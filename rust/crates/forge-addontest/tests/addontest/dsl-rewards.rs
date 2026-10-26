//! Turn-in rewards (`reward`, `choose`, `xp`, `money` on `turnin`): parse, names from data, errors, Lua emission
//! through the engine registry, the step view, and the guide window's reward line.

use forge_addontest::dsl::{compile, compile_with, fixture_data, guide_text, line_of, plain, write_our_test_pack, Compiled};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const LINES: [&str; 3] = ["step S", "  accept 783", r#"  turnin 783 choose 159 750 "Wolf Steak" uncommon reward 990010 "Miner's Lantern" rare xp 1050 money 1g7s"#];

fn turnin(r: &Compiled) -> Value {
	plain(&r.guides[0].get("steps").at(0).get("goals").at(1))
}

#[test]
fn rewards_choices_and_items_with_names_from_data_or_the_line_quality_words_xp_and_money() {
	let r = compile(&guide_text(&LINES));
	assert_eq!(r.errors, Vec::<String>::new());
	assert_eq!(r.warnings, Vec::<String>::new(), "an unknown reward item with a name is display only, no warning");
	assert_eq!(
		turnin(&r)["rewards"],
		json!({
			"choices": [
				{ "item": 159, "itemName": "Refreshing Spring Water" },
				{ "item": 750, "itemName": "Wolf Steak", "quality": 2 },
			],
			"items": [{ "item": 990010, "itemName": "Miner's Lantern", "quality": 3 }],
			"xp": 1050,
			"money": 10700,
		})
	);
	let plain_money = compile(&guide_text(&["step S", "  accept 783", "  turnin 783 money 350"]));
	assert_eq!(turnin(&plain_money)["rewards"], json!({ "money": 350 }));
}

#[test]
fn rewards_xp_from_the_line_counts_toward_the_route_level_when_data_has_no_xp() {
	// 9300 needs level 20; a 100000 XP turn-in before it makes that plausible.
	let needs = |r: &Compiled| r.warnings.iter().filter(|w| is_match(w, "needs level 20")).count();
	let r = compile(&guide_text(&["step S", r#"  accept 990900 "New Quest" @48,42"#, r#"  turnin 990900 "New Quest" @48,42 xp 100000"#, "  accept 9300"]));
	assert_eq!(needs(&r), 0);
	let without = compile(&guide_text(&["step S", r#"  accept 990900 "New Quest" @48,42"#, r#"  turnin 990900 "New Quest" @48,42"#, "  accept 9300"]));
	assert_eq!(needs(&without), 1);
}

#[test]
fn rewards_malformed_lists_unknown_unnamed_items_bad_money_and_other_verbs_are_errors() {
	let src = guide_text(&[
		"step S",
		"  accept 783",
		"  turnin 783 choose xp 5",
		"  turnin 783 reward 990010",
		"  turnin 783 choose 159 159",
		"  turnin 783 money 5x",
		"  turnin 783 xp 0",
		"  accept 7 xp 50",
		"  turnin 783 choose 159 choose 750",
	]);
	let r = compile(&src);
	let at = |l: &str| line_of(&src, l);
	assert_eq!(
		r.errors,
		vec![
			format!("test.guide:{}: `choose` needs item ids: choose <itemId> [\"Item name\"] [quality] ...", at("  turnin 783 choose xp 5")),
			format!("test.guide:{}: reward item 990010 is not in data; give its name: `990010 \"Item name\"`", at("  turnin 783 reward 990010")),
			format!("test.guide:{}: `choose` lists item 159 twice", at("  turnin 783 choose 159 159")),
			format!("test.guide:{}: malformed money \"5x\" (copper, or e.g. 1g50s, 7s)", at("  turnin 783 money 5x")),
			format!("test.guide:{}: malformed xp amount \"0\"", at("  turnin 783 xp 0")),
			format!("test.guide:{}: `xp <N>` does not apply to `accept`", at("  accept 7 xp 50")),
			format!("test.guide:{}: duplicate `choose`", at("  turnin 783 choose 159 choose 750")),
		]
	);
}

#[test]
fn rewards_emitted_lua_passes_the_engine_registry_and_the_step_view_carries_them() {
	let text = guide_text(&LINES).replacen("guide t/", "guide test/", 1);
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("test/main");
	assert!(is_match(
		pack.text(at),
		r#"rewards = \{ choices = \{ \{ item = 159, itemName = "Refreshing Spring Water" \}, \{ item = 750, itemName = "Wolf Steak", quality = 2 \} \}, items = \{ \{ item = 990010, itemName = "Miner's Lantern", quality = 3 \} \}, money = 10700, xp = 1050 \}"#,
	));
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: "stub.world.addMap(1429, { name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })\nstub.world.moveTo(1429, 48, 42)".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			r#"
			local res = {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) local ok, e = real(g); res[#res + 1] = ok and "ok" or e; return ok, e end"#,
			TEST_PACK,
			TEST_SOURCE,
			&format!("assert(loadfile({file}))(\"Polestar_Guides\", {{}})"),
			r#"
			stub.login()
			Polestar.Engine.SetGuide("test/main")
			stub.advance(0.6)
			local view = Polestar.Engine.GetStepView(1)
			emit({ res = res, rewards = view.goals[2].rewards })"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0]["res"], json!(["ok"]));
	assert_eq!(out[0]["rewards"], turnin(&r)["rewards"]);
	let bad = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			r#"emit({ Polestar.RegisterGuide({ id = "test/bad", pack = "test", title = "B", steps = { { goals = { { t = "turnin", quest = 1, title = "Q", rewards = { choices = { { itemName = "x" } } } } } } } }) })"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(bad[0], json!([false, "step 1 goal 1: bad reward 1"]));
}

#[test]
fn the_guide_window_shows_an_open_turn_in_s_rewards_under_it_and_in_its_tooltip_item_names_in_quality_colours() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: "ITEM_QUALITY_COLORS = { [2] = { r = 0.12, g = 1, b = 0 }, [3] = { r = 0, g = 0.44, b = 0.87 } }".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
		script: r#"
			local real = Polestar.Compat
			uistub.install()
			stub.login()
			-- The fake Compat keeps the real item-quality lookups (uncached items: compiled quality).
			Polestar.Compat.GetItemQuality, Polestar.Compat.ItemQualityHex = real.GetItemQuality, real.ItemQualityHex
			local UI = Polestar.UI
			local goal = { t = "turnin", status = "active", note = "Inside",
				rewards = { choices = { { item = 1, itemName = "Cloak", quality = 3 }, { item = 2, itemName = "Boots", quality = 2 }, { item = 3, itemName = "Ring" } },
					items = { { item = 4, itemName = "Map" } }, xp = 3570, money = 10750 } }
			local done = { t = "turnin", status = "done", rewards = goal.rewards }
			emit({ line = UI.GoalRewards(goal), sub = UI.GoalSubline(goal), done = UI.GoalSubline(done) or false,
				none = UI.GoalRewards({ t = "turnin" }) or false, item = Polestar.Theme.Hex("item") })"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	let (blue, green) = ("ff0070de", "ff1fff00");
	let item = out["item"].as_str().unwrap();
	let line = format!("Choose: |c{blue}Cloak|r, |c{green}Boots|r or |c{item}Ring|r  \u{b7}  Get: |c{item}Map|r  \u{b7}  3,570 XP  \u{b7}  1g 7s 50c");
	assert_eq!(out["line"], line.as_str());
	assert_eq!(out["sub"], format!("Inside  \u{b7}  {line}").as_str());
	assert_eq!(out["done"], false, "a done turn-in drops its rewards");
	assert_eq!(out["none"], false);
}
