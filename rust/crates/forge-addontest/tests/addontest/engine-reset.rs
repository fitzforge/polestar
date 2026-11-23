//! Reset guide progress (Engine.ResetProgress, addon/Polestar/Core/Engine.lua) mid-guide (#1764): the reset
//! clears the player's check-offs and skips from where the game shows them to be (the last step with quest
//! progress, anchorStep) on, and keeps the ones behind it. Before, it cleared them all and placed the guide
//! again: a step skipped long ago, its quest never taken and still open to take, became the guide's start and
//! the guide went back there (the Barrens' Crossroads step from step 86). Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.level = 19
"#;

// 1 accept 7 · 2 accept 33 (skipped, never taken) · 3 walk (ticked) · 4 kill 10 vermin for 7 · 5 hand in 7 ·
// 6 accept 15 (skipped, never taken) · 7 walk (ticked) · 8 accept 783
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/reset", pack = "test", title = "Reset", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Wolves", goals = { { t = "accept", quest = 33, title = "Wolves Across the Border", npc = 196, map = 1429, x = 40, y = 40 } } },
		{ title = "Walk", goals = { { t = "goto", map = 1429, x = 30, y = 30, text = "Walk" } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Back to McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Echo Ridge", goals = { { t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Walk on", goals = { { t = "goto", map = 1429, x = 20, y = 20, text = "Walk on" } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, map = 1429, x = 48.2, y = 42.0 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- The live step, the saved step skips and check-offs.
function state()
	local st = Polestar.CharState()
	local sk, m = {}, {}
	for k in pairs(st.skipped["test/reset"] or {}) do sk[#sk + 1] = tostring(k) end
	for k in pairs(st.manual["test/reset"] or {}) do m[#m + 1] = tostring(k) end
	table.sort(sk); table.sort(m)
	return { live = E.GetLiveStep(), skipped = table.concat(sk, " "), manual = table.concat(m, " ") }
end
"#;

fn run(script: &str) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/reset" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	}))
}

// Played to step 8: Wolves and Echo Ridge skipped (their quests never taken), both walks ticked by hand,
// Kobold Camp Cleanup done and handed in (step 5: the game's own progress).
const PLAYED: &str = r#"
	local w = stub.world
	w.accept(7, { 10 }); flush()                   -- live 2
	E.Skip(); flush()                              -- Wolves skipped: live 3
	E.ToggleGoal(3, 1); flush()                    -- the walk ticked: live 4
	w.progress(7, 1, 10); flush()                  -- live 5
	w.turnIn(7); flush()                           -- live 6
	E.Skip(); flush()                              -- Echo Ridge skipped: live 7
	E.ToggleGoal(7, 1); flush()                    -- live 8
"#;

#[test]
fn issue_1764_a_reset_keeps_the_skips_and_ticks_behind_the_last_quest_progress_and_clears_the_rest() {
	let out = run(&format!(
		r#"{PLAYED}
		emit(state())
		E.ResetProgress(); flush(); stub.advance(11)
		emit(state())"#
	));
	assert_eq!(out[0], json!({ "live": 8, "skipped": "2 6", "manual": "3:1 7:1" }));
	// Wolves (step 2) stays skipped and the first walk ticked: they are behind the hand-in of Kobold Camp
	// Cleanup (step 5). Echo Ridge and the second walk, past it, come back: the guide is at Echo Ridge, not at
	// Wolves.
	assert_eq!(out[1], json!({ "live": 6, "skipped": "2", "manual": "3:1" }));
}

#[test]
fn issue_1764_after_a_reset_a_step_skipped_behind_the_progress_comes_back_from_the_step_list() {
	let out = run(&format!(
		r#"{PLAYED}
		E.ResetProgress(); flush(); stub.advance(11)
		E.Goto(2); flush()
		emit(state())"#
	));
	assert_eq!(out[0], json!({ "live": 2, "skipped": "", "manual": "3:1" }), "Goto opens the skipped step again");
}
