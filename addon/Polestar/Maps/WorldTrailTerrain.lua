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

local floor, sqrt, abs, huge, min, max = math.floor, math.sqrt, math.abs, math.huge, math.min, math.max

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
-- The ground at a marker's place
---------------------------------------------------------------------------

-- A tracked quest's marker has no place on the map, and nothing says how high
-- its place lies; the view's tilt is measured from it all the same, so one of
-- the two is taken on trust (Render.lua, fromMarker). Where the place lies in
-- a cell the maps have read, the ground there says how high it is. The place
-- is `toward` (radians) from the player at (px, py), `away` yards off through
-- the air. Returns the ground's height above `feet` (of a cell's surfaces the
-- one nearest `guess` above them), the flat distance to the place, and the
-- angle that height may be out by as seen from the player: the maps round to
-- two yards, and a marker floats a yard or two over its place. nil where the
-- maps do not say: a cell not read (another map tile, or the maps not to be
-- read now: allowRead is the caller's gate, as Terrain.Begin's), nothing
-- walkable there, or a place within PLACE_NEAR yards, where that angle is too
-- wide to tell anything by.
local PLACE_NEAR = 40
local PLACE_SLACK = 4
function Terrain.PlaceLift(map, px, py, now, allowRead, toward, away, feet, guess)
	if type(feet) ~= "number" or type(away) ~= "number" or not Terrain.Begin(map, px, py, now, allowRead) then return nil end
	local lift, flat = guess or 0, nil
	-- The distance is through the air: the flat one follows from the height, and the height from where that puts the place.
	for _ = 1, 3 do
		local flat2 = away * away - lift * lift
		flat = flat2 > 1 and sqrt(flat2) or 1
		if flat < PLACE_NEAR then return nil end
		local cell = Terrain.Cell(px + flat * math.cos(toward), py + flat * math.sin(toward))
		local z = cell and Terrain.Closest(cell, feet + lift)
		if not z then return nil end
		if abs(z - feet - lift) < 0.01 then break end
		lift = z - feet
	end
	local flat2 = away * away - lift * lift
	flat = flat2 > 1 and sqrt(flat2) or 1
	return lift, flat, PLACE_SLACK / flat
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

---------------------------------------------------------------------------
-- A strip of heights along a route
---------------------------------------------------------------------------

-- A walk without a baked leg (one the arrow searches; a guide pack that ships
-- none) has no heights of its own, and a trail drawn level from the feet runs
-- into every slope. Where the maps may be read (the caller's gate, the one the
-- sight check reads them by; nothing is decoded or held for this), the ground
-- along the next stretch of the route is sampled into a strip like a baked
-- leg's: a height a yard, from a few yards behind the player to well past the
-- trail's end, so it is sampled again only every thirty yards or so. A cell
-- with one walkable surface gives its height; one with several, the surface
-- nearest the height before it (the first of them nearest the floor the
-- player stands on, where the caller knows it: the deck of a bridge, not the
-- road under it). The surface of the next cell more than STRIP_RISE from this
-- one's is another floor, not this ground, and ends the strip: ground that
-- can be walked climbs less than that from one cell to the next. A few yards
-- with nothing walkable under the route's line (the smoothed line cuts a
-- corner the path goes round) are bridged. A cell that cannot be read yet
-- (the next map tile, read only once the player is in it) ends what is read;
-- the strip is carried on past it at the slope it had, and settles onto the
-- ground when that is read (sampleStrip, Terrain.Strip).
--
-- The maps keep one height a cell, 4.17 yd across, and round the ground's to
-- 2 yd: read as they are, a slope is a flight of steps two yards high. So the
-- strip is evened out over STRIP_EVEN yards either side of every point, with
-- the nearer heights counting for more, which turns the steps of a slope into
-- the slope again. A height depends only on the cells within that reach of
-- it, never on where the strip begins or ends: sampled again further on, the
-- same place has the same height, and nothing drawn moves.
local STRIP_EVEN = 7     -- yards either side of a point its height is evened over
local STRIP_BACK = 8     -- yards behind the player the strip begins: the evening's reach, so the feet's own height is whole
local STRIP_MORE = 30    -- yards past the trail's end it is sampled to
local STRIP_RISE = 6     -- yards up or down the next cell's surface may lie from this one's (more for more cells between)
local STRIP_GAP = 9      -- yards with nothing walkable under the route's line that are bridged
local STRIP_OVER = 10    -- yards more than the trail's own reach a strip is carried on past a cell not read yet
local STRIP_FIT = 20     -- yards of heights read last that the slope it is carried on at is taken from
local STRIP_SETTLE = 0.6 -- seconds a new strip takes to settle from the heights the one before it had
local STRIP_RETRY = 0.25 -- seconds before a strip that came up short is tried again
local CELL = TILE / 128  -- yards a cell spans
local strip = {}         -- of (the route), path (the strip, as Trail.BakedPath gives one), first (yards along the route), hint, tried

-- seed, back: the floor under the player, who stands `back` yards on from `first`; nil where it is not known.
local function sampleStrip(route, c, first, last, seed, back, over)
	local Trail = NS.Trail
	local xs, ys, cum, zs = {}, {}, {}, {}
	local m, known = 0, 0
	local unread = false
	-- The last height taken, the cell it was taken in and where along the strip that was.
	local ref, cellOfRef, refAt = seed, nil, seed and back or nil
	for k = 0, floor(last - first) do
		local x, y = Trail.PointAt(route, first + k)
		local cell, key = Terrain.Cell(x, y)
		if cell == nil then unread = true break end
		local z
		if cell then
			if ref then z = Terrain.Closest(cell, ref) elseif cell.n == 1 then z = cell[1] end
			-- Another cell's surface too far from the last height for the cells between: another floor.
			if z and ref and key ~= cellOfRef and abs(z - ref) > STRIP_RISE * (1 + max(0, abs(k - refAt) - 1) / CELL) then break end
		end
		if not z and m + 1 - known > STRIP_GAP then break end
		m = m + 1
		xs[m], ys[m], cum[m], zs[m] = x, y, k, z or false
		if z then
			-- The yards before it with nothing walkable: a straight line from the last ground to this.
			for i = known + 1, m - 1 do
				zs[i] = known > 0 and ref + (z - ref) * (i - known) / (m - known) or z
			end
			known, ref, cellOfRef, refAt = m, z, key, k
		end
	end
	if known < 2 then return nil end
	for i = known + 1, m do xs[i], ys[i], cum[i], zs[i] = nil, nil, nil, nil end
	local even = {}
	for i = 1, known do
		local sum, weight = 0, 0
		for j = max(1, i - STRIP_EVEN), min(known, i + STRIP_EVEN) do
			local w = STRIP_EVEN + 1 - abs(j - i)
			sum, weight = sum + zs[j] * w, weight + w
		end
		even[i] = sum / weight
	end
	-- Ended at a cell that cannot be read yet (the next map tile is read only once the player is in it):
	-- the strip carries on at the slope it had, for `over` yards at most. Until that tile is read it is a
	-- better guess than level ground, and the trail neither ends at the tile's edge nor falls level there
	-- and jumps back when the tile comes in. The slope is that of the line that fits the last STRIP_FIT
	-- heights read best; with too few read for one, the strip carries on level. The heights within the
	-- evening's reach of the end were evened toward the ground behind them only, so they follow that line
	-- too, from the last height evened over its whole reach.
	local count = known
	if unread and over and over >= 1 then
		local n, sx, sy, sxx, sxy = 0, 0, 0, 0, 0
		for i = max(1, known - STRIP_FIT + 1), known do
			n, sx, sy, sxx, sxy = n + 1, sx + i, sy + zs[i], sxx + i * i, sxy + i * zs[i]
		end
		local spread = n * sxx - sx * sx
		local slope = n >= 6 and spread > 0 and (n * sxy - sx * sy) / spread or 0
		if slope > 1 then slope = 1 elseif slope < -1 then slope = -1 end
		local whole = max(1, known - STRIP_EVEN)
		for i = whole + 1, known + floor(over) do
			if i > known then
				-- Sample i lies i - 1 yards on from `first`: the samples are a yard apart from the strip's first.
				if first + i - 1 > route.total then break end
				xs[i], ys[i] = Trail.PointAt(route, first + i - 1)
				cum[i], count = i - 1, i
			end
			even[i] = even[whole] + slope * (i - whole)
		end
	end
	local path = Trail.BakedPath({ c = c, n = count, xs = xs, ys = ys, distances = cum, m = count, strip = even, stripYd = 1 })
	-- real: the yards of it read from the maps; past them it is carried on.
	if path then path.real = known - 1 end
	return path
end

-- The route's next stretch as a path with heights (Trail.BakedPath's shape), how far along it the player
-- at (px, py) is and how far off it; nil where there is none to be had, and the trail is then the level
-- one. ahead, length: where the trail begins and how long it is. allowed(route, off, along): the caller's
-- gate for reading the maps now; without it only a strip already sampled is given. floor: the floor the
-- player stands on, where it is known (which of a cell's surfaces the strip starts on). The strip's
-- `origin` is where along the route it begins: a sparkle is numbered and placed by its yards along the
-- route, not along the strip, so it keeps its number and its place when the strip is sampled again.
-- The strip is sampled again while the trail's end is still STRIP_EVEN yards short of the strip's, so
-- nothing drawn lies where a height is evened over less than its whole reach.
function Terrain.Strip(route, c, px, py, now, ahead, length, allowed, floorZ)
	local Trail = NS.Trail
	if not (Trail and type(route) == "table" and route.c == c and route.kind == "walk") then return nil end
	if strip.of ~= route then strip.of, strip.path, strip.first, strip.hint, strip.tried = route, nil, nil, nil, nil end
	local along, off = Trail.Nearest(route, c, px, py, strip.hint)
	if not along then return nil end
	strip.hint = along
	local reach = min(ahead + length, route.total - along)
	local sp, first = strip.path, strip.first
	-- How far ahead of the player the strip goes, and how far of that was read from the maps.
	local have = sp and along >= first and first + sp.coverage - along or 0
	local read = sp and along >= first and first + sp.real - along or 0
	if read < min(ahead + length + STRIP_EVEN, route.total - along) - 0.5 and (not strip.tried or now - strip.tried >= STRIP_RETRY)
		and allowed and allowed(route, off, along) and Terrain.Begin(c, px, py, now, true) then
		strip.tried = now
		local from = max(0, floor(along - STRIP_BACK))
		local fresh = sampleStrip(route, c, from, min(route.total, along + ahead + length + STRIP_MORE),
			type(floorZ) == "number" and floorZ or nil, along - from, ahead + length + STRIP_OVER)
		-- Taken when more of it is read than of the one in use (not for a longer guess alone).
		if fresh and from + fresh.real - along > read then
			-- Where the strip in use has a height already, the new one starts from that and settles onto its
			-- own over STRIP_SETTLE seconds. The two differ only where the old one was carried on past a cell
			-- not read (and is now read): there the trail glides to the ground instead of jumping to it.
			if sp then
				local final, start, moved = fresh.strip, {}, false
				for i = 1, fresh.m do
					local old = Trail.BakedHeight(sp, from + i - 1 - first)
					start[i] = old or final[i]
					if old and abs(old - final[i]) > 0.05 then moved = true end
				end
				if moved then
					fresh.final, fresh.start, fresh.since, fresh.strip = final, start, now, {}
				end
			end
			sp, first, have = fresh, from, from + fresh.coverage - along
			sp.origin = from
			strip.path, strip.first = sp, first
		end
	end
	if sp and sp.since then
		local u = (now - sp.since) / STRIP_SETTLE
		if u >= 1 then
			sp.strip, sp.final, sp.start, sp.since = sp.final, nil, nil, nil
		else
			local w = 1 - u * u * (3 - 2 * u)
			local heights, final, start = sp.strip, sp.final, sp.start
			for i = 1, sp.m do heights[i] = final[i] + (start[i] - final[i]) * w end
		end
	end
	-- Enough of it to start the trail on; with less, the trail is the level one.
	if not sp or have < min(ahead + 2, reach) then return nil end
	sp.left = route.total - along
	return sp, along - first, off
end

---------------------------------------------------------------------------
-- A walk no way was found for
---------------------------------------------------------------------------

-- Where the walking router finds no way to the goal (a building or a floor
-- the maps cut off, a ledge, an island), the arrow points straight at it and
-- the route is that straight line: through a wall, off an edge, onto another
-- floor. It is no route, and the trail is drawn along it only as far as it
-- can be walked. Polestar_NavEngine.Sight, the check the arrow aims beside its
-- path by, says whether a player standing at one point at a height can walk
-- straight to another over the walking maps: true; false at a closed step (a
-- wall, an edge, a building's side), another floor, water or indoor ground;
-- nil where it cannot tell (a map tile not decoded, off the maps). It decodes
-- nothing and leaves the reader as it was, so it is asked without the gate
-- the surface reads go by. The line is tried every CLEAR_STEP yards out from
-- the player, at most every CLEAR_EVERY seconds, and where it ends is kept as
-- a place on the route: it stays put as the player walks up to it.
local CLEAR_EVERY = 0.25 -- seconds between checks
local CLEAR_STEP = 2     -- yards between the points tried
local clear = {}         -- of (the route), at (yards along it the walkable line ends; false: none within reach), tried

-- How many yards on from `along` the route (the straight line of a walk no
-- way was found for) can be walked by the player at (px, py), standing at
-- height z: 0 where the first step is closed, or with the maps there and the
-- floor under the player not known (a line through a place of several floors
-- is not drawn on a guess). nil where the maps say nothing against it within
-- `reach`, the trail's length, or cannot be asked (no walking maps here, a
-- tile not decoded and nothing found before): it is then drawn as any route.
function Terrain.Clear(route, c, px, py, z, along, reach, now)
	local Trail = NS.Trail
	local E = data(c)
	if not (E and type(E.Sight) == "function" and Trail and type(route) == "table" and route.c == c) then
		clear.of = nil
		return nil
	end
	if clear.of ~= route then clear.of, clear.at, clear.tried = route, nil, nil end
	if type(z) ~= "number" then
		clear.tried = nil
		return 0
	end
	if not clear.tried or now - clear.tried >= CLEAR_EVERY then
		clear.tried = now
		local last = min(reach, route.total - along)
		local d, far, known = 0, 0, true
		while d < last do
			d = min(d + CLEAR_STEP, last)
			local x, y = Trail.PointAt(route, along + d)
			local ok, can = pcall(E.Sight, c, px, py, z, x, y)
			if not ok or can == nil then known = false break end
			if not can then break end
			far = d
		end
		-- Not told: what was found before stands.
		if known then clear.at = far < last and along + far end
	end
	if not clear.at then return nil end
	return max(0, clear.at - along)
end

function Terrain.Reset() cache, cached, cacheMap, here, cand, strip, clear = {}, 0, nil, nil, nil, {}, {} end
function Terrain.Live() return here and here.allow and here.live or false end
