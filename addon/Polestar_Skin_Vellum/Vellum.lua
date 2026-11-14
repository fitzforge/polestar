-- Vellum: a parchment skin for Polestar through its Skin API
-- (docs/skins in the Polestar repository). The guide window as a page
-- of the quest log: mottled paper, dark umber ink, a sealing-wax red for the
-- one accent, every quest and name in a dark ink of its own colour, the game's
-- own font. Windows are framed by a brown rule with a gilt line just inside
-- it; menus, buttons and fields are paper too, a shade lighter or darker.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a LIGHT skin: a base-"polestar" skin can give every token, grounds,
--     text ladder and the sixteen subject colours alike, and Polestar's
--     legibility rule (7:1 primary, 4.5:1 the rest) still holds it;
--   * a texture of its own (Media/paper.tga, tinted at paint time so the
--     player's own ground colour and opacity still apply);
--   * painters for most kinds of frame, each keeping its pieces in
--     kit.store(frame) so a switch to another skin leaves nothing behind;
--   * a layout preset (where this Polestar offers one): the settings that
--     make the paper read as paper, offered to the player, never applied
--     behind their back.
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

---------------------------------------------------------------------------
-- The palette. Paper grounds (the controls a shade darker, menus a shade
-- lighter, the band at the top a toned strip), an ink ladder, inks for the
-- subjects. Every pair below reads at Polestar's floors as given, so the
-- registration answers true with no correction; the muted ink, the wax and
-- the warning ink are deep enough for 4.5:1 on the sidebar's grained paper,
-- the darkest ground they sit on.
---------------------------------------------------------------------------

local INK = "#3a2a1a"
local TOKENS = {
	bg = "#e7dbbf", panel = "#efe5cf", panelAlt = "#dccda8", sidebar = "#d8c8a2", footer = "#dfd0ad", sky = "#d3c096",
	text = "#2a1d12", textDim = "#4a3626", textMuted = "#513f30",
	-- No stars on paper. shade: wells (a khaki sheet); scrim: the light sheet
	-- under text on the world and in the fields below.
	ink = INK, star = "#ffffff00", shade = "#6b5035", scrim = "#f3eadb", onAccent = "#f7efdc", shadow = "#3a261466",
	-- Sealing wax: the accent for what you can act on and where you are.
	accent = "#7b241a",
	-- Rules on paper must be drawn, not washed: the hairlines carry real ink.
	border = "#5a3d22bf", divider = "#5a3d2273", separator = "#5a3d2273", rowLine = "#5a3d2259",
	hover = INK .. "14", selected = INK .. "24", progress = INK .. "1f", track = INK .. "2e", toggle = INK .. "38",
	box = INK .. "66", thumb = INK .. "4d", swatch = INK .. "4d", chip = INK .. "14", watermark = INK .. "0d", mover = INK .. "14",
	-- The subjects as inks: the same hues Polestar gives them, deep enough to
	-- read on the darkest paper.
	success = "#1f5a2e", warning = "#5f3b00", danger = "#962222", quest = "#654200", npc = "#1c477c", item = "#553484",
	place = "#7e3c12", object = "#524026", level = "#1e1a16", skill = "#2f5a12", spell = "#105a64", faction = "#7e2c58",
	area = "#6c3f1a", achievement = "#804208", dungeon = "#45338c", rare = "#8f3414",
	icon = "#4a3626", iconHover = "#2a1d12", buttonText = "#2a1d12", tabRest = "#513f30", navRest = "#4a3626",
}

-- The gilt line inside the window's rule.
local GILT = { 0.66, 0.47, 0.16 }

---------------------------------------------------------------------------
-- Paint helpers. Everything a painter makes lives in kit.store(frame).
---------------------------------------------------------------------------

-- The paper grain over a frame's ground: Polestar's flat fill goes clear and
-- the grain carries the colour, so the mottling is the ground itself. The
-- grain's values average GRAIN (Media/paper.tga: 214-245 of 255), so the
-- colour is lifted by it: the paper averages the palette's ground, the
-- colour every legibility check reads against, not a tenth darker.
local GRAIN = 0.901
local function paper(frame, kit, layer, sub, r, g, b, a)
	local own = kit.store(frame)
	if not own.paper then
		own.paper = frame:CreateTexture(nil, layer or "BACKGROUND", nil, sub or -6)
		own.paper:SetTexture(MEDIA .. "paper")
		own.paper:SetAllPoints(frame)
	end
	kit.fill(frame):SetVertexColor(r, g, b, 0)
	own.paper:SetVertexColor(math.min(1, r / GRAIN), math.min(1, g / GRAIN), math.min(1, b / GRAIN), a)
	own.paper:Show()
end

-- A rule drawn `inset` units inside the frame's edge, 1 unit thick.
local EDGES = {
	{ "TOPLEFT", "TOPRIGHT", 1, -1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", 1, 1 },
	{ "TOPLEFT", "BOTTOMLEFT", 1, -1 }, { "TOPRIGHT", "BOTTOMRIGHT", -1, -1 },
}
local function rule(frame, kit, inset, r, g, b, a)
	local own = kit.store(frame)
	if not own.rule then
		own.rule = {}
		for i, e in ipairs(EDGES) do
			local t = frame:CreateTexture(nil, "BORDER", nil, 2)
			t:SetTexture(Theme.Media("white"))
			local dx, dy = e[3] * inset, e[4] * inset
			t:SetPoint(e[1], frame, e[1], dx, dy)
			t:SetPoint(e[2], frame, e[2], (i <= 2 and -dx or dx), (i <= 2 and dy or -dy))
			if i <= 2 then t:SetHeight(1) else t:SetWidth(1) end
			own.rule[i] = t
		end
	end
	for i = 1, 4 do
		own.rule[i]:SetVertexColor(r, g, b, a)
		own.rule[i]:Show()
	end
end

local function hideRule(frame, kit)
	local own = kit.store(frame)
	if own.rule then for i = 1, 4 do own.rule[i]:Hide() end end
end

-- A window's ground colour: its own (frame.psBgColor) or the palette's.
local function ground(frame, token)
	local c = frame.psBgColor
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3] end
	return Theme.Color(token)
end

local PAINT = {
	-- Every window, the guide window included: Polestar's own painter lays
	-- the ground, the window border (the player's setting) and the drop
	-- shadow; the paper goes over the ground and the gilt line inside the
	-- rule. A heads-up card (drawn as the guide window, psGuide, and docked
	-- on it; not a guide window itself, psGuideWindow, the live one or the
	-- settings preview's copy) keeps the brown rule alone, so the two frames
	-- meet in one edge. A transparent window shows nothing of it.
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b = ground(frame, "bg")
		paper(frame, kit, "BACKGROUND", -6, r, g, b, frame.psBgAlpha or Theme.GroundAlpha())
		local card = frame.psGuide and not frame.psGuideWindow
		local shown = Theme.WindowBorder()
		if shown and not frame.psNoBorder and not card then
			rule(frame, kit, 3, GILT[1], GILT[2], GILT[3], 0.75)
		else
			hideRule(frame, kit)
		end
	end,
	-- Menus and popups: lighter paper under a brown rule (a menu or popup
	-- over other frames, psMenu, on menuBg: never see-through).
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b, a = Theme.Color(frame.psMenu and "menuBg" or "panel")
		paper(frame, kit, "BACKGROUND", -6, r, g, b, a)
	end,
	sidebar = function(frame, base, kit)
		base(frame)
		local r, g, b, a = Theme.Color("sidebar")
		paper(frame, kit, "BACKGROUND", -6, r, g, b, a)
	end,
	-- Wells: the paper a shade darker, no edge.
	inset = function(frame, base, kit)
		base(frame)
		local r, g, b = Theme.Color("shade")
		kit.fill(frame):SetVertexColor(r, g, b, 0.08)
	end,
	-- Fields: a lighter sheet under Polestar's own rule (the accent while
	-- the field has the cursor).
	editbox = function(frame, base, kit)
		base(frame)
		kit.fill(frame):SetVertexColor(Theme.Color("scrim"))
	end,
	-- Check boxes as printed on the page: a box ruled in ink on the paper,
	-- not a grey square; its inside left clear, as the box's ground lies
	-- over the tick (the sealing-wax accent) and would pale it. The
	-- transparent window's boxes over the world keep Polestar's own.
	checkbox = function(frame, base, kit)
		base(frame)
		local box = frame.psSkin and frame.psSkin.box
		if not box or frame.psOnWorld then return end
		kit.fill(box):SetVertexColor(0, 0, 0, 0)
		local r, g, b = Theme.Color("ink")
		kit.border(box, r, g, b, 0.85)
	end,
}

---------------------------------------------------------------------------
-- The layout that reads as paper, offered to the player on the Theme page
-- where this Polestar supports presets (capability "preset"); an older one
-- loads the skin without it.
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "standard",    -- paper has no transparent form
	["ui.bgOpacity"] = 1,         -- a sheet, not a veil
	["ui.band"] = true, ["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.shadow"] = true,
	["guideWindow.rules"] = true, -- the hairlines between the window's parts
	-- Should the player go transparent anyway: dark ink wants a light shade
	-- behind each line and a shadow, not a black outline.
	["ui.backing"] = "soft", ["guideWindow.outline"] = "shadow",
	-- The arrow's words over the world (Polestar draws them in the paper's
	-- colour on a light skin) on a dark plate; the dart a brighter
	-- sealing-wax red than the ink's, to hold over the world.
	["nav.arrowBacking"] = true, ["nav.arrowBackingAlpha"] = 0.55,
	["nav.arrowColor"] = { 0.84, 0.27, 0.18 },
	["nav.lineStyle"] = "dots",   -- a dotted course on the map, as on a chart
}

check("skin vellum", Theme.RegisterSkin("vellum", {
	api = 2,
	name = "Vellum",
	addon = ADDON,
	author = "Polestar",
	desc = "A page of the quest log: dark ink on mottled parchment, a sealing-wax accent, the game's own font.",
	base = "polestar",
	tokens = TOKENS,
	font = "game",
	-- Dark ink needs no shadow.
	textShadow = false,
	-- The report glyph as a flag, as the game looks draw it.
	icons = { bug = "flag" },
	-- A dart in the sealing-wax red (Halo's tinted dart, not the game
	-- looks' gold), and the warm map pins.
	arrow = "halo",
	mapIcons = "hearth",
	paint = PAINT,
	preset = PRESET,
}))
