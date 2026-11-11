//! The options window (addon/Polestar/UI/Options.lua): built-in pages, the options registry other modules use,
//! the two-column grid, search, the footer, and the Blizzard Settings entry.

use forge_addontest::{emitted, fake_locale, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const MODS: [&str; 10] =
	["Core/Core.xml", "Theme/Theme.xml", "Quests/Quests.xml", "Gear/Gear.xml", "Maps/Maps.xml", "QoL/QoL.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml", "Rares/Rares.xml"];

// MODS and Nav: every module with settings on Quality of Life.
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

fn run_opts(script: &str, install: &str, before: &str, between: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("{between}\nuistub.install({install})\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_opts(script, "", "", "")
}

fn includes(v: &Value, s: &str) -> bool {
	v.as_array().unwrap().iter().any(|x| x.as_str() == Some(s))
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

const HELPERS: &str = r#"
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
end
local function navLabels()
	local out = {}
	for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
	return out
end
local function footer()
	local out = {}
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
	end
	return out
end
local function footerButton(text)
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() and b.Label:GetText() == text then return b end end
	end
end
-- A setting's widget wherever its page and tab are (the Look pages are their modules'): its page opened there; a
-- section's toggle is its header's switch, an extra its inline control; a cog's setting opens the cog's popup.
local function ctl(key)
	for _, c in ipairs(O.AllControls()) do
		if c.key == key then
			local row = c
			while row.psOwner do row = row.psOwner end
			O.Select(c.page.key, c.tab or "")
			local v = O.view
			local w = v.cache[c] or v.extras[c]
			if w then return w, c end
			local owner = v.cache[row]
			if owner and rawget(owner, "Cog") then
				O.ShowMore(owner.Cog, row)
				return O.MoreControls()[key], c
			end
			return nil, c
		end
	end
end
-- The shown section cards' titles, and one card by its title.
local function cardTitles()
	local out = {}
	for _, card in ipairs(O.view.cards) do
		if card:IsShown() and card.psHeader then out[#out + 1] = card.Title:GetText() end
	end
	return out
end
local function cardOf(name)
	for _, card in ipairs(O.view.cards) do if card:IsShown() and card.Title:GetText() == name then return card end end
end
-- The sidebar's tree: { { group, { page, ... } }, ... }
local function navTree()
	local out, g = {}, nil
	for _, b in ipairs(PolestarOptions.navButtons) do
		if b:IsShown() then
			if b.psGroup then
				g = { b.Label:GetText(), {} }
				out[#out + 1] = g
			elseif g then
				table.insert(g[2], b.Label:GetText())
			end
		end
	end
	return out
end
"#;

// The tree's groups in order and the pages of each.
fn tree(v: &Value) -> Vec<(String, Vec<String>)> {
	v.as_array()
		.unwrap()
		.iter()
		.map(|g| {
			let pages = match &g[1] {
				Value::Array(a) => a.iter().map(|p| p.as_str().unwrap().to_string()).collect(),
				_ => vec![],
			};
			(g[0].as_str().unwrap().to_string(), pages)
		})
		.collect()
}

// A search result card's page and tab: its title less the section.
fn tab_of(title: &str) -> String {
	title.split("  \u{b7}  ").take(2).collect::<Vec<_>>().join("  \u{b7}  ")
}

// Is `want` in `list` in this order (other entries between allowed)?
fn in_order(list: &[String], want: &[&str]) -> bool {
	let mut it = list.iter();
	want.iter().all(|w| it.any(|x| x == w))
}

// A module page, registered the way Quests/Gear/Maps/QoL do.
const FAKE_PAGE: &str = r#"
Polestar.RegisterDefaults("fake", { markers = true, size = 1, colour = { 1, 0.5, 0 }, mode = "auto" })
local clicks = 0
uifake = { clicks = function() return clicks end }
Polestar.RegisterOptions({ page = "Quests", icon = "icon-accept", order = 30, tab = "Map", section = "Markers", controls = {
	{ kind = "toggle", key = "fake.markers", label = "Objective markers", help = "Pins for quest objectives." },
	{ kind = "slider", key = "fake.size", label = "Marker size", min = 0.5, max = 2, step = 0.05, format = "%.2fx",
		disabled = function() return not Polestar.Get("fake.markers") end },
	{ kind = "dropdown", key = "fake.mode", label = "Weights", choices = { { value = "auto", label = "Automatic" }, { value = "manual", label = "Manual" } } },
	{ kind = "color", key = "fake.colour", label = "Marker colour" },
	{ kind = "button", label = "Reset lockouts", help = "Forget saved lockouts.", onClick = function() clicks = clicks + 1 end },
} })
"#;

#[test]
fn pages_by_order_in_the_tree_s_groups_a_page_with_nothing_to_set_left_out_recorder_and_about_last_tabs_and_sections() {
	let out = run_opts(
		r#"
		Polestar.RegisterOptions({ page = "Gear", icon = "star", order = 40, section = "Weights", controls = {} })
		UI.ShowOptions()
		emit({ tree = navTree(), pages = O.Pages(), title = PolestarOptions.Title:GetText(),
			tabs = (function() local t = {} for _, b in ipairs(PolestarOptions.tabButtons) do if b:IsShown() then t[#t + 1] = b.Label:GetText() end end return t end)(),
			footer = footer() })"#,
		"",
		"",
		FAKE_PAGE,
	);
	// Questing and Discovery fill from modules not loaded here; Gear registered no control: all left out of the
	// list. Quality of Life shows Guide's trainer reminders, declared with the built-in pages. Community guides (a
	// custom page) and Integrations (which says when it has nothing) are always there. The Look group holds the
	// pages the look modules register (20-29), Setup 63-79, About from 80.
	let tree = tree(&out["tree"]);
	let groups: Vec<&str> = tree.iter().map(|(g, _)| g.as_str()).collect();
	assert_eq!(groups, ["Guiding", "Look", "Setup", "About"]);
	assert_eq!(tree[0].1, ["Guide", "Map", "Quests", "Quality of Life"]);
	assert!(!tree[1].1.is_empty() && !tree[1].1.iter().any(|p| ["Guide", "Map", "Integrations", "About"].contains(&p.as_str())), "Look: {:?}", tree[1].1);
	assert!(in_order(&tree[2].1, &["Integrations", "Community guides", "Gamepad"]), "Setup: {:?}", tree[2].1);
	assert_eq!(tree[3].1, ["Guiding Stars", "Recorder", "About"]);
	assert_eq!(out["title"], "Guide");
	assert_eq!(out["tabs"], json!(["Window", "Arrow & routes", "Automation"]));
	let quests = out["pages"].as_array().unwrap().iter().find(|p| p["name"] == "Quests").cloned();
	assert_eq!(quests, Some(json!({ "name": "Quests", "key": "quests", "builtin": false, "tabs": ["Map"], "group": "guiding" })));
	let footer: Vec<String> = out["footer"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	assert!(in_order(&footer, &["Reset page", "Reload UI", "Close"]), "footer: {footer:?}");
}

// Options > Integrations: a section per supported addon, there only while that addon is installed or loaded;
// with none, one line says so.
const SHOW: &str = r#"
		UI.ShowOptions("integrations")
		local headers = cardTitles()
		local toggle = O.Controls("integrations")["routePlan.questie"]
		emit({ title = PolestarOptions.Title:GetText(), headers = headers, empty = O.view.empty,
			line = rawget(O.view, "Empty") and O.view.Empty:IsShown() and O.view.Empty:GetText() or nil,
			toggle = toggle ~= nil and toggle:IsShown() or false, on = Polestar.Get("routePlan.questie"),
			nav = navLabels() })"#;

#[test]
fn integrations_lists_spoken_with_its_wait_off_only_while_spoken_quests_is_there() {
	let script = r#"
		UI.ShowOptions("integrations")
		local headers = cardTitles()
		local c = O.Controls("integrations")
		local function shown(key) return c[key] ~= nil and c[key]:IsShown() or false end
		emit({ headers = headers, toggle = shown("behavior.spokenDelay"), on = Polestar.Get("behavior.spokenDelay") })"#;
	let without = run(script);
	assert_eq!(without["toggle"], false);
	let with = run(&format!("stub.addonsLoaded.Spoken_Quests = true\n{script}"));
	assert_eq!(with, json!({ "headers": ["Spoken"], "toggle": true, "on": true }));
}

#[test]
fn integrations_lists_questie_only_when_it_is_installed_or_loaded_else_says_none_is() {
	let none = run(SHOW);
	assert_eq!(none["title"], "Integrations");
	assert!(includes(&none["nav"], "Integrations"));
	let values: Vec<Value> = match &none["headers"] {
		Value::Array(a) => a.clone(),
		Value::Object(o) => o.values().cloned().collect(),
		other => panic!("headers: {other}"),
	};
	assert_eq!(values, Vec::<Value>::new());
	assert_eq!(none["empty"], true);
	assert_eq!(none["line"], "None of the addons Polestar works with is installed.");
	assert_eq!(none["toggle"], false);

	let loaded = run(&format!("stub.addonsLoaded.Questie = true\n{SHOW}"));
	assert_eq!(loaded["headers"], json!(["Questie"]));
	assert_eq!(loaded["empty"], false);
	assert!(loaded["line"].is_null());
	assert_eq!(loaded["toggle"], true);
	assert_eq!(loaded["on"], false, "planned turn-ins stay off until the player turns them on");

	// Installed and enabled but loading after Polestar counts too.
	let installed = run(&(r#"
		table.insert(stub.addons, { name = "Questie" })
		function C_AddOns.DoesAddOnExist(name) return name == "Questie" end
		"#
	.to_string()
		+ SHOW));
	assert_eq!(installed["headers"], json!(["Questie"]));
	assert_eq!(installed["toggle"], true);
}

// Players and macros still type the old page names (/polestar options navigation); each lands on the page and
// tab that holds those settings now. A page's own key wins: "guidewindow" is the Look page of that name now,
// "appearance" (and "look") the Theme page.
#[test]
fn old_page_keys_open_the_page_and_tab_that_hold_their_settings_now() {
	let out = run(r#"
		local function at(key)
			UI.ShowOptions(key)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			return O.page.key .. ": " .. PolestarOptions.Title:GetText() .. " > " .. tab
		end
		local out = {}
		for _, k in ipairs({ "guidewindow", "navigation", "automation", "appearance", "look", "map", "recorder", "nav", "behaviour", "General" }) do out[k] = at(k) end
		emit(out)"#);
	assert!(is_match(text(&out["appearance"]), r"^theme: Theme > "), "appearance: {}", out["appearance"]);
	assert_eq!(out["look"], out["appearance"]);
	assert!(is_match(text(&out["guidewindow"]), r"^guidewindow: Guide window > "), "guidewindow: {}", out["guidewindow"]);
	let mut rest = out.clone();
	for k in ["appearance", "look", "guidewindow"] {
		rest.as_object_mut().unwrap().remove(k);
	}
	assert_eq!(
		rest,
		json!({
			"navigation": "guide: Guide > Arrow & routes",
			"automation": "guide: Guide > Automation",
			"map": "map: Map > Guide & quests",
			"recorder": "recorder: Recorder > ",
			"nav": "guide: Guide > Arrow & routes",
			"behaviour": "guide: Guide > Automation",
			"General": "guide: Guide > Window",
		})
	);
	let mods = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &MODS)],
		script: "uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O = Polestar.UI, Polestar.UI.Options".to_string()
			+ r#"
		local out = {}
		for _, k in ipairs({ "quests", "gear", "lookup", "dungeons", "rares", "qualityoflife" }) do
			UI.ShowOptions(k)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			out[k] = PolestarOptions.Title:GetText() .. " > " .. tab
		end
		emit(out)"#,
		..Default::default()
	})
	.remove(0);
	assert_eq!(
		mods,
		json!({
			"quests": "Questing > Quests",
			"gear": "Questing > Rewards & gear",
			"lookup": "Discovery > Lookup",
			"dungeons": "Discovery > Dungeons",
			"rares": "Discovery > Rares",
			"qualityoflife": "Quality of Life > Quests",
		})
	);
}

// A translated client: the page titles change, the keys players type do not.
#[test]
fn page_keys_stay_english_on_a_translated_client_polestar_options_quests_gear_lookup_and_polestar_packs() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: fake_locale(
			"itIT",
			&[
				("Guide", "Leitfaden"),
				("Theme", "Thema"),
				("Questing", "Questen"),
				("Discovery", "Entdecken"),
				("Quality of Life", "Komfort"),
				("Community guides", "Community-Guides"),
				("About", "Über"),
				("Quests", "Aufträge"),
				("Rewards & gear", "Belohnungen & Ausrüstung"),
				("Lookup", "Nachschlagen"),
			],
		),
		addons: vec![Addon::files("Polestar", &MODS)],
		script: "uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal O = Polestar.UI.Options".to_string()
			+ r#"
		local function at(cmd)
			SlashCmdList.POLESTAR(cmd)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			return O.page.key .. ": " .. PolestarOptions.Title:GetText() .. " > " .. tab
		end
		local out = {}
		for _, cmd in ipairs({ "options quests", "options gear", "options lookup", "options appearance", "options qualityoflife", "options about", "packs" }) do out[cmd] = at(cmd) end
		local keys = {}
		for _, p in ipairs(O.Pages()) do keys[#keys + 1] = p.key end
		out.keys = keys
		emit(out)"#,
		..Default::default()
	})
	.remove(0);
	let keys: Vec<String> = out["keys"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	assert!(in_order(&keys, &["guide", "map", "questing", "discovery", "qualityoflife", "integrations", "guidepacks", "gamepad", "thanks", "recorder", "about"]), "keys: {keys:?}");
	assert!(keys.contains(&"theme".to_string()) && !keys.contains(&"appearance".to_string()), "keys: {keys:?}");
	assert!(is_match(text(&out["options appearance"]), r"^theme: Thema > "), "{}", out["options appearance"]);
	let mut rest = out.clone();
	for k in ["keys", "options appearance"] {
		rest.as_object_mut().unwrap().remove(k);
	}
	assert_eq!(
		rest,
		json!({
			"options quests": "questing: Questen > Aufträge",
			"options gear": "questing: Questen > Belohnungen & Ausrüstung",
			"options lookup": "discovery: Entdecken > Nachschlagen",
			"options qualityoflife": "qualityoflife: Komfort > Aufträge",
			"options about": "about: Über > ",
			"packs": "guidepacks: Community-Guides > ",
		})
	);
}

#[test]
fn registered_controls_read_and_write_settings_disabled_functions_follow_other_settings() {
	let out = run_opts(
		r#"
		UI.ShowOptions("quests")
		local c = O.Controls("quests")
		local size = c["fake.size"]
		local before = size:IsEnabled()
		c["fake.markers"]:Click()
		local after = size:IsEnabled()
		stub.RunScript(size.Slider, "OnValueChanged", 1.5, true)
		local blocked = Polestar.Get("fake.size")
		c["fake.markers"]:Click()
		stub.RunScript(size.Slider, "OnValueChanged", 1.52, true)
		c["fake.mode"].Button:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Manual" then r:Click() end end
		c["Reset lockouts"].Button:Click()
		emit({ before = before, after = after, blocked = blocked, size = Polestar.Get("fake.size"), mode = Polestar.Get("fake.mode"),
			label = c["fake.mode"].Button.Label:GetText(), clicks = uifake.clicks(), asked = Polestar.Widgets.ModalShown() })"#,
		"",
		"",
		FAKE_PAGE,
	);
	assert_eq!(out["before"], true);
	assert_eq!(out["after"], false, "disabled while markers are off");
	assert_eq!(out["blocked"], 1, "a disabled slider does not write");
	assert_eq!(out["size"], 1.5);
	assert_eq!(out["mode"], "manual");
	assert_eq!(out["label"], "Manual");
	assert_eq!(out["clicks"], 1);
	assert_eq!(out["asked"], false, "a button without confirm acts at once");
}

#[test]
fn a_registration_made_after_the_window_exists_shows_up_a_malformed_one_is_refused() {
	let out = run(r#"
		UI.ShowOptions()
		Polestar.RegisterDefaults("late", { thing = true })
		local ok = Polestar.RegisterOptions({ page = "Maps", icon = "icon-explore", order = 20, controls = { { kind = "toggle", key = "late.thing", label = "Late thing" } } })
		local bad, err = Polestar.RegisterOptions({ page = "Broken", controls = { { kind = "wheel", key = "x" } } })
		local bad2 = Polestar.RegisterOptions({ page = "Broken", controls = { { kind = "button", label = "No handler" } } })
		local nav = navLabels()
		UI.ShowOptions("maps")
		emit({ ok = ok, bad = bad, err = err, bad2 = bad2, nav = nav, controls = (function() local n = 0 for _ in pairs(O.Controls("maps")) do n = n + 1 end return n end)() })"#);
	assert_eq!(out["ok"], true);
	assert_eq!(out["bad"], false);
	assert!(is_match(text(&out["err"]), r"unknown kind wheel"));
	assert_eq!(out["bad2"], false);
	assert!(includes(&out["nav"], "Maps") && !includes(&out["nav"], "Broken"));
	assert_eq!(out["controls"], 1);
}

#[test]
fn a_registered_page_may_give_its_own_key_which_opens_it_whatever_its_title_a_key_that_is_not_a_string_is_refused() {
	let out = run(r#"
		Polestar.RegisterDefaults("mine", { thing = true })
		local ok = Polestar.RegisterOptions({ page = "Mein Addon", key = "myaddon", controls = { { kind = "toggle", key = "mine.thing", label = "Thing" } } })
		local bad, err = Polestar.RegisterOptions({ page = "Broken", key = 5, controls = {} })
		UI.ShowOptions("myaddon")
		emit({ ok = ok, bad = bad, err = err, key = O.page.key, title = PolestarOptions.Title:GetText() })"#);
	assert_eq!(out, json!({ "ok": true, "bad": false, "err": "RegisterOptions: key must be a string", "key": "myaddon", "title": "Mein Addon" }));
}

#[test]
fn built_in_controls_write_settings_and_follow_changes_made_elsewhere() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local c = O.Controls("guide")
		c["ui.compact"]:Click()
		local compact = Polestar.Get("ui.compact")
		Polestar.Set("ui.showNotes", false)
		local followed = c["ui.showNotes"].checked
		local notesOpen = c["ui.notesOpen"]:IsEnabled()
		O.Select("guide", "Automation")
		O.Controls("guide", "Automation")["behavior.skipGrey"]:Click()
		O.Select("guide", "Arrow & routes")
		local nav = O.Controls("guide", "Arrow & routes")
		Polestar.Set("nav.tomtom", false)
		stub.RunScript(O.Controls("guide", "Window")["ui.maxHeight"].Slider, "OnValueChanged", 0.79, true)
		-- The accent lives on the Theme page now (UI/Looks/Theme.lua); its colour row is the window's.
		local accent = ctl("ui.accent")
		accent:Click("LeftButton")
		local info = ColorPickerFrame.info
		ColorPickerFrame.GetColorRGB = function() return 0.9, 0.3, 0.1 end
		info.swatchFunc()
		local picked = Polestar.Get("ui.accent")
		info.cancelFunc()
		emit({ compact = compact, followed = followed, notesOpen = notesOpen, height = Polestar.Get("ui.maxHeight"),
			picked = picked, cancelled = Polestar.Get("ui.accent"), skipGrey = Polestar.Get("behavior.skipGrey"),
			tomtomArrow = nav["nav.useTomTomArrow"]:IsEnabled() })"#);
	assert_eq!(out["compact"], true);
	assert_eq!(out["followed"], false);
	assert_eq!(out["notesOpen"], false, "Expand step tips greys out with the tips off");
	assert_eq!(out["height"], 0.8, "slider values snap to the step");
	assert_eq!(out["picked"], json!([0.9, 0.3, 0.1]));
	assert_eq!(out["cancelled"], false, "cancel restores the previous value: no custom accent");
	assert_eq!(out["skipGrey"], true);
	assert_eq!(out["tomtomArrow"], false);
}

#[test]
fn the_lock_for_the_arrow_buttons_and_timers_sits_under_lock_window_off_by_default_and_says_shift_drag_still_moves_them() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local w = O.Controls("guide", "Window")["ui.lockHud"]
		local groups = O.Search("lock")
		local labels, help = {}, nil
		for _, g in ipairs(groups) do
			if g.title:find("Guide  \194\183  Window", 1, true) == 1 then
				for _, c in ipairs(g.controls) do
					labels[#labels + 1] = c.label
					if c.key == "ui.lockHud" then help = c.help end
				end
			end
		end
		local default = Polestar.Get("ui.lockHud")
		w:Click()
		emit({ labels = labels, help = help, default = default, clicked = Polestar.Get("ui.lockHud"), label = w.Label:GetText() })"#);
	// Move frames and its grid (UI/Movers.lua) follow them in the section.
	assert_eq!(out["labels"].as_array().unwrap()[..2], [json!("Lock window"), json!("Lock arrow and buttons")]);
	assert_eq!(out["help"], "Stops stray drags on the arrow, the action buttons and the flight and instance timers. Shift-drag still moves them.");
	assert_eq!(out["default"], false);
	assert_eq!(out["clicked"], true);
	assert_eq!(out["label"], "Lock arrow and buttons");
}

#[test]
fn search_finds_settings_by_label_and_help_across_pages_registered_ones_included() {
	let out = run_opts(
		r#"
		UI.ShowOptions()
		local box = PolestarOptions.Search
		box:SetText("arrow")
		stub.RunScript(box, "OnTextChanged", true)
		local titles = {}
		for _, g in ipairs(O.results.groups) do titles[#titles + 1] = g.title end
		local arrow = { titles = titles, count = O.results.count, title = PolestarOptions.Title:GetText(), sub = PolestarOptions.Subtitle:GetText(),
			tabRow = PolestarOptions.TabRow:IsShown(), footer = footer() }
		local groups, n = O.Search("pins objectives")
		local help = { n = n, label = groups[1] and groups[1].controls[1].label }
		local _, none = O.Search("zzzz")
		local found = {}
		for _, q in ipairs({ "compact", "tomtom", "trainer", "minimap button" }) do found[q] = select(2, O.Search(q)) end
		box:SetText("")
		stub.RunScript(box, "OnTextChanged", true)
		emit({ arrow = arrow, help = help, none = none, found = found, back = PolestarOptions.Title:GetText() })"#,
		"",
		"",
		FAKE_PAGE,
	);
	// Page and tab (a result card's title adds its section).
	let mut titles: Vec<String> = out["arrow"]["titles"].as_array().unwrap().iter().map(|v| tab_of(v.as_str().unwrap())).collect();
	titles.dedup();
	assert!(in_order(&titles[..2], &["Guide  \u{b7}  Window", "Guide  \u{b7}  Arrow & routes"]), "the best groups first: {titles:?}");
	assert!(titles.contains(&"Map  \u{b7}  Guide & quests".to_string()) && titles.contains(&"Gamepad  \u{b7}  Key bindings".to_string()), "{titles:?}");
	assert!(!titles.iter().any(|t| t.starts_with("Appearance")), "{titles:?}");
	assert_eq!(out["arrow"]["title"], "Search");
	assert_eq!(out["arrow"]["sub"], format!("{} settings match", out["arrow"]["count"]).as_str());
	assert_eq!(out["arrow"]["tabRow"], false);
	let footer: Vec<String> = out["arrow"]["footer"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	assert!(footer.contains(&"Reload UI".to_string()) && footer.contains(&"Close".to_string()) && !footer.contains(&"Reset page".to_string()), "{footer:?}");
	assert_eq!(out["help"], json!({ "n": 1, "label": "Objective markers" }), "help text is searchable");
	assert_eq!(out["none"], 0);
	for (q, v) in out["found"].as_object().unwrap() {
		assert!(n(v) >= 1.0, "search finds \"{q}\"");
	}
	assert_eq!(out["back"], "Guide");
}

#[test]
fn reset_page_asks_in_the_confirm_dialog_cancel_keeps_the_page_accept_resets_only_that_page() {
	let out = run(r#"
		Polestar.Set("ui.compact", true)
		Polestar.Set("nav.arrowScale", 1.5)
		UI.ShowOptions("guide")
		local b = footerButton("Reset page")
		b:Click()
		local asked = { Polestar.Widgets.ModalShown(), Polestar.Get("ui.compact") }
		PolestarModal.Box.Cancel:Click()
		local cancelled = { Polestar.Widgets.ModalShown(), Polestar.Get("ui.compact") }
		b:Click()
		PolestarModal.Box.Action:Click()
		emit({ asked = asked, cancelled = cancelled, closed = not Polestar.Widgets.ModalShown(), compact = Polestar.Get("ui.compact"),
			arrow = Polestar.Get("nav.arrowScale") })"#);
	assert_eq!(out["asked"], json!([true, true]), "the first click only asks");
	assert_eq!(out["cancelled"], json!([false, true]), "cancel closes the dialog and resets nothing");
	assert_eq!(out["closed"], true);
	assert_eq!(out["compact"], false);
	assert_eq!(out["arrow"], 1.5, "the arrow's look is on its own page, not reset with Guide");
}

#[test]
fn a_tab_whose_module_is_not_loaded_is_left_out_a_page_with_nothing_at_all_says_so() {
	let out = run_opts(
		r#"
		UI.ShowOptions("navigation")
		local tabs = {}
		for _, b in ipairs(PolestarOptions.tabButtons) do if b:IsShown() then tabs[#tabs + 1] = b.Label:GetText() end end
		local landed = PolestarOptions.Title:GetText()
		UI.ShowOptions("discovery")
		emit({ tabs = tabs, landed = landed, empty = O.view.empty, controls = (function() local n = 0 for _ in pairs(O.Controls("discovery")) do n = n + 1 end return n end)() })"#,
		"{ noNav = true }",
		"",
		"",
	);
	assert_eq!(out["landed"], "Guide");
	assert_eq!(out["tabs"], json!(["Window", "Automation"]), "no dead Arrow & routes tab without Nav");
	assert_eq!(out["empty"], true);
	assert_eq!(out["controls"], 0);
}

#[test]
fn recorder_page_not_installed_then_live_counts_and_a_stop_control() {
	let missing = run(r#"
		UI.ShowOptions("recorder")
		emit({ text = O.view.Refresh and select(1, (function() for _, r in ipairs({ O.view:GetRegions() }) do if r.text and r.text:find("not loaded") then return r.text end end end)()) })"#);
	assert!(is_match(text(&missing["text"]), r"The Polestar Recorder addon is not loaded"));
	let out = run(r#"
		stub.addonsLoaded.Polestar_Recorder = true
		PolestarRecorderDB = { schema = 2, enabled = true, install = "k3j9x0q2m7ab", seq = 9, acked = 7, chunks = { [8] = ("x"):rep(1024), [9] = ("x"):rep(2048) } }
		local sent = {}
		PolestarRecorder_Command = function(arg) sent[#sent + 1] = arg; if arg == "off" then PolestarRecorderDB.enabled = false end end
		UI.ShowOptions("recorder")
		local values = {}
		for _, f in ipairs({ O.view:GetChildren() }) do if rawget(f, "Value") and f:IsShown() then values[f.Label:GetText()] = f.Value:GetText() end end
		local stop
		for _, f in ipairs({ O.view:GetChildren() }) do if rawget(f, "Title") and f.Title:GetText() == "Stop recording" then stop = f end end
		stop:Click()
		emit({ values = values, sent = sent, after = stop.Title:GetText() })"#);
	assert_eq!(out["values"], json!({ "Status": "Recording", "Waiting to upload": "2", "Stored": "3 KiB", "Last uploaded chunk": "7" }));
	assert_eq!(out["sent"], json!(["off"]));
	assert_eq!(out["after"], "Start recording");
}

#[test]
fn about_reset_all_settings_asks_in_the_confirm_dialog_reset_positions_clears_saved_positions() {
	let out = run(r#"
		Polestar.Set("ui.scale", 1.4)
		Polestar.Set("ui.pos", { 10, 20 })
		UI.ShowOptions("about")
		local reset = O.view.ResetAll
		reset:Click()
		local asked = { Polestar.Get("ui.scale"), Polestar.Widgets.ModalShown() }
		PolestarModal.Box.Cancel:Click()
		local cancelled = Polestar.Get("ui.scale")
		reset:Click()
		PolestarModal.Box.Action:Click()
		O.ResetPositions()
		emit({ asked = asked, cancelled = cancelled, accepted = Polestar.Get("ui.scale"), pos = Polestar.Get("ui.pos") or false,
			arrow = lastCall("ResetArrowPosition") })"#);
	assert_eq!(out["asked"], json!([1.4, true]), "the first click only asks");
	assert_eq!(out["cancelled"], 1.4);
	assert_eq!(out["accepted"], 1);
	assert_eq!(out["pos"], false);
	assert_eq!(out["arrow"], json!(["ResetArrowPosition"]));
}

// The Menu scale sits in the settings window's header: the value follows the drag, the window rescales when it
// ends (it sits in what it scales), and the window's size stays within the screen at the new scale.
#[test]
fn the_header_s_menu_scale_applies_when_the_drag_ends_and_the_window_stays_on_the_screen() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local t = PolestarOptions.HeaderTools
		stub.RunScript(t.Slider, "OnValueChanged", 1.2, true)
		local during = { PolestarOptions:GetScale(), t.Value:GetText() }
		stub.RunScript(t.Slider, "OnMouseUp", "LeftButton")
		local after = PolestarOptions:GetScale()
		emit({ during = during, after = after, stored = Polestar.Get("ui.menuScale"),
			size = { PolestarOptions:GetWidth() * after, PolestarOptions:GetHeight() * after }, screen = { UIParent:GetWidth(), UIParent:GetHeight() } })"#);
	assert_eq!(out["during"], json!([1, "120%"]));
	assert_eq!(out["after"], 1.2);
	assert_eq!(out["stored"], 1.2);
	assert!(n(&out["size"][0]) <= n(&out["screen"][0]) && n(&out["size"][1]) <= n(&out["screen"][1]), "on screen: {} in {}", out["size"], out["screen"]);
}

// The sidebar's page list must never run into the version and stage chip at its foot, however many pages
// register, in either font and at any menu scale: the list scrolls in its own area, which ends on the footer
// bar's line, and the selected page is scrolled into view. The hub's sidebar is the same shell.
#[test]
fn the_sidebar_page_list_never_reaches_the_version_line_it_scrolls_the_selected_page_in_view() {
	let out = run(r#"
		local W, SH = Polestar.Widgets, Polestar.Widgets.SHELL
		Polestar.RegisterDefaults("many", { on = true })
		for i = 1, 14 do
			Polestar.RegisterOptions({ page = "Module " .. i, order = 60 + i, controls = { { kind = "toggle", key = "many.on", label = "On" } } })
		end
		local function measure(F)
			local side = F:GetHeight() - 2
			local sf = F.NavScroll
			local view, content, scroll = sf.psView, sf.psContent, sf:GetVerticalScroll()
			local floor = F.psNavTop + view
			local statusTop = side - SH.foot - F.Status:GetStringHeight()
			local chipTop = side - SH.foot - F.Status:GetStringHeight() / 2 - W.CHIP_H / 2
			local activeTop, activeH, clipped = nil, 0, true
			for _, b in ipairs(F.navButtons) do
				if b:IsShown() then
					if b:GetParent() ~= sf.Child then clipped = false end
					if b.Bar:IsShown() then local _, _, _, _, y = b:GetPoint(1); activeTop, activeH = -y, b:GetHeight() end
				end
			end
			return { floor = floor, foot = math.min(statusTop, chipTop), overflow = content > view, clipped = clipped,
				activeIn = activeTop ~= nil and activeTop >= scroll and activeTop + activeH <= scroll + view + 0.01, bar = sf.Bar:IsShown() }
		end
		local out = {}
		for _, font in ipairs({ "game", "inter" }) do
			for _, scale in ipairs({ 0.7, 1, 1.4 }) do
				Polestar.Set("ui.font", font)
				Polestar.Set("ui.menuScale", scale)
				UI.ShowOptions("about")
				out[#out + 1] = measure(PolestarOptions)
				UI.ShowOptions("guide")
				out[#out + 1] = measure(PolestarOptions)
			end
		end
		-- The hub: a section whose index holds thirty entries, the last selected.
		local items = {}
		for i = 1, 30 do items[i] = { key = "k" .. i, label = "Entry " .. i } end
		UI.RegisterSection({ key = "Many", label = "Many", icon = "gear", order = 90, nav = function() return items, "k30" end,
			build = function(parent) end, render = function() end })
		UI.ShowPicker()
		UI.Picker.ShowSection("Many")
		out[#out + 1] = measure(PolestarPicker)
		emit(out)"#);
	for (i, m) in out.as_array().unwrap().iter().enumerate() {
		assert!(n(&m["floor"]) <= n(&m["foot"]), "case {i}: the list ends at {}, the version starts at {}", m["floor"], m["foot"]);
		assert_eq!(m["overflow"], true, "case {i}: more pages than room");
		assert_eq!(m["clipped"], true, "case {i}: rows sit in the scroll area");
		assert_eq!(m["bar"], true, "case {i}: the scroll bar shows");
		assert_eq!(m["activeIn"], true, "case {i}: the selected page is in view");
	}
}

fn round(c: &Value) -> Value {
	Value::Array(
		c.as_array()
			.unwrap()
			.iter()
			.map(|v| {
				let r = (n(v) * 1000.0).round() / 1000.0;
				if r.fract() == 0.0 {
					json!(r as i64)
				} else {
					json!(r)
				}
			})
			.collect(),
	)
}

// Window border, band and shadow are the player's: each change repaints every open window at once, and a
// right-click on the control restores the house look.
#[test]
fn window_border_band_and_shadow_repaint_every_window_live_right_click_restores_each() {
	let out = run(r#"
		local T = Polestar.Theme
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		UI.ShowOptions("guide")
		-- The frame's settings are on the Theme page (UI/Looks/Theme.lua): each row where it lives.
		local c = setmetatable({}, { __index = function(_, k) return (ctl(k)) end })
		local GF = PolestarGuideFrame
		local wins = { options = PolestarOptions, guide = GF }
		local bands = { options = PolestarOptions.Band, guide = Polestar.UI.GuideFrame.parts.band }
		local function look()
			local o = {}
			for name, f in pairs(wins) do
				local e = f.psBorder[1]
				local r, g, b, a = e:GetVertexColor()
				local _, _, _, ba = bands[name]:GetVertexColor()
				o[name] = { border = e:IsShown(), colour = { r, g, b, a }, px = e:GetHeight(), band = ba, shadow = f.psShadow ~= nil and f.psShadow:IsShown() }
			end
			return o
		end
		local out = { house = look(), hairline = { T.Color("border") }, accent = { T.Accent() } }
		c["ui.border"]:Click(); out.noBorder = look(); c["ui.border"]:Click()
		c["ui.borderAccent"]:Click(); out.accentBorder = look()
		stub.RunScript(c["ui.borderSize"].Slider, "OnValueChanged", 3, true); out.thick = look()
		c["ui.band"]:Click(); c["ui.shadow"]:Click(); out.bare = look()
		c["ui.borderColor"]:Click("LeftButton")
		ColorPickerFrame.GetColorRGB = function() return 0.2, 0.9, 0.4 end
		ColorPickerFrame.info.swatchFunc()
		out.own = { look = look(), accentOff = Polestar.Get("ui.borderAccent") }
		for _, k in ipairs({ "ui.borderColor", "ui.borderSize", "ui.band", "ui.shadow" }) do c[k]:Click("RightButton") end
		out.reset = look()
		emit(out)"#);
	let house_look = json!({ "border": true, "colour": round(&out["hairline"]), "px": 1, "band": 1, "shadow": true });
	let mut accent = out["accent"].as_array().unwrap().clone();
	accent.push(json!(0.8));
	let accent = round(&Value::Array(accent));
	for w in ["options", "guide"] {
		let mut house = out["house"][w].clone();
		house["colour"] = round(&house["colour"]);
		assert_eq!(house, house_look, "{w}: the house look");
		assert_eq!(out["noBorder"][w]["border"], false, "{w}: border off");
		assert_eq!(round(&out["accentBorder"][w]["colour"]), accent, "{w}: accent border");
		assert_eq!(out["thick"][w]["px"], 3, "{w}: 3px border");
		assert_eq!(out["bare"][w]["band"], 0, "{w}: band off");
		assert_eq!(out["bare"][w]["shadow"], false, "{w}: shadow off");
		assert_eq!(round(&out["own"]["look"][w]["colour"]), json!([0.2, 0.9, 0.4, 1]), "{w}: own border colour");
		let mut reset = out["reset"][w].clone();
		reset["colour"] = round(&reset["colour"]);
		assert_eq!(reset, house_look, "{w}: right-click restored the house look");
	}
	assert_eq!(out["own"]["accentOff"], false, "picking an own border colour turns the accent border off");
}

// A new font lays the page out again; a label too long for its half in the new face is cut with an ellipsis (its
// whole text in the tooltip), never wrapped: its row keeps its 36px and the rows below keep their places.
#[test]
fn switching_the_font_lays_the_page_out_again_a_label_that_no_longer_fits_is_cut_its_row_keeps_its_height() {
	let out = run(r#"
		Polestar.Set("ui.font", "game")
		UI.ShowOptions("guide")
		local c = O.Controls("guide")
		local row, below = c["ui.shown"], c["ui.locked"]
		local function top(w) local _, _, _, _, y = w:GetPoint(1) return y end
		local before = { h = row:GetHeight(), below = top(below), wrap = row.Label:GetWordWrap() }
		-- Inter set eight times wider than the game font, as a font change can.
		local M = stub.Methods
		local function wide(self) return (self.font and tostring(self.font[1]):find("Inter")) and 8 or 1 end
		M.GetUnboundedStringWidth = function(self)
			return #tostring(self.text or "") * ((self.font and self.font[2]) or 12) * 0.5 * wide(self)
		end
		Polestar.Set("ui.font", "inter")
		emit({ before = before, after = { h = row:GetHeight(), below = top(below), wrap = row.Label:GetWordWrap(),
			cut = row.Label:GetStringWidth() <= row.Label:GetWidth() } })"#);
	let (before, after) = (&out["before"], &out["after"]);
	assert_eq!(before["h"], 36);
	assert_eq!(after["h"], 36, "the row keeps its height");
	assert_eq!(after["below"], before["below"], "the rows below keep their places");
	assert_eq!(after["wrap"], false, "one line");
	assert_eq!(after["cut"], true, "cut at its half");
}

#[test]
fn a_blizzard_settings_category_opens_the_options_window() {
	let out = run(r#"
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		open:Click()
		emit({ registered = cat ~= nil, opened = PolestarOptions:IsShown() })"#);
	assert_eq!(out, json!({ "registered": true, "opened": true }));
}

#[test]
fn in_combat_the_settings_canvas_button_leaves_the_protected_game_panel_alone() {
	let out = run(r#"
		local hidden = 0
		SettingsPanel = CreateFrame("Frame", "SettingsPanel", UIParent)
		HideUIPanel = function(f) hidden = hidden + 1; f:Hide() end
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		stub.inCombat = true
		open:Click()
		local inCombat = { hidden = hidden, opened = PolestarOptions:IsShown(), hint = #stub.messages > 0 }
		PolestarOptions:Hide()
		stub.inCombat = false
		open:Click()
		emit({ inCombat = inCombat, hidden = hidden, opened = PolestarOptions:IsShown() })"#);
	assert_eq!(out["inCombat"], json!({ "hidden": 0, "opened": true, "hint": true }));
	assert_eq!(out["hidden"], 1);
	assert_eq!(out["opened"], true);
}

// With the gamepad interface, a panel closed from addon code leaves the gamepad's focus blocked (Core/Init.lua,
// GamepadUI): B closes it.
#[test]
fn with_the_gamepad_interface_the_settings_canvas_button_leaves_the_game_panel_alone() {
	let out = run_opts(
		r#"
		local hidden = 0
		SettingsPanel = CreateFrame("Frame", "SettingsPanel", UIParent)
		HideUIPanel = function(f) hidden = hidden + 1; f:Hide() end
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		open:Click()
		emit({ hidden = hidden, opened = PolestarOptions:IsShown(), hint = stub.messages[#stub.messages] })"#,
		"",
		"Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }; C_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }",
		"",
	);
	assert_eq!(out["hidden"], 0);
	assert_eq!(out["opened"], true);
	assert!(is_match(text(&out["hint"]), r"Close the game menu to see Polestar's settings\.$"));
}

#[test]
fn hiding_a_window_mid_drag_on_its_scroll_bar_ends_the_drag() {
	let out = run(r#"
		UI.ShowOptions("navigation")
		local bar = PolestarOptions.Scroll.Bar
		Polestar.Widgets.SetScrollContent(PolestarOptions.Scroll, 2000, 400)
		stub.RunScript(bar, "OnMouseDown", "LeftButton")
		local dragging = bar:IsShown() and bar:GetScript("OnUpdate") ~= nil
		-- The client fires OnHide on the bar when its window hides (Escape);
		-- the stub does not cascade, so hide the bar itself.
		bar:Hide()
		emit({ dragging = dragging, after = bar:GetScript("OnUpdate") ~= nil })"#);
	assert_eq!(out, json!({ "dragging": true, "after": false }));
}

// The settings are a window of their own (Fitz, architecture v3): no hub rail; the lockup says "Settings"; the hub's
// Options opens it beside the hub, which stays; the hub's own sections never close it; it moves by its header.
#[test]
fn the_settings_window_is_its_own_window_no_hub_rail_the_hub_stays_and_it_moves_by_its_header() {
	let out = run(r#"
		local function railButton(f, key) for _, b in ipairs(f.railButtons) do if b:IsShown() and b.psKey == key then return b end end end
		UI.ShowPicker()
		local hub = PolestarPicker
		railButton(hub, "Options"):Click()
		local settings = PolestarOptions
		local opened = { shown = settings:IsShown(), hub = hub:IsShown(), rail = rawget(settings, "Rail") == nil and #settings.railButtons == 0,
			tagline = settings.Tagline:GetText(), main = settings.psMainW, width = settings:GetWidth() - settings.psSidebar - 2 }
		UI.ShowPicker()
		local back = { settings = settings:IsShown(), hub = hub:IsShown() }
		stub.RunScript(settings.Header, "OnDragStart")
		emit({ opened = opened, back = back, moving = rawget(settings, "moving") == true })"#);
	assert_eq!(out["opened"]["shown"], true);
	assert_eq!(out["opened"]["hub"], true, "the hub stays");
	assert_eq!(out["opened"]["rail"], true, "no hub rail");
	assert_eq!(out["opened"]["tagline"], "Settings");
	assert_eq!(out["opened"]["main"], out["opened"]["width"], "the rail's width goes to the page");
	assert_eq!(out["back"], json!({ "settings": true, "hub": true }), "the hub's sections leave the settings open");
	assert_eq!(out["moving"], true, "dragged by its header");
}

// The page subtitle wraps between the main column's pads, two lines at most, the rest cut with an ellipsis; the
// hub's narrower column bounds it too.
#[test]
fn a_shell_subtitle_wraps_to_two_lines_within_the_main_column_and_cuts_the_rest() {
	let out = run(r#"
		local W = Polestar.Widgets
		UI.ShowOptions("guide")
		local f = PolestarOptions
		local s = f.Subtitle
		local page = { text = s:GetText(), width = s:GetWidth(), lines = s:GetNumLines(), wrap = s:GetWordWrap(), height = s:GetHeight() }
		local long = string.rep("A long subtitle that runs on. ", 12)
		W.ShellTitle(f, "Title", long)
		local cut = { text = s:GetText(), lines = s:GetNumLines() }
		UI.ShowPicker()
		emit({ page = page, cut = cut, bodyWidth = f.BodyWidth, hub = { width = PolestarPicker.Subtitle:GetWidth(), bodyWidth = PolestarPicker.BodyWidth } })"#);
	assert!(is_match(text(&out["page"]["text"]), r"^The guide window, the arrow and its routes"));
	assert_eq!(out["page"]["wrap"], true);
	assert_eq!(out["page"]["width"], out["bodyWidth"]);
	assert!(n(&out["page"]["lines"]) <= 2.0, "{} lines", out["page"]["lines"]);
	assert!(n(&out["page"]["height"]) < (112 - 66) as f64, "box {}px", out["page"]["height"]);
	assert_eq!(out["cut"]["lines"], 2);
	assert!(is_match(text(&out["cut"]["text"]), r"^A long subtitle that runs on\. .*\S…$"));
	assert_eq!(out["hub"]["width"], out["hub"]["bodyWidth"]);
}

#[test]
fn distances_the_arrow_row_picks_yards_or_metres_right_click_restores_yards() {
	let out = run_opts(
		r#"
		UI.ShowOptions("guide")
		O.Select("guide", "Arrow & routes")
		local row = O.Controls("guide", "Arrow & routes")["nav.distanceUnit"]
		local before = row.Button.Label:GetText()
		row.Button:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Metres" then r:Click() end end
		local picked, label = Polestar.Get("nav.distanceUnit"), row.Button.Label:GetText()
		row:Click("RightButton")
		emit({ before = before, picked = picked, label = label, reset = Polestar.Get("nav.distanceUnit") })"#,
		"",
		"",
		r#"Polestar.RegisterDefaults("nav", { distanceUnit = "yards" })"#,
	);
	assert_eq!(out, json!({ "before": "Yards (the game's unit)", "picked": "metres", "label": "Metres", "reset": "yards" }));
}

// Tangens (Discord): healing in Wailing Caverns, the window was in the way all run and the setting hard to find.
#[test]
fn guide_window_in_dungeons_and_battlegrounds_hides_by_default_keep_visible_is_a_pick_right_click_restores_hide_and_search_finds_it() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local row = O.Controls("guide")["ui.instance"]
		local before = row.Button.Label:GetText()
		row.Button:Click()
		local choices = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then choices[#choices + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Keep visible" then r:Click() end end
		local picked = Polestar.Get("ui.instance")
		row:Click("RightButton")
		local found = {}
		for _, q in ipairs({ "dungeon", "raid", "battleground", "arena", "instance", "hide" }) do
			found[q] = false
			for _, g in ipairs((O.Search(q))) do for _, c in ipairs(g.controls) do if c.key == "ui.instance" then found[q] = true end end end
		end
		emit({ label = row.Label:GetText(), before = before, choices = choices, picked = picked, reset = Polestar.Get("ui.instance"), found = found })"#);
	assert_eq!(
		out,
		json!({ "label": "In dungeons and battlegrounds", "before": "Hide", "choices": ["Keep visible", "Hide"], "picked": "show", "reset": "hide",
			"found": { "dungeon": true, "raid": true, "battleground": true, "arena": true, "instance": true, "hide": true } })
	);
}

// Discovery, Dungeons: which dungeons the leveling guides' `when dungeon` steps take this character through
// (Dungeons/Dungeons.lua, Engine.ChooseDungeon). Only the dungeons this character's guides have steps for
// are offered (0.3.6 plan: "Options page lists only dungeons with steps"): Ragefire Chasm in a guide whose
// steps are read and The Deadmines here (Engine.GuideDungeons; engine-when-dungeon.rs reads them from the
// guides). A choice saved for a dungeon not offered (Gnomeregan) is kept.

#[test]
fn discovery_dungeons_a_toggle_per_dungeon_the_guides_have_steps_for_all_off_chosen_per_character_in_the_client_s_language() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"])],
		script: format!("uistub.install()\nuistub.guideDungeons = {{ [389] = true, [36] = true }}\nstub.login()\nPolestar.UI.LoadOptions()\n{HELPERS}\nlocal UI, O, E = Polestar.UI, Polestar.UI.Options, Polestar.Engine")
			+ r#"
		Polestar.Names.Instance = function(id) if id == 389 then return "Огненная пропасть" end end
		Polestar.CharState().dungeons[90] = true
		UI.ShowOptions("dungeons")
		local c = O.Controls("discovery", "Dungeons")
		local labels, on = {}, 0
		for _, d in ipairs(Polestar.Dungeons.ROUTE) do
			local row = c[d[1] == 389 and "Огненная пропасть" or d[2]]
			if row then
				labels[#labels + 1] = row.Label:GetText()
				if row.checked then on = on + 1 end
			end
		end
		local help = c["The Deadmines"].psDesc
		local rfc, dm = c["Огненная пропасть"], c["The Deadmines"]
		rfc:Click()
		dm:Click()
		local saved = {}
		for k, v in pairs(PolestarCharDB.dungeons) do saved[k] = v end
		local clicked = { rfc = rfc.checked, chosen = E.DungeonChosen(389), dm = E.DungeonChosen(36), saved = saved }
		local account = PolestarDB.settings.dungeons or false
		dm:Click("RightButton")
		local right = { dm = dm.checked, chosen = E.DungeonChosen(36) }
		local _, found = O.Search("Огненная")
		footerButton("Reset page"):Click()
		PolestarModal.Box.Action:Click()
		emit({ title = PolestarOptions.Title:GetText(), labels = labels, on = on, clicked = clicked, right = right, found = found,
			reset = { rfc = rfc.checked, chosen = E.DungeonChosen(389), saved = PolestarCharDB.dungeons },
			account = account, help = help, hidden = E.DungeonChosen(90) })"#,
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["title"], "Discovery");
	assert_eq!(out["labels"], json!(["Огненная пропасть", "The Deadmines"]), "only the dungeons this character's guides have steps for");
	assert!(out["help"].as_str().unwrap().ends_with("More dungeons join this list as they are added to the guides' route."), "{}", out["help"]);
	assert_eq!(out["on"], 0, "every dungeon is off by default: the solo route");
	assert_eq!(out["clicked"], json!({ "rfc": true, "chosen": true, "dm": true, "saved": { "389": true, "36": true, "90": true } }));
	assert_eq!(out["right"], json!({ "dm": false, "chosen": false }), "right-click puts it back to off");
	assert_eq!(out["found"], 1, "search finds the dungeon by the name it shows");
	assert_eq!(out["reset"], json!({ "rfc": false, "chosen": false, "saved": { "90": true } }), "Reset page turns the shown choices off; a hidden one's is kept");
	assert_eq!(out["hidden"], true, "Gnomeregan's saved choice stands though it is not offered");
	assert_eq!(out["account"], false, "the choice is per character, never an account setting");
}

#[test]
fn discovery_dungeons_with_no_guide_steps_for_any_dungeon_has_no_leveling_guides_section() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"])],
		script: format!("uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\n{HELPERS}\nlocal UI, O = Polestar.UI, Polestar.UI.Options")
			+ r#"
		UI.ShowOptions("dungeons")
		local c = O.Controls("discovery", "Dungeons")
		emit({ dm = c["The Deadmines"] ~= nil, rfc = c["Ragefire Chasm"] ~= nil })"#,
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "dm": false, "rfc": false }));
}

// Guide, Automation: the answer for every group quest (`when group`), shown once a guide for the character has
// one; and the offer of a Class guide when it opens (QoL/ClassQuests.lua), always there.
#[test]
fn guide_automation_an_answer_for_all_group_quests_while_a_guide_has_one_the_class_quest_offer() {
	let none = run(r#"
		UI.ShowOptions("guide")
		O.Select("guide", "Automation")
		local c = O.Controls("guide", "Automation")
		emit({ group = c["behavior.groupQuests"] ~= nil, offer = c["behavior.offerClassQuests"] ~= nil })"#);
	assert_eq!(none, json!({ "group": false, "offer": true }), "no group-quest answer while no guide has a group quest");
	let out = run(r#"
		uistub.groupQuests = { { quest = 7, title = "Kobold Camp Cleanup" } }
		UI.ShowOptions("guide")
		O.Select("guide", "Automation")
		local c = O.Controls("guide", "Automation")
		local dd = c["behavior.groupQuests"]
		emit({ shown = dd ~= nil, label = dd and dd.Button.Label:GetText() or false, value = Polestar.Get("behavior.groupQuests") })"#);
	assert_eq!(out, json!({ "shown": true, "label": "Ask me at each", "value": "ask" }));
}

// The quest automation toggles show on Questing > Quests and on Quality of Life > Quests:
// one setting, so a click on either page is what the other shows (Fitz, 2026-11-05).
#[test]
fn the_quest_automation_toggles_are_on_questing_and_quality_of_life_and_stay_in_step() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &MODS)],
		script: "uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O = Polestar.UI, Polestar.UI.Options".to_string()
			+ r#"
		Polestar.Set("behavior.autoAccept", true)
		UI.ShowOptions("qualityoflife")
		O.Select("qualityoflife", "Quests")
		local qol = O.Controls("qualityoflife", "Quests")
		local r = { qolHas = qol["behavior.autoAccept"] ~= nil and qol["behavior.autoTurnin"] ~= nil }
		qol["behavior.autoAccept"]:Click()
		r.after = Polestar.Get("behavior.autoAccept")
		UI.ShowOptions("questing")
		O.Select("questing", "Quests")
		local q = O.Controls("questing", "Quests")
		r.questingHas = q["behavior.autoAccept"] ~= nil and q["behavior.autoTurnin"] ~= nil
		r.questingShows = q["behavior.autoAccept"].checked
		UI.ShowOptions("guide")
		O.Select("guide", "Automation")
		r.guideHas = O.Controls("guide", "Automation")["behavior.autoAccept"] ~= nil
		emit(r)"#,
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["qolHas"], true, "Quality of Life > Quests has both toggles");
	assert_eq!(out["questingHas"], true, "Questing > Quests has both toggles");
	assert_eq!(out["after"], false, "the click on Quality of Life turned it off");
	assert_eq!(out["questingShows"], false, "Questing shows the same setting");
	assert_eq!(out["guideHas"], false, "no longer under Guide > Automation");
}

// The real addon's modules (the plain `run` loads the core alone), on a client in `before`'s locale.
fn run_mods(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &ALL)],
		// The settings window's addon loads before the stub's fake Nav stands in, so its Look pages see the real
		// modules, as in the game.
		script: format!("Polestar.UI.LoadOptions()\nuistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n{SEARCH_HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const SEARCH_HELPERS: &str = r#"
local function top(q)
	local g, n = O.Search(q)
	local c = g[1] and g[1].controls[1]
	-- The group's page and tab (its title adds the section).
	local title = g[1] and g[1].title
	if title then title = title:match("^(.-  \194\183  .-)  \194\183  ") or title end
	return { key = c and (c.key or c.label) or false, group = title or false, n = n }
end
local function keys(q)
	local out = {}
	for _, g in ipairs((O.Search(q))) do for _, c in ipairs(g.controls) do out[#out + 1] = c.key or c.label end end
	return out
end
"#;

// Quality of Life also shows the conveniences players look for there, from the Questing, Guide and Map pages
// (Fitz, 2026-11-05): each stays on its home page too, one setting in both places.
#[test]
fn quality_of_life_shows_the_conveniences_from_their_home_pages_as_the_same_settings() {
	let out = run_mods(
		"",
		r#"
		UI.ShowOptions("qualityoflife")
		local function missing(page, tab, list)
			O.Select(page, tab)
			local c, out = O.Controls(page, tab), {}
			for _, k in ipairs(list) do if not c[k] then out[#out + 1] = k end end
			return out
		end
		local r = { missing = {
			quests = missing("qualityoflife", "Quests", { "behavior.autoAccept", "qol.instantQuestText", "qol.skipGossip", "qol.fastLoot", "qol.hideErrors",
				"qol.rewardAutoPick", "qol.rewardEquip", "qol.itemButton", "qol.stepInteract", "qol.hideQuestTracker" }),
			travel = missing("qualityoflife", "Travel", { "qol.hearthButton", "nav.castPrompt", "nav.alerts", "nav.nearbyButton", "nav.nearbyMenu" }),
			vendors = missing("qualityoflife", "Vendors", { "behavior.trainReminder", "qol.trainAll" }),
			map = missing("qualityoflife", "Map", { "maps.minimapButton", "maps.coords", "maps.minimapCoords" }),
			questing = missing("questing", "Quests", { "qol.fastLoot", "qol.hideQuestTracker" }),
			buttons = missing("questing", "Buttons", { "qol.itemButton", "qol.stepInteract", "qol.hearthButton" }),
			guide = missing("guide", "Automation", { "behavior.trainReminder" }),
			mapPage = missing("map", "Guide & quests", { "maps.minimapButton" }),
		} }
		Polestar.Set("qol.fastLoot", false)
		O.Select("qualityoflife", "Quests")
		O.Controls("qualityoflife", "Quests")["qol.fastLoot"]:Click()
		r.fastLoot = Polestar.Get("qol.fastLoot")
		O.Select("questing", "Quests")
		r.questingShows = O.Controls("questing", "Quests")["qol.fastLoot"].checked
		local before = Polestar.Get("maps.minimapButton")
		O.Select("qualityoflife", "Map")
		O.Controls("qualityoflife", "Map")["maps.minimapButton"]:Click()
		r.minimapFlipped = Polestar.Get("maps.minimapButton") ~= before
		O.Select("map", "Guide & quests")
		r.mapShows = O.Controls("map", "Guide & quests")["maps.minimapButton"].checked == Polestar.Get("maps.minimapButton")
		emit(r)"#,
	);
	for (tab, v) in out["missing"].as_object().unwrap() {
		assert!(v.as_array().is_some_and(|a| a.is_empty()) || v.as_object().is_some_and(|o| o.is_empty()), "{tab}: missing {v}");
	}
	assert_eq!(out["fastLoot"], true, "the click on Quality of Life turned it on");
	assert_eq!(out["questingShows"], true, "Questing shows the same setting");
	assert_eq!(out["minimapFlipped"], true);
	assert_eq!(out["mapShows"], true, "the Map page shows the same minimap button setting");
}

// Search finds a setting from a loose hint: words run together or hyphenated, a typo, the start of words,
// a synonym, a question; the label's own words rank first, and a setting on two pages comes once.
#[test]
fn search_forgives_joined_words_typos_prefixes_and_synonyms_and_puts_the_best_match_first() {
	let out = run_mods(
		"",
		r#"
		local once = 0
		for _, k in ipairs(keys("autoaccept")) do if k == "behavior.autoAccept" then once = once + 1 end end
		-- By score across groups (the page shows them grouped by page and tab).
		local function best(q)
			local list = {}
			for gi, g in ipairs((O.Search(q))) do for ci, c in ipairs(g.controls) do list[#list + 1] = { c.key or c.label, c.psScore, gi * 1000 + ci } end end
			table.sort(list, function(a, b) if a[2] ~= b[2] then return a[2] > b[2] end return a[3] < b[3] end)
			local out = {}
			for i, e in ipairs(list) do out[i] = e[1] end
			return out
		end
		local perf = {}
		for _, q in ipairs({ "fps", "performance", "lag", "stutter", "cpu", "frame rate", "slow" }) do perf[q] = best(q) end
		emit({ perf = perf,
			joined = top("autoaccept"), hyphen = top("auto-loot"), typo = top("auto acept"), prefixes = top("acc quest"),
			minimap = keys("minimap icon"), question = top("how do I turn off the quest tracker"),
			american = top("sell gray"), repiar = keys("repiar"), once = once, upper = top("AUTOACCEPT"),
		})"#,
	);
	assert_eq!(out["joined"], json!({ "key": "behavior.autoAccept", "group": "Questing  \u{b7}  Quests", "n": out["joined"]["n"] }));
	assert_eq!(out["once"], 1, "shown on two pages, found once");
	assert_eq!(out["upper"]["key"], "behavior.autoAccept");
	assert_eq!(out["hyphen"]["key"], "qol.fastLoot");
	assert_eq!(out["typo"]["key"], "behavior.autoAccept", "\"acept\" is one letter off");
	assert_eq!(out["prefixes"]["key"], "behavior.autoAccept", "\"acc\" starts accept, \"quest\" quests");
	// What changes Polestar's frame cost: the walking paths and route planning first, then Reduce motion; never the
	// Quest database, and no three-letter word matches inside another ("lag" in "flag").
	for (q, v) in out["perf"].as_object().unwrap() {
		let k: Vec<&str> = v.as_array().unwrap().iter().map(|x| x.as_str().unwrap()).collect();
		assert!(k.len() >= 3, "{q}: {k:?}");
		let mut first = k[..2].to_vec();
		first.sort();
		assert_eq!(first, ["nav.navRouting", "nav.travel"], "{q}: {k:?}");
		assert_eq!(k[2], "ui.reduceMotion", "{q}: {k:?}");
		assert!(!k.contains(&"qol.questDB"), "{q}: {k:?}");
	}
	// "Minimap icon" (the minimap button's mark, on Buttons) says both words in its label, so it leads; the pins'
	// "Minimap size" on Map pins › Icons is found too.
	assert_eq!(out["minimap"][0], "maps.minimapButtonIcon");
	assert!(includes(&out["minimap"], "nav.minimapIconSize") && includes(&out["minimap"], "maps.minimapButton"), "{}", out["minimap"]);
	assert_eq!(out["question"]["key"], "qol.hideQuestTracker", "filler words are not needed");
	assert_eq!(out["american"]["key"], "qol.sellJunk");
	assert!(includes(&out["repiar"], "qol.autoRepair"), "a swap of two letters is one typo");
}

// On a German client the German label and help match as before, accents optional, and so do the English search
// terms and the English label: players often type English.
#[test]
fn search_on_a_german_client_matches_german_labels_and_the_english_terms_and_label() {
	let out = run_mods(
		&format!("function GetLocale() return \"deDE\" end\n{}", forge_addontest::shipped_strings("deDE")),
		r#"emit({ german = top("Plündern"), noAccent = top("plundern"), term = top("autoloot"), english = top("faster auto loot"), stone = top("ruhestein button") })"#,
	);
	for q in ["german", "noAccent", "term", "english"] {
		assert_eq!(out[q]["key"], "qol.fastLoot", "{q}");
	}
	assert_eq!(out["stone"]["key"], "qol.hearthButton");
}

// One Chinese, Korean or Cyrillic character is a whole meaningful fragment inside a translated
// label; the 4-byte floor that keeps "lag" out of "flag" must not reject its UTF-8 bytes.
#[test]
fn search_finds_single_non_ascii_characters_inside_translated_labels() {
	for (locale, query, expected) in [("zhCN", "图", "maps.minimapButton"), ("zhTW", "圖", "maps.minimapButton"), ("koKR", "템", "qol.itemButton"), ("ruRU", "ш", "nav.arrowScale")] {
		let out = run_mods(&format!("function GetLocale() return \"{locale}\" end\n{}", forge_addontest::shipped_strings(locale)), &format!("emit(keys(\"{query}\"))"));
		assert!(out.as_array().is_some_and(|keys| keys.iter().any(|key| key.as_str() == Some(expected))), "{locale}: {query:?} did not find {expected}: {out}");
	}
}

// Short ASCII fragments, also ones that fold to ASCII ("lág"), still stay out of other words.
#[test]
fn non_ascii_search_keeps_short_ascii_and_folded_latin_fragments_out() {
	let out = run_mods(
		"",
		r#"
		Polestar.RegisterDefaults("searchFragment", { flag = true, submarine = true })
		Polestar.RegisterOptions({ page = "Search fragments", controls = {
			{ kind = "toggle", key = "searchFragment.flag", label = "Flag display" },
			{ kind = "toggle", key = "searchFragment.submarine", label = "Submarine" },
		} })
		local function has(query, key)
			for _, found in ipairs(keys(query)) do if found == key then return true end end
			return false
		end
		emit({ short = has("lag", "searchFragment.flag"), folded = has("lág", "searchFragment.flag"),
			long = has("mari", "searchFragment.submarine") })"#,
	);
	assert_eq!(out, json!({ "short": false, "folded": false, "long": true }));
}

// A query nothing matches says so and offers up to three settings near it.
#[test]
fn search_with_no_match_suggests_the_nearest_settings() {
	let out = run_mods(
		"",
		r#"
		UI.ShowOptions()
		local box = PolestarOptions.Search
		box:SetText("hearthston xyzzy")
		stub.RunScript(box, "OnTextChanged", true)
		local r = { count = O.results.count, suggestions = O.results.suggestions, sub = PolestarOptions.Subtitle:GetText() }
		local _, n, none = O.Search("qqqq")
		r.nothing = { n = n, suggestions = none }
		emit(r)"#,
	);
	assert_eq!(out["count"], 0);
	assert_eq!(out["sub"], "0 settings match");
	let s = out["suggestions"].as_array().unwrap();
	assert!(!s.is_empty() && s.len() <= 3, "{s:?}");
	assert!(includes(&out["suggestions"], "Hearthstone button"), "{s:?}");
	assert_eq!(out["nothing"]["n"], 0);
	assert_eq!(out["nothing"]["suggestions"], json!({}), "nothing near: no suggestion (an empty list)");
}

// Fitz, 0.3.5 preview: "Version 0.3.5-preview.2f100bfb3" ran under the Discord mark, and the BETA chip after it
// sat on the footer's "Reset page". The version line and its chip stay left of the mark; a version too long for
// "Version " drops the word, then is cut.
#[test]
fn the_version_line_and_its_stage_chip_end_before_the_discord_mark_in_both_windows_a_long_version_drops_the_word_then_is_cut() {
	let out = run(r#"
		local function foot(f)
			local st, mark = f.Status, f.Discord
			local _, _, _, sx = st:GetPoint(1)
			local _, _, _, mx = mark:GetPoint(1)
			return { text = st:GetText(), right = sx + st:GetStringWidth(), chip = f.Stage:IsShown() and f.Stage:GetWidth() or 0,
				markLeft = f.psSidebar + mx - mark:GetWidth() }
		end
		Polestar.version = "0.3.5"
		UI.ShowOptions()
		local short = foot(PolestarOptions)
		PolestarOptions:Hide()
		Polestar.version = "0.3.5-preview.2f100bfb3"
		UI.ShowOptions()
		local preview = foot(PolestarOptions)
		UI.ShowPicker()
		emit({ short = short, preview = preview, hub = foot(PolestarPicker) })"#);
	assert_eq!(out["short"]["text"], "Version 0.3.5");
	assert_eq!(out["preview"]["text"], "0.3.5-preview.2f100bfb3", "too long with the word: the number alone");
	for key in ["short", "preview", "hub"] {
		let f = &out[key];
		assert!(n(&f["chip"]) > 0.0, "{key}: the BETA chip shows");
		let end = n(&f["right"]) + 8.0 + n(&f["chip"]);
		assert!(end <= n(&f["markLeft"]), "{key}: the line and its chip end at {end}, the Discord mark starts at {}", f["markLeft"]);
	}
}

// #1684's sweep: in the client a texture's SetAlpha and its vertex colour's alpha are one value. The confirm
// dialog's scrim was SetAlpha'd to 55 % once, and every theme change repainted its colour at full alpha: after
// any scheme or skin change the next dialog darkened the whole screen solid. Its strength is now in its colour.
#[test]
fn the_confirm_dialog_s_scrim_stays_at_its_strength_after_a_theme_change() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local b = footerButton("Reset page")
		local function scrim()
			b:Click()
			local a = select(4, PolestarModal.Scrim:GetVertexColor())
			PolestarModal.Box.Cancel:Click()
			return a
		end
		local first = scrim()
		Polestar.Set("ui.scheme", "graphite")
		emit({ first = first, after = scrim() })"#);
	assert_eq!(out["first"], 0.55, "the dialog's scrim at 55 %");
	assert_eq!(out["after"], 0.55, "and still 55 % after a theme change, not solid");
}

// A Look page the way the look modules register theirs: a preview per tab, sections of new settings.
const LOOK_PAGE: &str = r#"
Polestar.RegisterDefaults("fake", { pinSize = 1, numbers = true, fade = true, glow = true, goalSize = 1, goalAlpha = 1, goalGlow = true, ring = true,
	style = "a", face = "x", tint = false, glass = false, filler = true,
	medal = true, medalSize = 1, medalColour = false, medalGlow = true, medalOutline = false, medalOffset = 0,
	badgeSize = 1, badgeOn = true, badgeRing = false, badgeStyle = "a", glassy = true, sheen = 1 })
local built, laid = 0, nil
uifake = { built = function() return built end, laid = function() return laid end, drawn = {} }
local function preview(height)
	return function(host)
		built = built + 1
		local f = CreateFrame("Frame", nil, host)
		f.caption = "Elwynn Forest, zoomed out"
		function f:Layout(width) laid = width return height end
		return f
	end
end
local function pct(v) return math.floor(v * 100 + 0.5) .. "%" end
local filler = {}
-- The first across both columns, so the sections after it start under it, far down the page.
for i = 1, 14 do filler[i] = { kind = "toggle", key = "fake.filler", label = "Filler " .. i, wide = i == 1 or nil } end
Polestar.RegisterOptions({ page = "Fake pins", key = "fakepins", icon = "icon-goto", order = 23, tab = "World map", section = "Before",
	preview = preview(200), controls = filler })
Polestar.RegisterOptions({ page = "Fake pins", tab = "World map", section = "Numbered step pins", controls = {
	{ kind = "slider", key = "fake.pinSize", label = "Numbered pin size", min = 0.5, max = 2, step = 0.05, format = pct, new = "0.3.7",
		help = "How big the step pins are." },
	{ kind = "toggle", key = "fake.numbers", label = "Numbers", new = "0.3.7" },
} })
Polestar.RegisterOptions({ page = "Fake pins", tab = "World map", section = "Goal pins", controls = {
	{ kind = "slider", key = "fake.goalSize", label = "Goal size", min = 0.5, max = 2, step = 0.05, format = pct },
	{ kind = "slider", key = "fake.goalAlpha", label = "Goal opacity", min = 0, max = 1, step = 0.05, format = pct },
	{ kind = "toggle", key = "fake.goalGlow", label = "Glow on the goal" },
	{ kind = "toggle", key = "fake.ring", label = "Ring" },
	{ kind = "toggle", key = "fake.fade", label = "Fade" },
} })
Polestar.RegisterOptions({ page = "Fake pins", tab = "Minimap", section = "Kinds", preview = preview(2000), controls = {
	{ kind = "cards", key = "fake.style", label = "Style", choices = {
		{ value = "a", label = "A", draw = function(art, v) table.insert(uifake.drawn, v) end },
		{ value = "b", label = "B", draw = function(art, v) table.insert(uifake.drawn, v) end },
		{ value = "c", label = "C", disabled = true, note = "Not loaded", draw = function(art, v) table.insert(uifake.drawn, v) end },
	} },
	{ kind = "font", key = "fake.face", label = "Face", choices = { { value = "x", label = "Xenia", font = "Fonts\\XENIA.TTF" }, { value = "y", label = "Yoda" } } },
	{ kind = "color", key = "fake.tint", label = "Tint" },
	{ kind = "color", key = "fake.glass", label = "Glass", alpha = true },
} })
-- Layout v2: the section's on/off in its header, a colour and a glow inline on its size, details behind a cog.
Polestar.RegisterOptions({ page = "Fake pins", tab = "Medallions", section = "Medallions",
	-- A part of the preview a click takes to its setting (here one on another tab).
	preview = function(host)
		local f = CreateFrame("Frame", nil, host)
		f.Disc = f:CreateTexture(nil, "ARTWORK")
		f.Disc:SetSize(40, 40)
		f.Disc:SetPoint("CENTER", f, "CENTER", 0, 0)
		uifake.spot = host:Hotspot(f.Disc, "fake.goalSize")
		function f:Layout(width) return 120 end
		return f
	end,
	toggle = { kind = "toggle", key = "fake.medal", label = "Medallions", help = "The disc under every mark." },
	controls = {
		{ kind = "slider", key = "fake.medalSize", label = "Size", min = 0.5, max = 2, step = 0.05, format = pct, help = "How big the discs are.", info = true,
			extras = { { kind = "color", key = "fake.medalColour", label = "Colour", help = "Their colour.", alpha = true },
				{ kind = "toggle", key = "fake.medalGlow", label = "Glow", help = "A soft light round them." } },
			more = { { kind = "toggle", key = "fake.medalOutline", label = "Outline", help = "A dark rim." },
				{ kind = "slider", key = "fake.medalOffset", label = "Offset", min = -10, max = 10, step = 1, format = "%d" } } },
	} })
-- One switch extra and a cog on a slider, beside a dropdown with none: the columns stand where the row above has
-- them. And a section shown only while the glow is on.
Polestar.RegisterOptions({ page = "Fake pins", tab = "Medallions", section = "Badge", controls = {
	{ kind = "slider", key = "fake.badgeSize", label = "Badge size", min = 0.5, max = 2, step = 0.05, format = pct,
		extras = { { kind = "toggle", key = "fake.badgeOn", label = "Badge" } },
		more = { { kind = "toggle", key = "fake.badgeRing", label = "Badge ring" } } },
	{ kind = "dropdown", key = "fake.badgeStyle", label = "Badge style", choices = { { value = "a", label = "Round" }, { value = "b", label = "Square" } } },
} })
Polestar.RegisterOptions({ page = "Fake pins", tab = "Medallions", section = "Glass", shown = function() return Polestar.Get("fake.medalGlow") end, controls = {
	{ kind = "toggle", key = "fake.glassy", label = "Glassy" },
	{ kind = "slider", key = "fake.sheen", label = "Sheen", min = 0, max = 1, step = 0.05, format = pct },
} })
"#;

// The window opens at 1300 x 946 screen pixels at the default Menu scale (the stub's screen is 1080 pixels in
// 1080 units), the grip's drag is kept in ui.optionsSize and the body takes the new width; a saved size never
// goes past the screen nor under 860 x 560; right-click on the grip goes back.
#[test]
fn the_window_opens_at_1300_by_946_its_grip_s_size_is_kept_and_clamped_to_the_screen_right_click_restores_it() {
	let out = run(r#"
		local before = PolestarOptions == nil
		UI.ShowOptions("guide")
		local f = PolestarOptions
		local default = { f:GetWidth(), f:GetHeight(), f.Grip ~= nil, f:IsResizable() }
		stub.RunScript(f.Grip, "OnMouseDown", "LeftButton")
		local sizing = f.sizing
		f:SetSize(1000, 700)
		stub.RunScript(f.Grip, "OnMouseUp", "LeftButton")
		local saved = Polestar.Get("ui.optionsSize")
		local body = { f.BodyWidth, f:GetWidth() - f.psRail - f.psSidebar - 2 - 2 * Polestar.Widgets.SHELL.pad, f.psViewH }
		local row = O.Controls("guide", "Window")["ui.shown"]
		local rowW = row:GetWidth()
		f:Hide()
		Polestar.Set("ui.optionsSize", { 5000, 5000 })
		UI.ShowOptions("guide")
		local huge = { f:GetWidth(), f:GetHeight() }
		Polestar.Set("ui.optionsSize", { 100, 100 })
		local tiny = { f:GetWidth(), f:GetHeight() }
		f.Grip:Click("RightButton")
		emit({ before = before, default = default, sizing = sizing, saved = saved, body = body, rowW = rowW, huge = huge, tiny = tiny,
			bounds = f.resizeBounds, reset = { f:GetWidth(), f:GetHeight(), Polestar.Get("ui.optionsSize") } })"#);
	assert_eq!(out["before"], true, "nothing is built before the window first opens");
	assert_eq!(out["default"], json!([1300, 946, true, true]));
	assert_eq!(out["sizing"], true, "the grip sizes the window");
	assert_eq!(out["saved"], json!([1000, 700]));
	assert_eq!(out["body"][0], out["body"][1], "the body takes the new width");
	assert!(n(&out["rowW"]) < 1000.0 - 300.0, "the rows laid out anew at the new width: {}", out["rowW"]);
	assert_eq!(out["huge"], json!([1920 - 32, 1080 - 32]), "never past the screen");
	assert_eq!(out["tiny"], json!([860, 560]), "never under its least");
	assert_eq!(out["bounds"], json!([860, 560, 1920 - 32, 1080 - 32]));
	assert_eq!(out["reset"], json!([1300, 946, false]), "right-click on the grip: the default, nothing stored");
}

// A section's Reset shows while one of its settings is off its default and puts them back; more than three ask
// first in the shared dialog. The section beside it keeps its settings.
#[test]
fn a_section_s_reset_shows_while_a_setting_is_off_its_default_and_restores_the_section_asking_past_three() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		local pins, goal = cardOf("Numbered step pins"), cardOf("Goal pins")
		local before = { pins.Reset:IsShown(), goal.Reset:IsShown() }
		Polestar.Set("fake.pinSize", 1.5)
		local shown = { pins.Reset:IsShown(), goal.Reset:IsShown() }
		Polestar.Set("fake.goalSize", 1.5); Polestar.Set("fake.goalAlpha", 0.5); Polestar.Set("fake.ring", false); Polestar.Set("fake.fade", false)
		pins.Reset:Click()
		local small = { asked = Polestar.Widgets.ModalShown(), pin = Polestar.Get("fake.pinSize"), goal = Polestar.Get("fake.goalSize"), shown = pins.Reset:IsShown() }
		goal.Reset:Click()
		local asked = { Polestar.Widgets.ModalShown(), Polestar.Get("fake.goalSize") }
		PolestarModal.Box.Action:Click()
		emit({ before = before, shown = shown, small = small, asked = asked,
			after = { Polestar.Get("fake.goalSize"), Polestar.Get("fake.goalAlpha"), Polestar.Get("fake.ring"), Polestar.Get("fake.fade") },
			stored = PolestarDB.settings.fake == nil or next(PolestarDB.settings.fake) == nil, goalShown = goal.Reset:IsShown() })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["before"], json!([false, false]), "nothing to reset");
	assert_eq!(out["shown"], json!([true, false]), "only the section with a changed setting");
	assert_eq!(out["small"], json!({ "asked": false, "pin": 1, "goal": 1.5, "shown": false }), "one setting: at once, that section only");
	assert_eq!(out["asked"], json!([true, 1.5]), "four settings: it asks first");
	assert_eq!(out["after"], json!([1, 1, true, true]));
	assert_eq!(out["stored"], true, "defaults are not stored");
	assert_eq!(out["goalShown"], false);
}

// Players type what they want, not the setting's name: "bigger pins" finds the numbered pin size (bigger: size;
// pins: its label), and a result's chevron opens its page and tab, scrolls the row into view and lights it a
// moment, then nothing runs.
#[test]
fn search_finds_bigger_pins_by_synonym_and_a_result_jumps_to_its_page_and_tab_scrolls_to_the_row_and_lights_it() {
	let out = run_opts(
		r#"
		UI.ShowOptions("guide")
		local box = PolestarOptions.Search
		box:SetText("bigger pins")
		stub.RunScript(box, "OnTextChanged", true)
		local first = O.results.groups[1] and O.results.groups[1].controls[1]
		local jump
		for _, v in ipairs({ PolestarOptions.Body:GetChildren() }) do
			if v:IsShown() and v.cache then
				for c, w in pairs(v.cache) do if c.key == "fake.pinSize" and w:IsShown() then jump = rawget(w, "psJump") end end
			end
		end
		local _, seeThrough = O.Search("see-through goal")
		jump:Click()
		local row = O.Controls("fakepins", "World map")["fake.pinSize"]
		local tab
		for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
		local flash = rawget(row, "psFlash")
		local lit = flash and flash:IsShown()
		stub.advance(3)
		emit({ first = first and first.key, count = O.results.count, page = O.page.key, tab = tab, query = box:GetText(),
			scroll = PolestarOptions.Scroll:GetVerticalScroll(), range = PolestarOptions.Scroll.psContent - PolestarOptions.Scroll.psView,
			top = row.psTop, lit = lit, after = flash and flash:IsShown(),
			seeThrough = seeThrough, anims = Polestar.Anim.Active() })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["first"], "fake.pinSize", "the best match first");
	assert_eq!(out["page"], "fakepins");
	assert_eq!(out["tab"], "World map");
	assert_eq!(out["query"], "", "the search is left");
	assert!(n(&out["top"]) > 400.0, "the row is far down the page: {}", out["top"]);
	assert!(n(&out["range"]) > 0.0);
	assert_eq!(n(&out["scroll"]), (n(&out["top"]) - 40.0).min(n(&out["range"])), "scrolled to 40px over the row, as far as it goes");
	assert_eq!(out["lit"], true, "the row lights");
	assert_eq!(out["after"], false, "and goes out");
	assert_eq!(out["anims"], 0, "nothing runs once it is out");
	assert!(n(&out["seeThrough"]) >= 1.0, "see-through finds an opacity");
}

// A setting new in this release puts a New pill on its section's header, and its page's sidebar row counts the new
// ones until the page is opened; no mark on the row itself (the label's gutter is the changed dot's alone). The
// pills keep that session and go in the next (the seen state, PolestarDB.optionsSeen, is the account's, not a
// setting); a later release's settings count again.
#[test]
fn new_settings_put_a_pill_on_their_section_and_a_count_on_their_page_until_opened_gone_the_next_session_back_for_a_newer_release() {
	let script = r#"
		UI.ShowOptions("guide")
		local function navRow(label)
			for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.Label:GetText() == label then return b end end
		end
		local function count() local b = navRow("Fake pins") return b.New:IsShown() and b.New.Text:GetText() or false end
		local before = count()
		O.Select("fakepins")
		local c = O.Controls("fakepins", "World map")
		local function pill(name) local card = cardOf(name) return card.New:IsShown() and card.New.Text:GetText() or false end
		local rowMark = rawget(c["fake.pinSize"], "NewDot") ~= nil or rawget(c["fake.pinSize"], "Badge") ~= nil
		emit({ before = before, opened = count(), rowMark = rowMark, pill = pill("Numbered step pins"), oldPill = pill("Goal pins"),
			seen = PolestarDB.optionsSeen and PolestarDB.optionsSeen.fakepins or false, settings = PolestarDB.settings.optionsSeen == nil })"#;
	let first = run_opts(script, "", "", LOOK_PAGE);
	assert_eq!(first, json!({ "before": "2", "opened": false, "rowMark": false, "pill": "New", "oldPill": false, "seen": "0.3.7", "settings": true }));
	let next = run_opts(script, "", "", &format!("{LOOK_PAGE}\nPolestarDB.optionsSeen = {{ fakepins = \"0.3.7\" }}"));
	assert_eq!(next["before"], false);
	assert_eq!(next["pill"], false, "seen in an earlier session: no pill");
	let later = run_opts(script, "", "", &format!("{LOOK_PAGE}\nPolestarDB.optionsSeen = {{ fakepins = \"0.3.6\" }}"));
	assert_eq!(later["before"], "2", "seen up to 0.3.6: the 0.3.7 settings are new");
	assert_eq!(later["pill"], "New");
}

// A tab's preview is built when the tab first shows, laid out across the main column and pinned between the tab
// band and the rows, which scroll under it; the slot's chrome says what it shows. Another tab's taller preview
// is capped; a tab without one gives the room back; nothing is built twice.
#[test]
fn a_tab_s_preview_is_built_on_first_show_pinned_over_the_scrolling_rows_capped_and_given_back() {
	let out = run_opts(
		r#"
		local before = uifake.built()
		UI.ShowOptions("fakepins")
		local f = PolestarOptions
		local slot = f.PreviewSlot
		local _, _, _, _, scrollY = f.Scroll:GetPoint(1)
		local host = O.view.PreviewHost
		local first = { built = uifake.built(), laid = uifake.laid(), main = f.psMainW, slot = slot:IsShown(), h = f.psPreviewH,
			scrollY = scrollY, viewH = f.psViewH, room = f:GetHeight() - 112 - 40 - 56, caption = host.Caption:GetText(), label = host.Label:GetText() }
		O.Select("fakepins", "Minimap")
		local capped = { h = f.psPreviewH, room = f:GetHeight() - 112 - 40 - 56 }
		O.Select("guide")
		local gone = { h = f.psPreviewH, slot = slot:IsShown() }
		O.Select("fakepins", "World map")
		emit({ before = before, first = first, capped = capped, gone = gone, built = uifake.built() })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["before"], 0, "nothing built before the window opens");
	let first = &out["first"];
	assert_eq!(first["built"], 1);
	assert_eq!(first["laid"], first["main"], "laid out across the main column");
	assert_eq!(first["slot"], true);
	assert_eq!(first["h"], 200);
	assert_eq!(first["scrollY"], -204, "the rows start under it");
	assert_eq!(n(&first["viewH"]), n(&first["room"]) - 200.0, "and scroll in the room left");
	assert_eq!(first["caption"], "Elwynn Forest, zoomed out");
	assert_eq!(first["label"], "Preview");
	assert_eq!(n(&out["capped"]["h"]), (n(&out["capped"]["room"]) * 0.45).floor(), "a taller preview is capped");
	assert_eq!(out["gone"], json!({ "h": 0, "slot": false }), "a page without one gives the room back");
	assert_eq!(out["built"], 2, "each tab's preview built once");
}

// The new control kinds: picture cards (each drawn once; a click picks, a card that cannot be picked does
// nothing, right-click restores), a font list drawn in its faces, colour rows that take a typed hex and opacity
// and keep the colours picked last, and a slider's typed value (in its own terms, clamped).
#[test]
fn cards_font_faces_typed_colours_and_typed_slider_values() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Minimap")
		local c = O.Controls("fakepins", "Minimap")
		local cards = c["fake.style"]
		local by = cards.psCardBy
		by.b:Click("LeftButton")
		local picked = { Polestar.Get("fake.style"), by.b.Check:IsShown(), by.a.Check:IsShown() }
		by.c:Click("LeftButton")
		local off = Polestar.Get("fake.style")
		O.Select("fakepins", "World map"); O.Select("fakepins", "Minimap")
		by.b:Click("RightButton")
		local drawn = table.concat(uifake.drawn, ",")
		local face = c["fake.face"]
		local boxFace = { face.Button.Face:IsShown(), (face.Button.Face:GetFont()) }
		face.Button:Click()
		local rows = {}
		for _, r in ipairs(PolestarMenu.rows) do
			if r:IsShown() then
				local f = rawget(r, "Face")
				rows[#rows + 1] = { r.Text:GetText(), f ~= nil and f:IsShown() and (f:GetFont()) or false }
			end
		end
		Polestar.Widgets.HideMenu()
		local tint = c["fake.tint"]
		tint.Hex:SetText(string.char(35) .. "336699")
		stub.RunScript(tint.Hex, "OnEnterPressed")
		local glass = c["fake.glass"]
		glass.Alpha:SetText("40%")
		stub.RunScript(glass.Alpha, "OnEnterPressed")
		local size = O.Controls("fakepins", "World map")["fake.pinSize"]
		size.ValueHit:Click()
		local entry = size.Entry:IsShown()
		size.Entry:SetText("150")
		stub.RunScript(size.Entry, "OnEnterPressed")
		local typed = Polestar.Get("fake.pinSize")
		size.ValueHit:Click(); size.Entry:SetText("1000%"); stub.RunScript(size.Entry, "OnEnterPressed")
		emit({ picked = picked, off = off, reset = Polestar.Get("fake.style"), drawn = drawn, boxFace = boxFace, rows = rows,
			tint = Polestar.Get("fake.tint"), hex = tint.Hex:GetText(), recent = PolestarDB.recentColors[1],
			glass = Polestar.Get("fake.glass"), alpha = glass.Alpha:GetText(), entry = entry, typed = typed, clamped = Polestar.Get("fake.pinSize") })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["picked"], json!(["b", true, false]));
	assert_eq!(out["off"], "b", "a card that cannot be picked does nothing");
	assert_eq!(out["reset"], "a", "right-click: the default");
	assert_eq!(out["drawn"], "a,b,c", "each card's picture drawn once");
	assert_eq!(out["boxFace"], json!([true, "Fonts\\XENIA.TTF"]), "the box shows the choice in its face");
	assert_eq!(out["rows"], json!([["Xenia", "Fonts\\XENIA.TTF"], ["Yoda", false]]), "each name in its face, or the face in use");
	assert_eq!(round(&out["tint"]), json!([0.2, 0.4, 0.6]));
	assert_eq!(out["hex"], "336699");
	assert_eq!(round(&out["recent"]), json!([0.2, 0.4, 0.6]), "a typed colour goes to the recent ones");
	assert_eq!(round(&out["glass"]), json!([1, 1, 1, 0.4]), "an opacity typed in percent");
	assert_eq!(out["alpha"], "40%");
	assert_eq!(out["entry"], true);
	assert_eq!(out["typed"], 1.5, "150 on a slider showing percent is 1.5");
	assert_eq!(out["clamped"], 2, "clamped to the slider's range");
}

// A colour chip reads as a colour on the dark rows whatever the colour: a light ring inside its hairline, the
// colour within it, so a near-black one is a chip of that colour, never an empty box beside its slider (an
// unticked tick box). The row's chip and the inline one alike.
#[test]
fn a_colour_chip_rings_its_colour_in_light_so_a_near_black_one_never_reads_as_an_empty_box() {
	let out = run(r#"
		Polestar.Set("ui.accent", { 0.03, 0.03, 0.04 })
		local W = Polestar.Widgets
		local row = W.Swatch(UIParent, "Accent", "ui.accent")
		local inline = W.InlineSwatch(UIParent, "ui.accent", "Accent")
		if row.Refresh then row:Refresh() end
		inline:Refresh()
		local function chip(frame, fill)
			local ring = rawget(frame, "psRing")
			local rr, rg, rb, ra = ring:GetVertexColor()
			local fr, fg, fb = fill:GetVertexColor()
			local inset = { select(4, ring:GetPoint(1)), select(4, fill:GetPoint(1)) }
			return { ring = ring:IsShown(), light = math.min(rr, rg, rb) > 0.6 and ra >= 0.7, dark = math.max(fr, fg, fb) < 0.1,
				inside = inset[1] < inset[2] }
		end
		emit({ row = chip(row.ChipFrame, row.Chip), inline = chip(inline, inline.Fill) })"#);
	let ringed = json!({ "ring": true, "light": true, "dark": true, "inside": true });
	assert_eq!(out["row"], ringed, "the row's chip: a light ring round the dark colour");
	assert_eq!(out["inline"], ringed, "the inline chip too");
}

// Layout v2: a section's on/off sits in its card's header; while it is off every row of the section stops, its
// inline extras and cog too, and their tooltips say why; the marks (track, box) dim to 40% while the label and value
// turn textMuted at full alpha, so they stay legible (4.5:1); right-click on the switch restores it.
#[test]
fn a_section_s_toggle_in_its_header_dims_and_stops_its_rows_extras_and_cog_while_off() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local c = O.Controls("fakepins", "Medallions")
		local sw, row, colour, glow = c["fake.medal"], c["fake.medalSize"], c["fake.medalColour"], c["fake.medalGlow"]
		local card = cardOf("Medallions")
		local function muted(fs) local r = fs:GetTextColor() return math.abs(r - (Polestar.Theme.Color("textMuted"))) < 0.01 end
		local function state() return { row = row:IsEnabled(), alpha = row:GetAlpha(), marks = row.Slider:GetAlpha(), label = muted(row.Label),
			value = muted(row.Value), colour = colour:IsEnabled(), glow = glow:IsEnabled(), cog = row.Cog:IsEnabled() } end
		local inHeader = sw:GetParent() == card.Header
		local on = state()
		sw:Click()
		local off = state()
		local stored = Polestar.Get("fake.medal")
		local why = O.TipOf(select(2, (function() for _, x in ipairs(O.AllControls()) do if x.key == "fake.medalSize" then return nil, x end end end)()))(row)
		local whyText = {}
		for _, l in ipairs(why) do whyText[#whyText + 1] = type(l) == "table" and l[1] or l end
		stub.RunScript(row.Slider, "OnValueChanged", 1.5, true)
		local blocked = Polestar.Get("fake.medalSize")
		sw:Click("RightButton")
		emit({ inHeader = inHeader, on = on, off = off, stored = stored, why = whyText, blocked = blocked, back = state(), restored = Polestar.Get("fake.medal") })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["inHeader"], true, "the switch is in the section's header, not a row");
	assert_eq!(out["on"], json!({ "row": true, "alpha": 1, "marks": 1, "label": false, "value": false, "colour": true, "glow": true, "cog": true }));
	assert_eq!(out["stored"], false);
	assert_eq!(out["off"], json!({ "row": false, "alpha": 1, "marks": 0.4, "label": true, "value": true, "colour": false, "glow": false, "cog": false }));
	assert_eq!(out["why"], json!(["How big the discs are.", "Turn on Medallions first."]), "the tooltip says why");
	assert_eq!(out["blocked"], 1, "a stopped row writes nothing");
	assert_eq!(out["back"], out["on"]);
	assert_eq!(out["restored"], true, "right-click on the switch: its default");
}

// Inline extras: each is its own setting, with its own click and right-click reset; the row's own value and its
// changed-dot stay apart.
#[test]
fn inline_extras_keep_their_own_setting_click_and_right_click_reset_beside_the_row_s_control() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local c = O.Controls("fakepins", "Medallions")
		local row, colour, glow = c["fake.medalSize"], c["fake.medalColour"], c["fake.medalGlow"]
		local parent = colour:GetParent() == row and glow:GetParent() == row
		glow:Click()
		local flipped = Polestar.Get("fake.medalGlow")
		colour:Click("LeftButton")
		ColorPickerFrame.GetColorRGB = function() return 0.2, 0.4, 0.6 end
		ColorPickerFrame.GetColorAlpha = function() return 0.5 end
		ColorPickerFrame.info.swatchFunc()
		local picked = Polestar.Get("fake.medalColour")
		local rowDot = row.ModDot:IsShown()
		colour:Click("RightButton")
		glow:Click("RightButton")
		local _, _, _, cx = colour:GetPoint(1)
		local _, _, _, gx = glow:GetPoint(1)
		emit({ parent = parent, flipped = flipped, picked = picked, rowDot = rowDot, colour = Polestar.Get("fake.medalColour"),
			glow = Polestar.Get("fake.medalGlow"), size = Polestar.Get("fake.medalSize"), order = gx < cx })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["parent"], true, "the extras sit on the row");
	assert_eq!(out["flipped"], false);
	assert_eq!(round(&out["picked"]), json!([0.2, 0.4, 0.6, 0.5]), "a colour extra with alpha keeps the picker's opacity");
	assert_eq!(out["rowDot"], false, "the row's own setting is still its default");
	assert_eq!(out["colour"], false, "right-click: its default");
	assert_eq!(out["glow"], true);
	assert_eq!(out["size"], 1);
	assert_eq!(out["order"], true, "right to left before the control: the colour, then the glow");
}

// A row's `more` sits behind a cog: the cog opens a compact popup by it (the row's label, 300 wide, rows of 30px)
// with those settings, a click outside closes it, and the cog carries a dot while one of them is off its default.
#[test]
fn a_cog_opens_its_row_s_detail_settings_in_a_popup_and_shows_a_dot_while_one_is_changed() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local row = O.Controls("fakepins", "Medallions")["fake.medalSize"]
		local before = { cog = row.Cog ~= nil, dot = row.Cog.Dot:IsShown(), popup = PolestarOptionsMore == nil }
		row.Cog:Click()
		local p = PolestarOptionsMore
		local m = O.MoreControls()
		local opened = { shown = p:IsShown(), title = p.Title:GetText(), w = p:GetWidth(), rowH = m["fake.medalOutline"]:GetHeight(),
			keys = (function() local k = {} for key in pairs(m) do k[#k + 1] = key end table.sort(k) return k end)() }
		m["fake.medalOutline"]:Click()
		local outline = Polestar.Get("fake.medalOutline")
		p.Catcher:Click()
		local closed = not p:IsShown()
		emit({ before = before, opened = opened, outline = outline, closed = closed, dot = row.Cog.Dot:IsShown(),
			search = (function() local g = O.Search("outline") for _, gg in ipairs(g) do for _, x in ipairs(gg.controls) do if x.key == "fake.medalSize" then return true end end end return false end)() })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["before"], json!({ "cog": true, "dot": false, "popup": true }), "nothing built before the cog opens");
	assert_eq!(out["opened"], json!({ "shown": true, "title": "Size", "w": 300, "rowH": 30, "keys": ["fake.medalOffset", "fake.medalOutline"] }));
	assert_eq!(out["outline"], true);
	assert_eq!(out["closed"], true, "a click outside closes it");
	assert_eq!(out["dot"], true, "a dot on the cog while one of its settings is changed");
	assert_eq!(out["search"], true, "a cog's setting finds its row");
}

// No description under a row: its help is the tooltip, 0.25s after the cursor arrives (not if it left), with
// "Right-click to reset." while the setting is off its default; a search result adds where the setting lives.
#[test]
fn a_row_s_help_is_its_tooltip_after_a_moment_with_the_reset_hint_and_a_search_result_s_page_path() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local row = O.Controls("fakepins", "Medallions")["fake.medalSize"]
		local function texts(t)
			local out = {}
			for _, l in ipairs(t and t.lines or {}) do out[#out + 1] = type(l) == "table" and l[1] or l end
			return out
		end
		local noHelp = rawget(row, "Help") == nil or not row.Help:IsShown()
		row.psTipShown = nil
		stub.RunScript(row, "OnEnter")
		local early = row.psTipShown
		stub.advance(0.3)
		local plain = { title = row.psTipShown and row.psTipShown.title, lines = texts(row.psTipShown) }
		stub.RunScript(row, "OnLeave")
		row.psTipShown = nil
		stub.RunScript(row, "OnEnter")
		stub.RunScript(row, "OnLeave")
		stub.advance(0.3)
		local left = row.psTipShown
		Polestar.Set("fake.medalSize", 1.5)
		stub.RunScript(row, "OnEnter")
		stub.advance(0.3)
		local changed = texts(row.psTipShown)
		stub.RunScript(row, "OnLeave")
		O.SetQuery("disc size")
		local hit
		for _, v in ipairs({ PolestarOptions.Body:GetChildren() }) do
			if v:IsShown() and v.cache then for c, w in pairs(v.cache) do if c.key == "fake.medalSize" and w:IsShown() then hit = w end end end
		end
		stub.RunScript(hit, "OnEnter")
		stub.advance(0.3)
		emit({ noHelp = noHelp, early = early ~= nil, plain = plain, left = left ~= nil, changed = changed, found = texts(hit.psTipShown),
			h = row:GetHeight(), info = rawget(row, "Info") ~= nil and row.Info:IsShown() })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["noHelp"], true, "no description on the page");
	assert_eq!(out["h"], 36);
	assert_eq!(out["info"], true, "info = true: an (i) after the label");
	assert_eq!(out["early"], false, "not at once");
	assert_eq!(out["plain"], json!({ "title": "Size", "lines": ["How big the discs are."] }));
	assert_eq!(out["left"], false, "the cursor left before the moment: no tooltip");
	assert_eq!(out["changed"], json!(["How big the discs are.", "Right-click to reset."]));
	assert_eq!(out["found"], json!(["How big the discs are.", "Right-click to reset.", "Fake pins  \u{b7}  Medallions  \u{b7}  Medallions"]));
}

// Fixed columns: left of the control zone (as wide as the widest control) a half has, right to left, a swatch, a
// switch and the cog at one x each, an empty one keeping its place, so they line up down the page.
#[test]
fn a_half_s_swatch_switch_and_cog_stand_in_fixed_columns_down_the_page() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local c = O.Controls("fakepins", "Medallions")
		local function x(w) local _, _, _, ox = w:GetPoint(1) return ox end
		local size, badge = c["fake.medalSize"], c["fake.badgeSize"]
		emit({ switch = { x(c["fake.medalGlow"]), x(c["fake.badgeOn"]) }, cog = { x(size.Cog), x(badge.Cog) }, swatch = x(c["fake.medalColour"]),
			halves = { size:GetWidth(), badge:GetWidth() } })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["halves"][0], out["halves"][1]);
	assert_eq!(out["switch"][0], out["switch"][1], "the switches in one column, a swatch beside one or not");
	assert_eq!(out["cog"][0], out["cog"][1], "the cogs in one column");
	assert!(n(&out["swatch"]) > n(&out["switch"][0]) && n(&out["switch"][0]) > n(&out["cog"][0]), "right to left: swatch, switch, cog: {out}");
}

// Search results stand in a card per page, tab and section, the best first; a result its section's on/off stops
// comes after an equally good one that works, and its card carries that switch in the header.
#[test]
fn search_results_are_grouped_by_page_tab_and_section_stopped_ones_last_with_their_section_s_switch() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		Polestar.Set("fake.medal", false)
		O.SetQuery("size")
		local titles, keys, order = {}, {}, true
		for i, g in ipairs(O.results.groups) do
			local nx = O.results.groups[i + 1]
			if nx and (nx.best > g.best or (nx.best == g.best and g.off and not nx.off)) then order = false end
			titles[i] = g.title
			keys[i] = {}
			for _, x in ipairs(g.controls) do table.insert(keys[i], x.key) end
		end
		local sv
		for _, v in ipairs({ PolestarOptions.Body:GetChildren() }) do if rawget(v, "psSearch") and v:IsShown() then sv = v end end
		local switch
		for _, card in ipairs(sv.cards) do
			if card:IsShown() and card.Title:GetText() == "Fake pins  \194\183  Medallions" then switch = card.psToggle and card.psToggle:IsShown() and card.psToggle.psControl.key end
		end
		local chevron = sv.cache[(function() for _, x in ipairs(O.AllControls()) do if x.key == "fake.pinSize" then return x end end end)()]
		local _, _, _, jx = chevron.psJump:GetPoint(1)
		local _, _, _, rx = chevron:GetPoint(1)
		emit({ titles = titles, keys = keys, order = order, switch = switch or false, inside = rx + jx > Polestar.Widgets.SHELL.pad })"#,
		"",
		"",
		LOOK_PAGE,
	);
	let titles: Vec<&str> = out["titles"].as_array().unwrap().iter().map(|t| t.as_str().unwrap()).collect();
	assert!(titles.contains(&"Fake pins  \u{b7}  World map  \u{b7}  Numbered step pins"), "{titles:?}");
	assert!(titles.contains(&"Fake pins  \u{b7}  World map  \u{b7}  Goal pins"), "{titles:?}");
	assert!(titles.contains(&"Fake pins  \u{b7}  Medallions  \u{b7}  Badge"), "{titles:?}");
	let medal = titles.iter().position(|t| *t == "Fake pins  \u{b7}  Medallions").expect("a section named as its tab says it once");
	assert_eq!(out["order"], true, "best first, a stopped one after an equal one that works: {titles:?}");
	assert_eq!(out["keys"][medal], json!(["fake.medalSize"]));
	assert_eq!(out["switch"], "fake.medal", "the stopped result's card carries its section's switch");
	assert_eq!(out["inside"], true, "the chevron sits inside the card");
}

// A section's shown() hides its whole card (and its settings from search) and is worked out again as settings change.
#[test]
fn a_section_whose_shown_says_no_is_hidden_and_comes_back_when_the_setting_it_follows_changes() {
	let out = run_opts(
		r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local function has(name) for _, t in ipairs(cardTitles()) do if t == name then return true end end return false end
		local before = has("Glass")
		Polestar.Set("fake.medalGlow", false)
		local hidden = { has("Glass"), select(2, O.Search("sheen")), O.Controls("fakepins", "Medallions")["fake.sheen"]:IsShown() }
		Polestar.Set("fake.medalGlow", true)
		emit({ before = before, hidden = hidden, back = has("Glass"), found = select(2, O.Search("sheen")) })"#,
		"",
		"",
		LOOK_PAGE,
	);
	assert_eq!(out["before"], true);
	assert_eq!(out["hidden"], json!([false, 0, false]), "hidden: no card, no search result");
	assert_eq!(out["back"], true, "back as soon as the setting turns");
	assert_eq!(out["found"], 1);
}

// A preview's hotspot: under the cursor an accent outline and the setting's name; a click opens the setting's row (on
// its own tab) and lights it. A first preview with hotspots says so once, until the first click, for good.
#[test]
fn a_preview_hotspot_opens_its_setting_s_row_and_the_one_time_hint_goes_on_the_first_click() {
	let script = r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local host = O.view.PreviewHost
		local hint = host.Hint:IsShown() and host.Hint:GetText() or false
		local spot = uifake.spot
		stub.RunScript(spot, "OnEnter")
		local tip = GameTooltip:IsShown() and GameTooltip:GetOwner() == spot
		stub.RunScript(spot, "OnLeave")
		spot:Click()
		local tab
		for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
		local row = O.Controls("fakepins", "World map")["fake.goalSize"]
		local lit = rawget(row, "psFlash") ~= nil and row.psFlash:IsShown()
		O.Select("fakepins", "Medallions")
		emit({ hint = hint, tip = tip, tab = tab, lit = lit, after = host.Hint:IsShown(), stored = PolestarDB.optionsPreviewHint == true })"#;
	let out = run_opts(script, "", "", LOOK_PAGE);
	assert_eq!(out["hint"], "Click a part of the preview to find its settings.");
	assert_eq!(out["tip"], true, "the setting's name under the cursor");
	assert_eq!(out["tab"], "World map", "a click opens the setting's tab");
	assert_eq!(out["lit"], true, "and lights its row");
	assert_eq!(out["after"], false, "the hint goes on the first click");
	assert_eq!(out["stored"], true);
	let next = run_opts(script, "", "", &format!("{LOOK_PAGE}\nPolestarDB.optionsPreviewHint = true"));
	assert_eq!(next["hint"], false, "for good");
}

// The first open says once, over the first card, how the rows work; its close button dismisses it for good and the
// cards move up.
#[test]
fn the_first_open_says_hover_and_right_click_once_until_dismissed_for_good() {
	let script = r#"
		UI.ShowOptions("fakepins")
		O.Select("fakepins", "Medallions")
		local bar = rawget(O.view, "Intro")
		local first = { shown = bar ~= nil and bar:IsShown(), text = bar and bar.Text:GetText() or false, top = cardOf("Medallions").psTop }
		if bar and bar:IsShown() then bar.Close:Click() end
		emit({ first = first, after = { shown = bar ~= nil and bar:IsShown(), top = cardOf("Medallions").psTop }, stored = PolestarDB.optionsIntro == true })"#;
	let out = run_opts(script, "", "", LOOK_PAGE);
	assert_eq!(out["first"]["shown"], true);
	assert_eq!(out["first"]["text"], "Hover a setting for what it does. Right-click resets it.");
	assert_eq!(out["after"]["shown"], false);
	assert!(n(&out["after"]["top"]) < n(&out["first"]["top"]), "the cards move up: {out}");
	assert_eq!(out["stored"], true);
	let next = run_opts(script, "", "", &format!("{LOOK_PAGE}\nPolestarDB.optionsIntro = true"));
	assert_eq!(next["first"]["shown"], false, "for good");
}

// Every Look page and tab, at defaults, keeps the layout rules (FIXES-V2 R1-R4, R7): no shown section with fewer
// than two rows, no half with two switches or two swatches inline, no tab whose every row is off, no slider value
// (at its default, least and most) wider than its box.
#[test]
fn every_look_page_keeps_the_layout_rules_at_defaults() {
	let out = run_mods(
		"",
		r#"
		UI.ShowOptions("guide")
		local bad, seen = {}, 0
		for _, p in ipairs(O.Pages()) do
			if p.group == "look" then
				for _, tab in ipairs(p.tabs) do
					O.Select(p.key, tab)
					local v = O.view
					local where = p.name .. " > " .. tab
					seen = seen + 1
					local rows, on = 0, 0
					local per = {}
					for c, w in pairs(v.cache) do
						if w:IsShown() and not c.psOwner then
							rows = rows + 1
							if w:IsEnabled() then on = on + 1 end
							-- Rows as drawn: two halves on one line are one row.
							if c.psSection then
								per[c.psSection] = per[c.psSection] or {}
								per[c.psSection][w.psTop or 0] = true
							end
							local sw, sc = 0, 0
							for _, e in ipairs(rawget(w, "psExtras") or {}) do
								if rawget(e, "Knob") then sw = sw + 1 elseif rawget(e, "Fill") then sc = sc + 1 end
							end
							if sw > 1 then bad[#bad + 1] = where .. ": " .. tostring(c.key) .. " has " .. sw .. " switches inline" end
							if sc > 1 then bad[#bad + 1] = where .. ": " .. tostring(c.key) .. " has " .. sc .. " swatches inline" end
							if rawget(w, "ValueHit") and w.psMin then
								for _, val in ipairs({ w.psMin, w.psMax, c.key and Polestar.Get(c.key) or w.psMin }) do
									local text = Polestar.Widgets.SliderText(w, val)
									w.Value:SetText(text)
									if w.Value:GetUnboundedStringWidth() > w.Value:GetWidth() + 0.5 then
										bad[#bad + 1] = where .. ": " .. tostring(c.key) .. " value \"" .. text .. "\" is wider than its box"
									end
								end
								w:Refresh()
							end
						end
					end
					for _, card in ipairs(v.cards) do
						local s = card:IsShown() and card.psSection
						local lines = 0
						for _ in pairs(s and per[s] or {}) do lines = lines + 1 end
						if s and lines < 2 then bad[#bad + 1] = where .. ": section \"" .. tostring(s.name) .. "\" has " .. lines .. " row" end
					end
					if rows > 0 and on == 0 then bad[#bad + 1] = where .. ": every row is off at defaults" end
				end
			end
		end
		emit({ bad = table.concat(bad, "\n"), seen = seen })"#,
	);
	assert!(n(&out["seen"]) >= 8.0, "the Look pages' tabs walked: {}", out["seen"]);
	assert_eq!(out["bad"], "", "layout rules broken:\n{}", out["bad"].as_str().unwrap_or_default());
}

// /ps is short for /polestar: "/ps options" opens the settings window as "/polestar options" does.
#[test]
fn slash_ps_options_opens_the_settings_window() {
	let out = run(r#"
		local before = PolestarOptions ~= nil and PolestarOptions:IsShown()
		SlashCmdList.POLESTAR("options")
		emit({ before = before, alias = SLASH_POLESTAR3, shown = PolestarOptions ~= nil and PolestarOptions:IsShown() })"#);
	assert_eq!(out, json!({ "before": false, "alias": "/ps", "shown": true }));
}

// Move frames works with the settings window open: the window stays (the frames' boxes over it, the window dragged
// aside if one sits under it), and Lock leaves it as it was.
#[test]
fn move_frames_leaves_the_settings_window_open() {
	let out = run(r#"
		UI.ShowOptions("guide")
		footerButton("Move frames"):Click()
		local during = { unlocked = Polestar.Movers.IsUnlocked(), settings = PolestarOptions:IsShown() }
		Polestar.Movers.Lock()
		emit({ during = during, after = { unlocked = Polestar.Movers.IsUnlocked(), settings = PolestarOptions:IsShown() } })"#);
	assert_eq!(out["during"], json!({ "unlocked": true, "settings": true }));
	assert_eq!(out["after"], json!({ "unlocked": false, "settings": true }));
}
