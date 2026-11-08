//! The interface strings come from the client's language folder, Polestar_<locale> (#919): Core/Core.xml
//! lists no translation, Core/Locale.lua loads the one folder of the client's language before any file
//! reads L at load, and the folder's names and guide texts come in with it. An English client loads no
//! folder; a missing one leaves the interface in English.

use forge_addontest::run::{toc_files, xml_files};
use forge_addontest::{emitted, lua_string, Addon, RunAddon};
use serde_json::json;

fn root() -> std::path::PathBuf {
	std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

/// Lua for `before`: GetLocale() answers `locale`, the client knows the German language folder as a
/// load-on-demand addon (stub_packs.lua) when `folder`, and every translation file Lua opens is listed in
/// __opened (a locale file under Locales/ or a file of a language folder).
fn client(locale: &str, folder: bool) -> String {
	let files = if folder {
		let list = toc_files("Polestar_deDE").unwrap().iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
		format!("stub.packs.Polestar_deDE = {{ {list} }}")
	} else {
		String::new()
	};
	format!(
		r#"function GetLocale() return {loc} end
{files}
__opened = {{}}
do
	local load = loadfile
	function loadfile(file)
		local rel = file:gsub("\\", "/"):match("/addon/(.*)$")
		if rel and (rel:find("/Locales/") or rel:find("^Polestar_%a%a%u%u/")) then __opened[#__opened + 1] = rel end
		return load(file)
	end
end"#,
		loc = lua_string(locale)
	)
}

fn run(locale: &str, folder: bool) -> Vec<serde_json::Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_packs.lua"],
		before: client(locale, folder),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
local L, N, T = Polestar.L, Polestar.Names, Polestar.GuideTexts
emit({ BINDING_NAME_POLESTAR_NEXT, L["Previous step"], N.Cached("quest", 7) or false, T.PackText("guides", "Polestar Guides"), stub.packLoads.Polestar_deDE or 0, table.concat(__opened, " ") })"#
			.into(),
		..Default::default()
	})
}

#[test]
fn core_xml_loads_no_translation_and_asks_for_the_language_folder_after_names_and_guide_texts() {
	let files: Vec<String> = xml_files(&root().join("addon/Polestar/Core/Core.xml")).unwrap().iter().map(|f| f.file_name().unwrap().to_string_lossy().into_owned()).collect();
	let core = std::fs::read_to_string(root().join("addon/Polestar/Core/Core.xml")).unwrap();
	assert!(!core.contains("Locales"), "Core.xml lists a translation:\n{core}");
	let at = |name: &str| files.iter().position(|f| f == name).unwrap_or_else(|| panic!("Core.xml has no {name}"));
	assert!(at("Locale.lua") > at("Names.lua") && at("Locale.lua") > at("GuideTexts.lua"), "the language folder's Names.lua and Texts.lua need Names and GuideTexts: {files:?}");
	assert_eq!(at("Locale.lua"), at("GuideTexts.lua") + 1, "nothing between GuideTexts.lua and Locale.lua may read L at load: {files:?}");
	assert!(!root().join("addon/Polestar/Locales").exists(), "addon/Polestar/Locales is gone: the strings are in each Polestar_<locale>");
}

#[test]
fn a_german_client_has_its_strings_before_the_first_file_reads_one_and_opens_no_other_language() {
	let out = run("deDE", true);
	assert_eq!(
		out[0],
		json!(["Nächster Schritt", "Vorheriger Schritt", "Säuberung im Koboldlager", "Polestar-Guides", 1, "Polestar_deDE/Interface.lua Polestar_deDE/Names.lua Polestar_deDE/Texts.lua"]),
		"the key binding's name is read while Core/Commands.lua loads; the folder loads once, names and guide texts with it"
	);
}

#[test]
fn an_english_client_opens_no_language_folder_and_a_missing_one_leaves_the_interface_in_english() {
	for locale in ["enUS", "enGB"] {
		let out = run(locale, true);
		assert_eq!(out[0], json!(["Next step", "Previous step", false, "Polestar Guides", 0, ""]), "{locale}");
	}
	let out = run("deDE", false);
	assert_eq!(out[0], json!(["Next step", "Previous step", false, "Polestar Guides", 0, ""]), "a German client without Polestar_deDE");
}
