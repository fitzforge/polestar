-- Timed quests (0.3.6, a Discord request). While a quest's timer runs:
--   * its time left on each of its open goals the guide window shows (the
--     step's card, in full or compact mode, and its While-here lines:
--     UI.GoalLine, UI.HereText): "8:42 left" after the hourglass, in the
--     warning colour under WARN seconds and the danger colour under DANGER;
--   * a chat line and a sound at 5 minutes left, at 1, and when it fails
--     (qol.questTimerAlerts);
--   * on the step, a hint when the way to its hand-in takes longer than the
--     time left (Nav.EstimateTravel: the walks, flights and boats the arrow
--     would plan; while a timer runs that leaves out the Hearthstone and
--     teleports, as the route does).
-- Before it is taken, an open accept with a `limit` (seconds: quests.json,
-- carried by the guide's accept) says how long the quest allows
-- (UI.GoalSubline). While-here puts a timed quest's lines first and keeps
-- them while the timer holds every other line (Core/Engine.lua, Own.hereTick).
-- The arrow shows the same countdown under its distance (Nav/Arrow.lua:
-- Timed.Countdown of its target's quest, else of Timed.Soonest).
-- A quest that failed (C_QuestLog.IsFailed) loses its countdown at once; its
-- goals grey with the Engine's "failed: abandon it and take it again"
-- (Own.failedQuest) and the alert says the same in chat.
--
-- The clock is the client's (Compat.QuestTimers), else, for a quest taken
-- with a `limit` on the active guide's accept, the accept's time plus that
-- limit (fromData). A quest's deadline is kept from its first reading on and
-- only ever moves earlier, so a client whose elapsed time stands still
-- between quest log updates does not stretch it; it is dropped when the
-- quest leaves the log, fails or the timer ends. One ticker, each second,
-- only while a timer runs.
--
-- API:
--   Timed.Left(q)          seconds left on quest q's running timer, or nil
--   Timed.Clock(secs)      "8:42", "1:02:03"
--   Timed.Badge(goal)      the countdown for an open goal of a running timed quest, or nil
--   Timed.Countdown(q)     the countdown of quest q's running timer, or nil
--   Timed.Soonest()        the quest whose running timer ends first, or nil
--   Timed.LimitText(goal)  "Timed: 10 min once accepted" for an open accept with a `limit`, or nil
--   Timed.Hint(goal)       the hand-in hint, on the shown step's goal that carries it, or nil
--   Timed.Update()         read the quest log again and tick (events and the ticker; tests)
-- Message: QUEST_TIMER each second a timer runs (the guide window repaints its countdowns).

local ADDON, ns = ...
local L = ns.L
local Theme = ns.Theme

local Timed = {}
ns.Timed = Timed

ns.RegisterDefaults("qol", {
	questTimerAlerts = true, -- a chat line and a sound at 5 min, at 1 min and when a timed quest fails (Quests/Timed.lua)
})

Timed.ALERTS = { 300, 60 } -- seconds left that get a chat line and a sound, as they pass
Timed.WARN, Timed.DANGER = 120, 60 -- the countdown's warning colour below WARN seconds, its danger colour below DANGER
Timed.READ_EVERY = 5 -- seconds between readings of the log (and of the way to each hand-in) while a timer runs
Timed.ICON = "hourglass"

local GetTime, floor, format, pairs, ipairs, type = GetTime, math.floor, string.format, pairs, ipairs, type

local reading = {} -- Compat.QuestTimers' scratch
local deadline = {} -- questID -> GetTime() its timer ends
local prevLeft = {} -- questID -> seconds left at the last tick: an alert fires as its mark passes
local way = {} -- questID -> { secs, name }: the way to its hand-in, last estimated
local hintAt = {} -- questID -> index of the shown step's goal that carries the hint
local ticker, lastRead = nil, nil

function Timed.Left(q)
	local d = q and deadline[q]
	if not d then return nil end
	local left = d - GetTime()
	return left > 0 and left or 0
end

function Timed.Clock(secs)
	secs = floor((secs or 0) + 0.5)
	if secs >= 3600 then return format("%d:%02d:%02d", floor(secs / 3600), floor(secs / 60) % 60, secs % 60) end
	return format("%d:%02d", floor(secs / 60), secs % 60)
end

-- "3 min", "1 h", "1 h 30 min" (rounded up to the minute).
local function duration(secs)
	local m = math.ceil((secs or 0) / 60)
	if m < 60 then return format(L["%d min"], m < 1 and 1 or m) end
	if m % 60 == 0 then return format(L["%d h"], m / 60) end
	return format(L["%d h %d min"], floor(m / 60), m % 60)
end

-- An open goal of a quest still in play: a goal greyed because its quest
-- failed or left the log (the Engine's `lost`) carries no countdown.
local function open(goal)
	return type(goal) == "table" and goal.status ~= "done" and goal.status ~= "skipped" and goal.status ~= "na" and not goal.lost
end

-- The hourglass in the colour `role`, at the line's height.
local function glass(role)
	local r, g, b = Theme.Color(role)
	return format("|T%s:0:0:0:0:128:128:0:128:0:128:%d:%d:%d|t", Theme.Media(Timed.ICON), floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
end

function Timed.Countdown(q)
	local left = Timed.Left(q)
	if not left or (ns.Compat and ns.Compat.IsQuestFailed and ns.Compat.IsQuestFailed(q)) then return nil end
	local role = left < Timed.DANGER and "danger" or left < Timed.WARN and "warning" or "text"
	return glass(role) .. " |c" .. Theme.Hex(role) .. format(L["%s left"], Timed.Clock(left)) .. "|r"
end

function Timed.Soonest()
	local best, bestAt
	for q, d in pairs(deadline) do
		if not bestAt or d < bestAt then best, bestAt = q, d end
	end
	return best
end

function Timed.Badge(goal)
	if not open(goal) then return nil end
	return Timed.Countdown(goal.quest)
end

function Timed.LimitText(goal)
	if not (open(goal) and goal.t == "accept" and type(goal.limit) == "number" and goal.limit > 0) or Timed.Left(goal.quest) then return nil end
	return glass("textDim") .. " " .. format(L["Timed: %s once accepted"], duration(goal.limit))
end

function Timed.Hint(goal)
	if not open(goal) then return nil end
	local q = goal.quest
	local left, w = Timed.Left(q), way[q]
	if not (left and w and w.secs > left and hintAt[q] == goal.index) then return nil end
	return "|c" .. Theme.Hex("danger") .. format(L["The way to %s takes about %s, longer than the time left"], w.name, duration(w.secs)) .. "|r"
end

---------------------------------------------------------------------------
-- Alerts
---------------------------------------------------------------------------

local function title(q)
	local C = ns.Compat
	return ns.Quoted((C and C.GetQuestTitle and C.GetQuestTitle(q)) or ("#" .. q))
end

local function alert(text)
	if not ns.Get("qol.questTimerAlerts") then return end
	ns.Print(text)
	if SOUNDKIT and SOUNDKIT.RAID_WARNING then pcall(ns.PlaySound, SOUNDKIT.RAID_WARNING, "Master") end
end

local function passed(q, mark)
	if mark >= 120 then
		alert(format(L["%s: %d minutes left"], title(q), floor(mark / 60)))
	else
		alert(format(L["%s: 1 minute left"], title(q)))
	end
end

---------------------------------------------------------------------------
-- The way to each hand-in
---------------------------------------------------------------------------

-- The route's hand-in of quest q from the live step on (a turn-in goal for
-- this character, with a place), or nil.
local function turninOf(E, guide, q)
	for i = E.GetLiveStep() or 1, #guide.steps do
		for g, goal in ipairs(guide.steps[i].goals) do
			if goal.t == "turnin" and goal.quest == q and goal.map and goal.x and goal.y and E.Applies(i, g) then return goal end
		end
	end
	return nil
end

-- The shown step's goal that carries quest q's hint: its turn-in there, else
-- its last goal there; nil without one.
local function hintGoal(guide, shown, q)
	local step = shown and guide.steps[shown]
	if not step then return nil end
	local last
	for g, goal in ipairs(step.goals) do
		if goal.quest == q then
			if goal.t == "turnin" then return g end
			last = g
		end
	end
	return last
end

local function measure()
	local E, nav = ns.Engine, ns.Nav
	local guide = E and E.GetGuide and E.GetGuide()
	for q in pairs(way) do
		if not deadline[q] then way[q] = nil end
	end
	for q in pairs(hintAt) do hintAt[q] = nil end
	if not (guide and E.GetLiveStep and E.GetLiveStep()) then return end
	local shown = E.GetStepIndex and E.GetStepIndex()
	for q in pairs(deadline) do
		hintAt[q] = hintGoal(guide, shown, q)
		local goal = hintAt[q] and nav and nav.EstimateTravel and turninOf(E, guide, q)
		if goal then
			local ok, secs, busy = pcall(nav.EstimateTravel, nil, { map = goal.map, x = goal.x, y = goal.y, f = goal.f }, true)
			if ok and type(secs) == "number" then
				way[q] = { secs = secs, name = (goal.npc and ns.Names and ns.Names.Npc and ns.Names.Npc(goal.npc)) or goal.npcName or "" }
			elseif not (ok and busy == "busy") then
				way[q] = nil
			end
		else
			way[q] = nil
		end
	end
end

---------------------------------------------------------------------------
-- The clock
---------------------------------------------------------------------------

local tick

-- The `limit` of quest q on an accept of the active guide (quests.json, by
-- the compile), or nil.
local function limitOf(q)
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not guide then return nil end
	for _, step in ipairs(guide.steps) do
		for _, goal in ipairs(step.goals) do
			if goal.t == "accept" and goal.quest == q and type(goal.limit) == "number" and goal.limit > 0 then return goal.limit end
		end
	end
	return nil
end

-- Quests taken with a `limit` (CharState().timedAccepts[q] = { at = server
-- time of the accept, limit }, kept over a reload): the clock when the
-- client reports none. Recordings show why: the Recorder's timer check
-- skips a quest ready at once, and the delivery quests that are (Scalding
-- Mornbrew Delivery, Iverron's Antidote, MacKreel's Moonshine, Apothecary
-- Zamah, Prompt Potion Runner) failed exactly at their limits. A record
-- whose time is GRACE seconds past with the quest neither failed nor gone
-- (the data was wrong) is dropped without a word.
Timed.GRACE = 30
local function accepts()
	local st = ns.CharState()
	if type(st.timedAccepts) ~= "table" then st.timedAccepts = {} end
	return st.timedAccepts
end

local function fromData(C, QL)
	local list, now = accepts(), GetServerTime()
	for q, rec in pairs(list) do
		local left = type(rec) == "table" and type(rec.at) == "number" and type(rec.limit) == "number" and rec.limit - (now - rec.at)
		if not left or (not C.IsOnQuest(q) and now - rec.at > 5) or (QL and QL.IsFailed and QL.IsFailed(q)) or left < -Timed.GRACE then
			list[q] = nil
		elseif reading[q] == nil and C.IsOnQuest(q) then
			reading[q] = left > 0 and left or 0
		end
	end
end

local function read()
	local C = ns.Compat
	if not (C and C.QuestTimers) then return end
	lastRead = GetTime()
	C.QuestTimers(reading)
	local QL = C_QuestLog
	fromData(C, QL)
	for q in pairs(deadline) do
		if not reading[q] then
			-- Its timer ended: handed in or abandoned (nothing to say), or failed.
			local failed = QL and QL.IsFailed and QL.IsFailed(q)
			if failed == nil and deadline[q] <= lastRead then failed = C.IsOnQuest(q) end
			if failed then alert(format(L["%s failed: its time ran out. Abandon it in the quest log and take it again."], title(q))) end
			deadline[q], prevLeft[q], way[q] = nil, nil, nil
		end
	end
	for q, left in pairs(reading) do
		local d = lastRead + left
		if not deadline[q] or d < deadline[q] then deadline[q] = d end
	end
	if next(deadline) and not ticker then ticker = ns.NewTicker(1, tick) end
end

-- The ways to the hand-ins again, at most each READ_EVERY seconds (`now`:
-- whatever the time).
local lastMeasure
local function measureDue(now)
	if not next(deadline) then return end
	if now or not lastMeasure or GetTime() - lastMeasure >= Timed.READ_EVERY then
		lastMeasure = GetTime()
		measure()
	end
end

tick = function()
	if not lastRead or GetTime() - lastRead >= Timed.READ_EVERY then read() end
	if not next(deadline) then
		if ticker then ticker:Cancel() end
		ticker = nil
		-- The last countdown goes from the window.
		ns.Fire("QUEST_TIMER")
		return
	end
	measureDue()
	for q in pairs(deadline) do
		local left = Timed.Left(q)
		local prev = prevLeft[q]
		if prev then
			for _, mark in ipairs(Timed.ALERTS) do
				if prev > mark and left <= mark then passed(q, mark) end
			end
		end
		prevLeft[q] = left
	end
	ns.Fire("QUEST_TIMER")
end

function Timed.Update()
	local had = next(deadline) ~= nil
	read()
	if had or next(deadline) then tick() end
end

-- Another step shown: the hint moves with it.
ns.On("STEP_CHANGED", function() measureDue(true) end)

-- A quest taken again starts its clock afresh; one with a `limit` keeps its
-- accept's time for the clock from the data.
ns.RegisterEvent("QUEST_ACCEPTED", function(_, a, b)
	local q = type(b) == "number" and b > 0 and b or a
	if type(q) == "number" then
		deadline[q], prevLeft[q] = nil, nil
		local limit = limitOf(q)
		accepts()[q] = limit and { at = GetServerTime(), limit = limit } or nil
	end
	Timed.Update()
end)
for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_REMOVED", "PLAYER_ENTERING_WORLD" }) do
	ns.RegisterEvent(event, function() Timed.Update() end)
end
