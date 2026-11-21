-- The world on one canvas, for the Stats map: every zone's painting laid
-- where the zone lies on the world map (C_Map.GetMapRectOnMap), so the map
-- zooms out of one zone into the next instead of switching maps. Drawn from
-- the player's own client like UI/ZoneArt.lua (file IDs only, no art
-- shipped), in layers that come in with the zoom:
--
--   the world's art       always
--   the continents' art   over it, as the view closes in (CONT_FADE)
--   the zones' base art   faded out at each zone's frame through a mask
--                         (Media/Map/feather), so neighbours meet with no
--                         straight edge (DETAIL_FADE)
--   the zones' overlays   the explored-area paintings, over every base
--   a city (no overlays)  its base art through a rounded mask
--                         (feather-round), once it fills a good part of the
--                         view (CITY_FADE)
--
-- Only what meets the frame gets a texture, from a pool that grows to the
-- busiest view.
--
--   WorldArt.Available() -> whether this client can place maps on the world
--   WorldArt.Rect(uiMapID) -> left, right, top, bottom on the world (0..1) | nil
--   WorldArt.Include(uiMapID)   a map to draw besides the world's own zone list
--   WorldArt.Refresh()          forget the explored overlays read (before a render)
--   WorldArt.Paint(art, fx, fy, zoom) -> painted
--     art: a frame with psW, psH (a ZoneArt band works); fx, fy: the world
--     percent in the middle of it; zoom 1: the whole world. Sets art.psCanvas
--     = { left, top, width, height } of the world in the frame (also when
--     nothing could be painted) and art.psWorld = { tiles, continents,
--     detail, zones } (what was drawn: textures, the two fades, zones).
--   WorldArt.Clear(art)         hides what Paint drew

local ns = Polestar
local UI, Stats = ns.UI, ns.Stats
local ZA = UI and UI.ZoneArt
local max, min, ceil, pcall, type, ipairs, pairs = math.max, math.min, math.ceil, pcall, type, ipairs, pairs
local sort = table.sort

if not (Stats and ZA and ZA.ArtLayer and ZA.OverlaysOf) then return end

local WA = {}
Stats.WorldArt = WA

local WORLD = 947 -- Azeroth
local CONTINENT, ZONE = 2, 3 -- Enum.UIMapType
WA.WORLD = WORLD
WA.CONT_FADE = { 1.3, 2.2 } -- the zoom where the continents' art comes in over the world's
WA.DETAIL_FADE = { 3000, 5200 } -- ... the zones': the world's width in frame pixels (a zone is some 150 to 260 wide)
WA.CITY_FADE = { 0.3, 0.5 } -- ... a city's own map: its width as a share of the frame's
local WORLD_W, WORLD_H = 1002, 668 -- the world art's size, when the client gives none
local MEDIA = "Interface\\AddOns\\Polestar\\Media\\Map\\"
local FEATHER, FEATHER_ROUND = MEDIA .. "feather", MEDIA .. "feather-round"

local rects = {} -- [uiMapID] = { l, r, t, b } | false
local extra = {} -- maps included by the caller
local built -- { world = rec | false, continents = { rec }, zones = { rec, biggest first } }

function WA.Available()
	return C_Map ~= nil and C_Map.GetMapRectOnMap ~= nil
end

local function sane(v) return type(v) == "number" and v > -1 and v < 2 end

function WA.Rect(map)
	local r = rects[map]
	if r == nil then
		r = false
		if map == WORLD then
			r = { 0, 1, 0, 1 }
		elseif type(map) == "number" and WA.Available() then
			local ok, l, rr, t, b = pcall(C_Map.GetMapRectOnMap, map, WORLD)
			if ok and sane(l) and sane(rr) and sane(t) and sane(b) and rr > l and b > t then r = { l, rr, t, b } end
		end
		rects[map] = r
	end
	if r then return r[1], r[2], r[3], r[4] end
	return nil
end

function WA.Include(map)
	if type(map) ~= "number" or extra[map] then return end
	extra[map] = true
	built = nil
end

function WA.Refresh()
	if not built then return end
	for _, z in ipairs(built.zones) do
		if z.reveal ~= "full" then z.list, z.reveal, z.read = nil, nil, nil end
	end
end

-- A map's place and art, or nil when the client has either missing.
local function record(map)
	local l, r, t, b = WA.Rect(map)
	if not l then return nil end
	local info, files = ZA.ArtLayer(map)
	if not info then return nil end
	return {
		map = map, l = l, r = r, t = t, b = b, info = info, files = files,
		lw = info.layerWidth, lh = info.layerHeight, tw = info.tileWidth, th = info.tileHeight,
	}
end

local function children(kind, into)
	if not (C_Map and C_Map.GetMapChildrenInfo) then return end
	local ok, list = pcall(C_Map.GetMapChildrenInfo, WORLD, kind, true)
	if not (ok and type(list) == "table") then return end
	for _, info in ipairs(list) do
		if type(info) == "table" and type(info.mapID) == "number" then into[info.mapID] = true end
	end
end

-- The continent above a map, for a client that lists no children.
local function continentOf(map)
	if not (C_Map and C_Map.GetMapInfo) then return nil end
	local at = map
	for _ = 1, 8 do
		local ok, info = pcall(C_Map.GetMapInfo, at)
		if not (ok and type(info) == "table") then return nil end
		if info.mapType == CONTINENT then return at end
		local up = info.parentMapID
		if type(up) ~= "number" or up == 0 or up == at then return nil end
		at = up
	end
	return nil
end

local function build()
	if built then return built end
	local conts, zones = {}, {}
	children(CONTINENT, conts)
	children(ZONE, zones)
	for map in pairs(extra) do
		zones[map] = true
		local c = continentOf(map)
		if c then conts[c] = true end
	end
	built = { world = record(WORLD) or false, continents = {}, zones = {} }
	for map in pairs(conts) do
		local rec = map ~= WORLD and record(map)
		if rec then built.continents[#built.continents + 1] = rec end
	end
	for map in pairs(zones) do
		local rec = map ~= WORLD and not conts[map] and record(map)
		if rec then built.zones[#built.zones + 1] = rec end
	end
	-- The biggest first, so a small map lands over the one it lies in.
	local function bigger(a, b)
		local x, y = (a.r - a.l) * (a.b - a.t), (b.r - b.l) * (b.b - b.t)
		if x ~= y then return x > y end
		return a.map < b.map
	end
	sort(built.continents, bigger)
	sort(built.zones, bigger)
	return built
end

local function smooth(v, from, to)
	local t = max(0, min(1, (v - from) / (to - from)))
	return t * t * (3 - 2 * t)
end

-- The next mask of the frame's pool, over a map's whole rectangle: what is
-- drawn through it fades out at the map's frame. nil on a client without masks.
local function maskOver(a, file, x, y, w, h)
	if not a.CreateMaskTexture then return nil end
	local n = a.waM + 1
	a.waM = n
	local m = a.waMasks[n]
	if not m then
		m = a:CreateMaskTexture()
		a.waMasks[n] = m
	end
	if m.waFile ~= file then
		m.waFile = file
		m:SetTexture(file, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	end
	m:SetSize(w, h)
	m:ClearAllPoints()
	m:SetPoint("TOPLEFT", a, "TOPLEFT", x, -y)
	return m
end

-- One texture at (x, y) of the frame, when any of it is in the frame; drawn
-- through `mask` when given.
local function put(a, file, x, y, w, h, right, bottom, sub, alpha, mask)
	if x >= a.psW or y >= a.psH or x + w <= 0 or y + h <= 0 then return end
	local n = a.waN + 1
	a.waN = n
	local t = a.waPool[n]
	if not t then
		t = a:CreateTexture(nil, "BACKGROUND", nil, sub)
		-- Tiles meet edge to edge at any scale: no snapping to the screen's pixels.
		if t.SetSnapToPixelGrid then t:SetSnapToPixelGrid(false) end
		if t.SetTexelSnappingBias then t:SetTexelSnappingBias(0) end
		a.waPool[n] = t
	end
	if t.waMask ~= mask and t.AddMaskTexture then
		if t.waMask and t.RemoveMaskTexture then t:RemoveMaskTexture(t.waMask) end
		if mask then t:AddMaskTexture(mask) end
		t.waMask = mask
	end
	t:SetDrawLayer("BACKGROUND", sub)
	t:SetTexture(file, nil, nil, "TRILINEAR")
	t:SetTexCoord(0, right, 0, bottom)
	t:SetSize(w, h)
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", a, "TOPLEFT", x, -y)
	if t.SetDesaturation then t:SetDesaturation(a.psDesat or ZA.DESAT) end
	t:SetVertexColor(1, 1, 1, alpha)
	t:Show()
end

-- Where a map lies in the frame: its left, top, and frame pixels per art
-- pixel each way; nil when none of it is in the frame.
local function frameOf(a, rec, cv)
	local x, y = cv[1] + rec.l * cv[3], cv[2] + rec.t * cv[4]
	local w, h = (rec.r - rec.l) * cv[3], (rec.b - rec.t) * cv[4]
	if x >= a.psW or y >= a.psH or x + w <= 0 or y + h <= 0 then return nil end
	return x, y, w / rec.lw, h / rec.lh, w
end

-- A map's base art: its tiles, the last column and row cut to the layer.
local function base(a, rec, cv, sub, alpha, mask)
	local ox, oy, sx, sy = frameOf(a, rec, cv)
	if not ox then return false end
	local cols, rows = ceil(rec.lw / rec.tw), ceil(rec.lh / rec.th)
	for r = 1, rows do
		local ty = (r - 1) * rec.th
		local ph = min(rec.th, rec.lh - ty)
		for c = 1, cols do
			local tx = (c - 1) * rec.tw
			local pw = min(rec.tw, rec.lw - tx)
			local file = rec.files[(r - 1) * cols + c]
			if file then put(a, file, ox + tx * sx, oy + ty * sy, pw * sx, ph * sy, pw / rec.tw, ph / rec.th, sub, alpha, mask) end
		end
	end
	return true
end

-- An overlay's tile, from ZA.EachOverlayTile; c is the placing in hand.
local placing = {}
local function placePiece(c, file, x, y, w, h, right, bottom)
	put(c.a, file, c.ox + x * c.sx, c.oy + y * c.sy, w * c.sx, h * c.sy, right, bottom, c.sub, c.alpha, c.mask)
end

-- A zone's overlays, read once (the explored ones again after a Refresh).
local function pieces(rec)
	if not rec.read then
		rec.read = true
		local list, reveal = ZA.OverlaysOf(rec.map, rec.info)
		local n = 0
		if reveal == "full" then
			n = #list - 2
		elseif reveal == "explored" then
			for _, o in ipairs(list) do
				if type(o) == "table" and not o.isShownByMouseOver and type(o.fileDataIDs) == "table" then n = n + 1 end
			end
		end
		rec.list, rec.reveal, rec.pieces = list, reveal, n
	end
	return rec.pieces > 0
end

local function overlays(a, rec, ox, oy, sx, sy, alpha, mask)
	local c = placing
	c.a, c.ox, c.oy, c.sx, c.sy, c.alpha, c.mask = a, ox, oy, sx, sy, alpha, mask
	-- The frame, in the zone's layer pixels: only the tiles meeting it are drawn.
	local x0, y0 = -ox / sx, -oy / sy
	local x1, y1 = x0 + a.psW / sx, y0 + a.psH / sy
	local list = rec.list
	if rec.reveal == "full" then
		c.sub = -2
		for i = 3, #list do
			local o = list[i]
			ZA.EachOverlayTile(rec.tw, rec.th, o[1], o[2], o[3], o[4], o, 5, placePiece, c, x0, y0, x1, y1)
		end
	else
		for _, o in ipairs(list) do
			if type(o) == "table" and not o.isShownByMouseOver and type(o.fileDataIDs) == "table" then
				c.sub = o.isDrawOnTopLayer and -1 or -2
				ZA.EachOverlayTile(rec.tw, rec.th, o.textureWidth or 0, o.textureHeight or 0, o.offsetX or 0, o.offsetY or 0,
					o.fileDataIDs, 1, placePiece, c, x0, y0, x1, y1)
			end
		end
	end
end

function WA.Clear(a)
	local pool = a.waPool
	if not pool then return end
	for i = 1, #pool do pool[i]:Hide() end
	a.waN = 0
end

function WA.Paint(a, fx, fy, zoom)
	local w, h = a.psW, a.psH
	local b = build()
	local W, H = WORLD_W, WORLD_H
	if b.world then W, H = b.world.lw, b.world.lh end
	local s = max(w / W, h / H) * (zoom or 1)
	local cv = { w / 2 - (fx or 50) / 100 * W * s, h / 2 - (fy or 50) / 100 * H * s, W * s, H * s }
	a.psCanvas = cv
	if not a.waPool then
		a.waPool, a.waMasks = {}, {}
		if a.SetClipsChildren then a:SetClipsChildren(true) end
	end
	a.waN, a.waM = 0, 0
	-- A ZoneArt band's own painting gives way.
	if a.Tiles then for i = 1, #a.Tiles do a.Tiles[i]:Hide() end end
	if a.Shapes then for i = 1, #a.Shapes do a.Shapes[i]:Hide() end end

	if b.world then base(a, b.world, cv, -6, 1) end
	local cont = smooth(zoom or 1, WA.CONT_FADE[1], WA.CONT_FADE[2])
	if cont > 0.003 then
		for _, rec in ipairs(b.continents) do base(a, rec, cv, -4, cont) end
	end
	local detail = smooth(cv[3], WA.DETAIL_FADE[1], WA.DETAIL_FADE[2])
	local zones = 0
	for _, rec in ipairs(b.zones) do
		local ox, oy, sx, sy, wide = frameOf(a, rec, cv)
		if ox then
			local before = a.waN
			if detail > 0.003 and pieces(rec) then
				local mask = maskOver(a, FEATHER, ox, oy, rec.lw * sx, rec.lh * sy)
				base(a, rec, cv, -3, detail, mask)
				overlays(a, rec, ox, oy, sx, sy, detail, mask)
			elseif wide >= w * WA.CITY_FADE[1] and not pieces(rec) then
				local city = smooth(wide / w, WA.CITY_FADE[1], WA.CITY_FADE[2])
				if city > 0.003 then base(a, rec, cv, 0, city, maskOver(a, FEATHER_ROUND, ox, oy, rec.lw * sx, rec.lh * sy)) end
			end
			if a.waN > before then zones = zones + 1 end
		end
	end
	local pool = a.waPool
	for i = a.waN + 1, #pool do pool[i]:Hide() end
	local painted = a.waN > 0
	if a.Band then
		if painted then a.Band:Hide() else a.Band:Show() end
	end
	a.psWorld = { tiles = a.waN, continents = cont, detail = detail, zones = zones }
	return painted
end
