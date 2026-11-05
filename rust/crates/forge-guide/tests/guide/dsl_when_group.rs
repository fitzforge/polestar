//! `when group <quest>` on a step (docs/GUIDE_FORMAT.md, "Group quests"): the player is asked at the step
//! whether to do that group quest; `when !group` is the solo alternative. The parser's predicate and errors,
//! the quest check, the refusal on `next` and `skipto` lines (no step to ask at), the emitted table and the
//! pack format. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn when_group_and_when_not_group_parse_one_quest_id() {
	let text = guide_text(&["step With a group", "  when group 783", "  accept 783", "step The solo way", "  when !group 783", "  turnin 783"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!(s[0]["when"], json!([{ "k": "group", "q": 783, "line": line_of(&text, "when group 783") }]));
	assert_eq!(s[1]["when"], json!([{ "k": "group", "neg": true, "q": 783, "line": line_of(&text, "when !group 783") }]));
}

#[test]
fn when_group_without_one_quest_id_is_an_error_at_its_line() {
	for line in ["  when group", "  when group 0", "  when group 783,7", "  when !group Kobolds"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: `group` needs one quest id: group <quest>", line_of(&text, line))], "{line}");
	}
}

#[test]
fn a_quest_not_in_the_data_warns_a_step_asking_both_ways_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when group 99999", "  accept 783", "step Two", "  when group 783", "  when !group 783", "  turnin 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(r.warnings.contains(&format!("test.guide:{}: quest 99999 is not in data (new Forever content?)", line_of(&text, "when group 99999"))), "{}", r.text);
	assert!(r.warnings.contains(&format!("test.guide:{}: the step asks for `group` and `!group` of the same quest: no character sees it", line_of(&text, "when group 783"))), "{}", r.text);
}

#[test]
fn group_is_refused_on_a_skipto_and_on_a_next_line_nobody_is_asked_there() {
	let text = guide_text(&["step One", "  skipto end when group 783", "  note Go on.", "step End", "  label end", "  note Done."]);
	let r = compile(&text);
	assert_eq!(r.errors, vec![format!("test.guide:{}: `skipto` cannot wait for an answer: `group` asks the player at a step", line_of(&text, "skipto end when group 783"))]);
	let follower = lines(&["guide t/b", "title B", "faction Horde", "levels 10-20", "zone Elwynn Forest", "pitch B.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Horde", "levels 1-10", "zone Elwynn Forest", "next t/b when group 783", "", "step Start", "  note Go on.", ""]);
	let n = compile_map(&[("main.guide", &main), ("b.guide", &follower)]);
	assert!(n.errors.iter().any(|e| e.ends_with("`group` asks the player at a step of the guide: it cannot decide a `next` option")), "{}", n.text);
}

#[test]
fn the_emitted_predicate_carries_the_quest_and_the_pack_is_written_in_format_5() {
	let r = compile(&guide_text(&["step One", "  when !group 783", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.steps()[0]["when"], json!([{ "k": "group", "neg": true, "q": 783 }]));
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "group", neg = true, q = 783 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}
