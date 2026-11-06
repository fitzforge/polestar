-- Mirrors the target to other navigation systems:
--   TomTom (nav.tomtom): one waypoint, replaced whenever the target changes;
--     nav.useTomTomArrow hands the arrow over to TomTom's.
--   Blizzard's user waypoint (nav.blizzardWaypoint, off by default):
--     C_Map.SetUserWaypoint plus C_SuperTrack, cleared only if we set it.
--     With Waypoint UI loaded (its public WaypointUIAPI.Navigation), which
--     draws the game's tracked target in the world: a turn-in, or an objective
--     at one spot, whose quest is in the log tracks the quest itself, so
--     Waypoint UI shows its own quest marker (an objective over an area, a kill
--     or collect among spawns, is not: the game points nowhere while you are in
--     it, where Polestar's target is a spot); any other target is a pin named
--     after the target, set through Waypoint UI (flag "Polestar"), which sets
--     the game's pin and tracking itself. Only what Polestar set is cleared:
--     a pin flagged as ours, the quest we tracked while still tracked.
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

-- Real TomTom only: Nav/Journey.lua's stand-in answers other addons' calls
-- by setting our target, so mirroring into it would loop. Shortest Path
-- Forever's stand-in (TomTom not installed) would loop too: our waypoint
-- starts a journey of its own, Polestar steps aside for it, the mirror goes,
-- the journey ends and Polestar takes it back, every frame (#306).
local function tomtom()
	local T = TomTom
	if T == Nav.tomtomShim then return nil end
	local H, C = Nav.handoff, ns.Compat
	-- Shortest Path present, TomTom absent: on purpose, this also skips a third addon's TomTom-compatible global.
	if H and H.Available() and not (C and C.AddOnPresent and C.AddOnPresent("TomTom")) then return nil end
	if type(T) == "table" and type(T.AddWaypoint) == "function" and type(T.RemoveWaypoint) == "function" then return T end
end

function Nav.UsingTomTomArrow()
	return ns.Get("nav.tomtom") and ns.Get("nav.useTomTomArrow") and tomtom() ~= nil or false
end

local function syncTomTom(target)
	local T = tomtom()
	if tomtomUid then
		if T then T:RemoveWaypoint(tomtomUid) end
		tomtomUid = nil
	end
	if not (T and target and ns.Get("nav.tomtom")) or Nav.HandedOff() then return end
	-- A waypoint followed from TomTom's arrow (Nav/Journey.lua) is in TomTom already.
	local J = Nav.journey
	if J and J.IsTomTomTarget(target) then return end
	local map, x, y = Nav.LiveCoords(target)
	if not map then return end
	tomtomUid = T:AddWaypoint(map, x / 100, y / 100, {
		title = target.label,
		from = "Polestar",
		persistent = false,
		silent = true,
		-- TomTom draws its own pins only where Polestar's are switched off.
		minimap = not ns.Get("nav.minimapPins"),
		world = not ns.Get("nav.worldPins"),
		crazy = ns.Get("nav.useTomTomArrow") and true or false,
		cleardistance = 0,
		arrivaldistance = (target.r or Nav.DEFAULT_RADIUS) + (tonumber(target.area) or 0),
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

-- With Waypoint UI: true when the target is shown through it.
local function syncWaypointUI(W, target)
	local ST = C_SuperTrack
	local q = questTrackable(target)
	if q and ST and ST.SetSuperTrackedQuestID then
		if wuiSet then
			wuiSet = false
			if W.IsUserNavigationFlagged(FLAG) then W.ClearUserNavigation() end
		end
		ST.SetSuperTrackedQuestID(q)
		questSet = q
		return true
	end
	local map, x, y = Nav.LiveCoords(target)
	if not map or (C_Map and C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(map)) then return false end
	if questSet then clearWaypointUI(nil) end
	W.NewUserNavigation({ name = target.label, mapID = map, x = x, y = y, flags = FLAG, suppressAudio = true })
	wuiSet = true
	return true
end

local retrying = false

local function syncBlizzard(target)
	local on = ns.Get("nav.blizzardWaypoint") and target and not Nav.HandedOff()
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
	if on and W and syncWaypointUI(W, target) then
		blizzardSet = false -- Waypoint UI replaced any plain pin of ours
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
