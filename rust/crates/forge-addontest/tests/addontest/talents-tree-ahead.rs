//! The mini talent tree on the followed plan tells learned ranks from ranks the plan has not reached in the
//! game yet (Talents/Tree.lua). Another spec's plan has nothing learned to compare with, so it marks none.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Talents/Talents.xml"];

const PRELUDE: &str = r#"
local T, TS = Polestar.Talents, stub.talents
local data = T.Data("PALADIN")
TS.useSnapshot(data)
local function plan(key) return T.BuildByKey(data, key) end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_talents.lua", "stub_ui.lua"], addons: vec![Addon::files("Polestar", WITH_UI)], script: [PRELUDE, script].join("\n"), ..Default::default() })
}

const FOLLOWED: &str = r#"
local b = plan("retribution")
TS.learn(b, 20)
TS.currency = { quantity = 1, spent = 20 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local function cells()
	local ahead, shown = 0, 0
	for _, c in ipairs(TV.TreeFrame().cells) do
		if c:IsShown() then
			shown = shown + 1
			if c.psAhead then ahead = ahead + 1 end
		end
	end
	return ahead, shown
end
-- Talents whose rank at pick n is above the rank after the 20 learned picks.
local function expected(n)
	local learned, planned, k = T.Tree.RanksAt(b, 20), T.Tree.RanksAt(b, n), 0
	for id, r in pairs(planned) do if r > (learned[id] or 0) then k = k + 1 end end
	return k
end
"#;

fn followed(script: &str) -> Vec<Value> {
	run(&[FOLLOWED, script].join("\n"))
}

#[test]
fn tree_plan_progress_keeps_the_ranks_it_was_given() {
	let out = run(r#"
local b = plan("retribution")
local id = b.picks[1].node
local s = T.State(b, { [id] = 1 }, 20, 11)
emit({ rank = s.ranks and s.ranks[id] or false })"#)
	.remove(0);
	assert_eq!(out, json!({ "rank": 1 }));
}

#[test]
fn tree_on_the_followed_plan_ranks_past_what_is_learned_are_marked_as_ahead() {
	let outs = followed(
		r#"local a, n = cells()
emit({ cursor = TV.Shown().tree.cursor, ahead = a, shownAhead = TV.Shown().tree.ahead, want = expected(21) })
TV.StepTo(20)
a = cells()
emit({ ahead = a, shownAhead = TV.Shown().tree.ahead })
TV.StepTo(51)
a = cells()
emit({ ahead = a, shownAhead = TV.Shown().tree.ahead, want = expected(51) })"#,
	);
	assert_eq!(outs[0], json!({ "cursor": 21, "ahead": 1, "shownAhead": 1, "want": 1 }), "the next pick is ahead");
	assert_eq!(outs[1], json!({ "ahead": 0, "shownAhead": 0 }), "every pick up to 20 is learned");
	assert!(outs[2]["want"].as_f64().unwrap() > 1.0, "the rest of the plan spans several talents");
	let want = &outs[2]["want"];
	assert_eq!(outs[2], json!({ "ahead": want, "shownAhead": want, "want": want }));
}

#[test]
fn tree_another_spec_s_plan_marks_nothing_ahead() {
	let out = followed(
		r#"TV.SetTab("1")
local a = cells()
emit({ ahead = a, shownAhead = TV.Shown().tree.ahead })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "ahead": 0, "shownAhead": 0 }));
}

#[test]
fn tree_the_stepper_ranks_and_points_are_unchanged_by_the_marks() {
	let outs = followed(
		r#"local s = TV.Shown().tree
emit({ cursor = s.cursor, picked = s.picked, ret = s.points[3] or 0 })
TV.StepTo(51)
s = TV.Shown().tree
emit({ cursor = s.cursor, picked = s.picked, ret = s.points[3] or 0 })"#,
	);
	assert_eq!(outs[0], json!({ "cursor": 21, "picked": 21, "ret": 21 }));
	assert_eq!(outs[1], json!({ "cursor": 51, "picked": 51, "ret": 41 }));
}
