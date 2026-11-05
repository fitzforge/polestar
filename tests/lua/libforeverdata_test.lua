-- LibForeverData against its release: loads the generated addon the way the client does (its
-- TOC's files in order, each chunk called with the addon's name and namespace) and checks records
-- against the release's data/*.jsonl. Plain Lua 5.1 (or LuaJIT), no test framework.
--
--   lua5.1 tests/lua/libforeverdata_test.lua <dir holding LibForeverData> <release dir> [samples]
--
-- Exits 1 on a mismatch, printing each one.

local addonDir, release, samples = arg[1], arg[2], tonumber(arg[3] or "") or 200
assert(addonDir and release, "usage: libforeverdata_test.lua <addons dir> <release dir> [samples]")
local ADDON = "LibForeverData"

-- A minimal JSON reader for the release's rows (objects, arrays, strings, numbers, booleans).
local function decode(s)
	local i = 1
	local function ws() i = s:find("[^ \t\r\n]", i) or #s + 1 end
	local value
	local function str()
		local out, j = {}, i + 1
		while true do
			local c = s:sub(j, j)
			if c == '"' then break end
			if c == "\\" then
				local e = s:sub(j + 1, j + 1)
				if e == "u" then
					local code = tonumber(s:sub(j + 2, j + 5), 16)
					if code < 128 then out[#out + 1] = string.char(code)
					elseif code < 2048 then out[#out + 1] = string.char(192 + math.floor(code / 64), 128 + code % 64)
					else out[#out + 1] = string.char(224 + math.floor(code / 4096), 128 + math.floor(code / 64) % 64, 128 + code % 64) end
					j = j + 6
				else
					out[#out + 1] = ({ n = "\n", t = "\t", r = "\r", b = "\b", f = "\f" })[e] or e
					j = j + 2
				end
			else
				out[#out + 1] = c
				j = j + 1
			end
		end
		i = j + 1
		return table.concat(out)
	end
	function value()
		ws()
		local c = s:sub(i, i)
		if c == "{" then
			local t = {}
			i = i + 1
			ws()
			if s:sub(i, i) == "}" then i = i + 1 return t end
			while true do
				ws()
				local k = str()
				ws()
				i = i + 1 -- :
				t[k] = value()
				ws()
				local d = s:sub(i, i)
				i = i + 1
				if d == "}" then return t end
			end
		elseif c == "[" then
			local t = {}
			i = i + 1
			ws()
			if s:sub(i, i) == "]" then i = i + 1 return t end
			while true do
				t[#t + 1] = value()
				ws()
				local d = s:sub(i, i)
				i = i + 1
				if d == "]" then return t end
			end
		elseif c == '"' then
			return str()
		elseif s:sub(i, i + 3) == "true" then
			i = i + 4
			return true
		elseif s:sub(i, i + 4) == "false" then
			i = i + 5
			return false
		elseif s:sub(i, i + 3) == "null" then
			i = i + 4
			return nil
		else
			local num = s:match("^-?[%d.eE+-]+", i)
			i = i + #num
			return tonumber(num)
		end
	end
	return value()
end

local function rows(table_)
	local out = {}
	local f = io.open(release .. "/data/" .. table_ .. ".jsonl")
	if not f then return out end
	for line in f:lines() do
		if line ~= "" then out[#out + 1] = decode(line) end
	end
	f:close()
	return out
end

-- Load the addon from its TOC.
local ns = {}
local toc = assert(io.open(addonDir .. "/" .. ADDON .. "/" .. ADDON .. ".toc"))
for line in toc:lines() do
	if line ~= "" and not line:find("^##") then
		local file = addonDir .. "/" .. ADDON .. "/" .. line:gsub("\\", "/")
		assert(loadfile(file))(ADDON, ns)
	end
end
toc:close()
local L = assert(LibForeverData, "no LibForeverData global")

local failures, checks = 0, 0
local function check(ok, what)
	checks = checks + 1
	if not ok then
		failures = failures + 1
		if failures <= 40 then print("FAIL " .. what) end
	end
end
local function eq(a, b, what) check(a == b, what .. ": " .. tostring(a) .. " ~= " .. tostring(b)) end

-- Spread samples over each table: the first, the last and every k-th row.
local function pick(list)
	local out, k = {}, math.max(1, math.floor(#list / samples))
	for i = 1, #list, k do out[#out + 1] = list[i] end
	if #list > 0 then out[#out + 1] = list[#list] end
	return out
end

local index = decode(assert(io.open(release .. "/index.json")):read("*a"))
eq(L.version, index.version, "version")
eq(L.clientBuild, index.clientBuild, "clientBuild")

local quests = rows("quest")
eq(#L.Ids("quest"), #quests, "Ids(quest) count")
for _, q in ipairs(pick(quests)) do
	local r = L.Get("quest", q.id)
	check(r ~= nil, "quest " .. q.id .. " present")
	if r then
		eq(r.name, q.title, "quest " .. q.id .. " title")
		eq(L.Name("quest", q.id), q.title, "Name(quest, " .. q.id .. ")")
		eq(r.level, q.level, "quest " .. q.id .. " level")
		eq(r.requiredLevel, q.min_level, "quest " .. q.id .. " min_level")
		eq(r.races, q.races or 0, "quest " .. q.id .. " races")
		eq(r.xp, q.xp, "quest " .. q.id .. " xp")
		eq(r.zone, q.zone_area, "quest " .. q.id .. " zone")
		r.name = "changed"
		check(L.Get("quest", q.id).name ~= "changed", "quest " .. q.id .. ": a fresh table each time")
	end
end
local function byQuest(t)
	local m = {}
	for _, r in ipairs(rows(t)) do
		m[r.quest] = m[r.quest] or {}
		table.insert(m[r.quest], r)
	end
	return m
end
local starts, objs, pres = byQuest("quest_start"), byQuest("quest_objective"), byQuest("quest_prereq")
for _, q in ipairs(pick(quests)) do
	local r = L.Quest(q.id)
	eq(#r.start, #(starts[q.id] or {}), "quest " .. q.id .. " starts")
	eq(#r.objectives, #(objs[q.id] or {}), "quest " .. q.id .. " objectives")
	eq(#r.prereqs, #(pres[q.id] or {}), "quest " .. q.id .. " prereqs")
	for _, s in ipairs(starts[q.id] or {}) do
		local found = false
		for _, e in ipairs(r.start) do found = found or (e.kind == s.kind and e.id == s.id) end
		check(found, "quest " .. q.id .. " start " .. s.kind .. " " .. s.id)
	end
end

for _, kind in ipairs({ "npc", "object", "item" }) do
	local list = rows(kind)
	eq(#L.Ids(kind), #list, "Ids(" .. kind .. ") count")
	for _, e in ipairs(pick(list)) do
		local r = L.Get(kind, e.id)
		check(r ~= nil, kind .. " " .. e.id .. " present")
		if r then
			eq(r.name, e.name, kind .. " " .. e.id .. " name")
			if kind == "npc" then
				eq(r.subName, e.subname, "npc " .. e.id .. " subname")
				eq(r.maxLevel, e.level_max, "npc " .. e.id .. " level_max")
				eq(r.factionTemplate, e.faction_template, "npc " .. e.id .. " faction_template")
			end
		end
	end
end

-- Spawns: every point of the sampled entities, to the half yard and tenth of a yard.
local spawnBy = {}
for _, s in ipairs(rows("spawn")) do
	local k = s.kind .. ":" .. s.id
	spawnBy[k] = spawnBy[k] or {}
	table.insert(spawnBy[k], s)
end
local keys = {}
for k in pairs(spawnBy) do keys[#keys + 1] = k end
table.sort(keys)
local sampledKeys = {}
for _, k in ipairs(pick(keys)) do sampledKeys[#sampledKeys + 1] = k end
for _, k in ipairs(sampledKeys) do
	local kind, id = k:match("^(%a+):(%d+)$")
	local got = L.Spawns(kind, tonumber(id))
	local want = spawnBy[k]
	eq(#got, #want, k .. " spawn count")
	table.sort(want, function(a, b) if a.map ~= b.map then return a.map < b.map end return a.n < b.n end)
	for i, w in ipairs(want) do
		local g = got[i]
		if g then
			check(g.map == w.map and g.x == w.x and g.y == w.y and (g.z == w.z or (w.z and g.z and math.abs(g.z - w.z) < 0.051)),
				string.format("%s point %d: %s,%s,%s,%s ~= %s,%s,%s,%s", k, i, g.map, g.x, g.y, tostring(g.z), w.map, w.x, w.y, tostring(w.z)))
		end
	end
end

-- Steps: per quest, in order, with their ids and texts.
local steps = byQuest("step")
local qs = {}
for q in pairs(steps) do qs[#qs + 1] = q end
table.sort(qs)
for _, q in ipairs(pick(qs)) do
	local want = steps[q]
	table.sort(want, function(a, b) return a.n < b.n end)
	local got = L.Steps(q)
	eq(#got, #want, "steps of " .. q)
	for i, w in ipairs(want) do
		local g = got[i] or {}
		eq(g.id, w.id, "step " .. w.id .. " id")
		eq(g.text, w.text, "step " .. w.id .. " text")
		eq(g.action, w.action, "step " .. w.id .. " action")
		eq(g.confidence, w.confidence, "step " .. w.id .. " confidence")
	end
end

-- ToUiMap: a frame's own centre maps to (50, 50) on it or a smaller frame inside it.
local frame = rows("ui_map")[1]
if frame then
	local m, x, y = L.ToUiMap(frame.map, (frame.top + frame.bottom) / 2, (frame.left + frame.right) / 2)
	check(m ~= nil and x >= 0 and x <= 100 and y >= 0 and y <= 100, "ToUiMap of a frame's centre")
	if m == frame.ui_map then check(math.abs(x - 50) < 0.01 and math.abs(y - 50) < 0.01, "ToUiMap centre is 50,50") end
end

print(string.format("libforeverdata: %d checks, %d failed", checks, failures))
os.exit(failures == 0 and 0 or 1)
