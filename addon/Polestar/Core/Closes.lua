-- Quests that taking another one closes for good: a breadcrumb once the quest
-- it leads to is taken, the rest of an exclusive group once one is taken.
-- Contract: docs/ARCHITECTURE.md, "Engine" (Missable quests).
--
-- Setting behavior.warnClosing (off by default): when a quest giver offers
-- such a quest, a chat line names what it closes, and Automation leaves its
-- accept to the player.
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

-- Closing quest id -> { { goal, only, guide }, ... }: the guide accepts it
-- closes, with the guide each comes from (its faction, race and class decide
-- whether the character can ever take it) and its step's `only`. A guide
-- with deferred steps (a side shelf: Guides.Peek) is read in for the index
-- and given back: its entries keep copies of the goal fields read here, and
-- only a guide this character can take is read.
local index

local KEPT = { "quest", "title", "only", "closedBy", "preTitles" }

local function guideIndex()
	if index then return index end
	index = {}
	local Guides = ns.Guides
	local player = ns.Compat.GetPlayerInfo()
	for _, h in ipairs(Guides.List()) do
		local g = Guides.Get(h.id)
		local deferred = Guides.Deferred(g)
		local steps, fresh = nil, false
		if g and not (deferred and not Guides.GuideMatches(g, player)) then steps, fresh = Guides.Peek(h.id) end
		for _, step in ipairs(steps or {}) do
			for _, goal in ipairs(step.goals) do
				if goal.t == "accept" and type(goal.closedBy) == "table" then
					local kept = goal
					if deferred then
						kept = {}
						for _, k in ipairs(KEPT) do kept[k] = goal[k] end
					end
					for _, by in ipairs(goal.closedBy) do
						local list = index[by]
						if not list then
							list = {}
							index[by] = list
						end
						list[#list + 1] = { goal = kept, only = step.only, guide = g }
					end
				end
			end
		end
		Guides.Unpeek(h.id, fresh)
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

-- { { id, title }, ... }: what taking quest q closes for good for this
-- character, in guide order, then the database's; nil when nothing. `title`
-- is q's own title when the caller has it (the quest window's).
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
	local function add(id, name)
		if seen[id] then return end
		seen[id] = true
		if name and name == title then return end
		if taken(C, id) then return end
		out[#out + 1] = { id = id, title = name or ("#" .. id) }
	end

	for _, e in ipairs(list or {}) do
		local goal = e.goal
		if Guides.GuideMatches(e.guide, player) and Guides.Matches(e.only, player) and Guides.Matches(goal.only, player)
			and not anyTaken(C, goal.closedBy, q) then
			add(goal.quest, goal.title)
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

-- The quest the quest window offers, and its title as shown.
local function offered()
	local readable = ns.Compat.Readable
	local q = readable(GetQuestID and GetQuestID())
	local title = readable(GetTitleText and GetTitleText())
	return q, type(title) == "string" and title ~= "" and title or nil
end

-- Whether a choice is still open: the setting is on and the game has not
-- taken the offered quest itself (that one is only acknowledged).
local function choosing()
	return ns.Get("behavior.warnClosing") and not (QuestGetAutoAccept and QuestGetAutoAccept())
end

-- Whether the setting leaves the offered quest's accept to the player.
function Closes.HoldsOffer()
	return choosing() and Closes.For(offered()) ~= nil or false
end

ns.RegisterEvent("QUEST_DETAIL", function()
	if not choosing() then return end
	local q, shown = offered()
	local list, title = Closes.For(q, shown)
	if not list then return end
	local names = {}
	for i, c in ipairs(list) do names[i] = ns.Quoted(c.title) end
	ns.Print(L["Taking %s closes %s for good."]:format(ns.Quoted(title) or ("#" .. q), table.concat(names, ", ")))
end)
