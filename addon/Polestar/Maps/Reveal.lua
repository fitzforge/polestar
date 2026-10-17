-- The world map without fog of war:
-- the overlays this character has not explored yet are laid over the map,
-- as they are or tinted with the theme's mapUnexplored colour (setting
-- maps.reveal: "off" | "on" | "tint").
--
-- Every overlay comes from UI.ZoneArt's table (UI/ZoneArtOverlays.lua, the
-- client's WorldMapOverlay rows), used only when it was built for the art the
-- client shows (ZoneArt.FullOverlays: art ID and tile size). The client lists
-- what is explored (C_MapExplorationInfo.GetExploredMapTextures) without
-- overlay IDs, so the two are matched on offset and size. An explored overlay
-- is the client's own to draw: shown, or, when it isShownByMouseOver, only
-- while the cursor is over its area; it is never painted here, so a hover-only
-- overlay stays hover-only.
--
-- The tiles are Polestar's own: textures on one frame of its own on each map
-- frame's canvas (the world map, and the battlefield map once Blizzard loads
-- it), at the exploration frame level, laid out in canvas units (the canvas
-- is the art layer's size, as MapExplorationDataProvider assumes), faded
-- with the map's global alpha (the battlefield map's opacity). The map's
-- view (Core/MapCanvas.lua) says when the map, its size or its alpha
-- changes; the map itself is only read, and no Blizzard function is
-- replaced. Nothing is made while the setting is off: a map is watched the
-- first time it is on.

local ADDON, ns = ...
local Maps = ns.Maps

local type, pairs, ipairs, pcall = type, pairs, ipairs, pcall

---------------------------------------------------------------------------
-- Overlay selection (pure)
---------------------------------------------------------------------------

local function rectKey(w, h, x, y)
	return x .. ":" .. y .. ":" .. w .. ":" .. h
end

-- art: a ZoneArt.FullOverlays table ({ tileW, tileH, { w, h, x, y, file, ... }, ... });
-- explored: the client's explored list ({ textureWidth, textureHeight, offsetX,
-- offsetY, isShownByMouseOver, ... }, ...) or nil. -> the overlays of art no
-- explored entry covers, in table order (out is reused when given).
function Maps.UnexploredOverlays(art, explored, out)
	out = out or {}
	for i = #out, 1, -1 do out[i] = nil end
	if type(art) ~= "table" then return out end
	local seen
	if type(explored) == "table" then
		for _, e in ipairs(explored) do
			if type(e) == "table" then
				seen = seen or {}
				seen[rectKey(e.textureWidth, e.textureHeight, e.offsetX, e.offsetY)] = true
			end
		end
	end
	for i = 3, #art do
		local o = art[i]
		if not (seen and seen[rectKey(o[1], o[2], o[3], o[4])]) then out[#out + 1] = o end
	end
	return out
end

---------------------------------------------------------------------------
-- The tiles on each map
---------------------------------------------------------------------------

local maps = {} -- map frame -> { view, host = frame, tex = { texture, ... }, n, r, g, b }
local scratch = {}

local function mode()
	local m = ns.Get("maps.reveal")
	if m == "on" or m == "tint" then return m end
	return "off"
end

-- The art layer the canvas is sized to, or nil.
local function layerOf(mapID)
	local M = C_Map
	if not (mapID and M and M.GetMapArtLayers) then return nil end
	local ok, layers = pcall(M.GetMapArtLayers, mapID)
	local info = ok and type(layers) == "table" and layers[1] or nil
	if info and (info.tileWidth or 0) > 0 and (info.tileHeight or 0) > 0 then return info end
	return nil
end

local function exploredOf(mapID)
	local X = C_MapExplorationInfo
	if not (X and X.GetExploredMapTextures) then return nil end
	local ok, list = pcall(X.GetExploredMapTextures, mapID)
	return ok and type(list) == "table" and list or nil
end

local function host(rec)
	local f = rec.host
	if f then return f end
	local canvas = rec.view.canvas
	f = ns.CreateFrameUnder("Frame", nil, canvas)
	f:SetPoint("TOPLEFT", canvas, "TOPLEFT", 0, 0)
	f:SetSize(1, 1)
	rec.host, rec.tex, rec.n = f, {}, 0
	return f
end

-- ZoneArt.EachOverlayTile callback: one tile, canvas units = layer pixels.
-- Neither map frame masks its canvas (only the hybrid minimap's canvas has
-- a mask texture), so the tiles need none.
local function placeTile(rec, file, x, y, w, h, right, bottom)
	local n = rec.n + 1
	rec.n = n
	local t = rec.tex[n]
	if not t then
		t = rec.host:CreateTexture(nil, "ARTWORK", nil, 0)
		rec.tex[n] = t
	end
	t:SetTexture(file, nil, nil, "TRILINEAR")
	t:SetTexCoord(0, right, 0, bottom)
	t:SetSize(w, h)
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", rec.host, "TOPLEFT", x, -y)
	t:SetVertexColor(rec.r, rec.g, rec.b, 1)
	t:Show()
end

local function clear(rec)
	local tex = rec.tex
	if not tex then return end
	for i = 1, #tex do tex[i]:Hide() end
	rec.n = 0
end

local function paint(rec)
	clear(rec)
	local m = mode()
	if m == "off" then return end
	local ZA = ns.UI and ns.UI.ZoneArt
	if not (ZA and ZA.FullOverlays and ZA.EachOverlayTile) then return end
	local view = rec.view
	local mapID = view.mapID
	local info = layerOf(mapID)
	local art = info and ZA.FullOverlays(mapID, info.tileWidth, info.tileHeight)
	if not art then return end
	local list = Maps.UnexploredOverlays(art, exploredOf(mapID), scratch)
	if #list == 0 then return end
	local f = host(rec)
	f:SetSize(view.width, view.height)
	f:SetFrameLevel(view:Level("PIN_FRAME_LEVEL_MAP_EXPLORATION"))
	f:SetAlpha(view.alpha or 1)
	local T = ns.Theme
	if m == "tint" and T and T.Color then
		rec.r, rec.g, rec.b = T.Color("mapUnexplored")
	else
		rec.r, rec.g, rec.b = 1, 1, 1
	end
	local tileW, tileH = art[1], art[2]
	for _, o in ipairs(list) do
		ZA.EachOverlayTile(tileW, tileH, o[1], o[2], o[3], o[4], o, 5, placeTile, rec)
	end
	f:Show()
end

local function onView(view, what)
	local rec = maps[view.map]
	if not rec then return end
	if what == "show" or what == "map" then
		paint(rec)
	elseif what == "size" then
		if rec.host then rec.host:SetSize(view.width, view.height) end
	elseif what == "alpha" then
		if rec.host then rec.host:SetAlpha(view.alpha or 1) end
	end
end

local function watch(map)
	if maps[map] then return true end
	local M = ns.MapCanvas
	local view = map and M and M.Watch(map, onView)
	if not view then return false end
	maps[map] = { view = view }
	return true
end

-- Watches every map frame that exists (only once the setting is on), then
-- repaints the shown ones.
local function sync()
	if mode() ~= "off" then
		watch(WorldMapFrame)
		if BattlefieldMapFrame then watch(BattlefieldMapFrame) end
	end
	for _, rec in pairs(maps) do
		if rec.view.shown then paint(rec) end
	end
end
Maps.RefreshReveal = sync

ns.On("SETTING_CHANGED", function(path)
	if path == "maps.reveal" or path == "maps" or path == "" then sync() end
end)

ns.RegisterEvent("MAP_EXPLORATION_UPDATED", function()
	for _, rec in pairs(maps) do
		if rec.view.shown then paint(rec) end
	end
end)

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if (name == "Blizzard_WorldMap" or name == "Blizzard_BattlefieldMap") and ns.IsLoggedIn() then sync() end
end)

ns.OnLogin(function()
	sync()
	local T = ns.Theme
	if T and T.OnChanged then
		T.OnChanged(function()
			if mode() == "tint" then sync() end
		end)
	end
end)
