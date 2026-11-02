//! Conditions checked during play (`when` on a step, addon/Polestar/Core/Engine.lua): a step applies only while
//! its predicates hold, checked on the live state until the route moves past the step; from then on the outcome
//! is stored (CharState().when), so a passed step never comes back when the condition changes, and a reload
//! keeps it. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// Step 2 is the conditional one: a trainer visit between taking and handing in A Threat Within. `when` is Lua
// for step 2's predicates.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/when", pack = "test", title = "When", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = ${when}, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

fn guide(when: &str) -> String {
	GUIDE.replace("${when}", when)
}

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The live step and step 2's status.
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
"#;

const DEFAULT_SAVED: &str = r#"PolestarCharDB = { schema = 1, guide = "test/when" }"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

// `login` runs right after PLAYER_LOGIN; the quest log is read (QUEST_LOG_UPDATE) after it.
fn run(when: &str, before: &str, saved: Option<&str>, login: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![core()],
		saved: vec![("Polestar".into(), saved.unwrap_or(DEFAULT_SAVED).into())],
		script: [TEST_PACK, TEST_SOURCE, &guide(when), HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

// The player has taken A Threat Within: step 2 or 3 is the live step.
const TAKEN: &str = "w.onQuest(783, {})";

const WHEN_BEFORE: &str = r#"
			WHEN = { { k = "level", op = ">=", n = 1 } }"#;

#[test]
fn a_step_applies_while_its_when_holds_and_is_passed_stored_as_skipped_once_it_does_not() {
	let out = run(
		r#"{ { k = "level", op = "<", n = 3 } }"#,
		TAKEN,
		None,
		"",
		r#"
			emit(state())
			stub.world.setLevel(3); flush()
			emit(state())
		"#,
	);
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn once_the_route_has_moved_past_a_step_its_outcome_is_stored_a_failed_when_never_brings_the_step_back_and_a_reload_keeps_it() {
	let out = run(
		r#"{ { k = "has", item = 159, n = 1, neg = true } }"#,
		&format!("{TAKEN}; w.addItem(159, 1)"),
		None,
		"",
		r#"
			emit(state())
			stub.world.addItem(159, -1); flush()
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit({ skipped = PolestarCharDB.skipped, when = PolestarCharDB.when })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	// Without the stored outcome the water used up would pull the guide back to step 2.
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[2], json!({ "skipped": { "test/when": { "2": true } }, "when": {} }));

	let saved = format!("PolestarCharDB = {}", lua_value(&json!({ "schema": 1, "guide": "test/when", "skipped": { "test/when": { "2": true } } })));
	let reloaded = run(r#"{ { k = "has", item = 159, n = 1, neg = true } }"#, TAKEN, Some(&saved), "", "emit(state())");
	assert_eq!(reloaded[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn nothing_is_stored_before_the_quest_log_can_be_read_a_step_whose_when_reads_the_log_is_decided_once_it_can() {
	// Step 1's accept checked off by hand (which never stands for the quest log, #739); 783 shows in the log
	// only with QUEST_LOG_UPDATE.
	let saved = format!("PolestarCharDB = {}", lua_value(&json!({ "schema": 1, "guide": "test/when", "manual": { "test/when": { "1:1": true } } })));
	let out = run(
		r#"{ { k = "onquest", q = { 783 } } }"#,
		"",
		Some(&saved),
		"stub.advance(0.25); emit(state()); stub.world.onQuest(783, {})",
		r#"
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit({ skipped = PolestarCharDB.skipped, when = PolestarCharDB.when })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 1, "status": "na" }), "the tick alone keeps the guide at Willem");
	assert_eq!(out[1], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[2], json!({ "skipped": {}, "when": {} }));
}

#[test]
fn a_step_stored_off_can_be_unskipped_and_then_applies_whatever_its_when() {
	let out = run(
		r#"{ { k = "level", op = "<", n = 3 } }"#,
		&format!("{TAKEN}; w.setLevel(3)"),
		None,
		"",
		r#"
			emit(state())
			E.Unskip(2); flush()
			emit(state())
			emit(PolestarCharDB.when)
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[2], json!({ "test/when": { "2": true } }));
}

#[test]
fn a_step_that_applied_stays_applied_once_passed_and_resetprogress_forgets_the_stored_outcomes() {
	let out = run(
		r#"{ { k = "level", op = "<", n = 3 } }"#,
		TAKEN,
		None,
		"",
		r#"
			stub.world.trainer(911); stub.world.learnSpell(100); flush(); stub.world.close(); flush()
			local a = state()
			stub.world.setLevel(5); flush()
			local b = state()
			E.ResetProgress(); flush()
			emit(a); emit(b); emit(state())
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "done" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "done" }));
	// Reset, the route is placed again: at level 5 the step no longer applies.
	assert_eq!(out[2], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn quest_predicates_onquest_any_of_complete_turnedin_and_their_negations() {
	let out = run(
		"WHEN",
		&format!("{TAKEN}{WHEN_BEFORE}"),
		None,
		"",
		r#"
			local G = Polestar.Guides.Get("test/when")
			local w = stub.world
			local out = {}
			local function check(label, preds) PolestarCharDB.when["test/when"] = nil; G.steps[2].when = preds; flush(); out[#out + 1] = label .. "=" .. E.GetStepView(2).status end
			check("onquest 7,783", { { k = "onquest", q = { 7, 783 } } })
			check("onquest 7", { { k = "onquest", q = { 7 } } })
			check("!onquest 7", { { k = "onquest", q = { 7 }, neg = true } })
			check("complete 783", { { k = "complete", q = 783 } })
			check("!complete 783", { { k = "complete", q = 783, neg = true } })
			check("turnedin 776", { { k = "turnedin", q = 776 } })
			w.complete({ 776 })
			check("turnedin 776 done", { { k = "turnedin", q = 776 } })
			check("!turnedin 776 done", { { k = "turnedin", q = 776, neg = true } })
			emit(out)
		"#,
	);
	assert_eq!(
		out[0],
		json!(["onquest 7,783=current", "onquest 7=na", "!onquest 7=current", "complete 783=current", "!complete 783=na", "turnedin 776=na", "turnedin 776 done=current", "!turnedin 776 done=na"])
	);
}

#[test]
fn available_not_taken_or_done_the_level_reached_prerequisites_done_and_nothing_that_closes_it_taken() {
	let out = run(
		"WHEN",
		&format!("{TAKEN}{WHEN_BEFORE}"),
		None,
		"",
		r#"
			local G = Polestar.Guides.Get("test/when")
			local w = stub.world
			local out = {}
			local function check(label, pred) pred.k = "available"; PolestarCharDB.when["test/when"] = nil; G.steps[2].when = { pred }; flush(); out[#out + 1] = label .. "=" .. E.GetStepView(2).status end
			check("free", { q = 60 })
			check("in log", { q = 783 })
			check("level 4", { q = 60, minLevel = 4 })
			check("pre 33", { q = 60, pre = { 33 } })
			check("preAll 33,34", { q = 60, preAll = { 33, 34 } })
			w.complete({ 33 })
			check("pre 33 done", { q = 60, pre = { 33 } })
			check("preAll 33,34 one done", { q = 60, preAll = { 33, 34 } })
			check("closedBy 783", { q = 60, closedBy = { 783 } })
			check("!available free", { q = 60, neg = true })
			emit(out)
		"#,
	);
	assert_eq!(out[0], json!(["free=current", "in log=na", "level 4=na", "pre 33=na", "preAll 33,34=na", "pre 33 done=current", "preAll 33,34 one done=na", "closedBy 783=na", "!available free=na"]));
}

#[test]
fn zone_subzone_and_bound_read_the_area_name_in_the_client_s_language_else_the_name_the_guide_wrote() {
	let before = TAKEN.to_string()
		+ WHEN_BEFORE
		+ r#"
			C_Map.GetAreaInfo = function(id) return ({ [12] = "Forêt d'Elwynn", [87] = "Comté-de-l'Or" })[id] end
			w.setZone("Forêt d'Elwynn", "Comté-de-l'Or"); w.bind("Comté-de-l'Or")"#;
	let out = run(
		"WHEN",
		&before,
		None,
		"",
		r#"
			local G = Polestar.Guides.Get("test/when")
			local out = {}
			local function check(label, pred) PolestarCharDB.when["test/when"] = nil; G.steps[2].when = { pred }; flush(); out[#out + 1] = label .. "=" .. E.GetStepView(2).status end
			check("zone area", { k = "zone", name = "Elwynn Forest", area = 12 })
			check("zone name", { k = "zone", name = "Forêt d'Elwynn" })
			check("zone other", { k = "zone", name = "Westfall" })
			check("!zone other", { k = "zone", name = "Westfall", neg = true })
			check("subzone area", { k = "subzone", name = "Goldshire", area = 87 })
			check("subzone is not the zone", { k = "subzone", name = "Elwynn Forest", area = 12 })
			check("bound area", { k = "bound", name = "Goldshire", area = 87 })
			check("!bound area", { k = "bound", name = "Goldshire", area = 87, neg = true })
			emit(out)
		"#,
	);
	assert_eq!(
		out[0],
		json!(["zone area=current", "zone name=current", "zone other=na", "!zone other=current", "subzone area=current", "subzone is not the zone=na", "bound area=current", "!bound area=na"])
	);
}

#[test]
fn a_turn_in_whose_only_accept_sits_in_a_step_passed_by_its_when_goes_with_it() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/side" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			r#"Polestar.RegisterGuide({
	id = "test/side", pack = "test", title = "Side", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Side quest", when = { { k = "level", op = ">=", n = 5 } }, goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})"#,
			HELPERS,
			r#"stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local v = E.GetStepView(2)
emit({ live = E.GetLiveStep(), turnin = v.goals[2].status })
"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 2, "turnin": "na" }));
}

#[test]
fn a_guide_with_a_malformed_when_is_refused() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		script: r#"
local V = Polestar.Guides.Validate
local function step(when) return { id = "test/x", title = "X", steps = { { when = when, goals = { { t = "level", level = 2 } } } } } end
emit({
	ok = V(step({ { k = "level", op = "<", n = 3 }, { k = "onquest", q = { 7 } }, { k = "has", item = 159 }, { k = "zone", name = "Elwynn Forest" }, { k = "dungeon", name = "Ragefire Chasm", map = 389 }, { k = "dungeon", name = "Ragefire Chasmm" } })) or false,
	empty = V(step({})),
	op = V(step({ { k = "level", op = "=", n = 3 } })),
	kind = V(step({ { k = "weather", n = 3 } })),
	money = V(step({ { k = "money", n = 3 } })),
	quests = V(step({ { k = "onquest", q = 7 } })),
	place = V(step({ { k = "bound" } })),
	dungeon = V(step({ { k = "dungeon", map = 389 } })),
	dungeonMap = V(step({ { k = "dungeon", name = "Ragefire Chasm", map = "389" } })),
})
"#
		.into(),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!({
			"ok": false,
			"empty": "step 1: bad when",
			"op": "step 1: bad when",
			"kind": "step 1: bad when",
			"money": "step 1: bad when",
			"quests": "step 1: bad when",
			"place": "step 1: bad when",
			"dungeon": "step 1: bad when",
			"dungeonMap": "step 1: bad when",
		})
	);
}
