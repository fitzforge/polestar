-- The settings window's Arrow page (look group, key "arrow"): the waypoint
-- arrow's style, size, colours, glow, arrival, text and when it shows, every
-- row with real effect on the live arrow (Nav/Arrow.lua reads them on
-- SETTING_CHANGED and repaints in place).
--
-- Each tab pins a band over its rows (UI.Preview.Band): sandbox dials built
-- and painted by the arrow's own code (Arrow.BuildDial / Arrow.PaintDial) at
-- their real size, in the states that tab's settings change, with the
-- current values: Essentials on its way, closing in and in combat; Look the
-- arrival too; Text one dial with its distance, label and time lines. The
-- band has no target, no sampling and no Nav hook, and never touches the
-- live arrow; it runs an OnUpdate only while shown and the arrival
-- animates. Nothing is built until the page first shows.

local ns = Polestar
local Nav = ns.Nav
local Arrow = Nav and Nav.arrow
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Arrow and Arrow.BuildDial and ns.RegisterOptions and Theme and W) then return end

local floor, min, max = math.floor, math.min, math.max

local PAGE = L["Arrow"]
local NEW = "0.3.8"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
-- Guidance options with no effect while Shortest Path Forever guides (Nav/Handoff.lua).
local function H(c) return Nav.HandoffOption and Nav.HandoffOption(c) or c end
local function arrowOff() return not ns.Get("nav.arrow") end

---------------------------------------------------------------------------
-- The previews
---------------------------------------------------------------------------

-- Each tab's band (UI.Preview.Band): Nav's own dial (Arrow.BuildDial,
-- Arrow.PaintDial) in the states that tab's settings change, side by side at
-- its real size, a label under each. Essentials: on its way, closing in (the
-- near colour), in combat (the combat opacity); Look the arrival too (its
-- ring breathing while it shows); Text one dial on its way, its distance,
-- label and time lines.
local STATE = {
	travel = { state = "travel", angle = 0.6, dist = 420, eta = 95, label = L["On its way"] },
	near = { state = "travel", angle = -0.3, dist = 40, eta = 9, label = L["Closing in"], near = true },
	arrived = { state = "arrived", label = L["Arrived"] },
	combat = { state = "travel", angle = 0.6, dist = 420, eta = 95, label = L["In combat"], combat = true },
}
local TABS = {
	essentials = { "travel", "near", "combat" },
	look = { "travel", "near", "arrived", "combat" },
	text = { "travel" },
}
-- What each setting lights on a band: kind -> the parts of its dials.
local LIGHTS = {
	holders = { "nav.arrow", "nav.arrowScale", "nav.arrowAlpha", "nav.hideArrowWithGuide", "nav.arrowNoTarget" },
	dials = { "nav.arrowStyle", "nav.arrowGlowStrength", "nav.arrowGlow" },
	far = { "nav.arrowColor" },
	near = { "nav.arrowNearColor", "nav.arrowNearRange" },
	moving = { "nav.arrowTurn" },
	arrived = { "nav.arrowRingColor", "nav.arrowPulse", "nav.arrivalSound" },
	combat = { "nav.arrowCombatAlpha" },
	dist = { "nav.arrowDistSize", "nav.arrowDistance", "nav.arrowDistColor", "nav.distanceUnit" },
	label = { "nav.arrowLabelSize", "nav.arrowLabelColor", "nav.arrowLabelLines", "nav.arrowLabelWidth" },
	eta = { "nav.arrowEtaSize", "nav.arrowEta", "nav.arrowEtaColor" },
	text = { "nav.arrowTextPos", "nav.arrowFont", "nav.arrowOutline", "nav.arrowBacking", "nav.arrowBackingAlpha" },
}

local function clamp(v, lo, hi, default)
	v = tonumber(v) or default
	return min(hi, max(lo, v))
end

local function buildBand(view, which)
	local Preview = ns.UI.Preview
	local f = Preview.Band(view, { watch = { "nav." } })
	local lk, cols = {}, {}
	for i, key in ipairs(TABS[which]) do
		local s = STATE[key]
		local holder = CreateFrame("Frame", nil, f)
		holder:SetSize(Arrow.WIDTH, Arrow.HEIGHT)
		cols[i] = { holder = holder, dial = Arrow.BuildDial(holder), s = s, label = #TABS[which] > 1 and f:Label(s.label) or nil }
	end
	f.Dials = cols

	-- A click on a dial or a line of text finds its row; the pointer on a
	-- setting's row lights the parts it changes.
	local first = cols[1].dial
	f:Hot(first.dial, "nav.arrowScale")
	for i = 2, #cols do
		local s = cols[i].s
		f:Hot(cols[i].dial.dial, s.combat and "nav.arrowCombatAlpha" or s.state == "arrived" and "nav.arrowRingColor" or "nav.arrowNearColor")
	end
	f:Hot(first.distText, "nav.arrowDistSize")
	f:Hot(first.labelText, "nav.arrowLabelSize")
	f:Hot(first.etaText, "nav.arrowEtaSize")
	local parts = { holders = {}, dials = {}, far = {}, near = {}, moving = {}, arrived = {}, combat = {}, dist = {}, label = {}, eta = {}, text = {} }
	local function add(kind, region) parts[kind][#parts[kind] + 1] = region end
	for _, c in ipairs(cols) do
		local s, d = c.s, c.dial
		add("holders", c.holder)
		add("dials", d.dial)
		add("label", d.labelText)
		add("text", d.labelText)
		if s.state == "arrived" then
			add("arrived", d.dial)
		else
			add("moving", d.dial)
			add(s.near and "near" or "far", d.dial)
			add("dist", d.distText)
			add("eta", d.etaText)
			add("text", d.distText)
			add("text", d.etaText)
		end
		if s.combat then add("combat", c.holder) end
	end
	for kind, keys in pairs(LIGHTS) do
		if #parts[kind] > 0 then
			for _, key in ipairs(keys) do f:Light(key, unpack(parts[kind])) end
		end
	end

	-- The arrival's ring breathes while the band shows (with the pulse on).
	local arrived
	for _, c in ipairs(cols) do if c.s.state == "arrived" then arrived = c.dial end end
	local pulseT = 0
	local function animating()
		return arrived and lk.pulse and (arrived.ring:IsShown() or (arrived.skinRing:IsShown() and not arrived.skinCheck:IsShown()))
	end
	local function onUpdate(_, elapsed)
		pulseT = pulseT + elapsed
		Arrow.PulseDial(arrived, pulseT)
		if not animating() then f:SetScript("OnUpdate", nil) end
	end
	f:HookScript("OnShow", function(self) if animating() then self:SetScript("OnUpdate", onUpdate) end end)
	f:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)

	local snap, gap = Preview.Snap, Preview.STATE_GAP
	function f:Content()
		Arrow.ReadLook(lk)
		local style = Arrow.StyleFor(ns.Get("nav.arrowStyle"))
		local g0 = clamp(ns.Get("nav.arrowScale"), 0.5, 2, 1) * self:TrueScale()
		local alpha = clamp(ns.Get("nav.arrowAlpha"), 0.1, 1, 1)
		local fight = clamp(ns.Get("nav.arrowCombatAlpha"), 0, 1, 1)
		local w, h = Arrow.WIDTH * g0, Arrow.HEIGHT * g0
		local labels = {}
		for i, c in ipairs(cols) do
			local s = c.s
			Arrow.PaintDial(c.dial, lk, style, s.state, s.angle, s.dist, L["The innkeeper"], s.eta)
			c.holder:SetAlpha(alpha * (s.combat and fight or 1))
			if c.label then labels[#labels + 1] = { c.label, (i - 1) * (w + gap) + w / 2 } end
		end
		pulseT = 0
		self:SetScript("OnUpdate", self:IsVisible() and animating() and onUpdate or nil)
		return #cols * w + (#cols - 1) * gap, h, function(left, top, k)
			local g = g0 * k
			for i, c in ipairs(cols) do
				c.holder:SetScale(g)
				c.holder:ClearAllPoints()
				c.holder:SetPoint("TOPLEFT", self, "TOPLEFT", snap(c.holder, (left + (i - 1) * (w + gap) * k) / g), snap(c.holder, -top / g))
			end
		end, #labels > 0 and labels or nil
	end
	return f
end

local function buildEssentialsBand(view) return buildBand(view, "essentials") end
local function buildLookBand(view) return buildBand(view, "look") end
local function buildTextBand(view) return buildBand(view, "text") end
-- The previews, for the tests: ArrowPreview(parent) the Look tab's (every
-- state), ArrowEssentialsPreview and ArrowTextPreview the others' -> f.
Nav.ArrowPreview = buildLookBand
Nav.ArrowEssentialsPreview = buildEssentialsBand
Nav.ArrowTextPreview = buildTextBand

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
-- The controls (layout v2: one section per part of the arrow, in the order
-- it is drawn: the arrow, its glow, its arrival, then its text lines; the
-- part's on/off in the section header, its size and colour on one row, the
-- finer knobs behind the row's cog; help is the label's tooltip)
---------------------------------------------------------------------------

local function pickedOr(key, token)
	return function()
		local c = ns.Get(key)
		if type(c) == "table" then return c[1], c[2], c[3] end
		return Theme.Color(token)
	end
end

local SPECS = {
	-- Look: the arrow itself, its glow, its arrival, when it shows.
	{ page = PAGE, key = "arrow", icon = "icon-goto", order = 22, group = "look", tab = L["Look"], section = L["Arrow"],
		preview = buildLookBand,
		subtitle = L["The waypoint arrow: its style, size, colours, glow, arrival, text and when it shows."],
		toggle = H({ kind = "toggle", key = "nav.arrow", label = L["Show arrow"],
			search = "arrow, waypoint, pointer, direction, compass, navigation, hud, hide arrow",
			help = L["Points to the current goal."] }),
		controls = {
		H({ kind = "cards", key = "nav.arrowStyle", label = L["Style"], wide = true,
			search = "arrow style, arrow look, arrow type, 3d arrow, flat arrow, dart, pointer, halo, hearth, skin",
			help = L["The skin's arrow (the default: 3D in Polestar's look, the Halo or Hearth dart in theirs), or one of your choice."],
			choices = styleChoices }),
		H({ kind = "slider", key = "nav.arrowScale", label = L["Size"], min = 0.5, max = 2, step = 0.05, format = percent,
			search = "arrow scale, arrow size, bigger arrow, smaller arrow, huge, tiny, large, scale",
			help = L["The arrow and its text together."],
			extras = {
				{ kind = "color", key = "nav.arrowColor", label = L["Arrow colour"],
					search = "arrow colour, far colour, tint, accent",
					help = L["The arrow on its way; the target's pin on the maps and the route's stops wear it too. Right-click to go back to the accent."],
					shown = function() return Theme.Color("arrow") end,
					source = function() return L["Accent"] end },
			} }),
		H({ kind = "slider", key = "nav.arrowAlpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = percent,
			search = "arrow opacity, arrow transparency, alpha, see through, faint, fade",
			help = L["How solid the arrow and its text are."] }),
		{ kind = "color", key = "nav.arrowNearColor", label = L["Near colour"],
			search = "arrival colour, near colour, close colour, green, success",
			help = L["The arrow's colour as it closes on the goal, and the ring when you arrive. Right-click to go back to jade."],
			shown = function() return Theme.Color("arrowNear") end,
			source = function() return L["Jade"] end,
			more = {
				{ kind = "slider", key = "nav.arrowNearRange", label = L["Starts at"], min = 0, max = 600, step = 10, format = yards, new = NEW,
					search = "blend, fade, colour shift, colour change, near distance, how close, range, gradient",
					help = L["How far from the goal the arrow starts turning to this colour (the skins' darts change at a sixth of it). Only the colour: arriving is the same."] },
			} },
		{ kind = "dropdown", key = "nav.arrowTurn", label = L["Turning"], new = NEW, info = true,
			search = "rotation, smoothing, damping, responsiveness, snappy, smooth, turn speed, lag",
			help = L["How quickly the arrow swings round to a new direction. Only its movement on screen: where it points is the same."],
			choices = { { value = "snappy", label = L["Snappy"] }, { value = "smooth", label = L["Smooth"] }, { value = "gentle", label = L["Gentle"] } } },
	} },
	{ page = PAGE, tab = L["Look"], section = L["Arrival"], controls = {
		{ kind = "color", key = "nav.arrowRingColor", label = L["Ring colour"], new = NEW,
			search = "ring colour, arrived colour, check colour, arrival ring, circle",
			help = L["The ring and the check when you arrive. Right-click to go back to the near colour."],
			shown = pickedOr("nav.arrowRingColor", "arrowNear"),
			source = function() return L["Near colour"] end },
		{ kind = "toggle", key = "nav.arrowPulse", label = L["Pulse"], new = NEW,
			search = "pulse, breathing ring, arrival animation, motion, arrived ring, check mark",
			help = L["On arrival the ring breathes, and the skins' check follows the ring. Off: a still ring, the check at once."] },
		{ kind = "slider", key = "nav.arrowGlowStrength", label = L["Glow"], min = 0, max = 2, step = 0.05, format = percent, new = NEW,
			search = "glow, glow strength, glow brightness, brighter glow, softer glow, intensity, bloom, halo, shine",
			help = L["The soft light under the flat arrow, behind the arrival ring and behind a travel instruction's sign: the switch turns it off, the slider sets how bright it is (100% as it always was)."],
			extras = {
				{ kind = "toggle", key = "nav.arrowGlow", label = L["Glow"], new = NEW,
					search = "glow on, glow off, halo, shine, light, bloom, soft light",
					help = L["The soft light under the flat arrow, behind the arrival ring and behind a travel instruction's sign."] },
			} },
		H({ kind = "toggle", key = "nav.arrivalSound", label = L["Sound"],
			search = "arrival sound, chime, audio, ding",
			help = L["A soft chime when you reach a waypoint."] }),
	} },
	{ page = PAGE, tab = L["Look"], section = L["Visibility"], controls = {
		H({ kind = "toggle", key = "nav.hideArrowWithGuide", label = L["Hide with guide"],
			search = "hide the arrow with the guide, guide hidden, window closed",
			help = L["When the guide window is hidden, hide the arrow too."],
			disabled = arrowOff }),
		{ kind = "dropdown", key = "nav.arrowNoTarget", label = L["No goal"], new = NEW,
			search = "no target, no waypoint, idle, empty, placeholder, dim, always show",
			help = L["Hide the arrow when there is nowhere to go (the default), or keep a faint ring in its place."],
			disabled = arrowOff,
			choices = { { value = "hide", label = L["Hide it"] }, { value = "dim", label = L["Show it dimmed"] } } },
		{ kind = "slider", key = "nav.arrowCombatAlpha", label = L["Combat opacity"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			search = "opacity in combat, fight, fade in combat, hide in combat, transparency, alpha",
			help = L["How solid the arrow is while you fight, against its opacity. 0% hides it in combat."],
			disabled = arrowOff },
		H({ kind = "button", icon = "reset", button = L["Reset"], label = L["Position"],
			search = "reset arrow position, move arrow, default place, top of the screen",
			help = L["Back to the top of the screen. Drag the arrow to move it."],
			onClick = function() Nav.ResetArrowPosition() end }),
	} },

	-- Text: one card, a row per line of text (size and colour, its on/off as a
	-- switch), then the face and the backing.
	{ page = PAGE, tab = L["Text"], section = L["Text"], preview = buildTextBand, controls = {
		{ kind = "slider", key = "nav.arrowDistSize", label = L["Distance size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "distance size, bigger numbers, larger text, text size, font size, huge, tiny",
			help = L["The distance and the arrow's notes, against the skin's size. The switch hides the distance on the way; \"Arrived\" and the other notes still show."],
			extras = {
				{ kind = "toggle", key = "nav.arrowDistance", label = L["Distance"], new = NEW,
					search = "show the distance, yards, metres, number, hide distance, how far",
					help = L["The distance on the way. Off hides the number; \"Arrived\" and the other notes still show."] },
				{ kind = "color", key = "nav.arrowDistColor", label = L["Distance colour"], new = NEW,
					search = "distance colour, yards colour, number colour, text colour",
					help = L["The distance on the way. Right-click to go back to the text colour."],
					shown = pickedOr("nav.arrowDistColor", "text"),
					source = function() return L["Text"] end },
			} },
		{ kind = "dropdown", key = "nav.distanceUnit", label = L["Units"],
			search = "distances, units, yards, metres, meters, metric, distance",
			help = L["How the arrow, map tooltips, rares and the death helper show distances."],
			choices = { { value = "yards", label = L["Yards"] }, { value = "metres", label = L["Metres"] } } },
		{ kind = "slider", key = "nav.arrowLabelSize", label = L["Label size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "label size, name size, bigger text, text size, font size",
			help = L["The goal's name or the route's next leg, against the skin's size."],
			extras = {
				{ kind = "color", key = "nav.arrowLabelColor", label = L["Label colour"], new = NEW,
					search = "label colour, name colour, target name, destination text colour",
					help = L["The goal's name or the route's next leg. Right-click to go back to the skin's."],
					shown = pickedOr("nav.arrowLabelColor", "text"),
					source = function() return L["Text"] end },
			},
			more = {
				{ kind = "slider", key = "nav.arrowLabelWidth", label = L["Width"], min = 120, max = 400, step = 10, new = NEW,
					format = function(v) return string.format(L["%d px"], floor(v + 0.5)) end,
					search = "label width, wrap, wider, narrower, max width, long names",
					help = L["How wide the label may run before it wraps to its next line."] },
			} },
		{ kind = "slider", key = "nav.arrowLabelLines", label = L["Label lines"], min = 0, max = 2, step = 1, new = NEW,
			format = function(v) v = floor(v + 0.5); return v == 0 and L["Off"] or tostring(v) end,
			search = "label lines, target name, destination, hide label, wrap, hide text, step text, objective text, quest text under the arrow, text under arrow, arrow text",
			help = L["How many lines the goal's name or the route's next leg may take. Off hides it."] },
		{ kind = "slider", key = "nav.arrowEtaSize", label = L["Arrival time"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "eta size, time size, arrival time size, smaller text, text size, font size",
			help = L["The estimated time under the distance, and the arrow's last line, against the skin's size. The switch shows or hides the time."],
			extras = {
				H({ kind = "toggle", key = "nav.arrowEta", label = L["Arrival time"],
					search = "eta, time left, travel time, minutes, show arrival time",
					help = L["Estimated time under the distance."] }),
				{ kind = "color", key = "nav.arrowEtaColor", label = L["Arrival time colour"], new = NEW,
					search = "eta colour, time colour, arrival time colour, text colour",
					help = L["The arrival time and the arrow's last line. Right-click to go back to the text colour."],
					shown = pickedOr("nav.arrowEtaColor", "text"),
					source = function() return L["Text"] end },
			} },
		{ kind = "dropdown", key = "nav.arrowTextPos", label = L["Position"], new = NEW,
			search = "text position, text above, text below, layout, place, move text",
			help = L["The distance and label under the arrow (the default) or over it."],
			choices = { { value = "below", label = L["Below the arrow"] }, { value = "above", label = L["Above the arrow"] } } },
		{ kind = "font", key = "nav.arrowFont", label = L["Font"], new = NEW,
			search = "typeface, font face, family, letters, text font",
			help = L["The arrow's text: Polestar's text font (the default), or one of its own."],
			choices = fontChoices,
			more = {
				{ kind = "dropdown", key = "nav.arrowOutline", label = L["Outline"], new = NEW,
					search = "outline, border, stroke, thick, legible, readable, shadow",
					help = L["The edge round the arrow's text that keeps it readable over bright ground."],
					choices = { { value = "NONE", label = L["None"] }, { value = "OUTLINE", label = L["Thin"] }, { value = "THICKOUTLINE", label = L["Thick"] } } },
			} },
		{ kind = "toggle", key = "nav.arrowBacking", label = L["Backing"], new = NEW,
			search = "background, plate, panel, backdrop, behind text, contrast, readable",
			help = L["A dark plate behind the arrow's text, for reading it over bright ground."],
			more = {
				{ kind = "slider", key = "nav.arrowBackingAlpha", label = L["Opacity"], min = 0.05, max = 1, step = 0.05, format = percent, new = NEW,
					disabled = function() return not ns.Get("nav.arrowBacking") end,
					search = "backing opacity, backing transparency, plate opacity, darker, lighter",
					help = L["How dark the plate is."] },
			} },
	} },
}

-- Essentials (the page's lead tab): the arrow's styles, then the ten
-- settings players change most, each a reference to its row on Look or Text.
local O = ns.UI and ns.UI.Options
if O and O.Ref then
	local R = O.Ref
	local ESSENTIALS = L["Essentials"]
	local list = {
		{ page = PAGE, tab = ESSENTIALS, lead = true, section = L["Style"], preview = buildEssentialsBand,
			controls = { R("cards", "nav.arrowStyle") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Arrow"], jump = { tab = L["Look"], section = L["Arrow"] },
			toggle = R("toggle", "nav.arrow"),
			controls = { R("slider", "nav.arrowScale"), R("slider", "nav.arrowAlpha"), R("color", "nav.arrowNearColor"), R("slider", "nav.arrowGlowStrength"),
				R("toggle", "nav.hideArrowWithGuide"), R("slider", "nav.arrowCombatAlpha") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Text"], jump = { tab = L["Text"], section = L["Text"] },
			controls = { R("slider", "nav.arrowDistSize"), R("slider", "nav.arrowLabelLines"), R("slider", "nav.arrowEtaSize"), R("dropdown", "nav.distanceUnit") } },
	}
	for _, spec in ipairs(list) do SPECS[#SPECS + 1] = spec end
end

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
