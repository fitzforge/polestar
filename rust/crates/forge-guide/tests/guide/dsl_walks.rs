//! Walking NPCs (walks.rs, docs/GUIDE_FORMAT.md "Spawn areas"): a goal at an NPC whose spawn walks 20 yards
//! or more from its walk's centre (moves.json) gets that walk as its one spawn spot, so the map circles the
//! ground and the arrow counts it as reached; a short pace, a spawn elsewhere or no moves.json gives none.

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::heights::world_point;
use forge_guide::js::parse_json;
use serde_json::{json, Value};

fn at(data: &Data, x: f64, y: f64) -> (f64, f64, f64) {
	let p = world_point(data, &parse_json(&format!(r#"{{"map":1429,"x":{x},"y":{y},"f":"e"}}"#)).unwrap());
	(p.get("c").num(), p.get("wx").num(), p.get("wy").num())
}

/// Marshal McBride (197) at 48.92,41.61 walks 40 yd round a centre 30 yd off his spawn; Eagan
/// Peltskinner (196) at 48.94,40.17 paces 12 yd; Brother Danil (152) walks from a spawn 30 yd off his
/// point.
fn walk_data() -> Data {
	let mut data = fixture_data();
	let (c, mx, my) = at(&data, 48.92, 41.61);
	let (_, ex, ey) = at(&data, 48.94, 40.17);
	let (_, dx, dy) = at(&data, 47.5, 41.6);
	data.moves = v(&json!({ "npc": {
		"197": [[c, mx + 2.0, my, mx + 30.0, my, 40.0]],
		"196": [[c, ex, ey, ex, ey, 12.0]],
		"152": [[c, dx + 30.0, dy, dx + 30.0, dy, 50.0]],
	}}));
	data
}

fn goal(src: &[&str], data: &Data) -> Value {
	let r = compile_with(&guide_text(src), data);
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps()[0]["goals"][0].clone()
}

#[test]
fn a_walking_npcs_goal_gets_its_walk_as_its_one_spot_a_short_pace_or_another_spawns_walk_none() {
	let data = walk_data();
	let mcbride = goal(&["step Walker", "  talk 197"], &data);
	let spots = mcbride["spots"].as_array().expect("a walker's goal has its walk as a spot");
	assert_eq!(spots.len(), 1);
	assert_eq!(spots[0]["r"], 40, "the walk's radius");
	assert_eq!(spots[0]["n"], 1);
	let (_, cx, _) = at(&data, spots[0]["x"].as_f64().unwrap(), spots[0]["y"].as_f64().unwrap());
	let (_, mx, _) = at(&data, 48.92, 41.61);
	assert!((cx - (mx + 30.0)).abs() < 1.0, "the spot is the walk's centre, not the spawn ({cx} vs {})", mx + 30.0);
	assert_eq!((mcbride["x"].clone(), mcbride["y"].clone()), (json!(48.92), json!(41.61)), "the goal keeps the spawn as its point");
	assert!(goal(&["step Pacer", "  talk 196"], &data).get("spots").is_none(), "12 yd is pacing, not walking");
	assert!(goal(&["step Elsewhere", "  talk 152"], &data).get("spots").is_none(), "a walk from a spawn 30 yd off is another spawn's");
	assert!(goal(&["step No data", "  talk 197"], &fixture_data()).get("spots").is_none(), "no moves.json: none");
}
