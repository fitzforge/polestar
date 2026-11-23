-- Explorer mode (docs/RECORDING.md, "Explorer mode"): while recording, in
-- Forever's new places (NEW_PLACES: its new zones, its new dungeons and
-- battleground, and around the dungeon entrances outside them) the Recorder
-- notes more about the game world there, and nothing more about the player.
-- It works by itself; /psrec explore off (or Polestar Client's explorer flag
-- false) turns it off. The first time it works it says so once in chat.
--   - denser sightings and positions (ns.Dense: World.lua's breadcrumbs every
--     EXPLORE_POS_YARDS, Finds.lua's `unit` once per EXPLORE_UNIT_YARDS) and
--     each creature spawn seen (`unitx`, Finds.lua);
--   - `poi`: the quest log's own map points (C_QuestLog.GetQuestsOnMap);
--   - `imap`: the uiMapID and floor inside a new dungeon, on change;
--   - `engage`: an encounter's start (Finds.lua, beside `encounter`);
--   - `where`: the subzone an NPC's quest window opened in (Quests.lua);
--   - `open`: a world object opened (an "Opening" cast), with the object
--     when the client names it (the soft-interact target).
--
-- APIs, verified against .ref/wow-ui-source-forever: C_QuestLog
-- .GetQuestsOnMap (QuestPOIMapInfo: questID, mapID, x, y in 0-1),
-- C_Map.GetMapGroupID / GetMapGroupMembersInfo (relativeHeightIndex),
-- GetInstanceInfo (8th return: the map id, of world maps too), the
-- "softinteract" unit token, ENCOUNTER_START.

local ADDON, ns = ...
local L = ns.L

local type, GetTime, ipairs, pcall, wipe = type, GetTime, ipairs, pcall, wipe
local Num, Str = ns.Num, ns.Str

ns.EXPLORE_POS_YARDS = 10 -- a breadcrumb after moving this far ...
ns.EXPLORE_POS_GAP = 0.9 -- ... at most once a tick of the 1 s position ticker, where dense
ns.EXPLORE_UNIT_YARDS = 30 -- one `unit` (and `unitx` per spawn) per this many yards, where dense

-- Forever's new places: the one list explorer mode goes by. uiMap: a zone's
-- uiMapID (a map inside it counts by its parents); map: the map id
-- GetInstanceInfo gives there (dungeons, the battleground, separate world
-- maps); entrance: map, x, y of a dungeon's door in an older zone, dense
-- within ENTRANCE_YARDS. From data/forever zones.json and dungeons.json and
-- the client's Map table (the 70862 client).
local NEW_PLACES = {
	{ "Zephras Isle", uiMap = 2521, map = 2991 },
	{ "Zephras Isle (system map)", uiMap = 2665 },
	{ "Riverglades", uiMap = 2548 },
	{ "Shen'dralas", uiMap = 2652 },
	{ "Mount Hyjal", uiMap = 2482 },
	{ "Hyjal Crater", map = 2995 },
	{ "Darkspear Islands", uiMap = 2524, map = 2997 },
	{ "The Hall of Thanes", map = 3065, entrance = { 1455, 43.5, 52 } },
	{ "Ruins of Lordaeron", map = 2999, entrance = { 1420, 63.4, 67.4 } },
	{ "Excavation Site: Wetlands", map = 2998, entrance = { 1437, 47.7, 56.2 } },
	{ "City of Dalaran", map = 2959, entrance = { 1416, 8.5, 59.3 } },
	{ "The Drowned City", map = 2970 },
	{ "Krol'dok Stronghold", map = 3039 }, -- its door is in Riverglades
	{ "Alcaz Prison", map = 2994 },
	{ "Blackmaw Hold", map = 2974 },
	{ "The Shaper's Terrace", map = 3001 },
	{ "Manor Mistmantle", map = 3109 },
}
ns.NEW_PLACES = NEW_PLACES
local ENTRANCE_YARDS = 200

local NEW_UIMAP, NEW_MAP, ENTRANCES = {}, {}, {}
for _, p in ipairs(NEW_PLACES) do
	if p.uiMap then NEW_UIMAP[p.uiMap] = true end
	if p.map then NEW_MAP[p.map] = true end
	if p.entrance then ENTRANCES[#ENTRANCES + 1] = p.entrance end
end

local POI_DELAY = 2 -- seconds after a quest log or zone change before the map points are read
local OPEN_PER_MINUTE = 20 -- most `open` records in any 60 seconds
local OPENING = { [3365] = true, [6247] = true, [6477] = true, [6478] = true, [21651] = true, [22810] = true, [24390] = true }

local function call(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, a, b, c, d, e, f, g, h = pcall(fn, ...)
	if ok then return a, b, c, d, e, f, g, h end
	return nil
end

-- The map id GetInstanceInfo gives (world maps too) and whether that is an
-- instance; read at zone changes and every second.
local worldMap, inInstance

local function readInstance()
	local _, kind, _, _, _, _, _, id = call(GetInstanceInfo)
	worldMap = Num(id)
	inInstance = kind ~= nil and kind ~= "none"
end

local newMap = {} -- uiMapID -> whether it is (inside) a new zone

local function isNewMap(map)
	local known = newMap[map]
	if known ~= nil then return known end
	local m, found = map, false
	for _ = 1, 8 do
		if NEW_UIMAP[m] then
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

-- Whether (map, x, y) (x, y in percent; nil inside instances) is one of
-- Forever's new places.
local function newHere(map, x, y)
	if worldMap and NEW_MAP[worldMap] then return true end
	if map and isNewMap(map) then return true end
	if not x then return false end
	for _, e in ipairs(ENTRANCES) do
		if e[1] == map and ns.Yards(map, x - e[2], y - e[3]) <= ENTRANCE_YARDS then return true end
	end
	return false
end

-- Explorer mode may work now: recording, and not turned off.
local function active() return ns.ExploreAllowed() and ns.Recording() end

-- Whether explorer density applies at (map, x, y): explorer mode working in
-- one of Forever's new places.
function ns.Dense(map, x, y)
	return active() and newHere(map, x, y) or false
end

-- Whether explorer mode works where the player is now.
function ns.Exploring()
	return active() and newHere(ns.Position()) or false
end

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
	if poiPending or not active() then return end
	poiPending = true
	C_Timer.After(POI_DELAY, readPOIs)
end

ns.On("QUEST_LOG_UPDATE", schedulePOIs)
ns.On("QUEST_ACCEPTED", schedulePOIs)
ns.On("ZONE_CHANGED_NEW_AREA", function()
	readInstance()
	schedulePOIs()
end)
ns.On("ZONE_CHANGED", schedulePOIs)
ns.On("PLAYER_ENTERING_WORLD", readInstance)

---------------------------------------------------------------------------
-- Every second: the one-time chat note when explorer mode first works, and
-- `imap`: inside a new dungeon, its uiMapID and floor whenever they change
-- (the client gives no position there).
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

local function tick()
	readInstance()
	if not active() then return end
	local map, x, y = ns.Position()
	if not newHere(map, x, y) then
		lastInst, lastMap = nil, nil
		return
	end
	if not ns.ExploreSaid() then
		ns.Print(L["recording more detail here to map this new zone (/psrec explore off to stop)"])
		ns.SetExploreSaid()
	end
	if not (inInstance and worldMap and map) or (worldMap == lastInst and map == lastMap) then return end
	local group, floor = floorOf(map)
	if ns.Rec("imap", worldMap, map, group, floor) then lastInst, lastMap = worldMap, map end
end
C_Timer.NewTicker(1, tick)

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
	if ns.Value(unit) ~= "player" or not active() then return end
	spell = Num(spell)
	if not (spell and isOpening(spell)) or not ns.Exploring() then return end
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
	readInstance()
	schedulePOIs()
end)
