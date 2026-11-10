//! Undoing a step skip undoes what the skip stored on the way (addon/Polestar/Core/Engine.lua, Own.skipStore and
//! Own.skipRestore; docs/ARCHITECTURE.md, "Navigation"). A Skip moves the live step past more steps than the one
//! skipped, and the route stores what it finds there: a passed step's `when` outcome (failed: as a skip) and the
//! `skipto` jumps taken. Before, Unskip cleared only the skipped step, so a step passed at level 19 for
//! `when level>=20` stayed passed at 20, and a jump taken because of the skip stayed taken. A feeder step's skip
//! also left its quests in CharState().feedSkips for good. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.level = 19
"#;

// 1 accept 7 · 2 walk · 3 only from level 20: accept 33 · 4 accept 783, jump to "end" holding a candle ·
// 5 accept 15 · 6 "end": kill 10 vermin for 7 · 7 hand in 7
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/undo", pack = "test", title = "Undo", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Walk", goals = { { t = "goto", map = 1429, x = 30, y = 30, text = "Walk" } } },
		{ title = "At 20", when = { { k = "level", op = ">=", n = 20 } }, goals = { { t = "accept", quest = 33, title = "Wolves", npc = 196, map = 1429, x = 40, y = 40 } } },
		{ title = "Willem", skipto = { { to = "end", when = { k = "has", item = 750, n = 1 } } },
			goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Echo Ridge", goals = { { t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds", label = "end", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Back to McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The saved skips and `when` outcomes of steps 1-7 ("-" where none), and the live step.
function state()
	local st = Polestar.CharState()
	local sk, held = st.skipped["test/undo"] or {}, st.when["test/undo"] or {}
	local a, b = {}, {}
	for s = 1, 7 do
		a[#a + 1] = sk[s] == nil and "-" or tostring(sk[s])
		b[#b + 1] = held[s] == nil and "-" or tostring(held[s])
	end
	return { live = E.GetLiveStep(), skipped = table.concat(a, " "), when = table.concat(b, " ") }
end
"#;

fn run(script: &str) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/undo" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	}))
}

#[test]
fn undoing_a_skip_forgets_the_when_outcome_it_stored_so_a_level_gated_step_comes_back_at_the_level() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		emit(state())                                  -- live 2 (Walk)
		E.Skip(); flush()
		emit(state())                                  -- 2 skipped, 3 passed at 19 (stored failed), live 4
		E.Unskip(2); flush()
		emit(state())                                  -- back on 2, step 3's outcome gone with the skip
		w.setLevel(20); flush()
		E.ToggleGoal(2, 1); flush()
		emit(state())                                  -- level 20 before the route reaches step 3: it applies
		emit(Polestar.CharState().skipStored == nil)"#);
	assert_eq!(out[0], json!({ "live": 2, "skipped": "- - - - - - -", "when": "- - - - - - -" }));
	assert_eq!(out[1], json!({ "live": 4, "skipped": "- true true - - - -", "when": "- - - - - - -" }));
	assert_eq!(out[2], json!({ "live": 2, "skipped": "- - - - - - -", "when": "- - - - - - -" }), "the undo takes step 3's stored outcome back");
	assert_eq!(out[3]["live"], 3, "At 20 is the live step at level 20");
	assert_eq!(out[4], true, "nothing left to undo");
}

#[test]
fn undoing_a_skip_takes_back_the_jump_it_led_to() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); w.addItem(750, 1); flush()
		E.Skip(); flush()
		emit(state())                                  -- the route reaches Willem holding the candle: jumps to "end"
		E.Unskip(2); flush()
		emit(state())
		w.removeItem(750); E.ToggleGoal(2, 1); flush()
		emit(state())                                  -- no candle now: Willem is the live step, no jump"#);
	assert_eq!(out[0], json!({ "live": 6, "skipped": "- true true jump jump - -", "when": "- - - - - - -" }));
	assert_eq!(out[1], json!({ "live": 2, "skipped": "- - - - - - -", "when": "- - - - - - -" }));
	assert_eq!(out[2]["live"], 4);
	assert_eq!(out[2]["skipped"], "- - true - - - -", "step 3 passed again at 19, stored as the route passes it");
}

#[test]
fn a_step_the_player_brought_back_meanwhile_stays_when_the_skip_is_undone() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.Skip(); flush()                              -- 2 skipped, 3 stored failed
		E.Unskip(3); flush()                           -- the player brings step 3 back: kept for good
		E.Unskip(2); flush()
		emit(state())"#);
	assert_eq!(out[0], json!({ "live": 2, "skipped": "- - - - - - -", "when": "- - true - - - -" }), "step 3 kept (Own.keep)");
}

#[test]
fn undoing_a_feeder_step_s_skip_brings_its_quests_back_into_the_feeder_plan() {
	let out = run(r#"
		local st = Polestar.CharState()
		st.feedSkips = { [99] = true }                 -- an earlier feeder skip, not this one's
		E.GetGuide().steps[1].feeder = "test/before"
		E.Skip(); flush()
		local during = st.feedSkips[7]
		E.Unskip(1); flush()
		emit({ during = during, after = st.feedSkips and st.feedSkips[7] or false, other = st.feedSkips and st.feedSkips[99] or false })"#);
	assert_eq!(out[0], json!({ "during": true, "after": false, "other": true }));
}

#[test]
fn goto_on_a_skipped_step_undoes_its_skip_the_same_way() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.Skip(); flush()
		E.Goto(2); flush()
		emit(state())"#);
	assert_eq!(out[0], json!({ "live": 2, "skipped": "- - - - - - -", "when": "- - - - - - -" }));
}
