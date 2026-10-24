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
