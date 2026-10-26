//! A locale's state (stale keys, broken formats, a key set twice, a file Lua cannot load) and the
//! shipped interface files (tests/i18n.test.js).

use crate::{mini_addon, polestar, root, shipped, write};
use forge_guide::i18n_files::update_locale_text;
use forge_guide::js::V;
use forge_i18n::keys::extract_keys;
use forge_i18n::project::locale_state;

fn head(l: &str) -> String {
	format!("local _, ns = ...\nif not (GetLocale and GetLocale() == \"{l}\") then return end\nlocal L = ns.L\n")
}

#[test]
fn the_checker_reports_stale_keys_broken_formats_a_key_set_twice_and_a_file_lua_cannot_load() {
	let dir = mini_addon();
	write(dir.path(), "Locales/frFR.lua", &format!("{}L[\"Hello %s\"] = \"Bonjour %d\"\nL[\"Gone\"] = \"Parti\"\nL[\"Bye\"] = \"Salut\"\nL[\"Bye\"] = \"Au revoir\"\n", head("frFR")));
	write(dir.path(), "Locales/deDE.lua", &format!("{}L[\"Bye\"] = \"Tschüss\"\nL[\"Hello %s\" = \"Hallo %s\"\n", head("deDE")));
	let locales: Vec<String> = ["frFR", "deDE", "koKR"].iter().map(|s| s.to_string()).collect();
	let st = locale_state(root(), dir.path(), &locales, Some(dir.path())).unwrap();
	let fr = st.locale("frFR").unwrap();
	assert_eq!(fr.stale, [("Gone".to_string(), "Parti".to_string())]);
	let mut problems: Vec<&str> = fr.problems.iter().map(|(k, _)| k.as_str()).collect();
	problems.sort();
	assert_eq!(problems, ["Bye", "Hello %s"]);
	let mut missing = fr.missing.clone();
	missing.sort();
	assert_eq!(missing, ["Close the window", "New in Main", "slot: Back"], "a broken translation is translated, and refused");
	let de = st.locale("deDE").unwrap().error.clone().unwrap_or_default();
	assert!(de.contains("expected") || de.contains("']'"), "{de}");
	assert!(!st.locale("koKR").unwrap().exists);
}

#[test]
fn a_file_in_another_layout_is_an_error_for_the_check() {
	let dir = mini_addon();
	write(dir.path(), "Locales/frFR.lua", "return { [\"Bye\"] = \"Salut\" }\n");
	let st = locale_state(root(), dir.path(), &["frFR".to_string()], Some(dir.path())).unwrap();
	assert!(st.locale("frFR").unwrap().error.as_deref().unwrap().starts_with("written as a returned table"));
}

#[test]
fn every_shipped_interface_file_loads_has_no_stale_or_twice_set_key_and_keeps_the_english_formats() {
	let names: Vec<String> = std::fs::read_dir(polestar().join("Locales")).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f.ends_with(".lua")).collect();
	assert!(!names.is_empty());
	for f in &names {
		assert!(forge_guide::locales::locale(f.trim_end_matches(".lua")).is_some(), "Locales/{f}: not a locale Polestar ships");
	}
	let shipped = shipped();
	let st = locale_state(root(), &polestar(), &shipped, None).unwrap();
	for (l, s) in &st.locales {
		assert_eq!(s.error, None, "{l}");
		assert!(s.stale.is_empty(), "{l}: stale keys (run `forge i18n sync {l}`): {:?}", s.stale);
		assert!(s.problems.is_empty(), "{l}: broken translations: {:?}", s.problems);
		assert!(s.translated.len() > 1000, "{l}: {} translations", s.translated.len());
	}
}

#[test]
fn sync_keeps_every_translation_line_of_the_shipped_files_byte_for_byte() {
	let keys = extract_keys(root(), &polestar()).unwrap().by_file();
	for l in shipped() {
		let file = polestar().join("Locales").join(format!("{l}.lua"));
		let text = std::fs::read_to_string(&file).unwrap();
		let shown = file.to_string_lossy();
		let out = update_locale_text(&text, &shown, &keys, &V::obj(), &V::obj()).unwrap();
		let after: std::collections::HashSet<&str> = out.text.split('\n').collect();
		let lost: Vec<&str> = text.split('\n').filter(|x| x.starts_with("L[") && !after.contains(x) && !after.contains(format!("-- {x}").as_str())).collect();
		assert!(lost.is_empty(), "{l}: translation lines sync would change: {lost:?}");
		assert_eq!(update_locale_text(&out.text, &shown, &keys, &V::obj(), &V::obj()).unwrap().text, out.text, "{l}: a second sync changes nothing");
	}
}

#[test]
fn every_locale_has_its_language_status_and_translators() {
	for l in &forge_guide::locales::LOCALES {
		assert!(!l.language.is_empty(), "{}", l.code);
		assert!(l.status == "ai" || l.status == "reviewed", "{}", l.code);
		assert_eq!(l.translators.is_empty(), l.status == "ai", "{}: a reviewed locale names its translators", l.code);
	}
}
