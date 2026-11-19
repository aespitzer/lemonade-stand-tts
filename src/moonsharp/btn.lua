MOCK_DECODE = function(s) return {} end
onLoad(''); local P = { color = 'White', changeColor = function(c) print('moved the player to ' .. c) end }
uiSetup(P, '', 'np_3'); uiSeat(P, 'Human', 'seat1'); uiStart(P)
for k = 1, 40 do if #MOCK.waits == 0 then break end local f = table.remove(MOCK.waits, 1); f() end
local labels = {}; for _, o in ipairs(getObjects()) do if #o.buttons > 0 then labels[#labels + 1] = o.notes:sub(4) .. '=' .. o.buttons[1].label end end
table.sort(labels); print('card buttons: ' .. table.concat(labels, ' | '))
print('panel buttons: ' .. select(2, (MOCK.xml or ''):gsub('id="a_', '')))
print('card size measured', S.cardW, S.cardH, 'boards', #getObjects())
