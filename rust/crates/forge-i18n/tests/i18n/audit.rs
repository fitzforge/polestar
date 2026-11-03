//! `i18n audit` (forge_i18n::audit): a text whose English names a spell, a talent, an area or a talent
//! tree carries the client's name for it. The client tables here are a few rows, no download.

use forge_i18n::audit::{audit_texts, format_table, lua_files, name_index, read_texts, Entry, Finding, KindNames, Text};
use std::collections::BTreeMap;

fn m(rows: &[(i64, &str)]) -> BTreeMap<i64, String> {
	rows.iter().map(|(k, v)| (*k, v.to_string())).collect()
}

fn kinds(rows: Vec<(&'static str, BTreeMap<i64, String>)>) -> KindNames {
	rows.into_iter().collect()
}

struct Tables {
	index: BTreeMap<String, Entry>,
}

fn tables() -> Tables {
	let skills = [(20, "Subtlety"), (21, "Holy"), (22, "Shadow Magic"), (23, "Feral Combat"), (24, "Pet - Wolf")];
	let skills_de = [(20, "Feingefühl"), (21, "Heilig"), (22, "Schattenmagie"), (23, "Wilder Kampf"), (24, "Tier - Wolf")];
	// The talent window's tabs: "Shadow" where the skill line says "Shadow Magic".
	let tabs = [(30, "Subtlety"), (31, "Holy"), (32, "Shadow"), (33, "Restoration")];
	let tabs_de = [(30, "Täuschung"), (31, "Heilig"), (32, "Schatten"), (33, "Wiederherst")];
	let english = kinds(vec![
		("spell", m(&[(1, "Mortal Strike"), (2, "Fire"), (3, "Holy Shock"), (4, "Smite"), (5, "Ratchet Bolt"), (6, "Holy Specialization")])),
		("area", m(&[(10, "Deeprun Tram"), (11, "Ratchet Docks")])),
		("skill", m(&skills)),
		("tree", m(&tabs)),
	]);
	let names = kinds(vec![
		("spell", m(&[(1, "Tödlicher Stoß"), (2, "Feuer"), (3, "Heiliger Schock"), (4, "Göttliche Pein"), (5, "Ratchet Bolt"), (6, "Heiligspezialisierung")])),
		("area", m(&[(10, "Die Tiefenbahn"), (11, "Ratchet Docks")])),
		("skill", m(&skills_de)),
		("tree", m(&tabs_de)),
	]);
	Tables { index: name_index(&names, &english) }
}

fn run(t: &Tables, en: &str, tr: &str) -> Vec<Finding> {
	audit_texts(&[Text { file: "f.lua".into(), line: 7, en: en.into(), tr: tr.into() }], &t.index)
}

fn count(en: &str, tr: &str) -> usize {
	run(&tables(), en, tr).len()
}

#[test]
fn a_name_of_several_words_must_stand_in_the_translation_in_any_case_and_with_other_endings() {
	assert_eq!(count("Use Mortal Strike on the boss", "Benutze Tödlicher Stoß beim Boss"), 0);
	assert_eq!(count("Use Holy Shock on the boss", "Nutze den Heiligen Schock beim Boss"), 0, "inflected: Heiliger -> Heiligen");
	let rows = run(&tables(), "Use Mortal Strike on the boss", "Benutze Mortal Strike beim Boss");
	assert_eq!(rows.len(), 1);
	let r = &rows[0];
	assert_eq!((r.kind.as_str(), r.en.as_str(), r.client.as_slice(), r.file.as_str(), r.line), ("spell", "Mortal Strike", &["Tödlicher Stoß".to_string()][..], "f.lua", 7));
}

#[test]
fn hyphens_and_spaces_of_the_translation_do_not_matter() {
	assert_eq!(count("Holy Specialization first", "Zuerst Heiligspezialisierung"), 0);
	assert_eq!(count("Holy Specialization first", "Zuerst Heilig-Spezialisierung"), 0);
	assert_eq!(count("Holy Specialization first", "Zuerst Heilig Spezialisierung"), 0);
	assert_eq!(count("Holy Specialization first", "Zuerst Göttliche Fertigkeit"), 1);
}

#[test]
fn names_of_a_language_with_no_spaces_a_short_one_is_needed_whole_a_longer_one_by_its_first_four() {
	let english = kinds(vec![("spell", m(&[(1, "Flame Shock"), (2, "Templar's Bulwark")]))]);
	let names = kinds(vec![("spell", m(&[(1, "烈焰震击"), (2, "圣殿骑士壁垒")]))]);
	let t = Tables { index: name_index(&names, &english) };
	assert_eq!(run(&t, "Use Flame Shock on it", "对它使用烈焰震击").len(), 0);
	assert_eq!(run(&t, "Use Flame Shock on it", "对它使用火焰冲击").len(), 1);
	assert_eq!(run(&t, "Templar's Bulwark is an absorb", "圣殿骑士壁垒是吸收").len(), 0);
	assert_eq!(run(&t, "Templar's Bulwark is an absorb", "圣殿壁垒是吸收").len(), 1, "the first four characters 圣殿骑士 are missing");
}

#[test]
fn the_findings_are_a_table_a_header_aligned_columns_the_english_cut_at_60_characters() {
	let row = |kind: &str, en: &str, client: &[&str], file: &str, line: usize, text: String| Finding {
		kind: kind.into(),
		en: en.into(),
		client: client.iter().map(|c| c.to_string()).collect(),
		file: file.into(),
		line,
		text,
		tr: "y".into(),
	};
	let rows = [row("spell", "Mortal Strike", &["Tödlicher Stoß", "Stoß"], "a.lua", 7, "x".repeat(80)), row("area", "Elwynn", &["Elwynn"], "b.lua", 12, "Short".into())];
	let lines = format_table(&rows);
	assert_eq!(lines.len(), 3);
	let re = regex::Regex::new;
	assert!(re(r"^ {2}kind +English name +client name +file:line +English text$").unwrap().is_match(&lines[0]), "{}", lines[0]);
	assert!(re(r"^ {2}spell +Mortal Strike +Tödlicher Stoß \| Stoß +a\.lua:7 +x{59}…$").unwrap().is_match(&lines[1]), "{}", lines[1]);
	let col = |l: &str, s: &str| l.find(s).map(|b| l[..b].chars().count());
	assert_eq!(col(&lines[1], "a.lua:7"), col(&lines[2], "b.lua:12"), "the columns line up");
}

#[test]
fn a_leading_article_of_the_clients_name_is_not_needed_in_the_text() {
	assert_eq!(count("Take the Deeprun Tram", "Nimm die Tiefenbahn"), 0);
}

#[test]
fn a_name_of_one_word_counts_only_as_the_whole_text() {
	assert_eq!(count("Fire the cannon", "Feuer die Kanone ab, ganz ohne Namen"), 0);
	assert_eq!(count("Fire", "Brand"), 1);
	assert_eq!(count("Smite", "Strafe"), 1);
}

#[test]
fn a_talent_tab_is_asked_for_by_its_name_and_a_role_in_brackets_is_left_out() {
	assert_eq!(count("Shadow", "Schatten"), 0, "the talent window says Schatten, the skill line Schattenmagie");
	assert_eq!(count("Shadow", "Dunkelheit"), 1);
	let rows = run(&tables(), "Shadow", "Dunkelheit");
	assert_eq!((rows[0].kind.as_str(), rows[0].en.as_str(), rows[0].client.as_slice()), ("tree", "Shadow", &["Schatten".to_string()][..]));
	assert_eq!(count("Restoration (healer)", "Wiederherstellung (Heiler)"), 0, "the tab is cut short by the client; the full word still carries it");
	assert_eq!(count("Holy (healer)", "Heilig (Heiler)"), 0);
	assert_eq!(count("Holy (healer)", "Göttlich (Priester)"), 1);
	assert_eq!(count("Shadow resistance", "Schattenwiderstand"), 0, "inside a sentence: an everyday word");
}

#[test]
fn a_name_the_client_gives_two_ways_is_carried_by_either() {
	// The skill line Subtlety is Feingefühl, the talent tab Täuschung.
	assert_eq!(count("Subtlety", "Täuschung"), 0);
	assert_eq!(count("Subtlety", "Feingefühl"), 0);
	let rows = run(&tables(), "Subtlety", "Raffinesse");
	assert_eq!((rows[0].kind.as_str(), rows[0].client.as_slice()), ("tree", &["Feingefühl".to_string(), "Täuschung".to_string()][..]));
}

#[test]
fn a_name_the_client_leaves_in_english_is_not_asked_for_and_a_name_inside_a_longer_one_is_not_found() {
	assert_eq!(count("Ratchet Bolt hits", "Ratchet-Blitz trifft"), 0);
	assert_eq!(count("The Ratchet Docks are closed", "Die Hafenanlagen sind zu"), 0);
	assert_eq!(count("Holy Shockwave", "Heilige Welle"), 0, "whole words only");
}

#[test]
fn placeholders_tokens_and_colour_codes_are_no_part_of_the_english() {
	assert_eq!(count("{npc:12} sells %s |cff00ff00Mortal Strike|r", "{npc:12} verkauft %s |cff00ff00Tödlicher Stoß|r"), 0);
	assert_eq!(count("{area:10} Holy Shock", "{area:10} Heiliger Schock"), 0);
}

#[test]
fn texts_are_read_from_the_lines_of_a_lua_file_escapes_decoded_empty_translations_and_comments_left_out() {
	let dir = forge_addontest::tmp::TempDir::new("polestar-audit-");
	let a = super::write(
		dir.path(),
		"a.lua",
		"local L = ns.L\nL[\"Holy \\\"Shock\\\"\"] = \"Heiliger \\\"Schock\\\"\"\n-- L[\"Smite\"] = \"\"\nL[\"Smite\"] = \"\"\n\t[\"Fire\"] = \"Feuer\",\n-- [\"Hide\"] = \"Verbergen\",\n",
	);
	let b = super::write(dir.path(), "sub/b.lua", "\t[\"Subtlety\"] = \"Täuschung\",\n");
	super::write(dir.path(), "sub/notes.txt", "[\"x\"] = \"y\"");
	let files = lua_files(dir.path());
	assert_eq!(files, vec![a, b]);
	let texts = read_texts(&files, &|p| p.file_name().unwrap().to_string_lossy().into_owned()).unwrap();
	let got: Vec<(&str, usize, &str, &str)> = texts.iter().map(|t| (t.file.as_str(), t.line, t.en.as_str(), t.tr.as_str())).collect();
	assert_eq!(got, vec![("a.lua", 2, "Holy \"Shock\"", "Heiliger \"Schock\""), ("a.lua", 5, "Fire", "Feuer"), ("b.lua", 1, "Subtlety", "Täuschung")]);
}
