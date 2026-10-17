-- Mirrors the target to other navigation systems:
--   TomTom (nav.tomtom): one waypoint, replaced whenever the target changes;
--     nav.useTomTomArrow hands the arrow over to TomTom's.
--   Blizzard's user waypoint (nav.blizzardWaypoint, off by default):
--     C_Map.SetUserWaypoint plus C_SuperTrack, cleared only if we set it.
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

-- Real TomTom only: Nav/Journey.lua's stand-in answers other addons' calls
-- by setting our target, so mirroring into it would loop. Shortest Path
-- Forever's stand-in (TomTom not installed) would loop too: our waypoint
-- starts a journey of its own, Polestar steps aside for it, the mirror goes,
-- the journey ends and Polestar takes it back, every frame (#306).
local function tomtom()
	local T = TomTom
	if T == Nav.tomtomShim then return nil end
	local H, C = Nav.handoff, ns.Compat
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

local function syncBlizzard(target)
	if ns.Get("nav.blizzardWaypoint") and target and not Nav.HandedOff() and C_Map and C_Map.SetUserWaypoint then
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
