local __blocked = { os = true, io = true, load = true, loadfile = true, loadstring = true, dofile = true,
  require = true, module = true, package = true, debug = true, getfenv = true, setfenv = true,
  getmetatable = true, setmetatable = true, newproxy = true, collectgarbage = true, _G = true, jit = true, ffi = true, bit = true }
local function __copy(t) local c = {} for k, v in pairs(t) do c[k] = v end return c end
local __safe = { table = __copy(table), string = __copy(string), math = __copy(math) }
local __env = setmetatable({}, {
  __index = function(_, k)
    if __safe[k] ~= nil then return __safe[k] end
    if __blocked[k] or (type(k) == "string" and k:sub(1, 2) == "__") then return nil end
    return rawget(_G, k)
  end,
  __newindex = function(_, k, v)
    -- Data may add globals, never replace the functions trusted code relies on.
    if __blocked[k] or __safe[k] ~= nil or type(rawget(_G, k)) == "function" or (type(k) == "string" and k:sub(1, 2) == "__") then
      error("sandbox: cannot assign " .. tostring(k), 2)
    end
    rawset(_G, k, v)
  end,
})
local __rawopen, __rawload, __setfenv, __pcall = io.open, loadstring, setfenv, pcall
-- LuaJIT allows one function 65536 constants, fewer than pfQuest's db/units.lua
-- holds in its one table constructor. A file written the way pfQuest writes
-- its database ("<target> = {" on the first line, each entry starting on a
-- line indented two spaces, "}" on the last) loads again with its entries
-- split across functions of their own, which fill the same table.
local function __split(src)
  -- A cut inside a long string ([[...]], [==[...]==]) or after a backslash
  -- line continuation would paste the wrapper into the value: don't split.
  if src:find("%[=*%[") or src:find("\\\r?\n") then return nil end
  local lines = {}
  for line in (src:gsub("\r\n", "\n") .. "\n"):gmatch("([^\n]*)\n") do lines[#lines + 1] = line end
  while #lines > 0 and lines[#lines]:match("^%s*$") do lines[#lines] = nil end
  local target = lines[1] and lines[1]:match("^([%w_%[%]\"]+)%s*=%s*{%s*$")
  if not target or lines[#lines] ~= "}" then return nil end
  local out = { "local __t = {}", target .. " = __t;" }
  local group = 0
  for i = 2, #lines - 1 do
    if group >= 10000 and lines[i]:match("^  [^%s}]") then
      out[#out + 1] = "} for k, v in pairs(g) do t[k] = v end end)(__t);"
      group = 0
    end
    if group == 0 then out[#out + 1] = "(function(t) local g = {" end
    out[#out + 1] = lines[i]
    group = group + 1
  end
  if group > 0 then out[#out + 1] = "} for k, v in pairs(g) do t[k] = v end end)(__t);" end
  return table.concat(out, "\n")
end
function __polestar_loaddata(path, ...)
  local f, err = __rawopen(path, "rb")
  if not f then return false, err end
  local src = f:read("*a")
  f:close()
  if src:byte(1) == 27 then return false, path .. ": precompiled Lua is not accepted" end
  local chunk, perr = __rawload(src, "@" .. path)
  if not chunk and perr:match("more than %d+ constants") then
    local split = __split(src)
    chunk = split and __rawload(split, "@" .. path)
    if not chunk then return false, perr .. " (LuaJIT cannot load this file; set LUA to a Lua 5.1 interpreter)" end
  end
  if not chunk then return false, perr end
  __setfenv(chunk, __env)
  return __pcall(chunk, ...)
end
