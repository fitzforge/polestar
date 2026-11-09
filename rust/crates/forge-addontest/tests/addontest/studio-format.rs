//! Guide format 10 (Polestar Studio's tools, docs/GUIDE_FORMAT.md): a step's stable `id`, the `boss`,
//! `mark`, `path` and `area` goals and a guide's `credits` and `forked-from`, compiled by forge-guide and
//! read by Core/Guides.lua and Core/Import.lua; the v2 import string (`!PS2!`) that carries the guide's source
//! tree beside it, written by forge-guide's importstring and by the addon's Import.Encode.

use forge_addontest::dsl::{compile_with, fixture_data, plain};
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::format::{format_for, needs, STUDIO_FORMAT};
use forge_guide::importstring::{decode_import, import_string_v2, source_keys, LIMITS_V2};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const HEAD: &str = "guide yendi/studio
title Studio
faction Alliance
levels 1-6
zone Elwynn Forest
version 2
";

fn compile(body: &str) -> forge_addontest::dsl::Compiled {
	compile_with(&[("studio.guide", &format!("{HEAD}{body}"))], &fixture_data(), Some("yendi"))
}

#[test]
fn the_author_s_tools_compile_into_format_10() {
	let c = compile(
		"credits Joe: the dungeon paths
credits Ann
forked-from yendi/old 3

step Deputy Willem
  id k3f9ab
  accept 783
  mark 6 skull \"Pull first\"
  area 6 \"Kobold camp\"

step The way down
  id w4y5
  path @40,40 @41,41 @42,42 \"Down the hill\"
  path @42,42 @44,44 cycle
  area @40,40 @45,40 @45,45 @40,40.5

step VanCleef
  boss 639
",
	);
	assert_eq!(c.errors, Vec::<String>::new());
	let g = plain(&c.guides[0]);
	assert_eq!(format_for(&c.guides), STUDIO_FORMAT);
	assert_eq!(needs(STUDIO_FORMAT), Some("0.3.7"));
	assert_eq!(g["credits"], json!(["Joe: the dungeon paths", "Ann"]));
	assert_eq!(g["forkedFrom"], json!({ "id": "yendi/old", "version": 3 }));
	let s1 = &g["steps"][0];
	assert_eq!(s1["id"], "k3f9ab");
	assert_eq!(s1["goals"][1], json!({ "t": "mark", "npc": 6, "npcName": "Kobold Vermin", "icon": 8, "note": "Pull first" }));
	// The npc's area: the hull of its spawns on the step's map, with the author's label.
	assert_eq!(s1["goals"][2]["t"], "area");
	assert_eq!(s1["goals"][2]["text"], "Kobold camp");
	assert_eq!(s1["goals"][2]["map"], 1429);
	assert!(s1["goals"][2]["pts"].as_array().unwrap().len() >= 3);
	let s2 = &g["steps"][1];
	assert_eq!(s2["id"], "w4y5");
	assert_eq!(s2["goals"][0]["pts"], json!([{ "x": 40, "y": 40 }, { "x": 41, "y": 41 }, { "x": 42, "y": 42 }]));
	assert_eq!(s2["goals"][0]["text"], "Down the hill");
	assert_eq!(s2["goals"][1]["cycle"], true);
	// Four points of which one lies inside: the hull keeps the three corners... and the fourth off the line.
	let hull = s2["goals"][2]["pts"].as_array().unwrap();
	assert!(hull.len() >= 3 && hull.len() <= 4, "{hull:?}");
	let boss = &g["steps"][2]["goals"][0];
	assert_eq!(boss["t"], "boss");
	assert_eq!(boss["npc"], 639);
	assert_eq!(boss["npcName"], "Edwin VanCleef");
	assert_eq!(boss["instance"], 36);
}

#[test]
fn a_step_id_is_4_to_8_lowercase_letters_and_digits_once_per_guide() {
	let dup = compile("\nstep A\n  id aaaa\n  accept 783\n\nstep B\n  id aaaa\n  turnin 783\n");
	assert!(dup.errors.iter().any(|e| e.contains("step id \"aaaa\" used twice")), "{:?}", dup.errors);
	let bad = compile("\nstep A\n  id AB\n  accept 783\n");
	assert!(bad.errors.iter().any(|e| e.contains("malformed step id")), "{:?}", bad.errors);
	let plain_guide = compile("\nstep A\n  accept 783\n");
	assert!(format_for(&plain_guide.guides) < STUDIO_FORMAT);
}

#[test]
fn a_path_needs_two_points_and_an_area_three_off_one_line() {
	let path = compile("\nstep A\n  path @40,40\n");
	assert!(path.errors.iter().any(|e| e.contains("`path` needs at least 2 points")), "{:?}", path.errors);
	let line = compile("\nstep A\n  area @40,40 @41,41 @42,42\n");
	assert!(line.errors.iter().any(|e| e.contains("lie on one line")), "{:?}", line.errors);
	let icon = compile("\nstep A\n  mark 6 banana\n");
	assert!(icon.errors.iter().any(|e| e.contains("unknown mark icon")), "{:?}", icon.errors);
}

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		before: r#"stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })"#.into(),
		login: true,
		script: format!("I = Polestar.Import\n{script}"),
		..Default::default()
	})
}

fn sorted(a: &[&str]) -> Value {
	let mut v = a.to_vec();
	v.sort_unstable();
	json!(v)
}

#[test]
fn the_v2_caps_and_the_source_tree_keys_are_the_writer_s() {
	let out = run("emit({ v2 = I.LIMITS_V2, keys = I.KEYS })").remove(0);
	assert_eq!(out["v2"]["length"], LIMITS_V2.length);
	assert_eq!(out["v2"]["steps"], LIMITS_V2.steps);
	assert_eq!(out["v2"]["payload"], LIMITS_V2.payload);
	assert_eq!(out["v2"]["goals"], LIMITS_V2.goals);
	assert_eq!(out["keys"]["pts"], sorted(&["x", "y"]));
	assert_eq!(out["keys"]["forkedFrom"], sorted(&["id", "version"]));
	let src = &out["keys"]["source"];
	assert_eq!(src["tree"], sorted(&source_keys::TREE));
	assert_eq!(src["header"], sorted(&source_keys::HEADER));
	assert_eq!(src["headerLists"], sorted(&source_keys::HEADER_LISTS));
	assert_eq!(src["step"], sorted(&source_keys::STEP));
	assert_eq!(src["stepLists"], sorted(&source_keys::STEP_LISTS));
	assert_eq!(src["goal"], sorted(&source_keys::GOAL));
}

// The source tree of the guide below, as tools/lib/pack/sourcetree.js writes it.
fn tree() -> V {
	parse_json(
		&json!({
			"v": 1,
			"header": { "guide": "yendi/studio", "title": "Studio", "levels": "1-6", "zone": "Elwynn Forest", "faction": "Alliance", "version": "2" },
			"steps": [
				{ "title": "Deputy Willem", "id": "k3f9ab", "goals": [{ "verb": "accept", "args": ["783"], "mods": [] }] },
				{ "title": "Marshal McBride", "id": "m4c5", "goals": [{ "verb": "turnin", "args": ["783"], "mods": [] }] },
			],
		})
		.to_string(),
	)
	.unwrap()
}

#[test]
fn a_v2_string_carries_the_source_through_import_and_back_out_of_encode() {
	let c = compile("\nstep Deputy Willem\n  id k3f9ab\n  accept 783\n\nstep Marshal McBride\n  id m4c5\n  turnin 783\n");
	assert_eq!(c.errors, Vec::<String>::new());
	let manifest = parse_json(r#"{"id":"yendi","license":"CC-BY-4.0"}"#).unwrap();
	let (text, steps) = import_string_v2(&c.guides[0], &manifest, Some(&*fixture_data()), &tree()).unwrap_or_else(|e| panic!("{e}"));
	assert!(text.starts_with("!PS2!"));
	assert_eq!(steps, 2);
	let out = run(&format!(
		r#"
		local info, why = I.Preview({text:?})
		assert(info, why)
		assert(I.Save(info.entry))
		local e = I.Entry("yendi/studio")
		emit({{ format = e.format, source = e.source, ids = {{ e.guide.steps[1].id, e.guide.steps[2].id }} }})
		emit({{ again = I.Encode(e) }})
		"#
	));
	assert_eq!(out[0]["format"], STUDIO_FORMAT);
	assert_eq!(out[0]["ids"], json!(["k3f9ab", "m4c5"]));
	assert_eq!(out[0]["source"], plain(&tree()));
	// The addon's own writer: a v2 string the tools read back to the same source.
	let again = out[1]["again"].as_str().unwrap();
	assert!(again.starts_with("!PS2!"));
	let back = plain(&decode_import(again).unwrap_or_else(|e| panic!("{e}")));
	assert_eq!(back["source"], plain(&tree()));
	assert_eq!(back["guide"]["steps"][0]["id"], "k3f9ab");
}

#[test]
fn a_v1_string_keeps_its_smaller_caps() {
	let out = run(r#"emit({ steps = I.LIMITS.steps, length = I.LIMITS.length, v2steps = I.CAPS[2].steps })"#).remove(0);
	assert_eq!(out, json!({ "steps": 60, "length": 50000, "v2steps": 250 }));
}
