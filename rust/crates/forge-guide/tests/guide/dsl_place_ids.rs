//! Places by ID (places.rs, docs/GUIDE_FORMAT.md "Places by ID"): a goal naming a place gets the AreaTable
//! area it stands for (`area`, in the goal's zone, the open world's over Forever's copies), a getfp its flight
//! master's taxi node (`node`, for the goal's factions); a name with no single match gets nothing. (The
//! compile summary of how many got one is forge/tests/guide_cli.rs.)

use crate::common;
use common::*;
use forge_guide::data::{load_data, Data};
use serde_json::{json, Value};
use std::path::PathBuf;

/// Fixture AreaTable rows (real IDs, plus 9000x for the made-up cases): Goldshire and Stormwind City also on
/// Forever's continent 2940, a Fargodeep Mine in Durotar too, two Crystal Lakes in Elwynn Forest.
pub const AREA_CSV: &str = "ID,ZoneName,AreaName_lang,ContinentID,ParentAreaID
1,DunMorogh,\"Dun Morogh\",0,0
12,Elwynn,\"Elwynn Forest\",0,0
14,Durotar,Durotar,1,0
57,FargodeepMine,\"Fargodeep Mine\",0,12
87,Goldshire,Goldshire,0,12
1519,StormwindCity,\"Stormwind City\",0,0
2102,ThunderbrewDistillery,\"Thunderbrew Distillery\",0,1
16509,StormwindCity,\"Stormwind City\",2940,0
16524,Goldshire,Goldshire,2940,16510
90001,FargodeepMine,\"Fargodeep Mine\",1,14
90002,CrystalLake,\"Crystal Lake\",0,12
90003,CrystalLake,\"Crystal Lake\",0,12
";

fn nodes() -> Vec<Value> {
	vec![
		json!({ "id": 2, "name": "Stormwind, Elwynn", "short": "Stormwind", "map": 1453, "x": 66.3, "y": 62.67, "faction": 1, "npc": 352, "npcName": "Dungar Longdrink" }),
		json!({ "id": 18, "name": "Booty Bay, Stranglethorn", "short": "Booty Bay", "map": 1434, "x": 27.53, "y": 77.78, "faction": 2, "npc": 2858, "npcName": "Gringer" }),
		json!({ "id": 19, "name": "Booty Bay, Stranglethorn", "short": "Booty Bay", "map": 1434, "x": 27.53, "y": 77.78, "faction": 1, "npc": 2859, "npcName": "Gyll" }),
	]
}

/// The fixture data in <root>/forever with a travel.json (its taxi nodes and `inns`), and (areas) the
/// AreaTable cached in <root>/sources/wago/1.60.1.1 beside it.
fn place_dir(name: &str, areas: bool, travel: bool, inns: Value) -> PathBuf {
	let root = scratch(&format!("place-ids-{name}"));
	let dir = root.join("forever");
	std::fs::create_dir_all(&dir).unwrap();
	for e in std::fs::read_dir(data_dir()).unwrap().flatten() {
		std::fs::copy(e.path(), dir.join(e.file_name())).unwrap();
	}
	if travel {
		std::fs::write(dir.join("travel.json"), format!("{}\n", json!({ "inns": inns, "taxi": { "nodes": nodes() } }))).unwrap();
	}
	if areas {
		write_tree(&root.join("sources/wago/1.60.1.1"), &[("AreaTable.csv", AREA_CSV)]);
	}
	dir
}

fn place_data(name: &str, areas: bool, travel: bool) -> Data {
	load_data(&place_dir(name, areas, travel, json!([]))).unwrap()
}

fn src() -> String {
	guide_text(&[
		"step Places",
		"  sethome \"Goldshire\" npc 295",
		"  hearth \"Goldshire\"",
		"  hearth \"Thunderbrew Distillery\"",
		"  fly \"Stormwind City\"",
		"  fly \"Stormwind\"",
		"  getfp \"Stormwind\" npc 352",
		"  getfp \"Booty Bay\"",
		"  goto 41.5,78.2 \"Fargodeep Mine\"",
		"  goto 42.1,65.9 \"Crystal Lake\"",
		"  goto 48,42 \"Kobold camp\"",
	])
}

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

fn get(g: &Value, k: &str) -> Value {
	g.get(k).cloned().unwrap_or(Value::Null)
}

fn ids(r: &Compiled) -> Vec<Value> {
	goals(r).iter().map(|g| json!([g["t"], if g.get("location").is_some() { get(g, "location") } else { get(g, "text") }, get(g, "area"), get(g, "node")])).collect()
}

#[test]
fn a_place_name_gets_its_area_in_the_goals_zone_the_open_worlds_over_a_forever_copy_none_for_no_or_two_matches() {
	let r = compile_with(&src(), &place_data("area", true, true));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		ids(&r),
		vec![
			json!(["sethome", "Goldshire", 87, null]),
			json!(["hearth", "Goldshire", 87, null]),
			json!(["hearth", "Thunderbrew Distillery", 2102, null]),
			json!(["fly", "Stormwind City", 1519, null]),
			json!(["fly", "Stormwind", null, 2]),
			json!(["getfp", "Stormwind", null, 2]),
			json!(["getfp", "Booty Bay", null, 19]),
			json!(["goto", "Fargodeep Mine", 57, null]),
			json!(["goto", "Crystal Lake", null, null]),
			json!(["goto", "Kobold camp", null, null]),
		]
	);
}

#[test]
fn a_getfps_or_flys_node_its_flight_master_else_the_one_node_of_its_town_for_the_goals_factions_none_for_a_town_split_by_faction_on_a_guide_for_both() {
	let both = "guide t/both\ntitle Both\nlevels 1-10\nzone Elwynn Forest\n\nstep S\n  getfp \"Booty Bay\"\n  getfp \"Booty Bay\" npc 2858\n";
	let r = compile_with(both, &place_data("both", true, true));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(goals(&r).iter().map(|g| get(g, "node")).collect::<Vec<_>>(), [Value::Null, json!(18)]);
}

#[test]
fn without_the_cached_areatable_no_goal_gets_an_area_without_travel_json_no_getfp_gets_a_node() {
	let no_areas = compile_with(&src(), &place_data("noareas", false, true));
	assert!(goals(&no_areas).iter().all(|g| g.get("area").is_none()));
	assert_eq!(goals(&no_areas).iter().find(|g| g["t"] == "getfp").unwrap()["node"], 2);
	let no_travel = compile_with(&src(), &place_data("notravel", true, false));
	assert!(goals(&no_travel).iter().all(|g| g.get("node").is_none()));
}

#[test]
fn node_and_area_are_emitted_before_map_deterministically() {
	let data = place_data("emit", true, true);
	let a = emit(&compile_with(&src(), &data).guides);
	let b = emit(&compile_with(&src(), &data).guides);
	assert_eq!(a, b);
	assert_match(&a, r#"\{ t = "sethome", npc = 295, npcName = "Innkeeper Farley", location = "Goldshire", area = 87, map = 1429, "#);
	assert_match(&a, r#"\{ t = "getfp", npc = 352, location = "Stormwind", node = 2 \}"#);
	assert_match(&a, r#"\{ t = "goto", text = "Fargodeep Mine", area = 57, map = 1429, x = 41\.5, y = 78\.2"#);
}

/// Fixture inns: Goldshire's innkeeper is Alliance, Razor Hill's Horde, Booty Bay's a neutral goblin; The
/// Crossroads (Horde) is also reported as "Crossroads"; the made-up Crossway has one inn per faction.
fn inns() -> Value {
	json!([
		{ "location": "Goldshire", "names": ["Goldshire"], "npc": 295, "npcName": "Innkeeper Farley", "map": 1429, "x": 43.77, "y": 65.8 },
		{ "location": "Booty Bay", "names": ["Booty Bay"], "npc": 6807, "npcName": "Innkeeper Skindle", "map": 1434, "x": 27, "y": 77.3 },
		{ "location": "Razor Hill", "names": ["Razor Hill"], "npc": 6928, "npcName": "Innkeeper Grosk", "map": 1411, "x": 51.5, "y": 41.6 },
		{ "location": "The Crossroads", "names": ["The Crossroads", "Crossroads"], "npc": 3934, "npcName": "Innkeeper Boorand Plainswind", "map": 1413, "x": 51.99, "y": 29.89 },
		{ "location": "Crossway", "names": ["Crossway"], "npc": 295, "npcName": "Innkeeper Farley", "map": 1429, "x": 43.77, "y": 65.8 },
		{ "location": "Crossway", "names": ["Crossway"], "npc": 6928, "npcName": "Innkeeper Grosk", "map": 1411, "x": 51.5, "y": 41.6 },
	])
}

/// Adds `npcs` to the data folder's npcs.json.
fn add_npcs(dir: &std::path::Path, npcs: Value) {
	let file = dir.join("npcs.json");
	let mut all: Value = serde_json::from_slice(&std::fs::read(&file).unwrap()).unwrap();
	for (k, x) in npcs.as_object().unwrap() {
		all[k] = x.clone();
	}
	std::fs::write(file, all.to_string()).unwrap();
}

fn keepers(r: &Compiled) -> Vec<Value> {
	goals(r).iter().map(|g| json!([g.get("location").cloned().unwrap_or(json!("nearest")), get(g, "npc"), get(g, "npcName"), get(g, "map"), get(g, "x"), get(g, "y")])).collect()
}

#[test]
fn a_sethome_naming_no_npc_gets_its_inns_innkeeper_and_position_for_the_factions_it_applies_to_an_explicit_npc_wins() {
	let dir = place_dir("inns", true, true, inns());
	add_npcs(
		&dir,
		json!({ "3934": { "id": 3934, "name": "Innkeeper Boorand Plainswind", "level": 30, "faction": "H", "roles": ["innkeeper", "vendor"], "spawns": { "1413": { "f": "e", "pts": [[51.99, 29.89]] } } } }),
	);
	let data = load_data(&dir).unwrap();
	let alliance = compile_with(
		&guide_text(&[
			"step Inns",
			"  sethome \"Goldshire\"",
			"  sethome \"booty bay\"",
			"  sethome \"Razor Hill\"",
			"  sethome \"Crossroads\"",
			"  sethome \"Crossway\"",
			"  sethome \"Goldshire\" npc 6807",
			"  sethome nearest",
		]),
		&data,
	);
	assert!(alliance.errors.is_empty(), "{}", alliance.text);
	let none = |l: &str| json!([l, null, null, null, null, null]);
	assert_eq!(
		keepers(&alliance),
		vec![
			json!(["Goldshire", 295, "Innkeeper Farley", 1429, 43.77, 65.8]),
			json!(["booty bay", 6807, "Innkeeper Skindle", 1434, 27, 77.3]),
			none("Razor Hill"),
			none("Crossroads"),
			json!(["Crossway", 295, "Innkeeper Farley", 1429, 43.77, 65.8]),
			json!(["Goldshire", 6807, "Innkeeper Skindle", 1434, 27, 77.3]),
			none("nearest"),
		]
	);
	let both = "guide t/both\ntitle Both\nlevels 1-10\nzone Elwynn Forest\n\nstep Inns\n  sethome \"Booty Bay\"\n  sethome \"Goldshire\"\n  sethome \"Crossway\"\n  sethome \"Crossway\" only Horde\n  sethome \"Crossroads\" only Horde\n";
	let r = compile_with(both, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		keepers(&r),
		vec![
			json!(["Booty Bay", 6807, "Innkeeper Skindle", 1434, 27, 77.3]),
			none("Goldshire"),
			none("Crossway"),
			json!(["Crossway", 6928, "Innkeeper Grosk", 1411, 51.5, 41.6]),
			json!(["Crossroads", 3934, "Innkeeper Boorand Plainswind", 1413, 51.99, 29.89]),
		]
	);
}

fn masters(r: &Compiled) -> Vec<Value> {
	goals(r).iter().map(|g| json!([g["location"], get(g, "node"), get(g, "npc"), get(g, "npcName"), get(g, "map"), get(g, "x"), get(g, "y")])).collect()
}

#[test]
fn a_getfp_naming_no_npc_gets_its_taxi_nodes_flight_master_and_position_for_the_factions_its_races_can_be_an_explicit_npc_wins() {
	let dir = place_dir("masters", true, true, json!([]));
	let mut all = nodes();
	all.push(json!({ "id": 80, "name": "Ratchet, The Barrens", "short": "Ratchet", "map": 1413, "x": 63.08, "y": 37.16, "faction": 3, "npc": 16227, "npcName": "Bragok" }));
	std::fs::write(dir.join("travel.json"), format!("{}\n", json!({ "inns": [], "taxi": { "nodes": all } }))).unwrap();
	add_npcs(
		&dir,
		json!({
			"2858": { "id": 2858, "name": "Gringer", "level": 55, "faction": "H", "roles": ["flightmaster"], "spawns": { "1434": { "f": "e", "pts": [[26.53, 77.04]] } } },
			"2859": { "id": 2859, "name": "Gyll", "level": 55, "faction": "A", "roles": ["flightmaster"], "spawns": { "1434": { "f": "e", "pts": [[27.53, 77.78]] } } },
			"16227": { "id": 16227, "name": "Bragok", "level": 55, "faction": null, "roles": ["flightmaster"], "spawns": { "1413": { "f": "e", "pts": [[63.08, 37.16]] } } },
		}),
	);
	let data = load_data(&dir).unwrap();
	let none = |l: &str| json!([l, null, null, null, null, null, null]);
	let alliance = compile_with(&guide_text(&["step Flight paths", "  getfp \"Booty Bay\"", "  getfp \"ratchet\"", "  getfp \"Booty Bay\" npc 2858", "  getfp \"Nowhere\""]), &data);
	assert_eq!(
		masters(&alliance),
		vec![
			json!(["Booty Bay", 19, 2859, "Gyll", 1434, 27.53, 77.78]),
			json!(["ratchet", 80, 16227, "Bragok", 1413, 63.08, 37.16]),
			json!(["Booty Bay", 18, 2858, "Gringer", 1434, 26.53, 77.04]),
			none("Nowhere"),
		]
	);
	let both = "guide t/both\ntitle Both\nlevels 1-10\nzone Elwynn Forest\n\nstep Flight paths\n  getfp \"Ratchet\"\n  getfp \"Booty Bay\"\n  getfp \"Booty Bay\" only Horde\n  getfp \"Booty Bay\" only Human\n  getfp \"Booty Bay\" only Skyborne\n";
	let r = compile_with(both, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		masters(&r),
		vec![
			json!(["Ratchet", 80, 16227, "Bragok", 1413, 63.08, 37.16]),
			none("Booty Bay"),
			json!(["Booty Bay", 18, 2858, "Gringer", 1434, 26.53, 77.04]),
			json!(["Booty Bay", 19, 2859, "Gyll", 1434, 27.53, 77.78]),
			none("Booty Bay"),
		]
	);
}
