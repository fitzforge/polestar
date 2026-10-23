-- Route lines as geometry: paths and a view in, strokes out (docs/ARCHITECTURE.md,
-- "Maps"). Nothing here touches a frame or the client, so the painters
-- (Maps/RouteLines.lua: the world map's pin and the minimap's frame) only copy
-- strokes onto pooled lines, and tests run it as plain Lua.
--
-- Ported from Shortest Path Forever (UI/Strokes.lua and UI/FlightLines.lua,
-- v1.15.0) by Cillian Berragan, GPL-3.0-or-later, used with his permission
-- (2026-10-15): the stroke buffer, segment clipping, breadcrumbs spaced evenly
-- across a walk's bends, the gap they leave at each stop's mark, later legs
-- receding, the corner cutting that rounds a flight's track and the bound on
-- every painter's pool. Adapted to Polestar's route legs ({ c, wx, wy } world
-- points), its map projection and its pins.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
-- A stroke is a solid line with a slim dark outline, so it reads on parchment
-- and minimap alike. Walks are round breadcrumbs: each a dot-textured line one
-- diameter long over a slightly larger dark dot, spaced evenly along the walk.
--
--   Strokes.New(limit)                     a buffer of at most `limit` strokes
--   Strokes.Path(kind, pts, later, tracks) a leg as a draw path (once per route change)
--   Strokes.Map(buffer, paths, view)       the paths on the world map at this view
--   Strokes.Minimap(buffer, paths, view)   the paths on the minimap -> goal mark x, y or nil
--   Strokes.Project(...)                   a world point on the minimap's face

local ADDON, ns = ...

local sqrt, ceil, min, max, abs, cos, sin = math.sqrt, math.ceil, math.min, math.max, math.abs, math.cos, math.sin

local Strokes = {}
ns.RouteStrokes = Strokes

-- Sizes in screen pixels.
local THICKNESS, DOT, RIM, SPACING = 2, 4, 1, 9
-- Continent maps show a whole route at a fraction of a zone's scale, so their dots are smaller.
local SMALL_DOT, SMALL_SPACING = 3, 7
local UNDER_THICKNESS = THICKNESS + 2
-- Every leg past the current one recedes, so the way ahead reads first.
local LATER_ALPHA = 0.4
-- Breadcrumbs stop short of each stop's mark: a dot is left out when its rim
-- would come within STOP_GAP pixels of the mark.
local STOP_GAP = 2
-- Media/Nav/pin-fill's disc covers 42 of its 64 pixels: a dot's quad is this much wider than the dot.
local DOT_ART = 64 / 42
-- Client regions cannot be destroyed: every buffer, and so every painter's pool, is bounded.
local LIMIT = 4096
-- A sea crossing with only its two docks bows this share of its length out of the straight line.
local BOW = 0.2
local CURVE_STEPS = 12

Strokes.THICKNESS, Strokes.DOT, Strokes.RIM, Strokes.SPACING = THICKNESS, DOT, RIM, SPACING
Strokes.SMALL_DOT, Strokes.SMALL_SPACING, Strokes.STOP_GAP = SMALL_DOT, SMALL_SPACING, STOP_GAP
Strokes.LATER_ALPHA, Strokes.DOT_ART, Strokes.LIMIT, Strokes.BOW = LATER_ALPHA, DOT_ART, LIMIT, BOW

-- Strokes in drawing order, as parallel arrays 1..n, in the view's own units
-- with x right and y up from its top left (TOPLEFT offsets). A redraw
-- overwrites the arrays in place: the minimap redraws ten times a second and
-- must not allocate.
--   x1, y1, x2, y2   the stroke (a dot's: its texture quad)
--   ux, uy           how far the outline reaches past each end
--   width, under     the core's and the outline's thickness
--   alpha, color     color = the view's colour table for the leg's kind
--   dot              a breadcrumb, drawn with the dot texture
function Strokes.New(limit)
	return {
		n = 0, limit = min(limit or LIMIT, LIMIT),
		x1 = {}, y1 = {}, x2 = {}, y2 = {}, ux = {}, uy = {},
		width = {}, under = {}, alpha = {}, color = {}, dot = {},
	}
end

---------------------------------------------------------------------------
-- Draw paths: a route leg's points as parallel arrays, built once per route
-- change. A flight follows its tracks (FlightPaths.lua: what each hop flies),
-- its corners cut three times as SPF's FlightLines does: render-only, the
-- ends stay where they are.
---------------------------------------------------------------------------

local function push(path, c, wx, wy)
	local n = path.n + 1
	path.n, path.c[n], path.x[n], path.y[n] = n, c, wx, wy
end

-- The track flown from node a to node b, or nil: a flat { wx, wy, ... }.
local function trackOf(tracks, a, b)
	local from = tracks and a and b and tracks[a]
	return from and from[b]
end

local function cutCorners(path)
	for _ = 1, 3 do
		local n, c, x, y = path.n, path.c, path.x, path.y
		if n < 3 then return end
		local nc, nx, ny = { c[1] }, { x[1] }, { y[1] }
		local k = 1
		for i = 2, n - 1 do
			if c[i - 1] == c[i] and c[i + 1] == c[i] then
				nc[k + 1], nx[k + 1], ny[k + 1] = c[i], x[i] * 0.75 + x[i - 1] * 0.25, y[i] * 0.75 + y[i - 1] * 0.25
				nc[k + 2], nx[k + 2], ny[k + 2] = c[i], x[i] * 0.75 + x[i + 1] * 0.25, y[i] * 0.75 + y[i + 1] * 0.25
				k = k + 2
			else
				nc[k + 1], nx[k + 1], ny[k + 1] = c[i], x[i], y[i]
				k = k + 1
			end
		end
		nc[k + 1], nx[k + 1], ny[k + 1] = c[n], x[n], y[n]
		path.n, path.c, path.x, path.y = k + 1, nc, nx, ny
	end
end

-- kind: the leg's kind; pts = { { c, wx, wy }, ... }; later: a leg after the
-- current one. tracks: ns.FlightTracks; nodes: { [i] = taxi node id } for a
-- flight's points, when known. -> { kind, n, c = {}, x = {} (wx), y = {} (wy), later }
function Strokes.Path(kind, pts, later, tracks, nodes)
	local path = { kind = kind, n = 0, c = {}, x = {}, y = {}, later = later and true or false }
	for i = 1, #pts do
		local p = pts[i]
		local track = kind == "flight" and i > 1 and nodes and trackOf(tracks, nodes[i - 1], nodes[i])
		if track and p[1] == pts[i - 1][1] then
			-- The track's own ends sit beside the flight masters: the leg's points stay the ends.
			for k = 3, #track - 3, 2 do push(path, p[1], track[k], track[k + 1]) end
		end
		push(path, p[1], p[2], p[3])
	end
	if kind == "flight" then cutCorners(path) end
	return path
end

---------------------------------------------------------------------------
-- The pen: one drawing at a time.
---------------------------------------------------------------------------

local out, limit
local scale, width, height, dot, spacing, walked
local fade, dim
-- Flow (view.phase, 0..1 of a spacing): breadcrumbs sit that far on along a
-- walk, and glints (view.glint: their colour) run along every ride, GLINT
-- pixels apart, carried across its bends as the breadcrumbs are.
local phase, glint, glided = 0, nil, 0
local GLINT = 46
-- Stop marks as x, y and reach, flat; near holds those the segment in hand passes.
local circles, circleCount, near = {}, 0, {}

local function Begin(buffer, viewScale, small)
	out, scale, limit = buffer, viewScale, buffer.limit or LIMIT
	out.n = 0
	dot, spacing = small and SMALL_DOT or DOT, small and SMALL_SPACING or SPACING
	walked, fade, circleCount, glided = 0, 1, 0, 0
end

local function Stroke(x1, y1, x2, y2, color, isDot)
	local n = out.n
	if n >= limit then return end
	n = n + 1
	out.n = n
	local ux, uy = 0, 0
	if isDot then
		-- A dot's rim reaches RIM past it on every side, so its outline is longer as well as thicker.
		local length = sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
		ux, uy = (x2 - x1) / length * RIM * DOT_ART / scale, (y2 - y1) / length * RIM * DOT_ART / scale
	end
	out.x1[n], out.y1[n], out.x2[n], out.y2[n], out.ux[n], out.uy[n] = x1, y1, x2, y2, ux, uy
	out.width[n] = (isDot and dot * DOT_ART or THICKNESS) / scale
	out.under[n] = (isDot and (dot + RIM * 2) * DOT_ART or UNDER_THICKNESS) / scale
	out.alpha[n], out.color[n], out.dot[n] = fade * dim, color, isDot or false
end

-- Clip segments, not vertices: a line can cross a zone with both ends outside it.
local function ClipAxis(start, delta, low, high, minimum, maximum)
	if delta == 0 then
		if start < minimum or start > maximum then return nil end
	else
		local a, b = (minimum - start) / delta, (maximum - start) / delta
		low, high = max(low, min(a, b)), min(high, max(a, b))
	end
	if low < high then return low, high end
end

-- The stop marks this segment passes near, copied from circles into near; returns the length copied.
local function Near(x1, y1, x2, y2)
	local count = 0
	local dx, dy = x2 - x1, y2 - y1
	local lengthSquared = dx * dx + dy * dy
	for i = 1, circleCount, 3 do
		local cx, cy, reach = circles[i], circles[i + 1], circles[i + 2]
		local t = max(0, min(1, ((cx - x1) * dx + (cy - y1) * dy) / lengthSquared))
		local ex, ey = x1 + t * dx - cx, y1 + t * dy - cy
		if ex * ex + ey * ey < reach * reach then
			near[count + 1], near[count + 2], near[count + 3] = cx, cy, reach
			count = count + 3
		end
	end
	return count
end

local function Clear(count, x, y)
	for i = 1, count, 3 do
		local dx, dy = x - near[i], y - near[i + 1]
		if dx * dx + dy * dy < near[i + 2] * near[i + 2] then return false end
	end
	return true
end

-- A stop mark the dots leave a gap around: its radius (view units) plus what
-- leaves STOP_GAP on screen past a dot's rim.
local function Circle(x, y, radius)
	circles[circleCount + 1], circles[circleCount + 2] = x, y
	circles[circleCount + 3] = radius + (STOP_GAP + dot / 2 + RIM) / scale
	circleCount = circleCount + 3
end

-- Clip before subdividing: even continent-sized walks need only the visible
-- breadcrumbs. Dots sit every `spacing` pixels along the whole walk, walked
-- carrying the distance across segment joins so bends never bunch them.
local function Segment(x1, y1, x2, y2, low, high, color, dashed)
	local dx, dy = x2 - x1, y2 - y1
	local length = sqrt(dx * dx + dy * dy) * scale
	if length == 0 then return end
	if not dashed then
		walked = 0
		local start = glided
		glided = start + length
		if not low then return end
		Stroke(x1 + low * dx, y1 + low * dy, x1 + high * dx, y1 + high * dy, color)
		if glint then
			local half = dot * DOT_ART / 2 / length
			local shift = phase * GLINT
			local first = ceil((start + low * length - shift - 0.001) / GLINT) * GLINT + shift - start
			for distance = first, high * length - 0.001, GLINT do
				local t = distance / length
				Stroke(x1 + (t - half) * dx, y1 + (t - half) * dy, x1 + (t + half) * dx, y1 + (t + half) * dy, glint, true)
			end
		end
		return
	end
	local start = walked
	walked = start + length
	if not low then return end
	-- The caller clipped a walk a dot's reach inside its frame, so every rim
	-- fits. A dot on a joint belongs to the later segment: both ends share a
	-- tolerance, so rounding in the running total cannot push it out of both.
	local half = dot * DOT_ART / 2 / length
	local shift = phase * spacing
	local first = ceil((start + low * length - shift - 0.001) / spacing) * spacing + shift - start
	local count = Near(x1, y1, x2, y2)
	for distance = first, high * length - 0.001, spacing do
		local t = distance / length
		if count == 0 or Clear(count, x1 + t * dx, y1 + t * dy) then
			Stroke(x1 + (t - half) * dx, y1 + (t - half) * dy, x1 + (t + half) * dx, y1 + (t + half) * dy, color, true)
		end
	end
end

-- What the world map shows, in map fractions: the map itself, or on OpenMap's
-- stitched map the view (view.clip).
local clipX0, clipY0, clipX1, clipY1 = 0, 0, 1, 1

-- A line between two map fractions, clipped to what shows.
local function Line(x1, y1, x2, y2, color, dashed)
	local reach = dot / 2 + RIM
	local mx = dashed and reach / scale / width or 0
	local my = dashed and reach / scale / height or 0
	local low, high = ClipAxis(x1, x2 - x1, 0, 1, clipX0 + mx, clipX1 - mx)
	if low then low, high = ClipAxis(y1, y2 - y1, low, high, clipY0 + my, clipY1 - my) end
	Segment(x1 * width, -y1 * height, x2 * width, -y2 * height, low, high, color, dashed)
end

-- A sea crossing between two docks: a gentle bow, always to the same side
-- of the way it goes, so out and back read as one crossing.
local function Crossing(ax, ay, bx, by, color, line)
	local dx, dy = bx - ax, by - ay
	local side = dx < 0 and -1 or 1
	local cx, cy = (ax + bx) / 2 + dy * side * BOW, (ay + by) / 2 - dx * side * BOW
	local px, py = ax, ay
	for step = 1, CURVE_STEPS do
		local t = step / CURVE_STEPS
		local x = (1 - t) ^ 2 * ax + 2 * (1 - t) * t * cx + t ^ 2 * bx
		local y = (1 - t) ^ 2 * ay + 2 * (1 - t) * t * cy + t ^ 2 * by
		line(px, py, x, y, color)
		px, py = x, y
	end
end

local function bows(path)
	return path.n == 2 and (path.kind == "boat" or path.kind == "zeppelin")
end

---------------------------------------------------------------------------
-- The world map
--   view = { c, left, top, kx, ky   world yards -> map fraction: fx = (wy - left) * kx, fy = (wx - top) * ky
--            width, height          the painter's size, in its own units
--            scale                  screen pixels per unit
--            small                  a continent map: smaller dots
--            marks, markCount       stop marks, flat { fx, fy, radius (units), ... }
--            colors = { [kind] = { r, g, b } },
--            from, fromIndex        the live start (see Strokes.Live): nil = from the first point
--            fits                   OpenMap's stitched map: { [continent] = { ub, uc, va, vc } },
--                                   fx = ub * wy + uc, fy = va * wx + vc, every continent it places
--                                   (c, left, top, kx, ky are then unused)
--            clip                   { x0, y0, x1, y1 } map fractions to draw within (default 0, 0, 1, 1)
--            phase, glint           flow: 0..1 of a spacing on, and the glints' colour (nil: none)
--            dim                    every stroke's alpha times this (default 1) }
---------------------------------------------------------------------------

local vc, vLeft, vTop, vKx, vKy, vFits

local function position(c, wx, wy)
	if vFits then
		local f = vFits[c]
		if not f then return nil end
		return f.ub * wy + f.uc, f.va * wx + f.vc
	end
	if c ~= vc then return nil end
	return (wy - vLeft) * vKx, (wx - vTop) * vKy
end
Strokes.MapPosition = function(view, c, wx, wy)
	vc, vLeft, vTop, vKx, vKy, vFits = view.c, view.left, view.top, view.kx, view.ky, view.fits
	return position(c, wx, wy)
end

local MapLine = Line

function Strokes.Map(buffer, paths, view)
	Begin(buffer, view.scale, view.small)
	width, height = view.width, view.height
	vc, vLeft, vTop, vKx, vKy, vFits = view.c, view.left, view.top, view.kx, view.ky, view.fits
	phase, glint, dim = view.phase or 0, view.glint, view.dim or 1
	local clip = view.clip
	if clip then
		clipX0, clipY0, clipX1, clipY1 = clip[1], clip[2], clip[3], clip[4]
	else
		clipX0, clipY0, clipX1, clipY1 = 0, 0, 1, 1
	end
	if not ((vc or vFits) and width > 0 and height > 0) then return end
	local marks = view.marks
	for i = 1, (view.markCount or 0) * 3, 3 do
		Circle(marks[i] * width, -marks[i + 1] * height, marks[i + 2])
	end
	local colors = view.colors
	for p = 1, #paths do
		local path = paths[p]
		local kind = path.kind
		local color = colors[kind]
		if color and kind ~= "hearth" then
			fade = path.later and LATER_ALPHA or 1
			walked, glided = 0, 0
			local dashed = kind == "walk" or kind == "preview"
			local first = 1
			local px, py, pc
			if p == 1 and view.from then
				first, pc, px, py = view.fromIndex, view.fromC, position(view.fromC, view.fromX, view.fromY)
			end
			if bows(path) then
				local ax, ay = position(path.c[1], path.x[1], path.y[1])
				local bx, by = position(path.c[2], path.x[2], path.y[2])
				if ax and bx then Crossing(ax, ay, bx, by, color, MapLine) end
			else
				local cs, xs, ys = path.c, path.x, path.y
				local n = path.n
				for i = first, n do
					local c = cs[i]
					local x, y = position(c, xs[i], ys[i])
					-- Rounded flight points can be under a pixel apart on a zoomed-out map:
					-- keep longer strokes, but always the last point.
					local short = kind == "flight" and px and x and i < n and c == pc
						and ((x - px) * width) ^ 2 + ((y - py) * height) ^ 2 < (3 / scale) ^ 2
					if not short then
						if px and x and c == pc then Line(px, py, x, y, color, dashed) end
						pc, px, py = c, x, y
					end
				end
			end
		end
	end
	fade, glint, phase = 1, nil, 0
end

---------------------------------------------------------------------------
-- The minimap
--   view = { c, x, y          the player: continent, wx, wy
--            radius, facing   view radius in yards, turned by facing (radians; 0 north-up)
--            width, height, scale, square,
--            goalC, goalX, goalY, goalRadius   the guide pin (radius in units), or goalC nil
--            colors, from, fromIndex           as the world map's }
---------------------------------------------------------------------------

local function ClipMinimap(x, y, dx, dy, inset, square)
	if square then
		local low, high = ClipAxis(x, dx, 0, 1, -inset, inset)
		if low then return ClipAxis(y, dy, low, high, -inset, inset) end
		return nil
	end
	local a, b, c = dx * dx + dy * dy, x * dx + y * dy, x * x + y * y - inset * inset
	local discriminant = b * b - a * c
	if a == 0 or discriminant <= 0 then return nil end
	local root = sqrt(discriminant)
	local low, high = max(0, (-b - root) / a), min(1, (-b + root) / a)
	if low < high then return low, high end
end

-- A world point on a minimap centred on x, y (wx, wy) and turned by the
-- facing whose cosine and sine these are: -1 to 1 across its face, x right
-- and y up (as Pins.Project).
function Strokes.Project(wx, wy, x, y, radius, cosine, sine)
	-- wx runs north, wy west; the minimap's x runs east, y north.
	local east, north = y - wy, wx - x
	return (east * cosine + north * sine) / radius, (north * cosine - east * sine) / radius
end
local Project = Strokes.Project

local mmSquare, mmInset, mmWithin

local function MinimapSegment(ax, ay, bx, by, color, dashed)
	local low, high = ClipMinimap(ax, ay, bx - ax, by - ay, dashed and mmWithin or mmInset, mmSquare)
	Segment((ax + 1) * width / 2, (ay - 1) * height / 2, (bx + 1) * width / 2, (by - 1) * height / 2, low, high, color, dashed)
end

local function MinimapLine(ax, ay, bx, by, color)
	MinimapSegment(ax, ay, bx, by, color, false)
end

function Strokes.Minimap(buffer, paths, view)
	Begin(buffer, view.scale)
	dim, glint, phase = 1, nil, 0
	local x, y, c, radius, facing = view.x, view.y, view.c, view.radius, view.facing
	width, height = view.width, view.height
	local border = UNDER_THICKNESS / scale
	if not (x and c and radius and radius > 0 and width > border and height > border) then return nil end
	local cosine, sine = cos(facing or 0), sin(facing or 0)
	mmSquare = view.square
	mmInset = 1 - border / min(width, height)
	mmWithin = mmInset - (dot + RIM * 2) * DOT_ART / scale / min(width, height)
	local markX, markY
	if view.goalC == c then
		local gx, gy = Project(view.goalX, view.goalY, x, y, radius, cosine, sine)
		if abs(gx) <= 1 and abs(gy) <= 1 and (mmSquare or gx * gx + gy * gy <= 1) then
			markX, markY = gx, gy
			Circle((gx + 1) * width / 2, (gy - 1) * height / 2, view.goalRadius or 0)
		end
	end
	local colors = view.colors
	for p = 1, #paths do
		local path = paths[p]
		local kind = path.kind
		local color = colors[kind]
		-- The step preview is the world map's alone.
		if color and kind ~= "hearth" and kind ~= "preview" then
			fade = path.later and LATER_ALPHA or 1
			walked = 0
			local dashed = kind == "walk"
			local cs, xs, ys = path.c, path.x, path.y
			if bows(path) then
				if cs[1] == c and cs[2] == c then
					local ax, ay = Project(xs[1], ys[1], x, y, radius, cosine, sine)
					local bx, by = Project(xs[2], ys[2], x, y, radius, cosine, sine)
					Crossing(ax, ay, bx, by, color, MinimapLine)
				end
			else
				local first, pc, px, py = 2, cs[1], nil, nil
				if p == 1 and view.from then
					first, pc = view.fromIndex, view.fromC
					if pc == c then px, py = Project(view.fromX, view.fromY, x, y, radius, cosine, sine) end
				elseif pc == c then
					px, py = Project(xs[1], ys[1], x, y, radius, cosine, sine)
				end
				for i = first, path.n do
					local ci = cs[i]
					local bx, by
					if ci == c then bx, by = Project(xs[i], ys[i], x, y, radius, cosine, sine) end
					if px and bx and pc == ci then MinimapSegment(px, py, bx, by, color, dashed) end
					pc, px, py = ci, bx, by
				end
			end
		end
	end
	fade = 1
	-- Keep the last few yards in sight when the guide pin covers every breadcrumb.
	if markX and out.n == 0 then
		local distance = markX * markX + markY * markY
		if distance > 0 and distance < 0.25 and colors.walk then
			Stroke(width / 2, -height / 2, (markX + 1) * width / 2, (markY - 1) * height / 2, colors.walk)
		end
	end
	return markX, markY
end

---------------------------------------------------------------------------
-- The live start: the walk being walked starts where the player is, not where
-- it was planned from. The nearest point on the path to the player, searched
-- from `from` on (progress never runs back), within `reach` yards; returns the
-- index of the first point still ahead and the nearest point, or nil when the
-- player is off the path.
---------------------------------------------------------------------------

function Strokes.Live(path, c, wx, wy, from, reach)
	if not (path and c and path.n >= 2) then return nil end
	local cs, xs, ys = path.c, path.x, path.y
	local best, bestI, bestX, bestY = reach * reach, nil, nil, nil
	for i = max(2, from or 2), path.n do
		if cs[i] == c and cs[i - 1] == c then
			local ax, ay = xs[i - 1], ys[i - 1]
			local dx, dy = xs[i] - ax, ys[i] - ay
			local l2 = dx * dx + dy * dy
			local t = l2 > 0 and max(0, min(1, ((wx - ax) * dx + (wy - ay) * dy) / l2)) or 0
			local nx, ny = ax + t * dx, ay + t * dy
			local d2 = (wx - nx) ^ 2 + (wy - ny) ^ 2
			if d2 < best then best, bestI, bestX, bestY = d2, i, nx, ny end
		end
	end
	return bestI, bestX, bestY
end
