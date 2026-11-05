//! Engine and registry fixes from the code review: no rewind when saved state is lost, positional state
//! discarded when a guide's shape changes, the waypoint preferring blocking goals and re-announcing on guide
//! switch, live-frame coordinate text, guide-level validation, and achievements earned by this character only.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
w.class, w.className, w.level = "WARRIOR", "Warrior", 8
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/ns", pack = "test", title = "Northshire", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
	{ goals = { { t = "accept", quest = 783, title = "A Threat Within" } } },
	{ goals = { { t = "talk", npc = 197, npcName = "Marshal McBride" } } },
	{ only = { classes = { "WARRIOR" } }, goals = { { t = "train", npc = 911, npcName = "Llane Beshere" } } },
	{ goals = { { t = "hearth", location = "Northshire Abbey" } } },
	{ goals = { { t = "turnin", quest = 783, title = "A Threat Within" } } },
	{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup" } } },
	{ goals = { { t = "talk", npc = 6, npcName = "Someone" } } },
} })
"#;

fn run(before: &str, guides: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\n\t\t\tE = Polestar.Engine\n\t\t\tfunction flush() stub.advance(0.25) end\n\t\t\tstub.login()\n\t\t\t{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn lost_savedvariables_or_polestar_reset_never_rewind_to_soft_steps_before_live_quest_progress() {
	let lost = run(
		"stub.world.complete({ 783 }); stub.world.onQuest(7, {})",
		GUIDE,
		Some("PolestarDB = nil; PolestarCharDB = nil"),
		r#"E.SetGuide("test/ns"); emit({ at = E.GetStepIndex(), latched = PolestarCharDB.manual["test/ns"] })"#,
	);
	assert_eq!(lost, json!({ "at": 7, "latched": { "2:1": true, "3:1": true, "4:1": true } }));

	let reset = run("stub.world.complete({ 783 }); stub.world.onQuest(7, {})", GUIDE, None, r#"E.SetGuide("test/ns"); SlashCmdList.POLESTAR("reset"); flush(); emit(E.GetStepIndex())"#);
	assert_eq!(reset, 7);

	// Without later quest progress the soft steps stay open.
	let early = run("stub.world.onQuest(783, {})", GUIDE, Some("PolestarCharDB = nil"), r#"E.SetGuide("test/ns"); emit(E.GetStepIndex())"#);
	assert_eq!(early, 2);
}

#[test]
fn a_guide_loaded_at_login_is_placed_from_the_quest_log_even_with_stored_check_offs_once_the_log_is_readable() {
	let saved = Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/ns" }, activeTab = 1, manual = { ["test/ns"] = { ["2:1"] = true } } }"#);
	let at_login = run("stub.world.complete({ 783 }); stub.world.onQuest(7, {})", GUIDE, saved, r#"emit({ at = E.GetStepIndex(), latched = PolestarCharDB.manual["test/ns"] })"#);
	assert_eq!(at_login, json!({ "at": 7, "latched": { "2:1": true, "3:1": true, "4:1": true } }));

	// The client fills the quest log after PLAYER_LOGIN: placing waits for it.
	let late = run(
		"",
		GUIDE,
		saved,
		r#"
			local first = E.GetStepIndex()
			stub.world.complete({ 783 }); stub.world.onQuest(7, {})
			stub.fire("QUEST_LOG_UPDATE"); flush()
			emit({ first = first, placed = E.GetStepIndex() })
		"#,
	);
	assert_eq!(late, json!({ "first": 1, "placed": 7 }));
}

#[test]
fn after_placement_soft_steps_hold_during_play_a_quest_taken_out_of_order_never_jumps_them() {
	let out = run(
		"stub.world.onQuest(783, {})",
		GUIDE,
		Some("PolestarCharDB = nil"),
		r#"
			E.SetGuide("test/ns")
			stub.fire("QUEST_LOG_UPDATE"); flush()
			local placed = E.GetStepIndex()
			stub.world.turnIn(783); stub.world.accept(7, {}); flush()
			emit({ placed = placed, after = E.GetStepIndex(), latched = PolestarCharDB.manual["test/ns"] or false })
		"#,
	);
	assert_eq!(out, json!({ "placed": 2, "after": 2, "latched": false }));
}

#[test]
fn class_and_race_steps_are_no_evidence_for_placement_their_chains_run_on_their_own_schedule() {
	let out = run(
		"stub.world.complete({ 50 })",
		r#"
			Polestar.RegisterGuide({ id = "test/cls", pack = "test", title = "Class", minLevel = 1, maxLevel = 10, steps = {
				{ goals = { { t = "train", npc = 911, npcName = "Llane Beshere" } } },
				{ only = { classes = { "WARRIOR" } }, goals = { { t = "accept", quest = 50, title = "Class Chain" } } },
				{ goals = { { t = "accept", quest = 51, title = "Next" } } },
			} })
		"#,
		Some("PolestarCharDB = nil"),
		r#"E.SetGuide("test/cls"); emit(E.GetStepIndex())"#,
	);
	assert_eq!(out, 1);
}

#[test]
fn check_offs_and_skips_are_discarded_when_the_guide_changes_shape_kept_otherwise() {
	let saved = |shape: &str| {
		r#"PolestarCharDB = { schema = 1, tabs = { "test/ns" }, activeTab = 1, shapes = { ["test/ns"] = $SHAPE },
		manual = { ["test/ns"] = { ["2:1"] = true } }, skipped = { ["test/ns"] = { [3] = true } } }"#
			.replace("$SHAPE", shape)
	};
	let script =
		r#"emit({ shape = PolestarCharDB.shapes["test/ns"], manual = PolestarCharDB.manual["test/ns"] or false, skipped = PolestarCharDB.skipped["test/ns"] or false, at = E.GetStepIndex() })"#;
	let before = "stub.world.onQuest(783, {})";
	let first = run(before, GUIDE, Some(&saved("nil")), script);
	assert_eq!(first["manual"], json!({ "2:1": true })); // no fingerprint yet: kept
	assert_eq!(first["at"], 4);
	let same = run(before, GUIDE, Some(&saved(&serde_json::to_string(&first["shape"]).unwrap())), script);
	assert_eq!(json!([same["manual"], same["skipped"], same["at"]]), json!([{ "2:1": true }, { "3": true }, 4]));
	let changed = run(before, GUIDE, Some(&saved(r#""7-12345""#)), script);
	assert_eq!(json!([changed["manual"], changed["skipped"], changed["at"]]), json!([false, false, 2]));
}

#[test]
fn the_waypoint_prefers_blocking_goals_over_optional_ones_and_notes() {
	let out = run(
		"",
		r#"
			Polestar.RegisterGuide({ id = "test/wp", pack = "test", title = "WP", minLevel = 1, maxLevel = 60, steps = { { goals = {
				{ t = "note", text = "Look", map = 1429, x = 10, y = 10 },
				{ t = "collect", item = 1, itemName = "Cave loot", optional = true, map = 1429, x = 20, y = 20 },
				{ t = "goto", map = 1429, x = 30, y = 30, text = "Camp" },
				{ t = "level", level = 60 },
			} } } })
		"#,
		None,
		r#"
			E.SetGuide("test/wp")
			local first = E.GetWaypoint().goalIndex
			stub.world.moveTo(1429, 30, 30); stub.advance(1)
			emit({ first, E.GetWaypoint() and E.GetWaypoint().goalIndex or false })
		"#,
	);
	assert_eq!(out, json!([3, 2]));
}

#[test]
fn switching_to_a_guide_whose_first_waypoint_sits_at_the_same_spot_still_announces_it() {
	let out = run(
		"",
		r#"
			Polestar.RegisterGuide({ id = "test/first", pack = "test", title = "First", minLevel = 1, maxLevel = 60, steps = {
				{ goals = { { t = "goto", map = 1429, x = 48, y = 42, text = "Deputy Willem" } } } } })
			Polestar.RegisterGuide({ id = "test/second", pack = "test", title = "Second", minLevel = 1, maxLevel = 60, steps = {
				{ goals = { { t = "goto", map = 1429, x = 48, y = 42, text = "Willem at the gate", r = 4 } } } } })
		"#,
		None,
		r#"
			E.SetGuide("test/first")
			local seen = {}
			Polestar.On("WAYPOINT_CHANGED", function(wp) seen[#seen + 1] = wp and (wp.label .. "/" .. wp.r) or "nil" end)
			E.SetGuide("test/second")
			emit(seen)
		"#,
	);
	assert_eq!(out, json!(["Go to Willem at the gate/4"]));
}

#[test]
fn unlabeled_era_frame_coordinates_are_shown_in_the_live_frame() {
	let out = run(
		"",
		r#"
			Polestar.RegisterMapFrames({ era = { [1429] = { c = 0, left = 1600, right = -1400, top = 600, bottom = -1400 } } }, "guides")
			Polestar.RegisterGuide({ id = "test/era", pack = "test", title = "Era", minLevel = 1, maxLevel = 60, steps = {
				{ goals = { { t = "goto", map = 1429, x = 50, y = 50, f = "e" } } } } })
		"#,
		None,
		r#"E.SetGuide("test/era"); emit({ E.GetStepView(1).goals[1].text, E.GetWaypoint().label })"#,
	);
	assert_eq!(out, json!(["Go to 46.7, 45.0", "Go to 46.7, 45.0"]));
}

#[test]
fn guide_level_races_classes_and_faction_must_be_strings_so_suggest_can_never_throw() {
	let out = run(
		"",
		"",
		None,
		r#"
			local function try(extra)
				local def = { id = "test/x", pack = "test", title = "X", steps = { { goals = { { t = "level", level = 2 } } } } }
				for k, v in pairs(extra) do def[k] = v end
				local ok, err = Polestar.RegisterGuide(def)
				return ok and "ok" or err
			end
			emit({ try({ races = { 1 } }), try({ classes = { true } }), try({ faction = true }), try({ races = { "Human" }, faction = "Alliance" }),
				Polestar.Guides.Suggest() or false })
		"#,
	);
	assert_eq!(out, json!(["bad races", "bad classes", "bad faction", "ok", "test/x"]));
}

#[test]
fn an_achievement_earned_only_by_another_character_on_the_account_is_not_done() {
	let out = run(
		r#"stub.world.addAchievement(9001, "Legacy: Northshire", { { "A", 1 } }); stub.world.achievements[9001].account = true"#,
		r#"
			Polestar.RegisterGuide({ id = "test/lg", pack = "test", title = "Legacy", category = "Legacy", minLevel = 1, maxLevel = 60, steps = {
				{ goals = { { t = "achieve", achievement = 9001, achievementName = "Legacy: Northshire" } } },
				{ goals = { { t = "level", level = 60 } } },
			} })
		"#,
		None,
		r#"
			E.SetGuide("test/lg")
			local before = { E.GetStepIndex(), Polestar.Compat.GetAchievement(9001).completed }
			stub.world.criteria(9001, 1, 1); flush()
			emit({ before = before, after = E.GetStepIndex() })
		"#,
	);
	assert_eq!(out, json!({ "before": [1, false], "after": 2 }));
}
