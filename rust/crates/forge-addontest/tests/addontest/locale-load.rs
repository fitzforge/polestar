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

#[test]
fn a_failed_early_load_that_a_later_one_makes_up_leaves_only_what_was_read_at_load_in_english() {
	// The first ask for the folder (Core/Locale.lua's) fails, the next one (Names, through Data.Pack)
	// loads it: L fills then, so a string read at load (the key binding's name) stays English and one
	// looked up later is German. The report log names the failure.
	let out = emitted(&RunAddon {
		stubs: vec!["stub_packs.lua"],
		before: format!(
			r#"{}
do
	local load, failed = C_AddOns.LoadAddOn, false
	function C_AddOns.LoadAddOn(name)
		if name == "Polestar_deDE" and not failed then
			failed = true
			return false, "DEMAND_LOADED"
		end
		return load(name)
	end
	LoadAddOn = C_AddOns.LoadAddOn
end"#,
			client("deDE", true)
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"
local L, N = Polestar.L, Polestar.Names
local early = L["Previous step"]
local name = N.Cached("quest", 7) or false
local logged = false
for _, line in ipairs(Polestar.DebugLog()) do
	if line:find("Locale: Polestar_deDE not loaded: DEMAND_LOADED", 1, true) then logged = true end
end
emit({ BINDING_NAME_POLESTAR_NEXT, early, name, L["Previous step"], logged })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["Next step", "Previous step", "Säuberung im Koboldlager", "Vorheriger Schritt", true]));
}

/// The chat lines at login naming a language folder, for a client in `locale` whose folder is installed
/// (`folder`), and turned off in the AddOns list with `reason` "DISABLED".
fn login_lines(locale: &str, folder: bool, reason: Option<&str>) -> serde_json::Value {
	let disabled = match reason {
		Some(r) => format!(
			r#"
table.insert(stub.addons, {{ name = "Polestar_{locale}", reason = {r} }})
do
	local load = C_AddOns.LoadAddOn
	function C_AddOns.LoadAddOn(name)
		if name == "Polestar_{locale}" then return false, {r} end
		return load(name)
	end
	LoadAddOn = C_AddOns.LoadAddOn
end"#,
			r = lua_string(r)
		),
		None => String::new(),
	};
	emitted(&RunAddon {
		stubs: vec!["stub_packs.lua"],
		before: format!("{}\n{disabled}", client(locale, folder)),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		login: true,
		script: r#"
local out = {}
for _, m in ipairs(stub.messages) do if m:find("language files", 1, true) then out[#out + 1] = m:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end end
emit(table.concat(out, "\n"))"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_missing_or_turned_off_language_folder_is_named_in_one_english_chat_line_at_login() {
	let line = "Polestar: the German language files (Polestar_deDE) are missing or turned off in the AddOns list, so Polestar shows in English.";
	assert_eq!(login_lines("deDE", false, None), json!(line), "not installed");
	assert_eq!(login_lines("deDE", true, Some("DISABLED")), json!(line), "turned off in the AddOns list");
	assert_eq!(login_lines("deDE", true, None), json!(""), "loaded: nothing to say");
	assert_eq!(login_lines("enUS", false, None), json!(""), "an English client has no language folder");
	assert_eq!(login_lines("itIT", false, None), json!(""), "Polestar ships no Italian, so there is none to miss");
	assert_eq!(login_lines("zhTW", false, None), json!("Polestar: the Traditional Chinese language files (Polestar_zhTW) are missing or turned off in the AddOns list, so Polestar shows in English."));
}

// tools/dev/!PolestarLocaleTest: on an English client, Polestar's own files (and the language folder's) read the
// test's locale, so Core/Locale.lua loads Polestar_deDE while Polestar loads, as on a German client; anything else
// still reads the client's language. debugstack is the client's: the caller's chunk, by its file path.
#[test]
fn the_locale_test_addon_loads_the_german_folder_through_core_locale_on_an_english_client() {
	let helper = root().join("tools/dev/!PolestarLocaleTest/PolestarLocaleTest.lua");
	let toc = std::fs::read_to_string(root().join("tools/dev/!PolestarLocaleTest/!PolestarLocaleTest.toc")).unwrap();
	let interface = |s: &str| s.lines().find(|l| l.starts_with("## Interface:")).map(str::to_owned);
	assert_eq!(interface(&toc), interface(&std::fs::read_to_string(root().join("addon/Polestar/Polestar.toc")).unwrap()), "the client loads it only on Polestar's interface version");
	let out = emitted(&RunAddon {
		stubs: vec!["stub_packs.lua"],
		before: format!(
			r#"{}
function debugstack(start)
	local info = debug.getinfo((start or 1) + 1, "Sl")
	return info and (info.source .. ":" .. tostring(info.currentline) .. ": in function\n") or ""
end
dofile({})"#,
			client("enUS", true),
			lua_string(&helper.to_string_lossy())
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		login: true,
		script: r#"
local L, N = Polestar.L, Polestar.Names
local said = false
for _, m in ipairs(stub.messages) do if m:find("language files", 1, true) then said = true end end
emit({ BINDING_NAME_POLESTAR_NEXT, L["Previous step"], N.PackName() or false, N.Cached("quest", 7) or false, stub.packLoads.Polestar_deDE or 0, GetLocale(), said })"#
			.into(),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!(["Nächster Schritt", "Vorheriger Schritt", "Polestar_deDE", "Säuberung im Koboldlager", 1, "enUS", false]),
		"the folder loaded once, early (the key binding's name is German), and code outside Polestar still reads enUS"
	);
}

#[test]
fn a_translation_that_puts_the_arguments_in_its_own_order_formats_as_the_client_does() {
	let out = emitted(&RunAddon {
		before: forge_addontest::fake_locale("itIT", &[("Kill %s for %s", "Per %2$s uccidi %1$s")]),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"emit(Polestar.L["Kill %s for %s"]:format("Hogger", "Gryan Stoutmantle"))"#.into(),
		..Default::default()
	});
	assert_eq!(out[0], "Per Gryan Stoutmantle uccidi Hogger");
}

#[test]
fn every_shipped_translation_with_positional_arguments_renders_with_its_english_keys_arguments() {
	// Each translation using %1$s-style arguments is formatted with the arguments its English key takes
	// (a "<n>" string per %s, n per number), as the client formats it: every string argument shows up.
	let locales = forge_guide::locales::LOCALE_CODES.iter().map(|l| lua_string(l)).collect::<Vec<_>>().join(", ");
	let files = forge_guide::locales::LOCALE_CODES
		.iter()
		.map(|l| lua_string(&root().join("addon").join(forge_guide::toc::language_addon(l)).join(forge_guide::toc::INTERFACE_FILE).to_string_lossy()))
		.collect::<Vec<_>>()
		.join(", ");
	let out = emitted(&RunAddon {
		script: format!(
			r#"
local locales, files, count, bad = {{ {locales} }}, {{ {files} }}, 0, {{}}
for i, loc in ipairs(locales) do
	local L = {{}}
	Polestar = {{ L = L }}
	function GetLocale() return loc end
	dofile(files[i])
	for key, text in pairs(L) do
		if type(text) == "string" and text:find("%%%d+%$") then
			count = count + 1
			local args = {{}}
			for conv in key:gsub("%%%%", ""):gmatch("%%[-+ #0]*%d*%.?%d*(%a)") do
				args[#args + 1] = conv == "s" and ("<" .. (#args + 1) .. ">") or (#args + 1)
			end
			local ok, s = pcall(string.format, text, unpack(args))
			for _, a in ipairs(args) do
				if ok and type(a) == "string" and not s:find(a, 1, true) then ok, s = false, "no " .. a .. " in " .. s end
			end
			if not ok then bad[#bad + 1] = loc .. " " .. key .. ": " .. tostring(s) end
		end
	end
end
table.sort(bad)
-- An empty Lua table emits as a JSON object, so the list goes back as one string.
emit({{ count = count, bad = table.concat(bad, "\n") }})"#
		),
		..Default::default()
	});
	assert!(out[0]["count"].as_u64().unwrap() > 0, "no translation uses positional arguments: {}", out[0]);
	assert_eq!(out[0]["bad"], "", "translations the client's format can't render with their key's arguments:\n{}", out[0]["bad"].as_str().unwrap_or_default());
}
