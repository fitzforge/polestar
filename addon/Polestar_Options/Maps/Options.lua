-- The Maps modules' rows (docs/ARCHITECTURE.md, "Options registry"): the map
-- features on the Map page (its sections are declared by the options window,
-- UI/Options.lua), NPC services (Maps/Services.lua), and the flight timer and
-- the instance tracker on the Quality of Life page (Travel and Trackers).
-- Part of the settings' addon: none of it is in memory before the settings
-- open. One setting may show on two pages: a fresh control per page (the
-- registry keeps per-control state).

local ns = Polestar
local Maps = ns.Maps
local L = ns.L

if not (Maps and ns.RegisterOptions) then return end

local function off(key)
	return function() return not ns.Get(key) end
end

local MAP = L["Map"]

local function register(spec)
	local ok, err = ns.RegisterOptions(spec)
	if not ok and err then ns.Debug(err) end
end

-- Coordinates and the minimap button, also on Quality of Life > Trackers & map.
local function coords()
	return { kind = "toggle", key = "maps.coords", label = L["Coordinates"], search = "coords, position, location, xy, cursor",
		help = L["Shows your position and the cursor's position under the world map."] }
end
local function minimapCoords()
	return { kind = "toggle", key = "maps.minimapCoords", label = L["Coordinates on the minimap"], search = "coords, position, location, xy",
		help = L["A small readout of your position at the bottom of the minimap."] }
end
local function minimapButton()
	return { kind = "toggle", key = "maps.minimapButton", label = L["Minimap button"], search = "minimap icon, minimap button, hide button, launcher",
		help = L["A Polestar button on the edge of the minimap. Click to hide or show Polestar, right-click for a menu, drag to move it."] }
end

-- The map's second tab: rares (Rares/Options.lua), travel, NPC services and zones.
local PLACES = L["Rares, travel & zones"]

register({
	page = MAP, tab = PLACES, section = L["Dungeons and travel"],
	controls = {
		{ kind = "toggle", key = "maps.dungeonPins", label = L["Dungeon entrances"], search = "instance, dungeon, entrance, map pins, icons, markers",
			help = L["Marks each dungeon entrance with its level range. Click to open the dungeon's guide, or to set a waypoint when there is none; Shift-click always sets a waypoint. Needs the Codex pack."] },
		{ kind = "toggle", key = "maps.taxiPins", label = L["Flight masters"], search = "flight, taxi, flight path, gryphon, wind rider, map pins, icons, markers",
			help = L["Your faction's and neutral flight masters: green when known, amber when not yet discovered. The tooltip lists destinations and flight times."] },
		{ kind = "toggle", key = "maps.dockPins", label = L["Boats and zeppelins"], search = "boat, ship, zeppelin, tram, dock, map pins, icons, markers",
			help = L["Docks, zeppelin towers and the Deeprun Tram, with where they go."] },
		{ kind = "toggle", key = "maps.innPins", label = L["Inns"], search = "inn, innkeeper, hearth, hearthstone, map pins, icons, markers",
			help = L["Innkeepers; the one your Hearthstone is bound to is marked."] },
		{ kind = "toggle", key = "maps.travelMinimap", label = L["Travel icons on the minimap"], search = "flight, taxi, boat, inn, minimap icons, markers",
			help = L["Shows the flight masters, docks and inns turned on here on the minimap as well."] },
	},
})

register({
	page = MAP, tab = PLACES, section = L["Zones and coordinates"],
	controls = {
		{ kind = "dropdown", key = "maps.reveal", label = L["Unexplored areas"], search = "fog of war, reveal map, unexplored, explore, undiscovered",
			help = L["Shows the parts of each zone you have not explored yet, so the whole map is there before you visit. Tinted keeps them apart from where you have been."],
			choices = { { value = "off", label = L["Hidden"] }, { value = "on", label = L["Revealed"] }, { value = "tint", label = L["Revealed and tinted"] } } },
		{ kind = "toggle", key = "maps.zoneLevels", label = L["Zone level ranges"], search = "zone levels, level range, where to level",
			help = L["Shows each zone's level range on the continent and zone maps, coloured by difficulty for your level."] },
		coords(),
		minimapCoords(),
	},
})

register({ page = MAP, tab = L["Guide & quests"], section = L["Guide"], controls = { minimapButton() } })
register({ page = L["Quality of Life"], tab = L["Trackers & map"], section = L["Minimap and coordinates"], controls = { minimapButton(), coords(), minimapCoords() } })

-- The flight timer and the instance tracker join Quality of Life's Travel
-- and Trackers & map tabs; their sections are declared there, in order.
local QOL = L["Quality of Life"]
register({
	page = QOL, tab = L["Travel"], section = L["Flights"],
	controls = {
		{ kind = "toggle", key = "maps.flightTimer", label = L["Flight timer"], search = "flight, taxi, timer, time left", move = "flightTimer",
			help = L["While flying, shows the destination and the time left. Learns each route's real duration for this character; drag to move."] },
		{ kind = "button", button = L["Forget"], label = L["Forget learned flight times"],
			help = L["Clears this character's recorded flight durations; estimates are used until they are flown again."],
			onClick = function()
				ns.CharState().flightTimes = {}
				ns.Print(L["Learned flight times cleared."])
			end },
	},
})
-- The instance tracker: its switch in the section's header, then its display and its limits.
register({
	page = QOL, tab = L["Trackers & map"], section = L["Instances"], move = "instances",
	toggle = { kind = "toggle", key = "maps.instances", label = L["Track instances"], search = "dungeon, instance lockout, instance cap, reset, runs",
		help = L["Records dungeon and raid entries, time and experience per run. /pole instances lists them."] },
	controls = {
		{ kind = "toggle", key = "maps.instanceDisplay", label = L["Compact display"],
			help = L["Shows the hourly instance count and the current run while it matters; drag to move."],
			disabled = off("maps.instances") },
		{ kind = "slider", key = "maps.perHour", label = L["Instances per hour"], min = 1, max = 10, step = 1, format = "%d",
			help = L["Classic allows 5 new instances per hour per account. Forever may differ; adjust if it does."],
			disabled = off("maps.instances") },
		{ kind = "slider", key = "maps.perDay", label = L["Instances per day"], min = 0, max = 60, step = 1, format = "%d",
			help = L["Classic Era allows 30 new instances per 24 hours per account; 0 ignores the daily cap. Forever may differ."],
			disabled = off("maps.instances") },
		{ kind = "button", button = L["Clear"], label = L["Clear instance history"],
			help = L["Forgets recorded entries and runs (the server's own limit is not affected)."],
			onClick = function() if Maps.ClearInstances then Maps.ClearInstances() end end },
	},
})

-- NPC services (Maps/Services.lua): the layer's switch in the section's
-- header, its minimap icons and a toggle per category.
local CATEGORIES = Maps.ServiceCategories
if CATEGORIES then
	local function servicesOff() return not ns.Get("maps.servicePins") end
	local controls = {
		{ kind = "toggle", key = "maps.serviceMinimap", label = L["Service icons on the minimap"],
			help = L["Shows the enabled NPC service categories on the minimap as well."],
			disabled = servicesOff },
	}
	for _, category in ipairs(CATEGORIES) do
		controls[#controls + 1] = { kind = "toggle", key = "maps.serviceFilters." .. category.key, label = category.label,
			help = category.key == "class" and L["Shows trainers for your character's class."] or L["Shows this service category on the map."],
			disabled = servicesOff }
	end
	register({ page = MAP, tab = PLACES, section = L["NPC services"],
		toggle = { kind = "toggle", key = "maps.servicePins", label = L["Show NPC services"],
			help = L["Marks friendly service NPCs and mailboxes on zone and city maps using Polestar's bundled Codex. Click an individual icon to set a waypoint, or a city group to choose an NPC and destination; choose categories here or in the map's tracking menu. Flight masters and inns have their own toggles under Dungeons and travel."] },
		controls = controls })
end
