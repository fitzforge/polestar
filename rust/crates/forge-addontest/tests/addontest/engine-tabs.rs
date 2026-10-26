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
			local list, active = E.GetTabs()
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
