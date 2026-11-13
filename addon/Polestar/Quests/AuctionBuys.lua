-- Auction house buys (qol.auctionBuys, on by default): the quest items the
-- character can buy at an auction house instead of farming them, for the
-- running guide and the quest log. UI/AuctionBuys.lua shows them: a card when
-- a guide opens, a reminder in a town with an auction house, and a list.
-- Contract: docs/ARCHITECTURE.md, "Auction house buys".
--
-- What is asked for: every `collect` goal of the running guide that is for
-- this character (Engine.Applies) and serves a quest, from the live step on,
-- and before it while its quest is in the log (its hand-in is still ahead).
-- The quest is the goal's own, else the first one within LOOKAHEAD steps
-- whose objectives (the quest database) ask for the item. Left out: optional
-- goals, a goal naming the NPC who hands the item over, quests done or
-- skipped, and quests that hand the item over themselves. Scope "all" adds
-- the item objectives of the other quests in the log. Per item: the most each
-- quest asks for, summed over the quests, less what the bags and the bank
-- hold (the bank as far as the client knows it; Core/Materials.lua's count
-- where it runs); only items still short are listed.
--
-- An item is an auction house buy when it is all of:
--   1. Tradeable: the client says it is no Quest item (class 12) and binds
--      neither when picked up nor as a quest item (bindType 1 or 4). An item
--      the client has not loaded yet is asked for and judged when it comes.
--   2. Sold by no merchant: the guide has no `buy` goal for it (the route
--      buys it there: QoL/Buy.lua, QoL/Restock.lua) and the quest database
--      names no vendor for it, whoever's side or stock.
--   3. Not got on the way: the whole count takes LONG_FARM kills or loots or
--      more on average (count / drop chance), or nothing drops it. The chance
--      is the best of the goal's own sources (`fromNpcs`, else `fromId`) in
--      the quest database's drop table, which keeps an item's MAX_DROPPERS
--      best droppers: a creature past them drops it at most at the last one's
--      chance. A goal naming no source counts every source the data knows:
--      the droppers, and objects yielding the item at NODE_CHANCE or more
--      (herb and ore nodes only for a character with Herbalism or Mining:
--      without the skill, an item only nodes give is listed); chests and
--      crates below that chance do not count. A chance the data does not know
--      (0) leaves the item out. An item the quest database knows no source
--      for is judged by the Codex (loaded for it, never in combat): listed
--      when a profession makes it, or when the guide's goal for it stands at
--      an auctioneer; left out otherwise (a container, a quest or a gift the
--      guide already has a way to).
--
--   AuctionBuys.On()
--   AuctionBuys.List(scope) -> list, pending   scope "guide" (the running guide's quests) | "all"
--       list: { { item, name, need, have, count, quests = { { id, title } }, why, kills, skill }, ... }
--       in guide order, then log order; why "farm" (kills: the farm's kills or loots on average),
--       "gather" (skill: the gathering skill line the character lacks), "made" (a profession makes
--       it), "ah" (the guide's goal stands at an auctioneer). pending: an item still waits on the
--       client or the Codex; AUCTION_BUYS_CHANGED fires when its answer comes.
--   AuctionBuys.Judge(itemID, count, goal, buys) -> why, kills, skill | false | nil (not known yet)

local ADDON, ns = ...
local Q = ns.QuestDB

local AB = {}
ns.AuctionBuys = AB

local type, ipairs, pairs, tonumber, floor, sort = type, ipairs, pairs, tonumber, math.floor, table.sort

ns.RegisterDefaults("qol", { auctionBuys = true })

AB.LONG_FARM = 20 -- kills or loots on average: a farm this long is worth a trip to the auction house
AB.NODE_CHANCE = 50 -- percent: an object yielding the item this often is a node or the quest's own object
AB.AT_AUCTIONEER = 40 -- yards: a goal this close to an auctioneer sends the player to the auction house
local MAX_DROPPERS = 8 -- forge data questdb keeps an item's 8 best droppers
local LOOKAHEAD = 40 -- steps searched for the quest a quest-less collect serves
local QUEST_CLASS = 12
local BIND_ON_PICKUP, BIND_QUEST = 1, 4
-- Trade goods (class 7) picked from nodes: herbs (subclass 9) with Herbalism
-- (skill line 182), metal and stone (7) with Mining (186).
local GATHER = { [9] = 182, [7] = 186 }

function AB.On() return ns.Get("qol.auctionBuys") and true or false end

local function C() return ns.Compat end

---------------------------------------------------------------------------
-- The quest database's records (layouts: rust/crates/forge-data/src/questdb.rs)
---------------------------------------------------------------------------

-- items[id] = { name, nNpc, npc, chance, ..., nObj, object, chance, ..., vendor, ... }
local function itemRecord(id)
	return Q.IsLoaded() and Q.ItemRecord(id) or nil
end

local function hasVendor(rec)
	local first = 3 + 2 * (rec[2] or 0)
	return #rec > first + 2 * (rec[first] or 0)
end

-- The count quest q's objectives ask for item id, or nil.
local function objectiveCount(q, id)
	local r = Q.QuestRecord(q)
	local obj = r and r[Q.F.OBJ]
	if type(obj) ~= "table" then return nil end
	for k = 1, #obj, 3 do
		if obj[k] == 2 and obj[k + 1] == id then return obj[k + 2] or 1 end
	end
	return nil
end

-- The best chance among `ids` in the n (id, chance) pairs of rec from `first`, or nil.
local function bestOf(rec, first, n, ids)
	local best
	for k = 0, n - 1 do
		local id, c = rec[first + 2 * k], rec[first + 2 * k + 1]
		if c then
			for j = 1, #ids do
				if ids[j] == id and (best == nil or c > best) then best = c end
			end
		end
	end
	return best
end

-- The goal's own sources: creature ids, else object ids, else nil (it names none).
local function namedSources(goal)
	if not goal then return nil end
	local from = goal.fromNpcs
	if type(from) == "table" and #from > 0 then
		local ids = {}
		for i, f in ipairs(from) do ids[i] = f.npc end
		return ids
	end
	if type(goal.fromId) == "number" then
		local ids = { goal.fromId, goal.fromAlsoId }
		if goal.fromKind == "object" then return nil, ids end
		return ids
	end
	return nil
end

---------------------------------------------------------------------------
-- The rule
---------------------------------------------------------------------------

local waiting = {} -- itemID -> true: asked of the client, judged when it comes
local codexWanted = false -- a judgement waits for the Codex (combat)

-- true | false | nil (the client has not loaded it: asked for).
local function tradeable(id)
	local Cp = C()
	if Cp.ItemKind(id) == QUEST_CLASS then return false end
	local bind = Cp.ItemBinding(id)
	if bind == nil then
		waiting[id] = true
		Cp.RequestItem(id)
		return nil
	end
	return bind ~= BIND_ON_PICKUP and bind ~= BIND_QUEST
end

-- Whether an auctioneer the Codex knows stands within AT_AUCTIONEER yards of
-- the goal's point.
local function atAuctioneer(goal, X)
	if not (goal and goal.map and goal.x and goal.y and X.WithRole) then return false end
	local Cp = C()
	local c, wx, wy = Cp.MapToWorld(goal.map, goal.x, goal.y, goal.f)
	if not c then return false end
	local reach = AB.AT_AUCTIONEER * AB.AT_AUCTIONEER
	for _, id in ipairs(X.WithRole("auctioneer")) do
		local npc = X.Npc(id)
		for _, s in ipairs(npc and npc.spawns or {}) do
			if s.map == goal.map then
				local sc, sx, sy = Cp.MapToWorld(s.map, s.x, s.y, s.f)
				if sc == c and (sx - wx) ^ 2 + (sy - wy) ^ 2 <= reach then return true end
			end
		end
	end
	return false
end

-- An item the quest database knows no source for: "made" | "ah" | false | nil (the Codex waits).
local function sourceless(id, goal)
	local X = ns.Codex
	if not (X and X.IsLoaded and X.Item) then return false end
	if not X.IsLoaded() then
		if C().InCombat() then
			codexWanted = true
			return nil
		end
		if not (X.Load and X.Load()) then return false end
	end
	if atAuctioneer(goal, X) then return "ah" end
	local item = X.Item(id)
	for _, s in ipairs(item and item.sources or {}) do
		if s.type == "craft" then return "made" end
	end
	return false
end

-- why, kills, skill | false | nil (not known yet). count: the whole count
-- the quests ask for; goal: the guide's goal for it (nil: a quest in the
-- log); buys: the items the guide buys from a merchant.
function AB.Judge(id, count, goal, buys)
	if type(id) ~= "number" or (buys and buys[id]) then return false end
	local rec = itemRecord(id)
	if not rec or hasVendor(rec) then return false end
	local trade = tradeable(id)
	if not trade then return trade end
	local n = rec[2] or 0
	local oi = 3 + 2 * n
	local no = rec[oi] or 0
	local Cp = C()
	local classID, subclassID = Cp.ItemKind(id)
	local skill = classID == 7 and GATHER[subclassID] or nil
	local gathers = skill and Cp.GetSkillRank(skill) ~= nil
	local npcs, objects = namedSources(goal)
	local chance
	if npcs then
		chance = bestOf(rec, 3, n, npcs)
		if chance == nil then
			-- Not among the listed droppers: below the last of a full list, unknown otherwise.
			if n < MAX_DROPPERS then return false end
			chance = rec[2 + 2 * n]
		end
	elseif objects then
		chance = bestOf(rec, oi + 1, no, objects)
		if chance == nil then return false end
		if skill and chance >= AB.NODE_CHANCE and not gathers then return "gather", nil, skill end
	else
		local nodes = false
		if n > 0 then chance = rec[4] end
		for k = 0, no - 1 do
			local c = rec[oi + 2 + 2 * k]
			if c and c >= AB.NODE_CHANCE then
				if skill and not gathers then
					nodes = true
				elseif chance == nil or c > chance then
					chance = c
				end
			end
		end
		if chance == nil then
			if nodes then return "gather", nil, skill end
			return sourceless(id, goal)
		end
	end
	if not chance or chance <= 0 then return false end
	local kills = count / (chance / 100)
	if kills < AB.LONG_FARM then return false end
	return "farm", floor(kills + 0.5)
end

---------------------------------------------------------------------------
-- The lists
---------------------------------------------------------------------------

-- The quest a quest-less collect at step s serves: the first quest of this
-- or the next LOOKAHEAD steps whose objectives ask for the item.
local function questFor(steps, s, id)
	for t = s, math.min(#steps, s + LOOKAHEAD) do
		local goals = steps[t].goals
		for i = 1, goals and #goals or 0 do
			local q = goals[i].quest
			if type(q) == "number" and objectiveCount(q, id) then return q end
		end
	end
	return nil
end

local function open(q, id)
	local Cp, E = C(), ns.Engine
	if Cp.IsQuestCompleted(q) then return false end
	if E and E.IsQuestSkipped and E.IsQuestSkipped(q) then return false end
	return not Q.HandsOver(q, id)
end

local function questTitle(q, goal)
	return Q.GetQuestTitle(q) or (goal and goal.title) or C().GetQuestTitle(q) or tostring(q)
end

local function itemName(id, w, rec)
	local N = ns.Names
	return C().GetItemName(id) or (N and N.Item and N.Item(id)) or w.itemName or (rec and rec[1]) or ("#" .. id)
end

local cache = {} -- scope -> { list, pending }

local function build(scope)
	local out, pending = {}, false
	if not AB.On() then return out, pending end
	-- The quest database still to load (at login, or after a fight): asked again once it runs.
	if not Q.IsLoaded() then return out, Q.IsWanted() end
	local Cp, E = C(), ns.Engine
	local wants, order = {}, {}
	local function want(id, q, count, goal)
		local w = wants[id]
		if not w then
			w = { quests = {}, qorder = {}, goals = {} }
			wants[id] = w
			order[#order + 1] = id
		end
		if not w.quests[q] then
			w.quests[q] = 0
			w.qorder[#w.qorder + 1] = { id = q, title = questTitle(q, goal) }
		end
		if count > w.quests[q] then w.quests[q] = count end
		if goal then
			w.goals[#w.goals + 1] = goal
			w.itemName = w.itemName or goal.itemName
		end
	end
	local covered, buys = {}, {}
	local g = E and E.GetGuide and E.GetGuide()
	local steps = g and type(g.steps) == "table" and g.steps
	local live = steps and E.GetLiveStep and E.GetLiveStep()
	if live and E.Applies then
		for s = 1, #steps do
			local goals = steps[s].goals
			for i = 1, goals and #goals or 0 do
				local goal = goals[i]
				if goal.t == "buy" and type(goal.item) == "number" then buys[goal.item] = true end
			end
		end
		for s = 1, #steps do
			local goals = steps[s].goals
			for i = 1, goals and #goals or 0 do
				local goal = goals[i]
				local id = goal.item
				if goal.t == "collect" and type(id) == "number" and not goal.optional and not goal.npc then
					local q = goal.quest or questFor(steps, s, id)
					if q and (s >= live or Cp.IsOnQuest(q)) and open(q, id) and E.Applies(s, i) then
						covered[q] = true
						want(id, q, tonumber(goal.count) or objectiveCount(q, id) or 1, goal)
					end
				end
			end
		end
	end
	if scope == "all" then
		for _, q in ipairs(Cp.GetLogQuests()) do
			local r = not covered[q] and Q.QuestRecord(q)
			local obj = r and r[Q.F.OBJ]
			if type(obj) == "table" then
				for k = 1, #obj, 3 do
					local id = obj[k + 1]
					if obj[k] == 2 and type(id) == "number" and open(q, id) then want(id, q, obj[k + 2] or 1, nil) end
				end
			end
		end
	end
	for _, id in ipairs(order) do
		local w = wants[id]
		local count = 0
		for _, qe in ipairs(w.qorder) do count = count + w.quests[qe.id] end
		-- Core/Materials.lua's count (bags, bank, mail, what is on its way) where it runs.
		local M = ns.Materials
		local have = M and M.Have and tonumber((M.Have(id))) or Cp.GetItemCount(id, true) or 0
		if have < count then
			local why, kills, skill
			local tries = #w.goals > 0 and w.goals or { false }
			for _, goal in ipairs(tries) do
				local v, k, sk = AB.Judge(id, count, goal or nil, buys)
				if v == nil then
					pending = true
				elseif v then
					why, kills, skill = v, k, sk
					break
				end
			end
			if why then
				out[#out + 1] = { item = id, name = itemName(id, w, itemRecord(id)), need = count - have, have = have, count = count,
					quests = w.qorder, why = why, kills = kills, skill = skill }
			end
		end
	end
	return out, pending
end

function AB.List(scope)
	scope = scope == "guide" and "guide" or "all"
	local hit = cache[scope]
	if not hit then
		local list, pending = build(scope)
		hit = { list = list, pending = pending }
		cache[scope] = hit
	end
	return hit.list, hit.pending
end

---------------------------------------------------------------------------
-- Keeping the lists current
---------------------------------------------------------------------------

-- Anything a list reads changed: the lists are built again when next asked,
-- and AUCTION_BUYS_CHANGED says so once the burst of events is over.
local announcing = false
local function changed()
	cache = {}
	if announcing then return end
	announcing = true
	ns.After(0.2, function()
		announcing = false
		ns.Fire("AUCTION_BUYS_CHANGED")
	end)
end
AB.Changed = changed

for _, msg in ipairs({ "STEP_CHANGED", "GUIDE_CHANGED", "QUESTDB_STARTED", "CODEX_LOADED", "NAMES_LOADED", "MATERIALS_COUNTS" }) do ns.On(msg, changed) end
for _, event in ipairs({ "BAG_UPDATE_DELAYED", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "SKILL_LINES_CHANGED" }) do
	ns.RegisterEvent(event, changed)
end
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function(_, id)
	if id and waiting[id] then
		waiting[id] = nil
		changed()
	end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if codexWanted then
		codexWanted = false
		changed()
	end
end)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "qol" or path == "qol.auctionBuys" then changed() end
end)
