-- Unlock mode: every movable Polestar frame at once, moved where it stands.
--
-- /polestar unlock (or Guide > Window > Position > Move frames) lays a dim box
-- with an accent hairline, the frame's name and its size over each frame
-- registered here, hidden ones too (at their default size). Drag a box to move
-- its frame (Shift-drag keeps to one axis). It snaps to the screen's centre
-- lines and to the other boxes' edges and centres within SNAP px, an accent
-- guide drawn along the line it took, else to the grid (movers.grid,
-- movers.gridSize 8, 16 or 32 px, drawn out from the screen's centre with an
-- accent crosshair); movers.snap off leaves only the grid. A click selects a
-- box: the arrow keys nudge it 1 px (Shift: 10) and its line shows where it
-- stands. A right-click puts that frame back in its default place. The bar at
-- the top holds Grid, the grid size, Snap, Reset all positions (asks first) and
-- Lock; Escape locks, and so does a fight (no unlocking in one).
--
-- Each frame keeps its own saved key and format: a mover only reads where the
-- frame is (get) and hands the new spot back (set), both as a point on
-- UIParent in UIParent's units; the frame's module stores and applies it.
--
--   ns.Movers.Register({ key, label,
--     frame = fn -> frame | nil       the live frame (moved along while dragging)
--     size = fn -> w, h               its size while it has none (not built, hidden)
--     get = fn -> point, relPoint, x, y
--     set = fn(point, relPoint, x, y)
--     reset = fn
--     anchor = fn -> point, relPoint  optional: the point set is given (else get's)
--     enabled = fn -> bool            optional: no box while its feature is off
--     fixedSize = true                optional: always size(), never the frame's })
--   ns.Movers.Unlock([key]) -> ok (key: that box selected), Lock(), IsUnlocked(), Toggle()
--   ns.Movers.Rect(key) -> left, bottom, w, h; MoveTo(key, left, bottom); Reset(key); ResetAll()
--   ns.Movers.Snap(left, bottom, w, h, others, opts) -> left, bottom, guideX, guideY (pure)
--
-- Nothing is built before the first unlock, and nothing runs per frame except
-- while a box is being dragged.

local ADDON, ns = ...
local L = ns.L
local Theme, W = ns.Theme, ns.Widgets

local type, pairs, ipairs, floor, ceil, abs, max, min = type, pairs, ipairs, math.floor, math.ceil, math.abs, math.max, math.min
local format, sort = string.format, table.sort

ns.RegisterDefaults("movers", { grid = true, gridSize = 32, snap = true })

local M = {}
ns.Movers = M

M.SNAP = 6 -- px from a line at which a box snaps to it
M.GRID_SIZES = { 8, 16, 32 }
M.NUDGE, M.NUDGE_SHIFT = 1, 10

local specs, order = {}, {}
local unlocked = false
local root, bar, gridFrame, guides
local boxes = {} -- key -> box
local selected, dragging

local function round(v) return floor(v + 0.5) end
local function combat() return InCombatLockdown and InCombatLockdown() and true or false end
local function screen() return UIParent:GetWidth(), UIParent:GetHeight() end

---------------------------------------------------------------------------
-- Geometry, in UIParent's units with the origin at its bottom-left
---------------------------------------------------------------------------

-- Where `point` lies on a w x h box whose bottom-left is (0, 0).
local function pointXY(point, w, h)
	local x = point:find("LEFT", 1, true) and 0 or point:find("RIGHT", 1, true) and w or w / 2
	local y = point:find("TOP", 1, true) and h or point:find("BOTTOM", 1, true) and 0 or h / 2
	return x, y
end

-- A w x h frame's bottom-left when its `point` sits at UIParent's relPoint + (x, y).
function M.RectOf(point, relPoint, x, y, w, h)
	local sw, sh = screen()
	local rx, ry = pointXY(relPoint or point, sw, sh)
	local px, py = pointXY(point, w, h)
	return rx + (x or 0) - px, ry + (y or 0) - py
end

-- The offsets from UIParent's relPoint that put a w x h frame's `point` where
-- its bottom-left is (left, bottom).
function M.OffsetOf(point, relPoint, left, bottom, w, h)
	local sw, sh = screen()
	local rx, ry = pointXY(relPoint or point, sw, sh)
	local px, py = pointXY(point, w, h)
	return left + px - rx, bottom + py - ry
end

-- A frame's units in UIParent's (its own scale, and its parents'); fallback
-- for a frame not built yet.
function M.Ratio(frame, fallback)
	if frame and frame.GetEffectiveScale then
		local u = UIParent:GetEffectiveScale()
		if u and u > 0 then return frame:GetEffectiveScale() / u end
	end
	return fallback or 1
end

-- The move along one axis that lands one of the box's edges or its centre
-- (pos, pos + size/2, pos + size) on the nearest target within th, and that
-- target; nil when none is that close.
local function nearest(pos, size, targets, th)
	local bestD, bestAt
	for i = 1, #targets do
		local t = targets[i]
		for k = 0, 2 do
			local d = t - (pos + size * k / 2)
			if abs(d) <= th and (not bestD or abs(d) < abs(bestD)) then bestD, bestAt = d, t end
		end
	end
	return bestD, bestAt
end

local function toGrid(pos, origin, g)
	return origin + floor((pos - origin) / g + 0.5) * g
end

-- The place a box dragged to (left, bottom) settles at. others: the other
-- boxes, { left, bottom, w, h } each. opts: { snap = true (screen centre
-- lines and edges, the other boxes' edges and centres), grid = px (lines out
-- from the screen's centre, where no snap took), threshold = px }. A snap
-- beats the grid on its axis; the box stays on screen.
-- -> left, bottom, guideX (the vertical line it snapped to) | nil, guideY | nil
function M.Snap(left, bottom, w, h, others, opts)
	opts = opts or {}
	local sw, sh = screen()
	local th = opts.threshold or M.SNAP
	local gx, gy
	if opts.snap ~= false then
		local xs, ys = { sw / 2, 0, sw }, { sh / 2, 0, sh }
		for _, o in ipairs(others or {}) do
			xs[#xs + 1] = o[1]
			xs[#xs + 1] = o[1] + o[3] / 2
			xs[#xs + 1] = o[1] + o[3]
			ys[#ys + 1] = o[2]
			ys[#ys + 1] = o[2] + o[4] / 2
			ys[#ys + 1] = o[2] + o[4]
		end
		local dx, ax = nearest(left, w, xs, th)
		local dy, ay = nearest(bottom, h, ys, th)
		if dx then left, gx = left + dx, ax end
		if dy then bottom, gy = bottom + dy, ay end
	end
	local g = tonumber(opts.grid)
	if g and g > 0 then
		if not gx then left = toGrid(left, sw / 2, g) end
		if not gy then bottom = toGrid(bottom, sh / 2, g) end
	end
	left = max(0, min(sw - w, left))
	bottom = max(0, min(sh - h, bottom))
	return left, bottom, gx, gy
end

---------------------------------------------------------------------------
-- Registry
---------------------------------------------------------------------------

local placeBox, refresh

function M.Register(spec)
	if type(spec) ~= "table" or type(spec.key) ~= "string" or spec.key == "" then return false, "Movers.Register: key must be a string" end
	if type(spec.get) ~= "function" or type(spec.set) ~= "function" then return false, "Movers.Register: get and set must be functions" end
	if not specs[spec.key] then order[#order + 1] = spec.key end
	specs[spec.key] = spec
	if unlocked then refresh() end
	return true
end

function M.Keys()
	local out = {}
	for i = 1, #order do out[i] = order[i] end
	return out
end

local function enabled(spec)
	if not spec.enabled then return true end
	return spec.enabled() and true or false
end

local function frameOf(spec)
	return spec.frame and spec.frame() or nil
end

-- The box's size: the frame's own once it has one, else size()'s.
local function sizeOf(spec)
	local f = not spec.fixedSize and frameOf(spec)
	if f then
		local w, h = f:GetWidth(), f:GetHeight()
		if w and h and w > 0 and h > 0 then
			local s = M.Ratio(f)
			return w * s, h * s
		end
	end
	if spec.size then
		local w, h = spec.size()
		if w and h then return w, h end
	end
	return 64, 32
end

-- Where key's box stands: left, bottom, w, h.
function M.Rect(key)
	local spec = specs[key]
	if not spec then return nil end
	local w, h = sizeOf(spec)
	local point, relPoint, x, y = spec.get()
	if type(point) ~= "string" then point, relPoint, x, y = "CENTER", "CENTER", 0, 0 end
	local left, bottom = M.RectOf(point, relPoint, tonumber(x) or 0, tonumber(y) or 0, w, h)
	return left, bottom, w, h
end

-- Moves key's frame so its box's bottom-left is (left, bottom), kept on
-- screen; saved through the frame's own set.
function M.MoveTo(key, left, bottom)
	local spec = specs[key]
	if not spec then return false end
	local _, _, w, h = M.Rect(key)
	local sw, sh = screen()
	left, bottom = max(0, min(sw - w, left)), max(0, min(sh - h, bottom))
	local point, relPoint
	if spec.anchor then point, relPoint = spec.anchor() end
	if type(point) ~= "string" then
		local p, rp = spec.get()
		point = type(p) == "string" and p or "CENTER"
		relPoint = type(rp) == "string" and rp or point
	end
	relPoint = relPoint or point
	local x, y = M.OffsetOf(point, relPoint, left, bottom, w, h)
	spec.set(point, relPoint, x, y)
	if unlocked and boxes[key] then placeBox(key) end
	return true
end

function M.Reset(key)
	local spec = specs[key]
	if not (spec and spec.reset) then return false end
	spec.reset()
	if unlocked and boxes[key] then placeBox(key) end
	return true
end

function M.ResetAll()
	for _, key in ipairs(order) do
		local spec = specs[key]
		if spec.reset then spec.reset() end
	end
	if unlocked then refresh() end
end

function M.IsUnlocked() return unlocked end
function M.Box(key) return boxes[key] end
function M.Selected() return selected and selected.psKey or nil end

---------------------------------------------------------------------------
-- The boxes
---------------------------------------------------------------------------

local function gridSize()
	local g = tonumber(ns.Get("movers.gridSize")) or 32
	for _, v in ipairs(M.GRID_SIZES) do if v == g then return g end end
	return 32
end

local function snapOpts()
	return { snap = ns.Get("movers.snap") ~= false, grid = ns.Get("movers.grid") and gridSize() or nil, threshold = M.SNAP }
end

local function paintBox(b)
	local r, g, bl = Theme.Accent()
	local on = b == selected or b == dragging or b.psHover
	for i = 1, 4 do b.Edges[i]:SetVertexColor(r, g, bl, on and 1 or 0.6) end
	b.Tint:SetVertexColor(r, g, bl, (b == selected or b == dragging) and 0.18 or (b.psHover and 0.1 or 0.04))
	local px = Theme.Pixel(b)
	b.Edges[1]:SetHeight(px)
	b.Edges[2]:SetHeight(px)
	b.Edges[3]:SetWidth(px)
	b.Edges[4]:SetWidth(px)
end

-- The selected box says where it stands (its centre from the screen's);
-- the others their size.
local function boxText(b)
	if b == selected or b == dragging then
		local sw, sh = screen()
		b.Size:SetText(format(L["%d, %d"], round(b.psLeft + b.psW / 2 - sw / 2), round(b.psBottom + b.psH / 2 - sh / 2)))
	else
		b.Size:SetText(format(L["%d × %d"], round(b.psW), round(b.psH)))
	end
end

-- The name inside a box roomy enough for it, else above it.
local function layoutText(b)
	b.Label:ClearAllPoints()
	b.Size:ClearAllPoints()
	local lw = max(b.Label:GetStringWidth(), b.Size:GetStringWidth())
	if b.psW >= lw + 12 and b.psH >= 38 then
		b.Label:SetPoint("BOTTOM", b, "CENTER", 0, 1)
		b.Size:SetPoint("TOP", b, "CENTER", 0, -2)
	else
		b.Size:SetPoint("BOTTOM", b, "TOP", 0, 4)
		b.Label:SetPoint("BOTTOM", b.Size, "TOP", 0, 2)
	end
end

local function selectBox(b)
	local was = selected
	selected = b
	if was and was ~= b then
		paintBox(was)
		boxText(was)
	end
	if b then
		paintBox(b)
		boxText(b)
		layoutText(b)
	end
end

local function showGuides(gx, gy)
	guides.X:SetShown(gx ~= nil)
	guides.Y:SetShown(gy ~= nil)
	if gx then
		guides.X:ClearAllPoints()
		guides.X:SetPoint("TOP", root, "TOPLEFT", gx, 0)
		guides.X:SetPoint("BOTTOM", root, "BOTTOMLEFT", gx, 0)
	end
	if gy then
		guides.Y:ClearAllPoints()
		guides.Y:SetPoint("LEFT", root, "BOTTOMLEFT", 0, gy)
		guides.Y:SetPoint("RIGHT", root, "BOTTOMRIGHT", 0, gy)
	end
end

local function setBox(b, left, bottom)
	b.psLeft, b.psBottom = left, bottom
	b:ClearAllPoints()
	b:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", left, bottom)
	boxText(b)
end

function placeBox(key)
	local b = boxes[key]
	if not b then return end
	local left, bottom, w, h = M.Rect(key)
	b.psW, b.psH = w, h
	b:SetSize(w, h)
	setBox(b, left, bottom)
	layoutText(b)
	paintBox(b)
end

local function others(key)
	local out = {}
	for k, b in pairs(boxes) do
		if k ~= key and b:IsShown() then out[#out + 1] = { b.psLeft, b.psBottom, b.psW, b.psH } end
	end
	return out
end

local function cursor()
	local x, y = GetCursorPosition()
	local s = UIParent:GetEffectiveScale()
	return x / s, y / s
end

-- The live frame follows the box while it is dragged: its own first point,
-- shifted by how far the box went (its module re-places it on the drop).
local function liveMove(b)
	local st = b.psFrame
	if not st or combat() then return end
	local s = st.s
	st.f:ClearAllPoints()
	st.f:SetPoint(st[1], st[2], st[3], st[4] + (b.psLeft - b.psStartLeft) / s, st[5] + (b.psBottom - b.psStartBottom) / s)
end

-- A drag to (left, bottom), before snapping. Shift keeps the box on the
-- axis it has moved along most.
function M.DragTo(key, left, bottom)
	local b = boxes[key]
	if not (b and dragging == b) then return end
	if IsShiftKeyDown and IsShiftKeyDown() then
		if abs(left - b.psStartLeft) >= abs(bottom - b.psStartBottom) then bottom = b.psStartBottom else left = b.psStartLeft end
	end
	local l, bt, gx, gy = M.Snap(left, bottom, b.psW, b.psH, others(key), snapOpts())
	if l ~= b.psLeft or bt ~= b.psBottom then b.psMoved = true end
	setBox(b, l, bt)
	showGuides(gx, gy)
	liveMove(b)
end

local function dragTick()
	local b = dragging
	if not b then
		root:SetScript("OnUpdate", nil)
		return
	end
	local cx, cy = cursor()
	M.DragTo(b.psKey, cx - b.psGrab[1], cy - b.psGrab[2])
end

local function beginDrag(b)
	dragging = b
	local cx, cy = cursor()
	b.psGrab = { cx - b.psLeft, cy - b.psBottom }
	b.psStartLeft, b.psStartBottom, b.psMoved = b.psLeft, b.psBottom, false
	b.psFrame = nil
	local f = frameOf(specs[b.psKey])
	if f and f:IsShown() and f:GetNumPoints() >= 1 then
		local p, rel, rp, x, y = f:GetPoint(1)
		if p then b.psFrame = { p, rel, rp, x or 0, y or 0, f = f, s = M.Ratio(f) } end
	end
	paintBox(b)
	root:SetScript("OnUpdate", ns.Safe(dragTick))
end

-- The drop: saved through the frame's own key (a box that never moved
-- leaves it be).
local function endDrag()
	local b = dragging
	if not b then return end
	dragging = nil
	root:SetScript("OnUpdate", nil)
	showGuides(nil, nil)
	if b.psMoved then
		M.MoveTo(b.psKey, b.psLeft, b.psBottom)
	else
		placeBox(b.psKey)
	end
	b.psFrame = nil
	paintBox(b)
end
M.EndDrag = endDrag

local function boxTip(b)
	W.Tooltip(b, "ANCHOR_TOP", b.Label:GetText(), {
		{ L["Drag to move it (Shift: along one line). Arrow keys nudge it, Shift for 10 px."], Theme.Color("textDim") },
		{ L["Right-click: back to its default place."], Theme.Color("textDim") },
	})
end

local function newBox(key)
	local b = CreateFrame("Button", nil, root)
	b.psKey = key
	b:EnableMouse(true)
	b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	b.Dim = W.Fill(b, "scrim", "BACKGROUND")
	W.Color(b.Dim, "scrim", 0.5)
	b.Tint = b:CreateTexture(nil, "BORDER")
	b.Tint:SetTexture(Theme.Media("white"))
	b.Tint:SetAllPoints(b)
	b.Edges = {}
	for i = 1, 4 do
		local t = b:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.Media("white"))
		b.Edges[i] = t
	end
	b.Edges[1]:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Edges[1]:SetPoint("TOPRIGHT", b, "TOPRIGHT", 0, 0)
	b.Edges[2]:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	b.Edges[2]:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
	b.Edges[3]:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
	b.Edges[3]:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	b.Edges[4]:SetPoint("TOPRIGHT", b, "TOPRIGHT", 0, 0)
	b.Edges[4]:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
	b.Label = W.Text(b, "label", "text")
	b.Size = W.Text(b, "small", "textDim")
	W.Painter(b, paintBox)
	b:SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" or combat() then return end
		selectBox(self)
		beginDrag(self)
	end)
	b:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" then
			if not dragging then M.Reset(self.psKey) end
		elseif dragging == self then
			endDrag()
		end
	end)
	b:SetScript("OnEnter", function(self)
		self.psHover = true
		paintBox(self)
		boxTip(self)
	end)
	b:SetScript("OnLeave", function(self)
		self.psHover = nil
		paintBox(self)
		W.HideTooltip(self)
	end)
	boxes[key] = b
	return b
end

---------------------------------------------------------------------------
-- The grid: 1px lines out from the screen's centre, an accent crosshair
---------------------------------------------------------------------------

local function drawGrid()
	if not gridFrame then
		gridFrame = CreateFrame("Frame", nil, root)
		gridFrame:SetAllPoints(root)
		gridFrame:SetFrameLevel(root:GetFrameLevel() + 1)
		gridFrame.lines = {}
	end
	local on = ns.Get("movers.grid") and true or false
	gridFrame:SetShown(on)
	if not on then return end
	local g = gridSize()
	local sw, sh = screen()
	local cx, cy = sw / 2, sh / 2
	local px = Theme.Pixel(gridFrame)
	local lr, lg, lb, la = Theme.Wash("divider")
	-- Finer grids lie fainter, so the world still reads through them.
	la = (la or 0.1) * (g >= 32 and 1.6 or g >= 16 and 1.2 or 0.9)
	local ar, ag, ab = Theme.Accent()
	local n = 0
	local function line(vertical, at, centre)
		n = n + 1
		local t = gridFrame.lines[n]
		if not t then
			t = gridFrame:CreateTexture(nil, "BACKGROUND")
			t:SetTexture(Theme.Media("white"))
			gridFrame.lines[n] = t
		end
		t:ClearAllPoints()
		if vertical then
			t:SetPoint("TOP", gridFrame, "TOPLEFT", at, 0)
			t:SetPoint("BOTTOM", gridFrame, "BOTTOMLEFT", at, 0)
			t:SetWidth(px)
		else
			t:SetPoint("LEFT", gridFrame, "BOTTOMLEFT", 0, at)
			t:SetPoint("RIGHT", gridFrame, "BOTTOMRIGHT", 0, at)
			t:SetHeight(px)
		end
		t:SetDrawLayer("BACKGROUND", centre and 1 or 0)
		if centre then t:SetVertexColor(ar, ag, ab, 0.7) else t:SetVertexColor(lr, lg, lb, la) end
		t:Show()
	end
	for k = 1, ceil(cx / g) do
		if cx + k * g < sw then line(true, cx + k * g) end
		if cx - k * g > 0 then line(true, cx - k * g) end
	end
	for k = 1, ceil(cy / g) do
		if cy + k * g < sh then line(false, cy + k * g) end
		if cy - k * g > 0 then line(false, cy - k * g) end
	end
	line(true, cx, true)
	line(false, cy, true)
	for i = n + 1, #gridFrame.lines do gridFrame.lines[i]:Hide() end
end
M.GridLines = function() return gridFrame and gridFrame.lines or {} end

---------------------------------------------------------------------------
-- The bar: Grid, its size, Snap, Reset all positions, Lock
---------------------------------------------------------------------------

local BAR_H, PAD = 56, 16

local function labelled(parent, text, get, set, tip)
	local s = W.Switch(parent, get, function(v) set(v) end, tip)
	s.Text = W.Text(parent, "label", "textDim")
	s.Text:SetText(text)
	s.Text:SetPoint("LEFT", s, "RIGHT", 2, 0)
	return s
end

local function paintSegments()
	local g, on = gridSize(), ns.Get("movers.grid") and true or false
	for _, seg in ipairs(bar.Segs) do
		local cur = seg.psValue == g
		W.Color(seg.Label, cur and "text" or "textDim")
		seg.Bar:SetShown(cur)
		seg:SetAlpha(on and 1 or 0.45)
		seg:SetEnabled(on)
	end
end

local function layoutBar()
	local x = PAD
	local tw = max(bar.Title:GetStringWidth(), bar.Hint:GetStringWidth())
	x = x + ceil(tw) + 20
	bar.Rule1:SetPoint("TOPLEFT", bar, "TOPLEFT", x - 10, -12)
	bar.Rule1:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", x - 10, 12)
	bar.Grid:SetPoint("LEFT", bar, "LEFT", x, 0)
	x = x + bar.Grid:GetWidth() + 2 + ceil(bar.Grid.Text:GetStringWidth()) + 10
	for _, seg in ipairs(bar.Segs) do
		local w = ceil(seg.Label:GetStringWidth()) + 16
		seg:SetSize(w, 28)
		seg:SetPoint("LEFT", bar, "LEFT", x, 0)
		x = x + w
	end
	x = x + 14
	bar.Snap:SetPoint("LEFT", bar, "LEFT", x, 0)
	x = x + bar.Snap:GetWidth() + 2 + ceil(bar.Snap.Text:GetStringWidth()) + 20
	bar.Rule2:SetPoint("TOPLEFT", bar, "TOPLEFT", x - 10, -12)
	bar.Rule2:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", x - 10, 12)
	bar.ResetAll:SetPoint("LEFT", bar, "LEFT", x, 0)
	x = x + bar.ResetAll:GetWidth() + 8
	bar.Lock:SetPoint("LEFT", bar, "LEFT", x, 0)
	x = x + bar.Lock:GetWidth() + PAD
	bar:SetWidth(x)
end

local function confirmResetAll()
	W.Modal({ title = L["Reset all positions?"], icon = "reset", danger = true, action = L["Reset all positions"],
		text = L["Every Polestar frame goes back to its default place."], onAccept = M.ResetAll })
end

local function buildBar()
	bar = CreateFrame("Frame", "PolestarMoversBar", root)
	bar:SetFrameLevel(root:GetFrameLevel() + 400)
	bar:SetPoint("TOP", UIParent, "TOP", 0, -12)
	bar:SetHeight(BAR_H)
	bar:EnableMouse(true)
	bar:SetClampedToScreen(true)
	bar.psLight = true
	Theme.Skin(bar, "window")
	bar.Title = W.Text(bar, "heading", "text")
	bar.Title:SetPoint("TOPLEFT", bar, "TOPLEFT", PAD, -11)
	bar.Title:SetText(L["Move Polestar's frames"])
	bar.Hint = W.Text(bar, "small", "textMuted")
	bar.Hint:SetPoint("TOPLEFT", bar, "TOPLEFT", PAD, -31)
	bar.Hint:SetText(L["Drag a box. Click one, then nudge it with the arrow keys."])
	bar.Rule1, bar.Rule2 = W.Divider(bar, true), W.Divider(bar, true)
	bar.Grid = labelled(bar, L["Grid"], function() return ns.Get("movers.grid") end,
		function(v) ns.Set("movers.grid", v and true or false) end, L["Lines to line frames up on; a dragged frame lands on them."])
	bar.Segs = {}
	for i, v in ipairs(M.GRID_SIZES) do
		local seg = CreateFrame("Button", nil, bar)
		seg.psValue = v
		seg.Label = W.Text(seg, "label", "textDim")
		seg.Label:SetPoint("CENTER", seg, "CENTER", 0, 0)
		seg.Label:SetText(format(L["%d px"], v))
		seg.Bar = W.Tex(seg, "ARTWORK", nil, "accent")
		seg.Bar:SetHeight(2)
		seg.Bar:SetPoint("BOTTOMLEFT", seg, "BOTTOMLEFT", 6, 2)
		seg.Bar:SetPoint("BOTTOMRIGHT", seg, "BOTTOMRIGHT", -6, 2)
		seg:SetScript("OnClick", function(self) ns.Set("movers.gridSize", self.psValue) end)
		bar.Segs[i] = seg
	end
	bar.Snap = labelled(bar, L["Snap"], function() return ns.Get("movers.snap") ~= false end,
		function(v) ns.Set("movers.snap", v and true or false) end, L["Frames line up with the screen's centre and with each other's edges as you drag."])
	bar.ResetAll = W.Button(bar, L["Reset all positions"], confirmResetAll, { danger = true, icon = "reset" })
	bar.Lock = W.Button(bar, L["Lock"], function() M.Lock() end, { primary = true, icon = "lock" })
	bar.Lock.psTip, bar.Lock.psTipLines = L["Lock"], { L["Also Escape."] }
	layoutBar()
end

local function refreshBar()
	bar.Grid:Refresh()
	bar.Snap:Refresh()
	paintSegments()
end

---------------------------------------------------------------------------
-- Unlock and lock
---------------------------------------------------------------------------

local NUDGE = { UP = { 0, 1 }, DOWN = { 0, -1 }, LEFT = { -1, 0 }, RIGHT = { 1, 0 } }

function M.Nudge(key, dx, dy)
	local b = boxes[key]
	if not b then return false end
	return M.MoveTo(key, b.psLeft + dx, b.psBottom + dy)
end

local function onKey(self, key)
	local handled = true
	if key == "ESCAPE" then
		M.Lock()
	elseif selected and NUDGE[key] and not dragging then
		local d = (IsShiftKeyDown and IsShiftKeyDown()) and M.NUDGE_SHIFT or M.NUDGE
		M.Nudge(selected.psKey, NUDGE[key][1] * d, NUDGE[key][2] * d)
		boxText(selected)
	else
		handled = false
	end
	if self.SetPropagateKeyboardInput and not combat() then self:SetPropagateKeyboardInput(not handled) end
end

local function build()
	root = CreateFrame("Frame", "PolestarMovers", UIParent)
	root:SetAllPoints(UIParent)
	root:SetFrameStrata("DIALOG")
	root:EnableMouse(false)
	root:EnableKeyboard(true)
	root:SetScript("OnKeyDown", onKey)
	root:Hide()
	guides = CreateFrame("Frame", nil, root)
	guides:SetAllPoints(root)
	guides:SetFrameLevel(root:GetFrameLevel() + 300)
	guides.X = W.Tex(guides, "OVERLAY", nil, "accent")
	guides.Y = W.Tex(guides, "OVERLAY", nil, "accent")
	W.Painter(guides, function(g)
		local px = Theme.Pixel(g)
		g.X:SetWidth(px)
		g.Y:SetHeight(px)
	end)
	guides.X:Hide()
	guides.Y:Hide()
	buildBar()
end

-- Every enabled frame's box, the smaller ones over the bigger, so a box
-- inside another stays within reach; withGrid: the grid and the bar too.
function refresh(withGrid)
	if not root then return end
	local shown = {}
	for _, key in ipairs(order) do
		local spec = specs[key]
		local b = boxes[key]
		if enabled(spec) then
			b = b or newBox(key)
			b.Label:SetText(spec.label or key)
			placeBox(key)
			b:Show()
			shown[#shown + 1] = b
		elseif b then
			if selected == b then selected = nil end
			b:Hide()
		end
	end
	sort(shown, function(a, b) return a.psW * a.psH > b.psW * b.psH end)
	local base = root:GetFrameLevel() + 10
	for i, b in ipairs(shown) do b:SetFrameLevel(base + i * 2) end
	if withGrid then
		drawGrid()
		refreshBar()
	end
end
M.Refresh = function() if unlocked then refresh(true) end end

local function onCombat()
	if not unlocked then return end
	M.Lock()
	ns.Print(L["Frames locked for the fight."])
end

local function onResize()
	if unlocked then refresh(true) end
end

function M.Unlock(key)
	if combat() then
		ns.Print(L["You can't move frames in combat."])
		return false
	end
	if not root then build() end
	if not unlocked then
		unlocked = true
		ns.RegisterEvent("PLAYER_REGEN_DISABLED", onCombat)
		ns.RegisterEvent("DISPLAY_SIZE_CHANGED", onResize)
		ns.RegisterEvent("UI_SCALE_CHANGED", onResize)
		root:Show()
		refresh(true)
	end
	if key and boxes[key] and boxes[key]:IsShown() then selectBox(boxes[key]) end
	return true
end

function M.Lock()
	if not unlocked then return end
	if dragging then endDrag() end
	unlocked = false
	selectBox(nil)
	root:SetScript("OnUpdate", nil)
	root:Hide()
	if W.ModalShown and W.ModalShown() then W.HideModal() end
	ns.UnregisterEvent("PLAYER_REGEN_DISABLED", onCombat)
	ns.UnregisterEvent("DISPLAY_SIZE_CHANGED", onResize)
	ns.UnregisterEvent("UI_SCALE_CHANGED", onResize)
end

function M.Toggle()
	if unlocked then
		M.Lock()
		return true
	end
	return M.Unlock()
end

-- A position changed elsewhere (a reset in Options, a profile switch), or a
-- frame's size: the boxes follow while they are up; the grid on its own keys.
ns.On("SETTING_CHANGED", function(path)
	if not unlocked or dragging then return end
	refresh(path == "" or path == "movers" or (type(path) == "string" and path:sub(1, 7) == "movers."))
end)

ns.RegisterCommand("unlock", function() M.Toggle() end, L["Move Polestar's frames (again to lock them)"])
ns.RegisterCommand("lock", function() M.Lock() end, L["Lock Polestar's frames in place"])

---------------------------------------------------------------------------
-- Polestar's own frames
--
-- Each keeps its saved key and its format, read and written here in the
-- frame's own units (its scale): the guide window ui.pos { left, top or
-- bottom }, the arrow nav.arrowPos { point, relPoint, x, y }, the floating
-- button ui.launcherPos { centre x, y }, the quest buttons the character's
-- qol.buttonPos { point, relPoint, x, y }, the compact frames { "CENTER", x,
-- y } (maps.timerPos, maps.trackerPos, party.panelPos), and the alerts
-- { point, x, y } (rares.toastPoint, toasts.transport.point,
-- toasts.whilehere.point). The defaults are the modules' own (the test
-- ui-movers.rs holds them to where each module puts its frame).
---------------------------------------------------------------------------

local function G(name) return function() return _G[name] end end

local function num(v) return type(v) == "number" end

-- A frame saved as { point, x, y } (the point also UIParent's).
local function pointFormat(spec, posKey, default)
	local frame = spec.frame
	local function s() return M.Ratio(frame(), 1) end
	spec.get = function()
		local p = ns.Get(posKey)
		if type(p) ~= "table" or type(p[1]) ~= "string" then p = default end
		local k = s()
		return p[1], p[1], (tonumber(p[2]) or 0) * k, (tonumber(p[3]) or 0) * k
	end
	spec.anchor = function()
		local p = ns.Get(posKey)
		local point = type(p) == "table" and type(p[1]) == "string" and p[1] or default[1]
		return point, point
	end
	spec.set = function(point, _, x, y)
		local k = s()
		ns.Set(posKey, { point, round(x / k), round(y / k) })
	end
	spec.reset = function() ns.Set(posKey, nil) end
	return M.Register(spec)
end

-- The guide window: ui.pos holds its top-left corner (bottom-left with Grow
-- upward) from the screen's bottom-left; unset, UI/GuideFrame.lua pins it by
-- its top-right (bottom-right) corner 64 in, 240 down (up).
local guideFrame = G("PolestarGuideFrame")
local function guideScale() return M.Ratio(guideFrame(), ns.Get("ui.scale") or 1) end
M.Register({
	key = "guide", label = L["Guide window"], frame = guideFrame,
	size = function()
		local k = guideScale()
		return (ns.Get("ui.width") or 340) * k, 200 * k
	end,
	get = function()
		local k, pos, up = guideScale(), ns.Get("ui.pos"), ns.Get("ui.growUp")
		if type(pos) == "table" and num(pos[1]) and num(pos[2]) then
			return up and "BOTTOMLEFT" or "TOPLEFT", "BOTTOMLEFT", pos[1] * k, pos[2] * k
		end
		if up then return "BOTTOMRIGHT", "BOTTOMRIGHT", -64 * k, 240 * k end
		return "TOPRIGHT", "TOPRIGHT", -64 * k, -240 * k
	end,
	anchor = function() return ns.Get("ui.growUp") and "BOTTOMLEFT" or "TOPLEFT", "BOTTOMLEFT" end,
	set = function(_, _, x, y)
		local k = guideScale()
		ns.Set("ui.pos", { round(x / k), round(y / k) })
	end,
	reset = function() ns.Set("ui.pos", nil) end,
})

-- The arrow (Nav/Arrow.lua): nav.arrowPos, unset its top 140 under the
-- screen's top centre; it is scaled by nav.arrowScale.
if ns.Nav then
	local arrow = G("PolestarNavArrow")
	local function k() return M.Ratio(arrow(), ns.Get("nav.arrowScale") or 1) end
	M.Register({
		key = "arrow", label = L["Arrow"], frame = arrow,
		enabled = function() return ns.Get("nav.arrow") ~= false end,
		size = function() return 200 * k(), 130 * k() end,
		get = function()
			local pos, s = ns.Get("nav.arrowPos"), k()
			if type(pos) == "table" and type(pos.point) == "string" then
				return pos.point, pos.relPoint or pos.point, (tonumber(pos.x) or 0) * s, (tonumber(pos.y) or 0) * s
			end
			return "TOP", "TOP", 0, -140 * s
		end,
		set = function(point, relPoint, x, y)
			local s = k()
			ns.Set("nav.arrowPos", { point = point, relPoint = relPoint, x = round(x / s), y = round(y / s) })
		end,
		reset = function()
			if ns.Nav.ResetArrowPosition then ns.Nav.ResetArrowPosition() else ns.Set("nav.arrowPos", nil) end
		end,
	})
end

-- The floating button (UI/Launcher.lua): ui.launcherPos, its centre from the
-- screen's bottom-left; unset, 440 in from the right and 256 down.
do
	local launcher = G("PolestarLauncher")
	local function k() return M.Ratio(launcher(), 1) end
	M.Register({
		key = "launcher", label = L["Floating button"], frame = launcher,
		enabled = function() return ns.Get("ui.launcher") and true or false end,
		size = function() return 32 * k(), 32 * k() end,
		get = function()
			local pos, s = ns.Get("ui.launcherPos"), k()
			if type(pos) == "table" and num(pos[1]) and num(pos[2]) then return "CENTER", "BOTTOMLEFT", pos[1] * s, pos[2] * s end
			return "CENTER", "TOPRIGHT", -440 * s, -256 * s
		end,
		anchor = function() return "CENTER", "BOTTOMLEFT" end,
		set = function(_, _, x, y)
			local s = k()
			ns.Set("ui.launcherPos", { round(x / s), round(y / s) })
		end,
		reset = function() ns.Set("ui.launcherPos", nil) end,
	})
end

-- The quest buttons (QoL/Buttons.lua): the holder is the quest item button's
-- slot, the others laid out round it (Buttons.Offsets: a column or a row,
-- each at its own size); the box covers them all. Its spot is the
-- character's (qol.buttonPos), in the holder's units (qol.buttonScale).
local B = ns.QoL and ns.QoL.Buttons
if B and B.SavedPos and B.SetPosition and B.Offsets and B.Size then
	local function k() return M.Ratio(B.Holder(), ns.Get("qol.buttonScale") or 1) end
	-- The set's edges from the holder's centre, in button pixels.
	local function edges()
		local x0, x1, y0, y1 = 0, 0, 0, 0
		for kind, o in pairs(B.Offsets()) do
			local h = B.Size(kind) / 2
			x0, x1 = min(x0, o[1] - h), max(x1, o[1] + h)
			y0, y1 = min(y0, o[2] - h), max(y1, o[2] + h)
		end
		return x0, x1, y0, y1
	end
	-- The holder's centre in UIParent's units.
	local function holderCentre()
		local p, s = B.SavedPos(), k()
		local hs = B.Size("item") * s
		local l, b = M.RectOf(p[1], p[2], (tonumber(p[3]) or 0) * s, (tonumber(p[4]) or 0) * s, hs, hs)
		return l + hs / 2, b + hs / 2
	end
	M.Register({
		key = "buttons", label = L["Quest buttons"], frame = B.Holder, fixedSize = true,
		size = function()
			local x0, x1, y0, y1 = edges()
			local s = k()
			return (x1 - x0) * s, (y1 - y0) * s
		end,
		get = function()
			local cx, cy = holderCentre()
			local x0, _, y0 = edges()
			local s = k()
			return "BOTTOMLEFT", "BOTTOMLEFT", cx + x0 * s, cy + y0 * s
		end,
		anchor = function() return "BOTTOMLEFT", "BOTTOMLEFT" end,
		set = function(_, _, x, y)
			local p, s = B.SavedPos(), k()
			local x0, _, y0 = edges()
			local hs = B.Size("item") * s
			local cx, cy = x - x0 * s, y - y0 * s
			local ox, oy = M.OffsetOf(p[1], p[2], cx - hs / 2, cy - hs / 2, hs, hs)
			B.SetPosition({ p[1], p[2], round(ox / s), round(oy / s) })
		end,
		reset = function() B.SetPosition(nil) end,
	})
end

-- The compact frames (Maps.CompactFrame): saved as { "CENTER", x, y } once
-- dragged; their modules re-place them on the setting's change.
if ns.Maps then
	pointFormat({ key = "flightTimer", label = L["Flight timer"], frame = G("PolestarFlightTimer"),
		enabled = function() return ns.Get("maps.flightTimer") ~= false end,
		size = function() return 220, 34 end }, "maps.timerPos", { "TOP", 0, -140 })
	pointFormat({ key = "instances", label = L["Instance tracker"], frame = G("PolestarInstanceTracker"),
		enabled = function() return ns.Get("maps.instances") ~= false end,
		size = function() return 230, 30 end }, "maps.trackerPos", { "TOPRIGHT", -220, -220 })
end
if ns.Party then
	pointFormat({ key = "party", label = L["Party panel"], frame = G("PolestarPartyPanel"),
		enabled = function() return ns.Get("party.panel") ~= false end,
		size = function() return 260, 96 end }, "party.panelPos", { "TOPLEFT", 280, -220 })
end

-- The alerts: the rare alert (Rares/Toast.lua, rares.toastPoint), the
-- transport alert and Polestar's notices (Nav/Alerts.lua,
-- toasts.transport.point) and the While you're here card (UI/WhileHere.lua,
-- toasts.whilehere.point); each module re-places its card on the change.
-- While the alerts line up (toasts.stack) they hang from one line, which
-- UI/Looks/Toasts.lua registers as its own mover, so these step aside.
-- Registered once every file has loaded: Rares loads after UI.
local function own(fn) return function() return ns.Get("toasts.stack") ~= true and fn() end end
ns.OnInit(function()
	if ns.Rares and ns.Rares.Toast then
		pointFormat({ key = "rareAlert", label = L["Rare alert"], frame = G("PolestarRareToast"),
			enabled = own(function() return ns.Get("rares.alerts") ~= false end),
			size = function() return 368, 104 end }, "rares.toastPoint", { "TOP", 0, -132 })
	end
	if ns.Nav and ns.Nav.alerts then
		pointFormat({ key = "transportAlert", label = L["Transport alert"], frame = G("PolestarAlert"),
			enabled = own(function() return ns.Get("nav.alerts") ~= false and ns.Get("nav.alertBanner") ~= false end),
			size = function() return 320, 56 end }, "toasts.transport.point", { "TOP", 0, -72 })
	end
	pointFormat({ key = "whileHere", label = L["While you're here"], frame = G("PolestarWhileHereToast"),
		enabled = own(function() return ns.Get("behavior.whileHere") ~= false end),
		size = function() return 320, 46 end }, "toasts.whilehere.point", { "TOP", 0, -150 })
end)

---------------------------------------------------------------------------
-- Settings: Guide > Window > Position
---------------------------------------------------------------------------

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Window"], section = L["Position"],
		controls = {
			{ kind = "button", icon = "resize", button = L["Unlock"], label = L["Move frames"], new = "0.3.7",
				help = L["A box over each of Polestar's frames (the guide window, the arrow, the buttons, the alerts and the trackers) to drag where you want it, with a grid and snapping. Also /polestar unlock."],
				search = "move, unlock, drag, position, place, layout, edit mode, mover, movers, arrange, reposition, anchor, grid, snap, align, nudge",
				onClick = function() M.Unlock() end },
			{ kind = "toggle", key = "movers.snap", label = L["Snap while moving"], new = "0.3.7",
				help = L["A dragged frame lines up with the screen's centre and with the other frames' edges and centres."],
				search = "snap, align, line up, magnet, guides, edges, centre, center" },
			{ kind = "toggle", key = "movers.grid", label = L["Grid"], new = "0.3.7",
				help = L["Lines to line frames up on while they are unlocked; a dragged frame lands on them."],
				search = "grid, lines, align, snap, layout" },
			{ kind = "dropdown", key = "movers.gridSize", label = L["Grid size"], new = "0.3.7", child = true,
				disabled = function() return not ns.Get("movers.grid") end,
				help = L["How far apart the grid's lines are."], search = "grid size, spacing, finer, coarser, pixels",
				choices = { { value = 8, label = format(L["%d px"], 8) }, { value = 16, label = format(L["%d px"], 16) }, { value = 32, label = format(L["%d px"], 32) } } },
			{ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset all positions"], new = "0.3.7", confirm = true,
				help = L["Every Polestar frame goes back to its default place."],
				search = "reset positions, default place, move back, restore layout",
				onClick = function() M.ResetAll() end },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
