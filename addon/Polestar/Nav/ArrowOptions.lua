-- The settings window's Arrow page (look group, key "arrow"): the waypoint
-- arrow's style, size, colours, glow, arrival, text and when it shows, every
-- row with real effect on the live arrow (Nav/Arrow.lua reads them on
-- SETTING_CHANGED and repaints in place).
--
-- Each tab pins a live preview over its rows: three sandbox dials built and
-- painted by the arrow's own code (Arrow.BuildDial / Arrow.PaintDial) in its
-- three states, on its way, closing in and arrived, with the current values.
-- The preview has no target, no sampling and no Nav hook, and never touches
-- the live arrow; it runs an OnUpdate only while shown and the arrival
-- animates. Nothing is built until the page first shows.

local ADDON, ns = ...
local Nav = ns.Nav
local Arrow = Nav and Nav.arrow
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Arrow and Arrow.BuildDial and ns.RegisterOptions and Theme and W) then return end

local floor, min, max = math.floor, math.min, math.max

local PAGE = L["Arrow"]
local NEW = "0.3.7"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
-- Guidance options with no effect while Shortest Path Forever guides (Nav/Handoff.lua).
local function H(c) return Nav.HandoffOption and Nav.HandoffOption(c) or c end
local function arrowOff() return not ns.Get("nav.arrow") end
local function glowOff() return not ns.Get("nav.arrowGlow") end

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local STAGE_H, CAPTION_H, TOP = 196, 18, 30
-- The demo: heading (radians), yards and seconds for each state.
local STATES = {
	{ state = "travel", angle = 0.6, dist = 420, eta = 95, caption = L["On its way"] },
	{ state = "travel", angle = -0.3, dist = 40, eta = 9, caption = L["Closing in"] },
	{ state = "arrived", caption = L["Arrived"] },
}

local function clamp(v, lo, hi, default)
	v = tonumber(v) or default
	return min(hi, max(lo, v))
end

local function buildPreview(view)
	local f = CreateFrame("Frame", nil, view)
	f:SetHeight(STAGE_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	-- The ground: the deepest ground and the inner hairline, as the Theme
	-- page's. The window draws "Preview", the caption and "Live" over it.
	W.Fill(f, "scrim", "BACKGROUND", -8)
	W.Painter(f, function(self) Theme.Border(self, Theme.Wash("divider")) end)
	f.caption = L["On its way, closing in, arrived"]

	local lk = {}
	local cols = {}
	for i, s in ipairs(STATES) do
		local holder = CreateFrame("Frame", nil, f)
		holder:SetSize(Arrow.WIDTH, Arrow.HEIGHT)
		local caption = W.Text(f, "small", "textMuted")
		caption:SetJustifyH("CENTER")
		caption:SetText(s.caption)
		cols[i] = { holder = holder, dial = Arrow.BuildDial(holder), caption = caption, s = s }
	end
	f.Dials = cols

	local width, dirty = 0, true
	local pulseT = 0
	local function animating()
		return lk.pulse and cols[3].dial.ring:IsShown() or (lk.pulse and cols[3].dial.skinRing:IsShown() and not cols[3].dial.skinCheck:IsShown())
	end
	local function onUpdate(_, elapsed)
		pulseT = pulseT + elapsed
		Arrow.PulseDial(cols[3].dial, pulseT)
		if not animating() then f:SetScript("OnUpdate", nil) end
	end
	local function place()
		if width <= 0 then return end
		local pad = 32
		local colW = (width - 2 * pad) / 3
		local s = clamp(ns.Get("nav.arrowScale"), 0.5, 2, 1)
		s = min(s, colW / Arrow.WIDTH, (STAGE_H - TOP - CAPTION_H - 8) / Arrow.HEIGHT)
		local alpha = clamp(ns.Get("nav.arrowAlpha"), 0.1, 1, 1)
		for i, c in ipairs(cols) do
			local cx = pad + colW * (i - 0.5)
			c.holder:SetScale(s)
			c.holder:SetAlpha(alpha)
			c.holder:ClearAllPoints()
			c.holder:SetPoint("TOP", f, "TOPLEFT", cx / s, -TOP / s)
			c.caption:ClearAllPoints()
			c.caption:SetPoint("BOTTOM", f, "BOTTOMLEFT", cx, 10)
		end
	end
	-- Every dial in its state with the current values, through the arrow's own paint.
	local function paint()
		dirty = false
		Arrow.ReadLook(lk)
		local style = Arrow.StyleFor(ns.Get("nav.arrowStyle"))
		for _, c in ipairs(cols) do
			local s = c.s
			Arrow.PaintDial(c.dial, lk, style, s.state, s.angle, s.dist, L["The innkeeper"], s.eta)
		end
		place()
		pulseT = 0
		f:SetScript("OnUpdate", f:IsVisible() and animating() and onUpdate or nil)
	end
	f.Paint = paint
	-- Settings and theme changes repaint only while shown; else on the next show.
	ns.On("SETTING_CHANGED", function(path)
		if type(path) == "string" and path ~= "" and path ~= "nav" and path:sub(1, 4) ~= "nav." then return end
		if f:IsVisible() then paint() else dirty = true end
	end)
	W.Painter(f.Dials, function()
		if f:IsVisible() then paint() else dirty = true end
	end)
	f:SetScript("OnShow", function()
		if dirty then paint() elseif animating() then f:SetScript("OnUpdate", onUpdate) end
	end)
	f:SetScript("OnHide", function() f:SetScript("OnUpdate", nil) end)

	function f:Layout(w)
		self:SetWidth(w)
		width = w
		if dirty then paint() else place() end
		return STAGE_H
	end
	return f
end
-- The preview, for the tests: ArrowPreview(parent) -> f.
Nav.ArrowPreview = buildPreview

---------------------------------------------------------------------------
-- Style cards: each a sandbox dial in that style, pointing ahead-left.
---------------------------------------------------------------------------

local cardLook = {}
local function paintCard(c)
	Arrow.ReadLook(cardLook)
	Arrow.PaintDial(c.dial, cardLook, Arrow.StyleFor(c.value), "travel", 0.5, 400)
	c.dial.distText:Hide()
	c.dial.labelText:Hide()
	c.dial.etaText:Hide()
end

local function drawCard(card, value)
	local c = card.psArrow
	if c then
		c.value = value
		paintCard(c)
		return
	end
	local holder = CreateFrame("Frame", nil, card)
	holder:SetSize(Arrow.WIDTH, Arrow.HEIGHT)
	c = { holder = holder, dial = Arrow.BuildDial(holder), value = value }
	card.psArrow = c
	local function fit()
		local h = card:GetHeight() or 0
		local s = h > 0 and min(1.2, h * 0.6 / (Arrow.DIAL * 1.4)) or 0.8
		holder:SetScale(s)
		holder:ClearAllPoints()
		-- The dial's centre a little over the card's (the card's name sits under it).
		holder:SetPoint("TOP", card, "CENTER", 0, (Arrow.DIAL / 2) + 8 / s)
	end
	card:HookScript("OnSizeChanged", fit)
	fit()
	-- Theme changes (the skin, the arrow colours) repaint it.
	W.Painter(holder, function() paintCard(c) end)
end

local function styleChoices()
	local list = {
		{ value = "skin", label = L["The skin's arrow"] }, { value = "3d", label = L["3D"] }, { value = "flat", label = L["Flat"] },
		{ value = "halo", label = L["Halo"] }, { value = "hearth", label = L["Hearth"] },
	}
	for _, c in ipairs(list) do c.draw = drawCard end
	return list
end

local function fontChoices()
	local list = { { value = "theme", label = L["Polestar's text font"], font = (Theme.FontSpec("number")) } }
	if Theme.FontChoices then
		for _, c in ipairs(Theme.FontChoices()) do list[#list + 1] = c end
	end
	return list
end

local function yards(v)
	if v <= 0 then return L["Off"] end
	return ns.FormatDistance(floor(v + 0.5))
end

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

local SPECS = {
	-- Look: the style, size, opacity, glow and arrival.
	{ page = PAGE, key = "arrow", icon = "icon-goto", order = 22, group = "look", tab = L["Look"], section = L["Style"],
		preview = buildPreview,
		subtitle = L["The waypoint arrow: its style, size, colours, glow, text and when it shows. The preview shows it on its way, closing in and arrived; right-click a setting to reset it."],
		controls = {
		H({ kind = "cards", key = "nav.arrowStyle", label = L["Arrow style"],
			search = "arrow look, arrow type, 3d arrow, flat arrow, dart, pointer, halo, hearth, skin",
			help = L["The skin's arrow (the default: 3D in Polestar's look, the Halo or Hearth dart in theirs), or one of your choice."],
			choices = styleChoices }),
		H({ kind = "slider", key = "nav.arrowScale", label = L["Arrow scale"], min = 0.5, max = 2, step = 0.05, format = percent,
			search = "arrow size, bigger arrow, smaller arrow, huge, tiny, large, scale",
			help = L["The arrow and its text together."] }),
		H({ kind = "slider", key = "nav.arrowAlpha", label = L["Arrow opacity"], min = 0.2, max = 1, step = 0.05, format = percent,
			search = "arrow transparency, alpha, see through, faint, fade",
			help = L["How solid the arrow and its text are."] }),
	} },
	{ page = PAGE, tab = L["Look"], section = L["Glow & arrival"], controls = {
		{ kind = "toggle", key = "nav.arrowGlow", label = L["Glow"], new = NEW,
			search = "glow, halo, shine, light, bloom, soft light",
			help = L["The soft light under the flat arrow, behind the arrival ring and behind a travel instruction's sign."] },
		{ kind = "slider", key = "nav.arrowGlowStrength", label = L["Glow strength"], min = 0, max = 2, step = 0.05, format = percent, new = NEW,
			child = true, disabled = glowOff,
			search = "glow brightness, brighter glow, softer glow, intensity, bloom",
			help = L["How bright the glow is: 100% as it always was."] },
		{ kind = "toggle", key = "nav.arrowPulse", label = L["Arrival animation"], new = NEW,
			search = "pulse, breathing ring, animation, motion, arrived ring, check mark",
			help = L["On arrival the ring breathes, and the skins' check follows the ring. Off: a still ring, the check at once."] },
		{ kind = "dropdown", key = "nav.arrowTurn", label = L["Turning"], new = NEW,
			search = "rotation, smoothing, damping, responsiveness, snappy, smooth, turn speed, lag",
			help = L["How quickly the arrow swings round to a new direction. Only its movement on screen: where it points is the same."],
			choices = { { value = "snappy", label = L["Snappy"] }, { value = "smooth", label = L["Smooth"] }, { value = "gentle", label = L["Gentle"] } } },
	} },

	-- Colours.
	{ page = PAGE, tab = L["Colours"], section = L["Arrow"], preview = buildPreview, controls = {
		{ kind = "color", key = "nav.arrowColor", label = L["Arrow colour"],
			search = "arrow colour, far colour, tint, accent",
			help = L["The arrow on its way; the target's pin on the maps and the route's stops wear it too. Right-click to go back to the accent."],
			shown = function() return Theme.Color("arrow") end,
			source = function() return L["Accent"] end },
		{ kind = "color", key = "nav.arrowNearColor", label = L["Arrival colour"],
			search = "near colour, close colour, arrival colour, green, success",
			help = L["The arrow as it closes on the target, and the ring when you arrive. Right-click to go back to jade."],
			shown = function() return Theme.Color("arrowNear") end,
			source = function() return L["Jade"] end },
		{ kind = "color", key = "nav.arrowRingColor", label = L["Arrived ring colour"], new = NEW,
			search = "ring colour, arrived colour, check colour, arrival ring, circle",
			help = L["The ring and the check when you arrive. Right-click to go back to the arrival colour."],
			shown = function()
				local c = ns.Get("nav.arrowRingColor")
				if type(c) == "table" then return c[1], c[2], c[3] end
				return Theme.Color("arrowNear")
			end,
			source = function() return L["Arrival colour"] end },
		{ kind = "slider", key = "nav.arrowNearRange", label = L["Colour change starts at"], min = 0, max = 600, step = 10, format = yards, new = NEW,
			search = "blend, fade, colour shift, near distance, how close, range, gradient",
			help = L["How far from the goal the arrow starts turning to the arrival colour (the skins' darts change at a sixth of it). Only the colour: arriving is the same."] },
	} },
	{ page = PAGE, tab = L["Colours"], section = L["Text"], controls = {
		{ kind = "color", key = "nav.arrowDistColor", label = L["Distance colour"], new = NEW,
			search = "distance colour, yards colour, number colour, text colour",
			help = L["The distance on the way. Right-click to go back to the text colour."],
			shown = function()
				local c = ns.Get("nav.arrowDistColor")
				if type(c) == "table" then return c[1], c[2], c[3] end
				return Theme.Color("text")
			end,
			source = function() return L["Text"] end },
		{ kind = "color", key = "nav.arrowLabelColor", label = L["Label colour"], new = NEW,
			search = "label colour, name colour, target name, destination text colour",
			help = L["The goal's name or the route's next leg under the distance. Right-click to go back to the skin's."],
			shown = function()
				local c = ns.Get("nav.arrowLabelColor")
				if type(c) == "table" then return c[1], c[2], c[3] end
				return Theme.Color("text")
			end,
			source = function() return L["Text"] end },
		{ kind = "color", key = "nav.arrowEtaColor", label = L["Arrival time colour"], new = NEW,
			search = "eta colour, time colour, arrival time colour, text colour",
			help = L["The arrival time and the arrow's last line. Right-click to go back to the text colour."],
			shown = function()
				local c = ns.Get("nav.arrowEtaColor")
				if type(c) == "table" then return c[1], c[2], c[3] end
				return Theme.Color("text")
			end,
			source = function() return L["Text"] end },
	} },

	-- Text: what shows, its type and where it sits.
	{ page = PAGE, tab = L["Text"], section = L["Distance"], preview = buildPreview, controls = {
		{ kind = "toggle", key = "nav.arrowDistance", label = L["Show the distance"], new = NEW,
			search = "distance, yards, metres, number, hide distance, how far",
			help = L["The distance on the way. Off hides the number; \"Arrived\" and the other notes still show."] },
		{ kind = "slider", key = "nav.arrowDistSize", label = L["Distance size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "distance size, bigger numbers, larger text, font size, huge, tiny",
			help = L["The distance and the arrow's notes, against the skin's size."] },
		{ kind = "dropdown", key = "nav.distanceUnit", label = L["Distances"],
			search = "units, yards, metres, meters, metric, distance",
			help = L["How the arrow, map tooltips, rares and the death helper show distances."],
			choices = { { value = "yards", label = L["Yards (the game's unit)"] }, { value = "metres", label = L["Metres"] } } },
	} },
	{ page = PAGE, tab = L["Text"], section = L["Label & time"], controls = {
		{ kind = "slider", key = "nav.arrowLabelLines", label = L["Label lines"], min = 0, max = 2, step = 1, new = NEW,
			format = function(v) v = floor(v + 0.5); return v == 0 and L["Off"] or tostring(v) end,
			search = "label, target name, destination, lines, hide label, wrap",
			help = L["How many lines the goal's name or the route's next leg may take. Off hides it."] },
		{ kind = "slider", key = "nav.arrowLabelSize", label = L["Label size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "label size, name size, bigger text, font size",
			help = L["The label, against the skin's size."] },
		{ kind = "slider", key = "nav.arrowLabelWidth", label = L["Label width"], min = 120, max = 400, step = 10, new = NEW,
			format = function(v) return string.format(L["%d px"], floor(v + 0.5)) end,
			search = "label width, wrap, wider, narrower, max width, long names",
			help = L["How wide the label may run before it wraps to its next line."] },
		H({ kind = "toggle", key = "nav.arrowEta", label = L["Arrival time"],
			search = "eta, time left, travel time, minutes",
			help = L["Estimated time under the distance."] }),
		{ kind = "slider", key = "nav.arrowEtaSize", label = L["Time size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			child = true, disabled = function() return not ns.Get("nav.arrowEta") end,
			search = "eta size, time size, smaller text, font size",
			help = L["The arrival time and the arrow's last line, against the skin's size."] },
	} },
	{ page = PAGE, tab = L["Text"], section = L["Type"], controls = {
		{ kind = "font", key = "nav.arrowFont", label = L["Font"], new = NEW,
			search = "typeface, font face, family, letters, text font",
			help = L["The arrow's text: Polestar's text font (the default), or one of its own."],
			choices = fontChoices },
		{ kind = "dropdown", key = "nav.arrowOutline", label = L["Outline"], new = NEW,
			search = "outline, border, stroke, thick, legible, readable, shadow",
			help = L["The edge round the arrow's text that keeps it readable over bright ground."],
			choices = { { value = "NONE", label = L["None"] }, { value = "OUTLINE", label = L["Thin"] }, { value = "THICKOUTLINE", label = L["Thick"] } } },
		{ kind = "dropdown", key = "nav.arrowTextPos", label = L["Text position"], new = NEW,
			search = "text above, text below, position, layout, place, move text",
			help = L["The distance and label under the arrow (the default) or over it."],
			choices = { { value = "below", label = L["Below the arrow"] }, { value = "above", label = L["Above the arrow"] } } },
		{ kind = "toggle", key = "nav.arrowBacking", label = L["Backing"], new = NEW,
			search = "background, plate, panel, backdrop, behind text, contrast, readable",
			help = L["A dark plate behind the arrow's text, for reading it over bright ground."] },
		{ kind = "slider", key = "nav.arrowBackingAlpha", label = L["Backing opacity"], min = 0.05, max = 1, step = 0.05, format = percent, new = NEW,
			child = true, disabled = function() return not ns.Get("nav.arrowBacking") end,
			search = "backing transparency, plate opacity, darker, lighter",
			help = L["How dark the plate is."] },
	} },

	-- When it shows.
	{ page = PAGE, tab = L["Visibility"], section = L["When it shows"], preview = buildPreview, controls = {
		H({ kind = "toggle", key = "nav.arrow", label = L["Show arrow"],
			search = "arrow, waypoint, pointer, direction, compass, navigation, hud, hide arrow",
			help = L["Points to the current goal."] }),
		H({ kind = "toggle", key = "nav.hideArrowWithGuide", label = L["Hide the arrow with the guide"],
			help = L["When the guide window is hidden, hide the arrow too."],
			child = true, disabled = arrowOff }),
		{ kind = "dropdown", key = "nav.arrowNoTarget", label = L["With no goal"], new = NEW,
			search = "no target, no waypoint, idle, empty, placeholder, dim, always show",
			help = L["Hide the arrow when there is nowhere to go (the default), or keep a faint ring in its place."],
			disabled = arrowOff,
			choices = { { value = "hide", label = L["Hide it"] }, { value = "dim", label = L["Show it dimmed"] } } },
		{ kind = "slider", key = "nav.arrowCombatAlpha", label = L["Opacity in combat"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			search = "combat, fight, fade in combat, hide in combat, transparency, alpha",
			help = L["How solid the arrow is while you fight, against its opacity. 0% hides it in combat."],
			disabled = arrowOff },
		H({ kind = "toggle", key = "nav.arrivalSound", label = L["Arrival sound"],
			search = "sound, chime, audio, ding",
			help = L["A soft chime when you reach a waypoint."] }),
		H({ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset arrow position"],
			help = L["Back to the top of the screen. Drag the arrow to move it."],
			onClick = function() Nav.ResetArrowPosition() end }),
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
