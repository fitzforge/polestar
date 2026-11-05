-- Zone art: a zone's world map painting, drawn from the player's own client
-- the way the world map draws it (C_Map.GetMapArtLayers and
-- GetMapArtLayerTextures), with every overlay laid over it so the zone shows
-- whole, without fog of war, framed around a place. Polestar ships none of the
-- art, only file IDs (UI/ZoneArtOverlays.lua). Without it (an unknown map, a
-- client without the API) the night band stands in. Used by the route choice
-- cards and the guide menu's details pane.
--
--   ZoneArt.Create(parent, width, height[, ground]) -> art
--     A width x height band (the caller anchors it). ground: the palette
--     colour the bottom fade runs into (default "panelAlt"). art.Over sits
--     above the painting for text and chips; art.psZoom overrides ZA.ZOOM,
--     art.psDesat ZA.DESAT; art.psTint ({ r, g, b }) is multiplied into
--     every tile (the welcome engraves a painting into its night sky).
--     After a Paint, art.psCanvas = { left, top, width, height }: where the
--     whole layer lies in the band (nil while the band stands in), so a
--     caller can place map percent on the painting.
--   ZoneArt.Paint(art, uiMapID, focusX, focusY, index) -> painted, reveal
--     focusX/Y: the place to show, live-frame percent (default the middle);
--     it lands in the clear stretch between the top shade and the bottom
--     fade, zooming in a little where an edge would push it out of that.
--     index picks the stretch of night sky when the band stands in, so
--     neighbours never look cloned. painted is false when the band stands
--     in; reveal: "full" (every overlay), "explored" (the client's explored
--     overlays only: a map whose art this table was not built for) or nil.
--   ZoneArt.RegisterOverlays(build, arts)
--     arts: { [uiMapArtID] = { tileWidth, tileHeight, { textureWidth,
--     textureHeight, offsetX, offsetY, fileDataID, ... (row-major) }, ... } }
--     from WorldMapOverlay/WorldMapOverlayTile (generated; merges).
--   ZoneArt.FullOverlays(uiMapID, tileWidth, tileHeight) -> art table | nil
--     the table above for the art the client shows, only when it was built
--     for that art and tile size (Maps' world map reveal uses it too).
--   ZoneArt.EachOverlayTile(tileW, tileH, width, height, offX, offY, files,
--       first, place, ctx[, x0, y0, x1, y1])
--     one overlay's tiles as the world map splits them:
--     place(ctx, file, x, y, w, h, right, bottom) in layer pixels.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local floor, max, min, ceil, huge, pcall, type, pairs, ipairs = math.floor, math.max, math.min, math.ceil, math.huge, pcall, type, pairs, ipairs

local ZA = {}
UI.ZoneArt = ZA

ZA.ZOOM = 2.1 -- how far past "the whole map fits" the painting is zoomed in (art.psZoom overrides)
ZA.REFRAME = 1.5 -- at most this much further in, so a place near an edge still sits in the clear stretch
ZA.DESAT = 0.2 -- a little colour out, so every zone sits in the night palette
local TOP_SHADE = 40 -- the darker top edge, for chips and buttons
local FADE = 0.62 -- the bottom fade, as a share of the height

local overlays = {} -- [uiMapArtID] = { tileWidth, tileHeight, overlay, ... }
ZA.overlays = overlays

function ZA.RegisterOverlays(build, arts)
	if type(arts) ~= "table" then return end
	for art, list in pairs(arts) do overlays[art] = list end
	ZA.overlaysBuild = build
end

function ZA.Create(parent, width, height, ground)
	local a = CreateFrame("Frame", nil, parent)
	a:SetSize(width, height)
	a.psW, a.psH = width, height
	if a.SetClipsChildren then a:SetClipsChildren(true) end
	a.Band = Theme.Band(a, "BACKGROUND", -7, true) -- stands in for missing art: kept with the header band off
	a.Band:SetAllPoints(a)
	a.Canvas = CreateFrame("Frame", nil, a)
	a.Tiles, a.Shapes = {}, {}
	-- Above the painting: a fade into the ground below (where a name sits),
	-- a darker top edge for chips and buttons, and the hairline below.
	a.Over = CreateFrame("Frame", nil, a)
	a.Over:SetAllPoints(a)
	a.Over:SetFrameLevel(a.Canvas:GetFrameLevel() + 1)
	local fade = floor(height * FADE)
	a.Fade = a.Over:CreateTexture(nil, "BACKGROUND")
	a.Fade:SetTexture(Theme.Media("white"))
	a.Fade:SetPoint("BOTTOMLEFT", a, "BOTTOMLEFT", 0, 0)
	a.Fade:SetPoint("BOTTOMRIGHT", a, "BOTTOMRIGHT", 0, 0)
	a.Fade:SetHeight(fade)
	a.Top = a.Over:CreateTexture(nil, "BACKGROUND")
	a.Top:SetTexture(Theme.Media("white"))
	a.Top:SetPoint("TOPLEFT", a, "TOPLEFT", 0, 0)
	a.Top:SetPoint("TOPRIGHT", a, "TOPRIGHT", 0, 0)
	a.Top:SetHeight(TOP_SHADE)
	-- Where the place goes: the middle of the stretch neither shades.
	a.psFocusY = (TOP_SHADE + height - fade) / 2
	ground = ground or "panelAlt"
	W.Painter(a, function(self)
		local r, g, b = Theme.Color(ground)
		local sr, sg, sb = Theme.Color("shade")
		if self.Fade.SetGradient and CreateColor then
			self.Fade:SetGradient("VERTICAL", CreateColor(r, g, b, 1), CreateColor(r, g, b, 0))
			self.Top:SetGradient("VERTICAL", CreateColor(sr, sg, sb, 0), CreateColor(sr, sg, sb, 0.45))
		else
			self.Fade:SetVertexColor(r, g, b, 0.6)
			self.Top:SetVertexColor(sr, sg, sb, 0.2)
		end
	end)
	a.Rule = W.Divider(a.Over)
	a.Rule:SetPoint("BOTTOMLEFT", a, "BOTTOMLEFT", 0, 0)
	a.Rule:SetPoint("BOTTOMRIGHT", a, "BOTTOMRIGHT", 0, 0)
	return a
end

-- The client's first art layer for a map and its tile textures, or nil.
local function artLayer(uiMapID)
	local M = C_Map
	if not (type(uiMapID) == "number" and uiMapID > 0 and M and M.GetMapArtLayers and M.GetMapArtLayerTextures) then return nil end
	local ok, layers = pcall(M.GetMapArtLayers, uiMapID)
	local info = ok and type(layers) == "table" and layers[1] or nil
	if not info then return nil end
	if not ((info.layerWidth or 0) > 0 and (info.layerHeight or 0) > 0 and (info.tileWidth or 0) > 0 and (info.tileHeight or 0) > 0) then return nil end
	local ok2, list = pcall(M.GetMapArtLayerTextures, uiMapID, 1)
	if not (ok2 and type(list) == "table" and #list > 0) then return nil end
	return info, list
end

-- The overlay table of the art the client shows for a map, when it was built
-- for that art (same art ID, same tile size): { tileWidth, tileHeight,
-- { textureWidth, textureHeight, offsetX, offsetY, fileDataID, ... }, ... }
-- or nil. Shared with Maps' world map reveal.
function ZA.FullOverlays(uiMapID, tileWidth, tileHeight)
	local M = C_Map
	if not (M and M.GetMapArtID) then return nil end
	local ok, art = pcall(M.GetMapArtID, uiMapID)
	local t = ok and art and overlays[art]
	if t and t[1] == tileWidth and t[2] == tileHeight then return t end
	return nil
end

-- Every overlay of the map when the table was built for the art the client
-- shows, else the ones this character has explored.
-- -> list, "full" | "explored" | nil
local function overlaysOf(uiMapID, info)
	local t = ZA.FullOverlays(uiMapID, info.tileWidth, info.tileHeight)
	if t then return t, "full" end
	local X = C_MapExplorationInfo
	if X and X.GetExploredMapTextures then
		local ok, list = pcall(X.GetExploredMapTextures, uiMapID)
		if ok and type(list) == "table" then return list, "explored" end
	end
	return nil
end

-- The next texture of a pool, made on first use.
local function acquire(a, pool, n, sub)
	local t = pool[n]
	if not t then
		t = a.Canvas:CreateTexture(nil, "BACKGROUND", nil, sub)
		pool[n] = t
	end
	return t
end

-- A tile's desaturation and tint: the art's own, else the house's.
local function shadeTile(a, t)
	if t.SetDesaturation then t:SetDesaturation(a.psDesat or ZA.DESAT) end
	local tint = a.psTint
	if tint then t:SetVertexColor(tint[1], tint[2], tint[3], 1) else t:SetVertexColor(1, 1, 1, 1) end
end

-- One overlay split the way MapExplorationDataProvider splits it: tileW x
-- tileH textures, the last column and row partial, cropped from a
-- power-of-two file. Calls place(ctx, file, x, y, w, h, right, bottom) (layer
-- pixels; right/bottom: the texcoords of the crop) for each tile meeting the
-- window [x0, x1] x [y0, y1] (layer pixels; nil: every tile). files[first..]
-- are the fileDataIDs, row-major.
function ZA.EachOverlayTile(tileW, tileH, width, height, offX, offY, files, first, place, ctx, x0, y0, x1, y1)
	x0, y0 = x0 or -huge, y0 or -huge
	x1, y1 = x1 or huge, y1 or huge
	local wide, tall = ceil(width / tileW), ceil(height / tileH)
	for j = 1, tall do
		local ph, fh = tileH, tileH
		if j == tall then
			ph = height % tileH
			if ph == 0 then ph = tileH end
			fh = 16
			while fh < ph do fh = fh * 2 end
		end
		local ty = offY + tileH * (j - 1)
		if ty < y1 and ty + ph > y0 then
			for k = 1, wide do
				local pw, fw = tileW, tileW
				if k == wide then
					pw = width % tileW
					if pw == 0 then pw = tileW end
					fw = 16
					while fw < pw do fw = fw * 2 end
				end
				local tx = offX + tileW * (k - 1)
				local file = files[first + (j - 1) * wide + k - 1]
				if file and tx < x1 and tx + pw > x0 then
					place(ctx, file, tx, ty, pw, ph, pw / fw, ph / fh)
				end
			end
		end
	end
end

-- A tile of the zone art's overlays; ctx is the art (psN the pool count, psS
-- the scale, psSub the sublevel).
local function placeTile(a, file, x, y, w, h, right, bottom)
	local n = a.psN + 1
	a.psN = n
	local s, sub = a.psS, a.psSub
	local t = acquire(a, a.Shapes, n, sub)
	t:SetDrawLayer("BACKGROUND", sub)
	t:SetTexture(file, nil, nil, "TRILINEAR")
	t:SetTexCoord(0, right, 0, bottom)
	t:SetSize(w * s, h * s)
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", a.Canvas, "TOPLEFT", x * s, -y * s)
	shadeTile(a, t)
	t:Show()
end

-- Lays one overlay over the canvas; only the tiles inside the window get a
-- texture. -> the pool count after it
local function drawOverlay(a, n, s, x0, y0, x1, y1, tileW, tileH, width, height, offX, offY, files, first, sub)
	a.psN, a.psS, a.psSub = n, s, sub
	ZA.EachOverlayTile(tileW, tileH, width, height, offX, offY, files, first, placeTile, a, x0, y0, x1, y1)
	return a.psN
end

-- The scale and canvas offset that put (fx, fy) (0..1 of the layer) at
-- (w / 2, ay) of the band without showing past the painting's edges: the
-- base scale, raised up to ZA.REFRAME times where an edge would push the
-- place off that point.
local function frame(w, h, ay, lw, lh, fx, fy, base)
	local s = base
	if fx > 0 then s = max(s, (w / 2) / (fx * lw)) end
	if fx < 1 then s = max(s, (w / 2) / ((1 - fx) * lw)) end
	if fy > 0 then s = max(s, ay / (fy * lh)) end
	if fy < 1 then s = max(s, (h - ay) / ((1 - fy) * lh)) end
	s = min(s, base * ZA.REFRAME)
	local x = min(0, max(w - lw * s, w / 2 - fx * lw * s))
	local y = min(0, max(h - lh * s, ay - fy * lh * s))
	return s, x, y
end

function ZA.Paint(a, uiMapID, focusX, focusY, index)
	local w, h = a.psW, a.psH
	local info, textures = artLayer(uiMapID)
	local tiles, shapes = a.Tiles, a.Shapes
	if not info then
		for i = 1, #tiles do tiles[i]:Hide() end
		for i = 1, #shapes do shapes[i]:Hide() end
		local _, x1, y0, y1 = Theme.BandCoords(w, h)
		local shift = (((index or 1) - 1) * 0.29) % (1 - x1)
		a.Band:SetTexCoord(shift, shift + x1, y0, y1)
		a.Band:Show()
		a.psCanvas = nil
		return false
	end
	a.Band:Hide()
	local lw, lh, tileW, tileH = info.layerWidth, info.layerHeight, info.tileWidth, info.tileHeight
	local fx = min(1, max(0, (focusX or 50) / 100))
	local fy = min(1, max(0, (focusY or 50) / 100))
	local s, x, y = frame(w, h, a.psFocusY or h / 2, lw, lh, fx, fy, max(w / lw, h / lh) * (a.psZoom or ZA.ZOOM))
	a.Canvas:SetSize(lw * s, lh * s)
	a.Canvas:ClearAllPoints()
	a.Canvas:SetPoint("TOPLEFT", a, "TOPLEFT", x, -y)
	a.psCanvas = { x, y, lw * s, lh * s } -- where the layer lies in the band: left, top, width, height
	-- The window the band shows, in layer pixels: only what meets it is drawn.
	local x0, y0 = -x / s, -y / s
	local x1, y1 = x0 + w / s, y0 + h / s
	local cols, rows = ceil(lw / tileW), ceil(lh / tileH)
	local n = 0
	for r = 1, rows do
		local ty = (r - 1) * tileH
		if ty < y1 and ty + tileH > y0 then
			for col = 1, cols do
				local tx = (col - 1) * tileW
				local file = textures[(r - 1) * cols + col]
				if file and tx < x1 and tx + tileW > x0 then
					n = n + 1
					local t = acquire(a, tiles, n, 0)
					t:SetTexture(file, nil, nil, "TRILINEAR")
					t:SetSize(tileW * s, tileH * s)
					t:ClearAllPoints()
					t:SetPoint("TOPLEFT", a.Canvas, "TOPLEFT", tx * s, -ty * s)
					shadeTile(a, t)
					t:Show()
				end
			end
		end
	end
	for i = n + 1, #tiles do tiles[i]:Hide() end
	n = 0
	local list, reveal = overlaysOf(uiMapID, info)
	if reveal == "full" then
		for i = 3, #list do
			local o = list[i]
			n = drawOverlay(a, n, s, x0, y0, x1, y1, tileW, tileH, o[1], o[2], o[3], o[4], o, 5, 1)
		end
	elseif reveal == "explored" then
		for _, o in ipairs(list) do
			if not o.isShownByMouseOver and type(o.fileDataIDs) == "table" then
				n = drawOverlay(a, n, s, x0, y0, x1, y1, tileW, tileH, o.textureWidth or 0, o.textureHeight or 0,
					o.offsetX or 0, o.offsetY or 0, o.fileDataIDs, 1, o.isDrawOnTopLayer and 2 or 1)
			end
		end
	end
	for i = n + 1, #shapes do shapes[i]:Hide() end
	return true, reveal
end
