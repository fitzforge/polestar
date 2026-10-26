//! The guide window's "Along the way" section, end to end: a guide compiled from DSL with an `along` step,
//! loaded by the real addon (Core, Theme, Nav, UI), driven in the stub world. The along step's open goals are
//! listed under the card while the route is past it, with live progress, and "Then:" and Up next never name
//! the along step.

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack, TestPack};
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::json;

const GUIDE: &str = r#"guide forever/alliance/human/01-northshire
title Northshire Valley
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobolds on the way
  along until back
  kill 6 x10 quest 7.1

step Kobold camp
  goto 47.6,35.1 "Kobold camp"

step Back to the abbey
  label back
  turnin 7
"#;

fn compile_pack() -> TestPack {
	let data = fixture_data();
	let r = compile_with(&[("along.guide", GUIDE)], &data, None);
	let errors: Vec<String> = r.diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	write_our_test_pack(&r.guides)
}

const BEFORE: &str = r#"
				local w = stub.world
				w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
				w.moveTo(1429, 48.5, 42.5)"#;

const SCRIPT: &str = r#"
				Polestar.Set("ui.upcoming", 3)
				Polestar.Set("ui.upcomingOpen", true)
				stub.login()
				stub.advance(0.5)
				local w = stub.world
				local GF = Polestar.UI.GuideFrame
				local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
				local function snap()
					local A = GF.parts.along
					local rows, ups = {}, {}
					for _, r in ipairs(GF.alongRows) do
						if r:IsShown() then rows[#rows + 1] = { text = plain(r.Text:GetText()), step = r.psStep, goal = r.psGoal } end
					end
					for _, r in ipairs(GF.upRows) do if r:IsShown() then ups[#ups + 1] = r.psIndex end end
					emit({
						step = Polestar.Engine.GetStepIndex(),
						shown = A:IsShown(),
						header = A:IsShown() and plain(A.Label:GetText()) or false,
						rows = rows,
						after = plain(GF.parts.after.Text:GetText()),
						upnext = ups,
					})
				end
				snap()
				w.accept(783, {}, "A Threat Within")
				stub.advance(0.5)
				w.turnIn(783)
				w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
				stub.advance(0.5)
				snap()
				w.progress(7, 1, 4)
				stub.advance(0.5)
				snap()
				local r = GF.alongRows[1]
				r:GetScript("OnClick")(r)
				stub.advance(0.5)
				local t = Polestar.Nav.GetTarget()
				emit(t and { t.stepIndex, t.goalIndex } or false)
				Polestar.Set("ui.compact", true)
				stub.advance(0.1)
				snap()
				Polestar.Set("ui.compact", false)
				w.moveTo(1429, 47.6, 35.1)
				stub.advance(1)
				snap()"#;

#[test]
fn along_goals_show_under_the_card_while_the_route_is_past_them_then_and_up_next_leave_the_along_step_out() {
	let pack = compile_pack();
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let out =
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: "\n\t\t\t\t".to_string() + &loads + SCRIPT, ..Default::default() });
	let (login, on_seven, kills, target, compact, at_back) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5]);

	// Step 1: nothing is along yet; Up next leaves out the along step 3.
	assert_eq!(login["step"], 1);
	assert_eq!(login["shown"], false);
	assert_eq!(login["after"], "Then: Marshal McBride");
	assert_eq!(login["upnext"], json!([2, 4, 5]));

	// Taking 7 passes over the along step: step 4, with the kobolds along the way.
	assert_eq!(on_seven["step"], 4);
	assert_eq!(on_seven["shown"], true);
	assert_eq!(on_seven["header"], "Along the way");
	assert_eq!(on_seven["rows"].as_array().unwrap().len(), 1);
	assert!(is_match(text(&on_seven["rows"][0]["text"]), r"Kobold Vermin"));
	assert!(is_match(text(&on_seven["rows"][0]["text"]), r"0/10$"));
	assert_eq!(json!([on_seven["rows"][0]["step"], on_seven["rows"][0]["goal"]]), json!([3, 1]));

	// Progress updates in place.
	assert_eq!(kills["step"], 4);
	assert!(is_match(text(&kills["rows"][0]["text"]), r"4/10$"));

	// A click on the row leads the arrow to the kobolds.
	assert_eq!(*target, json!([3, 1]));

	// The compact window hides the section.
	assert_eq!(compact["shown"], false);

	// Arriving at the camp reaches the labelled step, which ends the list.
	assert_eq!(at_back["step"], 5);
	assert_eq!(at_back["shown"], false);
}
