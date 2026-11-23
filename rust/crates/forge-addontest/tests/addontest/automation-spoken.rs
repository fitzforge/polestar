//! behavior.spokenDelay: Spoken Quests records a quest page in its own handler of the event that opened the
//! window, and it loads after Polestar, so automation acting inside Polestar's handler leaves it nothing to read.
//! With Spoken Quests installed the setting is on by default, and each window waits before automation acts on
//! it; everything is decided when the wait ends.
//! `w.questDetail`/`w.gossip`/`w.questProgress` stand for the window opening, `stub.advance` for the wait.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const STEPS: &str = r#"Polestar.RegisterGuide({
	id = "test/spoken", pack = "test", title = "Spoken", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "Quest 783" } } },
		{ goals = { { t = "turnin", quest = 476, title = "Quest 476" } } },
		{ goals = { { t = "accept", quest = 33, title = "Quest 33" } } },
	},
})
"#;

const MAP: &str = r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42)"#;

// `calls()`: the quest actions so far, as "call quest, call quest"; `set(on)`: the setting.
const CALLS: &str = r#"
	local function calls()
		local c = {}
		for i, x in ipairs(w.calls) do c[i] = tostring(x[1]) .. " " .. tostring(x[2]) end
		return table.concat(c, ", ")
	end
	local function set(on) Polestar.Set("behavior.spokenDelay", on) end
"#;

fn run_with(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{MAP}\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("\n{TEST_PACK}\n{TEST_SOURCE}\n{STEPS}\nstub.login()\n{CALLS}\n{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with("stub.addonsLoaded.Spoken_Quests = true", script)
}

// Past the accept step, with quest 476 in the log ready to hand in.
const AT_TURNIN: &str = r#"
	set(false)
	w.onQuest(476, {})
	w.questDetail(823, 783)
	w.calls = {}
	set(true)
"#;

#[test]
fn turned_off_automation_acts_inside_the_event() {
	let out = run(r#"
		set(false)
		w.questDetail(823, 783)
		emit(calls())
	"#);
	assert_eq!(out, vec![json!("AcceptQuest 783")]);
}

#[test]
fn by_default_with_spoken_quests_the_accept_waits_200_ms_so_the_page_outlives_the_event() {
	let out = run(r#"
		w.questDetail(823, 783)
		emit(calls())
		stub.advance(0.15)
		emit(calls())
		stub.advance(0.1)
		emit(calls())
	"#);
	assert_eq!(out, vec![json!(""), json!(""), json!("AcceptQuest 783")]);
}

#[test]
fn without_spoken_quests_the_setting_is_on_but_nothing_waits() {
	let out = run_with(
		"",
		r#"
		emit(Polestar.Automation.Delay() == nil)
		w.questDetail(823, 783)
		emit(calls())
	"#,
	);
	assert_eq!(out, vec![json!(true), json!("AcceptQuest 783")], "without Spoken nothing changes, and its setting is hidden");
}

#[test]
fn a_window_closed_during_the_wait_is_not_acted_on_though_the_client_still_reports_its_quest() {
	let out = run(r#"
		w.questDetail(823, 783)
		stub.advance(0.1)
		w.close()
		GetQuestID = function() return 783 end
		stub.advance(0.5)
		emit(calls())
	"#);
	assert_eq!(out, vec![json!("")]);
}

#[test]
fn shift_held_when_the_wait_ends_skips_the_action() {
	let out = run(r#"
		w.questDetail(823, 783)
		stub.advance(0.1)
		stub.keys.shift = true
		stub.advance(0.5)
		emit(calls())
	"#);
	assert_eq!(out, vec![json!("")]);
}

#[test]
fn a_newer_window_replaces_the_wait_and_acts_once() {
	let out = run(r#"
		w.questDetail(823, 783)
		stub.advance(0.1)
		w.questDetail(823, 783)
		stub.advance(0.15)
		emit(calls())
		stub.advance(0.1)
		emit(calls())
		stub.advance(1)
		emit(#w.calls)
	"#);
	assert_eq!(out, vec![json!(""), json!("AcceptQuest 783"), json!(1)]);
}

#[test]
fn a_gossip_pick_waits_and_its_late_gossip_closed_does_not_drop_the_quest_window_it_opened() {
	let out = run(r#"
		w.gossip(823, { available = { { questID = 783 } } })
		emit(calls())
		stub.advance(0.35)
		emit(calls())
		w.questDetail(823, 783)
		stub.fire("GOSSIP_CLOSED", false)
		stub.advance(0.35)
		emit(calls())
	"#);
	assert_eq!(out[0], json!(""));
	assert_eq!(out[1], json!("C_GossipInfo.SelectAvailableQuest 783"));
	assert_eq!(out[2], json!("C_GossipInfo.SelectAvailableQuest 783, AcceptQuest 783"));
}

#[test]
fn a_gossip_closed_during_its_wait_picks_nothing() {
	let out = run(r#"
		w.gossip(823, { available = { { questID = 783 } } })
		stub.advance(0.1)
		w.close()
		stub.advance(0.5)
		emit(calls())
	"#);
	assert_eq!(out, vec![json!("")]);
}

#[test]
fn a_turn_in_waits_on_the_progress_page_and_again_on_the_reward_page() {
	let out = run(&format!(
		r#"{AT_TURNIN}
		w.questProgress(2078, 476)
		emit(calls())
		stub.advance(0.35)
		emit(calls())
		stub.advance(0.35)
		emit(calls())
	"#
	));
	assert_eq!(out[0], json!(""));
	assert_eq!(out[1], json!("CompleteQuest 476"));
	assert_eq!(out[2], json!("CompleteQuest 476, GetQuestReward 476"));
}

#[test]
fn the_window_the_game_opens_after_a_turn_in_is_still_closed_after_its_wait() {
	let out = run(&format!(
		r#"{AT_TURNIN}
		w.questComplete(2078, 476)
		stub.advance(0.35)
		w.questDetail(2078, 483)
		emit(w.frame ~= nil)
		stub.advance(0.35)
		emit(calls())
		emit(w.frame == nil)
	"#
	));
	assert_eq!(out[0], true);
	assert_eq!(out[1], json!("GetQuestReward 476, CloseQuest 483"));
	assert_eq!(out[2], true);
}

#[test]
fn a_window_the_player_opened_stays_open() {
	let out = run(r#"
		w.questDetail(823, 999)
		stub.advance(1)
		emit(calls())
		emit(w.frame ~= nil)
	"#);
	assert_eq!(out, vec![json!(""), json!(true)]);
}
