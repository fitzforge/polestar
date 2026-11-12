-- Hairline: the lightest touch, through Polestar's Skin API (docs/skins in
-- the Polestar repository). Frames drawn as single hairlines instead of
-- panels: a near-black glass ground, a one-pixel light outline, buttons and
-- fields as outlines with nothing filled, tabs marked by a one-pixel line in
-- the accent, the rule under the step bar in the accent too. Light type
-- (Barlow Semi Condensed Light, OFL, shipped in Fonts/) a size up, with room
-- round it; one accent, the player's class colour with the skin's layout.
-- The arrow is an open chevron, the map pins square chips.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * painters that take a look apart instead of adding to it: buttons and
--     fields keep Polestar's hover and lose their fill;
--   * a font of the skin's own: three weights given as files under the
--     addon's folder (here a light face as the regular one);
--   * a layout preset for room (padding, row and line spacing, a one-unit
--     progress line) and the class colour as the accent (ui.classAccent),
--     the player's own accent still winning;
--   * `media.dart` / `media.dartEdge`: the arrow's dart as the skin's own
--     art (Media/, drawn by tools/media/skin-addons.js), and `shadow =
--     false`: no drop shadow under any window;
--   * square map pins: `media.medallion` under the map marks and
--     `media.pinFill` / `media.pinRim` for the step pins, with `pinRing`
--     the light line inside their black outline;
--   * the `guideTitle` hook restyling a part (the rule under the step bar).
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local HOME = "Interface\\AddOns\\" .. ADDON .. "\\"
local FONTS = HOME .. "Fonts\\"

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local TOKENS = {
	-- Grounds: near-black glass (the preset takes the window to 78 %),
	-- controls the ground itself (they are outlines), the band's sky the
	-- ground.
	bg = "#08090bd9", panel = "#0b0c0ff0", panelAlt = "#0e1013", sidebar = "#060709", footer = "#07080a", sky = "#08090b",
	text = "#f4f5f7", textDim = "#c2c5cc", textMuted = "#91959e",
	ink = "#ffffff", star = "#ffffff00", shade = "#000000", scrim = "#000000", onAccent = "#08090b", shadow = "#00000000",
	-- The hairlines: the outline a light line, the rules fainter still.
	border = "#ffffff2e", windowBorder = "#ffffff38", divider = "#ffffff14", separator = "#ffffff14", rowLine = "#ffffff0d",
	hover = "#ffffff12", selected = "#ffffff17",
	-- Where the player has no class accent and none of their own.
	accent = "#58a6ff",
	-- The step pins' line inside their black outline (Media/chip-rim).
	pinRing = "#ffffff73",
}

-- A control as an outline: Polestar's painter for its border and hover,
-- then its fill made clear (a field keeps a trace of shade to type on).
local function outline(fillAlpha)
	return function(frame, base, kit)
		base(frame)
		local f = kit.fill(frame)
		local r, g, b = Theme.Color("shade")
		f:SetVertexColor(r, g, b, fillAlpha)
	end
end

-- The arrow's open chevron and the map marks' square ground; the step pins'
-- square body and rim where Polestar takes them (Skin API 2's "media.pins").
local MEDIA = { dart = HOME .. "Media\\dart", dartEdge = HOME .. "Media\\dart-edge", medallion = HOME .. "Media\\medallion" }
if Theme.HasCapability and Theme.HasCapability("media.pins") then
	MEDIA.pinFill, MEDIA.pinRim = HOME .. "Media\\chip", HOME .. "Media\\chip-rim"
end

local PAINT = {
	button = outline(0), dropdown = outline(0), tile = outline(0), editbox = outline(0.25),
	-- Tabs: Polestar's (its line under the selected tab), the line thinned.
	tab = function(frame, base, kit)
		base(frame)
		local bar = frame.psSkin and frame.psSkin.bar
		if bar then bar:SetHeight(1) end
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

-- Cards and toasts: the hairline frame marked at its four corners by short
-- ticks in the accent (eight units, one wide), the precise draughtsman's
-- touch; the card's own lines stay as they are.
local TICKS = {
	{ "TOPLEFT", 1, 1 }, { "TOPRIGHT", -1, 1 }, { "BOTTOMLEFT", 1, -1 }, { "BOTTOMRIGHT", -1, -1 },
}
local function ticks(frame)
	local o, own = overlay(frame)
	local r, g, b = Theme.Accent()
	for i, c in ipairs(TICKS) do
		for j = 1, 2 do
			local key = i * 2 + j
			local t = own[key]
			if not t then
				t = o:CreateTexture(nil, "OVERLAY")
				t:SetTexture(Theme.Media("white"))
				own[key] = t
			end
			t:ClearAllPoints()
			t:SetPoint(c[1], o, c[1], 0, 0)
			if j == 1 then t:SetSize(8, 1) else t:SetSize(1, 8) end
			t:SetVertexColor(r, g, b, 0.9)
			t:Show()
		end
	end
end

local HOOKS = {
	-- The rule under the step bar in the accent.
	guideTitle = function(nav, parts)
		local rule = parts.rule
		if rule and rule.SetVertexColor then
			local r, g, b = Theme.Accent()
			rule:SetVertexColor(r, g, b, 0.7)
		end
	end,
}

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.78, ["ui.band"] = false, ["ui.shadow"] = false, ["ui.rim"] = false,
	["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.borderAccent"] = false,
	["ui.classAccent"] = true, -- the one colour is your class's
	-- Room: wider margins, rows and lines apart, the thinnest progress line.
	["guideWindow.padding"] = 8, ["guideWindow.rowSpacing"] = 5, ["guideWindow.lineSpacing"] = 2,
	["guideWindow.rules"] = true, ["guideWindow.progressHeight"] = 1, ["guideWindow.targetBarWidth"] = 1,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 2, ["nav.lineOutline"] = 1,
}

if hasHooks("card", "toast") then
	HOOKS.card = function(frame) ticks(frame) end
	HOOKS.toast = function(frame) ticks(frame) end
end

check("skin hairline", Theme.RegisterSkin("hairline", {
	api = 2,
	name = "Hairline",
	addon = ADDON,
	author = "Polestar",
	desc = "The lightest touch: single hairlines for frames, outlined buttons, light condensed type with room round it, your class colour as the accent.",
	base = "polestar",
	tokens = TOKENS,
	-- A light face as the body, the regular and medium for the stronger roles.
	font = { regular = FONTS .. "BarlowSemiCondensed-Light.ttf", medium = FONTS .. "BarlowSemiCondensed-Regular.ttf",
		semibold = FONTS .. "BarlowSemiCondensed-Medium.ttf" },
	-- Condensed light faces want a size more to keep their x-height.
	fontSizes = { body = 15, goal = 16, label = 14, note = 14, small = 13, caption = 12, number = 14 },
	textShadow = false,
	-- An open chevron of its own (media.dart, media.dartEdge) on the skins' dart style.
	arrow = "halo",
	media = MEDIA,
	shadow = false,
	mapIcons = "polestar",
	paint = PAINT,
	hooks = HOOKS,
	preset = PRESET,
}))
