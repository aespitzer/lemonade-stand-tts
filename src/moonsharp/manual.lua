MOCK_DECODE = function(s) return {} end
for _, mode in ipairs({ 'arith', 'log' }) do
  MOCK.objs = {}; MOCK.waits = {}; MOCK.errors = {}; MOCK.tabs = {}
  onLoad(''); local P = { color = 'Red' }
  uiSetup(P, '', 'np_3'); uiSetup(P, '', 'mode_' .. mode); uiStart(P)
  while #MOCK.waits > 0 do local f = table.remove(MOCK.waits, 1); f() end
  local tile; for _, o in ipairs(getObjects()) do if o.notes:sub(1, 8) == 'se|tile:' then tile = o end end
  local chip = spawnObjectData({ data = { Name = 'Chip_10', GMNotes = 'se|loy:Red', Transform = { posX = 0, posY = 2, posZ = 0 } } })
  onObjectPickUp('Red', chip); chip.pos = { x = tile.pos.x, y = 2, z = tile.pos.z }; onObjectDrop('Red', chip)
  if mode == 'arith' then uiPayday(P); uiStipend(P); uiCosts(P) end
  uiSnap(P); uiRecord(P)
  local body = ''; for _, t in ipairs(MOCK.tabs) do body = body .. t.body end
  local lines = 0; for _ in body:gmatch('\n') do lines = lines + 1 end
  print(mode .. ': record lines ' .. lines .. ', errors ' .. #MOCK.errors .. (MOCK.errors[1] and (': ' .. MOCK.errors[1]) or ''))
end
for _, m in ipairs(MOCK.msgs) do if m:find('Payday') then print(m:sub(1, 120)) end end
