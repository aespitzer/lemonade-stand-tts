/* Sour Empire, second edition: one economy.
   Capital buys ingredient cards. Cards run machines (output) or research the mat (stars).
   Stars set how many pitchers of output buy one loyalty. Loyalty becomes tokens on the map.
   Markets you control pay Capital at payday. Breaking your own record draws a memo. */
const E = (() => {
  const ENV = (typeof process !== 'undefined' && process.env) || {};
  const num = (k, d) => ENV[k] !== undefined ? +ENV[k] : d;
  const arr = (k, d) => String(ENV[k] || d).split(',').map(Number);

  /* ---------- ingredients ---------- */
  const FAMS = ['sweet', 'sour', 'herb', 'fizz'];
  const FNAME = { sweet: 'Sweet', sour: 'Acidic', herb: 'Botanical', fizz: 'Effervescent' };
  const FDIR = { sweet: [0, -1], sour: [0, 1], herb: [-1, 0], fizz: [1, 0] }; // on the research mat: up, down, left, right
  const ARROW = { sweet: '↑', sour: '↓', herb: '←', fizz: '→' };
  const FLAVOR = { sweet: ['Strawberry', 'Cane sugar', 'Honey', 'Peach', 'Watermelon'], sour: ['Lemon', 'Lime', 'Grapefruit', 'Yuzu', 'Tamarind'], herb: ['Lavender', 'Mint', 'Basil', 'Hibiscus', 'Rosemary'], fizz: ['Soda water', 'Ginger', 'Tonic', 'Seltzer', 'Kombucha'] };
  const PILE1 = num('PILE1', 1), PERFAM = num('PF', 15), DRAW = num('DRAW', 2), TAKE = num('TAKE', 1), KEEP = num('KEEP', 1); // buy three, keep one; piles sell one card at a time

  /* ---------- economy ---------- */
  const MAXSTAR = 8, STARCASH = num('SC', 2); // stars run 1 to 5, counted in halves above the first
  // The era track: pitchers fill it, and a full track moves you up an era. Each whole star above the first takes a space off its length.
  const TX = num('TX', 16), ERAS = 12, OVER = num('OVER', 2);
  const LOYE = arr('LOYE', '1,2,3,3,4,4,5,5,6,6,7,7'); // loyalty at the start of every map phase, by era
  const XG = num('XG', 0), ONE = num('ONE', 0); // test switches: track growth per era, one era per round
  const CMAX = num('CMAX', 4), CC = num('CC', 1); // control tokens sit on the era track, one space each
  const trackLen = p => Math.max(3, TX + XG * (p.era - 1) - Math.floor(p.stars / 2) - (p.cont || 0)); // only whole stars cover a space: at most 4 above the first
  const INCB = num('INCB', 3), INCK = num('INCK', 1), SAULD = num('SAULD', 1);
  const income = k => INCB + INCK * k; // Capital at payday for k markets controlled
  // Capital tokens: research earns the right to improve a market you control. A market holds up to 3; each pays its printed
  // yield at payday to whoever controls the market, and they stay when the market changes hands.
  const IMPR = arr('IMPR', '0,1,1,2'), IMPY = arr('IMPY', '1,2,3'), IMPC = num('IMPC', 1), IMPON = num('IMPON', 1), RCHEAP = num('RCHEAP', 0);
  const yields = c => c.yield || [0, 0, 0];
  const cellYield = c => yields(c).slice(0, c.imp || 0).reduce((a, b) => a + b, 0); // what a market's capital tokens pay now
  const impIncome = (G, pi) => G.map.cells.reduce((a, c) => a + (ownerOf(c) === pi ? cellYield(c) : 0), 0);
  const CASH0 = num('CASH0', 6), LOY0 = num('LOY0', 3), TOKN = num('TOKN', 20), INFC = num('INFC', 2), BAILB = 4;
  const WIN = ENV.WIN || 'era'; // 'era': the first company to reach the top era wins. 'mono': the old monopoly filing
  const MSIZE = arr('MSZ', '0,5,5,6,7'), FM = num('FM', 11), FILECARDS = 3, MAXROUND = num('MAXR', 15), SLOTS = 3, MKT = 4;
  const BANDS = [
    { name: 'Lemonade Stand', title: 'Founder, age 9', coin: '$1', from: 0 },
    { name: 'Regional Enterprise', title: 'Managing Partner', coin: '$100', from: 3 },
    { name: 'National Brand', title: 'Chief Executive', coin: '$10,000', from: 5 },
    { name: 'Sovereign Interest', title: 'Chairman for Life', coin: '$1,000,000', from: 7 }];
  [1, 4, 7, 10].forEach((v, i) => BANDS[i].from = v); // eras 1-3, 4-6, 7-9, 10-12
  const TOL = arr('TOL', '2,3,5,8'); // the raid line, by the band of the highest era at the table
  const bandOf = era => { const rec = era; let b = 0; BANDS.forEach((x, i) => { if (rec >= x.from) b = i; }); return b; };

  /* ---------- machines: cards in, pitchers out ---------- */
  const M = (id, tier, name, price, inp, out, xtra, note) => ({ id, tier, name, price, inp, out, xtra: xtra || {}, note: note || '' });
  const START = M('hands', 0, 'Bare hands', 0, ['sour'], 2);
  // Machines scale in efficiency: better tiers make more pitchers per card, while most still eat one or two cards a run.
  // Bare hands and tier I machines also pay 1 Capital a run. Pitchers per card: bare hands 2, tier I about 3, tier II about 3.5, tier III about 4.5, tier IV about 5.5. Wildcard machines and machines that need no cards make one pitcher less a run.
  const MACHINES = [
    M('blender', 1, 'Kitchen blender', 4, ['any', 'any'], 4),
    M('juicer', 1, 'Hand juicer', 3, ['sour'], 3),
    M('sugarpot', 1, 'Sugar pot', 3, ['sweet'], 3),
    M('herbjar', 1, 'Herb jar', 3, ['herb'], 3),
    M('siphon', 1, 'Soda siphon', 3, ['fizz'], 3),
    M('squeezer', 1, 'Lemon squeezer', 5, ['sour', 'sour'], 6),
    M('icechest', 1, 'Ice chest', 4, ['any'], 1, { cash: 1 }),
    M('garage', 2, 'Garage line', 7, ['sour', 'sweet'], 7),
    M('muddler', 2, 'Mint muddler', 7, ['herb', 'sour'], 7),
    M('fizzrig', 2, 'Fizz rig', 7, ['fizz', 'sour'], 7),
    M('coldpress', 2, 'Cold press', 8, ['any', 'any'], 6),
    M('wagon', 2, 'Delivery wagon', 6, ['sour'], 2, { cash: 2 }),
    M('binder', 2, 'Recipe binder', 6, ['sweet'], 3, { card: 1 }),
    M('concentrate', 2, 'Frozen concentrate', 7, [], 2),
    M('bottling', 3, 'Bottling line', 11, ['sour', 'sweet'], 9),
    M('still', 3, 'Botanical still', 11, ['herb', 'sour'], 9),
    M('carbonator', 3, 'Carbonation plant', 11, ['fizz', 'sour'], 9),
    M('plant2', 3, 'Second plant', 12, ['any', 'any'], 7),
    M('franchise', 3, 'Franchise kit', 10, ['sweet', 'sour'], 8, { inf: 1 }),
    M('works', 3, 'Concentrate works', 10, ['sour'], 5),
    M('lightsout', 4, 'Lights-out factory', 16, ['sour', 'sweet'], 12),
    M('ftz', 4, 'Free-trade zone', 15, ['any', 'any'], 9),
    M('synthetic', 4, 'Synthetic flavor lab', 14, [], 5, { heat: 1 }, 'Every run adds 1 Heat to the table.'),
    M('global', 4, 'Global bottler', 17, ['sweet', 'herb', 'fizz'], 18),
    M('contract', 4, 'Contract manufacturer', 14, ['any'], 4, { cash: 2 }),
    M('skunk', 4, 'Skunkworks', 15, ['herb', 'fizz'], 11, { card: 1 })];
  const MP = arr('MP', '0,0,0,0,0'), MO = arr('MO', '0,0,0,0,0');
  MACHINES.forEach(m => { m.price += MP[m.tier]; m.out += MO[m.tier]; });
  const MCASH = num('MCASH', 1), MCT = num('MCT', 1); // test switch: machines up to tier MCT pay MCASH Capital a run
  if (MCASH) MACHINES.forEach(m => { if (m.tier >= 1 && m.tier <= MCT) m.xtra = { ...m.xtra, cash: (m.xtra.cash || 0) + MCASH }; });
  if (num('MCB', 1)) START.xtra = { cash: num('MCB', 1) }; // early machines pay Capital, so the first eras are not starved of cards
  const AP = num('AP', 0), NIP = num('NIP', 0); // pitchers lost per wildcard slot, and by no-input machines
  /* ---------- advisors: people who take a machine slot and bend one part of the loop ---------- */
  const A = (id, tag, price, name, role, who, text, o) => Object.assign({ id, tag, price, name, role, who, text, era: 1, cc: CC ? (price >= 6 ? 2 : 1) : 0 }, o || {}); // cc: control spent to hire
  const ADVISORS = [
    A('cfo', 'all', 6, 'Jordan Jekko', 'Chief Financial Officer', 'Thinks lunch is for wimps.', 'Your first buy-three each market costs 1 Capital less.'),
    A('tina', 'all', 7, 'Tina', 'Chief of Staff', 'Runs your calendar, and you.', 'Whenever you pass in the market, draw an ingredient card.'),
    A('swamp', 'dis', 8, 'Deep Swamp Creature', 'Lobbyist', 'Has resisted every attempt to drain it.', 'Draw an influence card when the market opens in every third round. Its Heat counts.'),
    A('saul', 'dis', 4, 'Your Lawyer, Saul', 'Special Counsel', 'Advertises on bus benches.', 'At every payday, +1 Capital for each Heat on the table.'),
    A('elle', 'dis', 2, 'Elle W.', 'General Counsel', "Got into Harvard Law. What, like it's hard?", 'While she is on anyone\'s floor, the raid line sits one band lower for the whole table.'),
    A('cop', 'dis', 2, 'A Mall Cop', 'Head of Security', 'Takes the job very seriously.', 'Rivals pay 1 more loyalty to place a token in a market you control.', { ms: 'def' }),
    A('chad', 'all', 0, 'Your Cousin, Chad', 'Vice President', 'Needed a job. Your aunt called.', 'Free to retain. +1 Capital at every payday.'),
    A('boogey', 'all', 6, 'The Boogeyman', 'Consultant', 'Was retired, briefly.', "Once a round, as your turn, make a rival's advisor disappear for good. +1 Heat each time.", { era: 7, price: 6 }),
    A('liz', 'prd', 6, 'Elizabeth H.', 'Chief Technology Officer', 'A slight r\u00e9sum\u00e9 gap.', 'Every research costs one wildcard card fewer. Every research adds 2 Heat.'),
    A('raman', 'prd', 3, 'Priya Raman', 'Head of R&D', 'Holds 40 patents, none for lemonade.', 'In every research, up to 2 named families your shelf lacks can be paid with cards instead.'),
    A('kevin', 'prd', 6, 'Kevin', 'Chief Innovation Officer', 'Has a podcast. You have been on it.', 'Every whole star you discover also pays 2 loyalty.'),
    A('grad', 'mfg', 7, 'A Recent Graduate', 'Plant Manager', 'Has read about the Toyota Production System.', 'One machine may run a second time each round.'),
    A('hal', 'mfg', 7, 'HAL 8000', 'Chief Automation Officer', 'An earlier, more indifferent model.', 'Once a round, run a machine without its cards. It makes 2 fewer pitchers.'),
    A('paul', 'mfg', 2, 'Your Neighbor, Paul', 'VP of Operations', 'Refers to lemons as "human money."', 'At every payday, +1 Capital for each Acidic card in your hand. You keep the cards.'),
    A('tanner', 'dis', 0, 'Tanner', 'Chief Marketing Officer', 'Refers to customers as "the audience."', 'Works on commission: free to retain. +1 loyalty every round. At every payday he takes half your income, rounded up.'),
    A('becky', 'dis', 3, 'Becky from the PTA', 'VP of Sales', 'Has already sold to your mother.', 'While you control your home market, it counts as two markets.', { ms: 'def' }),
    A('realtor', 'dis', 5, 'A Local Realtor', 'President, Global Markets', 'Describes every market as "up-and-coming."', 'Distance never costs more than 2 extra loyalty. Every token placed 3 or more steps out adds 1 Heat.', { ms: 'grow' }),
    A('dwarf', 'dis', 7, 'Brokk Stonebeard', 'Chief Mountain Officer', 'A dwarf. Has never once been asked to leave.', 'You pay no surcharge on rugged ground. At every payday, +2 Capital for each rugged market you control.', { ms: 'def' }),
    A('qa', 'dis', 8, 'Quality Assurance', 'Department of One', 'Checks every cup twice.', 'At every payday, +1 pitcher for each market holding 2 or more of your tokens, up to 4.', { ms: 'def' }),
    A('raider', 'dis', 3, 'A Corporate Raider', 'Head of Acquisitions', 'Wears suspenders without irony.', '+3 Capital each time you take a market that a rival controlled.', { ms: 'atk' }),
    A('lawyer2', 'dis', 2, 'A Litigator', 'Outside Counsel', 'Bills in six-minute increments.', 'When a contested market you lead is settled, you lose none of your tokens.', { ms: 'atk' }),
    A('pioneer', 'dis', 8, 'A Pioneer', 'Director of New Territories', 'Owns a covered wagon. It is a minivan.', '+1 Capital each time you place a token in an empty market.', { ms: 'grow' }),
    A('franchise', 'dis', 6, 'A Franchise Consultant', 'VP of Expansion', 'Has a binder for everything.', 'A market holding 2 of your tokens is an outpost, instead of 3.', { ms: 'grow' }),
    A('rhonda', 'dis', 7, 'Rhonda', 'Regional Sales Director', 'Has never once taken no for an answer.', 'Placing a token in a market a rival controls costs 2 loyalty less.', { ms: 'atk' })];
  const ROW = 3, POACH = num('POACH', 2), ADV = num('ADV', 1);
  const hasA = (p, id) => !!(p.adv && p.adv.some(a => a.id === id));
  const used = p => p.mach.length + (num('FREESLOT', 0) ? 0 : p.adv.length);
  MACHINES.forEach(m => { m.out -= AP * m.inp.filter(f => f === 'any').length + (m.inp.includes('any') ? num('AM', 0) : 0) + (m.inp.length ? 0 : NIP); m.out = Math.max(1, m.out); });

  /* ---------- the research mat: 5 by 5, star in the middle ---------- */
  const MAT = 5, MID = 2;
  const R = (st, get) => ({ st, get: get || {} });
  // one research deck, no rings: a few half stars, fewer whole stars, and small rewards on the rest
  const TS = arr('TS', '6,3'); // half-star tiles, whole-star tiles, out of 24
  const BLANK = [{ cash: 2 }, { card: 1 }, { out: 3 }, { cash: 3 }, { inf: 1 }, { calm: 2 }, { cash: 3 }, { card: 2 }, { out: 4 }, { cash: 2 }, { cash: 2 }, { card: 1 }, { out: 3 }, { cash: 3 }, { cash: 1 }, { card: 1 }, { out: 3 }, { cash: 2 }, { cash: 2 }, { card: 1 }, { cash: 2 }, { out: 2 }, { card: 1 }, { cash: 1 }]; // no loyalty: a random point of loyalty decided too many games
  const BLANK2 = [{ out: 3 }, { free: 1 }, { rerun: 1 }, { out: 4 }, { inf: 1 }, { free: 1 }, { out: 3 }, { rerun: 1 }, { calm: 2 }, { out: 4 }, { free: 1 }, { rerun: 1 }, { out: 3 }, { free: 1 }, { out: 2 }, { rerun: 1 }, { out: 3 }, { inf: 1 }, { free: 1 }, { out: 4 }, { rerun: 1 }, { out: 3 }, { free: 1 }, { calm: 2 }]; // pitchers, free runs, re-runs
  if (num('RRW', 1)) BLANK.splice(0, BLANK.length, ...BLANK2);
  /* ---------- the research deck: stacked in four tiers, cheap on top, the winning card at the bottom ---------- */
  // Every colour combination appears. Costs climb from one card to ten; rewards are weighted to cost.
  const PAIRS = [['sweet', 'sour'], ['sweet', 'herb'], ['sweet', 'fizz'], ['sour', 'herb'], ['sour', 'fizz'], ['herb', 'fizz']];
  const CONDS = { home5: 'you have at least 5 tokens on your home market', small5: 'you control fewer than 5 markets', deep3: 'at least 2 markets hold 2 or more of your tokens', nohot: 'you control no hot spot', noadv: 'you have no advisors' };
  const RNAME = { st1: 'A better recipe', st2: 'A breakthrough', st3: 'A signature formula', st4: 'A legendary formula', out: 'A production trick', free: 'An automation', rerun: 'A double shift', inf: 'A useful contact', bonus: 'A lab notebook' };
  const ANYC = num('ANYC', 1);
  function researchDeck() {
    // [total cost, named requirement, reward]. Named families are met by your shelf of scrapped machines, never paid in
    // cards; the rest of the total is wildcard, paid in cards. Tier I is all wildcard. No family is ever named more than twice.
    // Named families lean Acidic and Sweet, the families most machines eat.
    const T = [
      [1, [[1, {}, { get: { out: 3 } }], [1, {}, { get: { rerun: 1 } }], [2, {}, { st: 1 }], [2, {}, { st: 1 }], [2, {}, { get: { out: 5 } }], [2, {}, { get: { free: 1 } }], [2, {}, { get: { rerun: 1, out: 2 } }], [2, {}, { get: { out: 4 } }]]],
      [2, [[3, { sour: 1 }, { st: 1, get: { out: 2 } }], [3, { sweet: 1 }, { st: 1, get: { out: 2 } }], [3, { sour: 1 }, { get: { out: 8 } }], [4, { herb: 1 }, { st: 2 }], [4, { sour: 1 }, { st: 2 }], [4, { fizz: 1 }, { get: { free: 2 } }],
        [3, { sweet: 1 }, { st: 1, get: { out: 2 } }], [4, { sour: 1 }, { get: { free: 2 } }], [3, { herb: 1 }, { get: { rerun: 1, out: 3 } }]]],
      [3, [[5, { sour: 2 }, { st: 2, get: { out: 4 } }], [6, { sour: 1, sweet: 1 }, { st: 3 }], [5, { herb: 1, sour: 1 }, { get: { out: 15 } }], [6, { fizz: 1, sour: 1 }, { st: 1, get: { free: 2 } }],
        [5, { sweet: 2 }, { st: 2 }], [6, { herb: 1, fizz: 1 }, { st: 2, get: { out: 4 } }], [6, { sour: 1, sweet: 1 }, { st: 2, get: { rerun: 2 } }], [7, { sweet: 1, herb: 1 }, { st: 3, get: { out: 3 } }]]],
      [4, [[8, { sour: 2, sweet: 2 }, { st: 3, get: { out: 8 } }], [10, { sour: 2, herb: 2 }, { st: 4 }], [10, { sour: 2, fizz: 2 }, { st: 2, get: { free: 3 } }], [9, { sweet: 2, herb: 1 }, { st: 3, get: { free: 2 } }], [8, { fizz: 2, sweet: 1 }, { get: { out: 22, rerun: 1 } }]]]];
    const out = []; let id = 0; const keep = arr('RSIZE', '99,99,99,99');
    const NM = [['Ice in the pitcher', 'Two-handed stirring', 'A pinch of salt', 'Zest, not juice', 'A second pitcher', 'A timer on the stove', 'Your brother on the night shift', "Grandma's recipe"],
      ['Brown sugar', 'Mint from the garden', 'A bigger cooler', 'Cane sugar from Mexico', 'Meyer lemons', 'A hand-crank juicer', 'The family recipe box', 'Fermentation crocks', 'Doing it yourself'],
      ['Lavender lemonade', 'Pink lemonade', 'A bottling line', 'Cold-pressing', 'A small-batch philosophy', 'Aged in oak', 'Sparkling lemonade', 'Lemon-ginger tonic'],
      ['The perfect pour', 'The lemonade of legend', 'Full automation', 'Artisanal by design', 'A factory that never sleeps']];
    for (const [tier, cards] of T) for (const [j, [n, named, r]] of cards.slice(0, keep[tier - 1]).entries()) {
      const nn = Object.values(named).reduce((a, b) => a + b, 0), cost = { ...named }; if (n - nn - RCHEAP > 0) cost.any = n - nn - RCHEAP;
      const card = { kind: 'res', id: 'r' + id++, tier, cost, st: r.st || 0, get: { ...(r.get || {}) } };
      card.name = NM[tier - 1][j] || (r.st ? RNAME['st' + Math.min(4, r.st)] : RNAME[Object.keys(card.get)[0]] || 'Research');
      out.push(card); }
    return out;
  }
  const WINNEED = num('WINNEED', 5), RROW = 4, ABOARD = 4, PDISC = num('PDISC', 2);
  const WINCARD = { kind: 'res', id: 'rwin', tier: 5, win: true, cost: { sweet: num('WINC', 2), sour: num('WINC', 2), herb: num('WINC', 2), fizz: num('WINC', 2), any: num('WINW', 8) }, st: 0, get: {}, name: 'The Secret Formula' };
  const advTier = a => a.era > 1 ? 4 : a.price <= 2 ? 1 : a.price <= 4 ? 2 : a.price <= 6 ? 3 : 4; // cheap advisors come out early, the dangerous ones late
  function buildResearch(G) {
    const deck = researchDeck(), tiers = [1, 2, 3, 4].map(t => shuffle([...deck.filter(c => c.tier === t), ...(ADV ? ADVISORS.filter(a => advTier(a) === t).map(a => ({ ...a, kind: 'adv' })) : [])]));
    G.rdeck = [WINCARD && { ...WINCARD, cost: { ...WINCARD.cost } }, ...tiers[3], ...tiers[2], ...tiers[1], ...tiers[0]]; // pop() takes from the end: tier I first, the formula last
    G.rrow = [];
    for (let k = 0; k < RROW; k++) refillRow(G, k, null);
  }
  const TILESET = [...Array(TS[0]).fill(0).map(() => R(1)), ...Array(TS[1]).fill(0).map(() => R(2)), ...BLANK.slice(0, 24 - TS[0] - TS[1]).map(g => R(0, g))]; // st counts half stars

  /* ---------- influence: Heat is printed on each copy ---------- */
  const ICARD = {
    recall: { name: 'Product recall', text: 'A rival takes up to 5 pitchers off its era track.', target: 'player' },
    ha: { name: 'Hostile acquisition', text: 'Remove up to 2 rival tokens from one market.', target: 'cell' },
    judge: { name: 'A friendly judge', text: "Put the judge on call. The next time you would be raided, you are not: the table's Heat falls to 1 instead." },
    subsidy: { name: 'Subsidy', text: 'Gain 4 Capital.' },
    contract: { name: 'Government contract', text: 'Place one loyalty token from the bank in any market, at no cost to you.', target: 'cell' },
    spy: { name: 'Industrial espionage', text: "Take 2 ingredient cards at random from a rival's hand.", target: 'player' },
    reverse: { name: 'Reverse engineering', text: "Choose a research card in a rival's hand that nobody has copied. Collect its reward as well. The rival keeps the card.", target: 'rtile' },
    leak: { name: 'Kept memo', text: "Choose a research card in a rival's hand that nobody has copied. Collect its reward as well, then risk Heat as with a villainous option.", target: 'rtile', memo: true },
    patent: { name: 'Patent', text: 'Research a card in the row: this card counts as any one ingredient.', target: 'tile' },
    viral: { name: 'Viral campaign', text: 'Gain 3 loyalty.' },
    act: { name: 'Act of Congress', text: 'Discard 2 more cards. Remove 1 rival token from each of up to 3 markets next to ones you control.', extra: 2 },
    formula: { name: 'Stolen formula', text: 'Choose the company controlling the most markets, if that is more than you control. It loses half a star, and you gain it.', target: 'player', leader: true },
    antitrust: { name: 'Antitrust suit', text: 'Choose the company controlling the most markets, if that is more than you control. Remove 1 of its tokens from each of its 3 thinnest markets.', target: 'player', leader: true },
    proxy: { name: 'Proxy vote', text: 'Regain 2 control, up to 4.' },
    buyback: { name: 'Share buyback', text: 'Pay 4 Capital. Regain all your control, up to 4.' },
    regime: { name: 'Regime change', text: 'San Limón counts as one market you control at every payday, until someone else plays this.' }
  };
  const IDECK = { recall: [0, 0, 1, 1, 1, 2], ha: [0, 0, 0, 1, 1, 1, 1, 2], judge: [0, 0, 1], subsidy: [0, 0, 1, 1], contract: [0, 0, 1, 1], spy: [0, 1, 1], reverse: [0, 1, 1], patent: [0, 1, 1, 2], viral: [0, 1, 1], proxy: [0, 1, 1], buyback: [0, 1], act: [1, 2], regime: [1, 2], formula: arr('IFO', '0,1,1,2'), antitrust: arr('IAT', '1,1,2') };

  /* ---------- memos: an ordered deck, drawn when you break your own record ---------- */
  const MEMOS = [];
  const memo = (title, body, opts) => MEMOS.push({ id: MEMOS.length, title, body, opts });
  memo('Competitive entry', 'Tyler (8) has opened a competing stand directly across the street. His sign is better than yours.', [
    { label: 'Ignore him and focus on the core business', gain: { cash: 2 } },
    { label: 'Inform his mother of the sugar content', gain: { card: 2 }, note: 'He is grounded. His lemons are yours.' },
    { label: 'Tell the street his lemonade had a bug in it', gain: { cash: 3, loy: 2 }, risk: 1, note: 'It did, briefly.' },
    { label: "Keep this memo. Find out what is in Tyler's recipe later", keep: 'leak', note: 'Kept with your influence cards.' }]);
  memo('Regulatory inquiry', 'Mrs. Okafor at number 14 has asked whether you "have a permit for this."', [
    { label: 'Offer her a complimentary cup', gain: { loy: 2 } },
    { label: 'Read the municipal code', gain: { cash: 3 } },
    { label: 'Draw her a permit in crayon', gain: { cash: 5 }, risk: 1, note: 'It is very convincing.' },
    { label: "Keep this memo. Ask to see the other stands' permits later", keep: 'leak', note: 'Kept with your influence cards.' }]);
  memo('Staffing', 'Your little brother would like a job. He is six.', [
    { label: 'Hire him, paid in candy', gain: { out: 4 } },
    { label: 'Tell him to come back when he is seven', gain: { cash: 3 } },
    { label: 'Pay him in play money from the board game closet', gain: { out: 4, cash: 2 }, risk: 1, note: 'He will find out eventually.' },
    { label: 'Keep this memo. Send him to watch the other stands later', keep: 'leak', note: 'Kept with your influence cards.' }]);
  memo('Weather', 'The forecast calls for a heat wave. Everyone on the street will be thirsty.', [
    { label: 'Make extra and hope', gain: { out: 4 } },
    { label: 'Raise prices for the weekend', gain: { cash: 4 } },
    { label: "Turn off Tyler's garden hose", gain: { out: 4, cash: 3 }, risk: 1, note: 'He has a lot of explaining to do.' }]);
  memo('Formation', 'Your father says that if this continues you will need "an LLC or something."', [
    { label: 'File the paperwork', cost: { cash: 2 }, gain: { loy: 2, cont: 2 } },
    { label: 'Remain informal', gain: { cash: 4 } },
    { label: "Register the company in the dog's name", gain: { cash: 4, card: 2 }, risk: 1, note: 'Biscuit has excellent credit.' }]);
  memo('Inspection', 'The county health inspector has questions about the garage.', [
    { label: 'Bring the facility up to code', cost: { cash: 2 }, gain: { card: 3 } },
    { label: 'Learn what the inspector likes to drink', gain: { cash: 4 } },
    { label: 'Photograph the inspector at the racetrack', gain: { cash: 7 }, risk: 1, note: 'He has no further questions.' }]);
  memo('Press', 'The Gazette would like to profile "the lemonade kid."', [
    { label: 'Sit for the interview', gain: { loy: 3 } },
    { label: 'Decline and work the weekend', gain: { out: 6 } },
    { label: "Give the reporter a story about Tyler's stand", gain: { loy: 4, cash: 3 }, risk: 1, note: "Tyler's family moves to Ohio." }]);
  memo('Franchise inquiry', 'A girl two streets over would like to sell your lemonade under your name.', [
    { label: 'Grant her a franchise', gain: { loy: 4 } },
    { label: 'Charge her a fee', gain: { cash: 5 } },
    { label: 'Grant it, then open next to her', gain: { loy: 4, cash: 4 }, risk: 1, note: 'She is learning a valuable lesson.' }]);
  memo('Supply', 'A citrus wholesaler offers you terms.', [
    { label: 'Sign the contract', gain: { card: 4 } },
    { label: 'Negotiate a cash rebate', gain: { cash: 5 } },
    { label: 'Take delivery and lose the invoice', gain: { card: 5, cash: 3 }, risk: 1, note: 'Accounts payable is your brother.' }]);
  memo('Trademark', 'A pizza chain called Sour Empire has sent a letter.', [
    { label: 'Settle', cost: { cash: 3 }, gain: { loy: 3, cont: 1 } },
    { label: 'Rebrand the pizza chain', gain: { card: 4 } },
    { label: 'File first, backdate it', gain: { cash: 8 }, risk: 1, note: 'Your notary is very understanding.' }]);
  memo('Listing', 'Three banks have offered to take the company public. All three sent fruit baskets. None contained lemons.', [
    { label: 'Ring the bell', gain: { cash: 8 } },
    { label: 'Stay private', gain: { cont: 2, card: 1 } },
    { label: 'Ring the bell, and round the numbers up', gain: { cash: 11 }, risk: 1, note: 'The auditors are on a boat.' }]);
  memo('Bad batch', 'Customers report that the new formula tastes faintly of pennies.', [
    { label: 'Pull the batch', cost: { cash: 3 }, gain: { loy: 6 } },
    { label: 'Call it a limited edition', gain: { cash: 7 } },
    { label: 'Ship it to schools', gain: { cash: 10 }, risk: 1, note: 'Children do not write reviews.' }]);
  memo('Labor', 'Employees at the bottling plant are passing around a card.', [
    { label: 'Recognize the union', cost: { cash: 3 }, gain: { loy: 6 } },
    { label: 'Retain a firm that specializes in this', gain: { inf: 2 } },
    { label: 'Close the plant the night before the vote', gain: { cash: 8, inf: 1 }, risk: 1, note: 'It reopens on Monday under a new name.' }]);
  memo('Testimony', 'A Senate subcommittee invites you to discuss "pricing."', [
    { label: 'Testify, apologize, change nothing', gain: { inf: 1, loy: 3 } },
    { label: "Endow the chairman's library", cost: { cash: 3 }, gain: { inf: 3 } },
    { label: 'Testify, confidently, about things that are not true', gain: { inf: 2, cash: 6 }, risk: 1, note: 'The clip does very well online.' }]);
  memo('Food critic', 'A food critic has reviewed your flagship. The headline is "Fine."', [
    { label: 'Invite her back', gain: { loy: 6 } },
    { label: 'Ignore it', gain: { out: 8 } },
    { label: 'Buy the newspaper', gain: { loy: 7, inf: 1 }, risk: 1, note: 'The second review is much warmer.' }]);
  memo('Endorsement', 'A pop star would like to be seen holding your product. For a fee.', [
    { label: 'Pay her', cost: { cash: 4 }, gain: { loy: 8 } },
    { label: 'Decline', gain: { cash: 5 } },
    { label: 'Photoshop her holding it anyway', gain: { loy: 9 }, risk: 1, note: 'Her lawyers are on a boat with your auditors.' }]);
  memo('Foreign relations', 'The ambassador of San Limón requests a private dinner. He has brought maps.', [
    { label: 'Accept, and listen politely', gain: { inf: 1, cash: 3 } },
    { label: 'Fund a general', cost: { cash: 3 }, gain: { inf: 3 } },
    { label: 'Fund both generals', gain: { inf: 3, cash: 5 }, risk: 1, note: 'Whoever wins, they owe you.' }]);
  memo('Acquisition', 'A rival would like to buy your Midwest operation.', [
    { label: 'Decline, loudly', gain: { loy: 6 } },
    { label: 'Make a counteroffer', gain: { cash: 9 } },
    { label: 'Accept the deposit and lose the paperwork', gain: { cash: 13 }, risk: 1, note: 'There is no Midwest operation.' }]);
  memo('Halftime', 'A network offers thirty seconds during the championship game.', [
    { label: 'Buy the slot', cost: { cash: 5 }, gain: { loy: 11 } },
    { label: 'Sponsor the trophy instead', gain: { cash: 6, loy: 3 } },
    { label: "Buy the slot with the pension fund", gain: { loy: 12 }, risk: 1, note: 'The pension fund will recover.' }]);
  memo('Antitrust', 'The Department of Justice has opened an inquiry into "the lemonade situation."', [
    { label: 'Cooperate fully', gain: { cash: 5 } },
    { label: 'Restructure into fourteen subsidiaries', cost: { cash: 3 }, gain: { inf: 3 } },
    { label: 'Shred the documents', gain: { inf: 3, cash: 9 }, risk: 1, note: 'There were a lot of documents.' }]);
  memo('Sovereign wealth', 'A sovereign wealth fund would like a stake.', [
    { label: 'Sell them a stake', gain: { cash: 12 } },
    { label: 'Decline, graciously', gain: { loy: 7 } },
    { label: 'Sell the same stake to two funds', gain: { cash: 17 }, risk: 1, note: 'They will not compare notes.' }]);
  memo('Whistleblower', 'A former intern has written a book. Chapter four is about you.', [
    { label: 'Answer every question', gain: { loy: 8 } },
    { label: 'Hire her back as a consultant', cost: { cash: 4 }, gain: { inf: 3 } },
    { label: 'Buy every copy', gain: { cash: 10, inf: 1 }, risk: 1, note: 'There is a second printing.' }]);
  memo('Climate summit', 'You have been invited to speak about sustainability.', [
    { label: 'Pledge to go carbon neutral', cost: { cash: 4 }, gain: { loy: 10 } },
    { label: 'Send a deputy', gain: { cash: 7 } },
    { label: 'Pledge, then do not', gain: { loy: 10, cash: 5 }, risk: 1, note: 'Nobody checks.' }]);
  memo('Water rights', 'A drought. The reservoir upstream of the plant is for sale.', [
    { label: 'Buy it, and share', cost: { cash: 5 }, gain: { out: 14 } },
    { label: 'Ration production', gain: { cash: 8, loy: 3 } },
    { label: 'Buy it, and do not share', gain: { out: 18, cash: 4 }, risk: 1, note: 'Downstream is not your problem.' }]);
  memo('Space program', 'A launch company offers to put a lemonade stand on the moon.', [
    { label: 'Fund it', cost: { cash: 6 }, gain: { loy: 13 } },
    { label: 'Licence the footage', gain: { cash: 11 } },
    { label: 'Fund it with a government grant meant for something else', gain: { loy: 13, cash: 5 }, risk: 1, note: 'The moon has no zoning laws.' }]);
  memo('Homework', 'Your mother would like to know whether you have finished your homework.', [
    { label: 'Do your homework', gain: { loy: 8, card: 3 } },
    { label: 'Delegate it', gain: { cash: 10 } },
    { label: 'Forge her signature on the report card', gain: { cash: 12, inf: 2 }, risk: 1, note: 'Your empire spans continents. You are in the fourth grade.' }]);

  /* ---------- map names ---------- */
  const NAMES = ['Texas', 'Ohio', 'Florida', 'Iowa', 'Nevada', 'Maine', 'Utah', 'Georgia', 'Oregon', 'Kansas', 'Idaho', 'Vermont', 'Alabama', 'Arizona', 'Montana', 'Indiana', 'Kentucky', 'Nebraska', 'Michigan', 'Colorado', 'Delaware', 'Virginia', 'Missouri', 'Wyoming', 'Oklahoma', 'Canada', 'Mexico', 'Brazil', 'Peru', 'Chile', 'Iceland', 'Ireland', 'France', 'Spain', 'Italy', 'Greece', 'Egypt', 'Kenya', 'Nigeria', 'Morocco', 'Turkey', 'India', 'Japan', 'Korea', 'Vietnam', 'Australia', 'Norway', 'Poland', 'Antarctica'];
  const BONUS = [{ cash: 3 }, { card: 2 }, { calm: 2 }, { inf: 1 }, { out: 4 }];
  const COLORS = ['red', 'blue', 'green', 'orange'];

  const TRACE = num('TRACE', 0);
  const shuffle = a => { for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; } return a; };
  let uid = 1, ops = 0;
  const fx = (G, e) => { if (G.fxOn) (G.fx = G.fx || []).push(e); }; // physical moves, for the table to animate
  const PI = (G, p) => G.players.indexOf(p);

  /* ---------- a new game ---------- */
  function newGame(seats) {
    const n = seats.length, S = MSIZE[n];
    const G = { v: 6, n, round: 1, phase: 'stand', turn: 0, order: [], passed: [], players: [], deck: [], disc: [], piles: { sweet: [], sour: [], herb: [], fizz: [] },
      mdeck: [], mkt: [], mat: [], map: { size: S, cells: [] }, ideck: [], idisc: [], adeck: [], arow: [], rdeck: [], rrow: [], offer: null, memoAt: 0, memoQ: [], heat: 0, log: [], winner: null, choice: null, pending: null, reveal: null, limon: null, last: null };
    const PFS = ENV.PFS ? arr('PFS', '15,15,15,15') : FAMS.map(() => PERFAM); // test switch: cards per family, sweet,sour,herb,fizz
    FAMS.forEach((f, i) => { for (let k = 0; k < PFS[i]; k++) G.deck.push({ f, n: FLAVOR[f][k % FLAVOR[f].length] }); });
    shuffle(G.deck);
    for (let t = 1; t <= 4; t++) G.mdeck.push(...shuffle(MACHINES.filter(m => m.tier === t).map(m => ({ ...m }))));
    G.mdeck.reverse(); // pop() takes from the end: tier I first
    refillM(G);
    buildResearch(G);
    const names = shuffle(NAMES.slice());
    for (let r = 0; r < S; r++) for (let c = 0; c < S; c++) G.map.cells.push({ id: 'c' + c + 'r' + r, c, r, name: names.pop(), tok: {}, home: null, bonus: null });
    const plan = ENV.HOMES === 'free' ? null : BOARDS[n];
    if (plan) layBoard(G, plan, S);
    shuffle(G.map.cells.filter(c => !c.hot && !c.rough && !c.link && !(plan && plan.homes.some(([r, k]) => r === c.r && k === c.c)))).slice(0, n + 2).forEach((c, i) => c.bonus = { ...BONUS[i % BONUS.length] });
    for (const t in IDECK) for (const x of IDECK[t]) G.ideck.push({ u: uid++, t, x });
    shuffle(G.ideck);
    seats.forEach((s, i) => {
      const p = { name: s.name, bot: !!s.bot, gen: s.gen || undefined, spec: s.spec || (s.gen ? 'evo' : ['mfg', 'prd', 'dis', 'gen'][Math.floor(Math.random() * 4)]), color: i, shelf: [], cash: CASH0, hand: { sweet: 0, sour: 0, herb: 0, fizz: 0 },
        mach: [{ ...START, ran: false }], adv: [], tiles: [], prog: 0, era: 1, loy: LOY0, stars: 0, cont: num('C0', CMAX), ctl: 0, tok: TOKN, home: null, inf: [], jail: false, raided: false, filed: false };
      G.players.push(p);
      for (let k = 0; k < 2; k++) takeCard(G, p, 'sour');
    });
    if (ENV.G0CASH) G.players[0].cash += +ENV.G0CASH; // test switch
    if (ENV.GIFT) { const id = ENV.GIFT, k = G.rdeck.findIndex(a => a.id === id), j = G.arow.findIndex(a => a.id === id); const a = k >= 0 ? G.rdeck.splice(k, 1)[0] : j >= 0 ? G.arow.splice(j, 1)[0] : null; if (a) { G.players[0].adv.push(a); refillA(G); } } // test switch
    G.order = shuffle(G.players.map((_, i) => i)); G.turn = G.order[0];
    const spots = startSpots(n, S);
    if (spots) { // the board prints the starting stands; each founder is dealt one at random
      const deal = shuffle(spots.slice());
      G.players.forEach((p, i) => { const [r, c] = deal[i], x = G.map.cells.find(o => o.r === r && o.c === c); x.home = i; x.bonus = null; p.home = x.id; p.spot = spots.indexOf(deal[i]); log(G, i, `${p.name} sets up a card table in ${x.name}.`, 'up'); });
      log(G, null, 'Round 1. The founders set up at the edges of the map.', 'news');
      startPhase(G, 'biz'); return G;
    }
    log(G, null, `Round 1. Each founder chooses a corner for the stand.`, 'news');
    return G;
  }
  function takeCard(G, p, f) { // take the first card of a family from the deck (setup only)
    if (ENV.SDEAL === '0') { p.hand[f]++; return; } // test switch: starting cards come from outside the deck
    const i = G.deck.findIndex(c => c.f === f); if (i >= 0) { G.deck.splice(i, 1); p.hand[f]++; }
  }
  function dealMat(G) { // lay a fresh face-down tile on every square but the star
    const ts = shuffle(TILESET.map(t => ({ ...t, get: { ...t.get } }))); let k = 0;
    for (const t of G.mat) { if (t.d === 0) continue; t.st = ts[k].st; t.get = ts[k].get; t.owner = null; t.seen = false; k++; }
  }
  /* ---------- the printed boards ---------- */
  // Hot spots pay at every payday while you control them: one shared by every stand, and one shared by each pair of neighbouring stands.
  // Rugged markets cost 2 more loyalty to enter unless you control them: one in each stand's back yard. Air routes join far edges as one step.
  const BOARDS = {
    2: { homes: [[0, 0], [4, 4]], hot: [[2, 2, 3], [1, 3, 2], [3, 1, 2]], rough: [[1, 1], [3, 3]], links: [[[0, 4], [4, 0]]] },
    3: { homes: [[1, 0], [2, 5], [5, 2]], hot: [[2, 2, 3], [1, 3, 2], [3, 1, 2], [3, 3, 2]], rough: [[1, 1], [2, 4], [4, 2]], links: [[[0, 3], [4, 0], [5, 5]]] },
    4: { homes: [[0, 0], [0, 6], [6, 0], [6, 6]], hot: [[3, 3, 3], [1, 3, 2], [3, 1, 2], [3, 5, 2], [5, 3, 2]], rough: [[1, 1], [1, 5], [5, 1], [5, 5]], links: [[[0, 3], [6, 3]], [[3, 0], [3, 6]]] } };
  // The outer ring is North America, nearest the stands at the centre of the country and furthest at its far edges.
  const RING = [['Kansas', 'Nebraska', 'Missouri', 'Oklahoma'], ['Iowa', 'Colorado', 'Texas', 'South Dakota', 'Arkansas', 'Illinois', 'Minnesota', 'New Mexico'],
    ['Wyoming', 'Tennessee', 'Wisconsin', 'Kentucky', 'Louisiana', 'Montana', 'Indiana', 'Utah'], ['Ohio', 'Georgia', 'Arizona', 'Michigan', 'Idaho', 'Alabama', 'Nevada', 'Mississippi'],
    ['California', 'New York', 'Florida', 'Washington', 'Oregon', 'Ontario', 'Mexico', 'Virginia'], ['Maine', 'Quebec', 'British Columbia', 'Puerto Rico', 'Massachusetts', 'Cuba'],
    ['Alaska', 'Hawaii', 'Greenland', 'Yukon', 'Nunavut', 'Newfoundland']];
  const WORLD = ['Brazil', 'India', 'Nigeria', 'Germany', 'Egypt', 'Korea', 'Australia', 'Italy', 'Spain', 'Kenya', 'Vietnam', 'Peru', 'Turkey', 'Chile', 'Poland', 'Indonesia', 'Argentina', 'Morocco', 'Thailand', 'Norway', 'Greece', 'Japan', 'Ireland', 'Iceland', 'Ghana'];
  const HOTN = ['Tokyo', 'London', 'Shanghai', 'Paris', 'Dubai'], ROUGHN = ['the Himalayas', 'the Andes', 'the Alps', 'the Sahara', 'Siberia'], ROUTES = ['A', 'B', 'C'];
  function layBoard(G, plan, S) {
    const at = (r, c) => G.map.cells.find(x => x.r === r && x.c === c), e = S - 1;
    const near = x => Math.min(...plan.homes.map(([r, c]) => Math.abs(r - x.r) + Math.abs(c - x.c)));
    const ring = G.map.cells.filter(x => x.r === 0 || x.c === 0 || x.r === e || x.c === e), maxD = Math.max(...ring.map(near));
    const pools = RING.map(a => shuffle(a.slice()));
    ring.slice().sort((a, b) => near(a) - near(b)).forEach(x => { const dd = near(x); let t = dd <= 1 ? dd : Math.round(dd / maxD * (RING.length - 1)), k = 0;
      while (!pools[Math.min(RING.length - 1, Math.max(0, t + k))].length && k < 8) k = k <= 0 ? -k + 1 : -k; // nearest tier with a name left
      x.name = pools[Math.min(RING.length - 1, Math.max(0, t + k))].pop() || x.name; });
    const world = shuffle(WORLD.slice()); G.map.cells.filter(x => !ring.includes(x)).forEach(x => x.name = world.pop());
    plan.hot.forEach(([r, c, out], i) => { const x = at(r, c); x.hot = { out }; x.name = HOTN[i]; });
    plan.rough.forEach(([r, c], i) => { const x = at(r, c); x.rough = 2; x.name = ROUGHN[i]; });
    plan.links.forEach((grp, g) => grp.forEach(([r, c]) => { at(r, c).link = ROUTES[g]; }));
    if (IMPON) G.map.cells.forEach(x => { const inner = !ring.includes(x); x.imp = 0; x.yield = IMPY.map(y => y + (inner ? IMPC : 0) + (x.hot ? IMPC : 0)); });
  }
  // Printed starting stands, at the edges of the map: opposite corners for two, every corner for four,
  // and for three the pinwheel that puts every pair of stands exactly 6 steps apart. HOMES=free restores the old free choice.
  function startSpots(n, S) {
    if (ENV.HOMES === 'free') return null;
    if (ENV.HOMES) return ENV.HOMES.split(';').map(x => x.split(',').map(Number));
    const e = S - 1;
    if (n === 2) return [[0, 0], [e, e]];
    if (BOARDS[n] && S === BOARDS[n].homes.reduce((m, [r, c]) => Math.max(m, r, c), 0) + 1) return BOARDS[n].homes;
    if (n === 3) return [[1, 0], [2, e], [e, 2]];
    if (n === 4) return [[0, 0], [0, e], [e, 0], [e, e]];
    return null;
  }
  function refillA(G) { } // the advisor board fills only from the research deck
  function boardAdvisor(G, a) { G.arow.push(a); fx(G, { k: 'mach', m: { name: a.name, tier: 0 }, from: 'rdeck', to: 'arow-' + (G.arow.length - 1), slide: true });
    if (G.arow.length > ABOARD) { const old = G.arow.shift(); log(G, null, `${old.name} takes a job elsewhere.`, 'news'); } }
  function refillRow(G, k, pi) { // turn over research cards for a gap in the row; an advisor is offered to the researcher, or goes to the board
    while (G.rdeck.length) {
      const c = G.rdeck.pop();
      if (c.kind === 'adv') { const { kind, ...a } = c;
        if (pi !== null && G.winner === null) { G.offer = { pi, a, k }; log(G, pi, `${G.players[pi].name} turns over ${a.name}, ${a.role}.`, 'news'); return true; }
        boardAdvisor(G, a); log(G, null, `${a.name} is looking for work.`, 'news'); continue; }
      G.rrow[k] = c; if (c.win) { G.st = G.st || {}; G.st.formulaAt = G.round; } fx(G, { k: 'mach', m: { name: c.win ? c.name : 'Experiment', tier: c.tier }, from: 'rdeck', to: 'rcard-' + k, slide: true }); return false;
    }
    G.rrow[k] = null; return false;
  }
  function canTakeOffer(G) { const o = G.offer; if (!o) return no('Nothing on offer'); const p = G.players[o.pi]; if ((p.cont || 0) < (o.a.cc || 0)) return no(`Needs ${o.a.cc} control`); return p.cash < o.a.price ? no("Can't afford") : yes({ cash: o.a.price, cont: o.a.cc || 0 }); }
  function takeOffer(G, scrap) { // the researcher hires the advisor they turned over, at its price
    const o = G.offer; if (!o || !canTakeOffer(G).ok) return false; const pi = o.pi, p = G.players[pi];
    if (used(p) >= SLOTS && !canVacate(p, scrap)) return false;
    p.cash -= o.a.price; acc(p, 'adv', o.a.price); acc(p, 'advN', 1); p.cont -= o.a.cc || 0; const gone = used(p) >= SLOTS ? vacate(G, pi, scrap) : '';
    p.adv.push(o.a); hook(G, pi, o.a); (p.ever = p.ever || []).includes(o.a.id) || p.ever.push(o.a.id);
    fx(G, { k: 'mach', m: { name: o.a.name, tier: 0 }, from: 'rdeck', to: 'adv-' + pi + '-' + (p.adv.length - 1) });
    G.st = G.st || {}; G.st.offersTaken = (G.st.offersTaken || 0) + 1;
    log(G, pi, `${p.name} hires ${o.a.name} on the spot. (${o.a.who})${gone}`, 'up'); return afterOffer(G);
  }
  function declineOffer(G) { const o = G.offer; if (!o) return false; boardAdvisor(G, o.a); log(G, o.pi, `${G.players[o.pi].name} passes on ${o.a.name}, who goes to the board.`, 'news'); return afterOffer(G); }
  function afterOffer(G) { const o = G.offer; G.offer = null; if (refillRow(G, o.k, o.pi)) { G.offer.next = o.next; return true; } if (o.next && G.winner === null) next(G); return true; }
  function refillM(G) { while (G.mkt.length < MKT && G.mdeck.length) { const m = G.mdeck.pop(); G.mkt.push(m); (G.mseen = G.mseen || {})[m.id] = G.mseen[m.id] || G.round; } G.mkt.sort((a, b) => a.price - b.price); }
  function log(G, p, text, kind) { G.log.push({ p, text, kind: kind || 'news', r: G.round }); if (G.log.length > 120) G.log.shift(); recLog(G, p, text, kind); }

  /* ---------- reading the state ---------- */
  const P = G => G.players[G.turn];
  const co = (G, i) => G.players[i].name.endsWith('s') ? `${G.players[i].name}' Lemonade` : `${G.players[i].name}'s Lemonade`;
  const cell = (G, id) => G.map.cells.find(c => c.id === id) || null;
  const toks = (c, pi) => c.tok[pi] || 0;
  const ownerOf = c => { let best = 0, w = null; for (const k in c.tok) { const v = c.tok[k]; if (v > best) { best = v; w = +k; } else if (v === best) w = null; } return best > 0 ? w : null; };
  const controlled = (G, pi) => { const h = G.players[pi].home; return G.map.cells.filter(c => ownerOf(c) === pi).length + (G.limon === pi ? 1 : 0) + (hasA(G.players[pi], 'becky') && h && ownerOf(G.map.cells.find(c => c.id === h)) === pi ? 1 : 0); };
  const homeOf = (G, pi) => G.players[pi].home ? cell(G, G.players[pi].home) : null;
  const dist = (G, pi, c) => { const h = homeOf(G, pi); return h ? Math.abs(h.c - c.c) + Math.abs(h.r - c.r) : 0; };
  const NEAR = num('NEAR', 0); // 1: the surcharge counts from your nearest controlled market, and is 0 in one you control
  const OUTPOST = num('OUTPOST', 3), DCACHE = new WeakMap();
  const outpostN = p => hasA(p, 'franchise') ? 2 : OUTPOST;
  function travel(G, pi) { // steps from your home or any outpost to every market; air routes join their markets as neighbours
    const on = outpostN(G.players[pi]), origins = G.map.cells.filter(x => x.home === pi || (x.tok[pi] || 0) >= on), key = pi + ':' + origins.map(x => x.id).join(',');
    let cache = DCACHE.get(G); if (!cache) DCACHE.set(G, cache = {}); if (cache[pi] && cache[pi].key === key) return cache[pi].d;
    const d = {}, q = []; origins.forEach(x => { d[x.id] = 0; q.push(x); });
    const byPos = {}; G.map.cells.forEach(x => byPos[x.r + ',' + x.c] = x);
    while (q.length) { const x = q.shift(), nb = [byPos[(x.r - 1) + ',' + x.c], byPos[(x.r + 1) + ',' + x.c], byPos[x.r + ',' + (x.c - 1)], byPos[x.r + ',' + (x.c + 1)], ...(x.link ? G.map.cells.filter(y => y.link === x.link && y !== x) : [])];
      for (const y of nb) if (y && d[y.id] === undefined) { d[y.id] = d[x.id] + 1; q.push(y); } }
    cache[pi] = { key, d }; return d;
  }
  const reach = (G, pi, c) => { // steps from your home or nearest outpost (the old rule, NEAR=1, counted from controlled markets)
    if (!NEAR) { const d = travel(G, pi)[c.id]; return d === undefined ? dist(G, pi, c) : d; }
    if (ownerOf(c) === pi) return 0;
    const own = G.map.cells.filter(o => ownerOf(o) === pi); if (!own.length) return dist(G, pi, c); // nothing controlled: count from home
    return Math.min(...own.map(o => Math.abs(o.c - c.c) + Math.abs(o.r - c.r)));
  };
  const TB = num('TB', 1);
  const tokCost = (G, pi, c) => { const o = ownerOf(c); return Math.max(1, TB + (c.rough && o !== pi && !hasA(G.players[pi], 'dwarf') ? c.rough : 0) + (hasA(G.players[pi], 'realtor') ? Math.min(2, reach(G, pi, c)) : reach(G, pi, c)) - (hasA(G.players[pi], 'rhonda') && o !== null && o !== pi ? 2 : 0) + (o !== null && o !== pi && hasA(G.players[o], 'cop') ? 1 : 0)); };
  const drawCost = p => Math.max(1, DRAW - (hasA(p, 'cfo') && !p.cfoR ? 1 : 0));
  const starText = h => { const w = 1 + Math.floor(h / 2); return `${w}${h % 2 ? '\u00bd' : ''} star${w === 1 && !(h % 2) ? '' : 's'}`; };
  const handSize = p => FAMS.reduce((a, f) => a + p.hand[f], 0);
  const topEra = G => Math.max(...G.players.map(q => q.era));
  const tolerance = G => TOL[Math.max(0, bandOf(topEra(G)) - (G.players.some(q => hasA(q, 'elle')) ? 1 : 0))]; // Elle W. on anyone's floor lowers the raid line one band
  const onMap = (G, pi) => G.map.cells.reduce((a, c) => a + toks(c, pi), 0);
  const no = why => ({ ok: false, why });
  const yes = cost => ({ ok: true, cost: cost || {} });
  const myTurn = (G, phase) => G.winner !== null ? 'The game is over' : G.offer ? 'Decide on the advisor first' : G.choice ? 'Choose a card first' : G.pending ? 'Answer the memo first' : phase && G.phase !== phase ? 'Not in this phase' : null;

  /* ---------- turn order and phases ---------- */
  const rank = (G, i) => { const q = G.players[i]; return q.ctl * 1000 + q.era * 30 + q.cash; };
  const tina = (G, i) => hasA(G.players[i], 'tina') ? -1e6 : 0;
  function bizOrder(G) { return G.players.map((_, i) => i).sort((a, b) => tina(G, a) - tina(G, b) || rank(G, a) - rank(G, b) || G.order.indexOf(a) - G.order.indexOf(b)); } // trailing company first
  function placeOrder(G) { return G.players.map((_, i) => i).sort((a, b) => tina(G, a) - tina(G, b) || rank(G, b) - rank(G, a) || G.order.indexOf(a) - G.order.indexOf(b)); } // the leader places first
  const UD = num('UD', 0), UDF = num('UDF', 0); // catch-up loyalty: +1 for every UD markets you trail the leader by, plus UDF flat for everyone
  const stipend = (G, i) => { const q = G.players[i], top = Math.max(...G.players.map((_, j) => controlled(G, j))); return LOYE[q.era - 1] + (hasA(q, 'tanner') ? 1 : 0) + underdog(G, i, top); };
  const underdog = (G, i, top) => UDF + (UD ? Math.floor((top - controlled(G, i)) / UD) : 0);
  function startPhase(G, phase) {
    G.phase = phase; G.passed = [];
    G.order = phase === 'biz' ? bizOrder(G) : placeOrder(G);
    if (phase === 'biz') G.players.forEach((q, i) => { q.mach.forEach(m => m.ran = false); q.jail = q.raided; q.raided = false; q.t2 = q.g2 = q.halUsed = q.cfoR = false; if (ONE) pour(G, i, 0); if (hasA(q, 'swamp') && G.round % 3 === 0) { log(G, i, `The Deep Swamp Creature brings ${q.name} a favor.`, 'inf'); drawInf(G, i, 1); } });
    if (phase === 'place') G.players.forEach((q, i) => { q.r2 = false; const n = stipend(G, i) + (+(ENV.LGIFT || 0) && i === 0 && G.round === +(ENV.LGR || 2) ? +ENV.LGIFT : 0) + 0; q.loy += n; lt(G, i, 'era', stipend(G, i)); if (+(ENV.CGIFT || 0) && i === 0 && G.round === +(ENV.LGR || 2)) q.cash += +ENV.CGIFT; ops++; fx(G, { k: 'heart', n, from: 'era-' + i, to: 'loy-' + i }); });
    G.turn = G.order[0];
    log(G, null, phase === 'biz' ? `Round ${G.round}. The market opens.` : `Round ${G.round}. Every company collects loyalty for its era, and loyalty goes on the map.`, 'news');
  }
  function next(G) { // pass the turn to the next company in this phase that has not passed
    ops++;
    if (G.winner !== null) return;
    const me = G.players[G.turn];
    const o = G.order, start = o.indexOf(G.turn);
    for (let k = 1; k <= o.length; k++) { const i = o[(start + k) % o.length]; if (!G.passed.includes(i)) { G.turn = i; return; } }
    endPhase(G);
  }
  function endPhase(G) {
    if (G.phase === 'stand') return startPhase(G, 'biz');
    if (G.phase === 'biz') return startPhase(G, 'place');
    if (G.phase === 'place') return payday(G);
  }
  function pass(G) {
    if (myTurn(G)) return false;
    if (G.phase === 'biz' && hasA(P(G), 'tina')) { drawFree(G, P(G), 1); log(G, G.turn, `Tina handles a few things while ${P(G).name} is out.`, 'news'); }
    G.passed.push(G.turn); next(G); return true;
  }

  /* ---------- the stand (round 1) ---------- */
  function canStand(G, id) {
    const c = cell(G, id); if (G.phase !== 'stand') return no('Not now'); if (!c) return no('No market');
    if (c.home !== null) return no('Taken');
    if (G.map.cells.some(o => o.home !== null && Math.abs(o.c - c.c) + Math.abs(o.r - c.r) < 2)) return no('Too close to another stand');
    return yes();
  }
  function stand(G, id) {
    if (!canStand(G, id).ok) return false;
    const pi = G.turn, p = P(G), c = cell(G, id); c.home = pi; p.home = id; if (hasA(p, 'becky')) c.becky = pi; fx(G, { k: 'stand', pi, from: 'seat-' + pi, to: 'cell-' + id });
    log(G, pi, `${p.name} sets up a card table in ${c.name}.`, 'up');
    G.passed.push(pi); next(G); return true;
  }

  /* ---------- the ingredient market ---------- */
  function canDraw(G) { const p = P(G); return myTurn(G, 'biz') ? no(myTurn(G, 'biz')) : p.jail ? no('In custody') : p.cash < drawCost(p) ? no("Can't afford") : !(G.deck.length + G.disc.length) ? no('The deck is empty') : yes({ cash: drawCost(p) }); }
  function draw(G) { // pay, turn over three, keep one; the rest go face up on their piles
    const x = canDraw(G); if (!x.ok) return false; const p = P(G);
    p.cash -= x.cost.cash; acc(p, 'ing', x.cost.cash); acc(p, 'drawN', 1); if (hasA(p, 'cfo')) p.cfoR = true; const cs = [];
    for (let k = 0; k < 3; k++) { if (!G.deck.length) { G.deck = shuffle(G.disc); G.disc = []; } if (G.deck.length) cs.push(G.deck.pop()); }
    G.choice = { pi: G.turn, cards: cs }; ops += 2; fx(G, { k: 'back', n: cs.length, from: 'ingdeck', to: 'choice' }); return true;
  }
  function pick(G, i) {
    const ch = G.choice; if (!ch || !ch.cards[i] || ch.cards[i].taken) return false;
    const p = G.players[ch.pi], c = ch.cards[i]; p.hand[c.f]++; c.taken = true; ch.kept = (ch.kept || 0) + 1;
    fx(G, { k: 'ing', f: c.f, n: 1, from: 'choice-' + i, to: 'hand-' + ch.pi + '-' + c.f });
    if (ch.kept < KEEP && ch.cards.some(o => !o.taken)) return true; // keep another
    const left = ch.cards.map((o, k) => ({ o, k })).filter(x => !x.o.taken);
    left.forEach(x => { G.piles[x.o.f].push(x.o); fx(G, { k: 'ing', f: x.o.f, n: 1, from: 'choice-' + x.k, to: 'pile-' + x.o.f }); });
    G.st = G.st || {}; G.st.drawn = (G.st.drawn || 0) + 1; if (TRACE) (G.clog2 = G.clog2 || []).push({ pi: ch.pi, r: G.round, n: ch.kept, how: 'draw' });
    log(G, ch.pi, `${p.name} buys ${ch.cards.filter(o => o.taken).map(o => o.n.toLowerCase()).join(' and ')} and leaves ${left.map(x => x.o.n.toLowerCase()).join(' and ') || 'nothing'} on the counter.`, 'news');
    ch.cards.forEach(o => delete o.taken); G.choice = null; next(G); return true;
  }
  function canTake(G, f) { const p = P(G); return myTurn(G, 'biz') ? no(myTurn(G, 'biz')) : p.jail ? no('In custody') : !G.piles[f].length ? no('Nothing there') : p.cash < TAKE ? no("Can't afford") : yes({ cash: TAKE }); }
  function take(G, f) {
    const x = canTake(G, f); if (!x.ok) return false; const p = P(G), n = PILE1 ? 1 : G.piles[f].length;
    p.cash -= TAKE; acc(p, 'ing', TAKE); acc(p, 'pileN', 1); p.hand[f] += n; if (PILE1) G.piles[f].pop(); else G.piles[f] = []; ops++; /* PILE1 (test switch): a pile sells one card at a time */ if (TRACE) (G.clog2 = G.clog2 || []).push({ pi: G.turn, r: G.round, n, how: 'take', cash: TAKE }); G.st = G.st || {}; G.st.taken = (G.st.taken || 0) + 1; G.st.pileCards = (G.st.pileCards || 0) + n; fx(G, { k: 'ing', f, n, from: 'pile-' + f, to: 'hand-' + G.turn + '-' + f });
    log(G, G.turn, PILE1 ? `${p.name} buys a ${FNAME[f].toLowerCase()} card off the counter.` : `${p.name} takes all ${n} ${FNAME[f].toLowerCase()} card${n > 1 ? 's' : ''} on the counter.`, 'news');
    next(G); return true;
  }
  function spend(G, p, fams, to) { if (TRACE) (G.slog = G.slog || []).push({ pi: G.players.indexOf(p), r: G.round, n: fams.length, to: String(to).startsWith('mach') ? 'mach' : 'research' }); for (const f of fams) { p.hand[f]--; G.disc.push({ f, n: FLAVOR[f][0] }); fx(G, { k: 'ing', f, n: 1, from: 'hand-' + PI(G, p) + '-' + f, to: to || 'disc', gone: true }); } }

  /* ---------- machines ---------- */
  function fuel(p, inp) { // which cards would run this machine: named families first, then 'any' from whatever is most plentiful
    const h = { ...p.hand }, use = [];
    for (const f of inp) if (f !== 'any') { if (h[f] < 1) return null; h[f]--; use.push(f); }
    for (const f of inp) if (f === 'any') { const g = FAMS.slice().sort((a, b) => h[b] - h[a])[0]; if (!h[g]) return null; h[g]--; use.push(g); }
    return use;
  }
  function canRun(G, i, hal) {
    const p = P(G), m = p.mach[i]; if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody');
    if (!m) return no('No machine');
    if (hal === 'rerun') return !p.rerun ? no('No re-run') : !m.ran ? no('Has not run yet') : fuel(p, m.inp) ? yes() : no('Missing ingredients');
    if (m.ran && !(hasA(p, 'grad') && !p.g2)) return no('Already ran this round');
    if (hal === 'free') return !p.free ? no('No free run') : !m.inp.length ? no('Needs no cards anyway') : yes();
    if (hal) return !hasA(p, 'hal') ? no('No HAL') : p.halUsed ? no('HAL has run once this round') : !m.inp.length ? no('Needs no cards anyway') : yes();
    return fuel(p, m.inp) ? yes() : no('Missing ingredients');
  }
  function run(G, i, use, hal) {
    const x = canRun(G, i, hal); if (!x.ok) return false; const p = P(G), m = p.mach[i];
    if (hal === 'rerun') p.rerun--; else if (m.ran) p.g2 = true; // the graduate's second run
    const out = hal === true ? Math.max(1, m.out - 2) : m.out;
    if (hal === true) p.halUsed = true; else if (hal === 'free') p.free--; else spend(G, p, use || fuel(p, m.inp), 'mach-' + G.turn + '-' + i);
    m.ran = true; ops++; m.runs = (m.runs || 0) + 1; m.pit = (m.pit || 0) + out; if (hal !== true && hal !== 'free') { m.cards = (m.cards || 0) + m.inp.length; acc(p, 'runCards', m.inp.length); } acc(p, 'runs', 1); acc(p, 'runPit', out); m.how = m.how || {}; m.how[hal === true ? 'hal' : hal || 'paid'] = (m.how[hal === true ? 'hal' : hal || 'paid'] || 0) + 1;
    fx(G, { k: 'pit', n: out, from: 'mach-' + G.turn + '-' + i, to: 'prog-' + G.turn }); pour(G, G.turn, out, hal === true ? 'hal' : hal || 'mach');
    if (m.xtra.cash) fx(G, { k: 'coin', n: m.xtra.cash, from: 'mach-' + G.turn + '-' + i, to: 'cash-' + G.turn });
    const xs = m.xtra; if (xs.cash) p.cash += xs.cash; if (xs.card) drawFree(G, p, xs.card); if (xs.inf) drawInf(G, G.turn, xs.inf); if (xs.heat) expose(G, G.turn, xs.heat);
    log(G, G.turn, `${hal === true ? 'HAL 8000 runs' : hal === 'free' ? `${p.name} takes a free run on` : hal === 'rerun' ? `${p.name} re-runs` : `${p.name} runs`} the ${m.name.toLowerCase()}: ${out} pitchers.`, 'up');
    next(G); return true;
  }
  function pour(G, pi, n, src) { // pitchers go onto the era track; a full track is a new era, and at the top it pays loyalty instead
    const p = G.players[pi]; if (TRACE && n) (G.plog = G.plog || []).push({ pi, r: G.round, n, src: src || 'other' }); p.prog += n; ops++;
    while (p.prog >= trackLen(p) && !(ONE && p.upAt === G.round)) {
      p.prog -= trackLen(p); ops++;
      if (p.era < ERAS) {
        const aloneBefore = !G.players.some((q, j) => j !== pi && q.era >= p.era); // moving up from a tie still draws a memo
        const was = bandOf(p.era); p.era++; p.upAt = G.round; fx(G, { k: 'era', pi });
        // memos go only to a company that is not alone at the top era. MEMOMODE is a test switch: all, era (the rule), none, burn (the era leader's memo is discarded), map (no memo for the lone map leader)
        const MM = ENV.MEMOMODE || 'era', ctl = G.players.map((_, j) => controlled(G, j)), mtop = Math.max(...ctl), mapLead = ctl[pi] === mtop && ctl.filter(x => x === mtop).length === 1;
        const eraLead = aloneBefore;
        const get = MM === 'all' ? true : MM === 'none' ? false : MM === 'map' ? !mapLead : !eraLead;
        if (TRACE) (G.mlog = G.mlog || []).push({ pi, r: G.round, era: p.era, got: get && G.memoAt < MEMOS.length, eraLead, mapLead, ctl: ctl.slice(), id: G.memoAt });
        if (get && G.memoAt < MEMOS.length) G.memoQ.push({ pi, id: G.memoAt++ });
        else if (MM === 'burn' && eraLead && G.memoAt < MEMOS.length) G.memoAt++;
        log(G, pi, bandOf(p.era) > was ? `${co(G, pi)} enters era ${p.era}. It is now a ${BANDS[bandOf(p.era)].name}.` : `${co(G, pi)} enters era ${p.era}.`, bandOf(p.era) > was ? 'win' : 'up');
        if (TRACE) (G.elog = G.elog || []).push({ pi, era: p.era, r: G.round });
        if (WIN === 'era' && p.era >= ERAS && G.winner === null) { G.memoQ = []; G.choice = null; G.pending = null; return finish(G, [pi]); } // first to the top era wins on the spot
      } else { p.loy += OVER; lt(G, pi, 'era', OVER); fx(G, { k: 'heart', n: OVER, from: 'prog-' + pi, to: 'loy-' + pi }); log(G, pi, `${co(G, pi)} fills the track again: ${OVER} loyalty.`, 'up'); }
    }
  }
  function drawFree(G, p, n) { for (let k = 0; k < n; k++) { if (!G.deck.length) { G.deck = shuffle(G.disc); G.disc = []; } const c = G.deck.pop(); if (c) { p.hand[c.f]++; fx(G, { k: 'ing', f: c.f, n: 1, from: 'ingdeck', to: 'hand-' + PI(G, p) + '-' + c.f }); } } ops++; }
  function canBuy(G, i) {
    const p = P(G), m = G.mkt[i]; if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody');
    return !m ? no('No machine') : p.cash < m.price ? no("Can't afford") : yes({ cash: m.price });
  }
  function buy(G, i, scrap) {
    const x = canBuy(G, i); if (!x.ok) return false; const p = P(G);
    if (used(p) >= SLOTS && !canVacate(p, scrap)) return false;
    const m = G.mkt.splice(i, 1)[0]; p.cash -= m.price; acc(p, 'mach', m.price); acc(p, 'machN', 1);
    let gone = '', slot = p.mach.length;
    if (used(p) >= SLOTS && typeof scrap === 'number') { const old = p.mach[scrap]; fx(G, { k: 'mach', m: { name: old.name, tier: old.tier }, from: 'mach-' + G.turn + '-' + scrap, to: 'mdeck', gone: true }); (G.mdead = G.mdead || []).push({ ...old, gone: G.round, pi: G.turn }); (p.shelf = p.shelf || []).push({ id: old.id, name: old.name, tier: old.tier, inp: old.inp.slice() }); p.mach[scrap] = { ...m, ran: false, at: G.round, runs: 0, pit: 0, cards: 0 }; slot = scrap; gone = ` It scraps the ${old.name.toLowerCase()}.`; }
    else { if (used(p) >= SLOTS) gone = vacate(G, G.turn, scrap); slot = p.mach.length; p.mach.push({ ...m, ran: false, at: G.round, runs: 0, pit: 0, cards: 0 }); } // a new machine can run the round it is installed
    fx(G, { k: 'mach', m: { name: m.name, tier: m.tier }, from: 'mkt-' + i, to: 'mach-' + G.turn + '-' + slot });
    const had = G.mkt.slice(); refillM(G); ops++;
    G.mkt.forEach((x, k) => { if (!had.includes(x)) fx(G, { k: 'mach', m: { name: x.name, tier: x.tier }, from: 'mdeck', to: 'mkt-' + k, slide: true }); });
    log(G, G.turn, `${p.name} installs a ${m.name.toLowerCase()}.${gone}`, 'up');
    next(G); return true;
  }

  /* ---------- advisors ---------- */
  const canVacate = (p, s) => typeof s === 'string' ? !!p.adv[+s.slice(1)] : typeof s === 'number' && !!p.mach[s];
  function hook(G, pi, a) { if (a.id === 'becky') { const h = homeOf(G, pi); if (h) h.becky = pi; } }
  function unhook(G, pi, a) { if (a.id === 'becky') { const h = homeOf(G, pi); if (h) delete h.becky; } }
  function vacate(G, pi, s) { // free a slot: scrap a machine, or let an advisor go back to the bottom of the advisor deck
    const p = G.players[pi];
    if (typeof s === 'string') { const k = +s.slice(1), a = p.adv.splice(k, 1)[0]; unhook(G, pi, a); boardAdvisor(G, a); fx(G, { k: 'mach', m: { name: a.name, tier: 0 }, from: 'adv-' + pi + '-' + k, to: 'adeck', gone: true }); return ` ${a.name} is let go.`; }
    const old = p.mach.splice(s, 1)[0]; (G.mdead = G.mdead || []).push({ ...old, gone: G.round, pi }); (p.shelf = p.shelf || []).push({ id: old.id, name: old.name, tier: old.tier, inp: old.inp.slice() }); fx(G, { k: 'mach', m: { name: old.name, tier: old.tier }, from: 'mach-' + pi + '-' + s, to: 'mdeck', gone: true }); return ` It scraps the ${old.name.toLowerCase()}.`;
  }
  function canScrap(G, i) { const p = P(G); if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody'); return p.mach[i] ? yes() : no('No such machine'); }
  function scrapM(G, i) { // a free action on your market turn: the machine goes to your shelf
    if (!canScrap(G, i).ok) return false; const p = P(G), m = p.mach[i]; vacate(G, G.turn, i); acc(p, 'scrapN', 1);
    log(G, G.turn, `${p.name} scraps its ${m.name.toLowerCase()} and keeps what it learned.`, 'news'); ops++; return true;
  }
  function canHire(G, k, from) { // k: a place in the row, or, with from, a rival's advisor to poach
    const p = P(G); if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody');
    const a = from === undefined ? G.arow[k] : G.players[from] && G.players[from].adv[k]; if (!a) return no('Nobody there');
    if (from === G.turn) return no('Already yours'); if (p.era < a.era) return no(`Needs era ${a.era}`);
    const cost = a.price + (from === undefined ? 0 : POACH); if ((p.cont || 0) < (a.cc || 0)) return no(`Needs ${a.cc} control`); return p.cash < cost ? no("Can't afford") : yes({ cash: cost, cont: a.cc || 0 });
  }
  function hire(G, k, from, scrap) {
    const x = canHire(G, k, from); if (!x.ok) return false; const p = P(G), pi = G.turn;
    if (used(p) >= SLOTS && !canVacate(p, scrap)) return false;
    let a, src = 'arow-' + k;
    if (from === undefined) { a = G.arow.splice(k, 1)[0]; }
    else { const q = G.players[from]; a = q.adv.splice(k, 1)[0]; unhook(G, from, a); q.cash += POACH; src = 'adv-' + from + '-' + k; fx(G, { k: 'coin', n: POACH, from: 'cash-' + pi, to: 'cash-' + from }); }
    p.cash -= x.cost.cash; acc(p, 'adv', x.cost.cash); acc(p, 'advN', 1); p.cont -= a.cc || 0; const gone = used(p) >= SLOTS ? vacate(G, pi, scrap) : '';
    p.adv.push(a); hook(G, pi, a); ops += 2; (p.ever = p.ever || []).includes(a.id) || p.ever.push(a.id);
    fx(G, { k: 'mach', m: { name: a.name, tier: 0 }, from: src, to: 'adv-' + pi + '-' + (p.adv.length - 1) });
    G.st = G.st || {}; G.st[from === undefined ? 'hires' : 'poach'] = (G.st[from === undefined ? 'hires' : 'poach'] || 0) + 1;
    log(G, pi, from === undefined ? `${p.name} retains ${a.name} as ${a.role}. (${a.who})${gone}` : `${p.name} hires ${a.name} away from ${G.players[from].name}.${gone}`, 'up');
    next(G); return true;
  }
  function canHit(G, ti, k) {
    const p = P(G); if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody');
    if (!hasA(p, 'boogey')) return no('No Boogeyman'); if (p.hitR === G.round) return no('Once a round');
    const q = G.players[ti]; return ti === G.turn || !q ? no('Choose a rival') : !q.adv[k] ? no('Nobody there') : yes();
  }
  function hit(G, ti, k) {
    if (!canHit(G, ti, k).ok) return false; const p = P(G), q = G.players[ti], a = q.adv.splice(k, 1)[0]; unhook(G, ti, a); p.hitR = G.round; ops++;
    fx(G, { k: 'mach', m: { name: a.name, tier: 0 }, from: 'adv-' + ti + '-' + k, to: 'seat-' + G.turn, gone: true });
    G.st = G.st || {}; G.st.hits = (G.st.hits || 0) + 1;
    log(G, G.turn, `${q.name}'s ${a.role.toLowerCase()}, ${a.name}, is never seen again.`, 'dirty'); expose(G, G.turn, 1);
    next(G); return true;
  }
  function canSell(G) { const p = P(G); return myTurn(G, 'biz') ? no(myTurn(G, 'biz')) : !hasA(p, 'paul') ? no('No Paul') : p.soldR === G.round ? no('Once a market') : !p.hand.sour ? no('No Acidic cards') : yes(); }
  function sell(G, n) { // Paul buys lemons; free, and the turn goes on
    if (!canSell(G).ok) return false; const p = P(G); n = Math.max(1, Math.min(n || 1, 2, p.hand.sour)); p.soldR = G.round;
    for (let k = 0; k < n; k++) { p.hand.sour--; G.disc.push({ f: 'sour', n: 'Lemon' }); } p.cash += 2 * n; ops++;
    fx(G, { k: 'coin', n: 2 * n, from: 'hand-' + G.turn + '-sour', to: 'cash-' + G.turn });
    log(G, G.turn, `${p.name} sells Paul ${n} Acidic card${n > 1 ? 's' : ''}. He pays ${2 * n} Capital and calls it human money.`, 'news'); return true;
  }

  /* ---------- research ---------- */
  const HOMEN = num('HOMEN', 5), SMALLN = num('SMALLN', 5), DEEPT = num('DEEPT', 2), DEEPK = num('DEEPK', 2);
  function condOK(G, p, cond) { // the condition on a research bonus, checked every time you research
    const pi = G.players.indexOf(p), home = homeOf(G, pi);
    if (cond === 'home5') return !!home && (home.tok[pi] || 0) >= HOMEN;
    if (cond === 'small5') return controlled(G, pi) < SMALLN;
    if (cond === 'deep3') return G.map.cells.filter(c => (c.tok[pi] || 0) >= DEEPT).length >= DEEPK;
    if (cond === 'nohot') return !G.map.cells.some(c => c.hot && ownerOf(c) === pi);
    if (cond === 'noadv') return !p.adv.length;
    return false;
  }
  const rbonus = (G, p, f) => (p.tiles || []).reduce((a, c) => a + (c.bonus && c.bonus.f === f && condOK(G, p, c.bonus.cond) ? c.bonus.n : 0), 0);
  const SLOTS5 = [...FAMS, 'any'];
  const shelfOf = p => { const s = { sweet: 0, sour: 0, herb: 0, fizz: 0, any: 0 }; for (const m of p.shelf || []) for (const f of m.inp) s[f]++; return s; }; // what your scrapped machines contribute to research, for good
  function needFor(G, p, card) { // short: named families your shelf does not cover; any: wildcard cards to pay; ram: shortfall Priya Raman lets you pay in cards
    const sh = shelfOf(p), need = { short: {}, shortN: 0, any: 0, ram: 0 };
    for (const f of FAMS) { const x = Math.max(0, (card.cost[f] || 0) - sh[f]); need.short[f] = x; need.shortN += x; }
    need.any = Math.max(0, (card.cost.any || 0) - sh.any - (hasA(p, 'liz') ? 1 : 0)); // wildcard machines on the shelf, and Elizabeth H., take cards off the wildcard part
    need.ram = Math.min(need.shortN, hasA(p, 'raman') ? 2 : 0);
    return need;
  }
  // how many cards of any kind researching this card takes, or null if your shelf falls short
  function payCount(G, p, card, patent) {
    const n = needFor(G, p, card); let short = n.shortN - n.ram, cards = n.any + n.ram, wild = patent ? 1 : 0;
    if (short > wild) return null; wild -= short; if (wild > 0 && cards > 0) { cards--; wild--; } // a patent covers one missing named family, or one card
    return cards;
  }
  // the cards you would discard to research this card, or null if your shelf falls short. A player may name them (choice:
  // a list of families); otherwise the cards come from the families you hold most of
  function payFor(G, p, card, patent, choice) {
    const cards = payCount(G, p, card, patent); if (cards === null) return null;
    if (choice) { if (choice.length !== cards) return null; const h = { ...p.hand }; for (const f of choice) { if (!(h[f] > 0)) return null; h[f]--; } return choice.slice(); }
    const h = { ...p.hand }, use = [];
    for (let k = 0; k < cards; k++) { const g = FAMS.slice().sort((a, b) => h[b] - h[a])[0]; if (h[g] > 0) { h[g]--; use.push(g); } else return null; }
    return use;
  }
  const resCards = p => (p.tiles || []).length;
  function canResearch(G, k, patent, choice) {
    const p = P(G), c = G.rrow[k]; if (myTurn(G, 'biz')) return no(myTurn(G, 'biz')); if (p.jail) return no('In custody');
    if (!c) return no('No card there');
    if (c.win && resCards(p) < WINNEED) return no(`Needs ${WINNEED} research cards in hand`);
    return payFor(G, p, c, patent, choice) ? yes() : no(choice ? 'Those cards do not pay for it' : 'Not enough ingredients');
  }
  function research(G, k, patent, choice) {
    const x = canResearch(G, k, patent, choice); if (!x.ok) return false; const p = P(G), pi = G.turn, t = G.rrow[k];
    { const pay = payFor(G, p, t, patent, choice); acc(p, 'resCards', pay.length); acc(p, 'resN', 1); acc(p, 'resStars', t.st || 0); spend(G, p, pay, 'rcard-' + k); } G.rrow.splice(k, 1); G.rrow.push(null); ops += 2; // the row slides along; the new card comes in at the far end
    if (t.st) fx(G, { k: 'star', n: t.st, from: 'rcard-' + k, to: 'stars-' + pi });
    fx(G, { k: 'mach', m: { name: t.name, tier: t.tier }, from: 'rcard-' + k, to: 'tiles-' + pi });
    (p.tiles = p.tiles || []).push({ ...t, cost: { ...t.cost }, get: { ...t.get }, r: G.round, copied: false }); // the card goes into your hand
    G.st = G.st || {}; G.st.researched = (G.st.researched || 0) + 1;
    if (t.win) { log(G, pi, `${p.name} completes the Secret Formula. Nobody will ever make lemonade without them again.`, 'win'); G.memoQ = []; G.choice = null; G.pending = null; finish(G, [pi]); return true; }
    let st = t.st, extra = 0; while (st > 0 && p.stars < MAXSTAR) { p.stars++; st--; } extra = st;
    give(G, pi, t.get, 'tile'); if (extra) p.cash += extra * STARCASH;
    if (IMPON && !t.win) { const n = IMPR[t.tier - 1] || 0; if (n) { p.imp = (p.imp || 0) + n; acc(p, 'impGot', n); } } // the right to place capital tokens
    if (t.st) pour(G, pi, 0);
    if (hasA(p, 'kevin') && t.st >= 2) { p.loy += 2; lt(G, pi, 'adv', 2); fx(G, { k: 'heart', n: 2, from: 'stars-' + pi, to: 'loy-' + pi }); }
    if (hasA(p, 'liz')) { log(G, pi, 'Elizabeth H. announces the results before running the test.', 'dirty'); expose(G, pi, 2); }
    log(G, pi, t.bonus ? `${p.name} researches ${t.name.toLowerCase()}: +${t.bonus.n} ${t.bonus.f === 'any' ? 'of any family' : FNAME[t.bonus.f]} for future research while ${CONDS[t.bonus.cond]}.` : t.st ? `${p.name}'s formula earns ${t.st === 1 ? 'half a star' : t.st === 2 ? 'a star' : (t.st / 2) + ' stars'}. It is now a ${starText(p.stars)} product, and its era track is ${trackLen(p)} long.` : `${p.name} researches ${t.name.toLowerCase()}.`, t.st ? 'win' : 'news');
    if (G.winner !== null) return true;
    if (refillRow(G, RROW - 1, pi)) { G.offer.next = !patent; return true; } // an advisor turned up: the researcher decides before the turn ends
    if (!patent) next(G); return true;
  }
  /* ---------- the map ---------- */
  function canPlace(G, id) {
    const p = P(G), c = cell(G, id); if (myTurn(G, 'place')) return no(myTurn(G, 'place'));
    if (!c) return no('No market');
    const k = tokCost(G, G.turn, c); return p.loy < k ? no(`Needs ${k} loyalty`) : yes({ loy: k });
  }
  function canImprove(G, id) { const p = P(G), c = cell(G, id); if (myTurn(G, 'place')) return no(myTurn(G, 'place')); if (!IMPON) return no('Not in this game');
    if (!c) return no('No market'); if (!(p.imp > 0)) return no('Research earns capital tokens'); if (ownerOf(c) !== G.turn) return no('You must control the market'); if ((c.imp || 0) >= 3) return no('Fully improved'); return yes(); }
  function improve(G, id) {
    if (!canImprove(G, id).ok) return false; const p = P(G), c = cell(G, id); const y = yields(c)[c.imp || 0];
    c.imp = (c.imp || 0) + 1; p.imp--; acc(p, 'impN', 1); acc(p, 'impY', y); ops++; fx(G, { k: 'coin', n: 1, from: 'cash-' + G.turn, to: 'cell-' + c.id });
    log(G, G.turn, `${p.name} invests in ${c.name}: it now pays ${cellYield(c)} Capital at payday to whoever controls it.`, 'up');
    next(G); return true;
  }
  function put(G, pi, c) { // one token arrives; a bonus goes to whoever arrives first
    const p = G.players[pi], before = ownerOf(c), empty = !Object.keys(c.tok).length; c.tok[pi] = toks(c, pi) + 1; ops++;
    if (hasA(p, 'pioneer') && empty) { p.cash += 1; fx(G, { k: 'coin', n: 1, from: 'cell-' + c.id, to: 'cash-' + pi }); }
    if (hasA(p, 'raider') && before !== null && before !== pi && ownerOf(c) === pi) { p.cash += 3; G.st = G.st || {}; G.st.raids2 = (G.st.raids2 || 0) + 1; fx(G, { k: 'coin', n: 3, from: 'cell-' + c.id, to: 'cash-' + pi }); log(G, pi, `${p.name} takes ${c.name} from ${G.players[before].name}. The Raider collects.`, 'dirty'); } fx(G, { k: 'tok', pi, n: 1, from: 'loy-' + pi, to: 'cell-' + c.id });
    if (c.bonus) { give(G, pi, c.bonus, 'bonus'); c.bonus = null; }
  }
  function place(G, id) {
    const x = canPlace(G, id); if (!x.ok) return false; const p = P(G), c = cell(G, id);
    const far = hasA(p, 'realtor') && reach(G, G.turn, c) >= 3;
    { const o = ownerOf(c); acc(p, o === null ? (Object.keys(c.tok).length ? 'tokContest' : 'tokGrow') : o === G.turn ? 'tokDef' : 'tokAtk', 1); acc(p, 'loySpent', x.cost.loy); if (c.hot) acc(p, 'tokHot', 1); if (c.rough) acc(p, 'tokRough', 1); }
    p.loy -= x.cost.loy; put(G, G.turn, c);
    log(G, G.turn, `${p.name} places a token in ${c.name}.`, 'up');
    if (far) expose(G, G.turn, 1);
    next(G); return true;
  }

  /* ---------- influence and Heat ---------- */
  function drawInf(G, pi, n) {
    const p = G.players[pi];
    for (let k = 0; k < n; k++) {
      if (!G.ideck.length) { G.ideck = shuffle(G.idisc); G.idisc = []; } const c = G.ideck.pop(); if (!c) return;
      p.inf.push(c); ops++; fx(G, { k: 'inf', from: 'infdeck', to: 'inf-' + pi });
      log(G, pi, `${p.name} acquires influence.${c.x ? ` The Heat rises by ${c.x}.` : ''}`, 'inf');
      expose(G, pi, c.x);
    }
  }
  function expose(G, pi, x) { // add Heat to the table; whoever brings it to the raid line is raided, and the heat dies down
    if (!x) return; G.heat += x; ops++; fx(G, { k: 'heat', n: x, from: 'seat-' + pi, to: 'heat' });
    if (G.heat < tolerance(G)) return;
    if (TRACE) { const ctl = G.players.map((_, j) => controlled(G, j)), mtop = Math.max(...ctl); (G.rlog = G.rlog || []).push({ pi, r: G.round, mapLead: ctl[pi] === mtop && ctl.filter(x => x === mtop).length === 1 }); }
    if (G.players[pi].judge) { G.players[pi].judge = false; G.heat = 1; G.st = G.st || {}; G.st.judged = (G.st.judged || 0) + 1; log(G, pi, `A friendly judge dismisses the case against ${G.players[pi].name}. The Heat falls to 1.`, 'news'); return; }
    G.players[pi].raided = true; G.heat = 0; ops++; G.st = G.st || {}; G.st.raids = (G.st.raids || 0) + 1;
    log(G, pi, `Federal agents raid ${co(G, pi)}. The founder sits out the next market in custody unless bail is posted. The heat dies down.`, 'alarm');
  }
  const infCost = p => INFC;
  function canLobby(G) { const p = P(G); return myTurn(G, 'biz') ? no(myTurn(G, 'biz')) : p.jail ? no('In custody') : p.cash < infCost(p) ? no("Can't afford") : yes({ cash: infCost(p) }); }
  function lobby(G) { const x = canLobby(G); if (!x.ok) return false; P(G).cash -= x.cost.cash; acc(P(G), 'inf', x.cost.cash); drawInf(G, G.turn, 1); next(G); return true; }
  const bailCost = (G, p) => BAILB + bandOf(p.era);
  function canBail(G) { const p = P(G); return myTurn(G, 'biz') ? no(myTurn(G, 'biz')) : !p.jail ? no('Not in custody') : p.cash < bailCost(G, p) ? no("Can't afford") : yes({ cash: bailCost(G, p) }); }
  function bail(G) { const x = canBail(G); if (!x.ok) return false; const p = P(G); p.cash -= x.cost.cash; acc(p, 'bail', x.cost.cash); p.jail = false; log(G, G.turn, `${p.name} posts bail.`, 'bad'); return true; }

  function canPlay(G, u, target, extra) {
    const p = P(G), c = p.inf.find(k => k.u === u), pi = G.turn; if (myTurn(G)) return no(myTurn(G)); if (G.phase === 'stand') return no('Not yet');
    if (!c) return no('No such card'); if (p.jail && G.phase === 'biz') return no('In custody');
    const d = ICARD[c.t], need = d.extra || 0;
    if ((extra || []).filter(v => v !== u && p.inf.some(k => k.u === v)).length < need) return no(`Mark ${need} more card${need > 1 ? 's' : ''} to discard`);
    const t = c.t;
    if (d.leader) { const q = G.players[target]; if (!q || target === pi) return no('Choose a rival'); const top = Math.max(...G.players.map((_, i) => controlled(G, i))), k = controlled(G, target);
      if (k < top || k <= controlled(G, pi)) return no('Only the company controlling the most markets, and more than you');
      if (t === 'formula' && !q.stars) return no('Their product has no stars to steal');
      if (t === 'antitrust' && !G.map.cells.some(c => ownerOf(c) === target)) return no('They control no markets'); }
    if (t === 'recall' || t === 'spy') { const q = G.players[target]; if (!q || target === pi) return no('Choose a rival'); if (t === 'spy' && !handSize(q)) return no('Their hand is empty'); if (t === 'recall' && !q.prog) return no('Nothing on their track'); }
    if (t === 'ha') { const m = cell(G, target); if (!m) return no('Choose a market'); if (!Object.keys(m.tok).some(k => +k !== pi)) return no('No rival tokens there'); }
    if (t === 'contract') { const m = cell(G, target); if (!m) return no('Choose a market'); }
    if (t === 'patent') { if (G.phase !== 'biz') return no('Only in the market'); const tl = G.rrow[target]; if (!tl) return no('Choose a research card'); const r = canResearch(G, target, true); if (!r.ok) return r; }
    if (d.target === 'rtile') { const q = G.players[Math.floor(target / 1000)], tl = q && (q.tiles || [])[target % 1000];
      if (!q || Math.floor(target / 1000) === pi) return no("Choose a card in a rival's hand"); if (!tl) return no('No such tile'); if (tl.copied) return no('Already copied');
      if (!tl.st && !Object.keys(tl.get).length) return no('That card has no reward to copy'); }
    if (t === 'judge' && p.judge) return no('The judge is already on call');
    if ((t === 'proxy' || t === 'buyback') && (p.cont || 0) >= CMAX) return no('Your control is full');
    if (t === 'buyback' && p.cash < 4) return no("Can't afford");
    if (t === 'act' && !actTargets(G, pi).length) return no('No rival tokens next to your markets');
    if (t === 'regime' && G.limon === pi) return no('San Limón is already yours');
    return yes();
  }
  const actTargets = (G, pi) => G.map.cells.filter(c => Object.keys(c.tok).some(k => +k !== pi) && G.map.cells.some(o => ownerOf(o) === pi && Math.abs(o.c - c.c) + Math.abs(o.r - c.r) === 1)).slice(0, 3);
  function strip(G, c, pi, n) { // remove up to n rival tokens from a market, the strongest rival's first
    let k = 0; while (k < n) { let w = null, v = 0; for (const q in c.tok) if (+q !== pi && c.tok[q] > v) { v = c.tok[q]; w = +q; } if (w === null) break; c.tok[w]--; if (!c.tok[w]) delete c.tok[w]; k++; fx(G, { k: 'tok', pi: w, n: 1, from: 'cell-' + c.id, to: 'cell-' + c.id, gone: true }); }
    return k;
  }
  function play(G, u, target, extra) {
    const x = canPlay(G, u, target, extra); if (!x.ok) return false;
    const p = P(G), pi = G.turn, c = p.inf.find(k => k.u === u), d = ICARD[c.t];
    const gone = [c, ...p.inf.filter(k => (extra || []).includes(k.u) && k.u !== u).slice(0, d.extra || 0)];
    p.inf = p.inf.filter(k => !gone.includes(k)); G.idisc.push(...gone.filter(g => !ICARD[g.t].memo)); ops++; // a kept memo is not an influence card: it leaves the game
    gone.forEach(g => fx(G, { k: 'inf', face: g.t, from: 'inf-' + pi, to: 'infdisc' }));
    const t = c.t;
    if (t === 'recall') { const q = G.players[target], k = Math.min(5, q.prog); q.prog -= k; log(G, pi, `${q.name}'s product is recalled. ${k} pitchers come off its era track.`, 'dirty'); }
    else if (t === 'ha') { const m = cell(G, target), k = strip(G, m, pi, 2); log(G, pi, `${p.name} buys out ${k} rival distributor${k > 1 ? 's' : ''} in ${m.name}.`, 'dirty'); }
    else if (t === 'reverse' || t === 'leak') { const q = G.players[Math.floor(target / 1000)], tl = q.tiles[target % 1000]; tl.copied = true;
      let st = tl.st; while (st > 0 && p.stars < MAXSTAR) { p.stars++; st--; } if (st) p.cash += st * STARCASH;
      if (tl.st) { fx(G, { k: 'star', n: tl.st, from: 'seat-' + Math.floor(target / 1000), to: 'stars-' + pi }); pour(G, pi, 0); }
      give(G, pi, tl.get, 'copy'); G.st = G.st || {}; G.st.copies = (G.st.copies || 0) + 1;
      log(G, pi, `${p.name} copies ${q.name}'s research${tl.st ? `: ${tl.st === 1 ? 'half a star' : 'a whole star'}` : ''}.`, 'dirty');
      if (t === 'leak') riskHeat(G, pi, 'A kept memo'); }
    else if (t === 'judge') { p.judge = true; log(G, pi, `${p.name} has a friendly judge on call.`, 'news'); }
    else if (t === 'subsidy') { p.cash += 4; log(G, pi, `${p.name} receives a subsidy.`, 'news'); }
    else if (t === 'contract') { const m = cell(G, target); put(G, pi, m); log(G, pi, `${p.name} is awarded a government contract in ${m.name}.`, 'up'); }
    else if (t === 'spy') { const q = G.players[target]; let k = 0; while (k < 2 && handSize(q)) { const pool = FAMS.flatMap(f => Array(q.hand[f]).fill(f)); const f = pool[Math.floor(Math.random() * pool.length)]; q.hand[f]--; p.hand[f]++; k++; } log(G, pi, `${p.name} acquires ${k} of ${q.name}'s ingredients. Nobody can prove anything.`, 'dirty'); }
    else if (t === 'patent') { log(G, pi, `${p.name} files a patent.`, 'news'); research(G, target, true); }
    else if (t === 'proxy') { give(G, pi, { cont: 2 }); log(G, pi, `${p.name} wins a proxy vote and takes back the board.`, 'up'); }
    else if (t === 'buyback') { p.cash -= 4; give(G, pi, { cont: CMAX }); log(G, pi, `${p.name} buys back its shares.`, 'up'); }
    else if (t === 'viral') { p.loy += 3; lt(G, pi, 'inf', 3); log(G, pi, `${p.name}'s campaign goes viral.`, 'up'); }
    else if (t === 'act') { const cs = actTargets(G, pi); cs.forEach(m => strip(G, m, pi, 1)); log(G, pi, `An Act of Congress finds that ${cs.length} market${cs.length > 1 ? 's' : ''} would be better served by ${p.name}.`, 'dirty'); }
    else if (t === 'formula') { const q = G.players[target]; q.stars--; if (p.stars < MAXSTAR) p.stars++; else p.cash += STARCASH; pour(G, pi, 0); fx(G, { k: 'star', n: 1, from: 'stars-' + target, to: 'stars-' + pi }); log(G, pi, `${p.name} acquires ${q.name}'s formula. Half a star changes hands.`, 'dirty'); }
    else if (t === 'antitrust') { const q = G.players[target], cs = G.map.cells.filter(c => ownerOf(c) === target).sort((a, b) => a.tok[target] - b.tok[target]).slice(0, 3);
      cs.forEach(c => { c.tok[target]--; if (!c.tok[target]) delete c.tok[target]; fx(G, { k: 'tok', pi: target, n: 1, from: 'cell-' + c.id, to: 'cell-' + c.id, gone: true }); });
      log(G, pi, `${p.name}'s lobbyists win an antitrust suit against ${q.name}. ${cs.length} market${cs.length > 1 ? 's' : ''} must be divested.`, 'dirty'); }
    else if (t === 'regime') { G.limon = pi; log(G, pi, `Orderly transition of government in San Limón. The new president thanks ${p.name} by name.`, 'dirty'); }
    next(G); return true;
  }

  /* ---------- filing ---------- */
  function canFile(G, extra) {
    if (WIN === 'era') return no('The first company to era ' + ERAS + ' wins');
    const p = P(G); if (myTurn(G, 'place')) return no(myTurn(G, 'place')); if (p.filed) return no('Already filed');
    if (controlled(G, G.turn) < FM) return no(`Control ${FM} markets first`);
    return (extra || []).filter(u => p.inf.some(k => k.u === u)).length < FILECARDS ? no(`Mark ${FILECARDS} influence cards`) : yes();
  }
  function file(G, extra) {
    const x = canFile(G, extra); if (!x.ok) return false; const p = P(G);
    const gone = p.inf.filter(k => extra.includes(k.u)).slice(0, FILECARDS); p.inf = p.inf.filter(k => !gone.includes(k)); G.idisc.push(...gone);
    p.filed = true; log(G, G.turn, `${co(G, G.turn)} files for monopoly. It must still control ${FM} markets at payday.`, 'alarm');
    next(G); return true;
  }

  /* ---------- gains ---------- */
  const lt = (G, pi, src, n) => { if (TRACE && n) (G.lt = G.lt || []).push({ pi, r: G.round, src, n }); }; // loyalty trace, by source
  function give(G, pi, o, src) {
    const p = G.players[pi]; if (o && o.loy) lt(G, pi, src || 'other', o.loy);
    for (const r in o || {}) {
      const n = o[r]; if (!n) continue;
      if (r === 'cash' || r === 'loy') p[r] += n;
      else if (r === 'out') pour(G, pi, n, src);
      else if (r === 'card') drawFree(G, p, n);
      else if (r === 'inf') drawInf(G, pi, n);
      else if (r === 'calm') G.heat = Math.max(0, G.heat - n);
      else if (r === 'cont') { p.cont = Math.min(CMAX, (p.cont || 0) + n); pour(G, pi, 0); } // control back on the track: it may finish an era
      else if (r === 'free' || r === 'rerun') p[r] = (p[r] || 0) + n; // kept for later: a run without cards, or a second run of a machine
      ops++;
    }
  }

  /* ---------- payday ---------- */
  function payday(G) {
    const order = placeOrder(G);
    if (TRACE) (G.snap = G.snap || []).push({ r: G.round, ps: G.players.map((q, i) => ({ era: q.era, prog: q.prog, len: trackLen(q), stars: q.stars, cash: q.cash, hand: handSize(q), ctl: controlled(G, i), nm: q.mach.length, cap: q.mach.reduce((a, m) => a + m.out, 0), idle: q.mach.filter(m => !m.ran).length, idleCap: q.mach.filter(m => !m.ran).reduce((a, m) => a + m.out, 0), adv: q.adv.length })) });
    G.players.forEach((q, i) => { q.ctl = controlled(G, i); q.cash += income(q.ctl) + impIncome(G, i) + (hasA(q, 'chad') ? 1 : 0) + (hasA(q, 'paul') ? q.hand.sour : 0) + (hasA(q, 'saul') ? Math.floor(G.heat / SAULD) : 0); ops += 2; fx(G, { k: 'coin', n: income(q.ctl), from: 'map', to: 'cash-' + i });
      if (hasA(q, 'tanner')) q.cash -= Math.ceil(income(q.ctl) / 2); });
    log(G, null, `Payday. ${G.players.map((q, i) => `${q.name} controls ${q.ctl}`).join(', ')}.`, 'bank');
    for (const c of G.map.cells) { const o = c.hot ? ownerOf(c) : null; if (o === null || G.winner !== null) continue; // hot spots pay their holder every payday
      fx(G, { k: 'pit', n: c.hot.out, from: 'cell-' + c.id, to: 'prog-' + o }); log(G, o, `${G.players[o].name}'s stand in ${c.name} pours ${c.hot.out} pitchers.`, 'up'); pour(G, o, c.hot.out, 'hot'); }
    if (G.winner !== null) return;
    G.players.forEach((q, i) => {
      if (hasA(q, 'dwarf')) { const k = G.map.cells.filter(c => c.rough && ownerOf(c) === i).length; if (k) { q.cash += 2 * k; log(G, i, `Brokk Stonebeard's mines pay ${q.name} ${2 * k} Capital.`, 'up'); } }
      if (hasA(q, 'qa') && G.winner === null) { const k = Math.min(4, G.map.cells.filter(c => (c.tok[i] || 0) >= 2).length); if (k) { log(G, i, `Quality Assurance approves ${k} market${k > 1 ? 's' : ''}: ${k} pitcher${k > 1 ? 's' : ''}.`, 'up'); pour(G, i, k, 'qa'); } } });
    if (G.winner !== null) return;
    const filers = G.players.map((q, i) => i).filter(i => G.players[i].filed);
    const good = filers.filter(i => G.players[i].ctl >= FM);
    filers.filter(i => !good.includes(i)).forEach(i => { G.players[i].filed = false; log(G, i, `${co(G, i)}'s monopoly filing is dismissed. It no longer controls ${FM} markets.`, 'bad'); });
    if (WIN !== 'era' && good.length) return finish(G, good);
    // records are gone: memos were queued as companies moved up eras
    // attrition: in a contested market the leader keeps its margin and everyone else goes home; a tie empties it
    for (const c of G.map.cells) {
      const ks = Object.keys(c.tok).map(Number); if (ks.length < 2) continue;
      const w = ownerOf(c), tot = ks.reduce((a, k) => a + c.tok[k], 0); ops++;
      if (w === null) { ks.forEach(k => fx(G, { k: 'tok', pi: k, n: c.tok[k], from: 'cell-' + c.id, to: 'cell-' + c.id, gone: true })); c.tok = {}; continue; }
      const keep = hasA(G.players[w], 'lawyer2') ? c.tok[w] : c.tok[w] - (tot - c.tok[w]); ks.forEach(k => { const back = k === w ? c.tok[w] - keep : c.tok[k]; if (back) fx(G, { k: 'tok', pi: k, n: back, from: 'cell-' + c.id, to: 'cell-' + c.id, gone: true }); }); c.tok = { [w]: keep };
    }
    if (G.mkt.length) { const old = G.mkt.shift(); fx(G, { k: 'mach', m: { name: old.name, tier: old.tier }, from: 'mkt-0', to: 'mdeck', gone: true }); const had = G.mkt.slice(); refillM(G); G.mkt.forEach((x, k) => { if (!had.includes(x)) fx(G, { k: 'mach', m: { name: x.name, tier: x.tier }, from: 'mdeck', to: 'mkt-' + k, slide: true }); }); }
    for (let d = 0; d < PDISC; d++) { const k = G.rrow.findIndex(c => c && !c.win); if (k < 0) break; const old = G.rrow.splice(k, 1)[0]; fx(G, { k: 'mach', m: { name: 'Experiment', tier: old.tier }, from: 'rcard-' + k, to: 'rdeck', gone: true }); G.rrow.push(null); refillRow(G, RROW - 1, null); } // the oldest research cards are discarded
    G.round++;
    if (G.round > MAXROUND) { if (WIN === 'era') return finish(G, G.players.map((_, i) => i)); const best = Math.max(...G.players.map(q => q.ctl)); return finish(G, G.players.map((_, i) => i).filter(i => G.players[i].ctl === best)); }
    nextMemo(G);
  }
  function finish(G, cands) {
    const key = i => { const q = G.players[i]; return WIN === 'era' ? q.era * 1e6 + q.prog * 1e3 + q.cash - G.order.indexOf(i) / 10 : q.ctl * 10000 + (q.cash + q.inf.length) * 10 - G.order.indexOf(i); };
    G.winner = cands.sort((a, b) => key(b) - key(a))[0]; G.phase = 'over';
    log(G, G.winner, WIN === 'era' && G.players[G.winner].era >= ERAS ? `${co(G, G.winner)} reaches era ${ERAS}. All the lemonade on Earth is theirs.` : `${co(G, G.winner)} has a monopoly on lemonade.`, 'win');
  }
  function nextMemo(G) {
    const m = G.memoQ.shift();
    if (!m) { G.pending = null; return startPhase(G, 'biz'); }
    G.pending = m; G.phase = 'memo'; G.turn = m.pi;
  }
  function canChoose(G, i) {
    const m = G.pending && MEMOS[G.pending.id], o = m && m.opts[i]; if (!o) return no('No such option');
    const p = G.players[G.pending.pi]; for (const r in o.cost || {}) if (p[r] < o.cost[r]) return no("Can't afford");
    return yes(o.cost);
  }
  function riskHeat(G, pi, title) { // turn over the top influence card for its Heat, show it to the table, bury it
    const p = G.players[pi]; if (!G.ideck.length) { G.ideck = shuffle(G.idisc); G.idisc = []; }
    const c = G.ideck.pop();
    if (c) { G.ideck.unshift(c); const was = p.raided;
      log(G, pi, c.x ? `Word gets around. The Heat rises by ${c.x}.` : 'Nobody notices.', c.x ? 'dirty' : 'news');
      expose(G, pi, c.x); G.reveal = { n: (G.reveal ? G.reveal.n : 0) + 1, pi, t: c.t, x: c.x, raid: !was && p.raided, memo: title }; }
  }
  function choose(G, i) {
    if (!canChoose(G, i).ok) { if (i !== -1 || !G.pending) return false; }
    const pi = G.pending.pi, p = G.players[pi], m = MEMOS[G.pending.id], o = m.opts[i];
    if (o) {
      for (const r in o.cost || {}) p[r] -= o.cost[r];
      if (TRACE) { const ctl = G.players.map((_, j) => controlled(G, j)), mtop = Math.max(...ctl); (G.clog = G.clog || []).push({ pi, r: G.round, id: G.pending.id, opt: i, risk: !!o.risk, gain: { ...(o.gain || {}) }, cost: { ...(o.cost || {}) }, mapLead: ctl[pi] === mtop && ctl.filter(x => x === mtop).length === 1 }); }
      give(G, pi, o.gain, 'memo');
      log(G, pi, `${co(G, pi)}, re: ${m.title.toLowerCase()}. Resolved: ${o.label.toLowerCase()}.`, 'memo');
      if (o.keep) { p.inf.push({ u: 100000 + (G.keepN = (G.keepN || 0) + 1), t: o.keep, x: 0 }); fx(G, { k: 'inf', from: 'memo', to: 'inf-' + pi }); }
      if (o.risk) { riskHeat(G, pi, m.title);
        G.st = G.st || {}; G.st.villain = (G.st.villain || 0) + 1;
      }
    }
    nextMemo(G); return true;
  }

  /* ---------- bots ----------
     Every judgement a bot makes reads a gene: gv(p, key). A bot with p.gen (a genome) uses its genes;
     a bot without one uses the legacy value for its style (mfg, prd, dis, gen, flex), which reproduces
     the old hand-written bots exactly. GENES lists every gene with its range and group, for the tuner. */
  const KW = num('KW', 1), RC = num('RC', 10);
  const LEG = { // legacy gene values; f(p, ms) gets the player and its map style
    stv: () => +(ENV.STV || 1.8), rOut: () => 0.55, rFree: () => 3.5, rRerun: () => 2.5, nbv: () => +(ENV.BONV || 3), fchase: () => 1.5,
    resBias: p => p.spec === 'prd' ? +(ENV.PRDF || 2) : 0, rcost: () => +(ENV.RCOST || 0.9), missW: () => 1.6,
    resStock: p => p.spec === 'prd' || p.spec === 'gen' ? 99 : p.spec === 'mfg' ? +(ENV.MFGST || 2) : 4, resFirst: p => p.spec === 'prd' ? 1 : 0,
    pRun: () => 5, pRes: () => 4, pBuy: () => 3, pAdv: () => 2, pIng: () => 1,
    mGain: () => 3, mRes: p => p.spec === 'mfg' || p.spec === 'flex' ? +(ENV.MFGRES || 4) : 2, mFullCash: p => p.spec === 'mfg' || p.spec === 'flex' ? -99 : 4, freeMin: () => 4,
    pileThr: () => 3.5, drawCash: () => 8, handCap: () => 8,
    advMfg: (p) => advLeg(p, 'mfg'), advPrd: (p) => advLeg(p, 'prd'), advDis: (p) => advLeg(p, 'dis'), advGen: (p) => advLeg(p, 'gen'), advAll: (p) => advLeg(p, 'all'),
    advDef: (p, ms) => ms === 'def' ? 5.6 : ms === 'none' ? 1 : 3.5, advAtk: (p, ms) => ms === 'atk' ? 5.6 : ms === 'none' ? 1 : 3.5, advGrow: (p, ms) => ms === 'grow' ? 5.6 : ms === 'none' ? 1 : 3.5,
    advThr: () => 4.5, advRes: () => +(ENV.ARES || 9), advResMap: () => +(ENV.MSRES || 2), offerRes: () => 4, ccv: () => +(ENV.CCV || 0.5), amax: () => +(ENV.AMAX || 2), advScrap: p => p.spec === 'mfg' ? 2 : p.spec === 'dis' ? 7 : 4,
    mLoy: () => 1.6, mCash: () => 1, mCard: () => 1.4, mCont: () => 2.5, heatAv: () => RC, mKeep: () => +(ENV.KEEPV || 3),
    gKW: () => KW, gCapture: () => 10, gDefend: () => 6, gSpare: p => p.spec === 'dis' ? 0.5 : -99, gBonusCell: () => 2, gHot: () => 2, gOutpost: (p, ms) => ms === 'grow' ? 5 : 3,
    gDeep: (p, ms) => ms === 'def' ? 2.5 : 0, gRough: (p, ms) => ms === 'def' ? 1.5 : 0, gAtk: (p, ms) => ms === 'atk' ? 1.5 : 0, gGrow: (p, ms) => ms === 'grow' ? 1 : 0, gPlaceMin: () => 0,
    scrapThr: () => 99, scrapOut: () => 0.5, mFam: () => 0, rImp: () => 1.5, gImp: () => 0.6, impW: () => 2, impSafe: () => 1,
    lobbyMap: p => p.spec === 'dis' ? 1 : 0, lobbyRes: () => 2, bailRes: () => 6, stCenter: () => 1, stGap: () => 0.6, stBonus: () => 1 };
  const advLeg = (p, t) => t === 'all' ? 4.6 : t === p.spec ? 5 : p.spec === 'gen' ? 4 : p.spec === 'flex' && t === 'mfg' ? 4 : 1;
  const GENES = [ // key, low, high, group
    ['stv', 0, 6, 'research'], ['rOut', 0, 1.5, 'research'], ['rFree', 0, 7, 'research'], ['rRerun', 0, 6, 'research'], ['nbv', 0, 7, 'research'], ['fchase', 0, 6, 'research'],
    ['resBias', -3, 6, 'research'], ['rcost', 0.2, 2, 'research'], ['missW', 0.3, 4, 'research'], ['resStock', 0, 9, 'research'], ['resFirst', 0, 1, 'research'],
    ['pRun', 0, 6, 'order'], ['pRes', 0, 6, 'order'], ['pBuy', 0, 6, 'order'], ['pAdv', 0, 6, 'order'], ['pIng', 0, 6, 'order'],
    ['mGain', 0, 8, 'machines'], ['mRes', 0, 10, 'machines'], ['mFullCash', -10, 12, 'machines'], ['freeMin', 0, 10, 'machines'],
    ['pileThr', 0.5, 6, 'cards'], ['drawCash', 2, 20, 'cards'], ['handCap', 2, 14, 'cards'],
    ['advMfg', 0, 8, 'advisors'], ['advPrd', 0, 8, 'advisors'], ['advDis', 0, 8, 'advisors'], ['advGen', 0, 8, 'advisors'], ['advAll', 0, 8, 'advisors'],
    ['advDef', 0, 8, 'advisors'], ['advAtk', 0, 8, 'advisors'], ['advGrow', 0, 8, 'advisors'], ['advThr', 2, 8, 'advisors'], ['advRes', 0, 14, 'advisors'], ['advResMap', 0, 10, 'advisors'],
    ['offerRes', 0, 10, 'advisors'], ['ccv', 0, 3, 'advisors'], ['amax', 0, 3, 'advisors'], ['advScrap', 0, 12, 'advisors'],
    ['mLoy', 0, 4, 'memos'], ['mCash', 0, 3, 'memos'], ['mCard', 0, 4, 'memos'], ['mCont', 0, 5, 'memos'], ['heatAv', 0, 25, 'memos'], ['mKeep', 0, 7, 'memos'],
    ['gKW', 0.2, 2.5, 'map'], ['gCapture', 2, 16, 'map'], ['gDefend', 0, 12, 'map'], ['gSpare', -5, 6, 'map'], ['gBonusCell', 0, 6, 'map'], ['gHot', 0, 6, 'map'], ['gOutpost', 0, 10, 'map'],
    ['gDeep', 0, 8, 'map'], ['gRough', 0, 6, 'map'], ['gAtk', 0, 6, 'map'], ['gGrow', 0, 5, 'map'], ['gPlaceMin', -3, 8, 'map'],
    ['rImp', 0, 6, 'improve'], ['gImp', 0, 3, 'improve'], ['impW', 0, 8, 'improve'], ['impSafe', -1, 4, 'improve'],
    ['scrapThr', -2, 12, 'machines'], ['scrapOut', 0, 2, 'machines'], ['mFam', 0, 4, 'machines'],
    ['lobbyMap', 0, 1, 'influence'], ['lobbyRes', 0, 10, 'influence'], ['bailRes', 0, 15, 'influence'], ['stCenter', 0, 3, 'map'], ['stGap', 0, 2, 'map'], ['stBonus', 0, 4, 'map']];
  const MSG = new Set(['advDef', 'advAtk', 'advGrow', 'gOutpost', 'gDeep', 'gRough', 'gAtk', 'gGrow']);
  const gv = (p, k) => p.gen && p.gen[k] !== undefined ? p.gen[k] : LEG[k](p, !MSG.has(k) ? undefined : p.gen ? 'none' : mapStyle(p));
  const legacyGenome = (spec, ms) => { const p = { spec, ms: ms || (['dis', 'gen'].includes(spec) ? 'def' : 'none') }; const g = {}; for (const [k] of GENES) g[k] = LEG[k](p, p.ms); return g; };
  const acc = (p, k, n) => { if (!n) return; const a = p.acct || (p.acct = {}); a[k] = (a[k] || 0) + n; }; // what a company spent where, for measuring strategies

  const deckOdds = G => { const all = G.ideck.length ? G.ideck : G.idisc; const n = all.length || 1; return need => need <= 0 ? 1 : all.filter(c => c.x >= need).length / n; };
  let DECK0 = null;
  function cardValue(G, p, c, seen) { // what a research card is worth to a bot, before its cost. Row cards are face down: a bot only knows the tier
    if (c.win) return resCards(p) >= WINNEED ? 200 : 0;
    if (!seen && !ENV.FACEUP) { DECK0 = DECK0 || researchDeck(); const t = DECK0.filter(d => d.tier === c.tier); return t.reduce((a, d) => a + cardValue(G, p, d, true), 0) / t.length; }
    const st = Math.min(c.st, MAXSTAR - p.stars), g = c.get || {};
    let v = st * gv(p, 'stv') + (c.st - st) * STARCASH * 0.8 + (g.out || 0) * gv(p, 'rOut') + (g.free || 0) * gv(p, 'rFree') + (g.rerun || 0) * gv(p, 'rRerun') + (g.inf || 0) * 1.2;
    if (c.bonus) v += c.bonus.n * (c.bonus.f === 'any' ? 1.5 : 1) * (condOK(G, p, c.bonus.cond) ? gv(p, 'nbv') : nearCond(G, p, c.bonus.cond) ? 1.5 : 0.5);
    if (IMPON && !c.win) v += (IMPR[c.tier - 1] || 0) * gv(p, 'rImp'); // each research also earns capital tokens
    return v + (resCards(p) >= WINNEED - 2 ? gv(p, 'fchase') : 0) + gv(p, 'resBias'); // cards in hand count toward the formula
  }
  const held = (p, cond) => (p.tiles || []).reduce((a, c) => a + (c.bonus && c.bonus.cond === cond ? c.bonus.n : 0), 0);
  const keepOn = p => (p.keep !== undefined ? !!p.keep : !!p.bot && !ENV.NOKEEP) && (p.tiles || []).some(c => c.bonus);
  function nearCond(G, p, cond) { const pi = G.players.indexOf(p), home = homeOf(G, pi);
    if (cond === 'home5') return !!home && (home.tok[pi] || 0) >= 3;
    if (cond === 'deep3') return G.map.cells.filter(c => (c.tok[pi] || 0) >= 2).length >= 3;
    return false; }
  function plan(G, pi) { // the research card a bot is working toward: what its shelf allows, and the cards it still needs
    const p = G.players[pi]; let best = null; const rc = gv(p, 'rcost'), mw = gv(p, 'missW'), hs = handSize(p);
    G.rrow.forEach((c, i) => {
      if (!c) return; if (c.win && resCards(p) < WINNEED) return;
      const n = needFor(G, p, c), gap = n.shortN - n.ram; if (gap > 1) return; // more than a patent can cover: out of reach for now
      const cards = n.any + n.ram, miss = Math.max(0, cards - hs) + gap;
      const v = cardValue(G, p, c) - cards * rc - miss * mw + Math.random() * 0.2;
      if (cardValue(G, p, c) - cards * rc <= 0 && !c.win) return;
      if (!best || v > best.v) best = { i, v, cards, gap, miss };
    });
    return best;
  }
  function wants(G, pi) { // cards the bot would like to hold: fuel for each machine, plus its research route
    const p = G.players[pi], w = { sweet: 0, sour: 0, herb: 0, fizz: 0, any: 0 };
    for (const m of p.mach) for (const f of m.inp) w[f]++;
    const pl = plan(G, pi); if (pl && (G.rrow[pl.i].win || p.stars < gv(p, 'resStock'))) w.any += pl.cards;
    return w;
  }
  function deficit(G, pi) {
    const p = G.players[pi], w = wants(G, pi), d = {};
    let spare = FAMS.reduce((a, f) => a + Math.max(0, p.hand[f] - w[f]), 0);
    for (const f of FAMS) d[f] = Math.max(0, w[f] - p.hand[f]);
    d.any = Math.max(0, w.any - spare); return d;
  }
  function botPick(G, pi) {
    const d = deficit(G, pi), cs = G.choice.cards; let bi = 0, bv = -Infinity;
    cs.forEach((c, i) => { if (c.taken) return; const v = d[c.f] * 3 + (d.any ? 1 : 0) + Math.random() * 0.5 - G.players[pi].hand[c.f] * 0.2; if (v > bv) { bv = v; bi = i; } });
    return bi;
  }
  function memoScore(G, pi, o) {
    const p = G.players[pi], v = { cash: gv(p, 'mCash'), card: gv(p, 'mCard'), loy: gv(p, 'mLoy'), out: 2 / trackLen(p), inf: 1.1, calm: 0.5, free: 3, rerun: 2.5, cont: (p.cont || 0) < CMAX ? gv(p, 'mCont') : 0 };
    let s = 0; for (const r in o.gain || {}) s += (v[r] || 0) * o.gain[r]; for (const r in o.cost || {}) s -= o.cost[r];
    if (o.risk) s -= 0.5 + deckOdds(G)(tolerance(G) - G.heat) * gv(p, 'heatAv');
    if (o.keep) s += gv(p, 'mKeep'); // a later copy of someone's research, less the Heat it will risk
    return s + Math.random() * 0.3;
  }
  const mapStyle = p => p.ms || (p.ms = ['dis', 'gen'].includes(p.spec) ? ['def', 'atk', 'grow'][Math.floor(Math.random() * 3)] : 'none'); // a distribution or generalist bot picks a way to play the map
  function placeValue(G, pi, c, free) {
    const p = G.players[pi], mine = toks(c, pi); let top = 0, who = null;
    if (!p.gen) mapStyle(p);
    for (const k in c.tok) if (+k !== pi && c.tok[k] > top) { top = c.tok[k]; who = +k; }
    const own = ownerOf(c); let v;
    if (own === pi) v = top > 0 && mine - top <= 1 ? gv(p, 'gDefend') : top === 0 && mine < 2 ? gv(p, 'gSpare') : -99; // defend a thin lead
    else if (mine + 1 > top) v = gv(p, 'gCapture') + (top ? 3 : 0);
    else if (mine + 1 === top) v = who !== null && G.players[who].ctl >= p.ctl ? 4 : 2;
    else v = -99;
    if (c.bonus) v += gv(p, 'gBonusCell');
    if (c.hot && v > 0) v += gv(p, 'gHot') * c.hot.out;
    if (v > 0 && cellYield(c)) v += gv(p, 'gImp') * cellYield(c); // markets someone has invested in are worth taking and holding
    const on = outpostN(p), gO = gv(p, 'gOutpost');
    if (own === pi && mine === on - 1 && reach(G, pi, c) >= 2 && v < gO) v = gO; // the token that makes an outpost
    // defence: deepen what you hold, and hold the high ground
    const gD = gv(p, 'gDeep');
    if (own === pi && mine === 1 && (hasA(p, 'qa') || gD > 0) && v < (hasA(p, 'qa') ? 5 : gD)) { const deep = G.map.cells.filter(x => (x.tok[pi] || 0) >= 2).length; if (!hasA(p, 'qa') || deep < 4) v = hasA(p, 'qa') ? 5 : gD; }
    if (c.rough && own !== pi && v > 0) v += hasA(p, 'dwarf') ? 7 : gv(p, 'gRough');
    // attack: take markets that rivals hold
    if (own !== null && own !== pi && mine + 1 > top && v > 0) v += hasA(p, 'raider') ? 3 : gv(p, 'gAtk');
    // growth: claim empty ground
    if (!Object.keys(c.tok).length && v > 0) v += hasA(p, 'pioneer') ? 1.5 : gv(p, 'gGrow');
    // tall play: keep the research cards that reward a small, deep territory switched on
    if (keepOn(p)) { const home = homeOf(G, pi), hm = held(p, 'home5'), sm = held(p, 'small5'), dp = held(p, 'deep3');
      if (hm && c === home && mine < HOMEN + 1 && v < 12) v = 12; // keep the home stack at the notebook's line, with one to spare
      if (dp && own === pi && G.map.cells.filter(x => (x.tok[pi] || 0) >= DEEPT).length < DEEPK + 1) { if (mine === DEEPT - 1 && v < 9) v = 9; else if (mine > 0 && mine < DEEPT - 1 && v < 5) v = 5; }
      if (sm && own !== pi && mine + 1 > top && controlled(G, pi) >= SMALLN - 1) v = -99; // never grow past the notebook's limit
    }
    if (!ENV.NOTALL) { const hm = held(p, 'home5'), sm = held(p, 'small5'), dp = held(p, 'deep3');
      if (hm && c.home === pi && mine < 6 && v < 3 + hm) v = 3 + hm;
      if (dp && own === pi && mine === 2 && v < 2.5 + dp) v = 2.5 + dp;
      if (sm && own !== pi && mine + 1 > top && controlled(G, pi) >= 4 && v > 0) v -= 2.5 * sm; }
    return v - (free ? 0 : tokCost(G, pi, c) * gv(p, 'gKW')) + Math.random() * 0.01; // ties are broken at random, not by board position
  }
  function bestCell(G, pi, free) {
    let best = null; const p = G.players[pi];
    for (const c of G.map.cells) { if (!free && tokCost(G, pi, c) > p.loy) continue; const v = placeValue(G, pi, c, free); if (!best || v > best.v) best = { c, v }; }
    return best;
  }
  const ADVK = { mfg: 'advMfg', prd: 'advPrd', dis: 'advDis', gen: 'advGen', all: 'advAll' }, MSK = { def: 'advDef', atk: 'advAtk', grow: 'advGrow' };
  function advVal(G, pi, a) {
    const p = G.players[pi]; if (p.era < a.era) return -9;
    let v = gv(p, ADVK[a.tag] || 'advAll');
    if (a.ms) { v = gv(p, MSK[a.ms]); // map advisors go to bots playing that way
      if (a.id === 'dwarf') v += G.map.cells.some(c => c.rough && ownerOf(c) === pi) ? 0.5 : -0.5;
      if (a.id === 'qa') v += G.map.cells.filter(c => (c.tok[pi] || 0) >= 2).length >= 2 ? 0.5 : 0; }
    if (a.id === 'boogey') v = G.players.some((q, i) => i !== pi && q.adv.length) ? 5 : 0;
    if (a.id === 'saul') v += G.heat >= 2 ? 0.5 : 0;
    v -= (a.cc || 0) * gv(p, 'ccv'); // control spent lengthens the era track
    return v + Math.random() * 0.5;
  }
  const mapFit = (p, a) => a.ms && gv(p, MSK[a.ms]) >= 5; // a map advisor that fits how this bot plays the map
  function botAdvisor(G, pi) {
    const p = G.players[pi]; if (keepOn(p) && held(p, 'noadv')) return false; if (!ADV || p.adv.length >= gv(p, 'amax') || String(ENV.NOADV || '').split(',').includes(p.spec)) return false;
    let scrap; if (used(p) >= SLOTS) {
      const w = p.mach.map((m, i) => ({ m, i })).sort((a, b) => a.m.out - b.m.out)[0];
      if (!w || w.m.out > gv(p, 'advScrap')) return false; scrap = w.i;
    }
    let best = null; const res = gv(p, 'advRes'), thr = gv(p, 'advThr');
    const resFor = a => mapFit(p, a) ? gv(p, 'advResMap') : res; // a bot playing the map keeps less in reserve for the advisor that fits its plan
    G.arow.forEach((a, k) => { if (!canHire(G, k).ok || p.cash - a.price < resFor(a)) return; const v = advVal(G, pi, a); if (v >= thr && (!best || v > best.v)) best = { k, v }; });
    G.players.forEach((q, qi) => { if (qi === pi) return; q.adv.forEach((a, k) => { if (!canHire(G, k, qi).ok || p.cash - a.price - POACH < res + 2) return; const v = advVal(G, pi, a) - 0.8 + (q.ctl > p.ctl ? 0.6 : 0); if (v >= thr && (!best || v > best.v)) best = { k, v, from: qi }; }); });
    return best ? hire(G, best.k, best.from, scrap) : false;
  }
  function botOffer(G) {
    const o = G.offer, pi = o.pi, p = G.players[pi], v = keepOn(p) && held(p, 'noadv') ? 0 : advVal(G, pi, o.a);
    if (v >= gv(p, 'advThr') && canTakeOffer(G).ok && p.cash - o.a.price >= (mapFit(p, o.a) ? gv(p, 'advResMap') : gv(p, 'offerRes'))) {
      let scrap; if (used(p) >= SLOTS) { const w = p.mach.map((m, i) => ({ m, i })).sort((a, b) => a.m.out - b.m.out)[0]; if (w && w.m.out <= gv(p, 'advScrap')) scrap = w.i; else if (p.adv.length) scrap = 'a0'; else return declineOffer(G); }
      if (takeOffer(G, scrap)) return true; }
    return declineOffer(G);
  }
  function botStep(G) {
    if (G.winner !== null) return false;
    if (G.pending) { const pi = G.pending.pi, m = MEMOS[G.pending.id]; let bi = -1, bv = -1e9; m.opts.forEach((o, i) => { if (canChoose(G, i).ok) { const v = memoScore(G, pi, o); if (v > bv) { bv = v; bi = i; } } }); return choose(G, bi); }
    if (G.offer) return botOffer(G);
    if (G.choice) return pick(G, botPick(G, G.choice.pi));
    const pi = G.turn, p = P(G);
    if (G.phase === 'stand') {
      let best = null; const S = G.map.size, mid = (S - 1) / 2, wc = gv(p, 'stCenter'), wg = gv(p, 'stGap'), wb = gv(p, 'stBonus');
      for (const c of G.map.cells) { if (!canStand(G, c.id).ok) continue; const gap = Math.min(9, ...G.map.cells.filter(o => o.home !== null).map(o => Math.abs(o.c - c.c) + Math.abs(o.r - c.r))); const v = -(Math.abs(c.c - mid) + Math.abs(c.r - mid)) * wc + Math.min(gap, 4) * wg + (c.bonus ? wb : 0) + Math.random() * 0.4; if (!best || v > best.v) best = { c, v }; }
      return stand(G, best.c.id);
    }
    const has = t => p.inf.find(k => k.t === t);
    const tryPlay = (t, target) => { const c = has(t); return c && canPlay(G, c.u, target).ok ? play(G, c.u, target) : false; };
    const calm = k => G.heat + k < tolerance(G);
    if (G.phase === 'biz') {
      if (p.jail) { if (canBail(G).ok && p.cash >= bailCost(G, p) + gv(p, 'bailRes')) bail(G); else return pass(G); }
      const pl = plan(G, pi);
      if (has('subsidy') && tryPlay('subsidy')) return true;
      if (has('viral') && tryPlay('viral')) return true;
      if (has('proxy') && (p.cont || 0) <= CMAX - 2 && tryPlay('proxy')) return true;
      if (has('buyback') && (p.cont || 0) <= CMAX - 3 && p.cash >= 8 && tryPlay('buyback')) return true;
      if (has('judge') && !p.judge && tryPlay('judge')) return true; // put the judge on call as soon as you have one
      const lead = G.players.map((q, i) => i).filter(i => i !== pi).sort((a, b) => G.players[b].ctl - G.players[a].ctl)[0];
      if (lead !== undefined && has('recall') && G.players[lead].prog >= 3 && tryPlay('recall', lead)) return true;
      const top = G.players.map((q, i) => i).filter(i => i !== pi).sort((a, b) => controlled(G, b) - controlled(G, a))[0];
      if (top !== undefined && has('formula') && tryPlay('formula', top)) return true;
      if (has('reverse') || has('leak')) { const tv = tl => tl.st * 4 + Object.entries(tl.get).reduce((a, [r, n]) => a + ({ out: 1, free: 4, rerun: 3, inf: 1.1, calm: 0.5 }[r] || 1) * n, 0); let bt = null;
        G.players.forEach((q, qi) => { if (qi !== pi) (q.tiles || []).forEach((tl, k) => { if (!tl.copied && (!bt || tv(tl) > bt.v)) bt = { v: tv(tl), target: qi * 1000 + k }; }); });
        if (bt && bt.v >= 3 && has('reverse') && tryPlay('reverse', bt.target)) return true;
        if (bt && bt.v >= 3 && has('leak') && calm(2) && tryPlay('leak', bt.target)) return true; }
      if (lead !== undefined && has('spy') && handSize(G.players[lead]) >= 3 && tryPlay('spy', lead)) return true;
      const doResearch = () => { if (!pl) return false; if (pl.miss === 0 && canResearch(G, pl.i).ok) return research(G, pl.i); if (pl.miss === 1 && has('patent') && canPlay(G, has('patent').u, pl.i).ok) return play(G, has('patent').u, pl.i); return false; };
      // scrap a machine when its ingredients unlock a research card worth more than the machine's runs
      const doScrap = () => { const thr = gv(p, 'scrapThr'); if (thr >= 50 || p.mach.length < 1) return false; let best = null;
        p.mach.forEach((m, mi) => { const after = { ...p, shelf: [...(p.shelf || []), m] };
          G.rrow.forEach(c => { if (!c || (c.win && resCards(p) < WINNEED)) return; const now = needFor(G, p, c), then = needFor(G, after, c); if (now.shortN - now.ram <= 0 || then.shortN - then.ram > 0) return;
            const v = cardValue(G, p, c) - (then.any + then.ram) * gv(p, 'rcost') - m.out * gv(p, 'scrapOut'); if (v >= thr && (!best || v > best.v)) best = { mi, v }; }); });
        return best ? scrapM(G, best.mi) : false; };
      if (doScrap()) return true;
      if (gv(p, 'resFirst') >= 0.5 && doResearch()) return true;
      if (controlled(G, pi) >= FM - 1 && p.inf.length < FILECARDS && canLobby(G).ok && (calm(2) || controlled(G, pi) >= FM)) return lobby(G); // the cards that win
      if (hasA(p, 'paul') && canSell(G).ok) { const n = p.hand.sour - wants(G, pi).sour; if (n > 0) sell(G, n); }
      if (hasA(p, 'boogey') && calm(1) && p.hitR !== G.round) { const t = G.players.map((q, i) => ({ q, i })).filter(x => x.i !== pi && x.q.adv.length).sort((a, b) => b.q.ctl - a.q.ctl)[0]; if (t && hit(G, t.i, 0)) return true; }
      const fx2 = p.spec === 'flex' && !p.gen, flexy = m => m.inp.every(f => f === 'any');
      const steps = {
        run: () => { const runs = p.mach.map((m, i) => ({ m, i })).filter(x => canRun(G, x.i).ok).sort((a, b) => b.m.out - a.m.out);
          if (runs.length) return run(G, runs[0].i);
          if (p.rerun) { const x = p.mach.map((m, i) => ({ m, i })).filter(x => canRun(G, x.i, 'rerun').ok).sort((a, b) => b.m.out - a.m.out)[0]; if (x) return run(G, x.i, undefined, 'rerun'); }
          const fm = gv(p, 'freeMin');
          if (p.free) { const x = p.mach.map((m, i) => ({ m, i })).filter(x => canRun(G, x.i, 'free').ok && x.m.out >= fm).sort((a, b) => b.m.out - a.m.out)[0]; if (x) return run(G, x.i, undefined, 'free'); }
          if (hasA(p, 'hal')) { const h = p.mach.map((m, i) => ({ m, i })).filter(x => canRun(G, x.i, true).ok && x.m.out >= 4).sort((a, b) => b.m.out - a.m.out)[0]; if (h) return run(G, h.i, undefined, true); }
          return false; },
        res: () => doResearch(),
        buy: () => { const worst = used(p) < SLOTS ? null : p.mach.reduce((a, m, i) => !a || m.out < a.m.out ? { m, i } : a, null), mg = gv(p, 'mGain'), mr = gv(p, 'mRes');
          const sh = shelfOf(p), mf = gv(p, 'mFam'), mv = m => m.out + mf * new Set(m.inp.filter(f => f !== 'any' && sh[f] < 2)).size;
          const bm = G.mkt.map((m, i) => ({ m, i })).filter(x => canBuy(G, x.i).ok && (fx2 ? flexy(x.m) && (!worst || x.m.out > worst.m.out || !flexy(worst.m)) : (!worst || mv(x.m) >= worst.m.out + mg)) && p.cash - x.m.price >= mr).sort((a, b) => mv(b.m) - mv(a.m))[0];
          const worstFlex = fx2 && used(p) >= SLOTS ? p.mach.reduce((a, m, i) => !a || (!flexy(m) && flexy(a.m)) || (flexy(m) === flexy(a.m) && m.out < a.m.out) ? { m, i } : a, null) : worst;
          if (bm && (used(p) < SLOTS || worstFlex) && (used(p) < SLOTS || p.cash >= bm.m.price + gv(p, 'mFullCash'))) return buy(G, bm.i, worstFlex ? worstFlex.i : undefined);
          return false; },
        adv: () => botAdvisor(G, pi),
        ing: () => { const d = deficit(G, pi), short = FAMS.reduce((a, f) => a + d[f], 0) + d.any;
          if (p.cash >= Math.min(TAKE, drawCost(p))) {
            let bp = null; for (const f of FAMS) { const n = G.piles[f].length; if (!n) continue; const v = PILE1 ? Math.min(1, d[f] + d.any) * 3 + 0.6 : Math.min(n, d[f] + d.any) * 3 + n * 0.6; if (!bp || v > bp.v) bp = { f, v }; }
            if (fx2 && !ENV.FN) { const big = FAMS.filter(f => G.piles[f].length).sort((a, b) => G.piles[b].length - G.piles[a].length)[0]; if (big && (G.piles[big].length >= 2 || short > 0)) return take(G, big); if (!big && short > 0 && canDraw(G).ok && handSize(p) < 2) return draw(G); }
            else if (bp && bp.v >= gv(p, 'pileThr')) return take(G, bp.f);
            if ((!fx2 || ENV.FN) && short > 0 && canDraw(G).ok) return draw(G);
          }
          return false; } };
      const order = ['run', 'res', 'buy', 'adv', 'ing'].map((k, j) => ({ k, w: gv(p, { run: 'pRun', res: 'pRes', buy: 'pBuy', adv: 'pAdv', ing: 'pIng' }[k]) - j * 1e-6 })).sort((a, b) => b.w - a.w);
      for (const s of order) if (steps[s.k]()) return true;
      // influence, toward filing or a fight
      const near = p.ctl >= FM - 2 && p.inf.length < FILECARDS;
      if ((near || (gv(p, 'lobbyMap') >= 0.5 && p.inf.length < 2 && p.ctl >= 3)) && calm(2) && p.cash >= INFC + gv(p, 'lobbyRes') && canLobby(G).ok) return lobby(G);
      if ((!fx2 || ENV.FN) && p.cash >= gv(p, 'drawCash') && canDraw(G).ok && handSize(p) < gv(p, 'handCap')) return draw(G);
      return pass(G);
    }
    if (G.phase === 'place') {
      if (p.inf.length >= FILECARDS && controlled(G, pi) >= FM && canFile(G, p.inf.map(k => k.u)).ok) return file(G, p.inf.map(k => k.u));
      if (has('contract')) { const b = bestCell(G, pi, true); if (b && b.v > 0 && tryPlay('contract', b.c.id)) return true; }
      if (has('regime') && G.limon !== pi && tryPlay('regime')) return true;
      if (has('antitrust')) { const top = G.players.map((q, i) => i).filter(i => i !== pi).sort((a, b) => controlled(G, b) - controlled(G, a))[0]; if (top !== undefined && tryPlay('antitrust', top)) return true; }
      if (has('act') && p.inf.length >= 3 + (p.ctl >= FM - 2 ? FILECARDS : 0) && tryPlay('act')) return true;
      if (has('ha') && p.inf.length > (p.ctl >= FM - 2 ? FILECARDS : 0)) {
        const t = G.map.cells.filter(c => { const o = ownerOf(c); return o !== null && o !== pi && toks(c, o) - 2 < toks(c, pi) + 1; }).sort((a, b) => G.players[ownerOf(b)].ctl - G.players[ownerOf(a)].ctl)[0];
        if (t && tryPlay('ha', t.id)) return true;
      }
      const b = bestCell(G, pi, false);
      if (p.imp > 0) { let bi = null; const safe = gv(p, 'impSafe');
        for (const c of G.map.cells) { if (!canImprove(G, c.id).ok) continue; const mine = toks(c, pi), top = Math.max(0, ...Object.keys(c.tok).filter(k => +k !== pi).map(k => c.tok[k]));
          if (mine - top < safe) continue; const v = yields(c)[c.imp || 0] * gv(p, 'impW') + (mine - top) * 0.3; if (!bi || v > bi.v) bi = { c, v }; }
        if (bi && (!b || b.v <= gv(p, 'gPlaceMin') || bi.v >= b.v)) return improve(G, bi.c.id); }
      if (b && b.v > gv(p, 'gPlaceMin')) return place(G, b.c.id);
      return pass(G);
    }
    return false;
  }


  /* ---------- the game record: every action and every journal line, with what it changed, for analysing played games ----------
     On in the browser; off in the tuner unless REC=1, since it costs time. Kept in G.rec, which saves with the game. */
  const RECV = 1, RECON = typeof window !== 'undefined' ? 1 : num('REC', 0);
  const handS = h => FAMS.map(f => h[f] || 0).join('/');
  function snapP(G, i) { const p = G.players[i];
    return { cash: p.cash, loy: p.loy, era: p.era, prog: p.prog, trk: trackLen(p), stars: p.stars, cont: p.cont || 0, imp: p.imp || 0, tok: p.tok, hand: handS(p.hand),
      mach: p.mach.map(m => m.id).join(','), shelf: (p.shelf || []).map(m => m.id).join(','), adv: p.adv.map(a => a.id).join(','), res: (p.tiles || []).length, inf: (p.inf || []).length,
      ctl: controlled(G, i), inc: income(controlled(G, i)) + impIncome(G, i), jail: p.jail ? 1 : 0, rerun: p.rerun || 0 }; }
  function recOn(G) {
    if (!RECON || !G || !G.players) return null;
    if (!G.rec) G.rec = { v: RECV, t0: Date.now(), from: G.round, ev: [], rounds: [], snap: G.players.map((_, i) => snapP(G, i)), heat: G.heat };
    return G.rec; }
  function recDelta(G) { const R = G.rec, d = {};
    G.players.forEach((_, i) => { const s = snapP(G, i), o = R.snap[i] || {}, c = {}; let any = false; for (const k in s) if (s[k] !== o[k]) { c[k] = [o[k], s[k]]; any = true; } if (any) d[i] = c; R.snap[i] = s; });
    if (G.heat !== R.heat) { d.heat = [R.heat, G.heat]; R.heat = G.heat; } return d; }
  const sec = R => Math.round((Date.now() - R.t0) / 100) / 10;
  function recLog(G, p, text, kind) { const R = recOn(G); if (!R) return;
    const e = { i: R.ev.length, r: G.round, ph: G.phase, p, k: kind || 'news', x: text }, d = recDelta(G);
    if (Object.keys(d).length) e.d = d; if (R.cur !== undefined && R.cur !== null) e.in = R.cur; R.ev.push(e); }
  function recRound(G) { const R = recOn(G); if (!R) return; // the whole table at the start of each round's market
    R.rounds.push({ r: G.round, t: sec(R), heat: G.heat, players: G.players.map((p, i) => ({ ...snapP(G, i), tiles: (p.tiles || []).map(c => c.name), infc: (p.inf || []).map(c => c.t) })),
      map: G.map.cells.filter(c => Object.keys(c.tok).length || c.imp).map(c => [c.name, ownerOf(c), c.tok, c.imp || 0, cellYield(c)]),
      mkt: G.mkt.map(m => m.id), rrow: G.rrow.map(c => c ? c.name : null), arow: G.arow.map(a => a.id), piles: FAMS.map(f => G.piles[f].length).join('/'), deck: G.deck.length, rdeck: G.rdeck.length }); }
  const cn = (G, id) => { const c = cell(G, id); return c ? c.name : id; };
  const RES = c => c && { card: c.name, tier: c.tier, cost: c.cost };
  // what each action was about, read before it happens; who acts; anything worth reading after
  const RECA = {
    pass: {}, lobby: {}, bail: {},
    stand: { pre: (G, id) => ({ at: cn(G, id) }) },
    draw: { post: G => G.choice ? { seen: G.choice.cards.map(c => c.f + ':' + c.n) } : {} },
    pick: { who: G => G.choice ? G.choice.pi : G.turn, pre: (G, i) => G.choice && G.choice.cards[i] ? { kept: G.choice.cards[i].f + ':' + G.choice.cards[i].n, of: G.choice.cards.map(c => c.f + ':' + c.n) } : {} },
    take: { pre: (G, f) => ({ f, pile: G.piles[f] ? G.piles[f].length : 0 }) },
    run: { pre: (G, i, use, hal) => { const m = P(G).mach[i]; return { m: m && m.id, use, hal }; } },
    buy: { pre: (G, i, scrap) => { const m = G.mkt[i], p = P(G); return { m: m && m.id, price: m && m.price, scrap: scrap !== undefined && p.mach[scrap] ? p.mach[scrap].id : scrap, mkt: G.mkt.map(x => x.id + '$' + x.price) }; } },
    scrapM: { pre: (G, i) => ({ m: P(G).mach[i] && P(G).mach[i].id }) },
    hire: { pre: (G, k, from, scrap) => { const a = from === undefined ? G.arow[k] : G.players[from] && G.players[from].adv[k]; return { adv: a && a.id, price: a && a.price, from, scrap }; } },
    hit: { pre: (G, ti, k) => ({ tgt: ti, adv: G.players[ti] && G.players[ti].adv[k] && G.players[ti].adv[k].id }) },
    sell: { pre: (G, n) => ({ n }) },
    research: { pre: (G, k, patent) => ({ ...RES(G.rrow[k]), patent: patent || undefined, row: G.rrow.map((c, j) => c ? c.name + (canResearch(G, j).ok ? '' : ' (no)') : null) }) },
    place: { pre: (G, id) => { const c = cell(G, id), x = canPlace(G, id); return { at: c && c.name, own: c && ownerOf(c), tk: c && { ...c.tok }, cost: x.cost, hot: c && c.hot ? 1 : undefined, rough: c && c.rough ? 1 : undefined }; } },
    improve: { pre: (G, id) => { const c = cell(G, id); return { at: c && c.name, imp: c && (c.imp || 0), pays: c && yields(c)[c.imp || 0] }; } },
    play: { pre: (G, u, target, extra) => { const c = P(G).inf.find(k => k.u === u); return { card: c && c.t, target, extra }; } },
    file: { pre: (G, extra) => ({ extra }) },
    choose: { who: G => G.pending ? G.pending.pi : G.turn, pre: (G, i) => { const m = G.pending && MEMOS[G.pending.id], o = m && m.opts[i]; return { memo: m && m.title, opt: i, label: o ? o.label : 'none' }; } },
    takeOffer: { who: G => G.offer ? G.offer.pi : G.turn, pre: (G, scrap) => ({ adv: G.offer && G.offer.a.id, price: G.offer && G.offer.a.price, scrap }) },
    declineOffer: { who: G => G.offer ? G.offer.pi : G.turn, pre: G => ({ adv: G.offer && G.offer.a.id, price: G.offer && G.offer.a.price }) },
  };
  let recDepth = 0;
  function traced(name, fn) { const spec = RECA[name];
    return function (G, ...args) {
      const R = recDepth ? null : recOn(G); if (!R) return fn(G, ...args);
      const drift = recDelta(G); if (Object.keys(drift).length) R.ev.push({ i: R.ev.length, r: G.round, ph: G.phase, p: null, k: 'drift', d: drift }); // changes no journal line explained
      let by = G.turn, info = {}; try { by = spec.who ? spec.who(G) : G.turn; info = spec.pre ? spec.pre(G, ...args) : {}; } catch (err) { info = { err: String(err) }; }
      const A = { i: R.ev.length, r: G.round, ph: G.phase, p: by, a: name, t: sec(R), hum: G.players[by] && !G.players[by].bot ? 1 : 0, ...info };
      R.ev.push(A); const prev = R.cur; R.cur = A.i; recDepth++; let res;
      try { res = fn(G, ...args); } finally { recDepth--; R.cur = prev; }
      if (!res && R.ev.length === A.i + 1) { R.ev.pop(); return res; } // an action that did not happen
      try { if (spec.post) Object.assign(A, spec.post(G)); } catch (err) { }
      const d = recDelta(G); if (Object.keys(d).length) A.d = d;
      return res; }; }
  pass = traced('pass', pass); lobby = traced('lobby', lobby); bail = traced('bail', bail); stand = traced('stand', stand); draw = traced('draw', draw); pick = traced('pick', pick);
  take = traced('take', take); run = traced('run', run); buy = traced('buy', buy); scrapM = traced('scrapM', scrapM); hire = traced('hire', hire); hit = traced('hit', hit); sell = traced('sell', sell);
  research = traced('research', research); place = traced('place', place); improve = traced('improve', improve); play = traced('play', play); file = traced('file', file); choose = traced('choose', choose);
  takeOffer = traced('takeOffer', takeOffer); declineOffer = traced('declineOffer', declineOffer);
  { const sp = startPhase; startPhase = function (G, phase) { const r = sp(G, phase); if (phase === 'biz') recRound(G); return r; }; }
  // the whole record as text: a header for people, then one JSON object per line
  function recordText(G, build) {
    const R = recOn(G); if (!R) return '';
    const fin = G.players.map((p, i) => ({ ...snapP(G, i), tiles: (p.tiles || []).map(c => c.name) }));
    const meta = { record: RECV, build, saved: new Date().toISOString(), round: G.round, phase: G.phase, winner: G.winner, from: R.from, seconds: sec(R),
      seats: G.players.map((p, i) => ({ i, name: p.name, human: !p.bot, style: p.bot ? p.spec : undefined })),
      rules: { DRAW, KEEP, TAKE, CMAX, WINNEED, IMPR, IMPY, IMPC, IMPON, RCHEAP, SLOTS, MSIZE: G.map.size },
      key: 'Lines after meta: "round" = the table at the start of each market; "ev" = an action (a, by player p, t seconds since the record began, hum 1 if a person) or a journal line (x). d = what changed, by player index: field: [before, after]. hand = sweet/sour/herb/fizz. inc = map income at payday. in = the action a journal line belongs to.' };
    const lines = [`SOUR EMPIRE GAME RECORD v${RECV} | build ${build || '?'} | ${G.players.length} players | round ${G.round}${G.winner !== null ? ' | winner ' + G.players[G.winner].name : ''} | ${R.ev.length} events`, JSON.stringify({ meta })];
    for (const r of R.rounds) lines.push(JSON.stringify({ round: r }));
    for (const e of R.ev) lines.push(JSON.stringify({ ev: e }));
    lines.push(JSON.stringify({ final: fin }));
    return lines.join('\n'); }
  const researchPay = (G, k, patent) => { const c = G.rrow[k]; return c ? payCount(G, P(G), c, patent) : null; }; // cards of any kind owed
  return { researchPay, RING, WORLD, HOTN, ROUGHN, BONUS, IMPY, IMPC, recordText, recOn, GENES, LEG, legacyGenome, gv, shelfOf, canImprove, improve, cellYield, yields, impIncome, IMPR, IMPON, canScrap, scrapM, researchDeck, CMAX, advTier, ABOARD, PDISC, WINCARD, RROW, WINNEED, CONDS, condOK, rbonus, needFor, payFor, resCards, canTakeOffer, takeOffer, declineOffer, mapStyle, outpostN, BOARDS, OUTPOST, travel, WIN, stipend, UD, UDF, ADVISORS, ROW, POACH, hasA, used, drawCost, canHire, hire, canHit, hit, canSell, sell, canVacate, FAMS, FNAME, FDIR, ARROW, FLAVOR, DRAW, TAKE, KEEP, MAXSTAR, TX, ERAS, OVER, LOYE, trackLen, STARCASH, TILESET, BLANK, starText, income, INCB, INCK, CASH0, LOY0, TOKN, INFC, MSIZE, FM, FILECARDS, MAXROUND, SLOTS, MKT, BANDS, TOL, bandOf, START, MACHINES, MAT, MID, ICARD, IDECK, MEMOS, COLORS,
    newGame, co, cell, toks, ownerOf, controlled, homeOf, dist, tokCost, handSize, topEra, tolerance, onMap, bailCost, fuel, actTargets,
    canStand, stand, canDraw, draw, pick, canTake, take, canRun, run, canBuy, buy, canResearch, research, canPlace, place, canLobby, lobby, canBail, bail, canPlay, play, canFile, file, canChoose, choose, pass,
    botStep, plan, getOps: () => ops, resetOps: () => { ops = 0; } };
})();
if (typeof module !== 'undefined') module.exports = E;
