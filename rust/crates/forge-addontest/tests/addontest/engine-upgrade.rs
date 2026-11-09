//! An update never moves a player back (0.3.5 -> 0.3.6, UpgradeMid036: 26 of 199 recorded mid-guide saves
//! were sent back to a quest the update put behind them). A save made with an older version of a guide
//! (CharState().shapes and stepKeys, no shapeVersions) loads the new one: what the update added behind the
//! player passes for them (Own.noteAdded, Own.passAdded), what it added ahead stays, a quest they carry keeps
//! its work, and check-offs, skips and the saved view of changed steps go to the step that has the same goal
//! now (Own.remap with ns.LegacySteps). A save with no older shape (a fresh load) keeps today's placement.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 10
-- The player did 100 and 102 and carries 103 (not done yet).
w.complete({ 100, 102 })
w.onQuest(103, { { required = 5, fulfilled = 1 } }, "Quest 103")
"#;

// The guide as the save knew it (version 1): accept 100, turn in 100, accept 102, walk, turn in 102, accept
// 103, turn in 103. Version 2 (registered): a new accept 108 behind the player, 102's step with a new accept
// 109, a new accept 110 after 103's hand-in.
const GUIDE: &str = r#"
local M = 1429
local function a(q, x) return { t = "accept", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50 } end
local function t(q, x) return { t = "turnin", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50 } end
Polestar.RegisterGuide({ id = "test/up", pack = "test", title = "Upgraded", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Start", goals = { a(100) } },
	{ title = "New behind", goals = { a(108, 40) } },
	{ title = "Hand in 100", goals = { t(100) } },
	{ title = "Changed", goals = { a(102), a(109) } },
	{ title = "Walk", goals = { { t = "goto", map = M, x = 60, y = 60 } } },
	{ title = "Hand in 102", goals = { t(102) } },
	{ title = "Take 103", goals = { a(103) } },
	{ title = "Hand in 103", goals = { t(103) } },
	{ title = "New ahead", goals = { a(110, 70) } },
} })
"#;

// djb2 as Own.hash, for the save's step keys.
const HASH: &str = r#"local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end
local OLD = { "accept:100", "turnin:100", "accept:102", "goto:1429", "turnin:102", "accept:103", "turnin:103" }
local keys = {}
for i, p in ipairs(OLD) do keys[i] = h(p) end"#;

fn saved(extra: &str) -> String {
	format!(
		r#"{HASH}
PolestarCharDB = {{ schema = 1, tabs = {{ "test/up" }}, activeTab = 1,
	shapes = {{ ["test/up"] = "7-1" }}, stepKeys = {{ ["test/up"] = keys }}, {extra} }}"#
	)
}

const SCRIPT: &str = r#"
E = Polestar.Engine
-- The changed step's goals as the earlier release had them (tools/legacy-steps.js).
local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end
Polestar.LegacySteps = { ["test/up"] = { [h("accept:102")] = "accept:102" } }
stub.login(); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local status = {}
for i = 1, #g.steps do status[i] = E.GetStepView(i).status end
local db = PolestarCharDB
emit({ live = E.GetLiveStep(), view = E.GetStepIndex(), status = status, skipped = db.skipped["test/up"] or false,
	manual = db.manual["test/up"] or false, pin = db.pins and db.pins["test/up"] and db.pins["test/up"].step or false,
	ahead = E.GetStepView(9).goals[1].status, behind = E.GetStepView(2).goals[1].status,
	changed = { E.GetStepView(4).goals[1].status, E.GetStepView(4).goals[2].status } })
"#;

fn run(saved: Option<String>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		login: false,
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{SCRIPT}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn an_update_never_moves_the_player_back_its_new_quests_behind_them_pass_and_those_ahead_stay() {
	let out = run(Some(saved("")));
	// The player was at 103's hand-in: there still, not at the new accept 108 behind them.
	assert_eq!(out["live"], 8, "{out}");
	// The new step behind passes without showing as skipped; so does the new accept in the changed step.
	assert_eq!(out["status"][1], "na", "{out}");
	assert_eq!(out["changed"], json!(["done", "na"]));
	assert!(out["skipped"] == json!(false) || out["skipped"].get("2").is_none(), "{out}");
	// What the update added ahead of the player stays.
	assert_eq!(out["ahead"], "pending");
}

#[test]
fn a_fresh_load_of_the_guide_keeps_today_s_placement() {
	// No older shape in the save: the new accept 108 is the guide's own first open step.
	let out = run(None);
	assert_eq!(out["live"], 2, "{out}");
	assert_eq!(out["behind"], "active");
}

#[test]
fn check_offs_skips_and_the_view_of_a_changed_step_go_to_the_step_with_the_same_goal() {
	// Skipped the old step 3 (accept 102), ticked its accept, and was looking at it: all three go to the new
	// step 4, which has accept 102. The walk (a kept step, old 4) keeps its tick at its new number 5.
	let out = run(Some(saved(r#"skipped = { ["test/up"] = { [3] = true } }, manual = { ["test/up"] = { ["3:1"] = "tick", ["4:1"] = true } }, pins = { ["test/up"] = { step = 3, done = true } }"#)));
	assert_eq!(out["skipped"]["4"], true, "{out}");
	assert_eq!(out["manual"]["4:1"], "tick", "{out}");
	assert_eq!(out["manual"]["5:1"], true, "{out}");
	assert_eq!(out["pin"], 4, "{out}");
	assert_eq!(out["live"], 8, "the view kept, the player still at 103's hand-in: {out}");
}

#[test]
fn a_quest_the_player_carries_keeps_its_work_even_where_the_update_put_it_behind_them() {
	// The update moved 103's hand-in before the walk (here: the player carries 109, the changed step's new
	// accept... taken already): a goal of a quest in the log is the player's own, never passed.
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.onQuest(108, {{ {{ required = 1, fulfilled = 0 }} }}, \"Quest 108\")"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved(""))],
		login: false,
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{}\n{SCRIPT}",
			GUIDE.replace(r#"{ title = "New behind", goals = { a(108, 40) } },"#, r#"{ title = "New behind", goals = { a(108, 40), t(108, 40) } },"#)
		),
		..Default::default()
	})
	.remove(0);
	// 108 is in the log and its hand-in is only in the step the update added behind: the step stays.
	assert_eq!(out["status"][1], "current", "{out}");
}

// Fitz: a step an update passed behind the player may hold a prerequisite for a quest ahead. Here the update
// added 111 (accept and hand-in) behind the player and 112 (needs 111) after 103's hand-in. On the way (the
// same zone, near): 111 comes back just before 112, after the player's place. Far (another continent): 112
// and its hand-in drop out, as on a fresh load; never a "Requires" step.
const PRE_GUIDE: &str = r#"
local M = 1429
local function a(q, x, pre) return { t = "accept", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50, pre = pre } end
local function t(q, x) return { t = "turnin", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50 } end
local P111 = PRE111
Polestar.RegisterGuide({ id = "test/up", pack = "test", title = "Upgraded", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Start", goals = { a(100) } },
	{ title = "New behind", goals = {
		{ t = "accept", quest = 111, title = "Quest 111", map = P111[1], x = P111[2], y = P111[3] },
		{ t = "turnin", quest = 111, title = "Quest 111", map = P111[1], x = P111[2], y = P111[3] },
	} },
	{ title = "Hand in 100", goals = { t(100) } },
	{ title = "Take 103", goals = { a(103) } },
	{ title = "Hand in 103", goals = { t(103) } },
	{ title = "Needs 111", goals = { a(112, 52, { 111 }) } },
	{ title = "Hand in 112", goals = { t(112, 52) } },
} })
"#;

const PRE_SAVED: &str = r#"local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end
PolestarCharDB = { schema = 1, tabs = { "test/up" }, activeTab = 1, shapes = { ["test/up"] = "4-1" },
	stepKeys = { ["test/up"] = { h("accept:100"), h("turnin:100"), h("accept:103"), h("turnin:103") } } }"#;

fn run_pre(at: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.addMap(1440, {{ name = \"Ashenvale\", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 }})"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), PRE_SAVED.to_string())],
		login: false,
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
PRE111 = {{ {at} }}
{PRE_GUIDE}
E = Polestar.Engine
stub.login(); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local shape, requires = {{}}, {{}}
for i, step in ipairs(g.steps) do
	local v = E.GetStepView(i)
	local q = {{}}
	for k, goal in ipairs(step.goals) do
		q[#q + 1] = goal.t .. ":" .. tostring(goal.quest) .. "=" .. v.goals[k].status
		if v.goals[k].unavailable == "pre" then requires[#requires + 1] = goal.quest end
	end
	shape[i] = (step.feeder and "F " or "") .. step.title .. " " .. table.concat(q, " ")
end
emit({{ shape = shape, live = E.GetLiveStep(), title = g.steps[E.GetLiveStep()].title, requires = requires, hidden = g.hidden and g.hidden[112] and true or false }})"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_prerequisite_the_update_passed_comes_back_on_the_way_just_before_the_quest_that_needs_it() {
	let out = run_pre("1429, 51, 51");
	let shape: Vec<String> = out["shape"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	assert_eq!(out["title"], "Hand in 103", "the player stays where they were: {shape:?}");
	let f = shape.iter().position(|s| s.starts_with("F New behind")).expect("111 back as a step");
	let need = shape.iter().position(|s| s.starts_with("Needs 111")).unwrap();
	let here = shape.iter().position(|s| s.starts_with("Hand in 103")).unwrap();
	assert!(here < f && f + 1 == need, "after the player's place, just before 112: {shape:?}");
	assert_eq!(out["requires"].as_array().map_or(0, |a| a.len()), 0, "{shape:?}");
}

#[test]
fn a_prerequisite_the_update_passed_far_away_drops_the_quest_that_needs_it_and_its_hand_in() {
	let out = run_pre("1440, 50, 50");
	let shape: Vec<String> = out["shape"].as_array().unwrap().iter().map(|v| v.as_str().unwrap().to_string()).collect();
	assert_eq!(out["title"], "Hand in 103", "{shape:?}");
	assert!(!shape.iter().any(|s| s.contains(":112")), "112 and its hand-in drop out: {shape:?}");
	assert_eq!(out["hidden"], true);
	assert_eq!(out["requires"].as_array().map_or(0, |a| a.len()), 0, "{shape:?}");
}
