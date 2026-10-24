//! The Dungeons section of the hub (addon/Polestar/UI/Dungeons.lua) over the real Dungeons runtime and the
//! synthetic Codex pack of tests/fixtures/codex/dungeons.json (Wailing Caverns with its quests and bosses, the
//! Deadmines, a Forever dungeon with nothing known), against the fake Engine of tests/lua/stub_ui.lua. The
//! character: a level 20 Tauren.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use forge_data::codex::client::{Corpse, InstanceMap};
use forge_data::codex::journal::{build_journal, emit_journal, Codex, JournalInputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const FILES: [&str; 6] = ["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"];

fn v(x: &Value) -> V {
	if x.is_null() {
		V::obj()
	} else {
		parse_json(&x.to_string()).unwrap()
	}
}

fn instance_map(m: &Value) -> InstanceMap {
	let list = |k: &str| m[k].as_array().map(|a| a.iter().filter_map(Value::as_f64).collect()).unwrap_or_default();
	InstanceMap {
		id: m["id"].as_f64().unwrap(),
		name: m["name"].as_str().unwrap_or("").to_string(),
		raid: m["raid"].as_bool().unwrap_or(false),
		players: m["players"].as_f64(),
		area: m["area"].as_f64(),
		areas: list("areas"),
		inner: list("inner"),
		zones: list("zones"),
		corpse: m["corpse"].as_object().map(|c| Corpse { c: c["c"].as_f64().unwrap(), x: c["x"].as_f64().unwrap(), y: c["y"].as_f64().unwrap() }),
	}
}

/// The fixture's Codex as a pack, with its Dungeons journal (`buildJournal(fixture.inputs, fixture.codex)`).
fn pack() -> CodexPack {
	let f = fixture("dungeons.json");
	let (codex, inputs) = (&f["codex"], &f["inputs"]);
	let maps: Vec<InstanceMap> = inputs["client"]["instanceMaps"].as_array().map(|a| a.iter().map(instance_map).collect()).unwrap_or_default();
	let fv = &inputs["forever"];
	let (frames, quests, objects, zones, dungeons) = (v(&fv["mapFrames"]["forever"]), v(&fv["quests"]), v(&fv["objects"]), v(&fv["zones"]), v(&fv["dungeons"]));
	let attunements = v(&inputs["attunementTable"]);
	let c = Codex {
		instances: v(&codex["instances"]),
		quests: v(&codex["quests"]),
		npcs: v(&codex["npcs"]),
		items: v(&codex["items"]),
		objects: v(&codex["objects"]),
		factions: v(&codex["factions"]),
		zones: v(&codex["zones"]),
	};
	let (journal, _) = build_journal(
		&JournalInputs { maps: &maps, frames: &frames, fv_quests: &quests, fv_objects: &objects, fv_zones: &zones, fv_dungeons: &dungeons, journal_quests: &[], attunement_table: &attunements },
		&c,
	);
	write_codex_pack(codex, &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), emit_journal(&journal))], ..Default::default() })
}

const SETUP: &str = r#"uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 20, "Tauren", "DRUID", "Horde"
OpenWorldMap = function(map) uistub.worldMap = map end
local done, log = { [1490] = true }, { [914] = true }
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
Polestar.Compat.IsOnQuest = function(id) return log[id] or false end
Polestar.Compat.IsQuestReadyForTurnIn = function() return false end
local DS, P = Polestar.UI.DungeonsSection, Polestar.UI.Picker
local function navs()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then out[#out + 1] = { b.psKey, b.Label:GetText(), b.Count:IsShown() and b.Count:GetText() or "" } end
	end
	return out
end
local function cardNames()
	local out = {}
	for _, c in ipairs(DS.cards) do if c:IsShown() then out[#out + 1] = c.Name:GetText() end end
	return out
end
local function tabs()
	local out = {}
	for _, t in ipairs(PolestarPicker.tabButtons) do if t:IsShown() then out[#out + 1] = t.Label:GetText() end end
	return out
end
local function segs()
	local _, _, _, s = DS.Frames()
	local out = {}
	for _, b in ipairs(s) do out[#out + 1] = { b.psKey, b:IsShown(), b.Selected:IsShown() } end
	return out
end
local function block(id)
	for _, b in ipairs(DS.blocks) do if b:IsShown() and b.psQuest == id then return b end end
end
local function shownTexts(pool, field)
	local out = {}
	for _, r in ipairs(pool) do if r:IsShown() then out[#out + 1] = r[field]:GetText() end end
	return out
end
-- The shown chain rows, tiles or chips of every drawn quest block.
local function kids(field)
	local out = {}
	for _, b in ipairs(DS.blocks) do
		if b:IsShown() then for _, k in ipairs(b[field]) do if k:IsShown() then out[#out + 1] = k end end end
	end
	return out
end
local function chipTexts()
	local out = {}
	for _, c in ipairs(kids("Chips")) do out[#out + 1] = c.Text:GetText() end
	return out
end
local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
"#;

fn run_with(script: &str, with_pack: bool) -> Vec<Value> {
	let pack = with_pack.then(pack);
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.as_ref().map(|p| p.stub_lua.clone()).unwrap_or_default(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{SETUP}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, true)
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().unwrap_or(&Vec::new()).iter().map(|x| x.as_str().unwrap_or("").to_string()).collect()
}

#[test]
fn show_dungeon_nil_opens_the_hub_at_home_level_bands_in_the_sidebar_the_dungeons_for_your_level_as_cards_the_faction_filter_yours_first() {
	let out = run(r#"
		Polestar.Dungeons.Open()
		emit({ section = P.Section(), navs = navs(), cards = cardNames(), segs = segs(), title = PolestarPicker.Title:GetText(),
			sub = PolestarPicker.Subtitle:GetText(), tabRow = PolestarPicker.TabRow:IsShown(), shown = DS.Shown(),
			stats = DS.cards[1].Stats:GetText(), chip = DS.cards[1].Yours:IsShown() })"#);
	let out = &out[0];
	assert_eq!(out["section"], "Dungeons");
	assert_eq!(
		out["navs"],
		json!([
			["level", "For your level", "1"],
			["all", "All dungeons", "3"],
			["10", "10\u{2013}20", "2"],
			["20", "20\u{2013}30", ""],
			["30", "30\u{2013}40", ""],
			["40", "40\u{2013}50", ""],
			["50", "50\u{2013}60", "1"],
		])
	);
	assert_eq!(out["cards"], json!(["Wailing Caverns"]), "the Deadmines (Alliance quests only) is not a Horde dungeon for your level");
	assert_eq!(out["segs"], json!([["Horde", true, true], ["Alliance", true, false], ["All", true, false]]));
	assert_eq!(out["title"], "For your level");
	assert!(is_match(out["sub"].as_str().unwrap(), r"^Level 20 .+ 1 dungeon to run now$"), "{}", out["sub"]);
	assert_eq!(out["tabRow"], true, "the tab row stays for the faction filter");
	assert_eq!(out["shown"]["band"], "level");
	assert_eq!(out["stats"], "17\u{2013}24  \u{b7}  The Barrens  \u{b7}  4 quests");
	assert_eq!(out["chip"], false, "no \"Your level\" chip where every card is");
}

#[test]
fn home_all_dungeons_groups_by_band_the_faction_filter_changes_the_counts_search_narrows_and_enter_opens_the_first() {
	let out = run(r#"
		Polestar.Dungeons.Open()
		DS.SetBand("all")
		local deadmines = DS.cards[1].Stats:GetText()
		local all = { cards = cardNames(), heads = DS.Shown().heads, title = PolestarPicker.Title:GetText(), yours = DS.cards[2].Yours:IsShown(),
			forever = DS.cards[3].Forever:IsShown() }
		DS.SetFaction("All")
		local both = DS.cards[2].Stats:GetText()
		DS.SetFaction("Alliance")
		local alliance = { DS.cards[1].Stats:GetText(), segs() }
		local box = Polestar.UI.Picker.search
		box:SetText("wail"); stub.RunScript(box, "OnTextChanged", true)
		local found = { cards = cardNames(), title = PolestarPicker.Title:GetText(), sub = PolestarPicker.Subtitle:GetText() }
		DS.Enter()
		emit({ deadmines = deadmines, all = all, both = both, alliance = alliance, found = found, page = DS.Page(), tab = DS.Tab() })"#);
	let out = &out[0];
	assert_eq!(out["all"]["cards"], json!(["The Deadmines", "Wailing Caverns", "Blackmaw Hold"]));
	assert!(is_match(out["deadmines"].as_str().unwrap(), "No Horde quests$"), "never \"0 quests\"");
	assert_eq!(out["all"]["heads"], 2);
	assert_eq!(out["all"]["title"], "Dungeons");
	assert_eq!(out["all"]["yours"], true, "your level is marked under All");
	assert_eq!(out["all"]["forever"], true);
	assert!(is_match(out["both"].as_str().unwrap(), "3 Alliance, 4 Horde quests$"), "{}", out["both"]);
	assert!(is_match(out["alliance"][0].as_str().unwrap(), "1 quest$"), "{}", out["alliance"][0]);
	assert_eq!(out["alliance"][1][1], json!(["Alliance", true, true]));
	assert_eq!(out["found"]["cards"], json!(["Wailing Caverns"]));
	assert_eq!(out["found"]["title"], "Search");
	assert_eq!(out["page"], "wailing-caverns");
	assert_eq!(out["tab"], "quests");
}

// A French client whose names pack lands with Home open: the cards take the names Dungeons.List gives from then on.
#[test]
fn home_a_names_pack_landing_late_renames_the_cards() {
	let out = run(r#"
		Polestar.Dungeons.Open()
		DS.SetBand("all")
		local before = cardNames()
		local list = Polestar.Dungeons.List
		Polestar.Dungeons.List = function(...)
			local out = {}
			for i, d in ipairs(list(...)) do
				local c = {}
				for k, v in pairs(d) do c[k] = v end
				if c.name == "Wailing Caverns" then c.name = "Cavernes des Lamentations" end
				out[i] = c
			end
			return out
		end
		Polestar.Fire("NAMES_LOADED")
		emit({ before = before, after = cardNames() })"#);
	assert!(strs(&out[0]["before"]).contains(&"Wailing Caverns".to_string()));
	assert!(strs(&out[0]["after"]).contains(&"Cavernes des Lamentations".to_string()));
}

#[test]
fn a_page_the_painting_header_with_the_name_facts_and_actions_tabs_with_counts_guide_me_and_show_on_map_act() {
	let out = run(r#"
		-- Nothing in the log: the hand-in stays away, so "Show on map" keeps its place among three actions.
		log[914] = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local head = { pg.Title:GetText(), pg.Sub:GetText(), pg.GoQuiet:IsShown(), pg.MapBtn:IsShown(), pg.Back:IsShown(), pg.Forever:IsShown(),
			PolestarPicker.Title:GetText(), PolestarPicker.Title:GetAlpha(), PolestarPicker.Band:IsShown(), pg.Art:IsShown() }
		local nav = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) nav = { map, x, y, label } return true end
		pg.GoQuiet:Click()
		pg.MapBtn:Click()
		pg.Back:Click()
		emit({ head = head, tabs = (function() DS.Open("wailing-caverns") return tabs() end)(), nav = nav, map = uistub.worldMap,
			back = (function() DS.Home() return { DS.Page() or false, PolestarPicker.Title:GetAlpha(), PolestarPicker.Band:IsShown(), pg:IsShown() } end)() })"#);
	let out = &out[0];
	// The facts break between two facts where the actions leave too little room.
	assert_eq!(out["head"], json!(["Wailing Caverns", "Levels 17\u{2013}24  \u{b7}  The Barrens  \u{b7}  10 players\n4 bosses", true, true, true, false, "Wailing Caverns", 0, false, true]));
	assert_eq!(out["tabs"], json!(["Quests  4", "Attunement", "Bosses  4", "Map"]), "the fixture gives Wailing Caverns an attunement");
	assert_eq!(out["nav"], json!([1413, 46, 36.4, "Wailing Caverns"]));
	assert_eq!(out["map"], 1413);
	assert_eq!(out["back"], json!([false, 1, true, false]));
}

#[test]
fn the_levels_chip_what_the_quests_still_to_do_are_worth_hovering_it_shows_the_xp_a_bar_of_the_levels_it_spans_and_what_was_counted_none_at_60() {
	let out = run(r#"
		-- 19,800 of 23,200 into 20; the page's quests with XP known: 1,600 + 2,350 + 1,900.
		uistub.player.xp, uistub.player.xpMax = 19800, 23200
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local chip = { pg.XP:IsShown(), pg.XP.Text:GetText() }
		pg.XP:GetScript("OnEnter")(pg.XP)
		local t = Polestar.UI.LevelTip.Frame()
		local cells, marks = 0, {}
		for _, c in ipairs(t.Cells) do if c:IsShown() then cells = cells + 1 end end
		for _, m in ipairs(t.Marks) do if m:IsShown() then marks[#marks + 1] = m:GetText() end end
		local tip = { t:IsShown(), t.Head:GetText(), t.Levels:GetText(), t.XP:GetText(), t.Now:GetText(), t.Then:GetText(), t.Notes:GetText(),
			cells, marks, t.Cells[1].Gain:IsShown(), t.Cells[2].Gain:IsShown() }
		pg.XP:GetScript("OnLeave")(pg.XP)
		local left = t:IsShown()
		uistub.player.level = 60
		DS.Open("deadmines"); DS.Open("wailing-caverns")
		emit({ chip = chip, tip = tip, left = left, at60 = pg.XP:IsShown() })"#);
	let out = &out[0];
	assert_eq!(out["chip"], json!([true, "+24% of a level"]));
	assert_eq!(
		out["tip"],
		json!([
			true,
			"If you finish the quests here",
			"+24% of a level",
			"5,850 XP",
			"Now: 85% into level 20",
			"After: 9% into level 21",
			"3 quests for you, not done yet.\n1 more has no XP known and is not counted.",
			2,
			["20", "21", "22"],
			true,
			true,
		])
	);
	assert_eq!(out["left"], false, "leaving the chip hides the panel");
	assert_eq!(out["at60"], false, "at 60 the quests give no XP: no chip");
}

#[test]
fn the_levels_chip_below_the_quests_level_it_says_the_recommended_level_the_panel_says_so_first_and_sums_from_there_quests_only() {
	let out = run(r#"
		uistub.player.level = 10
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		pg.XP:GetScript("OnEnter")(pg.XP)
		local t = Polestar.UI.LevelTip.Frame()
		emit({ chip = pg.XP.Text:GetText(), need = t.Need:GetText(), now = t.Now:GetText(), first = t.Marks[1]:GetText(), notes = t.Notes:GetText() })"#);
	let out = &out[0];
	// Deviate Hides opens at 13, the lowest of the page's quests.
	assert_eq!(out["chip"], "Recommended: level 13");
	assert_eq!(out["need"], "You are level 10. Level 13 is recommended for the quests here; from there:");
	assert_eq!(out["now"], "Start: level 13");
	assert_eq!(out["first"], "13");
	assert!(!is_match(out["notes"].as_str().unwrap_or(""), "kills"), "a dungeon page counts its quests only");
}

#[test]
fn a_quest_with_a_chain_still_to_do_a_chip_after_its_rewards_says_what_the_quest_and_its_chain_are_worth_with_the_levels_panel_on_hover() {
	let out = run(r#"
		-- Nara Wildmane (650 XP) comes before Leaders of the Fang (2,350 XP).
		done[1490] = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local b = block(914)
		local c = b.ChainXP
		c:GetScript("OnEnter")(c)
		local t = Polestar.UI.LevelTip.Frame()
		emit({ shown = c:IsShown(), text = c.Text:GetText(), head = t.Head:GetText(), xp = t.XP:GetText(), notes = t.Notes:GetText(),
			after = select(4, c:GetPoint(1)) > select(4, b.Chips[1]:GetPoint(1)), own = b.Chips[1].Text:GetText(),
			plain = block(1486).ChainXP:IsShown() })
		c:GetScript("OnLeave")(c)
		done[1490] = true
		DS.Open("deadmines"); DS.Open("wailing-caverns")
		emit(block(914).ChainXP:IsShown())"#);
	let (open, done) = (&out[0], &out[1]);
	assert_eq!(open["shown"], true);
	assert_eq!(open["text"], "3,000 XP with its chain");
	assert_eq!(open["own"], "2,350 XP", "the quest's own XP chip stays");
	assert_eq!(open["after"], true, "after the reward chips");
	assert_eq!(open["head"], "If you finish this quest and the chain before it");
	assert_eq!(open["xp"], "3,000 XP");
	assert_eq!(open["notes"], "2 quests for you, not done yet.");
	assert_eq!(open["plain"], false, "a quest with no chain has none");
	assert_eq!(*done, json!(false), "the chain done: the quest's own XP says it all");
}

#[test]
fn hovering_a_quest_in_a_chain_shows_its_levels_state_objective_start_and_end_rewards_and_its_xp_at_your_level_when_that_is_less() {
	let out = run(r#"
		local function hover()
			local r = block(914).Chains[1]
			r:GetScript("OnEnter")(r)
			local lines = {}
			for i, l in ipairs(GameTooltip.lines) do lines[i] = plain(l) end
			return { owner = GameTooltip:GetOwner() == r, lines = lines }
		end
		Polestar.Dungeons.Open("wailing-caverns")
		emit(hover())
		uistub.player.level = 27
		DS.Open("deadmines"); DS.Open("wailing-caverns")
		emit(hover())"#);
	let (at20, at27) = (&out[0], &out[1]);
	assert_eq!(at20["owner"], true, "the tooltip is the row's");
	let text = strs(&at20["lines"]).join("\n");
	assert!(is_match(&text, "^Nara Wildmane"), "{text}");
	assert!(is_match(&text, "Level 20 {2}\u{b7} {2}Requires level 16"), "{text}");
	assert!(is_match(&text, "\nDone\n"), "this character has done it");
	assert!(is_match(&text, r"Starts \| "), "{text}");
	assert!(is_match(&text, r"Rewards \| 650 XP"), "{text}");
	assert!(!is_match(&text, "at your level"), "at 20 the level 20 quest gives its full XP");
	// At 27 the level 20 quest is 7 below: 60%.
	assert!(is_match(&strs(&at27["lines"]).join("\n"), "390 XP at your level"));
}

#[test]
fn a_page_with_quests_to_pick_up_pick_up_the_quests_is_the_primary_action_the_entrance_second_with_none_left_nothing_to_pick_up_says_why() {
	let out = run(r#"
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local function shown(b) return b:IsShown() and b.Label:GetText() or false end
		-- Right to left: the first shown button holds the band's corner.
		local function corner() for _, b in ipairs({ pg.Pickup, pg.Go, pg.PickupNone, pg.GoQuiet, pg.MapBtn }) do
			if b:IsShown() then local p = { b:GetPoint(1) } if p[1] == "BOTTOMRIGHT" then return b.Label:GetText() end end end end
		emit({ pickup = shown(pg.Pickup), go = shown(pg.Go), quiet = shown(pg.GoQuiet), none = shown(pg.PickupNone), corner = corner(),
			tip = { pg.Pickup.psTip, pg.Pickup.psTipLines } })
		done[1486], done[959] = true, true
		DS.Render()
		pg.PickupNone:Click()
		emit({ pickup = shown(pg.Pickup), go = shown(pg.Go), none = shown(pg.PickupNone), corner = corner(), tip = pg.PickupNone.psTipLines, printed = printed,
			tabs = #Polestar.Engine.GetTabs() })"#);
	let (open, none) = (&out[0], &out[1]);
	assert_eq!(json!([open["pickup"], open["go"], open["quiet"], open["none"], open["corner"]]), json!(["Pick up the quests", false, "Guide me to the entrance", false, "Pick up the quests"]));
	assert_eq!(open["tip"][0], "Pick up the quests");
	assert_eq!(
		open["tip"][1],
		json!(["A guide to the 2 quests here you can take, with what comes before them, ending at the entrance.", "1 more is in your log already.", "It opens in a new tab."]),
		"Deviate Hides and Trouble at the Docks; Leaders of the Fang is in the log; the Glowing Shard starts inside"
	);
	assert_eq!(json!([none["pickup"], none["go"], none["none"], none["corner"]]), json!([false, "Guide me to the entrance", "Nothing to pick up", "Guide me to the entrance"]));
	assert!(is_match(none["tip"][0].as_str().unwrap(), "^Nothing to pick up before the run"), "{}", none["tip"]);
	assert_eq!(none["printed"], json!([none["tip"][0]]), "the action says so");
	assert_eq!(none["tabs"], 0, "and opens no guide");
}

#[test]
fn hand_in_the_quests_shows_only_while_one_of_the_pages_quests_is_in_the_log_leads_once_one_is_finished_and_opens_the_hand_in_guide_nothing_finished_says_what_is_open() {
	let out = run(r#"
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		local function shown(b) return b:IsShown() and b.Label:GetText() or false end
		local function corner() for _, b in ipairs({ pg.HandIn, pg.HandInQuiet, pg.Pickup, pg.PickupQuiet, pg.Go, pg.PickupNone, pg.GoQuiet, pg.MapBtn }) do
			if b:IsShown() then local p = { b:GetPoint(1) } if p[1] == "BOTTOMRIGHT" then return b.Label:GetText() end end end end
		-- Leaders of the Fang is in the log, its gems still to get.
		pg.HandInQuiet:Click()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet), corner = corner(), tip = pg.HandInQuiet.psTipLines, printed = printed,
			tabs = #Polestar.Engine.GetTabs(), fits = pg.Sub:GetWidth() > 0, map = pg.MapBtn:IsShown(), go = shown(pg.GoQuiet) })
		log[914] = nil
		DS.Render()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet) })
		log[914] = true
		Polestar.Compat.IsQuestReadyForTurnIn = function(id) return id == 914 end
		local asked = {}
		Polestar.Dungeons.HandIn = function(key) asked[#asked + 1] = key return "lookup/handin/" .. key end
		DS.Render()
		emit({ lead = shown(pg.HandIn), quiet = shown(pg.HandInQuiet), pickup = shown(pg.Pickup), pickupQuiet = shown(pg.PickupQuiet),
			corner = corner(), tip = pg.HandIn.psTipLines, fits = pg.Sub:GetWidth() > 0 })
		pg.HandIn:Click()
		emit({ asked = asked, hub = PolestarPicker:IsShown() })"#);
	let (open, gone, ready, done2) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(json!([open["lead"], open["quiet"], open["corner"]]), json!([false, "Hand in the quests", "Pick up the quests"]), "beside \"Pick up the quests\", which leads");
	assert_eq!(open["tip"], json!(["Not finished yet: Leaders of the Fang."]));
	assert_eq!(open["printed"], json!([open["tip"][0]]), "the action says so");
	assert_eq!(open["tabs"], 0, "and opens no guide");
	assert_eq!(json!([open["go"], open["map"]]), json!(["Guide me to the entrance", false]), "three actions at most: \"Show on map\" gives way");
	assert_eq!(open["fits"], true, "the facts keep their room");
	assert_eq!(*gone, json!({ "lead": false, "quiet": false }), "nothing in the log: no hand-in");
	assert_eq!(json!([ready["lead"], ready["quiet"], ready["pickup"], ready["pickupQuiet"], ready["corner"]]), json!(["Hand in the quests", false, false, "Pick up the quests", "Hand in the quests"]));
	assert_eq!(ready["tip"], json!(["A guide to where the 1 finished quest here is turned in, and the follow-ups it opens there.", "It opens in a new tab."]));
	assert_eq!(ready["fits"], true);
	assert_eq!(*done2, json!({ "asked": ["wailing-caverns"], "hub": false }), "the guide opens and the hub steps aside");
}

#[test]
fn a_finished_pick_up_guide_offers_the_hand_in_while_the_dungeons_quests_are_in_the_log() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		local id = "lookup/pickup/wailing-caverns"
		uistub.guides[id] = { id = id, pack = "lookup", title = "Wailing Caverns: pick up the quests", category = "Lookup",
			lookup = { kind = "pickup", id = "wailing-caverns" }, steps = { { title = "Wailing Caverns", goals = { { t = "note", text = "n" } } } } }
		local asked = {}
		Polestar.Dungeons.HandIn = function(key) asked[#asked + 1] = key return "lookup/handin/" .. key end
		uistub.setGuide(id)
		uistub.complete()
		local e = GF.parts.empty
		local function state() return { title = e.Title:GetText(), text = e.Text:GetText(), primary = e.Primary:IsShown() and e.Primary.Label:GetText() or false,
			secondary = e.Secondary:IsShown() and e.Secondary.Label:GetText() or false } end
		local s = state()
		e.Primary:Click()
		s.asked = asked
		emit(s)
		log[914] = nil
		uistub.complete()
		emit(state())"#);
	assert_eq!(
		out[0],
		json!({
			"title": "Guide complete",
			"text": "After the run: a guide to where this dungeon's quests are turned in, and the follow-ups there.",
			"primary": "Hand in the quests",
			"secondary": "Choose a guide",
			"asked": ["wailing-caverns"],
		})
	);
	assert_eq!(out[1]["primary"], "Choose a guide", "nothing in the log: the usual end");
}

#[test]
fn quests_the_giver_line_is_a_link_with_a_prerequisite_still_to_do_it_points_at_that_one() {
	let out = run(r#"
		done[1490], log[914] = nil, nil
		Polestar.Dungeons.Open("wailing-caverns")
		local pins = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label } return true end
		local fang, hides = block(914), block(1486)
		fang.StartLink:Click()
		hides.StartLink:Click()
		emit({ pins = pins, fang = { fang.StartLink.psTip, fang.StartLink.psTipLines[1], fang.StartPin.psTip },
			hides = { hides.StartLink.psTip, hides.StartLink.psTipLines[1] } })"#);
	let out = &out[0];
	assert_eq!(out["pins"], json!([[1413, 52.2, 31.9, "Tonga Runetotem"], [1413, 46, 35.7, "Nalpak"]]));
	assert_eq!(out["fang"], json!(["Set the arrow to Tonga Runetotem", "First pick up Nara Wildmane, which comes before this quest.", "Set the arrow to Tonga Runetotem"]));
	assert_eq!(out["hides"], json!(["Set the arrow to Nalpak", "Where this quest starts."]));
}

#[test]
fn quests_one_block_per_quest_with_state_level_flags_objective_start_and_end_pins_the_chain_choice_tiles_and_reward_chips() {
	let out = run(r#"
		Polestar.Dungeons.Open("wailing-caverns")
		local fang = block(914)
		local hides = block(1486)
		local shard = block(6981)
		local pins = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label } return true end
		fang.StartPin:Click()
		for _, r in ipairs(kids("Chains")) do r.Pin:Click() end
		local tile
		for _, t in ipairs(kids("Tiles")) do if t.psID == 6505 then tile = t end end
		stub.RunScript(tile, "OnEnter")
		emit({ shown = DS.Shown(), order = (function() local t = {} for _, b in ipairs(DS.blocks) do if b:IsShown() then t[#t + 1] = b.psQuest end end return t end)(),
			fang = { fang.Title:GetText(), fang.Meta:GetText(), fang.State:IsShown() and fang.State.Text:GetText(), fang.Faction.Text:GetText(),
				plain(fang.Start:GetText()), plain(fang.End:GetText()), fang.ChainLabel:IsShown(), fang.ChooseLabel:IsShown(), fang.GetLabel:IsShown() },
			hides = { hides.Obj:GetText(), hides.State:IsShown(), hides.Faction:IsShown() },
			shard = { shard.Meta:GetText(), plain(shard.Start:GetText()), shard.GetLabel:IsShown(), shard.StartPin:IsEnabled() },
			chain = shownTexts(kids("Chains"), "Title"), chainSub = shownTexts(kids("Chains"), "Sub"),
			chainGlyph = kids("Chains")[1].Glyph:GetTexture(),
			tiles = shownTexts(kids("Tiles"), "Name"), chips = chipTexts(), pins = pins,
			tip = GameTooltip.owner == tile })"#);
	let out = &out[0];
	assert_eq!(out["order"], json!([1486, 959, 914, 6981]), "level order; the hidden errand stays out");
	assert_eq!(out["shown"]["quests"], json!(out["order"].as_array().unwrap().len()));
	assert_eq!(
		out["fang"],
		json!([
			"Leaders of the Fang",
			"Level 22  \u{b7}  Requires level 18  \u{b7}  Shareable",
			"In your log",
			"Horde",
			"Nara Wildmane  \u{b7}  Thunder Bluff",
			"Nara Wildmane  \u{b7}  Thunder Bluff",
			true,
			true,
			false,
		])
	);
	assert_eq!(out["hides"][1], false, "an open quest carries no state chip");
	assert_eq!(out["hides"][2], false, "no faction mark on a quest for both");
	let shard_meta = out["shard"][0].as_str().unwrap();
	assert!(is_match(shard_meta, "Picked up inside the dungeon"), "{shard_meta}");
	assert!(is_match(shard_meta, "Not shareable"), "{shard_meta}");
	assert_eq!(out["shard"][1], "Glowing Shard  \u{b7}  drops from Mutanus the Devourer");
	assert_eq!(out["shard"][2], true, "a fixed reward under \"You get\"");
	assert_eq!(out["chain"], json!(["Nara Wildmane"]));
	assert!(is_match(out["chainSub"][0].as_str().unwrap(), "^Level 20  \u{b7}  Tonga Runetotem, The Barrens$"), "{}", out["chainSub"]);
	assert!(is_match(out["chainGlyph"].as_str().unwrap(), "check$"), "a done chain quest is checked");
	let tiles = strs(&out["tiles"]);
	assert!(tiles.contains(&"Crescent Staff".into()) && tiles.contains(&"Wingblade".into()), "{tiles:?}");
	assert!(tiles.contains(&"2 x Necklace of Calisea".into()), "a reward given twice says how many");
	let chips = strs(&out["chips"]);
	assert!(chips.contains(&"2,350 XP".into()), "{chips:?}");
	assert!(chips.iter().any(|c| is_match(c, r"^\+250 ")), "reputation");
	assert!(chips.iter().any(|c| is_match(c, r"^\d+s$") || is_match(c, r"\d+g")), "money");
	assert_eq!(out["pins"][0], json!([1456, 75.6, 31.2, "Nara Wildmane"]));
	assert_eq!(out["pins"][1], json!([1413, 52.2, 31.9, "Tonga Runetotem"]));
	assert_eq!(out["tip"], true, "item hover shows the game tooltip");
}

#[test]
fn quests_too_low_shows_the_level_it_opens_at_the_other_faction_is_counted_when_none_are_left() {
	let out = run(r#"
		uistub.player.level = 12
		Polestar.Dungeons.Open("wailing-caverns")
		local fang = block(914)
		DS.SetFaction("Alliance")
		Polestar.Dungeons.Open("deadmines")
		local _, _, pg = DS.Frames()
		local dm = { DS.Shown().quests, pg.EmptyTitle:IsShown() }
		DS.SetFaction("Horde")
		emit({ low = { fang.State.Text:GetText(), fang.Glyph:GetTexture() }, dm = dm, empty = { DS.Shown().quests, pg.EmptyTitle:GetText(), pg.EmptyNote:GetText() } })"#);
	let out = &out[0];
	assert_eq!(out["low"][0], "From level 18");
	assert!(is_match(out["low"][1].as_str().unwrap(), "lock$"));
	assert_eq!(out["dm"], json!([1, false]));
	assert_eq!(out["empty"][0], 0);
	assert_eq!(out["empty"][1], "No quests for you here");
	assert!(is_match(out["empty"][2].as_str().unwrap(), "^1 quest here is for the Alliance"), "{}", out["empty"][2]);
}

#[test]
fn bosses_kill_order_level_and_the_quests_each_serves_a_quest_line_opens_the_quests_tab_at_it() {
	let out = run(r#"
		Polestar.Dungeons.Open("wailing-caverns")
		DS.SetTab("bosses")
		local names = shownTexts(DS.bossRows, "Name")
		local levels = shownTexts(DS.bossRows, "Level")
		local ties = {}
		for _, t in ipairs(DS.ties) do if t:IsShown() then ties[#ties + 1] = plain(t.Text:GetText()) end end
		local first
		for _, t in ipairs(DS.ties) do if t:IsShown() then first = t break end end
		local q = first.psQuest
		first:Click()
		emit({ names = names, levels = levels, ties = ties, tab = DS.Tab(), quest = q, blocks = DS.Shown().blocks, bosses = (function() return #DS.bossRows end)() })"#);
	let out = &out[0];
	assert_eq!(out["names"], json!(["Lady Anacondra", "Kresh", "Lord Cobrahn", "Mutanus the Devourer"]));
	assert_eq!(out["levels"], json!(["Level 20", "Level 20", "Level 20", "Level 22"]));
	let ties = strs(&out["ties"]);
	assert!(ties.len() >= 2, "{ties:?}");
	assert!(ties.iter().any(|t| t.contains("Leaders of the Fang")), "{ties:?}");
	assert!(ties.contains(&"Drops Glowing Shard, which starts The Glowing Shard".into()), "{ties:?}");
	assert_eq!(out["tab"], "quests");
	assert!(out["blocks"].as_f64().unwrap() > 0.0);
}

#[test]
fn map_the_entrance_on_its_zone_with_the_quest_givers_there() {
	let out = run(r#"
		-- The Barrens' painting: one art layer of 4x3 tiles.
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id) if id == 1413 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end return {} end
		C_Map.GetMapArtLayerTextures = function(id) if id == 1413 then local t = {} for i = 1, 12 do t[i] = 100 + i end return t end return {} end
		Polestar.Dungeons.Open("wailing-caverns")
		DS.SetTab("map")
		local _, _, pg = DS.Frames()
		emit({ shown = DS.Shown(), note = pg.MapNote:GetText(), art = pg.MapArt:IsShown(), blocks = (function() for _, b in ipairs(DS.blocks) do if b:IsShown() then return true end end return false end)() })"#);
	let out = &out[0];
	assert_eq!(out["shown"]["map"], "entrance");
	assert_eq!(out["shown"]["givers"], 2, "Nalpak (two quests) and Crane Operator Bigglefuzz; the shard starts inside");
	assert!(is_match(out["note"].as_str().unwrap(), r"^The entrance, on The Barrens \(46\.0, 36\.4\)\."), "{}", out["note"]);
	assert_eq!(out["art"], true);
	assert_eq!(out["blocks"], false, "the other tabs\u{2019} rows are hidden");
}

#[test]
fn speed_pages_reuse_pooled_frames_only_cards_in_view_are_painted_open_and_tab_switches_stay_fast() {
	let out = run(r#"
		-- Thirty more dungeons, so Home scrolls.
		local extra = {}
		for i = 1, 30 do extra["extra-" .. i] = { name = "Extra " .. i, kind = "dungeon", minLevel = 10 + i, maxLevel = 14 + i, zone = 1413, entrance = { map = 1413, x = 40, y = 40 }, quests = { A = 1, H = 1 }, bosses = 1 } end
		Polestar.Dungeons.Load()
		Polestar.Dungeons.Register("dungeon", extra, {})
		Polestar.Fire("CODEX_LOADED")
		local clock = os.clock
		local t0 = clock()
		Polestar.Dungeons.Open()
		local tHome = clock() - t0
		DS.SetBand("all")
		local cards, painted = DS.Shown().cards, DS.Shown().painted
		t0 = clock()
		DS.Open("wailing-caverns")
		local tOpen = clock() - t0
		t0 = clock()
		DS.SetTab("bosses"); DS.SetTab("map"); DS.SetTab("quests")
		local tTabs = (clock() - t0) / 3
		local frames = #stub.frames
		DS.Open("deadmines"); DS.Open("wailing-caverns"); DS.SetTab("bosses"); DS.SetTab("map"); DS.SetTab("quests")
		local grew = #stub.frames - frames
		-- A page of forty quests draws only the blocks in view, the rest as they scroll in.
		local qs = {}
		for i = 1, 40 do
			qs[i] = string.format('{id=%d,title="Errand %d",level=%d,minLevel=%d,objectives={{k="item",id=1,n=8,name="Things"}},start={kind="npc",id=1,name="Giver",map=1413,x=50,y=50},finish={kind="npc",id=1,name="Giver",map=1413,x=50,y=50},chain={},rewards={items={},xp=900,rep={}}}', 90000 + i, i, 20 + i % 5, 15)
		end
		Polestar.Dungeons.Register("dungeon", { big = { name = "Big Hold", kind = "dungeon", minLevel = 20, maxLevel = 25, quests = { A = 40, H = 40 }, bosses = 0 } },
			{ big = "return {quests={" .. table.concat(qs, ",") .. "},chain={},bosses={}}" })
		t0 = clock()
		DS.Open("big")
		local tBig = clock() - t0
		local first = DS.Shown().blocks
		local _, _, pg = DS.Frames()
		pg.Scroll:SetVerticalScroll(4000)
		DS.PaintQuests()
		emit({ cards = cards, painted = painted, grew = grew, tHome = tHome, tOpen = tOpen, tTabs = tTabs, tBig = tBig,
			big = { DS.Shown().quests, first, DS.Shown().blocks } })"#);
	let out = &out[0];
	assert_eq!(out["cards"], 33);
	let painted = out["painted"].as_f64().unwrap();
	assert!(painted > 0.0 && painted < 16.0, "only the cards in view are painted ({painted})");
	assert_eq!(out["grew"], 0, "reopening and switching tabs creates no frames");
	assert_eq!(out["big"][0], 40);
	let (first, later) = (out["big"][1].as_f64().unwrap(), out["big"][2].as_f64().unwrap());
	assert!(first > 0.0 && first < 15.0, "only the blocks in view are drawn ({first})");
	assert!(later > first, "scrolling draws more");
	for k in ["tHome", "tOpen", "tTabs", "tBig"] {
		assert!(out[k].as_f64().unwrap() < 0.25, "{k} {}s", out[k]);
	}
}

#[test]
fn without_the_codex_pack_an_empty_state_that_says_where_to_get_the_release_leaving_the_section_restores_the_header() {
	let out = run_with(
		r#"
		Polestar.Dungeons.Open("wailing-caverns")
		local _, home = DS.Frames()
		local empty = { DS.Shown().empty, home.EmptyTitle:GetText(), home.EmptyNote:GetText(), home.Watermark:IsVisible() }
		P.ShowSection("Guides")
		emit({ empty = empty, title = PolestarPicker.Title:GetAlpha(), band = PolestarPicker.Band:IsShown(), segs = segs() })"#,
		false,
	);
	let out = &out[0];
	assert_eq!(out["empty"][0], "missing");
	assert!(is_match(out["empty"][2].as_str().unwrap(), r#"not installed.*Releases page.*not "Source code""#), "points at the release download, not the source zip");
	assert_eq!(out["empty"][3], true);
	assert_eq!(out["title"], 1);
	assert_eq!(out["band"], true);
	assert!(out["segs"].as_array().unwrap().iter().all(|s| s[1] == false), "the faction filter goes with the section");
}

#[test]
fn review_p3_13_show_on_map_in_combat_says_in_chat_why_the_map_stays_shut_and_opens_it_once_combat_is_over() {
	let out = run(r#"
		local printed = {}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({ ... }, " ") end
		uistub.worldMap = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, pg = DS.Frames()
		stub.inCombat = true
		pg.MapBtn:Click()
		local inCombat = { map = uistub.worldMap or false, printed = printed[1] or false }
		stub.inCombat = false
		pg.MapBtn:Click()
		emit({ inCombat = inCombat, after = uistub.worldMap or false, lines = #printed })"#);
	let out = &out[0];
	assert_eq!(out["inCombat"]["map"], false, "nothing opens in combat");
	assert!(is_match(out["inCombat"]["printed"].as_str().unwrap(), "map can't open in combat"), "{}", out["inCombat"]["printed"]);
	assert_eq!(out["after"], 1413);
	assert_eq!(out["lines"], 1, "the out-of-combat click prints nothing");
}

/// A language folder Polestar_<locale> of a few names as `forge data names` writes it, loaded when Polestar
/// asks for it (C_AddOns.LoadAddOn) -> (its folder, Lua stub).
fn names_pack(locale: &str, names: &[(&str, &[(i64, &str)])]) -> (TempDir, String) {
	let pack = forge_addontest::names::names_pack(locale, names);
	(pack.tmp, pack.stub_lua)
}

#[test]
fn a_french_client_a_dungeon_page_and_the_codex_name_quests_npcs_and_items_in_french_english_where_french_has_none() {
	let (_fr_dir, fr) = names_pack(
		"frFR",
		&[
			("quest", &[(1486, "Peaux déviantes")]),
			("npc", &[(5767, "Nalpak (fr)"), (3671, "Dame Anacondra"), (234, "Gryan Forte-Manteau")]),
			("item", &[(6480, "Jambières déviantes lisses"), (9739, "Gemme d'Anacondra")]),
		],
	);
	let pack = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: format!(
			r#"function GetLocale() return "frFR" end
do
	local load = loadfile
	function loadfile(file)
		if file:match("[/\\]Locales[/\\]%a%a%u%u%.lua$") then return function() end end
		return load(file)
	end
end
{fr}
{}"#,
			pack.stub_lua
		),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"uistub.install()
stub.login()
local D = Polestar.Dungeons
local q = D.Quest("wailing-caverns", 1486)
local b = D.Bosses("wailing-caverns")
emit({ q.title, q.start.name, q.rewards.items[1].name, q.rewards.items[2].name, b[1].name, b[1].quests[1].itemName, b[2].name })
local C = Polestar.Codex
emit({ C.Npc(234).name, C.Name("npc", 234), C.Name("npc", 639) })
local guids = { target = "Creature-0-1-0-1-5767-0000AB", mouseover = "Creature-0-1-0-1-639-0000CD" }
local named = { target = "Nalpak (client)", mouseover = "Edwin VanCleef (client)" }
UnitGUID = function(u) return guids[u] end
UnitName = function(u) return named[u] end
UnitPlayerControlled = function() return false end
Polestar.Compat.Readable = function(v) return v end
stub.fire("PLAYER_TARGET_CHANGED"); stub.fire("UPDATE_MOUSEOVER_UNIT")
emit({ D.Quest("wailing-caverns", 1486).start.name, C.Npc(639).name })"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], json!(["Peaux déviantes", "Nalpak (fr)", "Jambières déviantes lisses", "Deviate Hide Pack", "Dame Anacondra", "Gemme d'Anacondra", "Kresh"]));
	assert_eq!(out[1], json!(["Gryan Forte-Manteau", "Gryan Forte-Manteau", "Edwin VanCleef"]));
	assert_eq!(out[2], json!(["Nalpak (client)", "Edwin VanCleef (client)"]), "an open page and decoded records pick up names learned in play");
}
