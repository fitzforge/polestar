//! A guide both factions play with each side's own levels (`levels <min>-<max> Alliance|Horde`, compiled to
//! `factionLevels`; Guides.Levels): Shen'dralas, which the 0.4.0 routes bring Alliance characters to at about 45.8
//! and Horde ones at about 47 (the Riverglades first). Each side's range is the one the addon uses: the outgrown
//! notice (GUIDE_OUTLEVELED), Suggest and the guide menu. The guide is compiled from its text by forge-guide, as the
//! pack ships it (rust/crates/forge-guide/tests/guide/dsl_faction_levels.rs covers the compiler).

use forge_addontest::dsl::{compile_with, fixture_data, plain};
use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

/// Shen'dralas as `pack`'s guide `<prefix>/shendralas`, compiled -> its registration as Lua.
fn shendralas(prefix: &str, pack: Option<&str>) -> Value {
	let text = [&format!("guide {prefix}/shendralas"), "title Shen'dralas", "levels 45-46 Alliance", "levels 47-48 Horde", "zone Elwynn Forest", "", "step Valley of Bones", "  level 60"].join("\n");
	let r = compile_with(&[("shendralas.guide", &text)], &fixture_data(), pack);
	assert_eq!(r.errors, Vec::<String>::new());
	plain(&r.guides[0])
}

const WORLD: &str = r#"
local w = stub.world
w.addMap(1444, { name = "Feralas", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1444, 50, 50)
w.zone, w.subzone = "Feralas", ""
"#;

/// The real Core with Shen'dralas and a Horde Feralas guide (44-47) in the test pack; a `faction` `race` at `level`.
fn run(faction: &str, race: &str, level: u32, script: &str) -> Value {
	let g = shendralas("test", Some("test"));
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.faction, stub.world.race = \"{faction}\", \"{race}\"\nstub.world.level = {level}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\nPolestar.RegisterGuide({})\n{}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\n{script}",
			lua_value(&g),
			r#"Polestar.RegisterGuide({ id = "test/feralas", pack = "test", title = "Feralas", faction = "Horde", minLevel = 44, maxLevel = 47, zone = 1444, steps = { { goals = { { t = "level", level = 60 } } } } })"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_compiled_guide_carries_each_sides_range_and_guides_levels_reads_the_players() {
	let out = run(
		"Horde",
		"Orc",
		47,
		r#"
		local G = Polestar.Guides
		local g = G.Get("test/shendralas")
		emit({ mine = { G.Levels(g) }, alliance = { G.Levels(g, "Alliance") }, horde = { G.Levels(g, "Horde") }, span = { g.minLevel, g.maxLevel } })"#,
	);
	assert_eq!(out, json!({ "mine": [47, 48], "alliance": [45, 46], "horde": [47, 48], "span": [45, 48] }));
}

// A Horde character arrives at about 47: Shen'dralas is their level, not outgrown. An Alliance character there at
// 49 is three past its own top (46) and is told so, though the span (45-48) alone would not.
#[test]
fn a_horde_character_at_47_to_49_is_not_told_shendralas_is_outgrown_an_alliance_one_at_49_is() {
	let script = r#"
		local fired = {}
		-- The outgrown notice, not Skip grey quests' catch-up passing the guide (Engine's mayPass).
		Polestar.Set("behavior.skipGrey", false)
		Polestar.On("GUIDE_OUTLEVELED", function(id) fired[#fired + 1] = id end)
		E.SetGuide("test/shendralas"); flush()
		local at = {}
		for _, l in ipairs(LEVELS) do stub.world.setLevel(l); flush(); at[#at + 1] = #fired end
		emit(at)"#;
	let horde = run("Horde", "Orc", 47, &format!("LEVELS = {{ 47, 48, 49 }}\n{script}"));
	assert_eq!(horde, json!([0, 0, 0]), "Horde: 47-48 is the guide's range for them");
	let alliance = run("Alliance", "Human", 46, &format!("LEVELS = {{ 47, 49 }}\n{script}"));
	assert_eq!(alliance, json!([0, 1]), "Alliance: outgrown past its own 45-46");
}

// Suggest (fresh start, catch-up) by each side's range: a Horde character below 47 gets Feralas, never Shen'dralas;
// at 47 Shen'dralas fits. An Alliance character at 45 is suggested it.
#[test]
fn suggest_offers_shendralas_to_horde_from_47_and_to_alliance_from_45() {
	let horde = |level: u32| run("Horde", "Orc", level, "emit(Polestar.Guides.Suggestions())");
	assert_eq!(horde(43), json!(["test/feralas"]), "level 43: not yet");
	assert_eq!(horde(45), json!(["test/feralas"]), "level 45 is the Alliance's arrival, not the Horde's");
	assert_eq!(horde(46), json!(["test/feralas"]));
	assert!(horde(47).as_array().unwrap().contains(&json!("test/shendralas")), "level 47: the Horde's arrival");
	assert_eq!(run("Alliance", "Human", 45, "emit(Polestar.Guides.Suggestions())"), json!(["test/shendralas"]));
}

// The guide menu, the guide window's meta line and a guide label show the player's side's range.
#[test]
fn the_guide_menu_shows_each_side_its_own_range() {
	let g = shendralas("forever/40-50", None);
	let shown = |faction: &str| {
		emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
			script: format!(
				r#"uistub.install()
				stub.login()
				uistub.player.faction, uistub.player.level = "{faction}", 45
				local g = {}
				uistub.guides[g.id] = g
				table.insert(uistub.order, g.id)
				local UI = Polestar.UI
				UI.ShowPicker()
				Polestar.UI.Picker.SetQuery("dralas")
				local range
				for _, f in ipairs(stub.frames) do
					if type(f.psGuide) == "table" and f.psGuide.id == g.id and rawget(f, "Range") and f:IsShown() then range = f.Range:GetText() end
				end
				emit({{ row = range, label = UI.GuideLabel(g), meta = UI.GuideMeta(g) }})"#,
				lua_value(&g)
			),
			..Default::default()
		})
		.remove(0)
	};
	let alliance = shown("Alliance");
	assert_eq!(alliance["row"], "(45\u{2013}46)");
	assert_eq!(alliance["label"], "Shen'dralas (45\u{2013}46)");
	assert!(alliance["meta"].as_str().unwrap().ends_with("Levels 45\u{2013}46"), "{alliance}");
	let horde = shown("Horde");
	assert_eq!(horde["row"], "(47\u{2013}48)");
	assert_eq!(horde["label"], "Shen'dralas (47\u{2013}48)");
}
