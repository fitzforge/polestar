-- env: world stub_maps.lua
-- The Quality of Life page's flight timer and instance limits (Maps/FlightTimer.lua, Maps/Instances.lua) in
-- stub_maps.lua's small travel world, as maps.rs plays them: a flight taken and timed, instances entered, and
-- what the timer and /pole instances say.
local M, m
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
-- West Hold to Mid Camp (1000 yd): the timer as the flight starts, then a landing short of it (not learned).
local function timer()
	m.openTaxi(1, { 3, 2 })
	TakeTaxiNode(2)
	m.board()
	stub.advance(0.5)
	local f = stub.frame("PolestarFlightTimer")
	local text = f and f:IsShown() and f.Time:GetText() or false
	m.land()
	stub.advance(0.5)
	return text
end
-- /pole instances: its lines on this hour and the last day.
local function instances()
	stub.messages = {}
	SlashCmdList.POLESTAR("instances")
	stub.runTimers()
	local out = {}
	for _, line in ipairs(stub.messages) do
		local hour = line:match("Instances this hour: (%d+/%d+)")
		local day = line:match("Last 24 hours: (%d+/%d+)")
		if hour then out.hour = hour end
		if day then out.day = day end
	end
	return out
end
return {
	setup = function()
		M, m = Polestar.Maps, stub.maps
		m.useWorld()
		m.place(0, 800)
		Polestar.Nav.RegisterTravelData(m.travel, true)
		known(1, 2, 3)
		-- One flight learned (40 s), one instance entered and left.
		m.openTaxi(1, { 3, 2 })
		TakeTaxiNode(2)
		m.board()
		stub.advance(40)
		m.place(600, 0)
		m.land()
		stub.advance(0.5)
		m.place(0, 800)
		m.enter("Ragefire Chasm", 389)
		m.leave()
	end,
	probes = {
		["maps.perHour"] = instances,
		["maps.perDay"] = instances,
		["Quality of Life:Clear instance history"] = { press = true, probe = instances },
		["Quality of Life:Forget learned flight times"] = { press = true, probe = timer },
	},
}
