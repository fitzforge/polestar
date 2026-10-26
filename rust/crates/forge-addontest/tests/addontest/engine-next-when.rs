//! Conditional hand-offs (`next <id> when ...`, a guide's `nextWhen`; Engine "Route choice"): an option whose
//! `when` does not hold is hidden wherever the options are listed (routeOptions, ChooseRoute,
//! Engine.RouteOffered, Guides.OfferedBy), checked on the character as they are then. One option left: Polestar
//! continues to it without asking; none: the guide ends there. The chain of guides ahead (prerequisites kept by
//! "Skip grey quests") leaves out an option that can no longer hold. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
w.addMap(1421, { name = "Silverpine Forest", c = 0, left = 3000, right = 0, top = 0, bottom = -3000 })
w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
w.moveTo(1411, 52, 43)
"#;

// Durotar goes on to the Barrens or Silverpine; @NEXTWHEN@ is Lua for its conditions.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/durotar", pack = "test", title = "Durotar", faction = "Horde", minLevel = 1, maxLevel = 10,
	next = "test/barrens", nextChoices = { "test/barrens", "test/silverpine" }, nextWhen = @NEXTWHEN@, steps = {
	{ goals = { { t = "accept", quest = 1, title = "Your Place In The World", map = 1411, x = 42, y = 68 } } },
	{ goals = { { t = "turnin", quest = 1, title = "Your Place In The World", map = 1411, x = 52, y = 43 } } },
} })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413,
	pitch = "Dense quests around a central hub.", steps = {
	{ goals = { { t = "goto", map = 1413, x = 52, y = 30 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/silverpine", pack = "test", title = "Silverpine Forest", faction = "Horde", minLevel = 10, maxLevel = 18, zone = 1421,
	pitch = "A quiet zone next to Undercity.", steps = {
	{ goals = { { t = "goto", map = 1421, x = 43, y = 41 } } },
	{ goals = { { t = "level", level = 18 } } },
} })
"#;

const HELPERS: &str = r#"
E, G = Polestar.Engine, Polestar.Guides
w = stub.world
function flush() stub.advance(0.25) end
LOG = {}
for _, m in ipairs({ "ROUTE_CHOICE", "GUIDE_CHANGED" }) do
	Polestar.On(m, function(a) LOG[#LOG + 1] = m .. " " .. tostring(a) end)
end
function takeLog() local l = LOG; LOG = {}; return l end
function finish()
	w.accept(1, {}); flush()
	w.finish(1); w.turnIn(1); flush()
end
function ids(list, key)
	local out = {}
	for i, x in ipairs(list or {}) do out[i] = key and x[key] or x.id end
	return out
end
-- What every place that lists Durotar's options sees now.
function offers()
	local c = E.GetRouteChoice("test/durotar")
	return {
		choice = c and ids(c.options) or false,
		barrens = E.RouteOffered("test/durotar", "test/barrens"),
		silverpine = E.RouteOffered("test/durotar", "test/silverpine"),
		offeredBy = { barrens = ids(G.OfferedBy("test/barrens")), silverpine = ids(G.OfferedBy("test/silverpine")) },
		next = E.NextGuide("test/durotar") or false,
	}
end
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(next_when: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		script: [TEST_PACK, TEST_SOURCE, &GUIDES.replace("@NEXTWHEN@", next_when), HELPERS, "stub.login()", script].join("\n"),
		..Default::default()
	})
}

const BARRENS_FROM_5: &str = r#"{ ["test/barrens"] = { { k = "level", op = ">=", n = 5 } } }"#;

#[test]
fn an_option_whose_when_does_not_hold_is_hidden_everywhere_the_one_left_is_taken_without_asking() {
	let out = run(
		BARRENS_FROM_5,
		r#"
			E.SetGuide("test/durotar"); flush(); takeLog()
			emit(offers())
			emit(E.ChooseRoute("test/durotar", "test/barrens"))
			finish()
			emit({ log = takeLog(), guide = E.GetGuide().id })"#,
	);
	assert_eq!(
		out[0],
		json!({
			"choice": ["test/silverpine"],
			"barrens": false,
			"silverpine": true,
			"offeredBy": { "barrens": {}, "silverpine": ["test/durotar"] },
			"next": "test/silverpine",
		})
	);
	// A hidden option cannot be chosen.
	assert_eq!(out[1], false);
	// No "Choose your path": Polestar goes on to the one option offered.
	assert_eq!(out[2], json!({ "log": ["GUIDE_CHANGED test/silverpine"], "guide": "test/silverpine" }));
}

#[test]
fn once_the_when_holds_the_option_is_offered_again_and_the_player_chooses() {
	let out = run(
		BARRENS_FROM_5,
		r#"
			E.SetGuide("test/durotar"); flush()
			w.setLevel(5); flush(); takeLog()
			emit(offers())
			finish()
			local r = { log = takeLog(), guide = E.GetGuide().id, pending = E.PendingRouteChoice() }
			r.chose = E.ChooseRoute("test/durotar", "test/barrens"); flush()
			r.now = E.GetGuide().id
			emit(r)"#,
	);
	assert_eq!(
		out[0],
		json!({
			"choice": ["test/barrens", "test/silverpine"],
			"barrens": true,
			"silverpine": true,
			"offeredBy": { "barrens": ["test/durotar"], "silverpine": ["test/durotar"] },
			"next": false,
		})
	);
	assert_eq!(out[1], json!({ "log": ["ROUTE_CHOICE test/durotar"], "guide": "test/durotar", "pending": "test/durotar", "chose": true, "now": "test/barrens" }));
}

#[test]
fn with_no_option_offered_the_guide_ends_without_a_hand_off_until_one_holds() {
	let out = run(
		r#"{ ["test/barrens"] = { { k = "level", op = ">=", n = 5 } }, ["test/silverpine"] = { { k = "has", item = 159, n = 1 } } }"#,
		r#"
			E.SetGuide("test/durotar"); flush(); takeLog()
			finish()
			local r = offers()
			r.log, r.guide, r.pending = takeLog(), E.GetGuide().id, E.PendingRouteChoice() or false
			emit(r)
			w.addItem(159, 1); flush()
			emit(offers())"#,
	);
	assert_eq!(
		out[0],
		json!({
			"choice": false,
			"barrens": false,
			"silverpine": false,
			"offeredBy": { "barrens": {}, "silverpine": {} },
			"next": false,
			"log": {},
			"guide": "test/durotar",
			"pending": false,
		})
	);
	assert_eq!(out[1]["choice"], json!(["test/silverpine"]));
	assert_eq!(out[1]["next"], "test/silverpine");
}

#[test]
fn changing_route_offers_the_choice_only_while_it_has_two_options_for_the_character() {
	let out = run(
		BARRENS_FROM_5,
		r#"
			E.SetGuide("test/silverpine"); flush()
			emit(E.RouteChoiceFor("test/silverpine") or false)
			w.setLevel(5); flush()
			emit(E.RouteChoiceFor("test/silverpine") or false)"#,
	);
	assert_eq!(out[0], false);
	assert_eq!(out[1], "test/durotar");
}

#[test]
fn a_guide_whose_nextwhen_is_malformed_or_names_a_guide_it_does_not_offer_is_refused() {
	for bad in [r#"{ ["test/barrens"] = {} }"#, r#"{ ["test/stonetalon"] = { { k = "level", op = "<", n = 5 } } }"#, r#"{ ["test/barrens"] = { { k = "level", op = "=", n = 5 } } }"#, r#""level<5""#] {
		let out = run(bad, r#"emit(G.Get("test/durotar") ~= nil)"#);
		assert_eq!(out[0], false, "{bad}");
	}
}

// "Skip grey quests" keeps a grey quest a guide down the chain needs. An option that can no longer be offered
// (a `level<N` the character is past) is no longer down the chain; one that may still hold stays, and the
// chain is looked at again once it is past.
#[test]
fn the_chain_ahead_leaves_out_an_option_that_can_no_longer_be_offered() {
	let chain_guides = |when: &str| {
		r#"
		Polestar.RegisterGuide({ id = "test/g1", pack = "test", title = "G1", faction = "Horde", minLevel = 1, maxLevel = 30,
			next = "test/g2", nextChoices = { "test/g2" }, nextWhen = { ["test/g2"] = { @WHEN@ } }, steps = {
			{ goals = { { t = "accept", quest = 103, title = "Grey prerequisite", qlvl = 4 } } },
			{ goals = { { t = "accept", quest = 104, title = "Current", qlvl = 19 } } },
		} })
		Polestar.RegisterGuide({ id = "test/g2", pack = "test", title = "G2", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
			{ goals = { { t = "accept", quest = 105, title = "Follow-up", qlvl = 20, pre = { 103 } } } },
		} })"#
			.replace("@WHEN@", when)
	};
	let play = |when: &str, script: &str| {
		json!(emitted(&RunAddon {
			stubs: vec!["stub_world.lua"],
			before: format!("{WORLD}\nw.level = 20"),
			addons: vec![core()],
			saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true } } }".into())],
			script: [TEST_PACK, TEST_SOURCE, &chain_guides(when), HELPERS, "stub.login()", r#"E.SetGuide("test/g1"); flush()"#, script].join("\n"),
			..Default::default()
		}))
	};
	let grey = "local function grey() return E.GetStepView(1).goals[1].status end";
	// Past `level<20`: G2 is never offered, so its prerequisite is grey and skipped.
	assert_eq!(play(r#"{ k = "level", op = "<", n = 20 }"#, &format!("{grey}\nemit(grey())")), json!(["na"]));
	// `level>=25` may hold by the hand-off: the prerequisite stays.
	assert_eq!(play(r#"{ k = "level", op = ">=", n = 25 }"#, &format!("{grey}\nemit(grey())")), json!(["active"]));
	// `level<21` holds at 20; at 21 it never will again.
	assert_eq!(play(r#"{ k = "level", op = "<", n = 21 }"#, &format!("{grey}\nemit(grey())\nw.setLevel(21); flush()\nemit(grey())")), json!(["active", "na"]));
}
