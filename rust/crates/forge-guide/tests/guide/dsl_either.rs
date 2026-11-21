//! A goal's `either` (docs/GUIDE_FORMAT.md, "One of several"): the goals of a step that carry it are
//! alternatives, and the step is done when any one of them is. The modifier, the checks on a set (two goals or
//! more, none optional), the emitted key and pack format 11. The addon side is an addon test.

use crate::common;
use common::*;
use forge_guide::data::Data;
use forge_guide::format::{format_for, needs, EITHER_FORMAT, FORMAT, MONEY_TASK_FORMAT};
use serde_json::{json, Value};

fn goals(r: &Compiled) -> Vec<Value> {
	r.steps()[0]["goals"].as_array().unwrap().clone()
}

fn eithers(r: &Compiled) -> Vec<Value> {
	goals(r).iter().map(|g| g.get("either").cloned().unwrap_or(Value::Null)).collect()
}

#[test]
fn either_marks_the_goals_of_a_step_that_are_alternatives_and_the_others_are_not_of_the_set() {
	let r = compile(&guide_text(&["step Pick one", "  accept 783 either", "  task \"Ask around\" either only Warrior", "  accept 7"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(eithers(&r), [json!(true), json!(true), Value::Null]);
	let text = emit(&r.guides);
	assert_match(&text, r#"\{ t = "accept", quest = 783, .* f = "e", either = true \},\n"#);
	assert_match(&text, r#"\{ t = "task", text = "Ask around", either = true, only = \{ classes = \{ "WARRIOR" \} \} \},\n"#);
	assert!(!re(r"quest = 7, .*either").is_match(&text), "{text}");
}

#[test]
fn a_set_is_two_goals_or_more_none_of_them_optional() {
	let alone = guide_text(&["step One", "  accept 783 either", "  accept 7"]);
	assert_eq!(compile(&alone).errors, [format!("test.guide:{}: `either` needs a second `either` goal in its step: the step is done when any one of them is", line_of(&alone, "accept 783 either"))]);
	let optional = guide_text(&["step One", "  accept 783 either optional", "  accept 7 either"]);
	assert_eq!(
		compile(&optional).errors,
		[format!("test.guide:{}: a goal cannot be both `either` and `optional`: an optional goal never holds its step", line_of(&optional, "accept 783 either optional"))]
	);
	// One set a step: two goals in each of two steps are two sets.
	let two = compile(&guide_text(&["step One", "  accept 783 either", "  accept 7 either", "step Two", "  turnin 783 either", "  turnin 7 either"]));
	assert!(two.errors.is_empty(), "{}", two.text);
}

#[test]
fn either_goes_on_every_goal_that_can_hold_a_step_and_on_no_note_or_wait() {
	let lines = ["accept 783", "kill 6", "collect 750 x2", "goto 47.6,35.1", "talk 197", "money 1s", "task \"Take the boat\"", "destroy 750", "abandon 7", "level 3", "hearth \"Goldshire\""];
	let mut src = vec!["step One".to_string()];
	src.extend(lines.iter().map(|l| format!("  {l} either")));
	let r = compile(&guide_text(&src.iter().map(String::as_str).collect::<Vec<_>>()));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(eithers(&r), vec![json!(true); lines.len()]);
	for (line, verb) in [("  note \"Words\" either", "note"), ("  wait 30 either", "wait")] {
		let errors = compile(&guide_text(&["step One", line, "  accept 7 either", "  accept 783 either"])).errors;
		assert!(errors.iter().any(|e| e.contains(&format!("`either` does not apply to `{verb}`"))), "{verb}: {errors:?}");
	}
}

/// The fixture data plus two quests of Marshal McBride's of which a character takes one: 9720 By the Road and
/// 9721 By the River close each other (`excl`).
fn fork_data() -> Data {
	let mut t = tables();
	for (id, title, excl) in [(9720, "By the Road", 9721), (9721, "By the River", 9720)] {
		let mut q = t["quests"]["7"].clone();
		for (k, x) in json!({ "id": id, "title": title, "pre": [], "objectives": [], "excl": [excl] }).as_object().unwrap() {
			q[k] = x.clone();
		}
		t.get_mut("quests").unwrap()[id.to_string()] = q;
	}
	data_from(&t, Value::Null, Value::Null)
}

#[test]
fn quests_that_close_each_other_are_no_warning_as_an_either_set_and_still_one_a_step_apart() {
	let data = fork_data();
	let set = compile_with(&guide_text(&["step Fork", "  accept 9720 either", "  accept 9721 either", "step Back", "  turnin 9720", "  turnin 9721"]), &data);
	assert!(set.errors.is_empty(), "{}", set.text);
	assert!(set.warned("is not offered once").is_empty(), "{}", set.text);
	let apart = guide_text(&["step Road", "  accept 9720", "step River", "  accept 9721", "step Back", "  turnin 9720", "  turnin 9721"]);
	assert_eq!(
		compile_with(&apart, &data).warned("is not offered once"),
		[format!("test.guide:{}: quest 9721 (By the River) is not offered once 9720 (By the Road) is in the log or done, and the chain takes that quest earlier", line_of(&apart, "accept 9721"))]
	);
	// Another quest of the set's step that is not of the set closes it as before.
	let beside = guide_text(&["step Fork", "  accept 9720", "  accept 9721 either", "  accept 783 either", "step Back", "  turnin 9720", "  turnin 9721", "  turnin 783"]);
	assert_eq!(compile_with(&beside, &data).warned("is not offered once").len(), 1);
}

#[test]
fn a_guide_with_an_either_goal_is_written_in_format_11_read_by_polestar_0_4_1_and_later() {
	assert_eq!((EITHER_FORMAT, needs(EITHER_FORMAT)), (11, Some("0.4.1")));
	let set = compile(&guide_text(&["step One", "  accept 783 either", "  accept 7 either"]));
	assert_eq!(format_for(&set.guides), EITHER_FORMAT);
	assert_eq!(format_for(&compile(&guide_text(&["step One", "  accept 783", "  accept 7"])).guides), FORMAT);
	assert_eq!(format_for(&compile(&guide_text(&["step One", "  task \"A\"", "  task \"B\""])).guides), MONEY_TASK_FORMAT);
}
