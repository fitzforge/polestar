-- Hairline: a flat, pixel-exact skin for Polestar through its Skin API
-- (docs/skins in the Polestar repository). For players whose whole
-- interface is the flat dark kind: near-black grounds at 85 %, a one-pixel
-- black outline on every window, button and field, a lighter well inside,
-- a condensed white face (Barlow Semi Condensed, OFL, shipped in Fonts/),
-- one accent that follows the player's class by default, no band and no
-- shadow. The current step keeps Polestar's accent bar; the arrow is a
-- narrow dart of the skin's own with a one-unit dark outline.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * tokens doing most of the frame: `border` black at full is the
--     outline, `shade` the wells, `divider` the faint inner rules; one small
--     painter adds the lighter inset line the flat suites draw inside it;
--   * a font of the skin's own: three weights given as files under the
--     addon's folder;
--   * a layout preset that asks for the class colour as the accent
--     (ui.classAccent), the player's own accent still winning;
--   * `media.dart` / `media.dartEdge`: the arrow's dart as the skin's own
--     art (Media/, drawn by tools/media/skin-addons.js), and `shadow =
--     false`: no drop shadow under any window.
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
	-- Grounds: near black, the window at 85 % (the preset sets the opacity
	-- to match), controls one step lighter, the band's sky the ground itself.
	bg = "#0a0a0ad9", panel = "#0e0e0ef2", panelAlt = "#1a1a1a", sidebar = "#060606", footer = "#080808", sky = "#0a0a0a",
	text = "#f2f2f2", textDim = "#bdbdbd", textMuted = "#8c8c8c",
	ink = "#ffffff", star = "#ffffff00", shade = "#000000", scrim = "#000000", onAccent = "#0a0a0a", shadow = "#00000000",
	-- The outline: black at full, on every frame; inner hairlines faint white.
	border = "#000000", divider = "#ffffff12", separator = "#ffffff12", rowLine = "#ffffff0d",
	hover = "#ffffff14", selected = "#ffffff1a",
	-- Where the player has no class accent and none of their own.
	accent = "#58a6ff",
}

-- The lighter inset: one white hairline just inside the black outline, on
-- windows, menus, buttons, dropdowns and fields (the flat suites' second
-- line, which gives a black-edged panel its depth without a shadow).
local EDGES = {
	{ "TOPLEFT", "TOPRIGHT", 1, -1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", 1, 1 },
	{ "TOPLEFT", "BOTTOMLEFT", 1, -1 }, { "TOPRIGHT", "BOTTOMRIGHT", -1, -1 },
}
local function inset(frame, kit, alpha)
	local own = kit.store(frame)
	if not own.inset then
		own.inset = {}
		for i, e in ipairs(EDGES) do
			local t = frame:CreateTexture(nil, "BORDER", nil, 2)
			t:SetTexture(Theme.Media("white"))
			t:SetPoint(e[1], frame, e[1], e[3], e[4])
			t:SetPoint(e[2], frame, e[2], i <= 2 and -e[3] or e[3], i <= 2 and e[4] or -e[4])
			if i <= 2 then t:SetHeight(1) else t:SetWidth(1) end
			own.inset[i] = t
		end
	end
	for i = 1, 4 do
		own.inset[i]:SetVertexColor(1, 1, 1, alpha)
		own.inset[i]:Show()
	end
end

local function lined(alpha)
	return function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		inset(frame, kit, alpha)
	end
end

local PAINT = { window = lined(0.07), panel = lined(0.07), button = lined(0.05), dropdown = lined(0.05), editbox = lined(0.04) }

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.85, ["ui.band"] = false, ["ui.shadow"] = false,
	["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.borderAccent"] = false,
	["ui.classAccent"] = true,     -- the one colour is your class's
	["guideWindow.rules"] = true, ["guideWindow.progressHeight"] = 2,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3, ["nav.lineOutline"] = 1,
}

check("skin hairline", Theme.RegisterSkin("hairline", {
	api = 2,
	name = "Hairline",
	addon = ADDON,
	author = "Polestar",
	desc = "Flat and pixel-exact: near-black panels, a one-pixel black outline, condensed type, your class colour as the accent.",
	base = "polestar",
	tokens = TOKENS,
	font = { regular = FONTS .. "BarlowSemiCondensed-Regular.ttf", medium = FONTS .. "BarlowSemiCondensed-Medium.ttf",
		semibold = FONTS .. "BarlowSemiCondensed-SemiBold.ttf" },
	-- Condensed faces want a touch more size to keep their x-height.
	fontSizes = { body = 14, goal = 15, label = 13, note = 13, small = 12, caption = 12, number = 13 },
	textShadow = { 1, -1, 1 },
	arrow = "flat",
	media = { dart = HOME .. "Media\\dart", dartEdge = HOME .. "Media\\dart-edge" },
	shadow = false,
	mapIcons = "polestar",
	paint = PAINT,
	preset = PRESET,
}))
