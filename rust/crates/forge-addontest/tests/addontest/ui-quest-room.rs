//! The Quest room (UI/QuestRoom.lua) with the log of a player who installs Polestar mid-leveling: thirty quests
//! from all over, none of them on the route, every fifth finished. One row per quest would stand 1,300 tall:
//! the window keeps to the screen instead (1080 high, and a 1366x768 screen at UI scale 1), its rows scrolling
//! inside it, every one reachable, the title, the close button, the switch to the finished quests and Guide me to all
//! outside the list and in reach; a quest's title or second line cut short reads whole in its tooltip, and the
//! second line keeps inside the window.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const LONG: &str = "Duskwood Mission XVIII: Rescue Elenora Marshwalker";

fn world(height: u32) -> String {
	format!(
		r#"
local w = stub.world
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 34
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 42.5, 36.0)
UIParent.height = {height}
for i = 1, 30 do
	w.onQuest(9000 + i, i % 5 == 0 and {{}} or {{ 8 }}, i == 1 and "{LONG}" or i == 5 and "{LONG} (finished)" or ("Quest " .. i))
end
"#
	)
}

// One guide that hands none of them in.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 30, maxLevel = 40, steps = {
	{ title = "Far", goals = { { t = "goto", map = 1429, x = 70, y = 70 } } },
} })
"#;

// Every finished one is taken in by an NPC with a long name in a zone with a long name.
const ENDER: &str = r#"
Polestar.RoutePlan.Ender = function(q)
	return { npc = 7000 + q, name = "Самонаводящийся робот КПХ-9/HL", zone = "Внутренние земли Хинтерленда", map = 1429, x = 50, y = 50 }
end
"#;

fn run(height: u32, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world(height),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			ENDER,
			"stub.login()",
			r#"Polestar.Set("behavior.autoAccept", false); Polestar.Set("ui.shown", true)"#,
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"Polestar.Engine.SetGuide("test/a"); stub.advance(0.6); stub.advance(0.6)"#,
			r#"local UI, F = Polestar.UI
-- The window's measures, and its rows: shown, inside the scroll list, each title's and second line's own text
-- and width.
function measure(mode)
	UI.ShowQuestRoom(mode)
	F = PolestarQuestRoom
	local list = rawget(F, "List")
	local rows, inList, widths = 0, 0, true
	for _, r in ipairs(F.rows) do
		if r:IsShown() then
			rows = rows + 1
			if list and r:GetParent() == list.Child then inList = inList + 1 end
			local w = r.Why:GetWidth()
			if not (w > 0 and w <= F:GetWidth() - 48) then widths = false end
		end
	end
	return { height = F:GetHeight(), screen = UIParent:GetHeight(), rows = rows, inList = inList, widths = widths,
		scrolls = list ~= nil and list.psContent ~= nil and list.psContent > list:GetHeight(),
		switch = F.Switch:IsShown() and F.Switch:GetParent() == F, guideMe = F.GuideMe:IsShown() and F.GuideMe:GetParent() == F }
end"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn make_room_keeps_to_a_1080_screen_with_thirty_quests_scrolling_inside_it() {
	let out = run(1080, "emit(measure())");
	assert!(out["height"].as_f64().unwrap() <= 1080.0 - 48.0, "the window stands taller than the screen: {out}");
	assert_eq!(out["rows"], 30, "{out}");
	assert_eq!(out["inList"], 30, "every row in the scroll list: {out}");
	assert_eq!(out["scrolls"], true, "{out}");
	assert_eq!(out["switch"], true, "the switch to the finished quests sits on the window, under the list: {out}");
}

#[test]
fn make_room_and_the_finished_list_keep_to_a_1366x768_screen_at_ui_scale_1() {
	let out = run(768, r#"emit({ room = measure(), carried = measure("carried") })"#);
	for mode in ["room", "carried"] {
		let m = &out[mode];
		assert!(m["height"].as_f64().unwrap() <= 768.0 - 48.0, "{mode}: the window stands taller than the screen: {out}");
		assert_eq!(m["inList"], m["rows"], "{mode}: {out}");
	}
	assert_eq!(out["carried"]["rows"], 6, "{out}");
	assert_eq!(out["carried"]["guideMe"], true, "{out}");
	assert_eq!(out["carried"]["widths"], true, "the second line keeps inside the window: {out}");
}

#[test]
fn the_switch_is_a_framed_secondary_button_in_both_lists() {
	let out = run(
		768,
		r#"measure()
local function framed() return F.Switch.psTextButton == true and not F.Switch.psGhost and not F.Switch.psPrimary end
local room = { F.Switch.Label:GetText(), framed() }
F.Switch:Click()
local carried = { F.Switch.Label:GetText(), framed() }
F.Switch:Click()
emit({ room = room, carried = carried, back = F.Title:GetText() })"#,
	);
	assert_eq!(out["room"], json!(["Finished quests you're still carrying (6)", true]), "{out}");
	assert_eq!(out["carried"], json!(["Make room in your quest log", true]), "{out}");
	assert_eq!(out["back"], "Make room in your quest log", "{out}");
}

#[test]
fn a_title_or_second_line_cut_short_reads_whole_in_its_tooltip() {
	let out = run(
		1080,
		r#"measure("carried")
local r = F.rows[1]
GameTooltip.lines = {}
stub.RunScript(r, "OnEnter")
local tip = GameTooltip.lines
stub.RunScript(r, "OnLeave")
emit({ title = r.Title:GetText(), cut = r.Title:IsTruncated() or r.Why:IsTruncated(), tip = tip, owner = GameTooltip:GetOwner() == r })"#,
	);
	assert_eq!(out["cut"], true, "{out}");
	assert_eq!(out["owner"], true, "{out}");
	assert_eq!(out["tip"][0], format!("{LONG} (finished)"), "{out}");
	assert_eq!(out["tip"][1], "Самонаводящийся робот КПХ-9/HL, Внутренние земли Хинтерленда", "{out}");
	assert_eq!(out["title"], json!(format!("{LONG} (finished)")), "{out}");
}

#[test]
fn each_finished_quest_guides_only_to_its_handin_and_leaves_room_for_abandon() {
	let out = run(
		768,
		r#"Polestar.Codex.Register("meta", {})
local P = Polestar.RoutePlan
local list = {
	{ quest = 9005, title = "A finished grey quest with a very long name", grey = true },
	{ quest = 9010, title = "A finished quest with no known recipient" },
}
P.Carried = function() return list end
P.Unneeded = function() return { { quest = 9005, title = list[1].title, status = "grey" } } end
local ender = P.Ender
P.Ender = function(q) if q ~= 9010 then return ender(q) end end
local function click(row)
	assert(row.GuideMe:IsShown(), "each finished quest has a Guide me button")
	row.GuideMe:Click()
	local guide, quests, goal = Polestar.Engine.GetGuide(), {}, nil
	for _, s in ipairs(guide.steps) do
		for _, g in ipairs(s.goals) do
			if g.t == "turnin" then quests[#quests + 1], goal = g.quest, g end
		end
	end
	return { id = guide.id, quests = quests, map = goal and goal.map or false, closed = not F:IsShown() }
end
measure("carried")
local row = F.rows[1]
local guide = assert(rawget(row, "GuideMe"), "a finished row has a Guide me button")
stub.RunScript(guide, "OnEnter")
local tip = GameTooltip:GetOwner() == guide and GameTooltip.lines[1]
stub.RunScript(guide, "OnLeave")
-- What a button is anchored to, and whether both text lines end left of the given buttons.
local function anchor(b) local _, rel, relPoint = b:GetPoint(); return rel, relPoint end
local function textFits(...)
	local w = 2
	for _, b in ipairs({ ... }) do w = w + b:GetWidth() + 6 end
	return row.Title:GetWidth() <= row:GetWidth() - w and row.Why:GetWidth() <= row:GetWidth() - w
end
local guideRel, guidePoint = anchor(guide)
local fits = row.Abandon:IsShown() and guideRel == row and guidePoint == "RIGHT" and anchor(row.Abandon) == guide
	and textFits(guide, row.Abandon)
local D = Polestar.Dungeons
local mark, tooltip = D.QuestMark, D.MarkTooltip
D.QuestMark = function(q) if q == 9005 then return { key = "gnomeregan" } end return mark(q) end
D.MarkTooltip = function(q) if q == 9005 then return "Part of the Gnomeregan quests" end return tooltip(q) end
Polestar.UI.LayoutQuestRoom()
local allFit = row.Dungeon:IsShown() and anchor(guide) == row and anchor(row.Dungeon) == guide
	and anchor(row.Abandon) == row.Dungeon and textFits(guide, row.Dungeon, row.Abandon)
local carried = click(row)
measure("elsewhere")
local elsewhere = click(F.rows[2])
measure()
emit({ carried = carried, elsewhere = elsewhere, fits = fits, allFit = allFit, tip = tip or false,
	hidden = not F.rows[1].GuideMe:IsShown() })"#,
	);
	assert_eq!(out["carried"], json!({ "id": "lookup/carried/9005", "quests": [9005], "map": 1429, "closed": true }), "{out}");
	assert_eq!(out["elsewhere"], json!({ "id": "lookup/carried/9010", "quests": [9010], "map": false, "closed": true }), "{out}");
	assert_eq!(out["fits"], true, "Guide me takes the right edge, Abandon sits left of it, and the text ends before both: {out}");
	assert_eq!(out["allFit"], true, "the dungeon icon goes left of Guide me, Abandon left of that, and the text ends before all three: {out}");
	assert_eq!(out["tip"], "Guide me to this hand-in", "{out}");
	assert_eq!(out["hidden"], true, "reused Make room rows hide the button: {out}");
}

#[test]
fn guide_me_to_all_opens_the_whole_log_and_stays_clear_of_the_switch() {
	let out = run(
		768,
		r#"Polestar.Codex.Register("meta", {})
local starts, allCalls = 0, 0
Polestar.RoutePlan.Carried = function(all)
	if not all then return {} end
	allCalls = allCalls + 1
	return { { quest = 9005, title = "Finished quest" } }
end
Polestar.RoutePlan.Ender = function() return nil end
local start = Polestar.Handins.Start
Polestar.Handins.Start = function(...) starts = starts + 1; return start(...) end
local room = measure()
-- Simulate a wider label, as a translation gives: the footer stays on one line and the wider label is cut short.
F.GuideMe:SetWidth(220)
local carried = measure("carried")
local cut = {}
for _, b in ipairs({ F.Switch, F.GuideMe }) do
	if b.psFooterCut then cut[#cut + 1] = b.psTip == b.Label:GetText() and not b.Label:GetWordWrap() end
end
local oneLine = {
	sameTop = select(5, F.Switch:GetPoint()) == select(5, F.GuideMe:GetPoint()),
	fits = F.Switch:GetWidth() + 16 + F.GuideMe:GetWidth() <= F:GetWidth() - 48 + 0.5,
	cut = cut,
}
local label = F.GuideMe.Label:GetText()
local before, hint, why = starts, F.Hint:GetText(), F.rows[1].Why:GetText()
F.GuideMe:Click()
local guide, quests, manual = Polestar.Engine.GetGuide(), {}, true
for _, s in ipairs(guide.steps) do
	for _, g in ipairs(s.goals) do
		if g.t == "turnin" then quests[#quests + 1], manual = g.quest, manual and g.currentLog and g.map == nil end
	end
end
table.sort(quests)
emit({ room = room, carried = carried, before = before, starts = starts, allCalls = allCalls,
	hint = hint, why = why, shown = F:IsShown(), label = label, oneLine = oneLine,
	id = guide.id, quests = quests, manual = manual })"#,
	);
	assert_eq!(out["label"], "Guide me to all", "{out}");
	assert_eq!(out["oneLine"]["sameTop"], true, "a wider label keeps the footer on one line: {out}");
	assert_eq!(out["oneLine"]["fits"], true, "the two buttons fit beside each other: {out}");
	let cut = out["oneLine"]["cut"].as_array().unwrap();
	assert!(!cut.is_empty() && cut.iter().all(|c| c == true), "the wider label(s) are cut short, whole in the tooltip: {out}");
	assert_eq!(out["id"], "lookup/carried/log", "{out}");
	assert_eq!(out["quests"], json!([9005, 9010, 9015, 9020, 9025, 9030]), "{out}");
	assert_eq!(out["manual"], true, "{out}");
	assert_eq!(out["room"]["switch"], true, "the existing Make room path reaches all finished quests: {out}");
	assert_eq!(out["carried"]["rows"], 1, "{out}");
	assert_eq!(out["carried"]["guideMe"], true, "unknown locations still allow a manual hand-in guide: {out}");
	assert_eq!(out["before"], 0, "listing quests does not start a guide: {out}");
	assert_eq!(out["starts"], 1, "the footer delegates once to the shared planner: {out}");
	assert_eq!(out["allCalls"], 2, "both the switch and carried list request every finished quest: {out}");
	assert_eq!(out["why"], "Where it is turned in is not known", "{out}");
	assert_eq!(out["shown"], false, "the window closes after the guide opens: {out}");
	assert!(!out["hint"].as_str().unwrap().contains("route ahead never hands"), "the list includes quests on routes: {out}");
}

#[test]
fn guide_me_preserves_the_planners_error_message_and_keeps_the_window_open() {
	let out = run(
		768,
		r#"local printed, failures = {}, {}
Polestar.Print = function(text) printed[#printed + 1] = text end
for _, why in ipairs({ "tabs", "combat", "nothing" }) do
	Polestar.Handins.Start = function() Polestar.Print("Planner: " .. why); return nil, why end
	measure("carried")
	F.GuideMe:Click()
	failures[#failures + 1] = F:IsShown()
end
emit({ printed = printed, shown = failures })"#,
	);
	assert_eq!(out["printed"], json!(["Planner: tabs", "Planner: combat", "Planner: nothing"]), "the UI must not replace or duplicate the planner's error: {out}");
	assert_eq!(out["shown"], json!([true, true, true]), "{out}");
}

#[test]
fn the_finished_list_has_an_empty_log_message_and_no_guide_action_when_nothing_is_ready() {
	let out = run(
		768,
		r#"Polestar.RoutePlan.Carried = function(all) assert(all == true); return {} end
local carried = measure("carried")
emit({ carried = carried, hint = F.Hint:GetText() })"#,
	);
	assert_eq!(out["carried"]["rows"], 0, "{out}");
	assert_eq!(out["carried"]["guideMe"], false, "{out}");
	assert_eq!(out["hint"], "No quests in your log are ready to hand in.", "{out}");
}

const HANDIN_MENU: &str = r#"
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
E.SetGuide(nil)
assert(not E.GetGuide() and #E.GetTabs() == 0, "the shortcut must work without a selected guide")
-- No recipient data: the real planner must still open the current-log hand-ins.
Polestar.Codex.Register("meta", {})
Polestar.RoutePlan.Ender = function() return nil end
local function handinMenuRow()
	Polestar.Widgets.HideMenu()
	GF.menuButton:Click()
	local row, count = nil, 0
	for _, r in ipairs(PolestarMenu.rows) do
		if r:IsShown() and r.psItem and r.psItem.icon == "icon-turnin" then row, count = r, count + 1 end
	end
	assert(count == 1, "the guide menu must offer exactly one hand-in action")
	assert(PolestarMenu.psOpts.short, "the grouped menu must show every action without a filter")
	return row
end
"#;

#[test]
fn the_menu_opens_all_finished_quests_without_a_guide_or_cleanup_and_reuses_its_tab() {
	let out = run(
		768,
		&format!(
			r#"{HANDIN_MENU}
local unneeded = #(Polestar.RoutePlan.Unneeded() or {{}})
local row = handinMenuRow()
local label = row.Text:GetText()
local disabled, cleanup = row.psItem.disabled or false, false
for _, r in ipairs(PolestarMenu.rows) do
	if r:IsShown() and (r.Text:GetText() or ""):find("Clean up quest log", 1, true) then cleanup = true end
end
row:Click()
local first = E.GetGuide()
local firstId, firstTabs = first and first.id or false, #E.GetTabs()
local quests, unknown = {{}}, true
for _, step in ipairs(first and first.steps or {{}}) do
	for _, goal in ipairs(step.goals or {{}}) do
		if goal.t == "turnin" then
			quests[#quests + 1] = goal.quest
			unknown = unknown and goal.map == nil and goal.currentLog == true
		end
	end
end
table.sort(quests)
handinMenuRow():Click()
emit({{ unneeded = unneeded, cleanup = cleanup, label = label, disabled = disabled, firstId = firstId,
	firstTabs = firstTabs, quests = quests, unknown = unknown,
	again = E.GetGuide() and E.GetGuide().id or false, tabs = #E.GetTabs() }})"#
		),
	);
	assert_eq!(out["unneeded"], 0, "the shortcut does not depend on cleanup suggestions: {out}");
	assert_eq!(out["cleanup"], false, "{out}");
	assert_eq!(out["label"], "Hand in finished quests (6)", "the menu counts every ready quest: {out}");
	assert_eq!(out["disabled"], false, "ready quests enable the shortcut without an active guide: {out}");
	assert_eq!(out["firstId"], "lookup/carried/log", "the click opens the shared hand-in planner: {out}");
	assert_eq!(out["firstTabs"], 1, "{out}");
	assert_eq!(out["quests"], json!([9005, 9010, 9015, 9020, 9025, 9030]), "every ready quest reaches the actual guide: {out}");
	assert_eq!(out["unknown"], true, "missing recipient locations do not block opening: {out}");
	assert_eq!(out["again"], "lookup/carried/log", "{out}");
	assert_eq!(out["tabs"], 1, "opening the shortcut again reuses its existing tab: {out}");
}

#[test]
fn the_menu_keeps_an_empty_handin_action_disabled_and_refreshes_readiness_on_open() {
	let out = run(
		768,
		&format!(
			r#"{HANDIN_MENU}
for i = 5, 30, 5 do stub.world.abandon(9000 + i) end
local starts, start = 0, Polestar.Handins.Start
Polestar.Handins.Start = function(...) starts = starts + 1; return start(...) end
local row = handinMenuRow()
local emptyLabel = row.Text:GetText()
local emptyDisabled = row.psItem.disabled or false
row:Click()
local emptyStarts, emptyTabs = starts, #E.GetTabs()
stub.world.finish(9001)
row = handinMenuRow()
local readyLabel = row.Text:GetText()
local readyDisabled = row.psItem.disabled or false
row:Click()
local readyId, readyStarts = E.GetGuide() and E.GetGuide().id or false, starts
E.SetGuide(nil)
stub.world.abandon(9001)
row = handinMenuRow()
local emptyAgain = row.psItem.disabled or false
row:Click()
emit({{ emptyLabel = emptyLabel, readyLabel = readyLabel, emptyDisabled = emptyDisabled, emptyStarts = emptyStarts, emptyTabs = emptyTabs,
	readyDisabled = readyDisabled, readyId = readyId, readyStarts = readyStarts,
	emptyAgain = emptyAgain, finalStarts = starts, finalTabs = #E.GetTabs() }})"#
		),
	);
	assert_eq!(out["emptyDisabled"], true, "unfinished quests leave the action visible but disabled: {out}");
	assert_eq!(out["emptyLabel"], "None to hand in", "{out}");
	assert_eq!(out["emptyStarts"], 0, "clicking the disabled row cannot call the planner: {out}");
	assert_eq!(out["emptyTabs"], 0, "{out}");
	assert_eq!(out["readyDisabled"], false, "reopening the menu reads the newly finished quest: {out}");
	assert_eq!(out["readyLabel"], "Hand in finished quests (1)", "{out}");
	assert_eq!(out["readyId"], "lookup/carried/log", "the enabled click still uses the real planner: {out}");
	assert_eq!(out["readyStarts"], 1, "{out}");
	assert_eq!(out["emptyAgain"], true, "reopening also reflects quests removed from the log: {out}");
	assert_eq!(out["finalStarts"], 1, "the disabled action does not start again: {out}");
	assert_eq!(out["finalTabs"], 0, "{out}");
}

#[test]
fn the_menu_includes_finished_quests_already_handed_in_later_by_an_open_guide() {
	let out = run(
		768,
		&format!(
			r#"{HANDIN_MENU}
local goals = {{}}
for i = 5, 30, 5 do goals[#goals + 1] = {{ t = "turnin", quest = 9000 + i, title = "Quest " .. i }} end
Polestar.RegisterGuide({{ id = "test/future", pack = "test", title = "Future hand-ins", minLevel = 30, maxLevel = 40,
	steps = {{ {{ goals = {{ {{ t = "goto", map = 1429, x = 70, y = 70 }} }} }}, {{ goals = goals }} }} }})
E.SetGuide("test/future"); stub.advance(0.6)
local carried = Polestar.RoutePlan.Carried()
assert(carried and #carried == 0, "the open guide already hands in all six ready quests")
local row = handinMenuRow()
local label, disabled = row.Text:GetText(), row.psItem.disabled or false
row:Click()
local guide, quests = E.GetGuide(), {{}}
for _, step in ipairs(guide and guide.steps or {{}}) do
	for _, goal in ipairs(step.goals or {{}}) do
		if goal.t == "turnin" then quests[#quests + 1] = goal.quest end
	end
end
table.sort(quests)
emit({{ label = label, disabled = disabled, id = guide and guide.id or false, quests = quests }})"#
		),
	);
	assert_eq!(out["label"], "Hand in finished quests (6)", "already planned hand-ins still count: {out}");
	assert_eq!(out["disabled"], false, "{out}");
	assert_eq!(out["id"], "lookup/carried/log", "{out}");
	assert_eq!(out["quests"], json!([9005, 9010, 9015, 9020, 9025, 9030]), "{out}");
}
