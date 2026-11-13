//! An update never moves a player back (0.3.5 -> 0.3.6: 26 of 199 recorded mid-guide saves
//! were sent back to a quest the update put behind them). A save made with an older version of a guide
//! (CharState().shapes and stepKeys, no shapeVersions) loads the new one: what the update added behind the
//! player passes for them (Own.noteAdded, Own.passAdded), what it added ahead stays, a quest they carry keeps
//! its work, and check-offs, skips and the saved view of changed steps go to the step that has the same goal
//! now (Own.remap with Core/LegacySteps.lua). A save with no older shape (a fresh load) keeps today's placement.
//! Safety: the mapping runs once (the save is stamped with the pack's version), an error in it falls back to
//! the plain restore by kept steps with one debug-log line, and Reset progress undoes what it passed.

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
Polestar.LegacyStepsLoad = function() return { ["test/up"] = { [h("accept:102")] = "accept:102" } } end
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

// The 6 states the upgrade check still saw sent back (Wetlands 98216, Hillsbrad 98283, Stranglethorn 1287, Silithus
// 6390): a quest the player carries whose work the update moved behind them. 108 is in the log; its kill and
// hand-in are only in the step the update added behind the player.
const BEHIND_GUIDE_FROM: &str = r#"{ title = "New behind", goals = { a(108, 40) } },"#;
const BEHIND_GUIDE_TO: &str = r#"{ title = "New behind", goals = { a(108, 40), { t = "kill", target = "Wolf", npc = 299, count = 5, quest = 108, oi = 1, map = M, x = 49, y = 50 }, t(108, 40) } },"#;

#[test]
fn a_quest_the_player_carries_whose_work_the_update_put_behind_them_is_still_to_do_and_the_place_stays() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.onQuest(108, {{ {{ required = 5, fulfilled = 1 }} }}, \"Quest 108\")"),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".to_string(), saved(""))],
		login: false,
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{}
{SCRIPT}
local GF = Polestar.UI.GuideFrame
GF.Update()
local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
local rows = {{}}
for _, r in ipairs(GF.alongRows) do if r:IsShown() then rows[#rows + 1] = plain(r.Text:GetText()) end end
local b = E.GetBehind()[1]
local cands = {{}}
for _, c in ipairs(E.GetWhileHereCandidates()) do cands[#cands + 1] = c.step .. ":" .. c.index end
local row = GF.alongRows[1]
row:GetScript("OnClick")(row, "LeftButton")
local wp = E.GetWaypoint()
emit({{ behind = b and {{ quest = b.quest, zone = b.zone, yards = b.yards }} or false, rows = rows,
	header = plain(GF.parts.along.Label:GetText()), cands = cands, wp = wp and (wp.stepIndex .. ":" .. wp.goalIndex) or false }})
E.SkipBehind(108)
emit({{ left = #E.GetBehind(), live = E.GetLiveStep() }})"#,
			GUIDE.replace(BEHIND_GUIDE_FROM, BEHIND_GUIDE_TO)
		),
	});
	let (at, ui, skipped) = (&out[0], &out[1], &out[2]);
	// The player stays at 103's hand-in; the step behind passes.
	assert_eq!(at["live"], 8, "{at}");
	assert_eq!(at["status"][1], "na", "{at}");
	// 108 is still to do, back in Elwynn Forest, 30 yd off (49,50 vs 50,50 on a 3000-yard-wide map).
	assert_eq!(ui["behind"], json!({ "quest": 108, "zone": "Elwynn Forest", "yards": 30 }), "{ui}");
	assert_eq!(ui["header"], "Still to do", "{ui}");
	assert_eq!(ui["rows"], json!(["Still to do: “Quest 108”, back in Elwynn Forest, 30 yd"]), "{ui}");
	// While-here offers its kill near; a click on the row points the arrow at it.
	assert!(ui["cands"].as_array().unwrap().contains(&json!("2:2")), "{ui}");
	assert_eq!(ui["wp"], "2:2", "{ui}");
	// Skip: the row goes, the place stays.
	assert_eq!(skipped["left"], 0);
	assert_eq!(skipped["live"], 8);
}

// #1595 (0.3.5 -> 0.3.6, The Sacred Flame): the update added a carried quest's work behind the player and its
// hand-in ahead of them (the phial in Ashenvale, the hand-in at Thunder Bluff). The hand-in is no work: the
// quest is still to do, and the place stays.
const TURNIN_AHEAD_FROM: &str = r#"{ title = "New ahead", goals = { a(110, 70) } },"#;
const TURNIN_AHEAD_TO: &str = r#"{ title = "New ahead", goals = { a(110, 70) } },
	{ title = "Hand in 108", when = { { k = "complete", q = 108 } }, goals = { t(108, 70) } },"#;

#[test]
fn a_carried_quest_whose_work_the_update_put_behind_them_is_still_to_do_when_its_hand_in_is_ahead() {
	let guide = GUIDE
		.replace(BEHIND_GUIDE_FROM, r#"{ title = "New behind", goals = { a(108, 40), { t = "kill", target = "Wolf", npc = 299, count = 5, quest = 108, oi = 1, map = M, x = 49, y = 50 } } },"#)
		.replace(TURNIN_AHEAD_FROM, TURNIN_AHEAD_TO);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.onQuest(108, {{ {{ required = 5, fulfilled = 1 }} }}, \"Quest 108\")"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved(""))],
		login: false,
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guide}\n{SCRIPT}\nlocal b = E.GetBehind()[1]\nemit({{ behind = b and b.quest or false, step = b and b.step or false }})"),
	});
	let (at, behind) = (&out[0], &out[1]);
	assert_eq!(at["live"], 8, "the player stays at 103's hand-in: {at}");
	assert_eq!(at["status"][1], "na", "{at}");
	assert_eq!(behind["behind"], 108, "108's kill is still to do, its hand-in ahead or not: {behind}");
	assert_eq!(behind["step"], 2, "{behind}");
}

#[test]
fn an_error_in_the_update_s_mapping_falls_back_to_the_plain_restore_with_one_debug_line_and_runs_once() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved(r#"manual = { ["test/up"] = { ["4:1"] = true } }"#))],
		login: false,
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{}\nlocal log = table.concat(Polestar.DebugLog(), \"\\n\")\nemit({{ log = log, ver = PolestarCharDB.shapeVersions[\"test/up\"], added = PolestarCharDB.added and PolestarCharDB.added[\"test/up\"] or false, gone = PolestarCharDB.gone and PolestarCharDB.gone[\"test/up\"] or false, legacy = Polestar.LegacyStepsLoad == nil }})",
			// The earlier releases' steps, broken: the mapping errors.
			SCRIPT.replace(
				r#"Polestar.LegacyStepsLoad = function() return { ["test/up"] = { [h("accept:102")] = "accept:102" } } end"#,
				r#"Polestar.LegacyStepsLoad = function() error("broken") end"#
			)
		),
	});
	let (at, after) = (&out[0], &out[1]);
	// No Lua error reached the player (the run would fail), one line in the log for /polestar report.
	let log = after["log"].as_str().unwrap();
	assert_eq!(log.matches("upgrade mapping failed, plain restore").count(), 1, "{log}");
	// The plain restore: the kept walk keeps its tick at its new number; nothing passed or noted.
	assert_eq!(at["manual"]["5:1"], true, "{at}");
	assert_eq!(after["added"], false);
	assert_eq!(after["gone"], false);
	// Stamped with this version: it never runs again on this save. The earlier releases' steps are let go.
	assert!(after["ver"].is_string(), "{after}");
	assert_eq!(after["legacy"], true);
}

#[test]
fn reset_progress_brings_back_what_an_update_passed() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved(""))],
		login: false,
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{SCRIPT}\nE.ResetProgress()\nstub.advance(11)\nemit({{ live = E.GetLiveStep(), behind = E.GetStepView(2).goals[1].status, gone = PolestarCharDB.gone and PolestarCharDB.gone[\"test/up\"] or false }})"
		),
	});
	assert_eq!(out[0]["status"][1], "na", "{}", out[0]);
	// The player's own correction: Reset progress places the guide as if just opened, 108's accept included.
	assert_eq!(out[1]["gone"], false, "{}", out[1]);
	assert_eq!(out[1]["live"], 2, "{}", out[1]);
}

// The upgrade check on the final candidate (Skyborne Druid, Zephras Isle): the player skipped 0.3.5's Raan Wildwind
// step whole; 0.3.6 split it, its training going to a new Zerril Softbreeze step after the Camping 101 steps. The
// skip went with the first half only, so the training half came back and pulled the live step 14 steps back. A
// step all of whose goals came from a step the player skipped whole is skipped too.
#[test]
fn a_skipped_step_an_update_split_stays_skipped_in_every_part() {
	let guide = GUIDE.replace(
		r#"{ title = "Walk", goals"#,
		r#"{ title = "Split off", goals = { { t = "train", spell = 999, map = M, x = 52, y = 50 } } },
	{ title = "Walk", goals"#,
	);
	let old = saved(r#"skipped = { ["test/up"] = { [3] = true } }"#).replace(r#""accept:102", "goto:1429""#, r#""accept:102,train:999", "goto:1429""#);
	let script = SCRIPT.replace(r#"[h("accept:102")] = "accept:102""#, r#"[h("accept:102,train:999")] = "accept:102,train:999""#);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), old)],
		login: false,
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guide}\n{script}"),
	})
	.remove(0);
	// 103's hand-in is step 9 now (the split-off step is 5).
	assert_eq!(out["live"], 9, "the player still at 103's hand-in: {out}");
	assert_eq!(out["skipped"]["4"], true, "{out}");
	assert_eq!(out["skipped"]["5"], true, "the split-off half keeps the skip: {out}");
}

// The upgrade check on the 0.3.6 candidate (Wetlands, a 0.3.5 save at Anilia, step 42, carrying Bloom of the
// Heavens taken off the route): Menethil's second stop gained that quest's hand-in (new) beside its hand-ins and
// a vendor check-off the save had there too. The vendor never holds that step (Own.sideVendor), so the player's
// place is still past it, and the carried quest is still to do; before, the vendor read as open work the update
// did not add and sent the player 28 steps back to Menethil.
#[test]
fn a_vendor_beside_what_an_update_added_to_a_step_behind_the_player_never_holds_them_there() {
	const VENDOR: &str = r#"{ t = "vendor" }"#;
	let guide = GUIDE.replace(r#"{ title = "Changed", goals = { a(102), a(109) } },"#, &format!(r#"{{ title = "Changed", goals = {{ a(102), t(109), {VENDOR} }} }},"#));
	let old = saved("").replace(r#""accept:102", "goto:1429""#, r#""accept:102,vendor:", "goto:1429""#);
	let script = SCRIPT
		.replace(r#"[h("accept:102")] = "accept:102""#, r#"[h("accept:102,vendor:")] = "accept:102,vendor:""#)
		.replace("changed = {", "behind = E.GetBehind()[1] and E.GetBehind()[1].quest or false, changed = {");
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.onQuest(109, {{ {{ required = 5, fulfilled = 1 }} }}, \"Quest 109\")"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), old)],
		login: false,
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guide}\n{script}"),
	})
	.remove(0);
	assert_eq!(out["live"], 8, "the player still at 103's hand-in: {out}");
	assert_eq!(out["behind"], 109, "109 still to do: {out}");
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
