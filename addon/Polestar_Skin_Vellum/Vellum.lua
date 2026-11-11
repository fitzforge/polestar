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
-- registration answers true with no correction.
---------------------------------------------------------------------------

local INK = "#3a2a1a"
local TOKENS = {
	bg = "#e7dbbf", panel = "#efe5cf", panelAlt = "#dccda8", sidebar = "#d8c8a2", footer = "#dfd0ad", sky = "#d3c096",
	text = "#2a1d12", textDim = "#4a3626", textMuted = "#5e4937",
	-- No stars on paper. shade: wells (a khaki sheet); scrim: the light sheet
	-- under text on the world and in the fields below.
	ink = INK, star = "#ffffff00", shade = "#6b5035", scrim = "#f3eadb", onAccent = "#f7efdc", shadow = "#3a261466",
	-- Sealing wax: the accent for what you can act on and where you are.
	accent = "#962c20",
	-- Rules on paper must be drawn, not washed: the hairlines carry real ink.
	border = "#5a3d22bf", divider = "#5a3d2273", separator = "#5a3d2273", rowLine = "#5a3d2259",
	hover = INK .. "14", selected = INK .. "24", progress = INK .. "1f", track = INK .. "2e", toggle = INK .. "38",
	box = INK .. "66", thumb = INK .. "4d", swatch = INK .. "4d", chip = INK .. "14", watermark = INK .. "0d", mover = INK .. "14",
	-- The subjects as inks: the same hues Polestar gives them, deep enough to
	-- read on the darkest paper.
	success = "#1f5a2e", warning = "#6d4300", danger = "#962222", quest = "#654200", npc = "#1c477c", item = "#553484",
	place = "#7e3c12", object = "#524026", level = "#1e1a16", skill = "#2f5a12", spell = "#105a64", faction = "#7e2c58",
	area = "#6c3f1a", achievement = "#804208", dungeon = "#45338c", rare = "#8f3414",
	icon = "#4a3626", iconHover = "#2a1d12", buttonText = "#2a1d12", tabRest = "#5e4937", navRest = "#4a3626",
}

-- The gilt line inside the window's rule.
local GILT = { 0.66, 0.47, 0.16 }

---------------------------------------------------------------------------
-- Paint helpers. Everything a painter makes lives in kit.store(frame).
---------------------------------------------------------------------------

-- The paper grain over a frame's ground: Polestar's flat fill goes clear and
-- the grain carries the colour, so the mottling is the ground itself.
local function paper(frame, kit, layer, sub, r, g, b, a)
	local own = kit.store(frame)
	if not own.paper then
		own.paper = frame:CreateTexture(nil, layer or "BACKGROUND", nil, sub or -6)
		own.paper:SetTexture(MEDIA .. "paper")
		own.paper:SetAllPoints(frame)
	end
	kit.fill(frame):SetVertexColor(r, g, b, 0)
	own.paper:SetVertexColor(r, g, b, a)
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
	-- rule. A transparent window shows nothing of it.
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b = ground(frame, "bg")
		paper(frame, kit, "BACKGROUND", -6, r, g, b, frame.psBgAlpha or Theme.GroundAlpha())
		local shown = Theme.WindowBorder()
		if shown and not frame.psNoBorder then
			rule(frame, kit, 3, GILT[1], GILT[2], GILT[3], 0.75)
		else
			hideRule(frame, kit)
		end
	end,
	-- Menus and popups: lighter paper under a brown rule.
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b, a = Theme.Color("panel")
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
}

---------------------------------------------------------------------------
-- The layout that reads as paper, offered to the player on the Theme page
-- where this Polestar supports presets (capability "preset"); an older one
-- loads the skin without it.
---------------------------------------------------------------------------

local PAPER = { 0.96, 0.92, 0.82 }
local PRESET = {
	["ui.style"] = "standard",    -- paper has no transparent form
	["ui.bgOpacity"] = 1,         -- a sheet, not a veil
	["ui.band"] = true, ["ui.border"] = true, ["ui.borderSize"] = 1, ["ui.shadow"] = true,
	["guideWindow.rules"] = true, -- the hairlines between the window's parts
	-- Should the player go transparent anyway: dark ink wants a light shade
	-- behind each line and a shadow, not a black outline.
	["ui.backing"] = "soft", ["guideWindow.outline"] = "shadow",
	-- The arrow's words over the world: paper-coloured on a dark plate (the
	-- skin's own ink would vanish over a night zone).
	["nav.arrowBacking"] = true, ["nav.arrowBackingAlpha"] = 0.55,
	["nav.arrowDistColor"] = PAPER, ["nav.arrowLabelColor"] = PAPER, ["nav.arrowEtaColor"] = PAPER,
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
	-- The warm game designs for the arrow and the map pins.
	arrow = "hearth",
	mapIcons = "hearth",
	paint = PAINT,
	preset = PRESET,
}))
