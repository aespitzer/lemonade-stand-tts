// Renders Tabletop Simulator XML UI as HTML at its 1920x1080 reference size, to check the panel's layout.
// Supports the elements the table uses: Panel, VerticalLayout, HorizontalLayout, GridLayout, Text, Button, Dropdown/Option.
//   node xmlview.js scene.json out.png
const fs = require('fs'), { chromium } = require('playwright');
const scene = JSON.parse(fs.readFileSync(process.argv[2]));
const out = process.argv[3] || '/home/claude/tts/preview/ui.png';
const html = `<!doctype html><meta charset="utf-8"><style>
body{margin:0;width:1920px;height:1080px;background:#3b2a20 url(${'data:image/png;base64,' + fs.readFileSync(process.argv[4] || '/home/claude/tts/preview/view-seat.png').toString('base64')}) center/cover;position:relative;font-family:Arial,sans-serif;overflow:hidden}
.p{position:absolute;box-sizing:border-box;display:flex;flex-direction:column}
.v{display:flex;flex-direction:column;box-sizing:border-box;width:100%;height:100%}
.h{display:flex;flex-direction:row;box-sizing:border-box}
.g{display:grid;box-sizing:border-box}
.t{display:flex;align-items:center;box-sizing:border-box;white-space:normal}
.b{box-sizing:border-box;border:0;border-radius:3px;background:#fff;color:#000;display:flex;align-items:center;justify-content:center;text-align:center}
</style><div id="root"></div><script>
const xml = new DOMParser().parseFromString('<root>' + ${JSON.stringify(scene.xml)} + '</root>', 'text/xml');
const A = (e, k, d) => e.getAttribute(k) ?? d;
const col = c => { if (!c) return null; c = c.split('|')[0]; if (/^#[0-9a-f]{8}$/i.test(c)) { const a = parseInt(c.slice(7), 16) / 255; return 'rgba(' + [1, 3, 5].map(i => parseInt(c.slice(i, i + 2), 16)).join(',') + ',' + a.toFixed(2) + ')'; } return c; };
function pad(e) { const p = A(e, 'padding'); if (!p) return '0'; const v = p.split(' ').map(Number); return v.length === 1 ? v[0] + 'px' : v.length === 4 ? v[2] + 'px ' + v[1] + 'px ' + v[3] + 'px ' + v[0] + 'px' : p; }
function build(e, parentDir) {
  const t = e.tagName; let d;
  const pw = A(e, 'preferredWidth'), ph = A(e, 'preferredHeight');
  const size = el => { if (pw) { el.style.width = pw + 'px'; el.style.flex = '0 0 auto'; } if (ph) { el.style.height = ph + 'px'; el.style.flexShrink = 0; } };
  if (t === 'Panel') { d = document.createElement('div'); d.className = 'p'; const w = +A(e, 'width', 100), h = +A(e, 'height', 100); d.style.width = w + 'px'; d.style.height = h + 'px';
    d.style.background = col(A(e, 'color', '#ffffff')); const [ox, oy] = (A(e, 'offsetXY', '0 0')).split(' ').map(Number); const al = A(e, 'rectAlignment', 'MiddleCenter');
    const x = /Left/.test(al) ? 0 : /Right/.test(al) ? 1920 - w : (1920 - w) / 2, y = /Upper/.test(al) ? 0 : /Lower/.test(al) ? 1080 - h : (1080 - h) / 2;
    d.style.left = (x + ox) + 'px'; d.style.top = (y - oy) + 'px'; const vis = A(e, 'visibility'); if (vis) d.title = 'visible to ' + vis; }
  else if (t === 'VerticalLayout' || t === 'HorizontalLayout') { d = document.createElement('div'); d.className = t === 'VerticalLayout' ? 'v' : 'h'; d.style.padding = pad(e); d.style.gap = (A(e, 'spacing', 0)) + 'px';
    if (A(e, 'childForceExpandHeight', 'true') === 'true' && t === 'VerticalLayout') d.dataset.expand = 1; if (t === 'HorizontalLayout' && A(e, 'childForceExpandWidth', 'true') === 'true') d.dataset.expand = 1;
    const ca = A(e, 'childAlignment', ''); if (/Center/.test(ca)) d.style.alignItems = 'center'; size(d); }
  else if (t === 'GridLayout') { d = document.createElement('div'); d.className = 'g'; const [cw, ch] = A(e, 'cellSize', '100 100').split(' '); const [sx, sy] = A(e, 'spacing', '0 0').split(' ');
    d.style.gridTemplateColumns = 'repeat(auto-fill,' + cw + 'px)'; d.style.gridAutoRows = ch + 'px'; d.style.gap = sy + 'px ' + sx + 'px'; d.style.justifyContent = 'center'; size(d); }
  else if (t === 'Text') { d = document.createElement('div'); d.className = 't'; d.textContent = e.textContent; d.style.fontSize = A(e, 'fontSize', 14) + 'px'; d.style.color = col(A(e, 'color', '#323232'));
    if (A(e, 'fontStyle') === 'Bold') d.style.fontWeight = 700; const al = A(e, 'alignment', 'MiddleCenter'); d.style.justifyContent = /Left/.test(al) ? 'flex-start' : /Right/.test(al) ? 'flex-end' : 'center'; d.style.textAlign = /Left/.test(al) ? 'left' : 'center'; size(d); }
  else if (t === 'Button') { d = document.createElement('div'); d.className = 'b'; d.textContent = e.textContent; d.style.fontSize = A(e, 'fontSize', 14) + 'px'; const c = A(e, 'colors'); if (c) d.style.background = col(c); size(d); }
  else if (t === 'Dropdown') { d = document.createElement('select'); for (const o of e.children) { const op = document.createElement('option'); op.textContent = o.textContent; if (o.getAttribute('selected')) op.selected = true; d.appendChild(op); } size(d); }
  else { d = document.createElement('div'); }
  for (const c of e.children) if (t !== 'Dropdown') { const k = build(c, t); if (d.dataset.expand && !k.style.height && d.className === 'v') k.style.flex = '1 1 0'; if (d.dataset.expand && !k.style.width && d.className === 'h') k.style.flex = '1 1 0'; d.appendChild(k); }
  return d;
}
for (const e of xml.documentElement.children) document.getElementById('root').appendChild(build(e));
document.title = 'done';
</script>`;
(async () => {
  const b = await chromium.launch(); const p = await b.newPage({ viewport: { width: 1920, height: 1080 } });
  await p.setContent(html); await p.waitForFunction(() => document.title === 'done');
  await p.screenshot({ path: out }); await b.close(); console.log('wrote', out);
})();
