import sys, json, hashlib, subprocess, lupa
from lupa import lua52
def lua_lit(v):  # a JSON value as a Lua expression in the runtime's format
    if v is None: return 'nil'
    if isinstance(v, bool): return 'true' if v else 'false'
    if isinstance(v, (int, float)): return repr(v)
    if isinstance(v, str): return json.dumps(v)
    if isinstance(v, list): return '__mkA({[0]=' + ', '.join(lua_lit(x) for x in v) + ', __n=%d})' % len(v) if v else '__mkA({__n=0})'
    return '__mkO({' + ', '.join('[%s]=%s' % (json.dumps(k), lua_lit(x)) for k, x in v.items()) + '}, {' + ', '.join(json.dumps(k) for k in v) + '})'
def make(seed):
    L = lua52.LuaRuntime(unpack_returned_tuples=True)
    L.execute(open('/home/claude/tts/js2lua/runtime.lua').read())
    L.execute('JS_process = { env = __mkO({REC="1"}, {"REC"}) }; JS_Date.now = function() return 0 end; local s = %d; JS_Math.random = function() s = (s * 16807) %% 2147483647; return (s - 1) / 2147483646 end' % seed)
    E = L.execute(open('/home/claude/tts/js2lua/engine.lua','rb').read())
    return L, E
def play(seed, seats, dump=-1):
    L, E = make(seed)
    G = L.eval('function(E, seats) return E.newGame(seats) end')(E, L.eval(lua_lit(seats)))
    enc = L.eval('JS_JSON.stringify')
    st = lambda: enc(G)
    hs = [hashlib.md5(st().encode('utf-8', 'surrogateescape')).hexdigest()]
    if dump == 0: return st()
    k = 0
    while G.winner is None and k < 20000:
        k += 1; ok = E.botStep(G)
        hs.append(hashlib.md5(st().encode('utf-8', 'surrogateescape')).hexdigest())
        if dump == len(hs) - 1: return st()
        if not ok: break
    return hs, G
if __name__ == '__main__':
    seed = int(sys.argv[1]); seats = json.loads(sys.argv[2])
    js = json.loads(subprocess.run(['env', '-i', 'PATH=/usr/bin:/usr/local/bin', 'REC=1', 'node', 'js_run.js', str(seed), sys.argv[2]], capture_output=True, text=True).stdout)
    hs, G = play(seed, seats)
    n = min(len(hs), len(js['hashes']))
    bad = next((i for i in range(n) if hs[i] != js['hashes'][i]), None)
    if bad is None and len(hs) == len(js['hashes']): print('MATCH steps', len(hs), 'winner', js['winner'], 'round', js['round'])
    else:
        bad = n if bad is None else bad
        print('DIVERGE at step', bad, 'of', len(js['hashes']), len(hs))
        a = subprocess.run(['env', '-i', 'PATH=/usr/bin:/usr/local/bin', 'REC=1', 'node', 'js_run.js', str(seed), sys.argv[2], str(bad)], capture_output=True, text=True).stdout.strip()
        b = play(seed, seats, bad)
        open('/tmp/claude-0/a.json', 'w').write(a); open('/tmp/claude-0/b.json', 'w').write(b)
        # show the first differing region
        i = next((j for j in range(min(len(a), len(b))) if a[j] != b[j]), min(len(a), len(b)))
        print('JS :', a[max(0, i - 300):i + 200]); print('LUA:', b[max(0, i - 300):i + 200])
