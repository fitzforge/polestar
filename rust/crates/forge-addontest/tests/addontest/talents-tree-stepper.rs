//! The mini talent tree's stepper (Talents/Tree.lua, Talents/View.lua): where it opens, that it starts over
//! when the hub is closed and reopened, the list's row clicks, the talents' clicks, one redraw per step, and
//! the muted drawing of ranks the followed plan has not learned yet.

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

// Followed Retribution, 20 picks learned; quantity: the points granted.
fn followed(quantity: u32, script: &str) -> String {
	let head = r#"
local b = plan("retribution")
TS.learn(b, 20)
TS.currency = { quantity = ${quantity}, spent = 20 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local function cursor() return TV.Shown().tree.cursor end
local function rowFor(n)
	for _, r in ipairs(TV.rows) do if r:IsShown() and r.psPick and r.psPick.order == n then return r end end
end
local function cellFor(node)
	for _, c in ipairs(TV.TreeFrame().cells) do if c:IsShown() and c.psNode and c.psNode.id == node then return c end end
end
"#
	.replace("${quantity}", &quantity.to_string());
	[head.as_str(), script].join("\n")
}

#[test]
fn tree_with_no_point_waiting_the_followed_plan_still_opens_on_its_next_pick_and_the_list_marks_that_row() {
	let out = run(&followed(
		0,
		r#"local s = TV.Shown()
emit({ status = s.status, cursor = cursor(), row = s.cursorRow, ahead = s.tree.ahead })"#,
	))
	.remove(0);
	assert_eq!(out, json!({ "status": "onplan", "cursor": 21, "row": 21, "ahead": 1 }));
}

#[test]
fn tree_the_stepper_starts_over_when_the_hub_is_closed_and_opened_again() {
	let out = run(&followed(
		1,
		r#"TV.StepTo(5)
local moved = cursor()
PolestarPicker:Hide()
Polestar.UI.ShowPicker()
Polestar.UI.Picker.ShowSection("Talents")
emit({ moved = moved, reopened = cursor() })"#,
	))
	.remove(0);
	assert_eq!(out, json!({ "moved": 5, "reopened": 21 }));
}

#[test]
fn tree_a_left_click_on_a_list_row_steps_there_a_right_click_does_not() {
	let out = run(&followed(
		1,
		r#"local r = rowFor(7)
r:GetScript("OnMouseUp")(r, "RightButton")
local right = cursor()
r = rowFor(7)
r:GetScript("OnMouseUp")(r, "LeftButton")
emit({ right = right, left = cursor() })"#,
	))
	.remove(0);
	assert_eq!(out, json!({ "right": 21, "left": 7 }));
}

#[test]
fn tree_a_step_redraws_the_tree_once_and_keeps_it_shown() {
	let out = run(&followed(
		1,
		r#"local tree = TV.TreeFrame()
local hides, draws = 0, 0
tree:SetScript("OnHide", function() hides = hides + 1 end)
local draw = T.Tree.Draw
T.Tree.Draw = function(...) draws = draws + 1; return draw(...) end
TV.StepTo(12)
T.Tree.Draw = draw
emit({ cursor = cursor(), hides = hides, draws = draws, shown = tree:IsShown() })"#,
	))
	.remove(0);
	assert_eq!(out, json!({ "cursor": 12, "hides": 0, "draws": 1, "shown": true }));
}

#[test]
fn tree_a_click_on_a_talent_steps_to_its_last_pick_drawn_learned() {
	let out = run(&followed(
		1,
		r#"local first = b.picks[1].node
local last = 0
for _, p in ipairs(b.picks) do if p.node == first then last = p.order end end
local c = cellFor(first)
TV.StepTo(30)
c = cellFor(first)
c:GetScript("OnClick")(c)
c = cellFor(first)
emit({ cursor = cursor(), last = last, ahead = c.psAhead, alpha = c.Icon:GetAlpha() })"#,
	))
	.remove(0);
	assert_eq!(out["cursor"], out["last"]);
	assert_eq!(json!([out["ahead"], out["alpha"]]), json!([false, 1]));
}

#[test]
fn tree_a_rank_ahead_of_what_is_learned_is_drawn_muted() {
	let out = run(&followed(
		1,
		r#"local c = cellFor(b.picks[21].node)
emit({ ahead = c.psAhead, alpha = c.Icon:GetAlpha() })"#,
	))
	.remove(0);
	assert_eq!(out, json!({ "ahead": true, "alpha": 0.6 }));
}

#[test]
fn tree_an_empty_page_another_class_shows_no_tree() {
	let out = run(r#"TS.learn(plan("retribution"), 20)
TS.currency = { quantity = 1, spent = 20 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local tree = TV.TreeFrame()
stub.class = "ROGUE"
UnitClass = function() return "Rogue", "ROGUE" end
T.Refresh()
TV.Render()
emit({ empty = TV.Shown().empty ~= nil, tree = tree:IsShown() })"#)
	.remove(0);
	assert_eq!(out, json!({ "empty": true, "tree": false }));
}
