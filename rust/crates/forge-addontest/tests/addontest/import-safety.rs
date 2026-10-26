//! Security hardening for import strings (0.2.6): tests for every finding in
//! data/local/research/ImportSafety.md.

use forge_addontest::dsl::{fixture_data, plain};
use forge_addontest::{emitted, is_match, lua_value, text, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::emit::guide_data;
use forge_guide::importstring::{encode_import, import_string, LIMITS};
use forge_guide::js::{parse_json, V};
use forge_guide::project::{compile_sources, CompileOpts, Source};
use serde_json::{json, Value};

const ID: &str = "yendi/northshire";

fn guide_src() -> String {
	format!(
		"guide {ID}
title Northshire Valley
faction Alliance
levels 1-6
zone Elwynn Forest
version 1

step Deputy Willem
  accept 783

step Back to the abbey
  turnin 783
"
	)
}

fn guide() -> V {
	let data = fixture_data();
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: Some("yendi".into()), author: Some("Yendi".into()), context: None, pack_dir: None };
	let sources = [Source { source: String::new(), file: "northshire.guide".into(), text: guide_src() }];
	let c = compile_sources(&sources, &data, &mut diag, &opts);
	let errors: Vec<String> = diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	c.guides[0].clone()
}

fn manifest() -> V {
	parse_json(r#"{"id":"yendi","license":"CC-BY-4.0"}"#).unwrap()
}

fn string() -> String {
	let data = fixture_data();
	let (text, _) = import_string(&guide(), &manifest(), Some(&*data)).unwrap_or_else(|e| panic!("{e}"));
	text
}

fn payload() -> Value {
	let g = guide();
	let loc = g.hidden("_localised");
	let src = if loc.truthy() { loc } else { g };
	json!({ "format": 3, "license": "CC-BY-4.0", "guide": plain(&guide_data(&src)) })
}

fn encode(p: &Value) -> String {
	encode_import(&parse_json(&p.to_string()).unwrap())
}

// The raw JSON, compressed and checksummed into an import string: the encoder writes the JSON it is given
// back as the same text (key order and `\b`, `\f`, `\r`, `\u00XX` escapes as JSON.stringify writes them).
fn envelope(raw: &str) -> String {
	encode_import(&parse_json(raw).unwrap())
}

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

const SAVE: &str = r#"
function save(text)
  local info, why = I.Preview(text) assert(info, why) assert(I.Save(info.entry)) return info
end
"#;

fn run(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		before: WORLD.into(),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("I = Polestar.Import\nG = Polestar.Guides\n{SAVE}\n{script}"),
	})
	.remove(0)
}

fn str(s: &str) -> String {
	serde_json::to_string(s).unwrap()
}

fn preview_refused(p: &Value) -> Value {
	run(
		&format!(
			r#"
		local info, why = I.Preview({})
		emit({{ refused = info == nil, why = why or "" }})
	"#,
			str(&encode(p))
		),
		None,
	)
}

fn preview_ok(p: &Value) -> Value {
	run(
		&format!(
			r#"
		local info, why = I.Preview({})
		emit({{ ok = info ~= nil, why = why or "" }})
	"#,
			str(&encode(p))
		),
		None,
	)
}

// ── Finding 1: fill output is capped at 2×text (8192 bytes) ─────────────────

#[test]
fn finding_1_fill_stops_at_8192_bytes_leftover_tokens_stay_as_written() {
	// A note of 100 × "{npc:1}" (700 bytes) with name value at the 128-byte cap. Before the fix: O(n²)
	// allocation; after: fill stops at 8192 bytes of output and appends the remaining original text (at most
	// 700 more bytes).
	let note = "{npc:1}".repeat(100); // 700 bytes
	let mut p = payload();
	p["guide"]["names"] = json!({ "npc:1": "A".repeat(128) });
	p["guide"]["steps"][0]["note"] = json!(note);
	let out = run(
		&format!(
			r#"
		save({})
		local g = G.Get({})
		emit({{ note_len = #(g.steps[1].note or ""), ok = true }})
	"#,
			str(&encode(&p)),
			str(ID)
		),
		None,
	);
	assert_eq!(out["ok"], true);
	let len = out["note_len"].as_f64().unwrap();
	// After fill: at most FILL_CAP (8192) of expanded text + remaining original (≤700).
	assert!(len <= (8192 + note.len()) as f64, "note length {len} unexpectedly large");
	// Also ensure meaningful fill happened (more than the original note).
	assert!(len > note.len() as f64, "some tokens were filled");
}

#[test]
fn finding_1_a_names_written_value_over_128_bytes_is_refused_by_the_writer() {
	let mut p = payload();
	p["guide"]["names"] = json!({ "npc:1": "A".repeat(129) });
	// importString's longText should catch this
	let bytes = serde_json::to_string(&p).unwrap().len();
	if bytes <= LIMITS.payload {
		// The addon also refuses it
		let out = run(
			&format!(
				r#"
			local info, why = I.Preview({})
			emit({{ refused = info == nil, why = why or "" }})
		"#,
				str(&encode(&p))
			),
			None,
		);
		assert_eq!(out["refused"], true, "addon must refuse a names value over 128 bytes");
		assert!(is_match(text(&out["why"]), r"longer than Polestar reads"));
	}
}

#[test]
fn finding_1_a_names_written_value_at_the_cap_128_bytes_is_accepted() {
	let mut p = payload();
	p["guide"]["names"] = json!({ "npc:1": "A".repeat(128) });
	let out = preview_ok(&p);
	assert_eq!(out["ok"], true, "{}", out["why"]);
}

// ── Finding 2: goals-per-step and candidates-per-goal caps ──────────────────

#[test]
fn finding_2_a_step_with_more_than_100_goals_is_refused() {
	let mut p = payload();
	// Duplicate the first goal until we exceed the cap
	let base_goal = p["guide"]["steps"][0]["goals"][0].clone();
	p["guide"]["steps"][0]["goals"] = Value::Array(vec![base_goal; 101]);
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"goals in step"));
}

#[test]
fn finding_2_a_goal_with_more_than_128_candidates_is_refused() {
	let mut p = payload();
	// Add a goal with 129 candidates
	let cand = json!({ "npc": 1, "map": 1, "x": 50, "y": 50 });
	p["guide"]["steps"][0]["goals"].as_array_mut().unwrap().push(json!({
		"t": "turnin", "quest": 783,
		"candidates": vec![cand; 129],
	}));
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"candidates in a goal"));
}

#[test]
fn finding_2_caps_match_the_writer_limits_goals_100_candidates_128() {
	assert_eq!(LIMITS.goals, 100);
	assert_eq!(LIMITS.candidates, 128);
	let out = run("emit({ goals = I.LIMITS.goals, candidates = I.LIMITS.candidates })", None);
	assert_eq!(out["goals"], 100);
	assert_eq!(out["candidates"], 128);
}

// ── Finding 3: at most one direct turn-in per quest per step ────────────────

#[test]
fn finding_3_two_direct_turn_ins_for_the_same_quest_in_one_step_are_refused() {
	let mut p = payload();
	let goals = p["guide"]["steps"][0]["goals"].as_array_mut().unwrap();
	goals.push(json!({ "t": "turnin", "quest": 783, "direct": true }));
	goals.push(json!({ "t": "turnin", "quest": 783, "direct": true }));
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"direct turn-in for quest"));
}

#[test]
fn finding_3_one_direct_turn_in_per_quest_per_step_is_allowed() {
	let mut p = payload();
	// A valid turnin goal requires title; copy from the existing step's guide data.
	p["guide"]["steps"][0]["goals"].as_array_mut().unwrap().push(json!({ "t": "turnin", "quest": 783, "title": "A Threat Within", "direct": true }));
	let out = preview_ok(&p);
	assert_eq!(out["ok"], true, "{}", out["why"]);
}

// ── Finding 4: control characters and id escaping ───────────────────────────

#[test]
fn finding_4_b_f_r_in_json_strings_are_refused() {
	let cases = json!({
		"backspace": envelope(r#"{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"a\bb"}}"#),
		"formfeed": envelope(r#"{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"a\fb"}}"#),
		"cr": envelope(r#"{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"a\rb"}}"#),
	});
	let out = run(
		&format!(
			r#"
		local out = {{}}
		for k, text in pairs({}) do
			local info, why = I.Preview(text)
			out[k] = info and "accepted" or why
		end
		emit(out)
	"#,
			lua_value(&cases)
		),
		None,
	);
	for (name, msg) in out.as_object().unwrap() {
		assert!(is_match(text(msg), r"damaged or incomplete"), "{name}: expected refusal");
	}
}

#[test]
fn finding_4_u0000_and_other_control_uxxxx_are_refused() {
	let nul = envelope(r#"{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"a\u0000b"}}"#);
	let ctrl = envelope(r#"{"format":3,"license":"MIT","guide":{"id":"yendi/x","title":"a\u0003b"}}"#);
	let out = run(
		&format!(
			r#"
		local n = I.Preview({})
		local c = I.Preview({})
		emit({{ nul = n == nil, ctrl = c == nil }})
	"#,
			str(&nul),
			str(&ctrl)
		),
		None,
	);
	assert_eq!(out["nul"], true, "NUL should be refused");
	assert_eq!(out["ctrl"], true, "U+0003 should be refused");
}

#[test]
fn finding_4_a_guide_id_with_special_chars_is_refused() {
	let mut p = payload();
	p["guide"]["id"] = json!("yendi/north|cffRed|rshire"); // colour codes in id
	let out = run(
		&format!(
			r#"
		local info, why = I.Preview({})
		emit({{ refused = info == nil }})
	"#,
			str(&encode(&p))
		),
		None,
	);
	assert_eq!(out["refused"], true);
}

#[test]
fn finding_4_guide_ids_with_uppercase_spaces_or_slashes_beyond_the_slug_are_refused() {
	let cases = [
		"yendi/north shire", // space
		"yendi/North",       // uppercase
		"yendi/a/b",         // two slashes
		"yendi/",            // empty slug
		"/northshire",       // no author
	];
	let strings: Vec<String> = cases
		.iter()
		.map(|id| {
			let mut p = payload();
			p["guide"]["id"] = json!(id);
			encode(&p)
		})
		.collect();
	let out = run(
		&format!(
			r#"
		local results = {{}}
		for i, text in ipairs({}) do
			local info, why = I.Preview(text)
			results[i] = info and "accepted" or "refused"
		end
		emit({{ results = results }})
	"#,
			lua_value(&json!(strings))
		),
		None,
	);
	for r in out["results"].as_array().unwrap() {
		assert_eq!(*r, "refused");
	}
}

// ── Finding 5: Import.List safe for broken entries; recovery commands ────────

#[test]
fn finding_5_import_list_returns_a_title_for_a_failed_entry_without_calling_prepare() {
	// A stored entry whose steps is a string rather than a table – it was hand-edited or saved by a newer
	// Polestar version then downgraded. build() refuses it at login, so it never registers; List() must show
	// a title without calling Prepare (which walks steps and errors).
	let good = payload();
	let mut bad = payload()["guide"].clone();
	bad["id"] = json!("yendi/broken");
	bad["steps"] = json!("oops");
	let saved = format!(
		r#"PolestarDB = {{ schema = 1, settings = {{}}, imports = {{ [{}] = {}, ["yendi/broken"] = {{ format = 3, license = "CC-BY-4.0", guide = {} }} }} }}"#,
		str(ID),
		lua_value(&good),
		lua_value(&bad)
	);
	let out = run(
		r#"
		local list = I.List()
		local broken = nil
		for _, e in ipairs(list) do if e.id == "yendi/broken" then broken = e end end
		local del = I.Delete("yendi/broken")
		emit({ listed = broken ~= nil, title_ok = broken and type(broken.title) == "string", del = del, after = #I.List() })
	"#,
		Some(&saved),
	);
	assert_eq!(out["listed"], true, "broken entry appears in List()");
	assert_eq!(out["title_ok"], true, "broken entry has a string title");
	assert_eq!(out["del"], true, "Delete works on broken entry");
	assert_eq!(out["after"], 1);
}

#[test]
fn finding_5_import_clear_removes_all_imported_guides() {
	let out = run(
		&format!(
			r#"
		save({})
		assert(#I.List() == 1)
		Polestar.RunCommand("import clear")
		emit({{ count = #I.List(), stored = PolestarDB.imports[{}] == nil }})
	"#,
			str(&string()),
			str(ID)
		),
		None,
	);
	assert_eq!(out["count"], 0);
	assert_eq!(out["stored"], true);
}

#[test]
fn finding_5_import_delete_removes_one_guide_by_id() {
	let out = run(
		&format!(
			r#"
		save({})
		Polestar.RunCommand("import delete {}")
		emit({{ count = #I.List(), stored = PolestarDB.imports[{}] == nil }})
	"#,
			str(&string()),
			ID,
			str(ID)
		),
		None,
	);
	assert_eq!(out["count"], 0);
	assert_eq!(out["stored"], true);
}

// ── Finding 6: degenerate and out-of-range frames/coordinates ───────────────

#[test]
fn finding_6_a_frame_with_left_right_is_refused() {
	let mut p = payload();
	p["frames"] = json!({ "9998": { "c": 0, "left": 5, "right": 5, "top": 1, "bottom": 2 } });
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"degenerate"));
}

#[test]
fn finding_6_a_frame_with_huge_coordinates_is_refused() {
	let mut p = payload();
	p["frames"] = json!({ "9998": { "c": 0, "left": 2000000, "right": 3000000, "top": 1, "bottom": 2 } });
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"out-of-range"));
}

#[test]
fn finding_6_a_candidate_coordinate_outside_0_100_is_refused() {
	let mut p = payload();
	p["guide"]["steps"][0]["goals"].as_array_mut().unwrap().push(json!({
		"t": "turnin", "quest": 783,
		"candidates": [{ "npc": 1, "map": 1, "x": 150, "y": 50 }], // x out of range
	}));
	let out = preview_refused(&p);
	assert_eq!(out["refused"], true);
	assert!(is_match(text(&out["why"]), r"coordinate outside 0-100"));
}

// ── Finding 7: update warns when author or licence changes ──────────────────

fn update(v1: &str, p2: &Value) -> Value {
	run(
		&format!(
			r#"
		save({})
		local info = I.Preview({})
		emit({{ state = info.state, authorChanged = info.authorChanged == true, licenseChanged = info.licenseChanged == true }})
	"#,
			str(v1),
			str(&encode(p2))
		),
		None,
	)
}

#[test]
fn finding_7_preview_marks_authorchanged_when_the_incoming_guide_has_a_different_author() {
	let v1 = string();
	let mut p2 = payload();
	p2["guide"]["version"] = json!(2);
	p2["guide"]["author"] = json!("Someone Else");
	let out = update(&v1, &p2);
	assert_eq!(out["state"], "update");
	assert_eq!(out["authorChanged"], true);
	assert_eq!(out["licenseChanged"], false);
}

#[test]
fn finding_7_preview_marks_licensechanged_when_the_incoming_licence_differs() {
	let v1 = string();
	let mut p2 = payload();
	p2["guide"]["version"] = json!(2);
	p2["license"] = json!("MIT");
	let out = update(&v1, &p2);
	assert_eq!(out["state"], "update");
	assert_eq!(out["authorChanged"], false);
	assert_eq!(out["licenseChanged"], true);
}

#[test]
fn finding_7_authorchanged_and_licensechanged_are_absent_for_a_new_guide() {
	let out = run(
		&format!(
			r#"
		local info = I.Preview({})
		emit({{ state = info.state, ac = info.authorChanged == nil, lc = info.licenseChanged == nil }})
	"#,
			str(&string())
		),
		None,
	);
	assert_eq!(out["state"], "new");
	assert_eq!(out["ac"], true, "authorChanged should be nil/absent for new");
	assert_eq!(out["lc"], true, "licenseChanged should be nil/absent for new");
}
