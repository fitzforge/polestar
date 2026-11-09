//! Skip says what it did (addon/Polestar/Core/Engine.lua, Own.passedBy, Own.passedWhy; PLAYER_SKIPPED_STEP's
//! third argument). Skip marks one step, the one on screen, and the live step then passes every step already
//! done or that can't be done any more, which read as "Skip skips 5-6 steps" (a Dwarf in Loch Modan). Now the
//! event lists the passed steps with a reason each: already done, left out (naming what the player skipped,
//! which may be an earlier skip's), not for you now (a `when` stored failed, a level), travel passed.

use crate::loch_modan::{run_as, AT_THE_TUNNEL};
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// 1 accept 7 · 2 kill for 7 · 3 accept 15 (done) · 4 hand in 7 · 5 only from level 20 · 6 walk
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/passed", pack = "test", title = "Passed", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Echo Ridge", goals = { { t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Back to McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "At 20", when = { { k = "level", op = ">=", n = 20 } }, goals = { { t = "accept", quest = 33, title = "Wolves", npc = 196, map = 1429, x = 40, y = 40 } } },
		{ title = "Walk", goals = { { t = "goto", map = 1429, x = 30, y = 30, text = "Walk" } } },
	},
})
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before:
			"local w = stub.world\nw.addMap(1429, { name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })\nw.moveTo(1429, 48, 42)\nw.level = 19\nw.complete({ 15 })"
				.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/passed" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			r#"E = Polestar.Engine
function flush() stub.advance(0.25) end
passed = nil
Polestar.On("PLAYER_SKIPPED_STEP", function(id, s, p) passed = p end)
function said()
	local out = {}
	for _, p in ipairs(passed or {}) do out[#out + 1] = p.step .. " " .. p.reason .. (p.because and (" (" .. table.concat(p.because, ", ") .. ")") or "") end
	return out
end"#,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
}

#[test]
fn a_skip_lists_the_steps_it_passed_with_why_left_out_naming_the_skipped_step_done_and_not_for_you_now() {
	let out = run(r#"
		E.Skip(); flush()
		emit({ live = E.GetLiveStep(), passed = said() })"#);
	assert_eq!(
		out[0],
		json!({ "live": 6, "passed": ["2 leftOut (McBride)", "3 done", "4 leftOut (McBride)", "5 notNow"] }),
		"McBride skipped: its kills and hand-in go with it, Echo Ridge was done, At 20 fails at 19"
	);
}

#[test]
fn a_skip_that_moves_on_by_one_step_passes_nothing() {
	let out = run(r#"
		stub.world.accept(7, { 10 }); flush()
		E.Skip(); flush()
		emit({ live = E.GetLiveStep(), passed = said() })"#);
	assert_eq!(out[0], json!({ "live": 4, "passed": ["3 done"] }));
}

// The Dwarf of the report (Loch Modan, "29/51"): at the tunnel with 301 in the log, 244 taken at Three Corners
// and 246/98407 at Lakeridge Highway without Lakeshire, standing at the Lakeridge Highway kills. Skip pressed from
// the live step, one press at a time: what each press passed, and why.
#[test]
fn the_dwarf_s_skip_presses_say_what_they_passed() {
	let Some(out) = run_as(
		"Dwarf",
		&format!(
			r#"{AT_THE_TUNNEL}
local w = stub.world
w.accept(244, {{}}); flush()
knowFP("Lakeshire"); w.turnIn(244); w.accept(98407, {{ {{ required = 1, text = "Spiked Collar: 0/1" }} }})
w.accept(246, {{ {{ required = 10, text = "Redridge Mongrel slain: 0/10" }}, {{ required = 8, text = "Redridge Poacher slain: 0/8" }} }}); flush()
walk(step("Lakeridge Highway: kill these as you meet them"))
local passed
Polestar.On("PLAYER_SKIPPED_STEP", function(id, s, p) passed = p end)
local function no(s) return s and E.StepNumber(s) or 0 end
emit({{ live = no(E.GetLiveStep()), title = live() }})
for i = 1, 6 do
	local s = E.Skip(); flush()
	local said = {{}}
	for _, p in ipairs(passed or {{}}) do said[#said + 1] = no(p.step) .. " " .. p.reason .. (p.because and (" (" .. table.concat(p.because, ", ") .. ")") or "") end
	emit({{ skipped = no(s) .. " " .. title(s), live = no(E.GetLiveStep()), passed = said }})
end"#
		),
	) else {
		return;
	};
	for o in &out {
		eprintln!("{o}");
	}
	assert_eq!(out[0]["title"], "Into Dun Morogh");
	// Every press says why each step it passed went, and no step is passed without one.
	for press in &out[1..] {
		for p in press["passed"].as_array().unwrap() {
			let p = p.as_str().unwrap();
			assert!(["done", "leftOut", "notNow", "travel"].iter().any(|r| p.split(' ').nth(1) == Some(r)), "{p}");
		}
	}
}
