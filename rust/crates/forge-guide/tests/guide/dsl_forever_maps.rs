//! Maps Forever added (Zephras Isle, Riverglades, Mount Hyjal, Shen'dralas) have no Era frame in
//! map-frames.json, only a Forever one, and their points are in the live frame. Everything in the compiler
//! that measures yards on them reads that frame (data.frame): spawn areas and farm spots (#299, #422). (The
//! quest database's markers and the route geometry on them are tested with those tools.)

use crate::common;
use common::*;
use forge_guide::data::load_data;
use forge_guide::js::V;
use serde_json::{json, Value};

const ZEPHRAS: u32 = 2521;

fn frame() -> Value {
	json!({ "c": 2991, "left": 4231.25, "right": -1331.25, "top": 4956.25, "bottom": 1247.917 })
}

const SX: f64 = (4231.25 + 1331.25) / 100.0; // 55.6 yd per x %
const SY: f64 = (4956.25 - 1247.917) / 100.0; // 37.1 yd per y %

#[test]
fn data_frame_the_era_frame_else_the_forever_one_map_sizes_come_from_it() {
	let data = load_data(&data_dir_with("fm-frame", &data_dir(), |raw| {
		raw.get_mut("map-frames.json").unwrap()["forever"] = json!({ ZEPHRAS.to_string(): frame() });
	}))
	.unwrap();
	let z = V::from(ZEPHRAS);
	assert_eq!(plain(&data.frame(&z)), frame());
	assert!(!data.era_frame(&z).truthy(), "Era-frame coordinates still need an Era frame");
	assert_eq!(plain(&data.frame(&V::from(1429))), plain(&data.era_frame(&V::from(1429))));
	let size = data.map_size(&z);
	assert!((size.get("w").num() - 5562.5).abs() < 1.0 && (size.get("h").num() - 3708.3).abs() < 1.0, "{}", plain(&size));
	assert!(!data.frame(&V::from(99999)).truthy());
}

#[test]
fn spawn_areas_on_a_forever_only_map_cover_the_camp_in_that_maps_own_yards() {
	// A camp of 16 mobs, 1.8% x 1.8% of Zephras Isle: about 100 x 67 yd.
	let mut pts = Vec::new();
	for i in 0..4 {
		for j in 0..4 {
			pts.push((44.0 + i as f64 * 0.6, 26.0 + j as f64 * 0.6));
		}
	}
	let jpts: Vec<Value> = pts.iter().map(|(x, y)| json!([x, y])).collect();
	let dir = data_dir_with("fm-spawns", &data_dir(), |raw| {
		raw.get_mut("map-frames.json").unwrap()["forever"] = json!({ ZEPHRAS.to_string(): frame() });
		raw.get_mut("npcs.json").unwrap()["92000"] = json!({ "id": 92000, "name": "Isle Vuldren", "level": 3, "faction": null, "spawns": { ZEPHRAS.to_string(): { "f": "l", "pts": jpts } } });
	});
	let r = compile_with("guide t/s\ntitle S\nlevels 1-10\nzone Elwynn Forest\n\nstep S\n  kill 92000 x5\n", &load_data(&dir).unwrap());
	assert!(r.errors.is_empty(), "{}", r.text);
	let goal = r.steps()[0]["goals"][0].clone();
	assert_eq!(goal["map"], ZEPHRAS);
	let spots = goal["spots"].as_array().cloned().unwrap_or_default();
	assert!(!spots.is_empty(), "{goal}");
	let outside: Vec<_> =
		pts.iter().filter(|(x, y)| !spots.iter().any(|s| ((x - s["x"].as_f64().unwrap()) * SX).hypot((y - s["y"].as_f64().unwrap()) * SY) <= s["r"].as_f64().unwrap() + 0.5)).collect();
	assert!(outside.is_empty(), "{outside:?} {spots:?}");
}

#[test]
fn farm_spots_on_a_forever_only_zone_of_eastern_kingdoms_contested_clustered_in_that_maps_yards() {
	// Riverglades: Eastern Kingdoms (continent 0), 4850 yd east-west, 48.5 yd per x %.
	let riverglades = 2548;
	// Two camps 2% apart: 97 yd, two spots at the 70 yd cluster radius (60 yd and one spot in a 3000 yd zone).
	let dir = data_dir_with("fm-farm", &data_dir(), |raw| {
		raw.get_mut("map-frames.json").unwrap()["forever"] = json!({ "2548": { "c": 0, "left": -1891.666, "right": -6741.666, "top": -6466.666, "bottom": -9700 } });
		raw.get_mut("zones.json").unwrap()["2548"] = json!({ "areaId": 16591, "id": 2548, "name": "Riverglades", "parent": 1415, "type": 3 });
		raw.get_mut("npcs.json").unwrap()["92001"] =
			json!({ "faction": null, "id": 92001, "level": 30, "name": "Glade Lurker", "spawns": { "2548": { "f": "l", "pts": [[40, 50], [40.2, 50.2], [42, 50], [42.2, 50.2]] } } });
		raw.get_mut("items.json").unwrap()["4306"]["drops"]["npc"]["92001"] = json!(30);
	});
	let data = load_data(&dir).unwrap();
	let spots: Vec<Value> = plain(&forge_guide::farmspots::farm_spots(&data, &V::from(4306))).as_array().unwrap().iter().filter(|s| s["map"] == riverglades).cloned().collect();
	let got: Vec<Value> = spots.iter().map(|s| json!([s["faction"], s.get("f"), s["x"], s["y"], s["spawns"]])).collect();
	assert_eq!(got, [json!(["AH", null, 40.1, 50.1, 2]), json!(["AH", null, 42.1, 50.1, 2])]);
}
