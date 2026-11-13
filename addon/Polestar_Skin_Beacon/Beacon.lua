-- Beacon: a high-contrast skin for Polestar through its Skin API
-- (docs/skins in the Polestar repository). For players who read the
-- guide at a distance, on a bright screen, or with low vision: solid black
-- grounds, a pure white ladder in Open Sans one size up, a yellow accent
-- (14:1 on black), hairlines and edges at half strength instead of a tenth,
-- subject colours brightened so each reads at 5:1 or better on every
-- ground and still tells apart from its neighbours, no shadows, no stars.
-- Its layout preset thickens the window border, grows the arrow, pins,
-- route line and tick boxes, and turns the drop shadow off.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a scheme AND a skin from one addon: Beacon's grounds and ladder are
--     a scheme too, so a player can wear them with Polestar's own skin;
--   * a skin that adjusts WASHES (border, divider, hover, selected...) and
--     fontSizes for the whole ladder, with painters only where the house's
--     own are too fine (a 2-unit focus ring on fields);
--   * a layout preset that reaches the arrow, the map pins and the route
--     line as well as the windows.
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

---------------------------------------------------------------------------
-- The scheme: black grounds (the controls a step lighter so a button's
-- shape shows without its edge), a white ladder whose dimmest step still
-- reads at 11:1, white ink at strong alphas. The band's sky is a near
-- black and the stars are off: nothing behind a title but ground.
---------------------------------------------------------------------------

local GROUNDS = {
	bg = "#000000", panel = "#0a0a0a", panelAlt = "#1c1c1c", sidebar = "#000000", footer = "#000000", sky = "#141414",
	text = "#ffffff", textDim = "#e8e8e8", textMuted = "#c9c9c9",
	ink = "#ffffff", star = "#ffffff00", shade = "#000000", scrim = "#000000", onAccent = "#000000", shadow = "#00000000",
}
local ACCENT = "#ffd400"
local WASHES = { border = 0.5, divider = 0.4, hover = 0.2, selected = 0.16, progress = 0.3, track = 0.4, toggle = 0.5, box = 0.8,
	thumb = 0.7, swatch = 0.6, chip = 0.2, watermark = 0.06, mover = 0.2 }

check("scheme beacon", Theme.RegisterScheme("beacon", {
	api = 2, name = "Beacon", addon = ADDON, author = "Polestar",
	desc = "High contrast: black grounds, white text, strong edges.",
	tokens = GROUNDS, accent = ACCENT, washes = WASHES,
}))

---------------------------------------------------------------------------
-- The skin: the scheme, the subjects brightened, the washes as colours (a
-- skin's washes are tokens, each with its alpha), the ladder a size up.
---------------------------------------------------------------------------

local function wash(alpha) return ("#ffffff%02x"):format(math.floor(alpha * 255 + 0.5)) end
local TOKENS = {
	accent = ACCENT,
	success = "#4ce38a", warning = "#ffb020", danger = "#ff7d7d", quest = "#ffe14d", npc = "#6ec6ff", item = "#d9a6ff",
	place = "#ffb380", object = "#e8d9b8", level = "#ffffff", skill = "#a6ff6e", spell = "#7ff0ff", faction = "#ff9ad6",
	area = "#ffcfa0", achievement = "#ffb347", dungeon = "#c4a8ff", rare = "#ff9666",
}
for name, alpha in pairs(WASHES) do TOKENS[name] = wash(alpha) end

local PAINT = {
	-- Fields: the house well, edged in white at half strength, and a
	-- 2-unit ring in the accent while the field has the cursor.
	editbox = function(frame, base, kit)
		base(frame)
		if frame.psFocused then
			local r, g, b = Theme.Accent()
			kit.border(frame, r, g, b, 1, nil, 2)
		else
			kit.border(frame, 1, 1, 1, 0.5)
		end
	end,
	-- Wells: a visible step down from the ground.
	inset = function(frame, base, kit)
		base(frame)
		kit.fill(frame):SetVertexColor(1, 1, 1, 0.08)
	end,
}

---------------------------------------------------------------------------
-- The layout, offered on the Theme page where this Polestar has presets
-- (capability "preset"): bigger and bolder wherever a size is a setting.
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 1, ["ui.band"] = false, ["ui.shadow"] = false,
	["ui.border"] = true, ["ui.borderSize"] = 2,
	["ui.textSize"] = 1.1, ["ui.textShadow"] = "none",
	["guideWindow.glyphSize"] = 1.2, ["guideWindow.checkSize"] = 1.25, ["guideWindow.rowSpacing"] = 2,
	["guideWindow.targetBarWidth"] = 3, ["guideWindow.progressHeight"] = 5, ["guideWindow.outline"] = "thick",
	["nav.arrowScale"] = 1.25, ["nav.arrowBacking"] = true, ["nav.arrowBackingAlpha"] = 0.7, ["nav.arrowOutline"] = "THICKOUTLINE",
	["nav.stepPinSize"] = 1.3, ["nav.stepNumberSize"] = 1.2, ["nav.worldIconSize"] = 1.3, ["nav.minimapIconSize"] = 1.2,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 6, ["nav.lineOutline"] = 2,
}

check("skin beacon", Theme.RegisterSkin("beacon", {
	api = 2,
	name = "Beacon",
	addon = ADDON,
	author = "Polestar",
	desc = "High contrast: black grounds, white Open Sans a size up, a yellow accent, strong edges, bigger pins and arrow.",
	base = "polestar",
	scheme = "beacon",
	tokens = TOKENS,
	font = "opensans",
	fontSizes = { hero = 28, display = 20, title = 16, heading = 14, body = 14, label = 13, note = 13, small = 12, number = 13,
		caption = 12, goal = 15, name = 16, mono = 13 },
	-- Shadows soften edges: none.
	textShadow = false,
	arrow = "flat",
	mapIcons = "polestar",
	paint = PAINT,
	preset = PRESET,
}))
