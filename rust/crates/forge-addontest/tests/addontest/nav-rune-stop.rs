//! The rune stop (addon/Polestar/Nav/RuneStop.lua, #3547): a Mage out of runes on a route that flies is offered a nearby
//! seller only when walking there, buying and teleporting clearly saves time. Runs the real Core/Init.lua + Nav/Nav.xml
//! against tests/lua/stub_nav.lua's travel world.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local N = Polestar.Nav
local R = N.runeStop
local nav = stub.nav
local RUNE = 17031
Polestar.Compat.GetUnitZone = function() return 9000 end
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	return N.SetTarget(m, x, y, label or "Target")
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
local function seller(wx, wy)
	local m, x, y = nav.mapPoint(wx, wy)
	return { id = 77, name = "Rune Seller", map = m, x = x, y = y, c = 0, wx = wx, wy = wy }
end
local function mage(wx, wy)
	local _, x, y = nav.mapPoint(wx, wy)
	-- Another map: the planner leaves out a teleport to the map it starts on.
	return { spell = 3561, name = "Teleport: Testshire", cast = 10, rune = RUNE,
		to = { name = "Testshire", c = 0, wx = wx, wy = wy, map = 9001, x = x, y = y } }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}\nnav.faction = \"Alliance\"\nPolestar.CharState().flags.taxiSeen = {{ [0] = true, [1] = true }}\nnav.useTravelWorld()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_near_seller_is_handed_to_the_engine_when_the_teleport_clearly_beats_the_flight_and_held_while_the_arrow_leads_there() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		local missing = { mage(0, -780) }
		local sold = { seller(20, 600) }
		local got, sets, aimed = nil, 0, false
		Polestar.Engine.SetRuneStop = function(o) got, sets = o, sets + 1 end
		Polestar.Engine.RuneStopAimed = function() return aimed end
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return sold end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		local o = R.Find()
		r.seller = o and o.seller.name
		r.saves = o and o.saves >= 60
		R.Refresh()
		r.handed = got and got.seller.name
		aimed = true
		target(20, 600, "Rune Seller")
		sets = 0
		R.Refresh()
		r.heldWhileAimed = sets == 0 and got ~= nil
		missing = {}
		R.Refresh()
		r.goneOnceBought = got == nil
		sets = 0
		R.Refresh()
		r.quietWithNoOffer = sets == 0
		emit(r)"#);
	assert_eq!(out["seller"], "Rune Seller");
	assert_eq!(out["saves"], true);
	assert_eq!(out["handed"], "Rune Seller");
	assert_eq!(out["heldWhileAimed"], true, "the arrow on the vendor: the route no longer flies, the line stays");
	assert_eq!(out["goneOnceBought"], true);
	assert_eq!(out["quietWithNoOffer"], true);
}

#[test]
fn a_seller_across_town_counts_and_the_closest_by_travel_time_is_the_one_offered() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		local missing = { mage(0, -780) }
		nav.useTravelWorld(6000) -- a long flight: the walk across town still leaves a clear saving
		local far, close = seller(220, 600), seller(170, 600)
		far.name, close.name = "Across town", "Closer"
		local sellers = { far }
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return sellers end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		local o = R.Find()
		r.acrossTown = o and o.seller.name
		sellers = { far, close }
		o = R.Find()
		r.closest = o and o.seller.name
		emit(r)"#);
	assert_eq!(out["acrossTown"], "Across town", "a seller beyond 150 yards in the same zone still counts");
	assert_eq!(out["closest"], "Closer");
}

// The planning is done on a route or bag change; the 3 s tick only measures the walk from where the player stands,
// so standing by a seller or walking up to one plans nothing (the review on #3554: 4 or 5 plans every other tick).
#[test]
fn the_tick_plans_nothing_standing_still_or_walking_up_to_a_seller() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		nav.useTravelWorld(6000)
		local missing = { mage(0, -780) }
		local sold = { seller(900, 600) }
		local got
		Polestar.Engine.SetRuneStop = function(o) got = o end
		Polestar.Engine.RuneStopAimed = function() return false end
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return sold end
		local estimates, verdicts = 0, 0
		local estimate, would = N.EstimateTravel, N.WouldCastTeleport
		N.EstimateTravel = function(...) estimates = estimates + 1; return estimate(...) end
		N.WouldCastTeleport = function(...) verdicts = verdicts + 1; return would(...) end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		R.Refresh()
		stub.advance(2)
		r.farAway = got == nil
		r.surveyed = estimates > 0
		estimates, verdicts = 0, 0
		stub.advance(30)
		r.stillPlans = estimates + verdicts
		nav.place(260, 600)
		stub.advance(3.5)
		r.walkedUp = got and got.seller.name
		r.walkedPlans = estimates
		r.askedOnce = verdicts
		estimates, verdicts = 0, 0
		nav.place(290, 600)
		stub.advance(30)
		r.closerPlans = estimates + verdicts
		emit(r)"#);
	assert_eq!(out["farAway"], true, "900 yards: past the two-minute walk");
	assert_eq!(out["surveyed"], true);
	assert_eq!(out["stillPlans"], 0, "ten ticks standing still");
	assert_eq!(out["walkedUp"], "Rune Seller", "the tick sees the seller come within reach");
	assert_eq!(out["walkedPlans"], 0, "no travel estimate on the tick");
	assert_eq!(out["askedOnce"], 1, "the planner's yes or no, once, for the seller that clears the margin");
	assert_eq!(out["closerPlans"], 0, "kept: no plan while walking on");
}

#[test]
fn no_offer_when_the_planner_would_not_cast_the_teleport_after_buying() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		local missing = { mage(0, -780) }
		local sold = { seller(20, 600) }
		local asked
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return sold end
		N.WouldCastTeleport = function(from, to, t)
			asked = from.name .. ":" .. t.spell
			return false
		end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		r.none = R.Find() == nil
		r.asked = asked
		emit(r)"#);
	assert_eq!(out["none"], true, "the line promises only a teleport the route would take");
	assert_eq!(out["asked"], "Rune Seller:3561");
}

#[test]
fn no_offer_without_a_near_seller_a_real_saving_a_missing_rune_or_a_flight() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		local missing = { mage(0, -780) }
		local sellers = { seller(20, 600) }
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return sellers end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		sellers = { seller(1000, 600) }
		r.farSeller = R.Find() == nil
		local elsewhere = seller(20, 600)
		elsewhere.map = 9001
		sellers = { elsewhere }
		r.otherZone = R.Find() == nil
		sellers = { seller(20, 600) }
		Polestar.Compat.GetUnitZone = function() return nil end
		r.noZone = R.Find() == nil
		Polestar.Compat.GetUnitZone = function() return 9000 end
		missing = { mage(0, 590) }
		r.noSaving = R.Find() == nil
		missing = {}
		r.hasRunes = R.Find() == nil
		missing = { mage(0, -780) }
		r.control = R.Find() ~= nil
		InCombatLockdown = function() return true end
		r.combat = R.Find() == nil
		InCombatLockdown = function() return false end
		nav.place(0, 0)
		target(10, 0, "Next door")
		r.noFlight = R.Find() == nil
		emit(r)"#);
	assert_eq!(out, json!({ "farSeller": true, "otherZone": true, "noZone": true, "noSaving": true, "hasRunes": true, "control": true, "combat": true, "noFlight": true }));
}

#[test]
fn missing_runes_lists_only_a_known_teleport_without_its_reagent() {
	let out = run(r#"
		local X = Polestar.Transit
		X.Register({ teleports = {
			{ spell = 3561, name = "Teleport: Stormwind", cast = 10, reagents = { RUNE, 1 }, to = { "Stormwind", 0, 10, 20, 9000, 50, 50, "e" } },
			{ spell = 3562, name = "Teleport: Ironforge", cast = 10, reagents = { RUNE, 1 }, to = { "Ironforge", 0, 30, 40, 9000, 60, 60, "e" } },
			{ spell = 18960, name = "Teleport: Moonglade", cast = 10, to = { "Moonglade", 1, 50, 60, 9001, 50, 50, "e" } },
		} })
		Polestar.Compat.IsSpellKnown = function(id) return id == 3561 or id == 18960 end
		local function names()
			local out = {}
			for _, t in ipairs(X.MissingRunes()) do out[#out + 1] = t.name .. ":" .. t.rune end
			return out
		end
		local r = {}
		r.none = names()
		nav.items[RUNE] = 1
		r.stocked = #names()
		emit(r)"#);
	assert_eq!(out["none"], json!(["Teleport: Stormwind:17031"]));
	assert_eq!(out["stocked"], 0, "a rune in the bags: nothing is missing");
}

#[test]
fn sellers_are_the_friendly_codex_vendors_of_that_item_on_the_continent() {
	let out = run(r#"
		local m, x, y = nav.mapPoint(10, 10)
		local npcs = {
			[1] = { name = "Ours", faction = "A", spawns = { { map = m, x = x, y = y } } },
			[2] = { name = "Theirs", faction = "H", spawns = { { map = m, x = x, y = y } } },
			[3] = { name = "No runes", faction = "A", spawns = { { map = m, x = x, y = y } } },
		}
		Polestar.Codex = {
			IsLoaded = function() return true end,
			WithRole = function() return { 1, 2, 3 } end,
			Npc = function(id) return npcs[id] end,
			Item = function(id) return id == RUNE and { sources = { { type = "vendor", npc = 1 }, { type = "vendor", npc = 2 } } } or nil end,
		}
		local names = {}
		for _, p in ipairs(N.nearby.Sellers(RUNE, 0)) do names[#names + 1] = p.name end
		emit({ names = names, other = #N.nearby.Sellers(RUNE, 1) })"#);
	assert_eq!(out, json!({ "names": ["Ours"], "other": 0 }));
}
