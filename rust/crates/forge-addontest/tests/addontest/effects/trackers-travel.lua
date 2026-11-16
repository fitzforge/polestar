-- env: world stub_maps.lua
-- The Trackers page's Travel tab and its presets (Polestar_Options/UI/Looks/Trackers.lua; UI/Trackers.lua,
-- Maps/FlightTimer.lua, UI/JourneyPanel.lua) on the whole addon in stub_maps.lua's travel world, as maps.rs and
-- ui-look-toasts.rs play them: each check takes a flight from West Hold to Mid Camp (35 s, estimated) and reads the
-- live flight timer half a second in, then lands; with a goal across the sea on Far Isle (walk, the boat, walk), the
-- journey under the guide window. Polestar_Nav's walking engine (not in this world) is faked as nav-handoff.rs does.
local m, N, JP
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return (select(2, fs:GetFont())) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function ground(f) return { f.psBgAlpha or false, rgba(f.psSkin.bg) } end
local function border(f)
	local e = f.psBorder
	return { e ~= nil and e[1]:IsShown(), e ~= nil and rgba(e[1]) or false, e ~= nil and e[1]:GetHeight() or false }
end
-- Half a second into a flight: read(the timer), then the landing (away from Mid Camp: nothing learned).
local function timer(read)
	return function()
		m.openTaxi(1, { 3, 2 })
		TakeTaxiNode(2)
		m.board()
		stub.advance(0.5)
		local out = read(PolestarFlightTimer)
		m.land()
		stub.advance(0.5)
		return out
	end
end
-- The journey's rows on screen: their count, whether the first shows its number.
local function journey()
	N.SetTarget(9001, 50, 30, "Far camp")
	stub.advance(0.3)
	JP.Refresh(true)
	local n = 0
	for _, r in ipairs(JP.rows) do if r:IsShown() then n = n + 1 end end
	return { n, JP.rows[1] ~= nil and JP.rows[1].Num:IsShown() }
end
return {
	setup = function()
		m, N, JP = stub.maps, Polestar.Nav, Polestar.UI.JourneyPanel
		m.useWorld()
		m.place(0, 800)
		N.RegisterTravelData(m.travel, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
		N.Path = { Find = function() return {} end, Cancel = function() end, Busy = function() return false end, Available = function() return true end }
		-- The guide window up: the journey sits in it.
		Polestar.Set("ui.shown", true)
		Polestar.UI.GuideFrame.frame:Show()
		stub.advance(0.5)
	end,
	settle = 0.2,
	probes = {
		["maps.flightTimer"] = timer(function(f) return f:IsShown() end),
		["trackers.flight.scale"] = timer(function(f) return f:GetScale() end),
		["trackers.flight.width"] = timer(function(f) return f:GetWidth() end),
		["trackers.flight.alpha"] = timer(function(f) return f:GetAlpha() end),
		["trackers.flight.bgAlpha"] = timer(ground),
		["trackers.flight.bg"] = timer(ground),
		["trackers.flight.borderSize"] = timer(border),
		["trackers.flight.border"] = timer(border),
		["trackers.flight.barHeight"] = timer(function(f) return f.Progress:GetHeight() end),
		["trackers.flight.bar"] = timer(function(f) return f.Progress:IsShown() end),
		["trackers.flight.barColor"] = timer(function(f) return rgba(f.Progress.Fill) end),
		["trackers.flight.titleSize"] = timer(function(f) return { size(f.Time), f:GetHeight() } end),
		["trackers.flight.outline"] = timer(function(f) return flags(f.Time) end),
		["trackers.flight.format"] = timer(function(f) return f.Time:GetText() end),
		["trackers.flight.bodySize"] = timer(function(f) return size(f.Dest) end),
		-- A preset card (Compact): the timer smaller, without its bar.
		["Trackers:Presets"] = timer(function(f) return { f:GetScale(), f.Progress:IsShown() } end),
		-- The journey of three steps: two of them listed (the third counted), their numbers.
		["trackers.journey.rows"] = { value = 2, probe = function() return journey()[1] end },
		["trackers.journey.numbers"] = function() return journey()[2] end,
	},
}
