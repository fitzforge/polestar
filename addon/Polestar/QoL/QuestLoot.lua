-- Quest-starting loot on the quest item button (qol.questLoot, on by
-- default): an item in the bags that begins a quest this character can take
-- now goes on the quest item button (QoL/Buttons.lua), glowing, until it is
-- clicked there or the quest is in the log. The step's own item comes first:
-- the button shows a starter only while the step gives it nothing. Several
-- starters take turns, oldest first.
--
--   QuestLoot.Current() -> itemID, questID | nil   -- the starter the button shows when the step has no item
--   QuestLoot.Used(itemID)                         -- clicked on the button: not offered again while it stays in the bags
--   QuestLoot.Scan()                               -- read the bags now (the events run it on the next frame)
--
-- A slot counts when the client says its item begins a quest that is not in
-- the log (C_Container.GetContainerItemQuestInfo, QoL.Client.SlotStartsQuest)
-- or, without that, Polestar.QuestDB names the quests the item starts
-- (QuestDB.StartedBy); and QuestDB.CheckAvailable says this character can
-- take that quest now: faction, race, class, level, not done, not in the log,
-- prerequisites done (a grey quest counts too). Race and class are only known
-- to the quest database, so without it loaded nothing is offered. An item
-- whose minimum level is above the character's (GetItemInfo) is passed over.
-- The order the starters arrived in and the clicked ones are kept per
-- character (QoL.State().questLoot), each dropped once its item leaves the
-- bags. Fires QUEST_LOOT_CHANGED(itemID | nil) when Current changes.

local ADDON, ns = ...

local QoL = ns.QoL
local Client = QoL.Client

local type, pairs = type, pairs

local QuestLoot = {}
QoL.QuestLoot = QuestLoot

local current, currentQuest
local ctx = {}
local found = {} -- itemID -> questID | false, for one scan
local OPTS = { lowLevel = true }

local function state()
	local s = QoL.State()
	local t = s.questLoot
	if type(t) ~= "table" then
		t = {}
		s.questLoot = t
	end
	if type(t.seen) ~= "table" then t.seen = {} end -- itemID -> arrival number
	if type(t.used) ~= "table" then t.used = {} end -- itemID -> true once clicked on the button
	if type(t.seq) ~= "number" then t.seq = 0 end
	return t
end

local function loadedQuestDB()
	local Q = ns.QuestDB
	return Q and Q.IsLoaded and Q.IsLoaded() and Q.CheckAvailable and Q.PlayerContext and Q or nil
end

local function isDone(q) return ns.Compat.IsQuestCompleted(q) end
local function isOn(q) return ns.Compat.IsOnQuest(q) end

local function takeable(Q, q)
	return type(q) == "number" and Q.CheckAvailable(q, ctx, isDone, isOn, OPTS) and true or false
end

-- The quest the item in bag/slot begins that this character can take now, or nil.
local function startsFor(Q, bag, slot, id)
	local q = Client.SlotStartsQuest(bag, slot)
	if q then return takeable(Q, q) and q or nil end
	local list = Q.StartedBy and Q.StartedBy(id)
	for i = 1, list and #list or 0 do
		if takeable(Q, list[i]) then return list[i] end
	end
	return nil
end

local function setCurrent(id, q)
	if id == current and q == currentQuest then return end
	current, currentQuest = id, q
	ns.Fire("QUEST_LOOT_CHANGED", id)
end

function QuestLoot.Scan()
	local Q = QoL.On("questLoot") and loadedQuestDB()
	if not Q then return setCurrent(nil, nil) end
	for k in pairs(found) do found[k] = nil end
	local s = state()
	Q.PlayerContext(nil, ctx)
	local level = ctx.level or 1
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local id = info and info.itemID
			if type(id) == "number" and found[id] == nil then
				local min = Client.ItemMinLevel(id)
				local q = not (type(min) == "number" and min > level) and startsFor(Q, bag, slot, id) or nil
				found[id] = q or false
				-- Numbered in bag order the first time it is seen as a starter.
				if q and not s.seen[id] then
					s.seq = s.seq + 1
					s.seen[id] = s.seq
				end
			end
		end
	end
	for id in pairs(s.seen) do
		if not found[id] then s.seen[id] = nil end
	end
	for id in pairs(s.used) do
		if found[id] == nil then s.used[id] = nil end
	end
	local best, bestQ, bestN
	for id, q in pairs(found) do
		if q and not s.used[id] and (not bestN or s.seen[id] < bestN) then best, bestQ, bestN = id, q, s.seen[id] end
	end
	setCurrent(best, bestQ)
end

function QuestLoot.Current()
	if not QoL.On("questLoot") then return nil end
	return current, currentQuest
end

function QuestLoot.Used(itemID)
	if type(itemID) ~= "number" then return end
	state().used[itemID] = true
	QuestLoot.Scan()
end

local scanSoon = QoL.Coalesce(function() QuestLoot.Scan() end)

for _, event in pairs({ "BAG_UPDATE_DELAYED", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "PLAYER_LEVEL_UP" }) do
	QoL.WhileOn("questLoot", event, scanSoon)
end
ns.On("QUESTDB_LOADED", scanSoon)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questLoot" or path == "qol" or path == "" then scanSoon() end
end)
ns.OnLogin(scanSoon)
