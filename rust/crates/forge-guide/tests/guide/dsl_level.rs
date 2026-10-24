//! A point inside a level: `level 12.5` (halfway through 12) and `level 12+2500` (2500 XP into it), as a
//! goal and in `when level` (docs/GUIDE_FORMAT.md): the parser's values and errors (xp.rs level_point), the
//! compiled and emitted `frac`, always strictly inside (0, 1), the pack format it needs, and playback to the
//! XP (level_reached). (The planner's goal-line writer is tested with the planner.)

use crate::common;
use common::*;
use forge_guide::format::{format_for, FORMAT, WHEN_FORMAT};
use forge_guide::xp::{level_point, level_reached, Progress, LEVEL_XP};
use serde_json::{json, Value};

fn goal_of(line: &str) -> (Value, Vec<String>) {
	let (ast, diag) = parse_all(&guide_text(&["step S", &format!("  {line}")]), "x.guide");
	let errors = diag.sorted().iter().filter(|d| d.severity == "error").map(|d| d.message.clone()).collect();
	(plain(&ast.get("steps").at(0).get("goals").at(0)), errors)
}

fn level_goal(line: &str) -> Value {
	let (mut goal, errors) = goal_of(line);
	assert!(errors.is_empty(), "{line}: {errors:?}");
	for k in ["line", "zone", "verb"] {
		goal.as_object_mut().unwrap().remove(k);
	}
	goal
}

fn error_of(line: &str) -> String {
	goal_of(line).1.join("\n")
}

#[test]
fn level_n_fraction_and_n_plus_xp_parse_to_level_and_frac_n_0_and_n_plus_0_are_plain_level_n() {
	assert_eq!(level_goal("level 12"), json!({ "level": 12 }));
	assert_eq!(level_goal("level 12.5"), json!({ "level": 12, "frac": 0.5 }));
	assert_eq!(level_goal("level 12.05"), json!({ "level": 12, "frac": 0.05 }));
	assert_eq!(level_goal("level 12.333"), json!({ "level": 12, "frac": 0.33 }));
	assert_eq!(level_goal("level 12.0"), json!({ "level": 12 }));
	assert_eq!(level_goal("level 12+0"), json!({ "level": 12 }));
	// 2500 of level 12's 10100 XP: 24.8%, the XP kept as written for the planner.
	assert_eq!(LEVEL_XP[12], 10100.0);
	assert_eq!(level_goal("level 12+2500"), json!({ "level": 12, "frac": 0.25, "levelXp": 2500 }));
	assert_eq!(level_goal("level 12+5050"), json!({ "level": 12, "frac": 0.5, "levelXp": 5050 }));
}

#[test]
fn a_point_that_rounds_to_the_start_or_end_of_the_level_xp_past_it_or_a_level_outside_1_59_is_an_error() {
	// These two compiled to frac = 0 and frac = 1, which the addon refuses ("bad frac").
	assert_match(&error_of("level 12.004"), r"level 12\.004 is less than 1% into level 12: write 12");
	assert_match(&error_of("level 12.999"), r"level 12\.999 rounds to the end of level 12: write 13");
	assert_match(&error_of("level 12.995"), r"rounds to the end of level 12");
	assert_eq!(level_goal("level 12.994"), json!({ "level": 12, "frac": 0.99 }));
	assert_eq!(level_goal("level 12.005"), json!({ "level": 12, "frac": 0.01 }));
	assert_match(&error_of("level 12+50"), r"less than 1% into level 12");
	assert_match(&error_of("level 12+10099"), r"rounds to the end of level 12: write 13");
	assert_match(&error_of("level 12+10100"), r"level 12\+10100: more XP than level 12 needs \(10100\)");
	assert_match(&error_of("level 60.5"), r"a point inside a level needs a level from 1 to 59");
	assert_match(&error_of("level 0.5"), r"a point inside a level needs a level from 1 to 59");
	assert_match(&error_of("level 12.5x"), r#"malformed level "12\.5x""#);
	assert_match(&error_of("level 12+"), r#"malformed level "12\+""#);
	assert_match(&error_of("level 0"), r#"malformed level "0""#);
	assert_match(&error_of("level \"12.5\""), r#"malformed level "12\.5""#);
}

#[test]
fn every_frac_the_parser_accepts_is_emitted_strictly_inside_0_1() {
	for d in 0..1000 {
		let Ok(p) = level_point(&format!("12.{d:03}")) else { continue };
		let Some(f) = p.frac else { continue };
		assert!(f > 0.0 && f < 1.0, "12.{d}");
		assert_eq!(format!("{f:.2}").parse::<f64>().unwrap(), f, "12.{d}: two decimals");
	}
	for xp in 1..LEVEL_XP[1] as u32 {
		if let Ok(p) = level_point(&format!("1+{xp}")) {
			if let Some(f) = p.frac {
				assert!(f > 0.0 && f < 1.0, "1+{xp}");
			}
		}
	}
}

#[test]
fn the_compiled_and_emitted_goal_carries_frac_the_pack_needs_format_4_only_then() {
	let r = compile(&guide_text(&["step Half", "  level 3.5", "step XP", "  level 4+700", "step Plain", "  level 5"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(first_goals(&r), vec![json!({ "t": "level", "level": 3, "frac": 0.5 }), json!({ "t": "level", "level": 4, "frac": 0.33 }), json!({ "t": "level", "level": 5 })]);
	let lua = emit(&r.guides);
	assert_match(&lua, r#"\{ t = "level", level = 3, frac = 0\.5 \}"#);
	assert_match(&lua, r#"\{ t = "level", level = 4, frac = 0\.33 \}"#);
	assert_match(&lua, r#"\{ t = "level", level = 5 \}"#);
	assert_eq!(format_for(&r.guides), WHEN_FORMAT);
	let flat = compile(&guide_text(&["step Plain", "  level 5", "step Zero", "  level 6.0"]));
	assert!(flat.errors.is_empty(), "{}", flat.text);
	assert_eq!(format_for(&flat.guides), FORMAT);
}

#[test]
fn when_level_takes_a_point_inside_a_level_too_with_the_same_errors() {
	let text = guide_text(&["step S", "  when level>=12.5", "  when level < 12+2500", "  when level<=3", "  accept 7"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(
		plain(&ast.get("steps").at(0).get("when")),
		json!([
			{ "k": "level", "op": ">=", "n": 12, "frac": 0.5, "line": line_of(&text, "when level>=12.5") },
			{ "k": "level", "op": "<", "n": 12, "frac": 0.25, "line": line_of(&text, "when level < 12+2500") },
			{ "k": "level", "op": "<=", "n": 3, "line": line_of(&text, "when level<=3") },
		])
	);
	let err = |when: &str| {
		let (_, d) = parse_all(&guide_text(&["step S", &format!("  when {when}"), "  accept 7"]), "x.guide");
		d.sorted().iter().filter(|x| x.severity == "error").map(|x| x.message.clone()).collect::<Vec<_>>().join("\n")
	};
	assert_match(&err("level>=12.999"), r"rounds to the end of level 12");
	assert_match(&err("level>=12.004"), r"less than 1% into level 12");
	assert_match(&err("level<12+99999"), r"more XP than level 12 needs");
	assert_match(&err("level>=60.5"), r"needs a level from 1 to 59");
	assert_match(&err("level>70"), r"level 70 is out of range \(1-60\)");
	let r = compile(&guide_text(&["step S", "  when level>=2.5", "  accept 7"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.steps()[0]["when"], json!([{ "k": "level", "op": ">=", "n": 2, "frac": 0.5 }]));
	assert_match(&emit(&r.guides), r#"when = \{ \{ k = "level", op = ">=", n = 2, frac = 0\.5 \} \}"#);
}

#[test]
fn a_when_level_with_frac_splits_its_level_no_never_holds_warning_at_the_guides_edge() {
	// The guide is for levels 1-10.
	let never = |when: &str| {
		let r = compile(&guide_text(&["step S", &format!("  when {when}"), "  accept 7"]));
		assert!(r.errors.is_empty(), "{when}");
		r.warned("never holds").len()
	};
	assert_eq!(never("level>10"), 1);
	assert_eq!(never("level>10.5"), 0);
	assert_eq!(never("level>=10.5"), 0);
	assert_eq!(never("level<1"), 1);
	assert_eq!(never("level<1.5"), 0);
}

#[test]
fn the_planner_writes_the_goal_line_back_as_written_and_plays_it_to_the_xp() {
	// Done past the level, or at it with the share of its XP (the goal-line writer is the planner's).
	let at = |level: f64, xp: f64| Progress { level, xp };
	assert!(!level_reached(&at(12.0, 5049.0), 12.0, 0.5));
	assert!(level_reached(&at(12.0, 5050.0), 12.0, 0.5));
	assert!(level_reached(&at(13.0, 0.0), 12.0, 0.5));
	assert!(!level_reached(&at(11.0, 8000.0), 12.0, 0.5));
	assert!(level_reached(&at(12.0, 0.0), 12.0, 0.0));
}
