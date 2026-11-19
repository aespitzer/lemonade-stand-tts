import json, subprocess, random, sys, os
sys.path.insert(0, '/home/claude/tts/diff'); import lua_run
champs = json.load(open('/home/claude/v2/bots/runs/imp-t3/champions.json'))[:6]
specs = [('gen','grow'),('gen','atk'),('mfg',None),('prd',None),('dis','def'),('dis','atk')]
rnd = random.Random(7); ok = 0; N = int(sys.argv[1])
for g in range(N):
    n = 2 if g % 3 == 0 else 3; seats = []
    for i in range(n):
        if rnd.random() < 0.5: seats.append({'name':'P%d'%i,'bot':True,'gen':rnd.choice(champs)['gen']})
        else: s,ms = rnd.choice(specs); seats.append({'name':'P%d'%i,'bot':True,'spec':s})
    seed = 4000 + g * 7919
    js = subprocess.run(['env','-i','PATH=/usr/bin:/usr/local/bin','REC=1','node','-e',"""
let s=%d;Math.random=()=>{s=(s*16807)%%2147483647;return (s-1)/2147483646};Date.now=()=>0;
const E=require('/home/claude/v2/engine.js');const G=E.newGame(%s);let k=0;while(G.winner===null&&k++<20000)if(!E.botStep(G))break;
process.stdout.write(JSON.stringify(G))""" % (seed, json.dumps(seats))],capture_output=True,text=True).stdout
    open('/tmp/claude-0/hdr.lua','w').write('SEED = %d\nSEATS = %s\n' % (seed, lua_run.lua_lit(seats)))
    out = subprocess.run(['mono','run.exe','../test/mock.lua','../build/Global.lua','/tmp/claude-0/hdr.lua','msgame.lua'],capture_output=True,text=True).stdout
    lu = out.split('@@',1)[1].strip() if '@@' in out else 'ERROR ' + out[-300:]
    def clean(x):
        if isinstance(x,dict): return {k:clean(v) for k,v in x.items() if v is not None}
        if isinstance(x,list): return [clean(v) for v in x]
        return x
    a = json.dumps(clean(json.loads(js))); b = json.dumps(clean(json.loads(lu))) if not lu.startswith('ERROR') else lu
    if a == b: ok += 1
    else:
        i = next((j for j in range(min(len(a),len(b))) if a[j]!=b[j]), 0); print('game', g, 'DIFFERS at', i, '\n JS:', a[max(0,i-200):i+120], '\n MS:', b[max(0,i-200):i+120])
print('MoonSharp vs JavaScript:', ok, 'of', N, 'games identical')
