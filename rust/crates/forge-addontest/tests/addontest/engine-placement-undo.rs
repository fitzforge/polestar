//! Placement's preview and undo. When a guide is placed (Own.mergeEarlier, place), the engine keeps what placement
//! marked apart from the player's own marks (CharState().placementUndo): the check-offs and skips it wrote and the quests
//! it listed as skipped earlier (#86). Engine.PlacementReport and Engine.PlacementLine say what it marked,
//! Engine.UndoPlacement takes exactly that back (the player's own marks stay) and leaves the guide unplaced, also when
//! it is loaded again, until Engine.RedoPlacement. Reset progress clears the record. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// A level-20 Human; Grey done (101) is handed in, Grey not done (102) was never taken.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 20
w.complete({ 101 })
"#;

// 1 accept 101 (done) · 2 a trip · 3 accept 102 (never taken) · 4 hand-ins · 5 and 6 trips on. With 101 handed in,
// placement starts at step 5: it passes the trip to the farm and the quest 102, listed as skipped earlier.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/low", pack = "test", title = "Low", faction = "Alliance", minLevel = 1, maxLevel = 30, steps = {
	{ goals = { { t = "accept", quest = 101, title = "Grey done", qlvl = 5 } } },
	{ goals = { { t = "goto", map = 1429, x = 10, y = 10, label = "Farm" } } },
	{ goals = { { t = "accept", quest = 102, title = "Grey not done", qlvl = 6 } } },
	{ goals = { { t = "turnin", quest = 102, title = "Grey not done" }, { t = "turnin", quest = 101, title = "Grey done" } } },
	{ goals = { { t = "goto", map = 1429, x = 20, y = 20, label = "Town" } } },
	{ goals = { { t = "goto", map = 1429, x = 30, y = 30, label = "Camp" } } },
} })
"#;

const SETUP: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- Saved marks of the guide, as their keys in one string.
function marks(field)
	local out = {}
	for k in pairs(Polestar.CharState()[field]["test/low"] or {}) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return table.concat(out, " ")
end
function snapshot()
	return { at = E.GetStepIndex(), manual = marks("manual"), earlier = marks("earlier"), listed = #E.SkippedEarlier() }
end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
"#;

// No catch-up and no guide picked at login: placement alone moves the player.
const SAVED: &str = r#"PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false, autoSelectGuide = false } } }; PolestarCharDB = nil"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), SAVED.into())],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{SETUP}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_report_names_what_placement_marked_done_and_skipped() {
	let out = run(r#"
		E.SetGuide("test/low"); flush()
		local r = E.PlacementReport()
		local steps, quests = {}, {}
		for _, s in ipairs(r.steps) do steps[#steps + 1] = s.index end
		for _, q in ipairs(r.quests) do quests[#quests + 1] = q.quest end
		emit({ at = E.GetStepIndex(), steps = steps, quests = quests, line = E.PlacementLine() })"#);
	assert_eq!(out["at"], 5, "{out}");
	assert_eq!(out["steps"], json!([2]), "the trip to the farm is marked done: {out}");
	assert_eq!(out["quests"], json!([102]), "the quest never taken is listed as skipped earlier: {out}");
	assert_eq!(out["line"], "Placed you at step 5: 1 step marked done, 1 quest skipped earlier.", "{out}");
}

#[test]
fn undo_takes_back_what_placement_marked_and_nothing_the_player_did() {
	let out = run(r#"
		E.SetGuide("test/low"); flush()
		E.ToggleGoal(5, 1); flush()                  -- the player's own tick, after placement
		local placed = snapshot()
		local undone = E.UndoPlacement(); flush()
		emit({ placed = placed, undone = undone, after = snapshot(), report = E.PlacementReport() or false,
			record = Polestar.CharState().placementUndo["test/low"] })"#);
	assert_eq!(out["placed"], json!({ "at": 6, "manual": "2:1 5:1", "earlier": "102", "listed": 1 }), "{out}");
	assert_eq!(out["undone"], true);
	// Back at the trip: placement's tick and list are gone, the player's own tick of step 5 stays.
	assert_eq!(out["after"], json!({ "at": 2, "manual": "5:1", "earlier": "", "listed": 0 }), "{out}");
	assert_eq!(out["report"], false, "nothing is left to report");
	assert_eq!(out["record"], json!({ "undone": true }));
}

#[test]
fn an_undone_guide_is_not_placed_again_when_it_is_loaded_again_until_redo() {
	let out = run(r#"
		E.SetGuide("test/low"); flush()
		E.UndoPlacement(); flush()
		E.SetGuide(nil); flush(); E.SetGuide("test/low"); flush(); stub.advance(11)
		local loaded = snapshot()
		local redone = E.RedoPlacement(); flush()
		emit({ loaded = loaded, redone = redone, after = snapshot(), again = E.RedoPlacement(), undoneAgain = E.UndoPlacement() })"#);
	assert_eq!(out["loaded"], json!({ "at": 2, "manual": "", "earlier": "", "listed": 0 }), "{out}");
	assert_eq!(out["redone"], true);
	assert_eq!(out["after"], json!({ "at": 5, "manual": "2:1", "earlier": "102", "listed": 1 }), "{out}");
	assert_eq!(out["again"], false, "a guide that is placed has nothing to redo");
	assert_eq!(out["undoneAgain"], true, "the placement can be undone once more");
}

#[test]
fn a_second_undo_and_the_report_of_an_undone_guide_have_nothing_to_give() {
	let out = run(r#"
		E.SetGuide("test/low"); flush()
		local first = E.UndoPlacement(); flush()
		emit({ first = first, second = E.UndoPlacement(), line = E.PlacementLine() or false })"#);
	assert_eq!(out, json!({ "first": true, "second": false, "line": false }), "{out}");
}

#[test]
fn reset_progress_clears_the_record_and_places_the_guide_again() {
	let out = run(r#"
		E.SetGuide("test/low"); flush()
		E.UndoPlacement(); flush()
		E.ResetProgress(); flush(); stub.advance(11)
		emit({ after = snapshot(), record = Polestar.CharState().placementUndo["test/low"] ~= nil })"#);
	assert_eq!(out["after"]["at"], 5, "reset placed the guide again: {out}");
	assert_eq!(out["record"], true, "and recorded that placement afresh: {out}");
}

// The full addon: the window's banner says what placement marked and offers the undo, then the way back.
fn run_window(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), SAVED.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			r#"E = Polestar.Engine; GF = Polestar.UI.GuideFrame; function flush() stub.advance(0.5) end"#,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_banner_offers_the_undo_and_then_the_way_to_place_the_guide_again() {
	let out = run_window(
		r#"
		E.SetGuide("test/low"); stub.advance(3)
		local placed = GF.BannerNotice()
		GF.TakeBanner(); flush()
		local undone, at = GF.BannerNotice(), E.GetStepIndex()
		GF.TakeBanner(); flush()
		emit({ placed = placed, undone = undone, at = at, again = GF.BannerNotice(), back = E.GetStepIndex() })"#,
	);
	assert_eq!(out, json!({ "placed": "placed", "undone": "unplaced", "at": 2, "again": "placed", "back": 5 }), "{out}");
}

#[test]
fn the_placement_command_lists_what_was_marked_and_undoes_it() {
	let out = run_window(
		r#"
		E.SetGuide("test/low"); stub.advance(3)
		local from = #stub.messages
		SlashCmdList.POLESTAR("placement")
		local shown = table.concat(stub.messages, "\n", from + 1)
		SlashCmdList.POLESTAR("placement undo"); flush()
		local undone = E.GetStepIndex()
		from = #stub.messages
		SlashCmdList.POLESTAR("placement")
		emit({ shown = shown, undone = undone, empty = table.concat(stub.messages, "\n", from + 1) })"#,
	);
	let shown = out["shown"].as_str().unwrap_or("");
	assert!(shown.contains("Placed you at step 5:") && shown.contains("1 quest skipped earlier."), "{out}");
	assert!(shown.contains("Skipped earlier: “Grey not done”"), "{out}");
	assert_eq!(out["undone"], 2, "{out}");
	assert!(out["empty"].as_str().unwrap_or("").contains("Placement marked nothing in this guide."), "{out}");
}
