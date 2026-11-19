// Renders every deck sheet (and its back) to PNG and writes manifest.json, which tells the table script
// which card sits in which cell of which sheet.  node sheets.js OUTDIR
const fs = require('fs'), path = require('path');
const { chromium } = require('playwright');
const C = require('./cards.js'), E = C.E;
const OUT = process.argv[2] || '/home/claude/tts/build/img';
fs.mkdirSync(OUT, { recursive: true });
const font = (fam, file) => `@font-face{font-family:"${fam}";src:url(data:font/woff2;base64,${fs.readFileSync(path.join(__dirname, 'node_modules/@fontsource', file)).toString('base64')}) format("woff2")}`;
const FONTS = [font('Alfa Slab One', 'alfa-slab-one/files/alfa-slab-one-latin-400-normal.woff2'), font('Bitter', 'bitter/files/bitter-latin-400-normal.woff2'),
  font('BitterB', 'bitter/files/bitter-latin-700-normal.woff2'), font('IBM Plex Sans', 'ibm-plex-sans/files/ibm-plex-sans-latin-400-normal.woff2'),
  font('PlexB', 'ibm-plex-sans/files/ibm-plex-sans-latin-600-normal.woff2'), font('Patrick Hand', 'patrick-hand/files/patrick-hand-latin-400-normal.woff2'),
  font('Special Elite', 'special-elite/files/special-elite-latin-400-normal.woff2')].join('\n');

const CSS = `${FONTS}
*{box-sizing:border-box;margin:0;padding:0}
body{background:#000}
.grid{display:inline-grid;gap:0}
.ic{display:inline-block;vertical-align:-.16em}.ic svg{width:100%;height:100%;display:block}
.chip{display:inline-flex;align-items:center;gap:6px;padding:4px 12px 4px 8px;border-radius:30px;background:rgba(255,255,255,.75);border:2px solid rgba(0,0,0,.18);font:700 30px/1 BitterB,Bitter,serif;color:#2b1a14;margin:3px}
.chip .ic{width:1.1em!important;height:1.1em!important}
.card{position:relative;overflow:hidden;font-family:"IBM Plex Sans",sans-serif;color:#2b1a14;display:flex;flex-direction:column;align-items:center;text-align:center}
.w4{width:400px;height:560px}.sq{width:400px;height:400px}.tk{width:200px;height:200px}
.card.back{justify-content:center;gap:14px;border:14px solid #2b1a14}
.bsign{font:56px/1 "Alfa Slab One",serif;color:#2b1a14;text-shadow:3px 3px 0 rgba(255,255,255,.5)}
.bsub{font:26px/1.2 "Patrick Hand",cursive;max-width:80%}
.back.lem{background:repeating-linear-gradient(45deg,#f4d03f 0 30px,#f6dc63 30px 60px)}
.back.cat{background:#efe6d2;border-color:#7a5d06}
.back.resb{background:radial-gradient(circle at 50% 40%,#3a7fd0,#173f72);color:#fff}.back.resb .bsign{color:#fff;text-shadow:none}
.back.infb{background:radial-gradient(circle,#8a5ddb,#3c1f78);color:#fff}.back.infb .bsign{color:#fff;text-shadow:none}
.back.memob{background:#e6ebf2;font-family:"Special Elite",monospace}.back.memob .bsign{font-family:"Special Elite",monospace}
.back.tileb{background:#d8cfb8}
/* ingredients */
.ing{background:linear-gradient(180deg,var(--fc) 0 22%,#fffaf0 22% 100%);border:12px solid var(--fc);padding:18px}
.ingtop{font:44px/1 "Alfa Slab One",serif;color:#fff;text-shadow:2px 2px 0 rgba(0,0,0,.25);height:70px}
.ingico{width:210px;height:210px;margin:40px 0 24px}.ingico svg{width:100%;height:100%}
.ingname{font:54px/1.05 "Patrick Hand",cursive}
.ingfoot{position:absolute;bottom:18px;font:20px/1 "IBM Plex Sans";color:#7b5a4e}
/* machines */
.mach{background:#fffaf0;border:12px solid #9a8f78;padding:14px 16px}
.mach.t0{border-color:#9a8f78}.mach.t1{border-color:#c9a227}.mach.t2{border-color:#4f9d5b}.mach.t3{border-color:#2f7fd6}.mach.t4{border-color:#7d4fd0}
.mtier{font:22px/1 PlexB,sans-serif;letter-spacing:.12em;text-transform:uppercase;color:#7b5a4e}
.mname{font:44px/1.05 BitterB,Bitter,serif;margin:10px 0 6px;min-height:92px;display:flex;align-items:center}
.mprice{position:absolute;top:10px;right:12px;display:flex;align-items:center;gap:4px;font:700 36px/1 BitterB,serif}
.mout{display:flex;flex-wrap:wrap;justify-content:center;align-items:center;gap:6px;margin:6px 0}
.mout .big{display:flex;align-items:center;gap:8px;font:700 70px/1 BitterB,serif}
.mnote{font:22px/1.2 "IBM Plex Sans";min-height:54px;padding:0 10px}
.mlab{margin-top:auto;font:20px/1 PlexB;letter-spacing:.1em;text-transform:uppercase;color:#7b5a4e}
.mstrip{display:flex;gap:10px;justify-content:center;align-items:center;margin:8px 0;padding:10px 18px;border:3px dashed #9a8f78;border-radius:12px;min-height:84px;font-size:26px}
.big2{width:60px!important;height:60px!important}
.mfoot{font:17px/1.2 "IBM Plex Sans";color:#7b5a4e;padding:0 6px}
/* research */
.res{background:linear-gradient(180deg,#e9f1fb,#fffaf0);border:12px solid #2f7fd6;padding:20px}
.res.t1{border-color:#6c9bd2}.res.t2{border-color:#2f7fd6}.res.t3{border-color:#1d4f97}.res.t4{border-color:#7d4fd0}
.res.win{background:radial-gradient(circle,#fff3b0,#f4c430);border-color:#7a5506}
.rtier{font:22px/1 PlexB;letter-spacing:.1em;text-transform:uppercase;color:#4c5d78}
.rname{font:40px/1.1 BitterB,serif;margin:14px 0;min-height:96px;display:flex;align-items:center}
.rrew{display:flex;flex-wrap:wrap;justify-content:center;align-items:center;gap:6px}
.stars{font:700 56px/1 BitterB,serif;color:#c08a00;text-shadow:2px 2px 0 #fff}
.rtext{font:24px/1.3 "IBM Plex Sans";margin-top:18px}
.rwin{font:48px/1 "Alfa Slab One",serif;margin:30px 0}
.rimp{margin-top:auto;font:22px/1.2 PlexB;color:#4c5d78;display:flex;align-items:center;gap:8px}
.rback{background:repeating-linear-gradient(135deg,#173f72 0 18px,#1d4a84 18px 36px);border:12px solid #0d2748;color:#fff;padding:22px;justify-content:space-between}
.rback.t1{background:repeating-linear-gradient(135deg,#3a6ea8 0 18px,#4479b4 18px 36px)}.rback.t4{background:repeating-linear-gradient(135deg,#4a2a8a 0 18px,#5532a0 18px 36px)}
.rback.t5{background:radial-gradient(circle,#c99a1a,#6e4f05);border-color:#3b2a02}
.rbt{font:36px/1.1 "Alfa Slab One",serif}
.rbcost{display:flex;flex-direction:column;gap:16px;align-items:center;width:100%}
.rshelf,.rwild{background:#fffaf0;color:#2b1a14;border-radius:14px;padding:12px;width:100%;display:flex;flex-wrap:wrap;justify-content:center;gap:10px;align-items:center}
.rshelf{border:4px dashed #2b1a14}.rshelf.none{opacity:.75}
.rsl{width:100%;font:22px/1 PlexB;text-transform:uppercase;letter-spacing:.06em}
.rc{display:inline-flex;align-items:center;gap:6px;font:700 46px/1 BitterB,serif}
.rbfoot{font:22px/1.2 "Patrick Hand",cursive}
/* advisors */
.adv{background:#fdfcf6;border:12px solid #2b1a14;padding:18px}
.atop{display:flex;justify-content:space-between;width:100%;font:22px/1 PlexB;letter-spacing:.1em;text-transform:uppercase;color:#7b5a4e}.atop em{color:#b3261e}
.aname{font:42px/1.05 BitterB,serif;margin:14px 0 4px}
.arole{font:22px/1.2 "Special Elite",monospace;color:#5a4a78}
.aprice{display:flex;align-items:center;gap:6px;margin:14px 0;font:700 38px/1 BitterB,serif}.acc{display:flex;gap:4px;align-items:center;margin-left:14px}
.ams{margin-left:12px;font:20px/1 PlexB;padding:6px 10px;border-radius:8px;background:#2b1a14;color:#fff}
.awho{font:24px/1.15 "Patrick Hand",cursive;color:#7b5a4e}
.atext{font:26px/1.3 "IBM Plex Sans";margin-top:16px}
.afoot{margin-top:auto;font:18px/1 "IBM Plex Sans";color:#7b5a4e}
/* influence */
.inf{background:linear-gradient(180deg,#efe6fb,#fdfcf6);border:12px solid #7d4fd0;padding:18px}
.itop{display:flex;justify-content:space-between;align-items:center;width:100%;font:22px/1 PlexB;letter-spacing:.1em;text-transform:uppercase;color:#3c1f78}
.iheat{display:flex;align-items:center;gap:6px;font:700 40px/1 BitterB,serif;color:#7d2210}
.iname{font:42px/1.05 BitterB,serif;margin:22px 0 14px;min-height:90px;display:flex;align-items:center}
.itext{font:27px/1.3 "IBM Plex Sans"}
.itarget{margin-top:auto;font:20px/1.2 PlexB;color:#3c1f78}
.ifoot{font:17px/1.2 "IBM Plex Sans";color:#7b5a4e;margin-top:8px}
/* memos */
.memo{background:#e6ebf2;border:12px solid #2c4a7c;padding:16px;font-family:"Special Elite",monospace;text-align:left;align-items:stretch}
.mm{font:18px/1 "Special Elite";letter-spacing:.08em;color:#4c5d78}
.mt{font:28px/1.1 BitterB,serif;margin:8px 0}
.mb{font:17px/1.25 "Special Elite",monospace;margin-bottom:8px}
.mo{padding-left:24px;display:flex;flex-direction:column;gap:6px;font:16px/1.2 "IBM Plex Sans"}
.mo li b{display:block;font:600 17px/1.15 PlexB}.mo .chip{font-size:16px;padding:2px 8px 2px 4px;margin:2px 2px 0 0;border-width:1px}.mo small{display:block;font-size:14px;color:#4c5d78}
/* tiles */
.tile{border:10px solid #2b1a14;padding:18px;justify-content:space-between}
.tile.ring{background:#fffaf0}.tile.world{background:#e3eef8}.tile.hot{background:radial-gradient(circle,#ffe2c4,#f7b26b)}.tile.rough{background:repeating-linear-gradient(45deg,#ddd6c6 0 16px,#cfc7b4 16px 32px)}
.tname{font:44px/1.05 BitterB,serif;margin-top:6px}
.tmark{display:flex;flex-direction:column;align-items:center;gap:4px;font:20px/1.15 "IBM Plex Sans"}.rug{font:30px/1 "Alfa Slab One",serif}
.tyield{display:flex;gap:16px}.ys{width:78px;height:78px;border-radius:50%;border:5px dashed #7a5506;background:rgba(255,241,184,.7);display:flex;align-items:center;justify-content:center;font:700 40px/1 BitterB,serif;color:#5a3d02}
.tfoot{font:18px/1 PlexB;text-transform:uppercase;letter-spacing:.1em;color:#7b5a4e;margin-top:-6px}
/* tokens */
.tok{border-radius:0;justify-content:center;padding:8px}
.tok.bonus{background:#fff1b8;border:8px solid #7a5506}.tkb{display:flex;align-items:center;gap:6px;font:700 46px/1 BitterB,serif}.tok small{font:18px/1 PlexB}
.tok.air{background:#dcecfb;border:8px solid #2c4a7c}.tka{font:70px/1 serif;color:#2c4a7c}.tok.air b{font:40px/1 "Alfa Slab One",serif}
.tok.stand{background:#fffaf0;border:8px solid var(--pc)}.tok.stand svg{width:130px;height:130px}
.tok.back2{background:#d8cfb8}
`;

const sheets = []; // manifest
async function sheet(page, name, cls, faces, cols, back, opts = {}) {
  const rows = Math.ceil(faces.length / cols);
  const html = `<!doctype html><meta charset="utf-8"><style>${CSS}</style><div class="grid" style="grid-template-columns:repeat(${cols},auto)">${faces.map(f => f.html.replace('class="card', `class="${cls} card`)).join('')}</div>`;
  await page.setContent(html, { waitUntil: 'load' }); await page.evaluate(() => document.fonts.ready);
  const el = await page.$('.grid'); const file = `${name}.png`;
  await el.screenshot({ path: path.join(OUT, file) });
  const entry = { name, file, cols, rows, keys: faces.map(f => f.key) };
  if (back) { // a single shared back, or a sheet of backs in the same grid
    if (Array.isArray(back)) {
      const bh = `<!doctype html><meta charset="utf-8"><style>${CSS}</style><div class="grid" style="grid-template-columns:repeat(${cols},auto)">${back.map(b => b.replace('class="card', `class="${cls} card`)).join('')}</div>`;
      await page.setContent(bh, { waitUntil: 'load' }); await page.evaluate(() => document.fonts.ready);
      await (await page.$('.grid')).screenshot({ path: path.join(OUT, `${name}-back.png`) }); entry.back = `${name}-back.png`; entry.uniqueBack = true;
    } else {
      await page.setContent(`<!doctype html><meta charset="utf-8"><style>${CSS}</style><div class="grid">${back.replace('class="card', `class="${cls} card`)}</div>`, { waitUntil: 'load' }); await page.evaluate(() => document.fonts.ready);
      await (await page.$('.grid')).screenshot({ path: path.join(OUT, `${name}-back.png`) }); entry.back = `${name}-back.png`;
    }
  }
  Object.assign(entry, opts); sheets.push(entry); console.log(name, faces.length, 'cards', cols + 'x' + rows);
}

(async () => {
  const b = await chromium.launch(); const page = await b.newPage({ deviceScaleFactor: 1, viewport: { width: 4400, height: 4000 } });
  // ingredients: one face per family and flavour
  const ings = []; for (const f of E.FAMS) for (const n of E.FLAVOR[f]) ings.push({ key: `ing:${f}:${n}`, html: C.ingFace(f, n) });
  await sheet(page, 'ingredients', 'w4', ings, 5, C.ingBack(), { kind: 'card' });
  const machs = [E.START, ...E.MACHINES].map(m => ({ key: `mach:${m.id}`, html: C.machFace(m) }));
  await sheet(page, 'machines', 'w4', machs, 7, C.machBack(), { kind: 'card' });
  const rd = E.researchDeck(), resAll = [...rd, E.WINCARD];
  const resFaces = [...resAll.map(c => ({ key: `res:${c.id}`, html: C.resFace(c) })), ...E.ADVISORS.map(a => ({ key: `adv:${a.id}`, html: C.advFace(a) }))];
  const resBacks = [...resAll.map(c => C.resBack(c)), ...E.ADVISORS.map(() => C.advBack())];
  await sheet(page, 'research', 'w4', resFaces, 10, resBacks, { kind: 'card' });
  const infs = []; for (const t in E.IDECK) for (const x of new Set(E.IDECK[t])) infs.push({ key: `inf:${t}:${x}`, html: C.infFace(t, x) });
  if (E.ICARD.leak) for (const x of [0, 1, 2]) if (!infs.some(i => i.key === `inf:leak:${x}`)) infs.push({ key: `inf:leak:${x}`, html: C.infFace('leak', x) });
  await sheet(page, 'influence', 'w4', infs, 8, C.infBack(), { kind: 'card' });
  await sheet(page, 'memos', 'w4', E.MEMOS.map(m => ({ key: `memo:${m.id}`, html: C.memoFace(m) })), 7, C.memoBack(), { kind: 'card' });
  const names = [...E.RING.flat(), ...E.WORLD, ...E.HOTN, ...E.ROUGHN];
  await sheet(page, 'tiles-a', 'sq', names.slice(0, 50).map(n => ({ key: `tile:${n}`, html: C.tileFace(n) })), 10, C.tileBack(), { kind: 'tile' });
  await sheet(page, 'tiles-b', 'sq', names.slice(50).map(n => ({ key: `tile:${n}`, html: C.tileFace(n) })), 10, C.tileBack(), { kind: 'tile' });
  const COLS = ['#d9483b', '#2e79d1', '#2f9e5b', '#c77b12'];
  const toks = [...E.BONUS.map((x, i) => ({ key: `bonus:${i}`, html: C.BON(x) })), ...['A', 'B', 'C'].map(r => ({ key: `air:${r}`, html: C.AIR(r) })), ...COLS.map((c, i) => ({ key: `stand:${i}`, html: C.STAND(c) }))];
  await sheet(page, 'tokens', 'tk', toks, 4, C.tokBack(), { kind: 'token' });
  fs.writeFileSync(path.join(OUT, '..', 'manifest.json'), JSON.stringify(sheets, null, 1));
  await b.close();
})();
