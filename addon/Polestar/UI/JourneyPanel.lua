-- The journey: the travel route's steps in the guide window, under the focus
-- they lead to (docs/DESIGN.md, "The Guide Window"; docs/ARCHITECTURE.md,
-- "Journey panel").
--
--   Journey                          36:48 · 8.0k yd   ^   header: click to collapse
--   To Silithus                                            destination
--   1  [lift]  Walk to The Great Lift, Top         11:10   current step: accent glyph
--   2  [lift]  Take The Great Lift                  0:25      and the 2px accent bar
--              leaves in about 0:15 · ride 0:10
--   3  [goto]  Walk to Silithus                    25:13
--
-- Shown while the route has more than one leg (Nav.travel.Active()): a lone
-- walk is the arrow's own distance and time, so a one-line journey would
-- only repeat it. Finished legs drop off; times count down once a second
-- while the panel is on screen and nothing runs while it is not. Each step's
-- time is whole seconds and the header adds up the steps, so the totals
-- always match what the rows say. Clicking the current step opens the skip
-- menu (Nav/Prompts.lua). Off with nav.journeySteps, collapsed with
-- nav.journeyOpen = false, never in compact mode.
--
-- Reads Nav.GetRoute() (legs, current index; leg.kind, label, seconds,
-- yards, step, lift, side, transport, to, hubs: a walk entering the other
-- faction's towns reads "Hostile town: <name>" under its step),
-- Nav.travel.Progress() for the
-- current leg and ns.Transit.NextDeparture for boats, zeppelins, the tram and
-- lifts. Wakes on ROUTE_CHANGED, ROUTE_ADVANCED, NAV_TRANSIT,
-- WAYPOINT_CHANGED and nav.* settings.
--
-- Adapted from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission): its journey tracker (UI/Tracker.lua) and step
-- wording and times (Journey/JourneySteps.lua: "Lift to %s", "leaves in
-- about %s", the header summing the steps' whole seconds).
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L

local type, pcall = type, pcall
local floor, ceil, huge = math.floor, math.ceil, math.huge
local format = string.format

local JP = {}
UI.JourneyPanel = JP

-- Without Nav there is no route, and no nav.* setting to show.
if ns.Nav then ns.RegisterDefaults("nav", { journeySteps = true, journeyOpen = true }) end

local PAD = 14
local TEXT_X = PAD + 15 + 10 -- the guide window's goal text edge
local HEAD_H = 30
local DEST_H = 22
local ROW_H = 24
local SUB_H = 14
local TIME_W = 56            -- "1:02:03" with room; fixed so a tick never moves the label
local MAX_ROWS = 8
local MORE_H = 20

local GLYPH = {
	walk = "icon-goto", fly = "icon-fly", boat = "icon-boat", zeppelin = "icon-boat", tram = "icon-boat",
	lift = "icon-lift", portal = "icon-explore", hearth = "icon-hearth", teleport = "icon-use",
}
local STEP_GLYPH = {
	lift = "icon-lift", gate = "icon-gate", bridge = "icon-bridge", tunnel = "icon-cave", cave = "icon-cave",
	pass = "icon-pass", building = "icon-goto",
}
-- How a leg reads when the planner gave it no caption (never "Unknown").
local STEP_TEXT = {
	walk = L["Walk to %s"], fly = L["Fly to %s"], boat = L["Boat to %s"], zeppelin = L["Zeppelin to %s"],
	tram = L["Tram to %s"], lift = L["Lift to %s"], portal = L["Portal to %s"], hearth = L["Hearth to %s"],
	teleport = L["Teleport to %s"],
}

---------------------------------------------------------------------------
-- Numbers and words
---------------------------------------------------------------------------

local function finite(v)
	return type(v) == "number" and v == v and v > -huge and v < huge
end

-- Whole seconds as a countdown shows them: up, so a step reads 0:00 only
-- once it is done; anything unreadable (nil, NaN, negative) is 0.
local function whole(v)
	if not finite(v) or v <= 0 then return 0 end
	return ceil(v - 1e-6)
end
JP.Whole = whole

-- "0:15", "11:10", "1:02:03".
function JP.FormatTime(secs)
	secs = whole(secs)
	if secs >= 3600 then
		return format("%d:%02d:%02d", floor(secs / 3600), floor(secs / 60) % 60, secs % 60)
	end
	return format("%d:%02d", floor(secs / 60), secs % 60)
end

local function setTime(fs, secs)
	secs = whole(secs)
	if secs >= 3600 then
		fs:SetFormattedText("%d:%02d:%02d", floor(secs / 3600), floor(secs / 60) % 60, secs % 60)
	else
		fs:SetFormattedText("%d:%02d", floor(secs / 60), secs % 60)
	end
end

-- "8.0k yd", "420 yd", "7.3 km" (nav.distanceUnit).
function JP.FormatDistance(yards)
	if not finite(yards) or yards < 0 then yards = 0 end
	return ns.FormatDistance(yards, { compact = true })
end

local function nonEmpty(s)
	return type(s) == "string" and s:find("%S") ~= nil
end

local function placeName(p)
	if type(p) ~= "table" then return nil end
	if nonEmpty(p.name) then return p.name end
	local C = ns.Compat
	local zone = p.map and C and C.GetMapName and C.GetMapName(p.map)
	if nonEmpty(zone) then return zone end
	return nil
end

-- A step's line: the planner's caption, else the kind's words and where it ends.
function JP.StepText(leg)
	if nonEmpty(leg.label) then return leg.label end
	return format(STEP_TEXT[leg.kind] or L["Go to %s"], placeName(leg.to) or L["the next stop"])
end

local function glyphOf(leg)
	return (leg.kind == "walk" and STEP_GLYPH[leg.step]) or GLYPH[leg.kind] or "icon-note"
end

-- "Hostile town: <names>" for a walk whose path enters the other faction's
-- towns (leg.hubs, Nav.travel.HubText), else nil.
local function hubText(leg)
	if leg.kind ~= "walk" then return nil end
	local T = ns.Nav and ns.Nav.travel
	return T and T.HubText and T.HubText(leg) or nil
end

---------------------------------------------------------------------------
-- The live numbers (reused tables, filled once a second)
---------------------------------------------------------------------------

local view = { n = 0, total = 0, yards = 0, secs = {}, wait = {}, ride = {}, timed = {}, board = {}, dep = {} }
JP.view = view

local DOCK = 60 -- yards from where a ride leaves: at the dock (Travel's BOARD)

-- The current leg and when it became current, stamped on every route event
-- whether or not the panel is on screen, so reopening the window keeps the
-- countdown.
local legStart, stampLegs, stampCi = 0, nil, nil

local function now() return GetTime and GetTime() or 0 end

local function stamp(legs, ci)
	if legs ~= stampLegs or ci ~= stampCi then
		stampLegs, stampCi, legStart = legs, ci, now()
	end
end

local function transitNow()
	local X = ns.Transit
	if X and X.Now then
		local ok, t = pcall(X.Now)
		if ok and finite(t) then return t end
	end
	return GetServerTime and GetServerTime() or 0
end

-- The transport a leg waits for: kind, id | nil.
local function serviceOf(leg)
	if leg.kind == "lift" then return leg.lift ~= nil and "lift" or nil, leg.lift end
	if leg.transport and leg.kind ~= "portal" then return leg.kind, leg.transport.id end
	return nil
end

-- wait, ride, timed for a leg reached at server time `at`, or nil.
-- `docked`: the player stands at the dock now, so a visit leaving within the
-- service's boarding window still counts (Transit.NextArrival asks with none).
local function departure(leg, at, docked)
	local X = ns.Transit
	local kind, id = serviceOf(leg)
	if not (kind and X and X.NextDeparture) then return nil end
	local ok, wait, ride, timed = pcall(X.NextDeparture, kind, id, at, leg.side)
	if not ok or not finite(wait) then return nil end
	if docked and X.NextArrival then
		local ok2, _, departIn = pcall(X.NextArrival, kind, id, at, leg.side)
		if ok2 and finite(departIn) and departIn >= 0 and departIn < wait then wait = departIn end
	end
	return wait, finite(ride) and ride or 0, timed and true or false
end

local function atDock(leg)
	local from = leg.from
	local C = ns.Compat
	if type(from) ~= "table" or not (C and C.GetPlayerWorldPosition) then return false end
	local ok, pc, px, py = pcall(C.GetPlayerWorldPosition)
	if not ok or pc == nil or pc ~= from.c or not (finite(px) and finite(py) and finite(from.wx) and finite(from.wy)) then return false end
	local dx, dy = px - from.wx, py - from.wy
	return dx * dx + dy * dy <= DOCK * DOCK
end

-- Seconds and yards left on the current leg. A walk asks Travel.Progress
-- (along the path from where the player stands); any other leg counts its
-- planned time down from when it became current, since Progress gives
-- those as planned.
local function progress(leg)
	if leg.kind == "walk" then
		local T = ns.Nav and ns.Nav.travel
		if T and T.Progress then
			local ok, s, y = pcall(T.Progress)
			if ok and finite(s) then return s, y end
		end
	end
	local s = (finite(leg.seconds) and leg.seconds or 0) - (now() - legStart)
	return s, leg.yards
end

-- Fill `view` from legs[ci..]: per step whole seconds (waits included), the
-- departure line's parts, and the totals.
function JP.Compute(legs, ci)
	local at = transitNow()
	local n, total, yards = 0, 0, 0
	for i = ci, #legs do
		local leg = legs[i]
		n = n + 1
		local s, y
		if i == ci then s, y = progress(leg) else s, y = leg.seconds, leg.yards end
		local hasDep, wait, ride, timed, board = false, 0, 0, false, false
		if serviceOf(leg) then
			hasDep = true
			local X = ns.Transit
			local riding = i == ci and X and X.Riding and X.Riding(at)
			if type(riding) == "table" and riding.kind == leg.kind and finite(riding.arriveIn) then
				board, ride = true, riding.arriveIn
			else
				local w, r, t = departure(leg, at + total, i == ci and atDock(leg))
				if w then
					wait, ride, timed = w, r, t
				else
					hasDep = false
				end
			end
			if hasDep then s = whole(wait) + whole(ride) end
		end
		s = whole(s)
		view.secs[n], view.dep[n] = s, hasDep
		view.wait[n], view.ride[n], view.timed[n], view.board[n] = whole(wait), whole(ride), timed, board
		total = total + s
		if finite(y) and y > 0 then yards = yards + y end
	end
	view.n, view.total, view.yards = n, total, yards
	return view
end

-- "leaves in about 0:15 · ride 0:10" (untimed: the loop's average wait).
function JP.DepartureText(i)
	if view.board[i] then return format(L["on board \194\183 %s"], JP.FormatTime(view.ride[i])) end
	local lead = view.timed[i] and L["leaves in %s"] or L["leaves in about %s"]
	return format(L["%s \194\183 ride %s"], format(lead, JP.FormatTime(view.wait[i])), JP.FormatTime(view.ride[i]))
end

---------------------------------------------------------------------------
-- What to show
---------------------------------------------------------------------------

-- legs, ci while there is a journey to show, else nil.
function JP.Route()
	if not ns.Get("nav.journeySteps") then return nil end
	local Nav = ns.Nav
	local T = Nav and Nav.travel
	if not (T and T.Active and T.Active() and Nav.GetRoute) then return nil end
	local legs, ci = Nav.GetRoute()
	if type(legs) ~= "table" or not ci or ci > #legs or #legs < 2 then return nil end
	return legs, ci
end

local function destination(legs)
	local Nav = ns.Nav
	local t = Nav and Nav.GetTarget and Nav.GetTarget()
	if type(t) == "table" and nonEmpty(t.label) then return t.label end
	return placeName(legs[#legs].to) or L["your goal"]
end

---------------------------------------------------------------------------
-- Frames
---------------------------------------------------------------------------

local F, head, dest, more
local rows = {}
JP.rows = rows
local shownLegs, shownCi, shownN -- the structure on screen
local ticker

local function GF() return UI.GuideFrame end

local function text(parent, role, color)
	local G = GF()
	if G and G.Text then return G.Text(parent, role, color) end
	return W.Text(parent, role, color)
end

local function anchor()
	local G = GF()
	return G and G.TooltipAnchor and G.TooltipAnchor() or "ANCHOR_RIGHT"
end

local function hoverIn()
	local G = GF()
	if G and G.HoverIn then G.HoverIn() end
end

local function rowClick(self)
	if not self.psCurrent then return end
	local P = ns.Nav and ns.Nav.prompts
	if P and P.OpenMenu and P.MenuItems and P.MenuItems() then P.OpenMenu(self) end
end

local function rowEnter(self)
	local lines = {}
	if self.Sub:IsShown() then lines[#lines + 1] = self.Sub:GetText() end
	local P = ns.Nav and ns.Nav.prompts
	if self.psCurrent and P and P.MenuItems and P.MenuItems() then
		lines[#lines + 1] = { L["Click to skip this leg"], Theme.Accent() }
	end
	W.Tooltip(self, anchor(), self.Text:GetText() or "", lines)
	hoverIn()
end

local function row(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, F.List)
	r:SetHeight(ROW_H)
	W.Hover(r)
	r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
	r.Num = text(r, "number", "textMuted")
	r.Num:SetJustifyH("RIGHT")
	r.Num:SetWidth(22)
	r.Num:SetPoint("LEFT", r, "TOPLEFT", PAD - 10, -ROW_H / 2)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(13, 13)
	r.Icon:SetPoint("LEFT", r, "TOPLEFT", TEXT_X - 2, -ROW_H / 2)
	r.Text = text(r, "label", "textDim")
	r.Text:SetPoint("LEFT", r.Icon, "RIGHT", 9, 0)
	r.Time = text(r, "number", "textMuted")
	r.Time:SetJustifyH("RIGHT")
	r.Time:SetWidth(TIME_W)
	r.Time:SetPoint("RIGHT", r, "TOPRIGHT", -PAD, -ROW_H / 2)
	r.Sub = text(r, "small", "textDim")
	r.Sub:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -2)
	r:SetScript("OnClick", rowClick)
	r:SetScript("OnEnter", rowEnter)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	rows[i] = r
	return r
end

local function open() return ns.Get("nav.journeyOpen") and true or false end

local function build()
	local G = GF()
	local body = G and G.parts and G.parts.body
	if F or not body then return end
	F = CreateFrame("Frame", nil, body)
	F:Hide()
	JP.frame = F

	head = CreateFrame("Button", nil, F)
	head:SetHeight(HEAD_H)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
	W.Hover(head, 0.7)
	head.Rule = W.Divider(head)
	head.Rule:SetPoint("TOPLEFT", head, "TOPLEFT", PAD, 0)
	head.Rule:SetPoint("TOPRIGHT", head, "TOPRIGHT", -PAD, 0)
	head.Label = text(head, "small", "textMuted")
	head.Label:SetPoint("LEFT", head, "LEFT", PAD, 0)
	head.Label:SetText(L["Journey"])
	head.Icon = head:CreateTexture(nil, "ARTWORK")
	head.Icon:SetSize(12, 12)
	head.Icon:SetPoint("RIGHT", head, "RIGHT", -PAD, 0)
	W.Color(head.Icon, "textMuted")
	head.Dist = text(head, "number", "textDim")
	head.Dist:SetJustifyH("RIGHT")
	head.Dist:SetPoint("RIGHT", head.Icon, "LEFT", -8, 0)
	head.Dot = text(head, "number", "textMuted")
	head.Dot:SetText("\194\183")
	head.Dot:SetPoint("RIGHT", head.Dist, "LEFT", -5, 0)
	head.Time = text(head, "number", "text")
	head.Time:SetJustifyH("RIGHT")
	head.Time:SetPoint("RIGHT", head.Dot, "LEFT", -5, 0)
	head:SetScript("OnClick", function() ns.Set("nav.journeyOpen", not open()) end)
	head:SetScript("OnEnter", function(self)
		W.Color(self.Label, "textDim")
		W.Tooltip(self, anchor(), L["Journey"], { open() and L["Click to collapse"] or L["Click to expand"] })
		hoverIn()
	end)
	head:SetScript("OnLeave", function(self)
		W.Color(self.Label, "textMuted")
		W.HideTooltip(self)
	end)
	JP.head = head

	-- Everything under the header, hidden while collapsed.
	F.List = CreateFrame("Frame", nil, F)
	F.List:SetPoint("TOPLEFT", F, "TOPLEFT", 0, -HEAD_H)
	F.List:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, -HEAD_H)
	dest = text(F.List, "label", "textDim")
	JP.dest = dest
	more = text(F.List, "small", "textMuted")
	JP.more = more

	F:SetScript("OnShow", function() JP.StartTicker() end)
	F:SetScript("OnHide", function() JP.StopTicker() end)
end

---------------------------------------------------------------------------
-- Painting
---------------------------------------------------------------------------

-- Labels, glyphs and colours: only when the steps themselves change.
local function fillStructure(legs, ci)
	local n = #legs - ci + 1
	local shown = n > MAX_ROWS and MAX_ROWS or n
	for i = 1, shown do
		local leg = legs[ci + i - 1]
		local r = row(i)
		local current = i == 1
		r.psCurrent = current
		r.psLeg = ci + i - 1
		r.Num:SetFormattedText("%d", ci + i - 1)
		r.Icon:SetTexture(Theme.Media(glyphOf(leg)))
		r.Text:SetText(JP.StepText(leg))
		r.Bar:SetShown(current)
		W.Color(r.Icon, current and "accent" or "textMuted")
		W.Color(r.Text, current and "text" or "textDim")
		W.Color(r.Time, current and "text" or "textMuted")
		W.Color(r.Num, current and "textDim" or "textMuted")
		-- The line under the step: a ride's departure once known, a walk's hostile towns.
		r.psHub = hubText(leg)
		W.Color(r.Sub, r.psHub and "warning" or "textDim")
		r.Sub:Hide()
		r:SetHeight(ROW_H)
		r:Show()
	end
	for i = shown + 1, #rows do rows[i]:Hide() end
	more:SetShown(n > shown)
	if n > shown then
		local left = n - shown
		more:SetText(left == 1 and L["1 more step"] or format(L["%d more steps"], left))
	end
	dest:SetText(format(L["To %s"], "|c" .. Theme.Hex("place") .. destination(legs) .. "|r"))
	shownLegs, shownCi, shownN = legs, ci, n
end

-- Times only: once a second and on transit news. Never changes a height.
local function fillTimes()
	setTime(head.Time, view.total)
	local yd = view.yards
	head.Dist:SetShown(yd > 0)
	head.Dot:SetShown(yd > 0)
	if yd > 0 then head.Dist:SetText(JP.FormatDistance(yd)) end
	for i = 1, #rows do
		local r = rows[i]
		if r:IsShown() then
			setTime(r.Time, view.secs[i])
			if r.Sub:IsShown() then r.Sub:SetText(view.dep[i] and JP.DepartureText(i) or r.psHub) end
		end
	end
end

local function relayout()
	local G = GF()
	if G and G.Layout then G.Layout() end
end

-- Bring the panel up to date. force: repaint the structure too (settings,
-- theme). Lays the window out only when what is shown changes shape.
function JP.Refresh(force)
	if not F then build() end
	if not F then return end
	local legs, ci = JP.Route()
	local had = F.psHas
	if not legs then
		F.psHas = false
		shownLegs = nil
		if had then relayout() end
		return
	end
	F.psHas = true
	local changed = force or legs ~= shownLegs or ci ~= shownCi or #legs - ci + 1 ~= shownN
	stamp(legs, ci)
	if changed then fillStructure(legs, ci) end
	head.Icon:SetTexture(Theme.Media(open() and "chevron-up" or "chevron-down"))
	JP.Compute(legs, ci)
	-- The line under a step only where there is something to say: a known
	-- departure, a walk's hostile towns (none: no empty line).
	for i = 1, #rows do
		local r = rows[i]
		if r:IsShown() then
			local want = (view.dep[i] or r.psHub) and true or false
			if r.Sub:IsShown() ~= want then
				r.Sub:SetShown(want)
				r:SetHeight(want and ROW_H + SUB_H or ROW_H)
				changed = true
			end
		end
	end
	fillTimes()
	if changed or not had then relayout() end
	if F:IsVisible() then JP.StartTicker() end
end

-- Height at `width`, rows placed (GuideFrame's Layout calls this).
function JP.Layout(width)
	if not F then return 0 end
	local list = F.List
	local isOpen = open()
	list:SetShown(isOpen)
	if not isOpen then
		F:SetHeight(HEAD_H)
		return HEAD_H
	end
	dest:SetWidth(width - TEXT_X - PAD)
	dest:ClearAllPoints()
	dest:SetPoint("LEFT", list, "TOPLEFT", TEXT_X, -(DEST_H / 2 - 2))
	local y = DEST_H
	local textW = width - (TEXT_X + 22) - PAD - TIME_W - 8
	for i = 1, #rows do
		local r = rows[i]
		if r:IsShown() then
			r.Text:SetWidth(textW)
			r.Sub:SetWidth(textW + TIME_W)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -y)
			r:SetPoint("TOPRIGHT", list, "TOPRIGHT", 0, -y)
			y = y + r:GetHeight()
		end
	end
	if more:IsShown() then
		more:ClearAllPoints()
		more:SetPoint("LEFT", list, "TOPLEFT", TEXT_X + 22, -(y + MORE_H / 2))
		y = y + MORE_H
	end
	y = y + 6
	list:SetHeight(y)
	F:SetHeight(HEAD_H + y)
	return HEAD_H + y
end

-------------------------------------------------------------------------
-- The once-a-second countdown, only while the panel is on screen
---------------------------------------------------------------------------

local function tick()
	if not (F and F:IsVisible()) then
		JP.StopTicker()
		return
	end
	JP.Refresh()
end

function JP.StartTicker()
	if ticker or not (C_Timer and C_Timer.NewTicker) then return end
	ticker = C_Timer.NewTicker(1, tick)
end

function JP.StopTicker()
	if ticker then
		ticker:Cancel()
		ticker = nil
	end
end

function JP.Ticking() return ticker ~= nil end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

local function guideShown()
	local f = _G.PolestarGuideFrame
	return f and f:IsShown() and ns.IsLoggedIn()
end

local function wake() if guideShown() then JP.Refresh() end end

ns.OnInit(function()
	build()
	local f = _G.PolestarGuideFrame
	if f then f:HookScript("OnShow", function() JP.Refresh(true) end) end
end)
ns.OnLogin(function() JP.Refresh(true) end)

-- A new plan repaints the steps even when Travel reuses its legs table.
-- Either event stamps when the current leg began, on screen or not.
local function routeEvent(force)
	return function()
		local Nav = ns.Nav
		if Nav and Nav.GetRoute then stamp(Nav.GetRoute()) end
		if guideShown() then JP.Refresh(force) end
	end
end
ns.On("ROUTE_CHANGED", routeEvent(true))
ns.On("ROUTE_ADVANCED", routeEvent(false))
ns.On("NAV_TRANSIT", wake)
ns.On("WAYPOINT_CHANGED", wake)
ns.On("SETTING_CHANGED", function(path)
	if not guideShown() then return end
	if path == "nav.journeyOpen" then
		JP.Refresh()
		relayout()
	elseif path == "" or type(path) == "string" and (path == "nav" or path:find("^nav%.")) then
		JP.Refresh(true)
	end
end)
Theme.OnChanged(function() if guideShown() then JP.Refresh(true) end end)

if ns.Nav and ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			ns.Nav.HandoffOption({ kind = "toggle", key = "nav.journeySteps", label = L["Show the journey"],
				help = L["The route's steps in the guide window with a time for each, counting down: walks, lifts, boats and flights. Click the current step to skip it."] }),
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
