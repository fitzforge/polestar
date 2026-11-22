-- Mirrors the target to other navigation systems:
--   TomTom (nav.tomtom): one waypoint, replaced whenever the target changes;
--     nav.useTomTomArrow hands the arrow over to TomTom's, on the target's
--     continent (Nav.TomTomArrowGuides). While TomTom's arrow guides and a
--     route is followed, the waypoint is the current leg's stop (a flight
--     master, a dock, a portal: Travel.Stop), moved on as the legs change, so
--     TomTom's arrow leads the way Polestar's would: to Booty Bay's flight
--     master for a flight to Grom'gol, not up the coast (#1834).
--   Blizzard's user waypoint (nav.blizzardWaypoint, off by default):
--     C_Map.SetUserWaypoint plus C_SuperTrack, cleared only while it is still
--     the pin we set (never one another addon or the player put over it), and
--     never on stepping aside for Shortest Path Forever: its guide keeps that
--     pin to put back when its journey ends.
--     With Waypoint UI loaded (its public WaypointUIAPI.Navigation), which
--     draws the game's tracked target in the world: a turn-in, or an objective
--     at one spot, whose quest is in the log tracks the quest itself, so
--     Waypoint UI shows its own quest marker (an objective over an area, a kill
--     or collect among spawns, is not: the game points nowhere while you are in
--     it, where Polestar's target is a spot); any other target is a pin named
--     after the target, set through Waypoint UI (flag "Polestar"), which sets
--     the game's pin and tracking itself. While a route is followed, the pin
--     is the current leg's stop instead (a flight master, a dock, a portal,
--     a crossing: Travel.Stop), moved on as the legs change, so Waypoint UI's
--     beacon leads the way the arrow does (#1741). Only what Polestar set is
--     cleared: a pin flagged as ours, the quest we tracked while still tracked.
-- Both take live-frame map percent, so Era-frame targets are converted first.
-- Neither mirrors while the target is handed to Shortest Path Forever
-- (Nav/Handoff.lua): its TomTom stand-in would start a second journey, and
-- either would be a second arrow.

local ADDON, ns = ...
local Nav = ns.Nav

local Bridges = {}
Nav.bridges = Bridges

local tomtomUid, tomtomOwner -- only the waypoint this bridge added
local tomtomGuides = false
local blizzardSet = false
local blizzardAt      -- the game's pin we set: { uiMapID, x, y } (0-1)
local blizzardTracked
local wuiSet = false   -- a Waypoint UI pin of ours
local wuiLast         -- the pin last set: label, map, x, y (an unchanged target is not sent again)
local questSet         -- the quest we super-tracked

local FLAG = "Polestar"

-- Waypoint UI's public navigation API, when the addon is loaded.
local function waypointUI()
	local api = type(WaypointUIAPI) == "table" and WaypointUIAPI.Navigation
	if type(api) == "table" and type(api.NewUserNavigation) == "function" and type(api.ClearUserNavigation) == "function"
		and type(api.IsUserNavigationFlagged) == "function" then
		return api
	end
end

local function inLog(q)
	local C = ns.Compat
	if C and C.IsOnQuest then return C.IsOnQuest(q) end
	return C_QuestLog and C_QuestLog.IsOnQuest and C_QuestLog.IsOnQuest(q) and true or false
end

-- Real TomTom only, installed and enabled: with TomTom absent the global is
-- another addon's stand-in for it. Nav/Journey.lua's answers other addons'
-- calls by setting our target, so mirroring into it would loop. Shortest Path
-- Forever's would loop too: our waypoint starts a journey of its own,
-- Polestar steps aside for it, the mirror goes, the journey ends and Polestar
-- takes it back, every frame (#306). A waypoint addon's makes our waypoint its
-- own arrow's when it has none, whatever `crazy` says: a second arrow on
-- Polestar's target, and its pins over Polestar's.
local function tomtom()
	local T = TomTom
	if T == Nav.tomtomShim then return nil end
	local C = ns.Compat
	if not (C and C.AddOnPresent and C.AddOnPresent("TomTom")) then return nil end
	if type(T) == "table" and type(T.AddWaypoint) == "function" and type(T.RemoveWaypoint) == "function" then return T end
end

function Nav.UsingTomTomArrow()
	return ns.Get("nav.tomtom") and ns.Get("nav.useTomTomArrow") and tomtom() ~= nil or false
end

-- The arrow asks every sample. Publish the handoff only after its waypoint is set.
function Nav.TomTomArrowGuides()
	return tomtomGuides
end

local function syncTomTom(T, target, wantsArrow, guide, stop, map, x, y)
	local label, r
	if guide and stop then
		label = stop
		if label == "" then label = target.label end
		r = Nav.DEFAULT_RADIUS
	elseif target and (not wantsArrow or guide) then
		label, r = target.label, (target.r or Nav.DEFAULT_RADIUS) + (tonumber(target.area) or 0)
		if not guide then map, x, y = Nav.LiveCoords(target) end
	end
	local J = Nav.journey
	local followed = T and target and J and J.IsTomTomTarget(target)
	if tomtomUid then
		tomtomOwner:RemoveWaypoint(tomtomUid)
		tomtomUid, tomtomOwner = nil, nil
	end
	-- A waypoint followed from another arrow belongs to its owner. Leave it alone;
	-- it can replace ours only when the goal itself is the verified bearing.
	if followed then return guide and not stop end
	-- With auto-selection enabled, even a passive replacement could become
	-- the closest arrow after our old waypoint is removed. In arrow mode
	-- publish nothing until there is a checked bearing.
	if not (T and target and map and (not wantsArrow or guide)) then return false end
	tomtomUid = T:AddWaypoint(map, x / 100, y / 100, {
		title = label,
		from = "Polestar",
		persistent = false,
		silent = true,
		-- TomTom draws its own pins only where Polestar's are switched off.
		minimap = not ns.Get("nav.minimapPins"),
		world = not ns.Get("nav.worldPins"),
		crazy = guide,
		cleardistance = 0,
		arrivaldistance = r,
	})
	-- AddWaypoint can return someone else's existing waypoint with the same key.
	if type(tomtomUid) == "table" and tomtomUid.from and tomtomUid.from ~= "Polestar" then tomtomUid = nil end
	tomtomOwner = tomtomUid and T
	return guide and tomtomUid ~= nil
end

local function makePoint(map, x, y)
	if UiMapPoint and UiMapPoint.CreateFromCoordinates then
		return UiMapPoint.CreateFromCoordinates(map, x, y)
	end
	if CreateVector2D then return { uiMapID = map, position = CreateVector2D(x, y) } end
end

-- Clears what Polestar set through Waypoint UI or as a tracked quest, never the player's own.
local function clearWaypointUI(W)
	wuiLast = nil
	if wuiSet then
		wuiSet = false
		if W and W.IsUserNavigationFlagged(FLAG) then W.ClearUserNavigation() end
	end
	if questSet then
		local ST = C_SuperTrack
		if ST and ST.GetSuperTrackedQuestID and ST.SetSuperTrackedQuestID and ST.GetSuperTrackedQuestID() == questSet then
			ST.SetSuperTrackedQuestID(0)
		end
		questSet = nil
	end
end

-- A quest goal the game's own quest tracking points at: a turn-in, or an
-- objective at one spot. Not an accept (not in the log yet), nor an objective
-- over an area or among spawns (the game has no point to show inside it).
local function questTrackable(target)
	local q = tonumber(target.quest)
	if not q or target.kind == "accept" or not inLog(q) then return nil end
	if target.kind ~= "turnin" and (target.area or target.spots or target.search) then return nil end
	return q
end

-- A world point in live-frame map percent of `map`, when it lies on it.
local function onMap(map, c, wx, wy)
	local C = ns.Compat
	if not (map and C and C.WorldToMap) then return nil end
	local x, y = C.WorldToMap(c, wx, wy, map)
	if not (x and y and x >= 0 and x <= 100 and y >= 0 and y <= 100) then return nil end
	return x, y
end

-- Where the arrow's current leg leads while a route is followed (a flight
-- master, a dock, a portal, a crossing: Travel.Stop), with the leg's label,
-- in live-frame map percent: on the point's own map, else the zone the
-- walking maps put it in, else the target's map. No ground waypoint for an
-- interaction here, or if a stop cannot be placed on a map.
local function steeringPoint(target, taxi)
	local T = Nav.travel
	local leg = T and T.CurrentLeg and T.CurrentLeg()
	if not taxi and leg and (leg.taxiOffer or leg.kind == "hearth" or leg.kind == "teleport") then return end
	local p, label
	if T and T.Stop and not taxi then p, label = T.Stop() end
	if not p then
		if not taxi and leg and leg.kind ~= "walk" then return end
		return nil, Nav.LiveCoords(target)
	end
	if not (p.c and p.wx and p.wy) then return end
	local x, y = onMap(p.map, p.c, p.wx, p.wy)
	if x then return label or "", p.map, x, y end
	local zone = T.ZoneOf and T.ZoneOf(p.map, p.c, p.wx, p.wy)
	x, y = onMap(zone, p.c, p.wx, p.wy)
	if x then return label or "", zone, x, y end
	x, y = onMap(target.map, p.c, p.wx, p.wy)
	if x then return label or "", target.map, x, y end
	return nil
end

-- Check the direct bearing the receiving addon will draw, not the plan that
-- led to its endpoint. This 2D policy needs neither an open map nor a floor.
local function clearBearing(pc, px, py, map, x, y, taxi)
	local C = ns.Compat
	if not (pc and px and py and C and C.MapToWorld) then return false end
	local c, wx, wy = C.MapToWorld(map, x, y)
	return c ~= nil and c == pc and wx ~= nil and wy ~= nil and (taxi or Nav.CanDrawGroundApproach(c, px, py, wx, wy))
end

-- The game may supertrack a different point for a quest. Without a readable
-- waypoint for this spot, send our checked point as a named pin instead.
local function trackedQuest(target, pc, px, py, map, x, y, taxi)
	local q = questTrackable(target)
	if not (q and C_QuestLog and C_QuestLog.GetNextWaypoint) then return end
	local ok, m, a, b = pcall(C_QuestLog.GetNextWaypoint, q)
	if not ok or (issecretvalue and (issecretvalue(m) or issecretvalue(a) or issecretvalue(b)))
		or m ~= map or type(a) ~= "number" or type(b) ~= "number" then return end
	a, b = a * 100, b * 100
	if math.abs(a - x) <= 0.05 and math.abs(b - y) <= 0.05
		and ((a == x and b == y) or clearBearing(pc, px, py, m, a, b, taxi)) then return q end
end

-- With Waypoint UI: "quest" or "pin" when the target is shown through it.
-- On a route, the pin is the current leg's stop, so its beacon leads the way
-- the arrow does (the portal first, then the bank: #1741); the target itself
-- (its quest tracked, or its pin) once the last walk to it begins.
local function syncWaypointUI(W, label, map, x, y, q)
	local ST = C_SuperTrack
	if q and ST and ST.SetSuperTrackedQuestID then
		if wuiSet then
			wuiSet, wuiLast = false, nil
			if W.IsUserNavigationFlagged(FLAG) then W.ClearUserNavigation() end
		end
		-- Already the tracked quest: nothing to tell the game (or Waypoint UI) again.
		if not (questSet == q and ST.GetSuperTrackedQuestID and ST.GetSuperTrackedQuestID() == q) then
			ST.SetSuperTrackedQuestID(q)
		end
		questSet = q
		return "quest"
	end
	if not map or (C_Map and C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(map)) then return false end
	if questSet then clearWaypointUI(nil) end
	-- The same pin again (the target re-announced, an area's spot unchanged,
	-- the route planned again the same way): Waypoint UI is not asked to
	-- redraw it while it still holds ours.
	local L = wuiLast
	if wuiSet and L and L.label == label and L.map == map and L.x == x and L.y == y
		and W.IsUserNavigationFlagged(FLAG) then
		return "pin"
	end
	W.NewUserNavigation({ name = label, mapID = map, x = x, y = y, flags = FLAG, suppressAudio = true })
	wuiSet, wuiLast = true, { label = label, map = map, x = x, y = y }
	return "pin"
end

-- Is the game's pin still the one we set (the same map and point)? Without
-- C_Map.GetUserWaypoint to ask, it is taken to be.
local function ourPin()
	local get = C_Map and C_Map.GetUserWaypoint
	if not get then return true end
	local p, at = get(), blizzardAt
	if not (p and at and p.uiMapID == at[1] and p.position) then return false end
	local x, y = p.position.x, p.position.y
	if p.position.GetXY then x, y = p.position:GetXY() end
	return x ~= nil and y ~= nil and math.abs(x - at[2]) < 1e-4 and math.abs(y - at[3]) < 1e-4
end

local function trackOurPin(track)
	local ST = C_SuperTrack
	if ST and ST.SetSuperTrackedUserWaypoint then
		if track or not ST.IsSuperTrackingUserWaypoint or ST.IsSuperTrackingUserWaypoint() then
			ST.SetSuperTrackedUserWaypoint(track)
		end
		blizzardTracked = track
	end
end

local function syncBlizzard(target, W, on, stop, map, x, y, q, refresh)
	-- Waypoint UI loaded: the tracked quest or a named pin, through it.
	local shown = on and W and map and syncWaypointUI(W, stop or target.label, map, x, y, q)
	if shown then
		-- A named pin replaces a plain one of ours (Waypoint UI sets the game's
		-- pin itself); a tracked quest does not, so ours is cleared (a target
		-- set as a plain pin before Waypoint UI's API was ready).
		if blizzardSet and shown == "quest" and ourPin() and C_Map and C_Map.ClearUserWaypoint then C_Map.ClearUserWaypoint() end
		blizzardSet = false
		return
	end
	if wuiSet or questSet then clearWaypointUI(W) end
	-- Without Waypoint UI: the game's own pin, unnamed.
	if on and not W and C_Map and C_Map.SetUserWaypoint then
		local track = map ~= nil and not stop
		local map, x, y = Nav.LiveCoords(target)
		if map and (not C_Map.CanSetUserWaypointOnMap or C_Map.CanSetUserWaypointOnMap(map)) then
			local at = blizzardSet and blizzardAt
			if at and at[1] == map and at[2] == x / 100 and at[3] == y / 100 then
				-- A refresh must not take back a pin someone else set over ours.
				if ourPin() then
					if track ~= blizzardTracked then trackOurPin(track) end
					return
				elseif refresh then return end
			end
			local point = makePoint(map, x / 100, y / 100)
			if point then
				C_Map.SetUserWaypoint(point)
				blizzardSet, blizzardAt = true, { map, x / 100, y / 100 }
				trackOurPin(track)
				return
			end
		end
	end
	if blizzardSet then
		blizzardSet = false
		-- Only our own pin goes, never one another addon or the player set over
		-- it. Stepping aside for Shortest Path Forever (Nav.HandedOff) it stays:
		-- its guide keeps the pin it found, to put back when its journey ends,
		-- and reads that pin cleared under it as the player taking over: it
		-- stopped guiding the moment Polestar handed it the target.
		if not Nav.HandedOff() and ourPin() and C_Map and C_Map.ClearUserWaypoint then C_Map.ClearUserWaypoint() end
	end
end

local lastTarget, lastW, lastStop, lastMap, lastX, lastY, lastQuest, lastGuide
local function sync(target, refresh)
	local enabled = target and not Nav.HandedOff() and not ns.ArrowHidden()
	local T = enabled and ns.Get("nav.tomtom") and tomtom()
	local wantsArrow = T and ns.Get("nav.useTomTomArrow")
	local pin = enabled and ns.Get("nav.blizzardWaypoint") and not (Nav.FollowerPins and Nav.FollowerPins())
	local W = waypointUI()
	local stop, map, x, y, q
	local guide = false
	if wantsArrow or (pin and (W or (C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint))) then
		local C = ns.Compat
		local taxi = C and C.IsOnTaxi and C.IsOnTaxi()
		local pc, px, py
		if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
		stop, map, x, y = steeringPoint(target, taxi)
		if map and clearBearing(pc, px, py, map, x, y, taxi) then
			guide = wantsArrow and pc == Nav.GetTargetWorld() or false
			if pin and W and not stop then q = trackedQuest(target, pc, px, py, map, x, y, taxi) end
		else
			stop, map, x, y = nil, nil, nil, nil
		end
	end
	-- Refresh runs on movement/situation ticks, not in the arrow's frame loop.
	-- Don't reassert a marker (especially one the player replaced) just because
	-- the player moved if the handoff hasn't changed.
	if refresh and target == lastTarget and W == lastW and stop == lastStop and map == lastMap
		and x == lastX and y == lastY and q == lastQuest and guide == lastGuide then return end
	local changed = target ~= lastTarget or guide ~= lastGuide or (guide and (stop ~= lastStop or map ~= lastMap or x ~= lastX or y ~= lastY))
	lastTarget, lastW, lastStop, lastMap, lastX, lastY, lastQuest, lastGuide = target, W, stop, map, x, y, q, guide
	local before = tomtomGuides
	if not refresh or (changed and (wantsArrow or tomtomGuides)) then
		tomtomGuides = syncTomTom(T, target, wantsArrow, guide, stop, map, x, y) or false
	end
	syncBlizzard(target, W, pin, stop, map, x, y, q, refresh)
	if before ~= tomtomGuides then Nav.arrow:Refresh() end
end

function Bridges:OnTarget(target)
	sync(target, false)
end

function Bridges:Refresh()
	sync(Nav.GetTarget(), true)
end

-- Only the settings these bridges read trigger a resync, so dragging the
-- arrow or changing its scale never churns TomTom's waypoint list.
local tracked = { tomtom = true, useTomTomArrow = true, worldPins = true, minimapPins = true, blizzardWaypoint = true, arrowToFollower = true }
local seen = {}

function Bridges:OnSettings()
	local changed = false
	for key in pairs(tracked) do
		local v = ns.Get("nav." .. key) and true or false
		if seen[key] ~= v then
			seen[key] = v
			changed = true
		end
	end
	if changed then self:OnTarget(Nav.GetTarget()) end
end

Nav.RegisterModule(Bridges)
ns.On("POLESTAR_HIDDEN", function() Bridges:OnTarget(Nav.GetTarget()) end)

-- A new plan or the next leg: Waypoint UI's pin moves to the new stop (#1741),
-- and so does TomTom's waypoint while TomTom's arrow guides (#1834). The
-- game's plain pin, and TomTom's as a mere mirror, stay on the target.
local function onRoute() Bridges:Refresh() end
ns.On("ROUTE_CHANGED", onRoute)
ns.On("ROUTE_ADVANCED", onRoute)

-- A walking search can refuse the current leg between situation ticks. Take
-- back a bearing that was guiding there; never run the sampler to query it.
ns.On("NAV_ROUTE_GEOMETRY", function()
	if (tomtomGuides or wuiSet or questSet or (blizzardSet and blizzardTracked))
		and not Nav.CanDrawGroundApproach() then Bridges:Refresh() end
end)
