//! The guide window's party line (Quests/Party.lua, Party.StepLine; UI/GuideFrameStatus.lua) with a real guide
//! compiled from DSL and the whole addon, against the fake client and party (tests/lua/stub_party.lua).
//!
//! Under the Atlas layout the line is a card above the window (Polestar_Skins/Layouts/Atlas). Closed with its x it
//! stays closed through any number of steps while the group is the same and the line holds nothing new: only a
//! change of members, or a state it did not have when closed (Waiting on someone, a member ahead, behind or on
//! another guide), brings it back; "With Ana" and "Everyone's ready" never do. While the party panel is open the
//! line says only the wait ("Waiting on Ana", with "Go on without them"), in every layout: the panel already shows
//! who is on which step.

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// Six walking steps (3 to 8) to change steps on, then the kobolds, handed in in the same step.
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

step First bend
  goto 47.0,15.0 "First bend"

step Second bend
  goto 47.0,20.0 "Second bend"

step Third bend
  goto 47.0,25.0 "Third bend"

step Fourth bend
  goto 47.0,30.0 "Fourth bend"

step Fifth bend
  goto 47.0,35.0 "Fifth bend"

step Sixth bend
  goto 47.0,40.0 "Sixth bend"

step Kobolds
  kill 6 x10 quest 7.1
  turnin 7
"#;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 48.5, 42.5)"#;

// Logged in with quest 7 taken, the layout picked, the party panel open or not; `join(name, step)` brings a
// member who runs Polestar to a step, `go(step, names...)` moves you there and the members after you,
// `place(name, step)` moves one member, `card()` what the window shows of the party line now.
const SETUP: &str = r#"
stub.login()
stub.advance(0.5)
local w, p, P, E, GF = stub.world, stub.party, Polestar.Party, Polestar.Engine, Polestar.UI.GuideFrame
local PP = Polestar.UI.PartyPanel
local G = "forever/alliance/human/01-northshire"
E.SetGuide(G)
stub.advance(0.5)
LAYOUT
Polestar.Set("party.panel", PANEL)
w.accept(783, {}, "A Threat Within")
stub.advance(0.5)
w.turnIn(783)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
local function at(i) return P.StepKey(Polestar.Guides.Get(G), i) .. "|" .. G end
local function place(name, i)
	local m = P.MyPos()
	p.receive(name .. "-TestRealm", "1P|" .. i .. "|0.3.5|" .. m.pack .. "|" .. m.packVersion .. "|" .. G)
	p.receive(name .. "-TestRealm", "2P|" .. at(i))
	stub.advance(1)
end
local function join(name, i)
	p.join(name)
	stub.advance(1)
	p.receive(name .. "-TestRealm", "1Y|0.3.6")
	stub.advance(1)
	place(name, i)
end
-- Walk each step's spot until the live step is `i` (the walking steps' spots are 5 apart, at 5 times the step's number), then the members follow.
local function go(i, ...)
	while E.GetLiveStep() < i do
		w.moveTo(1429, 47.0, 5 * E.GetLiveStep())
		stub.advance(1)
	end
	for _, name in ipairs({ ... }) do place(name, i) end
end
-- The party line as the window shows it: shown or not, its text, and whether it stands on a card.
local function card()
	local shown = GF.party:IsShown()
	return { shown, shown and GF.party.Text:GetText() or false, shown and rawget(GF.party:GetParent():GetParent(), "Close") ~= nil or false }
end
-- The card's x: its backing is the card's parent.
local function close() GF.party:GetParent():GetParent().Close:Click() stub.advance(0.5) end
"#;

fn run(layout: &str, panel: bool, script: &str) -> Vec<Value> {
	let data = fixture_data();
	let r = compile_with(&[("northshire.guide", GUIDE)], &data, None);
	let errors: Vec<String> = r.diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let pick = if layout == "atlas" { "Polestar.Theme.SetLayout(\"atlas\")\nstub.advance(0.5)" } else { "" };
	let setup = SETUP.replace("LAYOUT", pick).replace("PANEL", if panel { "true" } else { "false" });
	let mut addons = vec![Addon::name("Polestar")];
	if layout == "atlas" {
		addons.push(Addon::name("Polestar_Skins"));
	}
	emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_party.lua"], before: WORLD.into(), addons, script: format!("{loads}\n{setup}\n{script}"), ..Default::default() })
}

#[test]
fn atlas_a_closed_party_card_stays_closed_across_five_step_changes_with_the_same_members() {
	let out = run(
		"atlas",
		false,
		r#"
join("Ana", 3)
go(3, "Ana")
emit(card())
close()
emit(card())
for i = 4, 8 do
	go(i, "Ana")
	emit(card())
end
-- The kobolds, you done and Ana done: "Everyone's ready" is not a new state either.
go(9, "Ana")
w.progress(7, 1, 10)
p.onQuest.Ana = { [7] = true }
p.receive("Ana-TestRealm", "1|7:10/10")
stub.advance(1)
emit(card())
emit((P.StepLine()))"#,
	);
	assert_eq!(out[0], json!([true, "With Ana", true]), "on the card above the window");
	assert_eq!(out[1], json!([false, false, false]), "closed");
	for (i, step) in (4..=8).enumerate() {
		assert_eq!(out[2 + i], json!([false, false, false]), "still closed on step {step}");
	}
	assert_eq!(out[7], json!([false, false, false]), "Everyone's ready brings nothing back");
	assert_eq!(out[8], "With Ana  \u{b7}  Everyone's ready", "the line does say so");
}

#[test]
fn atlas_a_closed_party_card_comes_back_when_a_member_joins_or_leaves() {
	let out = run(
		"atlas",
		false,
		r#"
join("Ana", 3)
go(3, "Ana")
close()
emit(card())
join("Ben", 3)
emit(card())
close()
emit(card())
p.leave("Ben")
stub.advance(1)
emit(card())"#,
	);
	assert_eq!(out[0], json!([false, false, false]));
	assert_eq!(out[1], json!([true, "With Ana, Ben", true]), "Ben joined");
	assert_eq!(out[2], json!([false, false, false]), "closed again");
	assert_eq!(out[3], json!([true, "With Ana", true]), "Ben left");
}

#[test]
fn atlas_a_closed_party_card_comes_back_when_the_group_starts_waiting_on_a_member() {
	let out = run(
		"atlas",
		false,
		r#"
join("Ana", 9)
go(9, "Ana")
p.onQuest.Ana = { [7] = true }
p.receive("Ana-TestRealm", "1|7:3/10")
stub.advance(1)
emit(card())
close()
emit(card())
-- Your kobolds are done, Ana's are not: the step waits on her.
w.progress(7, 1, 10)
stub.advance(1)
emit(card())"#,
	);
	assert_eq!(out[0], json!([true, "With Ana", true]));
	assert_eq!(out[1], json!([false, false, false]));
	assert_eq!(out[2], json!([true, "With Ana  \u{b7}  Waiting on Ana", true]));
}

#[test]
fn atlas_a_closed_party_card_comes_back_when_a_member_stays_behind_or_on_another_guide() {
	let out = run(
		"atlas",
		false,
		r#"
join("Ana", 6)
go(6, "Ana")
close()
emit(card())
place("Ana", 4)
emit(card())
stub.advance(7)
emit(card())
close()
emit(card())
-- Another guide: the same two members, so only the new state brings it back.
p.receive("Ana-TestRealm", "1P|2|0.3.5|test|1|forever/alliance/human/02-elsewhere")
stub.advance(1)
emit(card())
stub.advance(7)
emit(card())"#,
	);
	assert_eq!(out[0], json!([false, false, false]));
	assert_eq!(out[1], json!([false, false, false]), "a few seconds behind is a step's lag, not news");
	assert_eq!(out[2], json!([true, "Ana: 2 steps behind", true]), "Ana stayed behind");
	assert_eq!(out[3], json!([false, false, false]));
	assert_eq!(out[4], json!([false, false, false]));
	assert_eq!(out[5], json!([true, "Ana: other guide", true]), "Ana went to another guide");
}

#[test]
fn atlas_the_party_card_does_not_show_while_the_party_panel_is_open_unless_the_group_waits() {
	let out = run(
		"atlas",
		true,
		r#"
join("Ana", 9)
go(9, "Ana")
p.onQuest.Ana = { [7] = true }
p.receive("Ana-TestRealm", "1|7:3/10")
stub.advance(1)
emit({ PP.Frame() ~= nil and PP.Frame():IsShown(), card() })
w.progress(7, 1, 10)
stub.advance(1)
emit({ PP.Frame():IsShown(), card(), GF.party.GoOn:IsShown() })
-- The panel closed: the line is whole again.
PP.Frame().Close:Click()
stub.advance(1)
emit({ PP.Frame():IsShown(), card() })"#,
	);
	assert_eq!(out[0], json!([true, [false, false, false]]), "the panel shows the group: no card");
	assert_eq!(out[1], json!([true, [true, "Waiting on Ana", true], true]), "only the wait, with Go on without them");
	assert_eq!(out[2], json!([false, [true, "With Ana  \u{b7}  Waiting on Ana", true]]), "the panel closed: the whole line");
}

#[test]
fn standard_the_party_line_leaves_the_window_while_the_party_panel_is_open_unless_the_group_waits() {
	let out = run(
		"",
		true,
		r#"
join("Ana", 9)
go(9, "Ana")
p.onQuest.Ana = { [7] = true }
p.receive("Ana-TestRealm", "1|7:3/10")
stub.advance(1)
emit({ PP.Frame() ~= nil and PP.Frame():IsShown(), card() })
w.progress(7, 1, 10)
stub.advance(1)
emit({ PP.Frame():IsShown(), card(), GF.party.GoOn:IsShown() })
PP.Frame().Close:Click()
stub.advance(1)
emit({ PP.Frame():IsShown(), card() })"#,
	);
	assert_eq!(out[0], json!([true, [false, false, false]]), "the panel shows the group: no line");
	assert_eq!(out[1], json!([true, [true, "Waiting on Ana", false], true]), "only the wait, in the window, with Go on without them");
	assert_eq!(out[2], json!([false, [true, "With Ana  \u{b7}  Waiting on Ana", false]]), "the panel closed: the whole line");
}
