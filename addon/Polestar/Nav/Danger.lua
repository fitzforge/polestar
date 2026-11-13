-- Zone danger: how much dearer a walk through a zone far above the character
-- is (#195). A zone is dangerous for a character of level L when its lowest
-- level (Maps.GetZoneLevels' third value, Maps/ZoneLevels.lua: the P10 of its
-- creatures, or its danger floor where a low pocket at the zone's edge pulls
-- the P10 under the ground walks cross: Alterac Mountains' lake murlocs and
-- border bears put it at 24 under Strahnbrad's 30-40, #1490) is at least
-- L + 4, and far above when it is more than L + 10 (the Engine's rule for
-- candidates). A
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
--     maps (Path.ZoneAt); nil without the router, its maps or a zone there,
--     and on another continent whose maps have not loaded yet (they load
--     when the player gets there).
--   Nav.danger.Mult(level, uiMapID) -> 1 | 3 | 20
--   Nav.danger.Table(level, startZone, goalZone) -> { [uiMapID] = 3 | 20 } | nil, signature
--     every zone with levels whose multiplier is above 1 except startZone and
--     goalZone (nil when none); signature "uiMap=mult,..." by uiMapID ("" for
--     none). Built once per level and zone pair: the router keys its caches
--     by the table's entries, so the same pair always gets the same table.
--   Nav.danger.Along(danger, map, x1, y1, x2, y2, road) -> factor >= 1
--     what a straight walk's cost is multiplied by: the zone in the middle of
--     each 100 yd piece of the line (Path.ZoneAt), each piece x danger[zone]
--     (a Table), x1 in none; 1 without a table, the router's maps or a
--     length, and on another continent whose maps have not loaded yet
--     (Path.Resident: its part loads on arrival). `road`: the walk is a
--     zone's road through (Nav/Travel.lua: from one of the zone's crossings
--     to another, or over a crossing), where a zone far above by at most
--     ROAD_GAP levels counts as dangerous, x3 (below). The line's own ends count
--     like any other ground: the Table already leaves out the player's and
--     the target's zones, and a plan's walk between two zone crossings deep in
--     Western Plaguelands is a walk through it (#566).
--
-- A zone's road through (0.4.0, #1972: a level 37 bound for Watcher Biggs
-- in the Swamp of Sorrows was sent to Lakeshire and round the Riverglades
-- coast, three times as far as the road east from Darkshire). A zone's
-- lowest level comes from all its creatures, and where they live off the
-- road walks take through it, the road is far safer than the zone. Deadwind
-- Pass (lowest level 55) lies between Duskwood and the Swamp of Sorrows: on
-- players' recordings 12 people walked or rode its pass at levels 36 to 46,
-- none died or fought on the way, and its level-55 creatures live 64 yd and
-- more off the pass (the vultures) or 200 yd and more (the ogres and
-- Karazhan's grounds). So on the road through (the crossing data's ways in
-- and out, which follow where players walk), a zone far above by at most
-- ROAD_GAP (20) levels counts as dangerous, x3: still kept out of where
-- another way is about as short, but never worth a detour three times as
-- long. Further above (no recording shows a road that far above walked
-- safely), and anywhere off the road, x20. On every leveling guide's step to
-- the next (21,330 pairs, both factions, each with every flight path and with
-- none) the rule changes 8 plans: 7 take Deadwind Pass at levels 36 to 43 (9
-- to 15 minutes sooner; 1 of them with flight paths), and 1 a 6 km walk with
-- none (15 minutes sooner).

local ADDON, ns = ...
local Nav = ns.Nav

local type, ipairs, sort, concat, pcall = type, ipairs, table.sort, table.concat, pcall
local sqrt, ceil, floor, byte = math.sqrt, math.ceil, math.floor, string.byte

local DANGEROUS = 4   -- a zone's lowest level at least this far above: x DANGEROUS_MULT
local FAR_ABOVE = 10  -- more than this far above: x FAR_MULT
local DANGEROUS_MULT = 3
local FAR_MULT = 20   -- the other faction's towns' strength (Costs, hostile hubs)
local STEP = 100      -- yards between the zones a straight walk looks at
local ROAD_GAP = 20   -- a zone's road through counts as dangerous while the zone is at most this far above (#1972)

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

-- Are map's zones known without loading another continent's walking maps?
-- Its maps are in memory (Path.Resident), or it is the player's continent
-- (its part of Polestar_Nav loads with its first search anyway).
local function known(P, map)
	if not P.Resident or P.Resident(map) then return true end
	local C = ns.Compat
	return C and C.GetPlayerWorldPosition and C.GetPlayerWorldPosition() == map or false
end

function Danger.ZoneAt(map, x, y)
	local P = Nav.Path
	if not (P and P.ZoneAt and map and x and y) or not known(P, map) then return nil end
	local ok, zone = pcall(P.ZoneAt, map, x, y)
	return ok and zone or nil
end

-- The level zone danger prices uiMapID from: its danger floor, else its lowest level; nil without a range.
local function lowest(uiMapID)
	local M = ns.Maps
	if not uiMapID or not (M and M.GetZoneLevels) then return nil end
	local min, _, danger = M.GetZoneLevels(uiMapID)
	local lo = type(danger) == "number" and danger or min
	return type(lo) == "number" and lo or nil
end

function Danger.Mult(level, uiMapID)
	local lo = type(level) == "number" and lowest(uiMapID)
	if not lo then return 1 end
	if lo > level + FAR_ABOVE then return FAR_MULT end
	if lo >= level + DANGEROUS then return DANGEROUS_MULT end
	return 1
end

local cache, cacheLevel = {}, nil -- [startZone:goalZone] = { table | false, signature } at cacheLevel
-- [a Table] = { [uiMapID] = DANGEROUS_MULT }: its zones far above, at most ROAD_GAP levels, whose road through
-- counts as dangerous (Danger.Along's `road`).
local roadOf = setmetatable({}, { __mode = "k" })

function Danger.Table(level, startZone, goalZone)
	local M = ns.Maps
	if type(level) ~= "number" or not (M and M.EachZoneLevels) then return nil, "" end
	if cacheLevel ~= level then cache, cacheLevel = {}, level end
	local key = (startZone or 0) .. ":" .. (goalZone or 0)
	local e = cache[key]
	if not e then
		local t, ids, roads = {}, {}, {}
		for id in M.EachZoneLevels() do
			if id ~= startZone and id ~= goalZone then
				local m = Danger.Mult(level, id)
				if m > 1 then
					t[id], ids[#ids + 1] = m, id
					if m > DANGEROUS_MULT and lowest(id) - level <= ROAD_GAP then roads[id] = DANGEROUS_MULT end
				end
			end
		end
		sort(ids)
		for i, id in ipairs(ids) do ids[i] = id .. "=" .. t[id] end
		e = { #ids > 0 and t or false, concat(ids, ",") }
		if e[1] then roadOf[t] = roads end
		cache[key] = e
	end
	return e[1] or nil, e[2]
end

-- The zones the straight walks looked at, per map and chunk: the maps' zone
-- field holds one zone per chunk, 16 to a 533.33 yd tile and tile-aligned
-- (tools/lib/nav/pack.js HEADER), so a plan's lines between the same places
-- (flight masters, docks) ask the router once per chunk, not once per plan.
-- A chunk not seen yet is read from its whole tile's zones, read in one pass
-- and kept too (Path.ZoneTile, 512 bytes a tile): read one chunk at a time,
-- a plan's first lines across a continent cost up to 22 ms (0.4.0, D18: 4,569
-- chunks for one estimate), now a pass per tile. Kept for one Path.ZoneAt
-- (another one, a new memo); dropped past MEMO_MAX chunks or TILES_MAX tiles.
local CHUNKS = 16 / (1600 / 3) -- chunks per yard
local MEMO_MAX, TILES_MAX = 32768, 1024
local memo, memoFn, memoSize = {}, nil, 0
local tiles, tilesN = {}, 0 -- [map] = { [tile key] = { zones string, cx0, cy0 } | false }

local function zoneOf(zoneAt, map, x, y)
	local m = memo[map]
	if not m then
		m = {}
		memo[map] = m
	end
	local cx, cy = floor(x * CHUNKS), floor(y * CHUNKS)
	local key = (cx + 4096) * 8192 + cy + 4096
	local z = m[key]
	if z == nil then
		local t = tiles[map]
		if not t then
			t = {}
			tiles[map] = t
		end
		local tk = (floor(cx / 16) + 256) * 512 + floor(cy / 16) + 256
		local e = t[tk]
		if e == nil then
			local P = Nav.Path
			local s, cx0, cy0
			if P and P.ZoneTile then s, cx0, cy0 = P.ZoneTile(map, x, y) end
			e = s and { s, cx0, cy0 } or false
			t[tk], tilesN = e, tilesN + 1
		end
		local qx, qy = e and cx - e[2], e and cy - e[3]
		if e and qx >= 0 and qx < 16 and qy >= 0 and qy < 16 then
			local hi, lo = byte(e[1], 2 * (qx * 16 + qy) + 1, 2 * (qx * 16 + qy) + 2)
			z = hi * 256 + lo
			if z == 0 then z = false end
		else
			z = zoneAt(map, x, y) or false
		end
		m[key] = z
		memoSize = memoSize + 1
	end
	return z or nil
end

-- `roads`: the multipliers a road through takes instead (roadOf), or nil.
local function along(zoneAt, danger, map, x1, y1, x2, y2, roads)
	local dx, dy = x2 - x1, y2 - y1
	local n = ceil(sqrt(dx * dx + dy * dy) / STEP)
	if n < 1 then return 1 end
	local sum = 0
	for i = 1, n do
		local f = (i - 0.5) / n
		local z = zoneOf(zoneAt, map, x1 + dx * f, y1 + dy * f)
		local m = z and (roads and roads[z] or danger[z]) or 1
		sum = sum + m
	end
	return sum / n
end

function Danger.Along(danger, map, x1, y1, x2, y2, road)
	local P = Nav.Path
	local zoneAt = P and P.ZoneAt
	if not (danger and zoneAt and map and x1 and y1 and x2 and y2) then return 1 end
	-- Another continent whose walking maps have not loaded (its part loads when the player gets there) has no zones
	-- yet: none is remembered as none.
	if not known(P, map) then return 1 end
	if zoneAt ~= memoFn or memoSize > MEMO_MAX or tilesN > TILES_MAX then memo, memoFn, memoSize, tiles, tilesN = {}, zoneAt, 0, {}, 0 end
	local ok, f = pcall(along, zoneAt, danger, map, x1, y1, x2, y2, road and roadOf[danger] or nil)
	return ok and type(f) == "number" and f >= 1 and f or 1
end
