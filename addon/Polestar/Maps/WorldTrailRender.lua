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

-- The player's own speed in yd/s (GetUnitSpeed's first value) and facing in
-- radians: nil while the client does not say or keeps the value secret, as
-- it can in combat. A secret value throws when it is compared or worked on,
-- and the client logs the attempt against the addon, so these are the only
-- two places the painter reads them.
local function ownSpeed()
	local speed = call(GetUnitSpeed, "player")
	if secret(speed) or type(speed) ~= "number" then return nil end
	return speed
end

local function ownFacing()
	local facing = call(GetPlayerFacing)
	if secret(facing) or type(facing) ~= "number" then return nil end
	return facing
end

-- The marker's place in gr's coordinates and the yards to it, or nil when
-- there is none, it is not Polestar's kind (a user waypoint), or it is pinned
-- to the screen's edge because the point is off screen or behind the camera.
-- Why the ground trail drew nothing last frame (nil when it drew), for the namespaced diagnostics.
local why

-- A marker that is off screen: where the game pins it (gr's coordinates, when
-- readable) and when a marker frame was last there at all. The pinned place
-- cannot measure the camera, but it can contradict a tilt the trail assumes.
-- close: yards, with twice the camera's distance, within which a marker low on the screen measures nothing (fromMarker).
-- flat: radians down, the flattest view a pin whose side (above or below) is only a guess may read.
local pinned = { foreign = "the game's marker is not one Polestar placed (it is not read)", close = 10, flat = 0.03 }
local OFF_SCREEN = "the marker is off screen"

local function marker(width, height)
	local wasOff = pinned.wasOff
	pinned.off, pinned.x, pinned.y, pinned.clamped, pinned.d, pinned.wasOff = nil, nil, nil, nil, nil, false
	local N, S = C_Navigation, C_SuperTrack
	if not (N and N.GetFrame and N.GetDistance) then why = "this client has no waypoint marker" return nil end
	-- Whose marker the game shows: a map pin's has a place on the map.
	local isPin = true
	if S then
		local kind = S.GetHighestPrioritySuperTrackingType and call(S.GetHighestPrioritySuperTrackingType)
		local pinKind = Enum and Enum.SuperTrackingType and Enum.SuperTrackingType.UserWaypoint
		if kind ~= nil and pinKind ~= nil and not secret(kind) then
			isPin = kind == pinKind
		elseif S.IsSuperTrackingUserWaypoint then
			isPin = call(S.IsSuperTrackingUserWaypoint) and true or false
		end
	end
	-- And only a map pin Polestar itself set is read (Nav/Bridges.lua: the game's waypoint, where the
	-- player has it on). Its place is the one Polestar gave it. Whatever else the game tracks, a quest it
	-- took up by itself when it was accepted or a pin of the player's own, stands at a place and a height
	-- the trail could only guess at, and a guess that is out lays the whole trail in the sky or in a heap:
	-- such a marker is never read, on the screen or pinned to its edge.
	local B = P and P.Nav and P.Nav.bridges
	local own = isPin and B and B.OwnsPin and call(B.OwnsPin) and true or false
	pinned.pin, pinned.own = isPin, own
	local f = call(N.GetFrame)
	if not f or (f.IsShown and not f:IsShown()) then why = "no waypoint marker on screen" return nil end
	pinned.seen = clock
	if not own then why = pinned.foreign return nil end
	local x, y = f:GetCenter()
	local readable = x and y and not secret(x, y)
	if readable then
		local k = (f:GetEffectiveScale() or 1) / (gr:GetEffectiveScale() or 1)
		x, y = x * k, y * k
	end
	-- Pinned to the screen's edge by the game, or without a place on screen at all.
	local off = N.WasClampedToScreen and call(N.WasClampedToScreen)
	local clamped = off and true or false
	if N.HasValidScreenPosition and call(N.HasValidScreenPosition) == false then off, readable, clamped = true, false, false end
	local d = call(N.GetDistance)
	if d ~= nil and secret(d) then d = nil end
	pinned.d = d
	if not off then
		if not (readable and d) then why = "the marker's place is unreadable" return nil end
		if d <= GROUND_START then why = "arrived" return nil end
		off = x < EDGE or y < EDGE or x > width - EDGE or y > height - EDGE
	end
	if off then
		pinned.off = true
		if readable then pinned.x, pinned.y = x, y end
		-- Pinned by the game itself (not merely at the screen's edge), and since when.
		pinned.clamped = clamped and readable or false
		pinned.since = wasOff and pinned.since or clock
		pinned.wasOff = true
		why = OFF_SCREEN return nil
	end
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

local TOO_NEAR = "the marker's place is near by and under the view: no tilt can be told from it"
-- The camera's tilt is measured from the marker: every frame it is usable,
-- the yaw and the pitch that put the waypoint where the marker shows are
-- solved, so the trail keeps to the ground however the camera is tilted.
--
-- The marker stands on the ground at the waypoint, and that ground's height
-- above the feet is only known when the waypoint ends an accepted baked
-- walking leg (the strip's last sample); otherwise it is taken as level. What
-- that leaves out (a far waypoint over a hill, a floor the strip does not
-- follow) is `lift`: while the player moves without touching the camera the
-- pitch does not change, so there the pitch holds and the marker's drift on
-- screen is the ground's, and corrects the lift. Standing still, or with a
-- mouse button held, mouselook or a new zoom, any drift is the camera's; so
-- is one too large for the ground to explain (a key bound to tilt the view).
local MERGE = 10        -- yards over which a trail leaving from beside the route joins it
local FADE_IN = 2       -- yards the trail fades in over, from where it starts ahead of you
local NEAR_DEPTH = 21   -- yards from the camera a sparkle shows at its set size (a mid zoom)
local PIN_AT_END = 5    -- yards between the waypoint and the leg's end for the strip to give its height
local LIFT_MAX = 15     -- yards (or half the way there) a marker may stand off its expected height
local GOAL_NEAR = 5     -- yards (or a twentieth of the way) a marker may stand from the route's end and be its goal
local WOBBLE = 0.05     -- radians a tilt held through a turn of the mouse may be out: less is not taken for a place's height
local TILT_OFF = 0.2    -- of the screen's height a pinned marker may sit from where the tilt puts it
local LOST_HOLD = 0.5   -- seconds the tilt counts as lost after a pinned marker last contradicted it
local PIN_SETTLE = 0.3  -- seconds a pin that has just moved may be shown by a marker still at its old place
local PIN_AGREE = 0.1   -- of the screen's width that marker may then show from where the camera puts the pin
local SETTLING = "the waypoint has just moved and its marker has yet to follow"
local REVEAL = 0.25     -- seconds the trail fades in over when it can be drawn again
local LOOK_DOWN = 1.53  -- radians the game lets the view tilt, down and up
local SEGMENT = 160     -- cursor units of one-way mouse travel a stroke must span to be measured
local JUMP_SPEED = 7.9555 -- yards a second a jump leaves the ground at
local GRAVITY = 19.2911   -- yards a second it loses each second
local JUMP_KEY = 0.3    -- seconds before leaving the ground that a jump key still makes it a jump
local UP_VIEW = -0.3    -- radians: a view turned further up than this is a look at the sky, not a view to play in
local UNPLACED = "the marker shows where no place could lie at the view's tilt"
-- usual: the tilt of the last ordinary view, one at rest and not turned up at the sky (below).
-- adrift: the view has been dragged since anything last said how it is tilted, so the tilt held is a guess
-- (set where a drag ends unread, cleared by whatever reads the tilt). The trail is then drawn short and flat
-- (drawCamera): no longer than reachZooms times the camera's distance (minReach yards at least), from nearer
-- the feet, fading out over its far half, and at a tilt no steeper than flatView. `loose` eases between the two.
local camState = { pitch = 0.42, lift = 0, usual = 0.42, flatView = 0.26, reachZooms = 0.3, minReach = 4 }

-- Mouse tilt. With no usable marker the only sign of a tilt is the mouse: the
-- cursor's vertical travel while a button drags the camera. How far the view
-- tilts per cursor unit is not given, so it is measured:
--   against the marker, whenever a drag tilts the view with a marker in sight;
--   else from turning: under right-button mouselook the character turns with
--   the camera, so the facing's change per unit of sideways travel is the
--   yaw's rate, and the game's own two speeds (cameraPitchMoveSpeed over
--   cameraYawMoveSpeed, mouseInvertPitch) take that to the tilt's.
-- Until one of them has a sample, or where the cursor's travel is not
-- reported, nothing is reckoned and the pitch holds as before.
local mouse = { dy = 0, travel = 0, turned = 0,
	turns = { x = 0, v = 0, a = 0, idle = 0, sumX = 0, sumV = 0 },
	tilts = { x = 0, v = 0, a = 0, idle = 0, sumX = 0, sumV = 0 } }

local function rateOf(v, x)
	local r = v / x
	if r ~= r or math.abs(r) < 1e-6 or math.abs(r) > 0.05 then return nil end
	return r
end

-- One stroke of the mouse and what it did: `x` cursor units one way (`a`
-- counting both ways) and `v` radians of turn or tilt. A stroke runs from rest
-- to rest, so a view that answers a frame late is still counted whole; one
-- `cut` short while moving (the drag ended), or `dirty` from starting that
-- way, is not counted. Only one-way strokes long enough to measure are kept,
-- the newer weighing more.
local function endStroke(s, least, cut)
	local x, v, a = s.x, s.v, s.a
	local spoilt = s.dirty or (cut and s.idle == 0 and x ~= 0)
	s.x, s.v, s.a, s.idle, s.dirty = 0, 0, 0, 0, nil
	if spoilt or math.abs(x) < least or math.abs(x) < 0.8 * a or not rateOf(v, x) then return nil end
	local way = x > 0 and 1 or -1
	-- The other way round from what was learnt (a setting changed): start again.
	if s.sumX > 0 and (s.sumV > 0) ~= (v * way > 0) then s.sumX, s.sumV = 0, 0 end
	s.sumX, s.sumV = s.sumX * 0.8 + math.abs(x), s.sumV * 0.8 + v * way
	return s.sumV / s.sumX
end

-- Adds a frame to the stroke; the rate when one is to be had from it. Until
-- the first whole stroke, the stroke so far serves.
local function stroke(s, dx, dv, least)
	s.x, s.v, s.a = s.x + dx, s.v + dv, s.a + math.abs(dx)
	s.idle = dx == 0 and s.idle + 1 or 0
	if s.idle >= 2 then return endStroke(s, least) end
	if s.sumX == 0 and math.abs(s.x) >= least and math.abs(s.x) >= 0.8 * s.a then return rateOf(s.v, s.x) end
end

local function cvar(name)
	local v = call(GetCVar, name)
	if v == nil or secret(v) then return nil end
	return v
end

-- Radians the pitch changes per cursor unit of upward travel, or nil.
local function tiltPerUnit()
	if mouse.tilt then return mouse.tilt end
	if not mouse.turn then return nil end
	local yawSpeed, pitchSpeed = tonumber(cvar("cameraYawMoveSpeed")), tonumber(cvar("cameraPitchMoveSpeed"))
	local ratio = yawSpeed and pitchSpeed and yawSpeed > 0 and pitchSpeed > 0 and pitchSpeed / yawSpeed or 0.5
	local invert = cvar("mouseInvertPitch")
	invert = invert == "1" or invert == 1 or invert == true
	-- The mouse pushed up turns the view up: the pitch (down is positive) falls.
	return math.abs(mouse.turn) * ratio * (invert and 1 or -1)
end

local function overWorld()
	local ok, focus
	if GetMouseFoci then
		ok, focus = pcall(GetMouseFoci)
		if ok and type(focus) == "table" then return focus[1] == nil or focus[1] == WorldFrame end
	end
	if GetMouseFocus then
		ok, focus = pcall(GetMouseFocus)
		if ok then return focus == nil or focus == WorldFrame end
	end
	return nil
end

-- Every frame (the cursor's travel is per frame, the painter runs at 40 a second).
local function trackMouse()
	local dx, dy = call(GetCursorDelta)
	local readable = type(dx) == "number" and type(dy) == "number" and not secret(dx, dy)
	local looking = IsMouselooking and IsMouselooking() and true or false
	local left = not looking and IsMouseButtonDown and IsMouseButtonDown("LeftButton") and true or false
	-- A left drag moves the camera only when it starts on the world, not on a window.
	if left and not mouse.left then mouse.leftWorld = overWorld() end
	mouse.left = left
	if looking or left then
		mouse.dragged = true
		if readable and (looking or mouse.leftWorld == true) then mouse.dy = mouse.dy + dy else mouse.blind = true end
	end
	local facing = looking and readable and ownFacing() or nil
	if facing and mouse.facing then
		local df = (facing - mouse.facing + math.pi) % (2 * math.pi) - math.pi
		mouse.travel, mouse.turned = mouse.travel + math.abs(dx), mouse.turned + math.abs(df) -- for the probe
		mouse.turn = stroke(mouse.turns, dx, df, SEGMENT) or mouse.turn
	else
		mouse.turn = endStroke(mouse.turns, SEGMENT, true) or mouse.turn
		if facing and dx ~= 0 then mouse.turns.dirty = true end -- a drag begun on the move
	end
	mouse.facing = facing
end

-- The cursor's upward travel under a camera drag since the last paint, whether
-- there was a drag, and whether some of it could not be read.
local function takeMouse()
	local dy, dragged, blind = mouse.dy, mouse.dragged, mouse.blind
	mouse.dy, mouse.dragged, mouse.blind = 0, nil, nil
	return dy, dragged, blind
end

-- A drag with the marker measuring the pitch at both ends of a paint: the
-- tilt per cursor unit, sign and all, straight from the game. `pitch` nil:
-- nothing measured this paint, which ends the stroke.
local function learnTilt(dy, dragged, blind, pitch)
	local last, at = mouse.pitch, mouse.pitchAt
	mouse.pitch, mouse.pitchAt = pitch, clock
	if not (pitch and dragged and not blind and last and clock - at < 0.2) or pitch <= -1.19 or pitch >= 1.44 then
		mouse.tilt = endStroke(mouse.tilts, SEGMENT / 2, true) or mouse.tilt
		if pitch and dragged and dy ~= 0 then mouse.tilts.dirty = true end
		return
	end
	mouse.tilt = stroke(mouse.tilts, dy, pitch - last, SEGMENT / 2) or mouse.tilt
end

-- No marker measured this paint's drag: the pitch follows the mouse. At the
-- end of the view's travel it is known outright, whatever it was reckoned from.
local function reckonTilt(dy)
	local rate = tiltPerUnit()
	if not rate then return false end
	local pitch = camState.pitch + rate * dy
	camState.strayed = (camState.strayed or 0) + math.abs(rate * dy)
	if pitch >= LOOK_DOWN or pitch <= -LOOK_DOWN then
		pitch = pitch > 0 and LOOK_DOWN or -LOOK_DOWN
		camState.locked, camState.lost, camState.lostAt, camState.adrift = true, false, nil, false
		camState.anchor, camState.strayed = "the end of the view's travel", 0
	end
	camState.pitch, camState.reckoned, camState.steady = pitch, true, pitch
	return true
end

-- In the air. The camera rides with the character, so through a jump the
-- ground drops away under a trail drawn from the feet, and the sparkles would
-- hop with the character. The client gives no height, only that the
-- character is falling, so the flight is the game's own: up at JUMP_SPEED when
-- a jump key was down as the ground was left (none when it was not: a step
-- off a ledge), and down by GRAVITY. Where the keys cannot be read every
-- flight is taken for a jump, the common case.
local air = {}
local jumpKeys, jumpKeysAt = {}, -math.huge

local function jumpKeyDown()
	if not (GetBindingKey and IsKeyDown) then return nil end
	if clock - jumpKeysAt > 5 then
		jumpKeysAt = clock
		wipe(jumpKeys)
		local a, b = call(GetBindingKey, "JUMP")
		if type(a) == "string" then jumpKeys[#jumpKeys + 1] = a:match("[^-]+$") or a end
		if type(b) == "string" then jumpKeys[#jumpKeys + 1] = b:match("[^-]+$") or b end
	end
	if #jumpKeys == 0 then return nil end
	for i = 1, #jumpKeys do
		local ok, down = pcall(IsKeyDown, jumpKeys[i])
		if ok and down == true then return true end
	end
	return false
end

-- Every frame: a jump key is down for a moment, and leaving the ground is timed to the frame.
local function trackAir(elapsed)
	local key = jumpKeyDown()
	air.keys = key ~= nil
	if key then air.keyAt = clock end
	if call(IsFalling, "player") == true then
		if not air.since then
			air.since = clock - elapsed / 2
			air.jump = not air.keys or (air.keyAt ~= nil and clock - air.keyAt <= JUMP_KEY)
			air.from, air.down = nil, nil
		end
	else
		air.since, air.from, air.down = nil, nil, nil
	end
end

-- Yards the feet are above the level they left the ground at (below it when
-- negative), or nil on the ground.
local function flight()
	if not air.since then return nil end
	local t = clock - air.since
	return (air.jump and JUMP_SPEED * t or 0) - GRAVITY * t * t / 2
end

-- Down again by the reckoning but still in the air: with the jump key held
-- the game jumps again at once. `known`: the ground under the feet is, so
-- staying in the air on it can only be another jump.
local function touchDown(floor, known)
	air.down = air.down or clock
	if (air.keyAt and clock - air.keyAt < 0.05) or (known and not air.keys and clock - air.down > 0.12) then
		air.since, air.jump, air.from, air.down = clock, true, floor, nil
	end
end

local function dragging()
	return (IsMouselooking and IsMouselooking()
		or IsMouseButtonDown and (IsMouseButtonDown("LeftButton") or IsMouseButtonDown("RightButton"))) and true or false
end

local function cameraMoving(zoom)
	local moving = dragging()
	if camState.zoom ~= zoom then
		camState.zoom = zoom
		moving = true
	end
	return moving and true or false
end

-- Moving over the ground, or in the air above it (a jump, a fall): the
-- waypoint's height against the feet is changing.
local function travelling()
	if air.since then return true end
	local speed = ownSpeed()
	return speed ~= nil and speed > 0
end

-- Yaw and pitch from the marker for a waypoint `dz` above the feet. When the
-- marker's distance is longer than the flat distance to it (a distance
-- measured in 3D) the height is that difference instead: the two heights it
-- could be, the one keeping the camera's pitch steadiest wins.
local function solveWithHeight(rx, ry, d3, ax, ay, zoom, focal, width, height, yaw0, dz)
	local d2 = math.sqrt(rx * rx + ry * ry)
	local best
	local h = d3 and d3 > d2 + 1 and math.sqrt(d3 * d3 - d2 * d2) or 0
	-- Above or below is not chosen afresh where this place has been found to lie on one side (`dz`, the height
	-- it is expected at): chosen by the steadier tilt each time, a drag that tilts the view by about as much as
	-- the two readings lie apart would swap the place to the other side and leave the tilt as it was.
	local side = h > 0 and dz and math.abs(dz) > 1 and (dz > 0 and h or -h) or nil
	-- With no side known, the reading that keeps the tilt steadier is taken; where nothing has measured the
	-- tilt since a drag (camState.stale) there is no tilt to keep steady, and it is the reading nearer the
	-- ordinary view. The third result is how far apart the two readings lay where both were to be had.
	local keep = camState.stale and camState.usual or camState.pitch
	local apart
	for _, z in ipairs(side and { side, -side } or h > 0 and { h, -h } or { dz }) do
		local yaw, pitch, miss = Trail.SolveCamera(rx, ry, ax, ay, zoom, focal, width, height, yaw0, camState.pitch, false, z)
		if yaw and miss <= 4 then
			local jump = math.abs(pitch - keep)
			if best then apart = math.abs(pitch - best.pitch) end
			if not best or jump < best.jump then best = { yaw = yaw, pitch = pitch, miss = miss, dz = z, jump = jump } end
			if side then break end
		end
	end
	return best, h > 0, apart
end

-- With the pitch held: the yaw, and the height the marker then stands at.
local function solveHeld(rx, ry, ax, ay, zoom, focal, width, height, yaw0, dz)
	local yaw, miss
	for _ = 1, 2 do
		local _
		yaw, _, miss = Trail.SolveCamera(rx, ry, ax, ay, zoom, focal, width, height, yaw or yaw0, camState.pitch, true, dz)
		if not yaw or miss > 4 then return nil end
		dz = Trail.HeightAt(Trail.Camera(yaw, camState.pitch, zoom, focal, width, height), rx, ry, ay)
		if not dz then return nil end
	end
	return { yaw = yaw, pitch = camState.pitch, miss = miss, dz = dz }
end

-- The flat distance to a place `away` yards off through the air and `dz` above or below.
local function flatTo(away, dz)
	local flat2 = away * away - dz * dz
	return flat2 > 1 and math.sqrt(flat2) or 1
end

-- Whether the marker stands where the route's current stretch ends: a map pin by its place (gx, gy), any
-- other marker by its flat distance. Only then is the marker's height the height the walk ends at.
local function atRouteEnd(path, px, py, gx, gy, flat)
	if not path then return false end
	local ex, ey = path.xs[path.n], path.ys[path.n]
	if type(gx) == "number" then
		return (gx - ex) ^ 2 + (gy - ey) ^ 2 <= GOAL_NEAR * GOAL_NEAR
	end
	local de = math.sqrt((ex - px) ^ 2 + (ey - py) ^ 2)
	return math.abs(de - flat) <= math.max(GOAL_NEAR, flat * 0.05)
end

-- The ground at the waypoint above the feet, when the baked leg ends there.
local function pinRise(path, gx, gy, baseZ)
	if not (baseZ and path.strip and path.coverage >= path.total - 1) then return 0 end
	local ex, ey = path.xs[path.n] - gx, path.ys[path.n] - gy
	if ex * ex + ey * ey > PIN_AT_END * PIN_AT_END then return 0 end
	local z = Trail.BakedHeight(path, path.coverage)
	return z and z - baseZ or 0
end

-- The camera from the marker of Polestar's own map pin: yaw, pitch, the pin's
-- height and flat distance, or nil and why not. The pin's place on the map is
-- the one Polestar gave it, so the marker measures the turn and the tilt at
-- once. (marker() lets no other marker through: one the game put up by itself
-- stands at a place and a height that could only be guessed.)
--
-- `up`: yards the feet are above the ground just now (a jump). The marker
-- stands that much lower against them, by the flight's reckoning; what it
-- shows beyond that in the air is taken for the flight's error, and neither
-- the height learnt nor a held pitch is changed by it.
local function fromMarker(c, px, py, path, ax, ay, d3, zoom, focal, width, height, baseZ, up)
	if not ax then return nil end
	-- A place near by whose marker shows in the lower half of the screen lies beside the character or
	-- between it and the camera, and the same spot on the screen is also where a camera lying on the
	-- ground, turned another way, would show a place ahead of it. A solve free to turn the view cannot tell
	-- the two apart: started from a tilt that is out it settles on the wrong one, and walking past such a
	-- place with the camera untouched it wanders from the one to the other, an ordinary view read as one
	-- turned up and called exact. (A marker in the upper half has only the one reading: a level place shows
	-- above the middle of the screen in no view but one looking down.) So such a marker measures nothing,
	-- whatever it stands for, and the tilt is held.
	if d3 and ay < height / 2 and d3 < pinned.close + 2 * zoom then return nil, TOO_NEAR end
	local gc, gx, gy = waypointWorld()
	-- A pin the game can't place in the world (one set on a world or stitched
	-- map): the route's end stands in when the marker's distance says it is
	-- there. Its place is then only near enough for a level distance.
	if gc ~= c and d3 and path then
		local ex, ey = path.xs[path.n], path.ys[path.n]
		local de = math.sqrt((ex - px) ^ 2 + (ey - py) ^ 2)
		if math.abs(de - d3) <= math.max(5, d3 * 0.03) then gc, gx, gy, d3 = c, ex, ey, nil end
	end
	-- Nor is a pin read whose place in the world is not known at all.
	if gc ~= c then return nil, "the pin's place in the world is not known" end
	if camState.gx ~= gx or camState.gy ~= gy then
		camState.gx, camState.gy, camState.lift, camState.pinAt, camState.guess = gx, gy, 0, clock, nil
	end
	local rx, ry = gx - px, gy - py
	-- A pin that has just moved: the game's marker may show where the last
	-- one was for a frame or more yet, and the new place solved against that
	-- would swing the whole view round for as long. Until PIN_SETTLE the
	-- marker is believed only where it shows about where the camera, as it
	-- was a paint ago, puts the new pin (sideways: its height is not known).
	if camState.pinAt and clock - camState.pinAt < PIN_SETTLE and camState.yaw and camState.cam then
		local sx = Trail.Project(camState.cam, rx, ry, 0)
		if not sx or math.abs(sx - ax) > width * PIN_AGREE then return nil, SETTLING end
	end
	local d2 = math.sqrt(rx * rx + ry * ry)
	local rise = path and pinRise(path, gx, gy, baseZ) or 0
	local yaw0 = camState.yaw or ownFacing() or 0
	local moving = cameraMoving(zoom)
	local expect = rise + camState.lift - up
	local sol
	if camState.locked and not camState.stale and not moving and travelling() then
		sol = solveHeld(rx, ry, ax, ay, zoom, focal, width, height, yaw0, expect)
		if sol and air.since then
			sol.dz = expect
		elseif sol and math.abs(sol.dz - rise) <= math.max(LIFT_MAX, d2 * 0.5) then
			camState.lift = sol.dz - rise
		else
			-- No believable height explains the marker at this pitch: the camera
			-- moved. The height learnt before it did still stands.
			sol = nil
		end
	end
	if not sol then
		-- A place with a height, met with no side known for it (above or below: the two distances say only how
		-- far), or with one that was only a guess. The walking maps say, where they hold the place: the ground
		-- there lies near the one height or the other. A guess is held against them twice a second until they do.
		local adrift = camState.stale
		if d3 and d3 > d2 + 1 and not air.since
			and (math.abs(expect) <= 1 or (camState.guess and clock - (camState.guessAt or -math.huge) >= 0.5)) then
			camState.guessAt = clock
			local h = math.sqrt(d3 * d3 - d2 * d2)
			local T = NS.Terrain
			if T and T.PlaceLift and baseZ and camState.reads then
				local toward = math.atan2(ry, rx)
				local lift = T.PlaceLift(c, px, py, clock, camState.reads, toward, d3, baseZ, h)
				if lift and math.abs(lift - h) <= math.max(4, h * 0.25) then
					expect, adrift, camState.guess = h, false, nil
				else
					lift = T.PlaceLift(c, px, py, clock, camState.reads, toward, d3, baseZ, -h)
					if lift and math.abs(lift + h) <= math.max(4, h * 0.25) then expect, adrift, camState.guess = -h, false, nil end
				end
			end
		end
		local measured, apart
		sol, measured, apart = solveWithHeight(rx, ry, d3, ax, ay, zoom, focal, width, height, yaw0, expect)
		if not sol then return nil, "the camera can't be worked out from the marker" end
		-- A pin whose side is only a guess reads no view flatter than pinned.flat: where the guess is out,
		-- the marker reads a view turned up at the sky. A pin whose height is known is gone by whatever it
		-- reads: there a look up at the sky is measured, not guessed.
		if sol.pitch < pinned.flat and camState.guess then return nil, UNPLACED end
		if measured then camState.lift = sol.dz - rise + up end
		-- A side taken with nothing to go by but the ordinary view, the two readings far apart: the tilt is
		-- one of two, and is not called exact while this place is the marker's.
		if adrift and apart and apart > 3 * WOBBLE then camState.guess = true end
		camState.pitch, camState.pitchAt, camState.locked, camState.stale = sol.pitch, clock, true, false
	end
	camState.adrift = false
	camState.lost, camState.lostAt, camState.reckoned, camState.d2, camState.d3 = false, nil, false, d2, d3
	-- Exact, but for a pin whose side is a guess.
	camState.exact, camState.pinChecked = not camState.guess, nil
	camState.steady = sol.pitch
	camState.anchor, camState.strayed = "the marker", 0
	camState.ax, camState.ay, camState.seenAt, camState.markZ = ax, ay, clock, sol.dz
	if not moving and sol.pitch >= UP_VIEW then camState.usual = sol.pitch end
	return sol.yaw, sol.pitch, sol.dz, d2, sol.miss
end

-- With the marker off screen nothing measures the tilt: the trail is drawn at
-- the pitch the marker last gave, which is right until the view is tilted
-- again. A marker that slips off the top or bottom of the screen is the
-- common case (a far marker stands at the horizon, which is at the top edge
-- of an ordinary view looking down at the character), so that alone hides
-- nothing: hidden then, the trail would stay away for as long as the marker
-- did. It is hidden only while there is evidence that the held pitch is
-- wrong: the game pins a map pin's marker a long way, up or down the screen,
-- from anywhere the held pitch could put the pin ahead of the camera. Pinned
-- straight out sideways or toward the screen's centre are both taken as
-- possible.
--
-- One case says more than "wrong", and hides nothing: a marker the game has
-- pinned to the top edge for a place that the held pitch puts ahead and on
-- the screen. The place is then above the top of the view, whichever way the
-- game goes about pinning, so the view is tilted down at least as far as
-- puts it there: the second result, the least pitch that does, for the place
-- as high as the game's distance to it lets it lie (the bound holds for any
-- lower). It is the everyday case, a far place ahead in a view looking down
-- at the character.
local function tiltContradicted(c, px, py, path, yaw, zoom, focal, width, height)
	pinned.over = nil
	if not pinned.off then return false end
	if not (yaw and pinned.y) then return false end
	local gc, gx, gy = waypointWorld()
	if gc == nil and path then
		-- A pin the game can't place: the route's end, if the marker last stood in for it there.
		gx, gy = path.xs[path.n], path.ys[path.n]
		if camState.gx == gx and camState.gy == gy then gc = c end
	end
	if gc ~= c then return false end
	local rx, ry = gx - px, gy - py
	local cam = Trail.Camera(yaw, camState.pitch, zoom, focal, width, height)
	local sx, sy, depth = Trail.Project(cam, rx, ry, camState.markZ or 0)
	if not sx or depth < 5 then return false end
	local top = height - Trail.PIN_INSET
	if pinned.clamped and pinned.y >= top - 2 and sx >= 0 and sx <= width then
		-- Over the top of the view, for a place ahead: the view looks down at least as far as the tilt held
		-- (pinned.over), whatever else is not known of it.
		pinned.over = true
		-- As high as the place can lie: what the game's distance leaves over the flat one, a yard given to
		-- how well the two agree, and no lower than the marker last showed it in view.
		local d, flat2 = pinned.d, rx * rx + ry * ry
		local hz = d and (d + 1) ^ 2 > flat2 and math.sqrt((d + 1) ^ 2 - flat2) or 0
		if camState.gx == gx and camState.gy == gy and camState.markZ and camState.markZ > hz then hz = camState.markZ end
		local _, y = Trail.Project(cam, rx, ry, hz)
		-- A thirtieth of the screen's height is left to what the camera's own place is out by.
		if y and y < top - height / 30 then
			local lo, hi = camState.pitch, LOOK_DOWN
			for _ = 1, 14 do
				local mid = (lo + hi) / 2
				_, y = Trail.Project(Trail.Camera(yaw, mid, zoom, focal, width, height), rx, ry, hz)
				if y and y < top then lo = mid else hi = mid end
			end
			return false, hi
		end
	end
	local lo, hi = height / 2, sy < 0 and 0 or sy > height and height or sy
	if lo > hi then lo, hi = hi, lo end
	local y = pinned.y < 0 and 0 or pinned.y > height and height or pinned.y
	return y < lo - height * TILT_OFF or y > hi + height * TILT_OFF
end

-- Without a usable marker (none of Polestar's own, or its pin off screen or
-- too near to read): the camera sits behind the character, as
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
		camState.behind = true -- mouselook turns the character to the view: the camera stands behind it
	elseif IsMouseButtonDown and IsMouseButtonDown("LeftButton") then
		leftSince = leftSince or now
		camState.moving = 0
		if now - leftSince >= LEFT_HOLD then camState.turned, camState.behind = true, false end
	else
		leftSince = nil
		if camState.turned then
			local speed = ownSpeed() or 0
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
	leftSince, lastTick, camState.moving, camState.behind = nil, nil, 0, false
	-- A drag that went by unpainted is not reckoned later; what the mouse was
	-- found to do per unit stays.
	if mouse.dragged then camState.stale, camState.exact, camState.adrift = true, false, true end
	mouse.dy, mouse.dragged, mouse.blind, mouse.facing, mouse.pitch = 0, nil, nil, nil, nil
	for _, s in ipairs({ mouse.turns, mouse.tilts }) do s.x, s.v, s.a, s.idle, s.dirty = 0, 0, 0, 0, nil end
end

local function reckoned(zoom, measured)
	-- No measured pitch in first person: omit only this view, never latch on
	-- mouse input. Zooming out restores the ordinary third-person estimate.
	if zoom <= 0 and not measured then return nil, "no measured camera pitch in first person" end
	if not GetPlayerFacing then return nil end
	if camState.turned then return nil, "the camera may have been turned away from your character (right-drag to re-centre or bring the waypoint into view)" end
	local facing = ownFacing()
	if not facing then return nil, "no facing here" end
	return facing + (camState.offset or 0), camState.pitch
end

-- The tilt from a marker the game has pinned to the screen's edge (the rule is
-- Trail.PinnedPitch's). It needs the bearing of the marker's place, and so the
-- place itself, which Polestar's own map pin has on the map. While the tilt
-- is exactly known the rule is only checked against it, and given up for the
-- session when it is 8 degrees out twice before ever agreeing (another client
-- may pin its marker another way).
local UP = "the view is turned up past the waypoint marker (none of the ground ahead is in view)"
local PIN_EASE = 0.25   -- seconds the game slides a marker to its pinned place over; not read meanwhile
local PIN_SMOOTH = 0.08 -- seconds the tilt read from a pinned marker is smoothed over (it runs a frame behind a turn)
local PIN_CHECK = math.rad(8)
-- near, nearZooms: a pinned marker whose place is nearer than `near` yards gives no tilt, nor one nearer
-- than nearZooms times the camera's distance (fields, not locals: this chunk has few to spare). At that
-- distance the place's bearing from the camera and from the character are seven degrees apart at most.
-- over: radians taken on top of the least tilt a marker pinned over the top of the view allows (unmeasured).
-- glance: radians a tilt seen only in a drag may stand off the ordinary view's and still be kept after it.
local pinLaw = { bad = 0, near = 100, nearZooms = 8, over = 0.05, glance = 0.5 }

-- The bearing of the pinned marker's place round to the right of the view, and
-- how far off the place is; nil where the place is not known. back: seen from
-- that many yards behind the player along the view, where the camera stands,
-- instead of from the player.
local function placeBearing(c, px, py, yaw, back)
	local gc, gx, gy = waypointWorld()
	if gc ~= c then
		gx, gy = nil, nil
		-- A pin the game can't place, when the route's end last stood in for it.
		if type(camState.gx) == "number" then gx, gy = camState.gx, camState.gy end
	end
	if not gx then return nil end
	back = back or 0
	local cx, cy = px - back * math.cos(yaw), py - back * math.sin(yaw)
	return (yaw - math.atan2(gy - cy, gx - cx) + math.pi) % (2 * math.pi) - math.pi, math.sqrt((gx - px) ^ 2 + (gy - py) ^ 2)
end

-- The tilt the pinned marker gives this paint, or nil and why not (UP: the
-- marker says the view is turned up at the sky).
--
-- The rule was measured on a marker whose place was about level with the
-- player. For a place well above or below, the game may pin the marker by
-- where the place is in the view (the rule then reads the tilt out by the
-- place's own drop) or by its bearing alone (the rule then reads true): no
-- recording says which, and the reading is taken as the rule gives it.
local function pinnedTilt(c, px, py, yaw, width, height, dt, zoom)
	pinLaw.reads, pinLaw.readsBack, pinLaw.tooNear = nil, nil, nil
	if not (pinned.off and pinned.clamped and pinned.x) then
		pinned.corner, pinned.edge = nil, nil
		return nil
	end
	-- How far inside the screen the game pins: where a marker rests on an edge two paints running.
	local edge = math.min(pinned.x, width - pinned.x, pinned.y, height - pinned.y)
	if pinned.edge and math.abs(edge - pinned.edge) < 0.05 and edge > 0.5 and edge < 60 then pinLaw.inset = edge end
	pinned.edge = edge
	if pinLaw.off or clock - (pinned.since or clock) < PIN_EASE then return nil end
	local inset = pinLaw.inset or Trail.PIN_INSET
	local hx, hy = width / 2 - inset, height / 2 - inset
	local dx, dy = pinned.x - width / 2, pinned.y - height / 2
	local bearing, away = placeBearing(c, px, py, yaw)
	-- The rule was measured on a place a mile off, which the camera sees where the character does. A place
	-- near by it does not: the camera stands the zoom's length behind the character and well above the
	-- ground, so a place a few yards behind the character lies ahead of the camera and under its view, and
	-- one a hundred yards off to the side is ten degrees further round for the one than for the other. How
	-- the game pins such a place is not recorded, and read by the rule it has given a tilt of sixty degrees
	-- and more in an ordinary view. Nearer than pinLaw.near yards, or pinLaw.nearZooms times the zoom, the
	-- pinned marker says nothing of the tilt (nor of its own place), and the tilt is held.
	zoom = zoom or 0
	away = pinned.d or away
	local near = away and away < math.max(pinLaw.near, pinLaw.nearZooms * zoom) or false
	if not bearing then return nil end
	local pitch, kind = Trail.PinnedPitch(dx, dy, bearing, hx, hy)
	-- For the probe, so that a report can settle it: what the rule reads by the place's bearing from the
	-- character, as it was measured, and what it would by its bearing from where the camera stands.
	pinLaw.reads, pinLaw.tooNear = pitch, near
	pinLaw.readsBack = (Trail.PinnedPitch(dx, dy, placeBearing(c, px, py, yaw, zoom * math.cos(camState.pitch or 0)), hx, hy))
	if near then
		pinned.corner = nil
		return nil, "the marker's place is too near for where it is pinned to give the tilt"
	end
	-- A marker resting in a bottom corner, or one for a place ahead pinned along the bottom: the view is turned up.
	pinned.corner = kind == "corner" and dy < 0 and (pinned.corner or clock) or nil
	if kind == "ahead under the view" or (pinned.corner and clock - pinned.corner >= 0.3) then return nil, UP end
	if not pitch then return nil, kind end
	if camState.exact then
		-- The tilt is known without it: the rule is only held against it, where the place is level.
		if not camState.pinChecked then
			camState.pinChecked = true
			if math.abs(pitch - camState.pitch) <= PIN_CHECK then
				pinLaw.good, pinLaw.bad = true, 0
			else
				pinLaw.bad = pinLaw.bad + 1
				if pinLaw.bad >= 2 and not pinLaw.good then pinLaw.off = true end
			end
		end
		return nil, "the tilt is known"
	end
	if camState.pinnedAt and clock - camState.pinnedAt < 0.3 and dt > 0 then
		pitch = camState.pitch + (pitch - camState.pitch) * (1 - math.exp(-dt / PIN_SMOOTH))
	end
	camState.pinnedAt = clock
	return pitch, kind
end

-- No marker measures the camera this paint: its turn is the facing's, its tilt
-- the last one known, carried on by the mouse or read from a marker the game
-- has pinned to the screen's edge. Returns the yaw and the pitch, or nil and
-- why nothing can be drawn.
local function unmeasured(c, px, py, path, zoom, focal, width, height, dt, mouseDy, dragged, blind, markerWhy)
	-- A drag no marker measured: the pitch follows the mouse where its
	-- travel is known. Where it is not, the camera may have been tilted, and
	-- the next usable marker measures the pitch afresh instead of holding it.
	local followed = false
	if dragged or dragging() then
		followed = dragged and not blind and reckonTilt(mouseDy)
		if not followed then camState.stale, camState.adrift = true, true end
		camState.exact = false
	end
	-- A marker the game has pinned to the screen's edge still gives the tilt
	-- (or says the view is turned up at the sky), where its place is known.
	local pin, pinWhy
	local turn = reckoned(zoom, true)
	if turn then pin, pinWhy = pinnedTilt(c, px, py, turn, width, height, dt, zoom) end
	-- A glance. A view turned up at the sky is one, and so is a tilt far from the view the player keeps
	-- (pinLaw.glance) that a marker showed in the middle of a drag: the mouse swings the view up, or
	-- steeply down, and back again in one stroke. Where the marker stops showing it (it leaves the view,
	-- or reaches an edge that gives no tilt) and the mouse cannot be followed, nothing sees the way back,
	-- and the tilt held on is the glance's: a view turned up is then drawn for a camera lying on the
	-- ground behind the character, the whole trail in the screen's last rows, a steep one stands it in
	-- the air as a column, for as long as nothing measures the tilt again. So once a drag nothing measured
	-- is over, such a tilt is given up for that of the last ordinary view (camState.usual). Not where a
	-- pinned marker still says the view is turned up, or stands over the top of a view held steeper than
	-- the ordinary one (which bears a steep tilt out), nor where the tilt is exactly known.
	local held = dragged or dragging()
	if not pin and pinWhy ~= UP and not held and camState.stale and not camState.exact then
		local far = camState.pitch - camState.usual
		local overTop = far > 0 and pinned.off and pinned.clamped and pinned.y and pinned.y >= height - Trail.PIN_INSET - 2
		if camState.pitch < UP_VIEW or (math.abs(far) > pinLaw.glance and not overTop) then
			camState.pitch, camState.steady, camState.reckoned = camState.usual, camState.usual, false
			camState.anchor, camState.strayed = "the last ordinary view (a tilt far from it was only a glance, and a drag nothing measured has ended since)", 0
		end
	end
	local yaw, pitch = reckoned(zoom, pin ~= nil)
	if pin then
		-- The next marker in view measures the tilt afresh: this one is near, not exact.
		camState.pitch, camState.stale, camState.reckoned, camState.adrift = pin, true, false, false
		if not (dragged or dragging()) then camState.steady = pin end
		camState.lost, camState.lostAt = false, nil
		camState.anchor, camState.strayed = "the pinned marker", 0
		if yaw then pitch = pin end
	elseif pinWhy == UP then
		camState.lost, camState.lostAt = false, nil
		if yaw then yaw, pitch = nil, UP end
	else
		-- A tilt the pinned marker contradicts counts as lost until LOST_HOLD seconds
		-- after the marker last did, or until a usable marker measures the tilt.
		local wrong, least = tiltContradicted(c, px, py, path, yaw, zoom, focal, width, height)
		if least then
			-- Pinned over the top of the view: the tilt is at least `least`, and nothing says how much more.
			-- A little more is taken, the place being as high as it could lie in that reckoning.
			least = math.min(least + pinLaw.over, LOOK_DOWN)
			camState.pitch, camState.steady, camState.exact, camState.stale, camState.reckoned = least, least, false, true, false
			-- A bound from below: out, it is too flat, which only squashes the trail toward the feet.
			camState.adrift = false
			camState.anchor, camState.strayed = "the marker pinned over the top of the view (the least tilt that puts its place there)", 0
			pitch = least
		elseif wrong then
			camState.lostAt, camState.locked = clock, false
		elseif pinned.over then
			-- The tilt held is the one the marker left the top of the view at, and the view looks down at
			-- least that far while the marker stays there: too flat if anything, which only squashes the
			-- trail toward the feet. It is drawn whole.
			camState.adrift = false
		end
		camState.lost = camState.lostAt ~= nil and clock - camState.lostAt < LOST_HOLD
		-- A tilt the pinned marker contradicts is a guess, and is drawn as one: the short trail from the feet.
		-- (It hid the trail outright once. But a marker is pinned low for a place ahead by two things, a view
		-- turned up and a place far below the player, and standing over a goal in a cave under the hill the
		-- trail was gone for as long as the player stood there.)
		if camState.lost then camState.adrift = true end
	end
	if not yaw then return nil, type(pitch) == "string" and pitch or markerWhy or "no camera" end
	-- The ordinary view: one at rest whose tilt something vouches for (the pinned marker's reading this
	-- paint, or a tilt exactly known and not touched since).
	if not held and (pin or camState.exact) and pitch >= UP_VIEW then camState.usual = pitch end
	camState.source = pin and "facing for the turn, the pinned marker for the tilt"
		or "facing (" .. (markerWhy or "no marker") .. ")"
	return yaw, pitch
end

-- Route heights: an accepted baked strip's, else a strip sampled from the walking maps (Terrain.Strip).
local heights = {}
local bakedOf, bakedPath
local fallbackOf, fallbackAlong
local shownOf, shownFloor
local HEIGHT_EASE = 0.3 -- settle observed floor-cell changes without changing strip data
local Terrain = NS.Terrain
local function profileAt(a)
	return Trail.BakedHeight(heights.path, a)
end

-- Diagnostics describe actual baked coverage, never an extrapolated tail: of a
-- sampled strip only what was read from the maps (`real`), not what it is
-- carried on by past a cell not read yet.
function Render.HeightsAhead()
	local along = heights.along
	if not along or not profileAt(along) then return nil end
	return math.max(0, (heights.path.real or heights.path.coverage) - along)
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
	-- path.left: what is left of the route itself, where the path is only a sampled stretch of it (Terrain.Strip).
	if path.kind ~= "walk" or not dist or dist > 25 or (path.left or path.total - along) < 10 then return false end
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
	local eyeIndoor = IsIndoors and IsIndoors() and true or false
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
local function drawnLength(path, px, py, along, cam, dt, sightAllowed, sightReady)
	local db = NS.db
	local maxLen = db.groundLength
	if not sightAllowed then
		sight.cutAt, sight.pending, sight.target, sight.drawn, sight.visible, sight.v, sight.held = nil, nil, nil, nil, nil, 0, nil
		return maxLen
	end
	if sight.path ~= path then sight.cutAt, sight.pending, sight.path = nil, nil, path end
	if clock - sight.at >= SIGHT_EVERY or not sight.cutAt then
		sight.at = clock
		local visible, unknown = nil, true
		if sightReady then visible, unknown = evaluateSight(path, px, py, along, maxLen, cam) end
		sight.visible = visible
		-- Ground not known yet (no floor, a map tile not read) neither grows nor
		-- shrinks the trail: it keeps its length. Only a hidden point fixes the
		-- end to a place on the route. The length kept is the one it had when
		-- the ground was last known (`held`), every frame until it is known
		-- again: held as a place instead, the end stood still while the player
		-- walked up to it, and the trail shrank to its shortest at every edge of
		-- what the maps had read.
		if unknown then sight.held = sight.held or sight.target or maxLen else sight.held = nil end
		local hold = along + (sight.held or maxLen)
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
	local target = sight.held or sight.cutAt - along
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

local lastDraw, shownAt

-- A route that changes, or ends. Each paint keeps what it drew as places in
-- the world: every sparkle's spot and height, its number and how strongly it
-- showed. When the way ahead is then another line, or there is no route any
-- more, that trail stays where it lay and fades out over FADE seconds,
-- twinkling on but no longer flowing, while the new one fades in over the
-- same time; the two add up to one trail's brightness throughout.
--
-- A change is the line ahead of the player moving, not the route being built
-- again: the route is announced whenever a later leg of it is found, a plan
-- of the same walk replaces the last one every so often, and the same walk is
-- drawn from its baked strip or from the route's own points as each is to be
-- had. So the two lines are compared where the trail can reach, from the
-- player's place on each: with every point of either no further than SAME
-- yards from the other, they are one route and nothing fades. The player's
-- place along a path is only as fresh as the walker's last step along it (a
-- rider is yards on by then), so each line is given SAME_SLIP yards more at
-- both ends when the other is held against it.
--
-- A route found in stages (a straight line, a sketch, the path) replaces
-- itself several times in a moment: a trail replaced before it had begun to
-- show is simply dropped, and up to MAX_FADES trails fade at once, the
-- faintest giving way to a new one, in at most one more Max sparkles between
-- them. Where the trail is hidden outright (turned off, the guide hidden, a
-- loading screen, a flight, indoors with that setting off) it goes at once,
-- and nothing is kept.
local FADE = 0.6     -- seconds a replaced trail fades out over, and its successor in
local SAME = 3       -- yards two lines may lie apart, all the way the trail reaches, and be one route
local SAME_SLIP = 8  -- yards along them the player's place on the one may be behind the other's
local MAX_FADES = 3  -- replaced trails fading at once
local FAINT = 0.02   -- of its full strength: a trail replaced this early in its own fade-in is not faded out
local fades = {}     -- newest first: { [i] = sparkle, n = how many, at = when it was replaced, level, ground }
local shown          -- the trail as last painted: the same, with seen = when
local shownPath      -- the path that trail lay along,
local shownAlong     -- and the player's place on it (yards along)
local inAt           -- when the trail now drawn began to fade in (nil: it is in)
local spare = {}

local function eased(u)
	if u <= 0 then return 0 elseif u >= 1 then return 1 end
	return u * u * (3 - 2 * u)
end

-- Whether line a, for `reach` yards from `aFrom`, keeps within SAME yards of
-- line b's stretch from `bFrom` (and SAME_SLIP yards either side of it).
local lineX, lineY = {}, {}
local function keepsTo(a, aFrom, b, bFrom, reach)
	local lo, span = bFrom - SAME_SLIP, reach + 2 * SAME_SLIP
	local n = math.ceil(span / 3)
	if n < 12 then n = 12 elseif n > 60 then n = 60 end
	for j = 0, n do lineX[j], lineY[j] = Trail.PointAt(b, lo + span * j / n) end
	local m = math.ceil(reach / 3)
	if m < 8 then m = 8 elseif m > 40 then m = 40 end
	for i = 0, m do
		local x, y = Trail.PointAt(a, aFrom + reach * i / m)
		local near = false
		for j = 0, n - 1 do
			local ax, ay = lineX[j], lineY[j]
			local dx, dy = lineX[j + 1] - ax, lineY[j + 1] - ay
			local len2 = dx * dx + dy * dy
			local t = len2 > 0 and ((x - ax) * dx + (y - ay) * dy) / len2 or 0
			if t < 0 then t = 0 elseif t > 1 then t = 1 end
			local qx, qy = ax + dx * t - x, ay + dy * t - y
			if qx * qx + qy * qy <= SAME * SAME then
				near = true
				break
			end
		end
		if not near then return false end
	end
	return true
end

local function sameLine(a, aAlong, b, bAlong, reach)
	return a.c == b.c and keepsTo(a, aAlong, b, bAlong, reach) and keepsTo(b, bAlong, a, aAlong, reach)
end

local function recycle(rec)
	rec.n = 0
	if #spare <= MAX_FADES then spare[#spare + 1] = rec end
end

-- The route's line this paint (nil: none), the player's place on it and how
-- far along it the trail can reach. `prev`: when the paint before this one
-- was, so only a trail that was on screen until now is faded out (not one
-- last drawn before the camera was lost, or before the painter was paused).
local function routeChanged(path, along, prev, reach)
	if path == shownPath then shownAlong = along return end
	if path and shownPath and sameLine(path, along, shownPath, shownAlong, reach) then
		shownPath, shownAlong = path, along
		return
	end
	local replaced = shownPath ~= nil
	local rec = shown
	if rec and rec.n > 0 and prev and rec.seen == prev and (rec.level or 0) > FAINT then
		shown, rec.at = nil, clock
		table.insert(fades, 1, rec)
		while #fades > MAX_FADES do
			local faintest, least
			for i = 1, #fades do
				local strength = fades[i].level * (1 - eased((clock - fades[i].at) / FADE))
				if not least or strength <= least then faintest, least = i, strength end
			end
			recycle(table.remove(fades, faintest))
		end
	elseif rec then
		rec.n = 0
	end
	shownPath, shownAlong = path, along
	inAt = path and (replaced or #fades > 0) and clock or nil
end

local function dropFades()
	for i = #fades, 1, -1 do recycle(table.remove(fades, i)) end
	if shown then shown.n = 0 end
	shownPath, shownAlong, inAt = nil, nil, nil
end

-- Whether a trail is fading out, or the last paint drew one that would.
local function fading()
	return #fades > 0 or (shown ~= nil and shown.n > 0 and lastDraw ~= nil and shown.seen == lastDraw)
end

-- The trails on their way out, after the one now drawn: each sparkle where it
-- lay and at the height it had (a known height against the feet now, or
-- against the ground they last stood on; a reckoned one as it was reckoned).
local function drawFades(cam, px, py, feet, up, lift, width, height, zoom, used)
	if #fades == 0 then return used end
	local near, size = NEAR_DEPTH, style.size * 1.6
	local budget = NS.db.maxSparkles
	for layer = 1, #fades do
		local f = fades[layer]
		local out = 1 - eased((clock - f.at) / FADE)
		local base = feet or (f.ground and f.ground + up)
		for i = 1, f.n do
			if budget <= 0 then return used end
			local q = f[i]
			local hz
			if q.z then hz = base and q.z - base else hz = q.rel - up end
			if hz then
				local alpha, scale, rotation = Trail.Sparkle(q.id, clock, style, q.fade * out)
				if alpha > 0.01 then
					local sx, sy, depth = Trail.Project(cam, q.x - px, q.y - py, hz + lift)
					if sx and sx >= 0 and sy >= 0 and sx <= width and sy <= height then
						local ds = near / depth
						if ds > 1.6 then ds = 1.6 end
						local s = size * scale * q.mul * ds
						if s >= 2.5 then
							used, budget = used + 1, budget - 1
							local dim = ds * (zoom > 2 and zoom + 3 or 5) / near
							place(gr, used, "BOTTOMLEFT", sx, sy, s, alpha * (0.45 + 0.55 * (dim < 1 and dim or 1)), rotation, true)
						end
					end
				end
			end
		end
	end
	return used
end

-- The trails fading out (newest first) and the trail as last painted, for tests and diagnostics.
function Render.Fades() return fades, shown end

-- Forgets the accepted-strip adapter and this painter's visibility history.
function Render.ResetGround()
	wipe(heights)
	bakedOf, bakedPath = nil, nil
	fallbackOf, fallbackAlong = nil, nil
	shownOf, shownFloor = nil, nil
	sight.cutAt, sight.pending, sight.target, sight.drawn, sight.visible, sight.v, sight.over, sight.held = nil, nil, nil, nil, nil, 0, 0, nil
	dropFades()
end

local function drawCamera(width, height, ax, ay, d3, used, markerWhy)
	local db = NS.db
	trackCamera()
	local prev = lastDraw
	local dt = prev and clock - prev or 0
	lastDraw = clock
	local c, px, py = playerPosition()
	local walk = P.Nav and P.Nav.walk
	local snapshot, progress = call(walk and walk.WorldTrail)
	if snapshot ~= bakedOf then bakedOf, bakedPath = snapshot, Trail.BakedPath(snapshot) end
	local path, along, dist
	-- The walking router found no way to the goal: the route is the straight line at it (Terrain.Clear).
	local unrouted = false
	wipe(heights)
	heights.source = "camera-estimate"
	if #paths == 0 then
		-- The route has gone: what was drawn of it is all there is, fading.
	elseif bakedPath and bakedPath.c == c and progress and progress.generation == snapshot.generation
		and Trail.BakedHeight(bakedPath, progress.sourceAlong)
		and progress.sourceAlong + db.groundAhead < bakedPath.coverage then
		path, along, dist = bakedPath, progress.sourceAlong, progress.off
		heights.path, heights.along, heights.source = path, along, "baked-strip"
	else
		path = paths[1] and smoothPath(paths[1])
		unrouted = path and path.unrouted or false
		-- No baked strip: the ground along the next stretch, sampled from the walking maps where they may be read.
		local strip, at, off
		if path and Terrain then
			strip, at, off = Terrain.Strip(path, c, px, py, clock, db.groundAhead, db.groundLength, readsAllowed, call(walk and walk.Floor, c, px, py))
		end
		if strip then
			path, along, dist = strip, at, off
			heights.path, heights.along, heights.source = path, along, "walking-map samples"
		end
	end
	local elsewhere = path and path.c ~= c
	if not c or elsewhere then path = nil end
	-- No route here: what was drawn of the last one is left to fade out.
	if not path then routeChanged(nil, nil, prev) end
	for i = #fades, 1, -1 do
		if clock - fades[i].at >= FADE then recycle(table.remove(fades, i)) end
	end
	if not path and (not c or #fades == 0) then
		why = not c and "no player position here"
			or elsewhere and "the route's current stretch is on another continent" or "no route"
		camState.yaw, shownAt = nil, nil return used
	end
	local zoom = GetCameraZoom and GetCameraZoom() or 15
	local focal = Trail.Focal(fov(), height)
	-- Floor() observes navigation's existing floor; it never starts a floor read.
	-- Without it, the strip at native progress is only an estimated baseline.
	local baseZ
	if heights.source == "walking-map samples" then
		-- A sampled strip is the ground as the maps have it, evened out, and the feet stand on it: their height
		-- is the strip's own at the player's place. The floor the arrow follows is the height of the cell under
		-- the player, which the maps round to 2 yd: up a slope it rises in steps a cell apart, and a trail drawn
		-- from it hops with every step and hangs above the ground between them.
		baseZ = profileAt(along)
		heights.floorSource, heights.floor = "walking-map estimate", baseZ
		shownOf, shownFloor = nil, nil
	elseif heights.path then
		baseZ = call(walk and walk.Floor, c, px, py)
		if type(baseZ) ~= "number" or baseZ ~= baseZ or math.abs(baseZ) == math.huge then baseZ = nil end
		heights.floorSource = baseZ and "observed-walk-floor" or "baked-strip estimate"
		baseZ = baseZ or profileAt(along)
		heights.floor = baseZ -- observation/estimate retained for LOS and diagnostics
		shownFloor = shownOf == path and shownFloor
			and shownFloor + (baseZ - shownFloor) * (1 - math.exp(-dt / HEIGHT_EASE)) or baseZ
		shownOf, baseZ = path, shownFloor
	else
		shownOf, shownFloor = nil, nil
	end
	-- In the air the feet are `up` yards above the ground the trail stands on.
	-- Where the ground is known they fly from the ground they left and come
	-- down on what is under them now (so a step off a ledge falls, too); where
	-- it is not, only a jump's rise over level ground is reckoned.
	local up = 0
	local rise = flight()
	if rise and baseZ then
		air.from = air.from or air.ground or baseZ
		local feet = air.from + rise
		if feet <= heights.floor then
			feet = heights.floor
			touchDown(feet, true)
		end
		up, air.feet = feet - baseZ, feet
	elseif rise and rise > 0 then
		up = rise
	elseif rise and air.jump then
		touchDown(nil, false)
	elseif baseZ then
		-- Down: the feet are on the ground under them, whatever the drawn floor had eased to.
		if air.feet then shownFloor, baseZ, air.feet = heights.floor, heights.floor, nil end
		air.ground = baseZ
	else
		air.ground, air.feet = nil, nil
	end
	local smartPivot = cvar("cameraPivot")
	Trail.pivotInPlace = smartPivot == "1" or smartPivot == 1 or smartPivot == true
	-- Whether the walking maps may be read this paint (the sight test's gate, and the one a marker's place is looked up by).
	camState.reads = Terrain and heights.path and baseZ and readsAllowed(path, dist, along) or false
	local yaw, pitch, dz, d2, miss = fromMarker(c, px, py, path, ax, ay, d3, zoom, focal, width, height, baseZ, up)
	local fromWhy = pitch
	local measured = yaw ~= nil
	local mouseDy, dragged, blind = takeMouse()
	learnTilt(mouseDy, dragged, blind, measured and pitch or nil)
	if measured then
		camState.source = "marker"
		-- The marker measures how far the camera is turned from the character.
		local facing = ownFacing()
		if facing then
			camState.offset = (yaw - facing + math.pi) % (2 * math.pi) - math.pi
			camState.turned = false
		end
	elseif fromWhy == SETTLING then
		-- The pin has moved and its marker has yet to follow: the camera as it
		-- was, turned on by the facing and tilted on by the mouse meanwhile.
		if (dragged or dragging()) and not (dragged and not blind and reckonTilt(mouseDy)) then camState.stale, camState.adrift = true, true end
		if dragged or dragging() then camState.exact = false end
		yaw = (reckoned(zoom, true)) or camState.yaw
		pitch, dz, d2, miss = camState.pitch, 0, 1, nil
		camState.source = "the camera as it was (" .. SETTLING .. ")"
	else
		markerWhy = type(fromWhy) == "string" and fromWhy or markerWhy
		yaw, pitch = unmeasured(c, px, py, path, zoom, focal, width, height, dt, mouseDy, dragged, blind, markerWhy)
		if not yaw then
			why = pitch
			camState.yaw, camState.miss, shownAt = nil, nil, nil return used
		end
		dz, d2, miss = 0, 1, nil
	end
	camState.yaw, camState.miss, camState.dz = yaw, miss, dz
	shownAt = shownAt or clock
	local reveal = (clock - shownAt) / REVEAL
	if reveal > 1 then reveal = 1 end
	-- The route climbs (or drops) toward the waypoint's height in step with the
	-- flat distance, from the ground under the feet: where the waypoint is where
	-- this stretch of the route ends. A pin anywhere else says nothing of the
	-- ground between here and there.
	-- Nor does a goal no way was found to: the line at it is no stairs up to it.
	d2 = d2 and d2 > 1 and d2 or 1
	local slope = measured and not unrouted and atRouteEnd(path, px, py, camState.gx, camState.gy, d2) and dz + up or 0
	if baseZ then baseZ = baseZ + up end
	-- A tilt that is only a guess (camState.adrift). The view turns about the character, so the feet show
	-- where they are whatever the tilt, and what a wrong tilt does to a place on the ground grows with its
	-- distance from them: ten degrees out, a place 25 yd ahead is drawn 4 yd over the ground or under it,
	-- one 5 yd ahead a few hands. Believed too steep, the far end lifts off the ground and into the sky;
	-- believed too flat, the trail is only squashed toward the feet. So the trail is drawn short, from nearer
	-- the feet, and at the flatter end of the views a player keeps: it points the way from the feet and
	-- cannot stand in the air or heap up. It grows back when something reads the tilt again.
	local loose = camState.loose or (camState.adrift and 1 or 0)
	loose = loose + ((camState.adrift and 1 or 0) - loose) * (1 - math.exp(-dt / 0.15))
	camState.loose = loose
	-- (The tilt goes flat as the trail shortens, and is the one read again the moment something reads it.)
	if camState.adrift and pitch > camState.flatView then pitch = pitch + (camState.flatView - pitch) * loose end
	local cam = Trail.Camera(yaw, pitch, zoom, focal, width, height)
	camState.cam = cam
	-- A raised trail is never drawn above the camera's own height: from a
	-- camera low on the ground it would hang in a view turned up at the sky.
	local lift = db.groundLift
	if lift > cam.z - 0.05 then lift = cam.z - 0.05 end
	if not path then return drawFades(cam, px, py, baseZ, up, lift, width, height, zoom, used) end
	if not along then
		along, dist = Trail.Nearest(path, c, px, py, fallbackOf == path and fallbackAlong or nil)
		if not along or dist > NEAR_PATH then along, dist = 0, nil end
		fallbackOf, fallbackAlong = path, dist and along or nil
	else
		fallbackOf, fallbackAlong = nil, nil
	end
	-- A route that took another's place fades in as that one fades out.
	routeChanged(path, along, prev, db.groundLength)
	if inAt then
		local u = (clock - inAt) / FADE
		if u >= 1 then inAt = nil else reveal = reveal * eased(u) end
	end
	-- Off the route's line (it runs a few yards beside you): the trail leaves
	-- from your feet and joins the route over MERGE yards.
	local offX, offY = 0, 0
	if dist then
		local qx, qy = Trail.PointAt(path, along)
		offX, offY = px - qx, py - qy
	end
	local spacing = db.groundGap
	local sightAllowed = db.groundSight and camState.reads
	local sightReady = sightAllowed and Terrain.Begin(c, px, py, clock, true)
	local length = drawnLength(path, px, py, along, cam, dt, sightAllowed, sightReady)
	if heights.path then length = math.min(length, path.coverage - along) end
	if unrouted then
		-- No way was found to the goal: the straight line at it is drawn as far as it can be walked, and no further.
		heights.noWay = true
		local can = Terrain and Terrain.Clear(path, c, px, py, call(walk and walk.Floor, c, px, py), along, length, clock)
		heights.clear = can
		if can and can < length then
			length = can
			if can <= db.groundAhead then why = "no way found, and the line at the goal cannot be walked from here" end
		end
	end
	local ahead = db.groundAhead
	if loose > 0.001 then
		local reach = math.max(camState.reachZooms * zoom, camState.minReach)
		local near = math.min(ahead, reach / 4)
		if reach < length then length = length + (reach - length) * loose end
		ahead = ahead + (near - ahead) * loose
	end
	local start = along + ahead
	local stop = along + length
	-- Sprites keep their size in the world, so a far camera sees them small
	-- (they'd crowd a zoomed-out trail at a fixed size on screen).
	local near = NEAR_DEPTH
	local size = style.size * 1.6
	local limit = db.maxSparkles
	-- What this paint draws is kept, to fade out should the route change (above).
	local rec, kept = shown, 0
	if not rec then
		rec = table.remove(spare) or {}
		shown = rec
	end
	-- A sparkle is numbered by its yards along the route. A sampled strip begins part-way along it (its
	-- origin) and begins somewhere else each time it is sampled again: counted from there, every sparkle
	-- would take another number and another place, and the whole trail would be laid afresh.
	local phase = groundPhase - (path.origin or 0) / spacing
	Trail.Emit(path, start, spacing, phase, SCAN_LIMIT, function(wx, wy, k, nx, ny, fade)
		local a = (k + phase) * spacing
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
		if loose > 0.001 then
			local far = 2 * (stop - a) / length
			if far < 1 then fade = fade * (1 - loose + loose * (far > 0 and far or 0)) end
		end
		-- The ground here, once for all of this point's glints.
		local pz = baseZ and profileAt(a)
		-- XY merge and lateral scatter remain best-effort visuals, not sampled
		-- ground away from the route. Do not extrapolate Z beyond strip coverage.
		if heights.path and not pz then return false end
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
				local lat, fwd, mul = side * style.jitter, 0, 1
				if j > 0 then
					lat = (Trail.Hash(id, 5) * 2 - 1) * width2
					fwd = (Trail.Hash(id, 6) - 0.5) * spacing
					mul = 0.55 + 0.35 * Trail.Hash(id, 7)
					scale = scale * mul
				end
				local ox, oy = wx + nx * lat + tx * fwd - px, wy + ny * lat + ty * fwd - py
				local hz
				if pz then
					hz = pz - baseZ
				else
					local way = math.sqrt(ox * ox + oy * oy) / d2
					hz = slope * (way < 1 and way or 1) - up
				end
				local sx, sy, depth = Trail.Project(cam, ox, oy, hz + lift)
				if sx and sx >= 0 and sy >= 0 and sx <= width and sy <= height then
					local ds = near / depth
					if ds > 1.6 then ds = 1.6 end
					local s = size * scale * ds
					if s >= 2.5 then
						used = used + 1
						local dim = ds * (zoom > 2 and zoom + 3 or 5) / near -- the far end dims, whatever the zoom
						place(gr, used, "BOTTOMLEFT", sx, sy, s, alpha * (0.45 + 0.55 * (dim < 1 and dim or 1)) * reveal, rotation, true)
						kept = kept + 1
						local q = rec[kept]
						if not q then
							q = {}
							rec[kept] = q
						end
						q.x, q.y, q.id, q.fade, q.mul = ox + px, oy + py, id, fade * reveal, mul
						if pz then q.z, q.rel = pz, nil else q.z, q.rel = nil, hz + up end
						if used >= limit then return false end
					end
				end
			end
		end
	end)
	rec.n, rec.seen, rec.level, rec.ground = kept, clock, reveal, baseZ and baseZ - up or nil
	return drawFades(cam, px, py, baseZ, up, lift, width, height, zoom, used)
end

function Render.GroundFrame() return gr end

function Render.CameraState() return camState end

-- What the ground trail is working from, for Render.Probe().
function Render.Probe()
	local C = P and P.Compat
	local ux, uy, uz = nil, nil, nil
	if C and C.GetPlayerUnitPosition then ux, uy, uz = C.GetPlayerUnitPosition() end
	local N = C_Navigation
	-- How far round from the view's own direction the pin's place lies (left
	-- positive): with where the game pins an off-screen marker, the two say
	-- how the game pins it.
	local bearing
	local facing = ownFacing()
	if facing and type(camState.gx) == "number" then
		local c, px, py = playerPosition()
		local toward = c and math.atan2(camState.gy - py, camState.gx - px) or nil
		if toward then bearing = (toward - facing - (camState.offset or 0) + math.pi) % (2 * math.pi) - math.pi end
	end
	local seen = pinned.seen == lastDraw
	-- The screen's scale (px for each unit of tan) as the pin's marker shows it, for a report to check
	-- Trail.Focal by. With the camera known to stand behind the character (mouselook was the last to turn
	-- it) the facing is the view's turn, and the pin's place gives its bearing from the camera: how far to
	-- the side the marker then shows fixes the scale by itself, whatever the tilt (the marker's direction
	-- keeps its share sideways as the view tilts). Only for a marker well off the middle of the screen.
	local scale
	if seen and pinned.own and camState.behind and facing and type(camState.gx) == "number" and camState.seenAt == lastDraw and gr then
		local c, px, py = playerPosition()
		local zoom = GetCameraZoom and GetCameraZoom() or 0
		local back, camZ = zoom * math.cos(camState.pitch), Trail.PIVOT + zoom * math.sin(camState.pitch)
		local cx, cy = px - back * math.cos(facing), py - back * math.sin(facing)
		local rx, ry = camState.gx - cx, camState.gy - cy
		local round = (facing - math.atan2(ry, rx) + math.pi) % (2 * math.pi) - math.pi
		local side = math.cos(math.atan2((camState.markZ or 0) - camZ, math.sqrt(rx * rx + ry * ry))) * math.sin(round)
		local dx, dy = camState.ax - gr:GetWidth() / 2, camState.ay - gr:GetHeight() / 2
		if c and math.abs(side) >= 0.15 then
			local f2 = dx * dx * (1 / (side * side) - 1) - dy * dy
			if f2 > 0 then scale = math.sqrt(f2) end
		end
	end
	return {
		zoom = GetCameraZoom and GetCameraZoom(),
		indoors = IsIndoors and IsIndoors() and true or false,
		navDistance = N and N.GetDistance and call(N.GetDistance),
		flat = camState.d2, height = camState.dz, yaw = camState.yaw, pitch = camState.pitch,
		tilt = camState.lost and "lost" or camState.pinnedAt ~= nil and camState.pinnedAt == lastDraw and "read from the pinned marker"
			or camState.reckoned and (camState.locked and "followed" or "followed from an assumed tilt")
			or not (camState.seenAt and camState.seenAt == lastDraw) and (camState.locked and "held" or "assumed")
			or camState.pitchAt == camState.seenAt and "measured" or "held",
		-- Which of the two ways the trail is working: reading Polestar's own map pin, or with no marker read.
		mode = seen and pinned.own and "pin" or "no pin",
		-- Full, or short because the tilt is a guess since the view was last dragged.
		trail = camState.adrift and "short" or "full",
		tracking = not seen and "nothing" or pinned.own and "Polestar's map pin"
			or pinned.pin and "a map pin Polestar did not set (not read)" or "something Polestar did not place (not read)",
		mouseTilt = tiltPerUnit(), mouseFrom = mouse.tilt and "marker" or mouse.turn and "turning" or nil,
		anchor = camState.anchor, strayed = camState.strayed, smartPivot = Trail.pivotInPlace,
		air = air.since and (air.jump and "jumping" or "falling") or nil, airHeight = flight(), jumpKeys = air.keys,
		cursor = type(GetCursorDelta) == "function", cursorTravel = mouse.travel, cursorTurned = mouse.turned,
		lift = camState.lift, markerX = pinned.x or camState.ax, markerY = pinned.y or camState.ay, offScreen = pinned.off and true or false,
		miss = camState.miss, why = Render.Why(), source = camState.source, locked = camState.locked and not (IsMouselooking and IsMouselooking()), facing = facing, z = uz, fov = fov(), floor = heights.floor, ahead = Render.HeightsAhead(), rise = Render.HeightsRise(),
		visible = sight.visible, drawn = sight.drawn,
		heightSource = heights.source, floorSource = heights.floorSource, sourceAlong = heights.along,
		-- No way found to the goal, and how many yards of the line at it can be walked (nil: nothing said against it).
		noWay = heights.noWay or false, clear = heights.clear,
		fadingOut = #fades, fadeIn = inAt and eased((clock - inAt) / FADE) or nil,
		-- A setting the client keeps of the view's tilt, if it has one and keeps it current.
		markerBearing = bearing, savedPitch = cvar("cameraSavedPitch"),
		pinRule = pinLaw.off and "given up" or pinLaw.good and "agreed" or "untried", pinInset = pinLaw.inset,
		-- What the pinned marker reads this paint by its place's bearing from the character and from the camera
		-- (false: the rule gives none), and whether its place is too near for either to be gone by.
		pinReads = pinned.off and pinLaw.reads ~= nil and pinLaw.reads or false, pinReadsBack = pinned.off and pinLaw.readsBack or false,
		pinNear = pinned.off and pinLaw.tooNear or false,
		exact = camState.exact and true or false,
		scale = scale, scaleUsed = gr and Trail.Focal(fov(), gr:GetHeight() or 0) or nil,
	}
end

-- /polestar trail record: what the game's marker does while the view is
-- tilted and turned through four timed steps, kept with the saved variables
-- (PolestarDB.trailRecording) for working out how this client pins a marker
-- it cannot show, and when it saves the view's tilt. It only watches:
-- nothing is set, moved or steered, and nothing reads the recording back.
local RECORD_STEPS = {
	{ 10, "1 of 4 (10 s): face the tracked marker so it shows on screen, about halfway between the middle and one side. Keep still." },
	{ 12, "2 of 4 (12 s): slowly tilt the view down until it stops, and hold it there. Do not turn." },
	{ 12, "3 of 4 (12 s): slowly tilt back up, on past level, until it stops looking up, and hold it. Do not turn." },
	{ 10, "4 of 4 (10 s): back to a normal view, then turn one slow full circle." },
}
local RECORD_FIELDS = "t,step,facing,markerX,markerY,clamped,valid,shown,distance,isPin,savedPitch,savedDistance,zoom,mouselook,leftButton,playerX,playerY,pinX,pinY,trailPitch,measured"
local recording

local function flag(v)
	if v == nil then return false end
	return v and 1 or 0
end

local function recordSample()
	local r = recording
	local t = clock - r.t0
	local step, ends = #RECORD_STEPS + 1, 0
	for i = 1, #RECORD_STEPS do
		ends = ends + RECORD_STEPS[i][1]
		if t < ends then
			step = i
			break
		end
	end
	if step > #RECORD_STEPS then
		recording = nil
		ns.DB().trailRecording = r.out
		-- How much of the run caught the marker inside the picture: a run without it has nothing to learn from.
		local inView = 0
		for i = 1, #r.out.samples do
			local q = r.out.samples[i]
			if q[4] and q[6] == 0 then inView = inView + 1 end
		end
		ns.Print(("trail record: done, %d samples, the marker inside the picture in %d of them. Type /reload now so the game saves them."):format(#r.out.samples, inView))
		return
	end
	if step ~= r.step then
		r.step = step
		ns.Print("trail record " .. RECORD_STEPS[step][2])
	end
	if t - r.last < 0.04 then return end
	r.last = t
	local N = C_Navigation
	local f = N and N.GetFrame and call(N.GetFrame)
	local x, y, shown = false, false, false
	if f then
		shown = flag(not f.IsShown or f:IsShown())
		local cx, cy = f:GetCenter()
		if cx and cy and not secret(cx, cy) then
			local k = (f:GetEffectiveScale() or 1) / (gr:GetEffectiveScale() or 1)
			x, y = cx * k, cy * k
		end
	end
	local distance = N and N.GetDistance and call(N.GetDistance)
	if distance == nil or secret(distance) then distance = false end
	local facing = ownFacing() or false
	local c, px, py = playerPosition()
	local gc, gx, gy = waypointWorld()
	r.out.samples[#r.out.samples + 1] = {
		t, step, facing, x, y,
		flag(N and N.WasClampedToScreen and call(N.WasClampedToScreen)),
		flag(N and N.HasValidScreenPosition and call(N.HasValidScreenPosition)),
		shown, distance, flag(pinned.pin), -- whose marker it is, as the last paint read it
		tonumber(cvar("cameraSavedPitch")) or false, tonumber(cvar("cameraSavedDistance")) or false,
		GetCameraZoom and GetCameraZoom() or false,
		flag(IsMouselooking and IsMouselooking()), flag(IsMouseButtonDown and IsMouseButtonDown("LeftButton")),
		c and px or false, c and py or false, gc == c and gx or false, gc == c and gy or false,
		camState.pitch, flag(camState.seenAt ~= nil and camState.seenAt == lastDraw),
	}
end

-- Starts a recording (or stops one under way). Needs the trail's own frame, so the trail has to be on and drawing.
function Render.Record()
	if recording then
		recording = nil
		ns.Print("trail record: stopped, nothing kept.")
		return false
	end
	if not (gr and gr:GetScript("OnUpdate")) then
		ns.Print("trail record: turn the ground trail on and have a route first.")
		return false
	end
	-- Nothing to watch: the game shows a marker only for what it tracks (a map pin, a quest).
	local N = C_Navigation
	if not (N and N.GetFrame and call(N.GetFrame)) then
		ns.Print("trail record: the game shows no waypoint marker to record. Switch Blizzard waypoint on (Settings, Guide, Arrow & routes) or track something, then try again.")
		return false
	end
	local total = 0
	for i = 1, #RECORD_STEPS do total = total + RECORD_STEPS[i][1] end
	recording = { t0 = clock, last = -1, out = {
		version = 1, fields = RECORD_FIELDS, samples = {},
		width = gr:GetWidth(), height = gr:GetHeight(), scale = gr:GetEffectiveScale(),
		fov = fov(), build = GetBuildInfo and select(1, GetBuildInfo()) or false,
		smartPivot = cvar("cameraPivot") or false, follow = cvar("cameraSmoothStyle") or false,
	} }
	ns.Print(("trail record: %d seconds in four steps. Follow the lines as they come."):format(total))
	return true
end

function Render.Recording() return recording ~= nil end

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
-- While there is nothing to paint (no route, the guide hidden, the trail off)
-- nothing here runs, and the view may be turned and tilted unseen: after more
-- than a moment of that the tilt is no longer known to be what it was. The
-- next marker in view measures it afresh, and it is not called exact, as the
-- tilt the client saved is until then. A loading screen is not such a spell
-- (the view cannot be turned in one): the count starts over when it ends, and
-- does not start at all before the world has been shown (camState.world: a
-- loading screen has ended, or the painter has run), so the wait for the first
-- route after a reload costs the saved tilt nothing while the screen is up.
--
-- The client says when a camera drag begins (PLAYER_STARTED_TURNING for the right button, PLAYER_STARTED_LOOKING
-- for the left: Blizzard_APIDocumentationGenerated/UnitDocumentation.lua, wowf 1.60.1). Where those are to be
-- had (camState.watched) the spell costs the tilt nothing unless one began in it: a talk with a quest giver,
-- the view untouched, leaves it as exact as it was.
local function unwatched()
	if not camState.unseen then return end
	local dragged = camState.sawDrag
	if not camState.watched then dragged = GetTime() - camState.unseen > 1 end
	if dragged then camState.stale, camState.exact, camState.adrift = true, false, true end
end
local function sawDrag()
	if camState.idle then camState.sawDrag = true end
end
local function loadingStarted()
	unwatched()
	pauseCameraTracking()
	loading = true
	generation = generation + 1
	settled = false
	if gr then finish(gr,0) end
	Render.ResetGround()
end
local function loadingFinished()
	loading = false
	camState.world = true
	if camState.idle then camState.unseen = GetTime() end
	settle()
end

drawGround = function()
	local db = NS.db
	if not Render.Settled() or not db or not db.enabled or competing() then pauseCameraTracking(); dropFades(); finish(gr,0); return end
	local width,height=gr:GetWidth() or 0,gr:GetHeight() or 0
	local onTaxi=UnitOnTaxi and UnitOnTaxi("player")
	local ax,ay,d
	why=nil
	if onTaxi then why="on a flight" elseif width>0 and height>0 then ax,ay,d=marker(width,height) end
	if not db.groundIndoors and IsIndoors and IsIndoors() then why="indoors"; pauseCameraTracking(); dropFades(); finish(gr,0); return end
	local used=0
	if not onTaxi and width>0 and height>0 then
		local markerWhy=why; why=nil
		used=drawCamera(width,height,ax,ay,d,0,markerWhy)
	else
		pauseCameraTracking()
		dropFades()
	end
	if used==0 and not why then why="nothing of the route in view" end
	finish(gr,used)
	-- The route went and its trail has faded out: nothing is left to paint.
	if #paths==0 and not fading() then Render.Show() end
end
function Render.Why()
	if competing() then return "suppressed while ForeverSparkleTrail is loaded" end
	if not (NS.db and NS.db.enabled) then return "the ground trail is off" end
	if not ns.GuideShown() then return "the guide is hidden" end
	if #paths==0 then return "no Polestar route" end
	if not Render.Settled() then return "waiting after a loading screen" end
	return why
end
local FRAME_INTERVAL = 1 / 40 -- retain the accepted painter's update ceiling
local drawElapsed = 0
local function tick(_, elapsed)
	clock = clock + elapsed
	camState.world = true
	trackMouse()
	trackAir(elapsed)
	if recording then recordSample() end
	groundPhase = groundPhase + elapsed * (style and style.flow or 0)
	drawElapsed = drawElapsed + elapsed
	if drawElapsed < FRAME_INTERVAL then return end
	drawElapsed = drawElapsed % FRAME_INTERVAL
	drawGround()
end
local function ensureGround()
	if gr then return true end
	if not (UIParent and ns.UIParent) then return false end
	-- On Polestar's layer (Core/Init.lua), anchored to the screen as before: hiding
	-- Polestar hides the trail with everything else and stops its painting.
	gr=newOwner(CreateFrame("Frame",nil,ns.UIParent))
	gr:SetAllPoints(UIParent)
	gr:SetScript("OnHide",pauseCameraTracking)
	gr:SetFrameStrata("BACKGROUND"); gr:SetFrameLevel(1); gr:EnableMouse(false)
	return true
end
function Render.Show()
	local db=NS.db
	local on=started and db and db.enabled and ns.GuideShown() and style and not competing()
	-- A route that has just gone leaves its trail to fade out: painting goes on until it has.
	local active=on and (#paths>0 or fading())
	if not active then
		if gr then finish(gr,0); gr:SetScript("OnUpdate",nil); gr:Hide() end
		pauseCameraTracking()
		dropFades()
		lastDraw, shownAt, drawElapsed = nil, nil, 0
		-- Nothing watches the mouse from here on, until there is something to paint again.
		camState.idle = true
		if camState.world then camState.unseen = camState.unseen or GetTime() end
		return
	end
	if ensureGround() then
		unwatched()
		camState.unseen, camState.idle, camState.sawDrag = nil, false, nil
		gr:SetScript("OnUpdate",tick); gr:Show()
	end
end
function Render.Start()
	if started then return true end
	started=true
	ns.On("NAV_ROUTE_GEOMETRY",Render.Rebuild)
	-- Follow the guide's explicit on/off, not its combat/instance auto-hide.
	ns.On("SETTING_CHANGED",function(path)
		if path == "" or path == "ui" or path == "ui.shown" then Render.Show() end
	end)
	-- Polestar hidden or shown again (ns.GuideShown() goes with it): stop or resume.
	ns.On("POLESTAR_HIDDEN",function() Render.Show() end)
	ns.RegisterEvent("LOADING_SCREEN_ENABLED",loadingStarted)
	ns.RegisterEvent("LOADING_SCREEN_DISABLED",loadingFinished)
	ns.RegisterEvent("PLAYER_ENTERING_WORLD",settle)
	local turning = ns.RegisterEvent("PLAYER_STARTED_TURNING",sawDrag)
	camState.watched = ns.RegisterEvent("PLAYER_STARTED_LOOKING",sawDrag) and turning
	ns.RegisterEvent("ADDON_LOADED",function() if competing() then Render.Rebuild() end end)
	-- The client keeps the view's tilt with its saved settings (cameraSavedPitch,
	-- in degrees, written when the interface is reloaded or the character logs
	-- out) and takes the view up from there: a better first tilt than a fixed
	-- one, until a marker measures it. It is not kept current while playing.
	local saved = tonumber(cvar("cameraSavedPitch"))
	if saved and saved == saved and saved > -89 and saved < 89 and not camState.locked then
		camState.pitch, camState.anchor, camState.exact = math.rad(saved), "the view the client saved", true
		camState.steady = camState.pitch
		if camState.pitch >= UP_VIEW then camState.usual = camState.pitch end
	end
	settle(); Render.Rebuild()
	return true
end
ns.OnLogin(Render.Start)
