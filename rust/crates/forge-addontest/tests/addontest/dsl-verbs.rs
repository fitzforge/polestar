//! Profession, reputation, exploration and achievement verbs (skill, learn, craft, rep, explore, achieve): parse,
//! resolve from professions.json / factions.json, validation, Lua emission, and the fallbacks when those data
//! files are absent. Also the any-of prerequisite rule. The compiler's side is forge-guide's
//! (rust/crates/forge-guide/tests/dsl_verbs.rs); here the addon loads what it emits.

use forge_addontest::dsl::{compile, compile_with, fixture_data, guide_text, plain, write_our_test_pack};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK};
use forge_guide::emit::emit_guides_with;
use forge_guide::js::V;
use serde_json::json;

#[test]
fn new_verbs_emit_lua_that_loads_under_lua_5_1_and_round_trips_with_reagents_as_nested_tables() {
	let src = guide_text(&[
		"guide t/prof",
		"title First Aid 1-150",
		"category Professions",
		"levels 1-60",
		"zone Elwynn Forest",
		"",
		"step Train",
		"  learn 3276",
		r#"  craft 3276 x10 -- "Linen" \ notes"#,
		"  craft 7934 until 115",
		"  skill First Aid 150",
		"step Rep",
		"  rep Stormwind Exalted",
		r#"  explore 42.1,65.9 "Goldshire""#,
		r#"  achieve 7 "Legacy: Northshire" criteria 3"#,
	]);
	let r = compile(&src);
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("t/prof");
	let lua = pack.text(at);
	assert!(is_match(lua, r#"reagents = \{ \{ item = 2589, itemName = "Linen Cloth", count = 2 \} \}"#));
	let localised = r.guides[0].hidden("_localised");
	let entry = V::obj();
	entry.set("guide", localised.clone());
	entry.set("source", V::str("test.guide"));
	// Polestar's own pack writes spawn spots packed (format 8).
	assert_eq!(lua, emit_guides_with(&[entry], false, true));
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Init.lua"])],
		script: [
			r#"
			local got
			Polestar.RegisterGuide = function(g) got = g end"#,
			&format!("\t\t\tassert(loadfile({file}))(\"Polestar_Guides\", {{}})"),
			"\t\t\temit(got)",
		]
		.join("\n"),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(*out, plain(&localised));
	assert_eq!(out["category"], "Professions");
	assert_eq!(out["steps"][0]["goals"][1]["note"], r#""Linen" \ notes"#);
}

#[test]
fn the_compiled_new_verb_goals_pass_the_real_engine_registry() {
	let text = guide_text(&["step S", "  learn 3276", "  craft 3276 x2", "  skill First Aid 150", "  rep 72 Friendly", r#"  explore 42,65 "Goldshire""#, r#"  achieve 6 "Level 10" criteria 1"#])
		.replacen("guide t/", "guide test/", 1);
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let file = serde_json::to_string(&pack.dir.join(pack.guides_of("test/main"))).unwrap();
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			"",
			&format!("\t\t\t{TEST_PACK}"),
			r#"			local res = {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) local ok, e = real(g); res[#res + 1] = ok and "ok" or e; return ok, e end"#,
			&format!("\t\t\tassert(loadfile({file}))(\"Polestar_Guides\", {{}})"),
			"\t\t\temit(res)",
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!(["ok"]));
}
