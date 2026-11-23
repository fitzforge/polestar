-- Sheen: glass and gloss, through Polestar's Skin API (docs/skins in the
-- Polestar repository). Every window, panel, button and tab is a bevelled
-- pane of translucent dark glass: a light edge on top, a dark one at the
-- foot, a gloss over its upper half, a broad band of light across each
-- window's top, a wide soft shadow under it. The character's class colour
-- runs into the accent along a glossy progress line; Fira Sans, the flat
-- dart with a cyan glow, the map pins' rims in the class colour.
--
-- What this skin shows:
--   * `shadow`: the window shadow's size and drop as the skin's own;
--   * `resolve(ctx)` for the class colour, and a gradient across the
--     progress line in the `guideProgress` hook;
--   * `kit.glow` for the sheen, a texture of the skin's own for the glare
--     across each window (Media/glare); bevels and gloss from Polestar's white
--     texture on every kind of frame (painters for buttons, dropdowns,
--     tiles and tabs too), and `Theme.SkinKit.store` from a hook.
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

---------------------------------------------------------------------------
-- Glass: every window, panel, button and tab is a bevelled pane, a light
-- line along its top edge and a dark one along its foot (and fainter down
-- its sides), with a gloss over its upper half: light running from the top
-- edge to nothing at the middle. Windows also catch a broad band of light
-- across the top (the sheen). All from Polestar's white texture and its
-- glow, kept in the frame's store.
---------------------------------------------------------------------------

local WHITE = Theme.Media("white")
local GLARE = "Interface\\AddOns\\" .. ADDON .. "\\Media\\glare"

local function piece(frame, own, key, layer, sub)
	local t = own[key]
	if not t then
		t = frame:CreateTexture(nil, layer, nil, sub)
		t:SetTexture(WHITE)
		own[key] = t
	end
	t:ClearAllPoints()
	t:Show()
	return t
end

-- The bevel: top light, foot dark, sides at half; `k` scales it.
local function bevel(frame, kit, k)
	local own = kit.store(frame)
	local top = piece(frame, own, "bevelTop", "BORDER", 3)
	top:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
	top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
	top:SetHeight(1)
	top:SetVertexColor(1, 1, 1, math.min(1, 0.3 * k))
	local foot = piece(frame, own, "bevelFoot", "BORDER", 3)
	foot:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(1)
	foot:SetVertexColor(0, 0, 0, 0.7 * k)
	local left = piece(frame, own, "bevelLeft", "BORDER", 3)
	left:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -2)
	left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 2)
	left:SetWidth(1)
	left:SetVertexColor(1, 1, 1, 0.1 * k)
	local right = piece(frame, own, "bevelRight", "BORDER", 3)
	right:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -2)
	right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 2)
	right:SetWidth(1)
	right:SetVertexColor(0, 0, 0, 0.45 * k)
end

-- The gloss over the upper half (to `depth` of the height when given in
-- units): white at `a` on the top edge to nothing.
local function gloss(frame, kit, a, depth)
	if not CreateColor then return end
	local own = kit.store(frame)
	local t = piece(frame, own, "gloss", "BORDER", 2)
	t:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)
	t:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
	t:SetHeight(depth or math.max(2, ((frame:GetHeight() or 20) - 2) / 2))
	t:SetGradient("VERTICAL", CreateColor(1, 1, 1, 0), CreateColor(1, 1, 1, a))
end

-- The sheen: the lower half of a radial glow laid along the top edge, its
-- brightest line on the edge, white and faint; over the band's sky and
-- stars (Theme.Band's BACKGROUND -5 and -4). The glow's middle half
-- across, stretched to the width: a broad band of light.
local function sheen(frame, kit, alpha)
	local t = kit.glow(frame, { key = "sheen", color = { 1, 1, 1, alpha }, blend = "ADD", layer = "BACKGROUND", sub = -3 })
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	t:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	t:SetHeight(48)
	t:SetTexCoord(0.25, 0.75, 0.5, 1)
end

-- The glare: light across the glass (Media/glare), over the whole pane.
local function glare(frame, kit, alpha)
	local own = kit.store(frame)
	local t = own.glare
	if not t then
		t = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
		t:SetTexture(GLARE)
		t:SetAllPoints(frame)
		t:SetBlendMode("ADD")
		own.glare = t
	end
	t:SetVertexColor(1, 1, 1, alpha)
	t:Show()
end

local function pane(alpha)
	return function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		sheen(frame, kit, alpha)
		glare(frame, kit, alpha * 0.45)
		gloss(frame, kit, 0.12, 30)
		bevel(frame, kit, 1.3)
	end
end

-- A control: Polestar's, glossed and bevelled.
local function control(frame, base, kit)
	base(frame)
	gloss(frame, kit, 0.2)
	bevel(frame, kit, 1)
end

-- A tab: glossed and bevelled only while selected.
local function tab(frame, base, kit)
	base(frame)
	local own = kit.store(frame)
	if frame.psSelected then
		gloss(frame, kit, 0.14)
		bevel(frame, kit, 0.8)
	else
		for _, k in ipairs({ "gloss", "bevelTop", "bevelFoot", "bevelLeft", "bevelRight" }) do
			if own[k] then own[k]:Hide() end
		end
	end
end

local PAINT = { window = pane(0.2), panel = pane(0.14), button = control, dropdown = control, tile = control, tab = tab }

-- A texture from the class colour on the left to the accent on the right.
local function duotone(t)
	if not (t and t.SetGradient and CreateColor) then return end
	local from, to = ends()
	t:SetVertexColor(1, 1, 1, 1)
	t:SetGradient("HORIZONTAL", CreateColor(from[1], from[2], from[3], 1), CreateColor(to[1], to[2], to[3], 1))
end

-- The progress line's fill (foot.Line.Fill), each time Polestar paints it:
-- the class colour into the accent, and a gloss over its upper half.
local HOOKS = {
	guideProgress = function(foot)
		local fill = foot.Line and foot.Line.Fill
		duotone(fill)
		local kit = Theme.SkinKit
		if not (fill and kit and kit.store and CreateColor) then return end
		local own = kit.store(foot)
		local t = own.gloss
		if not t then
			t = foot:CreateTexture(nil, "OVERLAY", nil, 7)
			t:SetTexture(WHITE)
			own.gloss = t
		end
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", fill, "TOPLEFT", 0, 0)
		t:SetPoint("TOPRIGHT", fill, "TOPRIGHT", 0, 0)
		t:SetHeight(math.max(1, (fill:GetHeight() or 2) / 2))
		t:SetGradient("VERTICAL", CreateColor(1, 1, 1, 0.08), CreateColor(1, 1, 1, 0.5))
		t:SetShown(fill:IsShown())
	end,
}

-- A frame of the skin's own over a card or a toast, above its parts (their
-- grounds would hide what the skin draws on the frame itself), never taking
-- the mouse; kept in the frame's store so another skin hides it.
local function overlay(frame)
	local kit = Theme.SkinKit
	local own = kit.store(frame)
	local o = own.overlay
	if not o then
		o = CreateFrame("Frame", nil, frame)
		o:SetAllPoints(frame)
		if o.EnableMouse then o:EnableMouse(false) end
		own.overlay = o
	end
	o:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
	o:Show()
	return o, kit.store(o)
end

local function hasHooks(...)
	if not Theme.HasCapability then return false end
	for i = 1, select("#", ...) do
		if not Theme.HasCapability("surfaces." .. select(i, ...)) then return false end
	end
	return true
end

-- Cards and toasts: their parts cover the pane, so its glass goes over
-- them: the bevel, a gloss over the top and the glare (light only).
local function glazed(frame)
	local o = overlay(frame)
	local kit = Theme.SkinKit
	bevel(o, kit, 1.2)
	gloss(o, kit, 0.1, 18)
	glare(o, kit, 0.07)
end
if hasHooks("card", "toast") then
	HOOKS.card = function(frame) glazed(frame) end
	HOOKS.toast = function(frame) glazed(frame) end
end

-- The guide window's own tabs (the guideTab hook, where Polestar has it):
-- the selected one glossed and bevelled like the panes.
if hasHooks("guideTab") then
	HOOKS.guideTab = function(button, parts, active)
		local kit = Theme.SkinKit
		if not (kit and kit.store) then return end
		if active then
			gloss(button, kit, 0.16, 12)
			bevel(button, kit, 0.8)
		else
			local own = kit.store(button)
			for _, k in ipairs({ "gloss", "bevelTop", "bevelFoot", "bevelLeft", "bevelRight" }) do
				if own[k] then own[k]:Hide() end
			end
		end
	end
end

check("skin sheen", Theme.RegisterSkin("sheen", {
	api = 2,
	name = "Sheen",
	addon = ADDON,
	author = "Polestar",
	desc = "Glass and gloss: bevelled translucent panes, a gloss on every button and tab, a wide shadow, your class colour running into the accent.",
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
