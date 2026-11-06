//! Field steps and spawn areas at the player's level (#827; Engine "Field goals" and "Spawn areas"): the
//! compiler writes the level of a kill or collect goal's spawn areas (the highest level of the mobs spawning in
//! each: the goal's `lvl` the one most share, an area of another level its own); the arrow takes the nearest place whose mobs
//! are at most one level above the player, of any open goal, and only with none the nearest of all. A `loop`
//! step's places carry no level: written order holds there. Real Core manifest, stub world. Elwynn here is
//! 30 yd per map percent across.

use forge_addontest::dsl::{compile, guide_text, plain};
use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
"#;

const HELPERS: &str = r#"
function flush() stub.advance(0.25) end
E = Polestar.Engine
w = stub.world
function at(x) w.moveTo(1429, x, 50); stub.advance(1); local wp = E.GetWaypoint(); return { wp.goalIndex, wp.x } end
"#;

fn run(guides: &str, before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, guides, HELPERS, "stub.login()", script].join("\n"),
		login: false,
		..Default::default()
	})
	.remove(0)
}

// Westfall's north loop after Sentinel Hill (player at x 40): the Goretusks (Snouts) and Harvest Watchers, level
// 14-15, are nearest; the Defias Smugglers and Trappers, 11-12, lie further out.
const WESTFALL: &str = r#"
Polestar.RegisterGuide({ id = "test/westfall", pack = "test", title = "Westfall", zone = 1429, steps = {
	{ title = "Westfall: kill these as you meet them", goals = {
		{ t = "kill", target = "Defias Smuggler", npc = 95, count = 15, quest = 12, oi = 2, map = 1429, x = 70, y = 50, spread = true, lvl = 12,
			spots = { { x = 70, y = 50, r = 40, n = 4 }, { x = 85, y = 50, r = 40, n = 3 } } },
		{ t = "kill", target = "Defias Trapper", npc = 504, count = 15, quest = 12, oi = 1, map = 1429, x = 75, y = 50, spread = true, lvl = 12,
			spots = { { x = 75, y = 50, r = 40, n = 4 } } },
		{ t = "kill", target = "Harvest Watcher", npc = 114, count = 20, quest = 9, oi = 1, map = 1429, x = 50, y = 50, spread = true, lvl = 15,
			spots = { { x = 50, y = 50, r = 40, n = 6 } } },
		{ t = "collect", item = 731, itemName = "Goretusk Snout", count = 3, quest = 38, oi = 3, map = 1429, x = 44, y = 50, spread = true, lvl = 15,
			spots = { { x = 44, y = 50, r = 40, n = 2 }, { x = 60, y = 50, r = 40, n = 2 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

const WESTFALL_QUESTS: &str = "w.onQuest(12, { 15, 15 }); w.onQuest(9, { 20 }); w.onQuest(38, { 10, 10, 3 }); w.moveTo(1429, 40, 50)";

#[test]
fn westfall_at_12_the_arrow_takes_the_defias_before_the_nearer_goretusks_at_14_or_with_the_defias_done_the_goretusks() {
	let out = run(
		WESTFALL,
		&format!("w.level = 12; {WESTFALL_QUESTS}"),
		r#"
			E.SetGuide("test/westfall"); flush()
			local r = { at12 = at(40) }
			-- walking out towards the Defias past the Watchers' field: still the Defias
			r.past = at(52)
			w.moveTo(1429, 40, 50)
			-- a level up re-picks: the Goretusks are at the player's level now
			w.setLevel(14); flush()
			r.at14 = at(40)
			emit(r)
		"#,
	);
	assert_eq!(out, json!({ "at12": [1, 70], "past": [1, 70], "at14": [4, 44] }), "the Smugglers 860 yd off, not the Snouts 80 yd off, until 14");
	let done = run(
		WESTFALL,
		&format!("w.level = 12; {WESTFALL_QUESTS}"),
		r#"
			E.SetGuide("test/westfall"); flush()
			w.progress(12, 1, 15); w.progress(12, 2, 15); flush()
			emit({ done = at(40) })
		"#,
	);
	assert_eq!(done, json!({ "done": [4, 44] }), "nothing at the player's level left: the nearest of all, as before");
}

// The Harvester Gyrostabilizer from mobs of three levels (Erá): a Reaper field (18, the goal's level) nearest
// the player, a Watcher field (15), two Golem fields (12), each of those carrying its own level; and a Smuggler
// camp far east as the step's other goal.
const GYRO: &str = r#"
Polestar.RegisterGuide({ id = "test/gyro", pack = "test", title = "Gyro", zone = 1429, steps = {
	{ title = "Westfall: kill these as you meet them", goals = {
		{ t = "collect", item = 255010, itemName = "Harvester Gyrostabilizer", count = 5, quest = 92909, oi = 2, map = 1429, x = 42, y = 50, spread = true, lvl = 18,
			spots = { { x = 42, y = 50, r = 40, n = 5 }, { x = 52, y = 50, r = 40, n = 4, lvl = 15 },
				{ x = 60, y = 50, r = 40, n = 4, lvl = 12 }, { x = 75, y = 50, r = 40, n = 3, lvl = 12 } } },
		{ t = "kill", target = "Defias Smuggler", npc = 95, count = 15, quest = 12, oi = 2, map = 1429, x = 95, y = 50, lvl = 12,
			spots = { { x = 95, y = 50, r = 40, n = 4 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

#[test]
fn gyrostabilizer_at_12_the_search_walks_the_golem_fields_never_the_reapers_while_those_exist_levels_open_the_rest() {
	let out = run(
		GYRO,
		"w.level = 12; w.onQuest(92909, { 14, 5 }); w.onQuest(12, { 15, 15 }); w.moveTo(1429, 40, 50)",
		r#"
			E.SetGuide("test/gyro"); flush()
			local r = { start = at(40) }
			r.golem = at(60)     -- searching the first Golem field
			r.left = at(66)      -- left it: the other Golem field, not the Watchers or Reapers
			r.second = at(75)
			r.back = at(50)      -- both visited: the one visited longest ago, never the Reapers beside the player
			w.setLevel(14); flush()
			r.at14 = at(48)      -- the Watchers' field opens
			w.setLevel(18); flush()
			r.at18 = at(44)      -- and at 18 the Reapers'
			emit(r)
		"#,
	);
	assert_eq!(out, json!({ "start": [1, 60], "golem": [1, 60], "left": [1, 75], "second": [1, 75], "back": [1, 60], "at14": [1, 52], "at18": [1, 42] }));
}

#[test]
fn goals_and_places_without_a_level_count_as_at_the_player_s_level_a_step_of_them_picks_the_nearest_as_before() {
	// Doom Weed (an object: no level) between a level-20 camp beside the player and a level-5 one further out.
	const MIXED: &str = r#"
Polestar.RegisterGuide({ id = "test/mixed", pack = "test", title = "Mixed", zone = 1429, steps = {
	{ goals = {
		{ t = "kill", target = "Ogre", npc = 300, count = 1, quest = 7, oi = 1, map = 1429, x = 42, y = 50, lvl = 20, spots = { { x = 42, y = 50, r = 10, n = 3 } } },
		{ t = "collect", item = 2848, itemName = "Doom Weed", quest = 9, oi = 1, count = 10, map = 1429, x = 55, y = 50, spots = { { x = 55, y = 50, r = 10, n = 4 } } },
		{ t = "kill", target = "Rot Hide Graverobber", npc = 1941, count = 8, quest = 8, oi = 1, map = 1429, x = 70, y = 50 },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;
	let mixed = run(MIXED, "w.level = 5; w.onQuest(7, { 1 }); w.onQuest(8, { 8 }); w.onQuest(9, { 10 }); w.moveTo(1429, 40, 50)", r#"E.SetGuide("test/mixed"); flush(); emit({ at = at(40) })"#);
	assert_eq!(mixed, json!({ "at": [2, 55] }), "the Doom Weed, not the level-20 Ogres beside the player");
	// No levels anywhere: the nearest, at any level.
	let plain_step = MIXED.replace(" lvl = 20,", "");
	for level in [1, 30, 60] {
		let out = run(
			&plain_step,
			&format!("w.level = {level}; w.onQuest(7, {{ 1 }}); w.onQuest(8, {{ 8 }}); w.onQuest(9, {{ 10 }}); w.moveTo(1429, 40, 50)"),
			r#"E.SetGuide("test/mixed"); flush(); emit({ at = at(40) })"#,
		);
		assert_eq!(out, json!({ "at": [1, 42] }), "level {level}");
	}
}

// Fixture data: Ancient Kobolds (level 40) at 20,20, Kobold Vermin (level 1) round 48,32.
fn compiled_guide(id: &str, step: &[&str]) -> Value {
	let mut lines = vec!["step Accept", "  accept 7"];
	lines.extend_from_slice(step);
	lines.extend_from_slice(&["step Hand in", "  turnin 7"]);
	let r = compile(&guide_text(&lines));
	assert_eq!(r.errors, Vec::<String>::new(), "{}", r.text);
	let mut g = plain(&r.guides[0]);
	g["id"] = json!(id);
	g["pack"] = json!("test");
	g
}

#[test]
fn a_loop_step_s_places_carry_no_level_its_written_order_holds_an_ordinary_step_s_carry_their_mobs_levels() {
	let field = compiled_guide("test/field", &["step Kobolds", "  kill 95007", "  kill 6 x10 quest 7.1"]);
	let looped = compiled_guide("test/loop", &["step Kobolds", "  loop", "  goto 20,20", "  goto 47.6,35.1", "  kill 95007", "  kill 6 x10 quest 7.1"]);
	// Per goal: its own level, then the distinct levels of its spawn areas (null: none).
	let levels = |g: &Value| -> Vec<(Value, Vec<Value>)> {
		g["steps"][1]["goals"]
			.as_array()
			.unwrap()
			.iter()
			.map(|goal| {
				let mut seen: Vec<Value> = Vec::new();
				for s in goal["spots"].as_array().unwrap() {
					if !seen.contains(&s["lvl"]) {
						seen.push(s["lvl"].clone());
					}
				}
				(goal["lvl"].clone(), seen)
			})
			.collect()
	};
	assert_eq!(levels(&field), vec![(json!(40), vec![Value::Null]), (json!(1), vec![Value::Null])], "the mobs' level, once per goal");
	assert_eq!(levels(&looped), vec![(Value::Null, vec![Value::Null]), (Value::Null, vec![Value::Null])], "a loop's points: none");
	// Frames left out: the stub's Elwynn places both alike.
	let register = |g: &Value| format!("local g = {}\nfor _, st in ipairs(g.steps) do for _, go in ipairs(st.goals) do go.f = nil end end\nPolestar.RegisterGuide(g)", lua_value(g));
	let arrow = |g: &Value, id: &str| {
		run(
			&register(g),
			"w.level = 1; w.onQuest(7, { 10 }); w.moveTo(1429, 21, 21)",
			&format!(r#"E.SetGuide("{id}"); flush(); emit({{ step = E.GetWaypoint().stepIndex, goal = E.GetWaypoint().goalIndex }})"#),
		)
	};
	assert_eq!(arrow(&field, "test/field"), json!({ "step": 2, "goal": 2 }), "level 1 beside the Ancient Kobolds: the Vermin");
	assert_eq!(arrow(&looped, "test/loop"), json!({ "step": 2, "goal": 1 }), "the loop's written order");
}
