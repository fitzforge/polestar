//! Waiting for the group (Quests/Party.lua, party.waitForGroup) with a real guide compiled from DSL and the
//! whole addon, against the fake client and two-member party (tests/lua/stub_party.lua): an objective done
//! for you that a party member still needs holds the live step, its turn-in (automation hands nothing in)
//! and the arrow, which leads to what they still need; "Everyone's ready" once they are done. A member in
//! another zone, offline for over 2 minutes, "Go on without them", or no party at all holds nothing.

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack};
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const HEAD: &str = r#"guide forever/alliance/human/01-northshire
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
"#;

// The kobolds, then the turn-in a step later.
const APART: &str = r#"
step Kobolds
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
"#;

// The kobolds and the turn-in in one step.
const TOGETHER: &str = r#"
step Kobolds
  kill 6 x10 quest 7.1
  turnin 7
"#;

const BEFORE: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 48.5, 42.5)"#;

// On step 3 with quest 7 done for you, Ana (who runs Polestar) at 3/10 of it.
const ON_KOBOLDS: &str = r#"
stub.login()
stub.advance(0.5)
local w, p, P, E = stub.world, stub.party, Polestar.Party, Polestar.Engine
w.accept(783, {}, "A Threat Within")
stub.advance(0.5)
w.turnIn(783)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(0.5)
p.join("Ana")
p.onQuest.Ana = { [7] = true }
stub.advance(1)
p.receive("Ana-TestRealm", "1|7:3/10")
w.progress(7, 1, 10)
stub.advance(1)
local function state()
	local view = E.GetStepView(E.GetStepIndex())
	local wp = E.GetWaypoint()
	local lines = {}
	for i, g in ipairs(view.goals) do lines[i] = P.Line(g) or false end
	local line, holding = P.StepLine()
	return { step = E.GetStepIndex(), wp = wp and { wp.goalIndex, wp.label } or false, wants = E.WantsQuest("turnin", 7),
		lines = lines, party = line or false, holding = holding or false }
end
"#;

fn run(rest: &str, script: &str) -> Vec<Value> {
	let data = fixture_data();
	let guide = format!("{HEAD}{rest}");
	let r = compile_with(&[("group.guide", guide.as_str())], &data, None);
	let errors: Vec<String> = r.diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::name("Polestar")],
		script: format!("{loads}\n{ON_KOBOLDS}\n{script}"),
		..Default::default()
	})
}

#[test]
fn group_the_step_waits_for_a_member_who_still_needs_its_objective_and_moves_on_once_they_are_done() {
	let out = run(
		APART,
		r#"
emit(state())
p.receive("Ana-TestRealm", "1|7:10/10")
stub.advance(1)
emit(state())"#,
	);
	let held = &out[0];
	assert_eq!(held["step"], 3, "held on the kobolds: {held}");
	assert!(is_match(text(&held["lines"][0]), r"^Waiting on Ana: 3/10 Kobold Vermin$"), "{held}");
	assert_eq!(held["wp"][0], 1, "the arrow leads to the kobolds Ana still needs");
	assert!(is_match(text(&held["wp"][1]), r"^For Ana: "), "{held}");
	assert!(is_match(text(&held["party"]), r"Waiting on Ana$"));
	assert_eq!(held["holding"], true, "the party line offers Go on without them");
	assert_eq!(out[1]["step"], 4, "Ana done: on to the turn-in");
}

#[test]
fn group_the_turn_in_waits_and_says_everyone_s_ready_when_the_member_is_done() {
	let out = run(
		TOGETHER,
		r#"
emit(state())
p.receive("Ana-TestRealm", "1|7:10/10")
stub.advance(1)
emit(state())"#,
	);
	let held = &out[0];
	assert_eq!(held["step"], 3);
	assert_eq!(held["wants"], false, "automation hands nothing in while the group waits");
	assert_eq!(held["wp"][0], 1, "the arrow stays on the kobolds, not the turn-in");
	assert_eq!(held["lines"][1], "Waiting on Ana");
	let ready = &out[1];
	assert_eq!(ready["wants"], true);
	assert_eq!(ready["wp"][0], 2, "now the turn-in");
	assert_eq!(ready["lines"][1], "Everyone's ready");
	assert!(is_match(text(&ready["party"]), r"Everyone's ready$"));
	assert_eq!(ready["holding"], false);
}

#[test]
fn group_a_member_far_away_offline_over_two_minutes_or_left_behind_holds_nothing() {
	let far = run(
		APART,
		r#"
p.set("Ana", { map = 1411 })
stub.advance(6)
emit(state())"#,
	);
	assert_eq!(far[0]["step"], 4, "Ana in another zone");
	let offline = run(
		APART,
		r#"
p.connect("Ana", false)
stub.advance(60)
emit(state())
stub.advance(65)
emit(state())"#,
	);
	assert_eq!(offline[0]["step"], 3, "a short disconnect still holds");
	assert_eq!(offline[1]["step"], 4, "over 2 minutes: on");
	let back = run(
		APART,
		r#"
p.connect("Ana", false)
stub.advance(30)
p.connect("Ana", true)
stub.advance(1)
emit(state())"#,
	);
	assert_eq!(back[0]["step"], 3, "back within the grace: what she sent holds until her snapshot");
	let go_on = run(
		APART,
		r#"
P.GoOn()
stub.advance(1)
emit(state())"#,
	);
	assert_eq!(go_on[0]["step"], 4, "Go on without them");
	let off = run(
		APART,
		r#"
Polestar.Set("party.waitForGroup", false)
stub.advance(1)
emit(state())"#,
	);
	assert_eq!(off[0]["step"], 4, "the wait off");
	let solo = run(
		APART,
		r#"
p.leave("Ana")
stub.advance(1)
emit(state())"#,
	);
	assert_eq!(solo[0]["step"], 4, "solo: never held");
}

#[test]
fn group_a_goal_row_offers_share_when_a_member_lacks_its_quest_and_the_party_line_toggles_the_panel() {
	let out = run(
		APART,
		r#"
p.join("Ben")
-- Ben runs Polestar too (his hello); without it nothing would be said of him.
p.receive("Ben-TestRealm", "1H|0.0.1")
p.onQuest.Ben = { [7] = false }
stub.advance(1)
Polestar.UI.GuideFrame.Update()
local GF = Polestar.UI.GuideFrame
local shares = {}
for _, r in ipairs(GF.rows or {}) do
	if r:IsShown() and r.Share:IsShown() then shares[#shares + 1] = r.psGoal.index end
end
emit(shares)
local PP = Polestar.UI.PartyPanel
emit(PP.Frame() ~= nil and PP.Frame():IsShown())
GF.party:Click()
emit({ Polestar.Get("party.panel"), PP.Frame():IsShown() })
GF.party:Click()
emit({ Polestar.Get("party.panel"), PP.Frame():IsShown() })"#,
	);
	assert_eq!(out[0], json!([1]), "once, on the kobolds' row");
	assert_eq!(out[1], true, "the panel opened by itself once a member was heard");
	assert_eq!(out[2], json!([false, false]), "a click on the party line closes it");
	assert_eq!(out[3], json!([true, true]), "and opens it again");
}

#[test]
fn group_a_member_s_xp_shows_on_the_party_panel_within_the_message_delay_without_waiting_for_its_ticker() {
	let out = run(
		APART,
		r#"
p.join("Ben")
p.receive("Ben-TestRealm", "1H|0.0.1")
p.receive("Ben-TestRealm", "2U|12|40|1|1")
stub.advance(1)
local PP = Polestar.UI.PartyPanel
-- Ben's row (Ana, the fixture's member, has one too).
local function level()
	if not PP.Frame():IsShown() then return false end
	for _, r in ipairs(PP.Frame().rows) do
		if r:IsShown() and r.psName == "Ben" then return r.Level:GetText() end
	end
	return false
end
emit(level())
-- Half a second on (the panel's own repaint is every 2 s): his next kill's XP is there.
stub.advance(1.4)
p.receive("Ben-TestRealm", "2U|12|43|1|1")
stub.advance(0.55)
emit(level())"#,
	);
	assert!(is_match(text(&out[0]), r"^Level 12\D+40% XP$"), "{}", out[0]);
	assert!(is_match(text(&out[1]), r"^Level 12\D+43% XP$"), "{}", out[1]);
}

#[test]
fn group_the_party_panel_reads_the_party_once_per_repaint() {
	let out = run(
		APART,
		r#"
p.join("Ben")
p.receive("Ben-TestRealm", "1H|0.0.1")
stub.advance(1)
local P, PP = Polestar.Party, Polestar.UI.PartyPanel
local roster, reads = P.Roster, 0
P.Roster = function(...) reads = reads + 1; return roster(...) end
PP.Sync()
emit({ reads, PP.Frame():IsShown() })
reads = 0
PP.Refresh()
emit(reads)"#,
	);
	assert_eq!(out[0], json!([1, true]), "whether to show and what to show: one read");
	assert_eq!(out[1], 1);
}
