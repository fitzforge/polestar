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
-- Straying more than STRAY yards from it, or a new goal, asks again (a stale
-- search is cancelled); nothing is asked for in combat. Hand-made walks win:
-- a crossing, an approach chain past its mouth (Travel's leg.handmade), and a
-- guide goal after a guide `goto` (the author's way in, a cave mouth) keep
-- the straight arrow. No engine, nav.navRouting off, no walking data for the
-- continent, or a failed search: the straight arrow, as without this file.
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
-- from it asks for a search as from any path (the re-plan); a goal the leg
-- does not end at (a walk leg's end before a flight, a hand-set target) is
-- searched as before.
--
-- Floors: a goal at the target's point carries the target's height (a guide
-- goal at an NPC or object: its spawn's z, Nav.GetTargetWorld) to Path.Find,
-- so the path ends on that floor (an Undercity quarter, not the street
-- above); a walk leg's end with a height of its own (a dock's board point on
-- a pier deck, a tram, zeppelin or portal end's floor, Nav/Travel.lua)
-- carries that one, so the walk ends on the deck or at the tram's entrance,
-- not in the water under it or on the roof above it. A search with the height that fails, or whose
-- path ends more than Z_OFF yards above or below it (the last engine point
-- before the goal), is asked once more without it, and that answer is the
-- one used. A hand-set target has no height: searched as before.
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
--     (Compat.GetZoneText; the rows' English names, Path.AreaName; other
--     languages wait for WMOAreaTable names in Polestar_Names)
--     are the floor at once when they lie within ZTOL, before seed and the
--     candidates, and they correct a followed floor on another level. A
--     subzone two levels share, or none, leaves it to movement.
--   Follow: the surface nearest the floor, never more than RISE (4) yards
--     above it (a ramp or stairs at mount speed, plus a jump); any drop (a
--     fall). None: unknown.
--   Unknown again: another continent; more than JUMP (30) yards since the
--     last read (a hearth, teleport, landing, loading screen); moving after
--     more than FRESH (2) seconds without a check; on a taxi, a transport
--     (Transit.Riding) or within LIFT (8) yards of a lift (Transit.LiftNear:
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
-- takes the same height. Unknown: searched without a height, as before; and
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
--     floor and path point `stop`, a piece of a split walk's last point
--     before its chokepoint); and the yards left along the path from the
--     player's place on it plus their way to it; nil = straight at the goal.
--     Allocation-free once the path is in.
--   Walk.Progress(c, x, y) -> along, off | nil: at the last Aim for that goal,
--     the yards along the path from its start to the player's place on it,
--     and the yards between the player and that place
--   Walk.Left(c, x, y) -> yards left along the path to that goal at the last Aim | nil
--   Walk.Passed(c, x, y, seg) -> the player is past segment `seg` of that goal's path
--   Walk.Stops(pc, px, py) -> stops, total: the chokepoints along the path
--   Walk.Split(): Travel.SplitWalk at them (on each path, and after a fresh plan);
--     with none, the walk leg takes the path's yards and time, and goes back
--     to its straight estimate when the path fails or is cleared (Travel.RestoreWalk)
--   Walk.FollowsGoto(target) -> true when the guide's last located goal before
--     this target is a `goto`
--   Walk.Clear()
--   Walk.Measure(c, x, y, water, places): measure the walks into that target
--     from the planner's places (one FindMany; Travel.Remeasured when in)
--   Walk.Measured(c, x, y, water) -> walkCost(c, wx, wy, start) -> cost, yards | nil, or nil
--   Walk.LegPath(from, to) -> yards along that later walk's searched path, its hubs | nil
--   Nav.GetRouteGeometry() -> { legs = { { kind, pts = { { c, wx, wy }, ... },
--     current, choke }, ... } } or nil without a target or while handed off
--     (Nav.HandedOff); NAV_ROUTE_GEOMETRY on change.
--     kind: walk | flight | boat | zeppelin | tram | portal | hearth | teleport | lift.
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
local ASK_EVERY = 2         -- seconds between asks for the same goal
local GOAL_MOVED = 1        -- yards: the goal is another one
local FAIL_RETRY, FAIL_MOVED = 15, 25 -- a failed search is asked again this late, this far away
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

-- The router's options (Routing/Path.lua): water walking (a ghost), the
-- player's faction (Compat.GetPlayerFaction: nil when neutral or unread),
-- the route style (nav.routeStyle, as saved: the router reads an unknown one
-- as Balanced) and the danger table (Nav.danger.Table at Nav.danger.Level,
-- without the zones (Nav.danger.ZoneAt) of the walk's start (sx, sy) and
-- goal (tx, ty) on map; nil for either leaves no zone out there), so each
-- step is priced for them: roads cheaper, slopes and indoors dearer, the
-- other faction's towns twenty times over, a zone far above the player three
-- or twenty times. A walk that starts or ends in a town of the other faction
-- (Path.HubAt at its start, its goal, or (hx, hy): the player's place in a
-- measure) is priced as for no faction (opts.homeHub): it leaves or enters
-- by the town's own streets and gate, never by the shortest way off the
-- town's ground over its walls or the mountains (a Tauren in Stormwind), and
-- the towns its line enters are still named.
local function opts(water, map, sx, sy, tx, ty, hx, hy)
	local C = ns.Compat
	local profile = C and C.GetPlayerFaction and C.GetPlayerFaction() or nil
	local D = Nav.danger
	local level = D and D.Level()
	local danger = level and D.Table(level, D.ZoneAt(map, sx, sy), D.ZoneAt(map, tx, ty)) or nil
	local P, home = Nav.Path, nil
	if profile and P and P.HubAt then
		home = (sx and P.HubAt(map, sx, sy, profile)) or (tx and P.HubAt(map, tx, ty, profile)) or (hx and P.HubAt(map, hx, hy, profile)) or nil
	end
	return { waterWalking = water and true or false, profile = profile, style = ns.Get("nav.routeStyle"), danger = danger, homeHub = home and true or nil }
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
local left = {}              -- left[i] = yards from point i to the end of the path
local lastLeft               -- yards left along the path at the last Aim
local count = 0              -- points in the path (0: none yet)
local idx = 1                -- the end point of the segment the player is on (Nav/Follow.lua)
local fstate = {}           -- the follower's state (Nav/Follow.lua's Follow.Step)
local wanted = false         -- a search is owed (deferred in combat)
local askedAt = -huge
local failed = false
local failAt, failX, failY = 0, 0, 0
local shape                  -- the live search's abstract route ({ xs, ys, n }; Find's coarse), drawn until the path is in
local geomVersion = 0
local pumpLegs              -- searches the route's later walks (below)
local pumpShapes            -- draws the route's later walks' abstract routes at once (below)
local release               -- lets the router drop the floor's cluster (below, "The walking floor")

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
	Nav.follow.Reset(fstate)
	if had then
		restore(c, x, y)
		changed()
	end
end

local function took(points)
	local n = 0
	for i = 1, #points do
		local p = points[i]
		if type(p) == "table" and p.x and p.y then
			n = n + 1
			ptsX[n], ptsY[n], ptsZ[n] = p.x, p.y, type(p.z) == "number" and p.z or false
		end
	end
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
local FRESH = 2       -- seconds: a floor checked longer ago is not used (and moving after such a gap loses it)
local NEAR = 5        -- yards from where the floor was read: farther, it is not used
local ZTOL = 10       -- Routing/PathGrid.lua's ZTOL: surfaces this close the router stands on alike
local LIFT = 8        -- yards from a lift (Transit.LiftNear): it changes level without moving
local INDOOR = 2      -- Path.SURFACE_INDOOR

local surf = {}       -- Path.SurfacesAt's out, reused
local surfArea = {}   -- Path.SurfacesAt's areas (each surface's AreaTable id, 0: none), reused
local areaNames = {}  -- WMOAreaTable row id -> its English name (false: none), read once each
local isNamed = {}    -- per surface of the last read: its area is the client's subzone (named), reused
local floorZ          -- the floor's height (nil: unknown)
local cand, candMiss, candN = {}, {}, 0 -- while the floor is unknown and seed cannot tell: the floors the player may be on, and reads each has missed (reused)
local candIndoor = false  -- the candidates are the indoor surfaces (the client said indoors): the player is on one of them
local fC, fX, fY, fAt, fGhost = nil, 0, 0, -huge, false -- the last check: continent, point read, time, ghost
local aimAt               -- GetTime of the last Walk.Aim (nil: the reader's cluster released)
local flatAt              -- GetTime of the last ask sent without a start height (nil: none owed a re-ask)
local floorAsk = false    -- the floor became known soon after that ask: ask once more with it (Ruling 36b)
local REASK = 5           -- seconds after a flat ask within which a floor found re-asks

-- On a taxi, a transport (Transit.Riding) or at a lift: the floor can change without walking.
local function carried(pc, px, py)
	local C, X = ns.Compat, ns.Transit
	if C and C.IsOnTaxi and C.IsOnTaxi() then return true end
	if X and X.Riding and X.Riding() then return true end
	return X and X.LiftNear and X.LiftNear(pc, px, py, LIFT) ~= nil or false
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

-- A known floor from the n surfaces read: the one nearest it, never more
-- than RISE above it (any drop is a fall); none: unknown.
local function follow(n)
	local best, gap = nil, huge
	for i = 1, n do
		local z = surf[i]
		if z <= floorZ + RISE and abs(z - floorZ) < gap then best, gap = z, abs(z - floorZ) end
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
-- areas: Path.AreaFormat; its English name Path.AreaName) is named as the client's subzone (the Undercity's "The
-- Canals", its quarters, the "Ruins of Lordaeron" hall over them), when they lie within ZTOL: the lowest. nil when the
-- map has no areas, the client names no subzone, or no surface or surfaces on several floors match (an area shared
-- by two levels: movement decides). English names only: on another client's language no subzone matches until
-- Polestar_Names carries WMOAreaTable names, and movement decides as before.
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
				name = P.AreaName and P.AreaName(pc, id) or false
				areaNames[id] = name
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

local function track(P, pc, px, py)
	local now = GetTime()
	aimAt = now
	if pc == fC and now - fAt < EVERY then return end
	local dx, dy = px - fX, py - fY
	local d2 = dx * dx + dy * dy
	local T = Nav.travel
	local ghost = T and T.IsGhost and T.IsGhost() or false
	local held = carried(pc, px, py)
	if held or pc ~= fC or ghost ~= fGhost or d2 > JUMP * JUMP or (d2 >= MOVE * MOVE and now - fAt > FRESH) then
		floorZ = nil
		dropCandidates()
	elseif d2 < MOVE * MOVE then
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
		elseif candN > 0 then
			floorZ = candidates(n)
		else
			floorZ = seed(n)
			if floorZ == nil then candidates(n) end
		end
		if floorZ ~= nil and flatAt and now - flatAt <= REASK then flatAt, floorAsk = nil, true end
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
		-- the wrong level, or a fall the follow missed).
		local z = named(P, pc, n)
		if z ~= nil and abs(z - floorZ) > ZTOL then floorZ = z else floorZ = follow(n) end
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
-- else the tracked floor; nil, tracked.
local function startZ(pc, px, py)
	local z = playerZ(pc)
	if z ~= nil then return z, false end
	z = trackedZ(pc, px, py)
	return z, z ~= nil
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

-- A path searched with height z that ends on another floor: its last engine
-- point before the goal (the last point is the goal itself) is more than
-- Z_OFF yards from z.
local function offFloor(points, z)
	for i = #points - 1, 2, -1 do
		local pz = type(points[i]) == "table" and points[i].z
		if type(pz) == "number" then return abs(pz - z) > Z_OFF end
	end
	return false
end

-- flat: the retry without the tracked floor. A search with it that finds
-- nothing is asked again without it (the goal's height kept); one with the
-- goal's height that finds nothing or ends off its floor, again without that
-- (Z2, for good), the start as it was.
local function ask(P, pc, px, py, flat)
	wanted = true
	if inCombat() then return end -- after combat, on the next sample
	wanted = false
	askedAt, failed = GetTime(), false
	cancel()
	if P.Available and not P.Available(pc) then
		failed, failAt, failX, failY = true, askedAt, px, py
		return
	end
	local mine = {}
	token = mine
	local ghost = Nav.travel and Nav.travel.IsGhost and Nav.travel.IsGhost() or false
	local z = gz
	local sz, tracked = startZ(pc, px, py)
	if flat and tracked then sz, tracked = nil, false end
	-- The floor unknown indoors: from the candidate floors; a search with them that finds nothing is asked flat.
	local floors = sz == nil and not flat and startFloors(pc, px, py) or nil
	if floors then tracked = true end
	-- A start without a height (not the retry that dropped the floor) owes one re-ask once the floor is found.
	floorAsk = false
	if sz == nil and not flat then flatAt = GetTime() else flatAt = nil end
	local o = opts(ghost, pc, px, py, gx, gy) -- a ghost walks on water
	local ok, handle = pcall(P.Find, pc, { x = px, y = py, z = sz, floors = floors }, { x = gx, y = gy, z = z }, function(points, _, answer)
		if token ~= mine then return end
		token, job = nil, nil
		dropSketch()
		local got = type(points) == "table" and #points > 0
		if tracked and not got then
			ask(P, pc, px, py, true)
			return
		end
		if z and (not got or offFloor(points, z)) then
			gz = nil
			ask(P, pc, px, py, flat)
			return
		end
		if got then
			failed = false
			took(points)
			local h = type(answer) == "table" and answer.hubs
			hubs = type(h) == "table" and #h > 0 and h or nil
			if Walk.Split then Walk.Split() end
		else
			failed, failAt, failX, failY = true, GetTime(), px, py
			count, hubs, shape = 0, nil, nil
			restore(gc, gx, gy)
		end
		changed()
		pumpLegs()
	end, o)
	if not ok then
		token = nil
		if tracked then return ask(P, pc, px, py, true) end
		if z then
			gz = nil
			return ask(P, pc, px, py, flat)
		end
		failed, failAt, failX, failY = true, askedAt, px, py
		return
	end
	if token == mine then job = handle end
	-- No path yet: the walk's shape at once (Path.FindCoarse across clusters), drawn until the path is in.
	if count == 0 and not shape and P.FindCoarse then
		local okShape, h = pcall(P.FindCoarse, pc, { x = px, y = py, z = sz }, { x = gx, y = gy, z = z }, function(points)
			if token ~= mine then return end
			sketchJob = nil
			if type(points) ~= "table" or count > 0 then return end
			local xs, ys, n = line(points)
			if n < 2 then return end
			shape = { xs = xs, ys = ys, n = n }
			changed()
		end, o)
		if okShape and token == mine then sketchJob = h end
	end
end

-- The current step's baked leg (Nav/Baked.lua) as the path to the goal just
-- taken, from the player's place on it: the nearest point of the leg, then
-- its points after that. Taken when the leg is on the player's continent,
-- ends at this goal (its last point within its tail and BAKED_END yards of
-- it) and the player is within STRAY yards of it; else false (search as
-- before). Straying from it later asks for a search like any path (Walk.Aim).
local BAKED_END = 3 -- yards: a leg's end this much past its tail is another goal's
local function takeBaked(pc, px, py)
	local E = ns.Engine
	local step = E and E.GetStepIndex and E.GetStepIndex()
	local leg = step and Nav.BakedLeg and Nav.BakedLeg(step)
	if not (leg and leg.c == pc and leg.n >= 2) then return false end
	local n, xs, ys, zs = leg.n, leg.xs, leg.ys, leg.zs
	local ex, ey, reach = xs[n] - gx, ys[n] - gy, leg.left[n] + BAKED_END
	if ex * ex + ey * ey > reach * reach then return false end
	local best, bk, bt = huge, 1, 0
	for k = 1, n - 1 do
		local ax, ay = xs[k], ys[k]
		local dx, dy = xs[k + 1] - ax, ys[k + 1] - ay
		local len2 = dx * dx + dy * dy
		local t = len2 > 0 and ((px - ax) * dx + (py - ay) * dy) / len2 or 0
		if t < 0 then t = 0 elseif t > 1 then t = 1 end
		local qx, qy = ax + dx * t - px, ay + dy * t - py
		local d = qx * qx + qy * qy
		if d < best then best, bk, bt = d, k, t end
	end
	if best > STRAY * STRAY then return false end
	local za, zb = zs[bk], zs[bk + 1]
	ptsX[1], ptsY[1], ptsZ[1] = xs[bk] + (xs[bk + 1] - xs[bk]) * bt, ys[bk] + (ys[bk + 1] - ys[bk]) * bt, za + (zb - za) * bt
	local m = 1
	for k = bk + 1, n do
		m = m + 1
		ptsX[m], ptsY[m], ptsZ[m] = xs[k], ys[k], zs[k]
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
	if Walk.Split then Walk.Split() end
	changed()
	pumpLegs()
	return true
end

function Walk.Aim(pc, px, py, goalC, goalX, goalY, handmade, goalZ, stop)
	local P = engine()
	if P and P.SurfacesAt and pc then track(P, pc, px, py) end
	if handmade or not P or pc ~= goalC then
		if gc then Walk.Clear() end
		return nil
	end
	local tz = (type(goalZ) == "number" and goalZ) or targetZ(goalC, goalX, goalY) or false
	if gc ~= goalC or gx == nil or tz ~= gzFor or (goalX - gx) * (goalX - gx) + (goalY - gy) * (goalY - gy) > GOAL_MOVED * GOAL_MOVED then
		local had = count > 0 or shape ~= nil
		cancel()
		gc, gx, gy, count, idx, failed, hubs, shape = goalC, goalX, goalY, 0, 1, false, nil, nil
		Nav.follow.Reset(fstate)
		gzFor, gz = tz, tz or nil
		askedAt = -huge
		if had then changed() end
		if not takeBaked(pc, px, py) then ask(P, pc, px, py) end
	elseif floorAsk then
		-- Ruling 36b: arrived (login, hearth, a landing) or off ambiguous ground,
		-- the floor found after a search without a height: once more with it.
		floorAsk = false
		ask(P, pc, px, py)
	elseif failed then
		local dx, dy = px - failX, py - failY
		if GetTime() - failAt >= FAIL_RETRY and dx * dx + dy * dy > FAIL_MOVED * FAIL_MOVED then ask(P, pc, px, py) end
	elseif wanted then
		ask(P, pc, px, py)
	end
	if count == 0 then return nil end

	local ax, ay = Nav.follow.Step(ptsX, ptsY, ptsZ, left, count, fstate, px, py, stop)
	idx = fstate.idx
	if not ax then
		lastLeft = nil
		return nil
	end
	-- Yards left: straight to the end of the segment the player is on, then along the path.
	local ix, iy = ptsX[idx] or ptsX[count], ptsY[idx] or ptsY[count]
	local dx, dy = ix - px, iy - py
	lastLeft = sqrt(dx * dx + dy * dy) + left[idx <= count and idx or count]
	-- Re-ask only when the player has strayed from the path: walking beside it,
	-- or coming at it from the side, is the follower's to handle.
	if fstate.off > STRAY and token == nil and not wanted and GetTime() - askedAt >= ASK_EVERY then ask(P, pc, px, py) end
	return pc, ax, ay, lastLeft
end

local function isGoal(c, x, y)
	return count > 0 and gc == c and (x - gx) * (x - gx) + (y - gy) * (y - gy) <= GOAL_MOVED * GOAL_MOVED
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
--   Places: those on the target's continent within MEASURE_YARDS of it, the
--     nearest MEASURE_MAX, the player among them. Farther ones keep their
--     straight estimate. With no place but the player nothing is measured (a
--     lone walk is the arrow's own search, above).
--   No walk found (false: a flight master on a tower the engine cannot snap
--     from, Thunder Bluff's), a failed batch, or none found at all (the target
--     snapped off the ground): those keep their straight estimate.
--   The player's measure holds within START_NEAR yards of where it was taken;
--     farther, the player's walk is measured again with the next plan (once
--     per replan), and until it lands it is that measure less the yards
--     moved, never less than the straight distance (x1.0: a walk is never
--     priced dearer for having come closer).
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
--     in combat (owed until it ends; the engine pauses a running one), with
--     Walk real paths off, or while Shortest Path Forever guides.
---------------------------------------------------------------------------

local MEASURE_YARDS = 3000  -- straight yards from the target: places farther keep the estimate
local MEASURE_MAX = 16      -- places measured, nearest first
local MEASURE_KEEP = 4      -- targets whose measures are kept
local START_NEAR = 50       -- yards from where the player's walk was measured: its measure holds

local measures = {}         -- finished measures, oldest first
local measuring             -- the measure being taken: { c, x, y, water, pts, si, sx, sy, job }
local measureOwed           -- { c, x, y, water, places } put off by combat

local function sameTarget(e, c, x, y, water)
	local dx, dy = x - e.x, y - e.y
	return e.c == c and e.water == water and dx * dx + dy * dy <= GOAL_MOVED * GOAL_MOVED
end

local function findMeasure(c, x, y, water)
	for i = #measures, 1, -1 do
		if sameTarget(measures[i], c, x, y, water) then return measures[i] end
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
		if sameTarget(measures[i], e.c, e.x, e.y, e.water) then table.remove(measures, i) end
	end
	measures[#measures + 1] = e
	if #measures > MEASURE_KEEP then table.remove(measures, 1) end
end

-- The index of the place (x, y) among a measure's points (not the player's), or nil.
local function placeIndex(e, x, y)
	local pts = e.pts
	for i = 1, #pts do
		if i ~= e.si and pts[i].x == x and pts[i].y == y then return i end
	end
	return nil
end

-- The walk from (c, wx, wy) to the measure's target (the player's walk when
-- start): its cost (chooses) and its yards (times it; FindMany's job.yards[i],
-- the cost itself from a router without them), or nil for the straight
-- estimate. The player's walk measured more than START_NEAR yards away is
-- that walk's yards less the yards moved, never below the straight distance,
-- its cost scaled alike.
local function measuredCost(e, c, wx, wy, start)
	if c ~= e.c then return nil end
	local costs, yards = e.costs, e.yards
	local i
	if start then i = e.si else i = placeIndex(e, wx, wy) end
	local m = i and costs[i]
	if type(m) ~= "number" then return nil end
	local y = yards and yards[i]
	if type(y) ~= "number" then y = m end
	if not start then return m, y end
	local dx, dy = wx - e.sx, wy - e.sy
	local moved = sqrt(dx * dx + dy * dy)
	if moved <= START_NEAR then return m, y end
	dx, dy = e.x - wx, e.y - wy
	local least = sqrt(dx * dx + dy * dy)
	local rate = y > 0 and m / y or 1
	y = y - moved
	if y < least then y = least end
	return y * rate, y
end

-- The target's measured walks for the planner: walkCost(c, wx, wy, start) -> cost, yards | nil, or nil (none).
function Walk.Measured(c, x, y, water)
	if not engine() then return nil end
	local e = findMeasure(c, x, y, water or false)
	return e and e.lookup
end

-- One FindMany for a measure: from the target (at height z, when it has one) to
-- its places, reversed. A batch with the height that finds nothing is asked once
-- more without it.
local function batch(P, mine, z)
	local pts, water = mine.pts, mine.water
	local ok, handle = pcall(P.FindMany, mine.c, { x = mine.x, y = mine.y, z = z }, pts, function(costs, _, answer)
		if measuring ~= mine then return end
		mine.job = nil
		costs = type(costs) == "table" and costs or {}
		mine.yards = type(answer) == "table" and type(answer.yards) == "table" and answer.yards or nil
		local found = false
		for i = 1, #pts do
			if type(costs[i]) == "number" then found = true end
		end
		if not found and z then return batch(P, mine, nil) end
		measuring, mine.costs = nil, costs
		-- Kept either way: a target whose measure found nothing is not asked again.
		if found then
			mine.lookup = function(wc, wx, wy, start) return measuredCost(mine, wc, wx, wy, start) end
		end
		storeMeasure(mine)
		local T = Nav.travel
		local tc, tx, ty = Nav.GetTargetWorld()
		if found and tc and T and T.Remeasured and sameTarget(mine, tc, tx, ty, water) then T.Remeasured() end
		pumpLegs()
	end, opts(water, mine.c, nil, nil, mine.x, mine.y, mine.sx, mine.sy), true)
	if not ok then
		if z then return batch(P, mine, nil) end
		measuring = nil
		return
	end
	if measuring == mine then mine.job = handle end
end

-- Measure the walks into the target (c, x, y) from the plan's places (Travel's
-- p.places), unless they are measured or being measured, or c's walking maps
-- may not be searched yet (canSearch: the target is on another continent).
function Walk.Measure(c, x, y, water, places)
	water = water or false
	if measuring and not sameTarget(measuring, c, x, y, water) then cancelMeasure() end
	local P = engine()
	if not (P and P.FindMany) or type(places) ~= "table" or not canSearch(P, c) then return end
	if inCombat() then
		measureOwed = { c = c, x = x, y = y, water = water, places = places }
		return
	end
	measureOwed = nil
	if measuring then return end
	-- The nearest places within MEASURE_YARDS, nearest first.
	local pick, far = {}, {}
	local reach = MEASURE_YARDS * MEASURE_YARDS
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
	for _, p in ipairs(pick) do
		if not p.start then others = true end
	end
	if not others then return end
	local e = findMeasure(c, x, y, water)
	if e then
		local missing = false
		for _, p in ipairs(pick) do
			if p.start then
				-- The player was out of reach, or has walked away from where their walk was measured.
				local dx, dy = p.wx - (e.sx or p.wx), p.wy - (e.sy or p.wy)
				if not e.si or dx * dx + dy * dy > START_NEAR * START_NEAR then missing = true end
			elseif not placeIndex(e, p.wx, p.wy) then
				missing = true
			end
			if missing then break end
		end
		if not missing then return end
	end
	-- The places picked, the player's walk, and those the last measure had.
	local pts, si = {}, nil
	for _, p in ipairs(pick) do
		local z = p.z or (p.start and (startZ(c, p.wx, p.wy))) or nil
		pts[#pts + 1] = { x = p.wx, y = p.wy, z = z, floors = p.start and z == nil and startFloors(c, p.wx, p.wy) or nil }
		if p.start then si = #pts end
	end
	if e then
		for i, p in ipairs(e.pts) do
			if i ~= e.si then
				local seen = false
				for k = 1, #pts do
					if k ~= si and pts[k].x == p.x and pts[k].y == p.y then seen = true end
				end
				if not seen then pts[#pts + 1] = p end
			end
		end
	end
	local mine = { c = c, x = x, y = y, water = water, pts = pts, si = si, sx = si and pts[si].x, sy = si and pts[si].y }
	measuring = mine
	batch(P, mine, targetZ(c, x, y))
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
-- kept by its ends and water mode (the last LEG_KEEP), so the route lines
-- and the journey draw it along the ground and price it by its path. A walk
-- with neither is drawn straight and keeps its estimate; a failed search is
-- kept too, and its leg stays straight. The last walk goes with the target's
-- height (once more without it, as Z2). Hand-made walks along an approach
-- chain, the pieces of a split walk and the last walk to a target after a
-- guide `goto` (the arrow goes straight from the mouth) are never searched;
-- a crossing, walked straight by the arrow, is searched for its line, which
-- keeps the data's straight one when the path is more than CROSS_DETOUR
-- times as long, and is never priced by it. A search whose leg leaves the
-- route is cancelled; none starts in combat, with Walk real paths off, or
-- while Shortest Path Forever guides.
---------------------------------------------------------------------------

local LEG_KEEP = 32
local CROSS_DETOUR = 2
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
	return from.c .. ":" .. from.wx .. ":" .. from.wy .. ":" .. to.wx .. ":" .. to.wy .. (ghost and ":w" or "")
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
	if #legOrder > LEG_KEEP then legPaths[table.remove(legOrder, 1)] = nil end
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

-- Search one later walk (to at height z, when it has one; from at its own
-- height, a dock's board point on a deck); its answer is kept by key. A
-- search with a height that fails, or that ends off the goal's floor, is
-- asked once more without either (flat).
local function searchLeg(P, mine, key, from, to, z, ghost, flat)
	local T = Nav.travel
	local fz = not flat and from.z or nil
	if flat then z = nil end
	local ok, handle = pcall(P.Find, from.c, { x = from.wx, y = from.wy, z = fz }, { x = to.wx, y = to.wy, z = z }, function(points, _, answer)
		if legToken ~= mine then return end
		legJob = nil
		local got = type(points) == "table" and #points > 0
		if (z or fz) and (not got or (z and offFloor(points, z))) then return searchLeg(P, mine, key, from, to, nil, ghost, true) end
		legToken, legKey = nil, nil
		local e = false
		if got then
			local xs, ys, n, yards = line(points)
			if n > 1 then
				local a = type(answer) == "table" and answer or nil
				local h = a and a.hubs
				if a and type(a.yards) == "number" then yards = a.yards end
				e = { xs = xs, ys = ys, n = n, yards = yards, hubs = type(h) == "table" and #h > 0 and h or nil }
			end
		end
		keepLeg(key, e)
		-- Priced: ROUTE_CHANGED redraws; a failure keeps the straight line.
		if not (e and T and T.PricePaths and T.PricePaths()) then changed() end
		pumpLegs()
	end, opts(ghost, from.c, from.wx, from.wy, to.wx, to.wy))
	if not ok then
		if z or fz then return searchLeg(P, mine, key, from, to, nil, ghost, true) end
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
	searchLeg(P, mine, nextKey, nextLeg.from, to, (nextAt == #legs and targetZ(to.c, to.wx, to.wy)) or to.z, ghost)
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
		-- Never over the walk's own path (its search may have answered first).
		local was = legPaths[nextKey]
		if was == nil or was.cluster then
			local e = { coarse = true, n = 0, cluster = not whole and reason == "cluster" or nil }
			if type(points) == "table" then
				e.xs, e.ys, e.n, e.yards = line(points)
				local a = type(answer) == "table" and answer or nil
				if not points.coarse and e.n > 1 and not (z and offFloor(points, z)) then
					local h = a and a.hubs
					e.coarse, e.hubs = nil, type(h) == "table" and #h > 0 and h or nil
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
-- height, on the path's floor: one more than STOP_DZ yards above or below the
-- path's segment there is on another floor (the Undercity's canals 110 yd
-- under the Ruins) and is no stop. STOP_DZ is generous: the engine's path
-- heights are coarse and a mouth's packed height is its indoor floor (the
-- Fargodeep Mine's is 14-34 yd under the path's points beside it).
--   stop = { kind, name, zone, to (passages: the area beyond), wx, wy (on the
--     path), r, along (yards from here), seg, lift (Transit id), side
--     ("top"|"bottom": the landing boarded), endX, endY (the other landing) }
--   (name, zone, to in the client's language when it names them: the
--   chokepoints' AreaTable areas and lift objects, Polestar.Names)
---------------------------------------------------------------------------

local SNAP = 15        -- yards: a chokepoint without a radius counts within this of the path
local MIN_STEP = 20    -- yards: closer stops, or this close to either end, are dropped
local LOOK = 25        -- yards past a passage that tell which side is ahead
local STOP_DZ = 30     -- yards above or below the path: a chokepoint on another floor
local RIDE_DZ = 20     -- yards the path's height changes across a lift it rides

-- Nearest point on the path to (x, y): distance, segment, point, yards from the path's start.
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
	return sqrt(bestD), a, ptsX[a] + dx * bestT, ptsY[a] + dy * bestT, left[1] - left[a] + sqrt(dx * dx + dy * dy) * bestT
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

-- Whether the path rides a lift at segment a: its height changes RIDE_DZ yards or more from the point before the
-- segment to the one after it (the walking engine's path steps from one landing to the other).
local function rides(a)
	local before, after = ptsZ[a > 1 and a - 1 or 1], ptsZ[a + 2 <= count and a + 2 or count]
	return type(before) == "number" and type(after) == "number" and abs(after - before) >= RIDE_DZ
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
		local d, a, sx, sy, along = project(e.wx, e.wy)
		along = along - here
		-- A lift the path rides is a step however near the walk's ends (the Great Lift's
		-- bottom landing a few yards from the Thousand Needles crossing).
		local ridden = kind == "lift" and rides(a)
		if d > r or along < (ridden and -r or MIN_STEP) or (not ridden and along > total - MIN_STEP) then return end
		-- Another floor: the path's segment there runs STOP_DZ yards or more above or below the
		-- chokepoint at both its ends (a cave entry at the Undercity's canals under a walk over the Ruins);
		-- never a lift the path rides (its landings join the floors).
		local ez, za, zb = tonumber(e.z), ptsZ[a], ptsZ[a + 1]
		if not ridden and ez and za and zb and abs(za - ez) > STOP_DZ and abs(zb - ez) > STOP_DZ then return end
		found[#found + 1] = { kind = kind, entry = e, wx = sx, wy = sy, r = r < 5 and 5 or r > 20 and 20 or r, along = along, seg = a, ridden = ridden }
	end
	local packed = type(_G.PolestarNavChokepoints) == "table" and _G.PolestarNavChokepoints[gc]
	if type(packed) == "table" then
		for _, e in ipairs(packed) do
			if type(e) == "table" and e.wx and e.wy and e.kind then consider(e, e.kind) end
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
		if not used[e] and (f.along - lastAlong >= MIN_STEP or f.ridden) then
			local s = { kind = f.kind, name = areaName(e.area, e.name), zone = areaName(e.zoneArea, e.zone), wx = f.wx, wy = f.wy, r = f.r, along = f.along, seg = f.seg }
			if f.kind == "lift" then
				-- The landing boarded and the ride to its pair. The side comes from
				-- the path's height when it has one (K4): a packed lift's two
				-- landings lie a few yards apart, too close for the order along
				-- the path to tell them apart; else the landing reached first.
				local other = packed and e.pair and packed[e.pair]
				local up = climbs(f.seg)
				local side = up ~= nil and (up and "bottom" or "top") or e.liftEnd
				if other and side and e.liftEnd and other.liftEnd == side and e.liftEnd ~= side then
					e, other = other, e
					s.name, s.zone = areaName(e.area, e.name), areaName(e.zoneArea, e.zone)
				end
				if other then
					used[other] = true
					s.endX, s.endY = other.wx, other.wy
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
	local stops, total = Walk.Stops(pc, px, py)
	if stops then T.SplitWalk(gc, gx, gy, stops, total, hubs) end
end

---------------------------------------------------------------------------
-- Hand-made guide waypoints
---------------------------------------------------------------------------

local gotoTarget, gotoAnswer

-- The guide's last located goal before this target is a `goto`: the
-- author's way in (a cave's mouth), so the arrow goes straight from there.
function Walk.FollowsGoto(target)
	if target == gotoTarget then return gotoAnswer end
	gotoTarget, gotoAnswer = target, false
	if type(target) ~= "table" or not (target.stepIndex and target.goalIndex) then return false end
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	local steps = type(guide) == "table" and guide.steps
	if type(steps) ~= "table" then return false end
	local s, g = target.stepIndex, target.goalIndex - 1
	while s >= 1 do
		local goals = steps[s] and steps[s].goals
		if type(goals) == "table" then
			if g == nil then g = #goals end
			for k = g, 1, -1 do
				local goal = goals[k]
				if type(goal) == "table" and goal.map ~= nil and goal.x ~= nil then
					gotoAnswer = goal.t == "goto"
					return gotoAnswer
				end
			end
		end
		s, g = s - 1, nil
	end
	return false
end

---------------------------------------------------------------------------
-- Route geometry for the map lines
---------------------------------------------------------------------------

local KIND = { fly = "flight" }
local geom, geomBuilt, geomRoute = nil, -1, -1

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
-- CROSS_DETOUR times as long as the data's straight line; or nil.
local function ownLine(legs, i, ci, P)
	local leg = legs[i]
	if i == ci and not leg.handmade then return nil end
	if not (P and searchable(legs, i, P)) then return nil end
	local lp = legPath(leg.from, leg.to)
	if lp and leg.handmade then
		local dx, dy = leg.to.wx - leg.from.wx, leg.to.wy - leg.from.wy
		if lp.yards > CROSS_DETOUR * sqrt(dx * dx + dy * dy) then return nil end
	end
	return lp
end

local function build()
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
			local pts = {}
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
				-- straight from the mouth).
				local lp = ownLine(legs, i, ci, E)
				if lp then
					for k = 1, lp.n do pt(pts, from.c, lp.xs[k], lp.ys[k]) end
				elseif not walkPoints(pts, to.c, to.wx, to.wy) and not (i == ci and shapePoints(pts, to.c, to.wx, to.wy)) then
					if i == ci and pc == from.c then pt(pts, pc, px, py) else pt(pts, from.c, from.wx, from.wy) end
					pt(pts, to.c, to.wx, to.wy)
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
			out[#out + 1] = { kind = KIND[leg.kind] or leg.kind, pts = pts, current = i == ci, choke = leg.choke }
		end
	else
		local tc, tx, ty = Nav.GetTargetWorld()
		if tc then
			local pts = {}
			if not walkPoints(pts, tc, tx, ty) and not shapePoints(pts, tc, tx, ty) and pc == tc then
				pt(pts, pc, px, py)
				pt(pts, tc, tx, ty)
			end
			if #pts > 0 then out[1] = { kind = "walk", pts = pts, current = true } end
		end
	end
	return { legs = out }
end

function Nav.GetRouteGeometry()
	if not Nav.GetTarget() or Nav.HandedOff() then return nil end
	local T = Nav.travel
	local route = T and T.version or 0
	if not geom or geomBuilt ~= geomVersion or geomRoute ~= route then
		geom, geomBuilt, geomRoute = build(), geomVersion, route
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
ns.On("ROUTE_ADVANCED", function()
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
	local o = measureOwed
	if o and not inCombat() then
		measureOwed = nil
		local tc, tx, ty = Nav.GetTargetWorld()
		if tc and sameTarget(o, tc, tx, ty, o.water) then Walk.Measure(o.c, o.x, o.y, o.water, o.places) end
	end
	if shapesOwed and not shapeToken then pumpShapes() end
	if legsWanted then pumpLegs() end
end

ns.OnLogin(function()
	if ns.Get("nav.navRouting") then load() end
end)

Nav.RegisterModule(Walk)
