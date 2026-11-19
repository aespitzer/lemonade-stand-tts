// plays one seeded game in the JS engine; prints the md5 of the state after every bot step (or the state at step DUMP)
const crypto = require('crypto'); const fs = require('fs');
let s = +process.argv[2]; Date.now = () => 0; Math.random = () => { s = (s * 16807) % 2147483647; return (s - 1) / 2147483646; };
const E = require('/home/claude/v2/engine.js');
const seats = JSON.parse(process.argv[3]); const DUMP = process.argv[4] !== undefined ? +process.argv[4] : -1;
const G = E.newGame(seats);
const ser = G => JSON.stringify(G, function (k, v) { if (v === null && !Array.isArray(this)) return undefined; return v; });
const out = [crypto.createHash('md5').update(ser(G)).digest('hex')];
if (DUMP === 0) { console.log(ser(G)); process.exit(0); }
let k = 0; while (G.winner === null && k++ < 20000) { const ok = E.botStep(G); out.push(crypto.createHash('md5').update(ser(G)).digest('hex')); if (DUMP === out.length - 1) { console.log(ser(G)); process.exit(0); } if (!ok) break; }
console.log(JSON.stringify({ hashes: out, winner: G.winner, round: G.round, log: G.log.map(l => l.text) }));
