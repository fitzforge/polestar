//! `when skill <Profession> <N>` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the
//! step applies while the character's rank in that profession is N or more. The parser's predicate and
//! errors, the resolver's skill line from the professions (professions.json or the Classic built-ins) and
//! its warnings, the emitted table and the pack format. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn when_skill_and_when_not_skill_parse_with_the_profession_quoted_or_bare_one_or_more_words() {
	let text = guide_text(&["step One", "  when skill Cooking 50", "  accept 783", "step Two", "  when !skill \"First Aid\" 1", "  when skill First Aid 75", "  accept 7"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!(s[0]["when"], json!([{ "k": "skill", "name": "Cooking", "n": 50, "line": line_of(&text, "when skill Cooking 50") }]));
	assert_eq!(
		s[1]["when"],
		json!([
			{ "k": "skill", "neg": true, "name": "First Aid", "n": 1, "line": line_of(&text, "when !skill \"First Aid\" 1") },
			{ "k": "skill", "name": "First Aid", "n": 75, "line": line_of(&text, "when skill First Aid 75") },
		])
	);
}

#[test]
fn when_skill_without_a_profession_or_a_rank_of_1_or_more_is_an_error_at_its_line() {
	for line in ["  when skill", "  when skill Cooking", "  when skill 50", "  when skill Cooking 0", "  when !skill \"First Aid\""] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: `skill` needs a profession and a rank of 1 or more: skill <Profession> <N>", line_of(&text, line))], "{line}");
	}
}

#[test]
fn the_resolver_gives_the_profession_its_skill_line_and_data_name_case_aside_an_unknown_one_warns_and_keeps_the_name() {
	let text = guide_text(&["step One", "  when skill first aid 1", "  when !skill Cooking 50", "  accept 783", "step Two", "  when skill Cookery 1", "  turnin 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	// First Aid from professions.json, Cooking from the Classic built-ins.
	assert_eq!(steps[0]["when"], json!([{ "k": "skill", "name": "First Aid", "n": 1, "skillLine": 129 }, { "k": "skill", "neg": true, "name": "Cooking", "n": 50, "skillLine": 185 }]));
	assert_eq!(steps[1]["when"], json!([{ "k": "skill", "name": "Cookery", "n": 1 }]));
	assert_eq!(
		r.warned("profession"),
		vec![format!("test.guide:{}: profession \"Cookery\" is not in data: the predicate reads the skill by that name, in English only", line_of(&text, "when skill Cookery 1"))]
	);
}

#[test]
fn a_step_that_asks_for_a_skill_rank_and_its_bang_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when skill Mining 50", "  when !skill Mining 50", "  accept 783"]);
	let r = compile(&text);
	assert!(
		r.warnings.contains(&format!("test.guide:{}: the step asks for `skill` and `!skill` of the same profession and rank: no character sees it", line_of(&text, "when skill Mining 50"))),
		"{}",
		r.text
	);
}

#[test]
fn the_emitted_predicate_carries_the_skill_line_and_the_pack_is_written_in_format_5_on_a_step_or_a_next_line() {
	let r = compile(&guide_text(&["step One", "  when !skill Mining 1", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "skill", neg = true, n = 1, name = "Mining", skillLine = 186 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
	let follower = lines(&["guide t/miner", "title Miner", "faction Horde", "levels 10-20", "zone Elwynn Forest", "pitch For miners.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Horde", "levels 1-10", "zone Elwynn Forest", "next t/miner when skill Mining 1", "", "step Start", "  note Go on.", ""]);
	let n = compile_map(&[("main.guide", &main), ("miner.guide", &follower)]);
	assert!(n.errors.is_empty(), "{}", n.text);
	assert_eq!(plain(&n.guide("t/main").get("nextWhen")), json!({ "t/miner": [{ "k": "skill", "name": "Mining", "n": 1, "skillLine": 186 }] }));
	assert_eq!(format_for(&n.guides), MONEY_TASK_FORMAT);
}
