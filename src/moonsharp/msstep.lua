JS_process = { env = __mkO({}, {}) }
local s = SEED; JS_Math.random = function() s = (s * 16807) % 2147483647; return (s - 1) / 2147483646 end
local E = loadEngine()
local G = E.newGame(SEATS)
print('@@' .. JS_JSON.stringify(G))
local k = 0; while G.winner == nil and k < (MAXSTEP or 20000) do k = k + 1; local okk = E.botStep(G); print('@@' .. JS_JSON.stringify(G)); if not okk then break end end
