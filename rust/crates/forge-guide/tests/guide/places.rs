//! The location of sethome, hearth, fly and getfp is checked against the inns and flight points of
//! travel.json and the zones of zones.json, matched as the addon matches it. (`find --kind inn|flight`,
//! which lists those places, is tested with find.)

use crate::common;
use common::*;
use forge_guide::data::Data;
use serde_json::{json, Value};

fn inns() -> Value {
	json!([
		{ "location": "Goldshire", "names": ["Goldshire"], "npc": 295, "npcName": "Innkeeper Farley", "map": 1429, "x": 43.77, "y": 65.8 },
		{ "location": "Thunderbrew Distillery", "names": ["Thunderbrew Distillery", "Kharanos"], "npc": 1247, "npcName": "Innkeeper Belm", "map": 1426, "x": 47.38, "y": 52.52 },
		{ "location": "Grom'gol Base Camp", "names": ["Grom'gol Base Camp"], "npc": 5814, "npcName": "Innkeeper Thulbek", "map": 1434, "x": 31.5, "y": 29.8 },
	])
}

fn nodes() -> Value {
	json!([
		{ "id": 2, "name": "Stormwind, Elwynn", "short": "Stormwind", "map": 1453, "x": 66.3, "y": 62.67, "faction": 1, "npc": 352, "npcName": "Dungar Longdrink" },
		{ "id": 20, "name": "Grom'gol, Stranglethorn", "short": "Grom'gol", "map": 1434, "x": 32.54, "y": 29.36, "faction": 2, "npc": 1387, "npcName": "Thysta" },
	])
}

/// The test data with a travel.json holding `travel`.
fn data_with(name: &str, travel: Value) -> Data {
	let dir = scratch(&format!("places-{name}"));
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		std::fs::copy(e.path(), dir.join(e.file_name())).unwrap();
	}
	std::fs::write(dir.join("travel.json"), format!("{travel}\n")).unwrap();
	forge_guide::data::load_data(&dir).unwrap()
}

fn full() -> Data {
	data_with("full", json!({ "inns": inns(), "taxi": { "nodes": nodes() } }))
}

/// The place warnings of a guide made of `goals`: (line, severity, message, hint).
fn place_warnings(goals: &[&str], data: &Data) -> Vec<(usize, String, String, Option<String>)> {
	let lines: Vec<String> = std::iter::once("step S".to_string()).chain(goals.iter().map(|g| format!("  {g}"))).collect();
	let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
	let r = compile_with(&guide_text(&refs), data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let pat = re(r#"^(sethome|hearth|fly|getfp) ".*": no "#);
	r.diag.sorted().into_iter().filter(|d| pat.is_match(&d.message)).map(|d| (d.line as usize, d.severity.to_string(), d.message, d.hint)).collect()
}

#[test]
fn an_inns_town_its_other_names_its_zone_and_a_flight_points_town_pass_in_any_case() {
	let goals = [
		"sethome \"Goldshire\"",
		"sethome \"kharanos\"",
		"hearth \"Thunderbrew Distillery\"",
		"hearth \"Elwynn Forest\"",
		"fly \"Stormwind\"",
		"fly \"Stormwind City\"",
		"fly \"Grom'gol Base Camp\"",
		"getfp \"Stormwind\"",
		"getfp \"Stormwind, Elwynn\"",
		"getfp \"grom'gol\"",
	];
	assert!(place_warnings(&goals, &full()).is_empty());
}

#[test]
fn a_misspelled_or_unknown_place_warns_with_the_closest_known_names() {
	let goals = ["sethome \"Goldshyre\"", "hearth \"Grom'gol\"", "getfp \"Stormwnd\"", "fly \"Nowhere At All\"", "getfp \"Elwynn\""];
	let src = guide_text(&["step S", "  sethome \"Goldshyre\"", "  hearth \"Grom'gol\"", "  getfp \"Stormwnd\"", "  fly \"Nowhere At All\"", "  getfp \"Elwynn\""]);
	let w = |line: &str, message: &str, hint: &str| (line_of(&src, line), "warning".to_string(), message.to_string(), Some(hint.to_string()));
	assert_eq!(
		place_warnings(&goals, &full()),
		vec![
			w(
				"sethome \"Goldshyre\"",
				"sethome \"Goldshyre\": no inn has that bind location; the game never reports that name, so the goal never checks off by itself",
				"did you mean \"Goldshire\"? (`polestar find --kind inn` lists every inn)"
			),
			w(
				"hearth \"Grom'gol\"",
				"hearth \"Grom'gol\": no inn stands there (an inn's area or the zone it is in); the game never reports that name, so the goal never checks off by itself",
				"did you mean \"Grom'gol Base Camp\"? (`polestar find --kind inn` lists every inn)"
			),
			w(
				"getfp \"Stormwnd\"",
				"getfp \"Stormwnd\": no flight point has that name; the game never reports that name, so the goal never checks off by itself",
				"did you mean \"Stormwind\"? (`polestar find --kind flight` lists every flight point)"
			),
			w(
				"fly \"Nowhere At All\"",
				"fly \"Nowhere At All\": no flight point lands there (its town, an inn's area or the zone it is in); the game never reports that name, so the goal never checks off by itself",
				"`polestar find --kind flight` lists every flight point"
			),
			// The node's area after the comma is not what the addon compares.
			w(
				"getfp \"Elwynn\"",
				"getfp \"Elwynn\": no flight point has that name; the game never reports that name, so the goal never checks off by itself",
				"`polestar find --kind flight` lists every flight point"
			),
		]
	);
}

#[test]
fn a_kind_of_place_the_data_has_nothing_for_is_not_checked() {
	let goals = ["sethome \"Nowhere At All\"", "hearth \"Nowhere At All\"", "fly \"Nowhere At All\"", "getfp \"Nowhere At All\""];
	let kinds = |data: &Data| place_warnings(&goals, data).into_iter().map(|w| w.2.split(':').next().unwrap().to_string()).collect::<Vec<_>>();
	// Without travel.json nothing is checked.
	assert!(place_warnings(&goals, &fixture_data()).is_empty());
	// Inns without flight points: sethome and hearth only.
	assert_eq!(kinds(&data_with("inns", json!({ "inns": inns() }))), ["sethome \"Nowhere At All\"", "hearth \"Nowhere At All\""]);
	// Flight points without inns: fly and getfp only.
	assert_eq!(kinds(&data_with("nodes", json!({ "taxi": { "nodes": nodes() } }))), ["fly \"Nowhere At All\"", "getfp \"Nowhere At All\""]);
}
