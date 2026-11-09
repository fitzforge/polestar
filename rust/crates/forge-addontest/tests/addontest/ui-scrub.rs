//! The wheel over the step number (addon/Polestar/UI/GuideFrame.lua, GF.Scrub): each notch looks at another step,
//! and SCRUB_BACK seconds after the last notch the window goes back to the live step. A player looking ahead with
//! the wheel who starts doing that step's work was pulled back to the live step mid-fight ("if I start doing
//! anything from where I'm looking ahead it jumps back"): now the window stays on a step whose goals changed since
//! the notch, and waits while the player is in combat. Real Core + Theme + UI manifests, the fake Engine
//! (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The live step is 2; one notch down looks at step 3 (a kill at 7/10 and a collect at 3/8 in the sample guide).
fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			r#"uistub.install()
stub.login()
local GF, E = Polestar.UI.GuideFrame, Polestar.Engine
uistub.setGuide(uistub.elwynn, 2)
uistub.live = 2
local function counted(s)
	for g, goal in ipairs(uistub.guides[uistub.elwynn].steps[s].goals) do
		if goal.progress then return uistub.goal(s, g) end
	end
end
GF.Scrub(-1)
local looked = E.GetStepIndex()
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn with_nothing_done_the_window_goes_back_to_the_live_step_four_seconds_after_the_last_notch() {
	let out = run(r#"
		stub.advance(3.9)
		local still = E.GetStepIndex()
		stub.advance(0.2)
		emit({ looked = looked, still = still, back = E.GetStepIndex() })"#);
	assert_eq!(out[0], json!({ "looked": 3, "still": 3, "back": 2 }));
}

#[test]
fn a_count_going_up_on_the_step_looked_at_keeps_the_window_there() {
	let out = run(r#"
		stub.advance(2)
		counted(3).progress.cur = counted(3).progress.cur + 1
		uistub.update()
		stub.advance(10)
		emit(E.GetStepIndex())"#);
	assert_eq!(out[0], json!(3), "the player is doing step 3: it stays, as after Next");
}

#[test]
fn a_goal_done_on_the_step_looked_at_keeps_the_window_there() {
	let out = run(r#"
		counted(3).status = "done"
		uistub.update()
		stub.advance(10)
		emit(E.GetStepIndex())"#);
	assert_eq!(out[0], json!(3));
}

#[test]
fn in_combat_the_window_waits_for_the_fight_to_end_then_goes_back() {
	let out = run(r#"
		stub.inCombat = true
		stub.advance(4.1)
		local mid = E.GetStepIndex()
		stub.advance(8)
		local later = E.GetStepIndex()
		stub.inCombat = false
		stub.advance(4.1)
		emit({ mid = mid, later = later, after = E.GetStepIndex() })"#);
	assert_eq!(out[0], json!({ "mid": 3, "later": 3, "after": 2 }));
}

#[test]
fn only_the_last_notch_counts() {
	let out = run(r#"
		stub.advance(3)
		GF.Scrub(-1)                                   -- step 4, 3 s later
		stub.advance(1.5)
		local on = E.GetStepIndex()                    -- the first notch's 4 s are up: not back yet
		stub.advance(3)
		emit({ on = on, back = E.GetStepIndex() })"#);
	assert_eq!(out[0], json!({ "on": 4, "back": 2 }));
}
