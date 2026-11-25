-- Polestar navigation core: which point we are guiding to, and where it is
-- relative to the player. The arrow, the map pins and the TomTom/Blizzard
-- bridges all read from here. Contract: docs/ARCHITECTURE.md, "Nav".
--
-- All geometry is done in world yards from Polestar.Compat: wx grows north,
-- wy grows west, facing 0 is north and grows counter-clockwise. A target is
-- converted to world space once (honouring its map frame, so Era-frame guide
-- coordinates land in the right place on reworked Forever maps) and every
-- distance and bearing after that is plain vector maths.
--
-- Colours: Nav.RGB(name) and Nav.Wash(role) read Polestar.Theme's tokens
-- (accent, success, the arrow's arrow/arrowNear and their legible *Text
-- forms, text, textDim, place, ink, shade; the ink washes), with a
-- fallback palette only for when Theme is not loaded; on a light palette
-- the text ones are the palette's paper, to read over the world.

local ADDON, ns = ...
local L = ns.L

local type, tonumber, pcall, error = type, tonumber, pcall, error
local sqrt, atan2, pi, max, abs = math.sqrt, math.atan2, math.pi, math.max, math.abs
local TWO_PI = 2 * pi

local Nav = {}
ns.Nav = Nav

Nav.MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"
Nav.DEFAULT_RADIUS = 8 -- yards, matches the guide format's goto default
-- Yards of height between the player's floor and the target's beyond which
-- they stand on different floors (an Undercity level, a tower storey), more
-- than a slope gives within arrival range.
local FLOOR_GAP = 8

ns.RegisterDefaults("nav", {
	arrow = true,
	arrowScale = 1,
	arrowAlpha = 1,
	arrowEta = true,
	-- Hiding the guide window (ui.shown) hides the arrow too (Nav.HiddenWithGuide).
	hideArrowWithGuide = false,
	worldPins = true,
	minimapPins = true,
	minimapRoute = true, -- the route line (or trail) on the minimap; off keeps the pin (Maps/RouteLines.lua, Nav/Layers.lua)
	trailDots = true,
	openmapDots = true, -- the trail on OpenMap's stitched map (Nav/Pins.lua; OpenMap's menu switch)
	tomtom = true,
	useTomTomArrow = false,
	blizzardWaypoint = false,
	-- Hide the arrow while an addon following Polestar shows the target itself (Nav.API.Follow, `shows`).
	arrowToFollower = false,
	arrivalSound = true,
	-- How distances read: "yards" (the game's unit) or "metres" (ns.FormatDistance).
	distanceUnit = "yards",
	-- The arrow's colours (Theme tokens "arrow" and "arrowNear"): false = the
	-- accent far away and success near; { r, g, b } = your own.
	arrowColor = false,
	arrowNearColor = false,
	-- arrowPos: { point, relPoint, x, y } once the arrow has been dragged; nil = default spot
})

-- Wrap an angle into (-pi, pi].
local function wrap(a)
	a = a % TWO_PI
	if a > pi then a = a - TWO_PI end
	return a
end
Nav.WrapAngle = wrap

---------------------------------------------------------------------------
-- Colours and fonts, from Polestar.Theme when it offers them. FALLBACK is
-- only read when Theme is absent (Nav loaded on its own, as in the nav
-- tests) or its call fails; with Theme, every name below comes from the
-- active scheme and refreshes on Theme.OnChanged.
---------------------------------------------------------------------------

local FALLBACK = {
	accent = { 0.902, 0.729, 0.4 }, -- Dusk gold, #e6ba66
	success = { 0.42, 0.85, 0.6 },
	-- The arrow's own colours (far, near; their legible text forms), which
	-- follow accent and success unless the player picked their own.
	arrow = { 0.902, 0.729, 0.4 },
	arrowNear = { 0.42, 0.85, 0.6 },
	arrowText = { 0.902, 0.729, 0.4 },
	arrowNearText = { 0.42, 0.85, 0.6 },
	text = { 0.969, 0.973, 0.992 },
	textDim = { 0.765, 0.793, 0.868 },
	place = { 0.96, 0.68, 0.52 },
	ink = { 1, 1, 1 },    -- hairlines and washes
	shade = { 0, 0, 0 },  -- text shadows
}
-- Wash alphas by role, as Theme.WASH has them.
local FALLBACK_WASH = { mover = 0.06, border = 0.08 }
local palette = {}
for name, c in pairs(FALLBACK) do palette[name] = { c[1], c[2], c[3] } end

local function themeColor(name)
	local T = ns.Theme
	if type(T) ~= "table" then return nil end
	local ok, r, g, b
	if name == "accent" and type(T.Accent) == "function" then
		ok, r, g, b = pcall(T.Accent)
	elseif type(T.Color) == "function" then
		ok, r, g, b = pcall(T.Color, name)
	end
	if ok and type(r) == "number" and type(g) == "number" and type(b) == "number" then return r, g, b end
end

-- A light palette (a parchment skin: dark ink on paper) can't colour text
-- the 3D world shows through: its ink vanishes over a night zone. Nav's
-- text (the arrow's lines, the leg prompts' lines on the game's dark
-- tooltip) then takes the palette's paper, outlined and shadowed in its
-- ink, and its coloured lines are lifted toward the paper until they read
-- on a night zone (WORLD_NIGHT) at the subject colours' floor (4.5:1).
local WORLD_NIGHT = { 0.086, 0.098, 0.122 }
local PAPER_TEXT, LIFTED = { "text", "textDim" }, { "place", "arrowText", "arrowNearText" }
local function overTheWorld(T)
	local ok, light = pcall(function() return T.IsLightPalette(T.Palette()) end)
	if not (ok and light) then return end
	local pr, pg, pb = themeColor("panel")
	if not pb then return end
	-- The ink (the palette's text, read above) goes to the shadow first.
	local ink, shade = palette.text, palette.shade
	shade[1], shade[2], shade[3] = ink[1], ink[2], ink[3]
	for _, name in ipairs(PAPER_TEXT) do
		local c = palette[name]
		c[1], c[2], c[3] = pr, pg, pb
	end
	for _, name in ipairs(LIFTED) do
		local c = palette[name]
		for _ = 1, 24 do
			if T.Contrast(c, WORLD_NIGHT) >= 4.5 then break end
			c[1], c[2], c[3] = c[1] + (pr - c[1]) * 0.15, c[2] + (pg - c[2]) * 0.15, c[3] + (pb - c[3]) * 0.15
		end
	end
end

local function refreshPalette()
	for name, fb in pairs(FALLBACK) do
		local r, g, b = themeColor(name)
		local c = palette[name]
		c[1], c[2], c[3] = r or fb[1], g or fb[2], b or fb[3]
	end
	local T = ns.Theme
	if type(T) == "table" and T.IsLightPalette and T.Palette and T.Contrast then overTheWorld(T) end
end

-- Whether the palette moved since the last theme change looked (the
-- colours as they were then kept in `seen`).
local seen = {}
local function paletteMoved()
	local moved = false
	for name, c in pairs(palette) do
		local s = seen[name]
		if not s then
			s = {}
			seen[name] = s
		end
		if s[1] ~= c[1] or s[2] ~= c[2] or s[3] ~= c[3] then
			s[1], s[2], s[3] = c[1], c[2], c[3]
			moved = true
		end
	end
	return moved
end

function Nav.RGB(name)
	local c = palette[name] or palette.text
	return c[1], c[2], c[3]
end

-- (): the theme's colours read again, as on every theme change; the skin
-- picker's cards read another skin's while they paint its arrow.
Nav.ReadPalette = refreshPalette

-- An ink wash at one of the house alphas (Theme.Wash): r, g, b, a.
function Nav.Wash(role)
	local T = ns.Theme
	local a = type(T) == "table" and type(T.WASH) == "table" and T.WASH[role] or nil
	if type(a) ~= "number" then a = FALLBACK_WASH[role] or FALLBACK_WASH.border end
	local c = palette.ink
	return c[1], c[2], c[3], a
end

-- HUD text: the theme's typeface at a size chosen for reading over the 3D
-- world, outlined so it survives bright terrain; the shadow stays dark (shade).
function Nav.SetHudFont(fs, role, size)
	local T = ns.Theme
	if T and T.SetFace then
		T.SetFace(fs, (T.FontSpec(role)), size, "OUTLINE")
	else
		fs:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
	end
	local c = palette.shade
	fs:SetShadowColor(c[1], c[2], c[3], 0.8)
	fs:SetShadowOffset(1, -1)
end

---------------------------------------------------------------------------
-- Modules (arrow, pins, bridges) register here and are told about changes.
--   module:OnTarget(target)   the target changed (may be nil)
--   module:Refresh()          situation may have changed (zone, taxi, ticker)
--   module:OnSettings()       a nav.* setting changed
--   module:OnTheme()          colours/fonts changed
---------------------------------------------------------------------------

local modules = {}

local function notify(method, ...)
	for i = 1, #modules do
		local m = modules[i]
		if m[method] then ns.SafeCall(m[method], m, ...) end
	end
end

function Nav.RegisterModule(m)
	modules[#modules + 1] = m
end

function Nav.Refresh()
	notify("Refresh")
end

---------------------------------------------------------------------------
-- Target model
---------------------------------------------------------------------------

local engineWp    -- last waypoint announced by the Engine
local override    -- point picked with Nav.SetTarget, kept until the step changes
local dismissed   -- engine waypoint hidden by ClearTarget until the Engine moves on
local hold        -- point held with Nav.Hold (the way back to your corpse), over everything until Nav.Unhold
local NOTHING = {} -- the hold of Nav.HoldNothing: no target at all until Nav.Unhold
local target      -- what we guide to: hold, else override, else engine waypoint
local tC, tX, tY  -- target in world space (nil until resolvable)
local tZ         -- its height: the target's `z` (a guide goal, candidate or spawn area at an NPC or object), else nil
local tDock      -- true when (tX, tY, tZ) is a ship's boarding spot the goal was moved to (dockPoint), else nil
local arrived = false
local wetBounds, wetNew
local wetReach, exactPoint, pointAnnounced -- shared one-shot announcement for a measured visit
local function number(v)
	return not (issecretvalue and issecretvalue(v)) and type(v) == "number" and v > -math.huge and v < math.huge
end
local pointKind = { manual=true, goto=true, accept=true, turnin=true, talk=true, interact=true, collect=true, kill=true, use=true, complete=true }
local floorHint  -- "up" | "down": near the target, a floor below or above it (Nav.Sample)
local firing = false
local ticker

-- A goal at a ship's dock is walked to where the ship is boarded, at that floor's height: the end's board point when
-- the ship lies in the water off its pier (TravelData's end `board`, Travel.lua's end.board: on the deck), else its
-- stop when TravelData gives the stop's floor (end.z: a zeppelin or skyboat tower's top, Ratchet's dock). The travel
-- planner walks to the same spot for that ship. A guide's boat step ("Boat to Auberdine") has no height, and every
-- column at a pier holds the sea under the deck: its walk ended on the sea (#3016: Theramore's, Southshore's,
-- Auberdine's Stormwind pier and the Forgotten Coast's swam the last stretch, and a swimmer cannot climb back up), and
-- a zeppelin step's at the foot of its tower. Only for a goal with no height of its own, within DOCK_SNAP yards of the
-- stop or Nav.DEFAULT_RADIUS (a goto's reach) of the boarding spot (every guide goto at a dock stands there, #2876);
-- the nearest such end. In a capital a manually picked point could be on the street above the tram.
-- Only an actual guide goto within its reach of the tram entrance takes the recorded tunnel floor.
local DOCK_SNAP = 12
local SHIP = { boat = true, zeppelin = true, airship = true }
local function dockPoint(c, wx, wy, guideGoto)
	local d = Nav.GetTravelData and Nav.GetTravelData()
	local list = d and d.transports
	if type(list) ~= "table" then return nil end
	local stop2, spot2 = DOCK_SNAP * DOCK_SNAP, Nav.DEFAULT_RADIUS * Nav.DEFAULT_RADIUS
	local best, bx, by, bz = math.huge, nil, nil, nil
	for i = 1, #list do
		local t = list[i]
		for side = 1, 2 do
			local e = side == 1 and t.a or t.b
			if type(e) == "table" and e.c == c and type(e.wx) == "number" and type(e.wy) == "number" then
				local b, px, py, pz = e.board, nil, nil, nil
				if type(b) == "table" then
					px, py, pz = b.wx, b.wy, b.z
				elseif SHIP[t.kind] or (guideGoto and t.kind == "tram") then
					px, py, pz = e.wx, e.wy, e.z
				end
				if type(px) == "number" and type(py) == "number" and type(pz) == "number" then
					local ds, dp = (e.wx - wx) ^ 2 + (e.wy - wy) ^ 2, (px - wx) ^ 2 + (py - wy) ^ 2
					local dd = ds < dp and ds or dp
					if (dp <= spot2 or (t.kind ~= "tram" and ds <= stop2)) and dd < best then best, bx, by, bz = dd, px, py, pz end
				end
			end
		end
	end
	return bx, by, bz
end

local function resolve()
	wetBounds, wetNew = nil, nil
	tC, tX, tY, tZ, tDock, wetReach, exactPoint = nil, nil, nil, nil, nil, nil, nil
	local C = ns.Compat
	if target and C and C.MapToWorld then
		if not (number(target.map) and number(target.x) and number(target.y)) then return end
		if (issecretvalue and issecretvalue(target.z)) or (target.z ~= nil and not number(target.z)) then return end
		if (issecretvalue and issecretvalue(target.r)) or (target.r ~= nil and (not number(target.r) or target.r <= 0)) then return end
		local ok, c, x, y = pcall(C.MapToWorld, target.map, target.x, target.y, target.f)
		if not (ok and number(c) and number(x) and number(y)) then return end
		tC, tX, tY = c, x, y
		if tC and type(target.z) == "number" then tZ = target.z end
		if tC and tZ == nil and target ~= hold then
			local x, y, z = dockPoint(tC, tX, tY, target == engineWp and target.kind == "goto")
			if x then tX, tY, tZ, tDock = x, y, z, true end
		end
		if tZ and not tDock and target ~= hold and pointKind[target.kind] and target.area == nil and not target.search and not target.placeGoal
			and not target.spots and not target.spot and not target.exact
			and (not target.stop or target.stop == "npc" or target.stop == "object") then
			exactPoint = (target.r or Nav.DEFAULT_RADIUS) <= Nav.DEFAULT_RADIUS
			wetReach, wetBounds, wetNew = Nav.StaticSubmergedGoal(tC, tX, tY, tZ, target.r or Nav.DEFAULT_RADIUS)
		end
	end
end

local function samePoint(a, b)
	return a ~= nil and b ~= nil and a.map == b.map and a.x == b.x and a.y == b.y
		and a.stepIndex == b.stepIndex and a.goalIndex == b.goalIndex
end

-- While a target exists, re-check the situation once a second: hidden
-- frames run no OnUpdate, so this is what brings them back after a taxi
-- ride, a boat to another continent or leaving an instance.
local function updateTicker()
	if target and not ticker and C_Timer and C_Timer.NewTicker then
		ticker = ns.NewTicker(1, Nav.Refresh)
	elseif not target and ticker then
		ticker:Cancel()
		ticker = nil
	end
end

local function announce()
	firing = true
	local ok, err = pcall(ns.Fire, "WAYPOINT_CHANGED", target)
	firing = false
	if not ok then error(err, 0) end
end

-- The Engine's waypoint as the arrow may take it: not while dismissed, nor
-- while paused (Pause takes the arrow; a hold and a picked point still show).
local function engineTarget()
	if dismissed or ns.PauseHides("arrow") then return nil end
	return engineWp
end

-- The Engine's waypoint for the same area goal at another of its spawn areas (Spots: the nearest one, or the next
-- after a dwell), not a search: no new target for the arrival (#3828). A search (an area objective spread over its
-- spots) moves on to the next spot on purpose, and the arrow leads there.
local function sameAreaGoal(a, b)
	return a ~= nil and b ~= nil and a.stepIndex ~= nil and a.stepIndex == b.stepIndex and a.goalIndex ~= nil
		and a.goalIndex == b.goalIndex and a.kind == b.kind and a.quest == b.quest and not b.search
		and (tonumber(a.area) or 0) > 0 and (tonumber(b.area) or 0) > 0
end

local function apply(shouldAnnounce)
	local new = hold or override or engineTarget() or nil
	if new == NOTHING then new = nil end
	-- Held: a step, the guide's waypoint or a picked point changing under the
	-- hold changes nothing shown (no replan, no second chime) until Nav.Unhold.
	if hold and new == target then return end
	if pointAnnounced and not (new and number(new.x) and number(new.y) and number(new.map) and number(new.z) and not (issecretvalue and issecretvalue(new.r))
		and samePoint(target, new) and target.z == new.z and target.kind == new.kind and target.f == new.f and target.r == new.r) then pointAnnounced = false end
	-- Arrived in an area goal's spawn area, the goal moving on to another of its areas: still arrived while the
	-- player is near it (Nav.Sample), no second chime.
	arrived = arrived and sameAreaGoal(target, new) or false
	target = new
	resolve()
	updateTicker()
	-- Plan before the arrow and pins hear about the new target.
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
	notify("OnTarget", target)
	if shouldAnnounce then announce() end
end

-- `stop`: what stands there, as Shortest Path Forever's stop kinds name it
-- ("dungeon", "trainer", "innkeeper", "flightmaster"; Nav/Handoff.lua), optional.
-- `z`: the height of the NPC or object there (a guide goal's or candidate's
-- compiled `z`), optional, so the walk ends on its floor.
-- `warning`: a line the arrow shows under the label while this is the target
-- (a dungeon entrance in the other faction's land), optional.
function Nav.SetTarget(map, x, y, label, f, stop, z, warning)
	map, x, y = tonumber(map), tonumber(x), tonumber(y)
	if not (map and x and y) then return false end
	local Engine = ns.Engine
	override = {
		map = map, x = x, y = y, f = f,
		z = type(z) == "number" and z or nil,
		label = (label and label ~= "") and label or L["Waypoint"],
		warning = type(warning) == "string" and warning ~= "" and warning or nil,
		kind = "manual",
		stop = type(stop) == "string" and stop or nil,
		r = Nav.DEFAULT_RADIUS,
		stepIndex = Engine and Engine.GetStepIndex and Engine.GetStepIndex() or nil,
	}
	apply(true)
	return override
end

-- The arrow held on one point (QoL/Death.lua: the way back to your corpse or
-- the Spirit Healer) over every other target until Nav.Unhold: the guide's
-- step and waypoint changes, and points picked by hand or set by other
-- addons, go on underneath and show again once it lets go (a picked point
-- only while the step is the same, as always). `z`: the floor's height there,
-- optional (a corpse in a basement, #2106), so the walk ends on it. Returns
-- the held target, or nil for a bad point.
function Nav.Hold(map, x, y, label, f, z)
	map, x, y = tonumber(map), tonumber(x), tonumber(y)
	if not (map and x and y) then return nil end
	hold = {
		map = map, x = x, y = y, f = f,
		z = type(z) == "number" and z or nil,
		label = (label and label ~= "") and label or L["Waypoint"],
		kind = "manual",
		r = Nav.DEFAULT_RADIUS,
	}
	apply(true)
	return hold
end

-- Lets go of the held point: the target is what it would have been without it.
function Nav.Unhold()
	if not hold then return end
	hold = nil
	apply(true)
end

function Nav.IsHeld()
	return hold ~= nil
end

-- The arrow held on nothing (QoL/Death.lua: a corpse inside a dungeon whose
-- entrance is not known, where no point is the way back): no arrow until
-- Nav.Unhold, the guide's targets going on underneath as under Nav.Hold.
function Nav.HoldNothing()
	hold = NOTHING
	apply(true)
	return hold
end

-- Drops the override; the engine's waypoint stays dismissed until the Engine
-- announces a different one or the step changes.
function Nav.ClearTarget()
	override = nil
	dismissed = engineWp ~= nil
	apply(true)
end

-- Drops the override only: the engine's waypoint (if any) is guided to again.
-- No-op without an override.
function Nav.ReleaseTarget()
	if not override then return end
	override = nil
	apply(true)
end

function Nav.GetTarget()
	return target
end

function Nav.IsOverride()
	return override ~= nil and target == override
end

-- A point of your own that moves (a party member followed, Quests/Party.lua):
-- the same target at its new place, so a trip on it goes on and an arrival
-- stays one arrival, one chime, until the player is well apart again
-- (Nav.Sample). A new target each time re-armed the arrival, and following
-- someone you stood beside chimed every few seconds. The route is planned
-- again. False when `t` is not the arrow's own target.
function Nav.MoveTarget(t, map, x, y)
	map, x, y = tonumber(map), tonumber(x), tonumber(y)
	if not (t and map and x and y and Nav.IsOverride() and target == t) then return false end
	t.map, t.x, t.y = map, x, y
	resolve()
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
	notify("OnTarget", target)
	announce()
	return true
end

-- World position of the target: continentID, wx, wy, then its height when
-- it has one (an Engine waypoint's `z`, or a ship's boarding spot's; a hand-set
-- target has none), then true when the goal was moved to that boarding spot
-- (a goal at a dock: resolve). nil if unresolved.
function Nav.GetTargetWorld()
	if target and not tC then resolve() end
	return tC, tX, tY, tZ, tDock
end

-- The hand-off to Shortest Path Forever began or ended (Nav/Handoff.lua): the
-- route is planned again and every module hears the same target anew, so its
-- arrow, lines and bridges show or step aside. Nothing is announced: the
-- target itself did not change.
function Nav.Reapply()
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
	notify("OnTarget", target)
end

-- A point's coordinates in the live (Forever) frame of its own map, for
-- APIs that take map percent: TomTom and Blizzard's user waypoint.
function Nav.LiveCoords(point)
	if not point then return nil end
	if not point.f then return point.map, point.x, point.y end
	local C = ns.Compat
	if not (C and C.MapToWorld and C.WorldToMap) then return nil end
	local c, wx, wy = C.MapToWorld(point.map, point.x, point.y, point.f)
	if not c then return nil end
	local x, y = C.WorldToMap(c, wx, wy, point.map)
	if not x then return nil end
	return point.map, x, y
end

---------------------------------------------------------------------------
-- Trips: a place the player asked to be taken to (a nearby service, a
-- dungeon's entrance, a trainer or quest giver a card or banner shows). A
-- trip is a point picked by hand (Nav.SetTarget) that ends once its goal is
-- reached, and the arrow is back on the guide's step: `ends` "arrive" at
-- the arrival (after it is drawn), "instance" (a dungeon's entrance) on
-- going through an instance's portal, in, or out when it was started
-- inside (#1686: the way to Blackfathom Deeps outlived the run). Any other
-- target (a step change, a goal clicked, a map click) ends it too, without
-- a word. The guide window shows it ("On the way to <name> (<label>).")
-- with "Back to the guide" (Nav.EndTrip). NAV_TRIP(trip | nil) fires as one
-- starts or ends.
---------------------------------------------------------------------------

local trip

local function inInstance()
	local C = ns.Compat
	return C and C.IsInInstance and C.IsInInstance() and true or false
end

-- `t`: what Nav.SetTarget just returned; `name`: the place, said on arrival;
-- `label`: what it is ("Repair", "Dungeon"). -> the trip, or nil when `t`
-- is not the arrow's own waypoint.
function Nav.StartTrip(t, name, label, ends)
	if not (t and Nav.IsOverride() and target == t) then return nil end
	trip = { target = t, name = name or t.label, label = label, ends = ends == "instance" and "instance" or "arrive", inside = inInstance() }
	ns.Fire("NAV_TRIP", trip)
	return trip
end

-- The trip under way: { target, name, label, ends, inside }, or nil.
function Nav.Trip()
	if trip and not (Nav.IsOverride() and target == trip.target) then trip = nil end
	return trip
end

-- Back to the guide: the trip's target lets go. `arrived`: said as "At <name>".
-- False when there is no trip.
function Nav.EndTrip(arrived)
	local t = Nav.Trip()
	if not t then return false end
	trip = nil
	Nav.ReleaseTarget()
	ns.Print(arrived and string.format(L["At %s: the arrow is back on the guide."], t.name) or L["The arrow is back on the guide."])
	ns.Fire("NAV_TRIP", nil)
	return true
end

-- Any point picked by hand lets go, a trip as its banner's link ends it (the
-- arrow's menu, the journey's header). False when the arrow is the guide's.
function Nav.BackToGuide()
	if Nav.EndTrip() then return true end
	if not Nav.IsOverride() then return false end
	Nav.ReleaseTarget()
	ns.Print(L["The arrow is back on the guide."])
	return true
end

---------------------------------------------------------------------------
-- Situation sampling. Allocation-free: called from throttled OnUpdates.
--
-- Nav.Sample() -> state, distance, relAngle, dNorth, dWest, measured
--   state: "none" | "instance" | "taxi" | "unknown" | "far" | "travel" | "arrived"
--          | "instruction" (a route leg to act on here: fly, ride, hearth)
--          | "submerged" (no verified walk or swim bearing) | "arrived-underwater" (observed, not inferred)
--          | "routing" (waiting for walking data or a route; distance and angle straight to what the walk will lead
--            to, the arrow pointing that way until the walk is in, as 0.4.1.1 pointed at once)
--          | "unmapped" (the known walk ended short; no verified walking bearing beyond it)
--          | "search" (reached a spot of an area objective: look around here)
--          | "nopos" (the client gives no player position here: the Deeprun
--            Tram, a map of its own without a world map)
--   distance/relAngle/dNorth/dWest are toward what the arrow points at: the
--   current route leg's end while a travel route is active, else the target;
--   on a walk the walking engine has a path for (Nav/Walk.lua), the angle is
--   toward the path's next point and the distance is what is left of the path
--   (measured = true: the distance is along a path, not a straight line).
--   An area target (`area`, yards: a spawn area) is reached anywhere inside
--   it plus its arrival radius `r`, and its distance is to the area's edge;
--   with `search` set (an area objective) reaching it is "search", never "arrived".
--   relAngle: radians relative to facing, counter-clockwise positive (nil
--   when facing is unknown)
---------------------------------------------------------------------------

local function playArrival()
	if not ns.Get("nav.arrivalSound") or (Nav.HandedOff and Nav.HandedOff()) then return end
	-- The arrow's own sound: it plays while hiding Polestar keeps the arrow, not while the arrow is off or hidden
	-- with the guide (the route lines sample then, Nav/Journey.lua: #3828).
	if not ns.Get("nav.arrow") or (Nav.HiddenWithGuide and Nav.HiddenWithGuide()) then return end
	ns.PlaySound((SOUNDKIT and SOUNDKIT.MAP_PING) or 3175, "SFX", true)
end

local function toward(C, px, py, ax, ay)
	local dn, dw = ax - px, ay - py
	local angle
	local facing = C.GetPlayerFacing and C.GetPlayerFacing()
	if facing then angle = wrap(atan2(dw, dn) - facing) end
	return sqrt(dn * dn + dw * dw), angle, dn, dw
end

-- Only UnitPosition (never a map pin, nearby mesh floor or water height)
-- can confirm a visit. A missing/secret observation removes the ring
-- immediately, but cannot re-arm the chime. A real departure can.
-- Use the client's XYZ from a single sample. A city trail, NPC's floor
-- or a nearby map height is a search hint, not evidence of a visit.
local function pointDistance(C, gc, gx, gy, gz)
	local ok, x, y, z, map = pcall(C.GetPlayerUnitPosition)
	if not (ok and number(map) and map == gc and number(x) and number(y) and number(z) and z ~= 0) then return end
	local xy2 = (x-gx)^2 + (y-gy)^2
	return xy2 + (z-gz)^2, z, xy2, x, y
end

-- No height from the client to use (Compat.GetPlayerUnitPosition: none, a
-- secret one, exactly 0, or one fixed while the player walks; Forever's client
-- has given 0): no visit can be measured. A point with a height is then
-- reached as before heights were checked, within its radius on the map (the
-- Engine's own check), and a guide goto's arrow says no floor. The debug log
-- says once a session which it was (a report's Where line says it too).
local saidHeightless, saidHeight
local function heightless(C, gc)
	local ok, x, _, z, map = pcall(C.GetPlayerUnitPosition)
	if ok and number(z) and map == gc then
		if not saidHeight then
			saidHeight = true
			ns.Debug("Arrival: the game gives the player's height: a point with a height is reached on its floor")
		end
		return false
	end
	if not saidHeightless then
		saidHeightless = true
		local mode = ok and x ~= nil and C.PlayerHeight and C.PlayerHeight() or "none"
		ns.Debug(("Arrival: no player height from the game (%s): a point with a height is reached by map distance"):format(tostring(mode)))
	end
	return true
end

local function stackedAt(z, gz, xy)
	return abs(z-gz) > max(2, .8 + 1.2 * xy)
end

-- Keep the existing XYZ check on clients without a movement flag. A positive
-- report of swimming, falling or being carried is never a dry point visit.
local function movingOffGround(C)
	if C.IsSwimming and C.IsSwimming() then return true end
	if IsFalling then
		local read, falling = pcall(IsFalling)
		if read and not (issecretvalue and issecretvalue(falling)) and falling then return true end
	end
	return ns.Transit and ns.Transit.Carried and ns.Transit.Carried()
end

local function bodyBlocked(c,x,y,z,ax,ay,limit,az)
	local P = Nav.Path
	return P and P.FinalBodyBlocked and z and P.FinalBodyBlocked(c,x,y,z,ax,ay,limit,az)
end

local function dryVisit(C, gc, gx, gy, gz, reach)
	local d2, z, xy2, x, y = pointDistance(C, gc, gx, gy, gz)
	if not d2 then return end
	if movingOffGround(C) then return d2, false end
	if d2 <= reach*reach then
		local P = Nav.Path
		if P and P.ContradictsPointFloor and P.ContradictsPointFloor(gc,x,y,z,gx,gy,gz) then return d2,false,z,true end
		-- The target floor exists; do not consume the visit from the other
		-- deck. Keep the ordinary walking route to its stairs available.
		if P and P.OnSeparateLocalFloors and P.OnSeparateLocalFloors(gc,x,y,z,gx,gy,gz) then return d2,false,z end
		return d2, not stackedAt(z, gz, sqrt(xy2)) and not bodyBlocked(gc,x,y,z,gx,gy,reach,gz), z
	end
	return d2,false,z
end

local function announcePoint()
	if pointAnnounced then return end
	pointAnnounced = true
	playArrival()
	pcall(ns.Fire, "NAV_ARRIVED", target)
end

local function submergedVisit(C, gc, gx, gy, gz, reach, bounds, new)
	local d2, z, xy2 = pointDistance(C, gc, gx, gy, gz)
	-- A positive swim flag cannot justify a visit below the local bed or
	-- above the liquid. The full visit sphere's XY fits in this halo.
	if d2 and bounds and d2 <= reach^2 and (z < bounds[1] or z > bounds[2]+4) then return d2 end
	local ms
	if d2 and bounds and (new or d2 > reach^2) then ms = Nav.WaterBoundaryPose(C, bounds, z, xy2) end
	if ms and ms > 10000 and d2 > reach^2 and z > gz and z-gz <= 12 then
		return d2, false, z-gz -- a measured height difference, never a direction of travel
	end
	if d2 and d2 <= reach^2 and (not new or ms) then
		local read, swim = pcall(IsSwimming)
		if read and not (issecretvalue and issecretvalue(swim)) and swim == true then return d2, true end
	end
	return d2
end

local function submergedSample(C)
	if wetReach == false then return "unmapped" end
	local d2, visited, depth = submergedVisit(C, tC, tX, tY, tZ, wetReach, wetBounds, wetNew)
	if d2 and d2 > (wetReach+5)^2 then pointAnnounced = false end
	if visited then
		announcePoint()
		return "arrived-underwater", sqrt(d2)
	end
	if depth then return "water-depth", depth end
	return "submerged"
end

-- Guide polls are independent of the arrow. A height-bearing point
-- needs the same actual visit whether its guide tab is visible or not.
function Nav.AllowGuideArrival(gc, gx, gy, gz, r)
	if Nav.travel and Nav.travel.place then return true end -- the existing portal-only place semantics
	local C = ns.Compat
	if C and C.GetPlayerUnitPosition and heightless(C, gc) then return true end
	local reach, bounds, new = Nav.StaticSubmergedGoal(gc, gx, gy, gz, r)
	if reach == nil and r > Nav.DEFAULT_RADIUS then return true end
	if reach == false or not C or (C.IsInInstance and C.IsInInstance()) or (C.IsOnTaxi and C.IsOnTaxi()) then return false end
	if reach == nil then
		if engineWp and target == engineWp and tC == gc and tX == gx and tY == gy and tZ == gz then
			if not exactPoint then return true end
			return Nav.Sample() == "arrived"
		end
		local _, visited = dryVisit(C, gc, gx, gy, gz, math.min(5,r))
		return visited == true
	end
	if engineWp and target == engineWp and tC == gc and tX == gx and tY == gy and tZ == gz and wetReach then
		return Nav.Sample() == "arrived-underwater"
	end
	local _, visited = submergedVisit(C, gc, gx, gy, gz, reach, bounds, new)
	return visited == true
end

-- Check the actual displayed segment, including smoothing, baked guidance and a direct fallback.
-- The sampler's taxi and ride-instruction states never enter this function.
-- Nav.noWalk (#3409, Fitz's ruling): the walking engine found no walk there ("unmapped"), so the bearing is the
-- straight one, as before 0.4.2, and the arrow says why under its label (Arrow.lua). Set by each sample
-- (Travel.Aim for a route's walk), nil when a walk guides. Enemy ground refuses no bearing (0.4.2.1, as before 0.4.2).
local function groundAim(C,pc,px,py,d,angle,dn,dw,measured)
	return "travel",d,angle,dn,dw,measured,Nav.danger.NearEnemyGround(pc,px,py,C.GetPlayerFaction())
end

local function sample()
	floorHint, Nav.noWalk = nil, nil
	if not target then return "none" end
	local C = ns.Compat
	if not C then return "unknown" end
	if C.IsInInstance and C.IsInInstance() then return "instance" end
	if C.IsOnTaxi and C.IsOnTaxi() then return "taxi" end
	if not tC then
		resolve()
		if not tC then return "unknown" end
	end
	local ok, pc, px, py = pcall(C.GetPlayerWorldPosition)
	if not (ok and number(pc) and number(px) and number(py)) then
		-- No position, nothing to measure. A ride, flight or hearth on the
		-- route is still what to do (the tram ride itself); else say so.
		local T = Nav.travel
		local leg = T and T.Active and T.Active() and T.CurrentLeg()
		if leg and leg.kind ~= "walk" then return "instruction" end
		return "nopos"
	end

	local T = Nav.travel
	if T and T.Active and T.Active() then
		local mode, ac, ax, ay, left = T.Aim(pc, px, py)
		-- The leg's walk still to come: straight to the leg's end meanwhile.
		if mode == "routing" then
			if ac == pc then return "routing", toward(C, px, py, ax, ay) end
			return "routing"
		end
		if mode == "unmapped" then return mode end
		if mode == "instruction" then
			if ac == pc then return "instruction", toward(C, px, py, ax, ay) end
			return "instruction"
		elseif mode == "walk" then
			if ac ~= pc then return "far" end
			local dist, angle, dn, dw = toward(C, px, py, ax, ay)
			return groundAim(C,pc,px,py,left or dist,angle,dn,dw,left ~= nil)
		end
		-- nil: the last leg, straight to the target
	end
	-- The planner holds a route while its landing's walk into the target is checked (Travel.Waiting): no walk
	-- straight to the target meanwhile, which would take that check's frames (#3369); the bearing straight to it.
	if T and T.Waiting and T.Waiting() then
		local W = Nav.walk
		if W and W.Clear then W.Clear() end
		if pc == tC then return "routing", toward(C, px, py, tX, tY) end
		return "routing"
	end

	if pc ~= tC then return "far" end
	local dist, angle, dn, dw = toward(C, px, py, tX, tY)
	local area = tonumber(target.area)
	if area and area > 0 then dist = dist > area and dist - area or 0 end
	local r = target.r or Nav.DEFAULT_RADIUS
	-- No height to use: as before heights were checked (heightless).
	local flat = (exactPoint or wetReach ~= nil) and not (T and T.place) and heightless(C, pc)
	local wet = wetReach ~= nil and not (T and T.place) and not flat
	if wet then
		if dist <= 20 then return submergedSample(C) end
		-- A distant measured walk may still guide towards the area, never to
		-- the submerged point itself. No fallback bearing across open water.
		r = 0
		arrived = false
		if pointAnnounced then submergedSample(C) end -- only a trusted XYZ departure re-arms it
		local read, swim = pcall(IsSwimming)
		if not read or (issecretvalue and issecretvalue(swim)) or swim ~= false then return "unmapped" end
	end
	local exact = exactPoint and not wet and not (T and T.place) and not flat
	local stacked, liveZ
	-- Near the target, the player's floor against its height: not arrived
	-- while a floor apart (Undercity's levels, caves, towers), and the arrow
	-- says up or down (Nav.FloorHint). Not in a place only portals reach (the
	-- walking maps have no floor there: the Wizard's Sanctum's chamber, #1970).
	if tZ and dist <= max(r * 2, 20) and not (T and T.place) and not (flat and target.kind == "goto") then
		local W = Nav.walk
		local z = W and W.Floor and W.Floor(pc, px, py)
		stacked = number(z) and not (area and area > 0) and stackedAt(z, tZ, dist)
		if number(z) and (stacked or abs(z - tZ) > FLOOR_GAP or (W.OnApproachFloor and W.OnApproachFloor(tC, tX, tY, tZ, z))) then
			floorHint = z < tZ and "up" or "down"
		end
	end
	if exact then
		local reach = math.min(r,5)
		arrived = false
		if dist <= 20 or pointAnnounced then
			local d2, visit, contradicted
			d2, visit, liveZ, contradicted = dryVisit(C, pc, tX, tY, tZ, reach)
			if contradicted then return "unmapped" end
			if d2 and d2 > (reach+5)^2 then pointAnnounced = false end
			if visit and not floorHint and dist <= reach then
				announcePoint()
				return "arrived", sqrt(d2), angle, dn, dw
			end
		end
	elseif arrived then
		local leave = r + max(5, r * 0.5)
		-- In an area target (a kill step's spawn area), the arrival holds while the player stays within
		-- Nav.NEAR_LINE yards of it on open ground, where no route line is drawn either (Nav.NearOpenArea): the
		-- arrow no longer comes back each time the fight moves a few yards out of the area (#3828, flep).
		if area and area > 0 and not (IsIndoors and IsIndoors()) then leave = max(leave, Nav.NEAR_LINE) end
		if dist > leave or floorHint then
			arrived = false
			-- Without a height, a departure on the map is the real one (re-arms the chime).
			if flat and dist > leave then pointAnnounced = false end
		end
	elseif dist <= r and not floorHint then
		arrived = true
		-- One chime per visit, measured with a height or without (pointAnnounced: the visit the height measured).
		if not (flat and pointAnnounced) then
			playArrival()
			-- NAV_ARRIVED(target): once per arrival (Nav/Nearby.lua ends its trip).
			pcall(ns.Fire, "NAV_ARRIVED", target)
		end
		if flat then pointAnnounced = true end
	end
	if arrived and target.search then return "search", dist, angle, dn, dw end
	if arrived then return "arrived", dist, angle, dn, dw end
	-- Along the walking engine's path when it has one (Nav/Walk.lua); the
	-- distance is then what is left of it (an area target: to its edge, straight).
	local W = Nav.walk
	local leg = T and T.CurrentLeg and T.CurrentLeg()
	local checkedOnly = leg and (leg.corpseGround or (leg.parent and leg.parent.leg.corpseGround))
	if W then
		local wc, wx, wy, left, unmapped = W.Aim(pc, px, py, tC, tX, tY, (leg and leg.handmade) or W.FollowsGoto(target), nil, nil, checkedOnly)
		-- The walk still to come: the straight bearing meanwhile, but for a checked detour (Walk.checkedOnly).
		if unmapped == "routing" then
			if checkedOnly then return "routing" end
			return "routing", dist, angle, dn, dw
		end
		-- No walk found (Walk.GroundStatus' reason, or true: a partial or a checked detour without its walk): straight.
		if unmapped then Nav.noWalk = "unmapped" end
		if wc then
			if exact and liveZ and dist <= 20 and bodyBlocked(pc,px,py,liveZ,wx,wy,2.75) then
				if W.RefineTerminal then W.RefineTerminal(pc,px,py,tX,tY,tZ) end
				return "unmapped"
			end
			if exact and dist <= r and not floorHint then
				-- Extend a chosen bearing only along the verified dry segment to
				-- the exact point, never past its end.
				local ax, ay, P = wx - px, wy - py, Nav.Path
				local along = ax*dn + ay*dw
				if not left or not liveZ or W.Unmapped() or not P or not P.FinalDrySight then return "unmapped" end
				if along > 0 and (ax*dw-ay*dn)^2 <= .04^2*(ax*ax+ay*ay) and
					(P.FinalDrySight(pc,px,py,liveZ,tX,tY,tZ) or (P.FootprintDrySight and P.FootprintDrySight(pc,px,py,liveZ,tX,tY,tZ))) then
					return groundAim(C,pc,px,py,dist,angle,dn,dw,true)
				end
				local az, piece
				if W.DetailAimZ then az,piece=W.DetailAimZ(wx,wy,px,py,liveZ) end
				if not piece and (not az or not P.FinalDrySight(pc,px,py,liveZ,wx,wy,az)) then
					if W.RefineTerminal then W.RefineTerminal(pc,px,py,tX,tY,tZ) end
					return "unmapped"
				end
			end
			if wet and (not left or (wx-tX)^2 + (wy-tY)^2 <= 20^2) then return "unmapped" end
			local _, a2, dn2, dw2 = toward(C, px, py, wx, wy)
			if area and area > 0 then return groundAim(C,pc,px,py,dist,a2,dn2,dw2) end
			return groundAim(C,pc,px,py,left,a2,dn2,dw2,true)
		end
	end
	-- On a slope Follow.Step may finish inside the horizontal circle before
	-- dryVisit enters the 3D sphere. Walk the remaining certified ground;
	-- never enlarge the arrival radius or revive an unmapped/partial route.
	if exact and liveZ and not floorHint and dist <= math.min(r,5)
		and dist*dist + (liveZ-tZ)^2 > math.min(r,5)^2
		and W and W.ExhaustedAt and W.ExhaustedAt(pc,tX,tY,tZ)
		and Nav.Path and Nav.Path.FootprintDrySight and Nav.Path.FootprintDrySight(pc,px,py,liveZ,tX,tY,tZ) then
		return groundAim(C,pc,px,py,dist,angle,dn,dw,true)
	end
	if exact and liveZ and not floorHint and dist <= r and W and W.RefineTerminal then W.RefineTerminal(pc,px,py,tX,tY,tZ) end
	if checkedOnly then Nav.noWalk = Nav.noWalk or "unmapped" end
	if wet or (exact and dist <= r) or (stacked and W and W.Searches and W.Searches(pc) and not (tDock or W.FollowsGoto(target))) then return "unmapped" end
	if exact and liveZ and dist <= 20 and bodyBlocked(pc,px,py,liveZ,tX,tY,2.75,tZ) then return "unmapped" end
	return groundAim(C,pc,px,py,dist,angle,dn,dw)
end

-- Map painters must not run the sampler: it advances route legs and can
-- announce a visit. Remember a refusal only for the target and leg it was
-- about.
local noGround = { unmapped = true, submerged = true, ["water-depth"] = true, ["arrived-underwater"] = true }
local refusedTarget, refusedLeg
local function groundLeg()
	local T = Nav.travel
	return T and T.Active() and T.CurrentLeg() or nil
end

-- An area objective (a kill's or a collect's spawn area: target.search) within Nav.NEAR_LINE yards on open ground,
-- its walk no longer than Nav.NEAR_BEND times the straight way: the arrow alone, no route line (#3641 E: in Hillsbrad
-- Fields a line looped round the farm for a 79 yd target the player was already walking to through the field).
Nav.NEAR_LINE, Nav.NEAR_BEND = 60, 1.25
function Nav.NearOpenArea()
	if not (target and target.search and tC) or (IsIndoors and IsIndoors()) then return false end
	local C = ns.Compat
	local pc, px, py = C.GetPlayerWorldPosition()
	if pc ~= tC then return false end
	local d = math.sqrt((tX - px) ^ 2 + (tY - py) ^ 2)
	if d > Nav.NEAR_LINE then return false end
	local W = Nav.walk
	local left = W and W.LiveLeft and W.LiveLeft(tC, tX, tY)
	return left ~= nil and left <= d * Nav.NEAR_BEND + 5
end
function Nav.CanDrawGroundApproach(c, x, y, gx, gy)
	if not target then return false end
	if Nav.NearOpenArea() then return false end
	if refusedTarget == target and refusedLeg == groundLeg() then return false end
	local W = Nav.walk
	local T = Nav.travel
	local current = T and T.CurrentLeg and T.CurrentLeg()
	if W and W.GroundStatus and (not current or current.kind == "walk") and not (current and current.handmade) then
		local legs, index = Nav.GetRoute()
		if not ((not legs or index == #legs) and W.FollowsGoto(target)) then
			local to = current and (current.parent and current.parent.leg.to or current.to)
			local status
			if to then status = W.GroundStatus(to.c, to.wx, to.wy, to.z)
			else status = W.GroundStatus(tC, tX, tY, tZ) end
			-- Its answer still to come: no line yet. No walk found: the straight line, as before 0.4.2 (#3409).
			if status == "routing" then return false end
		end
	end
	local whole = current and (current.parent and current.parent.leg or current)
	if c ~= nil and whole and whole.kind == "walk" and whole.corpseGround then
		-- Once its checked path is in, only that path supplies geometry for this
		-- detour: a straight trail from the player to its end is not the path that was checked.
		local to = whole.to
		if W and W.CheckedAt(to.c, to.wx, to.wy, to.z) then return false end
	end
	return true
end

local function recordSample(sampled, state, ...)
	if sampled == target and (noGround[state] or refusedTarget) then
		local t, leg
		if noGround[state] then
			t = target
			leg = groundLeg()
		end
		if t ~= refusedTarget or leg ~= refusedLeg then
			refusedTarget, refusedLeg = t, leg
			ns.Fire("NAV_ROUTE_GEOMETRY")
		end
	end
	return state, ...
end

function Nav.Sample()
	return recordSample(target, sample())
end

-- "up" or "down" while the player is near the target but a floor below or
-- above it (the last Nav.Sample), else nil; the arrow shows it.
function Nav.FloorHint() return floorHint end

-- States in which nothing is drawn at all.
function Nav.IsHiddenState(state)
	return state == "none" or state == "instance" or state == "taxi" or state == "unknown"
end

-- The target relative to the player: dNorth, dWest in yards (same continent
-- only, nil otherwise). Allocation-free.
function Nav.TargetOffset()
	if not target then return nil end
	local C = ns.Compat
	if not (C and C.GetPlayerWorldPosition) then return nil end
	if not tC then
		resolve()
		if not tC then return nil end
	end
	local pc, px, py = C.GetPlayerWorldPosition()
	if pc ~= tC then return nil end
	return tX - px, tY - py
end

-- Straight-line yards to the target (not along a travel route); to an area
-- target's edge, 0 inside it.
function Nav.GetDistance()
	local state = Nav.Sample()
	if Nav.IsHiddenState(state) then return nil end
	local dn, dw = Nav.TargetOffset()
	if not dn then return nil end
	local d, area = sqrt(dn * dn + dw * dw), tonumber(target.area)
	if area and area > 0 then d = d > area and d - area or 0 end
	return d
end

-- An area objective's target (the Engine's waypoint with `spots`): move it on
-- to the next spot, or to spot `index`. True if the Engine took it.
function Nav.NextSpot(index)
	local t, E = target, ns.Engine
	if not (t and t.spots and t == engineWp and E and E.CycleSpot) then return false end
	return E.CycleSpot(t.stepIndex, t.goalIndex, index) ~= nil
end

-- Display name of the target's zone (shown when it is on another continent).
function Nav.GetTargetZoneName()
	if not target then return nil end
	local C = ns.Compat
	local name = C and C.GetMapName and C.GetMapName(target.map)
	return name or target.zoneName
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

-- STEP_CHANGED / GUIDE_CHANGED drop an override or dismissal. The Engine
-- fires them before it stores the new step's waypoint (WAYPOINT_CHANGED
-- follows, and only when the waypoint differs), so the new target is taken
-- from that WAYPOINT_CHANGED, or after the dispatch when none comes. Without
-- an override nothing happens here: re-applying the old waypoint would reset
-- arrival (a second chime) and churn TomTom and the Blizzard waypoint.
local pendingStep = false

local function settleStep()
	if not pendingStep then return end
	pendingStep = false
	local Engine = ns.Engine
	if Engine and Engine.GetWaypoint then engineWp = Engine.GetWaypoint() end
	apply(true)
end

ns.On("WAYPOINT_CHANGED", function(wp)
	-- Another target took over: the trip is over, without a word.
	if trip and not Nav.Trip() then ns.Fire("NAV_TRIP", nil) end
	if firing then return end -- our own announcement
	if dismissed and not samePoint(wp, engineWp) then dismissed = false end
	engineWp = wp
	if override then return end
	pendingStep = false
	apply(false)
end)

-- There: a trip to a place goes back to the guide, after the arrival is drawn.
ns.On("NAV_ARRIVED", function(t)
	if not (trip and trip.target == t and trip.ends == "arrive") then return end
	ns.After(0, function()
		if trip and trip.target == t then Nav.EndTrip(true) end
	end)
end)

local function stepMoved()
	if override == nil and not dismissed then return end
	override, dismissed = nil, false
	if pendingStep then return end
	pendingStep = true
	if C_Timer and C_Timer.After then
		ns.After(0, settleStep)
	else
		settleStep()
	end
end
ns.On("STEP_CHANGED", stepMoved)
ns.On("GUIDE_CHANGED", stepMoved)

ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "nav" or (type(path) == "string" and path:sub(1, 4) == "nav.") then
		notify("OnSettings")
	elseif path == "ui.shown" or path == "ui" then
		Nav.Refresh() -- the travel button (and the arrow, Nav.HiddenWithGuide) go and come back with the guide
	end
end)
ns.On("GUIDE_SHOWN", function() Nav.Refresh() end) -- an instance hide (ns.GuideShown)
ns.On("POLESTAR_HIDDEN", function() Nav.Refresh() end) -- the arrow and its travel button (ns.ArrowHidden)
-- Paused or resumed: the Engine's waypoint goes or comes back (a hold or
-- a picked point over it stays as it is: no second chime).
ns.On("POLESTAR_PAUSED", function()
	if not (hold or override) and engineTarget() ~= target then apply(true) end
	Nav.Refresh()
end)

local function situationChanged()
	if target and not tC then resolve() end
	-- Through an instance's portal: a trip to a dungeon's entrance is over.
	local t = Nav.Trip()
	if t and t.ends == "instance" and inInstance() ~= t.inside then Nav.EndTrip(true) end
	Nav.Refresh()
end
for _, event in ipairs({
	"PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
	"PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED",
}) do
	ns.RegisterEvent(event, situationChanged)
end

ns.OnInit(function()
	refreshPalette()
	paletteMoved()
	local T = ns.Theme
	if type(T) == "table" and type(T.OnChanged) == "function" then
		T.OnChanged(function()
			refreshPalette()
			-- A live repaint (a slider dragged) changes colours alone: when
			-- none of Nav's moved, nothing Nav shows changes either.
			if not paletteMoved() and T.LiveChanged and T.LiveChanged() then return end
			notify("OnTheme")
		end)
	end
	notify("OnTheme")
	notify("OnSettings")
end)

ns.OnLogin(function()
	local Engine = ns.Engine
	if Engine and Engine.GetWaypoint then engineWp = Engine.GetWaypoint() end
	apply(false)
end)

---------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------

-- While Shortest Path Forever guides (Nav/Handoff.lua: handed off, or a
-- journey of its own runs), a command that would show Polestar's own arrow
-- or route says so in one line instead. True if it did.
function Nav.SayHandedOff()
	if not (Nav.HandedOff and Nav.HandedOff()) then return false end
	local H = Nav.handoff
	if H and H.Yielding and H.Yielding() then
		ns.Print(L["Shortest Path Forever is guiding a journey of its own. Polestar's arrow comes back when it ends."])
	else
		ns.Print(L["Shortest Path Forever is guiding. Turn off \"Hand guiding to Shortest Path Forever\" (Settings, Integrations) to use Polestar's arrow."])
	end
	return true
end

-- An option with no effect while Shortest Path Forever guides: greyed out
-- then (with any `disabled` it had), its help saying why. Returns `c`.
function Nav.HandoffOption(c)
	local was = c.disabled
	c.disabled = function()
		if Nav.HandedOff and Nav.HandedOff() then return true end
		return was ~= nil and was() or false
	end
	local why = L["Greyed out while Shortest Path Forever guides: it does this itself."]
	c.help = c.help and (c.help .. " " .. why) or why
	return c
end

-- Whether hiding the guide window (ui.shown) hides the arrow now: only with
-- nav.hideArrowWithGuide on, and never while the arrow is held (Nav.Hold: the
-- way back to your corpse or a Spirit Healer). The travel button goes with
-- the window either way (Nav/Prompts.lua). The window's own on/off: hiding
-- Polestar takes the arrow by ns.ArrowHidden, not by this.
function Nav.HiddenWithGuide()
	if ns.GuideWindowOn() or not ns.Get("nav.hideArrowWithGuide") then return false end
	return hold == nil
end

-- A command that asked for the arrow while something hides it still takes
-- effect: says why nothing shows yet, another addon keeping it out of sight
-- included (ns.OutOfSight).
local function arrowOutOfSight()
	return Nav.arrow ~= nil and ns.OutOfSight(Nav.arrow.frame)
end
function Nav.SayGuideHidden()
	if ns.ArrowHidden() then
		ns.Print(L["Polestar is hidden, the arrow with it: \"Keep the arrow when hidden\" in the minimap button's menu keeps it."])
	elseif Nav.HiddenWithGuide() then
		ns.Print(L["The guide is hidden and \"Hide the arrow with the guide\" is on, so the arrow is hidden too: /polestar show brings them back."])
	elseif ns.PauseHides("arrow") and not (hold or override) then
		ns.Print(L["Polestar is paused: the arrow follows the guide again once you leave the dungeon alive, or after /polestar resume."])
	elseif arrowOutOfSight() then
		ns.SayOutOfSight()
	end
end

-- The arrow on or off (nav.arrow): /polestar arrow, the minimap button's menu.
-- One that is on but kept out of sight stays on: the toggle says why it is
-- not seen, as the window's does.
function Nav.ToggleArrow()
	if not ns.Get("nav.arrow") and Nav.SayHandedOff() then return end
	if ns.Get("nav.arrow") and arrowOutOfSight() then
		ns.SayOutOfSight()
		return
	end
	ns.Set("nav.arrow", not ns.Get("nav.arrow"))
	if ns.Get("nav.arrow") then Nav.SayGuideHidden() end
end

-- Quiet (Init.lua's RegisterCommand): the arrow's commands set the arrow and
-- say why it does not show while Polestar is hidden.
ns.RegisterCommand("arrow", function(rest)
	local arg = (rest or ""):lower()
	if arg == "reset" then
		ns.Set("nav.arrowPos", nil)
	elseif arg == "show" or arg == "hide" then
		if arg == "show" and Nav.SayHandedOff() then return end
		ns.Set("nav.arrow", arg == "show")
		if arg == "show" then Nav.SayGuideHidden() end
	else
		Nav.ToggleArrow()
	end
end, L["Waypoint arrow: show, hide, reset"], true)

-- Two whitespace-separated coordinates take decimal points ("45.5 30.2") or a
-- decimal comma in both ("45,5 30,2"); otherwise a comma separates x and y
-- ("45,30", "45, 30 Camp"). A decimal comma in only one ("45,5 30", "45 30,2")
-- is refused: it reads just as well as x,y with a numeric label ("45,30 50"),
-- and either guess can point the arrow at a plausible wrong spot.
local function parseWay(s)
	local x, y, label = s:match("^%s*(%d+[,%.]?%d*)%s+(%d+[,%.]?%d*)(.*)$")
	if x and (label == "" or label:match("^%s")) then
		if (x:find("%d,%d") ~= nil) ~= (y:find("%d,%d") ~= nil) then return end
		x, y = x:gsub(",", "."), y:gsub(",", ".")
	else
		x, y, label = s:match("^%s*([%d%.]+)[%s,]+([%d%.]+)(.*)$")
	end
	return tonumber(x), tonumber(y), label and label:match("^%s*(.-)%s*$")
end

ns.RegisterCommand("way", function(rest)
	local x, y, label = parseWay(rest or "")
	if x and y and (x > 100 or y > 100) then x = nil end
	if not (x and y) then
		if (rest or ""):match("^%s*$") then
			Nav.ClearTarget()
		else
			ns.Print(L["Usage: /polestar way <x> <y> [label]"])
		end
		return
	end
	local C = ns.Compat
	local map = C and C.GetPlayerMapPosition and C.GetPlayerMapPosition()
	if not map then
		ns.Print(L["No position here: the game gives none in instances and on some maps."])
		return
	end
	if Nav.SetTarget(map, x, y, label ~= "" and label or nil) then Nav.SayGuideHidden() end
end, L["Point the arrow at x y on your current map (no argument clears it)"], true)

do
local depthPages, depthBalls = {}, {}

depthPages[0]={
[106288]="eNrtzCESABAYBWEze3AnUxRJU2iKLL5GcYI/GEHY+O3yzq1HSoiICAiLL4h8HhbfEfU8LH4iBqIZ/e93uw1PkoHw",
[110337]="eNr7X8/A8H8Uj+JBjn0YChm8GAoZfBkKGYIYCknW78xQCMYuUHNI1e8LtRuEfbDoj2AoZAiD4kgs8pFQcZC6cDLspxUGAEuHb0Y=",
[110338]="eNr7X8/A8H8Uj+IhjnMYCinSH0+hfj+GQoZQhkKGNIZChlwKzaInBgBVo3oD",
[109859]="eNr7X8/A8H+Y4BLGdsZsxnbGRsZ2RnL1ZzK2M9aQqb8Yqr+UTP0jGZcxtjPmMLYzpjK2M2aRGX61jO2MudA4INcd1Tj0t5FgZj4Wtc2DNE0AAFk7c2E=",
[110371]="eNr7X8/A8H+Q4TbGdkZ0sTzGdsYixnbGKsZ2xmYs8oRwDmM7YyljO2M9GXph+ivItBuE8xnbGavJ1DuKGRgqKQy7oa6fVhgAZth1ww==",
[112863]="eNr7X8/A8H8UUw23MU9hBuHRsCANn2OawoyM6a1/pGIAu/N8nA==",
[112862]="eNr7X8/A8H8Uj+IRhCczT2GmRH83GfqLmacww3AhhfZTEwMACv17oA==",
[113373]="eNrd0SEKgEAURdGBuzWDoLgCi2AQJhg0GASz/e13LA58RMOYHMNJjxs+P2zOhQysCCu19wgrt/7vZsRkXPcGUSNKRHGzL4gRMSC6F/2OsJ766pR6X4+I2g/9/wAnVmh5",
[113374]="eNr7X8/A8H8IYBbmKcx/mKYwf2eawvyBaQozqfqZofp/Mk1h/kyGfk4K9fNQqH+4Yw3mKczIGFf4geL+LZbw02SewoyMscXfL6YpzO+YpjA/J0M/KP18oUD/byb8+gcKAwAHhW3H",
[113375]="eNr7X8/A8H8E4UnMU5gp0R/OPIU5nwIzdJinMAdT6IbhiLczTWFeyTSFeSkUo8tLMk9hDsATbnuYpjBvokD/PqYpzFuooH8rFJOqf6AwAJadcqE=",
[113885]="eNrl0CEKgEAARNGFHzTYDTaTYPAQ4i1EDBbPYLCZjHPflYU9wSTF8OObMPEMIX6gC7EjNsSMcDaSXxCj6VfEhOhMfyB6RGP6v5f+q8zvbsSACKZvEUXO8TWizL3p0wf1H26Q",
[113886]="eNrtkjsKgDAQBeW9g3uJd7UgRBELP4hWXkAJKIQQjZDGwmKqYVjY3b0siv0DbBB9Qt9B9An9ANEn9A3ECxvxC8QZ4gRxjPgKosPc9Gui/3mH212fsT/3G21GX0OsI705b3/x1Kdm2A/9xwHc2315",
[113887]="eNr7X8/A8H8Q4MdMU5hh+BvTFGZS9T9hmsIMwwOtn4mZdP0jHd9mmsIMwg/JDL8bTFOYQfgm0xTmL2TE3zWmKczXoG74S4b+W1D7GZinMMsNofgHAOpTem8=",
[114397]="eNr7X8/A8H8Q4ETmKcxOzFOYlaAYXZ6NeQozDLNikQ9insKswDyFWRSKB4OfRvHgwd+YpjAjY3T590xTmF8hYXrrHygMAEfTdfg=",
[114398]="eNr7X8/A8H8Q4HdMU5hfMU1hfsI0hZmQ2kdY1NBTP6XuH8WY+BnTFGYQfs00hfkdGWFIqf4XTFOYX1Cg/xU0/j9CMT61PwdRGgEAiEl+qw==",
[114399]="eNr7X8/A8H8QYHbmKcz8zFOY7ZmnMPczT2EmVT8f8xRmYeYpzIlk6EXG7RTqH8WjeChhAG4PeN0=",
[114396]="eNr7X8/A8H8Uj+JBjsOYpzCbMU9h1mWewqzEPIWZVP2GzFOY1aF6mcjQr06h/iDmKcwgLMk8hfkzE+n6aYUBIrVzSA==",
[111359]="eNr7X8/A8H8Uj+JBgAsYChnSGQoZkhkKydKfw1DIkMRQyJBKpv4MqN3pZOpPherNJlP/QGAAZ+J2Sg==",
[111871]="eNr7X8/A8H8Q4EyGwhGtfxSP4oHAAL5ee4A=",
[112383]="eNrlkjEKwkAUBecYEhBshLTmBKaQJNpKbFQQBJs0cwKPniBss7IpkiqQYqrPvOL913+hXwAdRkz1W4yY6p+RE1Ihlxl+gxyREqln+GvnhdxC92WivwIj/u8f5IlcR/63x4jU/t7IPWSk/C2SBcY2/Mt4JO4HJEd2yGZB+xgAPf1ZoA==",
[110848]="eNr7X8/A8H+I4RyGwiHn5lE8igcjBgCalX1v",
[110850]="eNr7X8/A8H+Q4SyGwkHnplE8sDiSoZAhiaGQIZ/MtBHFUMgQx1DIkE6m/hSGQrAZyQyFDAVkmAHSHwZ1Q8YgSt8A75x0EQ==",
[111362]="eNrl0TEKgDAAQ9F/M5G2gohdBAed9AY5gUevi0Pn6KA4ZHwEknJA+UA2REQExIgsnxANojf8jliu/nTTt4b/eyZERnTmfmvlg+lnxPCAjy/6/wQu2GYw",
[111874]="eNrlkTEKwkAQRd8xxCKFIFrEwkasbFwhxE60WktBQSz+CXL0yCyLxTIipFIsXjOP4Q9/+g76L+KBEuV8jxINIjjeuCNumdLt0Iut4y3zgoiIo+NDzjVax18RZ8Qh31j6DUqYO725/5+xv6wRC8TU6Sd+6My6XSJmiGpAvytEjZggxgP2LXue90c/9N8nDhJaHg==",
[112384]="eNrtkSEKgEAUBSeoIOiCxQWbit5LMBh9J/DoK8gGWcQNFkHDpJlX/ncbuJ/HrOjWT4gZsUS6r9Ij2hOh79DRDIjxwjcIi6g9obeRu1cIgygRxUVrIvsckSEST+jTl/59BwYjZTo=",
[112385]="eNrlkcEKQVEURdcnKOVlIFJSSoqhhAnFwEiUXpkYUAb7C3z6k9tNPXbX9JXBmpzVbtc+xQOKinFBX7c7KpHK58afUYlU/mj8AjGPzBL5K+Jg/BgxQgwQ3R/9/0gfBXqIjtmnHrdbIjbGt1GghWga/9p8GPNb4zMUaKDQ9ekniClihdgbX0NvMuPXiB3ihLhV6P9PREhSwQ==",
[112386]="eNr7X8/A8H+Q4WyGwkHnplE8iocjBgCDCX1u",
[112896]="eNr7X8/A8H8QYD2GQjDWZSjEKv/+fyHDq/+FDG//FzJ8/I+pxp6hEIxNcegnhJH1i5FhBqX6RzqOZShk8GYoZLCEpgNS9ScxFDIEMBQy2JIZ9qkMhQyhDIUMriMs7gDLlG4i",
[112897]="eNr7X8/A8H8QYHaGQgYBhkIGDYZChmiGwkHhplE8ioc7BgBA5np2",
[110883]="eNr7X8/A8H8I4FLGdkZK9BcxtjO2UWBGAWM7YysF+vMY2xmbKfTDSMag8KuhMPwrqKCf3DRAqX5aYQBU8XXE",
[111395]="eNr7X8/A8H8I4RrGdkZK9JcwtjO2UmBGDmM7YzUF+pMZ2xkLKPTDSMTBjO2M/oztjEGM7YwJZIQfSH8IYztjJplhH0KmvTAcztjOWDgI4x0Ao9Vz5Q==",
[111907]="eNr7X8/A8H8I4HjGdsZSxnbGgdKfzNjOmEuB/izGdsYUxnbGegrMGMUMDHmM7YyVFIThUNdPbQwAuWV1LA==",
[112932]="eNr7X8/A8H8U0xwXMrYz1jO2M46GBXm4nLGdMZ+xnTGVsZ0xloxwbGRsZyxjbGfMZmxnTCIzHkBmwNwxXMIVANxcd2I=",
[113445]="eNr7X8/A8H8U0xy3MrYzjobDKB5sGACKwH2g",
[113958]="eNr7X8/A8H8Q4RLGdsZGxnZGSsyoHmD9o3gU48KNgyxtAQA5mXuz",
[114470]="eNr7X8/A8H8I4SLGdkZK9GcztjNWUWBGBWM7YzYF+kF2Z1Loh5GMQeFXSEH4FVCgv5qxnTGRTP1NjO2MyYztjPEUup/aGAByN3TB",
[114909]="eNrt0CEOg0AQRmG6T5HUNhwAxwmQCFKF5QZYwgVISFpf9Z+wFtUTLAoDE0ogTVZUPDMznxk/RJEPoAZxR1wR3onlfnTibcznnogeUSEy1ncx236uQxSGvyE+O/wL0Ro+QVz47v/ZPRAlIkekB/4Ygq9P+F81AcZsazo=",
[114910]="eNr7X8/A8H+Q4PdMU5g/QzG6nCbzFGZt5inMhsxTmE2ZMeWppf8TFOPT70Ch/hgc+kcxbizPPIVZj3kKczKZYefIPIU5gHkKcwmZ+kF6U5mnMHdQoD9jEMY7ADDcbVw=",
[115422]="eNr7X8/A8H8Q4U7mKcxZzFOYKTGjj0L9o3gUjxQMAMB3fOU=",
[114982]="eNr7X8/A8H8I4CbGdkZK9LdRqH8Uj+LhiAHUn30u",
[117542]="eNr7X8/A8H+I4WLGdkZy9ZYytjNmU6ifEvvrGNsZ6yjQP4pHMTUxAJybepQ=",
[118566]="eNr7X8/A8H8UE8QJjPmMUYz5jOTqD2fMZwxizGdMoMCMkYzdGPMZrRnzGU0Z8xkNyQhDH8Z8RgfGfEZzMvX7DrB+WmEA8bVthw==",
[118567]="eNrt0DEKgDAQRFH/vSxFsDMgNmoXtZwjePTYrBCWgKUWKV71mWbS1TSpqj62Ig7EaXyP1h++T4gtU+ozYkHEQh8QIyIY38PLvkV0iN74viNyf/n9BjnAZ6s=",
[118568]="eNrtyyEKgDAAheH90SZiEGzqAVy1CGKymbyA/R3Bo08GrshcXTF85f08dxnjfr/MTsSB2BEb4t0XhDcjbKT7/4qYPrp99hExJP49oon0DhG0iX+JKCK9RgRVpOdyA/MtYvY=",
[118569]="eNrtzKEKwmAUQOF72NC5YhHXDIbhmFmDiI90HsGHthmc/GCS21cWTvrgTM+IaWlp5g7IGbkid+TfH0jphlwSb5EOOSKnxEekNCB94u+QFbJFdol3v39pn/gr5BNSI03iG6S0RqrE5+oLFFBiwQ==",
[118570]="eNrtz6ENgDAYBeHeIhgEGoIvwSEJhgUqUDdCRy87/Kam4pP3ktdqSm0YOruQF/mQSL8jJ/IgJbAxIyuSkTvQT8iCbMgR/NDDD2WtciA=",
[117571]="eNr7X8/A8H+I4beM/xkp0f+KQv3PKNQ/ikfxYMEAjJ1/Vg==",
[117593]="eNr7X8/A8H8U0wXHMycxw/BoeIziwYABLdR76w==",
[120077]="eNr7X8/A8H8Uj+JhgEMYwxkp0R80wPoHAgMAVD97mQ==",
[120589]="eNr7X8/A8H+QYH/GcMbB4pZRPIpHAgYAyop9Og==",
[120591]="eNr7X8/A8H8Uj+JRjBc7M4YzmiBhUvVLM4YzIuPB4i8AQw92Mw==",
[120592]="eNr7X8/A8H8Uj+IhjkMZwxlhmJBaTyxqTBnDGa2RMLq8GWM4IwgbMIYzmmORl2UMZ1RiDGdUhmJ0eXXGcEZkPFjCDQAvBWtO",
[120593]="eNr7X8/A8H8Uj+JRTBEOZgxnHIruBgAWv30+",
[121104]="eNr7X8/A8H8QYBPGcEYQNmYMZ9RgDGdEl2diDGdExujy9ozhjDBsjkWenzGcERnjc4sDhfqxYUr1j+JRTAsMAHLqZCY=",
[121105]="eNr7X8/A8H8QYBXGcEYDxnBGf8ZwRnL0KzGGM1qQqReEdSnUb8QYzuhIgf5RPIoHAgMAL411mA==",
[121618]="eNr7X8/A8H8Uk4TTGfMZKdGfQKH+kYhBYYaMSdUfypjPCMKBUEyufn/GfEZDCvXLD6L4BwAtZnD7",
[122130]="eNr7X8/A8H+I4BTGfMYwxnxGH8Z8RnLNyGLMZ8yiQP8oHsXDCQMAuop6qQ==",
[122132]="eNr7X8/A8H8UUwXnMOYzwvBoeIzioYABml58LQ==",
[122133]="eNr7X8/A8H8U0xybM+YzOjHmM8Yy5jOOhgd2nM6YzxgJxehy0Yz5jPGM+YwJUIzLjETGfMbE0TAmGgMAi5R1nw==",
[122134]="eNr7X8/A8H8UUxXnMeYzEiM2iknDOYz5jGFQPBoe1MEAswV6ww==",
[122135]="eNr7X8/A8H8Uj+IBxlGM+YwwPBoe9MMAoDh79w==",
[120095]="eNrdkrEKQFAYRp3Xkk1ZbiHpSmRSyvI9gkenW4Y7XAkLhjOdzvJ//7pE0foRJsSAsIir7bh39mZvH/bFw/7vNIgcYRBp4D41wlEi4oD3e3PSJwHvNuk9jvoKkQV8u/+mYz7Zt3vR/htV115W",
[120094]="eNr7X8/A8H8Uj+JRTDTOY8xnpER/JoX6qYkB1Kl8zQ==",
[120606]="eNrl0bEKQFAAhWH/EygGJS/AQxgoGSQmynAXi+k8gkdnoQzq5k5kONPpW87ZVs/bPpAZYRAjokU89RNiQPSI2sF3iOawpYOvDlcgcgf/92SIFJEgIof9Th8jQotfbvqrDyzeWLz/ov93pYpiAw==",
[120607]="eNrt0iESQWEYRuH3SIwFWIFyR1ZsQLEVZwmWptwoCIoNCIIZQTDCVf5gfhJFuOFJZ77yztdtkq73szXS7/C9EbJAVkXdl0iDTIq6PyJTZF7UfYaMkVvkmvd+iQyQYVH3e+QUOUb2H+7PkVd1P0R2kTayzf/8yhNhLGw7",
[121117]="eNrtkTEOQEAABHd6rfAAHfEOb5DwAM0+wXPpFErFif5EKEShmGozzWwYpfDzKh3m73CPGlNhSkzxoF+OyTApJrnw+8h+OGA2mVVxf8C0mObEX2RmmUnf+X8HSVNvfw==",
[121118]="eNrlkTEKwlAUBHdKKyvxAIK9tVew8CZ7BE/iJdJop2BhKYggBmJhbK3sjXxIIMRvbAMW07xh4MEWC6noAHPMFDMqafoe5ilzlTnr01f9ENOP9C+Zh0z2pZ9hJmUb60N7a+nHmEFLf639foz0/07Ytk7T32VymZPMOuIvMhVZxOc/+q1MYCdziPhUJi37JOKT8h5YRfxeJrCRWXZo/zdbi2Qr",
[121119]="eNrlkc+GQnEYhp/3RmZdRJuhP45Z1dC6okW06I8oXtoWs5lIFxCtu4Xu7+Twixwfo91hFs/mfTx8fPkP5BXgjnXDOmOdsMq+2I5Ye6x14K9Yv1g7rE3gl1hzrAnWKPAXrAPWFmsW+B7WF1aWiPritgXWMPDZSxv1/50V1jdWK1H2DayCNlY/8NPUfybKvov1JOrHWB2seuLdvtiaWDWsjz/6QYX+/wCm9U9W",
[121629]="eNrVkrEKQXEYxb/favEARpPFZGJTkoySYlBY9XsE76PkIZQXMFmUZ/AAV7coXf/JXa7hN53O6eucL9tFZBVggoyQHtJCivo15BxyDDnEt75E8owh0k34HyG3kFPIPuHfIitk+rqjqNeQPOMeckn432yQWcLfQOofVKHzf2KNjJEO0vyxv/xHBki7RP9zpF9yv0WF9n8CYqdkWA==",
[121630]="eNrl0jEOQUEAhOH5C4mKwjHcQIUTKMQNtOYIElR6Ep1CIXEBESdQ0XAPnerJJq/YbFYUChLFX32ZboqxVPxAO5mNzEpmLpN6TyYu9bXMQmYmM814V6YVlfpSJi71oUxfpi3TzPhWJi71icxIZiDTyfi/V8E8ZO5lqZ9kQsfyJ6nXMOL1/ioTOsvsM15/s7/JhC4yh4w3MNUP9t/qCT2ZXng=",
[121631]="eNrl0KsKAlEAhOF/HkO8BC3eMAmW3aRFEGzaDCaLDOsLiOAb+MArCy4sh6PhFAXDl36mTHmF8gdMsSpDrB5W2GdYlRxrG+kDrFon0ltYow/7Plat+2Y/xsoS922sOdYSax3p/26PtcJaYE0i/+ywmsJurMOrbSK9wGoK+x3rgnXCOibsH1g3rHPi/lue4U1Myw==",
[122142]="eNrtki0KAlEYRd8JdtEgFgWDGMQigowGQbPiCkSwnyXMXo1uYmTghUHflGeZYDjlu9zL91eVIVQd4IyckAKZI596v64FeQV5hm/9hlyQHbJo8fcapHq4x4x9Qh8iTdrmeCDXH/x/0qyQCTJCBhn728a/mCLjDP8RWceMWYa//okDskGWHbr/G3X1WLk=",
[122143]="eNrl0aENwgAQheH3a6gq9Qj2eyOwQJswQlMBC7AEktQgsVgWaA3iciFpmiKaID7155m74SgNK9DKdEHutUwT5H6WuQRz91eZaO7+JRPlfprY/7sSE+VeYN4yvczty/12mApz+Mh9j9lgHgv2W8zzB/v7iv4/ArgQWMQ=",
[122655]="eNrtkrEKglAUQD17cySBFLhE4NKk1tASSB8g1Op+PqFPN9weaoG2ODSc6XAu9/Je+4qidgHckCtSIiek79dISN8/kQdyR84jfo+EfNqjQaoRnyIh326pf+z/DEmQTcDUPkN2SIysZvTdv+xmHJDtjP6CFEiOHBf0/m9CBVhz",
[119078]="eNrlkiEKgEAABG/gmmY1WgQtNsFm9QOCwSgY9wm+26TlwiEavKQYJi1Tht1XY/YP0CNaRIXIEU/9DlE7NwnwG0SBSBFRgF8iMkSMsAH+X5gR40Uf67rZm34LYnJuiD8gfM67Qfhc/dPnvG9G+Lyl9wEwEliV",
[119079]="eNrNkTELQWEARe/JZrHa/TCLsrllUAa9RVJKdov/YzMYpQxYXhjohZ7UG5QvheUb7nQ63bo3T6Q8gtxk7jIVTA3zrZ/JnGRKmOoP/lXmIHOWKf/hb2UuevdbmNfEsHlMyYr9NjLLwH4zmanMWGYY4M/f0g/+RKYv05VpB/hRZiezklkE+EimJ2OZRoDvZdZF9zzABzIdmaZMXfH8/wBJHWn9",
[119073]="eNr7X8/A8H8Uj+JRTBHOYsxnHIruBgA4V31t",
[119077]="eNr7X8/A8H8Uj+JRTFOczZjPmMqYzxjDmM8YwpjPOFjcBQAiO3tc",
[119585]="eNrl0DsKgDAURNHctaQSxA+KiKWIhRZ2bmOW4NIVwUAIabRRsDjNG27z9s2Y/QNaRInoEBPibr8gnP5BvyKc6YX+72aEM0b+d94GRIFIInuDqDzhXiNO9hLuOSLzhLv12lifInx3+7cc1K9WXA==",
[119586]="eNrtkTEKg0AABHdS5l4gwSqI8VGpLfcJvtTeByhaBC6EFLnIQbpgccVUwzS7cZBi4W/0mDumbPFNh7lhWkyT2SdgTphN5pLxNeaasPfCLHqT66sf/aubZGaZkPEPmTMf9n5M+lXH+f8JKxlnfw==",
[119587]="eNrt0C0KgFAUROF7ukGL2WyzWFyQCMIswXVr8Jku+PMQ0WB54UvDKRMms5B81iPcgDjvI2IvfXbUIVwT+adEFIgckUX2p30wsdh1bxHurl9NzJG+RrjqRf+XDUqOYSQ=",
[119588]="eNrlkLEKg0AQBR3wMySpBLGxDZJACgMBBWMXSKGFhd37hHy64WALOQ6vDVhMc3OzC7t+k2Q9AAtiRkyIDyL2138bED2iQzwD3s0eEW/EK+Bd2yDuiDqy/4jkiAdiMEL3uyIKw/fnSO9cudNn1rdGqC92+hRRIW6G7y+I04Z/ufsPgrRWzQ==",
[119589]="eNrN0KENwlAYReH/7FFUE5I6AsGgSJDoznFGYBQWQDYEHBLBFmhmKAbxUmhCHoInjrr5zO13EX0BtcgWWSNLZLgvkLThvkFWyAyZZvg50iA1Msnw9cuO+QpJK+HzknqE3ENuIdd4/+cY0iWN+UvI+cPefelPIYcf/T7D/6snKF5Y1w==",
[119590]="eNr7X8/A8H8Q4A8M+Yww/I0hnxFdHiR2lyGf8Q4UDzf9Ix2vZshnRMbo8scZ8hmfMOQz/mbIZ+RgxJSfyZDPCMJzoXgg9M+hQP9AYQAXdGyD",
[119591]="eNr7X8/A8H8Q4CMM+YwvGfIZhRjzGfUY8xnR5UFiGoz5jByM+YxvGDDlbzBA5PQZ8xntsOh3YsxnBGE1xnxGFizy7wnod0PSL49FXooxn1GKCP26UDwYwnwwYT1ovOvhiH9Y/MHwYNPPx5jPCML8jPmMgmToHygMAKDESjU=",
[119584]="eNr7X8/A8H8Uj+JRjBenM+YzgnAyYz5jLGM+I6n6/aH6YsnUTysMAOTWeJw=",
[120096]="eNrlzLEJg1AUheH7lxrUxhTCg0zgEJnojOCCFkIGSBm3MARucXlooY1Ciq/6OWcZzJYLeCKivN8RyT1Weo+I8t4iGkS9sU/hP23sa9ce3N9csdL/XYWI8v4x8TYxu737ycTPy+3djyaivHeI0hUH9mf5AtqYTJk=",
[120097]="eNrN0SEKAlEUheHz70DMJpO7O0tQMIugiMkJglVwDQYVBG0yXbCbDMLIwAw8Hg9B0wtf+jnl3mooVRkYYGp9TAcTd2FCv+5vMpdA3HuYWhfzTvSrzCkQ95fMU+YhUyb6UeYQyOHmObnL7GXWMvPEfWYyrSLRzzI7maXM9I/9VmbVbFP7iUwrtd/ILL7sRzLjphUZ/f8DD9JdfA==",
[120098]="eNrlkTEKwlAUBGevai1sa5deISgoChILBUVJIYjYeQMrDxT54G/kGUSbgMVUwzS7TQFNB7hjJW5YZ6xXf8BKHLGugb9gJU5Ym5Y+sQv8FmuFtcSavfGZdeArrOmTSeBHWIkx1iLw/07+Zo9VBfuUWGXLfjVW/UE/xJr/0BdYgy/63PWxeh36/wHhq2JM",
[120099]="eNrlkLEKg0AQRGf+Nzi1VVrTiQjqP6ROJbH1H+zvN5SFFeQ4C68xkOI183gs7PoE1h/gC/ENcYEYIMY++B5OfA3R+ECcE962CeLoxP4F0aggDglvW+s36oTvfc/t/x37XwOxgPhI/KeEeCT2nfdyrvb7ntsXhzanv4sN5R1fLA==",
[120100]="eNrl0aENwlAUheH/bMICaGbAoesbijqqFhwD1FSREEyDILBCF+hKJYiXvDSvNEU1QXzqzzH39ifoF6DFig17hxWbu39ixebuG6wb1hXr8sP+hfXxwKoT/d8VWCXWceQ+U/fbYWVYOVb1ZX8f2W+xgn2in7GCQ6JvsGLDvsYKVgv6/xvnNV9V",
[120101]="eNr7X8/A8H8Q4OUM+YyrkTC6/FKGfMZ5UIxNfiKR+kH0FjL1H4Tik2Tov8mQzyjMiMCDIcwHE+5myGdcz5DPqM6Yz5hJRvjsZchn5GKE6CfHfvMRGicAhfdqXw==",
[120102]="eNrt0KENwlAUheHz265R3R0Q3ecs0ASYAIFswhCkrq62DlTDMA91E0LvAE9UfOrPMaecpVKBWSZMMv/9LnOTGWQuSf/IhC3pq8wi85C5Jr3DhJZ9f8u8ZJ4yY7LvMeGU7BvMrxo+Pxy+2lpsRQ==",
[120103]="eNrt0TEKg1AURNG5q5HUWYlVljFLcFfJEgRThIA2FmkCglhbKwEF+X4QYmNhcarLvOYNmTQcQCnTLYT9I9PI9DKw7g+ZciHslcxPLfON9LvMU+Y9CftLZlZEer6xb2VmVaSftt0wyeTfG3v3l537FHPlOP8fAcdRbqo=",
[120608]="eNrlkTEKwkAUBd/cwNbD5QyvTGkpmkYEJSlFULDRSvAOghaW1iLkEJFAirAsC1oFLKaaN83/zURqBsAYU8vcZW4yod/LtOxklhE/wrwT/Vmm5SSzjnhhnjKPjm/7V6/9pf93rjJ9Ql/JVIm7XWSOMtuO0BcyRaI/yGxkVjKzyC6XyRN9KbOQmctMI7tMJhvg3z+XSmcv",
[120609]="eNrt0DEOQFAQhOGZS7oFEyEqoXQBhUYU3PNpvNjINk/jFYqvmvxbbBiBkIEaYguxuzz3CeICcYd4OHvsozd9Y6T2JcTK8PoZ4gpxc/bfrXD+M0C0Um9+3fcQrVx+fQKHGWM4",
[120610]="eNrl0TEKgDAQRNHZE88R7Gy0URRERBEiiuAZI0KEJZg0FgYsXrPDr9ZmgE2AAWUDZXf8fQSlUlLrp5f93+WglIq/3/cisNegDIq/N67rQDEPew/KooT+N4NyRPrV8ferayP9V06Pk2GB",
[120611]="eNrNkS0KAlEYRc/dkMViEfEHwWK2m0w3uACX4QYsBkUQB8EgYnABIribEeEJw+MxA6YXTjrfKfcrV1BmwBzrxwwr9lOsCVYfq5Pwi4Z+jDXC6mG1E37Z0A+wvnSxWn/0Q6wqOWyeE2usLdYhEPsC6xy4J/wG64hVBOr6Z8LvsE6Vm7r+lfB7rBvWIxD7S2ivWO+M/v8B2JRb2g==",
[120612]="eNr7X8/A8H8I4OcM+YzCjPmMWoz5jOTqp9R+fPIcDPmMGkiY2vYPd/yaIZ8RhskJqy8M+YwgzMOYzyhDRhr5xZDP+JcBkr5syNAP0svHmM9owpjP6Mk4dOIaALCWcKM=",
[121120]="eNrl0DEKgEAQQ9HkLhYigp21INhZKop4hhzBo68ILgwLFqOFgsWrwmdgwgaED1gh9hAriBnEdG8gWunenm3k7Y+bBcT65O1ziOWD/u9GiNFw8b/OSPcJouXtZ4iWt18gRnf6t+znUkuk",
[121121]="eNr7X8/A8H8IYHWGfEYtKCZHvyhDPqMMFNPCfUYM+YwaDPmM4gz5jIw0smM4YxuGfEZthnxGqdGwoysGAODAchU=",
[121122]="eNrl0aENAgEQBdE/jhIwlEBCCTSDnusAQwsUgDiNQBESgqEEUDRAAegjlyCPkKyCIJ76GbPbLZPuS2wi7cvQto7sIpeB/ZNtpLeP3Ar9IdI7R+6F/hg5Ra6RR6H/e5ERMkFmFO4XGSNTZP6mX0SayKr4n+YH//oES91wDg==",
[121123]="eNrlzjEKwkAURdF/C9OmsDBNwCKojUWarCGQFcQs4i0haxarVCMDMyCTacRGmOJU9z/4bjVzf+BpInqZSPtmokIcESf23fmNiUO4SbvfnBFDkPYa4TWILtMviDtiDNLeIqJrpt8QfdhOuf8LNyOWD9/uHz/uS/UGwGVhJQ==",
[121124]="eNr7X8/A8H8Q4CjGfMYExnzGgdI/ikfxSMQAfzd7UA==",
[121632]="eNrlkjEKg1AQRGdulcYiNgGxMSSQoII3mBNIgkeQBIQc1vDhfxBZtxYsXjXzWBh2fgHzDmggBmqID4jr/AoxcTHyOrqByvG37j8hBm4QC6PXQuwcv4RYRvds9EaIH8c/OlXcLoN4Mnb6Qvw5+yU/j1j+5Ph3iEvW+Rvi4Pg9xCVb/5XYy+5/3KRadg==",
[121633]="eNr7X8/A8H8Uj+JRTBG2ZMhntGHIZ3SC4qHibgBqLHrR",
[121634]="eNr7X8/A8H8Uj+JBgP8w5DOKM+YzujPmM5KjX4Qxn1GdAv1ajPmMxoz5jG5k6rdhzGcEYQ8y9Q8EBgDrbXSy",
[122144]="eNrl0KEKwnAUhfHvvJR5atq0iYhl2bQTfACbIIhYfAJB7LY9gW81GfzDGFdYc2D4yv1xym0O0IygJ1a3vldYJVaOtQ586L7A2v5wv/iy//cuWGesY/pT38t032BNA79jXQfuJ4HXWA+sE9Yu8BVW2xIrC/yN9cK6Ye0Dn2O1zVJj+fsHLQ5Yig==",
[122145]="eNrlzbEKQWEAxfH/eSuLxSBlUTJgUTapEwbKoPAC3sITWD2CN2CyWZXtSn3D7eu7cifK8Jv+nU62guwHdLDaWPUg7k2sAdYCa5fofawuVgOrlugtrCHWBGvzZv/6qSR6D2uKtfpgXy3oM6w11jbR/90IKy/ue6wT1jmI+xgrL+4HrAvWLSi7P2Jdse5Yj4L9HGsZlN1/yxOuolsV",
[122146]="eNr7X8/A8H8QYFvGfEYHKPZgzGekRL8zGfoNGfMZzaDYngz9coz5jGqM+Yw6ZOof6fg2Qz7jeYZ8xl1QjC4PEjvFkM8IUvcci/wbhnzGhwz5jKfx6D8KxTewyP9gyGd8y5DPeIshn3E/Hv0g8z9QoB9k90+GwZM+AG3yaWg=",
[122147]="eNr7X8/A8H8Uj+IBxumM+YyU6A+jUL8vhfqHKgYAH8N78w==",
[122656]="eNrlkbEKQWEARs/3JgaDxCbFxmbxBCZl/mYLq1EYbB5ApJQXUFKMBqM3uZarbn//JZsynOl0lu9LxpD8ABesA9YSa4oV+hZWlm/7BlaW0J+wdliLnL6GVcWqpIT+irXFmn3oC1jFiP93XvutU0JfwipjNbHab/7P6+tYHawe1iDib1hnrH1O3027EdYk4h9Yd6wj1ibi+1hDrDnW6of+fwKsyln7",
[122657]="eNrN0iEKQkEUheH/rPgswSyYLCKioPi6FrE8bDajweIGDC7hycCEy0WQZ5rwpZ9T7swwgaEBU6xZkHuP9cR6Yb2/9F/7I9YN6471+GO/wzpj9dXY/QYrauHmLdljRbnPsRZB7hesKPcl1gprXeV+xYpyL9stVleN3Zf/VxywTg29/wf7YmUA",
[122658]="eNrlkSsKglEYROcUN+BCZwlux6wYfGBQQY0WxSz4AMFs+uWDa7ncv1yDguGkwykzTU9qfoCHzFnmILOXyf1TpoPpJnJ/lNnJLCr7icxIZlzZ9z/s/53YbyATP0wL+51kgpvMveCHMvP0/7LgLzLBtaWP31Yy60Rb/yb3s9RvZLYV/bd4ATHiZjQ=",
[122659]="eNr7X8/A8H8UU4yNGPMZR8OBfKxCYfhRql+EMZ8RhMUZ8xkNyTDrC0M+43eGfEY2xnxGgyGUFgDnUXWK",
[119080]="eNrl0CEKAlEUheHzR/uswOTuzhLsKgwYNBhMLkUQURA0iEXEZDDbHBHfg2G8xTZg+NLPueFWfalqgR6mwHSSZr/LZDd9927aPfTR7FeZ7Bz0Im1PMvugH2WyqD9lLjJLmXXQtzJvG5lV0P/dRGYmM5dZBP85yNQ1eykzlpmmG7/uhzIjmTLd+HU/kMnKoO9k6try9xdKamdL",
[119081]="eNrlkSELwlAURs/X/J+C0S9aREHTgmges1j8FQarCBabsGRZsNkngxce+mS4NDCccg+HC/fWc6h7wAkr5t1XWM9mjjXQp99jxfza51gbrAxr2aHfRv2kQ//v7LDWWAusceJ+R6wLVon1SPimX4XbDxP+gHXGumLdv/RZ2D1q6cuEL7CmgVlLf6M//38BD+pllQ==",
[119082]="eNrVkCsOgDAQBTsWDAqDIIQQJCiug4LwEe8IHL3YpgFBERQxZvfNZvPsYYyNgBLRIjrEgPD308XM9ytEjWgusjNiRew3dwqEy9P/c4RLDJ3+iRSRIXrEGNCf6y8v/S3AT176X3EC89temA==",
[119592]="eNrlkKEKAlEUBc8k/8GkKAbRYhSDwR8R7KfZxGAVBJv/odW21T8xGkwrC09YHs9dtCgYJg1zLtx8LeU/wFJmITMMxH4qUyb2q9DPZFoJP5EpE/ujzFZmLjP+oL/KnGU2YePd/t9pYu4yJ5ld4j8DmYKOTDfhn30ms6/pRxX9ReaQ8H2ZgvaLvoG51fS9ivvf4gGV9VF9",
[119593]="eNrl0bEKQXEYhvHnnVyTGzBYDIpBUQYmvTajTSnZWE2ok0UZTAabRSmDG3AX6kid6fTn1JlOGd7p6bd8XzyGuACbYs2xllgrrHTfYR2xzliXQM/yW6wIa491yuk/23zxE6wZ1iKn//d1sPpYQ6xR4D5rrCvWLVm6N7DaWD2sQYZ/BnoVq47Vwur+8HesV6CXsSpYNaxmoB8S/8AqqTj/fwOtWmBj",
[119594]="eNrl0jEOQFAQRdF/16JiCyhFoRLRiYJCJOQtwdK/zBIMBVHc8kzxMvEIIb6gHNEgOsSMuOrNLYjdYa3R6Z7yf29ArDc2rBA9YkJsjjsZokDUiNbhE4SVIsoP/cIJUZxs2w==",
[120104]="eNrlkiEKAlEURe9JVhFBF+IWBJnoRm61uQazTczabBaL6AZcgMENTLCNDPwPMrxhwDRgOOlwyn2vWktVDwBTytxkNjJNP5fJLAP/lHnIHGRWP/Qnmb3MLtH0C5lM1F9lMufAFzKZqP933jIvmbvMpWO/IvBd/Uzmm7a+vt0x8EOZicw00dbX/7cN/EBmJDNO9GX3D+flWeU=",
[120105]="eNr7X8/A8H8Q4CiGfEYQdmHIZ4xlyGdElz/NkM8Iwm8Y8hnZGTHlSdFPjv0nCegPZchnDIXqj8SiZh8B/SMdyzHkM8KwEZYwmsOQz3iGIZ/xPI7wE2PIZ+RiyGcUZ8hnVCVDvwBDPiMnVL8SGfp5kPRrYlEzgSGfcccgjHsAz5hbww==",
[120106]="eNr7X8/A8H8QYD3GfEZkjC6fzpjPiIxJNd+FMZ8RhmPJ0G/AmM8IwtZk6g9hzGdExoMhzIcqDqUw/CjV70iGfjnGfEYpxnxGfsZ8Rt5BFP8AlLhotQ==",
[120108]="eNr7X8/A8H8UMyQy5jNSoj+MMZ8RhBMoNGek4mDGfEZkjC5vypjPCMIejPmM2OLKiTGfERnjk4/GIq/GmM8Iw+pY5H0Z8xlhGJt+JcZ8RmUoxqY/kDGfERkPlnAHAHmTYd8=",
[120107]="eNr7X8/A8H8Uj+IBxl6M+Yz+SBhd3pAxn9ESCVNbvwdjPqMvEiZVvxVjPqM1EiZV/0BhAPKMZGg=",
[120616]="eNr7X8/A8H+QYFPGfMYOhnzGGIZ8RnQ5NYZ8RmSMz5xyLPJmJOjvwCJvx5DPqM+Qz6hJhP6NWORdGfIZ7RnyGW0Z8hktCOgfxZj4DUM+40OGfMbrDPmMB8kIv4HW/48hn/EnFF8fRPEPACAMabE=",
[120617]="eNrl0qEKhFAUhOGZZLPZxeY7mRbM8wguWiwGsQi6CL7jNuEu4l2U5cLiTYLhS8N/0jEFYC7gbcQAmxTi2X459IlHH0GMsN8428cQV6Fnf3cVxOfB7/6AuMohlo69g9hCbCDWjj2D+OXqXxAHq/foZ4iTNf7piwv9xwdz+l/g",
[120618]="eNrNkCEKAlEURe9BjKLZ5A5mES7oLsFFCXYFk82kOCYxqEEsThz58D/I+BW0OOGUdzjwuPVEqlvAWiZwkBlgmn6ICfQwJ7361AcuGV/JVNGVGb+S2ctcI01/jl35oT/KdDDdzP/hdpPZRNqweZt43q+f2a/AJEYZv5DZyuhNP8YkioyfycxldjJ3fd9PZQLLH/t/8QD3P15O",
[120619]="eNrl0SEKAlEUheHzG0ziEtziWYK7MJstJpNOMCmYRDQ5oqAYhUEwjuU9kMfTMGnA8KWfU+6th1LdAk+Z6CWT9i6mjxkEaS9lPqX9LNP7sZ/KrGS2Qdp3MieZKmiyP8pcZR6Z/u/uMnuZscwoc5+5zFJmI3PL9LifBGmfySxkCplDg/1aJsr9rwz//7a/yEQd2vP/Nwe7aMQ=",
[120620]="eNrN0SEKw0AURdF/qaqLqusWQqEQFVNqYrOFmMq3hO63ohQyITIlEPH5dGpiRhxGXN6ImeVpthQgmXiZOCBOiNh7hBf7x8TbxGji+KN3CC/22cQqbWfsLcLL7aftjtgvCK+ENy/J+u9nJ/Ya4cVeIa7Ov/09s2+c3P6GGHbuHwX9/xfXX1FH",
[120621]="eNr7X8/A8H8Q4BTGfEYQJld/EGM+YzwF+oMZ8xljKNAfypjPGMGYz5hDgRkjGYcz5jOCcDaZ4RdOYfwlUWA3CGcM0XgHAGWgcnU=",
[121129]="eNr7X8/A8H8Q4L0M+YzIGF0+kSGf0Zkhn1GPIZ9RGov8bYZ8RmSMLp/DkM/oypDPaA/F6PKPGfIZnyBhdPkShnzGXCSMLv+MIZ/xJRJGl68joH8UI7A/I2b4fGfIZ/zMkM94nSGfcT4Z4febIZ/xGzRulw9B/bTCAKija7I=",
[121130]="eNr7X8/A8H8Q4CiGfMZmKJ7KkM+ILv+aIZ8RGaPLGzDkM4Yy5DOmMuQz9mCRv8KQz4iM0eV//M9nlMej/xBDPuNphnzG81CMTb80Hv0rGfIZDzDkMx6F4sEQ5oMJezJAwu/d/3zGF/8xw4eVIZ8RGWPTr4RH//3/+YzImFb6X//PZ3xChv6BwgC5lHiJ",
[121131]="eNr7X8/A8H8Q4H0M+YzTGfIZuxjyGacw5DOiyz9kyGeEYSZGTHmY/iyGfMYJWPTfRdL/lwG3/iiGfMZKLPJXkPQ/xCK/miGfsZ8hn9EXagap+kc6/vg/n1GEIZ9RhiGfUQtL+MxgyGdExsNN/0BhAMzsYzM=",
[121132]="eNr7X8/A8H8QYD7GfEYRKJZjzGckVT8nYz4jCCsz5jN6k6H/F0M+Iwi7MOYzplCoP50M/SMd72XIZ/xOQfiB9H9myGc0YcxnDCND/x6GfMYHDJD0Y0uG/t0M+Yz3KdA/UBgA1r1rAg==",
[121641]="eNr7X8/A8H8IYB7GfMYbDPmM6xnyGVcy5DOSqp+fMZ/x9gDrv8+Qz3iLTP0jHXsw5jOCsDljPuMPMsJvoPU7M+YzOlOgn1YYAITibIM=",
[121642]="eNrN0CEOg0AUhOGdq3KBUWguwCFQlBCCWQFBoFBVFdVNqjnEkCa7CSFvRRUrPjX5zahyThn4iniLeIpYRVz3RUQXjMb+6zcRk4jB2FsRdZDqZxEPEY2x9yKiVO9Da/U+7FEOn2dFxC7iJeJj/FM44uzfvnTEWXb9TQ7hg5ZZ",
[121643]="eNrlkSEKAmEYBd80DyAms1sFk4cxmt8RvIhnMC6YxLw3WNCkBzBoUfgMu8Lys2z404Jh0jDlvdhJMQIuYe5h3mGWMqnfy3RJ/TXMMwzK6x9hZjLzzP4VZqGGnP7f+e1XyKx69jnIHDuk/hPNd2uZTUY/kZkO9KXMSebcMtRve3wlU8vcWsay+xeo7GWj",
[121644]="eNr7X8/A8H8Q4BUM+YxnGPIZrzLkMz5lyGckV/91KB5q+kc63sGQz4iM0eWlGfGHKSH9HgT070HSewuL/gAC+q8x5DPuZ8hnPMCQz/iJDP0DhQHp+HHA",
[122153]="eNrl0SEKQlEURdGzq0G7GByKE5IdHIAzsDmCX21icQwGu6BFELvF4pOfFT68IIphp8sq55Z5Un6gMdI2RK6RT/sR0jZAjhW+j/SQEjlU+H/vEblHzpFtxX63yCWyizQdfsrr/RTZR9aRRYefvPGbyCqyjMy+6P9PQS9sww==",
[122154]="eNr7X8/A8H8QYCOGfEYGhnzGff/zGU/9z2dElw9hyGdExvj0b8eiX5chnxEZ49O/CIt+RoZ8RhBmY8hn5CCgfz4W/ff+5zOC8Lv/+YzfsciPdOzBkM/ojoTR5aUZ8hlBmJcBe/j5ENAvz5DPCMLiDPmM7Azk65eign4+hsET/wA0L1qV",
[122155]="eNrNkbEJAkEQRf9XOMTUQLlAOxBsQQ1twAKMP1fBNXlgCwZiYOIZjRzswrLMRiYbPBh4PBhmrAesAhYQzcQDxNs0Z/4O8QnxEyj1O4jnP/rRxHmhf0B8QXw7fgztxMzxQ+gjNdy8Jr4mpuR+A7GFeIF4de7XQEzx+sje8SuIKaV+C/Ho+DbsF8n9EuIa4gliV9H/f+1vY2c=",
[122156]="eNrl0CEOwlAQRdF3d8NKcHWwjrcD8N0EjpDgiyRdAg5DuocGX8wXk8+kSTGQIK6Zl2Nm2kvTDzTKPGR6madMvTe835b4DSY254fEbzGxer/L3IrvP/D/Xitzlulkrsn/1pjYnL8kfoWJZf5UfJd4MLF638kcZI6lpf5bvQAyGFvR",
[122157]="eNr7X8/A8H8Y4EDGfMZMxnxGcvW7M+YzxlGg344xnzGcMZ8xjwIzRjJOZ8xnRMZDTX8sYz4jDGcOoTQAAO/bbps=",
[122665]="eNrN0CEKAlEUheHzr0OYRVis7kbbiYrFIja1GRSDoKDJ7g4EsdpEMJmNhpGBFx6PN+YJX7k/p9xyLJUN0sV8ZdL7VmYaqdsXmE+mL2RmkbT3MW1Mq2ZfbVYy6yDtHUzxZ7+U2cnsgyb9vAneMleZjUwv85+TTCztB5m5jGVGmX6RiaV9IDOROcqcM/0uE0v7MGxvMs9Mf8lUHkFT/v4DAx1kNA==",
[122666]="eNrlkSEKAmEYBefdw+ZFDCbPIQqKPMuCzaBgsGtTFlGThzB5HI+wIhh+lu9XwbJgmDTMK6+aQ9UAxlijF0Osum9hdbH6WJPAL7GKN337Q7/BWmPNMn0n6YvAl1jPjRXWNNP3sAZYi8D/O0esfULdb7F2Cb/0ZeBPX/YHrFvgL1jnhFx/xbo36P8H6odb+Q==",
[122667]="eNrl0KEKwmAYheHzlpVlq3c4Tl/QoLdgWPMCHKztDgY270BsZsE8GfyDn58ZtjRYeMp3eMvXH6V+BQqZwTlI91LmKtPJPCf2g8xJpgrS/SJzk3n86RuZUb2gv8vE5vZb95aJpXsr85L5BnP78b6032Fi6Z5jBhnmM9HvMbG1/P0H6TxkFg==",
[122668]="eNr7X8/A8H8Q4JcM+YzIGF3+HUM+ozBjPqMtYz6jGyOmPCH93wnoZ2TMZ0TG6PLMjPj16zHmMyJjdHllqF47HPpHOgaFWQQF4SJFoX5VCvVbUah/oDAAU8hilw==",
[122669]="eNr7X8/A8H8Q4BjGfMY0xnxGcvWnU6B3FI/ikYoB71x8Eg==",
[124147]="eNrlkiEKgEAURN+pNYlGwWDxBGIw6DYx2CyiZY60onnlB8ui4bV582H4PgcfES1iQJ/zjxedf6JGNIGtesSM2I0dS0QVyHSIEbEafoYoHu5fLIafINJAxqGbCbFF9Asn8Sp8zg==",
[124659]="eNrlkTEKg0AURN9ZA6YQLSyCkkY8ggoJitjYWKUQBG8xR1JY0ijrNtsIFq/5w5ti/prDeiFiZDjeF7TjzA8QkYf/8PSfiNCSj4gfYkLMDv/uJIjMsk+NaBA9YnDs90K8PfzU4X8R7b/jzO8QhSUvERUyPZ8L/X8DGmJ5VA==",
[124663]="eNr7X8/A8H+I4SMM54acm0fxKB6MGADutX4k",
[125171]="eNr7X8/A8H8Uj+JBjtcynAfj+QznGVYwnB9Q/cvJ0N/PcJ5hOsN5hrkM5xkWk6GfVhgAE5J9aA==",
[125683]="eNrlkjkOgDAQA+fnfAIkINyHeI6fFEQUGhSSggIkimls2cWubQb2Q1TIcdVLRIHIEVPAP+mQ46q3iNp3xPIjcoT0HmES+cNbAv6hzb4jlv87qfsNiObB/VP5PvL/cwOx/IZYA77x2zE3+36LHULoexE=",
[125684]="eNr7X8/A8H8Uj+IBxmcZzlOk/wiF+ncwnGc4ToEZmxnOM+xjOM9wkkJ30BsDACqkfpE=",
[126195]="eNrtzrEJgDAUANHb3DlMIwiCwUIEC0FIZX8jRXADP1gIKa58cLWD+oN2ZEFGpMfX/kBWZEJSwBd8HjIyBPyFnMiGzAHfan3RDSzeffI=",
[126196]="eNrt0LEJhVAAQ9GzuZUL6AbfWlCshA82WghCRlJwhFeIhcUtb0hyVpwvoBez2KTI78Qg/mIvyGjFT4xiKfBr0cjdYyrc8MEh1u+/x7gAhwt+Fg==",
[126709]="eNrtzTEKwCAQBdG5uYdKp0VCELEw/CNtsPAAKoQUW7xyGAtgP5AQB+JGPGi6r4gLERF5oe/6tyDOxX5om71zX3kBhP9+/Q==",
[124152]="eNrV0D0KwlAQReGz7rxC8iBYCMb8KCIIQspsw/puKYFBJC9MkwTEFF91mCnucIBhB94osfS+Q1/9xvvXivsnSuxh81+6IHNGnJx9jigx7w0yFaJ0ekQUE/N+Q+aKqJ0eEDmyP9HpD2TuiNbpGTLh4192HwHyKHj6",
[124153]="eNrlkjEKwkAUBefcEuIqqSyUxGDSWOwZvMe7UiTLZ2HjrmkCCimmGgYe/D8dYfoDXiji0YdvUeSe8Wv9AyUsvbfOF/oRJWzd7x2HOCHOiKZwv8F4Zny90s8/0xu5vkJhQ6m/ITr7vVx/QGGDM5b+grh+6X/FG1r5d0I=",
[124154]="eNr7X8/A8H8Q4K0M51Awqfo3MZxDwaTqX8dwDgWTqn81wzkUPBjCdDjiMwznGDZQGL4rKdS/aBjFLwC64n4X",
[124159]="eNr7X8/A8H8U0xyfZjg/Gg6jeNBhAPVjfiw=",
[124155]="eNr7X8/A8H8Uj+IBxkcYzqFgUvXvYTjHsJ/hHMNhKEaXP0vAzF0E9J+kUP8JhnMMp8jwF60xABHUf4c=",
[124664]="eNrNkr0Kg0AQBuedk0JskneIkEJIDgn4A8akyGt8r3Q2d6KXU8HqiqmGgWV37QVsAvSIGmEQd/TnM8RpRujfO/0ZLQj9gGg2euOcJ/RfRLvRt857Uth5SvwQHeKJKA7sz/cPxC3ia/cfnrW+QpQRn6MFsf7jZntF/BVN5AndfwTwsnid",
[124665]="eNrlzkEKQEAAheH/hlZsJVYuMRa2OIuVGyibd6VR0tRkShilLL7V36tnDdgPMMgp0aEniAyRI+pAH9CmQ7SBniKnCPQzFXLu7PuH+7+bECOi2cXeL8hzdT8jT+z/b1kBVPJ3DQ==",
[124666]="eNr7X8/A8H8Q4JMM5yjSf5hC/Vso1N9Gof6RjkHh189wjmE6wzmG2VjC8gDDOYbjDOcYTuMI52qGcwztDOcYpuDQf4ThHMMZPHGUyHCOoRzJDejyxwnEryvDOYY0qBntWNSeHKTpAwCTVXvX",
[124667]="eNrtyzsKgDAURNG7c1cliESw8BNRZ0uRQDqfIKRIihSnmcuEDkIFeoRDLAiPXt2nfUPsRh8Qc2qX0eN2Im6jRSNi/Wh/TIgj4980JTxTzn+O",
[125176]="eNr7X8/A8H8Q4DMM58D4JMM5hsMM5zDkNzCcA+M1DOcYpmORR8Yn8egn133bGc4xbKZA/36Gcwx7KNA/ikcxLTAAR+1+lQ==",
[125177]="eNr7X8/A8H8Q4GiGcygYXd6L4RyDG8M5BnMoJtV8A4ZzDDZImFT9RQznGJqRMKn6FzCcY1iChAdDmI9iBD47QuMEAOEAeEI=",
[125178]="eNrtkCEOgDAAxPpzFG9AYXEEwwwYDIKQ9EsjwY6FZIIgJmruruZiA/EHtEiPjEjApD8espy/vGxz/oDMyFbgd8iErMhe4FfgxJv6xXdcZYx90Q==",
[123137]="eNr7X8/A8H8I4HMM5ynSf5rhPMNZCs0A4TMM58GYEjNOUsEdo3gUUwMDAKbKfr0=",
[123138]="eNr7X8/A8H8UU4xPM5wfDYdRPOQwAPjjfiw=",
[124160]="eNrlkasNACAQxbo50xH+vJEgCBbgECSIypp2OBgPkRAZHfvZ6NcLfjL4v7K/rXbhoF9DFEREeGP//tG/CWSzf9o=",
[123167]="eNr7X8/A8H8IYQ/GfEZDxnxGcvX7MOYzWlCgP44xn9GLAv0gnECh/lE8iqmFAaoheLo=",
[123168]="eNr7X8/A8H8Q4G8M+YxvofghQz4juvwlhnxGZIwu/5dC/XyM+Yy/KdAvw5jPyMWYz/iDIZ/xMRb5Rwz5jHegeq9ikR/FCJzKiBk+doz5jD6M+Yy+UEyqmdTSH8KYzxhLhn4vxnzGIMZ8xgTGfMZMxsET/wAWtGlB",
[123169]="eNr7X8/A8H8QYA7GfEZkjC7/hCGf8Q5DPuNVhnzG5wyY8sh6ObHoB4mxMeYzvmPIZ3xLQL80Fv0gMSnGfEZGRsr0s0HxYAjzwYRDGfMZkTGp+lMZ8xmR8WiYEocBTi5eWg==",
[123170]="eNr7X8/A8H8QYFXGfEZPxnzGUMZ8xmjGfEZK9KdRqJ8S94eTqX8Uj+KBwADGznMp",
[123171]="eNrlkqEKAlEQRd9JYrdYFxEtatJi0LhtFcQkWNRguJ/gp27Zb7DuIozwGN4qmBYMJx3OMAxTP0KoO8AEkSF6iDII7y+Im5HqF4gRoo+ofuhXUf9M9AfEm2tiRmH9wPB+jsiNXcsO/8wJMbYfyL7cL0/4V7+M8H6K2EZ4f0ZsPvRD229meH9H7BHrlv6IiOnK3Rv6PE4Z",
[123172]="eNr7X8/A8H8Uj+IBxtaM+YwhUJzFmM9Iqn4TxnxGM8Z8RpcB0u/DmM8Iwt5k6h8oDADD93IK",
[123175]="eNr7X8/A8H8Uj+JRTHMcx5jPONjcBABIU31h",
[123684]="eNr7X8/A8H8Q4BTGfMYsxnxGcvVnMOYz5hChPwmHmmwi9Y/iUTycMABOZ3mQ",
[123686]="eNrtjzEKgDAQBJ2P2VsIiqKBiI2NWLhP8OmRgHZH0olFimludooLV1WFH7AgPGJFpHYzojY2/ulHxGn4eNsQLaJL9AOiMfyOiEyIPtM7wx+IF5f5sVD4ihuns2nn",
[123687]="eNr7X8/A8H8QYDvGfEYQdmDMZ4xlzGckVX8AYz6jM2M+oy9jPmMmGfqDyNQ3ikfxUMYAkdB2qw==",
[123176]="eNrt0aENgEAQRNH5HVLAJSR4MiXQGpYGMAgECsslSA5zDXAIIEF8+XbEpk5KH2iTWWUWmVHmqo83/S4zy0wyQ4E/ZGLe7wv8n9RgqlzpjYAJD/oa0/Ke/5+2eXUv",
[123177]="eNr7X8/A8H8Q4FMM+YynGfIZnzDkM75hyGdEl+dmzGdExujyFxjyGR8y5DO+JFP/f4Z8RlHGfEZFKCZVvy5jPqMdYz6jBxSjy2tB9fFD8WAI81E8igFSmGZ6",
[123178]="eNrt0CEOwkAURdF3QSO6ARQLaFLJWpqwg7cEVkiCwlTQyu6gppmajhkmNE0QiBFHvX/ND3cp/IFB5iXzkHnKpPtbZpKpMA2f+yjTy3TrXbqDOWEumGumP2KiOdMfNvoaE53Z3xff3TBRW/73Mwsw+2W2",
[123179]="eNr7X8/A8H8QYBvGfEYQNmbMZ7RmzGdEl7dnzGf0ZcxnjMMiB8LujPmMboz5jHaM+YxeWNRkMOYzZuDQi6wfZEcSHnX49Acy5jPmkKF3FI/igcIAU4VvAQ==",
[126260]="eNrtyaEKgDAAAFG5H/dzBJMmBTEZjYJossr9xERYGusGF165C3VVhaL4gRu5kB1J39sO5IzSvyErsiBz5vfIiExR+gekQ1qkyfyvPApTghI=",
[126771]="eNr7X8/A8H8UM9xkesVEif5LFOof6XglgfDbyvSKCRmjyy8noH860yumWUgYXX4NAf0FTK+YipEwuvwuAvpjmF4xgXAU0ysm/0GUVgCgnn50",
[126772]="eNrtkjEKwlAMQOvbHAURnFwEOwjiIAhOguDuBQTXHqI36YEEB6/gorwjuHwR2kV+W+jUweEtSV4CSUKeJKEHHJANskOOyG++QO6ReMUJWSILZBupuza4Xy7ICpnW+M8WP0PWyKjG/9NMtb8wkLTD/s7l7d8d/T0yKefPI/6jpecMARki40jtDXn18C8+vR92lg==",
[127283]="eNr7X8/A8H8Q4SNMr5jWML1iQhdvY3rF1M70imk50yumC1jkkfFlLPLTmV4xbWV6xfSMgF5ceAvTK6YHZOoF4XMU6B3FDAx3KAw/SvU/GqbxBwDWJ4EF",
[127284]="eNr7X8/A8H8I4HNMr5huML1iug3FpOp/SYaeUTyKhzsGAGlYf4U=",
[128834]="eNr7X8/A8H8Uj+JRTFN8guk601mm60wXmK4zXWK6zjRY3AUACll+uw==",
[128835]="eNr7X8/A8H8Uj+JRTDV8lek6E7rYPqbrTHuZrjPtYLrOtAWL/EBhAP2Tfp0=",
[141594]="eNr7X8/A8H8U0wUrM2ozCjFqM46GBXasxajNKE9BGIH0yzBqMwpQoB9kvygFcaQOdcNQCXMABo9ueg==",
[142108]="eNrty6ENgDAURdF3WYCEboB9Q7IiEktSTahuSFEMwDcgKo48bZHaDyTMY8a8/adMkblkxsDfZHaZQ2YI/FUmy1SZKfC77gs3ywZxqQ==",
[145189]="eNr7X8/A8H8Uj+JBgm0YwxhBmFR9voxhjPZQveTod6dQvzNjGKMtFDuQoX+gMADd3XFz",
[144178]="eNr7X8/A8H8Q4FyGSoYyhspB4ZZRPIpHCgYAr7R86Q==",
[144689]="eNr7X8/A8H+E4AyGSoYChkqschUMlQyFDJUM2QyVDGlY1KRD5XJx6AdhkH6QHUlY1JQyVMLxSAnvUTz4MQCp4nUw",
[164143]="eNr7X8/A8H8Uj+JBhBcxL2ZGF5vIvJh5EvNi5llY5NDxfCxqJkD1zyGgH2T3PAr0g+yeTYF+emMAhpB5yA==",
[164655]="eNr7X8/A8H+I4CnMi5knQDG5ZkyiUP80CvWD8GQK9Y/iUUwtDABM4Hv3",
[165680]="eNr7X8/A8H8EYH/WMFZkTKp+F9YwVmRMqn4vqD4HKB4JYU4LHMgaxupNYfgFjoY/HAMAYzpxlQ==",
[165681]="eNr7X8/A8H8Uj+IBxs6sYayj4UB/DABr6n01",
[167728]="eNr7X8/A8H8Uj+JRTBFezCHKuZxDlHM9hyjnDg5RTnT5GxyinDA8mNwNAPLXeeE=",
[167730]="eNr7X8/A8H8Uj+JRTBX8lkOU8x2HKOdQcS8AHX59Ow==",
[167731]="eNr7X8/A8H8Uj+JRTBF+wSHK+ZZDlPMLhyjnHw5RTnR5Pk5RTgFOUU4hTky5gcQAWZB4oA==",
[168239]="eNr7X8/A8H8Uj+Ihgvk5RTi5OEU4ydXPySnCyUaBfgaQXg7y9f/mEOH8SoF+amMAvX12ZA==",
[168751]="eNrl0q0KgEAQBOCLM33e19czCyIYFBH/ggqHWE+EC1bXohgmfizMbEicCx/ICnGA2MTc9R7iCLGGWBr8DnGG2D7wC8TO6P+e7WF//rJfYfDn7QliBTEz+D7+Xg4xfdH+B8USb4E=",
[169263]="eNrV0LEKQFAAhWFM5y/jeV+PaDIZLCZJKJu6Ul7AdQvDP37DOaHKsvCDNplRppOpZe76HLPK9DJNhD/bZQaZNtKXmOXa8IfPv1iBmR78l8LPL/rUHX5+bww=",
[169775]="eNr7X8/A8H8I4Y8cIpyvOUQ4ydHLzynC+ZZDhPMZhfrJtf87hwgnCH8hU/8oHsXUxgBPLnfG",
[170287]="eNr7X8/A8H8Uj+IRhAU5RThHwwGCAVeyfMk=",
[170799]="eNr7X8/A8H8Uj+IhgAU5RTi5OEU4mTlFOMnRz88pwskxhPXTAgMA+O1uXA==",
[171311]="eNrl0TEKwkAUhOFNlflJJ3Pf3CqFSI6QRlJZWAUxjQREC4tNJWzrqyIppvwYmMltSvlP0mAS5inzqz1gasxH5hHwZfct4CvMS+Yucwn4vWeWucoMMl1gv0VmkjnLHAP++90ocwr4d+H7Df2/AvE8aYY=",
[171823]="eNr7X8/A8H8I4O8cIpwvOUQ4b3CIcJ7gEOEkR/9zqP5TFOo/PQD6Rzr+wiHCycZJfrh9o1D/Dwr1/6ZQP60wAO67b7M=",
[168240]="eNrtyzEKwkAABdFFEP6AnfvP6ym1iIUhRogEUbHQIpA02uiK4BaxsJhqeP0ihP4HWsoUMhuZSub572Qe7RN/JbOWKWW2id/KHGTOMrfELz74q0wnM8HA66/v9p2fYmaYecL+C+GoSKtIpUijSI4/ZfpLhq+/9GM1AIaEZOs=",
[168752]="eNrl0CsKgFAUhOEbZ/rs1zUZDRYRwSAWuQiCwWL1sYBrcQOeExQMf/wmTMpCSB9ohrhAXCGeED3+cPrd6TeD/3sDxAhxhDgZ/mshdhD7e+epLyFWEBujzyEWEGujf6sLUaVuCQ==",
[169264]="eNrd0LEKwkAUBdEUKndsRJz/9SdFJNiEgJVYqiAY2wVB2G1Ei1PO43GnbddNP+AceUSWSEt/itwjaewvkWtkgWwabtwiz8gMWTf+8M92kX3kEOnzvs8cWX3Y7Rgp1fZDpFTbj5FSbf8tL6+SYPI=",
[169776]="eNrlkbsKwkAUBQOCzMFKOP/r/wVEwUKwSBFfqFgIaiHIykIKibtCsAlYTDXM5e7eMCmK0AN2WHusA9YJq+3vWA+sgT5dlz5gjRMzuvSjH/th5g3/zBmreqPta6w1VvznY8JfsLZf+iVWZJXxN6y4wybjp1iRGdYi4Z9Y12a3VF9ilc2MOf25/wub6l5x",
[169777]="eNr7X8/A8H8Uj+IRjpk5RTj5OEU4ydX/jkOE8yeHCCcHBWYMBAYAsl95Vg==",
[170288]="eNrN0aEOg2AQA+DfrfV9373cRsjCGDMY3DJBQsgSxJBgTpFjMBD8ouaaz/SGcwhDRDlR7CBO7yXEAmIO8eH0//h8h79btvrMEtPmMSRQ/EJsIL6cfRKIF9vO+18PsYX4hljN+KvZwuk/EOsFn5p9On29wt9++KMyAjHoXbw=",
[170289]="eNr7X8/A8H8Q4AscIpx3OEQ4f3CIcHJyinCSqv8chfpPU6j/LIcI5y0K9I90/JBDhBMZDzX9FzlEOJHxUAl3ACIfa2w=",
[170290]="eNr7X8/A8H8UUwV/5BDhhOHR8CAdV3KIcKZwiHAWkhF+MRwinIkcIpylHCKcLWToT+YQ4WzkEOGcwyHCuWwExR8AAGBzLw==",
[170800]="eNrlkrsKwkAURFPO9PO/+Qmx1SKN4AMMAYuQIiAxQUFB7G0CfkXCwgoh7BWxUbA4zc49w+5yuziKuh+ghXjzXCGO8xpiEzgf+s67QDwbfv2Gf/J86jfG3NN373u86PlXjhD3EHOIm8D/LCBmEA8Q74G8griDuIQ4N/wVxMLYjxJiCjGBODV8x9bfc5y73jXEGcRJIE98t+V/ix5mb1vY",
[170801]="eNr7X8/A8H8I4JccIpwg/IhDhHM7hwjnUNP/lEOEE4RvcohwriBD/ygexbTAACU1dgw=",
[170802]="eNr7X8/A8H8Uj+JBgJ9wiHDycIpwkqv/BocIJzMF+s9yiHC+5xDhFCDTjCkcIpwgNzBg0c/BKcLJTYHbaIUBjsZzAA==",
[171312]="eNr7X8/A8H8Q4DUcIpyU6F9Gof5FA6x/pOM+CsOvnkL9eRwinJEcIpzuHCKcpljMEuEQ4YRhfizyZRwinCAMMicMizwHhwgnDLMOorQCACsqZ2g=",
[171313]="eNrl0iEKAkEYxfFt773si+J5vINH8AqCtzAIgibBaFNBsBo2avECGwQFq6x84Bad4qQFwy/95zEwTD0uiroFSlrhSGtN69f9gVbY0ppn7Ge0woTWKGM/pBUGtPoZ+3/XoxW6tJ74fr8prLCCtUt00wodWrdEX8AKS1ibRH/ACldYp0Tfw2qk7r/AOsMq32c++x1Wo0J7/scLS8NcVQ==",
[171314]="eNrl0SEKAlEUheFJcv4gKBzdgMEdaLJaZgFqtItmk7gBk+7NpklEEKyi8GRgwqBvyqQBw58uH7x3b9gkSahBW5m9zCHve36Uucg0+J1lrWV2hcp8UNxPZRYyy7yYv8o8ZZqRNwxkUpmJzLzE32ReMpT84Z/ryvRlhjLjyP5OMg+ZhPj+iz6t4Du5z+44q+BbMj2Zkcwq4s8yd5m3TLtG9/8AC/FHZQ==",
[171824]="eNr7X8/A8H8Q4DUcIpyrOEQ4Z3GIcJZziHAOlP4VUEyq/sscIpwgfIlDhPMiGfpHMX48lUOEcxISJlX/vEGgv5NDhLMLigdLuAIAbqNm2w==",
[171825]="eNr7X8/A8H8QYC0OEU4YJke/MYcIJwyTo9+WQ4QThsnRX8MhwgnDgyE8hxp+zCHC+Q4Jo8vf5hDhPMMhwrmTQ4RzNhZ5Wut/QEA/C6cIpwCnCKcQFGOTf4pH/0BhAFMUXH0=",
[171826]="eNr7X8/A8H8Q4M/sIpxqHCKc+RwinEc5RDjR5QU4McVI0S9MoX5K3T+K8eMH7CKcvBwinN4cIpwzyQi/W+winAwcIpxmHCKcNWTof8wuwvmFXYRTkUOEM4YM/R/ZRTh/s4tw8nCIcNph0X+ZQ4TzKhIeLOEOAHq0X2I=",
[171829]="eNr7X8/A8H8IYD5OEU4eThFOLk4RTm5OEU5S9fNA9bNxinCyUqifmQz9MEyp/pGOv3GIcIIwufpfcohwPqdQ/20K9V/jGDzxDwCUdmgz",
[171827]="eNrtzSEKgEAARNHFNL/PWS0KXsEreAKzZ7ArdoNZbIYV+6YFwbDhpeEzsQshFsXPVZhTZpM5ZHL7WWbJ6FeZSWaQGRP9LfO6ZPbE3ss0MrVMm/H/lQcEK3ET",
[171828]="eNr7X8/A8H8Uj+Ihjlk4RTiRMbo8ExYxZLyFQ4QTGaPLr+HAr7+GQ4SznEOEM55DhNMVi9pMAvoHCgMArPdvbA==",
[171830]="eNrtzKEKgDAARdHFd6Pw/tdvMwgmi21gMhjEpMU0sVs2EMvCifemNoRUVT/bZQ6ZSyY9Mvsos8hsMmdBP8hMMrPMWtB3Mr3MKBNfemEa8r9fuwFaLXPq",
[172335]="eNr7X8/A8H8oYA4RzvccIpx/oZhU/SycIpy/oXoZOEnXz88pwsnOSb5+mBlMnOTrH8UMDIKcIpzMFITfQOsHYeZBFP8ACLlnwA==",
[172336]="eNr7X8/A8H8Q4D8cIpyvOEQ4ydXPwCnC+WkI6x/p+BqHCOc1CsLvOIcI5y4q6AfhnVjMWcUhwgnCyzlEOBdhkQfpPwzFB7DIT+MQ4ZzEIcLZxyHC2TmI0gkAeAhrHQ==",
[172337]="eNrd0aENAmEQBeGTb/zUQAEkWAwJAociJJgToEDhweFoBUsrWEqgAQ4DyeXPOQyHGPVld8U2x6pqetIzco9cI32bB3lEbl/c/+cukXalnyOHyDay7PBTpF3p+8gmsohMO3z33v2p9FVkHplERh2+jtStSp9FxpFhZPBD/38BCD5ZCw==",
[172338]="eNrl0SELwlAYheEFwXMmaHlBsIhNDIrVoBYRBTGZzPsd/nFxMrhhjE9ELQPDSS8PF+5X3rKsbMHuXdwRzoUHws0+Eh4LT4XnQa/7ftCHwhPhmfAi6I8P/DLolf3F//tId++lP2z2lfAmbRv0ulfQ18I74b3w6QtfvXsQPgtf3/j8hT8KX4SLFt3/CSWLMt4=",
[172339]="eNr7X8/A8H8QYD0OEU4Q1uEQ4dTiEOFEl5fjEOEEYQUOEU5lLPKGHCKcIKzPIcKpi0c/DA82/SMdh3GIcCJjdPlUDhHOHRwinBc4RDgfY5Gv5hDhhGFcdpzkEOF8yiHC+ROLmjUcIpwwjEv/FQ4Rzq8cIpyMnOTFH6X6aYEBrA5Gng==",
[172340]="eNrN0DsKwlAQheH4KM5vIQSPaCMIwRRa2FoIrsEduBPX4R5tfPSRC1cI15vCLsVX/TNTTHMtiqYHKplaZiuzl0n7QeYoc4rSvpIJ1jJVptfx/q7j/lJmITOP0n6RaUv7TKaU2cicM/0m09aHn/fJXebrkfnPU+Yl847SPsIEjcyQ3y5MMI4zXX2AmWT2S0wwjXP/7vfVB55rPt4=",
[172341]="eNrl0TEOQEAUBFDlTD/3dQuJYHERhVor0UkkFAqNA6xssg7gV0Qx5ZtM/vdpkvgPJIOYQywgthCf+uBKiBXE2uAdxDuNwXfROeP+v+eEOEEcIPaG+wU/x47R6FeIS+yx+APiDnF70f8vSLNrBw==",
[172342]="eNrl0T0KwlAQBOCUM/3c1wtZaKGFiEGjCEZFEyUE//AkkYUVJGz6gMU08zFbvNcMkqTpQcYQf9P2DOIe4hXiI/AhRMsI4rRjv/Ubl8BtN4E4g7gI3LoU4hpiHrht5xCXEFeBW5f5fhP4vyf1d9n5H7XduoPnGHjuuzPEMvDS+wLiKfDCrYJYB157b37ruG92h/gM/AXxm3eP/v8DiJFaEw==",
[172343]="eNr7X8/A8H8QYE5OEU5K9fNQYAYbVL8AmWb85RDh5KBA/0jHbzlEOL9yiHCykRl+nzlEOEFxwE6m/h8cIpxMFKQhkN2sQzD+Ac5naR0=",
[172848]="eNr7X8/A8H8Q4PMcIpwwfIZDhBNdfjmHCOdCDhHOWRwinJOxyBPSv4JDhHMJhwjnPA4RzulY5C8Q0L+eQ4RzNdSMOVjkBThFOK/j0b+NQ4RzM4cI5xqoPwZDmA9WzMY5Gj70wgDrBGgT",
[172849]="eNrl0CFrQlEYxvG75PPvz3cT29AgjAXBpAsXv4DRMhDW1nTBD7A8g1GDyWixjBX1jgNn5XDusCkYfunP84a3KouiugFtmaZMS+ZRJu3PMn+6md6J+yeZYaaPZIIXmV6m92WCUmaS6W8ywavM4J8evGf6QiaYyYwz/d41MHuZTZT2tcxK5lNmWvO/o8whSlu4vZX5kpnX7E8y5yht3zI7maXMR82+wDxEafu5YH8Nv0sNUXs=",
[172850]="eNrlkaEKAlEUBTee00dMoogYBOMaRFAxrJgEUUSTWEyCwWzxA/zjtbz02F1hi4Jh0jA3nJs/kiT/AXrCTeFGIPZT4ZXwVvhS4IfCbeFWIPYT4Uz4UNKnwn3hTrgT+5HwsqIfCw+EuyV9+qH/d47Cm7DRrGL/nfC5wN+ET8Jr4XlJn1X0T+Fr8Isa/3kJ34X3Nftv8QZPCUH9",
[172851]="eNrd0aEKAlEARNEHgs4F4/1fq13DJmWTIAbtGiz+j0HWIk/8BJ9pDcOkU2bqopQ6gjwi98inC9Lqnz/4V2SCzBr8EKmRKTJv8P+ePrKLnCLXfL/POrKJHCKXBr+MdJF95NzgV5Ft5Bi5ZTz/vgGl5mc2",
[172852]="eNr7X8/A8H8QYEZOEU4QZuYU4eTnFOEkVT8XpwgnDAuQoV+YU4RTmAx9o3gUD2UMAE62cQg=",
[172853]="eNrt0TEOgDAQA8GjuwVREPm//BrKQxF5gUUTiWLLaew6I2qCDkQiKsWVwvEgAs83xIpYTN/bhr9N//f+sOPvN7v/ugfd1mTT",
[172854]="eNrlkrEKgDAMBTtJsud//VBxkSq2KoIgKA6VQoYQisVBKDjckuOG8hpqY0IB9EDoBNp7IJRoH5tZ8Lb3H/cjEA78tjXh/47L7G/5vgHhmfDx/1iB9l2mX7hrGe0n3m0HwuuhbxjtY3fEOxBWWM7+N5rJYYk=",
[173360]="eNr7X8/A8H8I4J8cIpyU6L9Pof6rFOq/SKH+kY53cYhwLkLC9Na/mUOEcy4SJsf+lRwinPM5RDgnD6K0AACTonD5",
[173361]="eNr7X8/A8H+QYAZOEU5GKEaX+84hwnmLQ4TzDAemHLJ+GCbH/p8cIpwwTI7+txwinDA8WMJ0FA8O/IBDhPMahwjnNg4RzoODKH0AAEi7b/k=",
[173362]="eNr7X8/A8H8UE8ThHCKcmRwinA0cIpwzOEQ4SdUfxSHCmc0hwtnEIcI5iwz9wx0f4hDhBOGNHCKcc8kIn8GifwOHCOeCIRS/AKpUbLs=",
[173363]="eNr7X8/A8H8Q4BccIpz/OEQ4BThFOMnR/5VDhJOTTL1gzEGB3noGBorsHsWjeIAwAHe0eKA=",
[173365]="eNr7X8/A8H8IYR5OEU4mThFOcvVzcYpw/uOgTL8AmfYLU6B3FI9iWmAAF1Z0og==",
[173366]="eNr7X8/A8H8Q4FccIpwvOUQ4v3OIcLJwinCSqv8fVO9fDhFOTjL0C3CKcPJyinCyQWly/SHEKcIpSIH+UTyK6YkBBqhxVg==",
[173873]="eNrlkrsKwlAQBVOe6c//+j1qehFEtIkkQUELH42oPxIJ3OJySSKkUbCYZodZtthmkmXND3CTaXkGUv+QOcusZYoOv5U5ylzCnq79C5lNT78K86LH5zLLgX4mM5WZy+Qj+n+nktlFpL6UqSNSf5ApI1Jff+ivMnuZKjB0a1f/kml/9C5zGtF/izf9PV1Z",
[173874]="eNr7X8/A8H8Q4OMcIpwgfIRDhPMkhwgnuvxFDhFOEL7GIcJ5F4s8MfqvcIhw3uQQ4XxIQ/1HydQ/0vFVDhHOG0gYXf4yNP5B6m5jkSdW/wVoPFCi/xwN9A8UBgAarlxD",
[173875]="eNrlkqsKw0AURFeUZg60Ee38b7+vMZEldX3I+sgNC6vCQghrQiqOupwRdybeQog74IKp8U+V/hHTVmb8Mx+Zr8xPZtT6Pw4yT5lXzpjfrwvd9DKJh8y74Kd9nDOlnu8yiU5mKPgHTNpIg2FDO5kA0AllUQ==",
[174385]="eNr7X8/A8H+I4QscIpyU6L9Lhn4hThFONk4Rzp8cIpxvyLRfGGrGDwrdP4pHMbUwADgmdq4=",
[174386]="eNrtkiELwmAYhL+Z7gHj/V//kbApaBC7TcEyDHMsaDJYFieDBdFt4iwLhivv8dwLx1WzEKqRKZN5vSUya5mNzLbFf9a5xY9lljKrJqePzzv+1xlJo2/5hcz8A/dXCFPMhPeejjK7H/orZFKZvcxhQM5d5ipTb/M0gI8wpcxN5jKiHTwApIppCw==",
[174388]="eNr7X8/A8H8QYCFOEU4YJkc/D6cIJwyTo5+VU4STjVOEk4NM/UycIpzMUMxHphkjGQuMhtmAYAAzDWvT",
[174387]="eNrtyzELRXAYRnHj8+zn+/qCJOmWQne4kVG6ZVH0X/XuUoYz/TpHnmXH29vDq4Ur4VK4EL56LzwKT8Jz4J1wK/wRbgJPzyK8Cv8D/wl/hQfhPvD0bsJ7ssDv6gSthHL2",
[174899]="eNr7X8/A8H8QYCFOEU5BThFOED0Y3DOKR/FIwAB5HHo9",
[188755]="eNr7X8/A8H8Uj+JRTFNcxNjJ2MDYyTjY3AUAHaB9HA==",
[188756]="eNr7X8/A8H8Uj+JRTDEuZ+xkHGpuBgBWG32U",
[189268]="eNr7X8/A8H8Q4EjGTsZQxk7GIMZOxhjGTkZS9SdC9ZNrfwNjJ2MqBfpBuI1C/aN4FNMbAwBSS3kC",
[189780]="eNr7X8/A8H+Q4XrGTkZy9XYwdjI2UaC/krGTsYUC/dUU6B3JuIqxk7FjAMO9Y4TGGwAqqnmY",
[189779]="eNr7X8/A8H8Uj+JRTBFuZexkHIruBgBeO32i",
[190291]="eNr7X8/A8H8Q4BTGTkYXxk5GecZORjHGTkZS9ecg6RcmU78rVD83hfp5ydA/ikfxQGAArspyVw==",
[193284]="eNr7X8/A8H8Uj+JRTFMsyS7DLs0uwz7Y3AUAPi17nA==",
[193796]="eNrt0DEKgDAABMGAmBULIWqhsH/Nz02ws41dxGLK5eBKDqF04ERWZEYGpLU/kIRMyBXb+3t7QSIyvtjfkP2hh89/31cBr9xqsA==",
[202526]="eNr7X8/A8H8Uj+JRDMatjB2MDYwdjKTqq2LsYKxg7GAsZ+xgLCVD/0BhAH0iezs=",
[202527]="eNr7X8/A8H8Uj+IhjtsZOxgp1U+JGW2MHYzIGJf5lNpDbQwAJmJ5XQ==",
[203039]="eNr7X8/A8H8Q4FzGDsZ8xg7GQsYOxmLGDsbB4KZRPIqHOwYAj918AA==",
[202533]="eNrlkSEKAmEQRuddxGAwCTY1ahMPYPUAJk1i2WJ4FzMIggaRDaJgEIyeYGXBJFv2TwuGLz3eN8NMkUUUDUmGrJEV8ssmyBSZIfMKvkU2yBJZVPARMkDG3566uw2RHtJF+gl+6XaQFtJO8P8975BXyCPkGvXv9wy5heQh5wT/HnIJOYUcEvxy7jFkH7KL5vz/A/hWbUw=",
[202534]="eNrlki0OwmAUBHduhuIE+GougAQ796kES4PlxxKCJuEKRZF8qWn6YZogRm3m5WWz/S7pZ8AaKZnqr5CSYb4ZublASoZ5g2wr/vqyRJof/H/nGnlEXpFU9HiMnCP3yDvT/X2ki1wizwq/jRwip8gt89nBBxB6cLY=",
[202535]="eNr7X8/A8H8Uj+IRjpsZOxgp0Z9Bof6BwgDakX0T",
[203044]="eNr7X8/A8H8I4XbGDsYmxg5GUvXVMnYw1pKhbxSP4uGMAevYfEM=",
[203046]="eNr7X8/A8H8I4IcMHYzImFT9Pxg6GJHxUPDzKB7FtMYAxGt9zA==",
[203040]="eNr7X8/A8H8Uj+JBggsZOxgp0V9Pof6RhgFlaX0Y",
[203557]="eNr7X8/A8H8UE8TPGDoYnzB0ML5i6GD8wtDBSKp+kL7nDB2Mb8jUP5KwKiNl4aNAoX5FCvUrMw6d+AUAYkp6eg==",
[203559]="eNrl0KsOgEAMRNG9XwoGCE+FQ0ACIfPXi1kMwdCaTRDHtJkRE9cQYgZmxIRoERXi+T9ebl/szvyGOB0dC8Lb8Xc9YkCMxg07xM2SrxFNYskXiDLJZdMLV0FyNw==",
[203558]="eNr7X8/A8H8Uj+IRjl0YOxhB2Jmxg5Ec/SGMHYwgHESm/oHCAF8neh0=",
[204069]="eNr7X8/A8H8I4GzGDsZyxg5GcvUXMXYw1lGgv4yxg7GZAv2jGD/2Y+xgdGbsYPRm7GAMISOcQfp8oHpjR+OJaAwAxOR1+w==",
[204071]="eNrtkLEJgDAAwJovnSqIQlFQQTq75uuK4AN2qzhkTIaUM4TSABMyIBHpkLf+giTk7vQV/o6syIyMFX5GDmR7Gi08//k+F8WcdVE=",
[203050]="eNrtzD0OQEAUReE5m9EgEo1CaEj89JaAZDahUdxdj0gUMhk1heJr3sm7bjPG/X4fYREzwr+vCHvj9x2xIHpEE+gtYkCMiCnQO0SJSBFZoOeIAlFdO36PEdGN3xPEuVE//L/lAIBradw=",
[203561]="eNr7X8/A8H+Q4FbGDsYGxg7GasYORlL1NjJ2MNYwdjBWMHYwlpGhfxSP4pGIAe+ies8=",
[203562]="eNr7X8/A8H8Q4CDGDsYixg5GcvUXUqB3FI/ikYoBE1h8aQ==",
[203560]="eNr7X8/A8H8Uj+IBxhWMHYyVjB2M5OovZOxgLKZAfwZjB2MWBfoTGDsYEyjQP1AYACeuedc=",
[204072]="eNr7X8/A8H8QYA/GDkZ3xg5GcvX7MXYw+lKgP5SxgzGEsYMxmLGDMRCLOe5Q80HysRTYE0Kh/pGOCxk7GPMpCL9qxg7GSgr0tzB2MDYNo/gDAAn7ckY=",
}

depthPages[1]={
[57587]="eNr7X8/A8H8Uj+IRjpeq7VabobZbbZbabrW1arvVaGXPWqg9g8XfAHOffw8=",
[58099]="eNr7X8/A8H8I4Q613WogPJT1T6NA/ygexdTEAFOgfqY=",
[71973]="eNrtkCESQFAUAF1gz+w8okrESGYohmQcYM/wlReVnwg/bNwNm+qqSoXCx8xIj7RIg+T6KzIiXTRy/QNZkCEauf6N7NGYXvwNOZEr+Mv3B3NshHI=",
[71974]="eNr7X8/A8H8Uj+JRTBG+x/uW9wLvW96h5m4AM29+0A==",
[71975]="eNr7X8/A8H8Uj+JRDMbbeN/ygvBA6ac3BgByfX8M",
[72486]="eNrty6sNgDAAANEucDMzHEEggCY4PhrMzVBSS1BU1FQ8dbnUhZCaprIJGZENuZB3v5HsRPqPPiAzcvz8I7IU/DuyFvy1POdiinA=",
[72998]="eNr7X8/A8H8I4Fu8b3mv877lPc37lncv71teUvU/5X3Le4f3Le9lqBnkuOEF71veh7xveW+SqR+EX/K+5X1Egf5RPIqpiQF3ZIMK",
[72999]="eNr7X8/A8H8I4Bbet7xevG959Xnf8qryvuUlVX8b71veAN63vNa8b3nNyNSfiITJ0T8RCQ+FMKcnfsH7lvcJEibHjDe8b3mf877lfURh+L4ZQfEDADDRgGg=",
[71464]="eNrtjjsKgDAAQ3uBd2aP5qxTB4e6KAj+yRkqhQ4itWuXDm9KXohvjPGVSmEmxPrimx+IE3EnssCICAyIPtHZEWHj+vEdwmX8GbHFDynfImx020Sni/tL5kMJHiBbiXk=",
[71976]="eNr7X8/A8H8Q4CO8b3n3QvFu3re86PLzeN/y1vC+5TXjfcv7kwdT/ghU3w7et7zbCei/ikf/NijGp/8MHv3bibAfm/5RTBjz877ljeN9yzuLl7zwE+N9y5vO+5Z33hDVTwsMAAaaglU=",
[72488]="eNrd0LENQFAYReHXy9nBABKVSkSlVFIZwAI6iRnMZAZj3BmeRvEif4XkheKrbk5z/eKc/4gMUSFGxN0+ReQP+yRS/2cNokDUiMH4Z0WErL5FdIjJ2DdE6LqXZ98jZmPfEaG3+1gOTV98sw==",
[72489]="eNr7X8/A8H8Q4HO8b3mv8L7lvcn7lvc171teUvUv433Lu4X3Le9h3re818nQn8v7lncK71vedbxveY+SoT8aSf9OMvSPdOxFYZj5DnH9A4UBoTOBGQ==",
[73000]="eNrN0b0JAkEQQOFr4LVgBeaCgaCJRgZmJgZ2YC5YidWIYqCn5w9WYKDwajg5uGA5lsNwg5fsx8AwW26yrEygDtJHxsgKafoTCWt6D6nqIvOI75Cwpk+RCTJCBhHfImFNXyMLZIYMI75EwlK4eWp9kBdyitwnR/La9i33eyOXiF+RqjNyaJn/IkXEi/o9/2P+EfE7cqt3Oyb0/z+F4ob+",
[73001]="eNr7X8/A8H8QYHPet7yU6OemUP9HHsr036RQ/0jH23nf8iJjdPnTvG95H+GJ4ye8b3mRMbr8ed63vC8pSCMXeN/yvh5A/bTCADzNhBU=",
[74006]="eNr7X8/A8H8Uj+IBxn4szSyOLM0sNlBMqn4zlmYWDZZmFimWZhZBMvSLsjSzMCNhUvXzsDSz8CLhoRLuAMPIcME=",
[74517]="eNr7X8/A8H+I4WCWZhZK9PtQoL+BpZnFiQL9tSzNLG4Uun8Uj2JqYQCD9nqC",
[74518]="eNr7X8/A8H8QYD6WZhZhJExt/W4szSwRLM0sySzNLKlY5HlYmlmEkDC6fB5LM0sDHndxsDSz8EGxABnuH+nYnUD4jmLaYABfbWtn",
[74023]="eNr7X8/A8H8UE8QveN/yPuN9y0uu/hu8b3nP8L7lvcP7lvcVBeaM5PAfDQfqYwC07oDv",
[79147]="eNr7X8/A8H8Uj+JBjtsFuwVLkfBomFAHAwDcqHyy",
[91387]="eNr7X8/A8H8Uj+JRTBGezjBjSLobAHRpfcE=",
[91899]="eNrtkcEKQFAUBedXLS1ko2SBRCllQcn87ZPyAbyVYjGd1ZxO94YWwgsokA6ZkQ0f+zlSIxOyRvgpUiL9teGpnyAZUiFDhP91zp+NSHNlbM+OLP/9b3MAzld1bA==",
[110339]="eNr7X8/A8H+Q4VdMf5ko0f+CQv2jeHjj6xSmj4HWT00MAEYXf/Y=",
[110344]="eNr7X8/A8H8Uj+JRTBH+xvSX6QPTX6ah5m4AUr9+/A==",
[113462]="eNr7X8/A8H8Uj+JBjl8xfGF4iITJ0Y+MSdX/juELHJPjfkr10woDALLfg00=",
[115470]="eNr7X8/A8H8Uj+JRzNDNNIWpkWkKUznTFCZyzchgmsIUQYF+emMA2Id71Q==",
[115983]="eNr7X8/A8H8Uj+JRTBGeyDSFaSi6GwBwGX27",
[114998]="eNr7X8/A8H8Uj+JRTDT+xPBlQPVTEwMANt9+4A==",
[115510]="eNr7X8/A8H8Uj+Ihgp8zfGF4wvCFbP1PKNT/lEL9LyjUT20MAEcngOg=",
[119036]="eNr7X8/A8H8IYUkG6SHl3lE8igczBgBoz3zG",
[119039]="eNrNkDsKgEAQQ6ONpQfIYT2f+EEFG4+gCFpoYxFxsdDFD2y1xWsmvARGCSCPiEGDqx+ABld/EbGKr70hiOijfxAN9n0UMZ/dm+jVz30gFW/YeSaiEFGLaB/yXrzx5OciShGNo3/sVz/704mdH153wZe/77adhks=",
[119037]="eNr7X8/A8H8Uj+JhgCUYpBl4GKQZ/v+XxpB7+18aBeMzR5QBU/7Bf2kUTKrbnv6XZrjzX5rhxn9phntk6KcVBgD5FoC2",
[119038]="eNr7X8/A8H8Uj+Ihjh/+lwbju/+lGW78l8aQv/RfGo4vYpGH6b//X5rhJhb5k/+lUTCp+g/+l0bBgyXcAP15iIo=",
[119549]="eNr7X8/A8H8IYG4GaYr081GoX4BC/cIU6h/Fo5gWGADlVnjA",
[119040]="eNr7X8/A8H8UU4ylGKSJVidOpNqRhP/8l2ZgZZBm4GeQJjoskTEjgzQDD4M0gxiZYcvBIM0gTEG88DFIM0gOwXgFAHlpbX8=",
[133882]="eNr7X8/A8H8UE8SZLPtZYDiCZT8LqfqDWPazwLAbGfpH8SimBQYA2H57Jw==",
[133883]="eNr7X8/A8H8UM1iy7GexhuI8lv0spOo3YNnPosOynyWKZT/LIjL0j+JRPBAYAGZHes0=",
[139039]="eNr7X8/A8H8Uj+IhgJ2Y3Jko0a/L5M7kQKEZww0DAFC0eyY=",
[139552]="eNr7X8/A8H8QYCMmdyZ7JncmcvXbMLkzIePB4KdRPIoHOwYAkTt4Pw==",
[146141]="eNr7X8/A8H8Y4GjGFEZK9AczpjAmUmCGP2MKYxhjCmMshe4YxaOYnhgAwEV5kQ==",
[145133]="eNr7X8/A8H8Uj+JRTBHOZGpkAuFcpkamoeRuAH8yfGQ=",
[146183]="eNr7X8/A8H8Uj+JRTBfs89/3v9N/3/+DxT0A2AeAOA==",
[146695]="eNrdkTEKg0AQRTdtwMI2QvAMsfAMEf6ZPGq6BNKEVJvGeSIoLEuIMJWmeNWbB8MMfQjsgCMiID4mPP0BEU28nP1g4m3i4eynvZ8mbs7+36kQJaKYyf195W414pyQ+7jSt4gmIfcnfvcdYuH6ZfbCNv8+ApALpQQ=",
[146694]="eNr7X8/A8H8Uj+IRhD3++/6nRL8Vhfq9KNRPTQwALe6BQw==",
[146184]="eNrt0LEKQGAAhdH/hSxiIIVkvM/k0Y+UWTFRhrPc+pZrK8Xv93KzGMUkVnG3r0UrBrE86CvRXPTH3ovu9JVfd5dKjpM=",
[146185]="eNr7X8/A8H8Uj+Ihjl3++/73/u/7n1z9zv99/4OwDwVmDEUMAEmRg3I=",
[146696]="eNr7X8/A8H+Q4VP/fP9Tov8khfoPYNEPMhMZ49O/g4D+QxS6bzjj5QTCZus/3/8b8ahZT0D/3H++/+fiUbOdgP5p/3z/z8Kj5gCF+umNAVm0okk=",
[146697]="eNrdkTEKwkAUBXMBOw8glilsJBfQ+p3Jy2gRYkAbFewsbARPYylvZCGBZV2rNMFiquEN/F02RcHIqBBD9mVmv0KsI1L/tpgi5ojcfomoIlL/spggZj/2C0RPOfC+f+Rq0XP39/s8LJ4RqT9ZnDsuGR+6t4jU7y0CrcUh449RO9ffWgR2FnXGNxZN1289nv//AGr/xZ8=",
[146698]="eNrlkjEKg1AQBbW1Sa+dlkEwCooEYiN270weydrWc+Qsf0T4lRoFgyBYvGp2HsuytI7DRdIgPogCMWe5Zb/ciZWIF+K5Mhcj8g1/L5HtrQ92BIipI/1jhzvngQgRGaI6cEPvZL8zojdiMOJrltxF+IgE8b7QD4wrhKR/",
[147208]="eNrtkiEOgDAQBJtAalqJ5Tso9k28tg5HMITcEBIcCHJBVCBGjtlZphCogBaxmigmPH5G7CZmp98hGsTi9HtEQmxO/+c7Bu4Nzi5v24wPfkRE/G3T9Y/atjoAJZ2Wsg==",
[147209]="eNr7X8/A8H8I4O5/vv9huPOf739S9bf/8/0Pwm3/fP+3kKF/FI9svPWf7//d/3z/H4RiUvXvoFA/rTAA82SU+Q==",
[147210]="eNrl0aEKwlAAheEFg0F8CcHqi3ieyScxaHBYDBr1KZYtSxvIDG4Yzy8LgszrlKWB4U/nfly4l0UU0YM2FjuLo8XZorlfLepKiyHv+9pia3GwSAK+sCha/NJiZRFbnAI+tUhbfH33/qXmnnzx/94U8ezTmcziYnEPvO8vPreoLEZ08zeLMWLW0Q8QE8S8R///ALnlyRI=",
[147211]="eNr7X8/A8H8Uj+IBxt7/ff+PhgP9MQBFKX8o",
[148226]="eNr7X8/A8H8Uj+JBjj3++/53hmJy9LtC9bqQqX+4YgBLSIR4",
[149250]="eNr7X8/A8H8Uj+IhhK3/+/6nRL/DENdPTQwAdzaCPw==",
[149251]="eNr7X8/A8H8Uj+IRjr3++/6nRL/Rf9//PhSaMRAYACzugT8=",
[149762]="eNr7X8/A8H8IYc//vv8t//v+H6n6R/EopiYGAEdBhoA=",
[149763]="eNr7X8/A8H8IYLf/vv+RMan6lf77/kfGpOr/8s/3/+9/vv+Z//v+5yFD/yjGjxn/+/4H4V//fP8/+Ud6+HL99/0Pw3//URY/zCMofgHrf5V4",
[150275]="eNr7X8/A8H8UU4xd//v+Hw2HUTzUMACS6H8i",
[150276]="eNr7X8/A8H8IYKP/vv8d/vv+H6n6hzv2GA2bAcEAXyGHVQ==",
[147720]="eNr7X8/A8H+IYPf/vv8t/vv+1/nv+58Sc+wp1D+KR/FwwQD65YIu",
[147721]="eNrtkCESQFAUABlNNKLsEO6wZ3JMUaSZkShvFRfwR/hjhI27YR2LwgzYA9fAOXAKfOpX4hm4BS4JfivWYikeCX4vdmJzd3J4+lWG/+9rXHDVk7Y=",
[147722]="eNrtyyEKgDAchfEFg0UwWATjijcQPIAgvDN5Ti9gXbEJ/0/sm6sLC7/0vsfhHAU4TVwmbhOpZie9BROPiRbRR7r15/tpEB1iRPhIu2X+A2JCzIgl01ZVKV4AmJLV",
[152300]="eNr7X8/A8H8Uj+JRTDXszujPOFTcCgATN30q",
[152812]="eNr7X8/A8H8Q4B8M/owPGPwZHzL4MzIy+jOSqp+F0Z/xK4M/4ysGf8bPDJj6fQmYKcHoz8hLhr0wrMLozyhGgf5RPIoHAgMAz6l0/Q==",
[162043]="eNr7X8/A8H8Uj+JBjpMYUxhHw4H6GAC49n1a",
[165117]="eNr7X8/A8H8Uj+JRTFO8+v/R/xuR8GBxFwAPsYXi",
[166139]="eNr7X8/A8H+E4S3/j/6nRH8SBfq3/z/6P5NC+0c63joaflTDACT4h1Q=",
[186118]="eNr7X8/A8H8Uj+IRgrW/m3/X/27+nRy96t/Nv7N9N//OT4Z+ze/m3zm+m3+/+M38+4tv5NlPCwwAoLeGbQ==",
[186631]="eNr7X8/A8H8Uk4QNvpt/J0ef9nfz79Jk6h3Fo5gWGAAKxoB7",
[186123]="eNr7X8/A8H8Uj+IRjh2/u353+e76nVz9+t9dvxt9d/1u/t31uz0F5tAbAwD+1IOq",
[186634]="eNrl0aEKwmAYRuFhmElMwgzCspi8Ast7XbsfMQwFBW/FYjUZhPeMlYnwB8NXtqYLJz7pdFWWdT/QClF81dfPEfnHWbTu7yeIxuJp8RjgX8ndLW4D/FjaIBbB36tFbXFMRXaLKBGzwJ8tDqk68DvEGrFETAN/stgne/mjf2+VVKp6",
[186635]="eNr7X8/A8H8QYNbvrt9BmFz9f765fgdhcvV/+Ob6/QMF+t+D9FKgf6Rjye+u35UpiH/N767fdSnQr/Pd9bv+AOofKAwAjhKQcg==",
[187145]="eNr7X8/A8H8U0w27fHf9bvbd9ftoWJCGHaHhpvXd9TsPGeEH0m/63fW79HfX7z+/ka7f+Lvrd3mQvd9cvz8gQ7/Cd9fvTN9dvz//5vr9wrfBE/8AQOiRgA==",
[187657]="eNrt0SEKgFAURFExGayCwaRgFATTL4Iw63KzggsQ3i3CN7gC3y8KhhtPmYlrlsUP1CNKhJnYTDz1I6JCnCZ2hw+IBpEjDodfEB2icPq/uwlR499vRrSk7T8k+sB7/r8Aej+VjQ==",
[187659]="eNr7X8/A8H8QYKPvrt9Nvrt+J1e/wHfX76IU6H//zfX7l2/k63/0zfX7Swr0j3S88Zvr9yUUhN/eb67fd1Gg//o31+/IGF1+yzfX7zC8D4v8u2+u35ExuvwuqPv2f3P9fnEQpRMAySOluw==",
[187660]="eNr7X8/A8H8Uj+IRjjm/u36X+O763eC763dy9Yt/d/1uTKb+gcIAoFiC8g==",
[188171]="eNr7X8/A8H8IYLPvrt+R8VBw8ygexYMdAwDQEoG8",
}

depthPages[2991]={
[101608]="eNr7X8/A8H8Uj+IBxkyy7rKU6OenUL84hfo1KNQ/UBgAoPp6bA==",
[101609]="eNr7X8/A8H8Uj+JRDMeusu6yQ8FMamAAle18oA==",
[105193]="eNrlkbEJwmAUhDPFfUU6N7AWJIWIREERAwoZ4Qo3cAwLCzfIEJIt7B3CJhKwCPqb4q8Ui2vu3cfBveaQJM0XaIcpMGvMCvN6LzFlwO/yG8wSs4jgt8/eHDON4NvuOWaGGUfw/64JZogZYO5636n1rvq8X4q5ydQy50DuKLPv4S8ylcxJJg/kMpmsh686/Ei/8+cHNR9osw==",
[105195]="eNr7X8/A8H8U0wUnieeIj4bDKB5MGABd9n2O",
[105192]="eNr7X8/A8H8Uj+IRhMPEc8TJ1RsnniNuQqF+bQr0UxsDAGvnew0=",
[105704]="eNr7X8/A8H8I4UzxHHFv8RxxSvQnUqB/FA9NnC2eI46MSdWfIp4jjoxJ1R8lniMejoQHS7gAACBVdek=",
[105705]="eNr7X8/A8H8Q4M9iOeJ3xXLE94jliE8RyxEnVb+UeI74e7Ec8f1k6lccYP0jHXOKUxZmmhTqNxlg/QOFASeidw8=",
[105708]="eNr7X8/A8H+Q4VTxHHFK9MdRqD+KQv2hFOofxaOYXhgAPcx78g==",
[106216]="eNrl0isKgAAQRVF3caNBDX7wExQsfsFgdB1vDy5diyt4YBDDjYeBmbnOILg+0IFYER2iRjh+RjSIyPQjokSEph8QOSI2/N/bET0iNfe3Pb+TmfdfEC2iQCSGn575lenf6gbizGha",
[106217]="eNr7X8/A8H8QYFXxHHFK9DNTqP+cGGX6t1Kof6TjjxSG359BoP+XWI74T7Ec8VdYzLojliN+UyxHHJTO9g2itAIAtz58VQ==",
[106218]="eNr7X8/A8H8kYNEccUaxHHEmsRxxcvT/G2D9Ix6L5oj/RcKk6mcXyxFHxqTqdxDLEUfG6PIRYjniyBhdvlAsRxwZD5ZwBQB1229S",
[106219]="eNr7X8/A8H8QYWaxHHEusRxxdHFsYqN4+OBoCuOXUv1eFOoXG6LpEwA39Xj6",
[106223]="eNrtkbEJgDAABAMuYHdgY2UjgoVWCuIIuoPl7eDokYxgsBFSXHlf3Mc7hFj4hAs5kBMpPd7RIzOyIntGv+RPyIJsGX6DdMiAjBl+hdRI2ml/9P8D6rhwvQ==",
[106220]="eNr7X8/A8H8Uj+IRjn+L5ogPpP6BwgDP7H46",
[106221]="eNr7X8/A8H8Uj+JBjvXFc8TVxXPEVcRzxOXFc8TJ1S8nniMuRoZ+bai9guI54rxk6GcWzxH/JJYj/kwsR/ypGOn6aYUBaP90GA==",
[106222]="eNrtzKENgDAYRGEMHvW/CcCSgGMGDA7JALcDa4FEsgJjkFQXUxLS1GMqPvVy59ei8Fn2sx4xIZYg7nPoI2JI9BLRINog7h3iVSf6ZeI24YK4V4ivuG8mdhOHiTOxd5/v1P9fHppycAA=",
[105204]="eNr7X8/A8H8Uj+IhguXFTcSHsn4RCvVTGwMA8aJ6EQ==",
[105205]="eNr7X8/A8H8Uj+JBjjXFTcQVxE3ERcVNxPnETcRJ1Q/Txw/FpOrnR9IrQIZ+Aag+EBYmQz+tMAAOXW19",
[105206]="eNr7X8/A8H8Uj+IBxhLiJuKSUKwobiJOqn4RcRNxMXETcVlxE3FNMvSD9EpB7dYnQ7+CuIm4kriJuBoZegcSAwBJX28v",
[105715]="eNr7X8/A8H8EYBlxE3FVcRNxcvXfEDMRfyZmIv5azET8jRhucwTETcS/YpE/IGYiflrMRPyymIn4VTHy3TGKRzE1MQCvUnjF",
[105716]="eNrlkaEKAlEUBTeJQdB0ZjVoMMmCGOb//ExtRouCzSI8k8mHgqZlw6S5Bw7nln3TlB5wi9wjJTJGPt12Ff+IjJAZsqj4a+TFJe9+grTIGtlW8ofIMXKKnCv5FdJ96T1kpsgc2fy40fLPfXcD/c0T3qRqzg==",
[105717]="eNr7X8/A8H8QYENxE/HB4I5RPIpHEgYAfkh9JQ==",
[106224]="eNr7X8/A8H8Uo+B08RxxdLFk8RzxNCziMBwjniMeJZ4jnohHzSgexYMNAwAh6Hr/",
[106226]="eNr7X8/A8H+IYGFxE/HfYibi5OrnFzcR/06Bfj5xE/H/FOgfxQOPDcVNxHnER+MQhgGxmniL",
[106227]="eNr7X8/A8H8Uj+IBxn/FTMSZxU3EucVNxAXETcRJ1c8kbiIuJG4irihuIq5Nhn5dMvQMBwwAGlB1uw==",
[107239]="eNrtkMsJgDAUBNPFdKEm+EPvghXYxPZg6ZFAhBCSq+TgYS5vWPax/jbGN8CB2BFbJPcrYkY4RF/xS0LuQ3ZEDAhb8DbebcWHzi52l/yESMm9i7+/tLB5S5yI69/lcx7pmGbx",
[107238]="eNr7X8/A8H8Uj+JBjm3Ec8QtxHPELcVzxK3Fc8TxqU3DIm8lniMOwiBznPHojxfPEffEoR+k1008RzwKj34fqD3o4iA3u4jniEcTcDu9MQDANnGf",
[107750]="eNr7X8/A8H8QYHvxHHEb8RxxS/EccTPxHHFS9VtD9VpAMan6rcRzxO2QMKn6HcVzxF2R8GAI06GEoykMs6zRMCcLAwArdXKf",
[106728]="eNrdkb0KggAYRX2LM0QgBC1BP/YDOYi1SC4SLUGTQyR436FHV4RvcPgisCFquNPhwOXe5hkEzQ/kgIgRS8QE8YkfvvFrh/f9scMrxANxR5QOT81fIEYD+v97rogCkSGOzj5TxAyxfcEv5iaIvcMj2/+EuDk8N3eHWDt8Y/xsP3v/du4KMR/gfystoyVcNA==",
[106729]="eNrl0S0KgEAUReHZxdmENqtgsFksGjQpBn/uHlz6iGAYhgcaFcOXDq/c53fn/AskiFDcM8QpR5RGTxGhr93/XYcIxb24dqsQjdFnRCjuNaJF9IjxZv/V6ANiQiwPfmfdby/9+QHY6Fxk",
[106730]="eNrl0DsOQEAYReGJRThaO9AQ0Ss0FiEacvdgqZZCJCORMR5REcXXzMn9i5kGY6YXKBGLHJEg3B4jQASIMdz3q32KSG2LON8Xnl4hVtmDfY1YlZ7+dy1iy/d/y3tnub1HbLm9udjfdXT/q2ax4mCW",
[106731]="eNrlkiFLw0EAR/8YBKMgv7eypILFIoumJZMga2ISFMP7BAtaLcPoZ1D8FmarLBnXTRZlIlyQ82YeLLz0eAf3u5vfdN18CXiI/HAXuY7UfhTZifQKtZ9GXiJPkUnDX0aOIsNC7deRj8hr5LHh7yPjyGmh9gNkG+mQz4afRZ4jtwv6VecCOUdOkEP+7rOLbCFfkbfGfr/7YaPfQ3rIGjL7px8hx41+H+kjG8j7gve7Qs7KGbU7KP9js9xhWXb/BkxhYBk=",
[106732]="eNr7X8/A8H8QYGaxHHFK9PNRqF9ogPWP4lE8EBgANnR6sQ==",
[106733]="eNr7X8/A8H8IYH+xHHFXsRxxU7EccUr061GoX55M/S5iOeLKYjni7GTqH+mYUSxHHIbJ0S8gliMOw+ToVxPLEYdhfOpkxXLE1bGoAaUdD7Ec8SSxHPHpgygNAAChJGsE",
[106734]="eNr7X8/A8H8IYFWxHHF1sRxxXbEc8UCxHHFS9StC9UeI5YhPIFN/lFiO+FSxHPHTZOhPFssRnyuWI34RpJcM/aN4FNMCAwAncXZl",
[106735]="eNr7X8/A8H8Q4AjxHPEs8RzxweCWUTyKRwoGACFjfQo=",
[107240]="eNr7X8/A8H8QYFPxHHEzJIwun4JFDBkj67UioBYbthPPEXcSzxH3Fc8RjyVDv494jngMGfpG8SgeSAwA0sF0nQ==",
[107243]="eNr7X8/A8H+I4AzxHPFo8RxxT/EccXLNyBTPEY+iQD/MHUMlzEbxKMaHAc+Seu8=",
[107756]="eNr7X8/A8H+Q4WzxHPHB5qZRPLA4SjxHPFQ8R9xPPEfcgYz0MdT10woDADwLdEs=",
[107757]="eNrty6EOQGAYheFfUfRzbvLcggkuQRB1jW6TsXELJpprYIIx++S/CG969u6Jc/vfn+ciisGjtzcQB4gLxNDw819x9/YCYgWxh7jB/meIE8TR8BRiDrH+8OvvILaGC2IMMYNYGu6rAxfJc44=",
[107758]="eNr7X8/A8H8Uj+IRjtPEc8Qp0W8jniMeJJ4jniKeI56NxSyQWLJ4jrgvDvmBwgB7DHlV",
[108268]="eNrl0CEKAlEYReExW0z/WYUwIILBYNImJsEiaBCEswc34w60WAziFkRwBy7BNJYXDK8MUxTDiR8XbrUriuoHmiADpJuq60dI+VFd32/oy4b+X1oh08w/HaSNtJB75P/bIAtknPGvkGfILeSY8VtkicyQYcY/Qi4h55B9xq+RedruZfw15BRySH3L328yMmeU",
[108269]="eNr7X8/A8H+Q4QixHHFK9LtTqN+JQv2uFOofiThfLEe8UCxHvEMsR3wulvDbLJYjDsJLxHLE52ORLxXLEe8WyxHfJZYjfhqL/BmxHHEQPgXF6PK1Yjni28VyxF+I5Yi/xCIPEnuIhNHll4vliF8RyxH/AsXo8q/FcsS/I+HBEu4AdI93JQ==",
[108270]="eNrdkKEOQWEARu9TfJ/JimmqTRPlm/WzeQJTbKaxKZIpJLeYMZuJiqQJnuXavwlmf3ETwklnp5y8nyT5D5AKd4S7wj3hT/umcEu4LZwW6KvCNeG6cKNAXxIuC1cK9v/OUDgwEB5F/kyFF8KZ8D7ix8KBifAs4jfCR+Gz8CXiV8Jz4aXwOuJDcxW+PXn3O+Gt8EH4FPGhub/wLd8fq1Ntfg==",
[108271]="eNr7X8/A8H8Q4NliOeILxHLE14jliO8UyxFHlw8VxxRDxp1iOeL9Yjnis8RyxJdh0e9IQH+jWI54q1iOeB/UDHR5ffEc8VQ8ZoD0dkL1T8WiX1o8R9yNgBtGMj4gliMOw/uxhF8igbA7I5YjjoxJtf+6WI74TbEc8XtiOeLPyND/QCxH/IVYjvhnsRxxxiEUzwDpi3LX",
[108780]="eNr7X8/A8H8Q4HDxHPEw8RzxIPEccQ/xHHF0eSHxHHFWkLhYjrgGFvkI8RxxkBkh4jni3ljkVcRzxCXFc8QVxXPEIwno98MibyqeI+6EQw6mPwLqh1AsarJx6BvFCBwrniMeTUE4xY6GMckYAK5xa+4=",
[108781]="eNr7X8/A8H8Q4GjxHHFkjC6vJZ4jbomESTXfVTxH3B0Jk+NGH6heTzL1x1Cof6TjVPEccT/xHHFXMsMPpt+NQv0eZOqPFc8R94HiwRKmAKKQbFw=",
[108782]="eNrVkjEKwkAURBch2FiIhS+lnVew1GCCIFiZKJo2EHDukIsLCcHfuWm22hRTPR58Zn7fOddHkD1iifhuf/HxAyJHlPzzkW0QC4Tz8CPiau5rwk/thsTDb4iHuVP+DrFGrDy8Mu9tiaHzmJIhTogCUQf0M/7FGfFEfAL8i/1GG7jNHdHMcNcBQDRiXQ==",
[108783]="eNr7X8/A8H8Q4HDxHHEQjhDPESdHf5R4jnikeI54HIX6U8nUnyKeI55Npt5RPIoHCgMAgvV4Qg==",
[109293]="eNr7X8/A8H8I4WTxHPFE8RxxSvQPJf+O4lFMSwwAxTR8iw==",
[110312]="eNr7X8/A8H+I4TTxHPGh5uZRPIoHIwYADbZ9kg==",
[108786]="eNr7X8/A8H8IYFFxBXE+cQVxNnEFcVZxBXFK9LOQoX8Uj+LhiAF0E3Tr",
[108787]="eNr7X8/A8H8QYCZxBXE2JEyqfiFxBXEpJEyqfkky9FBT/ygexQOBAWQ0ctY=",
[109301]="eNr7X8/A8H8UM3wXZhehRP9rYXYRJhHKzBjJ+Iowu8hHCuLglDC7yAthdhFGMuNgvzC7yB1hdpFvZLphozC7yFmoG/4LD510AACHQnW0",
[109814]="eNr7X8/A8H8Uj+Jhjn8Ls4tQov+cMLsIowj5ZiwSZhc5JMwuwiBCmTuojQFZZ3lg",
[110326]="eNr7X8/A8H+IYAYRdpEvwuwiz4XZRSgxh0WEMv2jeBQPFwwA12d6sQ==",
[110327]="eNr7X8/A8H8Q4C3C7CKbhdlFNgqzi6wSZhchVf8tYXaRm8LsIjeE2UWukqH/izC7yEco/oBF/2ao+2AYXZ5JhF2EAQmjy18XZhc5KswuAvLnEjLcN4pHMS0wANowbj4=",
[109817]="eNr7X8/A8H8Uj+JBjp8Ks4tQon+RMLvIUWF2kSfC7CLfyDArS5hdpEuYXWSZMLvITjL0ewiziyQLs4vUCLOL9FPoF2piAIs7dS8=",
[110328]="eNrtzqENwmAAROEKknMk8F7ZAMECCBIEFoOrQKCQhAEwOBwbsASDMAZzlJCgyF9LEBXP3GeuPVdV+0c9iXfi9z4lDohD4qzg7x7EC3Fd8Jo4Jo6Ik4LfiAfiirgs+Jy4+Pim4HvijrglNh1+JJ6I147/fX2/7gViYGGy",
[110329]="eNrl0CEKw0AURdFRfQt4dzeVXU3JAqpCRE1lITKiKrpUdg9RJcspTKkIDMO4MYERVx0+D34cQog76GSxdbTIvbO4WFwt7gU/W6Tl3lvcLEaLR8E/Fmm5/zcni9niVfCvRVruq8XT4m2xFLz1DtT9pPa+1X4PEGUT",
[110330]="eNr7X8/A8H8Q4G/C7CKU6P9CoX4WEcr0j+JRPBQxAHb1fA8=",
}
-- stage.py places this inside a private do-block with `depthPages` and `depthBalls`.
-- No walk engine, combat-time addon load or guessed water height is needed.
local floor, min = math.floor, math.min
local cached, decoded
local function finite(v)
	return not (issecretvalue and issecretvalue(v)) and type(v) == "number" and v > -math.huge and v < math.huge
end
local function inflate(page)
	local e = C_EncodingUtil
	if not (e and e.DecodeBase64 and e.DecompressString and Enum and Enum.CompressionMethod) then return end
	local bytes = e.DecodeBase64(page)
	return bytes and e.DecompressString(bytes, Enum.CompressionMethod.Zlib)
end
-- Returns the largest requested tolerance proved here (at most 5 yd); nil
-- outside coverage. False means a relevant page was unreadable: no arrival.
function Nav.StaticSubmergedGoal(map, x, y, z, radius)
	if not (finite(map) and finite(x) and finite(y) and finite(z) and finite(radius) and radius > 0) then return end
	radius = min(radius, 5)
	local balls = depthBalls[map]
	if balls then
		for i = 1, #balls do
			local b = balls[i]
			local dxy = (x-b[1])^2 + (y-b[2])^2
			if z >= b[4] and z <= b[5] and dxy <= b[6]^2 then
				-- Allow a hundredth-yard guard for map-frame round trips, by
				-- shrinking the arrival sphere, never enlarging the evidence.
				local reach = min(radius, 4.99)
				if dxy + (z-b[3])^2 <= (5-reach)^2 then return reach end
			end
		end
	end
	local pages = depthPages[map]
	if not pages then return end
	local r, c = 4096-x/(25/6), 4096-y/(25/6)
	if not (r >= 0 and r < 8192 and c >= 0 and c < 8192) then return end
	local R, C = floor(r), floor(c)
	-- Do not pick a nominal cell in the tolerated source-frame discrepancy.
	if r-R < .01 or r-R > .99 or c-C < .01 or c-C > .99 then return end
	local page = pages[floor(R/16)*512+floor(C/16)]
	if not page then return end
	if page ~= cached then
		local ok, s = pcall(inflate, page)
		if not ok or type(s) ~= "string" or #s ~= 1024 then return false end
		cached, decoded = page, s
	end
	local k = 4*((R%16)*16+C%16)+1
	local a,b,h,i = decoded:byte(k,k+3)
	local low, high = a+b*256, h+i*256
	if low == 32767 then return end
	if low >= 32768 then low = low-65536 end
	if high >= 32768 then high = high-65536 end
	if z*8 >= low and z*8 <= high then return radius end
end

end

-- Local nonwalk depth readout; no routing data or SavedVariables.
do
local envelopes = {
[0] = {
[44389154] = {280.25,290.5},
[44389155] = {280.25,290.5},
[44389156] = {278.125,290.5},
[44389157] = {275.625,290.5},
[44397346] = {280.25,290.5},
[44397347] = {280.25,290.5},
[44397348] = {278.125,290.5},
[44397349] = {275.625,290.5},
[44405538] = {280.25,290.5},
[44405539] = {280.25,290.5},
[44405540] = {278.125,290.5},
[44405541] = {275.625,290.5},
[44413730] = {280.25,290.5},
[44413731] = {280.25,290.5},
[44413732] = {278,290.5},
[44413733] = {276,290.5},
[44454690] = {280.875,290.5},
[44454691] = {280.875,290.5},
[44454692] = {280.5,290.5},
[44454693] = {281.125,290.5},
[44454698] = {282.125,290.5},
[44454699] = {282.125,290.5},
[44454700] = {282.75,290.5},
[44454701] = {283.625,290.5},
[44462882] = {280.875,290.5},
[44462883] = {280.875,290.5},
[44462884] = {280.5,290.5},
[44462885] = {281.125,290.5},
[44462890] = {282.125,290.5},
[44462891] = {282.5,290.5},
[44462892] = {283.125,290.5},
[44462893] = {284.125,290.5},
[44462898] = {290.25,290.5},
[44471074] = {280.875,290.5},
[44471075] = {280.875,290.5},
[44471076] = {280.5,290.5},
[44471077] = {281.125,290.5},
[44471082] = {282.125,290.5},
[44471083] = {282.5,290.5,-5552.4,-3379.5,281.8,281.763,290.555,0.05},
[44471084] = {283.125,290.5},
[44471085] = {284.125,290.5},
[44471090] = {289.5,290.5},
[44479266] = {280.875,290.5},
[44479267] = {280.875,290.5},
[44479268] = {280.625,290.5},
[44479269] = {281.125,290.5},
[44479274] = {282.125,290.5},
[44479275] = {282.5,290.5},
[44479276] = {283.125,290.5},
[44479277] = {284.125,290.5},
[44479282] = {288.75,290.5},
[44479283] = {289.75,290.5},
[44520226] = {282.625,290.5},
[44520227] = {283,290.5},
[44520228] = {283,290.5},
[44520229] = {283,290.5},
[44520234] = {282.375,290.5},
[44520235] = {282.125,290.5},
[44520236] = {282.625,290.5},
[44520237] = {283.375,290.5},
[44520242] = {284.375,290.5},
[44520243] = {284.5,290.5},
[44520244] = {285.5,290.5},
[44520245] = {286.875,290.5},
[44528418] = {282.625,290.5},
[44528419] = {283,290.5},
[44528420] = {283,290.5},
[44528421] = {283,290.5},
[44528426] = {282.375,290.5},
[44528427] = {282.125,290.5},
[44528428] = {282,290.5},
[44528429] = {282.5,290.5},
[44528434] = {283.125,290.5},
[44528435] = {283.25,290.5},
[44528436] = {284.125,290.5},
[44528437] = {285.5,290.5},
[44536610] = {282.625,290.5},
[44536611] = {283,290.5},
[44536612] = {283,290.5},
[44536613] = {283,290.5},
[44536618] = {282.375,290.5},
[44536619] = {282.125,290.5},
[44536620] = {282,290.5},
[44536621] = {281.75,290.5},
[44536626] = {281.875,290.5},
[44536627] = {281.875,290.5},
[44536628] = {282.875,290.5},
[44536629] = {284.25,290.5},
[44544802] = {282.625,290.5},
[44544803] = {283,290.5},
[44544804] = {283,290.5},
[44544805] = {283,290.5},
[44544810] = {282.375,290.5},
[44544811] = {282.125,290.5},
[44544812] = {282,290.5},
[44544813] = {281.75,290.5},
[44544818] = {281.125,290.5},
[44544819] = {281.125,290.5},
[44544820] = {281.25,290.5},
[44544821] = {283.125,290.5},
},
}
-- Private local readout, never a path, bearing, floor or reason to descend.
-- In the enclosed native halos the base terrain bounds only veto. The client's
-- own movement and draining breath timer attest the *present* submerged pose;
-- neither proves that the base phase, or a passage to the pin, is active.
local function plain(v)
	return not (issecretvalue and issecretvalue(v))
end
local function finite(v)
	return plain(v) and type(v) == "number" and v > -math.huge and v < math.huge
end
local function flag(fn, unit, wanted)
	local ok, v
	if unit then ok, v = pcall(fn, unit) else ok, v = pcall(fn) end
	return ok and plain(v) and v == wanted
end
local breathMax
local function reset() breathMax = nil end
ns.RegisterEvent("MIRROR_TIMER_START", function(_, timer, value, cap, scale, paused)
	if not plain(timer) then return reset() end
	if timer ~= "BREATH" then return end
	breathMax = finite(value) and finite(cap) and cap >= value and value > 0 and finite(scale) and scale < 0
		and plain(paused) and (paused == false or paused == 0) and cap or nil
end)
ns.RegisterEvent("MIRROR_TIMER_STOP", function(_, timer)
	if not plain(timer) or timer == "BREATH" then reset() end
end)
-- A new draining START must establish breath again. Ignore unsupported events;
-- none of these negative notifications establishes a positive phase or pose.
for _, event in ipairs({"MIRROR_TIMER_PAUSE", "PLAYER_ENTERING_WORLD", "PLAYER_LEAVING_WORLD", "ZONE_CHANGED_NEW_AREA", "PLAYER_CONTROL_LOST", "PLAYER_DEAD", "PHASE_SHIFT_CHANGED"}) do
	ns.RegisterEvent(event, reset)
end
local readGoal = Nav.StaticSubmergedGoal
function Nav.StaticSubmergedGoal(map, x, y, z, radius)
	local reach = readGoal(map, x, y, z, radius)
	if reach == false or not (finite(map) and finite(x) and finite(y) and finite(z) and finite(radius) and radius > 0) then return reach end
	local rows = envelopes[map]
	if not rows then return reach end
	local r, c = 4096-x/(25/6), 4096-y/(25/6)
	if r < 0 or r >= 8192 or c < 0 or c >= 8192 then return reach end
	local R, C = math.floor(r), math.floor(c)
	local b = rows[R*8192+C]
	if not b or r-R < .01 or r-R > .99 or c-C < .01 or c-C > .99 then return reach end
	local ok, version, build = pcall(GetBuildInfo)
	if not (ok and plain(version) and plain(build) and version == "1.60.1" and (build == "70532" or build == 70532)) then return reach end
	if reach then return reach, b end -- keep the original tolerance, supply a body veto
	if not b[3] or z < b[6] or z > b[7] then return end
	local dxy = (x-b[3])^2 + (y-b[4])^2
	local small = math.min(radius, 4.99)
	if dxy <= b[8]^2 and dxy + (z-b[5])^2 <= (5-small)^2 then return small, b, true end
end
function Nav.WaterBoundaryPose(C, bounds, z, xy2)
	-- A 1.5 yd local horizontal query plus a 1 yd body envelope fits well
	-- inside the 5x5 native halo even at a centre-cell edge. Above the maximum
	-- bed+.54, below the minimum surface-3.05 (upright body/head); never use a
	-- liquid surface/nearby mesh floor in place of the actual player's height.
	if not bounds or not z or xy2 > 2.25 or z < bounds[1]+.5 or z > bounds[2]+4 or not breathMax then return end
	local ok, ms = pcall(GetMirrorTimerProgress, "BREATH")
	if not (ok and finite(ms) and ms > 0 and ms <= breathMax) then return end
	local valid, faction = pcall(C.GetPlayerFaction)
	if not valid or not plain(faction) or (faction ~= "Alliance" and faction ~= "Horde") then return end
	-- Positive immersion plus static transport/deck vetoes. A missing required
	-- movement read never enables a new cue or a new point completion.
	if not flag(IsSwimming, nil, true) or not flag(UnitOnTaxi, "player", false)
		or not flag(IsMounted, nil, false) or not flag(IsFalling, nil, false)
		or not flag(UnitIsDeadOrGhost, "player", false) then return end
	if UnitInVehicle and not flag(UnitInVehicle, "player", false) then return end
	local T = ns.Transit
	if not T or not flag(T.Carried, nil, false) then return end
	return ms
end

end
