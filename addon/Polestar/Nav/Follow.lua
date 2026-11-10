-- Nav/Follow.lua: the arrow's path follower.
--
-- Given a path (points xs[i], ys[i], heights zs[i] (false where unknown) and
-- left[i], the yards from point i to the path's end) and the player's place,
-- it says how far along the path the player is and where the arrow points.
-- It knows nothing of where the path came from: today the walking engine's
-- searched path (Nav/Walk.lua), later any polyline a guide leg carries.
--
-- Progress is the player's projection onto the path: the nearest point on a
-- segment from the current one to WINDOW yards further along. A point the
-- player walks past to one side counts as passed, so approaching the path at
-- an angle or walking beside a road never holds the arrow on a node. Two
-- guards keep it honest:
--   - it never moves forward past a blocking point the player has not come
--     within REACH yards of: a point where the floor changes (a ramp, stairs,
--     a lift's landing) and every point after `stop` (the last point before a
--     chokepoint on a split walk: a gate, a door, a bridge end);
--   - a later segment takes over only when it is HYST yards nearer than the
--     current one, so the two sides of a hairpin don't swap back and forth.
--
-- The aim is the furthest point along the path ahead of the projection that
-- is within RADIUS yards of the player and AHEAD yards along the path, and
-- whose way there keeps every path point within PAD yards of the line from
-- the projection to it. It may fall between points, so it slides along the
-- path as the player moves instead of jumping from node to node. A road's
-- wiggles stay inside the corridor; a real corner (the path turning more than
-- TURN degrees away from the line to the aim, as at a street corner or a
-- switchback) stops it at the corner, cutting inside by CORNER_PAD at most,
-- and it comes round the corner as the player does. It never passes `stop`, nor a
-- point on another floor. When no path point ahead is within RADIUS (the
-- player has wandered off), it points back to the path LEAD yards ahead of
-- the projection, never at a point behind.
--
-- Joining the road: a path searched from where the player stands runs to the
-- nearest point of a road and turns along it (the router prices roads
-- cheaper), and that turn is a cost, not a place to go. With `join` (yards;
-- the caller passes it outdoors only), the first turn within `join` yards of
-- the path's start is not a corner: the arrow aims on along the road past it,
-- so the player merges at an angle. Later turns, `stop` and floor changes
-- still hold.
--
-- Beside the path in open ground (Fitz, 0.3.4, running up a hillside in
-- Tirisfal parallel to the path and 30-40 yd from it: the arrow pointed 90°
-- back to it while the target lay ahead; a path searched again from there
-- ran 40 yd straight across to the road first, and RADIUS held the aim on
-- that piece, so `join` could not cut it): with `sight` (the caller passes it
-- outdoors only, with the floor under the player known), a player more than
-- BODY and at most OPEN yards off the path, or within `join` yards of its
-- start, aims at the furthest point along it, up to SIGHT_AHEAD yards past the
-- projection, that sight(px, py, x, y, z)
-- says they can walk to in a straight line (the walking grid's line check,
-- Path.Sight: no wall, cliff, water, indoor ground or hostile town on the
-- way), never past `stop` nor onto another floor. The candidates go from the
-- furthest in, ever closer together (SIGHT_GAP, or a third of the way to the
-- last one tried), with the first point ahead last, so a check costs about ten
-- line reads at most and one in open ground; it is looked for again only
-- after the player moves SIGHT_MOVE yards. The aim may be a point, or the
-- one SIGHT_AHEAD along a long straight piece (it slides with the player).
-- Where no such point is in sight (a cliff, a river, a building's walls) the
-- aim is the corridor's, as above: tight. S.sighted says a point ahead is in
-- sight; the caller asks for no new path while it is true (Nav/Walk.lua's STRAY).
-- The aim never runs back along the path (0.3.5, the walk out of Goldshire on
-- the real maps): a point found in sight stays the aim until the player passes
-- it, a further one is found, or they have moved SIGHT_HOLD yards without
-- seeing it again (the walking grid closes a step at a lamp post or a fence
-- post between two looks), and within BODY yards of the path (on the road's
-- join) the corridor's aim wins whenever it lies further along than the one in
-- sight (there the corridor runs along the path itself; beside the path it is
-- not checked for walls, so the point in sight stands). A point held ahead
-- keeps the arrow until the player comes within SIGHT_NEAR (not BODY) yards
-- of the path, and nearer still stays the aim, not looked for again, while it
-- lies further along than the corridor's (0.3.6: a player following it back
-- toward the path crossed BODY back and forth, and the arrow flipped between
-- the two aims at every crossing).
--
--   Follow.Reset(S)                    a fresh path: S.idx = 2 (the first segment's end)
--   Follow.Step(xs, ys, zs, left, n, S, px, py, stop, join, sight) -> ax, ay | nil
--     the point to aim at; nil once the player is within REACH of the last
--     point (from there: straight at the goal). Sets, in S (the caller's table,
--     reused, so it is allocation-free):
--       S.idx     the end point of the segment the player projects onto
--       S.along   yards along the path from its start to the projection
--       S.left    yards along the path from the projection to its end
--       S.off     yards from the player to the projection (off the path)
--       S.sighted the aim is a point in sight beside the path (open ground)
--       S.aimAlong that point's yards along the path from its start (nil for
--                 any other aim): the caller's yards left go the way the
--                 arrow points, to it and then along the path

local ADDON, ns = ...
local Nav = ns.Nav

local sqrt, abs, huge = math.sqrt, math.abs, math.huge

local Follow = {}
Nav.follow = Follow

local REACH = 5        -- yards: a blocking point, or the last one, is reached
local WINDOW = 60      -- yards along the path the projection may look ahead
local HYST = 4         -- yards: a later segment must be this much nearer to take over
local RADIUS = 35      -- yards from the player the aim may lie
local AHEAD = 45       -- yards along the path the aim may lie past the projection
local PAD = 20         -- yards: path points this close to the line to the aim lie on the way (a road's wiggles)
local CORNER_PAD = 10  -- yards: how far the aim may cut inside a real corner
local TURN = math.cos(math.rad(60)) -- a piece of SHORT yards or more turning further from the line to the aim is a real corner (a wiggle's way back is less)
local BODY = 15        -- yards beside the path the player may walk with the arrow pointing along it, not back to it
local LEAD = 10        -- yards along the path past the projection: the aim when the path is out of RADIUS
local FLOOR_STEP = 6   -- yards above or below: another floor
local SHORT = 8        -- yards: pieces this short on both sides of a point are a road's zigzag, smoothed
local BISECT = 6       -- halvings when a corner cuts a segment short
local OPEN = 100       -- yards beside the path the player may run with the arrow aiming ahead by sight (open ground)
local SIGHT_AHEAD = 150 -- yards along the path past the projection the sight aim may lie
local SIGHT_GAP = 8    -- yards along the path between the closest sight candidates
local SIGHT_MOVE = 2   -- yards the player moves before the sight aim is looked for again
local SIGHT_HOLD = 12  -- yards the player may move with the point last seen in sight held while it is not seen again
local SIGHT_NEAR = BODY - 5 -- yards beside the path: a point held in sight stays the sight aim until the player comes this near

Follow.RADIUS, Follow.AHEAD, Follow.PAD, Follow.REACH, Follow.OPEN = RADIUS, AHEAD, PAD, REACH, OPEN

function Follow.Reset(S)
	S.idx, S.along, S.left, S.off, S.sighted, S.aimAlong = 2, 0, nil, nil, false, nil
	S.sightAt, S.sightX, S.sightY, S.heldX, S.heldY = nil, nil, nil, nil, nil
end

local function floorChange(zs, i)
	if i <= 1 then return false end
	local za, zb = zs[i - 1], zs[i]
	return za and zb and abs(zb - za) > FLOOR_STEP or false
end

-- Point i stops the projection from moving past it until it is reached.
local function blocked(xs, ys, zs, i, stop, px, py)
	if not ((stop and i > stop) or floorChange(zs, i)) then return false end
	local dx, dy = xs[i] - px, ys[i] - py
	return dx * dx + dy * dy > REACH * REACH
end

-- Every path point from a to b within pad of the line (sx, sy) -> (qx, qy),
-- and not behind its start or past its end.
local function inCorridor(xs, ys, a, b, sx, sy, qx, qy, pad)
	local lx, ly = qx - sx, qy - sy
	local len = sqrt(lx * lx + ly * ly)
	if len == 0 then return true end
	for m = a, b do
		local mx, my = xs[m] - sx, ys[m] - sy
		local along, across = (mx * lx + my * ly) / len, (mx * ly - my * lx) / len
		if along < -pad or along > len + pad or abs(across) > pad then return false end
	end
	return true
end

-- The point `at` yards along the path from its start, on segment a or later.
local function pointAlong(xs, ys, left, a, n, at)
	local start = left[1]
	for j = a, n - 1 do
		local a1 = start - left[j + 1]
		if a1 >= at then
			local a0 = start - left[j]
			local t = a1 > a0 and (at - a0) / (a1 - a0) or 1
			return xs[j] + (xs[j + 1] - xs[j]) * t, ys[j] + (ys[j + 1] - ys[j]) * t
		end
	end
	return xs[n], ys[n]
end

-- The furthest point along the path past the projection (`along` yards in,
-- the next point idx) up to SIGHT_AHEAD on, never past point `limit` nor onto
-- another floor than zRef, that sight says the player at (px, py) can walk to
-- in a straight line: its yards along the path, or false. The candidates run
-- from the furthest in, each at least SIGHT_GAP (or a third of the way to the
-- last one tried) nearer than the last, and the first point ahead last.
local function inSight(xs, ys, zs, left, idx, along, limit, zRef, px, py, sight)
	local start = left[1]
	local cap = along + SIGHT_AHEAD
	local last, capped = idx - 1, false
	for j = idx, limit do
		local zj = zs[j]
		if zRef and zj and abs(zj - zRef) > FLOOR_STEP then break end
		if start - left[j] > cap then capped = true break end
		last = j
	end
	local tried -- yards along of the last candidate tried (nil: none yet)
	if capped then
		-- A long piece runs on past the cap: the point on it SIGHT_AHEAD along.
		local a, b = last, last + 1
		local a0, len = start - left[a], left[a] - left[b]
		local t = len > 0 and (cap - a0) / len or 0
		local za, zb = zs[a], zs[b]
		if sight(px, py, xs[a] + (xs[b] - xs[a]) * t, ys[a] + (ys[b] - ys[a]) * t, za and zb and za + (zb - za) * t or false) then
			return cap
		end
		tried = cap
	end
	for j = last, idx, -1 do
		local aj = start - left[j]
		local gap = tried and (tried - along) / 3 or 0
		if gap < SIGHT_GAP then gap = SIGHT_GAP end
		if aj > along and (not tried or j == idx or tried - aj >= gap) then
			if sight(px, py, xs[j], ys[j], zs[j]) then return aj end
			tried = aj
		end
	end
	return false
end

function Follow.Step(xs, ys, zs, left, n, S, px, py, stop, join, sight)
	S.sighted, S.aimAlong = false, nil
	if n == 0 then return nil end
	if n == 1 then
		local dx, dy = xs[1] - px, ys[1] - py
		local d = sqrt(dx * dx + dy * dy)
		S.along, S.left, S.off = 0, left[1], d
		if d <= REACH then S.idx = 2 return nil end
		S.idx = 1
		return xs[1], ys[1]
	end
	local idx = S.idx
	if idx < 2 then idx = 2 end
	if idx > n then return nil end

	-- Projection: the nearest segment from the current one to WINDOW yards on.
	local start = left[1]
	local limitAlong = (S.along or 0) + WINDOW
	local best, bestD, bestT = idx - 1, nil, 0
	for a = idx - 1, n - 1 do
		if a > idx - 1 then
			if start - left[a] > limitAlong then break end
			if blocked(xs, ys, zs, a, stop, px, py) then break end
		end
		local ax, ay = xs[a], ys[a]
		local dx, dy = xs[a + 1] - ax, ys[a + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = 0
		if len2 > 0 then
			t = ((px - ax) * dx + (py - ay) * dy) / len2
			if t < 0 then t = 0 elseif t > 1 then t = 1 end
		end
		local ex, ey = ax + dx * t - px, ay + dy * t - py
		local d = sqrt(ex * ex + ey * ey)
		-- The next segment on takes over as soon as it is nearer; any later one
		-- (the far side of a hairpin) must be HYST yards nearer.
		local need = a == best + 1 and 0 or HYST
		if bestD == nil or d + need < bestD then
			best, bestD, bestT = a, d, t
		end
	end
	local a = best
	idx = a + 1
	local ax, ay = xs[a], ys[a]
	local segLen = left[a] - left[a + 1] -- the segment's own length (left[i] = left[i + 1] + it)
	local p0x, p0y = ax + (xs[a + 1] - ax) * bestT, ay + (ys[a + 1] - ay) * bestT
	S.idx = idx
	S.along = (start - left[a]) + bestT * segLen
	S.left = left[a] - bestT * segLen
	S.off = bestD

	if idx == n then
		local dx, dy = xs[n] - px, ys[n] - py
		if dx * dx + dy * dy <= REACH * REACH then
			S.idx = n + 1
			return nil
		end
	end

	-- Aim: slide along the path from the projection.
	local limit = n
	if stop and stop < limit then limit = stop end
	local zRef = zs[idx]
	-- Beside the path in open ground, or on a fresh path's way onto the road:
	-- the furthest point ahead in sight (sat: its yards along the path), held
	-- while it is not seen again for SIGHT_HOLD yards. A point held ahead keeps
	-- this until the player comes within SIGHT_NEAR of the path, not BODY, and
	-- nearer still it stays the aim, not looked for again, while it lies further
	-- along than the corridor's (below): a player following it back toward the
	-- path no longer flips the arrow between it and the corridor's aim at every
	-- yard across BODY.
	local sat
	local holding = S.sightAt and S.sightAt > S.along or false -- (sightAt is false when the last look found none)
	if sight and bestD <= OPEN and (bestD > BODY or (holding and bestD > SIGHT_NEAR) or (join and S.along <= join)) then
		local at = S.sightAt
		local mx, my = px - (S.sightX or huge), py - (S.sightY or huge)
		if mx * mx + my * my >= SIGHT_MOVE * SIGHT_MOVE or (at and at <= S.along) then
			local found = inSight(xs, ys, zs, left, idx, S.along, limit, zRef, px, py, sight)
			S.sightX, S.sightY = px, py
			local hx, hy = px - (S.heldX or huge), py - (S.heldY or huge)
			local held = at and at > S.along and hx * hx + hy * hy < SIGHT_HOLD * SIGHT_HOLD
			if found and not (held and found < at) then
				at, S.heldX, S.heldY = found, px, py
			elseif not held then
				at = found
				if found then S.heldX, S.heldY = px, py end
			end
			S.sightAt = at
		end
		if at and at > S.along then sat = at end
	elseif sight and holding and bestD <= SIGHT_NEAR then
		sat = S.sightAt
	else
		S.sightAt = nil
	end
	S.sighted = sat ~= nil
	local r2 = RADIUS * RADIUS
	local sx, sy, done = p0x, p0y, 0
	local qx, qy, qAlong -- the corridor's aim and its yards along the path past the projection
	local open = false -- the aim stopped mid-path at RADIUS or AHEAD (not at a corner, a floor change or the end)
	local from = idx    -- the first path point the corridor holds to (past a road's join, the points after it)
	local joined = false
	for j = idx, limit do
		local zj = zs[j]
		if zRef and zj and abs(zj - zRef) > FLOOR_STEP then break end
		-- Where the path's points are close together (a road's zigzag, pieces
		-- of SHORT yards or less on both sides), the aim slides along the path
		-- smoothed over each point's neighbours (1-2-1), so the side-to-side
		-- offsets cancel out. The last point it may reach (the goal's end,
		-- `stop`) and the corners of a sparse path stay where they are.
		local ex, ey = xs[j], ys[j]
		if j > 1 and j < limit and left[j - 1] - left[j] <= SHORT and left[j] - left[j + 1] <= SHORT then
			ex = (xs[j - 1] + 2 * ex + xs[j + 1]) * 0.25
			ey = (ys[j - 1] + 2 * ey + ys[j + 1]) * 0.25
		end
		local dx, dy = ex - sx, ey - sy
		local L = sqrt(dx * dx + dy * dy)
		if L > 0 then
			-- Furthest u in [0, 1] with the point inside RADIUS and within AHEAD along.
			local fx, fy = sx - px, sy - py
			local A = L * L
			local B = 2 * (fx * dx + fy * dy)
			local C = fx * fx + fy * fy - r2
			local disc = B * B - 4 * A * C
			if C > 0 or disc < 0 then break end -- this piece starts outside RADIUS
			local u = (-B + sqrt(disc)) / (2 * A)
			if u > 1 then u = 1 end
			local budget = (AHEAD - done) / L
			if budget < u then u = budget end
			if u <= 0 then break end
			local cx, cy = sx + dx * u, sy + dy * u
			local corner = j > idx and not inCorridor(xs, ys, from, j - 1, p0x, p0y, cx, cy, PAD)
			if not corner and j > idx and L >= SHORT then
				-- Within PAD, but the path itself turns away from the line to the aim:
				-- a corner or a switchback, not a wiggle.
				local ax2, ay2 = cx - p0x, cy - p0y
				local la = sqrt(ax2 * ax2 + ay2 * ay2)
				corner = la > 0 and (ax2 * dx + ay2 * dy) / (la * L) < TURN
			end
			if corner and join and not joined and j - 1 >= idx and start - left[j - 1] <= join then
				-- The first turn near the path's start: joining the road, cut freely.
				corner, joined, from = false, true, j
			end
			if corner then
				-- A corner: the furthest u whose line cuts inside it by CORNER_PAD at most.
				local lo, hi = 0, u
				for _ = 1, BISECT do
					local mid = (lo + hi) * 0.5
					if inCorridor(xs, ys, from, j - 1, p0x, p0y, sx + dx * mid, sy + dy * mid, CORNER_PAD) then lo = mid else hi = mid end
				end
				if lo > 0 then qx, qy, qAlong = sx + dx * lo, sy + dy * lo, done + L * lo end
				break
			end
			qx, qy, qAlong = cx, cy, done + L * u
			if u < 1 then open = true break end
			done = done + L
		end
		sx, sy = ex, ey
	end
	-- The point in sight beside the path; within BODY of it, only when it lies
	-- further along than the corridor's aim.
	if sat and (bestD > BODY or not qx or sat > S.along + qAlong) then
		S.aimAlong = sat
		return pointAlong(xs, ys, left, a, n, sat)
	end
	if qx then
		-- The body: walking beside the path within BODY yards, the arrow points
		-- along it from where the player is (the aim carried sideways by the
		-- player's offset) instead of pulling back to the line. At a corner, a
		-- floor change, `stop` or the end, it points at the path itself.
		local off = S.off
		if open and not joined and off > 0 and off <= BODY then return qx + (px - p0x), qy + (py - p0y) end
		return qx, qy
	end

	-- Out of RADIUS: back to the path, LEAD yards ahead of the projection.
	local bx, by = xs[idx], ys[idx]
	local dx, dy = bx - p0x, by - p0y
	local L = sqrt(dx * dx + dy * dy)
	if L > LEAD then return p0x + dx * LEAD / L, p0y + dy * LEAD / L end
	return bx, by
end
