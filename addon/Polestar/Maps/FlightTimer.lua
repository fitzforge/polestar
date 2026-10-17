-- Flight timer: while on a taxi, the destination and the time left.
--
-- Picking a destination (TakeTaxiNode, hooked, never replaced) remembers the
-- route; boarding starts the clock. The duration is this character's own
-- recording of that exact from -> to flight when there is one
-- (CharState().flightTimes, learned on every landing at the destination),
-- otherwise an estimate from the travel data: the shortest chain of known
-- flight legs at gryphon speed. Estimates show with a "~".
--
-- Cost: one hidden driver frame, shown only between picking a destination
-- and landing, ticking five times a second; text is formatted only when the
-- shown second changes.

local ADDON, ns = ...
local Maps = ns.Maps
local Client = Maps.Client
local serverTime = ns.Compat.Now
local L = ns.L

local type, pairs, ipairs, floor, lower, huge = type, pairs, ipairs, math.floor, string.lower, math.huge
local sqrt = math.sqrt

local FLIGHT_SPEED = 30   -- yd/s along the path (Classic gryphon/wyvern; Nav's planner uses the same)
local FLIGHT_STOP = 2     -- seconds per hop: take-off and landing
local TICK = 0.2
local BOARD_WINDOW = 10   -- seconds from picking a node to being on the taxi
local LAND_RADIUS = 300   -- yards: landed at the destination, so the time is learnable
local MIN_FLIGHT, MAX_FLIGHT = 5, 3600

---------------------------------------------------------------------------
-- Travel data lookups
---------------------------------------------------------------------------

local function travel()
	local N = ns.Nav
	return N and N.GetTravelData and N.GetTravelData() or nil
end

local function knownNodes()
	local N = ns.Nav
	return N and N.GetKnownTaxiNodes and N.GetKnownTaxiNodes() or nil
end

-- Node ID for a taxi node name ("Stormwind, Elwynn" or just "Stormwind"),
-- preferring the node this character's faction may use.
function Maps.TaxiNodeByName(name, faction)
	local d = travel()
	if not (d and name) then return nil end
	local key = lower(name)
	local fallback
	for _, node in pairs(d.taxi) do
		if lower(node.name) == key or lower(node.short or "") == key then
			if Maps.Allowed(node.faction, faction or 0) then return node.id end
			fallback = fallback or node.id
		end
	end
	return fallback
end

-- A node's short name to show: in the client's language (the names pack's,
-- else the client's own `fallback`), else the data's English.
local function nodeName(id, fallback)
	local d = travel()
	local node = d and id and d.taxiById[id]
	if not node then return fallback end
	local N = ns.Names
	if N and N.Localised() then
		local T = ns.Nav and ns.Nav.travel
		return (N.Taxi(node.id) and T and T.TaxiName(node, true)) or fallback or node.short or node.name
	end
	return node.short or node.name
end

-- Estimated seconds for one flight leg of `yards`.
function Maps.LegSeconds(yards)
	return yards / FLIGHT_SPEED + FLIGHT_STOP
end

-- Seconds by air from node `from` to node `to`, Dijkstra over the flight legs
-- through nodes this faction may use and, when known nodes are recorded, only
-- through known ones (the client routes over discovered nodes). nil: no route.
function Maps.EstimateFlight(from, to, faction, known)
	local d = travel()
	if not (d and from and to) or from == to then return nil end
	local nodes, flights = d.taxiById, d.flights
	if not (nodes[from] and nodes[to]) then return nil end
	faction = faction or 0
	local useKnown = false
	if type(known) == "table" then
		for _ in pairs(known) do
			useKnown = true
			break
		end
	end
	local dist, done = { [from] = 0 }, {}
	while true do
		local u, best = nil, huge
		for id, dv in pairs(dist) do
			if not done[id] and dv < best then u, best = id, dv end
		end
		if not u then return nil end
		if u == to then return floor(best + 0.5) end
		done[u] = true
		local legs = flights[u]
		if legs then
			for i = 1, #legs - 1, 2 do
				local v, yards = legs[i], legs[i + 1]
				local node = nodes[v]
				if node and not done[v] and Maps.Allowed(node.faction, faction)
					and (not useKnown or known[v] or v == to) then
					local alt = best + Maps.LegSeconds(yards)
					if not dist[v] or alt < dist[v] then dist[v] = alt end
				end
			end
		end
	end
end

-- Learned durations are keyed by node IDs when both are known, else by names.
function Maps.FlightKey(from, to, fromName, toName)
	if from and to then return from .. ">" .. to end
	if fromName and toName then return lower(fromName) .. ">" .. lower(toName) end
	return nil
end

-- This character's recorded duration of that exact flight, or nil.
function Maps.LearnedFlight(from, to, fromName, toName)
	local key = Maps.FlightKey(from, to, fromName, toName)
	local learned = key and Maps.CharTable("flightTimes")[key]
	return type(learned) == "number" and learned or nil
end

-- seconds, "learned" | "estimate"   (nil when neither is available)
function Maps.FlightSeconds(from, to, fromName, toName)
	local learned = Maps.LearnedFlight(from, to, fromName, toName)
	if learned then return learned, "learned" end
	local est = Maps.EstimateFlight(from, to, Maps.Faction(), knownNodes())
	if est then return est, "estimate" end
	return nil
end

function Maps.LearnFlight(from, to, fromName, toName, seconds)
	local key = Maps.FlightKey(from, to, fromName, toName)
	if not key or type(seconds) ~= "number" or seconds < MIN_FLIGHT or seconds > MAX_FLIGHT then return false end
	Maps.CharTable("flightTimes")[key] = floor(seconds + 0.5)
	return true
end

---------------------------------------------------------------------------
-- The live flight
---------------------------------------------------------------------------

local slots = {}       -- taxi map slot -> { id, name }, while the map is open
local current          -- { id, name } of the node the taxi map is at
local pending          -- picked, not yet airborne: { from, to, fromName, toName, at }
local flight           -- airborne: pending's fields + start, total, source
local frame, driver
local shownSecond, shownState

local function onTaxi()
	local C = ns.Compat
	return C and C.IsOnTaxi and C.IsOnTaxi() or false
end

local function render()
	if not frame then return end
	if not (flight and ns.Get("maps.flightTimer")) then
		frame:Hide()
		return
	end
	local elapsed = GetTime() - flight.start
	local state, second
	if flight.total then
		local left = flight.total - elapsed
		if left <= 0 then state, second = "late", 0 else state, second = flight.source, floor(left + 0.5) end
		local W = ns.Widgets
		if W and W.SetProgress then W.SetProgress(frame.Progress, elapsed / flight.total) end
	else
		state, second = "up", floor(elapsed)
	end
	if second ~= shownSecond or state ~= shownState then
		shownSecond, shownState = second, state
		if state == "late" then
			frame.Time:SetText(L["landing"])
		elseif state == "estimate" then
			frame.Time:SetText("~" .. Maps.FormatTime(second))
		else
			frame.Time:SetText(Maps.FormatTime(second))
		end
	end
	if not frame:IsShown() then
		frame.Dest:SetText(flight.toName or L["In flight"])
		frame:Show()
	end
end

local function saveNow()
	local s = ns.CharState()
	if flight then
		s.flightNow = {
			from = flight.from, to = flight.to, fromName = flight.fromName, toName = flight.toName,
			started = serverTime() - floor(GetTime() - flight.start),
		}
	else
		s.flightNow = nil
	end
end

local function begin(f)
	flight = f
	flight.start = flight.start or GetTime()
	flight.total, flight.source = Maps.FlightSeconds(f.from, f.to, f.fromName, f.toName)
	shownSecond, shownState = nil, nil
	saveNow()
	ns.Fire("FLIGHT_STARTED", flight.toName, flight.total)
end

local function nearDestination()
	local d = travel()
	local node = d and flight.to and d.taxiById[flight.to]
	if not node then return true end
	local C = ns.Compat
	local c, wx, wy
	if C and C.GetPlayerWorldPosition then c, wx, wy = C.GetPlayerWorldPosition() end
	if not c then return true end
	if c ~= node.c then return false end
	local dx, dy = wx - node.wx, wy - node.wy
	return sqrt(dx * dx + dy * dy) <= LAND_RADIUS
end

local function land()
	local elapsed = GetTime() - flight.start
	if nearDestination() then
		Maps.LearnFlight(flight.from, flight.to, flight.fromName, flight.toName, elapsed)
	end
	ns.Fire("FLIGHT_ENDED", flight.toName, elapsed)
	flight = nil
	saveNow()
	if frame then frame:Hide() end
end

local function tick()
	local airborne = onTaxi()
	if flight then
		if airborne then render() else land() end
	elseif airborne then
		begin(pending or { toName = nil })
		pending = nil
		render()
	elseif pending and GetTime() - pending.at > BOARD_WINDOW then
		pending = nil
	end
	if not (flight or pending) then driver:Hide() end
end

local function buildFrame()
	if frame or not ns.Widgets then return end
	local W = ns.Widgets
	frame = Maps.CompactFrame("PolestarFlightTimer", "maps.timerPos", "TOP", 0, -140)
	frame:SetSize(220, 34)
	local icon = W.Tex(frame, "ARTWORK", "icon-fly", "accent")
	icon:SetSize(16, 16)
	icon:SetPoint("LEFT", frame, "LEFT", 10, 1)
	frame.Time = W.Text(frame, "number", "text")
	frame.Time:SetPoint("RIGHT", frame, "RIGHT", -10, 1)
	frame.Time:SetJustifyH("RIGHT")
	frame.Dest = W.Text(frame, "body", "text")
	frame.Dest:SetPoint("LEFT", icon, "RIGHT", 8, 0)
	frame.Dest:SetPoint("RIGHT", frame.Time, "LEFT", -8, 0)
	frame.Progress = W.ProgressLine(frame, 2)
	frame.Progress:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 1, 1)
	frame.Progress:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
end

driver = CreateFrame("Frame")
driver:Hide()
local acc = 0
driver:SetScript("OnUpdate", function(_, dt)
	acc = acc + dt
	if acc < TICK then return end
	acc = 0
	tick()
end)

local function wake()
	acc = TICK
	driver:Show()
end

-- Current state for other modules: toName, secondsLeft (nil when unknown), source.
function Maps.GetFlight()
	if not flight then return nil end
	local left = flight.total and flight.total - (GetTime() - flight.start)
	return flight.toName, left, flight.source
end

---------------------------------------------------------------------------
-- Events and hooks
---------------------------------------------------------------------------

local function resolve(id, name)
	if not id and name then id = Maps.TaxiNodeByName(name, Maps.Faction()) end
	return id, nodeName(id, name and (name:match("^([^,]+),") or name))
end

ns.RegisterEvent("TAXIMAP_OPENED", function()
	for k in pairs(slots) do slots[k] = nil end
	local cid, cname = Client.TaxiCurrent()
	current = cname and { resolve(cid, cname) } or nil
	if NumTaxiNodes then
		for i = 1, NumTaxiNodes() or 0 do
			local id, name = Client.TaxiSlot(i)
			if name then slots[i] = { resolve(id, name) } end
		end
	end
end)

local function onTake(slot)
	if not ns.Get("maps.flightTimer") then return end
	local dest = slots[slot]
	if not dest then
		local id, name = Client.TaxiSlot(slot)
		if name then dest = { resolve(id, name) } end
	end
	if not dest then return end
	pending = {
		from = current and current[1], fromName = current and current[2],
		to = dest[1], toName = dest[2], at = GetTime(),
	}
	wake()
end

if TakeTaxiNode and hooksecurefunc then hooksecurefunc("TakeTaxiNode", onTake) end

local function check()
	if onTaxi() or flight or pending then wake() end
end

for _, event in ipairs({ "PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED", "PLAYER_ENTERING_WORLD" }) do
	ns.RegisterEvent(event, check)
end

ns.On("SETTING_CHANGED", function(path)
	if path == "maps.flightTimer" or path == "" or path == "maps" then render() end
	if path == "maps.timerPos" and frame then frame.Place() end
end)

ns.OnLogin(function()
	buildFrame()
	-- A /reload mid-flight: pick the flight up again from the saved start.
	local saved = ns.CharState().flightNow
	if type(saved) == "table" and onTaxi() and type(saved.started) == "number" then
		local ago = serverTime() - saved.started
		if ago >= 0 and ago < MAX_FLIGHT then
			begin({ from = saved.from, to = saved.to, fromName = saved.fromName, toName = saved.toName, start = GetTime() - ago })
			render()
		end
	else
		ns.CharState().flightNow = nil
	end
	check()
end)
