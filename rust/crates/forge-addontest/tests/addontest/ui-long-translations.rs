//! Long translations on the settings window: Options > Profiles' "In use" chip sits on the profile's picture, so a long
//! one ("Используется") never narrows the profile's name (beside the name it left "По умолчанию" 20px); the
//! previews' sample names (Kobold Vermin, the Deadmines, Elwynn Forest) are the game's in the client's language
//! (Polestar.Names.Or), Polestar's own strings in English.

use forge_addontest::{emitted, lua_string, run::toc_files, Addon, RunAddon};
use serde_json::{json, Value};

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The UI stub, its login and the settings window's addon; `pre`, then the Profiles page open; then `script`.
fn run_page(pre: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &UI_FILES)],
		script: format!(
			r#"uistub.install()
		stub.login()
		UI = Polestar.UI
		{pre}
		UI.LoadOptions()
		PV = UI.Profiles
		UI.ShowOptions("profiles")
		v = PV.views["Profiles"]
		function card(name) return v.CardRow.psCardBy[name] end
		{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_in_use_chip_sits_on_the_picture_and_leaves_the_profile_its_whole_name() {
	let out = run_page(
		r#"Polestar.L["In use"] = "Используется""#,
		r#"local c = card("Default")
		local chip
		for owner, ch in pairs(v.Chips) do if owner == c then chip = ch end end
		local _, rel = chip:GetPoint(1)
		emit({ name = c.Name:GetWidth(), card = c:GetWidth(), onArt = rel == c.Art, shown = chip:IsShown() })"#,
	);
	assert_eq!(out["shown"], true, "{out}");
	assert_eq!(out["onArt"], true, "the chip on the picture: {out}");
	assert_eq!(out["name"].as_f64(), out["card"].as_f64().map(|w| w - 20.0), "the name keeps the card's width: {out}");
}

// A German client with its language folder (the game's names in Names.lua): the previews' samples in German.
#[test]
fn the_previews_sample_names_are_the_games_in_the_clients_language() {
	let files = toc_files("Polestar_deDE").unwrap().iter().map(|f| lua_string(&f.to_string_lossy())).collect::<Vec<_>>().join(", ");
	let german = emitted(&RunAddon {
		stubs: vec!["stub_packs.lua"],
		before: format!("function GetLocale() return \"deDE\" end\nstub.packs.Polestar_deDE = {{ {files} }}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: r#"local N = Polestar.Names
emit({ N.Or("npc", 6, "Kobold Vermin"), N.Or("item", 773, "Gold Dust"), N.Or("map", 36, "The Deadmines") })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(german, json!(["Koboldgezücht", "Goldstaub", "Todesminen"]));
	let english =
		emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], script: r#"emit(Polestar.Names.Or("npc", 6, "Kobold Vermin"))"#.into(), ..Default::default() }).remove(0);
	assert_eq!(english, "Kobold Vermin");
}
