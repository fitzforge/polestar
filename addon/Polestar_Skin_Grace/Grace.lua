-- Grace: luxury minimal, through Polestar's Skin API (docs/SKINS-API.md in
-- the Polestar repository). Not a box: every window is a black veil that
-- is darkest at its head and thins toward its foot, with one hairline of
-- antique gold along the top edge and nothing else drawn around it. A
-- serif for every string (Spectral, OFL, shipped in Fonts/), a hard shadow
-- under it so the thinner foot still reads over the world, antique gold
-- for the accent, the flat dart in the same gold.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * kit.gradient as the whole frame: a veil instead of a panel, the
--     player's own ground colour and opacity still read through;
--   * a serif of the skin's own, with the ladder's sizes raised a point
--     where serifs read small;
--   * a preset that turns the house border and shadow off and leaves the
--     band on (the stars sit well in the veil's head).
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end

local FONTS = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\"

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local TOKENS = {
	-- The window ground is given at the veil's mean opacity, so the
	-- legibility check sees what the text sits on at the window's middle.
	bg = "#040404a6", panel = "#0a0a0af2", panelAlt = "#ffffff12", sidebar = "#030303d9", footer = "#030303d9", sky = "#141210",
	text = "#f5f1e8", textDim = "#cfc8b8", textMuted = "#a39b8a",
	ink = "#f5f1e8", star = "#f0e4c0", shade = "#000000", scrim = "#000000", onAccent = "#17130c", shadow = "#00000000",
	accent = "#c9a85c",
	border = "#c9a85c00", divider = "#f5f1e814", separator = "#f5f1e814", rowLine = "#f5f1e80d",
	hover = "#f5f1e80f", selected = "#f5f1e81a",
	haze = "#c9a85c2e",
}

local function clamp(x) return x < 0 and 0 or x > 1 and 1 or x end

-- The veil: the window ground at full strength at the head, at a third of
-- it at the foot, the player's own ground colour kept.
local function veil(frame, kit, alpha)
	local r, g, b = Theme.Color("bg")
	local c = frame.psBgColor
	if type(c) == "table" and type(c[1]) == "number" then r, g, b = c[1], c[2], c[3] end
	kit.gradient(frame, { r, g, b, clamp(alpha * 1.1) }, { r, g, b, alpha * 0.35 })
end

-- One hairline of gold along the top edge.
local function rule(frame, kit, alpha)
	local own = kit.store(frame)
	if not own.rule then
		own.rule = frame:CreateTexture(nil, "BORDER", nil, 3)
		own.rule:SetTexture(Theme.Media("white"))
		own.rule:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		own.rule:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		own.rule:SetHeight(1)
	end
	local r, g, b = Theme.Accent()
	own.rule:SetVertexColor(r, g, b, alpha)
	own.rule:Show()
end

local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		veil(frame, kit, frame.psBgAlpha or Theme.GroundAlpha())
		rule(frame, kit, 0.85)
	end,
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		kit.hideBorder(frame)
		rule(frame, kit, 0.6)
	end,
	-- Buttons and fields: no box, a gold hairline under them.
	button = function(frame, base, kit)
		base(frame)
		kit.hideBorder(frame)
		kit.fill(frame):SetVertexColor(Theme.Color("panelAlt"))
	end,
	inset = function(frame, base, kit)
		base(frame)
		kit.fill(frame):SetVertexColor(1, 1, 1, 0.03)
	end,
}

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.9, ["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.6,
	["ui.border"] = false, ["ui.shadow"] = false, ["ui.rim"] = false,
	["guideWindow.rules"] = false, ["guideWindow.progressHeight"] = 1,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 2, ["nav.arrowGlow"] = false,
}

local spec = {
	api = 1,
	name = "Grace",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Luxury minimal: a black veil that thins toward its foot, one gold hairline, a serif for every word.",
	base = "polestar",
	tokens = TOKENS,
	font = { regular = FONTS .. "Spectral-Medium.ttf", medium = FONTS .. "Spectral-SemiBold.ttf", semibold = FONTS .. "Spectral-Bold.ttf" },
	fontSizes = { hero = 28, display = 20, title = 16, heading = 14, body = 14, label = 13, note = 13, small = 12, number = 13,
		caption = 12, goal = 15, name = 16, mono = 13 },
	textShadow = { 1, -1, 1 },
	arrow = "flat",
	mapIcons = "polestar",
	paint = PAINT,
}
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin grace", Theme.RegisterSkin("grace", spec))
