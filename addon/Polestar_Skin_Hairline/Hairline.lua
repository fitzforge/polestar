-- Hairline: a flat, pixel-exact skin for Polestar through its Skin API
-- (docs/SKINS-API.md in the Polestar repository). For players whose whole
-- interface is the flat dark kind: near-black grounds at 85 %, a one-pixel
-- black outline on every window, button and field, a lighter well inside,
-- a condensed white face (Barlow Semi Condensed, OFL, shipped in Fonts/),
-- one accent that follows the player's class by default, no band and no
-- shadow. The current step keeps Polestar's accent bar; the arrow is the
-- flat dart.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a skin with NO painters: tokens alone turn the house frames into
--     black-outlined flat panels (the `border`, `divider` and `windowBorder`
--     tokens are the outline; `shade` the wells);
--   * a font of the skin's own: three weights given as files under the
--     addon's folder;
--   * a layout preset that asks for the class colour as the accent
--     (ui.classAccent), the player's own accent still winning.
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

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.85, ["ui.band"] = false, ["ui.shadow"] = false,
	["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.borderAccent"] = false,
	["ui.classAccent"] = true,     -- the one colour is your class's
	["guideWindow.rules"] = true, ["guideWindow.progressHeight"] = 2,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3, ["nav.lineOutline"] = 1,
}

local spec = {
	api = 1,
	name = "Hairline",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Flat and pixel-exact: near-black panels, a one-pixel black outline, condensed type, your class colour as the accent.",
	base = "polestar",
	tokens = TOKENS,
	font = { regular = FONTS .. "BarlowSemiCondensed-Regular.ttf", medium = FONTS .. "BarlowSemiCondensed-Medium.ttf",
		semibold = FONTS .. "BarlowSemiCondensed-SemiBold.ttf" },
	-- Condensed faces want a touch more size to keep their x-height.
	fontSizes = { body = 14, goal = 15, label = 13, note = 13, small = 12, caption = 12, number = 13 },
	textShadow = { 1, -1, 1 },
	arrow = "flat",
	mapIcons = "polestar",
}
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin hairline", Theme.RegisterSkin("hairline", spec))
