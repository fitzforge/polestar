-- The Nav modules' rows (docs/ARCHITECTURE.md, "Options registry"), in the
-- modules' order (Nav/Nav.xml): Journey, Nearby, Prompts, Alerts, Handoff.
-- Guide > Arrow & routes (Routes, Along the route), their doubles on Quality
-- of Life > Travel, and Integrations (TomTom, Shortest Path Forever). Part of
-- the settings' addon: none of it is in memory before the settings open.
-- One setting may show on two pages: a fresh control per page (the registry
-- keeps per-control state).

local ns = Polestar
local Nav = ns.Nav
local L = ns.L

-- Polestar's own Nav (Nav/Nav.lua's Nav.HandoffOption): a stand-in Nav table
-- has no rows to offer.
if not (Nav and Nav.HandoffOption and ns.RegisterOptions) then return end

local H = Nav.HandoffOption

local function register(spec)
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- Journey (Nav/Journey.lua): map clicks and the route's style; the TomTom
-- integration.
if Nav.journey then
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			H({ kind = "toggle", key = "nav.mapPlan", label = L["Shift-click a map to go there"],
				help = L["Shift-click the world map or minimap and the arrow takes you there; Alt-click works over map icons. Click the spot again to clear it."] }),
			H({ kind = "dropdown", key = "nav.routeStyle", label = L["Route style"],
				help = L["Fastest: the shortest walk, over hills and across fields. Balanced: roads that aren't much longer, and round hills. Roads: stays on roads even when they're longer; the safest way, not the quickest."],
				choices = { { value = "fastest", label = L["Fastest"] }, { value = "balanced", label = L["Balanced"] }, { value = "roads", label = L["Roads"] } } }),
		},
	})
	register({
		page = L["Integrations"], section = "TomTom",
		controls = {
			H({ kind = "toggle", key = "nav.answerTomTom", label = L["Let other addons set waypoints"],
				help = L["Without TomTom installed, waypoints other addons set through TomTom, and /way, point Polestar's arrow. Addons that expect TomTom's own settings may not work with it on."] }),
			{ kind = "toggle", key = "nav.followTomTom", label = L["Follow TomTom's arrow"],
				help = L["With TomTom installed, the arrow goes wherever TomTom's arrow points, routed like any goal."],
				disabled = function() return TomTom == nil or TomTom == Nav.tomtomShim end },
		},
	})
end

-- Nearby (Nav/Nearby.lua): also on Quality of Life > Travel > Nearby services.
if Nav.nearby then
	local function controls()
		return {
			{ kind = "toggle", key = "nav.nearbyMenu", label = L["Nearby services in map menus"],
				search = "nearest vendor, repair, trainer, mailbox, bank, inn, find npc, tracking",
				help = L["The world map's and minimap's tracking menus find the nearest trainer, vendor, inn, bank and more (/polestar near)."] },
			{ kind = "toggle", key = "nav.nearbyButton", label = L["Nearby services button"],
				search = "nearest vendor, repair, trainer, inn, flight master, find npc",
				help = L["A button in the guide window's header, left of the menu, finds the nearest vendor, repair, inn, flight master or trainer and points the arrow there."] },
		}
	end
	register({ page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"], controls = controls() })
	register({ page = L["Quality of Life"], tab = L["Travel"], section = L["Nearby services"], controls = controls() })
end

-- Prompts (Nav/Prompts.lua): Guide > Arrow & routes > Along the route (Alerts
-- adds its own), and Quality of Life > Travel > Along the route.
if Nav.prompts then
	local function castPrompt()
		return H({ kind = "toggle", key = "nav.castPrompt", label = L["Travel button"],
			search = "hearth, hearthstone, teleport, portal, cast button, travel spell",
			help = L["When the route says to hearth or teleport, a button under the arrow casts it. Right-click the arrow to skip a leg."] })
	end
	register({ page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"], controls = { castPrompt() } })
	register({ page = L["Quality of Life"], tab = L["Travel"], section = L["Along the route"], controls = { castPrompt() } })
end

-- Alerts (Nav/Alerts.lua): Guide > Arrow & routes > Along the route; the
-- alerts' switch also on Quality of Life > Travel > Along the route.
local Alerts = Nav.alerts
if Alerts then
	local function off() return not ns.Get("nav.alerts") end
	local function alerts()
		return H({ kind = "toggle", key = "nav.alerts", label = L["Transport alerts"],
			search = "boat, ship, zeppelin, tram, transport, departure, arrival, warning",
			help = L["Before your boat, zeppelin or tram comes in: 30 seconds ahead at the dock, 20 before the next stop on board. Never for lifts or in combat."] })
	end
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"],
		controls = {
			alerts(),
			H({ kind = "toggle", key = "nav.alertBanner", label = L["Show a banner"], disabled = off,
				help = L["A small card near the top of the screen with a countdown. Click it to dismiss."] }),
			H({ kind = "toggle", key = "nav.alertSound", label = L["Play the transport's sound"], disabled = off,
				help = L["The ship's bell, the zeppelin's horn or the tram, on the Master channel so you hear it with the game in the background."] }),
			H({ kind = "toggle", key = "nav.alertFlash", label = L["Flash the taskbar icon"], disabled = off,
				help = L["The game's icon flashes while the game is in the background."] }),
			{ kind = "button", button = L["Show"], label = L["Show a sample alert"], disabled = off,
				help = L["See the banner and hear the boat's bell."],
				onClick = function() Alerts.ShowSample() end },
		},
	})
	register({ page = L["Quality of Life"], tab = L["Travel"], section = L["Along the route"], controls = { alerts() } })
end

-- Handoff (Nav/Handoff.lua): Integrations > Shortest Path Forever.
if Nav.handoff then
	register({
		page = L["Integrations"], section = "Shortest Path Forever",
		controls = {
			{ kind = "toggle", key = "nav.spfHandoff", label = L["Hand guiding to Shortest Path Forever"],
				help = L["Shortest Path Forever's arrow, route and journey take you to each goal. Polestar's arrow, route lines, journey steps, travel button, transport alerts, map clicks and /way step aside; the guide window and map pins stay. Off: Polestar guides, and steps aside only while a journey you started in Shortest Path Forever runs."],
				needs = Nav.handoff.Available },
		},
	})
end
