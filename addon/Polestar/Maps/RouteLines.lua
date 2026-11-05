-- Route lines (docs/ARCHITECTURE.md, "Maps"): the way to the guide's target,
-- drawn on the world map and the minimap from the route Nav publishes
-- (Nav.GetRouteGeometry, NAV_ROUTE_GEOMETRY). Walks are breadcrumbs, flights
-- follow what the flight master flies (FlightPaths.lua), boats, zeppelins and
-- the tram are solid strokes; the current leg is strong and the legs after it
-- recede. Geometry is Maps/RouteStrokes.lua's; this file only paints it.
--
-- The painters follow Shortest Path Forever's (UI/Route.lua, v1.15.0) by
-- Cillian Berragan, GPL-3.0-or-later, used with his permission (2026-10-15):
-- one world map pin the size of the canvas and one frame over the minimap,
-- each copying strokes onto its own pool of line pairs (a core over a dark
-- outline), created on demand and only ever hidden, bounded by the stroke
-- buffer's limit.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
-- On the world map the canvas-sized frame is Polestar's own, on the map's
-- canvas through the map's view (Nav/MapCanvas.lua): the map is only read,
-- never written (no data provider, no pin pool, no AcquirePin), so the
-- gamepad interface's secure code meets nothing of Polestar's there.
--
-- Cost model: the draw paths are built once per NAV_ROUTE_GEOMETRY (flights
-- expanded along their tracks then). The world map frame redraws on map,
-- zoom, size, route, setting and theme changes, and when the player has
-- walked past a point of the walk (its own 4 Hz check, which runs only while
-- the map shows it). The minimap redraws from a 10 Hz driver that runs only
-- while there is a route to draw on it, and only when the player, the facing,
-- the zoom or the route changed since the last draw. No draw allocates.
--
-- nav.routeLines turns the lines on; nav.worldPins and nav.minimapPins pick
-- the surfaces, as for Nav's pins. Polestar.Pins' trail dots (Nav/Layers.lua)
-- stand in while the lines are off.
--
-- nav.lineStyle "sparkle" draws the same paths as twinkling sparkles instead
-- (Maps/RouteSparkle.lua: where each one sits and how it twinkles), on the
-- same two frames, each from its own pool of star and halo textures. They
-- move, so both surfaces redraw them about 30 times a second while they
-- show; with OpenMap's stitched world map on, the world map places them
-- through OpenMapAPI.CanvasFromWorldPos, above OpenMap's art. A draw looks
-- only along the stretches of the route that reach the minimap's face or the
-- map's canvas (Sparkle.Spans; the route projected on the map once per
-- route, map or size), so its cost follows the sparkles shown, not the
-- route's length, and it sets colours and shows textures only when they change.

local ADDON, ns = ...
local Nav, Strokes, Sparkle = ns.Nav, ns.RouteStrokes, ns.RouteSparkle
-- Without Nav there is no route (and no nav.* setting to show).
if not (Nav and Nav.GetRouteGeometry and Strokes) then return end

local type, ipairs, pairs, abs, cos, sin, pcall = type, ipairs, pairs, math.abs, math.cos, math.sin, pcall

local RouteLines = {}
ns.RouteLines = RouteLines

ns.RegisterDefaults("nav", { routeLines = true, lineStyle = "dots" })
if Sparkle then ns.RegisterDefaults("nav", Sparkle.DEFAULTS) end

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"
local DOT_TEXTURE = MEDIA .. "pin-fill"
local UNDER_ALPHA = 0.5
local MINIMAP_LIMIT = 600 -- strokes on the minimap: a full face of breadcrumbs, with room
local DRIVE_INTERVAL = 0.1
local SPARKLE_TEXTURE, GLOW_TEXTURE = MEDIA .. "sparkle", MEDIA .. "glow"
local SPARKLE_INTERVAL = 1 / 30 -- sparkle redraws a second, per surface
local SPARKLE_SCAN = 4000 -- places looked at per surface per draw, whatever is shown
local PROGRESS_INTERVAL = 0.25
-- The marks the dots leave a gap around, as Nav/Layers.lua sizes its pins
-- (Pins: 16 px on the world map, 14 on the minimap; the target at 1.4, the
-- route's stops at 0.9), as radii.
local STOP_MARK, GOAL_MARK, MINIMAP_GOAL = 7, 11, 10
-- Yards: the walk being walked starts at the player when they are this near it.
local LIVE_REACH = 60
-- Point kinds that are jumps, not ways: nothing is drawn for them.
local JUMP = { hearth = true, teleport = true, portal = true }

-- Theme tokens per leg kind (the same as the travel pins': Maps/TravelPins.lua).
local TOKEN = { walk = "arrow", flight = "success", boat = "npc", zeppelin = "place", tram = "object", lift = "object" }
local colors = {}
for kind in pairs(TOKEN) do colors[kind] = { 1, 1, 1 } end
local under = { 0.02, 0.03, 0.06 }

---------------------------------------------------------------------------
-- The route as draw paths
---------------------------------------------------------------------------

local paths = {}          -- Strokes.Path per drawable leg, in travel order
local marks = {}          -- world map stop marks: c, wx, wy, radius (px), ...
local markCount = 0
local goalC, goalX, goalY -- the route's end
local live, liveC, liveX, liveY = nil, nil, nil, nil -- the walk's live start: index ahead, player
local revision = 0        -- bumps on every change the painters must redraw for

-- The sparkle style: on or off, its look (Sparkle.Style), the paths as
-- measured runs, and where each run's sparkles start (yards in: the walk
-- being walked starts at the player).
local sparkling, sparkleStyle = false, nil
local runs, runFrom = {}, {}
local phase, phaseAt = 0, 0 -- sparkle spacings flowed toward the goal by GetTime() phaseAt
local progressAt = 0

local function sparkleClock()
	return GetTime and GetTime() or 0
end

-- Sparkles drift on at the flow rate; a new rate carries on from where they are.
local function sparklePhase(now)
	return phase + (now - phaseAt) * (sparkleStyle and sparkleStyle.flow or 0)
end

local function surfaces()
	if not ns.Get("nav.routeLines") then return false, false end
	return ns.Get("nav.worldPins") and true or false, ns.Get("nav.minimapPins") and true or false
end

-- The taxi node at a flight's point (its legs' points are the nodes' own positions).
local function nodeAt(data, c, wx, wy)
	for _, node in ipairs(data and data.taxi or {}) do
		if node.c == c and abs(node.wx - wx) < 1 and abs(node.wy - wy) < 1 then return node.id end
	end
end

local function rebuild()
	for i = #paths, 1, -1 do paths[i] = nil end
	markCount, goalC, live = 0, nil, nil
	local geometry = Nav and Nav.GetRouteGeometry and Nav.GetRouteGeometry()
	local legs = type(geometry) == "table" and geometry.legs or nil
	if not legs then return end
	local data = Nav.GetTravelData and Nav.GetTravelData()
	local seenCurrent = false
	for _, leg in ipairs(legs) do
		local pts = type(leg.pts) == "table" and leg.pts or {}
		local later = seenCurrent and not leg.current
		if leg.current then seenCurrent = true end
		if RouteLines.Drawable(leg) then
			local nodes
			if leg.kind == "flight" then
				nodes = {}
				for i, p in ipairs(pts) do nodes[i] = nodeAt(data, p[1], p[2], p[3]) end
			end
			paths[#paths + 1] = Strokes.Path(leg.kind, pts, later, ns.FlightTracks, nodes)
		end
		local last = pts[#pts]
		if last then
			marks[markCount * 4 + 1], marks[markCount * 4 + 2], marks[markCount * 4 + 3] = last[1], last[2], last[3]
			marks[markCount * 4 + 4] = STOP_MARK
			markCount = markCount + 1
			goalC, goalX, goalY = last[1], last[2], last[3]
		end
	end
	if markCount > 0 then marks[markCount * 4] = GOAL_MARK end
end

-- The player's world position, or nil when unknown or unreadable (secret:
-- NAV_QA C5).
local function playerPosition()
	local C = ns.Compat
	if not (C and C.GetPlayerWorldPosition) then return nil end
	local pc, px, py = C.GetPlayerWorldPosition()
	local secret = C.IsSecret
	if secret and (secret(pc) or secret(px) or secret(py)) then return nil end
	return pc, px, py
end

-- Where the sparkles start on each run: the first, when it is the leg being
-- travelled and the player is on it, at the player.
local function sparkleProgress()
	for i = 1, #runs do runFrom[i] = 0 end
	local first = runs[1]
	if not (first and not first.later) then return end
	local pc, px, py = playerPosition()
	if not pc then return end
	local along, off = Sparkle.Nearest(first, pc, px, py)
	if along and off <= LIVE_REACH then runFrom[1] = along end
end

local function restyle()
	sparkling = Sparkle ~= nil and ns.Get("nav.lineStyle") == "sparkle"
	if not sparkling then return end
	local now = sparkleClock()
	phase, phaseAt = sparklePhase(now), now
	sparkleStyle = Sparkle.Style(function(key) return ns.Get("nav." .. key) end)
end

local function rebuildRuns()
	for i = #runs, 1, -1 do runs[i], runFrom[i] = nil, nil end
	if not sparkling then return end
	for i, run in ipairs(Sparkle.Paths(paths, sparkleStyle.later)) do runs[i] = run end
	sparkleProgress()
end

-- Whether a geometry leg draws anything: a way (not a jump) of a kind with a
-- colour, through at least two distinct points (a lift's shaft point twice
-- draws nothing).
function RouteLines.Drawable(leg)
	local pts = type(leg) == "table" and leg.pts
	if type(pts) ~= "table" or #pts < 2 or JUMP[leg.kind] or not colors[leg.kind] then return false end
	local a = pts[1]
	for i = 2, #pts do
		local b = pts[i]
		if b[1] ~= a[1] or b[2] ~= a[2] or b[3] ~= a[3] then return true end
	end
	return false
end

-- Whether the lines stand in for the trail: on, and a leg they can draw.
function RouteLines.Active()
	if not ns.Get("nav.routeLines") then return false end
	local geometry = Nav and Nav.GetRouteGeometry and Nav.GetRouteGeometry()
	local legs = type(geometry) == "table" and geometry.legs
	if type(legs) ~= "table" then return false end
	for i = 1, #legs do
		if RouteLines.Drawable(legs[i]) then return true end
	end
	return false
end

-- The draw paths (tests and diagnostics).
function RouteLines.GetPaths()
	return paths
end

---------------------------------------------------------------------------
-- Painting: each stroke on its own pooled pair of lines, the outline under
-- the core; pairs left over are hidden.
---------------------------------------------------------------------------

-- Pooled lines swap between a flat colour and the dot texture only when their
-- use changes, and start from the whole texture each time (SPF's pooled
-- zeppelin icon kept old texture coordinates: NAV_QA C12).
local function texture(owner, index, dot)
	if owner.dots[index] == dot then return end
	owner.dots[index] = dot
	local line, outline = owner.lines[index], owner.outlines[index]
	if dot then
		line:SetTexture(DOT_TEXTURE)
		outline:SetTexture(DOT_TEXTURE)
	else
		line:SetColorTexture(1, 1, 1, 1)
		outline:SetColorTexture(1, 1, 1, 1)
	end
	line:SetTexCoord(0, 1, 0, 1)
	outline:SetTexCoord(0, 1, 0, 1)
end

local function paint(owner, strokes)
	local lines, outlines = owner.lines, owner.outlines
	for index = 1, strokes.n do
		local line, outline = lines[index], outlines[index]
		if not line then
			outline = owner:CreateLine(nil, "ARTWORK", nil, -1)
			line = owner:CreateLine(nil, "ARTWORK")
			lines[index], outlines[index] = line, outline
		end
		texture(owner, index, strokes.dot[index])
		local x1, y1, x2, y2 = strokes.x1[index], strokes.y1[index], strokes.x2[index], strokes.y2[index]
		local ux, uy, alpha = strokes.ux[index], strokes.uy[index], strokes.alpha[index]
		outline:SetAlpha(alpha * UNDER_ALPHA)
		outline:SetThickness(strokes.under[index])
		outline:SetStartPoint("TOPLEFT", owner, x1 - ux, y1 - uy)
		outline:SetEndPoint("TOPLEFT", owner, x2 + ux, y2 + uy)
		outline:SetVertexColor(under[1], under[2], under[3]) -- the theme's scrim, re-read on every paint
		outline:Show()
		local c = strokes.color[index]
		line:SetVertexColor(c[1], c[2], c[3])
		line:SetAlpha(alpha)
		line:SetThickness(strokes.width[index])
		line:SetStartPoint("TOPLEFT", owner, x1, y1)
		line:SetEndPoint("TOPLEFT", owner, x2, y2)
		line:Show()
	end
	for index = strokes.n + 1, owner.used do
		lines[index]:Hide()
		outlines[index]:Hide()
	end
	owner.used = strokes.n
end

local function newOwner(owner)
	owner.lines, owner.outlines, owner.dots, owner.used = {}, {}, {}, 0
	-- Per sparkle: its colour (the table, and the revision it was set at:
	-- route colours change in place with the theme) and whether its halo shows.
	owner.stars, owner.halos, owner.sparkles, owner.tints, owner.tinted, owner.glows = {}, {}, 0, {}, {}, {}
	return owner
end

---------------------------------------------------------------------------
-- Sparkles: a star over a soft halo per sparkle, pooled per frame as the
-- lines are, created on demand and only ever hidden. A draw sets what moves
-- (place, size, alpha, rotation); colour and Show only when they change.
---------------------------------------------------------------------------

local rotates = true -- SetRotation on a texture; off for good once it fails

local function sparkle(owner, i, x, y, size, alpha, rotation, c)
	local star, halo = owner.stars[i], owner.halos[i]
	if not star then
		halo = owner:CreateTexture(nil, "ARTWORK", nil, 1)
		halo:SetTexture(GLOW_TEXTURE)
		halo:SetBlendMode("ADD")
		halo:Hide()
		star = owner:CreateTexture(nil, "ARTWORK", nil, 2)
		star:SetTexture(SPARKLE_TEXTURE)
		star:SetBlendMode("ADD")
		owner.stars[i], owner.halos[i] = star, halo
	end
	if owner.tints[i] ~= c or owner.tinted[i] ~= revision then
		owner.tints[i], owner.tinted[i] = c, revision
		star:SetVertexColor(c[1], c[2], c[3])
		halo:SetVertexColor(c[1], c[2], c[3])
	end
	star:ClearAllPoints()
	star:SetPoint("CENTER", owner, "TOPLEFT", x, y)
	star:SetSize(size, size)
	star:SetAlpha(alpha)
	if rotates and star.SetRotation and not pcall(star.SetRotation, star, rotation) then rotates = false end
	if i > owner.sparkles then star:Show() end -- the last draw showed 1..owner.sparkles
	local st = sparkleStyle
	local h = st.alpha > 0 and st.halo * alpha / st.alpha or 0
	if h > 0.01 then
		halo:ClearAllPoints()
		halo:SetPoint("CENTER", owner, "TOPLEFT", x, y)
		halo:SetSize(size * 2.2, size * 2.2)
		halo:SetAlpha(h)
		if not owner.glows[i] then
			owner.glows[i] = true
			halo:Show()
		end
	elseif owner.glows[i] then
		owner.glows[i] = false
		halo:Hide()
	end
end

local function finishSparkles(owner, used)
	local glows = owner.glows
	for i = used + 1, owner.sparkles do
		owner.stars[i]:Hide()
		if glows[i] then
			glows[i] = false
			owner.halos[i]:Hide()
		end
	end
	owner.sparkles = used
end

-- A run's colour: the style's, or its leg's (the dots' colours), and how
-- strongly it shows (the legs after this one recede, as the dots do).
local function runLook(run)
	return sparkleStyle.color or colors[run.kind] or colors.walk, run.later and Strokes.LATER_ALPHA or 1
end

---------------------------------------------------------------------------
-- The world map: one frame the size of the canvas, under every pin.
---------------------------------------------------------------------------

local worldStrokes = Strokes.New()
local view, worldPin -- the world map's view; the frame the strokes are painted on
local bounds = {} -- uiMapID -> { c, left, top, kx, ky } | false

local mapView = { width = 0, height = 0, scale = 1, small = false, marks = {}, markCount = 0, colors = colors }

local function boundsOf(mapID)
	local b = bounds[mapID]
	if b ~= nil then return b or nil end
	local C = ns.Compat
	if not (C and C.MapToWorld) then return nil end
	local c1, top, left = C.MapToWorld(mapID, 0, 0)
	local c2, bottom, right = C.MapToWorld(mapID, 100, 100)
	if c1 and c1 == c2 and top ~= bottom and left ~= right then
		b = { c = c1, left = left, top = top, kx = 1 / (right - left), ky = 1 / (bottom - top) }
		bounds[mapID] = b
		return b
	end
	-- Live API failed for this zone map (e.g. a client where GetWorldPosFromMapPos only
	-- covers continent maps): fall back to the Era-frame bounds that the route points use.
	c1, top, left = C.MapToWorld(mapID, 0, 0, "e")
	c2, bottom, right = C.MapToWorld(mapID, 100, 100, "e")
	if c1 and c1 == c2 and top ~= bottom and left ~= right then
		b = { c = c1, left = left, top = top, kx = 1 / (right - left), ky = 1 / (bottom - top) }
		bounds[mapID] = b
		return b
	end
	-- No bounds yet (map not open or not in data); don't cache the failure so
	-- drawWorld retries when the map is actually opened.
	return nil
end

-- A continent map: its dots are smaller. (Bigger maps span continents and
-- have no bounds, so nothing is drawn there.)
local function isSmall(mapID)
	local C = ns.Compat
	return C and C.GetContinentMap and C.GetContinentMap(mapID) == mapID or false
end

-- The live start of the walk being walked: progress along it only moves on.
-- Shared by both surfaces; returns true when the point ahead changed.
local function advance(pc, px, py)
	local first = paths[1]
	if not (first and first.kind == "walk" and not first.later and pc) then
		if live then live = nil; return true end
		return false
	end
	local i = Strokes.Live(first, pc, px, py, live, LIVE_REACH)
	if i then
		local moved = i ~= live
		live, liveC, liveX, liveY = i, pc, px, py
		return moved
	end
	return false
end

-- OpenMap (OpenMapAPI, its docs/api.md v2) stitches the world into one map
-- on the world map's canvas; while it does, a world point's place on the
-- canvas is its CanvasFromWorldPos (fractions of the canvas, and past them
-- where the view shows beyond it), and its art reaches ArtTopLevel. Only read.
local function openMap()
	local O = _G.OpenMapAPI
	if type(O) ~= "table" or type(O.CanvasFromWorldPos) ~= "function" or type(O.IsStitched) ~= "function" then return nil end
	local ok, stitched = pcall(O.IsStitched)
	return ok and stitched and O or nil
end

-- What the open map shows as a projector (O: OpenMap's API while it
-- stitches): project(c, wx, wy) -> canvas fractions u, v or nil; the canvas
-- units a yard spans near (c, wx, wy); the range of u, v worth drawing in.
local function projector(O, c, wx, wy, width, height)
	if O then
		local project = function(pc, x, y)
			local ok, u, v = pcall(O.CanvasFromWorldPos, pc, x, y)
			if ok and type(u) == "number" and type(v) == "number" then return u, v end
		end
		local u1, v1 = project(c, wx, wy)
		local u2, v2 = project(c, wx + 100, wy)
		if not (u1 and u2) then return nil end
		local du, dv = (u2 - u1) * width, (v2 - v1) * height
		local perYard = math.sqrt(du * du + dv * dv) / 100
		if perYard <= 0 then return nil end
		return project, perYard, -1, 2
	end
	local b = view.mapID and boundsOf(view.mapID)
	if not b then return nil end
	local project = function(pc, x, y)
		if pc ~= b.c then return nil end
		return (y - b.left) * b.kx, (x - b.top) * b.ky
	end
	return project, (width * abs(b.kx) + height * abs(b.ky)) / 2, 0, 1
end

-- The world map's projection and every run's points on it (us[i], vs[i] for
-- runs[i]), worked out again only when the route, the map, the canvas size
-- or OpenMap's stitching changes, so a 30 Hz draw only reads them.
local projection = { us = {}, vs = {} }

local function worldProjection(width, height)
	local P, O = projection, openMap()
	if P.project and P.revision == revision and P.O == O and P.mapID == view.mapID and P.width == width and P.height == height then
		return P
	end
	-- Nothing kept until a projection works (OpenMap's may not answer yet).
	P.project = nil
	local ref = runs[1]
	if not ref then return nil end
	local project, perYard, lo, hi = projector(O, ref.c, ref.xs[1], ref.ys[1], width, height)
	if not project then return nil end
	P.revision, P.O, P.mapID, P.width, P.height = revision, O, view.mapID, width, height
	P.project, P.perYard, P.lo, P.hi = project, perYard, lo, hi
	for i = 1, #runs do
		local run, us, vs = runs[i], P.us[i] or {}, P.vs[i] or {}
		P.us[i], P.vs[i] = us, vs
		for j = 1, run.n do us[j], vs[j] = project(run.c, run.xs[j], run.ys[j]) end
	end
	return P
end

local spans = {} -- Sparkle.Spans' stretches, reused by every draw

-- One world map draw, for worldSparkle (Sparkle.Emit's fn: no closure per draw).
local worldDraw = { used = 0 }

local function worldSparkle(wx, wy, k, nx, ny, fade)
	local d, st = worldDraw, sparkleStyle
	local alpha, scale, rotation, side = Sparkle.Twinkle(k, d.now, st, fade)
	alpha = alpha * d.strength
	if alpha <= 0.01 then return end
	local s = d.size * scale
	local shift = side * st.jitter * s / d.perYard
	local u, v = d.project(d.c, wx + nx * shift, wy + ny * shift)
	local lo, hi = d.lo, d.hi
	if u and u >= lo and u <= hi and v >= lo and v <= hi then
		local used = d.used + 1
		d.used = used
		sparkle(d.pin, used, u * d.width, -v * d.height, s, alpha, rotation, d.color)
		if used >= st.max then return false end
	end
end

local function drawWorldSparkles(pin)
	local d = worldDraw
	d.used = 0
	local width, height = view.width or 0, view.height or 0
	local P = width > 0 and height > 0 and worldProjection(width, height) or nil
	if P then
		pin:SetSize(width, height)
		local level = view:Level("PIN_FRAME_LEVEL_QUEST_BLOB")
		local O = P.O
		if O and type(O.ArtTopLevel) == "function" then
			local ok, top = pcall(O.ArtTopLevel)
			if ok and type(top) == "number" and top + 1 > level then level = top + 1 end
		end
		if pin:GetFrameLevel() ~= level then pin:SetFrameLevel(level) end
		local st = sparkleStyle
		local now = sparkleClock()
		local at = sparklePhase(now)
		-- Sizes and spacing hold on screen while the canvas zooms under them, as the pins' do.
		local zoom = view.scale and view.scale > 0 and view.scale or 1
		d.pin, d.now, d.size, d.perYard, d.project = pin, now, st.size / zoom, P.perYard, P.project
		d.lo, d.hi, d.width, d.height = P.lo, P.hi, width, height
		local spacing = st.spacing / zoom / P.perYard
		-- Only the stretches that reach the canvas, with room for a sparkle's
		-- jitter off the run (doubled: OpenMap's yards needn't be the same size everywhere).
		local margin = 2 * st.jitter * 1.2 * d.size + 1
		local mu, mv = margin / width, margin / height
		local x1, x2, y1, y2 = P.lo - mu, P.hi + mu, P.lo - mv, P.hi + mv
		local mapAlpha = view.alpha or 1
		local budget = SPARKLE_SCAN
		for i = 1, #runs do
			if d.used >= st.max or budget <= 0 then break end
			local run = runs[i]
			local c, strength = runLook(run)
			d.color, d.strength, d.c = c, strength * mapAlpha, run.c
			local from = runFrom[i] or 0
			for j = 1, Sparkle.Spans(run, P.us[i], P.vs[i], x1, x2, y1, y2, spans) do
				budget = budget - Sparkle.Emit(run, from, spacing, at, budget, worldSparkle, spans[j * 2 - 1], spans[j * 2])
				if d.used >= st.max or budget <= 0 then break end
			end
		end
	end
	finishSparkles(pin, d.used)
end

local function drawWorld(pin)
	if sparkling then
		if pin.used > 0 then
			worldStrokes.n = 0
			paint(pin, worldStrokes)
		end
		drawWorldSparkles(pin)
		pin.revision = revision
		return
	end
	finishSparkles(pin, 0)
	local mapID = view.mapID
	local b = mapID and boundsOf(mapID)
	if not b then
		worldStrokes.n = 0
		paint(pin, worldStrokes)
		return
	end
	local width, height = view.width, view.height
	pin:SetSize(width, height)
	local zoom = view.scale
	local v = mapView
	v.c, v.left, v.top, v.kx, v.ky = b.c, b.left, b.top, b.kx, b.ky
	v.width, v.height, v.scale, v.small = width, height, pin:GetEffectiveScale(), isSmall(mapID)
	-- Polestar's pins keep their size on screen while the canvas zooms under them.
	local vm, n = v.marks, 0
	for i = 1, markCount * 4, 4 do
		if marks[i] == b.c then
			vm[n * 3 + 1] = (marks[i + 2] - b.left) * b.kx
			vm[n * 3 + 2] = (marks[i + 1] - b.top) * b.ky
			vm[n * 3 + 3] = marks[i + 3] / zoom
			n = n + 1
		end
	end
	v.markCount = n
	-- The walk being walked starts at the player, with or without the minimap.
	local pc, px, py = playerPosition()
	advance(pc, px, py)
	pin.drawnX, pin.drawnY = px, py
	v.from, v.fromIndex, v.fromC, v.fromX, v.fromY = live ~= nil, live, liveC, liveX, liveY
	Strokes.Map(worldStrokes, paths, v)
	paint(pin, worldStrokes)
	pin.revision = revision
end

-- While the map shows the pin (OnUpdate runs only then): redraw when the
-- player has walked on along the current walk.
local WORLD_INTERVAL, WORLD_MOVED = 0.25, 10
local function worldTick(pin, elapsed)
	pin.elapsed = (pin.elapsed or 0) + elapsed
	if sparkling then
		if pin.elapsed < SPARKLE_INTERVAL then return end
		pin.elapsed = 0
		local now = sparkleClock()
		if now - progressAt >= PROGRESS_INTERVAL then
			progressAt = now
			sparkleProgress()
		end
		drawWorldSparkles(pin)
		return
	end
	if pin.elapsed < WORLD_INTERVAL then return end
	pin.elapsed = 0
	local first = paths[1]
	if not (first and first.kind == "walk" and not first.later) then return end
	local pc, px, py = playerPosition()
	if not pc then return end
	local dx, dy = px - (pin.drawnX or px), py - (pin.drawnY or py)
	if advance(pc, px, py) or (live and dx * dx + dy * dy >= WORLD_MOVED * WORLD_MOVED) then drawWorld(pin) end
end

-- The frame for the strokes: on the canvas at its top left, under every pin,
-- no mouse; its OnUpdate runs only while the map shows it.
local function ensureWorldPin()
	if worldPin then return worldPin end
	local canvas = view.canvas
	worldPin = newOwner(ns.CreateFrameUnder("Frame", nil, canvas))
	worldPin:SetPoint("TOPLEFT", canvas, "TOPLEFT", 0, 0)
	worldPin:EnableMouse(false)
	worldPin:SetScript("OnUpdate", ns.Safe(worldTick))
	return worldPin
end

-- The open map shows the strokes when there is a route for it (nothing is
-- made before then); a closed map draws as it opens.
local function refreshWorld()
	if not (view and view.shown) then return end
	local world = surfaces()
	if world and #paths > 0 then
		local pin = ensureWorldPin()
		pin:SetFrameLevel(view:Level("PIN_FRAME_LEVEL_QUEST_BLOB"))
		pin:Show()
		drawWorld(pin)
	elseif worldPin then
		worldStrokes.n = 0
		paint(worldPin, worldStrokes)
		worldPin:Hide()
	end
end

local function installWorld()
	if view then return true end
	local M = ns.MapCanvas
	view = WorldMapFrame and M and M.Watch(WorldMapFrame, function(_, what)
		if what == "show" or what == "map" or what == "size" or what == "scale" then refreshWorld() end
	end) or nil
	return view ~= nil
end

---------------------------------------------------------------------------
-- The minimap: one frame over its face, just under Polestar.Pins' trail and pins.
---------------------------------------------------------------------------

local minimapStrokes = Strokes.New(MINIMAP_LIMIT)
local mm, driver
local minimapView = { width = 0, height = 0, scale = 1, colors = colors }
local last = {}
local elapsedSince = 0

-- One minimap draw, for minimapSparkle (Sparkle.Emit's fn).
local minimapDraw = { used = 0 }

local function minimapSparkle(wx, wy, k, nx, ny, fade)
	local d, st = minimapDraw, sparkleStyle
	local alpha, scale, rotation, side = Sparkle.Twinkle(k, d.now, st, fade)
	alpha = alpha * d.strength
	if alpha <= 0.01 then return end
	local s = st.size * scale
	local shift = side * st.jitter * s / d.perYard
	local x, y = Strokes.Project(wx + nx * shift, wy + ny * shift, d.px, d.py, d.radius, d.cosine, d.sine)
	if Sparkle.OnFace(x, y, d.square, d.inset) then
		local used = d.used + 1
		d.used = used
		sparkle(mm, used, (x + 1) * d.width / 2, (y - 1) * d.height / 2, s, alpha, rotation, d.color)
		if used >= st.max then return false end
	end
end

local function drawMinimapSparkles(pc, px, py, radius, facing, square, width, height)
	local d = minimapDraw
	d.used = 0
	local half = width / 2
	if pc and radius and radius > 0 and half > 0 and #runs > 0 then
		local st = sparkleStyle
		local now = sparkleClock()
		local at = sparklePhase(now)
		local perYard = half / radius
		local spacing = st.spacing / perYard
		d.now, d.perYard, d.px, d.py, d.radius, d.square, d.width, d.height = now, perYard, px, py, radius, square, width, height
		d.inset = 1 - st.size / 2 / half
		d.cosine, d.sine = cos(facing or 0), sin(facing or 0)
		-- Only the stretches near the player: the face, turned any way, lies
		-- within radius * sqrt(2), and a sparkle on it up to its jitter off the run.
		local reach = radius * 1.415 + st.jitter * 1.2 * st.size / perYard + 1
		local x1, x2, y1, y2 = px - reach, px + reach, py - reach, py + reach
		local budget = SPARKLE_SCAN
		for i = 1, #runs do
			local run = runs[i]
			if d.used >= st.max or budget <= 0 then break end
			if run.c == pc then
				d.color, d.strength = runLook(run)
				local from = runFrom[i] or 0
				for j = 1, Sparkle.Spans(run, run.xs, run.ys, x1, x2, y1, y2, spans) do
					budget = budget - Sparkle.Emit(run, from, spacing, at, budget, minimapSparkle, spans[j * 2 - 1], spans[j * 2])
					if d.used >= st.max or budget <= 0 then break end
				end
			end
		end
	end
	finishSparkles(mm, d.used)
end

local function drawMinimap(force)
	local C = ns.Compat
	local pc, px, py
	if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	local radius, facing, square = ns.Pins.MinimapView()
	-- An unreadable (secret) position or facing hides the line, with no error (NAV_QA C5).
	local secret = C and C.IsSecret
	if secret and (secret(pc) or secret(px) or secret(py) or secret(radius) or secret(facing)) then
		if minimapStrokes.n > 0 then
			minimapStrokes.n = 0
			paint(mm, minimapStrokes)
		end
		finishSparkles(mm, 0)
		last.revision = nil
		return
	end
	-- mm covers the minimap (SetAllPoints): its size is the minimap's.
	local width, height, scale = Minimap:GetWidth(), Minimap:GetHeight(), mm:GetEffectiveScale()
	if sparkling then
		if minimapStrokes.n > 0 then
			minimapStrokes.n = 0
			paint(mm, minimapStrokes)
		end
		last.revision = nil
		drawMinimapSparkles(pc, px, py, radius, facing, square, width, height)
		return
	end
	finishSparkles(mm, 0)
	if not force and last.c == pc and last.x == px and last.y == py and last.radius == radius and last.facing == facing
		and last.square == square and last.width == width and last.height == height and last.scale == scale
		and last.revision == revision then
		return
	end
	last.c, last.x, last.y, last.radius, last.facing, last.square = pc, px, py, radius, facing, square
	last.width, last.height, last.scale, last.revision = width, height, scale, revision
	if advance(pc, px, py) and worldPin and worldPin:IsShown() and view and view.shown then drawWorld(worldPin) end
	local v = minimapView
	v.c, v.x, v.y, v.radius, v.facing, v.square = pc, px, py, radius, facing, square
	v.width, v.height, v.scale = width, height, scale
	v.goalC, v.goalX, v.goalY, v.goalRadius = goalC, goalX, goalY, MINIMAP_GOAL
	v.from, v.fromIndex, v.fromC, v.fromX, v.fromY = live ~= nil, live, liveC, liveX, liveY
	Strokes.Minimap(minimapStrokes, paths, v)
	paint(mm, minimapStrokes)
end

local function tick(_, elapsed)
	elapsedSince = elapsedSince + elapsed
	if elapsedSince < (sparkling and SPARKLE_INTERVAL or DRIVE_INTERVAL) then return end
	elapsedSince = 0
	if sparkling then
		local now = sparkleClock()
		if now - progressAt >= PROGRESS_INTERVAL then
			progressAt = now
			sparkleProgress()
		end
	end
	drawMinimap(false)
end

local function ensureMinimap()
	if mm or not Minimap then return mm ~= nil end
	mm = newOwner(ns.CreateFrameUnder("Frame", nil, Minimap))
	mm:SetAllPoints(Minimap)
	mm:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 3)
	mm:EnableMouse(false)
	driver = ns.CreateFrameUnder("Frame", nil, mm)
	driver:SetScript("OnUpdate", ns.Safe(tick))
	return true
end

local function refreshMinimap()
	local _, minimap = surfaces()
	if not (minimap and #paths > 0) then
		if mm then
			minimapStrokes.n = 0
			paint(mm, minimapStrokes)
			mm:Hide()
		end
		return
	end
	if not ensureMinimap() then return end
	mm:Show()
	drawMinimap(true)
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

local function recolor()
	local T = ns.Theme
	for kind, token in pairs(TOKEN) do
		local c = colors[kind]
		if T and T.Color then c[1], c[2], c[3] = T.Color(token) end
	end
	if T and T.Color then under[1], under[2], under[3] = T.Color("scrim") end
end

function RouteLines.Refresh()
	restyle()
	rebuild()
	rebuildRuns()
	revision = revision + 1
	installWorld()
	refreshWorld()
	refreshMinimap()
end

-- The world map frame the strokes are painted on (hidden while there is
-- nothing to draw), or nil before the first (tests and diagnostics).
function RouteLines.GetWorldFrame()
	return worldPin
end

-- Strokes drawn on a surface ("world" | "minimap"): the buffer the painter
-- last copied (tests and diagnostics).
function RouteLines.GetStrokes(surface)
	return surface == "minimap" and minimapStrokes or worldStrokes
end

-- The sparkles shown on a surface ("world" | "minimap") and the runs they
-- sit on, while nav.lineStyle is "sparkle" (tests and diagnostics).
function RouteLines.GetSparkles(surface)
	local owner = surface == "minimap" and mm or worldPin
	return owner and owner:IsShown() and owner.sparkles or 0, runs
end

-- Put the sparkle settings to one of Sparkle.PRESETS ("subtle", "default",
-- "dazzling"). -> true when it is one
function RouteLines.ApplySparklePreset(name)
	local preset = Sparkle and Sparkle.PRESETS[name]
	if not preset then return false end
	for key, value in pairs(preset) do ns.Set("nav." .. key, value) end
	return true
end

ns.On("NAV_ROUTE_GEOMETRY", function()
	if ns.IsLoggedIn() then RouteLines.Refresh() end
end)

local WATCH = {
	["nav.routeLines"] = true, ["nav.worldPins"] = true, ["nav.minimapPins"] = true, ["nav"] = true, [""] = true,
	["nav.lineStyle"] = true, ["nav.sparkleLater"] = true,
}
ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if WATCH[path] then
		RouteLines.Refresh()
	elseif sparkling and type(path) == "string" and Sparkle.DEFAULTS[path:match("^nav%.(.+)$") or ""] ~= nil then
		-- The look alone: the sparkles move, so the next draw shows it.
		restyle()
	end
end)

ns.OnLogin(function()
	local T = ns.Theme
	if T and T.OnChanged then
		T.OnChanged(function()
			recolor()
			revision = revision + 1
			refreshWorld()
			refreshMinimap()
		end)
	end
	recolor()
	RouteLines.Refresh()
	-- Blizzard_WorldMap may load after login: watch the map when it does,
	-- as Polestar.Pins does (review P3-8).
	if view then return end
	local function onLoaded(_, name)
		if name == "Blizzard_WorldMap" and installWorld() then
			ns.UnregisterEvent("ADDON_LOADED", onLoaded)
			refreshWorld()
		end
	end
	ns.RegisterEvent("ADDON_LOADED", onLoaded)
end)
