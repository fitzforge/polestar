//! `skill <Profession> <N> nearest` (docs/GUIDE_FORMAT.md, "Smart targets"; #2529): the step's `goto` points are
//! the places to raise the skill, each for the characters its `only` (and the step's, else the guide's faction)
//! names. They become the goal's `candidates`, as for `train … nearest`, so the arrow leads to the one nearest the
//! player; the gotos leave the step. The runtime keys are ones every Polestar reads: no pack format change.
//! The JS twin is tests/dsl-skill-nearest.test.js; the engine side tests/engine-skill-nearest.test.js.

use crate::common;
use common::*;
use forge_guide::format::{format_for, FORMAT};
use serde_json::{json, Value};

const POINTS: [&str; 2] = ["  goto 47.4,62.2 \"Crystal Lake\" only Human", "  goto 35.4,40.1 map 1426 \"Iceflow Lake\" only Dwarf,Gnome"];

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

fn errors(lines: &[&str]) -> String {
	let mut l = vec!["step S"];
	l.extend_from_slice(lines);
	compile(&guide_text(&l)).errors.join("\n")
}

#[test]
fn skill_nearest_takes_the_steps_points_as_the_places_the_arrow_picks_from_each_for_its_own_characters() {
	let mut l = vec!["step Fishing 1-50"];
	l.extend(POINTS);
	l.push("  skill Mining 50 nearest");
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(r.warnings.is_empty(), "its places on other maps than the zone are no typo: {:?}", r.warnings);
	let g = goals(&r);
	assert_eq!(g.len(), 1, "the gotos leave the step");
	assert_eq!(json!([g[0]["t"], g[0]["level"]]), json!(["skill", 50]));
	assert!(g[0].get("map").is_none() && g[0].get("x").is_none(), "no fixed place");
	assert_eq!(
		g[0]["candidates"],
		json!([
			{ "map": 1429, "x": 47.4, "y": 62.2, "f": "e", "faction": "A", "races": ["Human"] },
			{ "map": 1426, "x": 35.4, "y": 40.1, "f": "e", "faction": "A", "races": ["Dwarf", "Gnome"] },
		])
	);
	assert_eq!(format_for(&r.guides), FORMAT, "no pack format change");
}

#[test]
fn a_point_without_only_is_for_whoever_the_step_or_the_guide_is_for() {
	let r = compile(&guide_text(&["step Fishing 1-50", "  goto 47.4,62.2", "  goto 35.4,40.1 map 1426", "  skill Mining 50 nearest"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let c = goals(&r)[0]["candidates"].clone();
	assert_eq!(json!([c[0]["faction"], c[1]["faction"], c[0].get("races"), c[1].get("races")]), json!(["A", "A", null, null]));
	let both = compile(&guide_text(&[
		"guide t/both",
		"title Both",
		"levels 1-10",
		"zone Elwynn Forest",
		"",
		"step Fishing 1-50",
		"  goto 47.4,62.2 only Horde",
		"  goto 35.4,40.1 map 1426 only Alliance",
		"  goto 50,50 map 1411",
		"  skill Mining 50 nearest",
	]));
	assert!(both.errors.is_empty(), "{}", both.text);
	let c = goals(&both)[0]["candidates"].clone();
	assert_eq!(json!([c[0]["faction"], c[1]["faction"], c[2]["faction"]]), json!(["H", "A", "AH"]));
}

#[test]
fn skill_nearest_needs_two_points_of_its_step_and_no_place_of_its_own_and_is_no_loop() {
	assert_match(&errors(&["  goto 47.4,62.2", "  skill Mining 50 nearest"]), r"needs at least two `goto` points");
	assert_match(&errors(&[POINTS[0], POINTS[1], "  skill Mining 50 nearest @47.4,62.2"]), r"drop `@x,y`");
	assert_match(&errors(&["  loop", "  goto 47.4,62.2", "  goto 52.3,26.8", "  skill Mining 50 nearest"]), r"`loop` walks them all");
	assert_match(&errors(&["  goto 47.4,62.2 optional", "  goto 35.4,40.1 map 1426", "  skill Mining 50 nearest"]), r"cannot be `optional`");
}

#[test]
fn without_nearest_a_skill_goal_keeps_the_steps_points_as_places_to_walk() {
	let mut l = vec!["step Copper"];
	l.extend(POINTS);
	l.push("  skill Mining 50");
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(g.iter().map(|g| g["t"].as_str().unwrap()).collect::<Vec<_>>(), ["goto", "goto", "skill"]);
	assert!(g[2].get("candidates").is_none());
}
