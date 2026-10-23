-- Camera-only world painter, adapted from accepted ForeverSparkleTrail 0.4.8.
-- No map painters, waypoint ownership, steering, or separate addon lifecycle.
local ADDON, ns = ...
local NS = ns.WorldTrail
if not NS then return end -- Keep independently loaded map modules usable.
local Trail = NS.Trail
local P = ns
local Render = {}
NS.Render = Render
local NEAR_PATH, SCAN_LIMIT = 80, 4000
local paths, groundPhase, clock = {}, 0, 0
local style, rgb
local rotates = true
local gr, drawGround
local started = false
local MEDIA = "Interface/AddOns/Polestar/Media/Nav/"
local function competing()
	local C = ns.Compat
	local loaded = C and C.IsAddOnLoaded or (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded
	if not loaded then return false end
	local ok, yes = pcall(loaded, "ForeverSparkleTrail")
	return ok and yes or false
end
local function secret(...)
	local isSecret = P and P.Compat and P.Compat.IsSecret
	if not isSecret then return false end
	for i = 1, select("#", ...) do
		if isSecret((select(i, ...))) then return true end
	end
	return false
end

local function playerPosition()
	local C = P and P.Compat
	if not (C and C.GetPlayerWorldPosition) then return nil end
	local ok, c, x, y = pcall(C.GetPlayerWorldPosition)
	if not ok or c == nil or secret(c, x, y) then return nil end
	return c, x, y
end

function Render.Rebuild()
	wipe(paths)
	local db = NS.db
	if started and db and db.enabled and not competing() and P.Nav and P.Nav.GetRouteGeometry then
		local ok, geometry = pcall(P.Nav.GetRouteGeometry)
		if ok then for i,p in ipairs(Trail.BuildPaths(geometry, false)) do paths[i]=p end end
	end
	Render.Restyle()
end
function Render.Restyle()
	local db = NS.db
	if not db then return end
	style, rgb = Trail.Style(db), NS.ColorOf(db.color).rgb
	Render.Show()
end
function Render.GetPaths() return paths end
local function newOwner(frame)
	frame.stars, frame.halos, frame.used = {}, {}, 0
	return frame
end

local function sprite(owner, i)
	local star = owner.stars[i]
	if not star then
		local halo = owner:CreateTexture(nil, "ARTWORK")
		halo:SetTexture(MEDIA .. "glow")
		halo:SetBlendMode("ADD")
		star = owner:CreateTexture(nil, "OVERLAY")
		star:SetTexture(MEDIA .. "sparkle")
		star:SetBlendMode("ADD")
		owner.stars[i], owner.halos[i] = star, halo
	end
	return star, owner.halos[i]
end

-- x, y: offsets from the owner's anchor point; size in the owner's units.
-- flat lays the halo on the ground, half as tall as it is wide.
local function place(owner, i, point, x, y, size, alpha, rotation, flat)
	local star, halo = sprite(owner, i)
	star:ClearAllPoints()
	star:SetPoint("CENTER", owner, point, x, y)
	star:SetSize(size, size)
	star:SetVertexColor(rgb[1], rgb[2], rgb[3])
	star:SetAlpha(alpha)
	if rotates and star.SetRotation then
		if not pcall(star.SetRotation, star, rotation) then rotates = false end
	end
	star:Show()
	local h = style.halo * alpha / (style.alpha > 0 and style.alpha or 1)
	if h > 0.01 then
		halo:ClearAllPoints()
		halo:SetPoint("CENTER", owner, point, x, y)
		halo:SetSize(size * 2.2, flat and size * 1.1 or size * 2.2)
		halo:SetVertexColor(rgb[1], rgb[2], rgb[3])
		halo:SetAlpha(h)
		halo:Show()
	else
		halo:Hide()
	end
end

local function finish(owner, used)
	for i = used + 1, owner.used do
		owner.stars[i]:Hide()
		owner.halos[i]:Hide()
	end
	owner.used = used
end

local GROUND_START = 2.5 -- yards ahead of the feet the trail begins
local EDGE = 6           -- px: a marker this near the screen's edge is pinned there, not on the ground

local function fov()
	local v = GetCVar and tonumber(GetCVar("cameraFov")) or nil
	if not v or v < 30 or v > 150 then v = 90 end
	return v
end

local function call(fn, ...)
	if not fn then return nil end
	local ok, a, b = pcall(fn, ...)
	if ok then return a, b end
end

-- The marker's place in gr's coordinates and the yards to it, or nil when
-- there is none, it is not Polestar's kind (a user waypoint), or it is pinned
-- to the screen's edge because the point is off screen or behind the camera.
-- Why the ground trail drew nothing last frame (nil when it drew), for the namespaced diagnostics.
local why

local function marker(width, height)
	local N, S = C_Navigation, C_SuperTrack
	if not (N and N.GetFrame and N.GetDistance) then why = "this client has no waypoint marker" return nil end
	if S and S.IsSuperTrackingUserWaypoint and not call(S.IsSuperTrackingUserWaypoint) then
		why = "the game is tracking something other than a map pin (a quest?)" return nil
	end
	local f = call(N.GetFrame)
	if not f or (f.IsShown and not f:IsShown()) then why = "no waypoint marker on screen" return nil end
	if N.WasClampedToScreen and call(N.WasClampedToScreen) then why = "the marker is off screen" return nil end
	local x, y = f:GetCenter()
	local d = call(N.GetDistance)
	if not (x and y and d) or secret(x, y, d) then why = "the marker's place is unreadable" return nil end
	if d <= GROUND_START then why = "arrived" return nil end
	local k = (f:GetEffectiveScale() or 1) / (gr:GetEffectiveScale() or 1)
	x, y = x * k, y * k
	if x < EDGE or y < EDGE or x > width - EDGE or y > height - EDGE then why = "the marker is off screen" return nil end
	return x, y, d
end

-- Camera estimate: where the waypoint is in the world, cached per waypoint.
local goal = {}
local function waypointWorld()
	local point = C_Map and C_Map.GetUserWaypoint and call(C_Map.GetUserWaypoint)
	local pos = point and point.position
	if not (pos and point.uiMapID and pos.x and pos.y) then return nil end
	if goal.map ~= point.uiMapID or goal.x ~= pos.x or goal.y ~= pos.y then
		goal.map, goal.x, goal.y = point.uiMapID, pos.x, pos.y
		goal.c, goal.wx, goal.wy = nil, nil, nil
		local C = P and P.Compat
		if C and C.MapToWorld then
			local ok, c, wx, wy = pcall(C.MapToWorld, point.uiMapID, pos.x * 100, pos.y * 100)
			if ok and c ~= nil and wy then goal.c, goal.wx, goal.wy = c, wx, wy end
		end
	end
	if goal.wx then return goal.c, goal.wx, goal.wy end
end

-- The waypoint's height is unknown (the probe showed C_Navigation.GetDistance
-- is flat and UnitPosition gives no height), so a pitch solved from it is off
-- by its slope, and drifts as the player walks over hills. So the pitch is
-- only taken from the marker while the camera is being moved (a mouse button
-- held, mouselook, a new zoom) and the waypoint is far enough for the slope to
-- matter little; the rest of the time it holds and only the yaw is solved.
local PITCH_FROM = 100 -- yards
local MERGE = 10       -- yards over which a trail leaving from beside the route joins it
local FADE_IN = 2      -- yards the trail fades in over, from where it starts ahead of you
local NEAR_DEPTH = 21  -- yards from the camera a sparkle shows at its set size (a mid zoom)
local camState = { pitch = 0.42 }

local function cameraMoving(zoom)
	local moving = IsMouselooking and IsMouselooking()
		or IsMouseButtonDown and (IsMouseButtonDown("LeftButton") or IsMouseButtonDown("RightButton"))
	if camState.zoom ~= zoom then
		camState.zoom = zoom
		moving = true
	end
	return moving and true or false
end

-- The waypoint's height above the feet, when the marker's distance is longer
-- than the flat distance to it (a distance measured in 3D): the two heights
-- it could be, the one keeping the camera's pitch steadiest wins.
local function solveWithHeight(rx, ry, d3, ax, ay, zoom, focal, width, height, yaw0, far)
	local d2 = math.sqrt(rx * rx + ry * ry)
	local best
	local h = d3 and d3 > d2 + 1 and math.sqrt(d3 * d3 - d2 * d2) or 0
	for _, dz in ipairs(h > 0 and { h, -h } or { 0 }) do
		local yaw, pitch, miss = Trail.SolveCamera(rx, ry, ax, ay, zoom, focal, width, height, yaw0, camState.pitch, not far, dz)
		if yaw and miss <= 4 then
			local jump = math.abs(pitch - camState.pitch)
			if not best or jump < best.jump then best = { yaw = yaw, pitch = pitch, miss = miss, dz = dz, jump = jump } end
		end
	end
	camState.d2, camState.d3 = d2, d3
	return best
end

-- The camera from the marker: yaw, pitch, the waypoint's height and flat
-- distance, or nil and why not.
local function fromMarker(c, px, py, path, ax, ay, d3, zoom, focal, width, height)
	if not ax then return nil end
	local gc, gx, gy = waypointWorld()
	-- A pin the game can't place in the world (one set on a world or stitched
	-- map): the route's end stands in when the marker's distance says it is there.
	if gc ~= c and d3 then
		local ex, ey = path.xs[path.n], path.ys[path.n]
		local de = math.sqrt((ex - px) ^ 2 + (ey - py) ^ 2)
		if math.abs(de - d3) <= math.max(5, d3 * 0.03) then gc, gx, gy = c, ex, ey end
	end
	if gc ~= c then
		return nil, gc == nil and "can't place the map pin in the world" or "the map pin is on another continent"
	end
	local rx, ry = gx - px, gy - py
	local far = rx * rx + ry * ry >= PITCH_FROM * PITCH_FROM
		and (cameraMoving(zoom) or not camState.locked)
	local yaw0 = camState.yaw or (GetPlayerFacing and GetPlayerFacing()) or 0
	local sol = solveWithHeight(rx, ry, d3, ax, ay, zoom, focal, width, height, yaw0, far)
	if not sol then return nil, "the camera can't be worked out from the marker" end
	if far then camState.pitch, camState.locked = sol.pitch, true end
	return sol.yaw, sol.pitch, sol.dz, camState.d2, sol.miss
end

-- Without a usable marker (none, a quest tracked, a far pin the game puts
-- under the ground or off screen): the camera sits behind the character, as
-- the probe showed it does (yaw = facing within a degree or two), at the
-- last pitch the marker gave. Not while the camera is being swung round
-- with the left button, when it looks elsewhere.
--
-- A left-button drag turns the camera away from the character by an amount
-- the game doesn't report, and it stays turned after the button is let go.
-- So after one the facing is not trusted again until the camera is known to
-- be behind the character: right-button mouselook (which turns the character
-- to the camera), a usable marker (which measures the turn exactly), or
-- RECENTER seconds of moving (the legacy following-camera estimate).
-- Never-follow cameras do not promise that walking re-centres the view.
local RECENTER = 1.5
-- Click-friendly heuristic, not a motion detector: a quick camera flick can
-- retain a wrong fallback until the marker or existing recovery restores it.
local LEFT_HOLD = 0.20 -- seconds from the first observed left-button press
local lastTick, leftSince

local function trackCamera()
	local now = GetTime and GetTime() or 0
	local dt = lastTick and now - lastTick or 0
	lastTick = now
	local looking = IsMouselooking and IsMouselooking()
	if looking then
		leftSince = nil
		camState.turned, camState.offset, camState.moving = false, 0, 0
	elseif IsMouseButtonDown and IsMouseButtonDown("LeftButton") then
		leftSince = leftSince or now
		camState.moving = 0
		if now - leftSince >= LEFT_HOLD then camState.turned = true end
	else
		leftSince = nil
		if camState.turned then
			local speed = GetUnitSpeed and GetUnitSpeed("player") or 0
			local follow = call(GetCVar, "cameraSmoothStyle")
			-- Keep the legacy estimate if unavailable; never infer recentering in Never mode.
			local following = not secret(follow) and tonumber(follow) ~= 0
			camState.moving = following and speed > 0 and (camState.moving or 0) + dt or 0
			if camState.moving >= RECENTER then camState.turned, camState.offset = false, 0 end
		end
	end
end

-- No input was observed while painting was paused; restart only the timers.
local function pauseCameraTracking()
	leftSince, lastTick, camState.moving = nil, nil, 0
end

local function reckoned()
	if not GetPlayerFacing then return nil end
	if camState.turned then return nil, "the camera may have been turned away from your character (right-drag to re-centre or bring the waypoint into view)" end
	local facing = GetPlayerFacing()
	if not facing or secret(facing) then return nil, "no facing here" end
	return facing + (camState.offset or 0), camState.pitch
end

-- The ground's height along the route ahead, from Polestar's walking maps.
-- The client gives addons no heights, but Polestar_Nav ships the walkable
-- surfaces of each 4.17 yd cell with their heights (Polestar_NavEngine,
-- Path.SurfacesAt, the reader Polestar's own floor tracking uses: decoded
-- clusters only, nil while one decodes). The floor under the player is the
-- surface nearest the last one (the lowest at first, as Polestar seeds it);
-- each point ahead takes the surface nearest the one before it, so a bridge
-- or a cave roof above the path is passed under, not climbed.
local HEIGHT_STEP = 2      -- yards between height samples along the route
local RISE = 4             -- yards a step up may climb (Polestar's floor rule)
local HEIGHT_EASE = 0.3    -- seconds a newly read height takes to settle in
-- Heights are sampled at fixed points of the route (every HEIGHT_STEP yards
-- from its start), each read once and kept (heights.z), so a sample never
-- changes as the player walks. What is drawn (heights.d) eases toward them:
-- a sample read late (its map tile decoded after the player crossed into it)
-- slides in instead of popping, and samples not known yet carry on the slope
-- before them. The cells are 4.17 yd steps, so the trail uses the samples
-- smoothed with their neighbours. Cells come from Terrain.lua, which reads
-- Polestar's walking maps without disturbing Polestar.
local heights = { z = {}, d = {}, path = nil, floor = nil }
local Terrain = NS.Terrain

-- The floor under the player, followed as Polestar's own floor tracking
-- does: kept across route changes, the surface nearest it at most RISE up as
-- they move (any drop is a fall), unknown when none is. A new floor is the
-- surface the route itself runs on beside the player when there is one
-- within RISE (the walking router's paths keep to real floors: in Ironforge
-- the city, not the mountain top over it), else seeded as Polestar does.
local function trackFloor(c, px, py, routeZ)
	if heights.fc ~= c or not heights.fx or (px - heights.fx) ^ 2 + (py - heights.fy) ^ 2 > 30 * 30 then
		heights.floor, heights.floorMarks, heights.floorShown = nil, nil, nil -- another continent, a hearth, a landing
	end
	heights.fc, heights.fx, heights.fy = c, px, py
	local cell = Terrain.Cell(px, py)
	if not cell then return end -- unknown or nothing walkable here: keep what we had
	local z, marks
	if heights.floor then z, marks = Terrain.Nearest(cell, heights.floor, RISE) end
	if not z and routeZ then
		local rz, rm = Terrain.Closest(cell, routeZ)
		if rz and math.abs(rz - routeZ) <= RISE then z, marks = rz, rm end
	end
	if not z then z, marks = Terrain.Seed(cell, IsIndoors and IsIndoors()) end
	heights.floor, heights.floorMarks = z, marks
end

-- Reads the route's samples from the player's to `reach` yards on that can be known now.
local function sampleHeights(path, along, reach)
	if heights.path ~= path then heights.z, heights.d, heights.path = {}, {}, path end
	heights.along = along
	local first = math.floor(along / HEIGHT_STEP) - 1
	local last = math.ceil((along + reach) / HEIGHT_STEP) + 1
	heights.first, heights.last = first, last
	local ref = heights.z[first - 1] or heights.floor
	for i = first, last do
		local z = heights.z[i]
		if z == nil then
			local wx, wy = Trail.PointAt(path, i * HEIGHT_STEP)
			local cell = Terrain.Cell(wx, wy)
			if cell == false then
				z = ref -- nothing walkable on the route (a post, a stall): the height before it
			elseif cell then
				if ref then
					z = Terrain.Nearest(cell, ref, RISE) or Terrain.Closest(cell, ref)
				else
					z = Terrain.Seed(cell, nil) or Terrain.Nearest(cell, nil, 0)
				end
			end
			if z then heights.z[i] = z end
		end
		if z then ref = z end -- an unknown sample leaves a gap; the chain picks up after it
	end
end

-- Eases the drawn heights toward the samples; unknown samples carry the slope on.
local function easeHeights(dt)
	local first, last = heights.first, heights.last
	if not first then return end
	local k = 1 - math.exp(-dt / HEIGHT_EASE)
	local z, d = heights.z, heights.d
	local lastKnown, slope = nil, 0
	for i = first, last do
		local target = z[i]
		if target ~= nil then
			lastKnown = i
			-- The mean slope over the last 8 yd known (single cells step by 2 yd).
			local back = z[i - 4] and 4 or z[i - 2] and 2 or nil
			slope = back and (target - z[i - back]) / back or 0
			if slope > RISE / 4 then slope = RISE / 4 elseif slope < -RISE / 4 then slope = -RISE / 4 end
		elseif lastKnown and d[lastKnown] then
			-- Unknown: the slope carries on for a few samples, then levels off.
			target = d[lastKnown] + slope * math.min(i - lastKnown, 4)
		end
		if target ~= nil then
			local v = d[i]
			d[i] = v and v + (target - v) * k or target
		end
	end
end

local function smoothed(i)
	local d = heights.d
	local c = d[i]
	if c == nil then return nil end
	local sum, w = c * 2, 2
	for j = -2, 2 do
		if j ~= 0 then
			local v = d[i + j]
			if v ~= nil and math.abs(v - c) < RISE * 2 then
				local k = (j == -1 or j == 1) and 1.5 or 1
				sum, w = sum + v * k, w + k
			end
		end
	end
	return sum / w
end

-- The smoothed ground height `a` yards along the route, or nil where unknown.
local function profileAt(a)
	local u = a / HEIGHT_STEP
	local i = math.floor(u)
	local z0, z1 = smoothed(i), smoothed(i + 1)
	if z0 and z1 then return z0 + (z1 - z0) * (u - i) end
	return z0 or z1
end

-- Diagnostics: yards of route ahead with heights read, and the rise over them.
function Render.HeightsAhead()
	local along = heights.along
	if not along or not profileAt(along) then return nil end
	local i, last = math.floor(along / HEIGHT_STEP), nil
	while heights.z[i] ~= nil do last, i = i, i + 1 end
	return last and math.max(0, last * HEIGHT_STEP - along) or nil
end
function Render.HeightsRise()
	local ahead = Render.HeightsAhead()
	if not ahead then return nil end
	local a, b = profileAt(heights.along), profileAt(heights.along + ahead)
	return a and b and b - a or nil
end

-- The route as the ground trail walks it: the walking router's paths step
-- across 4.17 yd cells, so they zigzag; corners are cut (Chaikin, twice) so
-- the trail flows. Built once per route.
local groundPath, groundOf
local function smoothPath(path)
	if groundOf ~= path then groundPath, groundOf = Trail.Smooth(path, 2), path end
	return groundPath
end

-- Whether the walking maps may be read now: only while Polestar is following
-- a walk itself (its floor tracking keeps the player's tile decoded), so a
-- read never decodes or holds a tile Polestar has let go. Not on a transport
-- leg, a taxi or a boat, not with Polestar's walking routes off, not off the
-- route (Polestar re-plans past 25 yd), not on arrival (Polestar stops aiming).
local function setting(key)
	if not (P and P.Get) then return nil end
	local ok, v = pcall(P.Get, key)
	if ok then return v end
end

local function readsAllowed(path, dist, along)
	if path.kind ~= "walk" or not dist or dist > 25 or path.total - along < 10 then return false end
	if UnitOnTaxi and UnitOnTaxi("player") then return false end
	-- Polestar reads the floor only from its arrow's updates (Walk.Aim from
	-- Nav.Sample): not with its arrow off or handed to TomTom's.
	if setting("nav.navRouting") == false or setting("nav.arrow") == false then return false end
	local Nav = P and P.Nav
	if Nav then
		if Nav.UsingTomTomArrow then
			local ok, tom = pcall(Nav.UsingTomTomArrow)
			if ok and tom then return false end
		end
		if Nav.HandedOff then
			local ok, off = pcall(Nav.HandedOff)
			if ok and off then return false end
		end
		-- Arrived (or about to be, or not yet left): Polestar stops aiming
		-- within the target's radius (plus its area), until past r + max(5, r/2).
		if Nav.TargetOffset and Nav.GetTarget then
			local ok, dn, dw = pcall(Nav.TargetOffset)
			local ok2, target = pcall(Nav.GetTarget)
			if ok and dn and dw and ok2 and type(target) == "table" then
				local r = tonumber(target.r) or Nav.DEFAULT_RADIUS or 8
				local d = math.sqrt(dn * dn + dw * dw) - (tonumber(target.area) or 0)
				if d <= r + math.max(5, r * 0.5) + 2 then return false end
			end
		end
	end
	local X = P and P.Transit
	if X and X.Riding then
		local ok, riding = pcall(X.Riding)
		if ok and riding then return false end
	end
	return true
end

-- How much of the route ahead is in view, from the walking maps: the line
-- from the camera (from the player's eyes when there is no camera estimate)
-- to points of the trail every SIGHT_STEP yards is walked over the cells
-- (Terrain.Sees); two blocked points in a row end it, and the edge between
-- the last point in view and the first hidden one is found more closely.
-- The end is kept as a place on the route, so it stays put in the world as
-- the player walks toward it, and a nearer end is taken only when two
-- evaluations agree. The drawn length follows it on a critically damped
-- spring (no overshoot, no sudden starts), shrinking briskly, growing
-- gently, and growing only once more has been in view for a moment.
local SIGHT_EVERY = 0.2   -- seconds between evaluations
local SIGHT_STEP = 4      -- yards between trail points tested
local SIGHT_MIN = 12      -- yards the trail always keeps (the ground right ahead)
local EYE = 2             -- yards above the floor the eyes are
local SIGHT_RATE = 15     -- yards a second the drawn length's end may move at most
local SHRINK_W = 6        -- spring rates (1/s): shrinking settles in about half a second,
local GROW_W = 2.2        -- growing in about a second and a half
local GROW_HOLD = 0.5     -- seconds more must be in view before the trail grows
local sight = { cutAt = nil, pending = nil, target = nil, drawn = nil, v = 0, at = -1, over = 0, visible = nil }

local function evaluateSight(path, px, py, along, maxLen, cam)
	local fl = heights.floor
	if not fl then return nil, true end
	local eyeIndoor = Terrain.Indoor(heights.floorMarks)
	local ox, oy, oz, boom = px, py, fl + EYE, false
	if cam then
		ox, oy, oz = px + cam.x, py + cam.y, fl + cam.z
		boom = true
	end
	local function sees(a)
		local gz = profileAt(a)
		if not gz then return nil end
		local wx, wy = Trail.PointAt(path, a)
		if boom then return Terrain.Sees(ox, oy, oz, wx, wy, gz + 1, eyeIndoor, fl, px, py) end
		return Terrain.Sees(ox, oy, oz, wx, wy, gz + 1, eyeIndoor, fl)
	end
	local visible, blockedAt = 0, nil
	local d = SIGHT_STEP
	while d <= maxLen do
		local s = sees(along + d)
		if s == nil then return visible, true end
		if s then
			visible, blockedAt = d, nil
		elseif blockedAt then
			-- Two hidden in a row: the edge lies between `visible` and the first of them.
			local lo, hi = visible, blockedAt
			for _ = 1, 2 do
				local mid = (lo + hi) / 2
				local m = sees(along + mid)
				if m == nil then break end
				if m then lo = mid else hi = mid end
			end
			return lo, false
		else
			blockedAt = d
		end
		d = d + SIGHT_STEP
	end
	return maxLen, false
end

local function spring(x, v, target, w, dt)
	local f = 1 + 2 * dt * w
	local ww = w * w
	local det = 1 / (f + dt * dt * ww)
	return (f * x + dt * v + dt * dt * ww * target) * det, (v + dt * ww * (target - x)) * det
end

-- The trail's drawn length this frame.
local function drawnLength(path, px, py, along, cam, dt)
	local db = NS.db
	local maxLen = db.groundLength
	if not db.groundSight or not Terrain then
		sight.cutAt, sight.pending, sight.target, sight.drawn, sight.visible, sight.v = nil, nil, nil, nil, nil, 0
		return maxLen
	end
	if sight.path ~= path then sight.cutAt, sight.pending, sight.path = nil, nil, path end
	if clock - sight.at >= SIGHT_EVERY or not sight.cutAt then
		sight.at = clock
		local visible, unknown = evaluateSight(path, px, py, along, maxLen, cam)
		sight.visible = visible
		-- Ground not known yet (no floor, a map tile not read) neither grows nor
		-- shrinks the trail: it keeps its length. Only a hidden point fixes the
		-- end to a place on the route.
		local hold = along + (sight.target or maxLen)
		local cut
		if not visible then
			cut = hold
		elseif unknown then
			cut = math.max(along + visible, hold)
		else
			cut = along + visible
		end
		if sight.cutAt and cut < sight.cutAt - 1 then
			-- Nearer: taken when the next evaluation agrees (a glimpse past a post doesn't flicker).
			if sight.pending and math.abs(sight.pending - cut) < 3 then
				sight.cutAt, sight.pending = math.max(cut, sight.pending), nil
			else
				sight.pending = cut
			end
		else
			sight.cutAt, sight.pending = cut, nil
		end
	end
	local floorLen = math.min(SIGHT_MIN, maxLen)
	local target = sight.cutAt - along
	if target < floorLen then target = floorLen elseif target > maxLen then target = maxLen end
	sight.target = target
	local L, v = sight.drawn or target, sight.v or 0
	if target < L then
		sight.over = 0
		L, v = spring(L, v, target, SHRINK_W, dt)
	elseif target > L + 4 and sight.over < GROW_HOLD then
		sight.over = sight.over + dt
		v = 0
	else
		L, v = spring(L, v, target, GROW_W, dt)
	end
	if v > SIGHT_RATE then v = SIGHT_RATE elseif v < -SIGHT_RATE then v = -SIGHT_RATE end
	local prev = sight.drawn or L
	local cap = SIGHT_RATE * dt
	if L > prev + cap then L = prev + cap elseif L < prev - cap then L = prev - cap end
	if L > maxLen then L, v = maxLen, 0 end -- the Length slider is a hard limit
	sight.drawn, sight.v = L, v
	return L
end

function Render.Sight() return sight end

-- Forgets the ground read so far (the maps themselves are cached in Terrain.lua).
function Render.ResetGround()
	heights.z, heights.d, heights.path, heights.floor, heights.floorMarks, heights.floorShown = {}, {}, nil, nil, nil, nil
	heights.first, heights.last, heights.along = nil, nil, nil
	sight.cutAt, sight.pending, sight.target, sight.drawn, sight.visible, sight.v, sight.over = nil, nil, nil, nil, nil, 0, 0
end

local lastDraw

local function drawCamera(width, height, ax, ay, d3, used, markerWhy)
	local db = NS.db
	trackCamera()
	local dt = lastDraw and clock - lastDraw or 0
	lastDraw = clock
	local path = paths[1] and smoothPath(paths[1])
	local c, px, py = playerPosition()
	if not (c and path and path.c == c) then
		why = not c and "no player position here" or "the route's current stretch is on another continent"
		camState.yaw = nil return used
	end
	local zoom = GetCameraZoom and GetCameraZoom() or 15
	local focal = Trail.Focal(fov(), height)
	local yaw, pitch, dz, d2, miss = fromMarker(c, px, py, path, ax, ay, d3, zoom, focal, width, height)
	local fromWhy = pitch
	if yaw then
		camState.source = "marker"
		-- The marker measures how far the camera is turned from the character.
		local facing = GetPlayerFacing and GetPlayerFacing()
		if facing and not secret(facing) then
			camState.offset = (yaw - facing + math.pi) % (2 * math.pi) - math.pi
			camState.turned = false
		end
	else
		markerWhy = type(fromWhy) == "string" and fromWhy or markerWhy
		yaw, pitch = reckoned()
		if not yaw then
			why = (type(pitch) == "string" and pitch or markerWhy or "no camera")
			camState.yaw, camState.miss = nil, nil return used
		end
		dz, d2, miss, camState.source = 0, 1, nil, "facing (" .. (markerWhy or "no marker") .. ")"
	end
	camState.yaw, camState.miss, camState.dz = yaw, miss, dz
	-- The route climbs (or drops) toward the waypoint's height in step with the flat distance.
	d2 = d2 and d2 > 1 and d2 or 1
	local cam = Trail.Camera(yaw, pitch, zoom, focal, width, height)
	camState.cam = cam
	local along, dist = Trail.Nearest(path, c, px, py, heights.path == path and heights.along or nil)
	if not along or dist > NEAR_PATH then along, dist = 0, nil end
	-- Off the route's line (it runs a few yards beside you): the trail leaves
	-- from your feet and joins the route over MERGE yards.
	local offX, offY = 0, 0
	if dist then
		local qx, qy = Trail.PointAt(path, along)
		offX, offY = px - qx, py - qy
	end
	local spacing = db.groundGap
	if Terrain and Terrain.Begin(c, px, py, clock, readsAllowed(path, dist, along)) then
		local wasFloor = heights.floor
		trackFloor(c, px, py, heights.path == path and heights.z[math.floor(along / HEIGHT_STEP)] or nil)
		sampleHeights(path, along, db.groundLength + 4)
		-- No floor yet: the route's chain started from its own lowest surfaces; take the floor from it.
		if not wasFloor and not heights.floor then trackFloor(c, px, py, heights.z[math.floor(along / HEIGHT_STEP)]) end
	end
	easeHeights(dt)
	-- The height the trail is drawn from: the route's ground where the player
	-- is, or, when they stand off the route (up a bank, down a gully), their
	-- own floor, eased so the 4.17 yd cells don't show.
	local routeZ = profileAt(along)
	if heights.floor then
		local fs = heights.floorShown
		heights.floorShown = fs and fs + (heights.floor - fs) * (1 - math.exp(-dt / HEIGHT_EASE)) or heights.floor
	end
	local baseZ = routeZ
	if heights.floorShown and (not routeZ or (dist and dist > 3)) then
		local w = routeZ and math.min(1, ((dist or 10) - 3) / 7) or 1
		baseZ = routeZ and routeZ + (heights.floorShown - routeZ) * w or heights.floorShown
	end
	local length = drawnLength(path, px, py, along, cam, dt)
	local start = along + db.groundAhead
	local stop = along + length
	-- Sprites keep their size in the world, so a far camera sees them small
	-- (they'd crowd a zoomed-out trail at a fixed size on screen).
	local near = NEAR_DEPTH
	local size = style.size * 1.6
	local limit = db.maxSparkles
	local lastZ
	Trail.Emit(path, start, spacing, groundPhase, SCAN_LIMIT, function(wx, wy, k, nx, ny, fade)
		local a = (k + groundPhase) * spacing
		local head = (a - start) / FADE_IN
		if head < fade then fade = head end
		local m = 1 - (a - along) / MERGE
		if m > 0 then
			m = m * m * (3 - 2 * m)
			wx, wy = wx + offX * m, wy + offY * m
		end
		if a > stop then return false end
		local tail = (stop - a) / (3 * spacing)
		if tail < fade then fade = tail end
		fade = fade * Trail.DistanceFade(a - along, length, db.groundFade)
		-- The ground here, once for all of this point's glints.
		local pz = baseZ and profileAt(a)
		if pz then lastZ = pz end
		pz = pz or lastZ
		-- Leaving from beside the route, the trail also starts at the player's own height.
		if pz and m > 0 and heights.floorShown then pz = pz + (heights.floorShown - pz) * m end
		-- Near the character the trail is a wide scatter of glints; ahead it
		-- narrows to a single thread and fades out.
		local u = (a - along) / length
		if u < 0 then u = 0 elseif u > 1 then u = 1 end
		local width2 = db.groundWidth * (1 - u) * (1 - u)
		local extra = math.floor(db.groundWidth * 2.5 * (1 - u) + 0.5)
		local tx, ty = ny, -nx
		for j = 0, extra do
			local id = j == 0 and k or k * 16 + j + 100000
			local alpha, scale, rotation, side = Trail.Sparkle(id, clock, style, fade)
			if alpha > 0.01 then
				local lat, fwd = side * style.jitter, 0
				if j > 0 then
					lat = (Trail.Hash(id, 5) * 2 - 1) * width2
					fwd = (Trail.Hash(id, 6) - 0.5) * spacing
					scale = scale * (0.55 + 0.35 * Trail.Hash(id, 7))
				end
				local ox, oy = wx + nx * lat + tx * fwd - px, wy + ny * lat + ty * fwd - py
				local hz
				if pz then
					hz = pz - baseZ
				else
					local rise = math.sqrt(ox * ox + oy * oy) / d2
					hz = dz * (rise < 1 and rise or 1)
				end
				local sx, sy, depth = Trail.Project(cam, ox, oy, hz + db.groundLift)
				if sx and sx >= 0 and sy >= 0 and sx <= width and sy <= height then
					local ds = near / depth
					if ds > 1.6 then ds = 1.6 end
					local s = size * scale * ds
					if s >= 2.5 then
						used = used + 1
						local dim = ds * (zoom > 2 and zoom + 3 or 5) / near -- the far end dims, whatever the zoom
						place(gr, used, "BOTTOMLEFT", sx, sy, s, alpha * (0.45 + 0.55 * (dim < 1 and dim or 1)), rotation, true)
						if used >= limit then return false end
					end
				end
			end
		end
	end)
	return used
end

function Render.GroundFrame() return gr end

function Render.CameraState() return camState end

-- What the ground trail is working from, for Render.Probe().
function Render.Probe()
	local C = P and P.Compat
	local ux, uy, uz = nil, nil, nil
	if C and C.GetPlayerUnitPosition then ux, uy, uz = C.GetPlayerUnitPosition() end
	local N = C_Navigation
	return {
		zoom = GetCameraZoom and GetCameraZoom(),
		indoors = IsIndoors and IsIndoors() and true or false,
		navDistance = N and N.GetDistance and call(N.GetDistance),
		flat = camState.d2, height = camState.dz, yaw = camState.yaw, pitch = camState.pitch,
		miss = camState.miss, why = Render.Why(), source = camState.source, locked = camState.locked and not (IsMouselooking and IsMouselooking()), facing = GetPlayerFacing and GetPlayerFacing(), z = uz, fov = fov(), floor = heights.floor, ahead = Render.HeightsAhead(), rise = Render.HeightsRise(),
		visible = sight.visible, drawn = sight.drawn,
	}
end

local SETTLE = 2 -- full seconds after the last loading-screen completion
local settled, loading = false, false
local generation, deadline = 0, 0
local function settle()
	pauseCameraTracking()
	generation = generation + 1
	settled = false
	if loading then return end
	local gen = generation
	deadline = GetTime() + SETTLE
	if C_Timer and C_Timer.After then
		C_Timer.After(SETTLE, function()
			if gen == generation and not loading and GetTime() >= deadline then settled = true end
		end)
	end
end
function Render.Settled()
	if not loading and not settled and GetTime() >= deadline then settled = true end
	return settled and not loading
end
local function loadingStarted()
	pauseCameraTracking()
	loading = true
	generation = generation + 1
	settled = false
	if gr then finish(gr,0) end
	Render.ResetGround()
end
local function loadingFinished()
	loading = false
	settle()
end

drawGround = function()
	local db = NS.db
	if not Render.Settled() or not db or not db.enabled or competing() then pauseCameraTracking(); finish(gr,0); return end
	local width,height=gr:GetWidth() or 0,gr:GetHeight() or 0
	local onTaxi=UnitOnTaxi and UnitOnTaxi("player")
	local ax,ay,d
	why=nil
	if onTaxi then why="on a flight" elseif width>0 and height>0 then ax,ay,d=marker(width,height) end
	if not db.groundIndoors and IsIndoors and IsIndoors() then why="indoors"; pauseCameraTracking(); finish(gr,0); return end
	local used=0
	if not onTaxi and width>0 and height>0 then
		local markerWhy=why; why=nil
		used=drawCamera(width,height,ax,ay,d,0,markerWhy)
	else
		pauseCameraTracking()
	end
	if used==0 and not why then why="nothing of the route in view" end
	finish(gr,used)
end
function Render.Why()
	if competing() then return "suppressed while ForeverSparkleTrail is loaded" end
	if not (NS.db and NS.db.enabled) then return "the ground trail is off" end
	if #paths==0 then return "no Polestar route" end
	if not Render.Settled() then return "waiting after a loading screen" end
	return why
end
local FRAME_INTERVAL = 1 / 40 -- retain the accepted painter's update ceiling
local drawElapsed = 0
local function tick(_, elapsed)
	clock = clock + elapsed
	groundPhase = groundPhase + elapsed * (style and style.flow or 0)
	drawElapsed = drawElapsed + elapsed
	if drawElapsed < FRAME_INTERVAL then return end
	drawElapsed = drawElapsed % FRAME_INTERVAL
	drawGround()
end
local function ensureGround()
	if gr then return true end
	if not UIParent then return false end
	gr=newOwner(ns.CreateFrameUnder("Frame",nil,UIParent))
	gr:SetAllPoints(UIParent)
	gr:SetScript("OnHide",pauseCameraTracking)
	gr:SetFrameStrata("BACKGROUND"); gr:SetFrameLevel(1); gr:EnableMouse(false)
	return true
end
function Render.Show()
	local db=NS.db
	local active=started and db and db.enabled and style and #paths>0 and not competing()
	if not active then
		if gr then finish(gr,0); gr:SetScript("OnUpdate",nil); gr:Hide() end
		pauseCameraTracking()
		lastDraw, drawElapsed = nil, 0
		return
	end
	if ensureGround() then gr:SetScript("OnUpdate",tick); gr:Show() end
end
function Render.Start()
	if started then return true end
	started=true
	ns.On("NAV_ROUTE_GEOMETRY",Render.Rebuild)
	ns.RegisterEvent("LOADING_SCREEN_ENABLED",loadingStarted)
	ns.RegisterEvent("LOADING_SCREEN_DISABLED",loadingFinished)
	ns.RegisterEvent("PLAYER_ENTERING_WORLD",settle)
	ns.RegisterEvent("ADDON_LOADED",function() if competing() then Render.Rebuild() end end)
	settle(); Render.Rebuild()
	return true
end
ns.OnLogin(Render.Start)
