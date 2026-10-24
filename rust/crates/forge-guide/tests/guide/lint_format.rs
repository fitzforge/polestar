//! Diagnostics formats and fix hints (diag.rs, manifest.rs, the compiler's hints): the JSON document, GitHub
//! workflow annotations and the hints the toolchain promises. The CLI side (--format on lint and compile,
//! --quiet, a failed write in the document) is forge/tests/guide_cli_format.rs.

use crate::common;
use common::*;
use forge_guide::diag::{format_diagnostics, Diag};
use forge_guide::js::parse_json;
use forge_guide::manifest::validate_manifest;

const HINT: &str = "find the id with `polestar find <name>`, or give its name in quotes";

fn d(file: &str, line: f64, severity: &'static str, message: &str, hint: Option<&str>) -> Diag {
	Diag { severity, file: Some(file.into()), line, message: message.into(), hint: hint.map(String::from) }
}

#[test]
fn format_json_prints_one_document_with_the_counts_the_diagnostics_and_the_hint() {
	// A diagnostic without a hint has no `hint` key (the CLI document is tested on forge).
	let bare = d("x", 1.0, "warning", "m", None);
	let doc: serde_json::Value = serde_json::from_str(&format_diagnostics(std::slice::from_ref(&bare), "json", std::slice::from_ref(&bare))).unwrap();
	assert!(doc["diagnostics"][0].get("hint").is_none(), "no hint, no key");
	let with = d("x", 1.0, "error", "m", Some("h"));
	let doc: serde_json::Value = serde_json::from_str(&format_diagnostics(std::slice::from_ref(&with), "json", std::slice::from_ref(&with))).unwrap();
	assert_eq!([&doc["ok"], &doc["errors"], &doc["warnings"]], [&serde_json::json!(false), &serde_json::json!(1), &serde_json::json!(0)]);
	assert_eq!(doc["diagnostics"][0]["hint"], "h");
}

#[test]
fn github_annotations_encode_percent_cr_and_lf() {
	let one = d("a,b:c.guide", 3.0, "error", "100% done\r\nnext line", Some("one\ntwo"));
	assert_eq!(format_diagnostics(std::slice::from_ref(&one), "github", &[]), "::error file=a%2Cb%3Ac.guide,line=3::100%25 done%0D%0Anext line (hint: one%0Atwo)");
	let zero = d("x", 0.0, "warning", "m", None);
	assert_eq!(format_diagnostics(std::slice::from_ref(&zero), "github", &[]), "::warning file=x::m");
}

#[test]
fn the_required_fix_hints() {
	let r = compile(&guide_text(&["guide forever/h", "title H", "faction Alliance", "levels 1-6", "zone Elwynn Forest", "next forever/nope", "", "step S", "  talk 999999", "  goto 50,50 \"a | b\""]));
	let hint_of = |list: &[Diag], pat: &str| list.iter().find(|d| re(pat).is_match(&d.message)).unwrap_or_else(|| panic!("{pat}")).hint.clone().unwrap_or_default();
	assert_eq!(hint_of(&r.diag.list, r"npc 999999 is not in data"), HINT);
	assert_eq!(hint_of(&r.diag.list, r"unknown guide"), "list guide ids with `polestar find --kind guide <text>`");
	assert_match(&hint_of(&r.diag.list, r"prints literally"), r"^drop the `\|`");
	let manifest = |id: &str| validate_manifest(&parse_json(&format!(r#"{{"id":"{id}","title":"T","author":"A","version":"1","license":"MIT"}}"#)).unwrap(), "pack.json", false, None);
	assert_match(&hint_of(&manifest("polestar"), "reserved"), r"pick an id like `<author>-<name>`");
	assert_match(&hint_of(&manifest("Bad Id"), "malformed"), r"pick an id like `<author>-<name>`");
}

#[test]
fn a_guide_id_outside_the_pack_hints_at_the_prefix() {
	let r = compile_files(&[("x.guide", "guide forever/x\ntitle X\nlevels 1-2\nzone Elwynn Forest\n\nstep S\n  level 2\n")], &fixture_data(), Some("joe"));
	assert_eq!(r.diag.errors()[0].hint.as_deref(), Some("start the id with `joe/`"));
}

#[test]
fn pack_json_hints_show_an_example_value_for_the_key() {
	let hint = |obj: &str, pat: &str| {
		validate_manifest(&parse_json(obj).unwrap(), "pack.json", false, None).into_iter().find(|d| re(pat).is_match(&d.message)).unwrap_or_else(|| panic!("{pat}")).hint.unwrap()
	};
	assert_eq!(hint(r#"{"title":"T","author":"A","version":"1","license":"MIT"}"#, r"missing `id`"), "add \"id\": \"joe-routes\" (with your own value) to pack.json");
	assert_eq!(hint(r#"{"id":"joe","author":"A","version":"1","license":"MIT"}"#, r"missing `title`"), "add \"title\": \"Joe's Routes\" (with your own value) to pack.json");
	assert_eq!(hint(r#"{"id":"joe","title":"T","author":7,"version":"1","license":"MIT"}"#, r"`author` must be a string"), "write the value in quotes, like \"author\": \"Joe\"");
	assert_eq!(hint(r#"{"id":"joe","title":"T","author":"A","version":1,"license":"MIT"}"#, r"`version` must be a string"), "write the value in quotes, like \"version\": \"1.0.0\"");
	assert_eq!(hint(r#"{"id":"joe","title":"T","author":"A","version":"1"}"#, r"missing `license`"), "add \"license\": \"CC-BY-4.0\" (with your own value) to pack.json");
}
