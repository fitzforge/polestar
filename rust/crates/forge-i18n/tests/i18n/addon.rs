//! The addon in its languages (tests/i18n.test.js): game terms in the client's words, race names,
//! each shipped language loaded before the code that reads L at load, the AI-made list, Options' About.

use crate::{polestar, root, shipped};
use forge_addontest::locale::fake_locale;
use forge_addontest::run::{emitted, Addon, RunAddon};
use forge_i18n::project::locale_state;
use serde_json::json;

fn core(files: &[&str]) -> Vec<Addon> {
	vec![Addon::files("Polestar", files)]
}

#[test]
fn game_terms_come_in_the_clients_words() {
	let out = emitted(&RunAddon {
		before: "function GetText(tag, sex) return sex == 3 and _G[tag .. \"_FEMALE\"] or _G[tag] end
function UnitSex() return 3 end
FACTION_STANDING_LABEL8, FACTION_STANDING_LABEL8_FEMALE = \"Exalté\", \"Exaltée\"
ITEM_QUALITY3_DESC, FACTION_HORDE, BACKSLOT = \"Rare\", \"Horde\", \"Dos\""
			.into(),
		addons: core(&["Core/Core.xml", "Gear/Gear.xml"]),
		script: "emit({ Polestar.StandingName(8), Polestar.QualityName(3), Polestar.FactionName(\"H\"), Polestar.Gear.SlotName(15), Polestar.StandingName(9) or false })".into(),
		..RunAddon::default()
	});
	assert_eq!(out[0], json!(["Exaltée", "Rare", "Horde", "Dos", false]));
}

#[test]
fn race_names_come_in_the_clients_words_and_skyborne_reads_its_key() {
	let out = emitted(&RunAddon {
		before: format!(
			"{}
local NAMES = {{ [1] = \"Umano\", [5] = \"Non morto\", [23] = \"Gilneano\", [95] = \"Celestiale dell'Ordine Supremo\" }}
C_CreatureInfo = {{ GetRaceInfo = function(id) return NAMES[id] and {{ raceName = NAMES[id], raceID = id }} end }}",
			fake_locale("itIT", &[("Skyborne", "Celestiale"), ("Human", "Umano (chiave)")])
		),
		addons: core(&["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"]),
		script: "local U = Polestar.UI\nemit({ U.RaceName(\"Human\"), U.RaceName(\"Scourge\"), U.RaceName(\"Skyborne\"), U.RaceName(\"Orc\") })".into(),
		..RunAddon::default()
	});
	assert_eq!(out[0], json!(["Umano", "Non morto", "Celestiale", "Orc"]));
}

#[test]
fn each_shipped_language_loads_before_the_code_that_reads_l_at_load() {
	let locales = shipped();
	let st = locale_state(root(), &polestar(), &locales, None).unwrap();
	for l in &locales {
		let out = emitted(&RunAddon {
			before: format!("function GetLocale() return \"{l}\" end"),
			addons: core(&["Core/Core.xml"]),
			script: "emit(BINDING_NAME_POLESTAR_TOGGLE)".into(),
			..RunAddon::default()
		});
		assert_eq!(out[0].as_str(), st.locale(l).unwrap().translation("Toggle guide window"), "{l}");
	}
	let en = emitted(&RunAddon { addons: core(&["Core/Core.xml"]), script: "emit(BINDING_NAME_POLESTAR_TOGGLE)".into(), ..RunAddon::default() });
	assert_eq!(en[0], json!("Toggle guide window"));
}

#[test]
fn the_lua_list_of_ai_made_locales_is_locales_rs() {
	let out = emitted(&RunAddon { addons: core(&["Core/Init.lua"]), script: "emit(Polestar.AI_LOCALES)".into(), ..RunAddon::default() });
	let mut got: Vec<&str> = out[0].as_object().unwrap().keys().map(String::as_str).collect();
	got.sort();
	let want: Vec<&str> = forge_guide::locales::LOCALES.iter().filter(|l| l.status == "ai").map(|l| l.code).collect();
	assert_eq!(got, want);
}

/// Options > About on a client: the AI line's text, or false when hidden.
fn about_note(before: &str, between: &str) -> serde_json::Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: core(&["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"]),
		script: format!(
			"{between}\nuistub.install()\nstub.login()\nPolestar.UI.ShowOptions(\"about\")
local v = Polestar.UI.Options.view
emit(v.AINote:IsShown() and {{ note = v.AINote:GetText(), link = v.AILink.Label:GetText(), url = Polestar.DiscordURL }} or false)"
		),
		..RunAddon::default()
	})
	.remove(0)
}

#[test]
fn options_about_says_an_ai_made_translation_is_one_with_the_discord_invite() {
	let ai = about_note(&fake_locale("itIT", &[("A translated text", "Un testo tradotto")]), "Polestar.AI_LOCALES.itIT = true");
	assert!(ai["note"].as_str().is_some_and(|n| !n.is_empty()), "the note shows: {ai}");
	let url = ai["url"].as_str().unwrap();
	assert_eq!(ai["link"].as_str().unwrap(), url.split_once("://").map_or(url, |(_, r)| r), "with the Discord invite");
	assert_eq!(about_note(&fake_locale("itIT", &[]), "Polestar.AI_LOCALES.itIT = true"), json!(false), "no translation loaded: English, no note");
	assert_eq!(about_note("function GetLocale() return \"deDE\" end", ""), json!(false), "reviewed");
	assert_eq!(about_note("", ""), json!(false), "English");
}
