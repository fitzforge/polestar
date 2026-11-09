//! Format 10 in play (addon/Polestar/Core/Engine.lua, Core/Slain.lua, Core/Studio.lua): a step's stable `id`
//! carries its check-offs wherever an update moves it; a `boss` goal is done by its death in the combat log
//! while its step is in play; `mark` and `area` goals never hold a step; a `path` is walked point by point;
//! Polestar.Studio plays a draft under `studio/<slug>`. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.6) end
function reg(steps)
	assert(Polestar.RegisterGuide({ id = "test/studio", pack = "test", title = "Studio", minLevel = 1, maxLevel = 10, steps = steps }))
end
function goto(x, y, text) return { t = "goto", map = 1429, x = x, y = y, text = text } end
-- Step s's goals as status:text.
function goals(s)
	local out = {}
	for i, g in ipairs(E.GetStepView(s).goals) do out[i] = g.status .. ":" .. (g.text or "") end
	return out
end
"#;

fn run(steps: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/studio" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, HELPERS, &format!("reg({steps})"), "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); flush()"#, script].join("\n"),
		..Default::default()
	})
}

const THREE: &str = r#"{
	{ id = "aaaa", title = "A", goals = { goto(10, 10, "A") } },
	{ id = "bbbb", title = "B", goals = { goto(20, 20, "B") } },
	{ id = "cccc", title = "C", goals = { goto(30, 30, "C") } },
}"#;

#[test]
fn a_step_id_carries_its_check_off_when_an_update_moves_the_step() {
	let out = run(
		THREE,
		r#"
		E.ToggleGoal(2, 1); flush()
		emit({ before = goals(2) })
		reg({
			{ id = "xxxx", title = "New", goals = { goto(5, 5, "New") } },
			{ id = "cccc", title = "C", goals = { goto(30, 30, "C") } },
			{ id = "bbbb", title = "B", goals = { goto(20, 20, "B") } },
			{ id = "aaaa", title = "A", goals = { goto(10, 10, "A") } },
		})
		Polestar.Fire("PACKS_CHANGED", "test"); flush()
		emit({ moved = goals(3), new = goals(1), a = goals(4) })
		"#,
	);
	assert_eq!(out[0]["before"], json!(["done:Go to B"]));
	assert_eq!(out[1]["moved"], json!(["done:Go to B"]));
	assert_ne!(out[1]["new"][0], "done:Go to New");
	assert_ne!(out[1]["a"][0], "done:Go to A");
}

#[test]
fn a_step_that_kept_its_id_but_changed_its_goals_drops_their_check_offs() {
	let out = run(
		THREE,
		r#"
		E.ToggleGoal(2, 1); flush()
		reg({
			{ id = "aaaa", title = "A", goals = { goto(10, 10, "A") } },
			{ id = "bbbb", title = "B", goals = { goto(22, 22, "Elsewhere"), goto(20, 20, "B") } },
			{ id = "cccc", title = "C", goals = { goto(30, 30, "C") } },
		})
		Polestar.Fire("PACKS_CHANGED", "test"); flush()
		emit({ b = goals(2) })
		"#,
	);
	assert!(out[0]["b"].as_array().unwrap().iter().all(|g| !g.as_str().unwrap().starts_with("done:")), "{:?}", out[0]["b"]);
}

#[test]
fn a_save_from_before_the_ids_maps_by_the_steps_goals() {
	// The same guide first without ids (a save keyed by goal hashes), then with: the tick stays.
	let out = run(
		r#"{
			{ title = "A", goals = { goto(10, 10, "A") } },
			{ title = "B", goals = { goto(20, 20, "B") } },
		}"#,
		r#"
		E.ToggleGoal(2, 1); flush()
		reg({
			{ id = "aaaa", title = "A", goals = { goto(10, 10, "A") } },
			{ id = "bbbb", title = "B", goals = { goto(20, 20, "B") } },
		})
		Polestar.Fire("PACKS_CHANGED", "test"); flush()
		emit({ b = goals(2) })
		"#,
	);
	assert_eq!(out[0]["b"], json!(["done:Go to B"]));
}

const BOSS: &str = r#"{
	{ title = "Kill him", goals = { { t = "boss", npc = 639, npcName = "Edwin VanCleef" } } },
	{ title = "After", goals = { goto(30, 30, "After") } },
}"#;

#[test]
fn a_boss_goal_is_done_by_its_death_while_its_step_is_in_play() {
	let out = run(
		BOSS,
		r#"
		emit({ live = E.GetLiveStep(), goals = goals(1), watching = Polestar.Slain.Watching() })
		stub.world.combatLog("UNIT_DIED", "Creature-0-1-2-3-639-0000ABCD"); flush()
		emit({ live = E.GetLiveStep(), goals = goals(1), watching = Polestar.Slain.Watching() })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 1, "goals": ["active:Defeat Edwin VanCleef"], "watching": true }));
	// Done, latched (a reload keeps it), and the combat log is no longer read.
	assert_eq!(out[1], json!({ "live": 2, "goals": ["done:Defeat Edwin VanCleef"], "watching": false }));
}

#[test]
fn a_boss_slain_before_its_step_is_in_play_does_not_count() {
	let out = run(
		r#"{
			{ title = "First", goals = { goto(10, 10, "First") } },
			{ title = "Kill him", goals = { { t = "boss", npc = 639, npcName = "Edwin VanCleef" } } },
		}"#,
		r#"
		stub.world.combatLog("UNIT_DIED", "Creature-0-1-2-3-639-0000ABCD"); flush()
		E.ToggleGoal(1, 1); flush()
		emit({ live = E.GetLiveStep(), goals = goals(2) })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 2, "goals": ["active:Defeat Edwin VanCleef"] }));
}

#[test]
fn marks_and_areas_never_hold_a_step() {
	let out = run(
		r#"{
			{ title = "Camp", goals = {
				{ t = "mark", npc = 6, npcName = "Kobold Vermin", icon = 8, note = "Pull first" },
				{ t = "area", map = 1429, pts = { { x = 40, y = 40 }, { x = 45, y = 40 }, { x = 45, y = 45 } } },
				goto(48, 42, "Camp"),
			} },
			{ title = "After", goals = { goto(30, 30, "After") } },
		}"#,
		r#"emit({ live = E.GetLiveStep(), tickable = { E.GetStepView(1).goals[1].tickable, E.GetStepView(1).goals[2].tickable } })"#,
	);
	// The player stands at the camp: the goto is done, and the mark and area leave the step.
	assert_eq!(out[0], json!({ "live": 2, "tickable": [false, false] }));
}

#[test]
fn a_path_is_walked_point_by_point_and_done_at_its_last() {
	let out = run(
		r#"{
			{ title = "Down", goals = { { t = "path", map = 1429, pts = { { x = 20, y = 20 }, { x = 22, y = 20 }, { x = 24, y = 20 } }, text = "Down the hill" } } },
			{ title = "After", goals = { goto(30, 30, "After") } },
		}"#,
		r#"
		local w = stub.world
		w.moveTo(1429, 10, 10); flush()
		emit({ live = E.GetLiveStep(), goal = goals(1)[1] })
		w.moveTo(1429, 20, 20); flush()
		w.moveTo(1429, 22, 20); flush()
		emit({ live = E.GetLiveStep(), goal = goals(1)[1] })
		w.moveTo(1429, 24, 20); flush()
		emit({ live = E.GetLiveStep(), goal = goals(1)[1] })
		"#,
	);
	assert_eq!(out[0]["live"], 1);
	assert!(out[0]["goal"].as_str().unwrap().starts_with("active:"));
	assert_eq!(out[1]["live"], 1);
	assert_eq!(out[2]["live"], 2);
	assert!(out[2]["goal"].as_str().unwrap().starts_with("done:"));
}

const DRAFT: &str = r#"
draft = { format = 10, license = "CC-BY-4.0", guide = {
	id = "yendi/cozy-bag", title = "Cozy Bag", author = "yendi", version = 1,
	steps = {
		{ id = "k3f9ab", title = "Kill him", goals = { { t = "boss", npc = 639, npcName = "Edwin VanCleef" } } },
		{ id = "m4c5", title = "After", goals = { { t = "goto", map = 1429, x = 30, y = 30, text = "After" } } },
	},
} }
"#;

#[test]
fn studio_plays_a_draft_under_studio_slug_and_pins_its_steps() {
	let out = run(
		THREE,
		&format!(
			r#"{DRAFT}
		local S = Polestar.Studio
		local ok, problems = S.SetDraft(draft); flush()
		emit({{ ok = ok, problems = problems, guide = E.GetGuide().id, draftId = S.DraftId("yendi/cozy-bag"), live = E.GetLiveStep() }})
		emit({{ pinned = S.PinStep("yendi/cozy-bag", "m4c5"), at = E.GetStepIndex(), entry = S.Entry("studio/cozy-bag").guide.id }})
		draft.guide.steps[1].goals[1].t = "nonsense"
		local ok2, why = S.SetDraft(draft)
		emit({{ ok = ok2, still = Polestar.Guides.Get("studio/cozy-bag").steps[1].goals[1].t, why = why[1] }})
		InCombatLockdown = function() return true end
		emit({{ combat = S.SetDraft(draft) }})
		InCombatLockdown = function() return false end
		S.ClearDraft(); flush()
		emit({{ gone = Polestar.Guides.Get("studio/cozy-bag") == nil }})
		"#
		),
	);
	assert_eq!(out[0]["ok"], true);
	assert_eq!(out[0]["guide"], "studio/cozy-bag");
	assert_eq!(out[0]["draftId"], "studio/cozy-bag");
	assert_eq!(out[1], json!({ "pinned": true, "at": 2, "entry": "yendi/cozy-bag" }));
	// A draft that fails the checks is not played: the last good one stays.
	assert_eq!(out[2]["ok"], false);
	assert_eq!(out[2]["still"], "boss");
	assert!(out[2]["why"].as_str().unwrap().contains("unknown verb"), "{:?}", out[2]);
	assert_eq!(out[3]["combat"], false);
	assert_eq!(out[4]["gone"], true);
}

#[test]
fn the_studio_pack_is_never_listed_or_suggested() {
	let out = run(
		THREE,
		&format!(
			r#"{DRAFT}
		Polestar.Studio.SetDraft(draft); flush()
		local listed = false
		for _, p in ipairs(Polestar.Guides.Packs()) do if p.id == "studio" then listed = true end end
		emit({{ listed = listed, owns = Polestar.Guides.OwnsId("studio", "studio/x"), reserved = Polestar.Guides.RESERVED.studio }})
		"#
		),
	);
	assert_eq!(out[0], json!({ "listed": false, "owns": true, "reserved": true }));
}
