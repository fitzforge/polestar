//! The pack docs keep up with the code: docs/PACK_FORMAT.md (the contract) names every goal verb the runtime
//! reads (Core/Guides.lua's REQUIRED table, Polestar.Guides.VERBS) and every guide and goal key the compiler
//! writes (tools/lib/dsl/emit.js); docs/PACKS.md (the handbook) names every problem kind and pack status the
//! Community guides page can show.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::emit::{GOAL_KEYS, GUIDE_KEYS};

fn read(rel: &str) -> String {
	std::fs::read_to_string(root().join(rel)).unwrap_or_else(|e| panic!("{rel}: {e}"))
}

// A name counts when the doc writes it as code: `accept`.
fn names(text: &str, name: &str) -> bool {
	text.contains(&format!("`{name}`"))
}

fn missing<S: AsRef<str>>(text: &str, list: &[S]) -> Vec<String> {
	list.iter().map(|n| n.as_ref()).filter(|n| !names(text, n)).map(String::from).collect()
}

fn has_items(list: &[&str]) -> bool {
	!list.is_empty()
}

#[test]
fn pack_format_md_names_every_goal_verb_the_runtime_reads() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua"])],
		script: "local out = {} for k in pairs(Polestar.Guides.VERBS) do out[#out + 1] = k end table.sort(out) emit(out)".into(),
		..Default::default()
	});
	let verbs = &out[0];
	let list: Vec<String> = verbs.as_array().map(|a| a.iter().map(|v| v.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default();
	assert!(list.len() >= 20, "expected the runtime's verb list, got {verbs}");
	assert_eq!(missing(&read("docs/PACK_FORMAT.md"), &list), Vec::<String>::new());
}

#[test]
fn pack_format_md_names_every_guide_and_goal_key_the_compiler_writes() {
	assert!(has_items(&GUIDE_KEYS), "emit.js exports GUIDE_KEYS");
	assert!(has_items(&GOAL_KEYS), "emit.js exports GOAL_KEYS");
	let doc = read("docs/PACK_FORMAT.md");
	assert_eq!(missing(&doc, &GUIDE_KEYS), Vec::<String>::new());
	assert_eq!(missing(&doc, &GOAL_KEYS), Vec::<String>::new());
}

#[test]
fn packs_md_names_every_problem_kind_and_pack_status() {
	let doc = read("docs/PACKS.md");
	assert_eq!(missing(&doc, &["pack-refused", "guide-refused", "no-guides"]), Vec::<String>::new());
	assert_eq!(missing(&doc, &["on", "off", "disabled", "not-loaded", "too-new", "refused", "broken"]), Vec::<String>::new());
}
