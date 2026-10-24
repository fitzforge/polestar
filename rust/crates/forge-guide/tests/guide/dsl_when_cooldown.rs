//! `when cooldown item <item>` and `when cooldown spell <spell>` on a step (docs/GUIDE_FORMAT.md,
//! "Conditions checked during play"): the step applies while the item or spell is on cooldown. The
//! parser's predicate and errors, the resolver's item check, the emitted table and the pack format.
//! Fixture data: tests/fixtures/dsl/data (6948, the Hearthstone, is in its items).

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn when_cooldown_parses_an_item_or_a_spell_with_or_without_bang() {
	let text = guide_text(&["step One", "  when !cooldown item 6948", "  when cooldown SPELL 8690", "  accept 783"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	assert_eq!(
		plain(&ast.get("steps").at(0).get("when")),
		json!([
			{ "k": "cooldown", "neg": true, "item": 6948, "line": line_of(&text, "when !cooldown item 6948") },
			{ "k": "cooldown", "spell": 8690, "line": line_of(&text, "when cooldown SPELL 8690") },
		])
	);
}

#[test]
fn when_cooldown_without_item_or_spell_and_one_id_is_an_error_at_its_line() {
	for line in ["  when cooldown", "  when cooldown 6948", "  when cooldown item", "  when cooldown item 0", "  when cooldown item 6948 2", "  when !cooldown quest 783"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: `cooldown` needs an item or spell id: cooldown item <item> or cooldown spell <spell>", line_of(&text, line))], "{line}");
	}
}

#[test]
fn an_item_not_in_the_data_warns_as_for_has_a_spell_is_taken_as_written() {
	let text = guide_text(&["step One", "  when cooldown item 6948", "  when !cooldown item 99999", "  when cooldown spell 8690", "  accept 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(plain(&r.guides[0].get("steps"))[0]["when"], json!([{ "k": "cooldown", "item": 6948 }, { "k": "cooldown", "neg": true, "item": 99999 }, { "k": "cooldown", "spell": 8690 }]));
	assert_eq!(r.warned("not in data"), vec![format!("test.guide:{}: item 99999 is not in data (new Forever content?)", line_of(&text, "when !cooldown item 99999"))]);
}

#[test]
fn a_step_that_asks_for_a_cooldown_and_its_bang_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when cooldown item 6948", "  when !cooldown item 6948", "  accept 783"]);
	let r = compile(&text);
	let want = format!("test.guide:{}: the step asks for `cooldown` and `!cooldown` of the same item: no character sees it", line_of(&text, "when cooldown item 6948"));
	assert!(r.warnings.contains(&want), "{}", r.text);
}

#[test]
fn the_emitted_predicate_carries_the_item_or_spell_and_the_pack_is_written_in_format_5() {
	let r = compile(&guide_text(&["step One", "  when !cooldown item 6948", "  when cooldown spell 8690", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "cooldown", neg = true, item = 6948 \}, \{ k = "cooldown", spell = 8690 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}
