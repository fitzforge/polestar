-- Quests that taking another one closes for good: a breadcrumb once the quest
-- it leads to is taken, the rest of an exclusive group once one is taken.
-- Contract: docs/ARCHITECTURE.md, "Engine" (Missable quests).
--
-- Setting behavior.warnClosing (off by default): when a quest giver offers
-- such a quest, a chat line names what it closes, with each one's giver, how
-- far away it is and its XP, and says what to do (decline to keep it, or
-- click Accept to skip it); Automation leaves the accept to the player.
-- Nothing is said, and the accept is not held, for a closed quest with
-- nothing to miss (Closes.Missed): one turned in at the NPC offering the
-- quest (a breadcrumb to where the player stands), or one worth no XP. The
-- guide's accept carries what that needs, from the compiler: the quest's
-- `endNpcs` and `xp`, beside its giver's name and point.
--
-- Sources: `closedBy` on the accepts of every shown guide (breadcrumbs and
-- exclusive groups, from the compiler), and the quest database's `excl` when
-- it is loaded, for quests no guide takes. Left out: quests the character has
-- done, has in the log or can never take (the guide's faction, race and
-- class, the accept's `only`, the database's faction, race and class), quests
-- something else already closed, and other
-- versions of the offered quest (the same title).

local ADDON, ns = ...

local L = ns.L

local Closes = {}
ns.Closes = Closes

-- Closing quest id -> { { goal, step, guide }, ... }: the guide accepts it
-- closes, with the guide each comes from (its faction, race and class decide
-- whether the character can ever take it).
local index

local function guideIndex()
	if index then return index end
	index = {}
	local Guides = ns.Guides
	for _, h in ipairs(Guides.List()) do
		local g = Guides.Get(h.id)
		for _, step in ipairs(g and g.steps or {}) do
			for _, goal in ipairs(step.goals) do
				if goal.t == "accept" and type(goal.closedBy) == "table" then
					for _, by in ipairs(goal.closedBy) do
						local list = index[by]
						if not list then
							list = {}
							index[by] = list
						end
						list[#list + 1] = { goal = goal, step = step, guide = g }
					end
				end
			end
		end
	end
	return index
end

ns.On("GUIDES_REGISTERED", function() index = nil end)
ns.On("PACKS_CHANGED", function() index = nil end)

local function taken(C, q)
	return C.IsOnQuest(q) or C.IsQuestCompleted(q)
end

local function anyTaken(C, ids, except)
	for _, q in ipairs(ids) do
		if q ~= except and taken(C, q) then return true end
	end
	return false
end

-- { { id, title, goal | db }, ... }: what taking quest q closes for good for
-- this character, in guide order (goal: the guide's accept of it), then the
-- database's (db = true); nil when nothing. `title` is q's own title when the
-- caller has it (the quest window's).
function Closes.For(q, title)
	if type(q) ~= "number" or q <= 0 then return nil end
	local C, Guides = ns.Compat, ns.Guides
	local player = C.GetPlayerInfo()
	local Q = ns.QuestDB
	local db = Q and Q.IsLoaded()
	local list = guideIndex()[q]
	local excl = db and Q.ClosedBy(q)
	if not (list or excl) then return nil end
	if not title and list then
		local pre = list[1].goal.preTitles
		title = pre and pre[q]
	end
	local r = db and Q.QuestRecord(q)
	title = title or (r and r[Q.F.TITLE])

	local out, seen = {}, { [q] = true }
	local function add(id, name, goal)
		if seen[id] then return end
		seen[id] = true
		if name and name == title then return end
		if taken(C, id) then return end
		out[#out + 1] = { id = id, title = name or ("#" .. id), goal = goal, db = not goal or nil }
	end

	for _, e in ipairs(list or {}) do
		local goal = e.goal
		if Guides.GuideMatches(e.guide, player) and Guides.Matches(e.step.only, player) and Guides.Matches(goal.only, player)
			and not anyTaken(C, goal.closedBy, q) then
			add(goal.quest, goal.title, goal)
		end
	end

	if excl then
		local ctx = Q.PlayerContext(player)
		for _, x in ipairs(excl) do
			local rx = Q.QuestRecord(x)
			if rx and Q.IsEligible(rx, ctx) then
				local closed = false
				for _, y in Q.Each(rx[Q.F.EXCL]) do
					if y ~= q and taken(C, y) then
						closed = true
						break
					end
				end
				if not closed then add(x, rx[Q.F.TITLE]) end
			end
		end
	end

	return #out > 0 and out or nil, title
end

-- Whether closed quest c leaves nothing to miss for a player at NPC npc: it
-- is turned in right there (a breadcrumb to the NPC offering the quest), or
-- it gives no XP.
local function trivial(c, npc)
	local goal = c.goal
	local ends = goal and goal.endNpcs
	if not ends and c.db then
		local Q = ns.QuestDB
		local r = Q and Q.GetQuest(c.id)
		ends = r and r.finish.npc
	end
	if npc and ends then
		for _, e in ipairs(ends) do
			if e == npc then return true end
		end
	end
	return goal ~= nil and goal.xp == 0
end

-- What taking quest q from NPC npc closes that the player would miss:
-- Closes.For's list without the quests with nothing to miss. -> list | nil, title
function Closes.Missed(q, title, npc)
	local list
	list, title = Closes.For(q, title)
	if not list then return nil, title end
	local out = {}
	for _, c in ipairs(list) do
		if not trivial(c, npc) then out[#out + 1] = c end
	end
	return #out > 0 and out or nil, title
end

-- The quest the quest window offers, its title as shown, and the NPC offering it.
local function offered()
	local C = ns.Compat
	local readable = C.Readable
	local q = readable(GetQuestID and GetQuestID())
	local title = readable(GetTitleText and GetTitleText())
	return q, type(title) == "string" and title ~= "" and title or nil, C.GetNpcID and C.GetNpcID("npc")
end

-- Whether a choice is still open: the setting is on and the game has not
-- taken the offered quest itself (that one is only acknowledged).
local function choosing()
	return ns.Get("behavior.warnClosing") and not (QuestGetAutoAccept and QuestGetAutoAccept())
end

-- Whether the setting leaves the offered quest's accept to the player.
function Closes.HoldsOffer()
	return choosing() and Closes.Missed(offered()) ~= nil or false
end

-- A closed quest as the chat line names it: “Daily Delivery” (from Einar
-- Stonegrip, 350 yd away, 830 XP), with what the guide's accept of it tells:
-- its giver, the walk to its giver's point (here: the player's world
-- position, on that continent) and its XP at the player's level.
local function named(c, here, level)
	local goal, parts = c.goal, {}
	if goal and goal.npcName then parts[#parts + 1] = L["from %s"]:format(goal.npcName) end
	if goal and here[1] then
		local cont, wy, wx = ns.Compat.MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if cont and cont == here[1] then
			local dy, dx = wy - here[2], wx - here[3]
			parts[#parts + 1] = L["%s away"]:format(ns.FormatDistance(math.sqrt(dx * dx + dy * dy), { round = 10, compact = true }))
		end
	end
	local xp = goal and goal.xp
	if type(xp) == "number" and xp > 0 then
		xp = math.floor(xp * ns.Levels.Share(level, tonumber(goal.qlvl) or level) + 0.5)
		parts[#parts + 1] = L["%s XP"]:format(xp)
	end
	if #parts == 0 then return ns.Quoted(c.title) end
	return L["%s (%s)"]:format(ns.Quoted(c.title), table.concat(parts, ", "))
end

ns.RegisterEvent("QUEST_DETAIL", function()
	if not choosing() then return end
	local q, shown, npc = offered()
	local list, title = Closes.Missed(q, shown, npc)
	if not list then return end
	local C = ns.Compat
	local here = { C.GetPlayerWorldPosition() }
	local level = C.GetPlayerInfo().level
	local names = {}
	for i, c in ipairs(list) do names[i] = named(c, here, level) end
	local text = #list == 1 and L["Taking %s closes %s for good. Decline to keep it, or click Accept to skip it."]
		or L["Taking %s closes %s for good. Decline to keep them, or click Accept to skip them."]
	ns.Print(text:format(ns.Quoted(title) or ("#" .. q), table.concat(names, ", ")))
end)
