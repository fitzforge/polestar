-- Camera world-trail geometry, adapted from accepted ForeverSparkleTrail 0.4.8.
local ADDON, ns = ...
local NS = ns.WorldTrail
if not NS then return end -- Nav is optional when a module is loaded on its own.
local Trail = {}
NS.Trail = Trail

local floor, sqrt, sin, abs, pi = math.floor, math.sqrt, math.sin, math.abs, math.pi

-- Legs that jump instead of travel: nothing to sparkle along.
Trail.JUMP = { hearth = true, teleport = true, portal = true }

local function newPath(c, kind, current)
	return { c = c, kind = kind, current = current, xs = {}, ys = {}, cum = {}, n = 0, total = 0 }
end

local function add(path, x, y)
	local n = path.n
	if n > 0 then
		local dx, dy = x - path.xs[n], y - path.ys[n]
		local d = sqrt(dx * dx + dy * dy)
		if d < 0.01 then return end
		path.total = path.total + d
	end
	n = n + 1
	path.n = n
	path.xs[n], path.ys[n], path.cum[n] = x, y, path.total
end

-- Paths in travel order, one per leg and continent (a leg is split where it
-- changes continent). wholeRoute = false keeps only the leg being travelled.
-- A path keeps its leg's `unrouted`: a straight line where the walking router
-- found no way to the goal (Nav/Walk.lua), not a route to draw as one.
function Trail.BuildPaths(geometry, wholeRoute)
	local out = {}
	local legs = type(geometry) == "table" and type(geometry.legs) == "table" and geometry.legs or nil
	if not legs then return out end
	local anyCurrent = false
	for i = 1, #legs do
		if type(legs[i]) == "table" and legs[i].current then anyCurrent = true break end
	end
	for i = 1, #legs do
		local leg = legs[i]
		local isCurrent = type(leg) == "table" and (leg.current or (not anyCurrent and i == 1)) or false
		if type(leg) == "table" and type(leg.pts) == "table" and not Trail.JUMP[leg.kind]
			and (wholeRoute or isCurrent) then
			local path
			for _, p in ipairs(leg.pts) do
				local c, x, y
				if type(p) == "table" then c, x, y = p[1], p[2], p[3] end
				if c ~= nil and type(x) == "number" and type(y) == "number"
					and x == x and y == y and math.abs(x) < math.huge and math.abs(y) < math.huge then
					if not path or path.c ~= c then
						if path and path.n >= 2 then out[#out + 1] = path end
						path = newPath(c, leg.kind, isCurrent)
						path.unrouted = leg.unrouted == true or nil
					end
					add(path, x, y)
				end
			end
			if path and path.n >= 2 then out[#out + 1] = path end
		end
	end
	return out
end

-- Read-only adapter for Walk.WorldTrail's accepted, untrimmed snapshot.
-- Strip spacing is in original 2D yards, not smoothed or 3D path distance.
-- The producer sampled before XY quantization: this is approximate alignment.
local function finite(v)
	return type(v) == "number" and v == v and abs(v) < math.huge
end
function Trail.BakedPath(s)
	if type(s) ~= "table" or type(s.xs) ~= "table" or type(s.ys) ~= "table"
		or type(s.distances) ~= "table" or type(s.strip) ~= "table"
		or not finite(s.n) or s.n < 2 or s.n % 1 ~= 0
		or not finite(s.m) or s.m < 2 or s.m % 1 ~= 0
		or not finite(s.stripYd) or s.stripYd <= 0 then return nil end
	-- Validate once per snapshot, not once per sprite or paint. Missing values
	-- cannot become a fabricated continuous profile in HeightsAhead().
	if s.distances[1] ~= 0 then return nil end
	for i = 1, s.n do
		if not finite(s.xs[i]) or not finite(s.ys[i]) or not finite(s.distances[i])
			or (i > 1 and s.distances[i] < s.distances[i - 1]) then return nil end
	end
	for i = 1, s.m do if not finite(s.strip[i]) then return nil end end
	local total = s.distances[s.n]
	if total <= 0 then return nil end
	return { c = s.c, kind = "walk", current = true, xs = s.xs, ys = s.ys,
		cum = s.distances, n = s.n, total = total, strip = s.strip, m = s.m,
		stripYd = s.stripYd, coverage = math.min(total, (s.m - 1) * s.stripYd) }
end

function Trail.BakedHeight(path, along)
	if not path or not path.strip or type(along) ~= "number" or along ~= along
		or along < 0 or along > path.coverage then return nil end
	local u = along / path.stripYd
	local i = math.min(floor(u) + 1, path.m - 1)
	local a, b = path.strip[i], path.strip[i + 1]
	if type(a) ~= "number" or type(b) ~= "number" or a ~= a or b ~= b
		or abs(a) == math.huge or abs(b) == math.huge then return nil end
	return a + (b - a) * (u - (i - 1))
end

-- How far along the path (yards) the point nearest (x, y) is, and how far
-- from the path that point is; nil when the path is on another continent.
-- hint: yards along the path the point was last near; only the stretch around
-- it is searched (a long route is thousands of points), the whole path when
-- the point is not found near it.
local WINDOW = 60
local function segmentAt(cum, n, along)
	local lo, hi = 1, n
	while hi - lo > 1 do
		local mid = floor((lo + hi) / 2)
		if cum[mid] <= along then lo = mid else hi = mid end
	end
	return lo
end

function Trail.Nearest(path, c, x, y, hint)
	if not path or path.c ~= c or path.n < 2 then return nil end
	if hint then
		local i1 = segmentAt(path.cum, path.n, hint - WINDOW)
		local i2 = segmentAt(path.cum, path.n, hint + WINDOW)
		local along, d = Trail.NearestIn(path, x, y, i1, math.min(i2, path.n - 1))
		if along and d <= 30 then return along, d end
	end
	return Trail.NearestIn(path, x, y, 1, path.n - 1)
end

function Trail.NearestIn(path, x, y, from, to)
	local xs, ys, cum = path.xs, path.ys, path.cum
	local best, bestAlong = math.huge, 0
	for i = from, to do
		local ax, ay = xs[i], ys[i]
		local dx, dy = xs[i + 1] - ax, ys[i + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = len2 > 0 and ((x - ax) * dx + (y - ay) * dy) / len2 or 0
		if t < 0 then t = 0 elseif t > 1 then t = 1 end
		local qx, qy = ax + dx * t, ay + dy * t
		local d2 = (x - qx) * (x - qx) + (y - qy) * (y - qy)
		if d2 < best then
			best, bestAlong = d2, cum[i] + (cum[i + 1] - cum[i]) * t
		end
	end
	return bestAlong, sqrt(best)
end

-- Shared map/world sparkle arithmetic; raw geometry and nearest differ above.
local Sparkle = ns.RouteSparkle
Trail.PointAt, Trail.Emit = Sparkle.PointAt, Sparkle.Emit
Trail.Hash, Trail.Sparkle = Sparkle.Hash, Sparkle.Twinkle
local STYLE_KEYS = {
	sparkleIntensity = "intensity", sparkleDensity = "density", sparkleSubtlety = "subtlety",
	sparkleSize = "size", sparkleFlow = "speed", sparkleMax = "maxSparkles", sparkleColor = "color",
}
function Trail.Style(db)
	return Sparkle.Style(function(key)
		local field = STYLE_KEYS[key]
		if field then return db[field] end
		if key == "sparkleLater" then return false end
	end)
end

function Trail.DistanceFade(yards, length, amount)
	if not length or length <= 0 then return 1 end
	local u = yards / length
	if u < 0 then u = 0 elseif u > 1 then u = 1 end
	return 1 - (amount or 0) * u ^ 0.8
end

Trail.PIVOT = 1.8 -- yards above the feet the camera turns about
Trail.CAMERA_FLOOR = 0.3 -- yards above the feet the camera stays when the view is turned up
Trail.pivotInPlace = false -- the game's Smart Pivot setting, as the painter last read it

-- Pixels per unit of tan(angle) for a screen width x height: cameraFov is
-- read as the angle from corner to corner of a 16:9 screen, the view widening
-- with the screen. Measured on wowf 1.60.1 at 2560x1440 from a recording of
-- the game's marker in a turn of the view under mouselook (the character
-- turns with the camera, so the facing gives the turn): the marker crossed
-- the screen at 1,410 to 1,480 px for each unit of tan, by its places at rest
-- and by the whole turn, where 90 degrees from corner to corner give 1,469.
-- Read as the angle from side to side (1,280) the marker went a tenth
-- further than the view could have turned it.
function Trail.Focal(fov, height)
	local v = math.atan(math.tan(math.rad(fov) / 2) * 9 / math.sqrt(16 * 16 + 9 * 9))
	return height / 2 / math.tan(v)
end

function Trail.Camera(yaw, pitch, zoom, focal, width, height, pivot)
	local cy, sy, cp, sp = math.cos(yaw), math.sin(yaw), math.cos(pitch), math.sin(pitch)
	zoom = zoom and zoom > 0 and zoom or 0
	local fx, fy, fz = cp * cy, cp * sy, -sp
	pivot = pivot or Trail.PIVOT
	local x, y, z = -zoom * fx, -zoom * fy, pivot - zoom * fz
	-- Turned up, the boom behind the character would end under the ground, and
	-- the game keeps the camera above it (level ground taken; the ground is
	-- never looked at from underneath). With Smart Pivot the camera rests
	-- where its boom met the ground and turns up there; without, it is drawn in
	-- along the boom, still looking over the character.
	local drop = pivot - Trail.CAMERA_FLOOR
	if fz > 0 and zoom * fz > drop then
		local back = Trail.pivotInPlace and sqrt(zoom * zoom - drop * drop) or drop / fz * cp
		x, y, z = -back * cy, -back * sy, Trail.CAMERA_FLOOR
	end
	return {
		x = x, y = y, z = z,
		fx = fx, fy = fy, fz = fz,
		rx = sy, ry = -cy, rz = 0,
		ux = sp * cy, uy = sp * sy, uz = cp,
		focal = focal, w = width, h = height,
	}
end

-- Screen x, y (pixels from the bottom left) and depth (yards along the view) of
-- a point, or nil when it is behind or at the camera.
function Trail.Project(cam, x, y, z)
	local vx, vy, vz = x - cam.x, y - cam.y, (z or 0) - cam.z
	local depth = vx * cam.fx + vy * cam.fy + vz * cam.fz
	if depth < 0.5 then return nil end
	local right = vx * cam.rx + vy * cam.ry
	local up = vx * cam.ux + vy * cam.uy + vz * cam.uz
	return cam.w / 2 + right / depth * cam.focal, cam.h / 2 + up / depth * cam.focal, depth
end

-- The height at which the point above (x, y) shows on screen row sy, or nil
-- when no height in front of the camera does (the row's ray runs level with
-- the point, or meets its upright behind the camera).
function Trail.HeightAt(cam, x, y, sy)
	local vx, vy = x - cam.x, y - cam.y
	local t = (sy - cam.h / 2) / cam.focal
	local along = vx * cam.fx + vy * cam.fy
	local den = cam.uz - t * cam.fz
	if abs(den) < 1e-6 then return nil end
	local vz = (t * along - (vx * cam.ux + vy * cam.uy)) / den
	if along + vz * cam.fz < 0.5 then return nil end
	return vz + cam.z
end

-- Where the client puts the marker of a place it cannot show, and what that
-- says of the view's tilt. Measured on wowf 1.60.1 from a recording of the
-- marker's frame (a full turn at a tilt the client had saved, then tilting
-- down from it): the marker is pinned to a rectangle PIN_INSET inside the
-- screen, and its place round that rectangle goes evenly with the place's
-- bearing. With the view tilted down by `pitch` and the place `bearing` round
-- from straight ahead, to either side:
--   up to `pitch`: along the top edge, from its middle to its corner;
--   for the next quarter turn: down the side edge, corner to corner;
--   from there to straight behind: along the bottom edge, corner to middle.
-- So a marker on a side edge or the bottom edge gives the tilt, once the
-- bearing is known: over the recorded turn the rule gave 20.5 degrees where
-- the client had saved 19.7, and it followed the view down to 83. The top
-- edge's share was not in the recording and is not read. A view turned up
-- pins the marker another way (to the bottom, mostly its corners), which
-- gives no tilt but does say the view is turned up.
Trail.PIN_INSET = 15

-- The tilt (radians, down positive) that pins the marker dx, dy from the
-- screen's centre for a place `bearing` radians round to the right of straight
-- ahead (left negative), on a pin rectangle reaching hx and hy from the
-- centre. Or nil and why: "corner", "top", "ahead under the view" (a place in
-- front pinned at the bottom: the view is turned up), "other side", "behind"
-- (too near straight behind to tell), "free" (not on the rectangle).
function Trail.PinnedPitch(dx, dy, bearing, hx, hy)
	local a = math.deg(abs(bearing))
	local slack = 1.5
	local side, bottom, top = abs(dx) >= hx - slack, dy <= -hy + slack, dy >= hy - slack
	if side and (bottom or top) then return nil, "corner" end
	local right = bearing > 0
	local pitch
	if side then
		if a > 4 and a < 176 and (dx > 0) ~= right then return nil, "other side" end
		pitch = a - 45 + 45 * dy / hy
	elseif bottom then
		if a < 90 then return nil, "ahead under the view" end
		if 180 - a < 6 or abs(dx) < hx * 0.08 then return nil, "behind" end
		if (dx > 0) ~= right then return nil, "other side" end
		pitch = 90 - (180 - a) * hx / abs(dx)
	else
		return nil, top and "top" or "free"
	end
	-- A little outside what a view can be is the rule's own error; further out it does not apply.
	if pitch < -6 or pitch > 92 then return nil, side and "side" or "bottom" end
	if pitch < 0 then pitch = 0 elseif pitch > 88 then pitch = 88 end
	return math.rad(pitch), side and "side" or "bottom"
end

-- The bearing (radians to the right of straight ahead) of the place whose
-- marker is pinned dx, dy from the centre with the view tilted down by
-- `pitch`: the same rule the other way round, for a marker on a side or the
-- bottom edge. nil elsewhere.
function Trail.PinnedBearing(dx, dy, pitch, hx, hy)
	local p = math.deg(pitch)
	if p < 0 or p > 88 then return nil end
	local slack = 1.5
	local side, bottom, top = abs(dx) >= hx - slack, dy <= -hy + slack, dy >= hy - slack
	if side and (bottom or top) or top then return nil end
	local a
	if side then
		a = p + 45 - 45 * dy / hy
	elseif bottom then
		if abs(dx) < hx * 0.08 then return nil end
		a = 180 - (90 - p) * abs(dx) / hx
	else
		return nil
	end
	if a < 0 or a > 180 then return nil end
	return math.rad(dx > 0 and a or -a)
end

-- Yaw and pitch putting the point (gx, gy, gz) at screen (ax, ay), from a
-- starting guess; with pitchFixed only the yaw moves. gz defaults to 0. Returns yaw, pitch and
-- the miss in pixels, or nil when it cannot be solved.
function Trail.SolveCamera(gx, gy, ax, ay, zoom, focal, width, height, yaw, pitch, pitchFixed, gz)
	local h = 1e-4
	local function miss(a, b)
		local sx, sy = Trail.Project(Trail.Camera(a, b, zoom, focal, width, height), gx, gy, gz or 0)
		if not sx then return nil end
		return sx - ax, sy - ay
	end
	for _ = 1, 8 do
		local ex, ey = miss(yaw, pitch)
		if not ex then return nil end
		local ax1, ay1 = miss(yaw + h, pitch)
		if not ax1 then return nil end
		local j11, j21 = (ax1 - ex) / h, (ay1 - ey) / h
		local dyaw, dpitch
		if pitchFixed then
			if abs(j11) < 1e-6 then return nil end
			dyaw, dpitch = -ex / j11, 0
		else
			local bx1, by1 = miss(yaw, pitch + h)
			if not bx1 then return nil end
			local j12, j22 = (bx1 - ex) / h, (by1 - ey) / h
			local det = j11 * j22 - j12 * j21
			if abs(det) < 1e-9 then return nil end
			dyaw = (-ex * j22 + ey * j12) / det
			dpitch = (-ey * j11 + ex * j21) / det
		end
		-- Small steps: the far side of the circle also solves it, upside down.
		if dyaw > 0.5 then dyaw = 0.5 elseif dyaw < -0.5 then dyaw = -0.5 end
		if dpitch > 0.3 then dpitch = 0.3 elseif dpitch < -0.3 then dpitch = -0.3 end
		yaw, pitch = yaw + dyaw, pitch + dpitch
		if pitch > 1.45 then pitch = 1.45 elseif pitch < -1.2 then pitch = -1.2 end
		if abs(dyaw) < 1e-6 and abs(dpitch) < 1e-6 then break end
	end
	local ex, ey = miss(yaw, pitch)
	if not ex then return nil end
	return yaw, pitch, sqrt(ex * ex + (pitchFixed and 0 or ey * ey))
end


-- The path with its corners cut (Chaikin's, `rounds` times: each segment's
-- quarter points replace its ends), first and last points kept. Walking
-- routes step across grid cells; this takes the zigzag out.
function Trail.Smooth(path, rounds)
	if not path or path.n < 3 then return path end
	local xs, ys = {}, {}
	for i = 1, path.n do xs[i], ys[i] = path.xs[i], path.ys[i] end
	for _ = 1, rounds or 2 do
		local nx, ny = { xs[1] }, { ys[1] }
		for i = 1, #xs - 1 do
			local ax, ay, bx, by = xs[i], ys[i], xs[i + 1], ys[i + 1]
			nx[#nx + 1], ny[#ny + 1] = ax * 0.75 + bx * 0.25, ay * 0.75 + by * 0.25
			nx[#nx + 1], ny[#ny + 1] = ax * 0.25 + bx * 0.75, ay * 0.25 + by * 0.75
		end
		nx[#nx + 1], ny[#ny + 1] = xs[#xs], ys[#ys]
		xs, ys = nx, ny
	end
	local out = newPath(path.c, path.kind, path.current)
	out.unrouted = path.unrouted
	for i = 1, #xs do add(out, xs[i], ys[i]) end
	return out
end
