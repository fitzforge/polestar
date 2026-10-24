//! Travel prompts (addon/Polestar/Nav/Prompts.lua), transport alerts (Nav/Alerts.lua) and the flight map's route
//! highlight (QoL/Flight.lua). Prompts and alerts run the real Core/Init.lua + Theme + Nav/Nav.xml against
//! tests/lua/stub_nav.lua with the route, Nav.travel and ns.Transit replaced by fakes in the script, and secure
//! frames enforced as the client does (SetAttribute, Show, Hide, SetPoint, ClearAllPoints, SetScale error in
//! combat). The flight map runs the QoL harness (tests/lua/stub_qol.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn nav_addon() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])
}

// Secure frames: the client refuses protected changes in combat.
const SECURE: &str = r#"
local M = stub.Methods
for _, name in ipairs({ "SetAttribute", "Show", "Hide", "SetPoint", "ClearAllPoints", "SetScale" }) do
	local original = M[name]
	M[name] = function(self, ...)
		if self.secure and stub.inCombat then error("protected call in combat: " .. tostring(self.name) .. ":" .. name, 2) end
		return original(self, ...)
	end
end
local createFrame = CreateFrame
function CreateFrame(kind, name, parent, template, id)
	local f = createFrame(kind, name, parent, template, id)
	if type(template) == "string" and template:find("Secure") then f.secure = true end
	return f
end
flashes = 0
function FlashClientIcon() flashes = flashes + 1 end
"#;

const PRELUDE: &str = r#"
local N = Polestar.Nav
local P = N.prompts
local nav = stub.nav
local route = { legs = nil, ci = 1 }
N.GetRoute = function() return route.legs, route.legs and route.ci or nil end
local skipped = 0
N.travel.Active = function() return route.legs ~= nil and #route.legs > 1 and route.ci <= #route.legs end
N.travel.SkipLeg = function()
	skipped = skipped + 1
	route.ci = route.ci + 1
	Polestar.Fire("ROUTE_ADVANCED", route.legs, route.ci)
	return true
end
local function setRoute(legs, ci)
	route.legs, route.ci = legs, ci or 1
	Polestar.Fire("ROUTE_CHANGED", legs)
end
local function combat(on)
	stub.inCombat = on
	stub.fire(on and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
end
local function btn() return _G.PolestarTravelButton end
local function state()
	local b = btn()
	if not b then return { exists = false } end
	local a = b.attributes or {}
	return { exists = true, shown = b:IsShown() and true or false, type1 = a.type1 or false, item = a.item or false, spell = a.spell or false }
end
local HEARTH = { kind = "hearth", item = 6948, label = "Hearth to Goldshire", from = { c = 0, wx = 0, wy = 0 }, to = { c = 0, wx = 900, wy = 0 } }
local WALK = { kind = "walk", label = "Walk", to = { c = 0, wx = 950, wy = 0 } }
"#;

fn run_nav(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], before: SECURE.into(), addons: vec![nav_addon()], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() })
}

#[test]
fn travel_button_a_hearth_leg_gets_a_secure_item_button_under_the_arrow_out_of_combat() {
	let out = run_nav(
		r#"
		nav.items[6948] = 1
		emit(state())
		setRoute({ HEARTH, WALK })
		emit(state())
		-- under the arrow's foot
		local a = N.arrow.frame
		local _, rel, relPoint = btn():GetPoint(1)
		emit({ rel == UIParent, relPoint })
		-- the leg ends: hidden and emptied
		route.ci = 2
		Polestar.Fire("ROUTE_ADVANCED", route.legs, 2)
		emit(state())
		-- no Hearthstone in the bags: no button
		nav.items[6948] = 0
		setRoute({ HEARTH, WALK })
		emit(state())
		-- switched off
		nav.items[6948] = 1
		Polestar.Set("nav.castPrompt", false)
		setRoute({ HEARTH, WALK })
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "exists": false }));
	assert_eq!(out[1], json!({ "exists": true, "shown": true, "type1": "item", "item": "item:6948", "spell": false }));
	assert_eq!(out[2][0], true);
	assert!(out[2][1] == "BOTTOMLEFT" || out[2][1] == "TOP");
	assert_eq!(out[3], json!({ "exists": true, "shown": false, "type1": false, "item": false, "spell": false }));
	assert_eq!(out[4]["shown"], false);
	assert_eq!(out[5]["shown"], false);
}

#[test]
fn travel_button_issues_6_never_changed_in_combat_the_last_request_lands_when_combat_ends() {
	let out = run_nav(
		r#"
		nav.items[6948] = 1
		-- a hearth leg that begins in combat creates nothing until it ends
		combat(true)
		setRoute({ HEARTH, WALK })
		emit({ state(), P.Pending() })
		combat(false)
		emit(state())
		-- the leg ends mid-fight: the button keeps its action until the fight ends
		combat(true)
		route.ci = 2
		Polestar.Fire("ROUTE_ADVANCED", route.legs, 2)
		emit({ state(), P.Pending() })
		-- back to the hearth, still in combat: the last request wins
		route.ci = 1
		Polestar.Fire("ROUTE_ADVANCED", route.legs, 1)
		combat(false)
		emit({ state(), P.Pending() })
	"#,
	);
	assert_eq!(out[0], json!([{ "exists": false }, true]));
	assert_eq!(out[1]["shown"], true);
	assert_eq!(out[2], json!([{ "exists": true, "shown": true, "type1": "item", "item": "item:6948", "spell": false }, true]));
	assert_eq!(out[3], json!([{ "exists": true, "shown": true, "type1": "item", "item": "item:6948", "spell": false }, false]));
}

#[test]
fn travel_button_issues_c1_a_route_cleared_or_replaced_while_a_change_waits_on_combat_revives_nothing() {
	let out = run_nav(
		r#"
		nav.items[6948] = 1
		combat(true)
		setRoute({ HEARTH, WALK })
		setRoute(nil)
		combat(false)
		emit({ state(), P.Pending() })
		-- shown, then replaced mid-fight by a route with no cast leg
		setRoute({ HEARTH, WALK })
		combat(true)
		setRoute({ WALK, { kind = "walk", to = {} } })
		route.legs = nil
		Polestar.Fire("ROUTE_CHANGED", nil)
		combat(false)
		emit(state())
		-- ticks after the cancel stay quiet
		N.Refresh()
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!([{ "exists": false }, false]));
	assert_eq!(out[1], json!({ "exists": true, "shown": false, "type1": false, "item": false, "spell": false }));
	assert_eq!(out[2], out[1]);
}

#[test]
fn travel_button_a_teleport_leg_casts_its_spell_when_known_an_item_leg_uses_its_item() {
	let out = run_nav(
		r#"
		local known = {}
		Polestar.Compat.IsSpellKnown = function(id) return known[id] == true end
		function C_Spell_name(id) return "Teleport: Darnassus" end
		GetSpellInfo = function(id) if id == 3565 then return "Teleport: Darnassus" end end
		local TELE = { kind = "teleport", spell = 3565, label = "Teleport to Darnassus", to = { c = 1, wx = 0, wy = 0 } }
		setRoute({ TELE, WALK })
		emit(state())
		known[3565] = true
		setRoute({ TELE, WALK })
		emit(state())
		nav.items[17690] = 1
		setRoute({ { kind = "teleport", item = 17690, label = "Use the Frostwolf insignia", to = { c = 0, wx = 0, wy = 0 } }, WALK })
		emit(state())
	"#,
	);
	assert_eq!(out[0], json!({ "exists": false }));
	assert_eq!(out[1], json!({ "exists": true, "shown": true, "type1": "spell", "item": false, "spell": "Teleport: Darnassus" }));
	assert_eq!(out[2], json!({ "exists": true, "shown": true, "type1": "item", "item": "item:17690", "spell": false }));
}

#[test]
fn skip_leg_issues_11_the_hearth_and_the_flight_offer_a_skip_class_teleports_still_prompt_the_last_leg_and_no_route_have_none() {
	let out = run_nav(
		r#"
		nav.items[6948] = 1
		emit(P.MenuItems() == nil)
		local FLY = { kind = "fly", label = "Fly to East Hold", from = { id = 1 }, to = { id = 2 } }
		setRoute({ HEARTH, FLY, WALK })
		local items = P.MenuItems()
		emit(items[1].text)
		items[1].onClick(items[1])
		emit({ skipped, route.ci, state().shown })
		emit(P.MenuItems()[1].text)
		SlashCmdList.POLESTAR("skipleg")
		emit({ skipped, route.ci, P.MenuItems() == nil })
		-- the final walk is the arrow's own target
		SlashCmdList.POLESTAR("skipleg")
		emit(skipped)
		-- a skipped Hearthstone leaves teleports alone
		Polestar.Compat.IsSpellKnown = function(id) return id == 3565 end
		setRoute({ { kind = "teleport", spell = 3565, label = "Teleport", to = { c = 1, wx = 0, wy = 0 } }, WALK })
		emit(state().type1)
	"#,
	);
	assert_eq!(out[0], true);
	assert_eq!(out[1], "Skip this leg");
	assert_eq!(out[2], json!([1, 2, false]));
	assert_eq!(out[3], "Skip this leg");
	assert_eq!(out[4], json!([2, 3, true]));
	assert_eq!(out[5], 2);
	assert_eq!(out[6], "spell");
}

#[test]
fn second_review_p3_legs_that_replan_when_skipped_offer_skip_this_leg_walks_and_lifts_mark_this_leg_done() {
	let out = run_nav(
		r#"
		local function row(leg)
			setRoute({ leg, WALK })
			local items = P.MenuItems()
			return items[1].text .. " / " .. items[1].tip
		end
		local to = { c = 0, wx = 900, wy = 0 }
		emit({
			hearth = row(HEARTH),
			teleport = row({ kind = "teleport", spell = 3565, label = "Teleport", to = to }),
			fly = row({ kind = "fly", label = "Fly", from = { id = 1 }, to = { id = 2 } }),
			boat = row({ kind = "boat", transport = { id = "boat-test" }, side = "a", label = "Boat", from = to, to = to }),
			portal = row({ kind = "portal", transport = { id = "portal-test" }, label = "Portal", from = to, to = to }),
			walk = row({ kind = "walk", label = "Walk to the lift", to = to }),
			lift = row({ kind = "lift", lift = 7, side = "top", label = "Ride the elevator down", from = to, to = to }),
		})"#,
	);
	let skip = "Skip this leg / Plans the rest of this trip without it.";
	let done = "Mark this leg done / The arrow moves on to the next leg.";
	assert_eq!(out[0], json!({ "hearth": skip, "teleport": skip, "fly": skip, "boat": skip, "portal": skip, "walk": done, "lift": done }));
}

#[test]
fn alerts_issues_c5_30_s_before_a_timed_boat_at_the_dock_20_s_before_the_next_stop_on_board_once_per_visit() {
	let out = run_nav(
		r#"
		local arrive, riding = nil, nil
		Polestar.Transit = {
			Now = function() return 1000 end,
			NextArrival = function(kind, id, now, side) if id == "boat-test" and side == "a" then return arrive, (arrive or 0) + 60, true end end,
			Riding = function() return riding end,
		}
		local A = N.alerts
		local BOAT = { kind = "boat", transport = { id = "boat-test", kind = "boat" }, side = "a",
			from = { name = "Testshire Docks", c = 0, wx = -900, wy = 0 }, to = { name = "Farland Pier", c = 1, wx = 400, wy = 0 } }
		setRoute({ { kind = "walk", to = BOAT.from }, BOAT, WALK }, 2)
		nav.place(-850, 0)
		local function check(secs) arrive = secs; return A.Check() end
		emit({ check(45), check(31), check(30), check(28), check(25) })
		emit({ #stub.sounds, stub.sounds[1], flashes, A.banner and A.banner:IsShown(), A.banner and A.banner.Title:GetText() })
		-- far from the dock: nothing
		stub.advance(200)
		nav.place(0, 0)
		emit(check(30))
		-- untimed, or docked now: nothing
		nav.place(-850, 0)
		emit(check(nil))
		emit(check(0))
		-- in combat: nothing
		stub.inCombat = true
		emit(check(30))
		stub.inCombat = false
		-- no readable position: nothing, and no error
		nav.player = nil
		emit(check(30))
		nav.place(-850, 0)
		-- riding: 20 s before the next dock
		riding = { kind = "boat", route = "boat-test", dock = "Farland Pier", arriveIn = 22 }
		emit(A.Check())
		riding.arriveIn = 20
		emit(A.Check())
		-- lifts never alert
		riding = { kind = "lift", route = "lift-1", dock = "Top", arriveIn = 20 }
		emit(A.Check())
		-- each part has its own switch
		riding = nil
		stub.advance(200)
		Polestar.Set("nav.alertSound", false)
		Polestar.Set("nav.alertFlash", false)
		local before, flashed = #stub.sounds, flashes
		emit({ check(30), #stub.sounds - before, flashes - flashed })
		stub.advance(200)
		Polestar.Set("nav.alerts", false)
		emit(check(30))
	"#,
	);
	assert_eq!(out[0], json!([false, false, true, false, false]));
	assert_eq!(out[1], json!([1, 566652, 1, true, "Boat to Farland Pier"]));
	assert_eq!(out[2], false);
	assert_eq!(out[3], false);
	assert_eq!(out[4], false);
	assert_eq!(out[5], false);
	assert_eq!(out[6], false);
	assert_eq!(out[7], false);
	assert_eq!(out[8], true);
	assert_eq!(out[9], false);
	assert_eq!(out[10], json!([true, 0, 0]));
	assert_eq!(out[11], false);
}

// ---------------------------------------------------------------------------
// Flight map (QoL harness)
// ---------------------------------------------------------------------------

fn qol_addon() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])
}

const TAXI: &str = r#"
local q = stub.qol
local QoL = Polestar.QoL
-- The flight master's own map: node IDs by slot, the hops to each slot, button anchors.
taxiIDs, taxiHops, types = {}, {}, {}
function GetTaxiMapID() return 1415 end
C_TaxiMap = { GetAllTaxiNodes = function()
	local out = {}
	for slot, id in ipairs(taxiIDs) do out[#out + 1] = { nodeID = id, slotIndex = slot, name = "node " .. id } end
	return out
end }
function TaxiNodeGetType(slot) return types[slot] or "REACHABLE" end
function GetNumRoutes(slot) return taxiHops[slot] and #taxiHops[slot] or 0 end
function TaxiGetNodeSlot(slot, hop, source) local h = taxiHops[slot][hop]; return source and h[1] or h[2] end
TaxiRouteMap = CreateFrame("Frame", "TaxiRouteMap", UIParent)
TAXIROUTE_LINEFACTOR = 32 / 30
drawn = {}
function DrawLine(tex, canvas, sx, sy, ex, ey) drawn[#drawn + 1] = { sx, sy, ex, ey } end
local function open(names)
	q.openTaxi(names)
end
local function anchor(slot, x, y)
	local b = _G["TaxiButton" .. slot]
	b:ClearAllPoints()
	b:SetPoint("CENTER", TaxiRouteMap, "BOTTOMLEFT", x, y)
end
"#;

fn run_qol(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![qol_addon()], login: true, script: format!("{TAXI}{script}"), ..Default::default() })
}

#[test]
fn flight_map_the_route_s_flight_is_found_by_node_id_its_hops_drawn_names_only_without_ids() {
	let out = run_qol(
		r#"
		local names = { "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" }
		taxiIDs = { 2, 5, 12 }
		-- Two same-named nodes would fool a name match; the ID cannot be fooled.
		q.nav.route = {
			{ kind = "walk", to = { name = "Stormwind" } },
			{ kind = "fly", from = { id = 2 }, to = { id = 12, name = "Somewhere Else" } },
			{ kind = "walk", to = {} },
		}
		q.nav.ci = 1
		for i = 1, 3 do if not _G["TaxiButton" .. i] then CreateFrame("Button", "TaxiButton" .. i, TaxiFrame) end end
		anchor(1, 100, 100); anchor(2, 200, 50); anchor(3, 50, 200)
		taxiHops[3] = { { 1, 2 }, { 2, 3 } }
		open(names)
		emit({ QoL.Flight.node, QoL.Flight.Drawn(), #drawn })
		emit(drawn[1])
		stub.fire("TAXIMAP_CLOSED")
		-- the flight is the current leg itself
		q.nav.ci = 2
		drawn = {}
		open(names)
		emit({ QoL.Flight.node, #drawn })
		stub.fire("TAXIMAP_CLOSED")
		-- the destination is the node you stand at, or unreachable: no mark, no name guess
		types[3] = "CURRENT"
		open(names)
		emit(QoL.Flight.node or "none")
		stub.fire("TAXIMAP_CLOSED")
		types[3] = nil
		-- a route without node IDs falls back to names
		q.nav.route = { { kind = "fly", to = { name = "Lakeshire, Redridge" } }, { kind = "walk", to = {} } }
		q.nav.ci = 1
		open(names)
		emit(QoL.Flight.node)
		emit(#q.calls)
	"#,
	);
	assert_eq!(out[0], json!([3, 3, 2]));
	assert_eq!(out[1], json!([100, 100, 200, 50]));
	assert_eq!(out[2], json!([3, 2]));
	assert_eq!(out[3], "none");
	assert_eq!(out[4], 2);
}

#[test]
fn flight_map_review_p3_12_the_chat_fallback_for_an_unmarkable_node_is_said_once_per_map_open_not_on_every_replan() {
	let out = run_qol(
		r#"
		local function said()
			local n = 0
			for _, m in ipairs(stub.messages) do if m:find("Route: fly to", 1, true) then n = n + 1 end end
			return n
		end
		-- Sentinel Hill has no button on screen, so the route can only be named in chat.
		local function openWithout(names, hidden)
			q.taxiNodes = names
			for i = 1, #names do
				local b = _G["TaxiButton" .. i] or CreateFrame("Button", "TaxiButton" .. i, TaxiFrame)
				if i == hidden then b:Hide() else b:Show() end
			end
			TaxiFrame:Show()
			stub.fire("TAXIMAP_OPENED", 1)
			stub.runTimers()
		end
		q.nav.route = { { kind = "fly", to = { name = "Sentinel Hill, Westfall" } }, { kind = "walk", to = {} } }
		q.nav.ci = 1
		openWithout({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" }, 3)
		emit({ QoL.Flight.node, said() })
		for _ = 1, 3 do Polestar.Fire("ROUTE_CHANGED", q.nav.route) end
		emit(said())
		stub.fire("TAXIMAP_CLOSED")
		TaxiFrame:Hide()
		openWithout({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" }, 3)
		emit(said())
	"#,
	);
	assert_eq!(out[0], json!([3, 1]));
	assert_eq!(out[1], 1);
	assert_eq!(out[2], 2);
}
