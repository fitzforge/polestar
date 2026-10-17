-- `nav eval`'s harness (tools/lib/nav/eval/run.js spawns it): Polestar_Nav's walking router run standalone,
-- outside the client, on one Polestar_Nav folder's maps, the way 0.2.4's maps were measured (NavPack's spf.lua).
--
--   luajit harness.lua <encoding.lua> <files.txt> <queries.jsonl> <out.jsonl> [zones.json]     (lua5.1 works too, slower)
--
-- encoding.lua: a plain-Lua C_EncodingUtil (tests/lua/stub_encoding.lua): the maps decode as the client decodes them.
-- files.txt: the files to load, one path per line, in the client's order (run.js reads the folder's .toc and its
-- Nav/Nav.xml): each runs as an addon file does, with ("Polestar_Nav", ns).
-- zones.json (optional): {"<uiMapID>": the zone's lowest level, ...} (tools/lib/maps/zonelevels.js, as the addon's
-- Maps.GetZoneLevels), for the routes with a level.
-- queries.jsonl, one JSON object per line ([x, y, z] points in UnitPosition's frame, z null when unknown):
--   {"type":"route","id":..,"map":0,"from":[x,y,z],"to":[x,y,z],"profile":null|"Alliance"|"Horde","style":"fastest"|"balanced"|"roads","level":n|null,"danger":{"<uiMapID>":mult}|null}
--   {"type":"many","id":..,"map":0,"from":[x,y,z],"targets":[[x,y,z],...],"profile":..,"style":..}
-- out.jsonl: an init line ({"type":"init","files":n,"loadMs":..,"packedKB":..,"profiles":bool}), then one line per
-- query:
--   {"type":"route","id","ok","reason","cost","yards","ms","warmMs","kb","pts":[[x,y,z],...],"hubs","wet","zones","endZones"}
--   {"type":"many","id","ok","reason","costs":[cost|false,...],"yards":[..]|null,"ms","kb"}
-- yards and hubs are the router's own (job.yards, job.hubs) when it returns them, null otherwise. A search runs
-- through Path.Find / Path.FindMany with the frame pump driven here and no frame budget, from cleared caches: ms is
-- the cold search (decoding included), warmMs the same route again, kb Lua memory when the search answered. An error
-- reported through the client's error handler during a query fails it (ok false, reason "error: ..."); each query
-- starts with none.
-- The profile and the route style reach the router (opts.profile, opts.style) only when it prices by profile (Polestar_NavCosts is defined):
-- 0.2.4's router takes a waterWalking flag where opts goes, so it is called without one.
-- A route with a level is priced with zone danger (opts.danger) as the addon's Nav.danger.Table builds it: every zone
-- of zones.json whose lowest level is >= level + 4 costs 3x, > level + 10 20x, except the start's and the goal's
-- zones (Path.ZoneAt at each end); none on a router without Path.ZoneAt or a map without the zone field. A route's
-- danger ({"<uiMapID>": multiplier}) is laid over that table, level or not: it adds zones, or replaces their
-- multipliers (1 takes a zone out; 1000 all but closes it, to ask whether a walk has another way).
-- zones: the drawn line's yards per zone ({"<uiMapID>": yd}, Path.ZoneAt at the middle of every <= 2 yd piece; a
-- piece in no zone counts nowhere), endZones: [the start's zone, the goal's zone] (Path.ZoneAt, null for none); both
-- null on a router without Path.ZoneAt or a map without the zone field.

local ENCODING, FILES, QUERIES, OUT, ZONES = arg[1], arg[2], arg[3], arg[4], arg[5]
assert(ENCODING and FILES and QUERIES and OUT, "usage: harness.lua <encoding.lua> <files.txt> <queries.jsonl> <out.jsonl> [zones.json]")

local clock = function()
	return os.clock() * 1000
end
debugprofilestop = clock

local errors = {}
function geterrorhandler()
	return function(err)
		errors[#errors + 1] = tostring(err)
	end
end

stub = stub or {}
Enum = Enum or {}
Enum.CompressionMethod = Enum.CompressionMethod or {}
assert(loadfile(ENCODING))()

-- JSON: the subset the queries use (objects, arrays, numbers, strings, true/false/null).
local function decode(s)
	local pos = 1
	local value
	local function ws()
		pos = s:find("[^ \t\r\n]", pos) or #s + 1
	end
	local function str()
		local out, i = {}, pos + 1
		while true do
			local c = s:sub(i, i)
			if c == '"' then
				pos = i + 1
				return table.concat(out)
			elseif c == "\\" then
				local e = s:sub(i + 1, i + 1)
				local map = { n = "\n", t = "\t", r = "\r", b = "\b", f = "\f" }
				if e == "u" then
					out[#out + 1] = string.char(tonumber(s:sub(i + 2, i + 5), 16) % 256)
					i = i + 6
				else
					out[#out + 1] = map[e] or e
					i = i + 2
				end
			elseif c == "" then
				error("json: unterminated string")
			else
				out[#out + 1] = c
				i = i + 1
			end
		end
	end
	value = function()
		ws()
		local c = s:sub(pos, pos)
		if c == "{" then
			local t = {}
			pos = pos + 1
			ws()
			if s:sub(pos, pos) == "}" then
				pos = pos + 1
				return t
			end
			while true do
				ws()
				local k = str()
				ws()
				assert(s:sub(pos, pos) == ":", "json: expected :")
				pos = pos + 1
				t[k] = value()
				ws()
				local d = s:sub(pos, pos)
				pos = pos + 1
				if d == "}" then
					return t
				end
				assert(d == ",", "json: expected , or }")
			end
		elseif c == "[" then
			local t, n = {}, 0
			pos = pos + 1
			ws()
			if s:sub(pos, pos) == "]" then
				pos = pos + 1
				return t
			end
			while true do
				n = n + 1
				t[n] = value()
				ws()
				local d = s:sub(pos, pos)
				pos = pos + 1
				if d == "]" then
					t.n = n
					return t
				end
				assert(d == ",", "json: expected , or ]")
			end
		elseif c == '"' then
			return str()
		elseif s:sub(pos, pos + 3) == "true" then
			pos = pos + 4
			return true
		elseif s:sub(pos, pos + 4) == "false" then
			pos = pos + 5
			return false
		elseif s:sub(pos, pos + 3) == "null" then
			pos = pos + 4
			return nil
		end
		local num = s:match("^-?%d+%.?%d*[eE]?[-+]?%d*", pos)
		assert(num and #num > 0, "json: unexpected " .. c)
		pos = pos + #num
		return tonumber(num)
	end
	return value()
end

local function num(v, fmt)
	if type(v) ~= "number" or v ~= v or v == math.huge or v == -math.huge then
		return "null"
	end
	return string.format(fmt or "%.3f", v)
end

local function quote(v)
	if v == nil then
		return "null"
	end
	return '"' .. tostring(v):gsub('[%c"\\]', function(c)
		return string.format("\\u%04x", c:byte())
	end) .. '"'
end

-- Load the folder as the client loads the addon.
local ns = {}
local nfiles = 0
collectgarbage("collect")
local kb0 = collectgarbage("count")
local t0 = clock()
for file in io.lines(FILES) do
	if file ~= "" then
		local chunk = assert(loadfile(file))
		chunk("Polestar_Nav", ns)
		nfiles = nfiles + 1
	end
end
local loadMs = clock() - t0
collectgarbage("collect")
local packedKB = collectgarbage("count") - kb0
local Path = assert(Polestar_NavEngine or ns.Path, "no walking router loaded (Polestar_NavEngine)")
local profiles = type(Polestar_NavCosts) == "table"

-- The frame pump: Path.after queues a frame; drain runs frames until none is left.
local frames = {}
Path.after = function(fn)
	frames[#frames + 1] = fn
end
Path.budget = math.huge
local function drain()
	local guard = 0
	while #frames > 0 do
		local fn = table.remove(frames, 1)
		fn()
		guard = guard + 1
		assert(guard < 1e6, "the router never finished")
	end
end

local function point(map, p)
	return { map = map, x = p[1], y = p[2], z = p[3] }
end

local function opts(profile, style, danger)
	if profiles then
		return { profile = profile, style = style, danger = danger }
	end
	return nil
end

-- Each zone's lowest level (zones.json), by uiMapID.
local zoneMins = {}
if ZONES then
	local f = assert(io.open(ZONES, "r"))
	for id, min in pairs(decode(f:read("*a"))) do
		zoneMins[tonumber(id)] = min
	end
	f:close()
end

-- Does the router read zones on this map (Path.ZoneAt and the maps' zone field)?
local function zoned(map)
	local D = PolestarPathData and PolestarPathData[map]
	return Path.ZoneAt ~= nil and D ~= nil and D.zone ~= nil
end

-- The danger table for a walk from from to to (the header; the rule is the addon's Nav.danger: Ding!'s dangerAbove):
-- the level's table without the ends' zones, extra laid over it; nil on a map without zones or when it is empty.
local function dangerOf(map, from, to, level, extra)
	if not zoned(map) then
		return nil
	end
	local danger
	if type(level) == "number" then
		local a, b = Path.ZoneAt(map, from.x, from.y), Path.ZoneAt(map, to.x, to.y)
		for id, min in pairs(zoneMins) do
			local m = (min > level + 10 and 20) or (min >= level + 4 and 3) or nil
			if m and id ~= a and id ~= b then
				danger = danger or {}
				danger[id] = m
			end
		end
	end
	if type(extra) == "table" then
		for id, m in pairs(extra) do
			danger = danger or {}
			danger[tonumber(id)] = m
		end
	end
	return danger
end

-- The zones of a walk's ends as JSON (the header's endZones).
local function endZones(map, from, to)
	if not zoned(map) then
		return "null"
	end
	local a, b = Path.ZoneAt(map, from.x, from.y), Path.ZoneAt(map, to.x, to.y)
	return string.format("[%s,%s]", a and num(a, "%d") or "null", b and num(b, "%d") or "null")
end

-- The drawn line's yards per zone as JSON (the header's zones).
local SAMPLE = 2
local function zoneYards(map, points)
	if not zoned(map) then
		return "null"
	end
	local yards, ids = {}, {}
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		local L = math.sqrt((b.x - a.x) ^ 2 + (b.y - a.y) ^ 2)
		local n = math.max(1, math.ceil(L / SAMPLE))
		for k = 0, n - 1 do
			local t = (k + 0.5) / n
			local z = Path.ZoneAt(map, a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t)
			if z then
				if not yards[z] then
					yards[z] = 0
					ids[#ids + 1] = z
				end
				yards[z] = yards[z] + L / n
			end
		end
	end
	table.sort(ids)
	local parts = {}
	for i, z in ipairs(ids) do
		parts[i] = string.format('"%d":%s', z, num(yards[z], "%.1f"))
	end
	return "{" .. table.concat(parts, ",") .. "}"
end

local function route(q)
	local from, to = point(q.map, q.from), point(q.map, q.to)
	local danger = dangerOf(q.map, from, to, q.level, q.danger)
	local got
	local function once()
		got = nil
		local start = clock()
		Path.Find(q.map, from, to, function(points, cost, job)
			got = { points = points, cost = cost, job = job, ms = clock() - start, kb = collectgarbage("count") }
		end, opts(q.profile, q.style, danger))
		drain()
		return got
	end
	errors = {}
	Path.ClearCaches()
	collectgarbage("collect")
	local cold = once()
	local warm = once()
	local out = {}
	if not cold then
		local reason = #errors > 0 and "error: " .. table.concat(errors, "; ") or "no answer"
		return string.format('{"type":"route","id":%s,"ok":false,"reason":%s,"cost":null,"yards":null,"ms":null,"warmMs":null,"kb":null,"pts":[],"hubs":null,"wet":null,"zones":null,"endZones":%s}', quote(q.id), quote(reason), endZones(q.map, from, to))
	end
	-- An error reported during the query (the client's error handler) fails it.
	local ok = cold.points ~= nil and #errors == 0
	if ok then
		for i, p in ipairs(cold.points) do
			out[i] = string.format("[%s,%s,%s]", num(p.x), num(p.y), num(p.z))
		end
	end
	local job = cold.job or {}
	local hubs = "null"
	if type(job.hubs) == "table" then
		local parts = {}
		for i, h in ipairs(job.hubs) do
			parts[i] = string.format('{"id":%s,"name":%s}', type(h.id) == "number" and num(h.id, "%d") or quote(h.id), quote(h.name))
		end
		hubs = "[" .. table.concat(parts, ",") .. "]"
	end
	local reason = ok and "null" or quote(cold.points == nil and cold.cost or nil)
	if #errors > 0 then
		reason = quote("error: " .. table.concat(errors, "; "))
	end
	return string.format(
		'{"type":"route","id":%s,"ok":%s,"reason":%s,"cost":%s,"yards":%s,"ms":%s,"warmMs":%s,"kb":%s,"pts":[%s],"hubs":%s,"wet":%s,"zones":%s,"endZones":%s}',
		quote(q.id),
		tostring(ok),
		reason,
		ok and num(cold.cost) or "null",
		ok and num(job.yards) or "null",
		num(cold.ms, "%.2f"),
		num(warm and warm.ms, "%.2f"),
		num(cold.kb, "%.0f"),
		table.concat(out, ","),
		hubs,
		ok and num(cold.points.wet) or "null",
		ok and zoneYards(q.map, cold.points) or "null",
		endZones(q.map, from, to)
	)
end

local function many(q)
	local from = point(q.map, q.from)
	local targets = {}
	local n = q.targets.n or #q.targets
	for i = 1, n do
		targets[i] = point(q.map, q.targets[i])
	end
	errors = {}
	Path.ClearCaches()
	collectgarbage("collect")
	local got
	local start = clock()
	Path.FindMany(q.map, from, targets, function(costs, reason, job)
		got = { costs = costs, reason = reason, job = job, ms = clock() - start, kb = collectgarbage("count") }
	end, opts(q.profile, q.style))
	drain()
	local parts, yards = {}, "null"
	local costs = got and got.costs or {}
	for i = 1, n do
		local c = costs[i]
		parts[i] = type(c) == "number" and num(c, "%.1f") or "false"
	end
	local job = got and got.job or {}
	if type(job.yards) == "table" then
		local y = {}
		for i = 1, n do
			y[i] = type(job.yards[i]) == "number" and num(job.yards[i], "%.1f") or "false"
		end
		yards = "[" .. table.concat(y, ",") .. "]"
	end
	local reason = got and got.reason
	if #errors > 0 then
		reason = "error: " .. table.concat(errors, "; ")
	end
	return string.format(
		'{"type":"many","id":%s,"ok":%s,"reason":%s,"costs":[%s],"yards":%s,"ms":%s,"kb":%s}',
		quote(q.id),
		tostring(got ~= nil and reason == nil),
		quote(reason or (not got and "no answer" or nil)),
		table.concat(parts, ","),
		yards,
		num(got and got.ms, "%.2f"),
		num(got and got.kb, "%.0f")
	)
end

local out = assert(io.open(OUT, "w"))
out:write(string.format('{"type":"init","files":%d,"loadMs":%.0f,"packedKB":%.0f,"profiles":%s}\n', nfiles, loadMs, packedKB, tostring(profiles)))
out:flush()
for line in io.lines(QUERIES) do
	if line:find("%S") then
		local q = decode(line)
		local text
		if q.type == "route" then
			text = route(q)
		elseif q.type == "many" then
			text = many(q)
		else
			text = string.format('{"type":"error","id":%s,"reason":%s}', quote(q.id), quote("unknown query type " .. tostring(q.type)))
		end
		out:write(text, "\n")
		out:flush()
	end
end
out:close()
