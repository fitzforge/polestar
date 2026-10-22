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
-- The route comes alive on the world map (each its own setting):
--   nav.lineFlow      the breadcrumbs crawl on toward the goal and glints run
--                     along every ride (a 20 Hz redraw while the map shows them;
--                     still with ui.reduceMotion)
--   nav.lineLabels    each leg's kind, length and time at its middle (a walk's
--                     time only with nav.lineWalkTime)
--   nav.stepPreview   the goals of the next PREVIEW_STEPS steps after the
--                     target, joined by a faint dashed line, numbered
--   maps.travelNetwork
--                     every flight this character knows and every boat,
--                     zeppelin and tram it may ride, faint, under the route
-- On OpenMap's stitched map (Nav/OpenMap.lua) all of it runs on across every
-- zone and continent the view shows.
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

local type, ipairs, pairs, abs, cos, sin, pcall, format, tostring = type, ipairs, pairs, math.abs, math.cos, math.sin, pcall, string.format, tostring
local L = ns.L

local RouteLines = {}
ns.RouteLines = RouteLines

ns.RegisterDefaults("nav", { routeLines = true, lineStyle = "dots", lineFlow = true, lineLabels = true, lineWalkTime = true, stepPreview = true })
ns.RegisterDefaults("maps", { travelNetwork = false })
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

-- Theme tokens per leg kind (the same as the travel pins': Maps/TravelPins.lua);
-- preview: the steps after the target.
local TOKEN = { walk = "arrow", flight = "success", boat = "npc", zeppelin = "place", tram = "object", lift = "object", preview = "accent" }
local colors = {}
for kind in pairs(TOKEN) do colors[kind] = { 1, 1, 1 } end
local under = { 0.02, 0.03, 0.06 }
local glint = { 1, 1, 1 } -- the flow's glints (the theme's ink)

local FLOW_PERIOD = 1.4      -- seconds for the flow to move on one spacing
local FLOW_INTERVAL = 1 / 20 -- its redraws a second
local PREVIEW_STEPS = 5      -- steps after the target the preview reaches
local NETWORK_DIM = 0.35     -- the travel network's strength

-- The flow's phase now: 0..1 of a spacing (0 and still with ui.reduceMotion).
local function flowPhase()
	if ns.Get("ui.reduceMotion") or not GetTime then return 0 end
	return (GetTime() / FLOW_PERIOD) % 1
end

local function flowing()
	return ns.Get("nav.lineFlow") and not ns.Get("ui.reduceMotion") and true or false
end

---------------------------------------------------------------------------
-- The route as draw paths
---------------------------------------------------------------------------

local paths = {}          -- Strokes.Path per drawable leg, in travel order, then the step preview
local labels = {}         -- { c, wx, wy, text, kind } per label: legs' middles, the preview's numbers
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

-- A path's middle by length: c, wx, wy (on its longest continent run's way).
local function middle(path)
	local total = 0
	for i = 2, path.n do
		if path.c[i] == path.c[i - 1] then total = total + math.sqrt((path.x[i] - path.x[i - 1]) ^ 2 + (path.y[i] - path.y[i - 1]) ^ 2) end
	end
	local half, run = total / 2, 0
	for i = 2, path.n do
		if path.c[i] == path.c[i - 1] then
			local d = math.sqrt((path.x[i] - path.x[i - 1]) ^ 2 + (path.y[i] - path.y[i - 1]) ^ 2)
			if run + d >= half and d > 0 then
				local t = (half - run) / d
				return path.c[i], path.x[i - 1] + (path.x[i] - path.x[i - 1]) * t, path.y[i - 1] + (path.y[i] - path.y[i - 1]) * t, total
			end
			run = run + d
		end
	end
	return path.c[1], path.x[1], path.y[1], total
end

local KIND_LABEL = {
	walk = L["Walk"], flight = L["Flight"], boat = L["Boat"], zeppelin = L["Zeppelin"], tram = L["Deeprun Tram"], lift = L["Lift"],
}

-- The route leg ending where a path ends (Nav.GetRoute's legs carry the time).
local function legEnding(c, wx, wy)
	local legs = Nav.GetRoute and Nav.GetRoute()
	for _, leg in ipairs(legs or {}) do
		local to = leg.to
		if to and to.c == c and abs(to.wx - wx) < 1 and abs(to.wy - wy) < 1 then return leg end
	end
end

-- A label: on a path (placed along it at draw time), or at a point.
local function addLabel(c, wx, wy, text, kind, path)
	labels[#labels + 1] = { c = c, wx = wx, wy = wy, text = text, kind = kind, path = path }
end

local function legLabels()
	local M = ns.Maps
	for _, path in ipairs(paths) do
		if KIND_LABEL[path.kind] and path.n >= 2 then
			local _, _, _, yards = middle(path)
			local leg = legEnding(path.c[path.n], path.x[path.n], path.y[path.n])
			local text = KIND_LABEL[path.kind]
			if path.kind == "walk" and yards > 0 then text = text .. " · " .. format(L["%d yd"], yards) end
			local secs = leg and leg.seconds
			if path.kind == "walk" and not ns.Get("nav.lineWalkTime") then secs = nil end
			if secs and secs > 0 and M and M.FormatTime then text = text .. " · " .. M.FormatTime(secs) end
			addLabel(nil, nil, nil, text, path.kind, path)
		end
	end
end

-- The steps after the target: for each, of its open goals with a place, the
-- one nearest the point before (the route's end, then the step before's),
-- as a "preview" path labelled by step. A step whose goals are all done, or
-- have no place, is left out.
local DONE = { done = true, complete = true, completed = true, skipped = true }
local function stepPreview()
	local E, C = ns.Engine, ns.Compat
	if not (goalC and E and E.GetStepIndex and E.GetStepView and C and C.MapToWorld) then return end
	local index = E.GetStepIndex()
	if not index then return end
	local pts = { { goalC, goalX, goalY } }
	local last = (E.GetStepCount and E.GetStepCount() or index + PREVIEW_STEPS)
	for i = index + 1, math.min(last, index + PREVIEW_STEPS) do
		local view = E.GetStepView(i)
		local from = pts[#pts]
		local best, bestD
		for _, goal in ipairs(view and view.goals or {}) do
			if goal.map and goal.x and goal.y and not DONE[goal.status] then
				local c, wx, wy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
				if c then
					-- Another continent counts as far past anything on this one.
					local d = c == from[1] and (wx - from[2]) ^ 2 + (wy - from[3]) ^ 2 or math.huge
					if not best or d < bestD then best, bestD = { c, wx, wy }, d end
				end
			end
		end
		if best then
			pts[#pts + 1] = best
			addLabel(best[1], best[2], best[3], format(L["Step %d"], i), "preview")
		end
	end
	if #pts >= 2 then paths[#paths + 1] = Strokes.Path("preview", pts, true) end
end

local function rebuild()
	for i = #paths, 1, -1 do paths[i] = nil end
	for i = #labels, 1, -1 do labels[i] = nil end
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
	if ns.Get("nav.lineLabels") then legLabels() end
	if ns.Get("nav.stepPreview") then stepPreview() end
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
local drawLabels -- forward: the leg and step tags
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
	local O = ns.OpenMap and ns.OpenMap.Stitched()
	if not (O and type(O.CanvasFromWorldPos) == "function") then return nil end
	return O
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

-- On OpenMap's stitched map (Nav/OpenMap.lua): every continent of the route
-- as the host map places it (fractions), clipped to the view and a margin.
-- Fills v and returns true; false without OpenMap's map.
local VIEW_MARGIN = 0.05
local viewRect = { 0, 0, 0, 0 }
local function stitchedView(v, list)
	local OM = ns.OpenMap
	if not (OM and OM.Stitched()) then return false end
	local host = view.mapID
	v.fitTable = v.fitTable or {}
	local stitchedFits = v.fitTable
	for c in pairs(stitchedFits) do stitchedFits[c] = nil end
	local any = false
	for p = 1, #list do
		local cs = list[p].c
		for i = 1, list[p].n do
			local c = cs[i]
			if stitchedFits[c] == nil then
				local f = OM.Fit(host, c)
				stitchedFits[c] = f and { ub = f.ub / 100, uc = f.uc / 100, va = f.va / 100, vc = f.vc / 100 } or false
				any = any or f ~= nil
			end
		end
	end
	if not any then return false end
	for c, f in pairs(stitchedFits) do if not f then stitchedFits[c] = nil end end
	local x0, y0, x1, y1 = OM.ViewRect(view)
	viewRect[1], viewRect[2], viewRect[3], viewRect[4] = x0, y0, x1, y1
	local mx, my = (x1 - x0) * VIEW_MARGIN / 100, (y1 - y0) * VIEW_MARGIN / 100
	v.clip = v.clip or {}
	v.clip[1], v.clip[2], v.clip[3], v.clip[4] = x0 / 100 - mx, y0 / 100 - my, x1 / 100 + mx, y1 / 100 + my
	v.fits, v.c = stitchedFits, nil
	return true
end

---------------------------------------------------------------------------
-- Labels: plain outlined text in its leg's colour, the same size on screen
-- at any zoom, pooled on the world frame. A leg's sits beside the middle of
-- its line as drawn (a crossing's on its bow), the first of a few places
-- along it and to either side that keeps clear of the route's stops and of
-- the labels already placed; a leg too short on screen for its text has
-- none. A step's number sits on its point when that is clear.
---------------------------------------------------------------------------

local LABEL_GAP = 9          -- px between a leg's line and its label
local LABEL_ROOM = 1.3       -- a leg's line must be this many times its label's width
local ALONG = { 0.5, 0.35, 0.65, 0.2, 0.8 }

local function labelFrame(pin, i)
	pin.tags = pin.tags or {}
	local f = pin.tags[i]
	if f then return f end
	f = ns.CreateFrameUnder("Frame", nil, pin)
	f:EnableMouse(false)
	f.text = f:CreateFontString(nil, "OVERLAY")
	local T = ns.Theme
	if T and T.Font then T.Font(f.text, "note") else f.text:SetFontObject("GameFontHighlightSmall") end
	local font, size = f.text:GetFont()
	if font then f.text:SetFont(font, size or 12, "OUTLINE") end
	f.text:SetShadowOffset(1, -1)
	f.text:SetShadowColor(0, 0, 0, 0.9)
	f.text:SetPoint("CENTER")
	pin.tags[i] = f
	return f
end

-- Placed boxes this draw (canvas units, centre and half sizes) and the
-- route's stops as boxes of their mark's radius.
local boxes, boxCount = {}, 0
local function clear(x, y, hw, hh)
	for k = 1, boxCount * 4, 4 do
		if abs(x - boxes[k]) < hw + boxes[k + 2] and abs(y - boxes[k + 1]) < hh + boxes[k + 3] then return false end
	end
	return true
end
local function take(x, y, hw, hh)
	boxes[boxCount * 4 + 1], boxes[boxCount * 4 + 2], boxes[boxCount * 4 + 3], boxes[boxCount * 4 + 4] = x, y, hw, hh
	boxCount = boxCount + 1
end

-- A path as drawn, in canvas units: xs, ys (a crossing's bow sampled), and its length.
local px, py = {}, {}
local function projected(path, v, width, height)
	local n = 0
	local bow = path.n == 2 and (path.kind == "boat" or path.kind == "zeppelin")
	if bow then
		local ax, ay = Strokes.MapPosition(v, path.c[1], path.x[1], path.y[1])
		local bx, by = Strokes.MapPosition(v, path.c[2], path.x[2], path.y[2])
		if not (ax and bx) then return 0, 0 end
		local dx, dy = bx - ax, by - ay
		local side = dx < 0 and -1 or 1
		local cx, cy = (ax + bx) / 2 + dy * side * Strokes.BOW, (ay + by) / 2 - dx * side * Strokes.BOW
		for k = 0, 12 do
			local t = k / 12
			n = n + 1
			px[n] = ((1 - t) ^ 2 * ax + 2 * (1 - t) * t * cx + t ^ 2 * bx) * width
			py[n] = ((1 - t) ^ 2 * ay + 2 * (1 - t) * t * cy + t ^ 2 * by) * height
		end
	else
		for i = 1, path.n do
			local x, y = Strokes.MapPosition(v, path.c[i], path.x[i], path.y[i])
			if x then
				n = n + 1
				px[n], py[n] = x * width, y * height
			end
		end
	end
	local length = 0
	for k = 2, n do length = length + math.sqrt((px[k] - px[k - 1]) ^ 2 + (py[k] - py[k - 1]) ^ 2) end
	return n, length
end

-- The point `at` (0..1) along the projected path, and the unit normal there.
local function along(n, length, at)
	local want, run = length * at, 0
	for k = 2, n do
		local dx, dy = px[k] - px[k - 1], py[k] - py[k - 1]
		local d = math.sqrt(dx * dx + dy * dy)
		if d > 0 and run + d >= want then
			local t = (want - run) / d
			return px[k - 1] + dx * t, py[k - 1] + dy * t, -dy / d, dx / d
		end
		run = run + d
	end
	return px[n], py[n], 0, -1
end

drawLabels = function(pin, v)
	local used = 0
	boxCount = 0
	if v and v.width > 0 and (ns.Get("nav.lineLabels") or ns.Get("nav.stepPreview")) then
		local width, height = v.width, v.height
		local clip = v.clip
		local x0, y0, x1, y1 = 0, 0, width, height
		if clip then x0, y0, x1, y1 = clip[1] * width, clip[2] * height, clip[3] * width, clip[4] * height end
		local s = view and view.PinScale and view:PinScale(1, 1.25) or 1
		-- The route's stops and goal: their marks stay clear.
		local marks = v.marks
		for k = 1, (v.markCount or 0) * 3, 3 do
			local r = marks[k + 2] + 4 * s
			take(marks[k] * width, marks[k + 1] * height, r, r)
		end
		for _, l in ipairs(labels) do
			local f = labelFrame(pin, used + 1)
			local c = colors[l.kind] or colors.walk
			f.text:SetText(l.text)
			f.text:SetTextColor(c[1], c[2], c[3])
			local tw, th = f.text:GetStringWidth() or 0, f.text:GetStringHeight() or 10
			local hw, hh = (tw / 2 + 2) * s, (th / 2 + 1) * s
			local x, y
			if l.path then
				local n, length = projected(l.path, v, width, height)
				if n >= 2 and length >= hw * 2 * LABEL_ROOM then
					local gap = LABEL_GAP * s + hh
					for _, at in ipairs(ALONG) do
						local mx, my, nx, ny = along(n, length, at)
						for side = 1, -1, -2 do
							-- Beside the line: its normal, pushed out by the label's own half extent that way.
							local ox, oy = nx * side, ny * side
							local cx, cy = mx + ox * (gap + abs(ox) * (hw - hh)), my + oy * gap
							if cx >= x0 and cx <= x1 and cy >= y0 and cy <= y1 and clear(cx, cy, hw, hh) then
								x, y = cx, cy
								break
							end
						end
						if x then break end
					end
				end
			else
				local fx, fy = Strokes.MapPosition(v, l.c, l.wx, l.wy)
				if fx then
					local cx, cy = fx * width, fy * height - hh - 6 * s
					if cx >= x0 and cx <= x1 and cy >= y0 and cy <= y1 and clear(cx, cy, hw, hh) then x, y = cx, cy end
				end
			end
			if x then
				used = used + 1
				take(x, y, hw, hh)
				f:SetSize(tw + 4, th + 2)
				f:SetScale(s)
				f:ClearAllPoints()
				f:SetPoint("CENTER", pin, "TOPLEFT", x / s, -y / s)
				f:Show()
			end
		end
	end
	local tags = pin.tags
	if tags then
		for i = used + 1, #tags do tags[i]:Hide() end
	end
end

local function drawWorld(pin)
	if sparkling then
		drawLabels(pin, nil)
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
	local v = mapView
	local stitched = mapID and stitchedView(v, paths)
	local b = not stitched and mapID and boundsOf(mapID)
	if not (stitched or b) then
		worldStrokes.n = 0
		paint(pin, worldStrokes)
		return
	end
	local width, height = view.width, view.height
	pin:SetSize(width, height)
	local zoom = view.scale
	if b then
		v.c, v.left, v.top, v.kx, v.ky, v.fits, v.clip = b.c, b.left, b.top, b.kx, b.ky, nil, nil
	end
	v.width, v.height, v.scale, v.small = width, height, pin:GetEffectiveScale(), isSmall(mapID)
	-- Polestar's pins keep their size on screen while the canvas zooms under them.
	local vm, n = v.marks, 0
	for i = 1, markCount * 4, 4 do
		local x, y = Strokes.MapPosition(v, marks[i], marks[i + 1], marks[i + 2])
		if x then
			vm[n * 3 + 1], vm[n * 3 + 2], vm[n * 3 + 3] = x, y, marks[i + 3] / zoom
			n = n + 1
		end
	end
	v.markCount = n
	-- The walk being walked starts at the player, with or without the minimap.
	local pc, px, py = playerPosition()
	advance(pc, px, py)
	pin.drawnX, pin.drawnY = px, py
	v.from, v.fromIndex, v.fromC, v.fromX, v.fromY = live ~= nil, live, liveC, liveX, liveY
	local flow = ns.Get("nav.lineFlow")
	v.phase, v.glint = flow and flowPhase() or 0, flow and glint or nil
	Strokes.Map(worldStrokes, paths, v)
	paint(pin, worldStrokes)
	drawLabels(pin, v)
	pin.revision = revision
end

-- While the map shows the pin (OnUpdate runs only then): redraw when the
-- player has walked on along the current walk.
local WORLD_INTERVAL, WORLD_MOVED = 0.25, 10
local function worldTick(pin, elapsed)
	pin.elapsed = (pin.elapsed or 0) + elapsed
	if not sparkling and flowing() then
		if pin.elapsed < FLOW_INTERVAL then return end
		pin.elapsed = 0
		drawWorld(pin)
		return
	end
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
	if mapView.fits and ns.OpenMap.ViewMoved(view, viewRect) then
		pin.elapsed = 0
		drawWorld(pin)
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
	worldPin:SetScript("OnUpdate", worldTick)
	return worldPin
end

-- The open map shows the strokes when there is a route for it (nothing is
-- made before then); a closed map draws as it opens.
local function refreshWorld()
	if not (view and view.shown) then return end
	local world = surfaces()
	if world and #paths > 0 then
		local pin = ensureWorldPin()
		local level = view:Level("PIN_FRAME_LEVEL_QUEST_BLOB")
		pin:SetFrameLevel(ns.OpenMap and ns.OpenMap.Level(level) or level)
		pin:Show()
		drawWorld(pin)
	elseif worldPin then
		worldStrokes.n = 0
		paint(worldPin, worldStrokes)
		worldPin:Hide()
	end
end

---------------------------------------------------------------------------
-- The travel network (maps.travelNetwork): every flight this character knows
-- between flight masters it may use, along what the flight master flies,
-- and every boat, zeppelin and tram it may ride, faint, on a frame of its
-- own under the route. Built when the travel data or the known flight
-- masters change; drawn with the route's map, view and stitching.
---------------------------------------------------------------------------

local netPaths, netPin = {}, nil
local netStrokes = Strokes.New()
local netView = { width = 0, height = 0, scale = 1, small = false, marks = {}, markCount = 0, colors = colors, dim = NETWORK_DIM }

local function buildNetwork()
	for i = #netPaths, 1, -1 do netPaths[i] = nil end
	if not (ns.Maps and ns.Maps.LayerOn and ns.Maps.LayerOn("maps.travelNetwork")) then return end
	local M = ns.Maps
	local data = Nav.GetTravelData and Nav.GetTravelData()
	if not (data and M and M.Allowed and M.Faction) then return end
	local faction = M.Faction()
	local known = Nav.GetKnownTaxiNodes and Nav.GetKnownTaxiNodes() or {}
	for _, node in ipairs(data.taxi or {}) do
		if known[node.id] and M.Allowed(node.faction, faction) then
			local legs = data.flights and data.flights[node.id]
			for i = 1, legs and #legs - 1 or 0, 2 do
				local dest = data.taxiById and data.taxiById[legs[i]]
				if dest and dest.id > node.id and known[dest.id] and M.Allowed(dest.faction, faction) then
					netPaths[#netPaths + 1] = Strokes.Path("flight", { { node.c, node.wx, node.wy }, { dest.c, dest.wx, dest.wy } },
						false, ns.FlightTracks, { node.id, dest.id })
				end
			end
		end
	end
	for _, t in ipairs(data.transports or {}) do
		if M.Allowed(t.faction, faction) and t.a and t.b and colors[t.kind] then
			netPaths[#netPaths + 1] = Strokes.Path(t.kind, { { t.a.c, t.a.wx, t.a.wy }, { t.b.c, t.b.wx, t.b.wy } }, false)
		end
	end
end

local function drawNetwork()
	if not (view and view.shown) then return end
	if #netPaths == 0 then
		if netPin then
			netStrokes.n = 0
			paint(netPin, netStrokes)
			netPin:Hide()
		end
		return
	end
	if not netPin then
		netPin = newOwner(ns.CreateFrameUnder("Frame", nil, view.canvas))
		netPin:SetPoint("TOPLEFT", view.canvas, "TOPLEFT", 0, 0)
		netPin:EnableMouse(false)
		netPin:SetScript("OnUpdate", function(self, elapsed)
			self.elapsed = (self.elapsed or 0) + elapsed
			if self.elapsed < WORLD_INTERVAL then return end
			self.elapsed = 0
			if netView.fits and ns.OpenMap.ViewMoved(view, self.rect) then drawNetwork() end
		end)
	end
	local level = view:Level("PIN_FRAME_LEVEL_QUEST_BLOB")
	level = ns.OpenMap and ns.OpenMap.Level(level) or level
	netPin:SetFrameLevel(level > 1 and level - 1 or level)
	local mapID = view.mapID
	local v = netView
	local stitched = mapID and stitchedView(v, netPaths)
	local b = not stitched and mapID and boundsOf(mapID)
	if not (stitched or b) then
		netStrokes.n = 0
		paint(netPin, netStrokes)
		return
	end
	if b then v.c, v.left, v.top, v.kx, v.ky, v.fits, v.clip = b.c, b.left, b.top, b.kx, b.ky, nil, nil end
	netPin.rect = netPin.rect or {}
	netPin.rect[1], netPin.rect[2], netPin.rect[3], netPin.rect[4] = viewRect[1], viewRect[2], viewRect[3], viewRect[4]
	v.width, v.height, v.scale, v.small = view.width, view.height, netPin:GetEffectiveScale(), isSmall(mapID)
	netPin:SetSize(view.width, view.height)
	netPin:Show()
	Strokes.Map(netStrokes, netPaths, v)
	paint(netPin, netStrokes)
end

function RouteLines.RefreshNetwork()
	buildNetwork()
	drawNetwork()
end

-- The network's strokes (tests and diagnostics).
function RouteLines.GetNetwork()
	return netStrokes, netPaths
end

-- OpenMap's stitched map came or went: the lines move to it, or back.
if ns.OpenMap then ns.OpenMap.OnChange(function() refreshWorld(); drawNetwork() end) end

local function installWorld()
	if view then return true end
	local M = ns.MapCanvas
	view = WorldMapFrame and M and M.Watch(WorldMapFrame, function(_, what)
		if what == "show" or what == "map" or what == "size" or what == "scale" then
			refreshWorld()
			drawNetwork()
		end
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
	driver:SetScript("OnUpdate", tick)
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
	if T and T.Color then
		under[1], under[2], under[3] = T.Color("scrim")
		glint[1], glint[2], glint[3] = T.Color("ink")
	end
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
	["nav.lineFlow"] = true, ["nav.lineLabels"] = true, ["nav.lineWalkTime"] = true, ["nav.stepPreview"] = true,
}
ns.On("SETTING_CHANGED", function(path)
	if ns.IsLoggedIn() and (path == "maps.travelNetwork" or path == "maps.omTravelNetwork" or path == "maps" or path == "") then RouteLines.RefreshNetwork() end
end)
-- Learning a flight master, or a new step's goals for the preview.
for _, event in ipairs({ "TAXIMAP_CLOSED" }) do
	ns.RegisterEvent(event, function() if ns.IsLoggedIn() then RouteLines.RefreshNetwork() end end)
end
ns.On("STEP_CHANGED", function() if ns.IsLoggedIn() and ns.Get("nav.stepPreview") then RouteLines.Refresh() end end)
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
			drawNetwork()
			refreshMinimap()
		end)
	end
	recolor()
	RouteLines.Refresh()
	buildNetwork()
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
