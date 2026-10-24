//! No English on a non-English client (tests/i18n-leaks.test.js). The addon runs in Russian and in
//! Simplified Chinese with its shipped translations, names packs and guide texts, through a
//! representative set of scenes; a Latin word left on screen that is none of the locale's own words,
//! not allowed and not a baselined name fails, as does a baseline name that no longer shows. The
//! scenes need the Codex and the quest database built (a developer's machine): without them they are
//! skipped. The check itself runs everywhere: planted English is found with its scene, the language's
//! own words, the client's names and the allowed names are not.

use crate::root;
use forge_guide::js::{parse_json, V};
use forge_i18n::leaks::{self, check_run, load_allow, load_baseline, run_scene, Check, DataNames, Scene};
use std::sync::LazyLock;

const LOCALES: [&str; 2] = ["ruRU", "zhCN"];
const SCENES: [&str; 6] = ["guide", "options", "picker", "lookup", "dungeons", "rares"];

/// The runs of every scene in both locales, once for the tests below.
static RUNS: LazyLock<Result<String, String>> = LazyLock::new(|| {
	let scenes: Vec<Scene> = SCENES.iter().map(|s| leaks::scene(root(), s, &[]).unwrap()).collect();
	let locales: Vec<String> = LOCALES.iter().map(|l| l.to_string()).collect();
	leaks::find_leaks(root(), &locales, &scenes, None, &mut |_| {}).map(|r| forge_guide::js::stringify(&V::from(r), None))
});

fn runs() -> Vec<V> {
	parse_json(RUNS.as_ref().unwrap_or_else(|e| panic!("{e}"))).unwrap().items()
}

fn describe(r: &V, l: &V) -> String {
	let text = l.get("text").to_js_string();
	let words: Vec<String> = l.get("words").items().iter().map(V::to_js_string).collect();
	let site = l.get("site").at(0);
	format!(
		"{} {}, {}: \"{}\" ({}; set at {})",
		r.get("locale").to_js_string(),
		r.get("scene").to_js_string(),
		l.get("scenes").at(0).to_js_string(),
		if text.chars().count() > 140 { format!("{}...", text.chars().take(137).collect::<String>()) } else { text },
		words.join(", "),
		if site.truthy() { site.to_js_string() } else { "?".into() }
	)
}

#[test]
fn every_scene_runs_to_the_end_and_every_word_on_screen_is_in_the_clients_language() {
	let all = runs();
	for scene in SCENES {
		let list: Vec<&V> = all.iter().filter(|r| r.get("scene").as_str() == Some(scene) && !r.get("skipped").truthy()).collect();
		if list.is_empty() {
			eprintln!("skipped {scene}: {}", all.iter().find(|r| r.get("scene").as_str() == Some(scene)).map(|r| r.get("skipped").to_js_string()).unwrap_or_default());
			continue;
		}
		let errors: Vec<String> =
			list.iter().flat_map(|r| r.get("errors").items().into_iter().map(move |e| format!("{} {scene}: {}", r.get("locale").to_js_string(), e.get("error").to_js_string()))).collect();
		assert!(errors.is_empty(), "a scene stopped with an error, so it did not show everything:\n{}", errors.join("\n"));
		for r in &list {
			assert!(r.get("texts").num() > 10.0, "{} {scene}: only {} texts", r.get("locale").to_js_string(), r.get("texts").to_js_string());
		}
		let found: Vec<String> = list.iter().flat_map(|r| r.get("leaks").items().into_iter().map(move |l| describe(r, &l))).collect();
		assert!(found.is_empty(), "English on screen:\n{}", found.join("\n"));
	}
}

#[test]
fn the_baseline_lists_only_names_that_still_show_in_english() {
	let stale: Vec<String> = leaks::stale_baseline(&runs(), &load_baseline(root()).unwrap())
		.iter()
		.map(|(l, k, e)| format!("{l} {k} ({})", e.get("scenes").items().iter().map(V::to_js_string).collect::<Vec<_>>().join(", ")))
		.collect();
	assert!(stale.is_empty(), "these names no longer show in English: remove them from data/i18n/leaks-baseline.json:\n{}", stale.join("\n"));
}

/// One locale through a scene of the test's own, checked without the reference data's names.
fn planted(locale: &str, script: &str, before: &str, every_step: bool, baseline: Option<V>) -> V {
	let scene = Scene { name: "test".into(), script: script.into(), before: before.into(), every_step, ..Scene::default() };
	let allow = load_allow(root()).unwrap();
	let dump = parse_json(&run_scene(root(), locale, &scene, &allow, false).unwrap()).unwrap();
	let baseline = baseline.unwrap_or_else(|| load_baseline(root()).unwrap());
	check_run(locale, "test", &dump, &allow, &Check { classify: false, baseline: &baseline, full_data: false }, &mut DataNames::new(root()))
}

fn mine(r: &V, scene: &str) -> Vec<V> {
	r.get("leaks").items().into_iter().filter(|l| l.get("scenes").items().iter().any(|s| s.as_str() == Some(scene))).collect()
}

fn words(l: &V) -> Vec<String> {
	l.get("words").items().iter().map(V::to_js_string).collect()
}

#[test]
fn english_the_code_shows_is_found_with_its_scene_and_the_language_the_names_and_the_allowed_names_are_not() {
	let r = planted(
		"deDE",
		r#"
leaks.try("a test window", function()
	local f = CreateFrame("Frame", nil, UIParent)
	local fs = f:CreateFontString()
	fs:SetText("Kill ten wolves near the farm")
	fs:SetText(Polestar.L["Open settings"])
	fs:SetText(UnitName("player") .. " · " .. C_Map.GetMapInfo(1429).name .. " · Polestar · /polestar guides")
	GameTooltip:SetOwner(UIParent)
	GameTooltip:AddLine("Left-click to open")
end)"#,
		"",
		false,
		None,
	);
	assert!(r.get("errors").is_empty(), "{}", forge_guide::js::stringify(&r.get("errors"), None));
	let m = mine(&r, "a test window");
	assert_eq!(m.iter().map(|l| l.get("text").to_js_string()).collect::<Vec<_>>(), ["Kill ten wolves near the farm", "Left-click to open"]);
	assert!(words(&m[0]).iter().any(|w| w == "wolves"), "{:?}", words(&m[0]));
}

#[test]
fn author_credits_keep_proper_names_while_their_label_and_prose_are_checked() {
	let r = planted(
		"zhCN",
		r#"
Polestar.RegisterPack({ addon="Polestar_Test", id="test", format=1, title="Test", author="NorthernScribe", version="1", license="MIT" })
Polestar.RegisterGuide({ id="test/credits", pack="test", title="署名", author="NorthernScribe", minLevel=1, maxLevel=60, steps={{goals={{t="note",text="说明"}}}}})
leaks.try("author credit", function()
	local fs=CreateFrame("Frame",nil,UIParent):CreateFontString()
	fs:SetText(string.format(Polestar.L["By %s"],"NorthernScribe"))
	fs:SetText("NorthernScribe says kill ten wolves")
	fs:SetText("Author: NorthernScribe")
end)"#,
		"",
		false,
		None,
	);
	assert!(r.get("errors").is_empty());
	let m = mine(&r, "author credit");
	assert_eq!(m.iter().map(|l| l.get("text").to_js_string()).collect::<Vec<_>>(), ["NorthernScribe says kill ten wolves", "Author: NorthernScribe"]);
	assert!(words(&m[0]).iter().any(|w| w == "wolves"));
	assert!(words(&m[1]).iter().any(|w| w == "Author"));
}

const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest";
const DROPPED: [&str; 2] = ["Young Wolves and Timber Wolves roam the fields right around the Abbey.", "Back to the Cathedral of Light."];

/// English a Russian or Chinese client must never see, each found with its scene: an interface string
/// "translated" as its English, English the code writes in words a translation elsewhere also uses, a
/// guide text whose translation is gone, and prose after a slash command.
#[test]
fn english_is_found_with_its_scene_even_where_a_translation_uses_the_same_words() {
	for locale in LOCALES {
		let drop = DROPPED.iter().map(|d| format!("[{}] = true", leaks::quote(d))).collect::<Vec<_>>().join(", ");
		let r = planted(
			locale,
			&format!(
				r#"
leaks.try("the accept button", function()
	rawset(Polestar.L, "Accept", "Accept")
	CreateFrame("Frame", nil, UIParent):CreateFontString():SetText(Polestar.L["Accept"])
end)
leaks.try("a hard-coded label", function() CreateFrame("Frame", nil, UIParent):CreateFontString():SetText("Open the guide path") end)
leaks.try("a slash hint", function() CreateFrame("Frame", nil, UIParent):CreateFontString():SetText("/polestar guides to pick one") end)
leaks.try("the Elwynn guide", function()
	local E = Polestar.Engine
	E.SetGuide({}); stub.advance(0.3)
	if PolestarGuideFrame then PolestarGuideFrame:Show() end
	for i = 1, E.GetStepCount() do E.Goto(i); stub.advance(0.1) end
end)"#,
				leaks::quote(ELWYNN)
			),
			&format!("LEAKS.drop = {{ {drop} }}"),
			true,
			Some(V::Obj(forge_guide::obj! { "reasons" => V::obj(), "entries" => V::obj() })),
		);
		assert!(r.get("errors").is_empty(), "{locale}: {}", forge_guide::js::stringify(&r.get("errors"), None));
		let found = |scene: &str, pred: &dyn Fn(&V) -> bool| mine(&r, scene).into_iter().find(|l| pred(l));
		assert!(found("the accept button", &|l| l.get("text").as_str() == Some("Accept")).is_some(), "{locale}: a translation equal to its English");
		assert!(found("a hard-coded label", &|l| l.get("text").as_str() == Some("Open the guide path")).is_some(), "{locale}: English in the code");
		let slash = found("a slash hint", &|l| l.get("text").to_js_string().starts_with("/polestar guides")).unwrap_or_else(|| panic!("{locale}: the slash hint"));
		assert!(words(&slash).iter().any(|w| w == "pick") && !words(&slash).iter().any(|w| w == "guides"), "{locale}: the prose after a slash command, not the command");
		for d in DROPPED {
			assert!(found("the Elwynn guide", &|l| l.get("text").to_js_string().contains(d)).is_some(), "{locale}: the dropped guide text \"{d}\"");
		}
	}
}

#[test]
fn the_allow_list_patterns_compile_and_cut_what_they_allow() {
	let allow = load_allow(root()).unwrap();
	let flagged: Vec<String> = ["see", "docs", "Polestar", "guides", "pick"].iter().map(|s| s.to_string()).collect();
	let left = leaks::leak_words("see docs/TRANSLATING.md · Polestar · https://polestar.gg/x · /polestar guides to pick", &flagged, &allow, "ruRU");
	assert_eq!(left, ["see", "pick"]);
}
