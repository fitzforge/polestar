-- Walking paths: the arrow follows real paths on the ground instead of a
-- straight line, from Polestar's walking router in the load-on-demand addon
-- Polestar_Nav, started from the walking engine of Shortest Path Forever by
-- Cillian Berragan (https://github.com/cjber/shortest-path-forever, GPL-3.0-or-later).
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever v1.16.0, Journey/JourneySearch.lua's goal batch, GPL-3.0-or-later); adapted for Polestar, 2026-10-16.
--
-- The travel planner (Travel.lua) picks flights, rides, the Hearthstone and
-- teleports; the walks into the target are priced by one reversed
-- Path.FindMany per target from here (Walk.Measure, below), the others by
-- straight-line estimates. Here the
-- walk the arrow is on right now (the player to the current walk leg's end,
-- or to the target) is searched asynchronously with Path.Find on the
-- player's continent; once the path arrives the arrow aims at its next point.
-- Straying more than STRAY yards from it (asked again at most every ASK_EVERY
-- seconds, ASK_FAR_EVERY on a walk of more than ASK_FAR yards), or a new goal, asks again (a stale
-- search is cancelled); nothing is asked for in combat, nor while something
-- the game gives no taxi for carries the player (Transit.Carried: the
-- skycutter from Zephras Isle to Dalaran, a search a second would start from
-- a point the ride has left; one under way when the ride is seen is dropped):
-- asked once, when the player is off. The arrow's own search
-- is urgent (sliced before the later legs' searches), and a path that lands
-- after the player has walked on is followed from their place on it
-- (Follow.Catch), not from where it was asked. Hand-made walks win:
-- a crossing, an approach chain past its mouth (Travel's leg.handmade), and a
-- guide goal after a guide `goto` (the author's way in, a cave mouth) keep
-- the straight arrow, as does a player who switches walking routes off.
-- A routed walk with no ground answer yet supplies no compass bearing. One
-- whose search found no walk (off the walking map, no maps there, a capital's
-- floor out of reach, a corpse run's checked detour) points straight at its
-- goal, as before 0.4.2, and says why under the label; its line is drawn
-- straight (Nav.Sample's noWalk, Nav.CanDrawGroundApproach, #3409). Enemy
-- ground refuses no walk (0.4.2.1). A failed search is asked again FAIL_RETRY
-- seconds after it failed once the player stands FAIL_MOVED yards (the router's
-- ARRIVE) from where it was asked: 0.4.2 asked again only 25 yards away. A
-- refusal no policy made (no blockedReason: the router's departure rule, a
-- line it could not check) is asked again once FAIL_AGAIN seconds later,
-- moved or not (#3448: beside Llane Beshere in Northshire Abbey the first
-- walk to the next goal was refused and the player standing there waited 15 s
-- and more for a walk).
-- Every later walk leg is sketched at once (Path.FindCoarse, its border
-- crossings), then searched once after it (Walk.LegPath), for the route
-- lines and its price; the arrow's own walk is drawn by its sketch until its
-- path is in. Walks on another continent than the player's are neither
-- measured nor searched until its walking maps are in memory (canSearch: a
-- continent's part of Polestar_Nav loads when the player gets there); until
-- then they keep the planner's straight estimates.
--
-- Baked legs: a guide step whose walk was routed at build time (Nav/Baked.lua,
-- a race part's Legs.lua) needs no search: for a new goal that the current
-- step's leg ends at, with the player within STRAY yards of the leg, the
-- arrow follows the leg from the player's place on it (takeBaked). Straying
-- from it (more than STRAY yards, with no point ahead on it in sight across
-- open ground: Nav/Follow.lua) asks for a search as from any path (the re-plan); a goal the leg
-- does not end at (a walk leg's end before a flight, a hand-set target) is
-- searched as before.
--
-- Floors: a goal at the target's point carries the target's height (a guide
-- goal at an NPC or object: its spawn's z, Nav.GetTargetWorld) to Path.Find,
-- so the path ends on that floor (an Undercity quarter, not the street
-- above); a walk leg's end with a height of its own (a dock's board point on
-- a pier deck, a tram, zeppelin or portal end's floor, Nav/Travel.lua)
-- carries that one, so the walk ends on the deck or at the tram's entrance,
-- not in the water under it or on the roof above it. The search with the
-- height takes the router's reach (city.GOAL: when no walk reaches the floor
-- itself, the nearest surface on its level within 10 yd that one reaches) and
-- its answer stands, one ending off the floor too (the walk asked again
-- without the height ends on whichever floor is cheapest at the spot); the
-- arrow says when it ends short of the floor (Walk.Unmapped).
-- One that finds no walk at all is asked once more without the height (the
-- maps miss the floor's join: a walk to the spot beats the straight arrow),
-- said too. A hand-set target has no height: searched as before. In the six
-- capitals a goal never loses its height (the trail floor at it when it has
-- none: "The six capitals", below).
--
-- The player's floor (#234, Ruling 36): Forever's client gives no player
-- height (Compat reads its 0 as none), and a search from a point without one
-- starts from the cheapest surface within a cell of it: a roof, rock top,
-- bridge or upper floor above the player. So Walk follows the height of the
-- surface under the player as they move: from Walk.Aim, at most every EVERY
-- (0.25) seconds, reading the cell's surfaces (Path.SurfacesAt, into one
-- reused table: nothing is allocated) only after moving MOVE (1) yard.
--   Seed (the floor unknown): the cell's surfaces all within ZTOL (10, the
--     router's: it stands on them alike): the lowest of them. Else, when the
--     client says whether the player is indoors (Compat.IsIndoors) and the
--     surfaces differ in it (an indoor or indoor city class against the
--     rest), indoors the indoor ones when they lie within ZTOL: off the
--     Undercity's lifts, the city under Tirisfal's outdoor ground. Outdoors
--     says nothing (a city's streets and gates are of the indoor city class
--     under the open sky: Stormwind's over its canal, Ironforge's gate under
--     the mountain). Never to override a followed floor (a doorway can
--     disagree for a moment).
--   Candidates (seed cannot tell: the Undercity, every cell with indoor
--     layers more than ZTOL apart): each surface read (indoors: the indoor
--     ones) is a floor the player may be on; each follows the surface within
--     ZTOL of it at every read, and one with none there two reads in a row is
--     gone. While any are followed they decide (not seed). One left: the
--     floor. A few dozen yards on the Trade Quarter's ring rule out the
--     entrance hall above it. Indoors, until then, a search from the player
--     starts only on the candidate floors (Path.Find's from.floors): the
--     canal ring keeps canal and walkway under every step, never the roofs.
--   Named: on a map whose surfaces carry their area (Path.AreaFormat: each
--     WMO group's WMOAreaTable row), the surfaces the client's subzone names
--     (Compat.GetZoneText; each row's name in the client's language: the
--     language folder's Subzones.lua, Names kind "subzone", else the row's
--     English name, Path.AreaName) are the floor at once when they lie
--     within ZTOL, before seed and the candidates, and they correct a
--     followed floor on another level. A subzone two levels share, or none,
--     leaves it to movement.
--   Follow: the surface nearest the floor, never more than RISE (4) yards
--     above it (a ramp or stairs at mount speed, plus a jump) nor more than
--     DROP (60) below it; a smaller drop is a fall. Deeper is a narrow deck's
--     cell the maps leave out (Darkcloud Pinnacle's rope bridges over the
--     canyon, #374), handled as no surface. None (a cell with no surface
--     from DROP below the floor to RISE above it: a blocked cell at a
--     cliff's foot, one whose only surface is the ridge above, a deck's
--     cell over a canyon): the floor is kept while the player is within KEEP (25,
--     the router's snap reach) yards of where it was last on a surface, so a
--     search from there starts on the ground walked in on, not on a ridge
--     the router snaps to without a height (#1650: beside the Stonewrought
--     Dam that ridge joins only Grim Batol, a 5,600 yd walk through the
--     Wetlands for 400 along the dam); farther: unknown. On a bridge
--     (Polestar_Nav's bridge chokepoints: within the radius of the line
--     between its sides), of the same surfaces the one nearest the deck's
--     height, not the floor's: a covered bridge's roof or rail a yard or two
--     above the bank is no floor (#1784, Silverpine's bridge north-east of
--     the Sepulcher).
--   Unknown again: another continent; more than JUMP (30) yards since the
--     last read (a hearth, teleport, landing, loading screen); moving NEAR
--     (5) yards or more after more than FRESH (2) seconds without a check
--     (nearer, the floor is followed from where it was read: the last steps
--     before a stop the arrow said Arrived at, a hand-in or a fight, are no
--     loss of it, #3448); on a taxi, a transport
--     (Transit.Riding, Transit.Carried) or within LIFT (8) yards of a lift (Transit.LiftNear:
--     it changes level without moving); a ghost state change; a read that
--     raises an error.
--   Decoding: the read never decodes. A cell whose cluster is not decoded
--     reads nil and the router decodes it under its frame budget
--     (Path.Prefetch, as a search's clusters; not in combat); meanwhile the
--     floor is kept, checked but not read again, so JUMP and NEAR still
--     count from where it was last read, and it is followed from there once
--     the cluster is in. The router keeps that one cluster decoded at rest
--     until Path.ReleaseSurfaces: the target cleared (Walk:OnTarget) or no
--     Walk.Aim for FRESH seconds (Walk:Refresh); never on Walk.Clear alone (a
--     style change, a level-up, a hand-made walk: the arrow goes on).
-- The arrow's search starts from the client's height when it gives one, else
-- from the floor when it is known, checked within FRESH seconds and read
-- within NEAR (5) yards of the player; a search with it that finds nothing is
-- asked once more without it, keeping the goal's height (Z2 still drops the
-- goal's, keeping the start as it was). The player's place in Walk.Measure
-- takes the same height. Unknown: in a capital the floor the trails or an NPC
-- beside the player say (below), else searched without a height, as before; and
-- when the floor then becomes known within REASK (5) seconds of that search
-- (an arrival: login, hearth, a landing; ambiguous ground walked off), asked
-- once more with it (Ruling 36b), once per such search, never in combat.
--
-- Steps: the walk is split at the lifts Nav/Transit.lua knows, and keeps the
-- crossings, approach chains and guide gotos the planner already makes legs
-- of. Gates, bridges, tunnels, passes, lift landings and cave or building
-- mouths come from Polestar_Nav's PolestarNavChokepoints (Nav/Chokepoints.lua,
-- generated by `nav pack`); without it, the lifts Nav/Transit.lua knows.
--
--   Walk.Aim(pc, px, py, gc, gx, gy, handmade, gz, stop) -> c, wx, wy, left | nil
--     where to point for walking from the player to (gc, gx, gy; gz: its
--     height, else the target's when it is the target's point): Nav/Follow.lua's
--     aim along the path (the furthest point within 35 yd of the player and
--     45 yd along it, sliding between points, stopped at a corner, another
--     floor and `stop`, a piece of a split walk's chokepoint's spot on the path
--     (its stop); outdoors, beside the path in open ground up to
--     100 yd from it, the furthest point ahead up to 150 yd along it the
--     player can walk to straight, Path.Sight checking the line); and the
--     yards left along the path from the
--     player's place on it plus their way to it (through the point in sight
--     when the arrow aims at one); nil = straight at the goal.
--     Allocation-free once the path is in. Strays more than STRAY yards off
--     the path ask for a new one, unless the aim is such a point in sight.
--   Walk.Progress(c, x, y) -> along, off | nil: at the last Aim for that goal,
--     the yards along the path from its start to the player's place on it,
--     and the yards between the player and that place
--   Walk.SightAim() -> c, wx, wy | nil: the last Aim's point when it was in
--     sight beside the path (the route line's walk starts toward it)
--   Walk.LastAim() -> c, wx, wy | nil: the last Aim's point, whatever it was
--     (the route line's walk starts toward it when the player is far off it)
--   Walk.Left(c, x, y) -> yards left along the path to that goal at the last Aim | nil
--   Walk.Passed(c, x, y, seg) -> the player is past segment `seg` of that goal's path
--   Walk.Stops(pc, px, py) -> stops, total: the chokepoints along the path
--   Walk.Split(): Travel.SplitWalk at them (on each path, and after a fresh plan);
--     with none, the walk leg takes the path's yards and time, and goes back
--     to its straight estimate when the path fails or is cleared (Travel.RestoreWalk)
--   Walk.Searches(c) -> true when the arrow's own walk on continent c is
--     searched (the engine on and its maps there)
--   Walk.Probe(pc, px, py, gx, gy, gz, callback) -> job | nil: one search for the
--     planner, apart from the arrow's own (Travel's near walk over a closed zone
--     border, #1543): callback(along, sx, sy) or callback(false); Walk.CancelProbe(job)
--   Walk.FollowsGoto(target) -> true when the guide's last located goal before
--     this target is a `goto` the player has reached (Engine.GoalDone)
--   Walk.Clear()
--   Walk.Measure(c, x, y, water, places, goalZ): measure the walks into that target
--     from the planner's places (one FindMany; Travel.Remeasured when in)
--   Walk.Measured(c, x, y, water, goalZ) -> walkCost(c, wx, wy, start, fromZ) -> cost, yards | false | nil, or nil
--   Walk.LegPath(from, to) -> yards along that later walk's searched path, its hubs | nil
--   Nav.GetRouteGeometry() -> { legs = { { kind, pts = { { c, wx, wy }, ... },
--     current, choke }, ... } } or nil without a target or while handed off
--     (Nav.HandedOff); NAV_ROUTE_GEOMETRY on change.
--     kind: walk | flight | boat | zeppelin | airship | tram | portal | hearth | teleport | lift.
--
-- Every search goes with opts { waterWalking, profile, style, danger }: the
-- player's faction (Compat.GetPlayerFaction; none when neutral or unread),
-- the Route style option (nav.routeStyle: "fastest", "balanced" (the default)
-- or "roads"; the router reads anything else as Balanced) and the zones far
-- above the player's level (Nav/Danger.lua's table at the player's level,
-- without the walk's own start and goal zones, Path.ZoneAt), so the router
-- prices each step by its ground in that style (roads cheaper, slopes and
-- indoors dearer), the other faction's towns twenty times over and a step
-- into a dangerous zone three or twenty times. A change of style, or a level-up
-- (PLAYER_LEVEL_UP), drops the arrow's path, the measures and the later
-- walks' paths, and re-plans at once (Walk:OnSettings, searchAgain): every
-- walk is searched and measured again in it. The router's cost chooses (the
-- planner's walkCost); every distance and time shown comes from yards: the
-- arrow's walk from its path's points (the drawn line, Find's job.yards), a
-- later walk from Find's job.yards, a measured walk from FindMany's
-- job.yards[i] (the no-profile path's yards per graph edge: low for a walk
-- that goes round a hostile town inside one cluster). Find's job.hubs, the
-- hostile towns the drawn line enters, go to the walk's leg (leg.hubs:
-- Travel.SplitWalk for the arrow's walk, every piece of a split one; Travel.PricePaths for later ones).

local ADDON, ns = ...
local Nav = ns.Nav

local type, ipairs, pcall = type, ipairs, pcall
local sqrt, huge, abs = math.sqrt, math.huge, math.abs

local Walk = {}
Nav.walk = Walk

ns.RegisterDefaults("nav", { navRouting = true, routeStyle = "balanced" })

local PACK = "Polestar_Nav"
local STRAY = 25            -- yards off the path: ask again
local JOIN = 50             -- yards from a path's start: its first turn there, outdoors, is joining a road (Nav/Follow.lua)
local ASK_EVERY = 2         -- seconds between asks for the same goal
local ASK_FAR, ASK_FAR_EVERY = 2000, 10 -- yards left along the path past which a stray is asked again at most this often
local GOAL_MOVED = 1        -- yards: the goal is another one
local FAIL_RETRY, FAIL_MOVED, FAIL_AGAIN = 15, 5, 2 -- a failed search is asked again this late, this far away; a refusal for no policy reason once this soon
local Z_OFF = 30            -- yards: a path ending this far above or below the goal's height missed its floor

---------------------------------------------------------------------------
-- The engine (Polestar_Nav's API.lua hands it over as Polestar_NavEngine)
---------------------------------------------------------------------------

local loadTried = false
local styleSeen             -- nav.routeStyle the searches were made in (nil until the first settings pass)

local function inCombat()
	local C = ns.Compat
	if C and C.InCombat then return C.InCombat() end
	return InCombatLockdown ~= nil and InCombatLockdown() and true or false
end

-- Load Polestar_Nav once (at login or later, never in combat: loading builds
-- about 26 MB of packed map strings), and never while Shortest Path Forever
-- guides instead (Nav/Handoff.lua): it walks its own maps.
local function load()
	if Nav.Path or loadTried then return end
	if inCombat() or Nav.HandedOff() then return end
	loadTried = true
	if ns.Data and ns.Data.Pack then pcall(ns.Data.Pack, PACK) end
	local P = _G.Polestar_NavEngine
	if type(P) == "table" and type(P.Find) == "function" and type(P.Cancel) == "function" then
		Nav.Path = P
	end
end

local function engine()
	if not ns.Get("nav.navRouting") or Nav.HandedOff() then return nil end
	return Nav.Path
end

-- May the router search walks on continent c now? Its maps are in memory
-- (Path.Resident: Polestar_Nav's own, or the continent's part addon loaded),
-- or c is the player's continent: its part loads with the first search there.
-- A walk on another continent keeps the planner's straight estimate until the
-- player gets there, so Polestar holds one continent's walking maps at a time.
local function canSearch(P, c)
	if P.Available and not P.Available(c) then return false end
	if not P.Resident or P.Resident(c) then return true end
	local C = ns.Compat
	return C and C.GetPlayerWorldPosition and C.GetPlayerWorldPosition() == c or false
end

-- Will the arrow's own walk on continent c be searched (the engine loaded and
-- on, its maps there)? Travel offers the near walk over a closed zone border
-- only then (Travel.NearWalk).
function Walk.Searches(c)
	local P = engine()
	return P ~= nil and c ~= nil and canSearch(P, c)
end

-- The router's options (Routing/Path.lua): water walking (a ghost), the
-- player's faction (Compat.GetPlayerFaction: nil when neutral or unread),
-- the route style (nav.routeStyle, as saved: the router reads an unknown one
-- as Balanced) and the danger table (Nav.danger.Table at Nav.danger.Level,
-- without the zones (Nav.danger.ZoneAt) of the walk's start (sx, sy) and
-- goal (tx, ty) on map; nil for either leaves no zone out there), so each
-- step is priced for them: roads cheaper, slopes and indoors dearer, the
-- other faction's towns twenty times over, a zone far above the player three
-- or twenty times. The separate hard policy applies to the whole walk,
-- including its start, goal and connectors; being inside a hub never waives it.
local function opts(water, map, sx, sy, tx, ty)
	local C = ns.Compat
	local profile = C and C.GetPlayerFaction and C.GetPlayerFaction() or nil
	local D = Nav.danger
	local level = D and D.Level()
	local danger = level and D.Table(level, D.ZoneAt(map, sx, sy), D.ZoneAt(map, tx, ty)) or nil
	return { waterWalking = water and true or false, profile = profile, style = ns.Get("nav.routeStyle"), danger = danger, walkLevel = level or 0 }
end

---------------------------------------------------------------------------
-- The current walk
---------------------------------------------------------------------------

local gc, gx, gy             -- the goal searched for (nil: none)
local gzFor                  -- the target's height when that goal was taken (targetZ; false: none)
local gz                     -- the height searches still send (nil: none, or dropped after a miss)
local token                  -- the live search's identity
local job                    -- its Cancel handle
local sketchJob              -- its shape's (Path.FindCoarse) Cancel handle
local ptsX, ptsY, ptsZ = {}, {}, {} -- the path, reused (z false where unknown)
local hubs                   -- the other faction's towns the path enters (Find's job.hubs; nil: none)

-- Find's answer as the walk's hostile-town list: job.hubs, the towns the path enters, with job.avoided, the ones it
-- goes round, as hubs.avoided (display only; the walk's leg carries both); nil when the walk has neither.
local function hubsOf(a)
	if type(a) ~= "table" then return nil end
	local h, v = a.hubs, a.avoided
	local entered = type(h) == "table" and #h > 0
	local avoided = type(v) == "table" and #v > 0
	if not (entered or avoided) then return nil end
	h = entered and h or {}
	if avoided then h.avoided = v end
	return h
end
local left = {}              -- left[i] = yards from point i to the end of the path
local lastLeft               -- yards left along the path at the last Aim
local count = 0              -- points in the path (0: none yet)
local idx = 1                -- the end point of the segment the player is on (Nav/Follow.lua)
local fstate = {}           -- the follower's state (Nav/Follow.lua's Follow.Step)
-- [chokepoint entry] = true: passed on this goal's walk (Walk.Stops). (A field, not a local: the file's main chunk keeps
-- clear of Lua 5.1's 200 locals.)
Walk.dropped = {}
local wanted = false         -- a search is owed (deferred in combat)
local landX, landY           -- the path just in was searched from here: Walk.Aim catches the follower up to the player (Follow.Catch)
local askedAt = -huge
local failed = false
local failAt, failX, failY = 0, 0, 0
local failAgain = false -- false: the goal's quick re-ask (FAIL_AGAIN) unused; true: owed; nil: spent
local shape                  -- the live search's abstract route ({ xs, ys, n }; Find's coarse), drawn until the path is in
local geomVersion = 0
local pumpLegs              -- searches the route's later walks (below)
local pumpShapes            -- draws the route's later walks' abstract routes at once (below)
local release               -- lets the router drop the floor's cluster (below, "The walking floor")
local city                  -- the capitals' floor rules (below, "The six capitals")

-- A search's points as flat lists for drawing: xs, ys, n (points with x and y) and the yards along them.
local function line(points)
	local xs, ys, n, yards = {}, {}, 0, 0
	for i = 1, #points do
		local p = points[i]
		if type(p) == "table" and p.x and p.y then
			n = n + 1
			xs[n], ys[n] = p.x, p.y
			if n > 1 then
				local dx, dy = xs[n] - xs[n - 1], ys[n] - ys[n - 1]
				yards = yards + sqrt(dx * dx + dy * dy)
			end
		end
	end
	return xs, ys, n, yards
end

local function changed()
	geomVersion = geomVersion + 1
	ns.Fire("NAV_ROUTE_GEOMETRY")
end

local function dropSketch()
	if sketchJob then
		local P = Nav.Path
		if P then pcall(P.Cancel, sketchJob) end
		sketchJob = nil
	end
end

local function cancel()
	token = nil
	if job then
		local P = Nav.Path
		if P then pcall(P.Cancel, job) end
		job = nil
	end
	dropSketch()
end

-- The walk the path measured goes back to its straight estimate (Travel.RestoreWalk).
local function restore(c, x, y)
	local T = Nav.travel
	if c and T and T.RestoreWalk then T.RestoreWalk(c, x, y) end
end

function Walk.Clear()
	local had, c, x, y = gc ~= nil, gc, gx, gy
	cancel()
	gc, gx, gy, gzFor, gz, count, idx, wanted, failed, hubs, shape = nil, nil, nil, nil, nil, 0, 1, false, false, nil, nil
	Walk.blockedReason = nil
	Walk.checkedOnly, ptsX.checkedPolicy = nil, nil
	city.goal, city.dropped = nil, nil
	city.Note(false)
	landX, landY = nil, nil
	for k in pairs(Walk.dropped) do Walk.dropped[k] = nil end
	Nav.follow.Reset(fstate)
	if had then
		restore(c, x, y)
		changed()
	end
end

-- see: the line check (sight, below) to smooth the path with once (Nav/Follow.lua Follow.Smooth), or nil.
local function took(points, see)
	local n = 0
	local detail, boarding
	for i = 1, #points do
		local p = points[i]
		if type(p) == "table" and p.x and p.y then
			n = n + 1
			ptsX[n], ptsY[n], ptsZ[n] = p.x, p.y, type(p.z) == "number" and p.z or false
			if p.boarding and p.rideFrom == points[i-1] then
				boarding = boarding or {}
				boarding[n] = p.boarding
			end
			if p.detail then
				if not detail then detail = {} end
				detail[n] = true
			end
		end
	end
	ptsX.detail, ptsX.absoluteDry, ptsX.boarding = detail, points.absoluteDry, boarding
	if see and not points.absoluteDry then n = Nav.follow.Smooth(ptsX, ptsY, ptsZ, n, see, not (IsIndoors and IsIndoors())) end
	for i = n + 1, count do ptsX[i], ptsY[i], ptsZ[i] = nil, nil, nil end
	count = n
	left[n + 1] = nil
	if n > 0 then
		local dx, dy = gx - ptsX[n], gy - ptsY[n]
		left[n] = sqrt(dx * dx + dy * dy)
		for i = n - 1, 1, -1 do
			dx, dy = ptsX[i + 1] - ptsX[i], ptsY[i + 1] - ptsY[i]
			left[i] = left[i + 1] + sqrt(dx * dx + dy * dy)
		end
	end
	idx, shape = 1, nil
	Nav.follow.Reset(fstate)
	Nav.follow.Mark(ptsX, ptsY, ptsZ, left, n, fstate)
	landX, landY = nil, nil
end

-- The player's height, when the client gives it on this continent (picks the
-- floor), through Compat's one player-position gate.
local function playerZ(pc)
	local C = ns.Compat
	if not (C and C.GetPlayerUnitPosition) then return nil end
	local ok, _, _, z, instance = pcall(C.GetPlayerUnitPosition)
	if ok and instance == pc and type(z) == "number" then return z end
	return nil
end

---------------------------------------------------------------------------
-- The walking floor (#234, Ruling 36): Forever gives no player height, so
-- the height of the surface under the player is followed as they move
-- (Path.SurfacesAt), from Walk.Aim. The rules are in the header ("The
-- player's floor").
---------------------------------------------------------------------------

local RISE = 4        -- yards a reading may climb above the floor: a ramp or stairs at mount speed, plus a jump
local MOVE = 1        -- yards moved before the surfaces are read again
local EVERY = 0.25    -- seconds between checks
local JUMP = 30       -- yards between checks: a hearth, a teleport, a landing, a loading screen
local FRESH = 2       -- seconds: a floor checked longer ago is not used (and moving NEAR yards after such a gap loses it)
local NEAR = 5        -- yards from where the floor was read: farther, it is not used
local KEEP = 25       -- yards from where the floor was last on a surface that it is kept over cells with none to follow (the router's SNAP 6 cells of 4.2 yd)
local ZTOL = 10       -- Routing/PathGrid.lua's ZTOL: surfaces this close the router stands on alike
local LIFT = 8        -- yards from a lift (Transit.LiftNear): it changes level without moving
local INDOOR = 2      -- Path.SURFACE_INDOOR

local surf = {}       -- Path.SurfacesAt's out, reused
local surfArea = {}   -- Path.SurfacesAt's areas (each surface's WMOAreaTable row id, 0: none), reused
local areaNames = {}  -- WMOAreaTable row id -> its name in the client's language (false: none), read once each
local isNamed = {}    -- per surface of the last read: its area is the client's subzone (named), reused
local floorZ          -- the floor's height (nil: unknown)
local cand, candMiss, candN = {}, {}, 0 -- while the floor is unknown and seed cannot tell: the floors the player may be on, and reads each has missed (reused)
local candIndoor = false  -- the candidates are the indoor surfaces (the client said indoors): the player is on one of them
local fC, fX, fY, fAt, fGhost = nil, 0, 0, -huge, false -- the last check: continent, point read, time, ghost
local onX, onY = 0, 0     -- where the known floor was last on a surface of a read (KEEP counts from there)
local aimAt               -- GetTime of the last Walk.Aim (nil: the reader's cluster released)
local flatAt              -- GetTime of the last ask sent without a start height (nil: none owed a re-ask)
local floorAsk = false    -- the floor became known soon after that ask: ask once more with it (Ruling 36b)
local REASK = 5           -- seconds after a flat ask within which a floor found re-asks

-- The six capitals (Fitz, 2026-11-18: "cities perfectly mapped so that pathing is flawless in there"): a walk there
-- never starts or ends without a height, and never asks again without its goal's. Their streets, plazas and bridges
-- float 11-38 yd over the ground they were built on (Stormwind, Orgrimmar) or run under the mountain (Ironforge), so a
-- search without a height starts or ends on whichever surface is cheapest at the spot: 33-66% of recorded city walks
-- searched so started or ended on another floor, or walked the ground under the streets. (A table, not locals: the
-- main chunk keeps clear of Lua 5.1's 200.)
--   city.At(c, x, y): (x, y) on c lies in a capital (Travel.ZoneOf's zone; Here: the player's, read again after MOVE yd)
--   city.Hint(P, c, x, y): where the walking floor has none, the floor there: the trail floor (Path.TrailFloor, the
--     surface most walked within TRAIL yd, from the recordings: 3+ people) on the level of the NPC beside the player
--     (Nav/NpcFloor.lua: talked to, targeted or in a nameplate within 15 s, its spawn within 30 yd), else the trail
--     floor, else that NPC's height; nil with none. Outside the capitals (no trail layer there): a flight's landing's
--     height, else the NPC whose window the player just opened (NpcFloor.Talked: Booty Bay's docks, huts and bank
--     stack 4-6 floors, #2215). The floor follow seeds on the read
--     surface nearest it (city.Pick, within ZTOL, on a candidate floor when any are followed); a search from the
--     player starts from it (startZ, city.Start: read again after MOVE_HINT yd or EVERY s).
--   A goal there without a height (a map click, a place) ends on the trail floor within TRAIL yd of it (city.GoalZ).
--   A goal with a height, anywhere, is searched with Path.Find's reach (GOAL yd): when no walk reaches its own floor
--     (a platform the maps don't join, #2860: Daryl Riknussun's in the Great Forge), the walk ends at the nearest
--     surface on its level within GOAL yd that one reaches, and the arrow says the last steps aren't mapped
--     (Walk.Unmapped). In a capital, none: the straight arrow, saying so, never the walk asked again without the
--     height (it went out of Ironforge's gate and over the mountain: 3,515 yd for a 356 yd walk), and the target's
--     walk is not marked unreachable (Travel.WalkUnreachable would plan round it); the planner's measure into such a
--     target (Walk.Measure) takes the same reach and, finding nothing, keeps the straight estimates. Elsewhere none
--     is asked once more without the height (city.dropped: said too), as are the measure and the later legs.
city = { CAPITAL = { [1453] = true, [1454] = true, [1455] = true, [1456] = true, [1457] = true, [1458] = true },
	TRAIL = 4, GOAL = 10, MOVE = 20, MOVE_HINT = 1, noteVersion = 0 }

-- (The Undercity lies under Tirisfal Glades: the zone a point there reads is Tirisfal's, 1420, so a point in the
-- Undercity's own map frame, Compat.WorldToMap on 1458, counts too. CityLifts2, 2026-11-18: none of the rules ran
-- there. Only the Undercity: the other capitals' frames reach over their zones' ground, the zone tells them.)
function city.At(c, x, y)
	if not (c and x and y) then return false end
	local T = Nav.travel
	local zone = T and T.ZoneOf and T.ZoneOf(nil, c, x, y)
	if zone ~= nil and city.CAPITAL[zone] == true then return true end
	local C = ns.Compat
	if zone ~= 1420 or not (C and C.WorldToMap) then return false end
	local mx, my = C.WorldToMap(c, x, y, 1458)
	return mx ~= nil and my ~= nil and mx >= 0 and mx <= 100 and my >= 0 and my <= 100
end

function city.Here(c, x, y)
	local dx, dy = x - (city.hx or huge), y - (city.hy or huge)
	if c ~= city.hc or not (dx * dx + dy * dy <= city.MOVE * city.MOVE) then
		city.hc, city.hx, city.hy, city.hin = c, x, y, city.At(c, x, y)
	end
	return city.hin
end

-- A flight's landing (the player was on a taxi, seen at a check, or took one: TakeTaxiNode, and is not now; checked
-- at every floor read and when control comes back, PLAYER_CONTROL_GAINED): the floor is the height of the flight
-- point it landed at (Travel's node.z: TravelData's taxiZ, TaxiNodes' height), the nearest node within LAND yd; kept
-- LAND_SECONDS for city.Hint, within LAND yd of where the flight landed. Thunder Bluff's tower top (176.9) over the
-- ground (145.7) and the Undercity's bat platform over its ring are walked alike: the trails can't tell them.
city.LAND, city.LAND_SECONDS = 20, 30
function city.Landed(c, x, y)
	local C = ns.Compat
	local on = C and C.IsOnTaxi and C.IsOnTaxi() and true or false
	-- (a flight taken but not seen on: counted once the client has had TOOK seconds to put the player on it)
	local took = city.tookAt ~= nil and GetTime() - city.tookAt > city.TOOK
	if (city.onTaxi or took) and not on and c and x and y then
		city.tookAt = nil
		city.landC, city.landX, city.landY, city.landAt, city.landZ = c, x, y, GetTime(), nil
		city.sAt = nil -- (city.Start's hint read again)
		local data = Nav.GetTravelData and Nav.GetTravelData() -- (once per landing)
		local best = city.LAND * city.LAND
		for _, n in ipairs(data and data.taxi or {}) do
			if n.c == c and type(n.z) == "number" then
				local dx, dy = n.wx - x, n.wy - y
				local d = dx * dx + dy * dy
				if d <= best then best, city.landZ = d, n.z end
			end
		end
	end
	if on then city.tookAt = nil end
	city.onTaxi = on
end
city.TOOK, city.FLOWN = 5, 100
-- Control lost and given back 100+ yd away (a flight: the client may not say on-taxi at either event) is a landing too.
ns.RegisterEvent("PLAYER_CONTROL_LOST", function()
	local C = ns.Compat
	if C and C.IsOnTaxi and C.IsOnTaxi() then city.onTaxi = true end
	if C and C.GetPlayerWorldPosition then city.lostC, city.lostX, city.lostY = C.GetPlayerWorldPosition() end
end)
ns.RegisterEvent("PLAYER_CONTROL_GAINED", function()
	local C = ns.Compat
	if not (C and C.GetPlayerWorldPosition) then return end
	local c, x, y = C.GetPlayerWorldPosition()
	if city.lostX and c and x and y then
		local dx, dy = x - city.lostX, y - city.lostY
		if c ~= city.lostC or dx * dx + dy * dy > city.FLOWN * city.FLOWN then city.onTaxi = true end
	end
	city.lostC, city.lostX, city.lostY = nil, nil, nil
	if city.onTaxi or city.tookAt then city.Landed(c, x, y) end
end)
if hooksecurefunc and TakeTaxiNode then hooksecurefunc("TakeTaxiNode", function() city.tookAt = GetTime() end) end

function city.LandZ(c, x, y)
	if city.landZ == nil or c ~= city.landC or GetTime() - city.landAt > city.LAND_SECONDS then return nil end
	local dx, dy = x - city.landX, y - city.landY
	if dx * dx + dy * dy > city.LAND * city.LAND then return nil end
	return city.landZ
end

-- (with a landing's or an NPC's height, the trail floor only within RISE of it: the trails' busiest level within ZTOL
-- can be another one, the Undercity's ring 5 yd under Harbinger Balthazad's platform)
function city.Hint(P, c, x, y)
	local F = Nav.npcFloor
	if not city.Here(c, x, y) then return city.LandZ(c, x, y) or (F and F.Talked and F.Talked(c, x, y)) or nil end
	local nz = city.LandZ(c, x, y) or (F and F.Near and F.Near(c, x, y)) or nil
	if P and P.TrailFloor then
		local ok, tz = pcall(P.TrailFloor, c, x, y, city.TRAIL, nz)
		if ok and type(tz) == "number" and not (nz and abs(tz - nz) > RISE) then return tz end
	end
	return nz
end

-- The hint for a search from the player (startZ): read again after MOVE_HINT yd or EVERY s.
function city.Start(c, x, y)
	local now = GetTime()
	local dx, dy = x - (city.sx or huge), y - (city.sy or huge)
	if c ~= city.sc or now - (city.sAt or -huge) > EVERY or not (dx * dx + dy * dy <= city.MOVE_HINT * city.MOVE_HINT) then
		city.sc, city.sx, city.sy, city.sAt = c, x, y, now
		city.sz = city.Hint(Nav.Path, c, x, y)
	end
	return city.sz
end

-- In a capital, a followed floor's start height for a search: the trail floor within SETTLE yd of it when there is
-- one (TrailFloor near it), else the floor. Leffe's maps can hold a pocket surface a few yards under the floor people
-- walk (the Undercity's Trade Quarter: -47 under the walkway at -43, walked by 2 players against 75); the follower
-- stays on what it reads, the search starts where the walk goes. Read again after MOVE_HINT yd or EVERY s.
city.SETTLE = 5
function city.Settle(c, x, y, z)
	local now = GetTime()
	local dx, dy = x - (city.tx or huge), y - (city.ty or huge)
	if c ~= city.tc or z ~= city.tz or now - (city.tAt or -huge) > EVERY or not (dx * dx + dy * dy <= city.MOVE_HINT * city.MOVE_HINT) then
		city.tc, city.tx, city.ty, city.tz, city.tAt, city.tOut = c, x, y, z, now, z
		local P = Nav.Path
		if P and P.TrailFloor and city.Here(c, x, y) then
			local ok, tz = pcall(P.TrailFloor, c, x, y, city.TRAIL, z)
			if ok and type(tz) == "number" and abs(tz - z) <= city.SETTLE then city.tOut = tz end
		end
	end
	return city.tOut
end

function city.GoalZ(P, c, x, y)
	if not (P and P.TrailFloor) then return nil end
	local ok, tz = pcall(P.TrailFloor, c, x, y, city.TRAIL)
	return ok and type(tz) == "number" and tz or nil
end

-- The arrow's walk ends short of its goal (or found none): said under the arrow (Walk.Unmapped).
function city.Note(on, approachZ)
	city.approachZ = approachZ
	if not on then city.partialAskX, city.partialAskY = nil, nil end
	on = on and true or nil
	if city.note ~= on then
		city.note = on
		city.noteVersion = city.noteVersion + 1
	end
end

-- A shaft in a capital has fixed trail levels as well as moving decks.
function city.Lift(pc, px, py)
	local now = GetTime()
	if pc ~= city.liftC or px ~= city.liftX or py ~= city.liftY or now - (city.liftAt or -huge) >= EVERY then
		local X = ns.Transit
		city.liftC, city.liftX, city.liftY, city.liftAt = pc, px, py, now
		city.lift = city.Here(pc, px, py) and X and X.LiftNear and X.LiftNear(pc, px, py, LIFT) ~= nil or false
	end
	return city.lift
end

-- On a taxi, a transport (Transit.Riding, or one the game gives no taxi for: Transit.Carried) or at a lift: the floor
-- can change without walking.
local function carried(pc, px, py)
	local C, X = ns.Compat, ns.Transit
	if C and C.IsOnTaxi and C.IsOnTaxi() then return true end
	if X and ((X.Riding and X.Riding()) or (X.Carried and X.Carried())) then return true end
	return X and X.LiftNear and X.LiftNear(pc, px, py, LIFT) ~= nil or false
end

-- Water is a floor only to a swimmer (#2215, Booty Bay): the docks' deck (8) lies 8 yd over the bay's water surface
-- (0), within ZTOL, so seed took the lowest, the water, and the follow kept it under the piers and decks all the way
-- up to Fleet Master Seahorn's floor (29): the plan sent the player "Through the pass to Booty Bay" from beside him.
-- Of the n surfaces read, those of the kind the client says (Compat.IsSwimming: water while swimming, else dry), when
-- any are; a ghost walks on water (either). -> the count kept, the read compacted.
local function wet(n, ghost)
	if ghost or n < 2 then return n end
	local C = ns.Compat
	local swim = C and C.IsSwimming and C.IsSwimming() and 1 or 0
	local k = 0
	for i = 1, n do
		if surf[-i] % 2 == swim then k = k + 1 end
	end
	if k == 0 or k == n then return n end
	k = 0
	for i = 1, n do
		if surf[-i] % 2 == swim then
			k = k + 1
			surf[k], surf[-k], surfArea[k] = surf[i], surf[-i], surfArea[i]
		end
	end
	return k
end

-- An unknown floor from the n surfaces read: their height when they lie
-- within ZTOL (the lowest); else, when the client says the player is indoors
-- and the surfaces differ in it, the indoor ones (an indoor or indoor city
-- class) when they lie within ZTOL; else nil. Outdoors says nothing: a city's
-- streets and gates are of the indoor city class under the open sky
-- (Stormwind's Trade District over its canal, Ironforge's gate under the
-- mountain), so the one outdoor surface there is the ground below or above.
local function seed(n)
	if n == 0 then return nil end
	local lo, hi = huge, -huge
	for i = 1, n do
		local z = surf[i]
		if z < lo then lo = z end
		if z > hi then hi = z end
	end
	if hi - lo <= ZTOL then return lo end
	local C = ns.Compat
	if not (C and C.IsIndoors and C.IsIndoors()) then return nil end
	local mlo, mhi, other = huge, -huge, false
	for i = 1, n do
		local z = surf[i]
		if surf[-i] % (2 * INDOOR) >= INDOOR then
			if z < mlo then mlo = z end
			if z > mhi then mhi = z end
		else
			other = true
		end
	end
	if other and mhi >= mlo and mhi - mlo <= ZTOL then return mlo end
	return nil
end

-- The deck's height when (x, y) on continent c is on a bridge, else nil: a bridge of Polestar_Nav's chokepoints
-- (PolestarNavChokepoints[c], kind "bridge"), within its radius of the line between its two sides (of its point when
-- it has no sides). Read in place: nothing is allocated.
local function bridgeDeck(c, x, y)
	local list = type(_G.PolestarNavChokepoints) == "table" and _G.PolestarNavChokepoints[c]
	if type(list) ~= "table" then return nil end
	for i = 1, #list do
		local e = list[i]
		if type(e) == "table" and e.kind == "bridge" and e.wx and e.wy and e.z then
			local r = e.r or 5
			local s = e.sides
			local ax, ay, bx, by = e.wx, e.wy, e.wx, e.wy
			if type(s) == "table" and s[1] and s[2] and s[1].wx and s[2].wx then
				ax, ay, bx, by = s[1].wx, s[1].wy, s[2].wx, s[2].wy
			end
			local dx, dy = bx - ax, by - ay
			local len2 = dx * dx + dy * dy
			local t = len2 > 0 and ((x - ax) * dx + (y - ay) * dy) / len2 or 0
			if t < 0 then t = 0 elseif t > 1 then t = 1 end
			local ex, ey = ax + dx * t - x, ay + dy * t - y
			if ex * ex + ey * ey <= r * r then
				-- A rope deck can pitch and sag. Its midpoint is not the walking floor at either bank.
				if len2 > 0 and s[1].z and s[2].z then
					if t < 0.5 then return s[1].z + 2 * t * (e.z - s[1].z) end
					return e.z + (2 * t - 1) * (s[2].z - e.z)
				end
				return e.z
			end
		end
	end
	return nil
end

-- A known floor from the n surfaces read: the one nearest it, never more
-- than RISE above it and never more than DROP below it (a smaller drop is a
-- fall); none: nil (track keeps the floor within KEEP yards of where it was
-- last on a surface). DROP (60) is the walking grid's deepest fall, and only
-- into water (its FALL_MAX_WATER; dry falls stop at FALL_MAX 30). A read whose
-- only surface lies deeper is a cell the walking maps leave out of a narrow
-- deck, not a fall the player walked off:
-- Darkcloud Pinnacle's rope bridges are one or two cells wide over a canyon
-- 115 yd below (Thousand Needles, #374, #1936). The arrow's own line there
-- crosses a cell with only the canyon floor (-4825,-1917), and the follow
-- dropped onto it and kept the canyon under the rest of the bridge: from
-- the bridge the walk to Lakota Windsong went back down the ramp and up
-- again, 1,118 yd for 412. On a bridge (deck:
-- its height, bridgeDeck) with a surface the follow may take within RISE of
-- the deck, the one nearest the deck instead (#1784): a covered bridge's
-- roof or side rail a yard or two above the bank it is walked onto from is
-- no floor. Silverpine's bridge north-east of the Sepulcher, walked onto
-- from the bank at 60: the roof's edge at 62 was nearer than the deck at
-- 56, and the arrow's walk from the roof turned back to the bank. Under the
-- bridge (the river, a road), with no such surface, the floor is followed
-- as anywhere else. Indoors (the client says so), a surface of neither indoor
-- nor indoor city class more than ZTOL below the floor is no fall either: it
-- is the ground a building was built over, the room's floor missing from the
-- maps (Stormwind's Gilded Rose: walked in from the street at 97, its cells
-- hold only the ground at 59, and the walk to the harbour from there found
-- none); the floor is kept as over a cell with none (KEEP).
local function follow(n, deck)
	local ref, low = floorZ, floorZ - 60 -- (DROP: a local here, the main chunk keeps clear of Lua 5.1's 200)
	local C = ns.Compat
	local inside = C and C.IsIndoors and C.IsIndoors()
	if deck then
		for i = 1, n do
			local z = surf[i]
			if z <= floorZ + RISE and z >= low and abs(z - deck) <= RISE then
				ref = deck
				break
			end
		end
	end
	local best, gap = nil, huge
	for i = 1, n do
		local z = surf[i]
		local buried = inside and z < floorZ - ZTOL and surf[-i] % (2 * INDOOR) < INDOOR
		if not buried and z <= floorZ + RISE and z >= low and abs(z - ref) < gap then best, gap = z, abs(z - ref) end
	end
	return best
end

-- Whether surface i of the read may be where the player stands, by what the client says of indoors: only indoors is
-- evidence (an indoor or city surface); outdoors is none, as a city's open streets are city class (Stormwind's).
local function fits(i, indoors)
	return not indoors or surf[-i] % (2 * INDOOR) >= INDOOR
end

-- Where seed cannot tell (the Undercity: every cell has indoor layers more than ZTOL apart), the floor is found by
-- walking: each surface of the first read (those matching indoors, when any do) is a candidate, and at each read every
-- candidate follows the surface nearest it within ZTOL (the router stands on such surfaces alike: a seed of -48 beside
-- -43 is the street at -43 too). A candidate with no surface there
-- for MISSES reads in a row is gone (the real floor may miss one read: a fall, a step between reads); candidates
-- within ZTOL merge. The one left is the floor; none left: unknown, and the next read starts again. -> it, or nil.
local MISSES = 2
local function candidates(n)
	local C = ns.Compat
	local indoors = C and C.IsIndoors and C.IsIndoors()
	if candN == 0 then
		local any = false
		for i = 1, n do
			if fits(i, indoors) then any = true end
		end
		for i = 1, n do
			local z, near = surf[i], false
			for j = 1, candN do
				if abs(cand[j] - z) <= ZTOL then near = true end
			end
			if not near and (not any or fits(i, indoors)) then
				candN = candN + 1
				cand[candN], candMiss[candN] = z, 0
			end
		end
		candIndoor = any and indoors and true or false
		return nil
	end
	local kept = 0
	for j = 1, candN do
		local c, miss, best, gap = cand[j], candMiss[j], nil, huge
		for i = 1, n do
			local z = surf[i]
			if abs(z - c) <= ZTOL and abs(z - c) < gap and fits(i, indoors) then best, gap = z, abs(z - c) end
		end
		if best then
			miss = 0
		else
			best, miss = c, miss + 1
		end
		local merged = false
		for k = 1, kept do
			if abs(cand[k] - best) <= ZTOL then
				merged = true
				if miss < candMiss[k] then cand[k], candMiss[k] = best, miss end
			end
		end
		if not merged and miss < MISSES then
			kept = kept + 1
			cand[kept], candMiss[kept] = best, miss
		end
	end
	for j = kept + 1, candN do cand[j], candMiss[j] = nil, nil end
	candN = kept
	-- One left, and on a surface of this read (not one riding out a miss).
	if candN == 1 and candMiss[1] == 0 then
		local z = cand[1]
		candN, cand[1], candMiss[1] = 0, nil, nil
		return z
	end
	return nil
end

-- Forget the candidates (the floor is lost, or found by seed).
local function dropCandidates()
	for j = 1, candN do cand[j], candMiss[j] = nil, nil end
	candN, candIndoor = 0, false
end

-- The floor the client names: of the n surfaces read, those whose area (the WMO group's WMOAreaTable row, maps with
-- areas: Path.AreaFormat) is named as the client's subzone (the Undercity's "The Canals", its quarters, the "Ruins of
-- Lordaeron" hall over them), when they lie within ZTOL: the lowest. nil when the map has no areas, the client names
-- no subzone, or no surface or surfaces on several floors match (an area shared by two levels: movement decides).
-- A row's name in the client's language (#2244): the language folder's (Names kind "subzone": Subzones.lua, the rows
-- not named as in English), else its English one (Path.AreaName). Read once each, but not while the language folder
-- is still to load (refused in combat: Names.Ready), whose name would be the English one until it does.
local function named(P, pc, n)
	if not (P.AreaFormat and P.AreaFormat(pc)) then return nil end
	local C = ns.Compat
	local sub = C and C.GetZoneText and select(2, C.GetZoneText())
	if not sub then return nil end
	local lo, hi = huge, -huge
	for i = 1, n do
		local id = surfArea[i]
		isNamed[i] = false
		if id and id ~= 0 then
			local name = areaNames[id]
			if name == nil then
				local N = ns.Names
				name = N and N.Get("subzone", id) or P.AreaName and P.AreaName(pc, id) or false
				if not (N and N.Localised() and not N.Ready()) then areaNames[id] = name end
			end
			if name == sub then
				isNamed[i] = true
				local z = surf[i]
				if z < lo then lo = z end
				if z > hi then hi = z end
			end
		end
	end
	if lo == huge then return nil end
	if hi - lo > ZTOL then return nil, true end
	return lo
end

-- The subzone names surfaces on several levels (the Undercity's hall at 62 and its gallery at 74, both "Ruins of
-- Lordaeron"; the Trade Quarter's ring, walkway and canal): the candidate floors are kept to those levels (seeded from
-- them when none is), so the planner and the searches from the player know at least which part of the city it is.
local function restrict(n)
	local kept = 0
	for j = 1, candN do
		local c, ok = cand[j], false
		for i = 1, n do
			if isNamed[i] and abs(surf[i] - c) <= ZTOL then ok = true end
		end
		if ok then
			kept = kept + 1
			cand[kept], candMiss[kept] = c, candMiss[j]
		end
	end
	for j = kept + 1, candN do cand[j], candMiss[j] = nil, nil end
	candN = kept
	if candN == 0 then
		for i = 1, n do
			if isNamed[i] then
				local z, near = surf[i], false
				for j = 1, candN do
					if abs(cand[j] - z) <= ZTOL then near = true end
				end
				if not near then
					candN = candN + 1
					cand[candN], candMiss[candN] = z, 0
				end
			end
		end
	end
	candIndoor = true
end

-- A followed floor more than TALK_OFF yd off the height of the NPC whose window the player has just opened (within
-- FRESH s of it, once per window: NpcFloor.Talked, its spawn within 10 yd; a window opens only within interact range
-- of it): the read surface nearest that height within RISE of it, else nil. Where floors stack (Booty Bay's docks,
-- piers, stairs and huts, #2215), walking up a ramp over a deck that runs on under it keeps the follow on the deck:
-- beside Fleet Master Seahorn the floor followed from the docks stayed 20 yd under his, and the plan went "Through the
-- pass to Booty Bay". Talking to him puts it right. Anywhere, the capitals too. city.TalkNew: a window not yet looked
-- at (track reads the surfaces for it even standing still).
city.TALK_OFF = 6
function city.TalkNew(pc, px, py)
	local F = Nav.npcFloor
	if not (F and F.Talked) then return false end
	local tz, at = F.Talked(pc, px, py)
	return tz ~= nil and at ~= city.talkSeen and GetTime() - at <= FRESH
end
function city.Talk(pc, px, py, n)
	if not city.TalkNew(pc, px, py) then return nil end
	local tz, at = Nav.npcFloor.Talked(pc, px, py)
	city.talkSeen = at
	if abs(floorZ - tz) <= city.TALK_OFF then return nil end
	local best, gap = nil, RISE
	for i = 1, n do
		local d = abs(surf[i] - tz)
		if d <= gap then best, gap = surf[i], d end
	end
	return best
end

-- The floor unknown: of the n surfaces read, the one nearest the floor city.Hint gives here, within ZTOL
-- of it, on a candidate floor when any are followed; nil when none is (or no hint).
function city.Pick(P, pc, px, py, n)
	if n == 0 then return nil end
	local h = city.Hint(P, pc, px, py)
	if h == nil then return nil end
	local best, gap = nil, ZTOL
	for i = 1, n do
		local z = surf[i]
		local d = abs(z - h)
		if d <= gap then
			local on = candN == 0
			for j = 1, candN do
				if abs(cand[j] - z) <= ZTOL then on = true end
			end
			if on then best, gap = z, d end
		end
	end
	return best
end

-- An approach chain's node the player has reached with no height from the client (Nav/Travel.lua, Walk.AtNode): its
-- authored floor puts the followed one right, as an NPC's window does (city.Talk): the read surface nearest the node's
-- height within RISE of it, once, while the player stands within city.NODE yd of it (track reads the surfaces for it
-- even standing still). The chains lie where the walking maps fail: at Ban'ethil Barrow Den's mouth the follow, walked
-- up the entrance ramp, fell onto the hall 26 yd under the mouth and stayed there outside (#3449).
city.NODE = 8
function city.Node(pc, px, py, n)
	local z = city.nodeZ
	if z == nil then return nil end
	local dx, dy = px - city.nodeX, py - city.nodeY
	if pc ~= city.nodeC or dx * dx + dy * dy > city.NODE * city.NODE then
		city.nodeZ = nil
		return nil
	end
	local best, gap = nil, RISE
	for i = 1, n do
		local d = abs(surf[i] - z)
		if d <= gap then best, gap = surf[i], d end
	end
	if best ~= nil then city.nodeZ = nil end
	return best
end

local function track(P, pc, px, py)
	local now = GetTime()
	aimAt = now
	if pc == fC and now - fAt < EVERY then return end
	local dx, dy = px - fX, py - fY
	local d2 = dx * dx + dy * dy
	local T = Nav.travel
	local ghost = T and T.IsGhost and T.IsGhost() or false
	city.Landed(pc, px, py)
	local held = carried(pc, px, py)
	if held or pc ~= fC or ghost ~= fGhost or d2 > JUMP * JUMP or (d2 >= NEAR * NEAR and now - fAt > FRESH) then
		floorZ = nil
		dropCandidates()
	elseif d2 < MOVE * MOVE and city.nodeZ == nil and not (floorZ ~= nil and city.TalkNew(pc, px, py)) then
		fAt = now
		return
	end
	if held then
		fC, fX, fY, fAt, fGhost = pc, px, py, now, ghost
		return
	end
	-- Decoded clusters only: nil queues the cluster's decode under the router's
	-- frame budget (Path.Prefetch), and the floor is kept meanwhile, checked
	-- now but read where it was (so the JUMP and NEAR checks still count from
	-- there). An error is unknown.
	local ok, n = pcall(P.SurfacesAt, pc, px, py, surf, surfArea)
	if ok and n == nil then
		fC, fAt, fGhost = pc, now, ghost
		return
	end
	fC, fX, fY, fAt, fGhost = pc, px, py, now, ghost
	if ok then n = wet(n, ghost) end
	if not ok then
		floorZ = nil
		dropCandidates()
	elseif floorZ == nil then
		-- Candidates being followed decide (a cell whose one level is the hall above, the street missing under it,
		-- is no seed for a player followed on the street); else seed, and the candidates start where it cannot tell.
		-- The client's subzone first, where the map names each floor's area; else movement.
		local z, several = named(P, pc, n)
		if several then restrict(n) end
		if z ~= nil then
			floorZ = z
			dropCandidates()
		else
			-- The floor a landing, an NPC beside the player or (in a capital) the trails say, before movement: seed
			-- takes the lowest surface within ZTOL, the ground a street was built 2 yd over (Stormwind's Dwarven District).
			floorZ = city.Node(pc, px, py, n) or city.Pick(P, pc, px, py, n)
			if floorZ ~= nil then
				dropCandidates()
			elseif candN > 0 then
				floorZ = candidates(n)
			else
				floorZ = seed(n)
				if floorZ == nil then candidates(n) end
			end
		end
		-- (asked from the hint: re-asked only when the floor found is on another level)
		if floorZ ~= nil then
			onX, onY = px, py
			if flatAt and now - flatAt <= REASK and not (city.asked and abs(floorZ - city.asked) <= ZTOL) then flatAt, floorAsk = nil, true end
		end
		-- Still unknown, indoors: a path asked without a height that starts on no candidate floor left (the
		-- entrance hall over the Trade Quarter, ruled out a few steps on) is asked again from those left.
		if floorZ == nil and flatAt and candIndoor and count > 1 and type(ptsZ[2]) == "number" then
			local on = false
			for j = 1, candN do
				if abs(cand[j] - ptsZ[2]) <= ZTOL then on = true end
			end
			if not on then flatAt, floorAsk = nil, true end
		end
	else
		-- Known: followed, unless the client's subzone names another floor here (a floor found by elimination on
		-- the wrong level, or a fall the follow missed). A read with no surface to follow keeps the floor within
		-- KEEP yards of where it was last on one (a cliff's foot, a ridge-only cell, #1650); farther, unknown.
		local z = named(P, pc, n)
		if z ~= nil and abs(z - floorZ) > ZTOL then
			floorZ, onX, onY = z, px, py
		else
			local f = city.Node(pc, px, py, n) or city.Talk(pc, px, py, n) or follow(n, bridgeDeck(pc, px, py))
			if f ~= nil then
				floorZ, onX, onY = f, px, py
			else
				local ox, oy = px - onX, py - onY
				if ox * ox + oy * oy > KEEP * KEEP then floorZ = nil end
			end
		end
	end
end

-- (city.Node) Read at once, so the plan made on reaching the node starts on its floor.
function Walk.AtNode(c, x, y, z)
	city.nodeC, city.nodeX, city.nodeY, city.nodeZ = c, x, y, z
	local P, C = engine(), ns.Compat
	if P and P.SurfacesAt and C and C.GetPlayerWorldPosition then
		local pc, px, py = C.GetPlayerWorldPosition()
		if pc == c then
			fAt = -huge
			track(P, pc, px, py)
		end
	end
end

-- The router may drop the cluster the floor reads (at rest it keeps only
-- that one): no target, or no Walk.Aim for FRESH seconds.
release = function()
	aimAt = nil
	local P = Nav.Path
	if P and P.ReleaseSurfaces then pcall(P.ReleaseSurfaces) end
end

-- The tracked floor under (px, py) on pc: known, checked within FRESH
-- seconds and read within NEAR yards of it; else nil.
local function trackedZ(pc, px, py)
	if floorZ == nil or fC ~= pc or GetTime() - fAt > FRESH then return nil end
	local dx, dy = px - fX, py - fY
	if dx * dx + dy * dy > NEAR * NEAR then return nil end
	return floorZ
end

-- The height a walk from the player at (px, py) starts from: the client's,
-- else the tracked floor (in a capital, the trail floor within 5 yd of it:
-- city.Settle), else in a capital (not while candidate floors are
-- followed indoors: the search starts on them) the floor the trails or an NPC
-- beside the player say (city.Start); nil, tracked (any but the client's: a
-- search with it that finds nothing is asked once more without it), hinted.
local function startZ(pc, px, py)
	local z = playerZ(pc)
	if z ~= nil then return z, false, false end
	-- A trail describes a fixed floor, not the deck currently at this lift.
	if city.Lift(pc, px, py) then return nil, false, false end
	z = trackedZ(pc, px, py)
	if z ~= nil then return city.Settle(pc, px, py, z), true, false end
	if candN == 0 or not candIndoor then z = city.Start(pc, px, py) end
	return z, z ~= nil, z ~= nil
end

-- The follower's line check (Nav/Follow.lua `sight`): can the player at (x1, y1)
-- walk straight to the path point (x2, y2, z2: false where unknown), from the
-- height and on the continent Walk.Aim set (sightC, sightZ)? Path.Sight on
-- the walking grid, for the player's faction; false on an error, and while the
-- line crosses a cluster the router has not decoded (nil: it decodes nothing).
-- One function for every Aim, so passing it allocates nothing. With z1, from
-- that height instead: a path point's, when the path is smoothed as it is
-- taken (Follow.Smooth; sightC set to the path's continent first).
local sightC, sightZ
local aimC, aimX, aimY -- the arrow's aim at the last Aim, a point on the path (Walk.LastAim; Walk.SightAim while by sight)
local function sight(x1, y1, x2, y2, z2, z1)
	local P = Nav.Path
	local C = ns.Compat
	local profile = C and C.GetPlayerFaction and C.GetPlayerFaction() or nil
	local ok, clear = pcall(P.Sight, sightC, x1, y1, z1 or sightZ, x2, y2, z2 or nil, profile)
	return ok and clear == true
end

-- The follower's reach check (Nav/Follow.lua `reach`): sight's line over indoor and city ground too (Path.Sight's
-- walls: only walls, cliffs, floor changes, water and hostile towns block), from the floor Walk.Aim set, else from
-- z1 (the path's height at the player's place on it). A line the grid cannot tell (a cluster not decoded, an error)
-- is no wall: the aim stays as it was before 0.4.2.
function city.Walls(x1, y1, x2, y2, z1)
	local P = Nav.Path
	local C = ns.Compat
	local profile = C and C.GetPlayerFaction and C.GetPlayerFaction() or nil
	local ok, clear = pcall(P.Sight, sightC, x1, y1, sightZ or z1, x2, y2, nil, profile, true)
	if ok and clear == false then return false end
	return not Nav.danger.Blocked(sightC,x1,y1,x2,y2,profile)
end

-- While the floor is unknown indoors: the candidate floors (a new list) the player stands on one of, checked within
-- FRESH seconds and read within NEAR yards; nil otherwise. A search from the player starts only on surfaces near them
-- (Path.Find's from.floors): in the Undercity its canals and streets, never the roofs or the Ruins over them.
local function startFloors(pc, px, py)
	if floorZ ~= nil or candN == 0 or not candIndoor or fC ~= pc or GetTime() - fAt > FRESH then return nil end
	local dx, dy = px - fX, py - fY
	if dx * dx + dy * dy > NEAR * NEAR then return nil end
	local out = {}
	for j = 1, candN do out[j] = cand[j] end
	return out
end

-- While the floor is unknown indoors: the floors the player may be on (a new list, Nav/Travel.lua: a chain node with
-- a height holds the start when every one of them lies on its floor), or nil.
function Walk.Floors(pc, px, py)
	return startFloors(pc, px, py)
end

-- The player's floor at (px, py) on pc for the planner (Nav/Travel.lua: a crossing end with a height is reached
-- only on its floor): the client's height, else the tracked floor; nil while unknown.
function Walk.Floor(pc, px, py)
	return (startZ(pc, px, py))
end

-- The target's height when the goal (c, x, y) is the target's own point.
local function targetZ(c, x, y)
	local tc, tx, ty, tz = Nav.GetTargetWorld()
	if tz == nil or tc ~= c then return nil end
	local dx, dy = x - tx, y - ty
	if dx * dx + dy * dy > GOAL_MOVED * GOAL_MOVED then return nil end
	return tz
end

-- The height a measure into the target (c, x, y) is searched at: the target's, else in a capital the trail floor at it.
function city.MeasureZ(P, c, x, y, z)
	if z == nil and city.At(c, x, y) then z = city.GoalZ(P, c, x, y) end
	return z
end

-- The arrow says when the last steps aren't mapped: a reachable approach on a different floor, or no walk at the
-- requested height. The version changes when the note does (Nav/Arrow.lua).
function Walk.Unmapped()
	return gc ~= nil and city.note == true, city.noteVersion
end

-- A renderer can run before the first arrow sample. Never start a search from
-- here: only query whether this goal has a walking answer on its own floor.
-- nil: it has (or routing is off); "routing": its answer is still to come; else
-- why none was found ("unmapped": the arrow points straight and says so).
function Walk.GroundStatus(c, x, y, z)
	if not ns.Get("nav.navRouting") or Nav.HandedOff() then return nil end
	if not Nav.Path then return loadTried and "unmapped" or "routing" end
	if gc == c and gx and gzFor == (z or false) and (x-gx)^2 + (y-gy)^2 <= GOAL_MOVED^2 then
		if count > 0 then return nil end
		if Walk.blockedReason then return "unmapped" end
		if failed then return "unmapped" end
	end
	if Nav.Path.Available and not Nav.Path.Available(c) then return "unmapped" end
	return "routing"
end

-- A height miss that warrants retrying, not an intentional partial walk: dropping the goal height after the
-- router explicitly returned its nearest reachable approach would trade a known floor for an arbitrary one.
local function offFloor(points, z, answer)
	if type(answer) == "table" and answer.reached then return false end
	for i = #points - 1, 2, -1 do
		local pz = type(points[i]) == "table" and points[i].z
		if type(pz) == "number" then return abs(pz - z) > Z_OFF end
	end
	return false
end

-- flat: the retry without the tracked floor. A search with it that finds
-- nothing is asked again without it (the goal's height kept). A goal with a
-- height is searched with the router's reach (city.GOAL: the nearest surface
-- on its level a walk reaches), and its answer stands, one that ends off the
-- goal's floor too; one that ends short of the goal's floor, or none, is said
-- (city.Note). Outside the capitals a search that finds no walk at all is
-- asked once more without the goal's height (Z2, for good; said: its walk
-- ends on whichever floor the maps join there), the start as it was; in a
-- capital never (city). In a capital
-- a start height that finds nothing is asked first from the surfaces within
-- ZTOL of it (flat "floors": Path.Find's from.floors), then without it: the
-- height a trail or an NPC gave can be a counter's or a stall's top over the
-- floor beside it (Ironforge's vendors), and none at all starts on the
-- mountain over the city.
local function ask(P, pc, px, py, flat, terminal)
	wanted = true
	if inCombat() then return end -- after combat, on the next sample
	-- Carried (Transit.Carried: the skycutter to Dalaran): no walk from a point the ride leaves at once; on the
	-- first sample after it.
	local X = ns.Transit
	if X and X.Carried and X.Carried() then return end
	wanted = false
	askedAt, failed = GetTime(), false
	cancel()
	if P.Available and not P.Available(pc) then
		-- Routing is on but this continent has no walking map. A clear
		-- faction/level check alone cannot establish a line across it.
		Walk.blockedReason = "unmapped"
		failed, failAt, failX, failY = true, askedAt, px, py
		return
	end
	local mine = {}
	token = mine
	local ghost = Nav.travel and Nav.travel.IsGhost and Nav.travel.IsGhost() or false
	local z = gz
	local sz, tracked, hinted = startZ(pc, px, py)
	local floors
	if flat == "floors" and tracked and sz ~= nil then
		floors, sz, hinted = { sz }, nil, false
	elseif flat and tracked then
		sz, tracked, hinted = nil, false, false
	end
	-- The floor unknown indoors: from the candidate floors; a search with them that finds nothing is asked flat.
	if not floors then
		floors = sz == nil and not flat and startFloors(pc, px, py) or nil
		if floors then tracked = true end
	end
	-- The tracked start's retry: in a capital, from the surfaces near its height first.
	local retry = (not flat and sz ~= nil and city.Here(pc, px, py)) and "floors" or true
	-- A start without a height (not the retry that dropped the floor), or from a capital's hint, owes one re-ask once
	-- the floor is found (from the hint: on another level than it).
	floorAsk = false
	if (sz == nil or hinted) and not flat then flatAt = GetTime() else flatAt = nil end
	city.asked = hinted and sz or nil
	local inCity = z ~= nil and city.goal
	-- For a priced crossing, steer under the same journey policy as the verified
	-- approach. Its intermediate zone is not the destination's zone exemption.
	local o = type(Walk.checkedOnly) == "table" and Walk.checkedOnly or opts(ghost, pc, px, py, gx, gy)
	local to = { x = gx, y = gy, z = z, reach = z ~= nil and city.GOAL or nil }
	local ok, handle = pcall(P.Find, pc, { x = px, y = py, z = sz, floors = floors }, to, function(points, reason, answer)
		if token ~= mine then return end
		token, job = nil, nil
		dropSketch()
		local got = type(points) == "table" and #points > 0
		if Walk.checkedOnly and not (got and sz ~= nil and not flat and not city.dropped and type(answer) == "table"
			and answer.walkChecked == true and not answer.reached and reason ~= "no safe walking route") then
			-- A price for a detour doesn't authorize a bearing. Don't install a
			-- partial or a walk found on a substitute floor as its live path.
			got, reason = false, "no safe walking route"
		end
		if not got and reason == "no safe walking route" then
			if terminal and count > 0 then return end
			Walk.blockedReason = type(answer) == "table" and answer.blockedReason or "unmapped"
			-- No policy said no (the router's departure rule, a line it could not check): asked again once soon.
			if failAgain == false and not Walk.checkedOnly and not (type(answer) == "table" and answer.blockedReason) then failAgain = true end
			count, hubs, shape, failed, failAt, failX, failY = 0, nil, nil, true, GetTime(), px, py
			restore(gc,gx,gy)
			changed()
			pumpLegs()
			return
		end
		-- A final refinement supplements a completed search. A refusal cannot
		-- replace it with a partial or trigger the ordinary heightless retry.
		if terminal and not (got and points.absoluteDry and type(answer)=="table" and not answer.reached) then return end
		if tracked and not got then
			ask(P, pc, px, py, retry)
			return
		end
		if z and not got and not inCity then
			gz, city.dropped = nil, true
			ask(P, pc, px, py, flat)
			return
		end
		local approach = got and type(answer) == "table" and answer.reached
		city.Note(city.dropped or (z ~= nil and (not got or approach or offFloor(points, z))), type(approach) == "table" and approach.z or nil)
		if got then
			failed = false
			if P.Rush then P.Rush(false) end
			Walk.blockedReason = nil
			sightC = gc
			ptsX.checkedPolicy = Walk.checkedOnly and o or nil
			took(points, P.Sight and sight or nil)
			landX, landY = px, py -- searched from here: the player may be well on by now (Walk.Aim catches up)
			hubs = hubsOf(answer)
			if Walk.Split then Walk.Split() end
		else
			failed, failAt, failX, failY = true, GetTime(), px, py
			count, hubs, shape = 0, nil, nil
			restore(gc, gx, gy)
			-- No walk joins the player to the goal at all: a portal there may be out of reach (Travel.WalkUnreachable).
			-- Not a capital's goal at its height: the last steps are unmapped, the city is walked.
			local T = Nav.travel
			if reason == "unreachable" and not inCity and T and T.WalkUnreachable then T.WalkUnreachable(gc, gx, gy) end
		end
		changed()
		pumpLegs()
	end, o)
	if not ok then
		token = nil
		if terminal then return end
		if tracked then return ask(P, pc, px, py, retry) end
		if z and not inCity then
			gz, city.dropped = nil, true
			return ask(P, pc, px, py, flat)
		end
		city.Note(z ~= nil or city.dropped)
		failed, failAt, failX, failY = true, askedAt, px, py
		return
	end
	if token == mine then
		job = handle
		-- The walk the arrow is on goes before the later legs' searches (Routing/PathJobs.lua's urgent): while
		-- the player walks on, every frame it waits is yards it lands behind them.
		if type(handle) == "table" then handle.urgent = true end
	end
	-- No path yet: the walk's shape at once (Path.FindCoarse across clusters), drawn until the path is in. Urgent as
	-- the walk is: Routing/PathJobs.lua slices the urgent sketch first, so the shape is drawn a frame after the ask.
	if count == 0 and not shape and P.FindCoarse then
		local okShape, h = pcall(P.FindCoarse, pc, { x = px, y = py, z = sz }, to, function(points)
			if token ~= mine then return end
			sketchJob = nil
			if type(points) ~= "table" or count > 0 then return end
			local xs, ys, n = line(points)
			if n < 2 then return end
			shape = { xs = xs, ys = ys, n = n }
			changed()
		end, o)
		if okShape and token == mine then
			sketchJob = h
			if type(h) == "table" then h.urgent = true end
		end
	end
end

-- One search for the planner, apart from the arrow's own: Travel's near walk
-- over a closed zone border (#1543) is planned only once the engine finds that
-- walk short. From the player at (pc, px, py) to (gx, gy, gz: the target's
-- height, or nil), from the start height or floors and with the opts the
-- arrow's own search would take. A failed start-floor hint may be retried, but a
-- shortcut to a named floor must reach it, not a substitute in the same map
-- column. A policy refusal is final. `place`: from a place
-- on the route instead (the walk after a crossing, Travel.NearWalk), with its
-- authored originZ when known. Not urgent: the arrow's walk and the later legs
-- go first. callback(along, sx, sy, path) with the measured yards from the
-- first point to the goal, or callback(false) when none was found. `path`
-- is present only for a complete, checked walk from a known starting floor.
-- Called once. -> the job (Walk.CancelProbe), or nil when none was started (no
-- engine, the continent's maps not searchable, in combat).
function Walk.Probe(pc, px, py, gx, gy, gz, callback, place, originZ)
	local P = engine()
	if not (P and pc and canSearch(P, pc)) or inCombat() then return nil end
	local ghost = Nav.travel and Nav.travel.IsGhost and Nav.travel.IsGhost() or false
	local o = opts(ghost, pc, px, py, gx, gy)
	local sz, tracked = originZ, false
	if not place then sz, tracked = startZ(pc, px, py) end
	if not place and sz == nil and city.Lift(pc, px, py) then return callback(false) end
	local floors = not place and sz == nil and startFloors(pc, px, py) or nil
	local job = {}
	local to = { x = gx, y = gy, z = gz, reach = gz ~= nil and city.GOAL or nil }
	local function find(from, again)
		local ok, handle = pcall(P.Find, pc, from, to, function(points, reason, answer)
			if job.cancelled then return end
			job.handle = nil
			if reason == "no safe walking route" or (type(answer) == "table" and answer.reached) then return callback(false) end
			local water = Nav.travel and Nav.travel.IsGhost and Nav.travel.IsGhost() or false
			if water ~= ghost or o.style ~= ns.Get("nav.routeStyle") or o.profile ~= ns.Compat.GetPlayerFaction()
				or o.walkLevel ~= (Nav.danger.Level() or 0) then return callback(false) end
			local n = type(points) == "table" and #points or 0
			if again and n == 0 then return find({ x = px, y = py }) end
			local first, last = n > 0 and points[1], n > 0 and points[n]
			-- The same one-yard floor tolerance as a checked router transfer. A
			-- measure prices this walk; only a live XYZ reading can mark a visit.
			if type(first) ~= "table" or type(last) ~= "table"
				or (sz and (type(first.z) ~= "number" or not (abs(first.z - sz) <= 1)))
				or (gz and (type(last.z) ~= "number" or not (abs(last.z - gz) <= 1))) then return callback(false) end
			if floors then
				local matches = false
				for i = 1, #floors do
					if first.z and abs(first.z - floors[i]) <= 1 then matches = true break end
				end
				if not matches then return callback(false) end
			end
			local along, x, y = 0, px, py
			local checked = type(answer) == "table" and answer.walkChecked == true
			for i = 1, n do
				local q = points[i]
				if type(q) ~= "table" or type(q.x) ~= "number" or type(q.y) ~= "number" then return callback(false) end
				if i > 1 then
					local dx, dy = q.x - x, q.y - y
					along = along + sqrt(dx * dx + dy * dy)
				end
				x, y = q.x, q.y
			end
			-- Neither a connector from another start nor a straight tail to the
			-- requested end is part of the measured walk.
			if (px - first.x)^2 + (py - first.y)^2 > .02^2 or (gx - x)^2 + (gy - y)^2 > .02^2 then return callback(false) end
			-- The planner can compare this path with a crossing only if the
			-- original start floor survived the search, not a heightless retry.
			local complete = checked and sz ~= nil and from.z == sz and first.x == px and first.y == py and x == gx and y == gy
			callback(along, first.x, first.y, complete and points or nil)
		end, o)
		if not ok then
			if again then return find({ x = px, y = py }) end
			return callback(false)
		end
		job.handle = handle
	end
	find({ x = px, y = py, z = sz, floors = floors }, tracked or floors ~= nil)
	return job
end

function Walk.CancelProbe(job)
	if type(job) ~= "table" or job.cancelled then return end
	job.cancelled = true
	local P = Nav.Path
	if P and job.handle then pcall(P.Cancel, job.handle) end
	job.handle = nil
end

-- The current step's baked leg (Nav/Baked.lua) as the path to the goal just
-- taken, from the player's place on it: the nearest point of the leg, then
-- its points after that. Taken when the leg is on the player's continent,
-- ends within its tail plus BAKED_END of the goal, and the player is within
-- STRAY yards of a segment of it. With a height from the client the leg must
-- end on the goal's floor and the player's segment lie on theirs. With none
-- (Forever gives none) the leg is taken as 0.4.1.1 took it, without either
-- floor check: the tracked or a capital's trail floor is a guess, and a guess
-- that missed the leg sent that step's walk to a live search (Fitz, 0.4.2.1).
-- At a ship's boarding spot (Nav.GetTargetWorld's fifth value: a guide's boat
-- step walked to on the deck) a leg ending more than RISE under the deck was
-- baked to the guide's point without a height and ends in the sea below it
-- (Theramore's, Southshore's and the Forgotten Coast's: a deck lies within
-- ZTOL over its water): the search walks onto the deck instead.
local BAKED_END = 3 -- yards: a leg's end this much past its tail is another goal's
local function takeBaked(pc, px, py)
	local E = ns.Engine
	local step = E and E.GetStepIndex and E.GetStepIndex()
	local leg = step and Nav.BakedLeg and Nav.BakedLeg(step)
	if not (leg and leg.c == pc and leg.n >= 2) then return false end
	local n, xs, ys, zs = leg.n, leg.xs, leg.ys, leg.zs
	local ex, ey, reach = xs[n] - gx, ys[n] - gy, leg.left[n] + BAKED_END
	local sz = playerZ(pc)
	if ex * ex + ey * ey > reach * reach or (sz and gz and abs(zs[n] - gz) > ZTOL) then return false end
	if gz and zs[n] < gz - RISE and select(5, Nav.GetTargetWorld()) then return false end
	local best, bk, bt = huge, 1, 0
	for k = 1, n - 1 do
		local ax, ay = xs[k], ys[k]
		local dx, dy = xs[k + 1] - ax, ys[k + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = len2 > 0 and ((px - ax) * dx + (py - ay) * dy) / len2 or 0
		if t < 0 then t = 0 elseif t > 1 then t = 1 end
		local qx, qy = ax + dx * t - px, ay + dy * t - py
		local d = qx * qx + qy * qy
		if d < best and (not sz or abs(zs[k] + (zs[k + 1] - zs[k]) * t - sz) <= ZTOL) then best, bk, bt = d, k, t end
	end
	if best > STRAY * STRAY then return false end
	local za, zb = zs[bk], zs[bk + 1]
	ptsX.detail, ptsX.absoluteDry, ptsX.boarding = nil, nil, nil
	ptsX[1], ptsY[1], ptsZ[1] = xs[bk] + (xs[bk + 1] - xs[bk]) * bt, ys[bk] + (ys[bk + 1] - ys[bk]) * bt, za + (zb - za) * bt
	local m = 1
	for k = bk + 1, n do
		m = m + 1
		ptsX[m], ptsY[m], ptsZ[m] = xs[k], ys[k], zs[k]
	end
	-- Smoothed as a searched path is (Follow.Smooth), its jumps, drops, climbs and lifts kept: point j >= 2 is the
	-- leg's bk + j - 1, its way in the leg's segment bk + j - 2.
	local P = Nav.Path
	if P and P.Sight then
		sightC = pc
		m = Nav.follow.Smooth(ptsX, ptsY, ptsZ, m, sight, not (IsIndoors and IsIndoors()), leg.cls, bk)
	end
	for i = m + 1, count do ptsX[i], ptsY[i], ptsZ[i] = nil, nil, nil end
	count = m
	left[m + 1] = nil
	left[m] = leg.left[n]
	for i = m - 1, 1, -1 do
		local dx, dy = ptsX[i + 1] - ptsX[i], ptsY[i + 1] - ptsY[i]
		left[i] = left[i + 1] + sqrt(dx * dx + dy * dy)
	end
	idx, failed, wanted, hubs = 1, false, false, nil
	Nav.follow.Reset(fstate)
	Nav.follow.Mark(ptsX, ptsY, ptsZ, left, m, fstate)
	if Walk.Split then Walk.Split() end
	changed()
	pumpLegs()
	return true
end

function Walk.Aim(pc, px, py, goalC, goalX, goalY, handmade, goalZ, stop, checkedOnly)
	local P = engine()
	if P and P.SurfacesAt and pc then track(P, pc, px, py) end
	-- With no observed deck, a flat search can start on any floor under the
	-- shaft. Drop even an old walk; Travel owns the separate ride instruction.
	if P and pc and pc == goalC and city.Lift(pc, px, py) and playerZ(pc) == nil then
		if gc then Walk.Clear() end
		return nil, nil, nil, nil, "unmapped"
	end
	if handmade or not P or pc ~= goalC then
		if gc then Walk.Clear() end
		if not handmade and pc == goalC and not P then
			return nil, nil, nil, nil, Walk.GroundStatus(goalC, goalX, goalY, goalZ)
		end
		return nil
	end
	local tz = (type(goalZ) == "number" and goalZ) or targetZ(goalC, goalX, goalY) or false
	if gc ~= goalC or gx == nil or tz ~= gzFor or Walk.checkedOnly ~= checkedOnly
		or (checkedOnly and (gx ~= goalX or gy ~= goalY))
		or (goalX - gx) * (goalX - gx) + (goalY - gy) * (goalY - gy) > GOAL_MOVED * GOAL_MOVED then
		local had = count > 0 or shape ~= nil
		cancel()
		gc, gx, gy, count, idx, failed, hubs, shape = goalC, goalX, goalY, 0, 1, false, nil, nil
		failAgain = false
		Walk.blockedReason = nil
		Walk.checkedOnly, ptsX.checkedPolicy = checkedOnly, nil
		landX, landY = nil, nil
		city.refineX,city.refineY=nil,nil
		for k in pairs(Walk.dropped) do Walk.dropped[k] = nil end
		Nav.follow.Reset(fstate)
		-- In a capital a goal without a height ends on the trail floor at it (city.GoalZ) and is never asked again
		-- without its height (city.goal); a goal with a height keeps it.
		city.goal, city.dropped = city.At(goalC, goalX, goalY), nil
		gzFor, gz = tz, tz or (city.goal and city.GoalZ(P, goalC, goalX, goalY)) or nil
		city.Note(false)
		askedAt = -huge
		if had then changed() end
		if checkedOnly or not takeBaked(pc, px, py) then
			if P.Rush then P.Rush(true) end
			ask(P, pc, px, py)
		end
	elseif floorAsk then
		-- Ruling 36b: arrived (login, hearth, a landing) or off ambiguous ground,
		-- the floor found after a search without a height: once more with it.
		floorAsk = false
		ask(P, pc, px, py)
	elseif failed then
		local dx, dy = px - failX, py - failY
		local wait = GetTime() - failAt
		if failAgain and wait >= FAIL_AGAIN then
			failAgain = nil
			ask(P, pc, px, py)
		elseif wait >= FAIL_RETRY and dx * dx + dy * dy > FAIL_MOVED * FAIL_MOVED then ask(P, pc, px, py) end
	elseif wanted then
		ask(P, pc, px, py)
	elseif token ~= nil and ns.Transit and ns.Transit.Carried and ns.Transit.Carried() then
		-- Carried, the arrow's own search under way (asked before the ride was seen): from a point the ride has
		-- left; dropped, so the router stops on it, and owed until the player is off (ask).
		cancel()
		wanted = true
	end
	if count == 0 then
		return nil, nil, nil, nil, Walk.GroundStatus(gc, gx, gy, tz)
	end
	if checkedOnly and not Walk.CheckedAt(goalC, goalX, goalY, tz) then return nil,nil,nil,nil,true end
	-- Beside the pin, a partial must still help reach it. Walking laterally
	-- underneath an upstairs NPC is not progress if the route stops downstairs.
	if city.approachZ and gzFor and not stop then
		local xy = (px - gx)^2 + (py - gy)^2
		if xy <= Nav.DEFAULT_RADIUS^2 then
			local z = startZ(pc, px, py)
			local last = (ptsX[count] - gx)^2 + (ptsY[count] - gy)^2 + (city.approachZ - gzFor)^2
			local reach = Nav.follow.REACH
			if z and last > reach^2 and (last >= xy + (z - gzFor)^2 or
				(xy <= reach^2 and abs(z - gzFor) > reach and abs(city.approachZ - gzFor) > reach and abs(city.approachZ - z) <= 1)) then
				aimC, aimX, aimY, lastLeft = nil, nil, nil, nil
				return nil, nil, nil, nil, true
			end
		end
	end

	-- Outdoors, the path's first turn near its start (joining a road) may be cut
	-- (Nav/Follow.lua `join`); indoors every turn is a wall's. Outdoors, with the
	-- floor under the player known, the follower may aim ahead by sight beside
	-- the path (open ground; Path.Sight checks the line). Outdoors a hillside
	-- between two corners is no floor change (Follow.lua `hill`); indoors
	-- neither, except where the path doubles back over itself (Follow.Mark,
	-- run on each path as it comes in: a spiral stair, the Undercity's rings).
	-- Indoors or out, the corridor's aim past the next point is one the player
	-- can walk to straight (Follow.lua `reach`).
	local outdoors = not (IsIndoors and IsIndoors())
	local join = outdoors and JOIN or nil
	local look, reach
	if P.Sight then
		sightC, sightZ, reach = pc, startZ(pc, px, py), city.Walls
		if outdoors and sightZ ~= nil then look = sight end
	end
	-- A path just in was searched from where the player stood when it was asked, seconds ago: walking on, they
	-- may be far along it, past corners the follower would hold behind them (Follow.Catch; 0.3.7, down a slope
	-- the arrow pointed back at each late path's start until the player stopped).
	if landX then
		local mx, my = px - landX, py - landY
		Nav.follow.Catch(ptsX, ptsY, ptsZ, left, count, fstate, px, py, sqrt(mx * mx + my * my), STRAY, stop, (startZ(pc, px, py)))
		landX, landY = nil, nil
	end
	local ax, ay = Nav.follow.Step(ptsX, ptsY, ptsZ, left, count, fstate, px, py, stop, join, look, outdoors, reach)
	idx = fstate.idx
	aimC, aimX, aimY = ax and pc, ax, ay
	if not ax then
		lastLeft = nil
		if city.approachZ ~= nil then
			-- The mapped approach is exhausted. Tell both arrow callers not to fall
			-- through to a direct bearing through the unmapped wall or between floors.
			local dx, dy = px - ptsX[count], py - ptsY[count]
			if dx * dx + dy * dy > Nav.follow.REACH^2 and not token and not wanted
				and GetTime() - askedAt >= ASK_EVERY and (not city.partialAskX
					or (px - city.partialAskX)^2 + (py - city.partialAskY)^2 > Nav.follow.REACH^2) then
				city.partialAskX, city.partialAskY = px, py
				ask(P, pc, px, py)
			end
			return nil, nil, nil, nil, true
		end
		return nil
	end
	-- Yards left: straight to the end of the segment the player is on, then along the path; with the arrow on a
	-- point in sight beside the path (Nav/Follow.lua's S.aimAlong), straight to that point, then along the path from
	-- it. (The segment's end may lie behind a player running beside the path, and 0.3.5's yards then counted up
	-- while they closed on the target.)
	local aimAlong = fstate.aimAlong
	local dx, dy
	if aimAlong then
		dx, dy = ax - px, ay - py
		lastLeft = sqrt(dx * dx + dy * dy) + (left[1] - aimAlong)
	else
		local ix, iy = ptsX[idx] or ptsX[count], ptsY[idx] or ptsY[count]
		dx, dy = ix - px, iy - py
		lastLeft = sqrt(dx * dx + dy * dy) + left[idx <= count and idx or count]
	end
	-- Re-ask only when the player has strayed from the path: walking beside it,
	-- or coming at it from the side, is the follower's to handle, and so is
	-- running up to Follow.OPEN yards beside it with a point ahead on it in
	-- sight (fstate.sighted: open ground). (A stale path
	-- left behind the player cannot hold the arrow back: the follower's
	-- projection moves on with the player, and past WINDOW yards the player is
	-- off the path and STRAY asks again.)
	-- On a long walk (ASK_FAR yards left) a stray asks again at most every ASK_FAR_EVERY seconds: each ask searches the
	-- whole walk again, and a mounted player cutting corners strayed every few seconds (a search every 4-5 s, ~1 MB of
	-- garbage a second). A stray that long after the last ask still asks at once.
	local every = lastLeft > ASK_FAR and ASK_FAR_EVERY or ASK_EVERY
	if fstate.off > STRAY and not fstate.sighted and token == nil and not wanted and GetTime() - askedAt >= every then ask(P, pc, px, py) end
	return pc, ax, ay, lastLeft
end

-- Only the live search for this floor, never a batch cost, a sketch or an
-- old path from another character policy, may supply a checked detour's aim.
function Walk.CheckedAt(c, x, y, z)
	local o = ptsX.checkedPolicy
	return count > 0 and o and gc == c and gx == x and gy == y and gzFor == (z or false)
		and (type(Walk.checkedOnly) ~= "table" or Walk.checkedOnly == o)
		and o.waterWalking == (not not Nav.travel.IsGhost()) and o.profile == ns.Compat.GetPlayerFaction()
		and o.walkLevel == (Nav.danger.Level() or 0) and o.style == ns.Get("nav.routeStyle")
end

local function isGoal(c, x, y)
	return count > 0 and gc == c and (x - gx) * (x - gx) + (y - gy) * (y - gy) <= GOAL_MOVED * GOAL_MOVED
end

-- Follow.Step finishes in XY. Only identify the exact mapped endpoint it
-- exhausted; a nearby goal, substitute floor or abandoned search is not it.
function Walk.ExhaustedAt(c, x, y, z)
	return count >= 2 and fstate.idx == count + 1 and gc == c and gx == x and gy == y
		and gzFor == z and gz == z and not (token or wanted or failed or Walk.blockedReason
			or city.note or city.dropped or city.approachZ)
		and ptsZ[count] and abs(ptsZ[count] - z) < .02
		and (ptsX[count] - x)^2 + (ptsY[count] - y)^2 < .02^2
end

-- Only while the arrow has stopped: ask asynchronously from the player's
-- actual stance. Never keep retrying because a player is standing still.
function Walk.RefineTerminal(c,px,py,x,y,z)
	if not isGoal(c,x,y) or gz~=z or token or wanted or failed or city.note or city.dropped
		or ptsX.absoluteDry or inCombat() or (px-x)^2+(py-y)^2>20^2 then return end
	if city.refineX and (px-city.refineX)^2+(py-city.refineY)^2<=4^2 then return end
	local P=engine()
	if not P or not P.FinalDrySight or not canSearch(P,c) or (ns.Transit and ns.Transit.Carried and ns.Transit.Carried()) then return end
	city.refineX,city.refineY=px,py
	ask(P,c,px,py,nil,true)
end

-- A known substitute deck is not arrival when it is vertically separate from the named goal. Once the player's
-- measured floor is closer to the goal than the substitute, the ordinary arrival radius applies again.
function Walk.OnApproachFloor(c, x, y, goalZ, playerZ)
	local deck = city.approachZ
	return deck ~= nil and gzFor == goalZ and isGoal(c, x, y) and abs(deck - goalZ) > 5 and abs(playerZ - deck) < abs(playerZ - goalZ)
end

-- Yards left along the path to (c, x, y) at the last Aim, or nil (no path for it).
function Walk.Left(c, x, y)
	if not isGoal(c, x, y) then return nil end
	return lastLeft
end

-- At the last Aim for (c, x, y): yards along the path from its start to the
-- player's place on it, and yards between the player and that place; or nil.
function Walk.Progress(c, x, y)
	if not isGoal(c, x, y) or fstate.off == nil then return nil end
	return fstate.along, fstate.off
end

-- Height of the displayed aim on a surveyed segment near the follower's
-- cursor. This is not the player's floor or permission to cut that segment.
function Walk.DetailAimZ(x,y,px,py,pz)
	local detail=ptsX.detail
	if not detail then return end
	local h,onPiece
	for i=math.max(2,idx-1),math.min(count,idx+3) do
		if detail[i-1] and detail[i] and ptsZ[i-1] and ptsZ[i] then
			local ax,ay=ptsX[i-1],ptsY[i-1];local dx,dy=ptsX[i]-ax,ptsY[i]-ay
			local d=dx*dx+dy*dy
			if d>.000001 then
				local t=((x-ax)*dx+(y-ay)*dy)/d
				if t>=-1e-7 and t<=1+1e-7 and (ax+t*dx-x)^2+(ay+t*dy-y)^2<.000001 then
					local z=ptsZ[i-1]+t*(ptsZ[i]-ptsZ[i-1])
					if h and abs(z-h)>.1 then return end
					h=z
					-- A subsegment of the exact certified piece inherits its proof.
					-- Never grant a chord to a different piece or from beside it.
					if ptsX.absoluteDry and pz then
						local s=((px-ax)*dx+(py-ay)*dy)/d
						if s>=-1e-7 and s<=t and (ax+s*dx-px)^2+(ay+s*dy-py)^2<.000001
							and abs(ptsZ[i-1]+s*(ptsZ[i]-ptsZ[i-1])-pz)<=.19 then onPiece=true end
					end
				end
			end
		end
	end
	return h,onPiece
end

-- The arrow's aim at the last Aim when it was a point ahead on the path in
-- sight beside it (Nav/Follow.lua, open ground): c, wx, wy; else nil. The
-- route line's walk starts from the player toward it (Maps/RouteLines.lua).
function Walk.SightAim()
	if count == 0 or not fstate.sighted then return nil end
	return aimC, aimX, aimY
end

-- The arrow's aim at the last Aim, whatever it was (the point in sight, the
-- corridor's aim along the path, or the point LEAD yards past the player's
-- place when they are off it): c, wx, wy, a point on the path; else nil (no
-- path, or the player at its end). The route line's walk starts from the
-- player toward it when they are far off the walk (Maps/RouteLines.lua).
function Walk.LastAim()
	if count == 0 or not aimC then return nil end
	return aimC, aimX, aimY
end

-- The yards left along the arrow's live walk to the goal (c, x, y) while the player follows it, else nil (Nav/Travel.lua:
-- a start inside an approach chain keeps that walk where no measure prices it, a target nearer than MEASURE_NEAR, #3449).
function Walk.LiveLeft(c, x, y)
	if count == 0 or not aimC or gc ~= c or gx == nil or (x - gx) * (x - gx) + (y - gy) * (y - gy) > GOAL_MOVED * GOAL_MOVED then return nil end
	return lastLeft
end

-- Has the player gone past segment `seg` of the path to (c, x, y)?
function Walk.Passed(c, x, y, seg)
	return seg ~= nil and isGoal(c, x, y) and idx > seg + 1
end

---------------------------------------------------------------------------
-- The planner's walks into the target (Travel.lua: p.walkCost, p.places)
--
-- One Path.FindMany per target, from the target to the places a walk to it
-- can start from, reversed so each cost is the walk from that place to the
-- target (after Shortest Path Forever's goal batch, Journey/JourneySearch.lua).
-- Travel prices those walks by these running yards instead of straight x1.25.
--   Places: those on the target's continent within Walk.measureRange of it, the
--     nearest MEASURE_MAX, the player among them. Farther ones keep their
--     straight estimate. With no place but the player nothing is measured (a
--     lone walk is the arrow's own search, above).
--   A settled refusal rules out the walk from that start. Unmeasured places
--     keep their policy-checked estimate. A player's measure is valid only
--     at the measured position and floor, never shortened by the yards they
--     have moved. Past START_NEAR, a new plan measures their walk again.
--   Fixed per target and kept for the last MEASURE_KEEP targets, so plans
--     never flip-flop on them: a target is measured again only when its plan
--     has a place the measure lacks (a flight master learned, a new bind, the
--     player come within reach or walked away, above).
--     When a measure lands, Travel.Remeasured plans once more and changes the
--     route only if it goes another way (the same way takes its new prices).
--   The target's height (Nav.GetTargetWorld) goes with the batch, so a walk
--     into an Undercity quarter is measured to that floor; a batch with it
--     that finds nothing is asked once more without it (as Z2).
--   The batch's danger table leaves out the target's zone only: one batch
--     takes one opts for all its places, so a place inside a dangerous zone
--     is priced through its own zone (the walk out of it).
--   One batch at a time; a new target cancels the old one's. None is started
--     in combat (owed until it ends; the engine pauses a running one), nor
--     while the player is carried (Transit.Carried: one under way is dropped,
--     the first plan once off measures), with Walk real paths off, or while
--     Shortest Path Forever guides.
--   None for a target within MEASURE_NEAR yards of the player: its plan keeps
--     the straight estimates (as before 0.3.0), and the arrow's own search
--     still draws the walk. A batch costs about a second of router work and
--     a guide sets a near waypoint at every turn-in, so measuring those
--     stuttered the frame rate for little: a hearth or a flight seldom beats
--     a walk that short. A target measured from farther keeps its measure,
--     the player's price is valid only at the measured position on its floor.
---------------------------------------------------------------------------

Walk.measureRange = 3000  -- straight yards from the target: places farther keep the estimate
local MEASURE_MAX = 16      -- places measured, nearest first
local MEASURE_CHOSEN = 6000 -- straight yards: a place the plan rides to and walks on from is measured up to this far
local MEASURE_KEEP = 4      -- targets whose measures are kept
local START_NEAR = 50       -- yards the player can move before the next plan remeasures their walk
local MEASURE_NEAR = 400    -- straight yards from the player: a nearer target is not measured

local measures = {}         -- finished measures, oldest first
local measuring             -- the measure being taken: { c, x, y, water, pts, si, sx, sy, job }
local measureOwed           -- { c, x, y, goalZ, places } put off by combat

local function sameTarget(e, c, x, y, water, goalZ)
	return e.c == c and e.water == water and e.x == x and e.y == y and e.goalZ == goalZ and e.o
		and e.o.profile == ns.Compat.GetPlayerFaction() and e.o.walkLevel == (Nav.danger.Level() or 0) and e.o.style == ns.Get("nav.routeStyle")
end

local function findMeasure(c, x, y, water, goalZ)
	for i = #measures, 1, -1 do
		if sameTarget(measures[i], c, x, y, water, goalZ) then return measures[i] end
	end
	return nil
end

local function cancelMeasure()
	local e = measuring
	measuring, measureOwed = nil, nil
	if e and e.job then
		local P = Nav.Path
		if P then pcall(P.Cancel, e.job) end
	end
end

local function storeMeasure(e)
	for i = #measures, 1, -1 do
		if sameTarget(measures[i], e.c, e.x, e.y, e.water, e.goalZ) then table.remove(measures, i) end
	end
	measures[#measures + 1] = e
	if #measures > MEASURE_KEEP then table.remove(measures, 1) end
end

-- A measured place's floor is part of its identity (a bridge and the ground below it).
local function placeIndex(e, x, y, z)
	local pts = e.pts
	for i = 1, #pts do
		if i ~= e.si and pts[i].x == x and pts[i].y == y and pts[i].z == z then return i end
	end
	return nil
end

-- Once an onward walk has been requested, finishing the batch without a
-- checked price for that floor is not permission to fall back to a fare. While
-- the batch runs, a place it has already priced is: a strict batch publishes a
-- place's cost only once that walk is checked (Routing/Path.lua Safe.many).
function Walk.UnpricedTransfer(c, x, y, water, goalZ, from)
	water = water or false
	local e = measuring
	if not (e and sameTarget(e, c, x, y, water, goalZ)) then e = findMeasure(c, x, y, water, goalZ) end
	local i = e and placeIndex(e, from.wx, from.wy, from.z)
	if i == nil then return false end
	local costs = e.costs or e.partial
	return not (e.checked or (not e.costs and e.partial)) or (goalZ and e.z ~= goalZ) or not costs or type(costs[i]) ~= "number"
end

-- A measure is being taken (Nav/Travel.lua Travel.Waiting: a route held for its landing's walk).
function Walk.MeasureBusy()
	return measuring ~= nil
end

-- The walk from (c, wx, wy) to the measure's target (the player's walk when
-- start): its cost (chooses) and its yards (times it; FindMany's job.yards[i],
-- the cost itself from a router without them), false when the engine found
-- no walk from there, or nil when the route has no measure from this pose.
local function measuredCost(e, c, wx, wy, start, z)
	if c ~= e.c or (e.goalZ and e.z ~= e.goalZ) then return nil end
	local costs, yards = e.costs, e.yards
	local i
	if start then
		i = e.si
		if not i then return nil end
		-- A start inside an approach chain (Travel's "inside": sealed but for this walk) keeps the player's last measure
		-- until the next one lands: without it each plan in between led out by the chain (#3449).
		if start ~= "inside" and (wx ~= e.sx or wy ~= e.sy or e.pts[i].z ~= z) then return nil end
	else
		i = placeIndex(e, wx, wy, z)
	end
	local m = i and costs[i]
	if m == false then return false, nil, true end
	if type(m) ~= "number" then return nil end
	local y = yards and yards[i]
	if type(y) ~= "number" then y = m end
	if e.checked then return m, y, e.o end
end

-- The costs from the measured origins into this target, or nil when none were measured for its floor.
function Walk.Measured(c, x, y, water, goalZ)
	if not engine() then return nil end
	local e = findMeasure(c, x, y, water or false, goalZ)
	return e and e.lookup
end

-- Keep even an empty reply so a replan won't ask again. Notify only about
-- usable new prices or explicit refusals: either can change the landing.
local function measured(mine, decided)
	measuring = nil
	mine.lookup = function(wc, wx, wy, start, z) return measuredCost(mine, wc, wx, wy, start, z) end
	storeMeasure(mine)
	local T = Nav.travel
	local tc, tx, ty, tz = Nav.GetTargetWorld()
	if decided and tc and T and T.Remeasured and sameTarget(mine, tc, tx, ty, T.IsGhost and T.IsGhost() or false, tz)
		and (not tz or mine.z == tz) then T.Remeasured() end
	pumpLegs()
end

-- One FindMany for a measure: from the target (at height z, when it has one,
-- with the router's reach) to its places, reversed. A batch with the height
-- that finds nothing is asked once more without it, but for a target in a
-- capital (mine.city): finding nothing, the straight estimates stand (the walk
-- without it went round Ironforge's gate, #2860).
local function batch(P, mine, z)
	local pts, water = mine.pts, mine.water
	mine.z, mine.o = z, mine.o or opts(water, mine.c, nil, nil, mine.x, mine.y)
	mine.partial, mine.firstPriced = nil, false
	local inCity = z ~= nil and mine.city
	local first
	for i = 1, #pts do
		if pts[i].first then first = i break end
	end
	-- The landing a planned route waits on (Travel.Waiting) is searched first; once it is priced the route is
	-- offered (Travel.Remeasured) while the batch goes on with the other places.
	local function progress(costs)
		if measuring ~= mine or type(costs) ~= "table" then return end
		mine.partial = costs
		if first and not mine.firstPriced and costs[first] ~= nil then
			mine.firstPriced = true
			local T = Nav.travel
			if T and T.Waiting and T.Waiting() then T.Remeasured() end
		end
	end
	local ok, handle = pcall(P.FindMany, mine.c, { x = mine.x, y = mine.y, z = z, reach = z ~= nil and city.GOAL or nil }, pts, function(costs, reason, answer)
		if measuring ~= mine then return end
		mine.job = nil
		costs = type(costs) == "table" and costs or {}
		mine.yards = type(answer) == "table" and type(answer.yards) == "table" and answer.yards or nil
		mine.checked = type(answer) == "table" and answer.walkChecked == true
		local found, refused = false, false
		for i = 1, #pts do
			if type(costs[i]) == "number" then found = true
			elseif costs[i] == false then refused = true end
		end
		if not found and z and not inCity and not (mine.goalZ and refused) and reason ~= "no safe walking route" then return batch(P, mine, nil) end
		mine.costs = costs
		measured(mine, refused or (found and mine.checked))
	end, mine.o, true, progress)
	if not ok then
		if z and not inCity then return batch(P, mine, nil) end
		measuring = nil
		return
	end
	if measuring == mine then mine.job = handle end
end

-- Two batches' opts alike (Walk's opts: the danger table compared by its entries).
local function sameOpts(a, b)
	if not (a and b) or a.waterWalking ~= b.waterWalking or a.profile ~= b.profile or a.style ~= b.style or a.walkLevel ~= b.walkLevel then return false end
	local da, db = a.danger, b.danger
	if da == db then return true end
	if type(da) ~= "table" or type(db) ~= "table" then return false end
	for k, v in pairs(da) do
		if db[k] ~= v then return false end
	end
	for k, v in pairs(db) do
		if da[k] ~= v then return false end
	end
	return true
end

-- The player alone has walked away from where their walk into e's target was
-- measured: only their walk is measured again (a batch of one, from the target
-- at the height and with the opts e's batch found its walks with), the other
-- places' walks kept: a batch's walks are each the cheapest from its place, so
-- the player's move changes none of theirs, and the 16-place batch measured
-- again cost 20-70 MB of garbage per replan near the target. Only when another
-- place's walk was found (the batch measured again would then find walks at the
-- same height, not ask once more without it). -> started.
local function remeasureStart(P, e, c, x, y, water, p)
	if not (e.lookup and e.costs and e.pts) or e.z ~= city.MeasureZ(P, c, x, y, e.goalZ) then return false end
	local other = false
	for i = 1, #e.pts do
		if i ~= e.si and type(e.costs[i]) == "number" then other = true end
	end
	if not other then return false end
	local o = opts(water, c, nil, nil, x, y)
	if not sameOpts(o, e.o) then return false end
	local pt = { x = p.wx, y = p.wy, z = p.z, floors = p.z == nil and startFloors(c, p.wx, p.wy) or nil }
	local pts, costs, yards = {}, {}, e.yards and {} or nil
	for i, q in ipairs(e.pts) do
		pts[i], costs[i] = q, e.costs[i]
		if yards then yards[i] = e.yards[i] end
	end
	local si = e.si or #pts + 1
	pts[si], costs[si] = pt, nil
	if yards then yards[si] = nil end
	local mine = { c = c, x = x, y = y, water = water, pts = pts, si = si, sx = pt.x, sy = pt.y, z = e.z, goalZ = e.goalZ, o = o, costs = costs, yards = yards, city = e.city }
	measuring = mine
	local ok, handle = pcall(P.FindMany, c, { x = x, y = y, z = e.z, reach = e.z and city.GOAL or nil }, { pt }, function(got, _, answer)
		if measuring ~= mine then return end
		mine.job = nil
		local m
		if type(got) == "table" then m = got[1] end
		-- Only the start was searched. An empty reply doesn't reject it or
		-- change the proofs for the other origins we kept.
		local priced = type(m) == "number" and type(answer) == "table" and answer.walkChecked == true and e.checked
		mine.checked = e.checked
		if priced or m == false then costs[si] = m end
		if yards and priced and type(answer.yards) == "table" then yards[si] = answer.yards[1] end
		measured(mine, priced or m == false)
	end, o, true)
	if not ok then
		measuring = nil
		return false
	end
	if measuring == mine then mine.job = handle end
	return true
end

-- Measure the walks into the target (c, x, y) from the plan's places (Travel's
-- p.places), unless they are measured or being measured, or c's walking maps
-- may not be searched yet (canSearch: the target is on another continent).
-- A place marked `chosen` (the landing the plan rides to and walks on from,
-- its walk still the straight estimate) is measured too up to MEASURE_CHOSEN
-- yards away, past Walk.measureRange and MEASURE_MAX: a landing out of reach was
-- never measured, and its straight estimate beat the player's own measured
-- walk, priced by its ground (#1728: from Camp Taurajo the plan flew back to
-- the Crossroads, 3,800 yd from the target, to walk on from there).
-- -> true while a measure of this target is being taken.
function Walk.Measure(c, x, y, water, places, goalZ)
	water = water or false
	if measuring and not sameTarget(measuring, c, x, y, water, goalZ) then cancelMeasure() end
	local P = engine()
	if not (P and P.FindMany) or type(places) ~= "table" or not canSearch(P, c) then return false end
	-- A near target: the straight estimates (the player's place is the plan's start).
	for _, p in ipairs(places) do
		if p.start then
			local dx, dy = p.wx - x, p.wy - y
			if dx * dx + dy * dy < MEASURE_NEAR * MEASURE_NEAR then
				measureOwed = nil
				return false
			end
			break
		end
	end
	if inCombat() then
		measureOwed = { c = c, x = x, y = y, goalZ = goalZ, places = places }
		return false
	end
	measureOwed = nil
	-- Carried (Transit.Carried): nothing measured from a point the ride leaves (Walk:Refresh drops a measure under
	-- way); the first plan once off measures.
	local X = ns.Transit
	if X and X.Carried and X.Carried() then return false end
	if measuring then return true end
	-- The nearest places within Walk.measureRange, nearest first.
	local pick, far = {}, {}
	local reach = Walk.measureRange * Walk.measureRange
	local others = false
	for _, p in ipairs(places) do
		local dx, dy = p.wx - x, p.wy - y
		local d = dx * dx + dy * dy
		if d <= reach then
			local at = #pick + 1
			while at > 1 and far[at - 1] > d do
				pick[at], far[at] = pick[at - 1], far[at - 1]
				at = at - 1
			end
			pick[at], far[at] = p, d
			if #pick > MEASURE_MAX then pick[#pick], far[#far] = nil, nil end
		end
	end
	local chosen = MEASURE_CHOSEN * MEASURE_CHOSEN
	for _, p in ipairs(places) do
		if p.chosen and not p.start then
			local dx, dy = p.wx - x, p.wy - y
			if dx * dx + dy * dy <= chosen then
				local included = false
				for _, q in ipairs(pick) do
					if not q.start and q.wx == p.wx and q.wy == p.wy and q.z == p.z then included = true; break end
				end
				if not included then pick[#pick + 1] = p end
			end
		end
	end
	for _, p in ipairs(pick) do
		if not p.start then others = true end
	end
	if not others then return false end
	local e = findMeasure(c, x, y, water, goalZ)
	if e then
		local start, other = nil, false
		for _, p in ipairs(pick) do
			if p.start then
				-- The player was out of reach, or has walked away from where their walk was measured.
				local dx, dy = p.wx - (e.sx or p.wx), p.wy - (e.sy or p.wy)
				if not e.si or (dx == 0 and dy == 0 and e.pts[e.si].z ~= p.z) or dx * dx + dy * dy > START_NEAR * START_NEAR then start = p end
			elseif not placeIndex(e, p.wx, p.wy, p.z) then
				other = true
				break
			end
		end
		if not (start or other) then return false end
		if start and not other and remeasureStart(P, e, c, x, y, water, start) then return true end
	end
	-- The places picked, the player's walk, and those the last measure had.
	local pts, si = {}, nil
	for _, p in ipairs(pick) do
		pts[#pts + 1] = { x = p.wx, y = p.wy, z = p.z, floors = p.start and p.z == nil and startFloors(c, p.wx, p.wy) or nil,
			first = p.chosen and not p.start or nil }
		if p.start then si = #pts end
	end
	if e then
		for i, p in ipairs(e.pts) do
			if i ~= e.si then
				local seen = false
				for k = 1, #pts do
					if k ~= si and pts[k].x == p.x and pts[k].y == p.y and pts[k].z == p.z then seen = true end
				end
				if not seen then pts[#pts + 1] = p end
			end
		end
	end
	local mine = { c = c, x = x, y = y, goalZ = goalZ, water = water, pts = pts, si = si, sx = si and pts[si].x, sy = si and pts[si].y, city = city.At(c, x, y) }
	measuring = mine
	batch(P, mine, city.MeasureZ(P, c, x, y, goalZ))
	return measuring == mine
end

---------------------------------------------------------------------------
-- Every later walk's own path (Travel.PricePaths, the route lines)
--
-- As soon as the route is planned, each later walk leg's abstract route
-- (Path.FindCoarse: its border crossings, in milliseconds) is asked for, one
-- at a time and whatever else runs, so the route lines follow the ground at
-- once. Once the plan has settled (no measure being taken) and the arrow's
-- own search for the walk it is on is in (or there is none: a flight, a
-- ride, a hand-made walk), each one is searched with Path.Find, one at a
-- time; the path replaces the abstract route (which prices nothing) and is
-- kept by its ends and water mode (the last LEG.KEEP), so the route lines
-- and the journey draw it along the ground and price it by its path. A walk
-- with neither is drawn straight and keeps its estimate; a failed search is
-- kept too, and its leg stays straight. A later walk to or from a known floor
-- is never priced by a walk on another one. Hand-made walks along an approach
-- chain, the pieces of a split walk and the last walk to a target after a
-- guide `goto` (the arrow goes straight from the mouth) are never searched;
-- a crossing, walked straight by the arrow, is searched for its line, which
-- keeps the data's straight one when the path is more than LEG.CROSS_DETOUR
-- times as long, and is never priced by it. A search whose leg leaves the
-- route is cancelled; none starts in combat, with Walk real paths off, or
-- while Shortest Path Forever guides.
---------------------------------------------------------------------------

local LEG = { KEEP = 32, CROSS_DETOUR = 2 } -- one local: the main chunk's are near Lua's limit
-- [ends] = { xs, ys, n, yards, hubs, coarse (the abstract route: n 0 when it found none) } | false (no path); keys oldest first
local legPaths, legOrder = {}, {}
local legToken, legJob, legKey    -- the leg search in flight
local legsWanted = false          -- a leg search waits for its turn
local shapeToken, shapeJob, shapeKey -- the abstract route asked for
local shapesOwed = false          -- abstract routes wait for the engine to load

local function ghostNow()
	local T = Nav.travel
	return T and T.IsGhost and T.IsGhost() or false
end

local function legKeyOf(from, to, ghost)
	return from.c .. ":" .. from.wx .. ":" .. from.wy .. ":" .. (from.z or "") .. ":" .. to.wx .. ":" .. to.wy .. ":" .. (to.z or "") .. (ghost and ":w" or "")
end

local function cancelLeg()
	local handle = legJob
	legToken, legJob, legKey = nil, nil, nil
	if handle then
		local P = Nav.Path
		if P then pcall(P.Cancel, handle) end
	end
end

local function cancelShape()
	local handle = shapeJob
	shapeToken, shapeJob, shapeKey = nil, nil, nil
	if handle then
		local P = Nav.Path
		if P then pcall(P.Cancel, handle) end
	end
end

local function keepLeg(key, e)
	if legPaths[key] == nil then legOrder[#legOrder + 1] = key end
	legPaths[key] = e
	if #legOrder > LEG.KEEP then legPaths[table.remove(legOrder, 1)] = nil end
end

-- The line of the walk from `from` to `to`: its searched path, else its abstract route; or nil.
local function legPath(from, to)
	if not (from and to and from.c == to.c and from.wx and to.wx) then return nil end
	local e = legPaths[legKeyOf(from, to, ghostNow())]
	return e and e.n > 1 and e or nil
end

-- The searched path of the walk from `from` to `to`: its yards (Find's
-- job.yards, the drawn line's length, never its cost) and the other faction's
-- towns it enters (job.hubs; nil: none), or nil (an abstract route is none).
function Walk.LegPath(from, to)
	local e = legPath(from, to)
	if not e or e.coarse then return nil end
	return e.yards, e.hubs
end

-- Leg i of the route is the last walk to a target after a guide `goto`: straight.
local function afterGoto(legs, i)
	return i == #legs and Walk.FollowsGoto(Nav.GetTarget())
end

-- Leg i is a walk drawn from its own search: not a piece of a split walk,
-- not along an approach chain (a crossing is), on one continent with walking
-- data the router may search now (canSearch), and not the last walk after a
-- guide `goto`.
local function searchable(legs, i, P)
	local leg = legs[i]
	return leg.kind == "walk" and (not leg.handmade or leg.crossing ~= nil) and not leg.parent and leg.from.c == leg.to.c
		and canSearch(P, leg.from.c) and not afterGoto(legs, i)
end

-- The first leg drawn from its own search: the one after the arrow's, or the
-- arrow's own when it walks it hand-made (a crossing, straight).
local function firstOwn(legs, ci)
	return legs[ci] and legs[ci].handmade and ci or ci + 1
end

-- The arrow's own search for the walk it is on is still to come or running:
-- the current leg is a walk it searches (not hand-made) whose goal (the whole
-- walk's end, for a piece of a split walk) has no answer yet.
local function arrowPending(legs, ci)
	local leg = legs[ci]
	if not (leg and leg.kind == "walk") or leg.handmade or afterGoto(legs, ci) then return false end
	local goal = leg.parent or leg.to
	if gc ~= goal.c or not gx then return true end
	local dx, dy = goal.wx - gx, goal.wy - gy
	if dx * dx + dy * dy > GOAL_MOVED * GOAL_MOVED then return true end
	return count == 0 and not failed
end

-- A partial approach can guide the player, not price a transfer between decks.
function LEG.complete(points, answer, from, to, z)
	if type(points) ~= "table" or #points < 2 or (type(answer) == "table" and answer.reached) then return false end
	if from.z == nil and z == nil then return true end
	if not (type(answer) == "table" and answer.walkChecked == true) then return false end
	local a, b = points[1], points[#points]
	return type(a) == "table" and type(b) == "table" and a.x == from.wx and a.y == from.wy and b.x == to.wx and b.y == to.wy
		and (not from.z or (type(a.z) == "number" and abs(a.z - from.z) <= 1))
		and (not z or (type(b.z) == "number" and abs(b.z - z) <= 1))
end

local function searchLeg(P, mine, key, from, to, z, ghost)
	local T = Nav.travel
	local ok, handle = pcall(P.Find, from.c, { x = from.wx, y = from.wy, z = from.z }, { x = to.wx, y = to.wy, z = z, reach = z ~= nil and city.GOAL or nil }, function(points, _, answer)
		if legToken ~= mine then return end
		legJob = nil
		legToken, legKey = nil, nil
		local e = false
		if LEG.complete(points, answer, from, to, z) then
			local xs, ys, n, yards = line(points)
			if n > 1 then
				local a = type(answer) == "table" and answer or nil
				if a and type(a.yards) == "number" then yards = a.yards end
				e = { xs = xs, ys = ys, n = n, yards = yards, hubs = hubsOf(a) }
			end
		end
		keepLeg(key, e)
		-- Priced: ROUTE_CHANGED redraws; a failure keeps the straight line.
		if not (e and T and T.PricePaths and T.PricePaths()) then changed() end
		pumpLegs()
	end, opts(ghost, from.c, from.wx, from.wy, to.wx, to.wy))
	if not ok then
		legToken, legKey = nil, nil
		keepLeg(key, false)
		return
	end
	if legToken == mine then legJob = handle end
end

pumpLegs = function()
	local P = engine()
	local T = Nav.travel
	local legs, ci = Nav.GetRoute()
	if not (P and legs and ci and T and T.Active and T.Active()) then
		cancelLeg()
		legsWanted = false
		return
	end
	local ghost = ghostNow()
	local nextLeg, nextKey, nextAt, kept = nil, nil, nil, false
	for i = firstOwn(legs, ci), #legs do
		local leg = legs[i]
		if searchable(legs, i, P) then
			local key = legKeyOf(leg.from, leg.to, ghost)
			local e = legPaths[key]
			if key == legKey then
				kept = true
			elseif (e == nil or (e and e.coarse)) and not nextLeg then
				nextLeg, nextKey, nextAt = leg, key, i
			end
		end
	end
	if legJob and not kept then cancelLeg() end
	if legToken then return end
	if not nextLeg then
		legsWanted = false
		return
	end
	-- After the plan settles and the arrow's own search (its answer pumps again).
	if measuring or token or wanted or inCombat() or arrowPending(legs, ci) then
		legsWanted = true
		return
	end
	legsWanted = false
	local mine, to = {}, nextLeg.to
	legToken, legKey = mine, nextKey
	local z = nextAt == #legs and city.MeasureZ(P, to.c, to.wx, to.wy, targetZ(to.c, to.wx, to.wy))
	searchLeg(P, mine, nextKey, nextLeg.from, to, z or to.z, ghost)
end

-- The shape of the next later walk with no line yet (Path.FindCoarse),
-- whatever else runs: its abstract route, or for a walk inside one cluster
-- its path itself, kept as its search's answer (one ending off the goal's
-- floor is drawn, and searched again as later walks are). Without the engine
-- yet (loaded on demand) it is owed (Walk:Refresh).
pumpShapes = function()
	local P = engine()
	local T = Nav.travel
	local legs, ci = Nav.GetRoute()
	shapesOwed = not P and ns.Get("nav.navRouting") and true or false
	if not (P and P.FindCoarse and legs and ci and T and T.Active and T.Active()) then
		cancelShape()
		return
	end
	local ghost = ghostNow()
	-- Every sketch first (milliseconds each), then the walks inside one cluster (their search, once the arrow's own is in).
	local nextLeg, nextKey, nextAt, kept, whole = nil, nil, nil, false, false
	local oneLeg, oneKey, oneAt
	for i = firstOwn(legs, ci), #legs do
		local leg = legs[i]
		if searchable(legs, i, P) then
			local key = legKeyOf(leg.from, leg.to, ghost)
			local e = legPaths[key]
			if key == shapeKey then
				kept = true
			elseif e == nil and not nextLeg then
				nextLeg, nextKey, nextAt = leg, key, i
			elseif e and e.cluster and not oneLeg then
				oneLeg, oneKey, oneAt = leg, key, i
			end
		end
	end
	if shapeJob and not kept then cancelShape() end
	if shapeToken then return end
	if not nextLeg then
		-- A whole search is a later walk's: never ahead of the arrow's own (Walk:Refresh asks again).
		if oneLeg and (token or wanted or arrowPending(legs, ci)) then
			shapesOwed = true
			return
		end
		nextLeg, nextKey, nextAt, whole = oneLeg, oneKey, oneAt, true
	end
	if not nextLeg then return end
	local mine, from, to = {}, nextLeg.from, nextLeg.to
	local z = (nextAt == #legs and targetZ(to.c, to.wx, to.wy)) or to.z
	shapeToken, shapeKey = mine, nextKey
	local ok, handle = pcall(P.FindCoarse, from.c, { x = from.wx, y = from.wy, z = from.z }, { x = to.wx, y = to.wy, z = z }, function(points, reason, answer)
		if shapeToken ~= mine then return end
		shapeToken, shapeJob, shapeKey = nil, nil, nil
		-- Never over the walk's own answer (its search may have answered first):
		-- its path, or false when it found none (indexing that false raised
		-- "attempt to index local 'was'"). Only a cluster's sketch is replaced.
		local was = legPaths[nextKey]
		if was == nil or (was and was.cluster) then
			local e = { coarse = true, n = 0, cluster = not whole and reason == "cluster" or nil }
			if LEG.complete(points, answer, from, to, z) then
				e.xs, e.ys, e.n, e.yards = line(points)
				local a = type(answer) == "table" and answer or nil
				if not points.coarse and e.n > 1 and not (z and offFloor(points, z, answer)) then
					e.coarse, e.hubs = nil, hubsOf(a)
					if a and type(a.yards) == "number" then e.yards = a.yards end
				end
			end
			keepLeg(nextKey, e)
			-- Priced (a path): ROUTE_CHANGED redraws.
			if e.n > 1 and not (not e.coarse and T.PricePaths and T.PricePaths()) then changed() end
		end
		pumpShapes()
	end, opts(ghost, from.c, from.wx, from.wy, to.wx, to.wy), whole)
	if not ok then
		shapeToken, shapeKey = nil, nil
		keepLeg(nextKey, { coarse = true, n = 0 })
		return
	end
	if shapeToken == mine then shapeJob = handle end
end

---------------------------------------------------------------------------
-- Chokepoints: the walk is split where its path passes a lift, gate,
-- bridge, tunnel, pass, or a cave or building mouth (Polestar_Nav's
-- PolestarNavChokepoints[map], else the lifts Nav/Transit.lua knows).
-- Travel.SplitWalk turns them into legs with captions; this finds them. A
-- chokepoint counts within its radius of the path (2D) and, when both have a
-- height, on the path's floor: one more than DZ.STOP yards above or below the
-- path's segment there is on another floor (the Undercity's canals 110 yd
-- under the Ruins) and is no stop. DZ.STOP is generous: the engine's path
-- heights are coarse and a mouth's packed height is its indoor floor (the
-- Fargodeep Mine's is 14-34 yd under the path's points beside it).
--   stop = { kind, name, zone, to (passages: the area beyond), wx, wy (on the
--     path), r, along (yards from here), seg, lift (Transit id), side
--     ("top"|"bottom": the landing boarded), endX, endY (the other landing) }
--   (name, zone, to in the client's language when it names them: the
--   chokepoints' AreaTable areas and lift objects, Polestar.Names)
---------------------------------------------------------------------------

-- yards above or below the path: a chokepoint on another floor (STOP); the path's height change across a lift it
-- rides (RIDE). One local: the main chunk's are at Lua's limit (syntax.rs).
local DZ = { STOP = 30, RIDE = 20 }

-- Nearest point on the path to (x, y): distance, segment, point, yards from the path's start, share of the segment.
local function project(x, y)
	local bestD, bestA, bestT = huge, 1, 0
	for a = 1, count - 1 do
		local ax, ay = ptsX[a], ptsY[a]
		local dx, dy = ptsX[a + 1] - ax, ptsY[a + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = 0
		if len2 > 0 then
			t = ((x - ax) * dx + (y - ay) * dy) / len2
			if t < 0 then t = 0 elseif t > 1 then t = 1 end
		end
		local ex, ey = ax + dx * t - x, ay + dy * t - y
		local d = ex * ex + ey * ey
		if d < bestD then bestD, bestA, bestT = d, a, t end
	end
	local a = bestA
	local dx, dy = ptsX[a + 1] - ptsX[a], ptsY[a + 1] - ptsY[a]
	return sqrt(bestD), a, ptsX[a] + dx * bestT, ptsY[a] + dy * bestT, left[1] - left[a] + sqrt(dx * dx + dy * dy) * bestT, bestT
end

-- The point `along` yards from the path's start.
local function pointAt(along)
	local total = left[1] - left[count]
	if along >= total then return ptsX[count], ptsY[count] end
	for a = 1, count - 1 do
		local s, e = left[1] - left[a], left[1] - left[a + 1]
		if along <= e then
			local t = e > s and (along - s) / (e - s) or 0
			return ptsX[a] + (ptsX[a + 1] - ptsX[a]) * t, ptsY[a] + (ptsY[a + 1] - ptsY[a]) * t
		end
	end
	return ptsX[count], ptsY[count]
end

-- The path's height a little before and after segment a: which way a lift goes.
local function climbs(a)
	local before, after = ptsZ[a > 1 and a - 1 or 1], ptsZ[a + 2 <= count and a + 2 or count]
	if not (before and after) or before == after then return nil end
	return after > before
end

-- Whether the path rides a lift at segment a: its height changes DZ.RIDE yards or more from the point before the
-- segment to the one after it (the walking engine's path steps from one landing to the other).
local function rides(a)
	local before, after = ptsZ[a > 1 and a - 1 or 1], ptsZ[a + 2 <= count and a + 2 or count]
	return type(before) == "number" and type(after) == "number" and abs(after - before) >= DZ.RIDE
end

local function liftId(c, wx, wy)
	local X = ns.Transit
	if not (X and X.LiftNear) then return nil end
	local ok, id, name = pcall(X.LiftNear, c, wx, wy)
	if ok then return id, name end
	return nil
end

-- A chokepoint's area name in the client's language, else the pack's English.
local function areaName(id, english)
	local N = ns.Names
	return (N and id and N.Area(id)) or english
end

-- The stops along the current path from where the player is, in order.
-- -> stops, total (yards along the path from the player to the goal)
function Walk.Stops(pc, px, py)
	if count < 2 or not gc then return nil end
	local SNAP = 15       -- yards: default distance from a chokepoint to the path
	local MIN_STEP = 20   -- yards: closer stops, or this close to either end, are dropped
	local LOOK = 25       -- yards past a passage that tell which side is ahead
	-- A chokepoint passed on this goal's walk (Walk.dropped) is a stop again AGAIN yards ahead along the path. (Local
	-- here: the file's main chunk keeps clear of Lua 5.1's 200 locals.)
	local dropped, AGAIN = Walk.dropped, 100
	local _, _, _, _, here = project(px, py)
	local total = left[1] - here
	local minX, maxX, minY, maxY = huge, -huge, huge, -huge
	for i = 1, count do
		local x, y = ptsX[i], ptsY[i]
		if x < minX then minX = x end
		if x > maxX then maxX = x end
		if y < minY then minY = y end
		if y > maxY then maxY = y end
	end
	local found = {}
	local function consider(e, kind)
		local r = tonumber(e.r) or SNAP
		if e.wx + r < minX or e.wx - r > maxX or e.wy + r < minY or e.wy - r > maxY then return end
		local d, a, sx, sy, along, t = project(e.wx, e.wy)
		along = along - here
		-- A lift the path rides is a step however near the walk's ends (the Great Lift's
		-- bottom landing a few yards from the Thousand Needles crossing).
		local ridden = kind == "lift" and rides(a)
		if d > r then return end
		if ridden then
			if along < -r then return end
		else
			-- Passed (behind, within MIN_STEP, or a piece walked): out of this goal's walk until AGAIN yards ahead.
			-- A search a few steps on (the player beside the path, or a plan made again) made it a stop again, and
			-- the route's step went to it and back as it was reached at once (0.4.0's border sweep, #1543).
			if along < MIN_STEP then
				dropped[e] = true
				return
			end
			if dropped[e] then
				if along < AGAIN then return end
				dropped[e] = nil
			end
			if along > total - MIN_STEP then return end
		end
		-- Another floor: the path's segment there runs DZ.STOP yards or more above or below the
		-- chokepoint at both its ends (a cave entry at the Undercity's canals under a walk over the Ruins);
		-- never a lift the path rides (its landings join the floors).
		local ez, za, zb = tonumber(e.z), ptsZ[a], ptsZ[a + 1]
		if not ridden and ez and za and zb and abs(za - ez) > DZ.STOP and abs(zb - ez) > DZ.STOP then return end
		-- stop: the follower's cap for the piece that ends here (Nav/Follow.lua), the chokepoint's spot on the path,
		-- kept on its segment a when it lies at the segment's end (t = 1: as at point a + 1, which the follower lets
		-- the aim reach from anywhere before it; the border sweep, #1543); a lift's, the point before its landing (a
		-- spot between the landings' floors is no place to aim at).
		found[#found + 1] = { kind = kind, entry = e, wx = sx, wy = sy, r = r < 5 and 5 or r > 20 and 20 or r, along = along, seg = a,
			stop = kind == "lift" and a or a + (t < 1 and t or 1 - 1e-6), ridden = ridden }
	end
	local packed = type(_G.PolestarNavChokepoints) == "table" and _G.PolestarNavChokepoints[gc]
	if type(packed) == "table" then
		-- A searched ride identifies its paired landing and the segment that actually boards.
		-- An earlier pass below the same platform is not a second ride.
		local selected
		if ptsX.boarding then
			selected = {}
			for i = 2, count do
				local e = ptsX.boarding[i]
				if e and packed[e.pair] then
					selected[e], selected[packed[e.pair]] = true, true
					local a, r = i-1, tonumber(e.r) or SNAP
					local along = left[1] - left[a] - here
					if along >= -r then
						found[#found+1] = { kind = "lift", entry = e, wx = e.wx, wy = e.wy, r = math.max(5, math.min(20, r)),
							along = math.max(0, along), seg = a, stop = a, ridden = true, boarding = true }
					end
				end
			end
		end
		for _, e in ipairs(packed) do
			if type(e) == "table" and e.wx and e.wy and e.kind and not (selected and selected[e]) then consider(e, e.kind) end
		end
	else
		local X = ns.Transit
		local ok, lifts = false, nil
		if X and X.Lifts then ok, lifts = pcall(X.Lifts) end
		if ok and type(lifts) == "table" then
			for _, e in ipairs(lifts) do
				if e.c == gc and e.wx and e.wy then consider(e, "lift") end
			end
		end
	end
	table.sort(found, function(a, b) return a.along < b.along end)

	local stops, lastAlong, used = {}, -huge, {}
	for _, f in ipairs(found) do
		local e = f.entry
		if (f.boarding or not used[e]) and (f.along - lastAlong >= MIN_STEP or f.ridden) then
			local s = { kind = f.kind, name = areaName(e.area, e.name), zone = areaName(e.zoneArea, e.zone), wx = f.wx, wy = f.wy, r = f.r, along = f.along, seg = f.seg,
				stop = f.stop, entry = e }
			if f.kind == "lift" then
				-- Use the search's boarding side when present. With only a legacy
				-- untyped line, infer the side from the path's climb as before.
				local other = packed and e.pair and packed[e.pair]
				local side = e.liftEnd
				if not f.boarding then
					local up = climbs(f.seg)
					if up ~= nil then side = up and "bottom" or "top" end
				end
				if other and side and e.liftEnd and other.liftEnd == side and e.liftEnd ~= side then
					e, other = other, e
					s.name, s.zone = areaName(e.area, e.name), areaName(e.zoneArea, e.zone)
				end
				if other then
					used[other] = true
					s.endX, s.endY = other.wx, other.wy
					s.z, s.endZ = e.z, other.z
				end
				s.side = side
				local id, name = liftId(gc, e.wx, e.wy)
				if packed then
					-- The lift object's own name; on another client's language,
					-- else the Transit lift's (its area's), before the English.
					local N = ns.Names
					local own = N and e.liftObject and N.Object(e.liftObject)
					s.lift, s.name = id or e.id, own or (N and N.Localised() and name) or e.lift or name or s.name
				else
					s.lift, s.name = e.id or id, e.name or name
				end
			elseif type(e.sides) == "table" then
				-- A passage: the side the path reaches after it is where it leads.
				local ax, ay = pointAt(f.along + here + LOOK)
				local best, bestD = nil, huge
				for _, side in ipairs(e.sides) do
					if type(side) == "table" and side.wx and side.wy then
						local dx, dy = side.wx - ax, side.wy - ay
						local d = dx * dx + dy * dy
						if d < bestD then best, bestD = side, d end
					end
				end
				s.to = best and areaName(best.zoneArea, best.area) or nil
			end
			stops[#stops + 1] = s
			lastAlong = f.along
		end
	end
	return stops, total
end

-- Split the walk the arrow is on at its chokepoints (Travel.SplitWalk), once
-- per path and once per plan.
function Walk.Split()
	local T = Nav.travel
	if not (T and T.SplitWalk and gc) or count < 2 then return end
	local C = ns.Compat
	local pc, px, py
	if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	if pc ~= gc then return end
	-- The pieces of this walk already walked: their chokepoints are passed (Walk.Stops keeps them out).
	local legs, ci = Nav.GetRoute()
	local cur = legs and ci and legs[ci]
	if cur and cur.parent then
		for k = ci - 1, 1, -1 do
			local l = legs[k]
			if l.parent ~= cur.parent then break end
			if l.entry then Walk.dropped[l.entry] = true end
		end
	end
	local stops, total = Walk.Stops(pc, px, py)
	if stops then T.SplitWalk(gc, gx, gy, stops, total, hubs) end
end

---------------------------------------------------------------------------
-- Hand-made guide waypoints
---------------------------------------------------------------------------

local gotoTarget, gotoStep, gotoGoal
-- yards: a way in this far or nearer the target leads into it (a cave's
-- mouth and the cave); a goto farther off, or on another continent, is the
-- last trip's end, not a way in (the zeppelin tower before the Barrens, #1128)
local WAY_IN_YD = 500
-- yards: a goal this near the target stands at its spot (another quest of the
-- same NPC, an optional turn-in before the accept): no waypoint of its own, so
-- the way in before it still leads to the target (#1338)
local SAME_SPOT_YD = 3

-- The goal's point in world yards: c, wx, wy | nil.
local function worldOf(t)
	local C = ns.Compat
	if not (C and C.MapToWorld and t.map and t.x and t.y) then return nil end
	return C.MapToWorld(t.map, t.x, t.y, t.f)
end

-- The guide's last located goal before this target is a `goto` the player
-- has reached (Engine.GoalDone): the author's way in (a cave's mouth), so
-- the arrow goes straight from there. Until then the target is walked like
-- any other, so a goal aimed at ahead of its way in never leads onto the
-- hill above the cave (#914). Only a goto on the target's continent within
-- WAY_IN_YD of it is a way in. Goals at the target's own spot (SAME_SPOT_YD)
-- are looked past. The goto is found once per target; its state is asked
-- every time.
function Walk.FollowsGoto(target)
	if target ~= gotoTarget then
		gotoTarget, gotoStep, gotoGoal = target, nil, nil
		if type(target) ~= "table" or not (target.stepIndex and target.goalIndex) then return false end
		local E = ns.Engine
		local guide = E and E.GetGuide and E.GetGuide()
		local steps = type(guide) == "table" and guide.steps
		if type(steps) ~= "table" then return false end
		local bc, bx, by = worldOf(target)
		local s, g = target.stepIndex, target.goalIndex - 1
		while s >= 1 and not gotoStep do
			local goals = steps[s] and steps[s].goals
			if type(goals) == "table" then
				if g == nil then g = #goals end
				for k = g, 1, -1 do
					local goal = goals[k]
					if type(goal) == "table" and goal.map ~= nil and goal.x ~= nil then
						local ac, ax, ay = worldOf(goal)
						local d2 = ac and ac == bc and (ax - bx) ^ 2 + (ay - by) ^ 2 or nil
						if goal.t == "goto" or not (d2 and d2 <= SAME_SPOT_YD * SAME_SPOT_YD) then
							if goal.t == "goto" and d2 and d2 <= WAY_IN_YD * WAY_IN_YD then gotoStep, gotoGoal = s, k end
							s = 0
							break
						end
					end
				end
			end
			s, g = s - 1, nil
		end
	end
	if not gotoStep then return false end
	local E = ns.Engine
	return E and E.GoalDone and E.GoalDone(gotoStep, gotoGoal) == true or false
end

---------------------------------------------------------------------------
-- Route geometry for the map lines
---------------------------------------------------------------------------

local KIND = { fly = "flight" }
local geom, geomBuilt, geomRoute, geomGround = nil, -1, -1, nil

local function pt(list, c, wx, wy)
	if c and wx and wy then list[#list + 1] = { c, wx, wy } end
end

-- The engine's path points a..b into `pts` when the path is for the goal (c, wx, wy).
local function walkPoints(pts, c, wx, wy, a, b)
	if not isGoal(c, wx, wy) then return false end
	for i = a or 1, b or count do pt(pts, c, ptsX[i], ptsY[i]) end
	return true
end

-- The arrow's search's abstract route into `pts` while its path is still to
-- come, when that search is for the goal (c, wx, wy).
local function shapePoints(pts, c, wx, wy)
	local s = shape
	if not s or count > 0 or gc ~= c or (wx - gx) * (wx - gx) + (wy - gy) * (wy - gy) > GOAL_MOVED * GOAL_MOVED then return false end
	for i = 1, s.n do pt(pts, c, s.xs[i], s.ys[i]) end
	return true
end

-- The line of later walk leg i (or the arrow's own hand-made one) from its
-- own search, else its abstract route; a crossing's only when it is at most
-- LEG.CROSS_DETOUR times as long as the data's straight line; or nil.
local function ownLine(legs, i, ci, P)
	local leg = legs[i]
	if i == ci and not leg.handmade then return nil end
	if not (P and searchable(legs, i, P)) then return nil end
	local lp = legPath(leg.from, leg.to)
	if lp and leg.handmade then
		local dx, dy = leg.to.wx - leg.from.wx, leg.to.wy - leg.from.wy
		if lp.yards > LEG.CROSS_DETOUR * sqrt(dx * dx + dy * dy) then return nil end
	end
	return lp
end

local function build(ground)
	local out = {}
	local E = engine()
	local T = Nav.travel
	local legs, ci = Nav.GetRoute()
	local C = ns.Compat
	local pc, px, py
	if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	if legs and ci and T and T.Active() then
		local lastParent, prevSeg = nil, 0
		for i = ci, #legs do
			local leg = legs[i]
			local from, to = leg.from, leg.to
			local pts, straight = {}, nil
			local P = leg.parent
			if P ~= lastParent then
				lastParent, prevSeg = P, 0
				for k = i - 1, 1, -1 do
					local before = legs[k]
					if not P or before.parent ~= P then break end
					if before.seg then
						prevSeg = before.seg
						break
					end
				end
			end
			if leg.kind == "walk" and P then
				-- A piece of a split walk: its stretch of the path.
				pt(pts, from.c, from.wx, from.wy)
				walkPoints(pts, P.c, P.wx, P.wy, prevSeg + 1, leg.seg)
				if leg.seg then
					pt(pts, to.c, to.wx, to.wy)
					prevSeg = leg.seg
				end
			elseif leg.kind == "walk" then
				-- A later walk (or a crossing the arrow walks straight) along its own searched
				-- path or abstract route; the current one along the arrow's path, or its
				-- search's abstract route until that is in (a walk after a guide goto:
				-- straight from the mouth), drawn as soon as either exists, as in 0.4.1.1.
				-- Only the straight stand-in for the current walk waits for its answer
				-- (`ground`: Nav.CanDrawGroundApproach).
				local lp = ownLine(legs, i, ci, E)
				if lp then
					for k = 1, lp.n do pt(pts, from.c, lp.xs[k], lp.ys[k]) end
				elseif not walkPoints(pts, to.c, to.wx, to.wy) and not (i == ci and shapePoints(pts, to.c, to.wx, to.wy)) and (i ~= ci or ground) then
					local c, x, y = from.c, from.wx, from.wy
					if i == ci and pc == c then x, y = px, py end
					-- A later leg's own evidence is independent of a refusal here.
					if c == to.c then
						pt(pts, c, x, y)
						pt(pts, to.c, to.wx, to.wy)
						straight = true
					end
				end
			elseif leg.kind == "fly" and leg.stops then
				for _, node in ipairs(leg.stops) do pt(pts, node.c, node.wx, node.wy) end
			elseif leg.kind == "hearth" or leg.kind == "teleport" then
				if i == ci and pc then pt(pts, pc, px, py) else pt(pts, from.c, from.wx, from.wy) end
				pt(pts, to.c, to.wx, to.wy)
			else
				pt(pts, from.c, from.wx, from.wy)
				pt(pts, to.c, to.wx, to.wy)
			end
			-- straight: a walk drawn straight, no walking path known for it (the route lines draw it paler; display only).
			out[#out + 1] = { kind = KIND[leg.kind] or leg.kind, pts = pts, current = i == ci, choke = leg.choke, straight = straight }
		end
	else
		local tc, tx, ty = Nav.GetTargetWorld()
		if tc then
			local pts = {}
			if not walkPoints(pts, tc, tx, ty) and not shapePoints(pts, tc, tx, ty) and ground and pc == tc and Nav.CanDrawGroundApproach(pc, px, py, tx, ty) then
				pt(pts, pc, px, py)
				pt(pts, tc, tx, ty)
				out[1] = { kind = "walk", pts = pts, current = true, straight = true }
			elseif #pts > 0 then
				out[1] = { kind = "walk", pts = pts, current = true }
			end
		end
	end
	return { legs = out }
end

function Nav.GetRouteGeometry()
	if not Nav.GetTarget() or Nav.HandedOff() then return nil end
	local T = Nav.travel
	local route = T and T.version or 0
	local ground = Nav.CanDrawGroundApproach()
	if not geom or geomBuilt ~= geomVersion or geomRoute ~= route or geomGround ~= ground then
		geom, geomBuilt, geomRoute, geomGround = build(ground), geomVersion, route, ground
	end
	return geom
end

-- A fresh plan of the same walk (a zone change, a re-plan on the way) is
-- split again from the path already in: the steps stay the same. Its later
-- walks are drawn along their abstract routes at once and searched in turn.
ns.On("ROUTE_CHANGED", function(legs)
	local _, ci = Nav.GetRoute()
	local leg = legs and ci and legs[ci]
	if leg and leg.kind == "walk" and not leg.parent and not leg.handmade and count > 1 then Walk.Split() end
	changed()
	pumpShapes()
	pumpLegs()
end)
ns.On("ROUTE_ADVANCED", function(legs, ci)
	-- A piece of a split walk walked: its chokepoint is passed for this walk (Walk.Stops keeps it out), also when the
	-- route is planned afresh before the next path comes in (Walk.Split marks the walked pieces only then).
	local done = legs and ci and legs[ci - 1]
	if done and done.parent and done.entry then Walk.dropped[done.entry] = true end
	changed()
	pumpShapes()
	pumpLegs()
end)

---------------------------------------------------------------------------
-- Module
---------------------------------------------------------------------------

function Walk:OnTarget(target)
	if not target then
		Walk.Clear()
		release()
		cancelMeasure()
		cancelLeg()
		cancelShape()
	elseif Nav.Path and Nav.Path.Rush then
		-- A new goal: the planner's measure and the arrow's walk take the larger budget until the walk is in.
		Nav.Path.Rush(true)
	end
	changed()
end

-- Every walk priced under the old options (a route style, a level) is
-- dropped: the arrow's path (straight until the new one is in), the measure
-- in flight and the kept measures, the later walk in flight and the kept
-- later paths; then the route is planned again at once, so each is measured
-- and searched again under the new ones.
local function searchAgain()
	Walk.Clear()
	cancelMeasure()
	for i = #measures, 1, -1 do measures[i] = nil end
	cancelLeg()
	cancelShape()
	for i = #legOrder, 1, -1 do legPaths[legOrder[i]], legOrder[i] = nil, nil end
	local T = Nav.travel
	if T and T.Replan then T.Replan() end
end

function Walk:OnSettings()
	if ns.Get("nav.navRouting") then
		load()
	else
		if gc then Walk.Clear() end
		cancelMeasure()
		cancelLeg()
		cancelShape()
	end
	-- Another route style: every walk priced in the old one is searched again (searchAgain).
	local style = ns.Get("nav.routeStyle")
	if styleSeen ~= nil and style ~= styleSeen then searchAgain() end
	styleSeen = style
end

-- A level-up: the zones far above the player are others now (Nav/Danger.lua,
-- whose own handler, run first, keeps the event's level: the client's can lag
-- it), so every walk priced at the old level is searched again (searchAgain).
ns.RegisterEvent("PLAYER_LEVEL_UP", function()
	searchAgain()
end)

function Walk:Refresh()
	if ns.Get("nav.navRouting") and not Nav.Path and not loadTried then load() end
	-- No arrow update for FRESH seconds (a taxi, an instance, arrived): the floor's cluster may go.
	if aimAt and GetTime() - aimAt > FRESH then release() end
	if not engine() then
		-- Off, or Shortest Path Forever guides: nothing of ours runs.
		if measuring or measureOwed then cancelMeasure() end
		if legToken then cancelLeg() end
		if shapeToken then cancelShape() end
		return
	end
	-- Carried: the measure under way (asked before the ride was seen) has the player's walk from a point it has left.
	local X = ns.Transit
	if measuring and X and X.Carried and X.Carried() then cancelMeasure() end
	local o = measureOwed
	if o and not inCombat() then
		measureOwed = nil
		local tc, tx, ty, tz = Nav.GetTargetWorld()
		-- An owed request has no checked profile yet. Measure under the current
		-- character policy; only finished measures can be reused as evidence.
		if tc == o.c and tx == o.x and ty == o.y and tz == o.goalZ then
			local T = Nav.travel
			Walk.Measure(tc, tx, ty, T and T.IsGhost and T.IsGhost() or false, o.places, tz)
		end
	end
	if shapesOwed and not shapeToken then pumpShapes() end
	if legsWanted then pumpLegs() end
end

ns.OnLogin(function()
	if ns.Get("nav.navRouting") then load() end
end)

Nav.RegisterModule(Walk)
