-- The guide window, a compact instrument that reads one thing at a time
-- (docs/DESIGN.md, "Intent" and "The Guide Window"). From the top:
--
--   tab strip      one tab per open guide, + opens another
--   navigator      prev, "8 / 29", next, Skip, the bug (UI/Report.lua), menu
--   banner         why the guide skipped a quest / out-levelled / training due
--   focus          the person to talk to now: icon, name in NPC colour, where;
--                  under it only that person's goals, one line each, the
--                  counter right after the text. A field step shows its few
--                  objectives under the step title. Done goals check and dim;
--                  a done step (viewed with Prev) lists all its goals.
--                  The author's tip, collapsed to one line.
--   journey        the travel route's steps and times (UI/JourneyPanel.lua),
--                  while the route has more than one leg
--   then           "Then: <next person>" and "Person 2 of 8"
--   up next        off by default (ui.upcoming)
--   xp             the QoL module's XP pace, when on
--   progress       the guide's progress bar and percent
--
-- The Engine groups a step's goals by who they are with (step view `groups`
-- and `focus`, docs/ARCHITECTURE.md "Focus: one person at a time"); without
-- groups the whole step is one group.
--
-- Styles (ui.style): "standard" draws the night ground (Theme.GroundAlpha,
-- ui.bgOpacity, like every Polestar window), hairline border and the
-- night-sky band behind the tabs and navigator. "transparent" draws no fills
-- or borders; every string is outlined so it reads over any terrain, the
-- progress track stays as a faint ink line, and the chrome (tabs, the whole
-- navigator: prev, "8 / 29", next, title, Skip, the bug, menu; the grip)
-- shows only while the cursor is over the window: the step number fades with
-- the chevrons that change it, so it never floats alone. Compact mode
-- (ui.compact) keeps the navigator, the focus goals and the progress bar.
--
-- Colour: the accent marks interaction and where you are (the active tab,
-- the arrow's target mark, the current goal's glyph, primary buttons, the
-- progress fill). Other glyphs sit in textDim, counters in text (success
-- once complete; UI.GoalLine), tooltip ids in textMuted. No colour literals:
-- everything reads Theme tokens and repaints on a scheme change.
--
-- Rows are pooled and filled in place, so STEP_UPDATED (a kill, a loot)
-- repaints existing rows instead of rebuilding anything. Nothing runs per
-- frame except a short tween (Polestar.Anim), an active drag-resize, or the
-- hover watch while the cursor is over a transparent window.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, abs, type, ipairs = math.floor, math.max, math.min, math.abs, type, ipairs

local PAD = 14
local TAB_H = 28
local NAV_H = 34
local PROG_H = 26
local ICON = 15
local TEXT_X = PAD + ICON + 10
local ROW_MIN = 24
local CHECK = 18
local UP_ROW = 24
local UP_TOGGLE = 30
local COMBAT_ALPHA = 0.35
local TAB_MAX_W = 150

local GF = {}
UI.GuideFrame = GF

local F, strip, nav, body, card, person, after, upnext, empty, grip, band, banner, foot
local rows, upRows, tabButtons = {}, {}, {}
GF.rows, GF.upRows, GF.tabs = rows, upRows, tabButtons -- the pools, for inspection (tests, preview)
local view -- the step view on screen
local focusGroup -- the group on screen
local shownIndex, shownGuide, shownFocus -- what the card shows, to tell a change from an update
local tipOpen = false
local inCombat = false
local state = "none" -- "steps" | "noguides" | "noguide" | "notyet" | "complete"
local texts = {} -- every string the window draws, for transparent-mode outlines
local chrome = {} -- frames that hide in transparent mode until hovered

local function Engine() return ns.Engine end
local function compact() return ns.Get("ui.compact") and true or false end
local function transparent() return ns.Get("ui.style") == "transparent" end

-- A string that follows the window's style (outlined when transparent).
local function T(parent, role, color, layer)
	local fs = W.Text(parent, role, color, layer)
	texts[#texts + 1] = fs
	if F and transparent() then Theme.SetOutline(fs, true) end
	return fs
end
GF.Text = T -- for the panels other files place in the window (UI/JourneyPanel.lua)

---------------------------------------------------------------------------
-- Targets and tooltips
---------------------------------------------------------------------------

-- Where the arrow points. With Nav loaded its answer is final: nil means the
-- player dismissed the target, so nothing is marked. Only without Nav does
-- the Engine's waypoint stand in.
local function targetOf()
	local nav = ns.Nav
	if nav and nav.GetTarget then return nav.GetTarget() end
	local E = Engine()
	return E and E.GetWaypoint and E.GetWaypoint() or nil
end

local function isTarget(p, t)
	if not (t and p and p.x and p.map) then return false end
	return t.map == p.map and abs((t.x or -1) - p.x) < 0.05 and abs((t.y or -1) - p.y) < 0.05
end

local function tooltipAnchor()
	local x = F:GetCenter()
	local sw = UIParent:GetWidth()
	return (x and sw and x * F:GetEffectiveScale() > sw * UIParent:GetEffectiveScale() / 2) and "ANCHOR_LEFT" or "ANCHOR_RIGHT"
end
GF.TooltipAnchor = tooltipAnchor

local function goalTooltip(row)
	local goal = row.psGoal
	if not goal then return end
	local lines = {}
	local id = "  |c" .. Theme.Hex("textMuted") .. "#"
	local detail = UI.GoalDetail(goal)
	if detail then lines[#lines + 1] = detail end
	if goal.quest then
		local title = UI.QuestTitle(goal.quest) or (goal.subjectKind == "quest" and goal.subject) or nil
		lines[#lines + 1] = { left = L["Quest"], right = title and (title .. id .. goal.quest .. "|r") or ("#" .. goal.quest) }
	end
	if goal.npc then
		local name = goal.subjectKind == "npc" and goal.subject or goal.npcName
		lines[#lines + 1] = { left = L["NPC"], right = name and (name .. id .. goal.npc .. "|r") or ("#" .. goal.npc) }
	end
	if goal.item then
		local name = goal.subjectKind == "item" and goal.subject or nil
		lines[#lines + 1] = { left = L["Item"], right = name and (name .. id .. goal.item .. "|r") or ("#" .. goal.item) }
	end
	if goal.map and goal.x then
		lines[#lines + 1] = { left = L["Location"], right = string.format("%s  %.1f, %.1f", UI.MapName(goal.map) or "", goal.x, goal.y) }
	end
	local rewards = UI.GoalRewards(goal)
	if rewards then lines[#lines + 1] = { left = L["Reward"], right = rewards } end
	local p = goal.progress
	if type(p) == "table" and p.kind == "skill" and p.max then
		lines[#lines + 1] = { left = L["Skill"], right = string.format("%s%d/%d", p.label and (p.label .. "  ") or "", p.cur or 0, p.max) }
	elseif type(p) == "table" and p.kind == "rep" and p.max then
		local right = string.format("%s%d/%d", p.label and (p.label .. "  ") or "", p.cur or 0, p.max)
		if goal.standingName then right = right .. "  \226\128\186  " .. goal.standingName end
		lines[#lines + 1] = { left = L["Reputation"], right = right }
	else
		local text = UI.GoalProgress(goal)
		if text then lines[#lines + 1] = { left = L["Progress"], right = text } end
	end
	if goal.spell then lines[#lines + 1] = { left = L["Spell"], right = "#" .. goal.spell } end
	if goal.achievement then
		lines[#lines + 1] = { left = L["Achievement"], right = "#" .. goal.achievement .. (goal.criteria and ("  \194\183  " .. L["criterion"] .. " " .. goal.criteria) or "") }
	end
	if type(goal.alternatives) == "number" and goal.alternatives > 0 then
		lines[#lines + 1] = goal.alternatives == 1 and L["1 other nearby; the arrow button switches to it."]
			or string.format(L["%d others nearby; the arrow button switches to the next."], goal.alternatives)
	elseif type(goal.spots) == "number" and goal.spots > 1 then
		lines[#lines + 1] = string.format(L["%d spawn spots; the arrow button (or a click on the arrow) moves to the next."], goal.spots)
	end
	local ar, ag, ab = Theme.Accent()
	if goal.x and goal.map and ns.Nav and ns.Nav.SetTarget then
		lines[#lines + 1] = { L["Click to point the arrow here"], ar, ag, ab }
	end
	if goal.tickable and goal.status ~= "skipped" then
		if goal.ticked then
			lines[#lines + 1] = { L["Right-click to untick"], ar, ag, ab }
		elseif goal.status ~= "done" then
			lines[#lines + 1] = { L["Right-click to tick it done"], ar, ag, ab }
		end
	end
	if goal.optional and goal.status ~= "done" then
		lines[#lines + 1] = goal.dismissed and L["Skipped. Undo brings it back."] or L["Optional: not needed for the route. Skip it if you pass on it."]
	end
	W.Tooltip(row, tooltipAnchor(), goal.text or "", lines)
end

-- `p`: a goal's or group's place from the step view, its height `z` included.
local function pointAt(p, label)
	local nav = ns.Nav
	if p and p.x and p.map and nav and nav.SetTarget then
		nav.SetTarget(p.map, p.x, p.y, label, p.f, nil, p.z)
		GF.UpdateTargets()
	end
end

---------------------------------------------------------------------------
-- Goal rows
---------------------------------------------------------------------------

-- Tick the row's goal done, or untick it (any goal but a note).
local function toggleGoal(row)
	local E, goal = Engine(), row.psGoal
	if E and E.ToggleGoal and goal and goal.tickable and view then E.ToggleGoal(view.index, goal.index) end
end

-- Skip an optional goal, or bring it back.
local function skipGoal(row)
	local E, goal = Engine(), row.psGoal
	if E and E.SkipGoal and goal and goal.optional and view then E.SkipGoal(view.index, goal.index) end
end

local function rowClick(row, button)
	local goal = row.psGoal
	if not goal then return end
	if button == "RightButton" then
		toggleGoal(row)
		return
	end
	-- A goal of the step the guide is on: the Engine leads the arrow there
	-- (its spawn areas and spots too) and drops any point picked by hand.
	-- Anywhere else, a plain point.
	local E, nav = Engine(), ns.Nav
	if view and E and E.AimGoal and E.GetStepIndex and E.GetStepIndex() == view.index and E.AimGoal(view.index, goal.index) then
		if nav and nav.ReleaseTarget then nav.ReleaseTarget() end
		GF.UpdateTargets()
	else
		pointAt(goal, goal.text)
	end
end

local function rowEnter(row)
	local goal = row.psGoal
	if goal and ((goal.x and goal.map) or goal.tickable) then row.Hover:Show() end
	goalTooltip(row)
	GF.HoverIn()
end

local function rowLeave(row)
	row.Hover:Hide()
	W.HideTooltip(row)
end

local function goalRow(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, card)
	r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	r.Hover = r:CreateTexture(nil, "BACKGROUND")
	r.Hover:SetTexture(Theme.Media("white"))
	r.Hover:SetAllPoints(r)
	W.Painter(r.Hover, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
	r.Hover:Hide()
	-- The arrow's current target: a 2px accent rule at the row's edge (the
	-- selection bar used across Polestar).
	r.Mark = r:CreateTexture(nil, "ARTWORK")
	r.Mark:SetTexture(Theme.Media("white"))
	r.Mark:SetWidth(2)
	r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
	r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
	W.Color(r.Mark, "accent")
	r.Mark:Hide()
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(ICON, ICON)
	r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -12)
	r.Text = T(r, "goal", "text")
	r.Text:SetWordWrap(true)
	r.Text:SetJustifyV("TOP")
	r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -4)
	r.Sub = T(r, "small", "textMuted")
	r.Sub:SetWordWrap(true)
	r.Sub:SetJustifyV("TOP")
	r.Check = W.Checkbox(r, function(c)
		-- The click already flipped the box; the Engine's view is the truth,
		-- so put it back and let STEP_UPDATED repaint it.
		c:SetChecked(c.psChecked)
		toggleGoal(r)
	end)
	r.Check:SetScript("OnEnter", function(c)
		local goal = r.psGoal
		local tip = not goal and "" or (goal.ticked and L["Untick"]) or (goal.status == "done" and L["Done"]) or L["Tick it done"]
		W.Tooltip(c, "ANCHOR_TOP", tip, goal and goal.status == "done" and not goal.ticked and { L["The game counts this one itself."] } or nil)
		GF.HoverIn()
	end)
	r.Check:SetScript("OnLeave", function(c) W.HideTooltip(c) end)
	-- An optional goal's one-click skip ("Skip"), and its undo ("Undo").
	r.Skip = CreateFrame("Button", nil, r)
	r.Skip:SetHeight(18)
	W.Hover(r.Skip, 0.7)
	r.Skip.Label = T(r.Skip, "small", "textDim")
	r.Skip.Label:SetPoint("CENTER", r.Skip, "CENTER", 0, 0)
	r.Skip:SetScript("OnClick", function() skipGoal(r) end)
	r.Skip:SetScript("OnEnter", function(b)
		W.Color(b.Label, "text")
		local goal = r.psGoal
		W.Tooltip(b, "ANCHOR_TOP", goal and goal.dismissed and L["Bring it back"] or L["Skip this optional goal"],
			{ goal and goal.dismissed and L["It leads the arrow again."] or L["The arrow moves on; Undo brings it back."] })
		GF.HoverIn()
	end)
	r.Skip:SetScript("OnLeave", function(b)
		W.Color(b.Label, "textDim")
		W.HideTooltip(b)
	end)
	r.Skip:Hide()
	r.Check:SetPoint("TOPRIGHT", r, "TOPRIGHT", -PAD + 3, -3)
	-- "Other": the next-nearest trainer, vendor, inn or farm spot; for a goal
	-- with spawn areas, the next spot. The arrow follows the goal there: the
	-- Engine aims at it, and a point picked by hand gives way.
	r.Alt = W.IconButton(r, "reload", 20, nil, function()
		local E, goal = Engine(), r.psGoal
		if not (E and goal and view) then return end
		if type(goal.alternatives) == "number" and goal.alternatives > 0 then
			if E.CycleCandidate then E.CycleCandidate(view.index, goal.index) end
		elseif E.CycleSpot then
			E.CycleSpot(view.index, goal.index)
		end
		local nav = ns.Nav
		if nav and nav.ReleaseTarget and E.GetStepIndex and E.GetStepIndex() == view.index then
			nav.ReleaseTarget()
			GF.UpdateTargets()
		end
	end, 11)
	r.Alt.psOnEnter = function(b)
		local goal = r.psGoal
		if goal and not (type(goal.alternatives) == "number" and goal.alternatives > 0) and type(goal.spots) == "number" then
			W.Tooltip(b, "ANCHOR_TOP", L["Next spot"], { string.format(L["%d spots in this area"], goal.spots) })
		else
			local n = goal and goal.alternatives or 0
			W.Tooltip(b, "ANCHOR_TOP", L["Choose another"], { n == 1 and L["1 other nearby"] or string.format(L["%d others nearby"], n) })
		end
		GF.HoverIn()
	end
	r.Alt:Hide()
	r:SetScript("OnClick", rowClick)
	r:SetScript("OnEnter", rowEnter)
	r:SetScript("OnLeave", rowLeave)
	rows[i] = r
	return r
end

-- The slim progress bar under a goal (skill ranks, reputation, achievement
-- criteria): a label, a 3px track and its fill; kept with the row.
local BAR_ROW, BAR_THICK = 13, 3

local function rowBar(r)
	local b = r.psBar
	if b then return b end
	b = CreateFrame("Frame", nil, r)
	b:SetHeight(BAR_ROW)
	b.Label = T(b, "small", "textDim")
	b.Label:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Track = b:CreateTexture(nil, "ARTWORK")
	b.Track:SetTexture(Theme.Media("white"))
	b.Track:SetHeight(BAR_THICK)
	b.Track:SetPoint("RIGHT", b, "RIGHT", 0, 0)
	W.Painter(b.Track, function(t) t:SetVertexColor(Theme.Wash("track")) end)
	b.Fill = b:CreateTexture(nil, "OVERLAY")
	b.Fill:SetTexture(Theme.Media("white"))
	b.Fill:SetHeight(BAR_THICK)
	b.Fill:SetPoint("LEFT", b.Track, "LEFT", 0, 0)
	b.Fill:SetWidth(0.01)
	r.psBar = b
	return b
end

-- Paint a row from its goal. pop = the goal just turned done: the check
-- lands with a short back-out pop (scale only; reduced motion skips it).
-- current = the first open goal of the focus: its glyph alone takes the
-- accent; the others sit in textDim.
-- `noParty`: a row above already says the group line (UI.GoalSubline);
-- `noMissing`: one already names who in the party lacks the goal's quest.
local function paintRow(r, goal, pop, sameStep, current, noParty, noMissing)
	local sameGoal = sameStep and r.psGoal and r.psGoal.index == goal.index and r.psGoal.t == goal.t
	r.psGoal = goal
	local status = goal.status
	local done = status == "done"
	local skipped = status == "skipped"
	r.Icon:SetTexture(done and Theme.Media("check") or (goal.dismissed and Theme.Media("skip")) or Theme.VerbIcon(goal.t))
	if skipped then
		W.Color(r.Icon, "textMuted", 0.8)
	else
		W.Color(r.Icon, done and "success" or (current and "accent" or "textDim"))
	end
	r.Text:SetText(UI.GoalLine(goal))
	-- White while it is to be done; done and skipped goals step back.
	W.Color(r.Text, (done or skipped) and "textMuted" or "text")
	local sub = UI.GoalSubline(goal, person.Where:IsShown() and person.psPlace and person.psPlace.map or nil, noParty, noMissing)
	r.Sub:SetText(sub or "")
	r.Sub:SetShown(sub ~= nil)
	-- An unavailable quest's reason is the point of the line: keep it readable.
	W.Color(r.Sub, goal.unavailable and "textDim" or "textMuted")
	if UI.GearPick then UI.GearPick.Paint(r, goal) end
	local alts = type(goal.alternatives) == "number" and goal.alternatives > 0 and Engine() and Engine().CycleCandidate
	local spots = type(goal.spots) == "number" and goal.spots > 1 and Engine() and Engine().CycleSpot
	r.Alt:SetShown((alts or spots) and not done and not skipped and true or false)
	local frac, label = UI.GoalBar(goal)
	if frac and not skipped then
		local b = rowBar(r)
		b.Label:SetText(label or "")
		b.Label:SetShown(label ~= nil)
		W.Color(b.Fill, done and "success" or "accent", status == "pending" and 0.6 or 1)
		-- Fill from where it was when the same goal moved on (a rank, a
		-- reputation tick); jump when the row now shows a different goal.
		b.psFrom = (sameGoal and b:IsShown() and b.psFrac ~= frac) and b.psFrac or nil
		b.psFrac = frac
		b:Show()
	elseif r.psBar then
		r.psBar:Hide()
	end
	-- Every goal ticks (a note never); a goal the game itself counts done
	-- shows its check but has nothing to undo.
	r.Check:SetShown(goal.tickable and not skipped and true or false)
	r.Check.psChecked = done
	r.Check:SetChecked(done)
	local locked = done and not goal.ticked
	if locked then r.Check:Disable() else r.Check:Enable() end
	r.Check:SetAlpha(locked and 0.45 or 1)
	-- An open optional goal skips in one click; a skipped one comes back.
	local canSkip = goal.optional and (goal.dismissed or (not done and not skipped)) and Engine() and Engine().SkipGoal
	r.Skip:SetShown(canSkip and true or false)
	if canSkip then
		r.Skip.Label:SetText(goal.dismissed and L["Undo"] or L["Skip"])
		r.Skip:SetWidth(floor(r.Skip.Label:GetStringWidth() + 12 + 0.5))
	end
	if pop then
		Anim.To(r.Icon, "size", ICON * 0.55, ICON, Anim.BASE, "back")
		Anim.To(r.Icon, "alpha", 0.2, 1, Anim.FAST, "out")
	elseif not Anim.IsRunning(r.Icon, "size") then
		r.Icon:SetSize(ICON, ICON)
	end
	r.psStatus = status
end

local function layoutBar(b, tw)
	local lw = 0
	if b.Label:IsShown() then lw = floor(b.Label:GetStringWidth() + 8 + 0.5) end
	local trackW = max(24, tw - lw)
	b:SetWidth(tw)
	b.Track:SetWidth(trackW)
	local w = max(0.01, trackW * b.psFrac)
	if b.psFrom then
		Anim.To(b.Fill, "width", max(0.01, trackW * b.psFrom), w, Anim.SLOW, "out")
		b.psFrom = nil
	elseif not Anim.IsRunning(b.Fill, "width") then
		b.Fill:SetWidth(w)
	end
end

-- Measure a row at a width; returns its height.
local function measureRow(r, width)
	-- Right edge, outside in: the tick, an optional goal's Skip, "Other".
	local right = PAD
	if r.Check:IsShown() then right = right + CHECK + 4 end
	if r.Skip:IsShown() then
		r.Skip:ClearAllPoints()
		r.Skip:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(right - 4), -3)
		right = right + r.Skip:GetWidth() + 2
	end
	if r.Alt:IsShown() then
		r.Alt:ClearAllPoints()
		r.Alt:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(right - 4), -2)
		right = right + 20
	end
	local tw = max(40, width - TEXT_X - right)
	r.Text:SetWidth(tw)
	local h = 4 + r.Text:GetStringHeight()
	local above = r.Text
	local b = r.psBar
	if b and b:IsShown() then
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -5)
		layoutBar(b, tw)
		h = h + 5 + BAR_ROW
		above = b
	end
	if UI.GearPick then h, above = UI.GearPick.Measure(r, tw, h, above) end
	if r.Sub:IsShown() then
		r.Sub:SetWidth(tw)
		r.Sub:ClearAllPoints()
		r.Sub:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -3)
		h = h + 3 + r.Sub:GetStringHeight()
	end
	return max(ROW_MIN, floor(h + 6 + 0.5))
end

---------------------------------------------------------------------------
-- The focus header: who to talk to now (or the field step's title)
---------------------------------------------------------------------------

-- A group's place: its own position, else its first located goal.
local function groupPlace(group)
	if group.map and group.x then return group end
	for _, gi in ipairs(group.goals or {}) do
		local g = view.goals[gi]
		if g and g.map and g.x and g.status ~= "na" then return g end
	end
	return nil
end

-- A person speaks, an object is used, a field group is a place.
local GROUP_VERB = { npc = "talk", object = "interact", here = "goto" }

-- The arrow on the header: on its person, or on the "Go to" it stands for
-- (a field step's own place, `person.psHeaderGoal`, shown as the header).
local function personMarked(t)
	if person.psPerson and isTarget(person.psPlace, t) then return true end
	local hg = person.psHeaderGoal
	return hg ~= nil and hg.status ~= "done" and hg.status ~= "skipped" and isTarget(hg, t)
end

local function paintPerson(group)
	local kind = group.kind or "here"
	local verb = GROUP_VERB[kind] or "goto"
	person.Icon:SetTexture(Theme.VerbIcon(verb))
	W.Color(person.Icon, "textDim")
	person.Name:SetText(UI.GroupName(view, group))
	W.Color(person.Name, kind == "here" and "text" or (kind == "object" and "object" or "npc"))
	local place = groupPlace(group)
	local where = place and UI.MapName(place.map) or nil
	person.Where:SetText(where or "")
	person.Where:SetShown(where ~= nil)
	person.psPlace = place
	person.psLabel = UI.GroupName(view, group)
	-- The arrow on this person marks the header; a field group's goals carry
	-- their own marks, except the "Go to" the header stands for.
	person.psPerson = kind ~= "here"
	person.Mark:SetShown(personMarked(targetOf()))
end

local function personEnter(self)
	local lines = {}
	if self.psPlace then
		lines[#lines + 1] = { left = L["Location"], right = string.format("%s  %.1f, %.1f", UI.MapName(self.psPlace.map) or "", self.psPlace.x, self.psPlace.y) }
		local r, g, b = Theme.Accent()
		lines[#lines + 1] = { L["Click to point the arrow here"], r, g, b }
	end
	if view and view.title and view.title ~= self.psLabel then lines[#lines + 1] = view.title end
	W.Tooltip(self, tooltipAnchor(), self.psLabel or "", lines)
	GF.HoverIn()
end

---------------------------------------------------------------------------
-- Upcoming steps (off by default; collapsed when on)
---------------------------------------------------------------------------

local function upRow(i)
	local r = upRows[i]
	if r then return r end
	r = CreateFrame("Button", nil, upnext)
	r:SetHeight(UP_ROW)
	W.Hover(r)
	r.Num = T(r, "number", "textMuted")
	r.Num:SetJustifyH("RIGHT")
	r.Num:SetWidth(22)
	r.Num:SetPoint("LEFT", r, "LEFT", PAD - 10, 0)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(13, 13)
	r.Icon:SetPoint("LEFT", r, "LEFT", TEXT_X - 2, 0)
	W.Color(r.Icon, "textMuted")
	r.Text = T(r, "label", "textDim")
	r.Text:SetPoint("LEFT", r.Icon, "RIGHT", 9, 0)
	r:SetScript("OnClick", function(self)
		local E = Engine()
		if E and E.Goto and self.psIndex then E.Goto(self.psIndex) end
	end)
	r:SetScript("OnEnter", function(self)
		W.Tooltip(self, tooltipAnchor(), self.psSummary or "", { { L["Click to jump to this step"], Theme.Accent() } })
		GF.HoverIn()
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	upRows[i] = r
	return r
end

local function upcomingOpen() return ns.Get("ui.upcomingOpen") and true or false end

---------------------------------------------------------------------------
-- Tab strip
---------------------------------------------------------------------------

local function tabsOf(E)
	if not (E and E.GetTabs) then return nil, nil end
	local ok, tabs, active = pcall(E.GetTabs)
	if not ok or type(tabs) ~= "table" then return nil, nil end
	return tabs, active
end

local function tabMenu(self)
	local E = Engine()
	local i = self.psIndex
	local tabs = tabsOf(E) or {}
	W.ShowMenu(self, {
		{ text = L["Close tab"], icon = "close", onClick = function() E.CloseTab(i) end },
		{ text = L["Move left"], icon = "chevron-left", disabled = i <= 1, onClick = function() E.MoveTab(i, i - 1) end },
		{ text = L["Move right"], icon = "chevron-right", disabled = i >= #tabs, onClick = function() E.MoveTab(i, i + 1) end },
	}, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -2 })
end

-- A tab's label: the title, then its level range in a dimmer string. The
-- range tells same-named guides apart, so it keeps its width and the title
-- truncates; `pad` is the room kept at the right (more while the close button
-- shows). Too narrow for even the range, the tab is its glyph alone.
local TAB_TEXT_X = 27 -- the label's left edge: the glyph's inset, width and gap
local TAB_RANGE_GAP = 4
local function layoutTab(b, pad)
	local room = b:GetWidth() - TAB_TEXT_X - pad
	local rangeW = b.psRange and (floor(b.Range:GetStringWidth() + 1) + TAB_RANGE_GAP) or 0
	local fits = rangeW <= room
	local titleW = fits and min(b.psTitleW, room - rangeW) or 0
	b.Label:SetShown(titleW >= 1)
	if titleW >= 1 then b.Label:SetWidth(titleW) end
	b.Range:SetShown(b.psRange and fits or false)
	b.Range:ClearAllPoints()
	b.Range:SetPoint("LEFT", b.Icon, "RIGHT", 6 + (titleW >= 1 and titleW + TAB_RANGE_GAP or 0), 0)
end

local function tabButton(i)
	local b = tabButtons[i]
	if b then return b end
	b = CreateFrame("Button", nil, strip)
	b:SetHeight(TAB_H)
	b:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
	b.Selected = b:CreateTexture(nil, "BACKGROUND")
	b.Selected:SetTexture(Theme.Media("white"))
	b.Selected:SetAllPoints(b)
	W.Painter(b.Selected, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
	W.Hover(b, 0.7)
	b.Bar = b:CreateTexture(nil, "OVERLAY")
	b.Bar:SetTexture(Theme.Media("white"))
	b.Bar:SetHeight(2)
	b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	b.Bar:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
	W.Color(b.Bar, "accent")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetSize(12, 12)
	b.Icon:SetPoint("LEFT", b, "LEFT", 9, 0)
	b.Label = T(b, "small", "textDim")
	b.Label:SetPoint("LEFT", b.Icon, "RIGHT", 6, 0)
	b.Range = T(b, "small", "textMuted")
	b.Close = W.IconButton(b, "close", 16, L["Close tab"], function(self)
		local E = Engine()
		if E and E.CloseTab then E.CloseTab(self:GetParent().psIndex) end
	end, 9)
	b.Close:SetPoint("RIGHT", b, "RIGHT", -3, 0)
	b.Close:SetAlpha(0)
	b.Close.psOnEnter = function(c) c:SetAlpha(1) end
	b.Close.psOnLeave = function(c) if not c:GetParent():IsMouseOver() then c:SetAlpha(0) end end
	b:SetScript("OnClick", function(self, button)
		local E = Engine()
		if not E then return end
		if button == "RightButton" then return tabMenu(self) end
		if button == "MiddleButton" and E.CloseTab then return E.CloseTab(self.psIndex) end
		if E.SelectTab and not self.psActive then E.SelectTab(self.psIndex) end
	end)
	b:SetScript("OnEnter", function(self)
		self.Close:SetAlpha(1)
		layoutTab(self, 20)
		local lines = {}
		if self.psMeta and self.psMeta ~= "" then lines[#lines + 1] = self.psMeta end
		if self.psProgress then lines[#lines + 1] = self.psProgress end
		lines[#lines + 1] = { L["Right-click for tab options"], Theme.Accent() }
		W.Tooltip(self, "ANCHOR_TOP", self.psTitle or "", lines)
		GF.HoverIn()
	end)
	b:SetScript("OnLeave", function(self)
		self.Close:SetAlpha(0)
		layoutTab(self, 8)
		W.HideTooltip(self)
	end)
	tabButtons[i] = b
	return b
end

local CATEGORY_ICON = {
	Leveling = "icon-level", Class = "icon-train", Professions = "icon-craft", Reputation = "icon-rep", Legacy = "icon-achieve",
	Exploration = "icon-explore", Collectibles = "star", Dungeons = "icon-kill",
}
GF.CATEGORY_ICON = CATEGORY_ICON

function GF.RenderTabs()
	if not F then return end
	local tabs, active = tabsOf(Engine())
	local n = tabs and #tabs or 0
	strip.psCount = n
	local avail = F:GetWidth() - 2 - 30
	-- The active tab gets the room to read its title; the rest share the remainder.
	local share = n > 0 and floor(avail / n) or 0
	local activeW, otherW = share, share
	if n >= 2 and active then
		activeW = min(TAB_MAX_W, max(share, floor(avail * (n == 2 and 0.55 or 0.42))))
		otherW = floor((avail - activeW) / (n - 1))
	end
	activeW, otherW = min(TAB_MAX_W, activeW), min(TAB_MAX_W, otherW)
	local G = ns.Guides
	local x = 1
	for i = 1, n do
		local t = tabs[i]
		local b = tabButton(i)
		b.psIndex = i
		b.psActive = i == active
		b.psTitle = t.title or t.guideId
		local guide = G and G.Get and G.Get(t.guideId)
		b.psMeta = guide and UI.GuideMeta(guide) or nil
		local total = t.total or t.stepCount
		b.psProgress = (t.done and total and total > 0) and string.format(L["%d of %d steps done"], t.done, total) or nil
		b.Label:SetText(b.psTitle)
		b.Label:SetWidth(0) -- unbound, to measure the whole title
		b.psTitleW = floor(b.Label:GetStringWidth() + 1)
		local lv = guide and UI.LevelRange(guide.minLevel, guide.maxLevel)
		b.psRange = lv and ("(" .. lv .. ")") or nil
		b.Range:SetText(b.psRange or "")
		b.Icon:SetTexture(Theme.Media(CATEGORY_ICON[t.category] or "icon-level"))
		W.Color(b.Label, b.psActive and "text" or "textMuted")
		W.Color(b.Range, b.psActive and "textDim" or "textMuted")
		W.Color(b.Icon, b.psActive and "accent" or "textMuted")
		b.Selected:SetShown(b.psActive)
		b.Bar:SetShown(b.psActive)
		local w = b.psActive and activeW or otherW
		b:SetWidth(w)
		layoutTab(b, b:IsMouseOver() and 20 or 8)
		b:ClearAllPoints()
		b:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", x, 0)
		x = x + w
		b:Show()
	end
	for i = n + 1, #tabButtons do tabButtons[i]:Hide() end
	strip.Add:ClearAllPoints()
	strip.Add:SetPoint("LEFT", strip, "BOTTOMLEFT", x + 2, TAB_H / 2)
	local full = n >= 6
	W.SetIconState(strip.Add, false, not full)
	strip.Add.psTip = full and L["Six tabs is the limit"] or L["Open a guide in a new tab"]
end

---------------------------------------------------------------------------
-- Banners: the step the player just skipped, with its undo; why the guide
-- just moved past a quest (while that step's guide and next step are on
-- screen); the step on screen when it is not the live one (skipped: unskip
-- it; looked at with ‹ ›: back to the live step); then the out-levelled offer
-- (while its guide is active), then the training reminder. Taking or
-- dismissing one lets the next through.
---------------------------------------------------------------------------

local SKIPPED_SECONDS = 20 -- how long the "Skipped …" notices stay
local notices = { stepSkip = nil, skipped = nil, away = nil, outlevel = nil, train = nil }
GF.notices = notices

-- The step on screen when it is not the live step: { guideId, index, live,
-- skipped }, or nil. Dismissed per step (notices.away holds the key).
local function awayNotice(E, g)
	if not (E.GetLiveStep and view and g) then return nil end
	local index, live = E.GetStepIndex(), E.GetLiveStep()
	if not index or index ~= view.index or index == live then return nil end
	if not view.skipped and not live then return nil end
	local a = { guideId = g.id, index = index, live = live, skipped = view.skipped and true or false }
	if notices.away == g.id .. ":" .. index then return nil end
	return a
end

local function bannerNotice()
	local E = Engine()
	local g = E and E.GetGuide and E.GetGuide()
	local k = notices.stepSkip
	if k and g ~= nil and g.id == k.guideId and (not view or view.index ~= k.step) then return "stepSkip", k end
	local s = notices.skipped
	if s and g ~= nil and g.id == s.guideId and E.GetStepIndex() == s.to then return "skipped", s end
	local a = E and awayNotice(E, g)
	if a then return "away", a end
	local o = notices.outlevel
	if o and g ~= nil and g.id == o.guideId then return "outlevel", o end
	if notices.train then return "train", notices.train end
	return nil
end
GF.BannerNotice = bannerNotice

-- Skip the step on screen (the navigator's Skip, the menu).
function GF.SkipStep()
	local E = Engine()
	if E and E.Skip and E.GetGuide and E.GetGuide() then E.Skip() end
end

-- PLAYER_SKIPPED_STEP(guideId, step): from the window or /polestar skip, the
-- banner offers the undo for SKIPPED_SECONDS.
ns.On("PLAYER_SKIPPED_STEP", function(guideId, step)
	if not F or type(step) ~= "number" then return end
	local G = ns.Guides
	local g = G and G.Get and G.Get(guideId)
	local st = g and g.steps and g.steps[step]
	local notice = { guideId = guideId, step = step, title = st and st.title }
	notices.stepSkip = notice
	if ns.IsLoggedIn() then GF.Layout() end
	C_Timer.After(SKIPPED_SECONDS, function()
		if notices.stepSkip == notice then
			notices.stepSkip = nil
			if F and ns.IsLoggedIn() then GF.Layout() end
		end
	end)
end)

local function trainerPlace(t)
	local zone = t.map and UI.MapName(t.map) or nil
	if t.npcName and zone then return t.npcName .. ", " .. zone end
	return t.npcName or zone
end

-- One link-style action in the banner (label, chevron).
local function placeLink(link, text, x, y)
	link.Label:SetText(text)
	link:SetWidth(floor(link.Label:GetStringWidth() + 16 + 0.5))
	link:ClearAllPoints()
	link:SetPoint("TOPLEFT", banner.Text, "BOTTOMLEFT", x, y)
	link:Show()
	return link:GetWidth()
end

function GF.LayoutBanner(width)
	local kind, n = bannerNotice()
	banner.psKind = kind
	banner.Text:SetWidth(width - PAD * 2 - 21 - 24)
	banner.Later:Hide()
	if kind == "skipped" then
		banner.Icon:SetTexture(Theme.Media("skip"))
		local lines = {}
		for i, k in ipairs(n.skips) do
			lines[i] = string.format(L["Skipped %s"], k.title or "") .. (k.text and ("  \194\183  " .. k.text) or "")
		end
		banner.Text:SetText(table.concat(lines, "\n"))
		banner.Jump:Hide()
		banner.Close:Show()
		local h = floor(9 + banner.Text:GetStringHeight() + 9 + 0.5)
		banner:SetHeight(h)
		return h
	elseif kind == "stepSkip" then
		banner.Icon:SetTexture(Theme.Media("skip"))
		local what = string.format(L["Step %d"], n.step)
		if n.title and n.title ~= "" then what = what .. "  \194\183  " .. n.title end
		banner.Text:SetText(string.format(L["Skipped %s"], what))
		placeLink(banner.Jump, L["Undo"], 0, -4)
		banner.Close:Show()
	elseif kind == "away" then
		banner.Icon:SetTexture(Theme.Media(n.skipped and "skip" or (n.live and n.index > n.live and "chevron-right" or "chevron-left")))
		if n.skipped then
			banner.Text:SetText(L["You skipped this step."])
			placeLink(banner.Jump, L["Unskip it"], 0, -4)
		else
			banner.Text:SetText(string.format(n.index > n.live and L["Looking ahead. The guide is at step %d."]
				or L["Looking back. The guide is at step %d."], n.live))
			placeLink(banner.Jump, string.format(L["Back to step %d"], n.live), 0, -4)
		end
		banner.Close:Show()
	elseif kind == "outlevel" then
		banner.Icon:SetTexture(Theme.Media("icon-level"))
		banner.Text:SetText(L["You have outlevelled this guide."])
		-- The suggested guide is one of a route choice: offer the choice.
		local E = Engine()
		n.choiceFrom = n.to and E and E.RouteChoiceFor and E.RouteChoiceFor(n.to) or nil
		placeLink(banner.Jump, n.choiceFrom and L["Choose where to level next"] or string.format(L["Jump to %s"], n.title or ""), 0, -4)
		banner.Close:Show()
	else
		banner.Icon:SetTexture(Theme.Media("icon-train"))
		local class = UI.PlayerClass and UI.PlayerClass() or nil
		local parts = { string.format(L["Level %d"], n.level or 0),
			class and string.format(L["new %s skills"], class) or L["new class skills"] }
		local place = n.trainer and trainerPlace(n.trainer)
		if place then parts[#parts + 1] = place end
		banner.Text:SetText(table.concat(parts, "  \194\183  "))
		local w = placeLink(banner.Jump, L["Show"], 0, -4)
		placeLink(banner.Later, L["Later"], w + 10, -4)
		banner.Close:Hide()
	end
	local h = floor(9 + banner.Text:GetStringHeight() + 4 + 18 + 9 + 0.5)
	banner:SetHeight(h)
	return h
end

-- The banner's main action: undo the skip, unskip the step on screen or go
-- back to the live step, load the suggested guide into the current tab, or
-- point the arrow at the trainer (until the step changes).
function GF.TakeBanner()
	local kind, n = bannerNotice()
	local E = Engine()
	if kind == "stepSkip" then
		notices.stepSkip = nil
		if E and E.Unskip then E.Unskip(n.step) end
	elseif kind == "away" then
		if n.skipped then
			if E and E.Unskip then E.Unskip(n.index) end
		elseif E and E.Goto and n.live then
			E.Goto(n.live)
		end
	elseif kind == "outlevel" then
		notices.outlevel = nil
		-- A route choice opens the choice window, which loads the zone picked.
		if not (n.choiceFrom and UI.ShowRouteChoice(n.choiceFrom)) and E and E.SetGuide and n.to then
			E.SetGuide(n.to)
		end
	elseif kind == "train" then
		notices.train = nil
		local t, nav2 = n.trainer, ns.Nav
		if t and t.map and t.x and nav2 and nav2.SetTarget then
			nav2.SetTarget(t.map, t.x, t.y, t.npcName or L["Class trainer"], t.f, "trainer", t.z)
		end
	end
	GF.Layout()
end

-- Dismiss the visible notice (training: until the next due level; a step on
-- screen that is not the live one: until another step is).
function GF.DismissBanner()
	local kind, n = bannerNotice()
	if kind == "away" then
		notices.away = n.guideId .. ":" .. n.index
	elseif kind then
		notices[kind] = nil
	end
	GF.Layout()
end

---------------------------------------------------------------------------
-- Layout: positions and heights from the current content and width. Called
-- on render and on every step of a drag-resize, so it only measures and
-- anchors; it never fetches views or builds strings.
---------------------------------------------------------------------------

local function stripShown()
	return strip.psHasTabs and not compact()
end

local function layoutCard(width)
	local y = 0
	local cw = width - PAD * 2
	if person:IsShown() then
		local nameW = cw - ICON - 10
		person.Name:SetWidth(nameW)
		person.Where:SetWidth(nameW)
		local h = 10 + person.Name:GetStringHeight()
		if person.Where:IsShown() then h = h + 3 + person.Where:GetStringHeight() end
		h = floor(h + 8 + 0.5)
		person:SetHeight(h)
		person:ClearAllPoints()
		person:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
		person:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
		y = h
	end
	for i = 1, #rows do
		local r = rows[i]
		if r:IsShown() then
			local h = measureRow(r, width)
			r:SetHeight(h)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -y)
			r:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -y)
			y = y + h
		end
	end
	local tip = card.Tip
	if tip:IsShown() then
		tip.Text:SetWidth(cw - 18)
		tip.Text:SetWordWrap(tipOpen)
		tip.psOpen = tipOpen
		local th = tipOpen and tip.Text:GetStringHeight() or min(tip.Text:GetStringHeight(), tip.Text:GetLineHeight())
		local h = floor(6 + th + 6 + 0.5)
		tip:SetHeight(h)
		tip:ClearAllPoints()
		tip:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -(y + 2))
		tip:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -(y + 2))
		y = y + 2 + h
	end
	y = y + 6
	card:SetHeight(y)
	return y
end

local function layoutAfter(width)
	after.Text:SetWidth(width - PAD * 2 - after.Count:GetStringWidth() - 12)
	after:SetHeight(28)
	return 28
end

local function layoutUpnext(width)
	upnext.Toggle:ClearAllPoints()
	upnext.Toggle:SetPoint("TOPLEFT", upnext, "TOPLEFT", 0, 0)
	upnext.Toggle:SetPoint("TOPRIGHT", upnext, "TOPRIGHT", 0, 0)
	local y = -UP_TOGGLE
	if upcomingOpen() then
		for i = 1, #upRows do
			local r = upRows[i]
			if r:IsShown() then
				r.Text:SetWidth(width - TEXT_X - 14 - PAD)
				r:ClearAllPoints()
				r:SetPoint("TOPLEFT", upnext, "TOPLEFT", 0, y)
				r:SetPoint("TOPRIGHT", upnext, "TOPRIGHT", 0, y)
				y = y - UP_ROW
			end
		end
		y = y - 6
	end
	upnext:SetHeight(-y)
	return -y
end

local function layoutEmpty(width)
	local cw = width - PAD * 4
	local y = -26
	empty.Glyph:ClearAllPoints()
	empty.Glyph:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - 36 - 14
	empty.Title:SetWidth(cw)
	empty.Title:ClearAllPoints()
	empty.Title:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - empty.Title:GetStringHeight() - 8
	empty.Text:SetWidth(cw)
	empty.Text:ClearAllPoints()
	empty.Text:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - empty.Text:GetStringHeight() - 18
	if empty.Primary:IsShown() then
		empty.Primary:ClearAllPoints()
		empty.Primary:SetPoint("TOP", empty, "TOP", 0, y)
		y = y - empty.Primary:GetHeight() - 8
	end
	if empty.Secondary:IsShown() then
		empty.Secondary:ClearAllPoints()
		empty.Secondary:SetPoint("TOP", empty, "TOP", 0, y)
		y = y - empty.Secondary:GetHeight()
	end
	y = y - 24
	empty:SetHeight(-y)
	return -y
end

-- Place `frame` in the body at y; returns the new y.
local function stack(frame, y, h)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", body, "TOPLEFT", 0, -y)
	frame:SetPoint("TOPRIGHT", body, "TOPRIGHT", 0, -y)
	return y + h
end

-- The journey (UI/JourneyPanel.lua) right under the focus it leads to;
-- never in compact mode. Returns the new y.
local function stackJourney(y, width)
	local J = UI.JourneyPanel
	local jf = J and J.frame
	if not jf then return y end
	if jf.psHas and not compact() then
		jf:Show()
		return stack(jf, y, J.Layout(width))
	end
	jf:Hide()
	return y
end

function GF.Layout()
	if not F then return end
	local width = F:GetWidth()
	local isCompact = compact()
	local showStrip = stripShown()
	strip:SetShown(showStrip)
	strip:SetHeight(showStrip and TAB_H or 0.01)
	-- The guide's title sits in the navigator only when no tab names it.
	local steps = nav.Steps:IsShown()
	nav.Title:SetShown((not showStrip or not steps) and nav.Title:GetText() ~= nil and nav.Title:GetText() ~= "")
	local skipW = nav.Skip:IsShown() and nav.Skip:GetWidth() + 4 or 0
	local reportW = nav.Report:IsShown() and nav.Report:GetWidth() or 0
	nav.Title:SetWidth(max(40, width - PAD - (steps and nav.Steps:GetWidth() + 12 or 0) - 24 - 8 - 8 - skipW - reportW))
	card:SetWidth(width)

	local y = 0
	if bannerNotice() and state ~= "noguide" and state ~= "noguides" then
		y = stack(banner, y, GF.LayoutBanner(width))
		banner:Show()
	else
		banner:Hide()
	end
	if state == "steps" then
		local h = layoutCard(width)
		-- The card animates its own offset; keep its anchor's base in step.
		if Anim.IsRunning(card, "offset") then
			card.psAnchor[5] = -y
		else
			Anim.Anchor(card, "TOPLEFT", body, "TOPLEFT", 0, -y)
		end
		y = y + h
		y = stackJourney(y, width)
		if after:IsShown() then y = stack(after, y, layoutAfter(width)) end
		if upnext:IsShown() then y = stack(upnext, y, layoutUpnext(width)) end
	else
		y = stack(empty, y, layoutEmpty(width))
		y = stackJourney(y, width)
	end
	if GF.xp.psHas and not isCompact and state == "steps" then
		GF.xp:Show()
		y = stack(GF.xp, y, GF.xp:GetHeight())
	else
		GF.xp:Hide()
	end
	body:SetHeight(max(1, y))
	local showFoot = state == "steps" or state == "complete"
	foot:SetShown(showFoot)
	local stripH = showStrip and TAB_H or 0
	F:SetHeight(floor(stripH + NAV_H + y + (showFoot and PROG_H or 0) + 0.5))
	band:SetHeight(stripH + NAV_H)
	band:SetTexCoord(Theme.BandCoords(width - 2, stripH + NAV_H, 30))
	if showStrip then GF.RenderTabs() end
	GF.PaintProgress(false)
end

---------------------------------------------------------------------------
-- Progress
---------------------------------------------------------------------------

local function progress()
	local E = Engine()
	if not (E and E.GetProgress and E.GetGuide and E.GetGuide()) then return 0, 0 end
	local done, total = E.GetProgress()
	return done or 0, total or 0
end

function GF.PaintProgress(animate)
	local done, total = progress()
	local frac = total > 0 and min(1, done / total) or 0
	foot.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
	local w = F:GetWidth() - PAD * 2 - 44
	foot.Line:SetWidth(max(1, w))
	W.SetProgress(foot.Line, frac, w, animate)
	foot.psDone, foot.psTotal = done, total
end

---------------------------------------------------------------------------
-- Render
---------------------------------------------------------------------------

-- A finished dungeon pick-up guide whose dungeon has quests in the log ->
-- the dungeon's key | nil.
local function pickupKey(guide)
	local lk, Dg = guide and guide.lookup, ns.Dungeons
	if not (lk and lk.kind == "pickup" and Dg and Dg.HandinPlan and UI.DungeonsSection) then return nil end
	local plan = Dg.HandinPlan(lk.id)
	if not plan or #plan.hand + #plan.unfinished + #plan.inside + #plan.unplaced == 0 then return nil end
	return lk.id
end

local function setEmpty(kind)
	state = kind
	local E, G = Engine(), ns.Guides
	empty.Primary:Hide()
	empty.Secondary:Hide()
	local glyph, color = "emblem", "accent"
	if kind == "noguides" and UI.Packs and UI.Packs.AnySwitchedOff() then
		-- Installed but switched off on the Community guides page.
		empty.Title:SetText(L["No guides shown"])
		empty.Text:SetText(L["The community addons are switched off. Turn one on under Options, Community guides (/polestar packs)."])
		W.SetButtonText(empty.Primary, L["Community guides"])
		empty.Primary.psAction = function() UI.ShowOptions("guidepacks") end
		empty.Primary:Show()
	elseif kind == "noguides" then
		empty.Title:SetText(L["No guides installed"])
		empty.Text:SetText(L["Enable Polestar Guides or a community addon in the AddOns list on the character screen, then reload."])
	elseif kind == "noguide" then
		local id = G and G.Suggest and G.Suggest()
		local suggested = id and G.Get(id)
		empty.Title:SetText(L["No guide open"])
		if suggested then
			empty.Text:SetText(L["Suggested for you"] .. ": |c" .. Theme.Hex("text") .. suggested.title .. "|r")
			W.SetButtonText(empty.Primary, L["Start guide"])
			empty.Primary.psAction = function()
				if E and E.OpenTab then E.OpenTab(id) elseif E and E.SetGuide then E.SetGuide(id) end
			end
			empty.Primary:Show()
			W.SetButtonText(empty.Secondary, L["Browse guides"])
			empty.Secondary.psAction = function() UI.ShowPicker() end
			empty.Secondary:Show()
		else
			empty.Text:SetText(L["Pick a guide to start."])
			W.SetButtonText(empty.Primary, L["Choose a guide"])
			empty.Primary.psAction = function() UI.ShowPicker() end
			empty.Primary:Show()
		end
	elseif kind == "notyet" then
		-- A Class guide the character cannot start yet (Engine.StartGate):
		-- when it opens, who starts it; the guide picks up by itself.
		glyph = "icon-level"
		local guide = E and E.GetGuide and E.GetGuide()
		local gate = guide and E.StartGate and E.StartGate(guide.id) or {}
		local lines = {}
		if gate.giver then
			local zone = gate.map and UI.MapName(gate.map) or nil
			lines[1] = string.format(L["%s starts it."], zone and (gate.giver .. ", " .. zone) or gate.giver)
		end
		if gate.level then
			empty.Title:SetText(string.format(L["Available from level %d"], gate.level))
			lines[#lines + 1] = string.format(L["Come back at level %d: the guide picks up by itself then."], gate.level)
		else
			empty.Title:SetText(L["Not available yet"])
			lines[#lines + 1] = string.format(L["Finish %s first: the guide picks up by itself then."], gate.preTitle or "")
		end
		empty.Text:SetText(table.concat(lines, "\n"))
		W.SetButtonText(empty.Primary, L["Choose a guide"])
		empty.Primary.psAction = function() UI.ShowPicker() end
		empty.Primary:Show()
	elseif kind == "complete" then
		glyph, color = "check", "success"
		local guide = E and E.GetGuide and E.GetGuide()
		local nextGuide = guide and guide.next and G and G.Get and G.Get(guide.next)
		local choiceFrom = guide and E.PendingRouteChoice and E.PendingRouteChoice()
		local afterRun = not choiceFrom and pickupKey(guide)
		empty.Title:SetText(L["Guide complete"])
		if choiceFrom then
			-- Several zones to continue in: the player picks (UI.RouteChoice).
			empty.Text:SetText(L["Choose where to level next."])
			W.SetButtonText(empty.Primary, L["Choose your path"])
			empty.Primary.psAction = function() UI.ShowRouteChoice(choiceFrom) end
			empty.Primary:Show()
			W.SetButtonText(empty.Secondary, L["Browse guides"])
			empty.Secondary.psAction = function() UI.ShowPicker() end
			empty.Secondary:Show()
		elseif afterRun then
			-- A dungeon's pick-up guide ends at the entrance; after the run
			-- its quests are handed in (Dungeons/Handin.lua).
			empty.Text:SetText(L["After the run: a guide to where this dungeon's quests are turned in, and the follow-ups there."])
			W.SetButtonText(empty.Primary, L["Hand in the quests"])
			empty.Primary.psAction = function() UI.DungeonsSection.HandIn(afterRun) end
			empty.Primary:Show()
			W.SetButtonText(empty.Secondary, L["Choose a guide"])
			empty.Secondary.psAction = function() UI.ShowPicker() end
			empty.Secondary:Show()
		elseif nextGuide then
			empty.Text:SetText(L["Up next"] .. ": |c" .. Theme.Hex("text") .. nextGuide.title .. "|r")
			W.SetButtonText(empty.Primary, L["Continue"])
			empty.Primary.psAction = function() E.SetGuide(nextGuide.id) end
			empty.Primary:Show()
			W.SetButtonText(empty.Secondary, L["Browse guides"])
			empty.Secondary.psAction = function() UI.ShowPicker() end
			empty.Secondary:Show()
		else
			empty.Text:SetText(L["Nice work. Pick your next guide to keep going."])
			W.SetButtonText(empty.Primary, L["Choose a guide"])
			empty.Primary.psAction = function() UI.ShowPicker() end
			empty.Primary:Show()
		end
	end
	empty.Glyph:SetTexture(Theme.Media(glyph))
	W.Color(empty.Glyph, color)
	empty.Glyph:SetSize(36, 36)
	W.Color(empty.Glyph.Glow, color, 0.16)
end

-- The navigator's Skip, beside the menu: skips the step on screen for good
-- (the banner offers the undo). Shown with a guide; off on a finished guide
-- and on a step already skipped.
function GF.PaintSkip(shown, enabled)
	local b = nav.Skip
	b:SetShown(shown and true or false)
	if enabled then b:Enable() else b:Disable() end
	local a = enabled and 1 or 0.35
	W.Color(b.Icon, "textDim", a)
	W.Color(b.Label, "textDim", a)
end

local function navigatorFor(guide, index)
	local E = Engine()
	local count = guide and E.GetStepCount and E.GetStepCount() or 0
	if guide then
		nav.Steps.Count:SetText(string.format("%d / %d", index or count, count))
		nav.Title:SetText(guide.title or guide.id)
		nav.psMeta = UI.GuideMeta(guide)
	else
		nav.Steps.Count:SetText("")
		nav.Title:SetText(L["Polestar"])
		nav.psMeta = nil
	end
	W.SetIconState(nav.Prev, false, guide ~= nil)
	W.SetIconState(nav.Next, false, guide ~= nil and index ~= nil)
	GF.PaintSkip(guide ~= nil, guide ~= nil and index ~= nil)
	nav.Report:SetShown(guide ~= nil)
	-- No guide: no steps to walk; the navigator names the addon instead.
	nav.Steps:SetShown(guide ~= nil)
	nav.Title:ClearAllPoints()
	if guide then
		nav.Title:SetPoint("LEFT", nav.Steps, "RIGHT", 8, 0)
	else
		nav.Title:SetPoint("LEFT", nav, "LEFT", PAD, 0)
	end
	local cw = max(floor(nav.Steps.Count:GetStringWidth() + 0.5), 40)
	nav.Steps.Count:SetWidth(cw)
	nav.Steps:SetWidth(24 + cw + 24)
end

local function fillUpcoming(E, index)
	for i = 1, #upRows do upRows[i]:Hide() end
	local want = compact() and 0 or (ns.Get("ui.upcoming") or 0)
	local n, count = 0, E.GetStepCount and E.GetStepCount() or 0
	local i = index + 1
	while n < want and i <= count do
		local v = E.GetStepView(i)
		if v and v.status ~= "na" then
			n = n + 1
			local r = upRow(n)
			r.psIndex = i
			r.psSummary = UI.StepSummary(v)
			r.Num:SetText(i)
			r.Icon:SetTexture(Theme.VerbIcon(UI.FirstVerb(v)))
			r.Text:SetText(r.psSummary)
			r:SetShown(upcomingOpen())
		end
		i = i + 1
	end
	upnext.psCount = n
	local open = upcomingOpen()
	upnext.Toggle.Label:SetText(n == 1 and L["Up next \194\183 1 step"] or string.format(L["Up next \194\183 %d steps"], n))
	upnext.Toggle.Icon:SetTexture(Theme.Media(open and "chevron-up" or "chevron-down"))
	upnext:SetShown(n > 0)
end

-- What comes after the focus: the next open group in this step, else the
-- first group of the next applicable step. -> name, kind | nil
local function nextOf(E, index, groups, focus)
	for gi = (focus or 0) + 1, #groups do
		local g = groups[gi]
		if not g.done then return UI.GroupName(view, g), g.kind end
	end
	local count = E.GetStepCount and E.GetStepCount() or 0
	for s = index + 1, count do
		local v = E.GetStepView(s)
		if v and v.status ~= "na" then
			local gs, f = UI.StepGroups(v)
			local g = gs[f or 1] or gs[1]
			if g then return UI.GroupName(v, g), g.kind end
			return nil
		end
	end
	return nil
end

-- "Then: Gazrog" and "Person 2 of 8".
local function fillAfter(E, index, groups, focus)
	if compact() then
		after:Hide()
		return
	end
	local persons, at = 0, nil
	for gi, g in ipairs(groups) do
		if g.kind ~= "here" then
			persons = persons + 1
			if gi == focus then at = persons end
		end
	end
	local name, kind = nextOf(E, index, groups, focus)
	if name and name ~= "" then
		local hex = Theme.Hex(kind == "npc" and "npc" or (kind == "object" and "object" or "textDim"))
		after.Text:SetText(L["Then:"] .. " |c" .. hex .. name .. "|r")
	else
		after.Text:SetText("")
	end
	if at and persons > 1 then
		after.Count:SetText(string.format(L["Person %d of %d"], at, persons))
	else
		after.Count:SetText("")
	end
	after:SetShown((name and name ~= "") or (at and persons > 1) and true or false)
end

-- The group the card shows: the focus. A done step (no focus: one viewed with
-- Prev or Goto) shows all its goals under the step title, so it reads as done
-- and no optional leftover is hidden; the Engine points the arrow at nothing
-- there.
local function shownGroup(v, groups, focus)
	if focus and groups[focus] then return groups[focus] end
	local all = {}
	for i in ipairs(v.goals) do all[#all + 1] = i end
	return { kind = "here", goals = all, done = true }
end

-- The goals a group shows as rows, as painted (UI.ReadingGoal): never one
-- that does not apply or is folded into another (a quest started by an item
-- is one row); a "Go to" naming the step's own place (`header`) only when
-- nothing else shows, since the header already says it.
-- -> rows (goal views), the hidden header goal
local function shownGoals(v, group)
	local list, others = {}, 0
	for _, gi in ipairs(group.goals or {}) do
		local goal = v.goals[gi]
		if goal and goal.status ~= "na" and not goal.folded then
			list[#list + 1] = UI.ReadingGoal(v, goal)
			if not goal.header then others = others + 1 end
		end
	end
	if others == 0 then return list, nil end
	local out, header = {}, nil
	for _, goal in ipairs(list) do
		if goal.header then header = header or goal else out[#out + 1] = goal end
	end
	return out, header
end

-- Fill the card from `view`: the focus group's header and goals, the tip.
-- sameFocus = repaint in place; goals that just turned done pop.
local function fillCard(sameFocus)
	local groups, focus = UI.StepGroups(view)
	local g = shownGroup(view, groups, focus)
	focusGroup = g
	local list, header = shownGoals(view, g)
	person.psHeaderGoal = header
	paintPerson(g)
	person:Show()
	local t = targetOf()
	local n = 0
	-- A group line ("Dungeon: Dire Maul") reads once, on the first open
	-- goal that carries it, not under every goal of the same run.
	local partySaid = {}
	local missingSaid = {} -- quest -> a row already names who lacks it
	-- The current goal (the Engine's `current`: the first open blocking goal
	-- of the focus, else its first open optional one) takes the accent; it
	-- is the goal the arrow leads to. The header stands for its "Go to".
	for _, goal in ipairs(list) do
		n = n + 1
		local r = goalRow(n)
		local pop = sameFocus and goal.status == "done" and r.psStatus and r.psStatus ~= "done" and r.psGoal and r.psGoal.index == goal.index
		local isCurrent = view.current ~= nil and goal.index == view.current and goal.status == "active"
		local party = UI.GroupLine(goal)
		paintRow(r, goal, pop, sameFocus, isCurrent, party and partySaid[party], goal.quest and missingSaid[goal.quest])
		if party then partySaid[party] = true end
		if goal.quest and goal.oi and goal.status ~= "skipped" then missingSaid[goal.quest] = true end
		r.Mark:SetShown(goal.status ~= "done" and goal.status ~= "skipped" and isTarget(goal, t) and not person.Mark:IsShown())
		r:Show()
	end
	for i = n + 1, #rows do
		rows[i]:Hide()
		rows[i].psGoal = nil
		rows[i].psStatus = nil
	end
	local note = (ns.Get("ui.showNotes") and not compact()) and view.note or nil
	card.Tip.Text:SetText(note or "")
	card.Tip:SetShown(note ~= nil and note ~= "")
	W.SetIcon(card.Tip.Toggle, tipOpen and "chevron-up" or "chevron-down")
	return groups, focus
end

local function showSteps(show)
	card:SetShown(show)
	after:SetShown(show and after:IsShown())
	upnext:SetShown(show and upnext:IsShown())
	empty:SetShown(not show)
end

function GF.Render()
	if not F or not ns.IsLoggedIn() then return end
	local E, G = Engine(), ns.Guides
	strip.psHasTabs = GF.TabsOf(E) ~= nil
	local guide = E and E.GetGuide and E.GetGuide()
	local list = G and G.List and G.List()
	if not guide then
		navigatorFor(nil)
		view, shownIndex, shownGuide, shownFocus = nil, nil, nil, nil
		setEmpty((list and #list > 0) and "noguide" or "noguides")
		showSteps(false)
		GF.Layout()
		return
	end
	local index = E.GetStepIndex and E.GetStepIndex()
	navigatorFor(guide, index)
	-- The undo goes once the step is no longer skipped (undone elsewhere).
	local k = notices.stepSkip
	if k and k.guideId == guide.id then
		local sv = E.GetStepView(k.step)
		if not (sv and sv.skipped) then notices.stepSkip = nil end
	end
	local v = index and E.GetStepView(index)
	if not v then
		view, shownIndex, shownGuide, shownFocus = nil, nil, guide.id, nil
		setEmpty("complete")
		showSteps(false)
		GF.Layout()
		GF.PaintProgress(true)
		return
	end
	-- A Class guide the character cannot start yet: its notice on the live
	-- step; Next still looks at the steps ahead.
	if index == (E.GetLiveStep and E.GetLiveStep()) and E.StartGate and E.StartGate(guide.id) then
		view, shownIndex, shownGuide, shownFocus = nil, nil, guide.id, nil
		setEmpty("notyet")
		showSteps(false)
		GF.Layout()
		return
	end
	local stepChanged = shownGuide ~= guide.id or shownIndex ~= index
	if stepChanged then tipOpen = ns.Get("ui.notesOpen") and true or false end
	view = v
	if v.skipped then GF.PaintSkip(true, false) end
	state = "steps"
	local _, f0 = UI.StepGroups(v)
	local focusChanged = stepChanged or shownFocus ~= f0
	local groups, focus = fillCard(not focusChanged)
	fillAfter(E, index, groups, focus)
	fillUpcoming(E, index)
	showSteps(true)
	GF.Layout()
	GF.PaintProgress(shownGuide == guide.id)
	if focusChanged and F:IsVisible() then
		-- The next person (or step) slides up 6px into place as it fades in.
		Anim.To(card, "alpha", 0, 1, Anim.BASE, "out")
		Anim.To(card, "offset", -6, 0, Anim.BASE, "out")
	end
	shownIndex, shownGuide, shownFocus = index, guide.id, focus
end

-- STEP_UPDATED: same step, new goal status/progress. When the focus moved
-- to the next person this re-renders (with the slide); otherwise rows are
-- refilled in place.
function GF.Update()
	if not F or state ~= "steps" or not view then return GF.Render() end
	local E = Engine()
	local index = E.GetStepIndex and E.GetStepIndex()
	if index ~= shownIndex then return GF.Render() end
	local v = E.GetStepView(index)
	if not v then return GF.Render() end
	local groups, focus = UI.StepGroups(v)
	if focus ~= shownFocus then return GF.Render() end
	local g = shownGroup(v, groups, focus)
	local visible = #shownGoals(v, g)
	local current = 0
	for i = 1, #rows do if rows[i]:IsShown() then current = current + 1 end end
	if visible ~= current then return GF.Render() end
	view = v
	fillCard(true)
	fillAfter(E, index, groups, focus)
	GF.Layout()
	GF.PaintProgress(true)
end

function GF.UpdateTargets()
	if not F or state ~= "steps" or not focusGroup then return end
	local t = targetOf()
	person.Mark:SetShown(personMarked(t))
	for i = 1, #rows do
		local r = rows[i]
		if r:IsShown() and r.psGoal then
			r.Mark:SetShown(r.psGoal.status ~= "done" and r.psGoal.status ~= "skipped" and isTarget(r.psGoal, t) and not person.Mark:IsShown())
		end
	end
end

function GF.TabsOf(E) return tabsOf(E) end

---------------------------------------------------------------------------
-- Transparent mode: chrome on hover
---------------------------------------------------------------------------

local watcher = CreateFrame("Frame")
local hovering = false

local function chromeAlpha()
	if not transparent() then return 1 end
	return hovering and 1 or 0
end

local function fadeChrome(to)
	for i = 1, #chrome do
		local c = chrome[i]
		if to == 1 then
			Anim.To(c, "alpha", c:GetAlpha(), 1, Anim.FAST, "out")
		else
			Anim.To(c, "alpha", c:GetAlpha(), 0, Anim.BASE, "out")
		end
	end
end

local function watch()
	if F:IsMouseOver(4, -4, -4, 4) then return end
	hovering = false
	watcher:SetScript("OnUpdate", nil)
	if transparent() then fadeChrome(0) end
end

-- The cursor reached the window (or one of its parts).
function GF.HoverIn()
	if not F or hovering then return end
	hovering = true
	if transparent() then
		fadeChrome(1)
		watcher:SetScript("OnUpdate", watch)
	end
end

function GF.IsHovering() return hovering end

-- The guide's progress track: the house wash on the night ground; over the
-- world (transparent) a stronger ink line, so the fill still reads as a
-- share of a whole.
local function paintTrack(t)
	local r, g, b, a = Theme.Wash("progress")
	t:SetVertexColor(r, g, b, transparent() and 0.15 or a)
end

-- The ground's opacity is Theme.GroundAlpha (ui.bgOpacity), read by the
-- window skin itself; ui.bgOpacity changes land here to repaint it.
function GF.ApplyStyle()
	if not F then return end
	local clear = transparent()
	F.psBare = clear
	Theme.Repaint(F)
	band:SetShown(not clear)
	strip.Rule:SetShown(not clear)
	nav.Rule:SetShown(not clear)
	W.Painter(foot.Line.Track, paintTrack)
	for i = 1, #texts do Theme.SetOutline(texts[i], clear) end
	if not clear then
		watcher:SetScript("OnUpdate", nil)
		hovering = false
	end
	for i = 1, #chrome do
		Anim.Stop(chrome[i], "alpha")
		chrome[i]:SetAlpha(chromeAlpha())
	end
	GF.Layout()
end

---------------------------------------------------------------------------
-- Window state from settings
---------------------------------------------------------------------------

local function targetAlpha()
	local a = ns.Get("ui.opacity") or 1
	if inCombat and ns.Get("ui.combat") == "fade" then a = a * COMBAT_ALPHA end
	return a
end

function GF.ApplyVisibility()
	if not F then return end
	local show = ns.Get("ui.shown") and not (inCombat and ns.Get("ui.combat") == "hide")
	F:SetShown(show and true or false)
end

function GF.ApplyAlpha(animate)
	if not F then return end
	if animate then
		Anim.To(F, "alpha", F:GetAlpha(), targetAlpha(), Anim.SLOW, "out")
	else
		Anim.Stop(F, "alpha")
		F:SetAlpha(targetAlpha())
	end
end

-- The corner the window is pinned by and that corner's y: the bottom-left
-- with ui.growUp (a longer step pushes the top edge up), else the top-left
-- (it pushes the bottom edge down). ui.pos holds that corner.
local function pinCorner()
	if ns.Get("ui.growUp") then return "BOTTOMLEFT", F:GetBottom() end
	return "TOPLEFT", F:GetTop()
end

function GF.ApplyPosition()
	if not F then return end
	local pos = ns.Get("ui.pos")
	F:ClearAllPoints()
	if type(pos) == "table" and type(pos[1]) == "number" and type(pos[2]) == "number" then
		F:SetPoint(ns.Get("ui.growUp") and "BOTTOMLEFT" or "TOPLEFT", UIParent, "BOTTOMLEFT", pos[1], pos[2])
	elseif ns.Get("ui.growUp") then
		F:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -64, 240)
	else
		F:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -64, -240)
	end
end

function GF.SavePosition()
	if not F then return end
	local l = F:GetLeft()
	local _, y = pinCorner()
	if l and y then ns.Set("ui.pos", { floor(l + 0.5), floor(y + 0.5) }) end
end

function GF.ApplyLock()
	if not F then return end
	grip:SetShown(not ns.Get("ui.locked"))
end

function GF.ApplyWidth()
	if not F then return end
	local w = ns.Get("ui.width") or 340
	F:SetWidth(min(UI.MAX_WIDTH, max(UI.MIN_WIDTH, w)))
	GF.Layout()
end

function GF.ApplyCompact()
	if not F then return end
	GF.Render()
	GF.Layout()
end

-- Scale about the pinned corner, so the window stays where the user put
-- it, then repaint so 1px lines land on the new pixel grid.
function GF.ApplyScale()
	local new = ns.Get("ui.scale") or 1
	local old = F:GetScale()
	if old == new then return end
	local l = F:GetLeft()
	local corner, y = pinCorner()
	F:SetScale(new)
	if l and y and type(ns.Get("ui.pos")) == "table" then
		F:ClearAllPoints()
		F:SetPoint(corner, UIParent, "BOTTOMLEFT", l * old / new, y * old / new)
		ns.Set("ui.pos", { floor(l * old / new + 0.5), floor(y * old / new + 0.5) })
	end
	Theme.Refresh()
end

local APPLY = {
	["ui.shown"] = function() GF.ApplyVisibility() end,
	["ui.scale"] = function() GF.ApplyScale() end,
	["ui.opacity"] = function() GF.ApplyAlpha(false) end,
	["ui.bgOpacity"] = function() GF.ApplyStyle() end,
	["ui.style"] = function() GF.ApplyStyle() end,
	["ui.locked"] = function() GF.ApplyLock() end,
	["ui.compact"] = function() GF.ApplyCompact() end,
	["ui.width"] = function() GF.ApplyWidth() end,
	["ui.pos"] = function() GF.ApplyPosition() end,
	-- Re-pin by the other corner where the window stands now, so it does not jump.
	["ui.growUp"] = function() GF.SavePosition() end,
	["ui.upcoming"] = function() GF.Render() end,
	["ui.upcomingOpen"] = function() GF.Render() end,
	["ui.showNotes"] = function() GF.Render() end,
	["ui.notesOpen"] = function() tipOpen = ns.Get("ui.notesOpen") and true or false; GF.Render() end,
	["ui.combat"] = function() GF.ApplyVisibility(); GF.ApplyAlpha(false) end,
	["ui.font"] = function() GF.Layout() end,
}

local function applyAll()
	F:SetScale(ns.Get("ui.scale") or 1)
	GF.ApplyPosition()
	GF.ApplyLock()
	GF.ApplyWidth()
	GF.ApplyAlpha(false)
	GF.ApplyStyle()
	GF.ApplyCompact()
	GF.ApplyVisibility()
end

---------------------------------------------------------------------------
-- Move and resize
---------------------------------------------------------------------------

local savePosition = GF.SavePosition

local function dragStart()
	if ns.Get("ui.locked") then return end
	F:StartMoving()
end

local function dragStop()
	F:StopMovingOrSizing()
	savePosition()
end

local function resizeUpdate(self)
	local x = GetCursorPosition() / F:GetEffectiveScale()
	local w = min(UI.MAX_WIDTH, max(UI.MIN_WIDTH, floor(self.psStartW + (x - self.psStartX) + 0.5)))
	if w ~= floor(F:GetWidth() + 0.5) then
		F:SetWidth(w)
		GF.Layout()
	end
end

local function resizeStart(self)
	if ns.Get("ui.locked") then return end
	-- Grow from the left edge: pin the window by its left corner first.
	local l = F:GetLeft()
	local corner, y = pinCorner()
	if l and y then
		F:ClearAllPoints()
		F:SetPoint(corner, UIParent, "BOTTOMLEFT", l, y)
	end
	self.psStartX = GetCursorPosition() / F:GetEffectiveScale()
	self.psStartW = F:GetWidth()
	self:SetScript("OnUpdate", resizeUpdate)
end

local function resizeStop(self)
	if not self:GetScript("OnUpdate") then return end
	self:SetScript("OnUpdate", nil)
	ns.Set("ui.width", floor(F:GetWidth() + 0.5))
	savePosition()
end

---------------------------------------------------------------------------
-- Menu
---------------------------------------------------------------------------

local function openMenu(button)
	if W.MenuShown(button) then return W.HideMenu() end
	local E = Engine()
	local hasGuide = E and E.GetGuide and E.GetGuide()
	local clear = transparent()
	W.ShowMenu(button, {
		{ text = L["Choose guide"], icon = "search", onClick = function() UI.ShowPicker() end },
		{ text = L["Open in new tab"], icon = "plus", disabled = not (E and E.OpenTab), onClick = function() UI.ShowPicker({ newTab = true }) end },
		{ text = L["Skip this step"], icon = "skip", disabled = not hasGuide, onClick = function() GF.SkipStep() end },
		{ text = L["Report a problem"], icon = "bug", onClick = function() UI.ShowReport() end },
		{ separator = true },
		{ text = L["Compact mode"], icon = "compact", checked = compact(), onClick = function() ns.Set("ui.compact", not compact()) end },
		{ text = L["Transparent"], icon = "layers", checked = clear, onClick = function() ns.Set("ui.style", clear and "standard" or "transparent") end },
		{ text = L["Lock window"], icon = "lock", checked = ns.Get("ui.locked") and true or false, onClick = function() ns.Set("ui.locked", not ns.Get("ui.locked")) end },
		{ separator = true },
		{ text = L["Reset guide progress"], icon = "reset", confirm = true, disabled = not hasGuide, tip = L["Clears your manual check-offs and skipped steps for this guide."],
			onClick = function() if E and E.ResetProgress then E.ResetProgress() end end },
		{ text = L["Options"], icon = "gear", onClick = function() UI.ShowOptions() end },
		{ text = L["Hide window"], icon = "close", onClick = function()
			ns.Set("ui.shown", false)
			ns.Print(L["Guide window hidden. Type /polestar to bring it back."])
		end },
	})
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------

local function hoverable(frame)
	frame:HookScript("OnEnter", function() GF.HoverIn() end)
	return frame
end

local function draggable(frame)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", dragStart)
	frame:SetScript("OnDragStop", dragStop)
	return hoverable(frame)
end

local function build()
	F = CreateFrame("Frame", "PolestarGuideFrame", UIParent)
	F:SetFrameStrata("MEDIUM")
	F:SetClampedToScreen(true)
	F:SetMovable(true)
	F:EnableMouse(true)
	F:SetSize(ns.Get("ui.width") or 340, 200)
	Theme.Skin(F, "window")
	F:SetScript("OnEnter", function() GF.HoverIn() end)
	GF.frame = F

	-- The night-sky band behind the tab strip and navigator (standard style).
	band = Theme.Band(F, "BACKGROUND", -5)
	band:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	band:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)

	-- Tab strip
	strip = CreateFrame("Frame", nil, F)
	strip:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	strip:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
	strip:SetHeight(TAB_H)
	draggable(strip)
	strip.Rule = W.Divider(strip)
	strip.Rule:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 0, 0)
	strip.Rule:SetPoint("BOTTOMRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	strip.Add = W.IconButton(strip, "plus", 24, L["Open a guide in a new tab"], function()
		UI.ShowPicker({ newTab = true })
	end, 12)
	hoverable(strip.Add)
	chrome[#chrome + 1] = strip

	-- Navigator: prev, "8 / 29", next on the left; Skip, the bug (report a
	-- problem) and the menu on the right.
	nav = CreateFrame("Frame", nil, F)
	nav:SetPoint("TOPLEFT", strip, "BOTTOMLEFT", 0, 0)
	nav:SetPoint("TOPRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	nav:SetHeight(NAV_H)
	draggable(nav)
	nav.Rule = W.Divider(nav)
	nav.Rule:SetPoint("BOTTOMLEFT", nav, "BOTTOMLEFT", 0, 0)
	nav.Rule:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	nav.Steps = CreateFrame("Frame", nil, nav)
	nav.Steps:SetSize(100, 24)
	nav.Steps:SetPoint("LEFT", nav, "LEFT", PAD - 6, 0)
	nav.Prev = W.IconButton(nav.Steps, "chevron-left", 24, L["Previous step"], function()
		local E = Engine()
		if E and E.Prev then E.Prev() end
	end)
	nav.Prev.psTipLines = { L["A look back: nothing changes."] }
	nav.Prev:SetPoint("LEFT", nav.Steps, "LEFT", 0, 0)
	nav.Steps.Count = T(nav.Steps, "number", "text")
	nav.Steps.Count:SetJustifyH("CENTER")
	nav.Steps.Count:SetPoint("LEFT", nav.Prev, "RIGHT", 0, 0)
	nav.Next = W.IconButton(nav.Steps, "chevron-right", 24, L["Next step"], function()
		local E = Engine()
		if E and E.Next then E.Next() end
	end)
	nav.Next.psTipLines = { L["A look ahead: nothing is skipped. Skip moves on for good."] }
	nav.Next:SetPoint("LEFT", nav.Steps.Count, "RIGHT", 0, 0)
	nav.Menu = W.IconButton(nav, "menu", 24, L["Menu"], openMenu)
	nav.Menu:SetPoint("RIGHT", nav, "RIGHT", -8, 0)
	GF.menuButton = nav.Menu
	-- Report a problem with the step on screen (UI/Report.lua): the bug, left
	-- of the menu.
	nav.Report = W.IconButton(nav, "bug", 24, L["Report a problem"], function() UI.ShowReport() end)
	nav.Report.psTipLines = { L["Write what went wrong, copy the report and paste it on the Polestar Discord."] }
	nav.Report:SetPoint("RIGHT", nav.Menu, "LEFT", 0, 0)
	nav.Report:Hide()
	-- Skip: the 11px skip glyph and a Small label, a ghost button left of the
	-- bug.
	local skip = CreateFrame("Button", nil, nav)
	skip:SetHeight(24)
	W.Hover(skip, 0.7)
	skip.Icon = W.Tex(skip, "ARTWORK", "skip", "textDim")
	skip.Icon:SetSize(11, 11)
	skip.Icon:SetPoint("LEFT", skip, "LEFT", 7, 0)
	skip.Label = T(skip, "small", "textDim")
	skip.Label:SetPoint("LEFT", skip.Icon, "RIGHT", 5, 0)
	skip.Label:SetText(L["Skip"])
	skip:SetWidth(floor(7 + 11 + 5 + skip.Label:GetStringWidth() + 8 + 0.5))
	skip:SetPoint("RIGHT", nav.Report, "LEFT", -2, 0)
	skip:SetScript("OnClick", function() GF.SkipStep() end)
	skip:SetScript("OnEnter", function(self)
		if self:IsEnabled() then
			W.Color(self.Icon, "text")
			W.Color(self.Label, "text")
		end
		W.Tooltip(self, "ANCHOR_BOTTOM", L["Skip this step"], { L["The guide moves on and remembers it. Undo in the banner, or go back to the step to unskip it."] })
		GF.HoverIn()
	end)
	skip:SetScript("OnLeave", function(self)
		GF.PaintSkip(self:IsShown(), self:IsEnabled())
		W.HideTooltip(self)
	end)
	skip:Hide()
	nav.Skip = skip
	nav.Title = T(nav, "small", "textDim")
	-- The step's own title and the guide's facts, on the step number.
	local countHit = CreateFrame("Frame", nil, nav.Steps)
	countHit:SetAllPoints(nav.Steps.Count)
	countHit:EnableMouse(true)
	countHit:SetScript("OnEnter", function(self)
		local lines = {}
		if view and view.title and view.title ~= "" then lines[#lines + 1] = view.title end
		if nav.psMeta and nav.psMeta ~= "" then lines[#lines + 1] = nav.psMeta end
		W.Tooltip(self, tooltipAnchor(), nav.Title:GetText() or "", lines)
		GF.HoverIn()
	end)
	countHit:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	for _, b in ipairs({ nav.Menu, nav.Report, nav.Next, nav.Prev, nav.Skip }) do hoverable(b) end
	-- Transparent chrome: the step number fades with its chevrons (nav.Steps
	-- holds all three) and the title with them; a lone "3 / 8" over the world
	-- would read as a stray number. Progress stays readable in the foot.
	for _, c in ipairs({ nav.Menu, nav.Report, nav.Skip, nav.Steps, nav.Title }) do chrome[#chrome + 1] = c end

	-- Body
	body = CreateFrame("Frame", nil, F)
	body:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", 0, 0)
	body:SetPoint("TOPRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	body:SetHeight(100)

	card = CreateFrame("Frame", nil, body)
	Anim.Anchor(card, "TOPLEFT", body, "TOPLEFT", 0, 0)

	-- The focus header: who (or what) the goals below belong to.
	person = CreateFrame("Button", nil, card)
	person:RegisterForClicks("LeftButtonUp")
	W.Hover(person, 0.7)
	-- The arrow on this person: the 2px accent selection bar.
	person.Mark = person:CreateTexture(nil, "ARTWORK")
	person.Mark:SetTexture(Theme.Media("white"))
	person.Mark:SetWidth(2)
	person.Mark:SetPoint("TOPLEFT", person, "TOPLEFT", 0, -6)
	person.Mark:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", 0, 4)
	W.Color(person.Mark, "accent")
	person.Mark:Hide()
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetSize(ICON + 1, ICON + 1)
	person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", PAD - 1, -11)
	person.Name = T(person, "name", "npc")
	person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", TEXT_X, -10)
	person.Where = T(person, "small", "textDim")
	person.Where:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -3)
	person:SetScript("OnClick", function(self) pointAt(self.psPlace, self.psLabel) end)
	person:SetScript("OnEnter", personEnter)
	person:SetScript("OnLeave", function(self) W.HideTooltip(self) end)

	-- The author's tip, one line until opened.
	local tip = CreateFrame("Button", nil, card)
	W.Hover(tip, 0.6)
	tip.Text = T(tip, "note", "textDim")
	tip.Text:SetJustifyV("TOP")
	tip.Text:SetSpacing(3)
	tip.Text:SetPoint("TOPLEFT", tip, "TOPLEFT", TEXT_X, -6)
	tip.Toggle = W.IconButton(tip, "chevron-down", 18, nil, nil, 10)
	tip.Toggle:EnableMouse(false)
	tip.Toggle:SetPoint("TOPLEFT", tip, "TOPLEFT", PAD - 2, -3)
	tip:SetScript("OnClick", function()
		tipOpen = not tipOpen
		W.SetIcon(tip.Toggle, tipOpen and "chevron-up" or "chevron-down")
		GF.Layout()
	end)
	tip:SetScript("OnEnter", function() GF.HoverIn() end)
	card.Tip = tip

	-- "Then: Gazrog" on the left, "Person 2 of 8" on the right.
	after = CreateFrame("Frame", nil, body)
	after:SetHeight(28)
	after.Rule = W.Divider(after)
	after.Rule:SetPoint("TOPLEFT", after, "TOPLEFT", PAD, 0)
	after.Rule:SetPoint("TOPRIGHT", after, "TOPRIGHT", -PAD, 0)
	after.Text = T(after, "label", "textDim")
	after.Text:SetPoint("LEFT", after, "LEFT", PAD, 0)
	after.Count = T(after, "small", "textMuted")
	after.Count:SetJustifyH("RIGHT")
	after.Count:SetPoint("RIGHT", after, "RIGHT", -PAD, 0)

	upnext = CreateFrame("Frame", nil, body)
	local toggle = CreateFrame("Button", nil, upnext)
	toggle:SetHeight(UP_TOGGLE)
	W.Hover(toggle, 0.7)
	toggle.Rule = W.Divider(toggle)
	toggle.Rule:SetPoint("TOPLEFT", toggle, "TOPLEFT", PAD, 0)
	toggle.Rule:SetPoint("TOPRIGHT", toggle, "TOPRIGHT", -PAD, 0)
	toggle.Label = T(toggle, "small", "textMuted")
	toggle.Label:SetPoint("LEFT", toggle, "LEFT", PAD, 0)
	toggle.Icon = toggle:CreateTexture(nil, "ARTWORK")
	toggle.Icon:SetSize(12, 12)
	toggle.Icon:SetPoint("RIGHT", toggle, "RIGHT", -PAD, 0)
	toggle.Icon:SetTexture(Theme.Media("chevron-down"))
	W.Color(toggle.Icon, "textMuted")
	toggle:SetScript("OnClick", function() ns.Set("ui.upcomingOpen", not upcomingOpen()) end)
	toggle:SetScript("OnEnter", function(self) W.Color(self.Label, "textDim"); GF.HoverIn() end)
	toggle:SetScript("OnLeave", function(self) W.Color(self.Label, "textMuted") end)
	upnext.Toggle = toggle

	-- XP pace (QoL module): "3.4k XP/h · 1h 05m to level", full summary on hover.
	local xp = CreateFrame("Frame", nil, body)
	xp:SetHeight(28)
	xp:EnableMouse(true)
	xp.Rule = W.Divider(xp)
	xp.Rule:SetPoint("TOPLEFT", xp, "TOPLEFT", PAD, 0)
	xp.Rule:SetPoint("TOPRIGHT", xp, "TOPRIGHT", -PAD, 0)
	xp.Icon = W.Tex(xp, "ARTWORK", "icon-level", "textMuted")
	xp.Icon:SetSize(11, 11)
	xp.Icon:SetPoint("LEFT", xp, "LEFT", PAD, -1)
	xp.Text = T(xp, "small", "textDim")
	xp.Text:SetPoint("LEFT", xp.Icon, "RIGHT", 7, 0)
	xp:SetScript("OnEnter", function(self)
		if self.psSummary then W.Tooltip(self, tooltipAnchor(), L["Experience"], { self.psSummary }) end
		GF.HoverIn()
	end)
	xp:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	xp:Hide()
	GF.xp = xp

	-- Banner: out-levelled offer or training reminder.
	banner = CreateFrame("Frame", nil, body)
	banner.Fill = banner:CreateTexture(nil, "BACKGROUND")
	banner.Fill:SetTexture(Theme.Media("white"))
	banner.Fill:SetAllPoints(banner)
	W.Painter(banner.Fill, function(t) local r, g, b = Theme.Accent(); t:SetVertexColor(r, g, b, 0.1) end)
	banner.Rule = W.Divider(banner)
	banner.Rule:SetPoint("BOTTOMLEFT", banner, "BOTTOMLEFT", 0, 0)
	banner.Rule:SetPoint("BOTTOMRIGHT", banner, "BOTTOMRIGHT", 0, 0)
	banner.Icon = W.Tex(banner, "ARTWORK", "icon-level", "accent")
	banner.Icon:SetSize(13, 13)
	banner.Icon:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD, -10)
	banner.Text = T(banner, "label", "text")
	banner.Text:SetWordWrap(true)
	banner.Text:SetJustifyV("TOP")
	banner.Text:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD + 21, -9)
	banner.Jump = CreateFrame("Button", nil, banner)
	banner.Jump:SetHeight(18)
	banner.Jump.Label = T(banner.Jump, "label", "accent")
	banner.Jump.Label:SetPoint("LEFT", banner.Jump, "LEFT", 0, 0)
	banner.Jump.Arrow = W.Tex(banner.Jump, "ARTWORK", "chevron-right", "accent")
	banner.Jump.Arrow:SetSize(11, 11)
	banner.Jump.Arrow:SetPoint("LEFT", banner.Jump.Label, "RIGHT", 3, 0)
	banner.Jump:SetScript("OnClick", function() GF.TakeBanner() end)
	banner.Jump:SetScript("OnEnter", function(self) W.Color(self.Label, "text"); GF.HoverIn() end)
	banner.Jump:SetScript("OnLeave", function(self) W.Color(self.Label, "accent") end)
	banner.Later = CreateFrame("Button", nil, banner)
	banner.Later:SetHeight(18)
	banner.Later.Label = T(banner.Later, "label", "textDim")
	banner.Later.Label:SetPoint("LEFT", banner.Later, "LEFT", 0, 0)
	banner.Later:SetScript("OnClick", function() GF.DismissBanner() end)
	banner.Later:SetScript("OnEnter", function(self) W.Color(self.Label, "text"); GF.HoverIn() end)
	banner.Later:SetScript("OnLeave", function(self) W.Color(self.Label, "textDim") end)
	-- A 12px glyph in a 24px target, centred where the old 18px one sat.
	banner.Close = W.IconButton(banner, "close", 24, L["Dismiss"], function() GF.DismissBanner() end, 12)
	banner.Close:SetPoint("TOPRIGHT", banner, "TOPRIGHT", -5, -3)
	banner:Hide()

	empty = CreateFrame("Frame", nil, body)
	empty.Glyph = empty:CreateTexture(nil, "ARTWORK")
	empty.Glyph:SetSize(36, 36)
	empty.Glyph.Glow = empty:CreateTexture(nil, "BACKGROUND")
	empty.Glyph.Glow:SetTexture(Theme.Media("glow"))
	empty.Glyph.Glow:SetSize(84, 84)
	empty.Glyph.Glow:SetPoint("CENTER", empty.Glyph, "CENTER", 0, 0)
	empty.Title = T(empty, "display", "text")
	empty.Title:SetJustifyH("CENTER")
	empty.Text = T(empty, "note", "textDim")
	empty.Text:SetJustifyH("CENTER")
	empty.Text:SetWordWrap(true)
	empty.Text:SetSpacing(3)
	local function act(b) if b.psAction then b.psAction() end end
	empty.Primary = W.Button(empty, "", act, { primary = true, width = 168 })
	empty.Secondary = W.Button(empty, "", act, { width = 168 })

	-- The guide's progress with its percent, at the bottom.
	foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 0, 0)
	foot:SetHeight(PROG_H)
	draggable(foot)
	foot.Line = W.ProgressLine(foot, 3)
	foot.Line:SetPoint("LEFT", foot, "LEFT", PAD, 0)
	foot.Pct = T(foot, "number", "textDim")
	foot.Pct:SetJustifyH("RIGHT")
	foot.Pct:SetWidth(40)
	foot.Pct:SetPoint("RIGHT", foot, "RIGHT", -PAD, 0)
	foot:SetScript("OnEnter", function(self)
		if self.psTotal and self.psTotal > 0 then
			W.Tooltip(self, tooltipAnchor(), L["Guide progress"], { string.format(L["%d of %d steps done"], self.psDone or 0, self.psTotal) })
		end
		GF.HoverIn()
	end)
	foot:SetScript("OnLeave", function(self) W.HideTooltip(self) end)

	-- Width grip
	grip = CreateFrame("Button", nil, F)
	grip:SetSize(16, 16)
	grip:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	grip:SetFrameLevel(F:GetFrameLevel() + 10)
	grip.Icon = grip:CreateTexture(nil, "OVERLAY")
	grip.Icon:SetTexture(Theme.Media("resize"))
	grip.Icon:SetSize(10, 10)
	grip.Icon:SetPoint("BOTTOMRIGHT", grip, "BOTTOMRIGHT", -1, 1)
	W.Color(grip.Icon, "textMuted", 0.6)
	grip:SetScript("OnEnter", function(self) W.Color(self.Icon, "text"); GF.HoverIn() end)
	grip:SetScript("OnLeave", function(self) W.Color(self.Icon, "textMuted", 0.6) end)
	grip:SetScript("OnMouseDown", resizeStart)
	grip:SetScript("OnMouseUp", resizeStop)
	grip:SetScript("OnHide", resizeStop)
	GF.grip = grip
	chrome[#chrome + 1] = grip

	GF.parts = {
		strip = strip, nav = nav, body = body, card = card, person = person, tip = tip, after = after,
		upnext = upnext, empty = empty, band = band, banner = banner, foot = foot, line = foot.Line,
	}
	GF.chrome = chrome

	F:SetScript("OnShow", function()
		GF.UpdateXP()
		GF.Render()
	end)
	Theme.OnChanged(function() if ns.IsLoggedIn() then GF.Render() end end)
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

-- A hidden window does no work: its OnShow renders it afresh.
local function whenReady(fn)
	return function(...)
		if F and F:IsShown() and ns.IsLoggedIn() then fn(...) end
	end
end

ns.OnInit(function()
	build()
	applyAll()
end)

-- The combat events may have fired before a /reload or reconnect.
local function combatNow()
	local C = ns.Compat
	if C and C.InCombat then
		local ok, v = pcall(C.InCombat)
		if ok then return v and true or false end
	end
	return InCombatLockdown and InCombatLockdown() and true or false
end

ns.OnLogin(function()
	inCombat = combatNow()
	applyAll()
	GF.Render()
end)

ns.On("GUIDE_CHANGED", whenReady(GF.Render))
ns.On("STEP_CHANGED", whenReady(GF.Render))
ns.On("STEP_UPDATED", whenReady(GF.Update))
ns.On("PARTY_PROGRESS", whenReady(GF.Update))
ns.On("GUIDES_REGISTERED", whenReady(GF.Render))
ns.On("PACKS_CHANGED", whenReady(GF.Render))
ns.On("GUIDE_COMPLETED", whenReady(GF.Render))
ns.On("WAYPOINT_CHANGED", whenReady(GF.UpdateTargets))

-- XP pace from the QoL tracker. Hidden when the tracker is off, at max level,
-- or before there is a rate to show.
function GF.UpdateXP(stats)
	if not GF.xp then return end
	local Q = ns.QoL
	if stats == nil and Q and Q.GetXPStats then
		local ok, s = pcall(Q.GetXPStats)
		stats = ok and s or nil
	end
	local parts = {}
	if type(stats) == "table" and not stats.maxed and Q then
		local short = Q.XP and Q.XP.Short
		if type(stats.rate) == "number" and stats.rate > 0 and short then
			parts[#parts + 1] = string.format(L["%s XP/h"], short(stats.rate))
		end
		if type(stats.timeToLevel) == "number" and Q.Duration then
			parts[#parts + 1] = string.format(L["%s to level"], Q.Duration(stats.timeToLevel))
		end
	end
	local had = GF.xp.psHas
	GF.xp.psHas = #parts > 0
	if GF.xp.psHas then
		GF.xp.Text:SetText(table.concat(parts, "  \194\183  "))
		local ok, summary = pcall(function() return Q.XP and Q.XP.Summary and Q.XP.Summary(stats) end)
		GF.xp.psSummary = ok and summary or nil
	end
	if had ~= GF.xp.psHas then GF.Layout() end
end

ns.On("QOL_XP_UPDATED", whenReady(function(stats) GF.UpdateXP(stats) end))
ns.OnLogin(function() GF.UpdateXP() end)

ns.On("TABS_CHANGED", whenReady(function()
	strip.psHasTabs = tabsOf(Engine()) ~= nil
	GF.Layout()
end))

-- STEP_SKIPPED(fromStep, toStep, skips): the guide moved past quests the
-- giver does not offer (or no longer can). Says why in the banner until the
-- step changes again, dismissed, or SKIPPED_SECONDS pass; in chat when the
-- window is hidden. Fires before STEP_CHANGED, whose render shows it.
ns.On("STEP_SKIPPED", function(_, to, skips)
	if not F or type(skips) ~= "table" or #skips == 0 then return end
	local E = Engine()
	local g = E and E.GetGuide and E.GetGuide()
	if not g then return end
	local n = { guideId = g.id, to = to, skips = skips }
	notices.skipped = n
	if not F:IsShown() then
		for _, k in ipairs(skips) do
			ns.Print(string.format(L["Skipped %s"], k.title or "") .. (k.text and (": " .. k.text) or ""))
		end
	end
	C_Timer.After(SKIPPED_SECONDS, function()
		if notices.skipped ~= n then return end
		notices.skipped = nil
		if F:IsShown() and ns.IsLoggedIn() then GF.Layout() end
	end)
end)

-- GUIDE_OUTLEVELED(guideId, suggestedId): the player has outgrown the guide
-- in the active tab; offer the suggested one until dismissed or taken.
ns.On("GUIDE_OUTLEVELED", function(guideId, suggestedId)
	if not F then return end
	local G = ns.Guides
	local target = suggestedId and G and G.Get and G.Get(suggestedId)
	if not target then return end
	notices.outlevel = { guideId = guideId, to = suggestedId, title = target.title or suggestedId }
	if ns.IsLoggedIn() then GF.Layout() end
end)

-- TRAIN_DUE(level, trainer): new class skills are waiting. A later level's
-- reminder replaces an older one.
ns.On("TRAIN_DUE", function(level, trainer)
	if not F then return end
	notices.train = { level = level, trainer = type(trainer) == "table" and trainer or nil }
	if ns.IsLoggedIn() then GF.Layout() end
end)

-- CLASS_TRAINED(level): the character visited their class trainer; the
-- reminder has done its job.
ns.On("CLASS_TRAINED", function()
	if not F or not notices.train then return end
	notices.train = nil
	if ns.IsLoggedIn() then GF.Layout() end
end)

ns.On("SETTING_CHANGED", function(path)
	if not F then return end
	local fn = APPLY[path]
	if fn then
		fn()
	elseif path == "" or path == "ui" then
		applyAll()
	end
end)

ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	inCombat = true
	W.HideMenu()
	GF.ApplyVisibility()
	GF.ApplyAlpha(true)
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	inCombat = false
	GF.ApplyVisibility()
	GF.ApplyAlpha(true)
end)
