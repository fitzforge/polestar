-- env: world stub_maps.lua
-- The Map page's travel, NPC service and zone layers (Maps/TravelPins.lua, Services.lua, Reveal.lua, WorldMap.lua,
-- Coords.lua) in stub_maps.lua's small travel world with the map canvas (maps.rs, maps-services.rs,
-- maps-reveal.rs): the world map open on Testshire (or its continent) and the minimap, read as drawn: Polestar's
-- pins by layer and category, the revealed tiles, the zone labels and the info bar, the minimap readout. The
-- services come from a Codex holding one NPC per service, as maps-services.rs fakes it.
local m, P
local function drawn(layer, category)
	m.showMap(9000)
	stub.advance(0.3)
	stub.runMapFrame(WorldMapFrame, 0)
	local n = 0
	for _, f in ipairs(P.GetWorldFrames("pins")) do
		local d = f.data
		if d and d.layer and d.layer.name == layer and (not category or (d.pin and d.pin.category == category)) then n = n + 1 end
	end
	return n
end
local function minimap(layer) stub.advance(0.3); return #P.GetMinimapFrames(layer) end
local SERVICES = { ["maps.servicePins"] = true }
local function service(category) return { with = SERVICES, probe = function() return drawn("maps.services", category) end } end
-- A frame of Polestar's on the canvas: under it, at any depth (the map's view frame holds the drawings, as
-- maps-reveal.rs has it).
local function onCanvas(f)
	local p = f.parent
	while p do
		if p == m.canvas then return true end
		p = p.parent
	end
	return false
end
-- The unexplored areas' tiles on the canvas (the client's art, by file id): how many, and their tint.
local function revealed()
	m.showMap(9000)
	stub.advance(0.3)
	local n, tint = 0, false
	for _, f in ipairs(stub.frames) do
		if onCanvas(f) and f.regions and f:IsShown() then
			for _, t in ipairs(f.regions) do
				if t.IsShown and t:IsShown() and type(t.texture) == "number" and t.vertexColor then n = n + 1; tint = t.vertexColor end
			end
		end
	end
	return { tiles = n, tint = tint }
end
-- The continent map, the cursor over Testshire: its level label and the info bar.
local function continent()
	m.showMap(9100)
	m.cursor = { 0.4, 0.3 }
	stub.advance(0.2)
	local labels = 0
	for _, f in ipairs(stub.frames) do if f.parent == m.canvas and rawget(f, "Range") and f:IsShown() then labels = labels + 1 end end
	local bar = stub.frame("PolestarMapInfo")
	local out = { labels = labels, zone = bar:IsShown() and bar.Zone:GetText() or false, coords = bar:IsShown() and bar.Coords:GetText() or false }
	m.cursor = nil
	return out
end
local NPCS = {
	{ "Smith", { "vendor", "repair" } }, { "Grocer", { "vendor" } }, { "Banker", { "banker" } }, { "Auctioneer", { "auctioneer" } },
	{ "Battlemaster", { "battlemaster" } }, { "Spirit Healer", { "spirithealer" } }, { "Stable Master", { "stablemaster" } },
	{ "Warrior Trainer", { "trainer", "class:WARRIOR" } }, { "Alchemy Trainer", { "trainer", "trainer:171" } }, { "Weapon Master", { "trainer", "weapon" } },
}
return {
	setup = function()
		m, P = stub.maps, Polestar.Pins
		m.useWorld()
		m.withMapCanvas()
		m.place(0, 800)
		Polestar.Nav.RegisterTravelData(m.travel, true)
		Polestar.CharState().flags.taxi = { [1] = true, [3] = true }
		Polestar.Maps.RegisterZoneLevels({ [9000] = { 10, 20, 50, 50 } })
		-- Zone 9000's art: one layer of 256 px tiles, three unexplored overlays (maps-reveal.rs).
		C_Map.GetMapArtLayers = function(id)
			if id == 9000 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
			return {}
		end
		C_Map.GetMapArtID = function(id) return id == 9000 and 9001 or nil end
		C_MapExplorationInfo = { GetExploredMapTextures = function() return {} end }
		Polestar.UI.ZoneArt.RegisterOverlays("test", { [9001] = { 256, 256,
			{ 300, 200, 600, 100, 501, 502 }, { 100, 100, 50, 300, 503 }, { 64, 64, 0, 0, 504 } } })
		-- The Codex's service NPCs, one per service, by the player (and a mailbox).
		local npcs, objects = {}, { [1] = { id = 1, name = "Mailbox", mailbox = true, faction = "A", spawns = { { map = 9000, x = 10, y = 52, f = "l" } } } }
		for i, n in ipairs(NPCS) do
			npcs[i] = { id = i, name = n[1], faction = "A", roles = n[2], spawns = { { map = 9000, x = 8 + i * 0.5, y = 50, f = "l" } } }
		end
		Polestar.Codex = {
			IsLoaded = function() return true end,
			WithRole = function(role)
				local ids = {}
				for id, npc in pairs(npcs) do for _, r in ipairs(npc.roles) do if r == role then ids[#ids + 1] = id; break end end end
				table.sort(ids)
				return ids
			end,
			Npc = function(id) return npcs[id] end,
			Each = function(kind, fn) for id, o in pairs(objects) do fn(id, o.name) end end,
			Object = function(id) return objects[id] end,
		}
	end,
	probes = {
		["maps.taxiPins"] = function() return drawn("maps.taxi") end,
		["maps.dockPins"] = function() return drawn("maps.docks") end,
		["maps.innPins"] = function() return drawn("maps.inns") end,
		["maps.travelMinimap"] = { with = { ["maps.taxiPins"] = true, ["maps.innPins"] = true }, probe = function() return minimap("maps.taxi") + minimap("maps.inns") end },
		["maps.servicePins"] = function() return drawn("maps.services") end,
		["maps.serviceMinimap"] = { with = SERVICES, probe = function() return minimap("maps.services") end },
		["maps.serviceFilters.repair"] = service("repair"),
		["maps.serviceFilters.mailbox"] = service("mailbox"),
		["maps.serviceFilters.class"] = service("class"),
		["maps.serviceFilters.weapon"] = service("weapon"),
		["maps.serviceFilters.auctioneer"] = service("auctioneer"),
		["maps.serviceFilters.banker"] = service("banker"),
		["maps.serviceFilters.battlemaster"] = service("battlemaster"),
		["maps.serviceFilters.spirithealer"] = service("spirithealer"),
		["maps.serviceFilters.stablemaster"] = service("stablemaster"),
		["maps.serviceFilters.trainer"] = service("trainer"),
		["maps.serviceFilters.vendor"] = service("vendor"),
		["maps.reveal"] = revealed,
		["maps.zoneLevels"] = continent,
		["maps.coords"] = continent,
		["maps.minimapCoords"] = function()
			local f = stub.frame("PolestarMinimapCoords")
			return f ~= nil and f:IsShown() and true or false
		end,
	},
}
