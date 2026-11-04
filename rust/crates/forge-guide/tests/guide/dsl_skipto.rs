//! `skipto <label> when <predicate>` step lines and the `done <label>` predicate (docs/GUIDE_FORMAT.md,
//! "Jumps"): parsed, checked against the guide's labels, emitted into Guides.lua, and a pack using either is
//! written in format 5. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::format::{format_for, MONEY_TASK_FORMAT, WHEN_FORMAT};
use forge_guide::js::V;
use forge_guide::when::parse_when;
use serde_json::{json, Value};

fn steps_of(l: &[&str]) -> Vec<Value> {
	let r = compile(&guide_text(l));
	assert!(r.errors.is_empty(), "{}", r.text);
	r.steps()
}

fn errors_of(l: &[&str]) -> String {
	compile(&guide_text(l)).errors.join("\n")
}

#[test]
fn done_label_is_a_when_predicate_bang_turns_it_around() {
	assert_eq!(plain(&parse_when("done camp").ok().unwrap()), json!({ "k": "done", "label": "camp" }));
	assert_eq!(plain(&parse_when("!done Camp_2").ok().unwrap()), json!({ "k": "done", "neg": true, "label": "Camp_2" }));
	for bad in ["done", "done a.b", "done \"camp\"", "done two words"] {
		let e = parse_when(bad).err().unwrap_or_else(|| panic!("{bad}"));
		assert!(e.error.contains("`done` needs a step label"), "{bad}: {}", e.error);
	}
}

#[test]
fn skipto_lines_collect_on_their_step_in_order_each_with_its_label_and_one_predicate() {
	let steps = steps_of(&[
		"step A",
		"  accept 783",
		"  skipto end when turnedin 783",
		"  SKIPTO mid WHEN has 750 x2",
		"step B",
		"  kill 6",
		"step C",
		"  label mid",
		"  accept 7",
		"step D",
		"  label end",
		"  kill 6",
	]);
	assert_eq!(steps[0]["skipto"], json!([{ "to": "end", "when": { "k": "turnedin", "q": 783 } }, { "to": "mid", "when": { "k": "has", "item": 750, "n": 2 } }]));
	assert!(steps[1].get("skipto").is_none());
}

#[test]
fn a_done_label_may_name_any_step_of_the_guide_earlier_or_later() {
	let steps = steps_of(&[
		"step A",
		"  label camp",
		"  accept 783",
		"step B",
		"  when done camp",
		"  turnin 783",
		"step C",
		"  when !done later",
		"  skipto later when done camp",
		"  kill 6",
		"step D",
		"  label later",
		"  accept 7",
	]);
	assert_eq!(steps[1]["when"], json!([{ "k": "done", "label": "camp" }]));
	assert_eq!(steps[2]["when"], json!([{ "k": "done", "neg": true, "label": "later" }]));
	assert_eq!(steps[2]["skipto"], json!([{ "to": "later", "when": { "k": "done", "label": "camp" } }]));
}

#[test]
fn malformed_skipto_lines_and_unknown_or_earlier_labels_are_errors_at_their_line() {
	let usage = r"`skipto` needs a label and a predicate: skipto <label> when <predicate>";
	assert_match(&errors_of(&["step A", "  skipto", "  accept 783"]), usage);
	for bad in ["  skipto end", "  skipto end if level>2", "  skipto end when", "  skipto \"end\" when level>2"] {
		assert_match(&errors_of(&["step A", bad, "  accept 783", "step B", "  label end", "  kill 6"]), usage);
	}
	assert_match(&errors_of(&["step A", "  skipto a.b when level>2", "  accept 783"]), r#"malformed label "a\.b""#);
	assert_match(&errors_of(&["step A", "  skipto end when sometimes", "  accept 783", "step B", "  label end", "  kill 6"]), r#"`skipto`: unknown `when` predicate "sometimes""#);
	assert_match(&errors_of(&["step A", "  skipto end when level>2 -- go", "  accept 783", "step B", "  label end", "  kill 6"]), r"notes .* only allowed on goal lines");
	let unknown = guide_text(&["step A", "  skipto nowhere when level>2", "  accept 783"]);
	assert_match(&compile(&unknown).errors.join("\n"), &format!(":{}: unknown label \"nowhere\"", line_of(&unknown, "skipto nowhere when level>2")));
	assert_match(&errors_of(&["step A", "  label here", "  accept 783", "step B", "  skipto here when level>2", "  kill 6"]), r"`skipto here` must name a later step");
	assert_match(&errors_of(&["step A", "  label here", "  skipto here when level>2", "  kill 6"]), r"`skipto here` must name a later step");
	let done = guide_text(&["step A", "  when done nowhere", "  accept 783"]);
	assert_match(&compile(&done).errors.join("\n"), &format!(":{}: unknown label \"nowhere\"", line_of(&done, "when done nowhere")));
	assert_match(&errors_of(&["step A", "  skipto b when done nowhere", "  accept 783", "step B", "  label b", "  kill 6"]), r#"unknown label "nowhere""#);
}

#[test]
fn done_cannot_decide_a_next_option_the_options_are_listed_from_other_guides_too() {
	let text = lines(&["guide t/one", "title One", "faction Alliance", "levels 1-10", "zone Elwynn Forest", "next t/two when done camp", "", "step A", "  label camp", "  accept 783"]);
	assert_match(&compile(&text).errors.join("\n"), r"`done` checks a step of the guide being played: it cannot decide a `next` option");
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
fn guides_lua_carries_skipto_after_along_and_done_predicates_with_their_label() {
	let (_, files) = pack(&["step One", "  when !done end", "  skipto end when turnedin 783", "  skipto end when done end", "  kill 6", "step Two", "  label end", "  accept 783"]);
	assert_match(
		&files["Guides.lua"],
		r#"when = \{ \{ k = "done", neg = true, label = "end" \} \},\n\t+skipto = \{ \{ to = "end", when = \{ k = "turnedin", q = 783 \} \}, \{ to = "end", when = \{ k = "done", label = "end" \} \} \},\n\t+goals = \{"#,
	);
}

#[test]
fn a_pack_using_skipto_or_done_is_written_in_format_5_a_label_alone_stays_in_format_4() {
	assert_eq!(format_for(&pack(&["step One", "  skipto b when level>2", "  kill 6", "step Two", "  label b", "  accept 783"]).0), MONEY_TASK_FORMAT);
	assert_eq!(format_for(&pack(&["step One", "  label b", "  accept 783", "step Two", "  when done b", "  kill 6"]).0), MONEY_TASK_FORMAT);
	assert_eq!(format_for(&pack(&["step One", "  label b", "  accept 783"]).0), WHEN_FORMAT);
}
