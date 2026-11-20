// Round pieces for the mats: coins (Capital) and loyalty tokens, in 1s and 5s. Transparent outside the circle.
const fs = require('fs'), path = require('path'), { chromium } = require('playwright');
const C = require('./cards.js');
const OUT = process.argv[2] || '/home/claude/tts/build/img';
const font = f => `@font-face{font-family:"BitterB";src:url(data:font/woff2;base64,${fs.readFileSync(path.join(__dirname, 'node_modules/@fontsource/bitter/files/bitter-latin-700-normal.woff2')).toString('base64')}) format("woff2")}`;
const piece = (bg, ring, ink, icon, n) => `<div style="width:256px;height:256px;border-radius:50%;background:radial-gradient(circle at 40% 35%,${bg[0]},${bg[1]});box-shadow:inset 0 0 0 14px ${ring},inset 0 0 0 20px rgba(255,255,255,.35);display:flex;flex-direction:column;align-items:center;justify-content:center;color:${ink};font:700 120px/1 BitterB,serif">
  <i style="width:54px;height:54px;display:block;margin-bottom:6px">${icon}</i><span style="font-size:96px;line-height:.85">${n}</span></div>`;
const items = {
  'coin-1': piece(['#ffe58a', '#e3ac1c'], '#9c6b05', '#5a3d02', C.ICON.cash, 1),
  'coin-5': piece(['#f2c25a', '#b5780a'], '#5e3c03', '#3a2401', C.ICON.cash, 5),
  'heart-1': piece(['#ffd1cb', '#e9776b'], '#8f2318', '#5e140d', C.ICON.loy, 1),
  'pitcher': `<div style="width:256px;height:256px;border-radius:50%;background:radial-gradient(circle at 40% 35%,#fffbe0,#f4d03f);box-shadow:inset 0 0 0 14px #7a5d06,inset 0 0 0 20px rgba(255,255,255,.4);display:flex;align-items:center;justify-content:center"><i style="width:150px;height:150px;display:block">${C.ICON.out}</i></div>`,
  'star': `<div style="width:256px;height:256px;border-radius:50%;background:radial-gradient(circle at 40% 35%,#fff6c9,#f2b81c);box-shadow:inset 0 0 0 14px #8a5a00,inset 0 0 0 20px rgba(255,255,255,.4);display:flex;align-items:center;justify-content:center"><i style="width:160px;height:160px;display:block">${C.ICON.st}</i></div>`,
  'control': `<div style="width:256px;height:256px;border-radius:50%;background:radial-gradient(circle at 40% 35%,#cfe9d8,#4f9a6d);box-shadow:inset 0 0 0 14px #1e4d33,inset 0 0 0 20px rgba(255,255,255,.35);display:flex;align-items:center;justify-content:center"><i style="width:150px;height:150px;display:block">${C.ICON.cont}</i></div>`,
  'heart-5': piece(['#f29a8f', '#c43b2e'], '#5e140d', '#ffffff', C.ICON.loy, 5),
};
(async () => {
  const b = await chromium.launch(); const p = await b.newPage({ viewport: { width: 400, height: 400 } });
  for (const [name, html] of Object.entries(items)) {
    await p.setContent(`<!doctype html><style>${font()}body{margin:0;background:transparent}</style><div id="r" style="display:inline-block">${html}</div>`); await p.evaluate(() => document.fonts.ready);
    await (await p.$('#r > div')).screenshot({ path: path.join(OUT, name + '.png'), omitBackground: true }); console.log(name);
  }
  await b.close();
})();
