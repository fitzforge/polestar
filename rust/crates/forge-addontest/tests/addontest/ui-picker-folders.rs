//! The guide menu's Browse folders and same-titled guides (#1358, addon/Polestar/UI/Picker.lua), against the fake
//! Engine and sample guides of tests/lua/stub_ui.lua (a level 4 Human Warrior). A folder's header folds its guides
//! away and back (a click, A on a gamepad), its count staying; the folded folders are kept account-wide; opening the
//! menu unfolds the open guide's folder; a search lists every match. Guides of one title and level range say whose
//! they are: "Dun Morogh (Dwarf)", "Zephras Isle (Horde)".

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local UI, P = Polestar.UI, Polestar.UI.Picker
local function shownIn(kind)
	local out = {}
	for _, f in ipairs(stub.frames) do
		if kind(f) and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	return out
end
local function isFolder(f) return rawget(f, "Count") ~= nil and rawget(f, "Rule") ~= nil and rawget(f, "Range") == nil end
local function isRow(f) return f.psGuide ~= nil and rawget(f, "Range") ~= nil end
-- The middle pane top down: "[Folder count v]" ("v" open, ">" folded, nothing where it does not fold), "Title (range)".
local function pane()
	local out = {}
	local items = shownIn(function(f) return isFolder(f) or isRow(f) end)
	for _, f in ipairs(items) do
		if isFolder(f) then
			local mark = f.Chevron:IsShown() and (f.psCollapsed and " >" or " v") or ""
			out[#out + 1] = "[" .. f.Text:GetText() .. " " .. f.Count:GetText() .. mark .. "]"
		else
			out[#out + 1] = f.Title:GetText() .. " " .. f.Range:GetText()
		end
	end
	return out
end
local function header(text)
	for _, f in ipairs(shownIn(isFolder)) do if f.Text:GetText() == text then return f end end
end
local function chevron(f) return (f.Chevron:GetTexture() or ""):match("chevron%-%a+") end
local function saved() return Polestar.DB().settings.ui and Polestar.DB().settings.ui.pickerCollapsed end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

#[test]
fn a_browse_folder_s_header_folds_its_guides_away_and_back_its_count_and_chevron_say_so_a_search_lists_every_match() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("Leveling")
		emit({ pane = pane(), chevron = chevron(header("Alliance 1\226\128\14730")), tip = header("Alliance 1\226\128\14730").psTip,
			pad = header("Alliance 1\226\128\14730").psPadLabel })
		header("Alliance 1\226\128\14730"):Click()
		local f = header("Alliance 1\226\128\14730")
		emit({ pane = pane(), chevron = chevron(f), tip = f.psTip, pad = f.psPadLabel, collapsed = P.IsCollapsed("Leveling/Alliance/1") })
		-- Arrow keys walk the guides shown: the folded ones are passed over.
		P.Select(nil)
		P.Step(1)
		local first = P.Selected()
		-- A search lists every match, folded folder or not, and its headers are labels only.
		P.SetQuery("westfall")
		local h = header("Alliance 1\226\128\14730")
		emit({ first = first, search = pane(), click = h:IsEnabled(), skip = h.psPadSkip == true })
		P.SetQuery("")
		P.SetCategory("Leveling")
		header("Alliance 1\226\128\14730"):Click()
		emit({ pane = pane(), collapsed = P.IsCollapsed("Leveling/Alliance/1"), saved = saved() == nil })
		-- Home's folders never fold.
		P.SetView("home")
		local home = shownIn(isFolder)
		emit({ foldable = #home > 0 and home[1]:IsEnabled(), chevron = #home > 0 and home[1].Chevron:IsShown() })"#);
	let open = json!([
		"[Alliance 1\u{2013}30 3 v]",
		"Elwynn Forest (1\u{2013}13)",
		"Westfall (12\u{2013}17)",
		"Darkshore (16\u{2013}21)",
		"[Other starting zones 3 v]",
		"Dun Morogh (1\u{2013}13)",
		"Teldrassil (1\u{2013}11)",
		"Zephras Isle (1\u{2013}15)"
	]);
	assert_eq!(out[0], json!({ "pane": open, "chevron": "chevron-down", "tip": "Collapse", "pad": "Collapse" }));
	assert_eq!(
		out[1],
		json!({
			"pane": ["[Alliance 1\u{2013}30 3 >]", "[Other starting zones 3 v]", "Dun Morogh (1\u{2013}13)", "Teldrassil (1\u{2013}11)", "Zephras Isle (1\u{2013}15)"],
			"chevron": "chevron-right", "tip": "Expand", "pad": "Expand", "collapsed": true,
		})
	);
	assert_eq!(out[2], json!({ "first": "forever/alliance/dwarf-gnome/01-dun-morogh", "search": ["[Alliance 1\u{2013}30 1]", "Westfall (12\u{2013}17)"], "click": false, "skip": true }));
	assert_eq!(out[3], json!({ "pane": open, "collapsed": false, "saved": true }), "unfolded again: nothing left saved");
	assert_eq!(out[4], json!({ "foldable": false, "chevron": false }));
}

#[test]
fn folded_folders_are_kept_account_wide_by_an_id_that_holds_in_every_language_and_for_either_faction() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("Leveling")
		header("Other starting zones"):Click()
		PolestarPicker:Hide()
		UI.ShowPicker()
		local r = { saved = saved(), pane = pane() }
		-- A Horde character on the same account sees the Alliance folders as left.
		uistub.player.race, uistub.player.faction = "Orc", "Horde"
		Polestar.Set("ui.pickerFaction", "Alliance")
		header("Alliance 1\226\128\14730"):Click()
		r.horde = pane()
		r.ids = {}
		for id in pairs(saved()) do r.ids[#r.ids + 1] = id end
		table.sort(r.ids)
		emit(r)"#);
	let out = &out[0];
	assert_eq!(out["saved"], json!({ "Leveling/other-starts": true }), "in the account's settings, not the character's");
	assert_eq!(
		out["pane"],
		json!(["[Alliance 1\u{2013}30 3 v]", "Elwynn Forest (1\u{2013}13)", "Westfall (12\u{2013}17)", "Darkshore (16\u{2013}21)", "[Other starting zones 3 >]"])
	);
	assert_eq!(out["ids"], json!(["Leveling/Alliance/1", "Leveling/other-starts"]));
	assert_eq!(out["horde"][0], "[Alliance 1\u{2013}30 6 >]", "the other faction's list: every Alliance start in the band, folded");
}

#[test]
fn opening_the_menu_unfolds_the_folder_of_the_open_guide_and_leaves_the_others_as_they_were() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("Leveling")
		header("Alliance 1\226\128\14730"):Click()
		header("Other starting zones"):Click()
		PolestarPicker:Hide()
		-- No guide open: both stay folded.
		UI.ShowPicker()
		local r = { closed = pane() }
		PolestarPicker:Hide()
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowPicker()
		r.open = pane()
		r.saved = saved()
		-- Folded again while the menu is open, it stays so until the menu opens again.
		header("Alliance 1\226\128\14730"):Click()
		r.refolded = P.IsCollapsed("Leveling/Alliance/1")
		emit(r)"#);
	let out = &out[0];
	assert_eq!(out["closed"], json!(["[Alliance 1\u{2013}30 3 >]", "[Other starting zones 3 >]"]));
	assert_eq!(
		out["open"],
		json!(["[Alliance 1\u{2013}30 3 v]", "Elwynn Forest (1\u{2013}13)", "Westfall (12\u{2013}17)", "Darkshore (16\u{2013}21)", "[Other starting zones 3 >]"])
	);
	assert_eq!(out["saved"], json!({ "Leveling/other-starts": true }));
	assert_eq!(out["refolded"], true);
}

// #1358: the Alliance list showed two "Dun Morogh (1-12)", the Dwarf's and the Gnome's start.
#[test]
fn guides_of_one_title_and_level_range_say_whose_they_are_by_race_else_by_faction_another_range_needs_nothing() {
	let out = run(r#"
		local dm = uistub.guides["forever/alliance/dwarf-gnome/01-dun-morogh"]
		dm.races = { "Dwarf" }
		local gnome = {}
		for k, v in pairs(dm) do gnome[k] = v end
		gnome.id, gnome.races = "forever/alliance/gnome/01-dun-morogh", { "Gnome" }
		uistub.guides[gnome.id] = gnome
		table.insert(uistub.order, gnome.id)
		local zh = {}
		for k, v in pairs(uistub.guides["forever/alliance/skyborne/01-zephras-isle"]) do zh[k] = v end
		zh.id, zh.faction = "forever/horde/skyborne/01-zephras-isle", "Horde"
		uistub.guides[zh.id] = zh
		table.insert(uistub.order, zh.id)
		-- Darkshore again at other levels: its range tells it apart.
		local ds = {}
		for k, v in pairs(uistub.guides["forever/alliance/03-darkshore"]) do ds[k] = v end
		ds.id, ds.minLevel, ds.maxLevel = "forever/alliance/03-darkshore-return", 21, 23
		uistub.guides[ds.id] = ds
		table.insert(uistub.order, ds.id)
		local function titles(filter)
			local out = {}
			for _, e in ipairs(P.Entries(filter, "", "Leveling")) do
				if e.kind == "guide" and (e.guide.title == "Dun Morogh" or e.guide.title == "Zephras Isle" or e.guide.title == "Darkshore") then out[#out + 1] = e.title end
			end
			return out
		end
		UI.ShowPicker()
		P.SetCategory("Leveling")
		emit({ alliance = titles("Alliance"), all = titles("All"), rows = pane() })
		-- Recent says it too.
		Polestar.CharState().ui.recentGuides = { "forever/alliance/dwarf-gnome/01-dun-morogh", gnome.id }
		P.SetView("recent")
		emit({ recent = pane() })"#);
	assert_eq!(out[0]["alliance"], json!(["Darkshore", "Darkshore", "Dun Morogh (Dwarf)", "Dun Morogh (Gnome)", "Zephras Isle"]));
	assert_eq!(
		out[0]["all"],
		json!(["Dun Morogh (Dwarf)", "Dun Morogh (Gnome)", "Zephras Isle (Alliance)", "Darkshore", "Darkshore", "Zephras Isle (Horde)"])
	);
	let rows = out[0]["rows"].as_array().unwrap();
	assert!(rows.contains(&json!("Dun Morogh (Dwarf) (1\u{2013}13)")) && rows.contains(&json!("Dun Morogh (Gnome) (1\u{2013}13)")), "{rows:?}");
	assert!(rows.contains(&json!("Darkshore (16\u{2013}21)")) && rows.contains(&json!("Darkshore (21\u{2013}23)")), "{rows:?}");
	assert_eq!(out[1]["recent"], json!(["[Recently loaded 2]", "Dun Morogh (Dwarf) (1\u{2013}13)", "Dun Morogh (Gnome) (1\u{2013}13)"]));
}
