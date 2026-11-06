//! The guide window's "Along the way" section, end to end: a guide compiled from DSL with an `along` step,
//! loaded by the real addon (Core, Theme, Nav, UI), driven in the stub world. The along step's open goals are
//! listed under the card while the route is past it, with live progress, and "Then:" and Up next never name
//! the along step. An along step is no step of its own (#942): paging never lands on it, it has no number, and
//! the section's heading says until which step its goals are listed. Nor has a step of another class (a Mage
//! paging through Darkshore never meets the Druids' Moonglade steps).

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
				snap()
				w.progress(7, 1, 10)
				stub.advance(0.5)
				snap()"#;

#[test]
fn along_goals_show_under_the_card_while_the_route_is_past_them_then_and_up_next_leave_the_along_step_out() {
	let pack = compile_pack();
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let out =
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: "\n\t\t\t\t".to_string() + &loads + SCRIPT, ..Default::default() });
	let (login, on_seven, kills, target, compact, at_back, done) = (&out[0], &out[1], &out[2], &out[3], &out[4], &out[5], &out[6]);

	// Step 1: nothing is along yet; Up next leaves out the along step 3.
	assert_eq!(login["step"], 1);
	assert_eq!(login["shown"], false);
	assert_eq!(login["after"], "Then: Marshal McBride");
	assert_eq!(login["upnext"], json!([2, 4, 5]));

	// Taking 7 passes over the along step: step 4, with the kobolds along the way.
	assert_eq!(on_seven["step"], 4);
	assert_eq!(on_seven["shown"], true);
	assert_eq!(on_seven["header"], "Along the way, until step 4", "the labelled step 5 is the player's step 4: the along step has no number");
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

	// Arriving at the camp reaches the labelled step, which hands quest 7 in: its kobolds stay listed while
	// they are open (#797), so "Turn in" never hides what is left; done, the list ends.
	assert_eq!(at_back["step"], 5);
	assert_eq!(at_back["shown"], true);
	assert!(is_match(text(&at_back["rows"][0]["text"]), r"4/10$"));
	assert_eq!(done["shown"], false);
}

// Fitz (#942): the along step is merged into the steps the player travels to. Paging with the window's arrows
// never lands on it, the header counts only the steps of the route ("1 / 4", not "1 / 5"), Goto does not open
// it, and the progress leaves it out.
#[test]
fn paging_never_lands_on_the_along_step_and_the_header_does_not_count_it() {
	let pack = compile_pack();
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let script = r#"
				stub.login()
				stub.advance(0.5)
				local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
				local function head() return GF.parts.nav.Steps.Count:GetText() end
				local ahead = { { E.GetStepIndex(), head() } }
				for _ = 1, 5 do GF.parts.nav.Next:Click(); stub.advance(0.1); ahead[#ahead + 1] = { E.GetStepIndex(), head() } end
				local back = {}
				for _ = 1, 5 do GF.parts.nav.Prev:Click(); stub.advance(0.1); back[#back + 1] = E.GetStepIndex() end
				E.Goto(3); stub.advance(0.1)
				local _, total = E.GetProgress()
				emit({ ahead = ahead, back = back, gotoAlong = E.GetStepIndex(), total = total })"#;
	let out =
		emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: BEFORE.into(), addons: vec![Addon::name("Polestar")], script: "\n\t\t\t\t".to_string() + &loads + script, ..Default::default() });
	assert_eq!(
		out[0]["ahead"],
		json!([[1, "1 / 4"], [2, "2 / 4"], [4, "3 / 4"], [5, "4 / 4"], [5, "4 / 4"], [5, "4 / 4"]]),
		"Next goes from step 2 to step 4; the numbers count the route's steps only"
	);
	assert_eq!(out[0]["back"], json!([4, 2, 1, 1, 1]), "Prev passes over it too");
	assert_eq!(out[0]["gotoAlong"], 1, "Goto does not open it");
	assert_eq!(out[0]["total"], 4, "nor does the progress count it");
}

// Fitz, as a Mage in Darkshore (#942): the Druids' steps (`only Druid`: Moonglade, Dendrite Starblaze, the
// relics) and the along steps do not exist for him. Paging from the first step to the last never lands on one,
// and the header counts only his steps.
#[test]
fn a_mage_paging_through_darkshore_never_meets_a_druid_step_and_the_header_counts_his_steps() {
	use forge_addontest::dsl::{our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/alliance/03-darkshore.guide";
	let source = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &source)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let before = r#"local w = stub.world
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Human", "Human", "MAGE", "Mage", "Alliance", 17
"#;
	let script = format!(
		r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
stub.advance(0.6)
local E, GF, G = Polestar.Engine, Polestar.UI.GuideFrame, Polestar.Guides
E.SetGuide("forever/alliance/03-darkshore"); stub.advance(0.5)
GF.LookAt(1); stub.advance(0.1)
local function head() return GF.parts.nav.Steps.Count:GetText() end
local seen = {{ {{ E.GetStepIndex(), head() }} }}
for _ = 1, 100 do
	local at = E.GetStepIndex()
	GF.parts.nav.Next:Click(); stub.advance(0.05)
	if E.GetStepIndex() == at then break end
	seen[#seen + 1] = {{ E.GetStepIndex(), head() }}
end
local guide, me = E.GetGuide(), Polestar.Compat.GetPlayerInfo()
local druid, along, visible = {{}}, {{}}, 0
for s, step in ipairs(guide.steps) do
	local mine = not step.along and G.Matches(step.only, me)
	if mine and #step.goals > 0 then
		mine = false
		for _, goal in ipairs(step.goals) do if G.Matches(goal.only, me) then mine = true end end
	end
	if mine then visible = visible + 1 end
	if step.along then along[#along + 1] = s end
	if type(step.only) == "table" and type(step.only.classes) == "table" and not G.Matches(step.only, me) then druid[#druid + 1] = s end
end
emit({{ seen = seen, druid = druid, along = along, visible = visible, steps = #guide.steps }})
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before: before.into(), addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0);
	let seen: Vec<(i64, String)> = out["seen"].as_array().unwrap().iter().map(|p| (p[0].as_i64().unwrap(), text(&p[1]).to_string())).collect();
	let druid: Vec<i64> = out["druid"].as_array().unwrap().iter().map(|v| v.as_i64().unwrap()).collect();
	let along: Vec<i64> = out["along"].as_array().unwrap().iter().map(|v| v.as_i64().unwrap()).collect();
	let visible = out["visible"].as_i64().unwrap();
	assert!(druid.len() >= 4, "Darkshore has its Druid steps: {druid:?}");
	assert!(!along.is_empty(), "and its along steps");
	assert!(visible < out["steps"].as_i64().unwrap(), "the Mage has fewer steps than the guide");
	assert!(seen.len() > 20, "paged through the guide: {seen:?}");
	let mut last = 0;
	for (s, head) in &seen {
		assert!(!druid.contains(s), "paged onto the Druid step {s}");
		assert!(!along.contains(s), "paged onto the along step {s}");
		let (n, total) = head.split_once(" / ").unwrap_or_else(|| panic!("header {head}"));
		let (n, total): (i64, i64) = (n.parse().unwrap(), total.parse().unwrap());
		assert_eq!(total, visible, "step {s}: the header counts the Mage's steps only ({head})");
		assert!(n > last, "step {s}: the numbers go up ({head} after {last})");
		last = n;
	}
	assert_eq!(seen[0].1, format!("1 / {visible}"), "the first step is step 1");
}
