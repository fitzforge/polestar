//! `travel build` (travel.json, TravelData.lua, FlightPaths.lua, Polestar_Travel/*) against the
//! JavaScript's output on the data golden, client table slices, the shipped and a synthetic local
//! crossings file and synthetic walks, without a navigation grid: rust/tests/golden/travel (README).

use crate::common;

use forge_data::travel::{build, Options};

#[test]
fn travel_matches_golden() {
	let g = common::golden("travel");
	let input = g.join("input");
	let mut o = Options::new(&input);
	o.data_dir = common::golden("data").join("expected");
	o.recordings_dir = input.join("recordings");
	o.sources_dir = input.join("sources");
	o.shipped_file = Some(input.join("crossings.json"));
	o.crossings_file = input.join("local").join("crossings.json");
	o.grid_dir = None;
	let out = build(&o).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in out.files() {
		check.file(&name, text, &want.join(&name));
		names.push(name);
	}
	assert!(out.travel_addon.is_some(), "the local crossings file builds Polestar_Travel");
	check.all_of(&want.join("Polestar_Travel"), &names.iter().filter_map(|n| n.strip_prefix("Polestar_Travel/").map(String::from)).collect::<Vec<_>>());
	names.push("Polestar_Travel".into());
	check.all_of(&want, &names);
	check.finish("travel build");
}

/// Zephras Isle's two airships (Forever TaxiPaths 11398 and 11457): the Alliance skycutter from the Valanaar
/// Skydocks to the Kirin Tor camp west of Dalaran, the Horde airship to northern Mulgore, each end at its stop on
/// its own zone's map. Without them the addon's planner had no way off the isle.
#[test]
fn zephras_isle_airships_leave_from_the_valanaar_skydocks_for_dalaran_and_mulgore() {
	let g = common::golden("travel");
	let input = g.join("input");
	let mut o = Options::new(&input);
	o.data_dir = common::golden("data").join("expected");
	o.recordings_dir = input.join("recordings");
	o.sources_dir = input.join("sources");
	o.shipped_file = Some(input.join("crossings.json"));
	o.crossings_file = input.join("local").join("crossings.json");
	o.grid_dir = None;
	let out = build(&o).unwrap();
	let doc: serde_json::Value = serde_json::from_str(&out.travel_json).unwrap();
	let ride = |id: &str| doc["transports"].as_array().unwrap().iter().find(|t| t["id"] == id).cloned().unwrap_or_else(|| panic!("{id} built: warnings {}", doc["warnings"]));
	let ends = |t: &serde_json::Value| {
		(
			t["kind"].as_str().unwrap().to_string(),
			t["faction"].as_i64().unwrap(),
			t["a"]["map"].as_i64().unwrap(),
			t["b"]["map"].as_i64().unwrap(),
			t["a"]["c"].as_f64().unwrap(),
			t["b"]["c"].as_f64().unwrap(),
		)
	};
	assert_eq!(ends(&ride("airship-zephras-dalaran")), ("airship".into(), 1, 2521, 1416, 2991.0, 0.0));
	assert_eq!(ends(&ride("airship-zephras-mulgore")), ("airship".into(), 2, 2521, 1412, 2991.0, 1.0));
	let d = ride("airship-zephras-dalaran");
	assert!((d["a"]["x"].as_f64().unwrap() - 65.8).abs() < 1.0 && (d["a"]["y"].as_f64().unwrap() - 83.6).abs() < 1.0, "the skydock by the guide's goto (65.8,83.4): {}", d["a"]);
	assert!((d["b"]["x"].as_f64().unwrap() - 12.8).abs() < 1.0 && (d["b"]["y"].as_f64().unwrap() - 51.2).abs() < 1.0, "the Kirin Tor camp west of Dalaran: {}", d["b"]);
	assert!(d["ab"].as_f64().unwrap() > 60.0 && d["waitA"].as_f64().unwrap() > 0.0, "a ride and a wait: {d}");
}

/// #2830 (Wolven): the Mulgore end of the Zephras Isle airship stood at the ship's stop, which hangs off the cliff
/// beside its dock, so the arrow led to the valley floor under it. Each airship end away from the isle is placed
/// at the NPC on its dock (Brix Xizzix in Mulgore, Arcanist Laurain at the Kirin Tor camp), whose spawn gives it
/// the dock's height with the walking grid.
#[test]
fn the_airship_ends_away_from_zephras_isle_stand_at_the_npc_on_their_dock_2830() {
	let g = common::golden("travel");
	let input = g.join("input");
	let data = std::env::temp_dir().join(format!("forge-travel-2830-{}", std::process::id()));
	std::fs::create_dir_all(&data).unwrap();
	for e in std::fs::read_dir(common::golden("data").join("expected")).unwrap() {
		let p = e.unwrap().path();
		std::fs::copy(&p, data.join(p.file_name().unwrap())).unwrap();
	}
	let mut npcs: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(data.join("npcs.json")).unwrap()).unwrap();
	npcs["262502"] = serde_json::json!({ "id": 262502, "name": "Brix Xizzix", "level": 30, "spawns": { "1412": { "f": "l", "pts": [[34.25, 25.68]] } } });
	npcs["256306"] = serde_json::json!({ "id": 256306, "name": "Arcanist Laurain", "level": 30, "spawns": { "1416": { "f": "l", "pts": [[12.9, 52.01]] } } });
	std::fs::write(data.join("npcs.json"), serde_json::to_string(&npcs).unwrap()).unwrap();
	let mut o = Options::new(&input);
	o.data_dir = data.clone();
	o.recordings_dir = input.join("recordings");
	o.sources_dir = input.join("sources");
	o.shipped_file = Some(input.join("crossings.json"));
	o.crossings_file = input.join("local").join("crossings.json");
	o.grid_dir = None;
	let out = build(&o).unwrap();
	std::fs::remove_dir_all(&data).ok();
	let doc: serde_json::Value = serde_json::from_str(&out.travel_json).unwrap();
	let ride = |id: &str| doc["transports"].as_array().unwrap().iter().find(|t| t["id"] == id).cloned().unwrap();
	let m = ride("airship-zephras-mulgore")["b"].clone();
	assert_eq!((m["x"].as_f64(), m["y"].as_f64()), (Some(34.25), Some(25.68)), "Mulgore: on the dock, at Brix Xizzix: {m}");
	assert!(m["source"].as_str().unwrap().starts_with("npc 262502 (\"Brix Xizzix\")"), "{m}");
	let d = ride("airship-zephras-dalaran")["b"].clone();
	assert_eq!((d["x"].as_f64(), d["y"].as_f64()), (Some(12.9), Some(52.01)), "Dalaran: on the dock, at Arcanist Laurain: {d}");
	assert!(d["source"].as_str().unwrap().starts_with("npc 256306 (\"Arcanist Laurain\")"), "{d}");
}
