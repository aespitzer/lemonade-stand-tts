// Builds the Tabletop Simulator save: compiles the engine to Lua, writes the Global script (runtime, engine, data, table code)
// and the save file with hand zones for Red, Blue and Green.
//   node build.js [IMGBASE]
const fs = require('fs'), path = require('path'), { execFileSync } = require('child_process');
const ROOT = __dirname, OUT = path.join(ROOT, 'build');
const IMG = process.argv[2] || 'https://raw.githubusercontent.com/aespitzer/lemonade-stand-tts/main/img/v1/';
fs.mkdirSync(OUT, { recursive: true });

// 1. the engine, compiled
execFileSync('node', [path.join(ROOT, 'js2lua/compile.js'), '/home/claude/v2/engine.js', path.join(ROOT, 'js2lua/engine.lua'), 'return E'], { stdio: 'inherit' });

// 2. data as Lua
const lua = v => { // plain Lua tables (1-based lists)
  if (v === null || v === undefined) return 'nil';
  if (typeof v === 'boolean') return String(v);
  if (typeof v === 'number') return String(v);
  if (typeof v === 'string') return JSON.stringify(v);
  if (Array.isArray(v)) return '{' + v.map(lua).join(', ') + '}';
  return '{' + Object.entries(v).map(([k, x]) => `[${JSON.stringify(k)}] = ${lua(x)}`).join(', ') + '}';
};
const jsLua = v => { // values the engine reads: arrays 0-based with __n, objects with key order
  if (v === null || v === undefined) return 'nil';
  if (typeof v !== 'object') return lua(v);
  if (Array.isArray(v)) return v.length ? `__mkA({[0]=${v.map(jsLua).join(', ')}, __n=${v.length}})` : '__mkA({__n=0})';
  const ks = Object.keys(v); return `__mkO({${ks.map(k => `[${JSON.stringify(k)}]=${jsLua(v[k])}`).join(', ')}}, {${ks.map(k => JSON.stringify(k)).join(', ')}})`;
};
const manifest = JSON.parse(fs.readFileSync(path.join(OUT, 'manifest.json')));
const layout = JSON.parse(fs.readFileSync(path.join(OUT, 'layout.json')));
const champs = JSON.parse(fs.readFileSync('/home/claude/v2/bots/runs/imp-t3/champions.json')).slice(0, 3).map(c => c.gen);

const script = [
  '-- Sour Empire for Tabletop Simulator. Built by build.js; edit the sources, not this file.',
  `IMG = ${JSON.stringify(IMG)}`,
  `MANIFEST = ${lua(manifest)}`,
  `LAYOUT = ${lua(layout)}`,
  `TILEFILES = ${lua(JSON.parse(fs.readFileSync(path.join(OUT, 'tilefiles.json'))))}`,
  'do\n' + fs.readFileSync(path.join(ROOT, 'js2lua/runtime.lua'), 'utf8') + '\nend',
  `GENOMES = {${champs.map(jsLua).join(',\n')}}`,
  'function loadEngine()\n' + fs.readFileSync(path.join(ROOT, 'js2lua/engine.lua'), 'utf8') + '\nend',
  fs.readFileSync(path.join(ROOT, 'lua/table.lua'), 'utf8'),
].join('\n\n');
fs.writeFileSync(path.join(OUT, 'Global.lua'), script);

// 3. the save file
const hand = (guid, col, x, z, rot) => ({ GUID: guid, Name: 'HandTrigger', Transform: { posX: x, posY: 4.5, posZ: z, rotX: 0, rotY: rot, rotZ: 0, scaleX: 17, scaleY: 7, scaleZ: 4 },
  Nickname: '', Description: '', GMNotes: '', ColorDiffuse: { r: 1, g: 1, b: 1, a: 0 }, FogColor: col, Locked: true, Grid: false, Snap: false, Autoraise: true, Sticky: true, Tooltip: false });
const save = {
  SaveName: 'Sour Empire', EpochTime: Math.floor(Date.now() / 1000), Date: new Date().toISOString(), VersionNumber: 'v13.2', GameMode: 'Sour Empire', GameType: 'Game', GameComplexity: 'Medium Complexity',
  PlayingTime: [45, 90], PlayerCounts: [2, 3], Tags: ['Economic'], Gravity: 0.5, PlayArea: 1, Table: 'Table_None', Sky: 'Sky_Museum', Note: 'Sour Empire: press Set up the table.', TabStates: {},
  Grid: { Type: 0, Lines: false, Color: { r: 0, g: 0, b: 0 }, Opacity: 0.75, ThickLines: false, Snapping: false, Offset: false, BothSnapping: false, xSize: 2, ySize: 2, PosOffset: { x: 0, y: 1, z: 0 } },
  Hands: { Enable: true, DisableUnused: false, Hiding: 0 },
  ComponentTags: { labels: [] }, CameraStates: [], DecalPallet: [], LuaScript: script, LuaScriptState: '', XmlUI: '',
  ObjectStates: [hand('a1e001', 'Red', 0, -27, 0), hand('a1e002', 'Blue', -36, 0, 90), hand('a1e003', 'Green', 36, 0, 270)],
};
fs.writeFileSync(path.join(OUT, 'SourEmpire.json'), JSON.stringify(save, null, 1));
console.log('Global.lua', Math.round(script.length / 1024) + ' KB; SourEmpire.json written');
