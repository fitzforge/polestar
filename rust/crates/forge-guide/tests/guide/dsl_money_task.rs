//! The `money` and `task` goals and the `when money` predicate (docs/GUIDE_FORMAT.md): parsing and errors,
//! what the resolver writes and warns about, the emitted goals and the pack format they need. Fixture data:
//! tests/fixtures/dsl/data (Elwynn Forest, uiMapID 1429).

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, FORMAT, MONEY_TASK_FORMAT, WAIT_FORMAT, WHEN_FORMAT};
use forge_guide::js::parse_json;
use forge_guide::money::read_money;
use forge_guide::when::parse_when;
use serde_json::json;

#[test]
fn amounts_read_as_copper_1g50s_7s_25c_a_plain_number() {
	let got: Vec<Option<f64>> = ["1g50s", "7s", "25c", "350", "2g", "1s5c", "x", "", "1.5g"].iter().map(|s| read_money(s)).collect();
	assert_eq!(got, vec![Some(15000.0), Some(700.0), Some(25.0), Some(350.0), Some(20000.0), Some(105.0), None, None, None]);
}

#[test]
fn when_money_compares_the_characters_money_it_takes_no_bang() {
	assert_eq!(plain(&parse_when("money>=1s").ok().unwrap()), json!({ "k": "money", "op": ">=", "n": 100 }));
	assert_eq!(plain(&parse_when("money < 1g50s").ok().unwrap()), json!({ "k": "money", "op": "<", "n": 15000 }));
	assert_match(&parse_when("!money<1s").err().unwrap().error, r"takes no `!`");
	assert_match(&parse_when("money<lots").err().unwrap().error, r#"malformed amount "lots""#);
	assert_match(&parse_when("money=1s").err().unwrap().error, r"malformed `money` predicate");
}

#[test]
fn money_amount_and_task_text_parse_into_goals_a_task_can_have_a_place_and_be_optional() {
	let text = guide_text(&["step One", "  money 1s50c", "  task \"Logout skip on the ledge\" @45,60 optional", "  task Kill Gru'ark when he becomes hostile", "  accept 783"]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let g = plain(&ast.get("steps").at(0).get("goals"));
	assert_eq!([&g[0]["verb"], &g[0]["money"]], [&json!("money"), &json!(150)]);
	assert_eq!([&g[1]["verb"], &g[1]["text"], &g[1]["x"], &g[1]["y"], &g[1]["optional"]], [&json!("task"), &json!("Logout skip on the ledge"), &json!(45), &json!(60), &json!(true)]);
	assert_eq!([&g[2]["verb"], &g[2]["text"]], [&json!("task"), &json!("Kill Gru'ark when he becomes hostile")]);
}

#[test]
fn a_malformed_money_or_task_goal_is_an_error_at_its_line() {
	for (line, message) in [
		("  money", "malformed amount \"\" (expected copper or 1g50s / 7s / 25c)"),
		("  money lots", "malformed amount \"lots\" (expected copper or 1g50s / 7s / 25c)"),
		("  money 0", "malformed amount \"0\" (expected copper or 1g50s / 7s / 25c)"),
		("  task", "`task` needs text: task \"<what to do>\""),
	] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		assert_eq!(parse(&text).1, vec![format!("{}: {message}", line_of(&text, line))], "{line}");
	}
}

#[test]
fn the_resolver_writes_the_goals_and_the_predicate_for_the_engine_and_the_emitter_in_a_fixed_key_order() {
	let r = compile(&guide_text(&["step One", "  when money>=1s", "  money 2s", "  task \"Tame a Venomtail Scorpid\"", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let step = &r.steps()[0];
	assert_eq!(step["when"], json!([{ "k": "money", "op": ">=", "n": 100 }]));
	assert_eq!(step["goals"][0], json!({ "t": "money", "money": 200 }));
	assert_eq!(step["goals"][1], json!({ "t": "task", "text": "Tame a Venomtail Scorpid" }));
	let lua = emit(&r.guides);
	assert_match(&lua, r#"when = \{ \{ k = "money", op = ">=", n = 100 \} \},"#);
	assert_match(&lua, r#"\{ t = "money", money = 200 \},"#);
	assert_match(&lua, r#"\{ t = "task", text = "Tame a Venomtail Scorpid" \},"#);
}

#[test]
fn a_task_in_an_along_step_warns_polestar_checks_it_off_only_on_the_step_the_route_is_on() {
	let text = guide_text(&["step Along", "  along", "  task \"Pick up any Tough Wolf Meat\"", "  money 1s", "step Two", "  accept 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		r.warned("along"),
		vec![format!(
			"test.guide:{}: `task` in an `along` step never checks off: Polestar checks it only on the step the route is on, so it stays listed",
			line_of(&text, "task \"Pick up any Tough Wolf Meat\"")
		)]
	);
}

#[test]
fn a_pack_with_a_money_or_task_goal_or_a_when_money_predicate_is_written_in_format_5() {
	let guides = compile_pack_fixture("mini").guides;
	assert_eq!(format_for(&guides), FORMAT);
	for goal in [r#"{"t":"money","money":100}"#, r#"{"t":"task","text":"Do it"}"#] {
		let copy = with_first_step(&guides, |s| s.get("goals").push(parse_json(goal).unwrap()));
		assert_eq!(format_for(&copy), MONEY_TASK_FORMAT, "{goal}");
	}
	// `when money` also needs format 5
	let money = with_first_step(&guides, |s| s.set("when", parse_json(r#"[{"k":"money","op":">=","n":100}]"#).unwrap()));
	assert_eq!(format_for(&money), MONEY_TASK_FORMAT, "when money");
	// `when level` stays format 4
	let level = with_first_step(&guides, |s| s.set("when", parse_json(r#"[{"k":"level","op":">=","n":10}]"#).unwrap()));
	assert_eq!(format_for(&level), WHEN_FORMAT, "when level stays format 4");
}

#[test]
fn a_pack_with_a_wait_goal_is_written_in_format_9_which_an_older_polestar_refuses_as_too_new() {
	let guides = compile_pack_fixture("mini").guides;
	let copy = with_first_step(&guides, |s| s.get("goals").push(parse_json(r#"{"t":"wait","seconds":30}"#).unwrap()));
	assert_eq!(format_for(&copy), WAIT_FORMAT);
	assert_eq!(WAIT_FORMAT, 9);
	assert_eq!(needs(WAIT_FORMAT), Some("0.3.0"));
}
