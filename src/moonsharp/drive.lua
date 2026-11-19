-- plays games through the table script, as the Python test does, inside MoonSharp
MOCK_DECODE = function(s) return {} end
local function runWaits(limit) local k = 0; while #MOCK.waits > 0 and k < limit do local f = table.remove(MOCK.waits, 1); f(); k = k + 1 end end
math.randomseed(SEED or 1)
for g = 1, GAMES or 2 do
  MOCK.objs = {}; MOCK.waits = {}; MOCK.errors = {}
  onLoad('')
  local P = { color = 'Red' }
  uiSetup(P, '', 'np_' .. (g % 2 == 0 and 2 or 3)); uiSetup(P, '', 'mode_full'); uiSetup(P, '', 'anyone_no')
  uiSeat(P, 'Human', 'seat1'); uiSeat(P, 'Bot: champion', 'seat2'); uiSeat(P, 'Bot: generalist', 'seat3')
  uiStart(P)
  local steps, acts = 0, 0
  while steps < 5000 do steps = steps + 1
    if #MOCK.waits > 0 then local f = table.remove(MOCK.waits, 1); f()
    else
      if not S.G or S.G.winner ~= nil then break end
      local ids = {}; for id in (MOCK.xml or ''):gmatch('id="a_([^"]+)"') do ids[#ids + 1] = id end
      local tiles = {}; for _, o in ipairs(getObjects()) do if #o.buttons > 0 and o.notes:sub(1, 8) == 'se|tile:' then tiles[#tiles + 1] = o end end
      if #ids == 0 and #tiles == 0 then print('stuck in phase ' .. tostring(S.G.phase)); break end
      acts = acts + 1
      if #tiles > 0 and math.random() < 0.85 then onCellClick(tiles[math.random(#tiles)], 'Red', false)
      else local pref = {}; for _, id in ipairs(ids) do if id:match('^(memo|pick|otake|run|research|buy|draw|take|hire|scrap|tgt|dok|impmode)') or id:match('^memo') or id:match('^pick') or id:match('^run') or id:match('^research') or id:match('^buy') or id:match('^draw') or id:match('^take') then pref[#pref + 1] = id end end
        local pool = (#pref > 0 and math.random() < 0.8) and pref or ids
        uiAct(P, '', 'a_' .. pool[math.random(#pool)]) end
    end
  end
  print('game ' .. g .. ': steps ' .. steps .. ', human actions ' .. acts .. ', winner ' .. tostring(S.G and S.G.winner) .. ', round ' .. tostring(S.G and S.G.round) .. ', errors ' .. #MOCK.errors .. (MOCK.errors[1] and (': ' .. MOCK.errors[1]) or ''))
end
