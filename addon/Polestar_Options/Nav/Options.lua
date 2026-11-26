-- The Nav modules' rows (docs/ARCHITECTURE.md, "Options registry"), in the
-- modules' order (Nav/Nav.xml): Journey, Nearby, Alerts, Handoff.
-- Guide > Arrow & routes (Routes, Along the route, Getting around), their
-- references on Quality of Life > Travel > Hearth and travel, and Integrations
-- (TomTom, Shortest Path Forever). The travel button (Prompts) sits beside
-- the action set's Hearthstone, on the Buttons page, Questing > Buttons and
-- Hearth and travel (QoL/Options.lua). Part of
-- the settings' addon: none of it is in memory before the settings open.
-- One setting has one home row; another page shows a reference to it
-- (UI.Options.Ref).

local ns = Polestar
local Nav = ns.Nav
local L = ns.L

-- Polestar's own Nav (Nav/Nav.lua's Nav.HandoffOption): a stand-in Nav table
-- has no rows to offer.
if not (Nav and Nav.HandoffOption and ns.RegisterOptions) then return end

local H = Nav.HandoffOption
local Ref = ns.Widgets.Ref

local function register(spec)
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- Journey (Nav/Journey.lua): the route's style; map clicks with the other ways
-- round the world (Getting around); the TomTom integration.
if Nav.journey then
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			H({ kind = "dropdown", key = "nav.routeStyle", label = L["Which way to walk"],
				help = L["Fastest: the shortest walk, over hills and across fields. Balanced: roads that aren't much longer, and round hills. Roads: stays on roads even when they're longer; the safest way, not the quickest."],
				choices = { { value = "fastest", label = L["Fastest"] }, { value = "balanced", label = L["Balanced"] }, { value = "roads", label = L["Roads"] } } }),
		},
	})
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Getting around"],
		controls = {
			H({ kind = "toggle", key = "nav.mapPlan", label = L["Shift-click a map to go there"],
				help = L["Shift-click the world map or minimap and the arrow takes you there; Alt-click works over map icons. Click the spot again to clear it."] }),
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
-- The waypoint mirror and its arrow, with the other waypoint addon's other
-- settings (they were on Guide > Arrow & routes > Other waypoints).
register({
	page = L["Integrations"], section = "TomTom",
	controls = {
		H({ kind = "toggle", key = "nav.tomtom", label = L["Mirror to TomTom"], help = L["Adds the target as a TomTom waypoint when TomTom is loaded."], search = "waypoints, tomtom",
			children = {
				H({ kind = "toggle", key = "nav.useTomTomArrow", label = L["Use TomTom's arrow"], help = L["Hides Polestar's arrow in favour of TomTom's, except on the way to another continent, where TomTom's arrow cannot point."] }),
			} }),
	},
})

-- Nearby (Nav/Nearby.lua): Guide > Arrow & routes > Getting around, and a
-- reference on Quality of Life > Travel > Hearth and travel.
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
	register({ page = L["Guide"], tab = L["Arrow & routes"], section = L["Getting around"], controls = controls() })
	register({ page = L["Quality of Life"], tab = L["Travel"], section = L["Hearth and travel"],
		controls = { Ref("toggle", "nav.nearbyMenu"), Ref("toggle", "nav.nearbyButton") } })
end

-- Alerts (Nav/Alerts.lua): their home is Alerts > Transport alert
-- (UI/Looks/Toasts.lua); Guide > Arrow & routes > Along the route shows a
-- reference to the switch, and the sample.
local Alerts = Nav.alerts
if Alerts then
	local function off() return not ns.Get("nav.alerts") end
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"],
		controls = {
			Ref("toggle", "nav.alerts"),
			{ kind = "button", button = L["Show"], label = L["Show a sample alert"], disabled = off,
				help = L["See the banner and hear the boat's bell."],
				onClick = function() Alerts.ShowSample() end },
		},
	})
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
