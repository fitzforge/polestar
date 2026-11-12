//! Every Look page opens on Essentials (addon/Polestar_Options/UI/Options.lua, UI/Presets.lua and each Look page
//! file): its presets or styles as picture cards, then at most ten of its settings, each a reference to its row on
//! the page's other tabs (the same setting, its tooltip, where it lives, never a second search result), and More
//! links to those rows. A preset writes exactly what it names (the others of its row back to their defaults), is
//! lit while the settings match it, and its card is drawn with its own values by the element's look code.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const ALL: [&str; 11] = [
	"Core/Core.xml",
	"Theme/Theme.xml",
	"Nav/Nav.xml",
	"Quests/Quests.xml",
	"Gear/Gear.xml",
	"Maps/Maps.xml",
	"QoL/QoL.xml",
	"Lookup/Lookup.xml",
	"Dungeons/Dungeons.xml",
	"UI/UI.xml",
	"Rares/Rares.xml",
];

// The whole addon; the settings window's addon loads before the stub's fake Nav stands in (as ui-options.rs's
// run_mods), so its Look pages see the real modules, as in the game.
fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &ALL)],
		script: format!("Polestar.UI.LoadOptions()\nuistub.install()\nstub.login()\nlocal UI, O, W = Polestar.UI, Polestar.UI.Options, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const LOOK: [&str; 8] = ["theme", "guidewindow", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers"];

// Each Look page: Essentials is its first tab, starred, and the page opens on it; its first block is picture cards
// (presets or styles); then sections of references only, at most ten rows (extras not counted), each section with
// a More link to the tab its rows live on; every reference has its home on the same page.
#[test]
fn every_look_page_opens_on_essentials_cards_first_then_at_most_ten_references_to_its_own_rows() {
	let out = run(r#"
		UI.ShowOptions("theme")
		local r = {}
		for _, p in ipairs(O.Pages()) do
			if p.group == "look" then
				O.Select(p.key)
				local v = O.view
				local e = { first = p.tabs[1], opened = v.psTab.name, star = PolestarOptions.tabButtons[1].psStar ~= nil and PolestarOptions.tabButtons[1].psStar:IsShown(),
					rows = 0, notRef = {}, homeless = {}, cardsFirst = false, more = 0, sections = 0 }
				local firstTop
				for c, w in pairs(v.cache) do
					if w:IsShown() and not c.psOwner then
						if c.kind == "cards" and (not firstTop or w.psTop < firstTop) then firstTop = w.psTop end
					end
				end
				for c, w in pairs(v.cache) do
					if w:IsShown() and not c.psOwner then
						if c.kind == "cards" and w.psTop == firstTop then
							e.cardsFirst = true
						else
							e.rows = e.rows + 1
							if not rawget(c, "ref") then e.notRef[#e.notRef + 1] = tostring(c.key or c.label) end
						end
						if rawget(c, "ref") then
							local home = O.HomeOf(c)
							if not home or home.page ~= c.page then e.homeless[#e.homeless + 1] = tostring(c.key) end
						end
					end
				end
				for _, card in ipairs(v.cards) do
					if card:IsShown() then
						e.sections = e.sections + 1
						if card.More:IsShown() then e.more = e.more + 1 end
					end
				end
				r[p.key] = e
			end
		end
		emit(r)"#);
	for key in LOOK {
		let e = &out[key];
		assert_eq!(e["first"], "Essentials", "{key}: Essentials is the first tab");
		assert_eq!(e["opened"], "Essentials", "{key}: the page opens on it");
		assert_eq!(e["star"], true, "{key}: its tab carries the star");
		assert_eq!(e["cardsFirst"], true, "{key}: picture cards first");
		let rows = e["rows"].as_f64().unwrap();
		assert!((4.0..=10.0).contains(&rows), "{key}: {rows} rows under the cards (at most ten)");
		assert_eq!(e["notRef"], json!({}), "{key}: every row a reference to its home");
		assert_eq!(e["homeless"], json!({}), "{key}: every reference's home on its page");
		assert_eq!(e["more"].as_f64().unwrap(), e["sections"].as_f64().unwrap() - 1.0, "{key}: a More link on every section but the cards'");
	}
}

// A reference row is its home's setting: it follows its section's switch (a reference too), writes the same key,
// follows a change made on the home row, shows the home's tooltip with where the setting lives, carries no cog and
// no New; search lists the home row alone; More opens the home's tab with that section lit.
#[test]
fn a_reference_writes_its_home_setting_shows_where_it_lives_and_search_finds_only_the_home() {
	let out = run(r#"
		UI.ShowOptions("mappins")
		O.Select("mappins", "Essentials")
		local ess = O.Controls("mappins", "Essentials")
		local ref = ess["nav.stepPinSize"]
		local r = {}
		r.offFirst = W.Enabled(ref)
		ess["nav.upcomingPins"]:Click()
		r.on = { Polestar.Get("nav.upcomingPins"), W.Enabled(ref) }
		stub.RunScript(ref.Slider, "OnValueChanged", 2, true)
		r.written = Polestar.Get("nav.stepPinSize")
		Polestar.Set("nav.stepPinSize", 1.5)
		r.follows = ref.Slider:GetValue()
		r.cog = rawget(ref, "Cog") ~= nil
		local lines = O.TipOf(ref.psControl)(ref)
		r.tipHelp = type(lines[1]) == "string" and lines[1]:find("numbered pins", 1, true) ~= nil
		r.tipWhere = type(lines[#lines]) == "table" and lines[#lines][1] or false
		local found = {}
		for _, g in ipairs((O.Search("pin size"))) do
			for _, c in ipairs(g.controls) do if c.key == "nav.stepPinSize" then found[#found + 1] = g.title end end
		end
		r.found = found
		-- The section's More link: the Pins tab, the Numbered pins section lit.
		local lit
		local flash = O.Flash
		O.Flash = function(w, ...) lit = w.psName; return flash(w, ...) end
		for _, card in ipairs(O.view.cards) do
			if card:IsShown() and card.psName == "Numbered pins" then card.More:Click() end
		end
		r.more = { O.view.psTab.name, lit }
		emit(r)"#);
	assert_eq!(out["offFirst"], false, "off while its section's switch (Numbered pins) is off");
	assert_eq!(out["on"], json!([true, true]), "the section's switch turns them on");
	assert_eq!(out["written"], 2, "the reference writes its home's setting");
	assert_eq!(out["follows"], 1.5, "and shows a change made elsewhere");
	assert_eq!(out["cog"], false, "no cog on Essentials");
	assert_eq!(out["tipHelp"], true, "the home's help is the tooltip");
	assert_eq!(out["tipWhere"], "Map pins  \u{b7}  Pins  \u{b7}  Numbered pins", "the tooltip says where it lives");
	assert_eq!(out["found"], json!(["Map pins  \u{b7}  Pins  \u{b7}  Numbered pins"]), "search lists the home row alone");
	assert_eq!(out["more"], json!(["Pins", "Numbered pins"]), "More opens the tab with the section lit");
}

// Presets: a card writes the settings it names and puts the others of its row back to their defaults (nothing
// else); it is lit while the settings match, no card after a change by hand, and a right-click goes back to the
// defaults (the first card). Each card is drawn by the element's own look code with its preset's values: the
// Large card's pin is bigger than the defaults', and stays so while the live setting changes.
#[test]
fn a_preset_writes_exactly_its_settings_is_lit_while_they_match_and_its_card_shows_its_own_values() {
	let out = run(r#"
		UI.ShowOptions("mappins")
		O.Select("mappins", "Essentials")
		local row
		for c, w in pairs(O.view.cache) do if c.presets then row = w end end
		local r = { lit = {} }
		local function lit() for v, card in pairs(row.psCardBy) do if card.Check:IsShown() then return v end end return false end
		r.lit[1] = lit()
		Polestar.Set("nav.mapIcons", "halo") -- a key no preset names stays
		row.psCardBy.subtle:Click()
		r.subtle = { Polestar.Get("nav.stepPinSize"), Polestar.Get("nav.targetGlow"), Polestar.Get("nav.areaAlpha"), Polestar.Get("nav.mapIcons") }
		r.lit[2] = lit()
		row.psCardBy.large:Click()
		r.large = { Polestar.Get("nav.stepPinSize"), Polestar.Get("nav.targetGlow"), Polestar.Get("nav.areaAlpha"), Polestar.Get("nav.targetPinSize") }
		r.lit[3] = lit()
		Polestar.Set("nav.stepPinSize", 1.45)
		r.lit[4] = lit()
		row:Click("RightButton")
		r.reset = { Polestar.Get("nav.stepPinSize"), Polestar.Get("nav.targetPinSize"), Polestar.Get("nav.mapIcons") }
		r.lit[5] = lit()
		-- The cards' art: the first numbered pin of each card, drawn with its preset's size.
		local function pinW(v) local a = row.psCardBy[v].Art; return a.psSteps and math.floor(a.psSteps[1].width * 100 + 0.5) / 100 or false end
		r.art = { pinW("polestar"), pinW("large"), pinW("subtle") }
		Polestar.Set("nav.stepPinSize", 3)
		r.artAfter = { pinW("polestar"), pinW("large") }
		emit(r)"#);
	assert_eq!(out["lit"], json!(["polestar", "subtle", "large", false, "polestar"]));
	assert_eq!(out["subtle"], json!([0.8, false, 0.2, "halo"]), "Subtle's settings, the icon pack untouched");
	assert_eq!(out["large"], json!([1.5, true, 0.32, 1.3]), "Large's, and Subtle's others back to their defaults");
	assert_eq!(out["reset"], json!([1, 1, "halo"]), "right-click: the defaults, the icon pack untouched");
	let art = out["art"].as_array().unwrap();
	assert!(art[1].as_f64().unwrap() > art[0].as_f64().unwrap(), "Large draws a bigger pin: {art:?}");
	assert!(art[2].as_f64().unwrap() < art[0].as_f64().unwrap(), "Subtle a smaller one: {art:?}");
	assert_eq!(out["artAfter"], json!([art[0], art[1]]), "the cards keep their own values while the live setting changes");
}

// Every preset of every page writes only settings that exist (a registered default) with a value its row could
// write (a slider's range, a dropdown's choices), and each is lit right after it is picked.
#[test]
fn every_preset_names_real_settings_with_values_their_rows_allow_and_lights_once_picked() {
	let out = run(r#"
		UI.ShowOptions("theme")
		local bad, n = {}, 0
		for _, p in ipairs(O.Pages()) do
			if p.group == "look" then
				O.Select(p.key, "Essentials")
				for c in pairs(O.view.cache) do
					for _, preset in ipairs(c.presets or {}) do
						n = n + 1
						for k, v in pairs(preset.set) do
							local home
							for _, h in ipairs(O.AllControls()) do if h.key == k then home = h end end
							if Polestar.GetDefault(k) == nil then bad[#bad + 1] = p.key .. "/" .. preset.value .. ": " .. k .. " has no default"
							elseif not home then bad[#bad + 1] = p.key .. "/" .. preset.value .. ": " .. k .. " has no row"
							elseif home.kind == "slider" and (v < home.min - 1e-9 or v > home.max + 1e-9) then
								bad[#bad + 1] = p.key .. "/" .. preset.value .. ": " .. k .. " = " .. tostring(v) .. " is past its slider"
							elseif home.kind == "dropdown" then
								local list = type(home.choices) == "function" and home.choices() or home.choices
								local ok = false
								for _, ch in ipairs(list or {}) do if ch.value == v then ok = true end end
								if not ok then bad[#bad + 1] = p.key .. "/" .. preset.value .. ": " .. k .. " = " .. tostring(v) .. " is no choice" end
							end
						end
						c.set(preset.value)
						if c.get() ~= preset.value then bad[#bad + 1] = p.key .. "/" .. preset.value .. ": not lit once picked" end
						c.set(nil)
					end
				end
			end
		end
		emit({ bad = table.concat(bad, "\n"), n = n })"#);
	assert!(out["n"].as_f64().unwrap() >= 19.0, "the five pages' presets: {}", out["n"]);
	assert_eq!(out["bad"], "", "presets:\n{}", out["bad"].as_str().unwrap_or_default());
}

// A page opens again on the tab last opened there (account-wide, not a setting); a first visit on Essentials.
#[test]
fn a_page_opens_again_on_the_tab_last_opened_there() {
	let out = run(r#"
		UI.ShowOptions("arrow")
		local first = O.view.psTab.name
		O.Select("arrow", "Text")
		O.Select("mappins")
		O.Select("arrow")
		emit({ first = first, again = O.view.psTab.name, saved = PolestarDB.optionsTab and PolestarDB.optionsTab.arrow or false,
			setting = Polestar.GetDefault("ui.optionsTab") == nil })"#);
	assert_eq!(out, json!({ "first": "Essentials", "again": "Text", "saved": "Text", "setting": true }));
}
