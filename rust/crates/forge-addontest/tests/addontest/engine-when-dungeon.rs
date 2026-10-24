//! `when dungeon` during play (addon/Polestar/Core/Engine.lua): the step applies while the character has chosen
//! to run the dungeon (CharState().dungeons[map], Engine.ChooseDungeon; Options, Discovery, Dungeons),
//! `!dungeon` while they have not. None is chosen by default. A choice re-evaluates the guide at once; a step
//! the route has passed keeps its stored outcome. Real Core manifest, stub world (a level 1 Human Warrior in
//! Elwynn Forest), as tests/engine-when.test.js.

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
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
	id = "test/dungeon", pack = "test", title = "Dungeon", minLevel = 1, maxLevel = 10,
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

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
"#;

const RFC: &str = r#"{ { k = "dungeon", name = "Ragefire Chasm", map = 389 } }"#;
const NOT_RFC: &str = r#"{ { k = "dungeon", name = "Ragefire Chasm", map = 389, neg = true } }"#;
const DEFAULT_SAVED: &str = r#"PolestarCharDB = { schema = 1, guide = "test/dungeon" }"#;

fn run(when: &str, saved: &str, login: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("@WHEN@", when);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), saved.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

fn chosen_saved() -> String {
	format!("PolestarCharDB = {}", lua_value(&json!({ "schema": 1, "guide": "test/dungeon", "dungeons": { "389": true } })))
}

#[test]
fn by_default_no_dungeon_is_chosen_a_when_dungeon_step_is_passed_a_when_dungeon_step_applies() {
	let out = run(RFC, DEFAULT_SAVED, "", "emit(state()); emit({ dungeons = PolestarCharDB.dungeons, chosen = E.DungeonChosen(389) })");
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "dungeons": {}, "chosen": false }));
	let not = run(NOT_RFC, DEFAULT_SAVED, "", "emit(state())");
	assert_eq!(not[0], json!({ "live": 2, "status": "current" }));
}

#[test]
fn choosing_the_dungeon_before_the_route_reaches_the_step_makes_it_apply_and_the_choice_is_saved_per_character() {
	let out = run(RFC, &chosen_saved(), "", r#"emit(state()); stub.fire("PLAYER_LOGOUT"); emit(PolestarCharDB.dungeons)"#);
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "389": true }));
	let not = run(NOT_RFC, &chosen_saved(), "", "emit(state())");
	assert_eq!(not[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn a_choice_re_evaluates_the_guide_at_once_choosedungeon_map_false_takes_it_back() {
	// Before the quest log is read nothing is stored, so step 2 is decided live: it applies while chosen, and
	// does not (na) once taken back.
	let out = run(RFC, DEFAULT_SAVED, "E.ChooseDungeon(389, true); stub.advance(0.25); emit(state()); E.ChooseDungeon(389, false); stub.advance(0.25); emit(state())", "");
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "na" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_choice_changes_later() {
	let out = run(
		RFC,
		DEFAULT_SAVED,
		"",
		r#"
			emit(state())
			E.ChooseDungeon(389, true); flush()
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit({ skipped = PolestarCharDB.skipped, dungeons = PolestarCharDB.dungeons })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[2], json!({ "skipped": { "test/dungeon": { "2": true } }, "dungeons": { "389": true } }));
}

#[test]
fn a_dungeon_the_compiler_found_no_map_id_for_is_never_chosen_dungeon_never_holds_dungeon_always_does() {
	let saved = format!("{}\n\t\t\tWHEN = {{ {{ k = \"level\", op = \">=\", n = 1 }} }}", chosen_saved());
	let out = run(
		"WHEN",
		&saved,
		"",
		r#"
			local G = Polestar.Guides.Get("test/dungeon")
			local out = {}
			local function check(label, pred) PolestarCharDB.when["test/dungeon"] = nil; PolestarCharDB.skipped["test/dungeon"] = nil; G.steps[2].when = { pred }; flush(); out[#out + 1] = label .. "=" .. E.GetStepView(2).status end
			check("chosen", { k = "dungeon", name = "Ragefire Chasm", map = 389 })
			check("other", { k = "dungeon", name = "The Deadmines", map = 36 })
			check("!other", { k = "dungeon", name = "The Deadmines", map = 36, neg = true })
			check("no map", { k = "dungeon", name = "Ragefire Chasmm" })
			check("!no map", { k = "dungeon", name = "Ragefire Chasmm", neg = true })
			emit(out)
		"#,
	);
	assert_eq!(out[0], json!(["chosen=current", "other=na", "!other=current", "no map=na", "!no map=current"]));
}
