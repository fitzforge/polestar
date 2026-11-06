//! Quests/PartyChat.lua: in a party, one party chat line when you finish one of a quest's objectives and
//! one when the quest is ready to turn in, with the client's quest link (setting party.chat, on by
//! default). Against the fake client (tests/lua/stub_world.lua for the quest log, tests/lua/stub_party.lua
//! for the group and the chat API): nothing solo or in a raid, nothing on login, reload or zoning, never
//! twice, a gap between lines, and nothing while the client locks chat.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Quests/Party.lua", "Quests/PartyChat.lua"];
const STUBS: &[&str] = &["stub_world.lua", "stub_party.lua"];
const DEFAULTS: &str = "PolestarDB = { schema = 1 }";

const HELPERS: &str = r#"
local w, p = stub.world, stub.party
local function chat()
	local out = {}
	for i, m in ipairs(p.chat) do out[i] = m.chatType .. " " .. m.text end
	return out
end
-- Plagued Lands: a capture and five hides.
local function plagued(bear, hides)
	return { { text = "Rabid Thistle Bear Captured: 0/1", required = 1, fulfilled = bear or 0 },
		{ text = "Plagued Hide: 0/5", required = 5, fulfilled = hides or 0 } }
end"#;

fn run_with(script: &str, login: bool, saved: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: STUBS.to_vec(),
		before: String::new(),
		saved: vec![("Polestar".to_string(), saved.to_string())],
		addons: vec![Addon::files("Polestar", FILES)],
		login,
		script: format!("{HELPERS}\n{script}"),
	})
}

// Logged in with the default settings.
fn live(script: &str) -> Vec<Value> {
	run_with(script, true, DEFAULTS)
}

fn link(q: u32, title: &str) -> String {
	format!("|cffffff00|Hquest:{q}:0|h[{title}]|h|r")
}

fn finished(objective: &str, q: u32, title: &str) -> String {
	format!("PARTY [Polestar] Finished: {objective} - {}", link(q, title))
}

fn ready(q: u32, title: &str) -> String {
	format!("PARTY [Polestar] Ready to turn in: {}", link(q, title))
}

// The chat lines emitted (an empty Lua table arrives as an object).
fn lines(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

const NONE: Vec<String> = Vec::new();

#[test]
fn party_chat_says_each_finished_objective_and_then_ready_to_turn_in_once_with_the_quest_link() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 2, 1); stub.advance(1)
w.progress(33, 2, 4); stub.advance(1)
local before = chat()
w.progress(33, 1, 1); stub.advance(1)
w.progress(33, 2, 5); stub.advance(3)
emit(before); emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), NONE, "no line for a kill or a loot that finishes nothing");
	assert_eq!(lines(&out[1]), vec![finished("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands"), ready(33, "Plagued Lands")]);
}

#[test]
fn party_chat_the_last_objective_gives_only_the_ready_line() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(1)
for n = 1, 10 do w.progress(7, 1, n); stub.advance(0.3) end
stub.advance(3)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec![ready(7, "Kobold Camp Cleanup")]);
}

#[test]
fn party_chat_says_nothing_solo_in_a_raid_or_with_the_setting_off() {
	let script = r#"
local function play(q)
	w.accept(q, plagued(), "Plagued Lands")
	stub.advance(1)
	w.progress(q, 1, 1); stub.advance(1)
	w.progress(q, 2, 5); stub.advance(3)
end
play(33)
local solo = chat()
p.join("Ana"); p.raid(true)
stub.advance(6)
play(34)
emit(solo); emit(chat())"#;
	let out = live(script);
	assert_eq!(lines(&out[0]), NONE, "solo");
	assert_eq!(lines(&out[1]), NONE, "raid");
	let off = run_with(&format!("p.join(\"Ana\")\nstub.advance(6)\n{script}"), true, "PolestarDB = { schema = 1, settings = { party = { chat = false } } }");
	assert_eq!(lines(&off[1]), NONE, "setting off");
}

#[test]
fn party_chat_says_nothing_on_login_reload_log_rebuilds_or_zoning_then_tells_real_progress() {
	let out = run_with(
		r#"
-- A reload in a party: the log is there, the client fills its counts in after login.
w.onQuest(33, plagued(), "Plagued Lands")
w.onQuest(40, { { text = "Gnoll Paw: 0/3", required = 3 } }, "Gnoll Paws")
p.join("Ana")
stub.login()
-- The first read (0.5 s in) learns zero counts; the real ones come after it.
stub.advance(1.5)
w.progress(33, 1, 1)
w.progress(33, 2, 2)
w.progress(40, 1, 3)
stub.advance(6)
for _ = 1, 3 do stub.fire("QUEST_LOG_UPDATE"); stub.advance(1) end
-- Zoning: the counts read 0 for a moment.
w.progress(33, 2, 0)
stub.fire("PLAYER_ENTERING_WORLD", false, false)
stub.advance(0.2)
w.progress(33, 2, 2)
stub.advance(6)
local quiet = chat()
w.progress(33, 2, 5); stub.advance(3)
emit(quiet); emit(chat())"#,
		false,
		DEFAULTS,
	);
	assert_eq!(lines(&out[0]), NONE);
	assert_eq!(lines(&out[1]), vec![ready(33, "Plagued Lands")]);
}

#[test]
fn party_chat_never_says_the_same_objective_or_quest_twice() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 2, 5); stub.advance(1)
-- A hide destroyed and looted again.
w.progress(33, 2, 4); stub.advance(1)
w.progress(33, 2, 5); stub.advance(1)
for _ = 1, 3 do stub.fire("QUEST_LOG_UPDATE"); stub.advance(1) end
w.progress(33, 1, 1); stub.advance(3)
w.progress(33, 1, 0); stub.advance(1)
w.progress(33, 1, 1); stub.advance(3)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec![finished("Plagued Hide 5/5", 33, "Plagued Lands"), ready(33, "Plagued Lands")]);
}

#[test]
fn party_chat_a_quest_taken_with_its_objective_already_met_says_only_what_changes_after() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(0, 5), "Plagued Lands")
stub.advance(2)
local taken = chat()
w.progress(33, 1, 1); stub.advance(3)
emit(taken); emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), NONE);
	assert_eq!(lines(&out[1]), vec![ready(33, "Plagued Lands")]);
}

#[test]
fn party_chat_lines_at_once_go_out_spaced() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
w.accept(34, { { text = "Gnoll Paw: 0/3", required = 3 }, { text = "Gnoll Mane: 0/1", required = 1 } }, "Gnoll Paws")
stub.advance(1)
w.progress(33, 1, 1)
w.progress(34, 1, 3)
stub.advance(5)
local at = {}
for i, m in ipairs(p.chat) do at[i] = m.at end
emit(chat()); emit(at)"#,
	);
	assert_eq!(out[0], json!([finished("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands"), finished("Gnoll Paw 3/3", 34, "Gnoll Paws")]));
	let at: Vec<f64> = out[1].as_array().unwrap().iter().map(|v| v.as_f64().unwrap()).collect();
	assert!(at[1] - at[0] >= 1.4, "lines {:.2} s apart", at[1] - at[0]);
}

#[test]
fn party_chat_waits_out_a_chat_lockdown_and_drops_lines_older_than_two_minutes() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
w.accept(34, { { text = "Gnoll Paw: 0/3", required = 3 }, { text = "Gnoll Mane: 0/1", required = 1 } }, "Gnoll Paws")
stub.advance(1)
p.lockdown = true
w.progress(33, 1, 1); stub.advance(10)
local locked = chat()
p.lockdown = false
stub.advance(3)
local after = chat()
p.lockdown = true
w.progress(34, 1, 3); stub.advance(130)
p.lockdown = false
stub.advance(5)
emit(locked); emit(after); emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), NONE);
	assert_eq!(lines(&out[1]), vec![finished("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands")]);
	assert_eq!(lines(&out[2]), lines(&out[1]), "the line held over two minutes is dropped");
}

#[test]
fn party_chat_in_an_instance_group_uses_instance_chat_and_without_a_link_the_title() {
	let out = live(
		r#"
p.instance = true
p.noLinks = true
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 1, 1); stub.advance(3)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec!["INSTANCE_CHAT [Polestar] Finished: Rabid Thistle Bear Captured 1/1 - [Plagued Lands]".to_string()]);
}

#[test]
fn party_chat_the_first_line_says_once_where_to_turn_it_off() {
	let out = live(
		r#"
local function told()
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find("Polestar told your party", 1, true) then n = n + 1 end end
	return n
end
p.join("Ana")
stub.advance(6)
local before = told()
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 1, 1); stub.advance(3)
w.progress(33, 2, 5); stub.advance(3)
emit(before); emit(told()); emit(#p.chat); emit(PolestarDB.partyChatTold == true)"#,
	);
	assert_eq!(out, vec![json!(0), json!(1), json!(2), json!(true)]);
}
