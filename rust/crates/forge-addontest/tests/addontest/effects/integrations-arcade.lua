-- env: world stub_maps.lua
-- The Flight Arcade setting in stub_maps.lua's travel world: board a flight from West Hold to Mid Camp,
-- read the visibility of the Sky Jewels shortcut, then land (away from Mid Camp: nothing learned).
local m
return {
	setup = function()
		m = stub.maps
		m.useWorld()
		m.place(0, 800)
		Polestar.Nav.RegisterTravelData(m.travel, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
		Polestar.Maps.CharTable("flightTimes")["1>3"] = 300
		stub.advance(0.5)
	end,
	settle = 0.2,
	probes = {
		["maps.flightArcade"] = function()
			m.openTaxi(1, { 3, 2 })
			TakeTaxiNode(2)
			m.board()
			stub.advance(1)
			local hud = stub.frame("PolestarFlightArcade")
			local out = hud ~= nil and hud.Jewels:IsVisible()
			m.land()
			stub.advance(0.5)
			return out
		end,
	},
}
