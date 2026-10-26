//! `when upgrade` during play (addon/Polestar/Core/Engine.lua, Own.isUpgrade): the step applies while Polestar's
//! gear advice (Gear.IsUpgrade) rates the item an upgrade, `!upgrade` while it does not. When the advice cannot
//! judge (turned off, not loaded, the item or the weights unknown) the item counts as an upgrade. A new verdict
//! (GEAR_UPDATED) re-evaluates the guide; a step the route has passed keeps its stored outcome. Real Core
//! manifest, stub world (a level 1 Human Warrior in Elwynn Forest), as tests/engine-when-dungeon.rs; the gear
//! advice is a stub set here.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
"#;

// Step 2 is the conditional one, between taking and handing in A Threat Within: @WHEN@ is Lua for its
// predicates.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/upgrade", pack = "test", title = "Upgrade", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = @WHEN@, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

fn guide(when: &str) -> String {
	GUIDE.replace("@WHEN@", when)
}

// GEAR = { enabled, judged, up }: the stub gear advice's answers, changed by the tests; `asked` records the
// items it was asked about.
const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
GEAR = { enabled = true, judged = true, up = true }
asked = {}
function stubGear()
	Polestar.Gear = {
		IsEnabled = function() return GEAR.enabled end,
		CompareToEquipped = function(item) asked[#asked + 1] = item; if GEAR.judged then return { usable = true } end end,
		IsUpgrade = function(item) return GEAR.up, GEAR.up and 5 or -5 end,
	}
end
"#;

const UP: &str = r#"{ { k = "upgrade", item = 2488 } }"#;
const NOT_UP: &str = r#"{ { k = "upgrade", item = 2488, neg = true } }"#;

fn run(when: &str, gear: &str, login: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/upgrade" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide(when), HELPERS, gear, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn an_item_the_gear_advice_rates_an_upgrade_upgrade_applies_upgrade_is_passed() {
	let out = run(UP, "stubGear()", "", "emit(state()); emit(asked[1])");
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], "item:2488");
	assert_eq!(run(NOT_UP, "stubGear()", "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn an_item_it_rates_no_upgrade_upgrade_is_passed_upgrade_applies() {
	assert_eq!(run(UP, "stubGear(); GEAR.up = false", "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(NOT_UP, "stubGear(); GEAR.up = false", "", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
}

#[test]
fn when_the_gear_advice_cannot_judge_the_item_counts_as_an_upgrade_turned_off_not_loaded_or_the_item_unknown() {
	for gear in ["stubGear(); GEAR.enabled = false; GEAR.up = false", "", "stubGear(); GEAR.judged = false; GEAR.up = false"] {
		let what = if gear.is_empty() { "no gear module" } else { gear };
		assert_eq!(run(UP, gear, "", "emit(state())")[0], json!({ "live": 2, "status": "current" }), "{what}");
		assert_eq!(run(NOT_UP, gear, "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }), "{what}");
	}
}

#[test]
fn a_new_gear_verdict_gear_updated_re_evaluates_the_guide_at_once() {
	// Before the quest log is read nothing is stored, so step 2 is decided live: it applies while the item is an
	// upgrade, and does not (na) once the character wears something better.
	let out = run(UP, "stubGear()", r#"stub.advance(0.25); emit(state()); GEAR.up = false; Polestar.Fire("GEAR_UPDATED", "equipment"); stub.advance(0.25); emit(state())"#, "");
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "na" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_verdict_changes_later() {
	let out = run(
		UP,
		"stubGear(); GEAR.up = false",
		"",
		r#"
			emit(state())
			GEAR.up = true; Polestar.Fire("GEAR_UPDATED", "equipment"); flush()
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit(PolestarCharDB.skipped)
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[2], json!({ "test/upgrade": { "2": true } }));
}

#[test]
fn with_the_real_gear_advice_a_better_helm_is_an_upgrade_until_the_character_wears_it() {
	// tests/gear.test.js's fixture mail helms: 9001 (str5 sta3 armor150) and 9002 (str10 sta4 armor170), for a
	// level 30 Warrior wearing 9001.
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: format!("{WORLD}\nw.class, w.className, w.classID, w.level = \"WARRIOR\", \"Warrior\", 1, 30\nw.race, w.raceName, w.raceID, w.faction = \"Troll\", \"Troll\", 8, \"Horde\""),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/upgrade" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&guide(r#"{ { k = "upgrade", item = 9002 } }"#),
			HELPERS,
			r#"
Polestar.ItemDB.Register({ schema = 1, build = "test" }, {
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
})
stub.gear.equip(1, "item:9001")
stub.login()
stub.advance(0.25); emit(state())
stub.gear.equip(1, "item:9002"); stub.advance(0.25); emit(state())"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "na" }));
}
