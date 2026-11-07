//! `forge i18n`: status lists every locale, check passes on the shipped files and refuses an unknown
//! locale, and `guides sync|check` write and check a pack's texts files (tests/i18n.test.js and
//! tests/guide-texts.test.js, the CLI parts).

use std::path::{Path, PathBuf};
use std::process::Command;

fn root() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

fn forge(args: &[&str]) -> Run {
	let r = Command::new(env!("CARGO_BIN_EXE_forge")).arg("i18n").args(args).arg("--root").arg(root()).output().unwrap();
	Run { status: r.status.code().unwrap_or(-1), stdout: String::from_utf8_lossy(&r.stdout).into_owned(), stderr: String::from_utf8_lossy(&r.stderr).into_owned() }
}

#[test]
fn status_lists_every_locale_with_its_status_and_translators() {
	let r = forge(&["status", "--json"]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	let out: serde_json::Value = serde_json::from_str(&r.stdout).unwrap();
	let keys = out["keys"].as_u64().unwrap();
	let locales = out["locales"].as_array().unwrap();
	assert_eq!(locales.len(), forge_guide::locales::LOCALES.len());
	for (l, want) in locales.iter().zip(&forge_guide::locales::LOCALES) {
		assert_eq!(l["locale"], want.code);
		assert_eq!(l["status"], want.status);
		assert_eq!(l["translators"].as_array().unwrap().len(), want.translators.len());
		let file = root().join("addon/Polestar/Locales").join(format!("{}.lua", want.code)).exists();
		assert_eq!(l["file"], file);
		if file {
			let n = l["translated"].as_u64().unwrap();
			assert!(n > 0 && n <= keys, "{}: {n}/{keys}", want.code);
		}
	}
}

#[test]
fn check_passes_on_the_shipped_files_and_refuses_an_unknown_locale() {
	let r = forge(&["check"]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert!(r.stdout.starts_with("Polestar:\n"), "{}", r.stdout);
	assert!(r.stdout.contains("\nPolestar_Recorder:\n"));
	assert!(r.stdout.contains("\nPolestar_Mob_Markers:\n"));
	let bad = forge(&["check", "xxXX"]);
	assert_eq!(bad.status, 2);
	assert!(bad.stderr.starts_with("forge i18n: unknown locale \"xxXX\""), "{}", bad.stderr);
	assert_eq!(forge(&["bogus"]).status, 2);
	assert_eq!(forge(&["check", "--nope"]).status, 2);
}

const GUIDE: &str = "guide texts/main
title Elwynn Forest
faction Alliance
levels 1-10
zone Elwynn Forest
folder Warrior

step Marshal McBride
  tip Marshal McBride stands at the abbey door; Brother Danil sells food inside. Kobold Vermin crowd the camp to the north.
  accept 7 -- Marshal McBride
  kill 6 quest 7 -- a few Kobold Vermin at a time
  turnin 7 -- Marshal McBride; he also trains you
";

#[test]
fn guides_sync_writes_every_text_with_its_names_and_check_fails_on_a_lost_token_and_names_the_new_english() {
	let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("i18n-texts-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(dir.join("guides")).unwrap();
	std::fs::write(dir.join("pack.json"), r#"{"id":"texts","title":"Texts Pack","author":"Ann","version":"1.0.0","license":"CC0-1.0","folder":"PolestarPack_Texts"}"#).unwrap();
	std::fs::write(dir.join("guides/main.guide"), GUIDE).unwrap();
	let data = root().join("tests/fixtures/dsl/data");
	let (d, p) = (data.to_string_lossy().into_owned(), dir.to_string_lossy().into_owned());
	let i18n = |cmd: &str| forge(&["guides", cmd, "frFR", "--pack", &p, "--data", &d]);
	let sync = i18n("sync");
	assert_eq!(sync.status, 0, "{}", sync.stderr);
	let file = dir.join("locales/frFR/guides/main.lua");
	let text = std::fs::read_to_string(&file).unwrap();
	assert!(text.contains("-- {npc:197} Marshal McBride · {npc:152} Brother Danil · {npc:6} Kobold Vermin\n"), "{text}");
	assert!(text.contains("[\"a few {npc:6} at a time\"] = \"\","));
	assert!(!text.contains("[\"{npc:197}\"]"), "a text that is only a name needs no words");
	std::fs::write(&file, text.replace("[\"a few {npc:6} at a time\"] = \"\"", "[\"a few {npc:6} at a time\"] = \"quelques-uns à la fois\"")).unwrap();
	let lost = i18n("check");
	assert_eq!(lost.status, 1);
	assert!(lost.stderr.contains("leaves out {npc:6}"), "{}", lost.stderr);
	std::fs::write(&file, std::fs::read_to_string(&file).unwrap().replace("\"quelques-uns à la fois\"", "\"quelques {npc:6} à la fois\"")).unwrap();
	std::fs::write(dir.join("guides/main.guide"), GUIDE.replace("-- a few Kobold Vermin at a time", "-- a few Kobold Vermin at once")).unwrap();
	let stale = i18n("check");
	assert_eq!(stale.status, 1);
	assert!(stale.stderr.contains("stale translation of \"a few {npc:6} at a time\" (its English is now \"a few {npc:6} at once\""), "{}", stale.stderr);
	let again = i18n("sync");
	assert_eq!(again.status, 0, "{}", again.stderr);
	assert!(std::fs::read_to_string(&file).unwrap().contains("-- [\"a few {npc:6} at a time\"] = \"quelques {npc:6} à la fois\","), "the old translation waits for its translator");
	let clean = i18n("check");
	assert_eq!(clean.status, 0, "{}", clean.stderr);
	let _ = std::fs::remove_dir_all(&dir);
}

/// `i18n audit` (tests/i18n-audit.test.js, the command): no finding is exit 0 with a JSON document;
/// no client tables is exit 1 with the reason.
#[test]
fn audit_with_no_finding_is_exit_0_and_with_no_client_tables_exit_1() {
	let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("i18n-audit-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&dir);
	for locale in [None, Some("deDE")] {
		let mut at = dir.join("wago/1.60.1.1");
		if let Some(l) = locale {
			at = at.join(l);
		}
		std::fs::create_dir_all(&at).unwrap();
		for (table, field) in [("SpellName", "Name_lang"), ("AreaTable", "AreaName_lang"), ("SkillLine", "DisplayName_lang"), ("TalentTab", "Name_lang")] {
			std::fs::write(at.join(format!("{table}.csv")), format!("ID,{field}\n1,Zzyzx Qwerty Name {}\n", locale.unwrap_or("en"))).unwrap();
		}
	}
	let sources = dir.to_string_lossy().into_owned();
	let ok = forge(&["audit", "deDE", "--json", "--offline", "--build", "1.60.1.1", "--sources", &sources]);
	assert_eq!(ok.status, 0, "{}", ok.stderr);
	let doc: serde_json::Value = serde_json::from_str(&ok.stdout).unwrap();
	assert_eq!(doc["build"], "1.60.1.1");
	assert_eq!(doc["findings"].as_array().unwrap().len(), 0);
	assert!(doc["checked"]["deDE"]["texts"].as_u64().unwrap() > 1000, "the shipped German texts were read");
	let none = forge(&["audit", "frFR", "--offline", "--sources", &sources]);
	assert_eq!(none.status, 1);
	assert!(none.stderr.contains("no forever client tables"), "{}", none.stderr);
	let _ = std::fs::remove_dir_all(&dir);
}
