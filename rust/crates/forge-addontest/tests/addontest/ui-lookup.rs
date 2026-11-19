//! The Lookup section of the hub (addon/Polestar/UI/Lookup.lua) and its rows in the guide menu's search, against
//! the fake Engine of tests/lua/stub_ui.lua and the fake Search / Codex / Lookup runtime of
//! tests/lua/stub_lookup.lua; the last test runs the real runtime over the synthetic Codex pack
//! (tests/fixtures/codex).

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

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
emit({ search = search, title = LK.detail.title, query = LK.Query(), sources = LK.detail.sources, primary = LK.detail.primary, note = LK.detail.note })"#
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
	assert_eq!(out["primary"], Value::Null, "the real runtime builds no guide to a mount");
	assert!(is_match(text(&out["note"]), r"^No guide to this mount yet"));
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
			stub.RunScript(well, "OnLeave")
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
		Polestar.Lookup.Show(nil, "item", 4386)
		stub.RunScript(well, "OnEnter")
		LK.Select(nil)
		local leftEmpty = GameTooltip:IsShown()
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
