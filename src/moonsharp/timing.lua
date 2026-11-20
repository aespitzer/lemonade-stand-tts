MOCK_DECODE = function(s) return {} end
math.randomseed(3)
onLoad(''); local P = { color = 'Red' }
uiSetup(P, '', 'np_3'); uiSetup(P, '', 'anyone_yes'); uiSeat(P, 'Bot: champion', 'seat1'); uiSeat(P, 'Bot: champion', 'seat2'); uiSeat(P, 'Bot: champion', 'seat3')
uiStart(P)
local t = { wait = 0, n = 0, max = 0 }
local k = 0
while #MOCK.waits > 0 and k < 4000 do k = k + 1
  local f = table.remove(MOCK.waits, 1); local c = os.clock(); f(); local d = os.clock() - c
  t.wait = t.wait + d; t.n = t.n + 1; if d > t.max then t.max = d end; if d > 0.1 then t.slow = (t.slow or 0) + 1; t.slowR = (t.slowR or "") .. string.format(" r%d:%dms", S.G and S.G.round or 0, d * 1000) end
  if S.G and S.G.winner ~= nil then break end
end
print('over 100 ms:', t.slow or 0, t.slowR or '')
print(string.format('callbacks %d, total %.2fs, mean %.1f ms, worst %.0f ms (each bot step = engine move + table update)', t.n, t.wait, 1000 * t.wait / t.n, 1000 * t.max))
local c = os.clock(); local E2 = E; for i = 1, 20 do E2.botStep(S.G) end
local c2 = os.clock(); local s = onSave(); local c3 = os.clock()
print(string.format('save: %.0f ms for %d KB (round %d, %d record events)', 1000 * (c3 - c2), math.floor(#s / 1024), S.G.round, S.G.rec.ev.__n))
local c4 = os.clock(); local x = E.recordText(S.G, 'x'); print(string.format('record text: %.0f ms', 1000 * (os.clock() - c4)))
