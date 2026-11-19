-- Sour Empire for Tabletop Simulator. Built by build.js; edit the sources, not this file.

IMG = "https://raw.githubusercontent.com/aespitzer/lemonade-stand-tts/main/img/v1/"

MANIFEST = {{["name"] = "ingredients", ["file"] = "ingredients.png", ["cols"] = 5, ["rows"] = 4, ["keys"] = {"ing:sweet:Strawberry", "ing:sweet:Cane sugar", "ing:sweet:Honey", "ing:sweet:Peach", "ing:sweet:Watermelon", "ing:sour:Lemon", "ing:sour:Lime", "ing:sour:Grapefruit", "ing:sour:Yuzu", "ing:sour:Tamarind", "ing:herb:Lavender", "ing:herb:Mint", "ing:herb:Basil", "ing:herb:Hibiscus", "ing:herb:Rosemary", "ing:fizz:Soda water", "ing:fizz:Ginger", "ing:fizz:Tonic", "ing:fizz:Seltzer", "ing:fizz:Kombucha"}, ["back"] = "ingredients-back.png", ["kind"] = "card"}, {["name"] = "machines", ["file"] = "machines.png", ["cols"] = 7, ["rows"] = 4, ["keys"] = {"mach:hands", "mach:blender", "mach:juicer", "mach:sugarpot", "mach:herbjar", "mach:siphon", "mach:squeezer", "mach:icechest", "mach:garage", "mach:muddler", "mach:fizzrig", "mach:coldpress", "mach:wagon", "mach:binder", "mach:concentrate", "mach:bottling", "mach:still", "mach:carbonator", "mach:plant2", "mach:franchise", "mach:works", "mach:lightsout", "mach:ftz", "mach:synthetic", "mach:global", "mach:contract", "mach:skunk"}, ["back"] = "machines-back.png", ["kind"] = "card"}, {["name"] = "research", ["file"] = "research.png", ["cols"] = 10, ["rows"] = 6, ["keys"] = {"res:r0", "res:r1", "res:r2", "res:r3", "res:r4", "res:r5", "res:r6", "res:r7", "res:r8", "res:r9", "res:r10", "res:r11", "res:r12", "res:r13", "res:r14", "res:r15", "res:r16", "res:r17", "res:r18", "res:r19", "res:r20", "res:r21", "res:r22", "res:r23", "res:r24", "res:r25", "res:r26", "res:r27", "res:r28", "res:r29", "res:rwin", "adv:cfo", "adv:tina", "adv:swamp", "adv:saul", "adv:elle", "adv:cop", "adv:chad", "adv:boogey", "adv:liz", "adv:raman", "adv:kevin", "adv:grad", "adv:hal", "adv:paul", "adv:tanner", "adv:becky", "adv:realtor", "adv:dwarf", "adv:qa", "adv:raider", "adv:lawyer2", "adv:pioneer", "adv:franchise", "adv:rhonda"}, ["back"] = "research-back.png", ["uniqueBack"] = true, ["kind"] = "card"}, {["name"] = "influence", ["file"] = "influence.png", ["cols"] = 8, ["rows"] = 5, ["keys"] = {"inf:recall:0", "inf:recall:1", "inf:recall:2", "inf:ha:0", "inf:ha:1", "inf:ha:2", "inf:judge:0", "inf:judge:1", "inf:subsidy:0", "inf:subsidy:1", "inf:contract:0", "inf:contract:1", "inf:spy:0", "inf:spy:1", "inf:reverse:0", "inf:reverse:1", "inf:patent:0", "inf:patent:1", "inf:patent:2", "inf:viral:0", "inf:viral:1", "inf:proxy:0", "inf:proxy:1", "inf:buyback:0", "inf:buyback:1", "inf:act:1", "inf:act:2", "inf:regime:1", "inf:regime:2", "inf:formula:0", "inf:formula:1", "inf:formula:2", "inf:antitrust:1", "inf:antitrust:2", "inf:leak:0", "inf:leak:1", "inf:leak:2"}, ["back"] = "influence-back.png", ["kind"] = "card"}, {["name"] = "memos", ["file"] = "memos.png", ["cols"] = 7, ["rows"] = 4, ["keys"] = {"memo:0", "memo:1", "memo:2", "memo:3", "memo:4", "memo:5", "memo:6", "memo:7", "memo:8", "memo:9", "memo:10", "memo:11", "memo:12", "memo:13", "memo:14", "memo:15", "memo:16", "memo:17", "memo:18", "memo:19", "memo:20", "memo:21", "memo:22", "memo:23", "memo:24", "memo:25"}, ["back"] = "memos-back.png", ["kind"] = "card"}, {["name"] = "tiles-a", ["file"] = "tiles-a.png", ["cols"] = 10, ["rows"] = 5, ["keys"] = {"tile:Kansas", "tile:Nebraska", "tile:Missouri", "tile:Oklahoma", "tile:Iowa", "tile:Colorado", "tile:Texas", "tile:South Dakota", "tile:Arkansas", "tile:Illinois", "tile:Minnesota", "tile:New Mexico", "tile:Wyoming", "tile:Tennessee", "tile:Wisconsin", "tile:Kentucky", "tile:Louisiana", "tile:Montana", "tile:Indiana", "tile:Utah", "tile:Ohio", "tile:Georgia", "tile:Arizona", "tile:Michigan", "tile:Idaho", "tile:Alabama", "tile:Nevada", "tile:Mississippi", "tile:California", "tile:New York", "tile:Florida", "tile:Washington", "tile:Oregon", "tile:Ontario", "tile:Mexico", "tile:Virginia", "tile:Maine", "tile:Quebec", "tile:British Columbia", "tile:Puerto Rico", "tile:Massachusetts", "tile:Cuba", "tile:Alaska", "tile:Hawaii", "tile:Greenland", "tile:Yukon", "tile:Nunavut", "tile:Newfoundland", "tile:Brazil", "tile:India"}, ["back"] = "tiles-a-back.png", ["kind"] = "tile"}, {["name"] = "tiles-b", ["file"] = "tiles-b.png", ["cols"] = 10, ["rows"] = 4, ["keys"] = {"tile:Nigeria", "tile:Germany", "tile:Egypt", "tile:Korea", "tile:Australia", "tile:Italy", "tile:Spain", "tile:Kenya", "tile:Vietnam", "tile:Peru", "tile:Turkey", "tile:Chile", "tile:Poland", "tile:Indonesia", "tile:Argentina", "tile:Morocco", "tile:Thailand", "tile:Norway", "tile:Greece", "tile:Japan", "tile:Ireland", "tile:Iceland", "tile:Ghana", "tile:Tokyo", "tile:London", "tile:Shanghai", "tile:Paris", "tile:Dubai", "tile:the Himalayas", "tile:the Andes", "tile:the Alps", "tile:the Sahara", "tile:Siberia"}, ["back"] = "tiles-b-back.png", ["kind"] = "tile"}, {["name"] = "tokens", ["file"] = "tokens.png", ["cols"] = 4, ["rows"] = 3, ["keys"] = {"bonus:0", "bonus:1", "bonus:2", "bonus:3", "bonus:4", "air:A", "air:B", "air:C", "stand:0", "stand:1", "stand:2", "stand:3"}, ["back"] = "tokens-back.png", ["kind"] = "token"}}

LAYOUT = {["common"] = {["w"] = 40, ["h"] = 13.2, ["slots"] = {["mdeck"] = {1.6, 2.45, 2.6, 3.5}, ["mkt0"] = {4.6, 2.45, 2.6, 3.5}, ["mkt1"] = {7.3999999999999995, 2.45, 2.6, 3.5}, ["mkt2"] = {10.2, 2.45, 2.6, 3.5}, ["mkt3"] = {12.999999999999998, 2.45, 2.6, 3.5}, ["ideck"] = {17.4, 2.45, 2.6, 3.5}, ["pile_sweet"] = {20.4, 2.45, 2.6, 3.5}, ["pile_sour"] = {23.2, 2.45, 2.6, 3.5}, ["pile_herb"] = {26, 2.45, 2.6, 3.5}, ["pile_fizz"] = {28.799999999999997, 2.45, 2.6, 3.5}, ["choice0"] = {32.4, 2.45, 2.6, 3.5}, ["choice1"] = {35.199999999999996, 2.45, 2.6, 3.5}, ["choice2"] = {38, 2.45, 2.6, 3.5}, ["rdeck"] = {1.6, 6.55, 2.6, 3.5}, ["rrow0"] = {4.6, 6.55, 2.6, 3.5}, ["rrow1"] = {7.3999999999999995, 6.55, 2.6, 3.5}, ["rrow2"] = {10.2, 6.55, 2.6, 3.5}, ["rrow3"] = {12.999999999999998, 6.55, 2.6, 3.5}, ["arow0"] = {17.4, 6.55, 2.6, 3.5}, ["arow1"] = {20.2, 6.55, 2.6, 3.5}, ["arow2"] = {23, 6.55, 2.6, 3.5}, ["arow3"] = {25.799999999999997, 6.55, 2.6, 3.5}, ["infdeck"] = {29.6, 6.55, 2.6, 3.5}, ["infdisc"] = {32.4, 6.55, 2.6, 3.5}, ["memodeck"] = {35.2, 6.55, 2.6, 3.5}, ["memoplay"] = {38, 6.55, 2.6, 3.5}, ["round1"] = {1.6, 9.75, 1.35, 1.2}, ["round2"] = {3.1500000000000004, 9.75, 1.35, 1.2}, ["round3"] = {4.7, 9.75, 1.35, 1.2}, ["round4"] = {6.25, 9.75, 1.35, 1.2}, ["round5"] = {7.800000000000001, 9.75, 1.35, 1.2}, ["round6"] = {9.35, 9.75, 1.35, 1.2}, ["round7"] = {10.9, 9.75, 1.35, 1.2}, ["round8"] = {12.45, 9.75, 1.35, 1.2}, ["round9"] = {14, 9.75, 1.35, 1.2}, ["round10"] = {15.55, 9.75, 1.35, 1.2}, ["round11"] = {17.1, 9.75, 1.35, 1.2}, ["round12"] = {18.650000000000002, 9.75, 1.35, 1.2}, ["round13"] = {20.200000000000003, 9.75, 1.35, 1.2}, ["round14"] = {21.750000000000004, 9.75, 1.35, 1.2}, ["round15"] = {23.3, 9.75, 1.35, 1.2}, ["heat0"] = {1.6, 12, 1.35, 1.2}, ["heat1"] = {3.1500000000000004, 12, 1.35, 1.2}, ["heat2"] = {4.7, 12, 1.35, 1.2}, ["heat3"] = {6.25, 12, 1.35, 1.2}, ["heat4"] = {7.800000000000001, 12, 1.35, 1.2}, ["heat5"] = {9.35, 12, 1.35, 1.2}, ["heat6"] = {10.9, 12, 1.35, 1.2}, ["heat7"] = {12.45, 12, 1.35, 1.2}, ["heat8"] = {14, 12, 1.35, 1.2}, ["status"] = {30.5, 11, 17, 3.6}}}, ["map2"] = {["w"] = 16.2, ["h"] = 16.2, ["slots"] = {["c0r0"] = {2.1, 2.1, 2.9, 2.9}, ["c1r0"] = {5.1, 2.1, 2.9, 2.9}, ["c2r0"] = {8.1, 2.1, 2.9, 2.9}, ["c3r0"] = {11.1, 2.1, 2.9, 2.9}, ["c4r0"] = {14.1, 2.1, 2.9, 2.9}, ["c0r1"] = {2.1, 5.1, 2.9, 2.9}, ["c1r1"] = {5.1, 5.1, 2.9, 2.9}, ["c2r1"] = {8.1, 5.1, 2.9, 2.9}, ["c3r1"] = {11.1, 5.1, 2.9, 2.9}, ["c4r1"] = {14.1, 5.1, 2.9, 2.9}, ["c0r2"] = {2.1, 8.1, 2.9, 2.9}, ["c1r2"] = {5.1, 8.1, 2.9, 2.9}, ["c2r2"] = {8.1, 8.1, 2.9, 2.9}, ["c3r2"] = {11.1, 8.1, 2.9, 2.9}, ["c4r2"] = {14.1, 8.1, 2.9, 2.9}, ["c0r3"] = {2.1, 11.1, 2.9, 2.9}, ["c1r3"] = {5.1, 11.1, 2.9, 2.9}, ["c2r3"] = {8.1, 11.1, 2.9, 2.9}, ["c3r3"] = {11.1, 11.1, 2.9, 2.9}, ["c4r3"] = {14.1, 11.1, 2.9, 2.9}, ["c0r4"] = {2.1, 14.1, 2.9, 2.9}, ["c1r4"] = {5.1, 14.1, 2.9, 2.9}, ["c2r4"] = {8.1, 14.1, 2.9, 2.9}, ["c3r4"] = {11.1, 14.1, 2.9, 2.9}, ["c4r4"] = {14.1, 14.1, 2.9, 2.9}}, ["cell"] = 3}, ["map3"] = {["w"] = 19.2, ["h"] = 19.2, ["slots"] = {["c0r0"] = {2.1, 2.1, 2.9, 2.9}, ["c1r0"] = {5.1, 2.1, 2.9, 2.9}, ["c2r0"] = {8.1, 2.1, 2.9, 2.9}, ["c3r0"] = {11.1, 2.1, 2.9, 2.9}, ["c4r0"] = {14.1, 2.1, 2.9, 2.9}, ["c5r0"] = {17.1, 2.1, 2.9, 2.9}, ["c0r1"] = {2.1, 5.1, 2.9, 2.9}, ["c1r1"] = {5.1, 5.1, 2.9, 2.9}, ["c2r1"] = {8.1, 5.1, 2.9, 2.9}, ["c3r1"] = {11.1, 5.1, 2.9, 2.9}, ["c4r1"] = {14.1, 5.1, 2.9, 2.9}, ["c5r1"] = {17.1, 5.1, 2.9, 2.9}, ["c0r2"] = {2.1, 8.1, 2.9, 2.9}, ["c1r2"] = {5.1, 8.1, 2.9, 2.9}, ["c2r2"] = {8.1, 8.1, 2.9, 2.9}, ["c3r2"] = {11.1, 8.1, 2.9, 2.9}, ["c4r2"] = {14.1, 8.1, 2.9, 2.9}, ["c5r2"] = {17.1, 8.1, 2.9, 2.9}, ["c0r3"] = {2.1, 11.1, 2.9, 2.9}, ["c1r3"] = {5.1, 11.1, 2.9, 2.9}, ["c2r3"] = {8.1, 11.1, 2.9, 2.9}, ["c3r3"] = {11.1, 11.1, 2.9, 2.9}, ["c4r3"] = {14.1, 11.1, 2.9, 2.9}, ["c5r3"] = {17.1, 11.1, 2.9, 2.9}, ["c0r4"] = {2.1, 14.1, 2.9, 2.9}, ["c1r4"] = {5.1, 14.1, 2.9, 2.9}, ["c2r4"] = {8.1, 14.1, 2.9, 2.9}, ["c3r4"] = {11.1, 14.1, 2.9, 2.9}, ["c4r4"] = {14.1, 14.1, 2.9, 2.9}, ["c5r4"] = {17.1, 14.1, 2.9, 2.9}, ["c0r5"] = {2.1, 17.1, 2.9, 2.9}, ["c1r5"] = {5.1, 17.1, 2.9, 2.9}, ["c2r5"] = {8.1, 17.1, 2.9, 2.9}, ["c3r5"] = {11.1, 17.1, 2.9, 2.9}, ["c4r5"] = {14.1, 17.1, 2.9, 2.9}, ["c5r5"] = {17.1, 17.1, 2.9, 2.9}}, ["cell"] = 3}, ["mat"] = {["w"] = 30, ["h"] = 9.6, ["slots"] = {["era1"] = {7, 1.15, 1.7, 1.45}, ["era2"] = {8.85, 1.15, 1.7, 1.45}, ["era3"] = {10.7, 1.15, 1.7, 1.45}, ["era4"] = {12.55, 1.15, 1.7, 1.45}, ["era5"] = {14.4, 1.15, 1.7, 1.45}, ["era6"] = {16.25, 1.15, 1.7, 1.45}, ["era7"] = {18.1, 1.15, 1.7, 1.45}, ["era8"] = {19.950000000000003, 1.15, 1.7, 1.45}, ["era9"] = {21.8, 1.15, 1.7, 1.45}, ["era10"] = {23.650000000000002, 1.15, 1.7, 1.45}, ["era11"] = {25.5, 1.15, 1.7, 1.45}, ["era12"] = {27.35, 1.15, 1.7, 1.45}, ["trk0"] = {6.6, 3.05, 1.3, 1.3}, ["trk1"] = {8.02, 3.05, 1.3, 1.3}, ["trk2"] = {9.44, 3.05, 1.3, 1.3}, ["trk3"] = {10.86, 3.05, 1.3, 1.3}, ["trk4"] = {12.28, 3.05, 1.3, 1.3}, ["trk5"] = {13.7, 3.05, 1.3, 1.3}, ["trk6"] = {15.12, 3.05, 1.3, 1.3}, ["trk7"] = {16.54, 3.05, 1.3, 1.3}, ["trk8"] = {17.96, 3.05, 1.3, 1.3}, ["trk9"] = {19.38, 3.05, 1.3, 1.3}, ["trk10"] = {20.799999999999997, 3.05, 1.3, 1.3}, ["trk11"] = {22.22, 3.05, 1.3, 1.3}, ["trk12"] = {23.64, 3.05, 1.3, 1.3}, ["trk13"] = {25.060000000000002, 3.05, 1.3, 1.3}, ["trk14"] = {26.479999999999997, 3.05, 1.3, 1.3}, ["trk15"] = {27.9, 3.05, 1.3, 1.3}, ["floor0"] = {7.6, 6.25, 2.6, 3.5}, ["floor1"] = {10.45, 6.25, 2.6, 3.5}, ["floor2"] = {13.3, 6.25, 2.6, 3.5}, ["shelf"] = {19.3, 6.25, 7.2, 3.5}, ["tiles"] = {26.3, 6.25, 6.4, 3.5}, ["name"] = {3, 0.9, 5.4, 1.2}, ["cash"] = {1.6, 2.9, 2.6, 1.6}, ["loy"] = {4.4, 2.9, 2.6, 1.6}, ["stars"] = {1.6, 4.85, 2.6, 1.6}, ["imp"] = {4.4, 4.85, 2.6, 1.6}, ["hand"] = {1.6, 6.8, 2.6, 1.6}, ["inf"] = {4.4, 6.8, 2.6, 1.6}, ["note"] = {3, 8.6, 5.4, 1.4}}}, ["files"] = {["board-common"] = {["file"] = "board-common.png", ["w"] = 40, ["h"] = 13.2}, ["board-map2"] = {["file"] = "board-map2.png", ["w"] = 16.2, ["h"] = 16.2}, ["board-map3"] = {["file"] = "board-map3.png", ["w"] = 19.2, ["h"] = 19.2}, ["mat-0"] = {["file"] = "mat-0.png", ["w"] = 30, ["h"] = 9.6}, ["mat-1"] = {["file"] = "mat-1.png", ["w"] = 30, ["h"] = 9.6}, ["mat-2"] = {["file"] = "mat-2.png", ["w"] = 30, ["h"] = 9.6}, ["mat-3"] = {["file"] = "mat-3.png", ["w"] = 30, ["h"] = 9.6}, ["felt"] = {["file"] = "felt.png", ["w"] = 84, ["h"] = 60}}}

do
-- JavaScript semantics for code compiled by js2lua (Lua 5.1 / 5.2 / MoonSharp).
-- Arrays are tables with elements at 0..n-1 and their length in field __n. Objects are plain tables;
-- the order their keys were written in is kept on the side, so iteration order matches JavaScript.
-- 0, "", NaN, nil and false are false. Sorting is stable. Numbers print the way JavaScript prints them.
local unpack_ = table.unpack or unpack
local floor, huge, fmod = math.floor, math.huge, math.fmod
local sfmt, ssub, sfind, slower, supper, srep, sbyte = string.format, string.sub, string.find, string.lower, string.upper, string.rep, string.byte
local tconcat, tsort = table.concat, table.sort

local UNICODE = (#'\195\169' == 2) and (#'é' == 1) -- MoonSharp keeps text as characters; C Lua as UTF-8 bytes
local function chars(x) local out = {}
  if UNICODE then for i = 1, #x do out[i] = ssub(x, i, i) end
  else for c in x:gmatch('[^\128-\191][\128-\191]*') do out[#out + 1] = c end end
  return out end
local ARR = { __js = 'array' }
local SET = { __js = 'set' }
local MAP = { __js = 'map' }
local ORD = setmetatable({}, { __mode = 'k' }) -- object -> list of string keys in the order they were written
__ARR, __SET, __MAP, __ORD = ARR, SET, MAP, ORD

local function isarr(x) return type(x) == 'table' and getmetatable(x) == ARR end
__isarr = isarr

function __mkA(t) return setmetatable(t, ARR) end
local mkA = __mkA
function __mkO(t, keys) if keys then ORD[t] = keys end return t end

-- truthiness
local function t_(x) return not (x == nil or x == false or x == 0 or x == '' or x ~= x) end
__t = t_
function __T(x) if t_(x) then return x end return false end

-- numbers to text, as JavaScript writes them
local function numstr(n)
  if n ~= n then return 'NaN' end
  if n == huge then return 'Infinity' end
  if n == -huge then return '-Infinity' end
  if n == floor(n) and n > -1e21 and n < 1e21 then
    if n == 0 then return '0' end
    return sfmt('%.0f', n)
  end
  for p = 1, 17 do local s = sfmt('%.' .. p .. 'g', n); if tonumber(s) == n then
    -- JavaScript writes exponents as e+21 / e-7, Lua as e+21 / e-07
    s = s:gsub('e([%+%-])0*(%d)', 'e%1%2'); return s end end
  return sfmt('%.17g', n)
end
__numstr = numstr

local str_
local function joinA(a, sep)
  local out = {}
  for i = 0, a.__n - 1 do local v = a[i]; out[i + 1] = (v == nil) and '' or str_(v) end
  return tconcat(out, sep)
end
str_ = function(x)
  local ty = type(x)
  if ty == 'string' then return x end
  if ty == 'number' then return numstr(x) end
  if ty == 'boolean' then return x and 'true' or 'false' end
  if x == nil then return 'undefined' end
  if ty == 'table' then if isarr(x) then return joinA(x, ',') end return '[object Object]' end
  return 'function'
end
__str = str_

local function tonum(x)
  local ty = type(x)
  if ty == 'number' then return x end
  if ty == 'boolean' then return x and 1 or 0 end
  if ty == 'string' then local s = x:match('^%s*(.-)%s*$'); if s == '' then return 0 end local n = tonumber(s); if n == nil then return 0 / 0 end return n end
  if x == nil then return 0 / 0 end
  if isarr(x) then if x.__n == 0 then return 0 end if x.__n == 1 then return tonum(x[0]) end end
  return 0 / 0
end
__num = tonum

function __add(a, b)
  local ta, tb = type(a), type(b)
  if ta == 'number' and tb == 'number' then return a + b end
  if ta == 'string' or tb == 'string' or ta == 'table' or tb == 'table' then return str_(a) .. str_(b) end
  return tonum(a) + tonum(b)
end
local function cmpv(a, b)
  local ta, tb = type(a), type(b)
  if ta == 'string' and tb == 'string' then return a, b end
  return tonum(a), tonum(b)
end
function __lt(a, b) if type(a) == 'number' and type(b) == 'number' then return a < b end a, b = cmpv(a, b); return a < b end
function __le(a, b) if type(a) == 'number' and type(b) == 'number' then return a <= b end a, b = cmpv(a, b); return a <= b end
function __gt(a, b) if type(a) == 'number' and type(b) == 'number' then return a > b end a, b = cmpv(a, b); return a > b end
function __ge(a, b) if type(a) == 'number' and type(b) == 'number' then return a >= b end a, b = cmpv(a, b); return a >= b end
function __mod(a, b) return fmod(tonum(a), tonum(b)) end

function __typeof(x)
  local ty = type(x)
  if x == nil then return 'undefined' end
  if ty == 'table' then return 'object' end
  return ty
end

function __len(x)
  if type(x) == 'string' then
    -- JavaScript counts UTF-16 units; count characters, which agrees for everything this game prints
    if UNICODE then return #x end
    local n = 0; for _ in x:gmatch('[^\128-\191]') do n = n + 1 end; return n
  end
  if isarr(x) then return x.__n end
  if type(x) == 'table' and getmetatable(x) and getmetatable(x).__size then return getmetatable(x).__size(x) end
  return x.length
end
function __setlen(a, n) if isarr(a) then for i = n, a.__n - 1 do a[i] = nil end a.__n = n else a.length = n end return n end

function __set(o, k, v)
  if isarr(o) and type(k) == 'number' then if k >= o.__n then o.__n = floor(k) + 1 end o[k] = v; return v end
  if type(k) == 'string' and ORD[o] and o[k] == nil then local ks = ORD[o]; ks[#ks + 1] = k end
  o[k] = v; return v
end
function __get(o, k)
  if type(o) == 'string' then if type(k) == 'number' then return ssub(o, k + 1, k + 1) end return nil end
  return o[k]
end

-- keys in JavaScript order: integer keys ascending, then string keys in the order written
local function keys(o)
  local nums, strs, seen = {}, {}, {}
  local ord = ORD[o]
  if ord then for _, k in ipairs(ord) do if o[k] ~= nil and not seen[k] then seen[k] = true; strs[#strs + 1] = k end end end
  local extra = {}
  for k, v in pairs(o) do
    if type(k) == 'number' then nums[#nums + 1] = k
    elseif type(k) == 'string' and k ~= '__n' and not seen[k] then extra[#extra + 1] = k end
  end
  tsort(nums); tsort(extra)
  local out = {}
  for _, k in ipairs(nums) do out[#out + 1] = k end
  for _, k in ipairs(strs) do out[#out + 1] = k end
  for _, k in ipairs(extra) do out[#out + 1] = k end
  return out
end
__keys = keys
function __forin(o) -- an iterator over keys, for `for (k in o)`
  if o == nil then return function() return nil end end
  local ks
  if isarr(o) then ks = {}; for i = 0, o.__n - 1 do ks[#ks + 1] = i end else ks = keys(o) end
  local i = 0
  return function() i = i + 1; return ks[i] end
end
function __forof(x) -- arrays are walked live, like JavaScript; sets and maps by their entries
  if isarr(x) then local i = -1; return function() i = i + 1; if i < x.__n then return true, x[i] end return nil end end
  if type(x) == 'string' then local i = 0; local cs = chars(x); return function() i = i + 1; if cs[i] then return true, cs[i] end return nil end end
  local mt = getmetatable(x)
  if mt == SET then local i = 0; return function() i = i + 1; if i <= #x.__items then return true, x.__items[i] end return nil end end
  if mt == MAP then local i = 0; return function() i = i + 1; local k = x.__keys[i]; if i <= #x.__keys then return true, mkA({ [0] = k, x.__vals[k], __n = 2 }) end return nil end end
  error('not iterable: ' .. str_(x))
end
local function toArr(x)
  if isarr(x) then return x end
  local out, n = {}, 0
  for ok, v in __forof(x) do out[n] = v; n = n + 1 end
  out.__n = n; return mkA(out)
end
__toArr = toArr

-- building arrays and objects with spreads
function __spreadA(parts) -- parts: list of {v=value} or {s=iterable}
  local out, n = {}, 0
  for _, p in ipairs(parts) do
    if p.s ~= nil then local a = toArr(p.s); for i = 0, a.__n - 1 do out[n] = a[i]; n = n + 1 end
    else out[n] = p.v; n = n + 1 end
  end
  out.__n = n; return mkA(out)
end
function __spreadO(parts) -- parts: list of {k=key, v=value} or {s=object}
  local out, ks = {}, {}
  local function put(k, v) if type(k) == 'string' and out[k] == nil then ks[#ks + 1] = k end out[k] = v end
  for _, p in ipairs(parts) do
    if p.s ~= nil then local src = p.s
      if isarr(src) then for i = 0, src.__n - 1 do put(i, src[i]) end
      elseif type(src) == 'table' then for _, k in ipairs(keys(src)) do put(k, src[k]) end end
    else put(p.k, p.v) end
  end
  ORD[out] = ks; return out
end
function __objrest(o, omit) local parts = {}; local skip = {}; for _, k in ipairs(omit) do skip[k] = true end
  local out, ks = {}, {}
  for _, k in ipairs(keys(o)) do if not skip[k] then out[k] = o[k]; if type(k) == 'string' then ks[#ks + 1] = k end end end
  ORD[out] = ks; return out end
function __pack(...) local n = select('#', ...); local t = { ... }; local out = { __n = n }; for i = 1, n do out[i - 1] = t[i] end return mkA(out) end
function __unpack(a) a = toArr(a); if a.__n == 0 then return end return unpack_(a, 0, a.__n - 1) end

-- array methods (callbacks get value, index, array)
local A = {}
function A.push(a, ...) local n = select('#', ...); local t = { ... }; for i = 1, n do a[a.__n] = t[i]; a.__n = a.__n + 1 end return a.__n end
function A.pop(a) if a.__n == 0 then return nil end a.__n = a.__n - 1; local v = a[a.__n]; a[a.__n] = nil; return v end
function A.shift(a) if a.__n == 0 then return nil end local v = a[0]; for i = 1, a.__n - 1 do a[i - 1] = a[i] end a[a.__n - 1] = nil; a.__n = a.__n - 1; return v end
function A.unshift(a, ...) local n = select('#', ...); local t = { ... }; for i = a.__n - 1, 0, -1 do a[i + n] = a[i] end for i = 1, n do a[i - 1] = t[i] end a.__n = a.__n + n; return a.__n end
function A.map(a, f) local out = { __n = a.__n }; for i = 0, a.__n - 1 do out[i] = f(a[i], i, a) end return mkA(out) end
function A.filter(a, f) local out, n = {}, 0; for i = 0, a.__n - 1 do local v = a[i]; if t_(f(v, i, a)) then out[n] = v; n = n + 1 end end out.__n = n; return mkA(out) end
function A.forEach(a, f) for i = 0, a.__n - 1 do f(a[i], i, a) end end
function A.some(a, f) for i = 0, a.__n - 1 do if t_(f(a[i], i, a)) then return true end end return false end
function A.every(a, f) for i = 0, a.__n - 1 do if not t_(f(a[i], i, a)) then return false end end return true end
function A.find(a, f) for i = 0, a.__n - 1 do if t_(f(a[i], i, a)) then return a[i] end end return nil end
function A.findIndex(a, f) for i = 0, a.__n - 1 do if t_(f(a[i], i, a)) then return i end end return -1 end
function A.reduce(a, f, ...)
  local acc, i0
  if select('#', ...) > 0 then acc = ...; i0 = 0 else if a.__n == 0 then error('Reduce of empty array with no initial value') end acc = a[0]; i0 = 1 end
  for i = i0, a.__n - 1 do acc = f(acc, a[i], i, a) end
  return acc
end
local function relidx(i, n, d) if i == nil then return d end i = tonum(i); if i ~= i then i = 0 end i = (i < 0) and math.max(n + floor(i), 0) or math.min(floor(i), n); return i end
function A.slice(a, s, e) local n = a.__n; s = relidx(s, n, 0); e = relidx(e, n, n); local out, k = {}, 0; for i = s, e - 1 do out[k] = a[i]; k = k + 1 end out.__n = k; return mkA(out) end
function A.splice(a, s, dc, ...)
  local n = a.__n; s = relidx(s, n, 0)
  if dc == nil then dc = n - s else dc = math.max(0, math.min(floor(tonum(dc)), n - s)) end
  local ins = { ... }; local ni = select('#', ...)
  local removed = { __n = dc }; for i = 0, dc - 1 do removed[i] = a[s + i] end
  local tail = {}; for i = s + dc, n - 1 do tail[#tail + 1] = a[i] end
  for i = s, n - 1 do a[i] = nil end
  local k = s; for i = 1, ni do a[k] = ins[i]; k = k + 1 end
  for i = 1, #tail do a[k] = tail[i]; k = k + 1 end
  -- #tail misses trailing nils; count positions instead
  local tn = n - s - dc; k = s + ni + tn
  a.__n = k
  return mkA(removed)
end
-- splice above uses #tail, which is wrong with holes: redo with an explicit count
function A.splice(a, s, dc, ...)
  local n = a.__n; s = relidx(s, n, 0)
  if dc == nil then dc = n - s else dc = math.max(0, math.min(floor(tonum(dc)), n - s)) end
  local ni = select('#', ...); local ins = { ... }
  local removed = { __n = dc }; for i = 0, dc - 1 do removed[i] = a[s + i] end
  local tn = n - s - dc; local tail = {}; for i = 0, tn - 1 do tail[i] = a[s + dc + i] end
  for i = s, n - 1 do a[i] = nil end
  for i = 1, ni do a[s + i - 1] = ins[i] end
  for i = 0, tn - 1 do a[s + ni + i] = tail[i] end
  a.__n = s + ni + tn
  return mkA(removed)
end
local function sameZero(x, y) return x == y or (x ~= x and y ~= y) end
function A.includes(a, v) for i = 0, a.__n - 1 do if sameZero(a[i], v) then return true end end return false end
function A.indexOf(a, v, from) from = relidx(from, a.__n, 0); for i = from, a.__n - 1 do if a[i] == v then return i end end return -1 end
function A.join(a, sep) if sep == nil then sep = ',' end return joinA(a, sep) end
function A.reverse(a) local n = a.__n; for i = 0, floor(n / 2) - 1 do a[i], a[n - 1 - i] = a[n - 1 - i], a[i] end return a end
function A.fill(a, v, s, e) local n = a.__n; s = relidx(s, n, 0); e = relidx(e, n, n); for i = s, e - 1 do a[i] = v end return a end
function A.concat(a, ...) local parts = { { s = a } }; local t = { ... }; for i = 1, select('#', ...) do local x = t[i]; if isarr(x) then parts[#parts + 1] = { s = x } else parts[#parts + 1] = { v = x } end end return __spreadA(parts) end
function A.flat(a, depth) depth = depth or 1; local out, n = {}, 0
  local function put(x, d) if isarr(x) and d > 0 then for i = 0, x.__n - 1 do put(x[i], d - 1) end else out[n] = x; n = n + 1 end end
  for i = 0, a.__n - 1 do put(a[i], depth) end out.__n = n; return mkA(out) end
function A.flatMap(a, f) return A.flat(A.map(a, f), 1) end
-- stable merge sort; without a comparator, JavaScript compares the values as text, with undefined last
function A.sort(a, cmp)
  local n = a.__n; local t = {}; local undef = 0
  for i = 0, n - 1 do if a[i] == nil then undef = undef + 1 else t[#t + 1] = a[i] end end
  local before
  if cmp then before = function(x, y) local r = tonum(cmp(x, y)); return r < 0 end
  else before = function(x, y) return str_(x) < str_(y) end end
  local function msort(lo, hi, tmp)
    if hi - lo < 1 then return end
    local mid = floor((lo + hi) / 2)
    msort(lo, mid, tmp); msort(mid + 1, hi, tmp)
    local i, j, k = lo, mid + 1, lo
    while i <= mid and j <= hi do
      if before(t[j], t[i]) then tmp[k] = t[j]; j = j + 1 else tmp[k] = t[i]; i = i + 1 end
      k = k + 1
    end
    while i <= mid do tmp[k] = t[i]; i = i + 1; k = k + 1 end
    while j <= hi do tmp[k] = t[j]; j = j + 1; k = k + 1 end
    for x = lo, hi do t[x] = tmp[x] end
  end
  msort(1, #t, {})
  for i = 1, #t do a[i - 1] = t[i] end
  for i = #t, n - 1 do a[i] = nil end
  return a
end
function A.keys(a) local out = { __n = a.__n }; for i = 0, a.__n - 1 do out[i] = i end return mkA(out) end
function A.entries(a) local out = { __n = a.__n }; for i = 0, a.__n - 1 do out[i] = mkA({ [0] = i, a[i], __n = 2 }) end return mkA(out) end

-- string methods
local S = {}
local function plainfind(s, p, init) return sfind(s, p, init, true) end
function S.toLowerCase(s) return slower(s) end
function S.toUpperCase(s) return supper(s) end
function S.startsWith(s, p) return ssub(s, 1, #p) == p end
function S.endsWith(s, p) return p == '' or ssub(s, -#p) == p end
function S.includes(s, p) return plainfind(s, p, 1) ~= nil end
function S.indexOf(s, p) local i = plainfind(s, p, 1); return i and i - 1 or -1 end
function S.trim(s) return (s:gsub('^%s+', ''):gsub('%s+$', '')) end
function S.split(s, sep)
  local out, n = {}, 0
  if sep == nil then return mkA({ [0] = s, __n = 1 }) end
  if sep == '' then for _, c in ipairs(chars(s)) do out[n] = c; n = n + 1 end out.__n = n; return mkA(out) end
  local i = 1
  while true do local a, b = plainfind(s, sep, i); if not a then out[n] = ssub(s, i); n = n + 1; break end out[n] = ssub(s, i, a - 1); n = n + 1; i = b + 1 end
  out.__n = n; return mkA(out)
end
function S.slice(s, a, b) local n = #s; a = relidx(a, n, 0); b = relidx(b, n, n); return ssub(s, a + 1, b) end
function S.substring(s, a, b) local n = #s; a = math.max(0, math.min(floor(tonum(a or 0)), n)); b = b == nil and n or math.max(0, math.min(floor(tonum(b)), n)); if a > b then a, b = b, a end return ssub(s, a + 1, b) end
function S.charAt(s, i) return ssub(s, i + 1, i + 1) end
S['repeat'] = function(s, n) return srep(s, n) end
function S.padStart(s, n, p) p = p or ' '; local l = __len(s); if l >= n then return s end local fill = srep(p, math.ceil((n - l) / #p)); return ssub(fill, 1, n - l) .. s end
function S.padEnd(s, n, p) p = p or ' '; local l = __len(s); if l >= n then return s end local fill = srep(p, math.ceil((n - l) / #p)); return s .. ssub(fill, 1, n - l) end
function S.concat(s, ...) local t = { s }; for _, v in ipairs({ ... }) do t[#t + 1] = str_(v) end return tconcat(t) end
function S.toString(s) return s end

-- method call dispatch: arrays and strings get the built-ins; anything else calls its own function field
function __call(o, m, ...)
  if isarr(o) then local f = A[m]; if f then return f(o, ...) end
  elseif type(o) == 'string' then local f = S[m]; if f then return f(o, ...) end
  elseif type(o) == 'number' then if m == 'toFixed' then local d = ...; return sfmt('%.' .. (d or 0) .. 'f', o) elseif m == 'toString' then return numstr(o) end
  elseif type(o) == 'table' then local mt = getmetatable(o); if mt and mt.__methods then local f = mt.__methods[m]; if f then return f(o, ...) end end end
  if o == nil then error("Cannot read property '" .. m .. "' of undefined", 2) end
  local f = o[m]; if f == nil then error('not a function: ' .. m, 2) end
  return f(...)
end

-- Set, Map, WeakMap
local function setAdd(s, v) local key = v; if key == nil then key = SET end if not s.__has[key] then s.__has[key] = true; s.__items[#s.__items + 1] = v end return s end
SET.__methods = {
  has = function(s, v) if v == nil then v = SET end return s.__has[v] == true end,
  add = setAdd,
  delete = function(s, v) local key = v == nil and SET or v; if not s.__has[key] then return false end s.__has[key] = nil; for i, x in ipairs(s.__items) do if x == v then table.remove(s.__items, i) break end end return true end,
  forEach = function(s, f) for _, v in ipairs(s.__items) do f(v, v, s) end end,
  values = function(s) return toArr(s) end,
}
SET.__size = function(s) return #s.__items end
SET.__index = function(s, k) if k == 'size' then return #rawget(s, '__items') end return nil end
MAP.__methods = {
  get = function(m, k) return m.__vals[k] end,
  set = function(m, k, v) if m.__vals[k] == nil and not m.__in[k] then m.__keys[#m.__keys + 1] = k; m.__in[k] = true end m.__vals[k] = v; return m end,
  has = function(m, k) return m.__in[k] == true end,
  delete = function(m, k) if not m.__in[k] then return false end m.__in[k] = nil; m.__vals[k] = nil; for i, x in ipairs(m.__keys) do if x == k then table.remove(m.__keys, i) break end end return true end,
}
MAP.__index = function(m, k) if k == 'size' then return #rawget(m, '__keys') end return nil end
local WMAP = { __methods = {
  get = function(m, k) return m.__w[k] end, set = function(m, k, v) m.__w[k] = v; return m end, has = function(m, k) return m.__w[k] ~= nil end,
  delete = function(m, k) local had = m.__w[k] ~= nil; m.__w[k] = nil; return had end } }

JS_Set = { new = function(it) local s = setmetatable({ __has = {}, __items = {} }, SET); if it ~= nil then for ok, v in __forof(it) do setAdd(s, v) end end return s end }
JS_Map = { new = function(it) local m = setmetatable({ __vals = {}, __in = {}, __keys = {} }, MAP); if it ~= nil then for ok, kv in __forof(it) do MAP.__methods.set(m, kv[0], kv[1]) end end return m end }
JS_WeakMap = { new = function() return setmetatable({ __w = setmetatable({}, { __mode = 'k' }) }, WMAP) end }
function __new(C, ...) if C == nil or C.new == nil then error('not a constructor') end return C.new(...) end

-- globals the compiled code may use
JS_Math = {
  max = function(...) local n = select('#', ...); local r = -huge; local t = { ... }; for i = 1, n do local v = tonum(t[i]); if v ~= v then return v end if v > r then r = v end end return r end,
  min = function(...) local n = select('#', ...); local r = huge; local t = { ... }; for i = 1, n do local v = tonum(t[i]); if v ~= v then return v end if v < r then r = v end end return r end,
  floor = function(x) return floor(tonum(x)) end, ceil = function(x) return math.ceil(tonum(x)) end, abs = function(x) return math.abs(tonum(x)) end,
  round = function(x) x = tonum(x); return floor(x + 0.5) end, sqrt = function(x) return math.sqrt(tonum(x)) end, pow = function(a, b) return tonum(a) ^ tonum(b) end,
  trunc = function(x) x = tonum(x); if x < 0 then return math.ceil(x) end return floor(x) end, sign = function(x) x = tonum(x); return x > 0 and 1 or x < 0 and -1 or x end,
  random = function() return math.random() end, PI = math.pi,
}
JS_Object = {
  keys = function(o) local ks = isarr(o) and A.keys(o) or nil; if ks then local out = { __n = ks.__n }; for i = 0, ks.__n - 1 do out[i] = numstr(i) end return mkA(out) end
    local k = keys(o); local out = { __n = #k }; for i = 1, #k do out[i - 1] = k[i] end return mkA(out) end,
  values = function(o) local k = keys(o); local out = { __n = #k }; for i = 1, #k do out[i - 1] = o[k[i]] end return mkA(out) end,
  entries = function(o) local k = keys(o); local out = { __n = #k }; for i = 1, #k do out[i - 1] = mkA({ [0] = k[i], o[k[i]], __n = 2 }) end return mkA(out) end,
  assign = function(t, ...) local srcs = { ... }; for i = 1, select('#', ...) do local s = srcs[i]; if s ~= nil then for _, k in ipairs(keys(s)) do __set(t, k, s[k]) end end end return t end,
}
JS_Array = {
  isArray = function(x) return isarr(x) end,
  from = function(src, f) local a
    if type(src) == 'table' and not isarr(src) and getmetatable(src) == nil then local n = src.length or 0; a = { __n = n }; for i = 0, n - 1 do a[i] = nil end a = mkA(a)
    else a = A.slice(toArr(src)) end
    if f then for i = 0, a.__n - 1 do a[i] = f(a[i], i) end end
    return a end,
}
JS_String = function(x) return str_(x) end
JS_Number = function(x) return tonum(x) end
JS_Infinity = huge
JS_JSON = {}
local function jstr(s)
  return '"' .. s:gsub('[%c"\\]', function(c)
    if c == '"' then return '\\"' elseif c == '\\' then return '\\\\' elseif c == '\n' then return '\\n' elseif c == '\r' then return '\\r' elseif c == '\t' then return '\\t' end
    return sfmt('\\u%04x', sbyte(c)) end) .. '"'
end
local function enc(v, out)
  local ty = type(v)
  if v == nil then out[#out + 1] = 'null'
  elseif ty == 'boolean' then out[#out + 1] = v and 'true' or 'false'
  elseif ty == 'number' then out[#out + 1] = (v ~= v or v == huge or v == -huge) and 'null' or numstr(v)
  elseif ty == 'string' then out[#out + 1] = jstr(v)
  elseif ty == 'function' then out[#out + 1] = 'null'
  elseif isarr(v) then out[#out + 1] = '['; for i = 0, v.__n - 1 do if i > 0 then out[#out + 1] = ',' end local x = v[i]; if type(x) == 'function' then x = nil end enc(x, out) end out[#out + 1] = ']'
  else
    local mt = getmetatable(v)
    if mt == SET or mt == MAP then out[#out + 1] = '{}'; return end
    out[#out + 1] = '{'; local first = true
    for _, k in ipairs(keys(v)) do local x = v[k]
      if x ~= nil and type(x) ~= 'function' then if not first then out[#out + 1] = ',' end first = false; out[#out + 1] = jstr(type(k) == 'number' and numstr(k) or k); out[#out + 1] = ':'; enc(x, out) end end
    out[#out + 1] = '}'
  end
end
JS_JSON.stringify = function(v) local out = {}; enc(v, out); return tconcat(out) end
local function nowms() local ok, t = pcall(function() return os.time() end); return (ok and t or 0) * 1000 end
JS_Date = { now = nowms, new = function() return { toISOString = function() local ok, s = pcall(function() return os.date('!%Y-%m-%dT%H:%M:%S.000Z') end); return ok and s or '' end } end }
JS_isNaN = function(x) x = tonum(x); return x ~= x end
JS_parseInt = function(s) local n = tonumber(str_(s):match('^%s*([%+%-]?%d+)')); if n == nil then return 0 / 0 end return n end
JS_parseFloat = function(s) local n = tonumber(str_(s):match('^%s*([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)')); if n == nil then return 0 / 0 end return n end
setmetatable(JS_Array, { __call = function(_, ...) local n = select('#', ...)
  if n == 1 and type((...)) == 'number' then return mkA({ __n = (...) }) end
  return __pack(...) end })
JS_Array.new = function(...) return JS_Array(...) end

end

GENOMES = {__mkO({["stv"]=3.9489082218593126, ["rOut"]=0.40105193568540115, ["rFree"]=2.5394223606812267, ["rRerun"]=3.9068112065245755, ["nbv"]=2.8027696968106786, ["fchase"]=1.7449325967382425, ["resBias"]=4.782639078869516, ["rcost"]=1.3751623325708842, ["missW"]=3.169264357443899, ["resStock"]=8.504389112741427, ["resFirst"]=0.5289423351069088, ["pRun"]=4.720328604135475, ["pRes"]=3.29872557508463, ["pBuy"]=4.848253768442046, ["pAdv"]=6, ["pIng"]=4.261285513594091, ["mGain"]=3.3579766753631586, ["mRes"]=2.284245733869959, ["mFullCash"]=-8.401744790258395, ["freeMin"]=2.9621831866531174, ["pileThr"]=3.334444437530409, ["drawCash"]=5.51325773656149, ["handCap"]=5.66883977621187, ["advMfg"]=1.196976577051061, ["advPrd"]=7.6948506366461515, ["advDis"]=4.437437296985416, ["advGen"]=2.690510861681146, ["advAll"]=5.692425517082724, ["advDef"]=6.673643375845413, ["advAtk"]=4.992487515076337, ["advGrow"]=6.347824515620552, ["advThr"]=5.767350484154753, ["advRes"]=7.168868054016369, ["advResMap"]=9.317393716348844, ["offerRes"]=5.65475306706503, ["ccv"]=1.2424064652592186, ["amax"]=0.14929111185483634, ["advScrap"]=5.622844052364264, ["mLoy"]=0.836467565078385, ["mCash"]=0.46414667115737074, ["mCard"]=3.3956529042223456, ["mCont"]=2.3257272502842374, ["heatAv"]=12.769165952887823, ["mKeep"]=2.2944717226713855, ["gKW"]=1.1915719965486653, ["gCapture"]=7.2850409082853504, ["gDefend"]=3.126163201387418, ["gSpare"]=1.7754865231805952, ["gBonusCell"]=2.1566112189315003, ["gHot"]=3.2790709506929256, ["gOutpost"]=9.484465001906461, ["gDeep"]=5.488582683097475, ["gRough"]=2.271147977238705, ["gAtk"]=3.16481830701933, ["gGrow"]=1.09883893863298, ["gPlaceMin"]=7.017526958137751, ["rImp"]=2.406243282682562, ["gImp"]=1.3138822145821614, ["impW"]=5.755860948935151, ["impSafe"]=-0.40626804743540734, ["scrapThr"]=-2, ["scrapOut"]=1.8379225343657006, ["mFam"]=2.3167281560599804, ["lobbyMap"]=0.6328382107894868, ["lobbyRes"]=5.514877564840861, ["bailRes"]=6.609835962219944, ["stCenter"]=0.7917202981012292, ["stGap"]=1.7131506194459019, ["stBonus"]=0.8944354605268003}, {"stv", "rOut", "rFree", "rRerun", "nbv", "fchase", "resBias", "rcost", "missW", "resStock", "resFirst", "pRun", "pRes", "pBuy", "pAdv", "pIng", "mGain", "mRes", "mFullCash", "freeMin", "pileThr", "drawCash", "handCap", "advMfg", "advPrd", "advDis", "advGen", "advAll", "advDef", "advAtk", "advGrow", "advThr", "advRes", "advResMap", "offerRes", "ccv", "amax", "advScrap", "mLoy", "mCash", "mCard", "mCont", "heatAv", "mKeep", "gKW", "gCapture", "gDefend", "gSpare", "gBonusCell", "gHot", "gOutpost", "gDeep", "gRough", "gAtk", "gGrow", "gPlaceMin", "rImp", "gImp", "impW", "impSafe", "scrapThr", "scrapOut", "mFam", "lobbyMap", "lobbyRes", "bailRes", "stCenter", "stGap", "stBonus"}),
__mkO({["stv"]=5.209876061513772, ["rOut"]=0.005834931375749697, ["rFree"]=2.5394223606812267, ["rRerun"]=3.108907156023235, ["nbv"]=4.746518281014742, ["fchase"]=3.587002146611414, ["resBias"]=4.782639078869516, ["rcost"]=1.2848393041375656, ["missW"]=3.169264357443899, ["resStock"]=9, ["resFirst"]=0.17853902502381708, ["pRun"]=4.720328604135475, ["pRes"]=2.804748521429549, ["pBuy"]=4.848253768442046, ["pAdv"]=6, ["pIng"]=1.6940074899025541, ["mGain"]=1.8720584362241304, ["mRes"]=3.6414985886459768, ["mFullCash"]=-10, ["freeMin"]=3.438090723368485, ["pileThr"]=3.334444437530409, ["drawCash"]=5.51325773656149, ["handCap"]=5.66883977621187, ["advMfg"]=0, ["advPrd"]=7.363125890013758, ["advDis"]=3.0028953170203065, ["advGen"]=3.7654841786254063, ["advAll"]=6.056592181667696, ["advDef"]=0.4160438107618644, ["advAtk"]=5.228424629326411, ["advGrow"]=4.461697443481286, ["advThr"]=5.767350484154753, ["advRes"]=7.168868054016369, ["advResMap"]=8.741205169032298, ["offerRes"]=6.446772329124242, ["ccv"]=1.2424064652592186, ["amax"]=0.23243964449772467, ["advScrap"]=5.622844052364264, ["mLoy"]=0.7660687096803354, ["mCash"]=0.5645157055483586, ["mCard"]=3.3956529042223456, ["mCont"]=2.3257272502842374, ["heatAv"]=15.776132170852906, ["mKeep"]=2.6265006607257, ["gKW"]=1.015211650999786, ["gCapture"]=7.2850409082853504, ["gDefend"]=3.126163201387418, ["gSpare"]=0.8799871806691723, ["gBonusCell"]=2.1566112189315003, ["gHot"]=3.2790709506929256, ["gOutpost"]=9.484465001906461, ["gDeep"]=5.488582683097475, ["gRough"]=2.271147977238705, ["gAtk"]=3.8976685458155695, ["gGrow"]=1.09883893863298, ["gPlaceMin"]=8, ["rImp"]=1.8706215023868915, ["gImp"]=1.3138822145821614, ["impW"]=7.707876541573198, ["impSafe"]=-1, ["scrapThr"]=-2, ["scrapOut"]=1.8379225343657006, ["mFam"]=2.620503508356509, ["lobbyMap"]=0.7581575514770739, ["lobbyRes"]=4.833586882914786, ["bailRes"]=6.313666782562506, ["stCenter"]=0.7917202981012292, ["stGap"]=2, ["stBonus"]=1.718258214644895}, {"stv", "rOut", "rFree", "rRerun", "nbv", "fchase", "resBias", "rcost", "missW", "resStock", "resFirst", "pRun", "pRes", "pBuy", "pAdv", "pIng", "mGain", "mRes", "mFullCash", "freeMin", "pileThr", "drawCash", "handCap", "advMfg", "advPrd", "advDis", "advGen", "advAll", "advDef", "advAtk", "advGrow", "advThr", "advRes", "advResMap", "offerRes", "ccv", "amax", "advScrap", "mLoy", "mCash", "mCard", "mCont", "heatAv", "mKeep", "gKW", "gCapture", "gDefend", "gSpare", "gBonusCell", "gHot", "gOutpost", "gDeep", "gRough", "gAtk", "gGrow", "gPlaceMin", "rImp", "gImp", "impW", "impSafe", "scrapThr", "scrapOut", "mFam", "lobbyMap", "lobbyRes", "bailRes", "stCenter", "stGap", "stBonus"}),
__mkO({["stv"]=5.209876061513772, ["rOut"]=0.005834931375749697, ["rFree"]=2.5394223606812267, ["rRerun"]=3.108907156023235, ["nbv"]=4.373921878743233, ["fchase"]=3.587002146611414, ["resBias"]=4.782639078869516, ["rcost"]=1.3751623325708842, ["missW"]=3.169264357443899, ["resStock"]=8.504389112741427, ["resFirst"]=0.17853902502381708, ["pRun"]=5.256951017305255, ["pRes"]=2.804748521429549, ["pBuy"]=4.914513408707904, ["pAdv"]=5.800122258314735, ["pIng"]=2.4947666251557505, ["mGain"]=1.7586592806314403, ["mRes"]=3.6414985886459768, ["mFullCash"]=-8.401744790258395, ["freeMin"]=2.9621831866531174, ["pileThr"]=1.8421651295402062, ["drawCash"]=4.9651118168917, ["handCap"]=2.879167233330399, ["advMfg"]=0, ["advPrd"]=8, ["advDis"]=3.4711665020525193, ["advGen"]=3.7654841786254063, ["advAll"]=5.021619940176606, ["advDef"]=2.3152977563388264, ["advAtk"]=2.735014325731699, ["advGrow"]=4.461697443481286, ["advThr"]=4.555412020444459, ["advRes"]=7.168868054016369, ["advResMap"]=9.317393716348844, ["offerRes"]=8.245347621008488, ["ccv"]=1.2424064652592186, ["amax"]=0.23243964449772467, ["advScrap"]=5.622844052364264, ["mLoy"]=2.134929030202329, ["mCash"]=0.5125177938613433, ["mCard"]=3.7841751344483137, ["mCont"]=2.0906940687995546, ["heatAv"]=15.776132170852906, ["mKeep"]=2.6265006607257, ["gKW"]=1.1915719965486653, ["gCapture"]=7.2850409082853504, ["gDefend"]=2.4745818437342617, ["gSpare"]=4.067203961599848, ["gBonusCell"]=1.489608090122744, ["gHot"]=3.2790709506929256, ["gOutpost"]=7.6439346161258, ["gDeep"]=5.488582683097475, ["gRough"]=3.6755743657512525, ["gAtk"]=3.8976685458155695, ["gGrow"]=1.09883893863298, ["gPlaceMin"]=7.017526958137751, ["rImp"]=1.8706215023868915, ["gImp"]=1.5342870041780463, ["impW"]=4.291283000473192, ["impSafe"]=-1, ["scrapThr"]=-2, ["scrapOut"]=1.6855738401556037, ["mFam"]=3.265937199705519, ["lobbyMap"]=0.7855136082328147, ["lobbyRes"]=5.627936550951366, ["bailRes"]=5.702249891806736, ["stCenter"]=0.7917202981012292, ["stGap"]=2, ["stBonus"]=1.718258214644895}, {"stv", "rOut", "rFree", "rRerun", "nbv", "fchase", "resBias", "rcost", "missW", "resStock", "resFirst", "pRun", "pRes", "pBuy", "pAdv", "pIng", "mGain", "mRes", "mFullCash", "freeMin", "pileThr", "drawCash", "handCap", "advMfg", "advPrd", "advDis", "advGen", "advAll", "advDef", "advAtk", "advGrow", "advThr", "advRes", "advResMap", "offerRes", "ccv", "amax", "advScrap", "mLoy", "mCash", "mCard", "mCont", "heatAv", "mKeep", "gKW", "gCapture", "gDefend", "gSpare", "gBonusCell", "gHot", "gOutpost", "gDeep", "gRough", "gAtk", "gGrow", "gPlaceMin", "rImp", "gImp", "impW", "impSafe", "scrapThr", "scrapOut", "mFam", "lobbyMap", "lobbyRes", "bailRes", "stCenter", "stGap", "stBonus"})}

function loadEngine()
local E
E = (function()  local __S1 = {}
__S1.researchDeck = function()  local T, out, id, keep, NM
T = __mkA({[0]=__mkA({[0]=1, (__mkA({[0]=__mkA({[0]=1, __mkO({}, {}), (__mkO({["get"]=__mkO({["out"]=3}, {"out"})}, {"get"})), __n=3}), __mkA({[0]=1, __mkO({}, {}), (__mkO({["get"]=__mkO({["rerun"]=1}, {"rerun"})}, {"get"})), __n=3}), __mkA({[0]=2, __mkO({}, {}), (__mkO({["st"]=1}, {"st"})), __n=3}), __mkA({[0]=2, __mkO({}, {}), (__mkO({["st"]=1}, {"st"})), __n=3}), __mkA({[0]=2, __mkO({}, {}), (__mkO({["get"]=__mkO({["out"]=5}, {"out"})}, {"get"})), __n=3}), __mkA({[0]=2, __mkO({}, {}), (__mkO({["get"]=__mkO({["free"]=1}, {"free"})}, {"get"})), __n=3}), __mkA({[0]=2, __mkO({}, {}), (__mkO({["get"]=__mkO({["rerun"]=1, ["out"]=2}, {"rerun", "out"})}, {"get"})), __n=3}), (__mkA({[0]=2, __mkO({}, {}), (__mkO({["get"]=__mkO({["out"]=4}, {"out"})}, {"get"})), __n=3})), __n=8})), __n=2}), __mkA({[0]=2, (__mkA({[0]=__mkA({[0]=3, __mkO({["sour"]=1}, {"sour"}), (__mkO({["st"]=1, ["get"]=__mkO({["out"]=2}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=3, __mkO({["sweet"]=1}, {"sweet"}), (__mkO({["st"]=1, ["get"]=__mkO({["out"]=2}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=3, __mkO({["sour"]=1}, {"sour"}), (__mkO({["get"]=__mkO({["out"]=8}, {"out"})}, {"get"})), __n=3}), __mkA({[0]=4, __mkO({["herb"]=1}, {"herb"}), (__mkO({["st"]=2}, {"st"})), __n=3}), __mkA({[0]=4, __mkO({["sour"]=1}, {"sour"}), (__mkO({["st"]=2}, {"st"})), __n=3}), __mkA({[0]=4, __mkO({["fizz"]=1}, {"fizz"}), (__mkO({["get"]=__mkO({["free"]=2}, {"free"})}, {"get"})), __n=3}), __mkA({[0]=3, __mkO({["sweet"]=1}, {"sweet"}), (__mkO({["st"]=1, ["get"]=__mkO({["out"]=2}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=4, __mkO({["sour"]=1}, {"sour"}), (__mkO({["get"]=__mkO({["free"]=2}, {"free"})}, {"get"})), __n=3}), (__mkA({[0]=3, __mkO({["herb"]=1}, {"herb"}), (__mkO({["get"]=__mkO({["rerun"]=1, ["out"]=3}, {"rerun", "out"})}, {"get"})), __n=3})), __n=9})), __n=2}), __mkA({[0]=3, (__mkA({[0]=__mkA({[0]=5, __mkO({["sour"]=2}, {"sour"}), (__mkO({["st"]=2, ["get"]=__mkO({["out"]=4}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=6, __mkO({["sour"]=1, ["sweet"]=1}, {"sour", "sweet"}), (__mkO({["st"]=3}, {"st"})), __n=3}), __mkA({[0]=5, __mkO({["herb"]=1, ["sour"]=1}, {"herb", "sour"}), (__mkO({["get"]=__mkO({["out"]=15}, {"out"})}, {"get"})), __n=3}), __mkA({[0]=6, __mkO({["fizz"]=1, ["sour"]=1}, {"fizz", "sour"}), (__mkO({["st"]=1, ["get"]=__mkO({["free"]=2}, {"free"})}, {"st", "get"})), __n=3}), __mkA({[0]=5, __mkO({["sweet"]=2}, {"sweet"}), (__mkO({["st"]=2}, {"st"})), __n=3}), __mkA({[0]=6, __mkO({["herb"]=1, ["fizz"]=1}, {"herb", "fizz"}), (__mkO({["st"]=2, ["get"]=__mkO({["out"]=4}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=6, __mkO({["sour"]=1, ["sweet"]=1}, {"sour", "sweet"}), (__mkO({["st"]=2, ["get"]=__mkO({["rerun"]=2}, {"rerun"})}, {"st", "get"})), __n=3}), (__mkA({[0]=7, __mkO({["sweet"]=1, ["herb"]=1}, {"sweet", "herb"}), (__mkO({["st"]=3, ["get"]=__mkO({["out"]=3}, {"out"})}, {"st", "get"})), __n=3})), __n=8})), __n=2}), (__mkA({[0]=4, (__mkA({[0]=__mkA({[0]=8, __mkO({["sour"]=2, ["sweet"]=2}, {"sour", "sweet"}), (__mkO({["st"]=3, ["get"]=__mkO({["out"]=8}, {"out"})}, {"st", "get"})), __n=3}), __mkA({[0]=10, __mkO({["sour"]=2, ["herb"]=2}, {"sour", "herb"}), (__mkO({["st"]=4}, {"st"})), __n=3}), __mkA({[0]=10, __mkO({["sour"]=2, ["fizz"]=2}, {"sour", "fizz"}), (__mkO({["st"]=2, ["get"]=__mkO({["free"]=3}, {"free"})}, {"st", "get"})), __n=3}), __mkA({[0]=9, __mkO({["sweet"]=2, ["herb"]=1}, {"sweet", "herb"}), (__mkO({["st"]=3, ["get"]=__mkO({["free"]=2}, {"free"})}, {"st", "get"})), __n=3}), (__mkA({[0]=8, __mkO({["fizz"]=2, ["sweet"]=1}, {"fizz", "sweet"}), (__mkO({["get"]=__mkO({["out"]=22, ["rerun"]=1}, {"out", "rerun"})}, {"get"})), __n=3})), __n=5})), __n=2})), __n=4})
out = __mkA({__n=0})
id = 0
keep = __S1.arr("RSIZE", ("99,99,99,99"))
NM = __mkA({[0]=__mkA({[0]="Ice in the pitcher", "Two-handed stirring", "A pinch of salt", "Zest, not juice", "A second pitcher", "A timer on the stove", "Your brother on the night shift", ("Grandma's recipe"), __n=8}), __mkA({[0]="Brown sugar", "Mint from the garden", "A bigger cooler", "Cane sugar from Mexico", "Meyer lemons", "A hand-crank juicer", "The family recipe box", "Fermentation crocks", ("Doing it yourself"), __n=9}), __mkA({[0]="Lavender lemonade", "Pink lemonade", "A bottling line", "Cold-pressing", "A small-batch philosophy", "Aged in oak", "Sparkling lemonade", ("Lemon-ginger tonic"), __n=8}), (__mkA({[0]="The perfect pour", "The lemonade of legend", "Full automation", "Artisanal by design", ("A factory that never sleeps"), __n=5})), __n=4})
for _, __v1 in __forof(T) do
local tier, cards
local __v3 = __get(__v1, 0); tier = __v3; local __v4 = __get(__v1, 1); cards = __v4; 
for _, __v5 in __forof(__call(__call(cards, "slice", 0, (__get(keep, (tier - 1)))), "entries")) do
local j, n, named, r
local __v7 = __get(__v5, 0); j = __v7; local __v8 = __get(__v5, 1); local __v9 = __get(__v8, 0); n = __v9; local __v10 = __get(__v8, 1); named = __v10; local __v11 = __get(__v8, 2); r = __v11; 
local nn, cost, card
nn = __call(JS_Object.values((named)), "reduce", function(a, b)  
do return __add(a, b) end
end, (0))
cost = __spreadO({{s=named}})
if __gt(((n - nn) - __S1.RCHEAP), 0) then
do local __v12 = cost; local __v13 = "any"; local __v14 = ((n - nn) - __S1.RCHEAP); __set(__v12, __v13, __v14) end
end
card = __mkO({["kind"]="res", ["id"]=__add("r", (function() local __v15 = __num(id); id = __v15 + 1 return __v15 end)()), ["tier"]=tier, ["cost"]=cost, ["st"]=(__T(r.st) or 0), ["get"]=__spreadO({{s=(__T(r.get) or __mkO({}, {}))}})}, {"kind", "id", "tier", "cost", "st", "get"})
do local __v16 = card; local __v17 = "name"; local __v18 = (__T(__get(__get(NM, (tier - 1)), j)) or (function() if __t(r.st) then return __get(__S1.RNAME, __add("st", JS_Math.min(4, (r.st)))) end return (__T(__get(__S1.RNAME, __get(JS_Object.keys((card.get)), 0))) or "Research") end)()); __set(__v16, __v17, __v18) end
__call(out, "push", (card))

end

end
do return (out) end
end
__S1.buildResearch = function(G)  local deck, tiers
deck = __S1.researchDeck()
tiers = __call(__mkA({[0]=1, 2, 3, (4), __n=4}), "map", (function(t)  
do return __S1.shuffle((__spreadA({{s=__call(deck, "filter", (function(c)  
do return (c.tier == t) end
end))}, {s=(function() if __t(__S1.ADV) then return __call(__call(__S1.ADVISORS, "filter", (function(a)  
do return (__S1.advTier((a)) == t) end
end)), "map", (function(a)  
do return __spreadO({{s=a}, {k="kind", v="adv"}}) end
end)) end return __mkA({__n=0}) end)()}}))) end
end))
do local __v19 = G; local __v20 = "rdeck"; local __v22 = __spreadA({{v=(function() local __v21 = __S1.WINCARD; if __t(__v21) then return __spreadO({{s=__S1.WINCARD}, {k="cost", v=__spreadO({{s=__S1.WINCARD.cost}})}}) end return __v21 end)()}, {s=__get(tiers, 3)}, {s=__get(tiers, 2)}, {s=__get(tiers, 1)}, {s=__get(tiers, 0)}}); __set(__v19, __v20, __v22) end
do local __v23 = G; local __v24 = "rrow"; local __v25 = __mkA({__n=0}); __set(__v23, __v24, __v25) end
do
local k
k = 0

while __lt(k, __S1.RROW) do
__S1.refillRow(G, k, (nil))

do k = __num(k) + 1 end
end
end
end
__S1.newGame = function(seats)  local n, S, G, PFS, names, plan, spots
n = __len(seats)
S = __get(__S1.MSIZE, n)
G = __mkO({["v"]=6, ["n"]=n, ["round"]=1, ["phase"]="stand", ["turn"]=0, ["order"]=__mkA({__n=0}), ["passed"]=__mkA({__n=0}), ["players"]=__mkA({__n=0}), ["deck"]=__mkA({__n=0}), ["disc"]=__mkA({__n=0}), ["piles"]=__mkO({["sweet"]=__mkA({__n=0}), ["sour"]=__mkA({__n=0}), ["herb"]=__mkA({__n=0}), ["fizz"]=__mkA({__n=0})}, {"sweet", "sour", "herb", "fizz"}), ["mdeck"]=__mkA({__n=0}), ["mkt"]=__mkA({__n=0}), ["mat"]=__mkA({__n=0}), ["map"]=__mkO({["size"]=S, ["cells"]=__mkA({__n=0})}, {"size", "cells"}), ["ideck"]=__mkA({__n=0}), ["idisc"]=__mkA({__n=0}), ["adeck"]=__mkA({__n=0}), ["arow"]=__mkA({__n=0}), ["rdeck"]=__mkA({__n=0}), ["rrow"]=__mkA({__n=0}), ["offer"]=nil, ["memoAt"]=0, ["memoQ"]=__mkA({__n=0}), ["heat"]=0, ["log"]=__mkA({__n=0}), ["winner"]=nil, ["choice"]=nil, ["pending"]=nil, ["reveal"]=nil, ["limon"]=nil, ["last"]=nil}, {"v", "n", "round", "phase", "turn", "order", "passed", "players", "deck", "disc", "piles", "mdeck", "mkt", "mat", "map", "ideck", "idisc", "adeck", "arow", "rdeck", "rrow", "offer", "memoAt", "memoQ", "heat", "log", "winner", "choice", "pending", "reveal", "limon", "last"})
if __t(__S1.ENV.PFS) then PFS = __S1.arr("PFS", ("15,15,15,15")) else PFS = __call(__S1.FAMS, "map", (function()  
do return __S1.PERFAM end
end)) end
__call(__S1.FAMS, "forEach", (function(f, i)  
do
local k
k = 0

while __lt(k, __get(PFS, i)) do
__call(G.deck, "push", (__mkO({["f"]=f, ["n"]=__get(__get(__S1.FLAVOR, f), __mod(k, __len(__get(__S1.FLAVOR, f))))}, {"f", "n"})))

do k = __num(k) + 1 end
end
end
end))
__S1.shuffle((G.deck))
do
local t
t = 1

while __le(t, 4) do
__call(G.mdeck, "push", __unpack(__spreadA({{s=__S1.shuffle((__call(__call(__S1.MACHINES, "filter", (function(m)  
do return (m.tier == t) end
end)), "map", (function(m)  
do return __spreadO({{s=m}}) end
end))))}})))

do t = __num(t) + 1 end
end
end
__call(G.mdeck, "reverse")
__S1.refillM((G))
__S1.buildResearch((G))
names = __S1.shuffle((__call(__S1.NAMES, "slice")))
do
local r
r = 0

while __lt(r, S) do
do
local c
c = 0

while __lt(c, S) do
__call(G.map.cells, "push", (__mkO({["id"]=__add(__add(__add("c", c), "r"), r), ["c"]=c, ["r"]=r, ["name"]=__call(names, "pop"), ["tok"]=__mkO({}, {}), ["home"]=nil, ["bonus"]=nil}, {"id", "c", "r", "name", "tok", "home", "bonus"})))

do c = __num(c) + 1 end
end
end

do r = __num(r) + 1 end
end
end
if (__S1.ENV.HOMES == "free") then plan = nil else plan = __get(__S1.BOARDS, n) end
if __t(plan) then
__S1.layBoard(G, plan, (S))
end
__call(__call(__S1.shuffle((__call(G.map.cells, "filter", (function(c)  
do return ((((not __t(c.hot)) and (not __t(c.rough))) and (not __t(c.link))) and (not (__t(plan) and __t(__call(plan.homes, "some", (function(__p0) local r, k; local __v31 = __get(__p0, 0); r = __v31; local __v32 = __get(__p0, 1); k = __v32;  
do return ((r == c.r) and (k == c.c)) end
end)))))) end
end)))), "slice", 0, (__add(n, 2))), "forEach", (function(c, i)  
do return (function() local __v34 = c; local __v35 = "bonus"; local __v33 = __spreadO({{s=__get(__S1.BONUS, __mod(i, __len(__S1.BONUS)))}}); __set(__v34, __v35, __v33) return __v33 end)() end
end))
for __v36 in __forin(__S1.IDECK) do
local t
t = __v36; 
for _, __v38 in __forof(__get(__S1.IDECK, t)) do
local x
x = __v38; 
__call(G.ideck, "push", (__mkO({["u"]=(function() local __v40 = __num(__S1.uid); __S1.uid = __v40 + 1 return __v40 end)(), ["t"]=t, ["x"]=x}, {"u", "t", "x"})))

end

end
__S1.shuffle((G.ideck))
__call(seats, "forEach", (function(s, i)  local p
p = __mkO({["name"]=s.name, ["bot"]=(not (not __t(s.bot))), ["gen"]=(__T(s.gen) or nil), ["spec"]=(__T(s.spec) or (__t(s.gen) and "evo" or __get(__mkA({[0]="mfg", "prd", "dis", ("gen"), __n=4}), JS_Math.floor(((JS_Math.random() * 4)))))), ["color"]=i, ["shelf"]=__mkA({__n=0}), ["cash"]=__S1.CASH0, ["hand"]=__mkO({["sweet"]=0, ["sour"]=0, ["herb"]=0, ["fizz"]=0}, {"sweet", "sour", "herb", "fizz"}), ["mach"]=__mkA({[0]=(__spreadO({{s=__S1.START}, {k="ran", v=false}})), __n=1}), ["adv"]=__mkA({__n=0}), ["tiles"]=__mkA({__n=0}), ["prog"]=0, ["era"]=1, ["loy"]=__S1.LOY0, ["stars"]=0, ["cont"]=__S1.num("C0", (__S1.CMAX)), ["ctl"]=0, ["tok"]=__S1.TOKN, ["home"]=nil, ["inf"]=__mkA({__n=0}), ["jail"]=false, ["raided"]=false, ["filed"]=false}, {"name", "bot", "gen", "spec", "color", "shelf", "cash", "hand", "mach", "adv", "tiles", "prog", "era", "loy", "stars", "cont", "ctl", "tok", "home", "inf", "jail", "raided", "filed"})
__call(G.players, "push", (p))
do
local k
k = 0

while __lt(k, 2) do
__S1.takeCard(G, p, ("sour"))

do k = __num(k) + 1 end
end
end
end))
if __t(__S1.ENV.G0CASH) then
do local __v42 = __get(G.players, 0); local __v43 = "cash"; local __v44 = __add(__get(__v42, __v43), __num(__S1.ENV.G0CASH)); __set(__v42, __v43, __v44) end
end
if __t(__S1.ENV.GIFT) then
local id, k, j, a
id = __S1.ENV.GIFT
k = __call(G.rdeck, "findIndex", (function(a)  
do return (a.id == id) end
end))
j = __call(G.arow, "findIndex", (function(a)  
do return (a.id == id) end
end))
if __ge(k, 0) then a = __get(__call(G.rdeck, "splice", k, (1)), 0) else a = (function() if __ge(j, 0) then return __get(__call(G.arow, "splice", j, (1)), 0) end return nil end)() end
if __t(a) then
__call((__get(G.players, 0)).adv, "push", (a))
__S1.refillA((G))
end
end
do local __v45 = G; local __v46 = "order"; local __v47 = __S1.shuffle((__call(G.players, "map", (function(_, i)  
do return i end
end)))); __set(__v45, __v46, __v47) end
do local __v48 = G; local __v49 = "turn"; local __v50 = __get(G.order, 0); __set(__v48, __v49, __v50) end
spots = __S1.startSpots(n, (S))
if __t(spots) then
local deal
deal = __S1.shuffle((__call(spots, "slice")))
__call(G.players, "forEach", (function(p, i)  local r, c, x
do local __v51 = __get(deal, i); local __v52 = __get(__v51, 0); r = __v52; local __v53 = __get(__v51, 1); c = __v53;  end
x = __call(G.map.cells, "find", (function(o)  
do return ((o.r == r) and (o.c == c)) end
end))
do local __v54 = x; local __v55 = "home"; local __v56 = i; __set(__v54, __v55, __v56) end
do local __v57 = x; local __v58 = "bonus"; local __v59 = nil; __set(__v57, __v58, __v59) end
do local __v60 = p; local __v61 = "home"; local __v62 = x.id; __set(__v60, __v61, __v62) end
do local __v63 = p; local __v64 = "spot"; local __v65 = __call(spots, "indexOf", (__get(deal, i))); __set(__v63, __v64, __v65) end
__S1.log(G, i, (__str(p.name) .. " sets up a card table in " .. __str(x.name) .. "."), ("up"))
end))
__S1.log(G, nil, "Round 1. The founders set up at the edges of the map.", ("news"))
__S1.startPhase(G, ("biz"))
do return (G) end
end
__S1.log(G, nil, ("Round 1. Each founder chooses a corner for the stand."), ("news"))
do return (G) end
end
__S1.takeCard = function(G, p, f)  local i
if (__S1.ENV.SDEAL == "0") then
do local __v66 = p.hand; local __v67 = f; __set(__v66, __v67, __num((function() local __v66 = p.hand; local __v67 = f; return __get(__v66, __v67) end)()) + 1) end
do return end
end
i = __call(G.deck, "findIndex", (function(c)  
do return (c.f == f) end
end))
if __ge(i, 0) then
__call(G.deck, "splice", i, (1))
do local __v68 = p.hand; local __v69 = f; __set(__v68, __v69, __num((function() local __v68 = p.hand; local __v69 = f; return __get(__v68, __v69) end)()) + 1) end
end
end
__S1.dealMat = function(G)  local ts, k
ts = __S1.shuffle((__call(__S1.TILESET, "map", (function(t)  
do return __spreadO({{s=t}, {k="get", v=__spreadO({{s=t.get}})}}) end
end))))
k = 0
for _, __v70 in __forof(G.mat) do
local __v71 = false
local t
t = __v70; 
repeat
if (t.d == 0) then
do break end
end
do local __v72 = t; local __v73 = "st"; local __v74 = (__get(ts, k)).st; __set(__v72, __v73, __v74) end
do local __v75 = t; local __v76 = "get"; local __v77 = (__get(ts, k)).get; __set(__v75, __v76, __v77) end
do local __v78 = t; local __v79 = "owner"; local __v80 = nil; __set(__v78, __v79, __v80) end
do local __v81 = t; local __v82 = "seen"; local __v83 = false; __set(__v81, __v82, __v83) end
do k = __num(k) + 1 end
until true
if __v71 then break end
end
end
__S1.layBoard = function(G, plan, S)  local at, e, near, ring, maxD, pools, world
at = function(r, c)  
do return __call(G.map.cells, "find", (function(x)  
do return ((x.r == r) and (x.c == c)) end
end)) end
end
e = (S - 1)
near = function(x)  
do return JS_Math.min(__unpack(__spreadA({{s=__call(plan.homes, "map", (function(__p0) local r, c; local __v84 = __get(__p0, 0); r = __v84; local __v85 = __get(__p0, 1); c = __v85;  
do return __add(JS_Math.abs(((r - x.r))), JS_Math.abs(((c - x.c)))) end
end))}}))) end
end
ring = __call(G.map.cells, "filter", (function(x)  
do return ((((x.r == 0) or (x.c == 0)) or (x.r == e)) or (x.c == e)) end
end))
maxD = JS_Math.max(__unpack(__spreadA({{s=__call(ring, "map", (near))}})))
pools = __call(__S1.RING, "map", (function(a)  
do return __S1.shuffle((__call(a, "slice"))) end
end))
__call(__call(__call(ring, "slice"), "sort", (function(a, b)  
do return (near((a)) - near((b))) end
end)), "forEach", (function(x)  local dd, t, k
dd = near((x))
if __le(dd, 1) then t = dd else t = JS_Math.round((((dd / maxD) * (__len(__S1.RING) - 1)))) end
k = 0
do 
while ((not __t(__len(__get(pools, JS_Math.min((__len(__S1.RING) - 1), (JS_Math.max(0, (__add(t, k))))))))) and __lt(k, 8)) do
do local __v87; if __le(k, 0) then __v87 = __add((-k), 1) else __v87 = (-k) end k = __v87 end

end end
do local __v88 = x; local __v89 = "name"; local __v90 = (__T(__call(__get(pools, JS_Math.min((__len(__S1.RING) - 1), (JS_Math.max(0, (__add(t, k)))))), "pop")) or x.name); __set(__v88, __v89, __v90) end
end))
world = __S1.shuffle((__call(__S1.WORLD, "slice")))
__call(__call(G.map.cells, "filter", (function(x)  
do return (not __t(__call(ring, "includes", (x)))) end
end)), "forEach", (function(x)  
do return (function() local __v92 = x; local __v93 = "name"; local __v91 = __call(world, "pop"); __set(__v92, __v93, __v91) return __v91 end)() end
end))
__call(plan.hot, "forEach", (function(__p0, i) local r, c, out; local __v94 = __get(__p0, 0); r = __v94; local __v95 = __get(__p0, 1); c = __v95; local __v96 = __get(__p0, 2); out = __v96;  local x
x = at(r, (c))
do local __v97 = x; local __v98 = "hot"; local __v99 = __mkO({["out"]=out}, {"out"}); __set(__v97, __v98, __v99) end
do local __v100 = x; local __v101 = "name"; local __v102 = __get(__S1.HOTN, i); __set(__v100, __v101, __v102) end
end))
__call(plan.rough, "forEach", (function(__p0, i) local r, c; local __v103 = __get(__p0, 0); r = __v103; local __v104 = __get(__p0, 1); c = __v104;  local x
x = at(r, (c))
do local __v105 = x; local __v106 = "rough"; local __v107 = 2; __set(__v105, __v106, __v107) end
do local __v108 = x; local __v109 = "name"; local __v110 = __get(__S1.ROUGHN, i); __set(__v108, __v109, __v110) end
end))
__call(plan.links, "forEach", (function(grp, g)  
do return __call(grp, "forEach", (function(__p0) local r, c; local __v111 = __get(__p0, 0); r = __v111; local __v112 = __get(__p0, 1); c = __v112;  
do local __v113 = at(r, (c)); local __v114 = "link"; local __v115 = __get(__S1.ROUTES, g); __set(__v113, __v114, __v115) end
end)) end
end))
if __t(__S1.IMPON) then
__call(G.map.cells, "forEach", (function(x)  local inner
inner = (not __t(__call(ring, "includes", (x))))
do local __v116 = x; local __v117 = "imp"; local __v118 = 0; __set(__v116, __v117, __v118) end
do local __v119 = x; local __v120 = "yield"; local __v121 = __call(__S1.IMPY, "map", (function(y)  
do return __add(__add(y, (function() if __t(inner) then return __S1.IMPC end return 0 end)()), (function() if __t(x.hot) then return __S1.IMPC end return 0 end)()) end
end)); __set(__v119, __v120, __v121) end
end))
end
end
__S1.startSpots = function(n, S)  local e
if (__S1.ENV.HOMES == "free") then
do return (nil) end
end
if __t(__S1.ENV.HOMES) then
do return (__call(__call(__S1.ENV.HOMES, "split", (";")), "map", (function(x)  
do return __call(__call(x, "split", (",")), "map", (JS_Number)) end
end))) end
end
e = (S - 1)
if (n == 2) then
do return (__mkA({[0]=__mkA({[0]=0, (0), __n=2}), (__mkA({[0]=e, (e), __n=2})), __n=2})) end
end
if (__t(__get(__S1.BOARDS, n)) and (S == __add(__call((__get(__S1.BOARDS, n)).homes, "reduce", function(m, __p1) local r, c; local __v122 = __get(__p1, 0); r = __v122; local __v123 = __get(__p1, 1); c = __v123;  
do return JS_Math.max(m, r, (c)) end
end, (0)), 1))) then
do return ((__get(__S1.BOARDS, n)).homes) end
end
if (n == 3) then
do return (__mkA({[0]=__mkA({[0]=1, (0), __n=2}), __mkA({[0]=2, (e), __n=2}), (__mkA({[0]=e, (2), __n=2})), __n=3})) end
end
if (n == 4) then
do return (__mkA({[0]=__mkA({[0]=0, (0), __n=2}), __mkA({[0]=0, (e), __n=2}), __mkA({[0]=e, (0), __n=2}), (__mkA({[0]=e, (e), __n=2})), __n=4})) end
end
do return (nil) end
end
__S1.refillA = function(G)  

end
__S1.boardAdvisor = function(G, a)  
__call(G.arow, "push", (a))
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=a.name, ["tier"]=0}, {"name", "tier"}), ["from"]="rdeck", ["to"]=__add("arow-", (__len(G.arow) - 1)), ["slide"]=true}, {"k", "m", "from", "to", "slide"})))
if __gt(__len(G.arow), __S1.ABOARD) then
local old
old = __call(G.arow, "shift")
__S1.log(G, nil, (__str(old.name) .. " takes a job elsewhere."), ("news"))
end
end
__S1.refillRow = function(G, k, pi)  
do local __v124 = false

while __t(__len(G.rdeck)) do
repeat
local c
c = __call(G.rdeck, "pop")
if (c.kind == "adv") then
local kind, a
do local __v125 = c; local __v126 = __get(__v125, "kind"); kind = __v126; a = __objrest(__v125, {"kind"});  end
if ((pi ~= nil) and (G.winner == nil)) then
do local __v127 = G; local __v128 = "offer"; local __v129 = __mkO({["pi"]=pi, ["a"]=a, ["k"]=k}, {"pi", "a", "k"}); __set(__v127, __v128, __v129) end
__S1.log(G, pi, (__str((__get(G.players, pi)).name) .. " turns over " .. __str(a.name) .. ", " .. __str(a.role) .. "."), ("news"))
do return (true) end
end
__S1.boardAdvisor(G, (a))
__S1.log(G, nil, (__str(a.name) .. " is looking for work."), ("news"))
do break end
end
do local __v130 = G.rrow; local __v131 = k; local __v132 = c; __set(__v130, __v131, __v132) end
if __t(c.win) then
do local __v133 = G; local __v134 = "st"; local __v135 = (__T(G.st) or __mkO({}, {})); __set(__v133, __v134, __v135) end
do local __v136 = G.st; local __v137 = "formulaAt"; local __v138 = G.round; __set(__v136, __v137, __v138) end
end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=(function() if __t(c.win) then return c.name end return "Experiment" end)(), ["tier"]=c.tier}, {"name", "tier"}), ["from"]="rdeck", ["to"]=__add("rcard-", k), ["slide"]=true}, {"k", "m", "from", "to", "slide"})))
do return (false) end
until true
if __v124 then break end
end end
do local __v139 = G.rrow; local __v140 = k; local __v141 = nil; __set(__v139, __v140, __v141) end
do return (false) end
end
__S1.canTakeOffer = function(G)  local o, p
o = G.offer
if (not __t(o)) then
do return (__S1.no(("Nothing on offer"))) end
end
p = __get(G.players, o.pi)
if __lt((__T(p.cont) or 0), (__T(o.a.cc) or 0)) then
do return (__S1.no((("Needs " .. __str(o.a.cc) .. " control")))) end
end
if __lt(p.cash, o.a.price) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=o.a.price, ["cont"]=(__T(o.a.cc) or 0)}, {"cash", "cont"})))) end end
end
__S1.takeOffer = function(G, scrap)  local o, pi, p, gone
o = G.offer
if ((not __t(o)) or (not __t((__S1.canTakeOffer((G))).ok))) then
do return (false) end
end
pi = o.pi
p = __get(G.players, pi)
if (__ge(__S1.used((p)), __S1.SLOTS) and (not __t(__S1.canVacate(p, (scrap))))) then
do return (false) end
end
do local __v142 = p; local __v143 = "cash"; local __v144 = (__get(__v142, __v143) - o.a.price); __set(__v142, __v143, __v144) end
__S1.acc(p, "adv", (o.a.price))
__S1.acc(p, "advN", (1))
do local __v145 = p; local __v146 = "cont"; local __v147 = (__get(__v145, __v146) - (__T(o.a.cc) or 0)); __set(__v145, __v146, __v147) end
if __ge(__S1.used((p)), __S1.SLOTS) then gone = __S1.vacate(G, pi, (scrap)) else gone = "" end
__call(p.adv, "push", (o.a))
__S1.hook(G, pi, (o.a))
if not __t(__call((function() local __v149 = p; local __v150 = "ever"; local __v148 = (__T(p.ever) or __mkA({__n=0})); __set(__v149, __v150, __v148) return __v148 end)(), "includes", (o.a.id))) then __call(p.ever, "push", (o.a.id)) end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=o.a.name, ["tier"]=0}, {"name", "tier"}), ["from"]="rdeck", ["to"]=__add(__add(__add("adv-", pi), "-"), (__len(p.adv) - 1))}, {"k", "m", "from", "to"})))
do local __v151 = G; local __v152 = "st"; local __v153 = (__T(G.st) or __mkO({}, {})); __set(__v151, __v152, __v153) end
do local __v154 = G.st; local __v155 = "offersTaken"; local __v156 = __add((__T(G.st.offersTaken) or 0), 1); __set(__v154, __v155, __v156) end
__S1.log(G, pi, (__str(p.name) .. " hires " .. __str(o.a.name) .. " on the spot. (" .. __str(o.a.who) .. ")" .. __str(gone)), ("up"))
do return (__S1.afterOffer((G))) end
end
__S1.declineOffer = function(G)  local o
o = G.offer
if (not __t(o)) then
do return (false) end
end
__S1.boardAdvisor(G, (o.a))
__S1.log(G, o.pi, (__str((__get(G.players, o.pi)).name) .. " passes on " .. __str(o.a.name) .. ", who goes to the board."), ("news"))
do return (__S1.afterOffer((G))) end
end
__S1.afterOffer = function(G)  local o
o = G.offer
do local __v157 = G; local __v158 = "offer"; local __v159 = nil; __set(__v157, __v158, __v159) end
if __t(__S1.refillRow(G, o.k, (o.pi))) then
do local __v160 = G.offer; local __v161 = "next"; local __v162 = o.next; __set(__v160, __v161, __v162) end
do return (true) end
end
if (__t(o.next) and (G.winner == nil)) then
__S1.next((G))
end
do return (true) end
end
__S1.refillM = function(G)  
do 
while (__lt(__len(G.mkt), __S1.MKT) and __t(__len(G.mdeck))) do
local m
m = __call(G.mdeck, "pop")
__call(G.mkt, "push", (m))
do local __v164 = (function() local __v167 = G; local __v168 = "mseen"; local __v166 = (__T(G.mseen) or __mkO({}, {})); __set(__v167, __v168, __v166) return __v166 end)(); local __v165 = m.id; local __v169 = (__T(__get(G.mseen, m.id)) or G.round); __set(__v164, __v165, __v169) end

end end
__call(G.mkt, "sort", (function(a, b)  
do return (a.price - b.price) end
end))
end
__S1.log = function(G, p, text, kind)  
__call(G.log, "push", (__mkO({["p"]=p, ["text"]=text, ["kind"]=(__T(kind) or "news"), ["r"]=G.round}, {"p", "text", "kind", "r"})))
if __gt(__len(G.log), 120) then
__call(G.log, "shift")
end
__S1.recLog(G, p, text, (kind))
end
__S1.travel = function(G, pi)  local on, origins, key, cache, d, q, byPos
on = __S1.outpostN((__get(G.players, pi)))
origins = __call(G.map.cells, "filter", (function(x)  
do return ((x.home == pi) or __ge((__T(__get(x.tok, pi)) or 0), on)) end
end))
key = __add(__add(pi, ":"), __call(__call(origins, "map", (function(x)  
do return x.id end
end)), "join", (",")))
cache = __call(__S1.DCACHE, "get", (G))
if (not __t(cache)) then
__call(__S1.DCACHE, "set", G, ((function() local __v170 = __mkO({}, {}); cache = __v170 return __v170 end)()))
end
if (__t(__get(cache, pi)) and ((__get(cache, pi)).key == key)) then
do return ((__get(cache, pi)).d) end
end
d = __mkO({}, {})
q = __mkA({__n=0})
__call(origins, "forEach", (function(x)  
do local __v171 = d; local __v172 = x.id; local __v173 = 0; __set(__v171, __v172, __v173) end
__call(q, "push", (x))
end))
byPos = __mkO({}, {})
__call(G.map.cells, "forEach", (function(x)  
do return (function() local __v175 = byPos; local __v176 = __add(__add(x.r, ","), x.c); local __v174 = x; __set(__v175, __v176, __v174) return __v174 end)() end
end))
do 
while __t(__len(q)) do
local x, nb
x = __call(q, "shift")
nb = __spreadA({{v=__get(byPos, __add(__add((x.r - 1), ","), x.c))}, {v=__get(byPos, __add(__add(__add(x.r, 1), ","), x.c))}, {v=__get(byPos, __add(__add(x.r, ","), (x.c - 1)))}, {v=__get(byPos, __add(__add(x.r, ","), __add(x.c, 1)))}, {s=(function() if __t(x.link) then return __call(G.map.cells, "filter", (function(y)  
do return ((y.link == x.link) and (y ~= x)) end
end)) end return __mkA({__n=0}) end)()}})
for _, __v178 in __forof(nb) do
local y
y = __v178; 
if (__t(y) and (__get(d, y.id) == nil)) then
do local __v180 = d; local __v181 = y.id; local __v182 = __add(__get(d, x.id), 1); __set(__v180, __v181, __v182) end
__call(q, "push", (y))
end

end

end end
do local __v183 = cache; local __v184 = pi; local __v185 = __mkO({["key"]=key, ["d"]=d}, {"key", "d"}); __set(__v183, __v184, __v185) end
do return (d) end
end
__S1.bizOrder = function(G)  
do return (__call(__call(G.players, "map", (function(_, i)  
do return i end
end)), "sort", (function(a, b)  
do return (__T((__T((__S1.tina(G, (a)) - __S1.tina(G, (b)))) or (__S1.rank(G, (a)) - __S1.rank(G, (b))))) or (__call(G.order, "indexOf", (a)) - __call(G.order, "indexOf", (b)))) end
end))) end
end
__S1.placeOrder = function(G)  
do return (__call(__call(G.players, "map", (function(_, i)  
do return i end
end)), "sort", (function(a, b)  
do return (__T((__T((__S1.tina(G, (a)) - __S1.tina(G, (b)))) or (__S1.rank(G, (b)) - __S1.rank(G, (a))))) or (__call(G.order, "indexOf", (a)) - __call(G.order, "indexOf", (b)))) end
end))) end
end
__S1.startPhase = function(G, phase)  
do local __v186 = G; local __v187 = "phase"; local __v188 = phase; __set(__v186, __v187, __v188) end
do local __v189 = G; local __v190 = "passed"; local __v191 = __mkA({__n=0}); __set(__v189, __v190, __v191) end
do local __v192; if (phase == "biz") then __v192 = __S1.bizOrder((G)) else __v192 = __S1.placeOrder((G)) end local __v193 = G; local __v194 = "order"; local __v195 = __v192; __set(__v193, __v194, __v195) end
if (phase == "biz") then
__call(G.players, "forEach", (function(q, i)  
__call(q.mach, "forEach", (function(m)  
do return (function() local __v197 = m; local __v198 = "ran"; local __v196 = false; __set(__v197, __v198, __v196) return __v196 end)() end
end))
do local __v199 = q; local __v200 = "jail"; local __v201 = q.raided; __set(__v199, __v200, __v201) end
do local __v202 = q; local __v203 = "raided"; local __v204 = false; __set(__v202, __v203, __v204) end
do local __v206 = q; local __v207 = "g2"; local __v205 = (function() local __v209 = q; local __v210 = "halUsed"; local __v208 = (function() local __v212 = q; local __v213 = "cfoR"; local __v211 = false; __set(__v212, __v213, __v211) return __v211 end)(); __set(__v209, __v210, __v208) return __v208 end)(); __set(__v206, __v207, __v205); local __v214 = q; local __v215 = "t2"; local __v216 = __v205; __set(__v214, __v215, __v216) end
if __t(__S1.ONE) then
__S1.pour(G, i, (0))
end
if (__t(__S1.hasA(q, ("swamp"))) and (__mod(G.round, 3) == 0)) then
__S1.log(G, i, ("The Deep Swamp Creature brings " .. __str(q.name) .. " a favor."), ("inf"))
__S1.drawInf(G, i, (1))
end
end))
end
if (phase == "place") then
__call(G.players, "forEach", (function(q, i)  local n
do local __v217 = q; local __v218 = "r2"; local __v219 = false; __set(__v217, __v218, __v219) end
n = __add(__add(__S1.stipend(G, (i)), (function() if ((__t(__num((__T(__S1.ENV.LGIFT) or 0))) and (i == 0)) and (G.round == __num((__T(__S1.ENV.LGR) or 2)))) then return __num(__S1.ENV.LGIFT) end return 0 end)()), 0)
do local __v220 = q; local __v221 = "loy"; local __v222 = __add(__get(__v220, __v221), n); __set(__v220, __v221, __v222) end
__S1.lt(G, i, "era", (__S1.stipend(G, (i))))
if ((__t(__num((__T(__S1.ENV.CGIFT) or 0))) and (i == 0)) and (G.round == __num((__T(__S1.ENV.LGR) or 2)))) then
do local __v223 = q; local __v224 = "cash"; local __v225 = __add(__get(__v223, __v224), __num(__S1.ENV.CGIFT)); __set(__v223, __v224, __v225) end
end
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="heart", ["n"]=n, ["from"]=__add("era-", i), ["to"]=__add("loy-", i)}, {"k", "n", "from", "to"})))
end))
end
do local __v226 = G; local __v227 = "turn"; local __v228 = __get(G.order, 0); __set(__v226, __v227, __v228) end
__S1.log(G, nil, ((phase == "biz") and ("Round " .. __str(G.round) .. ". The market opens.") or ("Round " .. __str(G.round) .. ". Every company collects loyalty for its era, and loyalty goes on the map.")), ("news"))
end
__S1.next = function(G)  local me, o, start
do __S1.ops = __num(__S1.ops) + 1 end
if (G.winner ~= nil) then
do return end
end
me = __get(G.players, G.turn)
o = G.order
start = __call(o, "indexOf", (G.turn))
do
local k
k = 1

while __le(k, __len(o)) do
local i
i = __get(o, __mod(__add(start, k), __len(o)))
if (not __t(__call(G.passed, "includes", (i)))) then
do local __v230 = G; local __v231 = "turn"; local __v232 = i; __set(__v230, __v231, __v232) end
do return end
end

do k = __num(k) + 1 end
end
end
__S1.endPhase((G))
end
__S1.endPhase = function(G)  
if (G.phase == "stand") then
do return (__S1.startPhase(G, ("biz"))) end
end
if (G.phase == "biz") then
do return (__S1.startPhase(G, ("place"))) end
end
if (G.phase == "place") then
do return (__S1.payday((G))) end
end
end
__S1.pass = function(G)  
if __t(__S1.myTurn((G))) then
do return (false) end
end
if ((G.phase == "biz") and __t(__S1.hasA(__S1.P((G)), ("tina")))) then
__S1.drawFree(G, __S1.P((G)), (1))
__S1.log(G, G.turn, ("Tina handles a few things while " .. __str((__S1.P((G))).name) .. " is out."), ("news"))
end
__call(G.passed, "push", (G.turn))
__S1.next((G))
do return (true) end
end
__S1.canStand = function(G, id)  local c
c = __S1.cell(G, (id))
if (G.phase ~= "stand") then
do return (__S1.no(("Not now"))) end
end
if (not __t(c)) then
do return (__S1.no(("No market"))) end
end
if (c.home ~= nil) then
do return (__S1.no(("Taken"))) end
end
if __t(__call(G.map.cells, "some", (function(o)  
do return ((o.home ~= nil) and __lt(__add(JS_Math.abs(((o.c - c.c))), JS_Math.abs(((o.r - c.r)))), 2)) end
end))) then
do return (__S1.no(("Too close to another stand"))) end
end
do return (__S1.yes()) end
end
__S1.stand = function(G, id)  local pi, p, c
if (not __t((__S1.canStand(G, (id))).ok)) then
do return (false) end
end
pi = G.turn
p = __S1.P((G))
c = __S1.cell(G, (id))
do local __v233 = c; local __v234 = "home"; local __v235 = pi; __set(__v233, __v234, __v235) end
do local __v236 = p; local __v237 = "home"; local __v238 = id; __set(__v236, __v237, __v238) end
if __t(__S1.hasA(p, ("becky"))) then
do local __v239 = c; local __v240 = "becky"; local __v241 = pi; __set(__v239, __v240, __v241) end
end
__S1.fx(G, (__mkO({["k"]="stand", ["pi"]=pi, ["from"]=__add("seat-", pi), ["to"]=__add("cell-", id)}, {"k", "pi", "from", "to"})))
__S1.log(G, pi, (__str(p.name) .. " sets up a card table in " .. __str(c.name) .. "."), ("up"))
__call(G.passed, "push", (pi))
__S1.next((G))
do return (true) end
end
__S1.canDraw = function(G)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then do return (__S1.no((__S1.myTurn(G, ("biz"))))) end else if __t(p.jail) then do return (__S1.no(("In custody"))) end else if __lt(p.cash, __S1.drawCost((p))) then do return (__S1.no(("Can't afford"))) end else if (not __t(__add(__len(G.deck), __len(G.disc)))) then do return (__S1.no(("The deck is empty"))) end else do return (__S1.yes((__mkO({["cash"]=__S1.drawCost((p))}, {"cash"})))) end end end end end
end
__S1.draw = function(G)  local x, p, cs
x = __S1.canDraw((G))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
do local __v242 = p; local __v243 = "cash"; local __v244 = (__get(__v242, __v243) - x.cost.cash); __set(__v242, __v243, __v244) end
__S1.acc(p, "ing", (x.cost.cash))
__S1.acc(p, "drawN", (1))
if __t(__S1.hasA(p, ("cfo"))) then
do local __v245 = p; local __v246 = "cfoR"; local __v247 = true; __set(__v245, __v246, __v247) end
end
cs = __mkA({__n=0})
do
local k
k = 0

while __lt(k, 3) do
if (not __t(__len(G.deck))) then
do local __v249 = G; local __v250 = "deck"; local __v251 = __S1.shuffle((G.disc)); __set(__v249, __v250, __v251) end
do local __v252 = G; local __v253 = "disc"; local __v254 = __mkA({__n=0}); __set(__v252, __v253, __v254) end
end
if __t(__len(G.deck)) then
__call(cs, "push", (__call(G.deck, "pop")))
end

do k = __num(k) + 1 end
end
end
do local __v255 = G; local __v256 = "choice"; local __v257 = __mkO({["pi"]=G.turn, ["cards"]=cs}, {"pi", "cards"}); __set(__v255, __v256, __v257) end
do __S1.ops = __add(__S1.ops, 2) end
__S1.fx(G, (__mkO({["k"]="back", ["n"]=__len(cs), ["from"]="ingdeck", ["to"]="choice"}, {"k", "n", "from", "to"})))
do return (true) end
end
__S1.pick = function(G, i)  local ch, p, c, left
ch = G.choice
if (((not __t(ch)) or (not __t(__get(ch.cards, i)))) or __t((__get(ch.cards, i)).taken)) then
do return (false) end
end
p = __get(G.players, ch.pi)
c = __get(ch.cards, i)
do local __v258 = p.hand; local __v259 = c.f; __set(__v258, __v259, __num((function() local __v258 = p.hand; local __v259 = c.f; return __get(__v258, __v259) end)()) + 1) end
do local __v260 = c; local __v261 = "taken"; local __v262 = true; __set(__v260, __v261, __v262) end
do local __v263 = ch; local __v264 = "kept"; local __v265 = __add((__T(ch.kept) or 0), 1); __set(__v263, __v264, __v265) end
__S1.fx(G, (__mkO({["k"]="ing", ["f"]=c.f, ["n"]=1, ["from"]=__add("choice-", i), ["to"]=__add(__add(__add("hand-", ch.pi), "-"), c.f)}, {"k", "f", "n", "from", "to"})))
if (__lt(ch.kept, __S1.KEEP) and __t(__call(ch.cards, "some", (function(o)  
do return (not __t(o.taken)) end
end)))) then
do return (true) end
end
left = __call(__call(ch.cards, "map", (function(o, k)  
do return __mkO({["o"]=o, ["k"]=k}, {"o", "k"}) end
end)), "filter", (function(x)  
do return (not __t(x.o.taken)) end
end))
__call(left, "forEach", (function(x)  
__call(__get(G.piles, x.o.f), "push", (x.o))
__S1.fx(G, (__mkO({["k"]="ing", ["f"]=x.o.f, ["n"]=1, ["from"]=__add("choice-", x.k), ["to"]=__add("pile-", x.o.f)}, {"k", "f", "n", "from", "to"})))
end))
do local __v266 = G; local __v267 = "st"; local __v268 = (__T(G.st) or __mkO({}, {})); __set(__v266, __v267, __v268) end
do local __v269 = G.st; local __v270 = "drawn"; local __v271 = __add((__T(G.st.drawn) or 0), 1); __set(__v269, __v270, __v271) end
if __t(__S1.TRACE) then
__call((function() local __v273 = G; local __v274 = "clog2"; local __v272 = (__T(G.clog2) or __mkA({__n=0})); __set(__v273, __v274, __v272) return __v272 end)(), "push", (__mkO({["pi"]=ch.pi, ["r"]=G.round, ["n"]=ch.kept, ["how"]="draw"}, {"pi", "r", "n", "how"})))
end
__S1.log(G, ch.pi, (__str(p.name) .. " buys " .. __str(__call(__call(__call(ch.cards, "filter", (function(o)  
do return o.taken end
end)), "map", (function(o)  
do return __call(o.n, "toLowerCase") end
end)), "join", (" and "))) .. " and leaves " .. __str((__T(__call(__call(left, "map", (function(x)  
do return __call(x.o.n, "toLowerCase") end
end)), "join", (" and "))) or "nothing")) .. " on the counter."), ("news"))
__call(ch.cards, "forEach", (function(o)  
do return (function() rawset(o, "taken", nil) return true end)() end
end))
do local __v275 = G; local __v276 = "choice"; local __v277 = nil; __set(__v275, __v276, __v277) end
__S1.next((G))
do return (true) end
end
__S1.canTake = function(G, f)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then do return (__S1.no((__S1.myTurn(G, ("biz"))))) end else if __t(p.jail) then do return (__S1.no(("In custody"))) end else if (not __t(__len(__get(G.piles, f)))) then do return (__S1.no(("Nothing there"))) end else if __lt(p.cash, __S1.TAKE) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=__S1.TAKE}, {"cash"})))) end end end end end
end
__S1.take = function(G, f)  local x, p, n
x = __S1.canTake(G, (f))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
n = (__t(__S1.PILE1) and 1 or __len(__get(G.piles, f)))
do local __v278 = p; local __v279 = "cash"; local __v280 = (__get(__v278, __v279) - __S1.TAKE); __set(__v278, __v279, __v280) end
__S1.acc(p, "ing", (__S1.TAKE))
__S1.acc(p, "pileN", (1))
do local __v281 = p.hand; local __v282 = f; local __v283 = __add(__get(__v281, __v282), n); __set(__v281, __v282, __v283) end
if __t(__S1.PILE1) then
__call(__get(G.piles, f), "pop")
else
do local __v284 = G.piles; local __v285 = f; local __v286 = __mkA({__n=0}); __set(__v284, __v285, __v286) end
end
do __S1.ops = __num(__S1.ops) + 1 end
if __t(__S1.TRACE) then
__call((function() local __v288 = G; local __v289 = "clog2"; local __v287 = (__T(G.clog2) or __mkA({__n=0})); __set(__v288, __v289, __v287) return __v287 end)(), "push", (__mkO({["pi"]=G.turn, ["r"]=G.round, ["n"]=n, ["how"]="take", ["cash"]=__S1.TAKE}, {"pi", "r", "n", "how", "cash"})))
end
do local __v290 = G; local __v291 = "st"; local __v292 = (__T(G.st) or __mkO({}, {})); __set(__v290, __v291, __v292) end
do local __v293 = G.st; local __v294 = "taken"; local __v295 = __add((__T(G.st.taken) or 0), 1); __set(__v293, __v294, __v295) end
do local __v296 = G.st; local __v297 = "pileCards"; local __v298 = __add((__T(G.st.pileCards) or 0), n); __set(__v296, __v297, __v298) end
__S1.fx(G, (__mkO({["k"]="ing", ["f"]=f, ["n"]=n, ["from"]=__add("pile-", f), ["to"]=__add(__add(__add("hand-", G.turn), "-"), f)}, {"k", "f", "n", "from", "to"})))
__S1.log(G, G.turn, (__t(__S1.PILE1) and (__str(p.name) .. " buys a " .. __str(__call(__get(__S1.FNAME, f), "toLowerCase")) .. " card off the counter.") or (__str(p.name) .. " takes all " .. __str(n) .. " " .. __str(__call(__get(__S1.FNAME, f), "toLowerCase")) .. " card" .. __str((__gt(n, 1) and "s" or "")) .. " on the counter.")), ("news"))
__S1.next((G))
do return (true) end
end
__S1.spend = function(G, p, fams, to)  
if __t(__S1.TRACE) then
__call((function() local __v300 = G; local __v301 = "slog"; local __v299 = (__T(G.slog) or __mkA({__n=0})); __set(__v300, __v301, __v299) return __v299 end)(), "push", (__mkO({["pi"]=__call(G.players, "indexOf", (p)), ["r"]=G.round, ["n"]=__len(fams), ["to"]=(__t(__call(JS_String((to)), "startsWith", ("mach"))) and "mach" or "research")}, {"pi", "r", "n", "to"})))
end
for _, __v302 in __forof(fams) do
local f
f = __v302; 
do local __v304 = p.hand; local __v305 = f; __set(__v304, __v305, __num((function() local __v304 = p.hand; local __v305 = f; return __get(__v304, __v305) end)()) - 1) end
__call(G.disc, "push", (__mkO({["f"]=f, ["n"]=__get(__get(__S1.FLAVOR, f), 0)}, {"f", "n"})))
__S1.fx(G, (__mkO({["k"]="ing", ["f"]=f, ["n"]=1, ["from"]=__add(__add(__add("hand-", __S1.PI(G, (p))), "-"), f), ["to"]=(__T(to) or "disc"), ["gone"]=true}, {"k", "f", "n", "from", "to", "gone"})))

end
end
__S1.fuel = function(p, inp)  local h, use
h = __spreadO({{s=p.hand}})
use = __mkA({__n=0})
for _, __v306 in __forof(inp) do
local f
f = __v306; 
if (f ~= "any") then
if __lt(__get(h, f), 1) then
do return (nil) end
end
do local __v308 = h; local __v309 = f; __set(__v308, __v309, __num((function() local __v308 = h; local __v309 = f; return __get(__v308, __v309) end)()) - 1) end
__call(use, "push", (f))
end

end
for _, __v310 in __forof(inp) do
local f
f = __v310; 
if (f == "any") then
local g
g = __get(__call(__call(__S1.FAMS, "slice"), "sort", (function(a, b)  
do return (__get(h, b) - __get(h, a)) end
end)), 0)
if (not __t(__get(h, g))) then
do return (nil) end
end
do local __v312 = h; local __v313 = g; __set(__v312, __v313, __num((function() local __v312 = h; local __v313 = g; return __get(__v312, __v313) end)()) - 1) end
__call(use, "push", (g))
end

end
do return (use) end
end
__S1.canRun = function(G, i, hal)  local p, m
p = __S1.P((G))
m = __get(p.mach, i)
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if (not __t(m)) then
do return (__S1.no(("No machine"))) end
end
if (hal == "rerun") then
if (not __t(p.rerun)) then do return (__S1.no(("No re-run"))) end else if (not __t(m.ran)) then do return (__S1.no(("Has not run yet"))) end else if __t(__S1.fuel(p, (m.inp))) then do return (__S1.yes()) end else do return (__S1.no(("Missing ingredients"))) end end end end
end
if (__t(m.ran) and (not (__t(__S1.hasA(p, ("grad"))) and (not __t(p.g2))))) then
do return (__S1.no(("Already ran this round"))) end
end
if (hal == "free") then
if (not __t(p.free)) then do return (__S1.no(("No free run"))) end else if (not __t(__len(m.inp))) then do return (__S1.no(("Needs no cards anyway"))) end else do return (__S1.yes()) end end end
end
if __t(hal) then
if (not __t(__S1.hasA(p, ("hal")))) then do return (__S1.no(("No HAL"))) end else if __t(p.halUsed) then do return (__S1.no(("HAL has run once this round"))) end else if (not __t(__len(m.inp))) then do return (__S1.no(("Needs no cards anyway"))) end else do return (__S1.yes()) end end end end
end
if __t(__S1.fuel(p, (m.inp))) then do return (__S1.yes()) end else do return (__S1.no(("Missing ingredients"))) end end
end
__S1.run = function(G, i, use, hal)  local x, p, m, out, xs
x = __S1.canRun(G, i, (hal))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
m = __get(p.mach, i)
if (hal == "rerun") then
do local __v314 = p; __set(__v314, "rerun", __num((function() local __v314 = p; return __v314.rerun end)()) - 1) end
elseif __t(m.ran) then
do local __v315 = p; local __v316 = "g2"; local __v317 = true; __set(__v315, __v316, __v317) end
end
if (hal == true) then out = JS_Math.max(1, ((m.out - 2))) else out = m.out end
if (hal == true) then
do local __v318 = p; local __v319 = "halUsed"; local __v320 = true; __set(__v318, __v319, __v320) end
elseif (hal == "free") then
do local __v321 = p; __set(__v321, "free", __num((function() local __v321 = p; return __v321.free end)()) - 1) end
else
__S1.spend(G, p, (__T(use) or __S1.fuel(p, (m.inp))), (__add(__add(__add("mach-", G.turn), "-"), i)))
end
do local __v322 = m; local __v323 = "ran"; local __v324 = true; __set(__v322, __v323, __v324) end
do __S1.ops = __num(__S1.ops) + 1 end
do local __v325 = m; local __v326 = "runs"; local __v327 = __add((__T(m.runs) or 0), 1); __set(__v325, __v326, __v327) end
do local __v328 = m; local __v329 = "pit"; local __v330 = __add((__T(m.pit) or 0), out); __set(__v328, __v329, __v330) end
if ((hal ~= true) and (hal ~= "free")) then
do local __v331 = m; local __v332 = "cards"; local __v333 = __add((__T(m.cards) or 0), __len(m.inp)); __set(__v331, __v332, __v333) end
__S1.acc(p, "runCards", (__len(m.inp)))
end
__S1.acc(p, "runs", (1))
__S1.acc(p, "runPit", (out))
do local __v334 = m; local __v335 = "how"; local __v336 = (__T(m.how) or __mkO({}, {})); __set(__v334, __v335, __v336) end
do local __v337 = m.how; local __v338 = ((hal == true) and "hal" or (__T(hal) or "paid")); local __v339 = __add((__T(__get(m.how, ((hal == true) and "hal" or (__T(hal) or "paid")))) or 0), 1); __set(__v337, __v338, __v339) end
__S1.fx(G, (__mkO({["k"]="pit", ["n"]=out, ["from"]=__add(__add(__add("mach-", G.turn), "-"), i), ["to"]=__add("prog-", G.turn)}, {"k", "n", "from", "to"})))
__S1.pour(G, G.turn, out, (((hal == true) and "hal" or (__T(hal) or "mach"))))
if __t(m.xtra.cash) then
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=m.xtra.cash, ["from"]=__add(__add(__add("mach-", G.turn), "-"), i), ["to"]=__add("cash-", G.turn)}, {"k", "n", "from", "to"})))
end
xs = m.xtra
if __t(xs.cash) then
do local __v340 = p; local __v341 = "cash"; local __v342 = __add(__get(__v340, __v341), xs.cash); __set(__v340, __v341, __v342) end
end
if __t(xs.card) then
__S1.drawFree(G, p, (xs.card))
end
if __t(xs.inf) then
__S1.drawInf(G, G.turn, (xs.inf))
end
if __t(xs.heat) then
__S1.expose(G, G.turn, (xs.heat))
end
__S1.log(G, G.turn, (__str(((hal == true) and "HAL 8000 runs" or ((hal == "free") and (__str(p.name) .. " takes a free run on") or ((hal == "rerun") and (__str(p.name) .. " re-runs") or (__str(p.name) .. " runs"))))) .. " the " .. __str(__call(m.name, "toLowerCase")) .. ": " .. __str(out) .. " pitchers."), ("up"))
__S1.next((G))
do return (true) end
end
__S1.pour = function(G, pi, n, src)  local p
p = __get(G.players, pi)
if (__t(__S1.TRACE) and __t(n)) then
__call((function() local __v344 = G; local __v345 = "plog"; local __v343 = (__T(G.plog) or __mkA({__n=0})); __set(__v344, __v345, __v343) return __v343 end)(), "push", (__mkO({["pi"]=pi, ["r"]=G.round, ["n"]=n, ["src"]=(__T(src) or "other")}, {"pi", "r", "n", "src"})))
end
do local __v346 = p; local __v347 = "prog"; local __v348 = __add(__get(__v346, __v347), n); __set(__v346, __v347, __v348) end
do __S1.ops = __num(__S1.ops) + 1 end
do 
while (__ge(p.prog, __S1.trackLen((p))) and (not (__t(__S1.ONE) and (p.upAt == G.round)))) do
do local __v350 = p; local __v351 = "prog"; local __v352 = (__get(__v350, __v351) - __S1.trackLen((p))); __set(__v350, __v351, __v352) end
do __S1.ops = __num(__S1.ops) + 1 end
if __lt(p.era, __S1.ERAS) then
local aloneBefore, was, MM, ctl, mtop, mapLead, eraLead, get
aloneBefore = (not __t(__call(G.players, "some", (function(q, j)  
do return ((j ~= pi) and __ge(q.era, p.era)) end
end))))
was = __S1.bandOf((p.era))
do local __v353 = p; __set(__v353, "era", __num((function() local __v353 = p; return __v353.era end)()) + 1) end
do local __v354 = p; local __v355 = "upAt"; local __v356 = G.round; __set(__v354, __v355, __v356) end
__S1.fx(G, (__mkO({["k"]="era", ["pi"]=pi}, {"k", "pi"})))
MM = (__T(__S1.ENV.MEMOMODE) or "era")
ctl = __call(G.players, "map", (function(_, j)  
do return __S1.controlled(G, (j)) end
end))
mtop = JS_Math.max(__unpack(__spreadA({{s=ctl}})))
mapLead = ((__get(ctl, pi) == mtop) and (__len(__call(ctl, "filter", (function(x)  
do return (x == mtop) end
end))) == 1))
eraLead = aloneBefore
if (MM == "all") then get = true else get = (function() if (MM == "none") then return false end return (function() if (MM == "map") then return (not __t(mapLead)) end return (not __t(eraLead)) end)() end)() end
if __t(__S1.TRACE) then
__call((function() local __v358 = G; local __v359 = "mlog"; local __v357 = (__T(G.mlog) or __mkA({__n=0})); __set(__v358, __v359, __v357) return __v357 end)(), "push", (__mkO({["pi"]=pi, ["r"]=G.round, ["era"]=p.era, ["got"]=(function() local __v360 = get; if __t(__v360) then return __lt(G.memoAt, __len(__S1.MEMOS)) end return __v360 end)(), ["eraLead"]=eraLead, ["mapLead"]=mapLead, ["ctl"]=__call(ctl, "slice"), ["id"]=G.memoAt}, {"pi", "r", "era", "got", "eraLead", "mapLead", "ctl", "id"})))
end
if (__t(get) and __lt(G.memoAt, __len(__S1.MEMOS))) then
__call(G.memoQ, "push", (__mkO({["pi"]=pi, ["id"]=(function() local __v362 = __num((function() local __v361 = G; return __v361.memoAt end)()); local __v361 = G; __set(__v361, "memoAt", __v362 + 1) return __v362 end)()}, {"pi", "id"})))
elseif (((MM == "burn") and __t(eraLead)) and __lt(G.memoAt, __len(__S1.MEMOS))) then
do local __v363 = G; __set(__v363, "memoAt", __num((function() local __v363 = G; return __v363.memoAt end)()) + 1) end
end
__S1.log(G, pi, (__gt(__S1.bandOf((p.era)), was) and (__str(__S1.co(G, (pi))) .. " enters era " .. __str(p.era) .. ". It is now a " .. __str((__get(__S1.BANDS, __S1.bandOf((p.era)))).name) .. ".") or (__str(__S1.co(G, (pi))) .. " enters era " .. __str(p.era) .. ".")), ((__gt(__S1.bandOf((p.era)), was) and "win" or "up")))
if __t(__S1.TRACE) then
__call((function() local __v365 = G; local __v366 = "elog"; local __v364 = (__T(G.elog) or __mkA({__n=0})); __set(__v365, __v366, __v364) return __v364 end)(), "push", (__mkO({["pi"]=pi, ["era"]=p.era, ["r"]=G.round}, {"pi", "era", "r"})))
end
if (((__S1.WIN == "era") and __ge(p.era, __S1.ERAS)) and (G.winner == nil)) then
do local __v367 = G; local __v368 = "memoQ"; local __v369 = __mkA({__n=0}); __set(__v367, __v368, __v369) end
do local __v370 = G; local __v371 = "choice"; local __v372 = nil; __set(__v370, __v371, __v372) end
do local __v373 = G; local __v374 = "pending"; local __v375 = nil; __set(__v373, __v374, __v375) end
do return (__S1.finish(G, (__mkA({[0]=(pi), __n=1})))) end
end
else
do local __v376 = p; local __v377 = "loy"; local __v378 = __add(__get(__v376, __v377), __S1.OVER); __set(__v376, __v377, __v378) end
__S1.lt(G, pi, "era", (__S1.OVER))
__S1.fx(G, (__mkO({["k"]="heart", ["n"]=__S1.OVER, ["from"]=__add("prog-", pi), ["to"]=__add("loy-", pi)}, {"k", "n", "from", "to"})))
__S1.log(G, pi, (__str(__S1.co(G, (pi))) .. " fills the track again: " .. __str(__S1.OVER) .. " loyalty."), ("up"))
end

end end
end
__S1.drawFree = function(G, p, n)  
do
local k
k = 0

while __lt(k, n) do
local c
if (not __t(__len(G.deck))) then
do local __v380 = G; local __v381 = "deck"; local __v382 = __S1.shuffle((G.disc)); __set(__v380, __v381, __v382) end
do local __v383 = G; local __v384 = "disc"; local __v385 = __mkA({__n=0}); __set(__v383, __v384, __v385) end
end
c = __call(G.deck, "pop")
if __t(c) then
do local __v386 = p.hand; local __v387 = c.f; __set(__v386, __v387, __num((function() local __v386 = p.hand; local __v387 = c.f; return __get(__v386, __v387) end)()) + 1) end
__S1.fx(G, (__mkO({["k"]="ing", ["f"]=c.f, ["n"]=1, ["from"]="ingdeck", ["to"]=__add(__add(__add("hand-", __S1.PI(G, (p))), "-"), c.f)}, {"k", "f", "n", "from", "to"})))
end

do k = __num(k) + 1 end
end
end
do __S1.ops = __num(__S1.ops) + 1 end
end
__S1.canBuy = function(G, i)  local p, m
p = __S1.P((G))
m = __get(G.mkt, i)
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if (not __t(m)) then do return (__S1.no(("No machine"))) end else if __lt(p.cash, m.price) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=m.price}, {"cash"})))) end end end
end
__S1.buy = function(G, i, scrap)  local x, p, m, gone, slot, had
x = __S1.canBuy(G, (i))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
if (__ge(__S1.used((p)), __S1.SLOTS) and (not __t(__S1.canVacate(p, (scrap))))) then
do return (false) end
end
m = __get(__call(G.mkt, "splice", i, (1)), 0)
do local __v388 = p; local __v389 = "cash"; local __v390 = (__get(__v388, __v389) - m.price); __set(__v388, __v389, __v390) end
__S1.acc(p, "mach", (m.price))
__S1.acc(p, "machN", (1))
gone = ""
slot = __len(p.mach)
if (__ge(__S1.used((p)), __S1.SLOTS) and (__typeof(scrap) == "number")) then
local old
old = __get(p.mach, scrap)
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=old.name, ["tier"]=old.tier}, {"name", "tier"}), ["from"]=__add(__add(__add("mach-", G.turn), "-"), scrap), ["to"]="mdeck", ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
__call((function() local __v392 = G; local __v393 = "mdead"; local __v391 = (__T(G.mdead) or __mkA({__n=0})); __set(__v392, __v393, __v391) return __v391 end)(), "push", (__spreadO({{s=old}, {k="gone", v=G.round}, {k="pi", v=G.turn}})))
__call((function() local __v395 = p; local __v396 = "shelf"; local __v394 = (__T(p.shelf) or __mkA({__n=0})); __set(__v395, __v396, __v394) return __v394 end)(), "push", (__mkO({["id"]=old.id, ["name"]=old.name, ["tier"]=old.tier, ["inp"]=__call(old.inp, "slice")}, {"id", "name", "tier", "inp"})))
do local __v397 = p.mach; local __v398 = scrap; local __v399 = __spreadO({{s=m}, {k="ran", v=false}, {k="at", v=G.round}, {k="runs", v=0}, {k="pit", v=0}, {k="cards", v=0}}); __set(__v397, __v398, __v399) end
do slot = scrap end
do gone = (" It scraps the " .. __str(__call(old.name, "toLowerCase")) .. ".") end
else
if __ge(__S1.used((p)), __S1.SLOTS) then
do gone = __S1.vacate(G, G.turn, (scrap)) end
end
do slot = __len(p.mach) end
__call(p.mach, "push", (__spreadO({{s=m}, {k="ran", v=false}, {k="at", v=G.round}, {k="runs", v=0}, {k="pit", v=0}, {k="cards", v=0}})))
end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=m.name, ["tier"]=m.tier}, {"name", "tier"}), ["from"]=__add("mkt-", i), ["to"]=__add(__add(__add("mach-", G.turn), "-"), slot)}, {"k", "m", "from", "to"})))
had = __call(G.mkt, "slice")
__S1.refillM((G))
do __S1.ops = __num(__S1.ops) + 1 end
__call(G.mkt, "forEach", (function(x, k)  
if (not __t(__call(had, "includes", (x)))) then
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=x.name, ["tier"]=x.tier}, {"name", "tier"}), ["from"]="mdeck", ["to"]=__add("mkt-", k), ["slide"]=true}, {"k", "m", "from", "to", "slide"})))
end
end))
__S1.log(G, G.turn, (__str(p.name) .. " installs a " .. __str(__call(m.name, "toLowerCase")) .. "." .. __str(gone)), ("up"))
__S1.next((G))
do return (true) end
end
__S1.hook = function(G, pi, a)  
if (a.id == "becky") then
local h
h = __S1.homeOf(G, (pi))
if __t(h) then
do local __v400 = h; local __v401 = "becky"; local __v402 = pi; __set(__v400, __v401, __v402) end
end
end
end
__S1.unhook = function(G, pi, a)  
if (a.id == "becky") then
local h
h = __S1.homeOf(G, (pi))
if __t(h) then
rawset(h, "becky", nil)
end
end
end
__S1.vacate = function(G, pi, s)  local p, old
p = __get(G.players, pi)
if (__typeof(s) == "string") then
local k, a
k = __num(__call(s, "slice", (1)))
a = __get(__call(p.adv, "splice", k, (1)), 0)
__S1.unhook(G, pi, (a))
__S1.boardAdvisor(G, (a))
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=a.name, ["tier"]=0}, {"name", "tier"}), ["from"]=__add(__add(__add("adv-", pi), "-"), k), ["to"]="adeck", ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
do return ((" " .. __str(a.name) .. " is let go.")) end
end
old = __get(__call(p.mach, "splice", s, (1)), 0)
__call((function() local __v404 = G; local __v405 = "mdead"; local __v403 = (__T(G.mdead) or __mkA({__n=0})); __set(__v404, __v405, __v403) return __v403 end)(), "push", (__spreadO({{s=old}, {k="gone", v=G.round}, {k="pi", v=pi}})))
__call((function() local __v407 = p; local __v408 = "shelf"; local __v406 = (__T(p.shelf) or __mkA({__n=0})); __set(__v407, __v408, __v406) return __v406 end)(), "push", (__mkO({["id"]=old.id, ["name"]=old.name, ["tier"]=old.tier, ["inp"]=__call(old.inp, "slice")}, {"id", "name", "tier", "inp"})))
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=old.name, ["tier"]=old.tier}, {"name", "tier"}), ["from"]=__add(__add(__add("mach-", pi), "-"), s), ["to"]="mdeck", ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
do return ((" It scraps the " .. __str(__call(old.name, "toLowerCase")) .. ".")) end
end
__S1.canScrap = function(G, i)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if __t(__get(p.mach, i)) then do return (__S1.yes()) end else do return (__S1.no(("No such machine"))) end end
end
__S1.scrapM = function(G, i)  local p, m
if (not __t((__S1.canScrap(G, (i))).ok)) then
do return (false) end
end
p = __S1.P((G))
m = __get(p.mach, i)
__S1.vacate(G, G.turn, (i))
__S1.acc(p, "scrapN", (1))
__S1.log(G, G.turn, (__str(p.name) .. " scraps its " .. __str(__call(m.name, "toLowerCase")) .. " and keeps what it learned."), ("news"))
do __S1.ops = __num(__S1.ops) + 1 end
do return (true) end
end
__S1.canHire = function(G, k, from)  local p, a, cost
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if (from == nil) then a = __get(G.arow, k) else a = (function() local __v409 = __get(G.players, from); if __t(__v409) then return __get((__get(G.players, from)).adv, k) end return __v409 end)() end
if (not __t(a)) then
do return (__S1.no(("Nobody there"))) end
end
if (from == G.turn) then
do return (__S1.no(("Already yours"))) end
end
if __lt(p.era, a.era) then
do return (__S1.no((("Needs era " .. __str(a.era))))) end
end
cost = __add(a.price, ((from == nil) and 0 or __S1.POACH))
if __lt((__T(p.cont) or 0), (__T(a.cc) or 0)) then
do return (__S1.no((("Needs " .. __str(a.cc) .. " control")))) end
end
if __lt(p.cash, cost) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=cost, ["cont"]=(__T(a.cc) or 0)}, {"cash", "cont"})))) end end
end
__S1.hire = function(G, k, from, scrap)  local x, p, pi, a, src, gone
x = __S1.canHire(G, k, (from))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
pi = G.turn
if (__ge(__S1.used((p)), __S1.SLOTS) and (not __t(__S1.canVacate(p, (scrap))))) then
do return (false) end
end
a = nil
src = __add("arow-", k)
if (from == nil) then
do a = __get(__call(G.arow, "splice", k, (1)), 0) end
else
local q
q = __get(G.players, from)
do a = __get(__call(q.adv, "splice", k, (1)), 0) end
__S1.unhook(G, from, (a))
do local __v410 = q; local __v411 = "cash"; local __v412 = __add(__get(__v410, __v411), __S1.POACH); __set(__v410, __v411, __v412) end
do src = __add(__add(__add("adv-", from), "-"), k) end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=__S1.POACH, ["from"]=__add("cash-", pi), ["to"]=__add("cash-", from)}, {"k", "n", "from", "to"})))
end
do local __v413 = p; local __v414 = "cash"; local __v415 = (__get(__v413, __v414) - x.cost.cash); __set(__v413, __v414, __v415) end
__S1.acc(p, "adv", (x.cost.cash))
__S1.acc(p, "advN", (1))
do local __v416 = p; local __v417 = "cont"; local __v418 = (__get(__v416, __v417) - (__T(a.cc) or 0)); __set(__v416, __v417, __v418) end
if __ge(__S1.used((p)), __S1.SLOTS) then gone = __S1.vacate(G, pi, (scrap)) else gone = "" end
__call(p.adv, "push", (a))
__S1.hook(G, pi, (a))
do __S1.ops = __add(__S1.ops, 2) end
if not __t(__call((function() local __v420 = p; local __v421 = "ever"; local __v419 = (__T(p.ever) or __mkA({__n=0})); __set(__v420, __v421, __v419) return __v419 end)(), "includes", (a.id))) then __call(p.ever, "push", (a.id)) end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=a.name, ["tier"]=0}, {"name", "tier"}), ["from"]=src, ["to"]=__add(__add(__add("adv-", pi), "-"), (__len(p.adv) - 1))}, {"k", "m", "from", "to"})))
do local __v422 = G; local __v423 = "st"; local __v424 = (__T(G.st) or __mkO({}, {})); __set(__v422, __v423, __v424) end
do local __v425 = G.st; local __v426 = ((from == nil) and "hires" or "poach"); local __v427 = __add((__T(__get(G.st, ((from == nil) and "hires" or "poach"))) or 0), 1); __set(__v425, __v426, __v427) end
__S1.log(G, pi, ((from == nil) and (__str(p.name) .. " retains " .. __str(a.name) .. " as " .. __str(a.role) .. ". (" .. __str(a.who) .. ")" .. __str(gone)) or (__str(p.name) .. " hires " .. __str(a.name) .. " away from " .. __str((__get(G.players, from)).name) .. "." .. __str(gone))), ("up"))
__S1.next((G))
do return (true) end
end
__S1.canHit = function(G, ti, k)  local p, q
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if (not __t(__S1.hasA(p, ("boogey")))) then
do return (__S1.no(("No Boogeyman"))) end
end
if (p.hitR == G.round) then
do return (__S1.no(("Once a round"))) end
end
q = __get(G.players, ti)
if ((ti == G.turn) or (not __t(q))) then do return (__S1.no(("Choose a rival"))) end else if (not __t(__get(q.adv, k))) then do return (__S1.no(("Nobody there"))) end else do return (__S1.yes()) end end end
end
__S1.hit = function(G, ti, k)  local p, q, a
if (not __t((__S1.canHit(G, ti, (k))).ok)) then
do return (false) end
end
p = __S1.P((G))
q = __get(G.players, ti)
a = __get(__call(q.adv, "splice", k, (1)), 0)
__S1.unhook(G, ti, (a))
do local __v428 = p; local __v429 = "hitR"; local __v430 = G.round; __set(__v428, __v429, __v430) end
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=a.name, ["tier"]=0}, {"name", "tier"}), ["from"]=__add(__add(__add("adv-", ti), "-"), k), ["to"]=__add("seat-", G.turn), ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
do local __v431 = G; local __v432 = "st"; local __v433 = (__T(G.st) or __mkO({}, {})); __set(__v431, __v432, __v433) end
do local __v434 = G.st; local __v435 = "hits"; local __v436 = __add((__T(G.st.hits) or 0), 1); __set(__v434, __v435, __v436) end
__S1.log(G, G.turn, (__str(q.name) .. "'s " .. __str(__call(a.role, "toLowerCase")) .. ", " .. __str(a.name) .. ", is never seen again."), ("dirty"))
__S1.expose(G, G.turn, (1))
__S1.next((G))
do return (true) end
end
__S1.canSell = function(G)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then do return (__S1.no((__S1.myTurn(G, ("biz"))))) end else if (not __t(__S1.hasA(p, ("paul")))) then do return (__S1.no(("No Paul"))) end else if (p.soldR == G.round) then do return (__S1.no(("Once a market"))) end else if (not __t(p.hand.sour)) then do return (__S1.no(("No Acidic cards"))) end else do return (__S1.yes()) end end end end end
end
__S1.sell = function(G, n)  local p
if (not __t((__S1.canSell((G))).ok)) then
do return (false) end
end
p = __S1.P((G))
do n = JS_Math.max(1, (JS_Math.min((__T(n) or 1), 2, (p.hand.sour)))) end
do local __v437 = p; local __v438 = "soldR"; local __v439 = G.round; __set(__v437, __v438, __v439) end
do
local k
k = 0

while __lt(k, n) do
do local __v441 = p.hand; __set(__v441, "sour", __num((function() local __v441 = p.hand; return __v441.sour end)()) - 1) end
__call(G.disc, "push", (__mkO({["f"]="sour", ["n"]="Lemon"}, {"f", "n"})))

do k = __num(k) + 1 end
end
end
do local __v442 = p; local __v443 = "cash"; local __v444 = __add(__get(__v442, __v443), (2 * n)); __set(__v442, __v443, __v444) end
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=(2 * n), ["from"]=__add(__add("hand-", G.turn), "-sour"), ["to"]=__add("cash-", G.turn)}, {"k", "n", "from", "to"})))
__S1.log(G, G.turn, (__str(p.name) .. " sells Paul " .. __str(n) .. " Acidic card" .. __str((__gt(n, 1) and "s" or "")) .. ". He pays " .. __str((2 * n)) .. " Capital and calls it human money."), ("news"))
do return (true) end
end
__S1.condOK = function(G, p, cond)  local pi, home
pi = __call(G.players, "indexOf", (p))
home = __S1.homeOf(G, (pi))
if (cond == "home5") then
do return (((not (not __t(home))) and __ge((__T(__get(home.tok, pi)) or 0), __S1.HOMEN))) end
end
if (cond == "small5") then
do return (__lt(__S1.controlled(G, (pi)), __S1.SMALLN)) end
end
if (cond == "deep3") then
do return (__ge(__len(__call(G.map.cells, "filter", (function(c)  
do return __ge((__T(__get(c.tok, pi)) or 0), __S1.DEEPT) end
end))), __S1.DEEPK)) end
end
if (cond == "nohot") then
do return ((not __t(__call(G.map.cells, "some", (function(c)  
do return (function() local __v445 = c.hot; if __t(__v445) then return (__S1.ownerOf((c)) == pi) end return __v445 end)() end
end))))) end
end
if (cond == "noadv") then
do return ((not __t(__len(p.adv)))) end
end
do return (false) end
end
__S1.needFor = function(G, p, card)  local sh, need
sh = __S1.shelfOf((p))
need = __mkO({["short"]=__mkO({}, {}), ["shortN"]=0, ["any"]=0, ["ram"]=0}, {"short", "shortN", "any", "ram"})
for _, __v446 in __forof(__S1.FAMS) do
local f
f = __v446; 
local x
x = JS_Math.max(0, (((__T(__get(card.cost, f)) or 0) - __get(sh, f))))
do local __v448 = need.short; local __v449 = f; local __v450 = x; __set(__v448, __v449, __v450) end
do local __v451 = need; local __v452 = "shortN"; local __v453 = __add(__get(__v451, __v452), x); __set(__v451, __v452, __v453) end

end
do local __v454 = need; local __v455 = "any"; local __v456 = JS_Math.max(0, ((((__T(card.cost.any) or 0) - sh.any) - (__t(__S1.hasA(p, ("liz"))) and 1 or 0)))); __set(__v454, __v455, __v456) end
do local __v457 = need; local __v458 = "ram"; local __v459 = JS_Math.min(need.shortN, ((__t(__S1.hasA(p, ("raman"))) and 2 or 0))); __set(__v457, __v458, __v459) end
do return (need) end
end
__S1.payFor = function(G, p, card, patent)  local n, short, cards, wild, h, use
n = __S1.needFor(G, p, (card))
short = (n.shortN - n.ram)
cards = __add(n.any, n.ram)
wild = (__t(patent) and 1 or 0)
if __gt(short, wild) then
do return (nil) end
end
do wild = (wild - short) end
if (__gt(wild, 0) and __gt(cards, 0)) then
do cards = __num(cards) - 1 end
do wild = __num(wild) - 1 end
end
h = __spreadO({{s=p.hand}})
use = __mkA({__n=0})
do
local k
k = 0

while __lt(k, cards) do
local g
g = __get(__call(__call(__S1.FAMS, "slice"), "sort", (function(a, b)  
do return (__get(h, b) - __get(h, a)) end
end)), 0)
if __gt(__get(h, g), 0) then
do local __v461 = h; local __v462 = g; __set(__v461, __v462, __num((function() local __v461 = h; local __v462 = g; return __get(__v461, __v462) end)()) - 1) end
__call(use, "push", (g))
else
do return (nil) end
end

do k = __num(k) + 1 end
end
end
do return (use) end
end
__S1.canResearch = function(G, k, patent)  local p, c
p = __S1.P((G))
c = __get(G.rrow, k)
if __t(__S1.myTurn(G, ("biz"))) then
do return (__S1.no((__S1.myTurn(G, ("biz"))))) end
end
if __t(p.jail) then
do return (__S1.no(("In custody"))) end
end
if (not __t(c)) then
do return (__S1.no(("No card there"))) end
end
if (__t(c.win) and __lt(__S1.resCards((p)), __S1.WINNEED)) then
do return (__S1.no((("Needs " .. __str(__S1.WINNEED) .. " research cards in hand")))) end
end
if __t(__S1.payFor(G, p, c, (patent))) then do return (__S1.yes()) end else do return (__S1.no(("Not enough ingredients"))) end end
end
__S1.research = function(G, k, patent)  local x, p, pi, t, st, extra
x = __S1.canResearch(G, k, (patent))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
pi = G.turn
t = __get(G.rrow, k)
do
local pay
pay = __S1.payFor(G, p, t, (patent))
__S1.acc(p, "resCards", (__len(pay)))
__S1.acc(p, "resN", (1))
__S1.acc(p, "resStars", ((__T(t.st) or 0)))
__S1.spend(G, p, pay, (__add("rcard-", k)))
end
__call(G.rrow, "splice", k, (1))
__call(G.rrow, "push", (nil))
do __S1.ops = __add(__S1.ops, 2) end
if __t(t.st) then
__S1.fx(G, (__mkO({["k"]="star", ["n"]=t.st, ["from"]=__add("rcard-", k), ["to"]=__add("stars-", pi)}, {"k", "n", "from", "to"})))
end
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=t.name, ["tier"]=t.tier}, {"name", "tier"}), ["from"]=__add("rcard-", k), ["to"]=__add("tiles-", pi)}, {"k", "m", "from", "to"})))
__call((function() local __v464 = p; local __v465 = "tiles"; local __v463 = (__T(p.tiles) or __mkA({__n=0})); __set(__v464, __v465, __v463) return __v463 end)(), "push", (__spreadO({{s=t}, {k="cost", v=__spreadO({{s=t.cost}})}, {k="get", v=__spreadO({{s=t.get}})}, {k="r", v=G.round}, {k="copied", v=false}})))
do local __v466 = G; local __v467 = "st"; local __v468 = (__T(G.st) or __mkO({}, {})); __set(__v466, __v467, __v468) end
do local __v469 = G.st; local __v470 = "researched"; local __v471 = __add((__T(G.st.researched) or 0), 1); __set(__v469, __v470, __v471) end
if __t(t.win) then
__S1.log(G, pi, (__str(p.name) .. " completes the Secret Formula. Nobody will ever make lemonade without them again."), ("win"))
do local __v472 = G; local __v473 = "memoQ"; local __v474 = __mkA({__n=0}); __set(__v472, __v473, __v474) end
do local __v475 = G; local __v476 = "choice"; local __v477 = nil; __set(__v475, __v476, __v477) end
do local __v478 = G; local __v479 = "pending"; local __v480 = nil; __set(__v478, __v479, __v480) end
__S1.finish(G, (__mkA({[0]=(pi), __n=1})))
do return (true) end
end
st = t.st
extra = 0
do 
while (__gt(st, 0) and __lt(p.stars, __S1.MAXSTAR)) do
do local __v482 = p; __set(__v482, "stars", __num((function() local __v482 = p; return __v482.stars end)()) + 1) end
do st = __num(st) - 1 end

end end
do extra = st end
__S1.give(G, pi, t.get, ("tile"))
if __t(extra) then
do local __v483 = p; local __v484 = "cash"; local __v485 = __add(__get(__v483, __v484), (extra * __S1.STARCASH)); __set(__v483, __v484, __v485) end
end
if (__t(__S1.IMPON) and (not __t(t.win))) then
local n
n = (__T(__get(__S1.IMPR, (t.tier - 1))) or 0)
if __t(n) then
do local __v486 = p; local __v487 = "imp"; local __v488 = __add((__T(p.imp) or 0), n); __set(__v486, __v487, __v488) end
__S1.acc(p, "impGot", (n))
end
end
if __t(t.st) then
__S1.pour(G, pi, (0))
end
if (__t(__S1.hasA(p, ("kevin"))) and __ge(t.st, 2)) then
do local __v489 = p; local __v490 = "loy"; local __v491 = __add(__get(__v489, __v490), 2); __set(__v489, __v490, __v491) end
__S1.lt(G, pi, "adv", (2))
__S1.fx(G, (__mkO({["k"]="heart", ["n"]=2, ["from"]=__add("stars-", pi), ["to"]=__add("loy-", pi)}, {"k", "n", "from", "to"})))
end
if __t(__S1.hasA(p, ("liz"))) then
__S1.log(G, pi, "Elizabeth H. announces the results before running the test.", ("dirty"))
__S1.expose(G, pi, (2))
end
__S1.log(G, pi, (__t(t.bonus) and (__str(p.name) .. " researches " .. __str(__call(t.name, "toLowerCase")) .. ": +" .. __str(t.bonus.n) .. " " .. __str(((t.bonus.f == "any") and "of any family" or __get(__S1.FNAME, t.bonus.f))) .. " for future research while " .. __str(__get(__S1.CONDS, t.bonus.cond)) .. ".") or (__t(t.st) and (__str(p.name) .. "'s formula earns " .. __str(((t.st == 1) and "half a star" or ((t.st == 2) and "a star" or __add((t.st / 2), " stars")))) .. ". It is now a " .. __str(__S1.starText((p.stars))) .. " product, and its era track is " .. __str(__S1.trackLen((p))) .. " long.") or (__str(p.name) .. " researches " .. __str(__call(t.name, "toLowerCase")) .. "."))), ((__t(t.st) and "win" or "news")))
if (G.winner ~= nil) then
do return (true) end
end
if __t(__S1.refillRow(G, (__S1.RROW - 1), (pi))) then
do local __v492 = G.offer; local __v493 = "next"; local __v494 = (not __t(patent)); __set(__v492, __v493, __v494) end
do return (true) end
end
if (not __t(patent)) then
__S1.next((G))
end
do return (true) end
end
__S1.canPlace = function(G, id)  local p, c, k
p = __S1.P((G))
c = __S1.cell(G, (id))
if __t(__S1.myTurn(G, ("place"))) then
do return (__S1.no((__S1.myTurn(G, ("place"))))) end
end
if (not __t(c)) then
do return (__S1.no(("No market"))) end
end
k = __S1.tokCost(G, G.turn, (c))
if __lt(p.loy, k) then do return (__S1.no((("Needs " .. __str(k) .. " loyalty")))) end else do return (__S1.yes((__mkO({["loy"]=k}, {"loy"})))) end end
end
__S1.canImprove = function(G, id)  local p, c
p = __S1.P((G))
c = __S1.cell(G, (id))
if __t(__S1.myTurn(G, ("place"))) then
do return (__S1.no((__S1.myTurn(G, ("place"))))) end
end
if (not __t(__S1.IMPON)) then
do return (__S1.no(("Not in this game"))) end
end
if (not __t(c)) then
do return (__S1.no(("No market"))) end
end
if (not __gt(p.imp, 0)) then
do return (__S1.no(("Research earns capital tokens"))) end
end
if (__S1.ownerOf((c)) ~= G.turn) then
do return (__S1.no(("You must control the market"))) end
end
if __ge((__T(c.imp) or 0), 3) then
do return (__S1.no(("Fully improved"))) end
end
do return (__S1.yes()) end
end
__S1.improve = function(G, id)  local p, c, y
if (not __t((__S1.canImprove(G, (id))).ok)) then
do return (false) end
end
p = __S1.P((G))
c = __S1.cell(G, (id))
y = __get(__S1.yields((c)), (__T(c.imp) or 0))
do local __v495 = c; local __v496 = "imp"; local __v497 = __add((__T(c.imp) or 0), 1); __set(__v495, __v496, __v497) end
do local __v498 = p; __set(__v498, "imp", __num((function() local __v498 = p; return __v498.imp end)()) - 1) end
__S1.acc(p, "impN", (1))
__S1.acc(p, "impY", (y))
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=1, ["from"]=__add("cash-", G.turn), ["to"]=__add("cell-", c.id)}, {"k", "n", "from", "to"})))
__S1.log(G, G.turn, (__str(p.name) .. " invests in " .. __str(c.name) .. ": it now pays " .. __str(__S1.cellYield((c))) .. " Capital at payday to whoever controls it."), ("up"))
__S1.next((G))
do return (true) end
end
__S1.put = function(G, pi, c)  local p, before, empty
p = __get(G.players, pi)
before = __S1.ownerOf((c))
empty = (not __t(__len(JS_Object.keys((c.tok)))))
do local __v499 = c.tok; local __v500 = pi; local __v501 = __add(__S1.toks(c, (pi)), 1); __set(__v499, __v500, __v501) end
do __S1.ops = __num(__S1.ops) + 1 end
if (__t(__S1.hasA(p, ("pioneer"))) and __t(empty)) then
do local __v502 = p; local __v503 = "cash"; local __v504 = __add(__get(__v502, __v503), 1); __set(__v502, __v503, __v504) end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=1, ["from"]=__add("cell-", c.id), ["to"]=__add("cash-", pi)}, {"k", "n", "from", "to"})))
end
if (((__t(__S1.hasA(p, ("raider"))) and (before ~= nil)) and (before ~= pi)) and (__S1.ownerOf((c)) == pi)) then
do local __v505 = p; local __v506 = "cash"; local __v507 = __add(__get(__v505, __v506), 3); __set(__v505, __v506, __v507) end
do local __v508 = G; local __v509 = "st"; local __v510 = (__T(G.st) or __mkO({}, {})); __set(__v508, __v509, __v510) end
do local __v511 = G.st; local __v512 = "raids2"; local __v513 = __add((__T(G.st.raids2) or 0), 1); __set(__v511, __v512, __v513) end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=3, ["from"]=__add("cell-", c.id), ["to"]=__add("cash-", pi)}, {"k", "n", "from", "to"})))
__S1.log(G, pi, (__str(p.name) .. " takes " .. __str(c.name) .. " from " .. __str((__get(G.players, before)).name) .. ". The Raider collects."), ("dirty"))
end
__S1.fx(G, (__mkO({["k"]="tok", ["pi"]=pi, ["n"]=1, ["from"]=__add("loy-", pi), ["to"]=__add("cell-", c.id)}, {"k", "pi", "n", "from", "to"})))
if __t(c.bonus) then
__S1.give(G, pi, c.bonus, ("bonus"))
do local __v514 = c; local __v515 = "bonus"; local __v516 = nil; __set(__v514, __v515, __v516) end
end
end
__S1.place = function(G, id)  local x, p, c, far
x = __S1.canPlace(G, (id))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
c = __S1.cell(G, (id))
far = (function() local __v517 = __S1.hasA(p, ("realtor")); if __t(__v517) then return __ge(__S1.reach(G, G.turn, (c)), 3) end return __v517 end)()
do
local o
o = __S1.ownerOf((c))
__S1.acc(p, (function() if (o == nil) then return (__t(__len(JS_Object.keys((c.tok)))) and "tokContest" or "tokGrow") end return ((o == G.turn) and "tokDef" or "tokAtk") end)(), (1))
__S1.acc(p, "loySpent", (x.cost.loy))
if __t(c.hot) then
__S1.acc(p, "tokHot", (1))
end
if __t(c.rough) then
__S1.acc(p, "tokRough", (1))
end
end
do local __v518 = p; local __v519 = "loy"; local __v520 = (__get(__v518, __v519) - x.cost.loy); __set(__v518, __v519, __v520) end
__S1.put(G, G.turn, (c))
__S1.log(G, G.turn, (__str(p.name) .. " places a token in " .. __str(c.name) .. "."), ("up"))
if __t(far) then
__S1.expose(G, G.turn, (1))
end
__S1.next((G))
do return (true) end
end
__S1.drawInf = function(G, pi, n)  local p
p = __get(G.players, pi)
do
local k
k = 0

while __lt(k, n) do
local c
if (not __t(__len(G.ideck))) then
do local __v522 = G; local __v523 = "ideck"; local __v524 = __S1.shuffle((G.idisc)); __set(__v522, __v523, __v524) end
do local __v525 = G; local __v526 = "idisc"; local __v527 = __mkA({__n=0}); __set(__v525, __v526, __v527) end
end
c = __call(G.ideck, "pop")
if (not __t(c)) then
do return end
end
__call(p.inf, "push", (c))
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="inf", ["from"]="infdeck", ["to"]=__add("inf-", pi)}, {"k", "from", "to"})))
__S1.log(G, pi, (__str(p.name) .. " acquires influence." .. __str((__t(c.x) and (" The Heat rises by " .. __str(c.x) .. ".") or ""))), ("inf"))
__S1.expose(G, pi, (c.x))

do k = __num(k) + 1 end
end
end
end
__S1.expose = function(G, pi, x)  
if (not __t(x)) then
do return end
end
do local __v528 = G; local __v529 = "heat"; local __v530 = __add(__get(__v528, __v529), x); __set(__v528, __v529, __v530) end
do __S1.ops = __num(__S1.ops) + 1 end
__S1.fx(G, (__mkO({["k"]="heat", ["n"]=x, ["from"]=__add("seat-", pi), ["to"]="heat"}, {"k", "n", "from", "to"})))
if __lt(G.heat, __S1.tolerance((G))) then
do return end
end
if __t(__S1.TRACE) then
local ctl, mtop
ctl = __call(G.players, "map", (function(_, j)  
do return __S1.controlled(G, (j)) end
end))
mtop = JS_Math.max(__unpack(__spreadA({{s=ctl}})))
__call((function() local __v532 = G; local __v533 = "rlog"; local __v531 = (__T(G.rlog) or __mkA({__n=0})); __set(__v532, __v533, __v531) return __v531 end)(), "push", (__mkO({["pi"]=pi, ["r"]=G.round, ["mapLead"]=((__get(ctl, pi) == mtop) and (__len(__call(ctl, "filter", (function(x)  
do return (x == mtop) end
end))) == 1))}, {"pi", "r", "mapLead"})))
end
if __t((__get(G.players, pi)).judge) then
do local __v534 = __get(G.players, pi); local __v535 = "judge"; local __v536 = false; __set(__v534, __v535, __v536) end
do local __v537 = G; local __v538 = "heat"; local __v539 = 1; __set(__v537, __v538, __v539) end
do local __v540 = G; local __v541 = "st"; local __v542 = (__T(G.st) or __mkO({}, {})); __set(__v540, __v541, __v542) end
do local __v543 = G.st; local __v544 = "judged"; local __v545 = __add((__T(G.st.judged) or 0), 1); __set(__v543, __v544, __v545) end
__S1.log(G, pi, ("A friendly judge dismisses the case against " .. __str((__get(G.players, pi)).name) .. ". The Heat falls to 1."), ("news"))
do return end
end
do local __v546 = __get(G.players, pi); local __v547 = "raided"; local __v548 = true; __set(__v546, __v547, __v548) end
do local __v549 = G; local __v550 = "heat"; local __v551 = 0; __set(__v549, __v550, __v551) end
do __S1.ops = __num(__S1.ops) + 1 end
do local __v552 = G; local __v553 = "st"; local __v554 = (__T(G.st) or __mkO({}, {})); __set(__v552, __v553, __v554) end
do local __v555 = G.st; local __v556 = "raids"; local __v557 = __add((__T(G.st.raids) or 0), 1); __set(__v555, __v556, __v557) end
__S1.log(G, pi, ("Federal agents raid " .. __str(__S1.co(G, (pi))) .. ". The founder sits out the next market in custody unless bail is posted. The heat dies down."), ("alarm"))
end
__S1.canLobby = function(G)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then do return (__S1.no((__S1.myTurn(G, ("biz"))))) end else if __t(p.jail) then do return (__S1.no(("In custody"))) end else if __lt(p.cash, __S1.infCost((p))) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=__S1.infCost((p))}, {"cash"})))) end end end end
end
__S1.lobby = function(G)  local x
x = __S1.canLobby((G))
if (not __t(x.ok)) then
do return (false) end
end
do local __v558 = __S1.P((G)); local __v559 = "cash"; local __v560 = (__get(__v558, __v559) - x.cost.cash); __set(__v558, __v559, __v560) end
__S1.acc(__S1.P((G)), "inf", (x.cost.cash))
__S1.drawInf(G, G.turn, (1))
__S1.next((G))
do return (true) end
end
__S1.canBail = function(G)  local p
p = __S1.P((G))
if __t(__S1.myTurn(G, ("biz"))) then do return (__S1.no((__S1.myTurn(G, ("biz"))))) end else if (not __t(p.jail)) then do return (__S1.no(("Not in custody"))) end else if __lt(p.cash, __S1.bailCost(G, (p))) then do return (__S1.no(("Can't afford"))) end else do return (__S1.yes((__mkO({["cash"]=__S1.bailCost(G, (p))}, {"cash"})))) end end end end
end
__S1.bail = function(G)  local x, p
x = __S1.canBail((G))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
do local __v561 = p; local __v562 = "cash"; local __v563 = (__get(__v561, __v562) - x.cost.cash); __set(__v561, __v562, __v563) end
__S1.acc(p, "bail", (x.cost.cash))
do local __v564 = p; local __v565 = "jail"; local __v566 = false; __set(__v564, __v565, __v566) end
__S1.log(G, G.turn, (__str(p.name) .. " posts bail."), ("bad"))
do return (true) end
end
__S1.canPlay = function(G, u, target, extra)  local p, c, pi, d, need, t
p = __S1.P((G))
c = __call(p.inf, "find", (function(k)  
do return (k.u == u) end
end))
pi = G.turn
if __t(__S1.myTurn((G))) then
do return (__S1.no((__S1.myTurn((G))))) end
end
if (G.phase == "stand") then
do return (__S1.no(("Not yet"))) end
end
if (not __t(c)) then
do return (__S1.no(("No such card"))) end
end
if (__t(p.jail) and (G.phase == "biz")) then
do return (__S1.no(("In custody"))) end
end
d = __get(__S1.ICARD, c.t)
need = (__T(d.extra) or 0)
if __lt(__len(__call((__T(extra) or __mkA({__n=0})), "filter", (function(v)  
do return ((v ~= u) and __call(p.inf, "some", (function(k)  
do return (k.u == v) end
end))) end
end))), need) then
do return (__S1.no((("Mark " .. __str(need) .. " more card" .. __str((__gt(need, 1) and "s" or "")) .. " to discard")))) end
end
t = c.t
if __t(d.leader) then
local q, top, k
q = __get(G.players, target)
if ((not __t(q)) or (target == pi)) then
do return (__S1.no(("Choose a rival"))) end
end
top = JS_Math.max(__unpack(__spreadA({{s=__call(G.players, "map", (function(_, i)  
do return __S1.controlled(G, (i)) end
end))}})))
k = __S1.controlled(G, (target))
if (__lt(k, top) or __le(k, __S1.controlled(G, (pi)))) then
do return (__S1.no(("Only the company controlling the most markets, and more than you"))) end
end
if ((t == "formula") and (not __t(q.stars))) then
do return (__S1.no(("Their product has no stars to steal"))) end
end
if ((t == "antitrust") and (not __t(__call(G.map.cells, "some", (function(c)  
do return (__S1.ownerOf((c)) == target) end
end))))) then
do return (__S1.no(("They control no markets"))) end
end
end
if ((t == "recall") or (t == "spy")) then
local q
q = __get(G.players, target)
if ((not __t(q)) or (target == pi)) then
do return (__S1.no(("Choose a rival"))) end
end
if ((t == "spy") and (not __t(__S1.handSize((q))))) then
do return (__S1.no(("Their hand is empty"))) end
end
if ((t == "recall") and (not __t(q.prog))) then
do return (__S1.no(("Nothing on their track"))) end
end
end
if (t == "ha") then
local m
m = __S1.cell(G, (target))
if (not __t(m)) then
do return (__S1.no(("Choose a market"))) end
end
if (not __t(__call(JS_Object.keys((m.tok)), "some", (function(k)  
do return (__num(k) ~= pi) end
end)))) then
do return (__S1.no(("No rival tokens there"))) end
end
end
if (t == "contract") then
local m
m = __S1.cell(G, (target))
if (not __t(m)) then
do return (__S1.no(("Choose a market"))) end
end
end
if (t == "patent") then
local tl, r
if (G.phase ~= "biz") then
do return (__S1.no(("Only in the market"))) end
end
tl = __get(G.rrow, target)
if (not __t(tl)) then
do return (__S1.no(("Choose a research card"))) end
end
r = __S1.canResearch(G, target, (true))
if (not __t(r.ok)) then
do return (r) end
end
end
if (d.target == "rtile") then
local q, tl
q = __get(G.players, JS_Math.floor(((target / 1000))))
tl = (function() local __v567 = q; if __t(__v567) then return __get((__T(q.tiles) or __mkA({__n=0})), __mod(target, 1000)) end return __v567 end)()
if ((not __t(q)) or (JS_Math.floor(((target / 1000))) == pi)) then
do return (__S1.no(("Choose a card in a rival's hand"))) end
end
if (not __t(tl)) then
do return (__S1.no(("No such tile"))) end
end
if __t(tl.copied) then
do return (__S1.no(("Already copied"))) end
end
if ((not __t(tl.st)) and (not __t(__len(JS_Object.keys((tl.get)))))) then
do return (__S1.no(("That card has no reward to copy"))) end
end
end
if ((t == "judge") and __t(p.judge)) then
do return (__S1.no(("The judge is already on call"))) end
end
if (((t == "proxy") or (t == "buyback")) and __ge((__T(p.cont) or 0), __S1.CMAX)) then
do return (__S1.no(("Your control is full"))) end
end
if ((t == "buyback") and __lt(p.cash, 4)) then
do return (__S1.no(("Can't afford"))) end
end
if ((t == "act") and (not __t(__len(__S1.actTargets(G, (pi)))))) then
do return (__S1.no(("No rival tokens next to your markets"))) end
end
if ((t == "regime") and (G.limon == pi)) then
do return (__S1.no(("San Limón is already yours"))) end
end
do return (__S1.yes()) end
end
__S1.strip = function(G, c, pi, n)  local k
k = 0
do 
while __lt(k, n) do
local w, v
w = nil
v = 0
for __v569 in __forin(c.tok) do
local q
q = __v569; 
if ((__num(q) ~= pi) and __gt(__get(c.tok, q), v)) then
do v = __get(c.tok, q) end
do w = __num(q) end
end

end
if (w == nil) then
do break end
end
do local __v571 = c.tok; local __v572 = w; __set(__v571, __v572, __num((function() local __v571 = c.tok; local __v572 = w; return __get(__v571, __v572) end)()) - 1) end
if (not __t(__get(c.tok, w))) then
rawset(c.tok, w, nil)
end
do k = __num(k) + 1 end
__S1.fx(G, (__mkO({["k"]="tok", ["pi"]=w, ["n"]=1, ["from"]=__add("cell-", c.id), ["to"]=__add("cell-", c.id), ["gone"]=true}, {"k", "pi", "n", "from", "to", "gone"})))

end end
do return (k) end
end
__S1.play = function(G, u, target, extra)  local x, p, pi, c, d, gone, t
x = __S1.canPlay(G, u, target, (extra))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
pi = G.turn
c = __call(p.inf, "find", (function(k)  
do return (k.u == u) end
end))
d = __get(__S1.ICARD, c.t)
gone = __spreadA({{v=c}, {s=__call(__call(p.inf, "filter", (function(k)  
do return (function() local __v573 = __call((__T(extra) or __mkA({__n=0})), "includes", (k.u)); if __t(__v573) then return (k.u ~= u) end return __v573 end)() end
end)), "slice", 0, ((__T(d.extra) or 0)))}})
do local __v574 = p; local __v575 = "inf"; local __v576 = __call(p.inf, "filter", (function(k)  
do return (not __t(__call(gone, "includes", (k)))) end
end)); __set(__v574, __v575, __v576) end
__call(G.idisc, "push", __unpack(__spreadA({{s=__call(gone, "filter", (function(g)  
do return (not __t((__get(__S1.ICARD, g.t)).memo)) end
end))}})))
do __S1.ops = __num(__S1.ops) + 1 end
__call(gone, "forEach", (function(g)  
do return __S1.fx(G, (__mkO({["k"]="inf", ["face"]=g.t, ["from"]=__add("inf-", pi), ["to"]="infdisc"}, {"k", "face", "from", "to"}))) end
end))
t = c.t
if (t == "recall") then
local q, k
q = __get(G.players, target)
k = JS_Math.min(5, (q.prog))
do local __v577 = q; local __v578 = "prog"; local __v579 = (__get(__v577, __v578) - k); __set(__v577, __v578, __v579) end
__S1.log(G, pi, (__str(q.name) .. "'s product is recalled. " .. __str(k) .. " pitchers come off its era track."), ("dirty"))
elseif (t == "ha") then
local m, k
m = __S1.cell(G, (target))
k = __S1.strip(G, m, pi, (2))
__S1.log(G, pi, (__str(p.name) .. " buys out " .. __str(k) .. " rival distributor" .. __str((__gt(k, 1) and "s" or "")) .. " in " .. __str(m.name) .. "."), ("dirty"))
elseif ((t == "reverse") or (t == "leak")) then
local q, tl, st
q = __get(G.players, JS_Math.floor(((target / 1000))))
tl = __get(q.tiles, __mod(target, 1000))
do local __v580 = tl; local __v581 = "copied"; local __v582 = true; __set(__v580, __v581, __v582) end
st = tl.st
do 
while (__gt(st, 0) and __lt(p.stars, __S1.MAXSTAR)) do
do local __v584 = p; __set(__v584, "stars", __num((function() local __v584 = p; return __v584.stars end)()) + 1) end
do st = __num(st) - 1 end

end end
if __t(st) then
do local __v585 = p; local __v586 = "cash"; local __v587 = __add(__get(__v585, __v586), (st * __S1.STARCASH)); __set(__v585, __v586, __v587) end
end
if __t(tl.st) then
__S1.fx(G, (__mkO({["k"]="star", ["n"]=tl.st, ["from"]=__add("seat-", JS_Math.floor(((target / 1000)))), ["to"]=__add("stars-", pi)}, {"k", "n", "from", "to"})))
__S1.pour(G, pi, (0))
end
__S1.give(G, pi, tl.get, ("copy"))
do local __v588 = G; local __v589 = "st"; local __v590 = (__T(G.st) or __mkO({}, {})); __set(__v588, __v589, __v590) end
do local __v591 = G.st; local __v592 = "copies"; local __v593 = __add((__T(G.st.copies) or 0), 1); __set(__v591, __v592, __v593) end
__S1.log(G, pi, (__str(p.name) .. " copies " .. __str(q.name) .. "'s research" .. __str((__t(tl.st) and (": " .. __str(((tl.st == 1) and "half a star" or "a whole star"))) or "")) .. "."), ("dirty"))
if (t == "leak") then
__S1.riskHeat(G, pi, ("A kept memo"))
end
elseif (t == "judge") then
do local __v594 = p; local __v595 = "judge"; local __v596 = true; __set(__v594, __v595, __v596) end
__S1.log(G, pi, (__str(p.name) .. " has a friendly judge on call."), ("news"))
elseif (t == "subsidy") then
do local __v597 = p; local __v598 = "cash"; local __v599 = __add(__get(__v597, __v598), 4); __set(__v597, __v598, __v599) end
__S1.log(G, pi, (__str(p.name) .. " receives a subsidy."), ("news"))
elseif (t == "contract") then
local m
m = __S1.cell(G, (target))
__S1.put(G, pi, (m))
__S1.log(G, pi, (__str(p.name) .. " is awarded a government contract in " .. __str(m.name) .. "."), ("up"))
elseif (t == "spy") then
local q, k
q = __get(G.players, target)
k = 0
do 
while (__lt(k, 2) and __t(__S1.handSize((q)))) do
local pool, f
pool = __call(__S1.FAMS, "flatMap", (function(f)  
do return __call(JS_Array((__get(q.hand, f))), "fill", (f)) end
end))
f = __get(pool, JS_Math.floor(((JS_Math.random() * __len(pool)))))
do local __v601 = q.hand; local __v602 = f; __set(__v601, __v602, __num((function() local __v601 = q.hand; local __v602 = f; return __get(__v601, __v602) end)()) - 1) end
do local __v603 = p.hand; local __v604 = f; __set(__v603, __v604, __num((function() local __v603 = p.hand; local __v604 = f; return __get(__v603, __v604) end)()) + 1) end
do k = __num(k) + 1 end

end end
__S1.log(G, pi, (__str(p.name) .. " acquires " .. __str(k) .. " of " .. __str(q.name) .. "'s ingredients. Nobody can prove anything."), ("dirty"))
elseif (t == "patent") then
__S1.log(G, pi, (__str(p.name) .. " files a patent."), ("news"))
__S1.research(G, target, (true))
elseif (t == "proxy") then
__S1.give(G, pi, (__mkO({["cont"]=2}, {"cont"})))
__S1.log(G, pi, (__str(p.name) .. " wins a proxy vote and takes back the board."), ("up"))
elseif (t == "buyback") then
do local __v605 = p; local __v606 = "cash"; local __v607 = (__get(__v605, __v606) - 4); __set(__v605, __v606, __v607) end
__S1.give(G, pi, (__mkO({["cont"]=__S1.CMAX}, {"cont"})))
__S1.log(G, pi, (__str(p.name) .. " buys back its shares."), ("up"))
elseif (t == "viral") then
do local __v608 = p; local __v609 = "loy"; local __v610 = __add(__get(__v608, __v609), 3); __set(__v608, __v609, __v610) end
__S1.lt(G, pi, "inf", (3))
__S1.log(G, pi, (__str(p.name) .. "'s campaign goes viral."), ("up"))
elseif (t == "act") then
local cs
cs = __S1.actTargets(G, (pi))
__call(cs, "forEach", (function(m)  
do return __S1.strip(G, m, pi, (1)) end
end))
__S1.log(G, pi, ("An Act of Congress finds that " .. __str(__len(cs)) .. " market" .. __str((__gt(__len(cs), 1) and "s" or "")) .. " would be better served by " .. __str(p.name) .. "."), ("dirty"))
elseif (t == "formula") then
local q
q = __get(G.players, target)
do local __v611 = q; __set(__v611, "stars", __num((function() local __v611 = q; return __v611.stars end)()) - 1) end
if __lt(p.stars, __S1.MAXSTAR) then
do local __v612 = p; __set(__v612, "stars", __num((function() local __v612 = p; return __v612.stars end)()) + 1) end
else
do local __v613 = p; local __v614 = "cash"; local __v615 = __add(__get(__v613, __v614), __S1.STARCASH); __set(__v613, __v614, __v615) end
end
__S1.pour(G, pi, (0))
__S1.fx(G, (__mkO({["k"]="star", ["n"]=1, ["from"]=__add("stars-", target), ["to"]=__add("stars-", pi)}, {"k", "n", "from", "to"})))
__S1.log(G, pi, (__str(p.name) .. " acquires " .. __str(q.name) .. "'s formula. Half a star changes hands."), ("dirty"))
elseif (t == "antitrust") then
local q, cs
q = __get(G.players, target)
cs = __call(__call(__call(G.map.cells, "filter", (function(c)  
do return (__S1.ownerOf((c)) == target) end
end)), "sort", (function(a, b)  
do return (__get(a.tok, target) - __get(b.tok, target)) end
end)), "slice", 0, (3))
__call(cs, "forEach", (function(c)  
do local __v616 = c.tok; local __v617 = target; __set(__v616, __v617, __num((function() local __v616 = c.tok; local __v617 = target; return __get(__v616, __v617) end)()) - 1) end
if (not __t(__get(c.tok, target))) then
rawset(c.tok, target, nil)
end
__S1.fx(G, (__mkO({["k"]="tok", ["pi"]=target, ["n"]=1, ["from"]=__add("cell-", c.id), ["to"]=__add("cell-", c.id), ["gone"]=true}, {"k", "pi", "n", "from", "to", "gone"})))
end))
__S1.log(G, pi, (__str(p.name) .. "'s lobbyists win an antitrust suit against " .. __str(q.name) .. ". " .. __str(__len(cs)) .. " market" .. __str((__gt(__len(cs), 1) and "s" or "")) .. " must be divested."), ("dirty"))
elseif (t == "regime") then
do local __v618 = G; local __v619 = "limon"; local __v620 = pi; __set(__v618, __v619, __v620) end
__S1.log(G, pi, ("Orderly transition of government in San Limón. The new president thanks " .. __str(p.name) .. " by name."), ("dirty"))
end
__S1.next((G))
do return (true) end
end
__S1.canFile = function(G, extra)  local p
if (__S1.WIN == "era") then
do return (__S1.no((__add(__add("The first company to era ", __S1.ERAS), " wins")))) end
end
p = __S1.P((G))
if __t(__S1.myTurn(G, ("place"))) then
do return (__S1.no((__S1.myTurn(G, ("place"))))) end
end
if __t(p.filed) then
do return (__S1.no(("Already filed"))) end
end
if __lt(__S1.controlled(G, (G.turn)), __S1.FM) then
do return (__S1.no((("Control " .. __str(__S1.FM) .. " markets first")))) end
end
if __lt(__len(__call((__T(extra) or __mkA({__n=0})), "filter", (function(u)  
do return __call(p.inf, "some", (function(k)  
do return (k.u == u) end
end)) end
end))), __S1.FILECARDS) then do return (__S1.no((("Mark " .. __str(__S1.FILECARDS) .. " influence cards")))) end else do return (__S1.yes()) end end
end
__S1.file = function(G, extra)  local x, p, gone
x = __S1.canFile(G, (extra))
if (not __t(x.ok)) then
do return (false) end
end
p = __S1.P((G))
gone = __call(__call(p.inf, "filter", (function(k)  
do return __call(extra, "includes", (k.u)) end
end)), "slice", 0, (__S1.FILECARDS))
do local __v621 = p; local __v622 = "inf"; local __v623 = __call(p.inf, "filter", (function(k)  
do return (not __t(__call(gone, "includes", (k)))) end
end)); __set(__v621, __v622, __v623) end
__call(G.idisc, "push", __unpack(__spreadA({{s=gone}})))
do local __v624 = p; local __v625 = "filed"; local __v626 = true; __set(__v624, __v625, __v626) end
__S1.log(G, G.turn, (__str(__S1.co(G, (G.turn))) .. " files for monopoly. It must still control " .. __str(__S1.FM) .. " markets at payday."), ("alarm"))
__S1.next((G))
do return (true) end
end
__S1.give = function(G, pi, o, src)  local p
p = __get(G.players, pi)
if (__t(o) and __t(o.loy)) then
__S1.lt(G, pi, (__T(src) or "other"), (o.loy))
end
for __v627 in __forin((__T(o) or __mkO({}, {}))) do
local __v628 = false
local r
r = __v627; 
repeat
local n
n = __get(o, r)
if (not __t(n)) then
do break end
end
if ((r == "cash") or (r == "loy")) then
do local __v629 = p; local __v630 = r; local __v631 = __add(__get(__v629, __v630), n); __set(__v629, __v630, __v631) end
elseif (r == "out") then
__S1.pour(G, pi, n, (src))
elseif (r == "card") then
__S1.drawFree(G, p, (n))
elseif (r == "inf") then
__S1.drawInf(G, pi, (n))
elseif (r == "calm") then
do local __v632 = G; local __v633 = "heat"; local __v634 = JS_Math.max(0, ((G.heat - n))); __set(__v632, __v633, __v634) end
elseif (r == "cont") then
do local __v635 = p; local __v636 = "cont"; local __v637 = JS_Math.min(__S1.CMAX, (__add((__T(p.cont) or 0), n))); __set(__v635, __v636, __v637) end
__S1.pour(G, pi, (0))
elseif ((r == "free") or (r == "rerun")) then
do local __v638 = p; local __v639 = r; local __v640 = __add((__T(__get(p, r)) or 0), n); __set(__v638, __v639, __v640) end
end
do __S1.ops = __num(__S1.ops) + 1 end
until true
if __v628 then break end
end
end
__S1.payday = function(G)  local order, filers, good
order = __S1.placeOrder((G))
if __t(__S1.TRACE) then
__call((function() local __v642 = G; local __v643 = "snap"; local __v641 = (__T(G.snap) or __mkA({__n=0})); __set(__v642, __v643, __v641) return __v641 end)(), "push", (__mkO({["r"]=G.round, ["ps"]=__call(G.players, "map", (function(q, i)  
do return __mkO({["era"]=q.era, ["prog"]=q.prog, ["len"]=__S1.trackLen((q)), ["stars"]=q.stars, ["cash"]=q.cash, ["hand"]=__S1.handSize((q)), ["ctl"]=__S1.controlled(G, (i)), ["nm"]=__len(q.mach), ["cap"]=__call(q.mach, "reduce", function(a, m)  
do return __add(a, m.out) end
end, (0)), ["idle"]=__len(__call(q.mach, "filter", (function(m)  
do return (not __t(m.ran)) end
end))), ["idleCap"]=__call(__call(q.mach, "filter", (function(m)  
do return (not __t(m.ran)) end
end)), "reduce", function(a, m)  
do return __add(a, m.out) end
end, (0)), ["adv"]=__len(q.adv)}, {"era", "prog", "len", "stars", "cash", "hand", "ctl", "nm", "cap", "idle", "idleCap", "adv"}) end
end))}, {"r", "ps"})))
end
__call(G.players, "forEach", (function(q, i)  
do local __v644 = q; local __v645 = "ctl"; local __v646 = __S1.controlled(G, (i)); __set(__v644, __v645, __v646) end
do local __v647 = q; local __v648 = "cash"; local __v649 = __add(__get(__v647, __v648), __add(__add(__add(__add(__S1.income((q.ctl)), __S1.impIncome(G, (i))), (__t(__S1.hasA(q, ("chad"))) and 1 or 0)), (function() if __t(__S1.hasA(q, ("paul"))) then return q.hand.sour end return 0 end)()), (function() if __t(__S1.hasA(q, ("saul"))) then return JS_Math.floor(((G.heat / __S1.SAULD))) end return 0 end)())); __set(__v647, __v648, __v649) end
do __S1.ops = __add(__S1.ops, 2) end
__S1.fx(G, (__mkO({["k"]="coin", ["n"]=__S1.income((q.ctl)), ["from"]="map", ["to"]=__add("cash-", i)}, {"k", "n", "from", "to"})))
if __t(__S1.hasA(q, ("tanner"))) then
do local __v650 = q; local __v651 = "cash"; local __v652 = (__get(__v650, __v651) - JS_Math.ceil(((__S1.income((q.ctl)) / 2)))); __set(__v650, __v651, __v652) end
end
end))
__S1.log(G, nil, ("Payday. " .. __str(__call(__call(G.players, "map", (function(q, i)  
do return (__str(q.name) .. " controls " .. __str(q.ctl)) end
end)), "join", (", "))) .. "."), ("bank"))
for _, __v653 in __forof(G.map.cells) do
local __v654 = false
local c
c = __v653; 
repeat
local o
if __t(c.hot) then o = __S1.ownerOf((c)) else o = nil end
if ((o == nil) or (G.winner ~= nil)) then
do break end
end
__S1.fx(G, (__mkO({["k"]="pit", ["n"]=c.hot.out, ["from"]=__add("cell-", c.id), ["to"]=__add("prog-", o)}, {"k", "n", "from", "to"})))
__S1.log(G, o, (__str((__get(G.players, o)).name) .. "'s stand in " .. __str(c.name) .. " pours " .. __str(c.hot.out) .. " pitchers."), ("up"))
__S1.pour(G, o, c.hot.out, ("hot"))
until true
if __v654 then break end
end
if (G.winner ~= nil) then
do return end
end
__call(G.players, "forEach", (function(q, i)  
if __t(__S1.hasA(q, ("dwarf"))) then
local k
k = __len(__call(G.map.cells, "filter", (function(c)  
do return (function() local __v655 = c.rough; if __t(__v655) then return (__S1.ownerOf((c)) == i) end return __v655 end)() end
end)))
if __t(k) then
do local __v656 = q; local __v657 = "cash"; local __v658 = __add(__get(__v656, __v657), (2 * k)); __set(__v656, __v657, __v658) end
__S1.log(G, i, ("Brokk Stonebeard's mines pay " .. __str(q.name) .. " " .. __str((2 * k)) .. " Capital."), ("up"))
end
end
if (__t(__S1.hasA(q, ("qa"))) and (G.winner == nil)) then
local k
k = JS_Math.min(4, (__len(__call(G.map.cells, "filter", (function(c)  
do return __ge((__T(__get(c.tok, i)) or 0), 2) end
end)))))
if __t(k) then
__S1.log(G, i, ("Quality Assurance approves " .. __str(k) .. " market" .. __str((__gt(k, 1) and "s" or "")) .. ": " .. __str(k) .. " pitcher" .. __str((__gt(k, 1) and "s" or "")) .. "."), ("up"))
__S1.pour(G, i, k, ("qa"))
end
end
end))
if (G.winner ~= nil) then
do return end
end
filers = __call(__call(G.players, "map", (function(q, i)  
do return i end
end)), "filter", (function(i)  
do return (__get(G.players, i)).filed end
end))
good = __call(filers, "filter", (function(i)  
do return __ge((__get(G.players, i)).ctl, __S1.FM) end
end))
__call(__call(filers, "filter", (function(i)  
do return (not __t(__call(good, "includes", (i)))) end
end)), "forEach", (function(i)  
do local __v659 = __get(G.players, i); local __v660 = "filed"; local __v661 = false; __set(__v659, __v660, __v661) end
__S1.log(G, i, (__str(__S1.co(G, (i))) .. "'s monopoly filing is dismissed. It no longer controls " .. __str(__S1.FM) .. " markets."), ("bad"))
end))
if ((__S1.WIN ~= "era") and __t(__len(good))) then
do return (__S1.finish(G, (good))) end
end
for _, __v662 in __forof(G.map.cells) do
local __v663 = false
local c
c = __v662; 
repeat
local ks, w, tot, keep
ks = __call(JS_Object.keys((c.tok)), "map", (JS_Number))
if __lt(__len(ks), 2) then
do break end
end
w = __S1.ownerOf((c))
tot = __call(ks, "reduce", function(a, k)  
do return __add(a, __get(c.tok, k)) end
end, (0))
do __S1.ops = __num(__S1.ops) + 1 end
if (w == nil) then
__call(ks, "forEach", (function(k)  
do return __S1.fx(G, (__mkO({["k"]="tok", ["pi"]=k, ["n"]=__get(c.tok, k), ["from"]=__add("cell-", c.id), ["to"]=__add("cell-", c.id), ["gone"]=true}, {"k", "pi", "n", "from", "to", "gone"}))) end
end))
do local __v664 = c; local __v665 = "tok"; local __v666 = __mkO({}, {}); __set(__v664, __v665, __v666) end
do break end
end
if __t(__S1.hasA(__get(G.players, w), ("lawyer2"))) then keep = __get(c.tok, w) else keep = (__get(c.tok, w) - (tot - __get(c.tok, w))) end
__call(ks, "forEach", (function(k)  local back
if (k == w) then back = (__get(c.tok, w) - keep) else back = __get(c.tok, k) end
if __t(back) then
__S1.fx(G, (__mkO({["k"]="tok", ["pi"]=k, ["n"]=back, ["from"]=__add("cell-", c.id), ["to"]=__add("cell-", c.id), ["gone"]=true}, {"k", "pi", "n", "from", "to", "gone"})))
end
end))
do local __v667 = c; local __v668 = "tok"; local __v669 = __spreadO({{k=w, v=keep}}); __set(__v667, __v668, __v669) end
until true
if __v663 then break end
end
if __t(__len(G.mkt)) then
local old, had
old = __call(G.mkt, "shift")
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=old.name, ["tier"]=old.tier}, {"name", "tier"}), ["from"]="mkt-0", ["to"]="mdeck", ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
had = __call(G.mkt, "slice")
__S1.refillM((G))
__call(G.mkt, "forEach", (function(x, k)  
if (not __t(__call(had, "includes", (x)))) then
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]=x.name, ["tier"]=x.tier}, {"name", "tier"}), ["from"]="mdeck", ["to"]=__add("mkt-", k), ["slide"]=true}, {"k", "m", "from", "to", "slide"})))
end
end))
end
do
local d
d = 0

while __lt(d, __S1.PDISC) do
local k, old
k = __call(G.rrow, "findIndex", (function(c)  
do return (function() local __v671 = c; if __t(__v671) then return (not __t(c.win)) end return __v671 end)() end
end))
if __lt(k, 0) then
do break end
end
old = __get(__call(G.rrow, "splice", k, (1)), 0)
__S1.fx(G, (__mkO({["k"]="mach", ["m"]=__mkO({["name"]="Experiment", ["tier"]=old.tier}, {"name", "tier"}), ["from"]=__add("rcard-", k), ["to"]="rdeck", ["gone"]=true}, {"k", "m", "from", "to", "gone"})))
__call(G.rrow, "push", (nil))
__S1.refillRow(G, (__S1.RROW - 1), (nil))

do d = __num(d) + 1 end
end
end
do local __v672 = G; __set(__v672, "round", __num((function() local __v672 = G; return __v672.round end)()) + 1) end
if __gt(G.round, __S1.MAXROUND) then
local best
if (__S1.WIN == "era") then
do return (__S1.finish(G, (__call(G.players, "map", (function(_, i)  
do return i end
end))))) end
end
best = JS_Math.max(__unpack(__spreadA({{s=__call(G.players, "map", (function(q)  
do return q.ctl end
end))}})))
do return (__S1.finish(G, (__call(__call(G.players, "map", (function(_, i)  
do return i end
end)), "filter", (function(i)  
do return ((__get(G.players, i)).ctl == best) end
end))))) end
end
__S1.nextMemo((G))
end
__S1.finish = function(G, cands)  local key
key = function(i)  local q
q = __get(G.players, i)
if (__S1.WIN == "era") then do return ((__add(__add((q.era * 1000000), (q.prog * 1000)), q.cash) - (__call(G.order, "indexOf", (i)) / 10))) end else do return ((__add((q.ctl * 10000), (__add(q.cash, __len(q.inf)) * 10)) - __call(G.order, "indexOf", (i)))) end end
end
do local __v673 = G; local __v674 = "winner"; local __v675 = __get(__call(cands, "sort", (function(a, b)  
do return (key((b)) - key((a))) end
end)), 0); __set(__v673, __v674, __v675) end
do local __v676 = G; local __v677 = "phase"; local __v678 = "over"; __set(__v676, __v677, __v678) end
__S1.log(G, G.winner, (((__S1.WIN == "era") and __ge((__get(G.players, G.winner)).era, __S1.ERAS)) and (__str(__S1.co(G, (G.winner))) .. " reaches era " .. __str(__S1.ERAS) .. ". All the lemonade on Earth is theirs.") or (__str(__S1.co(G, (G.winner))) .. " has a monopoly on lemonade.")), ("win"))
end
__S1.nextMemo = function(G)  local m
m = __call(G.memoQ, "shift")
if (not __t(m)) then
do local __v679 = G; local __v680 = "pending"; local __v681 = nil; __set(__v679, __v680, __v681) end
do return (__S1.startPhase(G, ("biz"))) end
end
do local __v682 = G; local __v683 = "pending"; local __v684 = m; __set(__v682, __v683, __v684) end
do local __v685 = G; local __v686 = "phase"; local __v687 = "memo"; __set(__v685, __v686, __v687) end
do local __v688 = G; local __v689 = "turn"; local __v690 = m.pi; __set(__v688, __v689, __v690) end
end
__S1.canChoose = function(G, i)  local m, o, p
m = (function() local __v691 = G.pending; if __t(__v691) then return __get(__S1.MEMOS, G.pending.id) end return __v691 end)()
o = (function() local __v692 = m; if __t(__v692) then return __get(m.opts, i) end return __v692 end)()
if (not __t(o)) then
do return (__S1.no(("No such option"))) end
end
p = __get(G.players, G.pending.pi)
for __v693 in __forin((__T(o.cost) or __mkO({}, {}))) do
local r
r = __v693; 
if __lt(__get(p, r), __get(o.cost, r)) then
do return (__S1.no(("Can't afford"))) end
end

end
do return (__S1.yes((o.cost))) end
end
__S1.riskHeat = function(G, pi, title)  local p, c
p = __get(G.players, pi)
if (not __t(__len(G.ideck))) then
do local __v695 = G; local __v696 = "ideck"; local __v697 = __S1.shuffle((G.idisc)); __set(__v695, __v696, __v697) end
do local __v698 = G; local __v699 = "idisc"; local __v700 = __mkA({__n=0}); __set(__v698, __v699, __v700) end
end
c = __call(G.ideck, "pop")
if __t(c) then
local was
__call(G.ideck, "unshift", (c))
was = p.raided
__S1.log(G, pi, (__t(c.x) and ("Word gets around. The Heat rises by " .. __str(c.x) .. ".") or "Nobody notices."), ((__t(c.x) and "dirty" or "news")))
__S1.expose(G, pi, (c.x))
do local __v701 = G; local __v702 = "reveal"; local __v703 = __mkO({["n"]=__add((function() if __t(G.reveal) then return G.reveal.n end return 0 end)(), 1), ["pi"]=pi, ["t"]=c.t, ["x"]=c.x, ["raid"]=((not __t(was)) and p.raided), ["memo"]=title}, {"n", "pi", "t", "x", "raid", "memo"}); __set(__v701, __v702, __v703) end
end
end
__S1.choose = function(G, i)  local pi, p, m, o
if (not __t((__S1.canChoose(G, (i))).ok)) then
if ((i ~= (-1)) or (not __t(G.pending))) then
do return (false) end
end
end
pi = G.pending.pi
p = __get(G.players, pi)
m = __get(__S1.MEMOS, G.pending.id)
o = __get(m.opts, i)
if __t(o) then
for __v704 in __forin((__T(o.cost) or __mkO({}, {}))) do
local r
r = __v704; 
do local __v706 = p; local __v707 = r; local __v708 = (__get(__v706, __v707) - __get(o.cost, r)); __set(__v706, __v707, __v708) end

end
if __t(__S1.TRACE) then
local ctl, mtop
ctl = __call(G.players, "map", (function(_, j)  
do return __S1.controlled(G, (j)) end
end))
mtop = JS_Math.max(__unpack(__spreadA({{s=ctl}})))
__call((function() local __v710 = G; local __v711 = "clog"; local __v709 = (__T(G.clog) or __mkA({__n=0})); __set(__v710, __v711, __v709) return __v709 end)(), "push", (__mkO({["pi"]=pi, ["r"]=G.round, ["id"]=G.pending.id, ["opt"]=i, ["risk"]=(not (not __t(o.risk))), ["gain"]=__spreadO({{s=(__T(o.gain) or __mkO({}, {}))}}), ["cost"]=__spreadO({{s=(__T(o.cost) or __mkO({}, {}))}}), ["mapLead"]=((__get(ctl, pi) == mtop) and (__len(__call(ctl, "filter", (function(x)  
do return (x == mtop) end
end))) == 1))}, {"pi", "r", "id", "opt", "risk", "gain", "cost", "mapLead"})))
end
__S1.give(G, pi, o.gain, ("memo"))
__S1.log(G, pi, (__str(__S1.co(G, (pi))) .. ", re: " .. __str(__call(m.title, "toLowerCase")) .. ". Resolved: " .. __str(__call(o.label, "toLowerCase")) .. "."), ("memo"))
if __t(o.keep) then
__call(p.inf, "push", (__mkO({["u"]=__add(100000, (function() local __v713 = G; local __v714 = "keepN"; local __v712 = __add((__T(G.keepN) or 0), 1); __set(__v713, __v714, __v712) return __v712 end)()), ["t"]=o.keep, ["x"]=0}, {"u", "t", "x"})))
__S1.fx(G, (__mkO({["k"]="inf", ["from"]="memo", ["to"]=__add("inf-", pi)}, {"k", "from", "to"})))
end
if __t(o.risk) then
__S1.riskHeat(G, pi, (m.title))
do local __v715 = G; local __v716 = "st"; local __v717 = (__T(G.st) or __mkO({}, {})); __set(__v715, __v716, __v717) end
do local __v718 = G.st; local __v719 = "villain"; local __v720 = __add((__T(G.st.villain) or 0), 1); __set(__v718, __v719, __v720) end
end
end
__S1.nextMemo((G))
do return (true) end
end
__S1.cardValue = function(G, p, c, seen)  local st, g, v
if __t(c.win) then
if __ge(__S1.resCards((p)), __S1.WINNEED) then do return (200) end else do return (0) end end
end
if ((not __t(seen)) and (not __t(__S1.ENV.FACEUP))) then
local t
do __S1.DECK0 = (__T(__S1.DECK0) or __S1.researchDeck()) end
t = __call(__S1.DECK0, "filter", (function(d)  
do return (d.tier == c.tier) end
end))
do return ((__call(t, "reduce", function(a, d)  
do return __add(a, __S1.cardValue(G, p, d, (true))) end
end, (0)) / __len(t))) end
end
st = JS_Math.min(c.st, ((__S1.MAXSTAR - p.stars)))
g = (__T(c.get) or __mkO({}, {}))
v = __add(__add(__add(__add(__add((st * __S1.gv(p, ("stv"))), (((c.st - st) * __S1.STARCASH) * 0.8)), ((__T(g.out) or 0) * __S1.gv(p, ("rOut")))), ((__T(g.free) or 0) * __S1.gv(p, ("rFree")))), ((__T(g.rerun) or 0) * __S1.gv(p, ("rRerun")))), ((__T(g.inf) or 0) * 1.2))
if __t(c.bonus) then
do v = __add(v, ((c.bonus.n * ((c.bonus.f == "any") and 1.5 or 1)) * (function() if __t(__S1.condOK(G, p, (c.bonus.cond))) then return __S1.gv(p, ("nbv")) end return (__t(__S1.nearCond(G, p, (c.bonus.cond))) and 1.5 or 0.5) end)())) end
end
if (__t(__S1.IMPON) and (not __t(c.win))) then
do v = __add(v, ((__T(__get(__S1.IMPR, (c.tier - 1))) or 0) * __S1.gv(p, ("rImp")))) end
end
do return (__add(__add(v, (function() if __ge(__S1.resCards((p)), (__S1.WINNEED - 2)) then return __S1.gv(p, ("fchase")) end return 0 end)()), __S1.gv(p, ("resBias")))) end
end
__S1.nearCond = function(G, p, cond)  local pi, home
pi = __call(G.players, "indexOf", (p))
home = __S1.homeOf(G, (pi))
if (cond == "home5") then
do return (((not (not __t(home))) and __ge((__T(__get(home.tok, pi)) or 0), 3))) end
end
if (cond == "deep3") then
do return (__ge(__len(__call(G.map.cells, "filter", (function(c)  
do return __ge((__T(__get(c.tok, pi)) or 0), 2) end
end))), 3)) end
end
do return (false) end
end
__S1.plan = function(G, pi)  local p, best, rc, mw, hs
p = __get(G.players, pi)
best = nil
rc = __S1.gv(p, ("rcost"))
mw = __S1.gv(p, ("missW"))
hs = __S1.handSize((p))
__call(G.rrow, "forEach", (function(c, i)  local n, gap, cards, miss, v
if (not __t(c)) then
do return end
end
if (__t(c.win) and __lt(__S1.resCards((p)), __S1.WINNEED)) then
do return end
end
n = __S1.needFor(G, p, (c))
gap = (n.shortN - n.ram)
if __gt(gap, 1) then
do return end
end
cards = __add(n.any, n.ram)
miss = __add(JS_Math.max(0, ((cards - hs))), gap)
v = __add(((__S1.cardValue(G, p, (c)) - (cards * rc)) - (miss * mw)), (JS_Math.random() * 0.2))
if (__le((__S1.cardValue(G, p, (c)) - (cards * rc)), 0) and (not __t(c.win))) then
do return end
end
if ((not __t(best)) or __gt(v, best.v)) then
do best = __mkO({["i"]=i, ["v"]=v, ["cards"]=cards, ["gap"]=gap, ["miss"]=miss}, {"i", "v", "cards", "gap", "miss"}) end
end
end))
do return (best) end
end
__S1.wants = function(G, pi)  local p, w, pl
p = __get(G.players, pi)
w = __mkO({["sweet"]=0, ["sour"]=0, ["herb"]=0, ["fizz"]=0, ["any"]=0}, {"sweet", "sour", "herb", "fizz", "any"})
for _, __v721 in __forof(p.mach) do
local m
m = __v721; 
for _, __v723 in __forof(m.inp) do
local f
f = __v723; 
do local __v725 = w; local __v726 = f; __set(__v725, __v726, __num((function() local __v725 = w; local __v726 = f; return __get(__v725, __v726) end)()) + 1) end

end

end
pl = __S1.plan(G, (pi))
if (__t(pl) and (__t((__get(G.rrow, pl.i)).win) or __lt(p.stars, __S1.gv(p, ("resStock"))))) then
do local __v727 = w; local __v728 = "any"; local __v729 = __add(__get(__v727, __v728), pl.cards); __set(__v727, __v728, __v729) end
end
do return (w) end
end
__S1.deficit = function(G, pi)  local p, w, d, spare
p = __get(G.players, pi)
w = __S1.wants(G, (pi))
d = __mkO({}, {})
spare = __call(__S1.FAMS, "reduce", function(a, f)  
do return __add(a, JS_Math.max(0, ((__get(p.hand, f) - __get(w, f))))) end
end, (0))
for _, __v730 in __forof(__S1.FAMS) do
local f
f = __v730; 
do local __v732 = d; local __v733 = f; local __v734 = JS_Math.max(0, ((__get(w, f) - __get(p.hand, f)))); __set(__v732, __v733, __v734) end

end
do local __v735 = d; local __v736 = "any"; local __v737 = JS_Math.max(0, ((w.any - spare))); __set(__v735, __v736, __v737) end
do return (d) end
end
__S1.botPick = function(G, pi)  local d, cs, bi, bv
d = __S1.deficit(G, (pi))
cs = G.choice.cards
bi = 0
bv = (-JS_Infinity)
__call(cs, "forEach", (function(c, i)  local v
if __t(c.taken) then
do return end
end
v = (__add(__add((__get(d, c.f) * 3), (__t(d.any) and 1 or 0)), (JS_Math.random() * 0.5)) - (__get((__get(G.players, pi)).hand, c.f) * 0.2))
if __gt(v, bv) then
do bv = v end
do bi = i end
end
end))
do return (bi) end
end
__S1.memoScore = function(G, pi, o)  local p, v, s
p = __get(G.players, pi)
v = __mkO({["cash"]=__S1.gv(p, ("mCash")), ["card"]=__S1.gv(p, ("mCard")), ["loy"]=__S1.gv(p, ("mLoy")), ["out"]=(2 / __S1.trackLen((p))), ["inf"]=1.1, ["calm"]=0.5, ["free"]=3, ["rerun"]=2.5, ["cont"]=(function() if __lt((__T(p.cont) or 0), __S1.CMAX) then return __S1.gv(p, ("mCont")) end return 0 end)()}, {"cash", "card", "loy", "out", "inf", "calm", "free", "rerun", "cont"})
s = 0
for __v738 in __forin((__T(o.gain) or __mkO({}, {}))) do
local r
r = __v738; 
do s = __add(s, ((__T(__get(v, r)) or 0) * __get(o.gain, r))) end

end
for __v740 in __forin((__T(o.cost) or __mkO({}, {}))) do
local r
r = __v740; 
do s = (s - __get(o.cost, r)) end

end
if __t(o.risk) then
do s = (s - __add(0.5, ((__S1.deckOdds((G)))(((__S1.tolerance((G)) - G.heat))) * __S1.gv(p, ("heatAv"))))) end
end
if __t(o.keep) then
do s = __add(s, __S1.gv(p, ("mKeep"))) end
end
do return (__add(s, (JS_Math.random() * 0.3))) end
end
__S1.placeValue = function(G, pi, c, free)  local p, mine, top, who, own, v, on, gO, gD
p = __get(G.players, pi)
mine = __S1.toks(c, (pi))
top = 0
who = nil
if (not __t(p.gen)) then
__S1.mapStyle((p))
end
for __v742 in __forin(c.tok) do
local k
k = __v742; 
if ((__num(k) ~= pi) and __gt(__get(c.tok, k), top)) then
do top = __get(c.tok, k) end
do who = __num(k) end
end

end
own = __S1.ownerOf((c))
v = nil
if (own == pi) then
do local __v744; if (__gt(top, 0) and __le((mine - top), 1)) then __v744 = __S1.gv(p, ("gDefend")) else __v744 = (function() if ((top == 0) and __lt(mine, 2)) then return __S1.gv(p, ("gSpare")) end return (-99) end)() end v = __v744 end
elseif __gt(__add(mine, 1), top) then
do v = __add(__S1.gv(p, ("gCapture")), (__t(top) and 3 or 0)) end
elseif (__add(mine, 1) == top) then
do v = (((who ~= nil) and __ge((__get(G.players, who)).ctl, p.ctl)) and 4 or 2) end
else
do v = (-99) end
end
if __t(c.bonus) then
do v = __add(v, __S1.gv(p, ("gBonusCell"))) end
end
if (__t(c.hot) and __gt(v, 0)) then
do v = __add(v, (__S1.gv(p, ("gHot")) * c.hot.out)) end
end
if (__gt(v, 0) and __t(__S1.cellYield((c)))) then
do v = __add(v, (__S1.gv(p, ("gImp")) * __S1.cellYield((c)))) end
end
on = __S1.outpostN((p))
gO = __S1.gv(p, ("gOutpost"))
if ((((own == pi) and (mine == (on - 1))) and __ge(__S1.reach(G, pi, (c)), 2)) and __lt(v, gO)) then
do v = gO end
end
gD = __S1.gv(p, ("gDeep"))
if ((((own == pi) and (mine == 1)) and (__t(__S1.hasA(p, ("qa"))) or __gt(gD, 0))) and __lt(v, (__t(__S1.hasA(p, ("qa"))) and 5 or gD))) then
local deep
deep = __len(__call(G.map.cells, "filter", (function(x)  
do return __ge((__T(__get(x.tok, pi)) or 0), 2) end
end)))
if ((not __t(__S1.hasA(p, ("qa")))) or __lt(deep, 4)) then
do v = (__t(__S1.hasA(p, ("qa"))) and 5 or gD) end
end
end
if ((__t(c.rough) and (own ~= pi)) and __gt(v, 0)) then
do v = __add(v, (__t(__S1.hasA(p, ("dwarf"))) and 7 or __S1.gv(p, ("gRough")))) end
end
if ((((own ~= nil) and (own ~= pi)) and __gt(__add(mine, 1), top)) and __gt(v, 0)) then
do v = __add(v, (__t(__S1.hasA(p, ("raider"))) and 3 or __S1.gv(p, ("gAtk")))) end
end
if ((not __t(__len(JS_Object.keys((c.tok))))) and __gt(v, 0)) then
do v = __add(v, (__t(__S1.hasA(p, ("pioneer"))) and 1.5 or __S1.gv(p, ("gGrow")))) end
end
if __t(__S1.keepOn((p))) then
local home, hm, sm, dp
home = __S1.homeOf(G, (pi))
hm = __S1.held(p, ("home5"))
sm = __S1.held(p, ("small5"))
dp = __S1.held(p, ("deep3"))
if (((__t(hm) and (c == home)) and __lt(mine, __add(__S1.HOMEN, 1))) and __lt(v, 12)) then
do v = 12 end
end
if ((__t(dp) and (own == pi)) and __lt(__len(__call(G.map.cells, "filter", (function(x)  
do return __ge((__T(__get(x.tok, pi)) or 0), __S1.DEEPT) end
end))), __add(__S1.DEEPK, 1))) then
if ((mine == (__S1.DEEPT - 1)) and __lt(v, 9)) then
do v = 9 end
elseif ((__gt(mine, 0) and __lt(mine, (__S1.DEEPT - 1))) and __lt(v, 5)) then
do v = 5 end
end
end
if (((__t(sm) and (own ~= pi)) and __gt(__add(mine, 1), top)) and __ge(__S1.controlled(G, (pi)), (__S1.SMALLN - 1))) then
do v = (-99) end
end
end
if (not __t(__S1.ENV.NOTALL)) then
local hm, sm, dp
hm = __S1.held(p, ("home5"))
sm = __S1.held(p, ("small5"))
dp = __S1.held(p, ("deep3"))
if (((__t(hm) and (c.home == pi)) and __lt(mine, 6)) and __lt(v, __add(3, hm))) then
do v = __add(3, hm) end
end
if (((__t(dp) and (own == pi)) and (mine == 2)) and __lt(v, __add(2.5, dp))) then
do v = __add(2.5, dp) end
end
if ((((__t(sm) and (own ~= pi)) and __gt(__add(mine, 1), top)) and __ge(__S1.controlled(G, (pi)), 4)) and __gt(v, 0)) then
do v = (v - (2.5 * sm)) end
end
end
do return (__add((v - (__t(free) and 0 or (__S1.tokCost(G, pi, (c)) * __S1.gv(p, ("gKW"))))), (JS_Math.random() * 0.01))) end
end
__S1.bestCell = function(G, pi, free)  local best, p
best = nil
p = __get(G.players, pi)
for _, __v745 in __forof(G.map.cells) do
local __v746 = false
local c
c = __v745; 
repeat
local v
if ((not __t(free)) and __gt(__S1.tokCost(G, pi, (c)), p.loy)) then
do break end
end
v = __S1.placeValue(G, pi, c, (free))
if ((not __t(best)) or __gt(v, best.v)) then
do best = __mkO({["c"]=c, ["v"]=v}, {"c", "v"}) end
end
until true
if __v746 then break end
end
do return (best) end
end
__S1.advVal = function(G, pi, a)  local p, v
p = __get(G.players, pi)
if __lt(p.era, a.era) then
do return ((-9)) end
end
v = __S1.gv(p, ((__T(__get(__S1.ADVK, a.tag)) or "advAll")))
if __t(a.ms) then
do v = __S1.gv(p, (__get(__S1.MSK, a.ms))) end
if (a.id == "dwarf") then
do v = __add(v, (__t(__call(G.map.cells, "some", (function(c)  
do return (function() local __v747 = c.rough; if __t(__v747) then return (__S1.ownerOf((c)) == pi) end return __v747 end)() end
end))) and 0.5 or (-0.5))) end
end
if (a.id == "qa") then
do v = __add(v, (__ge(__len(__call(G.map.cells, "filter", (function(c)  
do return __ge((__T(__get(c.tok, pi)) or 0), 2) end
end))), 2) and 0.5 or 0)) end
end
end
if (a.id == "boogey") then
do v = (__t(__call(G.players, "some", (function(q, i)  
do return ((i ~= pi) and __len(q.adv)) end
end))) and 5 or 0) end
end
if (a.id == "saul") then
do v = __add(v, (__ge(G.heat, 2) and 0.5 or 0)) end
end
do v = (v - ((__T(a.cc) or 0) * __S1.gv(p, ("ccv")))) end
do return (__add(v, (JS_Math.random() * 0.5))) end
end
__S1.botAdvisor = function(G, pi)  local p, scrap, best, res, thr, resFor
p = __get(G.players, pi)
if (__t(__S1.keepOn((p))) and __t(__S1.held(p, ("noadv")))) then
do return (false) end
end
if (((not __t(__S1.ADV)) or __ge(__len(p.adv), __S1.gv(p, ("amax")))) or __t(__call(__call(JS_String(((__T(__S1.ENV.NOADV) or ""))), "split", (",")), "includes", (p.spec)))) then
do return (false) end
end
scrap = nil
if __ge(__S1.used((p)), __S1.SLOTS) then
local w
w = __get(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "sort", (function(a, b)  
do return (a.m.out - b.m.out) end
end)), 0)
if ((not __t(w)) or __gt(w.m.out, __S1.gv(p, ("advScrap")))) then
do return (false) end
end
do scrap = w.i end
end
best = nil
res = __S1.gv(p, ("advRes"))
thr = __S1.gv(p, ("advThr"))
resFor = function(a)  
do return (function() if __t(__S1.mapFit(p, (a))) then return __S1.gv(p, ("advResMap")) end return res end)() end
end
__call(G.arow, "forEach", (function(a, k)  local v
if ((not __t((__S1.canHire(G, (k))).ok)) or __lt((p.cash - a.price), resFor((a)))) then
do return end
end
v = __S1.advVal(G, pi, (a))
if (__ge(v, thr) and ((not __t(best)) or __gt(v, best.v))) then
do best = __mkO({["k"]=k, ["v"]=v}, {"k", "v"}) end
end
end))
__call(G.players, "forEach", (function(q, qi)  
if (qi == pi) then
do return end
end
__call(q.adv, "forEach", (function(a, k)  local v
if ((not __t((__S1.canHire(G, k, (qi))).ok)) or __lt(((p.cash - a.price) - __S1.POACH), __add(res, 2))) then
do return end
end
v = __add((__S1.advVal(G, pi, (a)) - 0.8), (__gt(q.ctl, p.ctl) and 0.6 or 0))
if (__ge(v, thr) and ((not __t(best)) or __gt(v, best.v))) then
do best = __mkO({["k"]=k, ["v"]=v, ["from"]=qi}, {"k", "v", "from"}) end
end
end))
end))
if __t(best) then do return (__S1.hire(G, best.k, best.from, (scrap))) end else do return (false) end end
end
__S1.botOffer = function(G)  local o, pi, p, v
o = G.offer
pi = o.pi
p = __get(G.players, pi)
v = ((__t(__S1.keepOn((p))) and __t(__S1.held(p, ("noadv")))) and 0 or __S1.advVal(G, pi, (o.a)))
if ((__ge(v, __S1.gv(p, ("advThr"))) and __t((__S1.canTakeOffer((G))).ok)) and __ge((p.cash - o.a.price), (function() if __t(__S1.mapFit(p, (o.a))) then return __S1.gv(p, ("advResMap")) end return __S1.gv(p, ("offerRes")) end)())) then
local scrap
scrap = nil
if __ge(__S1.used((p)), __S1.SLOTS) then
local w
w = __get(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "sort", (function(a, b)  
do return (a.m.out - b.m.out) end
end)), 0)
if (__t(w) and __le(w.m.out, __S1.gv(p, ("advScrap")))) then
do scrap = w.i end
elseif __t(__len(p.adv)) then
do scrap = "a0" end
else
do return (__S1.declineOffer((G))) end
end
end
if __t(__S1.takeOffer(G, (scrap))) then
do return (true) end
end
end
do return (__S1.declineOffer((G))) end
end
__S1.botStep = function(G)  local pi, p, has, tryPlay, calm
if (G.winner ~= nil) then
do return (false) end
end
if __t(G.pending) then
local pi, m, bi, bv
pi = G.pending.pi
m = __get(__S1.MEMOS, G.pending.id)
bi = (-1)
bv = (-1000000000)
__call(m.opts, "forEach", (function(o, i)  
if __t((__S1.canChoose(G, (i))).ok) then
local v
v = __S1.memoScore(G, pi, (o))
if __gt(v, bv) then
do bv = v end
do bi = i end
end
end
end))
do return (__S1.choose(G, (bi))) end
end
if __t(G.offer) then
do return (__S1.botOffer((G))) end
end
if __t(G.choice) then
do return (__S1.pick(G, (__S1.botPick(G, (G.choice.pi))))) end
end
pi = G.turn
p = __S1.P((G))
if (G.phase == "stand") then
local best, S, mid, wc, wg, wb
best = nil
S = G.map.size
mid = ((S - 1) / 2)
wc = __S1.gv(p, ("stCenter"))
wg = __S1.gv(p, ("stGap"))
wb = __S1.gv(p, ("stBonus"))
for _, __v748 in __forof(G.map.cells) do
local __v749 = false
local c
c = __v748; 
repeat
local gap, v
if (not __t((__S1.canStand(G, (c.id))).ok)) then
do break end
end
gap = JS_Math.min(__unpack(__spreadA({{v=9}, {s=__call(__call(G.map.cells, "filter", (function(o)  
do return (o.home ~= nil) end
end)), "map", (function(o)  
do return __add(JS_Math.abs(((o.c - c.c))), JS_Math.abs(((o.r - c.r)))) end
end))}})))
v = __add(__add(__add(((-__add(JS_Math.abs(((c.c - mid))), JS_Math.abs(((c.r - mid))))) * wc), (JS_Math.min(gap, (4)) * wg)), (function() if __t(c.bonus) then return wb end return 0 end)()), (JS_Math.random() * 0.4))
if ((not __t(best)) or __gt(v, best.v)) then
do best = __mkO({["c"]=c, ["v"]=v}, {"c", "v"}) end
end
until true
if __v749 then break end
end
do return (__S1.stand(G, (best.c.id))) end
end
has = function(t)  
do return __call(p.inf, "find", (function(k)  
do return (k.t == t) end
end)) end
end
tryPlay = function(t, target)  local c
c = has((t))
if (__t(c) and __t((__S1.canPlay(G, c.u, (target))).ok)) then do return (__S1.play(G, c.u, (target))) end else do return (false) end end
end
calm = function(k)  
do return __lt(__add(G.heat, k), __S1.tolerance((G))) end
end
if (G.phase == "biz") then
local pl, lead, top, doResearch, doScrap, fx2, flexy, steps, order, near
if __t(p.jail) then
if (__t((__S1.canBail((G))).ok) and __ge(p.cash, __add(__S1.bailCost(G, (p)), __S1.gv(p, ("bailRes"))))) then
__S1.bail((G))
else
do return (__S1.pass((G))) end
end
end
pl = __S1.plan(G, (pi))
if (__t(has(("subsidy"))) and __t(tryPlay(("subsidy")))) then
do return (true) end
end
if (__t(has(("viral"))) and __t(tryPlay(("viral")))) then
do return (true) end
end
if ((__t(has(("proxy"))) and __le((__T(p.cont) or 0), (__S1.CMAX - 2))) and __t(tryPlay(("proxy")))) then
do return (true) end
end
if (((__t(has(("buyback"))) and __le((__T(p.cont) or 0), (__S1.CMAX - 3))) and __ge(p.cash, 8)) and __t(tryPlay(("buyback")))) then
do return (true) end
end
if ((__t(has(("judge"))) and (not __t(p.judge))) and __t(tryPlay(("judge")))) then
do return (true) end
end
lead = __get(__call(__call(__call(G.players, "map", (function(q, i)  
do return i end
end)), "filter", (function(i)  
do return (i ~= pi) end
end)), "sort", (function(a, b)  
do return ((__get(G.players, b)).ctl - (__get(G.players, a)).ctl) end
end)), 0)
if ((((lead ~= nil) and __t(has(("recall")))) and __ge((__get(G.players, lead)).prog, 3)) and __t(tryPlay("recall", (lead)))) then
do return (true) end
end
top = __get(__call(__call(__call(G.players, "map", (function(q, i)  
do return i end
end)), "filter", (function(i)  
do return (i ~= pi) end
end)), "sort", (function(a, b)  
do return (__S1.controlled(G, (b)) - __S1.controlled(G, (a))) end
end)), 0)
if (((top ~= nil) and __t(has(("formula")))) and __t(tryPlay("formula", (top)))) then
do return (true) end
end
if (__t(has(("reverse"))) or __t(has(("leak")))) then
local tv, bt
tv = function(tl)  
do return __add((tl.st * 4), __call(JS_Object.entries((tl.get)), "reduce", function(a, __p1) local r, n; local __v750 = __get(__p1, 0); r = __v750; local __v751 = __get(__p1, 1); n = __v751;  
do return __add(a, ((__T(__get(__mkO({["out"]=1, ["free"]=4, ["rerun"]=3, ["inf"]=1.1, ["calm"]=0.5}, {"out", "free", "rerun", "inf", "calm"}), r)) or 1) * n)) end
end, (0))) end
end
bt = nil
__call(G.players, "forEach", (function(q, qi)  
if (qi ~= pi) then
__call((__T(q.tiles) or __mkA({__n=0})), "forEach", (function(tl, k)  
if ((not __t(tl.copied)) and ((not __t(bt)) or __gt(tv((tl)), bt.v))) then
do bt = __mkO({["v"]=tv((tl)), ["target"]=__add((qi * 1000), k)}, {"v", "target"}) end
end
end))
end
end))
if (((__t(bt) and __ge(bt.v, 3)) and __t(has(("reverse")))) and __t(tryPlay("reverse", (bt.target)))) then
do return (true) end
end
if ((((__t(bt) and __ge(bt.v, 3)) and __t(has(("leak")))) and __t(calm((2)))) and __t(tryPlay("leak", (bt.target)))) then
do return (true) end
end
end
if ((((lead ~= nil) and __t(has(("spy")))) and __ge(__S1.handSize((__get(G.players, lead))), 3)) and __t(tryPlay("spy", (lead)))) then
do return (true) end
end
doResearch = function()  
if (not __t(pl)) then
do return (false) end
end
if ((pl.miss == 0) and __t((__S1.canResearch(G, (pl.i))).ok)) then
do return (__S1.research(G, (pl.i))) end
end
if (((pl.miss == 1) and __t(has(("patent")))) and __t((__S1.canPlay(G, (has(("patent"))).u, (pl.i))).ok)) then
do return (__S1.play(G, (has(("patent"))).u, (pl.i))) end
end
do return (false) end
end
doScrap = function()  local thr, best
thr = __S1.gv(p, ("scrapThr"))
if (__ge(thr, 50) or __lt(__len(p.mach), 1)) then
do return (false) end
end
best = nil
__call(p.mach, "forEach", (function(m, mi)  local after
after = __spreadO({{s=p}, {k="shelf", v=__spreadA({{s=(__T(p.shelf) or __mkA({__n=0}))}, {v=m}})}})
__call(G.rrow, "forEach", (function(c)  local now, then_, v
if ((not __t(c)) or (__t(c.win) and __lt(__S1.resCards((p)), __S1.WINNEED))) then
do return end
end
now = __S1.needFor(G, p, (c))
then_ = __S1.needFor(G, after, (c))
if (__le((now.shortN - now.ram), 0) or __gt((then_.shortN - then_.ram), 0)) then
do return end
end
v = ((__S1.cardValue(G, p, (c)) - (__add(then_.any, then_.ram) * __S1.gv(p, ("rcost")))) - (m.out * __S1.gv(p, ("scrapOut"))))
if (__ge(v, thr) and ((not __t(best)) or __gt(v, best.v))) then
do best = __mkO({["mi"]=mi, ["v"]=v}, {"mi", "v"}) end
end
end))
end))
if __t(best) then do return (__S1.scrapM(G, (best.mi))) end else do return (false) end end
end
if __t(doScrap()) then
do return (true) end
end
if (__ge(__S1.gv(p, ("resFirst")), 0.5) and __t(doResearch())) then
do return (true) end
end
if (((__ge(__S1.controlled(G, (pi)), (__S1.FM - 1)) and __lt(__len(p.inf), __S1.FILECARDS)) and __t((__S1.canLobby((G))).ok)) and (__t(calm((2))) or __ge(__S1.controlled(G, (pi)), __S1.FM))) then
do return (__S1.lobby((G))) end
end
if (__t(__S1.hasA(p, ("paul"))) and __t((__S1.canSell((G))).ok)) then
local n
n = (p.hand.sour - (__S1.wants(G, (pi))).sour)
if __gt(n, 0) then
__S1.sell(G, (n))
end
end
if ((__t(__S1.hasA(p, ("boogey"))) and __t(calm((1)))) and (p.hitR ~= G.round)) then
local t
t = __get(__call(__call(__call(G.players, "map", (function(q, i)  
do return __mkO({["q"]=q, ["i"]=i}, {"q", "i"}) end
end)), "filter", (function(x)  
do return ((x.i ~= pi) and __len(x.q.adv)) end
end)), "sort", (function(a, b)  
do return (b.q.ctl - a.q.ctl) end
end)), 0)
if (__t(t) and __t(__S1.hit(G, t.i, (0)))) then
do return (true) end
end
end
fx2 = ((p.spec == "flex") and (not __t(p.gen)))
flexy = function(m)  
do return __call(m.inp, "every", (function(f)  
do return (f == "any") end
end)) end
end
steps = __mkO({["run"]=function()  local runs, fm
runs = __call(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "filter", (function(x)  
do return (__S1.canRun(G, (x.i))).ok end
end)), "sort", (function(a, b)  
do return (b.m.out - a.m.out) end
end))
if __t(__len(runs)) then
do return (__S1.run(G, ((__get(runs, 0)).i))) end
end
if __t(p.rerun) then
local x
x = __get(__call(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "filter", (function(x)  
do return (__S1.canRun(G, x.i, ("rerun"))).ok end
end)), "sort", (function(a, b)  
do return (b.m.out - a.m.out) end
end)), 0)
if __t(x) then
do return (__S1.run(G, x.i, nil, ("rerun"))) end
end
end
fm = __S1.gv(p, ("freeMin"))
if __t(p.free) then
local x
x = __get(__call(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "filter", (function(x)  
do return (function() local __v752 = (__S1.canRun(G, x.i, ("free"))).ok; if __t(__v752) then return __ge(x.m.out, fm) end return __v752 end)() end
end)), "sort", (function(a, b)  
do return (b.m.out - a.m.out) end
end)), 0)
if __t(x) then
do return (__S1.run(G, x.i, nil, ("free"))) end
end
end
if __t(__S1.hasA(p, ("hal"))) then
local h
h = __get(__call(__call(__call(p.mach, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "filter", (function(x)  
do return (function() local __v753 = (__S1.canRun(G, x.i, (true))).ok; if __t(__v753) then return __ge(x.m.out, 4) end return __v753 end)() end
end)), "sort", (function(a, b)  
do return (b.m.out - a.m.out) end
end)), 0)
if __t(h) then
do return (__S1.run(G, h.i, nil, (true))) end
end
end
do return (false) end
end, ["res"]=function()  
do return doResearch() end
end, ["buy"]=function()  local worst, mg, mr, sh, mf, mv, bm, worstFlex
if __lt(__S1.used((p)), __S1.SLOTS) then worst = nil else worst = __call(p.mach, "reduce", function(a, m, i)  
do return (((not __t(a)) or __lt(m.out, a.m.out)) and __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) or a) end
end, (nil)) end
mg = __S1.gv(p, ("mGain"))
mr = __S1.gv(p, ("mRes"))
sh = __S1.shelfOf((p))
mf = __S1.gv(p, ("mFam"))
mv = function(m)  
do return __add(m.out, (mf * (__new(JS_Set, (__call(m.inp, "filter", (function(f)  
do return ((f ~= "any") and __lt(__get(sh, f), 2)) end
end))))).size)) end
end
bm = __get(__call(__call(__call(G.mkt, "map", (function(m, i)  
do return __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) end
end)), "filter", (function(x)  
do return (function() local __v754 = (function() local __v755 = (__S1.canBuy(G, (x.i))).ok; if __t(__v755) then return (function() if __t(fx2) then return (function() local __v756 = flexy((x.m)); if __t(__v756) then return (((not __t(worst)) or __gt(x.m.out, worst.m.out)) or (not __t(flexy((worst.m))))) end return __v756 end)() end return ((not __t(worst)) or __ge(mv((x.m)), __add(worst.m.out, mg))) end)() end return __v755 end)(); if __t(__v754) then return __ge((p.cash - x.m.price), mr) end return __v754 end)() end
end)), "sort", (function(a, b)  
do return (mv((b.m)) - mv((a.m))) end
end)), 0)
if (__t(fx2) and __ge(__S1.used((p)), __S1.SLOTS)) then worstFlex = __call(p.mach, "reduce", function(a, m, i)  
do return ((((not __t(a)) or ((not __t(flexy((m)))) and __t(flexy((a.m))))) or ((flexy((m)) == flexy((a.m))) and __lt(m.out, a.m.out))) and __mkO({["m"]=m, ["i"]=i}, {"m", "i"}) or a) end
end, (nil)) else worstFlex = worst end
if ((__t(bm) and (__lt(__S1.used((p)), __S1.SLOTS) or __t(worstFlex))) and (__lt(__S1.used((p)), __S1.SLOTS) or __ge(p.cash, __add(bm.m.price, __S1.gv(p, ("mFullCash")))))) then
do return (__S1.buy(G, bm.i, ((function() if __t(worstFlex) then return worstFlex.i end return nil end)()))) end
end
do return (false) end
end, ["adv"]=function()  
do return __S1.botAdvisor(G, (pi)) end
end, ["ing"]=function()  local d, short
d = __S1.deficit(G, (pi))
short = __add(__call(__S1.FAMS, "reduce", function(a, f)  
do return __add(a, __get(d, f)) end
end, (0)), d.any)
if __ge(p.cash, JS_Math.min(__S1.TAKE, (__S1.drawCost((p))))) then
local bp
bp = nil
for _, __v757 in __forof(__S1.FAMS) do
local __v758 = false
local f
f = __v757; 
repeat
local n, v
n = __len(__get(G.piles, f))
if (not __t(n)) then
do break end
end
if __t(__S1.PILE1) then v = __add((JS_Math.min(1, (__add(__get(d, f), d.any))) * 3), 0.6) else v = __add((JS_Math.min(n, (__add(__get(d, f), d.any))) * 3), (n * 0.6)) end
if ((not __t(bp)) or __gt(v, bp.v)) then
do bp = __mkO({["f"]=f, ["v"]=v}, {"f", "v"}) end
end
until true
if __v758 then break end
end
if (__t(fx2) and (not __t(__S1.ENV.FN))) then
local big
big = __get(__call(__call(__S1.FAMS, "filter", (function(f)  
do return __len(__get(G.piles, f)) end
end)), "sort", (function(a, b)  
do return (__len(__get(G.piles, b)) - __len(__get(G.piles, a))) end
end)), 0)
if (__t(big) and (__ge(__len(__get(G.piles, big)), 2) or __gt(short, 0))) then
do return (__S1.take(G, (big))) end
end
if ((((not __t(big)) and __gt(short, 0)) and __t((__S1.canDraw((G))).ok)) and __lt(__S1.handSize((p)), 2)) then
do return (__S1.draw((G))) end
end
elseif (__t(bp) and __ge(bp.v, __S1.gv(p, ("pileThr")))) then
do return (__S1.take(G, (bp.f))) end
end
if ((((not __t(fx2)) or __t(__S1.ENV.FN)) and __gt(short, 0)) and __t((__S1.canDraw((G))).ok)) then
do return (__S1.draw((G))) end
end
end
do return (false) end
end}, {"run", "res", "buy", "adv", "ing"})
order = __call(__call(__mkA({[0]="run", "res", "buy", "adv", ("ing"), __n=5}), "map", (function(k, j)  
do return __mkO({["k"]=k, ["w"]=(__S1.gv(p, (__get(__mkO({["run"]="pRun", ["res"]="pRes", ["buy"]="pBuy", ["adv"]="pAdv", ["ing"]="pIng"}, {"run", "res", "buy", "adv", "ing"}), k))) - (j * 0.000001))}, {"k", "w"}) end
end)), "sort", (function(a, b)  
do return (b.w - a.w) end
end))
for _, __v759 in __forof(order) do
local s
s = __v759; 
if __t(__get(steps, s.k)()) then
do return (true) end
end

end
near = (__ge(p.ctl, (__S1.FM - 2)) and __lt(__len(p.inf), __S1.FILECARDS))
if ((((__t(near) or ((__ge(__S1.gv(p, ("lobbyMap")), 0.5) and __lt(__len(p.inf), 2)) and __ge(p.ctl, 3))) and __t(calm((2)))) and __ge(p.cash, __add(__S1.INFC, __S1.gv(p, ("lobbyRes"))))) and __t((__S1.canLobby((G))).ok)) then
do return (__S1.lobby((G))) end
end
if (((((not __t(fx2)) or __t(__S1.ENV.FN)) and __ge(p.cash, __S1.gv(p, ("drawCash")))) and __t((__S1.canDraw((G))).ok)) and __lt(__S1.handSize((p)), __S1.gv(p, ("handCap")))) then
do return (__S1.draw((G))) end
end
do return (__S1.pass((G))) end
end
if (G.phase == "place") then
local b
if ((__ge(__len(p.inf), __S1.FILECARDS) and __ge(__S1.controlled(G, (pi)), __S1.FM)) and __t((__S1.canFile(G, (__call(p.inf, "map", (function(k)  
do return k.u end
end))))).ok)) then
do return (__S1.file(G, (__call(p.inf, "map", (function(k)  
do return k.u end
end))))) end
end
if __t(has(("contract"))) then
local b
b = __S1.bestCell(G, pi, (true))
if ((__t(b) and __gt(b.v, 0)) and __t(tryPlay("contract", (b.c.id)))) then
do return (true) end
end
end
if ((__t(has(("regime"))) and (G.limon ~= pi)) and __t(tryPlay(("regime")))) then
do return (true) end
end
if __t(has(("antitrust"))) then
local top
top = __get(__call(__call(__call(G.players, "map", (function(q, i)  
do return i end
end)), "filter", (function(i)  
do return (i ~= pi) end
end)), "sort", (function(a, b)  
do return (__S1.controlled(G, (b)) - __S1.controlled(G, (a))) end
end)), 0)
if ((top ~= nil) and __t(tryPlay("antitrust", (top)))) then
do return (true) end
end
end
if ((__t(has(("act"))) and __ge(__len(p.inf), __add(3, (function() if __ge(p.ctl, (__S1.FM - 2)) then return __S1.FILECARDS end return 0 end)()))) and __t(tryPlay(("act")))) then
do return (true) end
end
if (__t(has(("ha"))) and __gt(__len(p.inf), (function() if __ge(p.ctl, (__S1.FM - 2)) then return __S1.FILECARDS end return 0 end)())) then
local t
t = __get(__call(__call(G.map.cells, "filter", (function(c)  local o
o = __S1.ownerOf((c))
do return ((((o ~= nil) and (o ~= pi)) and __lt((__S1.toks(c, (o)) - 2), __add(__S1.toks(c, (pi)), 1)))) end
end)), "sort", (function(a, b)  
do return ((__get(G.players, __S1.ownerOf((b)))).ctl - (__get(G.players, __S1.ownerOf((a)))).ctl) end
end)), 0)
if (__t(t) and __t(tryPlay("ha", (t.id)))) then
do return (true) end
end
end
b = __S1.bestCell(G, pi, (false))
if __gt(p.imp, 0) then
local bi, safe
bi = nil
safe = __S1.gv(p, ("impSafe"))
for _, __v761 in __forof(G.map.cells) do
local __v762 = false
local c
c = __v761; 
repeat
local mine, top, v
if (not __t((__S1.canImprove(G, (c.id))).ok)) then
do break end
end
mine = __S1.toks(c, (pi))
top = JS_Math.max(__unpack(__spreadA({{v=0}, {s=__call(__call(JS_Object.keys((c.tok)), "filter", (function(k)  
do return (__num(k) ~= pi) end
end)), "map", (function(k)  
do return __get(c.tok, k) end
end))}})))
if __lt((mine - top), safe) then
do break end
end
v = __add((__get(__S1.yields((c)), (__T(c.imp) or 0)) * __S1.gv(p, ("impW"))), ((mine - top) * 0.3))
if ((not __t(bi)) or __gt(v, bi.v)) then
do bi = __mkO({["c"]=c, ["v"]=v}, {"c", "v"}) end
end
until true
if __v762 then break end
end
if (__t(bi) and (((not __t(b)) or __le(b.v, __S1.gv(p, ("gPlaceMin")))) or __ge(bi.v, b.v))) then
do return (__S1.improve(G, (bi.c.id))) end
end
end
if (__t(b) and __gt(b.v, __S1.gv(p, ("gPlaceMin")))) then
do return (__S1.place(G, (b.c.id))) end
end
do return (__S1.pass((G))) end
end
do return (false) end
end
__S1.snapP = function(G, i)  local p
p = __get(G.players, i)
do return (__mkO({["cash"]=p.cash, ["loy"]=p.loy, ["era"]=p.era, ["prog"]=p.prog, ["trk"]=__S1.trackLen((p)), ["stars"]=p.stars, ["cont"]=(__T(p.cont) or 0), ["imp"]=(__T(p.imp) or 0), ["tok"]=p.tok, ["hand"]=__S1.handS((p.hand)), ["mach"]=__call(__call(p.mach, "map", (function(m)  
do return m.id end
end)), "join", (",")), ["shelf"]=__call(__call((__T(p.shelf) or __mkA({__n=0})), "map", (function(m)  
do return m.id end
end)), "join", (",")), ["adv"]=__call(__call(p.adv, "map", (function(a)  
do return a.id end
end)), "join", (",")), ["res"]=__len((__T(p.tiles) or __mkA({__n=0}))), ["inf"]=__len((__T(p.inf) or __mkA({__n=0}))), ["ctl"]=__S1.controlled(G, (i)), ["inc"]=__add(__S1.income((__S1.controlled(G, (i)))), __S1.impIncome(G, (i))), ["jail"]=(__t(p.jail) and 1 or 0), ["rerun"]=(__T(p.rerun) or 0)}, {"cash", "loy", "era", "prog", "trk", "stars", "cont", "imp", "tok", "hand", "mach", "shelf", "adv", "res", "inf", "ctl", "inc", "jail", "rerun"})) end
end
__S1.recOn = function(G)  
if (((not __t(__S1.RECON)) or (not __t(G))) or (not __t(G.players))) then
do return (nil) end
end
if (not __t(G.rec)) then
do local __v763 = G; local __v764 = "rec"; local __v765 = __mkO({["v"]=__S1.RECV, ["t0"]=JS_Date.now(), ["from"]=G.round, ["ev"]=__mkA({__n=0}), ["rounds"]=__mkA({__n=0}), ["snap"]=__call(G.players, "map", (function(_, i)  
do return __S1.snapP(G, (i)) end
end)), ["heat"]=G.heat}, {"v", "t0", "from", "ev", "rounds", "snap", "heat"}); __set(__v763, __v764, __v765) end
end
do return (G.rec) end
end
__S1.recDelta = function(G)  local R, d
R = G.rec
d = __mkO({}, {})
__call(G.players, "forEach", (function(_, i)  local s, o, c, any
s = __S1.snapP(G, (i))
o = (__T(__get(R.snap, i)) or __mkO({}, {}))
c = __mkO({}, {})
any = false
for __v766 in __forin(s) do
local k
k = __v766; 
if (__get(s, k) ~= __get(o, k)) then
do local __v768 = c; local __v769 = k; local __v770 = __mkA({[0]=__get(o, k), (__get(s, k)), __n=2}); __set(__v768, __v769, __v770) end
do any = true end
end

end
if __t(any) then
do local __v771 = d; local __v772 = i; local __v773 = c; __set(__v771, __v772, __v773) end
end
do local __v774 = R.snap; local __v775 = i; local __v776 = s; __set(__v774, __v775, __v776) end
end))
if (G.heat ~= R.heat) then
do local __v777 = d; local __v778 = "heat"; local __v779 = __mkA({[0]=R.heat, (G.heat), __n=2}); __set(__v777, __v778, __v779) end
do local __v780 = R; local __v781 = "heat"; local __v782 = G.heat; __set(__v780, __v781, __v782) end
end
do return (d) end
end
__S1.recLog = function(G, p, text, kind)  local R, e, d
R = __S1.recOn((G))
if (not __t(R)) then
do return end
end
e = __mkO({["i"]=__len(R.ev), ["r"]=G.round, ["ph"]=G.phase, ["p"]=p, ["k"]=(__T(kind) or "news"), ["x"]=text}, {"i", "r", "ph", "p", "k", "x"})
d = __S1.recDelta((G))
if __t(__len(JS_Object.keys((d)))) then
do local __v783 = e; local __v784 = "d"; local __v785 = d; __set(__v783, __v784, __v785) end
end
if ((R.cur ~= nil) and (R.cur ~= nil)) then
do local __v786 = e; local __v787 = "in"; local __v788 = R.cur; __set(__v786, __v787, __v788) end
end
__call(R.ev, "push", (e))
end
__S1.recRound = function(G)  local R
R = __S1.recOn((G))
if (not __t(R)) then
do return end
end
__call(R.rounds, "push", (__mkO({["r"]=G.round, ["t"]=__S1.sec((R)), ["heat"]=G.heat, ["players"]=__call(G.players, "map", (function(p, i)  
do return __spreadO({{s=__S1.snapP(G, (i))}, {k="tiles", v=__call((__T(p.tiles) or __mkA({__n=0})), "map", (function(c)  
do return c.name end
end))}, {k="infc", v=__call((__T(p.inf) or __mkA({__n=0})), "map", (function(c)  
do return c.t end
end))}}) end
end)), ["map"]=__call(__call(G.map.cells, "filter", (function(c)  
do return (__T(__len(JS_Object.keys((c.tok)))) or c.imp) end
end)), "map", (function(c)  
do return __mkA({[0]=c.name, __S1.ownerOf((c)), c.tok, (__T(c.imp) or 0), (__S1.cellYield((c))), __n=5}) end
end)), ["mkt"]=__call(G.mkt, "map", (function(m)  
do return m.id end
end)), ["rrow"]=__call(G.rrow, "map", (function(c)  
do return (function() if __t(c) then return c.name end return nil end)() end
end)), ["arow"]=__call(G.arow, "map", (function(a)  
do return a.id end
end)), ["piles"]=__call(__call(__S1.FAMS, "map", (function(f)  
do return __len(__get(G.piles, f)) end
end)), "join", ("/")), ["deck"]=__len(G.deck), ["rdeck"]=__len(G.rdeck)}, {"r", "t", "heat", "players", "map", "mkt", "rrow", "arow", "piles", "deck", "rdeck"})))
end
__S1.traced = function(name, fn)  local spec
spec = __get(__S1.RECA, name)
do return (function(G, ...) local args = __pack(...); local R, drift, by, info, A, prev, res, d
if __t(__S1.recDepth) then R = nil else R = __S1.recOn((G)) end
if (not __t(R)) then
do return (fn(__unpack(__spreadA({{v=G}, {s=args}})))) end
end
drift = __S1.recDelta((G))
if __t(__len(JS_Object.keys((drift)))) then
__call(R.ev, "push", (__mkO({["i"]=__len(R.ev), ["r"]=G.round, ["ph"]=G.phase, ["p"]=nil, ["k"]="drift", ["d"]=drift}, {"i", "r", "ph", "p", "k", "d"})))
end
by = G.turn
info = __mkO({}, {})
do local __v789, __v790 = pcall(function()
do local __v791; if __t(spec.who) then __v791 = spec.who((G)) else __v791 = G.turn end by = __v791 end
do local __v792; if __t(spec.pre) then __v792 = spec.pre(__unpack(__spreadA({{v=G}, {s=args}}))) else __v792 = __mkO({}, {}) end info = __v792 end
end)
if not __v789 then
local err = __v790
do info = __mkO({["err"]=JS_String((err))}, {"err"}) end
end
end
A = __spreadO({{k="i", v=__len(R.ev)}, {k="r", v=G.round}, {k="ph", v=G.phase}, {k="p", v=by}, {k="a", v=name}, {k="t", v=__S1.sec((R))}, {k="hum", v=((__t(__get(G.players, by)) and (not __t((__get(G.players, by)).bot))) and 1 or 0)}, {s=info}})
__call(R.ev, "push", (A))
prev = R.cur
do local __v793 = R; local __v794 = "cur"; local __v795 = A.i; __set(__v793, __v794, __v795) end
do __S1.recDepth = __num(__S1.recDepth) + 1 end
res = nil
do local __v796, __v797 = pcall(function()
do res = fn(__unpack(__spreadA({{v=G}, {s=args}}))) end
end)
do __S1.recDepth = __num(__S1.recDepth) - 1 end
do local __v798 = R; local __v799 = "cur"; local __v800 = prev; __set(__v798, __v799, __v800) end
if not __v796 then error(__v797, 0) end
end
if ((not __t(res)) and (__len(R.ev) == __add(A.i, 1))) then
__call(R.ev, "pop")
do return (res) end
end
do local __v801, __v802 = pcall(function()
if __t(spec.post) then
JS_Object.assign(A, (spec.post((G))))
end
end)
if not __v801 then
local err = __v802

end
end
d = __S1.recDelta((G))
if __t(__len(JS_Object.keys((d)))) then
do local __v803 = A; local __v804 = "d"; local __v805 = d; __set(__v803, __v804, __v805) end
end
do return (res) end
end) end
end
__S1.recordText = function(G, build)  local R, fin, meta, lines
R = __S1.recOn((G))
if (not __t(R)) then
do return ("") end
end
fin = __call(G.players, "map", (function(p, i)  
do return __spreadO({{s=__S1.snapP(G, (i))}, {k="tiles", v=__call((__T(p.tiles) or __mkA({__n=0})), "map", (function(c)  
do return c.name end
end))}}) end
end))
meta = __mkO({["record"]=__S1.RECV, ["build"]=build, ["saved"]=__call(__new(JS_Date), "toISOString"), ["round"]=G.round, ["phase"]=G.phase, ["winner"]=G.winner, ["from"]=R.from, ["seconds"]=__S1.sec((R)), ["seats"]=__call(G.players, "map", (function(p, i)  
do return __mkO({["i"]=i, ["name"]=p.name, ["human"]=(not __t(p.bot)), ["style"]=(function() if __t(p.bot) then return p.spec end return nil end)()}, {"i", "name", "human", "style"}) end
end)), ["rules"]=__mkO({["DRAW"]=__S1.DRAW, ["KEEP"]=__S1.KEEP, ["TAKE"]=__S1.TAKE, ["CMAX"]=__S1.CMAX, ["WINNEED"]=__S1.WINNEED, ["IMPR"]=__S1.IMPR, ["IMPY"]=__S1.IMPY, ["IMPC"]=__S1.IMPC, ["IMPON"]=__S1.IMPON, ["RCHEAP"]=__S1.RCHEAP, ["SLOTS"]=__S1.SLOTS, ["MSIZE"]=G.map.size}, {"DRAW", "KEEP", "TAKE", "CMAX", "WINNEED", "IMPR", "IMPY", "IMPC", "IMPON", "RCHEAP", "SLOTS", "MSIZE"}), ["key"]="Lines after meta: \"round\" = the table at the start of each market; \"ev\" = an action (a, by player p, t seconds since the record began, hum 1 if a person) or a journal line (x). d = what changed, by player index: field: [before, after]. hand = sweet/sour/herb/fizz. inc = map income at payday. in = the action a journal line belongs to."}, {"record", "build", "saved", "round", "phase", "winner", "from", "seconds", "seats", "rules", "key"})
lines = __mkA({[0]=("SOUR EMPIRE GAME RECORD v" .. __str(__S1.RECV) .. " | build " .. __str((__T(build) or "?")) .. " | " .. __str(__len(G.players)) .. " players | round " .. __str(G.round) .. __str((function() if (G.winner ~= nil) then return __add(" | winner ", (__get(G.players, G.winner)).name) end return "" end)()) .. " | " .. __str(__len(R.ev)) .. " events"), (JS_JSON.stringify((__mkO({["meta"]=meta}, {"meta"})))), __n=2})
for _, __v806 in __forof(R.rounds) do
local r
r = __v806; 
__call(lines, "push", (JS_JSON.stringify((__mkO({["round"]=r}, {"round"})))))

end
for _, __v808 in __forof(R.ev) do
local e
e = __v808; 
__call(lines, "push", (JS_JSON.stringify((__mkO({["ev"]=e}, {"ev"})))))

end
__call(lines, "push", (JS_JSON.stringify((__mkO({["final"]=fin}, {"final"})))))
do return (__call(lines, "join", ("\n"))) end
end
__S1.ENV = (__T(((__typeof(JS_process) ~= "undefined") and JS_process.env)) or __mkO({}, {}))
__S1.num = function(k, d)  
do return (function() if (__get(__S1.ENV, k) ~= nil) then return __num(__get(__S1.ENV, k)) end return d end)() end
end
__S1.arr = function(k, d)  
do return __call(__call(JS_String(((__T(__get(__S1.ENV, k)) or d))), "split", (",")), "map", (JS_Number)) end
end
__S1.FAMS = __mkA({[0]="sweet", "sour", "herb", ("fizz"), __n=4})
__S1.FNAME = __mkO({["sweet"]="Sweet", ["sour"]="Acidic", ["herb"]="Botanical", ["fizz"]="Effervescent"}, {"sweet", "sour", "herb", "fizz"})
__S1.FDIR = __mkO({["sweet"]=__mkA({[0]=0, ((-1)), __n=2}), ["sour"]=__mkA({[0]=0, (1), __n=2}), ["herb"]=__mkA({[0]=(-1), (0), __n=2}), ["fizz"]=__mkA({[0]=1, (0), __n=2})}, {"sweet", "sour", "herb", "fizz"})
__S1.ARROW = __mkO({["sweet"]="↑", ["sour"]="↓", ["herb"]="←", ["fizz"]="→"}, {"sweet", "sour", "herb", "fizz"})
__S1.FLAVOR = __mkO({["sweet"]=__mkA({[0]="Strawberry", "Cane sugar", "Honey", "Peach", ("Watermelon"), __n=5}), ["sour"]=__mkA({[0]="Lemon", "Lime", "Grapefruit", "Yuzu", ("Tamarind"), __n=5}), ["herb"]=__mkA({[0]="Lavender", "Mint", "Basil", "Hibiscus", ("Rosemary"), __n=5}), ["fizz"]=__mkA({[0]="Soda water", "Ginger", "Tonic", "Seltzer", ("Kombucha"), __n=5})}, {"sweet", "sour", "herb", "fizz"})
__S1.PILE1 = __S1.num("PILE1", (1))
__S1.PERFAM = __S1.num("PF", (15))
__S1.DRAW = __S1.num("DRAW", (2))
__S1.TAKE = __S1.num("TAKE", (1))
__S1.KEEP = __S1.num("KEEP", (1))
__S1.MAXSTAR = 8
__S1.STARCASH = __S1.num("SC", (2))
__S1.TX = __S1.num("TX", (16))
__S1.ERAS = 12
__S1.OVER = __S1.num("OVER", (2))
__S1.LOYE = __S1.arr("LOYE", ("1,2,3,3,4,4,5,5,6,6,7,7"))
__S1.XG = __S1.num("XG", (0))
__S1.ONE = __S1.num("ONE", (0))
__S1.CMAX = __S1.num("CMAX", (4))
__S1.CC = __S1.num("CC", (1))
__S1.trackLen = function(p)  
do return JS_Math.max(3, (((__add(__S1.TX, (__S1.XG * (p.era - 1))) - JS_Math.floor(((p.stars / 2)))) - (__T(p.cont) or 0)))) end
end
__S1.INCB = __S1.num("INCB", (3))
__S1.INCK = __S1.num("INCK", (1))
__S1.SAULD = __S1.num("SAULD", (1))
__S1.income = function(k)  
do return __add(__S1.INCB, (__S1.INCK * k)) end
end
__S1.IMPR = __S1.arr("IMPR", ("0,1,1,2"))
__S1.IMPY = __S1.arr("IMPY", ("1,2,3"))
__S1.IMPC = __S1.num("IMPC", (1))
__S1.IMPON = __S1.num("IMPON", (1))
__S1.RCHEAP = __S1.num("RCHEAP", (0))
__S1.yields = function(c)  
do return (__T(c.yield) or __mkA({[0]=0, 0, (0), __n=3})) end
end
__S1.cellYield = function(c)  
do return __call(__call(__S1.yields((c)), "slice", 0, ((__T(c.imp) or 0))), "reduce", function(a, b)  
do return __add(a, b) end
end, (0)) end
end
__S1.impIncome = function(G, pi)  
do return __call(G.map.cells, "reduce", function(a, c)  
do return __add(a, (function() if (__S1.ownerOf((c)) == pi) then return __S1.cellYield((c)) end return 0 end)()) end
end, (0)) end
end
__S1.CASH0 = __S1.num("CASH0", (6))
__S1.LOY0 = __S1.num("LOY0", (3))
__S1.TOKN = __S1.num("TOKN", (20))
__S1.INFC = __S1.num("INFC", (2))
__S1.BAILB = 4
__S1.WIN = (__T(__S1.ENV.WIN) or "era")
__S1.MSIZE = __S1.arr("MSZ", ("0,5,5,6,7"))
__S1.FM = __S1.num("FM", (11))
__S1.FILECARDS = 3
__S1.MAXROUND = __S1.num("MAXR", (15))
__S1.SLOTS = 3
__S1.MKT = 4
__S1.BANDS = __mkA({[0]=__mkO({["name"]="Lemonade Stand", ["title"]="Founder, age 9", ["coin"]="$1", ["from"]=0}, {"name", "title", "coin", "from"}), __mkO({["name"]="Regional Enterprise", ["title"]="Managing Partner", ["coin"]="$100", ["from"]=3}, {"name", "title", "coin", "from"}), __mkO({["name"]="National Brand", ["title"]="Chief Executive", ["coin"]="$10,000", ["from"]=5}, {"name", "title", "coin", "from"}), (__mkO({["name"]="Sovereign Interest", ["title"]="Chairman for Life", ["coin"]="$1,000,000", ["from"]=7}, {"name", "title", "coin", "from"})), __n=4})
__call(__mkA({[0]=1, 4, 7, (10), __n=4}), "forEach", (function(v, i)  
do return (function() local __v811 = __get(__S1.BANDS, i); local __v812 = "from"; local __v810 = v; __set(__v811, __v812, __v810) return __v810 end)() end
end))
__S1.TOL = __S1.arr("TOL", ("2,3,5,8"))
__S1.bandOf = function(era)  local rec, b
rec = era
b = 0
__call(__S1.BANDS, "forEach", (function(x, i)  
if __ge(rec, x.from) then
do b = i end
end
end))
do return (b) end
end
__S1.M = function(id, tier, name, price, inp, out, xtra, note)  
do return __mkO({["id"]=id, ["tier"]=tier, ["name"]=name, ["price"]=price, ["inp"]=inp, ["out"]=out, ["xtra"]=(__T(xtra) or __mkO({}, {})), ["note"]=(__T(note) or "")}, {"id", "tier", "name", "price", "inp", "out", "xtra", "note"}) end
end
__S1.START = __S1.M("hands", 0, "Bare hands", 0, __mkA({[0]=("sour"), __n=1}), (2))
__S1.MACHINES = __mkA({[0]=__S1.M("blender", 1, "Kitchen blender", 4, __mkA({[0]="any", ("any"), __n=2}), (4)), __S1.M("juicer", 1, "Hand juicer", 3, __mkA({[0]=("sour"), __n=1}), (3)), __S1.M("sugarpot", 1, "Sugar pot", 3, __mkA({[0]=("sweet"), __n=1}), (3)), __S1.M("herbjar", 1, "Herb jar", 3, __mkA({[0]=("herb"), __n=1}), (3)), __S1.M("siphon", 1, "Soda siphon", 3, __mkA({[0]=("fizz"), __n=1}), (3)), __S1.M("squeezer", 1, "Lemon squeezer", 5, __mkA({[0]="sour", ("sour"), __n=2}), (6)), __S1.M("icechest", 1, "Ice chest", 4, __mkA({[0]=("any"), __n=1}), 1, (__mkO({["cash"]=1}, {"cash"}))), __S1.M("garage", 2, "Garage line", 7, __mkA({[0]="sour", ("sweet"), __n=2}), (7)), __S1.M("muddler", 2, "Mint muddler", 7, __mkA({[0]="herb", ("sour"), __n=2}), (7)), __S1.M("fizzrig", 2, "Fizz rig", 7, __mkA({[0]="fizz", ("sour"), __n=2}), (7)), __S1.M("coldpress", 2, "Cold press", 8, __mkA({[0]="any", ("any"), __n=2}), (6)), __S1.M("wagon", 2, "Delivery wagon", 6, __mkA({[0]=("sour"), __n=1}), 2, (__mkO({["cash"]=2}, {"cash"}))), __S1.M("binder", 2, "Recipe binder", 6, __mkA({[0]=("sweet"), __n=1}), 3, (__mkO({["card"]=1}, {"card"}))), __S1.M("concentrate", 2, "Frozen concentrate", 7, __mkA({__n=0}), (2)), __S1.M("bottling", 3, "Bottling line", 11, __mkA({[0]="sour", ("sweet"), __n=2}), (9)), __S1.M("still", 3, "Botanical still", 11, __mkA({[0]="herb", ("sour"), __n=2}), (9)), __S1.M("carbonator", 3, "Carbonation plant", 11, __mkA({[0]="fizz", ("sour"), __n=2}), (9)), __S1.M("plant2", 3, "Second plant", 12, __mkA({[0]="any", ("any"), __n=2}), (7)), __S1.M("franchise", 3, "Franchise kit", 10, __mkA({[0]="sweet", ("sour"), __n=2}), 8, (__mkO({["inf"]=1}, {"inf"}))), __S1.M("works", 3, "Concentrate works", 10, __mkA({[0]=("sour"), __n=1}), (5)), __S1.M("lightsout", 4, "Lights-out factory", 16, __mkA({[0]="sour", ("sweet"), __n=2}), (12)), __S1.M("ftz", 4, "Free-trade zone", 15, __mkA({[0]="any", ("any"), __n=2}), (9)), __S1.M("synthetic", 4, "Synthetic flavor lab", 14, __mkA({__n=0}), 5, __mkO({["heat"]=1}, {"heat"}), ("Every run adds 1 Heat to the table.")), __S1.M("global", 4, "Global bottler", 17, __mkA({[0]="sweet", "herb", ("fizz"), __n=3}), (18)), __S1.M("contract", 4, "Contract manufacturer", 14, __mkA({[0]=("any"), __n=1}), 4, (__mkO({["cash"]=2}, {"cash"}))), (__S1.M("skunk", 4, "Skunkworks", 15, __mkA({[0]="herb", ("fizz"), __n=2}), 11, (__mkO({["card"]=1}, {"card"})))), __n=26})
__S1.MP = __S1.arr("MP", ("0,0,0,0,0"))
__S1.MO = __S1.arr("MO", ("0,0,0,0,0"))
__call(__S1.MACHINES, "forEach", (function(m)  
do local __v813 = m; local __v814 = "price"; local __v815 = __add(__get(__v813, __v814), __get(__S1.MP, m.tier)); __set(__v813, __v814, __v815) end
do local __v816 = m; local __v817 = "out"; local __v818 = __add(__get(__v816, __v817), __get(__S1.MO, m.tier)); __set(__v816, __v817, __v818) end
end))
__S1.MCASH = __S1.num("MCASH", (1))
__S1.MCT = __S1.num("MCT", (1))
if __t(__S1.MCASH) then
__call(__S1.MACHINES, "forEach", (function(m)  
if (__ge(m.tier, 1) and __le(m.tier, __S1.MCT)) then
do local __v819 = m; local __v820 = "xtra"; local __v821 = __spreadO({{s=m.xtra}, {k="cash", v=__add((__T(m.xtra.cash) or 0), __S1.MCASH)}}); __set(__v819, __v820, __v821) end
end
end))
end
if __t(__S1.num("MCB", (1))) then
do local __v822 = __S1.START; local __v823 = "xtra"; local __v824 = __mkO({["cash"]=__S1.num("MCB", (1))}, {"cash"}); __set(__v822, __v823, __v824) end
end
__S1.AP = __S1.num("AP", (0))
__S1.NIP = __S1.num("NIP", (0))
__S1.A = function(id, tag, price, name, role, who, text, o)  
do return JS_Object.assign(__mkO({["id"]=id, ["tag"]=tag, ["price"]=price, ["name"]=name, ["role"]=role, ["who"]=who, ["text"]=text, ["era"]=1, ["cc"]=(function() if __t(__S1.CC) then return (__ge(price, 6) and 2 or 1) end return 0 end)()}, {"id", "tag", "price", "name", "role", "who", "text", "era", "cc"}), ((__T(o) or __mkO({}, {})))) end
end
__S1.ADVISORS = __mkA({[0]=__S1.A("cfo", "all", 6, "Jordan Jekko", "Chief Financial Officer", "Thinks lunch is for wimps.", ("Your first buy-three each market costs 1 Capital less.")), __S1.A("tina", "all", 7, "Tina", "Chief of Staff", "Runs your calendar, and you.", ("Whenever you pass in the market, draw an ingredient card.")), __S1.A("swamp", "dis", 8, "Deep Swamp Creature", "Lobbyist", "Has resisted every attempt to drain it.", ("Draw an influence card when the market opens in every third round. Its Heat counts.")), __S1.A("saul", "dis", 4, "Your Lawyer, Saul", "Special Counsel", "Advertises on bus benches.", ("At every payday, +1 Capital for each Heat on the table.")), __S1.A("elle", "dis", 2, "Elle W.", "General Counsel", "Got into Harvard Law. What, like it's hard?", ("While she is on anyone's floor, the raid line sits one band lower for the whole table.")), __S1.A("cop", "dis", 2, "A Mall Cop", "Head of Security", "Takes the job very seriously.", "Rivals pay 1 more loyalty to place a token in a market you control.", (__mkO({["ms"]="def"}, {"ms"}))), __S1.A("chad", "all", 0, "Your Cousin, Chad", "Vice President", "Needed a job. Your aunt called.", ("Free to retain. +1 Capital at every payday.")), __S1.A("boogey", "all", 6, "The Boogeyman", "Consultant", "Was retired, briefly.", "Once a round, as your turn, make a rival's advisor disappear for good. +1 Heat each time.", (__mkO({["era"]=7, ["price"]=6}, {"era", "price"}))), __S1.A("liz", "prd", 6, "Elizabeth H.", "Chief Technology Officer", "A slight résumé gap.", ("Every research costs one wildcard card fewer. Every research adds 2 Heat.")), __S1.A("raman", "prd", 3, "Priya Raman", "Head of R&D", "Holds 40 patents, none for lemonade.", ("In every research, up to 2 named families your shelf lacks can be paid with cards instead.")), __S1.A("kevin", "prd", 6, "Kevin", "Chief Innovation Officer", "Has a podcast. You have been on it.", ("Every whole star you discover also pays 2 loyalty.")), __S1.A("grad", "mfg", 7, "A Recent Graduate", "Plant Manager", "Has read about the Toyota Production System.", ("One machine may run a second time each round.")), __S1.A("hal", "mfg", 7, "HAL 8000", "Chief Automation Officer", "An earlier, more indifferent model.", ("Once a round, run a machine without its cards. It makes 2 fewer pitchers.")), __S1.A("paul", "mfg", 2, "Your Neighbor, Paul", "VP of Operations", "Refers to lemons as \"human money.\"", ("At every payday, +1 Capital for each Acidic card in your hand. You keep the cards.")), __S1.A("tanner", "dis", 0, "Tanner", "Chief Marketing Officer", "Refers to customers as \"the audience.\"", ("Works on commission: free to retain. +1 loyalty every round. At every payday he takes half your income, rounded up.")), __S1.A("becky", "dis", 3, "Becky from the PTA", "VP of Sales", "Has already sold to your mother.", "While you control your home market, it counts as two markets.", (__mkO({["ms"]="def"}, {"ms"}))), __S1.A("realtor", "dis", 5, "A Local Realtor", "President, Global Markets", "Describes every market as \"up-and-coming.\"", "Distance never costs more than 2 extra loyalty. Every token placed 3 or more steps out adds 1 Heat.", (__mkO({["ms"]="grow"}, {"ms"}))), __S1.A("dwarf", "dis", 7, "Brokk Stonebeard", "Chief Mountain Officer", "A dwarf. Has never once been asked to leave.", "You pay no surcharge on rugged ground. At every payday, +2 Capital for each rugged market you control.", (__mkO({["ms"]="def"}, {"ms"}))), __S1.A("qa", "dis", 8, "Quality Assurance", "Department of One", "Checks every cup twice.", "At every payday, +1 pitcher for each market holding 2 or more of your tokens, up to 4.", (__mkO({["ms"]="def"}, {"ms"}))), __S1.A("raider", "dis", 3, "A Corporate Raider", "Head of Acquisitions", "Wears suspenders without irony.", "+3 Capital each time you take a market that a rival controlled.", (__mkO({["ms"]="atk"}, {"ms"}))), __S1.A("lawyer2", "dis", 2, "A Litigator", "Outside Counsel", "Bills in six-minute increments.", "When a contested market you lead is settled, you lose none of your tokens.", (__mkO({["ms"]="atk"}, {"ms"}))), __S1.A("pioneer", "dis", 8, "A Pioneer", "Director of New Territories", "Owns a covered wagon. It is a minivan.", "+1 Capital each time you place a token in an empty market.", (__mkO({["ms"]="grow"}, {"ms"}))), __S1.A("franchise", "dis", 6, "A Franchise Consultant", "VP of Expansion", "Has a binder for everything.", "A market holding 2 of your tokens is an outpost, instead of 3.", (__mkO({["ms"]="grow"}, {"ms"}))), (__S1.A("rhonda", "dis", 7, "Rhonda", "Regional Sales Director", "Has never once taken no for an answer.", "Placing a token in a market a rival controls costs 2 loyalty less.", (__mkO({["ms"]="atk"}, {"ms"})))), __n=24})
__S1.ROW = 3
__S1.POACH = __S1.num("POACH", (2))
__S1.ADV = __S1.num("ADV", (1))
__S1.hasA = function(p, id)  
do return (not (not (__t(p.adv) and __t(__call(p.adv, "some", (function(a)  
do return (a.id == id) end
end)))))) end
end
__S1.used = function(p)  
do return __add(__len(p.mach), (__t(__S1.num("FREESLOT", (0))) and 0 or __len(p.adv))) end
end
__call(__S1.MACHINES, "forEach", (function(m)  
do local __v825 = m; local __v826 = "out"; local __v827 = (__get(__v825, __v826) - __add(__add((__S1.AP * __len(__call(m.inp, "filter", (function(f)  
do return (f == "any") end
end)))), (function() if __t(__call(m.inp, "includes", ("any"))) then return __S1.num("AM", (0)) end return 0 end)()), (__t(__len(m.inp)) and 0 or __S1.NIP))); __set(__v825, __v826, __v827) end
do local __v828 = m; local __v829 = "out"; local __v830 = JS_Math.max(1, (m.out)); __set(__v828, __v829, __v830) end
end))
__S1.MAT = 5
__S1.MID = 2
__S1.R = function(st, get)  
do return __mkO({["st"]=st, ["get"]=(__T(get) or __mkO({}, {}))}, {"st", "get"}) end
end
__S1.TS = __S1.arr("TS", ("6,3"))
__S1.BLANK = __mkA({[0]=__mkO({["cash"]=2}, {"cash"}), __mkO({["card"]=1}, {"card"}), __mkO({["out"]=3}, {"out"}), __mkO({["cash"]=3}, {"cash"}), __mkO({["inf"]=1}, {"inf"}), __mkO({["calm"]=2}, {"calm"}), __mkO({["cash"]=3}, {"cash"}), __mkO({["card"]=2}, {"card"}), __mkO({["out"]=4}, {"out"}), __mkO({["cash"]=2}, {"cash"}), __mkO({["cash"]=2}, {"cash"}), __mkO({["card"]=1}, {"card"}), __mkO({["out"]=3}, {"out"}), __mkO({["cash"]=3}, {"cash"}), __mkO({["cash"]=1}, {"cash"}), __mkO({["card"]=1}, {"card"}), __mkO({["out"]=3}, {"out"}), __mkO({["cash"]=2}, {"cash"}), __mkO({["cash"]=2}, {"cash"}), __mkO({["card"]=1}, {"card"}), __mkO({["cash"]=2}, {"cash"}), __mkO({["out"]=2}, {"out"}), __mkO({["card"]=1}, {"card"}), (__mkO({["cash"]=1}, {"cash"})), __n=24})
__S1.BLANK2 = __mkA({[0]=__mkO({["out"]=3}, {"out"}), __mkO({["free"]=1}, {"free"}), __mkO({["rerun"]=1}, {"rerun"}), __mkO({["out"]=4}, {"out"}), __mkO({["inf"]=1}, {"inf"}), __mkO({["free"]=1}, {"free"}), __mkO({["out"]=3}, {"out"}), __mkO({["rerun"]=1}, {"rerun"}), __mkO({["calm"]=2}, {"calm"}), __mkO({["out"]=4}, {"out"}), __mkO({["free"]=1}, {"free"}), __mkO({["rerun"]=1}, {"rerun"}), __mkO({["out"]=3}, {"out"}), __mkO({["free"]=1}, {"free"}), __mkO({["out"]=2}, {"out"}), __mkO({["rerun"]=1}, {"rerun"}), __mkO({["out"]=3}, {"out"}), __mkO({["inf"]=1}, {"inf"}), __mkO({["free"]=1}, {"free"}), __mkO({["out"]=4}, {"out"}), __mkO({["rerun"]=1}, {"rerun"}), __mkO({["out"]=3}, {"out"}), __mkO({["free"]=1}, {"free"}), (__mkO({["calm"]=2}, {"calm"})), __n=24})
if __t(__S1.num("RRW", (1))) then
__call(__S1.BLANK, "splice", __unpack(__spreadA({{v=0}, {v=__len(__S1.BLANK)}, {s=__S1.BLANK2}})))
end
__S1.PAIRS = __mkA({[0]=__mkA({[0]="sweet", ("sour"), __n=2}), __mkA({[0]="sweet", ("herb"), __n=2}), __mkA({[0]="sweet", ("fizz"), __n=2}), __mkA({[0]="sour", ("herb"), __n=2}), __mkA({[0]="sour", ("fizz"), __n=2}), (__mkA({[0]="herb", ("fizz"), __n=2})), __n=6})
__S1.CONDS = __mkO({["home5"]="you have at least 5 tokens on your home market", ["small5"]="you control fewer than 5 markets", ["deep3"]="at least 2 markets hold 2 or more of your tokens", ["nohot"]="you control no hot spot", ["noadv"]="you have no advisors"}, {"home5", "small5", "deep3", "nohot", "noadv"})
__S1.RNAME = __mkO({["st1"]="A better recipe", ["st2"]="A breakthrough", ["st3"]="A signature formula", ["st4"]="A legendary formula", ["out"]="A production trick", ["free"]="An automation", ["rerun"]="A double shift", ["inf"]="A useful contact", ["bonus"]="A lab notebook"}, {"st1", "st2", "st3", "st4", "out", "free", "rerun", "inf", "bonus"})
__S1.ANYC = __S1.num("ANYC", (1))

__S1.WINNEED = __S1.num("WINNEED", (5))
__S1.RROW = 4
__S1.ABOARD = 4
__S1.PDISC = __S1.num("PDISC", (2))
__S1.WINCARD = __mkO({["kind"]="res", ["id"]="rwin", ["tier"]=5, ["win"]=true, ["cost"]=__mkO({["sweet"]=__S1.num("WINC", (2)), ["sour"]=__S1.num("WINC", (2)), ["herb"]=__S1.num("WINC", (2)), ["fizz"]=__S1.num("WINC", (2)), ["any"]=__S1.num("WINW", (8))}, {"sweet", "sour", "herb", "fizz", "any"}), ["st"]=0, ["get"]=__mkO({}, {}), ["name"]="The Secret Formula"}, {"kind", "id", "tier", "win", "cost", "st", "get", "name"})
__S1.advTier = function(a)  
do return (__gt(a.era, 1) and 4 or (__le(a.price, 2) and 1 or (__le(a.price, 4) and 2 or (__le(a.price, 6) and 3 or 4)))) end
end

__S1.TILESET = __spreadA({{s=__call(__call(JS_Array((__get(__S1.TS, 0))), "fill", (0)), "map", (function()  
do return __S1.R((1)) end
end))}, {s=__call(__call(JS_Array((__get(__S1.TS, 1))), "fill", (0)), "map", (function()  
do return __S1.R((2)) end
end))}, {s=__call(__call(__S1.BLANK, "slice", 0, (((24 - __get(__S1.TS, 0)) - __get(__S1.TS, 1)))), "map", (function(g)  
do return __S1.R(0, (g)) end
end))}})
__S1.ICARD = __mkO({["recall"]=__mkO({["name"]="Product recall", ["text"]="A rival takes up to 5 pitchers off its era track.", ["target"]="player"}, {"name", "text", "target"}), ["ha"]=__mkO({["name"]="Hostile acquisition", ["text"]="Remove up to 2 rival tokens from one market.", ["target"]="cell"}, {"name", "text", "target"}), ["judge"]=__mkO({["name"]="A friendly judge", ["text"]="Put the judge on call. The next time you would be raided, you are not: the table's Heat falls to 1 instead."}, {"name", "text"}), ["subsidy"]=__mkO({["name"]="Subsidy", ["text"]="Gain 4 Capital."}, {"name", "text"}), ["contract"]=__mkO({["name"]="Government contract", ["text"]="Place one loyalty token from the bank in any market, at no cost to you.", ["target"]="cell"}, {"name", "text", "target"}), ["spy"]=__mkO({["name"]="Industrial espionage", ["text"]="Take 2 ingredient cards at random from a rival's hand.", ["target"]="player"}, {"name", "text", "target"}), ["reverse"]=__mkO({["name"]="Reverse engineering", ["text"]="Choose a research card in a rival's hand that nobody has copied. Collect its reward as well. The rival keeps the card.", ["target"]="rtile"}, {"name", "text", "target"}), ["leak"]=__mkO({["name"]="Kept memo", ["text"]="Choose a research card in a rival's hand that nobody has copied. Collect its reward as well, then risk Heat as with a villainous option.", ["target"]="rtile", ["memo"]=true}, {"name", "text", "target", "memo"}), ["patent"]=__mkO({["name"]="Patent", ["text"]="Research a card in the row: this card counts as any one ingredient.", ["target"]="tile"}, {"name", "text", "target"}), ["viral"]=__mkO({["name"]="Viral campaign", ["text"]="Gain 3 loyalty."}, {"name", "text"}), ["act"]=__mkO({["name"]="Act of Congress", ["text"]="Discard 2 more cards. Remove 1 rival token from each of up to 3 markets next to ones you control.", ["extra"]=2}, {"name", "text", "extra"}), ["formula"]=__mkO({["name"]="Stolen formula", ["text"]="Choose the company controlling the most markets, if that is more than you control. It loses half a star, and you gain it.", ["target"]="player", ["leader"]=true}, {"name", "text", "target", "leader"}), ["antitrust"]=__mkO({["name"]="Antitrust suit", ["text"]="Choose the company controlling the most markets, if that is more than you control. Remove 1 of its tokens from each of its 3 thinnest markets.", ["target"]="player", ["leader"]=true}, {"name", "text", "target", "leader"}), ["proxy"]=__mkO({["name"]="Proxy vote", ["text"]="Regain 2 control, up to 4."}, {"name", "text"}), ["buyback"]=__mkO({["name"]="Share buyback", ["text"]="Pay 4 Capital. Regain all your control, up to 4."}, {"name", "text"}), ["regime"]=__mkO({["name"]="Regime change", ["text"]="San Limón counts as one market you control at every payday, until someone else plays this."}, {"name", "text"})}, {"recall", "ha", "judge", "subsidy", "contract", "spy", "reverse", "leak", "patent", "viral", "act", "formula", "antitrust", "proxy", "buyback", "regime"})
__S1.IDECK = __mkO({["recall"]=__mkA({[0]=0, 0, 1, 1, 1, (2), __n=6}), ["ha"]=__mkA({[0]=0, 0, 0, 1, 1, 1, 1, (2), __n=8}), ["judge"]=__mkA({[0]=0, 0, (1), __n=3}), ["subsidy"]=__mkA({[0]=0, 0, 1, (1), __n=4}), ["contract"]=__mkA({[0]=0, 0, 1, (1), __n=4}), ["spy"]=__mkA({[0]=0, 1, (1), __n=3}), ["reverse"]=__mkA({[0]=0, 1, (1), __n=3}), ["patent"]=__mkA({[0]=0, 1, 1, (2), __n=4}), ["viral"]=__mkA({[0]=0, 1, (1), __n=3}), ["proxy"]=__mkA({[0]=0, 1, (1), __n=3}), ["buyback"]=__mkA({[0]=0, (1), __n=2}), ["act"]=__mkA({[0]=1, (2), __n=2}), ["regime"]=__mkA({[0]=1, (2), __n=2}), ["formula"]=__S1.arr("IFO", ("0,1,1,2")), ["antitrust"]=__S1.arr("IAT", ("1,1,2"))}, {"recall", "ha", "judge", "subsidy", "contract", "spy", "reverse", "patent", "viral", "proxy", "buyback", "act", "regime", "formula", "antitrust"})
__S1.MEMOS = __mkA({__n=0})
__S1.memo = function(title, body, opts)  
do return __call(__S1.MEMOS, "push", (__mkO({["id"]=__len(__S1.MEMOS), ["title"]=title, ["body"]=body, ["opts"]=opts}, {"id", "title", "body", "opts"}))) end
end
__S1.memo("Competitive entry", "Tyler (8) has opened a competing stand directly across the street. His sign is better than yours.", (__mkA({[0]=__mkO({["label"]="Ignore him and focus on the core business", ["gain"]=__mkO({["cash"]=2}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Inform his mother of the sugar content", ["gain"]=__mkO({["card"]=2}, {"card"}), ["note"]="He is grounded. His lemons are yours."}, {"label", "gain", "note"}), __mkO({["label"]="Tell the street his lemonade had a bug in it", ["gain"]=__mkO({["cash"]=3, ["loy"]=2}, {"cash", "loy"}), ["risk"]=1, ["note"]="It did, briefly."}, {"label", "gain", "risk", "note"}), (__mkO({["label"]="Keep this memo. Find out what is in Tyler's recipe later", ["keep"]="leak", ["note"]="Kept with your influence cards."}, {"label", "keep", "note"})), __n=4})))
__S1.memo("Regulatory inquiry", "Mrs. Okafor at number 14 has asked whether you \"have a permit for this.\"", (__mkA({[0]=__mkO({["label"]="Offer her a complimentary cup", ["gain"]=__mkO({["loy"]=2}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Read the municipal code", ["gain"]=__mkO({["cash"]=3}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Draw her a permit in crayon", ["gain"]=__mkO({["cash"]=5}, {"cash"}), ["risk"]=1, ["note"]="It is very convincing."}, {"label", "gain", "risk", "note"}), (__mkO({["label"]="Keep this memo. Ask to see the other stands' permits later", ["keep"]="leak", ["note"]="Kept with your influence cards."}, {"label", "keep", "note"})), __n=4})))
__S1.memo("Staffing", "Your little brother would like a job. He is six.", (__mkA({[0]=__mkO({["label"]="Hire him, paid in candy", ["gain"]=__mkO({["out"]=4}, {"out"})}, {"label", "gain"}), __mkO({["label"]="Tell him to come back when he is seven", ["gain"]=__mkO({["cash"]=3}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Pay him in play money from the board game closet", ["gain"]=__mkO({["out"]=4, ["cash"]=2}, {"out", "cash"}), ["risk"]=1, ["note"]="He will find out eventually."}, {"label", "gain", "risk", "note"}), (__mkO({["label"]="Keep this memo. Send him to watch the other stands later", ["keep"]="leak", ["note"]="Kept with your influence cards."}, {"label", "keep", "note"})), __n=4})))
__S1.memo("Weather", "The forecast calls for a heat wave. Everyone on the street will be thirsty.", (__mkA({[0]=__mkO({["label"]="Make extra and hope", ["gain"]=__mkO({["out"]=4}, {"out"})}, {"label", "gain"}), __mkO({["label"]="Raise prices for the weekend", ["gain"]=__mkO({["cash"]=4}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Turn off Tyler's garden hose", ["gain"]=__mkO({["out"]=4, ["cash"]=3}, {"out", "cash"}), ["risk"]=1, ["note"]="He has a lot of explaining to do."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Formation", "Your father says that if this continues you will need \"an LLC or something.\"", (__mkA({[0]=__mkO({["label"]="File the paperwork", ["cost"]=__mkO({["cash"]=2}, {"cash"}), ["gain"]=__mkO({["loy"]=2, ["cont"]=2}, {"loy", "cont"})}, {"label", "cost", "gain"}), __mkO({["label"]="Remain informal", ["gain"]=__mkO({["cash"]=4}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Register the company in the dog's name", ["gain"]=__mkO({["cash"]=4, ["card"]=2}, {"cash", "card"}), ["risk"]=1, ["note"]="Biscuit has excellent credit."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Inspection", "The county health inspector has questions about the garage.", (__mkA({[0]=__mkO({["label"]="Bring the facility up to code", ["cost"]=__mkO({["cash"]=2}, {"cash"}), ["gain"]=__mkO({["card"]=3}, {"card"})}, {"label", "cost", "gain"}), __mkO({["label"]="Learn what the inspector likes to drink", ["gain"]=__mkO({["cash"]=4}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Photograph the inspector at the racetrack", ["gain"]=__mkO({["cash"]=7}, {"cash"}), ["risk"]=1, ["note"]="He has no further questions."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Press", "The Gazette would like to profile \"the lemonade kid.\"", (__mkA({[0]=__mkO({["label"]="Sit for the interview", ["gain"]=__mkO({["loy"]=3}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Decline and work the weekend", ["gain"]=__mkO({["out"]=6}, {"out"})}, {"label", "gain"}), (__mkO({["label"]="Give the reporter a story about Tyler's stand", ["gain"]=__mkO({["loy"]=4, ["cash"]=3}, {"loy", "cash"}), ["risk"]=1, ["note"]="Tyler's family moves to Ohio."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Franchise inquiry", "A girl two streets over would like to sell your lemonade under your name.", (__mkA({[0]=__mkO({["label"]="Grant her a franchise", ["gain"]=__mkO({["loy"]=4}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Charge her a fee", ["gain"]=__mkO({["cash"]=5}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Grant it, then open next to her", ["gain"]=__mkO({["loy"]=4, ["cash"]=4}, {"loy", "cash"}), ["risk"]=1, ["note"]="She is learning a valuable lesson."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Supply", "A citrus wholesaler offers you terms.", (__mkA({[0]=__mkO({["label"]="Sign the contract", ["gain"]=__mkO({["card"]=4}, {"card"})}, {"label", "gain"}), __mkO({["label"]="Negotiate a cash rebate", ["gain"]=__mkO({["cash"]=5}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Take delivery and lose the invoice", ["gain"]=__mkO({["card"]=5, ["cash"]=3}, {"card", "cash"}), ["risk"]=1, ["note"]="Accounts payable is your brother."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Trademark", "A pizza chain called Sour Empire has sent a letter.", (__mkA({[0]=__mkO({["label"]="Settle", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["loy"]=3, ["cont"]=1}, {"loy", "cont"})}, {"label", "cost", "gain"}), __mkO({["label"]="Rebrand the pizza chain", ["gain"]=__mkO({["card"]=4}, {"card"})}, {"label", "gain"}), (__mkO({["label"]="File first, backdate it", ["gain"]=__mkO({["cash"]=8}, {"cash"}), ["risk"]=1, ["note"]="Your notary is very understanding."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Listing", "Three banks have offered to take the company public. All three sent fruit baskets. None contained lemons.", (__mkA({[0]=__mkO({["label"]="Ring the bell", ["gain"]=__mkO({["cash"]=8}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Stay private", ["gain"]=__mkO({["cont"]=2, ["card"]=1}, {"cont", "card"})}, {"label", "gain"}), (__mkO({["label"]="Ring the bell, and round the numbers up", ["gain"]=__mkO({["cash"]=11}, {"cash"}), ["risk"]=1, ["note"]="The auditors are on a boat."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Bad batch", "Customers report that the new formula tastes faintly of pennies.", (__mkA({[0]=__mkO({["label"]="Pull the batch", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["loy"]=6}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Call it a limited edition", ["gain"]=__mkO({["cash"]=7}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Ship it to schools", ["gain"]=__mkO({["cash"]=10}, {"cash"}), ["risk"]=1, ["note"]="Children do not write reviews."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Labor", "Employees at the bottling plant are passing around a card.", (__mkA({[0]=__mkO({["label"]="Recognize the union", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["loy"]=6}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Retain a firm that specializes in this", ["gain"]=__mkO({["inf"]=2}, {"inf"})}, {"label", "gain"}), (__mkO({["label"]="Close the plant the night before the vote", ["gain"]=__mkO({["cash"]=8, ["inf"]=1}, {"cash", "inf"}), ["risk"]=1, ["note"]="It reopens on Monday under a new name."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Testimony", "A Senate subcommittee invites you to discuss \"pricing.\"", (__mkA({[0]=__mkO({["label"]="Testify, apologize, change nothing", ["gain"]=__mkO({["inf"]=1, ["loy"]=3}, {"inf", "loy"})}, {"label", "gain"}), __mkO({["label"]="Endow the chairman's library", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["inf"]=3}, {"inf"})}, {"label", "cost", "gain"}), (__mkO({["label"]="Testify, confidently, about things that are not true", ["gain"]=__mkO({["inf"]=2, ["cash"]=6}, {"inf", "cash"}), ["risk"]=1, ["note"]="The clip does very well online."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Food critic", "A food critic has reviewed your flagship. The headline is \"Fine.\"", (__mkA({[0]=__mkO({["label"]="Invite her back", ["gain"]=__mkO({["loy"]=6}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Ignore it", ["gain"]=__mkO({["out"]=8}, {"out"})}, {"label", "gain"}), (__mkO({["label"]="Buy the newspaper", ["gain"]=__mkO({["loy"]=7, ["inf"]=1}, {"loy", "inf"}), ["risk"]=1, ["note"]="The second review is much warmer."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Endorsement", "A pop star would like to be seen holding your product. For a fee.", (__mkA({[0]=__mkO({["label"]="Pay her", ["cost"]=__mkO({["cash"]=4}, {"cash"}), ["gain"]=__mkO({["loy"]=8}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Decline", ["gain"]=__mkO({["cash"]=5}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Photoshop her holding it anyway", ["gain"]=__mkO({["loy"]=9}, {"loy"}), ["risk"]=1, ["note"]="Her lawyers are on a boat with your auditors."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Foreign relations", "The ambassador of San Limón requests a private dinner. He has brought maps.", (__mkA({[0]=__mkO({["label"]="Accept, and listen politely", ["gain"]=__mkO({["inf"]=1, ["cash"]=3}, {"inf", "cash"})}, {"label", "gain"}), __mkO({["label"]="Fund a general", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["inf"]=3}, {"inf"})}, {"label", "cost", "gain"}), (__mkO({["label"]="Fund both generals", ["gain"]=__mkO({["inf"]=3, ["cash"]=5}, {"inf", "cash"}), ["risk"]=1, ["note"]="Whoever wins, they owe you."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Acquisition", "A rival would like to buy your Midwest operation.", (__mkA({[0]=__mkO({["label"]="Decline, loudly", ["gain"]=__mkO({["loy"]=6}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Make a counteroffer", ["gain"]=__mkO({["cash"]=9}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Accept the deposit and lose the paperwork", ["gain"]=__mkO({["cash"]=13}, {"cash"}), ["risk"]=1, ["note"]="There is no Midwest operation."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Halftime", "A network offers thirty seconds during the championship game.", (__mkA({[0]=__mkO({["label"]="Buy the slot", ["cost"]=__mkO({["cash"]=5}, {"cash"}), ["gain"]=__mkO({["loy"]=11}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Sponsor the trophy instead", ["gain"]=__mkO({["cash"]=6, ["loy"]=3}, {"cash", "loy"})}, {"label", "gain"}), (__mkO({["label"]="Buy the slot with the pension fund", ["gain"]=__mkO({["loy"]=12}, {"loy"}), ["risk"]=1, ["note"]="The pension fund will recover."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Antitrust", "The Department of Justice has opened an inquiry into \"the lemonade situation.\"", (__mkA({[0]=__mkO({["label"]="Cooperate fully", ["gain"]=__mkO({["cash"]=5}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Restructure into fourteen subsidiaries", ["cost"]=__mkO({["cash"]=3}, {"cash"}), ["gain"]=__mkO({["inf"]=3}, {"inf"})}, {"label", "cost", "gain"}), (__mkO({["label"]="Shred the documents", ["gain"]=__mkO({["inf"]=3, ["cash"]=9}, {"inf", "cash"}), ["risk"]=1, ["note"]="There were a lot of documents."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Sovereign wealth", "A sovereign wealth fund would like a stake.", (__mkA({[0]=__mkO({["label"]="Sell them a stake", ["gain"]=__mkO({["cash"]=12}, {"cash"})}, {"label", "gain"}), __mkO({["label"]="Decline, graciously", ["gain"]=__mkO({["loy"]=7}, {"loy"})}, {"label", "gain"}), (__mkO({["label"]="Sell the same stake to two funds", ["gain"]=__mkO({["cash"]=17}, {"cash"}), ["risk"]=1, ["note"]="They will not compare notes."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Whistleblower", "A former intern has written a book. Chapter four is about you.", (__mkA({[0]=__mkO({["label"]="Answer every question", ["gain"]=__mkO({["loy"]=8}, {"loy"})}, {"label", "gain"}), __mkO({["label"]="Hire her back as a consultant", ["cost"]=__mkO({["cash"]=4}, {"cash"}), ["gain"]=__mkO({["inf"]=3}, {"inf"})}, {"label", "cost", "gain"}), (__mkO({["label"]="Buy every copy", ["gain"]=__mkO({["cash"]=10, ["inf"]=1}, {"cash", "inf"}), ["risk"]=1, ["note"]="There is a second printing."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Climate summit", "You have been invited to speak about sustainability.", (__mkA({[0]=__mkO({["label"]="Pledge to go carbon neutral", ["cost"]=__mkO({["cash"]=4}, {"cash"}), ["gain"]=__mkO({["loy"]=10}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Send a deputy", ["gain"]=__mkO({["cash"]=7}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Pledge, then do not", ["gain"]=__mkO({["loy"]=10, ["cash"]=5}, {"loy", "cash"}), ["risk"]=1, ["note"]="Nobody checks."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Water rights", "A drought. The reservoir upstream of the plant is for sale.", (__mkA({[0]=__mkO({["label"]="Buy it, and share", ["cost"]=__mkO({["cash"]=5}, {"cash"}), ["gain"]=__mkO({["out"]=14}, {"out"})}, {"label", "cost", "gain"}), __mkO({["label"]="Ration production", ["gain"]=__mkO({["cash"]=8, ["loy"]=3}, {"cash", "loy"})}, {"label", "gain"}), (__mkO({["label"]="Buy it, and do not share", ["gain"]=__mkO({["out"]=18, ["cash"]=4}, {"out", "cash"}), ["risk"]=1, ["note"]="Downstream is not your problem."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Space program", "A launch company offers to put a lemonade stand on the moon.", (__mkA({[0]=__mkO({["label"]="Fund it", ["cost"]=__mkO({["cash"]=6}, {"cash"}), ["gain"]=__mkO({["loy"]=13}, {"loy"})}, {"label", "cost", "gain"}), __mkO({["label"]="Licence the footage", ["gain"]=__mkO({["cash"]=11}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Fund it with a government grant meant for something else", ["gain"]=__mkO({["loy"]=13, ["cash"]=5}, {"loy", "cash"}), ["risk"]=1, ["note"]="The moon has no zoning laws."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.memo("Homework", "Your mother would like to know whether you have finished your homework.", (__mkA({[0]=__mkO({["label"]="Do your homework", ["gain"]=__mkO({["loy"]=8, ["card"]=3}, {"loy", "card"})}, {"label", "gain"}), __mkO({["label"]="Delegate it", ["gain"]=__mkO({["cash"]=10}, {"cash"})}, {"label", "gain"}), (__mkO({["label"]="Forge her signature on the report card", ["gain"]=__mkO({["cash"]=12, ["inf"]=2}, {"cash", "inf"}), ["risk"]=1, ["note"]="Your empire spans continents. You are in the fourth grade."}, {"label", "gain", "risk", "note"})), __n=3})))
__S1.NAMES = __mkA({[0]="Texas", "Ohio", "Florida", "Iowa", "Nevada", "Maine", "Utah", "Georgia", "Oregon", "Kansas", "Idaho", "Vermont", "Alabama", "Arizona", "Montana", "Indiana", "Kentucky", "Nebraska", "Michigan", "Colorado", "Delaware", "Virginia", "Missouri", "Wyoming", "Oklahoma", "Canada", "Mexico", "Brazil", "Peru", "Chile", "Iceland", "Ireland", "France", "Spain", "Italy", "Greece", "Egypt", "Kenya", "Nigeria", "Morocco", "Turkey", "India", "Japan", "Korea", "Vietnam", "Australia", "Norway", "Poland", ("Antarctica"), __n=49})
__S1.BONUS = __mkA({[0]=__mkO({["cash"]=3}, {"cash"}), __mkO({["card"]=2}, {"card"}), __mkO({["calm"]=2}, {"calm"}), __mkO({["inf"]=1}, {"inf"}), (__mkO({["out"]=4}, {"out"})), __n=5})
__S1.COLORS = __mkA({[0]="red", "blue", "green", ("orange"), __n=4})
__S1.TRACE = __S1.num("TRACE", (0))
__S1.shuffle = function(a)  
do
local i
i = (__len(a) - 1)

while __gt(i, 0) do
local j
j = JS_Math.floor(((JS_Math.random() * __add(i, 1))))
do local __v832 = __mkA({[0]=__get(a, j), (__get(a, i)), __n=2}); local __v833 = __get(__v832, 0); local __v834 = a; local __v835 = i; __set(__v834, __v835, __v833); local __v836 = __get(__v832, 1); local __v837 = a; local __v838 = j; __set(__v837, __v838, __v836);  end

do i = __num(i) - 1 end
end
end
do return (a) end
end
__S1.uid = 1
__S1.ops = 0
__S1.fx = function(G, e)  
if __t(G.fxOn) then
__call((function() local __v840 = G; local __v841 = "fx"; local __v839 = (__T(G.fx) or __mkA({__n=0})); __set(__v840, __v841, __v839) return __v839 end)(), "push", (e))
end
end
__S1.PI = function(G, p)  
do return __call(G.players, "indexOf", (p)) end
end



__S1.BOARDS = __mkO({[2]=__mkO({["homes"]=__mkA({[0]=__mkA({[0]=0, (0), __n=2}), (__mkA({[0]=4, (4), __n=2})), __n=2}), ["hot"]=__mkA({[0]=__mkA({[0]=2, 2, (3), __n=3}), __mkA({[0]=1, 3, (2), __n=3}), (__mkA({[0]=3, 1, (2), __n=3})), __n=3}), ["rough"]=__mkA({[0]=__mkA({[0]=1, (1), __n=2}), (__mkA({[0]=3, (3), __n=2})), __n=2}), ["links"]=__mkA({[0]=(__mkA({[0]=__mkA({[0]=0, (4), __n=2}), (__mkA({[0]=4, (0), __n=2})), __n=2})), __n=1})}, {"homes", "hot", "rough", "links"}), [3]=__mkO({["homes"]=__mkA({[0]=__mkA({[0]=1, (0), __n=2}), __mkA({[0]=2, (5), __n=2}), (__mkA({[0]=5, (2), __n=2})), __n=3}), ["hot"]=__mkA({[0]=__mkA({[0]=2, 2, (3), __n=3}), __mkA({[0]=1, 3, (2), __n=3}), __mkA({[0]=3, 1, (2), __n=3}), (__mkA({[0]=3, 3, (2), __n=3})), __n=4}), ["rough"]=__mkA({[0]=__mkA({[0]=1, (1), __n=2}), __mkA({[0]=2, (4), __n=2}), (__mkA({[0]=4, (2), __n=2})), __n=3}), ["links"]=__mkA({[0]=(__mkA({[0]=__mkA({[0]=0, (3), __n=2}), __mkA({[0]=4, (0), __n=2}), (__mkA({[0]=5, (5), __n=2})), __n=3})), __n=1})}, {"homes", "hot", "rough", "links"}), [4]=__mkO({["homes"]=__mkA({[0]=__mkA({[0]=0, (0), __n=2}), __mkA({[0]=0, (6), __n=2}), __mkA({[0]=6, (0), __n=2}), (__mkA({[0]=6, (6), __n=2})), __n=4}), ["hot"]=__mkA({[0]=__mkA({[0]=3, 3, (3), __n=3}), __mkA({[0]=1, 3, (2), __n=3}), __mkA({[0]=3, 1, (2), __n=3}), __mkA({[0]=3, 5, (2), __n=3}), (__mkA({[0]=5, 3, (2), __n=3})), __n=5}), ["rough"]=__mkA({[0]=__mkA({[0]=1, (1), __n=2}), __mkA({[0]=1, (5), __n=2}), __mkA({[0]=5, (1), __n=2}), (__mkA({[0]=5, (5), __n=2})), __n=4}), ["links"]=__mkA({[0]=__mkA({[0]=__mkA({[0]=0, (3), __n=2}), (__mkA({[0]=6, (3), __n=2})), __n=2}), (__mkA({[0]=__mkA({[0]=3, (0), __n=2}), (__mkA({[0]=3, (6), __n=2})), __n=2})), __n=2})}, {"homes", "hot", "rough", "links"})}, {})
__S1.RING = __mkA({[0]=__mkA({[0]="Kansas", "Nebraska", "Missouri", ("Oklahoma"), __n=4}), __mkA({[0]="Iowa", "Colorado", "Texas", "South Dakota", "Arkansas", "Illinois", "Minnesota", ("New Mexico"), __n=8}), __mkA({[0]="Wyoming", "Tennessee", "Wisconsin", "Kentucky", "Louisiana", "Montana", "Indiana", ("Utah"), __n=8}), __mkA({[0]="Ohio", "Georgia", "Arizona", "Michigan", "Idaho", "Alabama", "Nevada", ("Mississippi"), __n=8}), __mkA({[0]="California", "New York", "Florida", "Washington", "Oregon", "Ontario", "Mexico", ("Virginia"), __n=8}), __mkA({[0]="Maine", "Quebec", "British Columbia", "Puerto Rico", "Massachusetts", ("Cuba"), __n=6}), (__mkA({[0]="Alaska", "Hawaii", "Greenland", "Yukon", "Nunavut", ("Newfoundland"), __n=6})), __n=7})
__S1.WORLD = __mkA({[0]="Brazil", "India", "Nigeria", "Germany", "Egypt", "Korea", "Australia", "Italy", "Spain", "Kenya", "Vietnam", "Peru", "Turkey", "Chile", "Poland", "Indonesia", "Argentina", "Morocco", "Thailand", "Norway", "Greece", "Japan", "Ireland", "Iceland", ("Ghana"), __n=25})
__S1.HOTN = __mkA({[0]="Tokyo", "London", "Shanghai", "Paris", ("Dubai"), __n=5})
__S1.ROUGHN = __mkA({[0]="the Himalayas", "the Andes", "the Alps", "the Sahara", ("Siberia"), __n=5})
__S1.ROUTES = __mkA({[0]="A", "B", ("C"), __n=3})











__S1.P = function(G)  
do return __get(G.players, G.turn) end
end
__S1.co = function(G, i)  
do return (__t(__call((__get(G.players, i)).name, "endsWith", ("s"))) and (__str((__get(G.players, i)).name) .. "' Lemonade") or (__str((__get(G.players, i)).name) .. "'s Lemonade")) end
end
__S1.cell = function(G, id)  
do return (__T(__call(G.map.cells, "find", (function(c)  
do return (c.id == id) end
end))) or nil) end
end
__S1.toks = function(c, pi)  
do return (__T(__get(c.tok, pi)) or 0) end
end
__S1.ownerOf = function(c)  local best, w
best = 0
w = nil
for __v842 in __forin(c.tok) do
local k
k = __v842; 
local v
v = __get(c.tok, k)
if __gt(v, best) then
do best = v end
do w = __num(k) end
elseif (v == best) then
do w = nil end
end

end
if __gt(best, 0) then do return (w) end else do return (nil) end end
end
__S1.controlled = function(G, pi)  local h
h = (__get(G.players, pi)).home
do return (__add(__add(__len(__call(G.map.cells, "filter", (function(c)  
do return (__S1.ownerOf((c)) == pi) end
end))), ((G.limon == pi) and 1 or 0)), (((__t(__S1.hasA(__get(G.players, pi), ("becky"))) and __t(h)) and (__S1.ownerOf((__call(G.map.cells, "find", (function(c)  
do return (c.id == h) end
end)))) == pi)) and 1 or 0))) end
end
__S1.homeOf = function(G, pi)  
do return (function() if __t((__get(G.players, pi)).home) then return __S1.cell(G, ((__get(G.players, pi)).home)) end return nil end)() end
end
__S1.dist = function(G, pi, c)  local h
h = __S1.homeOf(G, (pi))
if __t(h) then do return (__add(JS_Math.abs(((h.c - c.c))), JS_Math.abs(((h.r - c.r))))) end else do return (0) end end
end
__S1.NEAR = __S1.num("NEAR", (0))
__S1.OUTPOST = __S1.num("OUTPOST", (3))
__S1.DCACHE = __new(JS_WeakMap)
__S1.outpostN = function(p)  
do return (__t(__S1.hasA(p, ("franchise"))) and 2 or __S1.OUTPOST) end
end

__S1.reach = function(G, pi, c)  local own
if (not __t(__S1.NEAR)) then
local d
d = __get(__S1.travel(G, (pi)), c.id)
if (d == nil) then do return (__S1.dist(G, pi, (c))) end else do return (d) end end
end
if (__S1.ownerOf((c)) == pi) then
do return (0) end
end
own = __call(G.map.cells, "filter", (function(o)  
do return (__S1.ownerOf((o)) == pi) end
end))
if (not __t(__len(own))) then
do return (__S1.dist(G, pi, (c))) end
end
do return (JS_Math.min(__unpack(__spreadA({{s=__call(own, "map", (function(o)  
do return __add(JS_Math.abs(((o.c - c.c))), JS_Math.abs(((o.r - c.r)))) end
end))}})))) end
end
__S1.TB = __S1.num("TB", (1))
__S1.tokCost = function(G, pi, c)  local o
o = __S1.ownerOf((c))
do return (JS_Math.max(1, (__add((__add(__add(__S1.TB, (function() if ((__t(c.rough) and (o ~= pi)) and (not __t(__S1.hasA(__get(G.players, pi), ("dwarf"))))) then return c.rough end return 0 end)()), (function() if __t(__S1.hasA(__get(G.players, pi), ("realtor"))) then return JS_Math.min(2, (__S1.reach(G, pi, (c)))) end return __S1.reach(G, pi, (c)) end)()) - (((__t(__S1.hasA(__get(G.players, pi), ("rhonda"))) and (o ~= nil)) and (o ~= pi)) and 2 or 0)), ((((o ~= nil) and (o ~= pi)) and __t(__S1.hasA(__get(G.players, o), ("cop")))) and 1 or 0))))) end
end
__S1.drawCost = function(p)  
do return JS_Math.max(1, ((__S1.DRAW - ((__t(__S1.hasA(p, ("cfo"))) and (not __t(p.cfoR))) and 1 or 0)))) end
end
__S1.starText = function(h)  local w
w = __add(1, JS_Math.floor(((h / 2))))
do return ((__str(w) .. __str((__t(__mod(h, 2)) and "½" or "")) .. " star" .. __str((((w == 1) and (not __t(__mod(h, 2)))) and "" or "s")))) end
end
__S1.handSize = function(p)  
do return __call(__S1.FAMS, "reduce", function(a, f)  
do return __add(a, __get(p.hand, f)) end
end, (0)) end
end
__S1.topEra = function(G)  
do return JS_Math.max(__unpack(__spreadA({{s=__call(G.players, "map", (function(q)  
do return q.era end
end))}}))) end
end
__S1.tolerance = function(G)  
do return __get(__S1.TOL, JS_Math.max(0, ((__S1.bandOf((__S1.topEra((G)))) - (__t(__call(G.players, "some", (function(q)  
do return __S1.hasA(q, ("elle")) end
end))) and 1 or 0))))) end
end
__S1.onMap = function(G, pi)  
do return __call(G.map.cells, "reduce", function(a, c)  
do return __add(a, __S1.toks(c, (pi))) end
end, (0)) end
end
__S1.no = function(why)  
do return __mkO({["ok"]=false, ["why"]=why}, {"ok", "why"}) end
end
__S1.yes = function(cost)  
do return __mkO({["ok"]=true, ["cost"]=(__T(cost) or __mkO({}, {}))}, {"ok", "cost"}) end
end
__S1.myTurn = function(G, phase)  
do return ((G.winner ~= nil) and "The game is over" or (__t(G.offer) and "Decide on the advisor first" or (__t(G.choice) and "Choose a card first" or (__t(G.pending) and "Answer the memo first" or ((__t(phase) and (G.phase ~= phase)) and "Not in this phase" or nil))))) end
end
__S1.rank = function(G, i)  local q
q = __get(G.players, i)
do return (__add(__add((q.ctl * 1000), (q.era * 30)), q.cash)) end
end
__S1.tina = function(G, i)  
do return (function() if __t(__S1.hasA(__get(G.players, i), ("tina"))) then return (-1000000) end return 0 end)() end
end


__S1.UD = __S1.num("UD", (0))
__S1.UDF = __S1.num("UDF", (0))
__S1.stipend = function(G, i)  local q, top
q = __get(G.players, i)
top = JS_Math.max(__unpack(__spreadA({{s=__call(G.players, "map", (function(_, j)  
do return __S1.controlled(G, (j)) end
end))}})))
do return (__add(__add(__get(__S1.LOYE, (q.era - 1)), (__t(__S1.hasA(q, ("tanner"))) and 1 or 0)), __S1.underdog(G, i, (top)))) end
end
__S1.underdog = function(G, i, top)  
do return __add(__S1.UDF, (function() if __t(__S1.UD) then return JS_Math.floor((((top - __S1.controlled(G, (i))) / __S1.UD))) end return 0 end)()) end
end



















__S1.canVacate = function(p, s)  
do return (function() if (__typeof(s) == "string") then return (not (not __t(__get(p.adv, __num(__call(s, "slice", (1))))))) end return ((__typeof(s) == "number") and (not (not __t(__get(p.mach, s))))) end)() end
end











__S1.HOMEN = __S1.num("HOMEN", (5))
__S1.SMALLN = __S1.num("SMALLN", (5))
__S1.DEEPT = __S1.num("DEEPT", (2))
__S1.DEEPK = __S1.num("DEEPK", (2))

__S1.rbonus = function(G, p, f)  
do return __call((__T(p.tiles) or __mkA({__n=0})), "reduce", function(a, c)  
do return __add(a, (function() if ((__t(c.bonus) and (c.bonus.f == f)) and __t(__S1.condOK(G, p, (c.bonus.cond)))) then return c.bonus.n end return 0 end)()) end
end, (0)) end
end
__S1.SLOTS5 = __spreadA({{s=__S1.FAMS}, {v="any"}})
__S1.shelfOf = function(p)  local s
s = __mkO({["sweet"]=0, ["sour"]=0, ["herb"]=0, ["fizz"]=0, ["any"]=0}, {"sweet", "sour", "herb", "fizz", "any"})
for _, __v844 in __forof((__T(p.shelf) or __mkA({__n=0}))) do
local m
m = __v844; 
for _, __v846 in __forof(m.inp) do
local f
f = __v846; 
do local __v848 = s; local __v849 = f; __set(__v848, __v849, __num((function() local __v848 = s; local __v849 = f; return __get(__v848, __v849) end)()) + 1) end

end

end
do return (s) end
end


__S1.resCards = function(p)  
do return __len((__T(p.tiles) or __mkA({__n=0}))) end
end









__S1.infCost = function(p)  
do return __S1.INFC end
end


__S1.bailCost = function(G, p)  
do return __add(__S1.BAILB, __S1.bandOf((p.era))) end
end



__S1.actTargets = function(G, pi)  
do return __call(__call(G.map.cells, "filter", (function(c)  
do return (function() local __v850 = __call(JS_Object.keys((c.tok)), "some", (function(k)  
do return (__num(k) ~= pi) end
end)); if __t(__v850) then return __call(G.map.cells, "some", (function(o)  
do return ((__S1.ownerOf((o)) == pi) and (__add(JS_Math.abs(((o.c - c.c))), JS_Math.abs(((o.r - c.r)))) == 1)) end
end)) end return __v850 end)() end
end)), "slice", 0, (3)) end
end




__S1.lt = function(G, pi, src, n)  
if (__t(__S1.TRACE) and __t(n)) then
__call((function() local __v852 = G; local __v853 = "lt"; local __v851 = (__T(G.lt) or __mkA({__n=0})); __set(__v852, __v853, __v851) return __v851 end)(), "push", (__mkO({["pi"]=pi, ["r"]=G.round, ["src"]=src, ["n"]=n}, {"pi", "r", "src", "n"})))
end
end







__S1.KW = __S1.num("KW", (1))
__S1.RC = __S1.num("RC", (10))
__S1.LEG = __mkO({["stv"]=function()  
do return __num((__T(__S1.ENV.STV) or 1.8)) end
end, ["rOut"]=function()  
do return 0.55 end
end, ["rFree"]=function()  
do return 3.5 end
end, ["rRerun"]=function()  
do return 2.5 end
end, ["nbv"]=function()  
do return __num((__T(__S1.ENV.BONV) or 3)) end
end, ["fchase"]=function()  
do return 1.5 end
end, ["resBias"]=function(p)  
do return (function() if (p.spec == "prd") then return __num((__T(__S1.ENV.PRDF) or 2)) end return 0 end)() end
end, ["rcost"]=function()  
do return __num((__T(__S1.ENV.RCOST) or 0.9)) end
end, ["missW"]=function()  
do return 1.6 end
end, ["resStock"]=function(p)  
do return (((p.spec == "prd") or (p.spec == "gen")) and 99 or (function() if (p.spec == "mfg") then return __num((__T(__S1.ENV.MFGST) or 2)) end return 4 end)()) end
end, ["resFirst"]=function(p)  
do return ((p.spec == "prd") and 1 or 0) end
end, ["pRun"]=function()  
do return 5 end
end, ["pRes"]=function()  
do return 4 end
end, ["pBuy"]=function()  
do return 3 end
end, ["pAdv"]=function()  
do return 2 end
end, ["pIng"]=function()  
do return 1 end
end, ["mGain"]=function()  
do return 3 end
end, ["mRes"]=function(p)  
do return (function() if ((p.spec == "mfg") or (p.spec == "flex")) then return __num((__T(__S1.ENV.MFGRES) or 4)) end return 2 end)() end
end, ["mFullCash"]=function(p)  
do return (function() if ((p.spec == "mfg") or (p.spec == "flex")) then return (-99) end return 4 end)() end
end, ["freeMin"]=function()  
do return 4 end
end, ["pileThr"]=function()  
do return 3.5 end
end, ["drawCash"]=function()  
do return 8 end
end, ["handCap"]=function()  
do return 8 end
end, ["advMfg"]=function(p)  
do return __S1.advLeg(p, ("mfg")) end
end, ["advPrd"]=function(p)  
do return __S1.advLeg(p, ("prd")) end
end, ["advDis"]=function(p)  
do return __S1.advLeg(p, ("dis")) end
end, ["advGen"]=function(p)  
do return __S1.advLeg(p, ("gen")) end
end, ["advAll"]=function(p)  
do return __S1.advLeg(p, ("all")) end
end, ["advDef"]=function(p, ms)  
do return ((ms == "def") and 5.6 or ((ms == "none") and 1 or 3.5)) end
end, ["advAtk"]=function(p, ms)  
do return ((ms == "atk") and 5.6 or ((ms == "none") and 1 or 3.5)) end
end, ["advGrow"]=function(p, ms)  
do return ((ms == "grow") and 5.6 or ((ms == "none") and 1 or 3.5)) end
end, ["advThr"]=function()  
do return 4.5 end
end, ["advRes"]=function()  
do return __num((__T(__S1.ENV.ARES) or 9)) end
end, ["advResMap"]=function()  
do return __num((__T(__S1.ENV.MSRES) or 2)) end
end, ["offerRes"]=function()  
do return 4 end
end, ["ccv"]=function()  
do return __num((__T(__S1.ENV.CCV) or 0.5)) end
end, ["amax"]=function()  
do return __num((__T(__S1.ENV.AMAX) or 2)) end
end, ["advScrap"]=function(p)  
do return ((p.spec == "mfg") and 2 or ((p.spec == "dis") and 7 or 4)) end
end, ["mLoy"]=function()  
do return 1.6 end
end, ["mCash"]=function()  
do return 1 end
end, ["mCard"]=function()  
do return 1.4 end
end, ["mCont"]=function()  
do return 2.5 end
end, ["heatAv"]=function()  
do return __S1.RC end
end, ["mKeep"]=function()  
do return __num((__T(__S1.ENV.KEEPV) or 3)) end
end, ["gKW"]=function()  
do return __S1.KW end
end, ["gCapture"]=function()  
do return 10 end
end, ["gDefend"]=function()  
do return 6 end
end, ["gSpare"]=function(p)  
do return ((p.spec == "dis") and 0.5 or (-99)) end
end, ["gBonusCell"]=function()  
do return 2 end
end, ["gHot"]=function()  
do return 2 end
end, ["gOutpost"]=function(p, ms)  
do return ((ms == "grow") and 5 or 3) end
end, ["gDeep"]=function(p, ms)  
do return ((ms == "def") and 2.5 or 0) end
end, ["gRough"]=function(p, ms)  
do return ((ms == "def") and 1.5 or 0) end
end, ["gAtk"]=function(p, ms)  
do return ((ms == "atk") and 1.5 or 0) end
end, ["gGrow"]=function(p, ms)  
do return ((ms == "grow") and 1 or 0) end
end, ["gPlaceMin"]=function()  
do return 0 end
end, ["scrapThr"]=function()  
do return 99 end
end, ["scrapOut"]=function()  
do return 0.5 end
end, ["mFam"]=function()  
do return 0 end
end, ["rImp"]=function()  
do return 1.5 end
end, ["gImp"]=function()  
do return 0.6 end
end, ["impW"]=function()  
do return 2 end
end, ["impSafe"]=function()  
do return 1 end
end, ["lobbyMap"]=function(p)  
do return ((p.spec == "dis") and 1 or 0) end
end, ["lobbyRes"]=function()  
do return 2 end
end, ["bailRes"]=function()  
do return 6 end
end, ["stCenter"]=function()  
do return 1 end
end, ["stGap"]=function()  
do return 0.6 end
end, ["stBonus"]=function()  
do return 1 end
end}, {"stv", "rOut", "rFree", "rRerun", "nbv", "fchase", "resBias", "rcost", "missW", "resStock", "resFirst", "pRun", "pRes", "pBuy", "pAdv", "pIng", "mGain", "mRes", "mFullCash", "freeMin", "pileThr", "drawCash", "handCap", "advMfg", "advPrd", "advDis", "advGen", "advAll", "advDef", "advAtk", "advGrow", "advThr", "advRes", "advResMap", "offerRes", "ccv", "amax", "advScrap", "mLoy", "mCash", "mCard", "mCont", "heatAv", "mKeep", "gKW", "gCapture", "gDefend", "gSpare", "gBonusCell", "gHot", "gOutpost", "gDeep", "gRough", "gAtk", "gGrow", "gPlaceMin", "scrapThr", "scrapOut", "mFam", "rImp", "gImp", "impW", "impSafe", "lobbyMap", "lobbyRes", "bailRes", "stCenter", "stGap", "stBonus"})
__S1.advLeg = function(p, t)  
do return ((t == "all") and 4.6 or ((t == p.spec) and 5 or ((p.spec == "gen") and 4 or (((p.spec == "flex") and (t == "mfg")) and 4 or 1)))) end
end
__S1.GENES = __mkA({[0]=__mkA({[0]="stv", 0, 6, ("research"), __n=4}), __mkA({[0]="rOut", 0, 1.5, ("research"), __n=4}), __mkA({[0]="rFree", 0, 7, ("research"), __n=4}), __mkA({[0]="rRerun", 0, 6, ("research"), __n=4}), __mkA({[0]="nbv", 0, 7, ("research"), __n=4}), __mkA({[0]="fchase", 0, 6, ("research"), __n=4}), __mkA({[0]="resBias", (-3), 6, ("research"), __n=4}), __mkA({[0]="rcost", 0.2, 2, ("research"), __n=4}), __mkA({[0]="missW", 0.3, 4, ("research"), __n=4}), __mkA({[0]="resStock", 0, 9, ("research"), __n=4}), __mkA({[0]="resFirst", 0, 1, ("research"), __n=4}), __mkA({[0]="pRun", 0, 6, ("order"), __n=4}), __mkA({[0]="pRes", 0, 6, ("order"), __n=4}), __mkA({[0]="pBuy", 0, 6, ("order"), __n=4}), __mkA({[0]="pAdv", 0, 6, ("order"), __n=4}), __mkA({[0]="pIng", 0, 6, ("order"), __n=4}), __mkA({[0]="mGain", 0, 8, ("machines"), __n=4}), __mkA({[0]="mRes", 0, 10, ("machines"), __n=4}), __mkA({[0]="mFullCash", (-10), 12, ("machines"), __n=4}), __mkA({[0]="freeMin", 0, 10, ("machines"), __n=4}), __mkA({[0]="pileThr", 0.5, 6, ("cards"), __n=4}), __mkA({[0]="drawCash", 2, 20, ("cards"), __n=4}), __mkA({[0]="handCap", 2, 14, ("cards"), __n=4}), __mkA({[0]="advMfg", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advPrd", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advDis", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advGen", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advAll", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advDef", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advAtk", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advGrow", 0, 8, ("advisors"), __n=4}), __mkA({[0]="advThr", 2, 8, ("advisors"), __n=4}), __mkA({[0]="advRes", 0, 14, ("advisors"), __n=4}), __mkA({[0]="advResMap", 0, 10, ("advisors"), __n=4}), __mkA({[0]="offerRes", 0, 10, ("advisors"), __n=4}), __mkA({[0]="ccv", 0, 3, ("advisors"), __n=4}), __mkA({[0]="amax", 0, 3, ("advisors"), __n=4}), __mkA({[0]="advScrap", 0, 12, ("advisors"), __n=4}), __mkA({[0]="mLoy", 0, 4, ("memos"), __n=4}), __mkA({[0]="mCash", 0, 3, ("memos"), __n=4}), __mkA({[0]="mCard", 0, 4, ("memos"), __n=4}), __mkA({[0]="mCont", 0, 5, ("memos"), __n=4}), __mkA({[0]="heatAv", 0, 25, ("memos"), __n=4}), __mkA({[0]="mKeep", 0, 7, ("memos"), __n=4}), __mkA({[0]="gKW", 0.2, 2.5, ("map"), __n=4}), __mkA({[0]="gCapture", 2, 16, ("map"), __n=4}), __mkA({[0]="gDefend", 0, 12, ("map"), __n=4}), __mkA({[0]="gSpare", (-5), 6, ("map"), __n=4}), __mkA({[0]="gBonusCell", 0, 6, ("map"), __n=4}), __mkA({[0]="gHot", 0, 6, ("map"), __n=4}), __mkA({[0]="gOutpost", 0, 10, ("map"), __n=4}), __mkA({[0]="gDeep", 0, 8, ("map"), __n=4}), __mkA({[0]="gRough", 0, 6, ("map"), __n=4}), __mkA({[0]="gAtk", 0, 6, ("map"), __n=4}), __mkA({[0]="gGrow", 0, 5, ("map"), __n=4}), __mkA({[0]="gPlaceMin", (-3), 8, ("map"), __n=4}), __mkA({[0]="rImp", 0, 6, ("improve"), __n=4}), __mkA({[0]="gImp", 0, 3, ("improve"), __n=4}), __mkA({[0]="impW", 0, 8, ("improve"), __n=4}), __mkA({[0]="impSafe", (-1), 4, ("improve"), __n=4}), __mkA({[0]="scrapThr", (-2), 12, ("machines"), __n=4}), __mkA({[0]="scrapOut", 0, 2, ("machines"), __n=4}), __mkA({[0]="mFam", 0, 4, ("machines"), __n=4}), __mkA({[0]="lobbyMap", 0, 1, ("influence"), __n=4}), __mkA({[0]="lobbyRes", 0, 10, ("influence"), __n=4}), __mkA({[0]="bailRes", 0, 15, ("influence"), __n=4}), __mkA({[0]="stCenter", 0, 3, ("map"), __n=4}), __mkA({[0]="stGap", 0, 2, ("map"), __n=4}), (__mkA({[0]="stBonus", 0, 4, ("map"), __n=4})), __n=69})
__S1.MSG = __new(JS_Set, (__mkA({[0]="advDef", "advAtk", "advGrow", "gOutpost", "gDeep", "gRough", "gAtk", ("gGrow"), __n=8})))
__S1.gv = function(p, k)  
do return (function() if (__t(p.gen) and (__get(p.gen, k) ~= nil)) then return __get(p.gen, k) end return __get(__S1.LEG, k)(p, ((function() if (not __t(__call(__S1.MSG, "has", (k)))) then return nil end return (__t(p.gen) and "none" or __S1.mapStyle((p))) end)())) end)() end
end
__S1.legacyGenome = function(spec, ms)  local p, g
p = __mkO({["spec"]=spec, ["ms"]=(__T(ms) or (__t(__call(__mkA({[0]="dis", ("gen"), __n=2}), "includes", (spec))) and "def" or "none"))}, {"spec", "ms"})
g = __mkO({}, {})
for _, __v854 in __forof(__S1.GENES) do
local k
local __v856 = __get(__v854, 0); k = __v856; 
do local __v857 = g; local __v858 = k; local __v859 = __get(__S1.LEG, k)(p, (p.ms)); __set(__v857, __v858, __v859) end

end
do return (g) end
end
__S1.acc = function(p, k, n)  local a
if (not __t(n)) then
do return end
end
a = (__T(p.acct) or (function() local __v861 = p; local __v862 = "acct"; local __v860 = __mkO({}, {}); __set(__v861, __v862, __v860) return __v860 end)())
do local __v863 = a; local __v864 = k; local __v865 = __add((__T(__get(a, k)) or 0), n); __set(__v863, __v864, __v865) end
end
__S1.deckOdds = function(G)  local all, n
if __t(__len(G.ideck)) then all = G.ideck else all = G.idisc end
n = (__T(__len(all)) or 1)
do return (function(need)  
do return (__le(need, 0) and 1 or (__len(__call(all, "filter", (function(c)  
do return __ge(c.x, need) end
end))) / n)) end
end) end
end
__S1.DECK0 = nil

__S1.held = function(p, cond)  
do return __call((__T(p.tiles) or __mkA({__n=0})), "reduce", function(a, c)  
do return __add(a, (function() if (__t(c.bonus) and (c.bonus.cond == cond)) then return c.bonus.n end return 0 end)()) end
end, (0)) end
end
__S1.keepOn = function(p)  
do return (function() local __v866 = (function() if (p.keep ~= nil) then return (not (not __t(p.keep))) end return ((not (not __t(p.bot))) and (not __t(__S1.ENV.NOKEEP))) end)(); if __t(__v866) then return __call((__T(p.tiles) or __mkA({__n=0})), "some", (function(c)  
do return c.bonus end
end)) end return __v866 end)() end
end






__S1.mapStyle = function(p)  
do return (__T(p.ms) or (function() local __v868 = p; local __v869 = "ms"; local __v867 = (function() if __t(__call(__mkA({[0]="dis", ("gen"), __n=2}), "includes", (p.spec))) then return __get(__mkA({[0]="def", "atk", ("grow"), __n=3}), JS_Math.floor(((JS_Math.random() * 3)))) end return "none" end)(); __set(__v868, __v869, __v867) return __v867 end)()) end
end


__S1.ADVK = __mkO({["mfg"]="advMfg", ["prd"]="advPrd", ["dis"]="advDis", ["gen"]="advGen", ["all"]="advAll"}, {"mfg", "prd", "dis", "gen", "all"})
__S1.MSK = __mkO({["def"]="advDef", ["atk"]="advAtk", ["grow"]="advGrow"}, {"def", "atk", "grow"})

__S1.mapFit = function(p, a)  
do return (function() local __v870 = a.ms; if __t(__v870) then return __ge(__S1.gv(p, (__get(__S1.MSK, a.ms))), 5) end return __v870 end)() end
end



__S1.RECV = 1
__S1.RECON = ((__typeof(JS_window) ~= "undefined") and 1 or __S1.num("REC", (0)))
__S1.handS = function(h)  
do return __call(__call(__S1.FAMS, "map", (function(f)  
do return (__T(__get(h, f)) or 0) end
end)), "join", ("/")) end
end



__S1.sec = function(R)  
do return (JS_Math.round((((JS_Date.now() - R.t0) / 100))) / 10) end
end


__S1.cn = function(G, id)  local c
c = __S1.cell(G, (id))
if __t(c) then do return (c.name) end else do return (id) end end
end
__S1.RES = function(c)  
do return (function() local __v871 = c; if __t(__v871) then return __mkO({["card"]=c.name, ["tier"]=c.tier, ["cost"]=c.cost}, {"card", "tier", "cost"}) end return __v871 end)() end
end
__S1.RECA = __mkO({["pass"]=__mkO({}, {}), ["lobby"]=__mkO({}, {}), ["bail"]=__mkO({}, {}), ["stand"]=__mkO({["pre"]=function(G, id)  
do return __mkO({["at"]=__S1.cn(G, (id))}, {"at"}) end
end}, {"pre"}), ["draw"]=__mkO({["post"]=function(G)  
do return (__t(G.choice) and __mkO({["seen"]=__call(G.choice.cards, "map", (function(c)  
do return __add(__add(c.f, ":"), c.n) end
end))}, {"seen"}) or __mkO({}, {})) end
end}, {"post"}), ["pick"]=__mkO({["who"]=function(G)  
do return (function() if __t(G.choice) then return G.choice.pi end return G.turn end)() end
end, ["pre"]=function(G, i)  
do return ((__t(G.choice) and __t(__get(G.choice.cards, i))) and __mkO({["kept"]=__add(__add((__get(G.choice.cards, i)).f, ":"), (__get(G.choice.cards, i)).n), ["of"]=__call(G.choice.cards, "map", (function(c)  
do return __add(__add(c.f, ":"), c.n) end
end))}, {"kept", "of"}) or __mkO({}, {})) end
end}, {"who", "pre"}), ["take"]=__mkO({["pre"]=function(G, f)  
do return __mkO({["f"]=f, ["pile"]=(function() if __t(__get(G.piles, f)) then return __len(__get(G.piles, f)) end return 0 end)()}, {"f", "pile"}) end
end}, {"pre"}), ["run"]=__mkO({["pre"]=function(G, i, use, hal)  local m
m = __get((__S1.P((G))).mach, i)
do return (__mkO({["m"]=(function() local __v872 = m; if __t(__v872) then return m.id end return __v872 end)(), ["use"]=use, ["hal"]=hal}, {"m", "use", "hal"})) end
end}, {"pre"}), ["buy"]=__mkO({["pre"]=function(G, i, scrap)  local m, p
m = __get(G.mkt, i)
p = __S1.P((G))
do return (__mkO({["m"]=(function() local __v873 = m; if __t(__v873) then return m.id end return __v873 end)(), ["price"]=(function() local __v874 = m; if __t(__v874) then return m.price end return __v874 end)(), ["scrap"]=(function() if ((scrap ~= nil) and __t(__get(p.mach, scrap))) then return (__get(p.mach, scrap)).id end return scrap end)(), ["mkt"]=__call(G.mkt, "map", (function(x)  
do return __add(__add(x.id, "$"), x.price) end
end))}, {"m", "price", "scrap", "mkt"})) end
end}, {"pre"}), ["scrapM"]=__mkO({["pre"]=function(G, i)  
do return __mkO({["m"]=(function() local __v875 = __get((__S1.P((G))).mach, i); if __t(__v875) then return (__get((__S1.P((G))).mach, i)).id end return __v875 end)()}, {"m"}) end
end}, {"pre"}), ["hire"]=__mkO({["pre"]=function(G, k, from, scrap)  local a
if (from == nil) then a = __get(G.arow, k) else a = (function() local __v876 = __get(G.players, from); if __t(__v876) then return __get((__get(G.players, from)).adv, k) end return __v876 end)() end
do return (__mkO({["adv"]=(function() local __v877 = a; if __t(__v877) then return a.id end return __v877 end)(), ["price"]=(function() local __v878 = a; if __t(__v878) then return a.price end return __v878 end)(), ["from"]=from, ["scrap"]=scrap}, {"adv", "price", "from", "scrap"})) end
end}, {"pre"}), ["hit"]=__mkO({["pre"]=function(G, ti, k)  
do return __mkO({["tgt"]=ti, ["adv"]=(function() local __v879 = (function() local __v880 = __get(G.players, ti); if __t(__v880) then return __get((__get(G.players, ti)).adv, k) end return __v880 end)(); if __t(__v879) then return (__get((__get(G.players, ti)).adv, k)).id end return __v879 end)()}, {"tgt", "adv"}) end
end}, {"pre"}), ["sell"]=__mkO({["pre"]=function(G, n)  
do return __mkO({["n"]=n}, {"n"}) end
end}, {"pre"}), ["research"]=__mkO({["pre"]=function(G, k, patent)  
do return __spreadO({{s=__S1.RES((__get(G.rrow, k)))}, {k="patent", v=(__T(patent) or nil)}, {k="row", v=__call(G.rrow, "map", (function(c, j)  
do return (function() if __t(c) then return __add(c.name, (__t((__S1.canResearch(G, (j))).ok) and "" or " (no)")) end return nil end)() end
end))}}) end
end}, {"pre"}), ["place"]=__mkO({["pre"]=function(G, id)  local c, x
c = __S1.cell(G, (id))
x = __S1.canPlace(G, (id))
do return (__mkO({["at"]=(function() local __v881 = c; if __t(__v881) then return c.name end return __v881 end)(), ["own"]=(function() local __v882 = c; if __t(__v882) then return __S1.ownerOf((c)) end return __v882 end)(), ["tk"]=(function() local __v883 = c; if __t(__v883) then return __spreadO({{s=c.tok}}) end return __v883 end)(), ["cost"]=x.cost, ["hot"]=((__t(c) and __t(c.hot)) and 1 or nil), ["rough"]=((__t(c) and __t(c.rough)) and 1 or nil)}, {"at", "own", "tk", "cost", "hot", "rough"})) end
end}, {"pre"}), ["improve"]=__mkO({["pre"]=function(G, id)  local c
c = __S1.cell(G, (id))
do return (__mkO({["at"]=(function() local __v884 = c; if __t(__v884) then return c.name end return __v884 end)(), ["imp"]=(function() local __v885 = c; if __t(__v885) then return (__T(c.imp) or 0) end return __v885 end)(), ["pays"]=(function() local __v886 = c; if __t(__v886) then return __get(__S1.yields((c)), (__T(c.imp) or 0)) end return __v886 end)()}, {"at", "imp", "pays"})) end
end}, {"pre"}), ["play"]=__mkO({["pre"]=function(G, u, target, extra)  local c
c = __call((__S1.P((G))).inf, "find", (function(k)  
do return (k.u == u) end
end))
do return (__mkO({["card"]=(function() local __v887 = c; if __t(__v887) then return c.t end return __v887 end)(), ["target"]=target, ["extra"]=extra}, {"card", "target", "extra"})) end
end}, {"pre"}), ["file"]=__mkO({["pre"]=function(G, extra)  
do return __mkO({["extra"]=extra}, {"extra"}) end
end}, {"pre"}), ["choose"]=__mkO({["who"]=function(G)  
do return (function() if __t(G.pending) then return G.pending.pi end return G.turn end)() end
end, ["pre"]=function(G, i)  local m, o
m = (function() local __v888 = G.pending; if __t(__v888) then return __get(__S1.MEMOS, G.pending.id) end return __v888 end)()
o = (function() local __v889 = m; if __t(__v889) then return __get(m.opts, i) end return __v889 end)()
do return (__mkO({["memo"]=(function() local __v890 = m; if __t(__v890) then return m.title end return __v890 end)(), ["opt"]=i, ["label"]=(function() if __t(o) then return o.label end return "none" end)()}, {"memo", "opt", "label"})) end
end}, {"who", "pre"}), ["takeOffer"]=__mkO({["who"]=function(G)  
do return (function() if __t(G.offer) then return G.offer.pi end return G.turn end)() end
end, ["pre"]=function(G, scrap)  
do return __mkO({["adv"]=(function() local __v891 = G.offer; if __t(__v891) then return G.offer.a.id end return __v891 end)(), ["price"]=(function() local __v892 = G.offer; if __t(__v892) then return G.offer.a.price end return __v892 end)(), ["scrap"]=scrap}, {"adv", "price", "scrap"}) end
end}, {"who", "pre"}), ["declineOffer"]=__mkO({["who"]=function(G)  
do return (function() if __t(G.offer) then return G.offer.pi end return G.turn end)() end
end, ["pre"]=function(G)  
do return __mkO({["adv"]=(function() local __v893 = G.offer; if __t(__v893) then return G.offer.a.id end return __v893 end)(), ["price"]=(function() local __v894 = G.offer; if __t(__v894) then return G.offer.a.price end return __v894 end)()}, {"adv", "price"}) end
end}, {"who", "pre"})}, {"pass", "lobby", "bail", "stand", "draw", "pick", "take", "run", "buy", "scrapM", "hire", "hit", "sell", "research", "place", "improve", "play", "file", "choose", "takeOffer", "declineOffer"})
__S1.recDepth = 0

do __S1.pass = __S1.traced("pass", (__S1.pass)) end
do __S1.lobby = __S1.traced("lobby", (__S1.lobby)) end
do __S1.bail = __S1.traced("bail", (__S1.bail)) end
do __S1.stand = __S1.traced("stand", (__S1.stand)) end
do __S1.draw = __S1.traced("draw", (__S1.draw)) end
do __S1.pick = __S1.traced("pick", (__S1.pick)) end
do __S1.take = __S1.traced("take", (__S1.take)) end
do __S1.run = __S1.traced("run", (__S1.run)) end
do __S1.buy = __S1.traced("buy", (__S1.buy)) end
do __S1.scrapM = __S1.traced("scrapM", (__S1.scrapM)) end
do __S1.hire = __S1.traced("hire", (__S1.hire)) end
do __S1.hit = __S1.traced("hit", (__S1.hit)) end
do __S1.sell = __S1.traced("sell", (__S1.sell)) end
do __S1.research = __S1.traced("research", (__S1.research)) end
do __S1.place = __S1.traced("place", (__S1.place)) end
do __S1.improve = __S1.traced("improve", (__S1.improve)) end
do __S1.play = __S1.traced("play", (__S1.play)) end
do __S1.file = __S1.traced("file", (__S1.file)) end
do __S1.choose = __S1.traced("choose", (__S1.choose)) end
do __S1.takeOffer = __S1.traced("takeOffer", (__S1.takeOffer)) end
do __S1.declineOffer = __S1.traced("declineOffer", (__S1.declineOffer)) end
do
local sp
sp = __S1.startPhase
do __S1.startPhase = function(G, phase)  local r
r = sp(G, (phase))
if (phase == "biz") then
__S1.recRound((G))
end
do return (r) end
end end
end

do return (__mkO({["RING"]=__S1.RING, ["WORLD"]=__S1.WORLD, ["HOTN"]=__S1.HOTN, ["ROUGHN"]=__S1.ROUGHN, ["BONUS"]=__S1.BONUS, ["IMPY"]=__S1.IMPY, ["IMPC"]=__S1.IMPC, ["recordText"]=__S1.recordText, ["recOn"]=__S1.recOn, ["GENES"]=__S1.GENES, ["LEG"]=__S1.LEG, ["legacyGenome"]=__S1.legacyGenome, ["gv"]=__S1.gv, ["shelfOf"]=__S1.shelfOf, ["canImprove"]=__S1.canImprove, ["improve"]=__S1.improve, ["cellYield"]=__S1.cellYield, ["yields"]=__S1.yields, ["impIncome"]=__S1.impIncome, ["IMPR"]=__S1.IMPR, ["IMPON"]=__S1.IMPON, ["canScrap"]=__S1.canScrap, ["scrapM"]=__S1.scrapM, ["researchDeck"]=__S1.researchDeck, ["CMAX"]=__S1.CMAX, ["advTier"]=__S1.advTier, ["ABOARD"]=__S1.ABOARD, ["PDISC"]=__S1.PDISC, ["WINCARD"]=__S1.WINCARD, ["RROW"]=__S1.RROW, ["WINNEED"]=__S1.WINNEED, ["CONDS"]=__S1.CONDS, ["condOK"]=__S1.condOK, ["rbonus"]=__S1.rbonus, ["needFor"]=__S1.needFor, ["payFor"]=__S1.payFor, ["resCards"]=__S1.resCards, ["canTakeOffer"]=__S1.canTakeOffer, ["takeOffer"]=__S1.takeOffer, ["declineOffer"]=__S1.declineOffer, ["mapStyle"]=__S1.mapStyle, ["outpostN"]=__S1.outpostN, ["BOARDS"]=__S1.BOARDS, ["OUTPOST"]=__S1.OUTPOST, ["travel"]=__S1.travel, ["WIN"]=__S1.WIN, ["stipend"]=__S1.stipend, ["UD"]=__S1.UD, ["UDF"]=__S1.UDF, ["ADVISORS"]=__S1.ADVISORS, ["ROW"]=__S1.ROW, ["POACH"]=__S1.POACH, ["hasA"]=__S1.hasA, ["used"]=__S1.used, ["drawCost"]=__S1.drawCost, ["canHire"]=__S1.canHire, ["hire"]=__S1.hire, ["canHit"]=__S1.canHit, ["hit"]=__S1.hit, ["canSell"]=__S1.canSell, ["sell"]=__S1.sell, ["canVacate"]=__S1.canVacate, ["FAMS"]=__S1.FAMS, ["FNAME"]=__S1.FNAME, ["FDIR"]=__S1.FDIR, ["ARROW"]=__S1.ARROW, ["FLAVOR"]=__S1.FLAVOR, ["DRAW"]=__S1.DRAW, ["TAKE"]=__S1.TAKE, ["KEEP"]=__S1.KEEP, ["MAXSTAR"]=__S1.MAXSTAR, ["TX"]=__S1.TX, ["ERAS"]=__S1.ERAS, ["OVER"]=__S1.OVER, ["LOYE"]=__S1.LOYE, ["trackLen"]=__S1.trackLen, ["STARCASH"]=__S1.STARCASH, ["TILESET"]=__S1.TILESET, ["BLANK"]=__S1.BLANK, ["starText"]=__S1.starText, ["income"]=__S1.income, ["INCB"]=__S1.INCB, ["INCK"]=__S1.INCK, ["CASH0"]=__S1.CASH0, ["LOY0"]=__S1.LOY0, ["TOKN"]=__S1.TOKN, ["INFC"]=__S1.INFC, ["MSIZE"]=__S1.MSIZE, ["FM"]=__S1.FM, ["FILECARDS"]=__S1.FILECARDS, ["MAXROUND"]=__S1.MAXROUND, ["SLOTS"]=__S1.SLOTS, ["MKT"]=__S1.MKT, ["BANDS"]=__S1.BANDS, ["TOL"]=__S1.TOL, ["bandOf"]=__S1.bandOf, ["START"]=__S1.START, ["MACHINES"]=__S1.MACHINES, ["MAT"]=__S1.MAT, ["MID"]=__S1.MID, ["ICARD"]=__S1.ICARD, ["IDECK"]=__S1.IDECK, ["MEMOS"]=__S1.MEMOS, ["COLORS"]=__S1.COLORS, ["newGame"]=__S1.newGame, ["co"]=__S1.co, ["cell"]=__S1.cell, ["toks"]=__S1.toks, ["ownerOf"]=__S1.ownerOf, ["controlled"]=__S1.controlled, ["homeOf"]=__S1.homeOf, ["dist"]=__S1.dist, ["tokCost"]=__S1.tokCost, ["handSize"]=__S1.handSize, ["topEra"]=__S1.topEra, ["tolerance"]=__S1.tolerance, ["onMap"]=__S1.onMap, ["bailCost"]=__S1.bailCost, ["fuel"]=__S1.fuel, ["actTargets"]=__S1.actTargets, ["canStand"]=__S1.canStand, ["stand"]=__S1.stand, ["canDraw"]=__S1.canDraw, ["draw"]=__S1.draw, ["pick"]=__S1.pick, ["canTake"]=__S1.canTake, ["take"]=__S1.take, ["canRun"]=__S1.canRun, ["run"]=__S1.run, ["canBuy"]=__S1.canBuy, ["buy"]=__S1.buy, ["canResearch"]=__S1.canResearch, ["research"]=__S1.research, ["canPlace"]=__S1.canPlace, ["place"]=__S1.place, ["canLobby"]=__S1.canLobby, ["lobby"]=__S1.lobby, ["canBail"]=__S1.canBail, ["bail"]=__S1.bail, ["canPlay"]=__S1.canPlay, ["play"]=__S1.play, ["canFile"]=__S1.canFile, ["file"]=__S1.file, ["canChoose"]=__S1.canChoose, ["choose"]=__S1.choose, ["pass"]=__S1.pass, ["botStep"]=__S1.botStep, ["plan"]=__S1.plan, ["getOps"]=function()  
do return __S1.ops end
end, ["resetOps"]=function()  
do __S1.ops = 0 end
end}, {"RING", "WORLD", "HOTN", "ROUGHN", "BONUS", "IMPY", "IMPC", "recordText", "recOn", "GENES", "LEG", "legacyGenome", "gv", "shelfOf", "canImprove", "improve", "cellYield", "yields", "impIncome", "IMPR", "IMPON", "canScrap", "scrapM", "researchDeck", "CMAX", "advTier", "ABOARD", "PDISC", "WINCARD", "RROW", "WINNEED", "CONDS", "condOK", "rbonus", "needFor", "payFor", "resCards", "canTakeOffer", "takeOffer", "declineOffer", "mapStyle", "outpostN", "BOARDS", "OUTPOST", "travel", "WIN", "stipend", "UD", "UDF", "ADVISORS", "ROW", "POACH", "hasA", "used", "drawCost", "canHire", "hire", "canHit", "hit", "canSell", "sell", "canVacate", "FAMS", "FNAME", "FDIR", "ARROW", "FLAVOR", "DRAW", "TAKE", "KEEP", "MAXSTAR", "TX", "ERAS", "OVER", "LOYE", "trackLen", "STARCASH", "TILESET", "BLANK", "starText", "income", "INCB", "INCK", "CASH0", "LOY0", "TOKN", "INFC", "MSIZE", "FM", "FILECARDS", "MAXROUND", "SLOTS", "MKT", "BANDS", "TOL", "bandOf", "START", "MACHINES", "MAT", "MID", "ICARD", "IDECK", "MEMOS", "COLORS", "newGame", "co", "cell", "toks", "ownerOf", "controlled", "homeOf", "dist", "tokCost", "handSize", "topEra", "tolerance", "onMap", "bailCost", "fuel", "actTargets", "canStand", "stand", "canDraw", "draw", "pick", "canTake", "take", "canRun", "run", "canBuy", "buy", "canResearch", "research", "canPlace", "place", "canLobby", "lobby", "canBail", "bail", "canPlay", "play", "canFile", "file", "canChoose", "choose", "pass", "botStep", "plan", "getOps", "resetOps"})) end
end)()
if (__typeof(JS_module) ~= "undefined") then
do local __v895 = JS_module; local __v896 = "exports"; local __v897 = E; __set(__v895, __v896, __v897) end
end
return E
end

--[[ Sour Empire for Tabletop Simulator: the table.
  The rules engine is the browser game's own engine, compiled to Lua (engine.lua, with runtime.lua for JavaScript semantics).
  Three ways to play, chosen at setup:
    full   the engine runs the game: players act from their panel and by clicking markets; pieces follow the engine; bots can sit in.
    arith  the table is the truth: players move everything themselves; buttons work out payday, loyalty and token costs.
    log    the table is the truth: nothing is checked; every move is written down.
  Every mode keeps a record you can copy from the Notebook (Sour Empire record tab). ]]

local VERSION = 'tts-1'
local SEATCOL = { 'Red', 'Blue', 'Green' }
local RGB = { Red = { 0.85, 0.28, 0.23 }, Blue = { 0.18, 0.47, 0.82 }, Green = { 0.18, 0.62, 0.36 } }
local CARD_W, CARD_H = 2.14, 3.05 -- a Tabletop Simulator card at scale 1
local Y = 1.12                    -- height of the board surfaces

S = S or nil -- the saved state
local objs = {}   -- key -> object we spawned
local want = {}   -- key -> what should be on the table now
local ui = { impMode = false }
local busy = false

--[[ ---------- values: the engine's arrays are 0-based with their length in __n ---------- ]]
local function alen(a) return a and a.__n or 0 end
local function aget(a, i) return a and a[i] end
local function each(a) local i = -1; local n = alen(a); return function() i = i + 1; if i < n then return i, a[i] end end end
local function jsA(t) local a = { __n = #t }; for i = 1, #t do a[i - 1] = t[i] end return __mkA(a) end
local function jsO(t, keys) return __mkO(t, keys) end
local function ok(x) return x and x.ok end
local function alive(o) if o == nil then return false end local okk, g = pcall(function() return o.getGUID() end); return okk and g ~= nil end

-- lossless save format for engine values: arrays as ["\1", ...], numeric object keys as "#n"
local function ser(v, out)
  local ty = type(v)
  if v == nil then out[#out + 1] = 'null'
  elseif ty == 'boolean' then out[#out + 1] = v and 'true' or 'false'
  elseif ty == 'number' then out[#out + 1] = (v ~= v) and '"\2NaN"' or (v == math.huge and '"\2inf"' or (v == -math.huge and '"\2-inf"' or __numstr(v)))
  elseif ty == 'string' then out[#out + 1] = JS_JSON.stringify(v)
  elseif ty == 'table' then
    if __isarr(v) then out[#out + 1] = '["\1"'; for i = 0, v.__n - 1 do out[#out + 1] = ','; ser(v[i], out) end out[#out + 1] = ']'
    else out[#out + 1] = '{'; local first = true
      for _, k in ipairs(__keys(v)) do local x = v[k]; if x ~= nil and type(x) ~= 'function' and not (type(x) == 'table' and getmetatable(x) and not __isarr(x)) then
        if not first then out[#out + 1] = ',' end first = false
        out[#out + 1] = JS_JSON.stringify(type(k) == 'number' and ('#' .. __numstr(k)) or k); out[#out + 1] = ':'; ser(x, out) end end
      out[#out + 1] = '}' end
  end
end
local function serialize(v) local out = {}; ser(v, out); return table.concat(out) end
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
function utf8char(c)
  if c < 0x800 then return string.char(0xC0 + math.floor(c / 64), 0x80 + c % 64) end
  return string.char(0xE0 + math.floor(c / 4096), 0x80 + math.floor(c / 64) % 64, 0x80 + c % 64)
end

--[[ ---------- geometry: boards and their slots ---------- ]]
-- each board: centre (x, z), size (w, h) in table units, turn (degrees about y)
local BOARD = {}
local function placeBoards(n)
  BOARD.felt = { x = 0, z = 2.5, w = LAYOUT.files.felt.w, h = LAYOUT.files.felt.h, rot = 0, file = 'felt' }
  BOARD.common = { x = 0, z = 19.4, w = LAYOUT.common.w, h = LAYOUT.common.h, rot = 0, file = 'board-common', L = LAYOUT.common }
  local M = LAYOUT['map' .. n]; BOARD.map = { x = 0, z = 0, w = M.w, h = M.h, rot = 0, file = 'board-map' .. n, L = M }
  local spots = { { 0, -15.9, 0 }, { -25.1, 0, 90 }, { 25.1, 0, 270 } }
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
local function tf(p, roty, sc, flip) return { posX = p.x, posY = p.y, posZ = p.z, rotX = 0, rotY = roty or 0, rotZ = flip and 180 or 0, scaleX = sc[1], scaleY = 1, scaleZ = sc[2] } end
local function cardData(key, cardKey, p, roty, sc, flip, locked)
  local c = CARDS[cardKey]; if not c then error('no card ' .. tostring(cardKey)) end
  return { Name = 'CardCustom', Transform = tf(p, roty, sc, flip), CardID = c.id * 100 + c.cell, CustomDeck = customDeck(c), GMNotes = 'se|' .. key, Nickname = '', Locked = locked ~= false, Hands = true, SidewaysCard = false }
end
local function spawnFrom(key, data, after)
  local o = spawnObjectData({ data = data, callback_function = function(obj) if after then after(obj) end end })
  objs[key] = o; return o
end
local function card(key, cardKey, p, opt) opt = opt or {}
  want[key] = { kind = 'card', card = cardKey, p = p, rot = opt.rot or 0, sc = opt.sc or { 1, 1 }, flip = opt.flip, hand = opt.hand, tap = opt.tap, label = opt.label } end
local function chip(key, col, p, sc) want[key] = { kind = 'chip', col = col, p = p, sc = sc or 0.55 } end
local function pawn(key, col, p) want[key] = { kind = 'pawn', col = col, p = p } end
local function text(key, s, p, rot, size, col) want[key] = { kind = 'text', s = s, p = p, rot = rot or 0, size = size or 40, col = col } end

local function colorOf(c) if type(c) == 'string' then local r = RGB[c] or { 1, 1, 1 }; return { r = r[1], g = r[2], b = r[3] } end return { r = c[1], g = c[2], b = c[3] } end
local function spawnWanted(key, w)
  if w.kind == 'card' then
    local d = cardData(key, w.card, w.hand and { x = w.p.x, y = w.p.y + 2, z = w.p.z } or w.p, w.rot + (w.tap and 90 or 0), w.sc, w.flip, not w.hand)
    return spawnFrom(key, d)
  elseif w.kind == 'chip' then
    return spawnFrom(key, { Name = w.col == 'gold' and 'Chip_1000' or 'Chip_10', Transform = tf(w.p, 0, { w.sc, w.sc }), ColorDiffuse = w.col == 'gold' and { r = 0.89, g = 0.67, b = 0.11 } or colorOf(w.col), GMNotes = 'se|' .. key, Locked = true })
  elseif w.kind == 'pawn' then
    return spawnFrom(key, { Name = 'PlayerPawn', Transform = tf(w.p, 0, { 0.45, 0.45 }), ColorDiffuse = colorOf(w.col), GMNotes = 'se|' .. key, Locked = true })
  elseif w.kind == 'text' then
    return spawnFrom(key, { Name = '3DText', Transform = { posX = w.p.x, posY = w.p.y + 0.05, posZ = w.p.z, rotX = 90, rotY = w.rot, rotZ = 0, scaleX = 1, scaleY = 1, scaleZ = 1 },
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
      elseif w.kind == 'card' and last[key] and (last[key].card ~= w.card or last[key].hand ~= w.hand) then o.destruct(); objs[key] = nil; spawnWanted(key, w)
      elseif w.kind == 'card' and w.hand then -- hand cards stay where the hand puts them
      else o.setPositionSmooth({ w.p.x, w.p.y, w.p.z }, false, true); if w.kind == 'card' then o.setRotationSmooth({ 0, (w.rot or 0) + (w.tap and 90 or 0), w.flip and 180 or 0 }, false, true) end end
      last[key] = w
    end
  end
end
local function clearAll() for key, o in pairs(objs) do if alive(o) then o.destruct() end end objs = {}; want = {}; last = {} end
local function boardsUp(n)
  placeBoards(n)
  for _, b in ipairs({ 'felt', 'common', 'map', 'mat0', 'mat1', 'mat2' }) do local B = BOARD[b]
    if B and not objs['board:' .. b] then
      local p = { x = B.x, y = (b == 'felt') and 0.9 or 1.0, z = B.z }
      objs['board:' .. b] = spawnObjectData({ data = { Name = 'Custom_Tile', Transform = tf(p, B.rot, { 1, 1 }), Locked = true, GMNotes = 'se|board:' .. b,
        CustomImage = { ImageURL = IMG .. B.file .. '.png', ImageSecondaryURL = '', ImageScalar = 1, WidthScale = 0, CustomTile = { Type = 0, Thickness = 0.1, Stackable = false, Stretch = true } } },
        callback_function = function(o) local bd = o.getBoundsNormalized(); local sz = bd.size
          local wx = (B.rot % 180 == 0) and sz.x or sz.z
          if wx and wx > 0 then local k = B.w / wx; o.setScale({ k, 1, k }) end
          o.interactable = (b ~= 'felt') and false or false end })
    end
  end
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
    card('tile:' .. c.id, 'tile:' .. c.name, base, { sc = { 2.8 / CARD_W, 2.8 / CARD_H } })
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
  card('deck:mach', 'mach:hands', slot('common', 'mdeck'), { flip = true }); text('n:mdeck', alen(G.mdeck) .. ' left', slot('common', 'mdeck', 0, 2.0), 0, 30)
  card('deck:ing', 'ing:sour:Lemon', slot('common', 'ideck'), { flip = true }); text('n:ideck', alen(G.deck) .. ' cards', slot('common', 'ideck', 0, 2.0), 0, 30)
  for _, f in ipairs(FAMS) do local pile = G.piles[f]; local np = alen(pile)
    if np > 0 then local top = pile[np - 1]; card('pile:' .. f, 'ing:' .. f .. ':' .. top.n, slot('common', 'pile_' .. f)) end
    text('n:pile:' .. f, np .. ' in pile', slot('common', 'pile_' .. f, 0, 2.0), 0, 30) end
  if G.choice then for i, c in each(G.choice.cards) do if not c.taken then card('choice:' .. i, 'ing:' .. c.f .. ':' .. c.n, slot('common', 'choice' .. i)) end end end
  for i = 0, alen(G.rrow) - 1 do local c = G.rrow[i]; if c then card('rrow:' .. i, 'res:' .. c.id, slot('common', 'rrow' .. i), { flip = true }) end end
  if alen(G.rdeck) > 0 then card('deck:res', 'adv:' .. E.ADVISORS[0].id, slot('common', 'rdeck'), { flip = true }) end
  text('n:rdeck', alen(G.rdeck) .. ' left', slot('common', 'rdeck', 0, 2.0), 0, 30)
  for i, a in each(G.arow) do card('arow:' .. i, 'adv:' .. a.id, slot('common', 'arow' .. i)) end
  if G.offer then card('offer', 'adv:' .. G.offer.a.id, slot('common', 'memoplay', 0, 0, 0.4)) end
  if alen(G.ideck) > 0 then card('deck:inf', 'inf:recall:0', slot('common', 'infdeck'), { flip = true }) end
  text('n:infdeck', alen(G.ideck) .. ' left', slot('common', 'infdeck', 0, 2.0), 0, 30)
  local nd = alen(G.idisc); if nd > 0 then local c = G.idisc[nd - 1]; if c and CARDS['inf:' .. c.t .. ':' .. c.x] then card('infdisc', 'inf:' .. c.t .. ':' .. c.x, slot('common', 'infdisc')) end end
  card('deck:memo', 'memo:0', slot('common', 'memodeck'), { flip = true }); text('n:memo', (alen(E.MEMOS) - (G.memoAt or 0)) .. ' left', slot('common', 'memodeck', 0, 2.0), 0, 30)
  if G.pending then card('memoplay', 'memo:' .. G.pending.id, slot('common', 'memoplay')) end
  pawn('round', { 0.95, 0.82, 0.25 }, slot('common', 'round' .. math.min(G.round, E.MAXROUND)))
  pawn('heat', { 0.89, 0.34, 0.18 }, slot('common', 'heat' .. math.max(0, math.min(G.heat, 8))))
  -- the companies
  for pi, p in each(G.players) do local mat = 'mat' .. pi; local B = BOARD[mat]
    local fl = 0
    for i, m in each(p.mach) do card('floor:' .. pi .. ':m' .. i, 'mach:' .. m.id, slot(mat, 'floor' .. fl), { rot = B.rot, tap = m.ran }); fl = fl + 1 end
    for i, a in each(p.adv) do card('floor:' .. pi .. ':a' .. i, 'adv:' .. a.id, slot(mat, 'floor' .. fl), { rot = B.rot }); fl = fl + 1 end
    for i, m in each(p.shelf) do card('shelf:' .. pi .. ':' .. i, 'mach:' .. m.id, slot(mat, 'shelf', -2.9 + i * 0.95, 0, 0.02 * i), { rot = B.rot, sc = { 0.78, 0.78 } }) end
    for i, t in each(p.tiles) do if CARDS['res:' .. t.id] then card('tiles:' .. pi .. ':' .. i, 'res:' .. t.id, slot(mat, 'tiles', -2.4 + i * 0.95, 0, 0.02 * i), { rot = B.rot, sc = { 0.78, 0.78 } }) end end
    pawn('era:' .. pi, SEATCOL[pi + 1], slot(mat, 'era' .. math.min(p.era, 12)))
    local tl = E.trackLen(p)
    if p.prog > 0 then pawn('prog:' .. pi, SEATCOL[pi + 1], slot(mat, 'trk' .. math.min(p.prog, tl) - 1)) end
    local cover = E.TX - tl; local cont = math.min(p.cont or 0, cover)
    for k = 0, cover - 1 do local sp = E.TX - 1 - k; chip('cover:' .. pi .. ':' .. k, k < cont and { 0.12, 0.42, 0.29 } or { 0.96, 0.77, 0.19 }, slot(mat, 'trk' .. sp), 0.5) end
    local hand = p.hand
    text('lab:name:' .. pi, (p.name or SEATCOL[pi + 1]) .. ' · era ' .. p.era .. (p.bot and ' (bot)' or ''), slot(mat, 'name'), B.rot, 34, SEATCOL[pi + 1])
    text('lab:cash:' .. pi, tostring(p.cash), slot(mat, 'cash', 0, 0.15), B.rot, 70)
    text('lab:loy:' .. pi, tostring(p.loy), slot(mat, 'loy', 0, 0.15), B.rot, 70)
    text('lab:stars:' .. pi, E.starText(p.stars), slot(mat, 'stars', 0, 0.15), B.rot, 34)
    text('lab:imp:' .. pi, tostring(p.imp or 0), slot(mat, 'imp', 0, 0.15), B.rot, 70)
    text('lab:hand:' .. pi, (hand.sweet or 0) .. ' / ' .. (hand.sour or 0) .. ' / ' .. (hand.herb or 0) .. ' / ' .. (hand.fizz or 0), slot(mat, 'hand', 0, 0.15), B.rot, 34)
    text('lab:inf:' .. pi, tostring(alen(p.inf)), slot(mat, 'inf', 0, 0.15), B.rot, 70)
    text('lab:note:' .. pi, (p.prog .. ' of ' .. tl .. ' pitchers to era ' .. (p.era + 1)) .. (p.jail and '\nIn custody' or ''), slot(mat, 'note'), B.rot, 26)
    -- hands: ingredient cards and influence cards, hidden
    local col = SEATCOL[pi + 1]; local ht = Player[col] and Player[col].getHandTransform and Player[col].getHandTransform()
    if ht then local hp = { x = ht.position.x, y = ht.position.y, z = ht.position.z }
      for _, f in ipairs(FAMS) do local fl2 = E.FLAVOR[f]; for k = 0, (hand[f] or 0) - 1 do card('hand:' .. pi .. ':' .. f .. ':' .. k, 'ing:' .. f .. ':' .. fl2[k % alen(fl2)], hp, { hand = true, rot = B.rot + 180 }) end end
      for _, c in each(p.inf) do if CARDS['inf:' .. c.t .. ':' .. c.x] then card('hinf:' .. pi .. ':' .. c.u, 'inf:' .. c.t .. ':' .. c.x, hp, { hand = true, rot = B.rot + 180 }) end end
    end
  end
  -- what is happening
  local a = actor(); local p = P(a)
  local lines = {}
  local nl = alen(G.log); for k = math.max(0, nl - 4), nl - 1 do lines[#lines + 1] = G.log[k].text end
  local head = G.winner ~= nil and (P(G.winner).name .. ' wins.') or ('Round ' .. G.round .. ' · ' .. ({ stand = 'setup', biz = 'the market', place = 'the map', memo = 'payday memos' })[G.phase] .. ' · ' .. p.name .. ' to act')
  text('status', head .. '\n' .. table.concat(lines, '\n'), slot('common', 'status'), 0, 26)
end

--[[ ---------- the action panel ---------- ]]
local function esc(s) return (tostring(s):gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;'):gsub('"', '&quot;')) end
local function costTxt(x) if not x or not x.cost then return '' end local t = {}
  for _, k in ipairs(__keys(x.cost)) do local v = x.cost[k]; if v and v ~= 0 then t[#t + 1] = v .. ({ cash = ' Capital', loy = ' loyalty', cont = ' control', card = ' cards' })[k] or (v .. ' ' .. k) end end
  return #t > 0 and (' (' .. table.concat(t, ', ') .. ')') or '' end
local btns, dialog = {}, nil
local function B(id, label, x) if x == nil or ok(x) then btns[#btns + 1] = { id = id, label = label .. costTxt(x) } end end
local function humanColor(pi) return S.seats[pi + 1].human and SEATCOL[pi + 1] or nil end
local function canAct(color) if not S or not S.G or S.G.winner ~= nil then return false end
  local a = actor(); if not S.seats[a + 1].human then return false end
  return S.anyone or color == SEATCOL[a + 1] end

local function buildActions()
  btns, dialog = {}, nil
  local G = S.G; if G.winner ~= nil then return end
  local a = actor(); local p = P(a)
  if not S.seats[a + 1].human then return end
  if G.pending then local m = E.MEMOS[G.pending.id]
    dialog = 'Memo to ' .. p.name .. ': ' .. m.title .. '\n' .. m.body
    for i, o in each(m.opts) do local x = E.canChoose(G, i); if ok(x) then B('memo_' .. i, o.label) end end
    if #btns == 0 then B('memo_-1', 'Read it') end
    return end
  if G.choice then dialog = 'Keep one of the three cards you turned over.'
    for i, c in each(G.choice.cards) do if not c.taken then B('pick_' .. i, 'Keep ' .. c.n .. ' (' .. E.FNAME[c.f] .. ')') end end return end
  if ui.scrapFor then dialog = 'Your floor is full. Free a slot: a machine goes to your shelf; an advisor leaves.'
    for i, m in each(p.mach) do B('scrap_' .. i, 'Scrap ' .. m.name) end
    for i, ad in each(p.adv) do B('scrap_a' .. i, 'Let ' .. ad.name .. ' go') end
    B('noscrap', 'Cancel'); return end
  if G.offer then dialog = 'Your research turned up ' .. G.offer.a.name .. ' (' .. G.offer.a.role .. '). ' .. G.offer.a.text
    B('otake', 'Hire for ' .. (G.offer.a.price or 0) .. ' Capital', E.canTakeOffer(G)); B('opass', 'Pass'); return end
  if ui.disc then local D = ui.disc; dialog = 'Choose ' .. D.need .. ' influence card(s) to discard.'
    for _, c in each(p.inf) do if c.u ~= D.u then B('dpick_' .. c.u, (D.chosen[c.u] and '[x] ' or '[ ] ') .. E.ICARD[c.t].name) end end
    B('dok', 'Done'); B('dno', 'Cancel'); return end
  if ui.sel then local c; for _, k in each(p.inf) do if k.u == ui.sel then c = k end end
    if c then local d = E.ICARD[c.t]; dialog = d.name .. ': choose a target. ' .. d.text
      local extra = jsA(ui.marks or {})
      if d.target == 'player' then for pi, q in each(G.players) do local x = E.canPlay(G, ui.sel, pi, extra); if ok(x) then B('tgt_' .. pi, q.name) end end
      elseif d.target == 'cell' then for _, cl in each(G.map.cells) do local x = E.canPlay(G, ui.sel, cl.id, extra); if ok(x) then B('tgt_' .. cl.id, cl.name) end end
      elseif d.target == 'tile' then for k = 0, alen(G.rrow) - 1 do local x = E.canPlay(G, ui.sel, k, extra); if ok(x) then B('tgt_' .. k, 'Research row card ' .. (k + 1)) end end
      elseif d.target == 'rtile' then for pi, q in each(G.players) do for k, t in each(q.tiles) do local x = E.canPlay(G, ui.sel, pi * 1000 + k, extra); if ok(x) then B('tgt_' .. (pi * 1000 + k), q.name .. ': ' .. t.name) end end end end
      B('nosel', 'Cancel') end
    return end
  if G.phase == 'biz' then
    if ok(E.canBail(G)) then B('bail', 'Post bail', E.canBail(G)) end
    B('draw', 'Buy three, keep one', E.canDraw(G))
    for _, f in ipairs(FAMS) do B('take_' .. f, 'Buy ' .. E.FNAME[f] .. ' from the pile', E.canTake(G, f)) end
    for i, m in each(p.mach) do
      B('run_' .. i, 'Run ' .. m.name, E.canRun(G, i))
      B('frun_' .. i, 'Free run: ' .. m.name, E.canRun(G, i, 'free')); B('rerun_' .. i, 'Re-run ' .. m.name, E.canRun(G, i, 'rerun')); B('hal_' .. i, 'HAL runs ' .. m.name, E.canRun(G, i, true)) end
    for i, m in each(G.mkt) do B('buy_' .. i, 'Buy ' .. m.name, E.canBuy(G, i)) end
    for k = 0, alen(G.rrow) - 1 do local c = G.rrow[k]; if c then B('research_' .. k, (c.win and 'Research the Secret Formula' or ('Research row card ' .. (k + 1) .. ' (tier ' .. c.tier .. ')')), E.canResearch(G, k)) end end
    for k, ad in each(G.arow) do B('hire_' .. k, 'Hire ' .. ad.name, E.canHire(G, k)) end
    for pi, q in each(G.players) do if pi ~= a then for k, ad in each(q.adv) do B('poach_' .. pi .. '_' .. k, 'Hire away ' .. ad.name, E.canHire(G, k, pi)); B('hit_' .. pi .. '_' .. k, 'Hit ' .. ad.name, E.canHit(G, pi, k)) end end end
    B('lobby', 'Buy influence', E.canLobby(G)); B('sell_1', 'Sell Paul 1 Acidic card (+2 Capital)', E.canSell(G)); if (p.hand.sour or 0) >= 2 then B('sell_2', 'Sell Paul 2 Acidic cards (+4 Capital)', E.canSell(G)) end
    for _, c in each(p.inf) do B('iplay_' .. c.u, 'Play ' .. E.ICARD[c.t].name, { ok = true }) end
    for i, m in each(p.mach) do if ok(E.canScrap(G, i)) then B('mscrap_' .. i, 'Scrap ' .. m.name .. ' to the shelf') end end
    B('pass', 'Pass for the rest of the market')
  elseif G.phase == 'place' then
    dialog = ui.impMode and 'Click a market you control to put a capital token on it.' or ('Click a market to place loyalty. Loyalty: ' .. p.loy .. '.')
    if (p.imp or 0) > 0 then B('impmode', ui.impMode and 'Back to loyalty' or ('Place a capital token (' .. p.imp .. ')')) end
    for _, c in each(p.inf) do B('iplay_' .. c.u, 'Play ' .. E.ICARD[c.t].name, { ok = true }) end
    B('pass', 'Done placing')
  end
end

local function setupXml()
  local opts = { 'Human', 'Bot: champion', 'Bot: generalist', 'Bot: manufacturer', 'Bot: producer', 'Bot: distributor' }
  local seats = ''
  for i = 1, 3 do local o = ''; for _, x in ipairs(opts) do o = o .. '<Option' .. ((S.setup.seats[i] == x) and ' selected="true"' or '') .. '>' .. x .. '</Option>' end
    seats = seats .. '<HorizontalLayout preferredHeight="40" spacing="8"><Text color="' .. ({ '#e05a4c', '#4b8fe0', '#43b06c' })[i] .. '" fontSize="20" preferredWidth="110">' .. SEATCOL[i] .. '</Text><Dropdown id="seat' .. i .. '" onValueChanged="uiSeat" preferredWidth="330">' .. o .. '</Dropdown></HorizontalLayout>' end
  local function radio(id, val, label, cur) return '<Button id="' .. id .. '_' .. val .. '" onClick="uiSetup" colors="' .. (cur == val and '#f4d03f|#ffe27a|#d8b52a|#888888' or '#efe6d2|#ffffff|#cfc4aa|#888888') .. '" preferredHeight="36">' .. label .. '</Button>' end
  return '<Panel id="setup" width="560" height="560" color="#2b1a14f2" outline="#f4d03f" outlineSize="2 2"><VerticalLayout padding="18" spacing="10" childForceExpandHeight="false">' ..
    '<Text fontSize="34" fontStyle="Bold" color="#f4d03f">Sour Empire</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('np', 2, 'Two players', S.setup.np) .. radio('np', 3, 'Three players', S.setup.np) .. '</HorizontalLayout>' ..
    seats ..
    '<Text fontSize="18" color="#efe6d2" alignment="MiddleLeft">How much should the table enforce?</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('mode', 'full', 'Full rules', S.setup.mode) .. radio('mode', 'arith', 'Arithmetic only', S.setup.mode) .. radio('mode', 'log', 'None, just log', S.setup.mode) .. '</HorizontalLayout>' ..
    '<Text fontSize="15" color="#cfc4aa" alignment="MiddleLeft">Bots need full rules. In the other modes, bot seats are left empty.</Text>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('speed', 0.4, 'Bots fast', S.setup.speed) .. radio('speed', 1.2, 'Bots steady', S.setup.speed) .. radio('speed', 2.5, 'Bots slow', S.setup.speed) .. '</HorizontalLayout>' ..
    '<HorizontalLayout preferredHeight="40" spacing="8">' .. radio('anyone', 'yes', 'Anyone may act for human seats', S.setup.anyone) .. radio('anyone', 'no', 'Only the seated player', S.setup.anyone) .. '</HorizontalLayout>' ..
    '<Button id="start" onClick="uiStart" preferredHeight="50" fontSize="22" colors="#2f9e5b|#43b06c|#227a45|#888888" textColor="#ffffff">Set up the table</Button>' ..
    '</VerticalLayout></Panel>'
end
local function panelXml()
  local x = '<Panel id="tools" rectAlignment="UpperRight" width="230" height="' .. (S.mode == 'full' and 90 or 250) .. '" offsetXY="-10 -60" color="#2b1a14e6"><VerticalLayout padding="6" spacing="4">'
  x = x .. '<Button id="rec" onClick="uiRecord">Write the record to the Notebook</Button>'
  if S.mode ~= 'full' then
    x = x .. '<Button id="snap" onClick="uiSnap">Note the table as it stands</Button>'
    if S.mode == 'arith' then x = x .. '<Button id="payday" onClick="uiPayday">Work out payday</Button><Button id="stipend" onClick="uiStipend">Loyalty for the map phase</Button><Button id="costs" onClick="uiCosts">Show token costs</Button>' end
  end
  x = x .. '<Button id="newgame" onClick="uiNew">New game</Button></VerticalLayout></Panel>'
  if S.mode ~= 'full' or not S.G then return x end
  buildActions()
  local a = actor(); local col = SEATCOL[a + 1]
  local vis = S.anyone and '' or (' visibility="' .. col .. '"')
  local rows = math.ceil(#btns / 3)
  local h = 70 + rows * 40 + (dialog and 70 or 0)
  x = x .. '<Panel id="act" rectAlignment="LowerCenter" width="980" height="' .. h .. '" offsetXY="0 12" color="#2b1a14ee"' .. vis .. '><VerticalLayout padding="8" spacing="6" childForceExpandHeight="false">'
  x = x .. '<Text fontSize="18" color="#f4d03f" preferredHeight="26">' .. esc(P(a).name .. ' (' .. col .. ') to act') .. '</Text>'
  if dialog then x = x .. '<Text fontSize="15" color="#efe6d2" preferredHeight="64" alignment="UpperLeft">' .. esc(dialog) .. '</Text>' end
  if #btns > 0 then x = x .. '<GridLayout cellSize="315 34" spacing="6 6" preferredHeight="' .. (rows * 40) .. '">'
    for _, b in ipairs(btns) do x = x .. '<Button id="a_' .. b.id .. '" onClick="uiAct" fontSize="14">' .. esc(b.label) .. '</Button>' end
    x = x .. '</GridLayout>' end
  x = x .. '</VerticalLayout></Panel>'
  return x
end
local lastXml = nil
local function refreshUI()
  local x = S.mode == 'setup' and setupXml() or panelXml()
  if x ~= lastXml then UI.setXml(x); lastXml = x end
end

--[[ ---------- markets you can click ---------- ]]
local function cellButtons()
  for key, o in pairs(objs) do if key:sub(1, 5) == 'tile:' and alive(o) then o.clearButtons() end end
  if S.mode ~= 'full' or not S.G or S.G.winner ~= nil or S.G.phase ~= 'place' then return end
  local a = actor(); if not S.seats[a + 1].human or S.G.pending or S.G.offer then return end
  for _, c in each(S.G.map.cells) do local o = objs['tile:' .. c.id]
    if alive(o) then
      local x = ui.impMode and E.canImprove(S.G, c.id) or E.canPlace(S.G, c.id)
      if ok(x) then o.createButton({ click_function = 'onCellClick', function_owner = Global, label = ui.impMode and 'Invest' or ('Place ' .. ((x.cost and x.cost.loy) or '')), position = { 0, 0.3, 0 },
        width = 900, height = 420, font_size = 220, color = { 0.17, 0.1, 0.08, 0.85 }, font_color = { 1, 0.93, 0.6 }, scale = { 1 / (2.8 / CARD_W), 1, 1 / (2.8 / CARD_H) } }) end
    end
  end
end

--[[ ---------- the record ---------- ]]
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
  if S.mode == 'full' and S.G then buildWant(); apply(); Wait.frames(cellButtons, 2) end
  refreshUI()
  if S.mode == 'full' and S.G and S.G.winner ~= nil and not S.wroteEnd then S.wroteEnd = true; broadcastToAll(P(S.G.winner).name .. ' wins.', { 1, 0.9, 0.4 }); writeNotebook() end
  if S.mode == 'full' and S.G and S.G.winner == nil and not S.seats[actor() + 1].human and not busy then
    busy = true
    Wait.time(function() busy = false; if S.G and S.G.winner == nil and not S.seats[actor() + 1].human then
      local okk, err = pcall(function() E.botStep(S.G) end); if not okk then broadcastToAll('Bot error: ' .. tostring(err), { 1, 0.4, 0.4 }) end
      if S.lastRound ~= S.G.round then S.lastRound = S.G.round; if S.autoRec ~= false then pcall(writeNotebook) end end
      sync() end end, S.speed or 1.2)
  end
end
function onCellClick(obj, color, alt)
  if not canAct(color) then broadcastToColor('Not your turn.', color, { 1, 0.6, 0.6 }); return end
  local key = (obj.getGMNotes() or ''):match('^se|tile:(.+)$'); if not key then return end
  local done = ui.impMode and E.improve(S.G, key) or E.place(S.G, key)
  if done then ui.impMode = false end
  sync()
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
  elseif cmd == 'research' then acted = E.research(G, num(r1))
  elseif cmd == 'bail' then acted = E.bail(G)
  elseif cmd == 'lobby' then acted = E.lobby(G)
  elseif cmd == 'sell' then acted = E.sell(G, num(r1))
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
function uiAct(player, value, id)
  if not canAct(player.color) then broadcastToColor('Not your turn.', player.color, { 1, 0.6, 0.6 }); return end
  local okk, err = pcall(doAct, id:sub(3)); if not okk then broadcastToAll('Error: ' .. tostring(err), { 1, 0.4, 0.4 }) end
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
-- manual modes: the same deal as the engine's, laid out as loose pieces players move themselves
local function dealPhysical(G)
  want = {}
  local n = alen(G.players)
  S.cellName = {}
  for _, c in each(G.map.cells) do S.cellName[c.id] = c.name
    card('tile:' .. c.id, 'tile:' .. c.name, slot('map', c.id, 0, 0, 0.1), { sc = { 2.8 / CARD_W, 2.8 / CARD_H } })
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
    for i = #keys, 1, -1 do local c = CARDS[keys[i]]; if c then local d = cardData('d', keys[i], p, 0, { 1, 1 }, flip, false); d.GMNotes = 'se|c:' .. keys[i]; cds[#cds + 1] = d; ids[#ids + 1] = d.CardID
      for k, v in pairs(d.CustomDeck) do cd[k] = v end end end
    if #cds == 1 then cds[1].Transform = tf(p, 0, { 1, 1 }, flip); objs[key] = spawnObjectData({ data = cds[1] }); return end
    objs[key] = spawnObjectData({ data = { Name = 'Deck', Transform = tf(p, 0, { 1, 1 }, flip), DeckIDs = ids, CustomDeck = cd, ContainedObjects = cds, GMNotes = 'se|' .. key } })
  end
  local ing = {}; for _, c in each(G.deck) do ing[#ing + 1] = 'ing:' .. c.f .. ':' .. c.n end; deck('deck:ing', ing, slot('common', 'ideck'), true)
  local mach = {}; for _, m in each(G.mdeck) do mach[#mach + 1] = 'mach:' .. m.id end; deck('deck:mach', mach, slot('common', 'mdeck'), true)
  local res = {}; for _, c in each(G.rdeck) do res[#res + 1] = (c.kind == 'adv' and 'adv:' or 'res:') .. c.id end; deck('deck:res', res, slot('common', 'rdeck'), true)
  local inf = {}; for _, c in each(G.ideck) do inf[#inf + 1] = 'inf:' .. c.t .. ':' .. c.x end; deck('deck:inf', inf, slot('common', 'infdeck'), true)
  local memo = {}; for i = alen(E.MEMOS) - 1, 0, -1 do memo[#memo + 1] = 'memo:' .. i end; deck('deck:memo', memo, slot('common', 'memodeck'), true)
  local loose = function(key, ck, p, flip) local d = cardData(key, ck, p, 0, { 1, 1 }, flip, false); objs[key] = spawnObjectData({ data = d }) end
  for i, m in each(G.mkt) do loose('mkt:' .. i, 'mach:' .. m.id, slot('common', 'mkt' .. i)) end
  for i = 0, alen(G.rrow) - 1 do local c = G.rrow[i]; if c then loose('rrow:' .. i, 'res:' .. c.id, slot('common', 'rrow' .. i), true) end end
  for i, a in each(G.arow) do loose('arow:' .. i, 'adv:' .. a.id, slot('common', 'arow' .. i)) end
  -- each company: bare hands, starting cards in hand, counters, chips, markers
  for pi, p in each(G.players) do local mat = 'mat' .. pi; local B = BOARD[mat]; local col = SEATCOL[pi + 1]
    local d = cardData('m', 'mach:hands', slot(mat, 'floor0'), B.rot, { 1, 1 }, false, false); d.GMNotes = 'se|c:mach:hands'; objs['start:' .. pi] = spawnObjectData({ data = d })
    local ht = Player[col].getHandTransform and Player[col].getHandTransform()
    if ht then for _, f in ipairs(FAMS) do for k = 1, (p.hand[f] or 0) do local h = cardData('h', 'ing:' .. f .. ':' .. E.FLAVOR[f][(k - 1) % 5], { x = ht.position.x, y = ht.position.y + 2, z = ht.position.z }, B.rot + 180, { 1, 1 }, false, false); h.GMNotes = 'se|c:ing:' .. f; spawnObjectData({ data = h }) end end end
    for _, st in ipairs({ { 'cash', p.cash }, { 'loy', p.loy }, { 'stars', 0 }, { 'imp', 0 } }) do
      local q = slot(mat, st[1], 0, 0.15, 0.1)
      objs['ctr:' .. pi .. ':' .. st[1]] = spawnObjectData({ data = { Name = 'Counter', Transform = tf(q, B.rot, { 0.9, 0.9 }), GMNotes = 'se|ctr:' .. col .. ':' .. st[1], Counter = { value = st[2] } }, callback_function = function(o) if o.Counter then o.Counter.setValue(st[2]) end end })
    end
    objs['bag:' .. pi] = spawnObjectData({ data = { Name = 'Infinite_Bag', Transform = tf(slot(mat, 'note', 0, 0, 0.3), B.rot, { 0.8, 0.8 }), ColorDiffuse = colorOf(col), Nickname = col .. ' loyalty tokens',
      ContainedObjects = { { Name = 'Chip_10', ColorDiffuse = colorOf(col), Transform = tf({ x = 0, y = 0, z = 0 }, 0, { 0.55, 0.55 }), GMNotes = 'se|loy:' .. col } } } })
    objs['era:' .. pi] = spawnObjectData({ data = { Name = 'PlayerPawn', Transform = tf(slot(mat, 'era1'), 0, { 0.45, 0.45 }), ColorDiffuse = colorOf(col), Nickname = col .. ' era', GMNotes = 'se|era:' .. col } })
    objs['prog:' .. pi] = spawnObjectData({ data = { Name = 'Checker_white', Transform = tf(slot(mat, 'trk0', -0.9), 0, { 0.6, 0.6 }), ColorDiffuse = colorOf(col), Nickname = col .. ' era track', GMNotes = 'se|prog:' .. col } })
    for k = 1, (p.cont or 0) do objs['cont:' .. pi .. ':' .. k] = spawnObjectData({ data = { Name = 'Chip_10', Transform = tf(slot(mat, 'trk' .. (E.TX - k), 0, 0, 0.2), 0, { 0.5, 0.5 }), ColorDiffuse = { r = 0.12, g = 0.42, b = 0.29 }, Nickname = 'control token', GMNotes = 'se|cont:' .. col } }) end
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
    local col, what = note:match('^se|ctr:(%a+):(%a+)$'); if col and o.Counter then out[col] = out[col] or { objs = {} }; out[col][what] = o.Counter.getValue(); out[col].objs[what] = o end end
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
    if ctr[col] and ctr[col].objs.cash then ctr[col].objs.cash.Counter.setValue((ctr[col].cash or 0) + pay) end
    recPush({ what = 'payday', who = col, markets = r.markets, pay = pay, tokens = r.tokens }) end
  table.sort(lines); broadcastToAll('Payday. ' .. table.concat(lines, '  '), { 1, 0.9, 0.5 }); snapshot('payday')
end
function uiStipend(player)
  local lines = {}
  for _, o in ipairs(getObjects()) do local note = o.getGMNotes and o.getGMNotes() or ''; local col = note:match('^se|era:(%a+)$')
    if col then local w = where(o.getPosition()); local era = tonumber((w:match(':era(%d+)$')) or 1) or 1
      local add = E.LOYE[era - 1] or 1; local ctr = counters()[col]
      if ctr and ctr.objs.loy then ctr.objs.loy.Counter.setValue((ctr.loy or 0) + add) end
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
        color = { 0.17, 0.1, 0.08, 0.8 }, font_color = colorOf(col), scale = { 1 / (2.8 / CARD_W), 1, 1 / (2.8 / CARD_H) } }) end end end
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
  local okk, err = pcall(function()
    S.np = S.setup.np; S.mode = S.setup.mode; S.speed = S.setup.speed; S.anyone = S.setup.anyone == 'yes'
    S.seats = seatsFromSetup(); S.log = {}; S.wroteEnd = false
    clearAll(); boardsUp(S.np)
    local G = newEngineGame()
    if S.mode == 'full' then S.G = G; S.lastRound = G.round
      Wait.time(function() sync() end, 1.5)
    else S.G = nil; S.deal = G; Wait.time(function() dealPhysical(G); recPush({ what = 'setup', seats = S.seats, mode = S.mode }); snapshot('start'); refreshUI() end, 1.5) end
    lastXml = nil; refreshUI()
  end)
  if not okk then broadcastToAll('Setup error: ' .. tostring(err), { 1, 0.4, 0.4 }) end
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
  local keep = { v = VERSION, mode = S.mode, np = S.np, seats = S.seats, setup = S.setup, speed = S.speed, anyone = S.anyone, log = S.log, lastRound = S.lastRound, wroteEnd = S.wroteEnd, cellName = S.cellName }
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
  if S.mode ~= 'setup' then placeBoards(S.np or 3) end
  refreshUI()
  if S.mode == 'full' and S.G then Wait.time(sync, 1) end
end
