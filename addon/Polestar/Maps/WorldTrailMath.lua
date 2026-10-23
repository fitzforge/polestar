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
					end
					add(path, x, y)
				end
			end
			if path and path.n >= 2 then out[#out + 1] = path end
		end
	end
	return out
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

-- Pixels per unit of tan(angle) for a screen width x height: cameraFov is
-- read as the horizontal angle at 16:9, the view widening with the screen.
function Trail.Focal(fov, height)
	local v = math.atan(math.tan(math.rad(fov) / 2) * 9 / 16)
	return height / 2 / math.tan(v)
end

function Trail.Camera(yaw, pitch, zoom, focal, width, height, pivot)
	local cy, sy, cp, sp = math.cos(yaw), math.sin(yaw), math.cos(pitch), math.sin(pitch)
	zoom = zoom and zoom > 0 and zoom or 0
	local fx, fy, fz = cp * cy, cp * sy, -sp
	pivot = pivot or Trail.PIVOT
	return {
		x = -zoom * fx, y = -zoom * fy, z = pivot - zoom * fz,
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
	for i = 1, #xs do add(out, xs[i], ys[i]) end
	return out
end
