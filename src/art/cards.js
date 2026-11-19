// Card faces for Sour Empire in Tabletop Simulator. Every card is drawn from the engine's own data, so the
// printed text is the rule text. Each function returns the inner HTML of one card; sheets.js lays them out.
const E = require('/home/claude/v2/engine.js');
const esc = s => String(s).replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
const ROM = ['I', 'II', 'III', 'IV', 'V'];
const FCOL = { sweet: '#e2668f', sour: '#e8c12a', herb: '#4f9d5b', fizz: '#3f9bd8', any: '#8a8478' };

/* ---------- icons ---------- */
const PIT = '<svg viewBox="0 0 16 16"><path d="M3.5 2.5h8.2l-1 1.6v8.2a1.6 1.6 0 0 1-1.6 1.6H5.1a1.6 1.6 0 0 1-1.6-1.6z" fill="#f4d03f" stroke="#7a5d06" stroke-width="1.1" stroke-linejoin="round"/><path d="M10.7 5.2h1.4a1.6 1.6 0 0 1 1.6 1.6v1.3a1.6 1.6 0 0 1-1.6 1.6h-1.4" fill="none" stroke="#7a5d06" stroke-width="1.1"/><path d="M4.6 6.4h5.1" stroke="#fff6c2" stroke-width="1"/></svg>';
const ICON = {
  cash: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="6.6" fill="#e3ac1c" stroke="#7a5506" stroke-width="1.1"/><circle cx="8" cy="8" r="4.8" fill="none" stroke="#fff1b8" stroke-width=".7"/><text x="8" y="11.2" text-anchor="middle" font-size="8.5" font-weight="700" fill="#5a3d02" font-family="Bitter">$</text></svg>',
  loy: '<svg viewBox="0 0 16 16"><path d="M8 13.8S2 10 2 5.9A3 3 0 0 1 8 4.6a3 3 0 0 1 6 1.3C14 10 8 13.8 8 13.8z" fill="#d9483b" stroke="#7b1d14" stroke-width="1.1" stroke-linejoin="round"/></svg>',
  out: PIT,
  card: '<svg viewBox="0 0 16 16"><rect x="4.6" y="1.8" width="8" height="11" rx="1.4" fill="#fff" stroke="#5a4a78" stroke-width="1"/><rect x="2.8" y="3.4" width="8" height="11" rx="1.4" fill="#f4d03f" stroke="#5a4a78" stroke-width="1"/></svg>',
  inf: '<svg viewBox="0 0 16 16"><rect x="2.5" y="2" width="11" height="12" rx="1.6" fill="#7d4fd0" stroke="#3c1f78" stroke-width="1"/><path d="M8 4.5v4.6M8 11v.6" stroke="#fff" stroke-width="1.8" stroke-linecap="round"/></svg>',
  heat: '<svg viewBox="0 0 16 16"><path d="M8 1.5c.6 2.4 4.6 4.2 4.6 8.2A4.6 4.6 0 0 1 3.4 9.7c0-2 1.2-3 1.9-4 .2 1.3.9 2 1.6 2.2C6.6 5.4 7 3.4 8 1.5z" fill="#e4572e" stroke="#7d2210" stroke-width="1" stroke-linejoin="round"/></svg>',
  calm: '<svg viewBox="0 0 16 16"><path d="M8 1.5c.6 2.4 4.6 4.2 4.6 8.2A4.6 4.6 0 0 1 3.4 9.7c0-2 1.2-3 1.9-4 .2 1.3.9 2 1.6 2.2C6.6 5.4 7 3.4 8 1.5z" fill="#8fb8d8" stroke="#2c4a7c" stroke-width="1"/><path d="M5 10h6" stroke="#14233b" stroke-width="1.8"/></svg>',
  cont: '<svg viewBox="0 0 16 16"><rect x="2.5" y="2.5" width="11" height="11" rx="2" fill="#1f6a4a" stroke="#0b3322" stroke-width="1"/><circle cx="8" cy="8" r="2.6" fill="#bfe8cf"/></svg>',
  rerun: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="6.6" fill="#2b1a14"/><path d="M11.3 6.2A3.6 3.6 0 1 0 11.6 9" fill="none" stroke="#fff" stroke-width="1.5"/><path d="M11.8 3.6v3h-3" fill="none" stroke="#fff" stroke-width="1.5"/></svg>',
  free: '<svg viewBox="0 0 16 16"><rect x="1.8" y="4" width="12.4" height="8" rx="1.2" fill="#2f7fd6" stroke="#14233b" stroke-width="1"/><text x="8" y="10.4" text-anchor="middle" font-size="5.6" font-weight="700" fill="#fff" font-family="IBM Plex Sans">RUN</text></svg>',
  st: '<svg viewBox="0 0 16 16"><path d="M8 1.6l1.9 4.1 4.5.5-3.4 3 1 4.4L8 11.3l-4 2.3 1-4.4-3.4-3 4.5-.5z" fill="#f4c430" stroke="#7a5506" stroke-width="1" stroke-linejoin="round"/></svg>',
};
const FAMI = {
  sweet: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="7" fill="#e2668f" stroke="#7d1f40" stroke-width="1"/><rect x="5" y="5" width="6" height="6" rx="1" fill="#fff" opacity=".92"/><path d="M5 8h6M8 5v6" stroke="#f3b6c9" stroke-width=".6"/></svg>',
  sour: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="7" fill="#e8c12a" stroke="#7a5d06" stroke-width="1"/><ellipse cx="8" cy="8" rx="4.4" ry="3.1" fill="#fff6c2"/><path d="M8 5.2v5.6M5.3 6.4l5.4 3.2M5.3 9.6l5.4-3.2" stroke="#e8c12a" stroke-width=".6"/></svg>',
  herb: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="7" fill="#4f9d5b" stroke="#1e4d26" stroke-width="1"/><path d="M4.4 11.6C4.4 6.6 8 4.4 11.8 4.2c0 4.4-2.6 7.4-7.4 7.4z" fill="#e6f6e2"/><path d="M4.6 11.4L10 6.2" stroke="#4f9d5b" stroke-width=".7"/></svg>',
  fizz: '<svg viewBox="0 0 16 16"><circle cx="8" cy="8" r="7" fill="#3f9bd8" stroke="#14456b" stroke-width="1"/><circle cx="6.2" cy="10" r="2" fill="#fff"/><circle cx="9.8" cy="6.6" r="1.6" fill="#fff"/><circle cx="10.4" cy="10.6" r="1" fill="#fff"/><circle cx="6.6" cy="5.4" r=".8" fill="#fff"/></svg>',
  any: '<svg viewBox="0 0 16 16"><path d="M8 8V1a7 7 0 0 1 7 7z" fill="#3f9bd8"/><path d="M8 8h7a7 7 0 0 1-7 7z" fill="#e8c12a"/><path d="M8 8v7a7 7 0 0 1-7-7z" fill="#4f9d5b"/><path d="M8 8H1a7 7 0 0 1 7-7z" fill="#e2668f"/><circle cx="8" cy="8" r="7" fill="none" stroke="#3a332a" stroke-width="1"/></svg>',
};
const ic = (k, sz) => `<i class="ic" style="width:${sz || 1}em;height:${sz || 1}em">${ICON[k] || FAMI[k] || ''}</i>`;
const RN = { cash: 'Capital', loy: 'loyalty', out: 'pitchers', card: 'ingredient cards', inf: 'influence cards', calm: 'Heat lower', st: 'stars', heat: 'Heat', free: 'free machine runs', rerun: 're-runs', cont: 'control' };
const chips = (o, sign) => Object.keys(o || {}).filter(k => o[k]).map(k => `<span class="chip">${ic(k)}<b>${k === 'calm' ? '−' : (sign || '')}${o[k]}</b></span>`).join('');
const starTxt = st => (st > 2 ? Math.floor(st / 2) : '') + (st % 2 ? '½' : '') + '★';

/* ---------- the cards ---------- */
// ingredients: one face per family and flavour
const ingFace = (f, n) => `<div class="card ing" style="--fc:${FCOL[f]}"><div class="ingtop">${E.FNAME[f]}</div><div class="ingico">${FAMI[f]}</div><div class="ingname">${esc(n)}</div><div class="ingfoot">${E.ARROW ? '' : ''}Ingredient · ${E.FNAME[f]}</div></div>`;
const ingBack = () => `<div class="card back lem"><div class="bsign">Sour<br>Empire</div><div class="bsub">Ingredients</div></div>`;

const machFace = m => `<div class="card mach t${m.tier}"><div class="mtier">${m.tier ? 'Tier ' + ROM[m.tier - 1] : 'Starting machine'}</div><div class="mname">${esc(m.name)}</div>${m.price ? `<div class="mprice">${ic('cash', 1.2)}<b>${m.price}</b></div>` : ''}
  <div class="mout"><span class="big">${ic('out', 1.6)}<b>+${m.out}</b></span>${chips({ cash: m.xtra.cash, card: m.xtra.card, inf: m.xtra.inf }, '+')}${m.xtra.heat ? `<span class="chip">${ic('heat')}<b>+${m.xtra.heat}</b></span>` : ''}</div>
  ${m.note ? `<div class="mnote">${esc(m.note)}</div>` : '<div class="mnote"></div>'}
  <div class="mlab">Runs on</div><div class="mstrip">${m.inp.length ? m.inp.map(f => `<i class="ic big2">${FAMI[f]}</i>`).join('') : '<small>no cards</small>'}</div>
  <div class="mfoot">Scrapped, its ingredients join your shelf and count toward research for good.</div></div>`;
const machBack = () => `<div class="card back cat"><div class="bsign">The<br>Catalogue</div><div class="bsub">Machines</div></div>`;

// research: the face is the reward (seen once researched); the back is the tier and the cost (seen in the row)
const resFace = c => c.win ? `<div class="card res win"><div class="rtier">The bottom card</div><div class="rname">${esc(c.name)}</div><div class="rwin">Wins the game</div><div class="rtext">Research it with ${E.WINNEED} research cards already in hand and you win at once.</div></div>`
  : `<div class="card res t${c.tier}"><div class="rtier">Tier ${ROM[c.tier - 1]} · research</div><div class="rname">${esc(c.name)}</div><div class="rrew">${c.st ? `<span class="stars">${starTxt(c.st)}</span>` : ''}${chips(c.get, '+')}</div>
  <div class="rtext">${[c.st ? `${c.st === 1 ? 'Half a star' : c.st === 2 ? 'A whole star' : starTxt(c.st).replace('★', ' stars')} for your product.` : '', ...Object.keys(c.get).map(k => `+${c.get[k]} ${RN[k] || k}${k === 'out' ? ' on your era track' : ''}${k === 'rerun' || k === 'free' ? ' to keep' : ''}.`)].filter(Boolean).join(' ')}</div>
  <div class="rimp">${E.IMPR[c.tier - 1] ? `${ic('cash')} Earns ${E.IMPR[c.tier - 1]} capital token${E.IMPR[c.tier - 1] > 1 ? 's' : ''}` : 'Earns no capital token'}</div></div>`;
const resCost = c => { const named = E.FAMS.filter(f => c.cost[f]).map(f => `<span class="rc"><i class="ic big2">${FAMI[f]}</i><b>${c.cost[f]}</b></span>`).join('');
  return `${named ? `<div class="rshelf"><div class="rsl">Your shelf must hold</div>${named}</div>` : '<div class="rshelf none"><div class="rsl">No shelf needed</div></div>'}${c.cost.any ? `<div class="rwild"><div class="rsl">Then pay</div><span class="rc"><i class="ic big2">${FAMI.any}</i><b>${c.cost.any}</b></span><div class="rsl">cards of any kind</div></div>` : ''}`; };
const resBack = c => `<div class="card rback t${c.win ? 5 : c.tier}"><div class="rbt">${c.win ? 'The Secret Formula' : 'Tier ' + ROM[c.tier - 1] + ' experiment'}</div><div class="rbcost">${resCost(c)}</div><div class="rbfoot">${c.win ? 'Wins the game' : 'Result unknown until you run it'}</div></div>`;
const advFace = a => `<div class="card adv"><div class="atop"><span>Advisor</span>${a.era > 1 ? `<em>era ${a.era}+</em>` : ''}</div><div class="aname">${esc(a.name)}</div><div class="arole">${esc(a.role)}</div>
  <div class="aprice">${a.price ? `${ic('cash', 1.2)}<b>${a.price}</b>` : '<b>free</b>'}${a.cc ? `<span class="acc">${ic('cont', 1.1)}<b>${a.cc}</b></span>` : ''}${a.ms ? `<span class="ams">${({ def: 'Defense', atk: 'Attack', grow: 'Growth' })[a.ms]}</span>` : ''}</div>
  <div class="awho">${esc(a.who)}</div><div class="atext">${esc(a.text)}</div><div class="afoot">Takes one of your three floor slots</div></div>`;
const advBack = () => `<div class="card back resb"><div class="bsign">Research</div><div class="bsub">An advisor turns up</div></div>`;

const infFace = (t, x) => { const d = E.ICARD[t]; return `<div class="card inf"><div class="itop"><span>Influence</span><span class="iheat">${ic('heat', 1.3)}<b>${x}</b></span></div><div class="iname">${esc(d.name)}</div><div class="itext">${esc(d.text)}</div>
  <div class="itarget">${d.target === 'player' ? 'Target: a rival company' : d.target === 'cell' ? 'Target: a market' : d.target === 'rtile' ? "Target: a rival's research card" : d.target === 'tile' ? 'Target: a research card in the row' : 'No target'}${d.extra ? ` · discard ${d.extra} other influence card${d.extra > 1 ? 's' : ''}` : ''}</div>
  <div class="ifoot">Its Heat goes on the table when you draw it.</div></div>`; };
const infBack = () => `<div class="card back infb"><div class="bsign">Influence</div><div class="bsub">Favors, filings and dirty tricks</div></div>`;

const memoFace = m => { const fx = o => [o.cost ? chips(o.cost, '−') : '', o.gain ? chips(o.gain, '+') : '', o.risk ? `<span class="chip">${ic('heat')}<b>+?</b></span>` : ''].join('');
  return `<div class="card memo"><div class="mm">MEMORANDUM · ${m.id + 1}</div><div class="mt">Re: ${esc(m.title)}</div><div class="mb">${esc(m.body)}</div><ol class="mo">${m.opts.map(o => `<li><b>${esc(o.label)}</b><span>${fx(o)}</span>${o.note ? `<small>${esc(o.note)}</small>` : ''}</li>`).join('')}</ol></div>`; };
const memoBack = () => `<div class="card back memob"><div class="bsign">Memo</div><div class="bsub">Drawn when a company enters a new era</div></div>`;

// map tiles: what kind of market a name is decides its yields and marks
function tileKind(name) {
  const hot = E.HOTN.indexOf(name), rough = E.ROUGHN.includes(name), world = E.WORLD.includes(name);
  const inner = hot >= 0 || rough || world;
  const yields = E.IMPY.map(y => y + (inner ? E.IMPC : 0) + (hot >= 0 ? E.IMPC : 0));
  return { hot: hot >= 0 ? { out: name === 'Tokyo' ? 3 : 2 } : null, rough, inner, yields };
}
const tileFace = name => { const k = tileKind(name);
  return `<div class="card tile${k.hot ? ' hot' : k.rough ? ' rough' : k.inner ? ' world' : ' ring'}"><div class="tname">${esc(name)}</div>
  <div class="tmark">${k.hot ? `<span class="chip">${ic('out', 1.2)}<b>+${k.hot.out}</b></span><small>at payday, to whoever controls it</small>` : k.rough ? '<b class="rug">Rugged +2</b><small>loyalty to enter unless you control it</small>' : ''}</div>
  <div class="tyield">${k.yields.map(y => `<span class="ys"><b>${y}</b></span>`).join('')}</div><div class="tfoot">capital tokens</div></div>`; };
const tileBack = () => `<div class="card back tileb"><div class="bsign">Market</div></div>`;

// small tokens: bonuses on the map, air routes, stands
const BON = b => { const k = Object.keys(b)[0]; return `<div class="card tok bonus"><div class="tkb">${ic(k, 2.2)}<b>${k === 'calm' ? '−' : '+'}${b[k]}</b></div><small>first to arrive</small></div>`; };
const AIR = r => `<div class="card tok air"><div class="tka">✈</div><b>${r}</b><small>air route</small></div>`;
const STAND = col => `<div class="card tok stand" style="--pc:${col}"><svg viewBox="0 0 40 40"><path d="M6 18L20 7l14 11v15H6z" fill="var(--pc)" stroke="#2b1a14" stroke-width="2.4" stroke-linejoin="round"/><rect x="16" y="23" width="8" height="10" fill="#fff6c2" stroke="#2b1a14" stroke-width="2"/></svg><small>stand</small></div>`;
const tokBack = () => `<div class="card tok back2"></div>`;

module.exports = { E, ingFace, ingBack, machFace, machBack, resFace, resBack, advFace, advBack, infFace, infBack, memoFace, memoBack, tileFace, tileBack, tileKind, BON, AIR, STAND, tokBack, ICON, FAMI, ic, esc, FCOL, ROM };
