"""Runs the Tabletop Simulator Global script against the mock API.
Plays full-rules games with a scripted human (clicking panel buttons and market buttons) against bots,
checks every panel is well-formed XML, saves and reloads mid-game, and exercises the arithmetic and log-only modes."""
import json, random, sys, re, xml.etree.ElementTree as ET
from lupa import lua52

ROOT = '/home/claude/tts/'
def new_runtime():
    L = lua52.LuaRuntime(unpack_returned_tuples=True)
    L.execute(open(ROOT + 'test/mock.lua', 'rb').read())
    def to_lua(v):
        if isinstance(v, dict): return L.table_from({k: to_lua(x) for k, x in v.items()})
        if isinstance(v, list): return L.table_from([to_lua(x) for x in v])
        return v
    L.globals().MOCK_DECODE = lambda s: to_lua(json.loads(s))
    L.execute(open(ROOT + 'build/Global.lua', 'rb').read())
    return L

def xml_ok(x):
    try: ET.fromstring('<root>' + x + '</root>'); return True
    except ET.ParseError as e: print('BAD XML', e, x[:500]); return False

def buttons(L):
    x = L.globals().MOCK.xml or ''
    return re.findall(r'id="a_([^"]+)"', x)

def tile_buttons(L):
    out = []
    for o in L.globals().getObjects().values():
        if o.buttons and len(o.buttons) and o.buttons[1].click_function == 'onCardClick': out.append(o)
    return out

def play(L, rnd, max_steps=4000, save_at=None):
    G = L.globals()
    steps = 0; bad_xml = 0; human_acts = 0; saves = 0
    while steps < max_steps:
        steps += 1
        waits = G.MOCK.waits; n = len(waits)
        if n:
            f = waits[1]; L.eval('table.remove')(waits, 1); f()
            continue
        S = G.S
        if S.G is None or S.G.winner is not None: break
        if not xml_ok(G.MOCK.xml): bad_xml += 1
        if save_at is not None and S.G.round >= save_at and saves == 0:
            return 'save'
        ids = buttons(L)
        tiles = tile_buttons(L)
        if not ids and not tiles: print('stuck: no actions; phase', S.G.phase); break
        human_acts += 1
        if tiles and rnd.random() < 0.85:
            o = rnd.choice(tiles); G.onCardClick(o, 'Red', False); continue
        prefer = [i for i in ids if re.match(r'(memo|pick|otake|opass|run|research|buy|draw|take|hire|scrap|tgt|dpick|dok|impmode|sell|frun|rerun)', i)]
        pool = prefer if prefer and rnd.random() < 0.8 else ids
        choice = rnd.choice(pool)
        G.uiAct(L.table_from({'color': 'Red'}), '', 'a_' + choice)
    return {'steps': steps, 'bad_xml': bad_xml, 'human_acts': human_acts, 'winner': G.S.G.winner if G.S.G else None, 'round': G.S.G.round if G.S.G else None, 'errors': list(G.MOCK.errors.values())}

def start(L, np, seats, mode='full'):
    G = L.globals()
    G.onLoad('')
    assert xml_ok(G.MOCK.xml), 'setup xml'
    G.uiSetup(L.table_from({'color': 'Red'}), '', 'np_%d' % np)
    G.uiSetup(L.table_from({'color': 'Red'}), '', 'mode_' + mode)
    G.uiSetup(L.table_from({'color': 'Red'}), '', 'anyone_no')
    for i, s in enumerate(seats): G.uiSeat(L.table_from({'color': 'Red'}), s, 'seat%d' % (i + 1))
    G.uiStart(L.table_from({'color': 'Red'}))

if __name__ == '__main__':
    results = []
    for g in range(int(sys.argv[1]) if len(sys.argv) > 1 else 4):
        rnd = random.Random(g)
        L = new_runtime(); L.execute('math.randomseed(%d)' % (g + 1))
        np = 2 if g % 2 else 3
        seats = ['Human'] + [rnd.choice(['Bot: champion', 'Bot: generalist', 'Bot: manufacturer', 'Bot: producer', 'Bot: distributor']) for _ in range(np - 1)]
        start(L, np, seats)
        r = play(L, rnd, save_at=3 if g == 0 else None)
        if r == 'save':
            before = L.eval('JS_JSON.stringify')(L.globals().S.G)
            state = L.globals().onSave()
            L2 = new_runtime(); L2.globals().onLoad(state)
            after = L2.eval('JS_JSON.stringify')(L2.globals().S.G)
            print('save/load: state', 'IDENTICAL' if before == after else 'DIFFERENT', len(state) // 1024, 'KB saved')
            if before != after:
                i = next(j for j in range(min(len(before), len(after))) if before[j] != after[j]); print(before[i-200:i+100]); print(after[i-200:i+100])
            L = L2; r = play(L, rnd)
        G = L.globals()
        rec = [t.body for t in G.MOCK.tabs.values()]
        lines = ''.join(rec).split('\n') if rec else []
        parsed = sum(1 for l in lines[1:] if l.strip() and json.loads(l) is not None)
        r.update({'np': np, 'seats': seats, 'record_lines': len(lines), 'parsed': parsed, 'objects': len(G.getObjects())})
        print(r)
        results.append(r)

    # the manual modes
    for mode in ['arith', 'log']:
        L = new_runtime(); G = L.globals()
        start(L, 3, ['Human', 'Human', 'Human'], mode)
        while len(G.MOCK.waits): f = G.MOCK.waits[1]; L.eval('table.remove')(G.MOCK.waits, 1); f()
        assert xml_ok(G.MOCK.xml)
        objs = list(G.getObjects().values())
        # move a loyalty chip from Red's bag onto a market and a machine to Red's floor, as a player would
        tile = next(o for o in objs if str(o.notes).startswith('se|tile:'))
        chip = G.spawnObjectData(L.table_from({'data': L.table_from({'Name': 'Chip_10', 'GMNotes': 'se|loy:Red', 'Transform': L.table_from({'posX': 0, 'posY': 2, 'posZ': 0})})}))
        G.onObjectPickUp('Red', chip); chip.pos.x = tile.pos.x; chip.pos.z = tile.pos.z; G.onObjectDrop('Red', chip)
        mkt = next(o for o in objs if str(o.notes) == 'se|c:mach:hands' or 'mach:' in str(o.notes))
        G.onObjectPickUp('Red', mkt); G.onObjectDrop('Red', mkt)
        if mode == 'arith':
            G.uiPayday(L.table_from({'color': 'Red'})); G.uiStipend(L.table_from({'color': 'Red'})); G.uiCosts(L.table_from({'color': 'Red'}))
            labels = [b.label for o in G.getObjects().values() if o.buttons for b in o.buttons.values()]
            print('token costs shown on', len(labels), 'markets, e.g.', labels[:6])
        G.uiSnap(L.table_from({'color': 'Red'})); G.uiRecord(L.table_from({'color': 'Red'}))
        body = ''.join(t.body for t in G.MOCK.tabs.values()); lines = body.split('\n')
        print(mode, 'record lines', len(lines), 'parse', all(json.loads(l) is not None for l in lines[1:] if l.strip()), 'errors', list(G.MOCK.errors.values()), [m for m in G.MOCK.msgs.values() if 'Payday' in m][:1])
