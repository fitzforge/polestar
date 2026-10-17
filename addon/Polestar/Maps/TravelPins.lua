-- Travel icons on the world map (and optionally the minimap), through
-- Polestar.Pins, from the travel data Nav registers (TravelData.lua):
--   maps.taxi   flight masters of this faction and neutral ones; known ones
--               green, undiscovered ones amber; the tooltip lists direct
--               destinations with this character's learned flight time or
--               an estimate.
--   maps.docks  both ends of every boat, zeppelin and the tram this faction
--               may ride; the tooltip names where it goes, the ride and the
--               rough wait.
--   maps.inns   innkeepers; the one the Hearthstone is bound to glows.
-- Layers are rebuilt on login, discovery (taxi map), binding, settings and
-- theme changes; never per frame.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local type, ipairs, lower, format = type, ipairs, string.lower, string.format

local KIND = {
	boat = { label = L["Boat to %s"], color = "npc" },
	zeppelin = { label = L["Zeppelin to %s"], color = "place" },
	tram = { label = L["Deeprun Tram to %s"], color = "object" },
}

-- Names to show, in the client's language (Nav/Travel.lua: by area and node
-- id), else the data's English.
local function placeName(p)
	local T = ns.Nav and ns.Nav.travel
	return T and T.PlaceName and T.PlaceName(p) or p.name
end

local function taxiName(node, short)
	local T = ns.Nav and ns.Nav.travel
	if T and T.TaxiName then return T.TaxiName(node, short) end
	return short and node.short or node.name
end

local function color(name, a)
	local T = ns.Theme
	if T and T.Color then
		local r, g, b = T.Color(name)
		return { r, g, b, a or 1 }
	end
	return { 1, 1, 1, a or 1 }
end

local function rgb(name)
	local T = ns.Theme
	if T and T.Color then return T.Color(name) end
	return 1, 1, 1
end

---------------------------------------------------------------------------
-- Tooltips
---------------------------------------------------------------------------

local function taxiTooltip(node, data, faction, known)
	return function(tip)
		tip:SetText(taxiName(node), rgb("text"))
		local status = known[node.id] and L["Flight master, known"] or L["Flight master, not discovered"]
		if node.faction == 3 then status = status .. " · " .. L["Neutral"] end
		tip:AddLine(status, rgb(known[node.id] and "success" or "warning"))
		local legs = data.flights[node.id]
		if not legs then return end
		local header = false
		for i = 1, #legs - 1, 2 do
			local dest = data.taxiById[legs[i]]
			if dest and Maps.Allowed(dest.faction, faction) then
				if not header then
					tip:AddLine(" ")
					tip:AddLine(L["Flights from here"], rgb("textDim"))
					header = true
				end
				local secs = Maps.LearnedFlight(node.id, dest.id)
				local t = secs and Maps.FormatTime(secs) or ("~" .. Maps.FormatTime(Maps.LegSeconds(legs[i + 1])))
				local r, g, b = rgb(known[dest.id] and "text" or "textMuted")
				local name = taxiName(dest, true)
				if not known[dest.id] then name = name .. " " .. L["(not discovered)"] end
				tip:AddDoubleLine(name, t, r, g, b, rgb("textDim"))
			end
		end
	end
end

local function dockTooltip(t, here, there, ride, waitThere, waitHere)
	return function(tip)
		local kind = KIND[t.kind] or KIND.boat
		tip:SetText(format(kind.label, placeName(there)), rgb("text"))
		tip:AddLine(format(L["From %s"], placeName(here)), rgb("textDim"))
		if ride then
			tip:AddDoubleLine(L["Ride"], Maps.FormatTime(ride), rgb("textDim"))
			local cycle = (t.ab or 0) + (t.ba or 0) + (waitThere or 0) + (waitHere or 0)
			if cycle > 0 then tip:AddDoubleLine(L["Departs about every"], Maps.FormatTime(cycle), rgb("textDim")) end
		end
	end
end

local function innTooltip(inn, bound)
	return function(tip)
		tip:SetText(placeName(inn), rgb("text"))
		tip:AddLine(L["Inn"], rgb("textDim"))
		if bound then tip:AddLine(L["Your Hearthstone is bound here"], rgb("success")) end
	end
end

local function pinAt(p, icon, size, col, tooltip, priority)
	return {
		c = p.c, wx = p.wx, wy = p.wy, map = p.map, x = p.x, y = p.y, f = p.f,
		icon = icon, size = size, color = col, tooltip = tooltip, priority = priority,
	}
end

---------------------------------------------------------------------------
-- Layer building (pure: everything comes in `o`)
--   o = { data = Nav.GetTravelData(), faction = 1|2|0, known = { [nodeID] = true }, bind = "Goldshire" | nil }
-- -> taxi, docks, inns (pin lists)
---------------------------------------------------------------------------

function Maps.BuildTravelPins(o)
	local data, faction, known = o.data, o.faction or 0, o.known or {}
	local taxi, docks, inns = {}, {}, {}
	if type(data) ~= "table" then return taxi, docks, inns end
	local knownCol, unknownCol = color("success"), color("warning")
	for _, node in ipairs(data.taxi or {}) do
		if Maps.Allowed(node.faction, faction) then
			local isKnown = known[node.id] and true or false
			local p = pinAt(node, "icon-fly", isKnown and 14 or 15, isKnown and knownCol or unknownCol,
				taxiTooltip(node, data, faction, known), isKnown and 2 or 3)
			p.nodeID, p.known = node.id, isKnown
			taxi[#taxi + 1] = p
		end
	end
	for _, t in ipairs(data.transports or {}) do
		if Maps.Allowed(t.faction, faction) then
			local col = color((KIND[t.kind] or KIND.boat).color)
			local a = pinAt(t.a, "icon-boat", 15, col, dockTooltip(t, t.a, t.b, t.ab, t.waitB, t.waitA), 1)
			a.transport, a.dest = t.id, t.b.name
			local b = pinAt(t.b, "icon-boat", 15, col, dockTooltip(t, t.b, t.a, t.ba, t.waitA, t.waitB), 1)
			b.transport, b.dest = t.id, t.a.name
			docks[#docks + 1] = a
			docks[#docks + 1] = b
		end
	end
	local bind = o.bind and lower(o.bind)
	for _, inn in ipairs(data.inns or {}) do
		local bound = false
		if bind then
			for _, n in ipairs(inn.names or {}) do
				if lower(n) == bind then bound = true end
			end
		end
		local p = pinAt(inn, "icon-hearth", bound and 14 or 12, color(bound and "success" or "quest"), innTooltip(inn, bound), bound and 2 or 0)
		p.glow, p.bound = bound or nil, bound
		inns[#inns + 1] = p
	end
	return taxi, docks, inns
end

---------------------------------------------------------------------------
-- Applying the layers
---------------------------------------------------------------------------

local LAYERS = {
	{ name = "maps.taxi", key = "maps.taxiPins" },
	{ name = "maps.docks", key = "maps.dockPins" },
	{ name = "maps.inns", key = "maps.innPins" },
}

local queued = false

function Maps.RefreshTravelPins()
	queued = false
	local Pins, N = ns.Pins, ns.Nav
	if not (Pins and Pins.SetLayer) then return end
	local C = ns.Compat
	local built = { Maps.BuildTravelPins({
		data = N and N.GetTravelData and N.GetTravelData() or nil,
		faction = Maps.Faction(),
		known = N and N.GetKnownTaxiNodes and N.GetKnownTaxiNodes() or {},
		bind = C and C.GetBindLocation and C.GetBindLocation() or nil,
	}) }
	local opts = { world = true, minimap = ns.Get("maps.travelMinimap") and true or false, edge = false }
	for i, layer in ipairs(LAYERS) do
		if ns.Get(layer.key) and #built[i] > 0 then
			Pins.SetLayer(layer.name, built[i], opts)
		else
			Pins.ClearLayer(layer.name)
		end
	end
end

local function queue()
	if queued then return end
	queued = true
	if C_Timer and C_Timer.After then
		C_Timer.After(0, Maps.RefreshTravelPins)
	else
		Maps.RefreshTravelPins()
	end
end

local WATCH = { ["maps.taxiPins"] = true, ["maps.dockPins"] = true, ["maps.innPins"] = true, ["maps.travelMinimap"] = true, ["maps"] = true, [""] = true }

ns.On("SETTING_CHANGED", function(path)
	if WATCH[path] and ns.IsLoggedIn() then queue() end
end)

for _, event in ipairs({ "TAXIMAP_OPENED", "TAXIMAP_CLOSED", "HEARTHSTONE_BOUND" }) do
	ns.RegisterEvent(event, function()
		if ns.IsLoggedIn() then queue() end
	end)
end

ns.OnLogin(function()
	local T = ns.Theme
	if T and T.OnChanged then T.OnChanged(queue) end
	queue()
end)
