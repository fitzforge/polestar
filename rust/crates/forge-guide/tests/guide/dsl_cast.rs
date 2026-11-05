//! `cast <spellId> ["Name"]` (docs/GUIDE_FORMAT.md, "Goals"): the player casts that spell while the goal
//! is open. The parser's goal and its errors, the name from the professions data (a recipe) or the
//! author's, the emitted table and the pack format. Fixture data: tests/fixtures/dsl/data (3275, Linen
//! Bandage, is a First Aid recipe in its professions).

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn cast_takes_a_spell_id_and_an_optional_quoted_name() {
	let (ast, errors) = parse(&guide_text(&["step Fire", "  cast 818 \"Basic Campfire\"", "step Bandage", "  cast 3275"]));
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!([&s[0]["goals"][0]["verb"], &s[0]["goals"][0]["spell"], &s[0]["goals"][0]["spellName"]], [&json!("cast"), &json!(818), &json!("Basic Campfire")]);
	assert_eq!([&s[1]["goals"][0]["spell"], &s[1]["goals"][0]["spellName"]], [&json!(3275), &json!(null)]);
}

#[test]
fn cast_without_a_spell_id_is_an_error_at_its_line() {
	let text = guide_text(&["step One", "  cast", "  note Go on."]);
	assert_eq!(parse(&text).1, vec![format!("{}: `cast` needs a spell id", line_of(&text, "cast"))]);
}

#[test]
fn the_name_comes_from_the_professions_data_else_the_author_a_spell_in_neither_is_an_error() {
	let text = guide_text(&["step A", "  cast 3275", "step B", "  cast 18960 \"Teleport: Moonglade\"", "step C", "  cast 18960"]);
	let r = compile(&text);
	// Step C's goal is the line after its header.
	assert_eq!(r.errors, vec![format!("test.guide:{}: spell 18960 is not in data; give its name: `cast 18960 \"Name\"`", line_of(&text, "step C") + 1)]);
	let ok = compile(&guide_text(&["step A", "  cast 3275", "step B", "  cast 18960 \"Teleport: Moonglade\""]));
	assert!(ok.errors.is_empty(), "{}", ok.text);
	assert_eq!(first_goals(&ok), vec![json!({ "t": "cast", "spell": 3275, "spellName": "Linen Bandage" }), json!({ "t": "cast", "spell": 18960, "spellName": "Teleport: Moonglade" })]);
}

#[test]
fn the_emitted_goal_carries_the_spell_and_its_name_and_the_pack_is_written_in_format_5() {
	let r = compile(&guide_text(&["step A", "  cast 818 \"Basic Campfire\""]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\{ t = "cast", spell = 818, spellName = "Basic Campfire" \}"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}
