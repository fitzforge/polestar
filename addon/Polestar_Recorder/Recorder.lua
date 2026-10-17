-- Polestar Recorder: writes what the player does while leveling into
-- PolestarRecorderDB.sessions, in the schema of docs/ARCHITECTURE.md
-- ("Toolchain → Recordings"). `node tools/polestar.js record import` turns it
-- into data/recordings/<session>.json; `record draft` turns that into a guide.
-- Off until the player turns it on (/psrec on, or Options > Recorder): while
-- off nothing is written, not even a session.
--
-- This file: SavedVariables access, sessions, the event log and caps,
-- positions and map info. Quests.lua, World.lua and Commands.lua add the
-- recorders and the /psrec command on the shared namespace.
--
-- Forever beta can restore SavedVariables as nil after a cold client restart.
-- Nothing here trusts a cached PolestarRecorderDB: DB() recreates it, and
-- Session() re-attaches the live session table to whatever DB() returns, so
-- a lost table never loses the session being recorded.

local ADDON, ns = ...

-- ns.L[key]: the key is the English text, a missing key returns itself.
-- Locales/<locale>.lua (after this file in the TOC) fill it on that client,
-- as Polestar's do (docs/TRANSLATING.md; `node tools/polestar.js i18n`).
ns.L = setmetatable({}, { __index = function(_, key) return key end })

local type, pairs, pcall, floor, tostring, select = type, pairs, pcall, math.floor, tostring, select

ns.SCHEMA = 1

-- Per-session event caps. Breadcrumbs go first; the total keeps a runaway
-- session from bloating the SavedVariables file past what the client loads.
ns.CAPS = {
	total = 60000,
	pos = 20000,
	progress = 8000,
	kill = 8000,
	loot = 8000,
	slain = 8000,
	drop = 8000,
	rare = 2000,
	treasure = 1000,
	enter = 500,
	encounter = 500,
	gossip = 4000,
	vendor = 2000,
	trainer = 1000,
	zone = 4000,
	mark = 500,
	skill = 3000,
	rep = 4000,
	explore = 1500,
	craft = 4000,
	learn = 1500,
	achieve = 1500,
	step = 6000,
	combat = 12000,
	afk = 1000,
	revive = 1000,
}

---------------------------------------------------------------------------
-- Chat output
---------------------------------------------------------------------------

local PREFIX = "|cff4fd1c5Polestar Recorder|r: "

function ns.Print(...)
	local n = select("#", ...)
	local parts = {}
	for i = 1, n do parts[i] = tostring((select(i, ...))) end
	DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. table.concat(parts, " "))
end

---------------------------------------------------------------------------
-- Game events, through one hidden frame
---------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
local handlers = {} -- event -> { fn, ... }

-- Returns false for an event this client does not know (RegisterEvent
-- throws on unknown names).
function ns.On(event, fn)
	local list = handlers[event]
	if not list then
		local ok = pcall(eventFrame.RegisterEvent, eventFrame, event)
		if not ok then return false end
		list = {}
		handlers[event] = list
	end
	list[#list + 1] = fn
	return true
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
	local list = handlers[event]
	if not list then return end
	for i = 1, #list do
		local ok, err = pcall(list[i], event, ...)
		if not ok then geterrorhandler()(err) end
	end
end)

---------------------------------------------------------------------------
-- Small helpers
---------------------------------------------------------------------------

local function round2(v) return floor(v * 100 + 0.5) / 100 end
ns.Round2 = round2

-- Values the client marks secret (restricted contexts) are unusable.
local function usable(v)
	if v == nil then return false end
	if issecretvalue and issecretvalue(v) then return false end
	return true
end
ns.Usable = usable

-- "Creature-0-1465-0-2105-448-000043F59F" -> "Creature", 448
function ns.ParseGUID(guid)
	if not usable(guid) or type(guid) ~= "string" then return nil end
	local kind, id = guid:match("^(%a+)%-[^-]*%-[^-]*%-[^-]*%-[^-]*%-(%d+)")
	return kind, tonumber(id)
end

-- npcID, name, objectID of a unit token ("npc", "target", ...). Game objects
-- (wanted posters, quest boxes) are not units, so UnitExists("npc") is false
-- for them while UnitGUID("npc") is their GameObject GUID: go by the GUID.
function ns.UnitEntity(unit)
	local kind, id = ns.ParseGUID(UnitGUID and UnitGUID(unit))
	if not kind then return nil end
	local name = UnitName and UnitName(unit)
	if not usable(name) then name = nil end
	if kind == "Creature" or kind == "Vehicle" then return id, name, nil end
	if kind == "GameObject" then return nil, name, id end
	return nil, name, nil
end

---------------------------------------------------------------------------
-- SavedVariables
---------------------------------------------------------------------------

-- Recording is opt-in: nothing is written, not even a session, until the
-- player turns it on (/psrec on, or Options > Recorder). The choice lives in
-- the DB and here, so a DB table lost mid-session keeps recording on.
local enabled = false

local function DB()
	local db = PolestarRecorderDB
	if type(db) ~= "table" then
		db = {}
		PolestarRecorderDB = db
	end
	if type(db.sessions) ~= "table" then db.sessions = {} end
	if type(db.maps) ~= "table" then db.maps = {} end
	if type(db.fp) ~= "table" then db.fp = {} end
	db.schema = ns.SCHEMA
	if enabled then db.enabled = true end
	return db
end
ns.DB = DB

function ns.IsEnabled() return enabled end

local session -- forward: the live session table
local inWorld = false

-- Turning recording on in play starts a session at once.
function ns.SetEnabled(on)
	enabled = on and true or false
	DB().enabled = enabled or nil
	if enabled and not session and inWorld then ns.StartSession(false) end
end

---------------------------------------------------------------------------
-- Positions and maps
---------------------------------------------------------------------------

-- uiMapID, x, y (0-100, two decimals) | uiMapID | nil
function ns.Position()
	if not (C_Map and C_Map.GetBestMapForUnit) then return nil end
	local map = C_Map.GetBestMapForUnit("player")
	if not usable(map) then return nil end
	local v = C_Map.GetPlayerMapPosition and C_Map.GetPlayerMapPosition(map, "player")
	if not v then return map end
	local x, y = v.x, v.y
	if not (usable(x) and usable(y)) then return map end
	return map, round2(x * 100), round2(y * 100)
end

-- Fills ev.map/x/y with the player's position (when known); returns ev.
function ns.Here(ev)
	local map, x, y = ns.Position()
	ev.map, ev.x, ev.y = map, x, y
	return ev
end

local function worldPos(map, x, y)
	local ok, c, pos = pcall(C_Map.GetWorldPosFromMapPos, map, CreateVector2D(x, y))
	if ok and c and pos and pos.x and pos.y then return c, pos.x, pos.y end
end

-- { name, type, parent, c, left, right, top, bottom } for a uiMapID. World
-- bounds follow the Era-frame convention in ARCHITECTURE "Map frames":
-- wx = top + (bottom - top) * y/100, wy = left + (right - left) * x/100.
function ns.MapInfo(map)
	if not (C_Map and C_Map.GetMapInfo) then return nil end
	local info = C_Map.GetMapInfo(map)
	if not info then return nil end
	local m = { name = info.name, type = info.mapType, parent = info.parentMapID }
	if C_Map.GetWorldPosFromMapPos and CreateVector2D then
		local c0, top, left = worldPos(map, 0, 0)
		local c1, bottom, right = worldPos(map, 1, 1)
		if c0 and c0 == c1 and (top ~= bottom or left ~= right) then
			m.c, m.top, m.left, m.bottom, m.right = c0, round2(top), round2(left), round2(bottom), round2(right)
		end
	end
	return m
end

-- Yards per 100% of map width and height (nil when unknown).
local sizeW, sizeH = {}, {}
function ns.MapSize(map)
	local w = sizeW[map]
	if w == nil then
		w, sizeH[map] = false, false
		if C_Map and C_Map.GetMapWorldSize then
			local mw, mh = C_Map.GetMapWorldSize(map)
			if mw and mh and mw > 0 and mh > 0 then w, sizeH[map] = mw, mh end
		end
		sizeW[map] = w
	end
	if not w then return nil end
	return w, sizeH[map]
end

-- Distance in yards between two points (0-100) on one map; percent units
-- scaled by 30 yd/% when the map size is unknown.
function ns.Yards(map, dx, dy)
	local w, h = ns.MapSize(map)
	if w then
		dx, dy = dx * w / 100, dy * h / 100
	else
		dx, dy = dx * 30, dy * 30
	end
	return (dx * dx + dy * dy) ^ 0.5
end

---------------------------------------------------------------------------
-- Spells and trait trees (talents, Legacy trees)
---------------------------------------------------------------------------

function ns.SpellName(spellID)
	if not spellID then return nil end
	if C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(spellID) end
	return nil
end

local function copyList(list)
	local out = {}
	if type(list) == "table" then
		for i = 1, #list do out[i] = list[i] end
	end
	return out
end

-- { id, groups = { { id, name, order, icon } }, nodes = { { id, x, y, type,
-- maxRanks, groups, edges, entries = { { id, definition, maxRanks, type,
-- spell, name } } } } } and the number of visible nodes.
function ns.TraitTree(configID, treeID)
	local tree = { id = treeID, groups = {}, nodes = {} }
	if not (C_Traits and C_Traits.GetTreeNodes and C_Traits.GetNodeInfo) then return tree, 0 end
	if C_Traits.GetGroupDisplayInfoByTreeID then
		local groups = C_Traits.GetGroupDisplayInfoByTreeID(treeID)
		if type(groups) == "table" then
			for _, g in ipairs(groups) do
				tree.groups[#tree.groups + 1] = { id = g.groupID, name = g.displayName, order = g.orderIndex, icon = g.icon }
			end
		end
	end
	local count = 0
	for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID) or {}) do
		local n = C_Traits.GetNodeInfo(configID, nodeID)
		if n and n.ID and n.ID ~= 0 and n.isVisible ~= false then
			local node = {
				id = n.ID, x = n.posX, y = n.posY, type = n.type, maxRanks = n.maxRanks,
				groups = copyList(n.groupIDs), entries = {}, edges = {},
			}
			if type(n.visibleEdges) == "table" then
				for _, edge in ipairs(n.visibleEdges) do
					node.edges[#node.edges + 1] = edge.targetNode
				end
			end
			for _, entryID in ipairs(n.entryIDs or {}) do
				local e = C_Traits.GetEntryInfo and C_Traits.GetEntryInfo(configID, entryID)
				if e then
					local def = e.definitionID and C_Traits.GetDefinitionInfo and C_Traits.GetDefinitionInfo(e.definitionID)
					local spell = def and def.spellID
					node.entries[#node.entries + 1] = {
						id = entryID, definition = e.definitionID, maxRanks = e.maxRanks, type = e.type,
						spell = spell, name = (def and def.overrideName) or ns.SpellName(spell),
					}
				end
			end
			tree.nodes[#tree.nodes + 1] = node
			count = count + 1
		end
	end
	return tree, count
end

---------------------------------------------------------------------------
-- Sessions
---------------------------------------------------------------------------

local t0 = 0 -- GetTime() at session start
local sessionCallbacks = {}

-- Last recorded position (any event with coordinates), for breadcrumbs.
ns.last = { map = nil, x = nil, y = nil, at = -math.huge }

function ns.OnSession(fn) sessionCallbacks[#sessionCallbacks + 1] = fn end

-- The live session, or nil while recording is off: every writer goes through
-- here, so an off recorder writes nothing.
local function Session()
	local s = session
	if not s or not enabled then return nil end
	local db = DB()
	if db.sessions[s.session] ~= s then db.sessions[s.session] = s end
	if db.current ~= s.session then db.current = s.session end
	return s
end
ns.Session = Session

local function charInfo()
	local _, race = UnitRace("player")
	local _, class = UnitClass("player")
	local faction = UnitFactionGroup("player")
	return {
		name = UnitName("player"),
		realm = GetRealmName and GetRealmName() or nil,
		race = race,
		class = class,
		faction = faction,
	}
end

local function buildString()
	if not GetBuildInfo then return nil end
	local version, build = GetBuildInfo()
	if build and build ~= "" then return tostring(version) .. "." .. tostring(build) end
	return version and tostring(version) or nil
end

function ns.Now()
	return floor((GetTime() - t0) * 10 + 0.5) / 10
end

-- New session per login. A UI reload continues the session the reload
-- interrupted (same character, still the current one in the DB).
function ns.StartSession(isReload)
	local db = DB()
	local char = charInfo()
	local prev = isReload and db.current and db.sessions[db.current]
	if type(prev) == "table" and type(prev.char) == "table" and prev.char.name == char.name
		and prev.char.realm == char.realm and type(prev.events) == "table" then
		session = prev
		if type(prev.counts) ~= "table" then prev.counts = {} end
		if type(prev.dropped) ~= "table" then prev.dropped = {} end
		if type(prev.maps) ~= "table" then prev.maps = {} end
		local last = prev.events[#prev.events]
		local elapsed = GetServerTime() - (prev.started or GetServerTime())
		if last and type(last.t) == "number" and last.t > elapsed then elapsed = last.t end
		t0 = GetTime() - elapsed
	else
		local started = GetServerTime()
		local base = tostring(started) .. "-" .. tostring(char.name or "Unknown")
		local key, n = base, 1
		while db.sessions[key] do
			n = n + 1
			key = base .. "-" .. n
		end
		session = {
			schema = ns.SCHEMA,
			build = buildString(),
			session = key,
			char = char,
			started = started,
			ended = started,
			events = {},
			maps = {},
			counts = {},
			dropped = {},
		}
		db.sessions[key] = session
		t0 = GetTime()
	end
	db.current = session.session
	ns.last.map, ns.last.x, ns.last.y, ns.last.at = nil, nil, nil, -math.huge
	for i = 1, #sessionCallbacks do
		local ok, err = pcall(sessionCallbacks[i], session, isReload)
		if not ok then geterrorhandler()(err) end
	end
	return session
end

-- Records map info for a map the session touched (once per map).
function ns.NoteMap(map)
	local s = Session()
	if not s or not map or s.maps[map] then return end
	local info = ns.MapInfo(map)
	if info then s.maps[map] = info end
end

-- Appends one event; returns true when it was stored. `ev` becomes the
-- stored table (callers pass a fresh one).
function ns.Record(kind, ev)
	local s = Session()
	if not s then return false end
	local events, counts = s.events, s.counts
	local n = #events
	local cap = ns.CAPS[kind]
	if n >= ns.CAPS.total or (cap and (counts[kind] or 0) >= cap) then
		s.dropped[kind] = (s.dropped[kind] or 0) + 1
		return false
	end
	ev.t = ns.Now()
	ev.e = kind
	events[n + 1] = ev
	counts[kind] = (counts[kind] or 0) + 1
	s.ended = GetServerTime()
	if ev.map then
		if not s.maps[ev.map] then ns.NoteMap(ev.map) end
		if ev.x then
			local last = ns.last
			last.map, last.x, last.y, last.at = ev.map, ev.x, ev.y, GetTime()
		end
	end
	return true
end

-- Forget every session (and dumps), then start a fresh one if recording.
function ns.ClearAll()
	local db = DB()
	db.sessions = {}
	db.maps = {}
	db.talents = nil
	db.fp = {}
	db.current = nil
	session = nil
	if enabled then return ns.StartSession(false) end
end

---------------------------------------------------------------------------
-- Lifecycle
---------------------------------------------------------------------------

ns.On("ADDON_LOADED", function(_, name)
	if name ~= ADDON then return end
	enabled = type(PolestarRecorderDB) == "table" and PolestarRecorderDB.enabled == true
	DB()
end)

ns.On("PLAYER_ENTERING_WORLD", function(_, isInitialLogin, isReloadingUi)
	inWorld = true
	if not enabled then return end
	if not session or isInitialLogin then
		ns.StartSession(isReloadingUi and true or false)
	end
end)

ns.On("PLAYER_LOGOUT", function()
	local s = Session()
	if s then s.ended = GetServerTime() end
end)
