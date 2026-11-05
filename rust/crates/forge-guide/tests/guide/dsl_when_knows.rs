//! `when knows <spell>` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the step
//! applies while the character knows the spell. The parser's predicate and errors, the emitted table and
//! the pack format. 100 is Charge (Rank 1); the id is taken as written.

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn when_knows_parses_a_spell_id_with_or_without_bang() {
	let text = guide_text(&["step One", "  when !knows 100", "  when knows 6673", "  accept 783"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(
		plain(&ast.get("steps").at(0).get("when")),
		json!([
			{ "k": "knows", "neg": true, "spell": 100, "line": line_of(&text, "when !knows 100") },
			{ "k": "knows", "spell": 6673, "line": line_of(&text, "when knows 6673") },
		])
	);
}

#[test]
fn when_knows_without_one_spell_id_is_an_error_at_its_line() {
	for line in ["  when knows", "  when knows 0", "  when knows Charge", "  when knows 100 2", "  when !knows spell 100"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: `knows` needs a spell id: knows <spell>", line_of(&text, line))], "{line}");
	}
}

#[test]
fn a_step_that_asks_for_a_spell_and_its_bang_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when knows 100", "  when !knows 100", "  accept 783"]);
	let r = compile(&text);
	let want = format!("test.guide:{}: the step asks for `knows` and `!knows` of the same spell: no character sees it", line_of(&text, "when knows 100"));
	assert!(r.warnings.contains(&want), "{}", r.text);
}

#[test]
fn the_emitted_predicate_carries_the_spell_on_a_step_or_a_next_option_and_the_pack_is_written_in_format_5() {
	let r = compile(&guide_text(&["step One", "  when !knows 100", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(plain(&r.guides[0].get("steps"))[0]["when"], json!([{ "k": "knows", "neg": true, "spell": 100 }]));
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "knows", neg = true, spell = 100 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
	let follower = lines(&["guide t/warrior", "title Warrior", "faction Horde", "levels 10-20", "zone Elwynn Forest", "pitch For warriors.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Horde", "levels 1-10", "zone Elwynn Forest", "next t/warrior when knows 100", "", "step Start", "  note Go on.", ""]);
	let n = compile_map(&[("main.guide", &main), ("warrior.guide", &follower)]);
	assert!(n.errors.is_empty(), "{}", n.text);
	assert_eq!(plain(&n.guide("t/main").get("nextWhen")), json!({ "t/warrior": [{ "k": "knows", "spell": 100 }] }));
	assert_eq!(format_for(&n.guides), MONEY_TASK_FORMAT);
}
