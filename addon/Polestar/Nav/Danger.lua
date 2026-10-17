-- Zone danger: how much dearer a walk through a zone far above the character
-- is (#195). A zone is dangerous for a character of level L when its lowest
-- level (Maps.GetZoneLevels, Maps/ZoneLevels.lua) is at least L + 4, and far
-- above when it is more than L + 10 (the Engine's rule for candidates). A
-- step into a dangerous zone costs 3 times, into a far-above one 20 times
-- (the strength of the other faction's towns: kept out of wherever there is
-- another way, never closed); a
-- zone without a level range (a city, an unknown one) never counts, nor do the
-- zones the walk starts and ends in (a quest inside Moonglade at level 15 is
-- still walked to). The router (Polestar_Nav's Routing/Path.lua) takes the
-- table as opts.danger; no zone is ever closed. The journey planner
-- (Nav/Travel.lua) prices its straight walks by the same table (Danger.Along).
-- The zone danger idea and its 4-level threshold come from Ding! by Yendi
-- (ding-travel 2bccf01, its dangerAbove).
--
--   Nav.danger.Level() -> level | nil
--     the player's: the client's (Compat.GetPlayerInfo), or the last
--     PLAYER_LEVEL_UP's when that is higher (the client's can lag the event);
--     nil when unread. Walk's searches and Travel's plans both read it.
--   Nav.danger.ZoneAt(map, x, y) -> uiMapID | nil
--     the zone of world point (x, y) on map (a continent) in the router's
--     maps (Path.ZoneAt); nil without the router, its maps or a zone there.
--   Nav.danger.Mult(level, uiMapID) -> 1 | 3 | 20
--   Nav.danger.Table(level, startZone, goalZone) -> { [uiMapID] = 3 | 20 } | nil, signature
--     every zone with levels whose multiplier is above 1 except startZone and
--     goalZone (nil when none); signature "uiMap=mult,..." by uiMapID ("" for
--     none). Built once per level and zone pair: the router keys its caches
--     by the table's entries, so the same pair always gets the same table.
--   Nav.danger.Along(danger, map, x1, y1, x2, y2) -> factor >= 1
--     what a straight walk's cost is multiplied by: the zone in the middle of
--     each 100 yd piece of the line (Path.ZoneAt), each piece x danger[zone]
--     (a Table), x1 in the zones of its two ends or in none; 1 without a
--     table, the router's maps or a length.

local ADDON, ns = ...
local Nav = ns.Nav

local type, ipairs, sort, concat, pcall = type, ipairs, table.sort, table.concat, pcall
local sqrt, ceil, floor = math.sqrt, math.ceil, math.floor

local DANGEROUS = 4   -- a zone's lowest level at least this far above: x DANGEROUS_MULT
local FAR_ABOVE = 10  -- more than this far above: x FAR_MULT
local DANGEROUS_MULT = 3
local FAR_MULT = 20   -- the other faction's towns' strength (Costs, hostile hubs)
local STEP = 100      -- yards between the zones a straight walk looks at

local Danger = {}
Nav.danger = Danger

local levelSeen = 0 -- PLAYER_LEVEL_UP's level: the client's can lag the event

function Danger.Level()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo()
	local level = info and type(info.level) == "number" and info.level or nil
	if levelSeen > (level or 0) then level = levelSeen end
	return level
end

-- Registered before Nav/Walk.lua's handler (Nav.xml loads this file first;
-- ns.RegisterEvent calls handlers in the order registered), so the walks
-- searched again on a level-up already read the new level.
ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	if type(level) == "number" and level > levelSeen then levelSeen = level end
end)

function Danger.ZoneAt(map, x, y)
	local P = Nav.Path
	if not (P and P.ZoneAt and map and x and y) then return nil end
	local ok, zone = pcall(P.ZoneAt, map, x, y)
	return ok and zone or nil
end

function Danger.Mult(level, uiMapID)
	local M = ns.Maps
	if type(level) ~= "number" or not uiMapID or not (M and M.GetZoneLevels) then return 1 end
	local lo = M.GetZoneLevels(uiMapID)
	if type(lo) ~= "number" then return 1 end
	if lo > level + FAR_ABOVE then return FAR_MULT end
	if lo >= level + DANGEROUS then return DANGEROUS_MULT end
	return 1
end

local cache, cacheLevel = {}, nil -- [startZone:goalZone] = { table | false, signature } at cacheLevel

function Danger.Table(level, startZone, goalZone)
	local M = ns.Maps
	if type(level) ~= "number" or not (M and M.EachZoneLevels) then return nil, "" end
	if cacheLevel ~= level then cache, cacheLevel = {}, level end
	local key = (startZone or 0) .. ":" .. (goalZone or 0)
	local e = cache[key]
	if not e then
		local t, ids = {}, {}
		for id in M.EachZoneLevels() do
			if id ~= startZone and id ~= goalZone then
				local m = Danger.Mult(level, id)
				if m > 1 then t[id], ids[#ids + 1] = m, id end
			end
		end
		sort(ids)
		for i, id in ipairs(ids) do ids[i] = id .. "=" .. t[id] end
		e = { #ids > 0 and t or false, concat(ids, ",") }
		cache[key] = e
	end
	return e[1] or nil, e[2]
end

-- The zones the straight walks looked at, per map and chunk: the maps' zone
-- field holds one zone per chunk, 16 to a 533.33 yd tile and tile-aligned
-- (tools/lib/nav/pack.js HEADER), so a plan's lines between the same places
-- (flight masters, docks) ask the router once per chunk, not once per plan.
-- Kept for one Path.ZoneAt (another one, a new memo); dropped past MEMO_MAX.
local CHUNKS = 16 / (1600 / 3) -- chunks per yard
local MEMO_MAX = 32768
local memo, memoFn, memoSize = {}, nil, 0

local function zoneOf(zoneAt, map, x, y)
	local m = memo[map]
	if not m then
		m = {}
		memo[map] = m
	end
	local key = (floor(x * CHUNKS) + 4096) * 8192 + floor(y * CHUNKS) + 4096
	local z = m[key]
	if z == nil then
		z = zoneAt(map, x, y) or false
		m[key] = z
		memoSize = memoSize + 1
	end
	return z or nil
end

local function along(zoneAt, danger, map, x1, y1, x2, y2)
	local dx, dy = x2 - x1, y2 - y1
	local n = ceil(sqrt(dx * dx + dy * dy) / STEP)
	if n < 1 then return 1 end
	local a, b = zoneOf(zoneAt, map, x1, y1), zoneOf(zoneAt, map, x2, y2)
	local sum = 0
	for i = 1, n do
		local f = (i - 0.5) / n
		local z = zoneOf(zoneAt, map, x1 + dx * f, y1 + dy * f)
		sum = sum + (z and z ~= a and z ~= b and danger[z] or 1)
	end
	return sum / n
end

function Danger.Along(danger, map, x1, y1, x2, y2)
	local P = Nav.Path
	local zoneAt = P and P.ZoneAt
	if not (danger and zoneAt and map and x1 and y1 and x2 and y2) then return 1 end
	if zoneAt ~= memoFn or memoSize > MEMO_MAX then memo, memoFn, memoSize = {}, zoneAt, 0 end
	local ok, f = pcall(along, zoneAt, danger, map, x1, y1, x2, y2)
	return ok and type(f) == "number" and f >= 1 and f or 1
end
