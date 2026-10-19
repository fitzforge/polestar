-- Polestar.Theme, the game's own skins (docs/ARCHITECTURE.md, "Skins"):
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
--               header plate round the big windows, the tooltip tile under
--               the chat tab's rim round the guide window, the panel
--               buttons, check boxes, option slider, dropdown and scroll bar.
-- Every piece drawn here lives in frame.psSkin.kit, so Theme's clearSkin
-- hides it when another skin paints the frame.

local _, ns = ...
local Theme = ns.Theme
local P = Theme.Paint

local pairs, ipairs, type, max, min = pairs, ipairs, type, math.max, math.min

-- [name] = { file, w, h, left, right, top, bottom } (sizes at 1x)
local CLASSIC = {
	tile = { "Interface\\Tooltips\\UI-Tooltip-Background", 64, 64, 0, 1, 0, 1 },
	rim = { "Interface\\ChatFrame\\ChatFrameTab", 64, 32, 0, 1, 0, 1 },
	header = { "Interface\\DialogFrame\\UI-DialogBox-Header", 256, 64, 0, 1, 0, 1 },
	tab = { "Interface\\OptionsFrame\\UI-OptionsFrame-InActiveTab", 111, 25, 9 / 128, 120 / 128, 7 / 32, 1 },
	tabActive = { "Interface\\OptionsFrame\\UI-OptionsFrame-ActiveTab", 114, 31, 7 / 128, 121 / 128, 0, 31 / 32 },
	check = { "Interface\\Buttons\\UI-CheckBox-Up", 32, 32, 0, 1, 0, 1 },
	checkOn = { "Interface\\Buttons\\UI-CheckBox-Check", 32, 32, 0, 1, 0, 1 },
	slThumb = { "Interface\\Buttons\\UI-SliderBar-Button-Horizontal", 32, 32, 0, 1, 0, 1 },
	ddArrow = { "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up", 32, 32, 0, 1, 0, 1 },
	-- UIDropDownMenuTemplate's frame: left 25, middle, right 25 of its 128.
	ddLeft = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 25, 64, 0, 0.1953125, 0, 1 },
	ddMiddle = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 115, 64, 0.1953125, 0.8046875, 0, 1 },
	ddRight = { "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame", 25, 64, 0.8046875, 1, 0, 1 },
	close = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Up", 32, 32, 0, 1, 0, 1 },
	closeDown = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Down", 32, 32, 0, 1, 0, 1 },
	closeLit = { "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", 32, 32, 0, 1, 0, 1 },
	prev = { "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up", 32, 32, 0, 1, 0, 1 },
	next = { "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up", 32, 32, 0, 1, 0, 1 },
	rowLit = { "Interface\\QuestFrame\\UI-QuestTitleHighlight", 128, 16, 0, 1, 0, 1 },
	selected = { "Interface\\Buttons\\UI-Listbox-Highlight2", 128, 16, 0, 1, 0, 1 },
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

local METAL = { "UI-Frame-Metal-CornerTopLeft", "_UI-Frame-Metal-EdgeTop", "UI-Frame-Metal-CornerTopRight",
	"!UI-Frame-Metal-EdgeLeft", false, "!UI-Frame-Metal-EdgeRight",
	"UI-Frame-Metal-CornerBottomLeft", "_UI-Frame-Metal-EdgeBottom", "UI-Frame-Metal-CornerBottomRight" }
local INSET = { "UI-Frame-InnerTopLeft", "_UI-Frame-InnerTopTile", "UI-Frame-InnerTopRight",
	"!UI-Frame-InnerLeftTile", false, "!UI-Frame-InnerRightTile",
	"UI-Frame-InnerBotLeftCorner", "_UI-Frame-InnerBotTile", "UI-Frame-InnerBotRight" }
local TOOLTIP_NINE = { "Tooltip-NineSlice-CornerTopLeft", "_Tooltip-NineSlice-EdgeTop", "Tooltip-NineSlice-CornerTopRight",
	"!Tooltip-NineSlice-EdgeLeft", false, "!Tooltip-NineSlice-EdgeRight",
	"Tooltip-NineSlice-CornerBottomLeft", "_Tooltip-NineSlice-EdgeBottom", "Tooltip-NineSlice-CornerBottomRight" }
-- The micro menu box's bronze frame, split into its actual NineSlice atlas
-- pieces (UI-HUD-ActionBar-Frame-NineSlice-*). Using the individual pieces
-- instead of sliced(UI-HUD-ActionBar-Frame) avoids the full-frame art's
-- inner semi-transparent margins (16 left/right, 20 top/bottom at 1x)
-- bleeding inside the guide window (#306).
-- Sizes at 1x; GetAtlasInfo returns 2x. Out: each piece sized to its art.
local SLIM = {
	"UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft",
	"_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop",
	"UI-HUD-ActionBar-Frame-NineSlice-CornerTopRight",
	"!UI-HUD-ActionBar-Frame-NineSlice-EdgeLeft",
	false,
	"!UI-HUD-ActionBar-Frame-NineSlice-EdgeRight",
	"UI-HUD-ActionBar-Frame-NineSlice-CornerBottomLeft",
	"_UI-HUD-ActionBar-Frame-NineSlice-EdgeBottom",
	"UI-HUD-ActionBar-Frame-NineSlice-CornerBottomRight"
}
local SLIM_SIZE = { {17,16},{16,16},{22,16}, {17,16},false,{22,16}, {17,23},{16,23},{22,23} }
local SLIM_OUT  = { 17, 16, 22, 23 }


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
	k.plate, k.plateHover = "common-button-tertiary-square-normal", "common-button-tertiary-square-hover"
	k.navLit, k.navHover = "Options_List_Active", "Options_List_Hover"
	k.streaks = "_UI-Frame-TopTileStreaks"
	k.header = "UI-QuestTracker-Primary-Objective-Header"
	k.scroll = { track = { "minimal-scrollbar-track-top", "!minimal-scrollbar-track-middle", "minimal-scrollbar-track-bottom" },
		thumb = { "minimal-scrollbar-small-thumb-top", "minimal-scrollbar-small-thumb-middle", "minimal-scrollbar-small-thumb-bottom" },
		up = "minimal-scrollbar-arrow-top", down = "minimal-scrollbar-arrow-bottom", width = 8, inset = 19 }
	return k
end

local KITS = {
	-- ButtonFrameTemplateNoPortrait with the Forever client's offsets
	-- (camelot/NineSliceLayoutOverrides.lua: the right corners 2 in, the
	-- bottom ones 8 down) and its art's sizes (2x only: 95 a side).
	forever = settingsParts({
		source = "atlas",
		metalOut = { 8, 16, 2, 8 },
		metalSize = { { 95, 95 }, { 128, 95 }, { 95, 95 }, { 95, 128 }, false, { 95, 128 }, { 95, 100 }, { 128, 100 }, { 95, 100 } },
		closeSize = 28, closeAt = { 0, 3 },
		slim = SLIM, slimOut = SLIM_OUT, slimSize = SLIM_SIZE,
		card = "common-button-list-small", cardHover = "common-button-list-small-hover", cardSelected = "common-button-list-small-selected",
		rowLit = "common-button-list-small-selected",
		status = { bg = "Legacy-Progressbar-BG", fill = "Legacy-Progressbar-Fill", frame = "Legacy-Progressbar-Frame" },
	}),
	-- ButtonFrameTemplateNoPortrait's mainline offsets, the retail art.
	blizzard = settingsParts({
		source = "retail",
		metalOut = { 8, 16, 4, 3 },
		closeSize = 24, closeAt = { 1, 0 },
		headerBar = "ui-damagemeters-header-bar",
		status = { bg = "ui-damagemeters-bar-shadowbg", edge = "ui-damagemeters-bar-shadowedge" },
	}),
	classic = {
		source = "file",
		tab = { "tab" }, tabActive = { "tabActive" },
		check = "check", checkOn = "checkOn",
		slThumb = "slThumb",
		ddArrow = "ddArrow",
		close = "close", closeDown = "closeDown", closeLit = "closeLit",
		prev = "prev", next = "next",
		rowLit = "rowLit", navLit = "selected",
		scroll = { up = "scrollUp", down = "scrollDown", knob = "knob", width = 16, inset = 16 },
	},
}
Theme.KITS = KITS

-- The kit of the skin in use, or nil (the house style, Halo, Hearth).
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
	t:SetVertexColor(1, 1, 1, 1)
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
	t:SetVertexColor(1, 1, 1, 1)
	t:Show()
	return t
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
-- piece. -> the nine textures
local function sliced(f, key, kit, name, host, out, layer, sub, noCentre)
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

-- A backdrop of the classic files (BackdropTemplate), out units past f.
local function backdrop(f, key, spec, r, g, b, a, out, levelUp, host)
	local k = store(f)
	local o = k[key]
	if not o then
		o = CreateFrame("Frame", nil, host or f, BackdropTemplateMixin and "BackdropTemplate" or nil)
		o:EnableMouse(false)
		k[key] = o
	end
	out = out or 0
	o:ClearAllPoints()
	o:SetPoint("TOPLEFT", f, "TOPLEFT", -out, out)
	o:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", out, -out)
	o:SetFrameLevel(max(0, f:GetFrameLevel() + (levelUp or 0)))
	if o.SetBackdrop then
		o:SetBackdrop(spec)
		o:SetBackdropColor(r or 0, g or 0, b or 0, a or 1)
		if o.SetBackdropBorderColor then o:SetBackdropBorderColor(1, 1, 1, 1) end
	end
	o:Show()
	return o
end

local DIALOG = { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 } }
local TOOLTIP = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } }
local SLIDER = { bgFile = "Interface\\Buttons\\UI-SliderBar-Background", edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true, tileSize = 8, edgeSize = 8, insets = { left = 3, right = 3, top = 6, bottom = 6 } }
Theme.CLASSIC_SLIDER = SLIDER
Theme.CLASSIC_TOOLTIP = TOOLTIP

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
		body(f, 0, 0, 0, 0.96 * opacity(f), 3)
		-- The micro menu box's bronze border, assembled from its nine individual
		-- NineSlice atlas pieces so each piece covers only its own art and does
		-- not extend inside the window (sliced(UI-HUD-ActionBar-Frame) had 16–20
		-- unit margins that bled inward and appeared as a semi-transparent inner
		-- border over the tab strip and content edges, #306).
		local o = child(f, "edge", 6)
		o:EnableMouse(false)
		o:SetAllPoints(f)
		nine(f, "slim", kit, kit.slim, o, kit.slimOut, "BORDER", 0, kit.slimSize)
	end,
	blizzard = function(f)
		local a = opacity(f)
		local t = body(f, 0, 0, 0, 0.96 * a)
		t:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -20)
		local band = tex(f, "band", "BACKGROUND", -7)
		band:ClearAllPoints()
		band:SetPoint("TOPLEFT", f, "TOPLEFT")
		band:SetPoint("TOPRIGHT", f, "TOPRIGHT")
		band:SetHeight(20)
		file(band, Theme.Media("white"))
		if band.SetGradient and CreateColor then
			band:SetGradient("VERTICAL", CreateColor(0, 0, 0, 0.96 * a), CreateColor(0, 0, 0, 0.48 * a))
		else
			band:SetVertexColor(0, 0, 0, 0.8 * a)
		end
	end,
	classic = function(f)
		local a = opacity(f)
		local t = body(f, 0.063, 0.063, 0.063, 0.9 * a, 3)
		t:SetTexture(CLASSIC.tile[1], "REPEAT", "REPEAT")
		if t.SetHorizTile then t:SetHorizTile(true); t:SetVertTile(true) end
		local o = child(f, "edge", 6)
		o:EnableMouse(false)
		o:SetAllPoints(f)
		rim(f, o)
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
	t:SetVertexColor(1, 1, 1, a)
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

local BIG = {
	forever = bigMetal,
	blizzard = bigMetal,
	-- The vanilla options window: the dialog box (its border 11 units
	-- in), the header plate on its top edge with the title in it, the panel
	-- close button in its corner.
	classic = function(f, kit)
		local a = opacity(f)
		body(f, 0, 0, 0, a)
		local d = backdrop(f, "dialog", DIALOG, 1, 1, 1, a, 11, 0)
		local o = child(f, "metal", 500)
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
		bar:SetPoint("TOPLEFT", plate, "TOPLEFT", 50, 0)
		bar:SetPoint("BOTTOMRIGHT", plate, "BOTTOMRIGHT", -50, 24)
		closeButton(f, o, kit, 32, "TOPRIGHT", -4, -4)
	end,
}

-- Menus, popups and the other panels: the dropdown menu's ground (Menu
-- Style1: common-dropdown-bg stretched 10 out, 92.5 %), the tooltip in
-- Classic.
local function panel(f, kit)
	if f.psBare then return P.bare(f) end
	if kit.source == "file" then
		P.fill(f):Hide()
		backdrop(f, "tipBd", TOOLTIP, 0, 0, 0, 0.92, 0, 0)
		return
	end
	P.fill(f):Hide()
	-- Wide enough round the items for the art's own margins (MenuStyle1
	-- insets its items 8 from the top and 15 from the bottom).
	local p = sliced(f, "menuBg", kit, kit.menu, f, { 10, 8, 10, 15 }, "BACKGROUND", -7)
	for i = 1, 9 do p[i]:SetAlpha(0.925) end
end

-- A text button: UIPanelButtonTemplate (UI-Panel-Button-Up, the same file in
-- every look).
local function textButton(f)
	return P.redButton(f)
end

local function card(f, kit, selected)
	if kit.card then
		sliced(f, "card", kit, selected and kit.cardSelected or kit.card, f, nil, "BACKGROUND", -6)
		-- ADD blend: the hover art brightens rather than covering icons and labels
		-- (#306).
		local lp = sliced(f, "cardLit", kit, kit.cardHover, f, nil, "HIGHLIGHT", 0)
		for i = 1, 9 do if lp[i] then lp[i]:SetBlendMode("ADD") end end
		return
	end
	if kit.source == "file" then
		P.fill(f):Hide()
		local o = backdrop(f, "tipBd", TOOLTIP, 0.1, 0.1, 0.1, 0.6, 0, 0)
		if o.SetBackdropBorderColor then o:SetBackdropBorderColor(0.4, 0.4, 0.4, 1) end
		P.hoverWash(f)
		return
	end
	body(f, 0, 0, 0, 0.45)
	Theme.Border(f, 1, 1, 1, 0.12)
	P.hoverWash(f)
end

-- An inset (InsetFrameTemplate: the marble tile and the inner frame), the
-- options box in Classic (a tooltip border at 40 % grey on a dark ground).
local function inset(f, kit)
	if kit.source == "file" then
		P.fill(f):Hide()
		local o = backdrop(f, "tipBd", TOOLTIP, 0.1, 0.1, 0.1, 0.5, 0, 0)
		if o.SetBackdropBorderColor then o:SetBackdropBorderColor(0.4, 0.4, 0.4, 1) end
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
	local w, h = 26, 25
	draw(box, kit, kit.check)
	box:SetSize(w, h)
	box:ClearAllPoints()
	box:SetPoint("CENTER", f, "CENTER", 0, 0)
	if d.check then
		draw(d.check, kit, kit.checkOn)
		d.check:SetSize(w, h)
		d.check:SetVertexColor(1, 1, 1, 1)
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
	local sf = bar.psScroll
	local function arrow(key, name, point, dir)
		local b = child(bar, key, 1, "Button")
		b:SetSize(s.width == 8 and 17 or 16, s.width == 8 and 11 or 16)
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

local function paints(name)
	local kit = KITS[name]
	return {
		window = function(f)
			if f.psBare then
				P.bare(f)
				for _, key in ipairs({ "edge", "band", "dialog", "frame", "metal", "streaks" }) do hideKey(f, key) end
				return
			end
			P.hideBorder(f)
			if f.psShadow then f.psShadow:Hide() end
			if f.psGuide or f.psLight then GUIDE[name](f, kit) else BIG[name](f, kit) end
		end,
		panel = function(f) panel(f, kit) end,
		sidebar = function(f) inset(f, kit) end,
		inset = function(f) inset(f, kit) end,
		button = function(f)
			if f.psTextButton then return textButton(f) end
			card(f, kit)
		end,
		tile = function(f) card(f, kit) end,
		dropdown = function(f) field(f, kit) end,
		editbox = function(f)
			if kit.source == "file" then
				P.fill(f):Hide()
				backdrop(f, "tipBd", TOOLTIP, 0, 0, 0, 0.8, 0, 0)
			else
				P.fill(f):Hide()
				three(f, "field", kit, { "common-search-border-left", "common-search-border-middle", "common-search-border-right" }, f, 8, nil, "BACKGROUND", -6)
			end
		end,
		checkbox = function(f) checkbox(f, kit) end,
		tab = function(f) tab(f) end,
		scrollbar = function(f) scrollbar(f, kit) end,
	}
end

for name in pairs(KITS) do Theme.SKIN_PAINT[name] = paints(name) end

---------------------------------------------------------------------------
-- Parts the widgets and the guide window ask for
---------------------------------------------------------------------------

-- An icon button in a kit: the close art, a plate under the glyph (or, in
-- Classic, the page arrows for ‹ ›). -> true when the kit drew it.
function Theme.KitIconButton(b)
	local kit = Theme.Kit()
	local framed = rawget(b, "psFramed")
	local isClose = rawget(b, "psIconName") == "close"
	for _, key in ipairs({ "plate", "plateLit", "closeN", "closeD", "closeL" }) do hideKey(b, key) end
	if not kit or not (framed or isClose) then
		if b.Icon then b.Icon:SetAlpha(1) end
		return false
	end
	if isClose then
		closeArt(b, kit, min(32, b:GetWidth() + 2))
		b.Icon:SetAlpha(0)
		return true
	end
	if kit.source == "file" then
		if framed == "red" then
			local t = tex(b, "plate", "ARTWORK", 1)
			draw(t, kit, b.psIconName == "chevron-left" and kit.prev or kit.next)
			t:ClearAllPoints()
			t:SetPoint("CENTER", b, "CENTER", 0, 0)
			t:SetSize(b:GetWidth() + 4, b:GetHeight() + 4)
			b.Icon:SetAlpha(0)
		else
			b.Icon:SetAlpha(1)
		end
		return true
	end
	local t = tex(b, "plate", "BACKGROUND", -6)
	draw(t, kit, kit.plate)
	t:SetAllPoints(b)
	local hl = tex(b, "plateLit", "HIGHLIGHT")
	draw(hl, kit, kit.plateHover)
	hl:SetAllPoints(b)
	hl:SetBlendMode("ADD")  -- ADD: hover brightens without hiding the icon (#306)
	b.Icon:SetAlpha(1)
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

-- A slider's track, thumb and steppers (MinimalSliderWithSteppersTemplate:
-- the back button 4 left of the track, the forward one 4 right of it; the
-- options slider in Classic). -> true when the kit drew them.
function Theme.KitSlider(owner, s, thumb)
	local kit = Theme.Kit()
	for _, key in ipairs({ "trackBd", "trackHost", "back", "forward" }) do hideKey(owner, key) end
	if not kit then return false end
	if kit.source == "file" then
		local o = backdrop(owner, "trackBd", SLIDER, 1, 1, 1, 1, 0, 0, s)
		o:ClearAllPoints()
		o:SetPoint("LEFT", s, "LEFT", 0, 0)
		o:SetPoint("RIGHT", s, "RIGHT", 0, 0)
		o:SetHeight(17)
		o:SetFrameLevel(s:GetFrameLevel())
		draw(thumb, kit, kit.slThumb)
		thumb:SetSize(32, 32)
		return true
	end
	local host = child(owner, "trackHost", 0)
	host:SetParent(s)
	host:EnableMouse(false)
	host:ClearAllPoints()
	host:SetPoint("LEFT", s, "LEFT", 0, 0)
	host:SetPoint("RIGHT", s, "RIGHT", 0, 0)
	host:SetHeight(17)
	host:SetFrameLevel(s:GetFrameLevel())
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
	stepper("back", kit.slBack, 11, 19, "RIGHT", "LEFT", -4, -1)
	stepper("forward", kit.slForward, 9, 18, "LEFT", "RIGHT", 4, 1)
	return true
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
-- its label on the art: BOTTOM 0,6 when active, 0,4 otherwise. -> true
-- `flush`: the tab's top lies on the window's edge (the guide window's
-- strip). Forever's tab art is an outline whose top and left run along that
-- edge, leaving its right side as a lone line by the rest of the strip
-- (#312); there the active tab is the Settings list's selected row instead.
function Theme.KitTab(b, active, label, flush)
	local kit = Theme.Kit()
	if not kit then
		hideKey(b, "tab")
		return false
	end
	local isFile = kit.source == "file"
	local lit = flush and active and kit.source == "atlas" and kit.navLit
	local host = child(b, "tab", -1)
	host:EnableMouse(false)
	host:ClearAllPoints()
	host:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	host:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
	if lit then
		host:SetPoint("TOP", b, "TOP", 0, 0)
		hideKey(b, "tabArt")
		local t = tex(b, "tabLit", "BACKGROUND", 0, host)
		draw(t, kit, lit)
		t:SetAllPoints(host)
	else
		hideKey(b, "tabLit")
		host:SetHeight(active and (isFile and 28 or 26) or (isFile and 24 or 23))
		three(b, "tabArt", kit, active and kit.tabActive or kit.tab, host, isFile and 14 or 7, isFile and 16 / 112 or nil, "BACKGROUND", 0)
	end
	if label then
		b.psKitLabel = true
		label:ClearAllPoints()
		label:SetPoint("BOTTOM", b, "BOTTOM", 0, active and 6 or 4)
	end
	return true
end

-- The highlight under the guide window's current goal and a selected
-- navigation row: Forever's selected card / the Settings list's active row,
-- Blizzard's gold wash, Classic's quest title or list highlight.
function Theme.KitRowLit(r, shown, key, inset)
	key = key or "rowLit"
	local kit = Theme.Kit()
	hideKey(r, key .. "Edge")
	hideKey(r, key .. "Hover")
	if not kit then
		hideKey(r, key)
		return false
	end
	-- The Settings list's rows: Options_List_Hover under the cursor too.
	if key == "navLit" and kit.navHover then
		local hv = tex(r, key .. "Hover", "HIGHLIGHT", 0)
		draw(hv, kit, kit.navHover)
		hv:SetBlendMode("ADD")  -- ADD: hover brightens without covering labels (#306)
		hv:ClearAllPoints()
		hv:SetPoint("LEFT", r, "LEFT", inset or 4, 0)
		hv:SetPoint("RIGHT", r, "RIGHT", -(inset or 4), 0)
		hv:SetHeight(24)
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
	if kit.source == "retail" then
		file(t, Theme.Media("white"))
		if t.SetGradient and CreateColor then
			t:SetGradient("HORIZONTAL", CreateColor(1, 0.82, 0, 0.2), CreateColor(1, 0.82, 0, 0))
		else
			t:SetVertexColor(1, 0.82, 0, 0.12)
		end
		local e = tex(r, key .. "Edge", "BORDER", 0)
		file(e, Theme.Media("white"))
		e:SetVertexColor(1, 0.82, 0, 1)
		e:ClearAllPoints()
		e:SetPoint("TOPLEFT", t, "TOPLEFT")
		e:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT")
		e:SetWidth(2)
		return true
	end
	draw(t, kit, (key == "navLit" and kit.navLit) or kit.rowLit)
	if kit.source == "file" then t:SetBlendMode("ADD") end
	return true
end

-- The quest tracker's header behind the guide window's focus (Forever's
-- bronze rods, Blizzard's gold filigree). -> true when drawn
function Theme.KitHeader(f, shown)
	local kit = Theme.Kit()
	if not (kit and kit.header and shown) then
		hideKey(f, "header")
		return false
	end
	-- The band's own rows: 4..39 of its 40, its ends' rods 25 of its 300.
	local parts = three(f, "header", kit, kit.header, f, 12, 25 / 300, "BACKGROUND", -3)
	local _, l, r, tp, b = region(kit, kit.header)
	if l then
		local du, dv = r - l, b - tp
		local us = { { 0, 25 / 300 }, { 25 / 300, 1 - 25 / 300 }, { 1 - 25 / 300, 1 } }
		for i = 1, 3 do parts[i]:SetTexCoord(l + du * us[i][1], l + du * us[i][2], tp + dv * 4 / 40, tp + dv * 39 / 40) end
	end
	return true
end

-- The guide window's tab strip ground: Blizzard's damage meter header bar.
function Theme.KitStrip(f, shown)
	local kit = Theme.Kit()
	if not (kit and kit.headerBar and shown) then
		hideKey(f, "strip")
		return false
	end
	local t = tex(f, "strip", "BACKGROUND", -6)
	draw(t, kit, kit.headerBar)
	t:SetAllPoints(f)
	return true
end

-- The guide window's progress bar in a kit, on StatusBar b (its Bg, a frame
-- piece). -> true when the kit drew it
function Theme.KitStatus(b)
	local kit = Theme.Kit()
	for _, key in ipairs({ "statusFrame", "statusEdge", "statusArt", "statusNine" }) do hideKey(b, key) end
	if not kit then return false end
	local fill = b:GetStatusBarTexture()
	if kit.source == "atlas" then
		-- SetStatusBarAtlas tells the bar the fill is an atlas piece; the engine
		-- then fills the piece proportionally. SetStatusBarTexture + SetTexCoord
		-- breaks because the bar recomputes the right texcoord as a fraction of
		-- the full atlas file, not of the piece, so the fill is nearly invisible
		-- at any percentage (#306).
		if b.SetStatusBarAtlas then
			b:SetStatusBarAtlas(kit.status.fill)
		else
			local f, l, r, tp, bt = region(kit, kit.status.fill)
			if f then b:SetStatusBarTexture(f); b:GetStatusBarTexture():SetTexCoord(l, r, tp, bt) end
		end
		fill = b:GetStatusBarTexture()
		fill:SetVertexColor(1, 1, 1, 1)
		draw(b.Bg, kit, kit.status.bg)
		local o = child(b, "statusFrame", 2)
		o:EnableMouse(false)
		o:ClearAllPoints()
		o:SetPoint("TOPLEFT", b, "TOPLEFT", -7, 6)
		o:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 7, -7)
		sliced(b, "statusArt", kit, kit.status.frame, o, nil, "ARTWORK", 0, true)
	elseif kit.source == "retail" then
		b:SetStatusBarTexture(CLASSIC.statusFill[1])
		fill = b:GetStatusBarTexture()
		fill:SetTexCoord(0, 1, 0, 1)
		fill:SetVertexColor(1, 0.67, 0, 1)
		draw(b.Bg, kit, kit.status.bg)
		local e = tex(b, "statusEdge", "OVERLAY", 6)
		draw(e, kit, kit.status.edge)
		e:ClearAllPoints()
		e:SetPoint("TOPLEFT", b, "TOPLEFT", -2, 2)
		e:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 2, -2)
	else
		b:SetStatusBarTexture(CLASSIC.statusFill[1])
		fill = b:GetStatusBarTexture()
		fill:SetTexCoord(0, 1, 0, 1)
		fill:SetVertexColor(0, 0.8, 0, 1)
		file(b.Bg, Theme.Media("white"))
		b.Bg:SetVertexColor(0, 0, 0, 0.5)
		local o = child(b, "statusFrame", 2)
		o:EnableMouse(false)
		o:SetAllPoints(b)
		-- The cast bar frame at 60 % of its sheet: caps 19 wide, the bands
		-- 7 over and under the bar.
		local parts = nineOf(b, "statusNine", kit, "castbar", 32 / 224, 12 / 32, 19, 7, o, { 10, 7, 10, 7 }, "ARTWORK", 0, true)
		parts[5]:Hide()
	end
	if b.psBorder then for i = 1, 4 do b.psBorder[i]:Hide() end end
	return true
end
