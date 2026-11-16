-- env: world
-- The Map pins page's presets (Polestar_Options/Nav/PinsOptions.lua; Nav/Pins.lua, Layers.lua) on the whole addon,
-- whose settings window registers them (pins.lua's nav environment loads the page alone, without the window): a
-- character in Elwynn with a goal 100 yd away and the world map open on Elwynn; the goal's pin as drawn.
local P
local function target()
	stub.advance(0.1)
	stub.runMapFrame(WorldMapFrame, 0)
	for _, f in ipairs(P.GetWorldFrames("pins")) do
		if f.data and f.data.layer and f.data.layer.name == "nav.target" then return { f.width, f.glow ~= nil and f.glow:IsShown() } end
	end
	return false
end
return {
	setup = function()
		P = Polestar.Pins
		local w = stub.world
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 45, 50)
		Polestar.Nav.SetTarget(1429, 50, 50, "Goal")
		stub.worldMapID = 1429
		WorldMapFrame:Show()
		stub.advance(0.5)
	end,
	probes = {
		-- A preset card (Large): the goal's pin bigger.
		["Map pins:Presets"] = target,
	},
}
