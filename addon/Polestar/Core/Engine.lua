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
	autoNextGuide = true,
	autoSelectGuide = true,
	skipGrey = false,
	warnClosing = false, -- name what an offered quest closes for good, and leave its accept to the player (Closes.lua)
	routeChoice = "ask", -- "ask" | "recommended": what happens where a guide offers several next zones
	trainReminder = "2", -- "2" | "1" | "off": remind to visit the class trainer every 2 levels, every level, never
	suggestFrom = "guides", -- pack id the suggestions come from (Guides.SuggestSource); ours fill in
})

local outleveled = {} -- guideId -> true, GUIDE_OUTLEVELED once per session

local Engine = {}
ns.Engine = Engine

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
	if levelSeen > (player.level or 0) then player.level = levelSeen end
end

local function stepApplies(step)
	return Guides.Matches(step.only, player)
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

-- Quests a guide or any guide after it (via `next` and every route choice)
-- still needs at a character level: the prerequisites (`pre`, `preAll`) of
-- every accept that is not grey at that level, and of every accept a needed
-- quest's own accept is, down the chain (a grey Buzzbox 827 opens the Buzzbox
-- quests that still give full experience). A quest's own turn-in and
-- objectives are not a need: they go with its accept. Each needed quest maps
-- to the accept that is not grey it leads to, the nearest down the chain
-- (the first in guide order among equals). Cached per guide and level.
local chainNeedsCache = setmetatable({}, { __mode = "k" })
local function chainNeeds(g, level)
	local byLevel = chainNeedsCache[g]
	if not byLevel then
		byLevel = {}
		chainNeedsCache[g] = byLevel
	end
	local set = byLevel[level]
	if set then return set end
	local C = Compat()
	-- Every accept down the chain: quest -> its prerequisite lists; open: the
	-- accepts that are not grey, needed as they are.
	local pres, open = {}, {}
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
						for _, key in ipairs({ "pre", "preAll" }) do
							if type(goal[key]) == "table" then list[#list + 1] = goal[key] end
						end
						if not (goal.qlvl and C.IsQuestTrivial(tonumber(goal.qlvl), level)) then open[#open + 1] = goal end
					end
				end
			end
			for _, id in ipairs(cur.nextChoices or { cur.next }) do
				local nxt = Guides.Get(id)
				if nxt then queue[#queue + 1] = nxt end
			end
		end
	end
	-- Breadth first from every open accept at once: a quest's nearest open
	-- accept is the one that reached it first.
	set = {}
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
	byLevel[level] = set
	return set
end

-- behavior.skipGrey: an accept for a quest already grey for the character,
-- not taken yet and not a prerequisite of a quest later in the guide or its
-- chain, no longer applies (status "na", never blocks, never auto-accepted);
-- its turn-in and objectives go with it (orphaned). greyNeed gives false for
-- such an accept; for a grey accept that is not taken yet but kept, the open
-- accept it leads to; nil when the setting is off or the accept is not grey
-- and open.
local function greyNeed(goal)
	if goal.t ~= "accept" or not goal.qlvl or not ns.Get("behavior.skipGrey") then return nil end
	local C = Compat()
	local level = player.level or 1
	if not C.IsQuestTrivial(tonumber(goal.qlvl), level) then return nil end
	local q = goal.quest
	if C.IsOnQuest(q) or questDone(q) then return nil end
	return chainNeeds(guide, level)[q] or false
end

-- Per guide: each goal's step index, and each quest's accept and turn-in
-- goals ({ s, key = "s:g", step, goal }).
local NONE = {}
local layoutCache = setmetatable({}, { __mode = "k" })
local function layoutOf(g)
	local l = layoutCache[g]
	if l then return l end
	l = { stepOf = {}, accepts = {}, turnins = {} }
	for s, step in ipairs(g.steps) do
		for gi, goal in ipairs(step.goals) do
			l.stepOf[goal] = s
			local by = goal.quest and (goal.t == "accept" and l.accepts or goal.t == "turnin" and l.turnins)
			if by then
				local list = by[goal.quest]
				if not list then
					list = {}
					by[goal.quest] = list
				end
				list[#list + 1] = { s = s, key = s .. ":" .. gi, step = step, goal = goal }
			end
		end
	end
	layoutCache[g] = l
	return l
end

-- A turn-in, complete or objective goal for a quest the character neither
-- has nor has done, and that this guide does not (for this character) accept
-- at or before that step, in a step the player has not skipped, with an
-- accept that is not optional, not left out as grey nor checked off: it was
-- picked up on another route, or skipped, or ticked without being taken, so it
-- cannot be done here and no longer applies. An `optional` accept the player
-- did not take is the same: its turn-in holds only those who took the quest.
-- Taking the quest brings the goals back.
-- A `turnin ... direct` has no accept by definition: it is handed in from the
-- giver's own window, so it is never orphaned.
local function orphaned(goal)
	local q = goal.quest
	if not q or goal.t == "accept" or goal.direct or not guide then return false end
	local C = Compat()
	if C.IsOnQuest(q) or questDone(q) then return false end
	local l = layoutOf(guide)
	local s = l.stepOf[goal]
	if not s then return false end
	local skipped = ns.CharState().skipped[guide.id]
	local manual = ns.CharState().manual[guide.id]
	for _, a in ipairs(l.accepts[q] or NONE) do
		if a.s <= s and not a.goal.optional and not (skipped and skipped[a.s]) and not (manual and manual[a.key])
			and Guides.Matches(a.step.only, player) and Guides.Matches(a.goal.only, player) and greyNeed(a.goal) ~= false then
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
-- shows them. (Inline: the main chunk is at Lua's 200 locals.)
local function goalApplies(goal)
	if not Guides.Matches(goal.only, player) then return false end
	if goal.profLine or goal.profName then
		local C = Compat()
		local q = goal.quest
		if C.GetSkillRank and C.Supports("skill") and not (q and (C.IsOnQuest(q) or questDone(q))) then
			local rank = goal.profLine and C.GetSkillRank(goal.profLine)
			if not rank and goal.profName then rank = C.GetSkillRank(goal.profName) end
			if (rank or 0) < (goal.profRank or 1) then return false end
		end
	end
	return greyNeed(goal) ~= false and not orphaned(goal)
end

-- The player's own word: goal skips, the current goal, header arrival, the
-- saved view, state carried over pack updates. One table (Lua 5.1 caps a
-- chunk at 200 locals), which also holds the Engine's other private helpers.
local Own = {}

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

-- Per quest, a goal's unavailable mark or nil. Known in advance when an
-- accept of the quest in this guide is closed for good (reason "closed"): one
-- of its `closedBy` (the quest a breadcrumb leads to, or one exclusive with
-- it) is in the log or done, so the giver never offers it again. Else the mark
-- its giver's window left this session. Else, also known in advance, "pre":
-- the accept lacks a prerequisite the route no longer brings (Own.preBlocked),
-- a mark that goes the moment that prerequisite is done. `depth`: how far
-- Own.coming has followed a chain of prerequisites.
local function unavailableFor(goal, depth)
	local q = goal.quest
	if not q then return nil end
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
	-- A chain followed this deep (or looping in the data) proves nothing.
	if u or Own.offered[q] or (depth or 0) > 8 then return u end
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
-- every goal of p in the guide is for other characters (`only`): another
-- race's or class's version of the chain, whose own the data does not list
-- (Emphasis on Sacrifice names the Human Lord Grayson Shadowbreaker, 7638,
-- not the Dwarf's 7670).
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
	local accepts = l.accepts[p] or NONE
	for _, t in ipairs(accepts) do
		if stepApplies(t.step) and Guides.Matches(t.goal.only, player) then return false end
	end
	return #turnins + #accepts > 0
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

function Own.findGate(g, level)
	local s = ns.CharState()
	local sk, ticks = s.skipped[g.id], s.manual[g.id]
	if (type(sk) == "table" and next(sk)) or (type(ticks) == "table" and next(ticks)) then return nil end
	local C = Compat()
	for _, step in ipairs(g.steps) do
		for _, goal in ipairs(step.goals) do
			local q = goal.quest
			if q and (C.IsOnQuest(q) or questDone(q)) then return nil end
		end
	end
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

local MANUAL = { talk = true, hearth = true, getfp = true, fly = true, train = true, vendor = true }

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
	if MANUAL[t] then return true end
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
local UNMEASURED = 1e9
local PLANNED = 8
local RUN_SPEED = 7 -- yards per second, unmounted

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
	p = { list = list, i = #list > 0 and 1 or 0, gen = contextGen }
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
-- Alternatives (`alt`): other places the target spawns. The automatic picks
-- above never choose one; moving on by hand walks them too, so every place
-- is reachable, and one picked that way holds like any other current spot.
---------------------------------------------------------------------------

local Spots = {
	SWITCH = 40, -- yards
	LEAVE = 4, -- yards past the arrival radius
	FORGET = 300, -- seconds a visited spot is skipped
	chosen = setmetatable({}, { __mode = "k" }), -- goal -> chosen spot
	pinned = setmetatable({}, { __mode = "k" }), -- goal -> spot picked by hand, until reached
	seen = setmetatable({}, { __mode = "k" }), -- spot -> GetTime() of the last visit
	world = setmetatable({}, { __mode = "k" }), -- spot -> { c, wx, wy } | false
}

-- Yards from the player to a spot's edge (0 inside), nil on another continent.
function Spots.edge(goal, s, c, px, py)
	local w = Spots.world[s]
	if w == nil then
		local sc, wx, wy = Compat().MapToWorld(goal.map, s.x, s.y, goal.f)
		w = sc and { sc, wx, wy } or false
		Spots.world[s] = w
	end
	if not (w and w[1] == c) then return nil end
	local d = ((w[2] - px) ^ 2 + (w[3] - py) ^ 2) ^ 0.5 - (s.r or 0)
	return d > 0 and d or 0
end

-- Re-pick a goal's spot from the player's world position (c nil: unknown).
-- moveOn: leave the current spot (CycleSpot marked it visited first); spots
-- visited lately are then skipped for camps too, so cycling walks them all.
-- True if the spot changed.
function Spots.repick(goal, c, px, py, moveOn)
	local now, spread, reach = GetTime(), goal.spread, goal.r or DEFAULT_RADIUS
	local spots = goal.spots
	local cur = Spots.chosen[goal]
	if cur and not c and not moveOn then return false end
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
		if not (moveOn and s == cur) and (moveOn or not s.alt) then
			if fresh(s) then
				local d = c and Spots.edge(goal, s, c, px, py)
				local key = d or (1e9 + (i - at - 1) % #spots)
				if not bestKey or key < bestKey then best, bestKey = s, key end
			elseif not oldT or Spots.seen[s] < oldT then
				old, oldT = s, Spots.seen[s]
			end
		end
	end
	best = best or old
	local new = cur
	if best and (moveOn or not cur or not fresh(cur) or not curD or bestKey < curD - Spots.SWITCH) then new = best end
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

local function isCandidate(goal, npc)
	for _, c in ipairs(goal.candidates) do
		if c.npc == npc then return true end
	end
	return false
end

-- Goals whose live condition can stop holding after the step is passed
-- (leaving the zone, rebinding, selling the items, walking away). Their done
-- state is stored once the route moves past them, so the guide never jumps
-- back; quest goals stay live on purpose (abandoning reopens the step).
local function latchable(goal)
	local t = goal.t
	return t == "goto" or t == "explore" or t == "sethome" or t == "hearth" or t == "fly" or t == "getfp"
		or t == "buy" or (t == "collect" and not goal.quest) or (t == "craft" and craftMode(goal) == "count")
		or (t == "train" and goal.class == true)
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

-- Objective goals: done when objective `oi` is finished or the quest is ready
-- for turn-in or turned in. Returns done, cur, max.
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
		local o = objs[goal.oi]
		if o then cur, max, finished = o.numFulfilled, o.numRequired, o.finished end
	end
	if C.IsQuestReadyForTurnIn(q) then return true, cur, max end
	return finished and true or false, cur, max
end

-- A `complete` goal's quest in the log: its objectives' counts summed, each
-- capped at what it needs ("Plainstrider Meat 3/7, Feathers 5/7": 8/14), and
-- with `open`, when it has more than one, the open ones in the game's words
-- ("Plainstrider Meat: 3/7"; the count alone says it for one). Nil when the
-- quest is not in the log. (On Own: the main chunk is at 200 locals.)
function Own.completeState(q, open)
	local objs = Compat().GetQuestObjectives(q)
	if not objs then return nil end
	local cur, max, list = 0, 0, nil
	for i = 1, #objs do
		local o = objs[i]
		max = max + o.numRequired
		cur = cur + math.min(o.numFulfilled, o.numRequired)
		if open and #objs > 1 and not o.finished and o.text ~= "" then
			local text = o.text
			if not text:find("%d+%s*/%s*%d+") then text = ("%s %d/%d"):format(text, o.numFulfilled, o.numRequired) end
			list = list or {}
			list[#list + 1] = text
		end
	end
	return cur, max, list
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

-- done, cur, max[, label, kind] for goal g of step s. Notes are never done
-- (and never block). A stored check-off (the player's tick, or a result the
-- Engine latched) is done whatever the live state says.
goalDone = function(s, g, goal)
	local t = goal.t
	local C = Compat()
	if checked(s, g) then return true end
	if t == "accept" then
		return C.IsOnQuest(goal.quest) or questDone(goal.quest)
	elseif t == "turnin" then
		-- `direct`: only its latched QUEST_TURNED_IN (checked above) or the
		-- completed flag. The session's turn-ins would close every later goal
		-- of a repeatable at the first hand-in; one hand-in closes one goal.
		if goal.direct then return C.IsQuestCompleted(goal.quest) and true or false end
		return questDone(goal.quest) and true or false
	elseif t == "complete" then
		if questDone(goal.quest) or C.IsQuestReadyForTurnIn(goal.quest) then return true end
		local cur, max = Own.completeState(goal.quest)
		return false, cur, max
	elseif t == "kill" or t == "interact" or t == "use" then
		if goal.quest then return objectiveState(goal) end
		return false
	elseif t == "collect" then
		if goal.quest then return objectiveState(goal) end
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
	elseif t == "talk" or t == "train" or t == "vendor" then
		-- Interactions during the step are stored as check-offs (see latch).
		return false
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
	elseif t == "hearth" or t == "fly" then
		if inPlace(goal) then return true end
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
		return (player.level or 1) >= goal.level
	elseif t == "skill" then
		if isManual(goal) then return false end
		return skillState(goal, goal.level)
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
	elseif t == "achieve" then
		if isManual(goal) then return false end
		return achieveState(goal)
	end
	return false -- note
end

local function blocks(goal)
	return goal.t ~= "note" and not goal.optional
end

local function stepDone(s)
	local goals = guide.steps[s].goals
	for g = 1, #goals do
		local goal = goals[g]
		if blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(s, g, goal) then return false end
	end
	return true
end

-- Bag-count goals (non-quest buy/collect, count-mode craft), latched within
-- their own step so using the items up does not reopen it.
local function isBagCount(goal)
	return goal.t == "buy" or (goal.t == "collect" and not goal.quest)
		or (goal.t == "craft" and craftMode(goal) == "count")
end

-- Quest goals checked live from the quest log.
local QUEST_VERBS = { accept = true, turnin = true, complete = true }
local function isQuestGoal(goal)
	return goal.quest and (QUEST_VERBS[goal.t] or goal.t == "kill" or goal.t == "collect"
		or goal.t == "interact" or goal.t == "use")
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
local function anchorStep()
	local steps = guide.steps
	for s = #steps, 1, -1 do
		local step = steps[s]
		if not step.only then
			for g, goal in ipairs(step.goals) do
				if not goal.only and not goal.optional and isQuestGoal(goal) and goalApplies(goal) then
					local done, cur = goalDone(s, g, goal)
					if done or (goal.oi and (cur or 0) > 0) then return s end
				end
			end
		end
	end
	return 0
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
--   within HERE yards of the start step's work: no travel needed.
-- Soft goals passed are latched. So soft steps never hold the player behind
-- quest work done further on, yet a fresh guide still begins with its
-- travel and training stops.
local function place()
	local steps, C = guide.steps, Compat()
	local level = player.level or 1
	local sk = skippedFor(guide.id)
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
	local start
	for s = 1, #steps do
		if stepApplies(steps[s]) and not (sk and sk[s]) and not stepDone(s) then
			local started, doable = false, false
			for g, goal in ipairs(steps[s].goals) do
				if open(s, g, goal) then
					if goal.t == "accept" then
						doable = doable or not gated(goal)
					elseif isQuestGoal(goal) and C.IsOnQuest(goal.quest) then
						started = true
					end
				end
			end
			if not start and (started or doable) then start = s end
		end
	end
	local anchor = anchorStep()
	local limit = start or anchor
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
	for s = 1, limit - 1 do
		if stepApplies(steps[s]) and not (sk and sk[s]) and not stepDone(s) then
			local goals, passes = steps[s].goals, true
			for g, goal in ipairs(goals) do
				local t = goal.t
				if open(s, g, goal) and not gated(goal)
					and not (s < anchor and (isManual(goal) or latchable(goal) or isBagCount(goal)))
					and not (here and (t == "goto" or t == "fly" or t == "hearth" or t == "explore")) then
					passes = false
					break
				end
			end
			if passes then
				local m = manualFor(guide.id, true)
				for g, goal in ipairs(goals) do
					if open(s, g, goal) then
						local why = gated(goal)
						if why then
							unavailable[goal.quest] = { reason = why, accept = goal }
						else
							m[s .. ":" .. g] = true
						end
					end
				end
			end
		end
	end
end

-- First applicable, not skipped, not done step, after placing the tab when
-- it was just loaded (place). During play soft steps hold as usual, so a
-- quest taken out of order never jumps a training stop.
local function computeCurrent()
	if placing then place() end
	local steps = guide.steps
	local sk = skippedFor(guide.id)
	for s = 1, #steps do
		if stepApplies(steps[s]) and not (sk and sk[s]) and not stepDone(s) then return s end
	end
	return nil
end

-- Store the live-done latchable goals of steps from..to (steps the route has
-- just moved past).
local function latchPassed(from, to)
	local steps = guide.steps
	for s = from, to do
		local step = steps[s]
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

local function latchInStep(s)
	local step = guide.steps[s]
	if not stepApplies(step) then return end
	for g, goal in ipairs(step.goals) do
		if isBagCount(goal) and goalApplies(goal) and not checked(s, g) and goalDone(s, g, goal) then
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
	if unavailableFor(goal) or Own.goalSkipped(s, g) then return "skipped", cur, max, label, kind end
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

-- Applicable, not skipped, not done, and blocking.
local function stillBlocks(s, g, goal)
	return blocks(goal) and goalApplies(goal) and not unavailableFor(goal) and not goalDone(s, g, goal)
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
		local pending = 0
		for _, g in ipairs(grp.goals) do
			local goal = goals[g]
			if stillBlocks(s, g, goal) then pending = pending + 1 end
			if not grp.map and goalApplies(goal) then
				local map, x, y, f, _, z = posOf(goal)
				if map and x and y then grp.map, grp.x, grp.y, grp.f, grp.z = map, x, y, f, z end
			end
		end
		grp.pending, grp.done = pending, pending == 0
		if not focus and pending > 0 then focus = grp.index end
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
	local a = u.accept
	if u.reason == "closed" then return L["No longer offered: you took %s"]:format(titleOfQuest(u.by, a.preTitles)) end
	if u.reason == "level" then return L["Requires level %d"]:format(tonumber(a.minLevel) or 0) end
	if u.reason == "pre" then
		local pre = u.pre or missingPre(a)
		if pre then return L["Requires %s first"]:format(titleOfQuest(pre, a.preTitles)) end
	end
	local N = ns.Names
	return L["Not offered by %s"]:format(N.Npc(a.npc) or a.npcName or N.Object(a.object) or a.objName or L["the quest giver"])
end

-- A translated pattern (L["from %s"]) filled with value; nil without one.
local function fmt(pattern, value)
	if not value then return nil end
	return pattern:format(value)
end

-- verb, subject, subjectKind, detail. An accept above the character's level
-- says from which level (an attunement's quests stay in its guide until then).
-- Quests, NPCs, objects and items are named in the client's language where
-- Polestar.Names has them, else as the guide names them.
local function describe(goal)
	local t = goal.t
	local C = Compat()
	local N = ns.Names
	-- A place goal's area (`area`) as the client names it, in its language.
	local place = C.GetAreaName and C.GetAreaName(goal.area) or nil
	if t == "accept" then
		local detail = fmt(L["from %s"], N.Npc(goal.npc) or goal.npcName or N.Object(goal.object) or goal.objName or N.Item(goal.item) or goal.itemName)
		local lvl = tonumber(goal.minLevel)
		if lvl and player and (player.level or 1) < lvl then
			detail = detail and L["%s, from level %d"]:format(detail, lvl) or L["From level %d"]:format(lvl)
		end
		return L["Accept"], questTitle(goal), "quest", detail
	elseif t == "turnin" then
		return L["Turn in"], questTitle(goal), "quest", fmt(L["at %s"], N.Npc(goal.npc) or goal.npcName or N.Object(goal.object) or goal.objName)
	elseif t == "complete" then
		return L["Complete"], questTitle(goal), "quest", nil
	elseif t == "kill" then
		return L["Kill"], N.Npc(goal.npc) or goal.target, "npc", goal.quest and fmt(L["for %s"], questTitle(goal)) or nil
	elseif t == "collect" then
		local item = N.Item(goal.item) or goal.itemName
		if goal.quest then return L["Collect"], item, "item", fmt(L["for %s"], questTitle(goal)) end
		local _, npcName = npcOf(goal)
		return L["Collect"], item, "item", fmt(L["from %s"], npcName)
	elseif t == "goto" then
		local mapName = C.GetMapName(goal.map)
		if place or goal.text then return L["Go to"], place or goal.text, "place", mapName end
		local lx, ly = liveXY(goal)
		return L["Go to"], ("%.1f, %.1f"):format(lx or goal.x, ly or goal.y), "place", mapName
	elseif t == "talk" then
		return L["Talk to"], N.Npc(goal.npc) or goal.npcName, "npc", nil
	elseif t == "interact" then
		return L["Click"], N.Object(goal.object) or goal.objName, "object", goal.quest and fmt(L["for %s"], questTitle(goal)) or nil
	elseif t == "use" then
		return L["Use"], N.Item(goal.item) or goal.itemName, "item", goal.quest and fmt(L["for %s"], questTitle(goal)) or nil
	elseif t == "sethome" then
		local _, npcName = npcOf(goal)
		if goal.location then return L["Set your home to"], place or goal.location, "place", fmt(L["at %s"], npcName) end
		return L["Set your home at"], npcName or L["the nearest inn"], npcName and "npc" or "text", nil
	elseif t == "hearth" then
		return L["Hearth to"], place or goal.location, "place", nil
	elseif t == "getfp" then
		return L["Get the flight path at"], place or N.Taxi(goal.node) or goal.location, "place", fmt(L["from %s"], N.Npc(goal.npc) or goal.npcName)
	elseif t == "fly" then
		return L["Fly to"], place or N.Taxi(goal.node) or goal.location, "place", nil
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
		return L["Reach level"], tostring(goal.level), "level", nil
	elseif t == "skill" then
		return L["Raise"], skillName(goal), "skill", fmt(L["to %d"], goal.level)
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
	end
	return "", goal.text or "", "text", nil -- note
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
-- `inText` when the text names it.
local function goalText(goal, verb, subject, detail)
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
	local verb, subject, kind, detail = describe(goal)
	local npc, npcName = npcOf(goal)
	local map, x, y, f, _, z = posOf(goal)
	local alternatives
	if goal.candidates then
		local n = #pickFor(goal).list
		alternatives = n > 0 and n - 1 or 0
	end
	local unavail = status == "skipped" and unavailableFor(goal) or nil
	local text, src = goalText(goal, verb, subject, detail)
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
		note = goal.note,
		map = map, x = x, y = y, f = f, z = z,
		quest = goal.quest, oi = goal.oi, npc = npc, npcName = npcName, item = goal.item,
		alternatives = alternatives,
		spots = goal.spots and #goal.spots or nil, spread = goal.spread or nil,
		lvl = goal.candidates and chosen(goal) and chosen(goal).lvl or nil,
		unavailable = unavail and unavail.reason or nil,
		unavailableText = unavail and unavailableText(unavail) or nil,
		skippedGrey = need == false or nil,
		keptGrey = opens and opens.quest or nil,
		keptGreyText = opens and L["Grey, kept: opens %s"]:format(questTitle(opens)) or nil,
		skillLine = goal.skillLine, spell = goal.spell, faction = goal.faction,
		standing = goal.standing, standingName = goal.standing and standingName(goal.standing) or nil,
		achievement = goal.achievement, criteria = goal.criteria,
		rewards = goal.rewards,
		objectives = goal.t == "complete" and (status == "active" or status == "pending") and select(3, Own.completeState(goal.quest, true)) or nil,
		-- Group content (compiled `group`: elite, dungeon, raid or an author's
		-- group size); `group` above is the goal's field group.
		party = type(goal.group) == "table" and type(goal.group.kind) == "string" and goal.group or nil,
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
local function waypointOf(g, goal)
	local map, x, y, f, area, z = posOf(goal)
	if not (map and x and y) or not goalApplies(goal) or unavailableFor(goal) or Own.goalSkipped(current, g)
		or goalDone(current, g, goal) then return nil end
	local verb, subject, _, detail = describe(goal)
	local many = area and #goal.spots > 1
	return {
		map = map, x = x, y = y, f = f, z = z,
		label = (goalText(goal, verb, subject, detail)),
		stepIndex = current, goalIndex = g, kind = goal.t,
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
-- optional one; the group's header only when nothing else is open. Returns
-- its index (or nil) and the open header's index (or nil).
function Own.currentGoal(s, groups, focus)
	local grp = focus and groups[focus]
	if not grp then return nil end
	local step = guide.steps[s]
	local header, optional
	for _, g in ipairs(grp.goals) do
		local goal = step.goals[g]
		if goal.t ~= "note" and goalApplies(goal) and not unavailableFor(goal) and not Own.goalSkipped(s, g)
			and not goalDone(s, g, goal) then
			if Own.isHeader(step, goal, grp) then
				header = header or g
			elseif not goal.optional then
				return g, header or Own.headerOf(s, grp, g)
			else
				optional = optional or g
			end
		end
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

-- The arrow's goal: the one the player chose in the current step (a row
-- click, the next spot), while it is open; else the current goal's own place;
-- else the header's; else the focus group's first open located goal
-- (blocking, then optional, then notes). The arrow only ever points at a goal
-- the guide window shows. A done step (no focus, e.g. viewed with Prev) has
-- nothing to point at, even when optional goals are left open; nor has a
-- Class guide the character cannot start yet (Own.startGate), on its live step.
local function findWaypoint()
	if not current or (current == computed and Own.startGate(guide)) then return nil end
	local goals = guide.steps[current].goals
	if aim then
		for g, goal in ipairs(goals) do
			if goal == aim then
				local wp = waypointOf(g, goal)
				if wp then return wp end
			end
		end
	end
	local groups, focus = stepGroups(current)
	local grp = focus and groups[focus]
	if not grp then return nil end
	local cg, header = Own.currentGoal(current, groups, focus)
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
function Own.stepKeys(g)
	local keys = {}
	for s, part in ipairs(Own.stepParts(g)) do keys[s] = Own.hash(part) end
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

-- Move guide `id`'s check-offs ("s:g"), skips (s, "s:g") and saved view to
-- the new step numbers; entries of steps not kept are dropped.
function Own.remap(id, map)
	local s = ns.CharState()
	local function moved(k)
		if type(k) == "number" then return map[k] end
		local a, b = tostring(k):match("^(%d+):(%d+)$")
		local j = a and map[tonumber(a)]
		return j and (j .. ":" .. b) or nil
	end
	for _, field in ipairs({ "manual", "skipped" }) do
		local old = s[field][id]
		if type(old) == "table" then
			local out = {}
			for k, v in pairs(old) do
				local nk = moved(k)
				if nk then out[nk] = v end
			end
			s[field][id] = next(out) and out or nil
		end
	end
	local p = type(s.pins) == "table" and s.pins[id]
	if p then s.pins[id] = type(p) == "table" and map[p.step] and { step = map[p.step], done = p.done } or nil end
end

local function checkShape(g)
	local s = ns.CharState()
	if type(s.shapes) ~= "table" then s.shapes = {} end
	if type(s.stepKeys) ~= "table" then s.stepKeys = {} end
	local h = shapeOf(g)
	local stored = s.shapes[g.id]
	if stored ~= nil and stored ~= h then
		local old = s.stepKeys[g.id]
		-- Saved before step keys existed: nothing to match them by, all dropped.
		Own.remap(g.id, type(old) == "table" and Own.matchSteps(old, Own.stepKeys(g)) or {})
	end
	s.shapes[g.id] = h
	if stored ~= h or type(s.stepKeys[g.id]) ~= "table" then s.stepKeys[g.id] = Own.stepKeys(g) end
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

-- CharState().tabs = { guideId, ... } (open tabs, then the absent ones),
-- .absentAt = { [guideId] = place }, .activeTab, and .guide (the active
-- tab's guide, as before tabs existed). Saved views (pins) are kept for open
-- and absent guides only. A guide open in a tab is never absent too: however
-- it got into the tab (OpenTab, SetGuide, a `next` chain, a route choice),
-- its absent entry goes here, so closing it later forgets it.
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
	s.tabs = ids
	s.absentAt = at
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
		if stepApplies(step) then
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

local function isArrivalGoal(goal) return goal.t == "goto" or goal.t == "explore" end

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

-- Loaded tab: mark arrived goals of the current step; true if any. A "Go to"
-- naming its step is the area the step's work is in: reaching the place of
-- any other goal of the step (where the arrow leads) arrives there too.
local function arriveLoaded(c, px, py)
	if not (guide and current) then return false end
	local step = guide.steps[current]
	local goals = step.goals
	local hit = false
	for g = 1, #goals do
		local goal = goals[g]
		if isArrivalGoal(goal) and not arrived[goal] and goalApplies(goal) then
			local gc, gx, gy = goalWorld(goal)
			local dx, dy, r = (gx or 0) - px, (gy or 0) - py, goal.r or DEFAULT_RADIUS
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

local function checkArrival()
	if #tabs == 0 then return end
	local c, px, py = Compat().GetPlayerWorldPosition()
	if not c then return end
	local hit = false
	for i = 1, #tabs do
		use(tabs[i])
		if arriveLoaded(c, px, py) then hit = true end
	end
	useActive()
	local sg = Spots.waypointGoal()
	if sg and Spots.repick(sg, c, px, py) then hit = true end
	if hit then requestUpdate() end
end

local function needsArrival()
	if not (guide and current) then return false end
	local goals = guide.steps[current].goals
	for g = 1, #goals do
		local goal = goals[g]
		if isArrivalGoal(goal) and goalApplies(goal) and not goalDone(current, g, goal) then return true end
	end
	return false
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
	if not need then need = Spots.waypointGoal() ~= nil end
	if need and not ticker then
		ticker = C_Timer.NewTicker(ARRIVAL_POLL, checkArrival)
	elseif not need and ticker then
		ticker:Cancel()
		ticker = nil
	end
end

---------------------------------------------------------------------------
-- Evaluation
---------------------------------------------------------------------------

local sigParts = {}

local function signature()
	local n = 0
	if current then
		-- A gate opening (level-up, turn-in) changes the view, not the step.
		n = n + 1
		sigParts[n] = Own.startGate(guide) and "gated" or "open"
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
			end
		end
		local _, focus = stepGroups(current)
		n = n + 1
		sigParts[n] = "focus" .. tostring(focus)
	end
	for i = #sigParts, n + 1, -1 do sigParts[i] = nil end
	return table.concat(sigParts, ",")
end

-- An NPC interaction while a step is current checks off its talk/train/
-- vendor goals (sethome: binding); while the player looks at another step,
-- the live step's too. Stored with the manual check-offs, so the result
-- survives the step moving on and a reload. Goals with candidates count only
-- for one of their candidates (any of them); profession trains complete from
-- the skill's max rank instead. Returns true if anything changed.
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
						ok = goal.npc == npc
					elseif kind == "sethome" then
						-- `sethome nearest` on any bind; a located one at its inn's
						-- innkeeper (goal.npc, else the one of the inn its location names).
						local nav = goal.location and npc and ns.Nav
						local inn = nav and nav.FindInn and nav.FindInn(goal.npc, goal.location)
						ok = not goal.location or (npc ~= nil and npc == (inn and inn.npc or goal.npc))
					elseif kind == "train" and isProfessionTrain(goal) then
						ok = false
					elseif goal.candidates and npc then
						ok = isCandidate(goal, npc)
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

-- A frame still open when the step changes counts for the new step.
local function latchOpenFrame()
	if not openNpc and not openKind then return false end
	local hit = openNpc and latch("talk", openNpc) or false
	if openKind == "train" or openKind == "vendor" then hit = latch(openKind, openNpc) or hit end
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
-- stand (1-minute bands), then the author's order.
---------------------------------------------------------------------------

local ROUTE_TIE = 60 -- seconds of travel that count as a tie

local function routesTable()
	local s = ns.CharState()
	if type(s.routes) ~= "table" then s.routes = {} end
	return s.routes
end

-- The options of `from` that fit the character, in the author's order:
-- { guide = g, outleveled = bool }.
local function routeOptions(from)
	local list = {}
	if not (from and from.nextChoices) then return list end
	if not player then refreshPlayer() end
	local level = player.level or 1
	for _, id in ipairs(from.nextChoices) do
		local g = Guides.Get(id)
		if g and Guides.GuideMatches(g, player) then
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

-- The best class trainer for the character from where they stand, or nil;
-- its npcName in the client's language where Names has it.
function Engine.NearestClassTrainer()
	if #classTrainers.candidates == 0 then return nil end
	if not player then refreshPlayer() end
	local p = pickFor(classTrainers)
	local t = p.list[p.i]
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

-- The active guide sends the character to their class trainer soon.
local function guideTrainsSoon()
	if not (guide and current) then return false end
	local seen = 0
	for s = current, #guide.steps do
		local step = guide.steps[s]
		if stepApplies(step) then
			for _, goal in ipairs(step.goals) do
				if goal.t == "train" and goalApplies(goal) and (goal.class or (goal.npc and trainerClasses[goal.npc])) then return true end
			end
			seen = seen + 1
			if seen >= TRAIN_LOOKAHEAD then break end
		end
	end
	return false
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
	local t = Engine.NearestClassTrainer()
	if not t then return end
	s.trainDueShown = level
	ns.Fire("TRAIN_DUE", level, t)
end

-- A trainer window of the character's class: trained at this level.
-- classTrainVisit is only ever a real visit (classTrainLevel is also set on
-- first sight), so `train class` trusts it alone.
local function noteClassTrainer(npc)
	if not Engine.IsClassTrainer(npc) then return end
	refreshPlayer()
	local s = ns.CharState()
	s.classTrainLevel = player.level or 1
	s.classTrainVisit = s.classTrainLevel
	ns.Fire("CLASS_TRAINED", s.classTrainLevel)
end

-- `train class` has nothing to teach: the character visited its class trainer
-- at this level, or at the even level below an odd one (class trainers teach
-- on even levels only). Latched once the route moves past (latchable), so the
-- next level does not send the player back.
function Own.nothingToTrain()
	local visit, level = tonumber(ns.CharState().classTrainVisit), player and player.level
	return visit ~= nil and level ~= nil and visit <= level and level - visit <= level % 2
end

-- Fresh step state for a new guide in the loaded tab.
local function resetLoaded(id, auto)
	guide = Guides.Get(id)
	current, computed, pin, pinDone, aim, lastSig, passedUpTo = nil, nil, nil, nil, nil, nil, 0
	autoChain, sawIncomplete, placing = auto and true or false, false, GetTime() + PLACE_SECONDS
	tabsDirty = true
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
	computed = gate and gate.step or computeCurrent()
	-- Placed once the quest log could be read (it can lag PLAYER_LOGIN).
	local wasPlacing = placing
	if placing and (logReady or GetTime() >= placing) then placing = nil end
	if computed then sawIncomplete = true end
	local passed = (computed or #guide.steps + 1) - 1
	if passed > passedUpTo then latchPassed(passedUpTo + 1, passed) end
	passedUpTo = passed

	-- The view of another step: released once it is the live step (or no
	-- longer applies); while the step looked at gets done it follows forward,
	-- behind the live step up to it, ahead of it to the next open step, its
	-- transient goals latched like any step the route moves past.
	local wasPinned = pin ~= nil
	if pin and ((computed and pin == computed) or not guide.steps[pin] or not stepApplies(guide.steps[pin])) then pin = nil end
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
	local latched = false
	-- Bag-count goals already met in the step about to be (or still) current
	-- stay met for the rest of it, even if the items get used up (crafted,
	-- handed in) before the step's other goals are done.
	if newCurrent then latchInStep(newCurrent) end
	if changed then
		-- The computed step moved past a step whose quests became unavailable
		-- (not offered at the giver, or closed for good): say which and why,
		-- before STEP_CHANGED, so the window shows it with the new step.
		-- STEP_SKIPPED(fromStep, toStep, { { quest, title, reason, text }, ... })
		local old = current
		if active and old and not wasPlacing and not wasPinned and not pin and (not newCurrent or newCurrent > old) and not isSkipped(old)
			and stepApplies(guide.steps[old]) then
			local skips, seen = {}, {}
			for g, goal in ipairs(guide.steps[old].goals) do
				local u = blocks(goal) and goalApplies(goal) and not seen[goal.quest] and unavailableFor(goal)
				if u and not goalDone(old, g, goal) then
					seen[goal.quest] = true
					skips[#skips + 1] = { quest = goal.quest, title = questTitle(goal), reason = u.reason, text = unavailableText(u) }
				end
			end
			if #skips > 0 then ns.Fire("STEP_SKIPPED", old, newCurrent, skips) end
		end
		current = newCurrent
		aim = nil -- the arrow's choice was for the old step
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
		latched = current and latchOpenFrame() or false
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

	-- The open frame just checked off goals of the new step: re-evaluate.
	if latched then requestUpdate() end

	if not current then
		local id = guide.id
		if not completedFired[id] then
			completedFired[id] = true
			if active then
				ns.Fire("GUIDE_COMPLETED", id)
			else
				pendingCompleted[#pendingCompleted + 1] = id
			end
			-- autoNextGuide replaces the finished guide within its own tab,
			-- unless the next guide is already open in another one. A route
			-- choice the player has to make keeps the finished guide and asks.
			local mayChain = (autoChain or sawIncomplete) and ns.Get("behavior.autoNextGuide")
			local nextId, asks = routeNext(guide)
			if mayChain and asks then pendingChoices[#pendingChoices + 1] = id end
			if mayChain and nextId and Guides.Get(nextId) and not completedFired[nextId] and not tabIndexOf(nextId) then
				resetLoaded(nextId, true)
				persist()
				if active then ns.Fire("GUIDE_CHANGED", nextId) end
				evaluateLoaded(active)
			end
		end
	end
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
	-- Out-levelled: once per guide per session.
	if guide and guide.maxLevel and (player.level or 1) >= guide.maxLevel + 2 and not outleveled[guide.id] then
		outleveled[guide.id] = true
		local suggested = Guides.Suggest()
		ns.Fire("GUIDE_OUTLEVELED", guide.id, suggested ~= guide.id and suggested or nil)
	end
	checkTrainDue()
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
	C_Timer.After(wait > 0 and wait or 0, flush)
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

-- Already open: activates it (unless activate == false). Full: nil.
function Engine.OpenTab(id, activate)
	local g = id and Guides.Get(id)
	if not g or not ns.IsLoggedIn() then return nil end
	local open = tabIndexOf(id)
	if open then
		if activate ~= false then Engine.SelectTab(open) end
		return open
	end
	if #tabs >= MAX_TABS then return nil end
	local tab = { guide = g, passedUpTo = 0, autoChain = false, sawIncomplete = false, placing = GetTime() + PLACE_SECONDS }
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
-- closing the last tab leaves no guide.
function Engine.CloseTab(index)
	if type(index) ~= "number" or not tabs[index] then return end
	sync()
	table.remove(tabs, index)
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
-- check-offs/skips) or "done" (finished this session, or open and finished);
-- doneSteps/totalSteps when the guide is open in a tab.
function Engine.GetGuideState(id)
	if not (id and Guides.Get(id)) then return nil end
	local open = tabIndexOf(id)
	local done, total
	if open then
		use(tabs[open])
		if not player then refreshPlayer() end
		done, total = progressLoaded()
		local complete = computed == nil
		useActive()
		if complete then return "done", done, total end
	end
	if completedFired[id] then return "done", done, total end
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
-- guide already open in another tab is selected instead of duplicated. nil
-- closes the active tab.
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
		resetLoaded(id, false)
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
-- option being changed, else in the active tab. Fires ROUTE_CHOSEN.
function Engine.ChooseRoute(fromId, toId)
	local from, to = fromId and Guides.Get(fromId), toId and Guides.Get(toId)
	if not (from and to and from.nextChoices) then return false end
	local offered = false
	for _, id in ipairs(from.nextChoices) do
		if id == toId then offered = true end
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
			use(tabs[index or activeIndex])
			resetLoaded(toId, true)
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

-- The active tab's finished guide when its route choice waits for the
-- player, else nil.
function Engine.PendingRouteChoice()
	if not (guide and guide.nextChoices) or computed ~= nil or current ~= nil then return nil end
	if not player then refreshPlayer() end
	local _, asks = routeNext(guide)
	return asks and guide.id or nil
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

function Engine.GetStepView(i)
	if not guide or type(i) ~= "number" then return nil end
	local step = guide.steps[i]
	if not step then return nil end
	if not player then refreshPlayer() end
	local status = stepStatusOf(i)
	local groups, focus, groupOf = stepGroups(i)
	local goals = {}
	for g, goal in ipairs(step.goals) do goals[g] = goalView(i, g, goal, status, groupOf[g]) end
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
	-- current step only); `skipped`: the player skipped this step (Unskip).
	return {
		index = i, title = step.title, note = step.note, status = status, goals = goals,
		groups = outGroups, focus = focus,
		current = status == "current" and (Own.currentGoal(i, groups, focus)) or nil,
		skipped = isSkipped(i), live = computed,
	}
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
-- skipped step.
function Engine.Skip()
	if not (guide and current) then return nil end
	refreshPlayer()
	placing = nil
	local s, id = current, guide.id
	skippedFor(id, true)[s] = true
	if pin then Own.view(nextApplicable(pin)) end
	evaluate()
	ns.Fire("PLAYER_SKIPPED_STEP", id, s)
	return s
end

-- Undo a skip: step i is open again (the live step when it is the first open
-- one). True if it was skipped.
function Engine.Unskip(i)
	if not guide or type(i) ~= "number" then return false end
	local sk = skippedFor(guide.id)
	if not (sk and sk[i]) then return false end
	refreshPlayer()
	placing = nil
	sk[i] = nil
	if not next(sk) then ns.CharState().skipped[guide.id] = nil end
	evaluate()
	return true
end

-- One applicable step forward, done, skipped or open alike: a look at it
-- that changes nothing (the counterpart of Prev); reaching the live step
-- hands back to it.
function Engine.Next()
	if not (guide and current) then return end
	refreshPlayer()
	placing = nil
	local s = nextApplicable(current)
	if not s then return end
	Own.view(s)
	evaluate()
end

-- Look at step i: a jump back or ahead that changes nothing, except that a
-- skipped step jumped to is open again.
function Engine.Goto(i)
	if not guide or type(i) ~= "number" or not guide.steps[i] then return end
	refreshPlayer()
	if not stepApplies(guide.steps[i]) then return end
	placing = nil
	local sk = skippedFor(guide.id)
	if sk then sk[i] = nil end
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
		if stepApplies(guide.steps[s]) then
			if current and current == computed then clearInStep(current) end
			Own.view(s)
			evaluate()
			return
		end
	end
end

-- Tick a goal done, or clear its check-off: any goal but a note, quest goals
-- included (the player's word over the quest log). Saved as "tick" in
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
	placing = nil
	evaluate()
	return true
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
	placing = nil
	evaluate()
	return true
end

-- Point the arrow at a goal of the current step the player chose (its place,
-- spawn areas included) until the step changes or the goal is done. True if
-- the arrow can lead there.
function Engine.AimGoal(stepIndex, goalIndex)
	if not (guide and current) or stepIndex ~= current then return false end
	local goal = guide.steps[current].goals[goalIndex]
	if not (goal and waypointOf(goalIndex, goal)) then return false end
	aim = goal
	evaluate()
	return true
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

-- Forget check-offs, skips and the saved view for the active guide.
function Engine.ResetProgress()
	if not guide then return end
	local state = ns.CharState()
	state.manual[guide.id] = nil
	state.skipped[guide.id] = nil
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
	"BAG_UPDATE_DELAYED", "PLAYER_ENTERING_WORLD",
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
-- `sethome` when the innkeeper bound at is its inn's, in every tab.
ns.RegisterEvent("HEARTHSTONE_BOUND", function()
	if player then
		local npc = Compat().GetNpcID("npc")
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

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	if type(level) == "number" and level > levelSeen then levelSeen = level end
	Own.clearMarks()
	requestUpdate()
end)

-- kind: "talk" for gossip/quest frames, "train"/"vendor" for those windows.
-- The interaction counts for the current step of every open tab.
local function onNpcFrame(kind)
	local npc = Compat().GetNpcID("npc")
	openNpc, openKind = npc, kind
	if player then
		for i = 1, #tabs do
			use(tabs[i])
			if npc then latch("talk", npc) end
			if kind ~= "talk" then latch(kind, npc) end
		end
		useActive()
	end
	requestUpdate()
end
local function onTalkFrame() onNpcFrame("talk") end
for _, event in ipairs({ "GOSSIP_SHOW", "QUEST_DETAIL", "QUEST_GREETING", "QUEST_PROGRESS", "QUEST_COMPLETE" }) do
	ns.RegisterEvent(event, onTalkFrame)
end

-- Unavailable quests. A gossip, greeting or quest-detail window from an
-- `accept` goal's own giver (current step of any tab) that does not offer
-- its quest marks it unavailable; one that offers it clears the mark. A
-- detail window opened from that giver's list, popped up by a turn-in at
-- that giver (the follow-up quest), or started by an item, says nothing
-- about the others.
local LIST_WINDOW = 30 -- seconds a list or a turn-in covers the detail windows opened from it
local listedAt = {} -- npc -> GetTime() of its last gossip/greeting list or turn-in

local function unavailableReason(goal)
	local lvl = tonumber(goal.minLevel)
	if lvl and (player.level or 1) < lvl then return "level" end
	if missingPre(goal) then return "pre" end
	return "offer"
end

-- A level-up or a turn-in (either can unlock a quest) clears the marks, so
-- the giver's next window decides afresh. A mark whose accept is in a step a
-- tab has moved past is cleared only when the data says the quest has just
-- opened: a "level" or "pre" mark whose level is reached and prerequisites
-- done (the guide goes back to it, as for #70). A "level" or "pre" mark still
-- gated stays, its reason brought up to date (a level reached, a
-- prerequisite still missing). An "offer" mark stays (#161): nothing in the
-- data explains the refusal, and clearing it would send the guide back to a
-- giver who said no, from wherever the player is now. It keeps that step
-- passed until the giver's window offers the quest (checkOffers) or it is
-- taken; a server gate the data does not know (a higher level) opens the
-- same way.
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
		if now and (u.reason == "offer" or now ~= "offer") then
			if u.reason ~= "offer" then u.reason = now end
		else
			unavailable[q] = nil
		end
	end
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
				unavailable[list[1]] = nil
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
		unavailable[list[i]] = nil
		Own.offered[list[i]] = true
	end
	-- The window lists a quest just accepted as active a moment before the
	-- quest log has it (#127): taken, not refused.
	local active = source ~= "detail" and C.GetActiveQuests(source) or nil
	for i = 1, active and #active or 0 do
		offered[active[i]] = true
		unavailable[active[i]] = nil
	end
	for i = 1, #tabs do
		use(tabs[i])
		if guide and current then
			for _, goal in ipairs(guide.steps[current].goals) do
				local q = goal.quest
				if goal.t == "accept" and q and (goal.npc == npc or goal.object == npc) and goalApplies(goal)
					and not offered[q] and not C.IsOnQuest(q) and not questDone(q) and not unavailable[q] then
					unavailable[q] = { reason = unavailableReason(goal), accept = goal }
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
	if type(q) == "number" then unavailable[q] = nil end
end)
for _, event in ipairs({ "QUEST_COMPLETE", "QUEST_TURNED_IN" }) do
	ns.RegisterEvent(event, function()
		local npc = Compat().GetNpcID("npc")
		if npc then listedAt[npc] = GetTime() end
	end)
end

-- Quests their giver did not offer survive a reload and a relog, at any
-- level: saved at logout as CharState().offers[questID] = true (older saves
-- hold a level there, which reads the same) and restored at login, so placing
-- the guide does not pull the player back to a giver who already said no
-- (#161). As in play, the giver's window offering the quest clears the mark
-- (checkOffers).
function Own.saveOffers()
	local s = ns.CharState()
	local out
	for q, u in pairs(unavailable) do
		if u.reason == "offer" and not Compat().IsOnQuest(q) then
			out = out or {}
			out[q] = true
		end
	end
	s.offers = out
end

function Own.restoreOffers()
	local saved = ns.CharState().offers
	if type(saved) ~= "table" then return end
	for q in pairs(saved) do
		q = tonumber(q)
		if q and not unavailable[q] then
			for _, t in ipairs(tabs) do
				local a = layoutOf(t.guide).accepts[q]
				if a then
					unavailable[q] = { reason = "offer", accept = a[1].goal }
					break
				end
			end
		end
	end
end

ns.RegisterEvent("PLAYER_LOGOUT", function()
	sync()
	Own.saveOffers()
end)

ns.RegisterEvent("TRAINER_SHOW", function()
	onNpcFrame("train")
	noteClassTrainer(openNpc)
end)
ns.RegisterEvent("MERCHANT_SHOW", function() onNpcFrame("vendor") end)

local function onNpcFrameClosed() openNpc, openKind = nil, nil end
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
-- sits in the live step or the next `span` (default 2) applicable steps of any
-- open tab, or in the step in view and the ones after it when Prev/Next moved
-- the view. Automation's gate: never act on quests the route does not want now.
local function wantsFrom(from, verb, questID, span)
	local left = span + 1
	local steps = guide.steps
	for s = from, #steps do
		local step = steps[s]
		if stepApplies(step) then
			for g, goal in ipairs(step.goals) do
				if matchesVerb(goal, verb) and goal.quest == questID and goalApplies(goal)
					and not (verb == "direct" and goalDone(s, g, goal)) then
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
	if not guide then return false end
	if computed and wantsFrom(computed, verb, questID, span) then return true end
	return current ~= nil and current ~= computed and wantsFrom(current, verb, questID, span)
end

function Engine.WantsQuest(verb, questID, span)
	if not questID then return false end
	if not player then refreshPlayer() end
	local found = false
	for i = 1, #tabs do
		use(tabs[i])
		if wantsLoaded(verb, questID, span or 2) then
			found = true
			break
		end
	end
	useActive()
	return found
end

-- A saved tab coming back: at the step the player was looking at (a pack
-- update carries it to the step's new place first).
local function restoredTab(g)
	checkShape(g)
	local pins = ns.CharState().pins
	local p = type(pins) == "table" and pins[g.id]
	return { guide = g, passedUpTo = 0, autoChain = true, sawIncomplete = false, placing = GetTime() + PLACE_SECONDS,
		pin = type(p) == "table" and tonumber(p.step) or nil, pinDone = type(p) == "table" and p.done or nil }
end

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
	add(s.guide) -- saved before tabs existed
	local activeId = s.tabs and list[tonumber(s.activeTab) or 0] or s.guide
	local offerFrom
	if #ids == 0 and ns.Get("behavior.autoSelectGuide") then
		local suggested = Guides.Suggest()
		add(suggested)
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
	Own.restoreOffers()
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
