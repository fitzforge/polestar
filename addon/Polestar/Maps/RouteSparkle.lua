-- Route lines as sparkles (docs/ARCHITECTURE.md, "Maps"): the route's draw
-- paths measured in yards, sparkles placed along them and each sparkle's
-- twinkle. The other line style (nav.lineStyle "sparkle") to RouteStrokes'
-- breadcrumbs; Maps/RouteLines.lua paints both. Nothing here touches a frame
-- or the client, so tests run it as plain Lua.
--
-- Ported from Forever Sparkle Trail (Trail.lua, 0.1.1), written for Polestar's
-- route on 2026-10-17: loot-gold glints drifting toward the goal, spaced
-- evenly on screen at any zoom, each with its own steady twinkle.
--
--   Sparkle.Paths(drawPaths, later)          measured paths, split by continent
--   Sparkle.Nearest(path, c, wx, wy)          yards along, yards off
--   Sparkle.Emit(path, from, spacing, phase, limit, fn, lo, hi)
--   Sparkle.Spans(path, xs, ys, x1, x2, y1, y2, out) the stretches that can show
--   Sparkle.Style(settings)                   the settings in pixels and seconds
--   Sparkle.Twinkle(k, t, style, fade)        one sparkle's alpha, scale, rotation, side
--   Sparkle.OnFace(x, y, square, inset)       inside the minimap's face

local ADDON, ns = ...

local floor, ceil, sqrt, sin, abs, pi = math.floor, math.ceil, math.sqrt, math.sin, math.abs, math.pi

local Sparkle = {}
ns.RouteSparkle = Sparkle

-- The settings and their ranges (nav.sparkle*; the Route lines page, Maps/RouteOptions.lua, shows them).
Sparkle.DEFAULTS = {
	sparkleIntensity = 0.75, sparkleDensity = 5, sparkleSubtlety = 0.35, sparkleSize = 14,
	sparkleFlow = 0.5, sparkleMax = 140, sparkleColor = "gold", sparkleLater = false,
}
Sparkle.LIMITS = {
	sparkleIntensity = { 0, 1 }, sparkleDensity = { 1, 10 }, sparkleSubtlety = { 0, 1 },
	sparkleSize = { 6, 28 }, sparkleFlow = { 0, 1 }, sparkleMax = { 10, 400 },
}
Sparkle.PRESETS = {
	subtle = { sparkleIntensity = 0.45, sparkleDensity = 3, sparkleSubtlety = 0.8, sparkleSize = 11, sparkleFlow = 0.25 },
	default = { sparkleIntensity = 0.75, sparkleDensity = 5, sparkleSubtlety = 0.35, sparkleSize = 14, sparkleFlow = 0.5 },
	dazzling = { sparkleIntensity = 1, sparkleDensity = 8, sparkleSubtlety = 0, sparkleSize = 18, sparkleFlow = 0.8 },
}
-- Loot gold first: the colour of the game's own loot sparkle. "route" takes
-- each leg's colour from the theme, as the dots do.
Sparkle.COLORS = {
	gold = { 1, 0.84, 0.38 }, arcane = { 0.55, 0.75, 1 }, fel = { 0.55, 1, 0.45 },
	rose = { 1, 0.55, 0.75 }, white = { 1, 1, 1 },
}

---------------------------------------------------------------------------
-- Paths: a draw path's points (Strokes.Path: c, x = wx north, y = wy west)
-- as runs on one continent, each with its length so far at every point.
---------------------------------------------------------------------------

local function newRun(c, src)
	return { c = c, kind = src.kind, later = src.later, xs = {}, ys = {}, cum = {}, n = 0, total = 0 }
end

local function add(run, x, y)
	local n = run.n
	if n > 0 then
		local dx, dy = x - run.xs[n], y - run.ys[n]
		local d = sqrt(dx * dx + dy * dy)
		if d < 0.01 then return end
		run.total = run.total + d
	end
	n = n + 1
	run.n = n
	run.xs[n], run.ys[n], run.cum[n] = x, y, run.total
end

-- Runs in travel order; `later` keeps the legs after the current one too.
-- Built once per route change.
function Sparkle.Paths(drawPaths, later)
	local out = {}
	for _, src in ipairs(drawPaths or {}) do
		if later or not src.later then
			local run
			for i = 1, src.n do
				local c = src.c[i]
				if not run or run.c ~= c then
					if run and run.n >= 2 then out[#out + 1] = run end
					run = newRun(c, src)
				end
				add(run, src.x[i], src.y[i])
			end
			if run and run.n >= 2 then out[#out + 1] = run end
		end
	end
	return out
end

-- How far along the run (yards) the point nearest (wx, wy) is, and how far
-- off the run it is; nil on another continent.
function Sparkle.Nearest(run, c, wx, wy)
	if not run or run.c ~= c or run.n < 2 then return nil end
	local xs, ys, cum = run.xs, run.ys, run.cum
	local best, along = math.huge, 0
	for i = 1, run.n - 1 do
		local ax, ay = xs[i], ys[i]
		local dx, dy = xs[i + 1] - ax, ys[i + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = len2 > 0 and ((wx - ax) * dx + (wy - ay) * dy) / len2 or 0
		if t < 0 then t = 0 elseif t > 1 then t = 1 end
		local qx, qy = ax + dx * t, ay + dy * t
		local d2 = (wx - qx) * (wx - qx) + (wy - qy) * (wy - qy)
		if d2 < best then best, along = d2, cum[i] + (cum[i + 1] - cum[i]) * t end
	end
	return along, sqrt(best)
end

-- The point `along` yards into the run, with its segment's unit normal.
function Sparkle.PointAt(run, along)
	local cum = run.cum
	if along <= 0 then along = 0 elseif along >= run.total then along = run.total end
	local lo, hi = 1, run.n
	while hi - lo > 1 do
		local mid = floor((lo + hi) / 2)
		if cum[mid] <= along then lo = mid else hi = mid end
	end
	local ax, ay, bx, by = run.xs[lo], run.ys[lo], run.xs[hi], run.ys[hi]
	local seg = cum[hi] - cum[lo]
	local t = seg > 0 and (along - cum[lo]) / seg or 0
	local dx, dy = bx - ax, by - ay
	local len = sqrt(dx * dx + dy * dy)
	local nx, ny = 0, 0
	if len > 0 then nx, ny = -dy / len, dx / len end
	return ax + dx * t, ay + dy * t, nx, ny
end

-- Sparkle k sits (k + phase) * spacing yards along the run. phase only grows
-- while the trail flows, so a sparkle keeps its number, and its twinkle, as
-- it drifts toward the goal. From `from` yards on, at most `limit` of them:
-- fn(wx, wy, k, nx, ny, fade), fade 0..1 easing in at the start and out at
-- the run's end; fn returns false to stop. lo..hi (yards along, optional)
-- keeps to one stretch of the run (Sparkle.Spans): the same sparkles, with
-- the same numbers and fades, as the whole run has there. -> the number emitted
function Sparkle.Emit(run, from, spacing, phase, limit, fn, lo, hi)
	if not run or run.n < 2 or not spacing or spacing <= 0 or limit <= 0 then return 0 end
	from = from or 0
	local total = run.total
	local stop = hi and hi < total and hi or total
	local k = ceil((lo and lo > from and lo or from) / spacing - phase)
	local count = 0
	while count < limit do
		local along = (k + phase) * spacing
		if along > stop then break end
		local fade = 1
		local head = (along - from) / spacing
		if head < 1 then fade = head end
		local tail = (total - along) / spacing
		if tail < 1 and tail < fade then fade = tail end
		if fade > 0 then
			local x, y, nx, ny = Sparkle.PointAt(run, along)
			count = count + 1
			if fn(x, y, k, nx, ny, fade) == false then break end
		end
		k = k + 1
	end
	return count
end

-- The stretches of a run whose segments reach into the box x1..x2, y1..y2,
-- with the run's points at xs[i], ys[i]: the run's own yards, or the points
-- projected onto a map (nil where they can't be). Only there can a sparkle
-- show, so a draw emits only those (a long route mostly lies off the
-- minimap's face and off a zone map). out gets yards along as pairs
-- lo1, hi1, lo2, hi2, ..., touching segments merged. -> the number of pairs
function Sparkle.Spans(run, xs, ys, x1, x2, y1, y2, out)
	local cum, n, open = run.cum, 0, false
	for i = 1, run.n - 1 do
		local ax, ay, bx, by = xs[i], ys[i], xs[i + 1], ys[i + 1]
		if ax and ay and bx and by and not ((ax < x1 and bx < x1) or (ax > x2 and bx > x2)
			or (ay < y1 and by < y1) or (ay > y2 and by > y2)) then
			if open then
				out[n * 2] = cum[i + 1]
			else
				n, open = n + 1, true
				out[n * 2 - 1], out[n * 2] = cum[i], cum[i + 1]
			end
		else
			open = false
		end
	end
	return n
end

---------------------------------------------------------------------------
-- The look
---------------------------------------------------------------------------

-- A steady pseudo-random 0..1 for a sparkle number and a salt.
function Sparkle.Hash(k, salt)
	local v = sin(k * 12.9898 + (salt or 0) * 78.233) * 43758.5453
	return v - floor(v)
end

local function clamped(get, key)
	local v = get(key)
	local d = Sparkle.DEFAULTS[key]
	if type(v) ~= type(d) then v = d end
	local range = Sparkle.LIMITS[key]
	if range then
		if v < range[1] then v = range[1] elseif v > range[2] then v = range[2] end
	end
	return v
end

-- What the settings mean on screen (pixels, seconds). get(key) reads a
-- nav.* setting; values out of range (a hand edit) are brought into it.
function Sparkle.Style(get)
	local i, s = clamped(get, "sparkleIntensity"), clamped(get, "sparkleSubtlety")
	local density = floor(clamped(get, "sparkleDensity") + 0.5)
	local color = clamped(get, "sparkleColor")
	return {
		spacing = 36 - (density - 1) * 3,                     -- px between sparkles: 36 .. 9
		size = clamped(get, "sparkleSize") * (1 - 0.45 * s), -- px
		alpha = i * (1 - 0.45 * s),
		halo = i * (1 - s) * 0.6,                             -- the soft glow under each star
		twinkle = 0.85 - 0.6 * s,                             -- how deep a sparkle fades between flashes
		rate = 2.6 - 1.4 * s,                                 -- twinkles a second, roughly
		flow = clamped(get, "sparkleFlow") * 0.9 * (1 - 0.5 * s), -- spacings a second toward the goal
		jitter = 0.45 * (1 - s),                              -- of a sparkle's size, to either side
		spin = 0.5 * (1 - s),                                 -- radians a second
		max = floor(clamped(get, "sparkleMax") + 0.5),
		color = Sparkle.COLORS[color] or (color ~= "route" and Sparkle.COLORS.gold) or nil,
		later = clamped(get, "sparkleLater"),
	}
end

-- One sparkle's look at time t: alpha (0..1), size scale, rotation and its
-- offset to the side (-1..1 of style.jitter * size).
function Sparkle.Twinkle(k, t, style, fade)
	local h1, h2, h3, h4 = Sparkle.Hash(k, 1), Sparkle.Hash(k, 2), Sparkle.Hash(k, 3), Sparkle.Hash(k, 4)
	local wave = 0.5 + 0.5 * sin(t * style.rate * (0.7 + 0.6 * h2) * 2 + h1 * 2 * pi)
	-- A sharp flash at the wave's crest, like a glint catching the light.
	local glint = wave * wave * wave
	local alpha = style.alpha * (1 - style.twinkle * (1 - glint)) * (fade or 1)
	local scale = 0.75 + 0.45 * glint
	local rotation = h3 * pi * 0.5 + t * style.spin * (h2 < 0.5 and -1 or 1)
	return alpha, scale, rotation, h4 * 2 - 1
end

-- A point on the minimap's face (-1..1, Strokes.Project) within `inset` of
-- its round or square edge.
function Sparkle.OnFace(x, y, square, inset)
	inset = inset or 1
	if square then return abs(x) <= inset and abs(y) <= inset end
	return x * x + y * y <= inset * inset
end
