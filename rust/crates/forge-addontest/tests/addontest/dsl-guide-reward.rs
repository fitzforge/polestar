//! A guide's `reward` and `why` headers (docs/GUIDE_FORMAT.md, "Header"): what its goal gives and why it is
//! worth doing, for the guide menu's details. Parse, names from data, errors, the Class-guide warnings and Lua
//! emission through the engine registry.

use forge_addontest::dsl::{compile, compile_with, fixture_data, plain, write_our_test_pack};
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::json;

fn guide(headers: &[&str], category: &str, id: &str) -> String {
	let head = format!("guide {id}");
	let cat = format!("category {category}");
	let mut lines: Vec<&str> = vec![&head, "title Test", "faction Alliance", &cat, "levels 1-10", "zone Elwynn Forest"];
	lines.extend_from_slice(headers);
	lines.extend_from_slice(&["", "step S", "  accept 783", "  turnin 783"]);
	format!("{}\n", lines.join("\n"))
}

fn class_guide(headers: &[&str]) -> String {
	guide(headers, "Class", "t/main")
}

#[test]
fn reward_an_item_several_items_as_a_choice_of_one_a_spell_and_words_in_header_order_why_as_written() {
	let r = compile(&class_guide(&[
		"reward item 159",
		r#"reward item 750 "Wolf Steak" uncommon 990010 "Miner's Lantern" rare"#,
		r#"reward spell 23161 "Summon Dreadsteed""#,
		"reward text Summon Incubus",
		"why A tireless demon horse.",
	]));
	assert_eq!(r.errors, Vec::<String>::new());
	assert_eq!(r.warnings, Vec::<String>::new());
	let g = plain(&r.guides[0]);
	assert_eq!(
		g["reward"],
		json!([
			{ "item": 159, "itemName": "Refreshing Spring Water" },
			{ "item": 750, "itemName": "Wolf Steak", "quality": 2, "choice": true },
			{ "item": 990010, "itemName": "Miner's Lantern", "quality": 3, "choice": true },
			{ "spell": 23161, "spellName": "Summon Dreadsteed" },
			{ "text": "Summon Incubus" },
		])
	);
	assert_eq!(g["why"], "A tireless demon horse.");
}

#[test]
fn reward_malformed_lines_are_errors_an_unknown_item_or_a_spell_needs_its_name_why_is_given_once() {
	let cases = [
		("reward", "`reward` needs a value"),
		("reward mount 5", "unknown reward kind \"mount\""),
		("reward item", "`reward item` needs item ids"),
		("reward item 159 159", "lists item 159 twice"),
		("reward item 159 epic sword", "unexpected \"sword\""),
		("reward spell x", "malformed `reward spell`"),
		("reward spell 23161", "reward spell 23161 needs its name"),
		("reward item 990010", "reward item 990010 is not in data"),
		("reward text", "`reward text` needs words"),
	];
	for (line, want) in cases {
		let r = compile(&class_guide(&[line, "why Because."]));
		assert!(r.errors.iter().any(|e| e.contains(want)), "{line}: {}", r.errors.join(" | "));
	}
	let twice = compile(&class_guide(&["reward text A", "why One.", "why Two."]));
	assert!(twice.errors.iter().any(|e| e.contains("duplicate header key `why`")), "{}", twice.errors.join(" | "));
}

#[test]
fn a_class_guide_without_reward_or_why_warns_another_category_does_not() {
	let bare = compile(&class_guide(&[]));
	assert_eq!(bare.errors, Vec::<String>::new());
	assert!(bare.warnings.iter().any(|w| w.contains("a Class guide needs `reward`")), "{}", bare.warnings.join(" | "));
	assert!(bare.warnings.iter().any(|w| w.contains("a Class guide needs `why`")), "{}", bare.warnings.join(" | "));
	assert_eq!(compile(&guide(&[], "Collectibles", "t/main")).warnings, Vec::<String>::new());
}

#[test]
fn reward_and_why_reach_the_registry_and_the_guide_list_lua_bad_shapes_are_refused() {
	let text = guide(&[r#"reward item 750 "Wolf Steak" uncommon 159"#, r#"reward spell 23161 "Summon Dreadsteed""#, "why Worth it."], "Class", "test/main");
	let r = compile_with(&[("test.guide", &text)], &fixture_data(), Some("test"));
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let at = pack.guides_of("test/main");
	assert!(is_match(
		pack.text(at),
		r#"reward = \{ \{ item = 750, itemName = "Wolf Steak", quality = 2, choice = true \}, \{ item = 159, itemName = "Refreshing Spring Water", choice = true \}, \{ spell = 23161, spellName = "Summon Dreadsteed" \} \},\n\t+why = "Worth it\.","#,
	));
	let file = serde_json::to_string(&pack.dir.join(at)).unwrap();
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&format!("assert(loadfile({file}))(\"Polestar_Guides\", {{}})"),
			r#"local h
for _, g in ipairs(Polestar.Guides.List()) do if g.id == "test/main" then h = g end end
local function bad(extra)
	local def = { id = "test/bad", pack = "test", title = "B", steps = { { goals = { { t = "note", text = "n" } } } } }
	for k, v in pairs(extra) do def[k] = v end
	return { Polestar.RegisterGuide(def) }
end
emit({ reward = h.reward, why = h.why, noId = bad({ reward = { { itemName = "x" } } }), why3 = bad({ why = 3 }) })"#,
		]
		.join("\n"),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["reward"], plain(&r.guides[0])["reward"]);
	assert_eq!(out["why"], "Worth it.");
	assert_eq!(out["noId"], json!([false, "bad reward 1"]));
	assert_eq!(out["why3"], json!([false, "bad why"]));
}
