-- env: world stub_rares.lua
-- codex: sample.json
-- The Map page's rare, treasure and dungeon entrance pins (Rares/Pins.lua, Maps/Dungeons.lua) from the sample
-- Codex (rares.rs): a level 10 character in Elwynn by Thuros Lightfingers's spawn, the world map open on Elwynn
-- (or Eastern Plaguelands, for Stratholme's entrance), read as drawn: Polestar's pins by layer on the world map
-- and the minimap.
local w, P
local function drawn(map, layer)
	stub.worldMapID = map
	WorldMapFrame:Show()
	stub.advance(0.3)
	stub.runMapFrame(WorldMapFrame, 0)
	local n = 0
	for _, f in ipairs(P.GetWorldFrames("pins")) do if f.data and f.data.layer and f.data.layer.name == layer then n = n + 1 end end
	return n
end
-- The minimap's pins of a layer with the player at (x, y) on Elwynn.
local function minimap(layer, x, y)
	w.moveTo(1429, x, y)
	stub.advance(0.3)
	local n = #P.GetMinimapFrames(layer)
	w.moveTo(1429, 88, 78)
	stub.advance(0.1)
	return n
end
return {
	setup = function()
		w, P = stub.world, Polestar.Pins
		w.addMap(1423, { name = "Eastern Plaguelands", c = 0, left = -2185.417, right = -6056.25, top = 3800, bottom = 1218.75 })
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1535.417, right = -1935.417, top = -7939.583, bottom = -10254.166 })
		w.moveTo(1429, 88, 78)
		w.setLevel(10)
		-- The world map opened once, so the Codex is loaded for the world map's kinds.
		stub.worldMapID = 1429
		WorldMapFrame:Show()
		Polestar.Codex.Load()
		stub.advance(0.5)
	end,
	probes = {
		["rares.worldRares"] = function() return drawn(1429, "rares.rare") end,
		["rares.worldTreasures"] = function() return drawn(1429, "rares.treasure") end,
		["rares.minimapRares"] = function() return minimap("rares.rare", 88, 78) end,
		-- By the Battered Chest's spawn.
		["rares.minimapTreasures"] = function() return minimap("rares.treasure", 79, 56) end,
		-- Thuros (level 11) for a level 20: grey.
		["rares.hideGrey"] = { with = { ["rares.worldRares"] = true },
			prepare = function() w.setLevel(20) end,
			probe = function() return drawn(1429, "rares.rare") end,
			cleanup = function() w.setLevel(10) end },
		["maps.dungeonPins"] = function() return drawn(1423, "maps.dungeons") end,
	},
}
