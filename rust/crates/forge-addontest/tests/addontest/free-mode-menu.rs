//! Free mode in the main window (addon/Polestar/UI/FreeMode.lua, Polestar_FreeMode/Page.lua): its menu item right under
//! Guides with its own icon, the page (Start or Return to <guide>, which quest first, the hand-in route, every quest in
//! the log with a tick and a pin, the quick actions), the hand-in row in the guide window, a gamepad on the page and
//! the world map's click on a held quest's pin. The choices are Free mode's own saved state (CharState().free).
//!
//! The Codex is tests/fixtures/codex/free-mode.json with the Highland Ogre an elite (Ogre Menace takes a group): a
//! Human Warrior at level 20 at Marshal Hale's camp (map 9001), 7001-7005 around it and 7101-7108 in Merrow Fields
//! (map 9002).

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::questdb::{build_db, fixture_dir};
use forge_addontest::{emitted, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

thread_local! {
	static PACK: CodexPack = {
		let mut codex = fixture("free-mode.json");
		codex["npcs"]["5014"]["elite"] = json!(true);
		write_codex_pack(&codex, &CodexOpts::default())
	};
}

fn maps() -> String {
	let codex = fixture("free-mode.json");
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.into_iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

// The quests as the log takes them, the step titles in order, the page and its rows.
const HELPERS: &str = r#"
local E, F, UI = Polestar.Engine, Polestar.Free, Polestar.UI
local Q = {
	[7001] = { { text = "Ridge Gnoll slain: 0/5", required = 5 } },
	[7002] = { { text = "Boar Tusk: 0/4", required = 4, type = "item" } },
	[7003] = { { text = "Marsh Lurker slain: 0/6", required = 6 } },
	[7004] = { { text = "Highland Ogre slain: 0/3", required = 3 } },
	[7101] = { { text = "Thing: 0/1", required = 1 } },
	[7102] = { { text = "Thing: 0/1", required = 1 } },
}
local TITLE = { [7001] = "Gnoll Trouble", [7002] = "Boar Hunt", [7003] = "Lurkers in the Marsh", [7004] = "Ogre Menace",
	[7101] = "Merrow's Errand", [7102] = "Oake's Fields" }
local function take(...)
	for _, q in ipairs({ ... }) do w.accept(q, Q[q], TITLE[q]) end
	stub.advance(1)
end
local function finish(q, n) w.progress(q, 1, n or 1); stub.advance(1) end
local function titles()
	local out = {}
	for i = 1, E.GetStepCount() do out[i] = E.GetStepView(i).title end
	return out
end
local function page()
	UI.ShowFreeMode()
	stub.advance(0.3)
	return F.Page
end
local function rowOf(q)
	for _, r in ipairs(F.Page.rows) do if r:IsShown() and r.psQuest == q then return r end end
end
local function shownTitles()
	local out = {}
	for _, r in ipairs(F.Page.Shown()) do out[#out + 1] = r.title end
	return out
end
"#;

fn run_with(script: &str, stubs: Vec<&'static str>) -> Vec<Value> {
	let pack = PACK.with(|p| p.stub_lua.clone());
	let before = format!(
		"{pack}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n",
		maps()
	);
	emitted(&RunAddon { stubs, before, addons: vec![Addon::name("Polestar")], login: true, script: format!("{HELPERS}{script}"), ..Default::default() })
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, vec!["stub_world.lua"])
}

// A Lua list of numbers (an empty table is emitted as {}).
fn nums(v: &Value) -> Vec<i64> {
	v.as_array().map(|a| a.iter().map(|n| n.as_i64().unwrap()).collect()).unwrap_or_default()
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| text(s).to_string()).collect()).unwrap_or_default()
}

#[test]
fn free_mode_is_a_menu_item_right_under_guides_with_its_own_icon_and_a_page() {
	let out = run(r#"
UI.ShowPicker()
stub.advance(0.3)
local P = UI.Picker
local keys, icon, label = {}, nil, nil
for _, s in ipairs(P.Sections()) do
	keys[#keys + 1] = s.key
	if s.key == "FreeMode" then icon, label = s.icon, s.label end
end
local rail = {}
for _, b in ipairs(PolestarPicker.railButtons or {}) do
	if b:IsShown() and b.psKey ~= "Options" then rail[#rail + 1] = b.psKey end
end
P.ShowSection("FreeMode")
stub.advance(0.3)
emit({ keys = keys, rail = rail, icon = icon, label = label, section = P.Section(), page = F.Page ~= nil, title = PolestarPicker.Title:GetText() })
"#);
	let o = &out[0];
	let keys = strs(&o["keys"]);
	assert_eq!(keys[0], "Guides");
	assert_eq!(keys[1], "FreeMode", "right under Guides: {keys:?}");
	assert_eq!(keys[2], "Lookup", "and before Lookup: {keys:?}");
	assert_eq!(strs(&o["rail"])[..2], ["Guides", "FreeMode"]);
	assert_eq!(text(&o["icon"]), "icon-ownpath", "its own glyph, not the Exploration compass");
	assert_eq!(text(&o["label"]), "Free mode");
	assert_eq!(text(&o["section"]), "FreeMode");
	assert!(truthy(&o["page"]), "the page loads with its folder");
	assert_eq!(text(&o["title"]), "Free mode");
}

#[test]
fn the_page_with_free_mode_off_lists_every_quest_with_its_zone_level_and_state_and_offers_start() {
	let out = run(r#"
take(7001, 7002, 7101)
finish(7101)
page()
local s = F.Page.Shown()
local rows = {}
for _, r in ipairs(s) do rows[#rows + 1] = { r.title, r.zone, r.level, r.checked, r.ready, r.pinned } end
emit({ start = s.start, on = s.on, pick = s.pick, handin = s.handin, rows = rows, actions = s.actions })
"#);
	let o = &out[0];
	assert_eq!(text(&o["start"]), "Start");
	assert!(!truthy(&o["on"]));
	assert_eq!(text(&o["pick"]), "near");
	assert_eq!(o["handin"]["count"], 1);
	assert_eq!(text(&o["handin"]["text"]), "Hand in finished quests (1)");
	assert_eq!(
		o["rows"],
		json!([["Gnoll Trouble", "Hale's Reach", 20, true, false, false], ["Boar Hunt", "Hale's Reach", 21, true, false, false], ["Merrow's Errand", "Merrow Fields", 20, true, true, false]]),
		"by zone, level and title: one row each, ticked, Merrow's Errand ready to hand in"
	);
	assert_eq!(o["actions"], json!({ "zones": 2, "group": 0, "out": 0 }));
}

#[test]
fn the_page_with_free_mode_on_says_return_to_the_guide_it_came_from_and_the_button_goes_back_to_it() {
	let out = run(r#"
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
} }))
E.SetGuide("test/route")
take(7001)
local P = page()
local off = P.Shown().start
P.parts.Start:Click()
stub.advance(1)
local on = { start = P.Shown().start, on = P.Shown().on, guide = E.GetGuide().id, state = P.Shown().state }
P.parts.Start:Click()
stub.advance(1)
emit({ off = off, on = on, after = E.GetGuide().id, running = F.IsOn(), start = P.Shown().start })
"#);
	let o = &out[0];
	assert_eq!(text(&o["off"]), "Start");
	assert_eq!(text(&o["on"]["start"]), "Return to Route");
	assert!(truthy(&o["on"]["on"]));
	assert_eq!(text(&o["on"]["guide"]), "lookup/free/log");
	assert_eq!(text(&o["on"]["state"]), "Free mode: the arrow takes your own quests, nearest first.");
	assert_eq!(text(&o["after"]), "test/route", "Return to hands the arrow back");
	assert!(!truthy(&o["running"]));
	assert_eq!(text(&o["start"]), "Start");
}

#[test]
fn the_order_choice_on_the_page_is_the_free_pick_setting() {
	let out = run(r#"
take(7001, 7002)
local P = page()
P.parts.XP:Click()
stub.advance(0.5)
local xp = { Polestar.Get("free.pick"), P.Shown().pick }
P.parts.Near:Click()
stub.advance(0.5)
emit({ xp = xp, near = { Polestar.Get("free.pick"), P.Shown().pick } })
"#);
	assert_eq!(out[0]["xp"], json!(["xp", "xp"]));
	assert_eq!(out[0]["near"], json!(["near", "near"]));
}

#[test]
fn ticking_and_pinning_a_row_changes_free_mode_s_order_and_the_choices_live_in_the_character_s_saved_state() {
	let out = run(r#"
take(7001, 7002, 7003)
assert(F.Start())
stub.advance(1)
local normal = titles()
page()
-- Untick Gnoll Trouble: left out of the loop, its row dimmed and unticked.
rowOf(7001):Click()
stub.advance(1)
local left = { titles = titles(), shown = shownTitles(), out = F.LeftOut(), ticked = rowOf(7001).Check:GetChecked() and true or false }
rowOf(7001):Click()
stub.advance(1)
local back = { titles = titles(), out = F.LeftOut(), ticked = rowOf(7001).Check:GetChecked() and true or false }
-- Pin the far one: it comes first, whatever the order.
rowOf(7003).Pin:Click()
stub.advance(1)
local pinned = { titles = titles(), pinned = F.Pinned() }
local saved = Polestar.CharState().free
local state = { pin = saved.pin, out = saved.out[7001] }
rowOf(7003).Pin:Click()
stub.advance(1)
emit({ normal = normal, left = left, back = back, pinned = pinned, state = state, unpinned = { titles = titles(), pinned = F.Pinned() or false } })
"#);
	let o = &out[0];
	assert_eq!(strs(&o["normal"])[0], "Gnoll Trouble");
	assert_eq!(strs(&o["left"]["titles"]), vec!["Boar Hunt".to_string(), "Lurkers in the Marsh".to_string()], "{o}");
	assert_eq!(o["left"]["shown"].as_array().unwrap().len(), 3, "a quest left out keeps its row");
	assert_eq!(nums(&o["left"]["out"]), vec![7001]);
	assert_eq!(o["left"]["ticked"], false);
	assert!(nums(&o["back"]["out"]).is_empty());
	assert_eq!(o["back"]["ticked"], true);
	assert_eq!(strs(&o["back"]["titles"])[0], "Gnoll Trouble");
	assert_eq!(strs(&o["pinned"]["titles"])[0], "Lurkers in the Marsh");
	assert_eq!(o["pinned"]["pinned"], 7003);
	assert_eq!(o["state"], json!({ "pin": 7003 }), "Free mode's own saved state, no second store");
	assert_eq!(strs(&o["unpinned"]["titles"])[0], "Gnoll Trouble");
	assert_eq!(o["unpinned"]["pinned"], false);
}

#[test]
fn the_quick_actions_leave_out_a_zone_or_the_quests_that_take_a_group_and_one_button_brings_them_back() {
	let out = run(r#"
take(7001, 7004, 7101, 7102)
assert(F.Start())
stub.advance(1)
local P = page()
local zones = {}
for _, z in ipairs(F.Zones()) do zones[#zones + 1] = { z.name, #z.quests } end
local before = P.Shown().actions
-- The group action: Ogre Menace (an elite objective).
P.parts.Group:Click()
stub.advance(1)
local group = { out = F.LeftOut(), titles = titles(), actions = P.Shown().actions }
-- The zone action: the zone's menu, then its row.
P.parts.Zone:Click()
local items = {}
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText():find("Merrow", 1, true) then r:Click() break end end
stub.advance(1)
local zone = { out = F.LeftOut(), titles = titles(), actions = P.Shown().actions, back = P.parts.Back.Label:GetText() }
P.parts.Back:Click()
stub.advance(1)
emit({ zones = zones, before = before, group = group, items = items, zone = zone, after = { out = F.LeftOut(), titles = titles() } })
"#);
	let o = &out[0];
	assert_eq!(o["zones"], json!([["Hale's Reach", 2], ["Merrow Fields", 2]]), "the zones of the quests in the loop, the busiest first, then by name");
	assert_eq!(o["before"], json!({ "zones": 2, "group": 1, "out": 0 }));
	assert_eq!(nums(&o["group"]["out"]), vec![7004]);
	assert!(!strs(&o["group"]["titles"]).contains(&"Ogre Menace".to_string()));
	assert_eq!(o["group"]["actions"]["group"], 0);
	assert_eq!(strs(&o["items"]), ["Merrow Fields (2)", "Hale's Reach (1)"]);
	assert_eq!(nums(&o["zone"]["out"]), vec![7004, 7101, 7102]);
	assert_eq!(strs(&o["zone"]["titles"]), ["Gnoll Trouble"]);
	assert_eq!(text(&o["zone"]["back"]), "Bring back left-out quests (3)");
	assert!(nums(&o["after"]["out"]).is_empty());
	assert_eq!(strs(&o["after"]["titles"]).len(), 4);
}

#[test]
fn the_hand_in_tile_counts_the_finished_quests_and_opens_the_shortest_trip_guide() {
	let out = run(r#"
take(7001, 7002)
local P = page()
local none = { P.Shown().handin.text, P.Shown().handin.enabled }
finish(7001, 5)
finish(7002, 4)
stub.advance(0.5)
local two = { P.Shown().handin.text, P.Shown().handin.enabled }
P.parts.Handin:Click()
stub.advance(1)
local tabs = {}
for _, t in ipairs(E.GetTabs()) do tabs[#tabs + 1] = t.guideId end
emit({ none = none, two = two, tabs = tabs, guide = E.GetGuide().id })
"#);
	let o = &out[0];
	assert_eq!(o["none"], json!(["None to hand in", false]));
	assert_eq!(o["two"], json!(["Hand in finished quests (2)", true]));
	assert_eq!(text(&o["guide"]), "lookup/carried/log");
	assert!(strs(&o["tabs"]).contains(&"lookup/carried/log".to_string()));
}

#[test]
fn the_guide_window_s_hand_in_row_shows_from_two_finished_quests_none_in_the_step_hides_until_the_count_changes_and_opens_the_hand_in_tab() {
	let out = run(r#"
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
	{ title = "Hale", goals = { { t = "turnin", quest = 7001, title = "Gnoll Trouble", npc = 5001, npcName = "Marshal Hale", map = 9001, x = 50, y = 52 } } },
} }))
E.SetGuide("test/route")
local GF = UI.GuideFrame
local function row()
	for _, l in ipairs(GF.lines) do
		if l:IsShown() and l.psHandins then return l end
	end
end
local function said() local l = row(); return l and l.Text:GetText() or false end
take(7001, 7002, 7003)
stub.advance(1)
local none = said()
finish(7002, 4)
local one = said()
finish(7003, 6)
local two = said()
local line = row()
-- Its close button hides it; the same count keeps it hidden, a new one shows it again.
line.Close:Click()
local closed = said()
take(7101)
finish(7101)
local three = said()
-- Route opens the hand-in tab.
row():Click()
stub.advance(1)
local guide = E.GetGuide().id
-- The setting turns it off.
E.SetGuide("test/route")
GF.handinClosed = nil
GF.Refill()
local on = said()
Polestar.Set("guideWindow.handinRow", false)
stub.advance(0.5)
GF.Refill()
local off = said()
Polestar.Set("guideWindow.handinRow", true)
-- A finished quest that is part of the step keeps the row away.
E.Goto(2)
stub.advance(1)
finish(7001, 5)
GF.handinClosed = nil
GF.Refill()
emit({ none = none, one = one, two = two, closed = closed, three = three, guide = guide, on = on, off = off, inStep = said() })
"#);
	let o = &out[0];
	assert_eq!(o["none"], false);
	assert_eq!(o["one"], false, "one finished quest is no row");
	assert!(text(&o["two"]).starts_with("2 quests ready to hand in"), "{o}");
	assert_eq!(o["closed"], false, "the close button hides it");
	assert!(text(&o["three"]).starts_with("3 quests ready to hand in"), "a new count shows it again: {o}");
	assert_eq!(text(&o["guide"]), "lookup/carried/log", "Route opens the hand-in tab");
	assert!(text(&o["on"]).starts_with("3 quests ready"), "{o}");
	assert_eq!(o["off"], false, "Settings > Guide window > Parts > Hand-in row");
	assert_eq!(o["inStep"], false, "a finished quest of the step on screen: no row");
}

#[test]
fn a_gamepad_reaches_the_start_button_the_order_and_every_row_a_ticks_or_unticks_a_row_and_x_pins_it() {
	let out = run_with(
		r#"
Polestar.Set("gamepad.withMouse", true)
stub.advance(3)
if PolestarWelcome then PolestarWelcome:Hide() end
take(7001, 7002, 7003)
local G = Polestar.Gamepad
page()
stub.advance(0.3)
local owner = G.owner and G.owner:GetName()
-- What the focus can reach: the buttons and one stop a row (a row's own pin is the mouse's, X is the gamepad's).
local reach = {}
for _, c in ipairs(G.Collect(PolestarPicker)) do
	if c.psQuest then reach[#reach + 1] = c.psQuest elseif c == F.Page.parts.Start then reach[#reach + 1] = "start" elseif c == F.Page.parts.Near then reach[#reach + 1] = "near" end
end
-- Until a button is pressed the focus follows the window's first stop: a press settles it, then the D-pad's target is the row.
stub.press("PADDDOWN")
local row = rowOf(7002)
G.SetFocus(PolestarPicker, row)
stub.advance(0.1)
local focused = G.Focused(PolestarPicker) == row
stub.press("PAD1")
stub.advance(0.5)
local left = F.LeftOut()
stub.press("PAD1")
stub.advance(0.5)
local back = F.LeftOut()
stub.press("PAD3")
stub.advance(0.5)
local pinned = F.Pinned()
local xlabel = row.psPadXLabel()
stub.press("PAD3")
stub.advance(0.5)
emit({ reach = reach, focused = focused, left = left, back = back, pinned = pinned, unpinned = F.Pinned() or false, label = row.psPadLabel, xlabel = xlabel, owner = owner })
"#,
		vec!["stub_world.lua", "stub_gamepad.lua"],
	);
	let o = &out[0];
	let reach: Vec<String> = o["reach"].as_array().unwrap().iter().map(|v| v.to_string()).collect();
	for want in ["\"start\"", "\"near\"", "7001", "7002", "7003"] {
		assert!(reach.contains(&want.to_string()), "the page is in the gamepad's reach, {want} too: {o}");
	}
	assert_eq!(text(&o["owner"]), "PolestarPicker");
	assert_eq!(o["focused"], true);
	assert_eq!(nums(&o["left"]), vec![7002], "A unticks it");
	assert!(nums(&o["back"]).is_empty(), "A ticks it again");
	assert_eq!(o["pinned"], 7002, "X pins it");
	assert_eq!(text(&o["xlabel"]), "Unpin", "the hint says what X does next");
	assert_eq!(o["unpinned"], false, "X again unpins it");
}

#[test]
fn a_click_on_a_held_quest_s_pin_on_the_world_map_makes_it_free_mode_s_first_quest_and_again_unpins_it() {
	let db = build_db(&fixture_dir());
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua"],
		before: format!(
			"stub.quests.dbFiles = {}\nlocal w = stub.world\nw.addMap(1429, {{ name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})\nw.moveTo(1429, 48, 40)\nfor q, t in pairs({{ [7] = \"Kobold Camp Cleanup\", [18] = \"Gathering Wood\" }}) do w.titles[q] = t end",
			db.lua_files()
		),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { qol = { mapObjectives = true, turnInMarkers = true } } }".into())],
		script: r#"
local w, sq, F = stub.world, stub.quests, Polestar.Free
sq.installPins()
stub.login()
stub.advance(0.3)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(18, { { text = "Wood: 0/4", type = "item", required = 4 } })
stub.advance(1)
local pins = sq.pins.layers["quests.objectives"].pins
local function pinOf(q)
	for _, p in ipairs(pins) do
		for _, r in ipairs(p.refs) do if r.q == q then return p end end
	end
end
local p7, p18 = pinOf(7), pinOf(18)
local function lines(p)
	local out = {}
	local tt = { AddLine = function(_, text) out[#out + 1] = text end }
	p.tooltip(tt)
	return out[#out]
end
local hint = lines(p7)
p7.onClick("LeftButton")
local first = F.Pinned()
local hintPinned = lines(p7)
p18.onClick("LeftButton")
local second = F.Pinned()
p18.onClick("LeftButton")
local third = F.Pinned() or false
p7.onClick("RightButton")
local right = F.Pinned() or false
IsShiftKeyDown = function() return true end
p7.onClick("LeftButton")
local shifted = F.Pinned() or false
IsShiftKeyDown = function() return false end
p7.onClick("LeftButton", {})
emit({ hint = hint, hintPinned = hintPinned, first = first, second = second, third = third, right = right, shifted = shifted, minimap = F.Pinned() or false })
"#
		.into(),
		..Default::default()
	});
	let o = &out[0];
	assert_eq!(text(&o["hint"]), "Click to make it Free mode's first quest");
	assert_eq!(o["first"], 7, "a click pins the quest");
	assert_eq!(text(&o["hintPinned"]), "Click to unpin it from Free mode");
	assert_eq!(o["second"], 18, "another quest's pin takes the first place");
	assert_eq!(o["third"], false, "clicked again, unpinned");
	assert_eq!(o["right"], false, "the right button is the map's");
	assert_eq!(o["shifted"], false, "Shift-click is Journey's");
	assert_eq!(o["minimap"], false, "mouse on the world map only");
}
