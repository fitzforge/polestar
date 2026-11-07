-- The ground around the player from Polestar's walking maps: heights for the
-- ground trail and a line-of-sight test, so the trail stops where a wall,
-- building or hill hides the route.
--
-- Polestar_Nav ships the walkable surfaces of every 4.17 yd cell
-- (Polestar_NavEngine.SurfacesAt(map, x, y, out): n surfaces, heights in
-- out[1..n], marks in out[-1..-n], bit 1 water, bit 2 indoor or indoor city;
-- 0 for a cell with nothing walkable; nil while the cell's map tile is not
-- decoded). That read has side effects: Polestar keeps one tile decoded for
-- its own floor tracking (the player's), a read in another tile evicts it or
-- cancels Polestar's own decode, a read off the grid or in a tile without
-- data drops it, and a read of an undecoded tile queues its decode. So:
--   * real reads happen only when the caller allows them (Render.lua: on a
--     walk leg Polestar is following, not on a transport, not arrived), only
--     in the player's own tile once they have been in it SETTLE seconds, and
--     never in a tile without data;
--   * the player's own cell is read at Polestar's own cadence (PROBE_EVERY,
--     after moving PROBE_MOVE), and other cells only while that read found
--     the tile decoded;
--   * every cell read is cached (the maps never change), and a cell not in
--     the cache that can't be read now is unknown, never guessed.
-- A read of the player's undecoded tile queues the same decode Polestar's
-- own floor read does; nothing here releases or prefetches anything else.
local ADDON, ns = ...
local NS = ns.WorldTrail
if not NS then return end -- No world-trail settings without the Nav module.

local Terrain = {}
NS.Terrain = Terrain

local TILE = 1600 / 3     -- yards a map tile (one decoded cluster) spans
local CACHE_MAX = 6000    -- cells cached before the cache starts over
local INDOOR = 2          -- Path.SURFACE_INDOOR
local PROBE_EVERY = 0.25  -- seconds between reads of the player's own cell (Polestar's Walk.lua EVERY)
local PROBE_MOVE = 1      -- yards moved before it is read again (Walk.lua MOVE)
local SETTLE = 0.5        -- seconds in a new tile before it is read (a step over the border and back reads nothing)

local floor, sqrt, abs, huge = math.floor, math.sqrt, math.abs, math.huge

local surf = {}
local cache, cached, cacheMap = {}, 0, nil
local here  -- the player's accepted tile: { map, E, D, kx, ky, live, allow, at, x, y }
local cand  -- a tile the player has stepped into: { kx, ky, since }

local function data(map)
	local E = _G.Polestar_NavEngine
	if type(E) ~= "table" or type(E.SurfacesAt) ~= "function" then return nil end
	if E.HasData then
		local ok, has = pcall(E.HasData, map)
		if not ok or not has then return nil end
	end
	local all = _G.PolestarPathData
	local D = type(all) == "table" and all[map] or nil
	if type(D) ~= "table" or not (D.cx0 and D.cy0 and D.nx and D.ny and D.cells) then return nil end
	return E, D
end

-- Grid cell and tile of a point, as the router locates it (Routing/PathGrid.lua locate); nil off the grid.
local function cellOf(D, x, y)
	local C = D.cells
	local cs = TILE / C
	local gx = floor((x - D.cx0 * TILE) / cs)
	local gy = floor((y - D.cy0 * TILE) / cs)
	if gx < 0 or gy < 0 or gx >= D.nx * C or gy >= D.ny * C then return nil end
	return gx, gy, floor(gx / C), floor(gy / C)
end

-- A tile the maps hold nothing for (its read would drop Polestar's tile): its
-- packed grid string is missing. Unpacked (loose) data is taken as present.
local function noData(D, kx, ky)
	local key = kx * D.ny + ky + 1
	local packed = type(D.packed) == "table" and D.packed.grid or nil
	if type(packed) ~= "table" then return false end
	if packed[key] ~= nil then return false end
	return not (type(D.grid) == "table" and D.grid[key] ~= nil)
end

local function store(key, n)
	local cell = false
	if n > 0 then
		cell = { n = n }
		for i = 1, n do cell[i], cell[-i] = surf[i], surf[-i] end
	end
	if cached >= CACHE_MAX then cache, cached = {}, 0 end
	cache[key], cached = cell, cached + 1
	return cell
end

-- Starts a frame at the player. allowRead: whether the maps may be read now.
-- Returns true when there is a map to work with (cached cells at least).
function Terrain.Begin(map, px, py, now, allowRead)
	local E, D = data(map)
	if not E then here, cand = nil, nil return false end
	if cacheMap ~= map then cache, cached, cacheMap, here, cand = {}, 0, map, nil, nil end
	local gx, gy, kx, ky = cellOf(D, px, py)
	if not gx then
		if here then here.allow = false end
		return here ~= nil
	end
	if not here then
		here = { map = map, kx = kx, ky = ky, live = false, at = -huge }
	elseif here.kx ~= kx or here.ky ~= ky then
		if not (cand and cand.kx == kx and cand.ky == ky) then cand = { kx = kx, ky = ky, since = now } end
		if now - cand.since >= SETTLE then
			here.kx, here.ky, here.live, here.at, cand = kx, ky, false, -huge, nil
		end
	else
		cand = nil
	end
	here.E, here.D = E, D
	here.allow = allowRead and here.kx == kx and here.ky == ky and not noData(D, kx, ky) or false
	if not here.allow then
		here.live = false
		return true
	end
	local moved = not here.x or (px - here.x) ^ 2 + (py - here.y) ^ 2 >= PROBE_MOVE * PROBE_MOVE
	if now - here.at >= PROBE_EVERY and (moved or not here.live) then
		here.at, here.x, here.y = now, px, py
		local ok, n = pcall(E.SurfacesAt, map, px, py, surf)
		here.live = ok and n ~= nil or false
		if here.live then
			local key = gx * 65536 + gy
			if cache[key] == nil then store(key, n) end
		end
	end
	return true
end

-- A cell's surfaces: { n, [i] = height, [-i] = marks } or false (nothing
-- walkable), or nil when unknown; and its key.
function Terrain.Cell(x, y)
	local h = here
	if not (h and h.D) then return nil end
	local gx, gy, kx, ky = cellOf(h.D, x, y)
	if not gx then return nil end
	local key = gx * 65536 + gy
	local cell = cache[key]
	if cell ~= nil then return cell, key end
	if not (h.allow and h.live) or kx ~= h.kx or ky ~= h.ky then return nil end
	local ok, n = pcall(h.E.SurfacesAt, h.map, x, y, surf)
	if not ok then return nil end
	if n == nil then h.live = false return nil end -- evicted since the probe: stop reading
	return store(key, n), key
end

-- The surface of a cell nearest `ref` and at most `rise` above it (the lowest
-- when ref is nil), with its marks; nil when none.
function Terrain.Nearest(cell, ref, rise)
	if not cell then return nil end
	local best, gap, marks
	for i = 1, cell.n do
		local z = cell[i]
		if type(z) == "number" and (not ref or z <= ref + rise) then
			local g = ref and abs(z - ref) or z
			if not gap or g < gap then best, gap, marks = z, g, cell[-i] end
		end
	end
	return best, marks
end

-- The surface of a cell nearest `ref` in either direction.
function Terrain.Closest(cell, ref)
	if not cell then return nil end
	local best, gap, marks
	for i = 1, cell.n do
		local z = cell[i]
		if type(z) == "number" and (not gap or abs(z - ref) < gap) then best, gap, marks = z, abs(z - ref), cell[-i] end
	end
	return best, marks
end

local function indoor(marks) return marks and marks % (2 * INDOOR) >= INDOOR or false end
Terrain.Indoor = indoor

local ZTOL = 10 -- yards: surfaces this close the router stands on alike (Polestar's Walk.lua seed)

-- An unknown floor from a cell, as Polestar's own floor tracking seeds it:
-- the lowest when all its surfaces lie within ZTOL; else, by whether the
-- player is indoors, the lowest of the matching ones when those lie within
-- ZTOL; else nil (ambiguous: wait to walk somewhere clearer).
function Terrain.Seed(cell, indoors)
	if not cell or cell.n == 0 then return nil end
	local lo, hi, loM = huge, -huge, nil
	for i = 1, cell.n do
		local z = cell[i]
		if z < lo then lo, loM = z, cell[-i] end
		if z > hi then hi = z end
	end
	if hi - lo <= ZTOL then return lo, loM end
	if indoors == nil then return nil end
	local mlo, mhi, mM = huge, -huge, nil
	for i = 1, cell.n do
		if indoor(cell[-i]) == indoors then
			local z = cell[i]
			if z < mlo then mlo, mM = z, cell[-i] end
			if z > mhi then mhi = z end
		end
	end
	if mhi >= mlo and mhi - mlo <= ZTOL then return mlo, mM end
	return nil
end

---------------------------------------------------------------------------
-- Line of sight
---------------------------------------------------------------------------

local STEP = TILE / 128 / 2 -- yards between samples along a ray: half a cell
local BELOW = 8.5           -- a surface this far under the ray still holds it up
local ABOVE = 2.5           -- a surface higher than this over the ray blocks it
local WALL = 6              -- yards over the ground before it a wall reaches (cells with nothing walkable)
local RUN = 2               -- blocked cells in a row that block a ray (a lone tree or post doesn't);
                            -- samples are half a cell apart, so cells are counted, not samples

-- Whether the eye at (ex, ey, ez) sees (tx, ty, tz): true, false, or nil when
-- a cell on the way is unknown. eyeIndoor: whether the eye stands on an
-- indoor or indoor-city surface (a ray over a surface of the other kind at its
-- height goes through a wall the maps don't draw: a building's walls are
-- thinner than a cell). groundZ: the ground under the player. (bx, by): the
-- player, for a ray from the camera: samples on the camera's boom (within
-- BOOM yards of the line from the camera to the player) are skipped, since
-- the game keeps the boom clear; the rest of the ray, beside the player too,
-- is tested.
local BOOM = 2
function Terrain.Sees(ex, ey, ez, tx, ty, tz, eyeIndoor, groundZ, bx, by)
	local dx, dy = tx - ex, ty - ey
	local len = sqrt(dx * dx + dy * dy)
	local t = STEP
	if t >= len - STEP then return true end
	local ux, uy, blen
	if bx then
		ux, uy = bx - ex, by - ey
		blen = sqrt(ux * ux + uy * uy)
		if blen > 0 then ux, uy = ux / blen, uy / blen else bx = nil end
	end
	local run, lastKey = 0, nil          -- blocked cells in a row (walls the maps draw, hills)
	local solid, solidKey, lowest = 0, nil, huge -- a run of cells with nothing walkable, undecided
	local ground = groundZ or (ez - 2)   -- the ground the ray last passed over
	-- A run of cells with nothing walkable is a wall or rock if the ground
	-- after it is about as high as before (or higher) and the ray went low
	-- over it; it is the drop below a ledge or a steep bank if the ground after
	-- is lower: the ray passes over it.
	local function wall(after)
		if solid < RUN then return false end
		if after < ground - 3 then return lowest < after end
		return lowest < ground + WALL
	end
	while t < len - STEP do
		local f = t / len
		local sx, sy = ex + dx * f, ey + dy * f
		local onBoom = false
		if bx then
			local along = (sx - ex) * ux + (sy - ey) * uy
			if along >= 0 and along <= blen then
				local qx, qy = sx - ex - ux * along, sy - ey - uy * along
				onBoom = qx * qx + qy * qy < BOOM * BOOM
			end
		end
		local cell, key
		if not onBoom then
			cell, key = Terrain.Cell(sx, sy)
			if cell == nil then return nil end
		end
		local hr = ez + (tz - ez) * f
		if onBoom then
			-- Kept clear by the game's own camera collision.
		elseif cell == false then
			if key ~= solidKey then solid, solidKey = solid + 1, key end
			if hr < lowest then lowest = hr end
		else
			local top, topMarks, above, under = nil, nil, false, false
			for i = 1, cell.n do
				local z = cell[i]
				if z >= hr - BELOW and z <= hr + ABOVE then
					if not top or z > top then top, topMarks = z, cell[-i] end
				elseif z > hr + ABOVE then
					above = true
				elseif indoor(cell[-i]) == eyeIndoor then
					under = true -- a floor of the eye's own kind below: the ray is in the room over it
				end
			end
			if above and under then above = false end -- a hall's high ceiling, not rock
			local after = top or (above and hr + ABOVE) or (hr - BELOW)
			if solid > 0 then
				if wall(after) then return false end
				solid, solidKey, lowest = 0, nil, huge
			end
			local open
			if top then
				open = indoor(topMarks) == eyeIndoor
			else
				open = not above -- only ground far below: open air over a drop
			end
			ground = after
			if open then
				run = 0
			elseif key ~= lastKey then
				run = run + 1
				if run >= RUN then return false end
			end
			lastKey = key
		end
		t = t + STEP
	end
	if solid > 0 and wall(tz - 1) then return false end
	return true
end

function Terrain.Reset() cache, cached, cacheMap, here, cand = {}, 0, nil, nil, nil end
function Terrain.Live() return here and here.allow and here.live or false end
