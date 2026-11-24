//! Every Look page opens on Essentials (addon/Polestar_Options/UI/Options.lua, UI/Presets.lua and each Look page
//! file): its presets or styles as picture cards, then at most ten of its settings, each a reference to its row on
//! the page's other tabs (the same setting, its tooltip, where it lives, never a second search result), and More
//! links to those rows. A preset writes exactly what it names (the others of its row back to their defaults), is
//! lit while the settings match it, and its card is drawn with its own values by the element's look code.

use forge_addontest::{emitted, lua_string, Addon, RunAddon};
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
						-- A reference has a home. Since the Settings Overhaul's one home per setting (#3185) that home
						-- may be on another page: what the arrow and the route lines do lives on Guide (hide the arrow
						-- with the guide, distance units, line style), the rare and dungeon alerts on Discovery, and a
						-- Look page's Essentials reference them there.
						if rawget(c, "ref") then
							local home = O.HomeOf(c)
							if not home or not home.page then e.homeless[#e.homeless + 1] = tostring(c.key) end
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
		// Alerts & toasts' "All alerts" (Line up alerts, toasts.stack) is homed on its Essentials since #3185: the line
		// lines up the rare alert, the transport banner and While you're here alike, so no one alert's tab holds it.
		let own = if key == "alerts" { json!(["toasts.stack"]) } else { json!({}) };
		assert_eq!(e["notRef"], own, "{key}: every row a reference to its home");
		assert_eq!(e["homeless"], json!({}), "{key}: every reference has a home");
		// Theme's cards show the first six skins, and their More link opens the full list on the Colour tab. Alerts &
		// toasts' All alerts is the line's home, not references, so it has no More link either.
		let no_more = match key {
			"theme" => 0.0,
			"alerts" => 2.0,
			_ => 1.0,
		};
		assert_eq!(e["more"].as_f64().unwrap(), e["sections"].as_f64().unwrap() - no_more, "{key}: a More link on every section but the cards' (Theme's too) and a home's");
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
		-- The cards' art: the first numbered pin of each card, drawn with its preset's size (its size on screen).
		local function pinW(v)
			local d = row.psCardBy[v].Art.psSharp
			local s = d and d.steps[1]
			return s and s:IsShown() and math.floor(s:GetWidth() * s:GetScale() * 100 + 0.5) / 100 or false
		end
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

// The Atlas layout and skin installed as the release ships them: in our skins' folder (Polestar_Skins, since 0.4.3),
// load on demand, named in its TOC, loaded from its files the first time Polestar asks (stub_packs.lua).
fn run_with_atlas(script: &str) -> Value {
	let files = forge_addontest::run::toc_files("Polestar_Skins").unwrap().iter().map(|f| lua_string(&f.display().to_string())).collect::<Vec<_>>().join(", ");
	let toc = std::fs::read_to_string(forge_addontest::run::addons_dir().join("Polestar_Skins/Polestar_Skins.toc")).unwrap();
	let meta: Vec<String> = toc
		.lines()
		.filter_map(|l| l.strip_prefix("## ")?.split_once(':'))
		.filter(|(k, _)| k.starts_with("X-Polestar-"))
		.map(|(k, v)| format!("[{}] = {}", lua_string(k.trim()), lua_string(v.trim())))
		.collect();
	let before = format!(
		r#"
stub.addons = {{
	{{ name = "Polestar" }},
	{{ name = "Polestar_Skins", title = "Polestar Skins", notes = "Polestar's skins and the Atlas layout.", demand = true }},
}}
stub.addonMeta["Polestar_Skins"] = {{ {} }}
stub.packs.Polestar_Skins = {{ {files} }}"#,
		meta.join(", ")
	);
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_packs.lua"],
		before,
		addons: vec![Addon::files("Polestar", &ALL)],
		script: format!("Polestar.UI.LoadOptions()\nuistub.install()\nstub.login()\nlocal UI, O, W = Polestar.UI, Polestar.UI.Options, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// The guide window's Presets row, its cards in order with the one lit.
const PRESET_ROW: &str = r#"
	UI.ShowOptions("guidewindow")
	O.Select("guidewindow", "Essentials")
	local row
	for c, w in pairs(O.view.cache) do if c.presets then row = w end end
	local function choices() return type(row.psChoices) == "function" and row.psChoices() or row.psChoices end
	local function values()
		local t = {}
		for i, ch in ipairs(choices()) do t[i] = ch.value end
		return table.concat(t, ",")
	end
	local function lit() for v, card in pairs(row.psCardBy) do if card:IsShown() and card.Check:IsShown() then return v end end return false end
"#;

// No layout installed: the row is Polestar's own four cards.
#[test]
fn the_presets_row_has_no_layout_card_without_a_layout_installed() {
	let out = run(&format!("{PRESET_ROW}\nemit({{ values = values(), lit = lit() }})"));
	assert_eq!(out["values"], "standard,compact,transparent,large");
	assert_eq!(out["lit"], "standard");
}

// Atlas installed, not loaded: its card follows the four, labelled from its TOC, a name on the card and "Not loaded",
// and drawing it loads nothing. Picking it loads the layout and puts it in use, the player's skin kept, and lights it alone;
// its card is then the window drawn through Atlas's hooks, on that copy's own parts. The built-in cards draw with
// Polestar's own layout meanwhile: no layout hook runs for them. Standard (and Compact) go back to Polestar's own
// layout, lit. A skin the player chose stays through Atlas and back.
#[test]
fn the_atlas_card_picks_the_layout_only_and_standard_goes_back() {
	let out = run_with_atlas(&format!(
		r##"{PRESET_ROW}
	local T = Polestar.Theme
	local r = {{ values = values(), lit = {{ lit() }} }}
	local atlas = row.psCardBy["layout:atlas"]
	r.before = {{ atlas.Name:GetText(), atlas.Note:GetText(), atlas.Art.psLabel and atlas.Art.psLabel:GetText() or false,
		stub.packLoads.Polestar_Skins or 0, T.LayoutInfo("atlas") ~= nil }}
	atlas:Click()
	r.picked = {{ T.LayoutId() or false, Polestar.Get("ui.skin"), T.SkinId(), stub.packLoads.Polestar_Skins or 0 }}
	r.lit[2] = lit()
	-- Every Atlas hook counted, with the window it was handed.
	local hooks = Polestar.ThemeInternal.LAYOUTS.atlas.hooks
	local calls, windows = 0, {{}}
	for name, fn in pairs(hooks) do
		hooks[name] = function(...)
			calls = calls + 1
			for i = 1, select("#", ...) do
				local a = select(i, ...)
				if type(a) == "table" and rawget(a, "window") then windows[a.window] = true end
			end
			return fn(...)
		end
	end
	local byValue = {{}}
	for _, ch in ipairs(choices()) do byValue[ch.value] = ch end
	r.builtin = {{}}
	for _, v in ipairs({{ "standard", "compact", "transparent", "large" }}) do
		calls = 0
		byValue[v].draw(row.psCardBy[v].Art)
		r.builtin[#r.builtin + 1] = calls
	end
	calls = 0
	byValue["layout:atlas"].draw(atlas.Art)
	local copy = atlas.Art.psCopy
	r.atlasCard = {{ calls > 0, copy ~= nil and windows[copy.frame] == true, windows[Polestar.UI.GuideFrame.frame] == true,
		atlas.Art.psLabel and atlas.Art.psLabel:IsShown() or false }}
	row.psCardBy.standard:Click()
	r.standard = {{ T.LayoutId() or false, Polestar.Get("ui.skin"), Polestar.Get("ui.layout") or false }}
	r.lit[3] = lit()
	atlas:Click()
	row.psCardBy.compact:Click()
	r.compact = {{ T.LayoutId() or false, Polestar.Get("ui.compact"), Polestar.Get("ui.skin") }}
	r.lit[4] = lit()
	atlas:Click()
	row:Click("RightButton")
	r.reset = {{ T.LayoutId() or false, Polestar.Get("ui.compact") }}
	r.lit[5] = lit()
	Polestar.Set("ui.skin", "forever")
	atlas:Click()
	local inAtlas = Polestar.Get("ui.skin")
	row.psCardBy.standard:Click()
	r.ownSkin = {{ inAtlas, Polestar.Get("ui.skin") }}
	r.failed = T.LayoutInfo("atlas").failed or false
	emit(r)"##
	));
	assert_eq!(out["values"], "standard,compact,transparent,large,layout:atlas", "the Atlas card after Polestar's own");
	assert_eq!(out["before"], json!(["Atlas", "Not loaded", "Atlas", 0, false]), "labelled from its TOC, drawing it loads nothing");
	assert_eq!(out["picked"], json!(["atlas", "polestar", "polestar", 1]), "picked: the layout loads and is in use, the skin left as it was");
	assert_eq!(out["builtin"], json!([0, 0, 0, 0]), "the built-in cards call no layout hook while Atlas is in use");
	assert_eq!(out["atlasCard"], json!([true, true, false, false]), "the Atlas card draws through its hooks, on the copy's own parts");
	assert_eq!(out["standard"], json!([false, "polestar", false]), "Standard: Polestar's own layout, the skin as it was");
	assert_eq!(out["compact"], json!([false, true, "polestar"]), "Compact too");
	assert_eq!(out["reset"], json!([false, false]), "right-click: Standard");
	assert_eq!(out["lit"], json!(["standard", "layout:atlas", "standard", "compact", "standard"]), "the check follows the layout in use");
	assert_eq!(out["ownSkin"], json!(["forever", "forever"]), "the player's skin stays through Atlas and Standard");
	assert_eq!(out["failed"], false, "no Atlas hook failed");
}

// Atlas, then Standard: the settings' preview copy (drawing with the layout in use) drops every change Atlas made to it,
// as the live window does. Its title, zone and goal rows sit, show, size and take their fonts as a fresh copy's drawn
// under Standard, a repaint after included.
#[test]
fn leaving_atlas_gives_the_preview_copy_polestar_s_own_layout_back() {
	let out = run_with_atlas(&format!(
		r##"{PRESET_ROW}
	local GF = Polestar.UI.GuideFrame
	local preview
	for copy in pairs(GF.copies or {{}}) do preview = copy end
	-- A window's title, zone and goal rows: anchors (to frames of that window, by name), shown, size.
	local function snap(G)
		local P = G.SkinParts()
		local names = {{ [P.window] = "window" }}
		for k, v in pairs(P) do if type(v) == "table" and k ~= "rows" then names[v] = k end end
		for k, v in pairs(P.person) do if type(v) == "table" then names[v] = "person." .. tostring(k) end end
		local function one(f)
			local t = {{ shown = f:IsShown() and true or false, w = math.floor(f:GetWidth() + 0.5) }}
			if f.GetFont then
				local path, size, flags = f:GetFont()
				t.font = table.concat({{ tostring(path), tostring(size), tostring(flags) }}, " ")
			end
			for i = 1, f:GetNumPoints() do
				local pt, rel, rp, x, y = f:GetPoint(i)
				t[#t + 1] = table.concat({{ pt, names[rel] or (rel and "other" or "parent"), tostring(rp), tostring(x), tostring(y) }}, " ")
			end
			return t
		end
		local s = {{ title = one(P.person.Name), zone = one(P.person.Where), person = one(P.person), rows = {{}} }}
		for i, r in ipairs(P.rows) do
			if r:IsShown() then s.rows[#s.rows + 1] = {{ row = one(r), text = r.Text and one(r.Text) or false }} end
		end
		return s
	end
	local r = {{ found = preview ~= nil }}
	row.psCardBy["layout:atlas"]:Click()
	stub.advance(0.5)
	preview.Draw()
	r.atlas = snap(preview)
	row.psCardBy.standard:Click()
	stub.advance(0.5)
	-- A repaint (a theme change) after: what the window got back stays.
	Polestar.Theme.Refresh()
	preview.Draw()
	r.after = snap(preview)
	local fresh = GF.Copy(preview.parent, preview.content)
	fresh.Draw()
	r.fresh = snap(fresh)
	r.layout = Polestar.Theme.LayoutId() or false
	emit(r)"##
	));
	assert_eq!(out["found"], true, "the preview is a copy drawing with the layout in use");
	assert_eq!(out["layout"], false, "Standard: Polestar's own layout");
	assert_ne!(out["atlas"], out["fresh"], "under Atlas the preview is laid out as Atlas's");
	assert_eq!(out["after"], out["fresh"], "after Atlas, the preview is a fresh copy's layout");
}

// A layout's preset: label and help as text, set as a skin preset's settings plus the skin it is drawn for; never
// ui.layout (the card picks the layout), never behaviour.
#[test]
fn a_layout_preset_is_checked_as_it_registers() {
	let out = run(r#"
		local T = Polestar.Theme
		local function try(id, preset)
			local ok, msg = T.RegisterLayout(id, { api = 2, name = "Test " .. id, addon = "Polestar_Layout_Test", preset = preset })
			return msg or (ok and "ok") or "?"
		end
		local r = {
			try("p1", "x"),
			try("p2", { label = "" }),
			try("p3", { set = { ["ui.layout"] = "p3" } }),
			try("p4", { set = { ["ui.skin"] = 3 } }),
			try("p5", { set = { ["behavior.autoAccept"] = true } }),
			try("p6", { colour = 1 }),
			try("good", { help = "A test.", set = { ["ui.skin"] = "hearth", ["ui.width"] = 320 } }),
		}
		local info = T.LayoutInfo("good").preset
		emit({ r = r, info = { info.label, info.help, info.set["ui.skin"], info.set["ui.width"] }, cap = T.HasCapability("layouts.preset") })"#);
	assert_eq!(
		out["r"],
		json!([
			"preset must be a table { label, help, set }",
			"preset.label must be a string of 1-40 characters",
			"preset.set[\"ui.layout\"]: picking the card chooses the layout",
			"preset.set[\"ui.skin\"] must be a skin id",
			"preset.behavior.autoAccept is not a look setting (a preset changes how Polestar looks, never what it does)",
			"unknown field preset.colour",
			"ok"
		])
	);
	assert_eq!(out["info"], json!(["Test good", "A test.", "hearth", 320]), "the label is the layout's name when unset");
	assert_eq!(out["cap"], true);
}
