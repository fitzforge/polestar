//! `when taxi "<Flight point>"` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the step
//! applies while the character knows that flight path. The parser's predicate and errors, the taxi node the
//! resolver gives it for the step's factions (as a getfp's, places.rs goal_node), the warning for a name no
//! flight point has, the emitted table and pack format 10. Taxi nodes as travel.json has them.

use crate::common;
use common::*;
use forge_guide::data::{load_data, Data};
use forge_guide::format::{format_for, needs, TAXI_FORMAT};
use serde_json::{json, Value};

/// The fixture data with a travel.json holding Ironforge, Thelsamar and both factions' Booty Bay flight masters.
fn taxi_data() -> Data {
	let dir = data_dir_with("when-taxi", &data_dir(), |raw| {
		raw.insert(
			"travel.json".into(),
			json!({ "inns": [], "taxi": { "nodes": [
				{ "id": 6, "name": "Ironforge, Dun Morogh", "short": "Ironforge", "map": 1455, "x": 55.89, "y": 47.87, "faction": 1, "npc": 1573, "npcName": "Gryth Thurden" },
				{ "id": 8, "name": "Thelsamar, Loch Modan", "short": "Thelsamar", "map": 1432, "x": 33.94, "y": 50.79, "faction": 1, "npc": 1572, "npcName": "Thorgrum Borrelson" },
				{ "id": 18, "name": "Booty Bay, Stranglethorn", "short": "Booty Bay", "map": 1434, "x": 26.82, "y": 77, "faction": 2, "npc": 2858, "npcName": "Gringer" },
				{ "id": 19, "name": "Booty Bay, Stranglethorn", "short": "Booty Bay", "map": 1434, "x": 27.53, "y": 77.67, "faction": 1, "npc": 2859, "npcName": "Gyll" },
			] } }),
		);
	});
	load_data(&dir).unwrap()
}

fn whens(r: &Compiled) -> Vec<Value> {
	r.steps().iter().map(|s| s["when"].clone()).collect()
}

#[test]
fn when_taxi_parses_a_flight_point_quoted_or_bare_with_or_without_bang() {
	let text = guide_text(&["step One", "  when taxi \"Ironforge\"", "  when !taxi Thelsamar", "  accept 783"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(
		plain(&ast.get("steps").at(0).get("when")),
		json!([
			{ "k": "taxi", "name": "Ironforge", "line": line_of(&text, "when taxi \"Ironforge\"") },
			{ "k": "taxi", "neg": true, "name": "Thelsamar", "line": line_of(&text, "when !taxi Thelsamar") },
		])
	);
}

#[test]
fn when_taxi_without_a_name_is_an_error_at_its_line() {
	for line in ["  when taxi", "  when !taxi"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: `taxi` needs a name: taxi \"<Flight point>\"", line_of(&text, line))], "{line}");
	}
}

#[test]
fn the_predicate_gets_the_taxi_node_of_the_flight_master_for_the_factions_the_step_is_for() {
	let data = taxi_data();
	let r = compile_with(&guide_text(&["step One", "  when taxi \"Ironforge\"", "  note Fly.", "step Two", "  when !taxi \"Booty Bay\"", "  note Walk."]), &data);
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	assert_eq!(whens(&r), [json!([{ "k": "taxi", "name": "Ironforge", "node": 6 }]), json!([{ "k": "taxi", "neg": true, "name": "Booty Bay", "node": 19 }])]);
	// A guide for both factions: Booty Bay names a flight master of each, so only a step for one side gets its node.
	let both = lines(&[
		"guide t/both",
		"title Both",
		"levels 1-10",
		"zone Elwynn Forest",
		"",
		"step One",
		"  when taxi \"Booty Bay\"",
		"  note Fly.",
		"step Two",
		"  only Horde",
		"  when taxi \"Booty Bay\"",
		"  note Fly.",
		"",
	]);
	let r = compile_with(&both, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(whens(&r), [json!([{ "k": "taxi", "name": "Booty Bay" }]), json!([{ "k": "taxi", "name": "Booty Bay", "node": 18 }])]);
}

#[test]
fn a_name_no_flight_point_has_warns_and_keeps_the_name_alone() {
	let text = guide_text(&["step One", "  when !taxi \"Ironforgee\"", "  accept 783"]);
	let r = compile_with(&text, &taxi_data());
	let line = line_of(&text, "when !taxi \"Ironforgee\"");
	assert_eq!(r.warned("no flight point has that name"), [format!("test.guide:{line}: taxi \"Ironforgee\": no flight point has that name, so Polestar never counts its flight path as known")]);
	assert!(r.text.contains("did you mean \"Ironforge\"?"), "{}", r.text);
	assert_eq!(whens(&r), [json!([{ "k": "taxi", "neg": true, "name": "Ironforgee" }])]);
}

#[test]
fn a_step_that_asks_for_a_flight_path_and_its_bang_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when taxi Ironforge", "  when !taxi Ironforge", "  accept 783"]);
	let r = compile_with(&text, &taxi_data());
	let want = format!("test.guide:{}: the step asks for `taxi` and `!taxi` of the same flight path: no character sees it", line_of(&text, "when taxi Ironforge"));
	assert!(r.warnings.contains(&want), "{}", r.text);
}

#[test]
fn the_emitted_predicate_carries_name_and_node_on_a_step_a_skipto_or_a_next_option_and_the_pack_is_written_in_format_10() {
	let data = taxi_data();
	let r = compile_with(&guide_text(&["step One", "  when !taxi \"Ironforge\"", "  accept 783"]), &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "taxi", neg = true, name = "Ironforge", node = 6 \} \},\n"#);
	assert_eq!(format_for(&r.guides), TAXI_FORMAT);
	assert_eq!((TAXI_FORMAT, needs(TAXI_FORMAT)), (10, Some("0.4.0")));
	let jump = compile_with(&guide_text(&["step One", "  skipto fly when taxi \"Ironforge\"", "  accept 783", "step Walk", "  turnin 783", "step Fly", "  label fly", "  note Fly."]), &data);
	assert!(jump.errors.is_empty(), "{}", jump.text);
	assert_eq!(jump.steps()[0]["skipto"], json!([{ "to": "fly", "when": { "k": "taxi", "name": "Ironforge", "node": 6 } }]));
	assert_eq!(format_for(&jump.guides), TAXI_FORMAT);
	let follower = lines(&["guide t/flyer", "title Flyer", "faction Alliance", "levels 10-20", "zone Elwynn Forest", "pitch For flyers.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Alliance", "levels 1-10", "zone Elwynn Forest", "next t/flyer when taxi \"Ironforge\"", "", "step Start", "  note Go on.", ""]);
	let n = compile_files(&[("main.guide", &main), ("flyer.guide", &follower)], &data, None);
	assert!(n.errors.is_empty(), "{}", n.text);
	assert_eq!(plain(&n.guide("t/main").get("nextWhen")), json!({ "t/flyer": [{ "k": "taxi", "name": "Ironforge", "node": 6 }] }));
	assert_eq!(format_for(&n.guides), TAXI_FORMAT);
}
