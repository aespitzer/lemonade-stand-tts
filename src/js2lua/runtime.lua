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
