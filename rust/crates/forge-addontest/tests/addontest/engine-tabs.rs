//! Guide tabs (Engine "Tabs"): several guides open at once, each with its own step state, persisted per
//! character. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
"#;

// A leveling guide (suggested for a level-1 Human), a warrior class guide, a profession guide, and filler
// guides for the cap.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/lvl", pack = "test", title = "Northshire", faction = "Alliance", minLevel = 1, maxLevel = 6, next = "test/lvl2", steps = {
	{ goals = { { t = "accept", quest = 783, title = "A Threat Within", map = 1429, x = 48, y = 42 } } },
	{ goals = { { t = "turnin", quest = 783, title = "A Threat Within", map = 1429, x = 49, y = 41 } } },
} })
Polestar.RegisterGuide({ id = "test/lvl2", pack = "test", title = "Elwynn", faction = "Alliance", minLevel = 6, maxLevel = 10, steps = {
	{ goals = { { t = "level", level = 10 } } },
} })
Polestar.RegisterGuide({ id = "test/warrior", pack = "test", title = "Warrior skills", category = "Class", minLevel = 1, maxLevel = 10, steps = {
	{ goals = { { t = "accept", quest = 1684, title = "Elanaria", map = 1429, x = 60, y = 60 } } },
	{ goals = { { t = "turnin", quest = 1684, title = "Elanaria" } } },
} })
Polestar.RegisterGuide({ id = "test/cook", pack = "test", title = "Cooking", category = "Professions", minLevel = 1, maxLevel = 60, next = "test/cook2", steps = {
	{ goals = { { t = "buy", item = 159, itemName = "Spring Water", count = 2 } } },
} })
Polestar.RegisterGuide({ id = "test/cook2", pack = "test", title = "Cooking 2", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "level", level = 50 } } },
} })
for i = 1, 6 do
	Polestar.RegisterGuide({ id = "test/f" .. i, pack = "test", title = "Filler " .. i, category = "Exploration", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "level", level = 60 } } },
	} })
end
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
LOG = {}
for _, m in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "WAYPOINT_CHANGED", "GUIDE_COMPLETED", "TABS_CHANGED" }) do
	Polestar.On(m, function(a, b)
		local v = a
		if m == "WAYPOINT_CHANGED" then v = a and (a.stepIndex .. ":" .. a.goalIndex) or "nil" end
		if m == "TABS_CHANGED" then
			local ids = {}
			for i, t in ipairs(a) do ids[i] = t.guideId end
			v = table.concat(ids, ",") .. "@" .. b
		end
		LOG[#LOG + 1] = m .. " " .. tostring(v)
	end)
end
function takeLog() local l = LOG; LOG = {}; return l end
function ids()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { tabs = out, active = active }
end
"#;

fn run(before: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn open_select_move_and_close_tabs_the_active_tab_and_its_guide_persist() {
	let out = run(
		"",
		None,
		r#"
			local r = {}
			r.login = ids()
			r.openWarrior = E.OpenTab("test/warrior")
			r.afterOpen = ids()
			r.openBackground = E.OpenTab("test/cook", false)
			r.afterBackground = ids()
			r.reopen = E.OpenTab("test/lvl")
			r.afterReopen = ids()
			r.guide = E.GetGuide().id
			E.MoveTab(1, 3)
			r.afterMove = ids()
			E.SelectTab(2)
			E.CloseTab(2)
			r.afterCloseActive = { ids(), E.GetGuide().id }
			E.CloseTab(1)
			r.afterCloseOther = ids()
			r.saved = { tabs = PolestarCharDB.tabs, activeTab = PolestarCharDB.activeTab, guide = PolestarCharDB.guide }
			emit(r)
		"#,
	);
	assert_eq!(out["login"], json!({ "tabs": ["test/lvl"], "active": 1 }));
	assert_eq!(out["openWarrior"], 2);
	assert_eq!(out["afterOpen"], json!({ "tabs": ["test/lvl", "test/warrior"], "active": 2 }));
	assert_eq!(out["openBackground"], 3);
	assert_eq!(out["afterBackground"], json!({ "tabs": ["test/lvl", "test/warrior", "test/cook"], "active": 2 }));
	assert_eq!(out["reopen"], 1);
	assert_eq!(out["afterReopen"], json!({ "tabs": ["test/lvl", "test/warrior", "test/cook"], "active": 1 }));
	assert_eq!(out["guide"], "test/lvl");
	assert_eq!(out["afterMove"], json!({ "tabs": ["test/warrior", "test/cook", "test/lvl"], "active": 3 }));
	// Closing the active tab 2 (cook) activates its right neighbour.
	assert_eq!(out["afterCloseActive"], json!([{ "tabs": ["test/warrior", "test/lvl"], "active": 2 }, "test/lvl"]));
	assert_eq!(out["afterCloseOther"], json!({ "tabs": ["test/lvl"], "active": 1 }));
	assert_eq!(out["saved"], json!({ "tabs": ["test/lvl"], "activeTab": 1, "guide": "test/lvl" }));
}

#[test]
fn saved_tabs_reopen_at_login_with_their_own_step_state_a_guide_not_registered_stays_saved_after_the_open_tabs() {
	let out = run(
		"stub.world.onQuest(783, {})",
		Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/warrior", "gone", "test/lvl" }, activeTab = 3, guide = "test/lvl" }"#),
		r#"
			local list, active = E.GetTabs(true)
			emit({ ids = ids(), guide = E.GetGuide().id, step = E.GetStepIndex(),
				tabs = { { list[1].guideId, list[1].stepIndex, list[1].done, list[1].total, list[1].complete },
					{ list[2].guideId, list[2].stepIndex, list[2].done, list[2].total, list[2].complete } },
				saved = PolestarCharDB.tabs })
		"#,
	);
	assert_eq!(
		out,
		json!({
			"ids": { "tabs": ["test/warrior", "test/lvl"], "active": 2 },
			"guide": "test/lvl",
			"step": 2,
			"tabs": [["test/warrior", 1, 0, 2, false], ["test/lvl", 2, 1, 2, false]],
			"saved": ["test/warrior", "test/lvl", "gone"],
		})
	);
}

#[test]
fn switching_tabs_fires_the_guide_step_and_waypoint_messages_the_waypoint_follows_the_active_tab() {
	let out = run(
		"",
		None,
		r#"
			E.OpenTab("test/warrior", false)
			takeLog()
			local wp1 = E.GetWaypoint()
			E.SelectTab(2)
			local switched = takeLog()
			local wp2 = E.GetWaypoint()
			-- Progress in the background tab moves no waypoint.
			stub.world.accept(783, {}); flush()
			local background = takeLog()
			E.SelectTab(1)
			emit({ wp1 = wp1.x, switched = switched, wp2 = wp2.x, background = background, back = takeLog(), wp = E.GetWaypoint().stepIndex })
		"#,
	);
	assert_eq!(out["wp1"], 48);
	assert_eq!(out["switched"], json!(["GUIDE_CHANGED test/warrior", "STEP_CHANGED 1", "WAYPOINT_CHANGED 1:1", "TABS_CHANGED test/lvl,test/warrior@2"]));
	assert_eq!(out["wp2"], 60);
	assert_eq!(out["background"], json!(["TABS_CHANGED test/lvl,test/warrior@2"]));
	assert_eq!(out["back"], json!(["GUIDE_CHANGED test/lvl", "STEP_CHANGED 2", "WAYPOINT_CHANGED 2:1", "TABS_CHANGED test/lvl,test/warrior@1"]));
	assert_eq!(out["wp"], 2);
}

#[test]
fn automation_accepts_a_background_tab_s_quest_while_another_tab_is_active() {
	let out = run(
		"",
		None,
		r#"
			E.OpenTab("test/warrior", false)
			local w = stub.world
			w.questDetail(913, 1684)  -- warrior tab (inactive) wants it
			w.questDetail(914, 9999); w.close()
			local list = E.GetTabs()
			flush()
			list = E.GetTabs()
			emit({ accepted = w.log[1684] ~= nil, other = w.log[9999] == nil, active = E.GetGuide().id,
				lvlStep = E.GetStepIndex(), warriorStep = list[2].stepIndex })
		"#,
	);
	assert_eq!(out, json!({ "accepted": true, "other": true, "active": "test/lvl", "lvlStep": 1, "warriorStep": 2 }));
}

#[test]
fn autonextguide_replaces_a_finished_guide_within_its_own_tab() {
	let out = run(
		"",
		None,
		r#"
			E.OpenTab("test/cook", false)
			takeLog()
			stub.world.addItem(159, 2); flush()
			emit({ ids = ids(), active = E.GetGuide().id, log = takeLog(), saved = PolestarCharDB.tabs })
		"#,
	);
	assert_eq!(
		out,
		json!({
			"ids": { "tabs": ["test/lvl", "test/cook2"], "active": 1 },
			"active": "test/lvl",
			"log": ["GUIDE_COMPLETED test/cook", "TABS_CHANGED test/lvl,test/cook2@1"],
			"saved": ["test/lvl", "test/cook2"],
		})
	);
}

#[test]
fn nil_savedvariables_reopen_one_suggested_tab() {
	let out = run("", Some("PolestarDB = nil; PolestarCharDB = nil"), "emit({ ids = ids(), saved = PolestarCharDB.tabs, log = takeLog() })");
	assert_eq!(out["ids"], json!({ "tabs": ["test/lvl"], "active": 1 }));
	assert_eq!(out["saved"], json!(["test/lvl"]));
}

#[test]
fn at_most_six_tabs_setguide_replaces_the_active_tab_and_never_duplicates_one() {
	let out = run(
		"",
		None,
		r#"
			local opened = {}
			for i = 1, 6 do opened[i] = E.OpenTab("test/f" .. i) or false end
			local full = ids()
			E.SelectTab(2)
			E.SetGuide("test/warrior")
			local replaced = ids()
			E.SetGuide("test/f4")
			local selected = ids()
			emit({ opened = opened, full = full, replaced = replaced, selected = selected })
		"#,
	);
	assert_eq!(out["opened"], json!([2, 3, 4, 5, 6, false]));
	assert_eq!(out["full"], json!({ "tabs": ["test/lvl", "test/f1", "test/f2", "test/f3", "test/f4", "test/f5"], "active": 6 }));
	assert_eq!(out["replaced"], json!({ "tabs": ["test/lvl", "test/warrior", "test/f2", "test/f3", "test/f4", "test/f5"], "active": 2 }));
	assert_eq!(out["selected"], json!({ "tabs": ["test/lvl", "test/warrior", "test/f2", "test/f3", "test/f4", "test/f5"], "active": 5 }));
}

#[test]
fn slash_commands_list_switch_and_close_tabs_guide_state_for_the_picker() {
	let out = run(
		"",
		None,
		r#"
			E.OpenTab("test/warrior", false)
			stub.messages = {}
			SlashCmdList.POLESTAR("tabs")
			local listed = stub.messages
			SlashCmdList.POLESTAR("tab 2")
			local switched = E.GetGuide().id
			SlashCmdList.POLESTAR("close")
			local states = { E.GetGuideState("test/lvl"), E.GetGuideState("test/warrior"), E.GetGuideState("test/cook") }
			emit({ listed = listed, switched = switched, after = ids(), states = states })
		"#,
	);
	assert_eq!(out["listed"], json!(["|cff4fd1c5Polestar|r: Open guides:", "|cff4fd1c5>|r 1. Northshire  |cff8a8f98step 1 of 2|r", "  2. Warrior skills  |cff8a8f98step 1 of 2|r",]));
	assert_eq!(out["switched"], "test/warrior");
	assert_eq!(out["after"], json!({ "tabs": ["test/lvl"], "active": 1 }));
	assert_eq!(out["states"], json!(["started", "started", "new"]));
}

// The class quest heads-up (UI/ClassToast.lua) opens a Class guide in a tab of its own; once its quests
// are handed in there, the leveling tab's step for the same quests counts done from the quest log.
#[test]
fn a_class_chain_finished_in_its_own_tab_passes_the_leveling_route_s_class_step() {
	let out = run(
		"",
		None,
		r#"
			Polestar.RegisterGuide({ id = "test/lvl-class", pack = "test", title = "Elwynn with Elanaria", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
				{ goals = { { t = "accept", quest = 783, title = "A Threat Within", map = 1429, x = 48, y = 42 } } },
				{ goals = { { t = "accept", quest = 1684, title = "Elanaria", map = 1429, x = 60, y = 60 } } },
				{ goals = { { t = "turnin", quest = 1684, title = "Elanaria", map = 1429, x = 60, y = 60 } } },
				{ goals = { { t = "turnin", quest = 783, title = "A Threat Within", map = 1429, x = 49, y = 41 } } },
			} })
			E.SetGuide("test/lvl-class")
			local w = stub.world
			w.questDetail(913, 783); flush()
			local before = E.GetStepIndex()
			E.OpenTab("test/warrior")
			w.questDetail(914, 1684); flush()
			w.turnIn(1684); flush()
			local warrior = E.GetStepIndex()
			E.SelectTab(1); flush()
			emit({ before = before, warrior = warrior or "done", leveling = E.GetStepIndex(), guide = E.GetGuide().id })
		"#,
	);
	// The leveling tab stood at the class accept (2); the class tab finished (no step left), and the
	// leveling tab's accept and turn-in of the same quest count done: it is on 4.
	assert_eq!(out, json!({ "before": 2, "warrior": "done", "leveling": 4, "guide": "test/lvl-class" }));
}

// #1328: 0.3.5 kept forever/horde/05-stonetalon-mountains for Ashenvale & Silverpine Forest and moved Sun Rock
// Retreat's quests to The Barrens & Stonetalon Mountains. A 0.3.4 character in the middle of Sun Rock found its
// tab holding the other zone. A saved tab whose guide an update reworked (fewer than half its steps kept) moves,
// once the quest log is in, to the leveling guide that has the most quests of the log to work on, and the chat
// says so. The same steps, its own guide holding the log's quests, or the other guide open already: it stays.
const REWORKED: &str = r#"
local function hand(id) return { goals = { { t = "turnin", quest = id, title = "Quest " .. id, map = 1429, x = 50, y = 50 } } } end
Polestar.RegisterGuide({ id = "test/zone05", pack = "test", title = "Ashenvale & Silverpine Forest", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "accept", quest = 216, title = "Quest 216", map = 1429, x = 40, y = 40 } } }, hand(216), hand(6462),
} })
Polestar.RegisterGuide({ id = "test/zone04", pack = "test", title = "The Barrens & Stonetalon Mountains", minLevel = 1, maxLevel = 60, steps = {
	hand(1087), hand(6282), hand(6393),
} })
"#;

fn run_reworked(log: &[u32], saved: &str) -> Value {
	let quests: String = log.iter().map(|q| format!("stub.world.onQuest({q}, {{ 1 }})\n")).collect();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{quests}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved.to_string())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDES,
			REWORKED,
			HELPERS,
			"stub.login(); flush()",
			r#"local at = ids()
			stub.fire("QUEST_LOG_UPDATE"); flush()
			local said = {}
			for _, m in ipairs(stub.messages) do if m:find("changed in this update", 1, true) then said[#said + 1] = m:gsub("^.-|r: ", "") end end
			emit({ login = at.tabs, tabs = ids().tabs, active = ids().active, saved = PolestarCharDB.tabs, said = table.concat(said, "\n"), keys = PolestarCharDB.stepKeys["test/zone05"] })"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

fn saved_tabs(tabs: &str, keys: &str) -> String {
	format!(r#"PolestarCharDB = {{ schema = 1, tabs = {{ {tabs} }}, activeTab = 1, shapes = {{ ["test/zone05"] = "4-1" }}, stepKeys = {{ ["test/zone05"] = {keys} }} }}"#)
}

#[test]
fn a_tab_whose_guide_an_update_reworked_follows_the_quests_in_the_log_to_their_guide() {
	let log = [1087, 6282, 216];
	let moved = run_reworked(&log, &saved_tabs(r#""test/zone05""#, "{ 1, 2, 3, 4 }"));
	assert_eq!(moved["login"], json!(["test/zone05"]), "at login the log is not in yet: the tab waits");
	assert_eq!(json!([moved["tabs"], moved["active"], moved["saved"]]), json!([["test/zone04"], 1, ["test/zone04"]]));
	assert_eq!(
		moved["said"],
		"Ashenvale & Silverpine Forest changed in this update and holds other quests now. Its tab moved to The Barrens & Stonetalon Mountains, which has the quests in your log."
	);

	// The same steps under a new shape (an edit, not a rework): the tab stays.
	let keys = moved["keys"].as_array().unwrap().iter().map(|k| k.to_string()).collect::<Vec<_>>().join(", ");
	let edited = run_reworked(&log, &saved_tabs(r#""test/zone05""#, &format!("{{ {keys} }}")));
	assert_eq!(json!([edited["tabs"], edited["said"]]), json!([["test/zone05"], ""]), "an edit keeps the tab");

	// Reworked, but its own guide has as many of the log's quests: it stays.
	let own = run_reworked(&[216, 6462, 1087], &saved_tabs(r#""test/zone05""#, "{ 1, 2, 3, 4 }"));
	assert_eq!(json!([own["tabs"], own["said"]]), json!([["test/zone05"], ""]), "its own quests keep the tab");

	// Reworked, and the guide with the log's quests is open in another tab already: no duplicate.
	let open = run_reworked(&log, &saved_tabs(r#""test/zone05", "test/zone04""#, "{ 1, 2, 3, 4 }"));
	assert_eq!(json!([open["tabs"], open["said"]]), json!([["test/zone05", "test/zone04"], ""]), "never a second tab of a guide");
}

// The fresh-start sweep (0.3.6): a /reload with no update moved an Alliance 35 tab from
// Stranglethorn Vale to Arathi Highlands ("changed in this update"). The saved shape and step keys are the
// guide as planned for the character (feeders in, quests waiting on earlier guides left out: other step keys),
// so against the guide as registered they read reworked. A save stamped with the pack's own version saw no
// update: the tab stays, whatever its keys.
#[test]
fn a_reload_with_no_update_never_moves_a_tab_however_its_planned_steps_differ() {
	let saved = saved_tabs(r#""test/zone05""#, "{ 1, 2, 3, 4 }").replace("activeTab = 1,", r#"activeTab = 1, shapeVersions = { ["test/zone05"] = "1" },"#);
	let out = run_reworked(&[1087, 6282, 216], &saved);
	assert_eq!(json!([out["tabs"], out["said"]]), json!([["test/zone05"], ""]), "{out}");
}

// #3440 tabs: a save's steps as planned for the character (Own.feederPlan's left-out quests taken out of them)
// against the guide as released, and an update that reworked a guide for real.
fn run_update(guides: &str, log: &str, saved: &str, legacy: &str) -> Value {
	let legacy = format!("Polestar.LegacyStepsLoad = function() return {legacy} end");
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{log}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved.to_string())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDES,
			guides,
			HELPERS,
			legacy.as_str(),
			"stub.login(); flush()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
			local said = {}
			for _, m in ipairs(stub.messages) do if m:find("changed in this update", 1, true) then said[#said + 1] = m:gsub("^.-|r: ", "") end end
			emit({ tabs = ids().tabs, said = table.concat(said, "\n"), live = E.GetLiveStep() or false })"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

const H: &str = r#"local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end"#;

// 0.4.1.1 -> 0.4.2, Horde Winterspring: the save had 15 of the guide's 22 steps, 5 of them with quests left out
// for the character, so only 10 matched the guide as released and the tab "reworked" moved to the Plaguelands'
// first step. Here three of four steps lost 400's goals in the save: the guide is the same, and the tab stays.
#[test]
fn a_save_s_steps_planned_without_a_quest_are_the_guide_s_own_and_never_read_as_reworked() {
	let guides = r#"
local function g(t, q, extra) local x = { t = t, quest = q, title = "Quest " .. q, map = 1429, x = 50, y = 50 } for k, v in pairs(extra or {}) do x[k] = v end return x end
Polestar.RegisterGuide({ id = "test/plan", pack = "test", title = "Ashenvale", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { g("accept", 216), g("accept", 400) } },
	{ goals = { g("kill", 216, { target = "Wolf", npc = 299, count = 5, oi = 1 }), g("kill", 400, { target = "Bear", npc = 298, count = 5, oi = 1 }) } },
	{ goals = { g("turnin", 216), g("turnin", 400) } },
	{ goals = { g("turnin", 6462) } },
} })
Polestar.RegisterGuide({ id = "test/zone04", pack = "test", title = "The Barrens & Stonetalon Mountains", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { g("turnin", 1087) } }, { goals = { g("turnin", 6282) } }, { goals = { g("turnin", 6393) } },
} })"#;
	let saved = format!(
		r#"{H}
PolestarCharDB = {{ schema = 1, tabs = {{ "test/plan" }}, activeTab = 1, shapes = {{ ["test/plan"] = "4-1" }},
	stepKeys = {{ ["test/plan"] = {{ h("accept:216"), h("kill:216"), h("turnin:216"), h("turnin:6462") }} }} }}"#
	);
	let log = "stub.world.onQuest(1087, { 1 })\nstub.world.onQuest(6282, { 1 })\nstub.world.onQuest(216, { 1 })\n";
	let out = run_update(guides, log, &saved, "{}");
	assert_eq!(json!([out["tabs"], out["said"]]), json!([["test/plan"], ""]), "{out}");
}

// 0.4.1.1 -> 0.4.2, reworked for real (Alliance Silithus, Horde Azshara and Feralas): the tab moved to the guide
// with the log's quests opened at that guide's first step, wherever the player was in it, and the chat line named
// the tab by the reworked guide's new title, one the player never saw on it. The line names the guide as the save
// knew it (Core/LegacySteps.lua `titles`, by the version of the guides the save was made with), and the guide it
// moved to opens at the work of the log's quests, its steps before passing behind the player.
#[test]
fn a_tab_an_update_moved_names_the_guide_the_player_had_and_opens_at_the_log_s_work() {
	let guides = r#"
local function g(t, q, extra) local x = { t = t, quest = q, title = "Quest " .. q, map = 1429, x = 50, y = 50 } for k, v in pairs(extra or {}) do x[k] = v end return x end
Polestar.RegisterGuide({ id = "test/rw", pack = "test", title = "Ashenvale & Silverpine Forest", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { g("accept", 216, { x = 40, y = 40 }) } }, { goals = { g("turnin", 216) } }, { goals = { g("turnin", 6462) } },
} })
Polestar.RegisterGuide({ id = "test/to", pack = "test", title = "The Barrens & Stonetalon Mountains", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { g("accept", 300, { x = 30, y = 30 }) } },
	{ goals = { { t = "goto", map = 1429, x = 60, y = 60 } } },
	{ goals = { g("kill", 1087, { target = "Wolf", npc = 299, count = 5, oi = 1, x = 70, y = 70 }) } },
	{ goals = { g("turnin", 1087) } },
	{ goals = { g("turnin", 6282) } },
} })"#;
	let saved = r#"PolestarCharDB = { schema = 1, tabs = { "test/rw" }, activeTab = 1, shapes = { ["test/rw"] = "4-1" },
	shapeVersions = { ["test/rw"] = "0.9" }, stepKeys = { ["test/rw"] = { 1, 2, 3, 4 } } }"#;
	let log = "stub.world.onQuest(1087, { { required = 5, fulfilled = 2 } })\nstub.world.onQuest(6282, { 1 })\nstub.world.onQuest(216, { 1 })\n";
	let out = run_update(guides, log, saved, r#"{ ["test/rw"] = { titles = { ["0.9"] = "Stonetalon Mountains & Ashenvale" } } }"#);
	assert_eq!(out["tabs"], json!(["test/to"]), "{out}");
	assert_eq!(
		out["said"],
		"Stonetalon Mountains & Ashenvale changed in this update and holds other quests now. Its tab moved to The Barrens & Stonetalon Mountains, which has the quests in your log."
	);
	assert_eq!(out["live"], 3, "at 1087's kills, not 300's accept at the guide's start: {out}");
}

// A report: after a relog the guide list forgot which guides were finished (Darkshore 21-23 read "Started"
// until it was opened again): completion was only remembered for the session. A guide finished in play is
// recorded in CharState().guideDone, so its check stays after a reload.
#[test]
fn a_guide_finished_in_play_stays_done_in_the_guide_list_after_a_reload() {
	let first = run(
		"",
		None,
		r#"
			E.SetGuide("test/lvl"); flush()
			stub.world.accept(783, {}, "A Threat Within"); flush()
			stub.world.turnIn(783); flush()
			local r = { open = E.GetGuideState("test/lvl"), done = PolestarCharDB.guideDone["test/lvl"] or false }
			E.CloseTab(1); flush()
			r.closed = E.GetGuideState("test/lvl")
			emit(r)
		"#,
	);
	assert_eq!(first, json!({ "open": "done", "done": true, "closed": "done" }));

	let saved = r#"PolestarCharDB = { schema = 1, tabs = { "test/cook" }, activeTab = 1, guideDone = { ["test/lvl"] = true }, flags = { started = { ["test/lvl"] = true } } }"#;
	let reload = run("", Some(saved), r#"flush(); emit({ state = E.GetGuideState("test/lvl"), tabs = ids() })"#);
	assert_eq!(reload["state"], "done", "the check survives a reload: {reload}");
	assert_eq!(reload["tabs"], json!({ "tabs": ["test/cook"], "active": 1 }));
}

// The same for a guide that is no leveling guide (a class guide): the guide list's "done" is for every guide.
#[test]
fn a_class_guide_finished_in_play_stays_done_after_a_reload() {
	let first = run(
		"",
		None,
		r#"
			E.SetGuide("test/warrior"); flush()
			stub.world.accept(1684, {}, "Elanaria"); flush()
			stub.world.turnIn(1684); flush()
			local r = { open = E.GetGuideState("test/warrior"), done = PolestarCharDB.guideDone["test/warrior"] or false }
			E.CloseTab(1); flush()
			r.closed = E.GetGuideState("test/warrior")
			emit(r)
		"#,
	);
	assert_eq!(first, json!({ "open": "done", "done": true, "closed": "done" }));

	let saved = r#"PolestarCharDB = { schema = 1, tabs = { "test/cook" }, activeTab = 1, guideDone = { ["test/warrior"] = true }, flags = { started = { ["test/warrior"] = true } } }"#;
	let reload = run("", Some(saved), r#"flush(); emit(E.GetGuideState("test/warrior"))"#);
	assert_eq!(reload, "done", "the check survives a reload: {reload}");
}

// Reset guide progress forgets the saved finish with the check-offs and skips (it is the guide list's check).
#[test]
fn reset_guide_progress_forgets_the_saved_finish() {
	let first = run(
		"",
		None,
		r#"
			E.SetGuide("test/lvl"); flush()
			stub.world.accept(783, {}, "A Threat Within"); flush()
			stub.world.turnIn(783); flush()
			local r = { before = PolestarCharDB.guideDone["test/lvl"] or false }
			E.ResetProgress(); flush()
			r.after = PolestarCharDB.guideDone["test/lvl"] or false
			emit(r)
		"#,
	);
	assert_eq!(first, json!({ "before": true, "after": false }));
}

// A save from before CharState().guideDone: a leveling guide's saved end (guideEnds, 0.3.6 on) is its finish,
// so the guide list checks it after a reload without it being opened again.
#[test]
fn a_leveling_guide_with_a_saved_end_is_done_after_a_reload() {
	let saved = r#"PolestarCharDB = { schema = 1, tabs = { "test/cook" }, activeTab = 1, guideEndsV = 2, guideEnds = { ["test/lvl"] = true } }"#;
	let out = run("", Some(saved), r#"flush(); emit({ state = E.GetGuideState("test/lvl"), done = PolestarCharDB.guideDone["test/lvl"] or false })"#);
	assert_eq!(out, json!({ "state": "done", "done": false }));
}

// Fitz (preview5): the arrow seemed to stay on the other tab's goal after a switch (not reproduced: the walking-map
// harness switched at once too, with tab 2's walk still being planned). With the whole addon (Nav too) and two tabs
// whose goals lie in different zones, SelectTab(1) gives tab 1's waypoint and the arrow's target in the same frame, and
// never tab 2's again. (The walk's hold for a measure, #3594, is for the target it was planned for only.)
#[test]
fn switching_tabs_retargets_the_arrow_at_once_and_never_back_to_the_other_tab_s_goal() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.addMap(1433, {{ name = \"Redridge Mountains\", c = 0, left = -1500, right = -4500, top = 500, bottom = -1500 }})\n"),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDES,
			r#"Polestar.RegisterGuide({ id = "test/far", pack = "test", title = "Redridge", category = "Exploration", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "goto", label = "Lakeshire", map = 1433, x = 30, y = 60 } } },
} })"#,
			HELPERS,
			"stub.login()",
			r#"
			local N = Polestar.Nav
			local function target() local t = N.GetTarget(); return t and t.map or false end
			flush()
			local r = { one = target() }
			E.OpenTab("test/far", true)
			N.Sample()
			r.two = target()
			E.SelectTab(1)
			r.back = { E.GetWaypoint().map, target() }
			local seen = 0
			for i = 1, 30 do N.Sample(); stub.advance(1 / 30); if target() == 1433 then seen = seen + 1 end end
			r.seen = seen
			emit(r)"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "one": 1429, "two": 1433, "back": [1429, 1429], "seen": 0 }));
}
