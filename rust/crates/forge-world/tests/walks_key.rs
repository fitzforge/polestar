//! World::walks_key: what forge build's walks stage is keyed by. A data fix that moves and adds no
//! place keeps it (the stage is skipped); a new place, a moved one or a zone's danger changes it.

use forge_world::World;
use serde_json::{json, Value};

fn fixture() -> Value {
	let p = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/synthetic/base/world-horde.json");
	serde_json::from_slice(&std::fs::read(&p).unwrap()).unwrap()
}

fn key(v: &Value) -> String {
	World::from_json(v.to_string().as_bytes()).unwrap().walks_key()
}

#[test]
fn a_fix_that_moves_no_place_keeps_the_walks_key() {
	let base = fixture();
	let k = key(&base);
	assert_eq!(k, key(&base), "the same world, the same key");
	let mut v = base.clone();
	v["quests"][0]["title"] = json!("Rat Trouble (corrected)");
	v["quests"][0]["xp"] = json!(355);
	v["quests"][0]["pre"] = json!([376]);
	v["dataHash"] = json!("another data hash");
	assert_eq!(key(&v), k, "a quest's text, xp, prerequisites and the data hash are not walk inputs");
}

#[test]
fn a_new_or_moved_place_or_a_zones_danger_changes_the_walks_key() {
	let base = fixture();
	let k = key(&base);
	let mut added = base.clone();
	added["points"].as_array_mut().unwrap().push(json!([1, 10, -600, 400, 1412, null]));
	assert_ne!(key(&added), k, "a new place (#735: a kill objective's camp)");
	let mut moved = base.clone();
	moved["points"][1][2] = json!(-657.9);
	assert_ne!(key(&moved), k, "a place moved by 0.1 yd");
	let mut danger = base.clone();
	danger["zoneMin"] = json!({ "1412": 10 });
	assert_ne!(key(&danger), k, "a zone's minimum level prices the danger bands");
	let mut giver = base.clone();
	giver["quests"][0]["giver"] = json!(3);
	assert_ne!(key(&giver), k, "a quest given elsewhere walks to another place");
}
