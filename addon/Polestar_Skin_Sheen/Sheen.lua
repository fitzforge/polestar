-- Sheen: soft glass and gradients, through Polestar's Skin API (docs/skins
-- in the Polestar repository). Translucent dark panels at 80 %, a wide soft
-- shadow under every window, a faint sheen along the top of each panel
-- (light caught on glass), the character's class colour running into the
-- accent along the progress line, Fira Sans, the flat dart with a cyan
-- glow, the map pins' rims in the class colour.
--
-- What this skin shows:
--   * `shadow`: the window shadow's size and drop as the skin's own;
--   * `resolve(ctx)` for the class colour, and a gradient across the
--     progress line in the `guideProgress` hook;
--   * `kit.glow` for the sheen.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local TOKENS = {
	bg = "#0a0f16cc", panel = "#0d131cf0", panelAlt = "#ffffff14", sidebar = "#070b11e6", footer = "#070b11e6", sky = "#0f1824",
	text = "#f2f6fa", textDim = "#c2ccd8", textMuted = "#8f9bab",
	ink = "#e6f0fa", star = "#ffffff99", shade = "#000000", scrim = "#04070b", onAccent = "#07111a", shadow = "#000000bf",
	accent = "#7fdcea", glow = "#7fdcea",
	border = "#e6f0fa1f", divider = "#e6f0fa14", separator = "#e6f0fa14", rowLine = "#e6f0fa0d",
	hover = "#e6f0fa12", selected = "#e6f0fa1f",
	haze = "#7fdcea33",
}

-- The class colour in use (from resolve; nil until Polestar knows the
-- class), and the two ends of the gradients: the class colour, the accent.
local classColor
local function ends()
	local ar, ag, ab = Theme.Accent()
	local c = classColor or { ar, ag, ab }
	return { c[1], c[2], c[3], 1 }, { ar, ag, ab, 1 }
end

-- The sheen: a wide, flat glow hung from the top edge, white and faint, so
-- the panel's top catches the light.
local function sheen(frame, kit, alpha)
	local w = frame:GetWidth() or 300
	kit.glow(frame, { key = "sheen", point = "TOP", offset = { 0, 6 }, size = { w * 1.1, 60 },
		color = { 1, 1, 1, alpha }, blend = "ADD", layer = "BACKGROUND", sub = -5 })
end

local function glass(alpha)
	return function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		sheen(frame, kit, alpha)
	end
end

local PAINT = { window = glass(0.08), panel = glass(0.06) }

-- A texture from the class colour on the left to the accent on the right.
local function duotone(t)
	if not (t and t.SetGradient and CreateColor) then return end
	local from, to = ends()
	t:SetVertexColor(1, 1, 1, 1)
	t:SetGradient("HORIZONTAL", CreateColor(from[1], from[2], from[3], 1), CreateColor(to[1], to[2], to[3], 1))
end

-- The progress line's fill (foot.Line.Fill), each time Polestar paints it.
local HOOKS = {
	guideProgress = function(foot)
		duotone(foot.Line and foot.Line.Fill)
	end,
}

check("skin sheen", Theme.RegisterSkin("sheen", {
	api = 2,
	name = "Sheen",
	addon = ADDON,
	author = "Polestar",
	desc = "Soft glass: translucent panels, a wide shadow, a sheen on every top edge, your class colour running into the accent.",
	base = "polestar",
	tokens = TOKENS,
	font = "fira",
	arrow = "flat",
	mapIcons = "polestar",
	paint = PAINT,
	hooks = HOOKS,
	shadow = { size = 32, drop = 6 },
	resolve = function(ctx)
		classColor = ctx and ctx.classColor or nil
		return classColor and { pinRing = { classColor[1], classColor[2], classColor[3], 1 } } or {}
	end,
	preset = {
		["ui.style"] = "standard", ["ui.bgOpacity"] = 0.8, ["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.6,
		["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.shadow"] = true, ["ui.shadowStrength"] = 1.4, ["ui.rim"] = true,
		["guideWindow.progressHeight"] = 3,
		["nav.arrowGlow"] = true, ["nav.arrowGlowStrength"] = 1.3, ["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3,
	},
}))
