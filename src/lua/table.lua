--[[ Sour Empire for Tabletop Simulator: the table.
  The rules engine is the browser game's own engine, compiled to Lua (engine.lua, with runtime.lua for JavaScript semantics).
  Three ways to play, chosen at setup:
    full   the engine runs the game: players act from their panel and by clicking markets; pieces follow the engine; bots can sit in.
    arith  the table is the truth: players move everything themselves; buttons work out payday, loyalty and token costs.
    log    the table is the truth: nothing is checked; every move is written down.
  Every mode keeps a record you can copy from the Notebook (Sour Empire record tab). ]]

local VERSION = 'tts-2'
local SEATCOL = { 'Red', 'Blue', 'Green' }
local RGB = { Red = { 0.85, 0.28, 0.23 }, Blue = { 0.18, 0.47, 0.82 }, Green = { 0.18, 0.62, 0.36 } }
local CARD_W, CARD_H = 2.14, 3.05 -- a card at scale 1; measured at setup (Tabletop Simulator does not document it)
local FACE = 180                  -- a card or tile at turn 0 shows its top edge to the south seat; turn it to face that player
local CS = 1                      -- the scale that fits a card in a board slot, worked out from the measured card
local Y = 1.12                    -- height of the board surfaces

S = S or nil -- the saved state
local objs = {}   -- key -> object we spawned
local want = {}   -- key -> what should be on the table now
local ui = { impMode = false }
local btnLast = {} -- object key -> the button label it carries
local busy = false

--[[ ---------- values: the engine's arrays are 0-based with their length in __n ---------- ]]
local function alen(a) return a and a.__n or 0 end
local function aget(a, i) return a and a[i] end
local function each(a) local i = -1; local n = alen(a); return function() i = i + 1; if i < n then return i, a[i] end end end
local function jsA(t) local a = { __n = #t }; for i = 1, #t do a[i - 1] = t[i] end return __mkA(a) end
local function jsO(t, keys) return __mkO(t, keys) end
local function ok(x) return x and x.ok end
local function loaded(o) local okk, r = pcall(function() return (not o.spawning) and (not o.loading_custom) end); return (not okk) or r end
local function alive(o) if o == nil then return false end local okk, g = pcall(function() return o.getGUID() end); return okk and g ~= nil end

-- lossless save format for engine values: arrays as ["\1", ...], numeric object keys as "#n"
-- (each piece goes at an index we count ourselves: MoonSharp's # on a long table is slow, which made saving take half a minute)
local function serialize(v)
  local out, n = {}, 0
  local function put(x) n = n + 1; out[n] = x end
  local function ser(v)
    local ty = type(v)
    if v == nil then put('null')
    elseif ty == 'boolean' then put(v and 'true' or 'false')
    elseif ty == 'number' then put((v ~= v) and '"\2NaN"' or (v == math.huge and '"\2inf"' or (v == -math.huge and '"\2-inf"' or __numstr(v))))
    elseif ty == 'string' then put(JS_JSON.stringify(v))
    elseif ty == 'table' then
      if __isarr(v) then put('["\1"'); for i = 0, v.__n - 1 do put(','); ser(v[i]) end put(']')
      else put('{'); local first = true
        for _, k in ipairs(__keys(v)) do local x = v[k]; if x ~= nil and type(x) ~= 'function' and not (type(x) == 'table' and getmetatable(x) and not __isarr(x)) then
          if not first then put(',') end first = false
          put(JS_JSON.stringify(type(k) == 'number' and ('#' .. __numstr(k)) or k)); put(':'); ser(x) end end
        put('}') end
    end
  end
  ser(v); return table.concat(out, '', 1, n)
end
local function deserialize(s)
  local i = 1
  local function ws() i = s:find('[^%s]', i) or #s + 1 end
  local val
  local function str()
    local out, j = {}, i + 1
    while true do
      local c = s:sub(j, j)
      if c == '"' then i = j + 1; return table.concat(out) end
      if c == '\\' then local e = s:sub(j + 1, j + 1)
        if e == 'u' then local code = tonumber(s:sub(j + 2, j + 5), 16); out[#out + 1] = code < 128 and string.char(code) or utf8char(code); j = j + 6
        else out[#out + 1] = ({ n = '\n', r = '\r', t = '\t', b = '\b', f = '\f' })[e] or e; j = j + 2 end
      else local k = s:find('["\\]', j); out[#out + 1] = s:sub(j, k - 1); j = k end
    end
  end
  val = function()
    ws(); local c = s:sub(i, i)
    if c == '{' then i = i + 1; local o, ks = {}, {}; ws()
      if s:sub(i, i) == '}' then i = i + 1; return __mkO(o, ks) end
      while true do ws(); local k = str(); ws(); i = i + 1; local v = val()
        if k:sub(1, 1) == '#' then o[tonumber(k:sub(2))] = v else o[k] = v; ks[#ks + 1] = k end
        ws(); local d = s:sub(i, i); i = i + 1; if d == '}' then break end end
      return __mkO(o, ks)
    elseif c == '[' then i = i + 1; ws()
      if s:sub(i, i) == ']' then i = i + 1; return {} end
      local first = val(); local arr = (first == '\1'); local items, n = {}, 0
      if not arr then items[0] = first; n = 1 end
      while true do ws(); local d = s:sub(i, i); i = i + 1; if d == ']' then break end; items[n] = val(); n = n + 1 end
      items.__n = n; return arr and __mkA(items) or items
    elseif c == '"' then local x = str(); if x:sub(1, 1) == '\2' then return ({ NaN = 0 / 0, inf = math.huge, ['-inf'] = -math.huge })[x:sub(2)] end return x
    elseif s:sub(i, i + 3) == 'true' then i = i + 4; return true
    elseif s:sub(i, i + 4) == 'false' then i = i + 5; return false
    elseif s:sub(i, i + 3) == 'null' then i = i + 4; return nil
    else local num = s:match('^-?%d+%.?%d*[eE]?[-+]?%d*', i); i = i + #num; return tonumber(num) end
  end
  return val()
end
__SE_SER = { s = function(v) return serialize(v) end, d = function(s) return deserialize(s) end }
function utf8char(c)
  if c < 0x800 then return string.char(0xC0 + math.floor(c / 64), 0x80 + c % 64) end
  return string.char(0xE0 + math.floor(c / 4096), 0x80 + math.floor(c / 64) % 64, 0x80 + c % 64)
end

--[[ ---------- geometry: boards and their slots ---------- ]]
-- each board: centre (x, z), size (w, h) in table units, turn (degrees about y)
local BOARD = {}
local function placeBoards(n)
  BOARD.felt = { x = 0, z = -1, w = LAYOUT.files.felt.w, h = LAYOUT.files.felt.h, rot = 0, file = 'felt' }
  BOARD.common = { x = 0, z = 19.7, w = LAYOUT.common.w, h = LAYOUT.common.h, rot = 0, file = 'board-common', L = LAYOUT.common }
  local M = LAYOUT['map' .. n]; BOARD.map = { x = 0, z = 0, w = M.w, h = M.h, rot = 0, file = 'board-map' .. n, L = M }
  local spots = { { 0, -17.2, 0 }, { -27.6, -8.6, 90 }, { 27.6, -8.6, 270 } }
  for pi = 0, n - 1 do local s = spots[pi + 1]; BOARD['mat' .. pi] = { x = s[1], z = s[2], w = LAYOUT.mat.w, h = LAYOUT.mat.h, rot = s[3], file = 'mat-' .. pi, L = LAYOUT.mat } end
end
-- a point on a board, in board units from its top-left corner, to the table
local function onBoard(b, u, v, dy)
  local B = BOARD[b]; local lx, lz = u - B.w / 2, B.h / 2 - v
  local t = math.rad(B.rot); local c, s = math.cos(t), math.sin(t)
  return { x = B.x + lx * c + lz * s, y = Y + (dy or 0.05), z = B.z - lx * s + lz * c }
end
local function slot(b, name, du, dv, dy)
  local sl = BOARD[b].L.slots[name]; if not sl then error('no slot ' .. b .. '.' .. name) end
  return onBoard(b, sl[1] + (du or 0), sl[2] + (dv or 0), dy)
end
-- the board and slot under a table point (for the move log)
local function where(p)
  for _, b in ipairs({ 'common', 'map', 'mat0', 'mat1', 'mat2' }) do local B = BOARD[b]
    if B then local t = math.rad(B.rot); local c, s = math.cos(t), math.sin(t); local dx, dz = p.x - B.x, p.z - B.z
      local lx, lz = dx * c - dz * s, dx * s + dz * c; local u, v = lx + B.w / 2, B.h / 2 - lz
      if u >= 0 and u <= B.w and v >= 0 and v <= B.h then
        for name, sl in pairs(B.L.slots) do if math.abs(u - sl[1]) <= sl[3] / 2 and math.abs(v - sl[2]) <= sl[4] / 2 then
          if b == 'map' and S and S.cellName then return 'map:' .. (S.cellName[name] or name) end
          if b:sub(1, 3) == 'mat' then return SEATCOL[tonumber(b:sub(4)) + 1] .. ':' .. name end
          return b .. ':' .. name end end
        return b end end end
  for _, col in ipairs(SEATCOL) do local ok2, ht = pcall(function() return Player[col].getHandTransform() end)
    if ok2 and ht and math.abs(p.x - ht.position.x) < 9 and math.abs(p.z - ht.position.z) < 4 then return col .. ':hand' end end
  return 'table'
end

--[[ ---------- spawning: every piece is keyed; GM notes hold the key ---------- ]]
local CARDS = {} -- card key -> { deck id, cell, sheet }
local function indexCards()
  for di, sh in ipairs(MANIFEST) do for cell, key in ipairs(sh.keys) do CARDS[key] = { id = di, cell = cell - 1, sh = sh } end end
end
local function customDeck(c)
  local sh = c.sh
  return { [c.id] = { FaceURL = IMG .. sh.file, BackURL = IMG .. (sh.back or sh.file), NumWidth = sh.cols, NumHeight = sh.rows, BackIsHidden = true, UniqueBack = sh.uniqueBack or false, Type = 0 } }
end
local function tf(p, roty, sc, flip) return { posX = p.x, posY = p.y, posZ = p.z, rotX = 0, rotY = (roty or 0) + FACE, rotZ = flip and 180 or 0, scaleX = sc[1], scaleY = 1, scaleZ = sc[2] } end
local function cardData(key, cardKey, p, roty, sc, flip, locked)
  local backFace = cardKey:sub(1, 5) == 'back:'
  local c = CARDS[backFace and cardKey:sub(6) or cardKey]; if not c then error('no card ' .. tostring(cardKey)) end
  if backFace then -- the back's image as the face of a card of its own
    local sh = c.sh; local id = c.id + 50; local one = not sh.uniqueBack
    local deck = { [id] = { FaceURL = IMG .. sh.back, BackURL = IMG .. sh.back, NumWidth = one and 1 or sh.cols, NumHeight = one and 1 or sh.rows, BackIsHidden = true, UniqueBack = false, Type = 0 } }
    return { Name = 'CardCustom', Transform = tf(p, roty, sc, false), CardID = id * 100 + (one and 0 or c.cell), CustomDeck = deck, GMNotes = 'se|' .. key, Nickname = '', Locked = locked ~= false, Hands = true, SidewaysCard = false }
  end
  return { Name = 'CardCustom', Transform = tf(p, roty, sc, flip), CardID = c.id * 100 + c.cell, CustomDeck = customDeck(c), GMNotes = 'se|' .. key, Nickname = '', Locked = locked ~= false, Hands = true, SidewaysCard = false }
end
local function spawnFrom(key, data, after)
  btnLast[key] = nil
  local o = spawnObjectData({ data = data, callback_function = function(obj) if after then after(obj) end end })
  objs[key] = o; return o
end
local function tileOf(key, name, p) want[key] = { kind = 'tile', card = name, p = p, rot = 0 } end
local function token(key, img, p, d, rot) want[key] = { kind = 'token', card = img, p = p, rot = rot or 0, d = d or 0.8 } end
-- an amount as coins or loyalty tokens: 5s then 1s, in stacks of up to five across the box
local function pieces(prefix, img, amount, at, boxW, rot)
  amount = math.max(0, math.floor(amount or 0)); local fives, ones = math.floor(amount / 5), amount % 5
  local list = {}; for i = 1, fives do list[#list + 1] = img .. '-5' end; for i = 1, ones do list[#list + 1] = img .. '-1' end
  local cols = 5; local gap = math.min(0.62, (boxW - 0.8) / (cols - 1))
  for i, im in ipairs(list) do local slotN = (i - 1) % 10; local layer = math.floor((i - 1) / 10)
    local col, row = slotN % cols, math.floor(slotN / cols)
    token(prefix .. i, im, at(-(cols - 1) * gap / 2 + col * gap + layer * 0.08, layer * 0.1, row), 0.6, rot) end
end
local function card(key, cardKey, p, opt) opt = opt or {}
  if opt.flip then cardKey = 'back:' .. cardKey; opt.flip = nil end -- face-down cards cannot show buttons in the game
  want[key] = { kind = 'card', card = cardKey, p = p, rot = opt.rot or 0, sc = opt.sc or { CS, CS }, flip = opt.flip, hand = opt.hand, tap = opt.tap, label = opt.label } end
local function chip(key, col, p, sc) want[key] = { kind = 'chip', col = col, p = p, sc = sc or 0.55 } end
local function pawn(key, col, p) want[key] = { kind = 'pawn', col = col, p = p } end
local function text(key, s, p, rot, size, col) want[key] = { kind = 'text', s = s, p = p, rot = rot or 0, size = size or 30, col = col } end

local function colorOf(c) if type(c) == 'string' then local r = RGB[c] or { 1, 1, 1 }; return { r = r[1], g = r[2], b = r[3] } end return { r = c[1], g = c[2], b = c[3] } end
local function spawnWanted(key, w)
  if w.kind == 'token' then
    local k = (S.tileScale or 1.4) * w.d / 2.85
    return spawnFrom(key, { Name = 'Custom_Tile', Transform = tf(w.p, w.rot, { k, k }), Locked = true, GMNotes = 'se|' .. key, Nickname = w.card:find('coin') and 'Capital' or (w.card:find('heart') and 'Loyalty' or 'Pitcher'),
      CustomImage = { ImageURL = IMG .. w.card .. '.png', ImageSecondaryURL = '', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 2, Thickness = 0.1, Stackable = false, Stretch = true } } })
  end
  if w.kind == 'tile' then
    local k = S.tileScale or 1.4
    return spawnFrom(key, { Name = 'Custom_Tile', Transform = tf(w.p, 0, { k, k }), Locked = true, GMNotes = 'se|' .. key,
      CustomImage = { ImageURL = IMG .. TILEFILES['tile:' .. w.card], ImageSecondaryURL = IMG .. 'tile-back.png', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 0, Thickness = 0.12, Stackable = false, Stretch = true } } })
  end
  if w.kind == 'card' then
    local d = cardData(key, w.card, w.hand and { x = w.p.x, y = w.p.y + 2, z = w.p.z } or w.p, w.rot + (w.tap and 90 or 0), w.sc, w.flip, not w.hand)
    if w.hand then return spawnFrom(key, d, function(obj) Wait.condition(function() pcall(function() obj.deal(1, w.hand) end) end, function() return loaded(obj) end, 10) end) end
    return spawnFrom(key, d)
  elseif w.kind == 'chip' then
    return spawnFrom(key, { Name = w.col == 'gold' and 'Chip_1000' or 'Chip_10', Transform = tf(w.p, 0, { w.sc, w.sc }), ColorDiffuse = w.col == 'gold' and { r = 0.89, g = 0.67, b = 0.11 } or colorOf(w.col), GMNotes = 'se|' .. key, Locked = true })
  elseif w.kind == 'pawn' then
    return spawnFrom(key, { Name = 'PlayerPawn', Transform = tf(w.p, 0, { 0.45, 0.45 }), ColorDiffuse = colorOf(w.col), GMNotes = 'se|' .. key, Locked = true })
  elseif w.kind == 'text' then
    return spawnFrom(key, { Name = '3DText', Transform = { posX = w.p.x, posY = w.p.y + 0.05, posZ = w.p.z, rotX = 90, rotY = w.rot or 0, rotZ = 0, scaleX = 1, scaleY = 1, scaleZ = 1 },
      Text = { Text = w.s, fontSize = w.size, colorstate = w.col and colorOf(w.col) or { r = 0.17, g = 0.1, b = 0.08 } }, GMNotes = 'se|' .. key, Locked = true },
      function(obj) obj.interactable = false end)
  end
end
local last = {} -- key -> the last wanted state applied
local function same(a, b) if not a or not b then return false end
  for _, k in ipairs({ 'kind', 'card', 'rot', 'flip', 'tap', 's', 'col', 'hand' }) do if a[k] ~= b[k] then return false end end
  if not a.hand and (math.abs(a.p.x - b.p.x) > 0.01 or math.abs(a.p.y - b.p.y) > 0.01 or math.abs(a.p.z - b.p.z) > 0.01) then return false end
  return true end
local function apply()
  for key, o in pairs(objs) do if key:sub(1, 6) ~= 'board:' and (want[key] == nil or not alive(o)) then
    if alive(o) then o.destruct() end objs[key] = nil; last[key] = nil end end
  for key, w in pairs(want) do
    local o = objs[key]
    if not alive(o) then spawnWanted(key, w); last[key] = w
    elseif not same(last[key], w) then
      if w.kind == 'text' and last[key] and last[key].s ~= w.s and last[key].kind == 'text' and math.abs(last[key].p.x - w.p.x) < 0.01 then o.TextTool.setValue(w.s)
      elseif last[key] and (last[key].kind ~= w.kind or last[key].card ~= w.card or last[key].hand ~= w.hand or last[key].col ~= w.col) then o.destruct(); objs[key] = nil; spawnWanted(key, w) -- a different picture or colour: replace the piece
      elseif w.kind == 'card' and w.hand then -- hand cards stay where the hand puts them
      else o.setPositionSmooth({ w.p.x, w.p.y, w.p.z }, false, true); if w.kind == 'card' or w.kind == 'token' then o.setRotationSmooth({ 0, (w.rot or 0) + FACE + (w.tap and 90 or 0), w.flip and 180 or 0 }, false, true) end end
      last[key] = w
    end
  end
end
local function clearAll() for key, o in pairs(objs) do if alive(o) then o.destruct() end end objs = {}; want = {}; last = {} end
-- measure a card once, so slots, tiles and tokens come out the size and shape they were drawn
local function calibrate(after)
  if S.cardW then CARD_W, CARD_H = S.cardW, S.cardH; CS = math.min(0.95 * BOARD.common.L.slots.mkt0[3] / CARD_W, 0.95 * BOARD.common.L.slots.mkt0[4] / CARD_H); return after() end
  local o = spawnObjectData({ data = cardData('probe', 'mach:hands', { x = 0, y = 30, z = 0 }, 0, { 1, 1 }, false, true) })
  Wait.condition(function()
    local okk, b = pcall(function() return o.getBoundsNormalized() end)
    if okk and b and b.size and b.size.x > 0.5 and b.size.z > 0.5 then CARD_W, CARD_H = b.size.x, b.size.z end
    S.cardW, S.cardH = CARD_W, CARD_H
    CS = math.min(0.95 * BOARD.common.L.slots.mkt0[3] / CARD_W, 0.95 * BOARD.common.L.slots.mkt0[4] / CARD_H)
    if alive(o) then o.destruct() end
    after()
  end, function() return loaded(o) end, 15, function() if alive(o) then o.destruct() end; after() end)
end
local function boardsUp(n, after)
  placeBoards(n)
  local pending = 0
  local function done() pending = pending - 1; if pending == 0 and after then after() end end
  for _, b in ipairs({ 'felt', 'common', 'map', 'mat0', 'mat1', 'mat2' }) do local B = BOARD[b]
    if B and not alive(objs['board:' .. b]) then
      pending = pending + 1
      local p = { x = B.x, y = (b == 'felt') and 0.3 or 0.9, z = B.z } -- the felt's top is below the boards' bottom; the boards' top is below the pieces
      local o = spawnObjectData({ data = { Name = 'Custom_Tile', Transform = tf(p, B.rot, { 1, 1 }), Locked = true, GMNotes = 'se|board:' .. b,
        CustomImage = { ImageURL = IMG .. B.file .. '.png', ImageSecondaryURL = '', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 0, Thickness = (b == 'felt') and 0.2 or 0.1, Stackable = false, Stretch = true } } } })
      objs['board:' .. b] = o
      local function size() local okk, bd = pcall(function() return o.getBoundsNormalized() end)
        if not (okk and bd and bd.size) then return nil end
        local sc = o.getScale(); local sx = (sc and sc.x) or 1; local sz = (sc and sc.z) or 1
        return bd.size.x / sx, bd.size.z / sz end -- getBoundsNormalized gives the size as if unrotated
      local function shaped() if not loaded(o) then return false end local w0, h0 = size(); if not w0 or h0 <= 0 then return false end
        local want = B.w / B.h; return math.abs(w0 / h0 - want) < 0.06 * want end
      local function fit() local w0 = size(); if w0 and w0 > 0.01 then local k = B.w / w0; o.setScale({ k, 1, k }); if b == 'map' then S.tileScale = k * 2.85 / B.w end end
        o.setPosition({ p.x, p.y, p.z }); o.interactable = false; done() end
      Wait.condition(fit, shaped, 30, fit)
    end
  end
  if pending == 0 and after then after() end
end

--[[ ---------- full mode: the engine's game state onto the table ---------- ]]
local function P(pi) return S.G.players[pi] end
local function actor() local G = S.G; if G.pending then return G.pending.pi end if G.choice then return G.choice.pi end if G.offer then return G.offer.pi end return G.turn end
local function ownerOf(c) return E.ownerOf(c) end
local FAMS = { 'sweet', 'sour', 'herb', 'fizz' }

local function buildWant()
  want = {}
  local G = S.G; local n = alen(G.players)
  -- the map
  S.cellName = {}
  for _, c in each(G.map.cells) do
    S.cellName[c.id] = c.name
    local base = slot('map', c.id, 0, 0, 0.1)
    tileOf('tile:' .. c.id, c.name, base)
    local at = function(du, dv, dy) return slot('map', c.id, du, dv, 0.25 + (dy or 0)) end
    for pi = 0, n - 1 do local k = c.tok[pi] or 0
      for j = 0, k - 1 do chip('tok:' .. c.id .. ':' .. pi .. ':' .. j, SEATCOL[pi + 1], at(-0.85 + pi * 0.85, -0.15, j * 0.2)) end end
    for j = 0, (c.imp or 0) - 1 do chip('imp:' .. c.id .. ':' .. j, 'gold', at(-0.66 + j * 0.66, 0.7), 0.42) end
    if c.home ~= nil then card('stand:' .. c.id, 'stand:' .. c.home, at(-1.02, -1.02), { sc = { 0.72 / CARD_W, 0.72 / CARD_H } }) end
    if c.bonus then local bk; for bi, b in each(E.BONUS) do for k in pairs(b) do if c.bonus[k] == b[k] then bk = bi end end end
      if bk then card('bonus:' .. c.id, 'bonus:' .. bk, at(1.02, -1.02), { sc = { 0.72 / CARD_W, 0.72 / CARD_H } }) end end
    if c.link then card('air:' .. c.id, 'air:' .. c.link, at(-1.12, 0.1), { sc = { 0.6 / CARD_W, 0.6 / CARD_H } }) end
  end
  -- the common board
  for i, m in each(G.mkt) do card('mkt:' .. i, 'mach:' .. m.id, slot('common', 'mkt' .. i)) end
  card('deck:mach', 'mach:hands', slot('common', 'mdeck'), { flip = true }); text('n:mdeck', alen(G.mdeck) .. ' left', slot('common', 'mdeck', 0, 2.55), 0, 28)
  card('deck:ing', 'ing:sour:Lemon', slot('common', 'ideck'), { flip = true }); text('n:ideck', alen(G.deck) .. ' cards', slot('common', 'ideck', 0, 2.55), 0, 28)
  for _, f in ipairs(FAMS) do local pile = G.piles[f]; local np = alen(pile)
    if np > 0 then local top = pile[np - 1]; card('pile:' .. f, 'ing:' .. f .. ':' .. top.n, slot('common', 'pile_' .. f)) end
    text('n:pile:' .. f, np .. ' in pile', slot('common', 'pile_' .. f, 0, 2.55), 0, 28) end
  if G.choice then for i, c in each(G.choice.cards) do if not c.taken then card('choice:' .. i, 'ing:' .. c.f .. ':' .. c.n, slot('common', 'choice' .. i)) end end end
  for i = 0, alen(G.rrow) - 1 do local c = G.rrow[i]; if c then card('rrow:' .. i, 'res:' .. c.id, slot('common', 'rrow' .. i), { flip = true }) end end
  if alen(G.rdeck) > 0 then card('deck:res', 'adv:' .. E.ADVISORS[0].id, slot('common', 'rdeck'), { flip = true }) end
  text('n:rdeck', alen(G.rdeck) .. ' left', slot('common', 'rdeck', 0, 2.55), 0, 28)
  for i, a in each(G.arow) do card('arow:' .. i, 'adv:' .. a.id, slot('common', 'arow' .. i)) end
  if G.offer then card('offer', 'adv:' .. G.offer.a.id, slot('common', 'memoplay', 0, 0, 0.4)) end
  if alen(G.ideck) > 0 then card('deck:inf', 'inf:recall:0', slot('common', 'infdeck'), { flip = true }) end
  text('n:infdeck', alen(G.ideck) .. ' left', slot('common', 'infdeck', 0, 2.55), 0, 28)
  local nd = alen(G.idisc); if nd > 0 then local c = G.idisc[nd - 1]; if c and CARDS['inf:' .. c.t .. ':' .. c.x] then card('infdisc', 'inf:' .. c.t .. ':' .. c.x, slot('common', 'infdisc')) end end
  card('deck:memo', 'memo:0', slot('common', 'memodeck'), { flip = true }); text('n:memo', (alen(E.MEMOS) - (G.memoAt or 0)) .. ' left', slot('common', 'memodeck', 0, 2.55), 0, 28)
  if G.pending then card('memoplay', 'memo:' .. G.pending.id, slot('common', 'memoplay')) end
  pawn('round', { 0.95, 0.82, 0.25 }, slot('common', 'round' .. math.min(G.round, E.MAXROUND)))
  pawn('heat', { 0.89, 0.34, 0.18 }, slot('common', 'heat' .. math.max(0, math.min(G.heat, 8))))
  -- the companies
  for pi, p in each(G.players) do local mat = 'mat' .. pi; local B = BOARD[mat]
    local fl = 0
    for i, m in each(p.mach) do card('floor:' .. pi .. ':m' .. i, 'mach:' .. m.id, slot(mat, 'floor' .. fl), { rot = B.rot, tap = m.ran }); fl = fl + 1 end
    for i, a in each(p.adv) do card('floor:' .. pi .. ':a' .. i, 'adv:' .. a.id, slot(mat, 'floor' .. fl), { rot = B.rot }); fl = fl + 1 end
    for i, m in each(p.shelf) do card('shelf:' .. pi .. ':' .. i, 'mach:' .. m.id, slot(mat, 'shelf', -3.6 + i * 1.25, 0, 0.02 * i), { rot = B.rot, sc = { CS * 0.8, CS * 0.8 } }) end
    for i, t in each(p.tiles) do if CARDS['res:' .. t.id] then card('tiles:' .. pi .. ':' .. i, 'res:' .. t.id, slot(mat, 'tiles', -3.0 + i * 1.0, 0, 0.02 * i), { rot = B.rot, sc = { CS * 0.8, CS * 0.8 } }) end end
    pawn('era:' .. pi, SEATCOL[pi + 1], slot(mat, 'era' .. math.min(p.era, 12)))
    local tl = E.trackLen(p)
    for k = 0, math.min(p.prog, tl) - 1 do token('pit:' .. pi .. ':' .. k, 'pitcher', slot(mat, 'trk' .. k, 0, 0, 0.05), 1.15, B.rot) end -- a pitcher on every space filled
    local cover = E.TX - tl; local cont = math.min(p.cont or 0, cover)
    for k = 0, cover - 1 do local sp = E.TX - 1 - k; chip('cover:' .. pi .. ':' .. k, k < cont and { 0.12, 0.42, 0.29 } or { 0.96, 0.77, 0.19 }, slot(mat, 'trk' .. sp), 0.5) end
    local hand = p.hand
    text('lab:name:' .. pi, (p.name or SEATCOL[pi + 1]) .. ' · era ' .. p.era .. (p.bot and ' (bot)' or ''), slot(mat, 'name', 0, -0.1), B.rot, 52, SEATCOL[pi + 1])
    local function boxAt(name) return function(du, dy, row) return slot(mat, name, du, -0.05 + (row or 0) * 0.62, 0.05 + dy) end end
    local bw = BOARD[mat].L.slots.cash[3]
    pieces('cash:' .. pi .. ':', 'coin', p.cash, boxAt('cash'), bw, B.rot)
    pieces('loy:' .. pi .. ':', 'heart', p.loy, boxAt('loy'), bw, B.rot)
    text('lab:stars:' .. pi, E.starText(p.stars), slot(mat, 'stars', 0, -0.05), B.rot, 48)
    for k = 1, math.min(p.imp or 0, 8) do local n = (p.imp or 0); local gap = math.min(0.8, (bw - 0.9) / math.max(1, n - 1)); chip('impl:' .. pi .. ':' .. k, 'gold', slot(mat, 'imp', -(math.min(n, 8) - 1) * gap / 2 + (k - 1) * gap, 0.25, 0.05), 0.42) end
    text('lab:hand:' .. pi, (hand.sweet or 0) .. '/' .. (hand.sour or 0) .. '/' .. (hand.herb or 0) .. '/' .. (hand.fizz or 0), slot(mat, 'hand', 0, -0.05), B.rot, 46)
    text('lab:inf:' .. pi, tostring(alen(p.inf)), slot(mat, 'inf', 0, -0.1), B.rot, 76)
    text('lab:note:' .. pi, (p.prog .. ' of ' .. tl .. ' pitchers to era ' .. (p.era + 1)) .. (p.jail and '\nIn custody' or ''), slot(mat, 'note', 0, -0.1), B.rot, 34)
    -- hands: ingredient cards and influence cards, hidden
    local col = SEATCOL[pi + 1]; local ht = Player[col] and Player[col].getHandTransform and Player[col].getHandTransform()
    if ht then local hp = { x = ht.position.x, y = ht.position.y, z = ht.position.z }
      for _, f in ipairs(FAMS) do local fl2 = E.FLAVOR[f]; for k = 0, (hand[f] or 0) - 1 do card('hand:' .. pi .. ':' .. f .. ':' .. k, 'ing:' .. f .. ':' .. fl2[k % alen(fl2)], hp, { hand = col, rot = B.rot }) end end
      for _, c in each(p.inf) do if CARDS['inf:' .. c.t .. ':' .. c.x] then card('hinf:' .. pi .. ':' .. c.u, 'inf:' .. c.t .. ':' .. c.x, hp, { hand = col, rot = B.rot }) end end
    end
  end
  -- what is happening
  local a = actor(); local p = P(a)
  local lines = {}
  local nl = alen(G.log); for k = math.max(0, nl - 3), nl - 1 do local t = G.log[k].text; lines[#lines + 1] = (#t > 64) and (t:sub(1, 62) .. '...') or t end
  local head = G.winner ~= nil and (P(G.winner).name .. ' wins.') or ('Round ' .. G.round .. ' · ' .. ({ stand = 'setup', biz = 'the market', place = 'the map', memo = 'payday memos' })[G.phase] .. ' · ' .. p.name .. ' to act')
  text('status', head .. '\n' .. table.concat(lines, '\n'), slot('common', 'status'), 0, 30)
end

--[[ ---------- the action panel ---------- ]]
local function esc(s) return (tostring(s):gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;'):gsub('"', '&quot;')) end
local function costTxt(x) if not x or not x.cost then return '' end local t = {}
  for _, k in ipairs(__keys(x.cost)) do local v = x.cost[k]; if v and v ~= 0 then t[#t + 1] = v .. ({ cash = ' Capital', loy = ' loyalty', cont = ' control', card = ' cards' })[k] or (v .. ' ' .. k) end end
  return #t > 0 and (' (' .. table.concat(t, ', ') .. ')') or '' end
local btns, dialog = {}, nil
local function B(id, label, x, group) if x == nil or ok(x) then btns[#btns + 1] = { id = id, label = label .. costTxt(x), group = group or 'more' } end end
local function canAct(color) if not S or not S.G or S.G.winner ~= nil then return false end
  local a = actor(); if not S.seats[a + 1].human then return false end
  return S.anyone or color == SEATCOL[a + 1] end

-- what a card on the table lets the player in turn do when clicked: key -> { label, action id }
local function cardActions()
  local out = {}
  local G = S.G; if G.winner ~= nil then return out end
  local a = actor(); if not S.seats[a + 1].human then return out end
  local p = P(a)
  if ui.sel and not (G.pending or G.offer) then -- an influence card that targets a market or a research card: choose on the table
    local c; for _, k in each(p.inf) do if k.u == ui.sel then c = k end end
    local d = c and E.ICARD[c.t]; local extra = jsA(ui.marks or {})
    if d and d.target == 'cell' then for _, cl in each(G.map.cells) do if ok(E.canPlay(G, ui.sel, cl.id, extra)) then out['tile:' .. cl.id] = { 'Choose', 'tgt_' .. cl.id } end end
    elseif d and d.target == 'tile' then for k = 0, alen(G.rrow) - 1 do if G.rrow[k] and ok(E.canPlay(G, ui.sel, k, extra)) then out['rrow:' .. k] = { 'Choose', 'tgt_' .. k } end end end
    return out
  end
  if G.pending or G.offer or ui.scrapFor or ui.disc or ui.sel or ui.pay then return out end
  if G.choice then for i, c in each(G.choice.cards) do if not c.taken then out['choice:' .. i] = { 'Keep', 'pick_' .. i } end end return out end
  if G.phase == 'biz' then
    if ok(E.canDraw(G)) then out['deck:ing'] = { 'Buy 3, keep 1' .. costTxt(E.canDraw(G)), 'draw' } end
    if ok(E.canLobby(G)) then out['deck:inf'] = { 'Buy influence' .. costTxt(E.canLobby(G)), 'lobby' } end
    for _, f in ipairs(FAMS) do local x = E.canTake(G, f); if ok(x) then out['pile:' .. f] = { 'Buy' .. costTxt(x), 'take_' .. f } end end
    for i, m in each(G.mkt) do local x = E.canBuy(G, i); if ok(x) then out['mkt:' .. i] = { 'Buy' .. costTxt(x), 'buy_' .. i } end end
    for k = 0, alen(G.rrow) - 1 do if G.rrow[k] then local x = E.canResearch(G, k); if ok(x) then out['rrow:' .. k] = { 'Research', 'research_' .. k } end end end
    for k, ad in each(G.arow) do local x = E.canHire(G, k); if ok(x) then out['arow:' .. k] = { 'Hire' .. costTxt(x), 'hire_' .. k } end end
    for i, m in each(p.mach) do local key = 'floor:' .. a .. ':m' .. i
      local run, scr = ok(E.canRun(G, i)), ok(E.canScrap(G, i))
      if run and scr then out[key] = { 'Run', 'run_' .. i, 'Scrap', 'mscrap_' .. i } elseif run then out[key] = { 'Run', 'run_' .. i } elseif scr then out[key] = { 'Scrap', 'mscrap_' .. i } end end
  elseif G.phase == 'place' then
    for _, c in each(G.map.cells) do
      local x = ui.impMode and E.canImprove(G, c.id) or E.canPlace(G, c.id)
      if ok(x) then out['tile:' .. c.id] = { ui.impMode and 'Invest' or ('Place ' .. ((x.cost and x.cost.loy) or '')), (ui.impMode and 'improve_' or 'place_') .. c.id } end
    end
  end
  return out
end
-- put the buttons on the cards, changing only the cards whose button changed
local function cardButtons()
  local want2 = (S.mode == 'full' and S.G) and cardActions() or {}
  for key, o in pairs(objs) do
    local w = want2[key]; local label = w and (w[1] .. (w[3] and ('|' .. w[3]) or '')) or nil
    if btnLast[key] ~= label and alive(o) then
      o.clearButtons()
      if w then local sc = (last[key] and last[key].kind == 'tile') and { S.tileScale or 1.4, S.tileScale or 1.4 } or (last[key] and last[key].sc) or { CS, CS }; local flip = last[key] and last[key].flip
        local two = w[3] ~= nil
        for b = 1, two and 2 or 1 do local lab = w[b * 2 - 1]; local dz = two and (b == 1 and 0.35 or -0.35) or 0
          o.createButton({ click_function = b == 1 and 'onCardClick' or 'onCardClick2', function_owner = Global, label = lab, position = { 0, flip and -0.3 or 0.3, dz }, rotation = flip and { 0, 0, 180 } or { 0, 0, 0 },
            width = 1500, height = 480, font_size = 220, color = (lab == 'Scrap') and { 0.85, 0.55, 0.45, 0.95 } or { 0.96, 0.82, 0.25, 0.95 }, hover_color = { 1, 0.9, 0.45, 1 }, font_color = { 0.17, 0.1, 0.08, 1 },
            scale = { 0.6 / sc[1], 1, 0.6 / sc[2] }, tooltip = lab }) end end
      btnLast[key] = label
    end
  end
  for key in pairs(btnLast) do if not objs[key] then btnLast[key] = nil end end
end

-- the panel: what has no card to click, grouped, and the questions the game asks
local function buildActions()
  btns, dialog = {}, nil
  local G = S.G; if G.winner ~= nil then return end
  local a = actor(); local p = P(a)
  if not S.seats[a + 1].human then return end
  if G.pending then local m = E.MEMOS[G.pending.id]
    dialog = 'Memo to ' .. p.name .. ': ' .. m.title .. '. ' .. m.body
    for i, o in each(m.opts) do local x = E.canChoose(G, i); if ok(x) then B('memo_' .. i, o.label, nil, 'answer') end end
    if #btns == 0 then B('memo_-1', 'Read it', nil, 'answer') end
    return end
  if G.choice then dialog = 'Click the card you keep, among the three you turned over.'
    for i, c in each(G.choice.cards) do if not c.taken then B('pick_' .. i, 'Keep ' .. c.n .. ' (' .. E.FNAME[c.f] .. ')', nil, 'answer') end end return end
  if ui.pay then local Y = ui.pay; local got, parts = 0, {}
    for _, f in ipairs(FAMS) do local n = Y.chosen[f] or 0; got = got + n; if n > 0 then parts[#parts + 1] = n .. ' ' .. E.FNAME[f] end end
    dialog = 'This research takes ' .. Y.need .. ' card' .. (Y.need > 1 and 's' or '') .. ' of any kind. Choose which to discard: ' .. (#parts > 0 and table.concat(parts, ', ') or 'none yet') .. ' (' .. got .. ' of ' .. Y.need .. ').'
    if got < Y.need then for _, f in ipairs(FAMS) do local left = (p.hand[f] or 0) - (Y.chosen[f] or 0); if left > 0 then B('payadd_' .. f, 'Discard ' .. E.FNAME[f] .. ' (' .. left .. ' in hand)', nil, 'answer') end end end
    if got > 0 then B('payclear', 'Start over', nil, 'answer') end
    if got == Y.need then B('payok', 'Research with these', nil, 'answer') end
    B('payno', 'Cancel', nil, 'answer'); return end
  if ui.scrapFor then dialog = 'Your floor is full. Free a slot: a machine goes to your shelf; an advisor leaves.'
    for i, m in each(p.mach) do B('scrap_' .. i, 'Scrap ' .. m.name, nil, 'answer') end
    for i, ad in each(p.adv) do B('scrap_a' .. i, 'Let ' .. ad.name .. ' go', nil, 'answer') end
    B('noscrap', 'Cancel', nil, 'answer'); return end
  if G.offer then dialog = 'Your research turned up ' .. G.offer.a.name .. ' (' .. G.offer.a.role .. '). ' .. G.offer.a.text
    B('otake', 'Hire for ' .. (G.offer.a.price or 0) .. ' Capital', E.canTakeOffer(G), 'answer'); B('opass', 'Pass', nil, 'answer'); return end
  if ui.disc then local D = ui.disc; dialog = 'Choose ' .. D.need .. ' influence card(s) to discard.'
    for _, c in each(p.inf) do if c.u ~= D.u then B('dpick_' .. c.u, (D.chosen[c.u] and '[x] ' or '[ ] ') .. E.ICARD[c.t].name, nil, 'answer') end end
    B('dok', 'Done', nil, 'answer'); B('dno', 'Cancel', nil, 'answer'); return end
  if ui.sel then local c; for _, k in each(p.inf) do if k.u == ui.sel then c = k end end
    if c then local d = E.ICARD[c.t]; dialog = d.name .. ': choose a target. ' .. d.text
      local extra = jsA(ui.marks or {})
      if d.target == 'player' then for pi, q in each(G.players) do local x = E.canPlay(G, ui.sel, pi, extra); if ok(x) then B('tgt_' .. pi, q.name, nil, 'answer') end end
      elseif d.target == 'cell' then dialog = d.name .. ': click a market on the map. ' .. d.text
      elseif d.target == 'tile' then dialog = d.name .. ': click a card in the research row. ' .. d.text
      elseif d.target == 'rtile' then for pi, q in each(G.players) do for k, t in each(q.tiles) do local x = E.canPlay(G, ui.sel, pi * 1000 + k, extra); if ok(x) then B('tgt_' .. (pi * 1000 + k), q.name .. ': ' .. t.name, nil, 'answer') end end end end
      B('nosel', 'Cancel', nil, 'answer') end
    return end
  if G.phase == 'biz' then
    dialog = 'Click a card to act: buy a machine, ingredients (deck or piles) or influence (its deck), research, hire, or run one of your machines. One thing a turn.'
    if ok(E.canBail(G)) then B('bail', 'Post bail', E.canBail(G), 'more') end
    for i, m in each(p.mach) do
      B('frun_' .. i, 'Free run: ' .. m.name, E.canRun(G, i, 'free'), 'more'); B('rerun_' .. i, 'Re-run ' .. m.name, E.canRun(G, i, 'rerun'), 'more'); B('hal_' .. i, 'HAL runs ' .. m.name, E.canRun(G, i, true), 'more') end
    for _, c in each(p.inf) do B('iplay_' .. c.u, 'Play ' .. E.ICARD[c.t].name, { ok = true }, 'influence') end
    B('sell_1', 'Sell Paul 1 Acidic', E.canSell(G), 'more'); if (p.hand.sour or 0) >= 2 then B('sell_2', 'Sell Paul 2 Acidic', E.canSell(G), 'more') end
    for pi, q in each(G.players) do if pi ~= a then for k, ad in each(q.adv) do B('poach_' .. pi .. '_' .. k, 'Hire away ' .. ad.name, E.canHire(G, k, pi), 'more'); B('hit_' .. pi .. '_' .. k, 'Hit ' .. ad.name, E.canHit(G, pi, k), 'more') end end end
    B('pass', 'Pass for the rest of the market', nil, 'end')
  elseif G.phase == 'place' then
    dialog = ui.impMode and 'Click a market you control to put a capital token on it.' or ('Click a market to place a loyalty token. You have ' .. p.loy .. ' loyalty.')
    if (p.imp or 0) > 0 then B('impmode', ui.impMode and 'Back to loyalty tokens' or ('Place a capital token (' .. p.imp .. ' to place)'), nil, 'more') end
    for _, c in each(p.inf) do B('iplay_' .. c.u, 'Play ' .. E.ICARD[c.t].name, { ok = true }, 'influence') end
    B('pass', 'Done placing', nil, 'end')
  end
end

local function setupXml()
  local opts = { 'Human', 'Bot: champion', 'Bot: generalist', 'Bot: manufacturer', 'Bot: producer', 'Bot: distributor' }
  local seats = ''
  for i = 1, 3 do local o = ''; for _, x in ipairs(opts) do o = o .. '<Option' .. ((S.setup.seats[i] == x) and ' selected="true"' or '') .. '>' .. x .. '</Option>' end
    seats = seats .. '<HorizontalLayout preferredHeight="40" spacing="8"><Text color="' .. ({ '#e05a4c', '#4b8fe0', '#43b06c' })[i] .. '" fontSize="20" preferredWidth="110">' .. SEATCOL[i] .. '</Text><Dropdown id="seat' .. i .. '" onValueChanged="uiSeat" preferredWidth="330">' .. o .. '</Dropdown></HorizontalLayout>' end
  local function radio(id, val, label, cur) return '<Button id="' .. id .. '_' .. val .. '" onClick="uiSetup" colors="' .. (cur == val and '#f4d03f|#ffe27a|#d8b52a|#888888' or '#efe6d2|#ffffff|#cfc4aa|#888888') .. '" preferredHeight="36">' .. label .. '</Button>' end
  return '<Panel id="setup" width="560" height="590" color="#2b1a14f2" outline="#f4d03f" outlineSize="2 2"><VerticalLayout padding="18" spacing="10" childForceExpandHeight="false">' ..
    '<Text fontSize="34" fontStyle="Bold" color="#f4d03f">Sour Empire</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('np', 2, 'Two players', S.setup.np) .. radio('np', 3, 'Three players', S.setup.np) .. '</HorizontalLayout>' ..
    seats ..
    '<Text fontSize="15" color="#cfc4aa" alignment="MiddleLeft">The first human seat is Red; whoever presses Set up sits there.</Text>' ..
    '<Text fontSize="18" color="#efe6d2" alignment="MiddleLeft">How much should the table enforce?</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('mode', 'full', 'Full rules', S.setup.mode) .. radio('mode', 'arith', 'Arithmetic only', S.setup.mode) .. radio('mode', 'log', 'None, just log', S.setup.mode) .. '</HorizontalLayout>' ..
    '<Text fontSize="15" color="#cfc4aa" alignment="MiddleLeft">Bots need full rules. In the other modes, bot seats are left empty.</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('speed', 0.4, 'Bots fast', S.setup.speed) .. radio('speed', 1.2, 'Bots steady', S.setup.speed) .. radio('speed', 2.5, 'Bots slow', S.setup.speed) .. '</HorizontalLayout>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('anyone', 'yes', 'Anyone may act for human seats', S.setup.anyone) .. radio('anyone', 'no', 'Only the seated player', S.setup.anyone) .. '</HorizontalLayout>' ..
    '<Button id="start" onClick="uiStart" preferredHeight="50" fontSize="22" colors="#2f9e5b|#43b06c|#227a45|#888888" textColor="#ffffff">Set up the table</Button>' ..
    '</VerticalLayout></Panel>'
end
local GROUPS = { { 'answer', 'Choose' }, { 'ingredients', 'Ingredients' }, { 'influence', 'Influence' }, { 'more', 'Also' }, { 'scrap', 'Scrap to shelf' }, { 'end', 'Done' } }
local function panelXml()
  local x = '<Panel id="tools" rectAlignment="UpperRight" width="230" height="' .. (S.mode == 'full' and 90 or 250) .. '" offsetXY="-10 -60" color="#2b1a14e6"><VerticalLayout padding="6" spacing="4">'
  x = x .. '<Button id="rec" onClick="uiRecord">Write the record to the Notebook</Button>'
  if S.mode ~= 'full' then
    x = x .. '<Button id="snap" onClick="uiSnap">Note the table as it stands</Button>'
    if S.mode == 'arith' then x = x .. '<Button id="payday" onClick="uiPayday">Work out payday</Button><Button id="stipend" onClick="uiStipend">Loyalty for the map phase</Button><Button id="costs" onClick="uiCosts">Show token costs</Button>' end
  end
  x = x .. '<Button id="newgame" onClick="uiNew">New game</Button></VerticalLayout></Panel>'
  if S.mode ~= 'full' or not S.G then return x end
  local G = S.G
  if G.winner ~= nil then return x .. '<Panel id="act" rectAlignment="MiddleLeft" width="380" height="60" offsetXY="70 -40" color="#2b1a14ee"><Text fontSize="22" color="#f4d03f">' .. esc(P(G.winner).name .. ' wins.') .. '</Text></Panel>' end
  buildActions()
  local a = actor(); local col = SEATCOL[a + 1]
  if not S.seats[a + 1].human then
    return x .. '<Panel id="act" rectAlignment="MiddleLeft" width="380" height="44" offsetXY="70 -40" color="#2b1a14cc"><Text fontSize="17" color="#efe6d2">' .. esc(P(a).name .. ' (bot) is thinking...') .. '</Text></Panel>' end
  local vis = S.anyone and '' or (' visibility="' .. col .. '"')
  local W, BW = 380, 340
  local rowsXml, h = '', 52
  if dialog then local lines = math.ceil(#dialog / 46); rowsXml = rowsXml .. '<Text fontSize="14" color="#efe6d2" preferredHeight="' .. (lines * 18 + 6) .. '" alignment="UpperLeft">' .. esc(dialog) .. '</Text>'; h = h + lines * 18 + 12 end
  for _, g in ipairs(GROUPS) do local list = {}; for _, b in ipairs(btns) do if b.group == g[1] then list[#list + 1] = b end end
    if #list > 0 then
      rowsXml = rowsXml .. '<Text fontSize="13" color="#f4d03f" preferredHeight="18" alignment="LowerLeft">' .. g[2] .. '</Text>'; h = h + 24
      for _, b in ipairs(list) do
        rowsXml = rowsXml .. '<Button id="a_' .. b.id .. '" onClick="uiAct" fontSize="14" preferredHeight="32"' .. (g[1] == 'end' and ' colors="#f4d03f|#ffe27a|#d8b52a|#888888"' or '') .. '>' .. esc(b.label) .. '</Button>'; h = h + 38 end
    end end
  h = math.min(h, 1000)
  x = x .. '<Panel id="act" rectAlignment="MiddleLeft" width="' .. W .. '" height="' .. h .. '" offsetXY="70 -40" color="#2b1a14ee"' .. vis .. '><VerticalLayout padding="12 12 10 10" spacing="6" childForceExpandHeight="false" childAlignment="UpperLeft">'
  x = x .. '<Text fontSize="17" color="' .. ({ Red = '#ff8a7a', Blue = '#8fbaff', Green = '#7fdc9f' })[col] .. '" preferredHeight="24" fontStyle="Bold" alignment="MiddleLeft">' .. esc(P(a).name .. ' to act · round ' .. G.round .. ' · ' .. ({ stand = 'setup', biz = 'the market', place = 'the map', memo = 'payday' })[G.phase]) .. '</Text>' .. rowsXml
  x = x .. '</VerticalLayout></Panel>'
  return x
end
local lastXml = nil
local function refreshUI()
  local x = S.mode == 'setup' and setupXml() or (S.mode == 'loading' and '<Panel width="420" height="60" color="#2b1a14ee"><Text fontSize="20" color="#f4d03f">Laying out the table...</Text></Panel>' or panelXml())
  if x ~= lastXml then UI.setXml(x); lastXml = x end
end

--[[ ---------- the record ---------- ]]
local function trace(e) local okd, tb = pcall(function() return debug.traceback(tostring(e), 2) end); return okd and tb or tostring(e) end
local function now() local okk, t = pcall(os.time); return okk and t or 0 end
local function recPush(e) S.log = S.log or {}; e.t = now(); S.log[#S.log + 1] = e end
local function recordText()
  if S.mode == 'full' and S.G then return E.recordText(S.G, VERSION) end
  local out = { 'SOUR EMPIRE TABLE RECORD v1 | ' .. VERSION .. ' | mode ' .. S.mode .. ' | ' .. (S.np or 0) .. ' players | ' .. #(S.log or {}) .. ' events' }
  out[#out + 1] = JSON.encode({ meta = { mode = S.mode, seats = S.seats, saved = (pcall(os.date, '!%Y') and os.date('!%Y-%m-%dT%H:%M:%SZ') or ''),
    key = 'ev = one move or helper: who (player colour), what (picked up, dropped, payday...), obj (the piece), from/to (board:slot, map:market, Colour:slot or Colour:hand). snap = the table as it stood.' } })
  for _, e in ipairs(S.log or {}) do out[#out + 1] = JSON.encode(e) end
  return table.concat(out, '\n')
end
local function writeNotebook()
  local t = recordText(); local CH = 60000; local parts = {}
  for i = 1, #t, CH do parts[#parts + 1] = t:sub(i, i + CH - 1) end
  -- replace every earlier record tab, so the tabs always hold exactly one record, in order
  local tabs = Notes.getNotebookTabs() or {}
  for i = #tabs, 1, -1 do local tb = tabs[i]; if tb.title and tb.title:sub(1, 18) == 'Sour Empire record' then Notes.removeNotebookTab(tb.index) end end
  for k, part in ipairs(parts) do
    Notes.addNotebookTab({ title = 'Sour Empire record' .. (#parts > 1 and (' ' .. k .. ' of ' .. #parts) or ''), body = part, color = 'Grey' })
  end
  broadcastToAll('Record written to the Notebook (' .. math.floor(#t / 1024) .. ' KB' .. (#parts > 1 and (', ' .. #parts .. ' tabs') or '') .. '). Open it, select all, copy.', { 1, 0.9, 0.5 })
end

--[[ ---------- the turn loop ---------- ]]
local function sync()
  if S.mode == 'full' and S.G then buildWant(); apply(); Wait.frames(cardButtons, 2) end
  refreshUI()
  if S.mode == 'full' and S.G and S.G.winner ~= nil and not S.wroteEnd then S.wroteEnd = true; broadcastToAll(P(S.G.winner).name .. ' wins.', { 1, 0.9, 0.4 }); writeNotebook() end
  if S.mode == 'full' and S.G and S.G.winner == nil and not S.seats[actor() + 1].human and not busy then
    busy = true
    Wait.time(function() busy = false; if S.G and S.G.winner == nil and not S.seats[actor() + 1].human then
      local okk, err = pcall(function() E.botStep(S.G) end); if not okk then broadcastToAll('Bot error: ' .. tostring(err), { 1, 0.4, 0.4 }) end
      sync() end end, S.speed or 1.2)
  end
end
local function doAct(id)
  local G = S.G; local a = actor(); local p = P(a)
  local function num(s) return tonumber(s) end
  local cmd, r1, r2 = id:match('^([%a]+)_?([^_]*)_?(.*)$')
  local acted = false
  if cmd == 'memo' then acted = E.choose(G, num(r1))
  elseif cmd == 'pick' then acted = E.pick(G, num(r1))
  elseif cmd == 'draw' then acted = E.draw(G)
  elseif cmd == 'take' then acted = E.take(G, r1)
  elseif cmd == 'run' then acted = E.run(G, num(r1))
  elseif cmd == 'frun' then acted = E.run(G, num(r1), nil, 'free')
  elseif cmd == 'rerun' then acted = E.run(G, num(r1), nil, 'rerun')
  elseif cmd == 'hal' then acted = E.run(G, num(r1), nil, true)
  elseif cmd == 'buy' then if E.used(p) >= E.SLOTS then ui.scrapFor = { kind = 'buy', i = num(r1) } else acted = E.buy(G, num(r1)) end
  elseif cmd == 'hire' then if E.used(p) >= E.SLOTS then ui.scrapFor = { kind = 'hire', k = num(r1) } else acted = E.hire(G, num(r1)) end
  elseif cmd == 'poach' then if E.used(p) >= E.SLOTS then ui.scrapFor = { kind = 'hire', k = num(r2), from = num(r1) } else acted = E.hire(G, num(r2), num(r1)) end
  elseif cmd == 'otake' then if E.used(p) >= E.SLOTS then ui.scrapFor = { kind = 'offer' } else acted = E.takeOffer(G) end
  elseif cmd == 'opass' then acted = E.declineOffer(G)
  elseif cmd == 'scrap' then local s = r1:sub(1, 1) == 'a' and r1 or num(r1); local f = ui.scrapFor; ui.scrapFor = nil
    if f.kind == 'buy' then acted = E.buy(G, f.i, s) elseif f.kind == 'offer' then acted = E.takeOffer(G, s) else acted = E.hire(G, f.k, f.from, s) end
  elseif cmd == 'noscrap' then ui.scrapFor = nil
  elseif cmd == 'hit' then acted = E.hit(G, num(r1), num(r2))
  elseif cmd == 'mscrap' then acted = E.scrapM(G, num(r1))
  elseif cmd == 'research' then local k = num(r1); local need = E.researchPay(G, k) or 0; local fams = 0
    for _, f in ipairs(FAMS) do if (p.hand[f] or 0) > 0 then fams = fams + 1 end end
    if need > 0 and fams > 1 then ui.pay = { k = k, need = need, chosen = {} } else acted = E.research(G, k) end
  elseif cmd == 'payadd' then local Y = ui.pay; Y.chosen[r1] = (Y.chosen[r1] or 0) + 1
  elseif cmd == 'payclear' then ui.pay.chosen = {}
  elseif cmd == 'payno' then ui.pay = nil
  elseif cmd == 'payok' then local Y = ui.pay; local list = {}; for _, f in ipairs(FAMS) do for i = 1, (Y.chosen[f] or 0) do list[#list + 1] = f end end
    ui.pay = nil; acted = E.research(G, Y.k, nil, jsA(list)); if not acted then broadcastToColor('Those cards do not pay for it.', SEATCOL[a + 1], { 1, 0.6, 0.6 }) end
  elseif cmd == 'bail' then acted = E.bail(G)
  elseif cmd == 'lobby' then acted = E.lobby(G)
  elseif cmd == 'sell' then acted = E.sell(G, num(r1))
  elseif cmd == 'place' then acted = E.place(G, r1 .. (r2 ~= '' and ('_' .. r2) or ''))
  elseif cmd == 'improve' then acted = E.improve(G, r1); if acted then ui.impMode = false end
  elseif cmd == 'pass' then ui.impMode = false; acted = E.pass(G)
  elseif cmd == 'impmode' then ui.impMode = not ui.impMode
  elseif cmd == 'iplay' then local u = num(r1); local c; for _, k in each(p.inf) do if k.u == u then c = k end end
    local d = c and E.ICARD[c.t]
    if d and d.extra then ui.disc = { need = d.extra, u = u, chosen = {} }
    elseif d and d.target then ui.sel = u; ui.marks = {}
    elseif d then acted = E.play(G, u, nil, jsA({})) end
  elseif cmd == 'dpick' then local u = num(r1); local D = ui.disc; local cnt = 0; for _ in pairs(D.chosen) do cnt = cnt + 1 end
    if D.chosen[u] then D.chosen[u] = nil elseif cnt < D.need then D.chosen[u] = true end
  elseif cmd == 'dok' then local D = ui.disc; ui.disc = nil; local marks = {}; for u in pairs(D.chosen) do marks[#marks + 1] = u end
    local c; for _, k in each(p.inf) do if k.u == D.u then c = k end end
    if c and E.ICARD[c.t].target then ui.sel = D.u; ui.marks = marks else acted = E.play(G, D.u, nil, jsA(marks)) end
  elseif cmd == 'dno' then ui.disc = nil
  elseif cmd == 'tgt' then local t = num(r1) or r1; acted = E.play(G, ui.sel, t, jsA(ui.marks or {})); if acted then ui.sel = nil; ui.marks = nil end
  elseif cmd == 'nosel' then ui.sel = nil; ui.marks = nil
  end
  return acted
end
function onCardClick(obj, color, alt)
  if not canAct(color) then broadcastToColor('Not your turn.', color, { 1, 0.6, 0.6 }); return end
  local key = (obj.getGMNotes() or ''):match('^se|(.+)$'); if not key then return end
  local w = cardActions()[key]; if not w then sync(); return end
  local id = (alt == 2) and w[4] or w[2]; if not id then sync(); return end
  local okk, err = xpcall(function() doAct(id) end, trace); if not okk then broadcastToAll('Error: ' .. tostring(err), { 1, 0.4, 0.4 }); print(err) end
  sync()
end
function onCardClick2(obj, color) onCardClick(obj, color, 2) end
function uiAct(player, value, id)
  if not canAct(player.color) then broadcastToColor('Not your turn.', player.color, { 1, 0.6, 0.6 }); return end
  local okk, err = xpcall(function() doAct(id:sub(3)) end, trace); if not okk then broadcastToAll('Error: ' .. tostring(err), { 1, 0.4, 0.4 }); print(err) end
  sync()
end

--[[ ---------- setup ---------- ]]
local function seatsFromSetup()
  local seats = {}
  for i = 1, S.setup.np do local v = S.setup.seats[i]; local human = (v == 'Human')
    seats[i] = { human = human or S.setup.mode ~= 'full', style = v } end
  return seats
end
local function newEngineGame()
  local list = {}
  for i, s in ipairs(S.seats) do local o = { name = SEATCOL[i], bot = not s.human }
    if not s.human then
      if s.style == 'Bot: champion' then o.gen = GENOMES[((i - 1) % #GENOMES) + 1]
      else o.spec = ({ ['Bot: generalist'] = 'gen', ['Bot: manufacturer'] = 'mfg', ['Bot: producer'] = 'prd', ['Bot: distributor'] = 'dis' })[s.style] or 'gen' end end
    local keys = { 'name', 'bot' }; if o.gen then keys[#keys + 1] = 'gen' end if o.spec then keys[#keys + 1] = 'spec' end
    list[i] = jsO(o, keys) end
  return E.newGame(jsA(list))
end
-- a loose coin or loyalty token for the manual modes
local function pieceData(img, n, p, rot)
  local k = (S.tileScale or 1.4) * 0.78 / 2.85
  if n == nil then -- a piece without a value (the pitcher)
    return { Name = 'Custom_Tile', Transform = tf(p, rot or 0, { k, k }), Locked = false, GMNotes = 'se|' .. img, Nickname = 'Pitcher',
      CustomImage = { ImageURL = IMG .. img .. '.png', ImageSecondaryURL = '', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 2, Thickness = 0.1, Stackable = true, Stretch = true } } }
  end
  return { Name = 'Custom_Tile', Transform = tf(p, rot or 0, { k, k }), Locked = false, GMNotes = 'se|' .. img .. ':' .. n, Nickname = (img == 'coin' and 'Capital ' or 'Loyalty ') .. n,
    CustomImage = { ImageURL = IMG .. img .. '-' .. n .. '.png', ImageSecondaryURL = '', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 2, Thickness = 0.1, Stackable = true, Stretch = true } } }
end
-- put an amount into a company's box as 5s and 1s
local function payPieces(img, amount, col, slotName)
  local pi; for i, c in ipairs(SEATCOL) do if c == col then pi = i - 1 end end; if not pi or amount <= 0 then return end
  local mat = 'mat' .. pi; local fives, ones = math.floor(amount / 5), amount % 5; local n = 0
  local function one(v) local du = -1.0 + (n % 4) * 0.66; local q = slot(mat, slotName, du, 0.3, 0.6 + math.floor(n / 4) * 0.15); n = n + 1; spawnObjectData({ data = pieceData(img, v, q, BOARD[mat].rot) }) end
  for i = 1, fives do one(5) end; for i = 1, ones do one(1) end
end
-- manual modes: the same deal as the engine's, laid out as loose pieces players move themselves
local function dealPhysical(G)
  want = {}
  local n = alen(G.players)
  S.cellName = {}
  for _, c in each(G.map.cells) do S.cellName[c.id] = c.name
    tileOf('tile:' .. c.id, c.name, slot('map', c.id, 0, 0, 0.1))
    local at = function(du, dv) return slot('map', c.id, du, dv, 0.3) end
    if c.home ~= nil then card('stand:' .. c.id, 'stand:' .. c.home, at(-1.02, -1.02), { sc = { 0.72 / CARD_W, 0.72 / CARD_H } }) end
    if c.bonus then local bk; for bi, b in each(E.BONUS) do for k in pairs(b) do if c.bonus[k] == b[k] then bk = bi end end end
      if bk then card('bonus:' .. c.id, 'bonus:' .. bk, at(1.02, -1.02), { sc = { 0.72 / CARD_W, 0.72 / CARD_H } }) end end
    if c.link then card('air:' .. c.id, 'air:' .. c.link, at(-1.12, 0.1), { sc = { 0.6 / CARD_W, 0.6 / CARD_H } }) end
  end
  apply()
  for key, o in pairs(objs) do if o.setLock and key:sub(1, 5) == 'tile:' then o.setLock(true) end end
  -- decks, as real decks, in the engine's order (the top card is the last one the engine would draw)
  local function deck(key, keys, p, flip)
    if #keys == 0 then return end
    local cds, ids, cd = {}, {}, {}
    for i = #keys, 1, -1 do local c = CARDS[keys[i]]; if c then local d = cardData('d', keys[i], p, 0, { CS, CS }, flip, false); d.GMNotes = 'se|c:' .. keys[i]; cds[#cds + 1] = d; ids[#ids + 1] = d.CardID
      for k, v in pairs(d.CustomDeck) do cd[k] = v end end end
    if #cds == 1 then cds[1].Transform = tf(p, 0, { CS, CS }, flip); objs[key] = spawnObjectData({ data = cds[1] }); return end
    objs[key] = spawnObjectData({ data = { Name = 'Deck', Transform = tf(p, 0, { CS, CS }, flip), DeckIDs = ids, CustomDeck = cd, ContainedObjects = cds, GMNotes = 'se|' .. key } })
  end
  local ing = {}; for _, c in each(G.deck) do ing[#ing + 1] = 'ing:' .. c.f .. ':' .. c.n end; deck('deck:ing', ing, slot('common', 'ideck'), true)
  local mach = {}; for _, m in each(G.mdeck) do mach[#mach + 1] = 'mach:' .. m.id end; deck('deck:mach', mach, slot('common', 'mdeck'), true)
  local res = {}; for _, c in each(G.rdeck) do res[#res + 1] = (c.kind == 'adv' and 'adv:' or 'res:') .. c.id end; deck('deck:res', res, slot('common', 'rdeck'), true)
  local inf = {}; for _, c in each(G.ideck) do inf[#inf + 1] = 'inf:' .. c.t .. ':' .. c.x end; deck('deck:inf', inf, slot('common', 'infdeck'), true)
  local memo = {}; for i = alen(E.MEMOS) - 1, 0, -1 do memo[#memo + 1] = 'memo:' .. i end; deck('deck:memo', memo, slot('common', 'memodeck'), true)
  local loose = function(key, ck, p, flip) local d = cardData(key, ck, p, 0, { CS, CS }, flip, false); objs[key] = spawnObjectData({ data = d }) end
  for i, m in each(G.mkt) do loose('mkt:' .. i, 'mach:' .. m.id, slot('common', 'mkt' .. i)) end
  for i = 0, alen(G.rrow) - 1 do local c = G.rrow[i]; if c then loose('rrow:' .. i, 'res:' .. c.id, slot('common', 'rrow' .. i), true) end end
  for i, a in each(G.arow) do loose('arow:' .. i, 'adv:' .. a.id, slot('common', 'arow' .. i)) end
  -- each company: bare hands, starting cards in hand, counters, chips, markers
  for pi, p in each(G.players) do local mat = 'mat' .. pi; local B = BOARD[mat]; local col = SEATCOL[pi + 1]
    local d = cardData('m', 'mach:hands', slot(mat, 'floor0'), B.rot, { CS, CS }, false, false); d.GMNotes = 'se|c:mach:hands'; objs['start:' .. pi] = spawnObjectData({ data = d })
    local ht = Player[col].getHandTransform and Player[col].getHandTransform()
    if ht then for _, f in ipairs(FAMS) do for k = 1, (p.hand[f] or 0) do local h = cardData('h', 'ing:' .. f .. ':' .. E.FLAVOR[f][(k - 1) % 5], { x = ht.position.x, y = ht.position.y + 2, z = ht.position.z }, B.rot, { CS, CS }, false, false); h.GMNotes = 'se|c:ing:' .. f; spawnObjectData({ data = h, callback_function = function(obj) Wait.condition(function() pcall(function() obj.deal(1, col) end) end, function() return loaded(obj) end, 10) end }) end end end
    payPieces('coin', p.cash, col, 'cash'); payPieces('heart', p.loy, col, 'loy')
    for _, st in ipairs({ { 'stars', 0 }, { 'imp', 0 } }) do
      local q = slot(mat, st[1], 0, 0.15, 0.1)
      objs['ctr:' .. pi .. ':' .. st[1]] = spawnObjectData({ data = { Name = 'Counter', Transform = tf(q, B.rot, { 0.9, 0.9 }), GMNotes = 'se|ctr:' .. col .. ':' .. st[1], Counter = { value = st[2] } }, callback_function = function(o) if o.Counter then o.Counter.setValue(st[2]) end end })
    end
    objs['bag:' .. pi] = spawnObjectData({ data = { Name = 'Infinite_Bag', Transform = tf(slot(mat, 'note', 0, 0, 0.3), B.rot, { 0.8, 0.8 }), ColorDiffuse = colorOf(col), Nickname = col .. ' loyalty tokens',
      ContainedObjects = { { Name = 'Chip_10', ColorDiffuse = colorOf(col), Transform = tf({ x = 0, y = 0, z = 0 }, 0, { 0.55, 0.55 }), GMNotes = 'se|loy:' .. col } } } })
    objs['era:' .. pi] = spawnObjectData({ data = { Name = 'PlayerPawn', Transform = tf(slot(mat, 'era1'), 0, { 0.45, 0.45 }), ColorDiffuse = colorOf(col), Nickname = col .. ' era', GMNotes = 'se|era:' .. col } })
    for k = 1, (p.cont or 0) do objs['cont:' .. pi .. ':' .. k] = spawnObjectData({ data = { Name = 'Chip_10', Transform = tf(slot(mat, 'trk' .. (E.TX - k), 0, 0, 0.2), 0, { 0.5, 0.5 }), ColorDiffuse = { r = 0.12, g = 0.42, b = 0.29 }, Nickname = 'control token', GMNotes = 'se|cont:' .. col } }) end
  end
  for i, sp in ipairs({ { 'coin', 1 }, { 'coin', 5 }, { 'heart', 1 }, { 'heart', 5 }, { 'pitcher' } }) do
    local d = pieceData(sp[1], sp[2], { x = 0, y = 0, z = 0 })
    if sp[1] == 'pitcher' then d.CustomImage.ImageURL = IMG .. 'pitcher.png'; d.GMNotes = 'se|pitcher'; d.Nickname = 'Pitcher'; local k = (S.tileScale or 1.4) * 1.15 / 2.85; d.Transform.scaleX = k; d.Transform.scaleZ = k end
    objs['supply:' .. i] = spawnObjectData({ data = { Name = 'Infinite_Bag', Transform = tf(slot('common', 'status', -6 + (i - 1) * 2.4, 0.2, 0.3), 0, { 0.75, 0.75 }),
      ColorDiffuse = sp[1] == 'coin' and { r = 0.89, g = 0.67, b = 0.11 } or (sp[1] == 'pitcher' and { r = 0.96, g = 0.82, b = 0.25 } or { r = 0.85, g = 0.28, b = 0.23 }), Nickname = sp[1] == 'pitcher' and 'Pitchers' or ((sp[1] == 'coin' and 'Capital ' or 'Loyalty ') .. sp[2] .. 's'), GMNotes = 'se|supply', ContainedObjects = { d } } })
  end
  objs['bag:gold'] = spawnObjectData({ data = { Name = 'Infinite_Bag', Transform = tf(slot('common', 'status', -6.5, 0.6, 0.3), 0, { 0.8, 0.8 }), ColorDiffuse = { r = 0.89, g = 0.67, b = 0.11 }, Nickname = 'Capital tokens',
    ContainedObjects = { { Name = 'Chip_1000', ColorDiffuse = { r = 0.89, g = 0.67, b = 0.11 }, Transform = tf({ x = 0, y = 0, z = 0 }, 0, { 0.42, 0.42 }), GMNotes = 'se|imp' } } } })
  objs['round'] = spawnObjectData({ data = { Name = 'PlayerPawn', Transform = tf(slot('common', 'round1'), 0, { 0.45, 0.45 }), ColorDiffuse = { r = 0.95, g = 0.82, b = 0.25 }, Nickname = 'round', GMNotes = 'se|round' } })
  objs['heat'] = spawnObjectData({ data = { Name = 'PlayerPawn', Transform = tf(slot('common', 'heat0'), 0, { 0.45, 0.45 }), ColorDiffuse = { r = 0.89, g = 0.34, b = 0.18 }, Nickname = 'Heat', GMNotes = 'se|heat' } })
  want = {}
end

-- reading a physical table back: who controls which market, and capital tokens on it
local function readMap()
  local cells = {}
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''
    local kind, who = note:match('^se|(loy):(%a+)$'); if not kind and note == 'se|imp' then kind = 'imp' end
    if kind then local w = where(o.getPosition()); local name = w:match('^map:(.+)$')
      if name then cells[name] = cells[name] or { tok = {}, imp = 0 }
        if kind == 'imp' then cells[name].imp = cells[name].imp + 1 else cells[name].tok[who] = (cells[name].tok[who] or 0) + 1 end end end end
  return cells
end
local function counters()
  local out = {}
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''
    local col, what = note:match('^se|ctr:(%a+):(%a+)$'); if col and o.Counter then out[col] = out[col] or { objs = {} }; out[col][what] = o.Counter.getValue(); out[col].objs[what] = o end
    local img, v = note:match('^se|(%a+):(%d)$')
    if (img == 'coin' or img == 'heart') then local w = where(o.getPosition()); local c2, sl = w:match('^(%a+):(%a+)$')
      if c2 and RGB[c2] and ((img == 'coin' and sl == 'cash') or (img == 'heart' and sl == 'loy')) then out[c2] = out[c2] or { objs = {} }; out[c2][sl] = (out[c2][sl] or 0) + tonumber(v) end end end
  for _, col in ipairs(SEATCOL) do if out[col] then out[col].cash = out[col].cash or 0; out[col].loy = out[col].loy or 0 end end
  return out
end
local function controlOf(cell) local best, who, tie = 0, nil, false
  for col, k in pairs(cell.tok) do if k > best then best, who, tie = k, col, false elseif k == best then tie = true end end
  return (best > 0 and not tie) and who or nil end
local function snapshot(why)
  local snap = { what = 'snap', why = why, map = {}, players = {} }
  for name, c in pairs(readMap()) do snap.map[name] = { tok = c.tok, imp = c.imp, owner = controlOf(c) } end
  for col, c in pairs(counters()) do snap.players[col] = { cash = c.cash, loy = c.loy, stars = c.stars, imp = c.imp } end
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''
    local ck = note:match('^se|c:(.+)$'); if ck then local w = where(o.getPosition()); local col, sl = w:match('^(%a+):(%a+%d*)$')
      if col and RGB[col] then local pl = snap.players[col] or {}; snap.players[col] = pl; pl.cards = pl.cards or {}; pl.cards[#pl.cards + 1] = sl .. ':' .. ck end end end
  for _, col in ipairs(SEATCOL) do local okh, hand = pcall(function() return Player[col].getHandObjects() end)
    if okh and hand then local pl = snap.players[col] or {}; snap.players[col] = pl; pl.hand = {}; for _, o in ipairs(hand) do pl.hand[#pl.hand + 1] = (o.getGMNotes() or ''):gsub('^se|c:', '') end end end
  recPush(snap); return snap
end

--[[ ---------- arithmetic helpers (the table is the truth; these only count) ---------- ]]
local function mapYields(name) local k = CARDS['tile:' .. name]; local y = { 1, 2, 3 }
  local inner = false; for _, w in each(E.WORLD) do if w == name then inner = true end end
  for _, w in each(E.ROUGHN) do if w == name then inner = true end end
  local hot = false; for _, w in each(E.HOTN) do if w == name then hot = true; inner = true end end
  for i = 1, 3 do y[i] = E.IMPY[i - 1] + (inner and E.IMPC or 0) + (hot and E.IMPC or 0) end
  return y end
function uiPayday(player)
  local cells = readMap(); local ctr = counters(); local res = {}
  for _, col in ipairs(SEATCOL) do if ctr[col] then res[col] = { markets = 0, tokens = 0 } end end
  for name, c in pairs(cells) do local w = controlOf(c); if w and res[w] then res[w].markets = res[w].markets + 1
    local y = mapYields(name); for k = 1, math.min(3, c.imp) do res[w].tokens = res[w].tokens + y[k] end end end
  local lines = {}
  for col, r in pairs(res) do local pay = E.income(r.markets) + r.tokens
    lines[#lines + 1] = col .. ': ' .. r.markets .. ' markets, +' .. pay .. ' Capital (' .. E.INCB .. ' base + ' .. (E.INCK * r.markets) .. ' markets + ' .. r.tokens .. ' from capital tokens). Advisor payday effects are not counted.'
    payPieces('coin', pay, col, 'cash')
    recPush({ what = 'payday', who = col, markets = r.markets, pay = pay, tokens = r.tokens }) end
  table.sort(lines); broadcastToAll('Payday. ' .. table.concat(lines, '  '), { 1, 0.9, 0.5 }); snapshot('payday')
end
function uiStipend(player)
  local lines = {}
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''; local col = note:match('^se|era:(%a+)$')
    if col then local w = where(o.getPosition()); local era = tonumber((w:match(':era(%d+)$')) or 1) or 1
      local add = E.LOYE[era - 1] or 1; local ctr = counters()[col]
      payPieces('heart', add, col, 'loy')
      lines[#lines + 1] = col .. ' (era ' .. era .. ') +' .. add; recPush({ what = 'stipend', who = col, era = era, add = add }) end end
  table.sort(lines); broadcastToAll('Loyalty for the map: ' .. table.concat(lines, ', ') .. '. Underdog and advisor bonuses are not counted.', { 1, 0.9, 0.5 })
end
function uiCosts(player)
  -- cost to place one loyalty token: 1 + steps from your stand or nearest outpost (3+ of your tokens), +2 into rugged ground you don't control
  local col = player.color; local pi; for i, c in ipairs(SEATCOL) do if c == col then pi = i - 1 end end
  if not pi then broadcastToColor('Sit in a company colour first.', col, { 1, 0.6, 0.6 }); return end
  local cells = readMap(); local G = S.deal; local origins = {}
  for _, c in each(G.map.cells) do local t = cells[c.name]; if c.home == pi or (t and (t.tok[col] or 0) >= E.OUTPOST) then origins[#origins + 1] = c end end
  local d = {}; local q = {}; for _, c in ipairs(origins) do d[c.id] = 0; q[#q + 1] = c end
  local byPos = {}; for _, c in each(G.map.cells) do byPos[c.r .. ',' .. c.c] = c end
  local h = 1; while h <= #q do local x = q[h]; h = h + 1
    local nb = { byPos[(x.r - 1) .. ',' .. x.c], byPos[(x.r + 1) .. ',' .. x.c], byPos[x.r .. ',' .. (x.c - 1)], byPos[x.r .. ',' .. (x.c + 1)] }
    if x.link then for _, y in each(G.map.cells) do if y.link == x.link and y ~= x then nb[#nb + 1] = y end end end
    for _, y in pairs(nb) do if y and d[y.id] == nil then d[y.id] = d[x.id] + 1; q[#q + 1] = y end end end
  for key, o in pairs(objs) do if key:sub(1, 5) == 'tile:' and o.clearButtons then o.clearButtons()
    local id = key:sub(6); local c; for _, x in each(G.map.cells) do if x.id == id then c = x end end
    if c and d[id] then local t = cells[c.name]; local own = t and controlOf(t)
      local cost = math.max(1, 1 + d[id] + ((c.rough and own ~= col) and 2 or 0))
      o.createButton({ click_function = 'noop', function_owner = Global, label = tostring(cost), position = { 0, 0.3, 0 }, width = 380, height = 380, font_size = 260,
        color = { 0.17, 0.1, 0.08, 0.8 }, font_color = colorOf(col), scale = { 1 / (S.tileScale or 1.4), 1, 1 / (S.tileScale or 1.4) } }) end end end
  broadcastToColor('Loyalty cost of one token in each market for ' .. col .. '. Advisors that change costs are not counted. Click Show token costs again after the map changes.', col, { 1, 0.9, 0.5 })
  Wait.time(function() for key, o in pairs(objs) do if key:sub(1, 5) == 'tile:' and o.clearButtons then o.clearButtons() end end end, 30)
end
function noop() end
function uiSnap(player) snapshot('asked by ' .. player.color); broadcastToAll('Noted.', { 0.8, 0.8, 0.8 }) end

-- the move log, for the arithmetic and log-only modes
local held = {}
function onObjectPickUp(color, obj)
  if not S or S.mode == 'full' or S.mode == 'setup' then return end
  held[obj.getGUID()] = where(obj.getPosition())
end
function onObjectDrop(color, obj)
  if not S or S.mode == 'full' or S.mode == 'setup' then return end
  local note = obj.getGMNotes and obj.getGMNotes() or ''
  local what = note:gsub('^se|', ''); if what == '' then what = obj.getName() ~= '' and obj.getName() or obj.type end
  local to = where(obj.getPosition())
  recPush({ what = 'move', who = color, obj = what, from = held[obj.getGUID()], to = to, faceDown = obj.is_face_down or nil })
  held[obj.getGUID()] = nil
  if what == 'round' then snapshot('round marker moved') end
end
function onObjectLeaveContainer(container, obj)
  if not S or S.mode == 'full' or S.mode == 'setup' then return end
  local note = obj.getGMNotes and obj.getGMNotes() or ''
  recPush({ what = 'draw', from = (container.getGMNotes() or ''):gsub('^se|', ''), obj = note:gsub('^se|', '') })
end
function onObjectEnterContainer(container, obj)
  if not S or S.mode == 'full' or S.mode == 'setup' then return end
  recPush({ what = 'into', to = (container.getGMNotes() or ''):gsub('^se|', ''), obj = (obj.getGMNotes() or ''):gsub('^se|', '') })
end
function onPlayerChangeColor(color) if S and S.mode ~= 'full' and S.mode ~= 'setup' then recPush({ what = 'seat', who = color }) end end

--[[ ---------- buttons: setup, record, new game ---------- ]]
function uiSeat(player, value, id) S.setup.seats[tonumber(id:sub(5))] = value end
function uiSetup(player, value, id)
  local k, v = id:match('^(%a+)_(.+)$')
  if k == 'np' then S.setup.np = tonumber(v) elseif k == 'speed' then S.setup.speed = tonumber(v) else S.setup[k] = v end
  lastXml = nil; refreshUI()
end
function uiStart(player)
  local okk, err = xpcall(function()
    S.np = S.setup.np; S.mode = S.setup.mode; S.speed = S.setup.speed; S.anyone = S.setup.anyone == 'yes'
    S.seats = seatsFromSetup(); S.log = {}; S.wroteEnd = false
    -- whoever sets up sits in the first human seat, so their hand is theirs
    if player and player.color and not RGB[player.color] then for i, st in ipairs(S.seats) do if st.human then pcall(function() player.changeColor(SEATCOL[i]) end); break end end end
    clearAll(); btnLast = {}
    for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''; if note:sub(1, 3) == 'se|' then o.destruct() end end
    local G = newEngineGame()
    S.mode = 'loading'; lastXml = nil; refreshUI()
    placeBoards(S.np)
    calibrate(function() boardsUp(S.np, function()
      local ok2, err2 = xpcall(function()
        S.mode = S.setup.mode
        if S.mode == 'full' then S.G = G; S.lastRound = G.round; sync()
        else S.G = nil; S.deal = G; dealPhysical(G); recPush({ what = 'setup', seats = S.seats, mode = S.mode }); snapshot('start') end
        lastXml = nil; refreshUI()
      end, trace)
      if not ok2 then broadcastToAll('Setup error: ' .. tostring(err2), { 1, 0.4, 0.4 }); print(err2) end
    end) end)
  end, trace)
  if not okk then broadcastToAll('Setup error: ' .. tostring(err), { 1, 0.4, 0.4 }); print(err) end
end
function uiRecord(player) local okk, err = pcall(writeNotebook); if not okk then broadcastToAll('Record error: ' .. tostring(err), { 1, 0.4, 0.4 }) end end
function uiNew(player)
  if S.mode == 'full' and S.G and S.G.winner == nil then pcall(writeNotebook) end
  clearAll(); for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''; if note:sub(1, 3) == 'se|' then o.destruct() end end
  S.mode = 'setup'; S.G = nil; S.deal = nil; lastXml = nil; refreshUI()
end

--[[ ---------- save and load ---------- ]]
function onSave()
  if not S then return '' end
  local keep = { v = VERSION, mode = S.mode, np = S.np, seats = S.seats, setup = S.setup, speed = S.speed, anyone = S.anyone, log = S.log, lastRound = S.lastRound, wroteEnd = S.wroteEnd, cellName = S.cellName, cardW = S.cardW, cardH = S.cardH, tileScale = S.tileScale }
  local okk, out = pcall(function() return JSON.encode(keep) .. '\n' .. (S.G and serialize(S.G) or '') .. '\n' .. (S.deal and serialize(S.deal) or '') end)
  return okk and out or ''
end
function onLoad(saved)
  pcall(function() math.randomseed(os.time()) end)
  JS_process = { env = __mkO({ REC = '1' }, { 'REC' }) }
  E = loadEngine()
  indexCards()
  S = { mode = 'setup', setup = { np = 3, seats = { 'Human', 'Bot: champion', 'Bot: champion' }, mode = 'full', speed = 1.2, anyone = 'yes' } }
  if saved and saved ~= '' then
    local okk = pcall(function()
      local a, b, c = saved:match('^(.-)\n(.-)\n(.*)$')
      local keep = JSON.decode(a); for k, v in pairs(keep) do S[k] = v end
      if b and b ~= '' then S.G = deserialize(b) end
      if c and c ~= '' then S.deal = deserialize(c) end
    end)
    if not okk then broadcastToAll('Could not restore the saved game; starting over.', { 1, 0.6, 0.6 }) end
  end
  -- find the pieces we spawned before the save
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''; local key = note:match('^se|(.+)$')
    if key then if key:sub(1, 6) == 'board:' then objs[key] = o elseif S.mode == 'full' then objs[key] = o end end end
  if S.mode == 'loading' then S.mode = 'setup' end
  if S.mode ~= 'setup' then placeBoards(S.np or 3)
    if S.cardW then CARD_W, CARD_H = S.cardW, S.cardH; CS = math.min(0.95 * BOARD.common.L.slots.mkt0[3] / CARD_W, 0.95 * BOARD.common.L.slots.mkt0[4] / CARD_H) end end
  refreshUI()
  if S.mode == 'full' and S.G then Wait.time(sync, 1) end
end
