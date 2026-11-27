//! `goto x,y ["Text"] nearest` (docs/GUIDE_FORMAT.md, "Smart targets"): the step's `nearest` gotos are one goal whose
//! places are smart-target `candidates`, each for the characters its `only` (and the step's) names: a profession
//! guide's "Go to an anvil", where the arrow leads to the nearest station and arriving at any of them finishes it.
//! The JS twin is tests/dsl-goto-nearest.test.js; the engine side tests/engine-goto-nearest.test.js.

use crate::common;
use common::*;
use serde_json::json;

const ANVILS: [&str; 2] = ["  goto 47.4,62.2 \"Anvil\" nearest only Alliance", "  goto 35.4,40.1 \"Anvil\" map 1426 nearest only Alliance"];

fn errors(lines: &[&str]) -> String {
	let mut l = vec!["step S"];
	l.extend_from_slice(lines);
	compile(&guide_text(&l)).errors.join("\n")
}

#[test]
fn goto_nearest_points_are_one_goal_whose_places_are_its_candidates() {
	let mut l = vec!["step Go to an anvil"];
	l.extend(ANVILS);
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(r.warnings.is_empty(), "its places on other maps than the zone are no typo: {:?}", r.warnings);
	let g = r.steps()[0]["goals"].as_array().unwrap().clone();
	assert_eq!(g.len(), 1, "one goal");
	assert_eq!(json!([g[0]["t"], g[0]["text"]]), json!(["goto", "Anvil"]));
	assert!(g[0].get("map").is_none() && g[0].get("x").is_none() && g[0].get("only").is_none(), "no fixed place");
	assert_eq!(
		g[0]["candidates"],
		json!([
			{ "map": 1429, "x": 47.4, "y": 62.2, "f": "e", "faction": "A" },
			{ "map": 1426, "x": 35.4, "y": 40.1, "f": "e", "faction": "A" },
		])
	);
}

#[test]
fn other_goals_stay_and_a_goto_without_nearest_stays_a_place_to_walk() {
	let mut l = vec!["step Go to an anvil", "  goto 50,50"];
	l.extend(ANVILS);
	l.push("  note ready");
	let r = compile(&guide_text(&l));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = r.steps()[0]["goals"].as_array().unwrap().clone();
	let kinds: Vec<(String, bool)> = g.iter().map(|x| (x["t"].as_str().unwrap().to_string(), x.get("candidates").is_some())).collect();
	assert_eq!(kinds, vec![("goto".into(), false), ("goto".into(), true), ("note".into(), false)]);
}

#[test]
fn goto_nearest_needs_two_points_none_optional_no_loop_and_no_skill_nearest_beside_it() {
	assert!(errors(&[ANVILS[0]]).contains("needs at least two `nearest` points"));
	let optional = format!("{} optional", ANVILS[1]);
	assert!(errors(&[ANVILS[0], &optional]).contains("cannot be `optional`"));
	assert!(errors(&["  loop", ANVILS[0], ANVILS[1]]).contains("`loop` walks them all"));
	assert!(errors(&[ANVILS[0], ANVILS[1], "  skill Mining 50 nearest"]).contains("use one"));
}
