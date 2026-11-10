//! Party sync by step identity and "sync to my guide" (Quests/Party.lua) with a real guide compiled from DSL
//! and the whole addon, against the fake client and party (tests/lua/stub_party.lua). The guide has a
//! Warrior-only step between two shared ones: a Warrior and a Mage on the same shared step are in sync, one a
//! real step ahead is "1 step ahead", whatever their numbers; a member who sends only the 0.3.5 "1P|" line is
//! still placed. A member's "sync to my guide" is a prompt the player accepts (the guide moves to their step,
//! opening it in a tab when needed; earlier ticks and skips stay, and one undo takes the sync back) or
//! declines (nothing changes), from party members only, once per 30 s each way, with what the move passes.

use forge_addontest::dsl::{compile_with, fixture_data, write_our_test_pack};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

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

step Warriors see Llane
  only Warrior
  goto 50.2,42.3 "Llane Beshere"

step Kobolds
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7

step Goldshire
  goto 42.1,65.9 "Goldshire"
"#;

const OTHER: &str = r#"guide forever/alliance/human/01-elsewhere
title Elsewhere
faction Alliance
race Human
levels 1-6
zone Elwynn Forest

step Somewhere
  goto 40.0,40.0 "Somewhere"
"#;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 48.5, 42.5)"#;

const MAGE: &str = r#"
stub.world.class, stub.world.className, stub.world.classID = "MAGE", "Mage", 8"#;

// Logged in on the guide, Ana (in the party, heard running Polestar) of class `ANA_CLASS`.
const SETUP: &str = r#"
stub.login()
stub.advance(0.5)
local w, p, P, E = stub.world, stub.party, Polestar.Party, Polestar.Engine
local G = "forever/alliance/human/01-northshire"
E.SetGuide(G)
stub.advance(0.5)
local function at(i) return P.StepKey(Polestar.Guides.Get(G), i) .. "|" .. G end
local function pos1(i, version)
	local m = P.MyPos()
	return "1P|" .. i .. "|0.3.5|" .. m.pack .. "|" .. (version or m.packVersion) .. "|" .. G
end
local function line() return P.StepLine() or false end
-- What went out of the sync request's own ("2G|", "2A|"): snapshots, hellos
-- and positions go out on timers of their own.
local function texts(all)
	local out = {}
	for _, s in ipairs(p.sent) do
		if all or s.text:match("^2[AG]|") then out[#out + 1] = s.text end
	end
	return out
end
local function skipped()
	local out = {}
	for s in pairs(Polestar.CharState().skipped[G] or {}) do out[#out + 1] = s end
	table.sort(out)
	return out
end
local function prompt()
	local last = stub.popups[#stub.popups]
	return last and last.which == "POLESTAR_PARTY_SYNC" and last or nil
end
local dialog = function() return StaticPopupDialogs.POLESTAR_PARTY_SYNC end
p.join("Ana")
p.set("Ana", { class = ANA_CLASS, classID = ANA_ID, race = "Human", raceID = 1 })
stub.advance(1)
p.receive("Ana-TestRealm", "1Y|0.3.6")
stub.advance(1)
"#;

// Quest 783 taken and handed in, quest 7 taken: a Warrior's live step is the Warrior-only one, a Mage's the
// kobolds.
const TO_KOBOLDS: &str = r#"
w.accept(783, {}, "A Threat Within")
stub.advance(0.5)
w.turnIn(783)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
"#;

fn run(before: &str, ana: (&str, u32), script: &str) -> Vec<Value> {
	let data = fixture_data();
	let r = compile_with(&[("northshire.guide", GUIDE), ("elsewhere.guide", OTHER)], &data, None);
	let errors: Vec<String> = r.diag.errors().into_iter().map(forge_guide::diag::format).collect();
	assert_eq!(errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let setup = SETUP.replace("ANA_CLASS", &format!("{:?}", ana.0)).replace("ANA_ID", &ana.1.to_string());
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: format!("{WORLD}\n{before}"),
		addons: vec![Addon::name("Polestar")],
		script: format!("{loads}\n{setup}\n{script}"),
		..Default::default()
	})
}

const MAGE_ANA: (&str, u32) = ("MAGE", 8);
const WARRIOR_ANA: (&str, u32) = ("WARRIOR", 1);

#[test]
fn sync_a_warrior_on_his_own_step_and_a_mage_on_the_next_shared_one_are_on_the_same_step() {
	let out = run(
		"",
		MAGE_ANA,
		&format!(
			"{TO_KOBOLDS}{}",
			r#"
emit(E.GetLiveStep())
p.receive("Ana-TestRealm", pos1(4)); p.receive("Ana-TestRealm", "2P|" .. at(4))
emit(line())
p.receive("Ana-TestRealm", pos1(5)); p.receive("Ana-TestRealm", "2P|" .. at(5))
emit(line())
-- Another pack version: its number means nothing here, the step's key still finds it.
p.receive("Ana-TestRealm", pos1(9, "999")); p.receive("Ana-TestRealm", "2P|" .. at(4))
emit(line())
p.receive("Ana-TestRealm", pos1(9, "999"))
emit(line())
-- A 0.3.5 member: "1P|" alone, by its number on the same pack version, still counting shared steps only.
p.receive("Ana-TestRealm", pos1(4))
emit(line())
p.receive("Ana-TestRealm", pos1(5))
emit(line())"#
		),
	);
	assert_eq!(out[0], 3, "the Warrior's live step is his own (Llane)");
	assert_eq!(out[1], "Ana: on this step", "the Mage on the kobolds: the Warrior-only step between them does not count");
	assert_eq!(out[2], "Ana: 1 step ahead", "a real step ahead");
	assert_eq!(out[3], "Ana: on this step", "matched by its key across pack versions");
	assert_eq!(out[4], false, "another pack version and no key: not placed");
	assert_eq!(out[5], "Ana: on this step", "0.3.5 member");
	assert_eq!(out[6], "Ana: 1 step ahead", "0.3.5 member a step ahead");
}

#[test]
fn sync_a_mage_sees_a_warrior_on_his_own_step_as_on_hers_and_one_shared_step_back_as_behind() {
	let out = run(
		MAGE,
		WARRIOR_ANA,
		&format!(
			"{TO_KOBOLDS}{}",
			r#"
emit(E.GetLiveStep())
p.receive("Ana-TestRealm", pos1(3)); p.receive("Ana-TestRealm", "2P|" .. at(3))
emit(line())
p.receive("Ana-TestRealm", pos1(2)); p.receive("Ana-TestRealm", "2P|" .. at(2))
emit(line())
p.receive("Ana-TestRealm", pos1(5)); p.receive("Ana-TestRealm", "2P|" .. at(5))
emit(line())
-- Her request for her Warrior-only step: the Mage is there already, no prompt.
p.sent = {}
p.receive("Ana-TestRealm", "2G|" .. at(3))
emit({ prompt = prompt() ~= nil, sent = texts() })"#
		),
	);
	assert_eq!(out[0], 4, "the Mage has no Llane step: on the kobolds");
	assert_eq!(out[1], "Ana: on this step");
	assert_eq!(out[2], "Ana: 1 step behind", "one shared step back, not two");
	assert_eq!(out[3], "Ana: 1 step ahead");
	assert_eq!(out[4], json!({ "prompt": false, "sent": ["2A|="] }));
}

#[test]
fn sync_your_place_goes_out_by_number_for_old_clients_and_by_step_key_after_it() {
	let out = run(
		"",
		MAGE_ANA,
		&format!(
			"{TO_KOBOLDS}{}",
			r#"
Polestar.Set("party.share", true)
p.sent = {}
p.receive("Ana-TestRealm", "1H|0.3.5")
stub.advance(8)
local pos = {}
for _, t in ipairs(texts(true)) do if t:match("^[12]P|") then pos[#pos + 1] = t end end
emit(pos)
emit(at(3))
-- What a 0.3.5 client makes of the new lines: nothing (each of its decoders drops them).
local function drops(t) return P.Decode(t) == nil and P.DecodePos(t) == nil and P.DecodeUnit(t) == nil and P.DecodeHello(t) == nil end
emit({ drops("2P|" .. at(3)), drops("2G|" .. at(3)), drops("2A|y") })"#
		),
	);
	let pos = out[0].as_array().unwrap();
	assert!(pos.len() >= 2, "{pos:?}");
	assert!(pos[0].as_str().unwrap().starts_with("1P|3|"), "{pos:?}");
	assert_eq!(pos[1], format!("2P|{}", out[1].as_str().unwrap()), "right after the number, the step's key");
	assert_eq!(out[2], json!([true, true, true]));
}

#[test]
fn sync_accepted_moves_to_her_step_keeps_your_class_step_ticks_and_skips_and_one_undo_takes_it_back() {
	let out = run(
		"",
		MAGE_ANA,
		r#"
-- Both quests taken, 783 not handed in yet: the live step is its hand-in.
w.accept(783, {}, "A Threat Within")
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
-- Your own doing first: the abbey hand-in skipped, Goldshire's goto ticked.
E.Goto(5)
E.Skip()
E.ToggleGoal(6, 1)
stub.advance(0.5)
local before = { live = E.GetLiveStep(), skipped = skipped(), ticked = E.GoalDone(6, 1) }
p.sent = {}
p.receive("Ana-TestRealm", "2G|" .. at(4))
local pr = prompt()
emit({ before = before, prompt = pr and pr.args[1] or false, live = E.GetLiveStep(), sent = #texts() })
dialog().OnAccept(nil, pr.args[3])
stub.advance(0.5)
emit({ live = E.GetLiveStep(), skipped = skipped(), ticked = E.GoalDone(6, 1), sent = texts() })
E.Unskip(2)
stub.advance(0.5)
emit({ live = E.GetLiveStep(), skipped = skipped(), ticked = E.GoalDone(6, 1) })"#,
	);
	let before = &out[0]["before"];
	assert_eq!(before, &json!({ "live": 2, "skipped": [5], "ticked": true }));
	let prompt = out[0]["prompt"].as_str().unwrap();
	assert!(prompt.starts_with("Ana asks you to sync to their guide."), "{prompt}");
	assert!(prompt.contains("Their step: Kobolds"), "{prompt}");
	assert!(prompt.ends_with("Ana is past these, which you haven't done: \u{201c}A Threat Within\u{201d}"), "quest 7, in your log, is not left behind: {prompt}");
	assert!(!prompt.contains("switch"), "same guide: no tab switch: {prompt}");
	assert_eq!(out[0]["live"], 2, "nothing moves before the answer");
	assert_eq!(out[0]["sent"], 0, "never accepted for you");
	assert_eq!(out[1], json!({ "live": 3, "skipped": [2, 5], "ticked": true, "sent": ["2A|y"] }), "the hand-in skipped; Llane, a Warrior's own step the Mage never had, stays yours and is live");
	assert_eq!(out[2], json!({ "live": 2, "skipped": [5], "ticked": true }), "the undo takes back the sync's skips, not yours");
}

#[test]
fn sync_a_mage_accepting_a_warrior_s_request_lands_on_his_step() {
	let out = run(
		MAGE,
		WARRIOR_ANA,
		r#"
w.accept(783, {}, "A Threat Within")
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
p.receive("Ana-TestRealm", "2G|" .. at(4))
dialog().OnAccept(nil, prompt().args[3])
stub.advance(0.5)
emit({ live = E.GetLiveStep(), skipped = skipped() })"#,
	);
	assert_eq!(out[0], json!({ "live": 4, "skipped": [2] }));
}

#[test]
fn sync_with_the_gamepad_interface_shows_no_prompt_and_declines_saying_why() {
	let out = run(
		"\nEnum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }\nC_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }",
		MAGE_ANA,
		r#"
p.sent = {}
stub.messages = {}
p.receive("Ana-TestRealm", "2G|" .. at(4))
emit({ gamepad = Polestar.GamepadUI(), prompt = prompt() ~= nil, live = E.GetLiveStep(), sent = texts(), said = stub.messages[#stub.messages] or false })"#,
	);
	assert_eq!(out[0]["gamepad"], true);
	assert_eq!(out[0]["prompt"], false, "its focus owns the game's dialogs");
	assert_eq!(out[0]["live"], 1);
	assert_eq!(out[0]["sent"], json!(["2A|n"]));
	assert!(out[0]["said"].as_str().unwrap().contains("Ana asked you to sync to their guide; that prompt can't show with the gamepad interface."), "{}", out[0]);
}

#[test]
fn sync_declined_changes_nothing_and_requests_are_rate_limited_and_party_only() {
	let out = run(
		"",
		MAGE_ANA,
		r#"
p.sent = {}
p.receive("Ana-TestRealm", "2G|" .. at(4))
p.receive("Ana-TestRealm", "2G|" .. at(5))
local shown = #stub.popups
dialog().OnCancel(nil, prompt().args[3], "clicked")
stub.advance(0.5)
emit({ shown = shown, live = E.GetLiveStep(), skipped = #skipped(), sent = texts() })
-- Not in the party: never heard.
p.receive("Zed-TestRealm", "2G|" .. at(4))
p.receive("Ana-TestRealm", "2G|" .. at(4), "WHISPER")
emit(#stub.popups)
stub.advance(30)
p.receive("Ana-TestRealm", "2G|" .. at(4))
emit(#stub.popups)
-- The old prompt's buttons no longer answer for the new request.
p.sent = {}
emit({ P.AcceptSync({}), #texts() })"#,
	);
	assert_eq!(out[0], json!({ "shown": 1, "live": 1, "skipped": 0, "sent": ["2A|n"] }), "the second request within 30 s is ignored");
	assert_eq!(out[1], 1, "a sender outside the party, or off the party channel, is ignored");
	assert_eq!(out[2], 2, "30 s later she may ask again");
	assert_eq!(out[3], json!([false, 0]));
}

#[test]
fn sync_on_another_guide_switches_tab_and_notes_what_you_did_already() {
	let out = run(
		"",
		MAGE_ANA,
		r#"
w.complete({ 783 })
E.SetGuide("forever/alliance/human/01-elsewhere")
stub.advance(0.5)
p.receive("Ana-TestRealm", "2G|" .. at(1))
local pr = prompt()
emit(pr.args[1])
dialog().OnAccept(nil, pr.args[3])
stub.advance(0.5)
emit({ guide = E.GetGuide().id, live = E.GetLiveStep() })"#,
	);
	let prompt = out[0].as_str().unwrap();
	assert!(prompt.contains("You'll switch to Northshire Valley."), "{prompt}");
	assert!(prompt.contains("You've done these already, so your guide passes them: \u{201c}A Threat Within\u{201d}"), "{prompt}");
	assert_eq!(out[1], json!({ "guide": "forever/alliance/human/01-northshire", "live": 2 }), "on her step's guide, past the accept done already");
}

#[test]
fn sync_asking_goes_to_the_party_once_per_30_seconds_and_says_who_answered() {
	let out = run(
		"",
		MAGE_ANA,
		&format!(
			"{TO_KOBOLDS}{}",
			r#"
p.join("Ben")
stub.advance(1)
p.sent = {}
stub.messages = {}
local first = P.RequestSync()
local again = P.RequestSync()
emit({ first, again, texts(), at(3) })
p.receive("Ana-TestRealm", "2A|y")
p.receive("Ana-TestRealm", "2A|n")
p.receive("Ben-TestRealm", "2A|n")
emit(stub.messages)"#
		),
	);
	assert_eq!(out[0][0], true);
	assert_eq!(out[0][1], false, "a second ask within 30 s does not go out");
	assert_eq!(out[0][2], json!([format!("2G|{}", out[0][3].as_str().unwrap())]));
	let said: Vec<&str> = out[1].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	assert_eq!(said.len(), 3, "Ana's second answer and Ben's (he was not asked: not heard running Polestar then) say nothing: {said:?}");
	assert!(said[0].contains("Asked your party to sync to your step."), "{said:?}");
	assert!(said[1].contains("You asked a moment ago: wait 30 seconds."), "{said:?}");
	assert!(said[2].contains("Ana synced to your guide."), "{said:?}");
}
