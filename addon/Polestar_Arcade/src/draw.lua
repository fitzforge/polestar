-- Draw backend: turns renderer quads into pooled WoW textures.
-- Coordinates are in Doom's logical 320x200 screen space.
local D = FreedoomArcade
local Draw = {}
D.Draw = Draw

local layers = {}
local layerList = {}
local root -- frame that hosts all layers
local sx, sy = 2, 2.4
local baseLevel = 1

Draw.stats = { quads = 0, setTexture = 0 }

function Draw.Init(parent)
	root = parent
	baseLevel = parent:GetFrameLevel() + 1
end

function Draw.SetScale(width, height)
	sx = width / 320
	sy = height / 200
	-- force every texture to re-anchor
	for _, lay in ipairs(layerList) do
		for _, t in ipairs(lay.tex) do t.dx1 = nil end
	end
end

local function getLayer(l)
	local lay = layers[l]
	if lay then return lay end
	local f = CreateFrame("Frame", nil, root)
	f:SetAllPoints(root)
	f:SetFrameLevel(baseLevel + l)
	lay = { frame = f, tex = {}, n = 0, used = 0, id = l }
	layers[l] = lay
	layerList[#layerList + 1] = lay
	table.sort(layerList, function(a, b) return a.id < b.id end)
	return lay
end

local function newTexture(lay)
	local t = lay.frame:CreateTexture(nil, "ARTWORK")
	if t.SetSnapToPixelGrid then
		t:SetSnapToPixelGrid(false)
		t:SetTexelSnappingBias(0)
	end
	t:Hide()
	lay.tex[#lay.tex + 1] = t
	return t
end

function Draw.Quad(l, x1, y1, x2, y2, tex, ulx, uly, llx, lly, urx, ury, lrx, lry, r, g, b, a)
	local lay = layers[l] or getLayer(l)
	local n = lay.n + 1
	lay.n = n
	local t = lay.tex[n] or newTexture(lay)
	if t.dtex ~= tex then
		t.dtex = tex
		t.dr = nil
		if tex.wrap then
			t:SetTexture(tex.path, "REPEAT", "REPEAT", "NEAREST")
		else
			t:SetTexture(tex.path, "CLAMP", "CLAMP", "NEAREST")
		end
	end
	local px1, py1 = x1 * sx, y1 * sy
	if t.dx1 ~= px1 or t.dy1 ~= py1 then
		t.dx1, t.dy1 = px1, py1
		t:SetPoint("TOPLEFT", lay.frame, "TOPLEFT", px1, -py1)
	end
	local w, h = (x2 - x1) * sx, (y2 - y1) * sy
	if t.dw ~= w or t.dh ~= h then
		t.dw, t.dh = w, h
		t:SetSize(w, h)
	end
	t:SetTexCoord(ulx, uly, llx, lly, urx, ury, lrx, lry)
	if t.dr ~= r or t.dg ~= g or t.db ~= b or t.da ~= a then
		t.dr, t.dg, t.db, t.da = r, g, b, a
		t:SetVertexColor(r, g, b, a)
	end
	if not t.shown then
		t.shown = true
		t:Show()
	end
end

-- solid colour rectangle
local colorTex = { color = true }
function Draw.Rect(l, x1, y1, x2, y2, r, g, b, a)
	local lay = layers[l] or getLayer(l)
	local n = lay.n + 1
	lay.n = n
	local t = lay.tex[n] or newTexture(lay)
	if t.dtex ~= colorTex then
		t.dtex = colorTex
		t.dr = nil
		t:SetTexCoord(0, 1, 0, 1)
	end
	if t.dr ~= r or t.dg ~= g or t.db ~= b or t.da ~= a then
		t.dr, t.dg, t.db, t.da = r, g, b, a
		t:SetColorTexture(r, g, b, a)
		t:SetVertexColor(1, 1, 1, 1)
	end
	local px1, py1 = x1 * sx, y1 * sy
	if t.dx1 ~= px1 or t.dy1 ~= py1 then
		t.dx1, t.dy1 = px1, py1
		t:SetPoint("TOPLEFT", lay.frame, "TOPLEFT", px1, -py1)
	end
	local w, h = (x2 - x1) * sx, (y2 - y1) * sy
	if t.dw ~= w or t.dh ~= h then
		t.dw, t.dh = w, h
		t:SetSize(w, h)
	end
	if not t.shown then
		t.shown = true
		t:Show()
	end
end

-- draw a patch graphic (HUD/menu) at Doom screen coords, honouring its offsets
function Draw.Patch(l, x, y, tex, r, g, b, a, flip)
	if not tex then return end
	x = x - tex.lo
	y = y - tex.to
	local u2, v2 = tex.w / tex.pw, tex.h / tex.ph
	local u1 = 0
	if flip then u1, u2 = u2, 0 end
	r = r or 1
	Draw.Quad(l, x, y, x + tex.w, y + tex.h, tex, u1, 0, u1, v2, u2, 0, u2, v2, r, g or r, b or r, a or 1)
end

-- same, but scaled to a box (used for full screen pictures)
function Draw.PatchStretched(l, x1, y1, x2, y2, tex)
	if not tex then return end
	local u2, v2 = tex.w / tex.pw, tex.h / tex.ph
	Draw.Quad(l, x1, y1, x2, y2, tex, 0, 0, 0, v2, u2, 0, u2, v2, 1, 1, 1, 1)
end

-- thin line in Doom screen coords (uses WoW Line regions)
function Draw.Line(l, x1, y1, x2, y2, r, g, b, a, thickness)
	local lay = layers[l] or getLayer(l)
	local n = (lay.ln or 0) + 1
	lay.ln = n
	local lines = lay.lines
	if not lines then lines = {}; lay.lines = lines end
	local ln = lines[n]
	if not ln then
		ln = lay.frame:CreateLine(nil, "ARTWORK")
		ln:Hide()
		lines[n] = ln
	end
	local px1, py1, px2, py2 = x1 * sx, -y1 * sy, x2 * sx, -y2 * sy
	if ln.x1 ~= px1 or ln.y1 ~= py1 or ln.x2 ~= px2 or ln.y2 ~= py2 then
		ln.x1, ln.y1, ln.x2, ln.y2 = px1, py1, px2, py2
		ln:SetStartPoint("TOPLEFT", lay.frame, px1, py1)
		ln:SetEndPoint("TOPLEFT", lay.frame, px2, py2)
	end
	local th = (thickness or 1) * sx * 0.6
	if th < 1 then th = 1 end
	if ln.th ~= th then
		ln.th = th
		ln:SetThickness(th)
	end
	a = a or 1
	if ln.r ~= r or ln.g ~= g or ln.b ~= b or ln.a ~= a then
		ln.r, ln.g, ln.b, ln.a = r, g, b, a
		ln:SetColorTexture(r, g, b, a)
	end
	if not ln.shown then
		ln.shown = true
		ln:Show()
	end
end

function Draw.Begin()
	for i = 1, #layerList do
		layerList[i].n = 0
		layerList[i].ln = 0
	end
end

function Draw.End()
	local total = 0
	for i = 1, #layerList do
		local lay = layerList[i]
		local n = lay.n
		total = total + n
		local texs = lay.tex
		for j = n + 1, lay.used do
			local t = texs[j]
			if t.shown then
				t.shown = false
				t:Hide()
			end
		end
		lay.used = n
		local lines = lay.lines
		if lines then
			local ln = lay.ln or 0
			for j = ln + 1, (lay.lused or 0) do
				local l = lines[j]
				if l.shown then l.shown = false; l:Hide() end
			end
			lay.lused = ln
			total = total + ln
		end
	end
	Draw.stats.quads = total
end

function Draw.HideAll()
	for i = 1, #layerList do
		local lay = layerList[i]
		for _, t in ipairs(lay.tex) do
			if t.shown then t.shown = false; t:Hide() end
		end
		for _, l in ipairs(lay.lines or {}) do
			if l.shown then l.shown = false; l:Hide() end
		end
		lay.lused, lay.ln = 0, 0
		lay.used = 0
		lay.n = 0
	end
end

function Draw.TextureCount()
	local c = 0
	for i = 1, #layerList do c = c + #layerList[i].tex end
	return c
end
