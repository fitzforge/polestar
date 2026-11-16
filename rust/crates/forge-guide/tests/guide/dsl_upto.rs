//! An objective goal's `upto` (docs/GUIDE_FORMAT.md, Modifiers): the goal is done at part of its quest
//! objective's count, so an objective worked in several places has a step for each. The modifier, its checks,
//! the emitted key and pack format 11. The addon side is an addon test.

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, FORMAT, UPTO_FORMAT};
use serde_json::{json, Value};

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

#[test]
fn upto_is_part_of_a_quest_objectives_count_by_the_line_named_or_the_one_the_data_finds() {
	let r = compile(&guide_text(&["step One", "  accept 7", "  kill 6 quest 7.1 upto 4", "  kill 6 quest 7 upto 6"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(r.warned("upto").is_empty(), "{}", r.text);
	let g = goals(&r);
	assert_eq!(json!([g[1]["quest"], g[1]["oi"], g[1]["upto"]]), json!([7, 1, 4]));
	assert_eq!(json!([g[2]["quest"], g[2]["oi"], g[2]["upto"]]), json!([7, 1, 6]));
	assert_match(&emit(&r.guides), r#"\{ t = "kill", quest = 7, title = "Kobold Camp Cleanup", target = "Kobold Vermin", npc = 6, count = 10, oi = 1, upto = 4, map = "#);
}

#[test]
fn upto_needs_a_quest_objective_to_count_and_a_count_of_1_or_more() {
	let bare = guide_text(&["step One", "  kill 6 upto 4"]);
	assert_eq!(compile(&bare).errors, [format!("test.guide:{}: `upto` counts part of a quest objective: the goal needs `quest <id>.<objective>`", line_of(&bare, "kill 6 upto 4"))]);
	for bad in ["  kill 6 quest 7.1 upto 0", "  kill 6 quest 7.1 upto", "  kill 6 quest 7.1 upto four", "  kill 6 quest 7.1 upto 2 upto 3"] {
		assert!(!compile(&guide_text(&["step One", "  accept 7", bad])).errors.is_empty(), "{bad}");
	}
	assert!(compile(&guide_text(&["step One", "  accept 7 upto 2"])).errors.iter().any(|e| e.contains("`upto <N>` does not apply to `accept`")));
}

#[test]
fn a_part_that_is_the_whole_of_the_objective_is_a_warning_the_goal_is_the_objective_itself() {
	let text = guide_text(&["step One", "  accept 7", "  kill 6 quest 7.1 upto 10"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.warned("upto"), [format!("test.guide:{}: `upto 10` is the whole of quest 7.1 (x10): the goal is done with the objective, as without it", line_of(&text, "kill 6 quest 7.1 upto 10"))]);
	assert_eq!(goals(&r)[1]["upto"], 10);
}

#[test]
fn a_guide_with_an_upto_goal_is_written_in_format_11_read_by_polestar_0_4_1_and_later() {
	assert_eq!((UPTO_FORMAT, needs(UPTO_FORMAT)), (11, Some("0.4.1")));
	assert_eq!(format_for(&compile(&guide_text(&["step One", "  accept 7", "  kill 6 quest 7.1 upto 4"])).guides), UPTO_FORMAT);
	assert_eq!(format_for(&compile(&guide_text(&["step One", "  accept 7", "  kill 6 quest 7.1"])).guides), FORMAT);
}
