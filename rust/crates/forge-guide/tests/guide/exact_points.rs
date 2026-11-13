//! Exact points (#1944; docs/GUIDE_FORMAT.md, "Spawn areas", Points): a kill, collect or interact goal whose
//! target stands at a few known points gets each point as a spot of its own, `r` 0, in place of spawn areas:
//! every spawn of an object (up to 40), and a creature's when it stands at up to 8 places, no two within 70 yd
//! of each other and none walking about. More objects, a camp of mobs, more places or a walker keep their
//! spawn areas. Hand-placed goals get the points of the target at their point, and keep that point.

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::heights::world_point;
use forge_guide::js::parse_json;
use serde_json::{json, Map, Value};

/// The Sprung Traps of the test's Dry Hills: nine on Elwynn's 40-45, 20-24.
const TRAPS: [(f64, f64); 9] = [(40.0, 20.0), (41.0, 21.0), (42.0, 20.5), (43.0, 22.0), (40.5, 23.0), (42.0, 24.0), (44.0, 21.0), (44.5, 23.5), (41.5, 22.5)];

/// A coordinate as the compiled goal writes it (whole numbers without a fraction).
fn n(x: f64) -> Value {
	if x.fract() == 0.0 {
		json!(x as i64)
	} else {
		json!(x)
	}
}

fn spawns(pts: &[(f64, f64)]) -> Value {
	json!({ "1429": { "f": "e", "pts": pts.iter().map(|&(x, y)| json!([x, y])).collect::<Vec<_>>() } })
}

/// The fixture's core tables with the traps (listed once more 2 yd off the first, and one stray far away), 41
/// crates over the whole map, and four kinds of brute: at three places far apart, in a camp, at nine places,
/// and at three places of which one walks 40 yd about its point.
fn data() -> Data {
	let mut t: Map<String, Value> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	let mut traps = TRAPS.to_vec();
	traps.push((40.05, 20.05));
	traps.push((80.0, 80.0));
	let crates: Vec<(f64, f64)> = (0..41).map(|i| (10.0 + (i % 7) as f64 * 12.0, 10.0 + (i / 7) as f64 * 12.0)).collect();
	let objects = t.get_mut("objects").unwrap();
	objects["95200"] = json!({ "id": 95200, "name": "Sprung Trap", "spawns": spawns(&traps) });
	objects["95205"] = json!({ "id": 95205, "name": "Scattered Crate", "spawns": spawns(&crates) });
	let npc = |id: u32, name: &str, pts: &[(f64, f64)]| json!({ "id": id, "name": name, "level": 12, "faction": null, "spawns": spawns(pts) });
	let npcs = t.get_mut("npcs").unwrap();
	npcs["95201"] = npc(95201, "Lone Brute", &[(20.0, 30.0), (30.0, 60.0), (60.0, 70.0)]);
	npcs["95202"] = npc(95202, "Camp Brute", &[(50.0, 50.0), (50.5, 50.5), (51.0, 50.0)]);
	npcs["95203"] = npc(95203, "Sparse Brute", &(1..10).map(|i| (i as f64 * 10.0, i as f64 * 10.0)).collect::<Vec<_>>());
	npcs["95204"] = npc(95204, "Walking Brute", &[(25.0, 85.0), (55.0, 85.0), (85.0, 85.0)]);
	let item = |id: u32, name: &str, drops: Value| json!({ "id": id, "name": name, "drops": drops, "vendors": [] });
	let items = t.get_mut("items").unwrap();
	items["95210"] = item(95210, "Trapped Game", json!({ "npc": {}, "object": { "95200": 100 } }));
	items["95211"] = item(95211, "Crate Part", json!({ "npc": {}, "object": { "95205": 100 } }));
	items["95212"] = item(95212, "Brute Tusk", json!({ "npc": { "95201": 100 }, "object": {} }));
	let mut d = data_from(&t, Value::Null, Value::Null);
	let p = world_point(&d, &parse_json(r#"{"map":1429,"x":55,"y":85,"f":"e"}"#).unwrap());
	let (c, wx, wy) = (p.get("c").num(), p.get("wx").num(), p.get("wy").num());
	d.moves = v(&json!({ "npc": { "95204": [[c, wx, wy, wx, wy, 40.0]] } }));
	d
}

fn goals(d: &Data, lines: &[&str]) -> Vec<Value> {
	let r = compile_with(&guide_text(lines), d);
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps().iter().flat_map(|s| s["goals"].as_array().cloned().unwrap_or_default()).collect()
}

fn spots(goal: &Value) -> Vec<Value> {
	goal.get("spots").and_then(Value::as_array).cloned().unwrap_or_default()
}

/// Every spot's radius.
fn radii(goal: &Value) -> Vec<f64> {
	spots(goal).iter().map(|s| s["r"].as_f64().unwrap()).collect()
}

/// The traps as points: by x then y, the stray last as an alternative.
fn trap_points() -> Vec<Value> {
	let mut traps = TRAPS.to_vec();
	traps.sort_by(|a, b| a.partial_cmp(b).unwrap());
	let mut out: Vec<Value> = traps.into_iter().map(|(x, y)| json!({ "x": n(x), "y": n(y), "r": 0 })).collect();
	out.push(json!({ "x": 80, "y": 80, "r": 0, "alt": true }));
	out
}

#[test]
fn a_collect_from_an_object_and_a_click_on_it_get_every_known_spawn_as_a_point_1944() {
	let d = data();
	let g = goals(&d, &["step Traps", "  goto 41,20", "  collect 95210 x8", "  interact 95200"]);
	for goal in [&g[1], &g[2]] {
		assert_eq!(spots(goal), trap_points(), "{}: every trap a point, the one listed twice once, the stray an alternative", goal["t"]);
		assert!(goal.get("spread").is_none(), "points are searched as points, not as an area: {goal}");
	}
	assert_eq!(json!([g[1]["x"], g[1]["y"], g[1]["from"], g[1]["fromKind"]]), json!([41, 21, "Sprung Trap", "object"]), "the goal's point: the trap nearest the goto");
	// Coming from the stray's corner, the goal's point leaves the stray for the nearest trap of the rest.
	let far = goals(&d, &["step Traps", "  goto 79,79", "  collect 95210 x8"]);
	assert_eq!(json!([far[1]["x"], far[1]["y"]]), json!([44.5, 23.5]));
	assert_eq!(spots(&far[1]), trap_points(), "the same list whatever the goal's point");
}

#[test]
fn a_hand_placed_goal_at_an_object_gets_its_points_and_keeps_the_authors_point() {
	let d = data();
	let g = goals(&d, &["step Traps", "  collect 95210 x8 @42.2,21.8"]);
	assert_eq!(spots(&g[0]), trap_points());
	assert_eq!(json!([g[0]["x"], g[0]["y"]]), json!([42.2, 21.8]));
}

#[test]
fn more_than_forty_spawns_of_an_object_keep_their_spawn_areas() {
	let d = data();
	let g = goals(&d, &["step Crates", "  collect 95211 x3"]);
	assert!(!spots(&g[0]).is_empty() && radii(&g[0]).iter().all(|&r| r > 0.0), "41 crates over the map: spawn areas, as before: {}", g[0]);
}

#[test]
fn a_creature_at_a_few_fixed_places_gets_points_a_camp_more_places_or_a_walker_keep_their_spawn_areas() {
	let d = data();
	let g = goals(&d, &["step Brutes", "  goto 21,31", "  kill 95201", "  kill 95202", "  kill 95203", "  kill 95204", "  collect 95212 x1"]);
	assert_eq!(spots(&g[1]), [json!({ "x": 20, "y": 30, "r": 0 }), json!({ "x": 30, "y": 60, "r": 0 }), json!({ "x": 60, "y": 70, "r": 0 })], "three places far apart: a point each");
	assert_eq!(json!([g[1]["x"], g[1]["y"], g[1]["lvl"]]), json!([20, 30, 12]), "the place nearest the goto; the mobs' level, as for spawn areas");
	for (i, why) in [(2, "a camp: three spawns within 70 yd"), (3, "nine places"), (4, "one spawn walks 40 yd about its point")] {
		assert!(!spots(&g[i]).is_empty() && radii(&g[i]).iter().all(|&r| r > 0.0), "{why}: spawn areas: {}", g[i]);
	}
	assert_eq!(radii(&g[5]), [0.0, 0.0, 0.0], "an item only the lone brute drops: its points: {}", g[5]);
}

#[test]
fn a_point_packs_as_its_x_y_height_and_a_zero_radius() {
	let packed = forge_guide::emit::pack_spots(&v(&json!([{ "x": 43.41, "y": 14.62, "r": 0 }, { "x": 42.7, "y": 21.2, "z": -3.5, "r": 0, "alt": true }])));
	assert_eq!(packed, "43.41,14.62,,0;42.7,21.2,-3.5,0,,1");
}
