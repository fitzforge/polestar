-- Polestar.Names: quest, NPC, object and item names in the language
-- Polestar shows (the Language setting, Core/Locale.lua: the client's unless
-- the player chose another). Contract: docs/ARCHITECTURE.md, "Names".
--
-- The guides and data packs name things in English. In another language
-- the guide window, the target button, objective matching, the quest
-- database's names and Lookup ask here first and keep their English when the
-- answer is nil.
--
--   Names.Quest(id) / Names.Npc(id) / Names.Object(id) / Names.Item(id) -> name | nil
--     The client's own name first (a quest's title, C_QuestLog; an item's,
--     C_Item; an NPC's or object's as the client named it in play, below),
--     then the names pack of its language, Names.lua in the language folder
--     Polestar_<locale> (built by `forge data names`; our guides' texts and
--     the interface strings share the folder), already in through
--     Core/Locale.lua (when that failed, loaded on demand on the first ask),
--     else nil. Always nil in English (an enUS or enGB client following
--     the game, or English chosen), which loads nothing. The client's own
--     names count only while Polestar shows the client's language (Native):
--     with another language chosen the pack's alone. A quest or item the
--     client has not cached is asked for,
--     once a session; when the asked names arrive (QUEST_DATA_LOAD_RESULT,
--     ITEM_DATA_LOAD_RESULT) one STEP_UPDATED redraws the guide window.
--   Names.Spell(id)       -- the client's (C_Spell.GetSpellName, GetSpellInfo)
--   Names.Faction(id)     -- the client's (C_Reputation, GetFactionInfoByID), else the pack's
--   Names.Instance(mapID) -- the pack's (Map.csv), else GetRealZoneText(mapID)
--   Names.Area(areaID)    -- the client's (C_Map.GetAreaInfo)
--   Names.Taxi(id) / Names.Encounter(id)   -- the pack's (TaxiNodes, DungeonEncounter)
--     each -> name | nil, nil in English
--   Names.Get(kind, id) -> name | nil   -- the above by kind (quest npc object
--     item spell faction map area taxi encounter), and any other kind a pack
--     adds (its table only): "subzone", a walking map's area by its
--     WMOAreaTable row, named as the client's subzone there (the folder's
--     Subzones.lua, `forge data subzones`; Nav/Walk.lua's floor by subzone)
--   Names.Cached(kind, id) -> name | nil   -- the same, never asking the
--     server; an item's name from the pack only (Lookup indexes thousands)
--   Names.Learn(unit) -> name | nil   -- remembers the name the client shows
--     for an NPC or a quest-giving object (by its GUID's id), per client
--     language, in PolestarDB.names; done on target, mouseover, nameplates
--     and NPC windows, while Native. A learned name comes before the pack's; one equal to
--     the pack's is not kept; at most 2,000 per language, oldest dropped
--     first. A change fires NAME_LEARNED(kind, id) and redraws the guide
--     window when its current or next step names that id.
--   Names.Localised() -> bool   -- Polestar shows a language other than English
--   Names.Native() -> bool      -- Polestar shows the client's language
--   Names.Language() -> locale  -- the language Polestar shows ("deDE"; an
--     English one as "enUS" or "enGB")
--   Names.ClientLanguage() -> locale   -- the client's, GetLocale()
--   Names.SetLanguage(locale)   -- Core/Locale.lua, at ADDON_LOADED, when the
--     Language setting asks for another than the client's: drops the names
--     the client's folder brought; that language's folder brings its own
--   Names.Ready() -> bool       -- the pack is in, or will not load this session
--   Names.PackName() -> "Polestar_<locale>" | nil (English)
--   Names.AddChunk(locale, kind, lo, hi, text)   -- the pack's files: one
--     LuaChunks chunk (Core/LuaChunks.lua) of "<id>\t<name>" lines of kind
--     quest npc object item, or another a pack adds; ignored unless locale is
--     the one Polestar shows. A name stays text in its chunk and is cut out when asked.

local ADDON, ns = ...

local Names = {}
ns.Names = Names

local type, pairs, ipairs, tonumber, floor = type, pairs, ipairs, tonumber, math.floor

local ENGLISH = { enUS = true, enGB = true }
local client = (GetLocale and GetLocale()) or "enUS"
-- The language shown: the client's until Core/Locale.lua reads the Language
-- setting (ADDON_LOADED).
local shown = client
local localised = not ENGLISH[shown]
local native = true
local PACK = localised and ("Polestar_" .. shown) or nil

local LuaChunks = ns.LuaChunks
local chunks = LuaChunks.New()
-- Names the client showed in play live in PolestarDB.names[<client locale>]
-- ({ npc = { [id] = name }, object = {...}, order = { "n<id>"|"o<id>", ... } },
-- oldest first), read through ns.DB() each time once saved variables are in
-- (ADDON_LOADED); at most LEARN_CAP ids, the oldest dropped first.
local svReady = false
local LEARN_CAP = 2000
local ready = not localised -- the pack is in, or will not load this session
-- Ids asked of the server: 1 while waiting, 2 once answered. Never asked twice.
local asked = { quest = {}, item = {} }
local redrawing = false
local deferred = false -- a load was refused in combat

function Names.Localised() return localised end
function Names.Native() return native end
function Names.Language() return shown end
function Names.ClientLanguage() return client end
function Names.Ready() return ready end
function Names.PackName() return PACK end

function Names.AddChunk(loc, kind, lo, hi, text)
	if loc ~= shown or type(kind) ~= "string" or type(text) ~= "string" then return end
	chunks:Add(kind, lo, hi, text)
end

-- One redraw for a burst of arrivals: the guide window refills its rows
-- (GuideFrame's STEP_UPDATED) with the names now cached.
-- (Names.revision counts them: the step browser draws its skipped cards,
-- whose reasons name quests, again when it moves.)
Names.revision = 0
local function redraw()
	redrawing = false
	Names.revision = Names.revision + 1
	local E = ns.Engine
	local step = E and E.GetStepIndex and E.GetStepIndex()
	if step then ns.Fire("STEP_UPDATED", step) end
end

local function scheduleRedraw()
	if redrawing then return end
	redrawing = true
	ns.After(0.2, redraw)
end

-- Data.Pack refuses in combat: the load is tried again when combat ends
-- (PLAYER_REGEN_ENABLED) or at the next ask, and once it lands NAMES_LOADED
-- fires (the tracker reads its names again) and the guide window redraws:
-- what showed meanwhile was English. Any other answer (loaded, missing,
-- disabled...) is final for the session.
local function load()
	local Data = ns.Data
	if not (Data and Data.Pack) then
		ready = true
		return
	end
	local ok, reason = Data.Pack(PACK)
	if not ok and reason == "combat" then
		deferred = true
		return
	end
	ready = true
	if ok and deferred then
		deferred = false
		ns.Fire("NAMES_LOADED")
		scheduleRedraw()
	end
end

local function fromPack(kind, id, cursor)
	if not ready then load() end
	return LuaChunks.Unesc(chunks:Raw(kind, id, cursor))
end

-- This client language's learned names, or nil before saved variables load.
local function store()
	if not svReady then return nil end
	local db = ns.DB()
	if type(db.names) ~= "table" then db.names = {} end
	local mine = db.names[client]
	if type(mine) ~= "table" then
		mine = {}
		db.names[client] = mine
	end
	if type(mine.npc) ~= "table" then mine.npc = {} end
	if type(mine.object) ~= "table" then mine.object = {} end
	if type(mine.order) ~= "table" then
		local order = {}
		for id in pairs(mine.npc) do order[#order + 1] = "n" .. id end
		for id in pairs(mine.object) do order[#order + 1] = "o" .. id end
		mine.order = order
	end
	return mine
end

-- What the client showed in play is in its language: none while another shows.
local function fromPlay(kind, id)
	if not native then return nil end
	local mine = store()
	local t = mine and mine[kind]
	return t and t[id]
end

local function ask(kind, id)
	if asked[kind][id] then return end
	asked[kind][id] = 1
	local C = ns.Compat
	if kind == "quest" then C.RequestQuest(id) else C.RequestItem(id) end
end

local function valid(id)
	return localised and type(id) == "number"
end

function Names.Quest(id)
	if not valid(id) then return nil end
	if native then
		local t = ns.Compat.GetQuestTitle(id)
		if t then return t end
		ask("quest", id)
	end
	return fromPack("quest", id)
end

function Names.Item(id)
	if not valid(id) then return nil end
	if native then
		local n = ns.Compat.GetItemName(id)
		if n then return n end
		ask("item", id)
	end
	return fromPack("item", id)
end

function Names.Npc(id)
	if not valid(id) then return nil end
	return fromPlay("npc", id) or fromPack("npc", id)
end

function Names.Object(id)
	if not valid(id) then return nil end
	return fromPlay("object", id) or fromPack("object", id)
end

-- A client API's answer when it is a usable name.
local function clientName(fn, ...)
	if not fn then return nil end
	local ok, name = pcall(fn, ...)
	if not ok then return nil end
	if type(name) == "table" then name = name.name end
	name = ns.Compat.Readable(name)
	if type(name) ~= "string" or name == "" then return nil end
	return name
end

function Names.Spell(id)
	if not (native and valid(id)) then return nil end
	return clientName(C_Spell and C_Spell.GetSpellName, id) or clientName(GetSpellInfo, id)
end

-- The client knows a faction the character has not met only by the pack.
function Names.Faction(id)
	if not valid(id) then return nil end
	return native and (clientName(C_Reputation and C_Reputation.GetFactionDataByID, id) or clientName(GetFactionInfoByID, id))
		or fromPack("faction", id)
end

-- An instance by its map ID (Map.csv): the pack's (the client's Map table),
-- else GetRealZoneText(mapID), which an older client answers with the
-- current zone whatever it is asked: trusted only inside that instance or
-- when it names somewhere else.
function Names.Instance(id)
	if not valid(id) then return nil end
	local n = fromPack("map", id)
	if n or not (native and GetRealZoneText) then return n end
	n = clientName(GetRealZoneText, id)
	if not n then return nil end
	local here = GetInstanceInfo and select(8, GetInstanceInfo())
	if here == id or n ~= clientName(GetRealZoneText) then return n end
	return nil
end

function Names.Area(id)
	if not (native and valid(id)) then return nil end
	return ns.Compat.GetAreaName(id)
end

function Names.Taxi(id)
	if not valid(id) then return nil end
	return fromPack("taxi", id)
end

function Names.Encounter(id)
	if not valid(id) then return nil end
	return fromPack("encounter", id)
end

local BY_KIND = {
	quest = Names.Quest, item = Names.Item, npc = Names.Npc, object = Names.Object,
	spell = Names.Spell, faction = Names.Faction, map = Names.Instance, area = Names.Area,
	taxi = Names.Taxi, encounter = Names.Encounter,
}

function Names.Get(kind, id)
	local fn = BY_KIND[kind]
	if fn then return fn(id) end
	if not valid(id) then return nil end
	return fromPack(kind, id)
end

-- A game name in the client's language (Names.Get), else `english` through
-- Polestar's own strings: the names the settings' previews show ("Kobold
-- Vermin" read "Kobold Vermin" in every language).
function Names.Or(kind, id, english)
	return Names.Get(kind, id) or ns.L[english]
end

function Names.Cached(kind, id, cursor)
	if not valid(id) then return nil end
	if kind == "quest" and native then
		local t = ns.Compat.GetQuestTitle(id)
		if t then return t end
	end
	return fromPlay(kind, id) or fromPack(kind, id, cursor)
end

-- The client names an NPC (or a quest-giving object, through the "npc"
-- unit) in its own language: that name is the truth, kept over the pack's.
local LEARN_KIND = { Creature = "npc", Vehicle = "npc", GameObject = "object" }

-- Drops the oldest learned names, a tenth of the cap at once, once there
-- are more than LEARN_CAP.
local function prune(mine)
	local order = mine.order
	local drop = #order - LEARN_CAP + floor(LEARN_CAP / 10)
	local last = {}
	for i, key in ipairs(order) do last[key] = i end
	local keep = {}
	for i, key in ipairs(order) do
		local kind, id = key:sub(1, 1) == "n" and "npc" or "object", tonumber(key:sub(2))
		if last[key] == i then
			if i <= drop then
				if id then mine[kind][id] = nil end
			elseif id and mine[kind][id] ~= nil then
				keep[#keep + 1] = key
			end
		end
	end
	mine.order = keep
end

-- The current or next step of the active guide names this NPC or object.
local function onStep(kind, id)
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local cur = E and E.GetStepIndex and E.GetStepIndex()
	if not (g and g.steps and cur) then return false end
	for s = cur, cur + 1 do
		local step = g.steps[s]
		for _, goal in ipairs(step and step.goals or {}) do
			if goal[kind] == id then return true end
		end
	end
	return false
end

-- A changed name fires NAME_LEARNED(kind, id) (caches drop their copy) and
-- redraws the guide window when its current or next step names that id.
-- A name the pack already gives is not kept.
function Names.Learn(unit)
	if not (localised and native and UnitGUID and UnitName) then return nil end
	local mine = store()
	if not mine then return nil end
	local C = ns.Compat
	local guid = C.Readable(UnitGUID(unit))
	if type(guid) ~= "string" then return nil end
	local gk, _, _, _, _, sid = strsplit("-", guid)
	local kind, id = LEARN_KIND[gk], tonumber(sid)
	if not (kind and id) then return nil end
	if kind == "npc" and UnitPlayerControlled and C.Readable(UnitPlayerControlled(unit)) then return nil end
	local name = C.Readable(UnitName(unit))
	if type(name) ~= "string" or name == "" or name == UNKNOWNOBJECT then return nil end
	local t = mine[kind]
	local old = t[id]
	if old == name then return name end
	if name == fromPack(kind, id) then
		if old == nil then return name end
		t[id] = nil
	else
		if old == nil then
			local order = mine.order
			order[#order + 1] = (kind == "npc" and "n" or "o") .. id
			if #order > LEARN_CAP then prune(mine) end
		end
		t[id] = name
	end
	ns.Fire("NAME_LEARNED", kind, id)
	if onStep(kind, id) then scheduleRedraw() end
	return name
end

local function arrived(kind, id, success)
	if asked[kind][id] ~= 1 then return end
	asked[kind][id] = 2
	if success == false then return end
	scheduleRedraw()
end

-- The events a translated Polestar listens to: from the first files when the
-- client's language is one, else once SetLanguage turns another on.
local listening = false
local function listen()
	if listening then return end
	listening = true
	ns.RegisterEvent("QUEST_DATA_LOAD_RESULT", function(_, id, success) arrived("quest", id, success) end)
	ns.RegisterEvent("ITEM_DATA_LOAD_RESULT", function(_, id, success) arrived("item", id, success) end)
	ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() if deferred and not ready then load() end end)
	ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() Names.Learn("target") end)
	ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() Names.Learn("mouseover") end)
	ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", function(_, unit) Names.Learn(unit) end)
	local function talking() if not Names.Learn("npc") then Names.Learn("questnpc") end end
	for _, e in pairs({ "GOSSIP_SHOW", "QUEST_GREETING", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE", "MERCHANT_SHOW", "TRAINER_SHOW" }) do
		ns.RegisterEvent(e, talking)
	end
end

ns.OnInit(function() svReady = true end)
if localised then listen() end

function Names.SetLanguage(loc)
	if type(loc) ~= "string" or loc == shown then return end
	shown = loc
	localised = not ENGLISH[loc]
	native = loc == client
	PACK = localised and ("Polestar_" .. loc) or nil
	chunks = LuaChunks.New()
	ready = not localised
	deferred = false
	if localised then listen() end
end
