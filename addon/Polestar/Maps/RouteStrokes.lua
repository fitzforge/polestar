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
-- and minimap alike. In the dots style (the view's style nil) walks are round
-- breadcrumbs: each a dot-textured line one diameter long over a slightly
-- larger dark dot, spaced evenly along the walk. In the line style
-- (view.style "line") a walk is one continuous line `view.lineWidth` px
-- thick over a soft shadow (Media/Nav/line-soft, feathered across its
-- width), its sharper bends rounded by a disc, optionally with small dark
-- chevrons pointing the way (view.chevrons; the painters leave them off) and the stretch already
-- walked fading out behind the player; flights are dashed, rides solid.
--
--   Strokes.New(limit)                     a buffer of at most `limit` strokes
--   Strokes.Path(kind, pts, later, tracks) a leg as a draw path (once per route change)
--   Strokes.Map(buffer, paths, view)       the paths on the world map at this view
--   Strokes.Minimap(buffer, paths, view)   the paths on the minimap -> goal mark x, y or nil
--   Strokes.Project(...)                   a world point on the minimap's face

local ADDON, ns = ...

local sqrt, ceil, floor, min, max, abs, cos, sin = math.sqrt, math.ceil, math.floor, math.min, math.max, math.abs, math.cos, math.sin

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

-- The line style, in screen pixels: the walk's soft shadow reaches SHADOW past
-- the line on each side; a bend sharper than JOINT_COS (cosine, about 14
-- degrees) gets a round joint; a chevron every CHEVRON_SPACING, its arms
-- CHEVRON_ARM long and CHEVRON_WIDTH thick, CHEVRON_ALPHA strong; flights
-- dashed DASH on, DASH_GAP off; the walked stretch fades from WALKED_ALPHA
-- to nothing over TAIL, in pieces of at most TAIL_STEP.
local SHADOW, JOINT_COS, STRAIGHT_COS = 3, 0.97, 0.9999
local CHEVRON_SPACING, CHEVRON_ARM, CHEVRON_WIDTH, CHEVRON_ALPHA = 90, 3.5, 1.5, 0.6
local DASH, DASH_GAP = 7, 5
-- The line's pieces: path points nearer than LINE_MIN px to the last one kept
-- are passed over (a walking path's points can be a pixel or two apart).
local LINE_MIN = 8
local WALKED_ALPHA, TAIL, TAIL_STEP = 0.45, 120, 12
local LINE_WIDTH, LINE_WIDTHS = 4, { 2, 8 }
-- The minimap: nothing is drawn within PLAYER_GAP px of its centre, where the
-- game draws the player's arrow under every frame on the minimap (a route dot
-- there read as the player); its dots are MINIMAP_STRETCH times as long as
-- they are wide, along the way, so a route dot is never the round blip of a
-- party member, a herb or the player.
local PLAYER_GAP, MINIMAP_STRETCH = 9, 1.5
-- In the line style a walk drawn straight, no walking path known for it (the
-- geometry's `straight`), is dashed and GUESS_ALPHA as strong. The dots keep
-- their look: the players who keep them see what they saw.
local GUESS_ALPHA = 0.55

Strokes.THICKNESS, Strokes.DOT, Strokes.RIM, Strokes.SPACING = THICKNESS, DOT, RIM, SPACING
Strokes.SMALL_DOT, Strokes.SMALL_SPACING, Strokes.STOP_GAP = SMALL_DOT, SMALL_SPACING, STOP_GAP
Strokes.LATER_ALPHA, Strokes.DOT_ART, Strokes.LIMIT = LATER_ALPHA, DOT_ART, LIMIT
Strokes.SHADOW, Strokes.CHEVRON_SPACING, Strokes.DASH, Strokes.DASH_GAP = SHADOW, CHEVRON_SPACING, DASH, DASH_GAP
Strokes.WALKED_ALPHA, Strokes.TAIL, Strokes.LINE_WIDTH, Strokes.LINE_WIDTHS = WALKED_ALPHA, TAIL, LINE_WIDTH, LINE_WIDTHS
Strokes.PLAYER_GAP, Strokes.MINIMAP_STRETCH = PLAYER_GAP, MINIMAP_STRETCH
Strokes.GUESS_ALPHA = GUESS_ALPHA

-- Strokes in drawing order, as parallel arrays 1..n, in the view's own units
-- with x right and y up from its top left (TOPLEFT offsets). A redraw
-- overwrites the arrays in place: the minimap redraws ten times a second and
-- must not allocate.
--   x1, y1, x2, y2   the stroke (a dot's: its texture quad)
--   ux, uy           how far the outline reaches past each end
--   width, under     the core's and the outline's thickness (under 0: no outline)
--   alpha, color     color = the view's colour table for the leg's kind
--   dot              a breadcrumb or a joint, drawn with the dot texture
--   soft             the outline is the line style's soft shadow
function Strokes.New(limit)
	return {
		n = 0, limit = min(limit or LIMIT, LIMIT),
		x1 = {}, y1 = {}, x2 = {}, y2 = {}, ux = {}, uy = {},
		width = {}, under = {}, alpha = {}, color = {}, dot = {}, soft = {},
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
-- flight's points, when known; guess: a walk drawn straight, no walking path
-- known. -> { kind, n, c = {}, x = {} (wx), y = {} (wy), later, guess }
function Strokes.Path(kind, pts, later, tracks, nodes, guess)
	local path = { kind = kind, n = 0, c = {}, x = {}, y = {}, later = later and true or false, guess = guess and kind == "walk" or false }
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
local fade
-- A dot's length over its width: 1, or MINIMAP_STRETCH on the minimap.
local stretch
-- The line style: on, the walk's thickness (px), chevrons and their colour.
local lined, lineWidth, chevrons, chevronColor
-- The line's last piece drawn to its own end: that end and its direction,
-- for the joint at the next piece (jointX nil: none to join).
local jointX, jointY, jointDx, jointDy
-- Stop marks as x, y and reach, flat; near holds those the segment in hand passes.
local circles, circleCount, near = {}, 0, {}

local function Begin(buffer, view, small)
	out, scale, limit = buffer, view.scale, buffer.limit or LIMIT
	out.n = 0
	dot, spacing = small and SMALL_DOT or DOT, small and SMALL_SPACING or SPACING
	walked, fade, circleCount, stretch = 0, 1, 0, 1
	lined = view.style == "line"
	local w = tonumber(view.lineWidth) or LINE_WIDTH
	lineWidth = w < LINE_WIDTHS[1] and LINE_WIDTHS[1] or w > LINE_WIDTHS[2] and LINE_WIDTHS[2] or w
	-- Continent maps show a whole route small, as their dots are.
	if small then lineWidth = max(LINE_WIDTHS[1], lineWidth - 1) end
	chevronColor = view.chevronColor
	chevrons = lined and view.chevrons and chevronColor ~= nil or false
	jointX = nil
end

-- One stroke: its ends, how far its outline reaches past them, the core's and
-- the outline's thickness (view units), alpha, colour, dot texture, soft outline.
local function Put(x1, y1, x2, y2, ux, uy, core, outline, alpha, color, isDot, soft)
	local n = out.n
	if n >= limit then return end
	n = n + 1
	out.n = n
	out.x1[n], out.y1[n], out.x2[n], out.y2[n], out.ux[n], out.uy[n] = x1, y1, x2, y2, ux, uy
	out.width[n], out.under[n], out.alpha[n], out.color[n] = core, outline, alpha, color
	out.dot[n], out.soft[n] = isDot or false, soft or false
end

local function Stroke(x1, y1, x2, y2, color, isDot)
	local ux, uy = 0, 0
	if isDot then
		-- A dot's rim reaches RIM past it on every side, so its outline is longer as well as thicker.
		local length = sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
		ux, uy = (x2 - x1) / length * RIM * DOT_ART / scale, (y2 - y1) / length * RIM * DOT_ART / scale
	end
	Put(x1, y1, x2, y2, ux, uy, (isDot and dot * DOT_ART or THICKNESS) / scale,
		(isDot and (dot + RIM * 2) * DOT_ART or UNDER_THICKNESS) / scale, fade, color, isDot, false)
end

-- A piece of the line style's walk: the line over its soft shadow.
local function Wide(x1, y1, x2, y2, color)
	Put(x1, y1, x2, y2, 0, 0, lineWidth / scale, (lineWidth + SHADOW * 2) / scale, fade, color, false, true)
end

-- A bend's round joint: a disc the line's width across at (x, y), turned
-- along (dx, dy); no outline of its own (the two pieces' shadows meet there).
local function Joint(x, y, dx, dy, color)
	local length = sqrt(dx * dx + dy * dy)
	local half = lineWidth * DOT_ART / 2 / scale
	local ex, ey = dx / length * half, dy / length * half
	Put(x - ex, y - ey, x + ex, y + ey, 0, 0, lineWidth * DOT_ART / scale, 0, fade, color, true, false)
end

-- A chevron centred on (x, y) pointing along the unit (dx, dy): two short
-- dark arms back from its tip, about 40 degrees off the way, no outline.
local CHEVRON_COS, CHEVRON_SIN = cos(0.7), sin(0.7)
local function Chevron(x, y, dx, dy)
	local arm = CHEVRON_ARM / scale
	local tx, ty = x + dx * arm / 2, y + dy * arm / 2
	for side = -1, 1, 2 do
		local rx = -dx * CHEVRON_COS + dy * CHEVRON_SIN * side
		local ry = -dx * CHEVRON_SIN * side - dy * CHEVRON_COS
		Put(tx, ty, tx + rx * arm, ty + ry * arm, 0, 0, CHEVRON_WIDTH / scale, 0, CHEVRON_ALPHA * fade, chevronColor, false, false)
	end
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

-- The line style's walk: one piece per segment, a joint where it bends
-- sharply, chevrons every CHEVRON_SPACING along the walk (half a spacing in
-- from its start, none under a stop's mark). length: the segment in pixels;
-- start: the walk's length before it.
local function LineSegment(x1, y1, dx, dy, length, start, low, high, color)
	-- Nothing to see: clipped away, or a sliver left at the minimap's centre or edge.
	if not low or (high - low) * length < 0.5 then
		jointX = nil
		return
	end
	-- A piece joined to the last one at a bend starts half the line's width back
	-- along its own way: that covers the wedge the two square ends leave on the
	-- bend's outer side (any turn up to 90 degrees; sharper ones also get a
	-- round joint). Straight-on joins (the tail's pieces) are not overlapped, so
	-- a faded line shows no darker spots. No extra stroke either way.
	local back = 0
	if low == 0 and jointX == x1 and jointY == y1 then
		local turn = (jointDx * dx + jointDy * dy) / sqrt((jointDx * jointDx + jointDy * jointDy) * (dx * dx + dy * dy))
		if turn < STRAIGHT_COS then back = lineWidth / 2 / length end
		if fade == 1 and turn < JOINT_COS then Joint(x1, y1, dx, dy, color) end
	end
	Wide(x1 + (low - back) * dx, y1 + (low - back) * dy, x1 + high * dx, y1 + high * dy, color)
	if high == 1 then
		jointX, jointY, jointDx, jointDy = x1 + dx, y1 + dy, dx, dy
	else
		jointX = nil
	end
	if not chevrons or fade < 1 then return end
	local half = CHEVRON_SPACING / 2
	-- A chevron on a joint belongs to the later segment, as a dot does.
	local first = ceil((start + low * length - half - 0.001) / CHEVRON_SPACING) * CHEVRON_SPACING + half - start
	if first > high * length - 0.001 then return end
	local count = Near(x1, y1, x1 + dx, y1 + dy)
	local ux, uy = dx / length * scale, dy / length * scale
	for distance = first, high * length - 0.001, CHEVRON_SPACING do
		local t = distance / length
		local x, y = x1 + t * dx, y1 + t * dy
		if count == 0 or Clear(count, x, y) then Chevron(x, y, ux, uy) end
	end
end

-- A flight in the line style: DASH on and DASH_GAP off, carried across its
-- joins; wide: a guessed walk's, as thick as the line (twice the dash).
local function DashSegment(x1, y1, dx, dy, length, start, low, high, color, wide)
	if not low then return end
	local on = wide and DASH * 2 or DASH
	local period = on + DASH_GAP
	local from, to = start + low * length, start + high * length
	local k = floor(from / period) * period
	while k < to do
		local a, b = max(k, from), min(k + on, to)
		if b - a > 0.5 then -- no sliver left at a join
			local ta, tb = (a - start) / length, (b - start) / length
			if wide then
				Wide(x1 + ta * dx, y1 + ta * dy, x1 + tb * dx, y1 + tb * dy, color)
			else
				Stroke(x1 + ta * dx, y1 + ta * dy, x1 + tb * dx, y1 + tb * dy, color)
			end
		end
		k = k + period
	end
end

-- mode: "solid" (default), "dots" (the dots style's walk), "line" (the line
-- style's walk), "dash" (the line style's flight), "guess" (the line style's
-- walk with no walking path known: dashed as thick as the line).
-- Clip before subdividing: even continent-sized walks need only the visible
-- breadcrumbs. Dots sit every `spacing` pixels along the whole walk, walked
-- carrying the distance across segment joins so bends never bunch them.
local function Segment(x1, y1, x2, y2, low, high, color, mode)
	local dx, dy = x2 - x1, y2 - y1
	local length = sqrt(dx * dx + dy * dy) * scale
	if length == 0 then return end
	if mode ~= "dots" and mode ~= "line" and mode ~= "dash" and mode ~= "guess" then
		walked = 0
		if low then Stroke(x1 + low * dx, y1 + low * dy, x1 + high * dx, y1 + high * dy, color) end
		return
	end
	local start = walked
	walked = start + length
	if mode == "line" then return LineSegment(x1, y1, dx, dy, length, start, low, high, color) end
	if mode == "dash" or mode == "guess" then return DashSegment(x1, y1, dx, dy, length, start, low, high, color, mode == "guess") end
	if not low then return end
	-- The caller clipped a walk a dot's reach inside its frame, so every rim
	-- fits. A dot on a joint belongs to the later segment: both ends share a
	-- tolerance, so rounding in the running total cannot push it out of both.
	local half = dot * DOT_ART * stretch / 2 / length
	local first = ceil((start + low * length - 0.001) / spacing) * spacing - start
	local count = Near(x1, y1, x2, y2)
	for distance = first, high * length - 0.001, spacing do
		local t = distance / length
		if count == 0 or Clear(count, x1 + t * dx, y1 + t * dy) then
			Stroke(x1 + (t - half) * dx, y1 + (t - half) * dy, x1 + (t + half) * dx, y1 + (t + half) * dy, color, true)
		end
	end
end

-- A line between two map fractions, clipped to the map.
local function Line(x1, y1, x2, y2, color, mode)
	local dashed = mode == "dots"
	local reach = dot / 2 + RIM
	local mx = dashed and reach / scale / width or 0
	local my = dashed and reach / scale / height or 0
	local low, high = ClipAxis(x1, x2 - x1, 0, 1, mx, 1 - mx)
	if low then low, high = ClipAxis(y1, y2 - y1, low, high, my, 1 - my) end
	Segment(x1 * width, -y1 * height, x2 * width, -y2 * height, low, high, color, mode)
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

-- How a path is drawn in the view's style; sets fade, its strength.
local function modeOf(path)
	local kind = path.kind
	fade = path.later and LATER_ALPHA or 1
	if lined and path.guess then
		fade = fade * GUESS_ALPHA
		return "guess"
	end
	if kind == "walk" then return lined and "line" or "dots" end
	if kind == "flight" and lined then return "dash" end
	return "solid"
end

-- The line style's walked stretch: from the live start (bx, by) back along
-- the path's points before `index`, in pieces fading out over TAIL pixels.
-- point(path, i) -> the point in the view's units, or nil off the view's
-- continent; kx, ky: pixels per unit; line: the view's Line.
local function Tail(path, index, bx, by, point, kx, ky, line, color)
	local behind = 0
	for i = index - 1, 1, -1 do
		local ax, ay = point(path, i)
		if not ax then return end
		local dx, dy = ax - bx, ay - by
		local length = sqrt((dx * kx) ^ 2 + (dy * ky) ^ 2)
		-- Points nearer than LINE_MIN to the last one kept are passed over, as ahead.
		if length >= LINE_MIN or i == 1 then
			local pieces = ceil(length / TAIL_STEP)
			for j = 1, pieces do
				local t0, t1 = (j - 1) / pieces, j / pieces
				local alpha = WALKED_ALPHA * (1 - (behind + length * (t0 + t1) / 2) / TAIL)
				if alpha <= 0.02 then return end
				fade = alpha
				line(bx + dx * t0, by + dy * t0, bx + dx * t1, by + dy * t1, color, "line")
			end
			behind = behind + length
			if behind >= TAIL then return end
			bx, by = ax, ay
		end
	end
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
--            style, lineWidth       "line": the line style, its walk lineWidth px thick; nil: dots
--            chevrons, chevronColor the line style's chevrons, in this colour }
---------------------------------------------------------------------------

local vc, vLeft, vTop, vKx, vKy

local function position(c, wx, wy)
	if c ~= vc then return nil end
	return (wy - vLeft) * vKx, (wx - vTop) * vKy
end

local function mapPoint(path, i)
	return position(path.c[i], path.x[i], path.y[i])
end

local MapLine = Line

function Strokes.Map(buffer, paths, view)
	Begin(buffer, view, view.small)
	width, height = view.width, view.height
	vc, vLeft, vTop, vKx, vKy = view.c, view.left, view.top, view.kx, view.ky
	if not (vc and width > 0 and height > 0) then return end
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
			walked, jointX = 0, nil
			local mode = modeOf(path)
			local merges = mode == "line" or mode == "guess"
			local strength = fade
			local first = 1
			local px, py, pc
			if p == 1 and view.from then
				first, pc, px, py = view.fromIndex, view.fromC, position(view.fromC, view.fromX, view.fromY)
				if mode == "line" and px then
					Tail(path, first, px, py, mapPoint, width * scale, height * scale, Line, color)
					fade, walked, jointX = strength, 0, nil
				end
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
					-- Rounded flight points can be under a pixel apart on a zoomed-out map,
					-- and a walk's path points a few: keep longer strokes (the line's
					-- pieces at least LINE_MIN), but always the last point.
					local least = kind == "flight" and 3 or merges and LINE_MIN
					local short = least and px and x and i < n and c == pc
						and ((x - px) * width) ^ 2 + ((y - py) * height) ^ 2 < (least / scale) ^ 2
					if not short then
						if px and x and c == pc then Line(px, py, x, y, color, mode) end
						pc, px, py = c, x, y
					end
				end
			end
		end
	end
	fade = 1
end

---------------------------------------------------------------------------
-- The minimap
--   view = { c, x, y          the player: continent, wx, wy
--            radius, facing   view radius in yards, turned by facing (radians; 0 north-up)
--            width, height, scale, square,
--            goalC, goalX, goalY, goalRadius   the guide pin (radius in units), or goalC nil
--            colors, from, fromIndex           as the world map's
--            style, lineWidth                  as the world map's (no chevrons here) }
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

local mmSquare, mmInset, mmWithin, mmLine, mmGap
local mmC, mmX, mmY, mmRadius, mmCos, mmSin

-- Lines and strokes leave out what lies within mmGap of the centre (the
-- player's arrow); the dots keep clear of it as of a stop's mark. A segment
-- through it is drawn as two pieces, its length counted once.
local function MinimapSegment(ax, ay, bx, by, color, mode)
	local inset = mode == "dots" and mmWithin or mode == "line" and mmLine or mmInset
	local dx, dy = bx - ax, by - ay
	local low, high = ClipMinimap(ax, ay, dx, dy, inset, mmSquare)
	local x1, y1, x2, y2 = (ax + 1) * width / 2, (ay - 1) * height / 2, (bx + 1) * width / 2, (by - 1) * height / 2
	if low and mode ~= "dots" then
		local a, b, c = dx * dx + dy * dy, ax * dx + ay * dy, ax * ax + ay * ay - mmGap * mmGap
		local discriminant = b * b - a * c
		if a > 0 and discriminant > 0 then
			local root = sqrt(discriminant)
			local inside, outside = (-b - root) / a, (-b + root) / a
			if inside < high and outside > low then
				if inside > low and outside < high then
					local before = walked
					Segment(x1, y1, x2, y2, low, inside, color, mode)
					walked = before
					low = outside
				elseif inside <= low then
					low = outside
				else
					high = inside
				end
				if low >= high then low = nil end
			end
		end
	end
	Segment(x1, y1, x2, y2, low, high, color, mode)
end

local function MinimapLine(ax, ay, bx, by, color)
	MinimapSegment(ax, ay, bx, by, color, "solid")
end

local function minimapPoint(path, i)
	if path.c[i] ~= mmC then return nil end
	return Project(path.x[i], path.y[i], mmX, mmY, mmRadius, mmCos, mmSin)
end

function Strokes.Minimap(buffer, paths, view)
	Begin(buffer, view)
	local x, y, c, radius, facing = view.x, view.y, view.c, view.radius, view.facing
	width, height = view.width, view.height
	local border = UNDER_THICKNESS / scale
	if not (x and c and radius and radius > 0 and width > border and height > border) then return nil end
	local cosine, sine = cos(facing or 0), sin(facing or 0)
	mmC, mmX, mmY, mmRadius, mmCos, mmSin = c, x, y, radius, cosine, sine
	mmSquare = view.square
	mmInset = 1 - border / min(width, height)
	mmWithin = mmInset - (dot + RIM * 2) * DOT_ART / scale / min(width, height)
	mmLine = 1 - (lineWidth + SHADOW * 2) / scale / min(width, height)
	mmGap = PLAYER_GAP / scale / (min(width, height) / 2)
	stretch = MINIMAP_STRETCH
	Circle(width / 2, -height / 2, PLAYER_GAP / scale)
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
		if color and kind ~= "hearth" then
			walked, jointX = 0, nil
			local mode = modeOf(path)
			local strength = fade
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
					if mode == "line" and px then
						Tail(path, first, px, py, minimapPoint, width / 2 * scale, height / 2 * scale, MinimapSegment, color)
						fade, walked, jointX = strength, 0, nil
					end
				elseif pc == c then
					px, py = Project(xs[1], ys[1], x, y, radius, cosine, sine)
				end
				-- The line's pieces at least LINE_MIN long, as on the world map.
				local merges, n = mode == "line" or mode == "guess", path.n
				local least = (LINE_MIN / scale) ^ 2
				for i = first, n do
					local ci = cs[i]
					local bx, by
					if ci == c then bx, by = Project(xs[i], ys[i], x, y, radius, cosine, sine) end
					if not (merges and px and bx and pc == ci and i < n
						and ((bx - px) * width / 2) ^ 2 + ((by - py) * height / 2) ^ 2 < least) then
						if px and bx and pc == ci then MinimapSegment(px, py, bx, by, color, mode) end
						pc, px, py = ci, bx, by
					end
				end
			end
		end
	end
	fade = 1
	-- Keep the last few yards in sight when the guide pin covers every breadcrumb.
	if markX and out.n == 0 then
		local distance = markX * markX + markY * markY
		if distance > mmGap * mmGap and distance < 0.25 and colors.walk then
			local k = mmGap / sqrt(distance)
			Stroke((markX * k + 1) * width / 2, (markY * k - 1) * height / 2, (markX + 1) * width / 2, (markY - 1) * height / 2, colors.walk)
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
