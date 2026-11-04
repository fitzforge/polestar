//! Group content (docs/GUIDE_FORMAT.md, "Group content"): the compiled `group` of a goal (elite work, a
//! dungeon or raid quest, an instance map, the author's `group [N]`) and the guide's `group` flag.

use crate::common;
use common::*;
use forge_guide::js::V;
use serde_json::{json, Value};

fn guide(body: &[&str]) -> String {
	let mut l = vec!["guide t/group", "title Group", "faction Alliance", "category Class", "levels 1-60", "zone Elwynn Forest", ""];
	l.extend_from_slice(body);
	format!("{}\n", l.join("\n"))
}

/// The compiled guide and the `group` of its first step's goals (null: none).
fn groups(src: &str) -> (V, Vec<Value>) {
	let r = compile_with(src, &group_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	let goals = r.steps()[0]["goals"].as_array().unwrap().iter().map(|g| g.get("group").cloned().unwrap_or(Value::Null)).collect();
	(r.guides[0].clone(), goals)
}

#[test]
fn a_kill_of_a_hostile_elite_is_elite_group_content_with_its_rank_a_friendly_talk_credit_and_a_normal_mob_are_not() {
	assert_eq!(groups(&guide(&["step S", "  kill 95003", "  kill 95030", "  kill 6"])).1, [json!({ "kind": "elite", "rank": 1 }), Value::Null, Value::Null]);
}

#[test]
fn a_collect_is_elite_group_content_only_when_every_dropper_is_an_elite() {
	assert_eq!(groups(&guide(&["step S", "  collect 95100 x3", "  collect 95101 x3"])).1, [json!({ "kind": "elite", "rank": 1 }), Value::Null]);
}

#[test]
fn every_goal_of_a_dungeon_quest_names_the_dungeon_a_raid_quest_the_raid_a_breadcrumb_with_the_area_is_not_one() {
	let (_, goals) = groups(&guide(&["step S", "  accept 9600", "  kill 95040 quest 9600", "  complete 9600", "  turnin 9600", "  accept 9601", "  turnin 9601", "  accept 9602", "  turnin 9602"]));
	let d = json!({ "kind": "dungeon", "name": "Hollow Deeps" });
	let r = json!({ "kind": "raid", "name": "Molten Core" });
	assert_eq!(goals, [d.clone(), d.clone(), d.clone(), d, r.clone(), r, Value::Null, Value::Null]);
}

#[test]
fn a_goal_placed_on_an_instance_map_is_in_that_instance() {
	assert_eq!(groups(&guide(&["step S", "  goto 50,50 map 9900 \"Hollow gate\"", "  goto 50,50 \"Outside\""])).1, [json!({ "kind": "dungeon", "name": "Hollow Deeps" }), Value::Null]);
}

#[test]
fn group_n_is_the_authors_word_it_wins_over_what_the_data_says_with_or_without_a_size() {
	let (_, goals) = groups(&guide(&["step S", "  kill 95003 group 3", "  accept 9600 group 5", "  talk 197 group", "  kill 6 optional group 2"]));
	assert_eq!(goals, [json!({ "kind": "group", "size": 3 }), json!({ "kind": "group", "size": 5 }), json!({ "kind": "group" }), json!({ "kind": "group", "size": 2 })]);
}

#[test]
fn a_malformed_group_size_is_an_error_on_its_line() {
	// Each step keeps a valid goal, so the bad line is the only error.
	let step = |line: &str| guide(&["step S", "  kill 6", line]);
	for size in ["0", "1", "41", "2.5", "-3"] {
		let line = format!("  kill 6 group {size}");
		let src = step(&line);
		assert_eq!(compile_with(&src, &group_data()).errors, vec![format!("test.guide:{}: malformed group size \"{size}\" (2 to 40 players)", line_of(&src, &line))]);
	}
	let twice = step("  kill 95003 group group");
	assert_eq!(compile_with(&twice, &group_data()).errors, vec![format!("test.guide:{}: duplicate `group [N]`", line_of(&twice, "  kill 95003 group group"))]);
	let note = step("  note \"Wait here\" group 3");
	assert_eq!(compile_with(&note, &group_data()).errors, vec![format!("test.guide:{}: `group [N]` does not apply to `note`", line_of(&note, "  note \"Wait here\" group 3"))]);
}

#[test]
fn the_guide_is_flagged_group_when_a_goal_of_its_route_needs_a_group_not_for_an_optional_extra() {
	assert_eq!(groups(&guide(&["step S", "  kill 6", "  kill 95003"])).0.get("group"), V::Bool(true));
	assert!(groups(&guide(&["step S", "  kill 6", "  kill 95003 optional"])).0.get("group").is_undef());
	assert!(groups(&guide(&["step S", "  kill 6"])).0.get("group").is_undef());
}

#[test]
fn the_compiled_group_reaches_the_pack_goal_and_guide_keys_in_guides_lua() {
	let r = compile_with(&guide(&["step S", "  accept 9600", "  kill 95003 group 3"]), &group_data());
	let lua = emit_sourced(&r.guides);
	assert_match(&lua, r"\t\t\tgroup = true,\n\t\t\tsteps = \{");
	assert_match(&lua, r#"t = "accept", quest = 9600, [^\n]*group = \{ kind = "dungeon", name = "Hollow Deeps" \} \},"#);
	assert_match(&lua, r#"t = "kill", [^\n]*group = \{ kind = "group", size = 3 \} \},"#);
}

#[test]
fn load_data_reads_the_instances_from_the_client_tables_in_the_sources_folder_beside_the_data_folder() {
	let root = scratch("dsl-group-instances");
	let data_dir = root.join("forever");
	std::fs::create_dir_all(&data_dir).unwrap();
	for e in std::fs::read_dir(common::data_dir()).unwrap().flatten() {
		std::fs::copy(e.path(), data_dir.join(e.file_name())).unwrap();
	}
	assert!(forge_guide::data::load_data(&data_dir).unwrap().instances.is_nullish(), "no cached client tables: no instances");
	write_tree(
		&root.join("sources/wago/1.60.1.1"),
		&[
			("Map.csv", "ID,MapName_lang,InstanceType,AreaTableID\n0,Eastern Kingdoms,0,0\n429,\"Dire Maul\",1,2557\n409,\"Molten Core\",2,2717\n"),
			("AreaTable.csv", "ID,AreaName_lang,ContinentID,ParentAreaID\n2557,\"Dire Maul\",429,0\n2717,\"Molten Core\",409,0\n3000,\"Gordok Commons\",429,2557\n"),
			("UiMapAssignment.csv", "UiMapID,MapID\n235,429\n236,429\n1429,0\n"),
		],
	);
	assert_eq!(
		plain(&forge_guide::data::load_data(&data_dir).unwrap().instances),
		json!({
			"build": "1.60.1.1",
			"areas": { "2557": { "kind": "dungeon", "name": "Dire Maul", "map": 429 }, "2717": { "kind": "raid", "name": "Molten Core", "map": 409 }, "3000": { "kind": "dungeon", "name": "Dire Maul", "map": 429 } },
			"maps": { "235": { "kind": "dungeon", "name": "Dire Maul", "map": 429 }, "236": { "kind": "dungeon", "name": "Dire Maul", "map": 429 } },
		})
	);
}
