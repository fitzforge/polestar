-- Polestar.Dungeons, the run inside: which of the instance's bosses died this
-- run, what a dead boss dropped that a quest in the log still needs, and the
-- instance's quests with their live counts. The dungeon tracker's model
-- (UI/DungeonTracker.lua; docs/DESIGN.md, "The Dungeon Tracker").
--
--   Dungeons.Run.Key() -> key | nil   -- the dungeon or raid the player is inside (a party or raid
--       instance with a page, Dungeons.ForMap), nil outside
--   Dungeons.Run.Model([now]) -> tracker | nil   -- nil outside, and inside while the log holds no
--       quest for the instance (unless trackers.dungeon.bossesAlone):
--       tracker = { key, name, bossesDone, bossesTotal, elapsed,
--         loot = { { item, itemName, boss, quest, questTitle, how, need, untilAt } },   -- newest first
--         quests = { { id, title, done, objectives = { { text, cur, max, done, boss, pending } } } },
--         bosses = { { order, name, npc, state = "dead"|"next"|"ahead", role,
--                      ties = { { how, item, itemName, quest, pending } } } },
--         use = { { item, quest } } }
--       quests: Dungeons.Quests(key) in the log, and the log's other quests whose objectives
--       name this instance's bosses or the items they drop; objectives from the quest log
--       (its lines, live), each with the boss that serves it (by the page's objective facts,
--       else the Codex quest's). bossesTotal: the encounters (the bosses without a role);
--       the rare and optional ones follow them. ties: what the boss gives the quests you hold:
--       "kill", "item" (it drops an objective's item), "starts" (it drops the item that starts
--       a quest you haven't done). use: the items the held quests' objectives are used with
--       (the Codex's `useItem`) that are in the bags.
--   Dungeons.Run.Killed(boss[, now])   -- a boss died: checks it off and, for each of its `item`
--       ties to a quest in the log that still needs that item (and each `starts` tie to a
--       quest neither done nor held, its item not in the bags), a loot reminder
--   Dungeons.Run.LOOT_SECONDS, Dungeons.Run.LOOT_MAX
--
-- A boss dies: ENCOUNTER_END with success, by its `encounter` id; a boss
-- without one: UNIT_DIED of its npc in the combat log (listened to only inside
-- an instance whose page has such a boss). A reminder goes when the bags hold
-- what the quest needs (BAG_UPDATE, QUEST_LOG_UPDATE), after LOOT_SECONDS, or
-- when the next boss is pulled (ENCOUNTER_START). Kept per character:
-- CharState().dungeonRun = { key, entered, dead = { [order] = true } }, so a
-- reload or a corpse run keeps its checks; a new run (Maps' instance run,
-- entered at another time) starts over. Fires DUNGEON_RUN_CHANGED(key).

local ADDON, ns = ...
local L = ns.L
local Dungeons = ns.Dungeons

local type, ipairs, pairs, tonumber, max, lower = type, ipairs, pairs, tonumber, math.max, string.lower

local Run = {}
Dungeons.Run = Run

Run.LOOT_SECONDS = 180
Run.LOOT_MAX = 3

local TRACKED = { party = true, raid = true }
local key -- the instance the player is in
local loot = {} -- the reminders, newest first

local function C() return ns.Compat end
local function now() return GetTime and GetTime() or 0 end

local function state()
	local cs = ns.CharState()
	local s = cs.dungeonRun
	if type(s) ~= "table" or type(s.dead) ~= "table" then
		s = { dead = {} }
		cs.dungeonRun = s
	end
	return s
end

-- The model is asked for several times a frame (the tracker, the guide
-- window's region, the quest item button): one build a frame until the run
-- changes (rev).
local rev, memoAt, memoRev, memo = 0, nil, nil, nil

local function changed()
	rev = rev + 1
	ns.Fire("DUNGEON_RUN_CHANGED", key)
end

function Run.Key() return key end

local function itemCount(id)
	return tonumber(C().GetItemCount(id)) or 0
end

local function held(id) return C().IsOnQuest(id) and true or false end

-- The page quest's need of item `item` (its objective's count), 1 without one.
local function needOf(q, item)
	for _, o in ipairs(q and q.objectives or {}) do
		if (o.k == "item" or o.type == "item") and o.id == item then return tonumber(o.n or o.count) or 1 end
	end
	return 1
end

local function questOf(id)
	return (key and Dungeons.Quest(key, id)) or (ns.Codex and ns.Codex.Quest and ns.Codex.Quest(id)) or nil
end

local function titleOf(id, q)
	return C().GetQuestTitle(id) or (q and q.title) or ""
end

-- Whether a reminder still stands: the bags short of the need, the quest still
-- open (or, for one that starts a quest, not yet taken), and its time not up.
local function standing(e, t)
	if t >= e.untilAt then return false end
	if itemCount(e.item) >= e.need then return false end
	if e.how == "starts" then return not (held(e.quest) or C().IsQuestCompleted(e.quest)) end
	return held(e.quest) and not C().IsQuestReadyForTurnIn(e.quest)
end

local function prune(t)
	local kept, gone = {}, false
	for _, e in ipairs(loot) do
		if standing(e, t) then kept[#kept + 1] = e else gone = true end
	end
	loot = kept
	return gone
end

function Run.Killed(boss, t)
	if not (key and boss) then return end
	t = t or now()
	state().dead[boss.order] = true
	for _, tie in ipairs(boss.quests or {}) do
		local id, item = tie.id, tie.item
		local q = item and questOf(id)
		local want
		if tie.how == "item" then
			want = held(id) and not C().IsQuestReadyForTurnIn(id) and itemCount(item) < needOf(q, item)
		elseif tie.how == "starts" then
			want = not (held(id) or C().IsQuestCompleted(id)) and itemCount(item) < 1
		end
		if want then
			local e = { item = item, itemName = C().GetItemName(item) or tie.itemName, boss = boss.name, quest = id,
				questTitle = titleOf(id, q), how = tie.how, need = tie.how == "item" and needOf(q, item) or 1,
				untilAt = t + Run.LOOT_SECONDS }
			table.insert(loot, 1, e)
		end
	end
	while #loot > Run.LOOT_MAX do loot[#loot] = nil end
	if #loot > 0 and ns.After then ns.After(Run.LOOT_SECONDS + 0.5, function() if prune(now()) then changed() end end) end
	changed()
end

---------------------------------------------------------------------------
-- Matching quests and objectives to bosses
---------------------------------------------------------------------------

-- The objective facts of a quest: the page's ({ k, id, n, name }) or the
-- Codex quest's ({ type, id, count, text }), as { k, id, name }.
local function facts(q)
	local out = {}
	for i, o in ipairs(q and q.objectives or {}) do
		out[i] = { k = o.k or o.type, id = o.id, name = o.name or o.text, useItem = o.useItem }
	end
	return out
end

-- The boss serving objective fact f: the one it names (a kill) or the one
-- that drops its item (the boss's ties, else its loot).
local function bossFor(f, bosses)
	if not (f and f.id) then return nil end
	for _, b in ipairs(bosses) do
		if f.k == "kill" and b.npc == f.id then return b end
		if f.k == "item" then
			for _, tie in ipairs(b.quests or {}) do if tie.item == f.id then return b end end
			for _, it in ipairs(b.loot or {}) do if it == f.id then return b end end
		end
	end
	return nil
end

-- The quests in the log for this instance: its page's, then any other whose
-- objectives a boss here serves.
local function heldQuests(bosses)
	local out, seen = {}, {}
	for _, q in ipairs(Dungeons.Quests(key)) do
		if not seen[q.id] and held(q.id) then
			seen[q.id] = true
			out[#out + 1] = { id = q.id, q = q }
		end
	end
	local Cx = ns.Codex
	for _, id in ipairs(C().GetLogQuests()) do
		if not seen[id] then
			local rec = Cx and Cx.Quest and Cx.Quest(id)
			for _, f in ipairs(rec and facts(rec) or {}) do
				if bossFor(f, bosses) then
					seen[id] = true
					out[#out + 1] = { id = id, q = rec }
					break
				end
			end
		end
	end
	return out
end

local function pendingFor(quest, item)
	for _, e in ipairs(loot) do
		if e.quest == quest and e.item == item then return true end
	end
	return false
end

local function objectives(h, bosses)
	local fs = facts(h.q)
	local lines = C().GetQuestObjectives(h.id) or {}
	local out = {}
	for i, o in ipairs(lines) do
		local label = C().ObjectiveLabel(o.text)
		local f = (#fs == #lines) and fs[i] or nil
		if not f then
			for _, x in ipairs(fs) do
				if x.name and label ~= "" and lower(x.name) == lower(label) then f = x; break end
			end
		end
		if label == "" then label = f and f.name or "" end
		local b = bossFor(f, bosses)
		out[#out + 1] = { text = label, cur = o.numFulfilled, max = o.numRequired, done = o.finished,
			boss = b and b.name or nil, pending = (f and f.k == "item" and pendingFor(h.id, f.id)) or false }
	end
	return out
end

---------------------------------------------------------------------------
-- The model
---------------------------------------------------------------------------

local build
function Run.Model(t)
	if not key then return nil end
	t = t or now()
	if memoAt == t and memoRev == rev and memo ~= nil then return memo or nil end
	local m = build(t)
	memoAt, memoRev, memo = t, rev, m or false
	return m
end

function build(t)
	local d = Dungeons.Get(key)
	if not d then return nil end
	prune(t)
	local bosses = Dungeons.Bosses(key)
	local hs = heldQuests(bosses)
	local UI = ns.UI
	if #hs == 0 and not (UI and UI.Trackers and UI.Trackers.Get("dungeon", "bossesAlone")) then return nil end
	local m = { key = key, name = d.name, bossesDone = 0, bossesTotal = 0, loot = loot, quests = {}, bosses = {}, use = {} }
	local St = ns.Maps and ns.Maps.GetInstanceStatus and ns.Maps.GetInstanceStatus()
	m.elapsed = St and St.run and ns.Maps.RunSeconds(St.run, St.now) or nil
	local open = {}
	for _, h in ipairs(hs) do
		local done = C().IsQuestReadyForTurnIn(h.id) and true or false
		m.quests[#m.quests + 1] = { id = h.id, title = titleOf(h.id, h.q), done = done, objectives = objectives(h, bosses) }
		if not done then
			open[h.id] = true
			for _, f in ipairs(facts(h.q)) do
				if f.useItem and itemCount(f.useItem) > 0 then m.use[#m.use + 1] = { item = f.useItem, quest = h.id } end
			end
		end
	end
	-- Encounters first in kill order, then the rare and optional ones.
	local dead, nextSet = state().dead, false
	local ordered = {}
	for _, b in ipairs(bosses) do if not b.role then ordered[#ordered + 1] = b end end
	for _, b in ipairs(bosses) do if b.role then ordered[#ordered + 1] = b end end
	for _, b in ipairs(ordered) do
		local isDead = dead[b.order] and true or false
		local st = "ahead"
		if isDead then st = "dead" elseif not nextSet and not b.role then st, nextSet = "next", true end
		if not b.role then
			m.bossesTotal = m.bossesTotal + 1
			if isDead then m.bossesDone = m.bossesDone + 1 end
		end
		local ties = {}
		for _, tie in ipairs(b.quests or {}) do
			local id = tie.id
			local mine = ((tie.how == "item" or tie.how == "kill") and open[id])
				or (tie.how == "starts" and not (held(id) or C().IsQuestCompleted(id)))
			if mine then
				ties[#ties + 1] = { how = tie.how, item = tie.item, itemName = tie.item and (C().GetItemName(tie.item) or tie.itemName) or nil,
					quest = id, pending = tie.item and pendingFor(id, tie.item) or false }
			end
		end
		m.bosses[#m.bosses + 1] = { order = b.order, name = b.name, npc = b.npc, state = st, role = b.role, ties = ties }
	end
	return m
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local function bossBy(field, value)
	if not (key and value) then return nil end
	for _, b in ipairs(Dungeons.Bosses(key)) do
		if b[field] == value then return b end
	end
	return nil
end

local function onDied()
	local _, sub, _, _, _, _, _, guid = CombatLogGetCurrentEventInfo()
	if sub ~= "UNIT_DIED" or type(guid) ~= "string" or (issecretvalue and issecretvalue(guid)) then return end
	local kind, _, _, _, _, id = strsplit("-", guid)
	if kind ~= "Creature" then return end
	local b = bossBy("npc", tonumber(id))
	if b and not b.encounter and not state().dead[b.order] then Run.Killed(b) end
end

local listening = false
local function listen(on)
	if on == listening then return end
	listening = on
	if on then ns.RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", onDied) else ns.UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", onDied) end
end

local function where()
	local inside, kind = C().IsInInstance()
	if not (inside and TRACKED[kind]) then return nil end
	if not Dungeons.IsEnabled() or not Dungeons.Load() then return nil end
	return Dungeons.ForMap(C().GetInstanceMapID())
end

local function check()
	local was = key
	key = where()
	if key then
		local s = state()
		local St = ns.Maps and ns.Maps.GetInstanceStatus and ns.Maps.GetInstanceStatus()
		local entered = St and St.run and St.run.entered or nil
		if s.key ~= key or (entered and s.entered ~= entered) then
			s.key, s.entered, s.dead = key, entered, {}
			loot = {}
		end
		local needLog = false
		for _, b in ipairs(Dungeons.Bosses(key)) do
			if b.npc and not b.encounter then needLog = true; break end
		end
		listen(needLog)
	else
		listen(false)
		loot = {}
	end
	if was ~= key or key then changed() end
end
Run.Check = check

ns.RegisterEvent("PLAYER_ENTERING_WORLD", check)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", check)
ns.RegisterEvent("ENCOUNTER_START", function()
	if not key then return end
	if #loot > 0 then
		loot = {}
		changed()
	end
end)
ns.RegisterEvent("ENCOUNTER_END", function(_, encounterID, _, _, _, success)
	if not key or success ~= 1 and success ~= true then return end
	local b = bossBy("encounter", encounterID)
	if b then Run.Killed(b) end
end)
local function recount()
	if not key then return end
	prune(now())
	changed()
end
ns.RegisterEvent("BAG_UPDATE_DELAYED", recount)
ns.RegisterEvent("QUEST_LOG_UPDATE", recount)
-- A tracker setting (bossesAlone) changes what the model holds.
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "trackers" or (type(path) == "string" and path:sub(1, 17) == "trackers.dungeon.") then rev = rev + 1 end
end)
