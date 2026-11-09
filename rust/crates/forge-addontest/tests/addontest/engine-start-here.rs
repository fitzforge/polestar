//! Start from here (addon/Polestar/Core/Engine.lua, Engine.StartHereOffer, Engine.StartHere, Engine.UndoStartHere;
//! docs/ARCHITECTURE.md, "Navigation"). A player looking ahead at a step makes it the guide's step: the open steps
//! from the live step up to it are skipped as "here", with one exact undo. From a player in Loch Modan: "how do I
//! start the guide from a particular position". Guards: steps that only read done for a while (a level, a lost
//! quest) are skipped too, so the guide never jumps back before the start; quests in the log whose work is only in
//! the skipped steps are pinned; a step that would lose its own quest offers the step it comes from instead; a start
//! the guide would not land on (a `skipto` jumping past it) is refused; feeder quests leave the plan and come back
//! with the undo; SkippedOut sees "here".

use crate::loch_modan::{run_as, AT_THE_TUNNEL};
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// 1 accept 7 and 47 (timed) · 2 walk · 3 only from level 20 · 4 accept 15 (level 20) · 5 "willem": accept 783,
// jump to "end" holding a candle · 6 accept 18, kill for 47 · 7 "end": kill 10 vermin for 7 · 8 only once
// "willem" is done: accept 21 · 9 hand in 7
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 },
			{ t = "accept", quest = 47, title = "Gold Dust Exchange", npc = 241, map = 1429, x = 48.9, y = 41.6, limit = 900 },
		} },
		{ title = "Walk", goals = { { t = "goto", map = 1429, x = 30, y = 30, text = "Walk" } } },
		{ title = "At 20", when = { { k = "level", op = ">=", n = 20 } }, goals = { { t = "accept", quest = 33, title = "Wolves", npc = 196, map = 1429, x = 40, y = 40 } } },
		{ title = "Gated", goals = { { t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, map = 1429, x = 48.9, y = 41.6, minLevel = 20 } } },
		{ title = "Willem", label = "willem", skipto = { { to = "end", when = { k = "has", item = 750, n = 1 } } },
			goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Echo Ridge", goals = {
			{ t = "accept", quest = 18, title = "Brotherhood of Thieves", npc = 823, map = 1429, x = 48.2, y = 42.0 },
			{ t = "kill", target = "Kobold Miner", npc = 40, count = 8, quest = 47, oi = 1, map = 1429, x = 40, y = 80 },
		} },
		{ title = "Kobolds", label = "end", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "If Willem", when = { { k = "done", label = "willem" } }, goals = { { t = "accept", quest = 21, title = "Skirmish", npc = 823, map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Back to McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
-- The saved skips and `when` outcomes of steps 1-9 ("-" where none), the live step and the one on screen.
function state()
	local st = Polestar.CharState()
	local sk, held = st.skipped["test/here"] or {}, st.when["test/here"] or {}
	local a, b = {}, {}
	for s = 1, 9 do
		a[#a + 1] = sk[s] == nil and "-" or tostring(sk[s])
		b[#b + 1] = held[s] == nil and "-" or tostring(held[s])
	end
	return { live = E.GetLiveStep() or false, view = E.GetStepIndex() or false, skipped = table.concat(a, " "), when = table.concat(b, " ") }
end
started = nil
Polestar.On("PLAYER_STARTED_HERE", function(id, from, to, count) started = { from, to, count } end)
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: "local w = stub.world\nw.addMap(1429, { name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })\nw.moveTo(1429, 48, 42)\nw.level = 19".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			// McBride's two quests taken: the live step is the walk.
			"w.accept(7, { 10 }); w.accept(47, { 8 }); flush()",
			script,
		]
		.join("\n"),
		..Default::default()
	})
}

#[test]
fn start_from_here_skips_the_open_steps_before_the_step_on_screen_and_its_undo_takes_back_all_it_did() {
	let out = run(r#"
		E.Goto(7); flush()
		local o = E.StartHereOffer()
		emit({ refuse = o.refuse or false, steps = o.steps, inLog = o.inLog })
		emit({ E.StartHere(), started })
		emit(state())
		emit({ pinned = E.IsPinned(47) })
		w.setLevel(20); flush()
		emit(state())                                  -- the level-up brings nothing back before the start
		emit(E.UndoStartHere())
		flush()
		emit(state())
		emit({ pinned = E.IsPinned(47), record = Polestar.CharState().startedHere or false })
		E.ToggleGoal(2, 1); flush()
		emit(state())                                  -- at 20 now, At 20 applies: its stored outcome went with the undo"#);
	assert_eq!(out[0]["refuse"], false);
	assert_eq!(out[0]["steps"], json!([2, 4, 5, 6]), "Walk, the level-gated accept, Willem and Echo Ridge; At 20 does not apply at 19");
	assert_eq!(out[0]["inLog"], json!([{ "id": 47, "title": "Gold Dust Exchange", "timed": true }]), "47's kills are only in Echo Ridge");
	assert_eq!(out[1], json!([true, [2, 7, 4]]));
	assert_eq!(out[2], json!({ "live": 7, "view": 7, "skipped": "- here true here here here - - -", "when": "- - - - - - - - -" }));
	assert_eq!(out[3], json!({ "pinned": true }), "47 stays along the way");
	assert_eq!(out[4]["live"], 7, "no jump back to the level-gated accept or At 20");
	assert_eq!(out[5], true);
	assert_eq!(out[6], json!({ "live": 2, "view": 2, "skipped": "- - - - - - - - -", "when": "- - - - - - - - -" }));
	assert_eq!(out[7], json!({ "pinned": false, "record": false }));
	assert_eq!(out[8]["live"], 3);
}

#[test]
fn a_step_brought_back_one_by_one_stays_when_the_start_is_undone() {
	let out = run(r#"
		E.Goto(7); flush()
		E.StartHere(); flush()
		E.Unskip(6); flush()
		emit(state())
		E.UndoStartHere(); flush()
		emit(state())"#);
	assert_eq!(out[0]["live"], 6);
	assert_eq!(out[1], json!({ "live": 2, "view": 2, "skipped": "- - - - - - - - -", "when": "- - - - - - - - -" }));
}

#[test]
fn a_start_the_guide_would_jump_past_is_refused_and_changes_nothing() {
	let out = run(r#"
		w.addItem(750, 1)
		E.Goto(5); flush()
		local o = E.StartHereOffer()
		local ok, why = E.StartHere()
		emit({ refuse = o.refuse or false, ok = ok, why = why or false, state = state() })"#);
	assert_eq!(
		out[0],
		json!({ "refuse": "live", "ok": false, "why": "live", "state": { "live": 2, "view": 5, "skipped": "- - - - - - - - -", "when": "- - - - - - - - -" } }),
		"Willem jumps to Kobolds with the candle in the bags: the guide would not land on it"
	);
}

#[test]
fn a_labelled_step_skipped_by_the_start_is_not_done_for_a_later_when_done() {
	let out = run(r#"
		E.Goto(7); flush()
		E.StartHere(); flush()
		emit(E.GetStepView(8).status)"#);
	assert_eq!(out[0], "na");
}

#[test]
fn a_feeder_step_in_the_range_leaves_the_feeder_plan_and_the_undo_brings_it_back() {
	let out = run(r#"
		local st = Polestar.CharState()
		E.GetGuide().steps[6].feeder = "test/before"
		E.Goto(7); flush()
		E.StartHere(); flush()
		local during = st.feedSkips and st.feedSkips[18] or false
		E.UndoStartHere(); flush()
		emit({ during = during, after = st.feedSkips and st.feedSkips[18] or false })"#);
	assert_eq!(out[0], json!({ "during": true, "after": false }));
}

#[test]
fn not_offered_on_the_live_step_looking_back_or_with_a_lost_quest_question_pending() {
	let out = run(r#"
		local live = E.StartHereOffer() or false
		Polestar.CharState().lostQuests = { ["test/here"] = { [783] = 9 } }
		E.Goto(7); flush()
		emit({ live = live, lost = E.StartHereOffer() or false })"#);
	assert_eq!(out[0], json!({ "live": false, "lost": false }));
}

// A Class guide (Call of Water's shape, #1372): the start from the last Brine would leave the chain without its
// quests (refused: their accept is the live step's), and a step skipped as "here" that the rest follows from
// is no completion.
#[test]
fn in_a_class_guide_a_start_that_empties_the_chain_is_refused_and_skipped_out_sees_here() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: "local w = stub.world\nw.addMap(1413, { name = \"The Barrens\", c = 1, left = 2000, right = -4000, top = 1000, bottom = -5000 })\nw.race, w.raceName, w.class, w.className, w.faction, w.level = \"Orc\", \"Orc\", \"SHAMAN\", \"Shaman\", \"Horde\", 21\nw.moveTo(1413, 43.4, 77.4)\nw.onQuest(1530, {}, \"Call of Water\")".into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/water" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			r#"
local function brine(t, q, extra)
	local g = { t = t, quest = q, title = "Call of Water", npc = 5899, map = 1413, x = 43.42, y = 77.41 }
	for k, v in pairs(extra or {}) do g[k] = v end
	return g
end
Polestar.RegisterGuide({ id = "test/water", pack = "test", title = "Call of Water", category = "Class", classes = { "SHAMAN" }, faction = "Horde", minLevel = 20, maxLevel = 23, steps = {
	{ title = "Islen", goals = { { t = "accept", quest = 1530, title = "Call of Water", npc = 5901, map = 1413, x = 65.8, y = 43.8 } } },
	{ title = "Brine", goals = { brine("turnin", 1530), brine("accept", 1535, { pre = { 1530 } }) } },
	{ title = "Watering Hole", goals = { { t = "collect", item = 7769, count = 1, quest = 1535, oi = 1, title = "Call of Water", map = 1413, x = 44.3, y = 76.8 } } },
	{ title = "Brine again", goals = { brine("turnin", 1535), brine("accept", 1536, { pre = { 1535 } }) } },
	{ title = "Brine last", goals = { brine("turnin", 1536) } },
} })
E = Polestar.Engine
completed = false
Polestar.On("GUIDE_COMPLETED", function() completed = true end)"#,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"
local live = E.GetLiveStep()
E.Goto(5); stub.advance(0.25)
local o = E.StartHereOffer()
emit({ live = live, refuse = o and o.refuse or false, ok = E.StartHere() })
E.Goto(live); stub.advance(0.25)
Polestar.CharState().skipped["test/water"] = { [2] = "here" }
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
local out = E.SkippedOut()
emit({ live = E.GetLiveStep() or false, out = out and out.step or false, completed = completed })"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 2, "refuse": "lost", "ok": false }));
	assert_eq!(out[1], json!({ "live": false, "out": 2, "completed": false }));
}

// The player's case (Loch Modan, a Dwarf): the guide at "Into Dun Morogh", 244 taken at Three Corners, the player
// at Deputy Feldon looking at Lakeridge Highway. Start from here makes it the guide's step: the step key and auto
// accept act on it (they act on the live step only), 301 for Ironforge is pinned. Without 244, Lakeridge Highway
// would lose its hand-in and 246: the offer is Three Corners instead.
#[test]
fn the_dwarf_starts_from_lakeridge_highway_and_auto_accept_follows() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TUNNEL}
local w = stub.world
w.accept(244, {{}}); flush()
walk(step("Lakeridge Highway"), "turnin")
E.Goto(step("Lakeridge Highway")); flush()
local wanted = E.WantsQuest("accept", 246)
local o = E.StartHereOffer()
emit({{ live(), view(), o and (o.refuse or o.instead) or false, wanted }})
emit({{ E.StartHere(), live(), view(), E.WantsQuest("accept", 246), E.IsPinned(301) }})
emit(skips())
E.UndoStartHere(); flush()
emit({{ live(), skips(), E.IsPinned(301) }})"#
		),
	) else {
		return;
	};
	assert_eq!(out[0], json!(["Into Dun Morogh", "Lakeridge Highway", false, false]));
	assert_eq!(out[1], json!([true, "Lakeridge Highway", "Lakeridge Highway", true, true]));
	assert_eq!(out[2], json!("Into Dun Morogh=here, Into Ironforge=here, Ironforge=here, Tram to Stormwind=here, Elwynn Forest=here"));
	assert_eq!(out[3], json!(["Into Dun Morogh", "", false]));
}

#[test]
fn the_dwarf_without_three_corners_quest_is_offered_three_corners_instead() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TUNNEL}
walk(step("Lakeridge Highway"), "turnin")
E.Goto(step("Lakeridge Highway")); flush()
local o = E.StartHereOffer()
local lost = {{}}
for _, e in ipairs(o.lost or {{}}) do lost[#lost + 1] = e.quest end
emit({{ title(o.instead), lost }})
emit({{ E.StartHere(), live() }})"#
		),
	) else {
		return;
	};
	assert_eq!(out[0][0], "Three Corners");
	assert!(out[0][1].as_array().unwrap().contains(&json!(244)), "{}", out[0]);
	assert_eq!(out[1], json!([true, "Three Corners"]));
}
