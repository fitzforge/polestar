//! The 0.4.3 "What's new" card (addon/Polestar/UI/LayoutCard.lua, #3629) against the real Core + Theme + UI
//! manifests, the Atlas layout and the fake Engine of tests/lua/stub_ui.lua: once per account after an update from
//! before 0.4.3, never on a fresh install; Your current design / Atlas and the four tab styles switch the real
//! window live; the guide window's setup is saved as "Before Atlas (<date>)" when the card opens; Keep this commits,
//! the ✕ and Escape put the saved setup back key for key; the saved setup stays in Presets, and a Presets card picked
//! over the player's own look saves that look first.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Ten window settings a player tuned, saved on 0.4.2 (and What's new's notes seen).
const TUNED: &str = r#"PolestarDB = { schema = 1, welcomeSeen = 1, whatsNewSeen = "0.4.0",
	settings = { ui = { scale = 1.2, width = 380, skin = "hearth", pos = { 300, 700 } },
		guideWindow = { tabStyle = "edge", padding = 10, rowSpacing = 4, titleSize = 1.1, goalSize = 1.15, bgOpacity = 0.6, idleAlpha = 0.5 } } }
PolestarCharDB = { schema = 1, welcomeSeen = 1 }"#;

const TEN: &str = r#"local TEN = { "ui.scale", "ui.width", "ui.skin", "ui.pos", "guideWindow.tabStyle", "guideWindow.padding", "guideWindow.rowSpacing",
	"guideWindow.titleSize", "guideWindow.goalSize", "guideWindow.bgOpacity", "guideWindow.idleAlpha" }
local function tuned()
	local out = {}
	for i, k in ipairs(TEN) do out[i] = Polestar.GetStored(k) end
	out[#out + 1] = Polestar.GetStored("ui.layout") or false
	return out
end
local LC = Polestar.UI.LayoutCard
local function card() return PolestarLayoutCard ~= nil and PolestarLayoutCard:IsShown() end"#;

// uistub.install marks the card seen for every other UI test; here the account keeps what it saved.
fn run_with(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES), Addon::name("Polestar_Layout_Atlas")],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!("local savedCard = PolestarDB and PolestarDB.layoutCardSeen\nuistub.install()\nPolestar.DB().layoutCardSeen = savedCard\nstub.login()\n{TEN}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn after_an_update_it_shows_once_the_buttons_switch_the_real_window_live_and_keep_this_commits() {
	let out = run_with(
		r#"
		local atLogin = card()
		stub.advance(6)
		local opened = LC.State()
		local before = tuned()
		local snap = LC.Snapshots()[1]
		LC.frame.Atlas:Click()
		local atlas = { layout = Polestar.Theme.LayoutId(), tabStyle = Polestar.Get("guideWindow.tabStyle"), lit = LC.State().atlas, rest = tuned() }
		LC.frame.Styles[4]:Click()
		local strip = { Polestar.Get("guideWindow.tabStyle"), LC.State().styles }
		LC.frame.Current:Click()
		local back = { tuned(), LC.State().current }
		LC.frame.Atlas:Click()
		LC.frame.Keep:Click()
		emit({ atLogin = atLogin, opened = opened, before = before, snapName = snap.name, snapLayout = snap.values["ui.layout"] or false,
			atlas = atlas, strip = strip, back = back, kept = { Polestar.Theme.LayoutId(), card(), PolestarDB.layoutCardSeen, #LC.Snapshots() } })"#,
		Some(TUNED),
	);
	assert_eq!(out["atLogin"], false, "a few seconds after login");
	let opened = &out["opened"];
	assert_eq!(opened["shown"], true);
	assert_eq!(json!([opened["current"], opened["atlas"]]), json!([true, false]), "the player's design is the one showing");
	assert_eq!(opened["styles"], json!([["underline", false], ["switcher", false], ["edge", true], ["strip", false]]), "the tab style showing is marked");
	assert_eq!(opened["credit"], "Atlas layout and tab styles by TTik3r");
	assert_eq!(opened["saved"], "Your current setup is saved; you can go back to it any time in Settings > Guide window > Presets.");
	assert!(out["snapName"].as_str().unwrap().starts_with("Before Atlas ("), "{}", out["snapName"]);
	assert_eq!(out["snapLayout"], false, "the snapshot holds Polestar's own layout");
	assert_eq!(json!([out["atlas"]["layout"], out["atlas"]["lit"]]), json!(["atlas", true]), "Atlas on the real window");
	assert_eq!(out["atlas"]["tabStyle"], "edge", "Atlas writes only its own key: the player's tab style stays");
	let mut rest = out["before"].clone();
	rest.as_array_mut().unwrap().pop();
	let mut with_atlas = rest.clone();
	with_atlas.as_array_mut().unwrap().push(json!("atlas"));
	assert_eq!(out["atlas"]["rest"], with_atlas, "nothing else written");
	assert_eq!(out["strip"][0], "strip");
	assert_eq!(out["strip"][1][3], json!(["strip", true]));
	assert_eq!(out["back"][0], out["before"], "Your current design: every key as it was, the tab style too");
	assert_eq!(out["back"][1], true);
	assert_eq!(out["kept"], json!(["atlas", false, "0.4.3", 1]), "Keep this: Atlas stays, the card is seen, the snapshot stays in Presets");
	// The next login, with what this one saved.
	let again = run_with(
		"stub.advance(10)\nemit({ shown = card() })",
		Some("PolestarDB = { schema = 1, welcomeSeen = 1, whatsNewSeen = \"0.4.0\", layoutCardSeen = \"0.4.3\", settings = {} }\nPolestarCharDB = { schema = 1, welcomeSeen = 1 }"),
	);
	assert_eq!(again["shown"], false, "once per account");
}

// Closing with the ✕ or Escape puts back every key the snapshot holds: the ten tuned settings, the layout and the
// tab style, whatever was tried.
#[test]
fn the_close_button_and_escape_put_the_setup_back_key_for_key() {
	for how in ["close", "escape"] {
		let out = run_with(
			&format!(
				r#"
				stub.advance(6)
				local before = tuned()
				LC.frame.Atlas:Click()
				LC.frame.Styles[2]:Click()
				local tried = {{ Polestar.Theme.LayoutId(), Polestar.Get("guideWindow.tabStyle") }}
				if "{how}" == "close" then LC.frame.Close:Click() else PolestarLayoutCard:Hide() end
				emit({{ before = before, tried = tried, after = tuned(), shown = card(), seen = PolestarDB.layoutCardSeen, layout = Polestar.Theme.LayoutId() or false }})"#
			),
			Some(TUNED),
		);
		assert_eq!(out["tried"], json!(["atlas", "switcher"]), "{how}");
		assert_eq!(out["after"], out["before"], "{how}: all identical");
		assert_eq!(json!([out["shown"], out["seen"], out["layout"]]), json!([false, "0.4.3", false]), "{how}: closed for good, Polestar's own layout");
	}
}

#[test]
fn a_fresh_install_never_sees_it_install_s_look_step_offers_the_layout() {
	let out = run_with("stub.advance(10)\nemit({ shown = card(), seen = PolestarDB.layoutCardSeen, snaps = #LC.Snapshots() })", None);
	assert_eq!(out, json!({ "shown": false, "seen": "0.4.3", "snaps": 0 }));
}

#[test]
fn in_combat_it_waits_for_the_fight_to_end() {
	let out = run_with(
		r#"
		stub.inCombat = true
		stub.advance(6)
		local during = card()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ during = during, after = card() })"#,
		Some(TUNED),
	);
	assert_eq!(out, json!({ "during": false, "after": true }));
}

// Settings > Guide window > Presets lists the saved setup; a card picked over the player's own look saves that look
// first (rule 10 of #3629: set ten window settings, pick Atlas, put the saved setup back: all ten identical).
#[test]
fn presets_list_the_saved_setup_and_picking_a_card_over_the_player_s_own_look_saves_it_first() {
	let out = run_with(
		r#"
		Polestar.DB().layoutCardSeen = "0.4.3"
		-- Atlas installed as the release ships it: in the AddOns list, its TOC naming its layout and preset card
		-- (settings-essentials.rs).
		stub.addons[#stub.addons + 1] = { name = "Polestar_Layout_Atlas", title = "Polestar Layout: Atlas" }
		stub.addonMeta["Polestar_Layout_Atlas"] = { ["X-Polestar-Layout"] = "atlas", ["X-Polestar-Layout-Preset"] = "atlas = Atlas" }
		Polestar.UI.LoadOptions()
		local O = Polestar.UI.Options
		local row
		for _, c in ipairs(O.AllControls()) do
			if c.kind == "cards" and c.presets and c.watch and c.watch["ui.layout"] then row = c end
		end
		local before = tuned()
		row.set("layout:atlas")
		local picked = { Polestar.Theme.LayoutId(), #LC.Snapshots() }
		local saved
		for _, ch in ipairs(row.choices()) do if ch.value:find("^snapshot:") then saved = ch end end
		row.set("compact")
		local again = #LC.Snapshots()
		row.set(saved.value)
		emit({ before = before, picked = picked, label = saved.label, again = again, after = tuned() })"#,
		Some(TUNED),
	);
	assert_eq!(out["picked"], json!(["atlas", 1]), "the player's own look saved before Atlas");
	assert!(out["label"].as_str().unwrap().starts_with("Before Atlas ("), "{}", out["label"]);
	assert_eq!(out["again"], 1, "a card over another card's look saves nothing more");
	assert_eq!(out["after"], out["before"], "the saved setup puts back all ten, and Polestar's own layout");
}
