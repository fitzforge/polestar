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
-- stage s. -> { bar, mark, Refresh(), Item() (one of the stage's surfaces) }
local MARK_ROOM = 20 -- the mark's label over the bar
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
	fill:SetWidth(BAR_W * 0.58)
	local rested = bar:CreateTexture(nil, "BORDER")
	rested:SetTexture(Theme.Media("white"))
	rested:SetPoint("TOPLEFT", fill, "TOPRIGHT", 0, 0)
	rested:SetPoint("BOTTOMLEFT", fill, "BOTTOMRIGHT", 0, 0)
	rested:SetVertexColor(0.0, 0.39, 0.88, 0.5)
	rested:SetWidth(BAR_W * 0.12)
	local mark = Mk and Mk.NewDemo and Mk.NewDemo(bar)
	x.bar, x.mark = bar, mark
	if mark then
		s:Hot(mark.Tick, "trackers.xp.tickWidth")
		s:Hot(mark.Label, "trackers.xp.labelSize")
		s:Light("qol.xpTargetMark", mark.Tick, mark.Label)
		s:Light("trackers.xp.tickColor", mark.Tick, mark.Label)
		s:Light("trackers.xp.label", mark.Label)
		s:Light("trackers.xp.outline", mark.Label)
	end
	function x.Refresh()
		if mark then Mk.FillDemo(mark, Mk.Label(12, 14), nil) end
	end
	function x.Item()
		local t = s:TrueScale()
		return { w = BAR_W * t, h = (12 + MARK_ROOM) * t, foot = bar,
			place = function(k, left, top)
				local g = t * k
				bar:SetScale(g)
				bar:ClearAllPoints()
				bar:SetPoint("TOPLEFT", s, "TOPLEFT", left / g, -(top / g + MARK_ROOM))
			end }
	end
	return x
end

-- The journey as the guide window lists it (UI/JourneyPanel.lua: header,
-- destination, a row per leg, in the window's paint and type): a made-up
-- route of three legs, as many listed as Steps listed allows and the rest
-- counted on one line, numbered or not; faint while the journey is off.
local J_W, J_PAD, J_HEAD, J_DEST, J_ROW, J_MORE = 280, 14, 30, 22, 24, 20
local J_TEXT_X = J_PAD + 15 + 10 -- the guide window's goal text edge
local J_LEGS = {
	{ glyph = "icon-goto", text = format(L["Walk to %s"], L["Sentinel Hill"]), secs = 72 },
	{ glyph = "icon-fly", text = format(L["Fly to %s"], L["Menethil Harbor"]), secs = 580 },
	{ glyph = "icon-goto", text = format(L["Walk to %s"], L["Menethil Harbor"]), secs = 45 },
}
local function clock(secs)
	local JP = UI.JourneyPanel
	if JP and JP.FormatTime then return JP.FormatTime(secs) end
	return format("%d:%02d", floor(secs / 60), secs % 60)
end

local function journey(s)
	local j = {}
	local f = CreateFrame("Frame", nil, s)
	f.psGuide = true
	Theme.Skin(f, "window")
	f:SetWidth(J_W)
	j.frame = f
	local head = W.Text(f, "small", "textMuted")
	head:SetText(L["Journey"])
	head:SetPoint("LEFT", f, "TOPLEFT", J_PAD, -J_HEAD / 2)
	local total, secs = W.Text(f, "number", "text"), 0
	for _, leg in ipairs(J_LEGS) do secs = secs + leg.secs end
	total:SetPoint("RIGHT", f, "TOPRIGHT", -J_PAD, -J_HEAD / 2)
	local rule = W.Divider(f)
	rule:SetPoint("TOPLEFT", f, "TOPLEFT", J_PAD, -J_HEAD)
	rule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -J_PAD, -J_HEAD)
	local dest = W.Text(f, "label", "textDim")
	dest:SetPoint("LEFT", f, "TOPLEFT", J_PAD, -(J_HEAD + J_DEST / 2))
	local list = CreateFrame("Frame", nil, f)
	list:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -(J_HEAD + J_DEST))
	list:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -(J_HEAD + J_DEST))
	j.rows = {}
	for i, leg in ipairs(J_LEGS) do
		local current = i == 1
		local r = CreateFrame("Frame", nil, list)
		r:SetHeight(J_ROW)
		r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
		r.Bar:SetWidth(2)
		r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
		r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
		r.Bar:SetShown(current)
		r.Num = W.Text(r, "number", current and "textDim" or "textMuted")
		r.Num:SetJustifyH("RIGHT")
		r.Num:SetWidth(22)
		r.Num:SetPoint("LEFT", r, "TOPLEFT", J_PAD - 10, -J_ROW / 2)
		r.Num:SetText(tostring(i))
		r.Icon = W.Tex(r, "ARTWORK", leg.glyph, current and "accent" or "textMuted")
		r.Icon:SetSize(13, 13)
		r.Icon:SetPoint("LEFT", r, "TOPLEFT", J_TEXT_X - 2, -J_ROW / 2)
		r.Text = W.Text(r, "label", current and "text" or "textDim")
		r.Text:SetPoint("LEFT", r.Icon, "RIGHT", 9, 0)
		r.Time = W.Text(r, "number", current and "text" or "textMuted")
		r.Time:SetJustifyH("RIGHT")
		r.Time:SetPoint("RIGHT", r, "TOPRIGHT", -J_PAD, -J_ROW / 2)
		r.Time:SetText(clock(leg.secs))
		j.rows[i] = r
	end
	local more = W.Text(list, "small", "textMuted")
	s:Light("nav.journeySteps", f)
	s:Light("trackers.journey.rows", list)
	local nums = {}
	for i, r in ipairs(j.rows) do nums[i] = r.Num end
	s:Light("trackers.journey.numbers", unpack(nums))
	function j.Refresh()
		total:SetText(clock(secs))
		dest:SetText(format(L["To %s"], "|c" .. Theme.Hex("place") .. L["Menethil Harbor"] .. "|r"))
		local most = max(1, floor(tonumber(TR.Get("journey", "rows")) or #J_LEGS))
		local shown = min(#J_LEGS, most)
		local numbers = TR.Get("journey", "numbers") ~= false
		for i, r in ipairs(j.rows) do
			local leg = J_LEGS[i]
			r.Text:SetText(leg.text)
			r.Num:SetShown(numbers)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -(i - 1) * J_ROW)
			r:SetPoint("TOPRIGHT", list, "TOPRIGHT", 0, -(i - 1) * J_ROW)
			r:SetShown(i <= shown)
		end
		local left = #J_LEGS - shown
		more:SetShown(left > 0)
		more:ClearAllPoints()
		more:SetPoint("LEFT", list, "TOPLEFT", J_TEXT_X, -(shown * J_ROW + J_MORE / 2))
		if left > 0 then more:SetText(left == 1 and L["1 more step"] or format(L["%d more steps"], left)) end
		local h = shown * J_ROW + (left > 0 and J_MORE or 0)
		list:SetHeight(h)
		f:SetHeight(J_HEAD + J_DEST + h + 8)
		f:SetAlpha(ns.Get("nav.journeySteps") and 1 or 0.35)
	end
	function j.Item()
		local k0 = (tonumber(ns.Get("ui.scale")) or 1) * s:TrueScale()
		return { w = J_W * k0, h = f:GetHeight() * k0, foot = f, caption = j.Caption,
			place = function(k, left, top)
				local g = k0 * k
				f:SetScale(g)
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", s, "TOPLEFT", left / g, -top / g)
			end }
	end
	return j
end

-- A tracker as one of the stage's surfaces: at its true size (its Scale on
-- the game's UI scale), its place its fight look's (Anim.Anchor).
local function trackerItem(s, kind, f, caption)
	local k0 = num(kind, "scale", 0.4, 2.5) * s:TrueScale()
	return { w = f:GetWidth() * k0, h = f:GetHeight() * k0, foot = f, caption = caption,
		place = function(k, left, top)
			local g = k0 * k
			f:SetScale(g)
			Anim.Anchor(f, "TOPLEFT", s, "TOPLEFT", left / g, -top / g)
		end }
end

-- What lights each tracker with a setting's row: its whole panel, its bar,
-- its main line, its other lines; its switch's own.
local PANEL_KEYS = { "scale", "width", "alpha", "bgAlpha", "bg", "borderSize", "border", "combat", "instance" }
local SWITCH = { flight = { "maps.flightTimer" }, instances = { "maps.instances", "maps.instanceDisplay" }, party = { "party.panel" } }
local function lightTracker(s, kind, f, fight)
	local t, k = f.psTracker, "trackers." .. kind .. "."
	for _, key in ipairs(PANEL_KEYS) do s:Light(k .. key, f) end
	for _, key in ipairs(SWITCH[kind] or {}) do s:Light(key, f) end
	if fight then
		s:Light(k .. "combat", fight)
		s:Light(k .. "instance", fight)
	end
	if t.bar then
		for _, key in ipairs({ "barHeight", "bar", "barColor" }) do s:Light(k .. key, t.bar) end
	end
	-- Lines a panel makes as it fills (the party panel's rows) light the panel.
	local titles = #t.titles > 0 and t.titles or { f }
	local bodies = #t.bodies > 0 and t.bodies or { f }
	s:Light(k .. "titleSize", unpack(titles))
	s:Light(k .. "outline", unpack(titles))
	s:Light(k .. "bodySize", unpack(bodies))
	if kind == "flight" then s:Light("trackers.flight.format", t.titles[1]) end
end

-- A stage of trackers: kinds (their sandbox panels), with the journey and
-- the XP bar when asked, all at their true size on soft shadows; the first
-- panel's fight look behind a button when it has a fight rule.
local HEIGHT = { flight = 130, instances = 200, party = 260 }
local NAMES = { flight = L["Flight timer"], instances = L["Instance tracker"], party = L["Party panel"] }

local function trackerStage(view, kinds, opts)
	local TS = UI.Toasts
	local first = kinds[1]
	local s = TS.NewStage(view, HEIGHT[first])
	stages[s] = true
	local panels, caps = {}, {}
	for _, kind in ipairs(kinds) do
		local f = BUILD[kind] and BUILD[kind](s)
		if f then
			f:Show()
			panels[kind] = f
			if opts.captions then
				caps[kind] = W.Text(s, "small", "textMuted")
				caps[kind]:SetJustifyH("CENTER")
				caps[kind]:SetText(NAMES[kind])
			end
		end
	end
	local f = panels[first]
	s.Tracker = f
	local j = opts.journey and journey(s) or nil
	if j and opts.captions then
		j.Caption = W.Text(s, "small", "textMuted")
		j.Caption:SetJustifyH("CENTER")
		j.Caption:SetText(L["Journey"])
	end
	local xp = opts.xp and xpBar(s) or nil
	s.XP, s.Journey = xp, j
	function s:Refresh()
		local items = {}
		for _, kind in ipairs(kinds) do
			local p = panels[kind]
			if p then
				p.psFit = nil
				TR.ApplyLook(p)
				p:Fill()
				p:SetAlpha(num(kind, "alpha", 0.1, 1))
				items[#items + 1] = trackerItem(self, kind, p, caps[kind])
			end
		end
		if j then
			j.Refresh()
			items[#items + 1] = j.Item()
		end
		if xp then
			xp.Refresh()
			items[#items + 1] = xp.Item()
		end
		if #items > 0 then self:SideBySide(items, { bottom = rawget(self, "Play") and 40 or 12 }) end
	end
	if f then
		local t, k = f.psTracker, "trackers." .. first .. "."
		s:Hot(f, k .. "scale")
		if t.bar then s:Hot(t.bar, k .. "barHeight") end
		s:Hot(t.titles[1], k .. "titleSize")
		s:Hot(t.bodies[1], k .. "bodySize")
		-- Play: its fight look, faded or gone, for a moment.
		if not opts.captions and TR.Get(first, "combat") then
			s.Play = W.Button(s, L["In a fight"], function()
				local rule = TR.Get(first, "combat")
				local a = num(first, "alpha", 0.1, 1)
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
	for kind, p in pairs(panels) do lightTracker(s, kind, p, kind == first and rawget(s, "Play") or nil) end
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height or HEIGHT[first]
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- tab: "flight" (with the journey) | "instances" (with the XP bar) |
-- "party" | "all" (Essentials: every tracker, the journey and the XP bar)
function TR.Preview(view, tab)
	if tab == "all" then return trackerStage(view, { "flight", "instances", "party" }, { journey = true, xp = true, captions = true }) end
	return trackerStage(view, { tab }, { journey = tab == "flight", xp = tab == "instances" })
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
	register({ tab = ESSENTIALS, lead = true, section = L["Presets"], preview = function(view) return TR.Preview(view, "all") end,
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
