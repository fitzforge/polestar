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
	local m, x, y = nav.mapPoint(wx, wy)
	return { spell = 3561, name = "Teleport: Testshire", cast = 10, rune = RUNE,
		to = { name = "Testshire", c = 0, wx = wx, wy = wy, map = m, x = x, y = y } }
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
fn a_near_seller_is_offered_when_the_teleport_clearly_beats_the_flight_once_per_target_and_accepting_is_a_trip() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		local missing = { mage(0, -780) }
		Polestar.Transit.MissingRunes = function() return missing end
		N.nearby.Sellers = function() return { seller(20, 600) } end
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		local o = R.Find()
		r.offered = o ~= nil
		r.seller = o and o.seller.name
		r.saves = o and o.saves >= 60
		r.shown = R.Check()
		r.again = R.Find() == nil
		r.accepted = o and R.Accept(o)
		local trip = N.Trip()
		r.trip = trip and trip.name
		r.ends = trip and trip.ends
		emit(r)"#);
	assert_eq!(out["offered"], true);
	assert_eq!(out["seller"], "Rune Seller");
	assert_eq!(out["saves"], true);
	assert_eq!(out["shown"], true);
	assert_eq!(out["again"], true, "asked once for this target, whatever the answer");
	assert_eq!(out["accepted"], true);
	assert_eq!(out["trip"], "Rune Seller");
	assert_eq!(out["ends"], "arrive", "the arrow goes back to the guide at the vendor");
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
		sellers = { seller(400, 600) }
		r.farSeller = R.Find() == nil
		sellers = { seller(20, 600) }
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
	assert_eq!(out, json!({ "farSeller": true, "noSaving": true, "hasRunes": true, "control": true, "combat": true, "noFlight": true }));
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
