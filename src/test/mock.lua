-- A stand-in for the parts of Tabletop Simulator's Lua API the table script uses, for testing outside the game.
MOCK = { objs = {}, n = 0, waits = {}, xml = nil, tabs = {}, msgs = {}, errors = {} }
local function vec(x, y, z) return { x = x or 0, y = y or 0, z = z or 0 } end
local function mkobj(data)
  MOCK.n = MOCK.n + 1
  local t = data.Transform or {}
  local o = { data = data, guid = string.format('g%05d', MOCK.n), dead = false, buttons = {}, pos = vec(t.posX, t.posY, t.posZ), rot = vec(t.rotX, t.rotY, t.rotZ),
    scale = vec(t.scaleX or 1, t.scaleY or 1, t.scaleZ or 1), notes = data.GMNotes or '', locked = data.Locked, type = data.Name, interactable = true }
  local function live() if o.dead then error('object is destroyed') end end
  o.getGUID = function() live(); return o.guid end
  o.getGMNotes = function() live(); return o.notes end
  o.setGMNotes = function(s) o.notes = s end
  o.getName = function() return data.Nickname or '' end
  o.getPosition = function() live(); return vec(o.pos.x, o.pos.y, o.pos.z) end
  local function setp(p) live(); if p.x then o.pos = vec(p.x, p.y, p.z) else o.pos = vec(p[1], p[2], p[3]) end end
  o.setPosition = setp; o.setPositionSmooth = function(p) setp(p) end
  o.setRotation = function(r) live() end; o.setRotationSmooth = function(r) live() end
  o.setScale = function(s) live(); o.scale = vec(s[1], s[2], s[3]) end
  o.setLock = function(b) o.locked = b end
  o.getScale = function() return vec(o.scale.x, o.scale.y, o.scale.z) end
  o.deal = function(n, col) live(); o.dealt = col end
  o.destruct = function() live(); o.dead = true end
  o.getBoundsNormalized = function() local ar = 1
      if data.CustomImage then local f = data.CustomImage.ImageURL:match('([^/]+)%.png$'); local L = LAYOUT.files[f]; if L then ar = L.h / L.w end end
      if data.CardID then return { size = vec(2.2 * o.scale.x, 0.1, 3.1 * o.scale.z), center = o.getPosition() } end
      return { size = vec(2 * o.scale.x, 0.2, 2 * ar * o.scale.z), center = o.getPosition() } end
  o.createButton = function(b) live(); assert(b.click_function and b.function_owner, 'button without a handler'); assert(type(_G[b.click_function]) == 'function', 'no global ' .. b.click_function); o.buttons[#o.buttons + 1] = b end
  o.clearButtons = function() live(); o.buttons = {} end
  if data.Name == '3DText' then o.text = data.Text.Text; o.TextTool = { setValue = function(s) live(); o.text = s end } end
  if data.Name == 'Counter' then o.cval = (data.Counter and data.Counter.value) or 0; o.Counter = { setValue = function(v) o.cval = v end, getValue = function() return o.cval end } end
  -- the card's image must exist
  if data.CardID then local d = math.floor(data.CardID / 100); assert(data.CustomDeck[d], 'card ' .. data.CardID .. ' without its deck') end
  return o
end
function spawnObjectData(args) local o = mkobj(args.data); MOCK.objs[#MOCK.objs + 1] = o; if args.callback_function then args.callback_function(o) end return o end
function getObjects() local out = {}; for _, o in ipairs(MOCK.objs) do if not o.dead then out[#out + 1] = o end end return out end
function getObjectFromGUID(g) for _, o in ipairs(MOCK.objs) do if o.guid == g and not o.dead then return o end end end
local HANDS = { Red = vec(0, 4.5, -27), Blue = vec(-36, 4.5, 0), Green = vec(36, 4.5, 0) }
Player = setmetatable({}, { __index = function(t, col) return { color = col, getHandTransform = function() return { position = HANDS[col], rotation = vec() } end,
  getHandObjects = function() return {} end, seated = true } end })
UI = { setXml = function(x) MOCK.xml = x; MOCK.xmlCount = (MOCK.xmlCount or 0) + 1 end, setAttribute = function() end }
Wait = { time = function(f, t) MOCK.waits[#MOCK.waits + 1] = f end, frames = function(f, n) MOCK.waits[#MOCK.waits + 1] = f end,
  condition = function(f, c, t, tf) MOCK.waits[#MOCK.waits + 1] = function() if c() then f() elseif tf then tf() end end end }
Notes = { getNotebookTabs = function() local out = {}; for i, t in ipairs(MOCK.tabs) do out[#out + 1] = { index = i - 1, title = t.title, body = t.body } end return out end,
  addNotebookTab = function(t) MOCK.tabs[#MOCK.tabs + 1] = { title = t.title, body = t.body }; return #MOCK.tabs - 1 end,
  editNotebookTab = function(t) MOCK.tabs[t.index + 1] = { title = t.title, body = t.body } end,
  removeNotebookTab = function(i) table.remove(MOCK.tabs, i + 1); return true end }
function broadcastToAll(m) MOCK.msgs[#MOCK.msgs + 1] = m; if m:find('rror') then MOCK.errors[#MOCK.errors + 1] = m end end
function broadcastToColor(m, c) MOCK.msgs[#MOCK.msgs + 1] = c .. ': ' .. m end
Global = { __global = true }
-- JSON for plain Lua tables (what the table script hands to TTS's JSON)
JSON = {}
local function enc(v, out)
  local ty = type(v)
  if v == nil then out[#out + 1] = 'null' elseif ty == 'boolean' then out[#out + 1] = tostring(v) elseif ty == 'number' then out[#out + 1] = string.format('%.14g', v)
  elseif ty == 'string' then out[#out + 1] = '"' .. v:gsub('[%c"\\]', function(c) return string.format('\\u%04x', c:byte()) end) .. '"'
  elseif ty == 'table' then
    if #v > 0 or next(v) == nil then out[#out + 1] = '['; for i, x in ipairs(v) do if i > 1 then out[#out + 1] = ',' end enc(x, out) end out[#out + 1] = ']'
    else out[#out + 1] = '{'; local first = true; for k, x in pairs(v) do if type(x) ~= 'function' then if not first then out[#out + 1] = ',' end first = false; out[#out + 1] = '"' .. tostring(k) .. '":'; enc(x, out) end end out[#out + 1] = '}' end
  else out[#out + 1] = 'null' end
end
JSON.encode = function(v) local out = {}; enc(v, out); return table.concat(out) end
JSON.decode = function(s) return MOCK_DECODE(s) end
