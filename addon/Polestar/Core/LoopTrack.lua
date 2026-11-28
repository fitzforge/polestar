-- A farming loop as one closed track the arrow runs round (Polestar 0.4.4;
-- docs/GUIDE_FORMAT.md, "Farming loops"). World coordinates only: no game
-- calls, nothing stored outside the track and the caller's state.
--
--   LoopTrack.Build(c, stops) -> track | nil
--     stops = { { wx, wy, x, y }, ... }: the loop's points in order, in world yards on continent c and in percent
--     of the loop's map. The track runs stop 1, 2, ... n and back to 1, cut into nodes at most STEP yards apart:
--     track = { c, n, wx = {}, wy = {}, x = {}, y = {}, s = {} (yards from node 1 along the track), lap (yards a
--     round), stops (count), stopNode = { [i] = node of stop i } }. Nil with fewer than two distinct stops.
--   LoopTrack.Place(track, px, py, last) -> s, d
--     the player's place on the track: s, the yards from node 1 to the nearest point of it, and d, the yards to
--     that point. With `last` (the place found before) the stretch from BACK yards behind it to FWD ahead is
--     searched first, so where the track comes near itself (two sides of a valley, a crossing) the player keeps
--     to the side they walk; only when that stretch is more than NEAR yards off is the whole track searched (the
--     player left it, or went elsewhere).
--   LoopTrack.Ahead(track, s, yards) -> node: the first node at least `yards` (at most half the lap) along from
--     s, round the end of the lap to the start (the arrow's aim: always a short way ahead along the track, lap
--     after lap).
--   LoopTrack.NextStop(track, s, pass) -> node: the node of the first stop more than `pass` yards along from s
--     (the plain waypoint, for an arrow that follows no track: TomTom's, or none with the travel planner off).
--
-- One fixed direction: the stops' order. Off the track the same rules lead back to the nearest point of it,
-- a short way ahead.

local ADDON, ns = ...
local LoopTrack = {}
ns.LoopTrack = LoopTrack

local sqrt, ceil, max, min = math.sqrt, math.ceil, math.max, math.min

LoopTrack.STEP = 20 -- yards between nodes at most
LoopTrack.BACK = 30 -- yards behind the last place searched first
LoopTrack.FWD = 150 -- yards ahead of it
LoopTrack.NEAR = 40 -- yards: past this from that stretch, the whole track is searched

function LoopTrack.Build(c, stops)
	local k = stops and #stops or 0
	if k < 2 then return nil end
	local t = { c = c, n = 0, wx = {}, wy = {}, x = {}, y = {}, s = {}, lap = 0, stops = k, stopNode = {} }
	local n, s = 0, 0
	for i = 1, k do
		local a, b = stops[i], stops[i % k + 1]
		local dx, dy = b.wx - a.wx, b.wy - a.wy
		local len = sqrt(dx * dx + dy * dy)
		local m = max(1, ceil(len / LoopTrack.STEP))
		t.stopNode[i] = n + 1
		for j = 0, m - 1 do
			local f = j / m
			n = n + 1
			t.wx[n], t.wy[n] = a.wx + dx * f, a.wy + dy * f
			t.x[n], t.y[n] = a.x + (b.x - a.x) * f, a.y + (b.y - a.y) * f
			t.s[n] = s + len * f
		end
		s = s + len
	end
	if s <= 0 then return nil end
	t.n, t.lap = n, s
	return t
end

-- Yards from a to b going forward round the lap.
local function forward(t, a, b)
	local d = b - a
	if d < 0 then d = d + t.lap end
	return d
end

-- The nearest point of segment i (node i to the next) to (px, py): its place along the track and its distance.
local function onSegment(t, i, px, py)
	local j = i % t.n + 1
	local ax, ay = t.wx[i], t.wy[i]
	local dx, dy = t.wx[j] - ax, t.wy[j] - ay
	local l2 = dx * dx + dy * dy
	local f = l2 > 0 and max(0, min(1, ((px - ax) * dx + (py - ay) * dy) / l2)) or 0
	local nx, ny = ax + dx * f, ay + dy * f
	local s = t.s[i] + f * sqrt(l2)
	if s >= t.lap then s = s - t.lap end
	return s, sqrt((px - nx) ^ 2 + (py - ny) ^ 2)
end

function LoopTrack.Place(t, px, py, last)
	local bestS, bestD
	if last then
		for i = 1, t.n do
			local a = forward(t, last, t.s[i])
			-- The segment starts within FWD ahead, or ends within BACK behind.
			local seg = (t.s[i % t.n + 1] - t.s[i]) % t.lap
			if a <= LoopTrack.FWD or a + seg >= t.lap - LoopTrack.BACK then
				local s, d = onSegment(t, i, px, py)
				if not bestD or d < bestD then bestS, bestD = s, d end
			end
		end
		if bestD and bestD <= LoopTrack.NEAR then return bestS, bestD end
	end
	bestS, bestD = nil, nil
	for i = 1, t.n do
		local s, d = onSegment(t, i, px, py)
		if not bestD or d < bestD then bestS, bestD = s, d end
	end
	return bestS, bestD
end

function LoopTrack.Ahead(t, s, yards)
	yards = min(yards, t.lap / 2)
	local best, bestA
	for i = 1, t.n do
		local a = forward(t, s, t.s[i])
		if a >= yards and (not bestA or a < bestA) then best, bestA = i, a end
	end
	return best or 1
end

function LoopTrack.NextStop(t, s, pass)
	local best, bestA
	for i = 1, t.stops do
		local node = t.stopNode[i]
		local a = forward(t, s, t.s[node])
		if a > pass and (not bestA or a < bestA) then best, bestA = node, a end
	end
	return best or t.stopNode[1]
end
