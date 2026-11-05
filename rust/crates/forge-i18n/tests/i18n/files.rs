//! The keys, the format check, sync's edits, the file reader and the glossary (the tooling half of
//! tests/i18n.test.js).

use crate::{mini_addon, root, write};
use forge_guide::i18n_files::{new_locale_text, parse_locale_text, read_locale_files, update_locale_text, RETIRED};
use forge_guide::js::V;
use forge_i18n::format::format_problems;
use forge_i18n::glossary::{fold, glossary_warnings, read_glossary, Entry, TERMS};
use forge_i18n::keys::{extract_keys, DATA_KEYS};

#[test]
fn keys_are_the_literal_l_and_lc_calls_by_first_use_plus_the_data_keys() {
	let t = forge_addontest::tmp::TempDir::new("polestar-i18n-keys-");
	let (data_file, data_keys) = DATA_KEYS[0];
	write(
		t.path(),
		"A.lua",
		"local L = ns.L\nlocal HERE = { boat = L[\"Docked %s\"] }\nprint(L['Single'], L[ [[Long]] ], ns.LC(\"boss\", \"Chest\"), L[\"Shared\"])\n-- L[\"In a comment\"]\n--[[ L[\"In a block comment\"] ]]\nprint(\"L[\\\"In a string\\\"]\")\n",
	);
	write(t.path(), data_file, "local L = ns.L\nprint(L[\"Shared\"])\n");
	write(t.path(), "Gear/Weights.lua", "local SPECS = { { key = \"arms\", label = \"A spec\" } }\n");
	let keys = extract_keys(root(), t.path()).unwrap();
	for k in ["Docked %s", "Single", "Long", "boss: Chest", "Shared"] {
		assert!(keys.has(k), "{k:?} is not found");
	}
	for k in ["In a comment", "In a block comment", "In a string"] {
		assert!(!keys.has(k), "{k:?} is not code");
	}
	let shared: Vec<&str> = keys.get("Shared").unwrap().iter().map(|w| w.file.as_str()).collect();
	assert_eq!(shared, ["A.lua", data_file], "its first use comes first");
	assert_eq!(keys.get("Docked %s").unwrap()[0].line, 2);
	for k in data_keys.iter().copied().chain(["A spec"]) {
		assert!(keys.get(k).is_some_and(|w| w.iter().all(|u| u.data)), "{k:?}: a data key");
	}
}

#[test]
fn the_format_check_refuses_what_the_client_shows_broken_and_allows_numbered_reordering() {
	for (en, tr) in
		[("%d quests", "%d quêtes"), ("Step %d of %d", "Étape %d sur %d"), ("level %d %s", "%2$s niveau %1$d"), ("%d |4quest:quests;", "%d |4quête:quêtes;"), ("100%% done", "fini à 100 %%")]
	{
		assert_eq!(format_problems(en, tr), Vec::<String>::new(), "{en} / {tr}");
	}
	assert_eq!(format_problems("%d quests", "%s quêtes").len(), 1, "a number shown as text");
	assert_eq!(format_problems("%s from %s", "de %s").len(), 1, "a value dropped");
	assert_eq!(format_problems("%d |4quest:quests;", "%d quêtes").len(), 1, "the plural grammar dropped");
	assert_eq!(format_problems("|cffff0000Red|r", "Rouge").len(), 2, "a colour and its end dropped");
	assert_eq!(format_problems("level %d %s", "%2$s niveau %d").len(), 1, "numbered and plain mixed");
	assert_eq!(format_problems("%d done", "%d fini à 100 %").len(), 1, "a lone percent sign in a formatted string");
	assert_eq!(format_problems("Done", "Fini à 100 %"), Vec::<String>::new(), "a plain string is shown as it is");
	// A percent sign in a sentence ("10% off", "25% of", "8% to") is not "% o" or "% t": the key is shown
	// as it is (string.format never sees it) and its translations are free text.
	for (en, tr) in [
		("10% off at Honored", "Ehrfürchtig: 10 % Rabatt"),
		("Spiritual Guidance adds 25% of your Spirit to your healing but only 8% to your damage.", "Spirituelle Führung: 25 % der Willenskraft als Heilung, nur 8 % als Schaden."),
	] {
		assert!(!forge_i18n::format::formatted(en), "{en}");
		assert_eq!(format_problems(en, tr), Vec::<String>::new(), "{en} / {tr}");
	}
	// A space flag on a real specifier is still one: "% d" ends the word, and a key with %% is formatted.
	assert!(forge_i18n::format::formatted("% d left") && forge_i18n::format::formatted("25%% of %s"));
	// ...and its translations as string.format reads them: "25 % de" is "% d", a second value.
	assert_eq!(format_problems("25%% of %s", "25 % de %s"), ["specifiers % d %s do not match the English %s"]);
	assert_eq!(format_problems("25%% of %s", "25 %% de %s"), Vec::<String>::new());
	assert_eq!(format_problems("a || b", "a | b"), ["a lone | (the client reads it as an escape; write || for a bar)"]);
	assert_eq!(format_problems("%s", "%3$s"), ["%3$s: the English has no value 3", "value 1 (%s) is never shown"]);
}

const GERMAN: &str = "-- German (deDE). Hand-written header.

local _, ns = ...
if not (GetLocale and GetLocale() == \"deDE\") then return end
local L = ns.L

-- Main.lua
L[\"Hello %s\"] = \"Hallo %s\"
-- L[\"Bye\"] = \"\"
L[\"Gone\"] = \"Weg\"
-- L[\"Gone too\"] = \"\"

-- Main.lua (the slot)
L[\"slot: Back\"] = \"Rücken\"
";

/// A locale file's keys -> (kind, the files its group's header names), and the lines of its end block.
fn placed(text: &str) -> (Vec<(String, &'static str, Vec<String>)>, Vec<String>) {
	let doc = parse_locale_text(text, "test.lua").unwrap();
	let mut keys = Vec::new();
	for g in &doc.groups {
		for l in &g.lines {
			if l.kind == "entry" || l.kind == "todo" {
				keys.push((l.key.clone().unwrap(), l.kind, g.files.clone()));
			}
		}
	}
	let retired = if doc.tail.first().map(String::as_str) == Some(RETIRED) { doc.tail[1..].to_vec() } else { Vec::new() };
	(keys, retired)
}

fn find<'a>(keys: &'a [(String, &'static str, Vec<String>)], k: &str) -> Option<&'a (String, &'static str, Vec<String>)> {
	keys.iter().find(|x| x.0 == k)
}

/// Whether every one of `lines` is in `text`, in the same order.
fn in_order(lines: &[&str], text: &str) -> bool {
	let out: Vec<&str> = text.split('\n').collect();
	let mut at = 0;
	for l in lines {
		match out[at..].iter().position(|x| x == l) {
			Some(i) => at += i + 1,
			None => return false,
		}
	}
	true
}

#[test]
fn sync_adds_missing_keys_under_their_group_retires_lost_translations_and_leaves_the_rest() {
	let dir = mini_addon();
	let keys = extract_keys(root(), dir.path()).unwrap().by_file();
	let out = update_locale_text(GERMAN, "deDE.lua", &keys, &V::obj(), &V::obj()).unwrap();
	let gone = "L[\"Gone\"] = \"Weg\"";
	let kept: Vec<&str> = GERMAN.split('\n').filter(|l| *l != gone && *l != "-- L[\"Gone too\"] = \"\"").collect();
	assert!(in_order(&kept, &out.text), "every other line stays as it was, in order");
	let (p, retired) = placed(&out.text);
	assert_eq!(find(&p, "New in Main").map(|x| (x.1, x.2.clone())), Some(("todo", vec!["Main.lua".to_string()])), "commented out in a group of the file that uses it");
	assert_eq!(find(&p, "Close the window").map(|x| (x.1, x.2.clone())), Some(("todo", vec!["UI/Window.lua".to_string()])), "in a new group for its file");
	assert!(find(&p, "Gone").is_none() && find(&p, "Gone too").is_none(), "keys the code lost leave the groups");
	assert_eq!(retired, [format!("-- {gone}")], "the lost translation is kept, commented out, at the end");
	assert_eq!(out.added, ["New in Main", "Close the window"]);
	assert_eq!(out.retired, ["Gone"]);
	assert_eq!(out.dropped, ["Gone too"]);
	assert_eq!(update_locale_text(&out.text, "deDE.lua", &keys, &V::obj(), &V::obj()).unwrap().text, out.text, "a second sync changes nothing");
	assert_eq!(update_locale_text(&GERMAN.replace('\n', "\r\n"), "deDE.lua", &keys, &V::obj(), &V::obj()).unwrap().text, out.text, "Windows line endings sync the same, written back with \\n");
}

#[test]
fn a_new_file_has_every_key_commented_out_filled_ones_translated_unknown_ones_retired() {
	let dir = mini_addon();
	let keys = extract_keys(root(), dir.path()).unwrap();
	let fill = V::Obj(forge_guide::obj! { "Bye" => "Au revoir" });
	let retire = V::Obj(forge_guide::obj! { "Old" => "Vieux" });
	let out = new_locale_text("frFR", &keys.by_file(), &fill, &retire, "Polestar's interface strings").unwrap();
	let (p, retired) = placed(&out.text);
	assert_eq!(p.len(), keys.len());
	for (k, w) in &keys.list {
		let x = find(&p, k).unwrap();
		assert_eq!((x.1, x.2.clone()), (if k == "Bye" { "entry" } else { "todo" }, vec![w[0].file.clone()]), "{k}");
	}
	assert_eq!(retired, ["-- L[\"Old\"] = \"Vieux\""]);
	let file = write(dir.path(), "Locales/frFR.lua", &out.text);
	let f = file.to_string_lossy().into_owned();
	let r = read_locale_files(&[(f.clone(), "frFR".into()), (f, "deDE".into())]).unwrap();
	assert_eq!(r[0].layout.as_deref(), Some("L"));
	assert_eq!(r[0].strings.entries().iter().map(|(k, v)| (k.to_string(), v.to_js_string())).collect::<Vec<_>>(), [("Bye".to_string(), "Au revoir".to_string())], "it loads on its client");
	assert!(r[1].strings.keys().is_empty(), "and sets nothing on another");
	assert_eq!(update_locale_text(&out.text, "frFR.lua", &keys.by_file(), &V::obj(), &V::obj()).unwrap().text, out.text, "a sync changes nothing");
}

#[test]
fn the_reader_takes_polestars_layout_dings_add_translations_and_a_returned_table() {
	let t = forge_addontest::tmp::TempDir::new("polestar-i18n-read-");
	let files = [
		("ours.lua", "local _, ns = ...\nif not (GetLocale and GetLocale() == \"frFR\") then return end\nlocal L = ns.L\nL[\"Accept\"] = \"Accepter\"\n"),
		("ding.lua", "local _, ns = ...\nif ns.locale ~= \"frFR\" then return end\nns.AddTranslations(\"frFR\", {\n\t[\"Accept\"] = \"Accepter\",\n\t-- [\"Skip\"] = \"\",\n})\n"),
		("table.lua", "return { [\"Accept\"] = \"Accepter\" }\n"),
	];
	let entries: Vec<(String, String)> = files.iter().map(|(n, text)| (write(t.path(), n, text).to_string_lossy().into_owned(), "frFR".to_string())).collect();
	let r = read_locale_files(&entries).unwrap();
	assert_eq!(r.iter().map(|x| x.layout.clone().unwrap_or_default()).collect::<Vec<_>>(), ["L", "AddTranslations", "return"]);
	for x in &r {
		assert_eq!(x.strings.get("Accept").to_js_string(), "Accepter");
		assert_eq!(x.strings.keys().len(), 1);
	}
}

#[test]
fn glossary_warns_on_a_translation_without_its_word_and_every_glossary_names_known_terms() {
	let g = [Entry { id: "flight master".into(), term: "Maître de vol".into(), matches: vec![fold("maitre de vol"), fold("maitres de vol")], client: None }];
	let pairs: Vec<(String, String)> =
		[("Flight masters", "Maîtres de vol"), ("Walk to the flight master", "Allez voir le maître de vol"), ("Fly from the flight master", "Partez du griffon"), ("/pole flight master: where", "où")]
			.iter()
			.map(|(a, b)| (a.to_string(), b.to_string()))
			.collect();
	let w = glossary_warnings(Some(&g), &pairs);
	assert_eq!(w.iter().map(|x| x.key.as_str()).collect::<Vec<_>>(), ["Fly from the flight master"]);
	let dir = root().join(forge_i18n::DATA_DIR).join("glossary");
	let mut n = 0;
	for e in std::fs::read_dir(&dir).unwrap().flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		let Some(locale) = name.strip_suffix(".json") else { continue };
		assert!(forge_guide::locales::locale(locale).is_some(), "{name}: not a locale Polestar ships");
		for entry in read_glossary(locale, &dir).unwrap().unwrap() {
			assert!(TERMS.iter().any(|(t, _)| *t == entry.id), "{name}: {}", entry.id);
		}
		n += 1;
	}
	assert!(n > 0, "the glossaries are in {}", dir.display());
	let bad = forge_addontest::tmp::TempDir::new("polestar-i18n-gloss-");
	write(bad.path(), "deDE.json", "{ \"nonsense\": { \"term\": \"x\" } }");
	assert!(read_glossary("deDE", bad.path()).unwrap_err().contains("is not a glossary term"));
}
