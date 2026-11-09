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
	let ends = |t: &serde_json::Value| (t["kind"].as_str().unwrap().to_string(), t["faction"].as_i64().unwrap(), t["a"]["map"].as_i64().unwrap(), t["b"]["map"].as_i64().unwrap(), t["a"]["c"].as_f64().unwrap(), t["b"]["c"].as_f64().unwrap());
	assert_eq!(ends(&ride("airship-zephras-dalaran")), ("airship".into(), 1, 2521, 1416, 2991.0, 0.0));
	assert_eq!(ends(&ride("airship-zephras-mulgore")), ("airship".into(), 2, 2521, 1412, 2991.0, 1.0));
	let d = ride("airship-zephras-dalaran");
	assert!((d["a"]["x"].as_f64().unwrap() - 65.8).abs() < 1.0 && (d["a"]["y"].as_f64().unwrap() - 83.6).abs() < 1.0, "the skydock by the guide's goto (65.8,83.4): {}", d["a"]);
	assert!((d["b"]["x"].as_f64().unwrap() - 12.8).abs() < 1.0 && (d["b"]["y"].as_f64().unwrap() - 51.2).abs() < 1.0, "the Kirin Tor camp west of Dalaran: {}", d["b"]);
	assert!(d["ab"].as_f64().unwrap() > 60.0 && d["waitA"].as_f64().unwrap() > 0.0, "a ride and a wait: {d}");
}
