//! Goal heights (heights.rs, docs/GUIDE_FORMAT.md "Heights"): a goal whose point stands for an NPC or object
//! gets the z of that entity's nearest classic-db spawn (spawnz.json) on the same instance map within 15
//! yards of the goal's world point; so do a smart target's candidates (each its own NPC), an NPC or
//! object goal's spawn spots (#180) and a use bound to a quest objective at an object or creature (#1782);
//! nothing else gets one. (The compile summary line and LICENSE-DATA.txt are tested on the CLI:
//! forge/tests/guide_cli.rs.)

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

/// #1782 (Redrett, Hillsbrad Foothills, Horde 30-40): `use 3710 quest 553.1 @43.9,28.1`, the Rod of Helcular at the
/// Flame of Azel, had no height: the Flame burns in the Foothill Caverns under Darrow Hill, and the walk from the north
/// ended on the hilltop above it. A `use` bound to a quest objective stands for that objective's object, or its
/// creature (kill, talk): it gets that one's spawn height. Bound to an item objective, or to none, it gets none.
#[test]
fn a_use_bound_to_an_objective_at_an_object_or_a_creature_gets_that_ones_spawn_z_1782() {
	let data = height_data();
	data.quests.set(
		"95930",
		v(&json!({ "id": 95930, "title": "Helcular's Revenge", "level": 5, "minLevel": 1, "races": null, "classes": null,
			"start": { "npc": [197], "object": [], "item": [] }, "end": { "npc": [197], "object": [] }, "pre": [], "excl": [], "next": null,
			"objectives": [
				{ "type": "object", "id": 95931, "count": 1, "text": "Flame of Azel charged" },
				{ "type": "kill", "id": 6, "count": 1, "text": "Kobold Vermin" },
				{ "type": "item", "id": 750, "count": 1, "text": "Tough Wolf Meat" }
			],
			"objectiveText": "", "zone": 1429, "xp": 250, "source": ["fixture"] })),
	);
	let flame = at(&data, 40.0, 50.0);
	data.spawnz.get("object").set("95931", v(&json!([[1415, flame.0 + 2.0, flame.1, 72.9]])));
	let src = guide_text(&["step Flames", "  accept 95930", "  use 1210 quest 95930.1 @40,50", "  use 1210 quest 95930.2 @47.6,31.2", "  use 1210 quest 95930.3 @40,50", "  use 1210 @40,50"]);
	let r = compile_with(&src, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let uses: Vec<Value> = goals(&r).into_iter().filter(|g| g["t"] == "use").collect();
	assert_eq!(uses[0]["z"], 72.9, "the objective's object, 2 yd off: {}", uses[0]);
	assert_eq!(uses[1]["z"], 1, "the kill objective's creature at its spawn: {}", uses[1]);
	assert!(uses[2].get("z").is_none(), "an item objective is no place: {}", uses[2]);
	assert!(uses[3].get("z").is_none(), "a use bound to no objective: {}", uses[3]);
}

/// #2126 (Pilsnerinn, Thousand Needles, Horde 26-30): `use 5868 quest 1197.1 @42.0,31.5`, the Filled Etched Phial on
/// the Ancient Brazier deep in Splithoof Hold, had no height while the Cloven Hoof's collect beside it had the
/// brazier's: the arrow climbed the Great Lift to the hill over the cave. A use bound to an item objective stands for
/// the objects the item comes out of (items.json `drops.object`): the nearest spawn of one within 15 yards gives its
/// height; one farther gives none (an item only creatures drop gives none either: the #1782 case above).
#[test]
fn a_use_bound_to_an_item_objective_gets_the_spawn_z_of_the_object_its_item_comes_out_of_2126() {
	let data = height_data();
	data.quests.set(
		"1197",
		v(&json!({ "id": 1197, "title": "The Sacred Flame", "level": 5, "minLevel": 1, "races": null, "classes": null,
			"start": { "npc": [197], "object": [], "item": [] }, "end": { "npc": [197], "object": [] }, "pre": [], "excl": [], "next": null,
			"objectives": [{ "type": "item", "id": 5869, "count": 1, "text": "Cloven Hoof" }],
			"objectiveText": "", "zone": 1429, "xp": 250, "source": ["fixture"] })),
	);
	data.items.set("5869", v(&json!({ "id": 5869, "name": "Cloven Hoof", "drops": { "npc": {}, "object": { "20807": 100 } }, "vendors": [], "questItem": true })));
	let brazier = at(&data, 40.0, 50.0);
	data.spawnz.get("object").set("20807", v(&json!([[1415, brazier.0 + 2.0, brazier.1, -70.5]])));
	let src = guide_text(&["step Splithoof Hold", "  accept 1197", "  use 1210 quest 1197.1 @40,50", "  use 1210 quest 1197.1 @40,52"]);
	let r = compile_with(&src, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let uses: Vec<Value> = goals(&r).into_iter().filter(|g| g["t"] == "use").collect();
	assert_eq!(uses[0]["z"], -70.5, "the brazier the hoof comes out of, 2 yd off: {}", uses[0]);
	assert!(uses[1].get("z").is_none(), "the brazier's spawn is over 15 yd from this point: {}", uses[1]);
}

/// #1786 (Redrett): `goto 28.5,55.0 "Azurelode Mine"` leads to the miners (`kill 2269 quest 539.2`, z 21.3) in the
/// next step, but had no height: the walk ended on the hill the mine runs under. A goto gets the height of the goal
/// it leads to (a later goal of its step, or one of the next), the nearest within 15 yards; none from farther, from
/// an earlier goal or from two steps on.
#[test]
fn a_goto_takes_the_height_of_the_goal_it_leads_to_in_its_step_or_the_next_within_15_yards_1786() {
	let src = guide_text(&[
		"step Before",
		"  talk 197",
		"  goto 48.92,41.61 \"After the marshal\"",
		"step To the marshal",
		"  goto 48.92,41.61 \"The marshal\"",
		"step Marshal",
		"  talk 197",
		"step Far",
		"  goto 48.94,40.17 \"Eagan\"",
		"step Eagan",
		"  talk 196",
		"step Two on",
		"  goto 48.92,41.61 \"Two steps from the marshal\"",
		"step Between",
		"  goto 10,10 \"Elsewhere\"",
		"step Marshal again",
		"  talk 197",
	]);
	let r = compile_with(&src, &height_data());
	assert!(r.errors.is_empty(), "{}", r.text);
	let gotos: Vec<Value> = r.steps().iter().flat_map(|s| s["goals"].as_array().unwrap().clone()).filter(|g| g["t"] == "goto").collect();
	let z = |i: usize| gotos[i].get("z").cloned();
	assert_eq!(z(0), None, "the marshal's talk comes before it: {}", gotos[0]);
	assert_eq!(z(1), Some(json!(12.3)), "the next step's talk, 3 yd off: {}", gotos[1]);
	assert_eq!(z(2), None, "a goal with no height (his spawn 20 yd away): {}", gotos[2]);
	assert_eq!(z(3), None, "the marshal two steps on: {}", gotos[3]);
}

/// #1782: where no NPC or object gives a goal's floor, data/goal-heights.json may, from players' recordings (a
/// mine's floor under the hill): a goal of any verb with no height within 5 yards of a record takes its z; one 10
/// yards off, or one with a height of its own, does not.
#[test]
fn a_goal_with_no_height_within_5_yards_of_a_goal_heights_record_takes_its_z_1782() {
	let mut data = height_data();
	data.goal_heights = v(&json!([
		{ "id": "rec-mine", "map": 1429, "x": 30.0, "y": 60.0, "frame": "era", "z": 21.3, "source": { "kind": "recording", "ref": "fixture" } },
		{ "id": "rec-marshal", "map": 1429, "x": 48.92, "y": 41.61, "frame": "era", "z": 99, "source": { "kind": "recording", "ref": "fixture" } }
	]));
	let (a, b) = (at(&data, 30.0, 60.0), at(&data, 30.0, 60.5));
	assert!((a.0 - b.0).abs() > 10.0, "60.5 lies more than 10 yd from the record");
	let src = guide_text(&["step Mine", "  goto 30,60 \"The mine\"", "  goto 30.05,60 \"Just by it\"", "  goto 30,60.5 \"Farther\"", "  talk 197"]);
	let r = compile_with(&src, &data);
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(g[0]["z"], 21.3, "on the record: {}", g[0]);
	assert_eq!(g[1]["z"], 21.3, "a yard or two off: {}", g[1]);
	assert!(g[2].get("z").is_none(), "half a map percent off: {}", g[2]);
	assert_eq!(g[3]["z"], 12.3, "the marshal's own spawn wins over a record: {}", g[3]);
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
fn spawn_spots_get_the_z_of_a_spawn_within_15_yards_a_clusters_centre_farther_from_both_none_a_collects_by_its_sources() {
	let r = compile_with(&src(), &height_data());
	let g = goals(&r);
	let kill = find(&g, "kill", None);
	let spot = |x: f64, y: f64| kill["spots"].as_array().unwrap().iter().find(|s| s["x"] == x && s["y"] == y).unwrap().clone();
	assert_eq!(spot(45.1, 33.9)["z"], 1, "a lone spawn: its z");
	assert_eq!(spot(52.3, 26.8)["z"], 1);
	assert!(spot(48.3, 31.8).get("z").is_none(), "the centre between two spawns some 30 yd apart: none");
	// A collect's spots: those at a spawn of one of its sources (the Timber Wolves at 45,40 and 44,45) take that
	// spawn's z (#1782); the rest none.
	let collect = find(&g, "collect", None);
	let spots = collect["spots"].as_array().cloned().unwrap_or_default();
	assert!(!spots.is_empty(), "the collect has spots: {collect}");
	for s in &spots {
		let at_wolf = (s["x"] == 45.0 && s["y"] == 40.0) || (s["x"] == 44.0 && s["y"] == 45.0);
		assert_eq!(s.get("z").cloned(), if at_wolf { Some(json!(2)) } else { None }, "spot {s}");
	}
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
