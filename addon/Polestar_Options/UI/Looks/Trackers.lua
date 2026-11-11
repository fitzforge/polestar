-- Trackers: the options page for how Polestar's small always-there panels
-- look and when they show (Options > Look > Trackers, key `trackers`), and
-- its pinned previews. The trackers' look itself is core (Polestar/UI/Trackers.lua,
-- UI.Trackers); this file is part of the settings window's addon.
--
--   UI.Trackers.Preview(view, tab)   the options' pinned preview (sandbox trackers with made-up values)

local ns = Polestar
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, format, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, string.format, type, ipairs, pairs, tonumber

local TR = UI.Trackers
local NEW = "0.3.8"
local FADED = TR.FADED
local num = TR.Num

-- A trackers setting changed: the stages repaint (now when shown, else when
-- they show); the trackers themselves follow in UI.Trackers.
local stages = setmetatable({}, { __mode = "k" })
ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "trackers" and path:sub(1, 9) ~= "trackers." then return end
	for s in pairs(stages) do
		if s:IsVisible() then s:Refresh() else s.psDirty = true end
	end
end)

---------------------------------------------------------------------------
-- Previews: the trackers' own builders, made-up values, no events
---------------------------------------------------------------------------

local BAR_W = 360

local function demoParty()
	return {
		{ name = L["Aelindra"], class = "PRIEST", level = 23, xp = 64, step = format(L["Step %d"], 41) .. "  \194\183  " .. L["The Defias Brotherhood"] },
		{ name = L["Brogan"], class = "WARRIOR", level = 22, xp = 12, step = format(L["Step %d"], 39),
			needs = { { what = L["Defias Bandana"], cur = 6, max = 10 } } },
		{ name = L["Kesh"], class = "MAGE", level = 23, xp = 88, otherGuide = true, far = true },
	}
end

local BUILD = {
	flight = function(parent)
		local M = ns.Maps
		if not (M and M.NewFlightTimer) then return nil end
		local f = M.NewFlightTimer(parent)
		f.Fill = function(self) M.FillFlightTimer(self, L["Sentinel Hill"], 74, 0.62) end
		return f
	end,
	instances = function(parent)
		local M = ns.Maps
		if not (M and M.NewInstanceTracker) then return nil end
		local f = M.NewInstanceTracker(parent)
		f.Fill = function(self)
			local now = ns.Compat and ns.Compat.Now and ns.Compat.Now() or 0
			M.FillInstanceTracker(self, { inHour = 3, perHour = 5, inDay = 3, perDay = 30, wait = 0, clears = 1530, now = now,
				run = { name = L["The Deadmines"], time = 1520, xp = 18450 } })
		end
		return f
	end,
	party = function(parent)
		local PP = UI.PartyPanel
		if not (PP and PP.NewPanel) then return nil end
		local f = PP.NewPanel(parent)
		f.Fill = function(self) PP.FillRows(self, demoParty()) end
		return f
	end,
}

-- The game's XP bar, drawn plainly, with the guide's real mark on it, in
-- stage s. -> { bar, mark, Layout(width), Refresh(), Place(y) }
local function xpBar(s)
	local Mk = ns.QoL and ns.QoL.XPMark
	local x = {}
	local bar = CreateFrame("Frame", nil, s)
	bar:SetSize(BAR_W, 12)
	local track = bar:CreateTexture(nil, "BACKGROUND")
	track:SetTexture(Theme.Media("white"))
	track:SetAllPoints(bar)
	track:SetVertexColor(0.08, 0.06, 0.1, 0.9)
	local fill = bar:CreateTexture(nil, "ARTWORK")
	fill:SetTexture(Theme.Media("white"))
	fill:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
	fill:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 0, 0)
	fill:SetVertexColor(0.58, 0.0, 0.55, 1) -- the game's XP purple
	local rested = bar:CreateTexture(nil, "BORDER")
	rested:SetTexture(Theme.Media("white"))
	rested:SetPoint("TOPLEFT", fill, "TOPRIGHT", 0, 0)
	rested:SetPoint("BOTTOMLEFT", fill, "BOTTOMRIGHT", 0, 0)
	rested:SetVertexColor(0.0, 0.39, 0.88, 0.5)
	local mark = Mk and Mk.NewDemo and Mk.NewDemo(bar)
	x.bar, x.mark = bar, mark
	if mark then
		UI.Toasts.Hot(s, mark.Tick, "trackers.xp.tickWidth")
		UI.Toasts.Hot(s, mark.Label, "trackers.xp.labelSize")
	end
	function x.Layout(width)
		bar:SetWidth(min(BAR_W, width - 60))
		fill:SetWidth(bar:GetWidth() * 0.58)
		rested:SetWidth(bar:GetWidth() * 0.12)
	end
	function x.Refresh()
		if mark then Mk.FillDemo(mark, Mk.Label(12, 14), nil) end
	end
	function x.Place(y)
		bar:ClearAllPoints()
		bar:SetPoint("CENTER", s, "CENTER", 0, y)
	end
	return x
end

-- One tracker's stage: the sandbox tracker, fitted; the instance tracker's
-- tab shows the XP bar with the guide's mark under it (both its tab's).
local HEIGHT = { flight = 130, instances = 200, party = 260 }

local function trackerStage(view, kind)
	local TS = UI.Toasts
	local s = TS.NewStage(view, HEIGHT[kind])
	stages[s] = true
	local f = BUILD[kind] and BUILD[kind](s)
	s.Tracker = f
	local xp = kind == "instances" and xpBar(s) or nil
	s.XP = xp
	function s:Refresh()
		if not f then return end
		f.psFit = nil
		TR.ApplyLook(f)
		f:Fill()
		TS.FitInto(self, f, f:GetWidth(), f:GetHeight(), num(kind, "scale", 0.4, 2.5))
		f:SetAlpha(num(kind, "alpha", 0.1, 1))
		if xp then
			-- The tracker over the bar: up by a third of the room under the chrome.
			local k = f:GetScale()
			Anim.Anchor(f, "CENTER", self, "CENTER", 0, 26 / k)
			xp.Refresh()
			xp.Place(-44)
		end
	end
	if f then
		f:Show()
		local t, k = f.psTracker, "trackers." .. kind .. "."
		TS.Hot(s, f, k .. "scale")
		if t.bar then TS.Hot(s, t.bar, k .. "barHeight") end
		TS.Hot(s, t.titles[1], k .. "titleSize")
		TS.Hot(s, t.bodies[1], k .. "bodySize")
		-- Play: its fight look, faded or gone, for a moment.
		if TR.Get(kind, "combat") then
			s.Play = W.Button(s, L["In a fight"], function()
				local rule = TR.Get(kind, "combat")
				local a = num(kind, "alpha", 0.1, 1)
				local to = rule == "hide" and 0 or rule == "fade" and a * FADED or a
				Anim.To(f, "alpha", a, to, Anim.SLOW, "out", function()
					ns.After(1.2, function() Anim.To(f, "alpha", f:GetAlpha(), a, Anim.SLOW, "out") end)
				end)
			end, { height = 22 })
			s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
		end
	else
		s.psNote = (L["Not loaded"])
	end
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		if xp then xp.Layout(width) end
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- tab: "flight" | "instances" (with the XP bar) | "party"
function TR.Preview(view, tab)
	return trackerStage(view, tab)
end

---------------------------------------------------------------------------
-- The options page
---------------------------------------------------------------------------

if not ns.RegisterOptions then return end

local PAGE = L["Trackers"]
local function pct(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return format(L["%d px"], floor(v + 0.5)) end

local function register(spec)
	spec.page, spec.key, spec.icon, spec.order, spec.group = PAGE, "trackers", "hourglass", 27, "look"
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- A tracker panel's one section, in its anatomy's order: its on/off in the
-- header; size, width, opacity, ground with its colour, border with its
-- colour, its bar when it has one, its type (outline behind the size's cog),
-- when it shows (noRules: none, for the flight timer, which shows only on a
-- flight path: never in a fight, never inside an instance).
local function panelPage(tab, kind, what, spec, opts)
	opts = opts or {}
	local k = "trackers." .. kind .. "."
	local combat = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } }
	if opts.guideRule then table.insert(combat, 1, { value = "guide", label = L["As the guide window"] }) end
	local controls = {}
	for _, c in ipairs(spec.controls or {}) do controls[#controls + 1] = c end
	for _, c in ipairs({
		{ kind = "slider", key = k .. "scale", label = L["Scale"], min = 0.5, max = 2, step = 0.05, format = pct, new = NEW,
			help = format(L["The whole %s, larger or smaller."], what),
			search = "size, bigger, larger, smaller, scale, huge, tiny, zoom, " .. what },
		{ kind = "slider", key = k .. "width", label = L["Width"], min = opts.minW or 160, max = opts.maxW or 420, step = 10, format = px, new = NEW,
			help = format(L["How wide the %s is; longer names fit on one line."], what),
			search = "width, wide, wider, narrow, size, " .. what },
		{ kind = "slider", key = k .. "alpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = pct, new = NEW,
			help = format(L["How solid the %s is, text and all."], what),
			search = "opacity, transparency, alpha, see through, faint, " .. what },
		{ kind = "slider", key = k .. "bgAlpha", label = L["Background"], min = 0, max = 1, step = 0.05, format = pct, new = NEW,
			help = L["Its background's opacity against every Polestar window's (Theme), and its own colour (the swatch). 0 leaves the text on the world."],
			search = "background, backing, ground, transparent, see through, opacity, colour, tint, " .. what,
			extras = {
				{ kind = "color", key = k .. "bg", label = L["Background colour"], new = NEW,
					help = L["Its own background colour; the theme's when reset."],
					search = "background colour, backing, ground, tint, " .. what,
					shown = function() return Theme.Color("bg") end, source = function() return L["Theme"] end },
			} },
		{ kind = "slider", key = k .. "borderSize", label = L["Border"], min = 0, max = 4, step = 1, new = NEW,
			format = function(v) return v < 0.5 and L["Theme"] or px(v) end,
			help = L["Its border's thickness in screen pixels (Theme: the windows' own), and its own colour (the swatch), shown even with the windows' border off."],
			search = "border, thickness, width, outline, edge, frame colour, " .. what,
			extras = {
				{ kind = "color", key = k .. "border", label = L["Border colour"], new = NEW,
					help = L["A border of its own colour, even with the windows' border off; the theme's when reset."],
					search = "border colour, outline, edge, frame colour, " .. what,
					shown = function() return Theme.Color("windowBorder") end, source = function() return L["Theme"] end },
			} },
	}) do controls[#controls + 1] = c end
	if opts.bar then
		controls[#controls + 1] = { kind = "slider", key = k .. "barHeight", label = L["Bar"], min = 1, max = 10, step = 1, format = px, new = NEW,
			disabled = function() return TR.Get(kind, "bar") == false end,
			help = L["The progress bar along its bottom: the switch shows it, the slider is its thickness, the swatch its colour (the accent when reset)."],
			search = "bar, progress, line, fill, thickness, thicker, thin, colour, " .. what,
			extras = {
				{ kind = "toggle", key = k .. "bar", label = L["Progress bar"], new = NEW,
					help = L["The line along its bottom that fills as the flight goes."],
					search = "bar, progress, line, fill, " .. what },
				{ kind = "color", key = k .. "barColor", label = L["Bar colour"], new = NEW,
					help = L["The bar's fill; the accent when reset."],
					search = "bar colour, color, progress, fill, " .. what,
					shown = function() return Theme.Accent() end, source = function() return L["Accent"] end },
			} }
	end
	-- Its type: the main line's size (its outline, and the flight timer's time
	-- format, behind its cog), the other lines' size.
	local titleMore = {
		{ kind = "toggle", key = k .. "outline", label = L["Outline"], new = NEW,
			help = L["A dark outline round the letters, legible over the world with the background off."],
			search = "outline, shadow, legible, readable, contrast, font, " .. what },
	}
	if opts.format then titleMore[#titleMore + 1] = opts.format end
	for _, c in ipairs({
		{ kind = "slider", key = k .. "titleSize", label = opts.titleLabel or L["Title size"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW,
			help = (opts.titleHelp or L["The size of its main line against Polestar's text size."]) .. " " .. (opts.format and L["Its outline and what the time shows: the cog."] or L["Its outline: the cog."]),
			search = "font size, number, bigger text, smaller text, readability, outline, " .. (opts.format and "format, percent, time left, " or "") .. what,
			more = titleMore },
		{ kind = "slider", key = k .. "bodySize", label = L["Text size"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW,
			help = L["The size of its other lines against Polestar's text size."],
			search = "font size, bigger text, smaller text, readability, " .. what },
	}) do controls[#controls + 1] = c end
	if not opts.noRules then
		for _, c in ipairs({
			{ kind = "dropdown", key = k .. "combat", label = L["In combat"], new = NEW, choices = combat,
				help = format(L["What the %s does while you fight."], what),
				search = "combat, fight, hide in combat, fade in combat, visibility, " .. what },
			{ kind = "dropdown", key = k .. "instance", label = L["In instances"], new = NEW,
				choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } },
				help = format(L["Whether the %s shows inside dungeons, raids, battlegrounds and arenas."], what),
				search = "dungeon, raid, instance, battleground, arena, hide, visibility, " .. what },
		}) do controls[#controls + 1] = c end
	end
	spec.tab, spec.controls = tab, controls
	register(spec)
end

-- Travel: the flight timer, and the journey in the guide window.
local TRAVEL = L["Travel"]
panelPage(TRAVEL, "flight", L["flight timer"], {
	section = L["Flight timer"], preview = function(view) return TR.Preview(view, "flight") end,
	subtitle = L["The flight timer, the journey, the instance tracker, the guide's mark on the XP bar and the party panel: their size, look and when they show."],
	toggle = { kind = "toggle", key = "maps.flightTimer", label = L["Flight timer"], search = "flight, taxi, timer, time left", needs = function() return ns.Maps end,
		help = L["While flying, shows the destination and the time left. Learns each route's real duration for this character; drag to move."] },
}, { bar = true, noRules = true, titleLabel = L["Time size"], titleHelp = L["The size of the time against Polestar's text size."],
	format = { kind = "dropdown", key = "trackers.flight.format", label = L["Time shows"], new = NEW,
		help = L["The time left (with ~ while it is an estimate), how far along the flight is, or both."],
		search = "format, percent, time left, countdown, display, numbers, flight",
		choices = { { value = "left", label = L["Time left"] }, { value = "percent", label = L["How far along"] }, { value = "both", label = L["Both"] } } } })
-- The journey (in the guide window: its frame, type and ground are the window's).
local function journeyOff() return not ns.Get("nav.journeySteps") end
register({ tab = TRAVEL, section = L["Journey"],
	controls = {
		{ kind = "toggle", key = "nav.journeySteps", label = L["Journey"], needs = function() return ns.Nav end,
			search = "journey, route steps, travel, legs, flights, boats",
			help = L["The route's steps in the guide window with a time for each, counting down: walks, lifts, boats and flights. Click the current step to skip it."] },
		{ kind = "slider", key = "trackers.journey.rows", label = L["Steps listed"], min = 2, max = 12, step = 1, format = "%d", new = NEW,
			help = L["How many of the route's steps the journey lists; the rest are counted on one line."],
			search = "rows, lines, max lines, how many, steps, legs, journey, longer, shorter", disabled = journeyOff },
		{ kind = "toggle", key = "trackers.journey.numbers", label = L["Numbers"], new = NEW, disabled = journeyOff,
			help = L["The number before each of the journey's steps."],
			search = "numbers, numbering, index, journey" },
	} })

-- Instances & XP: the instance tracker, then the guide's level on the XP bar.
local INST = L["Instances & XP"]
panelPage(INST, "instances", L["instance tracker"], {
	section = L["Instance tracker"], preview = function(view) return TR.Preview(view, "instances") end,
	toggle = { kind = "toggle", key = "maps.instances", label = L["Track instances"], search = "dungeon, instance lockout, instance cap, reset, runs",
		needs = function() return ns.Maps end,
		help = L["Records dungeon and raid entries, time and experience per run. /pole instances lists them."] },
	controls = {
		{ kind = "toggle", key = "maps.instanceDisplay", label = L["Display"], needs = function() return ns.Maps end,
			search = "compact display, tracker, panel, show",
			help = L["Shows the hourly instance count and the current run while it matters; drag to move."] },
	},
}, { titleLabel = L["Count size"], titleHelp = L["The size of the instance count against Polestar's text size."] })
local function labelOff() return TR.Get("xp", "label") == false end
local function markOff() return not ns.Get("qol.xpTargetMark") end
register({ tab = INST, section = L["Level mark"],
	controls = {
		{ kind = "toggle", key = "qol.xpTargetMark", label = L["Guide level"], needs = function() return ns.QoL end,
			search = "experience bar, exp bar, target level, guide level on the xp bar",
			help = L["A mark at the end of the game's XP bar with the level the guide wants you to reach before it moves on, and how many levels away that is when it is more than one."] },
		{ kind = "slider", key = "trackers.xp.tickWidth", disabled = markOff, label = L["Mark width"], min = 1, max = 6, step = 1, format = px, new = NEW,
			help = L["How wide the mark on the bar is, and its colour with its label's (the swatch; the accent when reset)."],
			search = "tick, mark, width, thicker, thin, colour, xp bar, experience",
			extras = {
				{ kind = "color", key = "trackers.xp.tickColor", label = L["Mark colour"], new = NEW,
					help = L["The mark and its label; the accent when reset."],
					search = "tick, mark, colour, color, xp bar, experience",
					shown = function() return Theme.Accent() end, source = function() return L["Accent"] end },
			} },
		{ kind = "toggle", key = "trackers.xp.label", label = L["Show the level"], new = NEW, disabled = markOff,
			help = L["The guide's level beside the mark (\"Guide: 14 (2 levels)\"). Off: the mark alone."],
			search = "label, text, level, guide level, xp bar" },
		{ kind = "slider", key = "trackers.xp.labelSize", label = L["Level text"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW,
			disabled = function() return markOff() or labelOff() end,
			help = L["The size of the guide's level beside the mark; its outline: the cog."],
			search = "label, text, level, guide level, font size, bigger text, outline, xp bar",
			more = {
				{ kind = "toggle", key = "trackers.xp.outline", label = L["Outline"], new = NEW, disabled = labelOff,
					help = L["A dark outline round the letters, legible over the bar's art."],
					search = "outline, shadow, legible, readable, xp bar" },
			} },
	} })

-- Party panel
local PARTY = L["Party panel"]
panelPage(PARTY, "party", L["party panel"], {
	section = L["Party panel"], preview = function(view) return TR.Preview(view, "party") end,
	toggle = { kind = "toggle", key = "party.panel", label = L["Party panel"], search = "party, group, members, steps, sync",
		needs = function() return ns.Party end,
		help = L["A small panel with your party members who run Polestar: their level, step and what they still need. Opens by itself in a party."] },
}, { minW = 200, maxW = 460, guideRule = true, titleLabel = L["Name size"],
	titleHelp = L["The size of the members' names and the panel's title against Polestar's text size."] })

---------------------------------------------------------------------------
-- Essentials (the page's lead tab): three sizes of the trackers as picture
-- cards, then each tracker's size and on/off and the guide's own trackers,
-- each a reference to its row on Travel, Instances & XP or Party panel.
---------------------------------------------------------------------------

local O = UI.Options
if O and O.PresetCards and O.Ref then
	local R = O.Ref
	local PANELS = { "flight", "instances", "party" }
	-- A preset's card: the flight timer as the preset paints it (its own
	-- builder and TR.ApplyLook, at a share of its scale so a bigger one shows
	-- bigger), fitted to the card.
	local function drawTrackerCard(art, _, values)
		local cw, ch = art:GetWidth(), art:GetHeight()
		if not (cw and cw > 0) then cw = W.CARD_W - 2 end
		if not (ch and ch > 0) then ch = W.CARD_ART end
		if art.psBuilt == nil then
			W.Fill(art, "scrim", "BACKGROUND", -6)
			art.psTimer = BUILD.flight(art)
			art.psBuilt = true
		end
		local f = art.psTimer
		if not f then return end
		O.WithSettings(values, function()
			f.psFit = nil
			TR.ApplyLook(f)
			f:Fill()
			local k = 0.42 * num("flight", "scale", 0.4, 2.5)
			k = min(k, (cw - 12) / max(1, f:GetWidth()), (ch - 12) / max(1, f:GetHeight()))
			f:SetScale(max(0.05, k))
			f:SetAlpha(num("flight", "alpha", 0.1, 1))
			f:ClearAllPoints()
			f:SetPoint("CENTER", art, "CENTER", 0, 0)
			f:Show()
		end)
	end
	local compact, large = { ["trackers.flight.bar"] = false }, {}
	for _, p in ipairs(PANELS) do
		compact["trackers." .. p .. ".scale"] = 0.85
		large["trackers." .. p .. ".scale"], large["trackers." .. p .. ".titleSize"], large["trackers." .. p .. ".bodySize"] = 1.25, 1.2, 1.15
	end
	local PRESETS = {
		{ value = "polestar", label = L["Polestar"], set = {}, draw = drawTrackerCard },
		{ value = "compact", label = L["Compact"], set = compact, draw = drawTrackerCard,
			help = L["Every tracker smaller, the flight timer without its bar."] },
		{ value = "large", label = L["Large"], set = large, draw = drawTrackerCard,
			help = L["Every tracker bigger, its text with it."] },
	}
	local function off(key) return function() return not ns.Get(key) end end
	local ESSENTIALS = L["Essentials"]
	register({ tab = ESSENTIALS, lead = true, section = L["Presets"], preview = function(view) return TR.Preview(view, "flight") end,
		controls = { O.PresetCards({ presets = PRESETS }) } })
	register({ tab = ESSENTIALS, section = L["Trackers"], jump = { tab = TRAVEL, section = L["Flight timer"] }, controls = {
		R("slider", "trackers.flight.scale", { label = L["Flight timer"], disabled = off("maps.flightTimer"), extras = { R("toggle", "maps.flightTimer") } }),
		R("slider", "trackers.instances.scale", { label = L["Instance tracker"], disabled = off("maps.instances"), extras = { R("toggle", "maps.instances") } }),
		R("slider", "trackers.party.scale", { label = L["Party panel"], disabled = off("party.panel"), extras = { R("toggle", "party.panel") } }),
		R("dropdown", "trackers.flight.format"),
		R("slider", "trackers.journey.rows", { label = L["Journey"], disabled = off("nav.journeySteps"), extras = { R("toggle", "nav.journeySteps") } }),
		R("toggle", "qol.xpTargetMark"),
	} })
end
