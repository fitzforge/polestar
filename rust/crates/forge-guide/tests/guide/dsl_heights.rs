//! Goal heights (heights.rs, docs/GUIDE_FORMAT.md "Heights"): a goal whose point stands for an NPC or object
//! gets the z of that entity's nearest classic-db spawn (spawnz.json) on the same instance map within 15
//! yards of the goal's world point; so do a smart target's candidates (each its own NPC) and an NPC or
//! object goal's spawn spots (#180); nothing else gets one. (The compile summary line and LICENSE-DATA.txt
//! are tested on the CLI: forge/tests/guide_cli.rs.)

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::heights::world_point;
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

fn at(data: &Data, x: f64, y: f64) -> (f64, f64) {
	let p = world_point(data, &parse_json(&format!(r#"{{"map":1429,"x":{x},"y":{y},"f":"e"}}"#)).unwrap());
	(p.get("wx").num(), p.get("wy").num())
}

/// Fixture data (Elwynn Forest, uiMap 1429, Era frame on instance map 1415): Marshal McBride (197) at
/// 48.92,41.61, Eagan Peltskinner (196) at 48.94,40.17, Brother Danil (152) at 47.5,41.6, Kobold Vermin (6)
/// around 48,31.
fn height_data() -> Data {
	let mut data = fixture_data();
	let mcbride = at(&data, 48.92, 41.61);
	let eagan = at(&data, 48.94, 40.17);
	let danil = at(&data, 47.5, 41.6);
	let kobolds: Vec<Value> = [(47.6, 31.2), (49.0, 32.4), (52.3, 26.8), (45.1, 33.9)]
		.iter()
		.map(|&(x, y)| {
			let p = at(&data, x, y);
			json!([1415, p.0, p.1, 1])
		})
		.collect();
	let (w1, w2) = (at(&data, 45.0, 40.0), at(&data, 44.0, 45.0));
	data.spawnz = v(&json!({
		"npc": {
			// 3 yd off the point, and a farther spawn that loses.
			"197": [[1415, mcbride.0 + 3.0, mcbride.1, 12.3], [1415, mcbride.0 + 14.0, mcbride.1, 99]],
			"196": [[1415, eagan.0 + 20.0, eagan.1, 5]],
			"152": [[0, danil.0, danil.1, 7]],
			"6": kobolds,
			// Timber Wolf, the meat's top source: at both its spawns, so a collect could find one.
			"69": [[1415, w1.0, w1.1, 2], [1415, w2.0, w2.1, 2]],
		},
		"object": {},
	}));
	data
}

fn src() -> String {
	guide_text(&[
		"step Heights",
		"  accept 7",
		"  accept 33",
		"  talk 197",
		"  talk 196",
		"  talk 152",
		"  goto 48.92,41.61 \"The marshal\"",
		"  kill 6 x10 quest 7.1",
		"  collect 750 x8 quest 33.1 optional",
	])
}

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

fn find<'a>(goals: &'a [Value], t: &str, npc: Option<u32>) -> &'a Value {
	goals.iter().find(|g| g["t"] == t && npc.is_none_or(|n| g["npc"] == n)).unwrap()
}

#[test]
fn z3_an_npc_goal_with_a_spawn_on_its_map_within_15_yards_gets_that_z_20_yards_another_map_a_goto_a_collect_none() {
	let r = compile_with(&src(), &height_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(find(&g, "accept", None)["z"], 12.3, "the quest giver Marshal McBride: his nearest spawn, 3 yd off");
	assert_eq!(find(&g, "talk", Some(197))["z"], 12.3);
	assert!(find(&g, "talk", Some(196)).get("z").is_none(), "a spawn 20 yd away is another one");
	assert!(find(&g, "talk", Some(152)).get("z").is_none(), "a spawn on another map says nothing");
	assert!(find(&g, "goto", None).get("z").is_none(), "a goto is a place, never an NPC");
	assert!(find(&g, "collect", None).get("z").is_none(), "a collect spot is no single NPC");
	assert_eq!(find(&g, "kill", None)["z"], 1, "a kill at its spawn");
}

#[test]
fn smart_target_candidate_on_a_spawn_of_its_npc_gets_that_z_one_with_no_spawn_within_15_yards_none() {
	let src = guide_text(&["step Smart", "  buy 159 x5 nearest"]);
	let bare = compile(&src);
	let cands = bare.guides[0].get("steps").at(0).get("goals").at(0).get("candidates");
	assert_eq!(plain(&cands).as_array().unwrap().iter().map(|c| c["npc"].clone()).collect::<Vec<_>>(), [json!(152), json!(295)]);
	assert!(cands.items().iter().all(|c| c.get("z").is_undef()), "no spawnz.json: none");
	let mut data = fixture_data();
	let p: Vec<V> = cands.items().iter().map(|c| world_point(&data, c)).collect();
	let n = |v: &V, k: &str| v.get(k).num();
	data.spawnz = v(&json!({ "npc": { "152": [[n(&p[0], "c"), n(&p[0], "wx") + 4.0, n(&p[0], "wy"), 8.5]], "295": [[n(&p[1], "c"), n(&p[1], "wx") + 20.0, n(&p[1], "wy"), 3]] }, "object": {} }));
	let r = compile_with(&src, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let c = &goals(&r)[0]["candidates"];
	assert_eq!(c[0]["z"], 8.5, "Brother Danil: his spawn 4 yd off");
	assert!(c[1].get("z").is_none(), "a spawn 20 yd away is another one");
	assert_match(&emit(&r.guides), r#"\{ npc = 152, npcName = "Brother Danil", map = \d+, x = [\d.]+, y = [\d.]+, z = 8\.5, f = "e""#);
}

#[test]
fn an_npc_goals_spawn_spots_get_the_z_of_a_spawn_within_15_yards_a_clusters_centre_farther_from_both_and_a_collects_spots_none() {
	let r = compile_with(&src(), &height_data());
	let g = goals(&r);
	let kill = find(&g, "kill", None);
	let spot = |x: f64, y: f64| kill["spots"].as_array().unwrap().iter().find(|s| s["x"] == x && s["y"] == y).unwrap().clone();
	assert_eq!(spot(45.1, 33.9)["z"], 1, "a lone spawn: its z");
	assert_eq!(spot(52.3, 26.8)["z"], 1);
	assert!(spot(48.3, 31.8).get("z").is_none(), "the centre between two spawns some 30 yd apart: none");
	let collect = find(&g, "collect", None);
	assert!(collect.get("spots").and_then(Value::as_array).is_none_or(|s| s.iter().all(|s| s.get("z").is_none())));
}

#[test]
fn class_trainers_lua_carries_a_trainers_z_and_its_header_then_names_classic_db() {
	let khelden = r#"{ "npc": 198, "npcName": "Khelden Bremen", "map": 1429, "x": 49.66, "y": 39.4, "f": "e", "faction": "A", "classes": ["MAGE"] }"#;
	let with_z = parse_json(khelden).unwrap();
	with_z.set("z", 57.25);
	let lua = forge_guide::emit::emit_class_trainers(&[with_z], &V::obj(), &V::obj());
	assert_match(&lua, r#"\{ npc = 198, npcName = "Khelden Bremen", map = 1429, x = 49\.66, y = 39\.4, z = 57\.25, f = "e", faction = "A""#);
	assert_match(lua.lines().next().unwrap(), r"spawnz\.json \(CMaNGOS classic-db spawn heights");
	let plain_lua = forge_guide::emit::emit_class_trainers(&[parse_json(khelden).unwrap()], &V::obj(), &V::obj());
	assert_no_match(plain_lua.lines().next().unwrap(), r"classic-db");
}

#[test]
fn z3_without_spawnz_json_no_goal_gets_z() {
	let r = compile(&src());
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(goals(&r).iter().all(|g| g.get("z").is_none()));
}

#[test]
fn z_is_emitted_right_after_y_deterministically() {
	let a = emit(&compile_with(&src(), &height_data()).guides);
	let b = emit(&compile_with(&src(), &height_data()).guides);
	assert_eq!(a, b);
	assert_match(&a, r#"\{ t = "talk", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48\.92, y = 41\.61, z = 12\.3, f = "e""#);
}
