-- Aurora: the northern lights over Polestar, through its Skin API
-- (docs/skins in the Polestar repository). An aurora hangs in the guide
-- window's band: green-teal ribbons whose rays turn violet as they climb
-- (Media/curtain.tga, drawn in light over the band's night sky); every other
-- window, card and toast catches the same light along its top edge
-- (Media/veil.tga). Edges glow teal above and violet below, a violet halo
-- stands in for the drop shadow, and the hairlines between a window's parts
-- are lines of teal light. The grounds are a deep night that falls toward
-- black at the foot, the accent is the aurora's green-teal, and the guide
-- window's progress runs from teal into violet. Inter, the 3D arrow and the
-- map pins, all in the accent.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * textures of the skin's own drawn in LIGHT (blend mode "ADD", in their
--     own colours) over the house ground, so the player's ground colour and
--     opacity still read through;
--   * kit.gradient for the ground, and pieces of the skin's own with a
--     gradient each (the edge), kept in kit.store(frame);
--   * spec.shadow in a colour: the window's drop shadow as a glow;
--   * hooks on the guide window's own parts: guideTitle (the aurora laid
--     over the band, wherever the band is, and a line of light on the
--     navigator's rule) and guideProgress (the progress in two colours),
--     their pieces kept in the guide window's store so a transparent window,
--     or another skin, hides them with everything else.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

-- The aurora's two lights.
local TEAL = { 0.27, 0.95, 0.78 }   -- #45F2C7, the accent
local VIOLET = { 0.62, 0.45, 1 }    -- #9E73FF

---------------------------------------------------------------------------
-- The scheme: a deep night, a violet-black sky in the band for the aurora
-- to glow against, cool text, a teal-white ink, pale mint stars.
---------------------------------------------------------------------------

local ACCENT = "#45f2c7"

check("scheme aurora", Theme.RegisterScheme("aurora", {
	api = 2, name = "Aurora", addon = ADDON, author = "Polestar",
	desc = "A deep night with teal and violet light.",
	tokens = {
		bg = "#090c1cf7", panel = "#0d1127fa", panelAlt = "#151a37", sidebar = "#05070f", footer = "#070916", sky = "#100f33",
		text = "#f2f6ff", textDim = "#c3cce6", textMuted = "#99a4c8",
		ink = "#dcfff4", star = "#e6fff7", shade = "#00000c", scrim = "#03050d", onAccent = "#02130e", shadow = "#00000ab3",
	},
	accent = ACCENT,
	washes = { border = 0.12, divider = 0.12, selected = 0.14, hover = 0.08 },
}))

---------------------------------------------------------------------------
-- The skin's own colours over the scheme: hairlines of teal light, a violet
-- line under a title bar, a violet track under the progress, the house
-- haze in teal under the band's aurora.
---------------------------------------------------------------------------

local TOKENS = {
	accent = ACCENT,
	haze = "#2ef0b440",
	windowBorder = "#2c2468",
	divider = "#45f2c733", separator = "#45f2c745", rowLine = "#45f2c71c", accentLine = "#45f2c7a6", titleLine = "#9e73ff73",
	selected = "#45f2c726", hover = "#45f2c714", progress = "#9e73ff3d",
}

---------------------------------------------------------------------------
-- Paint. Everything a painter or hook makes lives in a store
-- (kit.store(frame)): Polestar hides it when another skin paints the frame.
---------------------------------------------------------------------------

local function clamp(x) return x < 0 and 0 or x > 1 and 1 or x end

local function white(frame, own, key, layer, sub)
	local t = own[key]
	if not t then
		t = frame:CreateTexture(nil, layer or "BORDER", nil, sub or 4)
		t:SetTexture(Theme.Media("white"))
		own[key] = t
	end
	t:Show()
	return t
end

-- A gradient on one of the skin's own textures: `from` is the left
-- (HORIZONTAL) or the bottom (VERTICAL), `to` the right or the top.
local function shade(t, orient, from, to)
	t:SetVertexColor(1, 1, 1, 1)
	if t.SetGradient and CreateColor then
		t:SetGradient(orient, CreateColor(from[1], from[2], from[3], from[4]), CreateColor(to[1], to[2], to[3], to[4]))
	else
		t:SetVertexColor(from[1], from[2], from[3], from[4])
	end
end

local function light(c, a) return { c[1], c[2], c[3], a } end

-- The guide window, and its store (its painter's pieces and the hooks').
local function guideWindow()
	local parts = Theme.GuideParts and Theme.GuideParts()
	local f = parts and parts.window
	if not (f and f.psSkin) then return nil end
	return f, Theme.SkinKit.store(f)
end

-- The ground's colour: the window's own or the palette's.
local function ground(frame)
	local c = frame.psBgColor
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3] end
	return Theme.Color("bg")
end

-- The ground as a night that deepens toward the foot.
local function depth(frame, kit, alpha)
	local r, g, b = ground(frame)
	kit.gradient(frame, { clamp(r * 1.45 + 0.012), clamp(g * 1.35 + 0.012), clamp(b * 1.3 + 0.03), alpha },
		{ r * 0.5, g * 0.5, b * 0.6, alpha })
end

-- The veil: the aurora's light along a window's top edge, a third of the
-- window tall at most (36 units), kept to that as the window resizes.
local function veilHeight(frame)
	local h = frame:GetHeight() or 0
	if h <= 0 then return 36 end
	return math.min(36, math.max(16, math.floor(h * 0.34 + 0.5)))
end

local function veil(frame, kit)
	local own = kit.store(frame)
	local t = own.veil
	if not t then
		t = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
		t:SetTexture(MEDIA .. "veil")
		t:SetBlendMode("ADD")
		t:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
		t:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
		own.veil = t
		if frame.HookScript then
			frame:HookScript("OnSizeChanged", function() if t:IsShown() then t:SetHeight(veilHeight(frame)) end end)
		end
	end
	t:SetHeight(veilHeight(frame))
	t:SetVertexColor(1, 1, 1, 0.6)
	t:Show()
end

-- The glowing edge, one pixel inside the window border: teal along the top
-- and down the left, violet down the right, both fading toward the foot.
local EDGES = { "edgeTop", "edgeBottom", "edgeLeft", "edgeRight" }
local function glowEdge(frame, kit)
	local own = kit.store(frame)
	local top, bottom = white(frame, own, "edgeTop"), white(frame, own, "edgeBottom")
	local left, right = white(frame, own, "edgeLeft"), white(frame, own, "edgeRight")
	if not own.edgePlaced then
		top:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
		left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		right:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
		own.edgePlaced = true
	end
	local px = Theme.Pixel(frame)
	top:SetHeight(px)
	bottom:SetHeight(px)
	left:SetWidth(px)
	right:SetWidth(px)
	shade(top, "HORIZONTAL", light(TEAL, 0.95), light(VIOLET, 0.95))
	shade(bottom, "HORIZONTAL", light(TEAL, 0.22), light(VIOLET, 0.4))
	shade(left, "VERTICAL", light(TEAL, 0.18), light(TEAL, 0.95))
	shade(right, "VERTICAL", light(VIOLET, 0.3), light(VIOLET, 0.95))
end

local function hide(own, keys)
	for _, k in ipairs(keys) do
		if own[k] then own[k]:Hide() end
	end
end

local PAINT = {
	-- Every window, the guide window and the toasts included: the house
	-- ground, border and shadow, then the night's depth, the veil (the guide
	-- window's aurora is in its band: the guideTitle hook) and the glowing
	-- edge where the player shows a border.
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		depth(frame, kit, frame.psBgAlpha or Theme.GroundAlpha())
		local own = kit.store(frame)
		if frame == guideWindow() and own.curtain and own.curtain:IsShown() then hide(own, { "veil" }) else veil(frame, kit) end
		if Theme.WindowBorder() and not frame.psNoBorder then glowEdge(frame, kit) else hide(own, EDGES) end
	end,
	-- Menus and popups: the night's depth and a line of light on top.
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b, a = Theme.Color("panel")
		kit.gradient(frame, { clamp(r * 1.3 + 0.01), clamp(g * 1.25 + 0.01), clamp(b * 1.2 + 0.02), a }, { r * 0.7, g * 0.7, b * 0.78, a })
		local own = kit.store(frame)
		local top = white(frame, own, "edgeTop")
		if not own.edgePlaced then
			top:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
			top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
			own.edgePlaced = true
		end
		top:SetHeight(Theme.Pixel(frame))
		shade(top, "HORIZONTAL", light(TEAL, 0.8), light(VIOLET, 0.8))
	end,
}

---------------------------------------------------------------------------
-- Hooks on the guide window's parts. Their pieces go in the guide window's
-- own store, so they go wherever its painter's go.
---------------------------------------------------------------------------

local HOOKS = {
	-- The aurora over the band (the tabs and the navigator), hanging toward
	-- the step: flipped when the bars sit at the window's foot. With the
	-- band off, the window keeps the veil. Then the navigator's rule as a
	-- line of light, teal into violet, with a soft glow falling from it.
	guideTitle = function(nav, parts)
		local f, own = guideWindow()
		if not (f and parts) then return end
		local band, rule = parts.band, parts.rule
		if band then
			local c = own.curtain
			if not c then
				c = f:CreateTexture(nil, "BACKGROUND", nil, -3)
				c:SetTexture(MEDIA .. "curtain")
				c:SetBlendMode("ADD")
				c:SetAllPoints(band)
				own.curtain = c
			end
			local on = Theme.ShowsBand()
			local flip = Polestar.Get("ui.growUp") and Polestar.Get("ui.barsBottom")
			c:SetTexCoord(0, 1, flip and 1 or 0, flip and 0 or 1)
			c:SetVertexColor(1, 1, 1, 0.9)
			c:SetShown(on)
			if own.veil then own.veil:SetShown(not on) end
		end
		if rule then
			local line, glow = own.ruleLine, own.ruleGlow
			if not line then
				line = nav:CreateTexture(nil, "ARTWORK", nil, 5)
				line:SetTexture(Theme.Media("white"))
				line:SetAllPoints(rule)
				glow = nav:CreateTexture(nil, "ARTWORK", nil, 4)
				glow:SetTexture(Theme.Media("white"))
				glow:SetBlendMode("ADD")
				glow:SetPoint("TOPLEFT", rule, "BOTTOMLEFT", 0, 0)
				glow:SetPoint("TOPRIGHT", rule, "BOTTOMRIGHT", 0, 0)
				glow:SetHeight(10)
				own.ruleLine, own.ruleGlow = line, glow
			end
			local on = rule:IsShown()
			line:SetShown(on)
			glow:SetShown(on)
			shade(line, "HORIZONTAL", light(TEAL, 0.75), light(VIOLET, 0.75))
			shade(glow, "VERTICAL", light(TEAL, 0), light(TEAL, 0.14))
		end
	end,
	-- The progress filled teal into violet.
	guideProgress = function(foot, frac)
		local f, own = guideWindow()
		local fill = foot and foot.Line and foot.Line.Fill
		if not (f and fill) then return end
		local t = own.progress
		if not t then
			t = foot.Line:CreateTexture(nil, "ARTWORK", nil, 3)
			t:SetTexture(Theme.Media("white"))
			t:SetAllPoints(fill)
			own.progress = t
		end
		t:SetShown(not f.psBare and frac > 0)
		shade(t, "HORIZONTAL", light(TEAL, 1), light(VIOLET, 1))
	end,
}

---------------------------------------------------------------------------
-- The layout: the band's light and the halo on, the shadow a little
-- stronger, the route on the map a line of violet light. Offered on the
-- Theme page where this Polestar has presets.
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "standard", ["ui.band"] = true, ["ui.shadow"] = true, ["ui.haze"] = true, ["ui.rim"] = true,
	["ui.border"] = true, ["ui.starAlpha"] = 1, ["ui.shadowStrength"] = 1.3,
	["nav.lineStyle"] = "line", ["nav.walkColor"] = { 0.69, 0.55, 1 },
}

check("skin aurora", Theme.RegisterSkin("aurora", {
	api = 2,
	name = "Aurora",
	addon = ADDON,
	author = "Polestar",
	desc = "The northern lights over Polestar: teal and violet light in the band and on every window's edge, a deep night, Inter.",
	base = "polestar",
	scheme = "aurora",
	tokens = TOKENS,
	font = "inter",
	-- The drop shadow as a violet glow round each window.
	shadow = { size = 16, drop = 0, alpha = 0.5, color = "#7a5cff" },
	arrow = "3d",
	mapIcons = "polestar",
	paint = PAINT,
	hooks = HOOKS,
	preset = PRESET,
}))
