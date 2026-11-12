//! The Guide Planner (addon/Polestar/UI/Planner.lua), end to end: the real addon (Core, Theme, Nav, UI) in the stub
//! world. The details' "Guide Planner" button puts the selected guide's timeline in the guide list's place, for a
//! guide that is open and for one that is not; the same button, a category or a search go back to the list. A step
//! is a node with its lines under it, finished steps fold, the marker says where the character stands. A quest's
//! tick hides it (Engine.SkipQuest, saved for the character): its other lines go, the quests that need it keep one
//! line that names it, a step with nothing left goes whole; the tick, or "Show all", brings it back. The strip jumps
//! to a step; a long guide gets frames only for the rows in view. What a hidden quest was worth is no longer counted
//! beside the planner (the details' levels chip and its panel) or in the guide window's pace line.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 10
"#;

// A -> B -> C with Other beside A; the boars are A's alone, so their step goes with A. "test/leveling" is the same
// route as a leveling guide: the details show what it is worth in levels.
const GUIDES: &str = r#"
local function route()
	return {
		{ title = "Start", goals = { { t = "accept", quest = 1, title = "A", qlvl = 10 }, { t = "accept", quest = 9, title = "Other", qlvl = 10 } } },
		{ title = "Boars", goals = { { t = "kill", quest = 1, title = "A", target = "Boar", npc = 113, count = 8, oi = 1 } } },
		{ title = "Second", goals = { { t = "turnin", quest = 1, title = "A" }, { t = "accept", quest = 2, title = "B", qlvl = 10, pre = { 1 } }, { t = "note", text = "A tip." } } },
		{ title = "Third", goals = { { t = "turnin", quest = 2, title = "B" }, { t = "accept", quest = 3, title = "C", qlvl = 10, pre = { 2 } } } },
		{ title = "End", goals = { { t = "turnin", quest = 3, title = "C" }, { t = "turnin", quest = 9, title = "Other" } } },
	}
end
Polestar.RegisterGuide({ id = "test/plan", pack = "test", title = "Plan", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = route() })
Polestar.RegisterGuide({ id = "test/leveling", pack = "test", title = "Leveling plan", category = "Leveling", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = route() })
Polestar.RegisterGuide({ id = "test/other", pack = "test", title = "Other guide", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Elsewhere", goals = { { t = "accept", quest = 8, title = "Unrelated", qlvl = 10 } } },
} })
local long = {}
for i = 1, 150 do long[i] = { title = "Stop " .. i, goals = { { t = "accept", quest = 1000 + i, title = "Quest " .. i, qlvl = 10 } } } end
Polestar.RegisterGuide({ id = "test/long", pack = "test", title = "Long", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = long })
"#;

const HELPERS: &str = r#"
			E, UI = Polestar.Engine, Polestar.UI
			P, PL = UI.Picker, UI.Planner
			function flush() stub.advance(0.3) end
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
			-- The model's rows, one line each.
			function rows()
				local out = {}
				for _, row in ipairs(PL.model and PL.model.rows or {}) do
					if row.kind == "step" then
						out[#out + 1] = row.view.number .. " " .. row.view.title .. " [" .. row.state .. "]"
					elseif row.kind == "goal" then
						out[#out + 1] = "  " .. plain(UI.PlainGoalText(row.goal)) .. " [" .. row.class .. "]" .. (row.toggle and " *" or "")
							.. (row.names and (" ~" .. row.names) or "")
					elseif row.kind == "fold" then
						out[#out + 1] = "fold " .. row.from .. "-" .. row.to .. " done " .. row.done
					elseif row.kind == "here" then
						out[#out + 1] = "here " .. row.number .. (row.started and " started" or " new")
					else
						out[#out + 1] = row.kind
					end
				end
				return out
			end
			-- The frames on screen: what each says, its tick and its tag.
			function painted()
				local out = {}
				for i = 1, PL.shown or 0 do
					local r = PL.pool[i]
					local row = r.psRow
					local text = row.kind == "goal" and plain(r.Text:GetText()) or plain(r.Title:GetText())
					out[#out + 1] = row.kind .. ": " .. text
						.. (r.Check:IsShown() and (r.Check:GetChecked() and " [x]" or " [ ]") or "")
						.. (r.Tag:IsShown() and (" <" .. r.Tag.Text:GetText() .. ">") or "")
				end
				return out
			end
			function frameOf(quest)
				for i = 1, PL.shown or 0 do
					local r = PL.pool[i]
					if r.psRow.kind == "goal" and r.psRow.quest == quest and r.psRow.toggle then return r end
				end
			end
			function click(f) f:GetScript("OnClick")(f); flush() end
			function state()
				local win = P.frame
				return { open = PL.IsOpen(), pane = PL.frame ~= nil and PL.frame:IsShown(), list = win.Content:IsShown(), tabs = win.TabRow:IsShown(),
					title = win.Title:GetText(), sub = plain(win.Subtitle:GetText()), button = P.details.Plan.Label:GetText() }
			end
			function open(id)
				UI.ShowPicker(); P.Select(id); flush()
				click(P.details.Plan)
			end
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::name("Polestar")],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_details_button_puts_the_guide_s_timeline_in_the_list_s_place_and_takes_it_away_again() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			UI.ShowPicker(); P.Select("test/plan"); flush()
			local before = state()
			click(P.details.Plan)
			local opened = { state = state(), rows = rows(), painted = painted(), cells = #PL.model.cells, guide = E.GetGuide().id }
			click(P.details.Plan)
			emit({ before = before, opened = opened, closed = state() })"#,
	);
	assert_eq!(out["before"]["open"], false);
	assert_eq!(out["before"]["button"], "Guide Planner");
	assert_eq!(out["before"]["list"], true);
	let opened = &out["opened"];
	assert_eq!(
		opened["state"],
		json!({ "open": true, "pane": true, "list": false, "tabs": false, "title": "Guide Planner",
			"sub": "Plan (1\u{2013}20)  \u{b7}  4 quests in your route", "button": "Back to the guides" })
	);
	assert_eq!(
		opened["rows"],
		json!([
			"here 1 new",
			"1 Start [current]",
			"  Accept \u{201c}A\u{201d} [open] *",
			"  Accept \u{201c}Other\u{201d} [open] *",
			"2 Boars [upcoming]",
			"  Kill Boar [open]",
			"3 Second [upcoming]",
			"  Turn in \u{201c}A\u{201d} [open]",
			"  Accept \u{201c}B\u{201d} [open] *",
			"4 Third [upcoming]",
			"  Turn in \u{201c}B\u{201d} [open]",
			"  Accept \u{201c}C\u{201d} [open] *",
			"5 End [upcoming]",
			"  Turn in \u{201c}C\u{201d} [open]",
			"  Turn in \u{201c}Other\u{201d} [open]",
			"end",
		]),
		"every step with a line per goal, the note left out; a quest's tick is on its accept"
	);
	assert_eq!(opened["painted"][0], "here: You start here  \u{b7}  Step 1");
	assert_eq!(opened["painted"][2], "goal: Accept \u{201c}A\u{201d} [x]");
	assert_eq!(opened["cells"], 5);
	assert_eq!(opened["guide"], "test/other", "planning a guide does not open it");
	assert_eq!(out["closed"]["open"], false);
	assert_eq!(out["closed"]["pane"], false);
	assert_eq!((out["closed"]["list"].clone(), out["closed"]["tabs"].clone()), (json!(true), json!(true)));
	assert_eq!(out["closed"]["button"], "Guide Planner");
	assert_ne!(out["closed"]["title"], "Guide Planner");
}

#[test]
fn a_quest_s_tick_hides_it_with_what_follows_and_the_route_closes_up_the_tick_or_show_all_brings_it_back() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			open("test/plan")
			click(frameOf(1))
			local hidden = { rows = rows(), painted = painted(), sub = state().sub, saved = PolestarCharDB.skippedQuests and PolestarCharDB.skippedQuests[1] or false,
				all = PL.all:IsShown(), cells = #PL.model.cells }
			click(frameOf(1))
			local back = { rows = #rows(), saved = PolestarCharDB.skippedQuests or false, all = PL.all:IsShown() }
			click(frameOf(1)); click(frameOf(9))
			local two = PL.model.counts.hidden
			click(PL.all)
			emit({ hidden = hidden, back = back, two = two, shown = { hidden = PL.model.counts.hidden, rows = #rows(), saved = PolestarCharDB.skippedQuests or false } })"#,
	);
	let hidden = &out["hidden"];
	assert_eq!(
		hidden["rows"],
		json!([
			"here 1 new",
			"1 Start [current]",
			"  Accept \u{201c}A\u{201d} [hidden] *",
			"  Accept \u{201c}Other\u{201d} [open] *",
			"3 Second [removed]",
			"  Accept \u{201c}B\u{201d} [out]",
			"4 Third [removed]",
			"  Accept \u{201c}C\u{201d} [out]",
			"5 End [upcoming]",
			"  Turn in \u{201c}Other\u{201d} [open]",
			"end",
		]),
		"A keeps its line and its tick; the boars' step goes; B and C keep one line each; Other stays"
	);
	assert_eq!(hidden["painted"][2], "goal: Accept \u{201c}A\u{201d} [ ] <Hidden>");
	assert_eq!(hidden["painted"][5], "goal: Accept \u{201c}B\u{201d} <Needs \u{201c}A\u{201d}>");
	assert_eq!(hidden["sub"], "Plan (1\u{2013}20)  \u{b7}  1 quest in your route  \u{b7}  1 hidden  \u{b7}  2 left out with them");
	assert_eq!(hidden["saved"], true);
	assert_eq!(hidden["all"], true);
	assert_eq!(hidden["cells"], 4);
	assert_eq!(out["back"], json!({ "rows": 16, "saved": false, "all": false }));
	assert_eq!(out["two"], 2);
	assert_eq!(out["shown"], json!({ "hidden": 0, "rows": 16, "saved": false }));
}

#[test]
fn an_open_guide_folds_its_finished_steps_marks_the_live_one_and_the_strip_jumps() {
	let out = run(
		"stub.world.complete({ 1, 9 })",
		r#"
			E.SetGuide("test/plan"); flush()
			open("test/plan")
			local folded = rows()
			local first = PL.pool[1]
			local top = { kind = first.psRow.kind, text = plain(first.Title:GetText()), side = first.Side:GetText() }
			click(first)
			local unfolded = rows()
			emit({ folded = folded, top = top, unfolded = unfolded, live = E.GetStepIndex() })"#,
	);
	assert_eq!(out["live"], 3);
	assert_eq!(
		out["folded"],
		json!([
			"fold 1-2 done 2",
			"here 3 started",
			"3 Second [current]",
			"  Turn in \u{201c}A\u{201d} [done]",
			"  Accept \u{201c}B\u{201d} [open] *",
			"4 Third [upcoming]",
			"  Turn in \u{201c}B\u{201d} [open]",
			"  Accept \u{201c}C\u{201d} [open] *",
			"5 End [upcoming]",
			"  Turn in \u{201c}C\u{201d} [open]",
			"  Turn in \u{201c}Other\u{201d} [done]",
			"end",
		])
	);
	assert_eq!(out["top"], json!({ "kind": "fold", "text": "Steps 1\u{2013}2   2 done", "side": "Show" }));
	let unfolded: Vec<&str> = out["unfolded"].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	assert_eq!(unfolded[..4], ["1 Start [past]", "  Accept \u{201c}A\u{201d} [done]", "  Accept \u{201c}Other\u{201d} [done]", "2 Boars [past]"]);
}

#[test]
fn a_quest_already_taken_has_its_tick_on_its_next_line_which_names_it_and_hiding_it_there_takes_the_rest() {
	let out = run(
		"stub.world.complete({ 9 }); stub.world.onQuest(1, {}, \"A\")",
		r#"
			E.SetGuide("test/plan"); flush()
			open("test/plan")
			local taken, live = rows(), E.GetStepIndex()
			local line
			for i = 1, PL.shown do if PL.pool[i].psRow.names then line = plain(PL.pool[i].Text:GetText()) end end
			click(frameOf(1))
			emit({ live = live, taken = taken, line = line, hidden = rows(), saved = PolestarCharDB.skippedQuests[1] })"#,
	);
	assert_eq!(out["live"], 2);
	assert_eq!(out["saved"], true);
	let taken: Vec<&str> = out["taken"].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	assert_eq!(
		taken[..6],
		["1 Start [past]", "  Accept \u{201c}A\u{201d} [done]", "  Accept \u{201c}Other\u{201d} [done]", "here 2 started", "2 Boars [current]", "  Kill Boar [open] * ~A"],
		"the accept is behind: the tick is on the boars"
	);
	assert!(out["line"].as_str().unwrap().ends_with("\u{201c}A\u{201d}"), "{}", out["line"]);
	// Hidden, A leaves nothing for this character in the guide: every step is behind, and A's one line is its accept.
	let hidden: Vec<&str> = out["hidden"].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	assert!(hidden.contains(&"  Accept \u{201c}A\u{201d} [hidden] *"), "{hidden:?}");
	assert!(hidden.contains(&"  Accept \u{201c}B\u{201d} [out]"), "{hidden:?}");
	assert!(!hidden.iter().any(|l| l.starts_with("  Turn in \u{201c}A\u{201d}") || l.starts_with("  Kill Boar")), "{hidden:?}");
}

#[test]
fn with_the_codex_the_summary_says_what_the_quests_left_out_are_worth_in_levels() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			-- A Codex that knows every quest: level 10, 1900 XP.
			local Cx = Polestar.Codex
			Cx.IsLoaded = function() return true end
			Cx.Quest = function(q) return { id = q, level = 10, xp = 1900 } end
			open("test/plan")
			local whole = state().sub
			click(frameOf(1))
			emit({ whole = whole, hidden = state().sub, lost = PL.LevelsOut(Polestar.Guides.Get("test/plan"), PL.model), need = Polestar.Levels.Player().xpMax })"#,
	);
	assert_eq!(out["whole"], "Plan (1\u{2013}20)  \u{b7}  4 quests in your route", "nothing left out, nothing to say");
	// A, B and C go: three turn-ins of 1900 XP. The stub's character needs 400 XP at level 10, then level 11's
	// 8800: all four turn-ins come to level 11 and 7200 of it, Other alone to 11 and 1500.
	let (lost, need) = (out["lost"].as_f64().unwrap(), out["need"].as_f64().unwrap());
	assert_eq!(need, 400.0);
	assert!((lost - (7200.0 - 1500.0) / 8800.0).abs() < 0.001, "{lost}");
	assert_eq!(out["hidden"], format!("Plan (1\u{2013}20)  \u{b7}  1 quest in your route  \u{b7}  1 hidden  \u{b7}  2 left out with them  \u{b7}  about {lost:.1} levels less quest XP"));
}

// The trackers follow the planner: Levels.ForGuide leaves out a hidden quest and what goes with it (levels.rs has
// the sums), and a tick draws the details and the guide window's pace line again.
#[test]
fn the_levels_chip_beside_the_planner_and_the_guide_window_s_pace_line_stop_counting_a_hidden_quest_and_count_it_again() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/leveling"); flush()
			-- A Codex that knows every quest (level 10, 1900 XP) and every mob (level 10).
			local Cx = Polestar.Codex
			Cx.IsLoaded = function() return true end
			Cx.Quest = function(q) return { id = q, level = 10, xp = 1900 } end
			Cx.Npc = function(id) return { id = id, level = 10 } end
			Polestar.Levels.Invalidate()
			open("test/leveling")
			local d, LT, GF = P.details, UI.LevelTip, UI.GuideFrame
			local function read()
				local chip = d.XP:IsShown() and d.XP.Text:GetText() or false
				local note = false
				if chip then
					d.XP:GetScript("OnEnter")(d.XP)
					note = LT.Frame().Notes:GetText():match("[^\n]*left out of your route[^\n]*") or false
					d.XP:GetScript("OnLeave")(d.XP)
				end
				return { chip = chip, note = note, pace = plain(GF.PaceText() or ""), row = GF.xp and GF.xp:IsShown() and plain(GF.xp.Text:GetText()) or false }
			end
			local whole = read()
			click(frameOf(9))
			local other = read()
			local pane = state().pane
			click(frameOf(1))
			local all = read()
			click(PL.all)
			emit({ whole = whole, other = other, pane = pane, all = all, back = read(), need = Polestar.Levels.Player().xpMax })"#,
	);
	// The stub's character needs 400 XP at level 10, then level 11's 8800. Eight boars (five at 95 XP reach 11, three
	// more at 86) and four turn-ins of 1900 leave them 7933 into 11: 1.9 levels, 8.1 short of the guide's 20.
	assert_eq!(out["need"], 400);
	let behind = |by: &str| format!("Behind by {by} levels for level 20 by step 5, and no grind step ahead");
	assert_eq!(out["whole"]["chip"], "+1.9 levels");
	assert_eq!(out["whole"]["note"], false, "nothing left out, nothing to say");
	assert_eq!(out["whole"]["pace"], behind("8.1"));
	// Other hidden: 1900 less, 6033 into 11.
	assert_eq!(out["other"]["chip"], "+1.7 levels", "the chip beside the planner follows the tick");
	assert_eq!(out["other"]["note"], "1 quest you left out of your route is not counted.");
	assert_eq!(out["other"]["pace"], behind("8.3"));
	assert_eq!(out["other"]["row"], behind("8.3"), "the guide window's line is drawn again, with no XP gained in between");
	assert_eq!(out["pane"], true, "the planner stays open as the details draw again");
	// A too, and B and C with it: nothing left to gain, so no chip and no pace to keep.
	assert_eq!(out["all"], json!({ "chip": false, "note": false, "pace": "", "row": false }));
	assert_eq!(out["back"]["chip"], "+1.9 levels", "Show all: counted again");
	assert_eq!(out["back"]["note"], false);
	assert_eq!(out["back"]["row"], behind("8.1"));
}

// forge-judge's engine parity run (rust/tests/golden/engine) loads the addon from a file list of its own, written
// before the planner: the guide menu without UI/Planner.lua. A skip there must still go through.
#[test]
fn a_skip_goes_through_where_the_guide_menu_is_loaded_without_the_planner() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/plan"); flush()
			UI.Planner = nil
			local ok, err = pcall(E.Skip)
			flush()
			local quest, why = pcall(E.SkipQuest, 9, true)
			emit({ ok = ok, err = ok and "" or tostring(err), quest = quest, why = quest and "" or tostring(why),
				step = E.GetStepView(1).skipped and true or false, hidden = E.IsQuestSkipped(9) })"#,
	);
	assert_eq!(out["err"], "");
	assert_eq!(out["why"], "");
	assert_eq!(json!([out["ok"], out["quest"], out["step"], out["hidden"]]), json!([true, true, true, true]), "the step and the quest are skipped");
}

#[test]
fn the_planner_draws_in_every_look_and_a_new_look_paints_the_open_pane_again() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			open("test/plan")
			click(frameOf(1))
			local looks = {}
			for _, skin in ipairs({ "polestar", "hearth", "forever", "blizzard", "classic", "halo" }) do
				Polestar.Set("ui.skin", skin); flush()
				looks[#looks + 1] = { skin = skin, pane = PL.frame:IsShown(), shown = PL.shown, first = painted()[1], hidden = painted()[3] }
			end
			emit({ looks = looks })"#,
	);
	for look in out["looks"].as_array().unwrap() {
		assert_eq!(look["pane"], true, "{look}");
		assert_eq!(look["shown"], 11, "{look}");
		assert_eq!(look["first"], "here: You start here  \u{b7}  Step 1", "{look}");
		assert_eq!(look["hidden"], "goal: Accept \u{201c}A\u{201d} [ ] <Hidden>", "{look}");
	}
}

#[test]
fn a_category_a_search_another_section_or_closing_the_menu_go_back_to_the_list() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			local got = {}
			open("test/plan"); P.SetCategory("Leveling"); flush(); got.category = state()
			open("test/plan"); P.SetQuery("plan"); flush(); got.search = state()
			P.SetQuery(""); flush()
			open("test/plan"); P.frame:Hide(); flush(); UI.ShowPicker(); flush(); got.reopened = state()
			open("test/plan"); P.Select(nil); flush(); got.unselected = state()
			emit(got)"#,
	);
	for how in ["category", "search", "reopened", "unselected"] {
		let s = &out[how];
		assert_eq!((s["open"].clone(), s["pane"].clone(), s["list"].clone()), (json!(false), json!(false), json!(true)), "{how}: {s}");
	}
}

#[test]
fn a_long_guide_gets_frames_only_for_the_rows_in_view_and_the_strip_jumps_to_a_step() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			open("test/long")
			local at = { rows = #PL.model.rows, frames = #PL.pool, shown = PL.shown, first = painted()[1], cells = #PL.model.cells, height = PL.model.height }
			local cell = PL.cells[120]
			click(cell)
			local jumped = { frames = #PL.pool, scroll = PL.scroll:GetVerticalScroll() > 0, first = painted()[1], tip = cell.psTip }
			emit({ at = at, jumped = jumped })"#,
	);
	assert_eq!(out["at"]["rows"], 302, "the marker, 150 steps of a node and a line, the end");
	assert_eq!(out["at"]["cells"], 150);
	assert!(out["at"]["frames"].as_i64().unwrap() < 40, "{}", out["at"]);
	assert_eq!(out["at"]["first"], "here: You start here  \u{b7}  Step 1");
	assert!(out["jumped"]["frames"].as_i64().unwrap() < 40, "{}", out["jumped"]);
	assert_eq!(out["jumped"]["scroll"], true);
	assert_eq!(out["jumped"]["first"], "step: Stop 120");
	assert_eq!(out["jumped"]["tip"], "Step 120  \u{b7}  Stop 120");
}
