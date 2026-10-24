//! `cast <spellId>` during play (addon/Polestar/Core/Engine.lua, Own.latchCast): the player's own successful
//! cast of that spell (UNIT_SPELLCAST_SUCCEEDED) ticks the goal while it is open, in the step the guide is at
//! or an along step listed under it. A cast before that, or of another spell, or by another unit, does not
//! count. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest), as
//! tests/engine-when-dungeon.rs.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
"#;

// Step 1 waits on a task, step 2 is the campfire, step 3 hands in A Threat Within.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/cast", pack = "test", title = "Cast", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "First", goals = { { t = "task", text = "Gather wood" } } },
		{ title = "Campfire", goals = { { t = "cast", spell = 818, spellName = "Basic Campfire" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(guide: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/cast" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, guide, "E = Polestar.Engine", "function flush() stub.advance(0.25) end", "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script]
			.join("\n"),
		..Default::default()
	})
}

#[test]
fn a_cast_before_the_goal_is_open_does_not_count_once_open_only_that_spell_by_the_player_ticks_it() {
	let out = run(
		GUIDE,
		r#"
		local out = {}
		stub.world.cast(818); flush()
		out.early = { E.GetLiveStep() }
		E.ToggleGoal(1, 1); flush()
		out.open = E.GetLiveStep()
		stub.world.cast(133); flush()
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "target", "Cast-3-0-0-0-818-0", 818); flush()
		out.other = E.GetLiveStep()
		local text = E.GetStepView(2).goals[1]
		out.text = { text.verb, text.subject }
		stub.world.cast(818); flush()
		out.cast = E.GetLiveStep()
		stub.fire("PLAYER_LOGOUT")
		out.saved = PolestarCharDB.manual["test/cast"]["2:1"] or false
		emit(out)
	"#,
	);
	let rows = &out[0];
	assert_eq!(rows["early"], json!([1]), "step 1 still waits: the early cast did not tick step 2");
	assert_eq!(rows["open"], 2);
	assert_eq!(rows["other"], 2, "another spell, or another unit, does not count");
	assert_eq!(rows["text"], json!(["Cast", "Basic Campfire"]));
	assert_eq!(rows["cast"], 3);
	assert_eq!(rows["saved"], true, "the tick is kept per character");
}

#[test]
fn an_along_step_listed_under_the_live_step_is_ticked_by_the_cast_too() {
	// Step 1 (the campfire, along until step 3) is listed under step 2, where the guide is.
	let guide = r#"
Polestar.RegisterGuide({
	id = "test/cast", pack = "test", title = "Cast", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Campfire", along = "end", goals = { { t = "cast", spell = 818, spellName = "Basic Campfire" } } },
		{ title = "First", goals = { { t = "task", text = "Gather wood" } } },
		{ title = "Marshal McBride", label = "end", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;
	let out = run(guide, "local before = E.GetStepView(1).goals[1].status; stub.world.cast(818); flush(); emit({ before, after = E.GetStepView(1).goals[1].status })");
	assert_ne!(out[0]["before"], "done");
	assert_eq!(out[0]["after"], "done");
}

#[test]
fn guides_validate_takes_cast_with_a_spell_and_a_name_and_refuses_one_without() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(goal) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { goals = { goal } } } } end
			emit({ ok = V(g({ t = "cast", spell = 818, spellName = "Basic Campfire" })) or "ok", none = V(g({ t = "cast", spellName = "Basic Campfire" })) or "ok" })
		"#
		.into(),
		..Default::default()
	});
	assert_eq!(out[0]["ok"], "ok");
	assert!(is_match(text(&out[0]["none"]), "cast needs spell"));
}
