//! `when upgrade <item>` on a step (docs/GUIDE_FORMAT.md, "Gear upgrades"): the step is for characters
//! Polestar's gear advice says the item would help. The parser's predicate and errors, the resolver's item
//! check and contradiction warning, the emitted table and the pack format. Fixture data:
//! tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT};
use serde_json::json;

#[test]
fn when_upgrade_and_when_not_upgrade_parse_with_one_item_id() {
	let text = guide_text(&["step With", "  when upgrade 750", "  accept 783", "step Without", "  when !upgrade 750", "  accept 7"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let s = plain(&ast)["steps"].clone();
	assert_eq!(s[0]["when"], json!([{ "k": "upgrade", "item": 750, "line": line_of(&text, "when upgrade 750") }]));
	assert_eq!(s[1]["when"], json!([{ "k": "upgrade", "neg": true, "item": 750, "line": line_of(&text, "when !upgrade 750") }]));
}

#[test]
fn when_upgrade_without_one_item_id_is_an_error_at_its_line() {
	for line in ["  when upgrade", "  when !upgrade", "  when upgrade 0", "  when upgrade 750 x2", "  when upgrade 750,159", "  when upgrade sword"] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		let (ast, errors) = parse(&text);
		assert_eq!(errors, vec![format!("{}: `upgrade` needs one item id: upgrade <item>", line_of(&text, line))], "{line}");
		assert_eq!(ast.get("steps").at(0).get("goals").len(), 1);
	}
}

#[test]
fn the_resolver_keeps_the_item_and_warns_about_one_the_data_does_not_know() {
	let text = guide_text(&["step One", "  when upgrade 750", "  accept 783", "step Two", "  when !upgrade 777777", "  turnin 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	assert_eq!(steps[0]["when"], json!([{ "k": "upgrade", "item": 750 }]));
	assert_eq!(steps[1]["when"], json!([{ "k": "upgrade", "neg": true, "item": 777777 }]));
	assert_eq!(r.warned("not in data"), vec![format!("test.guide:{}: item 777777 is not in data (new Forever content?)", line_of(&text, "when !upgrade 777777"))]);
}

#[test]
fn a_step_that_asks_for_upgrade_and_not_upgrade_of_the_same_item_warns_that_no_character_sees_it() {
	let text = guide_text(&["step One", "  when upgrade 750", "  when !upgrade 750", "  accept 783"]);
	let r = compile(&text);
	assert!(r.warnings.contains(&format!("test.guide:{}: the step asks for `upgrade` and `!upgrade` of the same item: no character sees it", line_of(&text, "when upgrade 750"))), "{}", r.text);
}

#[test]
fn the_emitted_predicate_carries_the_item_and_the_pack_is_written_in_format_5() {
	let r = compile(&guide_text(&["step One", "  when !upgrade 750", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(&emit(&r.guides), r#"\n\t\t\t\t\twhen = \{ \{ k = "upgrade", neg = true, item = 750 \} \},\n"#);
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}

#[test]
fn next_id_when_upgrade_resolves_the_same_way_and_needs_format_5() {
	let follower = lines(&["guide t/geared", "title Geared", "faction Alliance", "levels 10-20", "zone Elwynn Forest", "pitch With the item.", "", "step Start", "  note Go on.", ""]);
	let main = lines(&["guide t/main", "title Main", "faction Alliance", "levels 1-10", "zone Elwynn Forest", "next t/geared when !upgrade 750", "", "step Start", "  note Go on.", ""]);
	let r = compile_map(&[("main.guide", &main), ("geared.guide", &follower)]);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(plain(&r.guide("t/main").get("nextWhen")), json!({ "t/geared": [{ "k": "upgrade", "neg": true, "item": 750 }] }));
	assert_eq!(format_for(&r.guides), MONEY_TASK_FORMAT);
}
