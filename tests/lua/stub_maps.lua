-- The client pieces Maps tests need on top of stub_world.lua: the taxi map
-- (slot API, C_TaxiMap, TakeTaxiNode), instances (IsInInstance with a type,
-- GetInstanceInfo, saved instances) and a small travel world.
--
--   local m = stub.maps
--   m.useWorld()                          map 9000 "Testshire" (c 0) and 9001 "Far Isle" (c 1) in stub.world
--   m.travel                              fixture for Polestar.Nav.RegisterTravelData(m.travel, true)
--   m.place(wx, wy)                       put the player at a world position on map 9000
--   m.openTaxi(currentID, { reachableID, ... })   open the flight map (names from m.travel)
--   TakeTaxiNode(slot)                    the client call (slot = index into the open map)
--   m.board() / m.land()                  UnitOnTaxi true / false
--   m.enter(name, instanceID, kind)       loading screen into an instance (PLAYER_LEAVING_WORLD, PLAYER_ENTERING_WORLD)
--   m.leave()                             loading screen back out
--   m.addXP(n)                            gain experience (levels up past xpMax) and fire PLAYER_XP_UPDATE
--   m.saved = { { name, id, reset, ... } } GetSavedInstanceInfo rows; RequestRaidInfo fires UPDATE_INSTANCE_INFO
--   m.jump(seconds)                       move the server clock (GetServerTime) without running frames

local world = stub.world
local m = { saved = {}, taxi = nil, instance = nil, took = {} }
stub.maps = m

-- One map percent is 20 yards; (50, 50) is the world origin.
function m.useWorld()
	world.addMap(9000, { name = "Testshire", c = 0, top = 1000, bottom = -1000, left = 1000, right = -1000 })
	world.addMap(9001, { name = "Far Isle", c = 1, top = 500, bottom = -500, left = 500, right = -500 })
end

function m.mapPoint(wx, wy)
	return 9000, (wy - 1000) / -2000 * 100, (wx - 1000) / -2000 * 100
end

function m.place(wx, wy)
	world.moveTo(m.mapPoint(wx, wy))
end

local function node(id, wx, wy, faction, name)
	local _, x, y = m.mapPoint(wx, wy)
	return { id, 0, wx, wy, 9000, x, y, faction, name }
end

m.travel = {
	build = "test",
	taxi = {
		node(1, 0, 800, 1, "West Hold, Testshire"),
		node(2, 0, -800, 1, "East Hold, Testshire"),
		node(3, 600, 0, 3, "Mid Camp, Testshire"),
		node(4, -600, 0, 2, "Red Fort, Testshire"),
	},
	flights = {
		1, 2, 3000,
		2, 1, 3000,
		1, 3, 1000,
		3, 1, 1000,
		3, 2, 1000,
		2, 3, 1000,
		3, 4, 900,
		4, 3, 900,
	},
	transports = {
		{ a = { "West Dock", 0, -900, 900, 9000, 5, 95 }, b = { "Far Isle", 1, 0, 0, 9001, 50, 50 },
			ab = 100, ba = 110, waitA = 60, waitB = 50, faction = 1, id = "boat-west", kind = "boat" },
		{ a = { "Red Tower", 0, -700, 100, 9000, 45, 85 }, b = { "Far Isle", 1, 100, 100, 9001, 40, 40 },
			ab = 90, ba = 90, waitA = 40, waitB = 40, faction = 2, id = "zeppelin-red", kind = "zeppelin" },
	},
	inns = {
		{ c = 0, f = "e", map = 9000, names = { "West Hold" }, npc = 100, wx = 10, wy = 790, x = 10.5, y = 49.5 },
		{ c = 0, f = "e", map = 9000, names = { "Mid Camp", "Camp Inn" }, npc = 101, wx = 610, wy = 10, x = 49.5, y = 19.5 },
	},
}

local function nameOf(id)
	for _, t in ipairs(m.travel.taxi) do
		if t[1] == id then return t[9] end
	end
end

---------------------------------------------------------------------------
-- Taxi
---------------------------------------------------------------------------

function m.openTaxi(current, reachable)
	local nodes = { { id = current, name = nameOf(current), type = "CURRENT" } }
	for _, id in ipairs(reachable or {}) do nodes[#nodes + 1] = { id = id, name = nameOf(id), type = "REACHABLE" } end
	m.taxi = nodes
	world.taxiNodes = nodes
	world.frame = { kind = "taxi" }
	stub.fire("TAXIMAP_OPENED", 0)
end

function GetTaxiMapID() return m.taxi and 9000 or nil end
C_TaxiMap = {}
function C_TaxiMap.GetAllTaxiNodes()
	local out = {}
	for i, n in ipairs(m.taxi or {}) do
		out[#out + 1] = { nodeID = n.id, name = n.name, slotIndex = i, state = n.type == "CURRENT" and 0 or 1 }
	end
	return out
end

-- The client closes the flight map once a destination is taken.
function TakeTaxiNode(slot)
	table.insert(m.took, slot)
end

function m.board()
	m.taxi = nil
	world.taxiNodes = {}
	world.close()
	world.onTaxi = true
	stub.fire("PLAYER_CONTROL_LOST")
end

function m.land()
	world.onTaxi = false
	stub.fire("PLAYER_CONTROL_GAINED")
end

---------------------------------------------------------------------------
-- Instances
---------------------------------------------------------------------------

function IsInInstance()
	if m.instance then return true, m.instance.kind end
	return false, "none"
end

function GetInstanceInfo()
	local i = m.instance
	if not i then return world.zone or "", "none", 0, "", 5, 0, false, 0, 0, nil end
	return i.name, i.kind, 1, "Normal", 5, 0, false, i.id, 5, nil
end

function m.enter(name, id, kind)
	stub.fire("PLAYER_LEAVING_WORLD")
	m.instance = { name = name, id = id, kind = kind or "party" }
	world.inInstance = true
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
end

function m.leave()
	stub.fire("PLAYER_LEAVING_WORLD")
	m.instance = nil
	world.inInstance = false
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
end

function m.addXP(n)
	world.xp = world.xp + n
	while world.xp >= world.xpMax do
		world.xp = world.xp - world.xpMax
		world.level = world.level + 1
		world.xpMax = world.xpMax + 100
	end
	stub.fire("PLAYER_XP_UPDATE", "player")
end

function GetNumSavedInstances() return #m.saved end
function GetSavedInstanceInfo(i)
	local s = m.saved[i]
	if not s then return nil end
	return s.name, s.id, s.reset, s.difficulty or 9, s.locked ~= false, s.extended or false, 0, s.isRaid ~= false,
		s.maxPlayers or 40, s.difficultyName or "40 Player", s.total or 10, s.done or 0, false, s.mapID or 409
end
function RequestRaidInfo()
	C_Timer.After(0, function() stub.fire("UPDATE_INSTANCE_INFO") end)
end

function m.jump(seconds)
	stub.epoch = stub.epoch + seconds
end

---------------------------------------------------------------------------
-- The world map (wow_stub.lua's map canvas, 1000 x 1000 canvas units; its
-- tables guarded: addon code may only read them)
--   m.withMapCanvas()          before login: continent 9100 holding zone 9000 at x 0.2-0.6, y 0.1-0.5
--   m.showMap(mapID)           open the world map on mapID (or show mapID in the open
--                              map), then one frame passes on the map
--   m.canvasScale              the canvas scale (zoom), read on the map's next frame
--   m.cursor = { nx, ny }      normalized cursor over the canvas (nil: off the map)
---------------------------------------------------------------------------

function m.withMapCanvas()
	world.addMap(9100, { name = "Testland", c = 0, top = 3000, bottom = -7000, left = 5000, right = -5000 })
	world.maps[9100].mapType = 2
	world.maps[9000].parent = 9100
	local map = WorldMapFrame
	m.canvas = map:GetCanvas()
	m.canvas:SetSize(1000, 1000)
	function map.GetMapID() return m.viewMap end
	function map.GetCanvasScale() return m.canvasScale or 1 end
	function map.IsCanvasMouseFocus() return m.cursor ~= nil end
	function map.GetNormalizedCursorPosition()
		if not m.cursor then return nil end
		return m.cursor[1], m.cursor[2]
	end
	stub.guardMap(map)
	stub.withSoftCursor()
	local getInfo = C_Map.GetMapInfo
	function C_Map.GetMapInfo(id)
		local info = getInfo(id)
		local b = world.maps[id]
		if info and b and b.mapType then info.mapType = b.mapType end
		return info
	end
	function C_Map.GetMapRectOnMap(id, top)
		if id == 9000 and top == 9100 then return 0.2, 0.6, 0.1, 0.5 end
		return nil
	end
	function C_Map.GetMapInfoAtPosition(id, x, y)
		if id == 9100 and x >= 0.2 and x <= 0.6 and y >= 0.1 and y <= 0.5 then return C_Map.GetMapInfo(9000) end
		return C_Map.GetMapInfo(id)
	end
end

function m.showMap(mapID)
	m.viewMap = mapID
	if not WorldMapFrame:IsShown() then WorldMapFrame:Show() end
	stub.runMapFrame(WorldMapFrame, 0)
end

return m
