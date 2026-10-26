//! The guide menu (addon/Polestar/UI/Picker.lua): three panes in the Polestar shell, against the fake Engine and
//! sample guides of tests/lua/stub_ui.lua. Rows mark a finished guide with a check and an open one with a muted
//! "Tab N" note; the tab row always has an active tab (Browse for a category or a search); the details end in a
//! facts block.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const HELPERS: &str = r#"
local function kinds(entries)
	local out = {}
	for _, e in ipairs(entries) do
		out[#out + 1] = e.kind == "guide" and e.guide.title or ("[" .. e.text .. " " .. e.count .. "]")
	end
	return out
end
local function rows()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	return out
end
local function lines()
	local out = {}
	for _, r in ipairs(rows()) do
		local mark = r.Check:IsShown() and "\226\156\147 " or ""
		local note = r.Note:GetText() ~= "" and (" | " .. r.Note:GetText()) or ""
		out[#out + 1] = mark .. r.Title:GetText() .. " " .. r.Range:GetText() .. note
	end
	return out
end
local function folders()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if rawget(f, "Count") and rawget(f, "Rule") and not rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	for i, f in ipairs(out) do out[i] = f.Text:GetText() .. " " .. f.Count:GetText() end
	return out
end
local function rowFor(title)
	for _, r in ipairs(rows()) do if r.psGuide.title == title then return r end end
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
end
local function tab(key)
	for _, t in ipairs(PolestarPicker.tabButtons) do if t.psKey == key and t:IsShown() then return t end end
end
local function nav(key)
	for _, b in ipairs(PolestarPicker.navButtons) do if b.psKey == key and b:IsShown() then return b end end
end
local D = function() return P.details end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
-- Guides past level 30, to show the bands; the two from 40-50 share a
-- minimum level (43), so the id decides their order, and are added out of it.
local function addBand(id, title, faction, lo, hi)
	uistub.guides[id] = { id = id, title = title, faction = faction, minLevel = lo, maxLevel = hi, category = "Leveling", zone = 0, zoneName = title,
		steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
	table.insert(uistub.order, id)
end
addBand("forever/horde/30-40/01-desolace", "Desolace & Hillsbrad Foothills", "Horde", 30, 33)
addBand("forever/alliance/30-40/02-desolace", "Desolace", "Alliance", 31, 34)
addBand("forever/alliance/40-50/03-feralas", "Feralas", "Alliance", 43, 46)
addBand("forever/alliance/40-50/02-badlands", "Badlands & The Hinterlands", "Alliance", 43, 44)
local westfall = uistub.guides["forever/alliance/02-westfall"]
westfall.pitch, westfall.pros, westfall.cons = "Farms and bandits.", { "Compact", "Flight path" }, { "Long walks" }
"#;

fn run_all(script: &str, install: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install({install})\nstub.login()\nlocal UI, P = Polestar.UI, Polestar.UI.Picker\n{HELPERS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Value {
	run_all(script, "").remove(0)
}

fn starting_with_bracket(v: &Value) -> Value {
	Value::Array(v.as_array().unwrap().iter().filter(|k| text(k).starts_with('[')).cloned().collect())
}

fn includes(v: &Value, s: &str) -> bool {
	v.as_array().unwrap().iter().any(|k| k.as_str() == Some(s))
}

#[test]
fn browse_folders_by_faction_and_band_then_by_category_faction_filter_and_band_derivation() {
	let out = run(r#"
		local alliance = kinds(P.Entries("Alliance", "", "Leveling"))
		local horde = kinds(P.Entries("Horde", ""))
		local all = kinds(P.Entries("All", "", "Leveling"))
		uistub.player.race, uistub.player.faction = "Scourge", "Horde"
		emit({ alliance = alliance, all = all, horde = horde, undeadHorde = kinds(P.Entries("Horde", "", "Leveling")),
			bands = { { P.Band({ id = "forever/horde/30-40/01-desolace", minLevel = 12 }) }, { P.Band({ id = "a/b", minLevel = 44 }) }, { P.Band({ id = "a/b", minLevel = 29 }) } } })"#);
	// Within a folder: faction, then minimum level, then id. On the player's own faction, a Human sees no other
	// race's start (Dun Morogh, Teldrassil, Zephras Isle).
	assert_eq!(
		out["alliance"],
		json!(["[Alliance 1\u{2013}30 3]", "Elwynn Forest", "Westfall", "Darkshore", "[Alliance 30\u{2013}40 1]", "Desolace", "[Alliance 40\u{2013}50 2]", "Badlands & The Hinterlands", "Feralas"])
	);
	// The player's faction first; every faction and every race's guides when all are listed.
	assert_eq!(starting_with_bracket(&out["all"]), json!(["[Alliance 1\u{2013}30 6]", "[Alliance 30\u{2013}40 1]", "[Alliance 40\u{2013}50 2]", "[Horde 1\u{2013}30 3]", "[Horde 30\u{2013}40 1]"]));
	// The other faction lists all of its guides, races included.
	assert_eq!(starting_with_bracket(&out["horde"]), json!(["[Horde 1\u{2013}30 3]", "[Horde 30\u{2013}40 1]", "[Professions 3]", "[Reputation 1]", "[Exploration 1]", "[Legacy 1]"]));
	assert!(includes(&out["horde"], "Durotar"));
	assert!(includes(&out["horde"], "Orgrimmar Reputation") && !includes(&out["horde"], "Stormwind Reputation"));
	// An Undead on the Horde list: the Orc and Troll start is left out, the shared guides stay.
	assert!(!includes(&out["undeadHorde"], "Durotar") && includes(&out["undeadHorde"], "The Barrens"));
	assert_eq!(out["bands"], json!([[30, 40], [40, 50], [1, 30]]));
}

#[test]
fn search_covers_titles_zones_categories_and_player_facing_race_names_typing_selects_the_first_result() {
	let out = run(r#"
		UI.ShowPicker()
		local function guides(q, cat)
			local t = {}
			for _, e in ipairs(P.Entries("All", q, cat)) do if e.kind == "guide" then t[#t + 1] = e.guide.title end end
			return t
		end
		P.SetView("current")
		P.SetQuery("elwynn")
		local r = { view = P.View(), shown = lines(), selected = P.Selected(), title = PolestarPicker.Title:GetText(),
			subtitle = PolestarPicker.Subtitle:GetText(), browseOn = tab("browse").psSelected }
		emit({ r = r, multi = guides("elwynn riding"), reputation = guides("reputation"), upper = guides("PROFESSIONS"),
			undead = guides("undead"), nightelf = guides("night elf"), profInLeveling = #guides("tailoring", "Leveling") })"#);
	assert_eq!(out["multi"], json!(["Horse"]), "every word must match: the zone and a keyword");
	assert_eq!(out["reputation"], json!(["Stormwind Reputation", "Orgrimmar Reputation"]));
	assert_eq!(out["upper"], json!(["Cooking 1-300", "First Aid 1-300", "Tailoring 1-300"]));
	assert_eq!(out["undead"], json!(["Tirisfal Glades"]), "\"Scourge\" is found as Undead");
	assert_eq!(out["nightelf"], json!(["Teldrassil"]));
	assert_eq!(out["profInLeveling"], 0);
	assert_eq!(
		out["r"],
		json!({
			"view": "browse", "shown": ["Elwynn Forest (1\u{2013}13)", "Horse (40\u{2013}60)"], "selected": "forever/alliance/human/01-elwynn-forest", "title": "Search",
			"subtitle": "2 results for \u{201c}elwynn\u{201d}", "browseOn": true,
		})
	);
}

#[test]
fn left_pane_the_rail_holds_the_sections_and_options_the_sidebar_holds_the_categories_in_order_favourites_last() {
	let out = run(r#"
		UI.ShowPicker()
		local labels, rail = {}, {}
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then labels[#labels + 1] = b.Label:GetText() .. " " .. b.Count:GetText() end
		end
		for _, b in ipairs(PolestarPicker.railButtons) do
			if b:IsShown() then rail[#rail + 1] = b.Label:GetText() .. (b.Bar:IsShown() and "*" or "") end
		end
		local icon = nav("Favorites").Icon:GetTexture()
		nav("Professions"):Click()
		local r = { view = P.View(), category = P.Category(), title = PolestarPicker.Title:GetText(), folders = folders(), lines = lines(),
			navOn = nav("Professions").Bar:IsShown(), tabOn = tab("home").psSelected or false, browseOn = tab("browse").psSelected,
			tabs = {}, footer = PolestarPicker.Footer:IsShown(), subtitle = PolestarPicker.Subtitle:GetText() }
		for _, t in ipairs(PolestarPicker.tabButtons) do if t:IsShown() then r.tabs[#r.tabs + 1] = t.Label:GetText() end end
		tab("home"):Click()
		r.home = { view = P.View(), homeOn = tab("home").psSelected }
		tab("browse"):Click()
		r.back = { view = P.View(), category = P.Category(), browseOn = tab("browse").psSelected }
		for _, b in ipairs(PolestarPicker.railButtons) do if b:IsShown() and b.psKey == "Options" then b:Click() end end
		local sections = {}
		for i, s in ipairs(P.Sections()) do sections[i] = s.label or s.key end
		emit({ cats = P.categories, labels = labels, rail = rail, sections = sections, icon = icon, r = r, options = PolestarOptions:IsShown(), picker = PolestarPicker:IsShown() })"#);
	assert_eq!(out["cats"], json!(["All", "Leveling", "Professions", "Reputation", "Exploration", "Legacy", "Collectibles", "Favorites"]), "dungeons have their own section, not a category");
	// Sections (Guides built in, then the registered ones by order) are on the rail, Options at its foot.
	assert_eq!(out["sections"][0], "Guides");
	assert_eq!(out["sections"][1], "Lookup");
	// Import is a foot section: above Options, not among the sections at the top.
	let mut rail = vec![json!("Options"), json!("Import"), json!("Guides*")];
	rail.extend(out["sections"].as_array().unwrap()[1..].iter().filter(|s| s.as_str() != Some("Import")).cloned());
	assert_eq!(out["rail"], Value::Array(rail));
	assert_eq!(out["labels"], json!(["All guides 13", "Leveling 6", "Professions 3", "Reputation 1", "Exploration 1", "Legacy 1", "Collectibles 1", "Favourites 0"]));
	assert!(is_match_icon(text(&out["icon"])));
	assert_eq!(
		out["r"],
		json!({
			"view": "browse", "category": "Professions", "title": "Professions", "folders": ["Professions 3"],
			"lines": ["Cooking 1-300 (5\u{2013}60)", "First Aid 1-300 (5\u{2013}60)", "Tailoring 1-300 (5\u{2013}60)"], "navOn": true, "tabOn": false, "browseOn": true,
			"tabs": ["Home", "Browse", "Current", "Recent"], "footer": false, "subtitle": "Alliance  \u{b7}  3 guides",
			"home": { "view": "home", "homeOn": true }, "back": { "view": "browse", "category": "Professions", "browseOn": true },
		})
	);
	assert_eq!(out["options"], true);
	assert_eq!(out["picker"], false);
}

fn is_match_icon(s: &str) -> bool {
	forge_addontest::is_match(s, r"\\star$")
}

#[test]
fn the_sidebar_is_one_compact_block_on_one_edge_the_lockup_wordmark_tagline_under_it_the_search_with_its_foot_on_the_band_line_navigation_12px_under_that_the_version_on_the_rail_s_foot_line() {
	let out = run(r#"
		UI.ShowPicker()
		local F = PolestarPicker
		local function pt(r, i) local p, _, _, x, y = r:GetPoint(i or 1); return { p, x, y } end
		local opt
		for _, b in ipairs(F.railButtons) do if b:IsShown() and b.psKey == "Options" then opt = b end end
		local _, _, _, _, optY = opt:GetPoint(1)
		local _, _, _, _, labelY = opt.Label:GetPoint(1)
		local _, _, _, _, iconY = opt.Icon:GetPoint(1)
		local navFirst = F.navButtons[1]
		emit({ wordmark = pt(F.Wordmark), tagline = pt(F.Tagline), search = pt(F.Search), navTop = F.psNavTop, navX = select(4, navFirst.Icon:GetPoint(1)),
			status = pt(F.Status), optLabelBottom = optY + opt:GetHeight() + iconY - opt.Icon:GetHeight() + labelY - opt.Label:GetStringHeight(),
			emblem = pt(F.Emblem), firstRail = (function() for _, b in ipairs(F.railButtons) do if b:IsShown() and b.psKey == "Guides" then local _, _, _, _, y = b:GetPoint(1); return -y end end end)() })"#);
	let edge = 24;
	assert_eq!(out["wordmark"], json!(["TOPLEFT", edge - 2, -22]), "the wordmark's ink (2px into its box) sits on the sidebar edge");
	assert_eq!(out["tagline"], json!(["TOPLEFT", edge, -52]), "the tagline under the wordmark, on the same edge");
	assert_eq!(out["search"], json!(["TOPLEFT", edge, -(112 - 30)]), "the search ends on the header band's 112 line");
	assert_eq!(out["navTop"], 112 + 12, "navigation 12px under the search");
	assert_eq!(out["navX"], edge, "navigation icons on the same edge");
	assert_eq!(out["status"], json!(["BOTTOMLEFT", edge, 23]));
	assert_eq!(out["optLabelBottom"], 23, "the version shares the line of the rail's Options label");
	assert_eq!(out["firstRail"], out["navTop"], "the first section sits level with the first category");
	assert_eq!(out["emblem"], json!(["TOP", 0, -(47 - 18)]), "the emblem centred on the title line, like the lockup beside it");
}

#[test]
fn the_search_placeholder_is_the_first_wording_that_fits_the_box_refitted_on_resize_the_last_is_cut_when_none_fits() {
	let out = run(r#"
		UI.ShowPicker()
		local box = PolestarPicker.Search
		local ph = box.Placeholder
		local function at(w)
			box:SetWidth(w)
			stub.RunScript(box, "OnSizeChanged", w, 30)
			return { ph:GetText(), ph:GetStringWidth() <= w - 40 }
		end
		emit({ wide = at(400), mid = at(185), narrow = at(60) })"#);
	// The stub measures 6px a character at the label's size (12); the placeholder has the box's width less 40px
	// (its left inset and padding).
	assert_eq!(out["wide"], json!(["Search guides, items, NPCs", true]));
	assert_eq!(out["mid"], json!(["Search guides, items", true]), "the full wording (156px) would overflow 145px: the shorter one shows");
	assert_eq!(out["narrow"], json!(["Search", true]), "the last wording, cut to the box when even it is too long");
}

#[test]
fn the_hub_fits_every_section_on_the_rail_above_the_foot_import_options_every_category_in_the_sidebar_above_the_status_line() {
	let out = run(r#"
		-- Fill the rail to seven sections above its foot of two (Import,
		-- Options): the docs/SUITE.md ones (Guides, Lookup, Dungeons, Rares)
		-- and stand-ins for more.
		local i = 0
		while #P.RailItems() < 7 do
			i = i + 1
			local key = i == 1 and "Rares" or ("Extra" .. i)
			UI.RegisterSection({ key = key, label = key, icon = "compact", order = 50 + i,
				build = function(parent) end, render = function() end,
				nav = function() return { { key = "a", label = "A" }, { key = "b", label = "B" } }, "a" end })
		end
		local all = {}
		for k, s in ipairs(P.RailItems()) do all[k] = s.key end
		UI.ShowPicker()
		P.SetCategory("All")
		local H = PolestarPicker:GetHeight()
		local function bottomOf(b) local _, _, _, _, y = b:GetPoint(1); return -y + b:GetHeight() end
		local function topOfFoot(b) local _, _, _, _, y = b:GetPoint(1); return H - 2 - (y + b:GetHeight()) end
		local foot = {}
		for _, item in ipairs(P.FootItems()) do foot[item.key] = true end
		local railBottom, options, keys = 0, nil, {}
		for _, b in ipairs(PolestarPicker.railButtons) do
			if b:IsShown() then
				if foot[b.psKey] then options = math.min(options or math.huge, topOfFoot(b)) else
					railBottom = math.max(railBottom, bottomOf(b))
					keys[#keys + 1] = b.psKey
				end
			end
		end
		local navBottom, navTop = 0, PolestarPicker.psNavTop
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then local _, _, _, _, y = b:GetPoint(1); navBottom = math.max(navBottom, navTop - y + b:GetHeight()) end
		end
		local _, _, _, _, statusY = PolestarPicker.Status:GetPoint(1)
		P.ShowSection("Rares")
		local sectionNav = {}
		for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then sectionNav[#sectionNav + 1] = b.psKey end end
		emit({ keys = keys, all = all, railBottom = railBottom, options = options, navBottom = navBottom, statusTop = H - 2 - statusY - 14,
			sectionNav = sectionNav, railOn = (function() for _, b in ipairs(PolestarPicker.railButtons) do if b:IsShown() and b.Bar:IsShown() then return b.psKey end end end)(),
			details = P.details:IsShown(), list = PolestarPicker.Content:IsShown() })"#);
	assert_eq!(out["all"].as_array().unwrap().len(), 7);
	assert_eq!(out["keys"], out["all"], "seven sections fit the rail above its foot of two");
	assert!(out["railBottom"].as_f64().unwrap() <= out["options"].as_f64().unwrap(), "rail ends at {}, Options starts at {}", out["railBottom"], out["options"]);
	assert!(out["navBottom"].as_f64().unwrap() <= out["statusTop"].as_f64().unwrap(), "categories end at {}, the status line starts at {}", out["navBottom"], out["statusTop"]);
	assert_eq!(out["sectionNav"], json!(["a", "b"]), "a section's own index replaces the categories");
	assert_eq!(out["railOn"], "Rares");
	assert_eq!(out["details"], false);
	assert_eq!(out["list"], false);
}

#[test]
fn categories_left_out_without_a_guide_for_any_faction_faded_with_a_tip_when_empty_only_for_this_faction() {
	let out = run(r#"
		-- No Legacy guide at all; the only collectible (Horse) is Alliance only.
		for i = #uistub.order, 1, -1 do
			local g = uistub.guides[uistub.order[i]]
			if g and g.category == "Legacy" then table.remove(uistub.order, i) end
		end
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.pickerFaction", "Horde")
		UI.ShowPicker()
		P.SetCategory("All")
		local collectibles = nav("Collectibles")
		emit({ cats = P.categories, legacy = nav("Legacy") ~= nil, collectibles = { collectibles.psTip, collectibles:GetAlpha(), collectibles.Count:IsShown() },
			leveling = nav("Leveling").psTip or false })"#);
	assert_eq!(out["cats"], json!(["All", "Leveling", "Professions", "Reputation", "Exploration", "Collectibles", "Favorites"]));
	assert_eq!(out["legacy"], false);
	assert_eq!(out["collectibles"], json!(["None for Horde; switch the filter to All.", 0.55, false]));
	assert_eq!(out["leveling"], false);
}

#[test]
fn selecting_a_guide_shows_its_details_and_loads_nothing_the_selection_is_remembered() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		P.SetCategory("Leveling")
		local before = #uistub.calls
		rowFor("Westfall"):Click()
		local d = D()
		local chips = {}
		for _, c in ipairs(d.Chips) do if c:IsShown() then chips[#chips + 1] = c.Text:GetText() end end
		local pros = {}
		for _, b in ipairs(d.Pros) do if b.Text:IsShown() then pros[#pros + 1] = b.Text:GetText() end end
		local r = { title = d.Title:GetText(), eyebrow = rawget(d, "Category") ~= nil, track = d.Prog:IsShown(), chips = chips, facts = P.detail.facts,
			progress = d.ProgLabel:GetText(), pitch = d.Pitch:GetText(), pros = pros, cons = d.Cons[1].Text:GetText(),
			load = d.Load.Label:GetText(), newTab = d.NewTab:IsShown() and d.NewTab:IsEnabled(), selectedRow = rowFor("Westfall").Selected:IsShown(),
			calls = #uistub.calls - before, open = PolestarPicker:IsShown(), tip = rowFor("Westfall").psTip }
		-- A route choice next.
		westfall.nextChoices = { "forever/alliance/30-40/02-desolace", "forever/alliance/40-50/03-feralas" }
		P.Render()
		r.choice = P.detail.facts[#P.detail.facts]
		westfall.nextChoices = nil
		-- An open guide: its tab and step; Continue alone at full width.
		rowFor("Elwynn Forest"):Click()
		r.open1 = { progress = d.ProgLabel:GetText(), pct = d.ProgPct:GetText(), track = d.Prog:IsShown(), load = d.Load.Label:GetText(), newTab = d.NewTab:IsShown(),
			loadWidth = d.Load.psFixedWidth, facts = P.detail.facts }
		PolestarPicker:Hide()
		r.saved = Polestar.CharState().ui.pickerSelected
		UI.ShowPicker()
		r.again = d.Title:GetText()
		emit(r)"#);
	assert_eq!(
		out,
		json!({
			"title": "Westfall", "eyebrow": false, "track": false, "chips": ["Levels 12\u{2013}17", "Alliance"], "facts": [["Steps", "17"], ["Zones", "Westfall"], ["Next", "Darkshore (16\u{2013}21)"]], "progress": "Not started",
			"pitch": "Farms and bandits.", "pros": ["Compact", "Flight path"], "cons": "Long walks", "load": "Load guide", "newTab": true, "selectedRow": true,
			"calls": 0, "open": true, "tip": "Double-click a guide or press Enter to load it.",
			"choice": ["Next", "Your choice: Desolace or Feralas"],
			"open1": {
				"progress": "Open in tab 1  \u{b7}  step 3 of 8", "pct": "29%", "track": true, "load": "Continue", "newTab": false, "loadWidth": 324,
				"facts": [["Steps", "8"], ["Quests", "4"], ["Zones", "Elwynn Forest"], ["Next", "Westfall (12\u{2013}17)"]],
			},
			"saved": "forever/alliance/human/01-elwynn-forest", "again": "Elwynn Forest",
		})
	);
}

#[test]
fn a_class_guide_s_details_lead_with_its_reward_item_and_spell_icons_quality_colour_the_game_s_tooltip_on_hover_and_why() {
	let out = run_all(
		r#"
		local id = "forever/class/warlock/test"
		uistub.guides[id] = { id = id, pack = "guides", title = "An Imp's Request", category = "Class", folder = "Warlock", minLevel = 50, maxLevel = 54,
			zone = 1429, zoneName = "Felwood",
			reward = { { spell = 23161, spellName = "Summon Dreadsteed" }, { item = 20536, itemName = "Soul Harvester", quality = 3, choice = true },
				{ item = 20534, itemName = "Abyss Shard", quality = 3, choice = true }, { text = "Summon Incubus" } },
			why = "A staff, an off-hand or a robe for the 50s.",
			steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
		table.insert(uistub.order, id)
		ITEM_QUALITY_COLORS = { [3] = { r = 0, g = 0.44, b = 0.87 } }
		Polestar.Compat.ItemIcon = function(item) return item == 20536 and 135139 or nil end
		Polestar.Compat.SpellIcon = function(spell) return spell == 23161 and 132238 or nil end
		local tips = {}
		GameTooltip.SetHyperlink = function(_, link) tips[#tips + 1] = link end
		GameTooltip.SetSpellByID = function(_, spell) tips[#tips + 1] = "spell:" .. spell end
		Polestar.Set("ui.pickerFaction", "All")
		UI.ShowPicker()
		P.Select(id)
		local d = D()
		local tiles = {}
		for _, t in ipairs(d.Rewards) do
			if t:IsShown() then
				stub.RunScript(t, "OnEnter")
				tiles[#tiles + 1] = { t.Name:GetText(), t.Icon:GetTexture() }
			end
		end
		emit({ reward = P.detail.reward, facts = { P.detail.facts[1], P.detail.facts[2], P.detail.facts[3] }, tiles = tiles, tips = tips,
			blue = select(3, d.Rewards[3].Name:GetTextColor()) > 0.8 })
		P.Select("forever/alliance/02-westfall")
		local shown = 0
		for _, t in ipairs(d.Rewards) do if t:IsShown() then shown = shown + 1 end end
		emit({ shown = shown, reward = P.detail.reward == nil, first = P.detail.facts[1][1] })"#,
		"",
	);
	let (rows, after) = (&out[0], &out[1]);
	assert_eq!(
		rows["reward"],
		json!([
			{ "kind": "spell", "id": 23161, "name": "Summon Dreadsteed" },
			{ "kind": "text", "name": "Summon Incubus" },
			{ "kind": "item", "id": 20536, "name": "Soul Harvester", "choice": true },
			{ "kind": "item", "id": 20534, "name": "Abyss Shard", "choice": true },
		])
	);
	assert_eq!(rows["facts"], json!([["Reward", "Summon Dreadsteed, Summon Incubus"], ["Choose one", "Soul Harvester, Abyss Shard"], ["Why", "A staff, an off-hand or a robe for the 50s."],]));
	assert_eq!(rows["tiles"].as_array().unwrap().len(), 4);
	assert_eq!(rows["tiles"][0][1], 132238, "the spell's icon");
	assert_eq!(rows["tiles"][2][1], 135139, "the item's icon");
	assert_eq!(rows["tips"], json!(["spell:23161", "item:20536", "item:20534"]), "items and spells show the game's tooltip; words none");
	assert_eq!(rows["blue"], true, "a rare item in its quality colour");
	assert_eq!(*after, json!({ "shown": 0, "reward": true, "first": "Steps" }));
}

#[test]
fn reward_tiles_an_uncached_item_s_tooltip_fills_in_when_the_item_arrives_the_pane_asks_for_its_items_and_modified_clicks_act_as_on_any_item_or_spell_button() {
	let out = run(r#"
		local id = "forever/class/warlock/test"
		uistub.guides[id] = { id = id, pack = "guides", title = "An Imp's Request", category = "Class", folder = "Warlock", minLevel = 50, maxLevel = 54,
			reward = { { spell = 691, spellName = "Summon Felhunter" }, { item = 20536, itemName = "Soul Harvester", quality = 3, choice = true },
				{ item = 20534, itemName = "Abyss Shard", quality = 3, choice = true } },
			steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
		table.insert(uistub.order, id)
		local cached, requested, spellsRequested = {}, {}, {}
		local names = { [20536] = "Soul Harvester", [20534] = "Abyss Shard" }
		local function link(item) return "|cff0070dd|Hitem:" .. item .. "::::::::50:::::|h[" .. names[item] .. "]|h|r" end
		local C = Polestar.Compat
		C.RequestItem = function(item) if cached[item] then return true end requested[#requested + 1] = item; return false end
		C.ItemLink = function(item) return cached[item] and link(item) or nil end
		C.RequestSpell = function(spell) spellsRequested[#spellsRequested + 1] = spell; return false end
		C.SpellLink = function(spell) return "|cff71d5ff|Hspell:" .. spell .. ":0|h[Summon Felhunter]|h|r" end
		GameTooltip.GetOwner = function(self) return self.owner end
		GameTooltip.IsOwned = function(self, f) return self.owner == f end
		GameTooltip.SetHyperlink = function(self, l)
			local item = tonumber(l:match("item:(%d+)"))
			self.lines = { cached[item] and names[item] or "Retrieving item information" }
		end
		GameTooltip.SetSpellByID = function(self, spell) self.lines = { "spell " .. spell } end
		local calls = {}
		function IsModifiedClick(kind)
			if kind == "CHATLINK" then return stub.keys.shift == true end
			if kind == "DRESSUP" then return stub.keys.ctrl == true end
			return (stub.keys.shift or stub.keys.ctrl or stub.keys.alt) and true or false
		end
		ChatFrameUtil = { InsertLink = function(l) calls[#calls + 1] = "chat " .. l; return true end }
		function DressUpItemLink(l) calls[#calls + 1] = "dressup " .. l; return true end
		function HandleModifiedItemClick(l)
			if IsModifiedClick("CHATLINK") and ChatFrameUtil.InsertLink(l) then return true end
			if IsModifiedClick("DRESSUP") then return DressUpItemLink(l) end
			return false
		end
		Polestar.Hooks.ItemClick("test", function(_, item) if IsAltKeyDown() then calls[#calls + 1] = "guide " .. item end end)
		Polestar.Set("ui.pickerFaction", "All")
		UI.ShowPicker()
		P.Select(id)
		local d = D()
		local r = { requested = requested, spellsRequested = spellsRequested }
		local spell, harvester, shard = d.Rewards[1], d.Rewards[2], d.Rewards[3]
		stub.RunScript(harvester, "OnEnter")
		r.before = { GameTooltip.lines[1], GameTooltip:IsShown() }
		cached[20536] = true
		stub.fire("GET_ITEM_INFO_RECEIVED", 20534, true)
		r.other = GameTooltip.lines[1]
		stub.fire("GET_ITEM_INFO_RECEIVED", 20536, true)
		r.after = { GameTooltip.lines[1], GameTooltip.owner == harvester }
		stub.RunScript(harvester, "OnLeave")
		stub.fire("GET_ITEM_INFO_RECEIVED", 20536, true)
		r.left = GameTooltip:IsShown()
		cached[20534] = true
		stub.RunScript(spell, "OnEnter")
		stub.fire("SPELL_DATA_LOAD_RESULT", 691, true)
		r.spellTip = GameTooltip.lines[1]
		stub.keys.ctrl = true; stub.RunScript(harvester, "OnClick", "LeftButton"); stub.keys.ctrl = false
		stub.keys.shift = true; stub.RunScript(harvester, "OnClick", "LeftButton"); stub.RunScript(spell, "OnClick", "LeftButton"); stub.keys.shift = false
		stub.keys.alt = true; stub.RunScript(harvester, "OnClick", "LeftButton")
		cached[20534] = false
		stub.RunScript(shard, "OnClick", "LeftButton"); stub.keys.alt = false
		stub.RunScript(harvester, "OnClick", "LeftButton")
		r.calls = calls
		emit(r)"#);
	assert_eq!(out["requested"].as_array().unwrap()[..2], [20536, 20534], "the pane asks for its reward items as it paints them");
	assert_eq!(out["spellsRequested"].as_array().unwrap()[..1], [691], "and for its spells");
	assert_eq!(out["before"], json!(["Retrieving item information", true]));
	assert_eq!(out["other"], "Retrieving item information", "another item arriving leaves the tooltip alone");
	assert_eq!(out["after"], json!(["Soul Harvester", true]), "the item arriving fills the tooltip in");
	assert_eq!(out["left"], false, "nothing reopens once the cursor has left");
	assert_eq!(out["spellTip"], "spell 691");
	assert_eq!(
		out["calls"],
		json!([
			"dressup |cff0070dd|Hitem:20536::::::::50:::::|h[Soul Harvester]|h|r",
			"chat |cff0070dd|Hitem:20536::::::::50:::::|h[Soul Harvester]|h|r",
			"chat |cff71d5ff|Hspell:691:0|h[Summon Felhunter]|h|r",
			"guide 20536",
			"guide 20534",
		]),
		"Ctrl tries it on, Shift links the item or spell, Alt still guides (an uncached item too); a plain click does nothing"
	);
}

#[test]
fn load_guide_replaces_the_current_tab_open_in_new_tab_adds_one_double_click_and_enter_load() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", false)
		local r = {}
		UI.ShowPicker(); P.SetCategory("Leveling"); P.Select("forever/alliance/02-westfall")
		D().Load:Click()
		r.load = { lastCall("SetGuide"), Polestar.Get("ui.shown"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.Select("forever/alliance/dwarf-gnome/01-dun-morogh")
		D().NewTab:Click()
		r.newTab = { lastCall("OpenTab"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.SetCategory("Professions")
		stub.RunScript(rowFor("Cooking 1-300"), "OnDoubleClick", "LeftButton")
		r.double = { lastCall("SetGuide"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.SetQuery("darkshore")
		stub.RunScript(PolestarPicker.Search, "OnEnterPressed")
		r.enter = { lastCall("SetGuide"), PolestarPicker:IsShown() }
		emit(r)"#);
	assert_eq!(out["load"], json!([["SetGuide", "forever/alliance/02-westfall"], true, false]));
	assert_eq!(out["newTab"], json!([["OpenTab", "forever/alliance/dwarf-gnome/01-dun-morogh"], false]));
	assert_eq!(out["double"], json!([["SetGuide", "forever/professions/cooking"], false]));
	assert_eq!(out["enter"], json!([["SetGuide", "forever/alliance/03-darkshore"], false]));
}

#[test]
fn from_the_guide_window_s_loading_opens_a_new_tab_faction_buttons_write_the_filter_no_tabs_api_no_new_tab_button() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		UI.ShowPicker({ newTab = true })
		local r = { subtitle = PolestarPicker.Subtitle:GetText(), newTabMode = P.IsNewTabMode() }
		for _, b in ipairs(PolestarPicker.factionButtons) do if b.psKey == "Horde" then b:Click() end end
		r.filter = Polestar.Get("ui.pickerFaction")
		P.SetCategory("Leveling")
		P.Select("forever/horde/orc-troll/01-durotar")
		r.primary = { load = D().Load.psPrimary or false, newTab = D().NewTab.psPrimary or false }
		r.tip = rowFor("Durotar").psTip
		stub.RunScript(rowFor("Durotar"), "OnDoubleClick", "LeftButton")
		r.call = lastCall("OpenTab")
		r.tabs = #select(1, Polestar.Engine.GetTabs())
		emit(r)"#);
	assert_eq!(
		out,
		json!({
			"subtitle": "Pick a guide to open in a new tab.", "newTabMode": true, "filter": "Horde", "primary": { "load": false, "newTab": true },
			"call": ["OpenTab", "forever/horde/orc-troll/01-durotar"], "tabs": 4,
			"tip": "Double-click a guide or press Enter to open it in a new tab.",
		})
	);
	let plain = run_all(
		r#"
		UI.ShowPicker(); P.Select("forever/alliance/02-westfall")
		emit({ newTab = D().NewTab:IsShown(), load = D().Load.Label:GetText(), primary = D().Load.psPrimary or false })"#,
		"{ noTabs = true }",
	)
	.remove(0);
	assert_eq!(plain, json!({ "newTab": false, "load": "Load guide", "primary": true }));
}

#[test]
fn home_continue_cards_for_the_open_tabs_and_the_suggested_guides_a_card_selects_a_double_click_continues() {
	let out = run(r#"
		uistub.player.level = 10
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		local cards = {}
		for _, f in ipairs(stub.frames) do
			if f.psIndex and rawget(f, "Pct") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then cards[#cards + 1] = f end
		end
		table.sort(cards, function(a, b) return a.psIndex < b.psIndex end)
		local info = {}
		for i, c in ipairs(cards) do info[i] = { c.Title:GetText(), c.Step:GetText(), c.Pct:GetText(), c.Note:GetText() } end
		local r = { view = P.View(), homeOn = tab("home").psSelected, folders = folders(), suggested = lines(), info = info, shown = P.shown.cards }
		cards[2]:Click()
		r.selected = { P.Selected(), D().Title:GetText(), PolestarPicker:IsShown() }
		stub.RunScript(cards[2], "OnDoubleClick", "LeftButton")
		r.continued = { lastCall("SetGuide"), select(2, Polestar.Engine.GetTabs()), PolestarPicker:IsShown() }
		emit(r)"#);
	assert_eq!(out["view"], "home");
	assert_eq!(out["homeOn"], true);
	assert_eq!(out["folders"], json!(["Continue 3", "Suggested for you 2"]));
	// The guide for the player's level is always suggested, open or not (its row says "Tab 1"); level 10 is within
	// two levels of its follow-up (12).
	assert_eq!(out["suggested"], json!(["Elwynn Forest (1\u{2013}13) | Tab 1", "Westfall (12\u{2013}17)"]));
	assert_eq!(out["shown"], 3);
	assert_eq!(out["info"], json!([["Elwynn Forest", "Step 3 of 8", "29%", "Tab 1"], ["Tailoring 1-300", "Step 2 of 4", "25%", "Tab 2"], ["Stormwind Reputation", "Step 2 of 2", "50%", "Tab 3"],]));
	assert_eq!(out["selected"], json!(["forever/professions/tailoring", "Tailoring 1-300", true]));
	assert_eq!(out["continued"], json!([["SetGuide", "forever/professions/tailoring"], 2, false]));
}

// "Suggested for you" always names the guide for the player's level, even when it is open; a follow-up only joins
// it near the end: at level 9, Elwynn Forest (1-13) open must not send the player on to Westfall (12-17).
#[test]
fn home_always_suggests_the_guide_for_the_player_s_level_and_its_follow_up_only_within_two_levels() {
	let out = run(r#"
		uistub.player.level = 9
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		emit({ folders = folders(), suggested = lines() })"#);
	assert_eq!(out["folders"], json!(["Continue 3", "Suggested for you 1"]));
	assert_eq!(out["suggested"], json!(["Elwynn Forest (1\u{2013}13) | Tab 1"]));
}

#[test]
fn current_lists_the_open_tabs_tab_and_progress_check_when_finished_recent_keeps_the_last_10_loaded() {
	let out = run(r#"
		uistub.openTabs(TABS, 1)
		uistub.complete()
		UI.ShowPicker()
		tab("current"):Click()
		local r = { view = P.View(), current = lines() }
		tab("recent"):Click()
		r.recent = lines()
		r.stored = Polestar.CharState().ui.recentGuides[1]
		-- Every guide that becomes the loaded one goes to the front, once.
		local ids = {}
		for _, id in ipairs(uistub.order) do ids[#ids + 1] = id end
		for i = 1, 12 do Polestar.Fire("GUIDE_CHANGED", ids[i]) end
		Polestar.Fire("GUIDE_CHANGED", ids[5])
		Polestar.Fire("GUIDE_CHANGED", nil)
		local list = Polestar.CharState().ui.recentGuides
		r.count, r.first, r.second, r.unique = #list, list[1], list[2], true
		local seen = {}
		for _, id in ipairs(list) do if seen[id] then r.unique = false end; seen[id] = true end
		r.rows = #rows()
		emit(r)"#);
	assert_eq!(out["view"], "current");
	assert_eq!(
		out["current"],
		json!(["\u{2713} Elwynn Forest (1\u{2013}13) | Tab 1  \u{b7}  100%", "Tailoring 1-300 (5\u{2013}60) | Tab 2  \u{b7}  25%", "Stormwind Reputation (12\u{2013}60) | Tab 3  \u{b7}  50%",])
	);
	assert_eq!(out["recent"], json!(["\u{2713} Elwynn Forest (1\u{2013}13) | Tab 1"]));
	assert_eq!(out["stored"], "forever/alliance/human/01-elwynn-forest");
	assert_eq!(out["count"], 10);
	assert_eq!(out["first"], "forever/alliance/skyborne/01-zephras-isle");
	assert_eq!(out["second"], "forever/legacy/legacy-challenges");
	assert_eq!(out["unique"], true);
	assert_eq!(out["rows"], 10);
}

#[test]
fn favorites_the_star_in_the_details_toggles_a_guide_in_charstate_ui_favoriteguides_and_the_favorites_category() {
	let out = run(r#"
		UI.ShowPicker()
		P.Select("forever/alliance/02-westfall")
		local star = D().Star
		local r = { before = star.psActive or false }
		star:Click()
		r.after = { star.psActive, star.psTip, Polestar.CharState().ui.favoriteGuides["forever/alliance/02-westfall"], nav("Favorites").Count:GetText() }
		nav("Favorites"):Click()
		r.list = lines()
		r.folders = folders()
		star:Click()
		r.removed = { Polestar.CharState().ui.favoriteGuides["forever/alliance/02-westfall"] or false, #rows(), PolestarPicker.Empty:IsShown() }
		emit(r)"#);
	assert_eq!(
		out,
		json!({
			"before": false,
			"after": [true, "Remove from favourites", true, "1"],
			"list": ["Westfall (12\u{2013}17)"], "folders": ["Alliance 1\u{2013}30 1"],
			"removed": [false, 0, true],
		})
	);
}

#[test]
fn the_details_art_the_zone_s_painting_from_the_client_around_the_guide_s_focus_the_night_band_without_it() {
	let out = run(r#"
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id)
			if id == 1436 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
			return {}
		end
		C_Map.GetMapArtLayerTextures = function() local t = {}; for i = 1, 12 do t[i] = 200000 + i end; return t end
		uistub.guides["forever/alliance/02-westfall"].zone = 1436
		Polestar.Engine.GuideFocus = function(id) if id == "forever/alliance/02-westfall" then return 56, 47 end end
		UI.ShowPicker()
		P.Select("forever/alliance/02-westfall")
		local a = D().Art
		local tiles = 0
		for _, t in ipairs(a.Tiles) do if t:IsShown() then tiles = tiles + 1 end end
		local _, _, _, cx = a.Canvas:GetPoint(1)
		local r = { painted = P.detail.art, band = a.Band:IsShown(), tiles = tiles, first = a.Tiles[1]:GetTexture(), cw = a.Canvas:GetWidth(), cx = cx, w = a:GetWidth() }
		P.Select("forever/alliance/03-darkshore")
		local shown = 0
		for _, t in ipairs(a.Tiles) do if t:IsShown() then shown = shown + 1 end end
		r.other = { painted = P.detail.art, band = a.Band:IsShown(), tiles = shown }
		Polestar.CharState().ui.pickerSelected = "gone"
		PolestarPicker:Hide()
		Polestar.Engine.SetGuide(nil)
		uistub.suggest = nil
		UI.ShowPicker()
		r.none = { P.detail == nil, D().EmptyTitle:IsShown(), a.Band:IsShown(), D().Load:IsShown() }
		emit(r)"#);
	assert_eq!(out["painted"], true);
	assert_eq!(out["band"], false);
	let tiles = out["tiles"].as_f64().unwrap();
	assert!(tiles > 0.0 && tiles < 12.0, "only the tiles that meet the art are drawn ({} of 12)", out["tiles"]);
	let first = out["first"].as_f64().unwrap();
	assert!(first > 200000.0 && first <= 200012.0, "tiles come from the zone's art layer");
	// The focus (56%) sits at the band's centre, the painting never showing past its edge.
	let (cx, w, cw) = (out["cx"].as_f64().unwrap(), out["w"].as_f64().unwrap(), out["cw"].as_f64().unwrap());
	assert!((-cx + w / 2.0 - 0.56 * cw).abs() < 0.5, "centre {}", out["cx"]);
	assert_eq!(out["other"], json!({ "painted": false, "band": true, "tiles": 0 }));
	assert_eq!(out["none"], json!([true, true, true, false]));
}

// A `next` option with `when` is offered only while it holds (Engine.RouteOffered): the "Next" fact and the
// follow-ups Home suggests name only the options offered now.
#[test]
fn the_next_fact_and_the_suggested_follow_ups_list_only_the_options_offered_now() {
	let out = run(r#"
		uistub.player.level = 10
		uistub.openTabs(TABS, 1)
		local desolace, feralas = "forever/alliance/30-40/02-desolace", "forever/alliance/40-50/03-feralas"
		local offered = {}
		Polestar.Engine.RouteOffered = function(from, id) return offered[id] ~= false end
		UI.ShowPicker()
		local r = { suggested = lines() }
		offered["forever/alliance/02-westfall"] = false
		P.Render()
		r.hidden = lines()
		P.SetCategory("Leveling")
		rowFor("Westfall"):Click()
		westfall.nextChoices, westfall.nextWhen = { desolace, feralas }, { [feralas] = { { k = "level", op = ">=", n = 43 } } }
		P.Render()
		r.both = P.detail.facts[#P.detail.facts]
		offered[feralas] = false
		P.Render()
		r.one = P.detail.facts[#P.detail.facts]
		offered[desolace] = false
		P.Render()
		r.none = P.detail.facts[#P.detail.facts][1]
		westfall.nextChoices, westfall.nextWhen = nil, nil
		emit(r)"#);
	assert_eq!(out["suggested"], json!(["Elwynn Forest (1\u{2013}13) | Tab 1", "Westfall (12\u{2013}17)"]));
	assert_eq!(out["hidden"], json!(["Elwynn Forest (1\u{2013}13) | Tab 1"]));
	assert_eq!(out["both"], json!(["Next", "Your choice: Desolace or Feralas"]));
	assert_eq!(out["one"], json!(["Next", "Desolace (31\u{2013}34)"]));
	assert_ne!(out["none"], "Next");
}
