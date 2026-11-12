-- The guide window, a compact instrument that reads one thing at a time
-- (docs/DESIGN.md, "Intent" and "The Guide Window"). From the top:
--
--   tab strip      one tab per open guide, + opens another
--   navigator      prev, "8 / 29", next, Skip, Nearby, the bug, Lookup, menu
--   banner         why the guide skipped a quest / out-levelled / training due
--   focus          the person to talk to now: icon, name in NPC colour, where;
--                  under it that person's open goals, one line each, the
--                  counter right after the text, and "✓ 3 done" folding the
--                  finished ones (a goal turning done pops, holds, then folds
--                  into that line). Every other person of the step is one
--                  summary line ("Then: Gazrog · 1 hand-in, 2 quests", "Then
--                  out here: 7 kills and items", "✓ Gazrog"); a click lists
--                  its goals in place. The persons already done share one
--                  "✓" line. The goals scroll inside a height cap
--                  (ui.maxHeight, a share of the screen); "Show the whole
--                  step" (ui.wholeStep) lists every goal as before. A done
--                  step (viewed with Prev) lists all its goals.
--                  The author's tip, collapsed to one line.
--   journey        the travel route's steps and times (UI/JourneyPanel.lua),
--                  while the route has more than one leg
--   then           "Then: <next step's person>" once this step has no one
--                  else; with "Show the whole step" also "Person 2 of 8"
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
-- or borders; every string is outlined and (ui.backing) sits on a light
-- feathered shade of its own ("soft", GF.PaintShades) or on a dark scrim with
-- no edge ("dark", GF.VEIL), one behind the body and one behind the tabs and
-- navigator that comes and goes with them, or on nothing ("none"); tick
-- boxes take the scrim and an ink edge, the progress track stays as a faint
-- ink line, and the chrome (tabs, the whole navigator: prev, "8 / 29", next,
-- title, Skip, the bug, menu; the grip) shows only while the cursor is over
-- the window (ui.barShown keeps all of it but the grip): the step number
-- fades with the chevrons that change it, so it never floats alone. Compact
-- mode (ui.compact) keeps the navigator, the focus goals and the progress bar.
--
-- Colour: the accent marks interaction and where you are (the active tab,
-- the arrow's target mark, the current goal's glyph, primary buttons, the
-- progress fill). Other glyphs sit in textDim, counters in text (success
-- once complete; UI.GoalLine), tooltip ids in textMuted. No colour literals:
-- everything reads Theme tokens and repaints on a scheme change. The player
-- may give the target mark and the progress fill colours of their own, and
-- this window its own ground and border (GF.LOOK, Options > Guide window).
--
-- Rows are pooled and filled in place, so STEP_UPDATED (a kill, a loot)
-- repaints existing rows instead of rebuilding anything. Nothing runs per
-- frame except a short tween (Polestar.Anim), a goal folding away (one
-- driver for every fold, stopped when none is left), an active drag-resize,
-- the name-target hitbox position watch, or the hover watch while the cursor
-- is on a transparent window or one that fades when it leaves
-- (guideWindow.idleAlpha).

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, abs, type, ipairs = math.floor, math.max, math.min, math.abs, type, ipairs

-- The window's sizes: the house style's here, a skin's from Theme.Metric
-- (readMetrics, on build and on a skin change).
local PAD = 14
local TAB_H = 28
local NAV_H = 34
local PROG_H = 26
local ICON = 15
local TEXT_X = PAD + ICON + 10
local ROW_MIN = 24
local CHECK = 18
-- A goal row's extra room above and below its lines, and its tick box's
-- extra inset from the edge (a skin with a framed lit goal: WoW Forever).
local ROW_PAD = 0
local CHECK_IN = 0
local CHECK_MID = false -- the tick box on the row's middle, not its first line
local UP_ROW = 24
local UP_TOGGLE = 30
-- A step's picture in the opened tip: never taller than this, and drawn
-- 2:1 when its pack gave no size (512x256, a common screenshot texture).
local PICTURE_MAX_H = 160
local PICTURE_ASPECT = 2

-- A goal row's tick box: at the right of its first line, or (CHECK_MID) of
-- its middle.
local function placeCheck(r)
	r.Check:ClearAllPoints()
	if CHECK_MID then
		r.Check:SetPoint("RIGHT", r, "RIGHT", -(PAD - 3 + CHECK_IN), 0)
	else
		r.Check:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(PAD - 3 + CHECK_IN), -3 - ROW_PAD)
	end
end

-- The skin's sizes, then the player's own on top of them (Options > Guide
-- window, UI/Looks/GuideWindow.lua: guideWindow.*; at their defaults the
-- skin's sizes stand as they are).
local function readMetrics()
	local function k(key) return tonumber(ns.Get("guideWindow." .. key)) or 1 end
	local function px(key) return tonumber(ns.Get("guideWindow." .. key)) or 0 end
	PAD = max(4, Theme.Metric("guidePad", 14) + px("padding"))
	TAB_H = floor(Theme.Metric("guideTabs", 28) * k("tabHeight") + 0.5)
	NAV_H = floor(Theme.Metric("guideNav", 34) * k("navHeight") + 0.5)
	PROG_H = Theme.Metric("guideFoot", 26)
	ICON = floor(15 * k("glyphSize") + 0.5)
	TEXT_X = PAD + ICON + Theme.Metric("guideIconGap", 10)
	ROW_MIN = Theme.Metric("guideRow", 24)
	CHECK = floor(Theme.Metric("guideCheck", 18) * k("checkSize") + 0.5)
	ROW_PAD = Theme.Metric("guideRowPad", 0) + px("rowSpacing")
	CHECK_IN = Theme.Metric("guideCheckIn", 0)
	CHECK_MID = Theme.Metric("guideCheckMiddle", false) and true or false
	UP_ROW = floor(Theme.Metric("guideUpRow", 24) * k("upSize") + 0.5)
	UP_TOGGLE = floor(Theme.Metric("guideUpToggle", 30) * k("upSize") + 0.5)
end
local TAB_MAX_W = 150

local GF = {}
-- The XP row's height, what its Boosted Rest line adds below a gap, and
-- its icon's offset beside the first of two lines.
GF.XPROW = { h = 28, restH = 16, gap = 3, iconY = 6 }
UI.GuideFrame = GF

local F, strip, nav, body, card, person, after, along, upnext, empty, grip, band, banner, foot, goals
local rows, upRows, alongRows, tabButtons, lines = {}, {}, {}, {}, {}
GF.rows, GF.upRows, GF.alongRows, GF.tabs, GF.lines = rows, upRows, alongRows, tabButtons, lines -- the pools, for inspection (tests, preview)
local view -- the step view on screen
local focusGroup -- the group on screen
local shownIndex, shownGuide, shownFocus -- what the card shows, to tell a change from an update
local tipOpen = false
local state = "none" -- "steps" | "noguides" | "noguide" | "notyet" | "away" | "complete" | "skippedout"
local texts = {} -- every string the window draws, for transparent-mode outlines
local chrome = {} -- frames that hide in transparent mode until hovered

-- The other GuideFrame*.lua files (UI.xml loads them after this one) keep
-- the window's parts and sizes as their own locals: GF.Bind(fn) calls
-- fn(parts, sizes) when the file binds, once the parts exist (build) and
-- again whenever a skin changes the sizes (GF.ReadMetrics).
local bound, handed = {}, { parts = {}, sizes = {} }
local function current()
	local p, m = handed.parts, handed.sizes
	p.F, p.strip, p.nav, p.body, p.card, p.person = F, strip, nav, body, card, person
	p.after, p.along, p.upnext, p.empty, p.grip, p.band = after, along, upnext, empty, grip, band
	p.banner, p.foot, p.goals = banner, foot, goals
	m.PAD, m.TAB_H, m.NAV_H, m.PROG_H, m.ICON, m.TEXT_X = PAD, TAB_H, NAV_H, PROG_H, ICON, TEXT_X
	m.ROW_MIN, m.CHECK, m.ROW_PAD, m.CHECK_IN, m.CHECK_MID, m.UP_ROW = ROW_MIN, CHECK, ROW_PAD, CHECK_IN, CHECK_MID, UP_ROW
	m.UP_TOGGLE, m.PICTURE_MAX_H, m.PICTURE_ASPECT, m.TAB_MAX_W = UP_TOGGLE, PICTURE_MAX_H, PICTURE_ASPECT, TAB_MAX_W
	return p, m
end
local function handOver()
	local p, m = current()
	for i = 1, #bound do bound[i](p, m) end
end
-- fn has the parts and sizes as they are now at once, as every file had
-- before the split (the house sizes until a skin's are read).
function GF.Bind(fn)
	bound[#bound + 1] = fn
	fn(current())
end

local function Engine() return ns.Engine end
local function compact() return ns.Get("ui.compact") and true or false end
local function transparent() return ns.Get("ui.style") == "transparent" end

-- A string that follows the window's style (outlined when transparent).
local function T(parent, role, color, layer)
	local fs = W.Text(parent, role, color, layer)
	texts[#texts + 1] = fs
	if F and transparent() then Theme.SetOutline(fs, GF.Outline()) end
	return fs
end
GF.Text = T -- for the panels other files place in the window (UI/JourneyPanel.lua)

---------------------------------------------------------------------------
-- The player's look for this window (Options > Guide window, UI/Looks/
-- GuideWindow.lua): sizes (readMetrics), text sizes per element, the
-- transparent style's outline, the target bar, the progress line, its own
-- ground and border, fading while the cursor is away, motion. Every default
-- leaves the window exactly as the skin draws it.
---------------------------------------------------------------------------

GF.LOOK = {
	tabs = true, tabHeight = 1, navHeight = 1, stepCount = true, guideTitle = true, skipButton = true, reportButton = true,
	barTextSize = 1, titleSize = 1, goalSize = 1, detailSize = 1, noteSize = 1, upSize = 1,
	outline = "outline", padding = 0, rowSpacing = 0, lineSpacing = 0, glyphSize = 1, checkSize = 1,
	targetBar = true, targetBarColor = false, targetBarWidth = 2,
	progress = true, progressPct = true, progressHeight = 3, progressColor = false,
	bgColor = false, bgOpacity = false, border = true, idleAlpha = 1, combatAlpha = 0.35, veil = 0.68, shade = 0.2,
	stepAnim = true, animSpeed = 1, foldAnim = true, rules = true, hideTaxi = false,
}
ns.RegisterDefaults("guideWindow", GF.LOOK)

function GF.On(key) return ns.Get("guideWindow." .. key) ~= false end
function GF.Num(key) return tonumber(ns.Get("guideWindow." .. key)) or GF.LOOK[key] end
-- A colour setting: r, g, b, or nil to follow the theme.
function GF.Rgb(key)
	local c = ns.Get("guideWindow." .. key)
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3] end
	return nil
end

-- The transparent style's outline (guideWindow.outline): true (thin),
-- "thick", or false (the drop shadow alone).
function GF.Outline()
	local o = ns.Get("guideWindow.outline")
	if o == "thick" then return "thick" end
	return o ~= "shadow"
end

-- Strings the player sizes by element: group -> its setting. GF.sized:
-- fontString -> group; GF.spaced: fontString -> its own line spacing (wrapped
-- lines, guideWindow.lineSpacing on top); GF.sizedAt: what was applied, so an
-- untouched string is never painted again.
GF.SIZE_KEYS = { title = "titleSize", goal = "goalSize", detail = "detailSize", note = "noteSize", up = "upSize", bar = "barTextSize" }
GF.sized = setmetatable({}, { __mode = "k" })
GF.spaced = setmetatable({}, { __mode = "k" })
GF.sizedAt = setmetatable({}, { __mode = "k" })

function GF.SizeOne(fs)
	local group = GF.sized[fs]
	local k = group and GF.Num(GF.SIZE_KEYS[group]) or 1
	local gap = GF.Num("lineSpacing")
	local at = GF.sizedAt[fs]
	if (at and (at[1] ~= k or at[2] ~= gap)) or (not at and (k ~= 1 or gap ~= 0)) then
		if Theme.SetFontScale then Theme.SetFontScale(fs, k) end
		local base = GF.spaced[fs]
		if base and fs.SetSpacing then fs:SetSpacing(base + gap) end
		GF.sizedAt[fs] = { k, gap }
	end
end

-- fs sized as `group`; `spacing`: its own line spacing when its lines wrap.
function GF.SizeAs(fs, group, spacing)
	GF.sized[fs] = group
	if spacing then GF.spaced[fs] = spacing end
	GF.SizeOne(fs)
	return fs
end

function GF.ApplyFonts()
	for fs in pairs(GF.sized) do GF.SizeOne(fs) end
end

-- The arrow's target on a goal or the person: a bar at the row's edge in
-- the accent (or the player's colour), guideWindow.targetBarWidth wide;
-- turned off it stays laid out, unseen.
function GF.PaintMark(t)
	local r, g, b = GF.Rgb("targetBarColor")
	if r then t:SetVertexColor(r, g, b, 1) else t:SetVertexColor(Theme.Color("accent")) end
	t:SetWidth(GF.Num("targetBarWidth"))
	t:SetAlpha(GF.On("targetBar") and 1 or 0)
end

-- The guide's progress fill: the accent, or the player's colour.
function GF.PaintProgressFill(t)
	local r, g, b = GF.Rgb("progressColor")
	if r then t:SetVertexColor(r, g, b, 1) else t:SetVertexColor(Theme.Color("accent")) end
end

-- The goal glyph's centre below a row's top: on the first line of its text,
-- which grows with guideWindow.goalSize (14 at 100 %).
function GF.GlyphY()
	return 12 + ROW_PAD + floor((GF.Num("goalSize") - 1) * 7 + 0.5)
end

-- How long a transition of `d` seconds takes at guideWindow.animSpeed.
function GF.Dur(d)
	return d / max(0.25, GF.Num("animSpeed"))
end

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
		local new = ns.NewQuests and ns.NewQuests.TooltipText(goal.quest)
		if new then lines[#lines + 1] = { new, Theme.Accent() } end
		-- A dungeon's quest, or one of the nearest prerequisites before one (Dungeons/Mark.lua).
		local dungeon = ns.Dungeons and ns.Dungeons.MarkTooltip and ns.Dungeons.MarkTooltip(goal.quest)
		if dungeon then lines[#lines + 1] = { dungeon, Theme.Accent() } end
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
	-- An accept: the level the quest needs (red while the character is below
	-- it) and the prerequisites not handed in yet (Engine.AcceptGate, #1247).
	local E = Engine()
	local gate = goal.t == "accept" and view and E and E.AcceptGate and E.AcceptGate(view.index, goal.index)
	if gate then
		if gate.level then
			local text = L["Requires level %d"]:format(gate.level)
			lines[#lines + 1] = { left = L["Level"], right = gate.short and ("|c" .. Theme.Hex("danger") .. text .. "|r") or text }
		end
		if #gate.needs > 0 then
			lines[#lines + 1] = { left = L["Needs"], right = "|c" .. Theme.Hex("danger") .. table.concat(gate.needs, ", ") .. "|r" }
		end
	end
	local rewards = UI.GoalRewards(goal)
	if rewards then lines[#lines + 1] = { left = L["Reward"], right = rewards } end
	-- What the quest opens up: what skipping it gives up (UI.UnlockLines).
	if goal.quest and not (goal.t == "turnin" and goal.status == "done") then UI.UnlockLines(goal.quest, lines) end
	if goal.skippedWith then lines[#lines + 1] = L["Left out because you skipped %s"]:format(ns.Quoted(goal.skippedWith)) end
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
	if goal.unavailable == "skipped" then
		lines[#lines + 1] = { L["Right-click to bring this quest back"], ar, ag, ab }
	elseif goal.quest and goal.status ~= "done" then
		lines[#lines + 1] = { L["Right-click to tick it done or skip this quest"], ar, ag, ab }
	elseif goal.tickable and goal.status ~= "skipped" then
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

-- Skip an optional goal, or bring it back; a quest the player skipped comes
-- back (its accept's Undo).
local function skipGoal(row)
	local E, goal = Engine(), row.psGoal
	if not (E and goal and view) then return end
	if goal.unavailable == "skipped" and E.SkipQuest then return E.SkipQuest(goal.quest, false) end
	if E.SkipGoal and goal.optional then E.SkipGoal(view.index, goal.index) end
end

-- A quest's line, right-clicked: tick this goal done (or untick it), or skip
-- the whole quest and what follows from it (Engine.SkipQuest), or bring a
-- skipped quest back.
local function rowMenu(row)
	local E, goal = Engine(), row.psGoal
	if not (E and goal and goal.quest and E.SkipQuest) then return false end
	if goal.unavailable == "skipped" then
		E.SkipQuest(goal.quest, false)
		return true
	end
	local items = {}
	if goal.tickable and goal.status ~= "done" or goal.ticked then
		items[#items + 1] = { text = goal.ticked and L["Untick"] or L["Tick it done"], icon = "check", onClick = function() toggleGoal(row) end }
	end
	-- What this guide leaves out with it (Engine.SkipLoses), named in the tip.
	local tip = L["This quest and the ones that follow from it are skipped, in every guide. Right-click it again to bring it back."]
	local loses = E.SkipLoses and UI.SkipLosesText(E.SkipLoses(goal.quest))
	if loses then tip = tip .. " " .. loses end
	items[#items + 1] = { text = L["Skip this quest"], icon = "skip", tip = tip,
		onClick = function() E.SkipQuest(goal.quest, true) end }
	W.ShowMenu(row, items)
	return true
end

-- A goal of the step the guide is on: the Engine leads the arrow there
-- (its spawn areas and spots too, which a click on the arrow moves on
-- through) and drops any point picked by hand; a goal whose quest is not
-- taken yet leaves the arrow on the accept and says so (#1385). False for a
-- goal anywhere else.
function GF.AimGoal(goal)
	local E, nav = Engine(), ns.Nav
	if not (goal and goal.index and view and E and E.AimGoal and E.GetStepIndex and E.GetStepIndex() == view.index) then return false end
	local aimed, why, title = E.AimGoal(view.index, goal.index)
	if not (aimed or why == "accept") then return false end
	if nav and nav.ReleaseTarget then nav.ReleaseTarget() end
	GF.UpdateTargets()
	if why == "accept" then
		local message = string.format(L["Take %s first"], ns.Quoted(title) or "")
		if UIErrorsFrame and UIErrorsFrame.AddMessage then
			UIErrorsFrame:AddMessage(message, 1, 0.82, 0)
		else
			ns.Print(message)
		end
	end
	return true
end

local function rowClick(row, button)
	local goal = row.psGoal
	if not goal then return end
	if button == "RightButton" then
		if not rowMenu(row) then toggleGoal(row) end
		return
	end
	-- Anywhere else than the step the guide is on, a plain point.
	if not GF.AimGoal(goal) then pointAt(goal, goal.text) end
end

local function rowEnter(row)
	local goal = row.psGoal
	if goal and ((goal.x and goal.map) or goal.tickable) then row.Hover:Show() end
	goalTooltip(row)
	GF.HoverIn()
	GF.BarWake()
end

local function rowLeave(row)
	row.Hover:Hide()
	W.HideTooltip(row)
end

local function goalRow(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, goals.Child)
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
	W.Painter(r.Mark, GF.PaintMark)
	r.Mark:Hide()
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(ICON, ICON)
	r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -GF.GlyphY())
	r.Text = GF.SizeAs(T(r, "goal", "text"), "goal", 0)
	r.Text:SetWordWrap(true)
	r.Text:SetJustifyV("TOP")
	r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -4 - ROW_PAD)
	r.Sub = GF.SizeAs(T(r, "small", "textMuted"), "detail", 0)
	r.Sub:SetWordWrap(true)
	r.Sub:SetJustifyV("TOP")
	r.Check = W.Checkbox(r, function(c)
		-- The click already flipped the box; the Engine's view is the truth,
		-- so put it back and let STEP_UPDATED repaint it.
		c:SetChecked(c.psChecked)
		toggleGoal(r)
	end)
	if transparent() then
		r.Check.psOnWorld = true
		Theme.Repaint(r.Check)
	end
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
		local back = goal and (goal.dismissed or goal.unavailable == "skipped")
		W.Tooltip(b, "ANCHOR_TOP", back and L["Bring it back"] or L["Skip this optional goal"],
			{ back and L["It leads the arrow again."] or L["The arrow moves on; Undo brings it back."] })
		GF.HoverIn()
	end)
	r.Skip:SetScript("OnLeave", function(b)
		W.Color(b.Label, "textDim")
		W.HideTooltip(b)
	end)
	r.Skip:Hide()
	-- "Share": the goal's quest, for party members who lack it and can take
	-- it (Party.ShareFor); the game's own share, with its rules.
	r.Share = CreateFrame("Button", nil, r)
	r.Share:SetHeight(18)
	W.Hover(r.Share, 0.7)
	r.Share.Label = T(r.Share, "small", "accent")
	r.Share.Label:SetPoint("CENTER", r.Share, "CENTER", 0, 0)
	r.Share:SetScript("OnClick", function(b)
		local P, goal = ns.Party, r.psGoal
		if P and goal and goal.quest then P.Share(goal.quest) end
	end)
	r.Share:SetScript("OnEnter", function(b)
		W.Color(b.Label, "text")
		W.Tooltip(b, "ANCHOR_TOP", L["Share with your party"], { L["Not on it: %s"]:format(table.concat(b.psNames or {}, ", ")) })
		GF.HoverIn()
	end)
	r.Share:SetScript("OnLeave", function(b)
		W.Color(b.Label, "accent")
		W.HideTooltip(b)
	end)
	r.Share:Hide()
	placeCheck(r)
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
-- `noEscort`: one already says the escort line; `noFinder`: the group
-- finder line (UI.FinderLine).
-- `who`: the person a goal of another group is done with (rowWho), said
-- first on its line; `aside`: a goal outside the focus, open goals step back.
-- `questHex`: the quest name's colour (the class-quest card's class colour).
local function paintRow(r, goal, pop, sameStep, current, noParty, noMissing, noEscort, who, aside, questHex, noFinder)
	local sameGoal = sameStep and r.psGoal and r.psGoal.index == goal.index and r.psGoal.t == goal.t
	r.psGoal = goal
	local status = goal.status
	local done = status == "done"
	local skipped = status == "skipped"
	r.Icon:SetTexture(done and Theme.Media("check") or (goal.dismissed and Theme.Media("skip")) or Theme.VerbIcon(goal.t))
	if skipped then
		W.Color(r.Icon, "textMuted", 0.8)
	else
		local gold = Theme.GameSkin() and (goal.t == "accept" or goal.t == "turnin")
		W.Color(r.Icon, done and "success" or ((current or gold) and "accent" or "textDim"))
	end
	-- The game's looks light the goal to do now with their own art.
	Theme.KitRowLit(r, current and not done and not skipped and not transparent(), nil, Theme.Metric("guideLitInset", 4))
	UI.SetCounted(r.Text, UI.GoalLine(goal, questHex, true))
	-- White while it is to be done; done and skipped goals step back. The
	-- turn-in of a quest whose objectives are still open, pinned (#644),
	-- ticked by hand (#1135) or worked along the way (#853): the warning
	-- colour, and its line says so.
	local warn = goal.pinOpen and not done and not skipped
	W.Color(r.Text, (done or skipped) and "textMuted" or (warn and "warning" or (aside and "textDim" or "text")))
	local sub = UI.GoalSubline(goal, person.Where:IsShown() and person.psPlace and person.psPlace.map or nil, noParty, noMissing, noEscort, noFinder)
	if warn then
		local open = goal.pinOpen == "along" and L["Its objectives are still open."]
			or goal.pinOpen == "ticked" and L["Ticked by you, but the game still counts its objectives open: finish them first."]
			or L["Pinned: its objectives are still open."]
		sub = sub and (open .. "\n" .. sub) or open
	end
	-- An unavailable quest's reason names its giver already.
	if who and not goal.unavailable then sub = sub and (who .. "  \194\183  " .. sub) or who end
	UI.SetCounted(r.Sub, sub or "")
	r.Sub:SetShown(sub ~= nil)
	-- An unavailable quest's reason, or an accept's notice, is the point of the line: keep it readable.
	W.Color(r.Sub, (goal.unavailable or goal.noticeText) and "textDim" or "textMuted")
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
	local questSkipped = goal.unavailable == "skipped" and goal.t == "accept"
	local canSkip = questSkipped or goal.optional and (goal.dismissed or (not done and not skipped)) and Engine() and Engine().SkipGoal
	r.Skip:SetShown(canSkip and true or false)
	if canSkip then
		r.Skip.Label:SetText((goal.dismissed or questSkipped) and L["Undo"] or L["Skip"])
		r.Skip:SetWidth(floor(r.Skip.Label:GetStringWidth() + 12 + 0.5))
	end
	-- Party members lack the quest and can take it: Share, once per card.
	local shareTo = not noMissing and ns.Party and ns.Party.ShareFor and ns.Party.ShareFor(goal) or nil
	r.Share.psNames = shareTo
	r.Share:SetShown(shareTo ~= nil)
	if shareTo then
		r.Share.Label:SetText(L["Share"])
		r.Share:SetWidth(floor(r.Share.Label:GetStringWidth() + 12 + 0.5))
	end
	if pop then
		Anim.To(r.Icon, "size", ICON * 0.55, ICON, Anim.BASE, "back")
		Anim.To(r.Icon, "alpha", 0.2, 1, Anim.FAST, "out")
	elseif not Anim.IsRunning(r.Icon, "size") then
		r.Icon:SetSize(ICON, ICON)
	end
	r.psStatus = status
	-- A skin's own dress for the row (Skin API 2, hooks.guideRow): after the
	-- house painted it; r.psRowInfo, the row's own table, says what it shows.
	local info = r.psRowInfo
	if not info then
		info = {}
		r.psRowInfo = info
	end
	info.current, info.done, info.skipped = current and true or false, done, skipped
	Theme.SkinHook("guideRow", r, goal, info)
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
	if r.Check:IsShown() then right = right + CHECK + 4 + CHECK_IN end
	if r.Skip:IsShown() then
		r.Skip:ClearAllPoints()
		r.Skip:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(right - 4), -3 - ROW_PAD)
		right = right + r.Skip:GetWidth() + 2
	end
	if r.Share:IsShown() then
		r.Share:ClearAllPoints()
		r.Share:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(right - 4), -3 - ROW_PAD)
		right = right + r.Share:GetWidth() + 2
	end
	if r.Alt:IsShown() then
		r.Alt:ClearAllPoints()
		r.Alt:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(right - 4), -2 - ROW_PAD)
		right = right + 20
	end
	local tw = max(40, width - TEXT_X - right)
	r.Text:SetWidth(tw)
	UI.FitCounts(r.Text)
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
		UI.FitCounts(r.Sub)
		r.Sub:ClearAllPoints()
		r.Sub:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -3)
		h = h + 3 + r.Sub:GetStringHeight()
	end
	return max(ROW_MIN, floor(h + 6 + ROW_PAD * 2 + 0.5))
end

---------------------------------------------------------------------------
-- The goals area: the focus's rows, a summary line for each other person
-- of the step, "✓ 3 done", the folding of finished goals, the height cap's
-- scroll
---------------------------------------------------------------------------

-- A goal turning done: its check pops (paintRow), it holds `hold` seconds so
-- the player sees it, then its row folds shut over `time` (ease-out) while
-- its text and glyph fade in the first `fade` share of that, the rows below
-- gliding up; then "✓ N done" counts it, the line's text glowing from the
-- accent back to textDim over `glow`. Goals done together (a turn-in batch)
-- start `stagger` apart, so they close as one movement. Reduced motion: the
-- hold, a fade of `reducedFade`, then the row is gone and the count changes.
local CARD = {
	hold = 0.75, stagger = 0.08, time = 0.3, fade = 0.6, reducedFade = 0.2, glow = 0.6,
	lineH = 24, -- a summary line
	minView = 72, -- the goals area under the cap: never shorter than three lines
	ahead = 3, -- summary lines after the focus before the rest share a "+ N more people" line
	scrollStep = 48, -- one wheel notch
	barIdle = 1.5, -- seconds the scroll bar stays after the last scroll
}
GF.CARD = CARD

-- Look-ahead text (the card's summary lines, Along the way, Up next) wraps
-- to two lines (SetWordWrap, SetMaxLines 2) and only past them ends in "…";
-- its row grows by the second line. -> the text's top inset in a row `rowH`
-- tall for one line (one line sits in its middle), and the row's height.
local function twoLines(fs, rowH)
	local inset = max(0, (rowH - fs:GetLineHeight()) / 2)
	return inset, max(rowH, floor(fs:GetStringHeight() + inset * 2 + 0.5))
end

-- What the card keeps for one guide, step and focus (cleared when any of
-- them moves): the goals folded into the done line, each goal's status at
-- the last fill (a goal turning done folds; one already done when the focus
-- came is folded from the start), the groups a click opened (`before`: the
-- persons done), whether the done line is opened, and its count.
local model = { folded = {}, last = {}, open = {}, doneOpen = false, doneN = 0 }

-- The goals area's contents, top to bottom (goal rows and lines; f.psAt is
-- the place), and their heights at full size (`h`, layoutCard). A folding
-- row's f.psK (1 open .. 0 shut) scales its height; each sits under the one
-- before, so a fold moves the rows below without placing them.
local area = { items = {}, h = {}, n = 0 }

-- The window around the goals area (Layout): the card without it (`fixed`),
-- the card's y in the body (`top`), the frames under the card (`below`,
-- their y from its bottom in `rel`, `n` of them, `h` tall), the strip,
-- navigator and foot (`outer`), and the room the cap leaves the goals
-- (`room`, math.huge while the window fits). `from`: the card's bottom
-- while Layout stacks the frames under it. `limit`: with ui.growUp, the
-- height to the top of the screen (roomAbove; nil without Grow upward).
local fit = { fixed = 0, top = 0, outer = 0, room = math.huge, below = {}, rel = {}, n = 0, h = 0 }

-- The window's height for a body `y` tall under the bars (`fit.outer`).
-- With Grow upward the game keeps a window on the screen by moving it
-- down, which would move the bottom edge Grow upward keeps still (#666), so
-- the window never passes `fit.limit`: past it, the body clips its lower
-- lines at the bars; at least MIN_BODY_H of it stays.
local MIN_BODY_H = 40
local function sizeWindow(y)
	local natural = floor(fit.outer + y + 0.5)
	local height, limit = natural, fit.limit
	if limit and natural > limit then height = max(floor(limit), floor(fit.outer + MIN_BODY_H + 0.5)) end
	local cut = height < natural
	if body.SetClipsChildren then body:SetClipsChildren(cut) end
	body:SetHeight(max(1, cut and height - fit.outer or y))
	F:SetHeight(height)
end

-- The goals folding now: one record per goal (pooled: `pool`), its
-- collapse's start `at` (after the hold), its height share `k` and alpha
-- `a` as last drawn, the row showing it (fillCard sets it; rows are
-- reassigned on every fill). `of`: goal index -> record; `last`: the latest
-- start, for the stagger; `grow`: the done line growing in with the first
-- fold; `glow`, `glowAt`: the done line whose count just went up.
local fold = { list = {}, n = 0, of = {}, pool = {}, last = 0, serial = 0, glowAt = 0, driver = CreateFrame("Frame") }

local wholeStep, resetModel, contentHeight, fitGoals, followCurrent, inSight, cardLine, goalsWheel
do
	function wholeStep() return ns.Get("ui.wholeStep") and true or false end

	local function refreshTargets()
		if UI.NameTargets then UI.NameTargets.Refresh() end
	end

	function contentHeight()
		local h, items, hs = 0, area.items, area.h
		for i = 1, area.n do h = h + hs[i] * (items[i].psK or 1) end
		return h
	end

	-- The y of item `f` from the top of the goals area; nil when not listed.
	local function itemTop(f)
		local y, items, hs = 0, area.items, area.h
		for i = 1, area.n do
			local o = items[i]
			if o == f then return y end
			y = y + hs[i] * (o.psK or 1)
		end
		return nil
	end
	GF.ItemTop = itemTop

	-- The goals area's items, top to bottom (tests, preview).
	function GF.CardItems()
		local out = {}
		for i = 1, area.n do out[i] = area.items[i] end
		return out
	end

	-- The scroll bar shows while there is more to scroll, and fades
	-- CARD.barIdle after the last wheel, scroll or the cursor on a goal.
	local barIdleAt = 0
	local function barFade()
		local bar = goals.Bar
		if GetTime() + 0.01 < barIdleAt or (bar.IsMouseOver and bar:IsMouseOver()) then return end
		Anim.To(bar, "alpha", bar:GetAlpha(), 0, 0.4, "out")
	end
	local function barWake()
		if not goals.psOver then return end
		local bar = goals.Bar
		if bar:GetAlpha() < 1 then Anim.To(bar, "alpha", bar:GetAlpha(), 1, Anim.FAST, "out") end
		barIdleAt = GetTime() + CARD.barIdle
		ns.After(CARD.barIdle, barFade)
	end
	GF.BarWake = barWake

	-- The goals area's height past the cap `limit`: whole items from the top,
	-- so the cap never cuts a line in half (a wrapped goal's second line
	-- half hidden under the tip, the window looking finished while a goal
	-- is out of sight). The bottom of the last item that fits; when that is
	-- under CARD.minView, the floor (which already outranks the cap) grows to
	-- the bottom of the item the cap cuts, unless that passes the cap by more
	-- than the floor itself: then the cap stays and the item scrolls.
	local function wholeItems(limit)
		local y, down, items, hs = 0, 0, area.items, area.h
		for i = 1, area.n do
			y = y + hs[i] * (items[i].psK or 1)
			if y > limit + 0.5 then
				if down >= CARD.minView - 0.5 then return down end
				return y <= limit + CARD.minView and y or limit
			end
			down = y
		end
		return limit
	end

	-- Size the goals area to its contents within the cap, then the card, the
	-- frames under it and the window to that. Runs every frame a row folds,
	-- so it only sets sizes and points. Past the cap the area ends on a whole
	-- item (wholeItems); while goals fold it keeps that height, shrinking
	-- only to the content, and settles on the next layout after the folds.
	function fitGoals()
		local content = contentHeight()
		local limit = max(CARD.minView, fit.room)
		local viewH = min(content, limit)
		if fold.n > 0 and goals.psWhole then
			viewH = min(content, goals.psViewH)
		else
			goals.psWhole = content > limit + 0.5
			if goals.psWhole then viewH = wholeItems(limit) end
		end
		goals:SetHeight(max(0.01, viewH))
		goals.psContentH, goals.psViewH = content, viewH
		W.SetScrollContent(goals, content, viewH)
		local over = content > viewH + 0.5
		if over ~= goals.psOver then
			goals.psOver = over
			-- Without more to see, the wheel stays the camera's.
			goals:EnableMouseWheel(over)
			barWake()
		end
		local cardH = fit.fixed + viewH
		card:SetHeight(cardH)
		local y = fit.top + cardH
		local below, rel = fit.below, fit.rel
		for i = 1, fit.n do
			local f, at = below[i], -(y + rel[i])
			f:SetPoint("TOPLEFT", body, "TOPLEFT", 0, at)
			f:SetPoint("TOPRIGHT", body, "TOPRIGHT", 0, at)
		end
		y = y + fit.h
		sizeWindow(y)
	end

	-- Scroll the goals area to `to` (clamped), gliding there unless `snap`.
	local function scrollTo(to, snap)
		local cur = goals:GetVerticalScroll()
		to = min(max(0, (goals.psContentH or 0) - (goals.psViewH or 0)), max(0, to))
		if abs(to - cur) < 0.5 then return end
		barWake()
		if snap then
			Anim.Stop(goals, "value")
			W.ScrollTo(goals, to)
			refreshTargets()
		else
			Anim.To(goals, "value", cur, to, Anim.BASE, "out", refreshTargets)
		end
	end

	function goalsWheel(self, delta)
		Anim.Stop(self, "value")
		scrollTo(self:GetVerticalScroll() - delta * CARD.scrollStep, true)
	end

	-- Keep the current goal in sight: from the top for a new focus, else
	-- scrolled just far enough to show its row whole.
	function followCurrent(top)
		if not goals.psOver then
			if goals:GetVerticalScroll() ~= 0 then W.ScrollTo(goals, 0) end
			return
		end
		if top then
			Anim.Stop(goals, "value")
			W.ScrollTo(goals, 0)
		end
		local to = goals:GetVerticalScroll()
		for i = 1, area.n do
			local o = area.items[i]
			if o.psGoal and view and o.psGoal.index == view.current and not o.psFold then
				local y, h, viewH = itemTop(o), area.h[i], goals.psViewH
				if y < to then
					to = y
				elseif y + h > to + viewH then
					to = y + h - viewH
				end
				break
			end
		end
		scrollTo(to, false)
	end

	-- Whether item `f` shows whole in the goals area (scrolled into sight).
	function inSight(f)
		if not goals.psOver then return true end
		local y = itemTop(f)
		if not y then return false end
		local top = goals:GetVerticalScroll()
		return y >= top - 0.5 and y + area.h[f.psAt] <= top + goals.psViewH + 0.5
	end

	-- Summary lines: a person of the step other than the focus, the persons
	-- done ("before") or the focus's finished goals ("done"); a click opens
	-- or closes the goals it stands for in place.
	local function lineClick(self)
		local key = self.psKey
		if key == "done" then
			model.doneOpen = not model.doneOpen
		else
			model.open[key] = (not model.open[key]) or nil
		end
		W.HideTooltip(self)
		GF.Refill()
	end

	local function lineEnter(self)
		local tips, list = {}, self.psGoals
		for i = 1, list and min(#list, 12) or 0 do tips[#tips + 1] = UI.GoalLine(list[i]) end
		local open = (self.psKey == "done" and model.doneOpen) or (self.psKey ~= "done" and model.open[self.psKey])
		tips[#tips + 1] = { open and L["Click to fold them away"] or L["Click to list them"], Theme.Accent() }
		W.Tooltip(self, tooltipAnchor(), self.psTitle or "", tips)
		GF.HoverIn()
		barWake()
	end

	local function lineLeave(self) W.HideTooltip(self) end

	function cardLine(i)
		local l = lines[i]
		if l then return l end
		local lh = CARD.lineH
		l = CreateFrame("Button", nil, goals.Child)
		l:SetHeight(lh)
		l.psLine = true
		W.Hover(l, 0.7)
		l.Icon = l:CreateTexture(nil, "ARTWORK")
		l.Icon:SetSize(13, 13)
		l.Icon:SetPoint("CENTER", l, "TOPLEFT", PAD + ICON / 2, -lh / 2)
		l.Text = GF.SizeAs(T(l, "label", "textDim"), "detail")
		l.Text:SetWordWrap(true)
		l.Text:SetMaxLines(2)
		l.Text:SetJustifyH("LEFT")
		l.Text:SetPoint("TOPLEFT", l, "TOPLEFT", TEXT_X, -twoLines(l.Text, lh))
		l.Chevron = l:CreateTexture(nil, "ARTWORK")
		l.Chevron:SetSize(10, 10)
		l.Chevron:SetPoint("CENTER", l, "TOPRIGHT", -PAD - 5, -lh / 2)
		W.Color(l.Chevron, "textMuted")
		l:SetScript("OnClick", lineClick)
		l:SetScript("OnEnter", lineEnter)
		l:SetScript("OnLeave", lineLeave)
		lines[i] = l
		return l
	end

	local EASE_OUT = Anim.EASE.out

	-- One frame of every fold and of the done line's glow; the window's
	-- sizes follow (fitGoals). A fold that lands refills the card once,
	-- which drops its row and counts it.
	function fold.step()
		local now = GetTime()
		-- guideWindow.foldAnim off: the row fades and goes, as with reduced motion.
		local reduced = Anim.Reduced() or not GF.On("foldAnim")
		local dur = reduced and CARD.reducedFade or GF.Dur(CARD.time)
		local list = fold.list
		local moved, landed = false, false
		local i = 1
		while i <= fold.n do
			local rec = list[i]
			local r = rec.row
			if r and r.psFold ~= rec then r = nil end
			local t = now - rec.at
			if t >= dur then
				list[i] = list[fold.n]
				list[fold.n] = nil
				fold.n = fold.n - 1
				fold.of[rec.goal] = nil
				model.folded[rec.goal] = true
				if r then
					r:SetAlpha(0)
					r.psFold = nil
				end
				rec.row = nil
				fold.pool[#fold.pool + 1] = rec
				landed = true
			else
				if t > 0 and r then
					local p = t / dur
					if reduced then
						rec.a = 1 - p
						r:SetAlpha(rec.a)
					else
						-- Cubic ease-out: a calmer start than the house quart.
						local u = 1 - p
						local k = u * u * u
						rec.k, rec.a = k, max(0, 1 - p / CARD.fade)
						r:SetAlpha(rec.a)
						r.psK = k
						r:SetHeight(max(0.01, area.h[r.psAt] * k))
						local g = fold.grow
						if rec.grow and g then
							g.psK = 1 - k
							g:SetHeight(max(0.01, CARD.lineH * (1 - k)))
							g:SetAlpha(1 - k)
						end
						moved = true
					end
				end
				i = i + 1
			end
		end
		local gl = fold.glow
		if gl then
			local p = (now - fold.glowAt) / CARD.glow
			if p >= 1 then
				W.Color(gl.Text, "textDim")
				fold.glow = nil
			else
				local e = EASE_OUT(p)
				local ar, ag, ab = Theme.Accent()
				local dr, dg, db = Theme.Color("textDim")
				gl.Text:SetTextColor(ar + (dr - ar) * e, ag + (dg - ag) * e, ab + (db - ab) * e)
			end
		end
		if moved then fitGoals() end
		if landed then GF.Refill() end
		if fold.n == 0 and not fold.glow then fold.driver:SetScript("OnUpdate", nil) end
	end

	function fold.run()
		fold.tick = fold.tick or ns.Safe(fold.step)
		if fold.driver:GetScript("OnUpdate") ~= fold.tick then fold.driver:SetScript("OnUpdate", fold.tick) end
	end

	-- Goal gi just turned done: its fold, after the hold and behind any
	-- fold already waiting. -> the record
	function fold.start(gi)
		local pool = fold.pool
		local rec = pool[#pool]
		if rec then pool[#pool] = nil else rec = {} end
		local at = max(GetTime() + CARD.hold, fold.last + CARD.stagger)
		fold.last = at
		rec.goal, rec.at, rec.row, rec.grow, rec.k, rec.a, rec.pop = gi, at, nil, nil, nil, nil, true
		fold.n = fold.n + 1
		fold.list[fold.n] = rec
		fold.of[gi] = rec
		fold.run()
		return rec
	end

	-- A folding goal open again (unticked), gone from the card, or the
	-- card moving on: its row back to full.
	function fold.drop(rec)
		local r = rec.row
		if r and r.psFold == rec then
			r.psFold, r.psK = nil, nil
			r:SetAlpha(1)
		end
		rec.row = nil
		fold.of[rec.goal] = nil
		local list = fold.list
		for i = 1, fold.n do
			if list[i] == rec then
				list[i] = list[fold.n]
				list[fold.n] = nil
				fold.n = fold.n - 1
				break
			end
		end
		fold.pool[#fold.pool + 1] = rec
	end

	-- Whether the fold driver runs (tests: it stops once nothing moves).
	function GF.Folding() return fold.driver:GetScript("OnUpdate") ~= nil end

	local function wipe(t) for k in pairs(t) do t[k] = nil end end

	-- A new guide, step or focus: nothing folded, opened or folding.
	function resetModel()
		while fold.n > 0 do fold.drop(fold.list[fold.n]) end
		wipe(model.folded)
		wipe(model.last)
		wipe(model.open)
		model.doneOpen, model.doneN = false, 0
		fold.grow, fold.last = nil, 0
		if fold.glow then W.Color(fold.glow.Text, "textDim") end
		fold.glow = nil
	end
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
	person.psGroup = group
	-- The arrow on this person marks the header; a field group's goals carry
	-- their own marks, except the "Go to" the header stands for.
	person.psPerson = kind ~= "here"
	person.Mark:SetShown(personMarked(targetOf()))
end

local function personEnter(self)
	self.Hover:Show()
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

local function personLeave(self)
	self.Hover:Hide()
	W.HideTooltip(self)
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
	r.Num = GF.SizeAs(T(r, "number", "textMuted"), "up")
	r.Num:SetJustifyH("RIGHT")
	r.Num:SetWidth(22)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(13, 13)
	W.Color(r.Icon, "textMuted")
	r.Text = GF.SizeAs(T(r, "label", "textDim"), "up")
	r.Text:SetWordWrap(true)
	r.Text:SetMaxLines(2)
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
-- Along the way: open goals of `along` steps the route has passed
-- (Engine.GetAlong), under the card until they are done
---------------------------------------------------------------------------

local ALONG_MAX = 6

local function alongRow(i)
	local r = alongRows[i]
	if r then return r end
	r = CreateFrame("Button", nil, along)
	r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	r:SetHeight(UP_ROW)
	W.Hover(r)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(13, 13)
	W.Color(r.Icon, "textMuted")
	r.Text = GF.SizeAs(T(r, "label", "textDim"), "up")
	r.Text:SetWordWrap(true)
	r.Text:SetMaxLines(2)
	r:SetScript("OnClick", function(self, button)
		local E = Engine()
		-- A quest an update left behind the player (Engine.GetBehind): the
		-- arrow on a click, Skip or Abandon on a right-click.
		local q = self.psBehind
		if q and E then
			if button ~= "RightButton" then
				if E.AimBehind then E.AimBehind(q) end
				return
			end
			W.ShowMenu(self, {
				{ text = L["Skip this quest"], icon = "skip", onClick = function() E.SkipBehind(q) end },
				{ text = L["Abandon"], icon = "close", onClick = function() ns.Compat.AskAbandonQuest(q) end },
			})
			return
		end
		-- A pinned quest's row unpins it on a right-click (#644).
		if button == "RightButton" then
			if self.psPin and E and E.PinQuest then E.PinQuest(self.psPin, false) end
			return
		end
		if E and E.AimAlong and self.psStep then E.AimAlong(self.psStep, self.psGoal) end
	end)
	r:SetScript("OnEnter", function(self)
		local lines = {}
		if self.psPlace then lines[#lines + 1] = { L["Click to point the arrow here"], Theme.Accent() } end
		if self.psPin then lines[#lines + 1] = { L["Pinned by you. Right-click to unpin."], Theme.Color("textDim") } end
		if self.psBehind then
			lines[#lines + 1] = { L["You carry this quest; the update moved what is left of it before your place in the guide."], Theme.Color("textDim") }
			lines[#lines + 1] = { L["Right-click to skip or abandon it."], Theme.Color("textDim") }
		end
		W.Tooltip(self, tooltipAnchor(), self.psTitle or "", lines)
		GF.HoverIn()
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	alongRows[i] = r
	return r
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

-- The tab a class guide was opened from by the class quest heads-up
-- (UI/ClassToast.lua, CharState().classReturn), while that guide is still
-- open in another tab. -> { id, title, tab } | nil
function GF.ClassReturn(id)
	local E = Engine()
	local st = ns.CharState()
	local from = st.classReturn and st.classReturn[id]
	if not (from and E and E.GetTabs) then return nil end
	local list = E.GetTabs()
	for i, t in ipairs(list or {}) do
		if t.guideId == from then return { id = from, title = t.title or from, tab = i } end
	end
	return nil
end

-- Close the finished class guide's tab and show the guide it came from.
function GF.CloseAndReturn(id)
	local E = Engine()
	local back = GF.ClassReturn(id)
	if not (back and E and E.GetTabs and E.CloseTab) then return end
	local list, active = E.GetTabs()
	local mine = list and list[active] and list[active].guideId == id and active
	ns.CharState().classReturn[id] = nil
	if mine then E.CloseTab(mine, true) end
	if E.SetGuide then E.SetGuide(back.id) end
end

local function setEmpty(kind)
	state = kind
	local E, G = Engine(), ns.Guides
	empty.Primary:Hide()
	empty.Secondary:Hide()
	local glyph, color = "emblem", "accent"
	if kind == "noguides" and UI.Packs and UI.Packs.OursSwitchedOff() then
		-- Our own guides switched off on the Community guides page: one
		-- click turns them back on.
		empty.Title:SetText(L["No guides shown"])
		empty.Text:SetText(L["Polestar's own guides are switched off on the Community guides page (/polestar packs)."])
		W.SetButtonText(empty.Primary, L["Show Polestar's guides"])
		empty.Primary.psAction = function()
			if G and G.SetPackShown then G.SetPackShown("guides", true) end
		end
		empty.Primary:Show()
		W.SetButtonText(empty.Secondary, L["Community guides"])
		empty.Secondary.psAction = function() UI.ShowOptions("guidepacks") end
		empty.Secondary:Show()
	elseif kind == "noguides" and UI.Packs and UI.Packs.OwnGuidesOff() then
		-- Polestar Guides installed but unticked in the AddOns list: one
		-- click turns it on (with its parts) and reloads.
		empty.Title:SetText(L["Polestar Guides is turned off"])
		empty.Text:SetText(L["It is installed but unticked in the game's AddOns list, so Polestar has no guides to show."])
		W.SetButtonText(empty.Primary, L["Turn on Polestar Guides and reload"])
		empty.Primary:SetWidth(math.max(168, math.floor(empty.Primary.Label:GetStringWidth() + 32.5)))
		empty.Primary.psAction = function() UI.Packs.TurnOnOwnGuides() end
		empty.Primary:Show()
	elseif kind == "noguides" and UI.Packs and UI.Packs.AnySwitchedOff() then
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
		local id = E and E.StartingGuide and E.StartingGuide() or (G and G.Suggest and G.Suggest())
		local suggested = id and G.Get(id)
		empty.Title:SetText(L["No guide open"])
		if suggested then
			empty.Text:SetText(L["Suggested for you"] .. ": |c" .. Theme.Hex("text") .. suggested.title .. "|r")
			W.SetButtonText(empty.Primary, L["Start guide"])
			empty.Primary.psAction = function()
				if E and E.StartGuide then E.StartGuide() elseif E and E.OpenTab then E.OpenTab(id) elseif E and E.SetGuide then E.SetGuide(id) end
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
			lines[#lines + 1] = string.format(L["Finish %s first: the guide picks up by itself then."], ns.Quoted(gate.preTitle) or "")
		end
		empty.Text:SetText(table.concat(lines, "\n"))
		W.SetButtonText(empty.Primary, L["Choose a guide"])
		empty.Primary.psAction = function() UI.ShowPicker() end
		empty.Primary:Show()
	elseif kind == "away" then
		-- Another race's starting zone the player has not reached
		-- (Engine.AwayStart): Polestar does not lead them there; the guide
		-- picks up when they arrive. Its class steps are the guide race's
		-- classes', so the trainer may be elsewhere.
		glyph = "icon-goto"
		local guide = E and E.GetGuide and E.GetGuide()
		local away = guide and E.AwayStart and E.AwayStart(guide.id) or {}
		local zone = (away.zone and UI.MapName(away.zone)) or away.zoneName or ""
		empty.Title:SetText(L["Another race's starting zone"])
		empty.Text:SetText(string.format(L["This is the %s starting zone. Polestar won't guide you there: make your own way to %s, and the guide picks up when you arrive."],
			UI.RaceList(away.races) or "", zone) .. "\n" .. L["Your class trainer may be elsewhere (check your capital)."])
		W.SetButtonText(empty.Primary, L["Choose a guide"])
		empty.Primary.psAction = function() UI.ShowPicker() end
		empty.Primary:Show()
	elseif kind == "skippedout" then
		-- The player's skip of a step left every later one without its
		-- quest (Engine.SkippedOut): the guide is not done; the undo brings
		-- the step back, and taking its quests by hand brings the rest.
		glyph = "skip"
		local out = E and E.SkippedOut and E.SkippedOut() or {}
		empty.Title:SetText(L["The rest of this guide follows from a skipped step"])
		empty.Text:SetText(string.format(L["You skipped %s, and the steps after it need its quests. Undo the skip to carry on, or do that step yourself: the guide picks up from there."],
			"|c" .. Theme.Hex("text") .. (out.title or "") .. "|r"))
		W.SetButtonText(empty.Primary, L["Undo the skip"])
		empty.Primary.psAction = function()
			if out.step and E.Unskip then E.Unskip(out.step) end
		end
		empty.Primary:Show()
		W.SetButtonText(empty.Secondary, L["Choose a guide"])
		empty.Secondary.psAction = function() UI.ShowPicker() end
		empty.Secondary:Show()
	elseif kind == "complete" then
		glyph, color = "check", "success"
		local guide = E and E.GetGuide and E.GetGuide()
		-- Where the hand-off goes now: the remembered or only option offered (an
		-- option with `when` only while it holds), nil with none.
		local nextId = guide and (E.NextGuide and E.NextGuide(guide.id) or not E.NextGuide and guide.next)
		local nextGuide = nextId and G and G.Get and G.Get(nextId)
		local choiceFrom = guide and E.PendingRouteChoice and E.PendingRouteChoice()
		local afterRun = not choiceFrom and pickupKey(guide)
		-- A class guide opened from the class quest heads-up (UI/ClassToast.lua)
		-- in a tab of its own: close it and go back to the guide it came from.
		local back = guide and not choiceFrom and not afterRun and GF.ClassReturn(guide.id)
		empty.Title:SetText(L["Guide complete"])
		if back then
			empty.Text:SetText(string.format(L["Your class quest is done. Back to %s."], "|c" .. Theme.Hex("text") .. back.title .. "|r"))
			W.SetButtonText(empty.Primary, L["Close and return"])
			empty.Primary.psAction = function() GF.CloseAndReturn(guide.id) end
			empty.Primary:Show()
			W.SetButtonText(empty.Secondary, L["Browse guides"])
			empty.Secondary.psAction = function() UI.ShowPicker() end
			empty.Secondary:Show()
		elseif choiceFrom then
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
	b:SetShown(shown and GF.On("skipButton") and true or false)
	if enabled then b:Enable() else b:Disable() end
	local a = enabled and 1 or 0.35
	W.Color(b.Icon, "textDim", a)
	W.Color(b.Label, "textDim", a)
end

-- Skip sits left of the Nearby services button, or of the bug when that
-- button is off (nav.nearbyButton).
local function anchorSkip()
	nav.Skip:ClearAllPoints()
	nav.Skip:SetPoint("RIGHT", (nav.Nearby:IsShown() and nav.Nearby) or (nav.Report:IsShown() and nav.Report) or nav.Menu, "LEFT", -2, 0)
end

local function navigatorFor(guide, index)
	local count = guide and UI.StepTotal() or 0
	if guide then
		-- While the catch-up shows the guides passed whole, the count and title
		-- are its (GF.PlayCatchUp). The numbers leave out the steps hidden
		-- from the character (UI.StepNo, #942).
		if GF.catchingUp ~= "guides" then
			nav.Steps.Count:SetText(string.format("%d / %d", index and UI.StepNo(index) or count, count))
			nav.Title:SetText(guide.title or guide.id)
		end
		nav.psMeta = UI.GuideMeta(guide)
	else
		nav.Steps.Count:SetText("")
		nav.Title:SetText(L["Polestar"])
		nav.psMeta = nil
	end
	W.SetIconState(nav.Prev, false, guide ~= nil)
	W.SetIconState(nav.Next, false, guide ~= nil and index ~= nil)
	GF.PaintSkip(guide ~= nil, guide ~= nil and index ~= nil)
	nav.Report:SetShown(guide ~= nil and GF.On("reportButton"))
	nav.Nearby:ClearAllPoints()
	nav.Nearby:SetPoint("RIGHT", nav.Report:IsShown() and nav.Report or nav.Lookup, "LEFT", 0, 0)
	anchorSkip()
	-- No guide: no steps to walk; the navigator names the addon instead.
	nav.Steps:SetShown(guide ~= nil and GF.On("stepCount"))
	nav.Title:ClearAllPoints()
	if guide and nav.Steps:IsShown() then
		nav.Title:SetPoint("LEFT", nav.Steps, "RIGHT", 8, 0)
	else
		nav.Title:SetPoint("LEFT", nav, "LEFT", PAD, 0)
	end
	if GF.catchingUp == "guides" then return end
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
		if v and v.status ~= "na" and not v.along and not UI.StepHidden(i) then
			n = n + 1
			local r = upRow(n)
			r.psIndex = i
			r.psSummary = UI.StepSummary(v)
			-- It turns in a quest still open, pinned (#644), ticked by hand (#1135) or worked along the way (#853): warning colour, and says so.
			local warn = false
			for _, gv in ipairs(v.goals) do
				if gv.pinOpen then warn = warn == true or gv.pinOpen end
			end
			if warn then r.psSummary = r.psSummary .. " (" .. (warn == true and L["pinned, still open"] or L["still open"]) .. ")" end
			r.Num:SetText(UI.StepNo(i))
			r.Icon:SetTexture(Theme.VerbIcon(UI.FirstVerb(v)))
			r.Text:SetText(r.psSummary)
			W.Color(r.Text, warn and "warning" or "textDim")
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
		-- An along step never holds the route: "Then:" names the next step that does.
		if v and v.status ~= "na" and not v.along and not UI.StepHidden(s) then
			local gs, f = UI.StepGroups(v)
			local g = gs[f or 1] or gs[1]
			if g then return UI.GroupName(v, g), g.kind end
			return nil
		end
	end
	return nil
end

-- A goal's identities for Along the way: its quest objective, and its verb
-- with its mob, item or object for that quest. -> key, key (either nil)
local function alongKeys(g)
	local a = g.quest and g.oi and ("q" .. g.quest .. ":" .. g.oi) or nil
	local id = g.npc or g.item or g.object
	local b = id and ((g.t or "") .. ":" .. id .. ":" .. (g.quest or "")) or nil
	return a, b
end

-- The open goals of along steps behind the live step (Engine.GetAlong), up to
-- ALONG_MAX rows, hidden in the compact window. A goal the step on screen
-- lists itself (the same quest objective, or the same kill or item for the
-- same quest) is not said twice. When every row is of `along until` steps
-- ending at one step, the heading says so: "Along the way, until step 30"
-- (#942: an along step has no card of its own).
local function fillAlong(E)
	for i = 1, #alongRows do alongRows[i]:Hide() end
	if compact() or not E.GetAlong then
		along:Hide()
		return
	end
	local inStep = {}
	for _, g in ipairs(view and view.goals or {}) do
		if g.status ~= "na" then
			local a, b = alongKeys(g)
			if a then inStep[a] = true end
			if b then inStep[b] = true end
		end
	end
	local n, untilStep, mixed = 0, nil, false
	-- First the quests an update left behind the player (Engine.GetBehind):
	-- "Still to do: <quest>, back in <zone>, 240 yd".
	local back = 0
	for _, b in ipairs(E.GetBehind and E.GetBehind() or {}) do
		if n < ALONG_MAX then
			n, back = n + 1, back + 1
			local r = alongRow(n)
			local where = b.zone and (b.yards and string.format(L["back in %s, %s"], b.zone, ns.FormatDistance(b.yards)) or string.format(L["back in %s"], b.zone)) or nil
			local quest = ns.Quoted(b.title or (L["Quest"] .. " " .. b.quest))
			r.psStep, r.psGoal, r.psTitle, r.psPin, r.psBehind = nil, nil, b.title, nil, b.quest
			r.psPlace = true
			r.Icon:SetTexture(Theme.VerbIcon("turnin"))
			r.Text:SetText(where and string.format(L["Still to do: %s, %s"], quest, where) or string.format(L["Still to do: %s"], quest))
			r:Show()
		end
	end
	for _, s in ipairs(E.GetAlong()) do
		for _, gv in ipairs(s.goals) do
			local a, b = alongKeys(gv)
			if n < ALONG_MAX and not ((a and inStep[a]) or (b and inStep[b])) then
				n = n + 1
				if not s.untilStep or (untilStep and untilStep ~= s.untilStep) then mixed = true end
				untilStep = untilStep or s.untilStep
				local r = alongRow(n)
				r.psStep, r.psGoal, r.psTitle, r.psPin, r.psBehind = gv.step or s.index, gv.index, s.title or UI.GoalLine(gv), s.pin, nil
				r.psPlace = gv.map and gv.x and gv.y and true or nil
				r.Icon:SetTexture(Theme.VerbIcon(gv.t))
				UI.SetCounted(r.Text, UI.GoalLine(gv))
				r:Show()
			end
		end
	end
	along.Label:SetText(back == n and L["Still to do"] or (untilStep and not mixed) and string.format(L["Along the way, until step %d"], UI.StepNo(untilStep)) or L["Along the way"])
	along:SetShown(n > 0)
end

-- "Then: Gazrog": the next step's first person, once this step has no one
-- else open (its summary lines name the persons still to come). With "Show
-- the whole step" it names the next person of this step too, and "Person 2
-- of 8" counts them.
local function fillAfter(E, index, groups, focus)
	if compact() then
		after:Hide()
		return
	end
	local whole = wholeStep() or not focus
	if not whole then
		for gi = focus + 1, #groups do
			if not groups[gi].done then
				after:Hide()
				return
			end
		end
	end
	local persons, at = 0, nil
	for gi, g in ipairs(groups) do
		if g.kind ~= "here" then
			persons = persons + 1
			if gi == focus then at = persons end
		end
	end
	if not whole then at = nil end
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

-- The rows the card lists: every goal of the step in written order, the
-- focus person's and everyone else's, done, skipped (with its reason) or
-- open, never one that does not apply or is folded into another. A hub step
-- reads person by person in the header, the arrow and "Then:", but a quest
-- taken, handed in or not offered stays on the card when the focus moves to
-- the next person (#741, #739: such a row vanished with its person, which read
-- as the guide ticking or losing it). The focus's own "Go to" header stays
-- folded into the header (shownGoals).
-- -> rows (goal views), the hidden header goal
local function cardGoals(v, groups, focus)
	local _, header = shownGoals(v, shownGroup(v, groups, focus))
	-- A class quest's accept reads inside the class card (UI/ClassCard.lua).
	local CC, E = UI.ClassCard, Engine()
	local fold = CC and E and E.GetGuide and CC.Fold(E.GetGuide(), v)
	local list = {}
	for gi, goal in ipairs(v.goals) do
		if goal.status ~= "na" and not goal.folded and gi ~= fold and not (header and header.index == gi) then
			list[#list + 1] = UI.ReadingGoal(v, goal)
		end
	end
	return list, header
end

-- The name a row of another person's goal carries (the focus's are under
-- the header already), in the NPC's or object's colour; nil for field work.
local function rowWho(goal, groups, focus)
	local grp = focus and goal.group ~= focus and groups[goal.group]
	if not grp or not grp.name or grp.name == "" or (grp.kind ~= "npc" and grp.kind ~= "object") then return nil end
	return "|c" .. Theme.Hex(grp.kind) .. grp.name .. "|r"
end

-- What a summary line says for a group's open goals, by kind in the order
-- they first come: "1 hand-in, 2 quests" at a person; out here "7 kills and
-- items", "3 kills", "2 items" or "4 goals" (a "Go to" counts only when
-- nothing else is open). nil when none is open.
local function countsOf(list, here)
	if here then
		local kills, items, other, gotos = 0, 0, 0, 0
		for _, g in ipairs(list) do
			if g.status ~= "done" and g.status ~= "skipped" then
				if g.t == "kill" then
					kills = kills + 1
				elseif g.t == "collect" then
					items = items + 1
				elseif g.t == "goto" then
					gotos = gotos + 1
				else
					other = other + 1
				end
			end
		end
		local all = kills + items + other
		if all == 0 then all = gotos end
		if all == 0 then return nil end
		if other > 0 or kills + items == 0 then return all == 1 and L["1 goal"] or string.format(L["%d goals"], all) end
		if items == 0 then return kills == 1 and L["1 kill"] or string.format(L["%d kills"], kills) end
		if kills == 0 then return items == 1 and L["1 item"] or string.format(L["%d items"], items) end
		return string.format(L["%d kills and items"], all)
	end
	local n, kinds = { quest = 0, handin = 0, task = 0 }, {}
	for _, g in ipairs(list) do
		if g.status ~= "done" and g.status ~= "skipped" then
			local k = (g.t == "accept" and "quest") or (g.t == "turnin" and "handin") or "task"
			if n[k] == 0 then kinds[#kinds + 1] = k end
			n[k] = n[k] + 1
		end
	end
	if #kinds == 0 then return nil end
	for i, k in ipairs(kinds) do
		local c = n[k]
		if k == "quest" then
			kinds[i] = c == 1 and L["1 quest"] or string.format(L["%d quests"], c)
		elseif k == "handin" then
			kinds[i] = c == 1 and L["1 hand-in"] or string.format(L["%d hand-ins"], c)
		else
			kinds[i] = c == 1 and L["1 task"] or string.format(L["%d tasks"], c)
		end
	end
	return table.concat(kinds, ", ")
end

-- Paint a summary line: `icon` a verb glyph or "check"; `list` the goals
-- its tooltip names; `open` whether its goals are listed under it.
local function paintLine(l, key, icon, iconColor, text, list, title, open)
	l.psKey, l.psGoals, l.psTitle = key, list, title
	l.Icon:SetTexture(icon == "check" and Theme.Media("check") or Theme.VerbIcon(icon))
	W.Color(l.Icon, iconColor)
	l.Text:SetText(text)
	if l ~= fold.glow then W.Color(l.Text, "textDim") end
	l.Chevron:SetTexture(Theme.Media(open and "chevron-up" or "chevron-down"))
	l.psK = nil
	l:SetAlpha(1)
	l:Show()
end

local DOT = "  \194\183  "

-- A level as the window shows the character's: whole, or cut (not rounded)
-- to one place, so 19.96 still reads 19.9.
function GF.LevelText(v)
	if v % 1 == 0 then return string.format("%d", v) end
	return string.format("%.1f", floor(v * 10) / 10)
end

-- Fill the card from `view`: the focus group's header, its goals under
-- "✓ N done", a summary line for every other person of the step, the tip
-- (with "Show the whole step", or on a done step, every goal as written).
-- sameFocus = repaint in place; a goal that just turned done pops and folds.
local function fillCard(sameFocus)
	local groups, focus = UI.StepGroups(view)
	local g = shownGroup(view, groups, focus)
	focusGroup = g
	if not sameFocus then resetModel() end
	local _, header = shownGoals(view, g)
	person.psHeaderGoal = header
	paintPerson(g)
	-- Under the header: why a step that depends on what the player does
	-- holds nothing for them now (the Engine's `why`, #942).
	local why = view.why
	person.Why:SetText(why or "")
	person.Why:SetShown(why ~= nil)
	-- Work on the step for a quest 3 or more levels above the character
	-- (Levels.StepHint; never an accept): "Level 25 quest: you're 19.7", in a
	-- calm colour (Fitz, 0.3.6: players read red as being behind).
	local Lv = ns.Levels
	local hint = Lv and Lv.StepHint and Lv.StepHint(view.index)
	if hint then
		person.Level:SetText(string.format(L["Level %d quest: you're %s"], hint.level, GF.LevelText(hint.you)))
		W.Color(person.Level, "textDim")
	end
	person.Level:SetShown(hint ~= nil)
	-- A profession guide's section: its skill range as the heading over the
	-- step ("First Aid 1-40"), in the accent colour while the player's skill
	-- is in it (Engine.GetSection).
	local sv = view.section
	card.Section:SetText(sv and sv.title or "")
	if sv then W.Color(card.Section, sv.state == "current" and "accent" or "textDim") end
	card.Section:SetShown(sv ~= nil)
	person:Show()
	-- A class quest's step: the class card, its colour on the step's quest names.
	local CC, E = UI.ClassCard, Engine()
	local guide = E and E.GetGuide and E.GetGuide()
	local step = guide and guide.steps and guide.steps[view.index]
	local classHex = CC and CC.Fill(guide, view.index, view) or nil
	-- A class quest's accept reads inside the class card (UI/ClassCard.lua).
	local classFold = CC and guide and CC.Fold(guide, view)
	local t = targetOf()
	local n, m = 0, 0
	area.n = 0
	-- A group line ("Dungeon: Dire Maul") reads once, on the first open
	-- goal that carries it, not under every goal of the same run.
	local partySaid = {}
	local missingSaid = {} -- quest -> a row already names who lacks it
	local escortSaid = false -- a row already says the escort line
	local finderSaid = false -- and the group finder line
	-- The current goal (the Engine's `current`: the first open blocking goal
	-- of the focus, else its first open optional one) takes the accent; it
	-- is the goal the arrow leads to. The header stands for its "Go to".
	-- `rec`: the goal's fold, while it folds.
	local function addRow(goal, who, aside, rec)
		n = n + 1
		local r = goalRow(n)
		local last = model.last[goal.index]
		local pop = (rec and rec.pop) or (not rec and sameFocus and goal.status == "done" and last ~= nil and last ~= "done")
		if rec then rec.pop = nil end
		local isCurrent = view.current ~= nil and goal.index == view.current and goal.status == "active"
		local party = UI.GroupLine(goal)
		local escort = UI.EscortLine(goal) ~= nil
		local finder = UI.FinderLine(goal) ~= nil
		local raw = classHex and step and step.goals[goal.index]
		local hex = raw and CC.Colours(raw) and classHex or nil
		paintRow(r, goal, pop and true or false, sameFocus, isCurrent, party and partySaid[party], goal.quest and missingSaid[goal.quest], escort and escortSaid, who, aside, hex, finder and finderSaid)
		if party then partySaid[party] = true end
		if escort then escortSaid = true end
		if finder then finderSaid = true end
		if goal.quest and goal.oi and goal.status ~= "skipped" then missingSaid[goal.quest] = true end
		r.Mark:SetShown(goal.status ~= "done" and goal.status ~= "skipped" and isTarget(goal, t) and not person.Mark:IsShown())
		r.psFold = rec
		if rec then
			rec.row = r
			r.psK = rec.k
			r:SetAlpha(rec.a or 1)
		else
			r.psK = nil
			r:SetAlpha(1)
		end
		r:Show()
		area.n = area.n + 1
		area.items[area.n], r.psAt = r, area.n
	end
	local function addLine(key, icon, iconColor, text, list, title, open)
		m = m + 1
		local l = cardLine(m)
		paintLine(l, key, icon, iconColor, text, list, title, open)
		area.n = area.n + 1
		area.items[area.n], l.psAt = l, area.n
		return l
	end
	-- A group's rows as painted (shownGoals), the class card's accept left out.
	local function goalsOf(grp)
		local list = shownGoals(view, grp)
		if classFold then
			for i = #list, 1, -1 do
				if list[i].index == classFold then table.remove(list, i) end
			end
		end
		return list
	end
	local function nameHex(grp)
		return Theme.Hex((grp.kind == "npc" or grp.kind == "object") and grp.kind or "text")
	end
	-- Who a group is done with, so one person reads on one summary line even
	-- when another person's goal splits their goals (Thundris Windweaver, a
	-- vendor, Thundris again); nil for field work, which never merges.
	local function personOf(grp)
		if grp.kind == "npc" and grp.npc then return "npc:" .. grp.npc end
		if grp.kind == "object" and grp.object then return "object:" .. grp.object end
		return nil
	end
	fold.grow = nil
	if wholeStep() or not focus then
		-- Every goal of the step in written order, the other persons' named
		-- on their rows and stepped back while open.
		for _, goal in ipairs(cardGoals(view, groups, focus)) do
			addRow(goal, rowWho(goal, groups, focus), focus ~= nil and goal.group ~= focus)
		end
	else
		-- The focus person's other groups on the same visit (Thundris
		-- Windweaver, a vendor, Thundris again: only persons between, no
		-- field work) read with the focus, in written order: the player is in
		-- front of them now (#942). Every other person after the focus, in the
		-- order they first come: all their groups share one entry, read as
		-- one summary line below.
		local me, mine = personOf(g), {}
		if me then
			for gi = focus + 1, #groups do
				local who = personOf(groups[gi])
				if not who then break end
				if who == me then mine[gi] = true end
			end
			for gi = focus - 1, 1, -1 do
				local who = personOf(groups[gi])
				if not who then break end
				if who == me then mine[gi] = true end
			end
		end
		local mineBefore, mineAfter = {}, {}
		local later, laterOf = {}, {}
		for gi = focus + 1, #groups do
			local grp = groups[gi]
			local list2 = goalsOf(grp)
			if #list2 > 0 then
				local who = personOf(grp)
				local e = who and laterOf[who]
				if mine[gi] then
					for _, goal in ipairs(list2) do mineAfter[#mineAfter + 1] = goal end
				elseif e then
					for _, goal in ipairs(list2) do e.list[#e.list + 1] = goal end
				else
					e = { gi = gi, list = list2, prev = groups[gi - 1].kind }
					later[#later + 1] = e
					if who then laterOf[who] = e end
				end
			end
		end
		-- The persons done before the focus: one line naming them. A person
		-- still to come after the focus reads on their own line instead, with
		-- these goals first; the focus person's read with the focus.
		local before, names, named, early = {}, {}, {}, {}
		for gi = 1, focus - 1 do
			local grp = groups[gi]
			local list = goalsOf(grp)
			local who = personOf(grp)
			local e = who and laterOf[who]
			if #list > 0 and mine[gi] then
				for _, goal in ipairs(list) do mineBefore[#mineBefore + 1] = goal end
			elseif #list > 0 and e then
				local into = early[e]
				if not into then
					into = {}
					early[e] = into
				end
				for _, goal in ipairs(list) do into[#into + 1] = goal end
			elseif #list > 0 then
				for _, goal in ipairs(list) do before[#before + 1] = goal end
				if not (who and named[who]) then
					names[#names + 1] = "|c" .. nameHex(grp) .. UI.GroupName(view, grp) .. "|r"
					if who then named[who] = true end
				end
			end
		end
		for e, into in pairs(early) do
			for _, goal in ipairs(e.list) do into[#into + 1] = goal end
			e.list = into
		end
		if #before > 0 then
			addLine("before", "check", "success", table.concat(names, ", "), before, L["Done"], model.open.before)
			if model.open.before then
				for _, goal in ipairs(before) do addRow(goal, rowWho(goal, groups, focus), true) end
			end
		end
		-- The focus: its finished goals folded into "✓ N done", the rest as rows.
		fold.serial = fold.serial + 1
		local list = mineBefore
		for _, goal in ipairs(goalsOf(g)) do list[#list + 1] = goal end
		for _, goal in ipairs(mineAfter) do list[#list + 1] = goal end
		local kept, doneList, first = {}, {}, nil
		for i, goal in ipairs(list) do
			local gi = goal.index
			local rec = fold.of[gi]
			if goal.status == "done" then
				if not rec and not model.folded[gi] then
					local last = model.last[gi]
					if sameFocus and last and last ~= "done" then
						rec = fold.start(gi)
					else
						model.folded[gi] = true
					end
				end
				if rec then
					rec.seen = fold.serial
					if not first or rec.at < first.at then first = rec end
				else
					doneList[#doneList + 1] = goal
				end
				kept[i] = rec or false
			else
				model.folded[gi] = nil
				if rec then fold.drop(rec) end
				kept[i] = true
			end
		end
		for i = fold.n, 1, -1 do
			if fold.list[i].seen ~= fold.serial then fold.drop(fold.list[i]) end
		end
		local done = #doneList
		if done > 0 or first then
			local l = addLine("done", "check", "success", string.format(L["%d done"], max(done, 1)), doneList, L["Done"], model.doneOpen)
			for i = 1, fold.n do fold.list[i].grow = nil end
			if done == 0 then
				-- The first goal to fold: the line grows in as its row shuts.
				fold.grow = l
				first.grow = true
				local k = first.k or 1
				l.psK = 1 - k
				l:SetAlpha(1 - k)
			elseif sameFocus and done > model.doneN and not Anim.Reduced() then
				fold.glow, fold.glowAt = l, GetTime()
				W.Color(l.Text, "accent")
				fold.run()
			end
		end
		model.doneN = done
		for i, goal in ipairs(list) do
			local k = kept[i]
			if k == true then
				addRow(goal, nil, false)
			elseif k then
				addRow(goal, nil, false, k)
			elseif model.doneOpen then
				addRow(goal, nil, false)
			end
		end
		-- Every person after the focus: one line, their goals in place once
		-- opened. Past CARD.ahead lines the rest share one "+ N more people"
		-- line, which opens them in place.
		local shown = #later > CARD.ahead + 1 and CARD.ahead or #later
		-- One or two goals left: the line names them ("Accept Bitter Rivals",
		-- the quest in its colour, a "Go to" only when nothing else is open);
		-- three or more: counts. The line wraps to two lines, then ends in "…".
		-- Opened, it is only the person or "Then out here": its goals are the
		-- rows right under it.
		local function namesOf(list2)
			local open, places = {}, {}
			for _, goal in ipairs(list2) do
				if goal.status ~= "done" and goal.status ~= "skipped" then
					local into = goal.t == "goto" and places or open
					into[#into + 1] = goal
				end
			end
			if #open == 0 then open = places end
			if #open == 0 or #open > 2 then return nil end
			local said = UI.GoalText(open[1])
			if open[2] then said = said .. ", " .. UI.GoalText(open[2]) end
			return said
		end
		local function groupLine(e)
			local gi, grp, list2 = e.gi, groups[e.gi], e.list
			local open = model.open[gi]
			local here = grp.kind ~= "npc" and grp.kind ~= "object"
			local counts = countsOf(list2, here)
			local said = counts and namesOf(list2)
			local name = UI.GroupName(view, grp)
			local muted = Theme.Hex("textMuted")
			if counts and here then
				local prev = e.prev == "npc" or e.prev == "object"
				local label = open and (prev and L["Then out here"] or L["Out here"])
					or ((prev and L["Then out here:"] or L["Out here:"]) .. " " .. (said or counts))
				addLine(gi, "goto", "textDim", label, list2, name, open)
			elseif counts then
				local tail = said and ("|c" .. muted .. DOT .. "|r" .. said) or ("|c" .. muted .. DOT .. counts .. "|r")
				addLine(gi, GROUP_VERB[grp.kind], "textDim", L["Then:"] .. " |c" .. nameHex(grp) .. name .. "|r" .. (open and "" or tail), list2, name, open)
			else
				addLine(gi, "check", "success", "|c" .. nameHex(grp) .. name .. "|r", list2, name, open)
			end
			if open then
				for _, goal in ipairs(list2) do addRow(goal, nil, true) end
			end
		end
		for i = 1, shown do groupLine(later[i]) end
		if shown < #later then
			local rest = {}
			for i = shown + 1, #later do
				for _, goal in ipairs(later[i].list) do rest[#rest + 1] = goal end
			end
			local counts = countsOf(rest, false)
			local text = string.format(L["+ %d more people"], #later - shown)
			if counts then text = text .. "|c" .. Theme.Hex("textMuted") .. DOT .. counts .. "|r" end
			addLine("more", "talk", "textDim", text, rest, L["Later in this step"], model.open.more)
			if model.open.more then
				for i = shown + 1, #later do groupLine(later[i]) end
			end
		end
	end
	for gi, goal in ipairs(view.goals) do model.last[gi] = goal.status end
	for i = n + 1, #rows do
		local r = rows[i]
		r:Hide()
		r.psGoal, r.psStatus, r.psFold, r.psK = nil, nil, nil, nil
	end
	for i = m + 1, #lines do lines[i]:Hide() end
	local i = area.n + 1
	while area.items[i] do
		area.items[i] = nil
		i = i + 1
	end
	local shown = ns.Get("ui.showNotes") and not compact()
	local note = shown and view.note or nil
	if note == "" then note = nil end
	-- The step's picture (a file in its pack's addon folder, Guides.lua): one
	-- the client cannot load leaves the tip as it was without one.
	local pic = shown and view.image and view.image.texture and view.image or nil
	if pic and not card.Tip.Image:SetTexture(pic.texture) then pic = nil end
	if not pic then card.Tip.Image:SetTexture(nil) end
	card.Tip.psImage = pic
	card.Tip.Text:SetText(note or (pic and L["Picture of this spot"]) or "")
	card.Tip:SetShown(note ~= nil or pic ~= nil)
	W.SetIcon(card.Tip.Toggle, tipOpen and "chevron-up" or "chevron-down")
	return groups, focus
end

local function showSteps(show)
	card:SetShown(show)
	after:SetShown(show and after:IsShown())
	along:SetShown(show and along:IsShown())
	GF.here:SetShown(show and GF.here:IsShown())
	upnext:SetShown(show and upnext:IsShown())
	empty:SetShown(not show)
end

local function render()
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
	local index = GF.catchUpIndex or (E.GetStepIndex and E.GetStepIndex())
	navigatorFor(guide, index)
	-- The undo goes once the step is no longer skipped (undone elsewhere).
	local k = GF.notices.stepSkip
	if k and k.guideId == guide.id then
		local sv = E.GetStepView(k.step)
		if not (sv and sv.skipped) then GF.notices.stepSkip = nil end
	end
	local v = index and E.GetStepView(index)
	if not v then
		view, shownIndex, shownGuide, shownFocus = nil, nil, guide.id, nil
		-- No live step only because a step skip left the rest out (#1372):
		-- not "Guide complete", but the skip and its undo.
		setEmpty(E.SkippedOut and E.SkippedOut() and "skippedout" or "complete")
		showSteps(false)
		GF.Layout()
		GF.PaintProgress(true)
		return
	end
	-- A Class guide the character cannot start yet, or another race's
	-- starting zone the player has not reached: its notice on the live step;
	-- Next still looks at the steps ahead.
	local live = index == (E.GetLiveStep and E.GetLiveStep())
	local notice = live and ((E.StartGate and E.StartGate(guide.id) and "notyet") or (E.AwayStart and E.AwayStart(guide.id) and "away"))
	if notice then
		view, shownIndex, shownGuide, shownFocus = nil, nil, guide.id, nil
		setEmpty(notice)
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
	fillAlong(E)
	GF.FillHere(E)
	fillUpcoming(E, index)
	showSteps(true)
	GF.Layout()
	followCurrent(focusChanged)
	GF.PaintProgress(shownGuide == guide.id)
	if focusChanged and F:IsVisible() and not GF.catchingUp and GF.On("stepAnim") then
		-- The next person (or step) slides up 6px into place as it fades in
		-- (guideWindow.stepAnim, at guideWindow.animSpeed).
		Anim.To(card, "alpha", 0, 1, GF.Dur(Anim.BASE), "out")
		Anim.To(card, "offset", -6, 0, GF.Dur(Anim.BASE), "out")
	end
	-- A class chain's card, the first time it shows: its shine and chime.
	if F:IsVisible() and not GF.catchingUp and UI.ClassCard then UI.ClassCard.Celebrate() end
	shownIndex, shownGuide, shownFocus = index, guide.id, focus
end

-- Render, then a skin's own (Skin API 2, hooks.guideRender(view, parts)):
-- the step on screen, nil when there is none.
function GF.Render()
	render()
	if F then Theme.SkinHook("guideRender", state == "steps" and view or nil, Theme.GuideParts()) end
end

-- The step the window shows (the catch-up's while it goes over the steps).
function GF.ShownStep() return shownIndex end

-- STEP_UPDATED: same step, new goal status/progress. When the focus moved
-- to the next person this re-renders (with the slide); otherwise the card is
-- refilled in place (a goal turning done folds).
function GF.Update()
	if not F or state ~= "steps" or not view then return GF.Render() end
	local E = Engine()
	local index = E.GetStepIndex and E.GetStepIndex()
	if index ~= shownIndex then return GF.Render() end
	local v = E.GetStepView(index)
	if not v then return GF.Render() end
	local groups, focus = UI.StepGroups(v)
	if focus ~= shownFocus then return GF.Render() end
	view = v
	fillCard(true)
	fillAfter(E, index, groups, focus)
	fillAlong(E)
	GF.FillHere(E)
	GF.Layout()
	GF.PaintProgress(true)
	followCurrent(false)
end

-- The card again from the view it shows: a summary line opened or closed,
-- a fold that landed.
function GF.Refill()
	if not F or state ~= "steps" or not view then return end
	fillCard(true)
	GF.Layout()
	followCurrent(false)
end

-- QUEST_TIMER (Quests/Timed.lua, each second a quest's timer runs): the
-- countdowns on the card and the While-here lines move. Only while shown.
function GF.TimerTick()
	if not F or state ~= "steps" or not view or not F:IsVisible() then return end
	fillCard(true)
	GF.FillHere(Engine())
	GF.Layout()
	followCurrent(false)
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

-- The window's sizes as the skin and the player's settings make them now,
-- for the settings window's preview (UI/Looks/GuideWindow.lua), which lays
-- out its step card by the same numbers.
function GF.Metrics()
	readMetrics()
	return { pad = PAD, tabH = TAB_H, navH = NAV_H, progH = PROG_H, icon = ICON, textX = TEXT_X, rowMin = ROW_MIN,
		check = CHECK, rowPad = ROW_PAD, checkIn = CHECK_IN, upRow = UP_ROW, upToggle = UP_TOGGLE, glyphY = GF.GlyphY(), lineH = CARD.lineH }
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
	frame:SetScript("OnDragStart", GF.DragStart)
	frame:SetScript("OnDragStop", GF.DragStop)
	return hoverable(frame)
end

local function build()
	readMetrics()
	handOver()
	F = CreateFrame("Frame", "PolestarGuideFrame", ns.UIParent)
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
	-- The transparent style's backing (GF.PaintVeil, placed by placeBars):
	-- under the body, and under the tabs and navigator, fading with them.
	GF.veil = Theme.Scrim(F, GF.VEIL_FEATHER)
	band.Veil = Theme.Scrim(F, GF.VEIL_FEATHER)
	GF.veil:Hide()
	band.Veil:Hide()
	chrome[#chrome + 1] = band.Veil

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
	-- The Forever skin positions its border below the tab strip; expose the strip.
	F.psStrip = strip

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
	-- Hearth's mantel: the lit band under the tabs (sky to skyBottom) the
	-- navigator stands on, edged below by nav.Rule in the copper titleLine.
	nav.TitleBar = nav:CreateTexture(nil, "BACKGROUND", nil, -4)
	nav.TitleBar:SetTexture(Theme.Media("white"))
	nav.TitleBar:SetPoint("TOPLEFT", nav, "TOPLEFT", 0, 0)
	nav.TitleBar:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 0, 1)
	W.Painter(nav.TitleBar, function(t)
		local top, bottom = { Theme.Color("sky") }, { Theme.Color("skyBottom") }
		if t.SetGradient and CreateColor then
			t:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], 1), CreateColor(top[1], top[2], top[3], 1))
		else
			t:SetVertexColor(top[1], top[2], top[3], 1)
		end
	end)
	nav.TitleBar:Hide()
	-- A skin's close square at the title bar's right (the guideTitle hook shows it).
	nav.Close = CreateFrame("Button", nil, nav)
	nav.Close:SetSize(18, 18)
	nav.Close:SetPoint("RIGHT", nav, "RIGHT", -5, 0)
	W.Fill(nav.Close, "closeFill", "BACKGROUND", -3)
	local closeGlyph = W.Tex(nav.Close, "ARTWORK", "close", "closeGlyph")
	closeGlyph:SetSize(10, 10)
	closeGlyph:SetPoint("CENTER", nav.Close, "CENTER", 0, 0)
	W.Painter(nav.Close, function(b) Theme.Border(b, Theme.Color("closeEdge")) end)
	nav.Close:SetScript("OnEnter", function(self) W.Tooltip(self, tooltipAnchor(), L["Hide window"]) end)
	nav.Close:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
	nav.Close:SetScript("OnClick", function()
		ns.Set("ui.shown", false)
		ns.Print(L["Guide window hidden. Type /polestar to bring it back."])
	end)
	nav.Close:Hide()
	nav.Steps = CreateFrame("Frame", nil, nav)
	nav.Steps:SetSize(100, 24)
	nav.Steps:SetPoint("LEFT", nav, "LEFT", PAD - 6, 0)
	nav.Prev = W.IconButton(nav.Steps, "chevron-left", 24, L["Previous step"], function()
		local E = Engine()
		if E and E.Prev then E.Prev() end
	end)
	nav.Prev.psTipLines = { L["A look back: nothing changes."] }
	nav.Prev:SetPoint("LEFT", nav.Steps, "LEFT", 0, 0)
	nav.Steps.Count = GF.SizeAs(T(nav.Steps, "number", "text"), "bar")
	nav.Steps.Count:SetJustifyH("CENTER")
	nav.Steps.Count:SetPoint("LEFT", nav.Prev, "RIGHT", 0, 0)
	nav.Next = W.IconButton(nav.Steps, "chevron-right", 24, L["Next step"], function()
		local E = Engine()
		if E and E.Next then E.Next() end
	end)
	nav.Next.psTipLines = { L["A look ahead: nothing is skipped. Skip moves on for good."] }
	nav.Next:SetPoint("LEFT", nav.Steps.Count, "RIGHT", 0, 0)
	nav.Menu = W.IconButton(nav, "menu", 24, L["Menu"], GF.OpenMenu)
	nav.Menu:SetPoint("RIGHT", nav, "RIGHT", -8, 0)
	GF.menuButton = nav.Menu
	-- Lookup opens the existing search section without changing the guide.
	nav.Lookup = W.IconButton(nav, "search", 24, L["Lookup"], function() UI.ShowLookup() end)
	nav.Lookup.psTipLines = { L["Search quests, NPCs, items, mounts and guides."] }
	nav.Lookup:SetPoint("RIGHT", nav.Menu, "LEFT", 0, 0)
	-- Report a problem with the step on screen (UI/Report.lua): the bug, left
	-- of Lookup.
	nav.Report = W.IconButton(nav, "bug", 24, L["Report a problem"], function() UI.ShowReport() end)
	nav.Report.psTipLines = { L["Write what went wrong, copy the report and paste it on the Polestar Discord."] }
	nav.Report:SetPoint("RIGHT", nav.Lookup, "LEFT", 0, 0)
	nav.Report:Hide()
	-- Nearby services: left of the bug, right of Skip.
	nav.Nearby = W.IconButton(nav, "icon-goto", 24, L["Nearby services"], GF.OpenNearby)
	nav.Nearby.psTipLines = { L["Points the arrow at the nearest vendor, repair, inn, flight master or trainer."] }
	nav.Nearby:SetPoint("RIGHT", nav.Report, "LEFT", 0, 0)
	nav.Nearby:SetShown(ns.Get("nav.nearbyButton") ~= false)
	GF.nearbyButton = nav.Nearby
	-- Skip: the 11px skip glyph and a Small label, a ghost button left of the
	-- bug.
	local skip = CreateFrame("Button", nil, nav)
	skip:SetHeight(24)
	W.Hover(skip, 0.7)
	skip.Icon = W.Tex(skip, "ARTWORK", "skip", "textDim")
	skip.Icon:SetSize(11, 11)
	skip.Icon:SetPoint("LEFT", skip, "LEFT", 7, 0)
	skip.Label = GF.SizeAs(T(skip, "small", "textDim"), "bar")
	skip.Label:SetPoint("LEFT", skip.Icon, "RIGHT", 5, 0)
	skip.Label:SetText(L["Skip"])
	skip:SetWidth(floor(7 + 11 + 5 + skip.Label:GetStringWidth() + 8 + 0.5))
	skip:SetScript("OnClick", function() GF.SkipStep() end)
	skip:SetScript("OnEnter", function(self)
		if self:IsEnabled() then
			W.Color(self.Icon, "text")
			W.Color(self.Label, "text")
		end
		local lines = { L["The guide moves on and remembers it. Undo in the banner, or go back to the step to unskip it."] }
		-- The later quests this guide leaves out with the step (Engine.SkipLoses).
		local E = Engine()
		local loses = self:IsEnabled() and E and E.SkipLoses and UI.SkipLosesText(E.SkipLoses())
		if loses then lines[#lines + 1] = { loses, Theme.Color("text") } end
		W.Tooltip(self, "ANCHOR_BOTTOM", L["Skip this step"], lines)
		GF.HoverIn()
	end)
	skip:SetScript("OnLeave", function(self)
		GF.PaintSkip(self:IsShown(), self:IsEnabled())
		W.HideTooltip(self)
	end)
	skip:Hide()
	nav.Skip = skip
	anchorSkip()
	nav.Title = GF.SizeAs(T(nav, "small", "textDim"), "bar")
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
	-- The wheel over the step number scrubs through the steps (GF.Scrub); a
	-- click opens and closes the step browser (UI/StepList.lua).
	nav.Steps.Hit = countHit
	countHit:EnableMouseWheel(true)
	countHit:SetScript("OnMouseWheel", function(_, delta) GF.Scrub(delta) end)
	countHit:SetScript("OnMouseUp", function(_, button)
		if button ~= "LeftButton" or not UI.StepList then return end
		GF.ScrubDone()
		UI.StepList.Toggle()
	end)
	for _, b in ipairs({ nav.Menu, nav.Lookup, nav.Report, nav.Nearby, nav.Next, nav.Prev, nav.Skip }) do hoverable(b) end
	-- Transparent chrome: the step number fades with its chevrons (nav.Steps
	-- holds all three) and the title with them; a lone "3 / 8" over the world
	-- would read as a stray number. Progress stays readable in the foot.
	for _, c in ipairs({ nav.Menu, nav.Lookup, nav.Report, nav.Nearby, nav.Skip, nav.Steps, nav.Title }) do chrome[#chrome + 1] = c end

	-- Body
	body = CreateFrame("Frame", nil, F)
	body:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", 0, 0)
	body:SetPoint("TOPRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	body:SetHeight(100)

	card = CreateFrame("Frame", nil, body)
	Anim.Anchor(card, "TOPLEFT", body, "TOPLEFT", 0, 0)

	-- The goals: rows and summary lines in a scroll area that grows with
	-- them up to the cap (fitGoals); its bar shows only while there is more.
	goals = W.Scroll(card)
	goals:SetHeight(0.01)
	goals:EnableMouseWheel(false)
	goals:SetScript("OnMouseWheel", goalsWheel)
	goals.psOnValue = W.ScrollTo
	goals.Bar:SetAlpha(0)
	goals.Bar:HookScript("OnEnter", function() GF.BarWake() end)
	goals.Bar:HookScript("OnLeave", function() GF.BarWake() end)

	-- The focus header: who (or what) the goals below belong to.
	person = CreateFrame("Button", nil, card)
	person:RegisterForClicks("LeftButtonUp")
	-- Ordinary texture: the name-target overlay forwards enter/leave, which
	-- cannot activate a native HIGHLIGHT on the header underneath it.
	person.Hover = person:CreateTexture(nil, "BACKGROUND")
	person.Hover:SetTexture(Theme.Media("white"))
	person.Hover:SetAllPoints(person)
	W.Painter(person.Hover, function(t)
		local r, g, b, a = Theme.Wash("hover")
		t:SetVertexColor(r, g, b, a * 0.7)
	end)
	person.Hover:Hide()
	-- The arrow on this person: the accent selection bar (GF.PaintMark).
	person.Mark = person:CreateTexture(nil, "ARTWORK")
	person.Mark:SetTexture(Theme.Media("white"))
	person.Mark:SetPoint("TOPLEFT", person, "TOPLEFT", 0, -6)
	person.Mark:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", 0, 4)
	W.Painter(person.Mark, GF.PaintMark)
	person.Mark:Hide()
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetSize(ICON + 1, ICON + 1)
	person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", PAD - 1, -11)
	person.Name = GF.SizeAs(T(person, "name", "personName"), "title")
	person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", TEXT_X, -10)
	person.Where = GF.SizeAs(T(person, "small", "textDim"), "detail")
	person.Where:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -3)
	-- Why a step that depends on what the player does holds nothing now (fillCard).
	person.Why = GF.SizeAs(T(person, "small", "textDim"), "detail", 0)
	person.Why:SetJustifyH("LEFT")
	person.Why:SetWordWrap(true)
	person.Why:Hide()
	-- A quest on the step well above the character's level (fillCard).
	person.Level = GF.SizeAs(T(person, "small", "warning"), "detail", 0)
	person.Level:SetJustifyH("LEFT")
	person.Level:SetWordWrap(true)
	person.Level:Hide()
	-- A profession guide's skill-range heading over the person (fillCard).
	card.Section = T(card, "label", "accent")
	card.Section:SetJustifyH("LEFT")
	card.Section:SetWordWrap(false)
	card.Section:Hide()
	-- Blizzard: a gold separator under the person, above the goals.
	person.Rule = person:CreateTexture(nil, "ARTWORK")
	person.Rule:SetTexture(Theme.Media("white"))
	person.Rule:SetHeight(1)
	person.Rule:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", PAD, 0)
	person.Rule:SetPoint("BOTTOMRIGHT", person, "BOTTOMRIGHT", -PAD, 0)
	W.Color(person.Rule, "separator")
	person.Rule:Hide()
	-- The header of the step the guide is on leads the arrow to its group's
	-- first open goal as a click on that goal's line does, so the arrow keeps
	-- moving on through the goal's spots (#1653: a point picked by hand there
	-- held the arrow on one spot); anywhere else, a plain point.
	person:SetScript("OnClick", function(self)
		local group, goal = self.psGroup, nil
		for _, gi in ipairs(group and view and group.goals or {}) do
			local g = view.goals[gi]
			if g and g.map and g.x and (g.status == "active" or g.status == "pending") then
				goal = g
				break
			end
		end
		if not GF.AimGoal(goal) then pointAt(self.psPlace, self.psLabel) end
	end)
	person:SetScript("OnEnter", personEnter)
	person:SetScript("OnLeave", personLeave)
	person:SetScript("OnHide", personLeave)

	-- The author's tip, one line until opened.
	local tip = CreateFrame("Button", nil, card)
	W.Hover(tip, 0.6)
	tip.Text = T(tip, "note", "textDim")
	tip.Text:SetJustifyV("TOP")
	tip.Text:SetSpacing(3)
	GF.SizeAs(tip.Text, "note", 3)
	tip.Text:SetPoint("TOPLEFT", tip, "TOPLEFT", TEXT_X, -6)
	tip.Toggle = W.IconButton(tip, "chevron-down", 18, nil, nil, 10)
	-- The step's picture, shown while the tip is open (layoutCard).
	tip.Image = tip:CreateTexture(nil, "ARTWORK")
	tip.Image:Hide()
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
	after.Text = GF.SizeAs(T(after, "label", "textDim"), "detail")
	after.Text:SetWordWrap(true)
	after.Text:SetMaxLines(2)
	after.Text:SetPoint("LEFT", after, "LEFT", PAD, 0)
	after.Count = GF.SizeAs(T(after, "small", "textMuted"), "detail")
	after.Count:SetJustifyH("RIGHT")
	after.Count:SetPoint("RIGHT", after, "RIGHT", -PAD, 0)

	-- Along the way: goals of along steps the route has passed. Shown only
	-- while one is open (fillAlong).
	along = CreateFrame("Frame", nil, body)
	along.Rule = W.Divider(along)
	along.Rule:SetPoint("TOPLEFT", along, "TOPLEFT", PAD, 0)
	along.Rule:SetPoint("TOPRIGHT", along, "TOPRIGHT", -PAD, 0)
	along.Label = GF.SizeAs(T(along, "small", "textMuted"), "up")
	along.Label:SetPoint("LEFT", along, "TOPLEFT", PAD, -UP_TOGGLE / 2)
	along:Hide()
	handOver()
	GF.BuildHere()

	upnext = CreateFrame("Frame", nil, body)
	local toggle = CreateFrame("Button", nil, upnext)
	toggle:SetHeight(UP_TOGGLE)
	W.Hover(toggle, 0.7)
	toggle.Rule = W.Divider(toggle)
	toggle.Rule:SetPoint("TOPLEFT", toggle, "TOPLEFT", PAD, 0)
	toggle.Rule:SetPoint("TOPRIGHT", toggle, "TOPRIGHT", -PAD, 0)
	toggle.Label = GF.SizeAs(T(toggle, "small", "textMuted"), "up")
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
	xp:SetHeight(GF.XPROW.h)
	xp:EnableMouse(true)
	xp.Rule = W.Divider(xp)
	xp.Rule:SetPoint("TOPLEFT", xp, "TOPLEFT", PAD, 0)
	xp.Rule:SetPoint("TOPRIGHT", xp, "TOPRIGHT", -PAD, 0)
	xp.Icon = W.Tex(xp, "ARTWORK", "icon-level", "textMuted")
	xp.Icon:SetSize(11, 11)
	xp.Icon:SetPoint("LEFT", xp, "LEFT", PAD, -1)
	xp.Text = T(xp, "small", "textDim")
	xp.Text:SetPoint("LEFT", xp.Icon, "RIGHT", 7, 0)
	-- (A narrow window cuts the line with "..."; the hover shows all of it.)
	xp.Text:SetPoint("RIGHT", xp, "RIGHT", -PAD, 0)
	xp.Text:SetJustifyH("LEFT")
	xp.Text:SetWordWrap(false)
	-- Boosted Rest and the sleeping bag (QoL/Rest.lua) on a short line of
	-- their own under it, so the pace text never pushes them out of sight.
	xp.Rest = T(xp, "small", "textDim")
	xp.Rest:SetPoint("TOPLEFT", xp.Text, "BOTTOMLEFT", 0, -GF.XPROW.gap)
	xp.Rest:SetPoint("RIGHT", xp, "RIGHT", -PAD, 0)
	xp.Rest:SetJustifyH("LEFT")
	xp.Rest:SetWordWrap(false)
	xp.Rest:Hide()
	xp:SetScript("OnEnter", function(self)
		if self.psSummary or self.psLine then
			local lines = {}
			for _, l in ipairs({ self.psLine or false, self.psRest or false, self.psSummary or false }) do
				if l then lines[#lines + 1] = l end
			end
			W.Tooltip(self, tooltipAnchor(), L["Experience"], lines)
		end
		GF.HoverIn()
	end)
	xp:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	xp:Hide()
	GF.xp = xp

	-- The party's place on this guide and the group's wait (Quests/Party.lua,
	-- Party.StepLine); a click shows or hides the party panel. While the
	-- group waits on the step: "Go on without them" (Party.GoOn).
	local party = CreateFrame("Button", nil, body)
	party:SetHeight(28)
	party.Rule = W.Divider(party)
	party.Rule:SetPoint("TOPLEFT", party, "TOPLEFT", PAD, 0)
	party.Rule:SetPoint("TOPRIGHT", party, "TOPRIGHT", -PAD, 0)
	party.Icon = W.Tex(party, "ARTWORK", "icon-talk", "textMuted")
	party.Icon:SetSize(11, 11)
	party.Icon:SetPoint("LEFT", party, "LEFT", PAD, -1)
	party.GoOn = W.Link(party, L["Go on without them"], function()
		if ns.Party and ns.Party.GoOn then ns.Party.GoOn() end
	end, { role = "small" })
	party.GoOn.psTip = L["The step stops waiting for the party and moves on as usual."]
	party.GoOn:SetPoint("RIGHT", party, "RIGHT", -PAD, -1)
	party.GoOn:Hide()
	party.Text = T(party, "small", "textDim")
	party.Text:SetPoint("LEFT", party.Icon, "RIGHT", 7, 0)
	party.Text:SetPoint("RIGHT", party, "RIGHT", -PAD, 0)
	party.Text:SetJustifyH("LEFT")
	party.Text:SetWordWrap(false)
	party:SetScript("OnClick", function()
		if UI.PartyPanel then UI.PartyPanel.Toggle() end
	end)
	party:SetScript("OnEnter", function(self)
		W.Tooltip(self, tooltipAnchor(), L["Party"], { L["Click to show or hide the party panel."] })
		GF.HoverIn()
	end)
	party:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	party:Hide()
	GF.party = party

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
	banner.Later:SetScript("OnClick", function() GF.LaterBanner() end)
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
	W.Uncolor(foot.Line.Fill)
	W.Painter(foot.Line.Fill, GF.PaintProgressFill)
	foot.Line:SetPoint("LEFT", foot, "LEFT", PAD, 0)
	foot.Pct = GF.SizeAs(T(foot, "number", "textDim"), "bar")
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
	grip:SetScript("OnMouseDown", GF.ResizeStart)
	grip:SetScript("OnMouseUp", GF.ResizeStop)
	grip:SetScript("OnHide", GF.ResizeStop)
	GF.grip = grip
	chrome[#chrome + 1] = grip

	GF.parts = {
		strip = strip, nav = nav, body = body, card = card, person = person, tip = tip, after = after,
		along = along, upnext = upnext, empty = empty, band = band, banner = banner, foot = foot, line = foot.Line, here = GF.here,
		goals = goals,
	}
	GF.chrome = chrome
	handOver()

	F:SetScript("OnShow", function()
		GF.UpdateXP()
		GF.Render()
	end)
	if UI.NameTargets then
		UI.NameTargets.Bind(F, function()
			local entries = {}
			if state ~= "steps" or not view then return entries end
			if person:IsShown() and focusGroup and focusGroup.kind == "npc" then
				entries[#entries + 1] = { owner = person, region = person.Name,
					goal = { t = "talk", npc = focusGroup.npc, npcName = focusGroup.name } }
			end
			local E = Engine()
			local g = E and E.GetGuide and E.GetGuide()
			local raw = g and g.steps and g.steps[view.index]
			for _, row in ipairs(rows) do
				-- Not a row scrolled out of sight (a folding row keeps its
				-- target until the fold lands and the card refills).
				if row:IsShown() and row.psGoal and inSight(row) then
					entries[#entries + 1] = { owner = row, region = row, wholeRow = true, goal = row.psGoal, right = true,
						controls = { row.Check, row.Skip, row.Alt, row.psGearPick },
						raw = raw and raw.goals and raw.goals[row.psGoal.index] }
				end
			end
			return entries
		end)
	end
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
	GF.ApplyAll()
end)

ns.On("GUIDE_CHANGED", whenReady(GF.Render))
ns.On("STEP_CHANGED", whenReady(GF.Render))
ns.On("STEP_UPDATED", whenReady(GF.Update))
ns.On("PARTY_PROGRESS", whenReady(GF.Update))
ns.On("GUIDES_REGISTERED", whenReady(GF.Render))
ns.On("PACKS_CHANGED", whenReady(GF.Render))
ns.On("GUIDE_COMPLETED", whenReady(GF.Render))
ns.On("WAYPOINT_CHANGED", whenReady(GF.UpdateTargets))
ns.On("QUEST_TIMER", whenReady(GF.TimerTick))
-- The screen's height changed (resolution, the game's UI scale): the
-- height cap follows.
ns.RegisterEvent("DISPLAY_SIZE_CHANGED", whenReady(function() GF.Layout() end))
ns.RegisterEvent("UI_SCALE_CHANGED", whenReady(function() GF.Layout() end))

-- The tabs changed (a step moved on, a tab opened or closed): their titles
-- and progress are redrawn. The window is laid out again only when the
-- strip itself comes or goes; a step change already laid it out (Render).
ns.On("TABS_CHANGED", whenReady(function()
	local has = GF.TabsOf(Engine()) ~= nil
	if has ~= strip.psHasTabs then
		strip.psHasTabs = has
		GF.Layout()
	elseif GF.StripShown() then
		GF.RenderTabs()
	end
end))

-- The catch-up (GUIDE_PLACED): once a guide just opened is placed, the
-- window goes over the steps before the one it resumes at, each shown in
-- full (the card, the journey, what follows) one after another faster and
-- faster, then the step placed. Guides passed whole go by first, by title.
-- It plays when a guide is opened (by the player, the login's pick, a guide
-- chained to), from step 1; a guide a login or /reload brings back is placed
-- without it (the Engine fires GUIDE_PLACED for opened guides only). Not
-- with reduced motion, the window hidden, or a single step to go over. A
-- guide placed before the world is entered waits for it. Only the window
-- moves: the Engine's step, the arrow and the automation stay on the step
-- placed.
local CATCH_GUIDE = 0.35 -- seconds per guide passed whole (at most 1.2 in all)
GF.catchUpState = { entered = false }

local function catchUpDone()
	GF.catchingUp, GF.catchUpIndex = nil, nil
	ns.Fire("CATCH_UP", false)
	GF.Render()
end

function GF.PlayCatchUp(guideId, step, chain)
	local cs = GF.catchUpState
	if not cs.entered then
		cs.queued = { guideId, step, chain }
		return
	end
	local passed = chain and #chain or 0
	if not (F and F:IsShown() and ns.IsLoggedIn()) or Anim.Reduced() then return end
	-- A single step passed is no catch-up (the player's own first step).
	if not step or (step <= 2 and passed == 0) then return end
	local Count = nav.Steps.Count
	-- CATCH_UP(true|false): the arrow shows an hourglass meanwhile (Nav/Arrow.lua).
	ns.Fire("CATCH_UP", true)
	local function roll()
		GF.catchingUp = "steps"
		local shown
		Count.psOnValue = function(_, v)
			local i = max(1, min(step - 1, floor(v)))
			-- A step hidden from the character (#942) is not shown on the way.
			if i ~= shown and not UI.StepHidden(i) then
				shown = i
				GF.catchUpIndex = i
				GF.Render()
			end
		end
		-- Slow at first, then faster: about 0.06 s a step, 2.5 s at most.
		local dur = min(2.5, 0.5 + 0.06 * (step - 1))
		Anim.To(Count, "value", 1, step - 0.001, dur, "in", catchUpDone)
	end
	if passed == 0 then return roll() end
	-- The guides passed whole, each shown done.
	GF.catchingUp = "guides"
	local titles = {}
	for i, id in ipairs(chain) do
		local g = ns.Guides.Get(id)
		titles[i] = { g and (g.title or g.id) or id, g and #g.steps or 0 }
	end
	Count.psOnValue = function(o, v)
		local t = titles[min(passed, floor(v) + 1)]
		nav.Title:SetText(t[1])
		o:SetText(string.format("%d / %d", t[2], t[2]))
	end
	Anim.To(Count, "value", 0, passed - 0.001, min(1.2, CATCH_GUIDE * passed), "linear", function()
		if step > 1 then return roll() end
		catchUpDone()
	end)
end

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	local cs = GF.catchUpState
	if cs.entered then return end
	cs.entered = true
	local q = cs.queued
	cs.queued = nil
	if q and F then GF.PlayCatchUp(q[1], q[2], q[3]) end
end)

ns.On("GUIDE_PLACED", function(guideId, step, chain)
	if F then GF.PlayCatchUp(guideId, step, chain) end
end)

-- A flight begins or ends (guideWindow.hideTaxi): the client says the
-- player is on a taxi a moment after control is lost, so look again then.
function GF.TaxiChanged()
	if not ns.Get("guideWindow.hideTaxi") then return end
	GF.ApplyVisibility()
	ns.After(0.5, GF.ApplyVisibility)
end
ns.RegisterEvent("PLAYER_CONTROL_LOST", function() GF.TaxiChanged() end)
ns.RegisterEvent("PLAYER_CONTROL_GAINED", function() GF.TaxiChanged() end)

-- For the other GuideFrame*.lua files, which take these as their own locals
-- when they load (GF.Bind hands over the parts and sizes).
GF.Engine, GF.Compact, GF.Transparent, GF.PlaceCheck = Engine, compact, transparent, placeCheck
GF.TwoLines, GF.MeasureRow, GF.UpcomingOpen = twoLines, measureRow, upcomingOpen
GF.ContentHeight, GF.FitGoals, GF.SizeWindow, GF.ResetModel = contentHeight, fitGoals, sizeWindow, resetModel
GF.AnchorSkip, GF.WhenReady = anchorSkip, whenReady
GF.area, GF.fit, GF.texts, GF.chrome = area, fit, texts, chrome
function GF.ReadMetrics()
	readMetrics()
	handOver()
end
-- What the window shows: the step view on screen, the window's state
-- ("steps", "noguide", ...) and whether the step's tip is opened.
function GF.View() return view end
function GF.State() return state end
function GF.TipOpen() return tipOpen end
function GF.SetTipOpen(open) tipOpen = open end
