//! Quests/Party.lua: quest progress shared with the party through hidden addon messages, against the fake
//! client (tests/lua/stub_world.lua for the quest log, tests/lua/stub_party.lua for the group and the addon
//! channel). Quest IDs and counts only, so players on other guides or other languages agree.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
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
-- The "2U|" unit messages and our own "1H|" hello have tests of their own
-- (p.units = true, p.hellos = true keep them); the others read what they
-- read before them.
local rawSend = C_ChatInfo.SendAddonMessage
function C_ChatInfo.SendAddonMessage(prefix, text, ...)
	if (text:sub(1, 3) == "2U|" and not p.units) or (text:sub(1, 3) == "1H|" and not p.hellos) then return p.result end
	return rawSend(prefix, text, ...)
end
-- A member who joins runs Polestar and says hello, unless p.quiet[name]. With
-- a surname (Forever) the sender reads "Ana Smith-TestRealm".
p.quiet = {}
local rawJoin = p.join
function p.join(name, realm, surname)
	rawJoin(name, realm, surname)
	local full = surname and (name .. " " .. surname) or name
	if not p.quiet[name] then p.receive(full .. "-" .. (realm and realm:gsub("[%s%-]", "") or "TestRealm"), "1H|0.0.1") end
end
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
const SHOWN_FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "UI/UI.xml", "Quests/Party.lua"];
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
	assert_eq!(out[2], json!(["1Y|0.1.0-test"]), "with showing on, only the answer to Ben's hello");
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
fn party_solo_only_the_roster_events_listen_for_the_party_in_a_party_the_rest_and_with_both_off_nothing() {
	let out = live(&sent(
		r#"
local EVENTS = { "GROUP_ROSTER_UPDATE", "GROUP_LEFT", "QUEST_LOG_UPDATE", "CHAT_MSG_ADDON", "PLAYER_XP_UPDATE", "CHAT_MSG_SYSTEM" }
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
p.join("Ana")
emit(registered())
Polestar.Set("party.share", false)
Polestar.Set("party.show", false)
emit(registered())"#,
	));
	let others = |v: &Value| -> Vec<Value> { v.as_array().unwrap().iter().filter(|e| e.as_str() != Some("QUEST_LOG_UPDATE") && e.as_str() != Some("PLAYER_XP_UPDATE")).cloned().collect() };
	// Solo with sharing on, Core/Update.lua listens for addon messages too (a stranger's version probe and its
	// answer); with sharing off, outside a guild, nothing listens.
	assert_eq!(others(&out[0]), vec![json!("GROUP_ROSTER_UPDATE"), json!("GROUP_LEFT"), json!("CHAT_MSG_ADDON")], "solo: the roster, and Update's probes");
	let grouped = out[1].as_array().unwrap();
	assert!(grouped.contains(&json!("CHAT_MSG_ADDON")) && grouped.contains(&json!("PLAYER_XP_UPDATE")), "{grouped:?}");
	assert!(!grouped.contains(&json!("CHAT_MSG_SYSTEM")), "the share answers only after a share");
	assert_eq!(others(&out[2]), Vec::<Value>::new());
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
fn party_after_a_reload_in_a_party_it_says_hello_and_answers_the_member_who_answers_once() {
	let out = not_logged_in(&sent(
		r#"
p.hellos = true
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
	assert_eq!(out[0], json!(["1H|0.1.0-test"]), "only the hello until someone answers");
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
fn party_the_group_section_has_its_switches_all_on_by_default_the_panel_too_1018() {
	let out = run_with(
		r#"
local keys = {}
Polestar.Widgets.OnOptionsRegistered(function(spec)
	for _, c in ipairs(spec.controls) do
		if c.key and c.key:sub(1, 6) == "party." then keys[#keys + 1] = spec.page .. "/" .. spec.section .. "/" .. c.key end
	end
end)
emit(keys)
emit({ Polestar.Get("party.share"), Polestar.Get("party.show"), Polestar.Get("party.waitForGroup"), Polestar.Get("party.lootNeeds"), Polestar.Get("party.panel"), Polestar.Get("party.chat"), Polestar.Get("party.chatLoot") })
emit({ Polestar.Get("party.chatEcho"), Polestar.Get("party.chatHideOthers"), Polestar.Get("party.chatOnlyNeeded") })"#,
		LIVE_STUBS,
		SHOWN_FILES,
		true,
		None,
	);
	assert_eq!(
		out[0],
		json!([
			"Questing/Group/party.share",
			"Questing/Group/party.show",
			"Questing/Group/party.waitForGroup",
			"Questing/Group/party.lootNeeds",
			"Questing/Group/party.panel",
			"Questing/Group/party.chat",
			"Questing/Group/party.chatLoot",
			"Questing/Group/party.chatEcho",
			"Questing/Group/party.chatHideOthers",
			"Questing/Group/party.chatOnlyNeeded"
		])
	);
	assert_eq!(out[1], json!([true, true, true, true, true, true, true]), "the panel opens by itself once a member is heard (#1018)");
	assert_eq!(out[2], json!([false, false, false]), "own lines, hiding others' and the Polestar-only quiet start off");
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
fn party_a_member_who_goes_offline_leaves_the_line_and_is_answered_when_back() {
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
p.receive("Ana-TestRealm", "1H|0.0.1")
stub.advance(6)
emit(texts())"#,
	));
	assert_eq!(out[0], 0);
	// Back online, her client says hello: our snapshot asks for hers too.
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
	assert_eq!(out[0], json!(["1S|"]), "the party had counts of ours from before the reload; nothing else until someone answers");
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
	// A hello from a member while showing without sharing: a bare answer, nothing of ours.
	assert_eq!(out[0], json!(["1Y|0.1.0-test"]));
	assert_eq!(out[1], json!([["1Y|0.1.0-test"], ["Ana 33:4/8"]]));
	// A sharer answers a bare request; it changes nothing of the asker's counts.
	assert_eq!(out[2], json!([["1S|33:1/8"], ["Ana 33:4/8"]]));
}

#[test]
fn party_a_refused_hello_is_said_again_when_a_member_s_quest_log_changes() {
	let out = live(&sent(
		r#"
p.hellos = true
p.quiet.Ana = true
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
	assert_eq!(out[0], json!(["1H|0.1.0-test"]));
	assert_eq!(out[1], json!(["1H|0.1.0-test"]));
	assert_eq!(out[2], 0, "once it went out, a log change says nothing");
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

// A guide on step 5 of pack "test" version 3, for the position line.
const ON_GUIDE: &str = r#"
local E = Polestar.Engine
E.GetGuide = function() return { id = "test/g", pack = "test" } end
E.GetLiveStep = function() return 5 end
Polestar.Guides.Pack = function(id) if id == "test" then return { id = "test", title = "Test", version = "3" } end end
local goals = {}
E.GetStepView = function(i) if i == 5 then return { goals = goals } end end
"#;

#[test]
fn party_where_you_are_round_trips_and_versions_compare_as_dotted_numbers() {
	let out = run(r#"
local text = P.EncodePos({ step = 12, addon = "0.3.1", pack = "polestar", packVersion = "7", guide = "forever/elwynn|1" })
emit(text); emit(P.DecodePos(text)); emit(P.Decode(text) == nil)
emit({ P.Newer("0.3.10", "0.3.9"), P.Newer("0.3.9", "0.3.10"), P.Newer("1.0", "1.0.0"), P.Newer("0.4", "dev") })"#);
	assert_eq!(out[0], "1P|12|0.3.1|polestar|7|forever/elwynn|1");
	assert_eq!(out[1], json!({ "step": 12, "addon": "0.3.1", "pack": "polestar", "packVersion": "7", "guide": "forever/elwynn|1" }));
	assert_eq!(out[2], true, "older clients drop it as malformed");
	assert_eq!(out[3], json!([true, false, false, false]));
}

#[test]
fn party_your_place_goes_out_with_the_snapshot_and_again_only_when_the_live_step_moves() {
	let out = live(&sent(&format!(
		"{ON_GUIDE}{}",
		r#"
local step = 5
E.GetLiveStep = function() return step end
p.join("Ana")
stub.advance(6.5)
local first = texts()
p.sent = {}
Polestar.Fire("STEP_UPDATED", 5); stub.advance(2.5)
local same = #p.sent
step = 6; Polestar.Fire("STEP_CHANGED", 6); stub.advance(2.5)
emit({ first = first, same = same, moved = texts() })"#
	)));
	let first = out[0]["first"].as_array().unwrap();
	assert!(first.len() == 2 && is_match(first[1].as_str().unwrap(), r"^1P\|5\|[^|]*\|test\|3\|test/g$"), "{first:?}");
	assert_eq!(out[0]["same"], 0);
	assert!(is_match(out[0]["moved"][0].as_str().unwrap(), r"^1P\|6\|"));
}

#[test]
fn party_the_step_line_says_who_is_ahead_behind_or_on_another_guide_and_who_the_group_waits_on() {
	let out = shown(&sent(&format!(
		"{ON_GUIDE}{}",
		r#"
w.onQuest(33, { 8 })
p.join("Ana"); p.join("Ben"); p.join("Cy"); p.join("Dee")
p.onQuest.Ana = { [33] = true }; p.onQuest.Cy = { [33] = true }
p.receive("Ana-TestRealm", "1P|8|0.0.1|test|3|test/g")
p.receive("Ben-TestRealm", "1P|4|0.0.1|test|3|test/g")
p.receive("Cy-TestRealm", "1P|9|0.0.1|test|2|test/g")
p.receive("Dee-TestRealm", "1P|2|0.0.1|test|3|test/other")
emit({ P.StepLine() })
goals[1] = { t = "kill", quest = 33, oi = 1, status = "done" }
p.receive("Ana-TestRealm", "1|33:5/8")
emit({ P.StepLine() })
Polestar.Set("party.waitForGroup", false)
emit({ P.StepLine() })"#
	)));
	let places = format!("Ana: 3 steps ahead{DOT}Ben: 1 step behind{DOT}Dee: other guide");
	assert_eq!(out[0], json!([places, false]), "Cy's pack version differs: no line for her");
	assert_eq!(out[1], json!([format!("{places}{DOT}Waiting on Ana"), true]));
	assert_eq!(out[2], json!([format!("{places}{DOT}Still at it: Ana"), false]), "the wait off: a hint, never a hold");
}

#[test]
fn party_a_member_on_another_polestar_version_is_said_once_a_session_and_a_newer_guide_pack_once() {
	let out = live(&sent(&format!(
		"{ON_GUIDE}{}",
		r#"
p.quiet.Ana, p.quiet.Ben, p.quiet.Cy, p.quiet.Dee = true, true, true, true
stub.messages = {}
Polestar.version = "0.3.7"
p.join("Ana"); p.join("Ben"); p.join("Cy"); p.join("Dee")
-- Ana: an older Polestar, from her hello, then the same again by "1P|" and "2U|".
p.receive("Ana-TestRealm", "1H|0.3.6")
p.receive("Ana-TestRealm", "1P|8|0.3.6|test|3|test/g")
p.receive("Ana-TestRealm", "2U|12|5|1|1")
-- Ben: a newer one, by "2U|" alone (he has no guide open), and a newer guide pack.
p.receive("Ben-TestRealm", "2U|12|5|1|1|999.0")
p.receive("Ben-TestRealm", "1P|9|999.0|test|4|test/g")
-- Cy: the same version; Dee: a dev build.
p.receive("Cy-TestRealm", "1Y|0.3.7")
p.receive("Dee-TestRealm", "1Y|0.3.8-preview.1a2b3c")
emit(stub.messages)
stub.messages = {}
-- Ana reloads: her hello again, same version: nothing.
p.receive("Ana-TestRealm", "1H|0.3.6")
emit(#stub.messages)"#
	)));
	let said: Vec<&str> = out[0].as_array().unwrap().iter().filter_map(|m| m.as_str()).map(|m| m.trim_start_matches("|cff4fd1c5Polestar|r: ")).filter(|m| !m.contains("Party sync is on")).collect();
	assert_eq!(
		said,
		vec!["Ana is on Polestar 0.3.6: your guides can differ.", "Ben is on Polestar 999.0: your guides can differ. A newer version is out.", "Ben has a newer Test guide pack (4; yours is 3).",],
		"once per member and version; nothing for the same version or a dev build"
	);
	assert_eq!(out[1], 0);
}

#[test]
fn party_with_showing_off_no_version_note() {
	let out = run_with(
		&sent(
			r#"
stub.messages = {}
Polestar.version = "0.3.7"
p.join("Ana")
p.receive("Ana-TestRealm", "1H|0.3.6")
emit(#stub.messages)"#,
		),
		LIVE_STUBS,
		FILES,
		true,
		Some("PolestarDB = { schema = 1, settings = { party = { share = true, show = false } } }"),
	);
	assert_eq!(out[0], 0);
}

// A member's release version tells the update notices (Core/Update.lua), from their hello or their "1P|"; once
// the update card has shown for that version (PolestarDB.update.shown), the chat line says nothing more.
#[test]
fn party_a_members_newer_release_tells_the_update_notices_and_the_chat_line_is_left_out_once_the_card_said_it() {
	let script = sent(&format!(
		"{ON_GUIDE}{}",
		r#"
stub.messages = {}
Polestar.version = "0.3.6"
p.quiet.Ben = true
p.join("Ben")
p.receive("Ben-TestRealm", "1Y|0.3.7")
local fromHello = PolestarDB.update and PolestarDB.update.peer or false
p.join("Ana")
p.receive("Ana-TestRealm", "1P|8|0.3.8|test|3|test/g")
local n = 0
for _, m in ipairs(stub.messages) do if m:find("A newer version is out", 1, true) then n = n + 1 end end
emit({ hello = fromHello, peer = PolestarDB.update.peer, lines = n })"#
	));
	let out = run_with(&script, LIVE_STUBS, FILES, true, Some(ON));
	assert_eq!(out[0], json!({ "hello": "0.3.7", "peer": "0.3.8", "lines": 2 }), "one line per member on a newer release (#1617)");
	let told = run_with(&script, LIVE_STUBS, FILES, true, Some("PolestarDB = { schema = 1, settings = { party = { share = true, show = true } }, update = { shown = \"0.3.8\" } }"));
	assert_eq!(told[0], json!({ "hello": "0.3.7", "peer": "0.3.8", "lines": 0 }), "the card said 0.3.8 is out");
}

// Group play: on by default, the "2U|" unit message, sharing with the reason a member cannot take a
// quest, the party panel's rows and the loot a member still needs. The wait itself, with a real guide:
// party-group.rs.

fn saved_run(saved: Option<&str>, script: &str) -> Vec<Value> {
	run_with(&sent(script), LIVE_STUBS, FILES, true, saved)
}

const NOTICE: &str = r#"
local function told()
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find("Party sync is on", 1, true) then n = n + 1 end end
	return n
end"#;

#[test]
fn party_sync_is_on_by_default_a_player_who_turned_it_off_stays_off_and_the_first_member_progress_shown_says_so_once() {
	let script = format!(
		"{NOTICE}{}",
		r#"
p.hellos = true
p.quiet.Ana = true
w.onQuest(33, { 8 })
p.join("Ana")
stub.advance(6)
emit(texts())
emit(told())
p.sent = {}
p.receive("Ana-TestRealm", "1Y|0.0.1")
emit(told())
p.receive("Ana-TestRealm", "1|60:1/4")
p.receive("Ana-TestRealm", "1|60:2/4")
stub.advance(6)
emit(texts())
emit(told())
emit(stub.messages[#stub.messages] or false)
p.disband(); p.join("Ben"); stub.advance(6)
p.receive("Ben-TestRealm", "1|60:1/4")
emit(told())"#
	);
	let fresh = saved_run(None, &script);
	assert_eq!(fresh[0], json!(["1H|0.1.0-test"]), "never touched: on, and only the hello before anyone answers");
	assert_eq!(fresh[3], json!(["1S|33:0/8"]), "Ana runs Polestar: she gets our snapshot");
	assert_eq!(json!([fresh[1], fresh[2], fresh[4], fresh[6]]), json!([0, 0, 1, 1]), "said once, when the first member's progress shows (her answer alone shows nothing)");
	assert_eq!(fresh[5], "|cff4fd1c5Polestar|r: Party sync is on: you and your party see each other's quest progress. Turn it off in Options.");
	let no_share = saved_run(Some("PolestarDB = { schema = 1, settings = { party = { share = false } } }"), &script);
	assert_eq!(no_share[0], json!(["1H|0.1.0-test"]), "showing alone still says hello");
	assert!(no_share[3] == json!([]) || no_share[3] == json!({}), "sharing turned off stays off: {}", no_share[3]);
	assert_eq!(no_share[4], 0, "a player who turned sharing off has been to Options: nothing to say");
	let off = saved_run(Some("PolestarDB = { schema = 1, settings = { party = { share = false, show = false } } }"), &script);
	assert!(off[0] == json!([]) || off[0] == json!({}), "both off: nothing sent, {}", off[0]);
}

// The handshake: a party whose members don't run Polestar gets one hello and sees nothing of group play;
// a member who answers starts the sync and the features; one who leaves takes their hold along at once.
#[test]
fn party_with_members_without_polestar_only_the_hello_goes_out_and_nothing_shows_until_one_answers() {
	let out = run_with(
		&sent(&format!(
			"{PANEL_GUIDE}{}",
			r#"
p.hellos = true
p.quiet.Ana, p.quiet.Ben = true, true
w.onQuest(33, { 8 })
w.progress(33, 1, 8)
p.join("Ana"); p.join("Ben")
p.onQuest.Ana = { [33] = false }; p.onQuest.Ben = { [33] = false }
stub.advance(10)
w.progress(33, 1, 7); stub.advance(10)
local goal = { t = "kill", quest = 33, oi = 1, status = "done", subject = "Kobold Vermin" }
local function seen()
	return { sent = texts(), line = P.Line(goal) or false, step = P.StepLine() or false, roster = #P.Roster(),
		share = P.ShareFor(goal) or false, missing = #P.Missing(33), waiting = P.Waiting(goal) or false, holds = P.HoldsQuest(33),
		panel = (function() Polestar.Set("party.panel", true); local f = Polestar.UI.PartyPanel.Frame(); return f ~= nil and f:IsShown() end)() }
end
emit(seen())
p.sent = {}
p.receive("Ana-TestRealm", "1Y|0.0.1")
stub.advance(6)
emit(seen())
p.receive("Ana-TestRealm", "1S|33:2/8")
stub.advance(1)
emit({ waiting = P.Waiting(goal), holds = P.HoldsQuest(33) })
p.leave("Ana")
emit({ waiting = P.Waiting(goal) or false, holds = P.HoldsQuest(33), roster = #P.Roster() })"#
		)),
		LIVE_STUBS,
		GROUP_FILES,
		true,
		None,
	);
	let quiet = &out[0];
	assert_eq!(
		quiet,
		&json!({ "sent": ["1H|0.1.0-test"], "line": false, "step": false, "roster": 0, "share": false, "missing": 0, "waiting": false, "holds": false, "panel": false }),
		"a member without Polestar: one hello, nothing shown"
	);
	let answered = &out[1];
	assert_eq!(answered["sent"], json!(["1S|33:7/8", "1P|5|0.1.0-test|test|3|test/g"]), "she answered: our snapshot and place");
	assert_eq!(answered["missing"], 1, "now she counts as lacking quest 33");
	assert_eq!(answered["roster"], 1);
	assert_eq!(answered["panel"], true);
	assert_eq!(out[2], json!({ "waiting": [{ "name": "Ana", "cur": 2, "max": 8 }], "holds": true }));
	assert_eq!(out[3], json!({ "waiting": false, "holds": false, "roster": 0 }), "she left: her hold goes at once");
}

#[test]
fn party_the_unit_message_round_trips_ignores_later_fields_and_version_1_decoders_drop_it() {
	let out = run(r#"
local text = P.EncodeUnit({ level = 12, xp = 45, class = 8, race = 1 })
emit(text); emit(P.DecodeUnit(text)); emit(P.DecodeUnit(text .. "|0.3.7|later"))
emit({ P.Decode(text) == nil, P.DecodePos(text) == nil })
emit({ P.DecodeUnit("1|33:1/2") == nil, P.DecodeUnit("2U|0|5||") == nil, P.DecodeUnit("2U|12|101||") == nil, P.DecodeUnit("2U|12|5||x") == nil })
emit(P.DecodeUnit("2U|3|0||"))"#);
	assert_eq!(out[0], "2U|12|45|8|1");
	assert_eq!(out[1], json!({ "level": 12, "xp": 45, "class": 8, "race": 1 }), "0.3.6 and older send no version");
	assert_eq!(out[2], json!({ "level": 12, "xp": 45, "class": 8, "race": 1, "version": "0.3.7" }), "the version, then a later version's fields ignored");
	assert_eq!(out[3], json!([true, true]), "the version-1 decoders (what older Polestar runs) drop it");
	assert_eq!(out[4], json!([true, true, true, true]));
	assert_eq!(out[5], json!({ "level": 3, "xp": 0 }), "class and race may be unknown");
}

// 0.3.7 adds the sender's Polestar version to "2U|" and the "2D|" message. A 0.3.6 client (tag v0.3.6) runs the
// decoders below: its DecodeUnit whole, the others by their patterns, which decide what each takes. It must still read
// the unit, and drop "2D|" as it drops every message it does not know (its handler then returns before anything else).
const DECODERS_036: &str = r#"
local Old = {}
local function count(s) local n = tonumber(s); return n and n <= 999 and n or nil end
function Old.DecodeUnit(text)
	if type(text) ~= "string" then return nil end
	local level, xp, class, race, rest = text:match("^2U|(%d+)|(%d+)|(%d*)|(%d*)(.*)$")
	if not level or (rest ~= "" and rest:sub(1, 1) ~= "|") then return nil end
	level, xp = count(level), tonumber(xp)
	if not level or level < 1 or xp > 100 then return nil end
	return { level = level, xp = xp, class = count(class), race = count(race) }
end
function Old.Decode(text)
	if type(text) ~= "string" then return nil end
	local mark, body = text:match("^1([SRQ]?)|(.*)$")
	if not mark then return nil end
	return mark
end
function Old.DecodeHello(text) return (type(text) == "string" and text:match("^1([HY])|([^|]*)$")) or nil end
function Old.DecodePos(text) return (type(text) == "string" and text:match("^1P|(%d+)|([^|]*)|([^|]*)|([^|]*)|(.+)$")) or nil end
function Old.DecodeAt(text) return (type(text) == "string" and text:match("^2([PG])|([%w%.]+)|(.+)$")) or nil end
function Old.DecodeAnswer(text) return (type(text) == "string" and text:match("^2A|(.)$")) or nil end
"#;

#[test]
fn party_a_0_3_6_client_reads_the_new_unit_message_and_drops_the_done_message() {
	let out = run(&format!(
		"{DECODERS_036}{}",
		r#"
local unit = P.EncodeUnit({ level = 12, xp = 45, class = 8, race = 1, version = "0.3.7" })
local done = P.EncodeDone({ 33, 60 })
emit(unit); emit(Old.DecodeUnit(unit)); emit(done)
local dropped = true
for _, f in pairs(Old) do if f(done) ~= nil then dropped = false end end
emit(dropped)
-- And the new client reads a 0.3.6 one's unit, which has no version.
emit(P.DecodeUnit("2U|12|45|8|1"))"#
	));
	assert_eq!(out[0], "2U|12|45|8|1|0.3.7");
	assert_eq!(out[1], json!({ "level": 12, "xp": 45, "class": 8, "race": 1 }), "0.3.6 reads the unit and ignores the version");
	assert_eq!(out[2], "2D|33,60");
	assert_eq!(out[3], true, "every 0.3.6 decoder drops \"2D|\"");
	assert_eq!(out[4], json!({ "level": 12, "xp": 45, "class": 8, "race": 1 }));
}

#[test]
fn party_the_done_message_round_trips_fits_255_bytes_and_refuses_malformed_text() {
	let out = run(r#"
local ids = {}
for i = 1, 60 do ids[i] = 78000 + i end
local long = P.EncodeDone(ids)
local n = 0
for _ in pairs(P.DecodeDone(long)) do n = n + 1 end
emit({ #long <= 255, n, long:sub(1, 15) })
emit({ P.EncodeDone({}), next(P.DecodeDone("2D|")) == nil, P.DecodeDone("2D|33|later")[33] })
emit({ P.DecodeDone("2D|1,,2") == nil, P.DecodeDone("2D|x") == nil, P.DecodeDone("2D|0") == nil, P.DecodeDone("1D|33") == nil })
emit({ P.Decode("2D|33") == nil, P.DecodePos("2D|33") == nil, P.DecodeUnit("2D|33") == nil, P.DecodeAt("2D|33") == nil })"#);
	assert_eq!(out[0], json!([true, 40, "2D|78001,78002,"]), "the nearest first, 40 at most, under 255 bytes");
	assert_eq!(out[1], json!(["2D|", true, true]), "none is \"2D|\"; a later version's fields are ignored");
	assert_eq!(out[2], json!([true, true, true, true]));
	assert_eq!(out[3], json!([true, true, true, true]));
}

#[test]
fn party_a_member_s_new_or_unknown_messages_change_nothing_else_and_raise_no_error() {
	let out = live(&sent_members(
		r#"
p.join("Ana")
p.receive("Ana-TestRealm", "1|33:5/8")
p.receive("Ana-TestRealm", "2U|14|55|8|1|0.3.9|more")
p.receive("Ana-TestRealm", "3Z|whatever|comes|next")
p.receive("Ana-TestRealm", "2P|5|x")
emit(members()); emit(P.Members()[1].unit); emit(#Polestar.Errors())"#,
	));
	assert_eq!(out[0], json!(["Ana 33:5/8"]));
	assert_eq!(out[1], json!({ "level": 14, "xp": 55, "class": 8, "race": 1, "version": "0.3.9" }));
	assert_eq!(out[2], 0);
}

#[test]
fn party_your_level_and_xp_go_out_with_the_snapshot_and_again_only_when_the_whole_percent_moves() {
	let out = live(&sent(
		r#"
p.units = true
w.setLevel(12); w.setXP(100, 1000)
stub.advance(3)
emit(#p.sent)
p.join("Ana"); stub.advance(6)
emit(texts())
p.sent = {}
w.setXP(105, 1000); stub.advance(3)
emit(#p.sent)
w.setXP(200, 1000); stub.advance(3)
emit(texts())"#,
	));
	assert_eq!(out[0], 0, "solo: nothing");
	assert_eq!(out[1], json!(["1R|", "2U|12|10|1|1|0.1.0-test"]), "with your Polestar version");
	assert_eq!(out[2], 0, "still 10%");
	assert_eq!(out[3], json!(["2U|12|20|1|1|0.1.0-test"]));
}

// A quest database for the reasons a member cannot take quest 33 (level 10, warriors and paladins).
const QDB: &str = r#"
local Q = Polestar.QuestDB
Q.IsLoaded = function() return true end
Q.GetQuest = function(q) if q == 33 then return { id = 33, minLevel = 10, classes = 1 + 2, objectives = {} } end end
"#;

const GROUP_FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "UI/UI.xml", "Quests/QuestDB.lua", "Quests/Party.lua"];

fn group(script: &str) -> Vec<Value> {
	run_with(&sent(script), LIVE_STUBS, GROUP_FILES, true, None)
}

#[test]
fn party_share_is_offered_only_for_a_quest_you_have_that_a_member_lacks_and_can_take_with_why_not() {
	let out = group(&format!(
		"{QDB}{}",
		r#"
local goal = { t = "kill", quest = 33, oi = 1, status = "active" }
p.join("Ana"); p.join("Ben"); p.join("Cy"); p.join("Dee")
p.onQuest.Ana = { [33] = true }
p.set("Ben", { level = 8, class = "WARRIOR", race = "Human" })
p.set("Cy", { level = 12, class = "MAGE", race = "Human" })
p.set("Dee", { level = 12, class = "WARRIOR", race = "Human" })
emit(P.ShareFor(goal) == nil)
w.onQuest(33, { 8 })
emit(P.ShareFor(goal))
emit(P.Line(goal))
emit(P.Share(33)); emit(p.shared)
p.pushResult("Dee", "ERR_QUEST_PUSH_ALREADY_DONE_S")
stub.advance(1)
emit(P.ShareFor(goal) == nil)
emit(P.Line(goal))
p.pushable[33] = false
p.set("Ben", { level = 10 })
emit(P.ShareFor(goal) == nil)"#
	));
	assert_eq!(out[0], true, "not in your log: nothing to share");
	assert_eq!(out[1], json!(["Dee"]), "Ana has it; Ben is too low, Cy another class");
	assert_eq!(out[2], "Not on this quest: Ben (level 8, needs 10), Dee", "Cy's class cannot take it: her guide never has it, so the line leaves her out");
	assert_eq!(json!([&out[3], &out[4]]), json!([true, [33]]));
	assert_eq!(out[5], true, "the game said Dee has done it");
	assert_eq!(out[6], "Not on this quest: Ben (level 8, needs 10), Dee (already done)");
	assert_eq!(out[7], true, "a quest the game will not share: no Share");
}

#[test]
fn party_a_member_who_handed_the_quest_in_reads_already_done_and_one_who_cannot_take_it_is_left_out() {
	let out = group(&format!(
		"{QDB}{}",
		r#"
local goal = { t = "kill", quest = 33, oi = 1, status = "active" }
w.onQuest(33, { 8 })
p.join("Cy"); p.join("Dee")
p.set("Cy", { level = 12, class = "MAGE", race = "Human" })
p.set("Dee", { level = 12, class = "WARRIOR", race = "Human" })
p.receive("Dee-TestRealm", "1S|60:1/4")
emit({ P.Line(goal) or false, P.ShareFor(goal) or false })
p.receive("Dee-TestRealm", "2D|71,33")
emit({ P.Line(goal) or false, P.ShareFor(goal) or false })
-- Her next snapshot replaces what she did; no "2D|" after it: she has done none of it.
p.receive("Dee-TestRealm", "1S|60:2/4")
emit({ P.Line(goal) or false, P.ShareFor(goal) or false })
p.leave("Dee")
emit(P.Line(goal) or false)"#
	));
	assert_eq!(out[0], json!(["Not on this quest: Dee", ["Dee"]]), "Cy, a Mage, never had the Warrior quest: not named");
	assert_eq!(out[1], json!(["Not on this quest: Dee (already done)", false]), "her \"2D|\" says she handed it in: no Share");
	assert_eq!(out[2], json!(["Not on this quest: Dee", ["Dee"]]));
	assert_eq!(out[3], false, "only Cy, who cannot take it: no line at all");
}

#[test]
fn party_the_quests_you_handed_in_around_your_step_go_out_after_your_place_and_again_only_when_they_change() {
	let out = live(&sent(
		r#"
local E = Polestar.Engine
local steps = {}
for i = 1, 30 do steps[i] = { goals = {} } end
steps[3].goals = { { t = "turnin", quest = 60 } }
steps[4].goals = { { t = "accept", quest = 61 }, { t = "turnin", quest = 62 } }
steps[5].goals = { { t = "kill", quest = 33, oi = 1 } }
steps[29].goals = { { t = "turnin", quest = 99 } }
local guide = { id = "test/g", pack = "test", steps = steps }
E.GetGuide = function() return guide end
E.GetLiveStep = function() return 5 end
Polestar.Guides.Pack = function(id) if id == "test" then return { id = "test", title = "Test", version = "3" } end end
w.complete({ 60, 62, 99 })
local function done()
	local out = {}
	for _, t in ipairs(texts()) do if t:sub(1, 3) == "2D|" then out[#out + 1] = t end end
	return out
end
emit(P.MyDone())
p.join("Ana"); stub.advance(6.5)
local all = texts()
emit({ done(), all[#all] })
p.sent = {}
Polestar.Fire("STEP_UPDATED", 5); stub.advance(2.5)
emit(#p.sent)
w.complete({ 33 })
Polestar.Fire("STEP_UPDATED", 5); stub.advance(2.5)
emit(texts())
p.sent = {}
guide = { id = "test/h", pack = "test", steps = {} }
Polestar.Fire("GUIDE_CHANGED"); stub.advance(2.5)
emit(done())"#,
	));
	assert_eq!(out[0], json!([62, 60]), "the live step's and the steps before it, nearest first; step 29 is too far ahead");
	assert_eq!(out[1], json!([["2D|62,60"], "2D|62,60"]), "after the place, with the snapshot");
	assert_eq!(out[2], 0, "nothing changed: nothing sent");
	assert_eq!(out[3], json!(["2D|33,62,60"]), "the place is the same; only what you did goes out");
	assert_eq!(out[4], json!(["2D|"]), "another guide with none of it: the party is told to forget the list");
}

// In the client's chat lockdown (encounters, dungeons: CHAT_MSG_SYSTEM is SecretInChatMessagingLockdown in Forever's
// ChatInfoDocumentation) the share's answer comes as a secret string, and matching one throws. Lua 5.1 has no secret
// type, so the stub marks the line secret through issecretvalue: a handler that parsed it would mark Dee "already
// done"; the share's answer reads as no answer instead.
#[test]
fn party_a_secret_system_line_after_a_share_is_never_parsed() {
	let out = group(&format!(
		"{QDB}{}",
		r#"
local secret = {}
function issecretvalue(v) return type(v) == "string" and secret[v] ~= nil end
local goal = { t = "kill", quest = 33, oi = 1, status = "active" }
p.join("Dee")
p.set("Dee", { level = 12, class = "WARRIOR", race = "Human" })
w.onQuest(33, { 8 })
emit(P.Share(33))
secret[ERR_QUEST_PUSH_ALREADY_DONE_S:format("Dee")] = true
p.pushResult("Dee", "ERR_QUEST_PUSH_ALREADY_DONE_S")
stub.advance(1)
emit(P.Line(goal))"#
	));
	assert_eq!(out[0], true);
	assert_eq!(out[1], "Not on this quest: Dee", "the secret line is passed over, never parsed");
}

const PANEL_GUIDE: &str = r#"
local E = Polestar.Engine
E.GetGuide = function() return { id = "test/g", pack = "test", steps = { [5] = { title = "Kobold Camp" } } } end
E.GetLiveStep = function() return 5 end
Polestar.Guides.Pack = function(id) if id == "test" then return { id = "test", title = "Test", version = "3" } end end
E.GetStepView = function(i) if i == 5 then return { goals = { { t = "kill", quest = 33, oi = 1, status = "active", subject = "Kobold Vermin" } } } end end
"#;

#[test]
fn party_the_panel_has_a_row_per_member_with_level_xp_step_needs_and_state_and_points_the_arrow() {
	let out = group(&format!(
		"{PANEL_GUIDE}{}",
		r#"
local PP = Polestar.UI.PartyPanel
p.quiet.Ben = true
p.join("Ana"); p.join("Ben")
p.set("Ana", { class = "MAGE", level = 11, sex = 3, map = 1429, x = 40, y = 50, dead = true })
p.set("Ben", { class = "WARRIOR", level = 9 })
p.receive("Ana-TestRealm", "1P|5|0.0.1|test|3|test/g")
p.receive("Ana-TestRealm", "2U|12|45|8|1")
p.receive("Ana-TestRealm", "1|33:3/8")
local rows = P.Roster()
emit(rows)
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or false end
local function texts(e) local a, b, c, d = PP.RowText(e); return { plain(a), b, c or false, d or false } end
emit({ texts(rows[1]), #rows, (PP.RowText(rows[1])):sub(1, 4) == "|cff" })
stub.advance(1)
emit(PP.Frame() ~= nil and PP.Frame():IsShown())
Polestar.RunCommand("party")
emit({ PP.Frame():IsShown(), Polestar.Get("party.panel") })
Polestar.RunCommand("party")
emit(PP.Frame():IsShown())
Polestar.Set("ui.combat", "hide")
stub.fire("PLAYER_REGEN_DISABLED")
emit(PP.Frame():IsShown())
stub.fire("PLAYER_REGEN_ENABLED")
emit(PP.Frame():IsShown())
local t
Polestar.Nav = { SetTarget = function(map, x, y, label) t = { map, x, y, label }; return t end, GetTarget = function() return t end }
emit({ P.PointAt("party1"), t, P.PointAt("party2") })
p.disband()
emit(PP.Frame():IsShown())"#
	));
	let ana = &out[0][0];
	assert_eq!(
		json!([&ana["name"], &ana["class"], &ana["level"], &ana["xp"], &ana["polestar"], &ana["dead"], &ana["far"], &ana["offline"], &ana["step"]]),
		json!(["Ana", "MAGE", 12, 45, true, true, false, false, "Kobold Camp"])
	);
	assert_eq!(ana["needs"], json!([{ "what": "Kobold Vermin", "cur": 3, "max": 8 }]));
	assert_eq!(out[1][0], json!(["Ana", "Level 12  \u{b7}  45% XP", "Kobold Camp  \u{b7}  Dead", "Still needs: Kobold Vermin 3/8"]));
	assert_eq!(out[1][1], 1, "Ben runs no Polestar: no row");
	assert_eq!(out[1][2], true, "the name in its class colour");
	assert_eq!(out[2], true, "open by itself once Ana is heard");
	assert_eq!(out[3], json!([false, false]), "/polestar party closes it, and that is kept");
	assert_eq!(out[4], true, "and opens it again");
	assert_eq!(out[5], false, "hidden in combat when the guide hides there");
	assert_eq!(out[6], true);
	assert_eq!(out[7], json!([true, [1429, 40, 50, "Party: Ana"], false]), "Ben's place is not known: no arrow");
	assert_eq!(out[8], false, "solo: hidden");
}

// The row's height counts the step line only while it shows, so the needs line must hang under the name then, not
// under the hidden step line: a hidden region keeps its place in an anchor chain, and an empty one can keep a line's
// height (Feature Studio's render of #1617: Ana's wrapped needs line ran into Ben's row).
#[test]
fn party_a_row_without_a_step_hangs_its_needs_line_under_the_name_and_sizes_to_its_wrapped_lines() {
	let out = group(&format!(
		"{PANEL_GUIDE}{}",
		r#"
local PP = Polestar.UI.PartyPanel
p.join("Ana"); p.join("Ben")
p.set("Ana", { class = "MAGE", level = 17 }); p.set("Ben", { class = "WARRIOR", level = 8 })
p.receive("Ana-TestRealm", "1|33:3/8")
p.receive("Ben-TestRealm", "1|60:1/4")
stub.advance(1)
local F = PP.Frame()
local function rowOf(name)
	for _, r in ipairs(F.rows) do if r:IsShown() and r.psName == name then return r end end
end
local function seen(r)
	local _, rel = r.Needs:GetPoint(1)
	local h = 6 + r.Name:GetStringHeight() + (r.Step:IsShown() and (2 + r.Step:GetStringHeight()) or 0)
		+ (r.Needs:IsShown() and (2 + r.Needs:GetStringHeight()) or 0)
	return { step = r.Step:IsShown(), under = rel == r.Name and "name" or rel == r.Step and "step" or "other",
		wraps = r.Needs:GetNumLines() > 1, fits = r:GetHeight() >= h }
end
-- A long needs line wraps.
Polestar.Engine.GetStepView = function(i)
	if i == 5 then
		return { goals = { { t = "kill", quest = 33, oi = 1, status = "active", subject = "Shipment of Boots from Drizzlik's Emporium" },
			{ t = "kill", quest = 33, oi = 2, status = "active", subject = "Telescopic Lens from Fragile - Do Not Drop" } } }
	end
end
p.receive("Ana-TestRealm", "1|33:3/8,1/4")
PP.Refresh()
emit(seen(rowOf("Ana")))
p.receive("Ana-TestRealm", "1P|5|0.0.1|test|3|test/g")
PP.Refresh()
emit(seen(rowOf("Ana")))"#
	));
	assert_eq!(out[0], json!({ "step": false, "under": "name", "wraps": true, "fits": true }), "no step: under the name, every wrapped line in the row");
	assert_eq!(out[1], json!({ "step": true, "under": "step", "wraps": true, "fits": true }), "with her step: under it");
}

#[test]
fn party_a_collect_goal_and_the_loot_window_say_who_still_needs_an_item_you_do_not() {
	let out = group(
		r#"
local PL = Polestar.UI.PartyLoot
Polestar.Engine.GetGuide = function() return { id = "test/g", steps = { { goals = { { t = "collect", item = 723, quest = 33, oi = 1 } } } } } end
p.join("Ana"); p.join("Ben")
p.set("Ana", { sex = 3 }); p.set("Ben", { sex = 2 })
p.receive("Ana-TestRealm", "1|33:3/5")
p.receive("Ben-TestRealm", "1|33:5/5")
emit(P.Line({ t = "collect", quest = 33, oi = 1, status = "active", subject = "Goretusk Liver" }))
local LIVER = "|cffffffff|Hitem:723::::::::|h[Goretusk Liver]|h|r"
function GetNumLootItems() return 2 end
function GetLootSlotLink(i) if i == 1 then return "|cff9d9d9d|Hitem:2589::::::::|h[Linen Cloth]|h|r" end return LIVER end
function GetLootRollItemLink(id) return LIVER end
stub.fire("LOOT_OPENED")
emit(PL.Lines()); emit(PL.Frame() and PL.Frame():IsShown())
stub.fire("LOOT_CLOSED")
emit(#PL.Lines())
stub.fire("START_LOOT_ROLL", 7, 60000)
emit(PL.Lines())
stub.fire("CANCEL_LOOT_ROLL", 7)
emit(#PL.Lines())
w.onQuest(33, { 5 })
stub.fire("LOOT_OPENED")
emit(#PL.Lines())
stub.fire("LOOT_CLOSED")
w.abandon(33)
Polestar.Set("party.lootNeeds", false)
stub.fire("LOOT_OPENED")
emit(#PL.Lines())"#,
	);
	assert_eq!(out[0], format!("Ana still needs 2 Goretusk Liver{DOT}Ben done").as_str());
	assert_eq!(out[1], json!([format!("Goretusk Liver{DOT}For Ana: she still needs 2")]), "Ben has his; the cloth is no quest's");
	assert_eq!(out[2], true);
	assert_eq!(out[3], 0);
	assert_eq!(out[4], json!([format!("Goretusk Liver{DOT}For Ana: she still needs 2")]), "a roll says it too");
	assert_eq!(out[5], 0);
	assert_eq!(out[6], 0, "you need it too: nothing said");
	assert_eq!(out[7], 0, "the setting off");
}

#[test]
fn party_the_hello_and_its_answer_round_trip_and_older_decoders_drop_them() {
	let out = run(r#"
local h, y = P.EncodeHello(false), P.EncodeHello(true)
emit({ h, y })
emit({ P.DecodeHello(h) }); emit({ P.DecodeHello(y) })
emit({ P.Decode(h) == nil, P.DecodePos(h) == nil, P.Decode(y) == nil, P.DecodePos(y) == nil })
emit({ P.DecodeHello("1Q|") == nil, P.DecodeHello("1H|1|2") == nil, P.DecodeHello("2H|1") == nil })"#);
	assert_eq!(out[0], json!(["1H|0.1.0-test", "1Y|0.1.0-test"]));
	assert_eq!(out[1], json!(["H", "0.1.0-test"]));
	assert_eq!(out[2], json!(["Y", "0.1.0-test"]));
	assert_eq!(out[3], json!([true, true, true, true]), "the decoders of Polestar before the handshake drop both");
	assert_eq!(out[4], json!([true, true, true]));
}

// Forever's characters carry a surname (#1018): its client's UnitName gives ("Ana", "Smith") where other
// clients give (name, realm) (FrameXML Blizzard_FrameXMLUtil/Camelot/NameUtil.lua), and senders read
// "Ana Smith-Realm", "Ana Smith" once Ambiguate drops this realm.
const FOREVER: &str = r#"
local baseName = UnitName
function UnitName(unit) if unit == "player" then return "Testchar", "Brightwood" end return baseName(unit) end
"#;

#[test]
fn party_compat_names_a_unit_and_a_sender_alike_on_forever_first_last_and_elsewhere_name_realm_1018() {
	let out = live(&format!(
		"{SENT}{}",
		r#"
local C = Polestar.Compat
p.quiet.Ben, p.quiet.Ana = true, true
p.join("Ben", "Other Realm")
emit({ C.UnitFullName("party1") })
emit({ C.SenderName("Ben-OtherRealm"), C.SenderName("Ana-TestRealm"), C.SenderIsMe("Testchar-TestRealm"), C.SenderIsMe("Ana-TestRealm") })
local baseName = UnitName
function UnitName(unit) if unit == "player" then return "Testchar", "Brightwood" end return baseName(unit) end
p.join("Ana", nil, "Smith")
emit({ C.UnitFullName("party2") }); emit({ C.UnitFullName("player") })
emit({ C.SenderName("Ana Smith-TestRealm"), C.SenderName("Ana Smith-OtherRealm"), C.SenderIsMe("Testchar Brightwood-TestRealm"), C.SenderIsMe("Testchar-TestRealm") })
p.secretNames = true
emit(C.UnitFullName("party2"))"#
	));
	assert_eq!(out[0], json!(["Ben-OtherRealm", "Ben"]), "elsewhere the second part is the realm");
	assert_eq!(out[1], json!(["Ben-OtherRealm", "Ana", true, false]));
	assert_eq!(out[2], json!(["Ana Smith", "Ana"]), "on Forever it is the surname");
	assert_eq!(out[3], json!(["Testchar Brightwood", "Testchar"]));
	assert_eq!(out[4], json!(["Ana Smith", "Ana Smith", true, false]), "the realm left off, the first name alone is someone else");
	assert_eq!(out[5], false, "a secret name");
}

#[test]
fn party_forever_members_with_surnames_are_heard_and_synced_and_your_own_echo_is_no_member_1018() {
	let out = live(&sent_members(&format!(
		"{FOREVER}{}",
		r#"
w.onQuest(33, { 8 })
p.join("Ana", nil, "Smith")
stub.advance(6)
emit(texts())
p.receive("Ana Smith-TestRealm", "1|60:2/4")
p.receive("Testchar Brightwood-TestRealm", "1|70:1/2")
p.receive("Ana-TestRealm", "1|80:1/2")
stub.advance(1)
emit(members())
emit({ P.Spoke("Ana Smith"), #P.Roster(), P.Roster()[1].name })"#
	)));
	assert_eq!(out[0], json!(["1R|33:0/8"]), "her hello was heard: our snapshot, asking hers");
	assert_eq!(out[1], json!(["Ana 60:2/4"]), "hers counted; our own echo and another Ana are no member");
	assert_eq!(out[2], json!([true, 1, "Ana"]));
}

#[test]
fn party_the_party_command_says_why_nothing_shows_yet_and_debug_prints_what_goes_out_and_comes_in_1018() {
	let out = group(&format!(
		"{FOREVER}{}",
		r#"
stub.messages = {}
Polestar.RunCommand("party")
p.quiet.Ana = true
p.join("Ana", nil, "Smith")
stub.advance(6)
Polestar.RunCommand("party")
emit(stub.messages)
stub.messages = {}
p.receive("Ana Smith-TestRealm", "1H|0.3.3")
stub.advance(1)
Polestar.RunCommand("party debug")
emit(stub.messages)
emit(Polestar.UI.PartyPanel.Frame():IsShown())"#
	));
	let said = out[0].as_array().unwrap();
	assert_eq!(said.len(), 2, "{said:?}");
	assert!(is_match(text(&said[0]), r"shows in a party \(not a raid\)"), "{said:?}");
	assert!(is_match(text(&said[1]), r"No one else in your party has been heard running Polestar yet"), "{said:?}");
	let debug = out[1].as_array().unwrap().iter().map(|v| text(v).to_string()).collect::<Vec<_>>().join("\n");
	assert!(is_match(&debug, r"prefix Polestar registered"), "{debug}");
	assert!(is_match(&debug, r"sent \d+, last 1H\| result 0; received 1, from party members 1, last sender Ana Smith-TestRealm"), "{debug}");
	assert!(is_match(&debug, r"you Testchar Brightwood"), "{debug}");
	assert!(is_match(&debug, r"party1 Ana Smith: in roster true, spoke Polestar true"), "{debug}");
	assert_eq!(out[2], true, "heard: the panel opened by itself");
}

#[test]
fn party_forever_name_shapes_the_player_s_name_whole_senders_with_or_without_a_realm_the_client_s_unit_check_and_secrets_1018() {
	let out = live(&sent_members(
		r#"
local C = Polestar.Compat
-- UnitName gives the player's name whole and party members' split; UnitNameUnmodified splits the player's.
local baseName = UnitName
function UnitName(unit) if unit == "player" then return "Testchar Brightwood" end return baseName(unit) end
function UnitNameUnmodified(unit) if unit == "player" then return "Testchar", "Brightwood" end return baseName(unit) end
p.quiet.Ana = true
p.join("Ana", nil, "Smith")
emit({ C.UnitFullName("player") }); emit({ C.UnitFullName("party1") })
emit({ C.SenderIsMe("Testchar Brightwood-TestRealm"), C.SenderIsMe("Testchar Brightwood"), C.SenderIsUnit("Ana Smith-TestRealm", "party1"), C.SenderIsUnit("Ana Smith", "player") })
p.receive("Ana Smith", "1|33:1/8")
p.receive("Testchar Brightwood", "1|60:1/4")
stub.fire("CHAT_MSG_ADDON", "Polestar", p.SECRET, "PARTY", "Ana Smith-TestRealm", "", 0, 0, "", 0)
stub.fire("CHAT_MSG_ADDON", "Polestar", "1|70:1/2", "PARTY", p.SECRET, "", 0, 0, "", 0)
emit(members()); emit(#Polestar.Errors())
p.secretIsUnit = true
emit(C.SenderIsUnit("Ana Smith-TestRealm", "party1"))"#,
	));
	assert_eq!(out[0], json!(["Testchar Brightwood", "Testchar"]), "whole, its first name to show");
	assert_eq!(out[1], json!(["Ana Smith", "Ana"]), "the player's whole name tells that the second part is a surname");
	assert_eq!(out[2], json!([true, true, true, false]));
	assert_eq!(out[3], json!(["Ana 33:1/8"]), "a sender without the realm counts; our echo and secret values do not");
	assert_eq!(out[4], 0, "no error");
	assert_eq!(out[5], false, "a secret answer is no");
}


// Boosted Rest (QoL/Rest.lua) as its own "2B|" message: every older decoder drops it, a later version's fields
// are ignored, a member who never sends it (an older client) shows none, and the panel counts it down.
#[test]
fn party_boosted_rest_round_trips_and_older_decoders_drop_it() {
	let out = run(r#"
emit({ P.EncodeRest(2519.2), P.EncodeRest(true), P.EncodeRest(nil), P.EncodeRest(0) })
emit({ P.DecodeRest("2B|2520"), P.DecodeRest("2B|*"), P.DecodeRest("2B|0"), P.DecodeRest("2B|2520|later") })
emit({ P.Decode("2B|2520") == nil, P.DecodePos("2B|2520") == nil, P.DecodeUnit("2B|2520") == nil, P.DecodeAt("2B|2520") == nil,
	P.DecodeAnswer("2B|2520") == nil, P.DecodeHello("2B|2520") == nil, P.DecodeRest("2U|12|45|8|1") == nil, P.DecodeRest("2B|x") == nil,
	P.DecodeRest("2B|2520x") == nil, P.DecodeRest("1B|20") == nil })"#);
	assert_eq!(out[0], json!(["2B|2520", "2B|*", "2B|0", "2B|0"]));
	assert_eq!(out[1], json!([2520, true, false, 2520]), "fields after the first are ignored");
	assert_eq!(out[2], json!([true, true, true, true, true, true, true, true, true, true]));
}

#[test]
fn party_boosted_rest_goes_out_on_a_change_only_and_an_end_only_after_it_was_on() {
	let out = live(&sent(r#"
local left
Polestar.QoL = { On = function(k) return k == "boostedRest" end, Rest = { Left = function() return left end } }
w.onQuest(33, { 8 })
p.join("Ana"); stub.advance(10)
p.sent = {}
Polestar.Fire("QOL_REST_UPDATED", true); stub.advance(3)
emit(#texts())
left = 2520
Polestar.Fire("QOL_REST_UPDATED", false); stub.advance(3)
emit(#texts())
Polestar.Fire("QOL_REST_UPDATED", true); stub.advance(3)
emit(texts()[1])
p.sent = {}
left = nil
Polestar.Fire("QOL_REST_UPDATED", true); stub.advance(3)
emit(texts()[1])
p.sent = {}
Polestar.Fire("QOL_REST_UPDATED", true); stub.advance(3)
emit(#texts())"#));
	assert_eq!(out[0], 0, "never on: nothing to say");
	assert_eq!(out[1], 0, "a minute redraw is no change");
	assert_eq!(out[2], "2B|2520");
	assert_eq!(out[3], "2B|0", "it ended: the party that heard it on is told");
	assert_eq!(out[4], 0, "and only once");
}

#[test]
fn party_boosted_rest_of_a_member_shows_on_their_panel_row_and_an_older_client_shows_none() {
	let out = group(&format!(
		"{PANEL_GUIDE}{}",
		r#"
local PP = Polestar.UI.PartyPanel
p.join("Ana")
p.set("Ana", { class = "MAGE", level = 11 })
p.receive("Ana-TestRealm", "2U|12|45|8|1")
local function lvl() local _, b = PP.RowText(P.Roster()[1]); return b end
emit({ P.Roster()[1].rest or false, lvl() })
p.receive("Ana-TestRealm", "2B|2520")
stub.advance(60)
emit({ math.floor(P.Roster()[1].rest + 0.5), lvl() })
p.receive("Ana-TestRealm", "2B|*")
emit(lvl())
p.receive("Ana-TestRealm", "2B|0")
emit({ P.Roster()[1].rest or false, lvl() })
p.receive("Ana-TestRealm", "2B|30")
stub.advance(31)
emit(P.Roster()[1].rest or false)"#
	));
	assert_eq!(out[0], json!([false, "Level 12  \u{b7}  45% XP"]), "an older client sends no \"2B|\": nothing shown");
	assert_eq!(out[1], json!([2460, "Level 12  \u{b7}  45% XP  \u{b7}  Boosted Rest 41m"]));
	assert_eq!(out[2], "Level 12  \u{b7}  45% XP  \u{b7}  Boosted Rest");
	assert_eq!(out[3], json!([false, "Level 12  \u{b7}  45% XP"]));
	assert_eq!(out[4], false, "run out since it arrived");
}
