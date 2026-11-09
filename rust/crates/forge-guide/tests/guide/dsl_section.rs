//! `section <Profession> <from>-<to>` (docs/GUIDE_FORMAT.md, "Sections"): a profession guide's skill range as a
//! heading over the steps after it. Parsed in column 0, resolved to the profession's skill line, emitted as the
//! guide's `sections` and each step's `section`; a `craft … until` carries its recipe's skill-up colours for the
//! engine's materials count. Fixture data: tests/fixtures/dsl/data.

use crate::common;
use common::*;
use forge_guide::emit::emit_guides;
use forge_guide::js::{Obj, V};
use serde_json::json;

const HEAD: [&str; 6] = ["guide t/first-aid", "title First Aid", "category Professions", "levels 1-60", "zone Elwynn Forest", ""];

fn text(l: &[&str]) -> String {
	let mut all = HEAD.to_vec();
	all.extend_from_slice(l);
	format!("{}\n", all.join("\n"))
}

#[test]
fn sections_head_the_steps_after_them_with_the_profession_s_skill_line() {
	let r = compile(&text(&[
		"step Learn",
		"  train First Aid Apprentice",
		"section First Aid 1-40",
		"",
		"step Cloth",
		"  collect 2589 x41 @40,50",
		"step Linen",
		"  craft 3275 until 40",
		"section \"First Aid\" 40-50",
		"step Heavy",
		"  learn 3276",
		"  craft 3276 until 50",
	]));
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	let g = plain(&r.guides[0]);
	assert_eq!(
		g["sections"],
		json!([{ "skill": "First Aid", "skillLine": 129, "from": 1, "to": 40 }, { "skill": "First Aid", "skillLine": 129, "from": 40, "to": 50 }])
	);
	let secs: Vec<_> = r.steps().iter().map(|s| s.get("section").cloned().unwrap_or(json!(null))).collect();
	assert_eq!(secs, vec![json!(null), json!(1), json!(1), json!(2)]);
	// The until craft's colours, from professions.json (Linen Bandage: yellow 30, grey 60).
	let linen = &r.steps()[2]["goals"][0];
	assert_eq!((linen["yellow"].clone(), linen["grey"].clone()), (json!(30), json!(60)));
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
	assert!(lua.contains("sections = { { skill = \"First Aid\", skillLine = 129, from = 1, to = 40 }"), "{lua}");
	assert!(lua.contains("section = 2,"), "{lua}");
	assert!(lua.contains("untilSkill = 40, yellow = 30, grey = 60,"), "{lua}");
}

#[test]
fn a_malformed_or_empty_section_and_a_header_key_after_one_are_errors() {
	let errs = |l: &[&str]| compile(&text(l)).errors.join("\n");
	for (line, want) in [
		("section First Aid", "`section` needs a profession and a skill range"),
		("section 1-40", "`section` needs a profession and a skill range"),
		("section First Aid 1-40 extra", "`section` needs a profession and a skill range"),
		("section First Aid 40-40", "malformed skill range \"40-40\""),
		("section Juggling 1-40", "unknown profession \"Juggling\""),
	] {
		let e = errs(&[line, "step A", "  craft 3275 until 40"]);
		assert!(e.contains(want), "{line}: {e}");
	}
	assert!(errs(&["step A", "  craft 3275 until 40", "section First Aid 40-50"]).contains("`section` has no steps under it"));
	assert!(errs(&["section First Aid 1-40", "faction Alliance", "step A", "  craft 3275 until 40"]).contains("unexpected `faction` in column 0"));
}

#[test]
fn sections_out_of_order_warn() {
	let r = compile(&text(&["section First Aid 40-50", "step A", "  learn 3276", "  craft 3276 until 50", "section First Aid 1-40", "step B", "  craft 3275 until 40"]));
	assert!(r.errors.is_empty(), "{}", r.text);
	assert_eq!(r.warned("a guide's sections are one profession's skill ranges in rising order").len(), 1, "{}", r.text);
}
