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
-- The way to a running timer's hand-in on the route is read every READ_EVERY
-- seconds whichever step is shown (Timed.Way). When the route's way there
-- (Engine.RouteSeconds: the errands before it, in order) would get in after
-- the timer runs out and the way straight there still makes it, with the quest
-- ready to hand in, the hand-in is pulled forward (0.3.8, plan item 3F-C7):
-- the Engine leads the arrow there ahead of the live step's other errands
-- (Own.timedAim) and the While-here panel opens with the quest's row, "Durnan
-- Furcutter ~3 min · go now, the route gets there too late" (a right-click
-- lets the route be: the row goes, the arrow back to the step). TIMED_PULL
-- when a pull starts or ends.
-- A running timer whose hand-in the active guide's route does not make from
-- the live step on (0.3.7: Apothecary Zamah, offered by a giver
-- the Barrens route visits, with 42:00 left) gets a line of its own at the top
-- of the guide window's While-here panel (UI/GuideFrame.lua, GF.FillHere):
-- "Apothecary Zamah 42:00 left", under it "Thunder Bluff ~6 min · this guide
-- doesn't go there". Its ender is the quest's (the Codex) nearest spawn
-- (Lookup.QuestEnd), the minutes Nav.EstimateTravel's from where the player
-- is; a click points the arrow there (Timed.AimOff: Nav.SetTarget with the
-- spawn's height), a right-click hides it until the timer ends (Timed.MuteOff).
--
-- The clock is the client's (Compat.QuestTimers), else, for a quest taken
-- with a `limit` (the active guide's accept, else the quest database's,
-- Polestar_QuestDB: QuestDB.TimeLimit, so a timed quest no guide takes counts
-- down too), the accept's time plus that limit (fromData). A quest's deadline
-- is kept from its first reading on and only ever moves earlier, so a client
-- whose elapsed time stands still between quest log updates does not stretch
-- it; it is dropped when the quest leaves the log, fails or the timer ends.
-- One ticker, each second, only while a timer runs.
--
-- API:
--   Timed.Left(q)          seconds left on quest q's running timer, or nil
--   Timed.Clock(secs)      "8:42", "1:02:03"
--   Timed.Badge(goal)      the countdown for an open goal of a running timed quest, or nil
--   Timed.Countdown(q)     the countdown of quest q's running timer, or nil
--   Timed.Soonest()        the quest whose running timer ends first, or nil
--   Timed.LimitText(goal)  "Timed: 10 min once accepted" for an open accept with a `limit`, or nil
--   Timed.Hint(goal)       the hand-in hint, on the shown step's goal that carries it, or nil
--   Timed.Running(out)     the running timers, soonest first (fills `out`, wiped)
--   Timed.Way(q)           seconds the way straight to quest q's hand-in on the route takes from where the player
--                          was at the last reading (Nav.EstimateTravel, as the hint's), or nil
--   Timed.Pulling()        the quest whose hand-in is pulled forward (soonest first), or nil
--   Timed.Pulled(q)        its hand-in on the route: step, goal index; or nil
--   Timed.OffRoute(out)    the running timers the route does not hand in, soonest first (fills `out`, wiped)
--   Timed.OffText(q)       an off-route timer's line and subline, or nil
--   Timed.AimOff(q)        the arrow to its ender; true when it could
--   Timed.MuteOff(q)       its line hidden until its timer ends
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
local off = {} -- questID -> its ender { name, zone, map, x, y, f, z, secs } while the route does not hand it in; false: none known
local muted = {} -- questID -> true: its off-route line hidden until the timer ends
local pull = {} -- questID -> { s, g }: its hand-in on the route, pulled forward (Timed.Pulling)
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

local function byDeadline(a, b) return deadline[a] < deadline[b] end

function Timed.Running(out)
	out = out or {}
	for i = #out, 1, -1 do out[i] = nil end
	for q in pairs(deadline) do out[#out + 1] = q end
	table.sort(out, byDeadline)
	return out
end

function Timed.Way(q)
	local w = q and way[q]
	return w and w.secs or nil
end

function Timed.Pulling()
	local best, bestAt
	for q in pairs(pull) do
		local d = deadline[q]
		if d and (not bestAt or d < bestAt) then best, bestAt = q, d end
	end
	return best
end

function Timed.Pulled(q)
	local p = q and pull[q]
	if not p then return nil end
	return p[1], p[2]
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
-- this character, with a place; `anyPlace`: with or without one), or nil.
local function turninOf(E, guide, q, anyPlace)
	for i = E.GetLiveStep() or 1, #guide.steps do
		for g, goal in ipairs(guide.steps[i].goals) do
			if goal.t == "turnin" and goal.quest == q and (anyPlace or (goal.map and goal.x and goal.y)) and E.Applies(i, g) then return goal end
		end
	end
	return nil
end

-- Quest q's ender as an off-route line places it: the nearest spawn of the
-- quest's ender (the Codex's `end`, Lookup.QuestEnd by straight line), its
-- height for the arrow, its zone's name; then the way there from where the
-- player stands (Nav.EstimateTravel, as the hint's). False when the Codex
-- knows no place for it; nothing kept while the Codex could not load (a
-- later reading tries again).
local function offPlace(q, nav)
	local o = off[q]
	if o == nil then
		local Codex, Lk, C = ns.Codex, ns.Lookup, ns.Compat
		local rec = Codex and Codex.Quest and Codex.Quest(q)
		if not rec then
			if Codex and Codex.IsLoaded and Codex.IsLoaded() then off[q] = false end
			return
		end
		local e = Lk and Lk.QuestEnd and Lk.QuestEnd(rec["end"], ns.PlayerPoint and ns.PlayerPoint() or nil, nil, true)
		local s = e and e.spawn
		if not (s and s.map and s.x and s.y) then
			off[q] = false
			return
		end
		local z = s.z
		if z == nil and Lk.SpawnZ then z = Lk.SpawnZ(e.npc and "npc" or "object", e.npc or e.object, s) end
		o = { name = e.name or "", map = s.map, x = s.x, y = s.y, f = s.f, z = z, zone = C and C.MapName and C.MapName(s.map) or "" }
		off[q] = o
	end
	if not (o and nav and nav.EstimateTravel) then return end
	local ok, secs, busy = pcall(nav.EstimateTravel, nil, { map = o.map, x = o.x, y = o.y, f = o.f }, true)
	if ok and type(secs) == "number" then
		o.secs = secs
	elseif not (ok and busy == "busy") then
		o.secs = nil
	end
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

-- Whether quest q's hand-in on the route is pulled forward now (see the top):
-- its step and goal index, or nil.
local function pulls(E, q)
	local C, w, left = ns.Compat, way[q], Timed.Left(q)
	if muted[q] or not (w and left and w.secs <= left and E.RouteSeconds) then return nil end
	if not (C and C.IsQuestReadyForTurnIn and C.IsQuestReadyForTurnIn(q)) or (C.IsQuestFailed and C.IsQuestFailed(q)) then return nil end
	local secs, s, g = E.RouteSeconds(q)
	if not (secs and secs > left) then return nil end
	return s, g
end

local function measure()
	local E, nav = ns.Engine, ns.Nav
	local guide = E and E.GetGuide and E.GetGuide()
	local was = next(pull) ~= nil and Timed.Pulling()
	for q in pairs(way) do
		if not deadline[q] then way[q] = nil end
	end
	for q in pairs(off) do
		if not deadline[q] then off[q], muted[q] = nil, nil end
	end
	for q in pairs(hintAt) do hintAt[q] = nil end
	for q in pairs(pull) do pull[q] = nil end
	for q in pairs(muted) do
		if not deadline[q] then muted[q] = nil end
	end
	if not (guide and E.GetLiveStep and E.GetLiveStep()) then
		for q in pairs(off) do off[q] = nil end
		if was then ns.Fire("TIMED_PULL") end
		return
	end
	local shown = E.GetStepIndex and E.GetStepIndex()
	for q in pairs(deadline) do
		hintAt[q] = hintGoal(guide, shown, q)
		if not turninOf(E, guide, q, true) then
			way[q] = nil
			offPlace(q, nav)
		else
			off[q] = nil
			local goal = nav and nav.EstimateTravel and turninOf(E, guide, q)
			if goal then
				local ok, secs, busy = pcall(nav.EstimateTravel, nil, { map = goal.map, x = goal.x, y = goal.y, f = goal.f }, true)
				if ok and type(secs) == "number" then
					way[q] = { secs = secs, name = (goal.npc and ns.Names and ns.Names.Npc and ns.Names.Npc(goal.npc)) or goal.npcName or "" }
				elseif not (ok and busy == "busy") then
					way[q] = nil
				end
				local s, g = pulls(E, q)
				if s then pull[q] = { s, g } end
			else
				way[q] = nil
			end
		end
	end
	local now = next(pull) ~= nil and Timed.Pulling()
	if now ~= was then ns.Fire("TIMED_PULL") end
end

---------------------------------------------------------------------------
-- Timers the route does not hand in
---------------------------------------------------------------------------

function Timed.OffRoute(out)
	out = out or {}
	for i = #out, 1, -1 do out[i] = nil end
	local C = ns.Compat
	for q, o in pairs(off) do
		if o and deadline[q] and not muted[q] and not (C and C.IsQuestFailed and C.IsQuestFailed(q)) then out[#out + 1] = q end
	end
	-- A hand-in pulled forward has its row too: it says why the arrow left the step.
	for q in pairs(pull) do
		if deadline[q] and not muted[q] then out[#out + 1] = q end
	end
	table.sort(out, byDeadline)
	return out
end

function Timed.OffText(q)
	local o, countdown = off[q], Timed.Countdown(q)
	local w = pull[q] and way[q]
	if not ((o or w) and countdown) then return nil end
	local C = ns.Compat
	local name = (C and C.GetQuestTitle and C.GetQuestTitle(q)) or ("#" .. q)
	if w then
		-- Timed.Countdown starts with the hourglass and its own space: "<quest> <hourglass> 4:12 left".
		return name .. " " .. countdown, format(L["%s ~%s · go now, the route gets there too late"], w.name, duration(w.secs))
	end
	local place = o.zone ~= "" and o.zone or o.name
	local sub
	if o.secs then
		-- The way's time, "about": "≈6 min", "~" in a face without it (Theme.Approx, #1906).
		sub = format(L["%s %s · this guide doesn't go there"], place, Theme.Approx() .. duration(o.secs))
		-- Longer than the time left: in the danger colour, as the hint on a step.
		if o.secs > (Timed.Left(q) or 0) then sub = "|c" .. Theme.Hex("danger") .. sub .. "|r" end
	else
		sub = format(L["%s · this guide doesn't go there"], place)
	end
	-- Timed.Countdown starts with the hourglass and its own space: "<quest> <hourglass> 44:59 left".
	return name .. " " .. countdown, sub
end

function Timed.AimOff(q)
	-- A pulled hand-in: the Engine's arrow leads there already (Own.timedAim).
	if q and pull[q] then
		ns.Fire("TIMED_PULL")
		return true
	end
	local o, nav = off[q], ns.Nav
	if not (o and nav and nav.SetTarget) then return false end
	local C = ns.Compat
	local label = o.name ~= "" and o.name or (C and C.GetQuestTitle and C.GetQuestTitle(q)) or nil
	return nav.SetTarget(o.map, o.x, o.y, label, o.f, nil, o.z) and true or false
end

function Timed.MuteOff(q)
	if not (q and (off[q] or pull[q])) then return false end
	muted[q] = true
	-- Let the route be: no pull, the arrow back to the step.
	if pull[q] then
		pull[q] = nil
		ns.Fire("TIMED_PULL")
	end
	return true
end

---------------------------------------------------------------------------
-- The clock
---------------------------------------------------------------------------

local tick

-- The `limit` of quest q on an accept of the active guide (quests.json, by
-- the compile), else the quest database's (QuestDB.TimeLimit: quests.json's
-- too, for the timed quests no guide takes), or nil.
local function limitOf(q)
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if guide then
		for _, step in ipairs(guide.steps) do
			for _, goal in ipairs(step.goals) do
				if goal.t == "accept" and goal.quest == q and type(goal.limit) == "number" and goal.limit > 0 then return goal.limit end
			end
		end
	end
	local Q = ns.QuestDB
	local limit = Q and Q.TimeLimit and Q.TimeLimit(q)
	return type(limit) == "number" and limit > 0 and limit or nil
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
			deadline[q], prevLeft[q], way[q], off[q], muted[q] = nil, nil, nil, nil, nil
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
-- accept's time for the clock from the data. The ways (and an off-route
-- line's place) are measured on the first tick, not up to READ_EVERY later.
ns.RegisterEvent("QUEST_ACCEPTED", function(_, a, b)
	local q = type(b) == "number" and b > 0 and b or a
	if type(q) == "number" then
		deadline[q], prevLeft[q], off[q], muted[q] = nil, nil, nil, nil
		local limit = limitOf(q)
		accepts()[q] = limit and { at = GetServerTime(), limit = limit } or nil
	end
	lastMeasure = nil
	Timed.Update()
end)
for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_REMOVED", "PLAYER_ENTERING_WORLD" }) do
	ns.RegisterEvent(event, function() Timed.Update() end)
end
