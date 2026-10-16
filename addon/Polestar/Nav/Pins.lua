-- Polestar.Pins: map and minimap icons for every module (quests, maps, QoL,
-- Nav's own target). Contract: docs/ARCHITECTURE.md, "Pins".
--
--   Pins.SetLayer(layer, pins, opts)   replace a layer; opts = { world = true, minimap = true, edge = false, scale = 1,
--                                      minimapAreas = false }
--   Pins.ClearLayer(layer)
--   Pins.SetLayerVisible(layer, visible)
--   pin = { map, x, y, f, icon, size, color = { r, g, b, a }, tooltip = string | function(tooltip),
--           onClick = function(button), priority }
--   Additive pin fields: c, wx, wy (world position instead of map/x/y), glow (soft halo),
--   area (yards: a soft disc of that radius under the pin, in the pin's colour, on the world
--   map; on the minimap too in a layer with minimapAreas, cut at the minimap's rim),
--   hull ({ wx1, wy1, wx2, wy2, ... }: a convex region in world yards on the pin's continent,
--   filled softly with a rim in the pin's colour, drawn like area), areaOnly (true: only the
--   area or hull draws, no pin), backdrop (true: icon pins sit on a dark
--   Theme "scrim" disc), ring ({ r, g, b, a }: a thin circle around the pin), minimapSize
--   (size on the minimap instead of size).
--   Pins.SetTrail(runs, opts)          the travel route's dots; runs = { { live = true, point, ... }, ... },
--                                      point = { c, wx, wy }; opts = { world = true, minimap = true, color }
--   Pins.ClearTrail()
--   Pins.MinimapCursor() -> dNorth, dWest | nil   yards from the player to the cursor on the minimap
--   Pins.MinimapView() -> radius, facing | nil, square   what the minimap shows (facing nil: north-up)
--
-- Positions are converted to world yards once per SetLayer (Era-frame `f = "e"`
-- included), then to map percent of whatever map the world map shows, and
-- projected onto the minimap honouring its zoom, indoor scale, rotation and
-- shape. Frames are pooled on both surfaces.
--
-- Cost model: the minimap is only touched when something it depends on
-- changed (position, facing on a rotating minimap, zoom, size, layers). A
-- 10 Hz watcher compares those scalars; while they keep changing a driver
-- frame repositions pins at most 30 times a second and hides itself after
-- 0.3 s of stillness, so standing still costs no per-frame work at all.
-- Movement events wake the driver at once. Layer changes redraw once on the
-- next frame however many layers changed in this one. Each layer indexes its
-- pins by continent and by CELL-yard grid square, so a redraw visits the
-- pins around the player, not every pin a module published. A hull on the
-- minimap is laid out again only when the zoom, the minimap's size or (when
-- it rotates) the facing changed; walking moves one anchor.
--
-- The trail is dots along the straight lines between a run's points (`live`:
-- the player's position goes first), anchored to the run's end: a dot every
-- spacing yards counted back from the destination, so dots keep their place
-- in the world as the player walks and run on across joints. A continent
-- change breaks a run. Minimap dots sit MM_SPACING apart inside the visible
-- disc (or square); world map dots a WORLD_DIVS-th of the viewed map's width
-- apart (at least WORLD_MIN_SPACING), inside its rectangle, under every pin;
-- on OpenMap's stitched map, inside what the view shows, through OpenMap's
-- placement (see "OpenMap" below).
-- Segment lengths are measured once per SetTrail. The dots crawl toward the
-- destination, one spacing per TRAIL_PERIOD, from a 20 Hz driver that runs
-- only while dots show on a visible minimap or an open world map; with
-- ui.reduceMotion they hold still and move only with the minimap's redraws.

local ADDON, ns = ...

local type, pairs, ipairs, tonumber, pcall = type, pairs, ipairs, tonumber, pcall
local sqrt, atan2, sin, cos, abs, max, pi, ceil = math.sqrt, math.atan2, math.sin, math.cos, math.abs, math.max, math.pi, math.ceil
local floor = math.floor

local Pins = {}
ns.Pins = Pins
local L = ns.L

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"
local AREA_ALPHA = 0.32 -- area disc opacity, times the pin colour's alpha
-- Hulls: fill and rim opacity (times the pin colour's alpha), the rim's width
-- on screen (UI units), and the solid texture their pieces are cut from.
local HULL_FILL, HULL_RIM, HULL_RIM_WIDTH = 0.2, 0.7, 1.5
local WHITE = "Interface\\Buttons\\WHITE8X8"
local WORLD_SIZE, MINIMAP_SIZE = 16, 14
local WATCH_INTERVAL = 0.1
local DRIVE_INTERVAL = 1 / 30
local IDLE_AFTER = 0.3
local MINIMAP_REACH = 1.0 -- fraction of the view radius a non-edge pin may sit at
local CELL = 500 -- yards per grid square of a layer's minimap index

-- View diameters in yards per zoom level, for clients without
-- C_Minimap.GetViewRadius (outdoor / indoor scale).
local OUTDOOR = { [0] = 466 + 2 / 3, 400, 333 + 1 / 3, 266 + 2 / 3, 200, 133 + 1 / 3 }
local INDOOR = { [0] = 300, 240, 180, 120, 80, 50 }

-- Trail dots (see the header).
local TRAIL_PERIOD = 1.5             -- seconds for the dots to crawl one spacing
local TRAIL_INTERVAL = 1 / 20        -- animation rate cap
local TRAIL_STILL = 0.5              -- phase while ui.reduceMotion holds the dots still
local TRAIL_ALPHA = 0.85
local MM_SPACING, MM_DOT, MM_CAP = 40, 5, 40 -- minimap: yards apart, px, most dots
local WORLD_DIVS, WORLD_MIN_SPACING = 60, 15  -- world map: spacing = map width in yards / 60, at least 15 yd
local WORLD_DOT, WORLD_CAP = 6, 300

---------------------------------------------------------------------------
-- Layers
---------------------------------------------------------------------------

local layers = {}  -- name -> layer
local order = {}   -- layer names, in first-SetLayer order
local hidden = {}  -- name -> true (SetLayerVisible(false) may precede SetLayer)

local refreshWorld, refreshMinimap -- forward
local drawTrailWorld, updateTrailDriver -- forward (trail)

local function resolveLayer(layer)
	local C = ns.Compat
	local pins = layer.pins
	local wc, wxs, wys, reach = layer.c, layer.wx, layer.wy, layer.reach
	local unresolved = 0
	-- byC[c] = { i, ... } (edge layers draw every pin on the continent);
	-- grid[c][gx][gy] = { i, ... } for the others.
	local byC, grid = {}, {}
	local floor = math.floor
	for i = 1, #pins do
		local p = pins[i]
		local c, wx, wy = p.c, p.wx, p.wy
		if not (c and wx and wy) then
			c, wx, wy = nil, nil, nil
			if C and C.MapToWorld and p.map and p.x and p.y then c, wx, wy = C.MapToWorld(p.map, p.x, p.y, p.f) end
		end
		wc[i], wxs[i], wys[i] = c or false, wx or 0, wy or 0
		-- How far the pin's area or hull reaches from its position (yards).
		local r = tonumber(p.area) or 0
		local hull = p.hull
		if c and type(hull) == "table" then
			for k = 1, #hull - 1, 2 do
				local dx, dy = hull[k] - wx, hull[k + 1] - wy
				local d = sqrt(dx * dx + dy * dy)
				if d > r then r = d end
			end
		end
		reach[i] = r
		if c then
			local list = byC[c]
			if not list then
				list = {}
				byC[c] = list
			end
			list[#list + 1] = i
			local gc = grid[c]
			if not gc then
				gc = {}
				grid[c] = gc
			end
			local gx, gy = floor(wx / CELL), floor(wy / CELL)
			local col = gc[gx]
			if not col then
				col = {}
				gc[gx] = col
			end
			local cell = col[gy]
			if not cell then
				cell = {}
				col[gy] = cell
			end
			cell[#cell + 1] = i
		else
			unresolved = unresolved + 1
		end
	end
	layer.byC, layer.grid = byC, grid
	layer.resolved = C ~= nil and C.MapToWorld ~= nil
	layer.unresolved = unresolved
	-- The widest area or hull decides how far past the minimap's view a pin
	-- may still reach into it.
	local maxArea = 0
	if layer.minimapAreas then
		for i = 1, #pins do
			if reach[i] > maxArea then maxArea = reach[i] end
		end
	end
	layer.maxArea = maxArea
end

function Pins.SetLayer(name, pins, opts)
	if type(name) ~= "string" then return end
	opts = type(opts) == "table" and opts or {}
	local layer = layers[name]
	if not layer then
		layer = { name = name }
		layers[name] = layer
		order[#order + 1] = name
	end
	layer.pins = type(pins) == "table" and pins or {}
	layer.world = opts.world ~= false
	layer.minimap = opts.minimap ~= false
	layer.edge = opts.edge == true
	layer.scale = tonumber(opts.scale) or 1
	layer.minimapAreas = opts.minimapAreas == true
	layer.c, layer.wx, layer.wy, layer.reach = {}, {}, {}, {}
	resolveLayer(layer)
	layer.version = (layer.version or 0) + 1
	refreshWorld()
	refreshMinimap(true)
end

function Pins.ClearLayer(name)
	local layer = layers[name]
	if not layer then return end
	layers[name] = nil
	for i = #order, 1, -1 do
		if order[i] == name then table.remove(order, i) end
	end
	refreshWorld()
	refreshMinimap(true)
end

function Pins.SetLayerVisible(name, visible)
	local now = not visible or nil
	if hidden[name] == now then return end
	hidden[name] = now
	refreshWorld()
	refreshMinimap(true)
end

function Pins.IsLayerVisible(name)
	return layers[name] ~= nil and not hidden[name]
end

function Pins.GetLayer(name)
	local layer = layers[name]
	return layer and layer.pins
end

---------------------------------------------------------------------------
-- Shared look
---------------------------------------------------------------------------

local function iconPath(icon)
	if type(icon) ~= "string" or icon == "" then return nil end
	if icon:find("[\\/]") then return icon end
	local T = ns.Theme
	if type(T) == "table" and type(T.Media) == "function" then
		local ok, path = pcall(T.Media, icon)
		if ok and type(path) == "string" then return path end
	end
	return MEDIA .. icon
end

local function pinColor(p)
	local c = p.color
	if type(c) == "table" then return c[1] or c.r or 1, c[2] or c.g or 1, c[3] or c.b or 1, c[4] or c.a or 1 end
	local T = ns.Theme
	if type(T) == "table" and type(T.Accent) == "function" then
		local ok, r, g, b = pcall(T.Accent)
		if ok and type(r) == "number" then return r, g, b, 1 end
	end
	return 0.902, 0.729, 0.4, 1 -- Dusk gold, when Theme is absent
end

-- Textures of a pin frame: either the Polestar pin (fill tinted + ring) or
-- one tinted icon, optionally on a dark disc (`backdrop`, Theme scrim) and
-- circled (`ring` colour); an optional glow; an edge pointer for clamped
-- minimap pins.
local BACKDROP_ALPHA, BACKDROP_SCALE = 0.55, 1.2

local function backdropColor()
	local T = ns.Theme
	if type(T) == "table" and type(T.Color) == "function" then
		local ok, r, g, b = pcall(T.Color, "scrim")
		if ok and type(r) == "number" then return r, g, b end
	end
	return 0.04, 0.05, 0.08
end

local function buildLook(f)
	f.glow = f:CreateTexture(nil, "BACKGROUND")
	f.glow:SetTexture(MEDIA .. "glow")
	f.glow:SetPoint("CENTER")
	f.glow:SetBlendMode("ADD")
	f.back = f:CreateTexture(nil, "BORDER")
	f.back:SetTexture(MEDIA .. "pin-fill")
	f.back:SetPoint("CENTER")
	f.fill = f:CreateTexture(nil, "ARTWORK")
	f.fill:SetTexture(MEDIA .. "pin-fill")
	f.fill:SetAllPoints()
	f.ring = f:CreateTexture(nil, "OVERLAY")
	f.ring:SetTexture(MEDIA .. "pin")
	f.ring:SetAllPoints()
	f.icon = f:CreateTexture(nil, "ARTWORK")
	f.icon:SetAllPoints()
	f.mark = f:CreateTexture(nil, "OVERLAY")
	f.mark:SetTexture(MEDIA .. "ring")
	f.mark:SetPoint("CENTER")
	f.edge = f:CreateTexture(nil, "OVERLAY", nil, 1)
	f.edge:SetTexture(MEDIA .. "edge")
	f.edge:SetPoint("CENTER")
	f.edge:Hide()
end

-- Shows the parts of a pin's look for its current state (clamped minimap
-- pins show only the edge pointer).
local function showParts(f, p, clamped)
	local icon = f.hasIcon
	f.fill:SetShown(not clamped and not icon)
	f.ring:SetShown(not clamped and not icon)
	f.icon:SetShown(not clamped and icon)
	f.back:SetShown(not clamped and icon and p.backdrop and true or false)
	f.mark:SetShown(not clamped and type(p.ring) == "table")
	f.glow:SetShown(not clamped and p.glow and true or false)
	f.edge:SetShown(clamped and true or false)
end

local function applyLook(f, p, size)
	f:SetSize(size, size)
	local r, g, b, a = pinColor(p)
	local path = iconPath(p.icon)
	if path then
		f.icon:SetTexture(path)
		f.icon:SetVertexColor(r, g, b, a)
		f.hasIcon = true
	else
		f.fill:SetVertexColor(r, g, b, a)
		f.ring:SetVertexColor(1, 1, 1, a)
		f.hasIcon = false
	end
	local disc = size * BACKDROP_SCALE
	if p.backdrop then
		local br, bg, bb = backdropColor()
		f.back:SetSize(disc, disc)
		f.back:SetVertexColor(br, bg, bb, BACKDROP_ALPHA * a)
	end
	local ring = p.ring
	if type(ring) == "table" then
		f.mark:SetSize(disc, disc)
		f.mark:SetVertexColor(ring[1] or ring.r or 1, ring[2] or ring.g or 1, ring[3] or ring.b or 1, ring[4] or ring.a or 1)
	end
	if p.glow then
		f.glow:SetSize(size * 1.8, size * 1.8)
		f.glow:SetVertexColor(r, g, b, 0.5)
	end
	f.edge:SetSize(size, size)
	f.edge:SetVertexColor(r, g, b, a)
	f.clamped = nil
	showParts(f, p, false)
end

local function showTooltip(owner, p)
	local tip = p and p.tooltip
	if not tip then return end
	GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
	if type(tip) == "function" then
		ns.SafeCall(tip, GameTooltip)
	else
		GameTooltip:SetText(tostring(tip))
	end
	GameTooltip:Show()
end

local function click(p, button)
	if p and type(p.onClick) == "function" then ns.SafeCall(p.onClick, button) end
end

---------------------------------------------------------------------------
-- Hulls, shared by both surfaces: a convex polygon cut from solid textures
-- whose quads SetVertexOffset bends into place. Pieces that share an edge
-- are rasterised without a seam or an overlap, so the fill is even at any
-- alpha. The polygon inset by the rim's width is filled with quads fanned
-- from its first point; the rim is one quad per edge between the polygon
-- and its inset. Every piece keeps one rectangle (the polygon's box around
-- its centre), so moving that rectangle moves the whole hull.
---------------------------------------------------------------------------

local hx, hy, inX, inY = {}, {}, {}, {} -- a polygon in local units (y up), and its inset
local HULL_EPSILON = 0.01                -- local units: closer points are one

local function hullTexture(parent)
	local t = parent:CreateTexture(nil, "BACKGROUND")
	t:SetTexture(WHITE)
	-- Snapping each piece's rectangle to the pixel grid on its own would
	-- open or overlap the edges they share.
	if t.SetSnapToPixelGrid then t:SetSnapToPixelGrid(false) end
	if t.SetTexelSnappingBias then t:SetTexelSnappingBias(0) end
	return t
end

-- Bend texture t's quad onto a, b, c, d (clockwise, local units around the
-- centre of its rectangle of half extents hw, hh).
local function bend(t, hw, hh, ax, ay, bx, by, cx, cy, dx, dy)
	t:SetVertexOffset(1, ax + hw, ay - hh) -- upper left
	t:SetVertexOffset(3, bx - hw, by - hh) -- upper right
	t:SetVertexOffset(4, cx - hw, cy + hh) -- lower right
	t:SetVertexOffset(2, dx + hw, dy + hh) -- lower left
end

-- Lay out the n points in hx/hy (local units around the rectangle's centre,
-- y up, convex, either winding) on textures get(1), get(2), ...: the rim
-- `rim` units wide (at most 0.4 of the way to the centre), in r, g, b at
-- alpha a. Leaves the polygon clockwise in hx/hy. Returns the textures used,
-- the rectangle's half extents and the point count.
local function layHull(n, rim, get, r, g, b, a)
	local m = 0
	for i = 1, n do
		local x, y = hx[i], hy[i]
		if m == 0 or abs(x - hx[m]) > HULL_EPSILON or abs(y - hy[m]) > HULL_EPSILON then
			m = m + 1
			hx[m], hy[m] = x, y
		end
	end
	if m > 1 and abs(hx[m] - hx[1]) <= HULL_EPSILON and abs(hy[m] - hy[1]) <= HULL_EPSILON then m = m - 1 end
	n = m
	if n < 3 then return 0, 0, 0, n end
	local area2, hw, hh, mx, my = 0, 0, 0, 0, 0
	for i = 1, n do
		local j = i % n + 1
		area2 = area2 + hx[i] * hy[j] - hx[j] * hy[i]
		hw, hh = max(hw, abs(hx[i])), max(hh, abs(hy[i]))
		mx, my = mx + hx[i] / n, my + hy[i] / n
	end
	if area2 > 0 then -- counter-clockwise: the quads' corners run clockwise
		for i = 1, floor(n / 2) do
			local j = n + 1 - i
			hx[i], hx[j] = hx[j], hx[i]
			hy[i], hy[j] = hy[j], hy[i]
		end
	end
	-- Outward edge normals (inX/inY hold them for now) and how far the
	-- centre is from the nearest edge.
	local inner = math.huge
	for i = 1, n do
		local j = i % n + 1
		local dx, dy = hx[j] - hx[i], hy[j] - hy[i]
		local len = sqrt(dx * dx + dy * dy)
		local nx, ny = -dy / len, dx / len
		inX[i], inY[i] = nx, ny
		local d = (hx[i] - mx) * nx + (hy[i] - my) * ny
		if d < inner then inner = d end
	end
	local w = rim
	if w > inner * 0.4 then w = inner * 0.4 end
	if w < 0 then w = 0 end
	-- The inset: each point moved in along the bisector of its two edges'
	-- normals, w from both edges.
	local px, py = inX[n], inY[n]
	for i = 1, n do
		local nx, ny = inX[i], inY[i]
		local k = w / (1 + px * nx + py * ny)
		inX[i], inY[i] = hx[i] - (px + nx) * k, hy[i] - (py + ny) * k
		px, py = nx, ny
	end
	local used = 0
	for k = 2, n - 1, 2 do
		local k2 = k + 2 > n and n or k + 2
		used = used + 1
		local t = get(used)
		bend(t, hw, hh, inX[1], inY[1], inX[k], inY[k], inX[k + 1], inY[k + 1], inX[k2], inY[k2])
		t:SetVertexColor(r, g, b, a * HULL_FILL)
	end
	for i = 1, n do
		local j = i % n + 1
		used = used + 1
		local t = get(used)
		bend(t, hw, hh, hx[i], hy[i], hx[j], hy[j], inX[j], inY[j], inX[i], inY[i])
		t:SetVertexColor(r, g, b, a * HULL_RIM)
	end
	return used, hw, hh, n
end

-- Copy the polygon in hx/hy into out (diagnostics and tests).
local function outline(out, n)
	for i = 1, n do out[2 * i - 1], out[2 * i] = hx[i], hy[i] end
	for i = #out, 2 * n + 1, -1 do out[i] = nil end
	return out
end

---------------------------------------------------------------------------
-- Trail placement, shared by both surfaces and allocation-free: a run's
-- points go into scratch arrays in the surface's units (yards around the
-- player, or map percent), each segment is clipped to what shows, and dots
-- fill the clipped part.
---------------------------------------------------------------------------

local trail -- { runs, world, minimap, r, g, b, version } or nil
local trailVersion = 0

-- World -> surface for loadRun: u = ua * wx + ub * wy + uc, v = va * wx + vb * wy + vc.
local ua, ub, uc, va, vb, vc = 1, 0, 0, 0, 1, 0
-- Clip bounds of the current draw: a rectangle, or a circle around (0, 0) (radius squared).
local cx0, cy0, cx1, cy1, cr2 = 0, 0, 100, 100, 0
local tx, ty, tr = {}, {}, {} -- one run in surface units, and yards from each point to its end
local dotX, dotY = {}, {}     -- placed dots, in surface units

-- One Liang-Barsky edge: p * t <= q narrows [t0, t1], or nil when nothing is left.
local function clipEdge(p, q, t0, t1)
	if p == 0 then
		if q < 0 then return nil end
		return t0, t1
	end
	local r = q / p
	if p < 0 then
		if r > t1 then return nil end
		if r > t0 then t0 = r end
	else
		if r < t0 then return nil end
		if r < t1 then t1 = r end
	end
	return t0, t1
end

-- The part of segment a -> b inside the rectangle, as t0 < t1 along it, or nil.
local function clipRect(ax, ay, bx, by)
	local dx, dy = bx - ax, by - ay
	local t0, t1 = clipEdge(-dx, ax - cx0, 0, 1)
	if t0 then t0, t1 = clipEdge(dx, cx1 - ax, t0, t1) end
	if t0 then t0, t1 = clipEdge(-dy, ay - cy0, t0, t1) end
	if t0 then t0, t1 = clipEdge(dy, cy1 - ay, t0, t1) end
	return t0, t1
end

-- The part of segment a -> b inside the circle, as t0 < t1 along it, or nil.
local function clipCircle(ax, ay, bx, by)
	local dx, dy = bx - ax, by - ay
	local a = dx * dx + dy * dy
	if a == 0 then return nil end
	local b = ax * dx + ay * dy
	local disc = b * b - a * (ax * ax + ay * ay - cr2)
	if disc <= 0 then return nil end
	local s = sqrt(disc)
	local t0, t1 = (-b - s) / a, (-b + s) / a
	if t0 < 0 then t0 = 0 end
	if t1 > 1 then t1 = 1 end
	if t0 >= t1 then return nil end
	return t0, t1
end

-- Dots along the n points in tx/ty (tr: yards to the end), `spacing` yards
-- apart and anchored to the end: dot k sits (k + frac) * spacing yards
-- before it. clip(ax, ay, bx, by) -> t0, t1 keeps the part of a segment that
-- shows. Appends to dotX/dotY after `count`, from the start, at most `cap`
-- in all; returns the new count. A segment owns its end point, not its start.
local function runDots(n, spacing, frac, clip, cap, count)
	for i = 1, n - 1 do
		if count >= cap then break end
		local dA = tr[i]
		local len = dA - tr[i + 1]
		if len > 0 then
			local ax, ay, bx, by = tx[i], ty[i], tx[i + 1], ty[i + 1]
			local t0, t1 = 0, 1
			if clip then t0, t1 = clip(ax, ay, bx, by) end
			if t0 then
				local lo, hi = dA - t1 * len, dA - t0 * len -- yards before the end
				local k = ceil(hi / spacing - frac) - 1
				local d = (k + frac) * spacing
				while d >= lo and count < cap do
					local t = (dA - d) / len
					count = count + 1
					dotX[count], dotY[count] = ax + (bx - ax) * t, ay + (by - ay) * t
					k = k - 1
					d = (k + frac) * spacing
				end
			end
		end
	end
	return count
end

-- A run's points into tx/ty/tr in surface units, the player first when the
-- run is live and the player is on its continent. Returns the point count.
local function loadRun(run, pc, px, py)
	local wxs, wys, rem = run.wx, run.wy, run.rem
	local n = 0
	if run.live and pc == run.c and px then
		local dx, dy = wxs[1] - px, wys[1] - py
		n = 1
		tx[1], ty[1], tr[1] = ua * px + ub * py + uc, va * px + vb * py + vc, rem[1] + sqrt(dx * dx + dy * dy)
	end
	for i = 1, run.n do
		local wx, wy = wxs[i], wys[i]
		n = n + 1
		tx[n], ty[n], tr[n] = ua * wx + ub * wy + uc, va * wx + vb * wy + vc, rem[i]
	end
	return n
end

local function stillTrail()
	return ns.Get("ui.reduceMotion") and true or false
end

-- The dots' phase: the fraction of a spacing between a run's end and its
-- nearest dot. It falls as time passes, so the dots crawl toward the end.
local function trailFrac()
	if stillTrail() then return TRAIL_STILL end
	return (-GetTime() / TRAIL_PERIOD) % 1
end

-- Placement alone (tests): dots along pts = { { x, y }, ... } (yards),
-- `spacing` apart, dot k at (k + phase) * spacing before the last point,
-- inside rect = { x0, y0, x1, y1 } when given, at most `cap`.
-- Returns the count and { { x, y }, ... } from the line's start.
function Pins.TrailDots(pts, spacing, phase, rect, cap)
	local n = #pts
	if n < 2 then return 0, {} end
	for i = 1, n do tx[i], ty[i] = pts[i][1], pts[i][2] end
	tr[n] = 0
	for i = n - 1, 1, -1 do
		local dx, dy = tx[i + 1] - tx[i], ty[i + 1] - ty[i]
		tr[i] = tr[i + 1] + sqrt(dx * dx + dy * dy)
	end
	if rect then cx0, cy0, cx1, cy1 = rect[1], rect[2], rect[3], rect[4] end
	local count = runDots(n, spacing, phase or 0, rect and clipRect or nil, cap or math.huge, 0)
	local out = {}
	for i = 1, count do out[i] = { dotX[i], dotY[i] } end
	return count, out
end

-- runs = { { live = true?, point, ... }, ... }, point = { c, wx, wy } (world
-- yards). Each run is one line; a live run starts at the player when they
-- are on its continent; a continent change inside a run breaks it there.
-- opts = { world = true, minimap = true, color = { r, g, b } }.
function Pins.SetTrail(runs, opts)
	opts = type(opts) == "table" and opts or {}
	local list = {}
	local function close(run)
		if not run or run.n < (run.live and 1 or 2) then return end
		local wx, wy, rem = run.wx, run.wy, run.rem
		rem[run.n] = 0
		for i = run.n - 1, 1, -1 do
			local dx, dy = wx[i + 1] - wx[i], wy[i + 1] - wy[i]
			rem[i] = rem[i + 1] + sqrt(dx * dx + dy * dy)
		end
		list[#list + 1] = run
	end
	for _, src in ipairs(type(runs) == "table" and runs or {}) do
		local live, run = src.live and true or false, nil
		for _, p in ipairs(src) do
			local c, wx, wy = p.c, tonumber(p.wx), tonumber(p.wy)
			if c and wx and wy then
				if run and run.c ~= c then
					close(run)
					run, live = nil, false
				end
				if not run then run = { c = c, live = live, n = 0, wx = {}, wy = {}, rem = {} } end
				local n = run.n
				if n == 0 or run.wx[n] ~= wx or run.wy[n] ~= wy then
					n = n + 1
					run.n, run.wx[n], run.wy[n] = n, wx, wy
				end
			end
		end
		close(run)
	end
	local world, minimap = opts.world ~= false, opts.minimap ~= false
	if #list == 0 or not (world or minimap) then
		Pins.ClearTrail()
		return
	end
	trailVersion = trailVersion + 1
	local r, g, b = pinColor(opts)
	trail = { runs = list, world = world, minimap = minimap, r = r, g = g, b = b, version = trailVersion }
	refreshWorld()
	refreshMinimap(true)
end

function Pins.ClearTrail()
	if not trail then return end
	trail = nil
	refreshWorld()
	refreshMinimap(true)
end

-- The trail as drawn from: { runs = { { c, live, n, wx, wy, rem }, ... }, world, minimap, ... } or nil.
function Pins.GetTrail()
	return trail
end

---------------------------------------------------------------------------
-- World map: frames of Polestar's own on the map's canvas, driven by the
-- world map's view (Core/MapCanvas.lua). The map is only read: no data
-- provider, no pin pool of the map's, no AcquirePin, so the gamepad
-- interface's secure code never meets a value of Polestar's (see the
-- header of Core/MapCanvas.lua). Each kind sits at the frame level the map
-- gives Blizzard's own pins of that sort:
--   pins        PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST, counter-scaled as a
--               map pin with SetScalingLimits(1, 1, 1.25) is (the same size
--               on screen zoomed out, a quarter larger zoomed in); tooltip
--               and click, with the mouse and with the gamepad's map cursor
--               and A (below), the right button passed through to the map
--               (zoom out)
--   areas, hulls, trail dots
--               PIN_FRAME_LEVEL_QUEST_BLOB, under every pin, no mouse; areas
--               and hulls in canvas units (they scale with the terrain),
--               dots counter-scaled like the pins
-- A kind's frames are used in order, made in that order: the i-th pin of a
-- draw is always the i-th frame, so a redraw hands every frame back the pin
-- it showed, and higher priorities, drawn last, sit on top. Layer changes
-- while the map is open are drawn once, on its next frame.
---------------------------------------------------------------------------

-- What the rest of the file reads: the view, the frames drawn (n of each
-- kind), the trail's textures, install, flush and dotsShown.
local world = { pins = { n = 0 }, areas = { n = 0 }, hulls = { n = 0 } }

do
	local PIN_LEVEL, BLOB_LEVEL = "PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST", "PIN_FRAME_LEVEL_QUEST_BLOB"
	local PIN_ZOOMED = 1.25 -- pin scale zoomed in (1 zoomed out)

	local wView              -- the world map's view, once Blizzard_WorldMap is loaded
	local wDirty = false     -- something to draw on the map's next frame
	local wPins, wAreas, wHulls = world.pins, world.areas, world.hulls
	local wTrail             -- { host, dots = { texture, ... }, n, size, version }
	local passPending = false -- pin frames made in combat wait for its end to pass the right button through
	-- The viewed map (viewMap): its continent, world yards -> percent, and the
	-- trail's dot spacing (nil continent: no trail or hull can show there).
	local wC, wLeft, wTop, wKx, wKy, wSpacing
	local viewMap -- forward

	-- Centre frame f on (x, y), percent of the viewed map, at scale s.
	local function placeAt(f, x, y, s)
		local v = wView
		f:SetScale(s)
		f:ClearAllPoints()
		f:SetPoint("CENTER", v.canvas, "TOPLEFT", v.width * x / 100 / s, -v.height * y / 100 / s)
	end

	-- SetPassThroughButtons is restricted in combat on Forever
	-- (SimpleScriptRegionAPI: IsProtectedFunction + HasRestrictions): set once
	-- per frame, and for frames made in combat once it ends (PLAYER_REGEN_ENABLED).
	local function passRightButton(f)
		if InCombatLockdown and InCombatLockdown() then
			passPending = true
			return
		end
		f:SetPassThroughButtons("RightButton")
		f.passThroughSet = true
	end
	ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
		if not passPending then return end
		passPending = false
		for i = 1, #wPins do
			if not wPins[i].passThroughSet then passRightButton(wPins[i]) end
		end
	end)

	-- A pin takes clicks without a click script. As the gamepad interface
	-- focuses the map, Blizzard_GamepadSmartNavigation scans every frame
	-- under it for buttons (Utility.lua, SmartNavigation_CanFocusFrame) and
	-- takes a frame with an OnMouseDown or OnMouseUp script for one, reading
	-- that script back with GetScript: Polestar's function in its secure
	-- code. Seen in game: the map's FocusGamepad then registered its
	-- SmartNavigation callbacks tainted, and the next close blocked the
	-- interface's actions. So a pin only takes the mouse (a left click stays
	-- off the map under it; the right button passes through), its OnEnter
	-- and OnLeave say which pin the pointer is on, and a click is a
	-- GLOBAL_MOUSE_DOWN and a GLOBAL_MOUSE_UP of one button on that pin.
	-- Pins.OnWorldClick(fn): fn(pin, layer, button) -> true takes a click
	-- on a world map pin before the pin's onClick (Nav/Journey.lua: Shift
	-- lets the target go).
	local mousePin, pressedPin, pressedButton
	local clickFilters = {}
	function Pins.OnWorldClick(fn) clickFilters[#clickFilters + 1] = fn end
	ns.RegisterEvent("GLOBAL_MOUSE_DOWN", function(_, button)
		if button == "RightButton" then return end
		pressedPin, pressedButton = mousePin, button
	end)
	ns.RegisterEvent("GLOBAL_MOUSE_UP", function(_, button)
		local f = pressedPin
		pressedPin = nil
		if not (f and f == mousePin and button == pressedButton and f:IsVisible()) then return end
		local d = f.data
		for i = 1, #clickFilters do
			if clickFilters[i](d.pin, d.layer, button) then return end
		end
		click(d.pin, button)
	end)

	local function worldPin(i)
		local f = wPins[i]
		if f then return f end
		f = ns.CreateFrameUnder("Frame", nil, wView.canvas)
		buildLook(f)
		f.data = {}
		f:EnableMouse(true)
		f:SetScript("OnEnter", function(self)
			mousePin = self
			showTooltip(self, self.data.pin)
		end)
		f:SetScript("OnLeave", function(self)
			if mousePin == self then mousePin = nil end
			GameTooltip:Hide()
		end)
		passRightButton(f)
		wPins[i] = f
		return f
	end

	-- Areas: a pin's `area` (yards) as a disc, its diameter dx / 50 of the
	-- canvas's width (dx: the radius in percent of the map's width).
	local function worldArea(i)
		local f = wAreas[i]
		if f then return f end
		f = ns.CreateFrameUnder("Frame", nil, wView.canvas)
		f.tex = f:CreateTexture(nil, "BACKGROUND")
		f.tex:SetTexture(MEDIA .. "area")
		f.tex:SetAllPoints()
		f.data = {}
		wAreas[i] = f
		return f
	end

	local function layoutArea(f)
		local d = f.data
		local size = d.dx / 50 * wView.width
		f:SetSize(size, size)
		placeAt(f, d.x, d.y, 1)
	end

	-- Hulls: a pin's `hull` as a region in canvas units; the rim stays
	-- HULL_RIM_WIDTH wide on screen at any zoom.
	local function worldHull(i)
		local f = wHulls[i]
		if f then return f end
		f = ns.CreateFrameUnder("Frame", nil, wView.canvas)
		f.texs, f.used, f.outline = {}, 0, {}
		f.get = function(k)
			local t = f.texs[k]
			if not t then
				t = hullTexture(f)
				t:SetAllPoints(f)
				f.texs[k] = t
			end
			t:Show()
			return t
		end
		f.data = { xs = {}, ys = {} }
		wHulls[i] = f
		return f
	end

	local function rimWidth()
		return HULL_RIM_WIDTH / (wView.scale or 1)
	end

	local function layoutHull(f)
		local d, v = f.data, wView
		local w, h = v.width, v.height
		local xs, ys, x, y = d.xs, d.ys, d.x, d.y
		for i = 1, d.n do hx[i], hy[i] = (xs[i] - x) / 100 * w, (y - ys[i]) / 100 * h end
		f.rim = rimWidth()
		local r, g, b, a = pinColor(d.pin)
		local used, hw, hh, n = layHull(d.n, f.rim, f.get, r, g, b, a)
		for k = used + 1, f.used do f.texs[k]:Hide() end
		f.used = used
		f:SetSize(max(2 * hw, 1), max(2 * hh, 1))
		outline(f.outline, used > 0 and n or 0)
		placeAt(f, x, y, 1)
	end

	-- Hide a kind's frames from index `from` on; they keep no pin.
	local function hideFrom(list, from)
		for i = from, list.n do
			local f = list[i]
			f:Hide()
			f.data.pin, f.data.layer = nil, nil
		end
	end

	-- Radius of a pin's area in percent of the viewed map's width, or nil.
	-- World y runs along the map's x axis (Compat.MapToWorld).
	local function areaRadius(p, layer, i, x, mapID, C)
		local r = tonumber(p.area)
		local c = layer.c[i]
		if not (r and r > 0 and c and C and C.WorldToMap) then return nil end
		local wx, wy = layer.wx[i], layer.wy[i]
		local x2 = C.WorldToMap(c, wx, wy + r, mapID) or C.WorldToMap(c, wx, wy - r, mapID)
		if not x2 then return nil end
		local dx = abs(x2 - x)
		return dx > 0 and dx or nil
	end

	-- A pin's hull in percent of the viewed map (same continent), drawn as the
	-- count + 1st hull when any of it lies on that map. Returns the new count.
	local sx, sy = {}, {}
	local function hullOn(p, layer, i, count, level)
		local hull, c = p.hull, layer.c[i]
		if not (c and c == wC) then return count end
		local n = 0
		local x0, y0, x1, y1 = math.huge, math.huge, -math.huge, -math.huge
		for k = 1, #hull - 1, 2 do
			local x, y = (hull[k + 1] - wLeft) * wKx, (hull[k] - wTop) * wKy
			n = n + 1
			sx[n], sy[n] = x, y
			if x < x0 then x0 = x end
			if x > x1 then x1 = x end
			if y < y0 then y0 = y end
			if y > y1 then y1 = y end
		end
		if n < 3 or x1 < 0 or x0 > 100 or y1 < 0 or y0 > 100 then return count end
		local f = worldHull(count + 1)
		local d = f.data
		local xs, ys = d.xs, d.ys
		for k = 1, n do xs[k], ys[k] = sx[k], sy[k] end
		d.pin, d.layer, d.n = p, layer, n
		d.x, d.y = (layer.wy[i] - wLeft) * wKx, (layer.wx[i] - wTop) * wKy
		f:SetFrameLevel(level)
		layoutHull(f)
		f:Show()
		return count + 1
	end

	-- Higher priority draws last, so it lands on top.
	local queue, qPin, qLayer, qX, qY, qPri = {}, {}, {}, {}, {}, {}
	local function byPriority(a, b)
		if qPri[a] ~= qPri[b] then return qPri[a] < qPri[b] end
		return a < b
	end

	-- Every layer's pins, areas and hulls, and the trail, for the viewed map.
	local function drawWorld()
		wDirty = false
		local v = wView
		local mapID = v.mapID
		local C = ns.Compat
		local n, areas, hulls = 0, 0, 0
		if mapID then
			viewMap(mapID)
			local pinLevel, blobLevel = v:Level(PIN_LEVEL), v:Level(BLOB_LEVEL)
			for _, name in ipairs(order) do
				local layer = layers[name]
				if layer and layer.world and not hidden[name] then
					if not layer.resolved then resolveLayer(layer) end
					local pins = layer.pins
					for i = 1, #pins do
						local p = pins[i]
						if type(p.hull) == "table" then hulls = hullOn(p, layer, i, hulls, blobLevel) end
						if not (p.areaOnly and not p.area) then
							local x, y
							if p.map == mapID and p.x and p.y and not p.f then
								x, y = p.x, p.y
							elseif layer.c[i] and C and C.WorldToMap then
								x, y = C.WorldToMap(layer.c[i], layer.wx[i], layer.wy[i], mapID)
							end
							if x and x >= 0 and x <= 100 and y >= 0 and y <= 100 then
								if not p.areaOnly then
									n = n + 1
									queue[n], qPin[n], qLayer[n], qX[n], qY[n], qPri[n] = n, p, layer, x, y, tonumber(p.priority) or 0
								end
								if p.area then
									local dx = areaRadius(p, layer, i, x, mapID, C)
									if dx then
										areas = areas + 1
										local f = worldArea(areas)
										local d = f.data
										d.pin, d.layer, d.x, d.y, d.dx = p, layer, x, y, dx
										local r, g, b, a = pinColor(p)
										f.tex:SetVertexColor(r, g, b, a * AREA_ALPHA)
										f:SetFrameLevel(blobLevel)
										layoutArea(f)
										f:Show()
									end
								end
							end
						end
					end
				end
			end
			for i = #queue, n + 1, -1 do queue[i] = nil end
			table.sort(queue, byPriority)
			local scale = v:PinScale(1, PIN_ZOOMED)
			for k = 1, n do
				local i = queue[k]
				local f = worldPin(k)
				local d = f.data
				d.pin, d.layer, d.x, d.y = qPin[i], qLayer[i], qX[i], qY[i]
				applyLook(f, d.pin, (tonumber(d.pin.size) or WORLD_SIZE) * d.layer.scale)
				f:SetFrameLevel(pinLevel)
				placeAt(f, d.x, d.y, scale)
				f:Show()
			end
			for i = 1, n do qPin[i], qLayer[i] = nil, nil end
		else
			wC = nil
		end
		hideFrom(wPins, n + 1)
		hideFrom(wAreas, areas + 1)
		hideFrom(wHulls, hulls + 1)
		wPins.n, wAreas.n, wHulls.n = n, areas, hulls
		drawTrailWorld(trailFrac())
		updateTrailDriver()
	end

	-- Zooming: pins and dots keep their size on screen, hull rims their width
	-- (within a quarter); areas and hulls scale with the terrain.
	local function rescaleWorld()
		local scale = wView:PinScale(1, PIN_ZOOMED)
		for i = 1, wPins.n do
			local f = wPins[i]
			placeAt(f, f.data.x, f.data.y, scale)
		end
		local rim = rimWidth()
		for i = 1, wHulls.n do
			local f = wHulls[i]
			if not f.rim or rim > f.rim * 1.25 or rim < f.rim * 0.8 then layoutHull(f) end
		end
		local t = wTrail
		local size = WORLD_DOT * scale
		if t and t.size ~= size then
			t.size = size
			local dots = t.dots
			for i = 1, t.n do dots[i]:SetSize(size, size) end
			for i = t.n + 1, #dots do dots[i].styled = nil end
		end
	end

	function world.dotsShown()
		return wTrail ~= nil and wTrail.n > 0 and wView ~= nil and wView.shown
	end

	-- The gamepad interface's map cursor (Blizzard_GamepadSoftCursor's
	-- SoftCursor, moved by the stick while the map has the gamepad's focus)
	-- is no mouse: the map hovers its own pins near it
	-- (MapCanvasMixin:UpdateGamepadCursor, within 12 units) and clicks them
	-- on A (WorldMapMixin:GamepadMapClick). Polestar's pins do the same on
	-- the view's frames, reading the cursor: the nearest pin with a tooltip
	-- or a click within CURSOR_REACH shows its tooltip, and a press of A
	-- clicks it. A is polled with IsKeyDown, as Blizzard_GamepadActionBars'
	-- ClassActionFlyout polls its buttons, so the press still reaches the map.
	local CURSOR_REACH, CURSOR_INTERVAL = 12, 0.05 -- UI units; seconds between searches
	local hovered, hoveredPin, cursorAcc, padDown = nil, nil, 0, false

	local function unhover()
		if hovered and GameTooltip:GetOwner() == hovered then GameTooltip:Hide() end
		hovered, hoveredPin = nil, nil
	end

	-- The pin frame nearest screen point (cx, cy) that shows a tooltip or
	-- takes a click, within reach; its place from its map percent and the
	-- canvas's (no layout read per pin).
	local function pinAt(cx, cy)
		local v = wView
		local canvas = v.canvas
		local left, top = canvas:GetLeft(), canvas:GetTop()
		if not (left and top) then return nil end
		local cs = canvas:GetEffectiveScale()
		local reach = CURSOR_REACH * UIParent:GetEffectiveScale()
		local best, bestD = nil, reach * reach
		for i = 1, wPins.n do
			local f = wPins[i]
			local d = f.data
			if d.pin.tooltip or d.pin.onClick then
				local dx = (left + v.width * d.x / 100) * cs - cx
				local dy = (top - v.height * d.y / 100) * cs - cy
				local dd = dx * dx + dy * dy
				if dd <= bestD then best, bestD = f, dd end
			end
		end
		return best
	end

	local function followGamepadCursor(elapsed)
		local cursor = SoftCursor
		if not (cursor and cursor:IsShown()) then
			if hovered then unhover() end
			padDown = false
			return
		end
		cursorAcc = cursorAcc + elapsed
		if cursorAcc >= CURSOR_INTERVAL or (hovered and not hovered:IsShown()) then
			cursorAcc = 0
			local x, y = cursor:GetCenter()
			local s = cursor:GetEffectiveScale()
			local f = x and pinAt(x * s, y * s)
			local p = f and f.data.pin
			if p ~= hoveredPin or f ~= hovered then
				unhover()
				if f then
					hovered, hoveredPin = f, p
					showTooltip(f, p)
				end
			end
		end
		local down = IsKeyDown and IsKeyDown(GAMEPAD_FACE_BOTTOM or "PAD1") and true or false
		if down and not padDown and hovered then click(hoveredPin, "LeftButton") end
		padDown = down
	end

	local function onWorldView(_, what, elapsed)
		if what == "tick" then
			if wDirty then drawWorld() else world.followView() end
			followGamepadCursor(elapsed)
		elseif what == "show" or what == "map" or what == "size" then
			drawWorld()
		elseif what == "scale" then
			rescaleWorld()
		elseif what == "hide" then
			unhover()
			padDown = false
			updateTrailDriver()
		end
	end

	function world.install()
		if wView then return true end
		local M = ns.MapCanvas
		wView = WorldMapFrame and M and M.Watch(WorldMapFrame, onWorldView) or nil
		world.view = wView
		world.openMap() -- OpenMap's menu switch, when it is loaded (an optional dependency: before Polestar)
		return wView ~= nil
	end

	-- Layers and the trail changed: drawn on the open map's next frame (a
	-- closed map draws everything as it opens).
	function refreshWorld()
		if wView and wView.shown then wDirty = true end
	end

	-- A draw still due this frame runs now (diagnostics and tests).
	function world.flush()
		if wDirty and wView and wView.shown then drawWorld() end
	end

	---------------------------------------------------------------------------
	-- OpenMap (an optional world map addon, its OpenMapAPI: docs/api.md in
	-- its repository). While its stitched map shows, the world map frame's
	-- map is only the zone or continent under the view's centre (or the
	-- whole world, 947), and the art around it is OpenMap's: the trail is
	-- drawn wherever it shows on screen, through OpenMap's own placement of
	-- every map on the stitched world, so the dots carry on into the
	-- neighbouring zones and across the world view. Only OpenMap's table is
	-- called (read-only, plus a switch of Polestar's in its menu); the map
	-- frame is read as everywhere else.
	--   nav.openmapDots   the trail on OpenMap's stitched map (on; its menu's switch)
	---------------------------------------------------------------------------
	local OM_MARGIN = 0.04   -- of the view's size: dots placed just past its edges
	local omHooked = false
	local omOn = false       -- the last trail draw went through OpenMap
	local omX0, omY0, omX1, omY1 = 0, 0, 0, 0 -- the view it was drawn for (map percent)
	local omRefs = {}        -- host map -> { [continent] = { map, left, top, kx, ky } }, measured once
	local omFit = {}         -- host map -> { [continent] = { ub, uc, va, vc } }: world yards -> host percent

	-- A map's continent and world yards -> percent (viewMap's measure), or nil.
	local function frameOf(C, mapID)
		local c1, top, left = C.MapToWorld(mapID, 0, 0)
		local c2, bottom, right = C.MapToWorld(mapID, 100, 100)
		if not (c1 and c1 == c2 and top ~= bottom and left ~= right) then return nil end
		return { map = mapID, c = c1, left = left, top = top, kx = 100 / (right - left), ky = 100 / (bottom - top) }
	end

	-- The maps that tell each continent's world yards on the host map: the
	-- host itself on one continent, else (the world map) its children.
	local function refsFor(C, host)
		local refs = omRefs[host]
		if refs then return refs end
		refs = {}
		local own = frameOf(C, host)
		if own then
			refs[own.c] = own
		elseif C_Map and C_Map.GetMapChildrenInfo then
			local ok, kids = pcall(C_Map.GetMapChildrenInfo, host)
			if ok and type(kids) == "table" then
				for _, kid in ipairs(kids) do
					local f = kid and kid.mapID and frameOf(C, kid.mapID)
					if f and not refs[f.c] then refs[f.c] = f end
				end
			end
		end
		omRefs[host] = refs
		return refs
	end

	-- World yards on continent c -> percent of the host map, as OpenMap
	-- places the reference map on its stitched world; nil when it can't.
	local function fitFor(OM, C, host, c)
		local byC = omFit[host]
		if not byC then
			byC = {}
			omFit[host] = byC
		end
		local fit = byC[c]
		if fit ~= nil then return fit or nil end
		local ref = refsFor(C, host)[c]
		if not ref then
			byC[c] = false
			return nil
		end
		local ok, u0, v0 = pcall(OM.WorldFromMap, ref.map, 0, 0)
		local ok1, u1, v1 = pcall(OM.WorldFromMap, ref.map, 1, 1)
		if not (ok and ok1 and u0 and u1) then return nil end -- (not built yet: asked again next draw)
		local okA, hx0, hy0 = pcall(OM.MapFromWorld, host, u0, v0)
		local okB, hx1, hy1 = pcall(OM.MapFromWorld, host, u1, v1)
		if not (okA and okB and hx0 and hx1) or hx0 == hx1 or hy0 == hy1 then return nil end
		-- reference percent: x = (wy - left) * kx, y = (wx - top) * ky; host percent = 100 * h0 + ref * (h1 - h0)
		local ub, va = ref.kx * (hx1 - hx0), ref.ky * (hy1 - hy0)
		fit = { ub = ub, uc = 100 * hx0 - ref.left * ub, va = va, vc = 100 * hy0 - ref.top * va }
		byC[c] = fit
		return fit
	end

	-- Dot spacing for a view `pct` percent of the host wide, at `perYard`
	-- percent a yard: a WORLD_DIVS-th of the view, at least
	-- WORLD_MIN_SPACING, in steps of twice the last, so the dots keep their
	-- places while a zoom stays within a step.
	local LOG2 = math.log(2)
	local function stitchedSpacing(pct, perYard)
		local raw = pct / abs(perYard) / WORLD_DIVS
		if raw <= WORLD_MIN_SPACING then return WORLD_MIN_SPACING end
		return WORLD_MIN_SPACING * 2 ^ ceil(math.log(raw / WORLD_MIN_SPACING) / LOG2 - 1e-9)
	end

	-- What the map's scroll frame shows of the canvas, in percent of the
	-- viewed map: x0, y0, x1, y1 (reads only: the canvas and its parent's place).
	local function viewRect()
		local v = wView
		local canvas = v.canvas
		local frame = canvas.GetParent and canvas:GetParent()
		local w, h = v.width or 0, v.height or 0
		if not frame or w <= 0 or h <= 0 then return 0, 0, 100, 100 end
		local cl, ct, cs = canvas:GetLeft(), canvas:GetTop(), canvas:GetEffectiveScale()
		local fl, ft, fr, fb, fs = frame:GetLeft(), frame:GetTop(), frame:GetRight(), frame:GetBottom(), frame:GetEffectiveScale()
		if not (cl and ct and fl and ft and fr and fb and cs and fs and cs > 0) then return 0, 0, 100, 100 end
		local kx, ky = 100 / (w * cs), 100 / (h * cs)
		return (fl * fs - cl * cs) * kx, (ct * cs - ft * fs) * ky, (fr * fs - cl * cs) * kx, (ct * cs - fb * fs) * ky
	end

	-- OpenMap's switch: the trail on its map.
	local function hookOpenMap(OM)
		if omHooked then return end
		omHooked = true
		if type(OM.RegisterCallback) == "function" then
			pcall(OM.RegisterCallback, Pins, "OpenMap_StitchedChanged", function() refreshWorld() end)
		end
		if type(OM.RegisterMenuToggle) == "function" then
			pcall(OM.RegisterMenuToggle, ADDON, {
				id = "trailDots",
				label = L["Polestar trail dots"],
				section = "Polestar",
				icon = MEDIA .. "pin-fill",
				get = function() return ns.Get("nav.openmapDots") and true or false end,
				set = function(on) ns.Set("nav.openmapDots", on and true or false) end,
			})
		end
	end
	ns.On("SETTING_CHANGED", function(path)
		if path == "nav.openmapDots" or path == "" or path == "nav" then refreshWorld() end
	end)

	-- OpenMapAPI while its stitched map shows, else nil.
	local function openMap()
		local OM = OpenMapAPI
		if type(OM) ~= "table" or OM.major ~= 1 or type(OM.IsStitched) ~= "function"
			or type(OM.WorldFromMap) ~= "function" or type(OM.MapFromWorld) ~= "function" then
			return nil
		end
		hookOpenMap(OM)
		local ok, on = pcall(OM.IsStitched)
		return ok and on and OM or nil
	end
	world.openMap = openMap

	-- The trail on OpenMap's stitched map: every run whose continent the
	-- host map can place, clipped to the view (and a margin). Returns the count.
	local function stitchedTrail(OM, frac, pc, px, py)
		if not ns.Get("nav.openmapDots") then return 0 end
		local C = ns.Compat
		local host = wView.mapID
		if not (C and C.MapToWorld and host) then return 0 end
		local x0, y0, x1, y1 = viewRect()
		omX0, omY0, omX1, omY1 = x0, y0, x1, y1
		local mx, my = (x1 - x0) * OM_MARGIN, (y1 - y0) * OM_MARGIN
		cx0, cy0, cx1, cy1 = x0 - mx, y0 - my, x1 + mx, y1 + my
		local count, runs = 0, trail.runs
		for k = 1, #runs do
			local run = runs[k]
			local fit = fitFor(OM, C, host, run.c)
			if fit then
				ua, ub, uc, va, vb, vc = 0, fit.ub, fit.uc, fit.va, 0, fit.vc
				count = runDots(loadRun(run, pc, px, py), stitchedSpacing(x1 - x0, fit.ub), frac, clipRect, WORLD_CAP, count)
			end
		end
		return count
	end

	-- Every frame of the open map: on OpenMap's map a pan or zoom moves the
	-- view without changing the map, so the trail follows it here.
	function world.followView()
		if not (omOn and trail and trail.world) then return end
		local x0, y0, x1, y1 = viewRect()
		local eps = (omX1 - omX0) * 0.002
		if abs(x0 - omX0) > eps or abs(y0 - omY0) > eps or abs(x1 - omX1) > eps or abs(y1 - omY1) > eps then
			drawTrailWorld(trailFrac())
			updateTrailDriver()
		end
	end

	function viewMap(mapID)
		wC = nil
		local C = ns.Compat
		if not (mapID and C and C.MapToWorld) then return end
		local c1, top, left = C.MapToWorld(mapID, 0, 0)
		local c2, bottom, right = C.MapToWorld(mapID, 100, 100)
		if not (c1 and c1 == c2 and top ~= bottom and left ~= right) then return end
		wC, wLeft, wTop = c1, left, top
		wKx, wKy = 100 / (right - left), 100 / (bottom - top)
		wSpacing = max(WORLD_MIN_SPACING, abs(right - left) / WORLD_DIVS)
	end

	-- The trail's dots: textures on one frame at the canvas's top left, laid out
	-- in canvas units; WORLD_DOT on screen like a pin.
	local function trailHost()
		if wTrail then return wTrail end
		local host = ns.CreateFrameUnder("Frame", nil, wView.canvas)
		host:SetPoint("TOPLEFT", wView.canvas, "TOPLEFT", 0, 0)
		host:SetSize(1, 1)
		wTrail = { host = host, dots = {}, n = 0 }
		world.trail = wTrail
		return wTrail
	end

	-- Place the world map's trail dots, reusing the textures already made and
	-- hiding the rest (on the map viewMap last measured).
	function drawTrailWorld(frac)
		local count = 0
		local v = wView
		omOn = false
		if trail and trail.world and v and v.shown then
			local C = ns.Compat
			local pc, px, py
			if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
			local OM = openMap()
			if OM then
				omOn = true
				count = stitchedTrail(OM, frac, pc, px, py)
			elseif wC then
				ua, ub, uc, va, vb, vc = 0, wKx, -wLeft * wKx, wKy, 0, -wTop * wKy
				cx0, cy0, cx1, cy1 = 0, 0, 100, 100
				local runs = trail.runs
				for k = 1, #runs do
					local run = runs[k]
					if run.c == wC then count = runDots(loadRun(run, pc, px, py), wSpacing, frac, clipRect, WORLD_CAP, count) end
				end
			end
		end
		local t = wTrail
		if count > 0 then
			t = trailHost()
			t.host:SetFrameLevel(v:Level(BLOB_LEVEL))
			local size = WORLD_DOT * v:PinScale(1, PIN_ZOOMED)
			local restyle = t.size ~= size or t.version ~= trail.version
			t.size, t.version = size, trail.version
			local w, h, dots = v.width, v.height, t.dots
			for i = 1, count do
				local dot = dots[i]
				if not dot then
					dot = t.host:CreateTexture(nil, "ARTWORK")
					dot:SetTexture(MEDIA .. "pin-fill")
					dots[i] = dot
				end
				if restyle or not dot.styled then
					dot:SetSize(size, size)
					dot:SetVertexColor(trail.r, trail.g, trail.b, TRAIL_ALPHA)
					dot.styled = true
				end
				if i > t.n then dot:Show() end
				dot:ClearAllPoints()
				dot:SetPoint("CENTER", t.host, "TOPLEFT", dotX[i] / 100 * w, -dotY[i] / 100 * h)
			end
			-- Dots past the count wait unstyled: the size may change before they show again.
			for i = count + 1, #dots do dots[i].styled = nil end
		end
		if t then
			for i = count + 1, t.n do t.dots[i]:Hide() end
			t.n = count
		end
	end
end

---------------------------------------------------------------------------
-- Minimap
---------------------------------------------------------------------------

local mmActive = {}   -- frames in use
local mmFree = {}     -- released frames
local assigned = {}   -- pin table -> frame
local gen = 0
local driver, watcher
local sPc, sPx, sPy, sFacing, sRadius, sRotate, sHalf, sSquare -- last drawn state
local dirty = true

local function viewRadius()
	if C_Minimap and C_Minimap.GetViewRadius then
		local r = C_Minimap.GetViewRadius()
		if type(r) == "number" and r > 0 then return r end
	end
	local zoom = Minimap.GetZoom and Minimap:GetZoom() or 0
	local indoors = IsIndoors and IsIndoors()
	local d = (indoors and INDOOR or OUTDOOR)[zoom] or OUTDOOR[0]
	return d / 2
end

local function isRotating()
	if not GetCVar or GetCVar("rotateMinimap") ~= "1" then return false end
	if C_Minimap and C_Minimap.IsRotateMinimapIgnored and C_Minimap.IsRotateMinimapIgnored() then return false end
	return true
end

local function isSquare()
	return GetMinimapShape ~= nil and GetMinimapShape() == "SQUARE"
end

local function hasMinimapPins()
	if trail and trail.minimap then return true end
	for _, name in ipairs(order) do
		local layer = layers[name]
		if layer and layer.minimap and not hidden[name] and #layer.pins > 0 then return true end
	end
	return false
end

-- Pixel offset from the minimap centre for a world delta (north, west), and
-- whether it was clamped to the rim. limit = nil: no clamping.
function Pins.Project(dNorth, dWest, facing, radius, half, rotate, square, limit)
	local scale = half / radius
	local x, y = -dWest * scale, dNorth * scale -- east, north
	if rotate and facing then
		local c, s = cos(facing), sin(facing)
		x, y = x * c + y * s, -x * s + y * c
	end
	if limit then
		local reach
		if square then reach = max(abs(x), abs(y)) else reach = sqrt(x * x + y * y) end
		if reach > limit then
			local k = limit / reach
			return x * k, y * k, true
		end
	end
	return x, y, false
end

-- What the minimap shows: radius (yards from its centre to its rim), facing
-- (radians when it rotates with the player, else nil), square (bool).
function Pins.MinimapView()
	local C = ns.Compat
	local facing = isRotating() and C and C.GetPlayerFacing and C.GetPlayerFacing() or nil
	return viewRadius(), facing, isSquare()
end

-- The world delta (dNorth, dWest yards) from the player to the cursor on the
-- minimap: Pins.Project undone. nil when the cursor is off the minimap's face.
function Pins.MinimapCursor()
	if not (Minimap and GetCursorPosition and Minimap.GetCenter) then return nil end
	local cx, cy = Minimap:GetCenter()
	if not cx then return nil end
	local scale = Minimap:GetEffectiveScale()
	local mx, my = GetCursorPosition()
	local x, y = mx / scale - cx, my / scale - cy -- east, north, in pixels
	local half = Minimap:GetWidth() / 2
	if half <= 0 then return nil end
	if isSquare() then
		if max(abs(x), abs(y)) > half then return nil end
	elseif x * x + y * y > half * half then
		return nil
	end
	local _, facing = Pins.MinimapView()
	if facing then
		local c, s = cos(facing), sin(facing)
		x, y = x * c - y * s, x * s + y * c
	end
	local k = (Pins.MinimapView()) / half
	return y * k, -x * k
end

local function acquireMinimap()
	local f = table.remove(mmFree)
	if not f then
		f = ns.CreateFrameUnder("Frame", nil, Minimap)
		buildLook(f)
		f:SetScript("OnEnter", function(self) showTooltip(self, self.pin) end)
		f:SetScript("OnLeave", function() GameTooltip:Hide() end)
		f:SetScript("OnMouseUp", function(self, button) click(self.pin, button) end)
	end
	mmActive[#mmActive + 1] = f
	return f
end

local function releaseAt(i)
	local f = mmActive[i]
	local n = #mmActive
	mmActive[i] = mmActive[n]
	mmActive[n] = nil
	if f.pin then assigned[f.pin] = nil end
	f.pin, f.layer = nil, nil
	f:Hide()
	f:ClearAllPoints()
	mmFree[#mmFree + 1] = f
end

local function releaseAllMinimap()
	for i = #mmActive, 1, -1 do releaseAt(i) end
end

-- Pin indexes of `layer` that may be in reach, in pin order (scratch list):
-- every pin on the player's continent for an edge layer, else the pins in
-- the grid squares the reach circle touches.
local near = {}
local function nearPins(layer, reach)
	local n = 0
	if layer.edge then
		local list = layer.byC and layer.byC[sPc]
		if list then
			for k = 1, #list do near[k] = list[k] end
			n = #list
		end
	else
		local gc = layer.grid and layer.grid[sPc]
		if gc then
			local floor = math.floor
			for gx = floor((sPx - reach) / CELL), floor((sPx + reach) / CELL) do
				local col = gc[gx]
				if col then
					for gy = floor((sPy - reach) / CELL), floor((sPy + reach) / CELL) do
						local cell = col[gy]
						if cell then
							for k = 1, #cell do
								n = n + 1
								near[n] = cell[k]
							end
						end
					end
				end
			end
		end
	end
	for k = #near, n + 1, -1 do near[k] = nil end
	if n > 1 then table.sort(near) end
	return near, n
end

-- Minimap redraws and pins they examined (diagnostics and tests).
local stats = { draws = 0, visited = 0 }
Pins.stats = stats

-- Trail dots on the minimap: textures on one frame just under the pins.
local mmTrail
local mmDots, mmDotCount, mmTrailAt = {}, 0, -1

local function minimapDot(i)
	if not mmTrail then
		mmTrail = ns.CreateFrameUnder("Frame", nil, Minimap)
		mmTrail:SetAllPoints(Minimap)
		mmTrail:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 4)
	end
	local t = mmTrail:CreateTexture(nil, "ARTWORK")
	t:SetTexture(MEDIA .. "pin-fill")
	t:SetSize(MM_DOT, MM_DOT)
	mmDots[i] = t
	return t
end

-- Place the trail's dots for the current state (sPc, sPx, ...) and phase;
-- with no trail (or none on the minimap) this hides them.
local function drawTrailMinimap(frac)
	local shown = 0
	if trail and trail.minimap and sPc then
		local half, radius, square = sHalf, sRadius, sSquare
		local lim = half - MM_DOT / 2
		ua, ub, uc, va, vb, vc = 1, 0, -sPx, 0, 1, -sPy
		cr2 = radius * radius * (square and 2 or 1) -- a square's corners reach radius * sqrt(2)
		local count = 0
		local runs = trail.runs
		for k = 1, #runs do
			local run = runs[k]
			if run.c == sPc then count = runDots(loadRun(run, sPc, sPx, sPy), MM_SPACING, frac, clipCircle, MM_CAP, count) end
		end
		local project, version = Pins.Project, trail.version
		for i = 1, count do
			local x, y = project(dotX[i], dotY[i], sFacing, radius, half, sRotate, square, nil)
			local inside
			if square then inside = abs(x) <= lim and abs(y) <= lim else inside = x * x + y * y <= lim * lim end
			if inside then
				shown = shown + 1
				local t = mmDots[shown] or minimapDot(shown)
				if t.trailVersion ~= version then
					t:SetVertexColor(trail.r, trail.g, trail.b, TRAIL_ALPHA)
					t.trailVersion = version
				end
				t:ClearAllPoints()
				t:SetPoint("CENTER", Minimap, "CENTER", x, y)
				t:Show()
			end
		end
	end
	for i = shown + 1, mmDotCount do mmDots[i]:Hide() end
	mmDotCount = shown
	mmTrailAt = GetTime()
end

-- Areas on the minimap (layers with minimapAreas): textures on one frame
-- just under the trail, masked to the minimap's shape so a disc or hull
-- reaching past the rim is cut there (a round minimap: pin-fill's disc, which
-- covers 42 of its 64 pixels; a square one: a plain square). A client
-- without mask textures shows only the ones that fit inside.
local SQUARE_MASK = "Interface\\Buttons\\WHITE8X8"
local mmArea, mmMask, mmMaskSquare, mmMaskHalf
local mmAreas, mmAreaCount = {}, 0
-- Hulls: one record per hull drawn, { pin, texs, used, outline, ... }.
local mmHulls, mmHullCount = {}, 0

-- The mask follows the minimap's shape and size.
local function shapeMask(square, half)
	if not mmMask or (square == mmMaskSquare and half == mmMaskHalf) then return end
	mmMaskSquare, mmMaskHalf = square, half
	local d = square and half * 2 or half * 2 * 64 / 42
	mmMask:SetTexture(square and SQUARE_MASK or MEDIA .. "pin-fill", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	mmMask:SetSize(d, d)
end

local function areaFrame()
	if mmArea then return end
	mmArea = ns.CreateFrameUnder("Frame", nil, Minimap)
	mmArea:SetAllPoints(Minimap)
	mmArea:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 3)
	if mmArea.CreateMaskTexture then
		mmMask = mmArea:CreateMaskTexture()
		mmMask:SetPoint("CENTER", mmArea, "CENTER", 0, 0)
		shapeMask(sSquare, sHalf)
	end
end

local function minimapArea(i)
	local t = mmArea:CreateTexture(nil, "BACKGROUND")
	t:SetTexture(MEDIA .. "area")
	if mmMask and t.AddMaskTexture then t:AddMaskTexture(mmMask) end
	mmAreas[i] = t
	return t
end

-- Place pin p's area (yards) at the world offset (dn, dw) from the player as
-- the count-th disc; returns the new count.
local function placeArea(count, p, layer, dn, dw, area)
	local half, radius = sHalf, sRadius
	areaFrame()
	if not mmMask and sqrt(dn * dn + dw * dw) + area > radius then return count end
	count = count + 1
	local t = mmAreas[count] or minimapArea(count)
	if t.pin ~= p or t.version ~= layer.version then
		local r, g, b, a = pinColor(p)
		t:SetVertexColor(r, g, b, a * AREA_ALPHA)
		t.pin, t.layer, t.version = p, layer, layer.version
	end
	local d = 2 * area * half / radius
	local x, y = Pins.Project(dn, dw, sFacing, radius, half, sRotate, sSquare, nil)
	t:SetSize(d, d)
	t:ClearAllPoints()
	t:SetPoint("CENTER", Minimap, "CENTER", x, y)
	t:Show()
	return count
end

local function hideAreasFrom(count)
	for i = count + 1, mmAreaCount do
		local t = mmAreas[i]
		t:Hide()
		t.pin, t.layer = nil, nil
	end
	mmAreaCount = count
end

local function hullRecord(i)
	local rec = { texs = {}, used = 0, outline = {} }
	-- Piece k shares piece 1's rectangle, so placing piece 1 places the hull.
	rec.get = function(k)
		local t = rec.texs[k]
		if not t then
			t = hullTexture(mmArea)
			if mmMask and t.AddMaskTexture then t:AddMaskTexture(mmMask) end
			if k > 1 then t:SetAllPoints(rec.texs[1]) end
			rec.texs[k] = t
		end
		t:Show()
		return t
	end
	mmHulls[i] = rec
	return rec
end

-- Place layer pin i's hull, its centre at the world offset (dn, dw) from the
-- player, as the count-th hull; returns the new count. Its shape is laid out
-- again only when the pin, the zoom, the minimap's size or (rotating) the
-- facing changed; walking only moves it.
local function placeHull(count, p, layer, i, dn, dw)
	areaFrame()
	if not mmMask and sqrt(dn * dn + dw * dw) + layer.reach[i] > sRadius then return count end
	count = count + 1
	local rec = mmHulls[count] or hullRecord(count)
	local facing = sRotate and sFacing or false
	if rec.pin ~= p or rec.version ~= layer.version or rec.radius ~= sRadius or rec.half ~= sHalf or rec.facing ~= facing then
		local hull, cx, cy, n = p.hull, layer.wx[i], layer.wy[i], 0
		local project = Pins.Project
		for k = 1, #hull - 1, 2 do
			n = n + 1
			hx[n], hy[n] = project(hull[k] - cx, hull[k + 1] - cy, sFacing, sRadius, sHalf, sRotate, sSquare, nil)
		end
		local r, g, b, a = pinColor(p)
		local used, hw, hh
		used, hw, hh, n = layHull(n, HULL_RIM_WIDTH, rec.get, r, g, b, a)
		for k = used + 1, rec.used do rec.texs[k]:Hide() end
		rec.used = used
		if used > 0 then rec.texs[1]:SetSize(2 * hw, 2 * hh) end
		outline(rec.outline, used > 0 and n or 0)
		rec.pin, rec.layer, rec.version, rec.radius, rec.half, rec.facing = p, layer, layer.version, sRadius, sHalf, facing
	end
	if rec.used > 0 then
		local x, y = Pins.Project(dn, dw, sFacing, sRadius, sHalf, sRotate, sSquare, nil)
		local t = rec.texs[1]
		t:ClearAllPoints()
		t:SetPoint("CENTER", Minimap, "CENTER", x, y)
		rec.x, rec.y = x, y
	end
	return count
end

local function hideHullsFrom(count)
	for i = count + 1, mmHullCount do
		local rec = mmHulls[i]
		for k = 1, rec.used do rec.texs[k]:Hide() end
		rec.used, rec.pin, rec.layer = 0, nil, nil
	end
	mmHullCount = count
end

-- Place every visible pin for the current state (sPc, sPx, ...).
local function drawMinimap()
	gen = gen + 1
	stats.draws = stats.draws + 1
	local half = sHalf
	local base = (Minimap:GetFrameLevel() or 1) + 5
	local areas, hulls = 0, 0
	if sPc then
		local reach = sRadius * MINIMAP_REACH
		local reach2 = reach * reach
		-- How far from the player the view reaches: a square's corners reach
		-- radius * sqrt(2).
		local view = sSquare and sRadius * 1.415 or sRadius
		shapeMask(sSquare, half)
		for _, name in ipairs(order) do
			local layer = layers[name]
			if layer and layer.minimap and not hidden[name] then
				if not layer.resolved then resolveLayer(layer) end
				local pins, lx, ly = layer.pins, layer.wx, layer.wy
				local edge = layer.edge
				local size = MINIMAP_SIZE * layer.scale
				local maxArea = layer.maxArea or 0
				local list, n = nearPins(layer, maxArea > 0 and max(reach, view + maxArea) or reach)
				stats.visited = stats.visited + n
				for k = 1, n do
					local i = list[k]
					local dn, dw = lx[i] - sPx, ly[i] - sPy
					local d2 = dn * dn + dw * dw
					local p = pins[i]
					if maxArea > 0 then
						local r = layer.reach[i]
						if r > 0 and d2 <= (view + r) * (view + r) then
							if type(p.hull) == "table" then
								hulls = placeHull(hulls, p, layer, i, dn, dw)
							elseif p.area then
								areas = placeArea(areas, p, layer, dn, dw, r)
							end
						end
					end
					if not p.areaOnly and (edge or d2 <= reach2) then
						local f = assigned[p]
						local own = tonumber(p.minimapSize) or tonumber(p.size)
						local psize = (own or MINIMAP_SIZE) * layer.scale
						if not f or f.layer ~= layer or f.version ~= layer.version then
							if not f then
								f = acquireMinimap()
								assigned[p] = f
							end
							f.pin, f.layer, f.version = p, layer, layer.version
							applyLook(f, p, own and psize or size)
							f:SetFrameLevel(base + max(0, tonumber(p.priority) or 0))
							f:EnableMouse(p.tooltip ~= nil or p.onClick ~= nil)
							f:Show()
						end
						f.gen = gen
						local x, y, clamped = Pins.Project(dn, dw, sFacing, sRadius, half, sRotate, sSquare,
							edge and (half - (own and psize or size) * 0.35) or nil)
						f:ClearAllPoints()
						f:SetPoint("CENTER", Minimap, "CENTER", x, y)
						if clamped ~= f.clamped then
							f.clamped = clamped
							showParts(f, p, clamped)
						end
						if clamped then f.edge:SetRotation(atan2(y, x) - pi / 2) end
					end
				end
			end
		end
	end
	for i = #mmActive, 1, -1 do
		if mmActive[i].gen ~= gen then releaseAt(i) end
	end
	hideAreasFrom(areas)
	hideHullsFrom(hulls)
	drawTrailMinimap(trailFrac())
	-- Held still, the world map's dots follow the player with these redraws.
	if world.dotsShown() and stillTrail() then drawTrailWorld(TRAIL_STILL) end
	updateTrailDriver()
end

-- Compare the state the minimap pins depend on; redraw when it changed.
-- Returns true when something changed.
local function sample(force)
	if not Minimap then return false end
	local C = ns.Compat
	local pc, px, py
	if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	local rotate = isRotating()
	local facing = rotate and C and C.GetPlayerFacing and C.GetPlayerFacing() or nil
	local radius, half, square = viewRadius(), Minimap:GetWidth() / 2, isSquare()
	if not force and not dirty and pc == sPc and px == sPx and py == sPy and facing == sFacing
		and radius == sRadius and rotate == sRotate and half == sHalf and square == sSquare then
		return false
	end
	sPc, sPx, sPy, sFacing, sRadius, sRotate, sHalf, sSquare = pc, px, py, facing, radius, rotate, half, square
	dirty = false
	drawMinimap()
	return true
end

local idle, accum = 0, 0

local function wake()
	if driver and not driver:IsShown() then
		idle, accum = 0, 0
		driver:Show()
	end
end

local function ensureMinimap()
	if driver or not Minimap then return end
	driver = CreateFrame("Frame", nil, UIParent)
	driver:Hide()
	driver:SetScript("OnUpdate", function(self, elapsed)
		accum = accum + elapsed
		if accum < DRIVE_INTERVAL then return end
		local step = accum
		accum = 0
		if sample(false) then
			idle = 0
		else
			idle = idle + step
			if idle >= IDLE_AFTER then self:Hide() end
		end
	end)
	Pins.driver = driver
end

local function updateWatcher()
	local want = hasMinimapPins()
	if want and not watcher and C_Timer and C_Timer.NewTicker then
		watcher = C_Timer.NewTicker(WATCH_INTERVAL, function()
			if sample(false) then
				wake()
			elseif mmDotCount > 0 then
				updateTrailDriver() -- the minimap may have been shown again
			end
		end)
	elseif not want and watcher then
		watcher:Cancel()
		watcher = nil
	end
end

local function redraw(force)
	updateWatcher()
	if not hasMinimapPins() then
		releaseAllMinimap()
		hideAreasFrom(0)
		hideHullsFrom(0)
		drawTrailMinimap(0) -- no trail: hides its dots
		dirty = true
		return
	end
	sample(force)
end

-- Layer changes in one frame share one redraw on the next (unless the
-- watcher drew them first).
local queued = false
local function flushQueued()
	if not queued then return end
	queued = false
	redraw(dirty)
end

-- layersChanged: pins or visibility changed, redraw on the next frame.
function refreshMinimap(layersChanged)
	if not Minimap then return end
	ensureMinimap()
	if layersChanged then
		dirty = true
		if C_Timer and C_Timer.After then
			if not queued then
				queued = true
				C_Timer.After(0, flushQueued)
			end
			return
		end
	end
	redraw(layersChanged)
end

-- The pin a world map frame of Pins shows: { pin, layer, x, y } (x, y in
-- percent of the viewed map), or nil for any other frame (Nav/Journey.lua
-- tells Polestar's pins under the mouse by it).
function Pins.WorldPinOf(frame)
	local list = world.pins
	for i = 1, list.n do
		if list[i] == frame then return frame.data end
	end
	return nil
end

-- Frames drawn on the open world map, in draw order (diagnostics and tests;
-- a draw still due this frame runs first): kind "pins" (a frame's `data`:
-- { pin, layer, x, y }, x and y in percent of the viewed map), "areas" (the
-- same and dx, the radius in percent of the map's width) or "hulls" (the
-- same and xs, ys, n, the corners; the frame's `used` pieces of `texs`, its
-- `outline`).
function Pins.GetWorldFrames(kind)
	world.flush()
	local list = kind == "areas" and world.areas or kind == "hulls" and world.hulls or world.pins
	local out = {}
	if world.view and world.view.shown then
		for i = 1, list.n do out[i] = list[i] end
	end
	return out
end

-- Frames currently drawn on the minimap for a layer (diagnostics and tests;
-- a redraw still queued for this frame runs first).
function Pins.GetMinimapFrames(name)
	flushQueued()
	local out = {}
	for _, f in ipairs(mmActive) do
		if f.layer and f.layer.name == name then out[#out + 1] = f end
	end
	return out
end

-- Area discs currently drawn on the minimap for a layer (diagnostics and
-- tests; a redraw still queued for this frame runs first).
function Pins.GetMinimapAreas(name)
	flushQueued()
	local out = {}
	for i = 1, mmAreaCount do
		local t = mmAreas[i]
		if t.layer and t.layer.name == name then out[#out + 1] = t end
	end
	return out
end

-- Hulls currently drawn on the minimap for a layer (diagnostics and tests; a
-- redraw still queued for this frame runs first): { pin, texs, used,
-- outline = { x1, y1, ... } (pixels around x, y, its centre's place on the
-- minimap, y up), x, y }.
function Pins.GetMinimapHulls(name)
	flushQueued()
	local out = {}
	for i = 1, mmHullCount do
		local rec = mmHulls[i]
		if rec.layer and rec.layer.name == name and rec.used > 0 then out[#out + 1] = rec end
	end
	return out
end

-- What the areas draw now, per surface: hulls and the textures they are cut
-- from, and discs (in game: /dump Polestar.Pins.AreaStats()).
function Pins.AreaStats()
	flushQueued()
	local out = { world = { hulls = 0, pieces = 0, discs = 0 }, minimap = { hulls = 0, pieces = 0, discs = mmAreaCount } }
	world.flush()
	if world.view and world.view.shown then
		local hulls = world.hulls
		for i = 1, hulls.n do
			out.world.hulls = out.world.hulls + 1
			out.world.pieces = out.world.pieces + hulls[i].used
		end
		out.world.discs = world.areas.n
	end
	for i = 1, mmHullCount do
		local used = mmHulls[i].used
		if used > 0 then
			out.minimap.hulls = out.minimap.hulls + 1
			out.minimap.pieces = out.minimap.pieces + used
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Trail animation: one driver for both surfaces, at most every
-- TRAIL_INTERVAL, awake only while dots show on a visible minimap or an
-- open world map and motion is not reduced.
---------------------------------------------------------------------------

local trailDriver
local trailAccum = 0

local function minimapTrailShown()
	return mmDotCount > 0 and Minimap ~= nil and Minimap:IsVisible() and true or false
end


local function trailTick(self, elapsed)
	trailAccum = trailAccum + elapsed
	if trailAccum < TRAIL_INTERVAL then return end
	trailAccum = 0
	local frac = trailFrac()
	-- The pins' own redraw may have drawn the minimap's dots this frame.
	if minimapTrailShown() and GetTime() - mmTrailAt >= TRAIL_INTERVAL / 2 then drawTrailMinimap(frac) end
	if world.dotsShown() then drawTrailWorld(frac) end
	updateTrailDriver()
end

function updateTrailDriver()
	if not stillTrail() and (minimapTrailShown() or world.dotsShown()) then
		if not trailDriver then
			trailDriver = CreateFrame("Frame", nil, UIParent)
			trailDriver:Hide()
			trailDriver:SetScript("OnUpdate", trailTick)
			Pins.trailDriver = trailDriver
		end
		if not trailDriver:IsShown() then
			trailAccum = 0
			trailDriver:Show()
		end
	elseif trailDriver and trailDriver:IsShown() then
		trailDriver:Hide()
	end
end

-- Trail dots drawn on a surface (textures: "minimap" or "world"), from the
-- line's start (diagnostics and tests; a queued redraw runs first).
function Pins.GetTrailFrames(surface)
	local out = {}
	if surface == "world" then
		world.flush()
		local t = world.trail
		for i = 1, t and t.n or 0 do out[i] = t.dots[i] end
	else
		flushQueued()
		for i = 1, mmDotCount do out[i] = mmDots[i] end
	end
	return out
end

-- ui.reduceMotion stops or restarts the crawl at once.
ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "ui" and path ~= "ui.reduceMotion" then return end
	if not trail then return end
	local frac = trailFrac()
	if Minimap then drawTrailMinimap(frac) end
	if world.view and world.view.shown then drawTrailWorld(frac) end
	updateTrailDriver()
end)

local function moved()
	if hasMinimapPins() then wake() end
end
for _, event in ipairs({
	"PLAYER_STARTED_MOVING", "PLAYER_STARTED_TURNING", "MINIMAP_UPDATE_ZOOM", "CVAR_UPDATE",
	"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD",
}) do
	ns.RegisterEvent(event, moved)
end

-- A late Compat (or a map frame registered after SetLayer) resolves pins again.
local function reresolve()
	for _, name in ipairs(order) do
		local layer = layers[name]
		if layer and (not layer.resolved or layer.unresolved > 0) then resolveLayer(layer) end
	end
	refreshWorld()
	refreshMinimap(true)
end
ns.OnInit(reresolve)

ns.OnLogin(function()
	reresolve()
	if world.install() then return end
	local function onLoaded(_, name)
		if name == "Blizzard_WorldMap" and world.install() then ns.UnregisterEvent("ADDON_LOADED", onLoaded) end
	end
	ns.RegisterEvent("ADDON_LOADED", onLoaded)
end)

if type(ns.Theme) == "table" and type(ns.Theme.OnChanged) == "function" then
	ns.Theme.OnChanged(function()
		for _, name in ipairs(order) do
			local layer = layers[name]
			if layer then layer.version = layer.version + 1 end
		end
		refreshWorld()
		refreshMinimap(true)
	end)
end
