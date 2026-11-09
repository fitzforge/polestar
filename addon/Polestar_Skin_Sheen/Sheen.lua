-- Sheen: soft glass and gradients, through Polestar's Skin API
-- (docs/SKINS-API.md in the Polestar repository). Translucent dark panels
-- at 80 %, a wide soft shadow under every window, a faint sheen along the
-- top of each panel (light caught on glass), a horizontal gradient from the
-- character's class colour to the accent on the title rule and the
-- progress line, Fira Sans, the flat dart with a soft glow that blooms on
-- arrival. Map pins as glass discs: the class colour on their rims.
--
-- What this example shows (Skin API 2; an older Polestar loads it as the
-- glass panels and the flat dart without the gradients and the glow):
--   * `shadow`: the window shadow's size, drop and strength as a skin's own;
--   * `kit.gradient(…, "HORIZONTAL")` on the progress and title-rule hooks,
--     from `ctx.classColor` (through `resolve`) to the accent;
--   * `kit.glow` for the sheen and for the arrival bloom in `hooks.arrow`,
--     which reads the arrow's state.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end
local V2 = Theme.API_VERSION >= 2

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
	accent = "#7fdcea",
	border = "#e6f0fa1f", divider = "#e6f0fa14", separator = "#e6f0fa14", rowLine = "#e6f0fa0d",
	hover = "#e6f0fa12", selected = "#e6f0fa1f",
	haze = "#7fdcea33",
}

-- The class colour in use (from resolve), else the accent.
local classColor

local function ends()
	local ar, ag, ab = Theme.Accent()
	local c = classColor or { ar, ag, ab }
	return c, { ar, ag, ab }
end

-- The sheen: a wide, flat glow hung from the top edge, white and faint,
-- so the panel's top catches the light.
local function sheen(frame, kit, alpha)
	if not (V2 and kit.glow) then return end
	local own = kit.store(frame)
	if not own.sheen then
		own.sheen = kit.glow(frame, { point = "TOP", offset = { 0, 6 }, size = { (frame:GetWidth() or 300) * 1.1, 60 },
			color = { 1, 1, 1, alpha }, blend = "ADD", layer = "BACKGROUND", sub = -5, key = "sheen" })
	end
	own.sheen:SetSize((frame:GetWidth() or 300) * 1.1, 60)
	own.sheen:SetVertexColor(1, 1, 1, alpha)
	own.sheen:Show()
end

local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		sheen(frame, kit, 0.08)
	end,
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		sheen(frame, kit, 0.06)
	end,
	-- Glass controls: the panelAlt wash, a brighter top line.
	button = function(frame, base, kit)
		base(frame)
		sheen(frame, kit, 0.05)
	end,
}

-- The horizontal class → accent gradient on a filled part (the progress
-- line's fill, the title rule).
local function duotone(frame, part, base, kit)
	base(frame, part)
	if not (V2 and part and part.SetGradient) then return end
	local from, to = ends()
	if part.SetGradient and CreateColor then
		part:SetVertexColor(1, 1, 1, 1)
		part:SetGradient("HORIZONTAL", CreateColor(from[1], from[2], from[3], 1), CreateColor(to[1], to[2], to[3], 1))
	end
end

local HOOKS = {
	progress = duotone,
	titleRule = duotone,
	-- The arrival bloom: a soft glow behind the dial that shows at
	-- "arrived" and fades out otherwise.
	arrow = function(frame, style, state)
		local own = frame.psSheen
		if not own then
			own = {}
			frame.psSheen = own
			own.bloom = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			own.bloom:SetTexture(Theme.Media("glow"))
			own.bloom:SetBlendMode("ADD")
			own.bloom:SetPoint("CENTER", frame, "CENTER", 0, 0)
		end
		local w = frame:GetWidth() or 64
		own.bloom:SetSize(w * 2.2, w * 2.2)
		local r, g, b = Theme.Color("arrowNear")
		own.bloom:SetVertexColor(r, g, b, 0.55)
		own.bloom:SetShown(state == "arrived")
	end,
}

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.8, ["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.6,
	["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.shadow"] = true, ["ui.shadowStrength"] = 1.4, ["ui.rim"] = true,
	["ui.classAccent"] = false,
	["guideWindow.progressHeight"] = 3,
	["nav.arrowGlow"] = true, ["nav.arrowGlowStrength"] = 1.3, ["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3,
}

local spec = {
	api = V2 and 2 or 1,
	name = "Sheen",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Soft glass: translucent panels, a wide shadow, a sheen on every top edge, your class colour running into the accent.",
	base = "polestar",
	tokens = TOKENS,
	font = "fira",
	arrow = "flat",
	mapIcons = "polestar",
	paint = PAINT,
}
if V2 then
	spec.shadow = { size = 32, drop = 6, alpha = 0.75, color = "shadow" }
	spec.resolve = function(ctx)
		classColor = ctx and ctx.classColor or nil
		local out = {}
		if classColor then
			out.pinRing = classColor
		end
		return out
	end
	spec.repaintOn = { "class" }
	spec.hooks = HOOKS
	spec.arrow = { fill = "accent" }
end
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin sheen", Theme.RegisterSkin("sheen", spec))
