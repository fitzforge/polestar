-- The guide engine: which step is current, what each goal's status is, and
-- where the waypoint points. Contract: docs/ARCHITECTURE.md, "Engine".
--
-- Progress is always recomputed from live client state (quest log, completed
-- flags, bags, level, zone, bind location); SavedVariables only add the
-- chosen guide, check-offs, skipped steps and goals, the step the player is
-- looking at, quests their giver did not offer and discovered flight paths,
-- so losing them after a cold restart costs preferences, never the position
-- in the guide. Check-offs are the player's ticks (any goal) plus results the
-- Engine stores itself: NPC interactions (talk/train/vendor) during their
-- step, and transient conditions (goto, sethome, hearth, fly, getfp, buy,
-- bag-count collect) once the route moves past their step, so the guide never
-- jumps back to them.
--
-- Current step = the first applicable, not skipped, not done step (the live
-- step), unless the player looks at another one with Prev/Next/Goto: that
-- "pin" changes nothing (only Skip skips a step), is saved, follows forward
-- as pinned steps get done, and is released once it reaches the live step.
-- When a tab loads a guide (login, reload, a new tab, reset) the quest log
-- places it (place): at the first step with quest work the player has started
-- or can do now, passing what holds them before it; the player's skips and
-- ticks always stand.

local ADDON, ns = ...

local type, ipairs, tostring, pairs = type, ipairs, tostring, pairs
local L = ns.L
local Guides = ns.Guides

ns.RegisterDefaults("behavior", {
	autoAccept = true,
	autoTurnin = true,
	guideEnd = "ask", -- "ask" | "continue": at the end of a leveling guide the guide-end window asks (UI/GuideEnd.lua), or the next guide loads by itself; other guides always go on (Own.endAsks)
	autoSelectGuide = true,
	skipGrey = false,
	deathskips = false, -- `die` goals (deathskips) apply; never on a Hardcore character (Own.deathskips)
	warnClosing = false, -- name what an offered quest closes for good, and leave its accept to the player (Closes.lua)
	closeSkipped = true, -- close the quest window the game opens after an auto accept/turn-in when it shows only quests the guide skips (Automation.lua)
	spokenDelay = true, -- with Spoken Quests installed: wait before each automatic quest action, so it reads the window (Automation.Delay)
	routeChoice = "ask", -- "ask" | "recommended": what happens where a guide offers several next zones
	trainReminder = "2", -- "2" | "1" | "off": remind to visit the class trainer every 2 levels, every level, never
	offerClassQuests = true, -- offer a Class guide in a tab when it opens for the character (QoL/ClassQuests.lua)
	groupQuests = "ask", -- "ask" | "do" | "skip": the answer at a group quest (`when group`) the player has not answered (Own.groupAnswer)
	lostQuests = "ask", -- "ask" | "back" | "skip": a quest the route had passed that leaves the log (abandoned, failed): the window asks, or the guide goes back for it or skips it at once (Own.holdLost)
	suggestFrom = "guides", -- pack id the suggestions come from (Guides.SuggestSource); ours fill in
	whileHere = true, -- "While you're here": a quick objective of a later step close by, as one line under the step (Own.hereBuild)
	whileHereRadius = 180, -- yards from its spawn area's edge at which it shows (60-400); it goes past 100/60 of that, at most Own.HERE_CLEAR_MAX
	whileHereTurnins = true, -- also a quest ready to hand in whose NPC is little out of the way (Own.hereDetour)
	whileHereTurninSeconds = 20, -- seconds of extra walking a hand-in may cost (0-60); an NPC in the town the player rests in counts whatever it costs
	whileHereSound = true, -- a soft chime for each line that appears, at least 5 s apart (UI/WhileHere.lua)
	whileHereStepKey = true, -- the step key also targets the lines' mobs, after the step's own (QoL/Buttons.lua, Buttons.HereNames)
})

-- behavior.autoNextGuide (a toggle, on by default) became behavior.guideEnd
-- in 0.3.1: a stored value was only ever `false`, and both old values start
-- on the new default, "ask".
ns.OnInit(function()
	local b = ns.DB().settings.behavior
	if type(b) == "table" then b.autoNextGuide = nil end
end)

local outleveled = {} -- guideId -> true, GUIDE_OUTLEVELED once per session

local Engine = {}
ns.Engine = Engine

-- The player's own word: goal skips, the current goal, header arrival, the
-- saved view, state carried over pack updates. One table (Lua 5.1 caps a
-- chunk at 200 locals), which also holds the Engine's other private helpers.
local Own = {}

local DEFAULT_RADIUS = 8 -- yards
local MIN_INTERVAL = 0.1 -- seconds between event-driven evaluations
local ARRIVAL_POLL = 0.5 -- seconds between goto arrival checks

-- Step state of the loaded tab (see "Tabs" below); at rest, the active tab.
local guide -- the tab's guide table or nil
local current -- current step index (pin or computed), nil when none
local computed -- first open step by live state, nil when the guide is complete
local pin, pinDone -- Prev/Next/Goto view of another step than the live one, and its done state
local aim -- the goal the player chose for the arrow in the current step (session), or nil
local passedUpTo = 0 -- steps 1..passedUpTo had their transient goals latched
local autoChain, sawIncomplete -- may chain to `next` on completion
local lastSig -- goal status signature of the current step
-- The tab's guide was just loaded: the quest log places it (place), until the
-- first evaluation once the log is readable, PLACE_SECONDS after the load
-- (GetTime() deadline), or the player's first navigation, whichever is first.
local placing
local PLACE_SECONDS = 10

local completedFired = {} -- guideId -> true, GUIDE_COMPLETED once per session
local waypoint -- last announced waypoint (active tab only)
local player -- Compat.GetPlayerInfo() of the last evaluation
local levelSeen = 0 -- PLAYER_LEVEL_UP payload; UnitLevel can lag the event
local turnedIn = {} -- QUEST_TURNED_IN this session; the completed flag can lag
local openNpc, openKind -- NPC and kind ("talk"/"train"/"vendor") of the open NPC frame
local generation = 0 -- evaluations (and active-tab announcements) so far
local logReady = false -- QUEST_LOG_UPDATE seen this session: the quest log can be read

-- goto goals the player reached this session (goal table -> true).
local arrived = setmetatable({}, { __mode = "k" })

local function Compat() return ns.Compat end

---------------------------------------------------------------------------
-- Live state helpers
---------------------------------------------------------------------------

local function refreshPlayer()
	player = Compat().GetPlayerInfo()
	-- The client's XP is still the old level's until UnitLevel catches up.
	if levelSeen > (player.level or 0) then player.level, player.xp = levelSeen, 0 end
end

-- A step is for this character (`only`) and, with `when`, its predicates
-- hold (Own.whenHolds: as stored once the route passed the step, else live).
-- A step an update added behind the player is not (Own.passAdded).
local function stepApplies(step)
	if Own.gone(step) then return false end
	return Guides.Matches(step.only, player) and (step.when == nil or Own.whenHolds(step))
end

local function questDone(q)
	return turnedIn[q] or Compat().IsQuestCompleted(q)
end

-- First blocking prerequisite of an `accept` the character still lacks, or
-- nil. The compiler drops breadcrumbs: every `preAll` must be done, and one
-- of `pre` when it lists any.
local function missingPre(goal)
	if type(goal.preAll) == "table" then
		for _, q in ipairs(goal.preAll) do
			if not questDone(q) then return q end
		end
	end
	if type(goal.pre) == "table" and #goal.pre > 0 then
		for _, q in ipairs(goal.pre) do
			if questDone(q) then return nil end
		end
		return goal.pre[1]
	end
	return nil
end

-- Every accept of a guide and of the guides after it (`next`, every route
-- choice), and each quest's prerequisite lists: { accepts, pres }. Cached
-- per guide. A `next` option whose `when` can no longer hold
-- (Own.optionClosed) is left out; one that may still hold at the hand-off
-- stays, and the cache is built again once it is closed.
local chainNeedsCache = setmetatable({}, { __mode = "k" })
function Own.chainOf(g)
	local c = chainNeedsCache[g]
	if c and c.chain then
		local stale = false
		for _, o in ipairs(c.open) do
			if Own.optionClosed(o.from, o.id) then
				stale = true
				break
			end
		end
		if not stale then return c.chain end
		c = nil
	end
	if not c then
		c = {}
		chainNeedsCache[g] = c
	end
	local open = {}
	local pres, accepts = {}, {}
	local seenIds, queue, head = {}, { g }, 1
	while queue[head] and head <= 200 do
		local cur = queue[head]
		head = head + 1
		if not seenIds[cur.id] then
			seenIds[cur.id] = true
			for _, step in ipairs(cur.steps) do
				for _, goal in ipairs(step.goals) do
					if goal.t == "accept" and goal.quest then
						local list = pres[goal.quest]
						if not list then
							list = {}
							pres[goal.quest] = list
						end
						-- Named, not walked: a list of key names here was a table
						-- per accept of every guide down the chain (#60).
						if type(goal.pre) == "table" then list[#list + 1] = goal.pre end
						if type(goal.preAll) == "table" then list[#list + 1] = goal.preAll end
						accepts[#accepts + 1] = goal
					end
				end
			end
			for _, id in ipairs(cur.nextChoices or { cur.next }) do
				if not Own.optionClosed(cur, id) then
					if cur.nextWhen and cur.nextWhen[id] then open[#open + 1] = { from = cur, id = id } end
					local nxt = Guides.Get(id)
					if nxt then queue[#queue + 1] = nxt end
				end
			end
		end
	end
	c.chain, c.open = { accepts = accepts, pres = pres }, open
	return c.chain
end

-- The quests the accepts in `open` need, down their prerequisites, each
-- mapped to the accept of `open` it leads to. Breadth first from every open
-- accept at once: a quest's nearest open accept is the one that reached it
-- first.
function Own.needsFrom(pres, open)
	local set = {}
	local by, queue, head = {}, {}, 1
	for _, goal in ipairs(open) do
		if not by[goal.quest] then
			by[goal.quest] = goal
			queue[#queue + 1] = goal.quest
		end
	end
	while queue[head] do
		local q = queue[head]
		head = head + 1
		for _, list in ipairs(pres[q] or {}) do
			for _, p in ipairs(list) do
				if not set[p] then set[p] = by[q] end
				if not by[p] then
					by[p] = by[q]
					queue[#queue + 1] = p
				end
			end
		end
	end
	return set
end

-- Quests a guide or any guide after it (via `next` and every route choice)
-- still needs at a character level: the prerequisites (`pre`, `preAll`) of
-- every accept that is not grey at that level, and of every accept a needed
-- quest's own accept is, down the chain (a grey Buzzbox 827 opens the Buzzbox
-- quests that still give full experience). A quest's own turn-in and
-- objectives are not a need: they go with its accept. Each needed quest maps
-- to the accept that is not grey it leads to, the nearest down the chain
-- (the first in guide order among equals). Cached per guide and level.
local function chainNeeds(g, level)
	local chain = Own.chainOf(g)
	local c = chainNeedsCache[g]
	local set = c[level]
	if set then return set end
	local C = Compat()
	-- The accepts that are not grey, needed as they are.
	local open = {}
	for _, goal in ipairs(chain.accepts) do
		if not (goal.qlvl and C.IsQuestTrivial(tonumber(goal.qlvl), level)) then open[#open + 1] = goal end
	end
	set = Own.needsFrom(chain.pres, open)
	c[level] = set
	return set
end

-- Whether every step of guide g is to be done, grey quests and quests behind
-- the player's progress included: any guide but a leveling one (an item, a
-- mount, a reputation, a profession, a class quest).
function Own.everyStep(g)
	return g ~= nil and not (g.category == nil or g.category == "Leveling")
end

-- behavior.skipGrey: an accept for a quest already grey for the character
-- (or a `turnin ... direct`, handed in with no accept, the compiler giving it
-- its quest's level too), not taken yet and not a prerequisite of a quest
-- later in the guide or its chain, no longer applies (status "na", never
-- blocks, never auto-accepted);
-- its turn-in and objectives go with it (orphaned). greyNeed gives false for
-- such an accept; for a grey accept that is not taken yet but kept, the open
-- accept it leads to; nil when the setting is off or the accept is not grey
-- and open.
local function greyNeed(goal)
	if not (goal.t == "accept" or goal.direct) or not goal.qlvl or not ns.Get("behavior.skipGrey") or Own.everyStep(guide) then return nil end
	local C = Compat()
	local level = player.level or 1
	if not C.IsQuestTrivial(tonumber(goal.qlvl), level) then return nil end
	local q = goal.quest
	if C.IsOnQuest(q) or questDone(q) then return nil end
	return chainNeeds(guide, level)[q] or false
end

-- Per guide: each goal's step index, each quest's accept, turn-in and
-- abandon goals ({ s, key = "s:g", step, goal }), and `starters`: a plain
-- `collect` of an item (no quest) -> the accept after it in its step that
-- the item starts (`accept <q> item <item>`, no giver: Ursangous's Paw
-- before The Hunt Continues), as Own.starterTaken pairs them.
local NONE = {}
local layoutCache = setmetatable({}, { __mode = "k" })
local function layoutOf(g)
	local l = layoutCache[g]
	if l then return l end
	l = { stepOf = {}, accepts = {}, turnins = {}, abandons = {}, starters = {} }
	for s, step in ipairs(g.steps) do
		for gi, goal in ipairs(step.goals) do
			l.stepOf[goal] = s
			local by = goal.quest and (goal.t == "accept" and l.accepts or goal.t == "turnin" and l.turnins or goal.t == "abandon" and l.abandons)
			if by then
				local list = by[goal.quest]
				if not list then
					list = {}
					by[goal.quest] = list
				end
				list[#list + 1] = { s = s, key = s .. ":" .. gi, step = step, goal = goal }
			end
			if goal.t == "collect" and not goal.quest and goal.item and (goal.count or 1) == 1 then
				for j = gi + 1, #step.goals do
					local a = step.goals[j]
					if a.item == goal.item then
						if a.t == "accept" and a.quest and not a.npc and not a.object then l.starters[goal] = a end
						break
					end
				end
			end
		end
	end
	layoutCache[g] = l
	return l
end

-- A turn-in, complete or objective goal for a quest the character neither
-- has nor has done, and that this guide does not (for this character) accept
-- at or before that step, in a step the player has not skipped, with an
-- accept that is not optional nor left out as grey: it was picked up on
-- another route, or skipped, so it cannot be done here and no longer applies.
-- An accept the player ticked by hand still counts as the guide's accept: a
-- tick never says the quest is in the log (#739), so its lines stay and the
-- accept reopens (goalDone). An `optional` accept the player did not take is
-- the same: its turn-in holds only those who took the quest.
-- Taking the quest brings the goals back.
-- A `turnin ... direct` has no accept by definition: it is handed in from the
-- giver's own window, so it is never orphaned. Nor is an `abandon`: a quest
-- the character does not have is already off the log, so it is done, and
-- taking the quest later must not bring the step back.
local function orphaned(goal)
	local q = goal.quest
	if not q or goal.t == "accept" or goal.t == "abandon" or goal.direct or not guide then return false end
	local C = Compat()
	if C.IsOnQuest(q) or questDone(q) then return false end
	local l = layoutOf(guide)
	local s = l.stepOf[goal]
	if not s then return false end
	local skipped = ns.CharState().skipped[guide.id]
	for _, a in ipairs(l.accepts[q] or NONE) do
		if a.s <= s and not a.goal.optional and not (skipped and skipped[a.s])
			and stepApplies(a.step) and Guides.Matches(a.goal.only, player) and not Own.barred(a.goal) and greyNeed(a.goal) ~= false then
			return false
		end
	end
	return true
end

-- A goal of a quest only characters with a profession can take (`profLine`,
-- `profName`, `profRank`: the quest's required skill) is not this
-- character's without the profession or below that rank, like another
-- class's goals; learning it brings them back (SKILL_LINES_CHANGED). A quest
-- in the log or done keeps its goals, and a client that cannot read skills
-- shows them. A `die` goal (a deathskip) is only for players who chose
-- deathskips (Own.deathskips): without it, its step passes and the next
-- step's travel takes the player there. In another race's starting zone, a
-- quest the character can never take is not theirs either (Own.barred).
-- (Inline: the main chunk is at Lua's 200 locals.)
local function goalApplies(goal)
	if not Guides.Matches(goal.only, player) or Own.barred(goal) or Own.gone(goal) then return false end
	-- The item a quest starts from is collected only for that quest (#1531).
	local starts = goal.t == "collect" and not goal.quest and guide and layoutOf(guide).starters[goal]
	if starts and not goalApplies(starts) then return false end
	if goal.t == "die" and not Own.deathskips() then return false end
	if goal.profLine or goal.profName then
		local C = Compat()
		local q = goal.quest
		if C.GetSkillRank and C.Supports("skill") and not (q and (C.IsOnQuest(q) or questDone(q))) then
			local rank = goal.profLine and C.GetSkillRank(goal.profLine)
			if not rank and goal.profName then rank = C.GetSkillRank(goal.profName) end
			if (rank or 0) < (goal.profRank or 1) then return false end
		end
	end
	local out = goal.quest and guide and Own.leftOut[guide.id]
	local why = out and out[goal.quest]
	if why and not questDone(goal.quest) then
		-- "log": a quest in the log, left out until it is ready to hand in;
		-- true: one not taken, left out until the player takes it.
		local C, q = Compat(), goal.quest
		if why == "log" and not C.IsQuestReadyForTurnIn(q) or why ~= "log" and not C.IsOnQuest(q) then return false end
	end
	return greyNeed(goal) ~= false and not orphaned(goal)
end

-- The catch-up's quests left out, per guide (guideId -> { [questID] = true |
-- "log" }), for the session; placement works them out again (Own.catchUp).
-- Taken by hand, a quest is back; one in the log ("log") is back once done.
Own.leftOut = {}
-- Guides placement passed whole (guideId -> true), for the session: the
-- guide list checks such a guide only once every quest of it is done
-- (Engine.GetGuideState). placedThrough: the ones opened for the player
-- (autoChain), which chain to `next` like a finished guide; placedChain: the
-- guides passed on the way to the one placed, for GUIDE_PLACED.
Own.passedWhole, Own.placedThrough, Own.placedChain = {}, {}, {}
-- Goals a guide passed for the player passes for the session only (guideId
-- -> { ["s:g"] = true }): a flight path, a hearth or training in a guide the
-- character is past and may never have been in is no check-off to store.
Own.passedNow = {}
-- Quests that left the log this session (QUEST_REMOVED), until taken again:
-- only these are held when the live step would go back (Own.holdLost), so
-- bringing back a step the player skipped asks nothing.
Own.removed = {}
-- When each `wait` goal's countdown began (goal -> GetTime()), for the
-- session: once the goals before it in its step are done (Own.startWaits).
Own.waitStart = setmetatable({}, { __mode = "k" })
-- Guides just opened in a tab, until placed (guideId -> true): by the player
-- or for them, not brought back by a login or reload. Only these chain on
-- when passed whole (with autoChain) and announce GUIDE_PLACED.
Own.opened = {}
-- The guides a catch-up passed whole on its current run (guideId -> true),
-- so a loop of `next` stops it.
Own.chainSeen = {}

-- Quests found unavailable at their giver this session (questID ->
-- { reason, accept }): the giver's window opened without offering them. Such a
-- quest's goals count as skipped until it is taken or done, or its giver
-- offers it. A level-up or a turn-in can unlock it, so they clear the marks
-- (Own.clearMarks), except the giver's refusals ("offer") of accepts the route
-- has moved past: the guide never goes back to a giver who said no for no
-- reason the data knows; seeing that giver again checks afresh.
local unavailable = {}
-- Quests a giver's window offered this session (questID -> true): the
-- giver's word beats a prerequisite the data names (Own.preBlocked).
Own.offered = {}
-- The "pre" mark of each accept whose prerequisite is known to be missing,
-- one table per accept goal.
Own.preMarks = setmetatable({}, { __mode = "k" })
-- The "level" mark of each accept the character is too low to take, one
-- table per accept goal.
Own.levelMarks = setmetatable({}, { __mode = "k" })

-- Quests the player skipped (Engine.SkipQuest): saved per character by quest
-- id (CharState().skippedQuests), so in every guide. Until the quest is
-- done, each of its goals (accept, objectives, turn-in) reads as skipped,
-- "You skipped this quest", even with the quest in the log; its follow-ups
-- go with it, their prerequisite no longer coming (Own.preBlocked).
function Own.questSkipped(q)
	local list = ns.CharState().skippedQuests
	return type(list) == "table" and list[q] == true
end

Own.skipMarks = {}
function Own.skipMark(goal)
	local q = goal.quest
	local m = Own.skipMarks[q]
	if not m then
		m = { reason = "skipped" }
		Own.skipMarks[q] = m
	end
	-- The accept the text and the undo go by: this one, else this guide's.
	local a = goal.t == "accept" and goal or nil
	if not a and guide then
		local list = layoutOf(guide).accepts[q]
		a = list and list[1] and list[1].goal or nil
	end
	m.accept = a or m.accept or goal
	return m
end

-- Per quest, a goal's unavailable mark or nil. First, a quest the player
-- skipped (Own.questSkipped) reads as "skipped" until it is done, even in the
-- log. Known in advance when an accept of the quest in this guide is closed
-- for good (reason "closed"): one of its `closedBy` (the quest a breadcrumb
-- leads to, or one exclusive with it) is in the log or done, so the giver
-- never offers it again. Else the mark its giver's window left this session.
-- Else, also known in advance, "level": the accept's `minLevel` is above the
-- character's level (the route passes it, "Requires level N", and comes back
-- to it on the level-up; its objectives and turn-in wait with it). Else
-- "pre": the accept lacks a prerequisite the route no longer brings
-- (Own.preBlocked), a mark that goes the moment that prerequisite is done.
-- `depth`: how far Own.coming has followed a chain of prerequisites.
local function unavailableFor(goal, depth)
	local q = goal.quest
	if not q then
		-- A quest's starting item waits with the quest (#1531: Ursangous's Paw
		-- for The Hunt Continues, which needs The Hunt Begins first).
		local a = goal.t == "collect" and guide and layoutOf(guide).starters[goal]
		if a and not questDone(a.quest) and not Compat().IsOnQuest(a.quest) then return unavailableFor(a, depth) end
		return nil
	end
	if Own.questSkipped(q) and not questDone(q) then return Own.skipMark(goal) end
	local C = Compat()
	if C.IsOnQuest(q) or questDone(q) then return nil end
	local own = goal.t == "accept"
	local list = not own and guide and layoutOf(guide).accepts[q] or NONE
	for i = 1, own and 1 or #list do
		local a = own and goal or list[i].goal
		if type(a.closedBy) == "table" then
			for _, by in ipairs(a.closedBy) do
				if C.IsOnQuest(by) or questDone(by) then
					local u = unavailable[q]
					if not (u and u.reason == "closed" and u.accept == a and u.by == by) then
						u = { reason = "closed", accept = a, by = by }
						unavailable[q] = u
					end
					return u
				end
			end
		end
	end
	local u = unavailable[q]
	if u and u.reason == "closed" then
		-- Its closing quest was abandoned since (or it is another tab's mark).
		unavailable[q] = nil
		u = nil
	end
	if u or Own.offered[q] then return u end
	local level = player and player.level
	for i = 1, level and (own and 1 or #list) or 0 do
		local a = own and goal or list[i].goal
		local lvl = tonumber(a.minLevel)
		if lvl and level < lvl then
			local m = Own.levelMarks[a]
			if not m then
				m = { reason = "level", accept = a }
				Own.levelMarks[a] = m
			end
			return m
		end
	end
	-- A chain followed this deep (or looping in the data) proves nothing.
	if (depth or 0) > 8 then return nil end
	for i = 1, own and 1 or #list do
		local a = own and goal or list[i].goal
		local pre = (a.pre or a.preAll) and Own.preBlocked(a, depth)
		if pre then
			local m = Own.preMarks[a]
			if not m then
				m = { reason = "pre", accept = a }
				Own.preMarks[a] = m
			end
			m.pre = pre
			return m
		end
	end
	return nil
end

local function same(a, b)
	return a ~= nil and b ~= nil and a:lower() == b:lower()
end

-- Conditions checked during play (`when` on a step, format 4;
-- docs/GUIDE_FORMAT.md, "Conditions checked during play"). Each predicate
-- holds or not on the live state; a step applies while all of its hold. Once
-- the route moves past a step (latchPassed) with the quest log readable,
-- the outcome is stored (Own.latchWhen): a step whose `when` held in
-- CharState().when[guideId][step], one whose `when` failed as skipped, so
-- it never comes back when the condition changes later (money spent, an
-- item used up, a zone left), a step that applied stays applied, and the
-- player can still Unskip a step stored off by mistake.

-- Quest `p.q` can be taken now: not in the log or done, the level reached,
-- its prerequisites done (missingPre, as an accept's) and none of the quests
-- that close it taken or done.
function Own.availableNow(p)
	local C, q = Compat(), p.q
	if C.IsOnQuest(q) or questDone(q) then return false end
	if p.minLevel and (player.level or 1) < p.minLevel then return false end
	if missingPre(p) then return false end
	for _, by in ipairs(type(p.closedBy) == "table" and p.closedBy or NONE) do
		if C.IsOnQuest(by) or questDone(by) then return false end
	end
	return true
end

-- A place predicate's text (zone, subzone or bind location) reads as its
-- area's name in the client's language, or as the name the guide wrote.
function Own.samePlace(text, p)
	local C = Compat()
	local area = p.area and C.GetAreaName and C.GetAreaName(p.area)
	return same(text, area) or same(text, p.name)
end

-- Whether the character has reached `level`, and with `frac` (0-1) that
-- share of its XP: a `level 12.5` goal is done at level 12 with half the
-- level's XP, or at any later level.
function Own.levelReached(level, frac)
	local lvl = player.level or 1
	if lvl ~= level or not frac then return lvl >= level end
	local max = player.xpMax or 0
	return max > 0 and (player.xp or 0) / max >= frac
end

-- XP still to earn for a `level` goal: the rest of the levels below its
-- level (the 1.12 table, Levels.LEVEL_XP; the client's own XP to level for
-- the one the character is at) and its share of that level. nil once it is
-- reached, or while the client tells no XP.
function Own.xpLeft(goal)
	local lvl, xp, max = player.level or 1, player.xp or 0, player.xpMax or 0
	if max <= 0 or Own.levelReached(goal.level, goal.frac) then return nil end
	-- The share of a level as XP; the epsilon keeps 0.4 x 1400 at 560.
	local function share(total) return goal.frac and math.ceil(goal.frac * total - 1e-6) or 0 end
	if lvl == goal.level then return share(max) - xp end
	local levels = ns.Levels and ns.Levels.LEVEL_XP
	if not levels then return nil end
	local left = max - xp
	for l = lvl + 1, goal.level - 1 do left = left + (levels[l] or 0) end
	return left + share(levels[goal.level] or 0)
end

-- Deathskips (`die` goals) are the player's choice (behavior.deathskips, off
-- by default) and never a Hardcore character's: a death there is the end.
function Own.deathskips()
	if not ns.Get("behavior.deathskips") then return false end
	local rules = C_GameRules
	return not (rules and rules.IsHardcoreActive and rules.IsHardcoreActive())
end

-- `when upgrade`: Polestar's gear advice (Gear.IsUpgrade: wearable now and at
-- least the "minimum upgrade" better than what is worn) rates the item an
-- upgrade. When it cannot judge (gear advice off, the item's stats or the
-- spec's weights unknown) the item counts as one, so the step is shown and
-- the player decides.
function Own.isUpgrade(item)
	local G, link = ns.Gear, "item:" .. item
	if not (G and G.IsEnabled and G.IsEnabled() and G.CompareToEquipped(link)) then return true end
	return G.IsUpgrade(link) and true or false
end

-- `when cooldown`: the item or spell is cooling down, the global cooldown
-- (1.5 s or less) aside. A cooldown runs out without an event, so one that
-- holds asks for an update when it ends; one starting comes with
-- BAG_UPDATE_COOLDOWN or SPELL_UPDATE_COOLDOWN, heard once a guide has asked.
function Own.onCooldown(p)
	Own.cooldownAsked = true
	local C = Compat()
	local start, duration
	if p.item then start, duration = C.GetItemCooldown(p.item) else start, duration = C.GetSpellCooldown(p.spell) end
	if duration <= 1.5 then return false end
	local ends, now = start + duration, GetTime()
	if ends <= now then return false end
	local wake = Own.cooldownWake
	if not (wake and wake > now and wake <= ends) then
		Own.cooldownWake = ends
		ns.After(ends - now, function()
			if Own.cooldownWake == ends then Own.cooldownWake = nil end
			Engine.RequestUpdate()
		end)
	end
	return true
end

-- `when group <quest>`: the player's answer to "do this group quest?",
-- per character (CharState().groupQuests[q]: "do" or "skip"; Engine.AnswerGroup),
-- else the answer for every group quest (behavior.groupQuests "do" or "skip";
-- "ask": none, so the route asks). Never guessed from the quest log: a solo
-- alternative (`when !group`) may be for a quest the player already has.
function Own.groupAnswer(q)
	local answer = ns.CharState().groupQuests[q]
	if answer ~= nil then return answer end
	local all = ns.Get("behavior.groupQuests")
	if all == "do" or all == "skip" then return all end
	return nil
end

-- The quest of the first unanswered `group` predicate of a step, or nil. Such
-- a step applies but is not done (stepDone), so the route waits there until
-- the player answers; an along step never waits (the route passes over it).
-- Nor does a step with nothing to do for the quest now (Own.groupOpen): it
-- then applies as it would without the question, and the route asks once
-- the quest can be taken.
function Own.groupPending(step)
	if step.along or not step.when then return nil end
	for _, p in ipairs(step.when) do
		if p.k == "group" and Own.groupAnswer(p.q) == nil and Own.groupOpen(step, p.q) then return p.q end
	end
	return nil
end

-- Whether group quest q is worth asking about at step: not handed in nor
-- skipped by the player (Own.questSkipped), and in the log or, when the step
-- takes it, with an accept the character can take now. Not one the catch-up
-- left out (grey), one closed for good, or one not open yet (level,
-- prerequisite): the route would pass that accept anyway.
function Own.groupOpen(step, q)
	local C = Compat()
	if questDone(q) or Own.questSkipped(q) then return false end
	if C.IsOnQuest(q) then return true end
	local takes = false
	for _, goal in ipairs(step.goals) do
		if goal.t == "accept" and goal.quest == q then
			takes = true
			local lvl = tonumber(goal.minLevel)
			if goalApplies(goal) and not unavailableFor(goal) and not (lvl and (player.level or 1) < lvl) and not missingPre(goal) then
				return true
			end
		end
	end
	return not takes
end

function Own.predicateHolds(p)
	local C, k, ok = Compat(), p.k, false
	if k == "level" then
		local level, n, op = player.level or 1, p.n, p.op
		if p.frac then
			-- A point inside a level: the level plus the share of it done.
			local max = player.xpMax or 0
			if max > 0 then level = level + (player.xp or 0) / max end
			n = n + p.frac
		end
		return (op == "<" and level < n) or (op == "<=" and level <= n) or (op == ">" and level > n) or (op == ">=" and level >= n)
	elseif k == "money" then
		local money, n, op = C.GetMoney(), p.n, p.op
		return (op == "<" and money < n) or (op == "<=" and money <= n) or (op == ">" and money > n) or (op == ">=" and money >= n)
	elseif k == "onquest" then
		for _, q in ipairs(p.q) do
			if C.IsOnQuest(q) then
				ok = true
				break
			end
		end
	elseif k == "complete" then
		ok = C.IsQuestReadyForTurnIn(p.q)
	elseif k == "turnedin" then
		ok = questDone(p.q) and true or false
	elseif k == "available" then
		ok = Own.availableNow(p)
	elseif k == "has" then
		ok = (C.GetItemCount(p.item) or 0) >= (p.n or 1)
	elseif k == "upgrade" then
		ok = Own.isUpgrade(p.item)
	elseif k == "zone" or k == "subzone" then
		local zone, sub = C.GetZoneText()
		ok = Own.samePlace(k == "zone" and zone or sub, p)
	elseif k == "bound" then
		ok = Own.samePlace(C.GetBindLocation(), p)
	elseif k == "dungeon" then
		ok = p.map ~= nil and Engine.DungeonChosen(p.map)
	elseif k == "done" then
		ok = Own.labelDone(p.label)
	elseif k == "skill" then
		-- Not learned reads as rank 0, so `!skill Herbalism 1` is "has no Herbalism".
		ok = (C.GetSkillRank and C.GetSkillRank(p.skillLine or p.name) or 0) >= p.n
	elseif k == "cooldown" then
		ok = Own.onCooldown(p)
	elseif k == "knows" then
		-- IsPlayerSpell too: Forever's spellbook check says no for weapon skills.
		ok = C.IsSpellKnown(p.spell) or C.IsPlayerSpell(p.spell) == true
	elseif k == "group" then
		local answer = Own.groupAnswer(p.q)
		-- Unanswered: the step applies either way, and waits (Own.groupPending).
		if answer == nil then return true end
		ok = answer == "do"
	end
	if p.neg then return not ok end
	return ok
end

-- The first predicate of a step's `when` that does not hold now, or nil.
function Own.whenFails(step)
	for _, p in ipairs(step.when or NONE) do
		if not Own.predicateHolds(p) then return p end
	end
	return nil
end

-- A `next` option's `when` (from.nextWhen[id], format 4): whether it holds
-- now. Checked each time Polestar lists the options (routeOptions,
-- ChooseRoute, Engine.RouteOffered: Guides.OfferedBy, the guide menu), on
-- the character as they are then: at the hand-off, that decides the route.
function Own.optionHolds(from, id)
	local list = from.nextWhen and from.nextWhen[id]
	if not list then return true end
	if not player then refreshPlayer() end
	for _, p in ipairs(list) do
		if not Own.predicateHolds(p) then return false end
	end
	return true
end

-- A `next` option whose `when` can no longer hold, whatever the character
-- does: a `level<N` or `level<=N` they are past, or `!turnedin` of a quest
-- handed in. Any other may hold by the hand-off.
function Own.optionClosed(from, id)
	local list = from.nextWhen and from.nextWhen[id]
	if not list then return false end
	local level = player and player.level
	for _, p in ipairs(list) do
		if p.k == "level" and level and ((p.op == "<" and level >= p.n) or (p.op == "<=" and level > p.n)) then return true end
		if p.k == "turnedin" and p.neg and questDone(p.q) then return true end
	end
	return false
end

-- The loaded guide's step numbers by step table, built once per guide.
Own.stepNumbers = setmetatable({}, { __mode = "k" })
function Own.stepNumber(step)
	if not guide then return nil end
	local map = Own.stepNumbers[guide]
	if not map then
		map = {}
		for s, st in ipairs(guide.steps) do map[st] = s end
		Own.stepNumbers[guide] = map
	end
	return map[step]
end

-- Stored as held, or skipped (it applies, the player passed it): applies;
-- else its predicates live.
function Own.whenHolds(step)
	local s = Own.stepNumber(step)
	if s then
		local state = ns.CharState()
		local held, skipped = state.when[guide.id], state.skipped[guide.id]
		if (held and held[s]) or (skipped and skipped[s]) then return true end
	end
	return Own.whenFails(step) == nil
end

-- Store step s's `when` outcome once the route has moved past it
-- (latchPassed): held in `when`, failed as a skip. Not before the quest log
-- can be read (it lags PLAYER_LOGIN; Own.latchCaughtUp stores the steps
-- passed meanwhile). A step for other characters (`only`) stores nothing.
function Own.latchWhen(s)
	local step = guide.steps[s]
	if not logReady or not (step and step.when) or not Guides.Matches(step.only, player) then return end
	local state = ns.CharState()
	local held, skipped = state.when[guide.id], state.skipped[guide.id]
	if (held and held[s]) or (skipped and skipped[s]) then return end
	local field = Own.whenFails(step) == nil and "when" or "skipped"
	local t = state[field][guide.id]
	if not t then
		t = {}
		state[field][guide.id] = t
	end
	t[s] = true
end

-- Once per loaded guide, after the quest log can be read: store the
-- outcomes of steps 1..passed the route moved past before it could.
Own.caughtUp = setmetatable({}, { __mode = "k" })
function Own.latchCaughtUp(passed)
	if not logReady or Own.caughtUp[guide] then return end
	Own.caughtUp[guide] = true
	for s = 1, passed do Own.latchWhen(s) end
end

-- The player stands in a hearth's or flight's place: the zone or subzone
-- text is its area's name (`area`, C_Map.GetAreaInfo: both in the client's
-- language), else, for a goal the compiler gave no area, its location.
local function inPlace(goal)
	local C = Compat()
	local place = C.GetAreaName and C.GetAreaName(goal.area) or goal.location
	local zone, sub = C.GetZoneText()
	return same(zone, place) or same(sub, place)
end

-- Whether the player stands in a goto's place, by the subzone text: true or
-- false for a goto whose area (`area`, its label's) the client names, nil
-- for any other. A zone's name is never a goto's place: a label naming the
-- zone (the zone text) would put the player there anywhere in it.
function Own.inSubzone(goal)
	local C = Compat()
	local place = goal.area and C.GetAreaName and C.GetAreaName(goal.area)
	if not place then return nil end
	local zone, sub = C.GetZoneText()
	return same(sub, place) and not same(zone, place)
end

-- Discovered flight paths, CharState().flags.fp; recreated if lost.
local function fpTable()
	local flags = ns.CharState().flags
	if type(flags.fp) ~= "table" then flags.fp = {} end
	return flags.fp
end

-- A getfp's flight path is known: by its taxi node when the compiler gave
-- one (`node`, among the nodes Nav/Travel.lua records from the flight map in
-- CharState().flags.taxi), else by name: taxi node names read "Stormwind,
-- Elwynn"; guides say "Stormwind".
local function fpKnown(goal)
	if goal.node then
		local taxi = ns.CharState().flags.taxi
		return type(taxi) == "table" and taxi[goal.node] == true
	end
	local want = goal.location:lower()
	for name in pairs(fpTable()) do
		local n = name:lower()
		if n == want or n:match("^([^,]+)") == want then return true end
	end
	return false
end

local function manualFor(id, create)
	local all = ns.CharState().manual
	local m = all[id]
	if not m and create then
		m = {}
		all[id] = m
	end
	return m
end

local function skippedFor(id, create)
	local all = ns.CharState().skipped
	local s = all[id]
	if not s and create then
		s = {}
		all[id] = s
	end
	return s
end

local function isSkipped(s)
	local sk = skippedFor(guide.id)
	return sk and sk[s] and true or false
end

-- `along` steps (format 4; docs/GUIDE_FORMAT.md, "Along the way"): the route
-- passes over them (stepDone), and while the live step is past one, its open
-- goals are listed under it (Engine.GetAlong) until they are done or, with
-- `along = "<label>"`, until the live step reaches the step so labelled. A
-- quest whose work is still open there stays listed past the label (its
-- goals only) until that work is done: the labelled step is often the one
-- that hands it in (#797, #809), and "Turn in" alone hides what is left.
-- Per guide: { labels = { name -> step }, along = { step, ... } }.
Own.marks = setmetatable({}, { __mode = "k" })
function Own.marksOf()
	local m = Own.marks[guide]
	if not m then
		m = { labels = {}, along = {} }
		for s, st in ipairs(guide.steps) do
			if type(st.label) == "string" then m.labels[st.label] = s end
			if st.along then m.along[#m.along + 1] = s end
		end
		Own.marks[guide] = m
	end
	return m
end

-- Whether an along step's goal is held past its label: work for its quest
-- (not its accept, hand-in or a note) that applies, the quest in the log and
-- not ready to hand in. (On Own: the main chunk is at Lua's 200 locals.)
function Own.alongHeld(goal)
	if goal.quest == nil or goal.t == "accept" or goal.t == "turnin" or goal.t == "note" then return false end
	local C = Compat()
	return goalApplies(goal) and C.IsOnQuest(goal.quest) and not C.IsQuestReadyForTurnIn(goal.quest) or false
end

-- Step s is an along step behind the live step whose goals are listed: it
-- applies, the player did not skip it, and the live step has not reached the
-- step its `along` names. -> true (every goal), "held" (past the label: only
-- its Own.alongHeld goals, Own.alongShows) or false.
function Own.alongListed(s)
	local live = computed
	if not (guide and live) or type(s) ~= "number" or s >= live then return false end
	local step = guide.steps[s]
	if not (step and step.along) or isSkipped(s) or not stepApplies(step) then return false end
	if step.along ~= true then
		local stop = Own.marksOf().labels[step.along]
		if stop and live >= stop then
			for _, goal in ipairs(step.goals) do
				if Own.alongHeld(goal) then return "held" end
			end
			return false
		end
	end
	return true
end

-- Whether goal `goal` of along step s is listed now (Own.alongListed).
function Own.alongShows(s, goal)
	local listed = Own.alongListed(s)
	if listed == "held" then return Own.alongHeld(goal) end
	return listed and true or false
end

-- The listed along step holding `goal`, and its index there, or nil.
function Own.alongOf(goal)
	if not (guide and goal) then return nil end
	for _, s in ipairs(Own.marksOf().along) do
		if Own.alongListed(s) then
			for g, other in ipairs(guide.steps[s].goals) do
				if other == goal and Own.alongShows(s, other) then return s, g end
			end
		end
	end
	-- A pinned quest's (Own.pinGoals).
	if goal.quest and ns.CharState().pinnedQuests[goal.quest] then
		for _, e in ipairs(Own.pinGoals(goal.quest)) do
			if e[3] == goal then return e[1], e[2] end
		end
	end
	return nil
end

-- Quest q's work in listed along steps while it is not ready to hand in
-- (Own.alongHeld): { { step, goal index }, ... } in route order.
function Own.alongWork(q)
	local out = {}
	if not (guide and q) then return out end
	for _, s in ipairs(Own.marksOf().along) do
		if Own.alongListed(s) then
			for g, goal in ipairs(guide.steps[s].goals) do
				if goal.quest == q and Own.alongHeld(goal) then out[#out + 1] = { s, g } end
			end
		end
	end
	return out
end

-- An optional goal the player skipped: CharState().skipped[guideId]["s:g"]
-- (next to the step skips, which use the step number).
function Own.goalSkipped(s, g)
	local sk = ns.CharState().skipped[guide.id]
	return sk ~= nil and sk[Own.key(s, g)] and true or false
end

-- Prerequisites during play. An accept is unavailable before any visit
-- (unavailableFor, reason "pre") while it lacks a prerequisite the route no
-- longer brings: one of `preAll`, or of `pre` when none of those is done,
-- that is not done and that this guide does not still turn in (Own.coming).
-- A missing prerequisite the guide still turns in, before the accept or
-- (against lint's order) after it, is the route's own business or a gap in
-- the data: the accept keeps its place and its giver's window has the last
-- word. So is one this guide has only for other characters (Own.coming).
-- Returns the prerequisite that blocks, or nil.
function Own.preBlocked(a, depth)
	if not (guide and missingPre(a)) then return nil end
	if type(a.preAll) == "table" then
		for _, p in ipairs(a.preAll) do
			if not questDone(p) and not Own.coming(p, depth) then return p end
		end
	end
	local any = a.pre
	if type(any) == "table" and #any > 0 then
		for _, p in ipairs(any) do
			if questDone(p) or Own.coming(p, depth) then return nil end
		end
		return any[1]
	end
	return nil
end

-- Whether quest p is no missing prerequisite this guide can tell of: the
-- guide still turns it in (a turn-in of it, not optional, that applies to
-- the character, in a step the player has not skipped, not skipped or
-- ticked itself, and not unavailable down the chain of prerequisites), or
-- every goal of p in the guide is for other characters (`only`) and p is
-- not this character's (Own.notMine): another race's or class's version of
-- the chain, whose own the data does not list (Emphasis on Sacrifice names
-- the Human Lord Grayson Shadowbreaker, 7638, not the Dwarf's 7670). A p
-- the character can take, whose steps here are for other races only, is
-- one the route gives them elsewhere (Washed Ashore, 4681, for a Night Elf
-- in Darkshore, done in the Night Elf's own Darkshore guide before, #1442):
-- it is missing. Nor is one the guide does not turn in for the
-- character that the player holds (not skipped, Engine.SkipQuest): another
-- giver's version of a breadcrumb the guide takes elsewhere, handed in at
-- the same NPC (a Tauren Shaman's Call of Water from Thunder Bluff, 1529,
-- where the guide takes Orgrimmar's 1528, #1372): its follow-up stays open
-- instead of "Requires Call of Water first" with Call of Water in the log.
function Own.coming(p, depth)
	local state = ns.CharState()
	local skipped, manual = state.skipped[guide.id], state.manual[guide.id]
	local l = layoutOf(guide)
	local turnins, mine = l.turnins[p] or NONE, false
	for _, t in ipairs(turnins) do
		local tg = t.goal
		if stepApplies(t.step) and Guides.Matches(tg.only, player) then
			mine = true
			if not tg.optional and goalApplies(tg)
				and not (skipped and (skipped[t.s] or skipped[t.key])) and not (manual and manual[t.key])
				and not unavailableFor(tg, (depth or 0) + 1) then
				return true
			end
		end
	end
	if mine then return false end
	if Compat().IsOnQuest(p) and not Own.questSkipped(p) then return true end
	local accepts = l.accepts[p] or NONE
	for _, t in ipairs(accepts) do
		if stepApplies(t.step) and Guides.Matches(t.goal.only, player) then return false end
	end
	-- Goals an update passed (Own.passAdded) are no other character's version.
	local others = false
	for _, list in ipairs({ turnins, accepts }) do
		for _, t in ipairs(list) do
			if not (Own.gone(t.step) or Own.gone(t.goal)) then others = true end
		end
	end
	return others and Own.notMine(p)
end

-- Whether quest p is closed to the character by faction, race or class in
-- the quest data (the Codex, Lookup.QuestBlock); also true when that cannot
-- be told (no Codex, a quest it lacks), which keeps such a prerequisite to
-- the giver's window as before.
function Own.notMine(p)
	local X, Lk = ns.Codex, ns.Lookup
	local rec = X and X.Quest and Lk and Lk.QuestBlock and X.Quest(p)
	if not rec then return true end
	local why = Lk.QuestBlock(rec, player)
	return why == "faction" or why == "race" or why == "class"
end

-- The quest the player skipped that leaves out an accept missing
-- prerequisite p (unavailable, reason "pre"), or nil when the route simply
-- never brings p: p itself when the player skipped it (Engine.SkipQuest) or
-- skipped a step with its accept or turn-in (not a step with a `when`: a
-- failed condition is stored as a skip too), else what left p's accept out
-- down the chain (A skipped leaves out B, B leaves out C: C's is A).
function Own.skipRoot(p, depth)
	depth = depth or 0
	if depth > 8 or questDone(p) then return nil end
	if Own.questSkipped(p) then return p end
	local skipped = ns.CharState().skipped[guide.id]
	local l = layoutOf(guide)
	for _, list in ipairs({ l.turnins[p] or NONE, l.accepts[p] or NONE }) do
		for _, t in ipairs(list) do
			if skipped and (skipped[t.key] or (skipped[t.s] and t.step.when == nil)) and stepApplies(t.step) and Guides.Matches(t.goal.only, player) then return p end
		end
	end
	for _, t in ipairs(l.accepts[p] or NONE) do
		local u = unavailableFor(t.goal, depth + 1)
		if u and u.reason == "pre" and u.pre then
			local root = Own.skipRoot(u.pre, depth + 1)
			if root then return root end
		end
	end
	return nil
end

-- Every guide stands on its own (#1353; Fitz 2026-11-08, AGENTS.md). A
-- character who opens a leveling guide without the guides before it (a fresh
-- start at the guide's level, a skipped guide, or 0.3.5's new route order
-- for a 0.3.4 character) has accepts here whose prerequisites an EARLIER
-- guide of the route gives; the guide would pass them ("Requires X first",
-- Own.preBlocked). When a tab opens the guide (a route handoff, a reworked
-- tab following the log, and the saved tabs once the quest log is in), its
-- steps are planned for the character (Own.feederPlan): a feeder chain that
-- stays in the guide's own zones and costs little goes in, next to the
-- guide's own steps nearest it; every other accept that waits on an earlier
-- guide's quest is left out, with its goals, and a step left with no quest
-- goal goes too. Nothing marks either in the guide window; the report names
-- them (step.feeder, guide.hidden).
Own.FEED_BACK = 8 -- guides back along the route
Own.FEED_LOCAL = 300 -- seconds a feeder chain may add to the guide's route
Own.FEED_OBJECTIVE = 90 -- seconds counted per objective goal (kill, collect, ...)
Own.feedTried = {} -- guide id -> true: planned this session

-- The guides leading to g (their `next` or route choice names it, back
-- FEED_BACK guides, the pack's leveling guides for the character) and their
-- goals for this character: { first = quest -> its nearest accept { id,
-- guide (title), title, d, s, pre, preAll }, goals = quest -> { { id, d, s,
-- step, goal }, ... } }, d the distance back (1: the guide just before).
-- Steps put in by an earlier plan are left out. -> index, the guide ids read.
function Own.feederIndex(g)
	local idx, read = { first = {}, goals = {} }, {}
	local into = {}
	for _, h in ipairs(Guides.List()) do
		if h.pack == g.pack and (h.category == nil or h.category == "Leveling") and Guides.GuideMatches(h, player) then
			for _, to in ipairs(h.nextChoices or (h.next and { h.next }) or NONE) do
				into[to] = into[to] or {}
				into[to][#into[to] + 1] = h.id
			end
		end
	end
	local seen, frontier = { [g.id] = true }, { g.id }
	for d = 1, Own.FEED_BACK do
		local further = {}
		for _, id in ipairs(frontier) do
			for _, from in ipairs(into[id] or NONE) do
				local fg = not seen[from] and Guides.Get(from)
				if fg then
					seen[from] = true
					further[#further + 1] = from
					read[#read + 1] = from
					for s, step in ipairs(fg.steps) do
						if not step.feeder and Guides.Matches(step.only, player) then
							for _, goal in ipairs(step.goals) do
								local q = goal.quest
								if q and Guides.Matches(goal.only, player) then
									local list = idx.goals[q]
									if not list then
										list = {}
										idx.goals[q] = list
									end
									list[#list + 1] = { id = from, d = d, s = s, step = step, goal = goal }
									if goal.t == "accept" and not idx.first[q] then
										idx.first[q] = { id = from, guide = fg.title, title = goal.title, d = d, s = s, pre = goal.pre, preAll = goal.preAll }
									end
								end
							end
						end
					end
				end
			end
		end
		if #further == 0 then break end
		frontier = further
	end
	return idx, read
end

-- The chain that brings missing quest p: p's accept in a guide leading here,
-- and down its own missing prerequisites while such a guide takes them. A
-- prerequisite in the log is only handed in on the way ("turnin"). nil when
-- no guide leading here takes p (a gap of the route itself: the guide keeps
-- such an accept, "Requires X first"). `ok` false when the chain cannot be
-- done from the route (a quest further down no such guide takes) or the
-- player skipped one of its quests (Engine.SkipQuest, or a feeder step:
-- CharState().feedSkips; then `skipped`, and its accepts stay, "skipped"). -> { p, from = idx.first[p], ok, quests = { [q] = true | "turnin" }, deps = {} }
function Own.feederChain(p, idx)
	local from = idx.first[p]
	if not from then return nil end
	local C, skips = Compat(), ns.CharState().feedSkips
	local ch = { p = p, from = from, ok = true, quests = {}, deps = {} }
	local cur = p
	for _ = 1, 8 do
		if Own.questSkipped(cur) or (type(skips) == "table" and skips[cur]) then
			ch.ok, ch.skipped = false, true
			break
		end
		if C.IsOnQuest(cur) then
			ch.quests[cur] = "turnin"
			break
		end
		local e = idx.first[cur]
		if not e then
			ch.ok = false
			break
		end
		ch.quests[cur] = true
		local m = missingPre(e)
		if not m then break end
		cur = m
	end
	return ch
end

-- The first located goal of a step (a travel point), or nil.
function Own.feedPoint(goals)
	for _, goal in ipairs(goals) do
		if goal.map and goal.x and goal.y then return { map = goal.map, x = goal.x, y = goal.y, f = goal.f } end
	end
	return nil
end

-- The extra route of `steps` ({ goals }, in order) for a guide whose own
-- steps stand at `own` (travel points), in seconds: each step's point is a
-- detour there and back from the nearest place the guide or the steps before
-- it already go (ns.DirectTravelCost: a straight run, never the route
-- planner; another continent costs an hour), plus FEED_OBJECTIVE per goal
-- other than an accept or a hand-in.
function Own.feedCost(own, steps)
	local near = {}
	for i, p in ipairs(own) do near[i] = p end
	local t = 0
	for _, st in ipairs(steps) do
		local pt = Own.feedPoint(st.goals)
		if pt then
			local best
			for _, q in ipairs(near) do
				local c = ns.DirectTravelCost(pt, q)
				if c and (not best or c < best) then best = c end
			end
			t = t + 2 * (best or 0)
			near[#near + 1] = pt
		end
		for _, goal in ipairs(st.goals) do
			if goal.t ~= "accept" and goal.t ~= "turnin" then t = t + Own.FEED_OBJECTIVE end
		end
	end
	return t
end

-- Whether goal `goal` of step j of guide g is one an update passed for the
-- character (CharState().gone, Own.passAdded), by g's own step keys.
function Own.goneIn(g, j, goal)
	local all = ns.CharState().gone
	local mine = type(all) == "table" and all[g.id]
	if not mine then return false end
	local e = mine[Own.stepKeys(g)[j]]
	if e == true then return true end
	return type(e) == "table" and e[Own.goalId(goal)] == true
end

-- The steps of guide g an update passed, as a source of feeder steps for the
-- planner (Own.feederIndex's shape, distance 0, from g itself): every goal of
-- a quest whose accept it passed, so a quest ahead that needs one gets it back
-- on the way (Own.feederPlan), or drops out with what follows.
function Own.goneSource(g, idx)
	local all = ns.CharState().gone
	if not (type(all) == "table" and all[g.id]) then return end
	local passed = {}
	for j, step in ipairs(g.steps) do
		for _, goal in ipairs(step.goals) do
			if goal.t == "accept" and goal.quest and Own.goneIn(g, j, goal) and Guides.Matches(goal.only, player) then
				passed[goal.quest] = true
				-- This guide's own step, on the way, before an earlier guide's.
				idx.first[goal.quest] = { id = g.id, guide = g.title, title = goal.title, d = 0, s = j, pre = goal.pre, preAll = goal.preAll }
			end
		end
	end
	for j, step in ipairs(g.steps) do
		if Guides.Matches(step.only, player) then
			for _, goal in ipairs(step.goals) do
				local q = goal.quest
				if q and passed[q] and Guides.Matches(goal.only, player) then
					local list = idx.goals[q] or {}
					idx.goals[q] = list
					list[#list + 1] = { id = g.id, d = 0, s = j, step = step, goal = goal }
				end
			end
		end
	end
end

-- Whether a step's quest conditions (`when onquest`, `complete`, `turnedin`,
-- negated or not) can hold for the character now, for the planner, which
-- reads guides no tab shows: a step for those who carry a quest (Loch Modan's
-- hand-in of Expanding Horizons, `when onquest 97914`) is not the route of a
-- character without it, so it neither brings its quests nor asks for feeders
-- (#1353 upgrade). Other conditions are taken to hold.
function Own.whenMayHold(step)
	local C = Compat()
	for _, p in ipairs(step.when or NONE) do
		local qs = type(p.q) == "table" and p.q or (p.q and { p.q }) or NONE
		local ok
		if p.k == "onquest" then
			ok = false
			for _, q in ipairs(qs) do ok = ok or C.IsOnQuest(q) end
		elseif p.k == "complete" then
			ok = false
			for _, q in ipairs(qs) do ok = ok or (C.IsOnQuest(q) and C.IsQuestReadyForTurnIn(q)) end
		elseif p.k == "turnedin" then
			ok = true
			for _, q in ipairs(qs) do ok = ok and questDone(q) and true end
		end
		if ok ~= nil then
			if p.neg then ok = not ok end
			if not ok then return false end
		end
	end
	return true
end

-- Guide g's steps for the character, or nil when they are g's own. Each
-- accept of g that would be passed for a missing prerequisite (not taken,
-- not done, not skipped) is followed to the quest it lacks that g does not
-- bring itself (a prerequisite g takes but passes too is followed to the one
-- it lacks), then to that quest's chain in the guides leading here
-- (Own.feederChain; none: a gap of the route, left as it is). A chain goes
-- in when it opens an accept here that is not grey for the character, every
-- goal of its steps with a place is in one of g's own zones (the maps of its
-- steps), and done before the first accept it opens it adds at most
-- FEED_LOCAL to the route from where g and the feeder steps already in go
-- before that accept (Own.feedCost; the feeder quests themselves may be
-- grey); chains opening the most go first. Its steps (those of the guides
-- leading here holding its goals, with those goals only, in route order,
-- each titled as in its guide, with `feeder` = that guide's id and
-- `feederStep` = its step there) go after the step of g before that accept
-- nearest each, in order. The accepts of every other chain are left out,
-- with all of their quest's goals; a step that loses a goal that way and has
-- no quest goal left goes.
-- -> { steps, feeders (steps put in), hidden = { [quest] = { title, need,
-- needTitle, from (guide title) } }, cost, fromBase (g's step -> new step),
-- legs (g's step -> true where its baked leg still leads in) }
function Own.feederPlan(g)
	local C = Compat()
	local level = player.level or 1
	local l = layoutOf(g)
	-- What an update passed behind the player (Own.passAdded) is not the
	-- guide's: a quest ahead needing it is planned for like one an earlier
	-- guide gives (its steps are a source, as the guides leading here).
	local function mine(t)
		return Guides.Matches(t.step.only, player) and Guides.Matches(t.goal.only, player) and Own.whenMayHold(t.step)
			and not Own.goneIn(g, t.s, t.goal)
	end
	local function acceptOf(p)
		for _, t in ipairs(l.accepts[p] or NONE) do
			if mine(t) then return t end
		end
		return nil
	end
	local function turnsIn(p)
		for _, t in ipairs(l.turnins[p] or NONE) do
			if mine(t) and not t.goal.optional then return true end
		end
		return false
	end
	-- As Own.preBlocked, for g whether or not a tab shows it.
	local blocker
	-- As Own.coming: p held (not skipped) counts as coming (#1372); else a
	-- turn-in here brings p when g takes p itself and that accept is open (a
	-- turn-in of a quest neither held nor taken here is orphaned).
	local function coming(p, depth)
		if C.IsOnQuest(p) and not Own.questSkipped(p) then return true end
		if not turnsIn(p) then
			-- Every goal of p here for other characters, p not this one's: another
			-- race's version of the chain (Own.coming, Own.notMine).
			-- (Goals an update passed are no version of anything: Own.goneIn.)
			if acceptOf(p) then return false end
			local others = false
			for _, list in ipairs({ l.turnins[p] or NONE, l.accepts[p] or NONE }) do
				for _, t in ipairs(list) do
					if not Own.goneIn(g, t.s, t.goal) then others = true end
				end
			end
			return others and Own.notMine(p)
		end
		local a = acceptOf(p)
		if not a then return false end
		if depth > 8 then return true end
		return blocker(a.goal, depth + 1) == nil
	end
	blocker = function(a, depth)
		if type(a.preAll) == "table" then
			for _, p in ipairs(a.preAll) do
				if not questDone(p) and not coming(p, depth) then return p end
			end
		end
		if type(a.pre) == "table" and #a.pre > 0 then
			for _, p in ipairs(a.pre) do
				if questDone(p) or coming(p, depth) then return nil end
			end
			return a.pre[1]
		end
		return nil
	end
	-- Every prerequisite accept a lacks that nothing here brings: each missing
	-- one of `preAll`, and `pre`'s first when none of them is done or coming.
	-- (Split Bone Necklace needs Bloody Bone Necklace and The Vile Reef: one
	-- chain alone opens nothing.)
	local function blockers(a)
		local out = {}
		if type(a.preAll) == "table" then
			for _, p in ipairs(a.preAll) do
				if not questDone(p) and not coming(p, 0) then out[#out + 1] = p end
			end
		end
		if type(a.pre) == "table" and #a.pre > 0 then
			local any = false
			for _, p in ipairs(a.pre) do
				if questDone(p) or coming(p, 0) then any = true break end
			end
			if not any then out[#out + 1] = a.pre[1] end
		end
		return out
	end
	local idx, read
	local chains, list, seen = {}, {}, {}
	for s, step in ipairs(g.steps) do
		if Guides.Matches(step.only, player) and Own.whenMayHold(step) then
			for _, goal in ipairs(step.goals) do
				local q = goal.quest
				if goal.t == "accept" and q and not seen[q] and (goal.pre or goal.preAll) and Guides.Matches(goal.only, player)
					and not Own.goneIn(g, s, goal) then
					seen[q] = true
					local roots = not (C.IsOnQuest(q) or questDone(q) or Own.questSkipped(q)) and blockers(goal) or NONE
					-- One record for the accept, in the chain of each missing root: it
					-- opens only once every one of them is put in (else it is left out
					-- with any chain not put in; a root no guide gives keeps its line).
					local d = #roots > 0 and { q = q, s = s, title = goal.title, whole = true,
						worth = not goal.optional and not (goal.qlvl and C.IsQuestTrivial(tonumber(goal.qlvl), level)) } or nil
					for _, root in ipairs(roots) do
						-- Down to the quest the guide does not take itself (as before).
						local p = root
						for _ = 1, 8 do
							local a = p and acceptOf(p)
							if not a then break end
							p = blocker(a.goal, 0)
						end
						if p and not idx then
							idx, read = Own.feederIndex(g)
							Own.goneSource(g, idx)
						end
						local ch = false
						if p then
							ch = chains[p]
							if ch == nil then
								ch = Own.feederChain(p, idx) or false
								chains[p] = ch
								if ch then
									ch.order = #list + 1
									list[#list + 1] = ch
								end
							end
						end
						if ch then
							ch.deps[#ch.deps + 1] = d
						else
							d.whole = false
						end
					end
				end
			end
		end
	end
	if #list == 0 then
		for _, id in ipairs(read or NONE) do
			if not Engine.TabIds()[id] then Guides.Release(id) end
		end
		return nil
	end
	-- g's own places: each step's point (the last one before it for a step
	-- without one), and its zones.
	local zones, pointAt, ptOf, at = {}, {}, {}, nil
	local goneAll = ns.CharState().gone
	local goneMine = type(goneAll) == "table" and goneAll[g.id] or nil
	local keysG = Own.stepKeys(g)
	for s, step in ipairs(g.steps) do
		-- A step an update passed is no place the guide goes (Own.passAdded).
		if Guides.Matches(step.only, player) and not (goneMine and goneMine[keysG[s]] == true) then
			ptOf[s] = Own.feedPoint(step.goals)
			at = ptOf[s] or at
			for _, goal in ipairs(step.goals) do
				if goal.map then zones[goal.map] = true end
			end
		end
		pointAt[s] = at
	end
	-- The source steps holding goals of the quests in `set` (quest -> true |
	-- "turnin"), in route order, each with those goals in its own order.
	local function stepsOf(set)
		local byKey, out = {}, {}
		for q, how in pairs(set) do
			-- The quest's goals in the guide of its accept (another guide's copy
			-- of the accept left out), and its work and hand-in in the guides after.
			local first = idx.first[q]
			for _, e in ipairs(idx.goals[q] or NONE) do
				local fits = not first or e.id == first.id or (e.d < first.d and e.goal.t ~= "accept")
				if fits and (how == true or e.goal.t ~= "accept") then
					local k = e.id .. ":" .. e.s
					local st = byKey[k]
					if not st then
						st = { key = k, d = e.d, s = e.s, id = e.id, step = e.step, has = {} }
						byKey[k] = st
						out[#out + 1] = st
					end
					st.has[e.goal] = true
				end
			end
		end
		table.sort(out, function(a, b)
			if a.d ~= b.d then return a.d > b.d end
			return a.s < b.s
		end)
		for _, st in ipairs(out) do
			st.goals = {}
			for _, goal in ipairs(st.step.goals) do
				if st.has[goal] then st.goals[#st.goals + 1] = goal end
			end
		end
		return out
	end
	local function local_(steps)
		for _, st in ipairs(steps) do
			for _, goal in ipairs(st.goals) do
				if goal.map and not zones[goal.map] then return false end
			end
		end
		return true
	end
	local function opens(ch)
		local n = 0
		for _, d in ipairs(ch.deps) do
			if d.worth and d.whole then n = n + 1 end -- an accept another missing root holds opens nothing
		end
		return n
	end
	table.sort(list, function(a, b)
		local na, nb = opens(a), opens(b)
		if na ~= nb then return na > nb end
		return a.order < b.order
	end)
	-- Chain by chain: its steps go in when they are local and, done before
	-- the first accept they open (U), cost at most FEED_LOCAL from where the
	-- guide and the steps already put in go before that (Own.feedCost). Each
	-- goes after the step of g before U nearest it, in order; a source step
	-- another chain put in already takes this chain's goals too.
	local gaps, placed, placedAt, cost = {}, {}, {}, 0
	for _, ch in ipairs(list) do
		local mine = ch.ok and opens(ch) > 0 and stepsOf(ch.quests)
		if mine and local_(mine) then
			local U = #g.steps + 1
			for _, d in ipairs(ch.deps) do
				if d.s < U then U = d.s end
			end
			local near, fresh = {}, {}
			for s = 1, U - 1 do
				if ptOf[s] then near[#near + 1] = ptOf[s] end
			end
			for _, st in pairs(placed) do
				local pt = Own.feedPoint(st.goals)
				if pt then near[#near + 1] = pt end
			end
			-- Nothing placed before it: the guide's own place at that accept.
			if #near == 0 and pointAt[U] then near[1] = pointAt[U] end
			for _, st in ipairs(mine) do
				if not placed[st.key] then fresh[#fresh + 1] = st end
			end
			local c = Own.feedCost(near, fresh)
			if c <= Own.FEED_LOCAL then
				cost, ch.inserted = cost + c, true
				local last = 0
				for _, st in ipairs(mine) do
					local p = placed[st.key]
					if p then
						for _, goal in ipairs(st.goals) do p.has[goal] = true end
						p.goals = {}
						for _, goal in ipairs(p.step.goals) do
							if p.has[goal] then p.goals[#p.goals + 1] = goal end
						end
						if placedAt[st.key] > last then last = placedAt[st.key] end
					else
						local pt = Own.feedPoint(st.goals)
						-- A step of this guide an update passed comes back just before
						-- the quest that needs it: on the way, never a step back.
						if st.d == 0 and U - 1 > last then last = U - 1 end
						local best, bestJ = nil, last
						for j = last, U - 1 do
							local q = pointAt[j > 0 and j or 1]
							local d = pt and q and ns.DirectTravelCost(pt, q)
							if d and (not best or d < best) then best, bestJ = d, j end
						end
						placed[st.key], placedAt[st.key] = st, bestJ
						gaps[bestJ] = gaps[bestJ] or {}
						table.insert(gaps[bestJ], st)
						last = bestJ
					end
				end
			end
		end
	end
	-- Left out: the accepts of the chains not put in, with their quests' goals.
	-- (Kept on the way: what needed a step an update passed, `onWay`.)
	local hidden, drop, onWay = {}, {}, {}
	for _, ch in ipairs(list) do
		if ch.inserted and ch.from.id == g.id then
			for _, d in ipairs(ch.deps) do onWay[d.q] = ch.p end
		end
	end
	-- A chain the player skipped is theirs: its accepts stay, passed as
	-- "skipped" (Engine.SkipQuest), not left out.
	for _, ch in ipairs(list) do
		if not ch.inserted and not ch.skipped then
			for _, d in ipairs(ch.deps) do
				hidden[d.q] = { title = d.title, need = ch.p, needTitle = ch.from.title, from = ch.from.guide, fromId = ch.from.id }
				drop[d.q] = true
			end
		end
	end
	if next(placed) == nil and next(hidden) == nil then
		for _, id in ipairs(read or NONE) do
			if not Engine.TabIds()[id] then Guides.Release(id) end
		end
		return nil
	end
	local function feederStep(st)
		local goals = {}
		for i, goal in ipairs(st.goals) do
			local c = {}
			for k, v in pairs(goal) do c[k] = v end
			goals[i] = c
		end
		local src = st.step
		return { title = src.title, note = src.note, image = src.image, label = src.label, only = src.only,
			goals = goals, feeder = st.id, feederStep = st.s }
	end
	local steps, fromBase, legs, feeders = {}, {}, {}, 0
	local prevOwn = 0 -- g's step just before, when nothing came in between
	local function add(list2)
		for _, st in ipairs(list2 or NONE) do
			steps[#steps + 1] = feederStep(st)
			feeders = feeders + 1
			prevOwn = nil
		end
	end
	add(gaps[0])
	local starters = l.starters
	for s, step in ipairs(g.steps) do
		local kept, lost, quests = {}, false, false
		for _, goal in ipairs(step.goals) do
			-- A quest left out goes with its goals, and with the item it starts from (#1531).
			local starts = starters[goal]
			if (goal.quest and drop[goal.quest]) or (starts and drop[starts.quest]) then
				lost = true
			else
				kept[#kept + 1] = goal
				if goal.quest then quests = true end
			end
		end
		if not (lost and not quests) then
			local st = step
			if lost then
				st = {}
				for k, v in pairs(step) do st[k] = v end
				st.goals = kept
			end
			steps[#steps + 1] = st
			fromBase[s] = #steps
			if prevOwn == s - 1 then legs[s] = true end
			prevOwn = s
		else
			prevOwn = nil
		end
		add(gaps[s])
	end
	for _, id in ipairs(read or NONE) do
		if not Engine.TabIds()[id] then Guides.Release(id) end
	end
	return { steps = steps, feeders = feeders, hidden = hidden, cost = cost, fromBase = fromBase, legs = legs, onWay = onWay }
end

-- Guide g with the plan's steps: a new guide table with g's fields (a fresh
-- table, so every per-guide cache starts over), `feeders` (steps put in),
-- `hidden`, `feedCost`, `fromBase`, `base` = g, and g's baked legs into the
-- steps whose way in is unchanged.
function Own.rebuilt(g, plan)
	local g2 = {}
	for key, v in pairs(g) do
		if key ~= "steps" and key ~= "stepsSrc" and key ~= "legs" then g2[key] = v end
	end
	g2.steps, g2.feeders, g2.hidden, g2.feedCost, g2.fromBase, g2.base = plan.steps, plan.feeders, plan.hidden, plan.cost, plan.fromBase, g
	g2.onWay = next(plan.onWay) and plan.onWay or nil
	local legs = rawget(g, "legs")
	if type(legs) ~= "table" then legs = Guides.Legs(g.id) end
	if type(legs) == "table" then
		local moved = {}
		for s, leg in pairs(legs) do
			if type(s) == "number" and plan.legs[s] and plan.fromBase[s] then moved[plan.fromBase[s]] = leg end
		end
		g2.legs = moved
	end
	return g2
end

-- Plan guide `id`'s steps for the character (Guides.Replace), once the quest
-- log can be read: once per session for a saved tab, and again (`again`)
-- each time a tab opens the guide afresh, so a quest done or skipped since
-- counts. Leveling guides only; always planned from the guide as registered
-- (`base`), which comes back when the plan changes nothing.
function Own.withFeeders(id, again)
	if (Own.feedTried[id] and not again) or not logReady or not ns.IsLoggedIn() then return end
	local g = Guides.Get(id)
	if not g or not (g.category == nil or g.category == "Leveling") then return end
	g = g.base or g
	Own.feedTried[id] = true
	if not player then refreshPlayer() end
	local plan = Own.feederPlan(g)
	if plan then
		Guides.Replace(id, Own.rebuilt(g, plan))
	elseif Guides.Get(id) ~= g then
		Guides.Replace(id, g)
	end
end

-- "s:g", built once per step and goal: check-offs and goal skips are looked
-- up for every goal on every evaluation.
Own.keys = {}
function Own.key(s, g)
	local row = Own.keys[s]
	if not row then
		row = {}
		Own.keys[s] = row
	end
	local k = row[g]
	if not k then
		k = s .. ":" .. g
		row[g] = k
	end
	return k
end

-- A Class guide this character cannot start yet: nothing of it played (no
-- step skipped, no goal ticked, none of its quests taken or done) and its
-- opening, the first step for this character with an accept or a `level`
-- goal, waits on them: a `level` goal above their level, or accepts none of
-- which they can take yet (level first, then a missing prerequisite). Such a
-- guide shows a notice instead of its steps, points nowhere and marks
-- nothing unavailable, and starts by itself once the gate opens (level-up,
-- turn-in). { step, level } or { step, pre, preTitles }, with the opening's
-- first accept as `giver`; else nil. Cached per evaluation.
Own.gateCache = setmetatable({}, { __mode = "k" })
function Own.startGate(g)
	if not (g and g.category == "Class" and player) then return nil end
	local level = player.level or 1
	local c = Own.gateCache[g]
	if c and c.gen == generation and c.level == level then return c.gate or nil end
	local gate = Own.findGate(g, level)
	Own.gateCache[g] = { gen = generation, level = level, gate = gate or false }
	return gate
end

-- Nothing of guide g played: no step skipped, no goal ticked, none of its
-- quests taken or done.
function Own.untouched(g)
	local s = ns.CharState()
	local sk, ticks = s.skipped[g.id], s.manual[g.id]
	if (type(sk) == "table" and next(sk)) or (type(ticks) == "table" and next(ticks)) then return false end
	local C = Compat()
	for _, step in ipairs(g.steps) do
		for _, goal in ipairs(step.goals) do
			local q = goal.quest
			if q and (C.IsOnQuest(q) or questDone(q)) then return false end
		end
	end
	return true
end

-- Another race's starting zone on the character's side (Guides.OtherStart),
-- per guide for the character's race and class.
Own.otherCache = setmetatable({}, { __mode = "k" })
function Own.otherStart(g)
	if not (g and player) then return false end
	local c = Own.otherCache[g]
	if not (c and c.race == player.race and c.class == player.class) then
		c = { race = player.race, class = player.class, v = Guides.OtherStart(g, player) }
		Own.otherCache[g] = c
	end
	return c.v
end

-- Such a guide the character has not reached: Polestar does not guide them
-- there (Fitz, 2026-10-30). While none of it is played (Own.untouched) and
-- the player is outside its zone, the guide window shows a notice instead of
-- its live step (Engine.AwayStart) and the arrow points nowhere; arriving
-- lifts it, and once a quest of it is taken it does not come back. Cached
-- per evaluation.
Own.awayCache = setmetatable({}, { __mode = "k" })
function Own.awayStart(g)
	if not (Own.otherStart(g) and type(g.zone) == "number") then return false end
	local c = Own.awayCache[g]
	if c and c.gen == generation then return c.v end
	local v = Compat().GetPlayerMapPosition() ~= g.zone and Own.untouched(g)
	Own.awayCache[g] = { gen = generation, v = v }
	return v
end

-- In such a guide, a quest the character can never take (the quest
-- database's race, class or faction: the Human class letters for a Night Elf
-- Warrior in Elwynn, Tauren-only Mulgore quests for a Troll) is not theirs,
-- like another class's goals. Without the quest database those goals stay.
Own.questCtx = {}
function Own.barred(goal)
	local q = goal.quest
	if not (q and guide and Own.otherStart(guide)) then return false end
	local Q = ns.QuestDB
	local r = Q and Q.IsLoaded() and Q.QuestRecord(q)
	if not r then return false end
	return not Q.IsEligible(r, Q.PlayerContext(player, Own.questCtx))
end

function Own.findGate(g, level)
	if not Own.untouched(g) then return nil end
	local C = Compat()
	for i, step in ipairs(g.steps) do
		if Guides.Matches(step.only, player) then
			local opening, need, doable, acceptLevel, pre, giver = false, 0, false, nil, nil, nil
			for _, goal in ipairs(step.goals) do
				if Guides.Matches(goal.only, player) then
					if goal.t == "level" then
						opening = true
						if (goal.level or 0) > need then need = goal.level end
					elseif goal.t == "accept" then
						opening = true
						giver = giver or goal
						local lvl = tonumber(goal.minLevel)
						if lvl and level < lvl then
							if not acceptLevel or lvl < acceptLevel then acceptLevel = lvl end
						else
							local p = missingPre(goal)
							if p then
								pre = pre or { quest = p, titles = goal.preTitles }
							else
								local closed = false
								for _, by in ipairs(type(goal.closedBy) == "table" and goal.closedBy or NONE) do
									if C.IsOnQuest(by) or questDone(by) then closed = true end
								end
								if not closed then doable = true end
							end
						end
					end
				end
			end
			if opening then
				if not doable and acceptLevel and acceptLevel > need then need = acceptLevel end
				if need > level then return { step = i, level = need, giver = giver } end
				if not doable and pre then return { step = i, pre = pre.quest, preTitles = pre.titles, giver = giver } end
				return nil
			end
		end
	end
	return nil
end

local MANUAL = { talk = true, hearth = true, getfp = true, fly = true, train = true, vendor = true, task = true }

-- Whether the client can answer for a feature (Compat.Supports); a missing
-- API turns the goal into a manual check-off instead of a dead end.
local function supports(feature)
	local fn = Compat().Supports
	return fn and fn(feature) or false
end

-- How a craft goal is tracked: "skill" (untilSkill on a known skill line),
-- "count" (created item in bags) or "manual".
local function craftMode(goal)
	if goal.untilSkill and (goal.skillLine or goal.skill) and supports("skill") then return "skill" end
	if goal.item then return "count" end
	return "manual"
end

-- Profession `train` goals: skill line plus the rank to reach (1 Apprentice
-- .. 4 Artisan, a rank name, or the cap itself).
local RANK_CAPS = { 75, 150, 225, 300 }
local RANK_NAMES = { apprentice = 1, journeyman = 2, expert = 3, artisan = 4 }
local function rankCap(goal)
	local r = goal.rank
	if type(r) == "string" then r = RANK_NAMES[r:lower()] or tonumber(r) end
	if type(r) ~= "number" then return nil end
	if r <= 4 then return RANK_CAPS[r] end
	return r
end

local function isProfessionTrain(goal)
	return goal.t == "train" and (goal.skillLine or goal.skill) and rankCap(goal) and supports("skill")
end

local function isManual(goal)
	local t = goal.t
	if t == "train" and isProfessionTrain(goal) then return false end
	-- A quest `talk` is the quest's objective: its line decides (goalDone).
	if MANUAL[t] and not (t == "talk" and goal.quest) then return true end
	if (t == "kill" or t == "interact" or t == "use") and not goal.quest then return true end
	if t == "skill" then return not supports("skill") end
	if t == "learn" then return not supports("spell") end
	if t == "rep" then return not supports("faction") end
	if t == "achieve" then return not supports("achievement") end
	if t == "craft" then return craftMode(goal) == "manual" end
	return false
end

---------------------------------------------------------------------------
-- Candidate goals: `candidates` lists every NPC that would do; the Engine
-- keeps those the character may use and picks the cheapest to reach. Picks
-- are redone on step start, zone change and landing (contextGen), never per
-- frame; CycleCandidate moves to the next-best.
---------------------------------------------------------------------------

local contextGen = 0
local picks = setmetatable({}, { __mode = "k" }) -- goal -> { list = { candidate, ... }, i, gen }

-- Ranking: candidates on the player's continent always come before others,
-- even when frames are missing and travel cannot be measured; candidates in a
-- zone far above the character (ZoneLevels) come after both. Within a
-- tier: travel cost. Only the PLANNED nearest by straight line get the travel
-- planner's estimate (a set can hold one vendor per town in the world); the
-- rest count their straight-line running time. An unplaceable candidate counts
-- as right here when it is on the player's own map, else after every placed one.
-- A `train class` goal carries its step's zone (`zone`, a uiMapID): when that
-- map has a trainer of the character's class, the others come after all of
-- the zone's, wherever the player stands, unless one is within HOME_NEAR
-- yards of them (the trainers at the Skyborne camp below Thunder Bluff for a
-- step in Thunder Bluff). Before, the step's town lost to the trainer nearest
-- the player whenever the step came up away from it: a Shaman still in the
-- Barrens at Orgrimmar's training step was sent to the Valley of Trials
-- (#1357), and the Undercity's training step, current at Orgrimmar's
-- zeppelin tower, named Orgrimmar's trainers.
local UNMEASURED = 1e9
local PLANNED = 8
local RUN_SPEED = 7 -- yards per second, unmounted
local HOME_NEAR = 100
-- Farm spots (`collect … nearest`): seconds to farm the items still missing
-- there, and how many levels the spot's weakest mobs are above the player
-- (3 or more: too high).
local TOO_HIGH = 3
local function farmSeconds(goal, c)
	local level = player.level or 1
	local lo, hi = level, level
	if type(c.lvl) == "table" then lo, hi = c.lvl[1] or c.lvl.min or level, c.lvl[2] or c.lvl.max or level end
	local gap = lo - level
	local mob = math.floor((lo + hi) / 2 + 0.5)
	local diff = mob - level
	local kpm
	if Compat().IsQuestTrivial(mob, level) then
		kpm = 2.5 -- grey
	elseif diff >= 1 then
		kpm = 1.0
	elseif diff >= -4 then
		kpm = 1.5
	else
		kpm = 2.0 -- green, not yet grey
	end
	kpm = kpm * math.min(1, (tonumber(c.spawns) or 8) / 8)
	local need = (goal.count or 1) - (goal.item and Compat().GetItemCount(goal.item) or 0)
	if need < 1 then need = 1 end
	local rate = tonumber(c.rate) or 1
	if rate <= 0 or kpm <= 0 then return UNMEASURED, gap end
	return need / (rate * kpm) * 60, gap
end

local function pickFor(goal)
	local p = picks[goal]
	if p and p.gen == contextGen then return p end
	local C = Compat()
	local here = ns.PlayerPoint()
	local hereCont = here and C.GetContinentMap and C.GetContinentMap(here.map)
	local hc, hx, hy
	if here then hc, hx, hy = C.MapToWorld(here.map, here.x, here.y, here.f) end
	local farm = goal.t == "collect" and not goal.quest
	local zoneLevels = ns.Maps and ns.Maps.GetZoneLevels
	local list, tier, cost, extra, order, gap = {}, {}, {}, {}, {}, {}
	local reasonable = false
	for i, c in ipairs(goal.candidates) do
		if Guides.CandidateMatches(c, player) then
			list[#list + 1] = c
			order[c] = i * 1e-6 -- stable among equals
			if farm then
				extra[c], gap[c] = farmSeconds(goal, c)
				if gap[c] < TOO_HIGH then reasonable = true end
			else
				extra[c], gap[c] = 0, 0
			end
			local cc, cx, cy = C.MapToWorld(c.map, c.x, c.y, c.f)
			local line = hc and cc == hc and ((cx - hx) ^ 2 + (cy - hy) ^ 2) ^ 0.5 / RUN_SPEED or nil
			local cont = C.GetContinentMap and C.GetContinentMap(c.map)
			local same
			if hereCont and cont then
				same = hereCont == cont
			else
				same = line ~= nil
			end
			tier[c] = same and 0 or 1
			-- A zone whose mobs start more than 10 levels above the character
			-- (Mount Hyjal's vendors seen from Darkshore at 18) comes after
			-- every other choice, other continents included.
			local zoneMin = not farm and zoneLevels and zoneLevels(c.map)
			if zoneMin and zoneMin > (player.level or 1) + 10 then tier[c] = tier[c] + 2 end
			cost[c] = line or ((here and c.map == here.map) and 0 or UNMEASURED)
		end
	end
	-- `train class`: the step's zone first, unless a trainer stands by the
	-- player (cost: straight-line seconds here, before the planner's).
	local home = goal.zone
	if home then
		local has = false
		for _, c in ipairs(list) do
			if c.map == home then
				has = true
				break
			end
		end
		if has then
			for _, c in ipairs(list) do
				if c.map ~= home and cost[c] * RUN_SPEED > HOME_NEAR then tier[c] = tier[c] + 4 end
			end
		end
	end
	-- Farm spots whose mobs are too high go, unless nothing else is left:
	-- then the smallest level gap first.
	if farm and reasonable then
		local kept = {}
		for _, c in ipairs(list) do
			if gap[c] < TOO_HIGH then kept[#kept + 1] = c end
		end
		list = kept
	end
	local function better(a, b)
		if tier[a] ~= tier[b] then return tier[a] < tier[b] end
		if not reasonable and gap[a] ~= gap[b] then return gap[a] < gap[b] end
		return cost[a] + extra[a] + order[a] < cost[b] + extra[b] + order[b]
	end
	table.sort(list, better)
	if here then
		for k = 1, math.min(PLANNED, #list) do
			local c = list[k]
			local s = ns.TravelCost(here, c)
			if s then cost[c] = s end
		end
		table.sort(list, better)
	end
	p = { list = list, i = #list > 0 and 1 or 0, gen = contextGen, tier = tier }
	picks[goal] = p
	return p
end

-- The chosen candidate of a goal, or nil (no candidates, or none usable).
local function chosen(goal)
	if not goal.candidates then return nil end
	local p = pickFor(goal)
	return p.list[p.i]
end

-- The NPC a goal is done with (the chosen candidate's, if any), named in
-- the client's language where Polestar.Names has it.
local function npcOf(goal)
	local c = chosen(goal)
	local npc, name
	if c then npc, name = c.npc, c.npcName else npc, name = goal.npc, goal.npcName end
	return npc, name and (ns.Names.Npc(npc) or name)
end

---------------------------------------------------------------------------
-- Spawn areas: `spots` on a goal are the places its target (mobs, objects,
-- an NPC) spawns ({ x, y, r, n, alt } in the goal's map and frame, r in
-- yards). Distances are to an area's edge (0 inside). Re-picked by the
-- arrival poll while the waypoint's goal has spots. One table (Lua 5.1 caps
-- a chunk at 200 locals).
--
-- Camps: the spot nearest the player; another takes over only once it is
-- Spots.SWITCH yards nearer, so standing between two camps never flaps.
-- Area objectives (`spread`): the player searches spot by spot. A spot is
-- visited once the player has been within its arrival radius; the current
-- spot stays while the player is within LEAVE yards of it, then the nearest
-- spot not visited for FORGET seconds takes over (all visited: the one
-- visited longest ago), so a circuit forms. CycleSpot moves on by hand (or
-- to a given spot); a spot picked that way holds until reached.
-- Dwell (Fitz, 2026-11-09: the arrow cycles a step's places by itself): a
-- camp or searched spot the player has stood in for Spots.DWELL seconds
-- (moving at most Spots.STILL yards), out of combat and with no progress on
-- its goal, and with no fight or progress on its ground in the last FORGET
-- seconds (Own.dwelt, Own.workedNear), is left (Spots.left, for FORGET
-- seconds): the arrow moves on to the nearest place not left (repick
-- "dwell"), never back to one left while another is open; with every place
-- left, the one left longest ago. Work at a left place later brings it back,
-- and ground worked lately counts as visited unless the player is on it. A step's other field
-- goals measure without left places (Own.fieldDistance), so a goal whose
-- places are all left gives way to the nearest other one.
-- Alternatives (`alt`): other places the target spawns. The automatic picks
-- above never choose one; moving on by hand walks them too, so every place
-- is reachable, and one picked that way holds like any other current spot.
-- Levels (`lvl`: the highest level of the mobs spawning in a kill or collect
-- goal's spot, #827; else the goal's `lvl`, the one most of its spots share): while
-- the goal has a spot whose mobs are at most Spots.ABOVE levels above the
-- player, the automatic picks leave the higher ones as they leave
-- alternatives (a level-12 player searching the Harvester Gyrostabilizer's
-- fields meets the Golems and Watchers, not the Reapers); with none at the
-- player's level, every spot counts as before.
---------------------------------------------------------------------------

local Spots = {
	SWITCH = 40, -- yards
	LEAVE = 4, -- yards past the arrival radius
	FORGET = 300, -- seconds a visited spot is skipped
	ABOVE = 1, -- levels above the player a spot's mobs may be
	DWELL = 7, -- seconds in a place with no progress before the arrow moves on
	STILL = 10, -- yards the player may move while a dwell is counted
	chosen = setmetatable({}, { __mode = "k" }), -- goal -> chosen spot
	pinned = setmetatable({}, { __mode = "k" }), -- goal -> spot picked by hand, until reached
	seen = setmetatable({}, { __mode = "k" }), -- spot -> GetTime() of the last visit
	left = setmetatable({}, { __mode = "k" }), -- spot (or a point goal) -> GetTime() it was left after a dwell
	stay = setmetatable({}, { __mode = "k" }), -- goal -> { place, since, sign }: the dwell being counted
	work = {}, -- the last WORK_KEEP places the player fought or made progress at: { c, x, y, t } (Spots.noteWork)
	WORK_KEEP = 16,
	WORK_SAME = 20, -- yards: a fight this close to the last one updates it
	SETTLE = 5, -- seconds after a fight or progress the automatic picks hold
	lastWork = -1e9, -- GetTime() of the last work noted (none yet: long ago)
	world = setmetatable({}, { __mode = "k" }), -- spot -> { c, wx, wy } | false
}

-- Whether a place of goal (a spot, or the goal itself at its point) was left
-- after a dwell within FORGET seconds, and not worked inside since: a fight
-- or progress within it after leaving it brings it back (ArrowGuard's grind
-- sweep: a camp left on arrival, then fought in for ten minutes). Work on its
-- fringe does not: it flipped the arrow between two goals' places sharing
-- ground (ArrowGuard's replay, the Mirage Raceway).
function Spots.isLeft(goal, place, now)
	now = now or GetTime()
	local t = Spots.left[place]
	if not t or now - t > Spots.FORGET then return false end
	local w = Own.workedNear(goal, place, now, true)
	return not (w and w > t)
end

-- The automatic picks hold (no spot or goal change) while the player fights
-- and for Spots.SETTLE seconds after a fight or progress: the arrow never
-- moves under a fight or right after a kill (ArrowGuard's replay).
function Spots.busy(now)
	if UnitAffectingCombat and UnitAffectingCombat("player") then return true end
	return (now or GetTime()) - Spots.lastWork <= Spots.SETTLE
end

-- Where the player worked (a fight, progress on the waypoint's goal): kept by
-- position, not by place, so the ground counts for every goal whose places lie
-- there (two goals' spots on the same camp; ArrowGuard's replay). The nearest
-- entry within WORK_SAME yards is updated, else the oldest of WORK_KEEP reused.
function Spots.noteWork(c, x, y, now)
	Spots.lastWork = now
	local list, oldest, oldT = Spots.work, nil, nil
	for i = 1, #list do
		local e = list[i]
		if e.c == c and (e.x - x) ^ 2 + (e.y - y) ^ 2 <= Spots.WORK_SAME * Spots.WORK_SAME then
			e.x, e.y, e.t = x, y, now
			return
		end
		if not oldT or e.t < oldT then oldest, oldT = e, e.t end
	end
	if #list < Spots.WORK_KEEP then
		list[#list + 1] = { c = c, x = x, y = y, t = now }
	else
		oldest.c, oldest.x, oldest.y, oldest.t = c, x, y, now
	end
end

-- Yards from the player to a spot's centre, nil on another continent.
function Spots.dist(goal, s, c, px, py)
	local w = Spots.world[s]
	if w == nil then
		local sc, wx, wy = Compat().MapToWorld(goal.map, s.x, s.y, goal.f)
		w = sc and { sc, wx, wy } or false
		Spots.world[s] = w
	end
	if not (w and w[1] == c) then return nil end
	return ((w[2] - px) ^ 2 + (w[3] - py) ^ 2) ^ 0.5
end

-- Yards from the player to a spot's edge (0 inside), nil on another continent.
function Spots.edge(goal, s, c, px, py)
	local d = Spots.dist(goal, s, c, px, py)
	if not d then return nil end
	d = d - (s.r or 0)
	return d > 0 and d or 0
end

-- The highest spot level the automatic picks take for the goal (the
-- player's level + ABOVE) while it has a spot (not an alternative) at or
-- below it and one above it; nil: every spot. A spot's level is its own
-- `lvl`, else the goal's.
function Spots.cap(goal)
	local top = player and player.level and player.level + Spots.ABOVE
	if not top then return nil end
	local lvl, low, high = goal.lvl, false, false
	for _, s in ipairs(goal.spots) do
		if not s.alt then
			local l = s.lvl or lvl
			if l and l > top then high = true else low = true end
			if low and high then return top end
		end
	end
	return nil
end

-- Re-pick a goal's spot from the player's world position (c nil: unknown).
-- moveOn: leave the current spot: true by hand (CycleSpot marked it visited
-- first; alternatives and spots above the player count), "dwell" after a
-- dwell (Own.dwelt left it; the automatic picks' rules hold); spots visited
-- lately are then skipped for camps too, so moving on walks them all. A spot
-- left after a dwell is never fresh within FORGET. True if the spot changed.
function Spots.repick(goal, c, px, py, moveOn)
	local now, spread, reach = GetTime(), goal.spread, goal.r or DEFAULT_RADIUS
	local spots = goal.spots
	local cur = Spots.chosen[goal]
	local manual = moveOn == true
	local cap = not manual and Spots.cap(goal)
	local lvl = goal.lvl
	if cur and not c and not moveOn then return false end
	if cur and not moveOn and Spots.busy(now) then return false end
	local curD = cur and c and Spots.edge(goal, cur, c, px, py)
	-- On another continent nothing is measurable: the spot holds (ranking by
	-- list order alone would walk to the next spot at every poll).
	if cur and not curD and not moveOn then return false end
	if c and spread then
		for _, s in ipairs(spots) do
			local d = Spots.edge(goal, s, c, px, py)
			if d and d <= reach then Spots.seen[s] = now end
		end
	end
	if not moveOn and cur then
		if Spots.pinned[goal] == cur then
			if not (curD and curD <= reach) then return false end
			Spots.pinned[goal] = nil
		end
		if spread and curD and curD <= reach + Spots.LEAVE then return false end
	end
	-- Not visited lately; the spot the player stands in counts as fresh too
	-- (search it now), unless moving on.
	local function fresh(s)
		if Spots.isLeft(goal, s, now) then return false end
		-- Ground worked lately (a camp cleared) counts as visited unless the
		-- player is on it, where it holds; moving on after a dwell, always.
		if Own.workedNear(goal, s, now) then
			local d = not moveOn and c and Spots.edge(goal, s, c, px, py)
			if not (d and d <= reach + Spots.SWITCH) then return false end
		end
		local t = (spread or moveOn) and Spots.seen[s]
		if not t or now - t > Spots.FORGET then return true end
		if moveOn or not c then return false end
		local d = Spots.edge(goal, s, c, px, py)
		return d ~= nil and d <= reach
	end
	-- Nearest fresh spot (unknown distances rank after known ones, in order
	-- from the current spot); with none fresh, the one visited longest ago.
	local at = 0
	for i, s in ipairs(spots) do
		if s == cur then at = i end
	end
	local best, bestKey, old, oldT
	for i, s in ipairs(spots) do
		if not (moveOn and s == cur) and (manual or not s.alt) and not (cap and (s.lvl or lvl or 0) > cap) then
			if fresh(s) then
				local d = c and Spots.edge(goal, s, c, px, py)
				local key = d or (1e9 + (i - at - 1) % #spots)
				if not bestKey or key < bestKey then best, bestKey = s, key end
			else
				local t = Spots.seen[s] or Own.workedNear(goal, s, now) or 0
				if not oldT or t < oldT then old, oldT = s, t end
			end
		end
	end
	best = best or old
	local new = cur
	if best and (moveOn or not cur or not fresh(cur) or not curD or bestKey < curD - Spots.SWITCH or (cap and (cur.lvl or lvl or 0) > cap)) then new = best end
	new = new or spots[1]
	if new == cur then return false end
	Spots.chosen[goal] = new
	return true
end

-- The goal's spot, picked from where the player stands on first use.
function Spots.get(goal)
	if not Spots.chosen[goal] then Spots.repick(goal, Compat().GetPlayerWorldPosition()) end
	return Spots.chosen[goal]
end

-- Position of the goal's spot in goal.spots.
function Spots.index(goal)
	local s = Spots.get(goal)
	for i, t in ipairs(goal.spots) do
		if t == s then return i end
	end
end

-- The active tab's waypoint goal when it has spots, else nil.
function Spots.waypointGoal()
	if not (waypoint and guide and current and waypoint.stepIndex == current) then return nil end
	local goal = guide.steps[current].goals[waypoint.goalIndex]
	return goal and goal.spots and goal or nil
end

-- map, x, y, f of the goal (the chosen candidate's when it has candidates,
-- the chosen spawn area's when it has spots), then that area's radius in
-- yards, then the height `z` there (the compiler's, from the spawn of the
-- NPC or object it stands for): the candidate's or spawn area's own, else the
-- goal's while the position is the goal's own point.
local function posOf(goal)
	local c = chosen(goal)
	if c then return c.map, c.x, c.y, c.f, nil, c.z end
	local s = goal.spots and Spots.get(goal)
	if s then return goal.map, s.x, s.y, goal.f, s.r, s.z or (s.x == goal.x and s.y == goal.y and goal.z) or nil end
	return goal.map, goal.x, goal.y, goal.f, nil, goal.z
end

-- One of the goal's candidates, and, for a candidate that names the classes
-- it serves (class trainers), one for the character's class.
local function isCandidate(goal, npc)
	for _, c in ipairs(goal.candidates) do
		if c.npc == npc then
			if type(c.classes) ~= "table" or not player then return true end
			for _, cls in ipairs(c.classes) do
				if cls == player.class then return true end
			end
		end
	end
	return false
end

-- Whether `npc` is an innkeeper a `sethome` goal binds at: a located goal's
-- inn's (goal.npc, else the innkeeper of the inn its location names, in
-- Nav/Travel.lua's data); `sethome nearest`, one of its candidates. The
-- latch below and QoL's bind helper both ask this.
function Engine.IsSethomeInnkeeper(goal, npc)
	if not (npc and type(goal) == "table" and goal.t == "sethome") then return false end
	if not goal.location then return goal.candidates ~= nil and isCandidate(goal, npc) end
	local nav = ns.Nav
	local inn = nav and nav.FindInn and nav.FindInn(goal.npc, goal.location)
	return npc == (inn and inn.npc or goal.npc)
end

-- Goals whose live condition can stop holding after the step is passed
-- (leaving the zone, rebinding, selling the items, walking away). Their done
-- state is stored once the route moves past them, so the guide never jumps
-- back; quest goals stay live on purpose (abandoning reopens the step once
-- the player says to go back for it: Own.holdLost), but an `abandon` is
-- kept, or taking the quest again would reopen it.
local function latchable(goal)
	local t = goal.t
	return t == "goto" or t == "explore" or t == "die" or t == "sethome" or t == "hearth" or t == "fly" or t == "getfp" or t == "enter"
		or t == "buy" or (t == "collect" and (not goal.quest or Own.bagCollect(goal))) or (t == "craft" and craftMode(goal) == "count")
		or (t == "train" and goal.class == true) or t == "money" or t == "destroy" or t == "wait" or t == "abandon"
end

-- Check-offs and latched results share CharState().manual[guideId]["s:g"].
local function checked(s, g)
	local m = ns.CharState().manual[guide.id]
	return m ~= nil and m[Own.key(s, g)] and true or false
end

-- The client's word for a standing (ns.StandingName), else its number.
local function standingName(n)
	return ns.StandingName(n) or tostring(n)
end

-- A skill goal's profession or skill in the client's language: the client's
-- skill-line name (by goal.skillLine, or the line of its English name), else
-- its English name through L (a Lookup.PROFESSIONS key, or "Riding"), or
-- "first aid" -> "First Aid" for goals that only carry a skill line ID.
local skillNames
local function skillName(goal)
	local C = Compat()
	local line = goal.skillLine or (goal.skill and C.SKILL_LINES and C.SKILL_LINES[goal.skill:lower()])
	local client = line and C.GetSkillLineName and C.GetSkillLineName(line)
	if client then return client end
	if goal.skill then return L[goal.skill] end
	if not skillNames then
		skillNames = {}
		for name, id in pairs(C.SKILL_LINES or {}) do
			skillNames[id] = name:gsub("(%a)(%w*)", function(a, b) return a:upper() .. b end)
		end
	end
	local name = goal.skillLine and skillNames[goal.skillLine]
	return name and L[name] or nil
end

local function skillRank(goal)
	local C = Compat()
	if not C.GetSkillRank then return nil end
	local rank = goal.skillLine and C.GetSkillRank(goal.skillLine)
	if not rank and goal.skill then rank = C.GetSkillRank(goal.skill) end
	return rank
end

-- Live-frame percent of an explore goal (Era coordinates converted once).
local livePos = setmetatable({}, { __mode = "k" })
local function liveXY(goal)
	if not goal.f then return goal.x, goal.y end
	local p = livePos[goal]
	if p == nil then
		p = false
		local C = Compat()
		local c, wx, wy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if c then
			local x, y = C.WorldToMap(c, wx, wy, goal.map)
			if x then p = { x, y } end
		end
		livePos[goal] = p
	end
	if not p then return nil end
	return p[1], p[2]
end

---------------------------------------------------------------------------
-- Done rules (contract table "Goal fields")
---------------------------------------------------------------------------

local goalDone

-- The quest-log line an objective goal reads (#223, #279, #335). The game
-- does not always list a quest's objectives in the order the guide was
-- compiled with: Slimy Menace counts Murlocs first where the quest data
-- lists Murloc Streamrunners first, so `oi` alone read the other
-- objective's count and ticked the other line. With more than one line: the
-- line labelled with the goal's target (its NPC, item or object, in the
-- client's language where Polestar.Names has it) wins, else the line holding
-- that name with the least else in its label ("Murloc" never takes "Murloc
-- Streamrunner slain"), the compiled `oi` among equals; with no name, or no
-- line holding it (a label not filled in yet, another language), `oi` as
-- compiled. (On Own: the main chunk is at 200 locals.)
Own.OBJECTIVE_NAME = {
	kill = function(g, N) return N.Npc(g.npc) or g.target end,
	collect = function(g, N) return N.Item(g.item) or g.itemName end,
	interact = function(g, N) return N.Object(g.object) or g.objName end,
}
function Own.objectiveLine(goal, objs)
	local oi = goal.oi
	local nameOf = #objs > 1 and Own.OBJECTIVE_NAME[goal.t]
	local name = nameOf and nameOf(goal, ns.Names)
	if type(name) ~= "string" or name == "" then return oi end
	local label = Compat().ObjectiveLabel
	local best, bestScore
	for k = 1, #objs do
		local l = label(objs[k].text)
		local score
		if l == name then
			score = 0
		elseif l ~= "" and l:find(name, 1, true) then
			score = #l - #name
		end
		if score and (not bestScore or score < bestScore or (score == bestScore and k == oi)) then
			best, bestScore = k, score
		end
	end
	return best or oi
end

-- The quest-log line (an index into Compat.GetQuestObjectives) objective goal
-- `goal` reads, as Own.objectiveLine picks it; its `oi` while the quest is not in
-- the log. Party sync reads members' counts by it: theirs come in the same
-- game order. Nil for a goal that counts the bags (Own.bagCollect): no line
-- counts its item.
function Engine.ObjectiveLine(goal)
	if type(goal) ~= "table" or not goal.quest or not goal.oi then return goal and goal.oi end
	if Own.bagCollect(goal) then return nil end
	local objs = Compat().GetQuestObjectives(goal.quest)
	return objs and Own.objectiveLine(goal, objs) or goal.oi
end

-- Whether quest `collect` goal `goal` counts the bags: the quest uses its
-- item without asking for it (QuestDB.UsesOnly), so no quest-log line counts
-- it, whichever line the goal was bound to (#538: a pack's Sunscale Feather
-- on "Blue Raptor Nest visited", its Fresh Zhevra Carcass on "Ishamuhale's
-- Fang"). Without the quest database (every quest feature off) the goal
-- reads its line. (On Own: the main chunk is at 200 locals.)
function Own.bagCollect(goal)
	if goal.t ~= "collect" or not goal.quest or not goal.item then return false end
	local Q = ns.QuestDB
	return Q and Q.IsLoaded() and Q.UsesOnly(goal.quest, goal.item) or false
end

-- Objective goals: done when objective `oi` (its line, Own.objectiveLine) is
-- finished or the quest is ready for turn-in or turned in. Returns done, cur, max.
local function objectiveState(goal)
	local q = goal.quest
	if questDone(q) then return true end
	local C = Compat()
	if not C.IsOnQuest(q) then return false end
	local cur, max, finished
	if goal.oi then
		local objs = C.GetQuestObjectives(q)
		-- No objectives at all while the quest is in the log: the client has
		-- not filled them in yet (right after the accept), and its ready flag
		-- says nothing until it has.
		if not objs then return false end
		local o = objs[Own.objectiveLine(goal, objs)]
		if o then cur, max, finished = o.numFulfilled, o.numRequired, o.finished end
	end
	if C.IsQuestReadyForTurnIn(q) then return true, cur, max end
	return finished and true or false, cur, max
end

-- Whether talking to a quest `talk` goal's NPC checks it off (latch). The
-- client reveals such lines one at a time (Desperate Times: Valennia, then
-- the Windshapers, then the High Order, each listed once the line before it
-- is done): the talk counts only while the quest is in the log, the client
-- lists no line `oi` yet and every line before it is finished. While the
-- client lists the line, the line decides (goalDone): a talk out of order,
-- which the game does not count, does not tick it. Without `oi` the talk
-- counts. (On Own: the main chunk is at 200 locals.)
function Own.talkCounts(goal)
	local q, oi = goal.quest, goal.oi
	if not (q and oi) then return true end
	local C = Compat()
	if not C.IsOnQuest(q) then return false end
	local objs = C.GetQuestObjectives(q)
	if not objs or objs[oi] then return false end
	for k = 1, oi - 1 do
		if not (objs[k] and objs[k].finished) then return false end
	end
	return true
end

-- A `complete` goal's quest in the log: its objectives' counts summed, each
-- capped at what it needs ("Plainstrider Meat 3/7, Feathers 5/7": 8/14), the
-- goal's progress (the window shows each line: Own.objectiveLines). Nil when
-- the quest is not in the log. (On Own: the main chunk is at 200 locals.)
function Own.completeState(q)
	local objs = Compat().GetQuestObjectives(q)
	if not objs then return nil end
	local cur, max = 0, 0
	for i = 1, #objs do
		local o = objs[i]
		max = max + o.numRequired
		cur = cur + math.min(o.numFulfilled, o.numRequired)
	end
	return cur, max
end

-- What a `complete` goal reads as (#942: "Complete Plagued Lands" said
-- nothing): its quest's objectives, { text, cur, max } each, in the game's
-- words from the log, the counts cut off the text (Compat.ObjectiveLabel:
-- "Rabid Thistle Bear Captured: 0/1" -> "Rabid Thistle Bear Captured", 0,
-- 1). With the quest not in the log (looked at ahead), the compiled
-- objectives (`objs`: the quest data's text and count), at 0, or every one
-- in once the goal is done; nil with neither (the window keeps "Complete
-- <quest>"). The compiled text is the data's English: a translated client
-- reads each as the name of what it counts (Own.objectiveName), and keeps
-- "Complete <quest>" in its own words when one has no name to give.
function Own.objectiveLines(goal, done)
	local C, out = Compat(), {}
	for _, o in ipairs(C.GetQuestObjectives(goal.quest) or NONE) do
		local text = C.ObjectiveLabel(o.text)
		if text ~= "" then out[#out + 1] = { text = text, cur = math.min(o.numFulfilled, o.numRequired), max = o.numRequired } end
	end
	if #out > 0 then return out end
	local translated = ns.Names.Localised()
	for _, o in ipairs(type(goal.objs) == "table" and goal.objs or NONE) do
		if type(o.text) == "string" and o.text ~= "" then
			local text = o.text
			if translated then
				text = Own.objectiveName(goal.quest, text)
				if not text then return nil end
			end
			local max = tonumber(o.count) or 1
			out[#out + 1] = { text = text, cur = done and max or 0, max = max }
		end
	end
	return #out > 0 and out or nil
end

-- The client's name for objective `text` (the quest data's English) of quest
-- q: the Codex's objective of q with that text, named by what it counts, its
-- NPC, item or object (Polestar.Names). Nil for an event ("Sit near the
-- campfire": no name to give), a name the client lacks, or without the Codex.
Own.OBJECTIVE_NAMES = { kill = "Npc", item = "Item", object = "Object" }
function Own.objectiveName(q, text)
	local X = ns.Codex
	local rec = X and X.Quest and X.Quest(q)
	for _, o in ipairs(rec and rec.objectives or NONE) do
		if o.text == text then
			local kind = Own.OBJECTIVE_NAMES[o.type]
			return kind and o.id and ns.Names[kind](o.id) or nil
		end
	end
	return nil
end

-- The name of the item a `complete` goal's quest hands over (`startItem`,
-- the compiler's from the quest data: Tharnariun's Hope for Plagued Lands)
-- while it is in the bags and usable: the window says "Use <item>:" first.
function Own.useItemName(goal)
	local id = goal.startItem
	if not id then return nil end
	local C = Compat()
	if (C.GetItemCount(id) or 0) <= 0 or not C.ItemUsable(id) then return nil end
	return ns.Names.Item(id) or goal.startItemName
end

local function countState(goal)
	local need = goal.count or 1
	local have = Compat().GetItemCount(goal.item)
	return have >= need, have < need and have or need, need
end

-- done, cur, max, label, kind of a skill-rank target.
local function skillState(goal, target)
	local rank = skillRank(goal) or 0
	return rank >= target, rank < target and rank or target, target, skillName(goal), "skill"
end

local function repState(goal)
	local fn = Compat().GetFactionStanding
	if not fn then return false end
	local standing, value, barMin, barMax = fn(goal.faction)
	if not standing then return false end
	local done = standing >= goal.standing
	if barMax and barMin and barMax > barMin then
		return done, (value or barMin) - barMin, barMax - barMin, standingName(standing), "rep"
	end
	return done
end

local function achieveState(goal)
	local fn = Compat().GetAchievement
	local a = fn and fn(goal.achievement)
	if not a then return false end
	local list = a.criteria or {}
	if goal.criteria then
		local c = list[goal.criteria]
		if not c then return a.completed end
		return a.completed or c.completed, c.cur, c.max, nil, "count"
	end
	if #list == 1 then return a.completed, list[1].cur, list[1].max, nil, "count" end
	if #list == 0 then return a.completed end
	local n = 0
	for i = 1, #list do
		if list[i].completed then n = n + 1 end
	end
	return a.completed, n, #list, nil, "count"
end

local function exploredAt(goal)
	local fn = Compat().IsAreaExploredAt
	if not fn then return false end
	local x, y = liveXY(goal)
	return x and fn(goal.map, x, y) or false
end

-- Whether bag-count collect g of step s gets the one item that starts a
-- quest: the next `accept Q item I` of that item in the step, before any
-- other collect of it (the pairing GetStepView folds into one line), and that
-- quest is in the log or done. Accepting uses the item up, and a player who
-- took the quest before the route reached the step never held it there
-- (#309). (On Own: the main chunk is at 200 locals.)
function Own.starterTaken(s, g, goal)
	if (goal.count or 1) ~= 1 then return false end
	local goals = guide.steps[s].goals
	for j = g + 1, #goals do
		local a = goals[j]
		if a.item == goal.item then
			if a.t == "collect" and not a.quest then return false end
			if a.t == "accept" and not a.npc and not a.object and goalApplies(a) then
				local C = Compat()
				return C.IsOnQuest(a.quest) or questDone(a.quest) or false
			end
		end
	end
	return false
end

-- Whether the guide abandoned quest q after step s (an `abandon` goal latched,
-- or the live route is at or past one and the quest is out of the log; a step
-- the player only looks at does not count). An accept at step s then stays
-- done, so the route does not go back to the giver; a player's own abandon
-- still reopens it, and an accept after the abandon (taking it again) is not
-- done by it.
function Own.abandonedByGuide(q, s)
	local list = layoutOf(guide).abandons[q]
	if not list then return false end
	local m = ns.CharState().manual[guide.id]
	for _, a in ipairs(list) do
		if a.s >= s then
			if m and m[a.key] == true then return true end
			if computed and a.s <= computed and not Compat().IsOnQuest(q) then return true end
		end
	end
	return false
end

-- Quests that left the log after the route had passed their accept, held
-- until the player answers (Engine.LostQuestion): per character, per guide,
-- quest id -> the live step when it left (CharState().lostQuests). Such an
-- accept before that step reads done, so the live step stays where it was
-- instead of jumping back to the giver unasked.
function Own.lostHeld(q, s)
	local all = ns.CharState().lostQuests
	local mine = all and guide and all[guide.id]
	local upTo = mine and mine[q]
	return upTo ~= nil and s < upTo
end

-- A goal of a quest held that way, other than its accept (#1365): its kills,
-- collects and turn-in cannot be done without the quest, so while the window
-- asks they read as skipped (greyed, never the current goal, the arrow's or
-- a map pin's) without being skipped: the step still waits on them, and the
-- arrow leads back to the giver (Own.lostAim). Taking the quest again, or an
-- answer, ends the hold and brings them back. So does a quest in the log
-- that failed (an escort lost, a timer run out: Own.failedQuest): its goals
-- cannot be done until it is abandoned and taken again, so they are greyed
-- with "failed: abandon it and take it again" and the arrow leads to its
-- giver; the step waits as before.
function Own.lostGoal(goal)
	local q = goal.quest
	if not q or goal.t == "accept" then return false end
	if Own.failedQuest(q) then return true end
	local all = ns.CharState().lostQuests
	local mine = all and guide and all[guide.id]
	return mine ~= nil and mine[q] ~= nil
end

-- Whether quest q is in the log and failed. Noted (Own.wasFailed) so that
-- abandoning it to take it again sends the route back to its giver without
-- asking (Own.holdLost): that is what the failed line told the player to do.
Own.wasFailed = {}
function Own.failedQuest(q)
	if not Compat().IsQuestFailed(q) then return false end
	Own.wasFailed[q] = true
	return true
end

-- Whether a later, non-optional quest goal of step s (after goal g) that
-- applies to the character is done: the work a goal led to is behind the
-- player. (On Own: the main chunk is at 200 locals.)
function Own.laterQuestDone(s, g)
	local goals = guide.steps[s].goals
	for j = g + 1, #goals do
		local later = goals[j]
		local lt = later.t
		-- A quest goal (isQuestGoal, declared further down).
		local quest = later.quest and (lt == "accept" or lt == "turnin" or lt == "complete" or lt == "kill"
			or lt == "collect" or lt == "interact" or lt == "use" or lt == "talk")
		if quest and not later.optional and goalApplies(later) and goalDone(s, j, later) then return true end
	end
	return false
end

-- done, cur, max[, label, kind] for goal g of step s. Notes are never done
-- (and never block). A stored check-off (the player's tick, or a result the
-- Engine latched) is done whatever the live state says, as is a goal the
-- catch-up passed for the session (Own.passedNow); but an accept is done
-- only by the quest log (in it, completed, abandoned by the guide, or held
-- after it left the log: Own.lostHeld): a tick
-- on it never stands for the quest (#739), and its view says the quest is
-- not in the log (`notInLog`).
goalDone = function(s, g, goal)
	local t = goal.t
	local C = Compat()
	if t ~= "accept" and checked(s, g) then return true end
	local now = Own.passedNow[guide.id]
	if now and now[Own.key(s, g)] then return true end
	if t == "accept" then
		return C.IsOnQuest(goal.quest) or questDone(goal.quest) or Own.abandonedByGuide(goal.quest, s) or Own.lostHeld(goal.quest, s)
	elseif t == "turnin" then
		-- `direct`: only its latched QUEST_TURNED_IN (checked above), the
		-- completed flag, or a later quest goal of its step done (the Tome of
		-- Divinity handed back before the book's own quest: a hand-in from
		-- before the goal was `direct` is never flagged, so a Paladin who had
		-- done the chain was sent back to it). The session's turn-ins would
		-- close every later goal of a repeatable at the first hand-in; one
		-- hand-in closes one goal.
		if goal.direct then return (C.IsQuestCompleted(goal.quest) or Own.laterQuestDone(s, g)) and true or false end
		return questDone(goal.quest) and true or false
	elseif t == "complete" then
		if questDone(goal.quest) or C.IsQuestReadyForTurnIn(goal.quest) then return true end
		local cur, max = Own.completeState(goal.quest)
		return false, cur, max
	elseif t == "kill" or t == "interact" or t == "use" then
		if goal.quest then return objectiveState(goal) end
		-- One with no quest (the Runes of Summoning before the voidwalker,
		-- #1120): done once a later quest goal of the step is, so the work it
		-- led to, done or handed in, never leaves it holding the step.
		return Own.laterQuestDone(s, g)
	elseif t == "collect" then
		if goal.quest then
			if not (Own.bagCollect(goal) and C.IsOnQuest(goal.quest)) then return objectiveState(goal) end
			if C.IsQuestReadyForTurnIn(goal.quest) then return true end
			return countState(goal)
		end
		if Own.starterTaken(s, g, goal) then return true end
		return countState(goal)
	elseif t == "buy" then
		return countState(goal)
	elseif t == "goto" then
		if arrived[goal] then return true end
		-- Done once any later goal of the step is. A later goto counts by its
		-- own arrival or check-off only: whatever would make it done through
		-- its own later goals is scanned here already (recursing would make a
		-- step of n waypoints cost 2^n checks).
		local goals = guide.steps[s].goals
		local leads = true -- nothing but gotos after it: it leads into the next step
		for j = g + 1, #goals do
			local later = goals[j]
			if later.t == "goto" then
				if (arrived[later] or checked(s, j)) and goalApplies(later) then return true end
			elseif later.t ~= "note" and goalApplies(later) then
				if goalDone(s, j, later) then return true end
				leads = false
			end
		end
		-- The way into the next step (a cave's mouth, a dock): done once that
		-- step's quest work is, so work done ahead of the guide never sends the
		-- player back to the way in (#240). A goto with optional work after it
		-- is where that work is, and holds.
		return leads and Own.nextStepDone(s) or false
	elseif t == "train" and isProfessionTrain(goal) then
		-- Done once the profession's max rank reaches this rank's cap, at
		-- whichever trainer.
		local fn = C.GetSkillRank
		local _, maxRank = fn(goal.skillLine or goal.skill)
		if not maxRank and goal.skillLine and goal.skill then _, maxRank = fn(goal.skill) end
		return (maxRank or 0) >= rankCap(goal)
	elseif t == "train" and goal.class and Own.nothingToTrain() then
		return true
	elseif t == "talk" and goal.quest then
		-- The quest's objective: its line (`oi`), the ready flag or the
		-- hand-in; a talk on a line the client does not list yet is latched
		-- (Own.talkCounts).
		return objectiveState(goal)
	elseif t == "talk" or t == "train" or t == "vendor" then
		-- Interactions during the step are stored as check-offs (see latch).
		return false
	elseif t == "task" then
		-- Done only by the player's tick (checked above).
		return false
	elseif t == "wait" then
		-- Its countdown starts once the goals before it are done (Own.startWaits).
		local secs = tonumber(goal.seconds) or 0
		local at = Own.waitStart[goal]
		if not at then return false, secs, secs, nil, "wait" end
		local left = secs - (GetTime() - at)
		if left <= 0 then return true end
		return false, math.ceil(left), secs, nil, "wait"
	elseif t == "abandon" then
		return not C.IsOnQuest(goal.quest)
	elseif t == "destroy" then
		return (C.GetItemCount(goal.item) or 0) == 0
	elseif t == "money" then
		return C.GetMoney() >= (goal.money or 0)
	elseif t == "sethome" then
		-- `sethome nearest` has no location: binding during the step latches it.
		if not goal.location then return false end
		-- Bound at the goal's inn (its innkeeper, else the inn its location
		-- names, in Nav/Travel.lua's data) by any of: the inn Travel finds for
		-- the bind location (the innkeeper learned at bind time, else the inn
		-- whose area the client names so, else its English names); the bind
		-- location reading as that inn's or the goal's area in the client's
		-- language; last, as its English location.
		local nav = ns.Nav
		local want = nav and nav.FindInn and nav.FindInn(goal.npc, goal.location)
		if want and nav.BoundInn and nav.BoundInn() == want then return true end
		local loc, areaName = C.GetBindLocation(), C.GetAreaName
		if areaName and (same(loc, areaName(want and want.area)) or same(loc, areaName(goal.area))) then return true end
		return same(loc, goal.location)
	elseif t == "enter" then
		-- In the zone or area: its zone or subzone text (inPlace), on the
		-- ground: a taxi passing over it is not there, landing in it is.
		return inPlace(goal) and not C.IsOnTaxi()
	elseif t == "hearth" or t == "fly" then
		-- A hearth is done in its place however the player got there (a flight
		-- that lands in the town counts), but only on the ground: a taxi passing
		-- over the town on its way elsewhere is not there.
		if (inPlace(goal) and (t == "fly" or not C.IsOnTaxi())) or (t == "fly" and Own.landingReached(goal)) then return true end
		-- Done once any later goal of the step is, like goto: a hearth followed
		-- by a flight is behind the player once the flight lands. Later travel
		-- goals count by their own place or check-off only (no recursion).
		local goals = guide.steps[s].goals
		for j = g + 1, #goals do
			local later = goals[j]
			if goalApplies(later) then
				local lt = later.t
				if lt == "hearth" or lt == "fly" then
					if inPlace(later) or checked(s, j) then return true end
				elseif lt == "goto" then
					if arrived[later] or checked(s, j) then return true end
				elseif lt ~= "note" and goalDone(s, j, later) then
					return true
				end
			end
		end
		return false
	elseif t == "getfp" then
		return fpKnown(goal)
	elseif t == "level" then
		return Own.levelReached(goal.level, goal.frac)
	elseif t == "skill" then
		if isManual(goal) then return false end
		return skillState(goal, goal.level)
	elseif t == "cast" then
		return false -- ticked by the cast itself (Own.latchCast) or the player
	elseif t == "learn" then
		if isManual(goal) then return false end
		return C.IsSpellKnown(goal.spell)
	elseif t == "craft" then
		local mode = craftMode(goal)
		if mode == "skill" then return skillState(goal, goal.untilSkill) end
		if mode == "count" then return countState(goal) end
		return false
	elseif t == "rep" then
		if isManual(goal) then return false end
		return repState(goal)
	elseif t == "explore" then
		return arrived[goal] or exploredAt(goal)
	elseif t == "die" then
		return arrived[goal] and true or false
	elseif t == "achieve" then
		if isManual(goal) then return false end
		return achieveState(goal)
	end
	return false -- note
end

local function blocks(goal)
	return goal.t ~= "note" and not goal.optional
end

-- A `vendor` check-off beside other work of its step is a stop on the way,
-- not work of its own: it holds the step only while no other goal that
-- holds it applies to the character. A step of nothing but vendor
-- check-offs still waits for the merchant window (or the player's tick or
-- skip); one with hand-ins beside it is done with them, whether the player
-- sold or not. The line stays listed, and leads the arrow in its turn,
-- while the step is live. (On Own: the main chunk is at Lua's 200 locals.)
function Own.sideVendor(s, goal)
	if goal.t ~= "vendor" then return false end
	for _, other in ipairs(guide.steps[s].goals) do
		if other.t ~= "vendor" and blocks(other) and goalApplies(other) then return true end
	end
	return false
end

-- Whether goal (of step s) holds the step until it is done: not a note,
-- not optional, not a vendor check-off beside other work (Own.sideVendor).
function Own.holds(s, goal)
	return blocks(goal) and not Own.sideVendor(s, goal)
end

-- Every goal of step s that holds the route is done (or cannot be done).
function Own.goalsDone(s)
	local goals = guide.steps[s].goals
	for g = 1, #goals do
		local goal = goals[g]
		if Own.holds(s, goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(s, g, goal) then return false end
	end
	return true
end

local function stepDone(s)
	-- The route passes over an along step (Own.alongListed), a hearth-only
	-- one (Own.hearthOnly: the arrow's route hearths when it pays), a
	-- travel step the route flies past (Own.flightPassed) and a walk to a
	-- stop that holds nothing for the character (Own.stopEmpty).
	if guide.steps[s].along or Own.hearthOnly(guide.steps[s]) then return true end
	if Own.groupPending(guide.steps[s]) then return false end -- waits for the player's answer
	return Own.goalsDone(s) or Own.flightPassed(s) or Own.stopEmpty(s)
end

-- `when done <label>` (format 5): the step so labelled applies and its goals
-- are done, and it was not skipped (by the player, a failed `when` or a
-- `skipto` jump). An along step counts by its own goals. A step whose own
-- `when` asks, through other steps, whether it is done is not (Own.asking).
Own.asking = {}
function Own.labelDone(label)
	local s = guide and Own.marksOf().labels[label]
	if not s or isSkipped(s) or Own.asking[s] then return false end
	Own.asking[s] = true
	local ok = stepApplies(guide.steps[s]) and Own.goalsDone(s)
	Own.asking[s] = nil
	return ok
end

-- Bag-count goals (non-quest buy/collect, count-mode craft, money, abandon,
-- destroy), latched within their own step so using the items up does not
-- reopen it.
local function isBagCount(goal)
	return goal.t == "buy" or (goal.t == "collect" and (not goal.quest or Own.bagCollect(goal)))
		or (goal.t == "craft" and craftMode(goal) == "count") or goal.t == "money"
		or goal.t == "abandon" or goal.t == "destroy"
end

-- Quest goals checked live from the quest log.
local QUEST_VERBS = { accept = true, turnin = true, complete = true }
local function isQuestGoal(goal)
	return goal.quest and (QUEST_VERBS[goal.t] or goal.t == "kill" or goal.t == "collect"
		or goal.t == "interact" or goal.t == "use" or goal.t == "talk")
end

-- Whether the step after s that applies to the character is done with quest
-- work done in it, as anchorStep counts it: a step passed only because its
-- quests are unavailable (their goals are not done then), or with no quest
-- goal (`train`, `level`, travel), is no sign the player went there; nor are
-- class and race steps and goals (`only`), whose quests run on their own
-- schedule (The Islander, taken by a Warrior anywhere, does not put him in
-- Orgrimmar). A step the player skipped vouches for nothing. (On Own: the
-- main chunk is at 200 locals.)
function Own.nextStepDone(s)
	local steps = guide.steps
	local sk = skippedFor(guide.id)
	for n = s + 1, #steps do
		local step = steps[n]
		if stepApplies(step) then
			if step.only or (sk and sk[n]) then return false end
			for g, goal in ipairs(step.goals) do
				if not goal.only and blocks(goal) and isQuestGoal(goal) and goalApplies(goal) and goalDone(n, g, goal) then
					return stepDone(n)
				end
			end
			return false
		end
	end
	return false
end

-- The last step with quest progress in the live quest log, or 0: a done quest
-- goal, or an objective with some progress. The route has demonstrably got
-- that far. Class and race steps and goals (`only`) and optional goals are no
-- evidence: class chains and item-started quests run on their own schedule (a
-- Warlock may finish the succubus chain long before the route reaches it).
-- After an update (`added`, Own.noteAdded), only what the save's guide had
-- in place counts (Own.goalMoved).
local function anchorStep(added)
	local steps = guide.steps
	-- Progress counts only on a quest the guide offers before (or at) that
	-- goal: a quest taken in another guide (or further on in this one) is no
	-- sign of where the player is in this guide. Fitz, 0.3.6: Tincho, a Horde
	-- Warrior at 28.7 carrying Dangerous! (567) from the 22-24 Hillsbrad visit,
	-- was put at Tarren Mill in Hillsbrad 29-32: that quest's done kills at the
	-- Azurelode Mine (step 32) passed the flight to the Crossroads, Orgrimmar,
	-- training and the Undercity, at every load.
	local offered = {}
	for s, step in ipairs(steps) do
		for _, goal in ipairs(step.goals) do
			if goal.t == "accept" and goal.quest and not offered[goal.quest] then offered[goal.quest] = s end
		end
	end
	for s = #steps, 1, -1 do
		local step = steps[s]
		if not step.only then
			for g, goal in ipairs(step.goals) do
				if not goal.only and not goal.optional and isQuestGoal(goal) and goalApplies(goal)
					and (goal.direct or (goal.quest and offered[goal.quest] and offered[goal.quest] <= s))
					and not (added and Own.goalMoved(added, s, goal)) then
					local done, cur = goalDone(s, g, goal)
					if done or (goal.oi and (cur or 0) > 0) then return s end
				end
			end
		end
	end
	return 0
end

-- The catch-up: behind the last quest progress (anchor), the guide leaves out
-- what is too low to be worth going back for, as "Skip grey quests" does for
-- grey quests anywhere: an accept that is green for the character (more than
-- 2 levels below) and not taken yet, unless a quest worth doing needs it first
-- (down the guide and the guides after it). Worth doing: an accept that is
-- not grey, behind the anchor only from yellow up (2 levels below or more). A
-- quest in the log by the same rules ("log"): left out while not done, kept
-- once it only has to be handed in. Only for leveling guides, with "Skip grey
-- quests" on.
function Own.catchUp(anchor, level)
	if guide.maxLevel and level >= guide.maxLevel + 2 then return Own.catchUpPast(level) end
	local out = {}
	if anchor <= 1 then return out end
	local C = Compat()
	local stepOf = layoutOf(guide).stepOf
	local chain = Own.chainOf(guide)
	local function low(goal)
		local qlvl = tonumber(goal.qlvl)
		return qlvl ~= nil and qlvl < level - 2
	end
	local worth = {}
	for _, goal in ipairs(chain.accepts) do
		local s = stepOf[goal]
		local qlvl = tonumber(goal.qlvl)
		if not (qlvl and C.IsQuestTrivial(qlvl, level)) and not (s and s < anchor and low(goal)) then
			worth[#worth + 1] = goal
		end
	end
	local needs = Own.needsFrom(chain.pres, worth)
	local steps = guide.steps
	for s = 1, anchor - 1 do
		if stepApplies(steps[s]) then
			for _, goal in ipairs(steps[s].goals) do
				local q = goal.quest
				if (goal.t == "accept" or goal.direct) and q and not goal.optional and Guides.Matches(goal.only, player)
					and low(goal) and not needs[q] and not questDone(q) then
					if C.IsOnQuest(q) then
						-- In the log: left out until done, kept to hand in.
						if not C.IsQuestReadyForTurnIn(q) then out[q] = "log" end
					elseif not C.IsQuestTrivial(tonumber(goal.qlvl), level) then
						out[q] = true -- grey ones: greyNeed
					end
				end
			end
		end
	end
	return out
end

-- In a guide the character is past (2 levels over its top, as the
-- out-levelled banner counts), going back is a detour: every grey or green
-- accept not taken yet is left out, unless at least CHAIN_WORTH quests from
-- yellow up need it, down the chain (The Tower of Althalaxx at 30: five
-- grey and green quests in Darkshore lead to four at 28 and 31 in
-- Ashenvale, so the chain stays). A quest in the log by the same rules,
-- kept once it only has to be handed in.
Own.CHAIN_WORTH = 3
function Own.catchUpPast(level)
	local C = Compat()
	local chain = Own.chainOf(guide)
	local cache = chainNeedsCache[guide]
	local key = "past:" .. level
	local counts = cache[key]
	if not counts then
		-- For each quest, how many distinct accepts from yellow up need it.
		counts = {}
		local targets = {}
		for _, goal in ipairs(chain.accepts) do
			local qlvl = tonumber(goal.qlvl)
			if qlvl and qlvl >= level - 2 and not targets[goal.quest] then
				targets[goal.quest] = true
				local seen, queue, head = { [goal.quest] = true }, { goal.quest }, 1
				while queue[head] do
					local q = queue[head]
					head = head + 1
					for _, list in ipairs(chain.pres[q] or NONE) do
						for _, p in ipairs(list) do
							if not seen[p] then
								seen[p] = true
								counts[p] = (counts[p] or 0) + 1
								queue[#queue + 1] = p
							end
						end
					end
				end
			end
		end
		cache[key] = counts
	end
	local out = {}
	for _, step in ipairs(guide.steps) do
		if stepApplies(step) then
			for _, goal in ipairs(step.goals) do
				local q, qlvl = goal.quest, tonumber(goal.qlvl)
				if (goal.t == "accept" or goal.direct) and q and qlvl and qlvl < level - 2 and not goal.optional
					and Guides.Matches(goal.only, player) and not questDone(q)
					and (counts[q] or 0) < Own.CHAIN_WORTH then
					if not C.IsOnQuest(q) then
						out[q] = true
					elseif not C.IsQuestReadyForTurnIn(q) then
						out[q] = "log" -- in the log, not done: left out; done, kept to hand in
					end
				end
			end
		end
	end
	return out
end

-- The first step with an accept waiting for the character's level
-- (unavailableFor's "level" mark: the route passes it until then), or nil.
-- A guide that is no leveling guide waits there with nothing else left open
-- (computeCurrent): a dungeon's or an attunement's quest the level-up brings
-- back. A leveling guide finishes past it, as past an accept its giver
-- refused: its end is its last step (Own.noteEnd), not a pickup for later.
function Own.levelHold()
	local steps, sk = guide.steps, skippedFor(guide.id)
	for s = 1, #steps do
		if stepApplies(steps[s]) and not (sk and sk[s]) then
			for g, goal in ipairs(steps[s].goals) do
				if goal.t == "accept" and blocks(goal) and goalApplies(goal) and not goalDone(s, g, goal) then
					local u = unavailableFor(goal)
					if u and u.reason == "level" then return s end
				end
			end
		end
	end
	return nil
end

-- A step of a dungeon run in a leveling guide (`when dungeon`, not negated).
function Own.dungeonStep(step)
	for _, p in ipairs(step.when or NONE) do
		if p.k == "dungeon" and not p.neg then return true end
	end
	return false
end

-- Where the route waits instead of moving on to step s: an accept before s
-- waiting for a level (Own.levelHold) holds a guide that is no leveling
-- guide (a dungeon's pick-up or hand-in, an attunement: its entrance is no
-- place for a character too low for its quests) and a leveling guide's
-- dungeon run. -> step | nil
function Own.holdsBefore(s)
	if not (Own.everyStep(guide) or Own.dungeonStep(guide.steps[s])) then return nil end
	local hold = Own.levelHold()
	return hold and hold < s and hold or nil
end

-- Whether the route waits at step s for its accept waiting on a level, as
-- computeCurrent decides it: s is Own.levelHold with nothing else open on
-- it, no open step comes before it, and the first open step after it is
-- held (Own.holdsBefore: a guide that is no leveling guide, a dungeon run),
-- or none is open and the guide is no leveling guide.
function Own.waitsOnLevel(s)
	if Own.levelHold() ~= s or not stepDone(s) then return false end
	local steps, sk = guide.steps, skippedFor(guide.id)
	for k = 1, #steps do
		if k ~= s and stepApplies(steps[k]) and not (sk and sk[k]) and not stepDone(k) then
			return k > s and (Own.everyStep(guide) or Own.dungeonStep(steps[k]))
		end
	end
	return Own.everyStep(guide)
end

-- Placement: where the quest log puts the player in the guide. Runs while the
-- tab is being placed (`placing`: its guide was just loaded at login, reload,
-- in a new tab, after /polestar reset).
--
-- The start is the first open step with work the player has started (a goal
-- of a quest in the log: objectives in progress, ready to turn in) or can do
-- now (an accept their level and prerequisites allow). Steps the player
-- skipped are never the start, even with their quest in the log, and ticked
-- or skipped goals are not open work: a reload never pulls the player back to
-- what they chose to pass. Before the start (or, with none, before the last
-- quest progress), a step holds unless all its open goals are:
-- - accepts the character cannot take yet (level, prerequisite): marked
--   unavailable for the session, so they come back when the level is
--   reached or the prerequisite done (Own.clearMarks);
-- - goals the quest log cannot vouch for (goto, fly, getfp, train, vendor,
--   hearth, non-quest kill/collect...) in a step before the last quest
--   progress (anchorStep): the player is demonstrably past them;
-- - travel goals (goto, fly, hearth, explore) when the player already stands
--   within HERE yards of the start step's work: no travel needed;
-- - with the catch-up, travel goals on the way to a quest it left out, and in
--   a guide it passes whole.
-- Soft goals passed are latched. So soft steps never hold the player behind
-- quest work done further on, yet a fresh guide still begins with its
-- travel and training stops: a flight path, a hearth or training ahead of
-- the last quest progress holds, unless every quest of the guide is done,
-- or the guide is passed for the player (opened for them, Own.opened), where
-- it passes for the session only (Own.passedNow).
local function place()
	local steps, C = guide.steps, Compat()
	local level = player.level or 1
	local sk = skippedFor(guide.id)
	local catchUp = ns.Get("behavior.skipGrey") and not Own.everyStep(guide)
	Own.leftOut[guide.id] = nil
	local addedAll = ns.CharState().added
	local added = type(addedAll) == "table" and addedAll[guide.id] or nil
	local anchor = anchorStep(added)
	if catchUp then Own.leftOut[guide.id] = Own.catchUp(anchor, level) end
	Own.passedNow[guide.id], Own.passedWhole[guide.id] = nil, nil
	local function open(s, g, goal)
		return blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(s, g, goal)
	end
	local function gated(goal)
		if goal.t ~= "accept" then return nil end
		local lvl = tonumber(goal.minLevel)
		if lvl and level < lvl then return "level" end
		if missingPre(goal) then return "pre" end
		return nil
	end
	local out = Own.leftOut[guide.id]
	-- An accept waiting for a level holds the guide (Own.levelHold).
	local start, later, anyOut = nil, Own.levelHold() ~= nil, nil
	for s = 1, #steps do
		for _, goal in ipairs(steps[s].goals) do
			if (goal.t == "accept" or goal.direct) and goal.quest and ((out and out[goal.quest]) or greyNeed(goal) == false) then anyOut = true end
		end
		if stepApplies(steps[s]) and not (sk and sk[s]) and not stepDone(s) then
			local started, doable = false, false
			for g, goal in ipairs(steps[s].goals) do
				if open(s, g, goal) then
					if goal.t == "accept" then
						-- An accept an update added behind the player is no start:
						-- an update never moves them back (Own.passAdded).
						doable = doable or (not gated(goal) and not (added and Own.goalAdded(added, s, goal)))
						-- Only a level to reach holds a guide the catch-up could
						-- pass: a missing prerequisite is often a grey quest it
						-- left out, which will never come.
						later = later or gated(goal) == "level"
					elseif isQuestGoal(goal) and C.IsOnQuest(goal.quest) then
						started = true
					end
				end
			end
			if not start and (started or doable) then start = s end
		end
	end
	local limit = start or anchor
	-- Caught up on a guide the character is past (quests left out as too low,
	-- or its top level reached) with no quest left to do, none waiting for a
	-- level or a prerequisite: it passes whole. Opened for the player (the
	-- login's pick, Start guide, a guide chained to), it then chains to the
	-- next (evaluateLoaded); opened by the player or brought back by a reload,
	-- it stays, finished.
	local past = anyOut or (guide.maxLevel ~= nil and level >= guide.maxLevel)
	local whole = catchUp and not start and not later and logReady and past
	local through = whole and autoChain and Own.opened[guide.id]
	local allDone = whole and Own.allQuestsDone(guide)
	if whole then
		limit = #steps + 1
		Own.passedWhole[guide.id] = true
		if through then Own.placedThrough[guide.id] = true end
	end
	-- The last step before the start with an accept left out: the way there
	-- passes with it.
	local lastOut = 0
	for s = 1, limit - 1 do
		for _, goal in ipairs(steps[s].goals) do
			if (goal.t == "accept" or goal.direct) and goal.quest and ((out and out[goal.quest]) or greyNeed(goal) == false) then lastOut = s end
		end
	end
	local here = false
	if start and anchor < start then
		local HERE = 150 -- yards: the player stands where the start step's work is
		local c, px, py = C.GetPlayerWorldPosition()
		for g, goal in ipairs(steps[start].goals) do
			local map, x, y, f = posOf(goal)
			if c and map and x and y and open(start, g, goal) then
				local gc, gx, gy = C.MapToWorld(map, x, y, f)
				if gc == c and (gx - px) ^ 2 + (gy - py) ^ 2 <= HERE * HERE then
					here = true
					break
				end
			end
		end
	end
	local function travel(t) return t == "goto" or t == "fly" or t == "hearth" or t == "explore" or t == "die" end
	-- A soft step behind the progress passes only when the quest work it
	-- leads to is done or under way: the next quest goal for the character
	-- after it that they can do (not waiting for a level or a prerequisite),
	-- or one the catch-up left out (the way passes with it). Progress on a
	-- quest done before this guide (an earlier visit to the zone, an earlier
	-- guide that offers it too) is no sign the travel and training before
	-- the work still to do were done (SkipAheadSweep, 0.3.6: Stranglethorn's
	-- flight to Darkshire, Feralas' zeppelin, Darkshore's boat).
	local function leadsToDone(s)
		for t = s + 1, #steps do
			-- A group quest waiting for the player's answer (Own.groupPending) is
			-- no work they owe the route; nor is what an update added (Own.passAdded
			-- passes it behind the player: Barrens' Wrongly Blamed, 0.3.6).
			if stepApplies(steps[t]) and not (sk and sk[t]) and not Own.groupPending(steps[t]) then
				for g, goal in ipairs(steps[t].goals) do
					local q = goal.quest
					if added and Own.goalAdded(added, t, goal) then goal = nil end
					-- Leads to a quest the catch-up left out: the way passes with it.
					if goal and blocks(goal) and isQuestGoal(goal) and q and out and out[q] then return true end
					if goal and blocks(goal) and isQuestGoal(goal) and goalApplies(goal) then
						if (goal.t == "accept" or goal.direct) and greyNeed(goal) == false then return true end
						if not gated(goal) and not unavailableFor(goal) then
							-- A hand-in of a quest in the log is still to do where its NPC
							-- stands: carrying the quest is no sign the player went there
							-- (Horde Stranglethorn 40-50: Fly to Grom'gol passed for a
							-- hand-in of 1240 there).
							if goalDone(t, g, goal) then return true end
							return q ~= nil and (questDone(q) or (goal.t ~= "turnin" and C.IsOnQuest(q))) or false
						end
					end
				end
			end
		end
		return true
	end
	for s = 1, limit - 1 do
		if stepApplies(steps[s]) and not (sk and sk[s]) and not stepDone(s) then
			local goals, passes = steps[s].goals, true
			-- Soft goals this step passes: all of them behind the progress or
			-- with every quest done; travel to a quest left out or through a
			-- guide passed whole; the rest only in a guide passed for the
			-- player, for the session.
			local behind = (s < anchor and leadsToDone(s)) or allDone
			local now = not behind and through
			for g, goal in ipairs(goals) do
				local t = goal.t
				local soft = isManual(goal) or latchable(goal) or isBagCount(goal)
				-- What an update added holds nothing (Own.passAdded passes it).
				if open(s, g, goal) and not gated(goal)
					and not (soft and (behind or now or ((s < lastOut or whole) and travel(t))))
					and not (here and travel(t)) and not (added and Own.goalAdded(added, s, goal)) then
					passes = false
					break
				end
			end
			if passes then
				local m = manualFor(guide.id, true)
				for g, goal in ipairs(goals) do
					if open(s, g, goal) and not (added and Own.goalAdded(added, s, goal)) then
						local why = gated(goal)
						if why then
							unavailable[goal.quest] = { reason = why, accept = goal }
						elseif now and not travel(goal.t) then
							local n = Own.passedNow[guide.id] or {}
							Own.passedNow[guide.id] = n
							n[Own.key(s, g)] = true
						else
							m[s .. ":" .. g] = true
						end
					end
				end
			end
		end
	end
	-- After an update: its steps behind the player's place pass (Own.passAdded).
	Own.safely("pass", guide.id, Own.passAdded)
end

-- `skipto` jumps (format 5; docs/GUIDE_FORMAT.md, "Jumps"): the route has
-- reached step s. The first of its jumps whose predicate holds skips s and
-- every step up to the labelled one for the character, saved as "jump" in
-- CharState().skipped next to the player's skips, so the jump does not undo
-- itself when the predicate turns false later; Unskip brings a step back. A
-- step skipped already keeps its skip. Not before the quest log
-- can be read (a `!turnedin` would hold on an empty log), nor for a step the
-- player brought back (Own.keep). True if the route jumped.
function Own.jump(s)
	local step = guide.steps[s]
	if not (step.skipto and logReady) then return false end
	local kept = ns.CharState().when[guide.id]
	if kept and kept[s] then return false end
	for _, k in ipairs(step.skipto) do
		local to = Own.marksOf().labels[k.to]
		if to and to > s and Own.predicateHolds(k.when) then
			local sk = skippedFor(guide.id, true)
			for t = s, to - 1 do
				if not sk[t] then sk[t] = "jump" end
			end
			return true
		end
	end
	return false
end

-- The player brought step s back (Unskip, Goto): a step with `when` applies
-- from now on, whatever its predicates, and one with `skipto` takes no jump
-- (CharState().when[guideId][s]).
function Own.keep(s)
	local step = guide.steps[s]
	if not (step and (step.when or step.skipto)) then return end
	local held = ns.CharState().when
	held[guide.id] = held[guide.id] or {}
	held[guide.id][s] = true
	-- Kept by the player now: no skip's undo takes it back (Own.skipRestore).
	local all = ns.CharState().skipStored
	local mine = type(all) == "table" and all[guide.id]
	for _, rec in pairs(type(mine) == "table" and mine or NONE) do
		if type(rec.steps) == "table" then rec.steps[s] = nil end
	end
end

-- First applicable, not skipped, not done step, after placing the tab when
-- it was just loaded (place). During play soft steps hold as usual, so a
-- quest taken out of order never jumps a training stop. A step the route
-- reaches may jump ahead (Own.jump), a flight step it reaches may pass to
-- the travel route (Own.flightJudged), and an accept waiting for a level
-- holds a dungeon guide or a dungeon run (Own.holdsBefore).
local function computeCurrent()
	if placing then place() end
	local steps = guide.steps
	local sk = skippedFor(guide.id)
	for s = 1, #steps do
		-- The live step stays while the group waits on it (Own.partyHold).
		if stepApplies(steps[s]) and not (sk and sk[s]) and (not stepDone(s) or (s == computed and Own.partyHold(s))) then
			local hold = Own.holdsBefore(s)
			if hold then
				return hold
			elseif Own.jump(s) then
				sk = skippedFor(guide.id)
			elseif not Own.flightJudged(s) then
				return s
			end
		end
	end
	-- Nothing else open: a guide that is no leveling guide waits at an accept
	-- the level-up brings back (Own.levelHold).
	return Own.everyStep(guide) and Own.levelHold() or nil
end

-- Store the live-done latchable goals of steps from..to (steps the route has
-- just moved past), and whether their `when` held (Own.latchWhen).
local function latchPassed(from, to)
	local steps = guide.steps
	for s = from, to do
		local step = steps[s]
		Own.latchWhen(s)
		if stepApplies(step) then
			for g, goal in ipairs(step.goals) do
				if latchable(goal) and goalApplies(goal) and not checked(s, g) and goalDone(s, g, goal) then
					manualFor(guide.id, true)[s .. ":" .. g] = true
				end
			end
		end
	end
end

-- isBagCount: see computeCurrent above.

-- Latch step s's met bag counts and, when s is the live step (`live`), its
-- flights and hearths that landed: walking out of the arrival's subzone, or
-- through Rut'theran's portal, must not send the player back to the flight
-- master while the step's other goals are open (#362). Only the live step's:
-- looking ahead at a step while standing at its flight's end is no landing.
-- Unlike bag counts they are kept when the step is left backwards (the
-- player did land).
local function latchInStep(s, live)
	local step = guide.steps[s]
	if not stepApplies(step) then return end
	for g, goal in ipairs(step.goals) do
		local t = goal.t
		-- An abandon latches on the live step only: on a step looked at ahead it
		-- reads done for a quest not taken yet (Own.abandonedByGuide).
		if ((isBagCount(goal) and (live or t ~= "abandon")) or (live and (t == "fly" or t == "hearth" or t == "enter" or t == "wait"))) and goalApplies(goal) and not checked(s, g) and goalDone(s, g, goal) then
			manualFor(guide.id, true)[s .. ":" .. g] = true
		end
	end
end

-- Forget the in-step bag-count latches of step s (the player's ticks stay).
local function clearInStep(s)
	local m = manualFor(guide.id)
	if not m then return end
	for g, goal in ipairs(guide.steps[s].goals) do
		local key = s .. ":" .. g
		if isBagCount(goal) and m[key] == true then m[key] = nil end
	end
end

-- First applicable step after `from` that is still open, below `limit`.
local function nextOpen(from, limit)
	local steps = guide.steps
	for s = from + 1, (limit or #steps + 1) - 1 do
		if stepApplies(steps[s]) and not isSkipped(s) and not stepDone(s) then return s end
	end
	return nil
end

local function nextApplicable(from)
	local steps = guide.steps
	for s = from + 1, #steps do
		if stepApplies(steps[s]) then return s end
	end
	return nil
end

local function goalStatus(s, g, goal, stepIsCurrent)
	if not goalApplies(goal) then return "na" end
	local done, cur, max, label, kind = goalDone(s, g, goal)
	if done then return "done", cur, max, label, kind end
	if unavailableFor(goal) or Own.goalSkipped(s, g) or Own.lostGoal(goal) then return "skipped", cur, max, label, kind end
	return stepIsCurrent and "active" or "pending", cur, max, label, kind
end

---------------------------------------------------------------------------
-- Focus: one person at a time (ARCHITECTURE "Focus"). A step's goals form
-- groups in authored order by who they are done with; the focus is the
-- first group with a blocking goal still open.
---------------------------------------------------------------------------

local WHO_VERBS = {
	accept = true, turnin = true, talk = true, train = true, vendor = true, sethome = true,
	getfp = true, learn = true, buy = true, interact = true,
}

-- kind ("npc" | "object" | "here"), id and name of whom a goal is done with.
-- An interact for a quest objective (totems, mounds, cages, braziers) is
-- field work done where you are, like a kill or a collect, not a visit: it
-- shows with the step's kills instead of waiting behind them. A plain
-- interact (no quest) is still a visit to that object.
local function whoOf(goal)
	if WHO_VERBS[goal.t] then
		local npc, name = npcOf(goal)
		if npc then return "npc", npc, name end
		if goal.object and not (goal.t == "interact" and goal.quest) then
			return "object", goal.object, ns.Names.Object(goal.object) or goal.objName
		end
	end
	return "here"
end

-- Applicable, not skipped, not done, not held as lost (Own.lostGoal), and blocking.
local function stillBlocks(s, g, goal)
	return blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not Own.lostGoal(goal) and not goalDone(s, g, goal)
end

-- groups = { { kind, id, name, goals = { goalIndex, ... }, map, x, y, f,
-- pending, done }, ... }, focus (group index or nil), groupOf (goalIndex ->
-- group index). Goals that do not apply to the character never split a
-- group: they join the group around them.
local function stepGroups(s)
	local goals = guide.steps[s].goals
	local groups, groupOf = {}, {}
	local cur, held
	local function add(grp, g)
		grp.goals[#grp.goals + 1] = g
		groupOf[g] = grp.index
	end
	for g = 1, #goals do
		local goal = goals[g]
		if not goalApplies(goal) then
			if cur then
				add(cur, g)
			else
				held = held or {}
				held[#held + 1] = g
			end
		else
			local kind, id, name = whoOf(goal)
			if not cur or cur.kind ~= kind or cur.id ~= id then
				cur = { index = #groups + 1, kind = kind, id = id, name = name, goals = {} }
				groups[cur.index] = cur
				if held then
					for _, h in ipairs(held) do add(cur, h) end
					held = nil
				end
			elseif not cur.name and name then
				cur.name = name
			end
			add(cur, g)
		end
	end
	if held then
		cur = { index = 1, kind = "here", goals = {} }
		groups[1] = cur
		for _, h in ipairs(held) do add(cur, h) end
	end
	local focus
	for _, grp in ipairs(groups) do
		-- `held`: turn-ins waiting on an objective the player ticked by hand
		-- (Own.tickedOpen): they keep the step, but take no focus.
		local pending, held = 0, 0
		for _, g in ipairs(grp.goals) do
			local goal = goals[g]
			if stillBlocks(s, g, goal) then
				pending = pending + 1
				if goal.t == "turnin" and Own.tickedOpen(goal.quest) then held = held + 1 end
			end
			if not grp.map and goalApplies(goal) then
				local map, x, y, f, _, z = posOf(goal)
				if map and x and y then grp.map, grp.x, grp.y, grp.f, grp.z = map, x, y, f, z end
			end
		end
		grp.pending, grp.done = pending, pending == 0
		if not focus and pending > held then focus = grp.index end
	end
	return groups, focus, groupOf
end

---------------------------------------------------------------------------
-- View models
---------------------------------------------------------------------------

local guideTitles = setmetatable({}, { __mode = "k" }) -- guide -> { [quest] = title }

local function titleMap()
	local map = guideTitles[guide]
	if not map then
		map = {}
		for _, step in ipairs(guide.steps) do
			for _, gl in ipairs(step.goals) do
				if gl.quest and gl.title and not map[gl.quest] then map[gl.quest] = gl.title end
			end
		end
		guideTitles[guide] = map
	end
	return map
end

-- A non-English client's own title (or its names pack's) comes before the
-- guide's English one; on an English client Names gives nil and the guide's
-- title wins over the client's.
local function questTitle(goal)
	local q = goal.quest
	if not q then return nil end
	local t = ns.Names.Quest(q) or goal.title or Compat().GetQuestTitle(q)
	if t then return t end
	return titleMap()[q] or (L["Quest"] .. " " .. q)
end

-- Title of any quest the guide names (e.g. a prerequisite).
local function titleOfQuest(q, hint)
	return ns.Names.Quest(q) or (hint and hint[q]) or titleMap()[q] or Compat().GetQuestTitle(q) or (L["Quest"] .. " " .. q)
end

-- Player-facing explanation of an unavailable mark.
local function unavailableText(u)
	if u.reason == "skipped" then return L["You skipped this quest"] end
	local a = u.accept
	if u.reason == "closed" then return L["No longer offered: you took %s"]:format(ns.Quoted(titleOfQuest(u.by, a.preTitles))) end
	if u.reason == "level" then return L["Requires level %d"]:format(tonumber(a.minLevel) or 0) end
	if u.reason == "pre" then
		local pre = u.pre or missingPre(a)
		if pre then return L["Requires %s first"]:format(ns.Quoted(titleOfQuest(pre, a.preTitles))) end
	end
	local N = ns.Names
	return L["Not offered by %s"]:format(N.Npc(a.npc) or a.npcName or N.Object(a.object) or a.objName or L["the quest giver"])
end

-- A "pre" mark's quest the player skipped (Own.skipRoot), as its title; nil
-- when the route simply never brings the prerequisite.
function Own.skippedWithTitle(u)
	local pre = u.pre or missingPre(u.accept)
	local root = pre and guide and Own.skipRoot(pre)
	return root and titleOfQuest(root, u.accept.preTitles) or nil
end

-- Another quest of the loaded guide than q, named `title` too, in the log.
function Own.namesakeInLog(q, title)
	local C, l = Compat(), layoutOf(guide)
	for _, by in ipairs({ l.accepts, l.turnins }) do
		for other in pairs(by) do
			if other ~= q and C.IsOnQuest(other) and titleOfQuest(other) == title then return true end
		end
	end
	return false
end

-- What an open accept's line says about the game's own word on it: ticked by
-- hand while the quest is not in the log (the tick does not stand for it,
-- #739), or its giver's window did not list it (Own.notListed: never a skip,
-- #741; the player is asked to report it). With another quest of this
-- guide by the same name in the log (every part of Call of Water is "Call
-- of Water"), the plain line read as though that one were not taken
-- (#1372): it says the one there is another quest.
function Own.acceptNotice(s, g, goal, status)
	if goal.t ~= "accept" or not goal.quest or (status ~= "active" and status ~= "pending") then return nil end
	if checked(s, g) then
		local title = questTitle(goal) or titleOfQuest(goal.quest)
		if Own.namesakeInLog(goal.quest, title) then return L["This %s isn't in your quest log yet: the one you have is another quest of that name"]:format(ns.Quoted(title)) end
		return L["%s isn't in your quest log"]:format(ns.Quoted(title))
	end
	if Own.notListed[goal.quest] then
		local N = ns.Names
		return L["Not offered by %s? Report it with /polestar"]:format(N.Npc(goal.npc) or goal.npcName or N.Object(goal.object) or goal.objName or L["the quest giver"])
	end
	return nil
end

-- What the game asks before it offers accept goal g of step s (#1247): the
-- quest's minimum level and the prerequisites not handed in yet, for the
-- goal's tooltip. From the compiled goal (`minLevel`, `pre`, `preAll`,
-- `preTitles`), else from the quest database when it is loaded (never loads
-- it). `needs` lists every missing `preAll` quest by name, and a `pre` list
-- none of which is done as one entry, "A or B"; it is empty once the quest is
-- in the log or done. A minimum level of 1 says nothing and is left out.
-- -> { level = n | nil, short = bool, needs = { text, ... } } | nil (not an
-- accept, or nothing known). Asked on hover only: it allocates.
function Engine.AcceptGate(s, g)
	local step = guide and type(s) == "number" and guide.steps[s]
	local goal = step and type(g) == "number" and step.goals[g]
	if not (goal and goal.t == "accept" and goal.quest) then return nil end
	if not player then refreshPlayer() end
	local Q = ns.QuestDB
	local loaded = Q and Q.IsLoaded and Q.IsLoaded() or false
	local rec = loaded and Q.GetQuest(goal.quest) or nil
	local level = tonumber(goal.minLevel) or (rec and tonumber(rec.minLevel)) or nil
	if level and level <= 1 then level = nil end
	local pre, preAll = goal.pre, goal.preAll
	if pre == nil and preAll == nil and rec then pre, preAll = rec.pre, rec.preAll end
	local needs = {}
	local C = Compat()
	if not (C.IsOnQuest(goal.quest) or questDone(goal.quest)) then
		local hint = goal.preTitles
		local function title(q)
			return ns.Names.Quest(q) or (hint and hint[q]) or (loaded and Q.GetQuestTitle(q)) or titleOfQuest(q)
		end
		for _, q in ipairs(type(preAll) == "table" and preAll or NONE) do
			if not questDone(q) then needs[#needs + 1] = title(q) end
		end
		if type(pre) == "table" and #pre > 0 then
			local any = false
			for _, q in ipairs(pre) do
				if questDone(q) then
					any = true
					break
				end
			end
			if not any then
				local text
				for _, q in ipairs(pre) do text = text and L["%s or %s"]:format(text, title(q)) or title(q) end
				needs[#needs + 1] = text
			end
		end
	end
	if not level and #needs == 0 then return nil end
	return { level = level, short = level ~= nil and (player.level or 1) < level, needs = needs }
end

-- A translated pattern (L["from %s"]) filled with value; nil without one.
local function fmt(pattern, value)
	if not value then return nil end
	return pattern:format(value)
end

-- A walk's waypoint named only by its zone ("Go to Mulgore", the guide
-- writer's label for a point on the way through a zone), shown while the
-- player is already in that zone, reads as done though it leads deeper in
-- (#1334). Such a goal of step s names where the walk goes instead: the zone
-- and the title of the next step for the character that is not another walk
-- through it. Display only: the goal completes as before. -> zone, title or nil
function Own.onThroughZone(s, goal)
	local text = goal.text
	if not (s and guide and text and not goal.area) then return nil end
	local C = Compat()
	if C.GetMapName(goal.map) ~= text or C.GetZoneText() ~= text then return nil end
	local steps = guide.steps
	for _, other in ipairs(steps[s].goals) do
		if other.t ~= "goto" and other.t ~= "note" then return nil end
	end
	for n = s + 1, #steps do
		local step = steps[n]
		if not step.along and stepApplies(step) and not isSkipped(n) and step.title and step.title ~= text then
			return text, step.title
		end
	end
	return nil
end

-- Whether quest title `title` is the name of its NPC or object `who` (case
-- aside): then the NPC goes unsaid ("to them"), as the title says it.
function Own.namesake(title, who)
	return type(title) == "string" and type(who) == "string" and title:lower() == who:lower()
end

-- verb, subject, subjectKind, detail. An accept above the character's level
-- says from which level (an attunement's quests stay in its guide until then).
-- Quests, NPCs, objects and items are named in the client's language where
-- Polestar.Names has them, else as the guide names them. `s`: the goal's step
-- (Own.onThroughZone), when known.
local function describe(goal, s)
	local t = goal.t
	local C = Compat()
	local N = ns.Names
	-- A place goal's area (`area`) as the client names it, in its language.
	local place = C.GetAreaName and C.GetAreaName(goal.area) or nil
	if t == "accept" then
		-- A quest named after its NPC (a breadcrumb: "Thun'grim Firegaze" at
		-- Thun'grim Firegaze) is not named twice: no "from"/"at" detail.
		local title = questTitle(goal)
		local who = N.Npc(goal.npc) or goal.npcName or N.Object(goal.object) or goal.objName or N.Item(goal.item) or goal.itemName
		local detail = not Own.namesake(title, who) and fmt(L["from %s"], who) or nil
		local lvl = tonumber(goal.minLevel)
		if lvl and player and (player.level or 1) < lvl then
			detail = detail and L["%s, from level %d"]:format(detail, lvl) or L["From level %d"]:format(lvl)
		end
		return L["Accept"], title, "quest", detail
	elseif t == "turnin" then
		local title = questTitle(goal)
		local who = N.Npc(goal.npc) or goal.npcName or N.Object(goal.object) or goal.objName
		return L["Turn in"], title, "quest", not Own.namesake(title, who) and fmt(L["at %s"], who) or nil
	elseif t == "complete" then
		return L["Complete"], questTitle(goal), "quest", nil
	elseif t == "abandon" then
		return L["Abandon"], questTitle(goal), "quest", nil
	elseif t == "wait" then
		return L["Wait"], goal.text or L["%d seconds"]:format(tonumber(goal.seconds) or 0), "text", nil
	elseif t == "destroy" then
		return L["Destroy"], N.Item(goal.item) or goal.itemName, "item", nil
	elseif t == "kill" then
		-- `tame`: kill credit for taming the beast (a Lookup guide's Taming the Beast).
		return goal.tame and L["Tame"] or L["Kill"], N.Npc(goal.npc) or goal.target, "npc", goal.quest and fmt(L["for %s"], ns.Quoted(questTitle(goal))) or nil
	elseif t == "collect" then
		local item = N.Item(goal.item) or goal.itemName
		if goal.quest then return L["Collect"], item, "item", fmt(L["for %s"], ns.Quoted(questTitle(goal))) end
		local _, npcName = npcOf(goal)
		return L["Collect"], item, "item", fmt(L["from %s"], npcName)
	elseif t == "goto" then
		local mapName = C.GetMapName(goal.map)
		local zone, onTo = Own.onThroughZone(s, goal)
		if zone then return "", L["On through %s to %s"]:format(zone, onTo), "text", mapName end
		if place or goal.text then return L["Go to"], place or goal.text, "place", mapName end
		local lx, ly = liveXY(goal)
		return L["Go to"], ("%.1f, %.1f"):format(lx or goal.x, ly or goal.y), "place", mapName
	elseif t == "talk" then
		return L["Talk to"], N.Npc(goal.npc) or goal.npcName, "npc", goal.quest and fmt(L["for %s"], ns.Quoted(questTitle(goal))) or nil
	elseif t == "interact" then
		return L["Click"], N.Object(goal.object) or goal.objName, "object", goal.quest and fmt(L["for %s"], ns.Quoted(questTitle(goal))) or nil
	elseif t == "use" then
		return L["Use"], N.Item(goal.item) or goal.itemName, "item", goal.quest and fmt(L["for %s"], ns.Quoted(questTitle(goal))) or nil
	elseif t == "sethome" then
		local _, npcName = npcOf(goal)
		if goal.location then return L["Set your home to"], place or goal.location, "place", fmt(L["at %s"], npcName) end
		return L["Set your home at"], npcName or L["the nearest inn"], npcName and "npc" or "text", nil
	elseif t == "hearth" then
		return L["Hearth to"], place or goal.location, "place", nil
	elseif t == "die" then
		return L["Die and resurrect at"], goal.location, "place", nil
	elseif t == "enter" then
		return L["Go to"], place or goal.location, "place", nil
	elseif t == "getfp" then
		return L["Get the flight path at"], place or N.Taxi(goal.node) or goal.location, "place", fmt(L["from %s"], N.Npc(goal.npc) or goal.npcName)
	elseif t == "fly" then
		-- A landing the character has no flight path to: travel there (Own.unknownLanding).
		return Own.unknownLanding(goal) and L["Go to"] or L["Fly to"], place or N.Taxi(goal.node) or goal.location, "place", nil
	elseif t == "train" then
		local _, npcName = npcOf(goal)
		if goal.skillLine and rankCap(goal) then
			local name = skillName(goal)
			return L["Train"], name, "skill", fmt(L["at %s"], npcName)
		end
		if npcName then return L["Train at"], npcName, "npc", nil end
		return L["Train at"], L["your trainer"], "text", nil
	elseif t == "buy" then
		local _, npcName = npcOf(goal)
		return L["Buy"], N.Item(goal.item) or goal.itemName, "item", fmt(L["from %s"], npcName)
	elseif t == "vendor" then
		local _, npcName = npcOf(goal)
		if npcName then return L["Sell and repair at"], npcName, "npc", nil end
		return L["Sell and repair at"], L["a vendor"], "text", nil
	elseif t == "level" then
		if goal.frac then return L["Reach level"], ns.LC("level and share of it", "%d (%d%%)"):format(goal.level, math.floor(goal.frac * 100 + 0.5)), "level", nil end
		return L["Reach level"], tostring(goal.level), "level", nil
	elseif t == "skill" then
		return L["Raise"], skillName(goal), "skill", fmt(L["to %d"], goal.level)
	elseif t == "cast" then
		return L["Cast"], N.Spell(goal.spell) or goal.spellName, "spell", nil
	elseif t == "learn" then
		local _, npcName = npcOf(goal)
		return L["Learn"], N.Spell(goal.spell) or goal.spellName, "spell", fmt(L["from %s"], npcName)
	elseif t == "craft" then
		local detail
		if goal.untilSkill then
			local name = skillName(goal)
			detail = name and L["until %s %d"]:format(name, goal.untilSkill) or fmt(L["until skill %d"], goal.untilSkill)
		end
		return L["Craft"], N.Spell(goal.spell) or goal.spellName, "spell", detail
	elseif t == "rep" then
		return L["Reach %s with"]:format(standingName(goal.standing)), N.Faction(goal.faction) or goal.factionName, "faction", nil
	elseif t == "explore" then
		local mapName = C.GetMapName(goal.map)
		if place or goal.text then return L["Explore"], place or goal.text, "area", mapName end
		local lx, ly = liveXY(goal)
		return L["Explore"], ("%.1f, %.1f"):format(lx or goal.x, ly or goal.y), "area", mapName
	elseif t == "achieve" then
		local detail
		if goal.criteria and C.GetAchievement then
			local a = C.GetAchievement(goal.achievement)
			local c = a and a.criteria and a.criteria[goal.criteria]
			if c and c.text ~= "" then detail = c.text end
		end
		return L["Complete"], goal.achievementName, "achievement", detail
	elseif t == "money" then
		return L["Have at least"], ns.MoneyText(goal.money or 0), "text", nil
	end
	return "", goal.text or "", "text", nil -- note, task
end

-- Goals whose count shows as a progress bar instead of in the text.
local function tracksProgress(goal)
	local t = goal.t
	return (goal.quest and goal.oi) or t == "buy" or (t == "collect" and not goal.quest)
		or (t == "craft" and craftMode(goal) ~= "manual")
end

-- Display text overrides the default except where `text` names a place.
local TEXT_IS_PLACE = { ["goto"] = true, explore = true }

-- Plain text, independent of the goal's state: "Kill Kobold Vermin" (with a
-- progress bar), "Kill 5 Young Wolf" (manual, no tracking). Second: a
-- collect's compiled source (`from`, `fromAlso`, named in the client's
-- language by `fromId`, `fromAlsoId`; `fromKind`, `fromRank`, `fromFaction`;
-- an NPC of a faction that is not the character's own is one to kill),
-- `inText` when the text names it. A quest (`kind` "quest") reads in the
-- client's quote marks: "Turn in “Your Place in the World”" (ns.Quoted).
local function goalText(goal, verb, subject, detail, kind)
	local fromKind = goal.fromKind or "npc"
	local nameOf = fromKind == "object" and ns.Names.Object or ns.Names.Npc
	local src = goal.from and {
		name = nameOf(goal.fromId) or goal.from, also = goal.fromAlso and (nameOf(goal.fromAlsoId) or goal.fromAlso),
		kind = fromKind, rank = goal.fromRank,
		enemy = fromKind == "npc" and not (goal.fromFaction == "AH"
			or (goal.fromFaction == "A" and player and player.faction == "Alliance")
			or (goal.fromFaction == "H" and player and player.faction == "Horde")),
	} or nil
	if goal.text and not TEXT_IS_PLACE[goal.t] then return goal.text, src end
	if kind == "quest" then subject = ns.Quoted(subject) end
	if verb == "" then return subject, src end
	if goal.t == "skill" then return verb .. " " .. tostring(subject) .. " " .. detail, src end
	local counted = goal.count and goal.count > 1 and not tracksProgress(goal)
	-- "Kill Grell or Grellkin for Fel Moss", "Collect Oats from Sack of Oats":
	-- a collect whose source is known says where the item comes from (the
	-- game's objective only names the item); not an object named as the item
	-- (the item lying there).
	if goal.t == "collect" and subject and src and goal.from ~= goal.itemName then
		local item = counted and (goal.count .. " " .. subject) or subject
		local who = src.name
		local rank = src.rank and ({ L["elite"], L["rare elite"], L["boss"], L["rare"] })[src.rank]
		if rank then who = who .. " (" .. rank .. ")" end
		if src.also then who = L["%s or %s"]:format(who, src.also) end
		src.inText = true
		if src.enemy then return L["Kill %s for %s"]:format(who, item), src end
		return L["Collect %s from %s"]:format(item, who), src
	end
	if counted then
		return verb .. " " .. goal.count .. " " .. tostring(subject), src
	end
	return verb .. " " .. tostring(subject), src
end

local function goalView(s, g, goal, stepStatus, group)
	local status, cur, max, label, pkind
	if stepStatus == "na" then
		status = "na"
	else
		status, cur, max, label, pkind = goalStatus(s, g, goal, stepStatus == "current")
	end
	local progress = (cur and max) and { cur = cur, max = max, label = label, kind = pkind or "count" } or nil
	local verb, subject, kind, detail = describe(goal, s)
	local npc, npcName = npcOf(goal)
	local map, x, y, f, _, z = posOf(goal)
	local alternatives
	if goal.candidates then
		local n = #pickFor(goal).list
		alternatives = n > 0 and n - 1 or 0
	end
	local unavail = status == "skipped" and unavailableFor(goal) or nil
	-- An accept waiting for the character's level is no task yet (Fitz,
	-- 0.3.6: no level text on pick-ups): not shown, like a goal for another
	-- class; the level-up brings it back (Own.clearMarks). Unless the route
	-- waits on it (Own.waitsOnLevel: a guide that is no leveling guide, or a
	-- dungeon run ahead, with nothing else left open there): then its
	-- "Requires level" line is the one thing the step says.
	-- `waitsLevel`: the level a hidden one waits for (playtest.js's SIMULATE levels the player to it).
	local waitsLevel
	if unavail and unavail.reason == "level" and (goal.t == "accept" or layoutOf(guide).starters[goal]) and not Own.waitsOnLevel(s) then
		status, unavail, waitsLevel = "na", nil, tonumber(goal.minLevel)
	end
	-- A goal of a quest that left the log, held for the player's answer.
	local lost = status == "skipped" and not unavail and Own.lostGoal(goal)
	local text, src = goalText(goal, verb, subject, detail, kind)
	local need = player and greyNeed(goal)
	-- A grey accept "Skip grey quests" keeps: the open accept it leads to.
	local opens = need or nil
	return {
		index = g,
		group = group,
		t = goal.t,
		status = status,
		text = text,
		verb = verb,
		subject = subject,
		subjectKind = kind,
		detail = detail,
		progress = progress,
		manual = isManual(goal),
		-- The player can tick any goal but a note (ToggleGoal); `ticked`: a
		-- stored check-off they can clear. `dismissed`: an optional goal they
		-- skipped (SkipGoal), status "skipped".
		tickable = goal.t ~= "note" and status ~= "na",
		ticked = checked(s, g),
		dismissed = Own.goalSkipped(s, g) or nil,
		optional = goal.optional and true or false,
		-- A vendor check-off beside other work: it does not hold the step
		-- (Own.sideVendor).
		side = Own.sideVendor(s, goal) or nil,
		note = goal.note,
		map = map, x = x, y = y, f = f, z = z,
		quest = goal.quest, oi = goal.oi, npc = npc, npcName = npcName, item = goal.item,
		alternatives = alternatives,
		spots = goal.spots and #goal.spots or nil, spread = goal.spread or nil,
		lvl = goal.candidates and chosen(goal) and chosen(goal).lvl or nil,
		unavailable = unavail and unavail.reason or nil,
		waitsLevel = waitsLevel,
		unavailableText = unavail and unavailableText(unavail) or nil,
		-- Left out because the player skipped a quest it needs (directly or
		-- down the chain): that quest's title (Own.skippedWithTitle).
		skippedWith = unavail and unavail.reason == "pre" and Own.skippedWithTitle(unavail) or nil,
		-- An open accept the game does not confirm: ticked but not in the
		-- quest log, or not listed by its giver (Own.acceptNotice); a goal
		-- of a quest that left the log (Own.lostGoal), greyed while asked.
		noticeText = Own.acceptNotice(s, g, goal, status) or (lost and (Own.failedQuest(goal.quest)
			and L["%s failed: abandon it and take it again"] or L["%s isn't in your quest log"]):format(ns.Quoted(questTitle(goal)))) or nil,
		lost = lost or nil,
		skippedGrey = need == false or nil,
		keptGrey = opens and opens.quest or nil,
		keptGreyText = opens and L["Grey, kept: opens %s"]:format(ns.Quoted(questTitle(opens))) or nil,
		-- A hearth goal still to do while the Hearthstone waits, or while
		-- travelling there is about as fast (#576, Own.hearthText).
		hearthText = (status == "active" or status == "pending") and Own.hearthText(goal) or nil,
		-- A level goal still to reach: the XP it takes (Own.xpLeft).
		xpLeft = goal.t == "level" and (status == "active" or status == "pending") and Own.xpLeft(goal) or nil,
		skillLine = goal.skillLine, spell = goal.spell, faction = goal.faction,
		standing = goal.standing, standingName = goal.standing and standingName(goal.standing) or nil,
		achievement = goal.achievement, criteria = goal.criteria,
		rewards = goal.rewards,
		-- A `complete` goal reads as its quest's objectives (Own.objectiveLines),
		-- "Use <item>:" first while the item the quest hands over is in the bags.
		objectiveLines = goal.t == "complete" and status ~= "na" and Own.objectiveLines(goal, status == "done") or nil,
		useItem = goal.t == "complete" and (status == "active" or status == "pending") and Own.useItemName(goal) or nil,
		-- Group content (compiled `group`: elite, dungeon, raid or an author's
		-- group size); `group` above is the goal's field group.
		party = type(goal.group) == "table" and type(goal.group.kind) == "string" and goal.group or nil,
		-- An escort quest's accept or objective (compiled `escort`).
		escort = goal.escort == true or nil,
		-- A timed quest's accept: the seconds it allows (compiled `limit`,
		-- quests.json; Quests/Timed.lua says so before it is taken).
		limit = goal.t == "accept" and goal.limit or nil,
		-- A collect's source (compiled `from`); `inText`: the goal's text
		-- already names it.
		source = src,
	}
end

local function stepStatusOf(s)
	local step = guide.steps[s]
	if not stepApplies(step) then return "na" end
	if s == current then return "current" end
	if current and s > current then return "upcoming" end
	if stepDone(s) then return "done" end
	-- Behind a look-ahead: still to do. Otherwise passed without being done:
	-- skipped, or live state regressed since the last evaluation (the next
	-- one corrects it).
	if computed and s >= computed and not isSkipped(s) then return "upcoming" end
	return "skipped"
end

---------------------------------------------------------------------------
-- Waypoint and goto arrival
---------------------------------------------------------------------------

-- A hearth goal while the Hearthstone cannot take the player there (#576):
-- seconds until it is ready, 0 with no Hearthstone in the bags; nil when it
-- is ready (or QoL, which reads it, is not loaded).
function Own.hearthWait(goal)
	if goal.t ~= "hearth" then return nil end
	local Q = ns.QoL
	local h = Q and Q.GetHearth and Q.GetHearth()
	if not h then return nil end
	if not h.have then return 0 end
	if (h.remaining or 0) > 0 then return h.remaining end
	return nil
end

-- The inn a hearth goal's location names (Nav/Travel.lua's inns), to walk to.
function Own.hearthInn(goal)
	local nav = ns.Nav
	local inn = nav and nav.FindInn and nav.FindInn(goal.npc, goal.location)
	if inn and inn.map and inn.x and inn.y then return inn end
	return nil
end

-- A hearth goal whose Hearthstone is bound at another inn (#667): the bind
-- location, as the client names it. nil when bound at the goal's inn (the
-- same check as `sethome`), and when the data does not know both inns, so
-- an inn it cannot place never reads as elsewhere.
function Own.hearthElsewhere(goal)
	if goal.t ~= "hearth" then return nil end
	local nav = ns.Nav
	local want = nav and nav.FindInn and nav.FindInn(goal.npc, goal.location)
	local bound = want and nav.BoundInn and nav.BoundInn()
	if not bound or bound == want then return nil end
	local C = Compat()
	local loc, areaName = C.GetBindLocation(), C.GetAreaName
	if not loc or loc == "" or same(loc, goal.location) then return nil end
	if areaName and (same(loc, areaName(want.area)) or same(loc, areaName(goal.area))) then return nil end
	return loc
end

-- Seconds the way to a hearth goal's inn takes without the Hearthstone:
-- walks, flights and boats as the arrow would plan them (Nav.EstimateTravel
-- with noHearth, cached there for a few seconds); nil when unknown.
function Own.hearthTrip(inn)
	local nav = ns.Nav
	if not (inn and nav and nav.EstimateTravel) then return nil end
	local ok, s = pcall(nav.EstimateTravel, nil, inn, nil, true)
	if ok and type(s) == "number" then return s end
	return nil
end

-- What a Hearthstone costs and is worth, as the route planner prices it
-- (Nav/Travel.lua): its cast and loading screen, the time it must save, and
-- how long the way without it must take before its hour's cooldown is spent
-- on a trip (only on a long haul).
function Own.hearthCost()
	local nav = ns.Nav
	return (nav and nav.HEARTH_SECONDS) or 15, (nav and nav.HEARTH_MARGIN) or 120, (nav and nav.HEARTH_MIN_TRIP) or 180
end

-- How to make a hearth goal's trip now: wait (Own.hearthWait), the inn
-- (Own.hearthInn), the trip there without the Hearthstone in seconds
-- (Own.hearthTrip, only while the inn is known), and `go`: travel there
-- yourself, as the Hearthstone waits, is missing or is bound at another inn
-- (Own.hearthElsewhere, #667), or, ready, saves less than the planner's
-- margin over the trip or the trip is shorter than its minimum (the inn is
-- close or a short flight away). Never holds the step: arriving checks the
-- goal off either way.
function Own.hearthPlan(goal)
	local wait = Own.hearthWait(goal)
	local inn = goal.t == "hearth" and Own.hearthInn(goal) or nil
	local trip = inn and Own.hearthTrip(inn)
	local cast, margin, minTrip = Own.hearthCost()
	local go = wait ~= nil or Own.hearthElsewhere(goal) ~= nil or (trip ~= nil and (trip <= cast + margin or trip < minTrip))
	return wait, inn, trip, go
end

-- "under a minute", "23 min".
function Own.minutes(seconds)
	return seconds < 60 and L["under a minute"] or L["%d min"]:format(math.ceil(seconds / 60))
end

-- The line under a hearth goal: how long the Hearthstone waits and, where
-- the trip there is known, whether to set off now or wait for it; with the
-- Hearthstone ready, that travelling is about as fast when it is. Bound at
-- another inn, that first: hearthing would land there (#667). nil when
-- hearthing is the way.
function Own.hearthText(goal)
	if goal.t ~= "hearth" then return nil end
	local wait, inn, trip, go = Own.hearthPlan(goal)
	local elsewhere = Own.hearthElsewhere(goal)
	if elsewhere then
		local _, subject = describe(goal)
		return (inn and L["Your Hearthstone is bound to %s, not %s: walk to the inn"] or L["Your Hearthstone is bound to %s, not %s"]):format(elsewhere, subject)
	end
	if not wait then
		if go then return L["The inn is only %s away: travel there and keep the Hearthstone"]:format(Own.minutes(trip)) end
		return nil
	end
	if wait == 0 then
		return inn and L["No Hearthstone in your bags: walk to the inn"] or L["No Hearthstone in your bags"]
	end
	local left = Own.minutes(wait)
	if trip then
		local cast = Own.hearthCost()
		if trip <= wait + cast then return L["Hearthstone ready in %s; the trip takes %s: set off now"]:format(left, Own.minutes(trip)) end
		return L["Hearthstone ready in %s, sooner than the %s trip: wait for it"]:format(left, Own.minutes(trip))
	end
	return (inn and L["Hearthstone ready in %s: walk to the inn, or wait for it"] or L["Hearthstone ready in %s"]):format(left)
end

-- Ranks for a fallback waypoint: blocking goals first, then optional goals,
-- then notes (which never complete).
local function waypointRank(goal)
	if goal.t == "note" then return 3 end
	if goal.optional then return 2 end
	return 1
end

-- `area`: the spawn area's radius in yards when the goal has spots (Nav
-- counts the whole area as reached); `r` stays the arrival margin. An area
-- objective's waypoint also carries `search` (Nav never says arrived),
-- `spots` (the goal's list, for the map marks) and `spot` (its index).
-- `z`: the goal's height at that point (posOf), for the walking engine's floor.
-- `at`: a group (stepGroups) whose place stands in for the goal's own.
-- `s`: the goal's step, when not the current one (an along goal).
-- `held`: a goal done for the player that a party member still needs
-- (Own.partyAim), pointed at all the same.
local function waypointOf(g, goal, at, s, held)
	s = s or current
	local map, x, y, f, area, z
	local walk
	if at then
		map, x, y, f, z = at.map, at.x, at.y, at.f, at.z
	else
		map, x, y, f, area, z = posOf(goal)
		-- A hearth goal has no place of its own; while the Hearthstone waits,
		-- is bound at another inn (#667) or travelling is about as fast
		-- (Own.hearthPlan), the arrow leads to its inn (#576).
		if not map and goal.t == "hearth" then
			local _, inn, _, go = Own.hearthPlan(goal)
			if go and inn then map, x, y, f, walk = inn.map, inn.x, inn.y, inn.f, true end
		end
	end
	if not (map and x and y) or not goalApplies(goal) or unavailableFor(goal) or Own.goalSkipped(s, g) or Own.lostGoal(goal)
		or (not held and goalDone(s, g, goal)) then return nil end
	local verb, subject, kind, detail = describe(goal, s)
	local many = area and #goal.spots > 1
	return {
		map = map, x = x, y = y, f = f, z = z,
		label = walk and L["Walk to %s"]:format(subject) or (goalText(goal, verb, subject, detail, kind)),
		stepIndex = s, goalIndex = g, kind = goal.t, quest = goal.quest,
		r = goal.r or DEFAULT_RADIUS, area = area,
		search = area and goal.spread or nil,
		spots = many and goal.spots or nil, spot = many and Spots.index(goal) or nil,
	}
end

-- A "Go to" naming its step (the window's header) in a field group that holds
-- other goals: it names the area those goals are in, not a goal of its own.
function Own.isHeader(step, goal, grp)
	if goal.t ~= "goto" or not step.title or goal.text ~= step.title or not grp or grp.kind ~= "here" then return false end
	for _, j in ipairs(grp.goals) do
		local other = step.goals[j]
		if other ~= goal and other.t ~= "note" and goalApplies(other) then return true end
	end
	return false
end

-- The current goal of step s, the one the window marks and the arrow leads
-- to: in the focus group, the first open blocking goal, else the first open
-- optional one; the group's header only when nothing else is open. When that
-- first blocking goal is a field goal (kill, collect, interact with a place)
-- and the group has two or more such goals open, the nearest of them to the
-- player takes its place (Own.nearestField: sticky, never switched in a
-- fight). A goto before a grind (Own.grindAfter) gives way to it: the arrow
-- leads to the grind mob's nearest spawn area, the goto only where the mob
-- has none. A flight step the arrow leads to the flight's end (Own.flyAim)
-- marks its flight, not the walk to the flight master it names. Returns its
-- index (or nil) and the open header's index (or nil).
function Own.currentGoal(s, groups, focus)
	local grp = focus and groups[focus]
	if not grp then return nil end
	local step = guide.steps[s]
	local _, flown = Own.flyAimed(s)
	if flown then
		for _, g in ipairs(grp.goals) do
			if g == flown then return g, nil end
		end
	end
	local header, optional, first, fields
	for _, g in ipairs(grp.goals) do
		local goal = step.goals[g]
		if goal.t ~= "note" and goalApplies(goal) and not unavailableFor(goal) and not Own.goalSkipped(s, g) and not Own.lostGoal(goal)
			and not goalDone(s, g, goal) then
			if Own.isHeader(step, goal, grp) then
				header = header or g
			elseif not goal.optional then
				first = first or g
				if Own.isField(goal) then
					fields = fields or {}
					fields[#fields + 1] = g
				end
			else
				optional = optional or g
			end
		end
	end
	if first and step.goals[first].t == "goto" then first = Own.grindAfter(s, grp, first) or first end
	if first then
		if fields and #fields >= 2 and fields[1] == first then
			first = Own.nearestField(s, fields)
		else
			Own.nearPick[step] = nil
		end
		return first, header or Own.headerOf(s, grp, first)
	end
	return optional or header, header
end

-- The open header of a group after goal index `after` (a header comes first,
-- so this is rarely reached).
function Own.headerOf(s, grp, after)
	local step = guide.steps[s]
	for _, g in ipairs(grp.goals) do
		local goal = step.goals[g]
		if g > after and Own.isHeader(step, goal, grp) and not goalDone(s, g, goal) then return g end
	end
	return nil
end

-- Whether group grp holds a goal for quest q.
function Own.dealsWith(grp, goals, q)
	for _, g in ipairs(grp.goals) do
		if goals[g].quest == q then return true end
	end
	return false
end

-- The arrow's place for a turn-in of quest q that is not ready while along
-- steps hold its work (#853, #862): the nearest of those goals with a place
-- (Own.fieldDistance; the first where nothing is measurable), as if the
-- player had chosen it (Engine.AimAlong). Nil when none has one.
function Own.alongAim(q)
	local c, px, py = Compat().GetPlayerWorldPosition()
	local best, bestD
	for _, e in ipairs(Own.alongWork(q)) do
		local goal = guide.steps[e[1]].goals[e[2]]
		local wp = waypointOf(e[2], goal, nil, e[1])
		if wp then
			local d = c and Own.fieldDistance(goal, c, px, py)
			if not best or (d and (not bestD or d < bestD)) then best, bestD = wp, d end
		end
	end
	return best
end

-- While the window asks about a quest that left the log (Engine.LostQuestion),
-- the arrow leads back to its giver, where Go back for it takes the route
-- (#1365): its first accept the character can take before the step the hold
-- keeps, pointed at although the hold reads it done. Nil when none has a place.
function Own.lostAim()
	local q = Engine.LostQuestion()
	if not q then return nil end
	local upTo = ns.CharState().lostQuests[guide.id][q]
	for _, a in ipairs(layoutOf(guide).accepts[q] or NONE) do
		if a.s < upTo and stepApplies(a.step) and not isSkipped(a.s) then
			local wp = waypointOf(tonumber(a.key:match(":(%d+)$")), a.goal, nil, a.s, true)
			if wp then return wp end
		end
	end
	return nil
end

-- Step s's quest that failed in the log (Own.failedQuest), with nothing else
-- open in the step: the arrow leads to its giver, where it is taken again
-- once abandoned (the accept nearest before s, else the first in the guide,
-- pointed at although it reads done). Nil when no accept has a place.
function Own.failedAim(s)
	for _, goal in ipairs(guide.steps[s].goals) do
		local q = goal.quest
		if q and goal.t ~= "accept" and goalApplies(goal) and Own.failedQuest(q) then
			local list, best = layoutOf(guide).accepts[q] or NONE, nil
			for _, a in ipairs(list) do -- in step order
				if stepApplies(a.step) and (a.s <= s or not best) then best = a end
			end
			local wp = best and waypointOf(tonumber(best.key:match(":(%d+)$")), best.goal, nil, best.s, true)
			if wp then return wp end
		end
	end
	return nil
end

-- The arrow's goal: the one the player chose in the current step (a row
-- click, the next spot), while it is open and its quest is not waiting for
-- its accept in the step (Own.acceptFirst); else the current goal's own place;
-- else the header's; else the focus group's first open located goal
-- (blocking, then optional, then notes); else, for a quest's current goal,
-- the place of the focus group or of the nearest group before it for that
-- quest. The arrow only ever points at a goal the guide window shows. A done
-- step (no focus, e.g. viewed with Prev) has nothing to point at, even when
-- optional goals are left open; nor has a Class guide the character cannot
-- start yet (Own.startGate), or another race's starting zone the player has
-- not reached (Own.awayStart), on its live step. An along goal the player
-- chose (Engine.AimAlong) leads while it is listed and open; so does, before
-- a turn-in that is not ready, its quest's work in along steps (Own.alongAim);
-- so does the "While you're here" line the player clicked (Engine.AimWhileHere),
-- while it shows. On the live step, a quest that left the log and waits for
-- the player's answer leads back to its giver (Own.lostAim), whose accept the
-- window's notice names. A flight step leads to the flight's end while the
-- travel planner flies there (Own.flyAim), past the flight master it names.
local function findWaypoint()
	if not current or (current == computed and (Own.startGate(guide) or Own.awayStart(guide))) then return nil end
	local goals = guide.steps[current].goals
	if aim then
		for g, goal in ipairs(goals) do
			if goal == aim and not Own.acceptFirst(current, goal) then
				local wp = waypointOf(g, goal)
				if wp then return wp end
			end
		end
		local as, ag = Own.alongOf(aim)
		local wp = as and waypointOf(ag, aim, nil, as)
		if wp then return wp end
		local here = Own.hereOf(aim)
		wp = here and waypointOf(here.g, aim, nil, here.s)
		if wp then return wp end
	end
	if current == computed then
		local wp = Own.lostAim() or Own.partyAim(current)
		if wp then return wp end
	end
	local fly = Own.flyAim(current)
	if fly then return fly end
	local groups, focus = stepGroups(current)
	local grp = focus and groups[focus]
	if not grp then return current == computed and Own.failedAim(current) or nil end
	local cg, header = Own.currentGoal(current, groups, focus)
	if cg and goals[cg].t == "turnin" then
		local wp = Own.alongAim(goals[cg].quest)
		if wp then return wp end
	end
	local wp = cg and waypointOf(cg, goals[cg])
	if wp then return wp end
	wp = header and waypointOf(header, goals[header])
	if wp then return wp end
	for rank = 1, 3 do
		for _, g in ipairs(grp.goals) do
			local goal = goals[g]
			if waypointRank(goal) == rank then
				wp = waypointOf(g, goal)
				if wp then return wp end
			end
		end
	end
	-- Nothing open in the focus group has a place (a bare `complete` after its
	-- giver's goals, #256): a quest's goal takes the place of its group's work
	-- (a goto already reached), else of the nearest group before it that
	-- deals with the same quest (the giver, an escort's start). Never a later
	-- group's: the window does not show it yet, and a turn-in's place does not
	-- lead to the objective.
	local quest = cg and goals[cg].quest
	if quest then
		if grp.map then return waypointOf(cg, goals[cg], grp) end
		for i = focus - 1, 1, -1 do
			local before = groups[i]
			if before.map and Own.dealsWith(before, goals, quest) then return waypointOf(cg, goals[cg], before) end
		end
	end
	return nil
end

local function sameWaypoint(a, b)
	if a == b then return true end
	if not a or not b then return false end
	return a.stepIndex == b.stepIndex and a.goalIndex == b.goalIndex and a.map == b.map
		and a.x == b.x and a.y == b.y and a.f == b.f
		and a.label == b.label and a.kind == b.kind and a.r == b.r
end

local worldOf = setmetatable({}, { __mode = "k" }) -- goal -> { c, wx, wy }

local function goalWorld(goal)
	local w = worldOf[goal]
	if not w then
		local c, wx, wy = Compat().MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if not c then return nil end
		w = { c, wx, wy }
		worldOf[goal] = w
	end
	return w[1], w[2], w[3]
end

-- Field goals: work done out at a place, where a step can hold several
-- (Garren's Haunt: the Graverobbers, the Mongrels, the Doom Weed). With two
-- or more open, the arrow leads to the nearest (Own.currentGoal); written
-- order still orders the window's list. Mobs at the player's level first
-- (#827): the nearest place whose mobs are at most Spots.ABOVE levels above
-- the player (a spot's `lvl`, else its goal's; a place with neither counts),
-- of any open goal; only with no such place the nearest of all. Sticky: another goal
-- takes over only once it is NEAR_SHARE of the current one's distance and
-- NEAR_YARDS nearer, or the current one is done or has no place at the
-- player's level while another has; never while the player is in a fight.
Own.FIELD = { kill = true, collect = true, interact = true }
Own.NEAR_SHARE, Own.NEAR_YARDS = 0.75, 40
Own.nearPick = setmetatable({}, { __mode = "k" }) -- step -> goal index the arrow is on

-- A grind: `level N grind <npc>`, placed by the compiler at the mob's spawn
-- areas (spots); a field goal like a kill. Without spawn data it has no place,
-- and the step's goto leads.
function Own.isGrind(goal)
	return goal.t == "level" and goal.grind ~= nil and goal.spots ~= nil and goal.map ~= nil
end

function Own.isField(goal)
	return (Own.FIELD[goal.t] == true or Own.isGrind(goal)) and not goal.candidates and (goal.spots ~= nil or (goal.map ~= nil and goal.x ~= nil and goal.y ~= nil))
end

-- The grind after goal g (a goto) in group grp of step s that the arrow takes
-- instead: open, and with only notes, optional, done or not applicable goals
-- between them (another goto or open work keeps the goto). Nil when none.
function Own.grindAfter(s, grp, g)
	local goals = guide.steps[s].goals
	for _, j in ipairs(grp.goals) do
		if j > g then
			local goal = goals[j]
			local open = goalApplies(goal) and not unavailableFor(goal) and not Own.goalSkipped(s, j) and not goalDone(s, j, goal)
			if open and Own.isGrind(goal) then return j end
			if goal.t == "goto" or (open and goal.t ~= "note" and not goal.optional) then return nil end
		end
	end
	return nil
end

-- Yards from the player (c, px, py) to a field goal's nearest spawn area
-- (its edge; alternatives left out, as the spot picks leave them), else to
-- its point; nil on another continent. Second: the same to its nearest area
-- whose mobs are at most `top` levels (its `lvl`, else the goal's; one with
-- neither counts; nil without one, or with top nil). Places left after a
-- dwell (Spots.isLeft) do not count: a goal with every place left measures
-- nil, so another field goal of the step takes over.
function Own.fieldDistance(goal, c, px, py, top)
	local best, low
	local lvl = goal.lvl
	local now, places = GetTime(), false
	for _, s in ipairs(goal.spots or NONE) do
		if not s.alt then
			places = true
			if not Spots.isLeft(goal, s, now) then
				local d = Spots.edge(goal, s, c, px, py)
				if d then
					if not best or d < best then best = d end
					local l = s.lvl or lvl
					if top and not (l and l > top) and (not low or d < low) then low = d end
				end
			end
		end
	end
	if best or places or not (goal.map and goal.x and goal.y) or Spots.isLeft(goal, goal, now) then return best, low end
	local gc, gx, gy = goalWorld(goal)
	if gc ~= c then return nil end
	local d = ((gx - px) ^ 2 + (gy - py) ^ 2) ^ 0.5
	return d, top and not (lvl and lvl > top) and d or nil
end

-- What changes while the player works on goal g of step s: its count (an
-- objective's, the bags'), for a level goal the XP. A dwell starts again when
-- it changes (Own.dwelt).
function Own.workSign(s, g, goal)
	if goal.t == "level" then return (UnitLevel and UnitLevel("player") or 0) * 1e7 + (UnitXP and UnitXP("player") or 0) end
	local done, cur = goalDone(s, g, goal)
	if done then return -1 end
	return tonumber(cur) or 0
end

-- The place the arrow leads to for goal (its chosen spot; a goal without
-- spots, its point) and the yards from the player to its edge, or nil: not
-- measurable, or a spot picked by hand not reached yet (it holds).
function Own.dwellPlace(goal, c, px, py)
	if goal.spots then
		local s = Spots.chosen[goal]
		if not s or Spots.pinned[goal] == s then return nil end
		return s, Spots.edge(goal, s, c, px, py)
	end
	if not (goal.map and goal.x and goal.y) then return nil end
	local gc, gx, gy = goalWorld(goal)
	if gc ~= c then return nil end
	return goal, ((gx - px) ^ 2 + (gy - py) ^ 2) ^ 0.5
end

-- The time of the latest work noted (Spots.work) on place's ground: within
-- its arrival radius and Spots.SWITCH yards around its edge (inside: within
-- the arrival radius only), in the last Spots.FORGET seconds; nil when none.
-- place: a spot of goal, or goal itself (a goal without spots, at its point).
function Own.workedNear(goal, place, now, inside)
	local reach = (goal.r or DEFAULT_RADIUS) + (inside and 0 or Spots.SWITCH)
	local latest
	for _, e in ipairs(Spots.work) do
		if now - e.t <= Spots.FORGET and not (latest and e.t <= latest) then
			local d
			if place == goal then
				local gc, gx, gy = goalWorld(goal)
				if gc == e.c then d = ((gx - e.x) ^ 2 + (gy - e.y) ^ 2) ^ 0.5 end
			else
				d = Spots.edge(goal, place, e.c, e.x, e.y)
			end
			if d and d <= reach then latest = e.t end
		end
	end
	return latest
end

-- The dwell (Spots, "Dwell"): true once the player has stood within the
-- arrival radius of field goal g's place for Spots.DWELL seconds, moving no
-- more than Spots.STILL yards, out of combat, with its work unchanged
-- (Own.workSign); the place is then left.
-- A place worked lately is never left (Own.workedNear): a fight anywhere,
-- or progress on the goal, is noted where the player stands (Spots.noteWork),
-- and a place with such a note within its radius and Spots.SWITCH yards around
-- it (a pull from the edge) in the last Spots.FORGET seconds holds, whichever
-- goal the note was made for: the drink or the walk to the next pull at a camp
-- being cleared never moves the arrow (ArrowGuard's replay: 13.75 moves per
-- 10 h off camps still worked with no such guard). Coming in, a fight or
-- progress starts the count again.
function Own.dwelt(s, g, goal, c, px, py)
	local place, d = Own.dwellPlace(goal, c, px, py)
	local st = Spots.stay[goal]
	local reach = goal.r or DEFAULT_RADIUS
	if not (place and d and d <= reach + Spots.SWITCH) then
		if st then Spots.stay[goal] = nil end
		return false
	end
	local now, sign = GetTime(), Own.workSign(s, g, goal)
	if not st then
		Spots.stay[goal] = { place = place, since = now, sign = sign, x = px, y = py }
		return false
	end
	if st.place ~= place then
		st.place, st.since, st.sign, st.x, st.y = place, now, sign, px, py
		return false
	end
	if (UnitAffectingCombat and UnitAffectingCombat("player")) or st.sign ~= sign then
		Spots.noteWork(c, px, py, now)
		st.since, st.sign = now, sign
		return false
	end
	-- Near it, not in it yet: the count starts on arrival. Walking on (more
	-- than Spots.STILL yards from where the count started): it starts again,
	-- so running across a wide camp to its middle never counts (ArrowGuard).
	if d > reach or (px - st.x) ^ 2 + (py - st.y) ^ 2 > Spots.STILL * Spots.STILL then
		st.since, st.x, st.y = now, px, py
		return false
	end
	if Own.workedNear(goal, place, now) then return false end
	if now - st.since < Spots.DWELL then return false end
	Spots.left[place], Spots.seen[place] = now, now
	Spots.stay[goal] = nil
	return true
end

-- Of step s's open field goals `list` (indexes, written order), the one the
-- arrow is on: the one it was on while it is open and nothing is clearly
-- nearer, or the player fights; else the nearest, at the player's level
-- first (Own.FIELD). Where nothing is measurable (no position, another
-- continent), the first. Sets Own.nearMoved when the pick changes (the
-- arrival poll re-evaluates then).
function Own.nearestField(s, list)
	local step = guide.steps[s]
	local cur = Own.nearPick[step]
	local open = false
	for _, g in ipairs(list) do
		if g == cur then open = true end
	end
	if not open then cur = nil end
	local c, px, py = Compat().GetPlayerWorldPosition()
	local fighting = UnitAffectingCombat and UnitAffectingCombat("player")
	local pick = cur
	-- Held while the player fights and Spots.SETTLE seconds after (Spots.busy).
	if c and not (cur and (fighting or Spots.busy())) then
		local top = player and player.level and player.level + Spots.ABOVE
		local best, bestD, curD, low, lowD, curLow
		for _, g in ipairs(list) do
			local d, dl = Own.fieldDistance(step.goals[g], c, px, py, top)
			if g == cur then curD, curLow = d, dl end
			if d and (not bestD or d < bestD) then best, bestD = g, d end
			if dl and (not lowD or dl < lowD) then low, lowD = g, dl end
		end
		-- A place at the player's level: measured to those places only.
		if low then best, bestD, curD = low, lowD, curLow end
		if best and (not cur or not curD or (bestD < curD * Own.NEAR_SHARE and bestD < curD - Own.NEAR_YARDS)) then pick = best end
	end
	pick = pick or list[1]
	if pick ~= Own.nearPick[step] then
		Own.nearPick[step] = pick
		Own.nearMoved = true
		-- Its spawn area from where the player stands now, not from where it
		-- was first picked.
		local goal = step.goals[pick]
		if c and goal.spots and Spots.chosen[goal] then Spots.repick(goal, c, px, py) end
	end
	return pick
end

-- Party sync's "wait for the group" (Quests/Party.lua, party.waitForGroup).
-- The live step stays while a member who holds the group still needs one of
-- its objectives that is done for the player (Party.Waiting): computeCurrent
-- asks this of the live step only, so the route never goes back for one. An
-- along step never waits.
function Own.partyHold(s)
	local P = ns.Party
	local step = guide.steps[s]
	if not (P and P.Waiting) or step.along then return false end
	for g, goal in ipairs(step.goals) do
		if goal.quest and goal.oi and blocks(goal) and goalApplies(goal) and goalDone(s, g, goal) and P.Waiting(goal) then return true end
	end
	return false
end

-- The arrow while the group waits: once every goal of step s is done for the
-- player but turn-ins the group holds (Party.HoldsQuest), the nearest of the
-- objectives a member still needs (Own.nearestField), its label naming them
-- ("For Ana: Kill Kobold Vermin"). Nil otherwise.
function Own.partyAim(s)
	local P = ns.Party
	if not (P and P.Waiting) then return nil end
	local goals = guide.steps[s].goals
	local list, names
	for g, goal in ipairs(goals) do
		if Own.holds(s, goal) and goalApplies(goal) and not unavailableFor(goal) and not Own.goalSkipped(s, g) then
			local done = goalDone(s, g, goal)
			if not done and not (goal.t == "turnin" and P.HoldsQuest(goal.quest)) then return nil end
			local w = done and goal.quest and goal.oi and P.Waiting(goal)
			if w then
				list, names = list or {}, names or {}
				list[#list + 1] = g
				local who = {}
				for i, m in ipairs(w) do who[i] = m.name end
				names[g] = table.concat(who, ", ")
			end
		end
	end
	if not list then return nil end
	local pick = Own.nearestField(s, list)
	local wp = waypointOf(pick, goals[pick], nil, s, true)
	if wp then wp.label = L["For %s: %s"]:format(names[pick], wp.label) end
	return wp
end

---------------------------------------------------------------------------
-- Tabs. Each open guide is a tab with its own step state. The locals at the
-- top (guide, current, computed, pin, ...) hold one tab's state at a time,
-- the "loaded" tab; at rest that is always the active tab. Work on another
-- tab loads it with use(tab) and switches back with useActive().
---------------------------------------------------------------------------

local MAX_TABS = 6
Engine.MAX_TABS = MAX_TABS

local tabs = {} -- { { guide, current, computed, pin, ... }, ... }
local activeIndex = 0 -- 0 when no tab is open
local loaded -- tab whose state is in the locals
local tabsDirty = false -- TABS_CHANGED pending

-- The loaded tab's view of another step than the live one, saved as
-- CharState().pins[guideId] = { step, done } so a reload shows the step the
-- player was looking at.
function Own.savePin()
	if not guide then return end
	local s = ns.CharState()
	local pins = s.pins
	local stored = type(pins) == "table" and pins[guide.id] or nil
	if pin then
		local done = pinDone and true or false
		if not (type(stored) == "table" and stored.step == pin and stored.done == done) then
			if type(pins) ~= "table" then
				pins = {}
				s.pins = pins
			end
			pins[guide.id] = { step = pin, done = done }
		end
	elseif stored ~= nil then
		pins[guide.id] = nil
	end
end

-- Write the loaded state back into its tab.
local function sync()
	local t = loaded
	if not t then return end
	t.guide, t.current, t.computed, t.pin, t.pinDone, t.aim = guide, current, computed, pin, pinDone, aim
	t.passedUpTo, t.autoChain, t.sawIncomplete, t.lastSig, t.placing = passedUpTo, autoChain, sawIncomplete, lastSig, placing
	-- Saved only when the view moved (sync runs on every tab switch).
	if t.savedPin ~= pin or t.savedPinDone ~= pinDone or t.savedGuide ~= guide then
		Own.savePin()
		t.savedPin, t.savedPinDone, t.savedGuide = pin, pinDone, guide
	end
end

local function use(tab)
	if loaded == tab then return end
	sync()
	loaded = tab
	if tab then
		guide, current, computed, pin, pinDone, aim = tab.guide, tab.current, tab.computed, tab.pin, tab.pinDone, tab.aim
		passedUpTo, autoChain, sawIncomplete, lastSig = tab.passedUpTo or 0, tab.autoChain, tab.sawIncomplete, tab.lastSig
		placing = tab.placing
	else
		guide, current, computed, pin, pinDone, aim = nil, nil, nil, nil, nil, nil
		passedUpTo, autoChain, sawIncomplete, lastSig, placing = 0, nil, nil, nil, nil
	end
end

local function useActive() use(tabs[activeIndex]) end

local function tabIndexOf(id)
	sync()
	for i = 1, #tabs do
		if tabs[i].guide.id == id then return i end
	end
	return nil
end

-- Guides ever opened in a tab, for the picker's "started" state.
local function markStarted(id)
	local flags = ns.CharState().flags
	if type(flags.started) ~= "table" then flags.started = {} end
	flags.started[id] = true
end

-- A guide's shape: its steps' verbs and ids, hashed. Check-offs, skips and the
-- saved view are stored by step/goal position, so when a pack update changes
-- the shape they are carried over to the steps it kept (Own.remap); steps it
-- changed or dropped lose theirs.
Own.partsCache = setmetatable({}, { __mode = "k" })

-- Each step's verbs and ids ("turnin:783,accept:7"), per guide.
function Own.stepParts(g)
	local parts = Own.partsCache[g]
	if parts then return parts end
	parts = {}
	for s, step in ipairs(g.steps) do
		local ids = {}
		for i, goal in ipairs(step.goals) do
			ids[i] = goal.t .. ":" .. tostring(goal.quest or goal.npc or goal.item or goal.spell or goal.object
				or goal.faction or goal.achievement or goal.level or goal.location or goal.map or "")
		end
		parts[s] = table.concat(ids, ",")
	end
	Own.partsCache[g] = parts
	return parts
end

function Own.hash(str)
	local h = 5381
	for i = 1, #str do h = (h * 33 + str:byte(i)) % 4294967296 end
	return h
end

local shapeCache = setmetatable({}, { __mode = "k" })
local function shapeOf(g)
	local h = shapeCache[g]
	if h then return h end
	h = #g.steps .. "-" .. Own.hash(table.concat(Own.stepParts(g), "|"))
	shapeCache[g] = h
	return h
end

-- Per step, the hash of its verbs and ids (CharState().stepKeys[guideId]).
-- Cached per guide table: read-only (checkShape stores a copy).
Own.keysCache = setmetatable({}, { __mode = "k" })
function Own.stepKeys(g)
	local keys = Own.keysCache[g]
	if keys then return keys end
	keys = {}
	for s, part in ipairs(Own.stepParts(g)) do keys[s] = Own.hash(part) end
	Own.keysCache[g] = keys
	return keys
end

-- Old step index -> new index for the steps a pack update kept, in order:
-- the longest common subsequence of the two key lists.
function Own.matchSteps(old, new)
	local n, m = #old, #new
	local len = {}
	for i = n + 1, 1, -1 do
		local row, below = {}, len[i + 1]
		for j = m + 1, 1, -1 do
			if i > n or j > m then
				row[j] = 0
			elseif old[i] == new[j] then
				row[j] = below[j + 1] + 1
			else
				row[j] = math.max(below[j], row[j + 1])
			end
		end
		len[i] = row
	end
	local map, i, j = {}, 1, 1
	while i <= n and j <= m do
		if old[i] == new[j] then
			map[i] = j
			i, j = i + 1, j + 1
		elseif len[i + 1][j] >= len[i][j + 1] then
			i = i + 1
		else
			j = j + 1
		end
	end
	return map
end

-- Move guide `id`'s check-offs ("s:g"), skips (s, "s:g"), stored `when`
-- outcomes (s), saved view and held lost quests (CharState().lostQuests) to
-- the new step numbers. A pack update and the Engine's own plan of a guide's
-- steps (Own.withFeeders) both come here. `map` is the steps kept (old
-- index -> new); with `old` (the save's step keys) and the new guide `g`, a
-- step the update changed is found by its goals (Own.legacyMaps), so its
-- check-offs, skips and view go to the step that has the same goal now
-- instead of being dropped; one with nothing in common is dropped.
function Own.remap(id, map, old, g)
	local s = ns.CharState()
	local stepTo, goalTo, changedGoals = Own.legacyMaps(id, map, old, g)
	local function moved(k)
		if type(k) == "number" then return stepTo(k) end
		local a, b = tostring(k):match("^(%d+):(%d+)$")
		if not a then return nil end
		local j, gi = goalTo(tonumber(a), tonumber(b))
		return j and (j .. ":" .. gi) or nil
	end
	for _, field in ipairs({ "manual", "skipped", "when" }) do
		local old = s[field][id]
		if type(old) == "table" then
			local out = {}
			-- A changed step skipped whole whose goals went to another step too (a
			-- step split in two): that step goes skipped when all of its goals came
			-- from skipped steps (Skyborne's Raan Wildwind step, whose Zerril
			-- Softbreeze half came back after an update and pulled the player back).
			local fromSkip = {}
			for k, v in pairs(old) do
				local nk = moved(k)
				if nk then out[nk] = v end
				if field == "skipped" and type(k) == "number" and changedGoals then
					for b = 1, changedGoals(k) do
						local j, gi = goalTo(k, b)
						if j and j ~= nk then
							local f = fromSkip[j] or {}
							fromSkip[j] = f
							f[gi] = v
						end
					end
				end
			end
			for j, f in pairs(fromSkip) do
				local all, v = g and g.steps[j] ~= nil, nil
				for gi in ipairs(all and g.steps[j].goals or NONE) do
					if f[gi] == nil then all = false break end
					v = f[gi]
				end
				if all and v ~= nil and out[j] == nil then out[j] = v end
			end
			s[field][id] = next(out) and out or nil
		end
	end
	-- What each skip stored on the way (Own.skipStore): its step and the
	-- steps it names, those kept only.
	local stored = type(s.skipStored) == "table" and s.skipStored[id]
	if type(stored) == "table" then
		local out = {}
		for k, rec in pairs(stored) do
			local nk = type(k) == "number" and map[k]
			if nk and type(rec) == "table" then
				local steps = {}
				for t, v in pairs(type(rec.steps) == "table" and rec.steps or NONE) do
					if type(t) == "number" and map[t] then steps[map[t]] = v end
				end
				out[nk] = { steps = steps, feed = rec.feed }
			end
		end
		s.skipStored[id] = next(out) and out or nil
	end
	-- The saved view: its step's new number, else the step sharing its goals,
	-- else the next step kept after it (never dropped while anything is kept).
	local p = type(s.pins) == "table" and s.pins[id]
	if p then
		local to = type(p) == "table" and tonumber(p.step) and (stepTo(p.step) or Own.nextKept(map, p.step)) or nil
		s.pins[id] = to and { step = to, done = p.done } or nil
	end
	-- A quest held for the player's answer (Own.holdLost) holds the accepts
	-- before the step the route was on: that step's new number, or, when it
	-- went, the next kept step's (after the last kept one, past it). Nothing
	-- kept at all: left as it was.
	local lost = type(s.lostQuests) == "table" and s.lostQuests[id]
	if type(lost) == "table" and next(map) ~= nil then
		for q, upTo in pairs(lost) do
			local to, last = map[upTo], 0
			if not to then
				for k, j in pairs(map) do
					if k > upTo and (not to or j < to) then to = j end
					if k < upTo and j > last then last = j end
				end
			end
			lost[q] = to or (last + 1)
		end
	end
end

-- The first step kept after old step k: its new number, else one past the last
-- kept before k; nil with nothing kept.
function Own.nextKept(map, k)
	if next(map) == nil then return nil end
	local to, last = map[k], 0
	if to then return to end
	for i, j in pairs(map) do
		if i > k and (not to or j < to) then to = j end
		if i < k and j > last then last = j end
	end
	return to or (last + 1)
end

-- An old step's goals as the Engine names them (Own.stepParts), from the save's
-- step key: a step of the new guide (kept) or one an earlier release had
-- (Own.legacy, tools/legacy-steps.js). -> { "turnin:783", ... } | nil
function Own.legacyGoals(id, key)
	local L = Own.legacy()
	local p = L and L[id] and L[id][key]
	if type(p) ~= "string" then return nil end
	local out = {}
	for x in (p .. ","):gmatch("([^,]*),") do out[#out + 1] = x end
	return out
end

-- The earlier releases' steps (Core/LegacySteps.lua), built on first use: only
-- an update that changed a saved guide asks (checkShape). Own.legacyDrop lets
-- them go once the saved tabs are mapped (the first QUEST_LOG_UPDATE); a guide
-- opened later maps by its kept steps alone.
function Own.legacy()
	if Own.legacyTable == nil then
		local load = ns.LegacyStepsLoad
		Own.legacyTable = load and load() or false
	end
	return Own.legacyTable or nil
end

function Own.legacyDrop()
	ns.LegacyStepsLoad, Own.legacyTable = nil, false
end

-- Old step -> new step, and old goal (step, index) -> new (step, index), for
-- Own.remap. Kept steps keep their goals' places. A changed step goes to the
-- new step that shares the most of its quest goals (a goal of a quest: verb
-- and quest id), the nearest to where it stood among equals; a goal of it to
-- that step when that step has the goal, else (a quest's goal only) to the
-- nearest step that has it. Without the old goals (no `old`, or a step no
-- release had): dropped as before.
function Own.legacyMaps(id, map, old, g)
	local function plain(k) return map[k] end
	if type(old) ~= "table" or not g then
		return plain, function(a, b)
			local j = map[a]
			return j, j and b or nil
		end
	end
	local parts = Own.stepParts(g)
	local newGoals = {}
	local function goalsOf(j)
		local list = newGoals[j]
		if not list then
			list = {}
			for x in ((parts[j] or "") .. ","):gmatch("([^,]*),") do list[#list + 1] = x end
			newGoals[j] = list
		end
		return list
	end
	-- A goal named by its quest for sure: an accept, a hand-in or a `complete`
	-- (a kill or collect without a quest is named by its creature or item).
	local QUEST_VERBS = { accept = true, turnin = true, complete = true }
	local function questGoal(x)
		local v, q = x:match("^(%a+):(%d+)$")
		return q ~= nil and QUEST_VERBS[v] == true
	end
	-- A planned guide (Own.rebuilt): a step of the guide as registered that the
	-- plan copied with fewer goals is that copy, its goals the registered step's.
	local baseAt, baseParts = {}, nil
	if g.base and g.fromBase then
		baseParts = Own.stepParts(g.base)
		for b, key in ipairs(Own.stepKeys(g.base)) do
			if not baseAt[key] then baseAt[key] = b end
		end
	end
	-- A step the update moved whole (the same goals elsewhere, past the kept
	-- order): that step, among those not kept.
	local keptNew, hereAt = {}, {}
	for _, j in pairs(map) do keptNew[j] = true end
	for j, key in ipairs(Own.stepKeys(g)) do
		if not keptNew[j] and not hereAt[key] then hereAt[key] = j end
	end
	local function oldGoals(k)
		local h = hereAt[old[k]]
		if h then return goalsOf(h) end
		local b = baseAt[old[k]]
		if b then
			local list = {}
			for x in ((baseParts[b] or "") .. ","):gmatch("([^,]*),") do list[#list + 1] = x end
			return list
		end
		return Own.legacyGoals(id, old[k])
	end
	local best = {}
	local function stepTo(k)
		if map[k] then return map[k] end
		if best[k] ~= nil then return best[k] or nil end
		if hereAt[old[k]] then
			best[k] = hereAt[old[k]]
			return best[k]
		end
		local b = baseAt[old[k]]
		if b and g.fromBase[b] then
			best[k] = g.fromBase[b]
			return best[k]
		end
		local goals = oldGoals(k)
		local want = {}
		for _, x in ipairs(goals or NONE) do
			if questGoal(x) then want[x] = true end
		end
		local near = Own.nextKept(map, k) or k
		local top, topN = nil, 0
		if next(want) then
			for j = 1, #g.steps do
				local n = 0
				for _, x in ipairs(goalsOf(j)) do
					if want[x] then n = n + 1 end
				end
				if n > topN or (n == topN and n > 0 and math.abs(j - near) < math.abs(top - near)) then top, topN = j, n end
			end
		end
		best[k] = top or false
		return top
	end
	local function goalTo(a, b)
		local j = map[a]
		if j then return j, b end
		local goals = oldGoals(a)
		local x = goals and goals[b]
		if not x or x == "" then return nil end
		local to = stepTo(a)
		if to then
			for gi, y in ipairs(goalsOf(to)) do
				if y == x then return to, gi end
			end
		end
		-- Else the nearest step with that goal: within the steps that took the
		-- old one's place (between the kept steps around it) for any goal, or
		-- anywhere for a goal named by something of its own (a quest, an item,
		-- a flight's landing; not a bare `train` or a zone's `goto`).
		local lo, hi = 1, #g.steps
		for k, j in pairs(map) do
			if k < a and j + 1 > lo then lo = j + 1 end
			if k > a and j - 1 < hi then hi = j - 1 end
		end
		local v, id = x:match("^(%a+):(.*)$")
		local own = id ~= nil and id ~= "" and v ~= "goto"
		local near = Own.nextKept(map, a) or a
		local topJ, topG, topIn
		for jj = 1, #g.steps do
			local inGap = jj >= lo and jj <= hi
			if inGap or own then
				for gi, y in ipairs(goalsOf(jj)) do
					if y == x then
						local better = not topJ or (inGap and not topIn)
							or (inGap == topIn and math.abs(jj - near) < math.abs(topJ - near))
						if better then topJ, topG, topIn = jj, gi, inGap end
					end
				end
			end
		end
		return topJ, topG
	end
	-- The number of goals of an old step the update changed (0 for one kept or unknown).
	local function changedGoals(k)
		if map[k] then return 0 end
		local list = oldGoals(k)
		return list and #list or 0
	end
	return stepTo, goalTo, changedGoals
end

-- What Own.remap rewrites for guide id, copied (Own.snapRestore puts it back).
Own.SNAP_FIELDS = { "manual", "skipped", "when", "skipStored", "pins", "lostQuests" }
function Own.deepCopy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for k, x in pairs(v) do out[k] = Own.deepCopy(x) end
	return out
end
function Own.snapState(id)
	local s, snap = ns.CharState(), {}
	for _, f in ipairs(Own.SNAP_FIELDS) do
		snap[f] = type(s[f]) == "table" and Own.deepCopy(s[f][id]) or nil
	end
	return snap
end
function Own.snapRestore(id, snap)
	local s = ns.CharState()
	for _, f in ipairs(Own.SNAP_FIELDS) do
		if type(s[f]) == "table" then s[f][id] = snap[f] end
	end
end

local function checkShape(g)
	local s = ns.CharState()
	if type(s.shapes) ~= "table" then s.shapes = {} end
	if type(s.stepKeys) ~= "table" then s.stepKeys = {} end
	if type(s.shapeVersions) ~= "table" then s.shapeVersions = {} end
	local h = shapeOf(g)
	local stored = s.shapes[g.id]
	local ver = Own.packVersion(g)
	if stored ~= nil and stored ~= h then
		local old = s.stepKeys[g.id]
		-- Saved before step keys existed: nothing to match them by, all dropped.
		local map = type(old) == "table" and Own.matchSteps(old, Own.stepKeys(g)) or {}
		-- An update of the pack (the save's shape came from another version):
		-- its new steps behind the player pass for them (Own.passAdded). Once:
		-- the save is stamped with this version below. Any error in that
		-- mapping puts the save back and restores it by kept steps alone.
		local upgrade = s.shapeVersions[g.id] ~= ver and type(old) == "table"
		local snap = upgrade and Own.snapState(g.id)
		if not upgrade or not Own.safely("mapping", g.id, function()
			Own.noteAdded(g, map, old)
			Own.remap(g.id, map, old, g)
		end) then
			if snap then Own.snapRestore(g.id, snap) end
			Own.remap(g.id, map, nil, g)
		end
		-- Its end reached is the old guide's (0.3.5 reused ids for new
		-- content): the new one says so again when the player gets there.
		if type(s.guideEnds) == "table" then s.guideEnds[g.id] = nil end
	end
	s.shapes[g.id] = h
	s.shapeVersions[g.id] = ver
	if stored ~= h or type(s.stepKeys[g.id]) ~= "table" then
		local copy = {}
		for i, k in ipairs(Own.stepKeys(g)) do copy[i] = k end
		s.stepKeys[g.id] = copy
	end
end

-- The version of guide g's pack, as a save stores it beside the guide's shape
-- (CharState().shapeVersions): "?" when the pack names none.
function Own.packVersion(g)
	local r = g.pack and Guides.Pack(g.pack)
	return tostring(r and r.version or "?")
end

-- An update never moves a player back (#1353 upgrade, 0.3.5 -> 0.3.6: 26 of
-- 199 recorded mid-guide saves were sent back to a quest the update put
-- behind them, Loch Modan's step 15 to Auberdine across the sea). What an
-- update added to guide g is noted per step key (CharState().added[id], with
-- the guide-as-registered step's key for a step of a planned guide): `true`
-- for a step none of whose quest goals the save's guide had there (or, with
-- no quest goal, none of its goals), else the goals it did not have
-- ("accept:385", Own.goalId) or had only further on (moved back past a step
-- it followed), the old guide's goals being those
-- of the steps kept (`map`, old index -> new) and of the changed ones
-- (ns.LegacySteps). Placement passes what of it is behind the player
-- (Own.passAdded).
function Own.goalId(goal)
	local id = goal.quest or goal.npc or goal.item or goal.spell or goal.object
		or goal.faction or goal.achievement or goal.level or goal.location or goal.map or ""
	return goal.t .. ":" .. tostring(id)
end

function Own.noteAdded(g, map, old)
	local kept = {}
	for _, j in pairs(map) do kept[j] = true end
	-- Where the save's guide had each goal, in the new guide's numbers: a kept
	-- step's new number, a changed step's first place after the kept step
	-- before it. A goal now before that place moved back: added here too.
	local parts = Own.stepParts(g)
	local hereAt = {}
	for j, key in ipairs(Own.stepKeys(g)) do
		if not kept[j] and not hereAt[key] then hereAt[key] = j end
	end
	local had, upTo, prev = {}, {}, 0
	for k = 1, #old do
		local list, at, last
		if map[k] then
			list, at, prev = {}, map[k], map[k]
			last = at
			for x in ((parts[map[k]] or "") .. ","):gmatch("([^,]*),") do list[#list + 1] = x end
		else
			-- A step moved whole is still in the guide under its key.
			local h = hereAt[old[k]]
			if h then
				list = {}
				for x in ((parts[h] or "") .. ","):gmatch("([^,]*),") do list[#list + 1] = x end
			else
				list = Own.legacyGoals(g.id, old[k])
			end
			at = prev + 1
			last = (Own.nextKept(map, k) or (#g.steps + 1)) - 1
			if last < at then last = at end
		end
		for _, x in ipairs(list or NONE) do
			if not had[x] or at < had[x] then had[x] = at end
			if not upTo[x] or last > upTo[x] then upTo[x] = last end
		end
	end
	local s = ns.CharState()
	if type(s.added) ~= "table" then s.added = {} end
	local mine = s.added[g.id] or {}
	local keys = Own.stepKeys(g)
	-- Quest goals an earlier release had optional only that block now
	-- (tools/legacy-steps.js `required`): a player may have passed them, so in
	-- a kept step too they count as added (Wetlands 98216, Hillsbrad 98283).
	local L = Own.legacy()
	local req = L and L[g.id] and L[g.id].required
	local became = {}
	for x in ((type(req) == "string" and req or "") .. ","):gmatch("([^,]+),") do became[x] = true end
	for j, step in ipairs(g.steps) do
		if kept[j] and not step.feeder and next(became) then
			local ids = {}
			for _, goal in ipairs(step.goals) do
				local x = Own.goalId(goal)
				if goal.quest and not goal.optional and became[x] then ids[x] = "req" end
			end
			if next(ids) then
				mine[keys[j]] = ids
				local bk = Own.baseKey(g, j)
				if bk then mine[bk] = ids end
			end
		end
		if not kept[j] and not step.feeder then
			local quests, fresh, ids, soft, moved = 0, 0, {}, true, false
			for _, goal in ipairs(step.goals) do
				local x = Own.goalId(goal)
				local new = not had[x] or j < had[x]
				if goal.quest then
					quests = quests + 1
					if new then
						fresh = fresh + 1
						-- Moved back: its old place, in the new guide's numbers
						-- (Own.passAdded keeps it when the player's place is past it).
						ids[x] = had[x] or true
						if had[x] then moved = true end
					elseif became[x] and not goal.optional then
						ids[x] = "req"
					elseif j > upTo[x] then
						-- Moved on past a step it came before: no sign of how far
						-- the player got (Own.goalMoved), though not added.
						ids[x] = "later"
					end
				elseif goal.t ~= "note" then
					if new then ids[x] = true else soft = false end
				end
			end
			-- A step of quest goals all new, or of travel and errands all new.
			local whole = (quests > 0 and fresh == quests) or (quests == 0 and soft and #step.goals > 0)
			local entry = (whole and not moved) or (next(ids) and ids) or nil
			if entry then
				mine[keys[j]] = entry
				local bk = Own.baseKey(g, j)
				if bk then mine[bk] = entry end
			end
		end
	end
	-- Noted even with nothing added: feeder steps planned in pass the same way.
	s.added[g.id] = mine
end

-- The key of the guide-as-registered step that step j of a planned guide
-- comes from (Own.rebuilt's fromBase), or nil (not planned, or a feeder step).
Own.baseIndexCache = setmetatable({}, { __mode = "k" })
function Own.baseKey(g, j)
	if not (g.base and g.fromBase) then return nil end
	local inv = Own.baseIndexCache[g]
	if not inv then
		inv = {}
		for b, n in pairs(g.fromBase) do inv[n] = b end
		Own.baseIndexCache[g] = inv
	end
	local b = inv[j]
	return b and Own.stepKeys(g.base)[b] or nil
end

-- Step j of the loaded guide in set `set` (step key -> true | { goal id =
-- true }): its entry by its own key or its guide-as-registered step's, or nil.
function Own.stepIn(set, j)
	if not set then return nil end
	local e = set[Own.stepKeys(guide)[j]]
	if e then return e end
	local bk = Own.baseKey(guide, j)
	return bk and set[bk] or nil
end

-- Whether goal `goal` of step j of the loaded guide is something an update
-- added (`added`, Own.noteAdded) or comes with a feeder step.
function Own.goalAdded(added, j, goal)
	if guide.steps[j].feeder then return true end
	local e = Own.stepIn(added, j)
	if e == true then return true end
	local v = type(e) == "table" and e[Own.goalId(goal)]
	return v == true or type(v) == "number" or (v == "req" and Own.carried(goal))
end

-- A goal of a quest the player carries, other than its accept: what an
-- earlier release had optional (Own.noteAdded's "req") counts as added only
-- then (Wetlands 98216); an optional accept the player never took stays.
function Own.carried(goal)
	return goal.t ~= "accept" and goal.quest ~= nil and Compat().IsOnQuest(goal.quest) or false
end

-- Whether goal `goal` of step j is something an update added, or moved on
-- past a step it came before: no sign of how far the player got in the guide
-- they had (placement's anchor, after an update).
function Own.goalMoved(added, j, goal)
	if Own.goalAdded(added, j, goal) then return true end
	local e = Own.stepIn(added, j)
	return type(e) == "table" and e[Own.goalId(goal)] ~= nil
end

-- What an update added behind the player passes for them. At the first
-- placement after the update with the quest log in: the player's place is the
-- first step that holds for what the save's guide had too (a goal open that
-- the update did not add and that holds its step, Own.holds: a vendor
-- check-off beside other work never does); behind it, each step the update added, or
-- a feeder step, and each quest goal it added to a step, is noted gone
-- (CharState().gone[id], as `added`): it no longer applies (stepApplies,
-- goalApplies), as another class's, so its accepts are not offered and its
-- quests' later goals go with them (orphaned). Nothing shows as skipped. Work
-- of a quest the player carries that the guide has nowhere from their place
-- on passes too, and the quest is noted behind (CharState().behind[id]): a
-- "Still to do" row (Engine.GetBehind) and While-here offer it; the place
-- stays. With the quest log in, the update's note is spent; what it added
-- ahead of the player stays.
Own.goneGen = 0
Own.goneCache = setmetatable({}, { __mode = "k" })
function Own.passAdded()
	local s = ns.CharState()
	local added = type(s.added) == "table" and s.added[guide.id]
	if not added then return end
	-- Worked out afresh while the note lasts: before the quest log is in,
	-- quests carried and travel done are not known yet (a pass then is
	-- provisional; the one with the log in decides).
	if type(s.gone) == "table" and s.gone[guide.id] then
		s.gone[guide.id] = nil
		Own.goneGen = Own.goneGen + 1
	end
	if type(s.behind) == "table" then s.behind[guide.id] = nil end
	local C, steps = Compat(), guide.steps
	local sk = skippedFor(guide.id)
	local P = #steps + 1
	for j = 1, #steps do
		if stepApplies(steps[j]) and not (sk and sk[j]) and not stepDone(j) then
			local holds = false
			for g, goal in ipairs(steps[j].goals) do
				if Own.holds(j, goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(j, g, goal)
					and not Own.goalAdded(added, j, goal) then
					holds = true
					break
				end
			end
			if holds then
				P = j
				break
			end
		end
	end
	-- A goal the update moved back from a place at or before that one was
	-- there in the old guide too: the player's place is still that step
	-- (Western Plaguelands' Layo Starstrike, moved before Cenarion Hold).
	for j = 1, P - 1 do
		local e = not steps[j].feeder and Own.stepIn(added, j)
		if type(e) == "table" and stepApplies(steps[j]) and not (sk and sk[j]) and not stepDone(j) then
			local holds = false
			for g, goal in ipairs(steps[j].goals) do
				local h = e[Own.goalId(goal)]
				if type(h) == "number" and h <= P and Own.holds(j, goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(j, g, goal) then
					holds = true
					break
				end
			end
			if holds then
				P = j
				break
			end
		end
	end
	-- Held quests whose work the guide still has from there on.
	local later = {}
	for j = P, #steps do
		for _, goal in ipairs(steps[j].goals) do
			if goal.quest and goal.t ~= "accept" then later[goal.quest] = true end
		end
	end
	local function held(j, g, goal)
		return goal.t ~= "accept" and isQuestGoal(goal) and C.IsOnQuest(goal.quest) and not later[goal.quest] and not goalDone(j, g, goal)
	end
	local gone, behind = {}, {}
	local keys = Own.stepKeys(guide)
	local function note(j, entry)
		gone[keys[j]] = entry
		local bk = Own.baseKey(guide, j)
		if bk then gone[bk] = entry end
	end
	for j = 1, P - 1 do
		local step = steps[j]
		if Guides.Matches(step.only, player) then
			local e = (step.feeder and true) or Own.stepIn(added, j)
			if e == true then
				for g, goal in ipairs(step.goals) do
					if held(j, g, goal) then behind[goal.quest] = true end
				end
				note(j, true)
			elseif type(e) == "table" then
				local ids, all = {}, true
				for g, goal in ipairs(step.goals) do
					local x = Own.goalId(goal)
					if e[x] == true or type(e[x]) == "number" or (e[x] == "req" and Own.carried(goal)) then
						ids[x] = true
						if goal.quest and held(j, g, goal) then behind[goal.quest] = true end
					elseif goal.t ~= "note" then
						all = false
					end
				end
				-- Every goal passed: the step itself (nothing left to hold it).
				if next(ids) then note(j, all or ids) end
			end
		end
	end
	if next(gone) then
		if type(s.gone) ~= "table" then s.gone = {} end
		s.gone[guide.id] = gone
		Own.goneGen = Own.goneGen + 1
	end
	if next(behind) then
		if type(s.behind) ~= "table" then s.behind = {} end
		s.behind[guide.id] = behind
	end
	if logReady then
		s.added[guide.id] = nil
		-- A quest ahead that needed what passed: planned again (Own.replan).
		if next(gone) then
			local id = guide.id
			ns.After(0, function() Own.safely("replan", id, Own.replan, id) end)
		end
	end
end

-- Runs f(...) for the update's mapping of guide `id`; an error drops what the
-- update noted for it (the plain restore: kept steps only), says one line in
-- the debug log (/polestar report) and shows none. -> true when f ran clean.
function Own.safely(what, id, f, ...)
	local ok, err = pcall(f, ...)
	if ok then return true end
	ns.Log("upgrade " .. what .. " failed, plain restore: " .. tostring(err):match("^[^\n]*"))
	local s = ns.CharState()
	for _, field in ipairs({ "added", "gone", "behind" }) do
		if id and type(s[field]) == "table" then s[field][id] = nil end
	end
	Own.goneGen = Own.goneGen + 1
	return false
end

-- The quests of the active guide whose work an update passed behind the
-- player while they carry them (Own.passAdded), still in the log: one entry
-- each, { quest, title, step, goal (the first open goal of it, for the
-- arrow), zone, yards (nil off the player's continent) }, in guide order.
function Engine.GetBehind()
	local ok, out = pcall(Own.behindList)
	if ok then return out end
	Own.safely("behind", guide and guide.id, error, out)
	return {}
end

function Own.behindList()
	local s = ns.CharState()
	local mine = guide and type(s.behind) == "table" and s.behind[guide.id]
	if not mine then return {} end
	local C, out, seen = Compat(), {}, {}
	for q in pairs(mine) do
		if not C.IsOnQuest(q) or (ns.CharState().skippedQuests or {})[q] then mine[q] = nil end
	end
	if not next(mine) then s.behind[guide.id] = nil return out end
	if not player then refreshPlayer() end
	local c, px, py = C.GetPlayerWorldPosition()
	for j, step in ipairs(guide.steps) do
		for g, goal in ipairs(step.goals) do
			local q = goal.quest
			if q and mine[q] and not seen[q] and goal.t ~= "accept" and goal.map and not goalDone(j, g, goal) then
				seen[q] = true
				local gc, gx, gy = goalWorld(goal)
				local yards = c and gc == c and math.floor(math.sqrt((gx - px) ^ 2 + (gy - py) ^ 2) + 0.5) or nil
				out[#out + 1] = { quest = q, title = titleOfQuest(q), step = j, goal = g, zone = C.MapName(goal.map), yards = yards }
			end
		end
	end
	return out
end

-- Whether goal is work of a quest Engine.GetBehind lists (While-here offers it).
function Own.behindGoal(goal)
	local b = guide and goal.quest and ns.CharState().behind
	return b and type(b) == "table" and b[guide.id] and b[guide.id][goal.quest] and true or false
end

-- The row's Skip: the quest is skipped (Engine.SkipQuest) and the row goes.
function Engine.SkipBehind(q)
	local b = guide and ns.CharState().behind
	if type(b) == "table" and b[guide.id] then b[guide.id][q] = nil end
	return Engine.SkipQuest(q, true)
end

-- The loaded guide's steps and goals an update passed (Own.passAdded): step
-- table -> true, goal table -> true. Cached per guide table and change.
function Own.goneOf()
	local c = Own.goneCache[guide]
	if not (c and c.gen == Own.goneGen) then
		local all = ns.CharState().gone
		local mine = type(all) == "table" and all[guide.id]
		local set = false
		if mine then
			set = {}
			for j, st in ipairs(guide.steps) do
				-- A passed step the plan brought back on the way (Own.goneSource)
				-- is the guide's again, though it carries the same goals.
				local e = st.feeder ~= guide.id and Own.stepIn(mine, j) or nil
				if e == true then
					set[st] = true
				elseif type(e) == "table" then
					for _, goal in ipairs(st.goals) do
						if e[Own.goalId(goal)] == true then set[goal] = true end
					end
				end
			end
		end
		c = { gen = Own.goneGen, set = set }
		Own.goneCache[guide] = c
	end
	return c.set
end

-- Whether `step` (or `goal`) of the loaded guide is one an update passed.
function Own.gone(x)
	if not guide then return false end
	local set = Own.goneOf()
	return set and set[x] == true or false
end

-- An update replaced most of guide g's steps: it keeps fewer than half of
-- those the character's save knew (0.3.5 reused leveling guide ids for
-- other parts of the route, #1328). Read before checkShape stores the new
-- shape. Only an update: a save stamped with the pack's own version saw
-- none, and its shape is the guide as planned for the character (feeders
-- in, quests waiting on earlier guides left out), whose step keys differ
-- from the guide as registered (a /reload moved a fresh-start tab).
function Own.reworked(g)
	local s = ns.CharState()
	local stored = type(s.shapes) == "table" and s.shapes[g.id]
	local old = type(s.stepKeys) == "table" and s.stepKeys[g.id]
	if not stored or stored == shapeOf(g) or type(old) ~= "table" or #old == 0 then return false end
	if type(s.shapeVersions) == "table" and s.shapeVersions[g.id] == Own.packVersion(g) then return false end
	local kept = 0
	for _ in pairs(Own.matchSteps(old, Own.stepKeys(g))) do kept = kept + 1 end
	return kept * 2 < #old
end

-- Tabs of guides that are not there (pack missing or switched off), oldest
-- first: { id, at } with `at` the tab's place when it was last open. They
-- stay saved, with their pins, and reopen there when the guide is back.
local absent = {}

local function forgetAbsent(id)
	for i = #absent, 1, -1 do
		if absent[i].id == id then table.remove(absent, i) end
	end
end

local function rememberAbsent(id, at)
	forgetAbsent(id)
	absent[#absent + 1] = { id = id, at = at }
	while #absent > MAX_TABS do table.remove(absent, 1) end
end

-- Tabs closed (Engine.CloseTab, or a guide loaded over them: SetGuide,
-- ChooseRoute), newest first: { id, at } with `at` the tab's place, saved
-- as CharState().closedTabs with their saved views (pins), so a closed
-- guide opened again by any way (Engine.ReopenClosedTab, the guide list's
-- Recently closed, Load, a route chosen again) comes back as a reload brings
-- a saved tab back: at the step the player was looking at (Own.takeClosed),
-- placed from the quest log. Ticks and skips are per guide and never go with
-- a tab. (On Own: the main chunk is at Lua's 200 locals.)
Own.MAX_CLOSED = 10
Own.closed = {}

function Own.rememberClosed(id, at)
	local closed = Own.closed
	for i = #closed, 1, -1 do
		if closed[i].id == id then table.remove(closed, i) end
	end
	table.insert(closed, 1, { id = id, at = at })
	while #closed > Own.MAX_CLOSED do table.remove(closed) end
end

-- Guide `id`'s closed tab entry and its index, or nil.
function Own.closedEntry(id)
	for i, c in ipairs(Own.closed) do
		if c.id == id then return c, i end
	end
	return nil
end

-- Guide `id` opened again: out of the closed tabs. -> the step the player
-- was looking at when they closed it and its `done` (its saved pin, carried
-- to the guide's steps as planned now by checkShape), or nil.
function Own.takeClosed(id)
	local _, i = Own.closedEntry(id)
	local g = i and Guides.Get(id)
	if not g then return nil end
	table.remove(Own.closed, i)
	checkShape(g)
	local pins = ns.CharState().pins
	local p = type(pins) == "table" and pins[id]
	if type(p) ~= "table" then return nil end
	return tonumber(p.step), p.done
end

-- CharState().tabs = { guideId, ... } (open tabs, then the absent ones),
-- .absentAt = { [guideId] = place }, .activeTab, .guide (the active tab's
-- guide, as before tabs existed) and .closedTabs. Saved views (pins) are
-- kept for open, absent and closed guides only. A guide open in a tab is
-- never absent or closed too: however it got into the tab (OpenTab,
-- SetGuide, a `next` chain, a route choice), its absent and closed entries
-- go here, so closing it later forgets it.
local function persist()
	sync()
	local s = ns.CharState()
	local ids, keep = {}, {}
	for i = 1, #tabs do
		ids[i] = tabs[i].guide.id
		keep[ids[i]] = true
		markStarted(ids[i])
		checkShape(tabs[i].guide)
	end
	for i = #absent, 1, -1 do
		if keep[absent[i].id] then table.remove(absent, i) end
	end
	local at
	for _, a in ipairs(absent) do
		ids[#ids + 1] = a.id
		keep[a.id] = true
		at = at or {}
		at[a.id] = a.at
	end
	local closed = Own.closed
	for i = #closed, 1, -1 do
		if keep[closed[i].id] then table.remove(closed, i) end
	end
	local shut = {}
	for i, c in ipairs(closed) do
		shut[i] = { id = c.id, at = c.at }
		keep[c.id] = true
	end
	s.tabs = ids
	s.absentAt = at
	s.closedTabs = #shut > 0 and shut or nil
	s.activeTab = activeIndex > 0 and activeIndex or nil
	s.guide = ids[activeIndex]
	if type(s.pins) == "table" then
		for id in pairs(s.pins) do
			if not keep[id] then s.pins[id] = nil end
		end
	end
end

-- Done and total applicable steps of the loaded tab; steps the player skipped
-- count as done. Counting runs the done
-- rules over every step after the current one, so the result is kept on the
-- tab until the next evaluation (or until its guide or current step moves):
-- the guide frame, tab strip and picker all ask for it on every repaint.
local function progressLoaded()
	if not guide then return 0, 0 end
	local t = loaded
	if t and t.progGen == generation and t.progGuide == guide and t.progComputed == computed then
		return t.progDone, t.progTotal
	end
	local done, total = 0, 0
	for s, step in ipairs(guide.steps) do
		if stepApplies(step) and not Own.numbersOf(guide).hidden[s] then
			total = total + 1
			if (not computed or s < computed) or isSkipped(s) or stepDone(s) then done = done + 1 end
		end
	end
	if t then
		t.progGen, t.progGuide, t.progComputed, t.progDone, t.progTotal = generation, guide, computed, done, total
	end
	return done, total
end

-- done = done steps (progress bar), complete = the guide is finished.
-- The guide ids the tabs hold (id -> true), without reading their steps.
function Engine.TabIds()
	local out = {}
	for i = 1, #tabs do out[tabs[i].guide.id] = true end
	return out
end

function Engine.GetTabs()
	sync()
	if not player and #tabs > 0 then refreshPlayer() end
	local out = {}
	for i = 1, #tabs do
		local t = tabs[i]
		use(t)
		local g = t.guide
		local done, total = progressLoaded()
		out[i] = {
			guideId = g.id, title = g.title, category = g.category or "Leveling",
			stepIndex = t.current, stepCount = #g.steps, done = done, total = total, complete = t.computed == nil,
			-- As the player counts them (Engine.StepNumberOf): what tabs and menus show.
			stepNumber = t.current and (Engine.StepNumberOf(g, t.current)) or nil, stepTotal = Engine.StepTotalOf(g),
		}
	end
	useActive()
	return out, activeIndex
end

local function fireTabs()
	tabsDirty = false
	local list, active = Engine.GetTabs()
	ns.Fire("TABS_CHANGED", list, active)
end

---------------------------------------------------------------------------
-- goto/explore arrival, polled for every tab while one has such a goal open;
-- the same poll re-picks the spawn area of the active waypoint's goal
---------------------------------------------------------------------------

local ticker
local requestUpdate

-- A `die` arrives only alive: a ghost at the graveyard has not resurrected yet.
-- A `fly` arrives at its landing's flight master (Own.landingNode), off the taxi.
local function isArrivalGoal(goal)
	local t = goal.t
	if t == "die" then return not (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player")) end
	if t == "fly" then return Own.landingNode(goal) ~= nil and not Compat().IsOnTaxi() end
	return t == "goto" or t == "explore"
end

-- The place a `fly` goal arrives at: its landing's taxi node, known or not
-- (#1530: a flight to the Crossroads landed but never ended its step, the
-- zone text reading "The Crossroads" and the goal "Crossroads"; so with
-- Stormwind, Grom'gol, Theramore, Feathermoon), with a place; else nil.
function Own.landingNode(goal)
	local node = Own.unknownLanding(goal) or (goal.node and ns.Nav and ns.Nav.GetTaxiNode and Own.knownLanding(goal))
	return node and node.map and node.x and node.y and node or nil
end
Own.LANDING_RADIUS = 30 -- yards around the flight master: where the taxi sets the player down

-- Whether the player (c, px, py) is within reach of a goal's place: its
-- arrival margin, around its spawn area when it has one.
function Own.reached(goal, c, px, py)
	local map, x, y, f, area = posOf(goal)
	if not (map and x and y) then return false end
	local gc, gx, gy = Compat().MapToWorld(map, x, y, f)
	if gc ~= c then return false end
	local dx, dy, r = gx - px, gy - py, (area or 0) + (goal.r or DEFAULT_RADIUS)
	return dx * dx + dy * dy <= r * r
end

-- A goto whose label names a subzone (`area`) arrives on going in there, a
-- cave or mine past its mouth's point (#177): in that subzone and indoors.
-- Indoors, as a cave's subzone can also cover the ground around and above
-- it (Fargodeep Mine), where the step's point still leads the way in. Only
-- once the player was seen elsewhere while the goal was open: being inside
-- when the goal comes up does not count, nor for a later goto of the step
-- naming the same place (a waypoint further in). Own.outside: the gotos with
-- a place the player was seen elsewhere while the goal was open.
Own.outside = setmetatable({}, { __mode = "k" })
function Own.enteredPlace(goals, g, goal)
	local inside = Own.inSubzone(goal)
	if inside == nil then return false end
	local C = Compat()
	inside = inside and C.IsIndoors ~= nil and C.IsIndoors()
	if not inside then
		Own.outside[goal] = true
		return false
	end
	if not Own.outside[goal] then return false end
	for j = 1, g - 1 do
		local other = goals[j]
		if other.t == "goto" and other.area == goal.area then return false end
	end
	return true
end

-- The end of a leveling guide reached ahead of the live step (a player who
-- skipped ahead: Own.noteEnd): its last step for everyone (a class's or a
-- race's own steps are not the end: Own.forSome) done out of turn, by what
-- the game keeps: quest state, the level, bags, flight paths, spells. Never
-- by where the player is or has been, nor by an NPC's window (goto,
-- explore, fly, hearth, enter, die; train, vendor, sethome, a talk with no
-- quest: Own.byPresence): the Undercity, the last stop of Hillsbrad (30-32),
-- is also its fifth, a hub the player visits to train, and a zone the
-- route crosses (0.3.5: "You've reached the end of this guide" at step 2).
-- Those count once their step is on screen, or ticked, or when later work
-- of the step is done (a walk to the turn-in: Own.laterWorkDone).
Own.PRESENCE = { goto = true, explore = true, fly = true, hearth = true, enter = true, die = true, vendor = true, sethome = true }
function Own.byPresence(goal)
	local t = goal.t
	if t == "train" then return not isProfessionTrain(goal) end
	return Own.PRESENCE[t] or (t == "talk" and not goal.quest) or false
end

-- Whether a goal after goal g of step s that counts as it is (not
-- Own.byPresence, not a note) is done.
function Own.laterWorkDone(s, g)
	local goals = guide.steps[s].goals
	for j = g + 1, #goals do
		local later = goals[j]
		if later.t ~= "note" and not Own.byPresence(later) and goalApplies(later) and goalDone(s, j, later) then return true end
	end
	return false
end

-- Whether step s, the last one, is done out of turn (see above).
function Own.endDoneAhead(s)
	if not stepDone(s) then return false end
	local goals = guide.steps[s].goals
	for g = 1, #goals do
		local goal = goals[g]
		if not goal.optional and goalApplies(goal) and not checked(s, g) and Own.byPresence(goal) and not Own.laterWorkDone(s, g) then return false end
	end
	return true
end

-- Whether the work of step s, the last one, was really done (#998): every
-- goal that holds the route done, none of them only passed over as
-- unavailable for now (a level not reached, a prerequisite missing, a
-- giver's refusal); those come back, so the step is no end yet. Out for
-- good (closed by another quest, skipped by the player) passes, but a step
-- of nothing else is void, no end either.
function Own.endWorkDone(s)
	local goals, did = guide.steps[s].goals, false
	for g = 1, #goals do
		local goal = goals[g]
		if Own.holds(s, goal) and goalApplies(goal) then
			if goalDone(s, g, goal) then
				did = true
			else
				local u = unavailableFor(goal)
				if not (u and (u.reason == "closed" or u.reason == "skipped")) then return false end
			end
		end
	end
	return did
end

-- Loaded tab: mark arrived goals of step s; true if any. A "Go to" naming
-- its step is the area the step's work is in: reaching the place of any
-- other goal of the step (where the arrow leads) arrives there too.
function Own.arriveStep(s, c, px, py)
	local step = guide.steps[s]
	local goals = step.goals
	local hit = false
	for g = 1, #goals do
		local goal = goals[g]
		if isArrivalGoal(goal) and not arrived[goal] and goalApplies(goal) then
			local gc, gx, gy
			if goal.t == "fly" then
				-- Its landing's flight master (Own.landingNode).
				local node = Own.landingNode(goal)
				gc, gx, gy = Compat().MapToWorld(node.map, node.x, node.y, node.f)
			else
				gc, gx, gy = goalWorld(goal)
			end
			local dx, dy, r = (gx or 0) - px, (gy or 0) - py, goal.r or (goal.t == "die" and Own.DIE_RADIUS) or (goal.t == "fly" and Own.LANDING_RADIUS) or DEFAULT_RADIUS
			local here = gc == c and dx * dx + dy * dy <= r * r
			if not here and goal.t == "goto" and Own.enteredPlace(goals, g, goal) then here = true end
			if not here and goal.t == "goto" and step.title and goal.text == step.title then
				for j = 1, #goals do
					local other = goals[j]
					if j ~= g and other.t ~= "goto" and other.t ~= "note" and goalApplies(other) and Own.reached(other, c, px, py) then
						here = true
						break
					end
				end
			end
			if here then
				arrived[goal] = true
				hit = true
			end
		end
	end
	return hit
end

-- Loaded tab: the current step's arrivals; true if any.
local function arriveLoaded(c, px, py)
	if not (guide and current) then return false end
	return Own.arriveStep(current, c, px, py)
end

local function checkArrival()
	if #tabs == 0 then return end
	local c, px, py = Compat().GetPlayerWorldPosition()
	if not c then
		-- Nowhere to measure from (an instance): no "While you're here" line.
		if Own.hereTick(nil) then requestUpdate() end
		return
	end
	local hit = false
	-- A fight is work where it happens (Spots.noteWork): no dwell leaves that ground.
	if UnitAffectingCombat and UnitAffectingCombat("player") then Spots.noteWork(c, px, py, GetTime()) end
	for i = 1, #tabs do
		use(tabs[i])
		if arriveLoaded(c, px, py) then hit = true end
	end
	useActive()
	-- The waypoint's field goal: a dwell at its place with no progress moves the
	-- arrow on (Spots, "Dwell"): to its next spot, or, with every place left, to
	-- the step's nearest other field goal (below).
	local wg = waypoint and guide and current and waypoint.stepIndex == current and guide.steps[current].goals[waypoint.goalIndex]
	if wg and Own.isField(wg) and Own.dwelt(current, waypoint.goalIndex, wg, c, px, py) then
		if wg.spots then Spots.repick(wg, c, px, py, "dwell") end
		hit = true
	end
	local sg = Spots.waypointGoal()
	if sg and Spots.repick(sg, c, px, py) then hit = true end
	-- A step with several open field goals: the nearest may have changed.
	if guide and current and Own.nearPick[guide.steps[current]] then
		Own.nearMoved = false
		local groups, focus = stepGroups(current)
		Own.currentGoal(current, groups, focus)
		if Own.nearMoved then hit = true end
	end
	-- "While you're here": the nearest quick objective of a later step.
	if Own.hereTick(c, px, py) then hit = true end
	if hit then requestUpdate() end
end

-- Whether step s has an arrival goal still open.
function Own.arrivalOpen(s)
	local goals = guide.steps[s].goals
	for g = 1, #goals do
		local goal = goals[g]
		if isArrivalGoal(goal) and goalApplies(goal) and not goalDone(s, g, goal) then return true end
	end
	return false
end

-- The current step waits on an arrival.
local function needsArrival()
	return guide ~= nil and current ~= nil and Own.arrivalOpen(current)
end

local function updateTicker()
	local need = false
	for i = 1, #tabs do
		use(tabs[i])
		if needsArrival() then
			need = true
			break
		end
	end
	useActive()
	if not need then need = Spots.waypointGoal() ~= nil or (guide ~= nil and current ~= nil and Own.nearPick[guide.steps[current]] ~= nil) end
	if not need then need = Own.hereAllN > 0 or Own.hereOnN > 0 end
	if need and not ticker then
		ticker = ns.NewTicker(ARRIVAL_POLL, checkArrival)
	elseif not need and ticker then
		ticker:Cancel()
		ticker = nil
	end
end

-- A `die` goal (deathskip) is done on being back alive this close (yards) to
-- its Spirit Healer: the resurrection puts the player beside him. Back alive,
-- the goal (no arrival goal while dead) may arrive now.
Own.DIE_RADIUS = 40
function Own.backAlive()
	checkArrival()
	requestUpdate()
end
ns.RegisterEvent("PLAYER_ALIVE", Own.backAlive)
ns.RegisterEvent("PLAYER_UNGHOST", Own.backAlive)

---------------------------------------------------------------------------
-- Evaluation
---------------------------------------------------------------------------

local sigParts = {}

local function signature()
	local n = 0
	if current then
		-- A gate opening (level-up, turn-in) or arriving in another race's
		-- starting zone changes the view, not the step.
		n = n + 1
		sigParts[n] = Own.startGate(guide) and "gated" or Own.awayStart(guide) and "away" or "open"
		local goals = guide.steps[current].goals
		for g = 1, #goals do
			local goal = goals[g]
			local status, cur, max = goalStatus(current, g, goal, true)
			n = n + 1
			sigParts[n] = status
			n = n + 1
			sigParts[n] = cur and (cur .. "/" .. (max or "")) or "-"
			if goal.candidates then
				local c = chosen(goal)
				n = n + 1
				sigParts[n] = c and (tostring(c.npc) .. "@" .. c.map .. ":" .. c.x .. "," .. c.y) or "none"
			elseif goal.spots and Spots.chosen[goal] then
				-- The chosen spawn area moves the goal's position in the view.
				n = n + 1
				sigParts[n] = "spot" .. (Spots.index(goal) or 0)
			elseif goal.t == "accept" and goal.quest then
				-- Its line's notice (not in the log, not listed by its giver).
				n = n + 1
				sigParts[n] = Own.acceptNotice(current, g, goal, status) and "notice" or "-"
			end
		end
		local _, focus = stepGroups(current)
		n = n + 1
		sigParts[n] = "focus" .. tostring(focus)
		-- The along goals listed under the step (Engine.GetAlong): their progress updates the view.
		for _, s in ipairs(Own.marksOf().along) do
			if Own.alongListed(s) then
				for g, goal in ipairs(guide.steps[s].goals) do
					local status, cur, max = goalStatus(s, g, goal, true)
					n = n + 1
					sigParts[n] = "a" .. s .. ":" .. g .. ":" .. status .. ":" .. (cur and (cur .. "/" .. (max or "")) or "-")
				end
			end
		end
		-- The quests an update left behind the player (Engine.GetBehind).
		for _, b in ipairs(Engine.GetBehind()) do
			n = n + 1
			sigParts[n] = "b" .. b.quest .. ":" .. b.step .. ":" .. b.goal
		end
		-- The pinned quests' (Own.pinGoals): which lines are open, and their counts.
		for _, q in ipairs(Own.pinList()) do
			for _, e in ipairs(Own.pinGoals(q)) do
				local status, cur, max = goalStatus(e[1], e[2], e[3], true)
				n = n + 1
				sigParts[n] = "p" .. e[1] .. ":" .. e[2] .. ":" .. status .. ":" .. (cur and (cur .. "/" .. (max or "")) or "-")
			end
		end
	end
	for i = #sigParts, n + 1, -1 do sigParts[i] = nil end
	return table.concat(sigParts, ",")
end

-- How far from a `vendor nearest` candidate a merchant still stands in its
-- town, in yards: the compiler keeps one candidate per town of this radius
-- (forge-guide candidates.rs, HUB_YARDS).
Own.VENDOR_TOWN = 250

-- Whether the merchant window open now is a sell-and-repair stop for a
-- `vendor nearest` goal: the merchant repairs, and the player stands within
-- Own.VENDOR_TOWN yards of one of the goal's candidates. Menethil Harbor
-- has Murndan Derth and Brak Durnad side by side; the guide lists one, and
-- selling and repairing at the other is the same errand (#1400).
function Own.repairsInTown(goal)
	local C = Compat()
	if not C.CanMerchantRepair() then return false end
	local c, px, py = C.GetPlayerWorldPosition()
	if not c then return false end
	local r2 = Own.VENDOR_TOWN * Own.VENDOR_TOWN
	for _, cand in ipairs(goal.candidates) do
		local cc, cx, cy = goalWorld(cand)
		if cc == c and (cx - px) ^ 2 + (cy - py) ^ 2 <= r2 then return true end
	end
	return false
end

-- An NPC interaction while a step is current checks off its talk/train/
-- vendor goals (sethome: binding); while the player looks at another step,
-- the live step's too. Stored with the manual check-offs, so the result
-- survives the step moving on and a reload. Only that NPC counts: a goal
-- with candidates for one of them (a class trainer's for the character's
-- class), one naming its NPC for that NPC, `train class` for a trainer of
-- the character's class; a quest `talk` only on a line the client does not
-- list yet (Own.talkCounts); profession trains complete from the skill's max
-- rank instead. One exception: `vendor nearest` is a sell-and-repair stop,
-- so any merchant who repairs in one of its candidates' towns counts
-- (Own.repairsInTown, #1400); a `vendor` naming its NPC (a mount vendor)
-- stays that NPC's. A window still open when the step changes counts for
-- nothing in the new step: only what opens, or what the player does, while
-- it is current (Fitz: "clear signals from the game"). Returns true if
-- anything changed.
local function latch(kind, npc)
	if not (guide and current and player) then return false end
	local hit = false
	for pass = 1, 2 do
		local s = pass == 1 and current or computed
		if s and (pass == 1 or s ~= current) then
			local goals = guide.steps[s].goals
			for g = 1, #goals do
				local goal = goals[g]
				local ok = goal.t == kind and goalApplies(goal)
				if ok then
					if kind == "talk" then
						ok = goal.npc == npc and Own.talkCounts(goal)
					elseif kind == "sethome" then
						-- `sethome nearest` on any bind; a located one at its inn's
						-- innkeeper (Engine.IsSethomeInnkeeper).
						ok = not goal.location or Engine.IsSethomeInnkeeper(goal, npc)
					elseif kind == "train" and isProfessionTrain(goal) then
						ok = false
					elseif goal.candidates then
						ok = npc ~= nil and isCandidate(goal, npc) or kind == "vendor" and Own.repairsInTown(goal)
					elseif goal.npc then
						ok = goal.npc == npc
					elseif kind == "train" and goal.class then
						ok = Engine.IsClassTrainer(npc)
					end
				end
				if ok then
					local m = manualFor(guide.id, true)
					local key = s .. ":" .. g
					if not m[key] then
						m[key] = true
						hit = true
					end
				end
			end
		end
	end
	return hit
end

-- A hand-in the client never flags completed (a repeatable quest, and every
-- `turnin ... direct` is one in practice) is stored like the latches above, so
-- it stays done after a /reload. The quest's own goal in the live step, and in
-- the step in view when the player looks elsewhere: one hand-in checks off one
-- goal, so a guide that repeats the same quest keeps its later steps open.
function Own.latchTurnin(questID)
	if not (guide and questID) then return false end
	local hit = false
	for pass = 1, 2 do
		local s = pass == 1 and current or computed
		if s and (pass == 1 or s ~= current) then
			for g, goal in ipairs(guide.steps[s].goals) do
				if goal.t == "turnin" and goal.direct and goal.quest == questID and goalApplies(goal) then
					local m = manualFor(guide.id, true)
					local key = s .. ":" .. g
					if not m[key] then
						m[key] = true
						hit = true
					end
				end
			end
		end
	end
	return hit
end

-- A `cast` goal that is open (in the step the guide is at, the step in view,
-- or an along step listed under them) for spellID: ticked, as the player
-- would tick it. A cast before the goal is open does not count.
function Own.latchCast(spellID)
	if not (guide and spellID) then return false end
	local hit = false
	local function tick(s)
		for g, goal in ipairs(guide.steps[s].goals) do
			if goal.t == "cast" and goal.spell == spellID and goalApplies(goal) then
				local m = manualFor(guide.id, true)
				local key = s .. ":" .. g
				if not m[key] then
					m[key] = true
					hit = true
				end
			end
		end
	end
	if current then tick(current) end
	if computed and computed ~= current then tick(computed) end
	for _, s in ipairs(Own.marksOf().along) do
		if s ~= current and s ~= computed and Own.alongListed(s) then tick(s) end
	end
	return hit
end

local lastEval = -math.huge
local pendingCompleted = {} -- background tabs' GUIDE_COMPLETED, fired once the active tab is loaded again
local pendingChoices = {} -- ROUTE_CHOICE from-guide ids, fired at the end of the evaluation

---------------------------------------------------------------------------
-- Route choice: a guide whose `next` names several guides (`nextChoices`)
-- lets the player choose where to level next. At completion the Engine
-- continues with the remembered choice (CharState().routes[fromId]), the only
-- option that fits the character, or, with behavior.routeChoice =
-- "recommended", the recommended one; otherwise the finished guide stays in
-- its tab and ROUTE_CHOICE(fromId) asks the UI. Recommended: an option the
-- character has not outlevelled, then the quickest to reach from where they
-- stand (1-minute bands), then the author's order. An option with `when`
-- (`nextWhen`) is offered only while it holds (Own.optionHolds): with one
-- option left the Engine continues to it, with none the guide ends there.
---------------------------------------------------------------------------

local ROUTE_TIE = 60 -- seconds of travel that count as a tie

local function routesTable()
	local s = ns.CharState()
	if type(s.routes) ~= "table" then s.routes = {} end
	return s.routes
end

-- The options of `from` that fit the character and are offered now (their
-- `when`, if any, holds), in the author's order:
-- { guide = g, outleveled = bool }.
local function routeOptions(from)
	local list = {}
	if not (from and from.nextChoices) then return list end
	if not player then refreshPlayer() end
	local level = player.level or 1
	for _, id in ipairs(from.nextChoices) do
		local g = Guides.Get(id)
		if g and Guides.GuideMatches(g, player) and Own.optionHolds(from, id) then
			list[#list + 1] = { guide = g, outleveled = (g.maxLevel ~= nil and level >= g.maxLevel) }
		end
	end
	return list
end

-- Fills each option's `seconds` (travel from the player to the guide's start,
-- or nil) and returns the recommended option.
local function rankRoutes(options)
	local here = ns.PlayerPoint()
	local best, k1, k2
	for _, o in ipairs(options) do
		local start = here and Guides.Start(o.guide)
		o.seconds = start and ns.TravelCost(here, start) or nil
		local a = o.outleveled and 1 or 0
		local b = o.seconds and math.floor(o.seconds / ROUTE_TIE) or math.huge
		if not best or a < k1 or (a == k1 and b < k2) then best, k1, k2 = o, a, b end
	end
	return best
end

-- Quest work done in guide g: its accepts and turn-ins of quests the
-- character has done or holds.
function Own.doneIn(g)
	local C, done = Compat(), 0
	for _, step in ipairs(g.steps) do
		for _, goal in ipairs(step.goals) do
			if (goal.t == "accept" or goal.t == "turnin") and goal.quest and (questDone(goal.quest) or C.IsOnQuest(goal.quest)) then done = done + 1 end
		end
	end
	return done
end

-- Whether every quest of guide g this character can take is turned in (its
-- accepts, turn-ins and completes, optional ones aside), nil for a guide
-- without quests. The picker's check: a guide the catch-up passed with grey
-- quests never done is not done.
function Own.allQuestsDone(g)
	local any = false
	for _, step in ipairs(g.steps) do
		if Guides.Matches(step.only, player) then
			for _, goal in ipairs(step.goals) do
				local t = goal.t
				if goal.quest and (t == "accept" or t == "turnin" or t == "complete") and not goal.optional
					and Guides.Matches(goal.only, player) then
					any = true
					if not questDone(goal.quest) then return false end
				end
			end
		end
	end
	if any then return true end
	return nil
end

-- The guide to start with, with no guide open (the login's pick, the guide
-- window's and the welcome's Start guide): with the catch-up, the race's
-- first guide when the character did quests in it, so placement goes
-- through the guides from there to where they are, for them to see; else
-- the guide for their level (Guides.Suggest).
function Engine.StartingGuide()
	if not player then refreshPlayer() end
	local first = ns.Get("behavior.skipGrey") and Guides.FirstGuide()
	local g = first and Guides.Get(first)
	if g and Own.doneIn(g) > 0 then return first end
	return Guides.Suggest()
end

-- Start guide (the guide window with no guide, the welcome): opens
-- Engine.StartingGuide() in a new tab, for the catch-up to go through the
-- guides from there to where the character is, finished ones included. The
-- tab's index, or nil.
function Engine.StartGuide()
	local id = Engine.StartingGuide()
	if not id then return nil end
	return Engine.OpenTab(id, true, true)
end

-- The route a catch-up takes where a guide passed whole offers several: the
-- option with the most quest work done (Own.doneIn), the recommended one
-- among equals.
function Own.likeliestRoute(from)
	local options = routeOptions(from)
	if #options == 0 then return nil end
	local best, bestDone = {}, -1
	for _, o in ipairs(options) do
		local done = Own.doneIn(o.guide)
		if done > bestDone then best, bestDone = { o }, done elseif done == bestDone then best[#best + 1] = o end
	end
	return #best == 1 and best[1].guide.id or rankRoutes(best).guide.id
end

-- The guide to continue with after `from` (or nil), and whether the player
-- has to choose it first.
local function routeNext(from)
	if not from.nextChoices then return from.next, false end
	local options = routeOptions(from)
	if #options == 0 then return nil, false end
	if #options == 1 then return options[1].guide.id, false end
	local remembered = routesTable()[from.id]
	for _, o in ipairs(options) do
		if o.guide.id == remembered then return remembered, false end
	end
	if ns.Get("behavior.routeChoice") == "recommended" then return rankRoutes(options).guide.id, false end
	return nil, true
end

-- The route choice that offered `id`, to offer again: a guide the character
-- fits whose choice has 2+ options for them, or nil.
local function choiceOffering(id)
	if not player then refreshPlayer() end
	for _, from in ipairs(Guides.OfferedBy(id)) do
		if Guides.GuideMatches(from, player) and #routeOptions(from) >= 2 then return from end
	end
	return nil
end

---------------------------------------------------------------------------
-- Class training reminder: Core/ClassTrainers.lua registers every known class
-- trainer; opening one of the character's class stores the level
-- (CharState().classTrainLevel). With behavior.trainReminder "2" (default)
-- or "1", TRAIN_DUE(level, trainer) fires once per level when that many
-- levels have passed (with "2", on even levels, when classes learn spells),
-- unless the active guide trains the class within its next few steps. A
-- character first seen without a stored level counts as trained.
---------------------------------------------------------------------------

local classTrainers = { candidates = {} } -- a pseudo goal, so pickFor ranks them
local trainerClasses = {} -- npc -> { [classFile] = true }, every class trainer
local TRAIN_LOOKAHEAD = 4 -- applicable steps, from the current one

function ns.RegisterClassTrainers(list)
	if type(list) ~= "table" then return end
	local c = classTrainers.candidates
	for _, t in ipairs(list) do
		if type(t) == "table" and type(t.npc) == "number" and type(t.map) == "number" and type(t.x) == "number"
			and type(t.y) == "number" and type(t.classes) == "table" then
			c[#c + 1] = t
		end
	end
	picks[classTrainers] = nil
end

-- Every class trainer's npc id by class ({ WARRIOR = { 914, ... } }), not only
-- the reminder's one per town: what Engine.IsClassTrainer answers from.
function ns.RegisterClassTrainerIds(byClass)
	if type(byClass) ~= "table" then return end
	for cls, ids in pairs(byClass) do
		if type(cls) == "string" and type(ids) == "table" then
			for _, id in ipairs(ids) do
				if type(id) == "number" then
					trainerClasses[id] = trainerClasses[id] or {}
					trainerClasses[id][cls] = true
				end
			end
		end
	end
end

-- Where the guide goes next: the first open goal with coordinates of each of
-- the next ROUTE_STEPS applicable steps from the live step (not the one on
-- screen), in order.
-- (On Own: the main chunk is at 200 locals.)
Own.ROUTE_STEPS = 8
Own.ROUTE_TIE = 15 -- seconds of detour that count as no difference
function Own.routePoints()
	local pts = {}
	local from = computed or current
	if not (guide and from) then return pts end
	local seen = 0
	for s = from, #guide.steps do
		local step = guide.steps[s]
		if stepApplies(step) then
			for g, goal in ipairs(step.goals) do
				if goalApplies(goal) and goal.map and goal.x and goal.y and not goalDone(s, g, goal) then
					pts[#pts + 1] = { map = goal.map, x = goal.x, y = goal.y, f = goal.f }
					break
				end
			end
			seen = seen + 1
			if seen >= Own.ROUTE_STEPS then break end
		end
	end
	return pts
end

-- Seconds added to walking from `here` through `pts` by a stop at `t`, by
-- `cost` (a travel function), on the cheapest leg to leave and rejoin the
-- route at; and that leg's end index. Nil when no leg can be measured.
function Own.routeDetour(here, pts, t, cost)
	local best, at_, a = nil, nil, here
	for i, b in ipairs(pts) do
		local ab, at, tb = cost(a, b), cost(a, t), cost(t, b)
		if ab and at and tb and (not best or at + tb - ab < best) then best, at_ = at + tb - ab, i end
		a = b
	end
	return best, at_
end

-- The trainer of the best pickFor tier (continent, zone level) among `list`
-- (nearest first) that costs the least detour on the guide's next steps; a
-- trainer within ROUTE_TIE of a nearer one loses to it. Straight lines pick
-- the Own.ROUTE_PLANNED likeliest, then the route planner prices each one's
-- best leg, so a trainer on the far side of a mountain does not win by
-- being close as the crow flies. Nil when the guide has no route ahead of
-- the player to measure against.
Own.ROUTE_PLANNED = 4
function Own.trainerOnRoute(list, tier)
	local here = ns.PlayerPoint()
	local pts = here and Own.routePoints()
	if not pts or #pts == 0 then return nil end
	local rough = {}
	for order, c in ipairs(list) do
		if tier[c] == tier[list[1]] then
			local d, leg = Own.routeDetour(here, pts, c, ns.DirectTravelCost)
			if d then rough[#rough + 1] = { c = c, d = d, leg = leg, order = order } end
		end
	end
	table.sort(rough, function(x, y)
		if x.d ~= y.d then return x.d < y.d end
		return x.order < y.order
	end)
	local best, bestCost
	for k = 1, math.min(Own.ROUTE_PLANNED, #rough) do
		local r = rough[k]
		local from = r.leg == 1 and here or pts[r.leg - 1]
		local to = pts[r.leg]
		local ab, at, tb = ns.TravelCost(from, to), ns.TravelCost(from, r.c), ns.TravelCost(r.c, to)
		r.cost = ab and at and tb and at + tb - ab or r.d
	end
	local planned = {}
	for k = 1, math.min(Own.ROUTE_PLANNED, #rough) do planned[#planned + 1] = rough[k] end
	table.sort(planned, function(x, y) return x.order < y.order end)
	for _, r in ipairs(planned) do
		if not best or r.cost < bestCost - Own.ROUTE_TIE then best, bestCost = r.c, r.cost end
	end
	return best
end

-- The best class trainer for the character from where they stand, or nil;
-- its npcName in the client's language where Names has it. `onRoute`: the one
-- that costs the least detour on the guide's route instead, when it has one.
function Engine.NearestClassTrainer(onRoute)
	if #classTrainers.candidates == 0 then return nil end
	if not player then refreshPlayer() end
	local p = pickFor(classTrainers)
	local t = p.list[p.i]
	if onRoute and t then t = Own.trainerOnRoute(p.list, p.tier) or t end
	if t then
		t.npcEnglish = t.npcEnglish or t.npcName
		t.npcName = ns.Names.Npc(t.npc) or t.npcEnglish
	end
	return t
end

-- Whether `npc` is a class trainer of the character's class.
function Engine.IsClassTrainer(npc)
	local classes = npc and trainerClasses[npc]
	if not classes then return false end
	if not player then refreshPlayer() end
	return classes[player.class] == true
end

-- The active guide's next class training stop from the live step, whichever
-- step is on screen: its place among the applicable steps (the live step is
-- 1) and the step's title. A `train` goal that already reads done (trained
-- there, or ticked) is no stop. False when the guide trains the class nowhere
-- ahead; nil with no guide.
function Engine.GuideTrainStop()
	local from = computed or current
	if not (guide and from) then return nil end
	local seen = 0
	for s = from, #guide.steps do
		local step = guide.steps[s]
		if stepApplies(step) then
			seen = seen + 1
			for g, goal in ipairs(step.goals) do
				if goal.t == "train" and goalApplies(goal) and (goal.class or (goal.npc and trainerClasses[goal.npc]))
					and not goalDone(s, g, goal) then
					return seen, step.title
				end
			end
		end
	end
	return false
end

-- The active guide sends the character to their class trainer soon: within
-- TRAIN_LOOKAHEAD steps of the live step.
local function guideTrainsSoon()
	local n = Engine.GuideTrainStop()
	return n and n <= TRAIN_LOOKAHEAD or false
end

local trainChecked -- the level last checked this session
local function checkTrainDue()
	local mode = ns.Get("behavior.trainReminder")
	local every = (mode == "1" and 1) or (mode == "2" and 2) or nil
	local level = player and player.level
	if not (every and level) or trainChecked == level then return end
	trainChecked = level
	local s = ns.CharState()
	local last = tonumber(s.classTrainLevel)
	if not last or last > level then
		s.classTrainLevel = level
		return
	end
	if level - last < every or (every == 2 and level % 2 == 1) or tonumber(s.trainDueShown) == level then return end
	if guideTrainsSoon() then return end
	local t = Engine.NearestClassTrainer(true)
	if not t then return end
	s.trainDueShown = level
	ns.Fire("TRAIN_DUE", level, t)
end

-- A trainer window of the character's class: the reminder's level
-- (classTrainLevel, also set on first sight). classTrainVisit, which `train
-- class` trusts, is set only when that trainer taught a spell
-- (Own.trainerLearned) or listed none to learn (Own.trainerChecked).
local function noteClassTrainer(npc)
	if not Engine.IsClassTrainer(npc) then return end
	refreshPlayer()
	local s = ns.CharState()
	s.classTrainLevel = player.level or 1
	ns.Fire("CLASS_TRAINED", s.classTrainLevel)
end

-- `train class` has nothing to teach: the character's class trainer taught
-- a spell (Own.trainerLearned) or listed none left (Own.trainerChecked) at this level or at
-- the even level below an odd one (class trainers teach on even levels
-- only). Latched once the route moves past (latchable), so the next level
-- does not send the player back.
function Own.nothingToTrain()
	local visit, level = tonumber(ns.CharState().classTrainVisit), player and player.level
	return visit ~= nil and level ~= nil and visit <= level and level - visit <= level % 2
end

-- Fresh step state for a new guide in the loaded tab.
local function resetLoaded(id, auto)
	-- Opened by the player: finished or passed whole earlier this session, it
	-- may finish and chain again.
	if not auto then completedFired[id] = nil end
	if not Engine.TabIds()[id] then Own.withFeeders(id, true) end
	guide = Guides.Get(id)
	current, computed, pin, pinDone, aim, lastSig, passedUpTo = nil, nil, nil, nil, nil, nil, 0
	Own.skipQueue[id] = nil
	autoChain, sawIncomplete, placing = auto and true or false, false, GetTime() + PLACE_SECONDS
	Own.opened[id] = true
	Own.endOpen[id], Own.lastOpen[id] = nil, nil -- seen afresh once placed (Own.noteEnd)
	tabsDirty = true
end

-- Guide `id` into tab `index` in place of its guide, which goes to the
-- closed tabs (Own.rememberClosed); `id` starts afresh (resetLoaded), at
-- the step the player was looking at if they closed it before
-- (Own.takeClosed). Leaves that tab loaded.
function Own.replaceTab(index, id, auto)
	use(tabs[index])
	sync()
	Own.rememberClosed(guide.id, index)
	resetLoaded(id, auto)
	pin, pinDone = Own.takeClosed(id)
end

-- Notices of quests passed over, per guide, until the player is on the live
-- step: { from = the first step passed, skips = { { quest, title, reason,
-- text }, ... }, seen = { [quest] = true } }.
Own.skipQueue = {}

-- Queue the unavailable quests of step s the route just moved past: its
-- blocking goals that apply, not done, unavailable (once per quest). A step
-- the player skipped, or one not for the character, says nothing.
function Own.queueSkips(s)
	local step = guide.steps[s]
	if not step or isSkipped(s) or not stepApplies(step) then return end
	local q = Own.skipQueue[guide.id]
	for g, goal in ipairs(step.goals) do
		local u = blocks(goal) and goalApplies(goal) and unavailableFor(goal)
		if u and not (q and q.seen[goal.quest]) and not goalDone(s, g, goal) then
			if not q then
				q = { from = s, skips = {}, seen = {} }
				Own.skipQueue[guide.id] = q
			end
			q.seen[goal.quest] = true
			q.skips[#q.skips + 1] = { quest = goal.quest, title = questTitle(goal), reason = u.reason, text = unavailableText(u) }
		end
	end
end

-- The live step went back from `to` to `from`: hold it at `to` for every
-- accept in between whose quest left the log (not done, not skipped), and
-- ask (Engine.LostQuestion). A held quest back in the log, done or skipped
-- is forgotten first. With behavior.lostQuests "back" or "skip" (#1365) the
-- answer is given at once instead, as Engine.AnswerLost gives it: "back"
-- holds nothing, so the route goes back to the giver; "skip" skips the
-- quest and what follows. Either is said in chat (Own.lostSaid, flushed by
-- evaluate). True if a quest is newly held or skipped.
Own.lostSaid = {} -- { { quest, title, answer }, ... }
function Own.holdLost(from, to)
	local st, C = ns.CharState(), Compat()
	local answer = ns.Get("behavior.lostQuests")
	local mine = st.lostQuests and st.lostQuests[guide.id]
	local held = false
	for s = from, to - 1 do
		local step = guide.steps[s]
		if stepApplies(step) and not isSkipped(s) then
			for g, goal in ipairs(step.goals) do
				local q = goal.quest
				if goal.t == "accept" and q and blocks(goal) and goalApplies(goal) and not goalDone(s, g, goal)
					and Own.removed[q] and not C.IsOnQuest(q) and not questDone(q) and not Own.questSkipped(q) then
					-- Abandoned after it failed (Own.wasFailed): to take it again, as
					-- its failed line said, so the route goes back without asking.
					local a = Own.wasFailed[q] and "back" or answer
					Own.wasFailed[q] = nil
					if a == "back" or a == "skip" then
						Own.removed[q] = nil
						Own.lostSaid[#Own.lostSaid + 1] = { q, questTitle(goal), a }
						if a == "skip" then
							if type(st.skippedQuests) ~= "table" then st.skippedQuests = {} end
							st.skippedQuests[q] = true
							held = true
						end
					else
						if not mine then
							st.lostQuests = st.lostQuests or {}
							mine = st.lostQuests[guide.id] or {}
							st.lostQuests[guide.id] = mine
						end
						mine[q] = math.max(mine[q] or 0, to)
						held = true
					end
				end
			end
		end
	end
	return held
end

-- Forget the held quests of the loaded guide that are back in the log, done
-- or skipped.
function Own.pruneLost()
	local all = ns.CharState().lostQuests
	local mine = all and all[guide.id]
	if not mine then return end
	local C = Compat()
	for q in pairs(mine) do
		if C.IsOnQuest(q) or questDone(q) or Own.questSkipped(q) then mine[q] = nil end
	end
	if not next(mine) then all[guide.id] = nil end
	if not next(all) then ns.CharState().lostQuests = nil end
end

---------------------------------------------------------------------------
-- The end of a leveling guide (category Leveling: the starting zones and
-- community leveling guides too). With behavior.guideEnd "ask" (default)
-- it does not hand off by itself: GUIDE_END(guideId, info) asks the player
-- (UI/GuideEnd.lua), who starts the next guide (Engine.StartNext), chooses
-- a route, or stays. With "continue" the hand-off loads the next guide as
-- before and GUIDE_CONTINUED(fromId, toId) says so. Other guides always go on.
--
-- The end is reached when the guide is done, or when its last step with
-- work for the character (Own.lastWork) is done ahead of the live step,
-- whatever steps before it were skipped or left open (Own.endDoneAhead: by
-- the kinds of its goals). The guide must have been seen unfinished once
-- placed this session (Own.endOpen), and for the last step done ahead, that
-- step seen open (Own.lastOpen), so a guide opened, or brought back by a
-- login, already at its end does not ask; and once per guide per character
-- (CharState().guideEnds[guideId], kept over a reload or relog). That record
-- is not the end itself: with a live step, it stands only while the end
-- still holds (Own.endHolds), and Engine.ResetProgress forgets it.
-- info = { guideId, undone (open steps left), live (the live step, nil when
-- all are done), next (the guide the hand-off goes to, nil with none or a
-- choice to make), choose (true: a route choice the player makes) }.
---------------------------------------------------------------------------

Own.endOpen = {} -- guideId -> true: seen unfinished once placed, this session
Own.lastOpen = {} -- guideId -> the last step (Own.lastWork) seen open once placed, this session
Own.pendingEnds, Own.pendingContinued = {}, {} -- fired at the end of the evaluation

function Own.leveling(g)
	return g ~= nil and not Own.everyStep(g)
end

function Own.endAsks(g)
	return Own.leveling(g) and ns.Get("behavior.guideEnd") ~= "continue"
end

-- The last step of the loaded guide with work for the character, after step
-- `after` (0: any): it applies, is not an along step, and has a goal that
-- applies and is neither a note nor optional (a closing note-only step, or a
-- class's training step another class reads empty, is no end). `forAll`:
-- not a step only for some characters either (Own.forSome). -> index | nil
function Own.lastWork(after, forAll)
	local steps = guide.steps
	for s = #steps, after + 1, -1 do
		local step = steps[s]
		if not step.along and stepApplies(step) and not (forAll and Own.forSome(step)) then
			for _, goal in ipairs(step.goals) do
				if goal.t ~= "note" and not goal.optional and goalApplies(goal) then return s end
			end
		end
	end
	return nil
end

-- A class's or a race's own step: its `only` names classes or races, or each
-- goal of its work does, or is a class quest by the quest database (Cat Form
-- at the end of The Barrens for Druids). Such quests and trips are also done
-- in class guides and on their own schedule, so they are never a leveling
-- guide's end done ahead (Fitz, 2026-11-06). (On Own: the main chunk is at
-- Lua's 200 locals.)
function Own.someOnly(only)
	return type(only) == "table" and ((type(only.classes) == "table" and #only.classes > 0) or (type(only.races) == "table" and #only.races > 0))
end
Own.ALL_CLASSES = 1503 -- the class bits of the quest database's masks (QuestDB CLASS_BIT)
function Own.classQuest(q)
	local Q = ns.QuestDB
	local r = q and Q and Q.IsLoaded and Q.IsLoaded() and Q.QuestRecord(q)
	local mask = r and r[Q.F.CLASSES]
	if not mask then return false end
	local band = bit and bit.band
	return not band or band(mask, Own.ALL_CLASSES) ~= Own.ALL_CLASSES
end
function Own.forSome(step)
	if Own.someOnly(step.only) then return true end
	local any = false
	for _, goal in ipairs(step.goals) do
		if goal.t ~= "note" and not goal.optional and goalApplies(goal) then
			if not (Own.someOnly(goal.only) or Own.classQuest(goal.quest)) then return false end
			any = true
		end
	end
	return any
end

-- Whether the end of the loaded guide holds with the live step before it:
-- its last step for everyone (`last`, Own.lastWork) done, on screen or
-- ahead of the live step (Own.endDoneAhead), its work really done, not
-- only passed over as unavailable for now (Own.endWorkDone, #998), and not
-- skipped.
function Own.endHolds(last)
	if last == nil or isSkipped(last) or not Own.endWorkDone(last) then return false end
	if last == current then return stepDone(last) end
	return Own.endDoneAhead(last)
end

-- The loaded tab's guide: note its end (see above).
function Own.noteEnd()
	if placing or not Own.endAsks(guide) then return end
	-- A live step with nothing left to do now (waiting on a level, Own.holdsBefore)
	-- is no end yet: the end comes after it.
	if computed and stepDone(computed) and Own.levelHold() == computed then return end
	local id, steps = guide.id, guide.steps
	local ends = ns.CharState().guideEnds
	-- The end done ahead is judged on the last step for everyone (Own.forSome).
	-- With the live step past it, a class's or race's own steps after it
	-- still to come (Own.lastWork from the live step) are no end yet: the end
	-- comes with them.
	local last = Own.lastWork(0, true)
	if computed then
		-- Seen unfinished once placed: finishing it from now on reaches its end.
		Own.endOpen[id] = true
		local holds = Own.endHolds(last)
		-- An end told before stands only while it holds: a quest of the last
		-- step abandoned, or a record from before 0.3.6 that slipped through
		-- (Init.lua drops those), and it is forgotten; reached again, it is
		-- told again.
		if ends[id] then
			if not holds then
				ends[id] = nil
				Own.lastOpen[id] = last
			end
			return
		end
		-- Its last step done ahead of the live step (Own.endDoneAhead; on
		-- screen as any step), once that same step was seen open: one that
		-- reads done from the start (its quest not offered to this character),
		-- or a `when` step that applies late already done, ends the guide only
		-- when the rest is done; so does one whose work only reads done as
		-- unavailable for now (Own.endWorkDone, #998). Trailing steps of only
		-- optional goals or notes are offered, not the end (Own.lastWork).
		local waits = last ~= nil and computed > last and Own.lastWork(computed - 1) ~= nil
		if waits or not holds then
			if last then Own.lastOpen[id] = last end
			return
		end
		if Own.lastOpen[id] ~= last then return end
	elseif ends[id] or not Own.endOpen[id] then
		return
	end
	ends[id] = true
	local undone = 0
	for s = computed or #steps + 1, #steps do
		if stepApplies(steps[s]) and not isSkipped(s) and not stepDone(s) then undone = undone + 1 end
	end
	local nextId, asks = routeNext(guide)
	if nextId and not Guides.Get(nextId) then nextId = nil end
	Own.pendingEnds[#Own.pendingEnds + 1] = { guideId = id, undone = undone, live = computed, next = nextId, choose = asks or nil }
end

-- Evaluate the loaded tab. Only the active tab announces step and waypoint
-- changes; background tabs keep their state for GetTabs and automation.
local function evaluateLoaded(active)
	if not guide then
		current, computed, pin = nil, nil, nil
		if active and waypoint ~= nil then
			waypoint = nil
			ns.Fire("WAYPOINT_CHANGED", nil)
		end
		return
	end
	-- A Class guide the character cannot start yet holds at its opening
	-- without placing (which would mark its accepts unavailable and move on).
	local gate = Own.startGate(guide)
	local wasComputed = computed
	Own.pruneLost()
	computed = gate and gate.step or computeCurrent()
	-- Placed once the quest log could be read (it can lag PLAYER_LOGIN).
	local wasPlacing = placing
	if placing and (logReady or GetTime() >= placing) then placing = nil end
	local placed = wasPlacing and not placing
	-- A quest the route had passed left the log: the live step stays and the
	-- window asks whether to go back for it (Own.holdLost), never silently.
	if not (gate or wasPlacing) and computed and wasComputed and computed < wasComputed and Own.holdLost(computed, wasComputed) then
		computed = computeCurrent()
		lastSig = nil
	end
	if computed then
		sawIncomplete = true
		Own.startWaits(computed)
	end
	local passed = (computed or #guide.steps + 1) - 1
	if passed > passedUpTo then latchPassed(passedUpTo + 1, passed) end
	Own.latchCaughtUp(passed)
	passedUpTo = passed

	-- The view of another step: released once it is the live step (or no
	-- longer applies); while the step looked at gets done it follows forward,
	-- behind the live step up to it, ahead of it to the next open step, its
	-- transient goals latched like any step the route moves past. A step
	-- hidden from the character (a saved view from before #942, an along
	-- step) gives way to the next one they can look at.
	local oldPin = pin
	if pin and guide.steps[pin] and Own.numbersOf(guide).hidden[pin] then
		local s = pin
		repeat s = nextApplicable(s) until not s or Own.lookable(s)
		pin = s
	end
	if pin and ((computed and pin == computed) or not Own.lookable(pin)) then pin = nil end
	if pin then
		local done = stepDone(pin)
		if done and not pinDone then
			latchPassed(pin, pin)
			pin = nextOpen(pin, (computed and computed > pin) and computed or nil)
			pinDone = pin and stepDone(pin) or nil
		else
			pinDone = done
		end
	end

	local newCurrent = pin or computed
	local changed = newCurrent ~= current
	-- Bag-count goals already met in the step about to be (or still) current
	-- stay met for the rest of it, even if the items get used up (crafted,
	-- handed in) before the step's other goals are done.
	if newCurrent then latchInStep(newCurrent, newCurrent == computed) end
	if pin and computed then latchInStep(computed, true) end
	-- Quests passed over as unavailable (not offered at the giver, or closed
	-- for good) are said, never silently: when the live step moves past its
	-- step, and when the step looked at follows forward past its own. While
	-- the player looks at another step the notice waits, and comes with the
	-- live step when they are back on it (#741, #739: Fitz pages a lot).
	-- STEP_SKIPPED(fromStep, toStep, { { quest, title, reason, text }, ... }),
	-- before STEP_CHANGED, so the window shows it with the step.
	if active and not wasPlacing then
		if wasComputed and (not computed or computed > wasComputed) then Own.queueSkips(wasComputed) end
		if oldPin and pin ~= oldPin and oldPin ~= wasComputed and (not newCurrent or newCurrent > oldPin) then Own.queueSkips(oldPin) end
		local q = Own.skipQueue[guide.id]
		if q and not pin then
			Own.skipQueue[guide.id] = nil
			ns.Fire("STEP_SKIPPED", q.from, newCurrent, q.skips)
			-- Back on the live step without a step change: repaint for the notice.
			if not changed then lastSig = nil end
		end
	end
	if changed then
		current = newCurrent
		-- The arrow's choice was for the old step; an along goal's lasts while it
		-- is listed, a "While you're here" line's while it shows.
		if not (aim and (Own.alongOf(aim) or Own.hereOf(aim))) then aim = nil end
		if active then Own.hereDirty = true end
		-- Step start: pick candidates and spawn spots afresh from where the
		-- player stands. A spot picked earlier (the step shown as "Then:" or
		-- looked at ahead, from elsewhere) would otherwise only move at the
		-- next arrival poll: a second evaluation right after the step change.
		-- A goto's place counts as entered only from outside seen from now on
		-- (Own.enteredPlace), also when the player comes back to the step.
		if current then
			local c, px, py
			for _, goal in ipairs(guide.steps[current].goals) do
				Own.outside[goal] = nil
				if goal.candidates then picks[goal] = nil end
				if goal.spots and Spots.chosen[goal] then
					if px == nil then c, px, py = Compat().GetPlayerWorldPosition() end
					if c then Spots.repick(goal, c, px, py) end
				end
			end
		end
		lastSig = signature()
		tabsDirty = true
		if active then ns.Fire("STEP_CHANGED", current) end
	else
		local sig = signature()
		if sig ~= lastSig then
			lastSig = sig
			tabsDirty = true
			if active and current then ns.Fire("STEP_UPDATED", current) end
		end
	end

	if active then
		local wp = findWaypoint()
		if not sameWaypoint(wp, waypoint) then
			waypoint = wp
			ns.Fire("WAYPOINT_CHANGED", wp)
		end
	end

	-- A skip that left the rest out is no completion (Engine.SkippedOut).
	if not current and not Engine.SkippedOut() then
		local id = guide.id
		if not completedFired[id] then
			completedFired[id] = true
			if active then
				ns.Fire("GUIDE_COMPLETED", id)
			else
				pendingCompleted[#pendingCompleted + 1] = id
			end
			-- The hand-off replaces the finished guide within its own tab,
			-- unless the next guide is already open in another one. A route
			-- choice the player has to make keeps the finished guide and asks.
			-- A leveling guide hands off by itself only with behavior.guideEnd
			-- "continue" (else its end asks: Own.noteEnd); the catch-up
			-- passes through whatever the setting.
			local through = Own.placedThrough[id]
			Own.placedThrough[id] = nil
			local mayChain = (autoChain or sawIncomplete or through) and (through or not Own.endAsks(guide))
			local nextId, asks = routeNext(guide)
			if through and asks then nextId, asks = Own.likeliestRoute(guide), false end
			if mayChain and asks then pendingChoices[#pendingChoices + 1] = id end
			-- A catch-up goes on through guides finished earlier this session
			-- (another try): only a guide it already passed on this run stops
			-- it, against a loop of `next`.
			local again = through and not Own.chainSeen[nextId] and nextId ~= id
			if mayChain and nextId and Guides.Get(nextId) and (again or not completedFired[nextId]) and not tabIndexOf(nextId) then
				if through then
					Own.chainSeen[id] = true
					completedFired[nextId] = nil
					if active then Own.placedChain[#Own.placedChain + 1] = id end
				end
				Own.opened[id] = nil
				-- "Continue automatically" says so (GUIDE_CONTINUED, after the evaluation).
				if not through and Own.leveling(guide) then
					ns.CharState().guideEnds[id] = true
					Own.pendingContinued[#Own.pendingContinued + 1] = { id, nextId }
				end
				resetLoaded(nextId, true)
				persist()
				if active then ns.Fire("GUIDE_CHANGED", nextId) end
				evaluateLoaded(active)
				return
			end
		end
	end
	Own.noteEnd()
	-- Placed: where a guide just opened resumes, and the guides passed whole
	-- on the way (the guide window shows the catch-up). A guide a login or
	-- reload brings back is placed without it.
	if placed then
		local opened = Own.opened[guide.id]
		local chain = Own.placedChain
		Own.chainSeen, Own.placedChain, Own.opened[guide.id] = {}, {}, nil
		if active and opened then ns.Fire("GUIDE_PLACED", guide.id, computed, chain) end
	end
end

-- Start the countdown of each `wait` goal of step s whose earlier goals (the
-- ones that hold the route) are all done.
function Own.startWaits(s)
	local goals = guide.steps[s].goals
	local ready = true
	for g = 1, #goals do
		local goal = goals[g]
		if goal.t == "wait" and goalApplies(goal) and not Own.waitStart[goal] and ready then
			Own.waitStart[goal] = GetTime()
		end
		if ready and Own.holds(s, goal) and goalApplies(goal) and not Own.goalSkipped(s, g) and not goalDone(s, g, goal) then ready = false end
	end
end

-- While the live step has a `wait` counting down: evaluate again each second,
-- so its countdown line moves and it is done on time. One timer at a time.
function Own.watchWait()
	if Own.waitTimer or not (guide and computed and guide.steps[computed]) then return end
	for g, goal in ipairs(guide.steps[computed].goals) do
		if goal.t == "wait" and Own.waitStart[goal] and not checked(computed, g) and not goalDone(computed, g, goal) then
			Own.waitTimer = true
			ns.After(1, function()
				Own.waitTimer = false
				requestUpdate()
			end)
			return
		end
	end
end

-- While the shown step has an open hearth goal whose Hearthstone waits:
-- evaluate again when its minute changes and once it is ready, so the time
-- left and the walk to the inn follow it (#576). One timer at a time
-- (Own.hearthTimer: the main chunk is at 200 locals).
function Own.watchHearth()
	if Own.hearthTimer or not (guide and current and guide.steps[current]) then return end
	local wait
	for g, goal in ipairs(guide.steps[current].goals) do
		if goal.t == "hearth" and goalApplies(goal) and not goalDone(current, g, goal) then
			local w = Own.hearthWait(goal)
			if w and w > 0 and (not wait or w < wait) then wait = w end
		end
	end
	if not wait then return end
	local nextIn = wait % 60
	if nextIn < 0.5 then nextIn = 60 end
	Own.hearthTimer = true
	ns.After(math.min(nextIn, wait) + 0.1, function()
		Own.hearthTimer = false
		requestUpdate()
	end)
end

-- Evaluate every tab, the active one last.
local function evaluate()
	lastEval = GetTime()
	generation = generation + 1
	refreshPlayer()
	for i = 1, #tabs do
		if i ~= activeIndex then
			use(tabs[i])
			evaluateLoaded(false)
		end
	end
	useActive()
	evaluateLoaded(true)
	Own.watchHearth()
	Own.watchWait()
	-- Out-levelled: once per guide per session; for a guide the catch-up may
	-- pass whole for the player (Own.opened, autoChain), once it is placed.
	local mayPass = placing and autoChain and Own.opened[guide and guide.id or ""] and ns.Get("behavior.skipGrey")
	if guide and guide.maxLevel and (player.level or 1) >= guide.maxLevel + 2 and not outleveled[guide.id] and not mayPass then
		outleveled[guide.id] = true
		local suggested = Guides.Suggest()
		ns.Fire("GUIDE_OUTLEVELED", guide.id, suggested ~= guide.id and suggested or nil)
	end
	checkTrainDue()
	-- "While you're here" candidates, after a step, quest-log, level or zone
	-- change (Own.hereBuild); a clicked line that went takes the arrow back.
	if Own.hereDirty or Own.hereGuide ~= guide then
		if Own.hereBuild() then requestUpdate() end
	end
	updateTicker()
	if #pendingCompleted > 0 then
		local list = pendingCompleted
		pendingCompleted = {}
		for i = 1, #list do ns.Fire("GUIDE_COMPLETED", list[i]) end
	end
	if tabsDirty then fireTabs() end
	if #pendingChoices > 0 then
		local list = pendingChoices
		pendingChoices = {}
		for i = 1, #list do ns.Fire("ROUTE_CHOICE", list[i]) end
	end
	if #Own.pendingContinued > 0 then
		local list = Own.pendingContinued
		Own.pendingContinued = {}
		for i = 1, #list do ns.Fire("GUIDE_CONTINUED", list[i][1], list[i][2]) end
	end
	if #Own.pendingEnds > 0 then
		local list = Own.pendingEnds
		Own.pendingEnds = {}
		for i = 1, #list do ns.Fire("GUIDE_END", list[i].guideId, list[i]) end
	end
	-- A quest that left the log, answered by the setting (Own.holdLost): said
	-- in chat; a skip also offers its undo (PLAYER_SKIPPED_QUEST).
	if #Own.lostSaid > 0 then
		local list = Own.lostSaid
		Own.lostSaid = {}
		for _, e in ipairs(list) do
			if e[3] == "skip" then
				ns.Print(L["%s is no longer in your quest log: the guide skips it and what follows."]:format(ns.Quoted(e[2])))
				ns.Fire("PLAYER_SKIPPED_QUEST", e[1], e[2])
			else
				ns.Print(L["%s is no longer in your quest log: the guide goes back for it."]:format(ns.Quoted(e[2])))
			end
		end
	end
end

local scheduled = false
local function flush()
	scheduled = false
	evaluate()
end

requestUpdate = function()
	if scheduled or #tabs == 0 or not ns.IsLoggedIn() then return end
	scheduled = true
	local wait = lastEval + MIN_INTERVAL - GetTime()
	ns.After(wait > 0 and wait or 0, flush)
end
Engine.RequestUpdate = requestUpdate

-- The active tab changed: announce its guide, step and waypoint.
local function announceActive()
	generation = generation + 1
	if not player then refreshPlayer() end
	ns.Fire("GUIDE_CHANGED", guide and guide.id or nil)
	if guide then ns.Fire("STEP_CHANGED", current) end
	waypoint = findWaypoint()
	ns.Fire("WAYPOINT_CHANGED", waypoint)
end

---------------------------------------------------------------------------
-- Tab API
---------------------------------------------------------------------------

-- Already open: activates it (unless activate == false). Full: nil. `auto`:
-- opened for the player rather than by them (Engine.StartGuide), so a guide
-- the catch-up passes whole chains on to the next, as the login's pick does,
-- instead of staying open, finished.
function Engine.OpenTab(id, activate, auto)
	if id and not Engine.TabIds()[id] then Own.withFeeders(id, true) end
	local g = id and Guides.Get(id)
	if not g or not ns.IsLoggedIn() then return nil end
	local open = tabIndexOf(id)
	if open then
		if activate ~= false then Engine.SelectTab(open) end
		return open
	end
	if #tabs >= MAX_TABS then return nil end
	local tab = { guide = g, passedUpTo = 0, autoChain = auto and true or false, sawIncomplete = false, placing = GetTime() + PLACE_SECONDS }
	-- Closed before: back at the step the player was looking at.
	tab.pin, tab.pinDone = Own.takeClosed(id)
	-- Finished or passed earlier this session, it may finish and chain again.
	completedFired[id] = nil
	Own.opened[id] = true
	Own.endOpen[id], Own.lastOpen[id] = nil, nil -- seen afresh once placed (Own.noteEnd)
	tabs[#tabs + 1] = tab
	local index = #tabs
	tabsDirty = true
	if activate ~= false or activeIndex == 0 then
		activeIndex = index
		useActive()
		persist()
		ns.Fire("GUIDE_CHANGED", id)
	else
		persist()
	end
	evaluate()
	return index
end

function Engine.SelectTab(index)
	if type(index) ~= "number" or not tabs[index] or index == activeIndex then return end
	activeIndex = index
	useActive()
	persist()
	tabsDirty = true
	announceActive()
	evaluate()
end

-- Closing the active tab activates its right neighbour (else the left one);
-- closing the last tab leaves no guide. The player's close keeps the tab
-- among the closed ones (Engine.ReopenClosedTab) and fires
-- TAB_CLOSED(guideId), for the window's undo. `quiet`: Polestar closes a tab
-- it is done with (a finished dungeon pick-up or class guide, a generated
-- guide reopening rebuilt), which is neither kept nor announced.
function Engine.CloseTab(index, quiet)
	if type(index) ~= "number" or not tabs[index] then return end
	sync()
	local tab = table.remove(tabs, index)
	if not quiet then Own.rememberClosed(tab.guide.id, index) end
	tabsDirty = true
	if index == activeIndex then
		activeIndex = math.min(index, #tabs)
		useActive()
		persist()
		announceActive()
	else
		if index < activeIndex then activeIndex = activeIndex - 1 end
		persist()
	end
	evaluate()
	if not quiet then ns.Fire("TAB_CLOSED", tab.guide.id) end
end

-- The closed tabs whose guide is registered and in no tab, newest first:
-- { { guideId, title, at }, ... }.
function Engine.ClosedTabs()
	local out, openIds = {}, Engine.TabIds()
	for _, c in ipairs(Own.closed) do
		local g = Guides.Get(c.id)
		if g and not openIds[c.id] then out[#out + 1] = { guideId = c.id, title = g.title, at = c.at } end
	end
	return out
end

-- Reopen a closed tab: guide `id`'s, else the last one closed (of
-- Engine.ClosedTabs), at its old place, active, at the step the player was
-- looking at. -> index | nil
-- (none closed, or six tabs open).
function Engine.ReopenClosedTab(id)
	if not ns.IsLoggedIn() or #tabs >= MAX_TABS then return nil end
	for _, c in ipairs(Engine.ClosedTabs()) do
		if id == nil or c.guideId == id then
			local index = Engine.OpenTab(c.guideId)
			if index and c.at and c.at < index then
				Engine.MoveTab(index, c.at)
				index = math.max(c.at, 1)
			end
			return index
		end
	end
	return nil
end

function Engine.MoveTab(from, to)
	if type(from) ~= "number" or type(to) ~= "number" or not tabs[from] then return end
	if to < 1 then to = 1 elseif to > #tabs then to = #tabs end
	if from == to then return end
	local activeTab = tabs[activeIndex]
	local tab = table.remove(tabs, from)
	table.insert(tabs, to, tab)
	for i = 1, #tabs do
		if tabs[i] == activeTab then activeIndex = i end
	end
	persist()
	fireTabs()
end

-- For the picker: "new", "started" (opened in a tab before, or has
-- check-offs/skips) or "done" (finished this session, or open and finished;
-- a guide the catch-up passed whole is done only once every quest the
-- character can take in it is turned in, not for its quests left out);
-- doneSteps/totalSteps when the guide is open in a tab.
function Engine.GetGuideState(id)
	local g = id and Guides.Get(id)
	if not g then return nil end
	if not player then refreshPlayer() end
	local open = tabIndexOf(id)
	local done, total
	local finished = completedFired[id]
	if open then
		use(tabs[open])
		done, total = progressLoaded()
		finished = finished or (computed == nil and not Engine.SkippedOut())
		useActive()
	end
	if finished and not (Own.passedWhole[id] and Own.allQuestsDone(g) == false) then return "done", done, total end
	local s = ns.CharState()
	local started = type(s.flags.started) == "table" and s.flags.started[id]
	if open or started or s.manual[id] or s.skipped[id] then return "started", done, total end
	return "new", done, total
end

---------------------------------------------------------------------------
-- Public API
---------------------------------------------------------------------------

function Engine.GetGuide() return guide end

-- Replaces the active tab's guide (opens a first tab when none is open); a
-- guide already open in another tab is selected instead of duplicated. The
-- guide replaced goes to the closed tabs, and a closed one loaded comes
-- back at the step the player was looking at (Own.replaceTab). nil closes
-- the active tab.
function Engine.SetGuide(id)
	if id ~= nil and not Guides.Get(id) then return false end
	if not ns.IsLoggedIn() then
		local s = ns.CharState()
		local list = type(s.tabs) == "table" and s.tabs or {}
		local a = math.min(math.max(tonumber(s.activeTab) or 1, 1), #list + 1)
		if id then
			list[a] = id
		else
			table.remove(list, a)
			a = math.min(a, #list)
		end
		s.tabs, s.activeTab, s.guide = list, a > 0 and a or nil, list[a]
		return true
	end
	if id == nil then
		if activeIndex > 0 then Engine.CloseTab(activeIndex) end
		return true
	end
	if guide and guide.id == id then
		evaluate()
		return true
	end
	local open = tabIndexOf(id)
	if open then
		Engine.SelectTab(open)
	elseif activeIndex == 0 then
		Engine.OpenTab(id)
	else
		Own.replaceTab(activeIndex, id, false)
		persist()
		ns.Fire("GUIDE_CHANGED", id)
		evaluate()
	end
	return true
end

---------------------------------------------------------------------------
-- Route choice API (see "Route choice" above)
---------------------------------------------------------------------------

-- Where a guide's zone art centres. A goal's place on the guide's zone map,
-- in that map's live frame (percent; its own figures when its frame is not
-- registered), or nil when it is elsewhere.
local function onZone(g, goal)
	if not (g.zone and goal.map == g.zone and goal.x and goal.y) then return nil end
	local x, y = goal.x, goal.y
	if goal.f then
		local C = Compat()
		local c, wx, wy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if c then x, y = C.WorldToMap(c, wx, wy, goal.map) end
	end
	if x and y then return { x = x, y = y } end
	return nil
end

-- The first goal of a step placed on the guide's zone map, or nil.
local function stepFocus(g, step)
	for _, goal in ipairs(step.goals) do
		local f = onZone(g, goal)
		if f then return f end
	end
	return nil
end

-- Where the guide starts: its first goal on its zone map, or nil.
local focusCache = setmetatable({}, { __mode = "k" })
local function zoneFocus(g)
	local f = focusCache[g]
	if f == nil then
		f = false
		for _, step in ipairs(g.steps) do
			f = stepFocus(g, step) or false
			if f then break end
		end
		focusCache[g] = f
	end
	return f or nil
end

-- Live-frame percent of where a guide is for this character (the guide
-- menu's zone art), or nil: its current step's place when the guide is open
-- in a tab, unfinished, and that step is on the guide's zone map; otherwise
-- where it starts (zoneFocus).
function Engine.GuideFocus(id)
	local g = id and Guides.Get(id)
	if not g then return nil end
	local open = tabIndexOf(id)
	local t = open and tabs[open]
	local step = t and t.computed ~= nil and t.current and g.steps[t.current]
	local f = step and stepFocus(g, step) or zoneFocus(g)
	if not f then return nil end
	return f.x, f.y
end

-- What the choice after `fromId` offers this character, or nil (no choice,
-- or nothing fits): { from, fromTitle, recommended, chosen, joinsAt,
-- options = { { id, title, zone, zoneName, focusX, focusY, minLevel, maxLevel,
-- pitch, pros, cons, seconds, quests, steps, recommended, chosen, outleveled,
-- open }, ... } }. zone is the guide's uiMapID (for its art), focusX/Y where
-- the route starts on it (live-frame percent); joinsAt: the title of the
-- guide every option continues to, when they share one.
function Engine.GetRouteChoice(fromId)
	local from = fromId and Guides.Get(fromId)
	if not (from and from.nextChoices) then return nil end
	local options = routeOptions(from)
	if #options == 0 then return nil end
	local rec = rankRoutes(options)
	local chosenId = routesTable()[from.id]
	local out = { from = from.id, fromTitle = from.title, recommended = rec.guide.id, chosen = chosenId, options = {} }
	local joins = options[1].guide.next
	for i, o in ipairs(options) do
		local g = o.guide
		if g.next ~= joins then joins = nil end
		local quests = 0
		for _, step in ipairs(g.steps) do
			if Guides.Matches(step.only, player) then
				for _, goal in ipairs(step.goals) do
					if goal.t == "accept" and Guides.Matches(goal.only, player) then quests = quests + 1 end
				end
			end
		end
		local focus = zoneFocus(g)
		out.options[i] = {
			id = g.id, title = g.title, zone = g.zone, zoneName = g.zoneName, focusX = focus and focus.x, focusY = focus and focus.y,
			minLevel = g.minLevel, maxLevel = g.maxLevel,
			pitch = g.pitch, pros = g.pros, cons = g.cons, seconds = o.seconds, quests = quests, steps = #g.steps,
			recommended = o == rec, chosen = g.id == chosenId, outleveled = o.outleveled, open = tabIndexOf(g.id) ~= nil,
		}
	end
	local joinGuide = joins and Guides.Get(joins)
	out.joinsAt = joinGuide and joinGuide.title or nil
	return out
end

-- Continue `fromId`'s route with `toId` (one of its options): remembered for
-- the character and loaded in place of the finished guide, else of the open
-- option being changed, else in the active tab (Own.replaceTab: the guide
-- replaced goes to the closed tabs, a closed `toId` comes back at its view).
-- Fires ROUTE_CHOSEN.
function Engine.ChooseRoute(fromId, toId)
	local from, to = fromId and Guides.Get(fromId), toId and Guides.Get(toId)
	if not (from and to and from.nextChoices) then return false end
	local offered = false
	for _, id in ipairs(from.nextChoices) do
		if id == toId then offered = Own.optionHolds(from, id) end
	end
	if not offered then return false end
	routesTable()[fromId] = toId
	if not ns.IsLoggedIn() then return true end
	local index = tabIndexOf(toId)
	if index then
		Engine.SelectTab(index)
	else
		index = tabIndexOf(fromId)
		if not index then
			for _, id in ipairs(from.nextChoices) do
				index = tabIndexOf(id)
				if index then break end
			end
		end
		if not index and activeIndex == 0 then
			Engine.OpenTab(toId)
		else
			Own.replaceTab(index or activeIndex, toId, true)
			activeIndex = index or activeIndex
			useActive()
			persist()
			ns.Fire("GUIDE_CHANGED", toId)
			evaluate()
		end
	end
	ns.Fire("ROUTE_CHOSEN", fromId, toId)
	return true
end

-- The dungeons the player runs in leveling guides (`when dungeon`, the
-- Options' "Dungeons in leveling guides"): CharState().dungeons[map] = true,
-- by the instance's Map id; none by default, so the solo route is the
-- default. A change re-evaluates the guides at once; a step the route has
-- passed keeps its stored outcome (Own.latchWhen).
function Engine.DungeonChosen(map)
	return ns.CharState().dungeons[map] == true
end

function Engine.ChooseDungeon(map, on)
	if type(map) ~= "number" then return end
	ns.CharState().dungeons[map] = on and true or nil
	requestUpdate()
end

-- The dungeons the guides for this character have `when dungeon` steps for
-- (not negated): { [map] = true }. For the Options list, which offers only
-- these. A guide whose steps are not read yet is searched in its source
-- (the compiler writes `{ k = "dungeon", name = "...", map = N }`, a
-- negated one with `neg = true` after `k`), so nothing is loaded for it.
function Engine.GuideDungeons()
	if not player then refreshPlayer() end
	local out = {}
	for _, h in ipairs(Guides.List()) do
		local g = Guides.Get(h.id)
		local src = g and rawget(g, "steps") == nil and rawget(g, "stepsSrc")
		if g and Guides.GuideMatches(g, player) and type(src) == "string" then
			if src:find('k = "dungeon"', 1, true) then
				for map in src:gmatch('{ k = "dungeon", name = "[^"]*", map = (%d+)') do out[tonumber(map)] = true end
			end
		elseif g and Guides.GuideMatches(g, player) then
			for _, step in ipairs(g.steps) do
				for _, p in ipairs(step.when or NONE) do
					if p.k == "dungeon" and not p.neg and type(p.map) == "number" then out[p.map] = true end
				end
			end
		end
	end
	return out
end

-- The group quest the live step waits on (`when group`, unanswered): its
-- quest id and title (the step's goal for it, else the guide's accept, else
-- the step's title), or nil.
function Engine.GroupQuestion()
	local step = guide and computed and guide.steps[computed]
	local q = step and Own.groupPending(step)
	if not q then return nil end
	for _, goal in ipairs(step.goals) do
		if goal.quest == q and goal.title then return q, goal.title end
	end
	local a = layoutOf(guide).accepts[q]
	return q, (a and a[1].goal.title) or step.title
end

-- The group quests (`when group`) of the guides for this character (the
-- guide's faction, races and classes, the step's `only`): { { quest, title } },
-- each quest once, in guide and step order. For the Options list.
function Engine.GroupQuests()
	if not player then refreshPlayer() end
	local out, seen = {}, {}
	for _, h in ipairs(Guides.List()) do
		local g = Guides.Get(h.id)
		-- A race part's guide not read in lists them in its header.
		if g and Guides.GuideMatches(g, player) and rawget(g, "steps") == nil and type(rawget(g, "stepsSrc")) == "string" then
			for _, gq in ipairs(type(g.groupQuests) == "table" and g.groupQuests or NONE) do
				if type(gq) == "table" and type(gq.quest) == "number" and not seen[gq.quest] then
					seen[gq.quest] = true
					out[#out + 1] = { quest = gq.quest, title = gq.title }
				end
			end
		elseif g and Guides.GuideMatches(g, player) then
			for _, step in ipairs(g.steps) do
				for _, p in ipairs(Guides.Matches(step.only, player) and step.when or NONE) do
					if p.k == "group" and not seen[p.q] then
						seen[p.q] = true
						local title
						for _, goal in ipairs(step.goals) do
							if goal.quest == p.q and goal.title then title = goal.title break end
						end
						out[#out + 1] = { quest = p.q, title = title or step.title }
					end
				end
			end
		end
	end
	return out
end

-- The player's answer for group quest q: "do", "skip", or nil to ask again.
-- Per character, for every guide (CharState().groupQuests); a quest not
-- answered takes behavior.groupQuests ("do", "skip"; "ask": nil).
function Engine.GroupAnswer(q) return Own.groupAnswer(q) end

function Engine.AnswerGroup(q, answer)
	if type(q) ~= "number" or (answer ~= nil and answer ~= "do" and answer ~= "skip") then return end
	ns.CharState().groupQuests[q] = answer
	requestUpdate()
end

-- The quest the active guide holds for the player's answer (it left the log
-- after the route had passed its accept, Own.holdLost): its id and title, the
-- lowest id first, or nil.
function Engine.LostQuestion()
	local all = guide and ns.CharState().lostQuests
	local mine = all and all[guide.id]
	if not mine then return nil end
	local q
	for id in pairs(mine) do
		if not q or id < q then q = id end
	end
	local a = layoutOf(guide).accepts[q]
	return q, a and questTitle(a[1].goal) or nil
end

-- The answer for a held quest: "back" lets the route go back to its giver,
-- "skip" skips it and the quests that follow from it (Engine.SkipQuest).
function Engine.AnswerLost(q, answer)
	local all = ns.CharState().lostQuests
	if type(q) ~= "number" or not all or (answer ~= "back" and answer ~= "skip") then return end
	Own.removed[q] = nil
	for id, mine in pairs(all) do
		mine[q] = nil
		if not next(mine) then all[id] = nil end
	end
	if not next(all) then ns.CharState().lostQuests = nil end
	if answer == "skip" then
		Engine.SkipQuest(q, true)
	else
		placing = nil
		evaluate()
	end
end

-- The active tab's finished guide when its route choice waits for the
-- player, else nil.
function Engine.PendingRouteChoice()
	if not (guide and guide.nextChoices) or computed ~= nil or current ~= nil then return nil end
	if not player then refreshPlayer() end
	local _, asks = routeNext(guide)
	return asks and guide.id or nil
end

-- Whether `fromId`'s `next` offers `toId` now: one of its guides, and its
-- `when`, if any, holds (Own.optionHolds). Guides.OfferedBy and the guide
-- menu ask this.
function Engine.RouteOffered(fromId, toId)
	local from = fromId and Guides.Get(fromId)
	if not (from and toId) then return false end
	local listed = from.next == toId
	for _, id in ipairs(from.nextChoices or NONE) do
		if id == toId then listed = true end
	end
	return listed and Own.optionHolds(from, toId)
end

-- Whether the player reached the end of leveling guide `id` (Own.noteEnd;
-- per character): the guide window then offers the next guide.
function Engine.GuideEnded(id)
	return id ~= nil and ns.CharState().guideEnds[id] == true
end

-- Start the guide that follows `fromId` now (Engine.NextGuide) in fromId's
-- tab, as the hand-off does by itself (the catch-up may pass it whole and go
-- on), and make that tab the active one; a next guide already open in a tab
-- is selected instead, and with fromId in no tab it opens in a new one. The
-- guide-end window's Start and the guide window's banner. False with no next
-- guide, or a route choice to make first (Engine.GetRouteChoice).
function Engine.StartNext(fromId)
	local nextId = Engine.NextGuide(fromId)
	if not (nextId and Guides.Get(nextId) and ns.IsLoggedIn()) then return false end
	local open = tabIndexOf(nextId)
	if open then
		Engine.SelectTab(open)
		return true
	end
	local index = tabIndexOf(fromId)
	if not index then return Engine.OpenTab(nextId, true, true) ~= nil end
	use(tabs[index])
	Own.opened[fromId] = nil
	completedFired[nextId] = nil
	resetLoaded(nextId, true)
	activeIndex = index
	useActive()
	persist()
	ns.Fire("GUIDE_CHANGED", nextId)
	evaluate()
	return true
end

-- The guide Polestar goes on with after `fromId` now (as at its hand-off),
-- or nil: none is offered, or the player has to choose first.
function Engine.NextGuide(fromId)
	local from = fromId and Guides.Get(fromId)
	if not from then return nil end
	if not player then refreshPlayer() end
	local id, asks = routeNext(from)
	if asks then return nil end
	return id
end

-- The choice that offers guide `id` to this character (to change route), or nil.
function Engine.RouteChoiceFor(id)
	local from = id and choiceOffering(id)
	return from and from.id or nil
end

-- `/polestar path`: the waiting choice of the active tab, else the choice that
-- offered the active guide. Fires ROUTE_CHOICE; returns the from-guide id or nil.
function Engine.OfferRouteChoice()
	local fromId = Engine.PendingRouteChoice() or (guide and Engine.RouteChoiceFor(guide.id))
	if fromId then ns.Fire("ROUTE_CHOICE", fromId) end
	return fromId
end

function Engine.GetStepIndex() return current end

function Engine.GetStepCount() return guide and #guide.steps or 0 end

-- A step whose only goals for this character are `hearth` (0.3.3, Fitz):
-- hearthing is no step of its own. The arrow's route to the next step's work
-- takes the Hearthstone when it clearly pays (Nav/Travel.lua, HEARTH_MARGIN
-- and HEARTH_MIN_TRIP), wherever it is bound. `sethome` stays a step.
-- `who`: another character's class, race and faction (Engine.StepHiddenFor),
-- the player's by default.
function Own.hearthOnly(step, who)
	who = who or player
	local any = false
	for _, goal in ipairs(step.goals) do
		if Guides.Matches(goal.only, who) then
			if goal.t ~= "hearth" then return false end
			any = true
		end
	end
	return any
end

---------------------------------------------------------------------------
-- Flights the travel route takes better (#1191, #1212). A travel step holds,
-- for the character, nothing open but gotos and a `fly` (a flight step: the
-- walk to a flight master and the flight) or gotos alone (a walk): it is a
-- way to the work after it, not work of its own. With the travel planner on
-- and leading on Polestar's own arrow (nav.travel and nav.arrow on, neither
-- TomTom's arrow nor a hand-off to another addon; Own.plannerFlies):
--   * a flight step's arrow leads to the flight's end, a node the character
--     knows, so the route flies there from whichever flight master reaches
--     it soonest, in one flight, instead of walking or flying to the flight
--     master the guide names first (Own.flyAim);
--   * a travel step passes when the next open step after it, past walks on
--     the same continent, is another flight step: the stop in between holds
--     nothing left to do for this character (its work done, skipped, given
--     up or for other characters), so the route flies on directly
--     (Own.flightOn);
--   * a flight step whose next open step is work passes, with the walks
--     between, when the planner gets to that work at least FLY_MARGIN
--     sooner without landing at the flight's end first: a nearer flight
--     master the character knows (Thunder Bluff for the Earthen Ring, not
--     Camp Taurajo), or a stop whose own work is behind the player. Judged
--     once when the route reaches the step (Own.flightJudged), until the
--     character learns a flight path.
--   * a walk passes when the stop it leads to holds nothing for this
--     character: their steps there up to their next travel step all done
--     or not applying now, whatever comes after (#1596, Own.stopEmpty).
-- A flight step whose landing the character has no flight path to yet (a
-- guide loaded mid-level that flies where they have never been) leads, with
-- the planner on, to the landing as travel: its arrow and its goal read "Go
-- to", the route walks, sails or takes the flights the character knows, and
-- the goal is done on arriving there or once that flight path is learned
-- (Own.unknownLanding, Own.landingReached).
-- With the planner off the guide's steps hold as written.
---------------------------------------------------------------------------

Own.FLY_MARGIN, Own.FLY_SHARE = 60, 0.1 -- seconds, and share of the trip via the flight's end
Own.flyVerdicts = setmetatable({}, { __mode = "k" }) -- guide -> { [step] = { passed, known } }

-- The travel route leads, on Polestar's own arrow: the route's legs ("Walk to
-- the flight master", "Fly to ...") show only there. TomTom's arrow and the
-- hand-off to Shortest Path Forever get the target alone.
function Own.plannerFlies()
	local nav = ns.Nav
	if not (nav and nav.GetKnownTaxiNodes and nav.GetTaxiNode and ns.Get("nav.travel") and ns.Get("nav.arrow") ~= false) then return false end
	if nav.UsingTomTomArrow and nav.UsingTomTomArrow() then return false end
	return not (nav.HandedOff and nav.HandedOff())
end

-- "fly", "walk" or nil: step s's open goals for the character are travel
-- only, with a flight among them ("fly") or gotos alone ("walk"); nil with
-- other work open, or nothing open.
function Own.transitKind(s)
	local kind
	for g, goal in ipairs(guide.steps[s].goals) do
		if blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not Own.goalSkipped(s, g) and not goalDone(s, g, goal) then
			local t = goal.t
			if t == "fly" then
				kind = "fly"
			elseif t == "goto" then
				kind = kind or "walk"
			else
				return nil
			end
		end
	end
	return kind
end

-- The flight step s's open `fly` goal and its index.
function Own.flyGoal(s)
	for g, goal in ipairs(guide.steps[s].goals) do
		if goal.t == "fly" and goalApplies(goal) and not goalDone(s, g, goal) then return goal, g end
	end
	return nil
end

-- The taxi node a `fly` goal lands at (Nav/Travel.lua's data), while the
-- character knows it; else nil.
function Own.knownLanding(goal)
	local nav = ns.Nav
	local node = goal and nav.GetTaxiNode(goal.node)
	return node and nav.GetKnownTaxiNodes()[goal.node] and node or nil
end

-- The landing node of a `fly` goal the character does not know, while the
-- planner leads (see above); else nil.
function Own.unknownLanding(goal)
	if not (goal and goal.t == "fly" and goal.node and Own.plannerFlies()) then return nil end
	local nav = ns.Nav
	if nav.GetKnownTaxiNodes()[goal.node] then return nil end
	local node = nav.GetTaxiNode(goal.node)
	return node and node.map and node.x and node.y and node or nil
end

-- `fly` goals the arrow led to as travel (Own.flyAim): learning their flight
-- path finishes them.
Own.ledAsTravel = setmetatable({}, { __mode = "k" })

-- A `fly` goal led as travel is done: arrived at its landing (a goto's
-- radius, Own.arriveStep) or its flight path learned since.
function Own.landingReached(goal)
	if arrived[goal] then return true end
	local nav = ns.Nav
	return Own.ledAsTravel[goal] == true and nav and nav.GetKnownTaxiNodes and nav.GetKnownTaxiNodes()[goal.node] and true or false
end

-- The continent travel step s starts on (its first open goal) or, with
-- `last`, ends on (its last: a flight's end, a walk's last goto).
function Own.transitContinent(s, last)
	local goals, c = guide.steps[s].goals, nil
	for g, goal in ipairs(goals) do
		if blocks(goal) and goalApplies(goal) and not goalDone(s, g, goal) then
			local here
			if goal.t == "fly" then
				local node = ns.Nav.GetTaxiNode(goal.node)
				here = node and node.c
			elseif goal.t == "goto" and goal.map and goal.x and goal.y then
				here = Compat().MapToWorld(goal.map, goal.x, goal.y, goal.f)
			end
			if here then
				if not last then return here end
				c = here
			end
		end
	end
	return c
end

-- The next open step after s past the walks on its continent, and its
-- transit kind (nil: work).
function Own.travelOnto(s)
	local steps = guide.steps
	local c = Own.transitContinent(s, true)
	for n = s + 1, #steps do
		local step = steps[n]
		if stepApplies(step) and not isSkipped(n) and not step.along then
			local kind = Own.transitKind(n)
			if kind == "fly" or (kind == "walk" and Own.transitContinent(n, false) ~= c) then return n, kind end
			if kind == "walk" then
				c = Own.transitContinent(n, true)
			elseif not stepDone(n) then
				return n, nil
			end
		end
	end
	return nil
end

-- Travel step s passes: another flight follows with nothing open between.
function Own.flightOn(s)
	local n, kind = Own.travelOnto(s)
	if kind ~= "fly" or Own.transitContinent(n, false) ~= Own.transitContinent(s, true) then return false end
	return Own.knownLanding((Own.flyGoal(n))) ~= nil
end

-- How many flight paths the character knows (a verdict holds until it changes).
function Own.knownCount()
	local n = 0
	for _ in pairs(ns.Nav.GetKnownTaxiNodes()) do n = n + 1 end
	return n
end

-- Step s's verdict, while it holds (see above), or nil.
function Own.flyVerdict(s)
	local v = Own.flyVerdicts[guide]
	v = v and v[s]
	return v and v.known == Own.knownCount() and v or nil
end

-- Whether travel step s passes (stepDone).
function Own.flightPassed(s)
	if not (guide and Own.plannerFlies() and Own.transitKind(s)) then return false end
	if Own.flightOn(s) then return true end
	local v = Own.flyVerdict(s)
	return v ~= nil and v.passed
end

-- Step `step`'s travel as written for the character, done or not: "fly" or
-- "walk" when every goal for them (notes aside) is a goto or a fly; else nil.
function Own.writtenTravel(step)
	local kind
	for _, goal in ipairs(step.goals) do
		local t = goal.t
		if t ~= "note" and Guides.Matches(goal.only, player) then
			if t == "fly" then
				kind = "fly"
			elseif t == "goto" then
				kind = kind or "walk"
			else
				return nil
			end
		end
	end
	return kind
end

-- Step n has optional work still to do for the character (a riding trainer,
-- a vendor): a stop made for it, which a walk there keeps.
function Own.optionalOpen(n)
	for g, goal in ipairs(guide.steps[n].goals) do
		if goal.optional and goal.t ~= "note" and goalApplies(goal) and not unavailableFor(goal)
			and not Own.goalSkipped(n, g) and not goalDone(n, g, goal) then
			return true
		end
	end
	return false
end

-- A walk to a stop that holds nothing for the character (#1596): walk step s
-- (or a run of walks) is followed by steps of their own written with work (a
-- hand-in, a flight path, training), and every one of them, up to their next
-- travel step, is done or does not apply now (a false `when`, a flight path
-- known, quests not in the log); optional work still open keeps the stop.
-- The walk passes and the route leads to that travel step or the work after
-- it (Camp Taurajo's Tear of the Moons, not Thunder Bluff's empty rise). Steps
-- for other classes and races, and notes alone, are no stop: a walk followed
-- only by those holds as written (it is the way on), as does a walk with no
-- travel step after its stop (the guide's end). With the planner leading
-- (Own.plannerFlies: the next leg may be a boat or a zeppelin), once the
-- quest log can be read (work would read done before).
function Own.stopEmpty(s)
	if not (logReady and guide and Own.plannerFlies()) then return false end
	local steps = guide.steps
	if Own.writtenTravel(steps[s]) ~= "walk" or Own.transitKind(s) ~= "walk" then return false end
	local stop = false
	for n = s + 1, #steps do
		local step = steps[n]
		if not (Own.hiddenStep(step) or isSkipped(n)) then
			local kind = Own.writtenTravel(step)
			if kind then
				if stepApplies(step) then
					if stop then return true end
					-- A walk right after: one run, judged by the stop after it. A
					-- flight right after is Own.flightOn's.
					if kind == "fly" then return false end
				end
			else
				local work = false
				for _, goal in ipairs(step.goals) do
					if goal.t ~= "note" and Guides.Matches(goal.only, player) then
						work = true
						break
					end
				end
				if work then
					if stepApplies(step) and (Own.groupPending(step) or not Own.goalsDone(n) or Own.optionalOpen(n)) then return false end
					stop = true
				end
			end
		end
	end
	return false
end

-- The route reached flight step s (computeCurrent): judge it once against
-- the planner (see above). True when it passes, with the walks after it.
function Own.flightJudged(s)
	-- Not before the quest log can be read (work would read done), nor on a taxi.
	if not logReady or Own.flyVerdict(s) or Compat().IsOnTaxi() or not Own.plannerFlies() or Own.transitKind(s) ~= "fly" then return false end
	local nav = ns.Nav
	local landing = Own.knownLanding((Own.flyGoal(s)))
	local n, kind = Own.travelOnto(s)
	if not (landing and n and kind == nil and nav.EstimateTravel) then return false end
	local to
	for g, goal in ipairs(guide.steps[n].goals) do
		if blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(n, g, goal) then
			local map, x, y, f = posOf(goal)
			if map and x and y then
				to = { map = map, x = x, y = y, f = f }
				break
			end
		end
	end
	if not to then return false end
	local direct = nav.EstimateTravel(nil, to)
	local there = nav.EstimateTravel(nil, landing)
	local on = nav.EstimateTravel(landing, to)
	if not (direct and there and on) then return false end
	local all = Own.flyVerdicts[guide] or {}
	Own.flyVerdicts[guide] = all
	local known = Own.knownCount()
	local via = there + on
	local passed = direct + math.max(Own.FLY_MARGIN, via * Own.FLY_SHARE) < via
	for k = s, passed and n - 1 or s do all[k] = { passed = passed, known = known } end
	return passed
end

-- Flight step s's flight the arrow leads to the end of (see above): its goal,
-- index and landing node; nil to lead as written.
function Own.flyAimed(s)
	if not (Own.plannerFlies() and Own.transitKind(s) == "fly") then return nil end
	local goal, g = Own.flyGoal(s)
	local node = Own.knownLanding(goal) or Own.unknownLanding(goal)
	if not (node and node.map and node.x and node.y) then return nil end
	return goal, g, node
end

-- The arrow's waypoint for flight step s (Own.flyAimed), or nil.
function Own.flyAim(s)
	local goal, g, node = Own.flyAimed(s)
	if not goal then return nil end
	local verb, subject, _, detail = describe(goal)
	if Own.unknownLanding(goal) then Own.ledAsTravel[goal] = true end
	return {
		map = node.map, x = node.x, y = node.y, f = node.f,
		label = goalText(goal, verb, subject, detail),
		stepIndex = s, goalIndex = g, kind = goal.t, r = DEFAULT_RADIUS,
	}
end

-- A step that is not a step of its own for this character (#942, Fitz): an
-- along step, whose goals read under "Along the way" of the steps the player
-- travels to (Engine.GetAlong); one whose `only` leaves out their class,
-- race or faction, or every goal's `only` does (a Druid's Dendrite
-- Starblaze for a Mage); a hearth-only step (Own.hearthOnly). Paging never
-- lands on it, it has no number and no progress share, the arrow never
-- leads to it, and nothing explains it. A step that depends on what the
-- player does (`when`) can apply later: it keeps its number and says why it
-- does not apply now (Own.stepWhy).
function Own.hiddenStep(step, who)
	who = who or player
	if step.along or not Guides.Matches(step.only, who) then return true end
	local goals = step.goals
	if #goals == 0 then return false end
	if Own.hearthOnly(step, who) then return true end
	for _, goal in ipairs(goals) do
		if Guides.Matches(goal.only, who) then return false end
	end
	return true
end

-- Whether `step` (of any guide) is no step of its own (Own.hiddenStep) for
-- `who` = { class, race, faction } (Party: a member's; nil: the player's).
function Engine.StepHiddenFor(step, who)
	if type(step) ~= "table" or type(step.goals) ~= "table" then return true end
	if not player then refreshPlayer() end
	return Own.hiddenStep(step, who) and true or false
end

-- The numbers the player sees for guide g's steps (Own.hiddenStep left out):
-- { of = { [step] = number }, hidden = { [step] = true }, total }. A hidden
-- step reads as the number of the next step shown. Per guide and character
-- (class, race and faction do not change in a session).
Own.numbering = setmetatable({}, { __mode = "k" })
function Own.numbersOf(g)
	if not player then refreshPlayer() end
	local key = tostring(player.class) .. "/" .. tostring(player.race) .. "/" .. tostring(player.faction)
	local n = Own.numbering[g]
	if n and n.key == key then return n end
	n = { key = key, of = {}, hidden = {}, total = 0 }
	for s, step in ipairs(g.steps) do
		if Own.hiddenStep(step) then
			n.hidden[s] = true
			n.of[s] = n.total + 1
		else
			n.total = n.total + 1
			n.of[s] = n.total
		end
	end
	Own.numbering[g] = n
	return n
end

-- Step i of guide g as the player counts it, and whether it is hidden from
-- them (Own.hiddenStep); the number of steps they see. The window, the bug
-- report, the tabs and every "step N" line use these.
function Engine.StepNumberOf(g, i)
	if type(g) ~= "table" or type(g.steps) ~= "table" or type(i) ~= "number" then return i, false end
	local n = Own.numbersOf(g)
	return n.of[i] or (n.total + 1), n.hidden[i] == true
end
function Engine.StepTotalOf(g)
	if type(g) ~= "table" or type(g.steps) ~= "table" then return 0 end
	return Own.numbersOf(g).total
end
function Engine.StepNumber(i) return Engine.StepNumberOf(guide, i) end
function Engine.StepTotal() return Engine.StepTotalOf(guide) end

-- Whether the player can look at step i of the loaded guide: it applies and
-- is not hidden from them (Next, Prev, Goto).
function Own.lookable(i)
	local step = guide.steps[i]
	return step ~= nil and stepApplies(step) and not Own.numbersOf(guide).hidden[i]
end

-- `when` predicate p in one line for the window (Own.stepWhy): what has to
-- hold for the step to apply. A kind with no wording of its own, a negated
-- level, an `onquest` of several quests: the generic line.
function Own.whenText(p)
	local k, neg = p and p.k, p and p.neg
	if k == "group" then
		return (neg and L["Only if you skip the group quest %s"] or L["Only if you do %s with a group"]):format(ns.Quoted(titleOfQuest(p.q)))
	elseif k == "level" and not neg then
		local n = tostring(p.n + (p.frac or 0))
		local fmt = (p.op == "<" and L["Only below level %s"]) or (p.op == "<=" and L["Only up to level %s"])
			or (p.op == ">" and L["Only above level %s"]) or L["Only from level %s"]
		return fmt:format(n)
	elseif k == "onquest" and type(p.q) == "table" and #p.q == 1 then
		return (neg and L["Only without %s in your quest log"] or L["Only with %s in your quest log"]):format(ns.Quoted(titleOfQuest(p.q[1])))
	elseif k == "turnedin" then
		return (neg and L["Only before %s is handed in"] or L["Only once %s is handed in"]):format(ns.Quoted(titleOfQuest(p.q)))
	end
	return L["Skipped for your character: its conditions do not hold"]
end

-- Why step `step` holds nothing for this character now (Engine.GetStepView
-- `why`), so a step looked at ahead does not read as an empty title: only a
-- step that depends on what the player does (`when`) says it. The first
-- `when` predicate that fails, or, when none of its goals applies (`goals`:
-- its goal views), the group quest it waits on not answered "do" (Elwynn's
-- Goldshire hand-in of Book Return), else that none applies. nil while a
-- goal applies, for a step hidden from the character (Own.hiddenStep), or
-- with no goals or no `when`.
function Own.stepWhy(step, goals)
	if #goals == 0 or not step.when or Own.hiddenStep(step) then return nil end
	if not Own.whenHolds(step) then
		local p = Own.whenFails(step)
		return p and Own.whenText(p) or nil
	end
	for _, gv in ipairs(goals) do
		if gv.status ~= "na" then return nil end
	end
	for _, p in ipairs(step.when) do
		if p.k == "group" and not p.neg and Own.groupAnswer(p.q) ~= "do" then return Own.whenText(p) end
	end
	return L["Skipped for your character: none of its goals apply"]
end

function Engine.GetStepView(i)
	if not guide or type(i) ~= "number" then return nil end
	local step = guide.steps[i]
	if not step then return nil end
	if not player then refreshPlayer() end
	local status = stepStatusOf(i)
	local groups, focus, groupOf = stepGroups(i)
	local goals = {}
	for g, goal in ipairs(step.goals) do
		goals[g] = goalView(i, g, goal, status, groupOf[g])
		goals[g].pinOpen = Own.pinOpen(i, goal) or nil
	end
	-- A quest that starts from an item reads as one line, the accept, with how
	-- to get the item under it (`starter`). Until the item is in the bags the
	-- collect's row stands for both (`starterOf` = the accept's index: the
	-- window words it as the accept; its waypoint, spots and index stay the
	-- collect's). After that, or once the quest is taken or out of reach, the
	-- accept's own row ("in your bags, right-click it"). The other goal is
	-- `folded`: not a row of its own. Statuses and verbs stay as they are.
	for a, av in ipairs(goals) do
		local ag = step.goals[a]
		if ag.t == "accept" and ag.item and not ag.npc and not ag.object and av.status ~= "na" then
			for c = a - 1, 1, -1 do
				local cg = step.goals[c]
				if cg.t == "collect" and cg.item == ag.item and not cg.quest then
					local cv = goals[c]
					if cv.status ~= "na" and groupOf[c] == groupOf[a] then
						local starter = { item = ns.Names.Item(ag.item) or ag.itemName or cg.itemName, source = cv.source, note = cv.note }
						local open = av.status ~= "done" and av.status ~= "skipped"
						if open and cv.status ~= "done" and cv.status ~= "skipped" then
							av.folded = true
							cv.starter, cv.starterOf = starter, a
						else
							cv.folded = true
							starter.held = (open and cv.status == "done") or nil
							av.starter = starter
						end
					end
					break
				end
			end
		end
	end
	-- A "Go to" naming the step's own place repeats a field group's header.
	for g, gv in ipairs(goals) do
		local grp = groups[groupOf[g]]
		if gv.t == "goto" and step.title and step.goals[g].text == step.title and grp and grp.kind == "here" then
			gv.header = true
		end
	end
	local outGroups = {}
	for k, grp in ipairs(groups) do
		outGroups[k] = {
			kind = grp.kind,
			npc = grp.kind == "npc" and grp.id or nil,
			object = grp.kind == "object" and grp.id or nil,
			name = grp.name,
			map = grp.map, x = grp.x, y = grp.y, f = grp.f, z = grp.z,
			goals = grp.goals, done = grp.done, pending = grp.pending,
		}
	end
	-- `current`: the goal the window marks and the arrow leads to (the
	-- current step only); `skipped`: the player skipped this step (Unskip);
	-- `image`: the step's picture ({ file, w, h, texture }, Guides.lua);
	-- `why`: why the step holds nothing for this character now, one line
	-- (Own.stepWhy).
	return {
		index = i, title = step.title, note = step.note, image = step.image, status = status, goals = goals,
		groups = outGroups, focus = focus,
		current = status == "current" and (Own.currentGoal(i, groups, focus)) or nil,
		skipped = isSkipped(i), live = computed,
		along = step.along, label = step.label,
		why = Own.stepWhy(step, goals),
	}
end

-- The open goals of the along steps behind the live step (Own.alongListed),
-- in step order, then those of the quests the player pinned (Own.pinGoals):
-- { { index = step, title, untilStep, goals = { goal view, ... } }, ... };
-- `untilStep`: an `along until` step's labelled step (the window's "Along
-- the way, until step N"); a pinned quest's entry has `pin` (the quest) and
-- no index, each goal view its `step` (Engine.AimAlong, Engine.AlongGoal).
-- Notes are left out; a step or quest with nothing open is not listed.
function Engine.GetAlong()
	local out = {}
	if not guide then return out end
	if not player then refreshPlayer() end
	for _, s in ipairs(Own.marksOf().along) do
		local listed = Own.alongListed(s)
		if listed then
			local step, goals = guide.steps[s], {}
			for g, goal in ipairs(step.goals) do
				if goal.t ~= "note" and (listed ~= "held" or Own.alongHeld(goal)) then
					local view = goalView(s, g, goal, "current", nil)
					if view.status == "active" then
						view.step = s
						goals[#goals + 1] = view
					end
				end
			end
			if #goals > 0 then
				local untilStep = type(step.along) == "string" and Own.marksOf().labels[step.along] or nil
				out[#out + 1] = { index = s, title = step.title, untilStep = untilStep, goals = goals }
			end
		end
	end
	for _, q in ipairs(Own.pinList()) do
		local goals = {}
		for _, e in ipairs(Own.pinGoals(q)) do
			local view = goalView(e[1], e[2], e[3], "current", nil)
			if view.status == "active" then
				view.step, view.pinned = e[1], q
				goals[#goals + 1] = view
			end
		end
		if #goals > 0 then out[#out + 1] = { pin = q, title = titleOfQuest(q), goals = goals } end
	end
	return out
end

---------------------------------------------------------------------------
-- While you're here: while the player works the live step, an open
-- objective of a later step whose quest is already in the log, close by,
-- becomes a line under the step, up to HERE_SHOW at once
-- (Engine.GetWhileHereList; Engine.GetWhileHere the first): "While you're here:
-- Kill Kobold Vermin, 2 more  (step 14)  45 yd". Grabbing it now saves coming
-- back: the later step then reads done (or shorter) when the route gets
-- there, as any objective done early does. It never takes the arrow unless
-- the player clicks it (Engine.AimWhileHere).
--
-- Candidates (Own.hereBuild, on a step, quest-log, level, zone or setting
-- change): open kill, collect, interact and use goals with a place on the
-- player's map, in every step of the guide after the live step (a later
-- trip away and back, a flight, a hearth or an instance in between change
-- nothing: the player is here now), each
--   * for a quest in the log and not ready to hand in; never an accept;
--   * for the character (stepApplies: its `when` and level gates;
--     goalApplies), its step and goal not skipped, the quest not left out;
--   * not shown already: the Along the way list has no open goal for the
--     same objective (Own.hereShown: listed along steps, background goals
--     among them; a later along step is not listed yet and counts like any
--     step), the quest is not pinned, and the live step has no open goal
--     for the same objective (Own.nearestField has those);
--   * with mobs at most HERE_ABOVE levels over the player (a spot's `lvl`,
--     else the goal's), measured to such places only;
--   * any size: whatever is left (15 quilboars as much as 2), the player is there
--     already.
-- The goals with a place are indexed by map once per guide (Own.hereGoalsOn),
-- so a build looks only at this map's. The poll measures at most HERE_MAX of
-- them: all when that many fit, else the HERE_MAX nearest the player, picked
-- again each HERE_REPICK yards they move (Own.herePick).
-- With behavior.whileHereTurnins, also a later step's turn-in of a quest
-- ready to hand in: "hand in X to Y". A hand-in costs a short walk to one
-- NPC and a click, so it is measured by its detour, not its distance: the
-- seconds of extra walking to visit the NPC and go on to where the arrow
-- leads (Own.hereDetour), at most behavior.whileHereTurninSeconds (twice
-- that, HERE_XP, when waiting for the guide's hand-in costs XP:
-- Own.hereXpLoss), or any detour for an NPC within HERE_TOWN yards while the
-- player rests in a town; never past HERE_FAR yards, never on another floor
-- or a long way round (Own.hereMayShow). One the route reaches anyway in
-- its next HERE_SOON steps, without leading away first, is left to it
-- (Own.hereSoon), unless the player stands at its NPC: within HERE_AT
-- yards a hand-in shows whatever its step (0.3.5's reach, which 0.3.6
-- must never fall short of: Fitz walked past Seer Graytongue with the
-- guide's hand-in one step on, after a trip 530 yd north to Grull).
--
-- The line (Own.hereTick, on the arrival poll every ARRIVAL_POLL seconds,
-- allocation-free), measured from the player wherever the live step leads:
-- of the candidates within behavior.whileHereRadius yards of the centre of
-- any place their target spawns, the point the arrow leads to (the guide's spots and the alternatives
-- alike: Fitz stood among Zhevra Runners in an alternative spot's camp), or
-- with one of their mobs in sight (a nameplate, the target, the mouseover:
-- HERE_SEEN yards, whatever the spawn data says; a hand-in by its detour,
-- above), the one whose target spawns in the fewest places on the map
-- (`places`: a pool's mushrooms before zhevra found all over the zone, which
-- can wait for another spot), then the nearest, ranks first; while fewer
-- than HERE_SHOW show, the best in reach join in that order, each checked once against the
-- walk there (Nav.EstimateTravel, budgeted: a walk over HERE_WALK times the
-- straight line is a cliff or a cave floor; not for a mob in sight). It goes
-- past HERE_CLEAR times that radius (at most HERE_CLEAR_MAX yards), once
-- done, after HERE_SECONDS out of reach (in reach, a spawn area near or one
-- of its mobs in sight, it never expires), or on a
-- dismiss (Engine.DismissWhileHere(i)). Each line by itself; during a fight none
-- appears and none goes by distance or time. A dismissed line stays away
-- (Own.hereMuted: 2 minutes, and until the player has been HERE_DISMISS_AWAY
-- yards from where they dismissed it; then back in reach anywhere); dismissed twice in a zone
-- stay, for the rest of it (Own.hereQuiet). An expired one comes again
-- once in reach, HERE_AGAIN s on at the earliest (Own.hereAgain).
-- Never in an
-- instance, on a taxi, boat or zeppelin, while a Hearthstone is cast, or
-- while the live step's escort runs; while a timed quest's clock runs, only
-- that quest's lines, first (Own.herePark). Messages:
-- WHILE_HERE_CHANGED when a line appears, its count changes or it goes;
-- WHILE_HERE_MOVED(yards, i) when line i's distance moves to the next HERE_STEP.
---------------------------------------------------------------------------

Own.HERE_MAX = 10 -- candidates the poll measures (the nearest, when more fit)
Own.HERE_SHOW = 3 -- lines shown at once
Own.HERE_TAKES = 2 -- pick-ups among them (a hub's later quests never fill the list)
Own.HERE_ORDER = 30 -- yards a shown line must be nearer to move up past another
Own.HERE_REPICK = 25 -- yards moved before the nearest are picked again
Own.HERE_ABOVE = 2 -- levels a candidate's mobs may be above the player
-- A hand-in (Own.hereDetour): in reach while its detour is at most the
-- player's seconds (behavior.whileHereTurninSeconds), or its NPC is within
-- HERE_TOWN yards while the player rests in a town (an inn's or a city's
-- rest area: the same town); never past HERE_FAR yards, however little the
-- detour (an NPC straight ahead on the way is "here" no longer). Within
-- HERE_AT yards it shows (and stays) whatever its detour or step, while the
-- setting allows any hand-in out of town or the player rests in one.
Own.HERE_TOWN = 100
Own.HERE_FAR = 250
Own.HERE_AT = 30 -- yards: at the NPC, a hand-in shows whatever else (0.3.5's reach)
Own.HERE_SOON = 2 -- the route's next steps: a hand-in there, or anything at its NPC, waits for them (Own.hereSoon)
Own.HERE_XP = 2 -- a hand-in's seconds times this when the guide's hand-in comes at a level that cuts its XP
Own.HERE_SLACK = 10 -- seconds: a shown hand-in goes once its detour is past HERE_CLEAR times its seconds and this
Own.HERE_RECHECK = 15 -- seconds before a hand-in the walk check turned away is checked again (or HERE_REPICK yards moved)
Own.HERE_FLOOR = 8 -- yards of height between the player and an NPC that make another floor (Nav's FLOOR_GAP)
Own.HERE_WINDING = 1.25 -- a walk over a straight line (Nav's WALK_DETOUR: straight lines are not walkable)
Own.HERE_CLEAR = 100 / 60 -- it goes past this times the radius it came at
Own.HERE_SEEN = 30 -- yards a mob of it seen around the player counts as (nameplate range)
Own.HERE_MOUSE = 5 -- seconds a mouseover counts as seen
Own.herePlates, Own.hereSeen = {}, {} -- nameplate unit -> npc id; npc id -> nameplates showing it
Own.HERE_AGAIN = 60 -- seconds before an expired line may come again
-- An expired line's time, per goal (Own.hereAgain).
Own.hereExpiredAt = setmetatable({}, { __mode = "k" })
Own.HERE_MUTE = 120 -- seconds a dismissed line stays away at the least
Own.HERE_DISMISS_AWAY = 100 -- yards from the dismiss spot the player must have been before it comes again
-- Dismissed (Own.hereDismiss), per goal, this zone stay: how many times
-- (two: quiet for the stay), and the first time's mute { at, c, x, y, far }
-- (when, where the player stood, whether they have been HERE_DISMISS_AWAY
-- yards from there since).
Own.hereStrikes = setmetatable({}, { __mode = "k" })
Own.hereMutes = setmetatable({}, { __mode = "k" })

-- The player's "not now" for line e: muted near where it was dismissed
-- (Own.hereMuted); dismissed a second time in the zone stay, quiet for the
-- rest of it (Own.hereQuiet).
function Own.hereDismiss(e)
	local g = e.goal
	local n = (Own.hereStrikes[g] or 0) + 1
	Own.hereStrikes[g], Own.herePickC = n, nil
	if n >= 2 then
		Own.hereQuiet[g], Own.hereMutes[g] = true, nil
		return
	end
	local c, x, y = Compat().GetPlayerWorldPosition()
	Own.hereMutes[g] = { at = GetTime(), c = c, x = x or 0, y = y or 0, far = false }
end

-- Whether candidate e is muted: dismissed once, until HERE_MUTE s have
-- passed and the player has been HERE_DISMISS_AWAY yards from where they
-- stood when dismissing it (m.far, the poll's). Then it comes again in
-- reach anywhere, the same spawn area too (Fitz: the spores grow at one
-- pool). Allocation-free.
function Own.hereMuted(e)
	local m = Own.hereMutes[e.goal]
	return m ~= nil and (GetTime() - m.at < Own.HERE_MUTE or not m.far)
end
Own.HERE_CLEAR_MAX = 600 -- yards: and never further out than this
Own.HERE_SECONDS = 180 -- a line out of reach (yet not past its clear distance) this long goes
Own.HERE_STEP = 5 -- yards the shown distance moves by
Own.HERE_WALK, Own.HERE_SPEED = 1.6, 7 -- walk / straight line; run speed (yd/s)
Own.HERE_VERBS = { kill = true, collect = true, interact = true, use = true }
Own.HERE_HEARTH = { [8690] = true, [556] = true } -- Hearthstone, Astral Recall
Own.hereAll, Own.hereAllN = {}, 0 -- every candidate, in route order
Own.hereList, Own.hereN, Own.hereDirty = {}, 0, true -- the ones the poll measures
Own.hereOn, Own.hereOnN = {}, 0 -- the lines shown, nearest first (stable: HERE_ORDER; reused)
Own.herePicked = {} -- the nearest HERE_MAX, when more fit (reused)
Own.hereQuiet = setmetatable({}, { __mode = "k" }) -- goal -> true: dismissed (or no walk there), this zone stay
Own.hereTo = {} -- the walk check's destination (reused)
Own.hereSoonAt, Own.hereSoonTo = {}, 0 -- the route's next HERE_SOON steps' NPCs (objects negated) and last step (reused)
Own.hereIndex = setmetatable({}, { __mode = "k" }) -- guide -> { at, unplaced, by = { [continent] = { s, g, s, g, ... } } }
Own.HERE_INDEX_RETRY = 10 -- seconds before an index with goals of maps not known yet is built again

-- The loaded guide's goals that may be candidates on continent `c` (a
-- quest, a place, work, a hand-in or an accept), as a flat { s, g, s, g, ... }
-- in route order, or nil. Indexed once per guide by world position, so a
-- goal on the next zone's map (a border, a city inside its zone) is as near
-- as the arrow measures it: no zone of the guide stops While you're here.
function Own.hereGoalsOn(c)
	local idx = Own.hereIndex[guide]
	if not idx or (idx.unplaced and GetTime() - idx.at >= Own.HERE_INDEX_RETRY) then
		idx = { at = GetTime(), unplaced = false, by = {} }
		local verbs = Own.HERE_VERBS
		for s, step in ipairs(guide.steps) do
			for g, goal in ipairs(step.goals) do
				if goal.map and goal.quest and goal.x and goal.y and not goal.candidates and (verbs[goal.t] or goal.t == "turnin" or goal.t == "accept") then
					local gc = goalWorld(goal)
					if gc then
						local list = idx.by[gc]
						if not list then
							list = {}
							idx.by[gc] = list
						end
						list[#list + 1] = s
						list[#list + 1] = g
					else
						-- Its map's frame is not known yet: built again a little later.
						idx.unplaced = true
					end
				end
			end
		end
		Own.hereIndex[guide] = idx
	end
	return idx.by[c]
end

-- The objectives the Along the way list shows now (listed along steps' open
-- work, Own.alongHeld): { [quest] = true (all of it: a goal with no
-- objective) or { [oi] = true } }.
function Own.hereShown()
	local shown = {}
	local steps = guide.steps
	for _, s in ipairs(Own.marksOf().along) do
		if Own.alongListed(s) then
			for _, goal in ipairs(steps[s].goals) do
				local q = goal.quest
				if q and shown[q] ~= true and Own.alongHeld(goal) then
					if goal.oi == nil then
						shown[q] = true
					else
						local t = shown[q] or {}
						t[goal.oi] = true
						shown[q] = t
					end
				end
			end
		end
	end
	return shown
end

-- The creatures a kill or collect goal needs (its npc, the drop source it
-- names, and with the quest database loaded every creature that drops its
-- item), or false.
function Own.hereNpcsOf(goal)
	local t = goal.t
	if t ~= "kill" and t ~= "collect" then return false end
	local ids = {}
	local function add(id)
		if type(id) == "number" then ids[#ids + 1] = id end
	end
	if type(goal.npc) == "table" then
		for _, id in ipairs(goal.npc) do add(id) end
	else
		add(goal.npc)
	end
	if t == "collect" then
		if goal.fromKind == "npc" then add(goal.fromId) end
		local QD = ns.QuestDB
		local r = goal.item and QD and QD.IsLoaded and QD.IsLoaded() and QD.ItemRecord and QD.ItemRecord(goal.item)
		if type(r) == "table" then
			for k = 1, (r[2] or 0) do add(r[1 + 2 * k]) end
		end
	end
	return #ids > 0 and ids or false
end

-- Whether a mob with npc id `npc` is around the player now: a nameplate, the
-- target or (for HERE_MOUSE seconds) the mouseover. Allocation-free.
function Own.hereSaw(npc)
	local n = Own.hereSeen[npc]
	if n and n > 0 then return true end
	if npc == Own.hereTarget then return true end
	return npc == Own.hereMouse and GetTime() - (Own.hereMouseAt or 0) <= Own.HERE_MOUSE
end

-- Living units only: a corpse's plate or target is no mob to get.
function Own.hereUnitNpc(unit)
	if UnitIsDead and UnitIsDead(unit) then return nil end
	return Compat().GetNpcID(unit)
end
-- Whether candidate e may show: any but an expired one, which comes again
-- once in reach (a spawn area, or one of its mobs in sight), HERE_AGAIN s on
-- at the earliest. Allocation-free.
function Own.hereAgain(e)
	local at = Own.hereExpiredAt[e.goal]
	return not at or GetTime() - at >= Own.HERE_AGAIN
end

ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", function(_, unit)
	if type(unit) ~= "string" then return end
	local npc = Own.hereUnitNpc(unit)
	local old = Own.herePlates[unit]
	if npc ~= old then
		if old then Own.hereSeen[old] = math.max(0, (Own.hereSeen[old] or 1) - 1) end
		Own.herePlates[unit] = npc
		if npc then Own.hereSeen[npc] = (Own.hereSeen[npc] or 0) + 1 end
		Own.herePickC = nil
	end
end)
ns.RegisterEvent("NAME_PLATE_UNIT_REMOVED", function(_, unit)
	local npc = Own.herePlates[unit]
	if npc then
		Own.herePlates[unit] = nil
		Own.hereSeen[npc] = math.max(0, (Own.hereSeen[npc] or 1) - 1)
	end
end)
ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() Own.hereTarget, Own.herePickC = Own.hereUnitNpc("target"), nil end)
ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function()
	Own.hereMouse, Own.hereMouseAt, Own.herePickC = Own.hereUnitNpc("mouseover"), GetTime(), nil
end)

-- Whether any of a goal's places has mobs at most `top` levels (one with no
-- level counts).
function Own.hereLevelOk(goal, top)
	local lvl = goal.lvl
	if goal.spots then
		for _, s in ipairs(goal.spots) do
			local l = s.lvl or lvl
			if not (l and l > top) then return true end
		end
		return false
	end
	return not (lvl and lvl > top)
end

-- Whether the route reaches turn-in goal `goal` of step s anyway in its next
-- HERE_SOON steps after the live one (for the character, not skipped): s is
-- one of them, or one has an open goal at the same NPC or object, and
-- neither the live step nor a step before that one leads away first (an
-- open goal with a place on another continent or past HERE_FAR yards from
-- the NPC: the guide's trip to Grull and back past Seer Graytongue). Then
-- the guide sends the player there in a moment; a line would say it twice.
function Own.hereSoon(s, goal, live)
	local steps, k = guide.steps, 0
	local npc, obj = goal.npc, goal.object
	local nc, nx, ny = goalWorld(goal)
	if not nc or Own.hereAway(live, nc, nx, ny) then return false end
	for i = live + 1, #steps do
		local step = steps[i]
		if stepApplies(step) and not isSkipped(i) then
			if i == s then return true end
			for j, other in ipairs(step.goals) do
				if ((npc and other.npc == npc) or (obj and other.object == obj)) and goalApplies(other) and not goalDone(i, j, other) then return true end
			end
			k = k + 1
			if k >= Own.HERE_SOON or Own.hereAway(i, nc, nx, ny) then return false end
		end
	end
	return false
end

-- Own.hereSoon during a build, asked only where it can hold: step s within
-- the route's next HERE_SOON steps or its NPC (object) at an open goal of
-- them (Own.hereSoonTo, Own.hereSoonAt, set by Own.hereBuild); every other
-- hand-in or pick-up, false without the walk over the steps.
function Own.hereSoonOf(s, goal, live)
	local at = Own.hereSoonAt
	if s <= Own.hereSoonTo or (goal.npc and at[goal.npc]) or (goal.object and at[-goal.object]) then return Own.hereSoon(s, goal, live) end
	return false
end

-- Whether step i leads away from world point c, x, y: an open goal of it
-- with a place on another continent or past HERE_FAR yards from there.
function Own.hereAway(i, c, x, y)
	local far = Own.HERE_FAR * Own.HERE_FAR
	for j, other in ipairs(guide.steps[i].goals) do
		if other.map and other.x and other.y and goalApplies(other) and not goalDone(i, j, other) then
			local oc, ox, oy = goalWorld(other)
			if oc and (oc ~= c or (ox - x) ^ 2 + (oy - y) ^ 2 > far) then return true end
		end
	end
	return false
end

---------------------------------------------------------------------------
-- Accepts ahead (Fitz, 0.3.6: "I'm here and you'd expect it to send me
-- backwards to grab the dynamic quest behind"). Talking to an NPC whose
-- accept the loaded guide takes in any later step, auto-accept takes it now
-- (Engine.WantsQuest, Own.aheadWants), and walking near one While you're
-- here shows it as a pick-up line ("Take X from Y", Own.hereFits): the
-- goal then reads done when the route gets there; the live step and the
-- arrow stay as they are. Only what the route would take anyway, for this
-- character, now (Own.aheadOk): the step and goal apply (`when`, level,
-- class and race gates, what a catch-up or an update left out), neither is
-- skipped, the accept is no `optional` or group/elite (`group`) one the
-- player has not chosen yet, its quest is not skipped, closed, below the
-- level it needs, more than HERE_ABOVE levels over the player (Fitz: no
-- quests far above) or dropped by a later `abandon`, and the log keeps
-- LOG_SPARE slots free (Compat.GetLogCap). A timed quest (`limit`, seconds)
-- is never a pick-up line nor taken for a step past the route's next AHEAD
-- (its clock would run on the way); in those, only when the route's walk
-- from this NPC to its hand-in fits LIMIT_SHARE of its time
-- (Own.aheadLimitOk). Only the loaded guide's steps, never another tab's or
-- the next guide's.
--
-- A While-you're-here hand-in whose NPC the route comes back to after
-- leading away (Own.hereVisit) is the whole visit when every open goal of
-- that later step is a hand-in ready now or such an accept there: one line
-- "Hand in X to Y, then take A, B: saves a trip back", its detour credited
-- with the trip back it saves (`visit.credit`, seconds: the route's walk
-- there and on, less the walk that skips it; Seer Graytongue between
-- Grull's tent and the Ritual Fire: 93 s).
---------------------------------------------------------------------------

Own.AHEAD = 5 -- the route's next steps: their lines rank first ("near"), a timed accept, a hand-in's whole visit
Own.LOG_SPARE = 2 -- quest log slots an accept ahead leaves free
Own.LIMIT_SHARE = 0.6 -- a timed quest taken ahead: the walk on to its hand-in within this share of its time
Own.GOAL_SECONDS = 10 -- seconds each open goal on that walk costs besides the walking (a talk, a click)

-- Quests the log may still take, keeping LOG_SPARE free.
function Own.logRoom()
	local C = Compat()
	-- Compat.GetLogCap: Forever's client answers 0 to GetMaxNumQuestsCanAccept
	-- (Fitz on 0.3.6: no accept ahead with 14 quests of 40 in the log).
	return C.GetLogCap() - Own.LOG_SPARE - #C.GetLogQuests()
end

Own.READY_NONE = {} -- Own.aheadOk's `ready` when nothing is handed in first: every prerequisite must be done

-- Whether the walk from world point c, x, y along the route to timed
-- accept a's hand-in fits Own.LIMIT_SHARE of its `limit`: the open goals
-- with a place of the steps from the live one on, in order, straight lines
-- HERE_WINDING longer at HERE_SPEED, GOAL_SECONDS each; goals at `npc`
-- (the visit's, done now) count for nothing. False when the route hands it
-- in nowhere, or a goal on the way is on another continent.
function Own.aheadLimitOk(a, npc, c, x, y)
	local steps, q = guide.steps, a.quest
	local yards, secs = 0, 0
	for i = computed, #steps do
		local step = steps[i]
		if stepApplies(step) and not isSkipped(i) then
			for j, other in ipairs(step.goals) do
				if goalApplies(other) and not (npc and other.npc == npc) and (other.quest == q or not goalDone(i, j, other)) and other.t ~= "note" then
					if other.map and other.x and other.y then
						local oc, ox, oy = goalWorld(other)
						if oc ~= c then return false end
						yards, x, y = yards + ((ox - x) ^ 2 + (oy - y) ^ 2) ^ 0.5, ox, oy
					end
					secs = secs + Own.GOAL_SECONDS
					if other.t == "turnin" and other.quest == q then
						return secs + yards * Own.HERE_WINDING / Own.HERE_SPEED <= a.limit * Own.LIMIT_SHARE
					end
				end
			end
		end
	end
	return false
end

-- Whether accept a, goal j of step i, may be taken now at its NPC (see
-- above), and when not, why (the debug log's words, Engine.AcceptRefusal).
-- `ready`: for a visit planned before its hand-ins, the quests it hands in
-- first (they count as done for a's prerequisites); nil at the NPC's window,
-- where the game offering it says they are met. `near`: step i is one of the
-- route's next AHEAD (a timed quest may be, Own.aheadLimitOk).
function Own.aheadOk(i, j, a, ready, near)
	local q = a.quest
	if not q then return false, "no quest" end
	if a.optional then return false, "optional" end
	if Own.goalSkipped(i, j) then return false, "goal skipped" end
	if not goalApplies(a) then return false, "goal not for this character" end
	if Own.groupPending(guide.steps[i]) then return false, "the group waits" end
	-- A group/elite quest only once the player said they do it.
	if a.group and Own.groupAnswer(q) ~= "do" then return false, "group quest not chosen" end
	local C = Compat()
	if C.IsOnQuest(q) then return false, "in the log" end
	if questDone(q) then return false, "done" end
	if Own.questSkipped(q) then return false, "quest skipped" end
	if layoutOf(guide).abandons[q] then return false, "abandoned later" end
	local lvl = tonumber(a.minLevel)
	if lvl and (player.level or 1) < lvl then return false, "needs level " .. lvl end
	local qlvl = tonumber(a.qlvl)
	if qlvl and qlvl > (player.level or 1) + Own.HERE_ABOVE then return false, "quest level " .. qlvl .. " too high" end
	if a.limit and not near then return false, "timed" end
	local u = unavailableFor(a)
	if u then return false, "unavailable (" .. tostring(u.reason) .. ")" end
	if ready then
		local function met(p) return questDone(p) or ready[p] end
		if type(a.preAll) == "table" then
			for _, p in ipairs(a.preAll) do
				if not met(p) then return false, "needs " .. p end
			end
		end
		if type(a.pre) == "table" and #a.pre > 0 then
			local any = false
			for _, p in ipairs(a.pre) do
				if met(p) then any = true end
			end
			if not any then return false, "needs " .. a.pre[1] end
		end
	end
	if a.limit then
		local c, x, y = goalWorld(a)
		if not (c and Own.aheadLimitOk(a, a.npc, c, x, y)) then return false, "timed: the walk to its hand-in does not fit" end
	end
	return true
end

-- Whether auto-accept takes quest q at the NPC whose window is open: an
-- accept of it at that NPC in a later step of the loaded guide for the
-- character (Own.aheadOk), with room in the log. When not, why.
function Own.aheadWants(q)
	if guide == nil or not computed then return false, "no guide placed" end
	if ns.Party and ns.Party.HoldsQuest(q) then return false, "the group holds it" end
	local npc = Compat().GetNpcID("npc")
	if not npc then return false, "no NPC" end
	if not player then refreshPlayer() end
	local steps, k = guide.steps, 0
	for i = computed + 1, #steps do
		local step = steps[i]
		if stepApplies(step) and not isSkipped(i) then
			k = k + 1
			for j, a in ipairs(step.goals) do
				if a.t == "accept" and a.quest == q and a.npc == npc then
					local ok, why = Own.aheadOk(i, j, a, nil, k <= Own.AHEAD)
					if not ok then return false, ("%s (step %d)"):format(why, i) end
					local room = Own.logRoom()
					if room < 1 then return false, ("log full (room %d, step %d)"):format(room, i) end
					return true
				end
			end
		end
	end
	return false, ("no accept here after step %d"):format(computed)
end

-- The world point of the first (last: `last`) open goal with a place of
-- step i, or nil.
function Own.stepPoint(i, last)
	local goals = guide.steps[i].goals
	local from, to, by = 1, #goals, 1
	if last then from, to, by = #goals, 1, -1 end
	for j = from, to, by do
		local other = goals[j]
		if other.map and other.x and other.y and goalApplies(other) and not Own.goalSkipped(i, j) and not goalDone(i, j, other) then
			local c, x, y = goalWorld(other)
			if c then return c, x, y end
		end
	end
	return nil
end

-- The whole visit hand-in `goal` of step s may be (see above), or nil: {
-- r (the step it does), accepts (its accept goals), credit (seconds of the
-- route's walk it saves) }. Only for an NPC the route reaches in its next
-- AHEAD steps after leading away (not Own.hereSoon's).
function Own.hereVisit(s, goal, live)
	local steps, npc, obj = guide.steps, goal.npc, goal.object
	local nc, nx, ny = goalWorld(goal)
	if not (nc and (npc or obj)) then return nil end
	local r, k = nil, 0
	for i = live + 1, #steps do
		if stepApplies(steps[i]) and not isSkipped(i) then
			if i == s then r = i end
			for j, other in ipairs(steps[i].goals) do
				if not r and ((npc and other.npc == npc) or (obj and other.object == obj)) and goalApplies(other) and not goalDone(i, j, other) then r = i end
			end
			if r then break end
			k = k + 1
			if k >= Own.AHEAD then return nil end
		end
	end
	if not r then return nil end
	local C = Compat()
	local ready, accepts, out = { [goal.quest] = true }, {}, 1
	for j, other in ipairs(steps[r].goals) do
		if other.t ~= "note" and goalApplies(other) and not Own.goalSkipped(r, j) and not goalDone(r, j, other) then
			local at = (npc and other.npc == npc) or (obj and other.object == obj)
			if not at then return nil end
			if other.t == "turnin" and C.IsQuestReadyForTurnIn(other.quest) then
				if not ready[other.quest] then ready[other.quest], out = true, out + 1 end
			elseif other.t == "accept" then
				accepts[#accepts + 1] = j
			else
				return nil
			end
		end
	end
	if Own.logRoom() + out < #accepts then return nil end
	for n, j in ipairs(accepts) do
		local a = steps[r].goals[j]
		if not Own.aheadOk(r, j, a, ready, true) then return nil end
		accepts[n] = a
	end
	-- The route's way in: from the last place before r (the live step's
	-- included), and on to the first place after it.
	local pc, px, py
	for i = r - 1, live, -1 do
		if stepApplies(steps[i]) and not isSkipped(i) then
			pc, px, py = Own.stepPoint(i, true)
			if pc then break end
		end
	end
	if pc ~= nc then return nil end
	local qc, qx, qy
	for i = r + 1, #steps do
		if stepApplies(steps[i]) and not isSkipped(i) then
			qc, qx, qy = Own.stepPoint(i, false)
			if qc then break end
		end
	end
	local yards = ((nx - px) ^ 2 + (ny - py) ^ 2) ^ 0.5
	if qc == nc then yards = yards + ((qx - nx) ^ 2 + (qy - ny) ^ 2) ^ 0.5 - ((qx - px) ^ 2 + (qy - py) ^ 2) ^ 0.5 end
	-- A visit that saves next to nothing (the route passes the NPC anyway, or
	-- comes back to it right after) is no visit: its line would claim a trip.
	local credit = yards * Own.HERE_WINDING / Own.HERE_SPEED
	if credit < Own.HERE_SLACK then return nil end
	return { r = r, accepts = accepts, credit = credit }
end

-- The level the character will be at, at least, when the route gets to
-- step s from the live step: the guide's own `level` goals on the way (it
-- holds the player there until they have it) and, with the Codex, what the
-- steps on the way give (Levels.ForGuide). Kept per guide, live step and
-- level (Own.herePlan).
Own.herePlan = { at = {} }
function Own.herePlanned(s, live, level)
	local m = Own.herePlan
	if m.guide ~= guide or m.live ~= live or m.level ~= level then
		m.guide, m.live, m.level, m.at = guide, live, level, {}
	end
	local n = m.at[s]
	if n then return n end
	n = level
	local steps = guide.steps
	for i = live, s - 1 do
		if stepApplies(steps[i]) and not isSkipped(i) then
			for _, goal in ipairs(steps[i].goals) do
				local l = goal.t == "level" and tonumber(goal.level)
				if l and l > n and goalApplies(goal) then n = l end
			end
		end
	end
	local Lv = ns.Levels
	local run = Lv and Lv.ForGuide and Lv.ForGuide(guide.id, nil, live, s)
	local to = type(run) == "table" and run.to
	if to and type(to.level) == "number" and to.level > n then n = to.level end
	m.at[s] = n
	return n
end

-- Whether waiting for the guide's hand-in at step s costs the quest's XP:
-- the character will be more levels over the quest there than now, past
-- the five that keep its full reward (Levels.Share).
function Own.hereXpLoss(s, goal, live)
	local Lv = ns.Levels
	if not (Lv and Lv.Share and Lv.QuestLevel) then return false end
	local q = Lv.QuestLevel(goal.quest, guide)
	if not q then return false end
	local level = player.level or 1
	return Lv.Share(Own.herePlanned(s, live, level), q) < Lv.Share(level, q)
end

-- Whether goal g of later step s, one of Own.hereGoalsOn's for a quest in
-- the log (an accept: one not taken), is a candidate, as what ("work",
-- "turnin" or "take"), how many are left (see above), and for a hand-in or a
-- pick-up whether the route reaches it anyway (Own.hereSoon: then it shows
-- only at its NPC). `shown`: Own.hereShown's. An accept comes here with the
-- log's room checked (Own.hereBuild).
function Own.hereFits(s, g, goal, live, shown)
	local q, t = goal.quest, goal.t
	local C = Compat()
	local liveGoals = guide.steps[live].goals
	if t == "accept" then
		-- A pick-up: a quest a later step of the loaded guide takes that the
		-- player can take now (Own.aheadOk with every prerequisite done: the
		-- goal for the character and not skipped, level, skips, group answers,
		-- closed breadcrumbs; never a timed one), weighed as a hand-in (Fitz on
		-- 0.3.6: walking past Thork with The Disruption Ends open since Disrupt
		-- the Attacks went in).
		if not Own.hereTurnins or not Own.aheadOk(s, g, goal, Own.READY_NONE) then return nil end
		for _, other in ipairs(liveGoals) do
			if other.t == "accept" and other.quest == q then return nil end
		end
		return "take", 0, Own.hereSoonOf(s, goal, live)
	end
	if not (goalApplies(goal) or Own.behindGoal(goal)) or Own.goalSkipped(s, g) or unavailableFor(goal) then return nil end
	if t == "turnin" then
		if not Own.hereTurnins or not C.IsQuestReadyForTurnIn(q) or goalDone(s, g, goal) then return nil end
		for _, other in ipairs(liveGoals) do
			if other.t == "turnin" and other.quest == q then return nil end
		end
		return "turnin", 0, Own.hereSoonOf(s, goal, live)
	end
	if C.IsQuestReadyForTurnIn(q) or ns.CharState().pinnedQuests[q] then return nil end
	local sh = shown[q]
	if sh and (sh == true or goal.oi == nil or sh[goal.oi]) then return nil end
	local done, cur, max = goalDone(s, g, goal)
	if done then return nil end
	for lg, other in ipairs(liveGoals) do
		if other.quest == q and other.oi == goal.oi and Own.HERE_VERBS[other.t] and goalApplies(other) and not goalDone(live, lg, other) then return nil end
	end
	if t == "use" and goal.item and C.GetItemCount(goal.item) < 1 then return nil end
	if not Own.hereLevelOk(goal, Own.hereTop) then return nil end
	local left = (max or goal.count or 1) - (cur or 0)
	if left < 1 then return nil end
	return "work", left
end

-- Build the candidates (Own.hereAll[1..hereAllN], route order) for the
-- active tab's live step, from every later step's goals of the loaded guide
-- on the player's continent (any zone of it: the poll measures them in world
-- yards), and keep the line on its goal while that is still one. True when a
-- line the player had clicked went (the arrow goes back to the guide).
function Own.hereBuild()
	Own.hereDirty = false
	local pc = Compat().GetPlayerWorldPosition()
	local aimed = false
	if Own.hereGuide ~= guide then
		aimed = Own.hereClear(false)
		Own.hereGuide = guide
	end
	local list, n = {}, 0
	Own.hereAll, Own.hereEscort = list, false
	local live = computed
	if guide and live and logReady and ns.Get("behavior.whileHere") then
		if not player then refreshPlayer() end
		Own.hereTop = (player.level or 1) + Own.HERE_ABOVE
		Own.hereRadius = tonumber(ns.Get("behavior.whileHereRadius")) or 180
		Own.hereTurnins = ns.Get("behavior.whileHereTurnins") and true or false
		Own.hereSeconds = tonumber(ns.Get("behavior.whileHereTurninSeconds")) or 20
		local steps = guide.steps
		for g, goal in ipairs(steps[live].goals) do
			if goal.escort and goalApplies(goal) and not goalDone(live, g, goal) then Own.hereEscort = true end
		end
		-- The route's next AHEAD steps (for the character, not skipped): their
		-- lines are near-term and rank first; later ones read "later in this
		-- guide". Of the first HERE_SOON of them, the last step and the NPCs and
		-- objects of their open goals (Own.hereSoonTo, Own.hereSoonAt: objects
		-- negated): a pick-up anywhere else is no "soon" one (Own.hereFits).
		local nearTo, k = live, 0
		local soonAt = Own.hereSoonAt
		for key in pairs(soonAt) do soonAt[key] = nil end
		Own.hereSoonTo = live
		for s = live + 1, #steps do
			if stepApplies(steps[s]) and not isSkipped(s) then
				k = k + 1
				if k > Own.AHEAD then break end
				if k <= Own.HERE_SOON then
					Own.hereSoonTo = s
					for g, other in ipairs(steps[s].goals) do
						if (other.npc or other.object) and goalApplies(other) and not goalDone(s, g, other) then
							if other.npc then soonAt[other.npc] = true end
							if other.object then soonAt[-other.object] = true end
						end
					end
				end
			end
			nearTo = s
		end
		-- Every goal of the loaded guide on the player's continent, whatever
		-- map it is on (Own.hereGoalsOn).
		local idx = pc and Own.hereGoalsOn(pc)
		if idx then
			local C, shown = Compat(), Own.hereShown()
			local at, ok = nil, false -- the step last checked, and whether it applies
			-- Pick-ups at all (the setting; room in the log, read once and only
			-- for an accept that passes the cheap checks), and the level they may
			-- be: what rules most accepts out before the costly checks.
			local takes, room = Own.hereTurnins, nil
			local level = player.level or 1
			local topQ = level + Own.HERE_ABOVE
			-- Quests an update passed behind the player (Engine.GetBehind): their
			-- work counts on steps behind the live one too; else those steps are
			-- skipped at once.
			local all = ns.CharState().behind
			local behind = type(all) == "table" and all[guide.id] or nil
			for i = 1, #idx, 2 do
				local s = idx[i]
				local goal = steps[s].goals[idx[i + 1]]
				local q = goal.quest
				local back = behind ~= nil and behind[q] and true or false
				if s > live or back then
					local g = idx[i + 1]
					local on = C.IsOnQuest(q)
					local take = not on and takes and goal.t == "accept" and s > live and not goal.limit and not goal.optional
						and (tonumber(goal.qlvl) or 0) <= topQ and (tonumber(goal.minLevel) or 0) <= level and not questDone(q) and not missingPre(goal)
					if take then
						if room == nil then room = Own.logRoom() >= 1 end
						take = room
					end
					if (on and not C.IsQuestFailed(q)) or take then
						if s ~= at then at, ok = s, stepApplies(steps[s]) and not isSkipped(s) end
						local kind, left, soon = nil, nil, false
						if ok or back then kind, left, soon = Own.hereFits(s, g, goal, live, shown) end
						if kind then
							n = n + 1
							-- places: where the target spawns on the map (Own.hereTick
							-- prefers the fewest). spot, d, pick: Own.hereDistance's and
							-- Own.herePick's, set here so the poll adds no keys.
							local spots = kind == "work" and goal.spots
							-- budget, xp: a hand-in's seconds of detour (with a visit's credit:
							-- the trip back it saves) and whether waiting costs XP; soon: the
							-- route reaches it anyway (only at its NPC); visit: Own.hereVisit's;
							-- detour, town: Own.hereDistance's.
							local xp = kind == "turnin" and Own.hereXpLoss(s, goal, live)
							local visit = kind == "turnin" and not soon and Own.hereVisit(s, goal, live) or false
							local budget = Own.hereSeconds * (xp and Own.HERE_XP or 1)
							if visit and budget > 0 then budget = budget + visit.credit end
							list[n] = { s = s, g = g, goal = goal, kind = kind, left = left, places = spots and #spots or 1,
								npcs = kind == "work" and Own.hereNpcsOf(goal), seen = false, spot = false, d = false, pick = 0,
								budget = budget, xp = xp or false, soon = soon or false, visit = visit, detour = 0, town = false, near = back or s <= nearTo,
								-- A shown line's: on, since (its time), yards (shown), serial (`appeared`), view.
								on = false, since = 0, yards = 0, serial = 0, view = false }
						end
					end
				end
			end
		end
		-- A pick-up once: its first accept in the route, and none an NPC's
		-- whole visit names already ("Hand in X to Y, then take A").
		local seen, kept = nil, 0
		for i = 1, n do
			local e = list[i]
			if e.visit then
				for _, a in ipairs(e.visit.accepts) do
					seen = seen or {}
					seen[a.quest] = true
				end
			end
		end
		for i = 1, n do
			local e = list[i]
			local q = e.kind == "take" and e.goal.quest
			if not (q and seen and seen[q]) then
				kept = kept + 1
				list[kept] = e
				if q then
					seen = seen or {}
					seen[q] = true
				end
			end
		end
		for i = kept + 1, n do list[i] = nil end
		n = kept
	end
	Own.hereAllN = n
	-- The poll measures them all, or the nearest HERE_MAX (picked at its next
	-- run, from where the player stands).
	if n <= Own.HERE_MAX then
		Own.hereList, Own.hereN, Own.hereCut = list, n, false
	else
		Own.hereList, Own.hereN, Own.hereCut, Own.herePickC = Own.herePicked, 0, true, nil
	end
	-- Each line stays on its goal while that is a candidate (its count may
	-- have changed; it takes over the new entry); a goal done or no longer one
	-- ends it.
	local on, changed = Own.hereOn, false
	local i = 1
	while i <= Own.hereOnN do
		local cur, e = on[i], nil
		for j = 1, n do
			if list[j].goal == cur.goal then
				e = list[j]
				break
			end
		end
		if e then
			e.on, e.since, e.yards, e.serial, e.view, e.spot, e.seen = true, cur.since, cur.yards, cur.serial, cur.view, cur.spot, cur.seen
			if e.left ~= cur.left then
				-- Worked on: its time starts again.
				e.since, e.view, changed = GetTime(), false, true
			end
			on[i] = e
			i = i + 1
		elseif Own.hereRemove(i, false) then
			aimed = true
		end
	end
	Own.here = on[1]
	if changed then ns.Fire("WHILE_HERE_CHANGED") end
	return aimed
end

-- The shown line with goal `goal`, or nil.
function Own.hereOf(goal)
	local on = Own.hereOn
	for i = 1, Own.hereOnN do
		if on[i].goal == goal then return on[i] end
	end
	return nil
end

-- End line i (dismissed: Own.hereDismiss). True when the player had clicked
-- it: the arrow goes back to the guide. Allocation-free unless dismissed.
function Own.hereRemove(i, dismissed)
	local on, n = Own.hereOn, Own.hereOnN
	local cur = on[i]
	if not cur then return false end
	if dismissed then Own.hereDismiss(cur) end
	for j = i, n - 1 do on[j] = on[j + 1] end
	on[n] = nil
	Own.hereOnN = n - 1
	cur.on, cur.view = false, false
	Own.here = on[1]
	local aimed = aim == cur.goal
	if aimed then aim = nil end
	ns.Fire("WHILE_HERE_CHANGED")
	return aimed
end

-- End every line, and forget the parked ones (Own.herePark). True when the
-- player had clicked one.
function Own.hereClear()
	local aimed = false
	while Own.hereOnN > 0 do
		if Own.hereRemove(Own.hereOnN, false) then aimed = true end
	end
	for k = Own.hereParkedN, 1, -1 do Own.hereParked[k] = nil end
	Own.hereParkedN = 0
	return aimed
end

-- Never in an instance, on a taxi, while a Hearthstone is cast, or while a
-- timed quest (Compat.QuestTimerRunning: the old timer list or the quest
-- log's time allowed, which Forever's client has; the old list alone when
-- Compat gives no answer) or the live step's escort runs: why (for the bug
-- report), or false. Allocation-free.
function Own.hereBlocked()
	if Own.hereEscort then return "escort" end
	if IsInInstance and IsInInstance() then return "instance" end
	if UnitOnTaxi and UnitOnTaxi("player") then return "flight" end
	local C = Compat()
	local timed = C.QuestTimerRunning and C.QuestTimerRunning()
	if timed == nil then timed = GetQuestTimers and GetQuestTimers() end
	if timed then return "timed quest" end
	if UnitCastingInfo then
		local spell = select(9, UnitCastingInfo("player"))
		if spell and Own.HERE_HEARTH[spell] then return "hearthing" end
	end
	return false
end

-- Yards from the player to candidate e: a goal's nearest spawn spot (its
-- centre, at the player's level; e.spot: that spot; every place the target
-- spawns, the alternatives too; once the player aimed the arrow at it, the
-- spot the arrow leads to), else its point; a hand-in's NPC (with its
-- detour and whether it is in the player's town: e.detour, e.town). The row, the
-- reach and the arrow so measure to the same point (Fitz: the row said 180 yd
-- to a zone-wide area's edge, the arrow 393 to its spot). A mob of the goal's
-- seen around the player (Own.hereSaw: a nameplate, the target, the
-- mouseover) puts it at HERE_SEEN yards at most (e.seen), whatever the spawn
-- data says. Nil on another continent and none seen. Allocation-free once
-- the places are resolved.
function Own.hereDistance(e, c, px, py)
	local goal = e.goal
	local best = nil
	if e.kind == "work" then
		local spots = goal.spots
		local led = spots and aim == goal and Spots.chosen[goal]
		if led then
			best, e.spot = Spots.dist(goal, led, c, px, py), led
		elseif spots then
			local top, lvl = Own.hereTop, goal.lvl
			for i = 1, #spots do
				local s = spots[i]
				local l = s.lvl or lvl
				if not (l and top and l > top) then
					local d = Spots.dist(goal, s, c, px, py)
					if d and (not best or d < best) then best, e.spot = d, s end
				end
			end
		else
			local gc, gx, gy = goalWorld(goal)
			if gc == c then best = ((gx - px) ^ 2 + (gy - py) ^ 2) ^ 0.5 end
		end
		local npcs, seen = e.npcs, false
		if npcs then
			for i = 1, #npcs do
				if Own.hereSaw(npcs[i]) then
					seen = true
					break
				end
			end
		end
		e.seen = seen
		if seen and not (best and best <= Own.HERE_SEEN) then best = Own.HERE_SEEN end
		return best
	end
	local gc, gx, gy = goalWorld(goal)
	if gc ~= c then return nil end
	local d = ((gx - px) ^ 2 + (gy - py) ^ 2) ^ 0.5
	e.detour = Own.hereDetour(c, px, py, gx, gy, d)
	e.town = d <= Own.HERE_TOWN and Own.hereResting()
	return d
end

-- Where the player is headed: the world point of the waypoint (the live
-- step's, or a line the player clicked), or nil. Allocation-free: resolved
-- once per waypoint.
function Own.hereHeading()
	local wp = waypoint
	if wp ~= Own.hereWp then
		Own.hereWp, Own.hereWpC = wp, nil
		if wp and wp.map and wp.x and wp.y then Own.hereWpC, Own.hereWpX, Own.hereWpY = Compat().MapToWorld(wp.map, wp.x, wp.y, wp.f) end
	end
	return Own.hereWpC, Own.hereWpX, Own.hereWpY
end

-- Seconds of extra walking to visit a hand-in's NPC at gx, gy (d yards from
-- the player) and go on to where the player is headed, against going there
-- straight: the straight lines HERE_WINDING longer, at run speed
-- (HERE_SPEED), as the walking router counts a walk it has no path for, so
-- the two agree on open ground. Headed nowhere, or to another continent:
-- there and back. Allocation-free.
function Own.hereDetour(c, px, py, gx, gy, d)
	local tc, tx, ty = Own.hereHeading()
	local extra
	if tc == c then
		extra = d + ((gx - tx) ^ 2 + (gy - ty) ^ 2) ^ 0.5 - ((px - tx) ^ 2 + (py - ty) ^ 2) ^ 0.5
	else
		extra = 2 * d
	end
	return extra > 0 and extra * Own.HERE_WINDING / Own.HERE_SPEED or 0
end

-- Whether the player rests in a town (an inn's or a city's rest area).
function Own.hereResting()
	return IsResting ~= nil and Compat().Readable(IsResting()) == true
end

-- Whether candidate e, d yards off (Own.hereDistance's), is in reach: an
-- objective within behavior.whileHereRadius yards; a hand-in or a pick-up
-- in the player's town or at most its seconds out of the way (0: in town
-- only), never past HERE_FAR.
function Own.hereIn(e, d)
	if e.kind ~= "work" then
		if Own.hereAt(e, d) then return true end
		return not e.soon and d <= Own.HERE_FAR and (e.town or (e.budget > 0 and e.detour <= e.budget))
	end
	return d <= (Own.hereRadius or 180)
end

-- Whether hand-in e, d yards off, is at its NPC (HERE_AT yards) while its
-- seconds allow one out of town or the player rests in one: then it shows
-- whatever its detour or step, as 0.3.5 showed it.
function Own.hereAt(e, d)
	return d <= Own.HERE_AT and (e.budget > 0 or e.town)
end

-- Whether a shown line, d yards off, goes: an objective past HERE_CLEAR
-- times the radius; a hand-in or a pick-up never at its NPC (Own.hereAt),
-- one the route reaches anyway (e.soon) past HERE_CLEAR times HERE_AT, else
-- past HERE_CLEAR times HERE_FAR, or out of town with its detour past
-- HERE_CLEAR times its seconds and HERE_SLACK more; never further than
-- HERE_CLEAR_MAX.
function Own.herePast(e, d)
	local clear, top = Own.HERE_CLEAR, Own.HERE_CLEAR_MAX
	if e.kind ~= "work" then
		if Own.hereAt(e, d) then return false end
		if e.soon then return d > Own.HERE_AT * clear end
		return d > math.min(Own.HERE_FAR * clear, top) or (not e.town and e.detour > e.budget * clear + Own.HERE_SLACK)
	end
	return d > math.min((Own.hereRadius or 180) * clear, top)
end

-- Hand-ins the walk check turned away (Own.hereMayShow), per goal: { at, c,
-- x, y, wp, why } (when, where the player stood, the waypoint then, and why:
-- "floor", "walk" or "detour"). Checked again HERE_RECHECK s on, once the
-- player has moved HERE_REPICK yards, or for another waypoint.
Own.hereWalked = setmetatable({}, { __mode = "k" })

function Own.hereTurnAway(e, why)
	local w = Own.hereWalked[e.goal]
	if not w then
		w = {}
		Own.hereWalked[e.goal] = w
	end
	local c, x, y = Compat().GetPlayerWorldPosition()
	w.at, w.c, w.x, w.y, w.wp, w.why = GetTime(), c, x or 0, y or 0, waypoint, why
	return false
end

-- Whether hand-in e, d yards off, waits after being turned away
-- (Own.hereWalked); at its NPC (Own.hereAt) only another floor keeps it
-- waiting. Allocation-free.
function Own.hereWalkWait(e, c, px, py, d)
	local w = Own.hereWalked[e.goal]
	if not w or w.c ~= c or w.wp ~= waypoint or GetTime() - w.at >= Own.HERE_RECHECK then return false end
	if w.why ~= "floor" and d and Own.hereAt(e, d) then return false end
	return (px - w.x) ^ 2 + (py - w.y) ^ 2 <= Own.HERE_REPICK * Own.HERE_REPICK
end

Own.hereBack = {} -- the hand-in check's waypoint (reused)

-- A hand-in, once as it would appear (Own.hereMayShow): never on another
-- floor (the NPC's height `z` against the player's floor, Nav's walking
-- engine: Undercity's levels, Thunder Bluff's rises); in the player's town,
-- a walk there not far longer than the straight line (a canal, a lift
-- without heights); else the detour the walking router gives (there, on to
-- the waypoint, less the waypoint straight from here) at most its seconds:
-- an NPC across a river is minutes out of the way, a few yards off. No
-- answer from the router lets the straight lines' word stand.
function Own.hereTurninOk(e, d)
	local goal, nav = e.goal, ns.Nav
	local W = nav and nav.walk
	if goal.z and W and W.Floor then
		local c, px, py = Compat().GetPlayerWorldPosition()
		local ok, z = pcall(W.Floor, c, px, py)
		if ok and type(z) == "number" and math.abs(z - goal.z) > Own.HERE_FLOOR then return Own.hereTurnAway(e, "floor") end
	end
	if Own.hereAt(e, d) then return true end
	if not (nav and nav.EstimateTravel) then return true end
	local to = Own.hereTo
	to.map, to.f, to.x, to.y = goal.map, goal.f, goal.x, goal.y
	local ok, there = pcall(nav.EstimateTravel, nil, to, true, true)
	if not (ok and type(there) == "number") then return true end
	if e.town then
		if there * Own.HERE_SPEED > d * Own.HERE_WALK + 20 then return Own.hereTurnAway(e, "walk") end
		return true
	end
	local extra = 2 * there
	local c = Compat().GetPlayerWorldPosition()
	local wp = waypoint
	if wp and Own.hereHeading() == c then
		local back = Own.hereBack
		back.map, back.f, back.x, back.y = wp.map, wp.f, wp.x, wp.y
		local ok1, on = pcall(nav.EstimateTravel, to, back, true, true)
		local ok2, direct = pcall(nav.EstimateTravel, nil, back, true, true)
		if not (ok1 and ok2 and type(on) == "number" and type(direct) == "number") then return true end
		extra = there + on - direct
	end
	if extra <= e.budget then return true end
	return Own.hereTurnAway(e, "detour")
end

-- Once, as the line would appear: not on a boat, zeppelin or tram, and the
-- walk there (Nav's budgeted estimate) not far longer than the straight
-- line (a hand-in or a pick-up: Own.hereTurninOk). No answer (no Nav, busy,
-- no route) lets it show, and so does a mob of it seen right here (e.seen).
function Own.hereMayShow(e, d)
	local T = ns.Transit
	if T and T.Riding and T.Riding() then return false end
	if e.kind ~= "work" then
		if not Own.hereTurninOk(e, d) then return false end
		Own.hereWalked[e.goal] = nil
		return true
	end
	if e.seen then return true end
	local nav = ns.Nav
	if not (nav and nav.EstimateTravel) then return true end
	local goal, s, to = e.goal, e.spot, Own.hereTo
	to.map, to.f = goal.map, goal.f
	to.x, to.y = s and s.x or goal.x, s and s.y or goal.y
	local ok, seconds = pcall(nav.EstimateTravel, nil, to, true, true)
	if not (ok and type(seconds) == "number") then return true end
	return seconds * Own.HERE_SPEED <= d * Own.HERE_WALK + 20
end

-- The nearest HERE_MAX candidates not quiet (Own.hereAll) into
-- Own.herePicked, from world position c, px, py. Allocation-free.
function Own.herePick(c, px, py)
	local all, quiet, picked = Own.hereAll, Own.hereQuiet, Own.herePicked
	local serial = (Own.herePickSerial or 0) + 1
	Own.herePickSerial = serial
	for i = 1, Own.hereAllN do
		local e = all[i]
		e.d = not quiet[e.goal] and Own.hereDistance(e, c, px, py) or false
	end
	local k = 0
	while k < Own.HERE_MAX do
		local best = nil
		for i = 1, Own.hereAllN do
			local e = all[i]
			if e.d and e.pick ~= serial and (not best or e.d < best.d) then best = e end
		end
		if not best then break end
		best.pick, k = serial, k + 1
		picked[k] = best
	end
	for i = k + 1, #picked do picked[i] = nil end
	Own.hereN, Own.herePickC, Own.herePickX, Own.herePickY = k, c, px, py
end

-- Whether candidate e at d yards ranks before `other` at otherD: a quest's
-- whose timer runs first (Own.hereTimed), then one of the route's next
-- steps (e.near) before one later in the guide, then the one whose target
-- spawns in the fewest places on the map (a camp or a pool before mobs
-- found all over the zone), then the nearest.
function Own.hereBefore(e, d, other, otherD)
	if not other then return true end
	local timed = Own.hereTimed(e)
	if timed ~= Own.hereTimed(other) then return timed end
	if e.near ~= other.near then return e.near end
	return e.places < other.places or (e.places == other.places and d < otherD)
end

-- A timed quest's clock runs (Own.hereBlocked's "timed quest"): its own lines
-- still come, before any other (Own.hereBefore), so its objectives and its
-- hand-in show on the way; every other line waits here as it was
-- (Own.herePark) and shows again once the clock stops (Own.hereUnpark), as
-- after a flight. Own.hereTimers: Compat.QuestTimers' reading, each poll
-- that ranks or parks.
Own.hereParked, Own.hereParkedN, Own.hereTimers = {}, 0, {}

-- Whether line e is a quest's whose timer runs: the client's reading, or
-- Quests/Timed.lua's clock (a delivery the client may not report: Timed.Left).
function Own.hereTimed(e)
	local q = e.goal.quest
	return Own.hereTimers[q] ~= nil or (ns.Timed ~= nil and ns.Timed.Left(q) ~= nil)
end

-- Park every shown line of a quest without a running timer. True when the
-- player had clicked one (the arrow goes back to the guide).
function Own.herePark()
	local on, aimed, moved = Own.hereOn, false, false
	local i = 1
	while i <= Own.hereOnN do
		local e = on[i]
		if Own.hereTimed(e) then
			i = i + 1
		else
			for j = i, Own.hereOnN - 1 do on[j] = on[j + 1] end
			on[Own.hereOnN] = nil
			Own.hereOnN = Own.hereOnN - 1
			Own.hereParkedN = Own.hereParkedN + 1
			Own.hereParked[Own.hereParkedN] = e
			e.on = false
			if aim == e.goal then aim, aimed = nil, true end
			moved = true
		end
	end
	if moved then
		Own.here = on[1]
		ns.Fire("WHILE_HERE_CHANGED")
	end
	return aimed
end

-- The clock stopped: each parked line whose goal is still a candidate shows
-- again (the candidate Own.hereBuild made for it since takes its row, and
-- its text while its count is the same), its time starting anew, in its
-- place by the distance it showed, while fewer than HERE_SHOW show; the
-- rest come again in reach like any other.
function Own.hereUnpark()
	local all, on, now, back = Own.hereAll, Own.hereOn, GetTime(), false
	for k = 1, Own.hereParkedN do
		local p = Own.hereParked[k]
		Own.hereParked[k] = nil
		local e = nil
		for j = 1, Own.hereAllN do
			if all[j].goal == p.goal then
				e = all[j]
				break
			end
		end
		if e and not e.on and Own.hereOnN < Own.HERE_SHOW then
			if e ~= p then
				e.yards, e.serial, e.spot, e.seen = p.yards, p.serial, p.spot, p.seen
				e.view = e.left == p.left and p.view or false
			end
			e.on, e.since, e.d = true, now, p.yards
			local n, at = Own.hereOnN, Own.hereOnN + 1
			for j = 1, n do
				if e.d < (on[j].d or math.huge) then
					at = j
					break
				end
			end
			for j = n, at, -1 do on[j + 1] = on[j] end
			on[at], Own.hereOnN = e, n + 1
			back = true
		end
	end
	Own.hereParkedN = 0
	if back then
		Own.here = on[1]
		ns.Fire("WHILE_HERE_CHANGED")
	end
end

-- The arrival poll (c nil: no position). Keeps or ends the lines shown
-- (each by its own distance and time), then while fewer than HERE_SHOW show
-- adds the best of the candidates in reach, in rank order (Own.hereBefore:
-- which show). The lines read nearest first: a new one takes its place by
-- distance, and two shown swap only once the lower is HERE_ORDER yards
-- nearer, so rows do not jump. Allocation-free. With HERE_SHOW lines up,
-- only those are measured. True when a line the player had clicked went
-- (the arrow goes back to the guide).
function Own.hereTick(c, px, py)
	if Own.hereOnN == 0 and Own.hereAllN == 0 then return false end
	-- On a taxi, boat or zeppelin, in an instance, hearthing or the live
	-- step's escort: the lines shown hide and wait (Own.hereHeld), no new one
	-- comes, nothing goes by distance or time, nothing counts as left. Back,
	-- they show again as they were (no chime, no ping), their time starting
	-- anew; then the usual rules apply from where the player is. A timed
	-- quest's clock holds only the other quests' lines (Own.herePark).
	local blocked = c and Own.hereBlocked() or false
	local timedOnly = blocked == "timed quest"
	local held = not c or (blocked and not timedOnly) or (ns.Transit and ns.Transit.Riding and ns.Transit.Riding()) or false
	if held then
		if not Own.hereHeld then
			Own.hereHeld = true
			if Own.hereOnN > 0 then ns.Fire("WHILE_HERE_CHANGED") end
		end
		return false
	end
	if Own.hereHeld then
		Own.hereHeld = false
		local now = GetTime()
		for j = 1, Own.hereOnN do Own.hereOn[j].since = now end
		if Own.hereOnN > 0 then ns.Fire("WHILE_HERE_CHANGED") end
	end
	local C, parked = Compat(), false
	if timedOnly then
		Own.hereTimers = C.QuestTimers and C.QuestTimers(Own.hereTimers) or Own.hereTimers
		parked = Own.herePark()
	elseif Own.hereParkedN > 0 then
		Own.hereUnpark()
	end
	if UnitAffectingCombat and UnitAffectingCombat("player") then return parked end
	local step, on, aimed, now = Own.HERE_STEP, Own.hereOn, parked, GetTime()
	local i = 1
	while i <= Own.hereOnN do
		local cur = on[i]
		local d = Own.hereDistance(cur, c, px, py)
		if not d or Own.herePast(cur, d) then
			if Own.hereRemove(i, false) then aimed = true end
		elseif not Own.hereIn(cur, d) and now - cur.since > Own.HERE_SECONDS then
			-- Out of reach (no spawn area in reach, none of its mobs in sight)
			-- for HERE_SECONDS without going past the clear distance: it goes.
			Own.hereExpiredAt[cur.goal] = now
			if Own.hereRemove(i, false) then aimed = true end
		else
			-- In reach the line holds, however long (Fitz: "it shouldn't
			-- expire unless I move away from those areas").
			if Own.hereIn(cur, d) then cur.since = now end
			cur.d = d
			local shown = math.floor(d / step + 0.5) * step
			if shown ~= cur.yards then
				cur.yards = shown
				ns.Fire("WHILE_HERE_MOVED", shown, i)
			end
			i = i + 1
		end
	end
	-- Nearest first, stable: a line moves up past the one above it only when
	-- HERE_ORDER yards nearer; the route's next steps' lines (e.near) above
	-- those later in the guide.
	local swapped = false
	for j = 1, Own.hereOnN - 1 do
		local a, b = on[j], on[j + 1]
		if (b.near and not a.near) or (b.near == a.near and b.d + Own.HERE_ORDER < a.d) then
			on[j], on[j + 1], swapped = b, a, true
		end
	end
	if swapped then
		Own.here = on[1]
		ns.Fire("WHILE_HERE_CHANGED")
	end
	-- A muted goal's player has been HERE_DISMISS_AWAY yards from where it
	-- was dismissed (Own.hereMuted).
	local away = Own.HERE_DISMISS_AWAY * Own.HERE_DISMISS_AWAY
	for _, m in pairs(Own.hereMutes) do
		if not m.far and (m.c ~= c or (px - m.x) ^ 2 + (py - m.y) ^ 2 >= away) then m.far = true end
	end
	if Own.hereOnN >= Own.HERE_SHOW or Own.hereAllN == 0 then return aimed end
	-- More candidates than the poll measures: the nearest, again each
	-- HERE_REPICK yards.
	if Own.hereCut then
		local pc, dx, dy = Own.herePickC, px - (Own.herePickX or 0), py - (Own.herePickY or 0)
		if pc ~= c or dx * dx + dy * dy > Own.HERE_REPICK * Own.HERE_REPICK then Own.herePick(c, px, py) end
	end
	-- The candidates in reach not shown (e.d: their distance, else false);
	-- while a timed quest's clock runs, only its own.
	if not timedOnly then Own.hereTimers = C.QuestTimers and C.QuestTimers(Own.hereTimers) or Own.hereTimers end
	local quiet, list, open = Own.hereQuiet, Own.hereList, 0
	local takes = 0 -- pick-ups shown (at most HERE_TAKES)
	for j = 1, Own.hereOnN do
		if on[j].kind == "take" then takes = takes + 1 end
	end
	for j = 1, Own.hereN do
		local e = list[j]
		if not e.on then
			local d = not quiet[e.goal] and (not timedOnly or Own.hereTimed(e)) and not (e.kind == "take" and takes >= Own.HERE_TAKES)
				and Own.hereDistance(e, c, px, py)
			if d and Own.hereIn(e, d) and Own.hereAgain(e) and not Own.hereMuted(e) and not (e.kind ~= "work" and Own.hereWalkWait(e, c, px, py, d)) then
				e.d, open = d, open + 1
			else
				e.d = false
			end
		end
	end
	while open > 0 and Own.hereOnN < Own.HERE_SHOW do
		local best = nil
		for j = 1, Own.hereN do
			local e = list[j]
			if not e.on and e.d and not (e.kind == "take" and takes >= Own.HERE_TAKES) and Own.hereBefore(e, e.d, best, best and best.d) then best = e end
		end
		if not best then break end
		open = open - 1
		if Own.hereMayShow(best, best.d) then
			-- Nearest first among the lines shown, the route's next steps' first.
			local n, at = Own.hereOnN, Own.hereOnN + 1
			for j = 1, n do
				local o = on[j]
				if (best.near and not o.near) or (best.near == o.near and best.d < o.d) then
					at = j
					break
				end
			end
			for j = n, at, -1 do on[j + 1] = on[j] end
			on[at], Own.hereOnN = best, n + 1
			if best.kind == "take" then takes = takes + 1 end
			Own.hereSerial = (Own.hereSerial or 0) + 1
			best.on, best.since, best.serial, best.view = true, now, Own.hereSerial, false
			best.yards = math.floor(best.d / step + 0.5) * step
			Own.hereExpiredAt[best.goal], Own.hereMutes[best.goal] = nil, nil
			Own.here = on[1]
			ns.Fire("WHILE_HERE_CHANGED")
		elseif best.kind ~= "work" then
			-- Turned away from here (Own.hereWalked): checked again later.
			best.d = false
		else
			Own.hereQuiet[best.goal], Own.herePickC = true, nil
			best.d = false
		end
	end
	return aimed
end

-- Line e as a goal view (Engine.GetAlong's) of its later step with: `step`
-- (its step), `here` ("work" | "turnin" | "take"), `left`, `appeared` (a number new
-- for each line that appears: the minimap's ping), `yards` (to the next
-- HERE_STEP), `hereText` (what to do: "Kill Kobold Vermin, 2 more", "Hand in
-- X to Y"), `hereTitle` (a turn-in's quoted quest name in it: UI.HereText
-- marks it), `later` (a step past the route's next AHEAD: "later in this
-- guide"). Kept on the line until its count changes.
function Own.hereViewOf(e)
	local v = e.view
	if not v then
		local goal, left = e.goal, e.left
		v = goalView(e.s, e.g, goal, "current", nil)
		v.step, v.here, v.left, v.appeared, v.later = e.s, e.kind, left, e.serial, not e.near
		local text
		if e.kind == "turnin" then
			local _, npc = npcOf(goal)
			local raw = questTitle(goal) or titleOfQuest(goal.quest)
			local title = ns.Quoted(raw)
			local visit = e.visit
			-- A quest named after its NPC (a breadcrumb: "Thun'grim Firegaze" to
			-- Thun'grim Firegaze) gets strings of its own that do not repeat it
			-- (Own.namesake).
			local same = npc and Own.namesake(raw, npc)
			if visit and npc then
				-- The whole visit (Own.hereVisit): its accepts by name, and why now.
				local names = {}
				for i, a in ipairs(visit.accepts) do names[i] = ns.Quoted(questTitle(a) or titleOfQuest(a.quest)) end
				if #names > 0 then
					local list = table.concat(names, ", ")
					text = same and L["Hand in %s to them, then take %s: saves a trip back"]:format(title, list)
						or L["Hand in %s to %s, then take %s: saves a trip back"]:format(title, npc, list)
				else
					text = same and L["Hand in %s to them: saves a trip back"]:format(title)
						or L["Hand in %s to %s: saves a trip back"]:format(title, npc)
				end
			elseif same then
				text = L["Hand in %s to them"]:format(title)
			else
				text = npc and L["Hand in %s to %s"]:format(title, npc) or L["Hand in %s"]:format(title)
			end
			v.hereTitle = title
		elseif e.kind == "take" then
			-- Auto-accept off, at the NPC of a quest the route takes in its next
			-- steps (Own.hereFits): take it now.
			local _, npc = npcOf(goal)
			local raw = questTitle(goal) or titleOfQuest(goal.quest)
			local title = ns.Quoted(raw)
			text = (not npc or Own.namesake(raw, npc)) and L["Take %s from them: saves a trip back"]:format(title)
				or L["Take %s from %s: saves a trip back"]:format(title, npc)
			v.hereTitle = title
		else
			text = L["%s, %d more"]:format(v.text or "", left)
		end
		v.hereText = text
		e.view = v
	end
	v.yards = e.yards
	return v
end

-- Whether the lines show now: not while held (Own.hereTick: a taxi, an
-- instance...), nor while the window looks at another step than the live one.
function Own.hereVisible()
	return Own.hereOnN > 0 and not Own.hereHeld and guide ~= nil and current ~= nil and current == computed
end

-- The lines shown now, nearest first, as Own.hereViewOf's views ({} without
-- one, or while the window looks at another step than the live one).
function Engine.GetWhileHereList()
	local out = {}
	if not Own.hereVisible() then return out end
	for i = 1, Own.hereOnN do out[i] = Own.hereViewOf(Own.hereOn[i]) end
	return out
end

-- The first line (Engine.GetWhileHereList's first), or nil.
function Engine.GetWhileHere()
	if not Own.hereVisible() then return nil end
	return Own.hereViewOf(Own.hereOn[1])
end

-- Lead the arrow to line i (default 1; it holds while the line shows, and
-- gives the arrow back to the guide when it goes); its time starts again.
-- True if the arrow can lead there.
function Engine.AimWhileHere(i)
	local cur = Own.hereOn[i or 1]
	if not (cur and guide and current) then return false end
	-- The arrow leads to the spot the row measures to, until it is reached.
	if cur.spot and cur.goal.spots then Spots.chosen[cur.goal], Spots.pinned[cur.goal] = cur.spot, cur.spot end
	if not waypointOf(cur.g, cur.goal, nil, cur.s) then return false end
	aim, cur.since = cur.goal, GetTime()
	evaluate()
	return true
end

-- The player's "not now" for line i (default 1): it goes, muted near here
-- (twice: for the zone stay, Own.hereDismiss); the others stay.
function Engine.DismissWhileHere(i)
	if not Own.hereOn[i or 1] then return false end
	if Own.hereRemove(i or 1, true) then evaluate() end
	return true
end

-- The candidates now, in route order, for tests and /polestar debug:
-- { { step, index, kind, left, measured, soon, credit }, ... }; `measured`:
-- the poll measures it (all of them, or the nearest HERE_MAX); a hand-in's
-- `soon` (Own.hereSoon) and `credit` (its visit's seconds saved, or nil).
function Engine.GetWhileHereCandidates()
	local out = {}
	local cut, serial = Own.hereCut, Own.herePickSerial
	for i = 1, Own.hereAllN do
		local e = Own.hereAll[i]
		out[i] = { step = e.s, index = e.g, kind = e.kind, left = e.left, measured = not cut or (Own.hereN > 0 and e.pick == serial),
			soon = e.soon, credit = e.visit and e.visit.credit or nil }
	end
	return out
end

-- What the bug report says of the lines (UI/Report.lua): { on, radius,
-- turnins (a hand-in's seconds out of the way, false with hand-ins off),
-- candidates, shown = { { text, quest, step, index, yards }, ... } } with
-- lines, else `nearest` (the nearest candidate: { quest, step, index, yards,
-- seen, detour (a hand-in's seconds out of the way) }, nil without one
-- measurable) and `why` none shows: "off", "another
-- step in view", "no candidates", "no position", Own.hereBlocked's reason,
-- "in combat", "quiet (dismissed, this zone)", "expired (...)", "out of
-- radius", "left to the route (...)", "out of the way (...)", "turned away
-- (...)", or "in reach, next poll".
function Engine.WhileHereState()
	local on = ns.Get("behavior.whileHereTurnins")
	local st = { on = ns.Get("behavior.whileHere") and true or false, candidates = Own.hereAllN,
		radius = Own.hereRadius or tonumber(ns.Get("behavior.whileHereRadius")) or 180,
		turnins = on and (Own.hereSeconds or tonumber(ns.Get("behavior.whileHereTurninSeconds")) or 20) or false }
	local cur = Own.here
	if Own.hereVisible() then
		st.shown = {}
		for i = 1, Own.hereOnN do
			local e = Own.hereOn[i]
			local v = Own.hereViewOf(e)
			st.shown[i] = { text = v.hereText, quest = e.goal.quest, step = e.s, index = e.g, yards = v.yards }
		end
		return st
	end
	local C = Compat()
	local c, px, py = C.GetPlayerWorldPosition()
	local best, bestD
	if c then
		for i = 1, Own.hereAllN do
			local e = Own.hereAll[i]
			local d = Own.hereDistance(e, c, px, py)
			if d and (not bestD or d < bestD) then best, bestD = e, d end
		end
	end
	if best then
		st.nearest = { quest = best.goal.quest, step = best.s, index = best.g, yards = math.floor(bestD + 0.5), seen = best.seen or false,
			detour = best.kind == "turnin" and math.floor(best.detour + 0.5) or nil }
	end
	if not st.on then
		st.why = "off"
	elseif cur then
		st.why = "another step in view"
	elseif Own.hereAllN == 0 then
		st.why = "no candidates"
	elseif not c then
		st.why = "no position"
	else
		local blocked = Own.hereBlocked()
		if blocked then
			st.why = blocked
		elseif UnitAffectingCombat and UnitAffectingCombat("player") then
			st.why = "in combat"
		elseif best and Own.hereQuiet[best.goal] then
			st.why = "quiet (dismissed twice, this zone)"
		elseif best and Own.hereMuted(best) then
			st.why = "muted (dismissed; comes back 2 min on, in reach, once 100 yd from where it was dismissed)"
		elseif best and Own.hereExpiredAt[best.goal] and not Own.hereAgain(best) then
			st.why = "expired (out of reach 3 min; comes again in reach a minute on)"
		elseif best and best.kind ~= "work" and Own.hereWalkWait(best, c, px, py, bestD) then
			local w = Own.hereWalked[best.goal]
			st.why = ("turned away (%s; checked again in %d s or %d yd)"):format(w.why == "floor" and "another floor"
				or w.why == "walk" and "a long way round" or "the walk is too far out of the way", Own.HERE_RECHECK, Own.HERE_REPICK)
		elseif best and best.kind ~= "work" and bestD > Own.HERE_FAR then
			st.why = ("too far for a hand-in or pick-up (over %d yd)"):format(Own.HERE_FAR)
		elseif best and best.kind ~= "work" and best.soon and not Own.hereIn(best, bestD) then
			st.why = ("left to the route (it goes there next; shows within %d yd)"):format(Own.HERE_AT)
		elseif best and not Own.hereIn(best, bestD) then
			st.why = best.kind ~= "work" and ("out of the way (%d s, over %d s%s%s)"):format(math.floor(best.detour + 0.5), math.floor(best.budget + 0.5),
				best.xp and ", doubled for XP" or "", best.visit and (", %d s of it the trip back saved"):format(math.floor(best.visit.credit + 0.5)) or "") or "out of radius"
		elseif best then
			st.why = "in reach, next poll"
		else
			st.why = "none measurable here"
		end
	end
	return st
end

-- One arrival poll's work for the line, from world position c, px, py (tests).
function Engine.WhileHereTick(c, px, py)
	if Own.hereTick(c, px, py) then requestUpdate() end
end

-- What changes the candidates: the quest log, a turn-in (it opens the
-- quests after it: pick-ups), the level, the player's pins, ticks and
-- skips, a new zone (which also ends the zone stay: dismissed lines may come
-- back), the settings.
function Own.hereChanged() Own.hereDirty = true end
for _, event in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "QUEST_LOG_UPDATE", "UNIT_QUEST_LOG_CHANGED", "PLAYER_LEVEL_UP" }) do
	ns.RegisterEvent(event, Own.hereChanged)
end
-- PLAYER_SKIPPED_QUEST comes after the skip's evaluation: one more.
for _, msg in ipairs({ "PINS_CHANGED", "PLAYER_SKIPPED_STEP", "PLAYER_SKIPPED_QUEST" }) do
	ns.On(msg, function()
		Own.hereDirty = true
		requestUpdate()
	end)
end
ns.RegisterEvent("PLAYER_LEVEL_UP", function() requestUpdate() end)
for _, event in ipairs({ "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD" }) do
	ns.RegisterEvent(event, function()
		Own.hereDirty = true
		local zone = GetRealZoneText and GetRealZoneText() or nil
		if zone ~= Own.hereZone then
			Own.hereZone = zone
			for goal in pairs(Own.hereQuiet) do Own.hereQuiet[goal] = nil end
			for goal in pairs(Own.hereExpiredAt) do Own.hereExpiredAt[goal] = nil end
			for goal in pairs(Own.hereMutes) do Own.hereMutes[goal] = nil end
			for goal in pairs(Own.hereStrikes) do Own.hereStrikes[goal] = nil end
		end
	end)
end
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and path:sub(1, 18) == "behavior.whileHere" then
		Own.hereDirty = true
		-- A hand-in turned away for its detour is weighed again at the new seconds.
		if path == "behavior.whileHereTurninSeconds" then
			for goal in pairs(Own.hereWalked) do Own.hereWalked[goal] = nil end
		end
		if path == "behavior.whileHere" and not ns.Get(path) and Own.hereClear(false) then evaluate() end
		requestUpdate()
	end
end)

---------------------------------------------------------------------------
-- Pinned quests (#644): the player pins a quest of the log as along the way
-- (the step menu, the quest log's menu). Its open objectives join the Along
-- the way list under whatever step is current (Engine.GetAlong), with their
-- map marks, the target button and the arrow (Engine.AimAlong), until they
-- are done or the player unpins it; a step ahead that turns it in while
-- they are open says so (goal view `pinOpen`). Each objective is the
-- guide's own goal for its quest-log line when the guide has one (the first
-- open one: located, with its spawn areas), else one built from the quest
-- database (Own.pinBuild). Pins are per character (CharState().pinnedQuests, quest
-- id -> true); a quest turned in drops its pin. (On Own: the main chunk is
-- at 200 locals.)
---------------------------------------------------------------------------

Own.PIN_STEP = 0 -- the step of a built pin goal: no guide step has index 0
Own.PIN_VERBS = { kill = true, collect = true, interact = true, use = true }
Own.pinBuilt = {} -- quest -> { [quest-log line] = goal | false }

-- Pin quest q (on: true or nil) or unpin it (on: false). True when done.
function Engine.PinQuest(q, on)
	q = tonumber(q)
	if not q then return false end
	local pins = ns.CharState().pinnedQuests
	if on == false then pins[q] = nil else pins[q] = true end
	Own.pinBuilt[q] = nil
	if on == false and aim and aim.quest == q then aim = nil end
	ns.Fire("PINS_CHANGED", q, pins[q] == true)
	if guide then evaluate() end
	return true
end

function Engine.IsPinned(q)
	return ns.CharState().pinnedQuests[tonumber(q) or 0] == true
end

-- The pinned quests listed now: in the log with an objective open, by id.
-- A pinned quest turned in is unpinned.
function Own.pinList()
	local C = Compat()
	local pins, out = ns.CharState().pinnedQuests, {}
	for q in pairs(pins) do
		if C.IsQuestCompleted(q) then
			pins[q] = nil
		elseif C.IsOnQuest(q) and not C.IsQuestReadyForTurnIn(q) then
			out[#out + 1] = q
		end
	end
	table.sort(out)
	return out
end

-- Pinned quest q's open quest-log lines, each as { step, goal index, goal,
-- line }, in the log's order: the guide's first open goal on that line, else
-- the built one.
function Own.pinGoals(q)
	local objs = Compat().GetQuestObjectives(q)
	local out, have = {}, {}
	if not objs then return out end
	for s, step in ipairs(guide.steps) do
		for g, goal in ipairs(step.goals) do
			if goal.quest == q and goal.oi and Own.PIN_VERBS[goal.t] and goalApplies(goal) then
				local line = Own.objectiveLine(goal, objs)
				local o = objs[line]
				if o and not o.finished and not have[line] and not goalDone(s, g, goal) then
					have[line] = true
					out[#out + 1] = { s, g, goal, line }
				end
			end
		end
	end
	for line, o in ipairs(objs) do
		if not o.finished and not have[line] then
			local goal = Own.pinBuild(q, line, o)
			if goal then out[#out + 1] = { Own.PIN_STEP, q * 100 + line, goal, line } end
		end
	end
	table.sort(out, function(a, b) return a[4] < b[4] end)
	return out
end

-- An objective goal for line `line` (objective `o`) of quest q, from the
-- quest database: a kill of its mob, a collect of its item or a click on its
-- object, at that NPC's (the item's best dropper's, else its object's)
-- spawns on the player's map, else on the map with most of them; the
-- objective's own words, by the line's type, when the database has nothing
-- to name.
function Own.pinBuild(q, line, o)
	local built = Own.pinBuilt[q]
	if not built then
		built = {}
		Own.pinBuilt[q] = built
	end
	if built[line] ~= nil then return built[line] or nil end
	local Q = ns.QuestDB
	local rec = Q and Q.IsLoaded() and Q.GetQuest(q)
	local ob = rec and rec.objectives[line]
	local goal = { quest = q, oi = line, title = rec and rec.title or nil, t = "kill", text = Compat().ObjectiveLabel(o.text) }
	local at
	if ob and ob.kind == "kill" then
		at = Q.GetNpc(ob.id)
		goal.npc, goal.target = ob.id, at and at.name
	elseif ob and ob.kind == "item" then
		local item = Q.GetItem(ob.id)
		goal.t, goal.item, goal.itemName = "collect", ob.id, item and item.name
		at = item and ((item.droppers[1] and Q.GetNpc(item.droppers[1].id)) or (item.objects[1] and Q.GetObject(item.objects[1].id)))
	elseif ob and ob.kind == "object" then
		at = Q.GetObject(ob.id)
		goal.t, goal.object, goal.objName = "interact", ob.id, at and at.name
	elseif ob and ob.kind == "event" and ob.map then
		goal.map, goal.x, goal.y, goal.f = ob.map, ob.x, ob.y, ob.f
	elseif not ob and goal.text ~= "" then
		-- No database line: the log's own label, by the line's type.
		if o.type == "monster" then
			goal.target = goal.text
		elseif o.type == "item" then
			goal.t, goal.itemName = "collect", goal.text
		elseif o.type == "object" then
			goal.t, goal.objName = "interact", goal.text
		end
	end
	if goal.target or goal.itemName or goal.objName then goal.text = nil end
	if at and at.spawns and #at.spawns > 0 then
		local here = Compat().GetPlayerMapPosition()
		local count, best = {}, nil
		for _, sp in ipairs(at.spawns) do
			count[sp.map] = (count[sp.map] or 0) + 1
			if not best or count[sp.map] > count[best] then best = sp.map end
		end
		local map = count[here or 0] and here or best
		local spots = {}
		for _, sp in ipairs(at.spawns) do
			if sp.map == map then
				spots[#spots + 1] = { x = sp.x, y = sp.y, r = sp.r or 0 }
				goal.f = goal.f or sp.f
			end
		end
		goal.map, goal.x, goal.y, goal.spots = map, spots[1].x, spots[1].y, spots
	end
	built[line] = goal
	return goal
end

-- The goal at `s`, `g` of an Along the way row (Engine.GetAlong's goal view
-- `step` and `index`): a guide goal, or a pinned quest's built one.
function Own.alongGoal(s, g)
	if not guide then return nil end
	if s == Own.PIN_STEP then
		local q = math.floor(g / 100)
		local built = Own.pinBuilt[q]
		return built and built[g - q * 100] or nil
	end
	local step = guide.steps[s]
	return step and step.goals[g] or nil
end
Engine.AlongGoal = Own.alongGoal

-- Whether `s`, `g` is a goal listed now as a pinned quest's (Own.pinGoals).
function Own.pinListed(s, g)
	if not guide then return false end
	for _, q in ipairs(Own.pinList()) do
		for _, e in ipairs(Own.pinGoals(q)) do
			if e[1] == s and e[2] == g then return true end
		end
	end
	return false
end

-- A step's turn-in of a quest whose objectives are still open, at step `s`
-- (current or ahead): true when the player pinned the quest, "ticked" when the
-- player ticked one of its objectives by hand that the game still counts open
-- (Own.tickedOpen, #1135), "along" when a listed along step holds its work
-- (Own.alongWork, #853); else false.
function Own.pinOpen(s, goal)
	if goal.t ~= "turnin" or not goal.quest then return false end
	if not current or s < current then return false end
	if ns.CharState().pinnedQuests[goal.quest] then
		local C = Compat()
		return C.IsOnQuest(goal.quest) and not C.IsQuestReadyForTurnIn(goal.quest) or false
	end
	if Own.tickedOpen(goal.quest) then return "ticked" end
	return Own.alongWork(goal.quest)[1] and "along" or false
end

-- Whether the player ticked by hand an objective of quest q (a kill,
-- collect, interact or use goal with `quest`) that the game still counts open,
-- the quest in the log and not ready to hand in (#1135). The tick means "stop
-- focusing this": the route moves on past it, but never stands for the quest
-- log, so the quest's turn-in waits (stepGroups gives it no focus; its line
-- says why, Own.pinOpen).
Own.OBJECTIVE_VERBS = { kill = true, collect = true, interact = true, use = true }
function Own.tickedOpen(q)
	local m = guide and q and ns.CharState().manual[guide.id]
	if not m then return false end
	local C = Compat()
	if not C.IsOnQuest(q) or C.IsQuestReadyForTurnIn(q) then return false end
	for key, v in pairs(m) do
		if v == "tick" then
			local s, g = key:match("^(%d+):(%d+)$")
			local step = s and guide.steps[tonumber(s)]
			local goal = step and step.goals[tonumber(g)]
			if goal and goal.quest == q and Own.OBJECTIVE_VERBS[goal.t] and not objectiveState(goal) then return true end
		end
	end
	return false
end

function Engine.GetWaypoint() return waypoint or nil end

function Engine.GetProgress()
	if not guide then return 0, 0 end
	if not player then refreshPlayer() end
	return progressLoaded()
end

-- The live step: the first applicable, not skipped, not done one (nil when
-- the guide is complete), whatever step the player is looking at.
function Engine.GetLiveStep() return computed end

-- Whether step i of the active guide is for this character (the step's
-- `only` and `when`) and, given goal g, that goal too (its `only`,
-- profession, quests the route leaves out): what the guide counts as
-- applicable. False for a step or goal it does not have.
function Engine.Applies(i, g)
	local step = guide and guide.steps[i]
	if not step then return false end
	if not player then refreshPlayer() end
	if not stepApplies(step) then return false end
	if g == nil then return true end
	local goal = step.goals[g]
	return goal ~= nil and goalApplies(goal)
end

-- The level the guide expects next (QoL/XPMark): the first `level N` goal at
-- or after the step shown that is for this character (the step's `only` and
-- `when`, the goal's `only`), neither skipped, with N above `level` (the
-- caller's reading; the character's level by default), or a point inside
-- that level (`level 12.4`, `frac`) the character has not reached yet.
-- N, its step, its frac (nil for a whole level); or nil.
function Engine.LevelTarget(level)
	if not (guide and current) then return nil end
	if not player then refreshPlayer() end
	level = level or player.level or 1
	local sk = skippedFor(guide.id)
	for s = current, #guide.steps do
		local step = guide.steps[s]
		if not (sk and sk[s]) and stepApplies(step) then
			for g, goal in ipairs(step.goals) do
				local n = goal.level or 0
				local ahead = n > level or (goal.frac and n == level and not Own.levelReached(n, goal.frac))
				if goal.t == "level" and ahead and not (sk and sk[Own.key(s, g)]) and goalApplies(goal) then
					return n, s, goal.frac
				end
			end
		end
	end
	return nil
end

-- Items the active guide still needs in the bags, so they are kept, never
-- sold (QoL/Vendor.lua, QoL/Keep.lua): from the live step on, a `use` goal's
-- item, a `collect`'s, a `buy`'s, a `craft`'s reagents and the item an
-- `accept` starts from; and before it, a quest `collect` whose quest is in
-- the log and handed in at a later step (the turn-in takes the items). Only
-- steps and goals for this character, none the player skipped.
-- -> { [itemID] = the first step that needs it }, built once per evaluation
-- (read it, do not keep it).
Own.kept = {}
function Engine.KeptItems()
	local k = Own.kept
	if k.items and k.generation == generation and k.guide == guide then return k.items end
	local items = {}
	k.items, k.generation, k.guide = items, generation, guide
	local live = computed
	if not (guide and live) then return items end
	if not player then refreshPlayer() end
	local C, sk = Compat(), skippedFor(guide.id)
	local function keep(item, s)
		if type(item) == "number" and not (items[item] and items[item] <= s) then items[item] = s end
	end
	local function wanted(s, g, goal)
		return not (sk and sk[Own.key(s, g)]) and goalApplies(goal)
	end
	local handIn, early = {}, {}
	for s, step in ipairs(guide.steps) do
		if not (sk and sk[s]) and stepApplies(step) then
			for g, goal in ipairs(step.goals) do
				local t = goal.t
				if s < live then
					if t == "collect" and goal.quest and C.IsOnQuest(goal.quest) and wanted(s, g, goal) then early[#early + 1] = goal end
				elseif wanted(s, g, goal) then
					if t == "use" or t == "collect" or t == "buy" or (t == "accept" and goal.item) then
						keep(goal.item, s)
					elseif t == "craft" and type(goal.reagents) == "table" then
						for _, r in ipairs(goal.reagents) do keep(r.item, s) end
					elseif t == "turnin" and goal.quest and not handIn[goal.quest] then
						handIn[goal.quest] = s
					end
				end
			end
		end
	end
	for _, goal in ipairs(early) do
		local s = handIn[goal.quest]
		if s then keep(goal.item, s) end
	end
	return items
end

-- Another race's starting zone the player has not reached (Own.awayStart),
-- for the guide window's notice: { races, zone, zoneName }; nil once they
-- are there (or it is under way), and for any other guide.
function Engine.AwayStart(id)
	local g = id and Guides.Get(id)
	if not g then return nil end
	if not player then refreshPlayer() end
	if not Own.awayStart(g) then return nil end
	return { races = g.races, zone = g.zone, zoneName = g.zoneName }
end

-- What a Class guide waits on before this character can start it
-- (Own.startGate), for the guide window's notice and the guide menu's row:
-- { level } or { pre, preTitle }, with who starts it (giver: the opening's
-- first accept's NPC, object or item name, and its map); nil when it can be
-- started (or is under way).
function Engine.StartGate(id)
	local g = id and Guides.Get(id)
	if not g then return nil end
	if not player then refreshPlayer() end
	local gate = Own.startGate(g)
	if not gate then return nil end
	local a = gate.giver
	return {
		level = gate.level,
		pre = gate.pre,
		preTitle = gate.pre and titleOfQuest(gate.pre, gate.preTitles) or nil,
		giver = a and (ns.Names.Npc(a.npc) or a.npcName or ns.Names.Object(a.object) or a.objName or ns.Names.Item(a.item) or a.itemName) or nil,
		map = a and a.map or nil,
	}
end

-- Look at step s instead of the live one (nil, or the live step: back to it).
function Own.view(s)
	if not s or (computed and s == computed) then
		pin, pinDone = nil, nil
	else
		pin, pinDone = s, stepDone(s)
	end
end

-- Navigation, ticks and skips are the player's word: they end the tab's
-- placement (place).
--
-- Skip the step on screen for good (saved): the guide moves on from it.
-- Looking at another step than the live one, the view moves to the next
-- applicable step. Undone by Unskip. Fires PLAYER_SKIPPED_STEP(guideId,
-- step) after the evaluation (the window offers the undo). Returns the
-- skipped step. What the skip stored besides the step (Own.skipStore) goes
-- with its undo.
function Engine.Skip()
	if not (guide and current) then return nil end
	refreshPlayer()
	placing = nil
	local s, id = current, guide.id
	local before = Own.skipState(id)
	skippedFor(id, true)[s] = true
	local feed = {}
	Own.feedSkip(s, feed)
	if pin then Own.view(nextApplicable(pin)) end
	evaluate()
	Own.skipStore(id, s, before, feed)
	ns.Fire("PLAYER_SKIPPED_STEP", id, s)
	return s
end

-- A feeder step skipped stays out of the guide's next prefix
-- (Own.feederChain): its quests join CharState().feedSkips, and those new
-- there are added to `feed` (what the skip's undo gives back).
function Own.feedSkip(s, feed)
	if not guide.steps[s].feeder then return end
	local st = ns.CharState()
	if type(st.feedSkips) ~= "table" then st.feedSkips = {} end
	for _, goal in ipairs(guide.steps[s].goals) do
		local q = goal.quest
		if q and not st.feedSkips[q] then
			st.feedSkips[q] = true
			feed[#feed + 1] = q
		end
	end
end

-- Party "sync to my guide", accepted (Party.AcceptSync): skip every step
-- from the live step up to step t of the loaded guide that applies, is open,
-- is not skipped yet and that keep(step) does not keep (the steps the
-- member who asked does not have: your class's own steps stay yours), so
-- the live step reaches t or a kept step before it. The player's ticks and
-- earlier skips stay as they are; nothing moves back (a live step at or past
-- t stays). The skips are stored with the first one's (Own.skipStore), so
-- the window's undo of it (PLAYER_SKIPPED_STEP) brings them all back.
-- Returns how many steps it skipped.
function Engine.SkipUpTo(t, keep)
	if not (guide and computed) or type(t) ~= "number" or not guide.steps[t] or t <= computed then return 0 end
	refreshPlayer()
	placing = nil
	local id = guide.id
	local before = Own.skipState(id)
	local sk = skippedFor(id, true)
	local first, n, feed = nil, 0, {}
	for s = computed, t - 1 do
		if not sk[s] and stepApplies(guide.steps[s]) and not stepDone(s) and not (keep and keep(guide.steps[s])) then
			sk[s] = true
			first, n = first or s, n + 1
			Own.feedSkip(s, feed)
		end
	end
	if not first then
		if not next(sk) then ns.CharState().skipped[id] = nil end
		return 0
	end
	Own.view(nil)
	evaluate()
	Own.skipStore(id, first, before, feed)
	ns.Fire("PLAYER_SKIPPED_STEP", id, first)
	return n
end

-- The steps of guide id with a stored `when` outcome or skip: { when = { [s]
-- = true }, skipped = { [s] = value } }, a copy (Engine.Skip compares).
function Own.skipState(id)
	local st = ns.CharState()
	local out = { when = {}, skipped = {} }
	for field, into in pairs(out) do
		local t = st[field][id]
		if type(t) == "table" then
			for k, v in pairs(t) do
				if type(k) == "number" then into[k] = v end
			end
		end
	end
	return out
end

-- A skip moves the live step past more steps than the one skipped, and the
-- route stores what it finds on the way: each passed step's `when` outcome
-- (Own.latchWhen: held in `when`, failed as a skip) and the `skipto` jumps
-- taken (Own.jump, "jump"). Those are the skip's own doing, so its undo
-- takes them back with it, or a step passed at level 19 for `when level>=20`
-- would stay passed at 20 once the skip is undone. Saved per character, per
-- guide and skipped step, with the feeder quests the skip left out
-- (CharState().skipStored[guideId][s] = { steps = { [t] = "when" | true |
-- "jump" }, feed = { questID, ... } }); Own.remap moves it with the steps.
function Own.skipStore(id, s, before, feed)
	local now = Own.skipState(id)
	local steps, any = {}, #feed > 0
	for t in pairs(now.when) do
		if not before.when[t] then steps[t], any = "when", true end
	end
	for t, v in pairs(now.skipped) do
		if t ~= s and before.skipped[t] == nil and (v == true or v == "jump") then steps[t], any = v, true end
	end
	local st = ns.CharState()
	if type(st.skipStored) ~= "table" then st.skipStored = {} end
	local mine = st.skipStored[id]
	if any then
		mine = mine or {}
		st.skipStored[id] = mine
		mine[s] = { steps = steps, feed = feed }
	elseif mine then
		mine[s] = nil
		if not next(mine) then st.skipStored[id] = nil end
	end
	if not next(st.skipStored) then st.skipStored = nil end
end

-- Step i of guide id is unskipped (Unskip, Goto): what its skip stored
-- (Own.skipStore) and still holds goes too.
function Own.skipRestore(id, i)
	local st = ns.CharState()
	local all = type(st.skipStored) == "table" and st.skipStored or nil
	local mine = all and all[id]
	local rec = type(mine) == "table" and mine[i]
	if not rec then return end
	mine[i] = nil
	if not next(mine) then all[id] = nil end
	if not next(all) then st.skipStored = nil end
	local held, sk = st.when[id], st.skipped[id]
	for t, v in pairs(type(rec.steps) == "table" and rec.steps or NONE) do
		if v == "when" then
			if held and held[t] == true then held[t] = nil end
		elseif sk and sk[t] == v then
			sk[t] = nil
		end
	end
	if held and not next(held) then st.when[id] = nil end
	if sk and not next(sk) then st.skipped[id] = nil end
	local fs = st.feedSkips
	if type(fs) == "table" then
		for _, q in ipairs(type(rec.feed) == "table" and rec.feed or NONE) do fs[q] = nil end
		if not next(fs) then st.feedSkips = nil end
	end
end

-- Undo a skip: step i is open again (the live step when it is the first open
-- one), with what its skip stored on the way (Own.skipRestore). True if it
-- was skipped.
function Engine.Unskip(i)
	if not guide or type(i) ~= "number" then return false end
	local sk = skippedFor(guide.id)
	if not (sk and sk[i]) then return false end
	refreshPlayer()
	placing = nil
	sk[i] = nil
	if not next(sk) then ns.CharState().skipped[guide.id] = nil end
	Own.skipRestore(guide.id, i)
	Own.keep(i)
	evaluate()
	return true
end

-- The player's step skip that left the rest of the loaded guide out
-- (#1372): with no live step, the first step skipped by hand (a skip of a
-- step with `when` may be a failed condition stored as one, and a `skipto`
-- jump is saved as "jump": neither is the player's to undo here) whose undo
-- would open a later step, one that follows from it (its quest's accept, or
-- a prerequisite, is in the skipped step). Skipping Brine in Call of Water
-- leaves every later step without its quest: the guide is not done then.
-- It does not complete (no GUIDE_COMPLETED, no hand-off, not "done" in the
-- guide list) and the window says so, with the undo, instead of "Guide
-- complete". Only in a guide that is no leveling guide (Own.everyStep): a
-- leveling guide the player skipped to its end finishes and hands off as
-- before, its end window asking (Own.noteEnd). Tried on the saved skips
-- and put straight back, as Engine.SkipLoses does. -> { step, title } | nil
function Engine.SkippedOut()
	if not guide or computed or not Own.everyStep(guide) then return nil end
	local sk = skippedFor(guide.id)
	if not sk then return nil end
	if not player then refreshPlayer() end
	local steps, found = guide.steps, nil
	for s = 1, #steps do
		if sk[s] == true and steps[s].when == nil and stepApplies(steps[s]) then
			sk[s] = nil
			local ok, opens = pcall(nextOpen, s)
			sk[s] = true
			if ok and opens then
				found = s
				break
			end
		end
	end
	nextOpen(0) -- the marks the try left (Own.preMarks' prerequisite) read the real state again
	return found and { step = found, title = steps[found].title } or nil
end

-- One applicable step forward, done, skipped or open alike: a look at it
-- that changes nothing (the counterpart of Prev); reaching the live step
-- hands back to it.
function Engine.Next()
	if not (guide and current) then return end
	refreshPlayer()
	placing = nil
	local s = nextApplicable(current)
	while s and not Own.lookable(s) do s = nextApplicable(s) end
	if not s then return end
	Own.view(s)
	evaluate()
end

-- Look at step i: a jump back or ahead that changes nothing, except that a
-- skipped step jumped to is open again.
function Engine.Goto(i)
	if not guide or type(i) ~= "number" or not guide.steps[i] then return end
	refreshPlayer()
	if not Own.lookable(i) then return end
	placing = nil
	local sk = skippedFor(guide.id)
	if sk and sk[i] then
		sk[i] = nil
		Own.skipRestore(guide.id, i)
		-- A jumped step looked at again takes no jump, or the route would jump straight back.
		if guide.steps[i].skipto then Own.keep(i) end
	end
	local comp = computeCurrent()
	-- Leaving the open step backwards forgets its in-step latches.
	if comp and i < comp and current and current == comp then clearInStep(current) end
	computed = comp
	Own.view(i)
	evaluate()
end

-- One applicable step back, done, skipped or open alike: a look at it like
-- Goto's, but it never un-skips the step, so Next walks the same steps
-- forward and hands back to the live step where Prev started.
function Engine.Prev()
	if not guide then return end
	refreshPlayer()
	placing = nil
	for s = (current or #guide.steps + 1) - 1, 1, -1 do
		if Own.lookable(s) then
			if current and current == computed then clearInStep(current) end
			Own.view(s)
			evaluate()
			return
		end
	end
end

-- Goal g of step s is done (by live state, arrival or check-off).
function Engine.GoalDone(stepIndex, goalIndex)
	if not guide then return false end
	local step = guide.steps[stepIndex]
	local goal = step and step.goals[goalIndex]
	if not goal then return false end
	if not player then refreshPlayer() end
	return goalDone(stepIndex, goalIndex, goal) == true
end

-- Tick a goal done, or clear its check-off: any goal but a note, quest goals
-- included (the player's word over the quest log for the route: it moves on).
-- A ticked quest objective never makes its quest ready to hand in: the turn-in
-- waits for the game (Own.tickedOpen, #1135). Saved as "tick" in
-- CharState().manual. False when there is nothing to change (no such goal, a
-- note, or a goal already done by live state).
function Engine.ToggleGoal(stepIndex, goalIndex)
	if not guide then return false end
	local step = guide.steps[stepIndex]
	local goal = step and step.goals[goalIndex]
	if not goal or goal.t == "note" then return false end
	refreshPlayer()
	local m = manualFor(guide.id, true)
	local key = stepIndex .. ":" .. goalIndex
	if m[key] then
		m[key] = nil
	elseif goalDone(stepIndex, goalIndex, goal) then
		return false
	else
		m[key] = "tick"
	end
	placing, Own.hereDirty = nil, true
	evaluate()
	return true
end

-- Skip a quest, or bring it back (on = false): its goals in every guide read
-- as skipped, and the quests that need it go with it; the guide moves on.
-- The quest may already be in the log: it stays there, the guide no longer
-- leads to it (the player abandons it or not). Saved per character. False
-- for no quest id.
function Engine.SkipQuest(questID, on)
	if type(questID) ~= "number" then return false end
	local st = ns.CharState()
	if type(st.skippedQuests) ~= "table" then st.skippedQuests = {} end
	st.skippedQuests[questID] = on ~= false or nil
	if not next(st.skippedQuests) then st.skippedQuests = nil end
	refreshPlayer()
	placing = nil
	evaluate()
	-- PLAYER_SKIPPED_QUEST(questID, title): the guide window offers the undo.
	if on ~= false then
		local title
		for _, step in ipairs(guide and guide.steps or NONE) do
			for _, goal in ipairs(step.goals) do
				if goal.quest == questID and goal.title then title = goal.title break end
			end
			if title then break end
		end
		ns.Fire("PLAYER_SKIPPED_QUEST", questID, title)
	end
	return true
end

function Engine.IsQuestSkipped(questID)
	return Own.questSkipped(questID)
end

-- The accepts of this guide a skip would leave out with it: skipping quest q
-- (Engine.SkipQuest), or with q nil the live step (Engine.Skip). The skip is
-- tried on the saved state and put straight back: nothing is evaluated or
-- fired. Counts the open accepts of other quests (not taken, done or already
-- left out) in other steps that go: { { id, title }, ... } in route order,
-- each quest once; nil when none.
function Engine.SkipLoses(q)
	if not guide or (q == nil and not current) or (q ~= nil and type(q) ~= "number") then return nil end
	if not player then refreshPlayer() end
	local C, state, s0 = Compat(), ns.CharState(), q == nil and current or nil
	local function open()
		local list, set = {}, {}
		for s, step in ipairs(guide.steps) do
			if s ~= s0 and stepApplies(step) then
				for _, goal in ipairs(step.goals) do
					local id = goal.quest
					if goal.t == "accept" and id and id ~= q and not set[id] and not (C.IsOnQuest(id) or questDone(id))
						and goalApplies(goal) and not unavailableFor(goal) then
						set[id] = true
						list[#list + 1] = goal
					end
				end
			end
		end
		return list, set
	end
	local before = open()
	local undo
	if q then
		local had = state.skippedQuests
		if type(had) ~= "table" then state.skippedQuests = {} end
		local was = state.skippedQuests[q]
		state.skippedQuests[q] = true
		undo = function()
			state.skippedQuests[q] = was
			if type(had) ~= "table" then state.skippedQuests = had end
		end
	else
		local had = skippedFor(guide.id)
		local sk = skippedFor(guide.id, true)
		local was = sk[s0]
		sk[s0] = true
		undo = function()
			sk[s0] = was
			if not had then state.skipped[guide.id] = nil end
		end
	end
	local ok, _, after = pcall(open)
	undo()
	open() -- the marks the try left (Own.preMarks' prerequisite) read the real state again
	if not ok then return nil end
	local out = {}
	for _, goal in ipairs(before) do
		if not after[goal.quest] then out[#out + 1] = { id = goal.quest, title = titleOfQuest(goal.quest, { [goal.quest] = goal.title }) } end
	end
	return #out > 0 and out or nil
end

-- Skip an optional goal, or bring it back: it no longer leads the arrow and
-- reads as skipped (saved as CharState().skipped[guideId]["s:g"]). A quest
-- started by an item is one thing to do: its accept and the collect of its
-- item in the same step skip and come back together. False for goals that
-- are not optional.
function Engine.SkipGoal(stepIndex, goalIndex)
	if not guide then return false end
	local step = guide.steps[stepIndex]
	local goal = step and step.goals[goalIndex]
	if not (goal and goal.optional) then return false end
	local sk = skippedFor(guide.id, true)
	local on = not sk[stepIndex .. ":" .. goalIndex] or nil
	local starter = goal.item and ((goal.t == "accept" and not goal.npc and not goal.object) or (goal.t == "collect" and not goal.quest))
	for g, other in ipairs(step.goals) do
		local partner = starter and other ~= goal and other.item == goal.item and other.optional
			and ((other.t == "accept" and not other.npc and not other.object) or (other.t == "collect" and not other.quest))
			and other.t ~= goal.t
		if g == goalIndex or partner then
			sk[stepIndex .. ":" .. g] = on
			if aim == other then aim = nil end
		end
	end
	if not next(sk) then ns.CharState().skipped[guide.id] = nil end
	placing, Own.hereDirty = nil, true
	evaluate()
	return true
end

-- Point the arrow at a goal of the current step the player chose (its place,
-- spawn areas included) until the step changes or the goal is done. True if
-- the arrow can lead there. A goal whose quest waits for its accept in the
-- step (Own.acceptFirst) is not picked: the arrow goes to that accept, and
-- false, "accept" and the quest's title come back (the window says "Take
-- <quest> first", #1385).
function Engine.AimGoal(stepIndex, goalIndex)
	if not (guide and current) or stepIndex ~= current then return false end
	local goal = guide.steps[current].goals[goalIndex]
	if not goal then return false end
	local a = Own.acceptFirst(current, goal)
	if a then
		local accept = guide.steps[current].goals[a]
		aim = waypointOf(a, accept) and accept or nil
		evaluate()
		return false, "accept", questTitle(accept)
	end
	if not waypointOf(goalIndex, goal) then return false end
	aim = goal
	evaluate()
	return true
end

-- The index of step s's open accept for goal's quest while the quest is not
-- taken yet, or nil (#1385): a collect, kill or turn-in before its accept
-- cannot be done, so the arrow does not lead there (Engine.AimGoal,
-- Engine.CycleWaypoint, findWaypoint's pick). Accepts and notes never wait.
function Own.acceptFirst(s, goal)
	local q = goal.quest
	if not q or goal.t == "accept" or goal.t == "note" then return nil end
	if Compat().IsOnQuest(q) or questDone(q) then return nil end
	for g, other in ipairs(guide.steps[s].goals) do
		if other.t == "accept" and other.quest == q and goalApplies(other) and not unavailableFor(other)
			and not Own.goalSkipped(s, g) and not goalDone(s, g, other) then
			return g
		end
	end
	return nil
end

-- Lead the arrow to an open, located goal of a listed along step (a row
-- click under the step). The choice lasts while the goal is listed and open,
-- also when the route moves on. True if the arrow can lead there.
function Engine.AimAlong(stepIndex, goalIndex)
	if not (guide and current) then return false end
	local goal = Own.alongGoal(stepIndex, goalIndex)
	if not (Own.pinListed(stepIndex, goalIndex) or goal and Own.alongShows(stepIndex, goal)) then return false end
	if not goal or goal.t == "note" or not waypointOf(goalIndex, goal, nil, stepIndex) then return false end
	aim = goal
	evaluate()
	return true
end

-- Point the arrow at a behind quest's open goal (its "Still to do" row).
function Engine.AimBehind(q)
	for _, e in ipairs(Engine.GetBehind()) do
		if e.quest == q then
			local goal = guide.steps[e.step].goals[e.goal]
			if not waypointOf(e.goal, goal, nil, e.step) then return false end
			aim = goal
			evaluate()
			return true
		end
	end
	return false
end

-- Move a candidate goal to its next-best candidate (wrapping); in the current
-- step the arrow follows it there. Returns the new candidate's position in
-- the ranking, or nil.
function Engine.CycleCandidate(stepIndex, goalIndex)
	if not guide then return nil end
	local step = guide.steps[stepIndex]
	local goal = step and step.goals[goalIndex]
	if not (goal and goal.candidates) then return nil end
	if not player then refreshPlayer() end
	local p = pickFor(goal)
	if #p.list < 2 then return p.i > 0 and p.i or nil end
	p.i = p.i % #p.list + 1
	if stepIndex == current then aim = goal else ns.Fire("STEP_UPDATED", current) end
	evaluate()
	return p.i
end

-- Move a goal with spawn areas on to its next spot: the nearest one not
-- visited lately (the current one counts as visited now), or spot `index`.
-- The new spot holds until the player reaches it; in the current step the
-- arrow follows the goal there, whichever goal it pointed at. Returns its
-- index in goal.spots, or nil (no such goal, or fewer than two spots).
function Engine.CycleSpot(stepIndex, goalIndex, index)
	if not guide then return nil end
	local step = guide.steps[stepIndex]
	local goal = step and step.goals[goalIndex]
	if not (goal and goal.spots and #goal.spots > 1) then return nil end
	local cur = Spots.get(goal)
	if cur then Spots.seen[cur] = GetTime() end
	local target = index and goal.spots[index]
	if target then
		Spots.chosen[goal] = target
	else
		local c, px, py = Compat().GetPlayerWorldPosition()
		Spots.repick(goal, c, px, py, true)
	end
	Spots.pinned[goal] = Spots.chosen[goal]
	if stepIndex == current then aim = goal else ns.Fire("STEP_UPDATED", current) end
	evaluate()
	return Spots.index(goal)
end

-- The waypoint keys (Bindings.xml): the next (dir 1) or previous (-1) place
-- the arrow can lead to on the step on screen. A goal with spawn spots moves
-- on to its next or previous spot (CycleSpot); else the arrow moves to the
-- next or previous open goal of the step that has a place, in goal order,
-- round the step. True if the arrow moved.
function Engine.CycleWaypoint(dir)
	if not (guide and current) then return false end
	dir = dir == -1 and -1 or 1
	local step = guide.steps[current]
	local gi = waypoint and waypoint.stepIndex == current and waypoint.goalIndex or nil
	local goal = gi and step.goals[gi]
	if goal and goal.spots and #goal.spots > 1 then
		local n = #goal.spots
		return Engine.CycleSpot(current, gi, ((Spots.index(goal) or 1) - 1 + dir) % n + 1) ~= nil
	end
	local n = #step.goals
	for k = 1, n do
		local g = ((gi or (dir == 1 and 0 or 1)) - 1 + dir * k) % n + 1
		local cand = step.goals[g]
		if cand ~= goal and goalApplies(cand) and not Own.goalSkipped(current, g) and not goalDone(current, g, cand) and not Own.acceptFirst(current, cand) and waypointOf(g, cand) then
			aim = cand
			evaluate()
			return true
		end
	end
	return false
end

-- Forget check-offs, skips, the saved view and the end reached for the
-- active guide: placed again as if just opened, it tells its end again only
-- when the player gets there (Own.noteEnd).
function Engine.ResetProgress()
	if not guide then return end
	local state = ns.CharState()
	state.manual[guide.id] = nil
	state.skipped[guide.id] = nil
	state.when[guide.id] = nil
	if type(state.skipStored) == "table" then state.skipStored[guide.id] = nil end
	-- What an update passed or left behind (Own.passAdded) comes back too.
	for _, f in ipairs({ "added", "gone", "behind" }) do
		if type(state[f]) == "table" then state[f][guide.id] = nil end
	end
	Own.goneGen = Own.goneGen + 1
	state.guideEnds[guide.id] = nil
	Own.endOpen[guide.id], Own.lastOpen[guide.id] = nil, nil
	pin, pinDone, aim, passedUpTo, placing = nil, nil, nil, 0, GetTime() + PLACE_SECONDS
	evaluate()
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local function onUpdateEvent() requestUpdate() end

-- Every name below is declared in Forever's API documentation; RegisterEvent
-- skips any a client build does not know.
for _, event in ipairs({
	"QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_LOG_UPDATE", "QUEST_WATCH_UPDATE",
	"BAG_UPDATE_DELAYED", "PLAYER_ENTERING_WORLD", "PLAYER_MONEY",
	-- level (a point inside a level: `level 12.5`)
	"PLAYER_XP_UPDATE",
	-- skill / craft
	"SKILL_LINES_CHANGED", "CHAT_MSG_SKILL", "TRADE_SKILL_SHOW", "TRADE_SKILL_LIST_UPDATE",
	-- learn
	"LEARNED_SPELL_IN_SKILL_LINE", "SPELLS_CHANGED", "NEW_RECIPE_LEARNED",
	-- rep
	"UPDATE_FACTION", "CHAT_MSG_COMBAT_FACTION_CHANGE",
	-- explore
	"MAP_EXPLORATION_UPDATED",
	-- achieve (and Legacy Challenges)
	"ACHIEVEMENT_EARNED", "CRITERIA_UPDATE", "CRITERIA_EARNED",
}) do
	ns.RegisterEvent(event, onUpdateEvent)
end
-- The quest database says which quest collects count the bags (Own.bagCollect).
ns.On("QUESTDB_LOADED", onUpdateEvent)
-- The Hearthstone's cooldown started, ended or the bind moved (QoL/Hearth.lua).
ns.On("QOL_HEARTH_CHANGED", onUpdateEvent)

-- New gear verdicts (equipment, spec, level, item data): `when upgrade`.
ns.On("GEAR_UPDATED", onUpdateEvent)

-- Party progress (Quests/Party.lua): the group's wait holds the live step,
-- its turn-ins and the arrow (Own.partyHold, Own.partyAim).
ns.On("PARTY_PROGRESS", onUpdateEvent)

-- A new answer for every group quest (`when group`, Own.groupAnswer), and
-- deathskips turned on or off (`die` goals, Own.deathskips).
ns.On("SETTING_CHANGED", function(path)
	if path == "behavior.groupQuests" or path == "behavior.deathskips" then requestUpdate() end
end)

-- A quest that left the log while the window asks (Engine.LostQuestion) is
-- answered once the player picks Always go back for it or Always skip it.
ns.On("SETTING_CHANGED", function(path, answer)
	if path ~= "behavior.lostQuests" or (answer ~= "back" and answer ~= "skip") then return end
	local q = Engine.LostQuestion()
	while q do
		Engine.AnswerLost(q, answer)
		local nq = Engine.LostQuestion()
		if nq == q then break end
		q = nq
	end
end)

-- An item or spell going on cooldown: `when cooldown` (Own.onCooldown), once a
-- guide has asked, since SPELL_UPDATE_COOLDOWN comes with every cast.
for _, event in ipairs({ "BAG_UPDATE_COOLDOWN", "SPELL_UPDATE_COOLDOWN" }) do
	ns.RegisterEvent(event, function() if Own.cooldownAsked then requestUpdate() end end)
end

-- Where the player is changed enough to re-pick candidates: a zone change or
-- landing (control comes back after a flight).
local function onContextEvent()
	contextGen = contextGen + 1
	requestUpdate()
end
for _, event in ipairs({ "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "PLAYER_CONTROL_GAINED" }) do
	ns.RegisterEvent(event, onContextEvent)
end

-- Binding during the step completes `sethome nearest`, and a located
-- `sethome` when the innkeeper bound at is its inn's, in every tab. The
-- innkeeper is the open NPC, else the last NPC window closed within 2
-- minutes: the bind confirmation closes the innkeeper's window before the
-- game says the Hearthstone is bound, so the "npc" unit is gone by then
-- (every bind the Recorder saw, #1298), and the bind location's name alone
-- may not read as the goal's place.
ns.RegisterEvent("HEARTHSTONE_BOUND", function()
	if player then
		local npc = Compat().GetNpcID("npc") or openNpc
		if not npc and Own.closedNpc and GetTime() - Own.closedAt < 120 then npc = Own.closedNpc end
		for i = 1, #tabs do
			use(tabs[i])
			latch("sethome", npc)
		end
		useActive()
	end
	requestUpdate()
end)

-- The client fills the quest log after PLAYER_LOGIN; placing a tab waits for
-- the first QUEST_LOG_UPDATE (onUpdateEvent evaluates after it).
ns.RegisterEvent("QUEST_LOG_UPDATE", function() logReady = true end)

-- A quest leaving the log (abandoned, failed, or handed in) may be held
-- (Own.holdLost); taking it again ends that.
ns.RegisterEvent("QUEST_REMOVED", function(_, questID)
	if type(questID) == "number" then Own.removed[questID] = true end
end)
ns.RegisterEvent("QUEST_ACCEPTED", function(_, a, b)
	local q = type(b) == "number" and b or a
	if type(q) == "number" then Own.removed[q], Own.wasFailed[q] = nil, nil end
end)

ns.RegisterEvent("UNIT_QUEST_LOG_CHANGED", function(_, unit)
	if unit == "player" then requestUpdate() end
end)

ns.RegisterEvent("QUEST_TURNED_IN", function(_, questID)
	if questID then turnedIn[questID] = true end
	if questID and player then
		for i = 1, #tabs do
			use(tabs[i])
			Own.latchTurnin(questID)
		end
		useActive()
	end
	Own.clearMarks()
	requestUpdate()
end)

-- The player's own successful casts: `cast` goals (Own.latchCast).
ns.RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spellID)
	local C = Compat()
	spellID = C.Readable(spellID)
	if C.Readable(unit) ~= "player" or type(spellID) ~= "number" or not player then return end
	local hit = false
	for i = 1, #tabs do
		use(tabs[i])
		if Own.latchCast(spellID) then hit = true end
	end
	useActive()
	if hit then requestUpdate() end
end)

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	if type(level) == "number" and level > levelSeen then levelSeen = level end
	Own.clearMarks()
	requestUpdate()
end)

-- kind: "talk" for gossip/quest frames, "train"/"vendor"/"taxi" for those
-- windows. A vendor or flight window is the service itself: it counts at
-- once, for the current step of every open tab (and as talking to that NPC).
-- A trainer window counts as talking to the trainer; its `train` goals wait
-- for a spell learned there (Own.trainerLearned). A gossip or quest window only opens
-- the chat, which proves nothing (#741: an NPC with nothing for the player):
-- a talk goal counts from what the player does in it (Own.talkAct), never
-- from the window opening.
local function onNpcFrame(kind)
	local npc = Compat().GetNpcID("npc")
	openNpc, openKind = npc, kind
	if player and kind ~= "talk" then
		for i = 1, #tabs do
			use(tabs[i])
			if npc then latch("talk", npc) end
			if kind ~= "train" then latch(kind, npc) end
		end
		useActive()
	end
	requestUpdate()
end
local function onTalkFrame() onNpcFrame("talk") end
for _, event in ipairs({ "GOSSIP_SHOW", "QUEST_DETAIL", "QUEST_GREETING", "QUEST_PROGRESS", "QUEST_COMPLETE" }) do
	ns.RegisterEvent(event, onTalkFrame)
end

-- The player's own act at the open NPC: a gossip option picked, a quest
-- accepted, completed or handed in there (the client's calls, post-hooked,
-- and the quest log's QUEST_ACCEPTED / QUEST_TURNED_IN). That is what checks
-- off the NPC's talk goals. Accepting closes the quest window before the
-- quest log says so: an act within 2 seconds of the NPC's window closing
-- still counts for that NPC. (No new main-chunk local: it is at Lua's 200.)
function Own.talkAct()
	local npc = openNpc
	if not npc and Own.closedNpc and GetTime() - Own.closedAt < 2 then npc = Own.closedNpc end
	if not (npc and player) then return end
	local hit = false
	for i = 1, #tabs do
		use(tabs[i])
		hit = latch("talk", npc) or hit
	end
	useActive()
	if hit then requestUpdate() end
end

-- A spell learned while a trainer's window is open: that is training done
-- there (Fitz: a train goal ticks only on a learned spell, never on the
-- window opening). It checks off the step's `train` goals for that trainer
-- (latch: the NPC named, a candidate of the character's class, or a class
-- trainer for `train class`), and at a class trainer of the character's
-- class it is the visit `train class` remembers for the level
-- (Own.nothingToTrain).
function Own.trainerLearned()
	if openKind ~= "train" or not (openNpc and player) then return end
	refreshPlayer()
	if Engine.IsClassTrainer(openNpc) then ns.CharState().classTrainVisit = player.level or 1 end
	for i = 1, #tabs do
		use(tabs[i])
		latch("train", openNpc)
	end
	useActive()
	requestUpdate()
end

-- The open window of a class trainer of the character's class lists nothing
-- the character can learn now (no "available" service): that is the visit
-- `train class` remembers for the level too (Own.nothingToTrain), so a
-- training step never holds the guide when there is nothing new (a Dwarf at
-- 19 in Ironforge held Loch Modan's step, 2026-11-09). With a spell
-- available it waits for the spell learned, as before. Unknown without the
-- client's trainer list, or with its "available" filter off (the list then
-- hides them). On TRAINER_SHOW and TRAINER_UPDATE (the list after a purchase).
function Own.trainerChecked()
	if openKind ~= "train" or not (openNpc and player) or not Engine.IsClassTrainer(openNpc) then return end
	if not (GetNumTrainerServices and GetTrainerServiceInfo) then return end
	if GetTrainerServiceTypeFilter and not GetTrainerServiceTypeFilter("available") then return end
	for i = 1, GetNumTrainerServices() or 0 do
		local _, kind = GetTrainerServiceInfo(i)
		if kind == "available" then return end
	end
	refreshPlayer()
	local s, level = ns.CharState(), player.level or 1
	if tonumber(s.classTrainVisit) == level then return end
	s.classTrainVisit = level
	requestUpdate()
end
if hooksecurefunc then
	for _, name in ipairs({ "SelectOption", "SelectOptionByIndex" }) do
		if C_GossipInfo and type(C_GossipInfo[name]) == "function" then hooksecurefunc(C_GossipInfo, name, function() Own.talkAct() end) end
	end
	for _, name in ipairs({ "SelectGossipOption", "AcceptQuest", "CompleteQuest", "GetQuestReward" }) do
		if type(_G[name]) == "function" then hooksecurefunc(name, function() Own.talkAct() end) end
	end
end
for _, event in ipairs({ "QUEST_ACCEPTED", "QUEST_TURNED_IN" }) do
	ns.RegisterEvent(event, function() Own.talkAct() end)
end

-- Unavailable quests. A gossip, greeting or quest-detail window from an
-- `accept` goal's own giver (current step of any tab) that does not offer
-- its quest marks it unavailable when the data says why (its level not
-- reached, a prerequisite missing); one that offers it clears the mark. A
-- refusal the data does not explain is never a skip (Fitz, #741: a giver the
-- server lacks would take the quest and its later steps out of the guide):
-- the accept stays open, the arrow stays on the giver, and its line says
-- "Not offered by <giver>? Report it with /polestar" (Own.notListed, this
-- session, until the giver's window lists the quest or it is taken). Nor is
-- a refusal while the missing prerequisite is in the log ready to hand in
-- (Own.preReady): the window shows before the hand-in that opens the quest
-- (Regthar Deathgate, Kolkar Leaders then Verog the Dervish, #998). A
-- detail window opened from that giver's list, popped up by a turn-in at
-- that giver (the follow-up quest), or started by an item, says nothing
-- about the others.
local LIST_WINDOW = 30 -- seconds a list or a turn-in covers the detail windows opened from it
local listedAt = {} -- npc -> GetTime() of its last gossip/greeting list or turn-in
Own.notListed = {} -- questID -> the accept goal whose giver's window did not list it

local function unavailableReason(goal)
	local lvl = tonumber(goal.minLevel)
	if lvl and (player.level or 1) < lvl then return "level" end
	if missingPre(goal) then return "pre" end
	return nil
end

-- Whether the prerequisites accept `goal` lacks are in the log, ready to hand
-- in: every missing one of `preAll`, and one of `pre` when none is done.
function Own.preReady(goal)
	local C = Compat()
	if type(goal.preAll) == "table" then
		for _, q in ipairs(goal.preAll) do
			if not questDone(q) and not C.IsQuestReadyForTurnIn(q) then return false end
		end
	end
	if type(goal.pre) == "table" and #goal.pre > 0 then
		for _, q in ipairs(goal.pre) do
			if questDone(q) or C.IsQuestReadyForTurnIn(q) then return true end
		end
		return false
	end
	return true
end

-- A level-up or a turn-in (either can unlock a quest) clears the marks, so
-- the giver's next window decides afresh. A mark whose accept is in a step a
-- tab has moved past is cleared only when the data says the quest has just
-- opened: its level reached and prerequisites done (the guide goes back to
-- it, as for #70). A mark still gated stays, its reason brought up to date
-- (a level reached, a prerequisite still missing).
function Own.clearMarks()
	if not player then
		wipe(unavailable)
		return
	end
	refreshPlayer() -- the new level: UnitLevel can lag PLAYER_LEVEL_UP
	local passed = {}
	for i = 1, #tabs do
		use(tabs[i])
		if guide then
			local stepOf = layoutOf(guide).stepOf
			for q, u in pairs(unavailable) do
				local s = stepOf[u.accept]
				if s and s <= passedUpTo and u.reason ~= "closed" then passed[q] = true end
			end
		end
	end
	useActive()
	for q, u in pairs(unavailable) do
		local now = passed[q] and unavailableReason(u.accept)
		if now then
			u.reason = now
		else
			unavailable[q] = nil
		end
	end
end

function Own.listed(q)
	unavailable[q] = nil
	Own.notListed[q] = nil
end

local function checkOffers(source, startItem)
	if not player then return end
	local C = Compat()
	local npc = C.GetNpcID("npc")
	if not npc then return end
	if source == "detail" then
		if startItem and startItem ~= 0 then return end
		local t = listedAt[npc]
		if t and GetTime() - t < LIST_WINDOW then
			local list = C.GetOfferedQuests("detail")
			if list and list[1] then
				Own.listed(list[1])
				Own.offered[list[1]] = true
			end
			return
		end
	else
		listedAt[npc] = GetTime()
	end
	local list = C.GetOfferedQuests(source)
	if not list then return end
	local offered = {}
	for i = 1, #list do
		offered[list[i]] = true
		Own.listed(list[i])
		Own.offered[list[i]] = true
	end
	-- The window lists a quest just accepted as active a moment before the
	-- quest log has it (#127): taken, not refused.
	local active = source ~= "detail" and C.GetActiveQuests(source) or nil
	for i = 1, active and #active or 0 do
		offered[active[i]] = true
		Own.listed(active[i])
	end
	for i = 1, #tabs do
		use(tabs[i])
		if guide and current then
			for _, goal in ipairs(guide.steps[current].goals) do
				local q = goal.quest
				if goal.t == "accept" and q and (goal.npc == npc or goal.object == npc) and goalApplies(goal)
					and not offered[q] and not C.IsOnQuest(q) and not questDone(q) and not unavailable[q] then
					local why = unavailableReason(goal)
					-- Offered once its prerequisite is handed in: no mark, nothing to report.
					local waits = why == "pre" and Own.preReady(goal)
					if why and not waits then
						unavailable[q] = { reason = why, accept = goal }
					elseif not why then
						Own.notListed[q] = goal
					end
				end
			end
		end
	end
	useActive()
end

ns.RegisterEvent("GOSSIP_SHOW", function() checkOffers("gossip") end)
ns.RegisterEvent("QUEST_GREETING", function() checkOffers("greeting") end)
ns.RegisterEvent("QUEST_DETAIL", function(_, startItem) checkOffers("detail", startItem) end)
ns.RegisterEvent("QUEST_ACCEPTED", function(_, q)
	if type(q) == "number" then Own.listed(q) end
end)
for _, event in ipairs({ "QUEST_COMPLETE", "QUEST_TURNED_IN" }) do
	ns.RegisterEvent(event, function()
		local npc = Compat().GetNpcID("npc")
		if npc then listedAt[npc] = GetTime() end
	end)
end

ns.RegisterEvent("PLAYER_LOGOUT", function() sync() end)

ns.RegisterEvent("TRAINER_SHOW", function()
	onNpcFrame("train")
	noteClassTrainer(openNpc)
	Own.trainerChecked()
end)
ns.RegisterEvent("TRAINER_UPDATE", function() Own.trainerChecked() end)
ns.RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE", function() Own.trainerLearned() end)
ns.RegisterEvent("MERCHANT_SHOW", function() onNpcFrame("vendor") end)

-- The NPC whose window just closed, for an act the client reports after it
-- (Own.talkAct).
local function onNpcFrameClosed()
	if openNpc then Own.closedNpc, Own.closedAt = openNpc, GetTime() end
	openNpc, openKind = nil, nil
end
ns.RegisterEvent("GOSSIP_CLOSED", onNpcFrameClosed)
ns.RegisterEvent("QUEST_FINISHED", onNpcFrameClosed)
ns.RegisterEvent("TRAINER_CLOSED", onNpcFrameClosed)
ns.RegisterEvent("MERCHANT_CLOSED", onNpcFrameClosed)
ns.RegisterEvent("TAXIMAP_CLOSED", onNpcFrameClosed)

ns.RegisterEvent("TAXIMAP_OPENED", function()
	local C = Compat()
	local node = C.GetCurrentTaxiNode()
	if not node then
		local zone, sub = C.GetZoneText()
		node = sub or zone
	end
	if node then fpTable()[node] = true end
	onNpcFrame("taxi")
end)

-- "direct": a `turnin ... direct` goal not done yet, whose quest its giver
-- lists among the quests it offers rather than the ones in the log, so
-- Automation picks it from there. A done one is not wanted: the giver of a
-- repeatable keeps offering it, and a second visit must not hand in again.
local function matchesVerb(goal, verb)
	if verb == "direct" then return goal.t == "turnin" and goal.direct == true end
	return goal.t == verb
end

-- True when an applicable `verb` goal ("accept"/"turnin"/"direct") for questID
-- sits in the live step (or the next `span` applicable steps after it, 0 by
-- default) of any open tab. Automation's gate (Fitz): it acts on the live
-- step, never on a step the player is only looking at (Prev/Next/Goto);
-- ahead of it only a While-you're-here hand-in (Own.hereWants) and an
-- accept of the next steps at the NPC the player talks to (Own.aheadWants).
local function wantsFrom(from, verb, questID, span)
	local left = span + 1
	local steps = guide.steps
	for s = from, #steps do
		local step = steps[s]
		if stepApplies(step) then
			-- A group quest the player has not answered for yet is not taken or handed in for them;
			-- nor is a quest handed in while the group waits on a member (Party.HoldsQuest).
			local waits = Own.groupPending(step)
			for g, goal in ipairs(step.goals) do
				if matchesVerb(goal, verb) and goal.quest == questID and questID ~= waits and goalApplies(goal)
					and not Own.questSkipped(questID)
					and not (verb == "direct" and goalDone(s, g, goal))
					and not (verb ~= "accept" and ns.Party and ns.Party.HoldsQuest(questID)) then
					return true
				end
			end
			left = left - 1
			if left == 0 then break end
		end
	end
	return false
end

local function wantsLoaded(verb, questID, span)
	return guide ~= nil and computed ~= nil and wantsFrom(computed, verb, questID, span)
end

-- "turnin": a While-you're-here hand-in line up for questID in the active
-- tab (#1408): the guide shows it to be handed in now, so Automation hands
-- it in as it would the live step's, with the same rules (a group quest not
-- answered for, a quest the group waits on or one the player left out is
-- not handed in). "take": a pick-up line up for questID whose NPC's window
-- is open, so auto-accept takes it however far on the route takes it.
-- Other accepts ahead: Own.aheadWants.
function Own.hereWants(questID, kind)
	if Own.hereHeld or guide == nil or Own.hereGuide ~= guide or Own.questSkipped(questID)
		or (ns.Party and ns.Party.HoldsQuest(questID)) then return false end
	local npc = kind == "take" and Compat().GetNpcID("npc")
	if kind == "take" and not npc then return false end
	for i = 1, Own.hereOnN do
		local e = Own.hereOn[i]
		local goal = e.goal
		if e.kind == kind and goal.quest == questID and Own.groupPending(guide.steps[e.s]) ~= questID
			and (kind ~= "take" or goal.npc == npc or goal.object == npc) then return true end
	end
	return false
end

function Engine.WantsQuest(verb, questID, span)
	if not questID then return false end
	if not player then refreshPlayer() end
	-- The live step after what just happened: a hand-in that finished the step
	-- whose next one takes the follow-up the game offers at once.
	if scheduled then flush() end
	local found = false
	for i = 1, #tabs do
		use(tabs[i])
		if wantsLoaded(verb, questID, span or 0) then
			found = true
			break
		end
	end
	useActive()
	if not found and verb == "turnin" then found = Own.hereWants(questID, "turnin") end
	if not found and verb == "accept" then found = Own.aheadWants(questID) or Own.hereWants(questID, "take") end
	return found
end

-- Why auto-accept leaves quest q, offered by the NPC whose window is open
-- (Automation's debug log): nil when Engine.WantsQuest("accept", q) holds.
-- The live step's own accepts aside, Own.aheadWants' reason.
function Engine.AcceptRefusal(questID)
	if not questID or questID == 0 then return "no quest id" end
	if Engine.WantsQuest("accept", questID) then return nil end
	local _, why = Own.aheadWants(questID)
	return why or "not wanted"
end

-- Saved tabs of leveling guides an update reworked (Own.reworked), by guide
-- id: the quest log decides where they go (Own.followReworked).
Own.reworkedTabs = {}

-- A saved tab coming back: at the step the player was looking at (a pack
-- update carries it to the step's new place first).
local function restoredTab(g)
	if (g.category == nil or g.category == "Leveling") and Own.reworked(g) then Own.reworkedTabs[g.id] = true end
	Own.withFeeders(g.id)
	g = Guides.Get(g.id) or g
	checkShape(g)
	local pins = ns.CharState().pins
	local p = type(pins) == "table" and pins[g.id]
	return { guide = g, passedUpTo = 0, autoChain = true, sawIncomplete = false, placing = GetTime() + PLACE_SECONDS,
		pin = type(p) == "table" and tonumber(p.step) or nil, pinDone = type(p) == "table" and p.done or nil }
end

-- Once the quest log is in (the client fills it after PLAYER_LOGIN), a tab
-- whose guide an update reworked moves to the leveling guide that has the
-- quests of the log now (Guides.FollowLog), unless that one is open already:
-- a 0.3.4 character at Sun Rock Retreat in Stonetalon Mountains &
-- Ashenvale found the same tab holding Ashenvale & Silverpine Forest, and
-- its Sun Rock quests in The Barrens & Stonetalon Mountains (#1328). The
-- chat says where it went.
function Own.followReworked()
	local moved = {}
	for id in pairs(Own.reworkedTabs) do
		local i = tabIndexOf(id)
		local to = i and Guides.FollowLog(id)
		local g = to and not tabIndexOf(to) and Guides.Get(to)
		if g then
			moved[#moved + 1] = { from = tabs[i].guide, to = g, active = i == activeIndex }
			tabs[i] = restoredTab(g)
		end
	end
	Own.reworkedTabs = {}
	if #moved == 0 then return end
	tabsDirty = true
	useActive()
	persist()
	for _, m in ipairs(moved) do
		ns.Print(L["%s changed in this update and holds other quests now. Its tab moved to %s, which has the quests in your log."]:format(m.from.title, m.to.title))
		if m.active then ns.Fire("GUIDE_CHANGED", m.to.id) end
	end
	evaluate()
end

-- The saved tabs came back before the quest log could be read: once it is,
-- each gets its steps planned (Own.withFeeders) and is placed afresh from the
-- log, as at login; its saved view follows its step, and checkShape carries
-- its saved check-offs and skips over.
function Own.feedTabs()
	sync()
	local changed = false
	for _, t in ipairs(tabs) do
		local id = t.guide.id
		if not Own.feedTried[id] then
			Own.withFeeders(id)
			local g2 = Guides.Get(id)
			if g2 and g2 ~= t.guide and g2.fromBase then
				t.guide = g2
				t.current, t.computed, t.lastSig, t.passedUpTo = nil, nil, nil, 0
				t.pin = t.pin and g2.fromBase[t.pin] or nil
				t.placing = GetTime() + PLACE_SECONDS
				changed = true
			end
		end
	end
	if not changed then return end
	loaded = nil
	useActive()
	tabsDirty = true
	persist()
	announceActive()
	evaluate()
end

-- Plan guide `id`'s steps again (Own.withFeeders) and give its tab the new
-- plan, its place found afresh from the quest log and its view following its
-- step: after an update passed steps behind the player, a quest ahead that
-- needed one of them gets it back on the way, or drops out (Own.goneSource).
function Own.replan(id)
	if not (ns.IsLoggedIn() and Guides.Get(id)) then return end
	Own.withFeeders(id, true)
	local g2 = Guides.Get(id)
	sync()
	local changed = false
	for _, t in ipairs(tabs) do
		if t.guide.id == id and g2 ~= t.guide then
			local map = Own.matchSteps(Own.stepKeys(t.guide), Own.stepKeys(g2))
			t.pin = t.pin and map[t.pin] or nil
			t.guide = g2
			t.current, t.computed, t.lastSig, t.passedUpTo = nil, nil, nil, 0
			t.placing = GetTime() + PLACE_SECONDS
			changed = true
		end
	end
	if not changed then return end
	loaded = nil
	useActive()
	tabsDirty = true
	persist()
	announceActive()
	evaluate()
end

ns.RegisterEvent("QUEST_LOG_UPDATE", function()
	if not ns.IsLoggedIn() then return end
	logReady = true
	if next(Own.reworkedTabs) ~= nil then Own.followReworked() end
	if not Own.feedSwept then
		Own.feedSwept = true
		Own.feedTabs()
		-- The saved tabs are mapped (checkShape at login): the earlier
		-- releases' steps go (Own.legacy).
		Own.legacyDrop()
	end
end)

local function byPlace(list)
	for i, a in ipairs(list) do a.order = i end
	table.sort(list, function(x, y)
		if x.at ~= y.at then return x.at < y.at end
		return x.order < y.order
	end)
	return list
end

-- Reopen the saved tabs (registered and shown guides only, no duplicates, at
-- most MAX_TABS); a guide that was absent returns to its old place, and the
-- tabs of guides still absent stay saved. With none open, one tab with
-- Guides.Suggest(). A fresh start at the bottom of a level bracket whose
-- guide is one of a route choice also offers that choice (the suggested
-- route stays loaded meanwhile).
ns.OnLogin(function()
	fpTable()
	refreshPlayer()
	local s = ns.CharState()
	-- The closed tabs, before anything is saved, so their pins stay.
	for _, c in ipairs(type(s.closedTabs) == "table" and s.closedTabs or {}) do
		local closed = Own.closed
		if type(c) == "table" and type(c.id) == "string" and #closed < Own.MAX_CLOSED and not Own.closedEntry(c.id) then
			closed[#closed + 1] = { id = c.id, at = tonumber(c.at) }
		end
	end
	local ids, seen, back = {}, {}, {}
	local function add(id)
		if type(id) == "string" and not seen[id] and #ids < MAX_TABS and Guides.Get(id) then
			ids[#ids + 1] = id
			seen[id] = true
		end
	end
	local list = type(s.tabs) == "table" and s.tabs or {}
	local absentAt = type(s.absentAt) == "table" and s.absentAt or {}
	for i = 1, MAX_TABS * 2 do
		local id = list[i]
		-- A guide a cutover retired: its successor in its place (Guides.Successor).
		local successor = type(id) == "string" and not Guides.Get(id) and Guides.Successor(id)
		if successor then id = successor end
		if type(id) == "string" and not seen[id] then
			local at = tonumber(absentAt[id])
			if not Guides.Get(id) then
				seen[id] = true
				rememberAbsent(id, at or i)
			elseif at then
				seen[id] = true
				back[#back + 1] = { id = id, at = at }
			else
				add(id)
			end
		end
	end
	for _, b in ipairs(byPlace(back)) do
		if #ids < MAX_TABS then
			table.insert(ids, math.min(math.max(b.at, 1), #ids + 1), b.id)
		else
			rememberAbsent(b.id, b.at)
		end
	end
	local saved = s.guide
	if type(saved) == "string" and not Guides.Get(saved) then saved = Guides.Successor(saved) or saved end
	add(saved) -- saved before tabs existed
	local activeId = s.tabs and list[tonumber(s.activeTab) or 0] or s.guide
	if type(activeId) == "string" and not Guides.Get(activeId) then activeId = Guides.Successor(activeId) or activeId end
	local offerFrom
	if #ids == 0 and ns.Get("behavior.autoSelectGuide") then
		local suggested = Engine.StartingGuide()
		add(suggested)
		if suggested then Own.opened[suggested] = true end -- opened for the player
		local g = suggested and Guides.Get(suggested)
		local from = g and choiceOffering(suggested)
		if from and routesTable()[from.id] == nil and (player.level or 1) <= (g.minLevel or 1) + 1 then offerFrom = from.id end
	end
	if #ids == 0 then
		persist()
		return
	end
	for i = 1, #ids do
		tabs[i] = restoredTab(Guides.Get(ids[i]))
		if ids[i] == activeId then activeIndex = i end
	end
	if activeIndex == 0 then activeIndex = 1 end
	-- Older saves kept "not offered" marks across a logout; no mark is kept now.
	s.offers = nil
	useActive()
	persist()
	tabsDirty = true
	ns.Fire("GUIDE_CHANGED", guide.id)
	evaluate()
	if offerFrom then ns.Fire("ROUTE_CHOICE", offerFrom) end
end)

-- A pack switched off (or on): tabs whose guide is gone close and stay saved
-- where they were; saved tabs whose guide is back reopen there, up to the
-- tab limit, at their pinned step.
ns.On("PACKS_CHANGED", function()
	if not ns.IsLoggedIn() then return end
	sync()
	-- A guide registered again in its place (an import updated on the Import
	-- page): its tab takes the new guide where it stands, at the step the
	-- player was looking at, as a reload would bring it back (checkShape
	-- carries ticks and skips to the steps it kept).
	local replacedActive, replaced = false, false
	for i = 1, #tabs do
		local g = Guides.Get(tabs[i].guide.id)
		if g and g ~= tabs[i].guide then
			tabs[i] = restoredTab(g)
			replaced = true
			if i == activeIndex then replacedActive = true end
		end
	end
	if replaced then
		tabsDirty = true
		useActive()
		persist()
		if replacedActive then ns.Fire("GUIDE_CHANGED", guide.id) end
		evaluate()
	end
	-- Tabs whose guide is gone close together and become absent at their
	-- place before anything is saved, so their pins stay. The active tab, if
	-- it goes, hands over to its right neighbour (else the left), as CloseTab.
	local activeTab, activeGone, before = tabs[activeIndex], false, 0
	local gone = {}
	for i = #tabs, 1, -1 do
		local id = tabs[i].guide.id
		if not Guides.Get(id) then
			if i == activeIndex then activeGone = true elseif i < activeIndex then before = before + 1 end
			table.insert(gone, 1, { id = id, at = i })
			table.remove(tabs, i)
		end
	end
	if #gone > 0 then
		for _, t in ipairs(gone) do rememberAbsent(t.id, t.at) end
		tabsDirty = true
		if activeGone then
			activeIndex = math.min(activeIndex - before, #tabs)
		else
			for i = 1, #tabs do
				if tabs[i] == activeTab then activeIndex = i end
			end
		end
		useActive()
		persist()
		if activeGone then announceActive() end
		evaluate()
	end
	local back = {}
	for _, a in ipairs(absent) do
		if Guides.Get(a.id) then back[#back + 1] = { id = a.id, at = a.at } end
	end
	if #back == 0 then return end
	local activeTab = tabs[activeIndex]
	local opened = false
	for _, b in ipairs(byPlace(back)) do
		if #tabs >= MAX_TABS then break end
		if not tabIndexOf(b.id) then
			table.insert(tabs, math.min(math.max(b.at, 1), #tabs + 1), restoredTab(Guides.Get(b.id)))
			opened = true
		end
	end
	if not opened then
		persist()
		return
	end
	tabsDirty = true
	activeIndex = 1
	for i = 1, #tabs do
		if tabs[i] == activeTab then activeIndex = i end
	end
	useActive()
	persist()
	if not activeTab then announceActive() end
	evaluate()
end)
