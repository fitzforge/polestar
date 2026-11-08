//! Quests/PartyChat.lua: in a party, a star-marked party chat line ("{rt1} Polestar: ") when you finish
//! a quest's objectives (those finished within 3 s in one line), one when the quest is ready to turn in,
//! and one when you loot an item that starts a quest, with the client's links (settings party.chat and
//! party.chatLoot, on by default). Against the fake client (tests/lua/stub_world.lua for the quest log,
//! tests/lua/stub_party.lua for the group, the chat API and the chat filters): nothing solo or in a raid,
//! nothing on login, reload or zoning, never twice, a gap between lines, nothing while the client locks
//! chat, no square brackets outside links, each line under 255 bytes, the marker in each language, and
//! the options: own lines shown, others' hidden, quiet while everyone runs Polestar.

use forge_addontest::{emitted, lua_string, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Quests/Party.lua", "Quests/PartyChat.lua"];
const STUBS: &[&str] = &["stub_world.lua", "stub_party.lua"];
const DEFAULTS: &str = "PolestarDB = { schema = 1 }";
const MARK: &str = "{rt1} Polestar: ";
const ICON: &str = "|TInterface\\AddOns\\Polestar\\Media\\UI\\logo:0|t";

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

fn run_full(script: &str, login: bool, saved: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: STUBS.to_vec(),
		before: before.to_string(),
		saved: vec![("Polestar".to_string(), saved.to_string())],
		addons: vec![Addon::files("Polestar", FILES)],
		login,
		script: format!("{HELPERS}\n{script}"),
	})
}

fn run_with(script: &str, login: bool, saved: &str) -> Vec<Value> {
	run_full(script, login, saved, "")
}

// Logged in with the default settings.
fn live(script: &str) -> Vec<Value> {
	run_with(script, true, DEFAULTS)
}

// Logged in with these party settings ("chatEcho = true").
fn with_settings(script: &str, party: &str) -> Vec<Value> {
	run_with(script, true, &format!("PolestarDB = {{ schema = 1, settings = {{ party = {{ {party} }} }} }}"))
}

// Logged in on a client in `locale`.
fn in_locale(script: &str, locale: &str) -> Vec<Value> {
	run_full(script, true, DEFAULTS, &format!("function GetLocale() return {} end", lua_string(locale)))
}

fn link(q: u32, title: &str) -> String {
	format!("|cffffff00|Hquest:{q}:0|h[{title}]|h|r")
}

fn item_link(id: u32, name: &str) -> String {
	format!("|cffffffff|Hitem:{id}::::::::1:::::::|h[{name}]|h|r")
}

fn objectives(list: &str, q: u32, title: &str) -> String {
	format!("PARTY {MARK}{} {list}", link(q, title))
}

fn ready(q: u32, title: &str) -> String {
	format!("PARTY {MARK}{} is ready to turn in", link(q, title))
}

// The chat lines emitted (an empty Lua table arrives as an object).
fn lines(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

// A line with every link's "[name]" taken out: what is left must carry no
// square bracket (the server rewrites plain ones).
fn outside_links(line: &str) -> String {
	let mut out = String::new();
	let mut rest = line;
	while let Some(i) = rest.find("|h[") {
		out.push_str(&rest[..i]);
		match rest[i..].find("]|h") {
			Some(j) => rest = &rest[i + j + 3..],
			None => {
				rest = &rest[i..];
				break;
			}
		}
	}
	out.push_str(rest);
	out
}

fn no_plain_brackets(all: &[String]) {
	for l in all {
		let o = outside_links(l);
		assert!(!o.contains('[') && !o.contains(']'), "plain brackets in {l:?}");
	}
}

const NONE: Vec<String> = Vec::new();

#[test]
fn party_chat_says_finished_objectives_and_then_ready_to_turn_in_once_with_the_quest_link() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 2, 1); stub.advance(1)
w.progress(33, 2, 4); stub.advance(1)
local before = chat()
w.progress(33, 1, 1); stub.advance(5)
w.progress(33, 2, 5); stub.advance(3)
emit(before); emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), NONE, "no line for a kill or a loot that finishes nothing");
	let all = lines(&out[1]);
	assert_eq!(all, vec![objectives("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands"), ready(33, "Plagued Lands")]);
	no_plain_brackets(&all);
}

#[test]
fn party_chat_two_objectives_finished_within_three_seconds_go_out_as_one_line() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(50, { { text = "Plagued Hide: 0/5", required = 5 }, { text = "Rabid Wolves slain: 0/8", required = 8 }, { text = "Gnoll Mane: 0/1", required = 1 } }, "Plagued Lands")
stub.advance(1)
w.progress(50, 1, 5); stub.advance(1)
w.progress(50, 2, 8); stub.advance(4)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec![objectives("Plagued Hide 5/5, Rabid Wolves 8/8", 50, "Plagued Lands")]);
}

#[test]
fn party_chat_ready_within_the_window_replaces_the_objectives_waiting() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 1, 1); stub.advance(1)
w.progress(33, 2, 5); stub.advance(6)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec![ready(33, "Plagued Lands")]);
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
stub.advance(4)
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
	w.progress(q, 1, 1); stub.advance(5)
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
	let off = with_settings(&format!("p.join(\"Ana\")\nstub.advance(6)\n{script}"), "chat = false");
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
	assert_eq!(lines(&out[0]), vec![objectives("Plagued Hide 5/5", 33, "Plagued Lands"), ready(33, "Plagued Lands")]);
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
stub.advance(7)
local at = {}
for i, m in ipairs(p.chat) do at[i] = m.at end
emit(chat()); emit(at)"#,
	);
	assert_eq!(out[0], json!([objectives("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands"), objectives("Gnoll Paw 3/3", 34, "Gnoll Paws")]));
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
	assert_eq!(lines(&out[1]), vec![objectives("Rabid Thistle Bear Captured 1/1", 33, "Plagued Lands")]);
	assert_eq!(lines(&out[2]), lines(&out[1]), "the line held over two minutes is dropped");
}

#[test]
fn party_chat_in_an_instance_group_uses_instance_chat_and_without_a_link_the_plain_title() {
	let out = live(
		r#"
p.instance = true
p.noLinks = true
p.join("Ana")
stub.advance(6)
w.accept(33, { { text = "[Cursed] Hide: 0/1", required = 1 }, { text = "Plagued Hide: 0/5", required = 5 } }, "Plagued [Lands]")
stub.advance(1)
w.progress(33, 1, 1); stub.advance(5)
emit(chat())"#,
	);
	let all = lines(&out[0]);
	assert_eq!(all, vec![format!("INSTANCE_CHAT {MARK}“Plagued Lands” Cursed Hide 1/1")]);
	no_plain_brackets(&all);
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
w.progress(33, 1, 1); stub.advance(5)
w.progress(33, 2, 5); stub.advance(3)
emit(before); emit(told()); emit(#p.chat); emit(PolestarDB.partyChatTold == true)"#,
	);
	assert_eq!(out, vec![json!(0), json!(1), json!(2), json!(true)]);
}

// Each language's marker: frFR spaces its colon, ruRU names the star in Russian
// (Forever's ruRU GlobalStrings: RAID_TARGET_1 "Звезда" is one of the chat's star
// tags), every other one sends {rt1}; the filter recognises all of them.
#[test]
fn party_chat_the_marker_in_each_language() {
	let script = r#"
p.join("Ana")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 2, 5); stub.advance(5)
emit(chat())"#;
	for (locale, mark) in [
		("enUS", "{rt1} Polestar: "),
		("frFR", "{rt1} Polestar : "),
		("ruRU", "{звезда} Polestar: "),
		("deDE", "{rt1} Polestar: "),
		("esES", "{rt1} Polestar: "),
		("esMX", "{rt1} Polestar: "),
		("ptBR", "{rt1} Polestar: "),
		("koKR", "{rt1} Polestar: "),
		("zhCN", "{rt1} Polestar: "),
		("zhTW", "{rt1} Polestar: "),
	] {
		let out = in_locale(script, locale);
		let all = lines(&out[0]);
		assert_eq!(all.len(), 1, "{locale}: {all:?}");
		let prefix = format!("PARTY {mark}{}", link(33, "Plagued Lands"));
		assert!(all[0].starts_with(&prefix), "{locale}: {:?}", all[0]);
		assert!(all[0].contains("5/5"), "{locale}: {:?}", all[0]);
		no_plain_brackets(&all);
	}
	let shown = live(
		r#"
for _, m in ipairs({ "{rt1} Polestar: x", "{rt1} Polestar : x", "{звезда} Polestar: x" }) do
	emit(p.show("CHAT_MSG_PARTY", m, "Ana-TestRealm") or "dropped")
end"#,
	);
	assert_eq!(shown, vec![json!(format!("{ICON} Polestar: x")), json!(format!("{ICON} Polestar : x")), json!(format!("{ICON} Polestar: x"))]);
}

#[test]
fn party_chat_looting_an_item_that_starts_a_quest_says_the_item_and_the_quest() {
	let script = r#"
w.titles[77] = "The Dark Iron War"
w.titles[78] = "A Done Deal"
Polestar.QuestDB = { StartedBy = function(id)
	if id == 9001 then return { 77 } end
	if id == 9002 then return { 78 } end
end }
w.complete({ 78 })
p.join("Ana")
stub.advance(6)
p.loot(9001, "Mysterious Letter"); stub.advance(2)
p.loot(9001, "Mysterious Letter", 2); stub.advance(2)
p.loot(9002, "Old Letter"); stub.advance(2)
p.loot(1234, "Linen Cloth"); stub.advance(2)
emit(chat())"#;
	let out = live(script);
	let all = lines(&out[0]);
	assert_eq!(all, vec![format!("PARTY {MARK}looted {}, which starts “The Dark Iron War”", item_link(9001, "Mysterious Letter"))]);
	no_plain_brackets(&all);
	let off = with_settings(script, "chatLoot = false");
	assert_eq!(lines(&off[0]), NONE, "party.chatLoot off");
	let solo = live(&script.replace("p.join(\"Ana\")", ""));
	assert_eq!(lines(&solo[0]), NONE, "solo");
	let fr = in_locale(script, "frFR");
	assert_eq!(lines(&fr[0]), vec![format!("PARTY {{rt1}} Polestar : a ramassé {}, qui lance «\u{a0}The Dark Iron War\u{a0}»", item_link(9001, "Mysterious Letter"))]);
}

#[test]
fn party_chat_the_filter_hides_your_own_lines_unless_asked_and_others_on_request() {
	let script = r#"
local mine = "{rt1} Polestar: |cffffff00|Hquest:33:0|h[Plagued Lands]|h|r is ready to turn in"
emit(p.show("CHAT_MSG_PARTY", mine, "Testchar") or "dropped")
emit(p.show("CHAT_MSG_PARTY_LEADER", "{rt1} Polestar: x", "Ana-TestRealm") or "dropped")
emit(p.show("CHAT_MSG_INSTANCE_CHAT", "{звезда} Polestar: x", "Ana-TestRealm") or "dropped")
emit(p.show("CHAT_MSG_INSTANCE_CHAT_LEADER", "{rt1} Polestar: x", "Ana-TestRealm") or "dropped")
emit(p.show("CHAT_MSG_PARTY", "{rt1} pull now", "Ana-TestRealm") or "dropped")"#;
	let out = live(script);
	assert_eq!(
		out,
		vec![json!("dropped"), json!(format!("{ICON} Polestar: x")), json!(format!("{ICON} Polestar: x")), json!(format!("{ICON} Polestar: x")), json!("{rt1} pull now")],
		"own lines dropped by default; others' with Polestar's star; other lines untouched"
	);
	let echo = with_settings(script, "chatEcho = true");
	assert_eq!(echo[0], json!(format!("{ICON} Polestar: |cffffff00|Hquest:33:0|h[Plagued Lands]|h|r is ready to turn in")));
	let hide = with_settings(script, "chatHideOthers = true");
	assert_eq!(hide, vec![json!("dropped"), json!("dropped"), json!("dropped"), json!("dropped"), json!("{rt1} pull now")]);
}

#[test]
fn party_chat_only_when_someone_lacks_polestar_stays_quiet_while_everyone_runs_it() {
	let script = r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1Y|0.3.5")
stub.advance(6)
w.accept(33, plagued(), "Plagued Lands")
stub.advance(1)
w.progress(33, 2, 5); stub.advance(5)
local all = chat()
p.join("Ben")
stub.advance(6)
w.progress(33, 1, 1); stub.advance(3)
emit(all); emit(chat())"#;
	let on = with_settings(script, "chatOnlyNeeded = true");
	assert_eq!(lines(&on[0]), NONE, "everyone runs Polestar");
	assert_eq!(lines(&on[1]), vec![ready(33, "Plagued Lands")], "Ben does not");
	let off = live(script);
	assert_eq!(lines(&off[0]), vec![objectives("Plagued Hide 5/5", 33, "Plagued Lands")], "the option off");
}

#[test]
fn party_chat_a_line_stays_under_255_bytes_cutting_the_objective_list_never_the_link() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
local objs = {}
for i = 1, 9 do objs[i] = { text = ("Очень длинное имя цели номер %d: 0/1"):format(i), required = 1 } end
objs[10] = { text = "Unfinished: 0/1", required = 1 }
w.accept(60, objs, "A Quest With Very Many Objectives")
local one = { { text = ("Ж"):rep(150) .. ": 0/1", required = 1 }, { text = "Unfinished: 0/1", required = 1 } }
w.accept(61, one, "One Long Objective")
stub.advance(1)
for i = 1, 9 do w.progress(60, i, 1) end
w.progress(61, 1, 1)
stub.advance(7)
emit(chat())"#,
	);
	let all = lines(&out[0]);
	assert_eq!(all.len(), 2, "{all:?}");
	for l in &all {
		let sent = l.strip_prefix("PARTY ").unwrap();
		assert!(sent.len() <= 255, "{} bytes: {sent}", sent.len());
		assert!(!sent.contains('\u{FFFD}'), "cut inside a character: {sent}");
		assert!(sent.ends_with('…'), "{sent}");
	}
	assert!(all[0].starts_with(&format!("PARTY {MARK}{} Очень длинное имя цели номер 1 1/1, ", link(60, "A Quest With Very Many Objectives"))), "{}", all[0]);
	assert!(all[0].ends_with(", …"), "whole objectives, the rest an ellipsis: {}", all[0]);
	assert!(all[1].starts_with(&format!("PARTY {MARK}{} ЖЖЖ", link(61, "One Long Objective"))), "{}", all[1]);
}

// The frFR client's kill line, "Jeune loup : 10/10 |4personnage tué:personnages tués;" (no-break space before the
// colon): the chat line says the name and counts, never the raw "|4…;" escape (the client refuses a chat message
// with a bad escape code).
#[test]
fn party_chat_an_frfr_kill_objective_says_its_name_without_the_grammar_escape() {
	let out = live(
		r#"
p.join("Ana")
stub.advance(6)
w.accept(50, { { text = "Jeune loup\194\160: 0/10 |4personnage tué:personnages tués;", required = 10 }, { text = "Peau de sanglier : 0/6", required = 6 } }, "Loups")
stub.advance(1)
w.progress(50, 1, 10); stub.advance(5)
emit(chat())"#,
	);
	assert_eq!(lines(&out[0]), vec![objectives("Jeune loup 10/10", 50, "Loups")]);
}
