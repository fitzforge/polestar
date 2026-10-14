-- Polestar.Widgets: the widget kit the guide window, picker and options are
-- built from. Every piece paints itself from Polestar.Theme.
--
-- Setting controls (Toggle, Slider, Dropdown, Swatch) are grid rows, 40px
-- high, label left and control right; their description is the row's
-- tooltip. Each is bound to a settings path: it reads Polestar.Get, writes
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

---------------------------------------------------------------------------
-- Theme-following paint
---------------------------------------------------------------------------

local colored = setmetatable({}, { __mode = "k" }) -- region -> colour name
local painters = setmetatable({}, { __mode = "k" }) -- object -> fn(object)

-- Colour a font string or texture by palette name, and keep it coloured
-- through theme changes. alpha multiplies the palette alpha.
function W.Color(region, name, alpha)
	colored[region] = name
	region.psAlpha = alpha
	local r, g, b, a = Theme.Color(name)
	a = (a or 1) * (alpha or 1)
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

local function simpleTip(self)
	if self.psTip then W.Tooltip(self, self.psTipAnchor or "ANCHOR_TOP", self.psTip, self.psTipLines) end
end
local function hideTip(self) W.HideTooltip(self) end
W.SimpleTip, W.HideTip = simpleTip, hideTip

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
function W.IconButton(parent, icon, size, tip, onClick, glyphSize)
	local b = CreateFrame("Button", nil, parent)
	size = size or 22
	b:SetSize(size, size)
	hoverTexture(b)
	local g = b:CreateTexture(nil, "ARTWORK")
	g:SetTexture(Theme.Media(icon))
	local gs = glyphSize or floor(size * 0.6 + 0.5)
	g:SetSize(gs, gs)
	g:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Icon = g
	W.Color(g, "textDim")
	b.psTip = tip
	b:SetScript("OnEnter", function(self)
		if self:IsEnabled() then W.Color(self.Icon, self.psActive and "accent" or "text") end
		simpleTip(self)
		if self.psOnEnter then self.psOnEnter(self) end
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Icon, self.psActive and "accent" or "textDim", self:IsEnabled() and 1 or 0.35)
		hideTip(self)
		if self.psOnLeave then self.psOnLeave(self) end
	end)
	b:SetScript("OnMouseDown", function(self) if self:IsEnabled() then self.Icon:SetPoint("CENTER", self, "CENTER", 0, -1) end end)
	b:SetScript("OnMouseUp", function(self) self.Icon:SetPoint("CENTER", self, "CENTER", 0, 0) end)
	if onClick then b:SetScript("OnClick", onClick) end
	return b
end

function W.SetIcon(b, icon)
	b.Icon:SetTexture(Theme.Media(icon))
end

-- Mark an icon button as "on" (accent glyph) or dim it when disabled.
function W.SetIconState(b, active, enabled)
	b.psActive = active and true or false
	if enabled == false then b:Disable() else b:Enable() end
	W.Color(b.Icon, b.psActive and "accent" or "textDim", b:IsEnabled() and 1 or 0.35)
end

-- A text button. opts: { primary = true, ghost = true, danger = true,
-- width = n, icon = name, height = n }.
function W.Button(parent, text, onClick, opts)
	opts = opts or {}
	local b = CreateFrame("Button", nil, parent)
	b:SetHeight(opts.height or 28)
	local label = W.Text(b, "label", opts.danger and "danger" or "text")
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
		Theme.Skin(b, "button")
	end
	W.Painter(b, function(self)
		local icon = rawget(self, "Icon")
		if self.psPrimary then
			local d = self.psSkin
			local r, g, bb = Theme.Accent()
			if d and d.bg then d.bg:SetVertexColor(r, g, bb, 1) end
			if self.psBorder then for i = 1, 4 do self.psBorder[i]:SetVertexColor(r, g, bb, 1) end end
			W.Uncolor(self.Label)
			self.Label:SetTextColor(Theme.Color("onAccent"))
			if icon then icon:SetVertexColor(Theme.Color("onAccent")) end
		elseif icon then
			icon:SetVertexColor(Theme.Color(self.psDanger and "danger" or "textDim"))
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
	b:SetWidth(b.psFixedWidth or max(72, floor(w + iconW + 32 + 0.5)))
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
		C_Timer.After(3, function()
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
	track(bound, path, control)
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

-- A grid row: label left (truncates against the control), a faint hairline
-- underneath, the description as the row's tooltip.
local function settingRow(parent, label, desc)
	local row = CreateFrame("Button", nil, parent)
	row:SetHeight(W.ROW_H)
	hoverTexture(row, 0.6)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	row.Label = W.Text(row, "body", "text")
	row.Label:SetText(label)
	row.Label:SetPoint("LEFT", row, "LEFT", 12, 0)
	row.psLabel, row.psDesc = label, desc
	row.psTip = label
	row.psTipLines = desc and { desc } or nil
	row.psTipAnchor = "ANCHOR_TOPLEFT"
	return row
end

-- Bound the label on the left of a row's control.
local function fitLabel(row, control)
	row.Label:SetPoint("RIGHT", control, "LEFT", -10, 0)
end

local function dimRow(row, enabled)
	row:SetAlpha(enabled and 1 or 0.45)
	if enabled then row:Enable() else row:Disable() end
end

local function rowEnter(self)
	simpleTip(self)
end

---------------------------------------------------------------------------
-- Toggle: a pill switch. The knob slides (120 ms, ease-out); with reduced
-- motion it simply lands.
---------------------------------------------------------------------------

local TOGGLE_W, TOGGLE_H, KNOB = 30, 16, 12

local function toggleValue(self)
	if self.psGet then return self.psGet() and true or false end
	return ns.Get(self.psPath) and true or false
end

local function toggleRefresh(self)
	local on = toggleValue(self)
	local enabled = W.Enabled(self)
	dimRow(self, enabled)
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
-- one switch stands for several settings (set(nil) on right-click: defaults).
function W.Toggle(parent, label, path, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.Track = pill(row, TOGGLE_W, TOGGLE_H)
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	row.Track:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Knob = row.Track:CreateTexture(nil, "OVERLAY")
	row.Knob:SetTexture(Theme.Media("circle"))
	row.Knob:SetSize(KNOB, KNOB)
	fitLabel(row, row.Track)
	-- Left-click flips it; right-click puts the setting back to its default.
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if self.psSet then
			if button == "RightButton" then self.psSet(nil) else self.psSet(not toggleValue(self)) end
		elseif button == "RightButton" then
			ns.Set(self.psPath, nil)
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

local SLIDER_W, VALUE_W = 112, 44

local function roundTo(v, stepSize)
	return floor(v / stepSize + 0.5) * stepSize
end

local function sliderText(self, v)
	local fmt = self.psFormat
	if type(fmt) == "function" then return fmt(v) end
	return string.format(fmt or "%.2f", v)
end

local function sliderPaint(self, value)
	local s = self.Slider
	local lo, hi = s:GetMinMaxValues()
	local v = value or s:GetValue()
	local w = SLIDER_W
	local frac = hi > lo and (v - lo) / (hi - lo) or 0
	self.Fill:SetWidth(max(0.01, w * frac))
	self.Value:SetText(sliderText(self, v))
end

local function sliderRefresh(self)
	local v = ns.Get(self.psPath)
	if type(v) ~= "number" then v = self.psMin end
	self.psRefreshing = true
	self.Slider:SetValue(v)
	self.psRefreshing = false
	dimRow(self, W.Enabled(self))
	self.Fill:SetVertexColor(Theme.Accent())
	self.Thumb:SetVertexColor(Theme.Color("text"))
	sliderPaint(self)
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

-- opts.release: write the value when the drag ends, not on every step (a
-- setting that rescales the window the slider sits in).
function W.Slider(parent, label, path, lo, hi, stepSize, fmt, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.psMin, row.psMax, row.psStep, row.psFormat = lo, hi, stepSize, fmt
	row.Value = W.Text(row, "number", "textDim")
	row.Value:SetJustifyH("RIGHT")
	row.Value:SetWidth(VALUE_W)
	row.Value:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	local s = sliderParts(row, row, SLIDER_W)
	s:SetPoint("RIGHT", row.Value, "LEFT", -8, 0)
	s:SetMinMaxValues(lo, hi)
	s:SetValueStep(stepSize)
	fitLabel(row, s)
	s:SetScript("OnValueChanged", function(_, value, userInput)
		value = roundTo(value, stepSize)
		sliderPaint(row, value)
		if userInput and not row.psRefreshing and W.Enabled(row) and ns.Get(row.psPath) ~= value then
			if opts and opts.release then row.psPending = value else ns.Set(row.psPath, value) end
		end
	end)
	s:SetScript("OnMouseUp", function()
		if row.psPending ~= nil then
			local v = row.psPending
			row.psPending = nil
			ns.Set(row.psPath, v)
		end
	end)
	s:SetScript("OnMouseWheel", function(_, delta)
		if not W.Enabled(row) then return end
		local v = roundTo((ns.Get(row.psPath) or lo) + delta * stepSize, stepSize)
		ns.Set(row.psPath, min(hi, max(lo, v)))
	end)
	-- Right-click puts the setting back to its default.
	row:RegisterForClicks("RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if button == "RightButton" and W.Enabled(self) then ns.Set(self.psPath, nil) end
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = sliderRefresh
	return W.Bind(row, path, depends)
end

---------------------------------------------------------------------------
-- Menu: one shared popup list (header menu, dropdown choices). A click
-- anywhere else closes it; Escape closes it.
---------------------------------------------------------------------------

local menu, catcher
local MENU_ROW, MENU_SEP, MENU_PAD = 26, 9, 5

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

local function menuRowEnter(self)
	if self.psItem and self.psItem.tip then W.Tooltip(self, "ANCHOR_RIGHT", self.psItem.text, { self.psItem.tip }) end
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
	menu:SetScript("OnHide", function() catcher:Hide() end)
	menu:Hide()
	if UISpecialFrames then tinsert(UISpecialFrames, "PolestarMenu") end
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
	row:SetScript("OnLeave", hideTip)
	menu.rows[i] = row
	return row
end

-- items: { { text, icon, checked, disabled, onClick, tip, color, confirm }, { separator = true }, ... }
-- opts: { point = "TOPRIGHT", relPoint = "BOTTOMRIGHT", x = 0, y = -4, minWidth = 168 }
function W.ShowMenu(anchor, items, opts)
	if not menu then buildMenu() end
	opts = opts or {}
	local y, width, nrow, nsep = -MENU_PAD, opts.minWidth or 176, 0, 0
	local anyIcon = false
	for i = 1, #items do if items[i].icon then anyIcon = true end end
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
			W.Color(row.Text, item.color or "text", item.disabled and 0.45 or 1)
			if item.icon then
				row.Icon:SetTexture(Theme.Media(item.icon))
				W.Color(row.Icon, item.color or "textDim", item.disabled and 0.45 or 1)
				row.Icon:Show()
			else
				row.Icon:Hide()
			end
			row.Check:SetShown(item.checked and true or false)
			W.Color(row.Check, "accent")
			row:ClearAllPoints()
			row:SetPoint("TOPLEFT", menu, "TOPLEFT", 1, y)
			row:SetPoint("TOPRIGHT", menu, "TOPRIGHT", -1, y)
			row:Show()
			width = max(width, row.Text:GetStringWidth() + (anyIcon and 32 or 12) + 36)
			y = y - MENU_ROW
		end
	end
	menu:SetSize(floor(width + 0.5), -y + MENU_PAD)
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

---------------------------------------------------------------------------
-- Dropdown: a button showing the current choice; the list is the menu.
-- choices: a list or a function returning one (choices that come and go).
-- opts.get() / opts.set(value) stand in for reading and writing the path
-- when the shown value is derived (the font: Inter, or EllesmereUI's while
-- following it).
---------------------------------------------------------------------------

local DROPDOWN_W = 150

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

local function dropdownRefresh(self)
	self.Button.Label:SetText(choiceText(choicesOf(self), valueOf(self)))
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
		items[i] = { text = c.text, checked = c.value == cur, onClick = function()
			if row.psSet then row.psSet(c.value) else ns.Set(row.psPath, c.value) end
		end }
	end
	W.ShowMenu(self, items, { minWidth = self:GetWidth() })
end

function W.Dropdown(parent, label, path, choices, desc, depends, opts)
	local row = settingRow(parent, label, desc)
	row.psChoices = choices
	row.psGet, row.psSet = opts and opts.get, opts and opts.set
	local b = CreateFrame("Button", nil, row)
	b:SetSize(DROPDOWN_W, 28)
	b:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	b.Label = W.Text(b, "label", "text")
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
	fitLabel(row, b)
	-- Right-click on the row puts the setting back to its default.
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(_, button)
		if button == "RightButton" then
			if W.Enabled(row) then W.HideMenu(); ns.Set(path, nil) end
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
-- Colour swatch: opens the game's colour picker; right-click restores the
-- default. Always editable. opts:
--   shown() -> r, g, b: the colour in effect when the setting holds none
--     (the scheme's accent, EllesmereUI's, the scheme's ground);
--   source() -> text: where that colour comes from, shown left of the chip
--     while the setting holds none ("EllesmereUI", "Dusk");
--   linked: other paths a cancelled pick restores too (picking an accent
--     turns Match EllesmereUI accent off).
---------------------------------------------------------------------------

local function swatchColor(self)
	local c = ns.Get(self.psPath)
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3], true end
	if self.psShown then
		local r, g, b = self.psShown()
		return r, g, b, false
	end
	c = ns.GetDefault(self.psPath)
	if type(c) == "table" then return c[1], c[2], c[3], false end
	return 1, 1, 1, false
end

local function swatchRefresh(self)
	local r, g, b, own = swatchColor(self)
	self.Chip:SetVertexColor(r, g, b, 1)
	self.Note:SetText((not own and self.psSource and self.psSource()) or "")
	dimRow(self, W.Enabled(self))
end

local function openPicker(self)
	if not ColorPickerFrame or not ColorPickerFrame.SetupColorPickerAndShow then return end
	local path = self.psPath
	local r, g, b = swatchColor(self)
	local previous = ns.Get(path)
	local linked = {}
	for i, p in ipairs(self.psLinked or {}) do linked[i] = ns.Get(p) end
	ColorPickerFrame:SetupColorPickerAndShow({
		r = r, g = g, b = b,
		hasOpacity = false,
		swatchFunc = function()
			local nr, ng, nb = ColorPickerFrame:GetColorRGB()
			ns.Set(path, { nr, ng, nb })
		end,
		cancelFunc = function()
			ns.Set(path, previous)
			for i, p in ipairs(self.psLinked or {}) do ns.Set(p, linked[i]) end
		end,
	})
end

function W.Swatch(parent, label, path, desc, opts)
	opts = opts or {}
	local row = settingRow(parent, label, desc)
	row.psShown, row.psSource, row.psLinked = opts.shown, opts.source, opts.linked
	local chip = CreateFrame("Frame", nil, row)
	chip:SetSize(34, 18)
	chip:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	local fillTex = chip:CreateTexture(nil, "ARTWORK")
	fillTex:SetTexture(WHITE)
	fillTex:SetPoint("TOPLEFT", chip, "TOPLEFT", 2, -2)
	fillTex:SetPoint("BOTTOMRIGHT", chip, "BOTTOMRIGHT", -2, 2)
	W.Painter(chip, function(f) Theme.Border(f, Theme.Wash("swatch")) end)
	row.Chip = fillTex
	row.Note = W.Text(row, "small", "textMuted")
	row.Note:SetPoint("RIGHT", chip, "LEFT", -8, 0)
	fitLabel(row, row.Note)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", function(self, button)
		if not W.Enabled(self) then return end
		if button == "RightButton" then ns.Set(self.psPath, nil) else openPicker(self) end
	end)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = swatchRefresh
	return W.Bind(row, path)
end

---------------------------------------------------------------------------
-- Key binding: the key bound to a binding command (Bindings.xml's, or
-- `CLICK <button>:LeftButton`), set without the game's Key Bindings window.
-- Click, then press a key (with Alt, Ctrl or Shift) or a mouse button 3-5;
-- Escape or a left or right click cancels. The new key replaces the
-- command's old ones and is taken from whatever held it. Right-click clears
-- it. Not in combat: the game refuses binding changes there.
---------------------------------------------------------------------------

local MODIFIER_KEYS = { LSHIFT = true, RSHIFT = true, LCTRL = true, RCTRL = true, LALT = true, RALT = true, LMETA = true, RMETA = true, UNKNOWN = true }
local MOUSE_KEYS = { MiddleButton = "BUTTON3", Button4 = "BUTTON4", Button5 = "BUTTON5" }

local keybindRows = setmetatable({}, { __mode = "k" })

local function keybindKeys(cmd)
	if not GetBindingKey then return nil end
	return GetBindingKey(cmd)
end

local function keyText(key)
	if GetBindingText then return GetBindingText(key, true) end
	return key
end

local function keybindRefresh(self)
	local b = self.Button
	if self.psCapturing then
		b.Label:SetText(L["Press a key"])
		W.Color(b.Label, "accent")
	else
		local key = keybindKeys(self.psCommand)
		b.Label:SetText(key and keyText(key) or L["Not bound"])
		W.Color(b.Label, key and "text" or "textDim")
	end
	dimRow(self, W.Enabled(self))
end

local function stopCapture(row)
	if not row.psCapturing then return end
	row.psCapturing = nil
	row:EnableKeyboard(false)
	row:Refresh()
end

local function saveBindings()
	if SaveBindings then SaveBindings(GetCurrentBindingSet and GetCurrentBindingSet() or 1) end
end

local function clearKeys(cmd)
	local keys = { keybindKeys(cmd) }
	for i = 1, #keys do SetBinding(keys[i]) end
end

local function bindKey(row, key)
	stopCapture(row)
	if not SetBinding or InCombatLockdown() then return end
	local cmd = row.psCommand
	local was = GetBindingAction and GetBindingAction(key) or ""
	clearKeys(cmd)
	if SetBinding(key, cmd) == false then
		ns.Print(string.format(L["Could not bind %s."], keyText(key)))
	else
		saveBindings()
		if was ~= "" and was ~= cmd then
			ns.Print(string.format(L["%s now does %s instead of %s."], keyText(key), row.psLabel, _G["BINDING_NAME_" .. was] or was))
		end
	end
	row:Refresh()
end

local function chord(key)
	return (IsAltKeyDown() and "ALT-" or "") .. (IsControlKeyDown() and "CTRL-" or "") .. (IsShiftKeyDown() and "SHIFT-" or "") .. key
end

local function keybindKeyDown(self, key)
	if MODIFIER_KEYS[key] then return end
	if key == "ESCAPE" then return stopCapture(self) end
	bindKey(self, chord(key))
end

local function keybindClick(self, button)
	if self.psCapturing then
		if MOUSE_KEYS[button] then return bindKey(self, chord(MOUSE_KEYS[button])) end
		return stopCapture(self)
	end
	if not W.Enabled(self) or not SetBinding then return end
	if InCombatLockdown() then
		ns.Print(L["Key bindings can't change in combat."])
		return
	end
	if button == "RightButton" then
		clearKeys(self.psCommand)
		saveBindings()
		self:Refresh()
	elseif button == "LeftButton" then
		-- A focused edit box (the options search) would take the key.
		local focus = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
		if focus and focus.ClearFocus then focus:ClearFocus() end
		self.psCapturing = true
		self:EnableKeyboard(true)
		if self.SetPropagateKeyboardInput then self:SetPropagateKeyboardInput(false) end
		self:Refresh()
	end
end

function W.Keybind(parent, label, command, desc)
	local row = settingRow(parent, label, desc)
	row.psCommand = command
	row.psTipLines = { L["Click, then press a key. Right-click clears it."] }
	if desc then table.insert(row.psTipLines, 1, desc) end
	local b = CreateFrame("Button", nil, row)
	b:SetSize(DROPDOWN_W, 28)
	b:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	b.Label = W.Text(b, "label", "text")
	b.Label:SetPoint("LEFT", b, "LEFT", 10, 0)
	b.Label:SetPoint("RIGHT", b, "RIGHT", -10, 0)
	Theme.Skin(b, "dropdown")
	b:RegisterForClicks("AnyUp")
	b:SetScript("OnClick", function(_, button) keybindClick(row, button) end)
	row.Button = b
	fitLabel(row, b)
	row:RegisterForClicks("AnyUp")
	row:SetScript("OnClick", keybindClick)
	row:SetScript("OnKeyDown", keybindKeyDown)
	row:SetScript("OnHide", stopCapture)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	row.Refresh = keybindRefresh
	keybindRows[row] = true
	row:Refresh()
	return row
end

ns.RegisterEvent("UPDATE_BINDINGS", function()
	for row in pairs(keybindRows) do row:Refresh() end
end)
-- Combat ends a capture: the key could not be bound.
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	for row in pairs(keybindRows) do stopCapture(row) end
end)

---------------------------------------------------------------------------
-- A read-only value row (status pages): label left, value right.
---------------------------------------------------------------------------

function W.InfoRow(parent, label, desc)
	local row = settingRow(parent, label, desc)
	row.Value = W.Text(row, "label", "textDim")
	row.Value:SetJustifyH("RIGHT")
	row.Value:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	fitLabel(row, row.Value)
	row:SetScript("OnEnter", rowEnter)
	row:SetScript("OnLeave", hideTip)
	return row
end

---------------------------------------------------------------------------
-- Action tile: icon, title and a one-line description; for consequential
-- actions (reset all, reset positions). confirm = a second click acts.
---------------------------------------------------------------------------

function W.ActionTile(parent, icon, title, desc, onClick, opts)
	opts = opts or {}
	local b = CreateFrame("Button", nil, parent)
	b:SetHeight(60)
	Theme.Skin(b, "button")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetTexture(Theme.Media(icon))
	b.Icon:SetSize(18, 18)
	b.Icon:SetPoint("LEFT", b, "LEFT", 16, 0)
	W.Color(b.Icon, opts.danger and "danger" or "accent")
	b.Title = W.Text(b, "body", "text")
	b.Title:SetPoint("TOPLEFT", b, "TOPLEFT", 48, -13)
	b.Title:SetPoint("TOPRIGHT", b, "TOPRIGHT", -12, -13)
	b.Title:SetText(title)
	b.Desc = W.Text(b, "small", "textMuted")
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
-- tall. W.SetCopyText(box, text) fills it.
function W.CopyBox(parent, opts)
	opts = opts or {}
	local e = CreateFrame("EditBox", nil, parent)
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
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self)
		Theme.SetFocused(self, true)
		self:HighlightText()
	end)
	e:SetScript("OnEditFocusLost", function(self)
		Theme.SetFocused(self, false)
		self:HighlightText(0, 0)
	end)
	e:SetScript("OnMouseUp", function(self) self:SetFocus(); self:HighlightText() end)
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

function W.SetCopyText(e, text)
	e.psText = text or ""
	e:SetText(e.psText)
	e:SetCursorPosition(0)
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
	local h = max(24, view * view / content)
	bar.Thumb:SetHeight(h)
	bar.Thumb:ClearAllPoints()
	bar.Thumb:SetPoint("TOPRIGHT", bar, "TOPRIGHT", 0, -(view - h) * (cur / range))
end

local function scrollDrag(bar)
	local sf = bar.psScroll
	local _, y = GetCursorPosition()
	local scale = bar:GetEffectiveScale()
	local view = sf.psView or sf:GetHeight()
	local range = max(0, (sf.psContent or 0) - view)
	local h = bar.Thumb:GetHeight()
	if view - h <= 0 then return end
	local dy = (bar.psStartY - y / scale)
	sf:SetVerticalScroll(min(range, max(0, bar.psStartScroll + dy * range / (view - h))))
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
		self:SetScript("OnUpdate", scrollDrag)
	end)
	bar:SetScript("OnMouseUp", function(self) self:SetScript("OnUpdate", nil) end)
	-- Escape can hide the window mid-drag, before any mouse-up arrives.
	bar:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
	bar:SetScript("OnEnter", function(self) self.Thumb:SetWidth(4) end)
	bar:SetScript("OnLeave", function(self) self.Thumb:SetWidth(2) end)
	bar:Hide()
	sf.Bar = bar
	Theme.Skin(bar, "scrollbar")
	return sf
end

-- Tell the scroll area its content and view heights (view nil = measured).
function W.SetScrollContent(sf, contentHeight, viewHeight)
	sf.psContent = contentHeight
	sf.psView = viewHeight
	sf.Child:SetHeight(max(1, contentHeight))
	scrollUpdate(sf)
end

function W.ScrollTo(sf, offset)
	sf:SetVerticalScroll(max(0, offset or 0))
	scrollUpdate(sf)
end

---------------------------------------------------------------------------
-- The shell
---------------------------------------------------------------------------

local SHELL = {
	width = 960, height = 680, sidebar = 240, header = 112, tabs = 40, footer = 56, pad = 32,
	side = 24, -- the sidebar's left edge
	top = 152, -- header + tab band: where navigation and content begin
	rail = 64, -- the section rail of a hub shell (opts.rail)
	brand = 69, -- a hub's brand block ends here: the rail's hairline starts below it
	foot = 23, -- the version line's bottom, level with the rail's foot label
}
W.SHELL = SHELL

-- Polestar's memory in KB (nil when the client hides it), for About.
function W.AddonMemory()
	if not (UpdateAddOnMemoryUsage and GetAddOnMemoryUsage) then return nil end
	local ok = pcall(UpdateAddOnMemoryUsage)
	if not ok then return nil end
	local ok2, kb = pcall(GetAddOnMemoryUsage, ADDON)
	if ok2 and type(kb) == "number" then return kb end
	return nil
end

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

-- Navigation rows in the sidebar, on the nav scroll area's child.
local function navButton(f, i)
	local b = f.navButtons[i]
	if b then return b end
	b = CreateFrame("Button", nil, f.NavScroll.Child)
	b:SetHeight(40)
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
	b.Icon:SetSize(16, 16)
	b.Icon:SetPoint("LEFT", b, "LEFT", SHELL.side, 0)
	b.Label = W.Text(b, "body", "textDim")
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
-- The rows live in their own scroll area, from 12px under the search down
-- to the line of the main column's footer bar (SHELL.footer from the
-- bottom), so the version and stage chip below it keep their band however
-- many rows there are: past that line the list scrolls (wheel, thumb) and
-- the active row is scrolled into view.
local NAV_ROW = 40
local NAV_COUNT_W = 32 -- room kept right of a row's label for its count or dot
function W.ShellNav(f, items, active, onSelect)
	f.psOnNav = onSelect
	local sf = f.NavScroll
	local y, activeY = 0, nil
	for i, item in ipairs(items) do
		local b = navButton(f, i)
		b.psKey = item.key
		local on = item.key == active
		local empty = item.count == 0
		b.Icon:SetTexture(Theme.Media(item.icon or "compact"))
		b.Label:SetText(item.label)
		b.Count:SetText(item.count or "")
		b.Count:SetShown(item.count ~= nil and not empty)
		b.Dot:SetShown(item.dot and true or false)
		if item.dot then b.Count:Hide() end
		b.Selected:SetShown(on)
		b.Bar:SetShown(on)
		W.Color(b.Label, on and "text" or (empty and "textMuted" or "textDim"))
		W.Color(b.Icon, on and "accent" or (empty and "textMuted" or "textDim"))
		b:SetAlpha((empty and not on) and 0.55 or 1)
		b.psEmpty = empty
		b.psHeading = item.heading and true or false
		b.Icon:SetShown(not item.heading)
		-- The label ends short of the count (or dot) so a long one is cut
		-- with an ellipsis rather than running under it or off the sidebar.
		b.Label:ClearAllPoints()
		if item.heading then
			b.Label:SetPoint("LEFT", b, "LEFT", SHELL.side, 0)
			b.Label:SetPoint("RIGHT", b, "RIGHT", -SHELL.side, 0)
			W.Color(b.Label, "textMuted")
			b:SetAlpha(1)
			b:Disable()
		else
			b.Label:SetPoint("LEFT", b.Icon, "RIGHT", 12, 0)
			b.Label:SetPoint("RIGHT", b, "RIGHT", -(SHELL.side + NAV_COUNT_W), 0)
			b:Enable()
		end
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", sf.Child, "TOPLEFT", 0, -y)
		b:SetPoint("TOPRIGHT", sf.Child, "TOPRIGHT", 0, -y)
		b:Show()
		if on then activeY = y end
		y = y + NAV_ROW
	end
	for i = #items + 1, #f.navButtons do f.navButtons[i]:Hide() end
	local view = W.ShellNavHeight(f)
	sf.Child:SetWidth(SHELL.sidebar - 1)
	W.SetScrollContent(sf, y, view)
	if activeY then
		local cur = sf:GetVerticalScroll()
		if activeY < cur then
			W.ScrollTo(sf, activeY)
		elseif activeY + NAV_ROW > cur + view then
			W.ScrollTo(sf, activeY + NAV_ROW - view)
		end
	end
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
-- hidden footer still marks the column's width).
local function layoutBody(f)
	local tabs, foot = f.TabRow:IsShown(), f.Footer:IsShown()
	f.Content:ClearAllPoints()
	f.Content:SetPoint("TOPLEFT", tabs and f.TabRow or f.Header, "BOTTOMLEFT", 0, 0)
	f.Content:SetPoint("BOTTOMRIGHT", f.Footer, foot and "TOPRIGHT" or "BOTTOMRIGHT", 0, 0)
	f.psViewH = f:GetHeight() - SHELL.header - (tabs and SHELL.tabs or 0) - (foot and SHELL.footer or 0)
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
		t:SetWidth(floor(t.Label:GetStringWidth() + 24 + 0.5))
		local on = tabs[i].key == active
		Theme.SetTabSelected(t, on)
		W.Color(t.Label, on and "text" or "textDim")
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
-- opts.confirm: a second click acts. Buttons are reused per position.
local function footerButton(f, side, i)
	local list = f.footerButtons[side]
	local b = list[i]
	if b then return b end
	b = W.Button(f.Footer, "", nil, {})
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
			local b = footerButton(f, side, i)
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
				if prev then b:SetPoint("LEFT", prev, "RIGHT", 8, 0) else b:SetPoint("LEFT", f.Footer, "LEFT", SHELL.pad, 0) end
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
		if not b.psPrimary then W.Color(b.Label, b.psDanger and "danger" or "text") end
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

-- opts: { width, height, title, subtitle, searchPlaceholder, onSearch,
--         scalePath = "ui.menuScale" (the window's scale setting) }
--
-- The grid every shell shares, top down: the header band (0-112: brand in
-- the sidebar, page title in the main column), the tab band (112-152: the
-- search in the sidebar, the tabs in the main column), then one hairline
-- across both columns at 152 where navigation and content begin. Left edges:
-- 24 in the sidebar, 32 in the main column.
--
-- opts.rail: a section rail (SHELL.rail wide) left of the sidebar, for a
-- hub of several sections (W.ShellRail); the emblem moves into it and the
-- window grows by the rail's width.
function W.Shell(name, opts)
	opts = opts or {}
	local RAIL = opts.rail and SHELL.rail or 0
	local Wd, Hd = opts.width or (SHELL.width + RAIL), opts.height or SHELL.height
	local SB = SHELL.sidebar
	local f = CreateFrame("Frame", name, UIParent)
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
	-- (Media/UI/wordmark-small.tga, drawn 1:1); the emblem's ink starts 5px
	-- into its 36px box and is 26px wide (emblem.tga).
	local WORD_INK, WORD_TOP, EMBLEM, EMBLEM_INK, EMBLEM_INK_W = 2, 22, 36, 5, 26
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
	f.Wordmark = W.Tex(side, "ARTWORK", "wordmark-small", "text")
	f.Wordmark:SetSize(256, 32)
	f.Wordmark:SetPoint("TOPLEFT", side, "TOPLEFT", textX - WORD_INK, -WORD_TOP)
	f.Tagline = W.Text(side, "small", "textDim")
	f.Tagline:SetPoint("TOPLEFT", side, "TOPLEFT", textX, -(WORD_TOP + 30))
	f.Tagline:SetText(L["A community project"])
	local searchTop = SHELL.header - 30
	f.Search = W.SearchBox(side, opts.searchPlaceholder or L["Search"], opts.onSearch)
	f.Search:SetPoint("TOPLEFT", side, "TOPLEFT", SHELL.side, -searchTop)
	f.Search:SetPoint("TOPRIGHT", side, "TOPRIGHT", -SHELL.side, -searchTop)
	f.psNavTop = searchTop + 30 + 12
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
	f.Band:SetTexCoord(Theme.BandCoords(Wd - RAIL - SB - 2, SHELL.header))
	f.Title = W.Text(head, "hero", "text")
	f.Title:SetPoint("TOPLEFT", head, "TOPLEFT", SHELL.pad, -32)
	-- Clear of the close button (28px, 12px in, 12px gap): a long title (a
	-- guide pack's) ends in an ellipsis.
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

	if opts.scalePath then
		local function applyScale() f:SetScale(ns.Get(opts.scalePath) or 1) end
		applyScale()
		ns.On("SETTING_CHANGED", function(path)
			if path == opts.scalePath or path == "" or path == "ui" then applyScale() end
		end)
	end
	f:HookScript("OnShow", function(self)
		self.Status:SetText(statusText())
		W.SetStageChip(self.Stage)
		Anim.To(self, "alpha", 0, 1, Anim.FAST, "out")
	end)
	f:HookScript("OnHide", function() W.HideMenu() end)
	if UISpecialFrames and name then tinsert(UISpecialFrames, name) end
	return f
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

-- items: { { key, label, icon, tip }, ... } stacked from the content line
-- down; bottom: the same, stacked up from the rail's foot (Options). The
-- active key is marked. -> the number of top items that fit.
function W.ShellRail(f, items, bottom, active, onSelect)
	if not rawget(f, "Rail") then return 0 end
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
function W.SectionHeader(parent)
	local h = CreateFrame("Frame", nil, parent)
	h:SetHeight(44)
	h.Text = W.Text(h, "heading", "text")
	h.Text:SetPoint("BOTTOMLEFT", h, "BOTTOMLEFT", 0, 10)
	h.Rule = W.Divider(h)
	h.Rule:SetPoint("LEFT", h.Text, "RIGHT", 12, 0)
	h.Rule:SetPoint("RIGHT", h, "RIGHT", 0, 0)
	h.Count = W.Text(h, "number", "textMuted")
	h.Count:SetJustifyH("RIGHT")
	h.Count:SetPoint("BOTTOMRIGHT", h, "BOTTOMRIGHT", 0, 10)
	h.Count:Hide()
	return h
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
-- Lives here, not in UI, because modules loading before UI.xml register at
-- file load: entries are kept in order and handed to the options window
-- whenever it exists (now or later).
---------------------------------------------------------------------------

local registry = {} -- { spec, ... } in registration order
local registryListeners = {}
W.OptionsRegistry = registry

local CONTROL_KINDS = { toggle = true, slider = true, dropdown = true, color = true, button = true, keybind = true }

-- spec = { page, icon, order, tab, section, controls = { { kind, key, label, help, ... } } }
-- -> true | false, err
function ns.RegisterOptions(spec)
	if type(spec) ~= "table" then return false, "RegisterOptions: spec must be a table" end
	if type(spec.page) ~= "string" or spec.page == "" then return false, "RegisterOptions: page must be a string" end
	if type(spec.controls) ~= "table" then return false, "RegisterOptions: controls must be a list" end
	for i, c in ipairs(spec.controls) do
		if type(c) ~= "table" or not CONTROL_KINDS[c.kind] then
			return false, ("RegisterOptions(%s): control %d has unknown kind %s"):format(spec.page, i, tostring(c and c.kind))
		end
		if c.kind == "keybind" then
			if type(c.command) ~= "string" or c.command == "" then
				return false, ("RegisterOptions(%s): key binding %d needs a command"):format(spec.page, i)
			end
		elseif c.kind ~= "button" and type(c.key) ~= "string" then
			return false, ("RegisterOptions(%s): control %d needs a settings key"):format(spec.page, i)
		end
		if c.kind == "button" and type(c.onClick) ~= "function" then
			return false, ("RegisterOptions(%s): button %d needs onClick"):format(spec.page, i)
		end
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
