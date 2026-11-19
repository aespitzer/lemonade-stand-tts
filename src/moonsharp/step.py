import json, subprocess, sys
sys.path.insert(0, '/home/claude/tts/diff'); import lua_run
seats = [{'name':'A','bot':True,'spec':'gen'},{'name':'B','bot':True,'spec':'mfg'},{'name':'C','bot':True,'spec':'prd'}]; seed = 7
js = subprocess.run(['env','-i','PATH=/usr/bin:/usr/local/bin','node','-e',"""
let s=%d;Math.random=()=>{s=(s*16807)%%2147483647;return (s-1)/2147483646};
const E=require('/home/claude/v2/engine.js');const G=E.newGame(%s);const out=[JSON.stringify(G)];let k=0;while(G.winner===null&&k++<20000){const o=E.botStep(G);out.push(JSON.stringify(G));if(!o)break}
process.stdout.write(out.join('\\n'))""" % (seed, json.dumps(seats))],capture_output=True,text=True).stdout.split('\n')
open('/tmp/claude-0/hdr.lua','w').write('SEED = %d\nSEATS = %s\nMAXSTEP = 80\n' % (seed, lua_run.lua_lit(seats)))
ms = [l[2:] for l in subprocess.run(['mono','run.exe','../test/mock.lua','../build/Global.lua','/tmp/claude-0/hdr.lua','msstep.lua'],capture_output=True,text=True).stdout.split('\n') if l.startswith('@@')]
def clean(x):
    if isinstance(x,dict): return {k:clean(v) for k,v in x.items() if v is not None}
    if isinstance(x,list): return [clean(v) for v in x]
    return x
def diff(a, b, path=''):
    if type(a) != type(b): return [(path, a, b)]
    if isinstance(a, dict):
        out = []
        for k in set(a) | set(b): out += diff(a.get(k), b.get(k), path + '.' + k)
        return out
    if isinstance(a, list):
        if len(a) != len(b): return [(path + '.length', len(a), len(b))] + [d for i in range(min(len(a),len(b))) for d in diff(a[i], b[i], path + '[%d]' % i)][:3]
        return [d for i in range(len(a)) for d in diff(a[i], b[i], path + '[%d]' % i)]
    return [] if a == b else [(path, a, b)]
print(len(js), len(ms))
for i in range(min(len(js), len(ms))):
    a, b = clean(json.loads(js[i])), clean(json.loads(ms[i]))
    if a != b:
        print('first difference after step', i)
        for d in diff(a, b)[:12]: print('  ', d[0], 'JS', str(d[1])[:150], '| MS', str(d[2])[:150])
        if i > 0:
            la = clean(json.loads(js[i-1]))['log'][-3:]; print('  last log before:', [l['text'] for l in la])
        break
