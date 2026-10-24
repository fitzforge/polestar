//! `loop` steps (docs/GUIDE_FORMAT.md, "Spawn areas"): in a step with a `loop` line, the `goto` points (in
//! order) are the places to search. Each kill, collect or interact goal of the step without its own `@x,y`
//! gets them as its spawn areas (`spots`, searched one after another: `spread`), its point at the first; the
//! gotos leave the step. The runtime keys are ones every Polestar reads, so a loop changes no pack format.
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
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  talk 197"]), r"`loop` needs a kill, collect or interact goal without its own `@x,y`");
	assert_match(&errors(&["step L", "  loop", "  goto 47.6,35.1", "  goto 52.3,26.8", "  kill 6 @50,30"]), r"`loop` needs a kill, collect or interact goal");
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
