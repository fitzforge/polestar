//! The `abandon` and `destroy` goals (docs/GUIDE_FORMAT.md): parsing, resolving, emitting and the pack
//! format they need. Fixture data: tests/fixtures/dsl/data (Elwynn Forest, uiMapID 1429).

use crate::common;
use common::*;
use forge_guide::format::{format_for, FORMAT, MONEY_TASK_FORMAT};
use forge_guide::js::V;
use forge_guide::project::compile_project;
use serde_json::json;

#[test]
fn abandon_and_destroy_parse_into_goals_a_missing_or_malformed_id_is_an_error_at_its_line() {
	let (ast, errors) = parse(&guide_text(&["step One", "  abandon 783 \"A Threat Within\"", "  destroy 159 \"Refreshing Spring Water\" optional"]));
	assert!(errors.is_empty(), "{errors:?}");
	let goals = plain(&ast.get("steps").at(0).get("goals"));
	assert_eq!([&goals[0]["verb"], &goals[0]["quest"], &goals[0]["title"]], [&json!("abandon"), &json!(783), &json!("A Threat Within")]);
	assert_eq!([&goals[1]["verb"], &goals[1]["item"], &goals[1]["itemName"], &goals[1]["optional"]], [&json!("destroy"), &json!(159), &json!("Refreshing Spring Water"), &json!(true)]);
	for (line, message) in [("  abandon x", "malformed quest id \"x\""), ("  destroy", "`destroy` needs an item id")] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: {message}", line_of(&text, line))], "{line}");
	}
}

#[test]
fn the_resolver_takes_titles_and_names_from_data_lint_takes_an_abandon_as_the_end_of_the_quest_and_the_emitter_writes_both_goals() {
	let r = compile(&guide_text(&["step One", "  accept 783", "  abandon 783", "  destroy 159"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(r.warned("never turned in").is_empty(), "an abandon ends the quest like a turn-in");
	let goals = plain(&r.guides[0].get("steps").at(0))["goals"].clone();
	assert_eq!([&goals[1]["t"], &goals[1]["quest"]], [&json!("abandon"), &json!(783)]);
	assert!(goals[1]["title"].as_str().is_some_and(|t| !t.is_empty()));
	assert_eq!([&goals[2]["t"], &goals[2]["item"], &goals[2]["itemName"]], [&json!("destroy"), &json!(159), &json!("Refreshing Spring Water")]);
	let lua = emit(&r.guides);
	assert_match(&lua, r#"\{ t = "abandon", quest = 783, title = "[^"]+" \},"#);
	assert_match(&lua, r#"\{ t = "destroy", item = 159, itemName = "Refreshing Spring Water" \},"#);
}

#[test]
fn a_pack_with_an_abandon_or_destroy_goal_is_written_in_format_5() {
	let mini = pack_fixture("mini");
	let (manifest, _) = forge_guide::manifest::read_manifest(&mini, false);
	let manifest = manifest.unwrap();
	let data = fixture_data();
	let p = compile_project(&mini, &manifest, &data, forge_guide::diag::Diagnostics::new(), false, None);
	assert_eq!(format_for(&p.guides), FORMAT);
	let copy: Vec<V> = p.guides.iter().map(V::json_clone).collect();
	copy[0].get("steps").at(0).get("goals").push(forge_guide::js::parse_json(r#"{"t":"destroy","item":159,"itemName":"Water"}"#).unwrap());
	assert_eq!(format_for(&copy), MONEY_TASK_FORMAT);
}
