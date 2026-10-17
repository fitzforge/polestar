-- Journeys: going anywhere, and letting other addons steer the arrow.
--
-- Adapted from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission): Journey/JourneyInput.lua (Shift- and Alt-click
-- planning), Core/API.lua (the public API), Core/TomTom.lua (the TomTom
-- stand-in) and Core/Way.lua (/way).
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
--   * Plan to anywhere (nav.mapPlan): Shift-click empty space on the world
--     map or the minimap and the arrow points there, routed like any target
--     (Nav.SetTarget, labelled with the zone and its coordinates). Alt-click
--     does the same on the world map over its icons too, named after the
--     icon (a flight master, a dungeon entrance), except Polestar's own
--     clickable pins, which keep their clicks. Shift- or Alt-clicking the
--     planned spot again lets it go: the arrow returns to the guide.
--   * Polestar.Nav.API, for other addons (docs/ARCHITECTURE.md, "Nav API").
--     Points are a uiMapID and x, y as 0-1 fractions, as TomTom and C_Map take them.
--       API.Estimate(fromMap, fromX, fromY, toMap, toX, toY) -> seconds | nil, reason
--           travel time by the route planner (cached there); fromMap nil: from the
--           player, the Hearthstone included. reason "invalid" | "unknown" | "busy"
--           (no new plan starts once this frame has spent 25 ms on estimates; ask
--           again next frame)
--       API.Navigate(owner, map, x, y, title) -> true | false   point the arrow there
--       API.Cancel(owner) -> true | false   the owner's target, while shown, lets go
--       API.Active() -> active, owner       anything guided to; owner when an API caller set it
--     A target set by the death helper over an owner's comes back theirs when handed back.
--   * TomTom's waypoint calls while TomTom is not installed (nav.answerTomTom,
--     off by default: an addon reading TomTom's settings would find none):
--     the global TomTom answers AddWaypoint, AddMFWaypoint, AddZWaypoint,
--     AddWaypointToCurrentZone, RemoveWaypoint, ClearWaypoint and
--     ClearAllWaypoints (and a few read-only helpers) by pointing Polestar's
--     arrow, one waypoint at a time; corpse waypoints are left to the death
--     helper. Any other TomTom method is a harmless no-op returning nil;
--     fields (TomTom.db, profiles) are not provided. The global is taken at
--     login, only when no addon has one (TomTom itself, enabled in the AddOns
--     list, counts even before it loads; one switched off never loads, so the
--     stand-in answers then), and given back if TomTom loads or the setting
--     goes off. Nav/Bridges.lua never mirrors to it. /way is claimed at login
--     when no addon has it: `/way [#mapID | zone] x y [title]`, `/way reset`.
--   * While the target is handed to Shortest Path Forever (Nav/Handoff.lua),
--     map clicks, the TomTom stand-in and /way are its own: Polestar's stay out.
--   * With TomTom installed, nav.followTomTom (off by default) points the
--     arrow wherever TomTom's arrow points (see "Following TomTom's arrow").
--
-- Journey.Estimate(from, to, budgeted) -> seconds | nil[, "busy"] and
-- Journey.PlanTo(map, x, y, label) are shared with Nav/Nearby.lua;
-- Journey.IsTomTomTarget(target) with Nav/Bridges.lua.

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local type, pairs, ipairs, tonumber, next = type, pairs, ipairs, tonumber, next
local sqrt, floor, abs, huge = math.sqrt, math.floor, math.abs, math.huge
local format, lower = string.format, string.lower

local Journey = {}
Nav.journey = Journey

ns.RegisterDefaults("nav", {
	mapPlan = true,
	answerTomTom = false, -- the stand-in has methods only: an addon reading TomTom.db would error
	followTomTom = false,
})

local RUN_SPEED = 7     -- yd/s, the straight-line estimate without the planner
local CONTINENT = 2     -- Enum.UIMapType.Continent; lower is the world and the cosmos
local AGAIN = 0.015     -- of the clicked map's width: a click this close to the planned spot lets it go
local AGAIN_MINIMAP = 0.08 -- of the minimap's radius

---------------------------------------------------------------------------
-- Places
---------------------------------------------------------------------------

local function number(v)
	return type(v) == "number" and v == v and v > -huge and v < huge
end

local function world(map, x, y, f)
	local C = ns.Compat
	if not (C and C.MapToWorld) then return nil end
	return C.MapToWorld(map, x, y, f)
end

local function zoneName(map)
	local C = ns.Compat
	return C and C.GetMapName and C.GetMapName(map) or nil
end

-- "Elwynn Forest 42, 65": what a planned spot is called.
local function spotLabel(map, x, y)
	local name = zoneName(map)
	if not name then return nil end
	return format(L["%s %d, %d"], name, floor(x + 0.5), floor(y + 0.5))
end

-- The spot under (x, y) percent of a map, on the zone that holds it: map, x,
-- y. On a continent map that is the zone under the cursor; nil for open sea,
-- the world map, or a map the client cannot place.
function Journey.ZonePoint(map, x, y)
	local c, wx, wy = world(map, x, y)
	if not c then return nil end
	local info = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(map)
	if not (info and info.mapType and info.mapType <= CONTINENT) then return map, x, y end
	local child = C_Map.GetMapInfoAtPosition and C_Map.GetMapInfoAtPosition(map, x / 100, y / 100)
	if not (child and child.mapID and child.mapID ~= map and (child.mapType or CONTINENT + 1) > CONTINENT) then return nil end
	local zx, zy = ns.Compat.WorldToMap(c, wx, wy, child.mapID)
	if not (zx and zx >= 0 and zx <= 100 and zy >= 0 and zy <= 100) then return nil end
	return child.mapID, zx, zy
end

-- Seconds from `from` ({ map, x, y, f }; nil: the player, Hearthstone
-- included) to `to`: the route planner's estimate (Nav.EstimateTravel, cached
-- there), else running in a straight line on one continent. nil when either
-- end cannot be placed, or across continents without the planner. `budgeted`
-- (the public API only) may answer nil, "busy": the planner's frame budget is
-- spent, and no straight line stands in for it (second review P2).
function Journey.Estimate(from, to, budgeted)
	if Nav.EstimateTravel then
		local s, why = Nav.EstimateTravel(from, to, budgeted)
		if s then return s end
		if why == "busy" then return nil, "busy" end
	end
	local C = ns.Compat
	local fc, fx, fy
	if from then
		fc, fx, fy = world(from.map, from.x, from.y, from.f)
	elseif C and C.GetPlayerWorldPosition then
		fc, fx, fy = C.GetPlayerWorldPosition()
	end
	local tc, tx, ty = world(to.map, to.x, to.y, to.f)
	if not (fc and tc and fc == tc) then return nil end
	return sqrt((tx - fx) ^ 2 + (ty - fy) ^ 2) / RUN_SPEED
end

-- Point the arrow at (x, y) percent of map, moved onto the zone under it.
-- False (and a line in chat) when no route can go there.
function Journey.PlanTo(map, x, y, label, f)
	local zm, zx, zy = map, x, y
	if not f then zm, zx, zy = Journey.ZonePoint(map, x, y) end
	if not zm then
		ns.Print(L["No route can be planned to that spot."])
		return false
	end
	return Nav.SetTarget(zm, zx, zy, label or spotLabel(zm, zx, zy), f)
end

-- A planned target (any picked point) within `yards` of world (c, wx, wy)
-- lets go, and the arrow returns to the guide. True if it did.
local function releaseNear(c, wx, wy, yards)
	if not (Nav.IsOverride() and c) then return false end
	local tc, tx, ty = Nav.GetTargetWorld()
	if tc ~= c or (tx - wx) ^ 2 + (ty - wy) ^ 2 > yards * yards then return false end
	Nav.ReleaseTarget()
	return true
end

-- A Shift- or Alt-click at (x, y) percent of a world map `map`.
function Journey.OnMapClick(map, x, y, label)
	local c, wx, wy = world(map, x, y)
	local c1, top, left = world(map, 0, 0)
	local c2, bottom, right = world(map, 100, 100)
	if c and c1 and c1 == c2 then
		local span = abs(right - left)
		if abs(bottom - top) > span then span = abs(bottom - top) end
		if releaseNear(c, wx, wy, span * AGAIN) then return true end
	end
	return Journey.PlanTo(map, x, y, label)
end

-- A Shift-click on the minimap, at (dNorth, dWest) yards from the player.
function Journey.OnMinimapClick(dNorth, dWest, radius)
	local C = ns.Compat
	local pc, px, py = C.GetPlayerWorldPosition()
	local map = C.GetPlayerMapPosition()
	if not (pc and map and dNorth) then
		ns.Print(L["No route can be planned to that spot."])
		return false
	end
	local wx, wy = px + dNorth, py + dWest
	if releaseNear(pc, wx, wy, (radius or 0) * AGAIN_MINIMAP) then return true end
	local x, y = C.WorldToMap(pc, wx, wy, map)
	if not x then
		ns.Print(L["No route can be planned to that spot."])
		return false
	end
	return Journey.PlanTo(map, x, y)
end

---------------------------------------------------------------------------
-- Clicks
---------------------------------------------------------------------------

-- Shortest Path Forever plans map clicks itself while it guides (Nav/Handoff.lua).
local function planning()
	return ns.Get("nav.mapPlan") and not Nav.HandedOff() and true or false
end

-- Shift-click inserts links into an open chat box; that click stays Blizzard's.
local function chatOpen()
	local active = (ChatFrameUtil and ChatFrameUtil.GetActiveWindow) or ChatEdit_GetActiveWindow
	return active ~= nil and active() ~= nil
end

local function foci()
	if GetMouseFoci then return GetMouseFoci() end
	return { GetMouseFocus and GetMouseFocus() }
end

-- The world map pin under the cursor: "own" for one of Polestar's clickable
-- pins (they keep their clicks), else its name (or nil) and position (0-1).
-- Polestar's are its own frames (Pins.WorldPinOf), Blizzard's the map's pins.
local function hoveredPin(map)
	local P = ns.Pins
	for _, f in ipairs(foci()) do
		local own = type(f) == "table" and P and P.WorldPinOf and P.WorldPinOf(f)
		if own then
			if own.pin.onClick then return "own" end
			return type(own.pin.tooltip) == "string" and own.pin.tooltip or nil, own.x / 100, own.y / 100
		end
		if type(f) == "table" and f.pinTemplate and f.GetMap and f:GetMap() == map then
			local info = f.poiInfo or f.taxiNodeData
			local name = info and type(info.name) == "string" and info.name or (type(f.name) == "string" and f.name) or nil
			local x, y
			if f.GetPosition then x, y = f:GetPosition() end
			return name, x, y
		end
	end
end

-- Canvas click handlers run before the map's own (zooming into a zone);
-- true takes the click. Clicks on pins never reach them.
local function onCanvasClick(canvas, button)
	if button ~= "LeftButton" or not planning() or not IsShiftKeyDown() or IsAltKeyDown()
		or IsControlKeyDown() or chatOpen() then
		return false
	end
	local mapID = canvas:GetMapID()
	local x, y = canvas:GetNormalizedCursorPosition()
	if not (mapID and x and y) then return false end
	Journey.OnMapClick(mapID, x * 100, y * 100)
	return true
end

-- Shift-click on the target's own pin (which takes the click) lets it go
-- (Pins.OnWorldClick: Polestar's pins are its own frames, not the map's).
local function onOwnPinClick(_, layer, button)
	if button ~= "LeftButton" or not (layer and layer.name == "nav.target") or not planning()
		or not IsShiftKeyDown() or IsAltKeyDown() or chatOpen() or not Nav.IsOverride() then
		return false
	end
	Nav.ReleaseTarget()
	return true
end

-- Alt-click anywhere on the world map, its icons included. Observed through
-- GLOBAL_MOUSE_DOWN, as icons swallow canvas clicks.
local function onGlobalMouseDown(_, button)
	if button ~= "LeftButton" or not planning() or not IsAltKeyDown() or IsShiftKeyDown() or IsControlKeyDown() then return end
	local map = WorldMapFrame
	if not (map and map:IsShown() and map.ScrollContainer and map.ScrollContainer:IsMouseOver()) then return end
	local mapID = map:GetMapID()
	local name, x, y = hoveredPin(map)
	if name == "own" then return end
	if not x then x, y = map:GetNormalizedCursorPosition() end
	if not (mapID and x and y) then return end
	Journey.OnMapClick(mapID, x * 100, y * 100, name)
end

-- The stock handler still pings the spot, which shows your group too.
local function onMinimapUp(_, button)
	if button ~= "LeftButton" or not planning() or not IsShiftKeyDown() then return end
	local P = ns.Pins
	if not (P and P.MinimapCursor) then return end
	local dNorth, dWest = P.MinimapCursor()
	Journey.OnMinimapClick(dNorth, dWest, (P.MinimapView()))
end

local worldHooked, minimapHooked = false, false

-- Not with the gamepad interface (ns.GamepadUI): the handler is a write
-- into the map's own table, and the gamepad clicks the map with A, never
-- the mouse this answers.
local function hookWorldMap()
	local map = WorldMapFrame
	if worldHooked or ns.GamepadUI() or not (map and map.AddCanvasClickHandler and map.GetNormalizedCursorPosition) then return worldHooked end
	map:AddCanvasClickHandler(onCanvasClick)
	worldHooked = true
	return true
end

local function hookMinimap()
	if minimapHooked or not (Minimap and Minimap.HookScript) then return end
	Minimap:HookScript("OnMouseUp", onMinimapUp)
	minimapHooked = true
end

ns.OnLogin(function()
	hookMinimap()
	ns.RegisterEvent("GLOBAL_MOUSE_DOWN", onGlobalMouseDown)
	if ns.Pins and ns.Pins.OnWorldClick then ns.Pins.OnWorldClick(onOwnPinClick) end
	if hookWorldMap() then return end
	local function onLoaded(_, name)
		if name == "Blizzard_WorldMap" and hookWorldMap() then ns.UnregisterEvent("ADDON_LOADED", onLoaded) end
	end
	ns.RegisterEvent("ADDON_LOADED", onLoaded)
end)

---------------------------------------------------------------------------
-- Public API (Polestar.Nav.API)
---------------------------------------------------------------------------

local API = { version = 1 }
Nav.API = API

-- The target an API caller set: owner, Nav's target table, and the spot (to
-- know it again when the death helper hands it back).
local owned

local function fraction(v) return number(v) and v >= 0 and v <= 1 end
local function mapID(v) return number(v) and v > 0 and v % 1 == 0 end
local function ownerName(v) return type(v) == "string" and v:find("%S") ~= nil end

local function apiPoint(map, x, y)
	if not (mapID(map) and fraction(x) and fraction(y)) then return nil end
	local p = { map = map, x = x * 100, y = y * 100 }
	if not world(p.map, p.x, p.y) then return nil end
	return p
end

function API.Estimate(fromMap, fromX, fromY, toMap, toX, toY)
	local to = apiPoint(toMap, toX, toY)
	if not to then return nil, "invalid" end
	local from
	if fromMap ~= nil then
		from = apiPoint(fromMap, fromX, fromY)
		if not from then return nil, "invalid" end
	end
	local seconds, why = Journey.Estimate(from, to, true)
	if not seconds then return nil, why == "busy" and "busy" or "unknown" end
	return seconds
end

function API.Navigate(owner, map, x, y, title)
	if not ownerName(owner) or (title ~= nil and type(title) ~= "string") then return false end
	local p = apiPoint(map, x, y)
	if not (p and Nav.SetTarget(p.map, p.x, p.y, title)) then return false end
	local t = Nav.GetTarget()
	owned = { owner = owner, target = t, map = t.map, x = t.x, y = t.y, label = t.label }
	return true
end

function API.Cancel(owner)
	if not (owned and owned.owner == owner and Nav.GetTarget() == owned.target) then return false end
	owned = nil
	Nav.ReleaseTarget()
	return true
end

function API.Active()
	local t = Nav.GetTarget()
	if not t then return false end
	return true, owned and owned.target == t and owned.owner or nil
end

---------------------------------------------------------------------------
-- TomTom's waypoint API, while TomTom is not installed
---------------------------------------------------------------------------

local OWNER = "TomTom"
local shim = {}
shim.waypoints = {} -- [map] = { [key] = uid }, the shape TomTom keeps
Nav.tomtomShim = shim
local current -- the shim's waypoint: { map, x, y, title = ... } as TomTom's uid
local shimActive = false

local function forget()
	current = nil
	wipe(shim.waypoints)
end

local function knownMap(id)
	return mapID(id) and world(id, 50, 50) ~= nil
end

-- The waypoint and the target start together: a refused target leaves no
-- waypoint for the caller to remove.
local function start(map, x, y, title, opts)
	if not shimActive or type(opts) == "table" and (opts.from == "Polestar" or opts.corpse) then return nil end
	if type(title) ~= "string" then title = nil end
	if not API.Navigate(OWNER, map, x, y, title) then return nil end
	local uid = { map, x, y, title = title }
	if type(opts) == "table" then
		for k, v in pairs(opts) do
			if uid[k] == nil then uid[k] = v end
		end
	end
	forget()
	current = uid
	shim.waypoints[map] = { [format("%d:%.6f:%.6f:%s", map, x, y, title or "")] = uid }
	return uid
end

function shim:AddWaypoint(map, x, y, opts)
	if opts ~= nil and type(opts) ~= "table" then return nil end
	return start(map, x, y, opts and opts.title, opts)
end

-- The map, its floor (this client has none) and the same point.
function shim:AddMFWaypoint(map, _, x, y, opts)
	return self:AddWaypoint(map, x, y, opts)
end

-- The old continent and zone form, x and y 0-100: the zone wins when it names a map.
function shim:AddZWaypoint(continent, zone, x, y, desc)
	if not (number(x) and number(y)) then return nil end
	local map = knownMap(zone) and zone or knownMap(continent) and continent or nil
	if not map then return nil end
	return start(map, x / 100, y / 100, desc)
end

function shim:RemoveWaypoint(uid)
	if uid == nil or uid ~= current then return false end
	API.Cancel(OWNER)
	forget()
	return true
end
shim.ClearWaypoint = shim.RemoveWaypoint

function shim:IsValidWaypoint(uid)
	return uid ~= nil and uid == current
end

function shim:WaypointExists(map, x, y, desc)
	local w = current
	return w ~= nil and w[1] == map and w[2] == x and w[3] == y and (desc == nil or w.title == desc)
end

function shim:SetCrazyArrow(uid)
	if uid ~= current and type(uid) == "table" then start(uid[1], uid[2], uid[3], uid.title) end
end

function shim:GetDistanceToWaypoint(uid)
	if uid ~= nil and uid == current then return Nav.GetDistance() end
	return nil
end

-- x, y 0-100 on the map the player stands on.
function shim:AddWaypointToCurrentZone(x, y, desc)
	local map = ns.Compat.GetPlayerMapPosition()
	if not (map and number(x) and number(y)) then return nil end
	return start(map, x / 100, y / 100, desc)
end

function shim:ClearAllWaypoints()
	if current then self:RemoveWaypoint(current) end
end

function shim:GetKey(uid)
	if type(uid) ~= "table" then return nil end
	return format("%s:%s:%s:%s", tostring(uid[1]), tostring(uid[2]), tostring(uid[3]), tostring(uid.title))
end

-- One waypoint: the closest is always the one there is.
function shim:SetClosestWaypoint() end

-- Any other method another addon calls (TomTom's API is larger than what the
-- stand-in answers) does nothing and returns nil, so a caller that only
-- checked `if TomTom then` never errors. Only method-style names (an upper-case
-- first letter, as all of TomTom's are) answer: fields such as TomTom.db or
-- TomTom.profile are not provided and read as nil.
local function ignored() return nil end
setmetatable(shim, {
	__index = function(_, key)
		if type(key) == "string" and key:find("^%u") then return ignored end
	end,
})

-- TomTom owns the global: its own table, one loaded already, or one enabled
-- in the AddOns list (it loads after us) means the shim stays out.
local function tomtomInstalled()
	if TomTom ~= nil and TomTom ~= shim then return true end
	local A = C_AddOns
	if not A then return false end
	if A.IsAddOnLoaded and A.IsAddOnLoaded("TomTom") then return true end
	if A.GetAddOnInfo then
		local name, _, _, loadable = A.GetAddOnInfo("TomTom")
		if name and loadable then return true end
	end
	return false
end

-- The global is taken at login, once every addon has loaded: an addon that
-- brings its own TomTom-compatible global, loading before or after Polestar,
-- keeps it, and the stand-in stays out. Callers set waypoints in response to
-- the player, after login, so none of them misses it.
function Journey.RefreshTomTom()
	if ns.IsLoggedIn() and ns.Get("nav.answerTomTom") and not Nav.HandedOff() and not tomtomInstalled() then
		if not shimActive then
			shimActive = true
			TomTom = shim
		end
	elseif shimActive then
		shimActive = false
		if current then API.Cancel(OWNER) end
		forget()
		if TomTom == shim then TomTom = nil end
	end
end

function Journey.AnsweringTomTom()
	return shimActive
end

---------------------------------------------------------------------------
-- Following TomTom's arrow, with TomTom installed (nav.followTomTom, off by
-- default). TomTom calls its own SetCrazyArrow whenever its arrow takes a
-- waypoint (its /way, another addon's, one the player picks, the closest one
-- left), and ClearWaypoint whenever one goes (RemoveWaypoint, "Remove all
-- waypoints", /way reset all and a profile change). Both are hooked on
-- TomTom's own table. TomTom's corpse arrow is left to the death helper, and
-- Polestar's own mirror (Nav/Bridges.lua, from = "Polestar") is never followed.
-- TomTom restores its saved waypoints at login, pointing the arrow at each:
-- nothing is followed until a frame after PLAYER_ENTERING_WORLD, then the
-- one the arrow was left on, unless something else is guided to already.
---------------------------------------------------------------------------

local hooked      -- the TomTom table hooked
local following   -- the TomTom waypoint the arrow follows
local restored    -- the arrow's waypoint before the world was up
local live = false
local fromTomTom = false -- true while a followed waypoint is being set as the target

local function follow(uid)
	if type(uid) ~= "table" or uid.corpse or uid.from == "Polestar" then return end
	if not live then
		restored = uid
		return
	end
	if not ns.Get("nav.followTomTom") then return end
	local _, owner = API.Active()
	if uid == following and owner == OWNER then return end
	fromTomTom = true
	local ok = API.Navigate(OWNER, uid[1], uid[2], uid[3], type(uid.title) == "string" and uid.title or nil)
	fromTomTom = false
	if ok then following = uid end
end

local function unfollow(uid)
	if uid == restored then restored = nil end
	if uid ~= nil and uid == following then
		following = nil
		API.Cancel(OWNER)
	end
end

-- Whether `target` is a followed TomTom waypoint: Bridges leaves it in
-- TomTom rather than mirroring it back.
function Journey.IsTomTomTarget(target)
	if fromTomTom then return true end
	return following ~= nil and owned ~= nil and owned.owner == OWNER and owned.target == target
end

function Journey.RefreshTomTomFollow()
	local T = TomTom
	if not hooked and type(T) == "table" and T ~= shim and type(T.SetCrazyArrow) == "function"
		and type(T.RemoveWaypoint) == "function" then
		hooked = T
		hooksecurefunc(T, "SetCrazyArrow", function(_, uid) follow(uid) end)
		hooksecurefunc(T, "RemoveWaypoint", function(_, uid) unfollow(uid) end)
		if type(T.ClearWaypoint) == "function" then
			hooksecurefunc(T, "ClearWaypoint", function(_, uid) unfollow(uid) end)
		end
	end
	if not ns.Get("nav.followTomTom") then unfollow(following) end
end

-- One frame after the world is up, the arrow's restored waypoint is followed.
local function worldUp()
	ns.UnregisterEvent("PLAYER_ENTERING_WORLD", worldUp)
	C_Timer.After(0, function()
		live = true
		local uid = restored
		restored = nil
		local T = hooked
		if uid and T and not Nav.IsOverride() then
			local valid = T.IsValidWaypoint
			if type(valid) ~= "function" or valid(T, uid) then follow(uid) end
		end
	end)
end
ns.RegisterEvent("PLAYER_ENTERING_WORLD", worldUp)

---------------------------------------------------------------------------
-- /way
---------------------------------------------------------------------------

-- Zone names folded: lower case, no spaces or punctuation.
local function fold(name)
	return (lower(name):gsub("[%s%p]", ""))
end

-- Every map under the world the player stands in, by folded name.
local zones

local function zoneList()
	if zones then return zones end
	local found = {}
	if C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo and C_Map.GetMapChildrenInfo then
		local root = C_Map.GetBestMapForUnit("player")
		local info = root and C_Map.GetMapInfo(root)
		while info and info.parentMapID and info.parentMapID ~= 0 do
			local parent = C_Map.GetMapInfo(info.parentMapID)
			if not parent then break end
			root, info = info.parentMapID, parent
		end
		for _, child in ipairs(root and C_Map.GetMapChildrenInfo(root, nil, true) or {}) do
			local key = fold(child.name or "")
			local held = found[key]
			-- A city and a micro map can share a name; the zone is the one meant.
			if key ~= "" and (not held or held.mapType ~= 3 and child.mapType == 3) then found[key] = child end
		end
	end
	if next(found) then zones = found end
	return found
end

-- The map a zone name means: its exact name, the one zone it begins, else the
-- one zone it is part of ("barrens"). nil and why not.
local function zoneMap(name)
	local key, list = fold(name), zoneList()
	if list[key] then return list[key].mapID end
	local matches = {}
	for _, inside in ipairs({ false, true }) do
		for folded, info in pairs(list) do
			local at = key ~= "" and folded:find(key, 1, true)
			if at and (inside or at == 1) then matches[#matches + 1] = info.name end
		end
		if matches[1] then break end
	end
	if #matches == 1 then return list[fold(matches[1])].mapID end
	if #matches > 1 then
		table.sort(matches)
		return nil, format(L["%s could be %s."], name, table.concat(matches, ", "))
	end
	return nil, format(L["No zone called %s."], name)
end

local function percent(token)
	local v = token and (token:match("^%d+%.?%d*$") or token:match("^%.%d+$")) and tonumber(token)
	if v and v >= 0 and v <= 100 then return v end
end

local WAY_USAGE = L["/way [zone] x y [title], with x and y from 0 to 100; /way reset clears it."]

-- A /way line -> map, x, y (percent), title | nil, why not.
function Journey.ParseWay(message)
	-- "45.2, 61.8" and "45, 61": the separator straight after x is not a decimal one.
	message = (message or ""):gsub("(%d)[%.,]%s+(%d)", "%1 %2")
	local tokens = {}
	for token in message:gmatch("%S+") do tokens[#tokens + 1] = (token:gsub("(%d),(%d)", "%1.%2")) end
	local map, at
	local id = tokens[1] and tokens[1]:match("^#(%d+)$")
	if id then
		map, at = tonumber(id), 2
		if not world(map, 50, 50) then return nil, format(L["No map %s."], tokens[1]) end
	else
		for i = 1, #tokens - 1 do
			if percent(tokens[i]) and percent(tokens[i + 1]) then
				at = i
				break
			end
		end
		if not at then return nil, WAY_USAGE end
		if at > 1 then
			local err
			map, err = zoneMap(table.concat(tokens, " ", 1, at - 1))
			if not map then return nil, err end
		else
			map = ns.Compat.GetPlayerMapPosition()
			if not map then return nil, L["No position here: the game gives none in instances and on some maps."] end
		end
	end
	local x, y = percent(tokens[at]), percent(tokens[at + 1])
	if not (x and y) then return nil, WAY_USAGE end
	local title = table.concat(tokens, " ", at + 2)
	return map, x, y, title ~= "" and title or nil
end

function Journey.Way(message)
	if not ns.Get("nav.answerTomTom") then
		ns.Print(L["/way is off: turn on Let other addons set waypoints in Polestar's settings."])
		return
	end
	local word = lower((message or ""):match("^%s*(%S*)") or "")
	if word == "reset" or word == "clear" then
		Nav.ClearTarget()
		return
	end
	local map, x, y, title = Journey.ParseWay(message)
	if not map then
		ns.Print(x)
		return
	end
	Journey.PlanTo(map, x, y, title)
end

-- Whether TomTom or another addon spells a command /way (globals SLASH_<NAME><n>).
local function wayTaken()
	if C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("TomTom") then return true end
	for key, value in pairs(_G) do
		if type(value) == "string" and type(key) == "string" and key:find("^SLASH_") and lower(value) == "/way"
			and key ~= "SLASH_POLESTARWAY1" then
			return true
		end
	end
	return false
end

-- Every addon has loaded by login, so whoever owns /way is there to be seen.
-- No slash command with the gamepad interface (Core/Init.lua).
local function claimWay()
	if SLASH_POLESTARWAY1 or ns.GamepadUI() or not ns.Get("nav.answerTomTom") or Nav.HandedOff() or wayTaken() then return end
	SLASH_POLESTARWAY1 = "/way"
	SlashCmdList.POLESTARWAY = Journey.Way
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

-- A target replaced by another is not the owner's while it is away (Active
-- names no owner, Cancel does nothing); the same spot set again, as the
-- death helper hands it back, is theirs again.
ns.On("WAYPOINT_CHANGED", function()
	local t = Nav.GetTarget()
	if owned and t and t ~= owned.target and t.kind == "manual" and t.map == owned.map and t.x == owned.x
		and t.y == owned.y and t.label == owned.label then
		owned.target = t
	end
end)

ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "nav" or path == "nav.answerTomTom" or path == "nav.spfHandoff" then
		Journey.RefreshTomTom()
		if ns.IsLoggedIn() then claimWay() end
	end
	if path == "" or path == "nav" or path == "nav.followTomTom" then Journey.RefreshTomTomFollow() end
end)

ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "TomTom" then
		Journey.RefreshTomTom()
		Journey.RefreshTomTomFollow()
	end
end)

ns.OnInit(Journey.RefreshTomTomFollow)
ns.OnLogin(function()
	Journey.RefreshTomTom()
	claimWay()
end)

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			Nav.HandoffOption({ kind = "toggle", key = "nav.mapPlan", label = L["Shift-click a map to go there"],
				help = L["Shift-click the world map or minimap and the arrow takes you there; Alt-click works over map icons. Click the spot again to clear it."] }),
			Nav.HandoffOption({ kind = "dropdown", key = "nav.routeStyle", label = L["Route style"],
				help = L["Fastest: the shortest walk, over hills and across fields. Balanced: roads that aren't much longer, and round hills. Roads: stays on roads even when they're longer; the safest way, not the quickest."],
				choices = { { value = "fastest", label = L["Fastest"] }, { value = "balanced", label = L["Balanced"] }, { value = "roads", label = L["Roads"] } } }),
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
	ok, err = ns.RegisterOptions({
		page = L["Integrations"], section = "TomTom",
		controls = {
			Nav.HandoffOption({ kind = "toggle", key = "nav.answerTomTom", label = L["Let other addons set waypoints"],
				help = L["Without TomTom installed, waypoints other addons set through TomTom, and /way, point Polestar's arrow. Addons that expect TomTom's own settings may not work with it on."] }),
			{ kind = "toggle", key = "nav.followTomTom", label = L["Follow TomTom's arrow"],
				help = L["With TomTom installed, the arrow goes wherever TomTom's arrow points, routed like any goal."],
				disabled = function() return TomTom == nil or TomTom == shim end },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
