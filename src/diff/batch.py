import json, sys, subprocess, random, time
sys.argv = [sys.argv[0]] + sys.argv[1:]
import lua_run
champs = json.load(open('/home/claude/v2/bots/runs/imp-t3/champions.json'))[:6]
specs = [('gen', 'grow'), ('gen', 'atk'), ('gen', 'def'), ('mfg', None), ('prd', None), ('dis', 'def'), ('dis', 'atk'), ('dis', 'grow')]
rnd = random.Random(1); res = {'match': 0, 'diverge': []}; t0 = time.time()
N = int(sys.argv[1]) if len(sys.argv) > 1 else 40
for g in range(N):
    n = 2 if g % 3 == 0 else 3; seats = []
    for i in range(n):
        if rnd.random() < 0.5: c = rnd.choice(champs); seats.append({'name': 'P%d' % i, 'bot': True, 'gen': c['gen']})
        else: s, ms = rnd.choice(specs); seats.append({'name': 'P%d' % i, 'bot': True, 'spec': s, **({'ms': ms} if ms else {})})
    seed = 1000 + g * 7919
    js = json.loads(subprocess.run(['env', '-i', 'PATH=/usr/bin:/usr/local/bin', 'REC=1', 'node', 'js_run.js', str(seed), json.dumps(seats)], capture_output=True, text=True).stdout)
    try: hs, G = lua_run.play(seed, seats)
    except Exception as e: res['diverge'].append((g, seed, 'LUA ERROR ' + str(e)[:300])); continue
    if hs == js['hashes']: res['match'] += 1
    else:
        bad = next((i for i in range(min(len(hs), len(js['hashes']))) if hs[i] != js['hashes'][i]), None)
        res['diverge'].append((g, seed, 'step %s of %d/%d' % (bad, len(js['hashes']), len(hs)), json.dumps(seats)[:80]))
print('games', N, 'match', res['match'], 'time %.0fs' % (time.time() - t0))
for d in res['diverge']: print(d)
