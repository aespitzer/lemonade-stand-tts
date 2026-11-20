// Draws scene.json the way Tabletop Simulator lays it out, from above and from the Red seat, with the real images.
// The sizes of Tabletop Simulator's own pieces (chips, pawns, 3D text, buttons) are not documented; the
// values in BUILTIN are estimates and are printed on the image so they are not mistaken for measurements.
//   node preview.js scene.json out-prefix
const fs = require('fs'), path = require('path'), { chromium } = require('playwright');
const [scenePath, outPrefix] = [process.argv[2] || '/home/claude/tts/preview/scene.json', process.argv[3] || '/home/claude/tts/preview/view'];
const scene = JSON.parse(fs.readFileSync(scenePath));
const IMG = '/home/claude/tts/build/img/';
const imgs = {}; for (const o of scene.objects) { if (o.card) { imgs[o.card.face] = 1; imgs[o.card.back] = 1; } if (o.image) imgs[o.image] = 1; }
const data = Object.fromEntries(Object.keys(imgs).map(f => [f, 'data:image/png;base64,' + fs.readFileSync(IMG + f).toString('base64')]));
const html = `<!doctype html><meta charset="utf-8"><body style="margin:0;background:#222"><canvas id="c"></canvas><script>
const S = ${JSON.stringify(scene)}, IMGS = ${JSON.stringify(data)};
const BUILTIN = { Chip_10: 1.5, Chip_1000: 1.5, PlayerPawn: 1.1, Checker_white: 1.6, Counter: [2.2, 1.1], Infinite_Bag: 2.0, textUnit: 1 / 90, buttonUnit: 1 / 500 };
const W = 2400, H = 2000, PPU = 26, CX = W / 2, CY = H / 2 + 60;
const c = document.getElementById('c'); c.width = W; c.height = H; const g = c.getContext('2d');
const scr = (x, z) => [CX + x * PPU, CY - z * PPU];
const rad = d => d * Math.PI / 180;
// a flat piece: Unity turns about y; at turn 0 the image's top points to -z and its right to -x (seen from above)
function axes(ry) { const t = rad(ry); return { R: [-Math.cos(t), Math.sin(t)], U: [-Math.sin(t), -Math.cos(t)] }; }
function drawImg(im, sx0, sy0, sw, sh, x, z, wW, hW, R, U) {
  // map the image's unit square onto the world rectangle, then to screen (z flipped)
  const r = [R[0] * PPU, -R[1] * PPU], u = [U[0] * PPU, -U[1] * PPU], [px, py] = scr(x, z);
  g.save(); g.setTransform(r[0] * wW / sw, r[1] * wW / sw, -u[0] * hW / sh, -u[1] * hW / sh, px - r[0] * wW / 2 + u[0] * hW / 2, py - r[1] * wW / 2 + u[1] * hW / 2);
  g.drawImage(im, sx0, sy0, sw, sh, 0, 0, sw, sh); g.restore();
}
function label(text, x, z, R, U, hW, col, bg, wW) {
  const r = [R[0], -R[1]], u = [-U[0], U[1]], [px, py] = scr(x, z);
  g.save(); g.setTransform(r[0], r[1], u[0], u[1], px, py);
  if (bg) { g.fillStyle = bg; g.fillRect(-wW * PPU / 2, -hW * PPU / 2, wW * PPU, hW * PPU); }
  g.fillStyle = col; g.font = (hW * PPU * 0.7) + 'px sans-serif'; g.textAlign = 'center'; g.textBaseline = 'middle';
  String(text).split('\\n').forEach((l, i, a) => g.fillText(l, 0, (i - (a.length - 1) / 2) * hW * PPU * 0.9)); g.restore();
}
const load = f => new Promise(res => { const im = new Image(); im.onload = () => res(im); im.src = IMGS[f]; });
(async () => {
  const L = {}; for (const f in IMGS) L[f] = await load(f);
  g.fillStyle = '#3b2a20'; g.fillRect(0, 0, W, H);
  const order = o => (o.type === 'Custom_Tile' ? (o.notes.includes('felt') ? 0 : 1) : o.type.startsWith('Card') || o.type === 'Deck' ? 2 : 3) * 1000 + o.y;
  const list = S.objects.filter(o => !o.inHand).sort((a, b) => order(a) - order(b));
  const cw = S.card[0], ch = S.card[1];
  for (const o of list) {
    const { R, U } = axes(o.ry); const flip = Math.abs(((o.rz % 360) + 360) % 360 - 180) < 1;
    if (o.image) { const im = L[o.image]; const w = 2 * o.sx, h = 2 * o.sz * im.height / im.width; drawImg(im, 0, 0, im.width, im.height, o.x, o.z, w, h, R, U); continue; }
    if (o.card) { const k = o.card, f = flip ? (k.unique ? k.back : k.back) : k.face, im = L[f]; const cols = k.cols, rows = k.rows;
      let sw, sh, sx0, sy0; if (flip && !k.unique) { sw = im.width; sh = im.height; sx0 = 0; sy0 = 0; } else { sw = im.width / cols; sh = im.height / rows; sx0 = (k.cell % cols) * sw; sy0 = Math.floor(k.cell / cols) * sh; }
      const RR = flip ? [-R[0], -R[1]] : R;
      drawImg(im, sx0, sy0, sw, sh, o.x, o.z, cw * o.sx, ch * o.sz, RR, U);
      if (o.deckN) label(o.deckN + ' cards', o.x, o.z - ch * o.sz / 2 - 0.4, [1, 0], [0, 1], 0.6, '#fff');
      if (o.button) { const b = o.button, bw = b.w * BUILTIN.buttonUnit * b.scale[0] * o.sx, bh = b.h * BUILTIN.buttonUnit * b.scale[1] * o.sz;
        label(b.label, o.x, o.z, R, U, bh, '#2b1a14', 'rgba(244,208,63,.95)', bw); }
      continue; }
    if (o.type === '3DText') { const t = rad(o.ry); label(o.text, o.x, o.z, [Math.cos(t), -Math.sin(t)], [Math.sin(t), Math.cos(t)], o.fontSize * BUILTIN.textUnit, o.color ? 'rgb(' + o.color.map(v => v * 255).join(',') + ')' : '#2b1a14'); continue; }
    const d = (BUILTIN[o.type] || 1) * (Array.isArray(BUILTIN[o.type]) ? 1 : o.sx); const [px, py] = scr(o.x, o.z);
    g.fillStyle = o.color ? 'rgb(' + o.color.map(v => v * 255).join(',') + ')' : '#ccc'; g.strokeStyle = '#000'; g.lineWidth = 2;
    if (o.type === 'Counter') { g.fillRect(px - 1.1 * o.sx * PPU, py - 0.55 * o.sz * PPU, 2.2 * o.sx * PPU, 1.1 * o.sz * PPU); continue; }
    g.beginPath(); g.arc(px, py, d * PPU / 2, 0, 7); g.fill(); g.stroke();
    if (o.type === 'PlayerPawn') { g.beginPath(); g.arc(px, py, d * PPU / 4, 0, 7); g.fillStyle = 'rgba(255,255,255,.5)'; g.fill(); }
  }
  for (const h of S.hands) { const [px, py] = scr(h.x, h.z); g.save(); g.translate(px, py); g.rotate(-rad(h.ry)); g.strokeStyle = h.color; g.setLineDash([12, 8]); g.lineWidth = 3;
    g.strokeRect(-h.w * PPU / 2, -h.d * PPU / 2, h.w * PPU, h.d * PPU); g.fillStyle = h.color; g.font = '22px sans-serif'; g.fillText(h.color + ' hand', -h.w * PPU / 2 + 6, -h.d * PPU / 2 + 24); g.restore(); }
  g.fillStyle = '#fff'; g.font = '20px sans-serif';
  g.fillText('Preview from the stand-in. Card ' + cw.toFixed(2) + ' x ' + ch.toFixed(2) + ' units (estimate). Chips, pawns, 3D text and button sizes are estimates. ' + PPU + ' px per unit.', 20, 30);
  document.title = 'done';
})();
</script>`;
(async () => {
  const b = await chromium.launch(); const p = await b.newPage({ viewport: { width: 2400, height: 2000 } });
  await p.setContent(html); await p.waitForFunction(() => document.title === 'done', null, { timeout: 60000 });
  await p.screenshot({ path: outPrefix + '-top.png' });
  // the Red seat: tilt the table toward the viewer
  await p.evaluate(() => { document.body.style.perspective = '1500px'; const c = document.getElementById('c'); c.style.transformOrigin = '50% 85%'; c.style.transform = 'rotateX(52deg)'; });
  await p.screenshot({ path: outPrefix + '-seat.png' });
  await b.close(); console.log('wrote', outPrefix + '-top.png', outPrefix + '-seat.png');
})();
