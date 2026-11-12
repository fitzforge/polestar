-- Mirrors the target to other navigation systems:
--   TomTom (nav.tomtom): one waypoint, replaced whenever the target changes;
--     nav.useTomTomArrow hands the arrow over to TomTom's, on the target's
--     continent (Nav.TomTomArrowGuides). While TomTom's arrow guides and a
--     route is followed, the waypoint is the current leg's stop (a flight
--     master, a dock, a portal: Travel.Stop), moved on as the legs change, so
--     TomTom's arrow leads the way Polestar's would: to Booty Bay's flight
--     master for a flight to Grom'gol, not up the coast (#1834).
--   Blizzard's user waypoint (nav.blizzardWaypoint, off by default):
--     C_Map.SetUserWaypoint plus C_SuperTrack, cleared only if we set it.
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

local tomtomUid      -- TomTom waypoint we own
local blizzardSet = false
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

-- TomTom's arrow measures nothing to a waypoint on another continent and
-- hides itself there (#1325: Durotar to Loch Modan showed no arrow at all).
-- So it guides only while the player stands on the target's continent;
-- elsewhere Polestar's own arrow and its route (a zeppelin, a boat) do. An
-- unknown position or target stays TomTom's. Allocation-free (the arrow asks
-- every sample).
function Nav.TomTomArrowGuides()
	if not Nav.UsingTomTomArrow() then return false end
	local tc = Nav.GetTargetWorld()
	local C = ns.Compat
	local pc = C and C.GetPlayerWorldPosition and C.GetPlayerWorldPosition()
	return tc == nil or pc == nil or tc == pc
end

local routeStop -- (below)
local tomtomAt -- the waypoint ours holds: "label|map|x|y" (an unchanged stop is not sent again)

local function syncTomTom(target, onRoute)
	local T = tomtom()
	-- While TomTom's arrow guides a route, its waypoint is the current leg's stop, else the target.
	local label, map, x, y, r
	if T and target and Nav.TomTomArrowGuides() then label, map, x, y = routeStop(target) end
	if label then
		if label == "" then label = target.label end
		r = Nav.DEFAULT_RADIUS
	elseif target then
		label, r = target.label, (target.r or Nav.DEFAULT_RADIUS) + (tonumber(target.area) or 0)
		map, x, y = Nav.LiveCoords(target)
	end
	local at = map and string.format("%s|%d|%.2f|%.2f", tostring(label), map, x, y)
	if onRoute and tomtomUid and at == tomtomAt then return end
	if tomtomUid then
		if T then T:RemoveWaypoint(tomtomUid) end
		tomtomUid, tomtomAt = nil, nil
	end
	-- A mirror is the arrow's: none while hiding Polestar takes the arrow (ns.ArrowHidden).
	if not (T and target and ns.Get("nav.tomtom")) or Nav.HandedOff() or ns.ArrowHidden() then return end
	-- A waypoint followed from TomTom's arrow (Nav/Journey.lua) is in TomTom already.
	local J = Nav.journey
	if J and J.IsTomTomTarget(target) then return end
	if not map then return end
	tomtomAt = at
	tomtomUid = T:AddWaypoint(map, x / 100, y / 100, {
		title = label,
		from = "Polestar",
		persistent = false,
		silent = true,
		-- TomTom draws its own pins only where Polestar's are switched off.
		minimap = not ns.Get("nav.minimapPins"),
		world = not ns.Get("nav.worldPins"),
		crazy = ns.Get("nav.useTomTomArrow") and true or false,
		cleardistance = 0,
		arrivaldistance = r,
	})
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
-- walking maps put it in, else the target's map. nil on the route's last
-- walk, with no route, or for a point on none of them.
function routeStop(target)
	local T = Nav.travel
	local p, label
	if T and T.Stop then p, label = T.Stop() end
	if not (p and p.c and p.wx and p.wy) then return nil end
	local x, y = onMap(p.map, p.c, p.wx, p.wy)
	if x then return label or "", p.map, x, y end
	local zone = T.ZoneOf and T.ZoneOf(p.map, p.c, p.wx, p.wy)
	x, y = onMap(zone, p.c, p.wx, p.wy)
	if x then return label or "", zone, x, y end
	x, y = onMap(target.map, p.c, p.wx, p.wy)
	if x then return label or "", target.map, x, y end
	return nil
end

-- With Waypoint UI: "quest" or "pin" when the target is shown through it.
-- On a route, the pin is the current leg's stop, so its beacon leads the way
-- the arrow does (the portal first, then the bank: #1741); the target itself
-- (its quest tracked, or its pin) once the last walk to it begins.
local function syncWaypointUI(W, target)
	local ST = C_SuperTrack
	local label, map, x, y = routeStop(target)
	local q = not label and questTrackable(target)
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
	if not label then
		label = target.label
		map, x, y = Nav.LiveCoords(target)
	end
	if not map or (C_Map and C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(map)) then return false end
	if questSet then clearWaypointUI(nil) end
	-- The same pin again (the target re-announced, an area's spot unchanged,
	-- the route planned again the same way): Waypoint UI is not asked to
	-- redraw it while it still holds ours.
	local L = wuiLast
	if wuiSet and L and L.label == label and L.map == map and math.abs(L.x - x) < 0.05 and math.abs(L.y - y) < 0.05
		and W.IsUserNavigationFlagged(FLAG) then
		return "pin"
	end
	W.NewUserNavigation({ name = label, mapID = map, x = x, y = y, flags = FLAG, suppressAudio = true })
	wuiSet, wuiLast = true, { label = label, map = map, x = x, y = y }
	return "pin"
end

local retrying = false

local function syncBlizzard(target)
	local on = ns.Get("nav.blizzardWaypoint") and target and not Nav.HandedOff() and not ns.ArrowHidden()
	local W = waypointUI()
	-- Waypoint UI loads after Polestar and fills its API late: look again once
	-- (the first target after login is set before it is ready).
	local C = ns.Compat
	local present = type(WaypointUIAPI) == "table" or (C and C.AddOnPresent and C.AddOnPresent("WaypointUI"))
	if on and not W and not retrying and present then
		retrying = true
		ns.After(2, function()
			retrying = false
			if waypointUI() then syncBlizzard(Nav.GetTarget()) end
		end)
	end
	-- Waypoint UI loaded: the tracked quest or a named pin, through it.
	local shown = on and W and syncWaypointUI(W, target)
	if shown then
		-- A named pin replaces a plain one of ours (Waypoint UI sets the game's
		-- pin itself); a tracked quest does not, so ours is cleared (a target
		-- set as a plain pin before Waypoint UI's API was ready).
		if blizzardSet and shown == "quest" and C_Map and C_Map.ClearUserWaypoint then C_Map.ClearUserWaypoint() end
		blizzardSet = false
		return
	end
	if wuiSet or questSet then clearWaypointUI(W) end
	-- Without Waypoint UI: the game's own pin, unnamed.
	if on and not W and C_Map and C_Map.SetUserWaypoint then
		local map, x, y = Nav.LiveCoords(target)
		if map and (not C_Map.CanSetUserWaypointOnMap or C_Map.CanSetUserWaypointOnMap(map)) then
			local point = makePoint(map, x / 100, y / 100)
			if point then
				C_Map.SetUserWaypoint(point)
				blizzardSet = true
				if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
					C_SuperTrack.SetSuperTrackedUserWaypoint(true)
				end
				return
			end
		end
	end
	if blizzardSet then
		blizzardSet = false
		if C_Map and C_Map.ClearUserWaypoint then C_Map.ClearUserWaypoint() end
	end
end

function Bridges:OnTarget(target)
	syncTomTom(target)
	syncBlizzard(target)
end

-- Only the settings these bridges read trigger a resync, so dragging the
-- arrow or changing its scale never churns TomTom's waypoint list.
local tracked = { tomtom = true, useTomTomArrow = true, worldPins = true, minimapPins = true, blizzardWaypoint = true }
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
local function onRoute()
	local target = Nav.GetTarget()
	if Nav.TomTomArrowGuides() then syncTomTom(target, true) end
	if waypointUI() then syncBlizzard(target) end
end
ns.On("ROUTE_CHANGED", onRoute)
ns.On("ROUTE_ADVANCED", onRoute)
