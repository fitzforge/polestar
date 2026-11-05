//! The game's AddOns list in every client language (tests/i18n-toc.test.js): each Polestar addon's TOC
//! carries `## Title-<locale>` and `## Notes-<locale>` for every locale, as forge-guide's toc.rs
//! writes them, the committed TOCs and the generated ones alike.

use crate::root;
use forge_guide::locales::LOCALE_CODES;
use forge_guide::toc::{language_addon, language_toc, retired_language_addons, toc_lines, toc_text};
use std::collections::HashMap;

fn fields(text: &str) -> HashMap<String, String> {
	let re = regex::Regex::new(r"(?m)^## ([\w-]+):[ \t]*(.*?)[ \t]*$").unwrap();
	re.captures_iter(text).map(|m| (m[1].to_string(), m[2].to_string())).collect()
}

fn tocs() -> Vec<String> {
	let dir = root().join("addon");
	let mut out: Vec<String> = std::fs::read_dir(&dir).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|d| dir.join(d).join(format!("{d}.toc")).exists()).collect();
	out.sort();
	out
}

#[test]
fn every_addon_toc_names_the_addon_in_every_client_language_as_toc_rs_has_it() {
	let tocs = tocs();
	assert!(tocs.iter().any(|t| t == "Polestar") && tocs.iter().any(|t| t == "Polestar_Guides") && tocs.iter().any(|t| t == "Polestar_ruRU"));
	for addon in &tocs {
		let f = fields(&std::fs::read_to_string(root().join("addon").join(addon).join(format!("{addon}.toc"))).unwrap());
		for (l, title, notes) in toc_text(addon).unwrap() {
			assert_eq!(f.get(&format!("Title-{l}")), Some(&title), "{addon} Title-{l}");
			assert_eq!(f.get(&format!("Notes-{l}")), Some(&notes), "{addon} Notes-{l}");
		}
	}
}

#[test]
fn the_translations_keep_polestars_name_fill_every_locale_and_the_language_folders_name_their_language() {
	let fill = regex::Regex::new(r"%[0-9]").unwrap();
	for addon in ["Polestar", "Polestar_Codex", "Polestar_Guides", "Polestar_ItemDB", "Polestar_Nav", "Polestar_QuestDB", "Polestar_Recorder", "Polestar_deDE", "Polestar_zhTW"] {
		let t = toc_text(addon).unwrap();
		assert_eq!(t.len(), LOCALE_CODES.len());
		for (l, title, notes) in t {
			assert!(title.contains("Polestar") && !notes.is_empty(), "{addon} {l}");
			assert!(!fill.is_match(&format!("{title}{notes}")), "{addon} {l} filled");
		}
	}
	assert!(toc_text("Polestar_deDE").unwrap().iter().any(|(l, _, n)| *l == "ruRU" && n.contains("немецкий")));
	assert!(toc_text("Polestar_deDE").unwrap().iter().any(|(l, t, _)| *l == "deDE" && t == "Polestar - Deutsch"));
	assert_eq!(toc_lines("Polestar_Codex").len(), LOCALE_CODES.len() * 2);
	assert!(toc_text("Polestar_Unknown").is_err());
	assert!(toc_text("Polestar_Names_deDE").is_err(), "the old folders have none");
}

#[test]
fn every_polestar_folder_sits_in_polestars_group_one_language_folder_per_language_none_of_the_old_ones_510() {
	let tocs = tocs();
	let missing: Vec<String> = LOCALE_CODES.iter().map(|l| language_addon(l)).filter(|d| !tocs.contains(d)).collect();
	assert!(missing.is_empty(), "the nine language folders: {missing:?} missing");
	// The two faction parts (Polestar_Guides_Alliance, _Horde; format 8) stay folders of their own: each loads on demand.
	for part in ["Polestar_Guides_Alliance", "Polestar_Guides_Horde"] {
		assert!(tocs.iter().any(|t| t == part), "{part}");
	}
	let old: Vec<&String> = tocs.iter().filter(|d| LOCALE_CODES.iter().any(|l| retired_language_addons(l).contains(d))).collect();
	assert!(old.is_empty(), "Polestar_Guides_<locale> and Polestar_Names_<locale> are gone: {old:?}");
	// The folders built locally (gitignored) may come from an older forge: their builders' tests check them.
	let local = ["Polestar_QuestDB", "Polestar_Codex", "Polestar_Travel"];
	// One collapsible "Polestar" heading (only a category folds in the client's AddOns list), Polestar's
	// own folders indented under it (a group only indents).
	for addon in tocs.iter().filter(|d| !local.contains(&d.as_str())) {
		let f = fields(&std::fs::read_to_string(root().join("addon").join(addon).join(format!("{addon}.toc"))).unwrap());
		assert_eq!(f.get("Category").map(String::as_str), Some("Polestar"), "{addon} is missing ## Category: Polestar");
		if addon != "Polestar" {
			assert_eq!(f.get("Group").map(String::as_str), Some("Polestar"), "{addon} is missing ## Group: Polestar");
		}
	}
	// The two writers of a language folder write the one TOC: both files, alike.
	for l in LOCALE_CODES {
		let name = language_addon(l);
		let dir = root().join("addon").join(&name);
		let text = std::fs::read_to_string(dir.join(format!("{name}.toc"))).unwrap();
		let f = fields(&text);
		assert_eq!(text, language_toc(l, &f["Interface"], &f["Version"]), "{name}");
		for file in ["Names.lua", "Texts.lua"] {
			assert!(dir.join(file).exists(), "{name}/{file}");
		}
	}
}
