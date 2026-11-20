//! A `level` goal before its step's quest work gates that work; once every quest goal after it is done, the gate has
//! nothing left to hold (Engine.lua, the `level` branch of Own.goalDoneLive with Own.laterQuestDone(s, g, true)).
//! #3165 (Lenny, Troll Shaman 12, 0.4.1.1): Call of Fire (Horde) held "Reach level 13" on the Minor Manifestation of
//! Fire after the elemental (level 12) was dead and its Glowing Ember handed in. #2921 (swork1, Dwarf Warrior 31,
//! 0.4.1): Whirlwind Weapon held "Reach level 32" with The Affray already accepted. The guides below are those steps'
//! shape. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2600, right = -2000, top = 1600, bottom = -5000 })
w.titles[1526] = "Call of Fire"; w.titles[1527] = "Call of Fire"; w.titles[1718] = "The Islander"; w.titles[1719] = "The Affray"
w.race, w.faction, w.class, w.className = "Troll", "Horde", "SHAMAN", "Shaman"
w.moveTo(1413, 50, 50)
"#;

const GUIDES: &str = r#"
local B = 1413
Polestar.RegisterGuide({ id = "test/call-of-fire", pack = "test", title = "Call of Fire", faction = "Horde", minLevel = 10, maxLevel = 13, steps = {
	{ title = "The Minor Manifestation of Fire", goals = {
		{ t = "level", level = 13 },
		{ t = "collect", item = 6655, itemName = "Glowing Ember", count = 1, quest = 1526, oi = 1, map = B, x = 38.9, y = 58.3 },
	} },
	{ title = "Kranal Fiss", goals = { { t = "turnin", quest = 1527, title = "Call of Fire", map = B, x = 52.0, y = 30.0 } } },
} })
Polestar.RegisterGuide({ id = "test/whirlwind", pack = "test", title = "Whirlwind Weapon", faction = "Horde", minLevel = 30, maxLevel = 32, steps = {
	{ title = "Fray Island", goals = {
		{ t = "turnin", quest = 1718, title = "The Islander", map = B, x = 68.6, y = 49.1 },
		{ t = "level", level = 32 },
		{ t = "accept", quest = 1719, title = "The Affray", map = B, x = 68.6, y = 49.1 },
	} },
	{ title = "The Affray", goals = { { t = "kill", target = "Big Will", npc = 6238, count = 1, quest = 1719, oi = 1, map = B, x = 68.6, y = 48.7 } } },
} })
"#;

const OPEN: &str = r#"
E = Polestar.Engine
stub.login()
Polestar.Set("behavior.autoAccept", false)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
E.SetGuide("{GUIDE}"); stub.advance(0.25)
emit({ at = E.GetStepIndex() })
"#;

fn at(level: u32, log: &str, guide: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nlocal w = stub.world\nw.level = {level}\n{log}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDES}\n{}", OPEN.replace("{GUIDE}", guide)),
		..Default::default()
	})
	.remove(0)["at"]
		.clone()
}

#[test]
fn t_3165_reach_level_13_does_not_hold_once_the_ember_is_handed_in_at_12() {
	// The Ember handed in (1526 done), its follow-up finished: the gate is behind the player.
	let done = at(12, "w.complete({ 1526 })\nw.onQuest(1527, {})", "test/call-of-fire");
	assert_eq!(done, json!(2), "on to Kranal Fiss");
	// Still on Call of Fire and below 13: the gate holds the fight, as written.
	let open = at(12, "w.onQuest(1526, { { required = 1, fulfilled = 0 } })", "test/call-of-fire");
	assert_eq!(open, json!(1), "the level gate holds the elemental");
}

#[test]
fn t_2921_reach_level_32_does_not_hold_with_the_affray_already_taken_at_31() {
	let taken = at(31, "w.complete({ 1718 })\nw.onQuest(1719, { { required = 1, fulfilled = 0 } })", "test/whirlwind");
	assert_eq!(taken, json!(2), "on to the fight");
	let not_taken = at(31, "w.complete({ 1718 })", "test/whirlwind");
	assert_eq!(not_taken, json!(1), "without The Affray the gate still asks for 32");
}
