//! "Accept guide quests" off (behavior.autoAccept false) with "Turn in guide quests" on and every other
//! default (Skip single-option gossip, Pick what the step asks for, Close offers the guide skips): the whole
//! Polestar addon (QoL, Dungeons and UI loaded, not Core alone) never accepts a quest, at a quest window of
//! the guide's, a gossip or greeting offering one, the follow-up the game opens after Polestar's own turn-in
//! (an auto-accept one too), with Spoken Quests' wait, or in a second tab (a dungeon's pick-up guide).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const GUIDES: &str = r#"Polestar.RegisterGuide({
	id = "test/off", pack = "test", title = "Accept off", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "Quest 783", npc = 823, npcName = "Deputy Willem" } } },
		{ goals = {
			{ t = "turnin", quest = 783, title = "Quest 783", npc = 197, npcName = "Marshal McBride" },
			{ t = "accept", quest = 7, title = "Quest 7", npc = 197, npcName = "Marshal McBride" },
		} },
		{ goals = { { t = "accept", quest = 33, title = "Quest 33" } } },
	},
})
Polestar.RegisterGuide({
	id = "test/pickup", pack = "test", title = "Pick up the quests", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 1000, title = "Quest 1000", npc = 900, npcName = "Dungeon Giver" } } } },
})
"#;

const MAP: &str = r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42)"#;

const TAIL: &str = r#"
stub.advance(0.5); stub.runTimers()
local c = {}
for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end
local log = {}
for _, q in ipairs({ 7, 33, 783, 1000 }) do if w.log[q] then log[#log + 1] = q end end
emit({ calls = c, log = log, open = w.frame and (w.frame.kind .. " " .. tostring(w.frame.questID)) or "none" })"#;

fn run_with(accept: bool, before: &str, script: &str) -> Value {
	let set = format!("Polestar.Set(\"behavior.autoAccept\", {accept})");
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{MAP}\n{before}"),
		addons: vec![Addon::name("Polestar")],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, "stub.login()", &set, "stub.fire(\"QUEST_LOG_UPDATE\"); stub.advance(0.6)", script, TAIL].join("\n"),
		..Default::default()
	})
	.remove(0)
}

fn run(before: &str, script: &str) -> Value {
	run_with(false, before, script)
}

// The same windows with the setting on accept, so the runs above see an accept when one is made.
#[test]
fn with_the_setting_on_the_same_windows_accept() {
	let detail = run_with(true, "", "w.questDetail(823, 783)");
	assert_eq!(detail["calls"], json!(["AcceptQuest 783 nil"]));
	let follow_up = run_with(
		true,
		"stub.addonsLoaded.Spoken_Quests = true",
		r#"w.onQuest(783, {}); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
		w.gossip(197, { active = { { questID = 783, isComplete = true } } }); stub.advance(0.25); stub.advance(0.25); stub.advance(0.25)
		w.questDetail(197, 7)"#,
	);
	assert_eq!(follow_up["log"], json!([7]));
	let pickup = run_with(true, "", r#"Polestar.Engine.OpenTab("test/pickup", true); stub.advance(0.6); w.questDetail(900, 1000)"#);
	assert_eq!(pickup["log"], json!([1000]));
}

fn l(items: &[&str]) -> Vec<String> {
	items.iter().map(|s| s.to_string()).collect()
}

#[test]
fn the_settings_under_test_are_what_the_player_has() {
	let out = run(
		"",
		r#"emit({ accept = Polestar.Get("behavior.autoAccept"), turnin = Polestar.Get("behavior.autoTurnin"), close = Polestar.Get("behavior.closeSkipped"),
		skip = Polestar.QoL.On("skipGossip"), step = Polestar.QoL.On("stepGossip"), live = Polestar.Engine.GetLiveStep() })"#,
	);
	assert_eq!(out, json!({ "accept": false, "turnin": true, "close": true, "skip": true, "step": true, "live": 1 }));
}

#[test]
fn the_guides_quest_window_is_left_to_the_player() {
	let out = run("", "w.questDetail(823, 783)");
	assert_eq!(out, json!({ "calls": {}, "log": {}, "open": "detail 783" }));
}

#[test]
fn a_gossip_or_greeting_offering_the_guides_quest_is_left_to_the_player() {
	for script in [
		"w.gossip(823, { available = { { questID = 783 } } })",
		"w.gossip(823, { available = { { questID = 783 } }, options = { { name = \"What is happening here?\" } } })",
		"w.greeting(823, { available = { { questID = 999 }, { questID = 783 } } })",
	] {
		let out = run("", script);
		assert_eq!(out["calls"], json!({}), "{script}");
		assert_eq!(out["log"], json!({}), "{script}");
	}
}

#[test]
fn the_follow_up_the_game_opens_after_polestars_turn_in_is_not_accepted() {
	let expect = [l(&["C_GossipInfo.SelectActiveQuest 783 nil", "CompleteQuest 783 nil", "GetQuestReward 783 0"])].concat();
	for (name, before, follow_up) in [
		("detail", "", "w.questDetail(197, 7)"),
		("auto-accept detail", "", "w.questDetail(197, 7, { auto = true })"),
		("gossip", "", "w.gossip(197, { available = { { questID = 7 } } })"),
		("greeting", "", "w.greeting(197, { available = { { questID = 7 } } })"),
		("detail, Spoken's wait", "stub.addonsLoaded.Spoken_Quests = true", "w.questDetail(197, 7)"),
	] {
		let out = run(
			before,
			&format!(
				r#"
				w.onQuest(783, {{}}); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
				-- Gossip, progress, reward: each window waits Spoken's 0.2 s when it is installed.
				w.gossip(197, {{ active = {{ {{ questID = 783, isComplete = true }} }} }}); stub.advance(0.25); stub.advance(0.25); stub.advance(0.25)
				{follow_up}"#
			),
		);
		assert_eq!(out["calls"], json!(expect), "{name}");
		assert_eq!(out["log"], json!({}), "{name}: nothing accepted");
	}
}

#[test]
fn a_second_tab_such_as_a_dungeons_pick_up_guide_accepts_nothing_either() {
	let out = run(
		"",
		r#"Polestar.Engine.OpenTab("test/pickup", true); stub.advance(0.6)
		w.gossip(900, { available = { { questID = 1000 } } }); stub.advance(0.25); w.close()
		w.questDetail(900, 1000)"#,
	);
	assert_eq!(out, json!({ "calls": {}, "log": {}, "open": "detail 1000" }));
}
