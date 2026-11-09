-- Trackers: how Polestar's small always-there panels look and when they
-- show, and the options page for them (Options > Look > Trackers, key
-- `trackers`).
--
-- The trackers: the flight timer (Maps/FlightTimer.lua), the instance
-- tracker (Maps/Instances.lua), the party panel (UI/PartyPanel.lua) and the
-- guide's level mark on the game's XP bar (QoL/XPMark.lua). Each builds its
-- frame and hands it here (TR.Attach) with its strings and progress bar;
-- from then on its scale, width, opacity, type sizes and outline, bar and
-- ground follow trackers.<kind>.* live. TR.Allowed says whether it may show
-- now (trackers.<kind>.combat: show, fade or hide in a fight;
-- trackers.<kind>.instance: show or hide inside an instance); a fight
-- starting or ending, or entering or leaving an instance, asks each again
-- (its `refresh`). The XP mark reads its own settings (QoL/XPMark.lua).
--
--   UI.Trackers.Get(kind, prop)
--   UI.Trackers.Attach(kind, frame, { titles, bodies, bar, relayout(frame), refresh(), sandbox })
--   UI.Trackers.AddText(frame, titles, bodies)   strings made later (the party panel's rows)
--   UI.Trackers.ApplyLook(frame[, relayout])
--   UI.Trackers.Allowed(kind) -> true | "fade" | false
--   UI.Trackers.Preview(view, tab)   the options' pinned preview (sandbox trackers with made-up values)

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, format, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, string.format, type, ipairs, pairs, tonumber

local TR = {}
UI.Trackers = TR

local NEW = "0.3.7"
local FADED = 0.35 -- a tracker set to fade in a fight

local function panel(width, extra)
	local t = { scale = 1, alpha = 1, width = width, titleSize = 1, bodySize = 1, outline = false,
		bgAlpha = 1, bg = false, border = false, borderSize = 0, combat = "show", instance = "show" }
	for k, v in pairs(extra or {}) do t[k] = v end
	return t
end

local DEFAULTS = {
	flight = panel(220, { barHeight = 2, barColor = false, bar = true, format = "left" }),
	instances = panel(230),
	-- combat "guide": as the guide window does in a fight (ui.combat).
	party = panel(260, { combat = "guide" }),
	xp = { tickWidth = 2, tickColor = false, label = true, labelSize = 1, outline = true },
	-- The guide window's journey (UI/JourneyPanel.lua): how many legs it lists, their numbers.
	journey = { rows = 8, numbers = true },
}
ns.RegisterDefaults("trackers", DEFAULTS)

function TR.Get(kind, prop)
	local v = ns.Get("trackers." .. kind .. "." .. prop)
	if v == nil then
		local d = DEFAULTS[kind]
		v = d and d[prop]
	end
	return v
end

local function num(kind, prop, lo, hi)
	local v = tonumber(TR.Get(kind, prop)) or tonumber(DEFAULTS[kind][prop]) or 1
	return min(hi, max(lo, v))
end

local function rgba(v)
	if type(v) == "table" and tonumber(v[1]) then return v[1], v[2] or 0, v[3] or 0, tonumber(v[4]) or 1 end
	return nil
end

---------------------------------------------------------------------------
-- When a tracker may show
---------------------------------------------------------------------------

local fighting = false
local function inInstance()
	local C = ns.Compat
	return C and C.IsInInstance and C.IsInInstance() and true or false
end

function TR.Allowed(kind)
	if TR.Get(kind, "instance") == "hide" and inInstance() then return false end
	local rule = TR.Get(kind, "combat")
	if fighting and rule == "hide" then return false end
	if fighting and rule == "fade" then return "fade" end
	return true
end

---------------------------------------------------------------------------
-- The look on a tracker
---------------------------------------------------------------------------

local attached = setmetatable({}, { __mode = "k" }) -- frame -> kind
local dirty = setmetatable({}, { __mode = "k" })

function TR.ApplyLook(frame, relayout)
	local t = frame and frame.psTracker
	if not t then return end
	local kind = t.kind
	local tk, bk = num(kind, "titleSize", 0.6, 2), num(kind, "bodySize", 0.6, 2)
	frame.psTextK = max(tk, bk)
	local outline = TR.Get(kind, "outline") and true or false
	for _, list in ipairs({ { t.titles, tk }, { t.bodies, bk } }) do
		for _, fs in ipairs(list[1]) do
			if Theme.SetFontScale then Theme.SetFontScale(fs, list[2]) end
			if Theme.SetOutline then Theme.SetOutline(fs, outline) end
		end
	end
	frame:SetScale(num(kind, "scale", 0.4, 2.5) * (frame.psFit or 1))
	local width = floor(num(kind, "width", 120, 600) + 0.5)
	frame.psWidth = width
	frame:SetWidth(width)
	local bar = t.bar
	if bar then
		local h = floor(num(kind, "barHeight", 1, 12) + 0.5)
		bar:SetHeight(h)
		bar:SetShown(TR.Get(kind, "bar") ~= false)
		local r, g, b = rgba(TR.Get(kind, "barColor"))
		if r then
			W.Uncolor(bar.Fill)
			bar.Fill:SetVertexColor(r, g, b, 1)
		else
			W.Color(bar.Fill, "accent")
		end
		-- The fill's width follows the frame's.
		if W.SetProgress and bar.psFrac then W.SetProgress(bar, bar.psFrac, width - 2) end
	end
	local TS = UI.Toasts
	if TS and TS.PaintGround then TS.PaintGround(frame, function(prop) return TR.Get(kind, prop) end) end
	local a = num(kind, "alpha", 0.1, 1)
	if not t.sandbox and TR.Allowed(kind) == "fade" then a = a * FADED end
	frame:SetAlpha(a)
	if relayout and t.relayout then t.relayout(frame) end
end

local function refresh(frame, relayout)
	if frame.psTracker.sandbox and not frame:IsVisible() then
		dirty[frame] = true
		return
	end
	TR.ApplyLook(frame, relayout)
end

function TR.Attach(kind, frame, opts)
	opts = opts or {}
	frame.psTracker = {
		kind = kind, titles = opts.titles or {}, bodies = opts.bodies or {}, bar = opts.bar,
		relayout = opts.relayout, refresh = opts.refresh, sandbox = opts.sandbox and true or false,
	}
	attached[frame] = kind
	if opts.sandbox then
		frame:HookScript("OnShow", function(self)
			if dirty[self] then
				dirty[self] = nil
				TR.ApplyLook(self, true)
			end
		end)
	end
	TR.ApplyLook(frame)
end

-- Strings a tracker makes later (a new row): they take its type sizes.
function TR.AddText(frame, titles, bodies)
	local t = frame and frame.psTracker
	if not t then return end
	local tk, bk = num(t.kind, "titleSize", 0.6, 2), num(t.kind, "bodySize", 0.6, 2)
	local outline = TR.Get(t.kind, "outline") and true or false
	for _, pair in ipairs({ { titles, t.titles, tk }, { bodies, t.bodies, bk } }) do
		for _, fs in ipairs(pair[1] or {}) do
			pair[2][#pair[2] + 1] = fs
			if Theme.SetFontScale then Theme.SetFontScale(fs, pair[3]) end
			if Theme.SetOutline then Theme.SetOutline(fs, outline) end
		end
	end
end

-- The live trackers asked again whether they show, and their opacity.
local function wake()
	for frame in pairs(attached) do
		local t = frame.psTracker
		if not t.sandbox then
			if t.refresh then t.refresh() end
			TR.ApplyLook(frame)
		end
	end
end

local stages = setmetatable({}, { __mode = "k" })

ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "trackers" and path:sub(1, 9) ~= "trackers." then return end
	local kind = path:match("^trackers%.([^.]+)")
	local prop = path:match("^trackers%.[^.]+%.(.+)$")
	for frame, k in pairs(attached) do
		if not kind or k == kind then
			refresh(frame, true)
			local t = frame.psTracker
			if (prop == "combat" or prop == "instance" or not kind) and not t.sandbox and t.refresh then t.refresh() end
		end
	end
	for s in pairs(stages) do
		if s:IsVisible() then s:Refresh() else s.psDirty = true end
	end
end)

ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	fighting = true
	wake()
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	fighting = false
	wake()
end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	local C = ns.Compat
	fighting = C and C.InCombat and C.InCombat() and true or false
	wake()
end)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", wake)

Theme.OnChanged(function()
	for frame in pairs(attached) do refresh(frame, false) end
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

-- One tracker's stage: the sandbox tracker, fitted.
local function trackerStage(view, kind)
	local TS = UI.Toasts
	local s = TS.NewStage(view)
	stages[s] = true
	local f = BUILD[kind] and BUILD[kind](s)
	s.Tracker = f
	function s:Refresh()
		if not f then return end
		f.psFit = nil
		TR.ApplyLook(f)
		f:Fill()
		TS.FitInto(self, f, f:GetWidth(), f:GetHeight(), num(kind, "scale", 0.4, 2.5))
		f:SetAlpha(num(kind, "alpha", 0.1, 1))
	end
	if f then
		f:Show()
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
		self:Refresh()
		return TS.STAGE_H
	end
	return s
end

-- The game's XP bar, drawn plainly, with the guide's real mark on it.
local function xpStage(view)
	local TS = UI.Toasts
	local s = TS.NewStage(view)
	stages[s] = true
	local Mk = ns.QoL and ns.QoL.XPMark
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
	fill:SetWidth(BAR_W * 0.58)
	fill:SetVertexColor(0.58, 0.0, 0.55, 1) -- the game's XP purple
	local rested = bar:CreateTexture(nil, "BORDER")
	rested:SetTexture(Theme.Media("white"))
	rested:SetPoint("TOPLEFT", fill, "TOPRIGHT", 0, 0)
	rested:SetPoint("BOTTOMLEFT", fill, "BOTTOMRIGHT", 0, 0)
	rested:SetWidth(BAR_W * 0.12)
	rested:SetVertexColor(0.0, 0.39, 0.88, 0.5)
	local mark = Mk and Mk.NewDemo and Mk.NewDemo(bar)
	local caption = W.Text(s, "small", "textMuted")
	caption:SetPoint("TOP", bar, "BOTTOM", 0, -12)
	caption:SetText(L["The game's XP bar, with the guide's level"])
	function s:Refresh()
		if not mark then return end
		Mk.FillDemo(mark, Mk.Label(12, 14), nil)
		bar:ClearAllPoints()
		bar:SetPoint("CENTER", self, "CENTER", 0, -6)
	end
	if not mark then s.psNote = (L["Not loaded"]) end
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		bar:SetWidth(min(BAR_W, width - 60))
		fill:SetWidth(bar:GetWidth() * 0.58)
		rested:SetWidth(bar:GetWidth() * 0.12)
		self:Refresh()
		return TS.STAGE_H
	end
	return s
end

-- tab: "flight" | "instances" | "party" | "xp"
function TR.Preview(view, tab)
	if tab == "xp" then return xpStage(view) end
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

-- The rows every tracker panel has: size, width, opacity; type; ground; when it shows.
local function panelSections(tab, kind, what, opts)
	opts = opts or {}
	local k = "trackers." .. kind .. "."
	local size = {
		{ kind = "slider", key = k .. "scale", label = L["Scale"], min = 0.5, max = 2, step = 0.05, format = pct, new = NEW,
			help = format(L["The whole %s, larger or smaller. Right-click to reset."], what),
			search = "size, bigger, larger, smaller, scale, huge, tiny, zoom, " .. what },
		{ kind = "slider", key = k .. "width", label = L["Width"], min = opts.minW or 160, max = opts.maxW or 420, step = 10, format = px, new = NEW,
			help = format(L["How wide the %s is; longer names fit on one line."], what),
			search = "width, wide, wider, narrow, size, " .. what },
		{ kind = "slider", key = k .. "alpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = pct, new = NEW,
			help = format(L["How solid the %s is, text and all."], what),
			search = "opacity, transparency, alpha, see through, faint, " .. what },
	}
	if opts.bar then
		size[#size + 1] = { kind = "toggle", key = k .. "bar", label = L["Progress bar"], new = NEW,
			help = L["The line along its bottom that fills as the flight goes."],
			search = "bar, progress, line, fill, " .. what }
		size[#size + 1] = { kind = "slider", key = k .. "barHeight", label = L["Bar thickness"], min = 1, max = 10, step = 1, format = px, new = NEW, child = true,
			disabled = function() return TR.Get(kind, "bar") == false end,
			help = L["How thick the progress bar is."],
			search = "bar height, thickness, thicker, thin, progress, " .. what }
		size[#size + 1] = { kind = "color", key = k .. "barColor", label = L["Bar colour"], new = NEW, child = true,
			disabled = function() return TR.Get(kind, "bar") == false end,
			help = L["The bar's fill. Right-click to go back to the accent."],
			search = "bar colour, color, progress, fill, " .. what,
			shown = function() return Theme.Accent() end, source = function() return L["Accent"] end }
	end
	register({ tab = tab, section = L["Size and opacity"], controls = size })
	local text = {
		{ kind = "slider", key = k .. "titleSize", label = opts.titleLabel or L["Title size"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW,
			help = opts.titleHelp or L["The size of its main line against Polestar's text size."],
			search = "font size, number, bigger text, smaller text, readability, " .. what },
		{ kind = "slider", key = k .. "bodySize", label = L["Text size"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW,
			help = L["The size of its other lines against Polestar's text size."],
			search = "font size, bigger text, smaller text, readability, " .. what },
		{ kind = "toggle", key = k .. "outline", label = L["Outlined text"], new = NEW,
			help = L["A dark outline round the letters, legible over the world with the background off."],
			search = "outline, shadow, legible, readable, contrast, font, " .. what },
	}
	if opts.format then text[#text + 1] = opts.format end
	register({ tab = tab, section = L["Text"], controls = text })
	register({ tab = tab, section = L["Background and border"], controls = {
		{ kind = "slider", key = k .. "bgAlpha", label = L["Background opacity"], min = 0, max = 1, step = 0.05, format = pct, new = NEW,
			help = L["Its background against every Polestar window's (Theme). 0 leaves the text on the world."],
			search = "background, backing, ground, transparent, see through, opacity, " .. what },
		{ kind = "color", key = k .. "bg", label = L["Background colour"], new = NEW,
			help = L["Its own background colour. Right-click to go back to the theme's."],
			search = "background colour, backing, ground, tint, " .. what,
			shown = function() return Theme.Color("bg") end, source = function() return L["Theme"] end },
		{ kind = "color", key = k .. "border", label = L["Border colour"], new = NEW,
			help = L["A border of its own colour, even with the windows' border off. Right-click to go back to the theme's."],
			search = "border, outline, edge, frame colour, " .. what,
			shown = function() return Theme.Color("windowBorder") end, source = function() return L["Theme"] end },
		{ kind = "slider", key = k .. "borderSize", label = L["Border thickness"], min = 0, max = 4, step = 1, new = NEW,
			format = function(v) return v < 0.5 and L["The theme's"] or px(v) end,
			help = L["In screen pixels; 0 follows the windows' border."],
			search = "border, thickness, width, outline, edge, " .. what },
	} })
	local combat = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } }
	if opts.guideRule then table.insert(combat, 1, { value = "guide", label = L["As the guide window"] }) end
	register({ tab = tab, section = L["When it shows"], controls = {
		{ kind = "dropdown", key = k .. "combat", label = L["In combat"], new = NEW, choices = combat,
			help = format(L["What the %s does while you fight."], what),
			search = "combat, fight, hide in combat, fade in combat, visibility, " .. what },
		{ kind = "dropdown", key = k .. "instance", label = L["In dungeons and battlegrounds"], new = NEW,
			choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } },
			help = format(L["Whether the %s shows inside dungeons, raids, battlegrounds and arenas."], what),
			search = "dungeon, raid, instance, battleground, arena, hide, visibility, " .. what },
	} })
end

-- Flight timer
local FLIGHT = L["Flight timer"]
register({ tab = FLIGHT, section = L["Flight timer"], preview = function(view) return TR.Preview(view, "flight") end,
	subtitle = L["How the flight timer, the instance tracker, the party panel and the guide's mark on the XP bar look, and when they show."],
	controls = {
		{ kind = "toggle", key = "maps.flightTimer", label = L["Flight timer"], search = "flight, taxi, timer, time left",
			help = L["While flying, shows the destination and the time left. Learns each route's real duration for this character; drag to move."],
			needs = function() return ns.Maps end },
	} })
panelSections(FLIGHT, "flight", L["flight timer"], { bar = true, titleLabel = L["Time size"], titleHelp = L["The size of the time against Polestar's text size."],
	format = { kind = "dropdown", key = "trackers.flight.format", label = L["Time shows"], new = NEW,
		help = L["The time left (with ~ while it is an estimate), how far along the flight is, or both."],
		search = "format, percent, time left, countdown, display, numbers, flight",
		choices = { { value = "left", label = L["Time left"] }, { value = "percent", label = L["How far along"] }, { value = "both", label = L["Both"] } } } })

-- Instances
local INST = L["Instance tracker"]
register({ tab = INST, section = L["Instance tracker"], preview = function(view) return TR.Preview(view, "instances") end, controls = {
	{ kind = "toggle", key = "maps.instances", label = L["Track instances"], search = "dungeon, instance lockout, instance cap, reset, runs",
		help = L["Records dungeon and raid entries, time and experience per run. /pole instances lists them."], needs = function() return ns.Maps end },
	{ kind = "toggle", key = "maps.instanceDisplay", label = L["Compact display"], child = true,
		help = L["Shows the hourly instance count and the current run while it matters; drag to move."],
		disabled = function() return not ns.Get("maps.instances") end, needs = function() return ns.Maps end },
} })
panelSections(INST, "instances", L["instance tracker"], { titleLabel = L["Count size"], titleHelp = L["The size of the instance count against Polestar's text size."] })

-- Party panel
local PARTY = L["Party panel"]
register({ tab = PARTY, section = L["Party panel"], preview = function(view) return TR.Preview(view, "party") end, controls = {
	{ kind = "toggle", key = "party.panel", label = L["Party panel"], search = "party, group, members, steps, sync",
		help = L["A small panel with your party members who run Polestar: their level, step and what they still need. Opens by itself in a party."],
		needs = function() return ns.Party end },
} })
panelSections(PARTY, "party", L["party panel"], { minW = 200, maxW = 460, guideRule = true, titleLabel = L["Name size"],
	titleHelp = L["The size of the members' names and the panel's title against Polestar's text size."] })

-- XP bar
local XP = L["XP bar"]
register({ tab = XP, section = L["Guide level on the XP bar"], preview = function(view) return TR.Preview(view, "xp") end, controls = {
	{ kind = "toggle", key = "qol.xpTargetMark", label = L["Guide level on the XP bar"],
		help = L["A mark at the end of the game's XP bar with the level the guide wants you to reach before it moves on, and how many levels away that is when it is more than one."],
		search = "experience bar, exp bar, target level", needs = function() return ns.QoL end },
	{ kind = "slider", key = "trackers.xp.tickWidth", label = L["Mark width"], min = 1, max = 6, step = 1, format = px, new = NEW,
		help = L["How wide the mark on the bar is."],
		search = "tick, mark, width, thicker, thin, xp bar, experience" },
	{ kind = "color", key = "trackers.xp.tickColor", label = L["Mark colour"], new = NEW,
		help = L["The mark and its label. Right-click to go back to the accent."],
		search = "tick, mark, colour, color, xp bar, experience",
		shown = function() return Theme.Accent() end, source = function() return L["Accent"] end },
	{ kind = "toggle", key = "trackers.xp.label", label = L["Show the level"], new = NEW,
		help = L["The guide's level beside the mark (\"Guide: 14 (2 levels)\"). Off: the mark alone."],
		search = "label, text, level, guide level, xp bar" },
	{ kind = "slider", key = "trackers.xp.labelSize", label = L["Text size"], min = 0.7, max = 1.8, step = 0.05, format = pct, new = NEW, child = true,
		disabled = function() return TR.Get("xp", "label") == false end,
		help = L["The size of the level beside the mark."],
		search = "font size, bigger text, label, xp bar" },
	{ kind = "toggle", key = "trackers.xp.outline", label = L["Outlined text"], new = NEW, child = true,
		disabled = function() return TR.Get("xp", "label") == false end,
		help = L["A dark outline round the letters, legible over the bar's art."],
		search = "outline, shadow, legible, readable, xp bar" },
} })

-- Journey (in the guide window: its frame, type and ground are the window's)
local JOURNEY = L["Journey"]
register({ tab = JOURNEY, section = L["Journey"], controls = {
	{ kind = "toggle", key = "nav.journeySteps", label = L["Show the journey"], needs = function() return ns.Nav end,
		search = "journey, route steps, travel, legs, flights, boats",
		help = L["The route's steps in the guide window with a time for each, counting down: walks, lifts, boats and flights. Click the current step to skip it."] },
	{ kind = "slider", key = "trackers.journey.rows", label = L["Steps listed"], min = 2, max = 12, step = 1, format = "%d", new = NEW,
		disabled = function() return not ns.Get("nav.journeySteps") end,
		help = L["How many of the route's steps the journey lists; the rest are counted on one line."],
		search = "rows, lines, max lines, how many, steps, legs, journey, longer, shorter" },
	{ kind = "toggle", key = "trackers.journey.numbers", label = L["Step numbers"], new = NEW,
		disabled = function() return not ns.Get("nav.journeySteps") end,
		help = L["The number before each of the journey's steps."],
		search = "numbers, numbering, index, journey" },
} })
