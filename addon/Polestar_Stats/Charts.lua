-- The Stats section's drawing kit: cards, bar rows, columns and a line chart,
-- painted from the theme's tokens. A page draws with font strings, textures
-- and lines taken from a pool that is rewound on every render (regions
-- cannot be destroyed), so opening a page or changing the look makes nothing
-- new once the pool has grown to the page's size.
--
--   local p = Charts.Pool(parent)
--   Charts.Reset(p)                       -- before each render
--   Charts.Text(p, role, color, text, x, y[, width]) -> font string (top-left at x, -y)
--   Charts.Rect(p, layer, x, y, w, h, color[, alpha]) -> texture; color: a palette name, a wash ("wash:track") or { r, g, b }
--   Charts.Blob(p, x, y, size, color[, alpha]) -> texture: a round soft-edged mark centred on (x, y)
--   Charts.Segment(p, x1, y1, x2, y2, color[, thickness[, alpha]]) -> line
--   Charts.Cards(p, y, width, { { label, value }, ... }) -> y below
--   Charts.Heading(p, y, title) -> y below
--   Charts.Note(p, y, width, text) -> y below
--   Charts.Bars(p, y, width, { { label, amount, text }, ... }[, color[, whole]]) -> y below
--   Charts.Columns(p, y, width, height, first, last, values, labelOf) -> y below
--   Charts.Line(p, y, width, height, series, format, empty) -> y below   -- series: { { t, value }, ... }
--   Charts.Table(p, y, { { text, x, width[, color] }, ... }) -> y below  -- one row of cells
--
-- y runs down the page from 0 (positive numbers); every helper returns the
-- y its content ends at. Charts.Counts(p) -> fonts, rects, lines in use.

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local Stats = ns.Stats
local max, min, floor, ipairs = math.max, math.min, math.floor, ipairs

if not (Stats and Theme and W) then return end

local Charts = {}
Stats.Charts = Charts

local WHITE = Theme.Media("white")
local BLOB = "Interface\\AddOns\\Polestar\\Media\\Map\\blob"
local CARD_H, CARD_GAP = 58, 12
local ROW_H = 22
local LABEL_W, VALUE_W = 170, 170

function Charts.Pool(parent)
	return { parent = parent, fonts = {}, rects = {}, lines = {}, blobs = {}, nFonts = 0, nRects = 0, nLines = 0, nBlobs = 0 }
end

function Charts.Reset(p)
	for _, fs in ipairs(p.fonts) do fs:Hide() end
	for _, t in ipairs(p.rects) do t:Hide() end
	for _, l in ipairs(p.lines) do l:Hide() end
	for _, t in ipairs(p.blobs) do t:Hide() end
	p.nFonts, p.nRects, p.nLines, p.nBlobs = 0, 0, 0, 0
end

function Charts.Counts(p) return p.nFonts, p.nRects, p.nLines end

-- A palette colour by name, a wash as "wash:<role>", or a colour of its own
-- as { r, g, b[, a] } (the map's marks: they sit on the map art, not the theme).
local function rgba(color, alpha)
	if type(color) == "table" then return color[1], color[2], color[3], (color[4] or 1) * (alpha or 1) end
	local r, g, b, a
	local wash = type(color) == "string" and color:match("^wash:(.+)$")
	if wash then r, g, b, a = Theme.Wash(wash) else r, g, b, a = Theme.Color(color or "text") end
	return r, g, b, (a or 1) * (alpha or 1)
end
Charts.RGBA = rgba

function Charts.Text(p, role, color, text, x, y, width)
	p.nFonts = p.nFonts + 1
	local fs = p.fonts[p.nFonts]
	if not fs then
		fs = p.parent:CreateFontString(nil, "OVERLAY")
		p.fonts[p.nFonts] = fs
	end
	Theme.Font(fs, role or "body")
	fs:ClearAllPoints()
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	fs:SetWordWrap(false)
	fs:SetWidth(width or 0)
	fs:SetTextColor(rgba(color))
	fs:SetText(text or "")
	if x then fs:SetPoint("TOPLEFT", p.parent, "TOPLEFT", x, -(y or 0)) end
	fs:Show()
	return fs
end

function Charts.Rect(p, layer, x, y, w, h, color, alpha)
	p.nRects = p.nRects + 1
	local t = p.rects[p.nRects]
	if not t then
		t = p.parent:CreateTexture(nil, layer or "ARTWORK")
		t:SetTexture(WHITE)
		p.rects[p.nRects] = t
	end
	t:SetDrawLayer(layer or "ARTWORK")
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", p.parent, "TOPLEFT", x, -y)
	t:SetSize(max(1, w), max(1, h))
	t:SetVertexColor(rgba(color, alpha))
	t:Show()
	return t
end

-- Drawn in the order they are asked for: a later blob lies over an earlier one.
function Charts.Blob(p, x, y, size, color, alpha)
	p.nBlobs = p.nBlobs + 1
	local t = p.blobs[p.nBlobs]
	if not t then
		t = p.parent:CreateTexture(nil, "ARTWORK")
		t:SetTexture(BLOB)
		p.blobs[p.nBlobs] = t
	end
	t:ClearAllPoints()
	t:SetPoint("CENTER", p.parent, "TOPLEFT", x, -y)
	t:SetSize(size, size)
	t:SetVertexColor(rgba(color, alpha))
	t:Show()
	return t
end

local function segment(p, x1, y1, x2, y2, color, thickness, alpha)
	p.nLines = p.nLines + 1
	local l = p.lines[p.nLines]
	if not l then
		l = p.parent:CreateLine(nil, "OVERLAY")
		p.lines[p.nLines] = l
	end
	l:SetStartPoint("TOPLEFT", p.parent, x1, -y1)
	l:SetEndPoint("TOPLEFT", p.parent, x2, -y2)
	l:SetColorTexture(rgba(color, alpha))
	l:SetThickness(thickness or 1)
	l:Show()
	return l
end

Charts.Segment = segment

function Charts.Heading(p, y, title)
	Charts.Text(p, "heading", "accent", title, 0, y)
	return y + 30
end

function Charts.Note(p, y, width, text)
	local fs = Charts.Text(p, "note", "textDim", text, 0, y, width)
	fs:SetWordWrap(true)
	return y + max(16, floor((fs:GetStringHeight() or 16) + 0.5)) + 8
end

-- A row of equal cards across the page: a muted label over a large value.
function Charts.Cards(p, y, width, cards)
	local n = #cards
	local w = (width - CARD_GAP * (n - 1)) / n
	for i, c in ipairs(cards) do
		local x = (i - 1) * (w + CARD_GAP)
		Charts.Rect(p, "BACKGROUND", x, y, w, CARD_H, "panel")
		Charts.Rect(p, "BORDER", x, y, w, 1, "wash:border")
		Charts.Text(p, "small", "textMuted", c[1], x + 10, y + 9, w - 20)
		Charts.Text(p, "title", "text", c[2], x + 10, y + 28, w - 20)
	end
	return y + CARD_H + CARD_GAP
end

local function meter(p, x, y, w, h, frac, color)
	Charts.Rect(p, "BORDER", x, y, w, h, "wash:track")
	frac = max(0, min(1, frac or 0))
	if frac > 0 then Charts.Rect(p, "ARTWORK", x, y, w * frac, h, color or "accent") end
end
Charts.Meter = meter

-- Rows of "label, bar, value", scaled to the largest amount (or to `whole`).
function Charts.Bars(p, y, width, rows, color, whole)
	local peak = whole or 0
	if not whole then for _, r in ipairs(rows) do peak = max(peak, r[2] or 0) end end
	local barW = max(40, width - LABEL_W - VALUE_W - 24)
	for _, r in ipairs(rows) do
		Charts.Text(p, "body", "text", r[1], 0, y, LABEL_W)
		meter(p, LABEL_W + 12, y + 3, barW, 10, peak > 0 and (r[2] or 0) / peak or 0, color)
		Charts.Text(p, "body", "textDim", r[3], LABEL_W + 24 + barW, y, VALUE_W)
		y = y + ROW_H
	end
	return y + 6
end

-- Vertical bars for values[first..last], each labelled underneath.
function Charts.Columns(p, y, width, height, first, last, values, labelOf)
	local n = last - first + 1
	local colW = width / n
	local barW = max(2, colW - 4)
	local peak = 1
	for i = first, last do peak = max(peak, values[i] or 0) end
	for i = first, last do
		local x = (i - first) * colW
		local fill = max(1, (height - 2) * (values[i] or 0) / peak)
		Charts.Rect(p, "BORDER", x, y, barW, height, "wash:track")
		Charts.Rect(p, "ARTWORK", x, y + height - fill, barW, fill, "accent")
		local fs = Charts.Text(p, "caption", "textMuted", labelOf(i), x, y + height + 4, barW)
		fs:SetJustifyH("CENTER")
	end
	return y + height + 26
end

-- A line through the series, spaced evenly by sample so time away from the
-- game does not stretch it. Fewer than two samples: `empty` in its place.
function Charts.Line(p, y, width, height, series, format, empty)
	Charts.Rect(p, "BORDER", 0, y, width, height, "wash:track")
	local n = #series
	if n < 2 then
		Charts.Text(p, "note", "textDim", empty, 10, y + height / 2 - 7, width - 20)
		return y + height + 12
	end
	local steps = min(n, 160)
	local lo, hi = math.huge, -math.huge
	for _, pt in ipairs(series) do lo, hi = min(lo, pt[2]), max(hi, pt[2]) end
	local range = hi > lo and hi - lo or 1
	local px, py
	for i = 1, steps do
		local pt = series[floor((i - 1) / (steps - 1) * (n - 1) + 0.5) + 1]
		local x = (i - 1) / (steps - 1) * width
		local yy = y + height - 4 - (pt[2] - lo) / range * (height - 8)
		if px then segment(p, px, py, x, yy, "accent", 2) end
		px, py = x, yy
	end
	Charts.Text(p, "caption", "textMuted", format(hi), 6, y + 4)
	Charts.Text(p, "caption", "textMuted", format(lo), 6, y + height - 16)
	return y + height + 12
end

-- One row of cells: { text, x, width, color }.
function Charts.Table(p, y, cells)
	for _, c in ipairs(cells) do Charts.Text(p, "body", c[4] or "text", c[1], c[2], y, c[3]) end
	return y + ROW_H
end
