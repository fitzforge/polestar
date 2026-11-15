//! A step's `backto` (docs/GUIDE_FORMAT.md, "Going back"): once the step is done, the route goes back to the
//! labelled step (its own or an earlier one) and the steps from there through it open again, while the
//! predicate holds. The line, its label and predicate checks, the emitted table, the import string and pack
//! format 11. The addon side is an addon test.

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, BACKTO_FORMAT, FORMAT};
use forge_guide::importstring::{decode_import, import_string, LIMITS};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const ROUND: [&str; 8] = ["step Take it", "  label round", "  accept 783", "step Hand it in", "  turnin 783", "  backto round when level<6", "step Then", "  task \"Go on\""];

fn v(j: Value) -> V {
	parse_json(&j.to_string()).unwrap()
}

#[test]
fn backto_names_this_step_or_an_earlier_one_with_or_without_a_predicate() {
	let r = compile(&guide_text(&ROUND));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.steps()[1]["backto"], json!({ "to": "round", "when": { "k": "level", "op": "<", "n": 6 } }));
	assert!(emit(&r.guides).contains("\t\t\t\t\tbackto = { to = \"round\", when = { k = \"level\", op = \"<\", n = 6 } },\n"));
	let bare = compile(&guide_text(&["step A", "  label a", "  accept 783", "  backto a"]));
	assert!(bare.errors.is_empty(), "{}", bare.text);
	assert_eq!(bare.steps()[0]["backto"], json!({ "to": "a" }));
	assert!(emit(&bare.guides).contains("\t\t\t\t\tbackto = { to = \"a\" },\n"));
}

#[test]
fn a_label_that_is_missing_or_on_a_later_step_a_second_backto_and_a_malformed_line_are_errors() {
	let ahead = guide_text(&["step A", "  backto b", "  accept 783", "step B", "  label b", "  turnin 783"]);
	assert_eq!(
		compile(&ahead).errors,
		[format!("test.guide:{}: `backto b` must name this step or an earlier one (the label is on line {}); `skipto` jumps ahead", line_of(&ahead, "backto b"), line_of(&ahead, "label b"))]
	);
	let unknown = guide_text(&["step A", "  backto nowhere", "  accept 783"]);
	assert_eq!(compile(&unknown).errors, [format!("test.guide:{}: unknown label \"nowhere\"", line_of(&unknown, "backto nowhere"))]);
	for bad in ["  backto", "  backto a b", "  backto a when", "  backto \"a\"", "  backto a! when level<6", "  backto a when group 783", "  backto a when nonsense"] {
		assert!(!compile(&guide_text(&["step A", "  label a", bad, "  accept 783"])).errors.is_empty(), "{bad}");
	}
	assert!(compile(&guide_text(&["step A", "  label a", "  backto a", "  backto a", "  accept 783"])).errors.iter().any(|e| e.contains("a second `backto`")));
}

#[test]
fn backto_is_not_for_an_along_step_and_its_when_done_names_a_label_of_the_guide() {
	let along = guide_text(&["step A", "  label a", "  accept 783", "step On the way", "  along until b", "  backto a", "  kill 6", "step B", "  label b", "  turnin 783"]);
	let want = format!("test.guide:{}: an `along` step is never the step the route is at", line_of(&along, "backto a"));
	assert!(compile(&along).errors.iter().any(|e| e.starts_with(&want)));
	let done = guide_text(&["step A", "  label a", "  accept 783", "  backto a when !done nowhere"]);
	assert_eq!(compile(&done).errors, [format!("test.guide:{}: unknown label \"nowhere\"", line_of(&done, "backto a when !done nowhere"))]);
	let ok = compile(&guide_text(&["step A", "  label a", "  accept 783", "step B", "  label b", "  task \"Once\"", "step C", "  turnin 783", "  backto a when !done b"]));
	assert!(ok.errors.is_empty(), "{}", ok.text);
}

#[test]
fn a_guide_with_a_backto_step_is_written_in_format_11_read_by_polestar_0_4_1_and_later() {
	assert_eq!((BACKTO_FORMAT, needs(BACKTO_FORMAT)), (11, Some("0.4.1")));
	assert_eq!(format_for(&compile(&guide_text(&ROUND)).guides), BACKTO_FORMAT);
	assert_eq!(format_for(&compile(&guide_text(&["step A", "  label a", "  accept 783", "  backto a"])).guides), BACKTO_FORMAT, "with no predicate too");
	assert_eq!(format_for(&compile(&guide_text(&["step A", "  accept 783"])).guides), FORMAT);
}

#[test]
fn an_import_string_carries_a_backto_and_counts_the_quests_of_its_predicate_against_the_cap_the_addon_reads() {
	let manifest = v(json!({ "id": "yendi", "license": "MIT" }));
	let guide = |when: Value| {
		let mut backto = json!({ "to": "a" });
		if !when.is_null() {
			backto["when"] = when;
		}
		v(json!({ "id": "yendi/round", "title": "Round", "steps": [{ "label": "a", "backto": backto, "goals": [{ "t": "level", "level": 2 }] }] }))
	};
	let (text, _) = import_string(&guide(json!({ "k": "onquest", "q": [7, 783] })), &manifest, None).unwrap();
	let read = decode_import(&text).unwrap();
	assert_eq!(plain(&read.get("format")), json!(BACKTO_FORMAT));
	assert_eq!(plain(&read.get("guide").get("steps").at(0).get("backto")), json!({ "to": "a", "when": { "k": "onquest", "q": [7, 783] } }));
	let (bare, _) = import_string(&guide(Value::Null), &manifest, None).unwrap();
	assert_eq!(plain(&decode_import(&bare).unwrap().get("guide").get("steps").at(0).get("backto")), json!({ "to": "a" }));
	let quests: Vec<usize> = (1..=LIMITS.pre + 1).collect();
	let error = import_string(&guide(json!({ "k": "onquest", "q": quests })), &manifest, None).unwrap_err();
	assert!(error.contains("yendi/round: guide.steps[1].backto.when.q has "), "{error}");
}
