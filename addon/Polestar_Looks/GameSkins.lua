-- Polestar_Looks (load on demand), the game's own skins (docs/ARCHITECTURE.md, "Skins"):
-- Polestar drawn in the client's art, the three looks EllesmereUI offers on
-- the Forever client (only their visual spec is followed; nothing of that
-- addon is used), composed the way the client's own templates compose them
-- (SharedUIPanelTemplates, NineSliceLayouts and the Settings panel of the
-- Forever client's FrameXML):
--   "forever"   WoW Forever: Forever's own art, by atlas name (the client
--               draws its -c60 members). The big windows wear
--               ButtonFrameTemplateNoPortrait's bronze metal with Forever's
--               offsets; the guide window the micro menu box's bronze line.
--   "blizzard"  Blizzard Style: the same templates in the retail art that
--               still ships with the client (ns.GameArt, by file and
--               coordinates: SetAtlas draws Forever's there).
--   "classic"   Classic WoW UI: the vanilla files. The dialog box and its
--               header plate round the big windows (InterfaceOptionsFrame),
--               the chat frame round the guide window (its tabs and rim on
--               the tooltip tile), the game's tooltip for toasts, menus and
--               the options boxes, the panel buttons, check boxes, option
--               slider, dropdown, input box and scroll bar, the XP bar in
--               the cast bar's frame. Every backdrop is drawn piece by
--               piece (Theme.KitEdge), as the client cuts its edge files.
-- Every piece drawn here lives in frame.psSkin.kit, so Theme's clearSkin
-- hides it when another skin paints the frame. Polestar loads this part the
-- first time one of these looks (or Hearth, Hearth.lua) is painted
-- (Theme.LoadLooks): a player on the house look never pays for it. It
-- replaces the core's stand-ins for Theme.Kit and the Theme.Kit* calls.

local ns = Polestar
local Theme = ns.Theme
local P = Theme.Paint

local pairs, ipairs, type, unpack, max, min = pairs, ipairs, type, unpack, math.max, math.min

-- [name] = { file, w, h, left, right, top, bottom } (sizes at 1x)
local CLASSIC = {
	tile = { "Interface\\Tooltips\\UI-Tooltip-Background", 64, 64, 0, 1, 0, 1 },
	dialogTile = { "Interface\\DialogFrame\\UI-DialogBox-Background", 64, 64, 0, 1, 0, 1 },
	rim = { "Interface\\ChatFrame\\ChatFrameTab", 64, 32, 0, 1, 0, 1 },
	-- The chat frame's tab (the same sheet the rim is cut from): its shape
	-- fills columns 3..61 of 64, rows 10..32 of 32, open at the foot.
	chatTab = { "Interface\\ChatFrame\\ChatFrameTab", 58, 22, 3 / 64, 61 / 64, 10 / 32, 1 },
	-- The 2x header plate: its oval is the middle 220 x 36 of 256 x 64.
	header = { "Interface\\DialogFrame\\UI-DialogBox-Header", 256, 64, 0, 1, 0, 1 },
	tab = { "Interface\\OptionsFrame\\UI-OptionsFrame-InActiveTab", 111, 25, 9 / 128, 120 / 128, 7 / 32, 1 },
	tabActive = { "Interface\\OptionsFrame\\UI-OptionsFrame-ActiveTab", 114, 31, 7 / 128, 121 / 128, 0, 31 / 32 },
	check = { "Interface\\Buttons\\UI-CheckBox-Up", 32, 32, 0, 1, 0, 1 },
	checkOn = { "Interface\\Buttons\\UI-CheckBox-Check", 32, 32, 0, 1, 0, 1 },
	checkLit = { "Interface\\Buttons\\UI-CheckBox-Highlight", 32, 32, 0, 1, 0, 1 },
	slThumb = { "Interface\\Buttons\\UI-SliderBar-Button-Horizontal", 32, 32, 0, 1, 0, 1 },
	slTile = { "Interface\\Buttons\\UI-SliderBar-Background", 8, 8, 0, 1, 0, 1 },
	ddArrow = { "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up", 32, 32, 0, 1, 0, 1 },
	-- UIDropDownMenuTemplate's frame: left 25, middle, right 25 of its 128.
	ddLeft = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 25, 64, 0, 0.1953125, 0, 1 },
	ddMiddle = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 115, 64, 0.1953125, 0.8046875, 0, 1 },
	ddRight = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 25, 64, 0.8046875, 1, 0, 1 },
	-- InputBoxTemplate's field: its box runs the sheet's width, rows 0..20
	-- of 32; the rounded ends 8 wide.
	inputLeft = { "Interface\\Common\\Common-Input-Border", 8, 20, 0, 8 / 128, 0, 20 / 32 },
	inputMiddle = { "Interface\\Common\\Common-Input-Border", 112, 20, 8 / 128, 120 / 128, 0, 20 / 32 },
	inputRight = { "Interface\\Common\\Common-Input-Border", 8, 20, 120 / 128, 1, 0, 20 / 32 },
	close = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Up", 32, 32, 0, 1, 0, 1 },
	closeDown = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Down", 32, 32, 0, 1, 0, 1 },
	closeLit = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", 32, 32, 0, 1, 0, 1 },
	prev = { "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up", 32, 32, 0, 1, 0, 1 },
	next = { "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up", 32, 32, 0, 1, 0, 1 },
	-- The quest log's title highlights: gold under the selected quest,
	-- silver under the cursor.
	rowLit = { "Interface\\QuestFrame\\UI-QuestTitleHighlight", 128, 16, 0, 1, 0, 1 },
	rowHover = { "Interface\\QuestFrame\\UI-QuestLogTitleHighlight", 128, 16, 0, 1, 0, 1 },
	statusFill = { "Interface\\TargetingFrame\\UI-StatusBar", 64, 8, 0, 1, 0, 1 },
	-- UIPanelScrollBarTemplate: the arrow buttons and the knob (their art
	-- sits in the middle of 32 x 32 sheets).
	scrollUp = { "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up", 16, 16, 0.2, 0.8, 0.25, 0.75 },
	scrollDown = { "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up", 16, 16, 0.2, 0.8, 0.25, 0.75 },
	knob = { "Interface\\Buttons\\UI-ScrollBar-Knob", 16, 16, 0.25, 0.75, 0.25, 0.75 },
	-- The cast bar's frame, cut at columns 16 | 48 | 208 | 240 and rows
	-- 16 | 28 | 37 | 48 of its 256 x 64 sheet.
	castbar = { "Interface\\CastingBar\\UI-CastingBar-Border", 224, 32, 16 / 256, 240 / 256, 16 / 64, 48 / 64 },
}

-- The vanilla backdrop edge files (eight squares in a strip: left, right,
-- top, bottom, then the corners), drawn by Theme.KitEdge.
local DIALOG_EDGE = "Interface\\DialogFrame\\UI-DialogBox-Border"
local TOOLTIP_EDGE = "Interface\\Tooltips\\UI-Tooltip-Border"
local SLIDER_EDGE = "Interface\\Buttons\\UI-SliderBar-Border"

local METAL = { "UI-Frame-Metal-CornerTopLeft", "_UI-Frame-Metal-EdgeTop", "UI-Frame-Metal-CornerTopRight",
	"!UI-Frame-Metal-EdgeLeft", false, "!UI-Frame-Metal-EdgeRight",
	"UI-Frame-Metal-CornerBottomLeft", "_UI-Frame-Metal-EdgeBottom", "UI-Frame-Metal-CornerBottomRight" }
local INSET = { "UI-Frame-InnerTopLeft", "_UI-Frame-InnerTopTile", "UI-Frame-InnerTopRight",
	"!UI-Frame-InnerLeftTile", false, "!UI-Frame-InnerRightTile",
	"UI-Frame-InnerBotLeftCorner", "_UI-Frame-InnerBotTile", "UI-Frame-InnerBotRight" }
local TOOLTIP_NINE = { "Tooltip-NineSlice-CornerTopLeft", "_Tooltip-NineSlice-EdgeTop", "Tooltip-NineSlice-CornerTopRight",
	"!Tooltip-NineSlice-EdgeLeft", false, "!Tooltip-NineSlice-EdgeRight",
	"Tooltip-NineSlice-CornerBottomLeft", "_Tooltip-NineSlice-EdgeBottom", "Tooltip-NineSlice-CornerBottomRight" }

-- The parts both atlas looks share (the Settings panel's controls).
local function settingsParts(k)
	k.metal, k.inset, k.tooltip = METAL, INSET, TOOLTIP_NINE
	k.tab = { "Options_Tab_Left", "Options_Tab_Middle", "Options_Tab_Right" }
	k.tabActive = { "Options_Tab_Active_Left", "Options_Tab_Active_Middle", "Options_Tab_Active_Right" }
	k.check, k.checkOn = "checkbox-minimal", "checkmark-minimal"
	k.slider = { "Minimal_SliderBar_Left", "_Minimal_SliderBar_Middle", "Minimal_SliderBar_Right" }
	k.slThumb, k.slBack, k.slForward = "Minimal_SliderBar_Button", "Minimal_SliderBar_Button_Left", "Minimal_SliderBar_Button_Right"
	k.dropdown, k.dropdownLit, k.dropdownArrow = "common-dropdown-c-button", "common-dropdown-c-button-hover-1", "common-dropdown-c-button-hover-arrow"
	k.menu = "common-dropdown-bg"
	k.close, k.closeDown, k.closeLit = "RedButton-Exit", "RedButton-exit-pressed", "RedButton-Highlight"
	-- A kit with bareIcons draws its icon buttons as their glyph alone.
	if not k.bareIcons then k.plate, k.plateHover = "common-button-tertiary-square-normal", "common-button-tertiary-square-hover" end
	k.navLit, k.navHover = "Options_List_Active", "Options_List_Hover"
	k.streaks = "_UI-Frame-TopTileStreaks"
	-- The quest tracker's header behind the guide window's focus, unless the
	-- kit says it has none (false).
	if k.header == nil then k.header = "UI-QuestTracker-Primary-Objective-Header" end
	k.scroll = { track = { "minimal-scrollbar-track-top", "!minimal-scrollbar-track-middle", "minimal-scrollbar-track-bottom" },
		thumb = { "minimal-scrollbar-small-thumb-top", "minimal-scrollbar-small-thumb-middle", "minimal-scrollbar-small-thumb-bottom" },
		up = "minimal-scrollbar-arrow-top", down = "minimal-scrollbar-arrow-bottom", width = 8, inset = 19 }
	return k
end

local KITS = {
	-- ButtonFrameTemplateNoPortrait with the Forever client's offsets
	-- (camelot/NineSliceLayoutOverrides.lua: the right corners 2 in, the
	-- bottom ones 8 down) and its art's sizes (2x only: 95 a side), round
	-- the Settings panel's flat black ground (SettingsFrameTemplate's Bg).
	-- The guide window is a HUD piece: the micro menu box's bronze line
	-- round the whole of it, the Settings tabs on their divider at the
	-- foot of its tab strip.
	forever = settingsParts({
		source = "atlas",
		flat = true,
		metalOut = { 8, 16, 2, 8 },
		metalSize = { { 95, 95 }, { 128, 95 }, { 95, 95 }, { 95, 128 }, false, { 95, 128 }, { 95, 100 }, { 128, 100 }, { 95, 100 } },
		closeSize = 28, closeAt = { 0, 3 },
		slim = "UI-HUD-ActionBar-Frame",
		strip = "Options_HorizontalDivider",
		-- A tab on the window's edge (the guide strip) stops its outline this
		-- far under the edge, so the top of the outline reads as a tab's
		-- (#312): the frame's 3-unit line, then as much air. Its sides stand
		-- tabGap in from the tab's, so neighbours' outlines are 2 gaps apart
		-- (the Settings panel sets its tabs 5 apart) and the first tab's left
		-- side stands clear of the frame's line.
		tabClear = 6, tabGap = 5,
		card = "common-button-list-small", cardHover = "common-button-list-small-hover", cardSelected = "common-button-list-small-selected",
		rowLit = "common-button-list-small-selected",
		status = { bg = "Legacy-Progressbar-BG", fill = "Legacy-Progressbar-Fill", frame = "Legacy-Progressbar-Frame" },
	}),
	-- ButtonFrameTemplateNoPortrait's mainline offsets, the retail art. The
	-- guide window is Blizzard's own damage meter, as the meter draws it: its
	-- window's ground (black under a grey light that falls from the top,
	-- the corners rounded), its flat charcoal header over the tab strip and
	-- the navigator (headerFill), grey hairlines between its parts, its
	-- selected row flat grey (rowFlat: the active tab and the current goal),
	-- its bars, and its header's buttons as their glyphs alone, the closes
	-- too; no ornament under the focus, no gold but the titles. The toasts
	-- and cards wear the alert toasts' frame, the text buttons the
	-- 128-RedButton.
	blizzard = settingsParts({
		source = "retail",
		metalOut = { 8, 16, 4, 3 },
		closeSize = 24, closeAt = { 1, 0 },
		meter = "damagemeters-background",
		toast = { "Toast-NineSlice-CornerTopLeft", "_Toast-NineSlice-EdgeTop", "Toast-NineSlice-CornerTopRight",
			"!Toast-NineSlice-EdgeLeft", false, "!Toast-NineSlice-EdgeRight",
			"Toast-NineSlice-CornerBottomLeft", "_Toast-NineSlice-EdgeBottom", "Toast-NineSlice-CornerBottomRight" },
		headerFill = { 0.122, 0.122, 0.122 }, header = false, bareIcons = true,
		rowFlat = { 0.165, 0.165, 0.165 }, flushBare = true,
		redButton = { "128-RedButton-Left", "_128-RedButton-Center", "128-RedButton-Right",
			pressed = { "128-RedButton-Left-Pressed", "_128-RedButton-Center-Pressed", "128-RedButton-Right-Pressed" },
			disabled = { "128-RedButton-Left-Disabled", "_128-RedButton-Center-Disabled", "128-RedButton-Right-Disabled" },
			lit = "128-RedButton-Highlight" },
	}),
	-- The vanilla files: the dialog box round the big windows, the chat
	-- frame (its tabs and rim on the tooltip tile) for the guide window, the
	-- tooltip for toasts and menus, the Options panel's controls.
	classic = {
		source = "file",
		tab = { "tab" }, tabActive = { "tabActive" }, chatTab = "chatTab",
		check = "check", checkOn = "checkOn", checkLit = "checkLit",
		-- UIPanelCloseButton's red button fills 19 of its art's 32 units.
		closeInk = 19 / 32,
		slThumb = "slThumb",
		ddArrow = "ddArrow",
		close = "close", closeDown = "closeDown", closeLit = "closeLit",
		prev = "prev", next = "next",
		rowLit = "rowLit", navLit = "rowLit", rowHover = "rowHover",
		scroll = { up = "scrollUp", down = "scrollDown", knob = "knob", width = 16, inset = 16 },
		-- The XP bar's purple in the cast bar's frame.
		status = { color = { 0.58, 0, 0.55 } },
	},
}
Theme.KITS = KITS

-- The kit of the skin in use, or nil (the house style, Halo, Hearth). A skin
-- another addon registered on one of the game's looks (docs/SKINS-API.md,
-- spec.base) draws in that look's kit.
function Theme.Kit()
	return KITS[Theme.SkinKey()]
end

---------------------------------------------------------------------------
-- Art: one named piece of a kit -> file, coordinates and size
---------------------------------------------------------------------------

local ROCK = "Interface\\FrameGeneral\\UI-Background-Rock"
local MARBLE = "Interface\\FrameGeneral\\UI-Background-Marble"

local function region(kit, name)
	if not name then return nil end
	if kit.source == "file" then
		local a = CLASSIC[name]
		if a then return a[1], a[4], a[5], a[6], a[7], a[2], a[3] end
	elseif kit.source == "retail" then
		local a = ns.GameArt and ns.GameArt[name]
		if a then return a[1], a[4], a[5], a[6], a[7], a[2], a[3] end
	else
		local info = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(name)
		if info then
			return info.file or info.filename, info.leftTexCoord, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord, info.width, info.height
		end
	end
end
Theme.KitRegion = region

-- Draw `name` on texture t, or the part of it between fractions u0..u1,
-- v0..v1 of its box. -> width, height of the whole piece (nil: not there).
local function draw(t, kit, name, u0, u1, v0, v1)
	local file, l, r, tp, b, w, h = region(kit, name)
	if not file then
		t:Hide()
		return nil
	end
	t:SetTexture(file)
	u0, u1, v0, v1 = u0 or 0, u1 or 1, v0 or 0, v1 or 1
	local du, dv = r - l, b - tp
	t:SetTexCoord(l + du * u0, l + du * u1, tp + dv * v0, tp + dv * v1)
	-- The game's art, in a registered skin's art tint where it has one
	-- (spec.artTint), else as drawn.
	Theme.TintArt(t)
	t:SetBlendMode("BLEND")
	t:Show()
	return w, h
end
Theme.KitDraw = draw

-- A plain client file, tiled or stretched.
local function file(t, path, tile)
	t:SetTexture(path, tile and "REPEAT" or nil, tile and "REPEAT" or nil)
	t:SetTexCoord(0, 1, 0, 1)
	if t.SetHorizTile then t:SetHorizTile(tile and true or false); t:SetVertTile(tile and true or false) end
	Theme.TintArt(t)
	t:Show()
	return t
end

-- A lit row or tab: the kit's flat colour (a { r, g, b }) or its art (a name).
local function litPiece(t, kit, what)
	if type(what) ~= "table" then return draw(t, kit, what) end
	file(t, Theme.Media("white"))
	Theme.TintArt(t, what[1], what[2], what[3], 1)
	t:SetBlendMode("BLEND")
end

-- frame.psSkin.kit[key]: textures (and frames) a kit painted on a frame,
-- made once and kept for every later paint.
local function store(f)
	f.psSkin = f.psSkin or {}
	local k = f.psSkin.kit
	if not k then
		k = {}
		f.psSkin.kit = k
	end
	return k
end

local function tex(f, key, layer, sub, host)
	local k = store(f)
	local t = k[key]
	if not t then
		t = (host or f):CreateTexture(nil, layer or "BACKGROUND", nil, sub or -6)
		k[key] = t
	end
	return t
end

-- A child frame of f kept in its kit store, at f's level + levelUp.
local function child(f, key, levelUp, kind)
	local k = store(f)
	local o = k[key]
	if not o then
		o = CreateFrame(kind or "Frame", nil, f)
		k[key] = o
	end
	o:SetFrameLevel(max(0, f:GetFrameLevel() + (levelUp or 6)))
	o:Show()
	return o
end

local function hideKey(f, key)
	local k = f.psSkin and f.psSkin.kit
	local v = k and k[key]
	if not v then return end
	if v.Hide then v:Hide() else for _, t in pairs(v) do if t and t.Hide then t:Hide() end end end
end
Theme.KitHide = hideKey

-- Nine pieces round host as NineSliceUtil lays them: corners at their own
-- size, placed `out` past host's corners (l, t, r, b: TL at -l,t; TR at
-- r,t; BL at -l,-b; BR at r,-b), edges between the corners at their own
-- thickness, the centre (when named) inside. sizes[i] = { w, h } stands for
-- a piece's own size where the atlas reports its 2x size.
local function nine(f, key, kit, names, host, out, layer, sub, sizes)
	out = out or { 0, 0, 0, 0 }
	local k = store(f)
	local p = k[key]
	if not p then
		p = {}
		for i = 1, 9 do p[i] = host:CreateTexture(nil, layer or "BORDER", nil, sub or 0) end
		k[key] = p
	end
	local sz = {}
	for i = 1, 9 do
		local w, h
		if names[i] then w, h = draw(p[i], kit, names[i]) else p[i]:Hide() end
		if sizes and sizes[i] then w, h = sizes[i][1], sizes[i][2] end
		sz[i] = { w or 0, h or 0 }
		p[i]:ClearAllPoints()
	end
	p[1]:SetPoint("TOPLEFT", host, "TOPLEFT", -out[1], out[2]); p[1]:SetSize(sz[1][1], sz[1][2])
	p[3]:SetPoint("TOPRIGHT", host, "TOPRIGHT", out[3], out[2]); p[3]:SetSize(sz[3][1], sz[3][2])
	p[7]:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", -out[1], -out[4]); p[7]:SetSize(sz[7][1], sz[7][2])
	p[9]:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", out[3], -out[4]); p[9]:SetSize(sz[9][1], sz[9][2])
	p[2]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[2]:SetPoint("TOPRIGHT", p[3], "TOPLEFT"); p[2]:SetHeight(sz[2][2])
	p[8]:SetPoint("BOTTOMLEFT", p[7], "BOTTOMRIGHT"); p[8]:SetPoint("BOTTOMRIGHT", p[9], "BOTTOMLEFT"); p[8]:SetHeight(sz[8][2])
	p[4]:SetPoint("TOPLEFT", p[1], "BOTTOMLEFT"); p[4]:SetPoint("BOTTOMLEFT", p[7], "TOPLEFT"); p[4]:SetWidth(sz[4][1])
	p[6]:SetPoint("TOPRIGHT", p[3], "BOTTOMRIGHT"); p[6]:SetPoint("BOTTOMRIGHT", p[9], "TOPRIGHT"); p[6]:SetWidth(sz[6][1])
	p[5]:SetPoint("TOPLEFT", p[1], "BOTTOMRIGHT"); p[5]:SetPoint("BOTTOMRIGHT", p[9], "TOPLEFT")
	return p
end

-- One piece of art cut into nine: corners `cu` x `cv` of its box (fractions),
-- drawn `cw` x `ch` units.
local function nineOf(f, key, kit, name, cu, cv, cw, ch, host, out, layer, sub, noCentre)
	out = out or { 0, 0, 0, 0 }
	local k = store(f)
	local p = k[key]
	if not p then
		p = {}
		for i = 1, 9 do p[i] = host:CreateTexture(nil, layer or "BORDER", nil, sub or 0) end
		k[key] = p
	end
	local us = { { 0, cu }, { cu, 1 - cu }, { 1 - cu, 1 } }
	local vs = { { 0, cv }, { cv, 1 - cv }, { 1 - cv, 1 } }
	for row = 1, 3 do
		for col = 1, 3 do
			local i = (row - 1) * 3 + col
			draw(p[i], kit, name, us[col][1], us[col][2], vs[row][1], vs[row][2])
			p[i]:ClearAllPoints()
		end
	end
	if noCentre then p[5]:Hide() end
	p[1]:SetPoint("TOPLEFT", host, "TOPLEFT", -out[1], out[2]); p[1]:SetSize(cw, ch)
	p[3]:SetPoint("TOPRIGHT", host, "TOPRIGHT", out[3], out[2]); p[3]:SetSize(cw, ch)
	p[7]:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", -out[1], -out[4]); p[7]:SetSize(cw, ch)
	p[9]:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", out[3], -out[4]); p[9]:SetSize(cw, ch)
	p[2]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[2]:SetPoint("BOTTOMRIGHT", p[3], "BOTTOMLEFT")
	p[8]:SetPoint("TOPLEFT", p[7], "TOPRIGHT"); p[8]:SetPoint("BOTTOMRIGHT", p[9], "BOTTOMLEFT")
	p[4]:SetPoint("TOPLEFT", p[1], "BOTTOMLEFT"); p[4]:SetPoint("BOTTOMRIGHT", p[7], "TOPRIGHT")
	p[6]:SetPoint("TOPLEFT", p[3], "BOTTOMLEFT"); p[6]:SetPoint("BOTTOMRIGHT", p[9], "TOPRIGHT")
	p[5]:SetPoint("TOPLEFT", p[1], "BOTTOMRIGHT"); p[5]:SetPoint("BOTTOMRIGHT", p[9], "TOPLEFT")
	return p
end
Theme.KitNineOf = nineOf

-- An atlas cut the way the client cuts it when it draws it
-- (UiTextureAtlasElementSliceData, ns.GameArtSlice): its margins (in its own
-- units, at 1x) drawn at their size, the edges and middle stretched between.
-- out = { l, t, r, b } past host's edges. Without slice data, one stretched
-- piece. scale: the margins' drawn size per unit of slice data (0.5 for an
-- atlas whose slice data counts its 2x pixels; default 1). -> the nine textures
local function sliced(f, key, kit, name, host, out, layer, sub, noCentre, scale)
	out = out or { 0, 0, 0, 0 }
	local k = store(f)
	local p = k[key]
	if not p then
		p = {}
		for i = 1, 9 do p[i] = host:CreateTexture(nil, layer or "BORDER", nil, sub or 0) end
		k[key] = p
	end
	local _, _, _, _, _, w, h = region(kit, name)
	local m = ns.GameArtSlice and ns.GameArtSlice[name]
	for i = 1, 9 do p[i]:ClearAllPoints(); p[i]:Hide() end
	if not w then return p end
	if not m then
		draw(p[5], kit, name)
		p[5]:SetPoint("TOPLEFT", host, "TOPLEFT", -out[1], out[2])
		p[5]:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", out[3], -out[4])
		return p
	end
	local l, t, r, b = m[1], m[2], m[3], m[4]
	local us = { { 0, l / w }, { l / w, 1 - r / w }, { 1 - r / w, 1 } }
	local vs = { { 0, t / h }, { t / h, 1 - b / h }, { 1 - b / h, 1 } }
	-- The pieces' texture coordinates come from the art's own size above;
	-- only their drawn size scales.
	scale = scale or 1
	l, t, r, b = l * scale, t * scale, r * scale, b * scale
	-- A row or column with no margin collapses into its neighbour.
	local rows = { t > 0, true, b > 0 }
	local cols = { l > 0, true, r > 0 }
	local x0, y0, x1, y1 = -out[1], out[2], out[3], -out[4]
	-- Each piece's edges: { host side, offset } for left, right, top, bottom.
	local L = { { "LEFT", x0 }, { "LEFT", x0 + l }, { "RIGHT", x1 - r } }
	local Rt = { { "LEFT", x0 + l }, { "RIGHT", x1 - r }, { "RIGHT", x1 } }
	local T = { { "TOP", y0 }, { "TOP", y0 - t }, { "BOTTOM", y1 + b } }
	local B = { { "TOP", y0 - t }, { "BOTTOM", y1 + b }, { "BOTTOM", y1 } }
	for row = 1, 3 do
		for col = 1, 3 do
			local i = (row - 1) * 3 + col
			if rows[row] and cols[col] and not (noCentre and i == 5) then
				local tx = p[i]
				draw(tx, kit, name, us[col][1], us[col][2], vs[row][1], vs[row][2])
				tx:SetPoint("TOPLEFT", host, T[row][1] .. L[col][1], L[col][2], T[row][2])
				tx:SetPoint("BOTTOMRIGHT", host, B[row][1] .. Rt[col][1], Rt[col][2], B[row][2])
			end
		end
	end
	return p
end
Theme.KitSliced = sliced

-- Three pieces across host (left, middle, right): the ends `capW` units
-- wide (their art's aspect kept when capW is nil), the middle stretched.
-- names: { left, middle, right }, or one name cut at `cut` (a fraction).
local function three(f, key, kit, names, host, capW, cut, layer, sub)
	local k = store(f)
	local p = k[key]
	if not p then
		p = {}
		for i = 1, 3 do p[i] = host:CreateTexture(nil, layer or "BACKGROUND", nil, sub or -5) end
		k[key] = p
	end
	local h = host:GetHeight()
	local wl, hl
	if type(names) == "string" or #names == 1 then
		local name = type(names) == "string" and names or names[1]
		cut = cut or 0.15
		wl, hl = draw(p[1], kit, name, 0, cut, 0, 1)
		draw(p[2], kit, name, cut, 1 - cut, 0, 1)
		draw(p[3], kit, name, 1 - cut, 1, 0, 1)
		if wl then wl = wl * cut end
	else
		wl, hl = draw(p[1], kit, names[1])
		draw(p[2], kit, names[2])
		draw(p[3], kit, names[3])
	end
	local cw = capW or ((wl and hl and hl > 0 and h > 0) and wl * h / hl) or 8
	for i = 1, 3 do p[i]:ClearAllPoints() end
	p[1]:SetPoint("TOPLEFT", host, "TOPLEFT"); p[1]:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT"); p[1]:SetWidth(cw)
	p[3]:SetPoint("TOPRIGHT", host, "TOPRIGHT"); p[3]:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT"); p[3]:SetWidth(cw)
	p[2]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[2]:SetPoint("BOTTOMRIGHT", p[3], "BOTTOMLEFT")
	return p
end
Theme.KitThree = three

-- A vanilla backdrop's edge, drawn piece by piece (the client's
-- BackdropTemplate cuts its edge file the same way: eight `e`-unit squares
-- in a strip, left, right, top, bottom, then the four corners; the top and
-- bottom squares lie on their side, so they take the corner form of
-- SetTexCoord). Corners `e` a side at host's corners, moved `out` past
-- them; the edges stretched between. -> the eight textures
-- The strip's inner 1/16 is skipped as the template skips it (coordStart).
local S, E = 0.0625, 0.9375
local EDGE_UV = {
	-- piece: { ULx, ULy, LLx, LLy, URx, URy, LRx, LRy }
	tl = { 0.5078125, S, 0.5078125, E, 0.6171875, S, 0.6171875, E },
	tr = { 0.6328125, S, 0.6328125, E, 0.7421875, S, 0.7421875, E },
	bl = { 0.7578125, S, 0.7578125, E, 0.8671875, S, 0.8671875, E },
	br = { 0.8828125, S, 0.8828125, E, 0.9921875, S, 0.9921875, E },
	t = { 0.2578125, E, 0.3671875, E, 0.2578125, S, 0.3671875, S },
	b = { 0.3828125, E, 0.4921875, E, 0.3828125, S, 0.4921875, S },
	l = { 0.0078125, S, 0.0078125, E, 0.1171875, S, 0.1171875, E },
	r = { 0.1328125, S, 0.1328125, E, 0.2421875, S, 0.2421875, E },
}
local EDGE_ORDER = { "tl", "tr", "bl", "br", "t", "b", "l", "r" }
local function edge(f, key, path, e, host, out, layer, sub, cr, cg, cb, ca)
	out = out or 0
	local k = store(f)
	local p = k[key]
	if not p then
		p = {}
		for i = 1, 8 do
			local t = host:CreateTexture(nil, layer or "BORDER", nil, sub or 0)
			t:SetTexture(path)
			t:SetTexCoord(unpack(EDGE_UV[EDGE_ORDER[i]]))
			p[i] = t
		end
		k[key] = p
	end
	for i = 1, 8 do
		p[i]:ClearAllPoints()
		Theme.TintArt(p[i], cr, cg, cb, ca)
		p[i]:Show()
	end
	p[1]:SetPoint("TOPLEFT", host, "TOPLEFT", -out, out); p[1]:SetSize(e, e)
	p[2]:SetPoint("TOPRIGHT", host, "TOPRIGHT", out, out); p[2]:SetSize(e, e)
	p[3]:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", -out, -out); p[3]:SetSize(e, e)
	p[4]:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", out, -out); p[4]:SetSize(e, e)
	p[5]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[5]:SetPoint("BOTTOMRIGHT", p[2], "BOTTOMLEFT")
	p[6]:SetPoint("TOPLEFT", p[3], "TOPRIGHT"); p[6]:SetPoint("BOTTOMRIGHT", p[4], "BOTTOMLEFT")
	p[7]:SetPoint("TOPLEFT", p[1], "BOTTOMLEFT"); p[7]:SetPoint("BOTTOMRIGHT", p[3], "TOPRIGHT")
	p[8]:SetPoint("TOPLEFT", p[2], "BOTTOMLEFT"); p[8]:SetPoint("BOTTOMRIGHT", p[4], "TOPRIGHT")
	return p
end
Theme.KitEdge = edge

-- A vanilla backdrop's ground: `name` (a CLASSIC tile) repeated over host
-- `inset` units in from its edges, in the colour. -> the texture
local function tiled(f, key, name, host, inset, cr, cg, cb, ca, layer, sub)
	local t = tex(f, key, layer or "BACKGROUND", sub or -6, host)
	file(t, CLASSIC[name][1], true)
	t:ClearAllPoints()
	inset = inset or 0
	t:SetPoint("TOPLEFT", host, "TOPLEFT", inset, -inset)
	t:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", -inset, inset)
	Theme.TintArt(t, cr, cg, cb, ca)
	return t
end

-- The tooltip tile shows the backdrop colour at 57 % (its grey); lifted so
-- the window draws the colour it was given, as a tooltip's own colour
-- (0.09, 0.09, 0.19) draws darker than it reads.
local function tipTint(r, g, b)
	return min(1, r / 0.57), min(1, g / 0.57), min(1, b / 0.57)
end

-- A vanilla tooltip (the game's tooltip backdrop: the tile at the colour
-- under the 16-unit rope border) over host, `out` past f's edges.
-- `pad` draws it that much inside host's edges. Its textures are host's
-- own, under host's content.
local function tooltip(f, key, host, r, g, b, a, br, bg, bb, pad)
	local tr, tg, tb = tipTint(r, g, b)
	pad = pad or 0
	-- The tile is 91 % opaque: lifted the same way so the panel's opacity is
	-- the one it was given.
	tiled(f, key .. "Bg", "tile", host, pad + 3, tr, tg, tb, min(1, (a or 1) / 0.91), "BACKGROUND", -6)
	edge(f, key .. "Edge", TOOLTIP_EDGE, 16, host, -pad, "BACKGROUND", -5, br or 1, bg or 1, bb or 1, 1)
end

-- A panel standing inside another Polestar window (a card, a hint bar),
-- not a menu or tooltip of its own on the screen.
local function embedded(f)
	local p = f:GetParent()
	return p ~= nil and p ~= UIParent
end

-- The chat tab's 5-unit rim (corners 5 x 5, the bottom ones the top ones
-- flipped; edges stretched between them), cut from its 64 x 32 sheet.
local RIM = {
	{ "TOPLEFT", 0.03125, 0.109375, 0.28125, 0.4375 }, { "TOPRIGHT", 0.890625, 0.96875, 0.28125, 0.4375 },
	{ "BOTTOMLEFT", 0.03125, 0.109375, 0.4375, 0.28125 }, { "BOTTOMRIGHT", 0.890625, 0.96875, 0.4375, 0.28125 },
	{ "TOP", 0.375, 0.5, 0.28125, 0.4375 }, { "BOTTOM", 0.375, 0.5, 0.4375, 0.28125 },
	{ "LEFT", 0.03125, 0.109375, 0.625, 0.75 }, { "RIGHT", 0.890625, 0.96875, 0.625, 0.75 },
}
local function rim(f, host)
	local k = store(f)
	local p = k.rim
	if not p then
		p = {}
		for i = 1, 8 do
			local t = host:CreateTexture(nil, "BORDER", nil, 1)
			t:SetTexture(CLASSIC.rim[1])
			t:SetTexCoord(RIM[i][2], RIM[i][3], RIM[i][4], RIM[i][5])
			p[i] = t
		end
		for i = 1, 4 do p[i]:SetSize(5, 5); p[i]:SetPoint(RIM[i][1], host, RIM[i][1]) end
		p[5]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[5]:SetPoint("BOTTOMRIGHT", p[2], "BOTTOMLEFT")
		p[6]:SetPoint("TOPLEFT", p[3], "TOPRIGHT"); p[6]:SetPoint("BOTTOMRIGHT", p[4], "BOTTOMLEFT")
		p[7]:SetPoint("TOPLEFT", p[1], "BOTTOMLEFT"); p[7]:SetPoint("BOTTOMRIGHT", p[3], "TOPRIGHT")
		p[8]:SetPoint("TOPLEFT", p[2], "BOTTOMLEFT"); p[8]:SetPoint("BOTTOMRIGHT", p[4], "TOPRIGHT")
		k.rim = p
	end
	for i = 1, 8 do p[i]:Show() end
end

-- A close button in the kit's art (UIPanelCloseButton): normal, pushed and
-- the additive highlight.
local function closeArt(b, kit, size)
	local k = store(b)
	local n, d, l = k.closeN, k.closeD, k.closeL
	if not n then
		n = b:CreateTexture(nil, "ARTWORK", nil, 1)
		d = b:CreateTexture(nil, "ARTWORK", nil, 2)
		l = b:CreateTexture(nil, "HIGHLIGHT")
		k.closeN, k.closeD, k.closeL = n, d, l
		b:HookScript("OnMouseDown", function() if Theme.Kit() then k.closeN:SetAlpha(0); k.closeD:SetAlpha(1) end end)
		b:HookScript("OnMouseUp", function() k.closeN:SetAlpha(1); k.closeD:SetAlpha(0) end)
	end
	for _, t in ipairs({ n, d, l }) do
		t:ClearAllPoints()
		t:SetPoint("CENTER", b, "CENTER", 0, 0)
		t:SetSize(size, size)
	end
	draw(n, kit, kit.close)
	draw(d, kit, kit.closeDown)
	d:SetAlpha(0)
	n:SetAlpha(1)
	draw(l, kit, kit.closeLit)
	l:SetBlendMode("ADD")
end

-- A guide window tab's close button: the red button 14 high in every look,
-- clear of the tab's outline above and below.
local TAB_CLOSE = 14

---------------------------------------------------------------------------
-- Windows
---------------------------------------------------------------------------

local function opacity(f)
	return min(1, (f.psBgAlpha or Theme.GroundAlpha()) / 0.94)
end

-- The body fill inside the frame's rect: the house fill's texture on f.
local function body(f, r, g, b, a, inset)
	local t = P.fill(f)
	f.psSkin.kitFill = true
	t:ClearAllPoints()
	inset = inset or 0
	t:SetPoint("TOPLEFT", f, "TOPLEFT", inset, -inset)
	t:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inset, inset)
	t:SetTexture(Theme.Media("white"))
	t:SetTexCoord(0, 1, 0, 1)
	if t.SetHorizTile then t:SetHorizTile(false); t:SetVertTile(false) end
	t:SetVertexColor(r, g, b, a)
	return t
end

-- The window title (GameFontNormal: the game font at 12, gold).
local function title(f, host, point, rel, x, y)
	local k = store(f)
	local fs = k.title
	if not fs then
		fs = host:CreateFontString(nil, "OVERLAY")
		Theme.Font(fs, "label")
		fs:SetWordWrap(false)
		k.title = fs
	end
	fs:SetParent(host)
	fs:SetDrawLayer("OVERLAY", 7)
	fs:ClearAllPoints()
	fs:SetPoint(point, rel, point, x, y)
	fs:SetText(f.psTitle or "Polestar")
	fs:SetTextColor(Theme.Color("title"))
	fs:Show()
	return fs
end

-- Title-bar dragging (PanelDragBarTemplate): a strip that moves f.
local function dragBar(f, host)
	local bar = child(f, "drag", 7, "Button")
	bar:SetParent(host)
	bar:SetFrameLevel(host:GetFrameLevel() + 1)
	bar:EnableMouse(true)
	bar:RegisterForDrag("LeftButton")
	if not bar.psWired then
		bar:SetScript("OnDragStart", function() if f:IsMovable() then f:StartMoving() end end)
		bar:SetScript("OnDragStop", function() f:StopMovingOrSizing() end)
		bar.psWired = true
	end
	return bar
end

-- The window's own close action: the shell's close button, else hiding it.
local function closeWindow(f)
	local c = rawget(f, "Close")
	if c and c.Click then c:Click() else f:Hide() end
end

local function closeButton(f, host, kit, size, point, x, y)
	local b = child(f, "closeButton", 9, "Button")
	b:SetParent(host)
	b:SetFrameLevel(host:GetFrameLevel() + 4)
	b:SetSize(size, size)
	b:ClearAllPoints()
	b:SetPoint(point, host, point, x, y)
	if not b.psWired then
		b:SetScript("OnClick", function() closeWindow(f) end)
		b.psWired = true
	end
	closeArt(b, kit, size)
	b:SetShown(rawget(f, "Close") ~= nil or f.psClosable == true)
	return b
end

-- The guide window (and the toasts, psLight).
local GUIDE = {
	forever = function(f, kit)
		body(f, 0, 0, 0, 0.96 * opacity(f))
		-- The micro menu box's bronze line (55 units, its chamfered corners 12),
		-- the line 3 units in from the art's edge: laid 3 out so it runs on the
		-- window's edge, round the whole window, tab strip included, as the
		-- box runs round the micro menu's buttons: one HUD piece, not a lid
		-- over a frame (#312). Its filled middle is left out: the body is the
		-- window's own. At the window's own level, under its content: the
		-- art's inner shade (all but its outer 3 units) drew over the nav row
		-- and the progress bar at f+6 (#306).
		local o = child(f, "edge", 0)
		o:EnableMouse(false)
		o:ClearAllPoints()
		o:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
		o:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		sliced(f, "slim", kit, kit.slim, o, { 3, 3, 3, 3 }, "BORDER", 0, true)
	end,
	-- The damage meter's window on the guide window: the meter's own ground
	-- (no other fill under it), cut at its slices so its light keeps its
	-- height and its corners their round, the slices at three quarters so
	-- the light falls over the tab strip and the navigator (60 units, the
	-- meter's header), at the window's opacity: the window's own textures,
	-- under every part on it (the heads-up card on the window too). The
	-- toasts and cards: a black body under the alert toasts' frame (its
	-- rail's outer edge one unit outside: the corner art's rail starts 3 in,
	-- so 4 out), at the window's own level: the content draws over it.
	blizzard = function(f, kit)
		local a = opacity(f)
		hideKey(f, "band")
		local o = child(f, "edge", 0)
		o:EnableMouse(false)
		o:ClearAllPoints()
		o:SetAllPoints(f)
		if f.psGuide then
			P.fill(f):Hide()
			hideKey(f, "toastArt")
			local p = sliced(f, "meterArt", kit, kit.meter, f, nil, "BACKGROUND", -8, false, 0.75)
			for i = 1, 9 do p[i]:SetAlpha(0.96 * a) end
		else
			body(f, 0, 0, 0, 0.96 * a)
			hideKey(f, "meterArt")
			nine(f, "toastArt", kit, kit.toast, o, { 4, 4, 4, 4 }, "BORDER", 0)
		end
	end,
	-- The guide window is a chat frame: the tooltip tile in the window's
	-- ground colour under the chat tab's rim, its tabs cut from the same
	-- sheet (Theme.KitTab, flush). A toast (psLight) is a tooltip: the same
	-- tile under the 16-unit rope border.
	classic = function(f)
		local a = opacity(f)
		local r, g, b = Theme.Color("bg")
		local tr, tg, tb = tipTint(r, g, b)
		local t = body(f, tr, tg, tb, a, 3)
		file(t, CLASSIC.tile[1], true)
		Theme.TintArt(t, tr, tg, tb, a)
		local o = child(f, "edge", 6)
		o:EnableMouse(false)
		o:SetAllPoints(f)
		if f.psLight then
			hideKey(f, "rim")
			edge(f, "tipEdge", TOOLTIP_EDGE, 16, o, 0, "BORDER", 1)
		else
			hideKey(f, "tipEdge")
			rim(f, o)
		end
	end,
}

-- The big windows (the shell's: options, the guide menu, the hub; and the
-- dialogs): ButtonFrameTemplateNoPortrait round them. Their rect is the
-- template's Bg (7, 21, 2 and 2 in from the frame), so the frame lies
-- outside: the title bar above, a drag strip on it, the close button on its
-- corner, the metal over the window's edges.
local function bigMetal(f, kit)
	local a = opacity(f)
	local t = body(f, 1, 1, 1, a)
	file(t, ROCK, true)
	Theme.TintArt(t, 1, 1, 1, a)
	local streaks = tex(f, "streaks", "BACKGROUND", -5)
	local w, h = draw(streaks, kit, kit.streaks)
	streaks:ClearAllPoints()
	streaks:SetPoint("TOPLEFT", f, "TOPLEFT", -1, 0)
	streaks:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	streaks:SetHeight(h or 43)
	-- The template's own frame round the window.
	local frame = child(f, "frame", 0)
	frame:EnableMouse(false)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", f, "TOPLEFT", -7, 21)
	frame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)
	local o = child(f, "metal", 500)
	o:EnableMouse(false)
	o:SetAllPoints(frame)
	nine(f, "metalArt", kit, kit.metal, o, kit.metalOut, "OVERLAY", 0, kit.metalSize)
	-- The title: TOP 0,-5, between 60 in from either side (the Settings
	-- panel's own title).
	local fs = title(f, o, "TOP", o, 0, -5)
	fs:SetPoint("LEFT", o, "LEFT", 60, 0)
	fs:SetPoint("RIGHT", o, "RIGHT", -60, 0)
	local bar = dragBar(f, o)
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", o, "TOPLEFT", 0, 0)
	bar:SetPoint("TOPRIGHT", o, "TOPRIGHT", -30, 0)
	bar:SetHeight(21)
	closeButton(f, o, kit, kit.closeSize, "TOPRIGHT", kit.closeAt[1], kit.closeAt[2])
end

-- WoW Forever's big windows: the same metal, title bar, drag strip and
-- corner close button round the Settings panel's ground
-- (SettingsFrameTemplate: FlatPanelBackgroundTemplate, flat black, no rock
-- and no streaks), so the gold labels and white text read as they do in
-- the client's own settings.
local function bigFlat(f, kit)
	local a = opacity(f)
	body(f, 0, 0, 0, a)
	hideKey(f, "streaks")
	local frame = child(f, "frame", 0)
	frame:EnableMouse(false)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", f, "TOPLEFT", -7, 21)
	frame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)
	local o = child(f, "metal", 500)
	o:EnableMouse(false)
	o:SetAllPoints(frame)
	nine(f, "metalArt", kit, kit.metal, o, kit.metalOut, "OVERLAY", 0, kit.metalSize)
	local fs = title(f, o, "TOP", o, 0, -5)
	fs:SetPoint("LEFT", o, "LEFT", 60, 0)
	fs:SetPoint("RIGHT", o, "RIGHT", -60, 0)
	local bar = dragBar(f, o)
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", o, "TOPLEFT", 0, 0)
	bar:SetPoint("TOPRIGHT", o, "TOPRIGHT", -30, 0)
	bar:SetHeight(21)
	closeButton(f, o, kit, kit.closeSize, "TOPRIGHT", kit.closeAt[1], kit.closeAt[2])
end

local BIG = {
	forever = bigFlat,
	blizzard = bigMetal,
	-- The vanilla options window (InterfaceOptionsFrame): the dialog box's
	-- translucent black tile over the ground, its 32-unit border 11 units
	-- out so the band's inner edge lies on the window's edge, the header
	-- plate on the top edge (TOP 0,12) with the title in it (TOP 0,-14), the
	-- panel close button in the corner.
	classic = function(f, kit)
		local a = opacity(f)
		local r, g, b = Theme.Color("bg")
		body(f, r, g, b, a)
		tiled(f, "dialogTile", "dialogTile", f, 0, 1, 1, 1, a, "BACKGROUND", -6)
		local d = child(f, "dialog", 0)
		d:EnableMouse(false)
		d:ClearAllPoints()
		d:SetPoint("TOPLEFT", f, "TOPLEFT", -11, 11)
		d:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 11, -11)
		edge(f, "dialogArt", DIALOG_EDGE, 32, d, 0, "BORDER", 0)
		local o = child(f, "crown", 500)
		o:EnableMouse(false)
		o:SetAllPoints(d)
		local plate = tex(f, "plate", "ARTWORK", 0, o)
		file(plate, CLASSIC.header[1])
		plate:ClearAllPoints()
		plate:SetPoint("TOP", o, "TOP", 0, 12)
		plate:SetSize(256, 64)
		title(f, o, "TOP", plate, 0, -14)
		local bar = dragBar(f, o)
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", plate, "TOPLEFT", 56, -6)
		bar:SetPoint("BOTTOMRIGHT", plate, "BOTTOMRIGHT", -56, 26)
		closeButton(f, o, kit, 32, "TOPRIGHT", -4, -4)
	end,
}

-- Menus, popups and the other panels: the dropdown menu's ground (Menu
-- Style1: common-dropdown-bg stretched 10 out, 92.5 %), the game's tooltip
-- in Classic (the panel colour on the tile under the rope border). A menu
-- or popup over other frames (f.psMenu) lays that art, at the game's own
-- strength, over a ground of Theme's menuBg, so it reads as the game's menu
-- does over a dark scene and what it opens over never shows through.
local function panel(f, kit)
	if f.psBare then return P.bare(f) end
	local menu = f.psMenu
	if kit.source == "file" then
		if embedded(f) and not menu then
			-- A card inside a window: the options panel's box.
			P.fill(f):Hide()
			tooltip(f, "tip", f, 0.1, 0.1, 0.1, 0.6, 0.4, 0.4, 0.4)
		else
			local r, g, b, a = Theme.Color(menu and "menuBg" or "panel")
			-- The tile is 91 % opaque at best: the ground under it, inside the rope.
			if menu then body(f, r, g, b, a, 4):Show() else P.fill(f):Hide() end
			tooltip(f, "tip", f, r, g, b, a or 0.92)
		end
		return
	end
	if menu then body(f, Theme.Color("menuBg")):Show() else P.fill(f):Hide() end
	-- Wide enough round the items for the art's own margins (MenuStyle1
	-- insets its items 8 from the top and 15 from the bottom).
	local p = sliced(f, "menuBg", kit, kit.menu, f, { 10, 8, 10, 15 }, "BACKGROUND", -7)
	for i = 1, 9 do p[i]:SetAlpha(0.925) end
end

-- A text button: UIPanelButtonTemplate (UI-Panel-Button-Up, the same file in
-- every look), or the kit's own (Blizzard's 128-RedButton: the retail
-- template's left cap, tiled middle and right cap at the button's height,
-- the pressed and disabled sets, the red glow under the cursor).
local RED_CAP = 48 -- the bevelled end of the 128-RedButton art, in its own pixels
local function kitButton(f, kit)
	local set = kit.redButton
	local k = store(f)
	local p = k.red
	if not p then
		p = {}
		for i = 1, 3 do p[i] = f:CreateTexture(nil, "BACKGROUND", nil, -6) end
		p.lit = f:CreateTexture(nil, "HIGHLIGHT")
		p.lit:SetBlendMode("ADD")
		p.lit:SetPoint("TOPLEFT", f, "TOPLEFT", -6, 4)
		p.lit:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 6, -4)
		k.red = p
		f:HookScript("OnMouseDown", function(b) if b:IsEnabled() and Theme.Kit() == kit then k.redDown = true; kitButton(b, kit) end end)
		f:HookScript("OnMouseUp", function(b) if k.redDown then k.redDown = nil; if Theme.Kit() == kit then kitButton(b, kit) end end end)
		f:HookScript("OnEnable", function(b) if Theme.Kit() == kit then kitButton(b, kit) end end)
		f:HookScript("OnDisable", function(b) if Theme.Kit() == kit then kitButton(b, kit) end end)
	end
	local names = set
	if f.IsEnabled and not f:IsEnabled() then names = set.disabled elseif k.redDown then names = set.pressed end
	local _, _, _, _, _, wl, hl = region(kit, names[1])
	local _, _, _, _, _, wr = region(kit, names[3])
	local h = f:GetHeight()
	if not (h and h > 0) then h = Theme.Metric("buttonH", 22) end
	-- The caps keep the art's aspect at the button's height.
	local cap = (wl and hl and hl > 0) and RED_CAP * h / hl or 8
	draw(p[1], kit, names[1], 0, wl and RED_CAP / wl or 1, 0, 1)
	draw(p[2], kit, names[2])
	draw(p[3], kit, names[3], wr and 1 - RED_CAP / wr or 0, 1, 0, 1)
	draw(p.lit, kit, set.lit)
	for i = 1, 3 do p[i]:ClearAllPoints() end
	p[1]:SetPoint("TOPLEFT", f, "TOPLEFT"); p[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT"); p[1]:SetWidth(cap)
	p[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT"); p[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT"); p[3]:SetWidth(cap)
	p[2]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[2]:SetPoint("BOTTOMRIGHT", p[3], "BOTTOMLEFT")
	return p
end

local function textButton(f, kit)
	if kit.redButton then return kitButton(f, kit) end
	return P.redButton(f)
end

local function card(f, kit, selected)
	if kit.card then
		sliced(f, "card", kit, selected and kit.cardSelected or kit.card, f, nil, "BACKGROUND", -6)
		local lp = sliced(f, "cardLit", kit, kit.cardHover, f, nil, "HIGHLIGHT", 0)
		for i = 1, 9 do if lp[i] then lp[i]:SetBlendMode("ADD") end end
		return
	end
	if kit.source == "file" then
		-- The options panel's box: a tooltip border at 40 % grey on a dark ground.
		P.fill(f):Hide()
		tooltip(f, "tip", f, 0.1, 0.1, 0.1, 0.6, 0.4, 0.4, 0.4)
		P.hoverWash(f)
		return
	end
	body(f, 0, 0, 0, 0.45)
	Theme.Border(f, 1, 1, 1, 0.12)
	P.hoverWash(f)
end

-- An inset (InsetFrameTemplate: the marble tile and the inner frame), the
-- options box in Classic (InterfaceOptionsFrameCategories: a tooltip
-- border at 40 % grey on a dark ground), `pad` units in from f's edges so
-- the sidebar's box stands clear of the dialog band.
local function inset(f, kit, pad)
	if kit.source == "file" then
		P.fill(f):Hide()
		tooltip(f, "tip", f, 0.1, 0.1, 0.1, 0.5, 0.4, 0.4, 0.4, pad)
		return
	end
	local t = body(f, 1, 1, 1, 1)
	file(t, MARBLE, true)
	local o = child(f, "insetFrame", 1)
	o:EnableMouse(false)
	o:SetAllPoints(f)
	nine(f, "insetArt", kit, kit.inset, o, { 0, 0, 0, 1 }, "BORDER", -5)
end

-- A dropdown's field: WowStyle2DropdownTemplate (the Settings panel's: its
-- button art 7 out, the arrow only under the cursor), UIDropDownMenu's
-- frame in Classic (64 high round its 32, the arrow button at its right).
local function field(f, kit)
	if kit.source == "file" then
		local host = child(f, "ddHost", -1)
		host:EnableMouse(false)
		host:ClearAllPoints()
		host:SetPoint("TOPLEFT", f, "TOPLEFT", -16, 19)
		host:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 16, -21)
		three(f, "ddArt", kit, { "ddLeft", "ddMiddle", "ddRight" }, host, 25, nil, "ARTWORK", 0)
		P.hoverWash(f):SetVertexColor(1, 1, 1, 0)
		return
	end
	sliced(f, "dd", kit, kit.dropdown, f, { 7, 7, 7, 7 }, "BACKGROUND", -6)
	local dp = sliced(f, "ddLit", kit, kit.dropdownLit, f, { 7, 7, 7, 7 }, "HIGHLIGHT", 0)
	for i = 1, 9 do if dp[i] then dp[i]:SetBlendMode("ADD") end end
	local arrow = tex(f, "ddArrow", "HIGHLIGHT", 1)
	draw(arrow, kit, kit.dropdownArrow)
	arrow:ClearAllPoints()
	arrow:SetPoint("BOTTOM", f, "BOTTOM", 0, -5)
	arrow:SetSize(12, 5)
	P.hoverWash(f):SetVertexColor(1, 1, 1, 0)
end

local function checkbox(f, kit)
	P.house.checkbox(f)
	local d = f.psSkin
	d.box:Hide()
	local box = tex(f, "check", "ARTWORK", 0)
	-- The art (30 x 29 with its glow) at 26 x 25 on the Settings panel's 18
	-- unit box, and in that proportion on a smaller one (the guide window's
	-- tick boxes), so it stays inside the control's own room.
	local function size()
		local side = max(f:GetWidth(), f:GetHeight())
		if side <= 0 then side = 18 end
		local w, h = side * 26 / 18, side * 25 / 18
		box:SetSize(w, h)
		if d.check then d.check:SetSize(w, h) end
	end
	draw(box, kit, kit.check)
	box:ClearAllPoints()
	box:SetPoint("CENTER", f, "CENTER", 0, 0)
	if d.check then
		draw(d.check, kit, kit.checkOn)
		Theme.TintArt(d.check)
	end
	size()
	local k = store(f)
	if not k.checkSized then
		k.checkSized = true
		f:HookScript("OnSizeChanged", function() if k.check and k.check:IsShown() then size() end end)
	end
	-- The vanilla box lights up blue under the cursor (UI-CheckBox-Highlight,
	-- additive); the atlas looks keep the house wash off.
	if kit.checkLit then
		local lit = tex(f, "checkLit", "HIGHLIGHT", 0)
		draw(lit, kit, kit.checkLit)
		lit:SetBlendMode("ADD")
		lit:ClearAllPoints()
		lit:SetAllPoints(box)
	else
		hideKey(f, "checkLit")
	end
	P.hoverWash(f):SetVertexColor(1, 1, 1, 0)
end

local function tab(f)
	Theme.KitTab(f, f.psSelected and true or false, rawget(f, "Label"))
	local d = f.psSkin
	if d.bar then d.bar:Hide() end
	P.hoverWash(f):SetVertexColor(1, 1, 1, 0)
end

-- The scroll bar: MinimalScrollBar (8 wide, its track between the arrow
-- buttons, the proportional thumb in three pieces), UIPanelScrollBar in
-- Classic (16 wide, the arrow buttons and the knob).
local function scrollbar(bar, kit)
	local s = kit.scroll
	local thumb = bar.thumb or bar.psThumb
	bar:SetWidth(s.width)
	bar.psInset = s.inset
	-- The arrow buttons, centred on the bar, reach past its left edge when
	-- wider than it (W.ScrollBarRoom: the strip the rows leave it).
	local aw, ah = s.width == 8 and 17 or 16, s.width == 8 and 11 or 16
	bar.psReach = max(0, (aw - s.width) / 2)
	local sf = bar.psScroll
	local function arrow(key, name, point, dir)
		local b = child(bar, key, 1, "Button")
		b:SetSize(aw, ah)
		b:ClearAllPoints()
		b:SetPoint(point, bar, point, 0, 0)
		local t = tex(b, key .. "Art", "ARTWORK", 0)
		draw(t, kit, name)
		t:SetAllPoints(b)
		if not b.psWired then
			b:SetScript("OnClick", function()
				if sf then
					sf:SetVerticalScroll(max(0, sf:GetVerticalScroll() + dir * 40))
					local fn = sf:GetScript("OnMouseWheel")
					if fn then fn(sf, 0) end
				end
			end)
			b.psWired = true
		end
	end
	arrow("up", s.up, "TOP", -1)
	arrow("down", s.down, "BOTTOM", 1)
	if not thumb then return end
	thumb:SetWidth(s.width)
	if s.track then
		local host = child(bar, "trackHost", -1)
		host:EnableMouse(false)
		host:ClearAllPoints()
		host:SetPoint("TOP", bar, "TOP", 0, -s.inset)
		host:SetPoint("BOTTOM", bar, "BOTTOM", 0, s.inset)
		host:SetWidth(s.width)
		local p = store(bar).track
		if not p then
			p = { host:CreateTexture(nil, "ARTWORK"), host:CreateTexture(nil, "ARTWORK"), host:CreateTexture(nil, "ARTWORK") }
			store(bar).track = p
		end
		for i = 1, 3 do draw(p[i], kit, s.track[i]); p[i]:ClearAllPoints() end
		p[1]:SetPoint("TOP", host, "TOP"); p[1]:SetSize(8, 8)
		p[3]:SetPoint("BOTTOM", host, "BOTTOM"); p[3]:SetSize(8, 8)
		p[2]:SetPoint("TOP", p[1], "BOTTOM"); p[2]:SetPoint("BOTTOM", p[3], "TOP"); p[2]:SetWidth(8)
		draw(thumb, kit, s.thumb[2])
		local top = tex(bar, "thumbTop", "OVERLAY", 1)
		local bottom = tex(bar, "thumbBottom", "OVERLAY", 1)
		draw(top, kit, s.thumb[1])
		draw(bottom, kit, s.thumb[3])
		top:ClearAllPoints(); top:SetPoint("BOTTOM", thumb, "TOP"); top:SetSize(8, 8)
		bottom:ClearAllPoints(); bottom:SetPoint("TOP", thumb, "BOTTOM"); bottom:SetSize(8, 8)
	else
		draw(thumb, kit, s.knob)
	end
end

-- What the big windows' paint (BIG) puts round a frame: the metal and its
-- title bar, drag strip and close button, Classic's dialog box and the crown
-- with its header plate. The guide window's (GUIDE) hides it, so a frame
-- painted as a big window before its psGuide or psLight was set keeps no
-- title bar or drag strip over its neighbours (#1802).
local BIG_KEYS = { "dialog", "dialogArt", "dialogTile", "frame", "metal", "crown", "streaks" }

local function paints(name)
	local kit = KITS[name]
	return {
		window = function(f)
			if f.psBare then
				P.bare(f)
				for _, key in ipairs({ "edge", "band", "dialog", "dialogArt", "dialogTile", "frame", "metal", "crown", "streaks", "meterArt" }) do hideKey(f, key) end
				return
			end
			P.hideBorder(f)
			if f.psShadow then f.psShadow:Hide() end
			if f.psGuide or f.psLight then
				for _, key in ipairs(BIG_KEYS) do hideKey(f, key) end
				GUIDE[name](f, kit)
			else
				BIG[name](f, kit)
			end
		end,
		panel = function(f) panel(f, kit) end,
		sidebar = function(f) inset(f, kit, kit.source == "file" and 6 or nil) end,
		inset = function(f) inset(f, kit) end,
		button = function(f)
			if f.psTextButton then return textButton(f, kit) end
			card(f, kit)
		end,
		tile = function(f) card(f, kit) end,
		dropdown = function(f) field(f, kit) end,
		editbox = function(f)
			P.fill(f):Hide()
			if kit.source == "file" then
				-- InputBoxTemplate's field (Common-Input-Border), its rounded
				-- ends 4 past the box so the text keeps the box's own room.
				local host = child(f, "inputHost", -1)
				host:EnableMouse(false)
				host:ClearAllPoints()
				host:SetPoint("TOPLEFT", f, "TOPLEFT", -4, 0)
				host:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 4, 0)
				three(f, "field", kit, { "inputLeft", "inputMiddle", "inputRight" }, host, nil, nil, "BACKGROUND", -6)
			else
				three(f, "field", kit, { "common-search-border-left", "common-search-border-middle", "common-search-border-right" }, f, 8, nil, "BACKGROUND", -6)
			end
		end,
		checkbox = function(f) checkbox(f, kit) end,
		tab = function(f) tab(f) end,
		scrollbar = function(f) scrollbar(f, kit) end,
	}
end

-- The game looks' painters: the base painters of these three skins, and of
-- any registered skin built on them (Theme.lua's paint passes them on).
for name in pairs(KITS) do Theme.SKIN_PAINT[name] = paints(name) end

---------------------------------------------------------------------------
-- Parts the widgets and the guide window ask for
---------------------------------------------------------------------------

-- The house glyph under a kit's own art, hidden or shown again. In the client
-- a texture's SetAlpha and its colour's alpha are one value (#1684), so a
-- shown glyph takes its colour back (a disabled button's 35 %), and a hidden
-- one stays hidden when the button recolours it (W.Color reads psVeiled).
local function veil(icon, hidden)
	icon.psVeiled = hidden or nil
	icon:SetAlpha(hidden and 0 or 1)
	if not hidden and ns.Widgets then ns.Widgets.Recolor(icon) end
end

-- An icon button in a kit: the close art, a plate under the glyph (or, in
-- Classic, the page arrows for ‹ ›; with kit.bareIcons the glyph alone, as
-- the damage meter's header draws its buttons). -> true when the kit drew it.
function Theme.KitIconButton(b)
	local kit = Theme.Kit()
	local framed = rawget(b, "psFramed")
	local isClose = rawget(b, "psIconName") == "close"
	for _, key in ipairs({ "plate", "plateLit", "closeN", "closeD", "closeL" }) do hideKey(b, key) end
	if not kit or not (framed or isClose) then
		if b.Icon then veil(b.Icon, false) end
		return false
	end
	if isClose and kit.bareIcons then
		-- The damage meter's header: the close a glyph like its other buttons.
		veil(b.Icon, false)
		return true
	end
	if isClose then
		-- The red button the same size in every look: a tab's TAB_CLOSE,
		-- another close button's width and 2; Classic's art grown by its
		-- margin (kit.closeInk), never past the art's own 32.
		local want = rawget(b, "psTabClose") and TAB_CLOSE or b:GetWidth() + 2
		closeArt(b, kit, min(32, want / (kit.closeInk or 1)))
		veil(b.Icon, true)
		return true
	end
	if kit.source == "file" then
		if framed == "red" then
			local t = tex(b, "plate", "ARTWORK", 1)
			draw(t, kit, b.psIconName == "chevron-left" and kit.prev or kit.next)
			t:ClearAllPoints()
			t:SetPoint("CENTER", b, "CENTER", 0, 0)
			t:SetSize(b:GetWidth() + 4, b:GetHeight() + 4)
			veil(b.Icon, true)
		else
			veil(b.Icon, false)
		end
		return true
	end
	if kit.bareIcons then
		veil(b.Icon, false)
		return true
	end
	local t = tex(b, "plate", "BACKGROUND", -6)
	draw(t, kit, kit.plate)
	t:SetAllPoints(b)
	local hl = tex(b, "plateLit", "HIGHLIGHT")
	draw(hl, kit, kit.plateHover)
	hl:SetAllPoints(b)
	hl:SetBlendMode("ADD")
	veil(b.Icon, false)
	return true
end

-- The check box in place of a toggle switch (SettingsCheckboxTemplate), on
-- `host` round `anchor`. -> the box texture (its .Check the tick)
function Theme.KitCheck(owner, host, anchor, on)
	local kit = Theme.Kit()
	local k = store(owner)
	local box = k.toggle
	if not box then
		box = host:CreateTexture(nil, "ARTWORK")
		box.Check = host:CreateTexture(nil, "OVERLAY")
		k.toggle, k.toggleCheck = box, box.Check
	end
	box:Show()
	draw(box, kit, kit.check)
	box:SetSize(26, 25)
	box:ClearAllPoints()
	box:SetPoint("CENTER", anchor, "CENTER", 0, 0)
	draw(box.Check, kit, kit.checkOn)
	box.Check:SetAllPoints(box)
	box.Check:SetShown(on and true or false)
	return box
end

-- The steppers' widths and their gap to the track.
local STEP_GAP, BACK_W, FORWARD_W = 4, 11, 9

-- A slider's track, thumb and steppers (MinimalSliderWithSteppersTemplate:
-- the back button 4 left of the track, the forward one 4 right of it; the
-- options slider in Classic). -> true when the kit drew them, and the room
-- each stepper takes beside the track (back, forward: none in Classic).
function Theme.KitSlider(owner, s, thumb)
	local kit = Theme.Kit()
	for _, key in ipairs({ "trackHost", "trackTile", "trackEdge", "trackArt", "back", "forward" }) do hideKey(owner, key) end
	if not kit then return false end
	local host = child(owner, "trackHost", 0)
	host:SetParent(s)
	host:EnableMouse(false)
	host:ClearAllPoints()
	host:SetPoint("LEFT", s, "LEFT", 0, 0)
	host:SetPoint("RIGHT", s, "RIGHT", 0, 0)
	host:SetHeight(17)
	host:SetFrameLevel(s:GetFrameLevel())
	if kit.source == "file" then
		-- OptionsSliderTemplate: the slider's tile 3 in from the ends and 6
		-- from the top and bottom of its 17, under the 8-unit border; the
		-- round thumb.
		local t = tiled(owner, "trackTile", "slTile", host, 0, 1, 1, 1, 1, "BACKGROUND", -1)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", host, "TOPLEFT", 3, -6)
		t:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", -3, 6)
		edge(owner, "trackEdge", SLIDER_EDGE, 8, host, 0, "BORDER", 0)
		draw(thumb, kit, kit.slThumb)
		thumb:SetSize(32, 32)
		return true
	end
	three(owner, "trackArt", kit, kit.slider, host, 11, nil, "BACKGROUND", 0)
	draw(thumb, kit, kit.slThumb)
	thumb:SetSize(20, 19)
	local function stepper(key, name, w, h, point, rel, x, dir)
		local b = child(owner, key, 2, "Button")
		b:SetParent(s:GetParent())
		b:SetFrameLevel(s:GetFrameLevel() + 2)
		b:SetSize(w, h)
		b:ClearAllPoints()
		b:SetPoint(point, s, rel, x, 0)
		local t = tex(b, key .. "Art", "ARTWORK", 0)
		draw(t, kit, name)
		t:SetAllPoints(b)
		if not b.psWired then
			b:SetScript("OnClick", function()
				local lo, hi = s:GetMinMaxValues()
				local step = s:GetValueStep() or 1
				local v = min(hi, max(lo, s:GetValue() + dir * (step > 0 and step or 1)))
				-- A click is the player's change, as a drag is.
				local fn = s:GetScript("OnValueChanged")
				s:SetValue(v)
				if fn then fn(s, v, true) end
			end)
			b.psWired = true
		end
	end
	stepper("back", kit.slBack, BACK_W, 19, "RIGHT", "LEFT", -STEP_GAP, -1)
	stepper("forward", kit.slForward, FORWARD_W, 18, "LEFT", "RIGHT", STEP_GAP, 1)
	return true, STEP_GAP + BACK_W, STEP_GAP + FORWARD_W
end

-- A dropdown's arrow: Classic's arrow button; the atlas looks draw theirs
-- with the field (under the cursor only). -> true when the kit drew it.
function Theme.KitDropArrow(arrow)
	local kit = Theme.Kit()
	if not kit then return false end
	if kit.source == "file" then
		draw(arrow, kit, kit.ddArrow)
		arrow:SetSize(26, 26)
		arrow:SetAlpha(1)
	else
		arrow:SetAlpha(0)
	end
	return true
end

-- A tab in the kit's art (MinimalTabTemplate: Options_Tab_* along its
-- bottom, the active one 3 higher; the vanilla option tabs in Classic) with
-- its label on the art: BOTTOM 0,6 when active, 0,4 otherwise. -> true and
-- how far the middle of the tab's art lies from the tab's middle (0 for art
-- the tab's own height, or none; negative: lower).
-- `flush`: the tab's top lies on the window's edge (the guide window's
-- strip). The Settings tab art is an outline: with its top on that edge
-- its right side stood as a lone line by the rest of the strip (#312). A
-- kit with tabClear stops the outline that far under the edge, so it
-- rises from the strip's foot and closes as a tab does (Forever); a kit
-- without one lights the active tab as the Settings list's selected row.
-- Blizzard's strip is the damage meter's header: the active tab is its
-- selected row (flat, kit.rowFlat), and the resting tabs their label alone
-- (kit.flushBare).
-- `close` (the guide window's tab close button) goes on the middle of the
-- tab's art, 3 in from its right side: a tab art that stops under the
-- strip's top (or rises from its foot) is lower than the strip's middle;
-- the guide window sets its glyph and title there too.
function Theme.KitTab(b, active, label, flush, close)
	local kit = Theme.Kit()
	if not kit then
		hideKey(b, "tab")
		return false
	end
	local isFile = kit.source == "file"
	local clear = flush and kit.tabClear
	local lit = flush and active and (kit.source == "atlas" or kit.flushBare) and not clear and (kit.rowFlat or kit.navLit)
	local gap = clear and kit.tabGap or 0
	local host = child(b, "tab", -1)
	host:EnableMouse(false)
	host:ClearAllPoints()
	host:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", gap, 0)
	host:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -gap, 0)
	host:SetAlpha(1)
	-- How far the middle of the tab's art lies from the tab's own middle (0:
	-- art the tab's height, or none).
	local mid = 0
	if lit then
		host:SetPoint("TOP", b, "TOP", 0, 0)
		hideKey(b, "tabArt")
		local t = tex(b, "tabLit", "BACKGROUND", 0, host)
		litPiece(t, kit, lit)
		t:SetAllPoints(host)
	elseif flush and kit.chatTab then
		-- The chat frame's tabs on the guide window's strip: the resting
		-- ones faded as the chat frame fades them, the active one whole and
		-- 3 taller.
		hideKey(b, "tabLit")
		host:SetHeight(active and 24 or 21)
		host:SetAlpha(active and 1 or 0.55)
		mid = ((active and 24 or 21) - b:GetHeight()) / 2
		three(b, "tabArt", kit, kit.chatTab, host, 10, 10 / 58, "BACKGROUND", 0)
	elseif flush and kit.flushBare then
		hideKey(b, "tabLit")
		hideKey(b, "tabArt")
	else
		hideKey(b, "tabLit")
		local h = active and (isFile and 28 or 26) or (isFile and 24 or 23)
		if clear then
			-- The resting tabs 3 lower than the active one, as the art is.
			h = min(h, max(12, b:GetHeight() - clear - (active and 0 or 3)))
		end
		host:SetHeight(h)
		mid = (h - b:GetHeight()) / 2
		three(b, "tabArt", kit, active and kit.tabActive or kit.tab, host, isFile and 14 or 7, isFile and 16 / 112 or nil, "BACKGROUND", 0)
	end
	if label then
		b.psKitLabel = true
		label:ClearAllPoints()
		label:SetPoint("BOTTOM", b, "BOTTOM", 0, active and 6 or 4)
	end
	if close and not (flush and kit.flushBare and not lit) then
		close:ClearAllPoints()
		close:SetPoint("RIGHT", host, "RIGHT", -3, 0)
	end
	return true, mid
end

-- The highlight under the guide window's current goal and a selected
-- navigation row: Forever's selected card / the Settings list's active row,
-- Blizzard's flat selected row, Classic's quest title or list highlight.
function Theme.KitRowLit(r, shown, key, inset)
	key = key or "rowLit"
	local kit = Theme.Kit()
	hideKey(r, key .. "Edge")
	hideKey(r, key .. "Hover")
	if not kit then
		hideKey(r, key)
		return false
	end
	-- The Settings list's rows: Options_List_Hover under the cursor too; the
	-- quest log's silver title highlight in Classic.
	local hover = key == "navLit" and (kit.navHover or kit.rowHover)
	if hover then
		local hv = tex(r, key .. "Hover", "HIGHLIGHT", 0)
		draw(hv, kit, hover)
		hv:SetBlendMode("ADD")
		hv:ClearAllPoints()
		if kit.navHover then
			hv:SetPoint("LEFT", r, "LEFT", inset or 4, 0)
			hv:SetPoint("RIGHT", r, "RIGHT", -(inset or 4), 0)
			hv:SetHeight(24)
		else
			hv:SetPoint("TOPLEFT", r, "TOPLEFT", inset or 4, 0)
			hv:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", -(inset or 4), 0)
		end
	end
	if not shown then
		hideKey(r, key)
		return false
	end
	local t = tex(r, key, "BACKGROUND", -4)
	t:ClearAllPoints()
	if key == "navLit" and kit.navHover then
		t:SetPoint("LEFT", r, "LEFT", inset or 4, 0)
		t:SetPoint("RIGHT", r, "RIGHT", -(inset or 4), 0)
		t:SetHeight(24)
		draw(t, kit, kit.navLit)
		return true
	end
	t:SetPoint("TOPLEFT", r, "TOPLEFT", inset or 4, 0)
	t:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", -(inset or 4), 0)
	litPiece(t, kit, (key == "navLit" and kit.navLit) or kit.rowFlat or kit.rowLit)
	-- The quest log's gold title highlight is light (ADD); at the game's full
	-- strength it drowns a goal's coloured tip lines (the violet of a
	-- mechanic, the muted "Inside"), so the guide window's lights it at half.
	if kit.source == "file" then
		t:SetBlendMode("ADD")
		if key ~= "navLit" then Theme.TintArt(t, 1, 1, 1, 0.5) end
	end
	return true
end

-- The quest tracker's header behind the guide window's focus (Forever's
-- bronze rods; a kit with header false has none). -> true when drawn
function Theme.KitHeader(f, shown)
	local kit = Theme.Kit()
	if not (kit and kit.header and shown) then
		hideKey(f, "header")
		return false
	end
	-- The band's own rows: 4..39 of its 40; its ends (the curl that opens the
	-- lines at the left, their fade at the right) 25 of its 300, drawn at
	-- that width (12 squeezes them, Forever's rods).
	local parts = three(f, "header", kit, kit.header, f, 12, 25 / 300, "BACKGROUND", -3)
	local _, l, r, tp, b = region(kit, kit.header)
	if l then
		local du, dv = r - l, b - tp
		local us = { { 0, 25 / 300 }, { 25 / 300, 1 - 25 / 300 }, { 1 - 25 / 300, 1 } }
		for i = 1, 3 do parts[i]:SetTexCoord(l + du * us[i][1], l + du * us[i][2], tp + dv * 4 / 40, tp + dv * 39 / 40) end
	end
	return true
end

-- The guide window's tab strip ground. Forever: the Settings panel's line
-- under its tabs (kit.strip, Options_HorizontalDivider: one unit high,
-- fading out at its ends) along the strip's foot where the tabs stand, 4 in
-- from the window's sides so its ends fade inside the frame's line; with
-- the strip at the window's bottom (ui.barsBottom) along the strip's top.
-- Blizzard: the damage meter's header, flat charcoal (kit.headerFill) at
-- the window's opacity, over the tab strip and the navigator together (the
-- navigator is guideNav high under the strip, which folds to nothing in
-- compact mode, so the header then covers the navigator alone); the
-- navigator's rule (the separator) closes it.
function Theme.KitStrip(f, shown)
	local kit = Theme.Kit()
	if not (kit and (kit.headerFill or kit.strip) and shown) then
		hideKey(f, "stripHost")
		hideKey(f, "stripLine")
		return false
	end
	if kit.strip then
		hideKey(f, "stripHost")
		local t = tex(f, "stripLine", "BACKGROUND", -6)
		draw(t, kit, kit.strip)
		local flip = ns.Get and ns.Get("ui.growUp") and ns.Get("ui.barsBottom")
		local edge = flip and "TOP" or "BOTTOM"
		t:ClearAllPoints()
		t:SetPoint(edge .. "LEFT", f, edge .. "LEFT", 4, 0)
		t:SetPoint(edge .. "RIGHT", f, edge .. "RIGHT", -4, 0)
		t:SetHeight(1)
		return true
	end
	hideKey(f, "stripLine")
	-- On the strip's parent (the window): the strip hides in compact mode,
	-- and the header must stay over the navigator. Its rect still anchors to
	-- the strip's, which folds to nothing then.
	local window = f:GetParent() or f
	local host = child(f, "stripHost", -1)
	host:SetParent(window)
	host:EnableMouse(false)
	host:ClearAllPoints()
	host:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	host:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	host:SetPoint("BOTTOM", f, "BOTTOM", 0, -Theme.Metric("guideNav", 32))
	local t = tex(f, "stripFill", "BACKGROUND", -6, host)
	file(t, Theme.Media("white"))
	local c = kit.headerFill
	Theme.TintArt(t, c[1], c[2], c[3], opacity(window))
	t:SetAllPoints(host)
	return true
end

-- The guide window's progress bar in a kit, on StatusBar b (its Bg, a frame
-- piece). -> true when the kit drew it
--
-- Forever's fill is drawn as a texture of its own, cropped to the bar's value
-- (statusFill): a status bar recomputes its own texture's coordinates as it
-- fills, which lost the atlas region set on it, so the fill never showed
-- (#306). Its frame is Legacy-Progressbar-Frame round the bar as the client's
-- legacy bars wear it: 7 out a side (its 262 x 52 against the fill's 234 x 24,
-- in 2x pixels), the slice margins drawn at half their 2x size.
-- statusFill to b's value: the fill's left share of its art, as wide as that
-- share of the bar (nothing at none).
local function paintFill(b)
	local k = store(b)
	local kit, t = k.fillKit, k.statusFill
	if not (kit and t) then return end
	local lo, hi = b:GetMinMaxValues()
	local share = hi > lo and (b:GetValue() - lo) / (hi - lo) or 0
	share = max(0, min(1, share))
	local w = b:GetWidth() * share
	if w < 0.5 then
		t:Hide()
		return
	end
	draw(t, kit, kit.status.fill, 0, share, 0, 1)
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	t:SetWidth(w)
end
Theme.KitPaintFill = paintFill
function Theme.KitStatus(b)
	local kit = Theme.Kit()
	for _, key in ipairs({ "statusFrame", "statusArt", "statusNine", "statusFill" }) do hideKey(b, key) end
	-- Every kit (and the house bar after them) draws the bar's ground over
	-- the whole bar.
	b.Bg:ClearAllPoints()
	b.Bg:SetAllPoints(b)
	b.Bg:Show()
	local own = b:GetStatusBarTexture()
	if own then own:SetAlpha(1) end
	-- The percent: white; the meter's bar text at 90 % (its hard shadow is
	-- the game look's own, Theme.Font).
	local pct = rawget(b, "Pct")
	if pct then pct:SetTextColor(1, 1, 1, kit and kit.source == "retail" and 0.9 or 1) end
	local k = store(b)
	k.fillKit = nil
	if not kit then return false end
	local fill = own
	if kit.source == "atlas" then
		-- The bar's own fill stays (others read and colour it) but unseen.
		if own then own:SetAlpha(0) end
		draw(b.Bg, kit, kit.status.bg)
		local t = tex(b, "statusFill", "ARTWORK", 0)
		k.fillKit = kit
		if not k.fillHooked then
			k.fillHooked = true
			b:HookScript("OnValueChanged", paintFill)
			b:HookScript("OnSizeChanged", paintFill)
		end
		paintFill(b)
		local o = child(b, "statusFrame", 2)
		o:EnableMouse(false)
		o:ClearAllPoints()
		o:SetPoint("TOPLEFT", b, "TOPLEFT", -7, 6)
		o:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 7, -7)
		sliced(b, "statusArt", kit, kit.status.frame, o, nil, "ARTWORK", 0, true, 0.5)
	elseif kit.source == "retail" then
		-- The meter's bar as its rows wear it: the game's status bar texture
		-- in the tracker's gold (NORMAL_FONT_COLOR), square at both ends,
		-- over a faint light strip that marks the bar's length on the
		-- window's black; nothing over the fill or the percent.
		b:SetStatusBarTexture(CLASSIC.statusFill[1])
		fill = b:GetStatusBarTexture()
		fill:SetTexCoord(0, 1, 0, 1)
		Theme.TintArt(fill, 1, 0.82, 0, 1)
		file(b.Bg, Theme.Media("white"))
		Theme.TintArt(b.Bg, 1, 1, 1, 0.1)
	else
		-- The XP bar: UI-StatusBar in its purple over a half-black trough,
		-- in the cast bar's frame at 60 % of its sheet: caps 19 wide, the
		-- bands 7 over and under the bar.
		b:SetStatusBarTexture(CLASSIC.statusFill[1])
		fill = b:GetStatusBarTexture()
		fill:SetTexCoord(0, 1, 0, 1)
		local c = kit.status.color
		Theme.TintArt(fill, c[1], c[2], c[3], 1)
		file(b.Bg, Theme.Media("white"))
		Theme.TintArt(b.Bg, 0, 0, 0, 0.5)
		local o = child(b, "statusFrame", 2)
		o:EnableMouse(false)
		o:SetAllPoints(b)
		local parts = nineOf(b, "statusNine", kit, "castbar", 32 / 224, 12 / 32, 19, 7, o, { 10, 7, 10, 7 }, "ARTWORK", 0, true)
		parts[5]:Hide()
	end
	if b.psBorder then for i = 1, 4 do b.psBorder[i]:Hide() end end
	return true
end
