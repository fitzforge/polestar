//! `loop` steps (docs/GUIDE_FORMAT.md, "Spawn areas"): in a step with a `loop` line, the `goto` points (in
//! order) are the places to search. Each kill, collect, interact or skill goal of the step without its own
//! `@x,y` gets them as its spawn areas (`spots`, searched one after another: `spread`), its point at the
//! first; the gotos leave the step. In a step with none of those goals the points are where to look for an
//! NPC who walks: its accept, turnin and talk goals take them.
//! The runtime keys are ones every Polestar reads, so a loop changes no pack format.
//! (The addon accepting a loop step is an addon test.)

use crate::common;
use common::*;
use forge_guide::format::{format_for, FORMAT};
use serde_json::{json, Value};

const LOOP: [&str; 9] = [
	"step Kobold circuit",
	"  loop",
	"  goto 47.6,35.1 \"North camp\"",
	"  goto 49.0,32.4 r 20",
	"  goto 52.3,26.8",
	"  kill 6 x10 quest 7.1",
	"  collect 750 x2",
	"  interact 1617",
	"  note Pull one at a time.",
];

fn spots() -> Value {
	json!([{ "x": 47.6, "y": 35.1, "r": 30 }, { "x": 49, "y": 32.4, "r": 20 }, { "x": 52.3, "y": 26.8, "r": 30 }])
}

fn compiled(lines: &[&str]) -> Compiled {
	let mut l = vec!["step Accept", "  accept 7"];
	l.extend_from_slice(lines);
	l.extend(["step Hand in", "  turnin 7"]);
	compile(&guide_text(&l))
}

fn errors(lines: &[&str]) -> String {
	compiled(lines).errors.join("\n")
}

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[1]["goals"].as_array().unwrap().clone()
}

#[test]
fn a_loop_step_turns_its_gotos_into_the_spawn_areas_of_its_kill_collect_and_interact_goals() {
	let r = compiled(&LOOP);
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(g.iter().map(|g| g["t"].clone()).collect::<Vec<_>>(), [json!("kill"), json!("collect"), json!("interact"), json!("note")], "the gotos are gone");
	for x in &g[..3] {
		assert_eq!([&x["map"], &x["x"], &x["y"], &x["f"]], [&json!(1429), &json!(47.6), &json!(35.1), &json!("e")], "{}: placed at the first point, in its frame", x["t"]);
		assert_eq!(x["spots"], spots(), "{}: every point, in order, its goto's r or 30 yd", x["t"]);
		assert_eq!(x["spread"], true, "{}: searched one after another", x["t"]);
	}
	assert_eq!(g[0]["quest"], 7);
	assert_eq!(g[0]["count"], 10);
	assert!(r.steps()[1].get("loop").is_none(), "loop is a compile-time line");
	assert_eq!(format_for(&r.guides), FORMAT, "no pack format change");
}

#[test]
fn the_displacer_and_its_kill_share_only_the_four_authored_silo_points() {
	let text = std::fs::read_to_string(fixtures().join("silo-loop.guide")).unwrap();
	let tables = serde_json::from_slice(&std::fs::read(fixtures().join("silo-loop.json")).unwrap()).unwrap();
	let r = compile_with(&text, &data_from(&tables, Value::Null, Value::Null));
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	let goals = steps[1]["goals"].as_array().unwrap();
	assert_eq!(goals.len(), 2);
	assert_eq!(json!([goals[0]["t"], goals[0]["item"], goals[1]["t"], goals[1]["npc"]]), json!(["use", 12627, "kill", 10717]));
	let spots = json!([
		{"x":45.15,"y":62.28,"r":8}, {"x":46.38,"y":62.33,"r":8},
		{"x":47.83,"y":63.45,"r":8}, {"x":48.45,"y":62.81,"r":8}
	]);
	for g in goals {
		assert_eq!(g["spots"], spots, "{}", g["t"]);
		assert_eq!(json!([g["quest"], g["oi"], g["map"], g["x"], g["y"], g["spread"]]), json!([4971, 1, 1422, 45.15, 62.28, true]));
	}
	assert!(!r.warnings.iter().any(|w| w.contains("has no coordinates")), "{}", r.text);
}

#[test]
fn a_loop_places_a_skill_goal_on_its_points_for_a_gathering_round() {
	let r = compiled(&["step Copper round", "  loop", "  goto 47.6,35.1", "  goto 49.0,32.4 r 20", "  skill Mining 50"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(g.len(), 1, "the gotos leave the step");
	assert_eq!(json!([g[0]["t"], g[0]["level"], g[0]["map"], g[0]["x"], g[0]["y"], g[0]["spread"]]), json!(["skill", 50, 1429, 47.6, 35.1, true]));
	assert_eq!(g[0]["spots"], json!([{ "x": 47.6, "y": 35.1, "r": 30 }, { "x": 49, "y": 32.4, "r": 20 }]));
	assert_eq!(format_for(&r.guides), FORMAT, "no pack format change");
}

#[test]
fn a_loop_with_nothing_else_to_search_places_the_npc_of_its_accept_turnin_and_talk_goals() {
	let r = compiled(&["step A sergeant on his rounds", "  loop", "  goto 47.6,35.1", "  goto 49.0,32.4", "  accept 783", "  talk 197"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(g.iter().map(|g| g["t"].clone()).collect::<Vec<_>>(), [json!("accept"), json!("talk")], "the gotos are gone");
	for x in &g {
		assert_eq!(json!([x["map"], x["x"], x["y"], x["spread"], x["spots"].as_array().unwrap().len()]), json!([1429, 47.6, 35.1, true, 2]), "{}", x["t"]);
	}
	// Beside a goal the loop searches for, an accept keeps the place the data gives it.
	let mixed = compiled(&["step Kobolds", "  loop", "  goto 47.6,35.1", "  goto 49.0,32.4", "  accept 783", "  kill 6"]);
	assert!(mixed.errors.is_empty(), "{}", mixed.text);
	let g = goals(&mixed);
	assert!(g[0].get("spread").is_none() && g[0].get("spots").is_none(), "the accept is not the loop's");
	assert_eq!(g[1]["spread"], true);
	assert_eq!(format_for(&mixed.guides), FORMAT, "no pack format change");
}

#[test]
fn a_goal_placed_with_x_y_keeps_its_point_and_its_own_spawn_areas() {
	let r = compiled(&["step Loop", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  kill 6 x10 quest 7.1", "  collect 750 x2 @40,60"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	let own = goals(&compiled(&["step Own", "  collect 750 x2 @40,60"]))[0].clone();
	let g = goals(&r);
	assert_eq!(g[0]["spots"].as_array().unwrap().len(), 2);
	assert_eq!(g[1], own);
}

#[test]
fn a_loop_target_the_data_has_no_spawns_for_is_placed_by_the_loop_without_the_no_coordinates_warning() {
	let has = |r: &Compiled| r.warnings.iter().any(|w| w.contains("`kill` has no coordinates"));
	assert!(has(&compiled(&["step Ghost", "  kill \"Wandering Ghost\""])), "the warning without a loop");
	let r = compiled(&["step Ghost", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  kill \"Wandering Ghost\""]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(!has(&r), "{}", r.text);
	let ghost = &goals(&r)[0];
	assert_eq!(json!([ghost["map"], ghost["x"], ghost["y"], ghost["spots"].as_array().unwrap().len(), ghost["spread"]]), json!([1429, 47.6, 35.1, 2, true]));
}

#[test]
fn a_loop_needs_two_points_on_one_map_and_frame_a_goal_to_search_them_and_nothing_else_on_its_line() {
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  kill 6"]), r"`loop` needs at least two `goto` points");
	assert_match(
		&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  note Nobody here"]),
		r"`loop` needs an unpinned kill, collect, interact, skill or `use … quest Q.O` goal, or with none of those an accept, turnin or talk",
	);
	for goal in ["  kill 6 @50,30", "  talk 197 @50,30", "  use 750 @50,30 quest 7.1", "  use 750"] {
		assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", goal]), r"`loop` needs an unpinned");
	}
	assert_match(&errors(&["step L", "  loop", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  kill 6"]), r"duplicate `loop` in step");
	assert_match(&errors(&["step L", "  loop now", "  goto 47.6,35.1", "  goto 52.3,26.8", "  kill 6"]), r"`loop` takes nothing");
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 50,50 map 1411", "  kill 6"]), r"`loop` points must all be on one map");
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 50,50 live", "  kill 6"]), r"`loop` points must all be in one map frame");
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 50,50 optional", "  kill 6"]), r"a `loop` point cannot be `optional` or have `only`");
}

#[test]
fn without_loop_the_gotos_stay_a_path_to_walk() {
	let lines: Vec<&str> = LOOP.iter().copied().filter(|l| *l != "  loop").collect();
	let g = goals(&compiled(&lines));
	assert_eq!(g.iter().map(|g| g["t"].as_str().unwrap()).collect::<Vec<_>>(), ["goto", "goto", "goto", "kill", "collect", "interact", "note"]);
	assert_ne!(g[3].get("spots"), Some(&spots()));
}

// #1616 kept (Alliance Desolace, Kolkar Village): a loop collect's target button names the droppers at the author's
// points, not the map's best droppers elsewhere. The Gelkis drop the token at 40% and 38% far from the loop; the
// Kolkar Raider and Scout (30%, 25%) stand at its first point, the Kolkar Mauler (10%, under half the map's best)
// alone at its second. Each point names its own; the Mauler's camp still has its target. The JS twin is in
// tests/dsl-loop-search.test.js.
const CAMP: [(u32, &str, u32, f64, f64); 5] = [
	(95941, "Gelkis Raider", 40, 60.0, 60.0),
	(95942, "Gelkis Scout", 38, 61.0, 60.0),
	(95943, "Kolkar Raider", 30, 30.0, 30.0),
	(95944, "Kolkar Scout", 25, 30.3, 30.2),
	(95945, "Kolkar Mauler", 10, 40.0, 30.0),
];

#[test]
fn a_loop_collect_names_the_droppers_at_each_of_its_points_a_point_none_of_the_likely_ones_stands_at_its_own_1616() {
	let dir = data_dir_with("loop-npcs", &data_dir(), |raw| {
		let drops: serde_json::Map<String, Value> = CAMP.iter().map(|c| (c.0.to_string(), json!(c.2))).collect();
		raw.get_mut("items.json").unwrap()["95940"] = json!({ "id": 95940, "name": "Camp Token", "drops": { "npc": drops, "object": {} }, "vendors": [] });
		for (id, name, _, x, y) in CAMP {
			raw.get_mut("npcs.json").unwrap()[id.to_string()] = json!({ "id": id, "name": name, "level": 5, "faction": null, "spawns": { "1429": { "f": "e", "pts": [[x, y], [x + 0.1, y]] } } });
		}
	});
	let r = compile_with(&guide_text(&["step Kolkar Village", "  loop", "  goto 30,30 r 60", "  goto 40,30 r 60", "  collect 95940 x5"]), &forge_guide::data::load_data(&dir).unwrap());
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	let goal = &steps[0]["goals"][0];
	let names: Vec<&str> = goal["fromNpcs"].as_array().unwrap().iter().map(|n| n["npcName"].as_str().unwrap()).collect();
	assert_eq!(names, ["Kolkar Raider", "Kolkar Scout", "Kolkar Mauler"], "{goal}");
	assert_eq!(goal["fromNpcsAt"], "1,2;3");
}
