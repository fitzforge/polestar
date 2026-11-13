-- Polestar.Widgets: the widget kit the guide window, picker and options are
-- built from. Every piece paints itself from Polestar.Theme.
--
-- Setting controls (Toggle, Slider, Dropdown, Swatch) are rows, 40px high
-- at least, label left and control right; their description is the row's
-- tooltip. The settings window makes them compact halves (W.CompactRow).
-- Each is bound to a settings path: it reads Polestar.Get, writes
-- Polestar.Set, and refreshes on SETTING_CHANGED, so a change made anywhere
-- (slash command, another control, a reset) shows up everywhere.
--
-- W.Shell is the window both the options and the guide picker live in: a
-- sidebar (emblem, wordmark and tagline, search, navigation, the version and
-- its stage chip), a night-sky header
-- band with the page title, a tab row, a scrolling body over a faint emblem
-- watermark, and a footer bar.

local ADDON, ns = ...
local W = {}
ns.Widgets = W

local Theme, Anim = ns.Theme, ns.Anim
local type, pairs, ipairs, floor, max, min = type, pairs, ipairs, math.floor, math.max, math.min
local L = ns.L

local WHITE = Theme.Media("white")

W.ROW_H = 40

-- A setting row's height in the skin in use (Halo 34, Blizzard 28).
function W.RowH()
	return Theme.Metric("row", W.ROW_H)
end

---------------------------------------------------------------------------
-- Theme-following paint
---------------------------------------------------------------------------

local colored = setmetatable({}, { __mode = "k" }) -- region -> colour name
local painters = setmetatable({}, { __mode = "k" }) -- object -> fn(object)

-- Colour a font string or texture by palette name, and keep it coloured
-- through theme changes. alpha multiplies the palette alpha. A veiled
-- region (psVeiled: a texture a kit hides under its own art, a string a
-- page hides, Dungeons' header) stays at 0: in the client the colour's
-- alpha is the region's alpha (#1684, #1753).
function W.Color(region, name, alpha)
	-- A text muted with its off row (muteText) keeps textMuted; the colour
	-- asked for comes back when the row does.
	if region.psMutedFrom and name ~= "textMuted" then
		region.psMutedFrom, name = name, "textMuted"
	end
	colored[region] = name
	region.psAlpha = alpha
	local r, g, b, a = Theme.Color(name)
	a = region.psVeiled and 0 or (a or 1) * (alpha or 1)
	if region:GetObjectType() == "Texture" then
		region:SetVertexColor(r, g, b, a)
	else
		region:SetTextColor(r, g, b, a)
	end
	return region
end

-- Stop following the theme (the caller colours the region itself).
function W.Uncolor(region)
	colored[region] = nil
end

-- Put a region's palette colour (and its W.Color alpha) back on: after a
-- SetAlpha that shows a texture again, which in the client also set its
-- colour's alpha (#1684).
function W.Recolor(region)
	local name = colored[region]
	if name then W.Color(region, name, region.psAlpha) end
	return region
end

-- A texture whose strength is its colour's alpha (W.Color) keeps it when
-- something else sets its alpha: in the client a texture's SetAlpha sets
-- that same alpha, so a button bar showing our regions at full alpha turned
-- a 25 % hover into an opaque disc (#1684). The colour goes back on after
-- any SetAlpha.
function W.HoldColorAlpha(tex)
	hooksecurefunc(tex, "SetAlpha", W.Recolor)
	return tex
end

-- Run fn(obj) now and on every theme change.
function W.Painter(obj, fn)
	painters[obj] = fn
	fn(obj)
	return obj
end

Theme.OnChanged(function()
	for region, name in pairs(colored) do W.Color(region, name, region.psAlpha) end
	for obj, fn in pairs(painters) do fn(obj) end
end)

-- One line by default, cut with an ellipsis at its width: that is how a
-- single-line string stays single, not SetMaxLines(1). On a cold client start
-- Forever left max-lines strings blank until their text changed (the guide
-- window's name, tip and "Then:" lines) while no-wrap strings drew.
function W.Text(parent, role, color, layer)
	local fs = parent:CreateFontString(nil, layer or "OVERLAY")
	Theme.Font(fs, role or "body")
	W.Color(fs, color or "text")
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("MIDDLE")
	fs:SetWordWrap(false)
	return fs
end

-- A texture: a glyph or "white", tinted by palette name or left untinted.
function W.Tex(parent, layer, media, color, sub)
	local t = parent:CreateTexture(nil, layer or "ARTWORK", nil, sub)
	t:SetTexture(media and Theme.Media(media) or WHITE)
	if color then W.Color(t, color) end
	return t
end

-- A one-pixel rule in the divider wash.
function W.Divider(parent, vertical, alpha)
	local t = parent:CreateTexture(nil, "BORDER")
	t:SetTexture(WHITE)
	W.Painter(t, function(tex)
		local r, g, b, a = Theme.Wash("divider")
		tex:SetVertexColor(r, g, b, a * (alpha or 1))
		if vertical then tex:SetWidth(Theme.Pixel(parent)) else tex:SetHeight(Theme.Pixel(parent)) end
	end)
	return t
end

-- A flat fill in a palette colour.
function W.Fill(parent, color, layer, sub)
	local t = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub or -6)
	t:SetTexture(WHITE)
	t:SetAllPoints(parent)
	W.Color(t, color)
	return t
end

---------------------------------------------------------------------------
-- Tooltips (the game tooltip; EllesmereUI skins it when present)
---------------------------------------------------------------------------

-- lines: strings, or { left = , right = } pairs, or { text, r, g, b }.
function W.Tooltip(owner, anchor, title, lines)
	if not GameTooltip then return end
	GameTooltip:SetOwner(owner, anchor or "ANCHOR_RIGHT")
	GameTooltip:SetText(title or "", 1, 1, 1)
	if lines then
		for i = 1, #lines do
			local l = lines[i]
			if type(l) == "table" then
				if l.right ~= nil then
					local r, g, b = Theme.Color("textDim")
					GameTooltip:AddDoubleLine(l.left, l.right, r, g, b, 1, 1, 1)
				else
					GameTooltip:AddLine(l[1], l[2], l[3], l[4], true)
				end
			else
				local r, g, b = Theme.Color("textDim")
				GameTooltip:AddLine(l, r, g, b, true)
			end
		end
	end
	GameTooltip:Show()
end

function W.HideTooltip(owner)
	if GameTooltip and (not owner or GameTooltip:GetOwner() == owner) then GameTooltip:Hide() end
end

---------------------------------------------------------------------------
-- W.Tip: the settings window's own tooltip (DESIGN.md "Tooltip"): one
-- shared frame on the panel ground at 92% with a hairline at 15%, padded 8,
-- at most 250 wide; the title in Label, the lines in Small at 80% (a line
-- given as { text, r, g, b } keeps its colour), 3 apart. Centred 4 over the
-- anchor (the row's label), under it where the screen ends; no delay, a
-- 0.2s fade in and out. Its owner's scale is its own (the Menu scale).
---------------------------------------------------------------------------

local TIP_PAD, TIP_MAX, TIP_GAP, TIP_LINE, TIP_FADE = 8, 250, 4, 3, 0.2
local tip

local function tipFrame()
	if tip then return tip end
	tip = CreateFrame("Frame", "PolestarTip", ns.UIParent)
	tip:SetFrameStrata("TOOLTIP")
	tip:SetClampedToScreen(true)
	tip:EnableMouse(false)
	tip:Hide()
	tip.Ground = tip:CreateTexture(nil, "BACKGROUND")
	tip.Ground:SetTexture(WHITE)
	tip.Ground:SetAllPoints(tip)
	W.Painter(tip.Ground, function(t)
		local r, g, b = Theme.Color("panel")
		t:SetVertexColor(r, g, b, 0.92)
	end)
	W.Painter(tip, function(f)
		local r, g, b = Theme.Color("text")
		Theme.Border(f, r, g, b, 0.15)
	end)
	tip.Title = W.Text(tip, "label", "text")
	tip.Title:SetJustifyH("LEFT")
	tip.Lines = {}
	return tip
end

local function tipLine(i)
	local fs = tip.Lines[i]
	if fs then return fs end
	fs = W.Text(tip, "small", "text")
	fs:SetJustifyH("LEFT")
	fs:SetWordWrap(true)
	fs:SetSpacing(TIP_LINE)
	tip.Lines[i] = fs
	return fs
end

-- Show `title` over `lines` for `owner`, centred over `anchor` (owner).
function W.Tip(owner, title, lines, anchor)
	local f = tipFrame()
	anchor = anchor or owner
	f.psOwner = owner
	f:SetScale(max(0.01, owner:GetEffectiveScale() / UIParent:GetEffectiveScale()))
	local room = TIP_MAX - 2 * TIP_PAD
	local w, y = 0, TIP_PAD
	local t = f.Title
	t:SetText(title or "")
	t:SetShown((title or "") ~= "")
	if t:IsShown() then
		t:SetWidth(room)
		local tw = min(room, t:GetUnboundedStringWidth())
		t:SetWidth(max(1, tw))
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", f, "TOPLEFT", TIP_PAD, -y)
		w = max(w, tw)
		y = y + t:GetStringHeight() + TIP_LINE
	end
	local n = 0
	for _, l in ipairs(lines or {}) do
		local text, r, g, b, a = l, nil, nil, nil, nil
		if type(l) == "table" then
			if l.right ~= nil then text = l.left .. "  " .. l.right else text, r, g, b, a = l[1], l[2], l[3], l[4], l[5] end
		end
		if text and text ~= "" then
			n = n + 1
			local fs = tipLine(n)
			fs:SetText(text)
			if r then
				W.Uncolor(fs)
				fs:SetTextColor(r, g, b, a or 1)
			else
				W.Color(fs, "text", 0.8)
			end
			fs:SetWidth(room)
			local lw = min(room, fs:GetUnboundedStringWidth())
			fs:SetWidth(max(1, lw))
			fs:ClearAllPoints()
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", TIP_PAD, -y)
			fs:Show()
			w = max(w, lw)
			y = y + fs:GetStringHeight() + TIP_LINE
		end
	end
	for i = n + 1, #f.Lines do f.Lines[i]:Hide() end
	local h = y - TIP_LINE + TIP_PAD
	f:SetSize(math.ceil(w + 2 * TIP_PAD), math.ceil(h))
	-- Over the anchor, under it where the screen's top would cut it.
	f:ClearAllPoints()
	local top = anchor:GetTop()
	local s = f:GetScale()
	local screenTop = UIParent:GetTop() or UIParent:GetHeight()
	if top and (top * anchor:GetEffectiveScale() / UIParent:GetEffectiveScale()) + (h + TIP_GAP) * s > screenTop then
		f:SetPoint("TOP", anchor, "BOTTOM", 0, -TIP_GAP)
	else
		f:SetPoint("BOTTOM", anchor, "TOP", 0, TIP_GAP)
	end
	if not f:IsShown() then f:SetAlpha(0) end
	f:Show()
	Anim.To(f, "alpha", f:GetAlpha() or 0, 1, TIP_FADE, "out")
	return f
end

-- Fade the tip out (only `owner`'s, when given).
function W.TipHide(owner)
	if not (tip and tip:IsShown()) then return end
	if owner and tip.psOwner ~= owner then return end
	tip.psOwner = nil
	Anim.To(tip, "alpha", tip:GetAlpha() or 1, 0, TIP_FADE, "out", function()
		if not tip.psOwner then tip:Hide() end
	end)
end

-- The tip on screen, for tests: { owner, title, lines = { text, ... } } | nil
function W.TipShown()
	if not (tip and tip:IsShown() and tip.psOwner) then return nil end
	local out = { owner = tip.psOwner, title = tip.Title:IsShown() and tip.Title:GetText() or nil, lines = {} }
	for _, fs in ipairs(tip.Lines) do if fs:IsShown() then out.lines[#out.lines + 1] = fs:GetText() end end
	return out
end

local function simpleTip(self)
	if self.psTip then W.Tooltip(self, self.psTipAnchor or "ANCHOR_TOP", self.psTip, self.psTipLines) end
end
local function hideTip(self) self.psHover = nil; W.HideTooltip(self); W.TipHide(self) end
W.SimpleTip, W.HideTip = simpleTip, hideTip

-- The game's own item and spell tooltips on Polestar's buttons (reward
-- tiles, loot tiles, gear picks, rare drops), and their modified clicks.
--   W.ItemTip(owner, itemID, extra?, place?)   -- extra(tooltip): lines after the game's
--   W.SpellTip(owner, spellID, extra?, place?) -- place(tooltip): anchors it (default: right of owner)
--   W.ItemClick(itemID) -> handled     -- Shift links, Ctrl tries on, Alt guides
--   W.SpellClick(spellID) -> handled   -- Shift links
--   W.PrefetchItem(itemID), W.PrefetchSpell(spellID)
-- An item or spell the client has not cached yet shows "Retrieving item
-- information" and the client's own refresh does not reliably redraw it, so
-- the tooltip is set again when GET_ITEM_INFO_RECEIVED / SPELL_DATA_LOAD_RESULT
-- brings that ID while the same button still owns it.
local gameTip -- { owner, kind, id, extra, place } of the tooltip last set here

local function setGameTip(owner, kind, id, extra, place)
	local tip = GameTooltip
	if not (tip and owner and type(id) == "number") then return end
	local C = ns.Compat
	if kind == "item" then
		if C.RequestItem then C.RequestItem(id) end
	elseif not tip.SetSpellByID then
		return
	elseif C.RequestSpell then
		C.RequestSpell(id)
	end
	tip:SetOwner(owner, place and "ANCHOR_NONE" or "ANCHOR_RIGHT")
	if place then
		tip:ClearAllPoints()
		place(tip)
	end
	if kind == "item" then tip:SetHyperlink("item:" .. id) else tip:SetSpellByID(id) end
	if extra then extra(tip) end
	tip:Show()
	gameTip = { owner = owner, kind = kind, id = id, extra = extra, place = place }
end

function W.ItemTip(owner, itemID, extra, place) setGameTip(owner, "item", itemID, extra, place) end
function W.SpellTip(owner, spellID, extra, place) setGameTip(owner, "spell", spellID, extra, place) end

local function owns(owner)
	local tip = GameTooltip
	if not tip then return false end
	if tip.IsOwned then return tip:IsOwned(owner) and true or false end
	return tip.GetOwner and tip:GetOwner() == owner or false
end

local function arrived(kind, id)
	local g = gameTip
	if not (g and g.kind == kind and (id == nil or id == g.id)) then return end
	if GameTooltip and GameTooltip.IsShown and not GameTooltip:IsShown() then gameTip = nil return end
	if not owns(g.owner) then gameTip = nil return end
	setGameTip(g.owner, kind, g.id, g.extra, g.place)
end

if ns.RegisterEvent then
	ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function(_, itemID) arrived("item", itemID) end)
	ns.RegisterEvent("SPELL_DATA_LOAD_RESULT", function(_, spellID) arrived("spell", spellID) end)
end

function W.PrefetchItem(itemID) if ns.Compat.RequestItem then ns.Compat.RequestItem(itemID) end end
function W.PrefetchSpell(spellID) if ns.Compat.RequestSpell then ns.Compat.RequestSpell(spellID) end end

-- A modified click on an item button, as on a bag item: the client's
-- HandleModifiedItemClick (Shift: chat link, Ctrl: dressing room), whose
-- post-hook (Core/Hooks.lua) runs Polestar's Alt-click guide. An item not
-- cached yet has no link: it is requested, and the Alt-click still guides.
function W.ItemClick(itemID)
	if type(itemID) ~= "number" or not (IsModifiedClick and IsModifiedClick()) then return false end
	local C = ns.Compat
	local link = C.ItemLink and C.ItemLink(itemID)
	if link and HandleModifiedItemClick then
		HandleModifiedItemClick(link)
	else
		if C.RequestItem then C.RequestItem(itemID) end
		if ns.Hooks and ns.Hooks.OnItemClick then ns.Hooks.OnItemClick("item:" .. itemID) end
	end
	return true
end

-- Shift-click on a spell button links the spell in chat.
function W.SpellClick(spellID)
	if type(spellID) ~= "number" or not (IsModifiedClick and IsModifiedClick("CHATLINK")) then return false end
	local link = ns.Compat.SpellLink and ns.Compat.SpellLink(spellID)
	local insert = (ChatFrameUtil and ChatFrameUtil.InsertLink) or ChatEdit_InsertLink
	if link and insert then insert(link) end
	return true
end

---------------------------------------------------------------------------
-- Buttons
---------------------------------------------------------------------------

local function hoverTexture(frame, alphaScale)
	local hl = frame:CreateTexture(nil, "HIGHLIGHT")
	hl:SetTexture(WHITE)
	hl:SetAllPoints(frame)
	W.Painter(hl, function(t)
		local r, g, b, a = Theme.Wash("hover")
		t:SetVertexColor(r, g, b, a * (alphaScale or 1))
	end)
	return hl
end
W.Hover = hoverTexture

-- A glyph-only button: the glyph sits in the dim text colour and brightens
-- under the cursor; a press nudges it down a pixel, like a key going in.
-- Hearth frames the buttons that ask for it (b.psFramed) as small planks:
-- "icon" the control ground #3B2616 shading to #2A1A0F with a dark copper
-- edge, "red" (the step buttons, ‹ ›) the same plank lit by the fire, #5A3016
-- to #3B2616, edged in copper. Hidden in the other skins (the game's looks
-- draw their own plates).
local FRAMES = {
	icon = { top = { 0.231, 0.149, 0.086 }, bottom = { 0.165, 0.102, 0.059 }, edge = { 0.353, 0.212, 0.094 } },
	red = { top = { 0.353, 0.188, 0.086 }, bottom = { 0.231, 0.149, 0.086 }, edge = { 0.69, 0.478, 0.235 } },
}
local function iconFrame(b)
	-- The game's looks draw their own plates, page arrows and close button.
	Theme.KitIconButton(b)
	local spec = FRAMES[rawget(b, "psFramed") or ""]
	local bliz = Theme.SkinKey() == "hearth" and spec ~= nil
	local f = rawget(b, "psFrame")
	if not f and bliz then
		f = b:CreateTexture(nil, "BACKGROUND", nil, -6)
		f:SetTexture(WHITE)
		f:SetAllPoints(b)
		b.psFrame = f
	end
	if not f then return end
	f:SetShown(bliz)
	if bliz then
		local t, bo, e = spec.top, spec.bottom, spec.edge
		if f.SetGradient and CreateColor then
			f:SetGradient("VERTICAL", CreateColor(bo[1], bo[2], bo[3], 1), CreateColor(t[1], t[2], t[3], 1))
		else
			f:SetVertexColor(t[1], t[2], t[3], 1)
		end
		Theme.Border(b, e[1], e[2], e[3], 1)
	elseif b.psBorder then
		for i = 1, 4 do b.psBorder[i]:Hide() end
	end
end

function W.IconButton(parent, icon, size, tip, onClick, glyphSize)
	local b = CreateFrame("Button", nil, parent)
	size = size or 22
	b:SetSize(size, size)
	hoverTexture(b)
	local g = b:CreateTexture(nil, "ARTWORK")
	b.psIconName = icon
	g:SetTexture(Theme.Media(Theme.Icon(icon)))
	local gs = glyphSize or floor(size * 0.6 + 0.5)
	g:SetSize(gs, gs)
	g:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Icon = g
	W.Color(g, "icon")
	b.psTip = tip
	W.Painter(b, function(self)
		self.Icon:SetTexture(Theme.Media(Theme.Icon(self.psIconName)))
		iconFrame(self)
	end)
	b:SetScript("OnEnter", function(self)
		if self:IsEnabled() then W.Color(self.Icon, self.psActive and "accent" or "iconHover") end
		simpleTip(self)
		if self.psOnEnter then self.psOnEnter(self) end
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Icon, self.psActive and "accent" or "icon", self:IsEnabled() and 1 or 0.35)
		hideTip(self)
		if self.psOnLeave then self.psOnLeave(self) end
	end)
	b:SetScript("OnMouseDown", function(self) if self:IsEnabled() then self.Icon:SetPoint("CENTER", self, "CENTER", 0, -1) end end)
	b:SetScript("OnMouseUp", function(self) self.Icon:SetPoint("CENTER", self, "CENTER", 0, 0) end)
	if onClick then b:SetScript("OnClick", onClick) end
	return b
end

function W.SetIcon(b, icon)
	b.psIconName = icon
	b.Icon:SetTexture(Theme.Media(Theme.Icon(icon)))
end

-- Ask for Blizzard's framed square on an icon button ("icon" or "red").
function W.SetFramed(b, kind)
	b.psFramed = kind
	iconFrame(b)
end

-- Mark an icon button as "on" (accent glyph) or dim it when disabled.
function W.SetIconState(b, active, enabled)
	b.psActive = active and true or false
	if enabled == false then b:Disable() else b:Enable() end
	W.Color(b.Icon, b.psActive and "accent" or "icon", b:IsEnabled() and 1 or 0.35)
end

-- A text button. opts: { primary = true, ghost = true, danger = true,
-- width = n, icon = name, height = n }.
function W.Button(parent, text, onClick, opts)
	opts = opts or {}
	local b = CreateFrame("Button", nil, parent)
	b.psHeight = opts.height
	b:SetHeight(opts.height or Theme.Metric("buttonH", 28))
	local label = W.Text(b, "label", opts.danger and "danger" or "buttonText")
	label:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Label = label
	if opts.icon then
		local g = b:CreateTexture(nil, "ARTWORK")
		g:SetTexture(Theme.Media(opts.icon))
		g:SetSize(13, 13)
		b.Icon = g
	end
	b.psPrimary, b.psGhost, b.psDanger = opts.primary, opts.ghost, opts.danger
	b.psFixedWidth = opts.width
	if opts.ghost then
		hoverTexture(b)
	else
		b.psTextButton = true
		Theme.Skin(b, "button")
	end
	W.Painter(b, function(self)
		local icon = rawget(self, "Icon")
		if not self.psHeight then self:SetHeight(Theme.Metric("buttonH", 28)) end
		-- Hearth's primary buttons, and every text button in the game's looks.
		local bliz = Theme.GameSkin() and (self.psPrimary or Theme.Kit() ~= nil)
		if bliz and not self.psGhost then
			-- The game's red button, as the others: an edge of its own would read
			-- as the gamepad's selection.
			W.Color(self.Label, "buttonText")
			if self.psBorder then for i = 1, 4 do self.psBorder[i]:Hide() end end
			if icon then icon:SetVertexColor(Theme.Color("buttonText")) end
			Theme.SetShadow(self.Label, true)
			if rawget(self, "psTopHi") then self.psTopHi:Hide() end
			return
		end
		local d = self.psSkin
		local hi = rawget(self, "psTopHi")
		if self.psPrimary then
			local r, g, bb = Theme.Accent()
			if d and d.bg then d.bg:SetVertexColor(r, g, bb, 1) end
			if self.psBorder then for i = 1, 4 do self.psBorder[i]:SetVertexColor(r, g, bb, 1) end end
			W.Uncolor(self.Label)
			self.Label:SetTextColor(Theme.Color("onAccent"))
			if icon then icon:SetVertexColor(Theme.Color("onAccent")) end
			-- The house primary: one lit line inside its top edge.
			if Theme.SkinKey() == "polestar" and not self.psGhost then
				if not hi then
					hi = self:CreateTexture(nil, "ARTWORK", nil, 7)
					hi:SetTexture(WHITE)
					hi:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
					hi:SetPoint("TOPRIGHT", self, "TOPRIGHT", -1, -1)
					self.psTopHi = hi
				end
				hi:SetHeight(Theme.Pixel(self))
				hi:SetVertexColor(1, 1, 1, 0.55)
				hi:Show()
			elseif hi then
				hi:Hide()
			end
		else
			if hi then hi:Hide() end
			-- The house danger button: red text over a red hairline and the
			-- faintest red ground.
			if self.psDanger and not self.psGhost and Theme.SkinKey() == "polestar" then
				local r, g, bb = Theme.Color("danger")
				if d and d.bg then d.bg:SetVertexColor(r, g, bb, 0.07) end
				if self.psBorder then for i = 1, 4 do self.psBorder[i]:SetVertexColor(r, g, bb, 0.45) end end
			end
			if icon then icon:SetVertexColor(Theme.Color(self.psDanger and "danger" or "textDim")) end
		end
		Theme.SetShadow(self.Label, not self.psPrimary)
	end)
	b:SetScript("OnMouseDown", function(self) if self:IsEnabled() then self.Label:SetPoint("CENTER", self, "CENTER", self.psLabelX or 0, -1) end end)
	b:SetScript("OnMouseUp", function(self) self.Label:SetPoint("CENTER", self, "CENTER", self.psLabelX or 0, 0) end)
	b:SetScript("OnEnter", simpleTip)
	b:SetScript("OnLeave", hideTip)
	if onClick then b:SetScript("OnClick", onClick) end
	W.SetButtonText(b, text)
	return b
end

function W.SetButtonText(b, text)
	b.Label:SetText(text or "")
	local w = b.Label:GetStringWidth()
	local icon = rawget(b, "Icon")
	local iconW = icon and 19 or 0
	if icon then
		b.psLabelX = iconW / 2
		b.Icon:ClearAllPoints()
		b.Icon:SetPoint("RIGHT", b.Label, "LEFT", -6, 0)
	end
	b.Label:SetPoint("CENTER", b, "CENTER", b.psLabelX or 0, 0)
	-- A tight button (the footer's ghosts): 8px either side, no minimum.
	local pad = b.psTight and 8 or Theme.Metric("buttonPad", 16)
	b:SetWidth(b.psFixedWidth or max(b.psTight and 0 or 72, floor(w + iconW + 2 * pad + 0.5)))
end

-- A link: an address shown as text in the accent, no box. Under the cursor
-- it turns to the text colour over a 1px accent underline, with "Click to
-- copy" as its tooltip; the click (onClick) opens the copy window holding
-- it. opts: { role = "label" (default) | "note" | any type role }.
function W.Link(parent, text, onClick, opts)
	local b = CreateFrame("Button", nil, parent)
	b.Label = W.Text(b, opts and opts.role or "label", "accent")
	b.Label:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Line = b:CreateTexture(nil, "ARTWORK")
	b.Line:SetTexture(WHITE)
	b.Line:SetPoint("TOPLEFT", b.Label, "BOTTOMLEFT", 0, -2)
	b.Line:SetPoint("TOPRIGHT", b.Label, "BOTTOMRIGHT", 0, -2)
	W.Painter(b.Line, function(t)
		t:SetHeight(Theme.Pixel(b))
		t:SetVertexColor(Theme.Accent())
	end)
	b.Line:Hide()
	b.psTip = L["Click to copy"]
	b:SetScript("OnEnter", function(self)
		W.Color(self.Label, "text")
		self.Line:Show()
		simpleTip(self)
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Label, "accent")
		self.Line:Hide()
		hideTip(self)
	end)
	if onClick then b:SetScript("OnClick", onClick) end
	W.SetLinkText(b, text)
	return b
end

-- A link's text; the hit area hugs it, 20px tall.
function W.SetLinkText(b, text)
	b.Label:SetText(text or "")
	b:SetSize(floor(b.Label:GetStringWidth() + 0.5), 20)
end

-- Buttons that act only on a second click within three seconds.
function W.Confirm(b, text, fn)
	b.psConfirmText, b.psConfirmFn = text, fn
	b:SetScript("OnClick", function(self)
		local now = GetTime()
		if self.psArmed and now - self.psArmed < 3 then
			self.psArmed = nil
			if self.psSetText then self.psSetText(self, self.psConfirmText) end
			self.psConfirmFn()
			return
		end
		self.psArmed = now
		if self.psSetText then self.psSetText(self, L["Click again to confirm"]) end
		ns.After(3, function()
			if self.psArmed and GetTime() - self.psArmed >= 2.9 then
				self.psArmed = nil
				if self.psSetText then self.psSetText(self, self.psConfirmText) end
			end
		end)
	end)
	return b
end

-- A real CheckButton (manual goals).
function W.Checkbox(parent, onClick)
	local c = CreateFrame("CheckButton", nil, parent)
	c:SetSize(18, 18)
	Theme.Skin(c, "checkbox")
	if onClick then c:SetScript("OnClick", onClick) end
	return c
end

---------------------------------------------------------------------------
-- Pills and chips
---------------------------------------------------------------------------

-- A horizontal capsule (two half circles and a middle).
local function pill(parent, w, h)
	local f = CreateFrame("Frame", nil, parent)
	f:SetSize(w, h)
	local l = f:CreateTexture(nil, "ARTWORK")
	l:SetTexture(Theme.Media("circle"))
	l:SetTexCoord(0, 0.5, 0, 1)
	l:SetSize(h / 2, h)
	l:SetPoint("LEFT", f, "LEFT", 0, 0)
	local r = f:CreateTexture(nil, "ARTWORK")
	r:SetTexture(Theme.Media("circle"))
	r:SetTexCoord(0.5, 1, 0, 1)
	r:SetSize(h / 2, h)
	r:SetPoint("RIGHT", f, "RIGHT", 0, 0)
	local m = f:CreateTexture(nil, "ARTWORK")
	m:SetTexture(WHITE)
	m:SetPoint("TOPLEFT", l, "TOPRIGHT", 0, 0)
	m:SetPoint("BOTTOMRIGHT", r, "BOTTOMLEFT", 0, 0)
	f.parts = { l, m, r }
	function f.SetColor(self, cr, cg, cb, ca)
		for i = 1, 3 do self.parts[i]:SetVertexColor(cr, cg, cb, ca) end
	end
	return f
end
W.Pill = pill

-- A small labelled capsule: level ranges, races, states. kind: "neutral" |
-- "accent" | "success" | "warning" (the release stage) | "dungeon" (group
-- content).
W.CHIP_H = 20
function W.Chip(parent)
	local c = CreateFrame("Frame", nil, parent)
	c:SetHeight(W.CHIP_H)
	c.Bg = pill(c, 40, W.CHIP_H)
	c.Bg:SetAllPoints(c)
	c.Text = W.Text(c, "caption", "textDim")
	c.Text:SetPoint("CENTER", c, "CENTER", 0, 0)
	return c
end

function W.SetChip(c, text, kind)
	c.Text:SetText(text)
	local w = floor(c.Text:GetStringWidth() + 18 + 0.5)
	c:SetWidth(w)
	c.Bg:SetSize(w, W.CHIP_H)
	if kind == "accent" then
		local r, g, b = Theme.Accent()
		c.Bg:SetColor(r, g, b, 0.16)
		W.Color(c.Text, "accent")
	elseif kind == "success" or kind == "warning" or kind == "dungeon" then
		local r, g, b = Theme.Color(kind)
		c.Bg:SetColor(r, g, b, 0.14)
		W.Color(c.Text, kind)
	else
		c.Bg:SetColor(Theme.Wash("chip"))
		W.Color(c.Text, "textDim")
	end
	c:Show()
	return w
end

-- A slim progress line: a hairline track and an accent fill.
function W.ProgressLine(parent, height)
	local f = CreateFrame("Frame", nil, parent)
	f:SetHeight(height or 2)
	f.Track = f:CreateTexture(nil, "BACKGROUND")
	f.Track:SetTexture(WHITE)
	f.Track:SetAllPoints(f)
	W.Painter(f.Track, function(t) t:SetVertexColor(Theme.Wash("progress")) end)
	f.Fill = f:CreateTexture(nil, "ARTWORK")
	f.Fill:SetTexture(WHITE)
	f.Fill:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.Fill:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
	f.Fill:SetWidth(0.01)
	W.Color(f.Fill, "accent")
	f.psFrac = 0
	return f
end

-- Set a progress line's fraction; animate eases from the old value.
function W.SetProgress(f, frac, width, animate)
	if frac < 0 then frac = 0 elseif frac > 1 then frac = 1 end
	local w = max(0.01, (width or f:GetWidth()) * frac)
	if animate and f.psFrac ~= frac and f.Fill:GetWidth() > 0 then
		Anim.To(f.Fill, "width", f.Fill:GetWidth(), w, Anim.SLOW, "out")
	elseif not Anim.IsRunning(f.Fill, "width") then
		f.Fill:SetWidth(w)
	end
	f.Fill:SetShown(frac > 0)
	f.psFrac = frac
end

---------------------------------------------------------------------------
-- Setting bindings
---------------------------------------------------------------------------

local bound = {} -- path -> { control, ... }
local dependents = {} -- path -> { control, ... }

local function track(map, path, control)
	local list = map[path]
	if not list then
		list = {}
		map[path] = list
	end
	list[#list + 1] = control
end

-- control.Refresh(control) paints it from the current value.
function W.Bind(control, path, depends)
	control.psPath = path
	control.psDepends = depends
	if path then track(bound, path, control) end
	if depends then track(dependents, depends, control) end
	control:Refresh()
	return control
end

-- Controls with a `disabled` function, re-evaluated on every setting change.
local conditional = setmetatable({}, { __mode = "k" })

function W.SetDisabledWhen(control, fn)
	control.psDisabledFn = fn
	conditional[control] = fn and true or nil
	if control.Refresh then control:Refresh() end
end

function W.Enabled(control)
	local fn = control.psDisabledFn
	if fn then
		local ok, off = pcall(fn)
		if ok and off then return false end
	end
	if not control.psDepends then return true end
	return ns.Get(control.psDepends) and true or false
end

local function refreshList(list)
	if not list then return end
	for i = 1, #list do list[i]:Refresh() end
end

function W.RefreshAll()
	for _, list in pairs(bound) do refreshList(list) end
end

ns.On("SETTING_CHANGED", function(path)
	path = path or ""
	if path == "" or not path:find(".", 1, true) then
		-- A section (or everything) was reset.
		for p, list in pairs(bound) do
			if path == "" or p:sub(1, #path + 1) == path .. "." then refreshList(list) end
		end
		for p, list in pairs(dependents) do
			if path == "" or p:sub(1, #path + 1) == path .. "." then refreshList(list) end
		end
		return
	end
	refreshList(bound[path])
	refreshList(dependents[path])
	for control in pairs(conditional) do control:Refresh() end
end)

Theme.OnChanged(W.RefreshAll)

-- fn() after the font changes (ui.font, EllesmereUI's font): text that
-- sized its row, column or control measures differently, so a window shown
-- lays itself out again. Colour and look changes do not call it.
local fontHandlers, fontKey = {}, nil
local function currentFont()
	local path, _, flags = Theme.FontSpec("body")
	return tostring(path) .. "|" .. tostring(flags)
end
function W.OnFontChanged(fn)
	fontHandlers[#fontHandlers + 1] = fn
end
Theme.OnChanged(function()
	local key = currentFont()
	if key == fontKey then return end
	fontKey = key
	for _, fn in ipairs(fontHandlers) do fn() end
end)

-- A grid row: label left, bound by the control and wrapping onto more lines
-- rather than cut, a faint hairline underneath, the description as the
-- row's tooltip. W.LayoutRow sizes it.
local function settingRow(parent, label, desc)
	local row = CreateFrame("Button", nil, parent)
	row:SetHeight(W.RowH())
	hoverTexture(row, 0.6)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	-- A setting's label: the text colour, gold in the game's looks (the
	-- Settings panel's GameFontNormal).
	row.Label = W.Text(row, "body", "rowLabel")
	row.Label:SetWordWrap(true)
	row.Label:SetText(label)
	row.Label:SetPoint("LEFT", row, "LEFT", 12, 0)
	row.psLabel, row.psDesc = label, desc
	row.psTip = label
	row.psTipLines = desc and { desc } or nil
	row.psTipAnchor = "ANCHOR_TOPLEFT"
	return row
end

-- Bound the label on the left of a row's control. span(row, width) -> the
-- width the control takes from the row's right edge, its 12px inset and the
-- 10px gap before the label included; it may size the control to fit.
local function fitLabel(row, control, span)
	row.Label:SetPoint("RIGHT", control, "LEFT", -10, 0)
	row.psSpan = span
end

-- A font string's text width, unbound by its anchors or width (with `text`
-- set first when given).
local function textWidth(fs, text)
	if text then fs:SetText(text) end
	if fs.GetUnboundedStringWidth then return fs:GetUnboundedStringWidth() end
	return fs:GetStringWidth()
end
W.TextWidth = textWidth

-- Size a settings row (toggle, slider, dropdown, swatch, info) to `width`:
-- its control takes what its text needs, the label the rest, on as many
-- lines as it needs; the row grows past ROW_H when they do not fit in it.
-- A compact half (W.CompactRow: the settings window) lays out its own way
-- (W.LayoutCompact). -> the row's height
function W.LayoutRow(row, width)
	if row.psCompact then return W.LayoutCompact(row, width) end
	row:SetWidth(width)
	local span = row.psSpan and row.psSpan(row, width) or 22
	row.Label:SetWidth(max(1, width - 12 - span))
	local h = max(W.ROW_H, math.ceil(row.Label:GetStringHeight()) + 16)
	row.psLaidH = h
	row:SetHeight(h)
	return h
end

-- Deep equality, numbers within rounding.
local function sameValue(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do if not sameValue(v, b[k]) then return false end end
		for k in pairs(b) do if a[k] == nil then return false end end
		return true
	end
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-6 end
	return a == b
end

-- Whether a setting holds something other than its default.
function W.Modified(path)
	if not (path and ns.GetDefault) then return false end
	local d = ns.GetDefault(path)
	if d == nil then return false end
	return not sameValue(ns.Get(path), d)
end

-- A row's right-click: its setting back to its default, or state that is no
-- setting through set(nil) (get() reads it). The listener W.OnReset installs
-- (the settings window's Undo) hears what it held, as { { path, value } }
-- (value as stored: nil is the default) or { { get, set, value } }; nothing
-- when it was at its default already.
local onReset
function W.OnReset(fn) onReset = fn end

function W.ResetSetting(path, get, set)
	if set then
		local was = get and get()
		set(nil)
		if onReset and get and not sameValue(get(), was) then onReset({ { get = get, set = set, value = was } }) end
		return
	end
	local was = ns.GetStored and ns.GetStored(path)
	ns.Set(path, nil)
	if onReset and was ~= nil then onReset({ { path = path, value = was } }) end
end

local function markRow(row)
	if not row.psCompact then return end
	-- A compact half: the label in text and the gold dot while off its
	-- default (the label's gutter is the changed dot's alone; newness is the
	-- section's New pill and the sidebar's count).
	local mod = W.Modified(row.psPath)
	row.psModified = mod
	W.Color(row.Label, row.psOff and "textMuted" or mod and "text" or "textDim")
	row.ModDot:SetShown(mod)
end

-- A text in textMuted while its row is off, its own colour back after.
local function muteText(region, off)
	if not region then return end
	if off then
		if not region.psMutedFrom then
			local from = colored[region] or "text"
			W.Color(region, "textMuted")
			region.psMutedFrom = from
		end
	elseif region.psMutedFrom then
		local from = region.psMutedFrom
		region.psMutedFrom = nil
		W.Color(region, from)
	end
end

-- An off compact half: its marks (track, slider, chip, box) at 40%, its
-- texts (label, value, hex) in textMuted at full alpha, legible (4.5:1).
local function dimCompact(row, enabled)
	row:SetAlpha(1)
	row.psOff = not enabled or nil
	local dropdown = row.psChoices ~= nil and not rawget(row, "psCardBy") and rawget(row, "Button") or nil
	local keep = {}
	for _, k in ipairs({ "ValueHit", "Hex", "Alpha" }) do
		local f = rawget(row, k)
		if f then keep[f] = true end
	end
	if dropdown then keep[dropdown] = true end
	for _, child in ipairs({ row:GetChildren() }) do
		if not keep[child] and not rawget(child, "psInline") then child:SetAlpha(enabled and 1 or 0.4) end
	end
	muteText(rawget(row, "Value"), not enabled)
	muteText(dropdown and dropdown.Label, not enabled)
	muteText(rawget(row, "Hex"), not enabled)
	muteText(rawget(row, "Alpha"), not enabled)
end

local function dimRow(row, enabled)
	if row.psCompact then
		dimCompact(row, enabled)
	else
		row:SetAlpha(enabled and 1 or 0.45)
	end
	if enabled then row:Enable() else row:Disable() end
	markRow(row)
end

-- A row's height as its refresh keeps it: a compact half's own, else the
-- skin's row.
local function keptHeight(self)
	if self.psCompact then return self.psLaidH or self.psCompactH or 36 end
	return max(W.RowH(), self.psLaidH or 0)
end

-- A row's tooltip: at once, or for a compact half (psTipFn) 0.25s after the
-- cursor arrives (W.ShowRowTip), unless it has left by then.
local TIP_DELAY = 0.25
local function rowEnter(self)
	if self.psTipFn then
		self.psHover = true
		local token = {}
		self.psTipToken = token
		C_Timer.After(TIP_DELAY, function()
			if self.psHover and self.psTipToken == token then W.ShowRowTip(self) end
		end)
		return
	end
	simpleTip(self)
end
W.RowEnter = rowEnter

---------------------------------------------------------------------------
-- Toggle: a pill switch. The knob slides (120 ms, ease-out); with reduced
-- motion it simply lands.
---------------------------------------------------------------------------

local TOGGLE_W, TOGGLE_H, KNOB = 30, 16, 12

local function toggleValue(self)
	if self.psGet then return self.psGet() and true or false end
	return ns.Get(self.psPath) and true or false
end

-- The game's looks' check box in place of the switch (their kit's art,
-- Theme.KitCheck): true when one was drawn.
local function gameCheck(self, on)
	local game, kit = Theme.GameSkin(), Theme.Kit()
	for i = 1, #self.Track.parts do self.Track.parts[i]:SetShown(not game) end
	self.Knob:SetShown(not game)
	if kit then
		Theme.KitCheck(self, self.Track:GetParent(), self.Track, on)
	else
		Theme.KitHide(self, "toggle")
		Theme.KitHide(self, "toggleCheck")
	end
	return game
end

local function toggleRefresh(self)
	local on = toggleValue(self)
	local enabled = W.Enabled(self)
	if self.SetHeight and self.psRow then self:SetHeight(keptHeight(self)) end
	dimRow(self, enabled)
	if gameCheck(self, on) then
		self.psOn = on
		self.checked = on
		return
	end
	if on then
		local r, g, b = Theme.Accent()
		self.Track:SetColor(r, g, b, 1)
		self.Knob:SetVertexColor(Theme.Color("onAccent"))
	else
		self.Track:SetColor(Theme.Wash("toggle"))
		self.Knob:SetVertexColor(Theme.Color("textDim"))
	end
	local x = on and (TOGGLE_W - KNOB - 2) or 2
	if self.psOn ~= nil and self.psOn ~= on then
		self.Knob.psAnchor[4] = x
		Anim.To(self.Knob, "offsetX", (self.psKnobX or x) - x, 0, Anim.FAST, "out")
	else
		Anim.Anchor(self.Knob, "LEFT", self.Track, "LEFT", x, 0)
	end
	self.psKnobX = x
	self.psOn = on
	self.checked = on
end

-- opts.get() / opts.set(value) stand in for reading and writing the path when
-- one switch stands for several settings, or for state that is no setting
-- (path nil); set(nil) on right-click: defaults.
-- opts.gear = { tip, onClick }: a gear before the switch that opens the
-- setting's own options (the route lines' style).
local GEAR, GEAR_GAP = 22, 6
function W.Toggle(parent, label, path, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.psRow = true
	row.Track = pill(row, TOGGLE_W, TOGGLE_H)
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	row.Track:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Knob = row.Track:CreateTexture(nil, "OVERLAY")
	row.Knob:SetTexture(Theme.Media("circle"))
	row.Knob:SetSize(KNOB, KNOB)
	local gear = opts and opts.gear
	if gear then
		row.Gear = W.IconButton(row, "gear", GEAR, gear.tip, function() gear.onClick() end)
		row.Gear:SetPoint("RIGHT", row.Track, "LEFT", -GEAR_GAP, 0)
		fitLabel(row, row.Gear, function() return 12 + TOGGLE_W + GEAR_GAP + GEAR + 10 end)
	else
		fitLabel(row, row.Track, function() return 12 + TOGGLE_W + 10 end)
	end
	-- Left-click flips it; right-click puts the setting back to its default.
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if self.psSet then
			if button == "RightButton" then W.ResetSetting(nil, function() return toggleValue(self) end, self.psSet) else self.psSet(not toggleValue(self)) end
			self:Refresh()
		elseif button == "RightButton" then
			W.ResetSetting(self.psPath)
		else
			ns.Set(self.psPath, not ns.Get(self.psPath))
		end
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = toggleRefresh
	return W.Bind(row, path, depends)
end

-- The same switch without a row or a setting, for state that is not a
-- setting (a guide pack shown or hidden): get() -> on, set(on). Click
-- flips it; the owner repaints it with :Refresh().
function W.Switch(parent, get, set, tip)
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(TOGGLE_W + 8, 24)
	b.Track = pill(b, TOGGLE_W, TOGGLE_H)
	b.Track:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Knob = b.Track:CreateTexture(nil, "OVERLAY")
	b.Knob:SetTexture(Theme.Media("circle"))
	b.Knob:SetSize(KNOB, KNOB)
	b.psGet, b.psTip = get, tip
	b:SetScript("OnClick", function(self)
		set(not toggleValue(self))
		self:Refresh()
	end)
	b:SetScript("OnEnter", simpleTip)
	b:SetScript("OnLeave", hideTip)
	b.Refresh = toggleRefresh
	return W.Painter(b, toggleRefresh)
end

---------------------------------------------------------------------------
-- Slider: a native Slider for dragging, drawn as a 2px track with an accent
-- fill and a round thumb, its value right of it. Wheel steps it.
---------------------------------------------------------------------------

local SLIDER_W, SLIDER_MIN, VALUE_W, VALUE_PAD = 112, 64, 44, 8

local function roundTo(v, stepSize)
	return floor(v / stepSize + 0.5) * stepSize
end

local function sliderText(self, v)
	local fmt = self.psFormat
	if type(fmt) == "function" then return fmt(v) end
	return string.format(fmt or "%.2f", v)
end
W.SliderText = sliderText

-- A slider row's value box: as wide as its widest end ("60 minutes"), never
-- narrower than the skin's; kept on the row (psValueW) for its repaints.
-- -> the width
local function valueWidth(row)
	local v = row.Value
	local shown = v:GetText()
	local need = max(textWidth(v, sliderText(row, row.psMin)), textWidth(v, sliderText(row, row.psMax)))
	v:SetText(shown or "")
	local w = max(Theme.Metric("valueW", VALUE_W), math.ceil(need))
	row.psValueW = w
	v:SetWidth(w)
	return w
end

local function sliderPaint(self, value)
	local s = self.Slider
	local lo, hi = s:GetMinMaxValues()
	local v = value or s:GetValue()
	local w = self.psTrackW or Theme.Metric("sliderW", SLIDER_W)
	local frac = hi > lo and (v - lo) / (hi - lo) or 0
	self.Fill:SetWidth(max(0.01, w * frac))
	self.Value:SetText(sliderText(self, v))
end

local function sliderValue(self)
	if self.psGet then return self.psGet() end
	return ns.Get(self.psPath)
end

local function sliderWrite(self, value)
	if self.psSet then
		self.psSet(value)
		self:Refresh()
	else
		ns.Set(self.psPath, value)
	end
end

local function sliderRefresh(self)
	local v = sliderValue(self)
	if type(v) ~= "number" then v = self.psMin end
	self.psRefreshing = true
	self.Slider:SetValue(v)
	self.psRefreshing = false
	dimRow(self, W.Enabled(self))
	W.SkinSlider(self)
	sliderPaint(self)
end

-- A slider's parts in the skin in use (rows and the guide window's own).
function W.SkinSlider(self)
	local hearth = Theme.SkinKey() == "hearth"
	local s = self.Slider
	if self.psRow then
		self:SetHeight(keptHeight(self))
		s:SetWidth(self.psTrackW or Theme.Metric("sliderW", SLIDER_W))
		self.Value:SetWidth(self.psValueW or Theme.Metric("valueW", VALUE_W))
	end
	self.Thumb:SetTexCoord(0, 1, 0, 1)
	-- A row's label ends short of the slider: further in the game's looks,
	-- where the back stepper stands left of the track.
	local kitDrawn = Theme.KitSlider(self, s, self.Thumb)
	self.psKitGap = kitDrawn and 10 or 0
	if self.psRow and self.Label and not self.psDetails then self.Label:SetPoint("RIGHT", s, "LEFT", kitDrawn and -20 or -10, 0) end
	if kitDrawn then
		-- The game's looks: their own track and thumb, the value in gold.
		self.Track:Hide()
		self.Fill:Hide()
		if s.psBorder then for i = 1, 4 do s.psBorder[i]:Hide() end end
		if self.Value then W.Color(self.Value, "accent") end
		return
	end
	self.Track:Show()
	-- The house slider: a hairline track, the accent fill, a round thumb.
	-- Hearth cuts a deeper groove (3) and lights the thumb in its firelit
	-- gold.
	self.Track:SetHeight(hearth and 3 or 2)
	self.Track:SetVertexColor(Theme.Wash("track"))
	if s.psBorder then for i = 1, 4 do s.psBorder[i]:Hide() end end
	self.Fill:Show()
	self.Fill:SetHeight(hearth and 3 or 2)
	self.Fill:SetVertexColor(Theme.Accent())
	self.Thumb:SetTexture(Theme.Media("circle"))
	self.Thumb:SetSize(12, 12)
	self.Thumb:SetVertexColor(Theme.Color(hearth and "title" or "text"))
	if self.Value then W.Color(self.Value, "textDim") end
end

-- The track, fill and thumb of a slider, on `owner`.
local function sliderParts(owner, parent, width)
	local s = CreateFrame("Slider", nil, parent)
	s:SetOrientation("HORIZONTAL")
	s:SetSize(width, 16)
	s:EnableMouseWheel(true)
	s:SetObeyStepOnDrag(true)
	local trk = s:CreateTexture(nil, "BACKGROUND")
	trk:SetTexture(WHITE)
	trk:SetHeight(2)
	trk:SetPoint("LEFT", s, "LEFT", 0, 0)
	trk:SetPoint("RIGHT", s, "RIGHT", 0, 0)
	W.Painter(trk, function(t) t:SetVertexColor(Theme.Wash("track")) end)
	owner.Track = trk
	local fillTex = s:CreateTexture(nil, "ARTWORK")
	fillTex:SetTexture(WHITE)
	fillTex:SetHeight(2)
	fillTex:SetPoint("LEFT", trk, "LEFT", 0, 0)
	owner.Fill = fillTex
	local thumb = s:CreateTexture(nil, "OVERLAY")
	thumb:SetTexture(Theme.Media("circle"))
	thumb:SetSize(12, 12)
	s:SetThumbTexture(thumb)
	owner.Thumb = thumb
	owner.Slider = s
	return s
end

-- A slider row's control: the value as wide as its widest end ("60
-- minutes"), the track giving up to SLIDER_W - SLIDER_MIN of its width to a
-- label that needs it.
local function sliderSpan(row, width)
	local valueW = valueWidth(row)
	local fixed = 12 + VALUE_PAD + valueW + VALUE_PAD + 8 + 10
	local trackW = max(SLIDER_MIN, min(SLIDER_W, width - 12 - fixed - math.ceil(textWidth(row.Label))))
	row.Slider:SetWidth(trackW)
	row.psTrackW = trackW
	sliderPaint(row)
	return fixed + trackW
end

-- A typed value: the number in the text, in the slider's own terms (on a
-- slider showing "120%", "120" and "120%" are both 1.2), clamped to its
-- range and put on its step. -> value | nil
function W.ParseSliderText(row, text)
	text = tostring(text or ""):gsub(",", ".")
	local n = tonumber(text:match("[-+]?%d*%.?%d+") or "")
	if not n then return nil end
	local cur = sliderValue(row)
	if type(cur) ~= "number" then cur = row.psMin end
	if sliderText(row, cur):find("%", 1, true) then n = n / 100 end
	n = roundTo(min(row.psMax, max(row.psMin, n)), row.psStep)
	return min(row.psMax, max(row.psMin, n))
end

-- A drag's magnet: the value a dragged slider lands on near its sensible
-- points, its default, zero inside its range and the value it shows as
-- 100%, when one lies within SNAP_PX of the thumb along the track. A track
-- whose steps are that far apart lands on any value already: no magnet.
-- (The wheel, the keys and a typed value never snap.) -> value
local SNAP_PX = 6
function W.SliderSnap(row, value)
	local lo, hi, step = row.psMin, row.psMax, row.psStep
	local w = row.psTrackW or row.Slider:GetWidth()
	if not (w and w > 0 and hi > lo) then return value end
	local th = SNAP_PX / w * (hi - lo)
	if th < step then return value end
	local pts = rawget(row, "psSnaps")
	if not pts then
		pts = {}
		local d = row.psPath and ns.GetDefault and ns.GetDefault(row.psPath)
		if type(d) == "number" and d >= lo and d <= hi then pts[#pts + 1] = d end
		if lo < 0 and hi > 0 then pts[#pts + 1] = 0 end
		for _, c in ipairs({ 1, 100 }) do
			if lo < c and c < hi and sliderText(row, c) == "100%" then pts[#pts + 1] = c end
		end
		row.psSnaps = pts
	end
	local best, bd
	for i = 1, #pts do
		local dist = math.abs(value - pts[i])
		if dist <= th and (not bd or dist < bd) then best, bd = pts[i], dist end
	end
	return best or value
end

-- The box a value is typed into, over the value; Enter applies it, Escape
-- or a click elsewhere leaves the value as it was.
local function sliderEntry(row)
	local e = rawget(row, "Entry")
	if e then return e end
	e = CreateFrame("EditBox", nil, row)
	e:SetAutoFocus(false)
	e:SetHeight(24)
	e:SetTextInsets(6, 6, 0, 0)
	e:SetJustifyH("RIGHT")
	Theme.Font(e, "number")
	W.Color(e, "text")
	Theme.Skin(e, "editbox")
	e:SetScript("OnEnterPressed", function(self)
		local v = W.ParseSliderText(row, self:GetText())
		self:ClearFocus()
		if v ~= nil and W.Enabled(row) then sliderWrite(row, v) end
	end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEditFocusGained", function(self)
		Theme.SetFocused(self, true)
		self:HighlightText()
	end)
	e:SetScript("OnEditFocusLost", function(self)
		Theme.SetFocused(self, false)
		self:Hide()
		row.Value:Show()
	end)
	e:Hide()
	row.Entry = e
	return e
end

-- Open the typed entry on a slider row.
function W.EditSliderValue(row)
	if not W.Enabled(row) then return end
	local e = sliderEntry(row)
	e:ClearAllPoints()
	e:SetPoint("RIGHT", row.Value, "RIGHT", VALUE_PAD, 0)
	e:SetWidth(row.Value:GetWidth() + 2 * VALUE_PAD)
	e:SetFrameLevel(row.ValueHit:GetFrameLevel() + 2)
	e:SetText(row.Value:GetText() or "")
	row.Value:Hide()
	e:Show()
	e:SetFocus()
end

-- opts.release: write the value when the drag ends, not on every step (a
-- setting that rescales the window the slider sits in).
-- opts.get() / opts.set(value) stand in for reading and writing the path,
-- for state that is no setting (path nil; per character); set(nil) on
-- right-click: the default.
function W.Slider(parent, label, path, lo, hi, stepSize, fmt, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.psRow = true
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	row.psMin, row.psMax, row.psStep, row.psFormat = lo, hi, stepSize, fmt
	-- The value in its box (the field's well and hairline); a click on it
	-- types one in.
	local hit = CreateFrame("Button", nil, row)
	hit:SetHeight(24)
	Theme.Skin(hit, "editbox")
	row.ValueHit = hit
	row.Value = W.Text(hit, "number", "textDim")
	row.Value:SetJustifyH("RIGHT")
	row.Value:SetWidth(VALUE_W)
	row.Value:SetPoint("RIGHT", row, "RIGHT", -(12 + VALUE_PAD), 0)
	hit:SetPoint("LEFT", row.Value, "LEFT", -VALUE_PAD, 0)
	hit:SetPoint("RIGHT", row.Value, "RIGHT", VALUE_PAD, 0)
	local s = sliderParts(row, row, SLIDER_W)
	s:SetPoint("RIGHT", row.Value, "LEFT", -(VALUE_PAD + 8), 0)
	s:SetMinMaxValues(lo, hi)
	s:SetValueStep(stepSize)
	fitLabel(row, s, sliderSpan)
	s:SetScript("OnValueChanged", function(_, value, userInput)
		value = roundTo(value, stepSize)
		-- A drag passing near the default, zero or 100% lands on it.
		if userInput and row.psDragging and not row.psSnapping then
			local v = W.SliderSnap(row, value)
			if v ~= value then
				value = v
				row.psSnapping = true
				s:SetValue(v)
				row.psSnapping = false
			end
		end
		sliderPaint(row, value)
		if userInput and not row.psRefreshing and W.Enabled(row) and sliderValue(row) ~= value then
			if opts and opts.release then row.psPending = value else sliderWrite(row, value) end
		end
	end)
	s:HookScript("OnMouseDown", function() row.psDragging = true end)
	s:HookScript("OnHide", function() row.psDragging = nil end)
	s:SetScript("OnMouseUp", function()
		row.psDragging = nil
		if row.psPending ~= nil then
			local v = row.psPending
			row.psPending = nil
			sliderWrite(row, v)
		end
	end)
	s:SetScript("OnMouseWheel", function(_, delta)
		if not W.Enabled(row) then return end
		local v = roundTo((sliderValue(row) or lo) + delta * stepSize, stepSize)
		sliderWrite(row, min(hi, max(lo, v)))
	end)
	hit.psTip = L["Click to type a value"]
	hit:SetScript("OnEnter", simpleTip)
	hit:SetScript("OnLeave", hideTip)
	hit:SetScript("OnClick", function() W.EditSliderValue(row) end)
	-- Right-click puts the setting back to its default.
	row:RegisterForClicks("RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if button == "RightButton" and W.Enabled(self) then
			if self.psSet then
				W.ResetSetting(nil, function() return sliderValue(self) end, function(v) sliderWrite(self, v) end)
			else
				W.ResetSetting(self.psPath)
			end
		end
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = sliderRefresh
	return W.Bind(row, path, depends)
end

---------------------------------------------------------------------------
-- Menu: one shared popup list (header menu, dropdown choices). A click
-- anywhere else closes it; Escape closes it. On the panel ground inside its
-- hairline, 26px rows in textDim; the chosen one in the text colour with the
-- accent check, the one under the cursor in the text colour on the hover
-- wash. It opens with a 120ms fade and a 4px drop (reduced motion: none).
---------------------------------------------------------------------------

local menu, catcher
local MENU_ROW, MENU_SEP, MENU_PAD = 26, 9, 4

-- A string in a face of its own, outside the theme's type: a font list's
-- names, each drawn in its face. W.SetFaceText(fs, text, path) sets it
-- (path nil: the label's face in use).
function W.FaceString(parent)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	local path, size = Theme.FontSpec("label")
	fs:SetFont(path, size, "")
	fs:SetShadowOffset(1, -1)
	fs:SetShadowColor(0, 0, 0, 0.6)
	return fs
end

function W.SetFaceText(fs, text, path)
	local own, size = Theme.FontSpec("label")
	Theme.SetFace(fs, path or own, size, "")
	fs:SetText(text or "")
end

-- A row's resting colours: the item's own, else the text colour while
-- chosen or under the cursor, textDim otherwise.
local function paintMenuRow(row, lit)
	local item = row.psItem
	if not item then return end
	local off = item.disabled and 0.45 or 1
	local on = (lit and not item.disabled) or item.checked
	W.Color(row.Text, item.color or (on and "text" or "textDim"), off)
	local face = rawget(row, "Face")
	if face then W.Color(face, item.color or (on and "text" or "textDim"), off) end
	if item.icon then W.Color(row.Icon, item.color or (on and "text" or "textDim"), off) end
end

-- Items with confirm = true need a second click: the first relabels the row
-- and keeps the menu open.
local function menuRowClick(self)
	local item = self.psItem
	if not item or item.disabled then return end
	if item.confirm and not self.psArmed then
		self.psArmed = true
		self.Text:SetText(L["Click again to confirm"])
		W.Color(self.Text, "danger")
		return
	end
	W.HideMenu()
	if item.onClick then item.onClick(item) end
end

-- item.preview(item): a choice heard (or seen) without picking it, a sound
-- list's: the row's speaker plays it, and so does resting the pointer on
-- the row a moment (PREVIEW_DWELL); leaving it or the menu closing first
-- plays nothing.
local PREVIEW_DWELL = 0.5
local previewToken = 0
local function previewSoon(row)
	previewToken = previewToken + 1
	local token, item = previewToken, row.psItem
	if not (item and item.preview) then return end
	ns.After(PREVIEW_DWELL, function()
		if token == previewToken and row:IsVisible() and row.psItem == item then item.preview(item) end
	end)
end

local function rowSpeaker(row)
	local b = rawget(row, "Speaker")
	if b then return b end
	b = W.IconButton(row, "speaker", 22, L["Play"], function()
		previewToken = previewToken + 1
		local item = row.psItem
		if item and item.preview then item.preview(item) end
	end, 13)
	b.psTipLines = { L["Hear it without picking it."] }
	row.Speaker = b
	return b
end

local function menuRowEnter(self)
	if not self.psArmed then paintMenuRow(self, true) end
	if self.psItem and self.psItem.tip then W.Tooltip(self, "ANCHOR_RIGHT", self.psItem.text, { self.psItem.tip }) end
	previewSoon(self)
end

local function menuRowLeave(self)
	if not self.psArmed then paintMenuRow(self, false) end
	hideTip(self)
	previewToken = previewToken + 1
end

local function buildMenu()
	catcher = CreateFrame("Button", nil, UIParent)
	catcher:SetAllPoints(UIParent)
	catcher:SetFrameStrata("FULLSCREEN_DIALOG")
	catcher:SetFrameLevel(1)
	catcher:RegisterForClicks("AnyUp")
	catcher:SetScript("OnClick", function() W.HideMenu() end)
	catcher:Hide()

	menu = CreateFrame("Frame", "PolestarMenu", UIParent)
	menu:SetFrameStrata("FULLSCREEN_DIALOG")
	menu:SetFrameLevel(20)
	menu:SetClampedToScreen(true)
	menu:EnableMouse(true)
	Theme.Skin(menu, "panel")
	menu.rows = {}
	menu.seps = {}
	menu:SetScript("OnHide", function()
		catcher:Hide()
		previewToken = previewToken + 1
	end)
	menu:Hide()
	ns.CloseOnEscape("PolestarMenu")
	-- A gamepad (UI/Gamepad.lua) picks a row, starting on the current choice; B closes.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(menu, {
			rows = function()
				local out = {}
				for _, r in ipairs(menu.rows) do
					if r:IsShown() and not (r.psItem and r.psItem.disabled) then out[#out + 1] = r end
				end
				return out
			end,
			initial = function(rows)
				for i, r in ipairs(rows) do if r.psItem and r.psItem.checked then return i end end
			end,
			back = function() W.HideMenu() end,
		})
	end
end

local function menuRow(i)
	local row = menu.rows[i]
	if row then return row end
	row = CreateFrame("Button", nil, menu)
	row:SetHeight(MENU_ROW)
	hoverTexture(row)
	row.Icon = row:CreateTexture(nil, "ARTWORK")
	row.Icon:SetSize(14, 14)
	row.Icon:SetPoint("LEFT", row, "LEFT", 10, 0)
	row.Text = W.Text(row, "label", "text")
	row.Text:SetPoint("LEFT", row, "LEFT", 32, 0)
	row.Check = row:CreateTexture(nil, "ARTWORK")
	row.Check:SetTexture(Theme.Media("check"))
	row.Check:SetSize(12, 12)
	row.Check:SetPoint("RIGHT", row, "RIGHT", -10, 0)
	row:SetScript("OnClick", menuRowClick)
	row:SetScript("OnEnter", menuRowEnter)
	row:SetScript("OnLeave", menuRowLeave)
	menu.rows[i] = row
	return row
end

-- items: { { text, icon, checked, disabled, onClick, tip, color, confirm, preview }, { separator = true }, ... }
-- opts: { point = "TOPRIGHT", relPoint = "BOTTOMRIGHT", x = 0, y = -4, minWidth = 168 }
function W.ShowMenu(anchor, items, opts)
	if not menu then buildMenu() end
	opts = opts or {}
	local pad, rowH = Theme.Metric("menuPad", MENU_PAD), Theme.Metric("menuRow", MENU_ROW)
	local y, width, nrow, nsep = -pad, opts.minWidth or Theme.Metric(opts.wide and "servicesWidth" or "menuWidth", 176), 0, 0
	local anyIcon, anyPreview = false, false
	for i = 1, #items do
		if items[i].icon then anyIcon = true end
		if items[i].preview then anyPreview = true end
	end
	for i = 1, #menu.rows do menu.rows[i]:Hide() end
	for i = 1, #menu.seps do menu.seps[i]:Hide() end
	for i = 1, #items do
		local item = items[i]
		if item.separator then
			nsep = nsep + 1
			local sep = menu.seps[nsep]
			if not sep then
				sep = W.Divider(menu)
				menu.seps[nsep] = sep
			end
			sep:ClearAllPoints()
			sep:SetPoint("TOPLEFT", menu, "TOPLEFT", 8, y - 4)
			sep:SetPoint("TOPRIGHT", menu, "TOPRIGHT", -8, y - 4)
			sep:Show()
			y = y - MENU_SEP
		else
			nrow = nrow + 1
			local row = menuRow(nrow)
			row.psItem = item
			row.psArmed = nil
			row.Text:SetText(item.text)
			row.Text:SetPoint("LEFT", row, "LEFT", anyIcon and 32 or 12, 0)
			-- item.font: the text drawn in that face (a font list).
			local face = rawget(row, "Face")
			if item.font then
				if not face then
					face = W.FaceString(row)
					row.Face = face
				end
				W.SetFaceText(face, item.text, item.font)
				face:ClearAllPoints()
				face:SetPoint("LEFT", row, "LEFT", anyIcon and 32 or 12, 0)
				face:Show()
				row.Text:SetAlpha(0)
			else
				if face then face:Hide() end
				row.Text:SetAlpha(1)
			end
			if item.icon then
				row.Icon:SetTexture(Theme.Media(Theme.Icon(item.icon)))
				row.Icon:Show()
			else
				row.Icon:Hide()
			end
			paintMenuRow(row, false)
			row.Check:SetShown(item.checked and true or false)
			W.Color(row.Check, "accent")
			-- A choice to hear first: its speaker at the right, the check left of it.
			local speaker = rawget(row, "Speaker")
			if item.preview then
				speaker = rowSpeaker(row)
				speaker:ClearAllPoints()
				speaker:SetPoint("RIGHT", row, "RIGHT", -6, 0)
				speaker:Show()
			elseif speaker then
				speaker:Hide()
			end
			row.Check:ClearAllPoints()
			row.Check:SetPoint("RIGHT", row, "RIGHT", item.preview and -32 or -10, 0)
			row:ClearAllPoints()
			row:SetHeight(rowH)
			row:SetPoint("TOPLEFT", menu, "TOPLEFT", 1, y)
			row:SetPoint("TOPRIGHT", menu, "TOPRIGHT", -1, y)
			row:Show()
			local shownText = (item.font and face) or row.Text
			width = max(width, shownText:GetStringWidth() + (anyIcon and 32 or 12) + 36 + (anyPreview and 26 or 0))
			y = y - rowH
		end
	end
	menu:SetSize(floor(width + 0.5), -y + pad)
	menu:ClearAllPoints()
	menu.psOwner = anchor
	local point, relPoint = opts.point or "TOPRIGHT", opts.relPoint or "BOTTOMRIGHT"
	Anim.Anchor(menu, point, anchor, relPoint, opts.x or 0, opts.y or -4)
	catcher:Show()
	menu:Show()
	-- Popovers grow out of their trigger: a short fade with a 4px drop.
	Anim.To(menu, "alpha", 0, 1, Anim.FAST, "out")
	Anim.To(menu, "offset", 4, 0, Anim.FAST, "out")
	return menu
end

function W.HideMenu()
	if menu and menu:IsShown() then menu:Hide() end
end

function W.MenuShown(owner)
	return menu and menu:IsShown() and (not owner or menu.psOwner == owner) or false
end

-- The menu is on UIParent, not Polestar's layer (Core/Init.lua): the minimap
-- button's menu works while Polestar is hidden. One open as Polestar hides
-- (a window's dropdown, a key pressed) closes.
ns.On("POLESTAR_HIDDEN", function(hidden)
	if hidden then W.HideMenu() end
end)

---------------------------------------------------------------------------
-- Dropdown: a button showing the current choice; the list is the menu.
-- choices: a list or a function returning one (choices that come and go).
-- opts.get() / opts.set(value) stand in for reading and writing the path
-- when the shown value is derived (the font: Inter, or EllesmereUI's while
-- following it).
---------------------------------------------------------------------------

local DROPDOWN_W, DROPDOWN_MIN = 150, 72

local function choicesOf(row)
	local c = row.psChoices
	if type(c) == "function" then return c() or {} end
	return c
end

local function valueOf(row)
	if row.psGet then return row.psGet() end
	return ns.Get(row.psPath)
end

local function choiceText(choices, v)
	for i = 1, #choices do
		if choices[i].value == v then return choices[i].text end
	end
	return tostring(v == nil and "" or v)
end

local DROPDOWN_ARROW = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up"

local function dropdownRefresh(self)
	self.Button.Label:SetText(choiceText(choicesOf(self), valueOf(self)))
	self:SetHeight(keptHeight(self))
	local b = self.Button
	b:SetSize(self.psBoxW or Theme.Metric("dropdownW", DROPDOWN_W), Theme.Metric("dropdownH", 28))
	local bliz = Theme.GameSkin()
	local size = bliz and 22 or Theme.Metric("chevron", 12)
	b.Arrow:SetTexture(bliz and DROPDOWN_ARROW or Theme.Media("chevron-down"))
	b.Arrow:SetTexCoord(0, 1, 0, 1)
	b.Arrow:SetAlpha(1)
	-- The Settings panel's dropdown centres its value.
	b.Label:SetJustifyH((Theme.Kit() and Theme.Kit().dropdown) and "CENTER" or "LEFT")
	b.Arrow:SetSize(size, size)
	-- The game's looks: their own arrow button.
	Theme.KitDropArrow(b.Arrow)
	b.Arrow:ClearAllPoints()
	b.Arrow:SetPoint("RIGHT", b, "RIGHT", bliz and (Theme.Kit() and -3 or 0) or -Theme.Metric("chevronInset", 9), 0)
	if bliz then W.Uncolor(b.Arrow); b.Arrow:SetVertexColor(1, 1, 1, 1) else W.Color(b.Arrow, "textDim") end
	-- A font list (opts.faces) shows the choice in its own face.
	if self.psFaces then
		local cur, list = valueOf(self), choicesOf(self)
		local font
		for i = 1, #list do if list[i].value == cur then font = list[i].font end end
		local face = rawget(b, "Face")
		if not face then
			face = W.FaceString(b)
			face:SetPoint("LEFT", b.Label, "LEFT", 0, 0)
			face:SetPoint("RIGHT", b.Label, "RIGHT", 0, 0)
			face:SetJustifyH("LEFT")
			face:SetWordWrap(false)
			W.Color(face, "text")
			b.Face = face
		end
		W.SetFaceText(face, b.Label:GetText(), font)
		face:SetShown(font ~= nil)
		b.Label:SetAlpha(font and 0 or 1)
	end
	dimRow(self, W.Enabled(self))
end

local function openChoices(self)
	local row = self.psRow
	if W.MenuShown(self) then return W.HideMenu() end
	local items = {}
	local cur = valueOf(row)
	local list = choicesOf(row)
	for i = 1, #list do
		local c = list[i]
		items[i] = { text = c.text, checked = c.value == cur, font = row.psFaces and c.font or nil, onClick = function()
			if row.psSet then row.psSet(c.value) else ns.Set(row.psPath, c.value) end
		end, preview = c.preview and function() c.preview(c.value) end }
	end
	W.ShowMenu(self, items, { minWidth = self:GetWidth() })
end

-- The widest word of a row's label: the least it can wrap to uncut.
local function widestWord(row)
	local w = 0
	for word in (row.psLabel or ""):gmatch("%S+") do w = max(w, textWidth(row.Label, word)) end
	row.Label:SetText(row.psLabel)
	return w
end

-- A dropdown row's control: as wide as its longest choice, DROPDOWN_W at
-- least, but never so wide that the label loses room for its widest word
-- (the label then wraps between words, never inside one): the box gives
-- way first, down to DROPDOWN_MIN.
local function dropdownSpan(row, width)
	local b = row.Button
	local shown = b.Label:GetText()
	local need = 0
	for _, c in ipairs(choicesOf(row)) do need = max(need, textWidth(b.Label, c.text)) end
	b.Label:SetText(shown or "")
	local desired = max(DROPDOWN_W, math.ceil(need) + 36)
	local room = width - 12 - 10 - 12 - math.ceil(widestWord(row))
	local bw = max(DROPDOWN_MIN, min(desired, room))
	b:SetWidth(bw)
	row.psBoxW = bw
	return 12 + bw + 10
end

function W.Dropdown(parent, label, path, choices, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.psChoices = choices
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	-- opts.faces: a font list, each choice ({ value, text, font = path })
	-- drawn in its own face, in the box and in the list.
	row.psFaces = opts and opts.faces or nil
	local b = CreateFrame("Button", nil, row)
	b:SetSize(DROPDOWN_W, 28)
	b:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	b.Label = W.Text(b, "label", "text")
	-- Where the box gave way to the label, the choice takes a second line
	-- (two 12px lines fit its 28px); set on every refresh, so the cold-start
	-- blank of a max-lines string (W.Text) does not stick.
	b.Label:SetWordWrap(true)
	b.Label:SetMaxLines(2)
	b.Label:SetPoint("LEFT", b, "LEFT", 10, 0)
	b.Label:SetPoint("RIGHT", b, "RIGHT", -26, 0)
	b.Arrow = b:CreateTexture(nil, "ARTWORK")
	b.Arrow:SetTexture(Theme.Media("chevron-down"))
	b.Arrow:SetSize(12, 12)
	b.Arrow:SetPoint("RIGHT", b, "RIGHT", -9, 0)
	W.Color(b.Arrow, "textDim")
	Theme.Skin(b, "dropdown")
	b.psRow = row
	b:SetScript("OnClick", openChoices)
	row.Button = b
	fitLabel(row, b, dropdownSpan)
	-- Right-click on the row puts the setting back to its default.
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(_, button)
		if button == "RightButton" then
			if W.Enabled(row) then
				W.HideMenu()
				if path then W.ResetSetting(path) elseif row.psSet then W.ResetSetting(nil, function() return valueOf(row) end, row.psSet) end
			end
			return
		end
		openChoices(b)
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = dropdownRefresh
	return W.Bind(row, path, depends)
end

---------------------------------------------------------------------------
-- Compact rows (the settings window, DESIGN.md "The Row Rule"): a setting
-- is a half of a 36px row: its label (Body, textDim; text and a 6px gold dot
-- before it while off its default) from 16, one line, cut with an ellipsis;
-- its control right-aligned 16 from the half's right edge at a fixed width
-- per kind (slider: a 120 track, 8, the value box; dropdown 168; colour: the
-- 20px chip, the hex, the opacity). Left of the control zone (as wide as the
-- widest control) stand fixed columns, right to left: a swatch, a switch,
-- the cog; an empty one keeps its place, so they line up down the page. No
-- description: the help is the tooltip, 0.25s after the cursor arrives
-- (W.ShowRowTip; opts.tip(row) -> lines). An optional (i) after the label.
--   W.CompactRow(row, { tip = fn, info = bool, height = 36,
--     extras = { widget, ... }, cog = widget }) -> row
-- W.LayoutRow(row, halfWidth) lays it out (W.LayoutCompact).
---------------------------------------------------------------------------

local HALF_PAD, COMPACT_H, INLINE_GAP = 16, 36, 8
W.COMPACT_H = COMPACT_H
local COMPACT_SLIDER, COMPACT_DROPDOWN, COMPACT_HEX, COMPACT_CHIP = 120, 168, 72, 20

-- The main control's width, re-anchored on the 16 edge, by kind.
local function compactControl(row)
	local right = HALF_PAD
	if rawget(row, "Track") and rawget(row, "Knob") then
		row.Track:ClearAllPoints()
		row.Track:SetPoint("RIGHT", row, "RIGHT", -right, 0)
		local w = TOGGLE_W
		local gear = rawget(row, "Gear")
		if gear then
			gear:ClearAllPoints()
			gear:SetPoint("RIGHT", row.Track, "LEFT", -6, 0)
			w = w + 6 + gear:GetWidth()
		end
		return function() return w end
	elseif rawget(row, "Slider") and rawget(row, "ValueHit") then
		row.psTrackW = COMPACT_SLIDER
		row.Value:ClearAllPoints()
		row.Value:SetPoint("RIGHT", row, "RIGHT", -(right + VALUE_PAD), 0)
		row.Slider:ClearAllPoints()
		row.Slider:SetPoint("RIGHT", row.Value, "LEFT", -(VALUE_PAD + INLINE_GAP), 0)
		row.Slider:SetWidth(COMPACT_SLIDER)
		return function(self)
			return COMPACT_SLIDER + INLINE_GAP + 2 * VALUE_PAD + valueWidth(self)
		end
	elseif rawget(row, "Button") and row.psChoices ~= nil then
		row.psBoxW = COMPACT_DROPDOWN
		row.Button:ClearAllPoints()
		row.Button:SetPoint("RIGHT", row, "RIGHT", -right, 0)
		return function() return COMPACT_DROPDOWN end
	elseif rawget(row, "ChipFrame") then
		local w, anchor = 0, nil
		local alpha = rawget(row, "Alpha")
		if alpha then
			alpha:ClearAllPoints()
			alpha:SetPoint("RIGHT", row, "RIGHT", -right, 0)
			w, anchor = alpha:GetWidth(), alpha
		end
		row.Hex:ClearAllPoints()
		row.Hex:SetWidth(COMPACT_HEX)
		if anchor then row.Hex:SetPoint("RIGHT", anchor, "LEFT", -INLINE_GAP, 0) else row.Hex:SetPoint("RIGHT", row, "RIGHT", -right, 0) end
		w = w + (anchor and INLINE_GAP or 0) + COMPACT_HEX
		local chip = row.ChipFrame
		chip:ClearAllPoints()
		chip:SetSize(COMPACT_CHIP, COMPACT_CHIP)
		chip:SetPoint("RIGHT", row.Hex, "LEFT", -INLINE_GAP, 0)
		w = w + INLINE_GAP + COMPACT_CHIP
		row.Note:Hide()
		return function() return w end
	elseif rawget(row, "psCardBy") then
		return function() return 0 end
	elseif rawget(row, "Button") then
		row.Button:ClearAllPoints()
		row.Button:SetPoint("RIGHT", row, "RIGHT", -right, 0)
		return function(self) return self.Button:GetWidth() end
	end
	-- Any other row (a key binding's, an info row's): what its span asks.
	return function(self, width)
		return self.psSpan and max(0, self.psSpan(self, width) - 22) or 0
	end
end

function W.CompactRow(row, opts)
	opts = opts or {}
	row.psCompact, row.psDetails, row.psInset = true, true, HALF_PAD
	row.psCompactH = opts.height or COMPACT_H
	-- opts.bare: picture cards with no label band (their section names them).
	row.psBare = opts.bare and row.psBelow ~= nil or nil
	row.Label:SetShown(not row.psBare)
	row.psTipFn = opts.tip or function(r) return r.psDesc and { r.psDesc } or nil end
	row.psTip, row.psTipLines = nil, nil
	row.psTipAnchor = "ANCHOR_TOPLEFT"
	row.psExtras = opts.extras
	row.Cog = opts.cog
	row.Label:SetWordWrap(false)
	if rawget(row, "Help") then row.Help:Hide() end
	if rawget(row, "psConnector") then for _, t in ipairs(row.psConnector) do t:Hide() end end
	if not rawget(row, "ModDot") then
		row.ModDot = W.Tex(row, "ARTWORK", "circle", "accent")
	end
	row.ModDot:SetSize(6, 6)
	row.ModDot:ClearAllPoints()
	row.ModDot:SetPoint("RIGHT", row.Label, "LEFT", -5, 0)
	if opts.info and not rawget(row, "Info") then
		row.Info = W.Tex(row, "ARTWORK", "info", "textMuted")
		row.Info:SetSize(12, 12)
	end
	row.psControlW = compactControl(row)
	markRow(row)
	return row
end

-- The control zone: as wide as the widest control, so the columns left of
-- it stand at one x down the page.
local function controlZone()
	local slider = COMPACT_SLIDER + INLINE_GAP + 2 * VALUE_PAD + Theme.Metric("valueW", VALUE_W)
	return max(slider, COMPACT_DROPDOWN)
end

function W.LayoutCompact(row, width)
	row:SetWidth(width)
	local h = row.psCompactH or COMPACT_H
	local used = HALF_PAD + (row.psControlW and row.psControlW(row, width) or 0)
	local x = used
	local extras, cog = row.psExtras, rawget(row, "Cog")
	if (extras and #extras > 0) or cog then
		-- Fixed columns right to left: swatch, switch, cog. A second of a
		-- kind (the page's mistake) stands left of the cog.
		local zone = max(used, HALF_PAD + controlZone())
		local swatchX = zone + INLINE_GAP
		local switchX = swatchX + COMPACT_CHIP + INLINE_GAP
		local cogX = switchX + TOGGLE_W + 8 + INLINE_GAP
		local spill = cogX + COMPACT_CHIP
		local hasSwatch, hasSwitch
		for _, e in ipairs(extras or {}) do
			local at
			if rawget(e, "Fill") and not hasSwatch then
				at, hasSwatch = swatchX, true
			elseif rawget(e, "Knob") and not hasSwitch then
				at, hasSwitch = switchX, true
			else
				at = spill + INLINE_GAP
				spill = at + e:GetWidth()
			end
			e:ClearAllPoints()
			e:SetPoint("RIGHT", row, "RIGHT", -at, 0)
			e:Show()
			x = max(x, at + e:GetWidth())
		end
		if cog then
			cog:ClearAllPoints()
			cog:SetPoint("RIGHT", row, "RIGHT", -cogX, 0)
			x = max(x, cogX + cog:GetWidth())
		end
	end
	local info = rawget(row, "Info")
	local label = row.Label
	local lw = max(1, width - HALF_PAD - x - INLINE_GAP - (info and 16 or 0))
	label:ClearAllPoints()
	local below = row.psBelow
	if below then
		label:SetPoint("LEFT", row, "TOPLEFT", HALF_PAD, -floor(h / 2))
	else
		label:SetPoint("LEFT", row, "LEFT", HALF_PAD, 0)
	end
	label:SetWidth(lw)
	if info then
		info:ClearAllPoints()
		info:SetPoint("LEFT", label, "LEFT", min(lw, math.ceil(textWidth(label))) + 4, 0)
	end
	-- Picture cards run under the label's band, across the row.
	if below then
		if row.psBare then h = 12 end
		h = h + below(row, width - HALF_PAD * 2, h) + 12
	end
	row.psLaidH = h
	row:SetHeight(h)
	return h
end

-- The tooltip of a compact half: its label over the lines its tip gives.
function W.ShowRowTip(row)
	local lines = row.psTipFn and row.psTipFn(row) or nil
	W.Tooltip(row, row.psTipAnchor or "ANCHOR_TOPLEFT", row.psLabel, lines)
	row.psTipShown = { title = row.psLabel, lines = lines }
end

-- The parts the settings window's own widgets build on: its colour rows,
-- picture cards, inline extras, cogs, section cards, action rows and tiles
-- are Polestar_Options/UI/Controls.lua's, loaded with the window, never at
-- login.
W.RowParts = {
	settingRow = settingRow, fitLabel = fitLabel, dimRow = dimRow, rowEnter = rowEnter,
	simpleTip = simpleTip, hideTip = hideTip, hoverTexture = hoverTexture,
	choicesOf = choicesOf, valueOf = valueOf, HALF_PAD = HALF_PAD, COMPACT_CHIP = COMPACT_CHIP,
}

-- A section card's header (W.SectionCard, Polestar_Options/UI/Controls.lua).
W.CARD_HEADER = 36

---------------------------------------------------------------------------
-- A read-only value row (status pages): label left, value right.
---------------------------------------------------------------------------

function W.InfoRow(parent, label, desc)
	local row = settingRow(parent, label, desc)
	row.Value = W.Text(row, "label", "textDim")
	row.Value:SetJustifyH("RIGHT")
	row.Value:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	fitLabel(row, row.Value, function(self) return 12 + math.ceil(textWidth(self.Value)) + 10 end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	return row
end

---------------------------------------------------------------------------
-- Search box
---------------------------------------------------------------------------

local PLACEHOLDER_X, PLACEHOLDER_PAD = 30, 10

-- The placeholder takes the first of its wordings (longest first) that fits
-- inside the box in the current font; the last one is cut with an ellipsis
-- if even it does not. Refitted when the box's size or the font changes.
local function fitPlaceholder(e)
	local ph, list = e.Placeholder, e.psPlaceholders
	if not list then return end
	local room = floor(e:GetWidth() - PLACEHOLDER_X - PLACEHOLDER_PAD)
	for i, text in ipairs(list) do
		ph:SetWidth(0) -- unbound, to measure the whole wording
		ph:SetText(text)
		if i == #list or room <= 0 or ph:GetStringWidth() <= room then break end
	end
	if room > 0 then ph:SetWidth(room) end
end

-- placeholder: a string, or a list of wordings, longest first.
function W.SetSearchPlaceholder(e, placeholder)
	e.psPlaceholders = type(placeholder) == "table" and placeholder or { placeholder or L["Search"] }
	fitPlaceholder(e)
end

function W.SearchBox(parent, placeholder, onChange)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetHeight(30)
	e:SetAutoFocus(false)
	e:SetTextInsets(30, 26, 0, 0)
	Theme.Font(e, "label")
	W.Color(e, "text")
	-- The glyph and placeholder live on an overlay frame above the box.
	local deco = CreateFrame("Frame", nil, e)
	deco:SetAllPoints(e)
	e.Icon = deco:CreateTexture(nil, "ARTWORK")
	e.Icon:SetTexture(Theme.Media("search"))
	e.Icon:SetSize(13, 13)
	e.Icon:SetPoint("LEFT", e, "LEFT", 10, 0)
	W.Color(e.Icon, "textMuted")
	e.Placeholder = W.Text(deco, "label", "textMuted")
	e.Placeholder:SetPoint("LEFT", e, "LEFT", PLACEHOLDER_X, 0)
	W.SetSearchPlaceholder(e, placeholder)
	e:HookScript("OnSizeChanged", fitPlaceholder)
	W.Painter(e.Placeholder, function() fitPlaceholder(e) end)
	e.Clear = W.IconButton(e, "close", 20, nil, function()
		e:SetText("")
		e:ClearFocus()
		if onChange then onChange("") end
	end)
	e.Clear:SetPoint("RIGHT", e, "RIGHT", -4, 0)
	e.Clear:Hide()
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	e:SetScript("OnTextChanged", function(self)
		local text = self:GetText() or ""
		self.Placeholder:SetShown(text == "")
		self.Clear:SetShown(text ~= "")
		if onChange then onChange(text) end
	end)
	return e
end

-- A read-only field holding text to copy (a link, a report, a position):
-- the search field's well and border, the text selected whenever it takes
-- focus, typing puts the text back. opts.lines > 1: a multi-line box that
-- tall. opts.well: the frame that draws the well and lights with focus
-- instead of the box (a box taller than its view, scrolled inside it).
-- W.SetCopyText(box, text) fills it.
function W.CopyBox(parent, opts)
	opts = opts or {}
	local e = CreateFrame("EditBox", nil, parent)
	local well = opts.well or e
	local lines = opts.lines or 1
	e:SetAutoFocus(false)
	Theme.Font(e, "label")
	W.Color(e, "text")
	if lines > 1 then
		e:SetMultiLine(true)
		e:SetHeight(lines * 16 + 16)
		e:SetTextInsets(10, 10, 8, 8)
	else
		e:SetHeight(30)
		e:SetTextInsets(10, 10, 0, 0)
	end
	Theme.Skin(well, "editbox")
	e:SetScript("OnEditFocusGained", function(self)
		Theme.SetFocused(well, true)
		self:HighlightText()
	end)
	e:SetScript("OnEditFocusLost", function(self)
		Theme.SetFocused(well, false)
		self:HighlightText(0, 0)
	end)
	e:SetScript("OnMouseUp", function(self) W.SelectCopy(self) end)
	-- Ctrl+A (Cmd+A on a Mac) selects all of it again.
	e:SetScript("OnKeyDown", function(self, key)
		if key == "A" and ((IsControlKeyDown and IsControlKeyDown()) or (IsMetaKeyDown and IsMetaKeyDown())) then self:HighlightText() end
	end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	e:SetScript("OnTextChanged", function(self, userInput)
		if userInput and self:GetText() ~= self.psText then
			self:SetText(self.psText or "")
			self:HighlightText()
		end
	end)
	return e
end

-- Fill a copy box: its text, the cursor at its start. The same text again
-- changes nothing, so a selection the player made stays: in 0.3.7-rc1 a
-- report box clicked or Ctrl+A'd flashed its selection, then sat with the
-- cursor at the start (#1753). -> whether the text changed.
function W.SetCopyText(e, text)
	text = text or ""
	if e.psText == text and e:GetText() == text then return false end
	e.psText = text
	e:SetText(text)
	e:SetCursorPosition(0)
	return true
end

-- A copy box in focus with all its text selected, for Ctrl+C: now, and
-- again in the next frame, after the game has handled the click that got
-- here and laid out a box just shown inside a scroll view (the report
-- window's, #1753). The next frame leaves the focus alone when the player
-- has gone on to another edit box.
function W.SelectCopy(e)
	e:SetFocus()
	e:HighlightText()
	ns.After(0, function()
		if not e:IsVisible() then return end
		local focus = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
		if focus and focus ~= e then return end
		if not focus then e:SetFocus() end
		e:HighlightText()
	end)
end

-- The line shown with a copy box a "Copy" button selected: the game gives
-- addons no clipboard, so the button only selects, and the player copies.
function W.CopyHintText()
	if IsMacClient and IsMacClient() then return L["Selected: press Cmd+C to copy."] end
	return L["Selected: press Ctrl+C to copy."]
end

---------------------------------------------------------------------------
-- Scroll area: a ScrollFrame with a thin thumb strip. Wheel scrolls; the
-- thumb can be dragged.
---------------------------------------------------------------------------

local function scrollUpdate(sf)
	local view = sf.psView or sf:GetHeight()
	local content = sf.psContent or 0
	local range = max(0, content - view)
	local cur = min(range, max(0, sf:GetVerticalScroll()))
	if cur ~= sf:GetVerticalScroll() then sf:SetVerticalScroll(cur) end
	local bar = sf.Bar
	if range <= 0 or view <= 0 then
		bar:Hide()
		return
	end
	bar:Show()
	-- A game look's scroll bar keeps its arrow buttons at the ends
	-- (bar.psInset, Polestar_Looks/GameSkins.lua): the thumb runs between them.
	local inset = bar.psInset or 0
	local track = max(1, view - 2 * inset)
	local h = max(24, track * view / content)
	bar.Thumb:SetHeight(h)
	bar.Thumb:ClearAllPoints()
	bar.Thumb:SetPoint("TOPRIGHT", bar, "TOPRIGHT", 0, -(inset + (track - h) * (cur / range)))
end

local function scrollDrag(bar)
	local sf = bar.psScroll
	local _, y = GetCursorPosition()
	local scale = bar:GetEffectiveScale()
	local view = sf.psView or sf:GetHeight()
	local range = max(0, (sf.psContent or 0) - view)
	local h = bar.Thumb:GetHeight()
	local track = view - 2 * (bar.psInset or 0)
	if track - h <= 0 then return end
	local dy = (bar.psStartY - y / scale)
	sf:SetVerticalScroll(min(range, max(0, bar.psStartScroll + dy * range / (track - h))))
	scrollUpdate(sf)
end

function W.Scroll(parent)
	local sf = CreateFrame("ScrollFrame", nil, parent)
	local child = CreateFrame("Frame", nil, sf)
	child:SetSize(1, 1)
	sf:SetScrollChild(child)
	sf.Child = child
	sf:EnableMouseWheel(true)
	sf:SetScript("OnMouseWheel", function(self, delta)
		self:SetVerticalScroll(self:GetVerticalScroll() - delta * 60)
		scrollUpdate(self)
	end)
	sf:SetScript("OnSizeChanged", scrollUpdate)
	local bar = CreateFrame("Button", nil, sf)
	bar:SetWidth(6)
	bar:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, 0)
	bar:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -2, 0)
	bar.Thumb = bar:CreateTexture(nil, "OVERLAY")
	bar.Thumb:SetTexture(WHITE)
	bar.Thumb:SetWidth(2)
	bar.psScroll = sf
	bar.psThumb = bar.Thumb
	bar:SetScript("OnMouseDown", function(self)
		local _, y = GetCursorPosition()
		self.psStartY = y / self:GetEffectiveScale()
		self.psStartScroll = sf:GetVerticalScroll()
		self:SetScript("OnUpdate", ns.Safe(scrollDrag))
	end)
	bar:SetScript("OnMouseUp", function(self) self:SetScript("OnUpdate", nil) end)
	-- Escape can hide the window mid-drag, before any mouse-up arrives.
	bar:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
	-- The house thumb widens under the cursor; a game look's keeps its art.
	bar:SetScript("OnEnter", function(self) if not Theme.Kit() then self.Thumb:SetWidth(4) end end)
	bar:SetScript("OnLeave", function(self) if not Theme.Kit() then self.Thumb:SetWidth(2) end end)
	bar:Hide()
	sf.Bar = bar
	Theme.Skin(bar, "scrollbar")
	return sf
end

-- Scroll `child` itself (created with the scroll area as its parent) in
-- place of the area's own child frame: an edit box, the way the game's own
-- scrolling input boxes hold theirs. 0.3.7-rc1's report box, nested in the
-- area's child frame instead, took no click and no focus in the game (#1753).
function W.ScrollChild(sf, child)
	if sf.Child and sf.Child ~= child then sf.Child:Hide() end
	sf:SetScrollChild(child)
	sf.Child = child
	return child
end

-- Tell the scroll area its content and view heights (view nil = measured).
-- UpdateScrollChildRect has the client take the child's new size at once,
-- as the game's own scroll frames do after resizing theirs (#1753: the
-- report box, sized while its area was hidden, took no click in rc1); only
-- when the height changed, so an edit box scrolled in it keeps its
-- selection through a layout that changes nothing.
function W.SetScrollContent(sf, contentHeight, viewHeight)
	local resized = sf.psContent ~= contentHeight or not sf.psSized
	sf.psSized = true
	sf.psContent = contentHeight
	sf.psView = viewHeight
	sf.Child:SetHeight(max(1, contentHeight))
	if resized and sf.UpdateScrollChildRect then sf:UpdateScrollChildRect() end
	scrollUpdate(sf)
end

function W.ScrollTo(sf, offset)
	sf:SetVerticalScroll(max(0, offset or 0))
	scrollUpdate(sf)
end

---------------------------------------------------------------------------
-- The gold rim: a line of light along the top edge of a Polestar window,
-- clear at the corners, accent at 22 % and 78 % of the way, bright at the
-- centre, with a soft light thrown down from it. The house style alone: the
-- other skins draw their own frames.
---------------------------------------------------------------------------

-- The accent lifted toward white: the rim's bright centre (#f5d898 on
-- Polestar gold). -> r, g, b
function W.AccentHi()
	local r, g, b = Theme.Accent()
	return r + (1 - r) * 0.4, g + (1 - g) * 0.4, b + (1 - b) * 0.4
end

local RIM_EDGE, RIM_MID, RIM_HI = 0, 0.18, 0.9 -- alphas at 0, 22 % and 50 %
local RIM_OUTER = 0.22 -- the outer segment's share of the width
local THROW_H, THROW_A = 110, 0.1

local function gradient(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("HORIZONTAL", CreateColor(r1, g1, b1, a1), CreateColor(r2, g2, b2, a2))
	else
		t:SetVertexColor(r2, g2, b2, (a1 + a2) / 2)
	end
end
W.Gradient = gradient

local function layoutRim(rim)
	local w = rim.psOwner:GetWidth() or 0
	if w <= 0 then return end
	local inner = w * (0.5 - RIM_OUTER)
	rim.parts[2]:SetWidth(inner)
	rim.parts[3]:SetWidth(inner)
	local tw = rim.psWidth or w * 0.6
	local th = rim.psHeight or THROW_H
	rim:SetHeight(th)
	rim.Throw:SetSize(tw, th)
	rim.Throw:ClearAllPoints()
	rim.Throw:SetPoint("TOP", rim, "TOP", rim.psOffset or 0, 0)
end

local function paintRim(rim)
	local on = Theme.SkinKey() == "polestar" and not rim.psOwner.psBare and (not Theme.ShowsRim or Theme.ShowsRim())
	rim:SetShown(on)
	if not on then return end
	local px = Theme.Pixel(rim)
	local r, g, b = Theme.Accent()
	local hr, hg, hb = W.AccentHi()
	local p = rim.parts
	for i = 1, 4 do p[i]:SetHeight(px) end
	gradient(p[1], r, g, b, RIM_EDGE, r, g, b, RIM_MID)
	gradient(p[2], r, g, b, RIM_MID, hr, hg, hb, RIM_HI)
	gradient(p[3], hr, hg, hb, RIM_HI, r, g, b, RIM_MID)
	gradient(p[4], r, g, b, RIM_MID, r, g, b, RIM_EDGE)
	rim.Throw:SetVertexColor(hr, hg, hb, THROW_A)
	layoutRim(rim)
end

-- W.Rim(frame, opts) -> rim: the rim on `frame`'s top edge, over its
-- children (its own frame, mouse-transparent, levels above), repainted on
-- theme changes and hidden outside the house style or on a bare frame.
-- opts: { width = the thrown light's width (60 % of the frame's by default),
-- offset = its centre's x from the frame's centre (0), height = how far it
-- falls (110; less on a short window, so it stays inside) }.
-- rim.parts: the four line segments, left to right; rim.Throw: the light.
-- W.LayoutRim(frame) after resizing a frame whose size scripts do not run.
function W.Rim(frame, opts)
	opts = opts or {}
	local rim = rawget(frame, "psRim")
	if rim then
		rim.psWidth, rim.psOffset, rim.psHeight = opts.width, opts.offset, opts.height
		paintRim(rim)
		return rim
	end
	rim = CreateFrame("Frame", nil, frame)
	rim:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	rim:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	rim:SetHeight(opts.height or THROW_H)
	rim:SetFrameLevel(frame:GetFrameLevel() + 30)
	rim.psOwner, rim.psWidth, rim.psOffset, rim.psHeight = frame, opts.width, opts.offset, opts.height
	local p = {}
	for i = 1, 4 do
		p[i] = rim:CreateTexture(nil, "OVERLAY", nil, 7)
		p[i]:SetTexture(WHITE)
	end
	p[2]:SetPoint("TOPRIGHT", rim, "TOP", 0, 0)
	p[3]:SetPoint("TOPLEFT", rim, "TOP", 0, 0)
	p[1]:SetPoint("TOPLEFT", rim, "TOPLEFT", 0, 0)
	p[1]:SetPoint("TOPRIGHT", p[2], "TOPLEFT", 0, 0)
	p[4]:SetPoint("TOPLEFT", p[3], "TOPRIGHT", 0, 0)
	p[4]:SetPoint("TOPRIGHT", rim, "TOPRIGHT", 0, 0)
	rim.parts = p
	-- The light: the lower half of the glow, flattened under the line.
	rim.Throw = rim:CreateTexture(nil, "OVERLAY", nil, 6)
	rim.Throw:SetTexture(Theme.Media("glow"))
	rim.Throw:SetTexCoord(0, 1, 0.5, 1)
	frame.psRim = rim
	frame:HookScript("OnSizeChanged", function() layoutRim(rim) end)
	W.Painter(rim, paintRim)
	return rim
end

function W.LayoutRim(frame)
	local rim = rawget(frame, "psRim")
	if rim then layoutRim(rim) end
end

-- The night header's haze: the lower half of the glow, wide and flat, hung
-- from the top of `parent` (a header band) in the "haze" tint, over the band
-- and under the text. House style with the band on only.
-- opts: { width = (80 % of parent's), height = 120, offset = x from centre,
--         layer = "BACKGROUND", sub = -4 } -> the texture
function W.Haze(parent, opts)
	opts = opts or {}
	local t = parent:CreateTexture(nil, opts.layer or "BACKGROUND", nil, opts.sub or -4)
	t:SetTexture(Theme.Media("glow"))
	t:SetTexCoord(0, 1, 0.5, 1)
	t:SetPoint("TOP", parent, "TOP", opts.offset or 0, 0)
	W.Painter(t, function(tex)
		local w = opts.width
		if type(w) == "function" then w = w() end
		w = w or (parent:GetWidth() or 0) * 0.8
		tex:SetSize(math.max(1, w), opts.height or 120)
		tex:SetVertexColor(Theme.Color("haze"))
		tex:SetShown(Theme.SkinKey() == "polestar" and Theme.ShowsBand())
	end)
	return t
end

---------------------------------------------------------------------------
-- The shared confirm dialog: a scrim over the screen, a 400 wide box on the
-- window ground with its hairline and the rim, a title (an optional glyph
-- before it), the body text, and a footer band with Cancel and the action
-- (and an optional third choice at its left). Escape, Cancel or a click on
-- the scrim close it.
--   W.Modal({ title, text, icon = glyph, action = label, danger = true,
--             onAccept = fn, cancel = label, onCancel = fn,
--             alt = label, onAlt = fn }) -> the dialog
--   W.HideModal(), W.ModalShown()
---------------------------------------------------------------------------

local modal
local MODAL_W, MODAL_PAD, MODAL_FOOT, MODAL_SCRIM = 400, 24, 54, 0.55

function W.HideModal()
	if modal and modal:IsShown() then modal:Hide() end
end

function W.ModalShown()
	return modal ~= nil and modal:IsShown()
end

-- accept: true (the action), false (Cancel) or "alt" (the third choice).
local function closeModal(accept)
	local spec = modal.psSpec
	modal:Hide()
	local fn = spec and (accept == "alt" and spec.onAlt or accept == true and spec.onAccept or (not accept and spec.onCancel))
	if fn then fn() end
end

local function buildModal()
	local s = CreateFrame("Button", "PolestarModal", ns.UIParent)
	s:SetAllPoints(UIParent)
	s:SetFrameStrata("FULLSCREEN_DIALOG")
	s:EnableMouse(true)
	s:Hide()
	-- Its strength in the colour (W.Color's alpha, kept through theme
	-- changes), never SetAlpha: in the client a texture's alpha is its vertex
	-- colour's, so the repaint on a theme change made a SetAlpha'd scrim solid.
	s.Scrim = W.Color(W.Fill(s, "scrim", "BACKGROUND"), "scrim", MODAL_SCRIM)
	s:SetScript("OnClick", function() closeModal(false) end)
	local box = CreateFrame("Frame", nil, s)
	box:SetWidth(MODAL_W)
	box:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	box:EnableMouse(true)
	-- A window on the window skin (the Player's Frame Rule), opaque over the
	-- scrim; the game's looks give it the guide window's light frame (#1390).
	box.psLight, box.psBgAlpha = true, 1
	Theme.Skin(box, "window")
	s.Box = box
	box.Icon = W.Tex(box, "ARTWORK")
	box.Icon:SetSize(16, 16)
	box.Title = W.Text(box, "title", "text")
	box.Text = W.Text(box, "note", "textDim")
	box.Text:SetWordWrap(true)
	box.Text:SetSpacing(3)
	box.Text:SetJustifyV("TOP")
	box.Text:SetWidth(MODAL_W - 2 * MODAL_PAD)
	local foot = CreateFrame("Frame", nil, box)
	foot:SetPoint("BOTTOMLEFT", box, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", box, "BOTTOMRIGHT", 0, 0)
	foot:SetHeight(MODAL_FOOT)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	box.Foot = foot
	box.Action = W.Button(foot, "", function() closeModal(true) end)
	box.Action:SetPoint("RIGHT", foot, "RIGHT", -16, 0)
	box.Cancel = W.Button(foot, L["Cancel"], function() closeModal(false) end)
	box.Cancel:SetPoint("RIGHT", box.Action, "LEFT", -8, 0)
	box.Alt = W.Button(foot, "", function() closeModal("alt") end)
	box.Alt:SetPoint("LEFT", foot, "LEFT", 16, 0)
	box.Alt:Hide()
	W.Rim(box, { width = MODAL_W * 0.7 })
	-- Escape closes the dialog alone; every other key goes on to the game.
	box:EnableKeyboard(true)
	box:SetScript("OnKeyDown", function(self, key)
		local esc = key == "ESCAPE"
		if self.SetPropagateKeyboardInput and not (InCombatLockdown and InCombatLockdown()) then
			self:SetPropagateKeyboardInput(not esc)
		end
		if esc then closeModal(false) end
	end)
	s:HookScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	modal = s
end

function W.Modal(spec)
	if not modal then buildModal() end
	W.HideMenu()
	local box = modal.Box
	modal.psSpec = spec
	local x = MODAL_PAD
	box.Icon:SetShown(spec.icon ~= nil)
	if spec.icon then
		box.Icon:SetTexture(Theme.Media(spec.icon))
		W.Color(box.Icon, spec.danger and "danger" or "accent")
		box.Icon:ClearAllPoints()
		box.Icon:SetPoint("TOPLEFT", box, "TOPLEFT", MODAL_PAD, -(MODAL_PAD + 2))
		x = x + 16 + 10
	end
	box.Title:ClearAllPoints()
	box.Title:SetPoint("TOPLEFT", box, "TOPLEFT", x, -MODAL_PAD)
	box.Title:SetPoint("RIGHT", box, "RIGHT", -MODAL_PAD, 0)
	box.Title:SetText(spec.title or "")
	if box.Icon:IsShown() then
		box.Icon:ClearAllPoints()
		box.Icon:SetPoint("RIGHT", box.Title, "LEFT", -10, 0)
		box.Icon:SetPoint("TOP", box.Title, "TOP", 0, 0)
	end
	local th = math.ceil(box.Title:GetStringHeight())
	box.Text:ClearAllPoints()
	box.Text:SetPoint("TOPLEFT", box, "TOPLEFT", MODAL_PAD, -(MODAL_PAD + th + 8))
	box.Text:SetText(spec.text or "")
	box.Text:SetShown((spec.text or "") ~= "")
	local body = box.Text:IsShown() and math.ceil(box.Text:GetStringHeight()) + 8 or 0
	box:SetHeight(MODAL_PAD + th + body + 20 + MODAL_FOOT)
	local a = box.Action
	a.psDanger, a.psPrimary = spec.danger and true or false, not spec.danger
	W.SetButtonText(a, spec.action or L["OK"])
	W.RepaintButton(a)
	W.SetButtonText(box.Cancel, spec.cancel or L["Cancel"])
	box.Alt:SetShown(spec.alt ~= nil)
	if spec.alt then W.SetButtonText(box.Alt, spec.alt) end
	modal:Show()
	modal:Raise()
	return modal
end

---------------------------------------------------------------------------
-- The shell
---------------------------------------------------------------------------

local HOUSE_SHELL = {
	width = 960, height = 680, sidebar = 240, header = 112, tabs = 40, footer = 56, pad = 32,
	side = 24, -- the sidebar's left edge
	top = 152, -- header + tab band: where navigation and content begin
	rail = 88, -- the section rail of a hub shell (opts.rail): "Nachschlagen" fits
	brand = 69, -- a hub's brand block ends here: the rail's hairline starts below it
	foot = 23, -- the version line's bottom, level with the rail's foot label
}
-- The shell's sizes follow the skin (Theme.Metric; DIRECTION_B_HALO.md §3:
-- 930 x 690, a 200 sidebar, 32 tabs, the body 28 from the edge, a 56 foot).
-- A window takes them as it is built: one built before a skin change keeps
-- its sizes until the interface reloads.
local SHELL_METRIC = { width = "shellW", height = "shellH", sidebar = "shellSidebar", header = "shellHeader",
	tabs = "shellTabs", footer = "shellFooter", pad = "shellPad" }
local SHELL = setmetatable({}, {
	__index = function(_, k)
		if k == "top" then
			return Theme.Metric("shellHeader", HOUSE_SHELL.header) + Theme.Metric("shellTabs", HOUSE_SHELL.tabs)
		end
		local m = SHELL_METRIC[k]
		if m then return Theme.Metric(m, HOUSE_SHELL[k]) end
		return HOUSE_SHELL[k]
	end,
})
W.SHELL = SHELL

-- The sidebar status line: the version (memory is a developer's number; it
-- lives on About).
local function statusText()
	return L["Version"] .. " " .. tostring(ns.version or "dev")
end

-- The release stage (ns.stage, "Beta") as a warning chip beside the version,
-- or nothing once there is none. -> the chip's width (0 when hidden).
function W.SetStageChip(c)
	if not ns.stage then
		c:Hide()
		return 0
	end
	return W.SetChip(c, string.upper(L[ns.stage]), "warning")
end

-- The version line and its stage chip, kept inside the sidebar and clear of
-- the Discord mark at its end (UI/Report.lua, R.SidebarLink): "Version
-- 0.3.5", the number alone when that is too long (a preview's
-- "0.3.5-preview.2f100bfb3"), cut at the room left when even that is.
function W.ShellStatus(f)
	local status = f.Status
	local room = (f.psSidebar or SHELL.sidebar) - SHELL.side * 2
	local mark = rawget(f, "Discord")
	if mark and mark:IsShown() then
		local _, _, _, x = mark:GetPoint(1)
		room = (f.psSidebar or SHELL.sidebar) - SHELL.side + (x or 0) - mark:GetWidth() - 4
	end
	local chip = W.SetStageChip(f.Stage)
	if chip > 0 then room = room - chip - 8 end
	status:SetWidth(0)
	local text = statusText()
	if textWidth(status, text) > room then text = tostring(ns.version or "dev") end
	-- As wide as its text (cut at the room left), so the stage chip anchored
	-- to its right edge follows the text, never sits on it.
	status:SetWidth(math.max(1, math.min(room, math.ceil(textWidth(status, text)))))
end

-- Navigation rows in the sidebar, on the nav scroll area's child.
local NAV_ROW = 36
local function navButton(f, i)
	local b = f.navButtons[i]
	if b then return b end
	b = CreateFrame("Button", nil, f.NavScroll.Child)
	b:SetHeight(NAV_ROW)
	hoverTexture(b)
	-- The selected row: in the house style an accent wash fading out to the
	-- right (12 % to clear at 85 % of the row), elsewhere the selected wash.
	b.Selected = b:CreateTexture(nil, "BACKGROUND")
	b.Selected:SetTexture(WHITE)
	b.Selected:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Selected:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	W.Painter(b.Selected, function(t)
		local w = (f.psSidebar or SHELL.sidebar) - 1
		if Theme.SkinKey() == "polestar" then
			local r, g, bb = Theme.Accent()
			t:SetWidth(w * 0.85)
			gradient(t, r, g, bb, 0.12, r, g, bb, 0)
		else
			t:SetWidth(w)
			if t.SetGradient and CreateColor then
				local r, g, bb, a = Theme.Wash("selected")
				t:SetGradient("HORIZONTAL", CreateColor(r, g, bb, a), CreateColor(r, g, bb, a))
			else
				t:SetVertexColor(Theme.Wash("selected"))
			end
		end
	end)
	b.Bar = b:CreateTexture(nil, "ARTWORK")
	b.Bar:SetTexture(WHITE)
	b.Bar:SetWidth(2)
	b.Bar:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	W.Color(b.Bar, "accent")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetSize(16, 16)
	b.Icon:SetPoint("LEFT", b, "LEFT", SHELL.side, 0)
	b.Label = W.Text(b, "body", "textDim")
	-- Two lines at most: both fit the 36px row (13px type); past that it is
	-- cut. Its text is set on every ShellNav, so the cold-start blank of a
	-- max-lines string (W.Text) does not stick.
	b.Label:SetWordWrap(true)
	b.Label:SetMaxLines(2)
	b.Label:SetPoint("LEFT", b.Icon, "RIGHT", 12, 0)
	b.Count = W.Text(b, "number", "textMuted")
	b.Count:SetJustifyH("RIGHT")
	b.Count:SetPoint("RIGHT", b, "RIGHT", -SHELL.side, 0)
	-- A warning dot: something on that page needs the player's attention.
	b.Dot = b:CreateTexture(nil, "ARTWORK")
	b.Dot:SetTexture(Theme.Media("circle"))
	b.Dot:SetSize(6, 6)
	b.Dot:SetPoint("RIGHT", b, "RIGHT", -SHELL.side, 0)
	W.Color(b.Dot, "warning")
	b.Dot:Hide()
	-- A group's fold chevron (down open, right folded).
	b.Chevron = b:CreateTexture(nil, "ARTWORK")
	b.Chevron:SetSize(12, 12)
	b.Chevron:SetPoint("RIGHT", b, "RIGHT", -SHELL.side, 0)
	b.Chevron:Hide()
	-- New settings not seen yet: their count in an accent chip.
	b.New = W.Chip(b)
	b.New:SetPoint("RIGHT", b, "RIGHT", -SHELL.side + 4, 0)
	b.New:Hide()
	-- Settings off their default on that page: a small accent dot.
	b.Changed = W.Tex(b, "ARTWORK", "circle", "accent")
	b.Changed:SetSize(6, 6)
	b.Changed:Hide()
	b:SetScript("OnClick", function(self) if f.psOnNav and not self.psHeading then f.psOnNav(self.psKey) end end)
	f.navButtons[i] = b
	return b
end

-- items: { { key, label, icon, count, dot }, ... }; the active one is marked.
-- A row whose count is 0 recedes (no number, faded) but stays reachable; a
-- row with `dot` carries a warning dot at its right edge (no count then).
-- { heading = true, label } is a muted heading over the rows after it, at
-- the text edge, not a choice.
--
-- A tree: { group = true, key, label, folded } is a group's header (32px, a
-- muted label on the text edge, a chevron at the right: down open, right
-- folded), a choice that folds or opens it (onSelect(key)); rows with
-- `indent` sit under it, their glyph 12px further in. A row's `new` (a
-- number) is an accent chip at its right edge, `changed` a 6px accent dot
-- (settings off their default there) before that.
--
-- The rows live in their own scroll area, from 12px under the search down
-- to the line of the main column's footer bar (SHELL.footer from the
-- bottom), so the version and stage chip below it keep their band however
-- many rows there are: past that line the list scrolls (wheel, thumb) and
-- the active row is scrolled into view.
-- { separator = true } is a hairline between groups of rows, at the text
-- edges, not a row.
local NAV_SEP, NAV_GROUP, NAV_INDENT = 17, 32, 12

local function navRow(b, item, on)
	b.psKey = item.key
	local empty = item.count == 0
	b.Icon:SetTexture(Theme.Media(item.icon or "compact"))
	b.Icon:ClearAllPoints()
	b.Icon:SetPoint("LEFT", b, "LEFT", SHELL.side + (item.indent and NAV_INDENT or 0), 0)
	b.Label:SetText(item.label)
	b.Count:SetText(item.count or "")
	b.Count:SetShown(item.count ~= nil and not empty)
	b.Dot:SetShown(item.dot and true or false)
	if item.dot then b.Count:Hide() end
	local new = not item.dot and not item.group and type(item.new) == "number" and item.new > 0
	if new then
		W.SetChip(b.New, tostring(item.new), "accent")
		b.Count:Hide()
	else
		b.New:Hide()
	end
	-- The changed dot, left of whatever stands at the right edge.
	local edge = b.Dot:IsShown() and 6 or new and b.New:GetWidth() - 4 or b.Count:IsShown() and math.ceil(textWidth(b.Count)) or 0
	b.Changed:ClearAllPoints()
	b.Changed:SetPoint("RIGHT", b, "RIGHT", -(SHELL.side + (edge > 0 and edge + 8 or 0)), 0)
	b.Changed:SetShown(item.changed and not item.group and true or false)
	b.Chevron:SetShown(item.group and true or false)
	b.Selected:SetShown(on)
	b.Bar:SetShown(on)
	-- The game's looks mark the row with their own selection art.
	if Theme.KitRowLit(b, on, "navLit", 10) then
		b.Selected:Hide()
		b.Bar:Hide()
	end
	W.Color(b.Label, on and "text" or (empty and "textMuted" or "navRest"))
	W.Color(b.Icon, on and "accent" or (empty and "textMuted" or "textDim"))
	b:SetAlpha((empty and not on) and 0.55 or 1)
	b.psEmpty = empty
	b.psHeading = item.heading and true or false
	b.psGroup = item.group and true or false
	b.Icon:SetShown(not (item.heading or item.group))
	-- The label ends short of the count (or dot), as wide as that is, and
	-- takes a second line rather than run under it or off the sidebar.
	b.Label:ClearAllPoints()
	if item.heading or item.group then
		b.Label:SetPoint("LEFT", b, "LEFT", SHELL.side, 0)
		b.Label:SetPoint("RIGHT", b, "RIGHT", -(SHELL.side + (item.group and 20 or 0)), 0)
		W.Color(b.Label, "textMuted")
		b:SetAlpha(1)
		if item.group then
			b.Chevron:SetTexture(Theme.Media(item.folded and "chevron-right" or "chevron-down"))
			W.Color(b.Chevron, "textMuted")
			b:Enable()
		else
			b:Disable()
		end
	else
		local reserve = edge > 0 and edge + 8 or 0
		if b.Changed:IsShown() then reserve = reserve + 6 + 8 end
		b.Label:SetPoint("LEFT", b.Icon, "RIGHT", 12, 0)
		b.Label:SetPoint("RIGHT", b, "RIGHT", -(SHELL.side + reserve), 0)
		b:Enable()
	end
end

-- The tree's group headers are shorter than the rows.
local function navRowH(item)
	return item.group and NAV_GROUP or NAV_ROW
end

function W.ShellNav(f, items, active, onSelect)
	f.psOnNav = onSelect
	local sf = f.NavScroll
	local y, activeY = 0, nil
	local rules = rawget(f, "navRules") or {}
	f.navRules = rules
	local bi, ri = 0, 0
	for _, item in ipairs(items) do
		if item.separator then
			ri = ri + 1
			local t = rules[ri]
			if not t then
				t = W.Divider(sf.Child)
				rules[ri] = t
			end
			t:ClearAllPoints()
			t:SetPoint("TOPLEFT", sf.Child, "TOPLEFT", SHELL.side, -(y + 8))
			t:SetPoint("TOPRIGHT", sf.Child, "TOPRIGHT", -SHELL.side, -(y + 8))
			t:Show()
			y = y + NAV_SEP
		else
			bi = bi + 1
			local b = navButton(f, bi)
			local on = item.key == active
			navRow(b, item, on)
			b:ClearAllPoints()
			b:SetHeight(navRowH(item))
			b:SetPoint("TOPLEFT", sf.Child, "TOPLEFT", 0, -y)
			b:SetPoint("TOPRIGHT", sf.Child, "TOPRIGHT", 0, -y)
			b:Show()
			if on then activeY = y end
			y = y + navRowH(item)
		end
	end
	for i = bi + 1, #f.navButtons do f.navButtons[i]:Hide() end
	for i = ri + 1, #rules do rules[i]:Hide() end
	local view = W.ShellNavHeight(f)
	sf.Child:SetWidth((f.psSidebar or SHELL.sidebar) - 1)
	W.SetScrollContent(sf, y, view)
	-- A new selection is scrolled into view; a redraw with the same one (a
	-- refresh, a guide picked in the list) keeps the place the player
	-- scrolled to, a community guide's entry far down the list included.
	if activeY and active ~= sf.psActive then
		local cur = sf:GetVerticalScroll()
		if activeY < cur then
			W.ScrollTo(sf, activeY)
		elseif activeY + NAV_ROW > cur + view then
			W.ScrollTo(sf, activeY + NAV_ROW - view)
		end
	end
	sf.psActive = active
end

-- The height the navigation rows may fill: from their top line to the
-- footer bar's line.
function W.ShellNavHeight(f)
	return f:GetHeight() - 2 - f.psNavTop - SHELL.footer
end

local function shellTab(f, i)
	local t = f.tabButtons[i]
	if t then return t end
	t = CreateFrame("Button", nil, f.TabRow)
	t:SetHeight(SHELL.tabs)
	t.Label = W.Text(t, "label", "textDim")
	t.Label:SetPoint("CENTER", t, "CENTER", 0, 0)
	Theme.Skin(t, "tab")
	t:SetScript("OnClick", function(self) if f.psOnTab then f.psOnTab(self.psKey) end end)
	f.tabButtons[i] = t
	return t
end

-- Where the body runs: from under the tab row (or the header without one) to
-- the footer bar, or through its place to the bottom when there is none (a
-- hidden footer still marks the column's width). A pinned preview
-- (W.ShellPreview) takes the top of that place, the scroll area the rest.
local function layoutBody(f)
	local tabs, foot = f.TabRow:IsShown(), f.Footer:IsShown()
	f.Content:ClearAllPoints()
	f.Content:SetPoint("TOPLEFT", tabs and f.TabRow or f.Header, "BOTTOMLEFT", 0, 0)
	f.Content:SetPoint("BOTTOMRIGHT", f.Footer, foot and "TOPRIGHT" or "BOTTOMRIGHT", 0, 0)
	local ph = f.psPreviewH or 0
	local slot = rawget(f, "PreviewSlot")
	if slot then
		slot:ClearAllPoints()
		slot:SetPoint("TOPLEFT", f.Content, "TOPLEFT", 0, 0)
		slot:SetPoint("TOPRIGHT", f.Content, "TOPRIGHT", 0, 0)
		slot:SetHeight(max(1, ph))
		slot:SetShown(ph > 0)
		f.Scroll:ClearAllPoints()
		f.Scroll:SetPoint("TOPLEFT", f.Content, "TOPLEFT", 0, -(4 + ph))
		f.Scroll:SetPoint("BOTTOMRIGHT", f.Content, "BOTTOMRIGHT", -4, 4)
	end
	f.psViewH = f:GetHeight() - SHELL.header - (tabs and SHELL.tabs or 0) - (foot and SHELL.footer or 0) - ph
end

-- The pinned preview's slot, between the tab band and the scrolling body
-- (made on first use): previews are built as its children.
function W.ShellPreviewSlot(f)
	local slot = rawget(f, "PreviewSlot")
	if slot then return slot end
	slot = CreateFrame("Frame", nil, f.Main)
	if slot.SetClipsChildren then slot:SetClipsChildren(true) end
	slot.Rule = W.Divider(slot)
	slot.Rule:SetPoint("BOTTOMLEFT", slot, "BOTTOMLEFT", 0, 0)
	slot.Rule:SetPoint("BOTTOMRIGHT", slot, "BOTTOMRIGHT", 0, 0)
	slot:Hide()
	f.PreviewSlot = slot
	return slot
end

-- The pinned preview: `host` (a child of W.ShellPreviewSlot(f); nil for
-- none) shown `height` tall across the main column, a hairline under it;
-- the body lays out under it and scrolls under it, not it. Called again
-- with another height (the preview grew), the body re-anchors and keeps the
-- rows the player scrolled to on screen.
function W.ShellPreview(f, host, height)
	if not host and not rawget(f, "PreviewSlot") then return end
	local slot = W.ShellPreviewSlot(f)
	local old = rawget(slot, "psHost")
	if old and old ~= host then old:Hide() end
	slot.psHost = host
	local h = host and max(0, floor((height or 0) + 0.5)) or 0
	local was = f.psPreviewH or 0
	f.psPreviewH = h
	if host then
		host:ClearAllPoints()
		host:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, 0)
		host:SetPoint("TOPRIGHT", slot, "TOPRIGHT", 0, 0)
		host:SetHeight(max(1, h))
		host:Show()
	end
	layoutBody(f)
	if h ~= was and old == host then
		local cur = f.Scroll:GetVerticalScroll()
		if cur > 0 then f.Scroll:SetVerticalScroll(max(0, cur + h - was)) end
	end
	W.SetScrollContent(f.Scroll, f.Scroll.psContent or 0, f.psViewH)
end

-- tabs: { { key, label }, ... } or nil (no tab row; the body moves up). A
-- single tab is no choice: its row is left out too.
function W.ShellTabs(f, tabs, active, onSelect)
	f.psOnTab = onSelect
	local n = tabs and #tabs or 0
	if n == 1 and not f.psKeepOneTab then n = 0 end
	local x = SHELL.pad - 12
	for i = 1, n do
		local t = shellTab(f, i)
		t.psKey = tabs[i].key
		t.Label:SetText(tabs[i].label)
		local on = tabs[i].key == active
		Theme.SetTabSelected(t, on)
		-- The game's looks: MinimalTabTemplate, its small label on the art,
		-- the tab 40 wider than it; the house tab 24 wider, its label centred.
		local kit = Theme.KitTab(t, on, t.Label)
		if not kit then
			t.Label:ClearAllPoints()
			t.Label:SetPoint("CENTER", t, "CENTER", 0, 0)
		end
		Theme.Font(t.Label, kit and "small" or "label")
		t:SetWidth(floor(t.Label:GetStringWidth() + (kit and 40 or 24) + 0.5))
		W.Color(t.Label, on and "text" or (kit and "tabRest" or "textDim"))
		t:ClearAllPoints()
		t:SetPoint("BOTTOMLEFT", f.TabRow, "BOTTOMLEFT", x, 0)
		t:Show()
		x = x + t:GetWidth() + 4
	end
	for i = n + 1, #f.tabButtons do f.tabButtons[i]:Hide() end
	f.TabRow:SetShown(n > 0 or f.psKeepTabRow and true or false)
	layoutBody(f)
end

-- Footer buttons: left and right lists of { label, onClick, opts }.
-- opts.confirm: a second click acts; opts.ghost: a borderless button (its
-- glyph on the content edge when first on the left). Buttons are reused
-- per position and kind.
local function footerButton(f, side, i, ghost)
	local list = f.footerButtons[side]
	local b = list[i]
	if b and (b.psGhost and true or false) == ghost then return b end
	if b then b:Hide() end
	b = W.Button(f.Footer, "", nil, { ghost = ghost })
	b.psTight = ghost or nil
	b.psSetText = W.SetButtonText
	list[i] = b
	return b
end

-- Without any button the footer bar goes and the body runs to the bottom.
function W.ShellFooter(f, left, right)
	f.Footer:SetShown(#(left or {}) + #(right or {}) > 0)
	layoutBody(f)
	for _, side in ipairs({ "left", "right" }) do
		local specs
		if side == "left" then specs = left or {} else specs = right or {} end
		local list = f.footerButtons[side]
		local prev
		for i, spec in ipairs(specs) do
			local ghost = spec.opts and spec.opts.ghost and true or false
			local b = footerButton(f, side, i, ghost)
			b.psPrimary = spec.opts and spec.opts.primary
			b.psArmed = nil
			if spec.opts and spec.opts.icon then
				if not rawget(b, "Icon") then
					b.Icon = b:CreateTexture(nil, "ARTWORK")
					b.Icon:SetSize(13, 13)
				end
				b.Icon:SetTexture(Theme.Media(spec.opts.icon))
				b.Icon:Show()
			elseif rawget(b, "Icon") then
				b.Icon:Hide()
				b.Icon = nil
			end
			W.SetButtonText(b, spec.label)
			if spec.opts and spec.opts.confirm then
				W.Confirm(b, spec.label, spec.onClick)
			else
				b:SetScript("OnClick", spec.onClick)
			end
			Theme.Repaint(b)
			W.RepaintButton(b)
			b:ClearAllPoints()
			if side == "left" then
				if prev then b:SetPoint("LEFT", prev, "RIGHT", 8, 0) else b:SetPoint("LEFT", f.Footer, "LEFT", SHELL.pad - (ghost and 8 or 0), 0) end
			else
				if prev then b:SetPoint("RIGHT", prev, "LEFT", -8, 0) else b:SetPoint("RIGHT", f.Footer, "RIGHT", -SHELL.pad, 0) end
			end
			b:Show()
			prev = b
		end
		for i = #specs + 1, #list do list[i]:Hide() end
	end
end

-- Re-run a button's paint (after toggling psPrimary).
function W.RepaintButton(b)
	local fn = painters[b]
	if fn then
		if not b.psPrimary then W.Color(b.Label, b.psDanger and "danger" or (b.psGhost and "textDim" or "text")) end
		fn(b)
	end
end

-- The page subtitle: at most two lines, in a box of 32px (two lines of the
-- note role in any font, short of a third). Its top sits at 66 (the title's
-- foot at 58, 8px gap), its foot at 98, 14px above the tab row.
local SUBTITLE_LINES, SUBTITLE_H = 2, 32
local ELLIPSIS = "\226\128\166"

-- Set `text` on a wrapping string bound in width; past `lines` lines, the
-- last words give way to an ellipsis.
local function fitLines(fs, text, lines)
	fs:SetText(text)
	if fs:GetNumLines() <= lines then return end
	local words = {}
	for w in text:gmatch("%S+") do words[#words + 1] = w end
	for k = #words - 1, 1, -1 do
		fs:SetText(table.concat(words, " ", 1, k):gsub("[,;:%.%s]+$", "") .. ELLIPSIS)
		if fs:GetNumLines() <= lines then return end
	end
end

-- The window's scale in its header, left of the close button (or on the
-- main column's pad where the frame's own close button stands): its label,
-- a small track and the value. The value follows the drag; the window
-- rescales when it ends (the slider sits in what it scales), the wheel
-- steps it. -> the control (control:Place() after the close button comes
-- or goes).
local SCALE_TRACK, SCALE_LO, SCALE_HI, SCALE_STEP = 64, 0.7, 1.4, 0.05
local function scaleText(v) return floor(v * 100 + 0.5) .. "%" end

function W.HeaderScale(f, path)
	local head = f.Header
	local t = CreateFrame("Frame", nil, head)
	t:SetHeight(20)
	t.Label = W.Text(t, "small", "textMuted")
	t.Label:SetText(L["Menu scale"])
	t.Value = W.Text(t, "number", "textDim")
	t.Value:SetJustifyH("RIGHT")
	local s = sliderParts(t, t, SCALE_TRACK)
	s:SetMinMaxValues(SCALE_LO, SCALE_HI)
	s:SetValueStep(SCALE_STEP)
	t.Thumb:SetSize(9, 9)
	local function paint(v)
		v = v or s:GetValue()
		t.Fill:SetWidth(max(0.01, SCALE_TRACK * (v - SCALE_LO) / (SCALE_HI - SCALE_LO)))
		t.Value:SetText(scaleText(v))
	end
	function t.Refresh()
		local v = ns.Get(path)
		if type(v) ~= "number" then v = 1 end
		t.psRefreshing = true
		s:SetValue(min(SCALE_HI, max(SCALE_LO, v)))
		t.psRefreshing = false
		paint()
	end
	function t.Place()
		local vw = math.ceil(max(textWidth(t.Value, scaleText(SCALE_HI)), textWidth(t.Value, scaleText(1))))
		paint()
		t.Value:SetWidth(vw)
		t.Value:ClearAllPoints()
		t.Value:SetPoint("RIGHT", t, "RIGHT", 0, 0)
		s:ClearAllPoints()
		s:SetPoint("RIGHT", t.Value, "LEFT", -10, 0)
		t.Label:ClearAllPoints()
		t.Label:SetPoint("RIGHT", s, "LEFT", -10, 0)
		t:SetWidth(math.ceil(textWidth(t.Label)) + 10 + SCALE_TRACK + 10 + vw)
		t:ClearAllPoints()
		-- Where the close button has left the header (the hub's details pane
		-- holds it) the header is too narrow for it: the scale stays under
		-- Settings, Theme, Frames.
		local inHeader = f.Close:GetParent() == head
		t:SetShown(inHeader or not f.Close:IsShown())
		if f.Close:IsShown() and inHeader then
			t:SetPoint("RIGHT", f.Close, "LEFT", -14, 0)
		else
			t:SetPoint("TOPRIGHT", head, "TOPRIGHT", -SHELL.pad, -16)
		end
		-- More tools (W.ShellHeaderTools: the settings search) right to left
		-- before it; the title ends short of the last.
		local left = t:IsShown() and t or nil
		for _, w in ipairs(rawget(f, "psHeadTools") or {}) do
			if w:IsShown() then
				w:ClearAllPoints()
				if left then
					w:SetPoint("RIGHT", left, "LEFT", -16, 0)
				elseif f.Close:IsShown() and inHeader then
					w:SetPoint("RIGHT", f.Close, "LEFT", -14, 0)
				else
					w:SetPoint("RIGHT", head, "TOPRIGHT", -SHELL.pad, -26)
				end
				left = w
			end
		end
		if left and left ~= t then
			local edge = 16
			for _, w in ipairs(f.psHeadTools) do if w:IsShown() then edge = edge + 16 + w:GetWidth() end end
			edge = edge + (t:IsShown() and t:GetWidth() or 0) + ((f.Close:IsShown() and inHeader) and (12 + 28 + 14) or (SHELL.pad + 16))
			f.Title:SetPoint("TOPRIGHT", head, "TOPRIGHT", -edge, -32)
		elseif t:IsShown() then
			f.Title:SetPoint("TOPRIGHT", t, "TOPLEFT", -16, -16)
		else
			f.Title:SetPoint("TOPRIGHT", head, "TOPRIGHT", -(12 + 28 + 12), -32)
		end
	end
	W.Painter(t.Track, function(tex) tex:SetHeight(3); tex:SetVertexColor(Theme.Wash("track")) end)
	W.Painter(t.Fill, function(tex) tex:SetHeight(3); tex:SetVertexColor(Theme.Accent()) end)
	W.Painter(t.Thumb, function(tex) tex:SetVertexColor(Theme.Color("text")) end)
	s:SetScript("OnValueChanged", function(_, v, userInput)
		v = roundTo(v, SCALE_STEP)
		paint(v)
		if userInput and not t.psRefreshing then t.psPending = v end
	end)
	s:SetScript("OnMouseUp", function(_, button)
		local v = t.psPending
		t.psPending = nil
		if button == "RightButton" then
			ns.Set(path, nil)
		elseif v ~= nil and ns.Get(path) ~= v then
			ns.Set(path, v)
		end
	end)
	s:SetScript("OnMouseWheel", function(_, delta)
		local v = roundTo((ns.Get(path) or 1) + delta * SCALE_STEP, SCALE_STEP)
		ns.Set(path, min(SCALE_HI, max(SCALE_LO, v)))
	end)
	s.psTip = L["Menu scale"]
	s.psTipLines = { L["The guide menu and this window; applies when you let go. Right-click to reset."] }
	s:SetScript("OnEnter", simpleTip)
	s:SetScript("OnLeave", hideTip)
	ns.On("SETTING_CHANGED", function(p)
		if p == path or p == "" or p == "ui" or p == nil then t.Refresh() end
	end)
	t.Place()
	t.Refresh()
	return t
end

-- The header search's width: 30 % of the main column, 180 to 320.
local function headerSearchW(f)
	return floor(min(320, max(180, (f.psMainW or 600) * 0.3)))
end

-- opts: { width, height, title, subtitle, searchPlaceholder, onSearch,
--         scalePath = "ui.menuScale" (the window's scale setting) }
--
-- The grid every shell shares, top down: the header band (0-112: brand in
-- the sidebar, page title in the main column), the tab band (112-152: the
-- search in the sidebar, the tabs in the main column), then one hairline
-- across both columns at 152 where navigation and content begin. Left edges:
-- 24 in the sidebar, 32 in the main column.
--
-- opts.sidebar: the sidebar's width (SHELL.sidebar by default).
-- opts.rail: a section rail (SHELL.rail wide) left of the sidebar, for a
-- hub of several sections (W.ShellRail); the emblem moves into it and the
-- window grows by the rail's width.
-- opts.headerSearch: the search sits in the header, left of the scale
-- (the settings window), and the navigation starts under the band.
-- opts.tagline: the line under the wordmark ("A community project"; the
-- settings window, a window of its own beside the hub: "Settings").
-- opts.resizable = { minW, minH, onResized = fn(w, h), onReset = fn() }: a
-- grip in the bottom-right corner sizes the window (right-click: onReset);
-- the shell lays itself out anew as it goes (W.ShellLayout), the caller
-- when it ends (onResized).
function W.Shell(name, opts)
	opts = opts or {}
	local RAIL = opts.rail and SHELL.rail or 0
	local Wd, Hd = opts.width or (SHELL.width + RAIL), opts.height or SHELL.height
	local SB = opts.sidebar or SHELL.sidebar
	local f = CreateFrame("Frame", name, ns.UIParent)
	f.psSidebar = SB
	f:SetSize(Wd, Hd)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	f:SetFrameStrata("HIGH")
	f:SetToplevel(true)
	f:SetClampedToScreen(true)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:Hide()
	Theme.Skin(f, "window")
	f.navButtons, f.tabButtons, f.footerButtons, f.railButtons = {}, {}, { left = {}, right = {} }, {}
	f.psRail = RAIL

	local function draggable(frame)
		frame:EnableMouse(true)
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function() f:StartMoving() end)
		frame:SetScript("OnDragStop", function() f:StopMovingOrSizing() end)
	end

	-- The section rail: the emblem on the title's line, then one button per
	-- section from the content line down, and its bottom items.
	if RAIL > 0 then
		local rail = CreateFrame("Frame", nil, f)
		rail:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
		rail:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		rail:SetWidth(RAIL)
		Theme.Skin(rail, "sidebar")
		draggable(rail)
		f.Rail = rail
		-- A hairline parts the rail from the sidebar below the brand.
		local railRule = W.Divider(rail, true)
		railRule:SetPoint("TOPRIGHT", rail, "TOPRIGHT", 0, -SHELL.brand)
		railRule:SetPoint("BOTTOMRIGHT", rail, "BOTTOMRIGHT", 0, 0)
	end

	-- Sidebar: brand, search, navigation, status at the bottom.
	local side = CreateFrame("Frame", nil, f)
	side:SetPoint("TOPLEFT", f, "TOPLEFT", 1 + RAIL, -1)
	side:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1 + RAIL, 1)
	side:SetWidth(SB)
	Theme.Skin(side, "sidebar")
	draggable(side)
	f.Sidebar = side
	local rule = W.Divider(side, true)
	rule:SetPoint("TOPRIGHT", side, "TOPRIGHT", 0, 0)
	rule:SetPoint("BOTTOMRIGHT", side, "BOTTOMRIGHT", 0, 0)

	-- The sidebar's own rhythm, one compact block from the top: the lockup
	-- (emblem, wordmark, and "A community project" under the wordmark)
	-- centred on the page title's line (centre y 47); the search under it,
	-- its foot on the band's 112 line; the navigation 12px under the search.
	-- Wordmark, tagline, search and navigation share the 24 edge. With a rail
	-- the emblem heads the rail column, centred like the section glyphs under
	-- it; without one it stands left of the wordmark, its ink on the 24 edge.
	-- Placed by their ink, not their texture boxes: the small wordmark's
	-- glyphs start 2px into its box and fill rows 7-24 of its 32
	-- (Media/UI/wordmark-small.tga, drawn 1:1); the emblem's ink starts 6px
	-- into its 44px box and is 32px wide (emblem.tga).
	local WORD_INK, WORD_TOP, EMBLEM, EMBLEM_INK, EMBLEM_INK_W = 2, 22, 44, 6, 32
	local railFrame = rawget(f, "Rail")
	f.Emblem = W.Tex(railFrame or side, "ARTWORK", "emblem", "accent")
	f.Emblem:SetSize(EMBLEM, EMBLEM)
	local textX = SHELL.side
	if railFrame then
		f.Emblem:SetPoint("TOP", railFrame, "TOP", 0, -(47 - EMBLEM / 2))
	else
		f.Emblem:SetPoint("TOPLEFT", side, "TOPLEFT", SHELL.side - EMBLEM_INK, -(47 - EMBLEM / 2))
		-- 12px of air between the emblem's ink and the wordmark's.
		textX = SHELL.side + EMBLEM_INK_W + 12
	end
	-- As on the website and the app icon: the gold star's bright centre over
	-- it (emblem-hot.tga, the same box) and a soft accent glow behind it.
	local emblemParent = railFrame or side
	f.Emblem.Hot = W.Tex(emblemParent, "OVERLAY", "emblem-hot")
	f.Emblem.Hot:SetAllPoints(f.Emblem)
	f.Emblem.Hot:SetVertexColor(1, 0.93, 0.76)
	f.Emblem.Glow = W.Tex(emblemParent, "BORDER", "glow")
	f.Emblem.Glow:SetSize(EMBLEM * 2, EMBLEM * 2)
	f.Emblem.Glow:SetPoint("CENTER", f.Emblem, "CENTER", 0, 0)
	W.Painter(f.Emblem.Glow, function(t) local r, g, b = Theme.Accent(); t:SetVertexColor(r, g, b, 0.22) end)
	f.Wordmark = W.Tex(side, "ARTWORK", "wordmark-small", "text")
	f.Wordmark:SetSize(256, 32)
	f.Wordmark:SetPoint("TOPLEFT", side, "TOPLEFT", textX - WORD_INK, -WORD_TOP)
	f.Tagline = W.Text(side, "small", "textDim")
	f.Tagline:SetPoint("TOPLEFT", side, "TOPLEFT", textX, -(WORD_TOP + 30))
	f.Tagline:SetText(opts.tagline or L["A community project"])
	if opts.headerSearch then
		-- The search is in the header (below); the navigation starts under
		-- the band, a hairline over it.
		f.psNavTop = SHELL.header + 12
		local bandRule = W.Divider(side)
		bandRule:SetPoint("TOPLEFT", side, "TOPLEFT", 0, -SHELL.header)
		bandRule:SetPoint("TOPRIGHT", side, "TOPRIGHT", -1, -SHELL.header)
	else
		local searchTop = SHELL.header - 30
		f.Search = W.SearchBox(side, opts.searchPlaceholder or L["Search"], opts.onSearch)
		f.Search:SetPoint("TOPLEFT", side, "TOPLEFT", SHELL.side, -searchTop)
		f.Search:SetPoint("TOPRIGHT", side, "TOPRIGHT", -SHELL.side, -searchTop)
		f.psNavTop = searchTop + 30 + 12
	end
	-- The navigation: its own scroll area, ending on the footer bar's line
	-- (W.ShellNav), so the version band below it is never crowded.
	f.NavScroll = W.Scroll(side)
	f.NavScroll:SetPoint("TOPLEFT", side, "TOPLEFT", 0, -f.psNavTop)
	f.NavScroll:SetPoint("BOTTOMRIGHT", side, "BOTTOMRIGHT", -1, SHELL.footer)
	f.NavScroll.Child:SetWidth(SB - 1)

	-- The version, on the line of the rail's foot label (Options) when there
	-- is a rail, and the release stage's chip after it while there is one.
	f.Status = W.Text(side, "small", "textMuted")
	f.Status:SetPoint("BOTTOMLEFT", side, "BOTTOMLEFT", SHELL.side, SHELL.foot)
	f.Stage = W.Chip(side)
	f.Stage:SetPoint("LEFT", f.Status, "RIGHT", 8, 0)

	-- Header band: the night sky, cropped to fit, never stretched.
	local main = CreateFrame("Frame", nil, f)
	main:SetPoint("TOPLEFT", side, "TOPRIGHT", 0, 0)
	main:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
	f.Main = main
	local head = CreateFrame("Frame", nil, main)
	head:SetPoint("TOPLEFT", main, "TOPLEFT", 0, 0)
	head:SetPoint("TOPRIGHT", main, "TOPRIGHT", 0, 0)
	head:SetHeight(SHELL.header)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() f:StartMoving() end)
	head:SetScript("OnDragStop", function() f:StopMovingOrSizing() end)
	f.Header = head
	f.Band = Theme.Band(head, "BACKGROUND", -5)
	f.Band:SetAllPoints(head)
	f.psMainW = Wd - RAIL - SB - 2
	f.Band:SetTexCoord(Theme.BandCoords(f.psMainW, SHELL.header))
	-- The night: a faint blue haze over the band (house style, band on).
	f.Haze = W.Haze(head, { width = function() return f.psMainW * 0.9 end, height = SHELL.header })
	f.Title = W.Text(head, "hero", "text")
	f.Title:SetPoint("TOPLEFT", head, "TOPLEFT", SHELL.pad, -32)
	-- Clear of the close button (28px, 12px in, 12px gap), or of the scale
	-- control left of it: a long title (a guide pack's) ends in an ellipsis.
	f.Title:SetPoint("TOPRIGHT", head, "TOPRIGHT", -(12 + 28 + 12), -32)
	-- The subtitle: up to two lines between the pads, under the close button
	-- and clear of it, cut with an ellipsis after the second (W.ShellTitle).
	f.Subtitle = W.Text(head, "note", "textDim")
	f.Subtitle:SetPoint("TOPLEFT", f.Title, "BOTTOMLEFT", 0, -8)
	f.Subtitle:SetHeight(SUBTITLE_H)
	f.Subtitle:SetWordWrap(true)
	f.Subtitle:SetJustifyV("TOP")
	f.Subtitle:SetSpacing(2)
	f.Close = W.IconButton(head, "close", 28, L["Close"], function() f:Hide() end, 14)
	f.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -12)
	-- The game's looks put the close button on the window frame's corner.
	f.Close:SetShown(not Theme.Kit())
	Theme.OnChanged(function()
		f.Close:SetShown(not Theme.Kit())
		if rawget(f, "HeaderTools") then f.HeaderTools:Place() end
	end)
	-- The window frame's own close button (the game's looks) stands for this
	-- one: paint again now that it exists.
	Theme.Repaint(f)
	if opts.scalePath then
		f.HeaderTools = W.HeaderScale(f, opts.scalePath)
		f.Title:SetPoint("TOPRIGHT", f.HeaderTools, "TOPLEFT", -16, -16)
	end
	-- The settings search in the header, left of the scale.
	if opts.headerSearch then
		f.Search = W.SearchBox(head, opts.searchPlaceholder or L["Search"], opts.onSearch)
		f.Search:SetWidth(headerSearchW(f))
		f.psHeadTools = { f.Search }
		if rawget(f, "HeaderTools") then
			f.HeaderTools.Place()
		else
			f.Search:SetPoint("RIGHT", f.Close, "LEFT", -14, 0)
		end
	end
	-- The gold rim along the window's top, its light thrown under the
	-- main column (f.Rim: the settings' Theme page lights it).
	f.Rim = W.Rim(f, { offset = Wd * 0.1 })

	-- Tab row: tabs sit on its bottom hairline.
	f.TabRow = CreateFrame("Frame", nil, main)
	f.TabRow:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, 0)
	f.TabRow:SetPoint("TOPRIGHT", head, "BOTTOMRIGHT", 0, 0)
	f.TabRow:SetHeight(SHELL.tabs)
	local tabRule = W.Divider(f.TabRow)
	tabRule:SetPoint("BOTTOMLEFT", f.TabRow, "BOTTOMLEFT", 0, 0)
	tabRule:SetPoint("BOTTOMRIGHT", f.TabRow, "BOTTOMRIGHT", 0, 0)

	-- Footer bar.
	f.Footer = CreateFrame("Frame", nil, main)
	f.Footer:SetPoint("BOTTOMLEFT", main, "BOTTOMLEFT", 0, 0)
	f.Footer:SetPoint("BOTTOMRIGHT", main, "BOTTOMRIGHT", 0, 0)
	f.Footer:SetHeight(SHELL.footer)
	W.Fill(f.Footer, "footer")
	local footRule = W.Divider(f.Footer)
	footRule:SetPoint("TOPLEFT", f.Footer, "TOPLEFT", 0, 0)
	footRule:SetPoint("TOPRIGHT", f.Footer, "TOPRIGHT", 0, 0)

	-- Body: a scrolling column. The emblem engraving shows only behind an
	-- empty state (W.ShellWatermark), never behind content.
	f.Content = CreateFrame("Frame", nil, main)
	f.Watermark = f.Content:CreateTexture(nil, "BACKGROUND", nil, -4)
	f.Watermark:SetTexture(Theme.Media("watermark"))
	f.Watermark:SetSize(300, 300)
	f.Watermark:SetPoint("CENTER", f.Content, "CENTER", 0, 0)
	W.Painter(f.Watermark, function(t) t:SetVertexColor(Theme.Wash("watermark")) end)
	f.Watermark:Hide()
	f.Scroll = W.Scroll(f.Content)
	f.Scroll:SetPoint("TOPLEFT", f.Content, "TOPLEFT", 0, -4)
	f.Scroll:SetPoint("BOTTOMRIGHT", f.Content, "BOTTOMRIGHT", -4, 4)
	f.Body = f.Scroll.Child
	f.BodyWidth = Wd - RAIL - SB - 2 - SHELL.pad * 2
	W.ShellTitle(f, opts.title, opts.subtitle)
	-- Refit the subtitle in a new font.
	W.Painter(f.Subtitle, function(fs) fitLines(fs, f.psSubtitle or "", SUBTITLE_LINES) end)
	W.ShellTabs(f, nil)

	-- A grip in the corner sizes the window; right-click: its default size.
	if opts.resizable then
		local R = opts.resizable
		f:SetResizable(true)
		local grip = W.IconButton(f, "resize", 16, L["Drag to resize"], nil, 12)
		grip:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
		grip:SetFrameLevel(f:GetFrameLevel() + 40)
		grip.psTipLines = { L["Right-click: the default size."] }
		grip:RegisterForClicks("RightButtonUp")
		grip:SetScript("OnMouseDown", function(_, button)
			if button ~= "LeftButton" then return end
			f.psSizing = true
			f:StartSizing("BOTTOMRIGHT")
		end)
		grip:SetScript("OnMouseUp", function(_, button)
			if button ~= "LeftButton" or not f.psSizing then return end
			f.psSizing = nil
			f:StopMovingOrSizing()
			W.ShellLayout(f)
			if R.onResized then R.onResized(f:GetWidth(), f:GetHeight()) end
		end)
		grip:SetScript("OnClick", function(_, button)
			if button == "RightButton" and R.onReset then R.onReset() end
		end)
		-- Only the frame follows the drag; the page lays out when it ends.
		f:HookScript("OnSizeChanged", function(self) if self.psSizing then W.ShellLayout(self) end end)
		f.Grip = grip
	end

	if opts.scalePath then
		local function applyScale()
			f:SetScale(ns.Get(opts.scalePath) or 1)
			if f:IsShown() then Theme.RetextLater(f) end
		end
		applyScale()
		ns.On("SETTING_CHANGED", function(path)
			if path == opts.scalePath or path == "" or path == "ui" then applyScale() end
		end)
	end
	-- Every string the window shows is set again a frame later
	-- (Theme.RetextLater): on a fresh start some drew blank.
	f:HookScript("OnShow", function(self)
		W.ShellStatus(self)
		Theme.RetextLater(self)
		Anim.To(self, "alpha", 0, 1, Anim.FAST, "out")
	end)
	-- Another font measures the version line anew.
	W.OnFontChanged(function() if f:IsShown() then W.ShellStatus(f) end end)
	f:HookScript("OnHide", function() W.HideMenu() end)
	ns.CloseOnEscape(name)
	return f
end

-- Lay the shell's own parts out for its size: the main column's width, the
-- band and haze across it, the rim, the header's tools and subtitle, the
-- body's place. A resizable window calls it as it is sized; its pages lay
-- out again after (they read f.BodyWidth).
function W.ShellLayout(f)
	local wd = f:GetWidth()
	f.psMainW = wd - (f.psRail or 0) - (f.psSidebar or SHELL.sidebar) - 2
	f.BodyWidth = f.psMainW - SHELL.pad * 2
	f.Band:SetTexCoord(Theme.BandCoords(f.psMainW, SHELL.header))
	local haze = painters[f.Haze]
	if haze then haze(f.Haze) end
	local rim = rawget(f, "psRim")
	if rim then
		rim.psOffset = wd * 0.1
		layoutRim(rim)
	end
	if rawget(f, "psHeadTools") and f.Search then f.Search:SetWidth(headerSearchW(f)) end
	if rawget(f, "HeaderTools") then f.HeaderTools.Place() end
	f.Subtitle:SetWidth(f.BodyWidth)
	fitLines(f.Subtitle, f.psSubtitle or "", SUBTITLE_LINES)
	layoutBody(f)
	W.SetScrollContent(f.Scroll, f.Scroll.psContent or 0, f.psViewH)
end

-- The emblem engraving behind the body, for empty states.
function W.ShellWatermark(f, shown)
	f.Watermark:SetShown(shown and true or false)
end

-- Section rail buttons: the icon over its 11px label; the active one gets
-- the selection wash, a 2px accent bar at the window's edge and the accent
-- icon.
local RAIL_ROW = 56

local function railButton(f, i)
	local b = f.railButtons[i]
	if b then return b end
	b = CreateFrame("Button", nil, f.Rail)
	b:SetSize(f.psRail, RAIL_ROW)
	hoverTexture(b)
	b.Selected = b:CreateTexture(nil, "BACKGROUND")
	b.Selected:SetTexture(WHITE)
	b.Selected:SetAllPoints(b)
	W.Painter(b.Selected, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	b.Bar = b:CreateTexture(nil, "ARTWORK")
	b.Bar:SetTexture(WHITE)
	b.Bar:SetWidth(2)
	b.Bar:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	W.Color(b.Bar, "accent")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetSize(18, 18)
	b.Icon:SetPoint("TOP", b, "TOP", 0, -10)
	b.Label = W.Text(b, "caption", "textDim")
	b.Label:SetJustifyH("CENTER")
	b.Label:SetWidth(f.psRail - 4)
	b.Label:SetPoint("TOP", b.Icon, "BOTTOM", 0, -6)
	b:SetScript("OnClick", function(self)
		if self.psOnClick then self.psOnClick(self.psKey) end
	end)
	b:SetScript("OnEnter", simpleTip)
	b:SetScript("OnLeave", hideTip)
	b.psTipAnchor = "ANCHOR_RIGHT"
	f.railButtons[i] = b
	return b
end

-- The rail as wide as its widest label needs, SHELL.rail at least
-- ("Lookup" is "Nachschlagen" in German); the window grows by as much, so the
-- sidebar and the content keep their widths.
local function fitRail(f, items, bottom)
	local probe = rawget(f, "psRailProbe")
	if not probe then
		probe = W.Text(f.Rail, "caption", "textDim")
		probe:Hide()
		f.psRailProbe = probe
	end
	local need = 0
	for _, list in ipairs({ items, bottom or {} }) do
		for _, item in ipairs(list) do need = max(need, textWidth(probe, item.label or "")) end
	end
	local rail = max(SHELL.rail, math.ceil(need) + 8)
	local grow = rail - f.psRail
	if grow == 0 then return end
	f.psRail = rail
	f.Rail:SetWidth(rail)
	f.Sidebar:SetPoint("TOPLEFT", f, "TOPLEFT", 1 + rail, -1)
	f.Sidebar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1 + rail, 1)
	f:SetWidth(f:GetWidth() + grow)
	W.LayoutRim(f)
	for _, b in ipairs(f.railButtons) do
		b:SetWidth(rail)
		b.Label:SetWidth(rail - 4)
	end
end

-- items: { { key, label, icon, tip }, ... } stacked from the content line
-- down; bottom: the same, stacked up from the rail's foot (Options). The
-- active key is marked. -> the number of top items that fit.
function W.ShellRail(f, items, bottom, active, onSelect)
	if not rawget(f, "Rail") then return 0 end
	fitRail(f, items, bottom)
	local n = 0
	local function place(item, i, y, fromBottom)
		local b = railButton(f, i)
		b.psKey, b.psOnClick = item.key, item.onClick or onSelect
		b.psTip = item.tip or item.label
		local on = item.key == active
		b.Icon:SetTexture(Theme.Media(item.icon or "compact"))
		b.Label:SetText(item.label)
		b.Selected:SetShown(on)
		b.Bar:SetShown(on)
		W.Color(b.Icon, on and "accent" or "textDim")
		W.Color(b.Label, on and "text" or "textDim")
		b:ClearAllPoints()
		if fromBottom then
			b:SetPoint("BOTTOMLEFT", f.Rail, "BOTTOMLEFT", 0, y)
		else
			b:SetPoint("TOPLEFT", f.Rail, "TOPLEFT", 0, -y)
		end
		b:Show()
	end
	local i = 0
	local y = 12
	for k = 1, #(bottom or {}) do
		i = i + 1
		place(bottom[k], i, y, true)
		y = y + RAIL_ROW
	end
	local limit = f:GetHeight() - 2 - y -- the top of the bottom group
	y = f.psNavTop -- the first section level with the sidebar's first row
	for k = 1, #items do
		if y + RAIL_ROW > limit then break end
		i = i + 1
		n = n + 1
		place(items[k], i, y)
		y = y + RAIL_ROW
	end
	for k = i + 1, #f.railButtons do f.railButtons[k]:Hide() end
	f.psRailFloor = limit
	return n
end

-- Page title and subtitle. The title keeps its place with or without a
-- subtitle, so it never jumps between pages.
function W.ShellTitle(f, title, subtitle)
	f.Title:SetText(title or "")
	f.psSubtitle = subtitle or ""
	-- The main column's width between its pads (a hub's narrower column too).
	f.Subtitle:SetWidth(f.BodyWidth)
	fitLines(f.Subtitle, f.psSubtitle, SUBTITLE_LINES)
	f.Subtitle:SetShown(subtitle ~= nil and subtitle ~= "")
end

-- Lay the body out for `height` px of content (the scroll range).
function W.ShellBody(f, height)
	f.Body:SetWidth(f.BodyWidth + SHELL.pad * 2)
	W.SetScrollContent(f.Scroll, height, f.psViewH)
end

-- A section header in a shell body: the heading itself, a hairline after it.
-- opts.plain: the heading alone over a panel of rows (W.PLAIN_SECTION_H
-- tall, its text 8 above the panel), no hairline.
W.PLAIN_SECTION_H = 30
function W.SectionHeader(parent, opts)
	local plain = opts and opts.plain
	local h = CreateFrame("Frame", nil, parent)
	h:SetHeight(plain and W.PLAIN_SECTION_H or 44)
	h.Text = W.Text(h, "heading", "text")
	h.Text:SetPoint("BOTTOMLEFT", h, "BOTTOMLEFT", 0, plain and 8 or 10)
	h.Rule = W.Divider(h)
	h.Rule:SetPoint("LEFT", h.Text, "RIGHT", 12, 0)
	h.Rule:SetPoint("RIGHT", h, "RIGHT", 0, 0)
	h.Rule:SetShown(not plain)
	h.Count = W.Text(h, "number", "textMuted")
	h.Count:SetJustifyH("RIGHT")
	h.Count:SetPoint("BOTTOMRIGHT", h, "BOTTOMRIGHT", 0, plain and 8 or 10)
	h.Count:Hide()
	return h
end

-- A panel the rows of one section sit in: the raised ground and its inner
-- hairline in the skin in use, under the rows (its parent's own level).
function W.RowPanel(parent)
	local p = CreateFrame("Frame", nil, parent)
	p:SetFrameLevel(parent:GetFrameLevel())
	Theme.Skin(p, "panel")
	return p
end

function W.SetSection(h, text, count)
	h.Text:SetText(text)
	if count then
		h.Count:SetText(count)
		h.Count:Show()
		h.Rule:SetPoint("RIGHT", h.Count, "LEFT", -12, 0)
	else
		h.Count:Hide()
		h.Rule:SetPoint("RIGHT", h, "RIGHT", 0, 0)
	end
end

---------------------------------------------------------------------------
-- Options registry (docs/ARCHITECTURE.md, UI -> "Options registry").
-- Lives here, not in UI, because anything may register before the options
-- window exists: entries are kept in order and handed to the window
-- whenever it exists (now or later).
--
-- The rows are only the settings window's, so none of them is built at
-- login: every page, the modules' rows included, registers from the
-- window's own addon (Polestar_Options, load on demand: <Module>/Options.lua
-- there). Reading W.OptionsRegistry loads that addon (out of combat), so it
-- holds every row.
---------------------------------------------------------------------------

local registry = {} -- { spec, ... } in registration order
local registryListeners = {}

-- W.OptionsRegistry: every registration, the window's addon loaded.
setmetatable(W, { __index = function(_, k)
	if k == "OptionsRegistry" then
		local UI = ns.UI
		if UI and UI.LoadOptions and not UI.Options then UI.LoadOptions() end
		return registry
	end
end })

-- binding: a key binding row (UI/GamepadGuide.lua): { kind = "binding", action = "POLESTAR_NEXT", label, help }.
-- cards: picture cards, choices = { { value, label, draw = function(card, value) end } }.
-- font: a font face list, each name drawn in its face (choices as a dropdown's, each with `font` = the file path).
local CONTROL_KINDS = { toggle = true, slider = true, dropdown = true, color = true, button = true, binding = true, cards = true, font = true }

-- spec = { page, key, icon, order, tab, section, toggle, controls = { { kind, key, label, help, search, ... } } }
-- page is the title as shown, key (optional) the page's stable key; a
-- control's `search` holds more words the settings search finds it by.
-- toggle: the section's on/off in its header ({ kind = "toggle", key, label,
-- help }); a control's extras: inline colours and on/offs before it
-- ({ kind = "color" | "toggle", key, label, help, ... }); its more: the
-- settings in its cog's popup (controls as any).
-- -> true | false, err
local function checkControl(page, i, c, what)
	if type(c) ~= "table" or not CONTROL_KINDS[c.kind] then
		return ("RegisterOptions(%s): %s %d has unknown kind %s"):format(page, what, i, tostring(c and c.kind))
	end
	-- A toggle, slider or cards may hold state that is no setting: get/set and no key.
	local state = (c.kind == "toggle" or c.kind == "slider" or c.kind == "cards") and c.key == nil and type(c.get) == "function" and type(c.set) == "function"
	if c.kind ~= "button" and c.kind ~= "binding" and not state and type(c.key) ~= "string" then
		return ("RegisterOptions(%s): %s %d needs a settings key"):format(page, what, i)
	end
	if c.kind == "binding" and type(c.action) ~= "string" then
		return ("RegisterOptions(%s): binding %d needs an action"):format(page, i)
	end
	if c.kind == "button" and type(c.onClick) ~= "function" then
		return ("RegisterOptions(%s): button %d needs onClick"):format(page, i)
	end
	if c.extras ~= nil then
		if type(c.extras) ~= "table" then return ("RegisterOptions(%s): %s %d: extras must be a list"):format(page, what, i) end
		for j, e in ipairs(c.extras) do
			if type(e) ~= "table" or (e.kind ~= "color" and e.kind ~= "toggle") or type(e.key) ~= "string" then
				return ("RegisterOptions(%s): %s %d: extra %d must be a color or toggle with a key"):format(page, what, i, j)
			end
		end
	end
	if c.more ~= nil then
		if type(c.more) ~= "table" then return ("RegisterOptions(%s): %s %d: more must be a list"):format(page, what, i) end
		for j, m in ipairs(c.more) do
			local err = checkControl(page, j, m, "more control")
			if err then return err end
		end
	end
end

function ns.RegisterOptions(spec)
	if type(spec) ~= "table" then return false, "RegisterOptions: spec must be a table" end
	if type(spec.page) ~= "string" or spec.page == "" then return false, "RegisterOptions: page must be a string" end
	if spec.key ~= nil and (type(spec.key) ~= "string" or spec.key == "") then return false, "RegisterOptions: key must be a string" end
	if spec.shown ~= nil and type(spec.shown) ~= "function" then
		return false, ("RegisterOptions(%s): shown must be a function"):format(spec.page)
	end
	if spec.toggle ~= nil then
		local t = spec.toggle
		if type(t) ~= "table" or (t.kind ~= nil and t.kind ~= "toggle") or type(t.key) ~= "string" then
			return false, ("RegisterOptions(%s): toggle must be { kind = \"toggle\", key = ... }"):format(spec.page)
		end
		t.kind = "toggle"
		if spec.controls == nil then spec.controls = {} end
	end
	if type(spec.controls) ~= "table" then return false, "RegisterOptions: controls must be a list" end
	for i, c in ipairs(spec.controls) do
		local err = checkControl(spec.page, i, c, "control")
		if err then return false, err end
	end
	registry[#registry + 1] = spec
	for i = 1, #registryListeners do
		local ok, err = pcall(registryListeners[i], spec)
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
	return true
end

-- fn(spec) for every registration so far and every later one.
function W.OnOptionsRegistered(fn)
	registryListeners[#registryListeners + 1] = fn
	for i = 1, #registry do fn(registry[i]) end
end
