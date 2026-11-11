-- env: world stub_maps.lua
-- The Guide page's arrow and routes rows (Polestar_Options/UI/Options.lua, Nav/Options.lua, UI/GuideOptions.lua;
-- Nav/Travel.lua, Walk.lua, Transit.lua, Journey.lua, Nearby.lua, Bridges.lua, Alerts.lua;
-- UI/JourneyPanel.lua) on the whole addon in stub_maps.lua's travel world: a goal across the sea on Far Isle, the
-- world map open on Testshire. What the modules' own tests fake stays faked the same way: the walking engine
-- (Polestar_Nav's, nav-handoff.rs), TomTom (stub_nav.lua's), the game's user waypoint (stub_nav.lua's), the route
-- and the boat's timetable for the alerts (nav-prompts.rs). The travel button under the arrow is the Buttons page's
-- (buttons-world.lua), beside the action set's Hearthstone.
local m, N, w, T, JP
local finds, lastStyle, spot = 0, false, 0
local pin = false
local current = false
local function target(label, map, x, y) N.SetTarget(map or 9001, x or 50, y or 30, label or "Far camp"); stub.advance(0.3) end
local function legs()
	local list, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, list and #list or 0 do out[#out + 1] = list[i].kind end
	return table.concat(out, ",")
end
local function tomtom()
	TomTom = {}
	function TomTom:AddWaypoint(map, x, y, opts) current = { map, x, y, title = opts and opts.title, crazy = opts and opts.crazy }; return current end
	function TomTom:RemoveWaypoint(uid) if uid == current then current = false end end
	stub.addonsLoaded.TomTom = true
	N.Reapply()
	stub.advance(0.3)
end
local function noTomTom()
	if current and TomTom then TomTom:RemoveWaypoint(current) end
	TomTom, current = nil, false
	stub.addonsLoaded.TomTom = nil
	N.Reapply()
	stub.advance(0.3)
end
-- The route and the planner's answer, as nav-prompts.rs fakes them, for one read; then the real ones back.
local function onRoute(route, read)
	local getRoute, active = N.GetRoute, N.travel.Active
	N.GetRoute = function() return route, 1 end
	N.travel.Active = function() return true end
	Polestar.Fire("ROUTE_CHANGED", route)
	stub.advance(0.2)
	local out = read()
	N.GetRoute, N.travel.Active = getRoute, active
	Polestar.Fire("ROUTE_CHANGED", N.GetRoute())
	stub.advance(0.2)
	return out
end
local WALK = { kind = "walk", label = "Walk", to = { c = 0, wx = 950, wy = 0 } }
local BOAT = { kind = "boat", transport = { id = "boat-west", kind = "boat" }, side = "a",
	from = { name = "West Dock", c = 0, wx = -900, wy = 900 }, to = { name = "Far Isle", c = 1, wx = 0, wy = 0 } }
-- At the West Dock with the boat 30 s out: the alert, and how it shows (banner, sound, taskbar).
local flashes = 0
local function dock()
	stub.now = stub.now + 200
	m.place(-880, 900)
	stub.advance(0.2)
	local X = Polestar.Transit
	local next, riding, now = X.NextArrival, X.Riding, X.Now
	X.NextArrival = function(_, id) if id == "boat-west" then return 30, 90, true end end
	X.Riding = function() return nil end
	local sounds, flashed = #stub.sounds, flashes
	local out = onRoute({ BOAT, WALK }, function()
		local alerted = N.alerts.Check()
		local b = PolestarAlert
		return { alerted = alerted and true or false, banner = b ~= nil and b:IsShown() and b.Title:GetText() or false,
			sound = #stub.sounds - sounds, flash = flashes - flashed }
	end)
	X.NextArrival, X.Riding, X.Now = next, riding, now
	if PolestarAlert then PolestarAlert:Hide() end
	m.place(0, 800)
	stub.advance(0.2)
	return out
end
return {
	setup = function()
		m, N, w, T = stub.maps, Polestar.Nav, stub.world, Polestar.Transit
		JP = Polestar.UI.JourneyPanel
		m.useWorld()
		m.place(0, 800)
		Polestar.Nav.RegisterTravelData(m.travel, true)
		Polestar.CharState().flags.taxi = { [1] = true, [3] = true }
		w.addItem(6948, 1)
		FlashClientIcon = function() flashes = flashes + 1 end
		-- Polestar_Nav's walking engine (not in this world), as nav-handoff.rs fakes it: what it is asked.
		N.Path = { Find = function(_, _, _, _, o) finds = finds + 1; lastStyle = o and o.style or false; return {} end,
			Cancel = function() end, Busy = function() return false end, Available = function() return true end }
		-- The game's user waypoint (stub_nav.lua's shape), which this world lacks.
		C_Map.CanSetUserWaypointOnMap = function() return true end
		C_Map.SetUserWaypoint = function(p) local x, y = p.position:GetXY(); pin = { p.uiMapID, x, y } end
		C_Map.ClearUserWaypoint = function() pin = false end
		C_SuperTrack = C_SuperTrack or {}
		C_SuperTrack.SetSuperTrackedUserWaypoint = C_SuperTrack.SetSuperTrackedUserWaypoint or function() end
		-- The world map under the cursor (Journey.lua's Alt-click reads it).
		WorldMapFrame.GetNormalizedCursorPosition = function() return 0.3, 0.7 end
		WorldMapFrame.ScrollContainer.IsMouseOver = function() return true end
		target()
	end,
	settle = 0.3,
	probes = {
		-- The goal across the sea: walk to the dock, the boat, walk on; or the straight arrow.
		["nav.travel"] = function() target("Far camp " .. stub.now); return legs() end,
		-- The journey panel under the window: the route's steps.
		["nav.journeySteps"] = function() target(); return JP.Route() ~= nil end,
		-- A route whose last walk goes round a hostile town (its leg's hubs.avoided, as ui-journey.rs's route has it):
		-- the journey panel's lines under each step.
		["nav.detourCaption"] = function()
			local route = { WALK, BOAT, { kind = "walk", label = "Walk to Far camp", to = { name = "Far camp", c = 1, wx = 50, wy = 30 },
				hubs = { avoided = { { id = 12, name = "Southshore" } } } } }
			return onRoute(route, function()
				local out = {}
				for _, r in ipairs(JP.rows) do
					if r:IsShown() then out[#out + 1] = r.Sub:IsShown() and r.Sub:GetText() or "-" end
				end
				return table.concat(out, " | ")
			end)
		end,
		-- A new goal a walk away (the player stands at Testshire 10, 50): Polestar_Nav is asked for the path.
		["nav.navRouting"] = function()
			local before = finds
			spot = spot % 8 + 1
			target("Near camp", 9000, 14 + spot / 2, 50)
			stub.advance(2)
			return finds - before > 0
		end,
		["nav.routeStyle"] = { value = "roads", probe = function()
			spot = spot % 8 + 1
			target("Near camp", 9000, 14, 50 + spot / 2)
			stub.advance(2)
			return lastStyle
		end },
		-- A druid's Teleport: Moonglade known: the routes may start with it.
		["nav.teleports"] = { prepare = function() w.learnSpell(18960); stub.fire("SPELLS_CHANGED"); stub.advance(0.1) end, probe = function()
			local out = {}
			for _, t in ipairs(T.Teleports(T.Now())) do out[#out + 1] = t.name end
			return table.concat(out, ",")
		end },
		-- A guildmate's sighting of the Menethil boat's loop (path-292), on a realm with none of its own: the boat's
		-- caption is timed from it, or stays an average wait.
		["nav.shareTransit"] = function()
			C_ChatInfo = C_ChatInfo or {}
			C_ChatInfo.SendAddonMessage = C_ChatInfo.SendAddonMessage or function() end
			T.ForgetSightings()
			local now = math.floor(T.Now())
			stub.fire("CHAT_MSG_ADDON", "PolestarT1", "Spath-292:" .. now .. ":12000", "GUILD", "Friend")
			stub.advance(0.1)
			return T.Caption("boat", "boat-menethil-theramore", T.Now(), "a") or false
		end,
		-- Alt-click on the world map open on Testshire: the arrow goes there.
		["nav.mapPlan"] = function()
			stub.worldMapID = 9000
			WorldMapFrame:Show()
			stub.keys.alt = true
			stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
			stub.keys.alt = false
			stub.advance(0.2)
			local t = N.GetTarget()
			local out = t and t.label or false
			WorldMapFrame:Hide()
			target()
			return out
		end,
		-- The game's tracking menu opened: Polestar's Nearby services in it.
		["nav.nearbyMenu"] = function()
			local made = 0
			local function node()
				local n = {}
				function n:CreateButton() made = made + 1; return node() end
				return n
			end
			N.nearby.AddMenu(nil, node())
			return made
		end,
		["nav.nearbyButton"] = function() local b = Polestar.UI.GuideFrame.nearbyButton; return b ~= nil and b:IsShown() and true or false end,
		-- The game's own waypoint, mirrored from the goal.
		["nav.blizzardWaypoint"] = function() target("Pinned " .. stub.now); return pin and pin[1] or false end,
		-- TomTom installed: its waypoint for the goal.
		["nav.tomtom"] = { prepare = tomtom, cleanup = noTomTom, probe = function()
			target("Mirrored")
			return current and current.title or false
		end },
		-- TomTom installed, a goal on the player's continent: Polestar's arrow, or TomTom's.
		["nav.useTomTomArrow"] = { prepare = tomtom, cleanup = noTomTom, probe = function()
			target("Near camp", 9000, 42, 42)
			return PolestarNavArrow:IsShown() and true or false
		end },
		["nav.alerts"] = dock,
		["nav.alertBanner"] = dock,
		["nav.alertSound"] = dock,
		["nav.alertFlash"] = dock,
		["Guide:Show a sample alert"] = { press = true, prepare = function() if PolestarAlert then PolestarAlert:Hide() end end,
			probe = function() return PolestarAlert ~= nil and PolestarAlert:IsShown() and PolestarAlert.Title:GetText() or false end,
			cleanup = function() if PolestarAlert then PolestarAlert:Hide() end end },
	},
}
