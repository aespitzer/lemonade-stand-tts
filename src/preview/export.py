"""Sets up a table in the stand-in for Tabletop Simulator and writes every object on it to scene.json,
for preview.html to draw. Usage: python3 export.py [players] [mode] [steps of play] [out.json]"""
import json, sys
sys.path.insert(0, '/home/claude/tts/test')
import run_table as T  # reuses the runtime loader and the scripted human

np_ = int(sys.argv[1]) if len(sys.argv) > 1 else 3
mode = sys.argv[2] if len(sys.argv) > 2 else 'full'
steps = int(sys.argv[3]) if len(sys.argv) > 3 else 0
out = sys.argv[4] if len(sys.argv) > 4 else '/home/claude/tts/preview/scene.json'
L = T.new_runtime(); G = L.globals()
seats = ['Human'] + ['Bot: champion'] * (np_ - 1) if mode == 'full' else ['Human'] * np_
T.start(L, np_, seats, mode)
while len(G.MOCK.waits): f = G.MOCK.waits[1]; L.eval('table.remove')(G.MOCK.waits, 1); f()
if steps:
    import random; r = T.play(L, random.Random(3), max_steps=steps)
    while len(G.MOCK.waits): f = G.MOCK.waits[1]; L.eval('table.remove')(G.MOCK.waits, 1); f()
def lt(t): return {k: (lt(v) if L.eval('type')(v) == 'table' else v) for k, v in t.items()} if t is not None else None
objs = []
for o in G.getObjects().values():
    d = o.data; e = {'type': o.type, 'x': o.pos.x, 'y': o.pos.y, 'z': o.pos.z, 'rx': o.rot.x, 'ry': o.rot.y, 'rz': o.rot.z, 'sx': o.scale.x, 'sz': o.scale.z,
                     'notes': o.notes, 'inHand': o.inHand}
    if d.CardID is not None:
        cd = d.CustomDeck[int(d.CardID // 100)]
        e['card'] = {'face': cd.FaceURL.split('/')[-1], 'back': cd.BackURL.split('/')[-1], 'cols': cd.NumWidth, 'rows': cd.NumHeight, 'cell': int(d.CardID % 100), 'unique': bool(cd.UniqueBack)}
    if d.Name == 'Deck':
        top = d.ContainedObjects[len(d.ContainedObjects)]; cd = top.CustomDeck[int(top.CardID // 100)]
        e['card'] = {'face': cd.FaceURL.split('/')[-1], 'back': cd.BackURL.split('/')[-1], 'cols': cd.NumWidth, 'rows': cd.NumHeight, 'cell': int(top.CardID % 100), 'unique': bool(cd.UniqueBack)}
        e['deckN'] = len(d.ContainedObjects)
    if d.CustomImage is not None: e['image'] = d.CustomImage.ImageURL.split('/img/v2/')[-1].split('/img/v1/')[-1]
    if d.Name == '3DText': e['text'] = o.text; e['fontSize'] = d.Text.fontSize; c = d.Text.colorstate; e['color'] = [c.r, c.g, c.b] if c else None
    if d.ColorDiffuse is not None: e['color'] = [d.ColorDiffuse.r, d.ColorDiffuse.g, d.ColorDiffuse.b]
    if o.buttons and len(o.buttons): b = o.buttons[1]; e['button'] = {'label': b.label, 'w': b.width, 'h': b.height, 'font': b.font_size, 'scale': [b.scale[1], b.scale[3]] if b.scale else [1, 1], 'y': b.position[2], 'flip': bool(b.rotation and b.rotation[3] == 180)}
    objs.append(e)
hands = [{'color': h['FogColor'], 'x': h['Transform']['posX'], 'z': h['Transform']['posZ'], 'w': h['Transform']['scaleX'], 'd': h['Transform']['scaleZ'], 'ry': h['Transform']['rotY']} for h in json.load(open('/home/claude/tts/build/SourEmpire.json'))['ObjectStates']]
xml = G.MOCK.xml
json.dump({'objects': objs, 'hands': hands, 'xml': xml, 'card': [G.S.cardW, G.S.cardH]}, open(out, 'w'))
print(out, len(objs), 'objects;', sum(1 for o in objs if o.get('inHand')), 'in hands;', sum(1 for o in objs if o.get('button')), 'with buttons')
