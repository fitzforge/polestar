-- LuaChunks: records kept as text in long-string chunks, read on demand (forge-core
-- src/luachunks.rs writes them). Lua 5.1, no WoW API. Nothing is parsed at load: a chunk is a
-- string of lines "\n" .. id .. "\t" .. payload; a record is found by its chunk's id range and
-- one plain string.find, and decoded on first read into a weak cache.
--
--   local store = LuaChunks.New()
--   store:Add(kind, lo, hi, text)      -- data files, one call per chunk
--   store:Raw(kind, id) -> payload | nil
--   store:Get(kind, id, decode) -> decode(payload, id) cached weakly per kind | nil
--   store:Ids(kind) -> { id, ... } sorted (a fresh table)
--   store:Has(kind) -> bool
--   LuaChunks.Split(s, sep) -> { field, ... }, n (empty fields kept; sep one of ; , : |)
--   LuaChunks.Unesc(s) -> s with %XX turned back (nil for "")
--   LuaChunks.Fixed(s, at, width) -> the number in base-64 digits s[at .. at+width-1]

local LuaChunks = {}

local find, sub, byte, gmatch, gsub, char = string.find, string.sub, string.byte, string.gmatch, string.gsub, string.char
local tonumber, setmetatable, sort = tonumber, setmetatable, table.sort

local WEAK = { __mode = "v" }

local Store = {}
Store.__index = Store

function LuaChunks.New()
	return setmetatable({ chunks = {}, cache = {} }, Store)
end

-- chunks[kind] = { { lo, hi, text }, ... } kept sorted by lo (files may come in any order)
function Store:Add(kind, lo, hi, text)
	local list = self.chunks[kind]
	if not list then
		list = {}
		self.chunks[kind] = list
	end
	local c = { lo, hi, text }
	local i = #list + 1
	while i > 1 and list[i - 1][1] > lo do
		list[i] = list[i - 1]
		i = i - 1
	end
	list[i] = c
	self.cache[kind] = nil
end

function Store:Has(kind)
	return self.chunks[kind] ~= nil
end

local function chunkOf(list, id)
	local a, b = 1, #list
	while a <= b do
		local m = math.floor((a + b) / 2)
		local c = list[m]
		if id < c[1] then
			b = m - 1
		elseif id > c[2] then
			a = m + 1
		else
			return c[3]
		end
	end
end

function Store:Raw(kind, id)
	local list = self.chunks[kind]
	id = tonumber(id)
	if not list or not id then return nil end
	local text = chunkOf(list, id)
	if not text then return nil end
	local _, e = find(text, "\n" .. id .. "\t", 1, true)
	if not e then return nil end
	local stop = find(text, "\n", e + 1, true)
	return sub(text, e + 1, stop - 1)
end

function Store:Get(kind, id, decode)
	id = tonumber(id)
	if not id then return nil end
	local c = self.cache[kind]
	if c then
		local rec = c[id]
		if rec ~= nil then return rec or nil end
	else
		c = setmetatable({}, WEAK)
		self.cache[kind] = c
	end
	local s = self:Raw(kind, id)
	if not s then return nil end
	local rec = decode(s, id)
	c[id] = rec
	return rec
end

function Store:Ids(kind)
	local out, n = {}, 0
	for _, c in ipairs(self.chunks[kind] or {}) do
		for id in gmatch(c[3], "\n(%-?%d+)\t") do
			n = n + 1
			out[n] = tonumber(id)
		end
	end
	sort(out)
	return out
end

local PATTERN = { [";"] = "([^;]*);", [","] = "([^,]*),", [":"] = "([^:]*):", ["|"] = "([^|]*)|" }

function LuaChunks.Split(s, sep)
	local t, n = {}, 0
	if s == nil then return t, 0 end
	for f in gmatch(s .. sep, PATTERN[sep]) do
		n = n + 1
		t[n] = f
	end
	return t, n
end

local function hex(h) return char(tonumber(h, 16)) end

function LuaChunks.Unesc(s)
	if s == nil or s == "" then return nil end
	if find(s, "%", 1, true) then s = gsub(s, "%%(%x%x)", hex) end
	return s
end

-- The digits of luachunks.rs DIGITS: 0-9 A-Z a-z + /
local B64 = {}
do
	local d = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
	for i = 1, 64 do B64[byte(d, i)] = i - 1 end
end

function LuaChunks.Fixed(s, at, width)
	local n = 0
	for i = at, at + width - 1 do
		n = n * 64 + B64[byte(s, i)]
	end
	return n
end

-- In an addon (a file's chunk gets the addon's name and namespace) it is ns.LuaChunks; loaded
-- with dofile or require it is the file's value.
local _, ns = ...
if type(ns) == "table" then ns.LuaChunks = LuaChunks end
return LuaChunks
