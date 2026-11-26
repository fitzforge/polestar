//! The 0.4.3 layout choice (addon/Polestar/UI/LayoutCard.lua, #3629, #3876): a section of the What's new card, against
//! the real Core + Theme + UI manifests, the Atlas layout and the fake Engine of tests/lua/stub_ui.lua. One card at
//! the first login after an update from before 0.4.3, never on a fresh install; Standard / Atlas ("(your current)"
//! after the player's own) and the four tab styles switch the real window live; the guide window's setup is saved as
//! "Before Atlas (<date>)" when What's new opens; Keep this commits, the ✕ and Escape put the saved setup back key
//! for key; the saved setup stays in Presets, and a Presets card picked over the player's own look saves that look
//! first.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Ten window settings a player tuned, saved on 0.4.2 (and What's new's 0.4.0 notes seen: 0.4.3's are due).
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
local WN = Polestar.UI.WhatsNew
-- What's new on screen with the layout section in it.
local function card() return PolestarWhatsNew ~= nil and PolestarWhatsNew:IsShown() and LC.IsShown() end"#;

// uistub.install marks the card seen for every other UI test; here the account keeps what it saved.
fn run_with(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES), Addon::files("Polestar_Skins", &["Layouts/Atlas/Atlas.lua"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!("local savedCard = PolestarDB and PolestarDB.layoutCardSeen\nuistub.install()\nPolestar.DB().layoutCardSeen = savedCard\nstub.login()\n{TEN}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn after_an_update_it_shows_once_in_what_s_new_the_buttons_switch_the_real_window_live_and_keep_this_commits() {
	let out = run_with(
		r#"
		local atLogin = card()
		stub.advance(6)
		local opened = LC.State()
		local keepLabel = WN.frame.GotIt.Label:GetText()
		local before = tuned()
		local snap = LC.Snapshots()[1]
		LC.frame.Atlas:Click()
		local atlas = { layout = Polestar.Theme.LayoutId(), tabStyle = Polestar.Get("guideWindow.tabStyle"), lit = LC.State().atlasOn, rest = tuned() }
		LC.frame.Styles[4]:Click()
		local strip = { Polestar.Get("guideWindow.tabStyle"), LC.State().styles }
		LC.frame.Standard:Click()
		local back = { tuned(), LC.State().standardOn }
		LC.frame.Atlas:Click()
		WN.frame.GotIt:Click()
		emit({ atLogin = atLogin, opened = opened, keepLabel = keepLabel, oldCard = PolestarLayoutCard ~= nil, before = before, snapName = snap.name,
			snapLayout = snap.values["ui.layout"] or false, atlas = atlas, strip = strip, back = back,
			kept = { Polestar.Theme.LayoutId(), card(), PolestarDB.layoutCardSeen, #LC.Snapshots() } })"#,
		Some(TUNED),
	);
	assert_eq!(out["atLogin"], false, "a few seconds after login");
	assert_eq!(out["oldCard"], false, "one card: the section is in What's new, no window of its own");
	let opened = &out["opened"];
	assert_eq!(opened["shown"], true);
	assert_eq!(json!([opened["standard"], opened["atlas"]]), json!(["Standard (your current)", "Atlas"]), "Standard and Atlas, the player's own marked");
	assert_eq!(json!([opened["standardOn"], opened["atlasOn"]]), json!([true, false]), "the player's design is the one showing");
	assert_eq!(opened["styles"], json!([["underline", false], ["switcher", false], ["edge", true], ["strip", false]]), "the tab style showing is marked");
	assert_eq!(opened["credit"], "Atlas layout and tab styles by TTik3r");
	assert_eq!(opened["saved"], "Your current setup is saved; you can go back to it any time in Settings > Guide window > Presets.");
	assert_eq!(opened["arrow"], "The arrow follows the route step you're on; to go to a quest you already have, open it in Lookup.", "what the arrow follows (#3701)");
	assert_eq!(out["keepLabel"], "Keep this", "What's new's own button commits what shows");
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
	assert_eq!(out["back"][0], out["before"], "Standard, the player's own: every key as it was, the tab style too");
	assert_eq!(out["back"][1], true);
	assert_eq!(out["kept"], json!(["atlas", false, "0.4.3", 1]), "Keep this: Atlas stays, the choice is seen, the snapshot stays in Presets");
	// The next login, with what this one saved.
	let again = run_with(
		"stub.advance(10)\nemit({ shown = PolestarWhatsNew ~= nil and PolestarWhatsNew:IsShown() })",
		Some("PolestarDB = { schema = 1, welcomeSeen = 1, whatsNewSeen = \"0.4.0\", layoutCardSeen = \"0.4.3\", settings = {} }\nPolestarCharDB = { schema = 1, welcomeSeen = 1 }"),
	);
	assert_eq!(again["shown"], false, "once per account");
}

// #3876: a player already on Atlas sees a difference too: the buttons are Standard and Atlas, "(your current)" after
// Atlas; Standard is Polestar's own layout, Atlas puts their whole setup back. /polestar whatsnew shows the section
// again without saving the same setup twice.
#[test]
fn a_player_already_on_atlas_gets_standard_and_atlas_marked_as_theirs() {
	let out = run_with(
		r#"
		Polestar.Theme.SetLayout("atlas")
		Polestar.Set("guideWindow.tabStyle", "strip")
		stub.advance(6)
		local opened = LC.State()
		LC.frame.Standard:Click()
		local standard = { Polestar.Theme.LayoutId() or false, LC.State().standardOn, Polestar.Get("guideWindow.tabStyle") }
		LC.frame.Atlas:Click()
		local atlas = { Polestar.Theme.LayoutId() or false, LC.State().atlasOn, Polestar.Get("guideWindow.tabStyle") }
		WN.frame.GotIt:Click()
		local snaps = #LC.Snapshots()
		WN.Show()
		local again = { card(), LC.State().atlas, #LC.Snapshots() }
		emit({ opened = { opened.standard, opened.atlas, opened.atlasOn }, standard = standard, atlas = atlas, snaps = snaps, again = again })"#,
		Some(TUNED),
	);
	assert_eq!(out["opened"], json!(["Standard", "Atlas (your current)", true]));
	assert_eq!(out["standard"][0], false, "Standard: Polestar's own layout");
	assert_eq!(out["standard"][1], true);
	assert_eq!(out["atlas"], json!(["atlas", true, "strip"]), "Atlas, theirs: their setup back, the tab style with it");
	assert_eq!(out["again"], json!([true, "Atlas (your current)", out["snaps"].clone()]), "/polestar whatsnew: the section again, no second snapshot of the same setup");
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
				if "{how}" == "close" then WN.frame.Close:Click() else PolestarWhatsNew:Hide() end
				emit({{ before = before, tried = tried, after = tuned(), shown = card(), seen = PolestarDB.layoutCardSeen, layout = Polestar.Theme.LayoutId() or false }})"#
			),
			Some(TUNED),
		);
		assert_eq!(out["tried"], json!(["atlas", "switcher"]), "{how}");
		assert_eq!(out["after"], out["before"], "{how}: all identical");
		assert_eq!(json!([out["shown"], out["seen"], out["layout"]]), json!([false, "0.4.3", false]), "{how}: closed for good, Polestar's own layout");
	}
}

// #4184: after Atlas, Standard or the ✕ gives the live guide window back every part it showed. Atlas kept the step
// count's anchor (Polestar's ‹ button in it) in its own store, which leaving hides whole, so the ‹ stayed hidden
// until a reload. Every frame of the window's parts, two levels down, shows as it did before Atlas.
#[test]
fn leaving_atlas_gives_the_window_back_every_part_it_showed() {
	for how in ["standard", "close"] {
		let out = run_with(
			&format!(
				r#"
				uistub.setGuide(uistub.elwynn, 3)
				stub.advance(6)
				local GF = Polestar.UI.GuideFrame
				local function shown()
					local out, seen = {{}}, {{}}
					local function walk(f, path, depth)
						if seen[f] then return end
						seen[f] = true
						out[path] = f:IsShown() and true or false
						if depth >= 2 then return end
						for k, v in pairs(f) do
							if type(k) == "string" and k ~= "parent" and type(v) == "table" and v.IsShown then walk(v, path .. "." .. k, depth + 1) end
						end
					end
					local keys = {{}}
					for k in pairs(GF.parts) do keys[#keys + 1] = k end
					table.sort(keys)
					for _, k in ipairs(keys) do
						local v = GF.parts[k]
						if type(v) == "table" and v.IsShown then walk(v, k, 0) end
					end
					return out
				end
				local before = shown()
				LC.frame.Atlas:Click()
				stub.advance(0.5)
				local atlas = Polestar.Theme.LayoutId()
				if "{how}" == "standard" then LC.frame.Standard:Click() else WN.frame.Close:Click() end
				stub.advance(0.5)
				GF.Render()
				local after, lost = shown(), {{}}
				for path, was in pairs(before) do
					if was and after[path] == false then lost[#lost + 1] = path end
				end
				table.sort(lost)
				local nav = GF.parts.nav
				emit({{ atlas = atlas, layout = Polestar.Theme.LayoutId() or false, lost = table.concat(lost, ", "), arrows = {{ nav.Prev:IsVisible(), nav.Next:IsVisible() }} }})"#
			),
			Some(TUNED),
		);
		assert_eq!(json!([out["atlas"], out["layout"]]), json!(["atlas", false]), "{how}: Atlas, then Polestar's own layout");
		assert_eq!(out["lost"], "", "{how}: every part shown before Atlas shows again");
		assert_eq!(out["arrows"], json!([true, true]), "{how}: ‹ and › both show");
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
		-- Atlas installed as the release ships it: in the AddOns list, our skins' folder's TOC naming its layout
		-- and preset card (settings-essentials.rs).
		stub.addons[#stub.addons + 1] = { name = "Polestar_Skins", title = "Polestar Skins" }
		stub.addonMeta["Polestar_Skins"] = { ["X-Polestar-Layout"] = "atlas", ["X-Polestar-Layout-Preset"] = "atlas = Atlas" }
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
