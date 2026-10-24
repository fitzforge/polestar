//! Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, Smart logic, Farm spots) and quest
//! prerequisite titles on accepts. The compiler's side is forge-guide's (rust/crates/forge-guide/tests/dsl_farm.rs);
//! this is the engine registry reading what it emits. Fixture: Silk Cloth (4306) drops from mobs in Elwynn,
//! Durotar and Stranglethorn, plus an elite, a mob standing in Goldshire and a 1% dropper.

use forge_addontest::dsl::{compile_with, fixture_data, plain, write_our_test_pack};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK};

fn head(faction: Option<&str>) -> Vec<String> {
	let mut h = vec!["guide t/f".to_string(), "title F".to_string()];
	if let Some(f) = faction {
		h.push(format!("faction {f}"));
	}
	h.push("levels 1-60".to_string());
	h.push("zone Elwynn Forest".to_string());
	h.push(String::new());
	h
}

fn src(faction: Option<&str>, body: &[&str]) -> String {
	let mut all = head(faction);
	all.push("step S".to_string());
	all.extend(body.iter().map(|s| s.to_string()));
	format!("{}\n", all.join("\n"))
}

const SCRIPT: &str = r#"
			${TEST_PACK}
			local got, res
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) got = g; local ok, e = real(g); res = ok and "ok" or e; return ok, e end
			assert(loadfile(${FILE}))("Polestar_Guides", {})
			emit({ res = res, title = got.steps[1].goals[2].preTitles[783], guide = got })"#;

#[test]
fn farm_spots_and_prerequisite_titles_emit_lua_that_the_engine_registry_accepts_and_round_trips() {
	let text = src(None, &["  collect 4306 x20 nearest", "  accept 9500"]).replacen("guide t/", "guide test/", 1);
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("test/f");
	let lua = pack.text(at);
	assert!(is_match(lua, r#"\{ npc = 95001, npcName = "Cloth Kobold", map = 1429, x = 65\.4, y = 75\.3, f = "e", faction = "A", lvl = \{ min = 5, max = 5 \}, rate = 0\.3, spawns = 4 \}"#));
	assert!(is_match(lua, r#"pre = \{ 9201, 783 \}, preTitles = \{ \[783\] = "A Threat Within", \[9201\] = "The First Step" \}"#));
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], script: SCRIPT.replace("${TEST_PACK}", TEST_PACK).replace("${FILE}", &file), ..Default::default() });
	let out = &out[0];
	assert_eq!(out["res"], "ok");
	assert_eq!(out["title"], "A Threat Within");
	assert_eq!(out["guide"], plain(&r.guides[0]));
}
