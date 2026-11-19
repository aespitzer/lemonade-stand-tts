-- one seeded bot game in MoonSharp; prints the final state as JSON
JS_process = { env = __mkO({ REC = '1' }, { 'REC' }) }
local s = SEED; JS_Math.random = function() s = (s * 16807) % 2147483647; return (s - 1) / 2147483646 end
JS_Date.now = function() return 0 end
local E = loadEngine()
local G = E.newGame(SEATS)
local k = 0; while G.winner == nil and k < 20000 do k = k + 1; if not E.botStep(G) then break end end
print('@@' .. JS_JSON.stringify(G))
