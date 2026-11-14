//! `when dungeon "<Name>"` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the step is
//! for characters who chose to run that dungeon. The parser's predicate and errors, the resolver's map id
//! from the instance tables "Group content" reads and its warnings, the emitted table and the pack format.
//! Fixture data: tests/fixtures/dsl/data, plus instance tables made here.

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

/// The fixture data with the client's instance tables and AreaTable names: Ragefire Chasm and the Deadmines
/// (Map.csv names it "Deadmines"; its area is "The Deadmines") are dungeons, Molten Core a raid. Area ids
/// 7101-7103 are made up for the test.
fn dungeon_data() -> Data {
	let instances = json!({ "areas": {
		"7101": { "kind": "dungeon", "name": "Ragefire Chasm", "map": 389 },
		"7102": { "kind": "dungeon", "name": "Deadmines", "map": 36 },
		"7103": { "kind": "raid", "name": "Molten Core", "map": 409 },
	}, "maps": {} });
	let mut a = areas(&[(7101, "Ragefire Chasm", 0), (7102, "The Deadmines", 0), (7103, "Molten Core", 0)]);
	for (id, c) in [("7101", 389), ("7102", 36), ("7103", 409)] {
		a["byId"][id]["c"] = json!(c);
		let name = a["byId"][id]["name"].as_str().unwrap().to_lowercase();
		a["byName"][&name][0]["c"] = json!(c);
	}
	let t: serde_json::Map<_, _> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	data_from(&t, instances, a)
}

#[test]
fn when_dungeon_and_when_not_dungeon_parse_with_the_name_quoted_or_bare() {
	let text = guide_text(&["step With", "  when dungeon \"Ragefire Chasm\"", "  accept 783", "step Without", "  when !dungeon The Deadmines", "  accept 7"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!(s[0]["when"], json!([{ "k": "dungeon", "name": "Ragefire Chasm", "line": line_of(&text, "when dungeon \"Ragefire Chasm\"") }]));
	assert_eq!(s[1]["when"], json!([{ "k": "dungeon", "neg": true, "name": "The Deadmines", "line": line_of(&text, "when !dungeon The Deadmines") }]));
}

#[test]
fn when_dungeon_without_a_name_is_an_error_at_its_line() {
	for line in ["  when dungeon", "  when !dungeon"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		let (ast, errors) = parse(&text);
		assert_eq!(errors, vec![format!("{}: `dungeon` needs a name: dungeon \"<Name>\"", line_of(&text, line))], "{line}");
		assert_eq!(ast.get("steps").at(0).get("goals").len(), 1);
	}
}

#[test]
fn the_resolver_gives_the_dungeon_its_map_id_by_its_map_name_or_an_area_of_that_name_on_its_map_case_aside() {
	let r = compile_with(
		&guide_text(&["step One", "  when dungeon \"Ragefire Chasm\"", "  accept 783", "step Two", "  when !dungeon \"The Deadmines\"", "  when dungeon deadmines", "  turnin 783"]),
		&dungeon_data(),
	);
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	assert_eq!(steps[0]["when"], json!([{ "k": "dungeon", "name": "Ragefire Chasm", "map": 389 }]));
	assert_eq!(steps[1]["when"], json!([{ "k": "dungeon", "neg": true, "name": "The Deadmines", "map": 36 }, { "k": "dungeon", "name": "deadmines", "map": 36 }]));
}

#[test]
fn a_name_that_is_no_dungeon_warns_and_keeps_the_name_without_the_instance_tables_nothing_warns() {
	let text = guide_text(&["step One", "  when dungeon \"Ragefire Chasmm\"", "  when !dungeon \"Molten Core\"", "  accept 783"]);
	let message =
		|name: &str| format!("dungeon \"{name}\" is not a dungeon in the client's instance tables: no character can choose it, so `when dungeon` never holds and `when !dungeon` always does");
	let r = compile_with(&text, &dungeon_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	let at = |s: &str| format!("test.guide:{}: ", line_of(&text, s));
	assert_eq!(
		r.warned("instance tables"),
		vec![format!("{}{}", at("when dungeon \"Ragefire Chasmm\""), message("Ragefire Chasmm")), format!("{}{}", at("when !dungeon \"Molten Core\""), message("Molten Core"))]
	);
	assert_eq!(r.steps()[0]["when"], json!([{ "k": "dungeon", "name": "Ragefire Chasmm" }, { "k": "dungeon", "neg": true, "name": "Molten Core" }]));
	// The fixture data has no sources folder: no instance tables, so no warning and no map id.
	let bare = compile(&guide_text(&["step One", "  when dungeon \"Ragefire Chasm\"", "  accept 783"]));
	assert!(bare.warned("dungeon").is_empty());
	assert_eq!(bare.steps()[0]["when"], json!([{ "k": "dungeon", "name": "Ragefire Chasm" }]));
}

#[test]
fn a_step_that_asks_for_a_dungeon_and_its_bang_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when dungeon \"Ragefire Chasm\"", "  when !dungeon \"Ragefire Chasm\"", "  accept 783"]);
	let r = compile_with(&text, &dungeon_data());
	assert!(
		r.warnings.contains(&format!("test.guide:{}: the step asks for `dungeon` and `!dungeon` of the same dungeon: no character sees it", line_of(&text, "when dungeon \"Ragefire Chasm\""))),
		"{}",
		r.text
	);
}

#[test]
fn the_emitted_predicate_carries_the_map_id_after_the_name_and_the_pack_is_written_in_format_5() {
	let r = compile_with(&guide_text(&["step One", "  when !dungeon \"Ragefire Chasm\"", "  accept 783"]), &dungeon_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "dungeon", neg = true, name = "Ragefire Chasm", map = 389 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}

#[test]
fn next_id_when_dungeon_resolves_the_same_way() {
	let follower = lines(&["guide t/rfc", "title RFC", "faction Horde", "levels 10-20", "zone Elwynn Forest", "pitch With Ragefire Chasm.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Horde", "levels 1-10", "zone Elwynn Forest", "next t/rfc when dungeon \"Ragefire Chasm\"", "", "step Start", "  note Go on.", ""]);
	let r = compile_files(&[("main.guide", &main), ("rfc.guide", &follower)], &dungeon_data(), None);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(plain(&r.guide("t/main").get("nextWhen")), json!({ "t/rfc": [{ "k": "dungeon", "name": "Ragefire Chasm", "map": 389 }] }));
	// On a `next` line too, `dungeon` needs format 5 (0.2.6 refuses an unknown `when` kind).
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}

/// Where the guide's kill of Kobold Vermin (6) is placed: its spawn nearest the goal before it (dsl_resolve.rs).
fn kill_at(lines: &[&str]) -> serde_json::Value {
	let r = compile(&guide_text(lines));
	assert!(r.errors.is_empty(), "{}", r.text);
	let goals: Vec<serde_json::Value> = r.steps().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect();
	let kill = goals.iter().find(|g| g["t"] == "kill").expect("a kill goal");
	json!([kill["x"], kill["y"]])
}

#[test]
fn a_dungeons_steps_leave_the_solo_routes_placing_alone_and_the_runners_steps_follow_each_other() {
	// A character who skips the dungeon never walks its steps: the solo route's kill after one is placed from the
	// solo route's own last goal, as it is without the dungeon's step.
	let solo = kill_at(&["step One", "  goto 45,34", "step Two", "  kill 6"]);
	assert_eq!(solo, json!([45.1, 33.9]));
	assert_eq!(kill_at(&["step One", "  goto 45,34", "step Run", "  when dungeon \"Ragefire Chasm\"", "  goto 52,27", "step Two", "  kill 6"]), solo);
	// A dungeon's step after another is placed from the runner's last goal.
	assert_eq!(
		kill_at(&["step One", "  goto 45,34", "step Run", "  when dungeon \"Ragefire Chasm\"", "  goto 52,27", "step Back", "  when dungeon \"Ragefire Chasm\"", "  kill 6"]),
		json!([52.3, 26.8])
	);
	// A `when !dungeon` step is the solo route's own: the steps after it are placed from it.
	assert_eq!(kill_at(&["step One", "  goto 45,34", "step Alone", "  when !dungeon \"Ragefire Chasm\"", "  goto 52,27", "step Two", "  kill 6"]), json!([52.3, 26.8]));
}

/// The fixture data with Razorfen Kraul in the instance tables (map 47) and its floor in a built Codex: 30.9,
/// where players who killed a boss there entered (`Data::dungeon_floors`, from the Codex journal's page).
fn floor_data() -> Data {
	let instances = json!({ "areas": { "7104": { "kind": "dungeon", "name": "Razorfen Kraul", "map": 47 } }, "maps": {} });
	let mut a = areas(&[(7104, "Razorfen Kraul", 0)]);
	a["byId"]["7104"]["c"] = json!(47);
	a["byName"]["razorfen kraul"][0]["c"] = json!(47);
	let t: serde_json::Map<_, _> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	let mut d = data_from(&t, instances, a);
	let journal = json!({ "dungeons": {
		"razorfen-kraul": { "key": "razorfen-kraul", "kind": "dungeon", "name": "Razorfen Kraul", "map": 47, "minLevel": 29, "maxLevel": 38, "floor": 30.9 },
		"molten-core": { "key": "molten-core", "kind": "raid", "name": "Molten Core", "map": 409, "minLevel": 60, "maxLevel": 60, "floor": 60 },
	} });
	d.dungeon_floors = forge_guide::data::dungeon_floors_of(&forge_guide::js::parse_json(&journal.to_string()).unwrap());
	d
}

/// Fitz, 2026-11-13: never send a player to a dungeon too low. A dungeon's run (its `when dungeon` step with an
/// `enter`) is gated at the dungeon's floor from the Codex: no gate, or one under the floor (Razorfen Kraul gated
/// 30 against its 30.9), is an error at the `enter`; 30.9 or more is clean. A `when !dungeon` step, a pick-up and a
/// hand-in aren't the run (a pick-up's gate is the floor less the levels the route plans before the run), and a
/// Codex built before floors gives nothing to check.
#[test]
fn a_dungeon_run_gated_under_its_codex_floor_is_an_error_at_its_enter() {
	let run = |gate: &[&str]| {
		let mut l = vec!["step Razorfen Kraul", "  when dungeon \"Razorfen Kraul\""];
		l.extend_from_slice(gate);
		l.push("  enter \"Razorfen Kraul\" @42.9,90.2");
		guide_text(&l)
	};
	let erred = |text: &str| compile_with(text, &floor_data()).erred("floor");
	let ungated = run(&[]);
	assert_eq!(
		erred(&ungated),
		vec![format!(
			"test.guide:{}: this Razorfen Kraul run applies at any level, under the dungeon's floor of 30.9 (the Codex: the Group Finder's minimum or where players who killed a boss there entered): gate it `when level>=30.9`",
			line_of(&ungated, "enter \"Razorfen Kraul\" @42.9,90.2")
		)]
	);
	assert_eq!(erred(&run(&["  when level>=30"])).len(), 1, "gated 30, under 30.9");
	assert!(erred(&run(&["  when level>=30"]))[0].contains("applies from level 30,"), "{:?}", erred(&run(&["  when level>=30"])));
	assert!(erred(&run(&["  when level>=30.9"])).is_empty(), "gated at the floor");
	assert!(erred(&run(&["  when level>30"])).is_empty(), "level>30 applies from 31");
	assert!(erred(&run(&["  when level>=31", "  when level<40"])).is_empty(), "the highest lower bound counts, an upper bound none");
	// Not runs: the solo way, a pick-up, a hand-in.
	let others = guide_text(&[
		"step Solo",
		"  when !dungeon \"Razorfen Kraul\"",
		"  enter \"Razorfen Kraul\" @42.9,90.2",
		"step Pick-up",
		"  when dungeon \"Razorfen Kraul\"",
		"  accept 783",
		"step Hand-in",
		"  when dungeon \"Razorfen Kraul\"",
		"  turnin 783",
	]);
	assert!(erred(&others).is_empty(), "{:?}", erred(&others));
	// No floor in the Codex (built before floors, or no Codex): nothing to check.
	assert!(compile_with(&ungated, &dungeon_data()).erred("floor").is_empty());
}

// `when dungeon "<Name>" all`: a step of the dungeon's every-quest route (the quests off the way), which the engine
// takes while the dungeon runs unless the player chose only the quests on the way. `!dungeon` takes no `all`.
#[test]
fn when_dungeon_all_marks_a_step_of_the_every_quest_route_and_takes_no_bang() {
	let text = guide_text(&["step Extra", "  when dungeon \"Ragefire Chasm\" all", "  accept 783", "step Bare", "  when dungeon Ragefire Chasm ALL", "  accept 7"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!(s[0]["when"], json!([{ "k": "dungeon", "all": true, "name": "Ragefire Chasm", "line": line_of(&text, "when dungeon \"Ragefire Chasm\" all") }]));
	assert_eq!(s[1]["when"][0]["name"], "Ragefire Chasm", "a bare name takes `all` too");
	assert_eq!(s[1]["when"][0]["all"], true);
	let bang = guide_text(&["step One", "  when !dungeon \"Ragefire Chasm\" all", "  accept 783"]);
	let (_, errors) = parse(&bang);
	assert_eq!(
		errors,
		vec![format!(
			"{}: `!dungeon` takes no `all`: `all` marks a step of the dungeon's every-quest route, and a player who skips the dungeon takes none of them",
			line_of(&bang, "when !dungeon \"Ragefire Chasm\" all")
		)]
	);
}

#[test]
fn the_emitted_every_quest_predicate_carries_all_after_the_map_id() {
	let r = compile_with(&guide_text(&["step One", "  when dungeon \"Ragefire Chasm\" all", "  accept 783"]), &dungeon_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.steps()[0]["when"], json!([{ "k": "dungeon", "name": "Ragefire Chasm", "map": 389, "all": true }]));
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "dungeon", name = "Ragefire Chasm", map = 389, all = true \} \},\n"#);
}

// The guide that holds a dungeon's run carries what that dungeon's every-quest steps add, from the run's record in
// data/dungeon-runs.json (`allQuests`: their minutes and XP), by the instance's map id: the guide window's "Only
// quests on my way" says what it saves. A run without `allQuests`, or another guide's, adds nothing.
#[test]
fn the_guide_holding_a_run_carries_its_every_quest_minutes_and_xp_from_the_dungeon_runs_record() {
	let mut data = dungeon_data();
	data.dungeon_runs = v(&json!({ "runs": [
		{ "dungeon": "Ragefire Chasm", "faction": "Horde", "run": { "guide": "t/main" }, "allQuests": { "minutes": 14, "xp": 23100, "quests": [5723, 5725] } },
		{ "dungeon": "The Deadmines", "faction": "Alliance", "run": { "guide": "t/main" } },
		{ "dungeon": "Ragefire Chasm", "faction": "Horde", "run": { "guide": "t/other" }, "allQuests": { "minutes": 9, "xp": 4000 } },
	] }));
	let r = compile_with(&guide_text(&["step One", "  when dungeon \"Ragefire Chasm\"", "  accept 783"]), &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(plain(&r.guides[0].get("dungeonAll")), json!({ "389": { "minutes": 14, "xp": 23100 } }));
	assert_match(&emit(&r.guides), r#"\n\t\t\tdungeonAll = \{ \[389\] = \{ minutes = 14, xp = 23100 \} \},\n"#);
	let none = compile_with(&guide_text(&["step One", "  accept 783"]), &dungeon_data());
	assert!(none.guides[0].get("dungeonAll").is_nullish(), "no record read: no dungeonAll");
}
