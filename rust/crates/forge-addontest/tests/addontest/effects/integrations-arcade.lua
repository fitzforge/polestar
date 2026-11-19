-- env: world stub_maps.lua
-- The Integrations page's Freedoom Arcade (Polestar_Options/Maps/Options.lua; Maps/Arcade.lua) on the whole addon in
-- stub_maps.lua's travel world, as maps-arcade.rs plays it: Polestar_Arcade in the addon list, and each check takes
-- a flight from West Hold to Mid Camp this character has flown in 5 minutes, reads whether the card under the
-- flight timer asks, then lands (away from Mid Camp: nothing learned).
local m
return {
	setup = function()
		m = stub.maps
		m.useWorld()
		m.place(0, 800)
		Polestar.Nav.RegisterTravelData(m.travel, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
		Polestar.Maps.CharTable("flightTimes")["1>3"] = 300
		stub.addons[#stub.addons + 1] = { name = "Polestar_Arcade", reason = "DEMAND_LOADED" }
		stub.advance(0.5)
	end,
	settle = 0.2,
	probes = {
		["maps.flightArcade"] = function()
			m.openTaxi(1, { 3, 2 })
			TakeTaxiNode(2)
			m.board()
			stub.advance(1)
			local c = _G.PolestarArcadeOffer
			local out = c ~= nil and c:IsShown() and c.mode or false
			m.land()
			stub.advance(0.5)
			return out
		end,
	},
}
