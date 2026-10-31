//! The mini talent tree's last details (Talents/Tree.lua, Talents/View.lua): before the game grants a point
//! the tree opens before the first pick; a stepper move scrolls the list to its row only once the list has a
//! height; leaving the section resets the stepper like closing the hub does.

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
	emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_talents.lua", "stub_ui.lua"], addons: vec![Addon::files("Polestar", WITH_UI)], script: [PRELUDE, script].concat(), ..Default::default() })
}

const FOLLOWED: &str = r#"
TS.learn(plan("retribution"), 20)
TS.currency = { quantity = 1, spent = 20 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local scroll = TV.rows[1]:GetParent():GetParent()
local function cursor() return TV.Shown().tree.cursor end
"#;

fn followed(script: &str) -> Vec<Value> {
	run(&[FOLLOWED, script].join("\n"))
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

#[test]
fn tree_before_the_game_grants_a_point_the_followed_plan_opens_before_its_first_pick() {
	let out = run(r#"
TS.currency = { quantity = 0, spent = 0 }
stub.login()
T.Refresh()
local TV = Polestar.UI.TalentsSection
TV.Show()
local s = TV.Shown()
emit({ status = s.status, cursor = s.tree.cursor, ahead = s.tree.ahead })"#)
	.remove(0);
	assert_eq!(out, json!({ "status": "early", "cursor": 0, "ahead": 0 }));
}

#[test]
fn tree_a_list_without_a_height_yet_is_not_scrolled_by_the_stepper() {
	let out = followed(
		r#"TV.StepTo(12)
emit({ cursor = cursor(), at = scroll:GetVerticalScroll() })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "cursor": 12, "at": 0 }));
}

#[test]
fn tree_with_a_height_the_stepper_scrolls_the_list_to_its_row_down_and_back_up() {
	let out = followed(
		r#"scroll:SetHeight(200)
TV.StepTo(45)
local down = scroll:GetVerticalScroll()
local function topOf(n)
	for _, r in ipairs(TV.rows) do if r:IsShown() and r.psPick and r.psPick.order == n then return -select(5, r:GetPoint(1)) end end
end
local t45 = topOf(45)
TV.StepTo(3)
local up, t3 = scroll:GetVerticalScroll(), topOf(3)
emit({ down = down, seen = t45 >= down and t45 + 26 <= down + 200, up = up, back = t3 >= up and t3 + 26 <= up + 200 })"#,
	)
	.remove(0);
	assert!(num(&out["down"]) > 0.0, "scrolled down to pick 45");
	assert_eq!(out["seen"], true, "pick 45 in view");
	assert!(num(&out["up"]) < num(&out["down"]), "scrolled back up for pick 3");
	assert_eq!(out["back"], true, "pick 3 in view");
}

#[test]
fn tree_leaving_the_talents_section_starts_the_stepper_over() {
	let out = followed(
		r#"TV.StepTo(5)
local moved = cursor()
local f = TV.TreeFrame()
while f and not f:GetScript("OnHide") do f = f:GetParent() end
f:GetScript("OnHide")(f)
TV.Render()
emit({ moved = moved, back = cursor() })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "moved": 5, "back": 21 }));
}
