//! Quests/Party.lua: quest progress shared with the party through hidden addon messages, against the fake
//! client (tests/lua/stub_world.lua for the quest log, tests/lua/stub_party.lua for the group and the addon
//! channel). Quest IDs and counts only, so players on other guides or other languages agree.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Quests/Party.lua"];

// Both switches start off; most tests play a player who turned them on.
const ON: &str = "PolestarDB = { schema = 1, settings = { party = { share = true, show = true } } }";

fn run_with(script: &str, stubs: &[&'static str], files: &[&str], login: bool, saved: Option<&str>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: stubs.to_vec(),
		before: String::new(),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		addons: vec![Addon::files("Polestar", files)],
		login,
		script: format!("local P, w = Polestar.Party, stub.world\n{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, &["stub_world.lua"], FILES, false, Some(ON))
}

// Sending and receiving run with the party stub, logged in.
const LIVE_STUBS: &[&str] = &["stub_world.lua", "stub_party.lua"];

fn live(script: &str) -> Vec<Value> {
	run_with(script, LIVE_STUBS, FILES, true, Some(ON))
}

fn not_logged_in(script: &str) -> Vec<Value> {
	run_with(script, LIVE_STUBS, FILES, false, Some(ON))
}

const SENT: &str = r#"
local p = stub.party
local function texts()
	local out = {}
	for i, m in ipairs(p.sent) do out[i] = m.text end
	return out
end"#;

const MEMBERS: &str = r#"
local function members()
	local out = {}
	for _, m in ipairs(P.Members()) do
		local qs = {}
		for q, counts in pairs(m.quests) do
			local parts = {}
			for i, c in ipairs(counts) do parts[i] = c[1] .. "/" .. c[2] end
			qs[#qs + 1] = q .. ":" .. table.concat(parts, ",")
		end
		table.sort(qs)
		out[#out + 1] = m.name .. " " .. table.concat(qs, ";")
	end
	return out
end"#;

fn sent(rest: &str) -> String {
	format!("{SENT}{rest}")
}

fn sent_members(rest: &str) -> String {
	format!("{SENT}{MEMBERS}{rest}")
}

// What the guide shows, with the guide window's own files loaded.
const SHOWN_FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Quests/Party.lua"];
const DOT: &str = "  \u{b7}  ";

fn shown(script: &str) -> Vec<Value> {
	run_with(script, LIVE_STUBS, SHOWN_FILES, true, Some(ON))
}

#[test]
fn party_a_message_round_trips_quests_counts_a_dropped_quest_and_the_snapshot_mark() {
	let out = run(r#"
local msgs = P.Encode({ { q = 33, counts = { { 5, 8 }, { 0, 1 } } }, { q = 60, counts = false } }, true)
local snap, entries = P.Decode(msgs[1])
emit(msgs); emit(snap); emit(entries)"#);
	assert_eq!(out[0], json!(["1S|33:5/8,0/1;60:-"]));
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!([{ "q": 33, "counts": [[5, 8], [0, 1]] }, { "q": 60, "counts": false }]));
}

#[test]
fn party_a_full_log_splits_into_messages_under_255_bytes_each_one_parsing_alone() {
	let out = run(r#"
local entries = {}
for q = 1001, 1025 do
	local counts = {}
	for i = 1, 10 do counts[i] = { 999, 999 } end
	entries[#entries + 1] = { q = q, counts = counts }
end
local msgs = P.Encode(entries, true)
local res = { lengths = {}, snaps = {}, quests = {} }
for i, m in ipairs(msgs) do
	res.lengths[i] = #m
	local snap, got = P.Decode(m)
	res.snaps[i] = snap
	for _, e in ipairs(got) do res.quests[#res.quests + 1] = e.q end
end
emit(res)"#);
	let out = &out[0];
	let lengths = out["lengths"].as_array().unwrap();
	assert!(lengths.len() > 1);
	for n in lengths {
		assert!(n.as_f64().unwrap() <= 255.0, "message of {n} bytes");
	}
	let snaps: Vec<Value> = lengths.iter().enumerate().map(|(i, _)| json!(i == 0)).collect();
	assert_eq!(out["snaps"], json!(snaps));
	let quests: Vec<i32> = (1001..1026).collect();
	assert_eq!(out["quests"], json!(quests));
}

#[test]
fn party_malformed_text_another_version_and_out_of_range_counts_are_refused() {
	let eleven = ["1/2"; 11].join(",");
	let many = (1..=41).map(|i| format!("{i}:1/2")).collect::<Vec<_>>().join(";");
	let bad = [
		"x".to_string(),
		String::new(),
		"2|33:1/2".to_string(),
		"1|33:1000/2".to_string(),
		"1|abc:1/2".to_string(),
		"1|33:1/".to_string(),
		"1|33".to_string(),
		format!("1|33:{eleven}"),
		format!("1|{many}"),
	];
	let script = bad.iter().map(|t| format!("emit(P.Decode({}) == nil)", serde_json::to_string(t).unwrap())).collect::<Vec<_>>().join("\n");
	let out = run(&script);
	assert_eq!(json!(out), json!(vec![true; bad.len()]));
}

#[test]
fn party_a_quest_with_no_objectives_is_sent_and_read_as_an_empty_list() {
	let out = run(r#"
local msgs = P.Encode({ { q = 33, counts = {} } })
local _, entries = P.Decode(msgs[1])
emit(msgs); emit(#entries[1].counts); emit(entries[1].q)"#);
	assert_eq!(out[0], json!(["1|33:"]));
	assert_eq!(out[1], 0);
	assert_eq!(out[2], 33);
}

#[test]
fn party_the_log_is_read_as_quest_id_to_counts() {
	let out = run(r#"
w.onQuest(33, { 8, 1 })
w.onQuest(60, {})
w.progress(33, 1, 5)
local out = {}
for q, s in pairs(P.ReadLog()) do out[tostring(q)] = s end
emit(out)"#);
	assert_eq!(out[0], json!({ "33": "5/8,0/1", "60": "" }));
}

#[test]
fn party_progress_goes_to_the_party_2_seconds_after_the_log_changes_once_per_burst() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
emit(texts())
w.progress(33, 1, 1); stub.advance(0.3)
w.progress(33, 1, 2); stub.advance(0.3)
w.progress(33, 1, 3)
stub.advance(2)
emit(texts())
emit(p.sent[#p.sent].chatType .. " " .. p.sent[#p.sent].prefix)"#,
	));
	// Solo before, so we knew nobody's progress: the snapshot asks for theirs.
	assert_eq!(out[0], json!(["1R|33:0/8"]));
	assert_eq!(out[1], json!(["1R|33:0/8", "1|33:3/8"]));
	assert_eq!(out[2], "PARTY Polestar");
}

#[test]
fn party_unchanged_quests_are_not_sent_again() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
stub.fire("QUEST_LOG_UPDATE")
stub.advance(3)
emit(#p.sent)"#,
	));
	assert_eq!(out[0], 1);
}

#[test]
fn party_a_quest_that_leaves_the_log_is_sent_as_dropped() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.onQuest(60, { 2 })
p.join("Ana")
stub.advance(6)
w.abandon(33)
stub.advance(2)
emit(p.sent[#p.sent].text)"#,
	));
	assert_eq!(out[0], "1|33:-");
}

#[test]
fn party_a_member_joining_gets_a_snapshot_within_6_seconds() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.onQuest(60, {})
p.join("Ana")
stub.advance(2.9)
emit(#p.sent)
stub.advance(3.2)
emit(texts())"#,
	));
	assert_eq!(out[0], 0);
	assert_eq!(out[1], json!(["1R|33:0/8;60:"]));
}

#[test]
fn party_a_change_while_a_snapshot_is_on_its_way_goes_out_in_the_snapshot_not_before_it() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.onQuest(60, { 2 })
p.join("Ana")
stub.advance(0.5)
w.progress(33, 1, 1)
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1R|33:1/8;60:0/2"]));
}

#[test]
fn party_solo_in_a_raid_or_with_sharing_off_none_of_your_progress_is_sent() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.progress(33, 1, 2)
stub.advance(10)
emit(#p.sent)
p.join("Ana"); p.raid(true)
w.progress(33, 1, 3)
stub.advance(10)
emit(#p.sent)
p.disband()
Polestar.Set("party.share", false)
p.join("Ben")
w.progress(33, 1, 4)
stub.advance(10)
emit(texts())"#,
	));
	assert_eq!(json!([out[0], out[1]]), json!([0, 0]));
	assert_eq!(out[2], json!(["1Q|"]), "with showing on, only the request for theirs");
}

#[test]
fn party_a_refused_send_keeps_the_change_for_the_next_one_without_retrying_on_its_own() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.onQuest(60, { 4 })
p.join("Ana")
stub.advance(6)
p.result = Enum.SendAddonMessageResult.AddonMessageThrottle
w.progress(33, 1, 5)
stub.advance(10)
emit(#p.sent)
p.result = 0
w.progress(60, 1, 1)
stub.advance(2)
emit(p.sent[#p.sent].text)"#,
	));
	assert_eq!(out[0], 2);
	assert_eq!(out[1], "1|33:5/8;60:1/4");
}

#[test]
fn party_both_settings_off_registers_no_events() {
	let out = live(&sent(
		r#"
local EVENTS = { "GROUP_ROSTER_UPDATE", "GROUP_LEFT", "QUEST_LOG_UPDATE", "CHAT_MSG_ADDON" }
local function registered()
	local out = {}
	for _, ev in ipairs(EVENTS) do
		for _, f in ipairs(stub.frames) do
			if f.events and f.events[ev] then out[#out + 1] = ev break end
		end
	end
	return out
end
emit(registered())
Polestar.Set("party.share", false)
Polestar.Set("party.show", false)
emit(registered())"#,
	));
	let on = out[0].as_array().unwrap();
	assert!(on.contains(&json!("CHAT_MSG_ADDON")) && on.contains(&json!("GROUP_ROSTER_UPDATE")));
	let off: Vec<&Value> = out[1].as_array().unwrap().iter().filter(|e| e.as_str() != Some("QUEST_LOG_UPDATE")).collect();
	assert_eq!(off, Vec::<&Value>::new());
}

#[test]
fn party_progress_from_a_party_member_is_kept_by_quest() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8,0/1")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ana 33:5/8,0/1"]));
}

#[test]
fn party_a_member_on_another_realm_is_matched_by_name_and_realm() {
	let out = live(&sent_members(
		r#"
p.join("Ben", "Other")
p.receive("Ben-Other", "1|60:2/4")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ben 60:2/4"]));
}

#[test]
fn party_messages_from_outside_the_party_from_yourself_on_another_channel_or_prefix_are_ignored() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.receive("Zed-TestRealm", "1|33:5/8")
p.receive("Testchar-TestRealm", "1|33:5/8")
p.receive("Ana-TestRealm", "1|33:5/8", "GUILD")
p.receive("Ana-TestRealm", "1|33:5/8", "PARTY", "Other")
p.receive("Ana-TestRealm", "garbage")
emit(#P.Members())"#,
	));
	assert_eq!(out[0], 0);
}

#[test]
fn party_a_snapshot_replaces_what_was_known_a_plain_message_merges() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1S|33:1/8")
p.receive("Ana-TestRealm", "1|60:2/4")
emit(members())
p.receive("Ana-TestRealm", "1S|60:3/4")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ana 33:1/8;60:2/4"]));
	assert_eq!(out[1], json!(["Ana 60:3/4"]));
}

#[test]
fn party_a_dropped_quest_disappears() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:1/8;60:2/4")
p.receive("Ana-TestRealm", "1|33:-")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ana 60:2/4"]));
}

#[test]
fn party_a_member_who_leaves_is_forgotten_and_everyone_when_the_group_ends() {
	let out = live(&sent_members(
		r#"
p.join("Ana"); p.join("Ben")
p.receive("Ana-TestRealm", "1|33:1/8")
p.receive("Ben-TestRealm", "1|33:2/8")
p.leave("Ana")
emit(members())
p.disband()
emit(#P.Members())
p.join("Ana")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ben 33:2/8"]));
	assert_eq!(out[1], 0);
	assert_eq!(out[2], json!(["Ana 60:1/4"]));
}

#[test]
fn party_with_showing_off_incoming_progress_is_ignored() {
	let out = live(&sent(
		r#"
Polestar.Set("party.show", false)
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:1/8")
emit(#P.Members())"#,
	));
	assert_eq!(out[0], 0);
}

#[test]
fn party_a_burst_of_messages_refreshes_the_guide_once() {
	let out = live(&sent(
		r#"
local fires = 0
Polestar.On("PARTY_PROGRESS", function() fires = fires + 1 end)
p.join("Ana")
for i = 1, 5 do p.receive("Ana-TestRealm", "1|33:" .. i .. "/8"); stub.advance(0.02) end
stub.advance(1)
emit(fires)"#,
	));
	assert_eq!(out[0], 1);
}

#[test]
fn party_after_a_reload_in_a_party_the_others_are_asked_for_their_progress_once() {
	let out = not_logged_in(&sent(
		r#"
p.members = { { name = "Ana", online = true } }
w.onQuest(33, { 8 })
stub.login()
stub.advance(6)
emit(texts())
p.sent = {}
stub.advance(10)
p.receive("Ana-TestRealm", "1R|60:1/4")
p.receive("Ana-TestRealm", "1R|60:1/4")
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1R|33:0/8"]));
	assert_eq!(out[1], json!(["1S|33:0/8"]));
}

#[test]
fn party_an_objective_goal_lists_party_members_counts() {
	let out = shown(&sent(
		r#"
p.join("Ben"); p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8")
p.receive("Ben-TestRealm", "1|33:8/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))"#,
	));
	assert_eq!(out[0], format!("Ana 5/8{DOT}Ben done").as_str());
}

#[test]
fn party_a_member_s_count_is_read_from_the_quest_log_line_the_goal_reads_not_its_compiled_position_335() {
	// Slimy Menace in the game's order, Murloc first; the guide compiled Murloc as objective 2.
	let out = shown(&sent(
		r#"
w.onQuest(99128, { { text = "Murloc slain: 0/7", required = 7, type = "monster" }, { text = "Murloc Streamrunner slain: 0/4", required = 4, type = "monster" } })
p.join("Ana")
p.receive("Ana-TestRealm", "1|99128:3/7,1/4")
emit(P.Line({ t = "kill", quest = 99128, target = "Murloc", npc = 285, oi = 2, status = "active" }))
emit(P.Line({ t = "kill", quest = 99128, target = "Murloc Streamrunner", npc = 735, oi = 1, status = "active" }))"#,
	));
	assert_eq!(out[0], "Ana 3/7");
	assert_eq!(out[1], "Ana 1/4");
}

#[test]
fn party_members_without_the_quest_or_showing_off_add_nothing() {
	let out = shown(&sent(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)
p.receive("Ana-TestRealm", "1|33:1/8")
Polestar.Set("party.show", false)
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)"#,
	));
	assert_eq!(json!([out[0], out[1]]), json!([true, true]));
}

#[test]
fn party_on_a_quest_you_have_its_objective_names_party_members_who_lack_it_after_their_counts() {
	let out = shown(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana"); p.join("Ben")
p.onQuest.Ana = { [33] = true }
p.onQuest.Ben = { [33] = false }
p.receive("Ana-TestRealm", "1|33:5/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))
emit(P.Line({ t = "kill", quest = 33, oi = 2, status = "active" }, true))
emit(P.Line({ t = "accept", quest = 33, status = "done" }) == nil)"#,
	));
	assert_eq!(out[0], format!("Ana 5/8{DOT}Not on this quest: Ben").as_str());
	assert!(out[1].is_null(), "a row above already names them");
	// Taking the quest moves the window past its accept.
	assert_eq!(out[2], true, "not on the accept");
}

#[test]
fn party_without_the_client_s_party_check_synced_members_still_count_unknown_ones_are_not_guessed() {
	let out = shown(&sent(
		r#"
p.noUnitQuestAPI()
w.onQuest(33, { 8 })
p.join("Ana"); p.join("Ben")
p.receive("Ana-TestRealm", "1|60:1/4")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))"#,
	));
	assert_eq!(out[0], "Not on this quest: Ana");
}

#[test]
fn party_before_you_have_the_quest_no_nudge() {
	let out = shown(&sent(
		r#"
p.join("Ben")
p.onQuest.Ben = { [33] = false }
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }) == nil)"#,
	));
	assert_eq!(out[0], true);
}

#[test]
fn party_the_goal_s_grey_line_carries_the_party_part() {
	let out = shown(&sent(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8")
emit(Polestar.UI.GoalSubline({ t = "kill", quest = 33, oi = 1, status = "active" }))"#,
	));
	assert_eq!(out[0], "Ana 5/8");
}

#[test]
fn party_the_questing_page_has_the_two_party_switches_both_off_until_turned_on() {
	let out = run_with(
		r#"
local keys = {}
Polestar.Widgets.OnOptionsRegistered(function(spec)
	for _, c in ipairs(spec.controls) do
		if c.key and c.key:sub(1, 6) == "party." then keys[#keys + 1] = spec.page .. "/" .. c.key end
	end
end)
emit(keys); emit(Polestar.Get("party.share")); emit(Polestar.Get("party.show"))"#,
		LIVE_STUBS,
		SHOWN_FILES,
		true,
		None,
	);
	assert_eq!(out[0], json!(["Questing/party.share", "Questing/party.show"]));
	assert_eq!(json!([out[1], out[2]]), json!([false, false]));
}

// Found by the final review (Codex and a fresh reviewer).

#[test]
fn party_a_40_quest_log_reaches_the_party_whole_at_most_40_quests_a_message() {
	let out = run(r#"
local function entries(n)
	local out = {}
	for q = 1, n do out[q] = { q = q, counts = { { 1, 2 } } } end
	return out
end
local function decoded(msgs)
	local total, ok = 0, true
	for _, m in ipairs(msgs) do
		local snap, got = P.Decode(m)
		if snap == nil then ok = false else total = total + #got end
	end
	return { n = #msgs, total = total, ok = ok }
end
emit(decoded(P.Encode(entries(30), true)))
emit(decoded(P.Encode(entries(45), true)))"#);
	assert_eq!(out[0], json!({ "n": 1, "total": 30, "ok": true }));
	assert_eq!(out[1], json!({ "n": 2, "total": 45, "ok": true }));
}

#[test]
fn party_a_refused_snapshot_is_owed_and_the_next_send_is_a_full_one() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
w.onQuest(60, { 4 })
p.result = Enum.SendAddonMessageResult.AddOnMessageLockdown
p.join("Ana")
stub.advance(6)
p.result = 0
w.progress(60, 1, 1)
stub.advance(2)
emit(p.sent[#p.sent].text)"#,
	));
	assert_eq!(out[0], "1R|33:0/8;60:1/4");
}

#[test]
fn party_a_member_who_goes_offline_leaves_the_line_and_gets_a_snapshot_when_back() {
	let out = live(&sent_members(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.receive("Ana-TestRealm", "1|33:3/8")
p.connect("Ana", false)
emit(#P.Members())
p.sent = {}
p.connect("Ana", true)
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], 0);
	// Back online with nobody else known: the snapshot asks for hers too.
	assert_eq!(out[1], json!(["1R|33:0/8"]));
}

#[test]
fn party_a_member_whose_name_is_not_known_yet_is_not_on_the_roster() {
	let out = live(&sent(
		r#"
p.join("Unknown")
p.receive("Unknown-TestRealm", "1|33:3/8")
emit(#P.Members())"#,
	));
	assert_eq!(out[0], 0);
}

#[test]
fn party_while_the_client_keeps_party_names_secret_the_roster_and_what_members_sent_stay_as_they_were() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.join("Ben")
p.receive("Ana-TestRealm", "1|33:5/8")
p.secretNames = true
stub.fire("GROUP_ROSTER_UPDATE")
p.receive("Ana-TestRealm", "1|33:6/8")
emit(members())
emit(#P.Missing(33))
p.secretNames = false
p.leave("Ben")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ana 33:6/8"]));
	assert_eq!(out[1], 0, "a member whose name is secret is not named");
	assert_eq!(out[2], json!(["Ana 33:6/8"]));
}

#[test]
fn party_turning_sharing_off_tells_the_party_to_forget_your_counts_on_again_it_resyncs() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
Polestar.Set("party.share", false)
w.progress(33, 1, 2)
stub.advance(10)
emit(texts())
p.sent = {}
Polestar.Set("party.share", true)
stub.advance(6)
emit(texts())
p.sent = {}
Polestar.Set("party.show", false)
Polestar.Set("party.show", true)
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1S|"]));
	assert_eq!(out[1], json!(["1R|33:2/8"]));
	assert_eq!(out[2], json!(["1R|33:2/8"]));
}

#[test]
fn party_turning_sharing_off_before_anything_went_out_sends_nothing() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())"#,
	));
	// No empty snapshot: the party has nothing of ours to forget.
	assert_eq!(out[0], json!(["1Q|"]));
}

#[test]
fn party_sharing_turned_off_while_a_resync_is_on_its_way_still_clears_what_the_party_has() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
Polestar.Set("party.show", false)
Polestar.Set("party.show", true)
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1S|", "1Q|"]));
}

#[test]
fn party_sharing_turned_off_right_after_a_reload_in_a_party_clears_what_the_party_had_from_before_it() {
	let out = not_logged_in(&sent(
		r#"
p.members = { { name = "Ana", online = true } }
w.onQuest(33, { 8 })
stub.login()
Polestar.Set("party.share", false)
stub.advance(10)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1S|", "1Q|"]));
}

#[test]
fn party_showing_without_sharing_asks_for_the_party_s_progress_and_sends_none_of_yours() {
	let out = live(&sent_members(
		r#"
Polestar.Set("party.share", false)
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
emit(texts())
p.receive("Ana-TestRealm", "1R|33:4/8")
w.progress(33, 1, 1)
stub.advance(3)
emit({ texts(), members() })
p.sent = {}
Polestar.Set("party.share", true)
stub.advance(6)
p.sent = {}
stub.advance(5)
p.receive("Ana-TestRealm", "1Q|")
stub.advance(6)
emit({ texts(), members() })"#,
	));
	// After a reload or a join from solo: a bare request, nothing of ours.
	assert_eq!(out[0], json!(["1Q|"]));
	assert_eq!(out[1], json!([["1Q|"], ["Ana 33:4/8"]]));
	// A sharer answers a bare request; it changes nothing of the asker's counts.
	assert_eq!(out[2], json!([["1S|33:1/8"], ["Ana 33:4/8"]]));
}

#[test]
fn party_a_refused_bare_request_is_asked_again_when_a_member_s_quest_log_changes() {
	let out = live(&sent(
		r#"
Polestar.Set("party.share", false)
p.result = Enum.SendAddonMessageResult.AddonMessageThrottle
p.join("Ana")
stub.advance(6)
emit(texts())
p.result = 0
p.sent = {}
p.questLogChanged("Ana")
stub.advance(6)
emit(texts())
p.sent = {}
p.questLogChanged("Ana")
stub.advance(6)
emit(#p.sent)"#,
	));
	assert_eq!(out[0], json!(["1Q|"]));
	assert_eq!(out[1], json!(["1Q|"]));
	assert_eq!(out[2], 0, "once it went out, a log change asks nothing");
}

#[test]
fn party_a_bare_request_carries_nothing() {
	let out = run(r#"
local snap, entries, asks = P.Decode("1Q|")
emit({ snap, #entries, asks })
emit(P.Decode("1Q|33:1/2") == nil)"#);
	assert_eq!(out[0], json!([false, 0, true]));
	assert_eq!(out[1], true);
}

#[test]
fn party_a_request_soon_after_a_snapshot_the_requester_may_have_missed_is_answered() {
	let out = live(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
p.sent = {}
stub.advance(5)
p.receive("Ana-TestRealm", "1R|")
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], json!(["1S|33:0/8"]));
}

#[test]
fn party_a_member_on_a_realm_whose_name_has_a_space_is_matched() {
	let out = live(&sent_members(
		r#"
p.join("Ben", "Other Realm")
p.receive("Ben-OtherRealm", "1|60:2/4")
emit(members())"#,
	));
	assert_eq!(out[0], json!(["Ben 60:2/4"]));
}

#[test]
fn party_a_member_who_sent_the_quest_is_never_listed_as_lacking_it() {
	let out = shown(&sent(
		r#"
w.onQuest(33, { 8 })
p.join("Ben")
p.onQuest.Ben = { [33] = false }
p.receive("Ben-TestRealm", "1|33:0/8")
emit(P.Line({ t = "kill", quest = 33, oi = 1, status = "active" }))"#,
	));
	assert_eq!(out[0], "Ben 0/8");
}

#[test]
fn party_a_member_s_quest_log_changing_or_someone_joining_refreshes_the_guide() {
	let out = live(&sent(
		r#"
local fires = 0
Polestar.On("PARTY_PROGRESS", function() fires = fires + 1 end)
p.join("Ben")
stub.advance(1)
p.questLogChanged("Ben")
stub.advance(1)
emit(fires)"#,
	));
	assert_eq!(out[0], 2);
}
