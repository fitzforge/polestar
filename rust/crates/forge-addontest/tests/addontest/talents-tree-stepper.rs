//! The mini talent tree's stepper (Talents/Tree.lua, Talents/View.lua): where it opens, that it starts over
//! when the hub is closed and reopened, the list's row clicks, the talents' clicks, one redraw per step, and
//! the muted drawing of ranks the followed plan has not learned yet.

use forge_addontest::{emitted, fake_locale, Addon, RunAddon};
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

#[test]
fn tree_the_chevrons_and_the_mouse_wheel_step_one_pick_and_stop_at_either_end() {
	let outs = run(&followed(
		1,
		r#"local t = TV.TreeFrame()
local function snap() return { cursor = cursor(), picked = TV.Shown().tree.picked, prev = t.Prev:IsEnabled() and true or false, next = t.Next:IsEnabled() and true or false } end
local function click(b) b:GetScript("OnClick")(b) end
local function wheel(delta) t:GetScript("OnMouseWheel")(t, delta) end
emit(snap())
click(t.Prev); emit(snap())
click(t.Next); emit(snap())
wheel(1); emit(snap())
wheel(-1); emit(snap())
TV.StepTo(51); click(t.Next); wheel(-1); emit(snap())
TV.StepTo(0); click(t.Prev); wheel(1); emit(snap())"#,
	));
	assert_eq!(outs[0], json!({ "cursor": 21, "picked": 21, "prev": true, "next": true }));
	assert_eq!(outs[1], json!({ "cursor": 20, "picked": 20, "prev": true, "next": true }), "the left chevron steps back");
	assert_eq!(outs[2], json!({ "cursor": 21, "picked": 21, "prev": true, "next": true }), "the right chevron steps on");
	assert_eq!(outs[3], json!({ "cursor": 20, "picked": 20, "prev": true, "next": true }), "the wheel up steps back");
	assert_eq!(outs[4], json!({ "cursor": 21, "picked": 21, "prev": true, "next": true }), "the wheel down steps on");
	assert_eq!(outs[5], json!({ "cursor": 51, "picked": 51, "prev": true, "next": false }), "at the last pick: the right chevron is off and nothing moves");
	assert_eq!(outs[6], json!({ "cursor": 0, "picked": 0, "prev": false, "next": true }), "before the first pick: the left chevron is off and nothing moves");
}

#[test]
fn tree_redraws_reuse_their_talents_arrows_and_spec_heads() {
	let outs = run(&followed(
		1,
		r#"local t = TV.TreeFrame()
local function pool() return { cells = #t.cells, lines = #t.lines, heads = #t.heads } end
local function shownCells() local n = 0 for _, c in ipairs(t.cells) do if c:IsShown() then n = n + 1 end end return n end
local first, shown = pool(), shownCells()
for i = 51, 0, -1 do TV.StepTo(i) end
TV.SetTab("1")
TV.SetTab("2")
TV.SetTab("3")
emit({ first = first, after = pool(), shown = shown, shownAfter = shownCells() })"#,
	))
	.remove(0);
	assert_eq!(outs["first"], outs["after"], "no new talents, arrows or heads on a redraw");
	assert_eq!(outs["shown"], outs["shownAfter"], "the same talents are shown again on the same plan");
	assert_eq!(outs["first"]["heads"], 3);
}

#[test]
fn tree_the_spec_columns_are_named_in_the_client_s_language() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_talents.lua", "stub_ui.lua"],
		before: fake_locale("itIT", &[("Holy", "Sacro"), ("Protection", "Protezione"), ("Retribution", "Castigo")]),
		addons: vec![Addon::files("Polestar", WITH_UI)],
		script: [
			PRELUDE,
			r#"TS.learn(plan("retribution"), 20)
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local names = {}
for _, h in ipairs(TV.TreeFrame().heads) do if h:IsShown() then names[#names + 1] = h.Name:GetText() end end
local tabs = {}
for _, n in ipairs((TV.Nav())) do tabs[#tabs + 1] = n.label end
emit({ heads = names, tabs = tabs })"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["heads"], json!(["Sacro", "Protezione", "Castigo"]), "the tree's columns");
	assert_eq!(out["tabs"], out["heads"], "named as the tabs are");
}

#[test]
fn tree_an_out_of_date_plan_is_drawn_whole_as_written_with_nothing_marked_ahead_and_still_steps() {
	let outs = run(r#"
local soc
for id, n in pairs(data.nodes) do if n.name == "Seal of Command" then soc = id end end
TS.learn(plan("retribution"), 20)
TS.nodes[soc] = nil
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local s = TV.Shown()
emit({ status = s.status, tree = TV.TreeFrame():IsShown(), cursor = s.tree.cursor, picked = s.tree.picked, ahead = s.tree.ahead })
TV.StepTo(10)
emit(TV.Shown().tree.cursor)"#);
	assert_eq!(outs[0], json!({ "status": "stale", "tree": true, "cursor": 51, "picked": 51, "ahead": 0 }));
	assert_eq!(outs[1], 10);
}
