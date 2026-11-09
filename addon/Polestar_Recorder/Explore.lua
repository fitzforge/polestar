-- Explorer mode (docs/RECORDING.md, "Explorer mode"): off until the player
-- types /psrec explore on (or turns it on in Polestar Client), and only
-- while recording. It adds game data about the places Forever made new, and
-- nothing more about the player:
--   - denser sightings and positions in Forever's new zones and around its
--     new dungeons' entrances (ns.Dense: World.lua's breadcrumbs every
--     EXPLORE_POS_YARDS, Finds.lua's `unit` once per EXPLORE_UNIT_YARDS), and
--     there and inside instances each creature spawn seen (`unitx`, Finds.lua);
--   - `poi`: the quest log's own map points (C_QuestLog.GetQuestsOnMap);
--   - `imap`: the uiMapID and floor inside an instance, on change;
--   - `engage`: an encounter's start (Finds.lua, beside `encounter`);
--   - `where`: the subzone an NPC's quest window opened in (Quests.lua);
--   - `open`: a world object opened (an "Opening" cast), with the object
--     when the client names it (the soft-interact target).
--
-- APIs, verified against .ref/wow-ui-source-forever: C_QuestLog
-- .GetQuestsOnMap (QuestPOIMapInfo: questID, mapID, x, y in 0-1),
-- C_Map.GetMapGroupID / GetMapGroupMembersInfo (relativeHeightIndex),
-- GetInstanceInfo (8th return: the instance map id), the "softinteract" unit
-- token, ENCOUNTER_START.

local ADDON, ns = ...

local type, GetTime, ipairs, pcall, wipe = type, GetTime, ipairs, pcall, wipe
local Num, Str = ns.Num, ns.Str

ns.EXPLORE_POS_YARDS = 10 -- a breadcrumb after moving this far ...
ns.EXPLORE_POS_GAP = 0.9 -- ... at most once a tick of the 1 s position ticker, where dense
ns.EXPLORE_UNIT_YARDS = 30 -- one `unit` (and `unitx` per spawn) per this many yards, where dense

-- Forever's new zones (uiMapIDs, data/forever zones.json); a map inside one
-- counts by its parents.
local NEW_MAPS = { [2521] = true, [2665] = true, [2548] = true, [2652] = true, [2482] = true, [2524] = true }
-- Forever's new dungeons' entrances (data/forever dungeons.json): map, x, y.
local ENTRANCES = {
	{ 1455, 43.5, 52 }, -- Hall of Thanes
	{ 1420, 63.4, 67.4 }, -- Ruins of Lordaeron
	{ 1437, 47.7, 56.2 }, -- Excavation Site: Wetlands
	{ 1416, 8.5, 59.3 }, -- City of Dalaran
}
local ENTRANCE_YARDS = 200

local POI_DELAY = 2 -- seconds after a quest log or zone change before the map points are read
local OPEN_PER_MINUTE = 20 -- most `open` records in any 60 seconds
local OPENING = { [3365] = true, [6247] = true, [6477] = true, [6478] = true, [21651] = true, [22810] = true, [24390] = true }

local function call(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, a, b, c, d, e, f, g, h = pcall(fn, ...)
	if ok then return a, b, c, d, e, f, g, h end
	return nil
end

-- Explorer mode is on and recording.
function ns.Exploring() return ns.IsExploring() and ns.Recording() end

local newMap = {} -- uiMapID -> whether it is (inside) a new zone

local function isNewMap(map)
	local known = newMap[map]
	if known ~= nil then return known end
	local m, found = map, false
	for _ = 1, 8 do
		if NEW_MAPS[m] then
			found = true
			break
		end
		local info = call(C_Map and C_Map.GetMapInfo, m)
		m = type(info) == "table" and Num(info.parentMapID) or nil
		if not m or m == 0 then break end
	end
	newMap[map] = found
	return found
end

-- Whether explorer density applies at (map, x, y) (x, y in percent): in a
-- new zone, or near a new dungeon's entrance, while exploring.
function ns.Dense(map, x, y)
	if not (map and ns.Exploring()) then return false end
	if isNewMap(map) then return true end
	if not x then return false end
	for _, e in ipairs(ENTRANCES) do
		if e[1] == map and ns.Yards(map, x - e[2], y - e[3]) <= ENTRANCE_YARDS then return true end
	end
	return false
end

-- The instance map id while inside one.
local function instanceId()
	local _, kind, _, _, _, _, _, id = call(GetInstanceInfo)
	if kind == nil or kind == "none" then return nil end
	return Num(id)
end
ns.InstanceId = instanceId

---------------------------------------------------------------------------
-- `where`: the subzone an NPC's (or object's) quest window opened in, once
-- per NPC per session, with whether the player stood indoors.
---------------------------------------------------------------------------

local whereSeen = {} -- "c<id>" | "o<id>"

function ns.Where(kind, id)
	if not (id and (kind == "c" or kind == "o") and ns.Exploring()) then return end
	local key = kind .. id
	if whereSeen[key] then return end
	if ns.Rec("where", kind, id, Str(call(GetSubZoneText)), call(IsIndoors) and true or false) then whereSeen[key] = true end
end

---------------------------------------------------------------------------
-- `poi`: the quest log's map points on the player's map, once per quest,
-- map and state (objectives open / ready to hand in) per session.
---------------------------------------------------------------------------

local poiSeen = {} -- "q:map:done"
local poiPending = false

local function readPOIs()
	poiPending = false
	if not ns.Exploring() then return end
	local Q = C_QuestLog
	local map = Num(call(C_Map and C_Map.GetBestMapForUnit, "player"))
	if not (map and Q) then return end
	local list = call(Q.GetQuestsOnMap, map)
	if type(list) ~= "table" then return end
	for _, info in ipairs(list) do
		local q = type(info) == "table" and Num(info.questID)
		local m, x, y = q and (Num(info.mapID) or map), q and Num(info.x), q and Num(info.y)
		if q and x and y and call(Q.IsOnQuest, q) then
			local done = call(Q.IsComplete, q) and true or false
			local key = q .. ":" .. m .. ":" .. (done and 1 or 0)
			if not poiSeen[key] and ns.Rec("poi", q, done, ns.PAt(m, x * 100, y * 100)) then poiSeen[key] = true end
		end
	end
end

local function schedulePOIs()
	if poiPending or not ns.Exploring() then return end
	poiPending = true
	C_Timer.After(POI_DELAY, readPOIs)
end

ns.On("QUEST_LOG_UPDATE", schedulePOIs)
ns.On("QUEST_ACCEPTED", schedulePOIs)
ns.On("ZONE_CHANGED_NEW_AREA", schedulePOIs)
ns.On("ZONE_CHANGED", schedulePOIs)

---------------------------------------------------------------------------
-- `imap`: inside an instance, its uiMapID and floor whenever they change
-- (read every second; the client gives no position there).
---------------------------------------------------------------------------

local lastInst, lastMap

local function floorOf(map)
	local M = C_Map
	local group = Num(call(M and M.GetMapGroupID, map))
	if not group then return nil, nil end
	local members = call(M.GetMapGroupMembersInfo, group)
	if type(members) == "table" then
		for _, m in ipairs(members) do
			if type(m) == "table" and Num(m.mapID) == map then return group, Num(m.relativeHeightIndex) end
		end
	end
	return group, nil
end

local function checkInstanceMap()
	if not ns.Exploring() then return end
	local id = instanceId()
	if not id then
		lastInst, lastMap = nil, nil
		return
	end
	local map = Num(call(C_Map and C_Map.GetBestMapForUnit, "player"))
	if not map or (id == lastInst and map == lastMap) then return end
	local group, floor = floorOf(map)
	if ns.Rec("imap", id, map, group, floor) then lastInst, lastMap = id, map end
end
C_Timer.NewTicker(1, checkInstanceMap)

---------------------------------------------------------------------------
-- `open`: a world object opened (an "Opening" cast: the client's lock
-- opening spells, by id or by the name of Opening in the client's
-- language), at the player's position, with the object when the client
-- names it. OPEN_PER_MINUTE a minute.
---------------------------------------------------------------------------

local openName -- "Opening" in the client's language
local openTimes = {}
local opening = {} -- spellId -> whether it is an opening, worked out once

local function isOpening(spell)
	local v = opening[spell]
	if v == nil then
		if openName == nil then openName = Str(ns.SpellName(3365)) or false end
		v = OPENING[spell] or (openName and Str(ns.SpellName(spell)) == openName) or false
		opening[spell] = v
	end
	return v
end

ns.On("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spell)
	if ns.Value(unit) ~= "player" or not ns.Exploring() then return end
	spell = Num(spell)
	if not (spell and isOpening(spell)) then return end
	local now = GetTime()
	local n = 0
	for i = 1, #openTimes do
		if now - openTimes[i] < 60 then
			n = n + 1
			openTimes[n] = openTimes[i]
		end
	end
	for i = #openTimes, n + 1, -1 do openTimes[i] = nil end
	if n >= OPEN_PER_MINUTE then return end
	local tk, tid = ns.RefOfGUID(call(UnitGUID, "softinteract"))
	if tk ~= "o" and tk ~= "c" then tk, tid = nil, nil end
	if ns.Rec("open", spell, ns.P(), tk, tid) then openTimes[n + 1] = now end
end)

---------------------------------------------------------------------------
-- Session start: dedupe sets start empty
---------------------------------------------------------------------------

ns.OnSession(function()
	wipe(whereSeen)
	wipe(poiSeen)
	wipe(openTimes)
	lastInst, lastMap = nil, nil
	schedulePOIs()
end)
