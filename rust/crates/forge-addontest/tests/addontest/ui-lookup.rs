//! The Lookup section of the hub (addon/Polestar/UI/Lookup.lua) and its rows in the guide menu's search, against
//! the fake Engine of tests/lua/stub_ui.lua and the fake Search / Codex / Lookup runtime of
//! tests/lua/stub_lookup.lua; the last test runs the real runtime over the synthetic Codex pack
//! (tests/fixtures/codex).

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "Lookup/Options.lua", "UI/UI.xml"];

const ALL_KINDS: [&str; 13] = ["all", "guide", "mount", "pet", "item", "recipe", "tabard", "quest", "npc", "rare", "instance", "zone", "treasure"];

const HELPERS: &str = r#"
local function shownRows(parent)
	local out = {}
	for _, f in ipairs(stub.frames) do
		if rawget(f, "Sub") and rawget(f, "Title") and f:IsShown() and f:GetParent() == parent then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	return out
end
local function rowTexts(parent)
	local out = {}
	for _, r in ipairs(shownRows(parent)) do out[#out + 1] = r.Title:GetText() end
	return out
end
local function rowFor(parent, title)
	for _, r in ipairs(shownRows(parent)) do if r.Title:GetText() == title then return r end end
end
local function nav(key)
	for _, b in ipairs(PolestarPicker.navButtons) do if b.psKey == key and b:IsShown() then return b end end
end
local function lookupShown() return PolestarPicker:IsShown() and Polestar.UI.Picker.Section() == "Lookup" end
local function colorIs(label, token)
	local r, g, b = label:GetTextColor()
	local tr, tg, tb = Polestar.Theme.Color(token)
	return r == tr and g == tg and b == tb
end
local function navKeys()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then out[#out + 1] = b.psKey end end
	return out
end
local function navCounts()
	local out = {}
	for _, key in ipairs(navKeys()) do
		local count = nav(key).Count
		out[#out + 1] = count:IsShown() and count:GetText() or false
	end
	return out
end
local function fillKinds()
	for i, k in ipairs(Polestar.Search.KINDS) do
		if Polestar.Search.BrowseCount(k.key) == 0 then
			local id = k.key == "instance" and "test-instance" or 100000 + i
			table.insert(lookupstub.entities, { kind = k.key, id = id, title = k.label .. " example" })
		end
	end
end
local function type_(text)
	local box = Polestar.UI.Picker.search
	box:SetText(text)
	stub.RunScript(box, "OnTextChanged", true)
end
local function menuChoice(text)
	local menu = _G.PolestarMenu
	for _, row in ipairs(menu and menu.rows or {}) do
		if row:IsVisible() and row.Text:GetText() == text then return row end
	end
end
local function choose(button, text)
	if not (button and button:IsShown()) then return false end
	button:Click()
	local row = menuChoice(text)
	if not row then return false end
	row:Click()
	return true
end
local function bottom()
	local scroll = LK.results
	Polestar.Widgets.ScrollTo(scroll, scroll.psContent - scroll.psView)
	stub.RunScript(scroll, "OnVerticalScroll", scroll:GetVerticalScroll())
	return rowTexts(scroll.Child)
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_lookup.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nlookupstub.install()\nstub.login()\nlocal UI, LK = Polestar.UI, Polestar.UI.Lookup\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run_category_lookup(script: &str) -> Value {
	let mut items = json!({
		"71": { "name": "Trial Axe", "itemClass": 2, "itemSubclass": 0 },
		"72": { "name": "Trial Tunic", "itemClass": 4, "itemSubclass": 1 },
		"73": { "name": "Trial Relic" },
		"74": { "name": "Quiet Flask", "itemClass": 0, "itemSubclass": 3 },
		"75": { "name": "Trial Mount", "kind": "mount", "itemClass": 15, "itemSubclass": 5 },
		"76": { "name": "Odd Bag", "itemClass": 1, "itemSubclass": 12 },
		"77": { "name": "Unusual Material", "itemClass": 42 }
	});
	for i in 1..=53 {
		items[(100 + i).to_string()] = json!({ "name": format!("Trial Sword {i:02}"), "itemClass": 2, "itemSubclass": 7 });
	}
	run_packed_lookup(&json!({ "items": items }), script)
}

fn run_packed_lookup(codex: &Value, script: &str) -> Value {
	let pack = write_codex_pack(codex, &CodexOpts::default());
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Weights.lua", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		script: [
			r#"
			local realCompat = Polestar.Compat
			uistub.install()
			stub.login()
			local UI, LK = Polestar.UI, Polestar.UI.Lookup
			"#,
			HELPERS,
			r#"
			local function navLabel(label)
				for _, b in ipairs(PolestarPicker.navButtons) do
					if b:IsShown() and b.Label:GetText() == label then return b end
				end
			end
			"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn item_category_tree_counts_and_folds_are_independent_of_selection_and_paging() {
	let out = run_category_lookup(
		r#"
		local S = Polestar.Search
		local queryCalls, totals = 0, {}
		local query = S.Query
		S.Query = function(q, opts)
			queryCalls = queryCalls + 1
			totals[queryCalls] = opts.categoryTotals
			return query(q, opts)
		end
		UI.ShowLookup({ query = "trial" })
		local win = PolestarPicker
		local items = assert(nav("item"))
		assert(queryCalls == 1, "the first result page also supplies the sidebar counts")
		assert(not navLabel("Weapon") and items:GetHeight() == 36 and items.Count:GetText() == "56")
		assert(items.Toggle:GetWidth() == 24 and items.Toggle:GetHeight() == 24 and items.Chevron:GetWidth() == 12)
		assert(select(4, items.Toggle:GetPoint(1)) - select(4, items.Count:GetPoint(1)) == 32)
		local before, selected, calls = LK.shown, LK.Selected().id, queryCalls
		items.Toggle:Click()
		local weapon = assert(navLabel("Weapon"))
		local armor, consumable = assert(navLabel("Armor")), assert(navLabel("Consumable"))
		assert(weapon:GetHeight() == 32 and not navLabel("Sword"))
		assert(armor.Count:GetText() == "1" and weapon.Count:GetText() == "54")
		assert(consumable.psEmpty and not consumable.Count:IsShown() and colorIs(consumable.Label, "textMuted"))
		local function y(row) return select(5, row:GetPoint(1)) end
		assert(y(armor) > y(consumable) and y(consumable) > y(navLabel("Container")) and y(navLabel("Container")) > y(weapon))
		local unknownClass = assert(navLabel("Category 42"))
		assert(not (rawget(unknownClass, "Toggle") and unknownClass.Toggle:IsShown()))
		assert(not navLabel("Miscellaneous"), "the Mounts column does not supply Items nodes")
		navLabel("Container").Toggle:Click()
		assert(navLabel("Type 12"), "a known subclass without a label uses its numeric name")
		navLabel("Container").Toggle:Click()
		weapon.Toggle:Click()
		assert(queryCalls == calls and LK.shown == before and LK.Selected().id == selected)
		local sword = assert(navLabel("Sword"))
		assert(sword:GetHeight() == 28 and sword.Count:GetText() == "53")
		assert(select(4, sword.Label:GetPoint(1)) - select(4, weapon.Label:GetPoint(1)) == 12)
		weapon:Click()
		assert(LK.Kind() == "item" and LK.Query() == "trial" and LK.Selected().title == "Trial Axe")
		assert(win.Title:GetText() == "Items › Weapon" and LK.shown.groups[1].count == 54)
		sword:Click()
		assert(win.Title:GetText() == "Items › Weapon › Sword")
		assert(win.Subtitle:GetText() == "53 results for “trial”" and LK.shown.groups[1].count == 53)
		assert(LK.shown.rows == 50 and LK.Selected().title == "Trial Sword 01")
		assert(nav("item").Count:GetText() == "56" and navLabel("Armor").Count:GetText() == "1")
		assert(navLabel("Axe").Count:GetText() == "1" and navLabel("Axe").psKey ~= sword.psKey)
		assert(rowFor(LK.results.Child, "Trial Sword 01") and not rowFor(LK.results.Child, "Trial Axe"))
		local tail = bottom()
		local at = LK.results:GetVerticalScroll()
		local more = assert(rowFor(LK.results.Child, "Show more (3 more)"))
		assert(tail[#tail] == more.Title:GetText())
		local firstPage = queryCalls
		more:Click()
		assert(queryCalls == firstPage + 1 and totals[firstPage] == true and totals[queryCalls] == totals[firstPage])
		assert(LK.shown.rows == 53 and LK.Selected().title == "Trial Sword 01" and LK.results:GetVerticalScroll() == at)
		assert(bottom()[#bottom()] == "Trial Sword 53")
		local selection, list = LK.Selected().id, LK.shown
		weapon.Toggle:Click()
		assert(weapon.psOn and not navLabel("Sword") and LK.shown == list and LK.Selected().id == selection)
		assert(win.Title:GetText() == "Items › Weapon › Sword")
		items.Toggle:Click()
		assert(items.psOn and not navLabel("Weapon") and win.Title:GetText() == "Items › Weapon › Sword")
		items.Toggle:Click()
		assert(navLabel("Weapon").psOn)
		nav("mount"):Click()
		assert(LK.Kind() == "mount" and navLabel("Weapon"), "switching kinds keeps folds for this visit")
		items:Click()
		assert(win.Title:GetText() == "Items" and LK.shown.groups[1].count == 56)
		navLabel("Consumable"):Click()
		assert(LK.Selected() == nil and win.Subtitle:GetText() == "0 results for “trial”")
		assert(colorIs(navLabel("Consumable").Label, "text"), "selection wins when a tree row is empty")
		type_("trial axe")
		local beforeClick = queryCalls
		navLabel("Weapon"):Click()
		assert(queryCalls == beforeClick + 1 and LK.Query() == "trial axe" and LK.Selected().id == 71)
		navLabel("Weapon"):Click()
		type_("")
		assert(win.Subtitle:GetText() == "54, from A to Z")
		assert(LK.shown.groups[1].count == 54 and nav("item").Count:GetText() == "59")
		local browseTail = bottom()
		assert(browseTail[#browseTail] == "Show more (4 more)")
		rowFor(LK.results.Child, "Show more (4 more)"):Click()
		assert(LK.shown.rows == 54)
		win:Hide()
		UI.ToggleLookup()
		assert(not navLabel("Weapon"), "a new visit starts folded")
		emit(true)
	"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn clicking_the_active_item_sidebar_row_folds_without_changing_selection() {
	let out = run_category_lookup(
		r#"
		UI.ShowLookup({ query = "trial" })
		assert(nav("all").psOn and not navLabel("Weapon"))
		nav("item"):Click()
		assert(nav("item").psOn and not navLabel("Weapon"), "first click selects Items")
		local results, selected = LK.shown, LK.Selected()
		nav("item"):Click()
		assert(navLabel("Weapon") and LK.shown == results and LK.Selected() == selected)
		nav("item"):Click()
		assert(not navLabel("Weapon") and LK.shown == results and LK.Selected() == selected)
		nav("item"):Click()
		navLabel("Weapon"):Click()
		assert(navLabel("Weapon").psOn and not navLabel("Sword"), "first click selects Weapon")
		results, selected = LK.shown, LK.Selected()
		navLabel("Weapon"):Click()
		assert(navLabel("Sword") and LK.shown == results and LK.Selected() == selected)
		navLabel("Weapon"):Click()
		assert(not navLabel("Sword") and LK.shown == results and LK.Selected() == selected)

		navLabel("Weapon").Toggle:Click()
		navLabel("Sword"):Click()
		results, selected = LK.shown, LK.Selected()
		navLabel("Weapon").Toggle:Click()
		assert(navLabel("Weapon").psOn)
		navLabel("Weapon"):Click()
		assert(navLabel("Sword").psOn and LK.shown == results and LK.Selected() == selected)
		nav("item").Toggle:Click()
		assert(nav("item").psOn)
		nav("item"):Click()
		assert(navLabel("Sword").psOn and LK.shown == results and LK.Selected() == selected)
		nav("item"):Click()
		assert(nav("item").psOn and navLabel("Sword") and LK.shown ~= results)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn older_codex_pack_has_the_unchanged_flat_lookup_sidebar() {
	let out = run_category_lookup(
		r#"
		Polestar.Codex.RegisterFilters = nil
		UI.ShowLookup({ query = "trial" })
		local win = PolestarPicker
		assert(Polestar.Codex.IsLoaded() and not Polestar.Codex.HasFilters())
		local view = LK.results.psView
		LK.root.Visibility:Click()
		local drawer = LK.root.FilterDrawer
		assert(drawer:IsVisible() and drawer:GetHeight() == drawer.Status:GetHeight() + 36 + drawer.Clear:GetHeight() + 8 and not rawget(drawer, "Item"))
		assert(drawer.Compatibility:IsShown() and drawer.Compatibility:GetText() == "Update the Codex to filter items.")
		assert(#drawer.Availability == 2 and LK.results.psView == view - drawer:GetHeight())
		for _, b in ipairs(win.navButtons) do
			if b:IsShown() then assert(b:GetHeight() == 36 and not rawget(b, "Toggle")) end
		end
		emit({ keys = navKeys(), counts = navCounts() })
	"#,
	);
	assert_eq!(out["keys"], json!(["all", "mount", "item"]));
	assert_eq!(out["counts"], json!(["57", "1", "56"]));
}

fn run_filter_drawer(script: &str) -> Value {
	let mut codex = json!({
		"items": {
			"71": { "name": "Trial Charm", "reqLevel": 0, "itemLevel": 10, "slot": 0, "allowClass": 128, "itemClass": 0, "itemSubclass": 0, "quality": 5, "levelsSource": "client", "stats": { "4": 0 } },
			"72": { "name": "Trial Tunic", "reqLevel": 10, "itemLevel": 20, "slot": 5, "allowClass": 1503, "itemClass": 4, "itemSubclass": 1, "quality": 6 },
			"73": { "name": "Trial Quiver", "reqLevel": 20, "itemLevel": 25, "slot": 27, "allowClass": 4, "itemClass": 11, "itemSubclass": 2, "quality": 7 },
			"74": { "name": "Trial Shield", "slot": 14, "allowClass": 1503, "itemClass": 4, "itemSubclass": 6, "quality": 5 },
			"75": { "name": "Trial Mount", "kind": "mount", "reqLevel": 0, "slot": 0, "quality": 5 },
			"76": { "name": "Trial Pet", "kind": "pet", "reqLevel": 10, "slot": 0, "quality": 6 },
			"77": { "name": "Trial Recipe", "kind": "recipe", "reqLevel": 10, "slot": 0, "quality": 4 },
			"78": { "name": "Trial Tabard", "kind": "tabard", "reqLevel": 0, "slot": 19, "quality": 5 },
			"79": { "name": "Retired Trial", "kind": "mount", "reqLevel": 0, "slot": 0, "quality": 5, "status": "retired" },
			"80": { "name": "Trial Unknown Source", "reqLevel": 0, "slot": 0, "status": "nosource" },
			"81": { "name": "Token Fixture", "kind": "mount", "quality": 8 }
		},
		"quests": { "90": { "title": "Trial Quest" } }
	});
	for i in 1..=53 {
		codex["items"][(100 + i).to_string()] = json!({
			"name": format!("Trial Sword {i:02}"), "reqLevel": 10, "itemLevel": 20, "slot": 13, "itemClass": 2, "itemSubclass": 7, "quality": 2
		});
	}
	run_packed_lookup(
		&codex,
		&[
			r#"
			local function edit(box, text)
				box:SetText(text)
				stub.RunScript(box, "OnTextChanged", true)
			end
			local function openDrawer()
				LK.root.Visibility:Click()
				local drawer = LK.root.FilterDrawer
				assert(drawer:IsVisible())
				return drawer, rawget(drawer, "Item")
			end
			local function clickOutsideMenu()
				for _, f in ipairs(stub.frames) do
					if f:IsVisible() and f:GetFrameStrata() == "FULLSCREEN_DIALOG" and f:GetFrameLevel() == 1 then
						f:Click()
						assert(not PolestarMenu:IsShown())
						return
					end
				end
				error("No menu outside-click catcher")
			end
			"#,
			script,
		]
		.join("\n"),
	)
}

#[test]
fn lookup_drawer_ranges_commit_zero_open_bounds_and_discard_invalid_drafts() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		nav("item"):Click()
		local drawer, item = openDrawer()
		local req, level = item.Required, item.Level
		assert(req.Min.Hint:GetText() == "Min" and req.Max.Hint:GetText() == "Max")
		local query, queries = Polestar.Search.Query, 0
		Polestar.Search.Query = function(...) queries = queries + 1; return query(...) end
		LK.More()
		assert(LK.shown.rows > 50, "second page is open")
		type_("trial charm")
		local before = queries
		req.Max:SetFocus()
		edit(req.Max, "0")
		stub.RunScript(req.Max, "OnEnterPressed")
		assert(LK.Query() == "trial charm" and LK.ItemFilters().reqMax == 0 and LK.ItemFilters().reqMin == nil)
		assert(LK.shown.rows == 1 and LK.Selected().id == 71 and LK.results:GetVerticalScroll() == 0)
		assert(#LK.Recent() == 0 and queries == before + 1)
		stub.advance(0.3)
		assert(queries == before + 1, "the debounced query was consumed")
		edit(req.Max, "2.5")
		stub.RunScript(req.Max, "OnEnterPressed")
		assert(req.Max.psTip == "Enter whole levels from 0 to 999." and colorIs(req.Max, "warning"))
		assert(LK.ItemFilters().reqMax == 0 and queries == before + 1)
		stub.RunScript(req.Max, "OnEscapePressed")
		assert(req.Max:GetText() == "0" and req.Max.psTip == nil and not req.Max:HasFocus())
		edit(req.Min, "20")
		stub.RunScript(req.Min, "OnEditFocusLost")
		assert(req.Min.psTip == "Minimum must be at or below maximum." and LK.ItemFilters().reqMin == nil)
		edit(req.Max, "999")
		stub.RunScript(req.Max, "OnEditFocusLost")
		assert(LK.ItemFilters().reqMin == 20 and LK.ItemFilters().reqMax == 999)
		edit(req.Max, "1000")
		LK.root.Visibility:Click()
		assert(not LK.root.FilterDrawer:IsShown())
		openDrawer()
		assert(req.Max:GetText() == "999" and req.Max.psTip == nil)
		edit(req.Max, "")
		stub.RunScript(req.Max, "OnEditFocusLost")
		assert(LK.ItemFilters().reqMin == 20 and LK.ItemFilters().reqMax == nil)
		edit(req.Min, "")
		stub.RunScript(req.Min, "OnEditFocusLost")
		assert(next(LK.ItemFilters()) == nil and LK.root.Visibility.Label:GetText() == "Filters")
		edit(level.Min, "10")
		edit(level.Max, "10")
		stub.RunScript(level.Max, "OnEnterPressed")
		assert(LK.ItemFilters().ilvlMin == 10 and LK.ItemFilters().ilvlMax == 10 and LK.Selected().id == 71)
		drawer.Clear:Click()
		type_("")
		assert(choose(item.Slot, "One-hand"))
		assert(LK.shown.rows == 50 and LK.shown.groups[1].count == 53 and LK.Selected().id == 101)
		LK.More()
		assert(LK.shown.rows == 53 and LK.Selected().id == 101 and bottom()[#bottom()] == "Trial Sword 53")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_mouse_menus_preserve_filter_and_order_choices() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		UI.Picker.search:ClearFocus()
		local _, item = openDrawer()
		item.Rarity:Click()
		assert(menuChoice("Legendary")):Click()
		clickOutsideMenu()
		assert(LK.ItemFilters().quality[1] == 5)

		item.Slot:Click()
		assert(not PolestarMenu.Filter:HasFocus(), "a long menu's filter leaves the keys to the game until clicked")
		stub.RunScript(PolestarMenu.Filter, "OnMouseDown", "LeftButton")
		assert(PolestarMenu.Filter:HasFocus(), "a clicked filter takes the keys")
		edit(PolestarMenu.Filter, "shield")
		stub.RunScript(PolestarMenu.Filter, "OnEnterPressed")
		assert(LK.ItemFilters().slot == 14 and not PolestarMenu.Filter:HasFocus())

		LK.root.Visibility:Click()
		assert(choose(LK.root.SearchOrder, "A to Z") and LK.Order() == "az")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_mouse_range_focus_loss_commits() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		local _, item = openDrawer()
		local box = item.Required.Min
		box:SetFocus()
		stub.RunScript(box, "OnEditFocusGained")
		edit(box, "10")
		box:ClearFocus()
		stub.RunScript(box, "OnEditFocusLost")
		assert(LK.ItemFilters().reqMin == 10)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_hub_close_commits_valid_range_drafts_and_discards_invalid_ones() {
	let out = run_filter_drawer(
		r#"
		LK.SetItemFilters({ ilvlMax = 25 })
		UI.ShowLookup({ query = "trial" })
		local drawer, item = openDrawer()
		edit(item.Level.Max, "2.5")
		item.Required.Min:SetFocus()
		stub.RunScript(item.Required.Min, "OnEditFocusGained")
		edit(item.Required.Min, "10")
		assert(LK.ItemFilters().reqMin == nil)
		PolestarPicker:Hide()
		assert(not drawer:IsShown() and not item.Required.Min:HasFocus())
		assert(LK.ItemFilters().reqMin == 10 and LK.ItemFilters().ilvlMax == 25)
		UI.ToggleLookup()
		openDrawer()
		assert(item.Required.Min:GetText() == "10" and item.Level.Max:GetText() == "25" and not item.Level.Max.psTip)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_mouse_menu_opens_above_a_scaled_trigger_and_animates_upward() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		local _, item = openDrawer()
		local class = item.Class
		Polestar.Set("ui.reduceMotion", false)
		class:SetScale(0.5)
		class.y = 350
		class:Click()
		local menu = PolestarMenu
		assert(class:GetBottom() > menu:GetHeight() and class:GetBottom() * 0.5 < menu:GetHeight())
		local point, anchor, relPoint, _, y = menu:GetPoint(1)
		assert(point == "BOTTOMRIGHT" and anchor == class and relPoint == "TOPRIGHT")
		assert(y == 0, "the popover starts toward the trigger")
		stub.advance(0.3)
		assert(select(5, menu:GetPoint(1)) == 4)
		clickOutsideMenu()
		class:SetScale(2)
		class.y = 170
		class:Click()
		point, _, relPoint, _, y = menu:GetPoint(1)
		assert(point == "TOPRIGHT" and relPoint == "BOTTOMRIGHT" and y == 0)
		stub.advance(0.3)
		assert(select(5, menu:GetPoint(1)) == -4)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_menus_open_at_button_width_and_grow_left_for_long_choices() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		LK.SetKind("item")
		local drawer, item = openDrawer()
		local function popupAt(button)
			local menu = PolestarMenu
			local point, anchor, edge, x = menu:GetPoint(1)
			assert(menu:IsShown() and anchor == button and x == 0)
			assert(point == "TOPRIGHT" and edge == "BOTTOMRIGHT" or point == "BOTTOMRIGHT" and edge == "TOPRIGHT")
			return menu:GetWidth()
		end
		local class, order = item.Class, LK.root.SearchOrder
		local width = class:GetWidth()
		class:Click()
		assert(popupAt(class) == width, "Usable by fits its button when the labels are short")
		class:Click()
		class:SetWidth(60)
		class:Click()
		local grown = popupAt(class)
		assert(grown > 60 and grown < width, "Usable by grows only enough to fit its labels")
		LK.SetKind("quest")
		assert(not item:IsVisible() and not PolestarMenu:IsShown())
		LK.SetKind("item")

		for _, button in ipairs({ item.Slot, item.Rarity, item.Stat, order }) do
			button:SetWidth(320)
			button:Click()
			assert(popupAt(button) == button:GetWidth())
			button:Click()
		end
		assert(choose(order, "Choose a stat…"))
		assert(popupAt(order) == order:GetWidth())
		item.Slot:Click()
		LK.root.Visibility:Click()
		assert(not drawer:IsShown() and not PolestarMenu:IsShown())
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_availability_probes_only_item_backed_kinds() {
	let out = run_filter_drawer(
		r#"
		Polestar.Set("lookup.hideRetired", true)
		local search = Polestar.Search
		local query, count, sawMount = search.Query, search.BrowseCount, false
		search.Query = function(text, opts)
			if opts.limit == 0 and not opts.hideRetired then
				sawMount = sawMount or opts.kinds.mount
				for kind in pairs(opts.kinds) do
					assert(LK.KIND[kind].item, "availability query probed " .. kind)
				end
			end
			return query(text, opts)
		end
		search.BrowseCount = function(kind, opts)
			if opts and opts.hideRetired == false then
				assert(LK.KIND[kind].item, "availability browse probed " .. kind)
			end
			return count(kind, opts)
		end
		UI.ShowLookup({ query = "retired trial" })
		assert(sawMount and nav("mount") and not nav("mount").Count:IsShown())
		nav("mount"):Click()
		assert(LK.shown.empty == "Nothing matches “retired trial”.")
		type_("")
		assert(nav("mount").Count:GetText() == "2")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_drawer_class_rarity_and_raw_slots_apply_through_real_search() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		nav("item"):Click()
		local _, item = openDrawer()
		local function hasRGB(label, r, g, b)
			local cr, cg, cb = label:GetTextColor()
			return cr == r and cg == g and cb == b
		end
		assert(colorIs(item.Class.Label, "text") and colorIs(item.Rarity.Label, "text"))
		local classRow = item.Class:GetParent()
		GameTooltip:Hide()
		stub.RunScript(item.Class, "OnEnter")
		assert(not GameTooltip:IsShown(), "the dropdown button has no tooltip")
		assert(not item.Rarity:GetScript("OnEnter"), "custom dropdown buttons have no tooltip either")
		stub.RunScript(classRow, "OnEnter")
		assert(GameTooltip:IsShown() and GameTooltip:GetOwner() == classRow)
		assert(GameTooltip.lines[1] == "Usable by" and GameTooltip.lines[2] == "Uses item class restrictions and equipment proficiencies.")
		stub.RunScript(classRow, "OnLeave")
		classRow:Click()
		assert(colorIs(menuChoice("Any class").Text, "text"))
		for _, token in ipairs({ "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }) do
			assert(hasRGB(menuChoice(UI.ClassName(token)).Text, Polestar.Theme.ClassColor(token)), token)
		end
		menuChoice("Mage"):Click()
		assert(hasRGB(item.Class.Label, Polestar.Theme.ClassColor("MAGE")))
		assert(LK.ItemFilters().class == "MAGE" and LK.shown.rows == 2 and LK.root.Visibility.Label:GetText() == "Filters (1)")
		assert(choose(item.Class, "Any class"))
		item.Rarity:Click()
		local any, legendary, artifact = menuChoice("Any rarity"), menuChoice("Legendary"), menuChoice("Artifact")
		assert(any.Check:IsShown() and colorIs(any.Text, "text") and colorIs(item.Class.Label, "text"))
		for i, name in ipairs({ "Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Artifact", "Heirloom", "WoW Token" }) do
			assert(hasRGB(menuChoice(name).Text, LK.QualityColor(i - 1)), name)
		end
		legendary:Click()
		assert(PolestarMenu:IsShown() and menuChoice("Legendary") == legendary and legendary.Check:IsShown() and not any.Check:IsShown())
		assert(LK.shown.rows == 2 and item.Rarity.Label:GetText() == "Legendary" and hasRGB(item.Rarity.Label, LK.QualityColor(5)))
		artifact:Click()
		assert(PolestarMenu:IsShown() and artifact.Check:IsShown() and legendary.Check:IsShown())
		assert(LK.shown.rows == 3 and item.Rarity.Label:GetText() == "2 rarities" and colorIs(item.Rarity.Label, "text"))
		any:Click()
		assert(PolestarMenu:IsShown() and any.Check:IsShown() and not artifact.Check:IsShown() and not legendary.Check:IsShown())
		artifact:Click(); artifact:Click()
		assert(any.Check:IsShown() and LK.ItemFilters().quality == nil and colorIs(item.Rarity.Label, "text"))
		clickOutsideMenu()
		assert(LK.root.FilterDrawer:IsShown())
		for _, sample in ipairs({ { "Armor and accessories", "Chest", 5, 72 }, { "Weapons and off-hand", "Shield", 14, 74 },
			{ "Clothing and containers", "Quiver slot", 27, 73 }, { "Other slots", "Non-equippable", 0, 71 } }) do
			item.Slot:Click()
			local heading = assert(menuChoice(sample[1]))
			assert(heading.psItem.disabled and not heading.Check:IsShown())
			heading:Click()
			assert(PolestarMenu:IsShown())
			assert(menuChoice(sample[2])):Click()
			assert(not PolestarMenu:IsShown() and LK.ItemFilters().slot == sample[3] and LK.Selected().id == sample[4])
		end
		assert(choose(item.Slot, "Mobility spell") and LK.ItemFilters().slot == 34 and LK.shown.rows == 0)
		assert(item.Slot.Label:GetText() == "Mobility spell")
		assert(choose(item.Slot, "Any slot"))
		assert(LK.ItemFilters().slot == nil and item.Slot.Label:GetText() == "Any slot")
		Polestar.Gear = nil
		assert(choose(item.Class, "Mage"))
		assert(LK.ItemFilters().class == "MAGE" and LK.shown.rows == 50)
		assert(item.Class.Label:GetText() == "Mage · Unknown")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_drawer_rarity_only_offers_wow_token_if_present_or_saved() {
	let out = run_category_lookup(
		r#"
		UI.ShowLookup({ query = "trial" })
		LK.root.Visibility:Click()
		local rarity = LK.root.FilterDrawer.Item.Rarity
		rarity:Click()
		assert(menuChoice("Heirloom") and not menuChoice("WoW Token"))
		rarity:Click()
		LK.SetItemFilters({ quality = { 8 } })
		UI.Picker.Render()
		rarity:Click()
		assert(menuChoice("WoW Token").Check:IsShown() and LK.shown.rows == 0)
		menuChoice("WoW Token"):Click()
		assert(PolestarMenu:IsShown() and not menuChoice("WoW Token") and menuChoice("Any rarity").Check:IsShown())
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_filter_scope_empty_precedence_history_and_character_storage() {
	let out = run_filter_drawer(
		r##"
		local owner, other = Polestar.CharState(), {}
		local history = { { kind = "item", id = 72, title = "Trial Tunic" }, { kind = "item", id = 71, title = "Trial Charm" } }
		owner.ui = { recentLookups = history }
		UI.ShowLookup({ query = "trial" })
		local drawer, item = openDrawer()
		edit(item.Required.Max, "0")
		stub.RunScript(item.Required.Max, "OnEnterPressed")
		local counts = {}
		for _, group in ipairs(LK.shown.groups) do counts[group.kind] = group.count end
		assert(counts.item == 2 and counts.mount == 2 and counts.tabard == 1 and counts.quest == 1)
		assert(not counts.pet and not counts.recipe and nav("pet") and nav("recipe") and not nav("pet").Count:IsShown())
		nav("pet"):Click()
		assert(LK.shown.empty == "Nothing matches “trial”." and not LK.Selected())
		type_("absent"); stub.advance(0.3)
		assert(LK.shown.empty == "Nothing matches “absent”.")
		type_("#76"); stub.advance(0.3)
		assert(LK.shown.empty == "No item with that ID here.")
		type_("#999"); stub.advance(0.3)
		assert(LK.shown.empty == "No item with that ID here.")
		type_("")
		assert(LK.shown.empty == "Nothing to list here.")
		LK.SetKind("treasure")
		assert(LK.shown.empty == "Nothing to list here.")
		assert(not item:IsShown() and drawer.Clear:IsVisible())
		assert(drawer:GetHeight() == drawer.Status:GetHeight() + drawer.Clear:GetHeight() + 8)
		drawer.Availability[1]:Click()
		assert(drawer.Availability[1].psOn)
		drawer.Clear:Click()
		assert(not Polestar.Get("lookup.hideRetired") and LK.ItemFilters().reqMax == 0)
		LK.SetKind("all")
		assert(LK.shown.groups[1] == nil and LK.shown.rows == 2 and not LK.Selected())
		local recent = rowTexts(LK.results.Child)
		assert(recent[1] == "Trial Tunic" and recent[2] == "Trial Charm")
		assert(LK.root.Visibility.psTipLines[1] == "Recent lookups show your history.")
		assert(nav("item").Count:GetText() == "2" and nav("pet") and not nav("pet").Count:IsShown())
		local char = Polestar.CharState
		PolestarPicker:Hide()
		Polestar.CharState = function() return other end
		UI.ToggleLookup()
		assert(next(LK.ItemFilters()) == nil and not LK.root.FilterDrawer:IsShown())
		_, item = openDrawer()
		assert(item.Required.Max:GetText() == "")
		assert(choose(item.Slot, "Shield") and other.ui.lookupItemFilters.slot == 14)
		PolestarPicker:Hide()
		Polestar.CharState = char
		UI.ToggleLookup()
		_, item = openDrawer()
		assert(item.Required.Max:GetText() == "0" and item.Slot.Label:GetText() == "Any slot")
		assert(owner.ui.recentLookups == history and #history == 2)
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_filter_rows_show_help_on_hover() {
	let out = run_filter_drawer(
		r#"
		UI.ShowLookup({ query = "trial" })
		nav("item"):Click()
		local drawer, item = openDrawer()
		local rows = {
			{ item.Required, "Required level", "Uses the level the item requires." },
			{ item.Level, "Item level", "Uses the item's item level, which sets how strong its stats are." },
			{ item.Rarity:GetParent(), "Rarity", "Uses the item's quality, from Poor to Legendary." },
			{ item.Slot:GetParent(), "Slot", "Uses where the item is worn; items that aren't worn have no slot." },
			{ item.Stat:GetParent(), "Stat", "Uses the item's listed stats." },
			{ drawer.Availability[1], "Hide no longer obtainable", "Hides items that can't be obtained any more." },
			{ drawer.Availability[2], "Hide no known source", "Hides items with no known source." },
		}
		for _, entry in ipairs(rows) do
			local row, label, help = unpack(entry)
			assert(row:IsVisible(), label)
			stub.RunScript(row, "OnEnter")
			assert(GameTooltip:IsShown() and GameTooltip:GetOwner() == row, label .. " shows its row tooltip")
			assert(#GameTooltip.lines == 2 and GameTooltip.lines[1] == label and GameTooltip.lines[2] == help, label)
			stub.RunScript(row, "OnLeave")
			assert(not GameTooltip:IsShown(), label .. " hides its row tooltip")
		end
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_filter_drawer_clears_every_displayed_group_in_one_update() {
	let out = run_filter_drawer(
		r#"
		LK.SetItemFilters({ reqMin = 0, reqMax = 10, ilvlMin = 10, class = "MAGE", quality = { 5, 6 }, slot = 0, stat = 4 })
		Polestar.Set("lookup.hideRetired", true)
		Polestar.Set("lookup.hideNoSource", true)
		local char = Polestar.CharState()
		local history = { { kind = "item", id = 72, title = "Trial Tunic" } }
		char.ui.recentLookups = history
		UI.ShowLookup({ query = "trial" })
		LK.SetOrder("az")
		nav("item").Toggle:Click()
		navLabel("Consumable"):Click()
		assert(LK.root.Visibility.Label:GetText() == "Filters (9)", LK.root.Visibility.Label:GetText())
		local drawer = openDrawer()
		assert(drawer.Clear:IsVisible() and drawer.Clear.Label:GetText() == "Clear all")
		local point, anchor, edge, _, y = drawer.Clear:GetPoint(1)
		assert(drawer.Clear:GetParent() == drawer and point == "TOPRIGHT" and anchor == drawer.Status and edge == "BOTTOMRIGHT" and y < 0,
			"Clear all sits below the availability switches")
		local query, calls = Polestar.Search.Query, 0
		Polestar.Search.Query = function(...) calls = calls + 1; return query(...) end
		type_("trial tunic")
		drawer.Clear:Click()
		assert(calls == 1 and drawer:IsShown() and LK.root.Visibility.Label:GetText() == "Filters", "Clear all queried " .. calls .. " times")
		assert(LK.Kind() == "item" and PolestarPicker.Title:GetText() == "Items" and LK.Selected().id == 72, "Clear all returns to Items root")
		assert(next(LK.ItemFilters()) == nil and not Polestar.Get("lookup.hideRetired") and not Polestar.Get("lookup.hideNoSource"), "all filters reset")
		assert(LK.Query() == "trial tunic" and LK.Order() == "az" and char.ui.recentLookups == history and #history == 1, "query, order and history are retained")
		stub.advance(0.3)
		assert(calls == 1)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_filter_drawer_fits_both_hub_widths_and_leaves_results_scrollable() {
	for (skin, width, pad, inner) in [("polestar", 1120, 32, 442), ("halo", 1100, 28, 440)] {
		let out = run_filter_drawer(&format!(
			r#"
			Polestar.Set("ui.skin", "{skin}")
			UI.ShowLookup({{ query = "trial" }})
			nav("item"):Click()
			local win, box, sf = PolestarPicker, UI.Picker.search, LK.results
			assert(win:GetWidth() - win.psRail == {width})
			local baseline = sf.psView
			local before = LK.shown
			local drawer, item = openDrawer()
			local bar, sort, filters = LK.root.FilterBar, LK.root.SearchOrder:GetParent(), LK.root.Visibility
			assert(bar:GetParent() == LK.root and filters:GetParent() == bar and sort:GetParent() == bar)
			assert(bar:GetWidth() == {inner} and select(4, bar:GetPoint(1)) == {pad})
			local point, owner, edge, x = sort:GetPoint(1)
			assert(point == "RIGHT" and owner == filters and edge == "LEFT" and x < 0)
			assert(sort.Label:GetText() == "Sort by" and sort.Button.Label:GetText() == "Best match")
			point, owner, edge = drawer:GetPoint(1)
			assert(point == "TOPLEFT" and owner == bar and edge == "BOTTOMLEFT" and drawer:GetWidth() == bar:GetWidth())
			for _, group in ipairs({{ item, drawer.Status }}) do
				assert(group.Panel:GetParent() == group and group.Header:GetParent() == group)
				assert(not group.Header.Rule:IsShown() and group.Header:GetHeight() == Polestar.Widgets.PLAIN_SECTION_H)
				assert(select(2, group.Panel:GetPoint(1)) == group.Header)
			end
			assert(item.Header.Text:GetText() == "Item filters" and drawer.Status.Header.Text:GetText() == "Availability")
			for _, button in ipairs({{ item.Class, item.Rarity, item.Slot, item.Stat }}) do
				local row = button:GetParent()
				assert(row:GetParent() == item.Panel and row.Button == button and rawget(button, "Arrow"))
			end
			for _, toggle in ipairs(drawer.Availability) do
				assert(toggle:GetParent() == drawer.Status.Panel and rawget(toggle, "Track") and rawget(toggle, "Knob"))
			end
			assert(LK.shown == before and sf.psView == baseline - drawer:GetHeight())
			assert(sf.psView >= 2 * shownRows(sf.Child)[1]:GetHeight(), "Lookup leaves room for two result rows")
			local listTop = -4 - bar:GetHeight() - drawer:GetHeight()
			assert(select(5, sf:GetPoint(1)) == listTop)
			assert(choose(item.Slot, "One-hand") and select(5, sf:GetPoint(1)) == listTop)
			assert(LK.shown.rows == 50 and LK.Selected().id == 101)
			local tail = bottom()
			assert(tail[#tail] == "Show more (3 more)" and sf:GetVerticalScroll() == sf.psContent - sf.psView)
			rowFor(sf.Child, "Show more (3 more)"):Click()
			assert(LK.shown.rows == 53)
			Polestar.Widgets.ScrollTo(sf, 0)
			for _ = 1, 20 do LK.Step(1) end
			assert(sf:GetVerticalScroll() > 0 and rowFor(sf.Child, LK.Selected().title))
			rowFor(sf.Child, LK.Selected().title):Click()
			assert(drawer:IsShown())
			box:SetFocus()
			stub.RunScript(box, "OnEscapePressed")
			assert(not box:HasFocus() and drawer:IsShown(), "Escape in search only clears search focus")
			filters:Click()
			assert(not drawer:IsShown() and sf.psView == baseline and filters.Label:GetText() == "Filters (1)")
			filters:Click()
			item.Rarity:Click()
			UI.Picker.ShowSection("Guides")
			assert(not PolestarMenu:IsShown() and not drawer:IsShown())
			UI.Picker.ShowSection("Lookup")
			assert(not drawer:IsShown())
			openDrawer()
			stub.inCombat = true
			stub.fire("PLAYER_REGEN_DISABLED")
			drawer.Availability[1]:Click()
			assert(drawer.Availability[1].psOn)
			stub.inCombat = false
			PolestarPicker:Hide()
			assert(not LK.root.Visibility:IsVisible() and not drawer:IsShown())
			emit(true)
			"#,
		));
		assert_eq!(out, json!(true), "{skin}");
	}
}

/// Each source's `keys`, as rows (`sources.map((s) => [s.a, s.b, ...])`; a missing field is null).
fn cols(sources: &Value, keys: &[&str]) -> Value {
	Value::Array(sources.as_array().unwrap().iter().map(|s| Value::Array(keys.iter().map(|k| s[*k].clone()).collect())).collect())
}

#[test]
fn guide_lookup_button_opens_lookup_with_search_focus_without_changing_the_guide_1528() {
	let out = run(r#"
		local GF = UI.GuideFrame
		local B = GF.parts.nav.Lookup
		assert(type(B) == "table", "the guide window has a Lookup button")
		local function open()
			B:Click()
			local result = { shown = lookupShown(), focused = UI.Picker.search:HasFocus(), button = B:IsShown() }
			PolestarPicker:Hide()
			return result
		end
		local empty = open()
		uistub.setGuide(uistub.elwynn, 3)
		local guide, step = Polestar.Engine.GetGuide(), Polestar.Engine.GetStepIndex()
		local normal = open()
		Polestar.Set("ui.compact", true)
		local compact = open()
		stub.inCombat = true
		local combat = open()
		emit({ empty = empty, normal = normal, compact = compact, combat = combat,
			sameGuide = Polestar.Engine.GetGuide() == guide, sameStep = Polestar.Engine.GetStepIndex() == step })"#);
	for state in ["empty", "normal", "compact", "combat"] {
		assert_eq!(out[state], json!({ "shown": true, "focused": true, "button": true }), "{state}");
	}
	assert_eq!(out["sameGuide"], true);
	assert_eq!(out["sameStep"], true);
}

// #2769 (Liquidor): a search, another section, then Lookup again. The hub empties its box on the way, and the sidebar
// drew before Lookup took up the empty search: its kinds still counted the old results under an empty box.
#[test]
fn closing_the_hub_frees_the_search_caches_switching_sections_does_not() {
	let out = run(r#"
		local released = 0
		Polestar.Search.Release = function() released = released + 1 end
		Polestar.Lookup.Show("saber")
		Polestar.UI.Picker.ShowSection("Guides")
		local switched = released
		PolestarPicker:Hide()
		emit({ switched = switched, closed = released })"#);
	assert_eq!(out["switched"], 0, "another section of the open hub keeps them");
	assert_eq!(out["closed"], 1);
}

#[test]
fn a_search_left_for_another_section_is_gone_from_lookup_s_sidebar_when_it_shows_again() {
	let out = run(r#"
		Polestar.Lookup.Show("saber")
		local searched = { navs = navKeys(), all = nav("all").Count:IsShown() }
		Polestar.UI.Picker.ShowSection("Guides")
		Polestar.UI.Picker.ShowSection("Lookup")
		emit({ searched = searched, query = LK.Query(), box = Polestar.UI.Picker.search:GetText(), navs = navKeys(),
			all = nav("all").Count:IsShown() })"#);
	assert_eq!(out["searched"]["all"], true, "while searching, Everything counts the results");
	assert_eq!(out["query"], "");
	assert_eq!(out["box"], "");
	assert_eq!(out["all"], false, "an empty box: no result count on Everything");
	assert_ne!(out["navs"], out["searched"]["navs"], "the kinds are no longer the old search's");
}

#[test]
fn show_lookup_opens_the_hub_at_lookup_on_the_query_results_grouped_by_kind_the_first_selected() {
	let out = run(r#"
		Polestar.Lookup.Show("saber")
		local body = LK.results.Child
		emit({ shown = lookupShown(), query = LK.Query(), box = Polestar.UI.Picker.search:GetText(), groups = LK.shown.groups, rows = rowTexts(body),
			sel = LK.Selected() and LK.Selected().id, title = PolestarPicker.Title:GetText(), sub = PolestarPicker.Subtitle:GetText(),
			navs = navKeys(), mounts = nav("mount").Count:GetText(), codex = LK.root.CodexLine:GetText(), tabRow = PolestarPicker.TabRow:IsShown(),
			tip = rowFor(body, "Reins of the Striped Frostsaber").psTip,
			special = (function() for _, n in ipairs(UISpecialFrames) do if n == "PolestarPicker" then return true end end end)() })"#);
	assert_eq!(out["shown"], true);
	assert_eq!(out["query"], "saber");
	assert_eq!(out["box"], "saber");
	assert_eq!(
		out["groups"],
		json!([
			{ "kind": "mount", "count": 6, "shown": 5 },
			{ "kind": "item", "count": 1, "shown": 1 },
			{ "kind": "quest", "count": 1, "shown": 1 },
		])
	);
	assert_eq!(
		out["rows"],
		json!([
			"Reins of the Striped Frostsaber",
			"Reins of the Spotted Frostsaber",
			"Reins of the Winterspring Frostsaber",
			"Reins of the Nightsaber",
			"Reins of the Shadowsaber",
			"Show all 6",
			"Sabertooth Fang",
			"Frostsaber Provisions",
		])
	);
	assert_eq!(out["sel"], 8631);
	assert_eq!(out["title"], "Lookup");
	assert!(is_match(text(&out["sub"]), r"^8 results for .saber.$"));
	assert_eq!(out["mounts"], "6");
	assert_eq!(out["navs"], json!(["all", "mount", "item", "quest"]), "the sidebar lists the kinds this search found");
	assert_eq!(out["codex"], "", "a loaded Codex is not news");
	assert_eq!(out["tabRow"], false, "no tabs, no tab row");
	assert_eq!(out["tip"], "Double-click or press Enter to be guided to it.", "the key that acts, in the row tooltip");
	assert_eq!(out["special"], true);
}

#[test]
fn show_all_and_the_sidebar_filter_to_one_kind_arrows_walk_the_results() {
	let out = run(r#"
		Polestar.Lookup.Show("saber")
		local body = LK.results.Child
		rowFor(body, "Show all 6"):Click()
		local filtered = { kind = LK.Kind(), rows = rowTexts(body), title = PolestarPicker.Title:GetText() }
		nav("all"):Click()
		local box = Polestar.UI.Picker.search
		stub.RunScript(box, "OnArrowPressed", "DOWN")
		stub.RunScript(box, "OnArrowPressed", "DOWN")
		local two = LK.Selected().id
		stub.RunScript(box, "OnArrowPressed", "UP")
		emit({ filtered = filtered, two = two, back = LK.Selected().id, kind = LK.Kind() })"#);
	assert_eq!(out["filtered"]["kind"], "mount");
	assert_eq!(out["filtered"]["rows"].as_array().unwrap().len(), 6);
	assert_eq!(out["filtered"]["title"], "Mounts");
	assert_eq!(out["kind"], "all");
	assert_eq!(out["two"], 13086);
	assert_eq!(out["back"], 8632);
}

#[test]
fn typing_waits_for_a_pause_before_searching() {
	let out = run(r#"
		UI.ShowLookup()
		local before = lookupstub.queries
		type_("dea")
		type_("death")
		local during = { query = LK.Query(), queries = lookupstub.queries - before }
		stub.advance(0.3)
		emit({ during = during, query = LK.Query(), rows = rowTexts(LK.results.Child), sel = LK.Selected().id })"#);
	assert_eq!(out["during"], json!({ "query": "", "queries": 0 }));
	assert_eq!(out["query"], "death");
	assert_eq!(out["rows"], json!(["Deathcharger's Reins"]));
	assert_eq!(out["sel"], 13335);
}

#[test]
fn what_cannot_be_got_a_muted_chip_carries_it_in_the_list_and_the_hub_search_the_name_keeps_its_colour_no_guide_in_the_details() {
	let out = run(r#"
		Polestar.Lookup.Show("saber")
		LK.SetKind("mount")
		local function row(title)
			local r = rowFor(LK.results.Child, title)
			return { status = r.Status:IsShown() and r.Status.Text:GetText() or false, alpha = r.Title:GetAlpha() }
		end
		local list = { live = row("Reins of the Striped Frostsaber"), nosource = row("Reins of the Shadowsaber"), retired = row("Reins of the Frostsaber"),
			last = rowTexts(LK.results.Child)[6] }
		rowFor(LK.results.Child, "Reins of the Frostsaber"):Click()
		local d = LK.detail
		local chip = LK.details.Status:IsShown() and LK.details.Status.Text:GetText()
		local buttons = { primary = LK.details.Primary:IsShown(), secondary = LK.details.Secondary:IsShown() }
		LK.details.Rows[1]:Click()
		local sourceGuide = LK.details.Rows[1].Guide:IsShown()
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		LK.Guide(1)
		local calls = #lookupstub.calls
		UI.ShowPicker()
		Polestar.UI.Picker.ShowSection("Guides")
		Polestar.UI.Picker.SetQuery("reins of the frostsaber")
		local hub = {}
		for _, r in ipairs(shownRows(PolestarPicker.Scroll.Child)) do
			if r.psResult and r.psResult.id == 12302 then hub = { chip = r.Status:IsShown() and r.Status.Text:GetText(), alpha = r.Title:GetAlpha() } end
		end
		emit({ list = list, d = d, chip = chip, buttons = buttons, sourceGuide = sourceGuide, calls = calls, hub = hub })"#);
	assert_eq!(out["list"]["live"], json!({ "status": false, "alpha": 1 }));
	assert_eq!(out["list"]["nosource"], json!({ "status": "No known source", "alpha": 1 }));
	assert_eq!(out["list"]["retired"], json!({ "status": "No longer obtainable", "alpha": 1 }));
	assert_eq!(out["list"]["last"], "Reins of the Frostsaber", "retired last, as Search ranks it");
	assert_eq!(out["d"]["status"], "retired");
	assert_eq!(out["chip"], "No longer obtainable");
	assert_eq!(out["buttons"], json!({ "primary": false, "secondary": false }));
	assert_eq!(out["d"]["note"], "Not obtainable any more; shown for reference.");
	assert_eq!(cols(&out["d"]["sources"], &["label", "why", "guide"]), json!([["Lelanai", "No longer obtainable", false]]));
	assert_eq!(out["sourceGuide"], false);
	assert_eq!(out["calls"], 0, "Enter and Guide never build a guide to it");
	assert_eq!(out["hub"], json!({ "chip": "No longer obtainable", "alpha": 1 }));
}

#[test]
fn a_vendor_mount_facts_ranked_sources_with_travel_and_price_the_closed_one_dimmed_with_why() {
	let out = run(r#"
		Polestar.Lookup.Show(nil, "mount", 8631)
		emit({ query = LK.Query(), d = LK.detail, title = LK.details.Title:GetText(), color = { LK.details.Title:GetTextColor() } })"#);
	assert_eq!(out["query"], "Reins of the Striped Frostsaber");
	assert_eq!(out["title"], "Reins of the Striped Frostsaber");
	let c = |i: usize| out["color"][i].as_f64().unwrap();
	assert!(c(2) > c(0) && c(2) > c(1), "rare quality: blue");
	assert!(c(0) > 0.0, "lifted toward the text colour to read on the ground");
	assert_eq!(out["d"]["facts"], json!([["Type", "Mount  \u{b7}  Rare"], ["Requires", "Level 40"], ["Sources", "2  \u{b7}  1 open to you"],]));
	assert_eq!(
		cols(&out["d"]["sources"], &["label", "travel", "facts", "why", "available"]),
		json!([["Lelanai", "4 min", "80g", null, true], ["Zachariah Post", "32 min", "80g  \u{b7}  Limited stock", "Horde only", false],])
	);
}

#[test]
fn a_mount_without_a_curated_guide_has_no_guide_me_an_ordinary_item_still_builds_one() {
	let out = run(r#"
		Polestar.Lookup.Show(nil, "mount", 8631)
		local mount = { d = LK.detail, shown = LK.details.Primary:IsShown() }
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		mount.enter = lookupstub.calls[1]
		mount.status = LK.details.Note:GetText()
		mount.still = lookupShown()
		LK.details.Rows[1]:Click()
		mount.rowGuide = LK.details.Rows[1].Guide:IsShown()
		Polestar.Lookup.Show(nil, "item", 4386)
		emit({ mount = mount, item = LK.detail })"#);
	assert_eq!(out["mount"]["d"]["primary"], Value::Null);
	assert_eq!(out["mount"]["shown"], false);
	assert!(is_match(text(&out["mount"]["d"]["note"]), r"^No guide to this mount yet: the sources above say where it comes from"));
	assert_eq!(out["mount"]["rowGuide"], true, "a source's own Guide still leads to it");
	assert_eq!(out["mount"]["enter"], json!(["mount", 8631, false]));
	assert!(is_match(text(&out["mount"]["status"]), r"^No guide to this mount yet"));
	assert_eq!(out["mount"]["still"], true);
	assert_eq!(out["item"]["primary"], "Guide me");
	assert!(is_match(text(&out["item"]["note"]), r"Builds a guide to Stranglethorn Tiger"));
}

#[test]
fn guide_me_and_a_source_s_own_guide_call_lookup_guide_and_open_the_guide_window() {
	let out = run(r#"
		Polestar.Lookup.Show(nil, "mount", 8631)
		LK.details.Rows[2]:Click()
		local pick = { sel = LK.detail.sources[2].guide, other = LK.detail.sources[1].guide }
		LK.details.Rows[2].Guide:Click()
		local afterSource = { call = lookupstub.calls[1], shown = lookupShown(), ui = Polestar.Get("ui.shown") }
		Polestar.Set("ui.shown", false)
		Polestar.Lookup.Show(nil, "item", 4386)
		LK.details.Primary:Click()
		local primary = lookupstub.calls[2]
		Polestar.Lookup.Show(nil, "item", 4386)
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ pick = pick, afterSource = afterSource, primary = primary, enter = lookupstub.calls[3], shown = lookupShown(), ui = Polestar.Get("ui.shown") })"#);
	assert_eq!(out["pick"], json!({ "sel": true, "other": false }));
	assert_eq!(out["afterSource"], json!({ "call": ["mount", 8631, 2], "shown": false, "ui": true }));
	assert_eq!(out["primary"], json!(["item", 4386, false]));
	assert_eq!(out["enter"], json!(["item", 4386, false]));
	assert_eq!(out["shown"], false);
	assert_eq!(out["ui"], true);
}

#[test]
fn a_rare_drop_mount_out_of_reach_chance_the_reason_no_guide_me_a_curated_guide_says_open_guide() {
	let out = run(r#"
		Polestar.Lookup.Show("deathcharger")
		local drop = LK.detail
		lookupstub.curated["mount:8631"] = "forever/alliance/02-westfall"
		Polestar.Lookup.Show(nil, "mount", 8631)
		local curated = LK.detail
		LK.details.Primary:Click()
		lookupstub.guideResult = "nosource"
		Polestar.Lookup.Show(nil, "mount", 13335)
		LK.details.Rows[1]:Click()
		LK.details.Rows[1].Guide:Click()
		emit({ drop = drop, curated = curated, call = lookupstub.calls[1], failed = LK.details.Note:GetText(), still = lookupShown() })"#);
	assert_eq!(out["drop"]["id"], 13335);
	assert_eq!(
		cols(&out["drop"]["sources"], &["label", "facts", "why", "available"]),
		json!([["Baron Rivendare", "0.1% drop chance", "Needs level 58", false], ["Ramstein's Reward", null, "Needs level 60", false],])
	);
	// A rare drop is no "kill it" guide: no Guide me for a mount without a curated guide.
	assert_eq!(out["drop"]["primary"], Value::Null);
	assert!(is_match(text(&out["drop"]["note"]), r"^No guide to this mount yet"));
	assert_eq!(out["curated"]["primary"], "Open guide");
	// Neutral wording: the curated guide may come from a guide pack.
	assert!(is_match(text(&out["curated"]["note"]), r"^A guide covers this: .*Westfall.*\.$"));
	assert!(!is_match(text(&out["curated"]["note"]), r"Polestar"));
	assert_eq!(out["call"], json!(["mount", 8631, false]));
	assert!(is_match(text(&out["failed"]), r"nosource"));
	assert_eq!(out["still"], true);
}

#[test]
fn without_the_codex_pack_the_section_says_what_is_missing_and_still_finds_guides() {
	let out = run(r#"
		lookupstub.loaded, lookupstub.reason = false, "missing"
		UI.ShowLookup()
		LK.root.Visibility:Click()
		assert(LK.root.FilterDrawer.Status:IsVisible() and not rawget(LK.root.FilterDrawer, "Compatibility"))
		local idle = { title = LK.detail.empty, note = LK.detail.note, list = LK.shown.empty, codex = LK.root.CodexLine:GetText(),
			navs = navKeys() }
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local none = LK.shown.empty
		Polestar.UI.Picker.SetQuery("west"); stub.advance(0.3)
		emit({ idle = idle, none = none, rows = rowTexts(LK.results.Child), sel = LK.detail.primary })"#);
	assert_eq!(out["idle"]["title"], "The Codex is not loaded");
	assert!(
		is_match(text(&out["idle"]["note"]), r#"^The Polestar_Codex addon is not installed\. .*Releases page.*not "Source code""#),
		"a missing Codex points at the release download, not the source zip"
	);
	assert!(!is_match(text(&out["idle"]["note"]), r"tools/polestar|codex build"), "no developer command in a player message");
	assert!(is_match(text(&out["idle"]["list"]), r"search the guides"));
	assert!(is_match(text(&out["idle"]["codex"]), r"Codex not installed"));
	assert_eq!(out["idle"]["navs"], json!(["all", "guide"]));
	assert!(is_match(text(&out["none"]), r"Nothing matches .saber.\. Items, mounts, NPCs and quests are searched once the Codex loads\."));
	assert_eq!(out["rows"], json!(["Westfall"]));
	assert_eq!(out["sel"], "Open in new tab");
}

#[test]
fn a_codex_that_is_installed_but_turned_off_says_to_enable_it_not_to_download_polestar_again() {
	let out = run(r#"
		lookupstub.loaded, lookupstub.reason = false, "disabled"
		UI.ShowLookup()
		emit({ note = LK.detail.note })"#);
	assert!(is_match(text(&out["note"]), r"turned off: enable it in the AddOns list"));
	assert!(!is_match(text(&out["note"]), r"Releases page"));
}

#[test]
fn a_guide_result_opens_in_a_new_tab_or_among_the_hub_s_guides() {
	let out = run(r#"
		Polestar.Lookup.Show("west")
		LK.details.Primary:Click()
		local opened = uistub.calls[#uistub.calls]
		Polestar.Lookup.Show("west")
		LK.details.Secondary:Click()
		local P = Polestar.UI.Picker
		emit({ opened = opened, lookup = lookupShown(), picker = PolestarPicker:IsShown(), section = P.Section(), view = P.View(), sel = P.Selected() })"#);
	assert_eq!(out["opened"], json!(["OpenTab", "forever/alliance/02-westfall"]));
	assert_eq!(out["lookup"], false);
	assert_eq!(out["picker"], true);
	assert_eq!(out["section"], "Guides");
	assert_eq!(out["view"], "browse");
	assert_eq!(out["sel"], "forever/alliance/02-westfall");
}

#[test]
fn the_hub_s_guide_search_lists_codex_matches_under_its_guides_one_opens_the_lookup_section_at_it() {
	let out = run(r#"
		UI.ShowPicker()
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local body = PolestarPicker.Scroll.Child
		local rows = {}
		for _, r in ipairs(shownRows(body)) do rows[#rows + 1] = r.Title:GetText() .. " | " .. r.Sub:GetText() end
		local empty = PolestarPicker.Empty and PolestarPicker.Empty:IsShown()
		local count = UI.LookupCount()
		rowFor(body, "Frostsaber Provisions"):Click()
		emit({ rows = rows, count = count, empty = empty, picker = PolestarPicker:IsShown(), lookup = lookupShown(), sel = LK.Selected(), query = LK.Query() })"#);
	assert_eq!(
		out["rows"],
		json!([
			"Reins of the Striped Frostsaber | Mount  \u{b7}  Vendor \u{b7} Darnassus",
			"Reins of the Spotted Frostsaber | Mount  \u{b7}  Vendor \u{b7} Darnassus",
			"Reins of the Winterspring Frostsaber | Mount  \u{b7}  Reputation \u{b7} Winterspring",
			"Sabertooth Fang | Item  \u{b7}  Drop \u{b7} Stranglethorn Vale",
			"Frostsaber Provisions | Quest  \u{b7}  Level 60 \u{b7} Winterspring",
			"Look up everything for \u{201c}saber\u{201d} | ",
		])
	);
	assert_eq!(out["count"], 5);
	assert!(!truthy(&out["empty"]), "no \"No guides match\" over the Codex rows");
	assert_eq!(out["picker"], true);
	assert_eq!(out["lookup"], true);
	assert_eq!(out["sel"], json!({ "kind": "quest", "id": 4970 }));
	assert_eq!(out["query"], "saber");
}

#[test]
fn clearing_the_hub_s_search_takes_its_codex_matches_away_none_stay_drawn_over_the_guide_list() {
	let out = run(r#"
		UI.ShowPicker()
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local body = PolestarPicker.Scroll.Child
		local before = rowFor(body, "Frostsaber Provisions") and true or false
		Polestar.UI.Picker.SetQuery(""); stub.advance(0.3)
		local stale = {}
		for _, r in ipairs(shownRows(body)) do
			local t = r.Title and r.Title:GetText() or ""
			if t:find("saber") or t:find("Look up everything") then stale[#stale + 1] = t end
		end
		emit({ before = before, stale = table.concat(stale, " / "), count = UI.LookupCount(), total = UI.LookupTotal() })"#);
	assert_eq!(out["before"], true);
	assert_eq!(out["stale"], "");
	assert_eq!(out["count"], 0);
	assert_eq!(out["total"], 0);
}

#[test]
fn with_the_real_search_codex_and_lookup_runtime_over_the_sample_pack() {
	let mut codex = sample_codex();
	codex["items"]["19019"] = json!({ "name": "Thunderfury", "quality": 5 });
	let pack = write_codex_pack(&codex, &CodexOpts { ..Default::default() });
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		script: [
			HELPERS,
			r#"uistub.install()
stub.login()
local LK = Polestar.UI.Lookup
Polestar.Lookup.Show("saber")
local search = { groups = LK.shown.groups, sel = LK.Selected().kind, codex = LK.root.CodexLine:GetText() }
Polestar.Lookup.Show(nil, "mount", 13335)
local out = { search = search, title = LK.detail.title, query = LK.Query(), sources = LK.detail.sources, primary = LK.detail.primary, note = LK.detail.note }
type_("19019"); stub.advance(0.3)
out.thunderfury = rowFor(LK.results.Child, "Thunderfury") ~= nil
emit(out)"#,
		]
		.concat(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["search"]["groups"], json!([{ "kind": "mount", "count": 3, "shown": 3 }]));
	assert_eq!(out["search"]["sel"], "mount");
	assert_eq!(out["search"]["codex"], "");
	assert_eq!(out["title"], "Deathcharger's Reins");
	assert_eq!(out["query"], "Deathcharger's Reins");
	assert_eq!(out["sources"][0]["label"], "Baron Rivendare");
	assert_eq!(out["sources"][0]["facts"], "0.1% drop chance");
	assert_eq!(out["sources"][0]["available"], false);
	assert!(truthy(&out["sources"][0]["why"]), "says why it is out of reach");
	assert_eq!(out["primary"], Value::Null, "the real runtime builds no guide to a mount");
	assert!(is_match(text(&out["note"]), r"^No guide to this mount yet"));
	assert_eq!(out["thunderfury"], true);
	drop(pack);
}

#[test]
fn item_filters_round_trip_per_character_and_clear_without_touching_history() {
	let pack = write_codex_pack(
		&json!({
			"items": {
				"1": { "name": "Match", "reqLevel": 0, "quality": 0, "itemClass": 2, "itemSubclass": 7 },
				"2": { "name": "Other category", "reqLevel": 0, "quality": 0, "itemClass": 2, "itemSubclass": 8 },
				"3": { "name": "Other rarity", "reqLevel": 0, "quality": 2, "itemClass": 2, "itemSubclass": 7 }
			}
		}),
		&CodexOpts::default(),
	);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Weights.lua", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		script: r#"
		uistub.install()
		stub.login()
		local LK, S = Polestar.UI.Lookup, Polestar.Search
		local char = Polestar.CharState
		local s = char()
		assert(next(LK.ItemFilters()) == nil, "missing saved filters")
		Polestar.CharState = nil
		assert(next(LK.ItemFilters()) == nil, "CharState is optional")
		assert(LK.SetItemFilters({ reqMax = 0 }).reqMax == 0)
		LK.ClearItemFilters()
		Polestar.CharState = char

		s.ui = { recentLookups = { { kind = "item", id = 1 } }, other = true }
		local history = s.ui.recentLookups
		s.ui.lookupItemFilters = "malformed"
		assert(next(LK.ItemFilters()) == nil, "malformed root")
		local input = {
			reqMin = 0, reqMax = 0, ilvlMin = 12, ilvlMax = 999,
			quality = { 8, 0, 4, 0, 9, -1, 2.5, "3", false },
			slot = 34, class = "MAGE", stat = 4, category = { class = 2 }, drawer = true, order = "az",
		}
		local set = LK.SetItemFilters(input)
		local saved = LK.ItemFilters()
		for _, f in ipairs({ set, saved }) do
			assert(f.reqMin == 0 and f.reqMax == 0 and f.ilvlMin == 12 and f.ilvlMax == 999)
			assert(table.concat(f.quality, ",") == "0,4,8")
			assert(f.slot == 34 and f.class == "MAGE" and f.stat == 4)
			assert(f.category == nil and f.drawer == nil and f.order == nil)
		end
		input.quality[1], set.quality[1], saved.quality[1], saved.reqMax = 7, 6, 5, 10
		assert(s.ui.lookupItemFilters.quality[1] == 0 and s.ui.lookupItemFilters.reqMax == 0)
		Polestar.CharState = function() return {} end
		assert(next(LK.ItemFilters()) == nil, "another character has separate filters")
		Polestar.CharState = char
		assert(LK.ItemFilters().class == "MAGE")

		local gear = Polestar.Gear
		Polestar.Gear = nil
		assert(LK.ItemFilters().class == "MAGE", "retain the class before Gear loads")
		Polestar.Gear = gear
		assert(next(LK.SetItemFilters({
			reqMin = 3, reqMax = 2, ilvlMin = 2, ilvlMax = 1, slot = -1, class = "UNKNOWN", stat = 999,
			quality = { [9] = true, [-1] = true, [2.5] = true, ["1"] = true, [0] = false },
		})) == nil, "drop inverted ranges and invalid selectors")
		assert(s.ui.lookupItemFilters == nil)
		for _, invalid in ipairs({ "0", -1, 0.5, 1000 }) do
			local f = LK.SetItemFilters({ reqMin = invalid, reqMax = 0, ilvlMin = 11, ilvlMax = invalid, slot = 35 })
			assert(f.reqMin == nil and f.reqMax == 0 and f.ilvlMin == 11 and f.ilvlMax == nil and f.slot == nil)
		end
		local valid = LK.SetItemFilters({ reqMax = 0, quality = { [0] = true, [8] = true, [2] = false }, slot = 0 })
		assert(valid.slot == 0 and table.concat(valid.quality, ",") == "0,8")

		assert(LK.SearchFilters({}) == nil and LK.SearchFilters(nil) == nil)
		local category = { class = 2, subclass = 7 }
		assert(LK.SearchFilters({}, category).category == category)
		local filters = LK.SearchFilters({ reqMin = 0, reqMax = 0, ilvlMin = 12, ilvlMax = 999,
			quality = valid.quality, slot = 0, class = "MAGE", stat = 4 }, category)
		assert(filters.reqMin == 0 and filters.reqMax == 0 and filters.ilvlMin == 12 and filters.ilvlMax == 999)
		assert(filters.slot == 0 and filters.class == "MAGE" and filters.stat == 4 and filters.category == category)
		assert(filters.quality[0] == true and filters.quality[8] == true and filters.quality[2] == nil)
		assert(Polestar.Codex.Load() and Polestar.Codex.HasFilters())
		local savedForBrowse = LK.SetItemFilters({ reqMax = 0, quality = valid.quality })
		local rows, count = S.Browse("item", { filters = LK.SearchFilters(savedForBrowse, category) })
		local _, handBuiltCount = S.Browse("item", {
			filters = { reqMax = 0, quality = { [0] = true, [8] = true }, category = category },
		})
		assert(count == handBuiltCount and count == 1 and rows[1].id == 1)
		LK.ClearItemFilters()
		assert(s.ui.lookupItemFilters == nil and next(LK.ItemFilters()) == nil)
		assert(s.ui.recentLookups == history and #history == 1 and history[1].id == 1 and s.ui.other)
		emit(true)"#
			.into(),
		..Default::default()
	});
	assert_eq!(out, vec![json!(true)]);
}

#[test]
fn changing_the_suggestion_source_ranks_a_cached_search_again() {
	let pack = write_codex_pack(&sample_codex(), &CodexOpts { ..Default::default() });
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		// The real registry: the ranking follows its suggestion source.
		script: [
			"uistub.install()\nPolestar.Guides = uistub.realGuides\nstub.login()\nlocal LK = Polestar.UI.Lookup",
			HELPERS,
			r#"Polestar.RegisterPack({ addon = "Polestar_Other", id = "other", format = 1, title = "Other", author = "O", version = "1", license = "MIT" })
local function g(id, extra)
	local def = { id = id, pack = "other", title = id, steps = { { goals = { { t = "note", text = "x" } } } } }
	for k, v in pairs(extra) do def[k] = v end
	assert(Polestar.RegisterGuide(def))
end
g("other/sabers", { category = "Collectibles", collects = { 13086 } })
g("other/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
Polestar.Lookup.Show("frostsaber")
emit(rowTexts(LK.results.Child)[1])
Polestar.Set("behavior.suggestFrom", "other")
emit(rowTexts(LK.results.Child)[1])"#,
		]
		.join("\n"),
		..Default::default()
	});
	let (before, after) = (&out[0], &out[1]);
	assert_ne!(*before, "Reins of the Winterspring Frostsaber");
	assert_eq!(*after, "Reins of the Winterspring Frostsaber", "the source's guide collects it: first");
	drop(pack);
}

#[test]
fn a_dungeon_also_opens_in_the_dungeons_section_beside_the_guide_to_its_entrance_or_alone() {
	let out = run(r#"
		local opened = {}
		Polestar.Dungeons = { Open = function(key) opened[#opened + 1] = key end }
		table.insert(lookupstub.entities, { kind = "instance", id = "stratholme", title = "Stratholme", subtitle = "Dungeon \194\183 45-60" })
		lookupstub.sources["instance:stratholme"] = {
			{ type = "world", src = { type = "world" }, label = "Stratholme", detail = "Entrance \194\183 Eastern Plaguelands", map = 1423, x = 27, y = 11, available = true, guideable = true },
		}
		Polestar.Lookup.Show(nil, "instance", "stratholme")
		local both = { primary = LK.detail.primary, secondary = LK.details.Secondary:IsShown() and LK.details.Secondary.Label:GetText() }
		LK.details.Secondary:Click()
		local after = { opened = opened[1], shown = lookupShown() }
		lookupstub.sources["instance:stratholme"] = {}
		Polestar.UI.Lookup.Select(nil)
		Polestar.Lookup.Show(nil, "instance", "stratholme")
		local alone = { primary = LK.detail.primary, secondary = LK.details.Secondary:IsShown() }
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ both = both, after = after, alone = alone, enter = opened[2] })"#);
	assert_eq!(out["both"], json!({ "primary": "Guide me", "secondary": "Open dungeon" }));
	// The Dungeons section takes over the hub itself; Lookup closes nothing.
	assert_eq!(out["after"], json!({ "opened": "stratholme", "shown": true }));
	assert_eq!(out["alone"], json!({ "primary": "Open dungeon", "secondary": false }));
	assert_eq!(out["enter"], "stratholme");
}

#[test]
fn everything_on_an_empty_search_shows_the_ten_most_recent_lookups_and_every_kind_in_the_sidebar() {
	let out = run(r#"
		fillKinds()
		UI.ShowLookup()
		local first = { rows = #rowTexts(LK.results.Child), empty = LK.shown.empty, queries = lookupstub.queries, browsed = lookupstub.browsed }
		Polestar.Lookup.Show(nil, "mount", 8631)
		Polestar.Lookup.Show(nil, "mount", 13335)
		-- Typing selects the first result for you: that is no lookup of yours.
		Polestar.UI.Picker.SetQuery("lelanai"); stub.advance(0.3)
		local auto = #LK.Recent()
		-- A click is.
		rowFor(LK.results.Child, "Lelanai"):Click()
		Polestar.UI.Picker.SetQuery(""); stub.advance(0.3)
		local recent = { rows = rowTexts(LK.results.Child), folder = LK.shown.rows, empty = LK.shown.empty, navs = navKeys() }
		for i = 1, 12 do Polestar.Lookup.Show(nil, "mount", 8631 + (i % 2)); Polestar.Lookup.Show(nil, "npc", 10440) end
		emit({ first = first, auto = auto, recent = recent, saved = Polestar.CharState().ui.recentLookups[1].title, n = #LK.Recent() })"#);
	assert_eq!(out["first"]["rows"], 0);
	assert!(is_match(text(&out["first"]["empty"]), r"Type a name in the search box"));
	assert_eq!(out["first"]["queries"], 0, "nothing is searched for an empty box");
	assert_eq!(out["first"]["browsed"], 0, "Everything does not browse any kind");
	assert_eq!(out["auto"], 2);
	assert_eq!(out["recent"]["rows"], json!(["Lelanai", "Deathcharger's Reins", "Reins of the Striped Frostsaber"]));
	assert!(is_match(text(&out["recent"]["empty"]), r"Type a name"), "the hint under the recent lookups");
	assert_eq!(out["recent"]["navs"], json!(ALL_KINDS));
	assert_eq!(out["saved"], "Baron Rivendare");
	assert!(out["n"].as_f64().unwrap() <= 10.0);
}

#[test]
fn empty_search_offers_every_nonempty_kind_with_its_total_when_the_codex_is_loaded() {
	let out = run(r#"
		UI.ShowLookup()
		local sparse = navKeys()
		fillKinds()
		Polestar.Fire("CODEX_LOADED")
		emit({ sparse = sparse, keys = navKeys(), counts = navCounts(), browsed = lookupstub.browsed })"#);
	assert_eq!(out["sparse"], json!(["all", "guide", "mount", "item", "quest", "npc", "zone"]));
	assert_eq!(out["keys"], json!(ALL_KINDS));
	assert_eq!(out["counts"], json!([false, "1", "7", "1", "1", "1", "1", "2", "2", "1", "1", "2", "1"]));
	assert_eq!(out["browsed"], 0);
}

#[test]
fn empty_search_offers_only_everything_and_guides_when_the_codex_is_unavailable() {
	let out = run(r#"
		local states = {}
		for _, reason in ipairs({ "missing", "disabled", "off", "nosearch" }) do
			lookupstub.loaded, lookupstub.reason = false, reason
			if reason == "nosearch" then Polestar.Search = nil end
			UI.ShowLookup()
			Polestar.Fire("CODEX_LOADED")
			states[reason] = navKeys()
		end
		emit(states)"#);
	for reason in ["missing", "disabled", "off", "nosearch"] {
		assert_eq!(out[reason], json!(["all", "guide"]), "{reason}");
	}
}

#[test]
fn empty_search_offers_kinds_without_counts_before_the_codex_loads_and_populates_the_open_kind_afterward() {
	let out = run(r#"
		fillKinds()
		lookupstub.loaded, lookupstub.reason = false, "notloaded"
		UI.ShowLookup()
		local waiting = { keys = navKeys(), counts = navCounts() }
		Polestar.Codex.Load = function() lookupstub.reason = "loading" end
		LK.SetKind("mount")
		local loading = { keys = navKeys(), counts = navCounts(), empty = LK.shown.empty, rows = LK.shown.rows }
		lookupstub.loaded, lookupstub.reason = true, nil
		Polestar.Fire("CODEX_LOADED")
		emit({ waiting = waiting, loading = loading, counts = navCounts(), rows = LK.shown.rows,
			selected = LK.Selected() and LK.Selected().id })"#);
	for state in ["waiting", "loading"] {
		assert_eq!(out[state]["keys"], json!(ALL_KINDS), "{state}");
		assert_eq!(out[state]["counts"], json!(vec![false; 13]), "{state}");
	}
	assert_eq!(out["loading"]["empty"], "Loading the Codex\u{2026}");
	assert_eq!(out["loading"]["rows"], 0);
	assert_eq!(out["counts"][2], "7");
	assert_eq!(out["rows"], 7);
	assert_eq!(out["selected"], 13335);
}

#[test]
fn browsing_a_kind_shows_its_header_count_only_after_the_codex_loads() {
	let out = run(r#"
		lookupstub.loaded, lookupstub.reason = false, "loading"
		UI.ShowLookup()
		nav("item"):Click()
		local loading = PolestarPicker.Subtitle:GetText()
		lookupstub.loaded, lookupstub.reason = true, nil
		Polestar.Fire("CODEX_LOADED")
		emit({ loading = loading, loaded = PolestarPicker.Subtitle:GetText() })"#);
	assert_eq!(out["loading"], "Every guide, item, mount, NPC, quest and place, and where to get it.");
	assert_eq!(out["loaded"], "1, from A to Z");
}

#[test]
fn browsing_a_kind_returns_to_everything_when_lookup_is_turned_off() {
	let out = run(r#"
		UI.ShowLookup()
		nav("mount"):Click()
		rowFor(LK.results.Child, "Deathcharger's Reins"):Click()
		nav("item"):Click()
		local before = LK.shown.kind
		local picked = LK.Selected() and LK.Selected().kind or false
		lookupstub.loaded, lookupstub.reason = false, "off"
		Polestar.Fire("SETTING_CHANGED", "lookup.enabled")
		emit({ before = before, picked = picked, kind = LK.shown.kind, active = PolestarPicker.NavScroll.psActive,
			navs = navKeys(), rows = rowTexts(LK.results.Child), hint = LK.shown.empty,
			selected = LK.Selected() ~= nil })"#);
	assert_eq!(out["before"], "item");
	assert_eq!(out["picked"], "item");
	assert_eq!(out["selected"], false, "no Codex entry stays selected once nothing can look it up");
	assert_eq!(out["kind"], "all");
	assert_eq!(out["active"], "all");
	assert_eq!(out["navs"], json!(["all", "guide"]));
	assert_eq!(out["rows"], json!(["Deathcharger's Reins"]));
	assert_eq!(out["hint"], "Type a name in the search box to search the guides.");
}

#[test]
fn an_empty_browse_list_uses_the_standard_message_or_says_the_codex_waits_for_combat() {
	let out = run(r#"
		UI.ShowLookup()
		LK.SetKind("mount")
		for _, e in ipairs(lookupstub.entities) do
			if e.kind == "mount" then e.status = e.status or "retired" end
		end
		Polestar.Set("lookup.hideRetired", true)
		Polestar.Set("lookup.hideNoSource", true)
		local filtered = { kind = LK.shown.kind, rows = LK.shown.rows, empty = LK.shown.empty }
		Polestar.Set("lookup.hideRetired", false)
		Polestar.Set("lookup.hideNoSource", false)
		lookupstub.loaded, lookupstub.reason = false, "combat"
		Polestar.Fire("CODEX_LOADED")
		local combat = { kind = LK.shown.kind, rows = LK.shown.rows, empty = LK.shown.empty }
		emit({ filtered = filtered, combat = combat })"#);
	assert_eq!(out["filtered"], json!({ "kind": "mount", "rows": 0, "empty": "Nothing to list here." }));
	assert_eq!(out["combat"], json!({ "kind": "mount", "rows": 0, "empty": "The Codex loads when combat ends." }));
}

#[test]
fn a_search_with_no_matches_clears_the_selection_so_enter_acts_on_nothing() {
	let out = run(r#"
		UI.ShowLookup()
		LK.SetKind("item")
		local before = LK.Selected() and LK.Selected().id or false
		type_("zzzzzzz")
		stub.advance(0.3)
		local after, rows = LK.Selected() and LK.Selected().id or false, LK.shown.rows
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		local calls = #lookupstub.calls
		type_("")
		emit({ before = before ~= false, after = after, rows = rows, calls = calls,
			browsing = LK.Selected() ~= nil })"#);
	assert_eq!(out["before"], true, "browsing selects the first row");
	assert_eq!(out["after"], false);
	assert_eq!(out["rows"], 0);
	assert_eq!(out["calls"], 0, "Enter guides to nothing");
	assert_eq!(out["browsing"], true, "clearing the search selects the first row again");
}

#[test]
fn leaving_a_browse_list_for_an_empty_everything_drops_the_selection_enter_could_act_on() {
	let out = run(r#"
		UI.ShowLookup()
		LK.SetKind("item")
		local before = LK.Selected() ~= nil
		LK.SetKind("all")
		local after, rows = LK.Selected() ~= nil, LK.shown.rows
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ before = before, after = after, rows = rows, calls = #lookupstub.calls })"#);
	assert_eq!(out["before"], true);
	assert_eq!(out["rows"], 0, "no recent lookups");
	assert_eq!(out["after"], false, "nothing listed, nothing selected");
	assert_eq!(out["calls"], 0, "Enter guides to nothing");
}

#[test]
fn a_search_or_filter_that_lands_while_the_hub_is_closed_reconciles_the_selection_when_it_opens() {
	let out = run(r#"
		UI.ShowLookup()
		LK.SetKind("item")
		local before = LK.Selected() ~= nil
		type_("zzzzzzz")
		PolestarPicker:Hide()
		stub.advance(0.3)
		UI.ToggleLookup()
		local searched = { rows = LK.shown.rows, selected = LK.Selected() ~= nil }
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		local calls = #lookupstub.calls
		-- A filter changed while closed: the selected mount is retired.
		type_("")
		LK.SetKind("mount")
		local mount = LK.Selected()
		PolestarPicker:Hide()
		for _, e in ipairs(lookupstub.entities) do
			if e.kind == "mount" and e.id == mount.id then e.status = "retired" end
		end
		Polestar.Set("lookup.hideRetired", true)
		UI.ToggleLookup()
		local now = LK.Selected()
		emit({ before = before, searched = searched, calls = calls, mount = mount.id,
			now = now and now.id or false, nowKind = now and now.kind or false })"#);
	assert_eq!(out["before"], true);
	assert_eq!(out["searched"], json!({ "rows": 0, "selected": false }));
	assert_eq!(out["calls"], 0, "Enter guides to nothing");
	assert_ne!(out["now"], out["mount"], "the hidden mount is no longer selected");
}

#[test]
fn a_browse_list_waiting_for_combat_to_end_loads_the_codex_when_it_does() {
	let out = run(r#"
		UI.ShowLookup()
		local inCombat, loads = true, 0
		lookupstub.loaded, lookupstub.reason = false, "combat"
		Polestar.Codex.Load = function()
			loads = loads + 1
			if inCombat then return false, "combat" end
			lookupstub.loaded, lookupstub.reason = true, nil
			Polestar.Fire("CODEX_LOADED")
			return true
		end
		LK.SetKind("mount")
		local waiting = { kind = LK.shown.kind, rows = LK.shown.rows, empty = LK.shown.empty }
		local tried = loads
		inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ waiting = waiting, tried = tried, loads = loads, kind = LK.shown.kind, rows = LK.shown.rows,
			selected = LK.Selected() and LK.Selected().kind or false })"#);
	assert_eq!(out["waiting"], json!({ "kind": "mount", "rows": 0, "empty": "The Codex loads when combat ends." }));
	assert_eq!(out["loads"], out["tried"].as_i64().unwrap() + 1, "one more load, when combat ends");
	assert_eq!(out["kind"], "mount");
	assert!(out["rows"].as_i64().unwrap() > 0, "the mounts are listed");
	assert_eq!(out["selected"], "mount");
}

#[test]
fn items_waiting_for_combat_load_the_codex_when_the_hub_reopens_after_combat_ended_behind_it() {
	let out = run(r#"
		local loads = 0
		stub.inCombat = true
		lookupstub.loaded, lookupstub.reason = false, "combat"
		Polestar.Codex.Load = function()
			loads = loads + 1
			if stub.inCombat then return false, "combat" end
			lookupstub.loaded, lookupstub.reason = true, nil
			Polestar.Fire("CODEX_LOADED")
			return true
		end
		UI.ShowLookup()
		LK.SetKind("item")
		local waiting = { kind = LK.shown.kind, rows = LK.shown.rows, empty = LK.shown.empty }
		local tried = loads
		PolestarPicker:Hide()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		local hidden = loads
		UI.ShowPicker()
		emit({ waiting = waiting, tried = tried, hidden = hidden, loads = loads, section = Polestar.UI.Picker.Section(),
			kind = LK.shown.kind, rows = LK.shown.rows, empty = LK.shown.empty, list = #rowTexts(LK.results.Child),
			selected = LK.Selected() and LK.Selected().kind or false })"#);
	assert_eq!(out["waiting"], json!({ "kind": "item", "rows": 0, "empty": "The Codex loads when combat ends." }), "combat still says so while it lasts");
	assert_eq!(out["hidden"], out["tried"], "nothing loads while the hub is hidden");
	assert_eq!(out["section"], "Lookup");
	assert_eq!(out["kind"], "item");
	assert!(out["loads"].as_i64().unwrap() > out["tried"].as_i64().unwrap(), "the hub loads the Codex when it comes back");
	assert!(out["rows"].as_i64().unwrap() > 0, "the items are listed: {out}");
	assert!(out["list"].as_i64().unwrap() > 0, "and drawn");
	assert_eq!(out["selected"], "item");
}

#[test]
fn browsing_a_kind_pages_alphabetically_with_muted_entries_last_and_subtitles_only_for_drawn_rows() {
	let out = run(r#"
		lookupstub.many(46)
		UI.ShowLookup()
		LK.SetKind("mount")
		local scroll, W = LK.results, Polestar.Widgets
		local page = { rows = LK.shown.rows, painted = LK.painted, subtitled = lookupstub.subtitled,
			title = PolestarPicker.Title:GetText(), sub = PolestarPicker.Subtitle:GetText(), top = rowTexts(scroll.Child)[1] }
		W.ScrollTo(scroll, scroll.psContent - scroll.psView)
		stub.RunScript(scroll, "OnVerticalScroll", scroll:GetVerticalScroll())
		local more = rowFor(scroll.Child, "Show more (3 more)")
		if more then more:Click() end
		W.ScrollTo(scroll, scroll.psContent - scroll.psView)
		stub.RunScript(scroll, "OnVerticalScroll", scroll:GetVerticalScroll())
		local tail = rowTexts(scroll.Child)
		local chips = {}
		for _, title in ipairs({ "Reins of the Frostsaber", "Reins of the Shadowsaber" }) do
			local r = rowFor(scroll.Child, title)
			chips[#chips + 1] = r and r.Status:IsShown() and r.Status.Text:GetText() or false
		end
		emit({ page = page, rows = LK.shown.rows, last = { tail[#tail - 2], tail[#tail - 1], tail[#tail] }, chips = chips,
			browsed = lookupstub.browsed, queries = lookupstub.queries, subtitled = lookupstub.subtitled })"#);
	assert_eq!(out["page"]["rows"], 50);
	assert_eq!(out["page"]["title"], "Mounts");
	assert_eq!(out["page"]["sub"], "53, from A to Z");
	assert_eq!(out["page"]["top"], "Deathcharger's Reins");
	assert_eq!(out["page"]["painted"], out["page"]["subtitled"]);
	assert!(out["page"]["subtitled"].as_u64().unwrap() < 50);
	assert_eq!(out["rows"], 53);
	assert_eq!(out["last"], json!(["Steed 046", "Reins of the Frostsaber", "Reins of the Shadowsaber"]));
	assert_eq!(out["chips"], json!(["No longer obtainable", "No known source"]));
	assert_eq!(out["browsed"], 2);
	assert_eq!(out["queries"], 0);
	assert!(out["subtitled"].as_u64().unwrap() < 53);
}

#[test]
fn typing_in_a_kind_uses_relevance_and_clearing_restores_alphabetical_browsing() {
	let out = run(r#"
		UI.ShowLookup()
		LK.SetKind("mount")
		local top = rowTexts(LK.results.Child)[1]
		type_("saber"); stub.advance(0.3)
		local matched = { top = rowTexts(LK.results.Child)[1], keys = navKeys() }
		type_("")
		emit({ top = top, matched = matched, kind = LK.Kind(), cleared = rowTexts(LK.results.Child)[1],
			selected = LK.Selected() and LK.Selected().id })"#);
	assert_eq!(out["top"], "Deathcharger's Reins");
	assert_eq!(out["matched"], json!({ "top": "Reins of the Striped Frostsaber", "keys": ["all", "mount", "item", "quest"] }));
	assert_eq!(out["kind"], "mount");
	assert_eq!(out["cleared"], out["top"]);
	assert_eq!(out["selected"], 13335);
}

#[test]
fn browsing_selects_the_first_row_and_supports_arrows_enter_click_and_double_click() {
	let out = run(r#"
		table.insert(lookupstub.entities, { kind = "item", id = 100001, title = "Axe" })
		UI.ShowLookup()
		LK.SetKind("item")
		local first = LK.Selected() and LK.Selected().id
		local box = Polestar.UI.Picker.search
		stub.RunScript(box, "OnArrowPressed", "DOWN")
		local down = LK.Selected() and LK.Selected().id
		stub.RunScript(box, "OnArrowPressed", "UP")
		local up, recent = LK.Selected() and LK.Selected().id, #LK.Recent()
		local body = LK.results.Child
		local fang = rowFor(body, "Sabertooth Fang")
		if fang then fang:Click() end
		local clicked = LK.Recent()[1] and LK.Recent()[1].id
		stub.RunScript(box, "OnEnterPressed")
		local entered = lookupstub.calls[1] and lookupstub.calls[1][2]
		local axe = rowFor(body, "Axe")
		if axe then stub.RunScript(axe, "OnDoubleClick") end
		emit({ first = first, down = down, up = up, recent = recent, clicked = clicked,
			entered = entered, double = lookupstub.calls[2] and lookupstub.calls[2][2] })"#);
	assert_eq!(out, json!({ "first": 100001, "down": 4386, "up": 100001, "recent": 0, "clicked": 4386, "entered": 4386, "double": 100001 }));
}

#[test]
fn every_kind_including_zones_and_treasures_can_be_scrolled_to_and_clicked() {
	let out = run(r#"
		fillKinds()
		UI.ShowLookup()
		PolestarPicker:SetHeight(440)
		Polestar.UI.Picker.Render()
		local scroll = PolestarPicker.NavScroll
		local scrolled, clicked = {}, {}
		local keys = navKeys()
		for _, key in ipairs(keys) do
			local b = nav(key)
			local y = -select(5, b:GetPoint(1))
			Polestar.Widgets.ScrollTo(scroll, math.min(y, math.max(0, scroll.psContent - scroll.psView)))
			local top = scroll:GetVerticalScroll()
			assert(y >= top and y + b:GetHeight() <= top + scroll.psView, key .. " is in the sidebar viewport")
			b:Click()
			clicked[#clicked + 1] = LK.Kind()
			scrolled[key] = top > 0
		end
		emit({ clicked = clicked, scrolled = scrolled })"#);
	assert_eq!(out["clicked"], json!(ALL_KINDS));
	assert_eq!(out["scrolled"]["zone"], true);
	assert_eq!(out["scrolled"]["treasure"], true);
}

#[test]
fn one_kind_shows_a_page_of_50_and_show_more_adds_the_next_only_the_rows_in_view_are_drawn_and_subtitled() {
	let out = run(r#"
		lookupstub.many(120)
		Polestar.Lookup.Show("steed")
		local all = { groups = LK.shown.groups, painted = LK.painted, subtitled = lookupstub.subtitled }
		LK.SetKind("mount")
		local page1 = { rows = LK.shown.rows, painted = LK.painted, more = rowTexts(LK.results.Child)[LK.painted] }
		LK.More()
		local page2 = LK.shown.rows
		LK.More()
		local page3 = { rows = LK.shown.rows, last = rowTexts(LK.results.Child)[LK.painted] }
		emit({ all = all, page1 = page1, page2 = page2, page3 = page3, subtitled = lookupstub.subtitled })"#);
	assert_eq!(out["all"]["groups"], json!([{ "kind": "mount", "count": 120, "shown": 5 }]));
	assert_eq!(out["page1"]["rows"], 50);
	assert!(out["page1"]["painted"].as_f64().unwrap() < 30.0, "drawn {} rows, not all 50", out["page1"]["painted"]);
	assert_eq!(out["page2"], 100);
	assert_eq!(out["page3"]["rows"], 120);
	assert!(out["subtitled"].as_f64().unwrap() < 60.0, "subtitles asked for {} rows, only those drawn", out["subtitled"]);
}

#[test]
fn a_to_z_holds_while_the_hub_is_open_and_closing_it_with_an_empty_search_resets_it() {
	let out = run(r#"
		local function at(q) type_(q); stub.advance(0.3); return LK.Order() end
		Polestar.Lookup.Show("ring")
		local picked = choose(rawget(LK.root, "SearchOrder"), "A to Z")
		local out = { picked = picked, chosen = LK.Order() }
		out.other = at("sword")
		out.kind = (function() LK.SetKind("item"); LK.SetKind("all"); return LK.Order() end)()
		out.emptied = at("")
		out.again = at("ring")
		PolestarPicker:Hide()
		UI.ToggleLookup()
		out.reopened = { order = LK.Order(), query = LK.Query(), shown = rawget(LK.root, "SearchOrder").Label:GetText() }
		at("")
		PolestarPicker:Hide()
		UI.ToggleLookup()
		out.closedEmpty = LK.Order()
		out.next = at("ring")
		out.stored = Polestar.GetStored("lookup.searchOrder") or false
		emit(out)"#);
	assert_eq!(out["picked"], true);
	assert_eq!(out["chosen"], "az");
	assert_eq!(out["other"], "az", "another search while open keeps it");
	assert_eq!(out["kind"], "az", "so does switching kinds");
	assert_eq!(out["emptied"], "az", "and emptying the box while open");
	assert_eq!(out["again"], "az");
	assert_eq!(out["reopened"], json!({ "order": "az", "query": "ring", "shown": "A to Z" }), "closed on a search: it comes back as it was");
	assert_eq!(out["closedEmpty"], "best", "closed with the box empty: Best match");
	assert_eq!(out["next"], "best");
	assert_eq!(out["stored"], false, "the order is not saved");
}

#[test]
fn everything_in_a_to_z_previews_each_kind_s_first_five_the_top_of_its_show_all_list() {
	let out = run(r#"
		for i = 1, 8 do
			table.insert(lookupstub.entities, { kind = "item", id = 92000 + i, title = ("Zeta Ring %d"):format(i) })
		end
		for i = 1, 3 do
			table.insert(lookupstub.entities, { kind = "item", id = 93000 + i, title = ("Alpha Ring %d"):format(i) })
		end
		Polestar.Lookup.Show("ring")
		local function items()
			local out = {}
			local rows = rowTexts(LK.results.Child)
			for _, t in ipairs(rows) do if t:find("Ring %d") then out[#out + 1] = t end end
			return out
		end
		local best = items()
		local picked = choose(rawget(LK.root, "SearchOrder"), "A to Z")
		local az = { rows = items(), kind = LK.shown.kind }
		LK.SetKind("item")
		local all = rowTexts(LK.results.Child)
		emit({ best = best, picked = picked, az = az, top = { all[1], all[2], all[3], all[4], all[5] } })"#);
	assert_eq!(out["picked"], true);
	assert_eq!(out["az"]["kind"], "all");
	assert_eq!(out["az"]["rows"], json!(["Alpha Ring 1", "Alpha Ring 2", "Alpha Ring 3", "Zeta Ring 1", "Zeta Ring 2"]));
	assert_eq!(out["top"], out["az"]["rows"], "Show all opens on the same five");
	assert_ne!(out["best"], out["az"]["rows"], "Best match previewed others");
}

#[test]
fn lookup_stat_picker_filters_aliases_and_applies_the_selected_stat() {
	let out = run_packed_lookup(
		&json!({ "items": {
			"71": { "name": "Trial Charm", "levelsSource": "client", "stats": { "36": 0 } },
			"72": { "name": "Trial Staff", "levelsSource": "client", "stats": { "136": 0 } },
			"73": { "name": "Trial Axe", "levelsSource": "client", "stats": { "128": 0 } }
		} }),
		r#"
		UI.ShowLookup()
		LK.SetKind("item")
		UI.Picker.search:ClearFocus()
		LK.root.Visibility:Click()
		local stat = assert(LK.root.FilterDrawer.Item.Stat, "the Stat control")
		assert(stat.Label:GetText() == "Any stat")
		local activated = 0
		LK.Activate = function() activated = activated + 1 end
		local function filter(text)
			local box = PolestarMenu.Filter
			if not box:HasFocus() then stub.RunScript(box, "OnMouseDown", "LeftButton") end
			assert(box:HasFocus())
			box:SetText(text)
			stub.RunScript(box, "OnTextChanged", true)
			return box
		end
		stat:Click()
		local menu = PolestarMenu
		assert(not menu.Filter:HasFocus(), "the filter takes the keys only once clicked")
		assert(menu:GetWidth() >= stat:GetWidth() and #menu.rows == 56)
		assert(menu.rows[1].Text:GetText() == "Any stat" and menu.rows[2].Text:GetText() == "Agility")
		local box = filter("unmatched")
		assert(menu.Empty:IsShown() and menu.Empty:GetText() == "Nothing matches.")
		stub.RunScript(box, "OnEnterPressed")
		assert(menu:IsShown() and LK.ItemFilters().stat == nil)
		filter("undead")
		assert(menuChoice("Attack Power vs Undead"))
		assert(menuChoice("Spell Damage vs Undead")):Click()
		assert(LK.Selected().id == 72 and LK.shown.rows == 1 and not menu:IsShown())
		assert(stat.Label:GetText() == "Spell Damage vs Undead")
		assert(Polestar.CharState().ui.lookupItemFilters.stat == 136)

		stat:Click()
		box = filter("aste rat")
		assert(menuChoice("Haste"), "an alias substring")
		stub.RunScript(box, "OnEnterPressed")
		assert(LK.ItemFilters().stat == 36 and LK.Selected().id == 71 and LK.shown.rows == 1)
		local order = LK.root.SearchOrder
		assert(choose(order, "Most Haste"))
		assert(rowFor(LK.results.Child, "Trial Charm").Sub:GetText() == "Amount unknown")
		assert(choose(stat, "Any stat") and LK.ItemFilters().stat == nil)
		assert(order.Label:GetText() == "Most Haste" and LK.shown.rows == 3, "the sort survives clearing its original filter")
		assert(activated == 0 and #LK.Recent() == 0)
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_most_draws_all_buckets_and_pages_in_preview_order_with_an_independent_filter() {
	let mut items = json!({
		"71": { "name": "Trial Unmeasured", "levelsSource": "client", "stats": { "7": 0, "31": 0 } },
		"72": { "name": "Trial Base", "levelsSource": "client", "stats": { "31": 0 } },
		"73": { "name": "Trial Aardvark" },
		"74": { "name": "Trial Retired", "status": "retired", "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 100, "31": 0 } },
		"75": { "name": "Trial Mount", "kind": "mount", "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 18 } }
	});
	for i in 1..=52 {
		items[(100 + i).to_string()] = json!({
			"name": format!("Trial Sword {i:02}"), "levelsSource": "client", "statAmountSource": "client", "stats": { "7": i }
		});
	}
	let out = run_packed_lookup(
		&json!({ "items": items, "quests": { "81": { "title": "Trial Quest" } } }),
		r#"
		UI.ShowLookup({ query = "tri" })
		LK.SetKind("item")
		local order = LK.root.SearchOrder
		assert(choose(order, "A to Z"))
		LK.More()
		assert(LK.shown.rows == 56)
		assert(choose(order, "Choose a stat…"))
		local box = PolestarMenu.Filter
		type_("trial")
		assert(LK.Query() == "tri", "the hub query is still waiting for the debounce")
		box:SetText("stamina")
		stub.RunScript(box, "OnTextChanged", true)
		stub.RunScript(box, "OnEnterPressed")
		assert(LK.Query() == "trial" and order.Label:GetText() == "Most Stamina" and LK.ItemFilters().stat == nil)
		assert(LK.shown.rows == 50 and LK.Selected().id == 74 and LK.results:GetVerticalScroll() == 0)
		assert(rowFor(LK.results.Child, "Trial Retired").Sub:GetText() == "100")

		local firstPage = bottom()
		assert(firstPage[#firstPage - 1] == "Trial Sword 04" and firstPage[#firstPage] == "Show more (6 more)")
		local scroll = LK.results:GetVerticalScroll()
		rowFor(LK.results.Child, "Show more (6 more)"):Click()
		assert(LK.shown.rows == 56 and LK.Selected().id == 74 and LK.results:GetVerticalScroll() == scroll)
		local tail = bottom()
		assert(table.concat(tail, "|", #tail - 5) ==
			"Trial Sword 03|Trial Sword 02|Trial Sword 01|Trial Unmeasured|Trial Base|Trial Aardvark")
		for _, sample in ipairs({ { "Trial Unmeasured", "Amount unknown" }, { "Trial Base", "No listed stat" },
			{ "Trial Aardvark", "Unknown" } }) do
			assert(rowFor(LK.results.Child, sample[1]).Sub:GetText() == sample[2])
		end

		LK.SetKind("all")
		assert(rowFor(LK.results.Child, "Trial Mount").Sub:GetText() == "18")
		local preview, top = {}, {}
		for _, row in ipairs(shownRows(LK.results.Child)) do
			if row.psResult and row.psResult.kind == "item" then preview[#preview + 1] = row.Title:GetText() end
		end
		assert(#preview == 5 and preview[1] == "Trial Retired")
		assert(rowFor(LK.results.Child, "Show all 56")):Click()
		local page = rowTexts(LK.results.Child)
		for i = 1, 5 do top[i] = page[i] end
		assert(table.concat(preview, "|") == table.concat(top, "|"))
		LK.SetKind("quest")
		assert(order.Label:GetText() == "A to Z")
		order:Click()
		assert(not menuChoice("Choose a stat…"))
		Polestar.Widgets.HideMenu()
		LK.SetKind("item")
		assert(order.Label:GetText() == "Most Stamina")

		LK.root.Visibility:Click()
		local stat = LK.root.FilterDrawer.Item.Stat
		stat:Click()
		box:SetText("hit rating")
		stub.RunScript(box, "OnTextChanged", true)
		stub.RunScript(box, "OnEnterPressed")
		assert(LK.ItemFilters().stat == 31 and LK.shown.rows == 3 and LK.Selected().id == 74)
		assert(order.Label:GetText() == "Most Stamina")
		assert(table.concat(rowTexts(LK.results.Child), "|") == "Trial Retired|Trial Unmeasured|Trial Base")
		assert(LK.root.FilterDrawer.Clear:IsVisible())
		LK.root.FilterDrawer.Clear:Click()
		assert(LK.ItemFilters().stat == nil and LK.shown.rows == 50 and LK.Selected().id == 74)
		assert(order.Label:GetText() == "Most Stamina")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_gear_sort_and_filters_suspend_outside_items_and_all() {
	let out = run_packed_lookup(
		&json!({ "items": {
			"71": { "name": "Trial Axe", "quality": 3, "slot": 13, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 1, "31": 0 } },
			"72": { "name": "Trial Sword", "quality": 3, "slot": 13, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 10, "31": 0 } },
			"73": { "name": "Trial Mace", "quality": 3, "slot": 13, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 100 } },
			"74": { "name": "Trial Shield", "quality": 3, "slot": 14, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 100, "31": 0 } },
			"75": { "name": "Trial A Steed", "kind": "mount", "quality": 3, "slot": 0, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 1 } },
			"76": { "name": "Trial Z Steed", "kind": "mount", "quality": 3, "slot": 0, "levelsSource": "client", "statAmountSource": "client", "stats": { "7": 100 } },
			"77": { "name": "Trial B Steed", "kind": "mount", "quality": 4, "slot": 0 }
		} }),
		r#"
		LK.SetItemFilters({ quality = { 3 }, slot = 13, stat = 31 })
		UI.ShowLookup({ query = "trial" })
		LK.SetKind("item")
		local order, filters, list = LK.root.SearchOrder, LK.root.Visibility, LK.results.Child
		assert(choose(order, "A to Z"))
		assert(choose(order, "Choose a stat…"))
		local box = PolestarMenu.Filter
		box:SetText("stamina")
		stub.RunScript(box, "OnTextChanged", true)
		stub.RunScript(box, "OnEnterPressed")
		filters:Click()
		local drawer = LK.root.FilterDrawer
		local item, fullHeight = drawer.Item, drawer:GetHeight()
		local slot, stat = item.Slot:GetParent(), item.Stat:GetParent()
		local gearHeight = slot:GetHeight() + stat:GetHeight()
		assert(order.Label:GetText() == "Most Stamina" and LK.shown.rows == 2 and rowTexts(list)[1] == "Trial Sword")
		assert(slot:IsVisible() and stat:IsVisible() and filters.Label:GetText() == "Filters (3)")

		order:Click()
		LK.SetKind("mount")
		assert(order.Label:GetText() == "A to Z" and LK.Order() == "most", "Mounts uses the base order")
		assert(not PolestarMenu:IsShown(), "the menu from Items closes on switching scope")
		order:Click()
		assert(menuChoice("Best match") and menuChoice("A to Z"))
		assert(not menuChoice("Most Stamina") and not menuChoice("Choose a stat…"))
		Polestar.Widgets.HideMenu()
		assert(not slot:IsShown() and not stat:IsShown() and drawer:GetHeight() == fullHeight - gearHeight)
		assert(item.Required:IsVisible() and item.Level:IsVisible() and item.Class:IsVisible() and item.Rarity:IsVisible())
		assert(filters.Label:GetText() == "Filters (1)" and LK.shown.rows == 2 and rowTexts(list)[1] == "Trial A Steed")
		assert(LK.ItemFilters().slot == 13 and LK.ItemFilters().stat == 31)
		type_("")
		assert(order.Label:GetText() == "A to Z" and LK.shown.rows == 2 and rowTexts(list)[1] == "Trial A Steed")
		type_("trial"); stub.advance(0.3)

		LK.SetKind("all")
		assert(order.Label:GetText() == "Most Stamina" and LK.shown.rows == 2 and rowTexts(list)[1] == "Trial Sword")
		assert(slot:IsVisible() and stat:IsVisible() and drawer:GetHeight() == fullHeight)
		LK.SetKind("item")
		assert(order.Label:GetText() == "Most Stamina" and LK.shown.rows == 2 and rowTexts(list)[1] == "Trial Sword")
		assert(item.Slot.Label:GetText() == "One-hand" and item.Stat.Label:GetText() == "Hit")
		assert(filters.Label:GetText() == "Filters (3)")
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_exact_ids_and_most_order_lifetime() {
	let out = run_packed_lookup(
		&json!({ "items": {
			"19019": { "name": "Trial Blade", "levelsSource": "client", "stats": { "36": 0 } },
			"71": { "name": "Replica 19019", "levelsSource": "client" }
		} }),
		r##"
		UI.ShowLookup({ query = "19019" })
		LK.SetKind("item")
		local order = LK.root.SearchOrder
		assert(LK.shown.rows == 2 and LK.Selected().id == 19019)
		local function query(q) type_(q); stub.advance(0.3) end
		query("#19019")
		assert(LK.shown.rows == 1 and LK.Selected().id == 19019)
		query("#71")
		assert(LK.shown.rows == 1 and LK.Selected().id == 71)
		query("#019019")
		assert(LK.shown.rows == 1 and LK.Selected().id == 19019)
		query("#1")
		assert(LK.shown.empty == "No item with that ID here." and LK.Selected() == nil)
		query("#abc")
		assert(LK.shown.empty == "Use # followed by an item ID." and LK.Selected() == nil)
		query("haste")
		assert(LK.shown.rows == 1 and LK.Selected().id == 19019)

		assert(choose(order, "Choose a stat…"))
		local filter = PolestarMenu.Filter
		filter:SetText("haste")
		stub.RunScript(filter, "OnTextChanged", true)
		stub.RunScript(filter, "OnEnterPressed")
		PolestarPicker:Hide()
		UI.ToggleLookup()
		assert(LK.Query() == "haste" and LK.Order() == "most" and order.Label:GetText() == "Most Haste")
		query("")
		assert(order.Label:GetText() == "Most Haste" and LK.Selected().id == 19019)
		PolestarPicker:Hide()
		UI.ToggleLookup()
		assert(LK.Order() == "best" and order:IsVisible() and order.Label:GetText() == "A to Z")
		order:Click()
		assert(menuChoice("A to Z") and not menuChoice("Best match") and not menuChoice("Most Haste"))
		Polestar.Widgets.HideMenu()
		LK.SetKind("all")
		assert(not order:IsVisible())
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn item_details_summarize_known_facts_from_mixed_sources() {
	let out = run_packed_lookup(
		&json!({"items": {
			"5200": {"name": "Impaling Harpoon", "reqLevel": 20, "itemLevel": 22, "quality": 3, "allowClass": 1503, "slot": 17, "itemClass": 2, "itemSubclass": 6,
				"levelsSource": "forever", "typeSource": "forever", "reqSource": "era", "qualitySource": "none"},
			"932": {"name": "Fel Steed Saddlebags", "reqLevel": 25, "quality": 3, "reqSource": "era", "qualitySource": "era"}
		}}),
		r##"
		ITEM_QUALITY3_DESC = "Client rare"
		local function open(id) UI.ShowLookup({ query = "#" .. id, kind = "item", id = id }) end
		local r, g, b = LK.QualityColor(3)
		local rarity = ("|cff%02x%02x%02xClient rare|r"):format(math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
		open(5200)
		local summary = assert(rawget(LK.details, "ItemSummary"), "expected a compact item summary")
		assert(summary:IsVisible() and summary:GetText() == rarity .. " · Item level 22 · Requires level 20")
		open(932)
		assert(summary:IsVisible() and summary:GetText() == rarity .. " · Requires level 25")
		local function matches(id, filters)
			return #Polestar.Search.Query("#" .. id, { ids = true, resultKind = "item", filters = filters }) == 1
		end
		assert(matches(5200, { reqMax = 20 }) and not matches(5200, { reqMax = 19 }))
		assert(matches(932, { quality = { [3] = true } }) and not matches(932, { quality = { [2] = true } }))
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn item_details_add_only_the_selected_items_cached_tooltip_lines() {
	let out = run_packed_lookup(
		&json!({"items": {
			"5200": {"name": "Impaling Harpoon", "quality": 3, "reqLevel": 20, "itemLevel": 22,
				"itemClass": 2, "itemSubclass": 6, "slot": 17, "allowClass": 1,
				"levelsSource": "forever", "typeSource": "forever", "statAmountSource": "forever", "stats": {"7": 8}},
			"647": {"name": "Destiny", "reqLevel": 52, "levelsSource": "forever"}
		}}),
		r##"
		Polestar.Compat.ItemTooltipLines = realCompat.ItemTooltipLines
		local cached, requests, data, reads = {}, {}, {}, 0
		C_Item = {
			IsItemDataCachedByID = function(id) return cached[id] == true end,
			RequestLoadItemDataByID = function(id) requests[id] = true end,
		}
		C_TooltipInfo = { GetItemByID = function(id) reads = reads + 1; return data[id] end }
		Enum.TooltipDataLineType = { None = 0, ItemName = 22, ItemLevel = 31, ItemQuality = 35, EquipSlot = 21, UsageRequirement = 43 }
		ITEM_CLASSES_ALLOWED, ITEM_MIN_LEVEL = "Classes admises (%s)", "Niveau %d requis"
		RETRIEVING_ITEM_INFO = "Retrieving item information"
		local function line(text, kind, right, color)
			return { leftText = text, type = kind or 0, rightText = right, leftColor = color }
		end
		data[5200] = { id = 5200, lines = {
			line("Impaling Harpoon", 22), line("Rare", 35), line("Item Level 22", 31), line("Two-Hand", 21, "Polearm"),
			line("Classes admises (Guerrier)", 43), line("Niveau 20 requis", 43), line("+8 Stamina"),
			line("Binds when picked up", 20), line("Unique"), line("92 Armor"),
			line("30 - 40 Damage", 0, "Speed 2.00"), line("(17.5 damage per second)"), line("Durability 60 / 60"),
			line("Use: Summon a companion.", 44), line("Equip: Improves your chance to hit.", 45, nil, { r = 0, g = 1, b = 0 }),
			line("A test set (0/2)"), line("  A test piece"), line("(2) Set: Improves your chance to hit."),
			line('"Test flavor text."', 37),
		} }
		local function open(id) UI.ShowLookup({ query = "#" .. id, kind = "item", id = id }) end
		local function shown()
			local result = {}
			for _, row in ipairs(rawget(LK.details, "TooltipRows") or {}) do
				if row.Left:IsVisible() then result[#result + 1] = row.Left:GetText() end
			end
			return table.concat(result, "\n")
		end
		open(5200)
		local d = LK.details
		local compact = d.Scroll.psContent
		assert(requests[5200], "selected item requested")
		assert(shown() == "", "no game lines before caching")
		assert(d.StatRows[1]:GetText() == "+8 Stamina", d.StatRows[1]:GetText())
		cached[5200] = true
		local before = reads
		stub.fire("GET_ITEM_INFO_RECEIVED", 647, true)
		stub.fire("GET_ITEM_INFO_RECEIVED", 5200, false)
		assert(reads == before and shown() == "")
		local hovered = CreateFrame("Frame")
		GameTooltip:SetOwner(hovered, "ANCHOR_RIGHT")
		GameTooltip:SetText("Another tooltip")
		stub.fire("GET_ITEM_INFO_RECEIVED", 5200, true)
		assert(GameTooltip:GetOwner() == hovered and GameTooltip.lines[1] == "Another tooltip")
		assert(shown() == table.concat({ "Binds when picked up", "Unique", "92 Armor", "30 - 40 Damage",
			"(17.5 damage per second)", "Durability 60 / 60", "Use: Summon a companion.", "Equip: Improves your chance to hit.",
			"A test set (0/2)", "  A test piece", "(2) Set: Improves your chance to hit.", '"Test flavor text."' }, "\n"), shown())
		local damage, equip = d.TooltipRows[4], d.TooltipRows[8]
		local function y(region) return select(5, region:GetPoint(1)) end
		assert(damage.Right:IsVisible() and damage.Right:GetText() == "Speed 2.00" and y(damage.Left) == y(damage.Right))
		local r, g, b = equip.Left:GetTextColor()
		assert(r == 0 and g == 1 and b == 0 and equip.Left:GetWidth() > damage.Left:GetWidth())
		assert(d.Scroll.psContent > compact and y(d.StatRows[1]) > y(d.TooltipRows[1].Left) and y(d.ItemHead) < y(d.TooltipRows[12].Left))
		open(647)
		assert(requests[647] and shown() == "" and not damage.Right:IsShown())
		before = reads
		stub.fire("GET_ITEM_INFO_RECEIVED", 5200, true)
		assert(reads == before and shown() == "")
		cached[647], data[647] = true, data[5200]
		stub.fire("GET_ITEM_INFO_RECEIVED", 647, true)
		assert(shown() == "", "tooltip for the wrong item")
		data[647] = { id = 647, lines = { line("Destiny", 22), line(RETRIEVING_ITEM_INFO), line("Stale tooltip row") } }
		stub.fire("GET_ITEM_INFO_RECEIVED", 647, true)
		assert(shown() == "", "retrieving placeholder")
		data[647] = { id = 647, lines = { line("Destiny", 22), line("Binds when equipped", 20) } }
		PolestarPicker:Hide()
		before = reads
		stub.fire("GET_ITEM_INFO_RECEIVED", 647, true)
		assert(reads == before)
		open(647)
		assert(shown() == "Binds when equipped" and not damage.Right:IsShown())
		cached[647] = false
		LK.Render()
		assert(shown() == "", "previously cached rows are cleared when the cache misses")
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn item_details_keep_legacy_facts_when_the_tooltip_arrives() {
	let out = run_packed_lookup(
		&json!({"items": { "647": {"name": "Destiny", "quality": 4, "reqLevel": 52, "levelsSource": "client"} }}),
		r##"
		Polestar.Compat.ItemTooltipLines = realCompat.ItemTooltipLines
		Polestar.Codex.HasFilters = function() return false end
		local cached = false
		ITEM_MIN_LEVEL = "Requires Level %d"
		C_Item = { IsItemDataCachedByID = function() return cached end }
		C_TooltipInfo = { GetItemByID = function(id) return { id = id, lines = {
			{ leftText = "Destiny" }, { leftText = "Binds when equipped" }, { leftText = "Requires Level 52" },
		} } end }
		UI.ShowLookup({ query = "#647", kind = "item", id = 647 })
		local d = LK.details
		assert(LK.detail.facts[1][1] == "Type" and LK.detail.facts[2][2] == "Level 52")
		assert(rawget(d, "TooltipRows") == nil)
		cached = true
		stub.fire("GET_ITEM_INFO_RECEIVED", 647, true)
		assert(LK.detail.facts[1][1] == "Type" and LK.detail.facts[2][2] == "Level 52")
		assert(d.TooltipRows[1].Left:IsVisible() and d.TooltipRows[1].Left:GetText() == "Binds when equipped")
		assert(#d.TooltipRows == 1)
		assert(not d.ItemSummary:IsShown() and d.ItemHead.Text:GetText() == "Where to get it")
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn item_details_scroll_facts_stats_and_sources_with_the_acquisition_action_pinned() {
	let out = run_packed_lookup(
		&json!({"items": {
			"19019": {"name": "Thunderfury", "reqLevel": 0, "itemLevel": 80, "quality": 0,
				"allowClass": 1503, "slot": 13, "itemClass": 2, "itemSubclass": 7,
				"levelsSource": "client", "typeSource": "era", "statAmountSource": "era",
				"stats": {"4": 9, "7": 8, "31": 0, "51": 8, "52": 8, "54": 8, "55": 8, "56": 8, "136": 0},
				"sources": [{"type": "vendor", "npc": 4730}, {"type": "vendor", "npc": 4731}, {"type": "vendor", "npc": 4732}]},
			"647": {"name": "Destiny", "reqLevel": 52, "itemLevel": 57, "quality": 4,
				"allowClass": 1503, "slot": 0, "itemClass": 4, "levelsSource": "era", "typeSource": "forever",
				"statAmountSource": "era", "stats": {"7": 3}},
			"6948": {"name": "Hearthstone", "allowClass": 0, "slot": 0, "levelsSource": "client"},
			"71": {"name": "Unidentified", "itemClass": 42, "itemSubclass": 44, "typeSource": "forever"},
			"72": {"name": "Ahn'Qiraj Wand [PH]", "reqLevel": 60, "quality": 4, "levelsSource": "era"},
			"73": {"name": "Trial Recipe", "kind": "recipe", "reqLevel": 10, "itemLevel": 20,
				"allowClass": 1503, "itemClass": 9, "itemSubclass": 2,
				"levelsSource": "client", "typeSource": "forever"}
		}, "npcs": {
			"4730": {"name": "Trial Vendor", "spawns": [{"map": 1432, "x": 50, "y": 50}]},
			"4731": {"name": "Second Vendor", "spawns": [{"map": 1432, "x": 51, "y": 51}]},
			"4732": {"name": "Third Vendor", "spawns": [{"map": 1432, "x": 52, "y": 52}]}
		}}),
		r##"
		ITEM_QUALITY0_DESC, ITEM_QUALITY4_DESC = nil, "Client epic"
		local function open(id, kind) UI.ShowLookup({ query = "#" .. id, kind = kind or "item", id = id }) end
		open(19019)
		local d, W = LK.details, Polestar.Widgets
		local function summary()
			return d.ItemSummary:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
		end
		local function stat(text)
			for _, line in ipairs(d.StatRows) do
				if line:IsShown() and line:GetText() == text then return line end
			end
		end
		local function statCount()
			local count = 0
			for _, line in ipairs(d.StatRows) do if line:IsShown() then count = count + 1 end end
			return count
		end
		assert(summary() == "Poor · Item level 80 · No level required")
		assert(d.ItemSlot:GetText() == "One-hand" and d.ItemSubtype:GetText() == "Sword")
		local function x(line) return select(4, line:GetPoint(1)) end
		local function y(line) return select(5, line:GetPoint(1)) end
		assert(x(d.ItemSlot) < x(d.ItemSubtype) and y(d.ItemSlot) == y(d.ItemSubtype))
		local classes = {}
		for _, token in ipairs({ "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "MAGE", "WARLOCK" }) do
			classes[#classes + 1] = UI.ClassName(token)
		end
		assert(d.ItemClasses:GetText() == "Classes: " .. table.concat(classes, ", "))
		assert(rawget(d, "Stats") == nil and d.StatMore:IsShown() and d.StatMore.Label:GetText() == "Show all")
		assert(statCount() == 8 and colorIs(assert(stat("Hit")), "textMuted"))
		assert(y(d.ItemSummary) > y(d.ItemSlot) and y(d.ItemSlot) > y(d.ItemClasses) and y(d.ItemClasses) > y(d.StatRows[1]))
		assert(x(d.StatRows[1]) < x(d.StatRows[2]) and y(d.StatRows[1]) == y(d.StatRows[2]))
		assert(x(d.StatRows[1]) == x(d.StatRows[3]) and y(d.StatRows[1]) > y(d.StatRows[3]))
		assert(d.ItemFactsPanel:GetParent() == d.Scroll.Child and d.ItemHead.Text:GetText() == "Where to get it")
		assert(d.Primary:IsShown() and d.Primary:GetParent() == d, "pinned acquisition button")
		local _, pinnedTo, _, _, pinnedY = d.Primary:GetPoint(1)
		local compact = d.Scroll.psContent
		d.StatMore:Click()
		assert(statCount() == 9 and d.StatMore.Label:GetText() == "Show fewer")
		assert(d.Scroll.psContent > compact and d.Scroll.psContent > d.Scroll.psView)
		assert(colorIs(assert(stat("+8 Stamina")), "text"))
		local firstSource = d.Rows[1]
		assert(firstSource:GetParent() == d.Scroll.Child)
		W.ScrollTo(d.Scroll, d.Scroll.psContent)
		local at = d.Scroll:GetVerticalScroll()
		assert(at > 0)
		firstSource:Click()
		assert(firstSource.Guide:IsShown())
		at = d.Scroll:GetVerticalScroll()
		LK.Render()
		assert(stat("+8 Stamina"):IsVisible() and at > 0 and d.Scroll:GetVerticalScroll() == at)
		local _, stillPinned, _, _, stillY = d.Primary:GetPoint(1)
		assert(stillPinned == pinnedTo and stillY == pinnedY)
		d.StatMore:Click()
		assert(statCount() == 8 and d.StatMore.Label:GetText() == "Show all")
		d.StatMore:Click()
		assert(statCount() == 9)
		open(647)
		assert(d.Scroll:GetVerticalScroll() == 0 and not d.StatMore:IsShown())
		assert(summary() == "Client epic · Item level 57 · Requires level 52")
		assert(d.ItemSlot:GetText() == "Non-equippable" and not d.ItemSubtype:IsShown() and not d.ItemClasses:IsShown())
		assert(statCount() == 1 and stat("+3 Stamina"))
		open(19019)
		assert(d.StatMore.Label:GetText() == "Show all" and statCount() == 8 and d.Scroll:GetVerticalScroll() == 0)
		open(6948)
		assert(d.ItemClasses:IsShown() and d.ItemClasses:GetText() == "Classes: None of these classes")
		open(71)
		assert(not d.ItemSummary:IsShown() and not d.ItemSlot:IsShown() and not d.ItemClasses:IsShown())
		assert(d.ItemSubtype:IsShown() and d.ItemSubtype:GetText() == "Type 44" and statCount() == 0)
		open(73, "recipe")
		assert(summary() == "Item level 20 · Requires level 10")
		assert(d.ItemSubtype:IsShown() and d.ItemSubtype:GetText() == "Tailoring" and not d.ItemClasses:IsShown())
		open(72)
		assert(summary() == "Client epic")
		assert(not d.ItemSlot:IsShown() and not d.ItemSubtype:IsShown() and not d.ItemClasses:IsShown() and statCount() == 0)
		local link
		GameTooltip.SetHyperlink = function(_, value) link = value end
		stub.RunScript(d.Well, "OnEnter")
		assert(link == "item:72")
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_pack_compatibility_keeps_legacy_details_and_drops_most_without_supported_data() {
	for version in [0, 2] {
		let out = run_packed_lookup(
			&json!({"items": {
				"647": {"name": "Destiny", "reqLevel": 52, "quality": 4, "levelsSource": "client",
					"statAmountSource": "era", "stats": {"7": 8}},
				"932": {"name": "Fel Steed Saddlebags", "reqLevel": 25, "quality": 3, "reqSource": "era"}
			}}),
			&format!(
				r##"
			local register = Polestar.Codex.RegisterFilters
			Polestar.Codex.RegisterFilters = function(_, ...) register({version}, ...) end
			LK.SetItemFilters({{ reqMax = 0, stat = 7 }})
			UI.ShowLookup({{ query = "#647" }})
			assert(LK.Selected().id == 647 and LK.ItemFilters().reqMax == 0)
			assert(LK.detail.facts[1][1] == "Type" and LK.detail.facts[2][1] == "Requires" and LK.detail.facts[2][2] == "Level 52")
			LK.root.Visibility:Click()
			local drawer, order = LK.root.FilterDrawer, LK.root.SearchOrder
			assert(drawer:GetHeight() == drawer.Status:GetHeight() + drawer.Clear:GetHeight() + 8 + ({version} == 0 and 36 or 0) and not rawget(drawer, "Item") and #drawer.Availability == 2)
			local note = rawget(drawer, "Compatibility")
			assert((note and note:IsShown() or false) == ({version} == 0))
			order:Click()
			assert(menuChoice("Best match") and menuChoice("A to Z"))
			assert(not menuChoice("Most Stamina") and not menuChoice("Choose a stat…"))
			UI.ShowLookup({{ query = "#932" }})
			assert(Polestar.Codex.Item(932).reqLevelFallback)
			assert(LK.detail.facts[1][1] == "Type" and LK.detail.facts[2][1] == "Sources" and #LK.detail.facts == 2)
			emit(true)
			"##
			),
		);
		assert_eq!(out, json!(true));
	}
}

#[test]
fn lookup_most_carries_into_search_but_a_to_z_chosen_in_browse_does_not() {
	let out = run_packed_lookup(
		&json!({"items": {
			"647": {"name": "A Destiny", "levelsSource": "era", "statAmountSource": "era", "stats": {"7": 8}},
			"19019": {"name": "Destiny", "levelsSource": "client", "statAmountSource": "era", "stats": {"7": 6}}
		}}),
		r#"
		UI.ShowLookup({ query = "" })
		LK.SetKind("item")
		LK.SetItemFilters({ stat = 7 })
		local order = LK.root.SearchOrder
		assert(choose(order, "Most Stamina"))
		type_("Destiny"); stub.advance(0.3)
		assert(order.Label:GetText() == "Most Stamina")
		type_("")
		assert(choose(order, "A to Z"))
		type_("Destiny"); stub.advance(0.3)
		assert(order.Label:GetText() == "Best match" and rowTexts(LK.results.Child)[1] == "Destiny", "Best match ranks the exact name first")
		assert(choose(order, "Most Stamina"))
		-- Simulate returning to a pack without stat data while Most is selected.
		Polestar.Codex.HasFilters = function() return false end
		Polestar.Codex.StatGeneration = function() return nil end
		Polestar.Fire("CODEX_LOADED")
		assert(LK.Order() == "best" and order.Label:GetText() == "Best match")
		order:Click()
		assert(not menuChoice("Choose a stat…") and not menuChoice("Most Stamina"))
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_menu_search_folds_raw_aliases_independently() {
	let out = run_packed_lookup(
		&json!({"items": {"647": {"name": "Destiny"}}}),
		r#"
		UI.ShowLookup({ query = "Destiny" })
		local items = { { text = "Example stat", searchText = "Fire-Resistance\nShadow Protection" } }
		for i = 1, 12 do items[#items + 1] = { text = "Other stat " .. i } end
		Polestar.Widgets.ShowMenu(LK.root.SearchOrder, items, { searchFold = function(s) return Polestar.Search.Fold(s):sub(2) end })
		local box = PolestarMenu.Filter
		box:SetText("fire resistance")
		stub.RunScript(box, "OnTextChanged", true)
		assert(menuChoice("Example stat"))
		box:SetText("resistance shadow")
		stub.RunScript(box, "OnTextChanged", true)
		assert(not menuChoice("Example stat"))
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_direct_open_outside_filters_allows_detail_actions_until_list_interaction() {
	let out = run_packed_lookup(
		&json!({"items": {
			"647": {"name": "Trial Destiny", "reqLevel": 52, "levelsSource": "era", "itemClass": 2, "itemSubclass": 8,
				"sources": [{"type": "vendor", "npc": 4730}]},
			"19019": {"name": "Trial Thunderfury", "reqLevel": 0, "levelsSource": "client", "itemClass": 4}
		}, "npcs": {"4730": {"name": "Trial Vendor", "spawns": [{"map": 1432, "x": 50, "y": 50}]}}}),
		r##"
		LK.SetItemFilters({ reqMax = 0 })
		UI.ShowLookup({ query = "#647", kind = "item", id = 647 })
		local d = LK.details
		assert(LK.Selected().id == 647 and LK.shown.rows == 0)
		assert(d.Outside:IsVisible() and d.Outside:GetText() == "This item is outside the current filters.")
		local action
		Polestar.Lookup.Guide = function(k, id, i) action = { k, id, i } end
		d.Rows[1]:Click()
		assert(d.Rows[1].Guide:IsVisible() and d.Outside:IsVisible(), "explicit source selection keeps the exception")
		d.Rows[1].Guide:Click()
		assert(action[1] == "item" and action[2] == 647 and action[3] == 1)
		LK.Render()
		assert(d.Outside:IsVisible())
		action = nil
		stub.RunScript(UI.Picker.search, "OnEnterPressed")
		assert(not action and LK.Selected() == nil and not d.Outside:IsVisible())
		UI.ShowLookup({ query = "trial", kind = "item", id = 647 })
		assert(LK.Selected().id == 647 and d.Outside:IsVisible())
		LK.Step(1)
		assert(LK.Selected().id == 19019 and not d.Outside:IsVisible())
		UI.ShowLookup({ query = "#19019", kind = "item", id = 19019 })
		assert(LK.Selected().id == 19019 and not d.Outside:IsVisible())
		UI.ShowLookup({ query = "trial", kind = "item", id = 647 })
		assert(LK.Kind() == "all" and LK.Selected().id == 647 and d.Outside:IsVisible())
		type_("Thunderfury"); stub.advance(0.3)
		assert(LK.Selected().id == 19019 and not d.Outside:IsVisible())
		emit(true)
		"##,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn lookup_direct_open_clears_the_category_and_lists_the_selected_item() {
	let out = run_packed_lookup(
		&json!({"items": {
			"647": {"name": "Trial Sword", "itemClass": 2, "itemSubclass": 8},
			"19019": {"name": "Trial Robe", "itemClass": 4, "itemSubclass": 1}
		}}),
		r#"
		UI.ShowLookup({ query = "trial" })
		nav("item").Toggle:Click()
		nav("item:4").Toggle:Click()
		nav("item:4:1"):Click()
		assert(select(2, LK.Nav()) == "item:4:1")
		assert(LK.shown.rows == 1 and rowFor(LK.results.Child, "Trial Robe"))
		UI.ShowLookup({ kind = "item", id = 647 })
		assert(LK.Kind() == "all" and select(2, LK.Nav()) == "all")
		assert(LK.Selected().id == 647 and LK.shown.rows == 1 and rowFor(LK.results.Child, "Trial Sword"))
		emit(true)
		"#,
	);
	assert_eq!(out, json!(true));
}

#[test]
fn search_dropdown_restarts_the_kind_list_and_shows_a_to_z_when_browsing_items() {
	let out = run(r#"
		for i = 239, 1, -1 do
			table.insert(lookupstub.entities, { kind = "item", id = 90000 + i, title = ("Ring %03d"):format(i) })
		end
		table.insert(lookupstub.entities, { kind = "item", id = 91000, title = "A Ring", status = "retired" })
		table.insert(lookupstub.entities, { kind = "item", id = 91001, title = "B Ring", status = "nosource" })
		Polestar.Lookup.Show("ring")
		local order = rawget(LK.root, "SearchOrder")
		local onAll = order and order:IsVisible() or false
		LK.SetKind("item")
		local controls = {}
		for _, button in ipairs(Polestar.Gamepad.Collect(PolestarPicker)) do
			if button == order:GetParent() then controls[button.Label:GetText()] = order.Label:GetText() end
			if button == LK.root.Visibility then controls[button.Label:GetText()] = true end
		end
		local before = { rowTexts(LK.results.Child)[1], nav("item").Count:GetText(), LK.Selected().id }
		LK.More()
		bottom()
		local picked = choose(order, "A to Z")
		local after = { rowTexts(LK.results.Child)[1], nav("item").Count:GetText(), LK.shown.rows,
			PolestarPicker.Subtitle:GetText(), LK.results:GetVerticalScroll() }
		local pages, tails = {}, {}
		for _, left in ipairs({ 191, 141, 91, 41 }) do
			local tail = bottom()
			tails[#tails + 1] = { tail[#tail - 1], tail[#tail] }
			local more = rowFor(LK.results.Child, ("Show more (%d more)"):format(left))
			if more then more:Click() end
			pages[#pages + 1] = LK.shown.rows
		end
		local tail = bottom()
		local last = { tail[#tail - 2], tail[#tail - 1], tail[#tail] }
		local kept = LK.Order()
		type_("")
		emit({ before = before, picked = picked, after = after, pages = pages, tails = tails, last = last, onAll = onAll,
			onEmpty = order and order:IsVisible() and order.Label:GetText() or false, kept = kept, emptied = LK.Order(), controls = controls })"#);
	assert_eq!(out["picked"], true);
	assert_eq!(out["onAll"], true, "Everything's search offers the order too");
	assert_eq!(out["onEmpty"], "A to Z");
	assert_eq!(out["kept"], "az", "paging keeps the search's order");
	assert_eq!(out["emptied"], "az", "the hub is still open");
	assert_eq!(out["controls"], json!({ "Sort by": "Best match", "Filters": true }));
	assert_eq!(out["before"], json!(["Ring 239", "241", 90239]));
	assert_eq!(out["after"], json!(["Ring 001", "241", 50, "241 results for “ring”", 0]));
	assert_eq!(out["pages"], json!([100, 150, 200, 241]));
	assert_eq!(out["tails"], json!([["Ring 050", "Show more (191 more)"], ["Ring 100", "Show more (141 more)"], ["Ring 150", "Show more (91 more)"], ["Ring 200", "Show more (41 more)"]]));
	assert_eq!(out["last"], json!(["Ring 239", "A Ring", "B Ring"]));
}

#[test]
fn lookup_visibility_drawer_filters_each_status_independently_in_browse_and_search() {
	let out = run(r#"
		lookupstub.many(50)
		for i, status in ipairs({ "retired", "nosource" }) do
			table.insert(lookupstub.entities, { kind = "mount", id = 92000 + i, title = "Steed " .. status, status = status })
		end
		UI.ShowLookup()
		local filters = rawget(LK.root, "Visibility")
		local onRecent = filters and filters:IsShown() or false
		LK.SetKind("mount")
		filters:Click()
		local function toggle(i) LK.root.FilterDrawer.Availability[i]:Click(); return true end
		local retired, nosource = 1, 2
		local function counts()
			local tail = bottom()
			return { nav("mount").Count:GetText(), PolestarPicker.Subtitle:GetText(), tail[#tail] }
		end
		local browseRetired = toggle(retired) and counts()
		LK.More()
		local tail = bottom()
		local browseTail = tail[#tail]
		local browseSource = toggle(retired) and toggle(nosource) and counts()
		LK.More()
		tail = bottom()
		local browseSourceTail = tail[#tail]
		type_("steed"); stub.advance(0.3)
		local searchSource = counts()
		LK.More()
		tail = bottom()
		local searchSourceTail = tail[#tail]
		local searchBoth = toggle(retired) and counts()
		local searchRetired = toggle(nosource) and counts()
		LK.More()
		tail = bottom()
		local searchRetiredTail = tail[#tail]
		LK.SetKind("all")
		local all = { nav("all").Count:GetText(), LK.shown.groups[1].count }
		local restored = toggle(retired) and { nav("all").Count:GetText(), LK.shown.groups[1].count }
		emit({ onRecent = onRecent, browseRetired = browseRetired, browseTail = browseTail, browseSource = browseSource,
			browseSourceTail = browseSourceTail, searchSource = searchSource, searchSourceTail = searchSourceTail,
			searchRetired = searchRetired, searchRetiredTail = searchRetiredTail, searchBoth = searchBoth,
			all = all, restored = restored })
	"#);
	assert_eq!(out["onRecent"], true);
	assert_eq!(out["browseRetired"], json!(["57", "57, from A to Z", "Show more (7 more)"]));
	assert_eq!(out["browseTail"], "Steed nosource");
	assert_eq!(out["browseSource"], out["browseRetired"]);
	assert_eq!(out["browseSourceTail"], "Steed retired");
	assert_eq!(out["searchSource"], json!(["51", "51 results for “steed”", "Show more (1 more)"]));
	assert_eq!(out["searchSourceTail"], "Steed retired");
	assert_eq!(out["searchBoth"], json!(["50", "50 results for “steed”", "Steed 050"]));
	assert_eq!(out["searchRetired"], out["searchSource"]);
	assert_eq!(out["searchRetiredTail"], "Steed nosource");
	assert_eq!(out["all"], json!(["51", 51]));
	assert_eq!(out["restored"], json!(["52", 52]));
}

#[test]
fn kind_tab_keystrokes_and_show_more_with_a_25_000_entry_codex_in_both_orders() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		script: format!(
			r#"
			uistub.install()
			stub.login()
			local UI, LK = Polestar.UI, Polestar.UI.Lookup
			{HELPERS}
			local lines, names = {{}}, {{}}
			for i = 1, 25000 do
				local name = ("Ring %05d of %s"):format(25001 - i, i % 2 == 0 and "Valor" or "Agility")
				names[i] = name
				lines[i] = "\2" .. Polestar.Search.Fold(name):sub(2) .. "\1" .. i .. ",2,," .. #name .. "\n"
			end
			local blob = table.concat(lines)
			Polestar.Codex.IsLoaded = function() return true end
			Polestar.Codex.Index = function(kind) if kind == "item" then return blob end end
			Polestar.Codex.Name = function(_, id) return names[id] end
			UI.ShowLookup()
			LK.SetKind("item")
			local function median(times)
				table.sort(times)
				return times[math.ceil(#times / 2)]
			end
			for _, order in ipairs({{ "best", "az" }}) do
				LK.SetOrder(order)
				local keys, pages = {{}}, {{}}
				for i = 1, 7 do
					local at = os.clock()
					for _, q in ipairs({{ "r", "ring", "valor", "ring agility" }}) do
						type_(q)
						stub.advance(0.2)
					end
					keys[i] = (os.clock() - at) * 1000 / 4
					at = os.clock()
					for _ = 1, 15 do LK.More() end
					pages[i] = (os.clock() - at) * 1000 / 15
				end
				emit({{ order = order, key = median(keys), page = median(pages), rows = LK.shown.rows, count = LK.shown.total }})
			end
		"#
		),
		..Default::default()
	});
	for times in out {
		let order = text(&times["order"]);
		let (key, page) = (times["key"].as_f64().unwrap(), times["page"].as_f64().unwrap());
		println!("{order}, 25,000 entries in Lookup: keystroke {key:.3} ms, Show more {page:.3} ms");
		assert_eq!(times["count"], 12500);
		assert_eq!(times["rows"], 800);
		forge_addontest::assert_timing!(key < 80.0, "{order}: Lookup keystroke took {key:.3} ms");
		forge_addontest::assert_timing!(page < 15.0, "{order}: Lookup Show more took {page:.3} ms");
	}
}

#[test]
fn while_the_codex_loads_the_section_says_so_and_searches_again_once_it_has() {
	let out = run(r#"
		lookupstub.loaded, lookupstub.reason = false, "loading"
		Polestar.Lookup.Show("saber")
		local loading = { empty = LK.shown.empty, codex = LK.root.CodexLine:GetText(), rows = #rowTexts(LK.results.Child) }
		lookupstub.loaded, lookupstub.reason = true, nil
		Polestar.Fire("CODEX_LOADED", {})
		emit({ loading = loading, rows = LK.shown.rows, empty = LK.shown.empty or false })"#);
	assert_eq!(out["loading"]["empty"], "Loading the Codex\u{2026}");
	assert_eq!(out["loading"]["codex"], "Loading the Codex\u{2026}");
	assert_eq!(out["loading"]["rows"], 0);
	assert!(out["rows"].as_f64().unwrap() > 0.0, "the search ran again");
	assert_eq!(out["empty"], false);
}

// A French client whose names pack lands with results up: the search runs again and the rows take the client's
// names.
#[test]
fn a_names_pack_landing_late_searches_again_and_the_rows_take_the_new_names() {
	let out = run(r#"
		Polestar.Lookup.Show("lelanai")
		local before = rowTexts(LK.results.Child)
		for _, e in ipairs(lookupstub.entities) do if e.id == 4730 then e.title = "Lelanai la dresseuse" end end
		Polestar.Fire("NAMES_LOADED")
		emit({ before = before, after = rowTexts(LK.results.Child) })"#);
	let strings = |v: &Value| v.as_array().unwrap().iter().map(|t| text(t).to_string()).collect::<Vec<_>>();
	assert!(strings(&out["before"]).iter().any(|t| t.starts_with("Lelanai") && !t.contains("dresseuse")));
	assert!(strings(&out["after"]).iter().any(|t| t.contains("Lelanai la dresseuse")));
}

#[test]
fn lookup_turned_off_in_options_guides_only_the_section_says_where_to_turn_it_on_nothing_loads_the_codex() {
	let out = run(r#"
		Polestar.Set("lookup.enabled", false)
		lookupstub.loaded, lookupstub.reason = false, "off"
		local loads = 0
		Polestar.Codex.Load = function() loads = loads + 1; return false, "off" end
		UI.ShowLookup()
		local idle = { title = LK.detail.empty, note = LK.detail.note, codex = LK.root.CodexLine:GetText() }
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local none = LK.shown.empty
		Polestar.Lookup.Show(nil, "mount", 8631)
		emit({ idle = idle, none = none, loads = loads })"#);
	assert_eq!(out["idle"]["title"], "Lookup is turned off");
	assert!(is_match(text(&out["idle"]["note"]), r"Options > Discovery > Lookup"));
	assert_eq!(out["idle"]["codex"], "Lookup is off: searching guides only");
	assert!(is_match(text(&out["none"]), r"Nothing matches .saber.\. Lookup is turned off in Options > Discovery > Lookup"));
	assert_eq!(out["loads"], 0);
}

// #2692: Lookup's "Lookup is off: searching guides only" sits in the hub's tab row. Going to the guide list hides
// the section's frame (the hub's), not Lookup's own, and the line read only its own frame's state: it stayed on
// the guide list over its tabs. The hub hiding with Lookup open keeps it for when the hub comes back.
#[test]
fn the_codex_line_leaves_the_tab_row_with_the_section_and_comes_back_with_it_2692() {
	let out = run(r#"
		stub.cascadeVisibility = true
		lookupstub.loaded, lookupstub.reason = false, "off"
		Polestar.Codex.Load = function() return false, "off" end
		UI.ShowLookup()
		local line = LK.root.CodexLine
		local r = { lookup = { line:GetText(), line:IsVisible() } }
		Polestar.UI.Picker.ShowSection("Guides")
		r.guides = { tabs = PolestarPicker.TabRow:IsShown(), line = line:IsVisible() }
		UI.ShowLookup()
		r.back = line:IsVisible()
		PolestarPicker:Hide(); PolestarPicker:Show()
		r.reopened = line:IsVisible()
		emit(r)"#);
	assert_eq!(out["lookup"], json!(["Lookup is off: searching guides only", true]));
	assert_eq!(out["guides"], json!({ "tabs": true, "line": false }), "the guide list's tab row is its own");
	assert_eq!(out["back"], true, "back in Lookup, the line is back");
	assert_eq!(out["reopened"], true, "the hub hidden and shown again with Lookup open keeps it");
}

// #2554: a quest in a chain shows "Step N of M" among its facts and the whole chain under its sources, each quest
// with its state (a skipped one marked), the follow-up branches after it, and a click opening another quest's page;
// hovering another quest's row says so. A chain left with only skipped quests says it is finished, not all done.
#[test]
fn a_quest_in_a_chain_shows_its_step_each_quest_s_state_and_its_branches_and_a_row_opens_that_quest() {
	let out = run(r#"
		lookupstub.chains[38] = {
			quests = {
				{ id = 36, title = "Gathering Ingredients", state = "later", why = "Needs level 14", skipped = true },
				{ id = 37, title = "Fresh Meat", state = "done" },
				{ id = 38, title = "Westfall Stew", state = "open" },
				{ id = 4970, title = "Frostsaber Provisions", state = "later", why = "After an earlier quest" },
			},
			step = 3, total = 4, skippedCount = 1,
			branches = { { id = 40, title = "A Fishy Peril" }, { id = 41, title = "Furlbrow's Deed" } },
		}
		Polestar.Lookup.Show(nil, "quest", 38)
		local d = LK.detail
		local chainFact
		for _, f in ipairs(d.facts) do if f[1] == "Chain" then chainFact = f[2] end end
		local rows = LK.details.ChainRows
		local first = { head = LK.details.ChainHead.Count:GetText(), fact = chainFact, chain = d.chain,
			branches = LK.details.ChainBranches:GetText(), clickHere = rows[3].psQuest or false }
		stub.RunScript(rows[4], "OnEnter")
		first.tip = GameTooltip.lines
		stub.RunScript(rows[4], "OnLeave")
		rows[4]:Click()
		first.finished = LK.ChainStepText({ done = true, step = 4, total = 4, skippedCount = 1 })
		emit({ first = first, sel = LK.Selected(), after = LK.detail.chain or false })"#);
	let f = &out["first"];
	assert_eq!(f["fact"], "Step 3 of 4");
	assert_eq!(f["head"], "Step 3 of 4");
	assert!(f["tip"].as_array().unwrap().iter().any(|l| text(l) == "Click to open its page."), "{}", f["tip"]);
	assert_eq!(f["finished"], "Finished, 1 skipped");
	assert_eq!(
		cols(&f["chain"]["quests"], &["id", "state", "here"]),
		json!([[36, "Skipped  \u{b7}  Needs level 14", null], [37, "Done", null], [38, "You can take it now", true], [4970, "After an earlier quest", null],])
	);
	assert_eq!(f["chain"]["branches"], json!(["A Fishy Peril", "Furlbrow's Deed"]));
	assert_eq!(f["branches"], "Then any of: A Fishy Peril, Furlbrow's Deed");
	assert_eq!(f["clickHere"], false, "the quest's own row opens nothing");
	assert_eq!(out["sel"], json!({ "kind": "quest", "id": 4970 }), "a row opens that quest's page");
	assert_eq!(out["after"], false, "a quest standing alone has no chain");
}

// #3370 (Zack: a level 57 went to Pix Xizzix for In Demand, which the game offers from level 60): a quest's page says
// which level it requires, in the warning colour, while the character is below it; its level alone read as a quest
// to take. At that level the line goes.
#[test]
fn a_quest_s_page_says_the_level_it_requires_in_the_warning_colour_while_the_character_is_below_it_3370() {
	let out = run(r#"
		lookupstub.entity["quest:4970"] = { id = 4970, title = "Frostsaber Provisions", level = 60, minLevel = 60, faction = "A" }
		uistub.player.level = 57
		Polestar.Lookup.Show(nil, "quest", 4970)
		local below = LK.detail.facts
		local r, g, b = LK.details.Facts[2].Value:GetTextColor()
		local wr, wg, wb = Polestar.Theme.Color("warning")
		local warning = r == wr and g == wg and b == wb
		LK.Select(nil)
		uistub.player.level = 60
		Polestar.Lookup.Show(nil, "quest", 4970)
		emit({ below = below, warning = warning, at = LK.detail.facts })"#);
	assert_eq!(out["below"], json!([["Level", "60"], ["Requires", "Level 60"], ["Faction", "Alliance"], ["Places", "None known"]]));
	assert_eq!(out["warning"], true, "the requirement in the warning colour");
	assert_eq!(out["at"], json!([["Level", "60"], ["Faction", "Alliance"], ["Places", "None known"]]), "at level 60: no line");
}

#[test]
fn an_item_s_icon_in_the_details_shows_the_game_s_tooltip_for_it_other_pages_icons_none() {
	let out = run(r#"
		local links = {}
		GameTooltip.SetHyperlink = function(self, link) links[#links + 1] = link end
		local well
		local function hover()
			GameTooltip.owner = nil
			stub.RunScript(well, "OnEnter")
			local r = { mouse = well:IsMouseEnabled(), owner = GameTooltip:GetOwner() == well, link = links[#links] or false }
			assert(well.Highlight:IsShown() == r.mouse)
			stub.RunScript(well, "OnLeave")
			assert(not well.Highlight:IsShown())
			links = {}
			return r
		end
		Polestar.Lookup.Show(nil, "item", 4386)
		well = LK.details.Well
		local item = hover()
		Polestar.Lookup.Show(nil, "mount", 8631)
		local mount = hover()
		Polestar.Lookup.Show(nil, "npc", 4730)
		local npc = hover()
		Polestar.Lookup.Show(nil, "item", 4386)
		stub.RunScript(well, "OnEnter")
		links = {}
		Polestar.Lookup.Show(nil, "mount", 8631)
		local follows = links[1] or false
		Polestar.Lookup.Show(nil, "npc", 4730)
		local leftNpc = GameTooltip:IsShown()
		assert(not well.Highlight:IsShown())
		Polestar.Lookup.Show(nil, "item", 4386)
		stub.RunScript(well, "OnEnter")
		LK.Select(nil)
		local leftEmpty = GameTooltip:IsShown()
		assert(not well.Highlight:IsShown())
		emit({ item = item, mount = mount, npc = npc, follows = follows, leftNpc = leftNpc, leftEmpty = leftEmpty })"#);
	assert_eq!(out["item"], json!({ "mouse": true, "owner": true, "link": "item:4386" }));
	assert_eq!(out["mount"], json!({ "mouse": true, "owner": true, "link": "item:8631" }));
	assert_eq!(out["npc"]["mouse"], false, "an NPC's glyph leaves the band to drag the window");
	assert_eq!(out["npc"]["link"], false);
	assert_eq!(out["follows"], "item:8631", "a tooltip already up follows the newly opened item");
	assert_eq!(out["leftNpc"], false, "and goes when the page is no item");
	assert_eq!(out["leftEmpty"], false, "and when the details empty");
}

#[test]
fn a_modified_click_on_an_item_s_icon_in_the_details_hands_its_link_to_the_client_a_plain_or_right_click_does_nothing() {
	let out = run(r#"
		local modified, handled = false, {}
		IsModifiedClick = function() return modified end
		Polestar.Compat.ItemLink = function(id) return "|Hitem:" .. id .. "|h[x]|h" end
		HandleModifiedItemClick = function(link) handled[#handled + 1] = link end
		Polestar.Lookup.Show(nil, "item", 4386)
		local well = LK.details.Well
		stub.RunScript(well, "OnMouseUp", "LeftButton")
		local plain = #handled
		modified = true
		stub.RunScript(well, "OnMouseUp", "RightButton")
		stub.RunScript(well, "OnMouseUp", "LeftButton")
		Polestar.Lookup.Show(nil, "npc", 4730)
		stub.RunScript(well, "OnMouseUp", "LeftButton")
		emit({ plain = plain, handled = handled })"#);
	assert_eq!(out["plain"], 0, "a plain click is not a modified click");
	assert_eq!(out["handled"], json!(["|Hitem:4386|h[x]|h"]), "Shift / Ctrl on the item hands its link over; an NPC's glyph none");
}
