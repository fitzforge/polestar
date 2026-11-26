//! The dungeon entry offer, generated run tab and Options toggle on the real addon.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
function IsInInstance() return w.instanceKind ~= nil, w.instanceKind end
function GetInstanceInfo() return nil, nil, nil, nil, nil, nil, nil, w.instanceMap end
function UnitIsGhost(unit) return unit == "player" and w.ghost end

-- Wailing Caverns quests and IDs from tests/fixtures/codex/dungeons.json.
-- Give the Glowing Shard an inside end to exercise the journal's inside branch.
local page = [=[return { quests = {
	{ id = 1486, title = "Deviate Hides", finish = { kind = "npc", id = 5767, name = "Nalpak", map = 1413, x = 45.99, y = 35.66, f = "e" } },
	{ id = 6981, title = "The Glowing Shard", finish = { kind = "npc", id = 5768, inside = true } },
} }]=]
local loaded = stub.addonLoaded
function stub.addonLoaded(name)
	if name == "Polestar" then
		local D, C = Polestar.Dungeons, Polestar.Codex
		D.Register("meta", {})
		D.Register("dungeon", { ["wailing-caverns"] = { name = "Wailing Caverns", map = 43, minLevel = 15, kind = "dungeon" } }, { ["wailing-caverns"] = page })
		C.Load = function() return true end
		C.Quest = function(id)
			if id == 1486 then return { id = id, title = "Deviate Hides", objectives = { { type = "item", id = 6443, count = 20 } } } end
			if id == 6981 then return { id = id, title = "The Glowing Shard", ["end"] = { npc = { 5768 } } } end
		end
		C.Item = function(id)
			if id == 6443 then return { id = id, name = "Deviate Hide", sources = { { type = "drop", npc = 3636, chance = 20, instance = "wailing-caverns" } } } end
		end
		C.Npc = function(id)
			if id == 3636 then
				return { id = id, name = "Deviate Ravager", spawns = { { map = 43, x = 40, y = 40 } } }
			end
		end
	end
	return loaded(name)
end
local function hides()
	w.onQuest(1486, { { type = "item", required = 20, fulfilled = 3, text = "Deviate Hide: 3/20" } }, "Deviate Hides")
end
"#;

const HELPERS: &str = r#"
local w, P = stub.world, Polestar
local E, F = P.Engine, PolestarGuideFrame
local id = "lookup/run/wailing-caverns"
local function enter(kind, map, reload)
	w.instanceKind, w.instanceMap = kind, map
	stub.fire("PLAYER_ENTERING_WORLD", false, reload or false)
	stub.runTimers()
end
local function offer() return stub.frame("PolestarDungeonRunOffer") end
local function asked() return offer() ~= nil and offer():IsShown() end
local function active() return E.GetGuide() and E.GetGuide().id or false end
local function guide(name)
	assert(P.RegisterGuide({ id = "lookup/" .. name, pack = "lookup", title = name, steps = { { goals = { { t = "note", text = name } } } } }))
	return assert(E.OpenTab("lookup/" .. name))
end
local GF = P.UI.GuideFrame
local function endPage()
	local e = GF.parts.empty
	return { shown = e:IsShown(), title = e.Title:GetText(),
		button = e.Primary:IsShown() and e.Primary.Label:GetText() or false }
end
local function openRun()
	enter("party", 43)
	assert(asked())
	offer().Open:Click()
	assert(active() == id)
end
"#;

fn run_with(before: &str, saved: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		before: format!("{WORLD}\n{before}"),
		saved: vec![("Polestar".into(), format!("PolestarDB = {{ schema = 1, instanceHint = true }}\n{saved}"))],
		login: true,
		script: format!("{HELPERS}\n{script}"),
	})
	.remove(0)
}

#[test]
fn offer_opens_and_rebuilds_the_run_tab_with_live_quest_progress_then_restores_the_previous_tab() {
	let out = run_with(
		"hides(); w.onQuest(166, { 1 }, 'The Defias Brotherhood')",
		"",
		r#"
		guide("leveling")
		guide("another")
		E.SelectTab(1)
		enter("party", 43)
		assert(asked(), "entering with a dungeon quest should ask even with the guide hidden")
		local before = { shown = F:IsShown(), title = offer().Title:GetText() }
		offer().Open:Click()
		local g = E.GetGuide()
		assert(g and g == P.Guides.Get(id), "Open should register and activate the Codex-backed guide")
		local goal = E.GetStepView(E.GetLiveStep()).goals[1]
		local opened = { id = active(), shown = F:IsShown(), steps = #g.steps, quest = goal.quest,
			goals = #g.steps[1].goals, source = g.steps[1].goals[1].from,
			progress = goal.progress, routed = goal.map ~= nil or E.GetWaypoint() ~= nil }
		w.progress(1486, 1, 4)
		stub.advance(0.25)
		local after = E.GetStepView(E.GetLiveStep()).goals[1].progress
		w.accept(6981, {}, "The Glowing Shard")
		stub.runTimers()
		g = E.GetGuide()
		local turnin = E.GetStepView(E.GetLiveStep()).goals[2]
		local added = { count = #g.steps[1].goals, turnin = turnin.t, quest = turnin.quest }
		w.turnIn(6981)
		stub.runTimers()
		local removed = #E.GetStepView(E.GetLiveStep()).goals
		w.abandon(1486)
		stub.runTimers()
		local empty = endPage().title
		enter(nil)
		emit({ before = before, opened = opened, after = after, added = added, removed = removed, empty = empty,
			left = active(), tabs = #E.GetTabs(), closed = #E.ClosedTabs() })
	"#,
	);
	assert_eq!(out["before"], json!({ "shown": false, "title": "You've entered Wailing Caverns. Open the step tracker for your quests here?" }));
	assert_eq!(out["opened"]["id"], "lookup/run/wailing-caverns");
	assert_eq!(out["opened"]["shown"], true);
	assert_eq!(out["opened"]["steps"], 1);
	assert_eq!(out["opened"]["goals"], 1);
	assert_eq!(out["opened"]["quest"], 1486);
	assert_eq!(out["opened"]["source"], "Deviate Ravager");
	assert_eq!(out["opened"]["progress"], json!({ "kind": "count", "cur": 3, "max": 20 }));
	assert_eq!(out["opened"]["routed"], false);
	assert_eq!(out["after"], json!({ "kind": "count", "cur": 4, "max": 20 }));
	assert_eq!(out["added"], json!({ "count": 2, "turnin": "turnin", "quest": 6981 }));
	assert_eq!(out["removed"], 1);
	assert_eq!(out["empty"], "All objectives done");
	assert_eq!(out["left"], "lookup/leveling");
	assert_eq!(out["tabs"], 2);
	assert_eq!(out["closed"], 0);
}

#[test]
fn open_registers_quest_log_goals_when_the_codex_has_no_objectives() {
	let out = run_with(
		"",
		"",
		r#"
		-- Scourge of the Downs has an inside turn-in and no Codex objectives.
		local key, qid, title = "razorfen-downs", 3523, "Scourge of the Downs"
		P.Dungeons.Register("dungeon", { [key] = { name = "Razorfen Downs", map = 129, kind = "dungeon" } },
			{ [key] = [=[return { quests = { { id = 3523, title = "Scourge of the Downs",
				finish = { kind = "npc", id = 8516, name = "Belnistrasz", inside = true } } } }]=] })
		local quest = P.Codex.Quest
		P.Codex.Quest = function(q)
			if q == qid then return { id = q, title = title, objectives = {} } end
			return quest(q)
		end
		w.onQuest(qid, { 1, 1 }, title)
		local objectives = C_QuestLog.GetQuestObjectives
		C_QuestLog.GetQuestObjectives = function(q)
			if q == qid then return {
				{ text = "Razorfen Battleguard slain: 2/8", type = "monster", numFulfilled = 2, numRequired = 8 },
				{ text = "", type = "event", numFulfilled = 0, numRequired = 1 },
			} end
			return objectives(q)
		end
		enter("party", 129)
		assert(asked())
		offer().Open:Click()
		local run = P.Guides.Get("lookup/run/" .. key)
		assert(run, "Open should register the run guide: " .. tostring(P.Guides.Validate(P.Lookup.BuildGuide("run", key))))
		local goals = run.steps[1].goals
		assert(#goals == 3 and goals[3].t == "turnin")
		assert(E.GetGuide() == run and F:IsShown() and #E.GetTabs() == 1)
		emit({ goals[1].target, goals[2].target })
	"#,
	);
	assert_eq!(out, json!(["Razorfen Battleguard", "Scourge of the Downs"]));
}

#[test]
fn open_registers_legacy_codex_talk_credit_as_a_log_line() {
	let out = run_with(
		"hides()",
		"",
		r#"
		-- Simulate an older Codex with a talk objective backed by a credit marker.
		P.Codex.Quest = function(q)
			return { id = q, title = "Deviate Hides", objectives = { { type = "talk", id = 13756, text = "Speak to Nalpak" } } }
		end
		P.Codex.Npc = function(q) return { id = q, name = "PvP Graveyard Credit Marker" } end
		enter("party", 43)
		offer().Open:Click()
		local run = P.Guides.Get(id)
		assert(run, "Open should register the credit objective: " .. tostring(P.Guides.Validate(P.Lookup.BuildGuide("run", "wailing-caverns"))))
		local goal = run.steps[1].goals[1]
		assert(E.GetGuide() == run and goal.logLine and goal.npc == nil and goal.oi == 1)
		emit(goal.target)
	"#,
	);
	assert_eq!(out, "Speak to Nalpak");
}

#[test]
fn open_reports_lookup_failure_and_keeps_the_tab_limit_message() {
	let out = run_with(
		"hides()",
		"",
		r#"
		local function clickAndReadMessage()
			assert(asked())
			local before = #stub.messages
			offer().Open:Click()
			local messages = {}
			for i = before + 1, #stub.messages do messages[#messages + 1] = stub.messages[i]:gsub("^.-|r: ", "") end
			assert(active() ~= id and not asked())
			return messages
		end
		enter("party", 43)
		local load = P.Codex.Load
		P.Codex.Load = function() return false, "nodata" end
		local failed = clickAndReadMessage()
		P.Codex.Load = load
		enter(nil)
		for i = 1, 6 do guide("tab" .. i) end
		enter("party", 43)
		emit({ failure = failed, limit = clickAndReadMessage() })
	"#,
	);
	assert_eq!(out["failure"], json!(["The dungeon quest tracker could not be opened (nodata)."]));
	assert_eq!(out["limit"], json!(["Six tabs is the limit. Close one to open another."]));
}

#[test]
fn offer_waits_for_an_eligible_dungeon_and_combat_to_end_and_not_now_keeps_the_current_tab() {
	let out = run_with(
		"",
		"",
		r#"
		guide("leveling")
		P.Set("ui.instance", "show")
		enter("party", 43)
		local empty = asked()
		enter(nil)
		w.onQuest(1486, { 20 }, "Deviate Hides")
		enter("raid", 43)
		local raid = asked()
		enter("pvp", 43)
		local bg = asked()
		enter("arena", 43)
		local arena = asked()
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		enter("party", 43)
		local combat = asked()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		local shown = asked() and F:IsShown()
		assert(shown, "Keep visible also shows the offer after combat")
		offer().Later:Click()
		local unchanged = active() == "lookup/leveling" and F:IsShown() and #E.GetTabs() == 1
		w.ghost = true
		enter(nil)
		enter("party", 43)
		w.ghost = false
		stub.fire("PLAYER_UNGHOST")
		stub.runTimers()
		local corpseRun = asked()
		enter(nil)
		enter("party", nil)
		local unreadable = asked()
		w.instanceMap = 43
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.runTimers()
		emit({ empty, raid, bg, arena, combat, shown, unchanged, corpseRun, unreadable, asked() })
	"#,
	);
	assert_eq!(out, json!([false, false, false, false, false, true, true, false, false, true]));
}

#[test]
fn dont_ask_again_saves_from_either_button_and_the_options_checkbox_turns_it_back_on() {
	let out = run_with(
		"hides()",
		"",
		r#"
		P.UI.ShowOptions()
		for _, button in ipairs({ "Later", "Open" }) do
			enter("party", 43)
			assert(asked(), "should offer before opting out")
			offer().Never:SetChecked(true)
			offer()[button]:Click()
			assert(P.Get("dungeons.runOffer") == false and not asked())
			assert((active() == id) == (button == "Open"))
			enter(nil)
			enter("party", 43)
			assert(not asked())
			local O = P.UI.Options
			for _, c in ipairs(O.AllControls()) do
				if c.key == "dungeons.runOffer" then
					O.Select(c.page.key, c.tab or "")
					assert(c.kind == "toggle" and c.help)
					local widget = assert(O.view.cache[c] or O.view.extras[c])
					widget:Click()
					break
				end
			end
			assert(P.Get("dungeons.runOffer") == true)
			enter(nil)
		end
		emit(true)
	"#,
	);
	assert_eq!(out, true);
}

#[test]
fn dont_ask_again_saves_if_the_player_leaves_or_enters_combat_before_the_click() {
	let out = run_with(
		"hides()",
		"",
		r#"
		guide("leveling")
		for _, button in ipairs({ "Open", "Later" }) do
			for _, combat in ipairs({ false, true }) do
				P.Set("dungeons.runOffer", true)
				enter("party", 43)
				assert(asked())
				offer().Never:SetChecked(true)
				-- Change client state before the event that would hide the card.
				if combat then stub.inCombat = true else w.instanceKind, w.instanceMap = nil, nil end
				offer()[button]:Click()
				assert(P.Get("dungeons.runOffer") == false, "should save the opt-out after the player state changes")
				assert(active() == "lookup/leveling" and #E.GetTabs() == 1 and not asked())
				stub.inCombat = false
				enter(nil)
			end
		end
		emit(true)
	"#,
	);
	assert_eq!(out, true);
}

#[test]
fn a_reload_inside_restores_the_run_tab_and_does_not_ask_again() {
	let out = run_with(
		"hides(); w.instanceKind, w.instanceMap = 'party', 43",
		r#"PolestarCharDB = { guide = "lookup/run/wailing-caverns", tabs = { "lookup/run/wailing-caverns" }, activeTab = 1,
			dungeonRun = { map = 43, key = "wailing-caverns", asked = true } }"#,
		r#"
		enter("party", 43, true)
		local restored = active()
		local askedAgain = asked()
		enter(nil)
		emit({ restored, askedAgain, #E.GetTabs() })
	"#,
	);
	assert_eq!(out, json!(["lookup/run/wailing-caverns", false, 0]));
}

#[test]
fn a_visit_waits_for_the_journal_and_leaving_cancels_an_offer_deferred_in_combat() {
	let out = run_with(
		"hides()",
		"",
		r#"
		P.Set("dungeons.enabled", false)
		enter("party", 43)
		local disabled = asked()
		assert(P.Lookup.BuildGuide("run", "wailing-caverns") == nil)
		P.Set("dungeons.enabled", true)
		stub.runTimers()
		local enabled = asked()
		enter(nil)
		stub.inCombat = true
		enter("party", 43)
		enter(nil)
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		emit({ disabled, enabled, asked() })
	"#,
	);
	assert_eq!(out, json!([false, true, false]));
}

#[test]
fn the_live_step_and_window_show_each_held_quest_when_the_log_changes() {
	let out = run_with(
		"hides()",
		"",
		r#"
		openRun()
		assert(not P.Get("ui.wholeStep"))
		w.accept(6981, {}, "The Glowing Shard")
		stub.runTimers()
		local live = E.GetLiveStep()
		local quests, labels = {}, {}
		for _, g in ipairs(E.GetStepView(live).goals) do quests[#quests + 1] = {g.quest, g.t} end
		for _, r in ipairs(GF.SkinParts().rows) do
			if r:IsVisible() and r.psGoal and r.psGoal.quest then
				local name = r.psGoal.quest == 1486 and "Deviate Hides" or "The Glowing Shard"
				if (r.Text:GetText() .. r.Sub:GetText()):find(name, 1, true) then labels[#labels + 1] = name end
			end
		end
		local steps, shown = E.GetStepCount(), F:IsShown()
		w.turnIn(6981)
		stub.runTimers()
		local remaining = E.GetStepView(E.GetLiveStep()).goals[1]
		emit({ live = live, steps = steps, shown = shown, quests = quests, labels = labels,
			remaining = remaining.quest, progress = remaining.progress.cur })
	"#,
	);
	assert_eq!(
		out,
		json!({ "live": 1, "steps": 1, "shown": true, "quests": [[1486, "collect"], [6981, "turnin"]],
		"labels": ["Deviate Hides", "The Glowing Shard"], "remaining": 1486, "progress": 3 })
	);
}

#[test]
fn finished_objectives_open_the_hand_in_from_inside_without_completing_the_tracker() {
	let out = run_with(
		"hides()",
		"",
		r#"
		local completions = 0
		P.On("GUIDE_COMPLETED", function(gid) if gid == id then completions = completions + 1 end end)
		openRun()
		w.finish(1486)
		stub.advance(0.25)
		assert(P.Dungeons.HandinGuide("wailing-caverns"), "the completed quest has an outside hand-in")
		local page, live = endPage(), E.GetLiveStep() or false
		if page.button == "Hand in the quests" then GF.parts.empty.Primary:Click() end
		local opened, count = active(), #E.GetTabs()
		enter(nil)
		emit({ page = page, live = live, opened = opened, count = count, left = active(), tabs = #E.GetTabs(),
			completions = completions, done = P.CharState().guideDone[id] == true })
	"#,
	);
	assert_eq!(
		out,
		json!({ "page": { "shown": true, "title": "All objectives done", "button": "Hand in the quests" },
		"live": false, "opened": "lookup/handin/wailing-caverns", "count": 2, "left": "lookup/handin/wailing-caverns",
		"tabs": 1, "completions": 0, "done": false })
	);
}

#[test]
fn removing_the_last_quest_shows_the_tracker_page_without_a_hand_in_button() {
	for (before, remove) in [("hides()", "w.abandon(1486)"), ("w.onQuest(6981, {}, 'The Glowing Shard')", "w.turnIn(6981)")] {
		let out = run_with(
			before,
			"",
			&format!(
				r#"
				openRun()
				{remove}
				stub.advance(0.25)
				emit({{ page = endPage(), live = E.GetLiveStep() or false, active = active(), done = P.CharState().guideDone[id] == true }})
			"#
			),
		);
		assert_eq!(
			out,
			json!({ "page": { "shown": true, "title": "All objectives done", "button": false },
			"live": false, "active": "lookup/run/wailing-caverns", "done": false }),
			"{remove}"
		);
	}
}

#[test]
fn the_first_pickup_inside_offers_once_and_an_answered_entry_offer_does_not_repeat() {
	let out = run_with(
		"",
		"",
		r#"
		enter("party", 43)
		local empty = asked()
		local saved = P.CharState().dungeonRun or {}
		local recorded = saved.key == "wailing-caverns" and saved.map == 43
		w.accept(1486, { 20 }, "Deviate Hides")
		stub.runTimers()
		local title = asked() and offer().Title:GetText() or false
		offer().Later:Click()
		w.accept(6981, {}, "The Glowing Shard")
		stub.runTimers()
		local repeated = asked()
		enter(nil)
		enter("party", 43)
		offer().Later:Click()
		w.abandon(6981)
		w.accept(6981, {}, "The Glowing Shard")
		stub.runTimers()
		emit({ empty = empty, recorded = recorded, title = title, repeated = repeated, afterEntry = asked() })
	"#,
	);
	assert_eq!(
		out,
		json!({ "empty": false, "recorded": true, "title": "You've picked up a quest for Wailing Caverns. Open the step tracker for your quests here?",
		"repeated": false, "afterEntry": false })
	);
}

#[test]
fn a_reload_after_entering_empty_preserves_the_visit_and_still_allows_a_pickup_offer() {
	let out = run_with(
		"w.instanceKind, w.instanceMap = 'party', 43",
		r#"PolestarCharDB = { dungeonRun = { map = 43, key = "wailing-caverns", asked = false } }"#,
		r#"
		local saved = P.CharState().dungeonRun
		enter("party", 43, true)
		local atReload = asked()
		w.accept(1486, { 20 }, "Deviate Hides")
		stub.runTimers()
		emit({ same = P.CharState().dungeonRun == saved, reload = atReload,
			pickup = asked() and offer().Title:GetText() or false })
	"#,
	);
	assert_eq!(
		out,
		json!({ "same": true, "reload": false,
		"pickup": "You've picked up a quest for Wailing Caverns. Open the step tracker for your quests here?" })
	);
}

#[test]
fn a_manually_closed_tracker_can_only_be_reopened_during_its_visit() {
	let out = run_with(
		"hides()",
		"",
		r#"
		guide("leveling")
		openRun()
		local _, at = E.GetTabs()
		E.CloseTab(at)
		assert(E.ReopenClosedTab(id), "the tracker is reopenable during its visit")
		local _, at = E.GetTabs()
		E.CloseTab(at)
		local before = E.ClosedTabs()[1].guideId
		enter(nil)
		emit({ before = before, closed = #E.ClosedTabs(), reopened = E.ReopenClosedTab(id) or false, active = active() })
	"#,
	);
	assert_eq!(out, json!({ "before": "lookup/run/wailing-caverns", "closed": 0, "reopened": false, "active": "lookup/leveling" }));
}

#[test]
fn leaving_keeps_the_tab_the_player_selected_inside() {
	let out = run_with(
		"hides()",
		"",
		r#"
		local other = guide("another")
		guide("leveling")
		openRun()
		E.SelectTab(other)
		enter(nil)
		emit({ active = active(), tabs = #E.GetTabs() })
	"#,
	);
	assert_eq!(out, json!({ "active": "lookup/another", "tabs": 2 }));
}

#[test]
fn an_unanswered_offer_returns_after_death_and_waits_for_combat_to_end() {
	let out = run_with(
		"hides()",
		"",
		r#"
		enter("party", 43)
		local before = asked()
		w.ghost = true
		stub.fire("PLAYER_DEAD")
		stub.runTimers()
		local dead = asked()
		enter(nil)
		enter("party", 43)
		stub.inCombat, w.ghost = true, false
		stub.fire("PLAYER_UNGHOST")
		stub.runTimers()
		local combat = asked()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		emit({ before, dead, combat, asked() })
	"#,
	);
	assert_eq!(out, json!([true, false, false, true]));
}

#[test]
fn the_restored_tracker_reads_quests_when_the_log_becomes_available() {
	let out = run_with(
		r#"
		hides()
		w.instanceKind, w.instanceMap = "party", 43
		local onQuest, entries = C_QuestLog.IsOnQuest, C_QuestLog.GetNumQuestLogEntries
		function C_QuestLog.IsOnQuest(q) if w.logReadable then return onQuest(q) end end
		function C_QuestLog.GetNumQuestLogEntries() if w.logReadable then return entries() end end
		"#,
		r#"PolestarCharDB = { guide = "lookup/run/wailing-caverns", tabs = { "lookup/run/wailing-caverns" }, activeTab = 1,
			dungeonRun = { map = 43, key = "wailing-caverns", asked = true } }"#,
		r#"
		P.Set("ui.instance", "show")
		enter("party", 43, true)
		assert(F:IsShown(), "test the visible window as the log loads")
		local loading = { title = endPage().title, done = P.CharState().guideDone[id] == true }
		w.logReadable = true
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.25)
		local step = E.GetLiveStep()
		local goal = step and E.GetStepView(step).goals[1]
		emit({ loading = loading, active = active(), asked = asked(), empty = endPage().shown, step = step or false,
			quest = goal and goal.quest, progress = goal and goal.progress.cur })
	"#,
	);
	assert_eq!(
		out,
		json!({ "loading": { "title": "All objectives done", "done": false }, "active": "lookup/run/wailing-caverns",
		"asked": false, "empty": false, "step": 1, "quest": 1486, "progress": 3 })
	);
}
