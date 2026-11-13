//! The Dungeons section of the hub (addon/Polestar/UI/Dungeons.lua) over the real Dungeons runtime and the
//! synthetic Codex pack of tests/fixtures/codex/dungeons.json (Wailing Caverns with its quests and bosses, the
//! Deadmines, a Forever dungeon with nothing known), against the fake Engine of tests/lua/stub_ui.lua. The
//! character: a level 20 Tauren.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
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
		finder: m["finder"].as_object().map(|f| forge_data::codex::client::Finder { min: f["min"].as_f64().unwrap_or(0.0), max: f["max"].as_f64().unwrap_or(0.0), players: f["players"].as_f64().unwrap_or(5.0), players_max: f.get("playersMax").and_then(Value::as_f64).or(f["players"].as_f64()).unwrap_or(5.0) }),
	}
}

/// The fixture's Codex as a pack, with its Dungeons journal (`buildJournal(fixture.inputs, fixture.codex)`).
fn pack() -> CodexPack {
	let f = fixture("dungeons.json");
	pack_of(&f["codex"], &f["inputs"])
}

/// A Codex and its journal inputs as a pack, with its Dungeons journal.
fn pack_of(codex: &Value, inputs: &Value) -> CodexPack {
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
		&JournalInputs {
			maps: &maps,
			frames: &frames,
			fv_quests: &quests,
			fv_objects: &objects,
			fv_zones: &zones,
			fv_dungeons: &dungeons,
			journal_quests: &[],
			attunement_table: &attunements,
			store_xp: &Default::default(),
			recorded_dungeons: &v(&inputs["recordedDungeons"]),
			levels_table: &v(&inputs["levelsTable"]),
		},
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
	run_pack(script, with_pack.then(pack))
}

fn run_pack(script: &str, pack: Option<CodexPack>) -> Vec<Value> {
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
	assert_eq!(out["stats"], "17\u{2013}24  \u{b7}  best at 19  \u{b7}  The Barrens  \u{b7}  4 quests");
	assert_eq!(out["chip"], false, "no \"Your level\" chip where every card is");
}

// Fitz, 2026-11-08 (a level 13 Horde Warlock saw the Ruins of Lordaeron, 15-22, and The Hall of Thanes, in
// Ironforge, under "For your level"): a dungeon is for your level from its recommended start, and
// one whose way in lies inside the other faction's capital is not under that faction's filter. The Ruins,
// outside the Undercity, can be reached by both.
#[test]
fn for_your_level_starts_at_the_recommended_level_and_leaves_out_dungeons_inside_the_other_factions_capital() {
	let f = fixture("dungeons.json");
	let mut codex = f["codex"].clone();
	let forever = |key: &str, name: &str, levels: [i64; 3]| json!({ "key": key, "name": name, "kind": "dungeon", "forever": true, "areaId": null, "map": null, "entrance": null, "levels": levels, "bosses": [] });
	codex["instances"]["ruins-of-lordaeron"] = forever("ruins-of-lordaeron", "Ruins of Lordaeron", [10, 15, 22]);
	codex["instances"]["the-hall-of-thanes"] = forever("the-hall-of-thanes", "The Hall of Thanes", [10, 13, 16]);
	codex["instances"]["ragefire-chasm"] = forever("ragefire-chasm", "Ragefire Chasm", [10, 13, 16]);
	let out = run_pack(
		r#"
		local function at(level, f)
			uistub.player.level = level
			Polestar.Dungeons.Open()
			DS.SetFaction(f)
			DS.SetBand("level")
			local keep = { ["Ruins of Lordaeron"] = true, ["The Hall of Thanes"] = true, ["Ragefire Chasm"] = true }
			local out = {}
			for _, n in ipairs(cardNames()) do if keep[n] then out[#out + 1] = n end end
			table.sort(out)
			return out
		end
		emit({ h12 = at(12, "Horde"), h13 = at(13, "Horde"), h14 = at(14, "Horde"), h15 = at(15, "Horde"), h22 = at(22, "Horde"),
			a13 = at(13, "Alliance"), a15 = at(15, "Alliance"), all13 = at(13, "All") })"#,
		Some(pack_of(&codex, &f["inputs"])),
	);
	let out = &out[0];
	assert_eq!(out["h12"], json!({}), "not below the recommended start");
	assert_eq!(out["h13"], json!(["Ragefire Chasm"]), "not the Ruins (15-22) at 13; not The Hall of Thanes (Ironforge) for the Horde");
	assert_eq!(out["h14"], json!(["Ragefire Chasm"]), "the Ruins from 15, not 14");
	assert_eq!(out["h15"], json!(["Ragefire Chasm", "Ruins of Lordaeron"]));
	assert_eq!(out["h22"], json!(["Ruins of Lordaeron"]));
	assert_eq!(out["a13"], json!(["The Hall of Thanes"]), "not Ragefire Chasm (Orgrimmar) for the Alliance");
	assert_eq!(out["a15"], json!(["Ruins of Lordaeron", "The Hall of Thanes"]), "the Ruins lie outside the Undercity: the Alliance can get there");
	assert_eq!(out["all13"], json!(["Ragefire Chasm", "The Hall of Thanes"]), "All shows both sides'");
}

// A player asked why Uldaman (35-47) showed under "For your level" at 35, where most of it suits ~42. It still
// shows inside its range, but the cards go by closeness to where each suits best (Dungeons.BestAt), the ones the
// player is 4+ levels under come after the ones that fit and say "Tough at your level" (a calm chip, not the
// warning colour), and each card and page says "best at N" after the range.
#[test]
fn for_your_level_sorts_by_closeness_to_best_at_and_marks_dungeons_4_levels_under_it_tough_uldaman_at_35_vs_42() {
	let out = run(r#"
		Polestar.Dungeons.Load()
		local function bosses(list)
			local t = {}
			for i, l in ipairs(list) do t[i] = string.format("{order=%d,name=%q,level=%d}", i, "Boss " .. i, l) end
			return "return {bosses={" .. table.concat(t, ",") .. "}}"
		end
		Polestar.Dungeons.Register("dungeon", {
			uldaman = { name = "Uldaman", kind = "dungeon", minLevel = 35, maxLevel = 47, players = 10, zoneName = "Badlands" },
			["scarlet-monastery"] = { name = "Scarlet Monastery", kind = "dungeon", minLevel = 30, maxLevel = 42, players = 10, zoneName = "Tirisfal Glades" },
			["razorfen-downs"] = { name = "Razorfen Downs", kind = "dungeon", minLevel = 35, maxLevel = 41, players = 10, zoneName = "The Barrens" },
		}, {
			uldaman = bosses({ 40, 42, 44, 44, 45, 46, 47 }),
			["scarlet-monastery"] = bosses({ 32, 35, 37, 40, 42 }),
			["razorfen-downs"] = bosses({ 39, 40, 40, 41 }),
		})
		local function at(level)
			uistub.player.level = level
			Polestar.Dungeons.Open()
			DS.SetFaction("All")
			DS.SetBand("level")
			local out = {}
			for _, c in ipairs(DS.cards) do
				if c:IsShown() then
					out[#out + 1] = { c.Name:GetText(), c.Yours:IsShown() and c.Yours.Text:GetText() or false, c.Stats:GetText() }
				end
			end
			return out
		end
		local at35, at42 = at(35), at(42)
		DS.SetBand("all")
		local chips = {}
		for _, c in ipairs(DS.cards) do
			if c:IsShown() and c.Yours:IsShown() then chips[c.Name:GetText()] = c.Yours.Text:GetText() end
		end
		uistub.player.level = 35
		DS.SetBand("all")
		local tough = {}
		for _, c in ipairs(DS.cards) do
			if c:IsShown() and c.Name:GetText() == "Uldaman" then tough = { c.Yours:IsShown(), c.Yours.Text:GetText() } end
		end
		Polestar.Dungeons.Open("uldaman")
		local _, _, pg = DS.Frames()
		emit({ at35 = at35, at42 = at42, chips = chips, tough = tough, sub = pg.Sub:GetText() })"#);
	let out = &out[0];
	let names = |v: &Value| v.as_array().unwrap().iter().map(|c| c[0].as_str().unwrap().to_string()).collect::<Vec<_>>();
	assert_eq!(names(&out["at35"]), ["Scarlet Monastery", "Razorfen Downs", "Uldaman"], "at 35 the Monastery (best at 36) fits; Razorfen Downs (39) and Uldaman (43) are tough, nearest first");
	assert_eq!(out["at35"][0][1], false, "no chip on a card that fits under For your level");
	assert_eq!(out["at35"][1][1], "Tough at your level");
	assert_eq!(out["at35"][2][1], "Tough at your level");
	assert_eq!(out["at35"][2][2], "35\u{2013}47  \u{b7}  best at 43  \u{b7}  Badlands\nNo quests known", "the chip leaves less room: the facts break between two");
	assert_eq!(names(&out["at42"]), ["Uldaman", "Scarlet Monastery"], "at 42 Uldaman (best at 43) comes first; Razorfen Downs (35-41) is behind you");
	assert_eq!(out["at42"][0][1], false, "not tough at 42");
	assert_eq!(out["at42"][1][1], false, "6 over best at is no reason to warn");
	assert_eq!(out["chips"]["Uldaman"], "Your level", "under All at 42: the usual chip");
	assert_eq!(out["tough"], json!([true, "Tough at your level"]), "under All at 35 the chip says it is tough");
	assert!(out["sub"].as_str().unwrap().starts_with("Levels 35\u{2013}47  \u{b7}  best at 43  \u{b7}  Badlands"), "{}", out["sub"]);
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
	assert_eq!(
		out["head"],
		json!(["Wailing Caverns", "Levels 17\u{2013}24  \u{b7}  best at 19  \u{b7}  The Barrens\n10 players  \u{b7}  4 bosses", true, true, true, false, "Wailing Caverns", 0, false, true])
	);
	assert_eq!(out["tabs"], json!(["Quests  4", "Attunement", "Bosses  4", "Map"]), "the fixture gives Wailing Caverns an attunement");
	assert_eq!(out["nav"], json!([1413, 46, 36.4, "Wailing Caverns"]));
	assert_eq!(out["map"], 1413);
	assert_eq!(out["back"], json!([false, 1, true, false]));
}

// #1753's pattern: a string hidden by SetAlpha(0) came back on a theme repaint (a UI scale or display size change),
// which sets its colour again, and in the client a string's colour alpha is its alpha. The hub's title and subtitle,
// veiled over a page's zone art, stay veiled through one; back home they show at their colour's alpha.
#[test]
fn a_page_s_veiled_hub_title_stays_veiled_through_a_theme_repaint() {
	let out = run(r#"
		Polestar.Dungeons.Open("wailing-caverns")
		Polestar.Theme.Refresh()
		local t, s = PolestarPicker.Title, PolestarPicker.Subtitle
		local open = { t:GetAlpha(), t.textColor[4], s.textColor[4] }
		DS.Home()
		Polestar.Theme.Refresh()
		emit({ open = open, back = { t:GetAlpha(), t.textColor[4] > 0 } })"#);
	assert_eq!(out[0]["open"], json!([0, 0, 0]), "veiled by alpha and by colour, through the repaint");
	assert_eq!(out[0]["back"], json!([1, true]));
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

// Fitz, 2026-11-08 (Ragefire Chasm at 13 offered "a guide to the 5 quests here you can take" when two needed
// 16): the button says how many can be taken now and how many wait for which level; its tip lists the
// waiting ones and why; with none open now it says from which level. Here Trouble at the Docks needs 19.
#[test]
fn pick_up_the_quests_says_how_many_now_and_how_many_wait_for_a_level_the_tip_lists_the_waiting_ones() {
	let f = fixture("dungeons.json");
	let mut codex = f["codex"].clone();
	codex["quests"]["959"]["minLevel"] = json!(19);
	let out = run_pack(
		r#"
		local _, _, pg = DS.Frames()
		local function page(level)
			uistub.player.level = level
			Polestar.Dungeons.Open("wailing-caverns")
			local _, _, p = DS.Frames()
			local b = p.Pickup:IsShown() and p.Pickup or p.PickupNone
			return { label = b.Label:GetText(), tip = b.psTipLines, width = b:GetWidth() > b.Label:GetStringWidth() }
		end
		local at17 = page(17)
		local at19 = page(19)
		done[1486] = true
		local none = page(17)
		emit({ at17 = at17, at19 = at19, none = none })"#,
		Some(pack_of(&codex, &f["inputs"])),
	);
	let out = &out[0];
	assert_eq!(out["at17"]["label"], "Pick up the quests (1 now \u{b7} 1 at level 19)");
	assert_eq!(out["at17"]["width"], true, "the button grows with its label");
	assert_eq!(
		out["at17"]["tip"],
		json!([
			"A guide to the 1 quest here you can take, with what comes before it, ending at the entrance.",
			"1 more is in your log already.",
			"Waiting:",
			"\u{201c}Trouble at the Docks\u{201d}: level 19",
			"It opens in a new tab."
		])
	);
	assert_eq!(out["at19"]["label"], "Pick up the quests", "all open: the plain label");
	assert_eq!(out["none"]["label"], "Pick up the quests from level 19");
	assert!(is_match(out["none"]["tip"][0].as_str().unwrap(), "^Nothing to pick up before the run.+1 more opens at a later level"), "{}", out["none"]["tip"]);
	assert_eq!(out["none"]["tip"][2], "\u{201c}Trouble at the Docks\u{201d}: level 19");
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
	assert_eq!(open["tip"], json!(["Not finished yet: “Leaders of the Fang”."]));
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
	assert_eq!(out["fang"], json!(["Set the arrow to Tonga Runetotem", "First pick up “Nara Wildmane”, which comes before this quest.", "Set the arrow to Tonga Runetotem"]));
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

// #1380: Blackfathom Deeps' Allegiance to the Old Gods starts from the Damp Note, which no boss drops: the
// Blackfathom Tide Priestesses do, in the tunnels before the portal, outside the instance. Its card named the
// item alone. A quest an item starts now names what drops it when no boss does (the mobs outside the dungeon
// first), says "Picked up inside the dungeon" only when every mob that drops it is inside, and its pin leads
// to the nearest one outside.
#[test]
fn a_quest_an_item_starts_names_the_mobs_that_drop_it_inside_or_outside_the_dungeon_its_pin_leads_to_one_outside_1380() {
	let f = fixture("dungeons.json");
	let (mut codex, mut inputs) = (f["codex"].clone(), f["inputs"].clone());
	let mob = |id: i64, name: &str, instance: Value, spawns: Value| json!({ "id": id, "name": name, "level": 20, "levelMax": 21, "faction": null, "rare": false, "elite": true, "boss": false, "instance": instance, "roles": [], "spawns": spawns });
	codex["npcs"]["90040"] = mob(90040, "Tide Priestess", Value::Null, json!([{ "map": 1413, "x": 45, "y": 37, "f": "e" }]));
	codex["npcs"]["90041"] = mob(90041, "Deviate Lurker", json!("wailing-caverns"), json!([]));
	let item = |id: i64, name: &str, source: Value| json!({ "id": id, "name": name, "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [source] });
	codex["items"]["90042"] = item(90042, "Damp Note", json!({ "type": "drop", "npc": 90040, "chance": 33 }));
	codex["items"]["90043"] = item(90043, "Lurker Scale", json!({ "type": "drop", "npc": 90041, "chance": 20, "instance": "wailing-caverns" }));
	let quest = |id: i64, title: &str, start_item: i64| {
		json!({
			"id": id, "title": title, "level": 15, "minLevel": 10, "faction": null, "races": null, "classes": null,
			"start": { "npc": [], "object": [], "item": [start_item] }, "end": { "npc": [5767], "object": [] },
			"objectives": [], "pre": [], "zone": 1413, "rewards": [], "choices": [], "preAny": [],
		})
	};
	codex["quests"]["90044"] = quest(90044, "A Damp Note", 90042);
	codex["quests"]["90045"] = quest(90045, "A Lurker Scale", 90043);
	inputs["forever"]["quests"]["90044"] = json!({ "area": 718 });
	inputs["forever"]["quests"]["90045"] = json!({ "area": 718 });
	let out = run_pack(
		r#"
		Polestar.Dungeons.Open("wailing-caverns")
		local pins = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label } return true end
		local note, scale = block(90044), block(90045)
		note.StartPin:Click()
		emit({ note = { note.Meta:GetText(), plain(note.Start:GetText()), note.StartPin:IsEnabled() },
			scale = { scale.Meta:GetText(), plain(scale.Start:GetText()), scale.StartPin:IsEnabled() }, pins = pins })"#,
		Some(pack_of(&codex, &inputs)),
	);
	let out = &out[0];
	assert_eq!(out["note"][1], "Damp Note  \u{b7}  drops from Tide Priestess", "the mob that drops it, though no boss does");
	assert!(!is_match(out["note"][0].as_str().unwrap(), "Picked up inside the dungeon"), "it drops outside: {}", out["note"][0]);
	assert_eq!(out["note"][2], true, "its pin leads to the mob outside");
	assert_eq!(out["pins"][0], json!([1413, 45, 37, "Tide Priestess"]));
	assert_eq!(out["scale"][1], "Lurker Scale  \u{b7}  drops from Deviate Lurker");
	assert!(is_match(out["scale"][0].as_str().unwrap(), "Picked up inside the dungeon"), "it drops only inside: {}", out["scale"][0]);
	assert_eq!(out["scale"][2], false, "nowhere to point the arrow outside");
}

// #837: Axe of Orgrimmar is blue on its tooltip in the game and green on the page, whose quality comes
// from the client's tables. The fixture's Crescent Staff is quality 3 on the page; the game says green.
#[test]
fn a_reward_tile_takes_its_colour_from_the_games_tooltip_and_is_painted_again_when_the_item_arrives() {
	let out = run(r#"
		local loaded, asked = false, {}
		ITEM_QUALITY_COLORS = { [3] = { r = 0, g = 0.44, b = 0.87 } }
		Polestar.Compat.ItemTipColor = function() if loaded then return 0.12, 1, 0 end end
		Polestar.Compat.RequestItem = function(id) asked[#asked + 1] = id return loaded end
		local function border(t)
			local r, g, b = t.Well.psBorder[1]:GetVertexColor()
			return string.format("%.2f %.2f %.2f", r, g, b)
		end
		Polestar.Dungeons.Open("wailing-caverns")
		local tile
		for _, b in ipairs(DS.blocks) do
			for _, t in ipairs(b.Tiles or {}) do if t.psID == 6505 and t:IsShown() then tile = t end end
		end
		local loading = border(tile)
		local requested = false
		for _, id in ipairs(asked) do if id == 6505 then requested = true end end
		loaded = true
		stub.fire("GET_ITEM_INFO_RECEIVED", 6505, true)
		local arrived = border(tile)
		emit({ loading = loading, requested = requested, arrived = arrived, name = tile.Name:GetText() })"#);
	let out = &out[0];
	assert_eq!(out["loading"], "0.00 0.44 0.87", "not loaded yet: the page's quality, never the red placeholder");
	assert_eq!(out["requested"], true, "the item is asked for");
	assert_eq!(out["arrived"], "0.12 1.00 0.00", "once it arrives: the game's own colour");
	assert_eq!(out["name"], "Crescent Staff");
}

#[test]
fn quest_cards_group_the_details_and_mark_the_next_unfinished_chain_step_names_keep_their_difficulty_colour() {
	let out = run(r#"
		done[1490] = nil
		Polestar.Dungeons.Open("wailing-caverns")
		local fang = block(914)
		local step = fang.Chains[1]
		local function rgb(r, g, b) return string.format("%.3f %.3f %.3f", r, g, b) end
		local text, accent = rgb(Polestar.Theme.Color("text")), rgb(Polestar.Theme.Color("accent"))
		emit({ panel = fang.psSkin ~= nil, rule = fang.HeadRule:IsShown(), rewards = fang.MoreLabel:IsShown(), objective = fang.Obj:GetText(),
			step = { step.Number:GetText(), step.Number:IsShown(), step.Highlight:IsShown(), step.Glyph:IsShown() },
			plain = { rgb(fang.Title:GetTextColor()) == text, rgb(step.Title:GetTextColor()) == text, rgb(step.Title:GetTextColor()) == accent } })"#);
	let out = &out[0];
	assert_eq!(out["panel"], true);
	assert_eq!(out["rule"], true);
	assert_eq!(out["rewards"], true);
	assert!(is_match(out["objective"].as_str().unwrap(), "^\u{2022}  "));
	assert_eq!(out["step"], json!(["1", true, true, false]));
	assert_eq!(out["plain"], json!([false, false, false]), "quest and chain names keep their difficulty colour");
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
	assert!(ties.contains(&"Drops Glowing Shard, which starts “The Glowing Shard”".into()), "{ties:?}");
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
fn leaving_dungeons_removes_its_faction_buttons_and_restores_the_guide_filters() {
	let out = run(r#"
		stub.cascadeVisibility = true
		Polestar.Dungeons.Open("wailing-caverns")
		local _, _, _, buttons = DS.Frames()
		local function visible()
			local n = 0
			for _, b in ipairs(buttons) do if b:IsVisible() then n = n + 1 end end
			return n
		end
		local r = { opened = visible() }
		PolestarPicker:Hide()
		r.closed = visible()
		Polestar.UI.ShowPicker()
		r.reopened = visible()
		P.ShowSection("Guides")
		P.SetCategory("All")
		r.left = visible()
		r.title = PolestarPicker.Title:GetAlpha()
		r.filters = {}
		for _, b in ipairs(PolestarPicker.factionButtons) do
			b:Click()
			local selected = Polestar.Get("ui.pickerFaction")
			local count, valid = 0, true
			for _, entry in ipairs((P.Entries(selected, "", "All"))) do
				if entry.kind == "guide" then
					count = count + 1
					local f = entry.guide.faction
					if selected ~= "All" and f and f ~= selected then valid = false end
				end
			end
			r.filters[#r.filters + 1] = { b.psKey, selected, b:IsVisible(), count > 0, valid }
		end
		P.ShowSection("Dungeons")
		r.returned = visible()
		P.ShowSection("Guides")
		r.leftAgain = visible()
		emit(r)"#);
	let out = &out[0];
	assert_eq!(out["opened"], 3);
	assert_eq!(out["closed"], 0);
	assert_eq!(out["reopened"], 3);
	assert_eq!(out["left"], 0, "dungeon controls must not cover the guide controls");
	assert_eq!(out["title"], 1, "the dungeon page must not leave the guide heading veiled");
	assert_eq!(out["returned"], 3);
	assert_eq!(out["leftAgain"], 0);
	for filter in out["filters"].as_array().unwrap() {
		assert_eq!(filter[0], filter[1]);
		assert_eq!(filter[2], true);
		assert_eq!(filter[3], true);
		assert_eq!(filter[4], true);
	}
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

// ---------------------------------------------------------------------------
// The dungeon heads-up (UI/DungeonToast.lua, #836) on the class quest heads-up's card
// ---------------------------------------------------------------------------

// The level 20 Tauren: Wailing Caverns (17-24) has its two Horde quests to take now and none for later
// levels; the Deadmines has none for the Horde; Blackmaw Hold is 55-60.
const HEADS_UP: &str = r#"
local DT, CT = Polestar.UI.DungeonToast, Polestar.UI.ClassToast
-- The Druid's own class quest heads-up (Cat Form at 20) stays out of these; the card waiting for
-- one is tested with a card shown by hand.
CT.Check = function() return false end
local asked, pickUp = {}, Polestar.Dungeons.PickUp
Polestar.Dungeons.PickUp = function(key) asked[#asked + 1] = key return "lookup/pickup/" .. key end
local function card()
	local f = CT.frame
	local on = f ~= nil and f:IsShown()
	if not on then return { shown = false } end
	return { shown = true, dungeon = CT.current and CT.current.dungeon, head = f.Head:GetText(), title = f.Title:GetText(), line = f.Giver:GetText(),
		badge = f.Badge:IsShown() and f.Badge.Text:GetText() or false, act = f.Act:IsShown() and f.Act.Label:GetText() or false,
		more = f.More:IsShown() and f.More.Label:GetText() or false, off = f.Off:IsShown() and f.Off.Label:GetText() or false, later = f.Later:IsShown(),
		open = f.Open:IsShown(), showMe = f.ShowMe:IsShown() }
end
local function levelUp(level)
	stub.fire("PLAYER_LEVEL_UP", level)
	stub.advance(2)
end
"#;

#[test]
fn a_level_up_tells_once_that_wailing_caverns_is_open_and_its_button_picks_up_the_quests_in_a_new_tab() {
	let out = run(&format!(
		r#"{HEADS_UP}
		stub.sounds = {{}}
		stub.fire("PLAYER_LEVEL_UP", 20)
		emit({{ before = card().shown }})
		stub.advance(2)
		emit(card())
		emit({{ sounds = #stub.sounds, seen = Polestar.CharState().dungeonToastSeen }})
		CT.frame.Later:Click()
		levelUp(20)
		emit({{ again = card().shown }})
		-- Shown again by the command, the button opens the pick-up guide and the card goes.
		Polestar.RunCommand("dungeontoast wailing caverns")
		local shown = card().shown
		CT.frame.Act:Click()
		emit({{ shown = shown, asked = asked, after = card().shown, ui = Polestar.Get("ui.shown") }})"#
	));
	assert_eq!(out[0], json!({ "before": false }), "it waits for the class quest heads-up's turn (DELAY)");
	assert_eq!(
		out[1],
		json!({
			"shown": true,
			"dungeon": "wailing-caverns",
			"head": "LEVEL 20 · DUNGEON",
			"title": "Wailing Caverns is open to you",
			"line": "2 quests to pick up  ·  Levels 17–24  ·  The Barrens",
			"badge": "+25% OF A LEVEL",
			"act": "Pick up the quests",
			"more": "Open in Dungeons",
			"off": "Turn these off",
			"later": true,
			"open": false,
			"showMe": false,
		}),
		"the Deadmines has no Horde quests and Blackmaw Hold is out of range"
	);
	assert_eq!(out[2], json!({ "sounds": 1, "seen": { "wailing-caverns": true } }));
	assert_eq!(out[3], json!({ "again": false }), "once per dungeon per character");
	assert_eq!(out[4], json!({ "shown": true, "asked": ["wailing-caverns"], "after": false, "ui": true }));
}

// The ring wears the dungeon's own picture (Dungeons/Art.lua: Wailing Caverns' loading screen, file 131882, by its
// Map id 43), filling it inside the accent's rim, lifted (the picture added over itself at its lift, 0.35) as it is a
// dark one; a dungeon the table doesn't know gets the dungeon glyph, small and whole on the disc, with no lift.
// Never the flat tinted circle the glyph made when it filled the ring.
#[test]
fn the_dungeon_heads_up_wears_the_dungeons_own_picture_and_the_dungeon_glyph_without_one() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local function ring()
			local f = CT.frame
			local i, l = f.Icon, f.Lift
			return {{ texture = i:GetTexture(), coords = i.texCoord, size = i:GetWidth(), mask = f.Mask:GetWidth(), tint = {{ i:GetVertexColor() }},
				solid = i.color ~= nil, ring = f.Ring:GetWidth(),
				lift = l:IsShown() and {{ texture = l:GetTexture(), coords = l.texCoord, size = l:GetWidth(), alpha = l:GetAlpha(), blend = l.blend,
					masked = l.mask == f.Mask }} or false }}
		end
		levelUp(20)
		local art = Polestar.Dungeons.Art("wailing-caverns")
		emit({{ dungeon = CT.current.dungeon, ring = ring(), art = {{ art.l, art.r, art.t, art.b }}, lift = art.lift, none = Polestar.Dungeons.Art("blackmaw-hold") or false }})
		CT.Hide()
		DT.Show({{ key = "blackmaw-hold", name = "Blackmaw Hold", minLevel = 55, maxLevel = 60, take = 1, level = 55 }})
		local r, g, b = Polestar.Theme.Color("dungeon")
		emit({{ dungeon = CT.current.dungeon, ring = ring(), violet = {{ r, g, b, 1 }}, glyph = Polestar.Theme.Media("icon-dungeon") }})"#
	));
	let (art, glyph) = (&out[0], &out[1]);
	assert_eq!(art["dungeon"], "wailing-caverns");
	assert_eq!(art["none"], false, "Blackmaw Hold has no Map id in the fixture, so no picture");
	assert_eq!(art["ring"]["texture"], 131882, "Wailing Caverns' loading screen");
	assert_eq!(art["ring"]["coords"], art["art"], "cropped square");
	assert_eq!(json!([&art["ring"]["size"], &art["ring"]["mask"], &art["ring"]["ring"]]), json!([36, 36, 40]), "the picture fills the ring inside a 2px rim");
	assert_eq!(art["ring"]["tint"], json!([1, 1, 1, 1]), "in its own colours");
	assert_eq!(art["ring"]["solid"], false);
	assert_eq!(art["lift"], 0.35);
	assert_eq!(
		art["ring"]["lift"],
		json!({ "texture": 131882, "coords": art["art"], "size": 36, "alpha": 0.35, "blend": "ADD", "masked": true }),
		"the same picture added over it, in the same round crop"
	);
	assert_eq!(glyph["dungeon"], "blackmaw-hold");
	assert_eq!(glyph["ring"]["texture"], glyph["glyph"]);
	assert_eq!(glyph["ring"]["coords"], json!([0, 1, 0, 1]), "no crop left over from the picture");
	assert_eq!(json!([&glyph["ring"]["size"], &glyph["ring"]["mask"]]), json!([20, 32]), "small on the disc, its corners inside the round crop");
	assert_eq!(glyph["ring"]["tint"], glyph["violet"]);
	assert_eq!(glyph["ring"]["solid"], false);
	assert_eq!(glyph["ring"]["lift"], false, "no lift left over from the picture");
}

#[test]
fn turn_these_off_stops_the_heads_ups_and_it_waits_for_combat_and_for_a_class_quest_card() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local combat = true
		Polestar.Compat.InCombat = function() return combat end
		levelUp(20)
		emit({{ inCombat = card().shown }})
		combat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		emit({{ afterCombat = card().dungeon or false }})
		-- A class quest card first: the dungeon one waits until it is dismissed.
		Polestar.CharState().dungeonToastSeen = nil
		CT.ShowCard({{ head = "LEVEL 20 · DRUID", title = "Cat Form ready", class = "DRUID", guideId = "x" }})
		levelUp(20)
		local class = card()
		CT.Hide()
		stub.advance(1)
		emit({{ waited = class.title, open = class.open, act = class.act, thenShown = card().dungeon or false }})
		CT.frame.Off:Click()
		Polestar.CharState().dungeonToastSeen = nil
		levelUp(20)
		emit({{ setting = Polestar.Get("dungeons.headsUp"), shown = card().shown, candidates = #DT.Candidates(20, "levelup") }})"#
	));
	assert_eq!(out[0], json!({ "inCombat": false }));
	assert_eq!(out[1], json!({ "afterCombat": "wailing-caverns" }), "shown once combat ends");
	assert_eq!(out[2], json!({ "waited": "Cat Form ready", "open": true, "act": false, "thenShown": "wailing-caverns" }));
	assert_eq!(out[3], json!({ "setting": false, "shown": false, "candidates": 0 }));
}

// Wailing Caverns (17-24) is best at 19 in the fixture: it comes due there, and a login heads-up tells it up to two
// levels after that.
#[test]
fn at_login_only_a_dungeon_that_came_due_at_its_best_at_level_in_the_last_two_levels_is_told() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local function keys(list) local t = {{}} for _, c in ipairs(list) do t[#t + 1] = c.key end return t end
		emit({{ login18 = keys(DT.Candidates(18, "login")), login19 = keys(DT.Candidates(19, "login")), login21 = keys(DT.Candidates(21, "login")),
			login22 = keys(DT.Candidates(22, "login")), levelup20 = keys(DT.Candidates(20, "levelup")), below = keys(DT.Candidates(16, "levelup")),
			above = keys(DT.Candidates(25, "levelup")) }})"#
	));
	assert_eq!(
		out[0],
		json!({ "login18": {}, "login19": ["wailing-caverns"], "login21": ["wailing-caverns"], "login22": {}, "levelup20": ["wailing-caverns"], "below": {}, "above": {} }),
		"best at 19: three levels past it at 22 is too old for a login heads-up, two at 21 is not; 18 is below it"
	);
}

// A level 44 character was told the City of Dalaran (28-60) was open to them, for one quest worth 1% of a level.
// The card now waits for the level the dungeon suits best (Dungeons.BestAt: 19 for the fixture's Wailing Caverns,
// 17-24), not the start of its range, though both its quests are offered from 17.
#[test]
fn the_dungeon_card_waits_for_the_dungeons_best_at_level_not_the_start_of_its_range() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local seen = {{}}
		for _, n in ipairs({{ 17, 18, 19 }}) do
			uistub.player.level = n
			levelUp(n)
			local c = card()
			seen[#seen + 1] = c.shown and c.head or false
		end
		emit({{ best = Polestar.Dungeons.BestAt("wailing-caverns"), seen = seen }})"#
	));
	assert_eq!(out[0], json!({ "best": 19, "seen": [false, false, "LEVEL 19 · DUNGEON"] }));
}

// No card when the quests to take now are worth under a tenth of a level (MIN_WORTH): with Trouble at the Docks
// carried, Deviate Hides (1486) is the one to take; the level 20 character's XP to level is set so it is worth
// 9.9%, then 10%.
#[test]
fn no_dungeon_card_for_quests_worth_under_a_tenth_of_a_level_and_one_from_a_tenth() {
	let out = run(&format!(
		r#"{HEADS_UP}
		log[959] = true
		Polestar.Dungeons.Load()
		local q = Polestar.Dungeons.Quest("wailing-caverns", 1486)
		local entry = {{ {{ id = 1486, level = q.level, xp = q.rewards.xp }} }}
		local xp = Polestar.Levels.Run(entry).questXP
		uistub.player.xp = 0
		local out = {{}}
		for i, need in ipairs({{ math.ceil(xp / 0.099), xp * 10 }}) do
			uistub.player.xpMax = need
			local c = DT.Candidates(20, "levelup")[1]
			out[i] = {{ worth = math.floor(Polestar.Levels.Run(entry).levels * 1000 + 0.5) / 10, card = c and c.key or false, take = c and c.take or false }}
		end
		emit(out)"#
	));
	assert_eq!(out[0], json!([{ "worth": 9.9, "card": false, "take": false }, { "worth": 10, "card": "wailing-caverns", "take": 1 }]));
}

// A card put off with Later below the dungeon's best-at level (here shown by the command at 18) comes back once at
// best-at (19); put off again there, it never comes back.
#[test]
fn a_dungeon_card_put_off_with_later_below_best_at_comes_back_once_at_best_at_then_never() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local function told() return (Polestar.CharState().dungeonToastSeen or {{}})["wailing-caverns"] or false end
		uistub.player.level = 18
		Polestar.RunCommand("dungeontoast wailing caverns")
		local early = card().head or false
		CT.frame.Later:Click()
		emit({{ early = early, told = told() }})
		levelUp(18)
		emit({{ again18 = card().shown }})
		uistub.player.level = 19
		levelUp(19)
		local back = card().head or false
		CT.frame.Later:Click()
		emit({{ back = back, told = told() }})
		for _, n in ipairs({{ 20, 21 }}) do
			uistub.player.level = n
			levelUp(n)
		end
		emit({{ after = card().shown }})"#
	));
	assert_eq!(out[0], json!({ "early": "LEVEL 18 · DUNGEON", "told": "later" }));
	assert_eq!(out[1], json!({ "again18": false }), "not before best-at");
	assert_eq!(out[2], json!({ "back": "LEVEL 19 · DUNGEON", "told": true }));
	assert_eq!(out[3], json!({ "after": false }), "once only");
}

// A character told about a dungeon at the start of its range by an older version (dungeonToastSeen[key] = true,
// no dungeonToastBestAt) and still below its best-at level hears about it once more at best-at, as after Later;
// one already at or past best-at keeps it told.
#[test]
fn a_dungeon_told_by_an_older_version_below_best_at_comes_back_once_at_best_at_and_one_past_it_stays_told() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local function told() return (Polestar.CharState().dungeonToastSeen or {{}})["wailing-caverns"] or false end
		local st = Polestar.CharState()
		st.dungeonToastSeen, st.dungeonToastBestAt = {{ ["wailing-caverns"] = true }}, nil
		uistub.player.level = 18
		levelUp(18)
		emit({{ shown = card().shown, told = told(), marked = st.dungeonToastBestAt or false }})
		uistub.player.level = 19
		levelUp(19)
		emit({{ shown = card().dungeon or false, told = told() }})
		CT.Hide()
		st.dungeonToastSeen, st.dungeonToastBestAt = {{ ["wailing-caverns"] = true }}, nil
		uistub.player.level = 20
		levelUp(20)
		emit({{ shown = card().shown, told = told(), marked = st.dungeonToastBestAt or false }})"#
	));
	assert_eq!(out[0], json!({ "shown": false, "told": "later", "marked": true }));
	assert_eq!(out[1], json!({ "shown": "wailing-caverns", "told": true }));
	assert_eq!(out[2], json!({ "shown": false, "told": true, "marked": true }), "past best-at: no second card");
}

// "Or a finished prerequisite" (#836): the fixture's Wailing Caverns has no page quest that opens another, so
// its plan is wrapped to stand in for one: until Leaders of the Fang (914, on the page, in the log) is handed
// in, one quest waits for a later level (two to take: not told); once it is, a third opens (told).
#[test]
fn handing_in_a_quest_of_the_dungeons_page_tells_it_once_its_follow_ups_open() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local plan = Polestar.Dungeons.PickupPlan
		Polestar.Dungeons.PickupPlan = function(key)
			local p = plan(key)
			if p and key == "wailing-caverns" then
				if done[914] then p.take[#p.take + 1] = {{ quest = {{ id = 90099 }} }} else p.later = 1 end
			end
			return p
		end
		-- The login check goes first (4 s, no Codex yet: it waits, and the level-up covers it), so that a
		-- dungeon due by now at login isn't taken for one told by the hand-in.
		stub.advance(5)
		levelUp(20)
		emit({{ levelUp = card().shown }})
		log[914], done[914] = nil, true
		-- A quest that isn't on the page tells nothing, not even a dungeon that is due by now.
		stub.fire("QUEST_TURNED_IN", 1490)
		stub.advance(2)
		emit({{ otherQuest = card().shown }})
		-- Handed in while another card is shown: it waits for that one.
		CT.ShowCard({{ head = "LEVEL 20 · DRUID", title = "Cat Form ready", class = "DRUID", guideId = "x" }})
		stub.fire("QUEST_TURNED_IN", 914)
		stub.advance(2)
		local waiting = card().title
		CT.Hide()
		emit({{ waiting = waiting, before = card().shown }})
		stub.advance(1)
		local c = card()
		emit({{ dungeon = c.dungeon, line = c.line }})"#
	));
	assert_eq!(out[0], json!({ "levelUp": false }), "two to take and one for later is not enough (MIN_OPEN)");
	assert_eq!(out[1], json!({ "otherQuest": false }));
	assert_eq!(out[2], json!({ "waiting": "Cat Form ready", "before": false }));
	assert_eq!(out[3], json!({ "dungeon": "wailing-caverns", "line": "3 quests to pick up  ·  Levels 17–24  ·  The Barrens" }));
}

#[test]
fn the_command_says_so_for_a_dungeon_with_nothing_to_pick_up_or_a_character_without_a_level() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local printed = {{}}
		Polestar.Print = function(...) printed[#printed + 1] = table.concat({{ ... }}, " ") end
		Polestar.RunCommand("dungeontoast deadmines")
		emit({{ shown = card().shown, printed = printed }})
		printed = {{}}
		Polestar.Levels.Player = function() return {{ faction = "Horde" }} end
		Polestar.RunCommand("dungeontoast wailing caverns")
		emit({{ shown = card().shown, printed = printed }})"#
	));
	assert_eq!(out[0], json!({ "shown": false, "printed": ["Nothing to pick up"] }), "the Deadmines has no Horde quests");
	assert_eq!(out[1], json!({ "shown": false, "printed": ["No dungeon has opened up for this character."] }));
}

// #869's screenshot: on the guide window at its narrowest the header ("LEVEL 19 · DUNGEON") wrapped and was cut
// beside the chip, and "Turn these off" ran to the card's edge. Where they don't fit on one line, the chip goes
// under the header; where the buttons don't fit in one row, Later and Turn these off take a row of their own
// under the actions, and no row runs past the card's edge.
#[test]
fn on_a_narrow_window_the_chip_goes_under_the_header_and_the_buttons_wrap_inside_the_card() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local w, f = Polestar.UI.GuideFrame.frame, nil
		levelUp(20)
		f = CT.frame
		local names = {{ [f.Act] = "act", [f.More] = "more", [f.Later] = "later", [f.Off] = "off" }}
		for _, width in ipairs({{ Polestar.UI.MAX_WIDTH, Polestar.UI.MIN_WIDTH }}) do
			w:SetWidth(width)
			CT.Place(false)
			local rows, sums, fits = {{ {{}} }}, {{}}, true
			for _, b in ipairs({{ f.Act, f.More, f.Later, f.Off }}) do
				local point = b:GetPoint(1)
				if point == "TOPLEFT" and #rows[#rows] > 0 then rows[#rows + 1] = {{}} end
				local r = rows[#rows]
				local gap = #r == 0 and 0 or (r[#r] == "act" and 8 or 4)
				sums[#rows] = (sums[#rows] or 0) + gap + b:GetWidth()
				r[#r + 1] = names[b]
			end
			for _, s in ipairs(sums) do if s > width - 32 then fits = false end end
			emit({{ chip = f.Badge:GetPoint(1), oneLine = f.Head:GetUnboundedStringWidth() <= f.Head:GetWidth(), badge = f.Badge.Text:GetText(),
				rows = rows, fits = fits }})
		end"#
	));
	assert_eq!(out[0], json!({ "chip": "TOPRIGHT", "oneLine": true, "badge": "+25% OF A LEVEL", "rows": [["act", "more", "later", "off"]], "fits": true }), "beside them on a wide window");
	assert_eq!(out[1], json!({ "chip": "TOPLEFT", "oneLine": true, "badge": "+25% OF A LEVEL", "rows": [["act"], ["more"], ["later", "off"]], "fits": true }), "under them at the narrowest");
}

// Fitz's design for #836, offered from one level below the quests' level (Fitz, 2026-11-10: the game gives many
// 3-5 levels early, and the cards stacked up there). With Leaders of the Fang (914, Horde, level 22, the game gives
// it from 18) not yet taken, 16 is below Wailing Caverns' range; from 17 to 20 one of its three quests still waits
// (two to take: not enough to tell); at 21, one below Leaders of the Fang's level, all three are offered.
#[test]
fn the_card_comes_one_level_below_the_dungeons_quests_level_not_when_the_game_first_gives_them() {
	let out = run(&format!(
		r#"{HEADS_UP}
		log[914] = nil
		local seen = {{}}
		for _, n in ipairs({{ 16, 17, 18, 20, 21 }}) do
			uistub.player.level = n
			levelUp(n)
			local c = card()
			seen[#seen + 1] = c.shown and c.line or false
		end
		emit(seen)"#
	));
	assert_eq!(out[0], json!([false, false, false, false, "3 quests to pick up  ·  Levels 17–24  ·  The Barrens"]));
}

// The heads-up's guide picks up by the same rule, its waiting quest coming back at its offer level; the dungeon's
// page still picks up everything the game gives (Fitz: "still openable early from the menus").
#[test]
fn the_heads_up_s_pick_up_plan_waits_for_one_level_below_a_quest_s_level_the_page_s_does_not() {
	let out = run(&format!(
		r#"{HEADS_UP}
		log[914] = nil
		local D = Polestar.Dungeons
		local function ids(list) local t = {{}} for _, x in ipairs(list) do t[#t + 1] = (x.quest or x).id end table.sort(t) return t end
		local offer, page = D.PickupPlan("wailing-caverns", true), D.PickupPlan("wailing-caverns")
		local w = offer.waiting[1]
		emit({{ offer = ids(offer.take), waiting = {{ w.quest.id, w.level }}, later = offer.later, page = ids(page.take), pageLater = page.later }})"#
	));
	assert_eq!(out[0]["waiting"], json!([914, 21]), "Leaders of the Fang, level 22: from 21");
	assert_eq!(out[0]["later"], 1);
	assert_eq!(out[0]["pageLater"], 0);
	let (offer, page) = (out[0]["offer"].as_array().unwrap(), out[0]["page"].as_array().unwrap());
	assert!(!offer.contains(&json!(914)) && page.contains(&json!(914)), "{offer:?} {page:?}");
	assert_eq!(offer.len() + 1, page.len());
}

// The player's faction only: the Deadmines' one quest is the Alliance's, Leaders of the Fang the Horde's.
#[test]
fn only_dungeons_with_quests_for_the_characters_faction_are_told_and_counted_for_it() {
	let out = run(&format!(
		r#"{HEADS_UP}
		log[914] = nil
		uistub.player.level = 21
		local function list()
			local t = {{}}
			for _, c in ipairs(DT.Candidates(21, "levelup")) do t[#t + 1] = {{ c.key, c.take }} end
			return t
		end
		emit({{ horde = list() }})
		uistub.player.race, uistub.player.class, uistub.player.faction = "Human", "WARRIOR", "Alliance"
		UnitRace = function() return "Human", "Human", 1 end
		UnitFactionGroup = function() return "Alliance", "Alliance" end
		emit({{ alliance = list() }})"#
	));
	assert_eq!(out[0], json!({ "horde": [["wailing-caverns", 3]] }), "the Deadmines has nothing for the Horde");
	assert_eq!(out[1], json!({ "alliance": [["deadmines", 1], ["wailing-caverns", 2]] }), "Leaders of the Fang is not the Alliance's");
}

// "Pick up the quests" builds the dungeon's real pick-up guide and opens it in a new tab beside the leveling guide.
#[test]
fn pick_up_the_quests_opens_the_dungeons_pick_up_guide_in_a_new_tab() {
	let out = run(&format!(
		r#"{HEADS_UP}
		Polestar.Dungeons.PickUp = pickUp
		-- The fake Engine opens only its sample guides: let it open the registered pick-up guide too.
		setmetatable(uistub.guides, {{ __index = function(_, k) return uistub.realGuides.Get(k) end }})
		uistub.openTabs({{ {{ uistub.elwynn, 1 }} }}, 1)
		levelUp(20)
		CT.frame.Act:Click()
		local g = Polestar.Engine.GetGuide()
		local tabs, accepts = {{}}, {{}}
		for i, t in ipairs(Polestar.Engine.GetTabs()) do tabs[i] = t.guideId end
		for _, st in ipairs(g and g.steps or {{}}) do
			for _, goal in ipairs(st.goals or {{}}) do if goal.t == "accept" then accepts[#accepts + 1] = goal.quest end end
		end
		table.sort(accepts)
		emit({{ active = g and g.id or false, tabs = tabs, accepts = accepts, card = card().shown, ui = Polestar.Get("ui.shown") }})"#
	));
	assert_eq!(
		out[0],
		json!({ "active": "lookup/pickup/wailing-caverns", "tabs": ["forever/alliance/human/01-elwynn-forest", "lookup/pickup/wailing-caverns"], "accepts": [959, 1486], "card": false, "ui": true })
	);
}

// The nudge to the Dungeons section: "Open in Dungeons" opens the dungeon's page in the hub.
#[test]
fn open_in_dungeons_shows_the_dungeons_page_in_the_hub() {
	let out = run(&format!(
		r#"{HEADS_UP}
		levelUp(20)
		CT.frame.More:Click()
		emit({{ section = P.Section(), page = DS.Page() or false, card = card().shown, seen = Polestar.CharState().dungeonToastSeen }})"#
	));
	assert_eq!(out[0], json!({ "section": "Dungeons", "page": "wailing-caverns", "card": false, "seen": { "wailing-caverns": true } }));
}

// A level-up while the guide window is hidden: the card waits for the window and the dungeon is told only once
// it has been on screen, so a /reload before then doesn't lose it.
#[test]
fn with_the_guide_window_hidden_the_card_waits_for_it_and_the_dungeon_is_told_once_shown() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local w = Polestar.UI.GuideFrame.frame
		local function told() return (Polestar.CharState().dungeonToastSeen or {{}})["wailing-caverns"] or false end
		w:Hide()
		levelUp(20)
		emit({{ shown = card().shown, told = told() }})
		w:Show()
		stub.advance(1)
		emit({{ shown = card().dungeon or false, told = told() }})"#
	));
	assert_eq!(out[0], json!({ "shown": false, "told": false }));
	assert_eq!(out[1], json!({ "shown": "wailing-caverns", "told": true }));
}

// The Codex (7 MB) never loads for the login or hand-in checks: at login the check waits until something
// else loads it (a level-up, Lookup, the dungeon page); a level-up loads it.
#[test]
fn the_login_and_hand_in_checks_never_load_the_codex_the_login_one_runs_once_it_is_loaded() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local X = Polestar.Codex
		uistub.player.level = 19
		local start = X.IsLoaded()
		stub.fire("QUEST_TURNED_IN", 914)
		stub.advance(5)
		emit({{ start = start, loaded = X.IsLoaded(), shown = card().shown }})
		X.Load()
		stub.advance(2)
		emit({{ loaded = X.IsLoaded(), shown = card().dungeon or false, head = card().head or false }})"#
	));
	assert_eq!(out[0], json!({ "start": false, "loaded": false, "shown": false }));
	assert_eq!(out[1], json!({ "loaded": true, "shown": "wailing-caverns", "head": "LEVEL 19 · DUNGEON" }));
}

// Fitz (2026-11-07): The Hall of Thanes is in Ironforge; Horde can do it, but only through Ironforge. The level 20
// Tauren's heads-up for it says so in the warning colour and leads with the dungeon's page, the pick-up guide
// second; Wailing Caverns' card is as before.
#[test]
fn a_dungeon_whose_entrance_is_in_the_other_factions_land_says_so_on_the_heads_up_and_leads_with_its_page() {
	let out = run(&format!(
		r#"{HEADS_UP}
		local m = DT.Model({{ key = "the-hall-of-thanes", name = "The Hall of Thanes", level = 15, take = 1, minLevel = 13, maxLevel = 20, zoneName = "Ironforge" }})
		local w = DT.Model({{ key = "wailing-caverns", name = "Wailing Caverns", level = 20, take = 2, minLevel = 17, maxLevel = 24, zoneName = "The Barrens" }})
		emit({{ line = m.giver, act = m.act.label, more = m.more.label, wline = w.giver, wact = w.act.label }})"#
	));
	let out = &out[0];
	let line = text(&out["line"]);
	assert!(line.starts_with("1 quest to pick up  ·  Levels 13–20  ·  Ironforge\n|c"), "the facts, then a coloured line: {line}");
	assert!(line.ends_with("Entrance in Alliance territory (in Ironforge)|r"), "{line}");
	assert_eq!(out["act"], "Open in Dungeons");
	assert_eq!(out["more"], "Pick up the quests");
	assert_eq!(out["wline"], "2 quests to pick up  ·  Levels 17–24  ·  The Barrens");
	assert_eq!(out["wact"], "Pick up the quests");
}

// #1730 (danagar, Alliance, Shadowfang Keep): The Orb of Soran'ruk is the Warlocks' quest, and its card said so
// nowhere: he worked it out from the rewards. The page's quests came without classes (the journal fills them only
// from dungeons.json), so who a quest is for now comes from the Codex quest's class and race masks. Each card says
// "Warlock only" with the class in its colour (races too: "Tauren only"), and for a character who may not take it
// the state chip says "Not for your class" (or race) and the name is muted, the rule the pick-up guide leaves it
// out by. Lookup's rows name who it is for too. Here Deviate Hides (1486) is made the Warlocks' and Trouble at the
// Docks (959) the Taurens'; the character is a Tauren Druid, then a Tauren Warlock.
#[test]
fn a_quest_only_some_classes_or_races_may_take_says_who_it_is_for_and_one_not_for_you_says_so_1730() {
	let f = fixture("dungeons.json");
	let mut codex = f["codex"].clone();
	codex["quests"]["1486"]["classes"] = json!(256);
	codex["quests"]["959"]["races"] = json!(32);
	let script = r#"
		local function card(id)
			local b = block(id)
			return { meta = b.Meta:GetText(), plain = plain(b.Meta:GetText()), state = b.State:IsShown() and b.State.Text:GetText() or false,
				title = { b.Title:GetTextColor() } }
		end
		local Lk = Polestar.Lookup
		local function lookup(id) local _, text = Lk.QuestBlock(Polestar.Codex.Quest(id), Lk.PlayerInfo()) return text or false end
		Polestar.Dungeons.Open("wailing-caverns")
		local druid = { hides = card(1486), docks = card(959), lookup = lookup(1486) }
		uistub.player.class = "WARLOCK"
		DS.Render()
		local warlock = { hides = card(1486), docks = card(959), lookup = lookup(1486) }
		uistub.player.race = "Orc"
		DS.Render()
		emit({ druid = druid, warlock = warlock, orc = { docks = card(959), lookup = lookup(959) } })"#;
	let out = run_pack(script, Some(pack_of(&codex, &f["inputs"]))).remove(0);
	let (druid, warlock, orc) = (&out["druid"], &out["warlock"], &out["orc"]);
	let meta = druid["hides"]["meta"].as_str().unwrap();
	assert!(is_match(druid["hides"]["plain"].as_str().unwrap(), "Warlock only"), "{meta}");
	assert!(is_match(meta, r"\|cff[0-9a-f]{6}Warlock\|r only"), "the class in its colour: {meta}");
	assert_eq!(druid["hides"]["state"], "Not for your class");
	assert_ne!(druid["hides"]["title"], warlock["hides"]["title"], "muted for the Druid, the difficulty colour for the Warlock");
	assert_eq!(druid["lookup"], "Warlock only", "Lookup's row says who it is for, not only that it isn't yours");
	assert!(is_match(druid["docks"]["plain"].as_str().unwrap(), "Tauren only"), "{}", druid["docks"]["plain"]);
	assert_eq!(druid["docks"]["state"], false, "a Tauren may take it");
	assert!(is_match(warlock["hides"]["plain"].as_str().unwrap(), "Warlock only"), "still says who it is for");
	assert_eq!(warlock["hides"]["state"], false, "a Warlock may take it: no chip");
	assert_eq!(warlock["lookup"], false);
	assert_eq!(orc["docks"]["state"], "Not for your race");
	assert_eq!(orc["lookup"], "Tauren only");
}

// Fitz, 2026-11-13: never offer a dungeon too low. "For your level" starts at a dungeon's floor (the level its
// run in the route starts at: its range's bottom or where players who killed a boss there entered, whichever is
// higher), not its range's bottom, and the page's group size is the Group Finder's: 5 for the Deadmines and
// Sunken Temple (the old Map table's 10 and 20 were caps), 5-10 for Blackrock Spire's two wings.
#[test]
fn for_your_level_starts_at_the_floor_and_the_page_shows_the_group_finders_size() {
	let out = run(r#"
		Polestar.Dungeons.Load()
		Polestar.Dungeons.Register("dungeon", {
			deadmines = { name = "Deadmines", kind = "dungeon", minLevel = 17, maxLevel = 26, floor = 19.6, players = 5, zoneName = "Westfall" },
			["sunken-temple"] = { name = "Sunken Temple", kind = "dungeon", minLevel = 50, maxLevel = 60, floor = 50, players = 5, zoneName = "Swamp of Sorrows" },
			["blackrock-spire"] = { name = "Blackrock Spire", kind = "dungeon", minLevel = 55, maxLevel = 60, floor = 55, players = 5, playersMax = 10, zoneName = "Searing Gorge" },
		}, { deadmines = "return {}", ["sunken-temple"] = "return {}", ["blackrock-spire"] = "return {}" })
		local function at(level)
			uistub.player.level = level
			Polestar.Dungeons.Open()
			DS.SetFaction("All")
			DS.SetBand("level")
			return cardNames()
		end
		local function sub(key)
			Polestar.Dungeons.Open(key)
			local _, _, pg = DS.Frames()
			return pg.Sub:GetText()
		end
		emit({ at19 = at(19), at20 = at(20), dm = sub("deadmines"), st = sub("sunken-temple"), brs = sub("blackrock-spire"),
			floor = Polestar.Dungeons.Get("deadmines").floor, best = Polestar.Dungeons.BestAt("deadmines") })"#);
	let out = &out[0];
	assert_eq!(out["at19"], json!({}), "19 is in the Deadmines' 17-26 but under its floor 19.6");
	assert_eq!(out["at20"], json!(["Deadmines"]), "from the floor up");
	assert_eq!(out["floor"], 19.6);
	assert!(out["best"].as_i64().unwrap() >= 20, "best at never under the floor: {}", out["best"]);
	assert!(out["dm"].as_str().unwrap().contains("5 players"), "{}", out["dm"]);
	assert!(out["st"].as_str().unwrap().contains("5 players"), "{}", out["st"]);
	assert!(out["brs"].as_str().unwrap().contains("5\u{2013}10 players") || out["brs"].as_str().unwrap().contains("5-10 players"), "{}", out["brs"]);
}

// Fitz, 2026-11-13: never offer a dungeon too low. With players' recorded entries setting Wailing Caverns' floor at
// 20.3 (71 people with a boss kill, a quarter of them under 20.3: the Codex's `levels_of`), a level 20 character, inside
// its 17-24 range but under the floor, sees it neither in "For your level" nor on the card that says it is open; the
// card comes at its best-at level, which never sits under the floor.
#[test]
fn between_the_range_and_the_floor_players_recorded_entries_set_neither_the_hub_nor_the_card_offers_the_dungeon() {
	let f = fixture("dungeons.json");
	let mut inputs = f["inputs"].clone();
	inputs["recordedDungeons"] = json!({ "43": { "people": 71, "p25": 20.3, "p90": 25.6 } });
	let out = run_pack(
		&format!(
			r#"{HEADS_UP}
		local function keys(list) local t = {{}} for _, c in ipairs(list) do t[#t + 1] = c.key end return t end
		Polestar.Dungeons.Load()
		local best = Polestar.Dungeons.BestAt("wailing-caverns")
		uistub.player.level = 20
		Polestar.Dungeons.Open()
		DS.SetFaction("All")
		DS.SetBand("level")
		emit({{ floor = Polestar.Dungeons.Get("wailing-caverns").floor, best = best, hub20 = cardNames(),
			card20 = keys(DT.Candidates(20, "any")), cardBest = keys(DT.Candidates(best, "any")) }})"#
		),
		Some(pack_of(&f["codex"], &inputs)),
	);
	let out = &out[0];
	assert_eq!(out["floor"], 20.3);
	assert!(out["best"].as_f64().unwrap() >= 21.0, "best at never under the floor: {}", out["best"]);
	assert_eq!(out["hub20"], json!({}), "level 20, under the floor 20.3: not for your level");
	assert_eq!(out["card20"], json!({}), "and no card");
	assert_eq!(out["cardBest"], json!(["wailing-caverns"]), "the card at its best-at level");
}
