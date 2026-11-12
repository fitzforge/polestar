-- Dungeon quests only (qol.instanceTrack, on by default): inside a dungeon or
-- raid that Polestar.Dungeons knows, the game's quest watch list holds only
-- that instance's quests, and Polestar's quest markers (Quests/Tracker.lua,
-- QuestDB.SetTracked) show only theirs. Leaving gives back exactly the watch
-- list from before, in its order. Nothing changes anywhere else.
--
--   InstanceTrack.Update()   -- read where the character is and apply (the events run it)
--   InstanceTrack.Saved()    -- the watch list kept from before the instance, or nil
--
-- The instance: Compat.IsInInstance ("party" or "raid") and its map
-- (Compat.GetInstanceMapID) found by Dungeons.ForMap; its quests are the
-- journal page's (Dungeons.Quests). On the way in, the watched quests
-- (C_QuestLog.GetNumQuestWatches, GetQuestIDForQuestWatchIndex) are kept per
-- character (QoL.State().instanceTrack = { key, watched = { questID, ... } }),
-- so a /reload inside still gives them back; then every other quest's watch
-- goes (C_QuestLog.RemoveQuestWatch) and the instance's quests in the log are
-- watched (C_QuestLog.AddQuestWatch). That happens once per instance and
-- session: a quest watched by hand inside stays until the way out, when the
-- watch list is set back to the kept one. Inside an instance Polestar can't
-- name (the data pack refused in combat, a hidden map), nothing changes until
-- it can; one whose page lists no quests is left alone. The kept list is
-- given back only once the quest log has loaded.

local ADDON, ns = ...

local QoL = ns.QoL

local type, ipairs, pairs = type, ipairs, pairs

local InstanceTrack = {}
QoL.InstanceTrack = InstanceTrack

local applied -- the instance key filtered this session
local retry = false -- inside an instance not named yet, or a log not loaded yet

local function readable(v) return ns.Compat.Readable(v) end

local function watchAPI()
	local Q = C_QuestLog
	return Q and Q.GetNumQuestWatches and Q.GetQuestIDForQuestWatchIndex and Q.AddQuestWatch and Q.RemoveQuestWatch and Q or nil
end

-- The watched quests, in the watch list's order.
local function watches()
	local out, Q = {}, watchAPI()
	if not Q then return out end
	for i = 1, readable(Q.GetNumQuestWatches()) or 0 do
		local q = readable(Q.GetQuestIDForQuestWatchIndex(i))
		if type(q) == "number" and q > 0 then out[#out + 1] = q end
	end
	return out
end

local function logLoaded()
	local Q = C_QuestLog
	return Q and Q.GetNumQuestLogEntries and (readable(Q.GetNumQuestLogEntries()) or 0) > 0 or false
end

-- Polestar's markers for these quests only (nil: all again); a marker
-- rebuild only when that changes.
local trackedKey
local function setTracked(key, set)
	if key == trackedKey then return end
	trackedKey = key
	local QDB = ns.QuestDB
	if QDB and QDB.SetTracked then QDB.SetTracked(set) end
end

-- "out", or "in" and the instance's key; "unknown" inside one not named.
local function locate()
	local C = ns.Compat
	local inside, kind = C.IsInInstance()
	if not inside or (kind ~= "party" and kind ~= "raid") then return "out" end
	local D = ns.Dungeons
	local key = D and D.ForMap and D.ForMap(C.GetInstanceMapID())
	if not key then return "unknown" end
	return "in", key
end

-- The instance's quests: a set, and their IDs in the page's order.
local function questSet(key)
	local set, list = {}, {}
	for _, q in ipairs(ns.Dungeons.Quests(key)) do
		if type(q.id) == "number" and not set[q.id] then
			set[q.id] = true
			list[#list + 1] = q.id
		end
	end
	return set, list
end

-- The watch list back as it was kept: false while the log has not loaded.
local function restore(saved)
	local list = type(saved.watched) == "table" and saved.watched or {}
	local Q = watchAPI()
	if not Q then return true end
	if #list > 0 and not logLoaded() then return false end
	for _, q in ipairs(watches()) do Q.RemoveQuestWatch(q) end
	for _, q in ipairs(list) do
		if type(q) == "number" and ns.Compat.IsOnQuest(q) then Q.AddQuestWatch(q) end
	end
	return true
end

local function filter(set, list)
	local Q = watchAPI()
	if not Q then return end
	for _, q in ipairs(watches()) do
		if not set[q] then Q.RemoveQuestWatch(q) end
	end
	local on = {}
	for _, q in ipairs(watches()) do on[q] = true end
	for _, q in ipairs(list) do
		if not on[q] and ns.Compat.IsOnQuest(q) then Q.AddQuestWatch(q) end
	end
end

function InstanceTrack.Saved()
	local s = QoL.State().instanceTrack
	return type(s) == "table" and s or nil
end

function InstanceTrack.Update()
	retry = false
	local s = QoL.State()
	local saved = InstanceTrack.Saved()
	local where, key = locate()
	if where == "unknown" and QoL.On("instanceTrack") then
		retry = true
		return
	end
	if where == "out" or not QoL.On("instanceTrack") then
		applied = nil
		setTracked(nil, nil)
		if saved then
			if restore(saved) then s.instanceTrack = nil else retry = true end
		end
		return
	end
	if applied == key and trackedKey == key then return end
	-- An instance without quests in the data (or a page that won't decode): left alone.
	local set, list = questSet(key)
	if #list == 0 then return end
	if not saved then
		saved = { key = key, watched = watches() }
		s.instanceTrack = saved
	end
	if applied ~= key then
		saved.key = key
		applied = key
		filter(set, list)
	end
	setTracked(key, set)
end

local updateSoon = QoL.Coalesce(InstanceTrack.Update)

QoL.WhileOn("instanceTrack", "PLAYER_ENTERING_WORLD", updateSoon)
QoL.WhileOn("instanceTrack", "ZONE_CHANGED_NEW_AREA", updateSoon)
-- A retry: the pack refused in combat, or the log not loaded at login.
local function again() if retry then updateSoon() end end
ns.RegisterEvent("PLAYER_REGEN_ENABLED", again)
ns.RegisterEvent("QUEST_LOG_UPDATE", again)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.instanceTrack" or path == "qol" or path == "" or path == "dungeons.enabled" then updateSoon() end
end)
ns.OnLogin(updateSoon)
