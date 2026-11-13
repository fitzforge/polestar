-- The settings window's own widgets, loaded with it (Polestar_Options),
-- never at login: colour rows (W.Swatch, with the hex, the opacity and the
-- recent colours), picture cards (W.Cards), a row's inline extras and cog
-- (W.InlineSwatch, W.InlineToggle, W.Cog), section cards and their header
-- switch (W.SectionCard, W.HeaderSwitch), action rows and tiles
-- (W.ActionRow, W.ActionTile) and Polestar's memory for About
-- (W.AddonMemory). They join core's kit (Polestar/Theme/Widgets.lua) under
-- the same names and build on its rows (W.RowParts).

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local type, pairs, ipairs, floor, max, min = type, pairs, ipairs, math.floor, math.max, math.min

local WHITE = Theme.Media("white")
local P = W.RowParts
local settingRow, fitLabel, dimRow, rowEnter = P.settingRow, P.fitLabel, P.dimRow, P.rowEnter
local simpleTip, hideTip, hoverTexture = P.simpleTip, P.hideTip, P.hoverTexture
local choicesOf, valueOf = P.choicesOf, P.valueOf
local HALF_PAD, COMPACT_CHIP = P.HALF_PAD, P.COMPACT_CHIP
local textWidth = W.TextWidth

---------------------------------------------------------------------------
-- Colour swatch: opens the game's colour picker; right-click restores the
-- default. Always editable. Beside the chip: the colour as hex, which takes
-- a typed one (Enter applies it), and the colours picked last (any colour
-- row's, PolestarDB.recentColors), a click applying one; a right-click on
-- one keeps it as a favourite (PolestarDB.pinnedColors, shown first, out of
-- the recents' turnover; right-click again lets it go). Nearest the chip,
-- after a change, the colour the row held before it: a click goes back.
-- opts:
--   shown() -> r, g, b: the colour in effect when the setting holds none
--     (the scheme's accent, EllesmereUI's, the scheme's ground);
--   source() -> text: where that colour comes from, shown left of the chip
--     while the setting holds none ("EllesmereUI", "Dusk");
--   linked: other paths a cancelled pick restores too (picking an accent
--     turns Match EllesmereUI accent off);
--   alpha: the colour has an opacity too, stored { r, g, b, a }.
---------------------------------------------------------------------------

local HEX_W, RECENT_N, RECENT_SIZE, RECENT_GAP = 76, 5, 12, 3
local RECENT_W = RECENT_N * (RECENT_SIZE + RECENT_GAP) - RECENT_GAP
local swatches = setmetatable({}, { __mode = "k" })

-- A colour chip's edge: a light hairline, so a dark colour still reads as a
-- chip on the dark row ground.
local function chipEdge(f)
	local r, g, b = Theme.Color("textDim")
	Theme.Border(f, r, g, b, 0.45)
end

local function swatchColor(self)
	local c = ns.Get(self.psPath)
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3], true, c[4] or 1 end
	if self.psShown then
		local r, g, b, a = self.psShown()
		return r, g, b, false, (self.psAlpha and a) or 1
	end
	c = ns.GetDefault(self.psPath)
	if type(c) == "table" then return c[1], c[2], c[3], false, c[4] or 1 end
	return 1, 1, 1, false, 1
end

local function hexByte(v) return string.format("%02X", floor(min(1, max(0, v or 0)) * 255 + 0.5)) end

-- "#RRGGBB" (and "AA" with an opacity) for r, g, b, a.
function W.ColorHex(r, g, b, a)
	return "#" .. hexByte(r) .. hexByte(g) .. hexByte(b) .. (a and hexByte(a) or "")
end

-- "#e6ba66", "e6ba66", "#E6BA66CC", "fc0" -> r, g, b, a | nil
function W.ParseHex(text)
	local h = tostring(text or ""):gsub("[%s#]", "")
	if not h:match("^%x+$") then return nil end
	if #h == 3 then h = h:gsub("(%x)", "%1%1") end
	if #h ~= 6 and #h ~= 8 then return nil end
	local function at(i) return tonumber(h:sub(i, i + 1), 16) / 255 end
	return at(1), at(3), at(5), #h == 8 and at(7) or nil
end

local function recentList()
	local db = ns.DB()
	if type(db.recentColors) ~= "table" then db.recentColors = {} end
	return db.recentColors
end

local function pinnedList()
	local db = ns.DB()
	if type(db.pinnedColors) ~= "table" then db.pinnedColors = {} end
	return db.pinnedColors
end

local function sameColor(o, c)
	return type(o) == "table" and type(c) == "table" and type(o[1]) == "number" and type(c[1]) == "number"
		and math.abs(o[1] - c[1]) < 0.002 and math.abs(o[2] - c[2]) < 0.002 and math.abs(o[3] - c[3]) < 0.002
		and math.abs((o[4] or 1) - (c[4] or 1)) < 0.002
end

local function isPinned(c)
	for _, o in ipairs(pinnedList()) do if sameColor(o, c) then return true end end
	return false
end

local function refreshSwatches()
	for row in pairs(swatches) do row:Refresh() end
end

-- Keep a colour as a favourite (first among the squares, out of the
-- recents' turnover; RECENT_N kept), or let it go (on = false).
function W.PinColor(c, on)
	if type(c) ~= "table" or type(c[1]) ~= "number" then return end
	local list = pinnedList()
	for i = #list, 1, -1 do if sameColor(list[i], c) or type(list[i]) ~= "table" then table.remove(list, i) end end
	if on ~= false then
		table.insert(list, 1, { c[1], c[2], c[3], c[4] })
		for i = #list, RECENT_N + 1, -1 do list[i] = nil end
	end
	refreshSwatches()
end

-- Put a colour first among the recent ones (8 kept, no repeats).
function W.PushRecentColor(c)
	if type(c) ~= "table" or type(c[1]) ~= "number" then return end
	local list = recentList()
	for i = #list, 1, -1 do
		local o = list[i]
		if type(o) ~= "table" or (math.abs(o[1] - c[1]) < 0.002 and math.abs(o[2] - c[2]) < 0.002 and math.abs(o[3] - c[3]) < 0.002
			and math.abs((o[4] or 1) - (c[4] or 1)) < 0.002) then
			table.remove(list, i)
		end
	end
	table.insert(list, 1, { c[1], c[2], c[3], c[4] })
	for i = #list, 9, -1 do list[i] = nil end
	refreshSwatches()
end

-- Write a colour to a row's setting ({ r, g, b } or with its opacity).
local function swatchWrite(self, r, g, b, a)
	if self.psAlpha then
		ns.Set(self.psPath, { r, g, b, a or 1 })
	else
		ns.Set(self.psPath, { r, g, b })
	end
end

-- What a row holds now, kept as its previous colour before a change made
-- from it: the value as stored (nil: its default) and the colour shown.
local function remember(row)
	local v = ns.GetStored(row.psPath)
	if type(v) == "table" then v = { v[1], v[2], v[3], v[4] } end
	local r, g, b, _, a = swatchColor(row)
	row.psPrev = { value = v, color = { r, g, b, row.psAlpha and a or nil } }
end

-- A square's edge: the accent around a favourite, the swatch hairline else.
local function paintSquare(sq)
	if sq.psPinned then
		local r, g, b = Theme.Accent()
		Theme.Border(sq, r, g, b, 0.95)
	else
		Theme.Border(sq, Theme.Wash("swatch"))
	end
end

local function swatchRefresh(self)
	local r, g, b, own, a = swatchColor(self)
	self.Chip:SetVertexColor(r, g, b, self.psAlpha and a or 1)
	self.Note:SetText((not own and self.psSource and self.psSource()) or "")
	if not self.Hex:HasFocus() then self.Hex:SetText(W.ColorHex(r, g, b):sub(2)) end
	W.Color(self.Hex, own and "text" or "textDim")
	local alpha = rawget(self, "Alpha")
	if alpha then
		if not alpha:HasFocus() then alpha:SetText(floor(a * 100 + 0.5) .. "%") end
		W.Color(alpha, own and "text" or "textDim")
	end
	-- The favourites first, then the recent ones not among them; the
	-- colour held before the last change nearest the chip, while it differs.
	local shown = {}
	for _, c in ipairs(pinnedList()) do
		if #shown < RECENT_N and type(c) == "table" and type(c[1]) == "number" then shown[#shown + 1] = c end
	end
	local pins = #shown
	for _, c in ipairs(recentList()) do
		if #shown < RECENT_N and type(c) == "table" and type(c[1]) == "number" and not isPinned(c) then shown[#shown + 1] = c end
	end
	local prev = rawget(self, "psPrev")
	local back = prev ~= nil and not sameColor(prev.color, { r, g, b, self.psAlpha and a or nil }) and prev
	self.Prev:SetShown(back and true or false)
	if back then self.Prev.Fill:SetVertexColor(back.color[1], back.color[2], back.color[3], 1) end
	local start = back and (RECENT_SIZE + RECENT_GAP + 4) or 0
	for i, sq in ipairs(self.Recent) do
		local c = shown[i]
		sq.psPinned = i <= pins
		sq:ClearAllPoints()
		sq:SetPoint("RIGHT", self.RecentBar, "RIGHT", -(start + (i - 1) * (RECENT_SIZE + RECENT_GAP)), 0)
		if c then
			sq.Fill:SetVertexColor(c[1], c[2], c[3], 1)
			sq.psColor = c
			sq:Show()
		else
			sq.psColor = nil
			sq:Hide()
		end
		paintSquare(sq)
	end
	dimRow(self, W.Enabled(self))
end

-- The pick open in the game's colour picker: its colour goes to the recent
-- ones when the picker closes, unless it was cancelled.
local picking
local pickerHooked = false

local function pickerAlpha()
	local P = ColorPickerFrame
	if P.GetColorAlpha then return P:GetColorAlpha() end
	if OpacitySliderFrame and OpacitySliderFrame.GetValue then return 1 - OpacitySliderFrame:GetValue() end
	return 1
end

local function openPicker(self)
	if not ColorPickerFrame or not ColorPickerFrame.SetupColorPickerAndShow then return end
	if not pickerHooked and ColorPickerFrame.HookScript then
		pickerHooked = true
		ColorPickerFrame:HookScript("OnHide", function()
			local p = picking
			picking = nil
			if p and not p.cancelled then
				local c = ns.Get(p.path)
				if type(c) == "table" then W.PushRecentColor(c) end
			end
		end)
	end
	local path = self.psPath
	local r, g, b, _, a = swatchColor(self)
	if rawget(self, "Prev") then remember(self) end
	local previous = ns.Get(path)
	local linked = {}
	for i, p in ipairs(self.psLinked or {}) do linked[i] = ns.Get(p) end
	local pick = { path = path }
	picking = pick
	local function apply()
		local nr, ng, nb = ColorPickerFrame:GetColorRGB()
		swatchWrite(self, nr, ng, nb, self.psAlpha and pickerAlpha() or nil)
	end
	ColorPickerFrame:SetupColorPickerAndShow({
		r = r, g = g, b = b,
		hasOpacity = self.psAlpha and true or false,
		opacity = self.psAlpha and a or nil,
		swatchFunc = apply,
		opacityFunc = self.psAlpha and apply or nil,
		cancelFunc = function()
			pick.cancelled = true
			ns.Set(path, previous)
			for i, p in ipairs(self.psLinked or {}) do ns.Set(p, linked[i]) end
		end,
	})
end

local function recentClick(sq, button)
	local row = sq.psRow
	local c = sq.psColor
	if not (c and W.Enabled(row)) then return end
	-- Right-click: kept as a favourite, or let go.
	if button == "RightButton" then return W.PinColor(c, not sq.psPinned) end
	local _, _, _, _, a = swatchColor(row)
	remember(row)
	swatchWrite(row, c[1], c[2], c[3], c[4] or a)
end

local function recentEnter(sq)
	local c = sq.psColor
	if not c then return end
	W.Tooltip(sq, "ANCHOR_TOP", W.ColorHex(c[1], c[2], c[3], c[4]), {
		L["Click to use this colour"],
		sq.psPinned and L["Right-click to stop keeping it."] or L["Right-click to keep it as a favourite."],
	})
end

-- The square nearest the chip: the colour the row held before its last
-- change; a click goes back to it.
local function prevClick(sq)
	local row = sq.psRow
	local back = rawget(row, "psPrev")
	if not (back and W.Enabled(row)) then return end
	remember(row)
	ns.Set(row.psPath, back.value)
end

local function prevEnter(sq)
	local back = rawget(sq.psRow, "psPrev")
	local c = back and back.color
	if c then W.Tooltip(sq, "ANCHOR_TOP", L["Previous colour"], { W.ColorHex(c[1], c[2], c[3]), L["Click to go back to it."] }) end
end

-- A small typed field on a colour row (the hex, the opacity).
local function colorField(row, width, tip, tipLine, onEnter)
	local e = CreateFrame("EditBox", nil, row)
	e:SetAutoFocus(false)
	e:SetSize(width, 24)
	e:SetTextInsets(8, 6, 0, 0)
	Theme.Font(e, "number")
	W.Color(e, "text")
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true); self:HighlightText() end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false); row:Refresh() end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self)
		local text = self:GetText()
		self:ClearFocus()
		if W.Enabled(row) then onEnter(text) end
		row:Refresh()
	end)
	e.psTip, e.psTipLines = tip, { tipLine }
	e:SetScript("OnEnter", simpleTip)
	e:SetScript("OnLeave", hideTip)
	return e
end

local ALPHA_W = 52

-- The recent colours show in the source's place while the cursor is on the row.
local function recentsShown(row, on)
	row.RecentBar:SetShown(on and (#recentList() > 0 or #pinnedList() > 0 or rawget(row, "psPrev") ~= nil))
	row.Note:SetShown(not row.RecentBar:IsShown() and not row.psCompact)
end

function W.Swatch(parent, label, path, desc, opts)
	opts = opts or {}
	local row = settingRow(parent, label, desc)
	row.psShown, row.psSource, row.psLinked, row.psAlpha = opts.shown, opts.source, opts.linked, opts.alpha and true or nil
	-- Right to left: the opacity (with alpha), the hex, the chip, the source.
	local right = 12
	if row.psAlpha then
		row.Alpha = colorField(row, ALPHA_W, L["Opacity"], L["Type an opacity from 0 to 100% and press Enter."], function(text)
			local n = tonumber((tostring(text or ""):gsub(",", ".")):match("%d*%.?%d+") or "")
			if not n then return end
			local r, g, b = swatchColor(row)
			remember(row)
			swatchWrite(row, r, g, b, min(1, max(0, n / 100)))
		end)
		row.Alpha:SetPoint("RIGHT", row, "RIGHT", -right, 0)
		right = right + ALPHA_W + 8
	end
	local hex = colorField(row, HEX_W, L["Colour as hex"], L["Type a colour such as E6BA66 and press Enter."], function(text)
		local r, g, b, a = W.ParseHex(text)
		if not r then return end
		if a == nil then local _, _, _, _, ca = swatchColor(row); a = ca end
		remember(row)
		swatchWrite(row, r, g, b, a)
		W.PushRecentColor(ns.Get(row.psPath))
	end)
	hex:SetMaxLetters(9)
	hex:SetPoint("RIGHT", row, "RIGHT", -right, 0)
	row.Hex = hex
	local chip = CreateFrame("Frame", nil, row)
	chip:SetSize(34, 18)
	chip:SetPoint("RIGHT", hex, "LEFT", -8, 0)
	-- Under a colour with an opacity: a light and a dark half, so it shows.
	if row.psAlpha then
		local under = chip:CreateTexture(nil, "BORDER")
		under:SetTexture(WHITE)
		under:SetPoint("TOPLEFT", chip, "TOPLEFT", 2, -2)
		under:SetPoint("BOTTOMRIGHT", chip, "BOTTOM", 0, 2)
		under:SetVertexColor(0.85, 0.85, 0.85, 1)
		local under2 = chip:CreateTexture(nil, "BORDER")
		under2:SetTexture(WHITE)
		under2:SetPoint("TOPLEFT", chip, "TOP", 0, -2)
		under2:SetPoint("BOTTOMRIGHT", chip, "BOTTOMRIGHT", -2, 2)
		under2:SetVertexColor(0.15, 0.15, 0.15, 1)
	end
	local fillTex = chip:CreateTexture(nil, "ARTWORK")
	fillTex:SetTexture(WHITE)
	fillTex:SetPoint("TOPLEFT", chip, "TOPLEFT", 2, -2)
	fillTex:SetPoint("BOTTOMRIGHT", chip, "BOTTOMRIGHT", -2, 2)
	W.Painter(chip, chipEdge)
	row.Chip, row.ChipFrame = fillTex, chip
	local fixed = right + HEX_W + 8 + 34 + 8
	-- The recent colours, newest nearest the chip.
	local bar = CreateFrame("Frame", nil, row)
	bar:SetSize(RECENT_W + RECENT_SIZE + RECENT_GAP + 4, RECENT_SIZE)
	bar:SetPoint("RIGHT", chip, "LEFT", -8, 0)
	row.RecentBar = bar
	row.Recent = {}
	for i = 1, RECENT_N do
		local sq = CreateFrame("Button", nil, bar)
		sq:SetSize(RECENT_SIZE, RECENT_SIZE)
		sq:SetPoint("RIGHT", bar, "RIGHT", -(i - 1) * (RECENT_SIZE + RECENT_GAP), 0)
		sq.Fill = sq:CreateTexture(nil, "ARTWORK")
		sq.Fill:SetTexture(WHITE)
		sq.Fill:SetPoint("TOPLEFT", sq, "TOPLEFT", 1, -1)
		sq.Fill:SetPoint("BOTTOMRIGHT", sq, "BOTTOMRIGHT", -1, 1)
		W.Painter(sq, paintSquare)
		sq.psRow = row
		sq:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		sq:SetScript("OnClick", recentClick)
		sq:SetScript("OnEnter", recentEnter)
		sq:SetScript("OnLeave", hideTip)
		sq:Hide()
		row.Recent[i] = sq
	end
	-- The previous colour, nearest the chip, set apart by a darker hairline.
	local prev = CreateFrame("Button", nil, bar)
	prev:SetSize(RECENT_SIZE, RECENT_SIZE)
	prev:SetPoint("RIGHT", bar, "RIGHT", 0, 0)
	prev.Fill = prev:CreateTexture(nil, "ARTWORK")
	prev.Fill:SetTexture(WHITE)
	prev.Fill:SetPoint("TOPLEFT", prev, "TOPLEFT", 1, -1)
	prev.Fill:SetPoint("BOTTOMRIGHT", prev, "BOTTOMRIGHT", -1, 1)
	W.Painter(prev, function(f) local r, g, b = Theme.Color("textDim"); Theme.Border(f, r, g, b, 0.9) end)
	prev.psRow = row
	prev:SetScript("OnClick", prevClick)
	prev:SetScript("OnEnter", prevEnter)
	prev:SetScript("OnLeave", hideTip)
	prev:Hide()
	row.Prev = prev
	-- Gone once the cursor leaves the row (its squares are in it).
	bar:SetScript("OnUpdate", function()
		if not (row.IsMouseOver and row:IsMouseOver()) then recentsShown(row, false) end
	end)
	bar:Hide()
	row.Note = W.Text(row, "small", "textMuted")
	row.Note:SetPoint("RIGHT", chip, "LEFT", -8, 0)
	fitLabel(row, row.Note, function(self) return fixed + max(RECENT_W + RECENT_SIZE + RECENT_GAP + 4, math.ceil(textWidth(self.Note))) + 10 end)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if button == "RightButton" then
			remember(self)
			W.ResetSetting(self.psPath)
		else
			openPicker(self)
		end
	end)
	row:SetScript("OnEnter", function(self)
		rowEnter(self)
		if W.Enabled(self) then recentsShown(self, true) end
	end)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = swatchRefresh
	swatches[row] = true
	return W.Bind(row, path)
end

---------------------------------------------------------------------------
-- Picture cards: a choice made by its picture (a skin, an arrow style, an
-- icon pack, a line style). The row's label and description on top, the
-- cards under them across the row: each a picture over its name on the
-- control ground with a hairline, the chosen one in an accent hairline with
-- a check in its corner. choices: a list (or a function returning one) of
-- { value, text, draw = function(art, value), disabled = bool | fn, note }:
-- draw paints the picture once, into `art` (the card's picture area,
-- W.CARD_W - 2 wide, W.CARD_ART tall, clipped); note: a word after the name
-- ("Not loaded"). A click picks; right-click puts the default back. A click
-- on the row itself (a gamepad's A) steps to the next card.
-- opts.get() / opts.set(value) as a dropdown's; opts.art = { w, h } the
-- picture's size (a registered control's `art`), W.CARD_W - 2 x W.CARD_ART
-- else.
---------------------------------------------------------------------------

local CARD_W, CARD_ART, CARD_NAME, CARD_GAP = 156, 88, 30, 12
W.CARD_W, W.CARD_ART = CARD_W, CARD_ART

local function cardOff(ch)
	local d = ch and ch.disabled
	if type(d) == "function" then
		local ok, off = pcall(d)
		return ok and off and true or false
	end
	return d and true or false
end

local function paintCard(card)
	local row = card.psRow
	local on = valueOf(row) == card.psValue
	if on then
		local r, g, b = Theme.Accent()
		Theme.Border(card, r, g, b, 0.9)
	else
		Theme.Border(card, Theme.Wash("border"))
	end
	card.Check:SetShown(on)
	W.Color(card.Name, on and "text" or "textDim")
	card:SetAlpha(card.psOff and 0.45 or 1)
end

local function pickCard(row, value)
	if row.psSet then
		row.psSet(value)
		row:Refresh()
	else
		ns.Set(row.psPath, value)
	end
end

-- Right-click: the default card (through the undo-aware reset).
local function resetCards(row)
	if row.psSet then
		W.ResetSetting(nil, function() return valueOf(row) end, function(v) pickCard(row, v) end)
	else
		W.ResetSetting(row.psPath)
	end
end

local function cardClick(card, button)
	local row = card.psRow
	if not W.Enabled(row) then return end
	if button == "RightButton" then return resetCards(row) end
	if card.psOff then return end
	pickCard(row, card.psValue)
end

local function cardFor(row, ch)
	local card = row.psCardBy[ch.value]
	if card then return card end
	card = CreateFrame("Button", nil, row)
	local cw, ca = row.psCardW or CARD_W, row.psCardArt or CARD_ART
	card:SetSize(cw, ca + CARD_NAME)
	W.Fill(card, "panelAlt", "BACKGROUND", -7)
	hoverTexture(card)
	card.Art = CreateFrame("Frame", nil, card)
	card.Art:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -1)
	card.Art:SetPoint("TOPRIGHT", card, "TOPRIGHT", -1, -1)
	card.Art:SetHeight(ca)
	if card.Art.SetClipsChildren then card.Art:SetClipsChildren(true) end
	-- The name first on the line under the picture, the note (an addon's
	-- name, "Not loaded") at its right in what the name leaves (cardsBelow).
	card.Name = W.Text(card, "label", "textDim")
	card.Name:SetJustifyH("LEFT")
	card.Name:SetWordWrap(false)
	card.Name:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 10, 9)
	card.Note = W.Text(card, "small", "textMuted")
	card.Note:SetJustifyH("RIGHT")
	card.Note:SetWordWrap(false)
	card.Note:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -8, 10)
	-- The chosen card's check: an accent disc in its corner.
	local check = CreateFrame("Frame", nil, card)
	check:SetSize(18, 18)
	check:SetPoint("TOPRIGHT", card, "TOPRIGHT", -6, -6)
	check:SetFrameLevel(card.Art:GetFrameLevel() + 5)
	local disc = W.Tex(check, "ARTWORK", "circle", "accent")
	disc:SetAllPoints(check)
	local mark = W.Tex(check, "OVERLAY", "check", "onAccent")
	mark:SetSize(10, 10)
	mark:SetPoint("CENTER", check, "CENTER", 0, 0)
	card.Check = check
	card.psRow, card.psValue = row, ch.value
	card:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	card:SetScript("OnClick", cardClick)
	card:SetScript("OnEnter", simpleTip)
	card:SetScript("OnLeave", hideTip)
	W.Painter(card, paintCard)
	if type(ch.draw) == "function" then
		local ok, err = pcall(ch.draw, card.Art, ch.value)
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
	row.psCardBy[ch.value] = card
	return card
end

-- The cards under the label from y, `width` wide. -> their height
local function cardsBelow(row, width, y)
	local list = choicesOf(row)
	local inset = row.psInset or 12
	local cw, ca = row.psCardW or CARD_W, row.psCardArt or CARD_ART
	local cols = max(1, floor((width + CARD_GAP) / (cw + CARD_GAP)))
	for _, card in pairs(row.psCardBy) do card:Hide() end
	local n = #list
	-- Balanced lines: no lone card on the last one (6 at 5 a line: 3 and 3).
	if n > 0 then cols = math.ceil(n / math.ceil(n / cols)) end
	for i, ch in ipairs(list) do
		local card = cardFor(row, ch)
		card.Name:SetText(ch.text)
		local note = ch.note or ""
		card.Note:SetText(note)
		-- The name takes what it needs; the note what is left, cut short
		-- (whole in the tooltip), or none when that is too little to read.
		local room = cw - 18
		local nameW = min(room, math.ceil(textWidth(card.Name)))
		card.Name:SetWidth(max(1, nameW))
		local noteRoom = room - nameW - 8
		card.Note:SetShown(note ~= "" and noteRoom >= 24)
		card.Note:SetWidth(max(1, min(noteRoom, math.ceil(textWidth(card.Note)))))
		card.psOff = cardOff(ch)
		local lines = {}
		if ch.tip then lines[#lines + 1] = ch.tip end
		if note ~= "" then lines[#lines + 1] = note end
		card.psTip, card.psTipLines = ch.text, #lines > 0 and lines or nil
		local col, line = (i - 1) % cols, floor((i - 1) / cols)
		card:ClearAllPoints()
		card:SetPoint("TOPLEFT", row, "TOPLEFT", inset + col * (cw + CARD_GAP), -(y + line * (ca + CARD_NAME + CARD_GAP)))
		card:Show()
		paintCard(card)
	end
	local lines = n == 0 and 0 or floor((n - 1) / cols) + 1
	return lines * (ca + CARD_NAME) + max(0, lines - 1) * CARD_GAP
end

local function cardsRefresh(self)
	for _, card in pairs(self.psCardBy) do
		if card:IsShown() then paintCard(card) end
	end
	dimRow(self, W.Enabled(self))
end

function W.Cards(parent, label, path, choices, desc, opts)
	local row = settingRow(parent, label, desc)
	row.psChoices = choices
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	-- opts.art = { w, h }: bigger pictures (the skin cards' mini windows).
	if opts and type(opts.art) == "table" then row.psCardW, row.psCardArt = opts.art[1] + 2, opts.art[2] end
	row.psCardBy = {}
	row.psBelow = cardsBelow
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if button == "RightButton" then return resetCards(self) end
		-- The next card that may be picked, round to the first.
		local list, cur, at = choicesOf(self), valueOf(self), 0
		for i, ch in ipairs(list) do if ch.value == cur then at = i end end
		for k = 1, #list do
			local ch = list[(at + k - 1) % #list + 1]
			if not cardOff(ch) then return pickCard(self, ch.value) end
		end
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = cardsRefresh
	return W.Bind(row, path)
end

-- Inline extras: small controls before a row's own, each its setting's,
-- its own tooltip (title, then opts.tip(self) -> lines) and right-click reset.
local function inlineRefreshEnabled(self)
	local on = W.Enabled(self)
	self:SetAlpha(on and 1 or 0.4)
	if on then self:Enable() else self:Disable() end
end

local function inlineCommon(b, path, label, tip)
	b.psLabel, b.psInline = label, true
	b.psTipFn = tip or function() return nil end
	b.psTipAnchor = "ANCHOR_TOP"
	b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	b:SetScript("OnEnter", rowEnter)
	b:SetScript("OnLeave", hideTip)
end

-- A colour as a 20px chip: a click opens the colour picker (with the
-- opacity when opts.alpha), right-click its default. opts as W.Swatch's.
function W.InlineSwatch(parent, path, label, tip, opts)
	opts = opts or {}
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(COMPACT_CHIP, COMPACT_CHIP)
	b.psShown, b.psLinked, b.psAlpha = opts.shown, opts.linked, opts.alpha and true or nil
	b.Fill = b:CreateTexture(nil, "ARTWORK")
	b.Fill:SetTexture(WHITE)
	b.Fill:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	b.Fill:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	W.Painter(b, chipEdge)
	inlineCommon(b, path, label, tip)
	b:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if button == "RightButton" then W.ResetSetting(self.psPath) else openPicker(self) end
	end)
	b.Refresh = function(self)
		local r, g, bb, _, a = swatchColor(self)
		self.Fill:SetVertexColor(r, g, bb, self.psAlpha and a or 1)
		inlineRefreshEnabled(self)
	end
	return W.Bind(b, path)
end

-- A small switch for an on/off: a click flips it, right-click its default.
function W.InlineToggle(parent, path, label, tip)
	local b = W.Switch(parent, function() return ns.Get(path) end, function(v) ns.Set(path, v) end)
	inlineCommon(b, path, label, tip)
	b:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if button == "RightButton" then W.ResetSetting(path) else ns.Set(path, not ns.Get(path)) end
	end)
	b.psPath = path
	return W.Bind(b, path)
end

-- The cog of a row with detail settings: a 20px gear; a dot on it while one
-- of them is off its default (W.SetCogDot).
function W.Cog(parent, tip, onClick)
	local b = W.IconButton(parent, "gear", COMPACT_CHIP, tip, onClick, 13)
	b.psLabel, b.psInline = tip, true
	b.Dot = W.Tex(b, "OVERLAY", "circle", "accent")
	b.Dot:SetSize(6, 6)
	b.Dot:SetPoint("CENTER", b, "TOPRIGHT", -3, -3)
	b.Dot:Hide()
	return b
end

function W.SetCogDot(b, on)
	b.Dot:SetShown(on and true or false)
end

-- A settings section's card: the panel ground and its inner hairline, a 36px
-- header inside its top (the title in Heading at 16; card.HeaderRight: the
-- header's right side, at 16, for its widgets right to left) and a hairline
-- under it. card:SetTitle(text); card:Place(x, y, width, rowsHeight) ->
-- the card's height. The rows go from card.RowsTop under its top.
function W.SectionCard(parent)
	local card = W.RowPanel(parent)
	card.Header = CreateFrame("Frame", nil, card)
	card.Header:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
	card.Header:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
	card.Header:SetHeight(W.CARD_HEADER)
	card.Title = W.Text(card.Header, "heading", "text")
	card.Title:SetPoint("LEFT", card.Header, "LEFT", HALF_PAD, 0)
	card.Title:SetWordWrap(false)
	card.Rule = W.Divider(card)
	card.Rule:SetPoint("TOPLEFT", card, "TOPLEFT", 1, -W.CARD_HEADER)
	card.Rule:SetPoint("TOPRIGHT", card, "TOPRIGHT", -1, -W.CARD_HEADER)
	card.RowsTop = W.CARD_HEADER + 1
	function card:SetTitle(text) self.Title:SetText(text or "") end
	function card:Place(x, y, width, rowsHeight)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
		local h = self.RowsTop + rowsHeight
		self:SetSize(width, h)
		self.Title:SetWidth(max(1, width * 0.5))
		self:Show()
		return h
	end
	return card
end

-- A section's on/off in its card's header: a switch bound to `path`, its
-- label and help in the tooltip, right-click its default.
function W.HeaderSwitch(parent, path, label, tip)
	local b = W.InlineToggle(parent, path, label, tip)
	b.psHeaderSwitch = true
	return b
end

---------------------------------------------------------------------------
-- An action row: label (and description) left, a button right that acts
-- (reset a position, forget a history). opts: { icon = glyph, danger = true }.
-- The button's click is onClick(row); a row with a `disabled` function
-- (W.SetDisabledWhen) dims and stops it.
---------------------------------------------------------------------------

local function actionRowRefresh(self)
	local on = W.Enabled(self)
	dimRow(self, on)
	if on then self.Button:Enable() else self.Button:Disable() end
end

function W.ActionRow(parent, label, desc, text, onClick, opts)
	opts = opts or {}
	local row = settingRow(parent, label, desc)
	local b = W.Button(row, text, function() if W.Enabled(row) then onClick(row) end end,
		{ icon = opts.icon, danger = opts.danger })
	b:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Button = b
	fitLabel(row, b, function(self) return 12 + math.ceil(self.Button:GetWidth()) + 10 end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = actionRowRefresh
	return row
end

---------------------------------------------------------------------------
-- Action tile: icon, title and a description; for consequential actions
-- (reset all, reset positions). confirm = a second click acts. Title and
-- description wrap; W.LayoutTile sizes the tile to them.
---------------------------------------------------------------------------

local TILE_H, TILE_PAD = 60, 13

function W.ActionTile(parent, icon, title, desc, onClick, opts)
	opts = opts or {}
	local b = CreateFrame("Button", nil, parent)
	b:SetHeight(TILE_H)
	Theme.Skin(b, "tile")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetTexture(Theme.Media(icon))
	b.Icon:SetSize(18, 18)
	b.Icon:SetPoint("LEFT", b, "LEFT", 16, 0)
	W.Color(b.Icon, opts.danger and "danger" or "accent")
	b.Title = W.Text(b, "body", "text")
	b.Title:SetWordWrap(true)
	b.Title:SetPoint("TOPLEFT", b, "TOPLEFT", 48, -TILE_PAD)
	b.Title:SetPoint("TOPRIGHT", b, "TOPRIGHT", -12, -TILE_PAD)
	b.Title:SetText(title)
	b.Desc = W.Text(b, "small", "textMuted")
	b.Desc:SetWordWrap(true)
	b.Desc:SetPoint("TOPLEFT", b.Title, "BOTTOMLEFT", 0, -5)
	b.Desc:SetPoint("TOPRIGHT", b.Title, "BOTTOMRIGHT", 0, -5)
	b.Desc:SetText(desc or "")
	b.psTitle = title
	b.psSetText = function(self, text)
		self.Title:SetText(text)
		W.Color(self.Title, text == self.psTitle and "text" or "danger")
	end
	if opts.confirm then
		W.Confirm(b, title, onClick)
	else
		b:SetScript("OnClick", onClick)
	end
	return b
end

-- Size an action tile to `width`, as tall as its title and description
-- need (the title's "Click again to confirm" too), at least TILE_H. -> height
function W.LayoutTile(b, width)
	b:SetWidth(width)
	local tw = max(1, width - 48 - 12)
	b.Title:SetWidth(tw)
	b.Desc:SetWidth(tw)
	local titleH = b.Title:GetStringHeight()
	if b.psConfirmText then
		local shown = b.Title:GetText()
		b.Title:SetText(L["Click again to confirm"])
		titleH = max(titleH, b.Title:GetStringHeight())
		b.Title:SetText(shown)
	end
	local descH = (b.Desc:GetText() or "") ~= "" and (5 + b.Desc:GetStringHeight()) or 0
	local h = max(TILE_H, math.ceil(TILE_PAD + titleH + descH + TILE_PAD))
	b:SetHeight(h)
	return h
end

---------------------------------------------------------------------------
-- A callout: a small window by a part of the screen that says something once
-- (Move frames' first open, a cog's first use): an accent edge at its left,
-- a title, a line and Got it. Built once per owner and reused.
--   W.Callout(owner, { title, text, anchor, point, relPoint, x, y, width,
--     onClose = fn }) -> the callout, shown
---------------------------------------------------------------------------

local CALLOUT_W, CALLOUT_PAD = 260, 14

function W.Callout(owner, opts)
	local c = rawget(owner, "psCallout")
	if not c then
		c = CreateFrame("Frame", nil, owner)
		c:EnableMouse(true)
		c:SetClampedToScreen(true)
		c.psLight = true
		Theme.Skin(c, "window")
		c.Edge = W.Tex(c, "ARTWORK", nil, "accent")
		c.Edge:SetWidth(2)
		c.Edge:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
		c.Edge:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 1, 1)
		c.Title = W.Text(c, "label", "text")
		c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", CALLOUT_PAD + 2, -12)
		c.Title:SetJustifyH("LEFT")
		c.Text = W.Text(c, "note", "textDim")
		c.Text:SetWordWrap(true)
		c.Text:SetJustifyH("LEFT")
		c.Text:SetSpacing(2)
		c.Text:SetPoint("TOPLEFT", c.Title, "BOTTOMLEFT", 0, -6)
		c.Close = W.Button(c, L["Got it"], function()
			c:Hide()
			local done = c.psOnClose
			c.psOnClose = nil
			if done then done() end
		end, { ghost = true, height = 22 })
		c.Close.psTight = true
		W.SetButtonText(c.Close, L["Got it"])
		c.Close:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -10, 8)
		owner.psCallout = c
	end
	local w = opts.width or CALLOUT_W
	c:SetFrameLevel(owner:GetFrameLevel() + 60)
	c:SetWidth(w)
	c.Title:SetText(opts.title or "")
	c.Title:SetWidth(w - 2 * CALLOUT_PAD - 2)
	c.Text:SetWidth(w - 2 * CALLOUT_PAD - 2)
	c.Text:SetText(opts.text or "")
	c:SetHeight(math.ceil(12 + c.Title:GetStringHeight() + 6 + c.Text:GetStringHeight() + 10 + 22 + 8))
	c.psOnClose = opts.onClose
	c:ClearAllPoints()
	c:SetPoint(opts.point or "TOP", opts.anchor or owner, opts.relPoint or "BOTTOM", opts.x or 0, opts.y or -8)
	c:Show()
	ns.Anim.To(c, "alpha", 0, 1, ns.Anim.BASE, "out")
	return c
end

-- Polestar's memory in KB (nil when the client hides it), for About.
function W.AddonMemory()
	if not (UpdateAddOnMemoryUsage and GetAddOnMemoryUsage) then return nil end
	local ok = pcall(UpdateAddOnMemoryUsage)
	if not ok then return nil end
	local ok2, kb = pcall(GetAddOnMemoryUsage, "Polestar")
	if ok2 and type(kb) == "number" then return kb end
	return nil
end
