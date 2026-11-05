//! The player's own word over the guide (addon/Polestar/Core/Engine.lua): › and ‹ look ahead and back without
//! changing anything, Skip is the only way a step is skipped (and Unskip undoes it), every goal ticks done and
//! back, optional goals skip with one click, all of it saved and honoured by a reload; the arrow follows the
//! current goal. Real Core manifest, stub world.

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// Elwynn: 3000 x 2000 yards, so 1% is 30 yd across and 20 yd down.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// A Northshire-shaped route for a Warrior: step 5 is Mage-only.
const ROUTE: &str = r#"
Polestar.RegisterGuide({
	id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Kobold camp", goals = {
			{ t = "goto", map = 1429, x = 47.6, y = 35.1, text = "Kobold camp", r = 10 },
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
		} },
		{ title = "Warrior training", only = { classes = { "WARRIOR" } }, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Mage training", only = { classes = { "MAGE" } }, goals = {
			{ t = "train", npc = 198, npcName = "Khelden Bremen" },
		} },
		{ title = "Back to the abbey", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "level", level = 4 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- A table's keys, sorted and joined ("1:1,3"; "" for none).
function keys(t)
	local out = {}
	for k in pairs(t or {}) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return table.concat(out, ",")
end
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(guides: &str, before: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![core()],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, guides, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

// SavedVariables as the client writes them at a reload: the script ends with stub.fire("PLAYER_LOGOUT") and
// emits PolestarCharDB; this turns it back into the chunk the next session loads.
fn reload_of(char_db: &Value) -> String {
	format!("PolestarCharDB = {}", lua_value(char_db))
}

const AT_CAMP: &str = "w.complete({ 783 }); w.onQuest(7, { 10 })"; // the kobolds are the live step (3)

const ROUTE_SAVED: Option<&str> = Some(r#"PolestarCharDB = { schema = 1, guide = "test/route" }"#);

#[test]
fn looks_ahead_and_back_without_skipping_anything_skip_skips_the_step_shown_and_unskip_undoes_it() {
	let out = run(
		ROUTE,
		AT_CAMP,
		ROUTE_SAVED,
		r#"
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) .. "/" .. tostring(E.GetLiveStep()) end
			mark("start")
			E.Next(); flush(); mark("next")
			local ahead = { E.GetStepView(4).status, E.GetStepView(3).status }
			E.Next(); flush(); mark("next")
			E.Next(); flush(); mark("end")
			E.Prev(); flush(); mark("prev")
			E.Prev(); flush(); mark("prev")
			local untouched = keys(PolestarCharDB.skipped["test/route"])
			E.Skip(); flush(); mark("skip")
			local skipped = keys(PolestarCharDB.skipped["test/route"])
			local view3 = E.GetStepView(3)
			local undone = E.Unskip(3); flush(); mark("unskip")
			emit({ trail = trail, ahead = ahead, untouched = untouched, skipped = skipped, skippedView = { view3.status, view3.skipped },
				undone = undone, after = keys(PolestarCharDB.skipped["test/route"]) })
		"#,
	);
	assert_eq!(out["trail"], json!(["start=3/3", "next=4/3", "next=6/3", "end=6/3", "prev=4/3", "prev=3/3", "skip=4/4", "unskip=3/3"]));
	assert_eq!(out["ahead"], json!(["current", "upcoming"]), "looking ahead: the live step is still to do, not skipped");
	assert_eq!(out["untouched"], "", "› and ‹ never skip");
	assert_eq!(out["skipped"], "3");
	assert_eq!(out["skippedView"], json!(["skipped", true]));
	assert_eq!(out["undone"], true);
	assert_eq!(out["after"], "");
}

#[test]
fn looking_ahead_at_an_accept_taking_the_quest_moves_on_to_its_objective_step_even_while_the_log_has_not_filled_in_the_objectives_yet_regression_barak_kodobane_passed_for_the_kolkar_leaders_turn_in()
{
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/kolkar", pack = "test", title = "Kolkar", minLevel = 1, maxLevel = 30, steps = {
			{ title = "Sergra", goals = { { t = "accept", quest = 3261, title = "Jorn Skyseer", npc = 3338 } } },
			{ title = "Regthar", goals = { { t = "accept", quest = 850, title = "Kolkar Leaders", npc = 3389 } } },
			{ title = "Barak", goals = { { t = "collect", item = 5022, itemName = "Barak's Head", count = 1, quest = 850, oi = 1 } } },
			{ title = "Regthar", goals = { { t = "turnin", quest = 850, title = "Kolkar Leaders", npc = 3389 } } },
		} })"#;
	let out = run(
		guides,
		"",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/kolkar" }"#),
		r#"
			local w = stub.world
			Polestar.Set("behavior.autoAccept", false)
			E.Goto(2); flush()
			local r = { looking = E.GetStepIndex() }
			w.accept(850, {}); flush() -- in the log, its objectives not there yet
			r.accepted = E.GetStepIndex()
			w.log[850].objectives = { { text = "Barak's Head: 0/1", type = "item", numFulfilled = 0, numRequired = 1, finished = false } }
			stub.fire("QUEST_LOG_UPDATE"); flush()
			r.filled = { E.GetStepIndex(), E.GetLiveStep(), E.GetStepView(3).status }
			emit(r)
		"#,
	);
	assert_eq!(out["looking"], 2);
	assert_eq!(out["accepted"], 3, "the head is still to get");
	assert_eq!(out["filled"], json!([3, 1, "current"]));
}

#[test]
fn skip_while_looking_ahead_skips_the_step_shown_and_moves_on_from_it_leaving_the_live_step_alone() {
	let out = run(
		ROUTE,
		AT_CAMP,
		ROUTE_SAVED,
		r#"
			E.Next(); flush()
			E.Skip(); flush()
			emit({ at = E.GetStepIndex(), live = E.GetLiveStep(), skipped = keys(PolestarCharDB.skipped["test/route"]) })
		"#,
	);
	assert_eq!(out, json!({ "at": 6, "live": 3, "skipped": "4" }));
}

#[test]
fn a_reload_keeps_the_position_a_skipped_step_stays_skipped_even_with_its_quest_under_way() {
	// The kobolds (step 3) were skipped with Kobold Camp Cleanup in the log and some kills done; the route
	// went on to training.
	let out = run(
		ROUTE,
		"w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })",
		Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/route" }, activeTab = 1, skipped = { ["test/route"] = { [3] = true } } }"#),
		r#"emit({ at = E.GetStepIndex(), skipped = keys(PolestarCharDB.skipped["test/route"]) })"#,
	);
	assert_eq!(out, json!({ "at": 4, "skipped": "3" }));
}

#[test]
fn a_quest_its_giver_did_not_list_is_never_skipped_nor_kept_across_a_reload_161_741() {
	const GUIDE: &str = r#"
		Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", minLevel = 10, maxLevel = 20, steps = {
			{ title = "Thork", goals = {
				{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork", map = 1429, x = 51, y = 30 },
				{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1429, x = 52, y = 30 },
			} },
			{ title = "Raptors", goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1, map = 1429, x = 45, y = 20 } } },
			{ goals = { { t = "level", level = 30 } } },
		} })
	"#;
	let before = "w.level = 12";
	let first = run(
		GUIDE,
		before,
		Some(r#"PolestarDB = { schema = 1, settings = { behavior = { autoAccept = false } } }; PolestarCharDB = { schema = 1, guide = "test/xr" }"#),
		r#"
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			local g = E.GetStepView(1).goals[1]
			local at = E.GetStepIndex()
			stub.fire("PLAYER_LOGOUT")
			emit({ at = at, status = g.status, notice = g.noticeText, db = PolestarCharDB })
		"#,
	);
	assert_eq!(first["at"], 1, "the guide stays at Thork");
	assert_eq!(first["status"], "active");
	assert_eq!(first["notice"], "Not offered by Thork? Report it with /polestar");
	assert_eq!(first["db"]["offers"], Value::Null, "nothing saved");
	let script = r#"local g = E.GetStepView(1).goals[1]; emit({ at = E.GetStepIndex(), status = g.status, why = g.unavailable or false, notice = g.noticeText or false })"#;
	let reload = run(GUIDE, &format!("{before}; w.onQuest(869, {{ 12 }})"), Some(&reload_of(&first["db"])), script);
	assert_eq!(reload, json!({ "at": 1, "status": "active", "why": false, "notice": false }), "a reload asks Thork afresh");
}

#[test]
fn a_pack_update_that_moves_steps_keeps_check_offs_skips_and_the_place_the_player_was_looking_at() {
	const V1: &str = r#"
		Polestar.RegisterGuide({ id = "test/mv", pack = "test", title = "Moves", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "talk", npc = 1, npcName = "One" } } },
			{ goals = { { t = "accept", quest = 902, title = "Two", npc = 2 } } },
			{ goals = { { t = "accept", quest = 903, title = "Three", npc = 3 } } },
			{ goals = { { t = "accept", quest = 904, title = "Four", npc = 4 } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#;
	// The update puts a new step in front.
	let v2 = V1.replacen("steps = {", "steps = {\n\t\t\t{ goals = { { t = \"level\", level = 1 } } },", 1);
	let first = run(
		V1,
		"",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/mv" }"#),
		r#"
			E.ToggleGoal(1, 1); flush()
			E.Skip(); flush()
			E.Next(); flush()
			local at = { E.GetStepIndex(), E.GetLiveStep() }
			stub.fire("PLAYER_LOGOUT")
			emit({ at = at, db = PolestarCharDB })
		"#,
	);
	assert_eq!(first["at"], json!([4, 3]));
	let updated = run(
		&v2,
		"",
		Some(&reload_of(&first["db"])),
		r#"emit({ at = { E.GetStepIndex(), E.GetLiveStep() }, manual = keys(PolestarCharDB.manual["test/mv"]), skipped = keys(PolestarCharDB.skipped["test/mv"]) })"#,
	);
	assert_eq!(updated, json!({ "at": [5, 4], "manual": "2:1", "skipped": "3" }));
}

#[test]
fn a_look_ahead_survives_a_reload_and_a_step_left_behind_by_the_guide_releases_it() {
	let first = run(ROUTE, AT_CAMP, ROUTE_SAVED, r#"E.Next(); E.Next(); flush(); stub.fire("PLAYER_LOGOUT"); emit({ at = E.GetStepIndex(), db = PolestarCharDB })"#);
	assert_eq!(first["at"], 6);
	let reload = run(ROUTE, AT_CAMP, Some(&reload_of(&first["db"])), "emit({ E.GetStepIndex(), E.GetLiveStep() })");
	assert_eq!(reload, json!([6, 3]));
	let caught_up = run(
		ROUTE,
		AT_CAMP,
		Some(&reload_of(&first["db"])),
		r#"
			local w = stub.world
			w.progress(7, 1, 10); flush()
			w.trainer(911); w.learnSpell(100); w.close(); flush()
			emit({ E.GetStepIndex(), E.GetLiveStep() })
		"#,
	);
	assert_eq!(caught_up, json!([6, 6]), "the guide reached the step looked at");
}

#[test]
fn every_goal_ticks_done_and_back_ticks_are_saved_place_the_guide_after_a_reload_and_count_in_its_progress() {
	let first = run(
		ROUTE,
		AT_CAMP,
		ROUTE_SAVED,
		r#"
			local r = {}
			local d0 = E.GetProgress()
			r.ok = E.ToggleGoal(3, 2); flush()
			local v = E.GetStepView(3)
			r.view = { v.goals[2].status, v.goals[2].ticked, v.goals[1].status }
			r.at = E.GetStepIndex()
			r.progress = E.GetProgress() - d0
			r.saved = PolestarCharDB.manual["test/route"]["3:2"]
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		"#,
	);
	assert_eq!(first["ok"], true);
	assert_eq!(first["view"], json!(["done", true, "done"]), "the kill ticked, the camp header with it");
	assert_eq!(first["at"], 4);
	assert_eq!(first["progress"], 1);
	assert_eq!(first["saved"], "tick");
	let reload = run(
		ROUTE,
		AT_CAMP,
		Some(&reload_of(&first["db"])),
		r#"
			local at = E.GetStepIndex()
			E.ToggleGoal(3, 2); flush()
			emit({ at = at, untick = E.GetStepIndex(), saved = keys(PolestarCharDB.manual["test/route"]) })
		"#,
	);
	// The camp's Go to stays latched: the route passed it.
	assert_eq!(reload, json!({ "at": 4, "untick": 3, "saved": "3:1" }));
}

#[test]
fn an_accept_ticked_without_taking_the_quest_stays_open_and_keeps_its_later_goals_taking_it_moves_on() {
	let out = run(
		ROUTE,
		"",
		ROUTE_SAVED,
		r#"
			local r = {}
			E.ToggleGoal(1, 1); flush()
			r.ticked = { E.GetStepView(1).goals[1].status, E.GetStepView(2).goals[1].status, E.GetStepIndex() }
			stub.world.accept(783, {}, "A Threat Within"); flush()
			r.taken = { E.GetStepView(2).goals[1].status, E.GetStepIndex() }
			emit(r)
		"#,
	);
	assert_eq!(out["ticked"], json!(["active", "pending", 1]), "a tick never stands for the quest log (#739): the accept stays, its turn-in too");
	assert_eq!(out["taken"], json!(["active", 2]));
}

// Issue #108: Distracting Jarven (308) is handed in straight from Jarven Thunderbrew's window, with no accept.
// `turnin ... direct` is that goal; the client never flags such a quest completed when it repeats, so the
// hand-in is stored like the Engine's other latched results.
const DIRECT: &str = r#"
	Polestar.RegisterGuide({ id = "test/direct", pack = "test", title = "Direct", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Jarven Thunderbrew", goals = {
			{ t = "turnin", quest = 308, title = "Distracting Jarven", @DIRECT@npc = 1373, npcName = "Jarven Thunderbrew", map = 1429, x = 49.0, y = 42.0 },
		} },
		{ title = "The barrel", goals = { { t = "level", level = 5 } } },
	} })"#;

fn direct(direct: bool) -> String {
	DIRECT.replace("@DIRECT@", if direct { "direct = true, " } else { "" })
}

#[test]
fn t_108_a_direct_turn_in_is_work_without_an_accept_and_the_hand_in_is_saved_even_when_the_quest_is_never_flagged_completed() {
	let out = run(
		&direct(true),
		"",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/direct" }"#),
		r#"
			local r = { before = E.GetStepView(1).goals[1].status, at = E.GetStepIndex() }
			-- The hand-in itself: no accept, and a repeatable leaves no completed flag.
			stub.fire("QUEST_TURNED_IN", 308); flush()
			r.after = E.GetStepView(1).goals[1].status
			r.flagged = stub.world.completed[308] == true
			r.saved = PolestarCharDB.manual["test/direct"]["1:1"]
			r.moved = E.GetStepIndex()
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		"#,
	);
	assert_eq!(out["before"], "active", "a direct turn-in has no accept, so it must not read as orphaned");
	assert_eq!(out["at"], 1);
	assert_eq!(out["after"], "done");
	assert_eq!(out["flagged"], false, "the quest repeats: the client flags nothing");
	assert_eq!(out["saved"], true);
	assert_eq!(out["moved"], 2);

	// The reload the issue describes: without the stored hand-in the goal would be open again, since nothing in
	// the client remembers it.
	let reload = run(&direct(true), "", Some(&reload_of(&out["db"])), "emit({ at = E.GetStepIndex(), status = E.GetStepView(1).goals[1].status })");
	assert_eq!(reload, json!({ "at": 2, "status": "done" }));
}

#[test]
fn t_108_the_same_turn_in_without_direct_reads_as_another_route_s_work_and_its_hand_in_is_forgotten_at_a_reload() {
	let out = run(
		&direct(false),
		"",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/direct" }"#),
		r#"
			local before = E.GetStepView(1).goals[1].status
			stub.fire("QUEST_TURNED_IN", 308); flush()
			local r = { before = before, after = E.GetStepView(1).goals[1].status, saved = PolestarCharDB.manual["test/direct"] }
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		"#,
	);
	assert_eq!(out["before"], "na", "a turn-in with no accept is orphaned");
	// The Engine remembers the turn-in for the session, so the goal does tick; nothing is stored, because only a
	// direct turn-in is latched.
	assert_eq!(out["after"], "done");
	assert!(out["saved"].is_null());
	let reload = run(&direct(false), "", Some(&reload_of(&out["db"])), "emit(E.GetStepView(1).goals[1].status)");
	assert_eq!(reload, "na", "the hand-in is gone: a repeatable would come back as undone");
}

// The cloth donations: Additional Runecloth (7796) repeats, a `turnin 7796 direct` in each step. The session's
// memory of a turn-in must not close the later steps' goals: one hand-in is one goal.
#[test]
fn t_108_one_hand_in_of_a_repeatable_direct_quest_checks_off_one_goal_not_every_later_one() {
	const GUIDE: &str = r#"
		Polestar.RegisterGuide({ id = "test/cloth", pack = "test", title = "Cloth", minLevel = 1, maxLevel = 60, steps = {
			{ title = "First", goals = { { t = "turnin", quest = 7796, title = "Additional Runecloth", direct = true, npc = 14722, npcName = "Clavicus Knavingham", map = 1429, x = 49.0, y = 42.0 } } },
			{ title = "Second", goals = { { t = "turnin", quest = 7796, title = "Additional Runecloth", direct = true, npc = 14722, npcName = "Clavicus Knavingham", map = 1429, x = 49.0, y = 42.0 } } },
		} })"#;
	let out = run(
		GUIDE,
		"w.repeatable[7796] = true",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/cloth" }"#),
		r#"
			stub.world.turnIn(7796); flush()
			emit({ E.GetStepView(1).goals[1].status, E.GetStepView(2).goals[1].status, E.GetStepIndex() })
		"#,
	);
	assert_eq!(out, json!(["done", "active", 2]));
}

#[test]
fn optional_goals_skip_with_one_click_are_saved_and_come_back_with_another() {
	const GUIDE: &str = r#"
		Polestar.RegisterGuide({ id = "test/og", pack = "test", title = "Optional", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Field", goals = {
				{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, optional = true, map = 1429, x = 20, y = 20 },
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 30, y = 30 },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#;
	let out = run(
		GUIDE,
		"w.onQuest(7, { 10 })",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/og" }"#),
		r#"
			local r = {}
			r.blocking = E.SkipGoal(1, 2)
			r.ok = E.SkipGoal(1, 1); flush()
			local g = E.GetStepView(1).goals[1]
			r.skipped = { g.status, g.dismissed }
			r.saved = keys(PolestarCharDB.skipped["test/og"])
			E.SkipGoal(1, 1); flush()
			r.back = E.GetStepView(1).goals[1].status
			r.after = keys(PolestarCharDB.skipped["test/og"])
			emit(r)
		"#,
	);
	assert_eq!(out, json!({ "blocking": false, "ok": true, "skipped": ["skipped", true], "saved": "1:1", "back": "active", "after": "" }));
}

// The Field of Giants (04-the-barrens): the step's Go to names the field; the Runed Scroll drops from Aean
// Swiftriver at 46,70, south-east of it.
const FIELD: &str = r#"
	Polestar.RegisterGuide({ id = "test/fog", pack = "test", title = "Southern Barrens", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Field of Giants", goals = {
			{ t = "goto", map = 1429, x = 44.7, y = 70.7, text = "Field of Giants" },
			{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, optional = true, map = 1429, x = 46.0, y = 70.0, note = "Aean Swiftriver" },
			{ t = "accept", quest = 3513, title = "The Runed Scroll", item = 10621, itemName = "Runed Scroll", optional = true },
			{ t = "accept", quest = 79192, title = "The Burned-Out Remains", object = 600001, objName = "Burned-Out Remains", map = 1429, x = 46.3, y = 73.9 },
		} },
		{ title = "Camp", goals = {
			{ t = "goto", map = 1429, x = 30, y = 30, text = "Camp" },
			{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1 },
		} },
		{ goals = { { t = "level", level = 60 } } },
	} })
"#;

#[test]
fn the_arrow_leads_to_the_current_goal_s_own_place_the_step_s_go_to_only_when_that_goal_has_none() {
	let out = run(
		FIELD,
		"w.onQuest(7, { 10 }); w.moveTo(1429, 40, 60)",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/fog" }"#),
		r#"
			local r = {}
			local wp = E.GetWaypoint()
			r.first = { wp.goalIndex, wp.x, wp.y }
			r.current = E.GetStepView(1).current
			-- At Aean Swiftriver: the field is reached, though not its centre.
			stub.world.moveTo(1429, 46.0, 70.0); stub.advance(1)
			r.header = E.GetStepView(1).goals[1].status
			E.SkipGoal(1, 2); flush()
			r.afterSkip = { E.GetWaypoint().goalIndex, E.GetStepView(1).current }
			r.paired = E.GetStepView(1).goals[3].dismissed or false
			E.Goto(2); flush()
			r.noPlace = { E.GetWaypoint().goalIndex, E.GetStepView(2).current }
			emit(r)
		"#,
	);
	assert_eq!(out["first"], json!([2, 46, 70]), "the Runed Scroll at Aean Swiftriver, not the field's centre");
	assert_eq!(out["current"], 2);
	assert_eq!(out["header"], "done", "reaching the scroll's place reaches the field");
	assert_eq!(out["afterSkip"], json!([4, 4]), "scroll skipped: the Burned-Out Remains");
	assert_eq!(out["paired"], true, "the scroll's quest skips with it: one thing to do");
	assert_eq!(out["noPlace"], json!([1, 2]), "the kobolds have no place: the camp's Go to");
}

const SPOTS: &str = r#"
		Polestar.RegisterGuide({ id = "test/sp", pack = "test", title = "Spots", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Hills", goals = {
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 20, y = 50,
					spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 25, y = 50, r = 30, n = 2 } } },
				{ t = "collect", item = 5058, itemName = "Silithid Egg", count = 12, quest = 868, oi = 1, map = 1429, x = 60, y = 50, spread = true,
					spots = { { x = 60, y = 50, r = 30, n = 3 }, { x = 70, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#;

#[test]
fn choosing_the_next_spot_of_a_goal_the_arrow_is_not_on_moves_the_arrow_to_that_spot() {
	let out = run(
		SPOTS,
		"w.onQuest(7, { 10 }); w.onQuest(868, { 12 }); w.moveTo(1429, 20, 50)",
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/sp" }"#),
		r#"
			local before = E.GetWaypoint().goalIndex
			E.CycleSpot(1, 2, 3)
			local wp = E.GetWaypoint()
			emit({ before = before, after = { wp.goalIndex, wp.x, wp.spot } })
		"#,
	);
	assert_eq!(out["before"], 1);
	assert_eq!(out["after"], json!([2, 80, 3]));
}

#[test]
fn the_next_spot_reaches_the_arrow_itself_engine_and_nav_together_over_a_point_picked_by_hand_too() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}; w.onQuest(7, {{ 10 }}); w.onQuest(868, {{ 12 }}); w.moveTo(1429, 20, 50)"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/sp" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			SPOTS,
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"			local Nav = Polestar.Nav
			local r = { first = Nav.GetTarget().x }
			-- The eggs' next spot, from the row's button: the arrow goes there.
			E.CycleSpot(1, 2, 2); flush()
			r.cycled = { Nav.GetTarget().x, Nav.GetTarget().goalIndex }
			-- A click on the arrow walks on to the eggs' next spot.
			Nav.NextSpot(); flush()
			r.arrow = Nav.GetTarget().x
			-- A point picked by hand holds until the window lets it go.
			Nav.SetTarget(1429, 10, 10, "By hand")
			E.CycleSpot(1, 2, 2); flush()
			r.held = Nav.GetTarget().label
			Nav.ReleaseTarget()
			r.released = Nav.GetTarget().x
			emit(r)"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "first": 20, "cycled": [70, 2], "arrow": 80, "held": "By hand", "released": 70 }));
}

#[test]
fn a_spawn_spot_holds_while_the_player_is_on_another_continent_and_is_picked_afresh_from_where_they_stand_at_the_step_start() {
	const GUIDE: &str = r#"
		Polestar.RegisterGuide({ id = "test/sc", pack = "test", title = "Spots", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 5, title = "First", npc = 1, map = 1429, x = 10, y = 50 } } },
			{ title = "Hills", goals = {
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 20, y = 50,
					spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 60, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	"#;
	let out = run(
		GUIDE,
		r#"w.addMap(1411, { name = "Durotar", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 }); w.onQuest(7, { 10 }); w.moveTo(1411, 50, 50)"#,
		Some(r#"PolestarCharDB = { schema = 1, guide = "test/sc" }"#),
		r#"
			local r = {}
			E.GetStepView(2) -- shown ahead ("Then:"): its spot is picked from Durotar
			stub.world.moveTo(1429, 80, 50)
			stub.world.accept(5, {}); flush()
			r.start = E.GetWaypoint().x -- the step starts: picked from where the player stands
			stub.world.moveTo(1411, 50, 50)
			local seen = {}
			for i = 1, 4 do stub.advance(0.6); seen[i] = E.GetWaypoint().x end
			r.away = seen
			emit(r)
		"#,
	);
	assert_eq!(out["start"], 80);
	assert_eq!(out["away"], json!([80, 80, 80, 80]));
}

// #221: a turn-in in a step of its own after an `optional` accept (Croaky's Head: the head drops on the murloc
// shore, Merell Ross takes it at Ridgepoint Tower). It holds only a player who took the quest: one who never
// did passes the step, one who has it in the log is led to the ender, and one who already handed it in finds
// the step done.
const OPTIONAL_TAKE: &str = r#"
	Polestar.RegisterGuide({ id = "test/optional", pack = "test", title = "Optional", minLevel = 1, maxLevel = 20, steps = {
		{ title = "Murlocs", goals = {
			{ t = "collect", item = 780, itemName = "Torn Murloc Fin", count = 8, quest = 46, oi = 1, map = 1429, x = 76.5, y = 79.7 },
			{ t = "accept", quest = 91740, title = "Croaky's Head", item = 247826, itemName = "Croaky's Head", optional = true },
		} },
		{ title = "Ridgepoint Tower", goals = {
			{ t = "turnin", quest = 91740, title = "Croaky's Head", npc = 248277, npcName = "Merell Ross", map = 1429, x = 84.75, y = 79.3 },
		} },
		{ title = "Guard Thomas", goals = {
			{ t = "turnin", quest = 46, title = "Bounty on Murlocs", npc = 261, npcName = "Guard Thomas", map = 1429, x = 74.0, y = 72.2 },
		} },
	} })"#;

const OPTIONAL_SCRIPT: &str = r#"
			local r = { start = E.GetStepIndex() }
			@ACCEPT@
			stub.world.finish(46); flush()
			local wp = E.GetWaypoint()
			r.at, r.ridgepoint = E.GetStepIndex(), E.GetStepView(2).goals[1].status
			r.wp = wp and { wp.stepIndex, wp.map, wp.x, wp.y } or false
			@TURNIN@
			emit(r)
		"#;

fn optional_take(take: &str) -> Value {
	let taken = take == "taken";
	let before = format!("w.onQuest(46, {{ 8 }}){}", if take == "done" { "; w.complete({ 91740 })" } else { "" });
	let script = OPTIONAL_SCRIPT
		.replace("@ACCEPT@", if taken { "stub.world.accept(91740, {}); flush()" } else { "" })
		.replace("@TURNIN@", if taken { "stub.world.turnIn(91740); flush(); r.after = E.GetStepIndex()" } else { "" });
	run(OPTIONAL_TAKE, &before, Some(r#"PolestarCharDB = { schema = 1, guide = "test/optional" }"#), &script)
}

#[test]
fn t_221_a_turn_in_after_an_optional_accept_the_player_never_took_no_longer_holds_the_guide() {
	let out = optional_take("no");
	assert_eq!(out["start"], 1);
	assert_eq!(out["ridgepoint"], "na", "the turn-in is not this player's");
	assert_eq!(out["at"], 3, "Ridgepoint Tower is passed: on to Guard Thomas");
	assert_eq!(out["wp"], json!([3, 1429, 74, 72.2]));
}

#[test]
fn t_221_a_turn_in_after_an_optional_accept_holds_a_player_who_took_the_quest_and_the_arrow_leads_to_the_ender() {
	let out = optional_take("taken");
	assert_eq!(out["at"], 2, "Ridgepoint Tower holds with the quest in the log");
	assert_eq!(out["ridgepoint"], "active");
	assert_eq!(out["wp"], json!([2, 1429, 84.75, 79.3]), "the arrow leads to Merell Ross");
	assert_eq!(out["after"], 3, "handed in: on to Guard Thomas");
}

#[test]
fn t_221_a_turn_in_after_an_optional_accept_is_done_for_a_player_who_already_handed_the_quest_in() {
	let out = optional_take("done");
	assert_eq!(out["ridgepoint"], "done");
	assert_eq!(out["at"], 3);
}
