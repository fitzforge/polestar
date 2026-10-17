-- A fake world for Nav tests: Polestar.Compat and Polestar.Engine fakes
-- (installed just before ADDON_LOADED, after the addon files have run), the
-- world map (wow_stub.lua's map canvas, guarded: addon code may only read
-- it), C_Minimap/C_Map/C_SuperTrack and an optional TomTom.
--
-- Map 9000 "Testshire" (continent 0) spans world wx 1000..-1000 (top to
-- bottom) and wy 1000..-1000 (left to right), so map (50, 50) is the world
-- origin and one map percent is 20 yards.
--
--   stub.nav.place(wx, wy [, continent])   put the player somewhere
--   stub.nav.mapPoint(wx, wy)             -> 9000, x, y on the live frame
--   stub.nav.setWaypoint(wp)              Engine announces a waypoint
--   stub.nav.changeStep(i, wp)            Engine moves to step i
--   stub.nav.withTomTom()                 install a recording TomTom
--   stub.nav.showWorldMap(mapID)          open the world map on mapID (see the map section)

local nav = {
	player = { c = 0, wx = 0, wy = 0 },
	facing = 0,
	taxi = false,
	instance = false,
	indoors = false,
	viewRadius = nil, -- C_Minimap.GetViewRadius() when set
	maps = {
		[9000] = { c = 0, top = 1000, bottom = -1000, left = 1000, right = -1000, name = "Testshire" },
		[9001] = { c = 1, top = 500, bottom = -500, left = 500, right = -500, name = "Farland" },
	},
	era = {},
	engine = { waypoint = nil, step = 1, views = {} },
	userWaypoints = {},
}
stub.nav = nav

function nav.place(wx, wy, c)
	nav.player = { c = c or 0, wx = wx, wy = wy }
end

function nav.mapPoint(wx, wy)
	local b = nav.maps[9000]
	return 9000, (wy - b.left) / (b.right - b.left) * 100, (wx - b.top) / (b.bottom - b.top) * 100
end

---------------------------------------------------------------------------
-- Compat
---------------------------------------------------------------------------

local Compat = {}
nav.Compat = Compat

function Compat.MapToWorld(map, x, y, frame)
	local b
	if frame == "e" then b = nav.era[map] else b = nav.maps[map] end
	if not b then return nil end
	return b.c, b.top + (b.bottom - b.top) * y / 100, b.left + (b.right - b.left) * x / 100
end

function Compat.WorldToMap(c, wx, wy, map)
	local b = nav.maps[map]
	if not b or b.c ~= c then return nil end
	return (wy - b.left) / (b.right - b.left) * 100, (wx - b.top) / (b.bottom - b.top) * 100
end

function Compat.GetPlayerWorldPosition()
	local p = nav.player
	if not p then return nil end
	return p.c, p.wx, p.wy
end

function Compat.GetPlayerMapPosition()
	local p = nav.player
	if not p or p.c ~= 0 then return nil end
	local _, x, y = nav.mapPoint(p.wx, p.wy)
	return 9000, x, y
end

function Compat.GetPlayerFacing() return nav.facing end
function Compat.IsOnTaxi() return nav.taxi end
function Compat.IsInInstance() return nav.instance end
function Compat.IsIndoors() return nav.indoors end
function Compat.GetMapName(map) return nav.maps[map] and nav.maps[map].name end
function Compat.GetPlayerInfo() return { name = "Testchar", level = 10, faction = nav.faction } end
function Compat.GetPlayerFaction() if nav.faction == "Alliance" or nav.faction == "Horde" then return nav.faction end end
function Compat.GetItemCount(id) return nav.items[id] or 0 end
function Compat.GetBindLocation() return nav.bind end
function Compat.GetNpcID(unit) if unit == "npc" then return nav.npcUnit end end
function Compat.IsShiftKeyDown() return stub.keys.shift end

---------------------------------------------------------------------------
-- Travel: run speed, Hearthstone cooldown, the flight map
---------------------------------------------------------------------------

nav.faction = "Neutral"
nav.items = {}
nav.bind = nil
nav.npcUnit = nil
nav.runSpeed = 7
nav.hearthCooldown = nil -- { start, duration }
nav.taxiMap = nil -- { mapID = n, nodes = { nodeID | { nodeID, state }, ... } } while the flight map is open (state 1 = Reachable)

function GetUnitSpeed(unit) if unit == "player" then return 0, nav.runSpeed, 0, 0 end end
C_Container = {}
function C_Container.GetItemCooldown(id)
	local cd = id == 6948 and nav.hearthCooldown
	if cd then return cd[1], cd[2], 1 end
	return 0, 0, 1
end
function GetTaxiMapID() return nav.taxiMap and nav.taxiMap.mapID end
C_TaxiMap = {}
function C_TaxiMap.GetAllTaxiNodes(mapID)
	local out = {}
	if nav.taxiMap and nav.taxiMap.mapID == mapID then
		for i, n in ipairs(nav.taxiMap.nodes) do
			local id, state = n, 1
			if type(n) == "table" then id, state = n[1], n[2] end
			out[i] = { nodeID = id, name = "node " .. id, state = state, slotIndex = i }
		end
	end
	return out
end

-- A small travel world on map 9000 (continent 0) and 9001 (continent 1),
-- replacing the generated TravelData:
--   1 West Hold (0, 790)  2 East Hold (0, -800)  Alliance; 3 Horde Roost (500, -800) Horde
--   flights 1 <-> 2 (`flightYards`), 1 <-> 3
--   a boat between Testshire Docks (-900, 0) and Farland Pier (c1: 400, 0)
--   an inn, "Testshire Inn", innkeeper 900 at (-500, -700)
function nav.useTravelWorld(flightYards)
	flightYards = flightYards or 1700
	Polestar.Nav.RegisterTravelData({
		build = "test",
		taxi = {
			{ 1, 0, 0, 790, 9000, 10.5, 50, 1, "West Hold, Testshire" },
			{ 2, 0, 0, -800, 9000, 90, 50, 1, "East Hold, Testshire" },
			{ 3, 0, 500, -800, 9000, 90, 25, 2, "Horde Roost, Testshire" },
		},
		flights = { 1, 2, flightYards, 2, 1, flightYards, 1, 3, 1700, 3, 1, 1700 },
		transports = {
			{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
				a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95 }, b = { "Farland Pier", 1, 400, 0, 9001, 50, 10 } },
		},
		inns = { { names = { "Testshire Inn" }, npc = 900, c = 0, wx = -500, wy = -700, map = 9000, x = 85, y = 75, f = "e" } },
	}, true)
end

---------------------------------------------------------------------------
-- Engine
---------------------------------------------------------------------------

local Engine = {}
nav.Engine = Engine
function Engine.GetWaypoint() return nav.engine.waypoint end
function Engine.GetStepIndex() return nav.engine.step end
function Engine.GetStepView(i) return nav.engine.views[i] end

function nav.setWaypoint(wp)
	nav.engine.waypoint = wp
	Polestar.Fire("WAYPOINT_CHANGED", wp)
end

function nav.changeStep(i, wp)
	nav.engine.step = i
	nav.engine.waypoint = wp
	Polestar.Fire("STEP_CHANGED", i)
	Polestar.Fire("WAYPOINT_CHANGED", wp)
end

local addonLoaded = stub.addonLoaded
function stub.addonLoaded(name)
	if name == "Polestar" and Polestar then
		Polestar.Compat = Polestar.Compat or Compat
		Polestar.Engine = Polestar.Engine or Engine
		if not Polestar.RegisterMapFrames then
			function Polestar.RegisterMapFrames(t)
				for id, b in pairs(t.era or {}) do nav.era[id] = b end
			end
		end
	end
	addonLoaded(name)
end

---------------------------------------------------------------------------
-- Minimap, user waypoint, super tracking
---------------------------------------------------------------------------

C_Minimap = {}
function C_Minimap.GetViewRadius() return nav.viewRadius end
function IsIndoors() return nav.indoors end

C_Map = {}
function C_Map.CanSetUserWaypointOnMap(map) return nav.maps[map] ~= nil end
function C_Map.SetUserWaypoint(point)
	local x, y = point.position:GetXY()
	table.insert(nav.userWaypoints, { "set", point.uiMapID, x, y })
end
function C_Map.ClearUserWaypoint() table.insert(nav.userWaypoints, { "clear" }) end
C_SuperTrack = {}
function C_SuperTrack.SetSuperTrackedUserWaypoint(on) table.insert(nav.userWaypoints, { "track", on }) end

---------------------------------------------------------------------------
-- TomTom
---------------------------------------------------------------------------

function nav.withTomTom()
	local calls, n = {}, 0
	TomTom = { calls = calls }
	function TomTom:AddWaypoint(m, x, y, opts)
		n = n + 1
		local uid = { m, x, y, title = opts and opts.title, id = n }
		table.insert(calls, { op = "add", id = n, map = m, x = x, y = y, title = opts and opts.title, crazy = opts and opts.crazy, minimap = opts and opts.minimap, world = opts and opts.world })
		return uid
	end
	function TomTom:RemoveWaypoint(uid)
		table.insert(calls, { op = "remove", id = uid and uid.id })
	end
	return TomTom
end

---------------------------------------------------------------------------
-- The world map: wow_stub.lua's map canvas, 1000 x 1000 canvas units, its
-- tables guarded (stub.guardMap: addon code may only read them).
--   nav.showWorldMap(mapID)   open the world map on mapID, or show mapID in the
--                             open map, then one frame passes on the map
--   nav.pins(kind)            Pins' world map frames (Pins.GetWorldFrames: "pins"
--                             by default, "areas", "hulls"), sorted by size
--                             (largest first), then layer, then position
--   nav.worldPoint(region)    where a world map frame or texture is centred:
--                             x, y in percent of the viewed map
--   nav.tooltipOf(frame)      tooltip lines a pin (world map or minimap) shows on hover
--   nav.click(frame, button)  click a pin (a minimap pin: its OnMouseUp; a world map
--                             pin: the pointer on it, GLOBAL_MOUSE_DOWN and _UP)
---------------------------------------------------------------------------

-- Forever restricts SetPassThroughButtons in combat (IsProtectedFunction + HasRestrictions).
stub.blocked = {}
function stub.Methods.SetPassThroughButtons(self, ...)
	if stub.inCombat then
		table.insert(stub.blocked, "SetPassThroughButtons")
		return
	end
	self.passThrough = { ... }
end

local map = WorldMapFrame
map.Child = map:GetCanvas() -- the tests' shorthand for the canvas
map.Child:SetSize(1000, 1000)
stub.guardMap(map)
stub.withSoftCursor()

function nav.showWorldMap(mapID)
	stub.worldMapID = mapID
	if not map:IsShown() then map:Show() end
	stub.runMapFrame(map, 0)
end

function nav.pins(kind)
	local out = Polestar.Pins.GetWorldFrames(kind or "pins")
	table.sort(out, function(a, b)
		if a.width ~= b.width then return a.width > b.width end
		if a.data.layer.name ~= b.data.layer.name then return a.data.layer.name < b.data.layer.name end
		if a.data.x ~= b.data.x then return a.data.x < b.data.x end
		return a.data.y < b.data.y
	end)
	return out
end

function nav.worldPoint(r)
	local p, s, canvas = r.points[1], r.scale or 1, map.Child
	return p.x * s / canvas.width * 100, -p.y * s / canvas.height * 100
end

function nav.tooltipOf(f)
	GameTooltip.lines = {}
	stub.RunScript(f, "OnEnter")
	return GameTooltip.lines
end

function nav.click(f, button)
	button = button or "LeftButton"
	if f.scripts.OnMouseUp then
		stub.RunScript(f, "OnMouseUp", button)
		return
	end
	stub.RunScript(f, "OnEnter")
	stub.fire("GLOBAL_MOUSE_DOWN", button)
	stub.fire("GLOBAL_MOUSE_UP", button)
	stub.RunScript(f, "OnLeave")
end
