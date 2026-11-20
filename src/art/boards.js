// Boards for the table, drawn at 100 px per table unit, and layout.json: where every slot sits on each board
// (in board units from its top-left corner), which the table script uses to place the pieces.
//   node boards.js OUTDIR
const fs = require('fs'), path = require('path');
const { chromium } = require('playwright');
const C = require('./cards.js'), E = C.E;
const OUT = process.argv[2] || '/home/claude/tts/build/img';
const PX = 100;
const font = (fam, file) => `@font-face{font-family:"${fam}";src:url(data:font/woff2;base64,${fs.readFileSync(path.join(__dirname, 'node_modules/@fontsource', file)).toString('base64')}) format("woff2")}`;
const FONTS = [font('Alfa Slab One', 'alfa-slab-one/files/alfa-slab-one-latin-400-normal.woff2'), font('Bitter', 'bitter/files/bitter-latin-400-normal.woff2'),
  font('BitterB', 'bitter/files/bitter-latin-700-normal.woff2'), font('IBM Plex Sans', 'ibm-plex-sans/files/ibm-plex-sans-latin-400-normal.woff2'),
  font('PlexB', 'ibm-plex-sans/files/ibm-plex-sans-latin-600-normal.woff2'), font('Patrick Hand', 'patrick-hand/files/patrick-hand-latin-400-normal.woff2')].join('\n');
const CSS = `${FONTS}*{box-sizing:border-box;margin:0;padding:0}body{background:transparent}
.b{position:relative;overflow:hidden;font-family:"IBM Plex Sans",sans-serif;color:#2b1a14}
.slot{position:absolute;border:6px dashed rgba(43,26,20,.45);border-radius:18px;display:flex;align-items:flex-end;justify-content:center;padding-bottom:10px;font:22px/1.1 PlexB;letter-spacing:.06em;text-transform:uppercase;color:rgba(43,26,20,.55);text-align:center}
.lab{position:absolute;font:38px/1 "Alfa Slab One",serif;color:#2b1a14;letter-spacing:.02em}
.sm{position:absolute;font:24px/1.2 "IBM Plex Sans";color:#5a4a3a}
.box{position:absolute;border:4px solid #2b1a14;border-radius:10px;display:flex;align-items:center;justify-content:center;font:700 34px/1 BitterB,serif;background:rgba(255,255,255,.55)}
.box small{position:absolute;top:4px;left:6px;font:17px/1 PlexB;color:#7b5a4e}
.ic{display:inline-block;vertical-align:-.16em;width:1em;height:1em}.ic svg{width:100%;height:100%;display:block}
.box .ly{position:absolute;bottom:5px;right:8px;display:flex;align-items:center;gap:3px;font:700 21px/1 BitterB,serif;color:#b3261e}
`;
const L = {}; // layout: board -> { w, h, slots: {name: [cx, cy, w, h]} }
const u = v => v * PX;
function slotsHTML(slots, labels = {}) { return Object.entries(slots).map(([k, [cx, cy, w, h]]) => labels[k] === null ? '' : `<div class="slot" style="left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px">${labels[k] || ''}</div>`).join(''); }

/* ---------- the common board: counter, ingredients, research, advisors, influence, memos, rounds, Heat ---------- */
function commonBoard() {
  const W = 40, H = 13.2, CW = 2.6, CH = 3.5, s = {}, lab = {};
  const rowA = 2.45, rowB = 6.55;
  s.mdeck = [1.6, rowA, CW, CH]; lab.mdeck = 'Catalogue';
  for (let i = 0; i < E.MKT; i++) { s['mkt' + i] = [4.6 + i * 2.8, rowA, CW, CH]; lab['mkt' + i] = ''; }
  s.ideck = [17.4, rowA, CW, CH]; lab.ideck = 'Ingredients';
  E.FAMS.forEach((f, i) => { s['pile_' + f] = [20.4 + i * 2.8, rowA, CW, CH]; lab['pile_' + f] = E.FNAME[f]; });
  for (let i = 0; i < 3; i++) { s['choice' + i] = [32.4 + i * 2.8, rowA, CW, CH]; lab['choice' + i] = 'Turned over'; }
  s.rdeck = [1.6, rowB, CW, CH]; lab.rdeck = 'Research';
  for (let i = 0; i < E.RROW; i++) { s['rrow' + i] = [4.6 + i * 2.8, rowB, CW, CH]; lab['rrow' + i] = 'Research row'; }
  for (let i = 0; i < E.ABOARD; i++) { s['arow' + i] = [17.4 + i * 2.8, rowB, CW, CH]; lab['arow' + i] = 'Advisor'; }
  s.infdeck = [29.6, rowB, CW, CH]; lab.infdeck = 'Influence';
  s.infdisc = [32.4, rowB, CW, CH]; lab.infdisc = 'Played';
  s.memodeck = [35.2, rowB, CW, CH]; lab.memodeck = 'Memos';
  s.memoplay = [38.0, rowB, CW, CH]; lab.memoplay = 'Memo in play';
  for (let r = 1; r <= E.MAXROUND; r++) s['round' + r] = [1.6 + (r - 1) * 1.55, 9.75, 1.35, 1.2];
  for (let h = 0; h <= 8; h++) s['heat' + h] = [1.6 + h * 1.55, 12.0, 1.35, 1.2];
  s.status = [31.6, 11.75, 15.6, 2.2];
  L.common = { w: W, h: H, slots: s };
  const boxes = Object.entries(s).filter(([k]) => /^round|^heat/.test(k)).map(([k, [cx, cy, w, h]]) => `<div class="box" style="left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px">${k.replace(/\D/g, '')}${k.startsWith('heat') && +k.slice(4) ? '' : ''}</div>`).join('');
  const tolLabels = E.TOL.map((t, i) => `<div class="sm" style="left:${u(1.6 + t * 1.55 - 0.7)}px;top:${u(12.7)}px;width:${u(1.4)}px;text-align:center;font-size:17px;color:#b3261e">raid ${['I', 'II', 'III', 'IV'][i]}</div>`).join('');
  const html = `<div class="b" style="width:${u(W)}px;height:${u(H)}px;background:linear-gradient(#efe6d2,#e6d9bd);border:14px solid #2b1a14;border-radius:30px">
    <div class="lab" style="left:${u(3.4)}px;top:${u(0.08)}px;font-size:30px">THE COUNTER</div><div class="lab" style="left:${u(16.4)}px;top:${u(0.08)}px;font-size:30px">INGREDIENTS</div><div class="lab" style="left:${u(31.2)}px;top:${u(0.08)}px;font-size:30px">BUY THREE, KEEP ONE</div>
    ${slotsHTML(s, Object.fromEntries(Object.keys(s).filter(k => /^round|^heat|^status/.test(k)).map(k => [k, null]).concat(Object.entries(lab))))}
    <div class="lab" style="left:${u(0.5)}px;top:${u(8.55)}px;font-size:26px">ROUND</div><div class="lab" style="left:${u(0.5)}px;top:${u(10.8)}px;font-size:26px">HEAT</div>${boxes}${tolLabels}
    <div class="sm" style="left:${u(23.8)}px;top:${u(8.75)}px;width:${u(15.8)}px;font-size:20px">Each round: the market (one thing per turn, until everyone passes), then the map (place loyalty or capital tokens), then payday. The first company to era 12, or to research the Secret Formula, wins.</div>
  </div>`;
  return { name: 'board-common', html, w: W, h: H };
}

/* ---------- the map frame, one per board size ---------- */
function mapBoard(n) {
  const S = E.MSIZE[n], CELL = 3.0, M = 0.6, W = S * CELL + 2 * M, s = {};
  for (let r = 0; r < S; r++) for (let c = 0; c < S; c++) s[`c${c}r${r}`] = [M + c * CELL + CELL / 2, M + r * CELL + CELL / 2, 2.9, 2.9];
  L['map' + n] = { w: W, h: W, slots: s, cell: CELL };
  const html = `<div class="b" style="width:${u(W)}px;height:${u(W)}px;background:#2a5a4f;border:12px solid #10302a;border-radius:24px">${Object.values(s).map(([cx, cy, w, h]) => `<div style="position:absolute;left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px;border:4px solid rgba(255,255,255,.18);border-radius:10px"></div>`).join('')}</div>`;
  return { name: 'board-map' + n, html, w: W, h: W };
}

/* ---------- a company's mat ---------- */
function mat(color, ci) {
  const W = 30, H = 9.6, s = {};
  for (let e = 1; e <= 12; e++) s['era' + e] = [7.0 + (e - 1) * 1.85, 1.15, 1.7, 1.45];
  for (let k = 0; k < E.TX; k++) s['trk' + k] = [6.6 + k * 1.42, 3.05, 1.3, 1.3];
  for (let i = 0; i < E.SLOTS; i++) s['floor' + i] = [7.6 + i * 2.85, 6.25, 2.6, 3.5];
  s.shelf = [19.3, 6.25, 7.2, 3.5]; s.tiles = [26.3, 6.25, 6.4, 3.5];
  s.name = [3.0, 0.9, 5.4, 1.2]; s.cash = [1.6, 2.9, 2.6, 1.6]; s.loy = [4.4, 2.9, 2.6, 1.6];
  s.stars = [1.6, 4.85, 2.6, 1.6]; s.imp = [4.4, 4.85, 2.6, 1.6]; s.hand = [1.6, 6.8, 2.6, 1.6]; s.inf = [4.4, 6.8, 2.6, 1.6]; s.note = [3.0, 8.6, 5.4, 1.4];
  L.mat = { w: W, h: H, slots: s };
  const bands = E.BANDS.map((b, i) => `<div class="sm" style="left:${u(7.0 + (b.from - 1) * 1.85 - 0.85)}px;top:${u(0.0)}px;font:18px/1 PlexB;letter-spacing:.06em;text-transform:uppercase">${b.name}</div>`).join('');
  const eras = Array.from({ length: 12 }, (_, i) => { const [cx, cy, w, h] = s['era' + (i + 1)]; return `<div class="box" style="left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px;padding-bottom:22px">${i + 1}<span class="ly">${C.ic('loy', 1)}+${E.LOYE[i]}</span></div>`; }).join('');
  const trk = Array.from({ length: E.TX }, (_, k) => { const [cx, cy, w, h] = s['trk' + k]; return `<div class="box" style="left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px;font-size:24px;color:#7b5a4e">${k + 1}</div>`; }).join('');
  const stat = (k, t) => { const [cx, cy, w, h] = s[k]; return `<div class="box" style="left:${u(cx - w / 2)}px;top:${u(cy - h / 2)}px;width:${u(w)}px;height:${u(h)}px"><small>${t}</small></div>`; };
  const html = `<div class="b" style="width:${u(W)}px;height:${u(H)}px;background:linear-gradient(#fdfaf1,#efe6d2);border:16px solid ${color};border-radius:30px">
    ${bands}${eras}<div class="sm" style="left:${u(4.1)}px;top:${u(0.62)}px;width:${u(1.95)}px;font:16px/1.15 PlexB;text-align:right;color:#b3261e">${C.ic('loy', 1)} loyalty each round</div><div class="sm" style="left:${u(0.4)}px;top:${u(1.9)}px;font:20px/1 PlexB">YOUR COMPANY</div>
    <div class="sm" style="left:${u(6.0)}px;top:${u(2.05)}px;font:18px/1 PlexB;text-transform:uppercase;letter-spacing:.06em">Era track: pitchers fill it; a full track moves you up an era. Whole stars and control tokens cover spaces from the right.</div>${trk}
    ${stat('cash', 'Capital')}${stat('loy', 'Loyalty')}${stat('stars', 'Stars')}${stat('imp', 'Capital tokens')}${stat('hand', 'Ingredients')}${stat('inf', 'Influence')}
    ${slotsHTML({ floor0: s.floor0, floor1: s.floor1, floor2: s.floor2, shelf: s.shelf, tiles: s.tiles }, { floor0: 'Floor', floor1: 'Floor', floor2: 'Floor', shelf: 'Shelf: scrapped machines count toward research', tiles: 'Research cards' })}
    <div class="sm" style="left:${u(6.3)}px;top:${u(4.15)}px;font:18px/1 PlexB;text-transform:uppercase;letter-spacing:.06em">Your floor: machines and advisors share three slots</div>
  </div>`;
  return { name: 'mat-' + ci, html, w: W, h: H };
}
function felt() { return { name: 'felt', html: `<div class="b" style="width:1950px;height:1650px;background:radial-gradient(ellipse at 50% 45%,#1f5a50,#123a33 70%,#0c2924)"></div>`, w: 78, h: 66 }; }

(async () => {
  const b = await chromium.launch(); const page = await b.newPage({ viewport: { width: 4400, height: 4000 } });
  const COLS = ['#d9483b', '#2e79d1', '#2f9e5b', '#c77b12'];
  const items = [commonBoard(), mapBoard(2), mapBoard(3), ...COLS.map((c, i) => mat(c, i)), felt()];
  for (const it of items) {
    await page.setContent(`<!doctype html><meta charset="utf-8"><style>${CSS}</style><div id="root" style="display:inline-block">${it.html}</div>`, { waitUntil: 'load' }); await page.evaluate(() => document.fonts.ready);
    const el = await page.$('#root > .b'); await el.screenshot({ path: path.join(OUT, it.name + '.png') });
    (L.files = L.files || {})[it.name] = { file: it.name + '.png', w: it.w, h: it.h };
    console.log(it.name, it.w + 'x' + it.h);
  }
  // the shared board and the mats are drawn at 100 px a unit but laid on the table 30% larger, so cards there read well
  const F = 1.3, grow = b => { b.w *= F; b.h *= F; for (const k in b.slots) b.slots[k] = b.slots[k].map(v => +(v * F).toFixed(3)); };
  grow(L.common); grow(L.mat);
  for (const k of ['board-common', 'mat-0', 'mat-1', 'mat-2', 'mat-3']) { L.files[k].w *= F; L.files[k].h *= F; }
  fs.writeFileSync(path.join(OUT, '..', 'layout.json'), JSON.stringify(L, null, 1));
  await b.close();
})();
