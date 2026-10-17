'use strict';
// Lua 5.1 for the toolchain. The interpreter does the parsing, so anything the
// game can load (SavedVariables, pfQuest database files) this can read:
//
//   const { luaToJson } = require('./lua');
//   const db = luaToJson({ files: [svPath], expr: 'return PolestarRecorderDB' });
//
// Tables with keys exactly 1..n become arrays; everything else becomes an object
// with string keys (integer keys printed without a decimal point). An empty
// table becomes {}. NaN and infinities become null; functions and userdata null.
//
// `files` are data from outside the repo (SavedVariables, pfQuest),
// so they run sandboxed: source text only (precompiled bytecode is refused),
// with an environment that can read and write ordinary globals but sees none of
// os, io, load*, dofile, require, debug, getfenv/setfenv or the metatable
// functions. `prelude` and `expr` are the caller's own code and run normally;
// they can load more untrusted files the same way with
// __polestar_loaddata(path, ...) -> ok, err (extra arguments become the
// chunk's `...`, as the client passes an addon's name and namespace). Every run
// has a time limit.

const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

let cached;

function findLua() {
	if (cached) return cached;
	const candidates = [process.env.LUA, 'lua5.1', 'luajit', 'lua'].filter(Boolean);
	for (const bin of candidates) {
		const r = spawnSync(bin, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
		if (r.status === 0 && /5\.1/.test(r.stdout)) return (cached = bin);
	}
	throw new Error(`No Lua 5.1 interpreter found (tried ${candidates.join(', ')}). Install lua5.1 or luajit, or set LUA=/path/to/lua5.1.`);
}

const ENCODER = String.raw`
local escapes = { ['"'] = '\\"', ['\\'] = '\\\\', ['\b'] = '\\b', ['\f'] = '\\f', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
local function num(v)
  if v ~= v or v == math.huge or v == -math.huge then return "null" end
  if v == math.floor(v) and math.abs(v) < 2^53 then return string.format("%d", v) end
  return string.format("%.17g", v)
end
local function str(s)
  return '"' .. s:gsub('[%z\1-\31"\\]', function(c) return escapes[c] or string.format("\\u%04x", c:byte()) end) .. '"'
end
local function encode(v, seen, buf)
  local t = type(v)
  if t == "nil" then buf[#buf+1] = "null"
  elseif t == "boolean" then buf[#buf+1] = v and "true" or "false"
  elseif t == "number" then buf[#buf+1] = num(v)
  elseif t == "string" then buf[#buf+1] = str(v)
  elseif t == "table" then
    if seen[v] then error("cycle in Lua data", 0) end
    seen[v] = true
    local n, count, ints = 0, 0, true
    for k in pairs(v) do
      count = count + 1
      if type(k) == "number" and k >= 1 and k == math.floor(k) then
        if k > n then n = k end
      else
        ints = false
      end
    end
    if count > 0 and ints and n == count then
      buf[#buf+1] = "["
      for i = 1, n do
        if i > 1 then buf[#buf+1] = "," end
        encode(v[i], seen, buf)
      end
      buf[#buf+1] = "]"
    else
      buf[#buf+1] = "{"
      local first = true
      for k, val in pairs(v) do
        local key
        if type(k) == "string" then key = k
        elseif type(k) == "number" then key = num(k)
        elseif type(k) == "boolean" then key = tostring(k) end
        if key then
          if not first then buf[#buf+1] = "," end
          first = false
          buf[#buf+1] = str(key)
          buf[#buf+1] = ":"
          encode(val, seen, buf)
        end
      end
      buf[#buf+1] = "}"
    end
    seen[v] = nil
  else
    buf[#buf+1] = "null"
  end
end
function __polestar_json(v)
  local buf = {}
  encode(v, {}, buf)
  return table.concat(buf)
end
`;

const SANDBOX = String.raw`
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
`;

// Run Lua and return the JSON-decoded value of `expr` (a chunk body that
// returns a value). `files` are loaded in order, sandboxed (see the top of this
// file); `prelude` runs first (e.g. creating tables the data files index into).
// `files` paths are passed as arguments, so no quoting issues. `timeout` is in ms.
function luaToJson({ files = [], prelude = '', expr, timeout = 120000 }) {
	if (!expr) throw new Error('luaToJson: expr is required, e.g. "return MyGlobal"');
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-lua-'));
	const script = path.join(dir, 'run.lua');
	const out = path.join(dir, 'out.json');
	fs.writeFileSync(
		script,
		`${ENCODER}
${SANDBOX}
local __out = arg[1]
${prelude}
for i = 2, #arg do
  local ok, err = __polestar_loaddata(arg[i])
  if not ok then error(err, 0) end
end
local __value = (function() ${expr} end)()
local __f = assert(io.open(__out, "wb"))
__f:write(__polestar_json(__value))
__f:close()
`,
	);
	try {
		const r = spawnSync(findLua(), [script, out, ...files], { encoding: 'utf8', maxBuffer: 16 * 1024 * 1024, timeout, killSignal: 'SIGKILL' });
		if (r.error && r.error.code === 'ETIMEDOUT') throw new Error(`Lua ran longer than ${timeout} ms; stopped`);
		if (r.error) throw r.error;
		if (r.status !== 0) throw new Error(`Lua failed (exit ${r.status}): ${r.stderr.trim()}`);
		return JSON.parse(fs.readFileSync(out, 'utf8'));
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

module.exports = { findLua, luaToJson };
