//! pack.json: reading and validating a guide pack's manifest (manifest.rs), and which guide ids a pack owns.

use crate::common;
use common::*;
use forge_guide::diag::Diag;
use forge_guide::format::owns_guide_id;
use forge_guide::manifest::{read_manifest, validate_manifest};
use serde_json::{json, Value};

fn good() -> Value {
	json!({ "id": "joe", "title": "Joe's Routes", "author": "Joe", "version": "1.2.0", "license": "CC-BY-4.0" })
}

fn with(k: &str, x: Value) -> Value {
	let mut g = good();
	g[k] = x;
	g
}

fn check(obj: &Value) -> Vec<Diag> {
	validate_manifest(&v(obj), "pack.json", false, None)
}

fn check_official(obj: &Value) -> Vec<Diag> {
	validate_manifest(&v(obj), "pack.json", true, None)
}

/// Exactly one diag of `severity` whose message contains `text`; errors carry a hint.
#[track_caller]
fn one(diags: Vec<Diag>, severity: &str, text: &str) -> Diag {
	assert_eq!(diags.len(), 1, "{diags:?}");
	let d = diags.into_iter().next().unwrap();
	assert_eq!(d.severity, severity);
	assert!(d.message.contains(text), "{} should mention {text}", d.message);
	assert_eq!(d.file.as_deref(), Some("pack.json"));
	assert!(d.line >= 1.0 && d.line.fract() == 0.0);
	if severity == "error" {
		assert!(d.hint.as_ref().is_some_and(|h| !h.is_empty()), "errors carry a hint");
	}
	d
}

fn write_pack(name: &str, content: &str) -> std::path::PathBuf {
	let dir = scratch(&format!("manifest-{name}"));
	std::fs::write(dir.join("pack.json"), content).unwrap();
	dir
}

fn folder_of(name: &str, obj: &Value) -> (String, Vec<Diag>) {
	let (m, diags) = read_manifest(&write_pack(name, &obj.to_string()), false);
	(m.map(|m| m.get("folder").to_js_string()).unwrap_or_default(), diags)
}

#[test]
fn a_complete_manifest_has_no_diagnostics_and_a_default_folder_from_its_title() {
	assert!(check(&good()).is_empty());
	let (m, diags) = read_manifest(&write_pack("complete", &serde_json::to_string_pretty(&good()).unwrap()), false);
	assert!(diags.is_empty(), "{diags:?}");
	let m = m.unwrap();
	assert_eq!(m.get("folder").to_js_string(), "PolestarPack_JoesRoutes");
	assert_eq!(m.get("id").to_js_string(), "joe");
	assert_eq!(m.get("license").to_js_string(), "CC-BY-4.0");
}

#[test]
fn a_title_without_letters_or_digits_takes_the_folder_from_the_id() {
	let mut g = with("id", json!("joe-routes"));
	g["title"] = json!("!!!");
	let (folder, diags) = folder_of("noletters", &g);
	assert!(diags.is_empty());
	assert_eq!(folder, "PolestarPack_JoeRoutes");
}

#[test]
fn each_required_field_missing_is_one_error_naming_it() {
	for key in ["id", "title", "author", "version", "license"] {
		let mut g = good();
		g.as_object_mut().unwrap().remove(key);
		one(check(&g), "error", key);
	}
}

#[test]
fn malformed_and_reserved_pack_ids_are_errors_ours_may_use_guides() {
	for id in ["Joe".to_string(), "j".into(), "a".repeat(33), "-x".into()] {
		one(check(&with("id", json!(id))), "error", "id");
	}
	for id in ["guides", "forever", "lookup", "draft", "polestar"] {
		one(check(&with("id", json!(id))), "error", "reserved");
	}
	assert!(check_official(&with("id", json!("guides"))).is_empty());
}

#[test]
fn folder_names_must_be_plain_and_may_not_look_like_our_addons() {
	for folder in ["../evil", "a/b", "Polestar", "Polestar_Guides", "Polestar_Anything"] {
		one(check(&with("folder", json!(folder))), "error", "folder");
	}
	let mut ours = with("id", json!("guides"));
	ours["folder"] = json!("Polestar_Guides");
	assert!(check_official(&ours).is_empty());
	assert!(check(&with("folder", json!("MyPack-1"))).is_empty());
	assert_eq!(folder_of("plainfolder", &with("folder", json!("MyPack-1"))).0, "MyPack-1");
}

#[test]
fn control_characters_are_refused_in_every_string_field() {
	one(check(&with("title", json!("Joe\n## Dependencies: X"))), "error", "control characters");
	for key in ["title", "author", "license", "website", "source", "notes"] {
		for ch in ['\u{0007}', '\u{007f}'] {
			let value = if key == "website" { format!("https://example.org/{ch}") } else { format!("Joe{ch}") };
			one(check(&with(key, json!(value))), "error", "control characters");
		}
	}
	// id, version and folder: refused for the control character, not reported as malformed too.
	for key in ["id", "version", "folder"] {
		for ch in ['\n', '\t', '\u{0000}', '\u{007f}'] {
			let d = one(check(&with(key, json!(format!("Joe{ch}")))), "error", "control characters");
			assert!(d.message.starts_with(&format!("`{key}`")), "{}", d.message);
		}
	}
}

#[test]
fn the_default_folder_is_polestarpack_and_the_title_in_camelcase_cut_to_the_64_characters_a_folder_may_have() {
	// 64 characters, one word: PolestarPack_ and it would be 77.
	let title = format!("Long{}", "r".repeat(60));
	let (folder, _) = folder_of("long", &with("title", json!(title)));
	assert_eq!(folder, format!("PolestarPack_Long{}", "r".repeat(47)));
	assert_eq!(folder.len(), 64);
	assert!(check(&with("folder", json!(folder))).is_empty());
}

#[test]
fn versions_are_one_plain_token() {
	one(check(&with("version", json!("1 2"))), "error", "version");
	assert!(check(&with("version", json!("2.0.0-beta+3"))).is_empty());
}

#[test]
fn websites_are_http_s_links_of_at_most_200_characters() {
	one(check(&with("website", json!("javascript:alert(1)"))), "error", "website");
	one(check(&with("website", json!(format!("https://example.org/{}", "a".repeat(200))))), "error", "website");
	assert!(check(&with("website", json!("http://example.org"))).is_empty());
	assert!(check(&with("website", json!("https://example.org/joe"))).is_empty());
}

#[test]
fn field_lengths_are_bounded() {
	for key in ["title", "author", "license"] {
		one(check(&with(key, json!("x".repeat(65)))), "error", key);
		assert!(check(&with(key, json!("x".repeat(64)))).is_empty());
	}
	for key in ["source", "notes"] {
		one(check(&with(key, json!("x".repeat(201)))), "error", key);
		assert!(check(&with(key, json!("x".repeat(200)))).is_empty());
	}
}

#[test]
fn an_unknown_key_is_a_warning() {
	one(check(&with("colour", json!("red"))), "warning", "unknown key");
}

#[test]
fn a_pipe_in_the_title_warns_that_it_prints_literally() {
	one(check(&with("title", json!("Joe|cffff0000"))), "warning", "prints literally in game");
}

#[test]
fn invalid_json_is_one_error_naming_the_file() {
	let (m, diags) = read_manifest(&write_pack("invalid", "{ \"id\": }"), false);
	assert!(m.is_none());
	assert_eq!(diags.len(), 1);
	assert_eq!(diags[0].severity, "error");
	assert!(format!("{} {}", diags[0].file.as_deref().unwrap_or(""), diags[0].message).contains("pack.json"));
	assert!(diags[0].hint.is_some());
}

#[test]
fn diagnostics_point_at_the_line_of_the_key_in_pack_json() {
	let (_, diags) = read_manifest(&write_pack("lines", "{\n\t\"id\": \"joe\",\n\t\"title\": \"Joe\",\n\t\"author\": \"Joe\",\n\t\"version\": \"1 2\",\n\t\"license\": \"MIT\"\n}\n"), false);
	assert_eq!(diags.len(), 1);
	assert_eq!(diags[0].line, 5.0);
	assert!(diags[0].file.as_deref().unwrap().ends_with("pack.json"));
}

#[test]
fn our_pack_owns_forever_and_draft_every_other_pack_owns_its_id_with_the_slash() {
	assert!(owns_guide_id("guides", "forever/horde/02-the-barrens"));
	assert!(owns_guide_id("guides", "draft/x"));
	assert!(!owns_guide_id("guides", "guides/x"));
	assert!(owns_guide_id("joe", "joe/a"));
	assert!(!owns_guide_id("joe", "joes/a"));
	assert!(!owns_guide_id("joe", "joe"));
	assert!(!owns_guide_id("joe", "forever/a"));
}
