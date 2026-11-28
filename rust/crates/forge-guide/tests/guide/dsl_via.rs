//! Steps of places only (#4467, docs/GUIDE_FORMAT.md "Steps of places only"): in a leveling guide a step whose
//! goals are only gotos, a flight or `enter` compiles `via = true`, a hidden hint on the way to the step after it,
//! and `keep <kind> <reason>` keeps one a step of its own (`keep = "<kind>"`). The Rust side of tests/dsl-via.test.js.
//! Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::emit::emit_guides;
use forge_guide::js::{Obj, V};
use serde_json::{json, Value};

fn text(lines: &[&str], category: Option<&str>) -> String {
	let mut all = vec!["guide t/main", "title Test", "faction Alliance", "levels 1-10", "zone Elwynn Forest"];
	let cat = category.map(|c| format!("category {c}"));
	if let Some(c) = &cat {
		all.push(c);
	}
	all.push("");
	all.extend_from_slice(lines);
	format!("{}\n", all.join("\n"))
}

const ROUTE: [&str; 11] = [
	"step Into Goldshire",
	"  tip Follow the road south.",
	"  goto 42.1,65.9 \"Goldshire\"",
	"step Smith Argus",
	"  goto 41.7,65.5",
	"  accept 7",
	"step The mine door",
	"  keep door the walking maps have no way into the mine: its mouth first",
	"  goto 39.5,82.4 \"Fargodeep Mine\"",
	"step Kobolds",
	"  kill 6",
];

fn marks(r: &Compiled) -> Vec<(Value, Value)> {
	r.steps().iter().map(|s| (s.get("via").cloned().unwrap_or(Value::Null), s.get("keep").cloned().unwrap_or(Value::Null))).collect()
}

#[test]
fn a_leveling_step_of_places_only_compiles_as_a_via_one_with_work_or_kept_stays_a_step() {
	let r = compile(&text(&ROUTE, None));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(marks(&r), vec![(json!(true), Value::Null), (Value::Null, Value::Null), (Value::Null, json!("door")), (Value::Null, Value::Null)]);
	assert_eq!(r.steps()[0]["goals"][0]["t"], json!("goto"));
	let entries: Vec<V> = r
		.guides
		.iter()
		.map(|g| {
			let o = Obj::new();
			o.set("guide", g.clone());
			V::Obj(o)
		})
		.collect();
	let lua = emit_guides(&entries, false);
	assert!(lua.contains("title = \"Into Goldshire\",\n\t\t\t\t\tnote = \"Follow the road south.\",\n\t\t\t\t\tvia = true,"), "{lua}");
	assert!(lua.contains("keep = \"door\","), "{lua}");
}

#[test]
fn a_trailing_run_of_steps_of_places_only_stays_as_written_the_guide_ends_there() {
	let vias = |r: &Compiled| -> Vec<Value> { r.steps().iter().map(|s| s.get("via").cloned().unwrap_or(Value::Null)).collect() };
	let r = compile(&text(
		&["step Into Goldshire", "  goto 42.1,65.9 \"Goldshire\"", "step Smith Argus", "  goto 41.7,65.5", "  accept 7", "step The road west", "  goto 30.0,60.0", "step Westfall", "  goto 10.0,60.0"],
		None,
	));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(vias(&r), vec![json!(true), Value::Null, Value::Null, Value::Null]);
	// A pack made only of places (the `polestar new` template's kind) keeps every step.
	let places = compile(&text(&["step A", "  goto 42.1,65.9", "step B", "  goto 41.7,65.5"], None));
	assert_eq!(vias(&places), vec![Value::Null, Value::Null]);
}

#[test]
fn other_categories_keep_every_step_as_written_and_say_so_of_a_keep() {
	let r = compile(&text(&ROUTE, Some("Class")));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert!(marks(&r).iter().all(|m| *m == (Value::Null, Value::Null)), "{:?}", marks(&r));
	assert_eq!(r.warned("`keep` is for a leveling guide's step of places only").len(), 1, "{}", r.text);
}

#[test]
fn keep_needs_a_known_kind_and_a_reason_and_only_fits_a_step_of_places_only() {
	let errs = |line: &str| compile(&text(&["step A", line, "  goto 42.1,65.9", "step B", "  kill 6"], None)).errors.join("\n");
	assert!(errs("  keep").contains("`keep` needs a kind: door, instance, boarding, phasing, safety"));
	assert!(errs("  keep shortcut it is quicker").contains("`keep` needs a kind"));
	assert!(errs("  keep door").contains("`keep door` needs its reason"));
	assert!(compile(&text(&["step A", "  keep door a", "  keep door b", "  goto 42.1,65.9"], None)).errors.join("\n").contains("duplicate `keep` in step"));
	let r = compile(&text(&["step A", "  keep door the smith is inside", "  goto 41.7,65.5", "  accept 7"], None));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.warned("`keep` is for a step of places only").len(), 1, "{}", r.text);
	assert_eq!(r.steps()[0].get("keep"), None);
}
