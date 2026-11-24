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
-- One window's code, any number of windows. Every GuideFrame*.lua file adds
-- its part with GF.Part(fn) as UI.xml loads it, and fn(GF) builds that part
-- into the window table GF: at once for the live window (UI.GuideFrame,
-- GF.live), then again, part by part in the same order, for each copy
-- GF.Copy(parent, content) makes (the settings preview's, UI/Looks/
-- GuideWindow.lua). A copy is unnamed, in `parent`, takes no clicks, wheel or
-- tooltip (only the pointer's hover, for the look the window has under it;
-- a transparent window's tabs and step bar show on a copy at rest too),
-- has no event, message, setting or hook of its own, and none of the frames
-- other modules put in the live window (the class card, the journey, the step
-- browser, name targets, gear picks), nor its banner, timers or party line.
-- Its host draws it with copy.Draw() and places copy.frame.
--
-- What a window draws is one small interface (GF.CONTENT): the Engine's read
-- API it draws a step from (GetGuide, GetTabs, GetStepIndex, GetLiveStep,
-- GetStepCount, GetStepView, StepNumber, StepTotal, GetProgress, GetAlong,
-- GetWhileHereList, LeftOutHere; a gate, notice or action it lacks is nothing to show or
-- do) and the lines other modules work out from it: Pace() (Core/Levels.lua),
-- XPStats() and RestParts() (QoL), Target() (where the
-- arrow points: Nav, else the Engine's waypoint). The live window reads the
-- Engine and those modules straight (GF.Engine(), GF.Derived()); a copy, its
-- host's provider of the whole interface (copy.content).
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

-- The live window's table, every file's part in load order and the copies
-- made so far. A part a load-on-demand addon adds later joins the copies
-- that exist too, after their build.
local GF, partsOf, copies = { live = true }, {}, setmetatable({}, { __mode = "k" })
ns.UI.GuideFrame = GF
function GF.Part(fn)
	partsOf[#partsOf + 1] = fn
	fn(GF)
	for copy in pairs(copies) do fn(copy) end
end
-- A copy of the window, unnamed, in `parent`, drawing `content` (a provider
-- of GF.CONTENT): built, not drawn. opts.layout: the layout it draws with
-- (GF.layoutChoice). -> its table (copy.frame, copy.parts, copy.rows, ... as
-- the live window's)
function GF.Copy(parent, content, opts)
	local copy = { live = false, parent = parent, content = content, layoutChoice = opts and opts.layout }
	for _, fn in ipairs(partsOf) do fn(copy) end
	copy.Build()
	-- A copy drawing with the layout in use is a window the layout leaves
	-- (Theme's switch hands its parts to the layout's onLeave, as the live
	-- window's): GF.copies, held weakly.
	if copy.layoutChoice == nil then
		GF.copies = GF.copies or setmetatable({}, { __mode = "k" })
		GF.copies[copy] = true
	end
	copies[copy] = true
	return copy
end

-- The layout's and the skin's hooks for this window (Theme.SkinHookFor):
-- GF.layoutChoice is the layout it draws with, nil the one in use (the live
-- window, the settings' preview), false Polestar's own (a built-in preset's
-- card), an id that layout's (a layout's preset card). The hooks get this
-- window's parts. With the layout in use they go through Theme.SkinHook and
-- Theme.SkinHookValue, as every other surface's do.
GF.Part(function(GF)
	local Theme = ns.Theme
	function GF.Hook(surface, ...)
		if GF.layoutChoice == nil then return Theme.SkinHook(surface, ...) end
		return Theme.SkinHookFor(GF.layoutChoice, surface, ...)
	end
	function GF.HookValue(surface, ...)
		if GF.layoutChoice == nil then return Theme.SkinHookValue(surface, ...) end
		return Theme.SkinHookValueFor(GF.layoutChoice, surface, ...)
	end
	-- A gap or height in the window's layout, `px` by Polestar's own, as the
	-- skin or layout sets it (Skin API 2, hooks.guideSpace(name, px)): its
	-- answer, a number of 0 or more, else px. `...`: what the hook is also
	-- handed for that name ("xpRoom": the window's width).
	-- Out of compact mode the player's own size for it stands over both
	-- (GF.Gap, GF.SPACE_KEYS: the gaps Options > Guide window, Step card sets);
	-- GF.LookSpace: the look's alone.
	function GF.LookSpace(name, px, ...)
		local ran, v = GF.HookValue("guideSpace", name, px, ...)
		if ran and type(v) == "number" and v >= 0 then return v end
		return px
	end
	function GF.Space(name, px, ...)
		px = GF.LookSpace(name, px, ...)
		local key = GF.SPACE_KEYS[name]
		return key and GF.Gap(key, px) or px
	end
	GF.SPACE_KEYS = { upRow = "upRowHeight", lastRow = "lastRowHeight", tipGap = "tipSpace", tipPad = "tipPadding", xpRow = "xpRowHeight" }
	-- A gap the player sizes (Options > Guide window, Step card:
	-- guideWindow.<key>, the gap's whole size in px; false, the look's own):
	-- that size out of compact mode, else px. Compact mode keeps the look's.
	function GF.Gap(key, px)
		if ns.Get("ui.compact") then return px end
		local v = tonumber(ns.Get("guideWindow." .. key))
		if v and v >= 0 then return math.floor(v + 0.5) end
		return px
	end
end)

GF.Part(function(GF)
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

	-- The XP row's height, what its Boosted Rest line adds below a gap, and
	-- its icon's offset beside the first of two lines.
	GF.XPROW = { h = 28, restH = 16, gap = 3, iconY = 6 }

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

	-- The window's content (the top of this file). The live window asks the
	-- Engine as it is when asked (a test may stand another in its place) and,
	-- for the four lines worked out from it, their modules (DERIVED), straight:
	-- its step change pays nothing for the interface. A copy reads its host's
	-- provider for both (copy.content). A host may hand the live window a
	-- provider too (GF.UseContent(content); nil: the Engine again).
	-- Quests in the log off the route from which the card nudges a cleanup (#2634).
	GF.OFF_ROUTE_NUDGE = 3
	-- The off-route line closed by its ×: how many quests were off the route
	-- then; it comes back when more are (this session).
	GF.offRouteClosed = nil
	GF.CONTENT = { "GetGuide", "GetTabs", "GetStepIndex", "GetLiveStep", "GetStepCount", "GetStepView", "StepNumber", "StepTotal",
		"GetProgress", "GetAlong", "GetWhileHereList", "LeftOutHere", "Pace", "XPStats", "RestParts", "Target" }
	local DERIVED = GF.live and {
		Pace = function()
			local Lv = ns.Levels
			return Lv and Lv.Pace and Lv.Pace() or nil
		end,
		XPStats = function()
			local Q = ns.QoL
			if not (Q and Q.GetXPStats) then return nil end
			local ok, stats = pcall(Q.GetXPStats)
			return ok and stats or nil
		end,
		RestParts = function()
			local Q = ns.QoL
			return Q and Q.Rest and Q.Rest.Parts and Q.Rest.Parts() or nil
		end,
		-- Where the arrow points. With Nav loaded its answer is final: nil
		-- means the player dismissed the target, so nothing is marked. Only
		-- without Nav does the Engine's waypoint stand in.
		Target = function()
			local nav, E = ns.Nav, ns.Engine
			if nav and nav.GetTarget then return nav.GetTarget() end
			return E and E.GetWaypoint and E.GetWaypoint() or nil
		end,
	} or nil
	local provider = GF.content
	local function Engine() return provider or ns.Engine end
	local function Derived() return provider or DERIVED end
	function GF.UseContent(c)
		provider, GF.content = c, c
	end
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
		tabs = true, tabStyle = "underline", tabHeight = 1, navHeight = 1, stepCount = true, guideTitle = true, skipButton = true, reportButton = true, allStepsButton = false,
		barTextSize = 1, stepNumberSize = 1, titleSize = 1, goalSize = 1, detailSize = 1, noteSize = 1, upSize = 1,
		outline = "outline", padding = 0, rowSpacing = 0, lineSpacing = 0, glyphSize = 1, checkSize = 1,
		targetBar = true, targetBarColor = false, targetBarWidth = 2,
		progress = true, progressPct = true, progressHeight = 3, progressColor = false, pace = true,
		-- The XP row's own line (#3304) and the Still to do rows (#3303): each
		-- off on its own, without compact mode.
		xpLine = true, stillToDo = true,
		bgColor = false, bgOpacity = false, border = true, idleAlpha = 1, combatAlpha = 0.35, veil = 0.68, shade = 0.2,
		stepAnim = true, animSpeed = 1, foldAnim = true, rules = true, hideTaxi = false, leftOut = true, lastSteps = 0,
		-- The step card's gaps, each its whole size in px (GF.Gap); false: the
		-- look's own (Polestar's: 10 over the step's title, 8 under it, 2 over
		-- the tip, 6 round its text, the skin's Up next row for Up next and the
		-- steps before, a 28 px XP row).
		stepSpace = false, titleSpace = false, tipSpace = false, tipPadding = false, upRowHeight = false, lastRowHeight = false, xpRowHeight = false,
		-- Where the Journey goes: "inside" (under the step); a layout may offer
		-- more ("joined", "folded", "rail", "foot": Polestar_Skins/Layouts/Atlas).
		journeyStyle = "inside",
		-- The banner's action: "under" the text, or "right" on its line, by
		-- the × (only a notice with one action; two stay under).
		bannerLinks = "under",
	}
	if GF.live then ns.RegisterDefaults("guideWindow", GF.LOOK) end

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
	-- untouched string is never painted again. A group of several settings
	-- takes their product (the step number: the bar's text, then its own).
	GF.SIZE_KEYS = { title = "titleSize", goal = "goalSize", detail = "detailSize", note = "noteSize", up = "upSize", bar = "barTextSize",
		count = { "barTextSize", "stepNumberSize" } }
	GF.sized = setmetatable({}, { __mode = "k" })
	GF.spaced = setmetatable({}, { __mode = "k" })
	GF.sizedAt = setmetatable({}, { __mode = "k" })

	-- GF.numFit: fontString -> its own factor on top of its group's (a number
	-- too wide for its column even at its widest, GF.FitNumColumn). Not GF.fit:
	-- that is the window's height-fit state (GuideFrameLayout.lua).
	GF.numFit = setmetatable({}, { __mode = "k" })

	function GF.SizeOne(fs)
		local key = GF.sized[fs] and GF.SIZE_KEYS[GF.sized[fs]]
		local k = 1
		if type(key) == "table" then
			for _, n in ipairs(key) do k = k * GF.Num(n) end
		elseif key then
			k = GF.Num(key)
		end
		k = k * (GF.numFit[fs] or 1)
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
	-- turned off it stays laid out, unseen. In the house look the row is lit as
	-- well (t.psLit, GF.ShowMark): the bar's colour at the house's `lit` share,
	-- fading out across the row; off with the bar and in the transparent style,
	-- which draws no fills. A layout that answers guideShows "markWash" true
	-- marks with the light alone, in every look (the house's share, else
	-- MARK_WASH); the transparent style keeps the bar instead.
	local MARK_WASH = 0.16
	local function markWash() return GF.Shows and GF.Shows("markWash", false) or false end
	local function litShare() return Theme.House("lit") or (markWash() and MARK_WASH) or nil end

	function GF.PaintMark(t)
		local r, g, b = GF.Rgb("targetBarColor")
		if r then t:SetVertexColor(r, g, b, 1) else t:SetVertexColor(Theme.Color("accent")) end
		t:SetWidth(GF.Num("targetBarWidth"))
		local washed = markWash() and not transparent()
		t:SetAlpha(GF.On("targetBar") and not washed and 1 or 0)
		local lit = t.psLit
		if not lit then return end
		if not r then r, g, b = Theme.Color("accent") end
		local a = GF.On("targetBar") and not transparent() and litShare() or 0
		if lit.SetGradient and CreateColor then
			lit:SetVertexColor(1, 1, 1, 1)
			lit:SetGradient("HORIZONTAL", CreateColor(r, g, b, a), CreateColor(r, g, b, 0))
		else
			lit:SetVertexColor(r, g, b, a * 0.6)
		end
	end

	-- Shows or hides row r's (or the person's) target bar, and its light in the
	-- house look (or under a layout's guideShows "markWash"), made on the first
	-- mark there (not at login), over the bar's height to the row's right edge.
	function GF.ShowMark(r, on)
		on = on and true or false
		local mark = r.Mark
		mark:SetShown(on)
		local lit = mark.psLit
		if on and not lit and litShare() then
			lit = r:CreateTexture(nil, "BACKGROUND", nil, 1)
			lit:SetTexture(Theme.Media("white"))
			local _, _, _, _, top = mark:GetPoint(1)
			local _, _, _, _, bottom = mark:GetPoint(2)
			lit:SetPoint("TOPLEFT", r, "TOPLEFT", 0, top)
			lit:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, bottom)
			mark.psLit = lit
			GF.PaintMark(mark)
		end
		-- A row the game look lights with its own art (Theme.KitRowLit,
		-- r.psKitLit) keeps that art alone: the wash over it ran out past the
		-- art's inset.
		if lit then lit:SetShown(on and not rawget(r, "psKitLit")) end
	end

	-- The goal rows' mark (GF.ShowMark) on frame r, a row a layout or a card
	-- draws itself (While you're here, Along the way): its bar made on the
	-- first mark, at r's left edge, 3 px in from its top and bottom.
	function GF.MarkRow(r, on)
		if not rawget(r, "Mark") then
			if not on then return end
			local m = r:CreateTexture(nil, "ARTWORK")
			m:SetTexture(Theme.Media("white"))
			m:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
			m:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
			r.Mark = m
			W.Painter(m, GF.PaintMark)
		end
		GF.ShowMark(r, on)
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

	-- Where the arrow points, as the window's content says (its Target line).
	local function targetOf()
		local d = Derived()
		return d.Target and d.Target() or nil
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
			-- Where the quest sits in its chain, "Chain: 6 of 11" (Lookup.ChainTooltipText, #2554).
			local Lk = ns.Lookup
			local chain = Lk and Lk.ChainTooltipText and Lk.ChainTooltipText(goal.quest)
			if chain then lines[#lines + 1] = { chain, Theme.Color("textDim") } end
			-- A dungeon's quest, or one of the nearest prerequisites before one (Dungeons/Mark.lua).
			local dungeon = ns.Dungeons and ns.Dungeons.MarkTooltip and ns.Dungeons.MarkTooltip(goal.quest)
			if dungeon then lines[#lines + 1] = { dungeon, Theme.Accent() } end
		end
		if goal.npc then
			local name = goal.subjectKind == "npc" and goal.subject or goal.npcName
			lines[#lines + 1] = { left = L["NPC"], right = name and (name .. id .. goal.npc .. "|r") or ("#" .. goal.npc) }
		end
		-- An item goal shows the game's tooltip of its item, the guide's lines under it.
		local itemTip = goal.item and goal.subjectKind == "item" and W.ItemTip and W.TooltipLines
		if goal.item and not itemTip then
			lines[#lines + 1] = { left = L["Item"], right = "#" .. goal.item }
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
		-- Middle-click: the quest log; shift-click: the quest's link in chat (#2545).
		if ns.QuestClickTips then ns.QuestClickTips(goal.quest, lines) end
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
		if itemTip then
			W.ItemTip(row, goal.item, function(tip)
				tip:AddLine(" ")
				tip:AddLine(goal.text or "", 1, 1, 1, true)
				W.TooltipLines(tip, lines)
			end, tooltipAnchor())
			return
		end
		if #lines == 0 then return end
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

	-- A quest's line, right-clicked: tick this goal done (or untick it), open
	-- the game's quest log at its quest (ns.QuestLogMenuItem), or skip the whole
	-- quest and what follows from it (Engine.SkipQuest), or bring a skipped
	-- quest back; last, its link in chat (ns.QuestLinkMenuItem: a gamepad's
	-- shift-click, #2545).
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
		local show = ns.QuestLogMenuItem and ns.QuestLogMenuItem(goal.quest)
		if show then items[#items + 1] = show end
		-- What this guide leaves out with it (Engine.SkipLoses), named in the tip.
		local tip = L["This quest and the ones that follow from it are skipped, in every guide. Right-click it again to bring it back."]
		local loses = E.SkipLoses and UI.SkipLosesText(E.SkipLoses(goal.quest))
		if loses then tip = tip .. " " .. loses end
		items[#items + 1] = { text = L["Skip this quest"], icon = "skip", tip = tip,
			onClick = function() E.SkipQuest(goal.quest, true) end }
		local link = ns.QuestLinkMenuItem and ns.QuestLinkMenuItem(goal.quest)
		if link then items[#items + 1] = link end
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
		-- A quest's line: a middle-click shows it in the quest log, a shift-click links it in chat (#2545).
		if ns.QuestRowClick and ns.QuestRowClick(goal.quest, button) then return end
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
		r:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
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
		r.Share.Label = T(r.Share, "small", "textDim")
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
			W.Color(b.Label, "textDim")
			W.HideTooltip(b)
		end)
		r.Share:Hide()
		-- At the player's size (guideWindow.checkSize) from the first, the skin's
		-- art drawn to it, as the look pass does: a row made after the last look
		-- pass (rows come as a step needs them) has no other.
		r.Check:SetSize(CHECK, CHECK)
		placeCheck(r)
		Theme.Repaint(r.Check)
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
			-- Gold is the live goal's alone; a goal at rest is dim.
			W.Color(r.Icon, done and "success" or (current and "accent" or "textDim"))
		end
		-- The game's looks light the goal to do now with their own art.
		r.psKitLit = Theme.KitRowLit(r, current and not done and not skipped and not transparent(), nil, GF.LookSpace("litInset", Theme.Metric("guideLitInset", 4))) or nil
		UI.SetCounted(r.Text, UI.GoalLine(goal, questHex, true))
		-- White while it is to be done; done and skipped goals step back. The
		-- turn-in of a quest whose objectives are still open, pinned (#644),
		-- ticked by hand (#1135) or worked along the way (#853): the warning
		-- colour, and its line says so. A goal marked `accent` (a pick-up
		-- guide's "Comes back at level N") takes the look's accent.
		local warn = goal.pinOpen and not done and not skipped
		W.Color(r.Text, (done or skipped) and "textMuted" or (warn and "warning" or (goal.accent and "accent") or (aside and "textDim" or "text")))
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
		if GF.live and UI.GearPick then UI.GearPick.Paint(r, goal) end
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
		local shareTo = GF.live and not noMissing and ns.Party and ns.Party.ShareFor and ns.Party.ShareFor(goal) or nil
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
		GF.Hook("guideRow", r, goal, info)
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
		-- A skin that puts its own column at the edge (Atlas's count) asks
		-- for at least that much room with r.psRightMin.
		if r.psRightMin and r.psRightMin > right then right = r.psRightMin end
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
		if GF.live and UI.GearPick then h, above = UI.GearPick.Measure(r, tw, h, above) end
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
	GF.MIN_BODY_H = MIN_BODY_H -- the step browser keeps it too (GuideFrameLayout.lua)
	-- `pad`: room the window keeps past its content (Fixed with the bar under the last goal, fit.follow).
	local function sizeWindow(y, pad)
		local natural = floor(fit.outer + y + (pad or 0) + 0.5)
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
			if GF.live and UI.NameTargets then UI.NameTargets.Refresh() end
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

		-- The row edge nearest `to` on one side: the last item top at or above it
		-- (dir < 0) or the first at or below it (dir > 0); nil when there is none.
		-- Scroll stops land on these, so no goal shows cut in half at the top.
		local function rowEdge(to, dir)
			local y, items, hs, last = 0, area.items, area.h, nil
			for i = 1, area.n do
				if dir > 0 and y >= to - 0.5 then return y end
				if dir < 0 and y > to + 0.5 then return last end
				last = y
				y = y + hs[i] * (items[i].psK or 1)
			end
			if dir < 0 then return last end
			return nil
		end
		GF.RowEdge = rowEdge

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
		-- Of the item bottoms that fit, the last from which the last scroll stop
		-- (the content less the view) is an item's top too is taken, so the
		-- wheel's last stop starts on a whole row as well (#1066); when none of
		-- them down to CARD.minView is, the last that fits.
		local sums = {}
		local function wholeItems(limit, content)
			local y, n, items, hs, fits = 0, area.n, area.items, area.h, 0
			for i = 1, n do
				y = y + hs[i] * (items[i].psK or 1)
				sums[i] = y
				if y <= limit + 0.5 then fits = i end
			end
			if fits == n then return limit end
			local down = fits > 0 and sums[fits] or 0
			if down < CARD.minView - 0.5 then
				local cut = sums[fits + 1]
				return cut <= limit + CARD.minView and cut or limit
			end
			-- Down from the last bottom that fits, the last stop climbs through
			-- the item tops (0, then each bottom) from the start.
			local k = 0
			for j = fits, 1, -1 do
				local v = sums[j]
				if v < CARD.minView - 0.5 then break end
				local stop = content - v
				while k < n and sums[k + 1] < stop - 0.5 do k = k + 1 end
				if stop < 0.5 or (k < n and abs(sums[k + 1] - stop) < 0.5) then return v end
			end
			return down
		end

		-- Size the goals area to its contents within the cap, then the card, the
		-- frames under it and the window to that. Runs every frame a row folds,
		-- so it only sets sizes and points. Past the cap the area ends on a whole
		-- item (wholeItems); while goals fold it keeps that height, shrinking
		-- only to the content, and settles on the next layout after the folds.
		function fitGoals()
			local content = contentHeight()
			local limit = max(CARD.minView, fit.room)
			local viewH, pad = min(content, limit), 0
			-- Fixed (ui.heightMode): the view fills the room up to the height, the
			-- step short or not; with the bar under the last goal (fit.follow) the
			-- window keeps that room past it instead. The height is the player's:
			-- no whole-item trim.
			if fit.fixedH and fit.room < math.huge then
				goals.psWhole = false
				if fit.follow then pad = limit - viewH else viewH = limit end
			elseif fold.n > 0 and goals.psWhole then
				viewH = min(content, goals.psViewH)
			else
				goals.psWhole = fit.snap and content > limit + 0.5 or false
				if goals.psWhole then viewH = wholeItems(limit, content) end
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
			-- While there is more to scroll, the goals take no click on the bar's
			-- strip at their right edge: the bar under them stays draggable.
			local strip = over and W.ScrollBarRoom(goals) or 0
			for i = 1, area.n do
				local f = area.items[i]
				if f.psBarStrip ~= strip then
					f.psBarStrip = strip
					f:SetHitRectInsets(0, strip, 0, 0)
				end
			end
			local cardH = fit.fixed + viewH
			card:SetHeight(cardH)
			local y = fit.top + cardH
			local below, rel = fit.below, fit.rel
			for i = 1, fit.n do
				local f, at = below[i], -(y + rel[i])
				f:SetPoint("TOPLEFT", body, "TOPLEFT", f.psInset or 0, at)
				f:SetPoint("TOPRIGHT", body, "TOPRIGHT", 0, at)
			end
			y = y + fit.h
			sizeWindow(y, pad)
		end

		-- Scroll the goals area to `to` (clamped), gliding there unless `snap`.
		local function scrollTo(to, snap)
			local cur = goals:GetVerticalScroll()
			local last = max(0, (goals.psContentH or 0) - (goals.psViewH or 0))
			to = min(last, max(0, to))
			-- Stop on a row's top, in the direction of travel (fitGoals keeps the
			-- last stop on one too: wholeItems).
			if to > 0.5 and to < last - 0.5 then
				to = min(last, rowEdge(to, to > cur and 1 or -1) or to)
			end
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
		-- scrolled just far enough to show its row whole. opened: the key of a
		-- summary line just opened ("Then: …"); its line and the goals under it
		-- come into sight instead, the line kept at the top when they do not fit.
		function followCurrent(top, opened)
			if not goals.psOver then
				if goals:GetVerticalScroll() ~= 0 then W.ScrollTo(goals, 0) end
				return
			end
			if top then
				Anim.Stop(goals, "value")
				W.ScrollTo(goals, 0)
			end
			local to = goals:GetVerticalScroll()
			for i = 1, opened and area.n or 0 do
				local o = area.items[i]
				if not o.psGoal and o.psKey == opened then
					local y, h, viewH = itemTop(o), area.h[i], goals.psViewH
					for j = i + 1, area.n do
						if not area.items[j].psGoal then break end
						h = h + area.h[j]
					end
					if y + h > to + viewH then to = y + h - viewH end
					if y < to then to = y end
					scrollTo(to, false)
					return
				end
			end
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
		-- or closes the goals it stands for in place. The dungeon line under a
		-- grind (psDungeon, UI.DungeonToast.GrindLine) opens that dungeon's page.
		local function lineClick(self)
			local key = self.psKey
			W.HideTooltip(self)
			if self.psDungeon then
				UI.DungeonToast.GrindOpen(self.psDungeon.key)
				return
			end
			-- "Left out here" (#2634): a quest's fix, or the setting off.
			local item, fix = self.psOutItem, self.psOutFix
			if item then
				if item.fix and item.fix.kind == "chain" then UI.LeftOutGuide(item.fix.quest) end
				return
			end
			if fix then
				ns.Set("behavior.skipGrey", false)
				return
			end
			if self.psRoom then
				UI.ShowQuestRoom("offroute")
				return
			end
			-- A grind step's lines (#2634): the why says only; a quest near here shows its step.
			if self.psInfo then return end
			if self.psNear then
				GF.LookAt(self.psNear[1].step)
				return
			end
			if self.psBack then
				GF.GoLevel(self.psBack)
				return
			end
			if key == "done" then
				model.doneOpen = not model.doneOpen
			else
				model.open[key] = (not model.open[key]) or nil
			end
			GF.Refill(key ~= "done" and model.open[key] and key or nil)
		end

		local function lineEnter(self)
			local tips = {}
			local d = self.psDungeon
			local item = self.psOutItem
			if d then
				local where = {}
				local range = UI.LevelRange(d.minLevel, d.maxLevel)
				if range then where[#where + 1] = string.format(L["Levels %s"], range) end
				if d.zoneName then where[#where + 1] = d.zoneName end
				if #where > 0 then tips[1] = table.concat(where, "  \194\183  ") end
				if d.enemy then tips[#tips + 1] = { d.enemy, Theme.TipColor("warning") } end
				tips[#tips + 1] = { d.take > 0 and L["Click to see its quests in Dungeons"] or L["Click to open it in Dungeons"], Theme.Accent() }
			elseif item then
				tips[1] = item.text
				if item.fix and item.fix.kind == "chain" then
					tips[2] = { L["Click for a guide to it, through what it needs first"], Theme.Accent() }
				end
			elseif self.psOutFix then
				tips[1] = L["Brings back the quests it leaves out. Settings, Automation turns it on again."]
			elseif self.psRoom then
				for i = 1, min(#self.psRoom, 12) do tips[#tips + 1] = self.psRoom[i].title or ("#" .. self.psRoom[i].quest) end
				tips[#tips + 1] = { L["Click to see them, each with an Abandon button"], Theme.Accent() }
			elseif self.psInfo then
				tips[1] = L["Too far below the next quests: the guide has you grind to the level they need. Or do what's around you first."]
			elseif self.psNear then
				for i = 1, #self.psNear do
					local o = self.psNear[i]
					tips[#tips + 1] = o.share < 1 and (o.title .. "  " .. string.format(L["%d%% XP"], floor(o.share * 100 + 0.5))) or o.title
				end
				tips[#tips + 1] = { L["Click to see its step"], Theme.Accent() }
			elseif self.psBack then
				tips[1] = L["This guide stays open in its tab and picks up by itself at that level."]
				tips[2] = { self.psBack.open and L["Click to switch to its tab"] or L["Click to open it in a new tab"], Theme.Accent() }
			elseif self.psOut then
				for i = 1, min(#self.psOut, 12) do
					local o = self.psOut[i]
					tips[#tips + 1] = o.title .. ": " .. o.text
				end
				local open = model.open[self.psKey]
				tips[#tips + 1] = { open and L["Click to fold them away"] or L["Click to list them"], Theme.Accent() }
			else
				local list = self.psGoals
				for i = 1, list and min(#list, 12) or 0 do tips[#tips + 1] = UI.GoalLine(list[i]) end
				local open = (self.psKey == "done" and model.doneOpen) or (self.psKey ~= "done" and model.open[self.psKey])
				tips[#tips + 1] = { open and L["Click to fold them away"] or L["Click to list them"], Theme.Accent() }
			end
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
			-- The off-route line's × (psRoom): a button over its glyph that
			-- closes the line (GF.DismissOffRoute); shown on that line alone.
			l.Close = CreateFrame("Button", nil, l)
			l.Close:SetSize(ICON + 6, lh)
			l.Close:SetPoint("CENTER", l.Icon, "CENTER", 0, 0)
			l.Close:SetScript("OnClick", function() GF.DismissOffRoute() end)
			l.Close:SetScript("OnEnter", function(self)
				W.Color(l.Icon, "text")
				W.Tooltip(self, "ANCHOR_TOP", L["Close"], { L["Hides this line until more quests are off your route."] })
			end)
			l.Close:SetScript("OnLeave", function(self)
				W.Color(l.Icon, "textMuted")
				W.HideTooltip(self)
			end)
			l.Close:Hide()
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
			-- A fold on the hidden card must not resize the step browser.
			if moved and card:IsShown() then fitGoals() end
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
		-- The group mark after the name (UI.StepMark, #3580); its reason in the tooltip.
		local E = Engine()
		local guide = E and E.GetGuide and E.GetGuide()
		local mark, reason = UI.StepMark(view, guide and guide.steps and view and guide.steps[view.index])
		person.Name:SetText(UI.GroupName(view, group) .. (mark and (" " .. UI.StepMarkGlyph(mark)) or ""))
		person.psMark, person.psMarkWhy = mark, reason
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
		GF.ShowMark(person, personMarked(targetOf()))
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
		if self.psMark then
			lines[#lines + 1] = { UI.StepMarkGlyph(self.psMark) .. " " .. self.psMarkWhy, Theme.TipColor(self.psMark == "group" and "warning" or "textDim") }
		end
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

	-- The Up next numbers' column: 22 px, wider when the widest number shown
	-- needs it (step 100 and on, or a raised Up next size), so a number keeps
	-- its size and never reads "1...". It grows to the right, up to 2 px short
	-- of the verb glyph (TEXT_X - 2); every row takes the same width, so the
	-- numbers stay right-aligned with each other. Only a number still wider
	-- than that room (three digits at the largest Up next sizes) is drawn
	-- smaller, through its size factor (GF.numFit), never below 11 px. Its
	-- width and size at the group's own size are measured once per text, Up
	-- next size and font (numNatural), and the smaller size is worked out from them
	-- and rounded down to the half pixel Theme sets, so it is the same on
	-- every render and never half a pixel too wide. -> the width
	local NUM_FLOOR = 11
	local numNatural = setmetatable({}, { __mode = "k" })
	local function naturalOf(n)
		local text, k = n:GetText(), GF.Num(GF.SIZE_KEYS.up)
		local c = numNatural[n]
		-- Kept while the string still has the face, size and outline it was
		-- last given (a look, font or text size change repaints it to another).
		local face, drawn, flags = n:GetFont()
		if c and c.text == text and c.k == k and drawn == c.drawn and face == c.face and flags == c.flags then return c.width, c.size end
		if GF.numFit[n] then
			GF.numFit[n] = nil
			GF.SizeOne(n)
		end
		local measure = n.GetUnboundedStringWidth or n.GetStringWidth
		local size
		face, size, flags = n:GetFont()
		c = { text = text, k = k, width = measure(n) or 0, size = size or NUM_FLOOR, drawn = size, face = face, flags = flags }
		numNatural[n] = c
		return c.width, c.size
	end
	function GF.FitNumColumn(rows, count)
		local room = max(22, (TEXT_X - 2) - (PAD - 10) - 2)
		local widest = 0
		for i = 1, count do
			local n = rows[i].Num
			local natural, full = naturalOf(n)
			local want = 1
			if natural > room and full > 0 then
				local size = math.floor(full * room / natural * 2) / 2
				want = max(size, math.min(full, NUM_FLOOR)) / full
			end
			if want ~= (GF.numFit[n] or 1) then
				GF.numFit[n] = want ~= 1 and want or nil
				GF.SizeOne(n)
			end
			local c = numNatural[n]
			c.face, c.drawn, c.flags = n:GetFont()
			widest = max(widest, natural * want)
		end
		local col = min(max(22, math.ceil(widest) + 1), room)
		for i = 1, count do rows[i].Num:SetWidth(col) end
		return col
	end

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

	-- Whether the window shows part `name` its way (Skin API 2,
	-- hooks.guideShows(name, default)): the skin in use's answer when it is a
	-- boolean, else `default`, Polestar's own choice. Names: "tip" (the step's
	-- tip, default off in compact mode), "done" (finished goals kept in place
	-- as rows, default off: folded into one line), "upnextHead" (Up next's
	-- heading, default on; without it the rows always show), "goalScroll" (the
	-- goals area scrolls past the window's cap, default on), "classCardLater"
	-- (the class quest card on the chain's later steps, default on),
	-- "bannerClose" (a banner notice's ×, default on; the notice's kind follows
	-- `default`), "progressFoot" (the progress bar under the window while the
	-- progress setting is on, default on: off for a skin that shows progress
	-- its own way, guideProgress), "markWash" (the arrow's target row marked
	-- by its light alone in every look, the bar only in the transparent style,
	-- default off: GF.PaintMark), "kitHeader" (the game look's band behind the
	-- step's title, Theme.KitHeader, default on), "ornament" (a look's art in
	-- the guide window's top right corner, Waymark's compass rose, asked by the
	-- look itself through Theme.SkinHookValue; default on).
	function GF.Shows(name, default, ...)
		local ran, v = GF.HookValue("guideShows", name, default, ...)
		if ran and type(v) == "boolean" then return v end
		return default
	end

	---------------------------------------------------------------------------
	-- Along the way: open goals of `along` steps the route has passed
	-- (Engine.GetAlong), under the card until they are done
	---------------------------------------------------------------------------

	local ALONG_MAX = 6

	local function alongRow(i)
		local r = alongRows[i]
		if r then return r end
		r = CreateFrame("Button", nil, along)
		r:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
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
			-- A quest's row (psQuest): a middle-click shows it in the quest log, a shift-click links it in chat (#2545).
			if ns.QuestRowClick and ns.QuestRowClick(self.psQuest, button) then return end
			-- The finished quests no open route hands in (RoutePlan.Carried):
			-- their list, with who takes each and a hand-in guide.
			if self.psCarried then
				if UI.ShowQuestRoom then UI.ShowQuestRoom("carried") end
				return
			end
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
			if self.psCarried then
				lines[#lines + 1] = { L["The route ahead never hands these in. Click to see who takes each, with a guide there."], Theme.Color("textDim") }
			end
			if ns.QuestClickTips then ns.QuestClickTips(self.psQuest, lines) end
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

	-- A guide that is no leveling guide (a class, item or profession guide)
	-- waiting at a `level` goal LEVEL_BACK levels or more above the character
	-- (Brutal Armor's level 29 hold after Ruga's Bulwark at 21) leaves
	-- nothing to do in it until then: the grind lines point back to leveling.
	-- Where: the tab the class quest heads-up opened it from (GF.ClassReturn),
	-- else the first open tab with a leveling guide, else the leveling guide
	-- for the character now (Engine.StartingGuide), for a new tab.
	-- -> { id, title, open (whether it is open in a tab) } | nil
	local LEVEL_BACK = 2
	local function levelingGuide(g) return type(g) == "table" and (g.category == nil or g.category == "Leveling") end
	function GF.LevelBack(guide, goal)
		local E, G = Engine(), ns.Guides
		local want = goal and goal.t == "level" and tonumber(goal.level)
		local lv = (ns.Compat.GetPlayerInfo() or {}).level
		if not (want and lv and want - lv >= LEVEL_BACK and guide and not levelingGuide(guide) and E and E.GetTabs and G and G.Get) then return nil end
		local back = GF.ClassReturn(guide.id)
		if back then return { id = back.id, title = back.title, open = true } end
		for _, t in ipairs(E.GetTabs() or {}) do
			local g = t.guideId ~= guide.id and G.Get(t.guideId)
			if levelingGuide(g) then return { id = g.id, title = t.title or g.title or g.id, open = true } end
		end
		local id = E.StartingGuide and E.StartingGuide()
		local g = id and G.Get(id)
		if not levelingGuide(g) then return nil end
		return { id = g.id, title = g.title or g.id, open = false }
	end

	-- Go to the leveling guide GF.LevelBack named: its tab, else a new one
	-- (Engine.StartGuide, placed by the catch-up). The guide waiting keeps its tab.
	function GF.GoLevel(back)
		local E = Engine()
		if not (back and E) then return end
		for i, t in ipairs(E.GetTabs and E.GetTabs() or {}) do
			if t.guideId == back.id then
				E.SelectTab(i)
				return
			end
		end
		if E.StartGuide then E.StartGuide() end
	end

	-- The end card's lines under its text, for the leveling guide `id` that
	-- ended (Guide complete): "10 quests in your log carry on to later guides"
	-- (Engine.CarriedQuests) and "2 quests aren't part of your route"
	-- (RoutePlan.OffRoute), each only with a count, each opening its list
	-- (UI.ShowQuestRoom "later" / "offroute"). Read when the card is painted,
	-- never on a frame tick.
	function GF.EndQuestLines(id)
		local E, P = Engine(), ns.RoutePlan
		local carried = E and E.CarriedQuests and #E.CarriedQuests(id) or 0
		local off = P and P.OffRoute and P.OffRoute(id)
		local stray = off and #off or 0
		local function line(link, n, text, mode)
			if n == 0 then return end
			W.SetLinkText(link, text)
			link.psAction = function() UI.ShowQuestRoom(mode, id) end
			link:Show()
		end
		line(empty.Carried, carried, carried == 1 and L["1 quest in your log carries on to a later guide"]
			or L["%d quests in your log carry on to later guides"]:format(carried), "later")
		line(empty.Stray, stray, stray == 1 and L["1 quest isn't part of your route"] or L["%d quests aren't part of your route"]:format(stray), "offroute")
	end

	local function setEmpty(kind)
		state = kind
		local E, G = Engine(), ns.Guides
		empty.Primary:Hide()
		empty.Secondary:Hide()
		empty.Carried:Hide()
		empty.Stray:Hide()
		if GF.PlayNext then GF.PlayNext.Hide() end
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
			empty.Text:SetText(L["The community addons are switched off. Turn one on under Settings, Community guides (/polestar packs)."])
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
				GF.PlayNext.Paint(nil, guide.id)
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
				-- Play next: the next guide as a card with one Start (UI/GuideFramePlayNext.lua).
				empty.Text:SetText(string.format(L["%s is done."], "|c" .. Theme.Hex("text") .. UI.GuideLabel(guide) .. "|r"))
				GF.PlayNext.Paint(nextGuide, guide.id)
			else
				empty.Text:SetText(L["Nice work. Pick your next guide to keep going."])
				GF.PlayNext.Paint(nil, guide.id)
			end
			-- A leveling guide's end: the quests left in the log, said.
			if guide and not (back or afterRun) then GF.EndQuestLines(guide.id) end
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
		nav.Skip:SetPoint("RIGHT", (nav.AllSteps:IsShown() and nav.AllSteps) or (nav.Nearby:IsShown() and nav.Nearby) or (nav.Report:IsShown() and nav.Report) or nav.Menu, "LEFT", -2, 0)
	end

	local function navigatorFor(guide, index)
		local E = Engine()
		local count = guide and UI.StepTotal(E) or 0
		if guide then
			-- While the catch-up shows the guides passed whole, the count and title
			-- are its (GF.PlayCatchUp). The numbers leave out the steps hidden
			-- from the character (UI.StepNo, #942).
			if GF.catchingUp ~= "guides" then
				nav.Steps.Count:SetText(string.format("%d / %d", index and UI.StepNo(index, E) or count, count))
				nav.Title:SetText(guide.title or guide.id)
			end
			nav.psMeta = UI.GuideMeta(guide)
			nav.psExperimental = ns.Guides.IsExperimental and ns.Guides.IsExperimental(guide) or nil
		else
			nav.Steps.Count:SetText("")
			nav.Title:SetText(L["Polestar"])
			nav.psMeta, nav.psExperimental = nil, nil
		end
		W.SetIconState(nav.Prev, false, guide ~= nil)
		W.SetIconState(nav.Next, false, guide ~= nil and index ~= nil)
		GF.PaintSkip(guide ~= nil, guide ~= nil and index ~= nil)
		nav.Report:SetShown(guide ~= nil and GF.On("reportButton"))
		nav.Nearby:ClearAllPoints()
		nav.Nearby:SetPoint("RIGHT", nav.Report:IsShown() and nav.Report or nav.Lookup, "LEFT", 0, 0)
		local SL = UI.StepList
		nav.AllSteps:SetShown(guide ~= nil and SL ~= nil and GF.On("allStepsButton"))
		W.SetIconState(nav.AllSteps, SL and SL.On() or false, true)
		nav.AllSteps:ClearAllPoints()
		nav.AllSteps:SetPoint("RIGHT", nav.Nearby:IsShown() and nav.Nearby or nav.Report:IsShown() and nav.Report or nav.Lookup, "LEFT", 0, 0)
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
		-- At least 40 wide at its own size (guideWindow.stepNumberSize), so
		-- the arrows hold still as the number changes.
		local cw = max(floor(nav.Steps.Count:GetStringWidth() + 0.5), floor(40 * GF.Num("stepNumberSize") + 0.5))
		nav.Steps.Count:SetWidth(cw)
		nav.Steps:SetWidth(24 + cw + 24)
	end

	-- The steps before: up to guideWindow.lastSteps (0 to 5, 0 by default:
	-- off) of the steps before the one on screen that the route holds, one
	-- dimmed row each over the step's header, the oldest on top and the
	-- newest right over the step (never more than there are; none in compact
	-- mode). Each says whether it was done or skipped; a click goes back to
	-- it. `E`: what the window draws from (a copy's provider: the preview's
	-- sample step). card.Last holds them: Rows (pooled, GF.LastRow), psCount.
	function GF.LastRow(i)
		local last = card.Last
		local r = last.Rows[i]
		if r then return r end
		r = CreateFrame("Button", nil, last)
		r:SetHeight(UP_ROW)
		W.Hover(r)
		r.Num = GF.SizeAs(T(r, "number", "textMuted"), "up")
		r.Num:SetJustifyH("RIGHT")
		r.Num:SetWidth(22)
		r.Icon = r:CreateTexture(nil, "ARTWORK")
		r.Icon:SetSize(13, 13)
		W.Color(r.Icon, "textMuted")
		r.Text = GF.SizeAs(T(r, "label", "textMuted"), "up")
		r.Text:SetJustifyH("LEFT")
		r.Text:SetWordWrap(false)
		r:SetAlpha(0.7)
		r:SetScript("OnClick", function(self)
			local E = Engine()
			if E and E.Goto and self.psIndex then E.Goto(self.psIndex) end
		end)
		r:SetScript("OnEnter", function(self)
			W.Tooltip(self, tooltipAnchor(), self.psTitle or "", { { L["Click to jump to this step"], Theme.Accent() } })
			GF.HoverIn()
		end)
		r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
		last.Rows[i] = r
		return r
	end

	function GF.FillLast(E, index)
		local last = card.Last
		local want = compact() and 0 or floor(tonumber(ns.Get("guideWindow.lastSteps")) or 0)
		want = max(0, min(5, want))
		-- The steps, newest first, then drawn oldest first.
		local found, views = {}, {}
		if want > 0 and type(index) == "number" then
			for s = index - 1, 1, -1 do
				local sv = E.GetStepView(s)
				if sv and sv.status ~= "na" and not sv.along and not UI.StepHidden(s, E) then
					local k = #found + 1
					found[k], views[k] = s, sv
					if #found >= want then break end
				end
			end
		end
		local n = #found
		for i = 1, n do
			local s, v, r = found[n + 1 - i], views[n + 1 - i], GF.LastRow(i)
			local skipped = v.skipped or v.status == "skipped"
			r.psIndex, r.psView = s, v
			r.psStatus = skipped and "skipped" or v.status
			r.psSummary = UI.StepSummary(v)
			r.psTitle = v.title or r.psSummary
			r.Num:SetText(UI.StepNo(s, E))
			r.Icon:SetTexture(Theme.VerbIcon(UI.FirstVerb(v)))
			local text = r.psSummary
			if skipped then text = text .. "  |c" .. Theme.Hex("textMuted") .. L["skipped"] .. "|r" end
			r.Text:SetText(text)
			W.Color(r.Text, "textMuted")
			r:Show()
		end
		for i = n + 1, #last.Rows do
			local r = last.Rows[i]
			r.psIndex, r.psView, r.psStatus, r.psSummary, r.psTitle = nil, nil, nil, nil, nil
			r:Hide()
		end
		last.psCount = n
		last:SetShown(n > 0)
	end

	local function fillUpcoming(E, index)
		for i = 1, #upRows do upRows[i]:Hide() end
		local want = compact() and 0 or (ns.Get("ui.upcoming") or 0)
		-- Without its heading (GF.Shows "upnextHead"), Up next's rows always show.
		local rowsShown = upcomingOpen() or not GF.Shows("upnextHead", true)
		local n, count = 0, E.GetStepCount and E.GetStepCount() or 0
		local i = index + 1
		while n < want and i <= count do
			local v = E.GetStepView(i, true)
			if v and v.status ~= "na" and not v.along and not UI.StepHidden(i, E) then
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
				r.Num:SetText(UI.StepNo(i, E))
				r.Icon:SetTexture(Theme.VerbIcon(UI.FirstVerb(v)))
				r.Text:SetText(r.psSummary)
				W.Color(r.Text, warn and "warning" or "textDim")
				r:SetShown(rowsShown)
				-- The skin in use's touch on the row (Skin API 2,
				-- hooks.guideUpRow(row, view, index)).
				GF.Hook("guideUpRow", r, v, i)
			end
			i = i + 1
		end
		upnext.psCount = n
		GF.FitNumColumn(upRows, n)
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
		-- Past this step's people: the next step's, said as "Next step:".
		local count = E.GetStepCount and E.GetStepCount() or 0
		for s = index + 1, count do
			local v = E.GetStepView(s, true)
			-- An along step never holds the route: "Then:" names the next step that does.
			if v and v.status ~= "na" and not v.along and not UI.StepHidden(s, E) then
				local gs, f = UI.StepGroups(v)
				local g = gs[f or 1] or gs[1]
				if g then return UI.GroupName(v, g), g.kind, true end
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
	-- ALONG_MAX rows, hidden in the compact window unless the skin keeps them
	-- (GF.Shows "along": Still to do among them). A goal the step on screen
	-- lists itself (the same quest objective, or the same kill or item for the
	-- same quest) is not said twice. An objective that several along steps or a
	-- pinned quest list with the same count is one row: the first, which takes a
	-- later one's pin, and its step, goal and place when it has no place itself.
	-- When every row is of `along until` steps ending at one step, the heading
	-- says so: "Along the way, until step 30" (#942: an along step has no card
	-- of its own).
	local function fillAlong(E)
		for i = 1, #alongRows do alongRows[i]:Hide() end
		if not GF.Shows("along", not compact()) or not E.GetAlong then
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
		-- Still to do (both kinds below) unless turned off (guideWindow.stillToDo,
		-- #3303); the finished ones stay in the menu's Hand in finished quests.
		local stillToDo = GF.On("stillToDo")
		-- First the quests an update left behind the player (Engine.GetBehind):
		-- "Still to do: <quest>, back in <zone>, 240 yd".
		local back = 0
		for _, b in ipairs(stillToDo and E.GetBehind and E.GetBehind() or {}) do
			if n < ALONG_MAX then
				n, back = n + 1, back + 1
				local r = alongRow(n)
				local where = b.zone and (b.yards and string.format(L["back in %s, %s"], b.zone, ns.FormatDistance(b.yards)) or string.format(L["back in %s"], b.zone)) or nil
				local quest = ns.Quoted(b.title or (L["Quest"] .. " " .. b.quest))
				r.psStep, r.psGoal, r.psTitle, r.psPin, r.psBehind, r.psQuest = nil, nil, b.title, nil, b.quest, b.quest
				r.psPlace, r.psCarried = true, nil
				-- Its facts, for a layout that lays the row out its own way.
				r.psFacts = { quest = quest, zone = b.zone, yards = b.yards }
				r.Icon:SetTexture(Theme.VerbIcon("turnin"))
				r.Text:SetText(where and string.format(L["Still to do: %s, %s"], quest, where) or string.format(L["Still to do: %s"], quest))
				r:Show()
			end
		end
		-- Then, in one row, the finished quests no open route hands in
		-- (RoutePlan.Carried): "3 finished quests to hand in elsewhere (410 XP)";
		-- a click lists them (UI/QuestRoom.lua, "carried"). The player's own
		-- quest log: the live window's row only.
		local carried = stillToDo and GF.live and ns.RoutePlan and ns.RoutePlan.Carried()
		if carried and #carried > 0 and n < ALONG_MAX then
			n, back = n + 1, back + 1
			local r, xp = alongRow(n), 0
			for _, c in ipairs(carried) do xp = xp + (c.xp or 0) end
			r.psStep, r.psGoal, r.psTitle, r.psPin, r.psBehind, r.psQuest = nil, nil, L["Finished quests you're still carrying"], nil, nil, nil
			r.psPlace, r.psCarried = nil, true
			r.Icon:SetTexture(Theme.VerbIcon("turnin"))
			local text = #carried == 1 and L["1 finished quest to hand in elsewhere"] or string.format(L["%d finished quests to hand in elsewhere"], #carried)
			r.psFacts = { text = text, count = #carried, xp = xp > 0 and xp or nil }
			r.Text:SetText(xp > 0 and string.format(L["%s (%s XP)"], text, ns.Thousands(xp)) or text)
			r:Show()
		end
		local list, byKey = {}, {}
		for _, s in ipairs(E.GetAlong()) do
			for _, gv in ipairs(s.goals) do
				local a, b = alongKeys(gv)
				if not ((a and inStep[a]) or (b and inStep[b])) then
					local key = a or b
					key = key and (key .. ":" .. (gv.progress and gv.progress.max or "")) or nil
					local place = gv.map and gv.x and gv.y and true or nil
					local kept = key and byKey[key]
					if kept then
						kept.pin = kept.pin or s.pin
						if place and not kept.place then
							kept.gv, kept.step, kept.place = gv, gv.step or s.index, place
						end
					else
						kept = { s = s, gv = gv, step = gv.step or s.index, place = place, pin = s.pin }
						list[#list + 1] = kept
						if key then byKey[key] = kept end
					end
				end
			end
		end
		for _, e in ipairs(list) do
			if n < ALONG_MAX then
				local s, gv = e.s, e.gv
				n = n + 1
				if not s.untilStep or (untilStep and untilStep ~= s.untilStep) then mixed = true end
				untilStep = untilStep or s.untilStep
				local r = alongRow(n)
				r.psStep, r.psGoal, r.psTitle, r.psPin, r.psBehind, r.psQuest = e.step, gv.index, s.title or UI.GoalLine(gv), e.pin, nil, gv.quest
				r.psPlace, r.psCarried, r.psFacts = e.place, nil, nil
				r.Icon:SetTexture(Theme.VerbIcon(gv.t))
				UI.SetCounted(r.Text, UI.GoalLine(gv))
				r:Show()
			end
		end
		along.Label:SetText(back == n and L["Still to do"] or (untilStep and not mixed) and string.format(L["Along the way, until step %d"], UI.StepNo(untilStep, E)) or L["Along the way"])
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
		local name, kind, later = nextOf(E, index, groups, focus)
		if name and name ~= "" then
			local hex = Theme.Hex(kind == "npc" and "npc" or (kind == "object" and "object" or "textDim"))
			-- "Then:" is this step's next person (as the Then rows say it); a
			-- later step's is "Next step:".
			after.Text:SetText((later and L["Next step:"] or L["Then:"]) .. " |c" .. hex .. name .. "|r")
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
	-- nothing else shows, since the header already says it; never one the skin
	-- in use shows on a card of its own (Skin API 2, hooks.guideTakes(goal):
	-- true takes it out of the window's list).
	-- -> rows (goal views), the hidden header goal
	local function shownGoals(v, group)
		local list, others = {}, 0
		for _, gi in ipairs(group.goals or {}) do
			local goal = v.goals[gi]
			local ran, taken
			if goal then ran, taken = GF.HookValue("guideTakes", goal) end
			if goal and goal.status ~= "na" and not goal.folded and not (ran and taken == true) then
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
		-- A class quest's accept reads inside the class card (UI/ClassCard.lua;
		-- the live window's alone).
		local CC, E = GF.live and UI.ClassCard or nil, Engine()
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

	-- Paint a summary line: `icon` a verb glyph, "check" or "icon-dungeon"; `list`
	-- the goals its tooltip names; `open` whether its goals are listed under
	-- it. The dungeon line (key "dungeon") is a link: its chevron points on.
	local function paintLine(l, key, icon, iconColor, text, list, title, open)
		l.psKey, l.psGoals, l.psTitle, l.psDungeon = key, list, title, nil
		l.psOut, l.psOutItem, l.psOutFix, l.psRoom, l.psInfo, l.psNear, l.psBack = nil, nil, nil, nil, nil, nil, nil
		if l.Close then l.Close:Hide() end
		l.Icon:SetTexture((icon == "check" or icon == "icon-dungeon" or icon == "skip" or icon == "cross") and Theme.Media(icon) or Theme.VerbIcon(icon))
		W.Color(l.Icon, iconColor)
		l.Text:SetText(text)
		if l ~= fold.glow then W.Color(l.Text, "textDim") end
		l.Chevron:SetTexture(Theme.Media(key == "dungeon" and "chevron-right" or open and "chevron-up" or "chevron-down"))
		l.Chevron:Show()
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
		local E = Engine()
		-- A profession guide's section: its skill range as the heading over the
		-- step ("First Aid 1-40"), in the accent colour while the player's skill
		-- is in it (Engine.GetSection).
		local sv = view.section
		card.Section:SetText(sv and sv.title or "")
		if sv then W.Color(card.Section, sv.state == "current" and "accent" or "textDim") end
		card.Section:SetShown(sv ~= nil)
		person:Show()
		-- A class quest's step: the class card, its colour on the step's quest
		-- names (the live window's alone).
		local CC = GF.live and UI.ClassCard or nil
		local guide = E.GetGuide and E.GetGuide()
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
			GF.ShowMark(r, goal.status ~= "done" and goal.status ~= "skipped" and isTarget(goal, t) and not person.Mark:IsShown())
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
		-- Under an open goal that grinds to a level, on the live window's current
		-- step: why (#2634, Engine.GrindHint: "You're 30: the quests after this
		-- are level 32-35") and what else there is: this guide's quests still
		-- worth doing near the player (a click shows the first one's step), and
		-- a dungeon at the character's level, one line that opens its page
		-- (UI.DungeonToast.GrindLine, worked out once per step and level).
		local function addGrind(goal)
			if goal.t ~= "level" or not GF.live then return end
			local h = goal.status ~= "done" and GF.On("leftOut") and E.GrindHint and E.GrindHint(view.index)
			if h then
				local lv = (ns.Compat.GetPlayerInfo() or {}).level
				if h.lo and lv then
					local l = addLine("grindWhy", "level", "textDim", string.format(L["You're %d: the quests after this are level %s"], lv, UI.LevelRange(h.lo, h.hi)), nil, nil, false)
					l.psInfo = true
					l.Chevron:Hide()
				end
				if #h.nearby > 0 then
					local names = {}
					for k, o in ipairs(h.nearby) do names[k] = o.title end
					local l = addLine("grindNear", "accept", "textDim", string.format(L["Worth doing near here: %s"], table.concat(names, ", ")), nil, nil, false)
					l.psNear = h.nearby
					l.Chevron:SetTexture(Theme.Media("chevron-right"))
				end
			end
			-- A class, item or profession guide waiting levels ahead: level with
			-- the leveling guide meanwhile; this one keeps its tab (GF.LevelBack).
			local back = goal.status ~= "done" and step and GF.LevelBack(guide, step.goals[goal.index])
			if back then
				local l = addLine("grindBack", "level", "textDim", string.format(L["Level with %s meanwhile: this guide picks up at level %d"], back.title, tonumber(step.goals[goal.index].level)), nil, nil, false)
				l.psBack = back
				l.Chevron:SetTexture(Theme.Media("chevron-right"))
			end
			local DT = UI.DungeonToast
			local d = DT and DT.GrindLine and DT.GrindLine(guide, view, goal)
			if not d then return end
			local l = addLine("dungeon", "icon-dungeon", "dungeon", d.text, nil, d.name, false)
			l.psDungeon = d
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
				addGrind(goal)
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
			-- A skin may keep them in place as rows, no line (GF.Shows "done").
			local inPlace = GF.Shows("done", false)
			fold.serial = fold.serial + 1
			local list = mineBefore
			for _, goal in ipairs(goalsOf(g)) do list[#list + 1] = goal end
			for _, goal in ipairs(mineAfter) do list[#list + 1] = goal end
			local kept, doneList, first = {}, {}, nil
			for i, goal in ipairs(list) do
				local gi = goal.index
				local rec = fold.of[gi]
				if goal.status == "done" then
					if not rec and not model.folded[gi] and not inPlace then
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
			if (done > 0 or first) and not inPlace then
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
					addGrind(goal)
				elseif k then
					addRow(goal, nil, false, k)
				elseif model.doneOpen or inPlace then
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
		-- What the route leaves out here (#2634, Engine.LeftOutHere): one dim
		-- line, "N left out here", on the live window with guideWindow.leftOut
		-- on. Opened, a line per quest with why; a quest that needs another
		-- first opens a guide to it (UI.LeftOutGuide), and "Turn off Skip grey
		-- quests" brings back the low ones.
		local outList = GF.live and GF.On("leftOut") and E.LeftOutHere and E.LeftOutHere(view.index) or nil
		if outList and #outList > 0 then
			local open = model.open.leftOut
			local l = addLine("leftOut", "skip", "textMuted", string.format(L["%d left out here"], #outList), nil, L["Left out here"], open)
			l.psOut = outList
			if open then
				local grey = false
				for k, o in ipairs(outList) do
					local chain = o.fix and o.fix.kind == "chain"
					local text = "|c" .. Theme.Hex("text") .. o.title .. "|r" .. DOT .. o.text
					if chain then text = text .. DOT .. "|c" .. Theme.Hex("accent") .. L["Guide me"] .. "|r" end
					local il = addLine("leftOut" .. k, "accept", "textMuted", text, nil, o.title, false)
					il.psOutItem = o
					il.Chevron:SetTexture(Theme.Media("chevron-right"))
					il.Chevron:SetShown(chain)
					grey = grey or (o.fix ~= nil and o.fix.kind == "skipGrey")
				end
				if grey then
					local fl = addLine("leftOutFix", "skip", "accent", "|c" .. Theme.Hex("accent") .. L["Turn off Skip grey quests"] .. "|r", nil, L["Skip grey quests"], false)
					fl.psOutFix = true
					fl.Chevron:SetTexture(Theme.Media("chevron-right"))
				end
			end
		end
		-- The cleanup nudge (#2634): with OFF_ROUTE_NUDGE or more quests in the
		-- log that no guide of the route uses (RoutePlan.OffRoute), one dim
		-- line that opens them with an Abandon button each (UI.ShowQuestRoom
		-- "offroute"). Worked out when the step changes, not on every refill.
		if GF.live and GF.On("leftOut") then
			if not sameFocus or model.offRoute == nil then
				local P = ns.RoutePlan
				model.offRoute = P and P.OffRoute and P.OffRoute() or false
			end
			local off = model.offRoute
			if off and #off >= GF.OFF_ROUTE_NUDGE and #off > (GF.offRouteClosed or 0) then
				local l = addLine("offRoute", "cross", "textMuted", string.format(L["%d quests aren't part of your route"], #off), nil, L["Clean up quest log (%d)"]:format(#off), false)
				l.psRoom = off
				l.Chevron:SetTexture(Theme.Media("chevron-right"))
				if l.Close then l.Close:Show() end
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
		local shown = ns.Get("ui.showNotes") and GF.Shows("tip", not compact()) or false
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
		local tl = GF.TabsOf(E)
		strip.psHasTabs = tl ~= nil
		strip.psTabN = tl and #tl or 0
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
			local sv = E.GetStepView(k.step, true)
			if not (sv and sv.skipped) then GF.notices.stepSkip = nil end
		end
		local v = index and E.GetStepView(index, true)
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
		GF.FillLast(E, index)
		showSteps(true)
		GF.Layout()
		followCurrent(focusChanged)
		GF.PaintProgress(shownGuide == guide.id)
		if focusChanged and GF.live and F:IsVisible() and not GF.catchingUp and GF.On("stepAnim") then
			-- The next person (or step) slides up 6px into place as it fades in
			-- (guideWindow.stepAnim, at guideWindow.animSpeed). A copy shows its
			-- step as it stands: nobody moved to it.
			Anim.To(card, "alpha", 0, 1, GF.Dur(Anim.BASE), "out")
			Anim.To(card, "offset", -6, 0, GF.Dur(Anim.BASE), "out")
		end
		-- A class chain's card, the first time it shows: its shine and chime.
		if GF.live and F:IsVisible() and not GF.catchingUp and UI.ClassCard then UI.ClassCard.Celebrate() end
		shownIndex, shownGuide, shownFocus = index, guide.id, focus
	end

	-- Render, then a skin's own (Skin API 2, hooks.guideRender(view, parts)):
	-- the step on screen, nil when there is none.
	function GF.Render()
		render()
		if F then GF.Hook("guideRender", state == "steps" and view or nil, GF.SkinParts()) end
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
		local v = E.GetStepView(index, true)
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
	-- a fold that landed. opened: the key of the line just opened, brought
	-- into sight with its goals.
	-- The off-route line's ×: closes it until more quests are off the route.
	function GF.DismissOffRoute()
		local off = model and model.offRoute
		GF.offRouteClosed = type(off) == "table" and #off or math.huge
		GF.Refill()
	end

	function GF.Refill(opened)
		if not F or state ~= "steps" or not view then return end
		fillCard(true)
		GF.Layout()
		followCurrent(false, opened)
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
		GF.ShowMark(person, personMarked(t))
		for i = 1, #rows do
			local r = rows[i]
			if r:IsShown() and r.psGoal then
				GF.ShowMark(r, r.psGoal.status ~= "done" and r.psGoal.status ~= "skipped" and isTarget(r.psGoal, t) and not person.Mark:IsShown())
			end
		end
	end

	-- The window's sizes as the skin and the player's settings make them now,
	-- for the settings window's preset pictures (UI/Looks/GuideWindow.lua),
	-- drawn by the same numbers.
	function GF.Metrics()
		readMetrics()
		return { pad = PAD, tabH = TAB_H, navH = NAV_H, progH = PROG_H, icon = ICON, textX = TEXT_X, rowMin = ROW_MIN,
			check = CHECK, rowPad = ROW_PAD, checkIn = CHECK_IN, upRow = UP_ROW, upToggle = UP_TOGGLE, glyphY = GF.GlyphY(), lineH = CARD.lineH }
	end

	---------------------------------------------------------------------------
	-- Build
	---------------------------------------------------------------------------

	-- A part that takes the pointer keeps the window's hover look (GF.HoverIn);
	-- the bars and the foot move the window. A copy takes neither: its frame
	-- alone sees the pointer, for that look.
	local function hoverable(frame)
		if GF.live then frame:HookScript("OnEnter", function() GF.HoverIn() end) end
		return frame
	end

	local function draggable(frame)
		if not GF.live then return frame end
		ns.DragWindow(frame, F, { locked = function() return ns.Get("ui.locked") end, onStop = function() GF.DragStop() end })
		return hoverable(frame)
	end

	local function build()
		readMetrics()
		handOver()
		F = CreateFrame("Frame", GF.live and "PolestarGuideFrame" or nil, GF.live and ns.UIParent or GF.parent)
		-- Its text follows the guide window's own size (Guide window > Window),
		-- the live window's and every copy's (the settings' preview).
		Theme.TextScope(F, "ui.guideTextSize")
		if GF.live then
			F:SetFrameStrata("MEDIUM")
			-- Above the game's action bars, whole (#2753): at UIParent's level
			-- its rows drew between the bars' buttons. Raised before it has
			-- parts, which take their levels from it, and one more for its
			-- shadow, a level under it (Theme.lua shadowFor); the target
			-- list's rows, made later, raise over it in turn (QoL/Buttons.lua
			-- newRow).
			F:Raise()
			F:SetFrameLevel(F:GetFrameLevel() + 1)
			F:SetClampedToScreen(true)
			F:SetMovable(true)
			F:EnableMouse(true)
		else
			-- The pointer's hover, never a click (GF.MouseOff keeps it so).
			F:EnableMouse(true)
			if F.SetMouseClickEnabled then F:SetMouseClickEnabled(false) end
		end
		F:SetSize(ns.Get("ui.width") or 340, 200)
		-- The guide window's own frame in the game's looks from its first paint
		-- (Theme/Looks/GameSkins.lua GUIDE): painted before the flag, it took
		-- the big windows' title bar and drag strip, which lay over the card above
		-- it (#1802). psGuideWindow: this window itself, live or a copy, not a
		-- card painted as it (a skin may dress the two apart).
		F.psGuide, F.psGuideWindow = true, true
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
		nav.Steps.Count = GF.SizeAs(T(nav.Steps, "number", "text"), "count")
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
		-- All steps: opens and closes the step browser (UI/StepList.lua), lit
		-- while it is open; left of Nearby (guideWindow.allStepsButton).
		nav.AllSteps = W.IconButton(nav, "layers", 24, L["All steps"], function()
			if UI.StepList then UI.StepList.Toggle() end
		end)
		nav.AllSteps.psTipLines = { L["Every step of the guide in one list. Click one to look at it."] }
		nav.AllSteps:SetPoint("RIGHT", nav.Nearby, "LEFT", 0, 0)
		nav.AllSteps:Hide()
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
			if nav.psExperimental then lines[#lines + 1] = { L["Experimental"], Theme.Color("experimental") } end
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
		for _, b in ipairs({ nav.Menu, nav.Lookup, nav.Report, nav.Nearby, nav.AllSteps, nav.Next, nav.Prev, nav.Skip }) do hoverable(b) end
		-- Transparent chrome: the step number fades with its chevrons (nav.Steps
		-- holds all three) and the title with them; a lone "3 / 8" over the world
		-- would read as a stray number. Progress stays readable in the foot.
		for _, c in ipairs({ nav.Menu, nav.Lookup, nav.Report, nav.Nearby, nav.AllSteps, nav.Skip, nav.Steps, nav.Title }) do chrome[#chrome + 1] = c end

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
		-- A profession guide's skill-range heading over the person (fillCard).
		card.Section = T(card, "label", "accent")
		card.Section:SetJustifyH("LEFT")
		card.Section:SetWordWrap(false)
		card.Section:Hide()
		-- The steps before, over the header (GF.FillLast, layoutCard).
		card.Last = CreateFrame("Frame", nil, card)
		card.Last.Rows = {}
		card.Last.psCount = 0
		card.Last:Hide()
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
		-- A line longer than the row takes a second one, the row growing by it
		-- (GF.XPHeight); past two it cuts with "...", and the hover shows all of it.
		xp.Text:SetPoint("RIGHT", xp, "RIGHT", -PAD, 0)
		xp.Text:SetJustifyH("LEFT")
		xp.Text:SetWordWrap(true)
		xp.Text:SetMaxLines(2)
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
		-- Tinted by the notice's kind (GF.LayoutBanner: banner.psRole), not the accent.
		banner.Fill.psPaint = function(t) local r, g, b = Theme.Color(banner.psRole or "textDim"); t:SetVertexColor(r, g, b, 0.1) end
		W.Painter(banner.Fill, banner.Fill.psPaint)
		banner.Rule = W.Divider(banner)
		banner.Rule:SetPoint("BOTTOMLEFT", banner, "BOTTOMLEFT", 0, 0)
		banner.Rule:SetPoint("BOTTOMRIGHT", banner, "BOTTOMRIGHT", 0, 0)
		banner.Icon = W.Tex(banner, "ARTWORK", "icon-level", "textDim")
		banner.Icon:SetSize(13, 13)
		banner.Icon:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD, -10)
		banner.Text = T(banner, "label", "text")
		banner.Text:SetWordWrap(true)
		banner.Text:SetJustifyV("TOP")
		banner.Text:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD + 21, -9)
		-- A notice that names an item (a gear upgrade, a spare bag, the junk to delete): its text shows
		-- the game's tooltip for that copy on hover, and a modified click links it or tries it on (#2826).
		banner.Item = CreateFrame("Button", nil, banner)
		banner.Item:SetPoint("TOPLEFT", banner.Text, "TOPLEFT", 0, 0)
		banner.Item:SetPoint("BOTTOMRIGHT", banner.Text, "BOTTOMRIGHT", 0, 0)
		banner.Item:SetScript("OnEnter", function(self) W.ItemTip(self, self.psItem); GF.HoverIn() end)
		banner.Item:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
		banner.Item:SetScript("OnClick", function(self) W.ItemClick(self.psItem) end)
		banner.Item:Hide()
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
		-- A finished leveling guide's quests left in the log (GF.EndQuestLines):
		-- links in the accent under the text, each opening its list.
		empty.Carried = W.Link(empty, "", act, { role = "note" })
		empty.Carried.psTip = L["A later guide of your route hands these in: keep them. Click to see each with its guide."]
		empty.Carried:Hide()
		empty.Stray = W.Link(empty, "", act, { role = "note" })
		empty.Stray.psTip = L["No guide of your route takes, works or hands these in. Click to see them and keep or abandon each."]
		empty.Stray:Hide()

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
			goals = goals, last = card.Last,
		}
		GF.chrome = chrome
		-- The parts a skin's hooks get (Skin API 2; Theme.GuideParts hands out
		-- the live window's): this window's, its frame and goal rows with them.
		local skinParts = { window = F, rows = rows }
		-- Marks a guide window's frame: a layout tells its own pieces by the
		-- window they sit in.
		F.psGuideWindow = true
		for k, v in pairs(GF.parts) do skinParts[k] = v end
		function GF.SkinParts() return skinParts end
		handOver()

		-- The rest is the live window's: a copy's host draws it (GF.Draw), and
		-- it is no one's to hide, name targets on or follow the theme for.
		if not GF.live then return end
		F:SetScript("OnShow", function()
			GF.UpdateXP()
			GF.Render()
		end)
		-- Another addon taking the window out of sight is told once
		-- (ns.WatchSight). After the OnShow above: SetScript drops a hooked script.
		ns.WatchSight(F, "window")
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
		-- Drawn anew after a full refresh; a live repaint (a slider dragged)
		-- recolours its parts where they stand (W.Color).
		Theme.OnChanged(function() if ns.IsLoggedIn() then GF.Render() end end, true)
	end

	---------------------------------------------------------------------------
	-- The catch-up, flights
	---------------------------------------------------------------------------

	-- A hidden window does no work: its OnShow renders it afresh.
	local function whenReady(fn)
		return function(...)
			if F and F:IsShown() and ns.IsLoggedIn() then fn(...) end
		end
	end

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
				if i ~= shown and not UI.StepHidden(i, Engine()) then
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

	-- A flight begins or ends (guideWindow.hideTaxi): the client says the
	-- player is on a taxi a moment after control is lost, so look again then.
	function GF.TaxiChanged()
		if not ns.Get("guideWindow.hideTaxi") then return end
		GF.ApplyVisibility()
		ns.After(0.5, GF.ApplyVisibility)
	end

	---------------------------------------------------------------------------
	-- Wiring: the live window's (a copy hears nothing; its host draws it)
	---------------------------------------------------------------------------

	if GF.live then
		ns.OnInit(function()
			build()
			GF.ApplyAll()
		end)

		ns.On("GUIDE_CHANGED", whenReady(GF.Render))
		ns.On("STEP_CHANGED", whenReady(GF.Render))
		ns.On("STEP_UPDATED", whenReady(GF.Update))
		ns.On("PARTY_PROGRESS", whenReady(GF.Update))
		-- The finished quests to hand in elsewhere changed off the step (RoutePlan, #3568): the row follows.
		ns.On("CARRIED_CHANGED", whenReady(GF.Update))
		-- A finished guide's card counts the quests in the log (GF.EndQuestLines):
		-- one taken, handed in or abandoned paints it afresh. Only on that card.
		ns.RegisterEvent("QUEST_LOG_UPDATE", function()
			if state == "complete" and F and F:IsShown() and ns.IsLoggedIn() then GF.Render() end
		end)
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
		-- strip itself comes or goes (compact mode shows it from two tabs); a
		-- step change already laid it out (Render).
		ns.On("TABS_CHANGED", whenReady(function()
			local tl = GF.TabsOf(Engine())
			local has, was = tl ~= nil, GF.StripShown()
			strip.psTabN = tl and #tl or 0
			if has ~= strip.psHasTabs or was ~= GF.StripShown() then
				strip.psHasTabs = has
				GF.Layout()
			else
				GF.RenderTabStyle()
			end
		end))

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

		ns.RegisterEvent("PLAYER_CONTROL_LOST", function() GF.TaxiChanged() end)
		ns.RegisterEvent("PLAYER_CONTROL_GAINED", function() GF.TaxiChanged() end)
	end
	-- A copy builds its window once every part is in (GF.Copy); the live
	-- window, at init.
	if not GF.live then GF.Build = build end

	-- For the other GuideFrame*.lua files, which take these as their own locals
	-- when they load (GF.Bind hands over the parts and sizes).
	GF.Engine, GF.Derived, GF.Compact, GF.Transparent, GF.PlaceCheck = Engine, Derived, compact, transparent, placeCheck
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
end)
