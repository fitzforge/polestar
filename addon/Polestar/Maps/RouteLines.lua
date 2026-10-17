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

local ADDON, ns = ...
local Nav, Strokes = ns.Nav, ns.RouteStrokes
-- Without Nav there is no route (and no nav.* setting to show).
if not (Nav and Nav.GetRouteGeometry and Strokes) then return end

local type, ipairs, pairs, abs = type, ipairs, pairs, math.abs

local RouteLines = {}
ns.RouteLines = RouteLines

ns.RegisterDefaults("nav", { routeLines = true })

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"
local DOT_TEXTURE = MEDIA .. "pin-fill"
local UNDER_ALPHA = 0.5
local MINIMAP_LIMIT = 600 -- strokes on the minimap: a full face of breadcrumbs, with room
local DRIVE_INTERVAL = 0.1
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
	return owner
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
	if b == nil then
		b = false
		local C = ns.Compat
		if not (C and C.MapToWorld) then return nil end
		local c1, top, left = C.MapToWorld(mapID, 0, 0)
		local c2, bottom, right = C.MapToWorld(mapID, 100, 100)
		if c1 and c1 == c2 and top ~= bottom and left ~= right then
			b = { c = c1, left = left, top = top, kx = 1 / (right - left), ky = 1 / (bottom - top) }
		end
		bounds[mapID] = b
	end
	return b or nil
end

-- A continent map: its dots are smaller. (Bigger maps span continents and
-- have no bounds, so nothing is drawn there.)
local function isSmall(mapID)
	local C = ns.Compat
	return C and C.GetContinentMap and C.GetContinentMap(mapID) == mapID or false
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

local function drawWorld(pin)
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
		last.revision = nil
		return
	end
	-- mm covers the minimap (SetAllPoints): its size is the minimap's.
	local width, height, scale = Minimap:GetWidth(), Minimap:GetHeight(), mm:GetEffectiveScale()
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
	if elapsedSince < DRIVE_INTERVAL then return end
	elapsedSince = 0
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
	if T and T.Color then under[1], under[2], under[3] = T.Color("scrim") end
end

function RouteLines.Refresh()
	rebuild()
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

ns.On("NAV_ROUTE_GEOMETRY", function()
	if ns.IsLoggedIn() then RouteLines.Refresh() end
end)

local WATCH = { ["nav.routeLines"] = true, ["nav.worldPins"] = true, ["nav.minimapPins"] = true, ["nav"] = true, [""] = true }
ns.On("SETTING_CHANGED", function(path)
	if WATCH[path] and ns.IsLoggedIn() then RouteLines.Refresh() end
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
