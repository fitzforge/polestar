//! Issue #360 (AurumTitanos): after Polestar's own accept or turn-in, the game opens the NPC's next window by
//! itself: the follow-up of the quest just handed in, or the NPC's other quests again. With
//! behavior.closeSkipped (on by default) Automation closes that window when it shows nothing the guide takes;
//! one the player opened, one with a quest the guide wants, one in combat or with Shift held stays open. Each
//! reported case is one test; `w.questDetail`/`w.greeting`/`w.gossip` after the turn-in or accept stand for the
//! window the game opens, `stub.runTimers()` for the next frame.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

// steps: Lua step tables, e.g. '{ goals = { { t = "turnin", quest = 476, title = "Quest 476" } } }'.
fn guide(steps: &[String]) -> String {
	format!(
		"\n{TEST_PACK}\n{TEST_SOURCE}\nPolestar.RegisterGuide({{\n\tid = \"test/close\", pack = \"test\", title = \"Close\", minLevel = 1, maxLevel = 20,\n\tsteps = {{ {} }},\n}})",
		steps.join(",\n")
	)
}

const TAIL: &str = r#"
			local c = {}
			for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end
			emit({ calls = c, open = w.frame and (w.frame.kind .. " " .. tostring(w.frame.questID)) or "none" })"#;

fn run(before: &str, steps: &[String], script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("w = stub.world; w.addMap(1429, {{ name = \"Elwynn Forest\", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }}); w.moveTo(1429, 48, 42)\n{before}"),
		addons: vec![core()],
		script: format!("{}\nstub.login()\n{script}{TAIL}", guide(steps)),
		..Default::default()
	})
	.remove(0)
}

fn goal(t: &str, q: i32) -> String {
	format!("{{ t = \"{t}\", quest = {q}, title = \"Quest {q}\" }}")
}

fn turnin(q: i32) -> String {
	format!("{{ goals = {{ {} }} }}", goal("turnin", q))
}

fn accept(q: i32) -> String {
	format!("{{ goals = {{ {} }} }}", goal("accept", q))
}

// The route's next step, at another NPC.
fn away() -> String {
	accept(33)
}

fn reward(q: i32) -> Vec<String> {
	vec![format!("CompleteQuest {q} nil"), format!("GetQuestReward {q} 0")]
}

fn l(items: &[&str]) -> Vec<String> {
	items.iter().map(|s| s.to_string()).collect()
}

#[test]
fn t_360_athridas_bearmantle_the_follow_up_the_game_offers_after_the_turn_in_is_closed() {
	let out = run(
		"w.onQuest(476, {})",
		&[turnin(476), away()],
		r#"
			w.gossip(2078, { active = { { questID = 476, isComplete = true } } })
			w.questDetail(2078, 483, { title = "The Relics of Wakening" })
			stub.runTimers()"#,
	);
	let calls = [l(&["C_GossipInfo.SelectActiveQuest 476 nil"]), reward(476), l(&["CloseQuest 483 nil"])].concat();
	assert_eq!(out, json!({ "calls": calls, "open": "none" }));
}

#[test]
fn t_360_tallonkai_swiftroot_a_follow_up_the_route_leaves_out_is_closed_twisted_hatred_932_then_98403() {
	let out = run(
		"w.onQuest(932, {})",
		&[turnin(932), away()],
		r#"
			w.questProgress(3567, 932)
			w.questDetail(3567, 98403, { title = "Twisted Hatred" })
			stub.runTimers()"#,
	);
	let calls = [reward(932), l(&["CloseQuest 98403 nil"])].concat();
	assert_eq!(out, json!({ "calls": calls, "open": "none" }));
}

#[test]
fn t_360_fandral_staghelm_the_skipped_follow_up_is_closed_and_the_next_talk_still_accepts_the_quest_the_guide_wants_there() {
	let out = run(
		"w.onQuest(935, {}); w.onQuest(940, {})",
		&[format!("{{ goals = {{ {}, {}, {} }} }}", goal("turnin", 935), goal("turnin", 940), goal("accept", 98046)), away()],
		r#"
			w.gossip(3516, { active = { { questID = 935, isComplete = true }, { questID = 940, isComplete = true } }, available = { { questID = 98046 } } })
			-- after 935 the game shows the NPC's quests again: Polestar carries on
			w.gossip(3516, { active = { { questID = 940, isComplete = true } }, available = { { questID = 98046 } } })
			-- after 940 it offers the follow-up, Grove of the Ancients
			w.questDetail(3516, 952, { title = "Grove of the Ancients" })
			stub.runTimers()
			stub.advance(5)
			-- the player talks to him again
			w.gossip(3516, { available = { { questID = 952 }, { questID = 98046 } } })
			w.gossip(3516, { available = { { questID = 952 } } })
			stub.runTimers()"#,
	);
	let calls = [
		l(&["C_GossipInfo.SelectActiveQuest 935 nil"]),
		reward(935),
		l(&["C_GossipInfo.SelectActiveQuest 940 nil"]),
		reward(940),
		l(&["CloseQuest 952 nil", "C_GossipInfo.SelectAvailableQuest 98046 nil", "AcceptQuest 98046 nil", "C_GossipInfo.CloseGossip nil nil"]),
	]
	.concat();
	assert_eq!(out, json!({ "calls": calls, "open": "none" }));
}

#[test]
fn t_360_rellian_greenspyre_from_the_greeting_panel_too_tumors_after_922() {
	let out = run(
		"w.onQuest(922, {})",
		&[turnin(922), away()],
		r#"
			w.greeting(3517, { active = { { questID = 922, isComplete = true } } })
			w.questDetail(3517, 923, { title = "Tumors" })
			stub.runTimers()"#,
	);
	let calls = [l(&["SelectActiveQuest 922 1"]), reward(922), l(&["CloseQuest 923 nil"])].concat();
	assert_eq!(out, json!({ "calls": calls, "open": "none" }));
}

#[test]
fn t_360_sister_aquinne_the_temple_of_the_moon_after_the_sisterhood_of_elune_is_closed() {
	let out = run(
		"w.onQuest(98391, {})",
		&[turnin(98391), away()],
		r#"
			w.questComplete(7316, 98391)
			w.questDetail(7316, 2519, { title = "The Temple of the Moon" })
			stub.runTimers()"#,
	);
	assert_eq!(out, json!({ "calls": ["GetQuestReward 98391 0", "CloseQuest 2519 nil"], "open": "none" }));
}

#[test]
fn t_360_marshal_dughan_and_remy_two_times_the_other_quest_the_npc_offers_after_an_accept_is_closed() {
	let out = run(
		"",
		&[accept(109), accept(40), away()],
		r#"
			w.questDetail(240, 109)
			w.questDetail(240, 62, { title = "The Fargodeep Mine" })
			stub.runTimers()
			w.questDetail(241, 40)
			w.questDetail(241, 47, { title = "Gold Dust Exchange" })
			stub.runTimers()"#,
	);
	assert_eq!(
		out,
		json!({
			"calls": ["AcceptQuest 109 nil", "CloseQuest 62 nil", "AcceptQuest 40 nil", "CloseQuest 47 nil"],
			"open": "none",
		})
	);
}

#[test]
fn t_360_gryan_stoutmantle_the_quest_list_left_after_the_turn_in_and_the_accept_is_closed() {
	let out = run(
		"w.onQuest(109, {})",
		&[format!("{{ goals = {{ {}, {} }} }}", goal("turnin", 109), goal("accept", 12)), accept(102)],
		r#"
			w.greeting(234, { active = { { questID = 109, isComplete = true } } })
			w.greeting(234, { available = { { questID = 12 }, { questID = 65 } } })
			-- the game lists the quest just taken and the one the guide skips
			w.greeting(234, { active = { { questID = 12, isComplete = false } }, available = { { questID = 65 } } })
			stub.runTimers()"#,
	);
	let calls = [l(&["SelectActiveQuest 109 1"]), reward(109), l(&["SelectAvailableQuest 12 1", "AcceptQuest 12 nil", "CloseQuest nil nil"])].concat();
	assert_eq!(out, json!({ "calls": calls, "open": "none" }));
}

// What is never closed.

const ATHRIDAS: &str = r#"
	w.questProgress(2078, 476)
	w.questDetail(2078, 483, { title = "The Relics of Wakening" })
	stub.runTimers()"#;

#[test]
fn t_360_a_window_the_player_opens_is_never_closed_a_quest_picked_from_the_list_one_opened_later_another_npc() {
	let from_list = run(
		"w.onQuest(476, {})",
		&[turnin(476), away()],
		r#"
			w.questProgress(2078, 476)
			w.gossip(2078, { available = { { questID = 483 } }, options = { { name = "Tell me about druids." } } })
			stub.runTimers()
			C_GossipInfo.SelectAvailableQuest(483)  -- the player's click
			stub.runTimers()"#,
	);
	let calls = [reward(476), l(&["C_GossipInfo.SelectAvailableQuest 483 nil"])].concat();
	assert_eq!(from_list, json!({ "calls": calls, "open": "detail 483" }));

	let late = run(
		"w.onQuest(476, {})",
		&[turnin(476), away()],
		r#"
			w.questProgress(2078, 476)
			stub.advance(3)
			w.questDetail(2078, 483, { title = "The Relics of Wakening" })
			stub.runTimers()"#,
	);
	assert_eq!(late, json!({ "calls": reward(476), "open": "detail 483" }));

	let other_npc = run(
		"w.onQuest(476, {})",
		&[turnin(476), away()],
		r#"
			w.questProgress(2078, 476)
			w.questDetail(3567, 483, { title = "The Relics of Wakening" })
			stub.runTimers()"#,
	);
	assert_eq!(other_npc, json!({ "calls": reward(476), "open": "detail 483" }));
}

#[test]
fn t_360_a_quest_the_guide_wants_stays_open_even_when_polestar_leaves_its_accept_to_the_player() {
	let out = run("w.onQuest(476, {})", &[turnin(476), accept(483)], &format!("\n\t\t\tPolestar.Set(\"behavior.autoAccept\", false)\n\t\t\t{ATHRIDAS}"));
	assert_eq!(out, json!({ "calls": reward(476), "open": "detail 483" }));

	let list = run(
		"w.onQuest(476, {}); w.onQuest(7, { 10 })",
		&[turnin(476), away(), turnin(7)],
		r#"
			w.questProgress(2078, 476)
			w.greeting(2078, { active = { { questID = 7, isComplete = false } }, available = { { questID = 483 } } })
			stub.runTimers()"#,
	);
	assert_eq!(list, json!({ "calls": reward(476), "open": "greeting nil" }), "a quest the guide turns in later is listed");
}

#[test]
fn t_360_nothing_is_closed_in_combat_with_shift_held_with_the_setting_off_or_on_a_gossip_with_other_services() {
	let steps = [turnin(476), away()];
	let before = "w.onQuest(476, {})";
	let combat = run(
		before,
		&steps,
		r#"
		w.questProgress(2078, 476)
		w.questDetail(2078, 483)
		stub.inCombat = true
		stub.runTimers()"#,
	);
	let shift = run(
		before,
		&steps,
		r#"
		w.questProgress(2078, 476)
		w.questDetail(2078, 483)
		stub.keys.shift = true
		stub.runTimers()"#,
	);
	let off = run(before, &steps, &format!("Polestar.Set(\"behavior.closeSkipped\", false)\n{ATHRIDAS}"));
	let services = run(
		before,
		&steps,
		r#"
		w.questProgress(2078, 476)
		w.gossip(2078, { available = { { questID = 483 } }, options = { { name = "Train me." } } })
		stub.runTimers()"#,
	);
	assert_eq!(
		json!([combat, shift, off, services]),
		json!([
			{ "calls": reward(476), "open": "detail 483" },
			{ "calls": reward(476), "open": "detail 483" },
			{ "calls": reward(476), "open": "detail 483" },
			{ "calls": reward(476), "open": "gossip nil" },
		])
	);
	let plain = run(
		before,
		&steps,
		r#"
		w.questProgress(2078, 476)
		w.gossip(2078, { available = { { questID = 483 } } })
		stub.runTimers()"#,
	);
	let calls = [reward(476), l(&["C_GossipInfo.CloseGossip nil nil"])].concat();
	assert_eq!(plain, json!({ "calls": calls, "open": "none" }), "a gossip that only lists quests is closed");
}

#[test]
fn t_360_the_setting_is_on_by_default() {
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![core()], script: "stub.login()\nemit(Polestar.Get(\"behavior.closeSkipped\"))".into(), ..Default::default() });
	assert_eq!(out[0], true);
}
