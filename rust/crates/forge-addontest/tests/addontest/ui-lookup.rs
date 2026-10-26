//! The Lookup section of the hub (addon/Polestar/UI/Lookup.lua) and its rows in the guide menu's search, against
//! the fake Engine of tests/lua/stub_ui.lua and the fake Search / Codex / Lookup runtime of
//! tests/lua/stub_lookup.lua; the last test runs the real runtime over the synthetic Codex pack
//! (tests/fixtures/codex).

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

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
local function navKeys()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then out[#out + 1] = b.psKey end end
	return out
end
local function type_(text)
	local box = Polestar.UI.Picker.search
	box:SetText(text)
	stub.RunScript(box, "OnTextChanged", true)
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

/// Each source's `keys`, as rows (`sources.map((s) => [s.a, s.b, ...])`; a missing field is null).
fn cols(sources: &Value, keys: &[&str]) -> Value {
	Value::Array(sources.as_array().unwrap().iter().map(|s| Value::Array(keys.iter().map(|k| s[*k].clone()).collect())).collect())
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
	assert_eq!(out["d"]["primary"], "Guide me");
	assert!(is_match(text(&out["d"]["note"]), r"Builds a guide to Lelanai"));
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
		Polestar.Lookup.Show(nil, "mount", 8631)
		LK.details.Primary:Click()
		local primary = lookupstub.calls[2]
		Polestar.Lookup.Show(nil, "mount", 8631)
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ pick = pick, afterSource = afterSource, primary = primary, enter = lookupstub.calls[3], shown = lookupShown(), ui = Polestar.Get("ui.shown") })"#);
	assert_eq!(out["pick"], json!({ "sel": true, "other": false }));
	assert_eq!(out["afterSource"], json!({ "call": ["mount", 8631, 2], "shown": false, "ui": true }));
	assert_eq!(out["primary"], json!(["mount", 8631, false]));
	assert_eq!(out["enter"], json!(["mount", 8631, false]));
	assert_eq!(out["shown"], false);
	assert_eq!(out["ui"], true);
}

#[test]
fn a_rare_drop_out_of_reach_chance_the_reason_guide_me_off_a_curated_guide_says_open_guide() {
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
	assert_eq!(out["drop"]["primary"], "Guide me");
	assert_eq!(out["drop"]["enabled"], false);
	assert!(is_match(text(&out["drop"]["note"]), r"No source is open"));
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
	assert_eq!(out["idle"]["navs"], json!(["all"]), "no kind is offered that nothing was found in");
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
	let pack = write_codex_pack(&sample_codex(), &CodexOpts { ..Default::default() });
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"])],
		script: r#"uistub.install()
stub.login()
local LK = Polestar.UI.Lookup
Polestar.Lookup.Show("saber")
local search = { groups = LK.shown.groups, sel = LK.Selected().kind, codex = LK.root.CodexLine:GetText() }
Polestar.Lookup.Show(nil, "mount", 13335)
emit({ search = search, title = LK.detail.title, query = LK.Query(), sources = LK.detail.sources, primary = LK.detail.primary })"#
			.into(),
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
	assert_eq!(out["primary"], "Guide me");
	drop(pack);
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
fn an_empty_search_lists_the_recent_lookups_newest_first_at_most_10_never_a_data_set() {
	let out = run(r#"
		UI.ShowLookup()
		local first = { rows = #rowTexts(LK.results.Child), empty = LK.shown.empty, queries = lookupstub.queries }
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
	assert_eq!(out["auto"], 2);
	assert_eq!(out["recent"]["rows"], json!(["Lelanai", "Deathcharger's Reins", "Reins of the Striped Frostsaber"]));
	assert!(is_match(text(&out["recent"]["empty"]), r"Type a name"), "the hint under the recent lookups");
	assert_eq!(out["recent"]["navs"], json!(["all"]));
	assert_eq!(out["saved"], "Baron Rivendare");
	assert!(out["n"].as_f64().unwrap() <= 10.0);
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
