//! `label` and `along [until <label>]` step lines (docs/GUIDE_FORMAT.md, "Along the way"): parsed, checked
//! across the guide, emitted into Guides.lua, and a pack using either is written in format 4. Fixture data:
//! tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, FORMAT, WHEN_FORMAT};
use forge_guide::js::V;
use serde_json::Value;

fn steps_of(l: &[&str]) -> Vec<Value> {
	let r = compile(&guide_text(l));
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps()
}

fn errors_of(l: &[&str]) -> String {
	compile(&guide_text(l)).errors.join("\n")
}

#[test]
fn label_names_a_step_along_marks_one_along_the_way_with_or_without_until() {
	let steps = steps_of(&[
		"step Kill kobolds on the way",
		"  along until back",
		"  kill 6 x5",
		"step Look for candles",
		"  along",
		"  collect 750 x2",
		"step Travel",
		"  goto 47.6,35.1",
		"step Hand in",
		"  label back",
		"  accept 783",
	]);
	assert_eq!(steps[0]["along"], "back");
	assert_eq!(steps[1]["along"], true);
	assert!(steps[2].get("along").is_none());
	assert_eq!(steps[3]["label"], "back");
	assert!(steps[0].get("label").is_none());
}

#[test]
fn labels_take_letters_digits_dash_and_underscore_and_keep_their_case_keywords_are_case_insensitive() {
	let steps = steps_of(&["step A", "  ALONG UNTIL Camp_2", "  kill 6", "step B", "  Label Camp_2", "  accept 783"]);
	assert_eq!(steps[0]["along"], "Camp_2");
	assert_eq!(steps[1]["label"], "Camp_2");
	assert_match(&errors_of(&["step A", "  along until camp_2", "  kill 6", "step B", "  label Camp_2", "  accept 783"]), r#"unknown label "camp_2""#);
}

#[test]
fn malformed_and_repeated_lines_are_errors() {
	assert_match(&errors_of(&["step A", "  label", "  accept 783"]), r"`label` needs a name");
	assert_match(&errors_of(&["step A", "  label two words", "  accept 783"]), r"`label` needs a name");
	assert_match(&errors_of(&["step A", "  label \"camp\"", "  accept 783"]), r"`label` needs a name");
	assert_match(&errors_of(&["step A", "  label a.b", "  accept 783"]), r#"malformed label "a\.b""#);
	assert_match(&errors_of(&["step A", "  label x", "  label y", "  accept 783"]), r"duplicate `label` in step");
	assert_match(&errors_of(&["step A", "  along", "  along", "  kill 6"]), r"duplicate `along` in step");
	assert_match(&errors_of(&["step A", "  along later", "  kill 6"]), r"`along` takes nothing or `until <label>`");
	assert_match(&errors_of(&["step A", "  along until", "  kill 6"]), r"`along` takes nothing or `until <label>`");
	assert_match(&errors_of(&["step A", "  along -- on the way", "  kill 6"]), r"notes .* only allowed on goal lines");
}

#[test]
fn labels_are_guide_wide_a_duplicate_an_unknown_or_an_earlier_until_target_is_an_error_at_its_line() {
	let dup = guide_text(&["step A", "  label x", "  accept 783", "step B", "  kill 6", "  label x"]);
	let first = line_of(&dup, "label x");
	let second = dup.split('\n').enumerate().position(|(i, l)| i + 1 > first && l.trim() == "label x").unwrap() + 1;
	assert_match(&compile(&dup).errors.join("\n"), &format!(r#":{second}: duplicate label "x" \(first at line {first}\)"#));
	let unknown = guide_text(&["step A", "  along until nowhere", "  kill 6"]);
	assert_match(&compile(&unknown).errors.join("\n"), &format!(":{}: unknown label \"nowhere\"", line_of(&unknown, "along until nowhere")));
	assert_match(&errors_of(&["step A", "  label here", "  accept 783", "step B", "  along until here", "  kill 6"]), r"`along until here` must name a later step");
	assert_match(&errors_of(&["step A", "  label here", "  along until here", "  kill 6"]), r"`along until here` must name a later step");
}

#[test]
fn a_goal_polestar_checks_off_only_on_the_routes_own_step_warns_in_an_along_step() {
	let text = guide_text(&[
		"step McBride",
		"  accept 7",
		"step On the way",
		"  along until back",
		"  kill 6 x10 quest 7.1",
		"  collect 750 x2",
		"  goto 47.6,35.1",
		"  talk 197",
		"  kill 6 x3",
		"step Back",
		"  label back",
		"  accept 783",
	]);
	let r = compile(&text);
	assert!(r.errors.is_empty(), "{}", r.text);
	let warned: Vec<&String> = r.warnings.iter().filter(|w| w.contains("in an `along` step never checks off")).collect();
	let at = re(r":(\d+): ");
	let got: Vec<usize> = warned.iter().map(|w| at.captures(w).unwrap()[1].parse().unwrap()).collect();
	assert_eq!(got, vec![line_of(&text, "goto 47.6,35.1"), line_of(&text, "talk 197"), line_of(&text, "kill 6 x3")]);
	assert_match(warned[2], r"`kill` without `quest`.*until the step labelled back");
}

const HDR: [&str; 6] = ["guide mini/a", "title A", "faction Alliance", "levels 1-10", "zone Elwynn Forest", ""];

fn pack(l: &[&str]) -> (Vec<V>, std::collections::BTreeMap<String, String>) {
	let manifest = manifest_of(&pack_fixture("mini"));
	let data = fixture_data();
	let mut all = HDR.to_vec();
	all.extend_from_slice(l);
	let r = compile_files(&[("test.guide", &guide_text(&all))], &data, Some("mini"));
	assert!(r.errors.is_empty(), "{}", r.text);
	let files = pack_files(&r.guides, &manifest, &data);
	(r.guides, files)
}

#[test]
fn guides_lua_carries_them_in_order_title_note_label_only_when_along_goals() {
	let (_, files) = pack(&["step One", "  along until end", "  only Warrior", "  when level<5", "  tip Go", "  kill 6", "step Two", "  label end", "  accept 783"]);
	let lua = &files["Guides.lua"];
	assert_match(lua, r#"title = "One",\n\t+note = "Go",\n\t+only = \{ classes = \{ "WARRIOR" \} \},\n\t+when = \{ \{ k = "level", op = "<", n = 5 \} \},\n\t+along = "end",\n\t+goals = \{"#);
	assert_match(lua, r#"title = "Two",\n\t+label = "end",\n\t+goals = \{"#);
	assert_match(&pack(&["step One", "  along", "  kill 6", "step Two", "  accept 783"]).1["Guides.lua"], r"\n\t+along = true,\n");
}

#[test]
fn a_pack_using_label_or_along_is_written_in_format_4_one_without_stays_in_format_3() {
	assert_eq!(format_for(&pack(&["step One", "  label a", "  accept 783"]).0), WHEN_FORMAT);
	assert_eq!(format_for(&pack(&["step One", "  along", "  kill 6", "step Two", "  accept 783"]).0), WHEN_FORMAT);
	assert_eq!(format_for(&pack(&["step One", "  accept 783"]).0), FORMAT);
	let files = pack(&["step One", "  along", "  kill 6", "step Two", "  accept 783"]).1;
	assert_match(&files["Pack.lua"], r"format = 4,");
	assert!(file_ending(&files, ".toc").contains(&format!("## X-Polestar-Format: 4\n## X-Polestar-Needs: {}\n", needs(WHEN_FORMAT).unwrap())));
}
