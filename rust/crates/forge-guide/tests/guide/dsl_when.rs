//! `when` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the parser's predicates and
//! errors, what the resolver fills in from the data and warns about, the emitted table and the pack format it
//! needs. Fixture data: tests/fixtures/dsl/data (Elwynn Forest, uiMapID 1429).

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, FORMAT, WHEN_FORMAT};
use forge_guide::js::parse_json;
use serde_json::json;

#[test]
fn every_predicate_parses_one_per_when_line_each_with_its_line_a_step_without_when_has_none() {
	let text = guide_text(&[
		"step Conditional",
		"  when level<6",
		"  when level >= 2",
		"  when onquest 783, 7",
		"  when !onquest 33",
		"  when complete 7",
		"  when !turnedin 783",
		"  when available 9200",
		"  when has 159 x5",
		"  when !has 750",
		"  when zone \"Elwynn Forest\"",
		"  when !subzone Goldshire",
		"  when bound \"Goldshire\"",
		"  turnin 783",
		"step Plain",
		"  accept 7",
	]);
	let (ast, errors) = parse(&text);
	assert!(errors.is_empty(), "{errors:?}");
	let l = |s: &str| line_of(&text, s);
	let steps = plain(&ast)["steps"].clone();
	assert_eq!(
		steps[0]["when"],
		json!([
			{ "k": "level", "op": "<", "n": 6, "line": l("when level<6") },
			{ "k": "level", "op": ">=", "n": 2, "line": l("when level >= 2") },
			{ "k": "onquest", "q": [783, 7], "line": l("when onquest 783, 7") },
			{ "k": "onquest", "neg": true, "q": [33], "line": l("when !onquest 33") },
			{ "k": "complete", "q": 7, "line": l("when complete 7") },
			{ "k": "turnedin", "neg": true, "q": 783, "line": l("when !turnedin 783") },
			{ "k": "available", "q": 9200, "line": l("when available 9200") },
			{ "k": "has", "item": 159, "n": 5, "line": l("when has 159 x5") },
			{ "k": "has", "neg": true, "item": 750, "n": 1, "line": l("when !has 750") },
			{ "k": "zone", "name": "Elwynn Forest", "line": l("when zone \"Elwynn Forest\"") },
			{ "k": "subzone", "neg": true, "name": "Goldshire", "line": l("when !subzone Goldshire") },
			{ "k": "bound", "name": "Goldshire", "line": l("when bound \"Goldshire\"") },
		])
	);
	assert!(steps[1].get("when").is_none());
}

#[test]
fn a_malformed_when_is_an_error_at_its_line_and_the_step_keeps_its_other_lines() {
	for (line, message) in [
		("  when", "`when` needs a predicate"),
		("  when !level<5", "`level` takes no `!`: turn the comparison around (`level>=10` for \"not below 10\")"),
		("  when level=5", "malformed `level` predicate (expected level<N, level<=N, level>N or level>=N)"),
		("  when level<70", "level 70 is out of range (1-60)"),
		("  when onquest", "`onquest` needs quest ids: onquest <quest>[,<quest>...]"),
		("  when complete 7,8", "`complete` needs one quest id: complete <quest>"),
		("  when has x5", "`has` needs an item id: has <item> [xN]"),
		("  when has 159 x0", "`has` needs a count of 1 or more"),
		("  when zone", "`zone` needs a name: zone \"<Name>\""),
		("  when weather<1s", "unknown `when` predicate \"weather<1s\""),
	] {
		let text = guide_text(&["step One", line, "  accept 783"]);
		let (ast, errors) = parse(&text);
		assert_eq!(errors, vec![format!("{}: {message}", line_of(&text, line))], "{line}");
		assert_eq!(ast.get("steps").at(0).get("goals").len(), 1);
	}
}

#[test]
fn the_resolver_keeps_the_predicates_for_the_engine_available_with_what_an_accept_waits_on_a_zone_with_its_area() {
	let r = compile(&guide_text(&[
		"step One",
		"  accept 783",
		"step Two",
		"  when onquest 783,7",
		"  when available 7",
		"  when !has 159 x2",
		"  when zone \"Elwynn Forest\"",
		"  when level<=5",
		"  turnin 783",
	]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let steps = r.steps();
	assert!(steps[0].get("when").is_none());
	assert_eq!(
		steps[1]["when"],
		json!([
			{ "k": "onquest", "q": [783, 7] },
			{ "k": "available", "q": 7, "minLevel": 1, "pre": [783] },
			{ "k": "has", "neg": true, "item": 159, "n": 2 },
			{ "k": "zone", "name": "Elwynn Forest", "area": 12 },
			{ "k": "level", "op": "<=", "n": 5 },
		])
	);
}

#[test]
fn the_resolver_warns_about_ids_the_data_lacks_a_zone_the_game_never_names_and_a_step_no_character_sees() {
	let text = guide_text(&[
		"step One",
		"  when onquest 424242",
		"  when has 777777",
		"  when zone \"Elwynnn Forest\"",
		"  accept 783",
		"step Two",
		"  when level>=20",
		"  accept 7",
		"step Three",
		"  when onquest 7",
		"  when !onquest 7",
		"  accept 33",
	]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	let at = |s: &str| format!("test.guide:{}: ", line_of(&text, s));
	// The accepts' own warnings (never turned in) are not this test's.
	let when_lines: Vec<String> = text.split('\n').enumerate().filter(|(_, l)| l.trim().starts_with("when ")).map(|(i, _)| format!("test.guide:{}: ", i + 1)).collect();
	let got: Vec<String> = r.warnings.iter().filter(|w| when_lines.iter().any(|p| w.starts_with(p))).cloned().collect();
	assert_eq!(
		got,
		vec![
			format!("{}quest 424242 is not in data (new Forever content?)", at("when onquest 424242")),
			format!("{}item 777777 is not in data (new Forever content?)", at("when has 777777")),
			format!("{}zone \"Elwynnn Forest\" is not in zones.json: the game never reports that zone name, so the predicate never holds there", at("when zone \"Elwynnn Forest\"")),
			format!("{}the step's `when level` never holds for this guide's levels (1-10): no character sees the step", at("when level>=20")),
			format!("{}the step asks for `onquest` and `!onquest` of the same quest: no character sees it", at("when onquest 7")),
		]
	);
}

#[test]
fn a_step_with_when_onquest_q_or_when_complete_q_hands_q_in_without_an_accept_in_the_chain() {
	for guard in ["when onquest 783", "when onquest 7, 783", "when complete 783"] {
		let r = compile(&guide_text(&["step Hand it in if you have it", &format!("  {guard}"), "  turnin 783"]));
		assert!(r.errors.is_empty(), "{guard}\n{}", r.text);
	}
	// Negated, or for another quest, it is no stand-in.
	for guard in ["when !onquest 783", "when onquest 7"] {
		let r = compile(&guide_text(&["step Hand it in", &format!("  {guard}"), "  turnin 783"]));
		assert_eq!(r.errors.len(), 1, "{guard}");
		assert_match(&r.errors[0], r"turnin` for quest 783 that is never accepted earlier");
	}
}

#[test]
fn a_turnin_after_accepts_only_in_steps_with_when_warns_one_with_a_guard_of_its_own_or_an_unconditional_accept_does_not() {
	let lines = |turnin: &[&str]| {
		let mut l = vec!["step One", "  when level<3", "  accept 783", "step Two"];
		l.extend_from_slice(turnin);
		guide_text(&l)
	};
	let warned = |r: &Compiled| r.warned("accepted earlier only in steps with `when`");
	let text = lines(&["  turnin 783"]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(
		warned(&r),
		vec![format!("test.guide:{}: `turnin` for quest 783 (A Threat Within), which is accepted earlier only in steps with `when`: characters who pass those steps never see this turn-in. Give it the same `when` or a `when onquest 783`", line_of(&text, "  turnin 783"))]
	);
	assert!(warned(&compile(&lines(&["  when onquest 783", "  turnin 783"]))).is_empty());
	assert!(warned(&compile(&lines(&["  when level<3", "  turnin 783"]))).is_empty());
	assert!(warned(&compile(&lines(&["  accept 783", "  turnin 783"]))).is_empty());
}

#[test]
fn the_emitted_step_carries_when_before_its_goals_in_a_fixed_key_order() {
	let r = compile(&guide_text(&["step Two", "  when !onquest 783,7", "  when has 159 x2", "  when level<6", "  accept 783"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_match(
		&emit(&r.guides),
		r#"\n\t\t\t\t\twhen = \{ \{ k = "onquest", neg = true, q = \{ 783, 7 \} \}, \{ k = "has", n = 2, item = 159 \}, \{ k = "level", op = "<", n = 6 \} \},\n\t\t\t\t\tgoals = \{"#,
	);
}

#[test]
fn a_pack_is_written_in_format_4_only_when_a_step_of_its_guides_has_when() {
	let mini = pack_fixture("mini");
	let manifest = manifest_of(&mini);
	let data = fixture_data();
	let guides = compile_pack_fixture("mini").guides;
	assert_eq!(format_for(&guides), FORMAT);
	guides[0].get("steps").at(0).set("when", parse_json(r#"[{"k":"level","op":"<","n":6}]"#).unwrap());
	assert_eq!(format_for(&guides), WHEN_FORMAT);
	let files = pack_files(&guides, &manifest, &data);
	let folder = manifest.get("folder").to_js_string();
	assert_match(&files[&format!("{folder}.toc")], &format!(r"(?m)^## X-Polestar-Format: {WHEN_FORMAT}\n## X-Polestar-Needs: {}$", needs(WHEN_FORMAT).unwrap().replace('.', r"\.")));
	assert_match(&files["Pack.lua"], &format!("format = {WHEN_FORMAT},"));
}
