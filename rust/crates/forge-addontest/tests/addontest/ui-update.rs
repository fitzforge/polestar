//! The update notices (addon/Polestar/Core/Update.lua, UI/UpdateCard.lua) against the real Core + Theme + UI
//! manifests and the fake Engine of tests/lua/stub_ui.lua: the card on the guide window at every login while a
//! newer release is known (from Polestar Client's ClientInfo.lua or another player), "Got it" for a day, the
//! stronger words and no way out two or more releases behind, never in combat, in an instance or the first two
//! minutes of a fresh install; the guide window's line; the old-build line when nothing is known; the report
//! window's warning. The guild hello runs over the party stub's addon channel.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];
/// stub.epoch: the tests' "now" at load.
const EPOCH: i64 = 1_791_000_000;
const DAY: i64 = 86_400;

// The class quest heads-up stays out of these (its own tests cover it). This build is 0.3.6, from its TOC
// (`before`), so the version first seen at load is 0.3.6 too.
const HEAD: &str = r#"uistub.install()
Polestar.UI.ClassToast.Check = function() return false end
local U, UC, CT, GF = Polestar.Update, Polestar.UI.UpdateCard, Polestar.UI.ClassToast, Polestar.UI.GuideFrame
local function card()
	local f = CT.frame
	if not (f and f:IsShown() and CT.current and CT.current.update) then return false end
	return { head = f.Head:GetText(), title = f.Title:GetText(), line = f.Giver:GetText(), how = f.Route:GetText(),
		act = f.Act:IsShown() and f.Act.Label:GetText() or false, later = f.Later:IsShown() and f.Later.Label:GetText() or false }
end
local function banner()
	local B = GF.parts.banner
	if not (B:IsShown() and B.psKind == "update") then return false end
	return { text = B.Text:GetText(), link = B.Jump.Label:GetText(), close = B.Close:IsShown() }
end
-- What Polestar Client wrote (ClientInfo.lua), checked `ago` seconds before now.
local function client(latest, releases, ago)
	PolestarClientInfo = { latest = latest, released = time() - 3 * 86400, checked = time() - (ago or 0), releases = releases }
end"#;

/// An account from before (no fresh install), with `settings` and `extra` fields in PolestarDB.
fn account(settings: &str, extra: &str) -> Option<String> {
	Some(format!("PolestarDB = {{ schema = 1, settings = {{ {settings} }}, welcomeSeen = 1, {extra} }}"))
}

fn run(script: &str, saved: Option<String>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		// Every folder of ours says 0.3.6, so the install check finds no mixed versions.
		before: r#"setmetatable(stub.addonMeta, { __index = function() return { Version = "0.3.6" } end })"#.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		script: format!("{HEAD}\n{script}"),
		..Default::default()
	})
}

const CLIENT_HOW: &str = "Polestar Client can update it for you: open it, press Update, then restart the game or /reload.";
const PLAIN_HOW: &str = "Update it with the CurseForge app or Polestar Client (or the zip from GitHub), then restart the game or /reload.";

#[test]
fn polestar_client_knows_a_newer_release_the_card_shows_10_seconds_after_login_and_the_line_stays() {
	let out = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6", "0.3.5" })
		stub.login()
		stub.advance(9)
		emit({ early = card() })
		stub.advance(2)
		emit(card())
		emit(banner())
		emit({ shown = PolestarDB.update.shown, ago = time() - PolestarDB.update.shownAt })
		-- The close button: gone until the next login; the line stays.
		CT.frame.Close:Click()
		stub.advance(60)
		emit({ again = card(), line = banner() ~= false })"#,
		account("", ""),
	);
	assert_eq!(out[0], json!({ "early": false }), "not before DELAY");
	assert_eq!(
		out[1],
		json!({ "head": "POLESTAR UPDATE", "title": "Polestar 0.3.7 is out", "line": "You're on 0.3.6.", "how": CLIENT_HOW,
			"act": "What's new", "later": "Got it" })
	);
	assert_eq!(out[2], json!({ "text": "Polestar 0.3.7 is out: you're on 0.3.6.", "link": "Update", "close": true }));
	assert_eq!(out[3]["shown"], "0.3.7");
	assert!((0..=2).contains(&out[3]["ago"].as_i64().unwrap()), "marked when it showed: {}", out[3]["ago"]);
	assert_eq!(out[4], json!({ "again": false, "line": true }));
	// The next login, the card shown before: it shows again, Got it or not.
	let next = run(
		r#"client("0.3.7", { "0.3.7", "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card() ~= false })"#,
		account("", &format!("update = {{ shown = \"0.3.7\", shownAt = {} }}", EPOCH - 3600)),
	);
	assert_eq!(next[0], json!({ "card": true }), "at every login while a newer release is known");
}

#[test]
fn got_it_keeps_the_card_away_for_a_day_and_the_line_stays() {
	let out = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6" })
		stub.login()
		stub.advance(11)
		CT.frame.Later:Click()
		emit({ card = card(), snooze = PolestarDB.update.snooze - time(), line = banner() ~= false })"#,
		account("", ""),
	);
	assert_eq!(out[0], json!({ "card": false, "snooze": DAY, "line": true }));
	let snoozed = run(
		r#"client("0.3.7", { "0.3.7", "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card(), line = banner() ~= false })"#,
		account("", &format!("update = {{ snooze = {} }}", EPOCH + 3600)),
	);
	assert_eq!(snoozed[0], json!({ "card": false, "line": true }), "within the day: no card");
	let after = run(r#"client("0.3.7", { "0.3.7", "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card() ~= false })"#, account("", &format!("update = {{ snooze = {} }}", EPOCH - 60)));
	assert_eq!(after[0], json!({ "card": true }), "a day later it is back");
}

#[test]
fn the_same_or_an_older_release_says_nothing_and_a_fresh_client_check_holds_back_the_old_build_line() {
	let script = r#"
		stub.login()
		stub.advance(11)
		emit({ card = card(), line = banner(), notice = U.Notice() or false })"#;
	let thirty_days = format!("update = {{ since = {{ version = \"0.3.6\", at = {} }} }}", EPOCH - 30 * DAY);
	let same = run(&format!("client(\"0.3.6\", {{ \"0.3.6\", \"0.3.5\" }}){script}"), account("", &thirty_days));
	assert_eq!(same[0], json!({ "card": false, "line": false, "notice": false }), "the Client checked: this is the newest");
	let older = run(&format!("client(\"0.3.5\", {{ \"0.3.5\" }}){script}"), account("", ""));
	assert_eq!(older[0], json!({ "card": false, "line": false, "notice": false }));
	// Nothing knows, and this build was first run 30 days ago: the line, no card.
	let old = run(script, account("", &thirty_days));
	assert_eq!(old[0]["card"], false);
	assert_eq!(old[0]["line"], json!({ "text": "This Polestar is 4 weeks old: updates come often, check for a newer one.", "link": "How to update", "close": true }));
	// A stale Client check (two weeks) no longer vouches for the build.
	let stale = run(&format!("client(\"0.3.6\", {{ \"0.3.6\" }}, 14 * 86400){script}"), account("", &thirty_days));
	assert_eq!(stale[0]["line"]["link"], "How to update");
	// A build first run 20 days ago: nothing yet.
	let young = run(script, account("", &format!("update = {{ since = {{ version = \"0.3.6\", at = {} }} }}", EPOCH - 20 * DAY)));
	assert_eq!(young[0], json!({ "card": false, "line": false, "notice": false }));
}

#[test]
fn a_peers_newer_release_shows_the_card_dev_builds_pre_releases_and_made_up_versions_do_not() {
	let out = run(
		r#"
		stub.login()
		stub.advance(11)
		emit({ before = card() })
		emit({ dev = U.NotePeer("dev"), rc = U.NotePeer("0.3.8-rc1"), short = U.NotePeer("999.0"), far = U.NotePeer("0.5.0"),
			huge = U.NotePeer("9.9.9"), older = U.NotePeer("0.3.5"), same = U.NotePeer("0.3.6"), junk = U.NotePeer("0.3.7; x") })
		emit({ still = card(), line = banner() })
		local ok = U.NotePeer("0.3.7")
		stub.advance(2)
		emit({ ok = ok, card = card(), line = banner(), peer = PolestarDB.update.peer })"#,
		account("", ""),
	);
	assert_eq!(out[0], json!({ "before": false }));
	assert_eq!(out[1], json!({ "dev": false, "rc": false, "short": false, "far": false, "huge": false, "older": false, "same": false, "junk": false }));
	assert_eq!(out[2], json!({ "still": false, "line": false }));
	assert_eq!(out[3]["ok"], true);
	assert_eq!(
		out[3]["card"],
		json!({ "head": "POLESTAR UPDATE", "title": "Polestar 0.3.7 is out", "line": "You're on 0.3.6.", "how": PLAIN_HOW,
			"act": "What's new", "later": "Got it" }),
		"heard during the session: the card then, without the Client's line"
	);
	assert_eq!(out[3]["line"]["text"], "Polestar 0.3.7 is out: you're on 0.3.6.");
	assert_eq!(out[3]["peer"], "0.3.7");
	// Kept for PEER_DAYS: a week later it no longer counts, and a Client check after it overrules it.
	let kept = run("stub.login(); stub.advance(11); emit({ card = card() ~= false })", account("", &format!("update = {{ peer = \"0.3.7\", peerAt = {} }}", EPOCH - 2 * DAY)));
	assert_eq!(kept[0], json!({ "card": true }));
	let expired = run("stub.login(); stub.advance(11); emit({ card = card() ~= false })", account("", &format!("update = {{ peer = \"0.3.7\", peerAt = {} }}", EPOCH - 8 * DAY)));
	assert_eq!(expired[0], json!({ "card": false }));
	let overruled =
		run(r#"client("0.3.6", { "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card() ~= false })"#, account("", &format!("update = {{ peer = \"0.3.7\", peerAt = {} }}", EPOCH - DAY)));
	assert_eq!(overruled[0], json!({ "card": false }), "the Client looked later and found 0.3.6 newest");
}

#[test]
fn two_releases_behind_says_so_cannot_be_closed_and_still_shows_with_the_option_off_once_a_day() {
	let off = "update = { card = false }";
	let out = run(
		r#"
		client("0.3.8", { "0.3.8", "0.3.7", "0.3.6", "0.3.5" })
		stub.login()
		stub.advance(11)
		emit(card())
		emit(banner())
		GF.DismissBanner()
		emit({ line = banner() ~= false })"#,
		account(off, ""),
	);
	assert_eq!(out[0]["line"], "You're on 0.3.6, 2 updates behind: fixes for the quests and arrow issues players report are in the newer versions.");
	assert_eq!(out[0]["title"], "Polestar 0.3.8 is out");
	assert_eq!(out[1], json!({ "text": "Polestar 0.3.8 is out: you're on 0.3.6, 2 updates behind.", "link": "Update", "close": false }));
	assert_eq!(out[2], json!({ "line": true }), "not closable two behind");
	// Shown an hour ago with the option off: not again today; the line stays.
	let today = run(
		r#"client("0.3.8", { "0.3.8", "0.3.7", "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card(), line = banner() ~= false })"#,
		account(off, &format!("update = {{ shownAt = {} }}", EPOCH - 3600)),
	);
	assert_eq!(today[0], json!({ "card": false, "line": true }));
	// One behind with the option off: neither.
	let one = run(r#"client("0.3.7", { "0.3.7", "0.3.6" }); stub.login(); stub.advance(11); emit({ card = card(), line = banner() })"#, account(off, ""));
	assert_eq!(one[0], json!({ "card": false, "line": false }));
	// Without the Client's list, the numbers say how far: 0.3.4 to 0.3.6 is 2.
	let numbers = run(r#"Polestar.version = "0.3.4"; stub.login(); U.NotePeer("0.3.6"); stub.advance(11); emit({ behind = select(2, U.Latest()), line = banner() })"#, account("", ""));
	assert_eq!(numbers[0]["behind"], 2);
	assert_eq!(numbers[0]["line"]["close"], false);
}

#[test]
fn it_waits_out_combat_an_instance_and_a_fresh_installs_first_two_minutes() {
	let combat = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6" })
		stub.inCombat = true
		stub.login()
		stub.advance(11)
		emit({ during = card() })
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(2)
		emit({ after = card() ~= false })"#,
		account("", ""),
	);
	assert_eq!(combat, vec![json!({ "during": false }), json!({ "after": true })]);
	let instance = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6" })
		uistub.instance = "party"
		stub.login()
		stub.advance(11)
		emit({ during = card() })
		uistub.instance = nil
		stub.fire("PLAYER_ENTERING_WORLD")
		stub.advance(2)
		emit({ after = card() ~= false })"#,
		account("", ""),
	);
	assert_eq!(instance, vec![json!({ "during": false }), json!({ "after": true })]);
	// A fresh install (no saved PolestarDB): nothing for two minutes, then the card.
	let fresh = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6" })
		stub.login()
		stub.advance(11)
		emit({ early = card() })
		stub.advance(114)
		emit({ after = card() ~= false })"#,
		None,
	);
	assert_eq!(fresh, vec![json!({ "early": false }), json!({ "after": true })]);
}

#[test]
fn whats_new_copies_the_release_notes_link_and_the_lines_update_brings_the_card_back() {
	let out = run(
		r#"
		client("0.3.7", { "0.3.7", "0.3.6" })
		stub.login()
		stub.advance(11)
		CT.frame.Act:Click()
		emit({ title = PolestarCopy.Title:GetText(), link = PolestarCopy.Box:GetText(), card = card() ~= false })
		CT.frame.Close:Click()
		GF.parts.banner.Jump:Click()
		emit({ back = card() ~= false })
		-- /polestar update does the same.
		CT.Hide()
		Polestar.RunCommand("update")
		emit({ command = card() ~= false })"#,
		account("", ""),
	);
	assert_eq!(out[0], json!({ "title": "Polestar 0.3.7: what's new", "link": "https://github.com/fitzforge/polestar/releases/tag/v0.3.7", "card": true }));
	assert_eq!(out[1], json!({ "back": true }));
	assert_eq!(out[2], json!({ "command": true }));
}

#[test]
fn the_report_window_asks_an_old_polestar_to_update_first_and_its_version_says_outdated() {
	let out = run(
		r#"
		stub.login()
		Polestar.UI.ShowReport()
		emit({ note = PolestarReport.Outdated:IsShown(), first = Polestar.UI.Report.Details().lines[1] })
		PolestarReport:Hide()
		client("0.3.7", { "0.3.7", "0.3.6" })
		Polestar.UI.ShowReport()
		emit({ note = PolestarReport.Outdated:IsShown() and PolestarReport.Outdated:GetText(), first = Polestar.UI.Report.Details().lines[1] })"#,
		account("", ""),
	);
	assert_eq!(out[0]["note"], false);
	assert!(out[0]["first"].as_str().unwrap().starts_with("Polestar 0.3.6 Beta \u{b7} "), "{}", out[0]["first"]);
	assert_eq!(out[1]["note"], "You're on an old Polestar (0.3.6): please update first, your problem may already be fixed.");
	assert!(out[1]["first"].as_str().unwrap().starts_with("Polestar 0.3.6 Beta (outdated: latest 0.3.7) \u{b7} "), "{}", out[1]["first"]);
}

// The guild hello: Core alone, the party stub's addon channel, a guild.
fn guild(script: &str, share: bool) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, settings = {{ party = {{ share = {share} }} }} }}"))],
		login: true,
		script: format!(
			r#"IsInGuild = function() return true end
Polestar.version = "0.3.7"
Polestar.Update.ReplyDelay = function() return 5 end
local p, U = stub.party, Polestar.Update
local function guildSent()
	local out = {{}}
	for _, m in ipairs(p.sent) do if m.chatType == "GUILD" then out[#out + 1] = m.prefix .. " " .. m.text end end
	p.sent = {{}}
	return out
end
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn the_guild_hello_says_the_version_once_a_newer_member_answers_once_and_a_newer_answer_counts() {
	let out = guild(
		r#"
		stub.advance(21)
		emit(guildSent())
		-- An older member logs in: we answer after a moment.
		p.receive("Ana-TestRealm", "1H|0.3.6", "GUILD")
		stub.advance(6)
		emit(guildSent())
		-- Another within REPLY_GAP: no answer.
		p.receive("Ben-TestRealm", "1H|0.3.5", "GUILD")
		stub.advance(6)
		emit(guildSent())
		-- Later, someone answers first with ours: ours is dropped.
		stub.advance(300)
		p.receive("Cy-TestRealm", "1H|0.3.6", "GUILD")
		p.receive("Dee-TestRealm", "1Y|0.3.7", "GUILD")
		stub.advance(6)
		emit(guildSent())
		-- A newer member's answer is a peer's version; a party message on the guild channel is not ours to read.
		p.receive("Eve-TestRealm", "1Y|0.3.8", "GUILD")
		emit({ latest = U.Latest() or false, helloAt = PolestarDB.update.helloAt ~= nil })"#,
		true,
	);
	assert_eq!(out[0], json!(["Polestar 1H|0.3.7"]), "once, HELLO_DELAY seconds after login");
	assert_eq!(out[1], json!(["Polestar 1Y|0.3.7"]));
	// An empty Lua table is emitted as {}.
	assert_eq!(out[2], json!({}), "at most one answer per REPLY_GAP");
	assert_eq!(out[3], json!({}), "Dee already answered with 0.3.7");
	assert_eq!(out[4], json!({ "latest": "0.3.8", "helloAt": true }));
	// Party sharing off: nothing goes out, what comes in still counts.
	let off = guild(
		r#"
		stub.advance(21)
		p.receive("Ana-TestRealm", "1H|0.3.6", "GUILD")
		stub.advance(6)
		p.receive("Eve-TestRealm", "1Y|0.3.8", "GUILD")
		emit({ sent = guildSent(), latest = U.Latest() or false })"#,
		false,
	);
	assert_eq!(off[0], json!({ "sent": {}, "latest": "0.3.8" }));
}

// The version probe: Core alone, the party stub's strangers (tests/lua/stub_party.lua `p.stranger`) and its
// addon channel, this build 0.3.6 from its TOC, the player a Forever character with a surname.
fn probe_run(script: &str, share: bool, extra: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: r#"setmetatable(stub.addonMeta, { __index = function() return { Version = "0.3.6" } end })"#.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, settings = {{ party = {{ share = {share} }} }}, {extra} }}"))],
		login: true,
		script: format!("{PROBE_HEAD}\n{script}"),
	})
}

fn probe(script: &str) -> Vec<Value> {
	probe_run(script, true, "")
}

const PROBE_HEAD: &str = r#"local p, U, w = stub.party, Polestar.Update, stub.world
local baseName = UnitName
function UnitName(unit) if unit == "player" then return "Testchar", "Brightwood" end return baseName(unit) end
local function whispers()
	local out = {}
	for _, m in ipairs(p.sent) do if m.chatType == "WHISPER" then out[#out + 1] = m.text .. " > " .. tostring(m.target) end end
	p.sent = {}
	return out
end
local n = 0
-- A stranger at `unit` (a new GUID each), then the event that shows them.
local function meet(unit, facts)
	n = n + 1
	facts = facts or {}
	facts.name, facts.surname = facts.name or ("Pl" .. string.char(96 + n)), facts.surname or "Smith"
	facts.faction, facts.guid = facts.faction or "Alliance", facts.guid or ("Player-1-000" .. n)
	p.stranger(unit, facts)
	if unit == "target" then stub.fire("PLAYER_TARGET_CHANGED")
	elseif unit == "mouseover" then stub.fire("UPDATE_MOUSEOVER_UNIT")
	else stub.fire("NAME_PLATE_UNIT_ADDED", unit) end
	stub.advance(0.2)
	return facts
end
local function hear(sender, text) p.receive(sender, text, "WHISPER") end"#;

#[test]
fn a_player_of_your_faction_you_target_gets_one_tagged_whisper_probe_after_the_clients_whisper_check() {
	let out = probe(
		r#"
		local a = meet("target", { name = "Ana" })
		emit({ checks = p.checks, sent = whispers(), probed = PolestarDB.update.probed["Ana Smith"] ~= nil })
		stub.advance(31)
		meet("target", a)
		meet("mouseover", a)
		emit({ again = whispers(), checks = #p.checks })
		meet("nameplate3")
		emit({ plate = whispers() })"#,
	);
	assert_eq!(out[0], json!({ "checks": ["Player-1-0001"], "sent": ["PSV1?0.3.6 > Ana Smith"], "probed": true }), "named as the game's Whisper names her");
	assert_eq!(out[1], json!({ "again": {}, "checks": 1 }), "once per player");
	assert_eq!(out[2], json!({ "plate": {} }), "a nameplate is no trigger (they flood in crowds)");
	// Probed 6 days ago (saved): not again; 8 days ago: again.
	let recent = probe_run(r#"meet("target", { name = "Ana" }); emit(whispers())"#, true, &format!("update = {{ probed = {{ [\"Ana Smith\"] = {} }} }}", EPOCH - 6 * DAY));
	assert_eq!(recent[0], json!({}));
	let week = probe_run(r#"meet("target", { name = "Ana" }); emit(whispers())"#, true, &format!("update = {{ probed = {{ [\"Ana Smith\"] = {} }} }}", EPOCH - 8 * DAY));
	assert_eq!(week[0], json!(["PSV1?0.3.6 > Ana Smith"]));
}

#[test]
fn probes_go_one_per_10_seconds_up_to_the_sessions_limit_and_the_saved_players_are_capped() {
	let out = probe(
		r#"
		U.PROBE_KEEP = 2
		meet("target"); local first = #whispers()
		stub.advance(3); meet("mouseover"); local gap = #whispers()
		stub.advance(30); meet("mouseover"); local later = #whispers()
		U.PROBE_SESSION = 3
		stub.advance(31); meet("target"); local third = #whispers()
		local kept = {}
		for k in pairs(PolestarDB.update.probed) do kept[#kept + 1] = k end
		table.sort(kept)
		stub.advance(31); meet("target"); local fourth = #whispers()
		emit({ first = first, gap = gap, later = later, third = third, fourth = fourth, kept = kept })"#,
	);
	assert_eq!(
		out[0],
		json!({ "first": 1, "gap": 0, "later": 1, "third": 1, "fourth": 0, "kept": ["Plc Smith", "Pld Smith"] }),
		"3 s after one: none (30 s apart); the session's last still goes out after its whisper check; the oldest saved player goes"
	);
}

#[test]
fn no_probe_to_the_other_faction_your_group_or_guild_a_hidden_name_in_instances_combat_or_lockdown() {
	let out = probe(
		r#"
		local out = {}
		local function try(label, facts, setup, undo)
			if setup then setup() end
			stub.advance(31)
			meet("target", facts)
			out[label] = #whispers()
			if undo then undo() end
		end
		try("horde", { faction = "Horde" })
		try("grouped", { grouped = true })
		try("guild", { guild = true })
		try("secret", { secret = true })
		try("instance", nil, function() w.inInstance = true end, function() w.inInstance = false end)
		try("combat", nil, function() stub.inCombat = true end, function() stub.inCombat = false end)
		try("lockdown", nil, function() p.lockdown = true end, function() p.lockdown = false end)
		try("wrongFaction", { guid = "Player-1-0999" }, function() p.whisperStatus["Player-1-0999"] = 3 end)
		try("ok", nil)
		C_ChatInfo.RequestCanLocalWhisperTarget = nil
		try("noCheck", nil)
		emit(out)"#,
	);
	assert_eq!(
		out[0],
		json!({ "horde": 0, "grouped": 0, "guild": 0, "secret": 0, "instance": 0, "combat": 0, "lockdown": 0, "wrongFaction": 0, "ok": 1, "noCheck": 1 }),
		"the client's check saying WrongFaction stops it; a client without the check sends at once"
	);
	let off = probe_run(r#"meet("target"); emit({ sent = whispers(), checks = #p.checks })"#, false, "");
	assert_eq!(off[0], json!({ "sent": {}, "checks": 0 }), "party sharing off: no probes");
}

#[test]
fn a_probe_is_answered_after_a_moment_once_a_minute_per_sender_never_an_answer_an_echo_or_another_channel() {
	let out = probe(
		r#"
		hear("Bob Stone-TestRealm", "PSV1?0.3.5")
		local now = whispers()
		stub.advance(3)
		local later = whispers()
		hear("Bob Stone-TestRealm", "PSV1?0.3.5")
		stub.advance(3)
		local again = whispers()
		stub.advance(61)
		hear("Bob Stone-TestRealm", "PSV1?0.3.5")
		stub.advance(3)
		local minute = whispers()
		hear("Testchar Brightwood-TestRealm", "PSV1?0.3.5")
		hear("Cy Hill-TestRealm", "PSV1=0.3.5")
		hear("Dee Moor-TestRealm", "1H|0.3.5")
		hear("Eve Dale-TestRealm", "PSV1?0.3.7")
		p.receive("Fay Rook-TestRealm", "PSV1?0.3.5", "PARTY")
		stub.advance(3)
		emit({ now = now, later = later, again = again, minute = minute, rest = whispers(), latest = U.Latest() or false })"#,
	);
	assert_eq!(
		out[0],
		json!({ "now": {}, "later": ["PSV1=0.3.6 > Bob Stone-TestRealm"], "again": {}, "minute": ["PSV1=0.3.6 > Bob Stone-TestRealm"],
			"rest": ["PSV1=0.3.6 > Eve Dale-TestRealm"], "latest": false }),
		"to the sender's own string; not our echo, a reply, a party hello or a party-channel probe; a probe's own version never counts"
	);
	let off = probe_run(r#"hear("Bob Stone-TestRealm", "PSV1?0.3.5"); stub.advance(3); emit({ sent = #p.sent })"#, false, "");
	assert_eq!(off[0], json!({ "sent": 0 }), "party sharing off: no answer");
}

#[test]
fn malformed_probe_messages_are_dropped_and_versions_are_capped() {
	let out = probe(
		r#"
		for _, t in ipairs({ "PSV1?0.3.7x", "PSV1?00000000000000000000.3.7", "PSV1?100.0.0", "PSV1?0.1000.0", "PSV1?0.3.1000", "PSV2?0.3.7",
			"V?0.3.7", "PSV1?0.3.7-rc1", "PSV1?0.3", "PSV1?dev", "psv1?0.3.7", "PSV1!0.3.7", "PSV1?0.3.7|x" }) do
			hear("Bob Stone-TestRealm", t)
		end
		stub.advance(3)
		emit({ sent = whispers(), parse = { U.ParseProbe("PSV1=0.03.7") }, cap = { U.ParseProbe("PSV1?99.999.999") }, padded = { U.ParseProbe("PSV1?099.0999.0999") } })"#,
	);
	assert_eq!(
		out[0],
		json!({ "sent": {}, "parse": ["=", "0.3.7"], "cap": ["?", "99.999.999"], "padded": ["?", "99.999.999"] }),
		"over 24 bytes, parts over 99/999, another tag or kind, a pre-release, two parts, a pipe: nothing answered"
	);
}

#[test]
fn only_answers_to_our_own_probes_count_and_a_newer_release_needs_two_players() {
	let out = probe(
		r#"
		local ana = meet("target", { name = "Ana" })
		whispers()
		hear("Ana Smith-TestRealm", "PSV1=0.3.7")
		local one = { latest = U.Latest() or false, heard = PolestarDB.update.heard["Ana Smith"] and PolestarDB.update.heard["Ana Smith"].v }
		hear("Ana Smith-TestRealm", "PSV1=0.3.8")
		hear("Zed Fox-TestRealm", "PSV1=0.3.8")
		local spoof = { latest = U.Latest() or false, ana = PolestarDB.update.heard["Ana Smith"].v, zed = PolestarDB.update.heard["Zed Fox"] or false }
		stub.advance(31)
		meet("target", { name = "Bob" })
		stub.advance(61)
		hear("Bob Smith-TestRealm", "PSV1=0.3.8")
		local late = { latest = U.Latest() or false, bob = PolestarDB.update.heard["Bob Smith"] or false }
		meet("target", { name = "Cy" })
		whispers()
		hear("Cy Smith-TestRealm", "PSV1=0.3.8")
		local two = { latest = U.Latest() or false, peer = PolestarDB.update.peer }
		stub.advance(31)
		meet("target")
		emit({ one = one, spoof = spoof, late = late, two = two, probes = whispers() })"#,
	);
	let o = &out[0];
	assert_eq!(o["one"], json!({ "latest": false, "heard": "0.3.7" }), "one player's answer is kept, not told");
	assert_eq!(o["spoof"], json!({ "latest": false, "ana": "0.3.7", "zed": false }), "one answer per probe; an unasked answer is ignored");
	assert_eq!(o["late"], json!({ "latest": false, "bob": false }), "an answer after 60 s is ignored");
	assert_eq!(o["two"], json!({ "latest": "0.3.7", "peer": "0.3.7" }), "two players: the lower of their two releases");
	assert_eq!(o["probes"], json!({}), "a newer release known: no more probes");
	let single = probe(
		r#"
		meet("target", { name = "Ana" })
		hear("Ana Smith-TestRealm", "PSV1=0.4.0")
		stub.advance(31)
		meet("target", { name = "Bob" })
		hear("Bob Smith-TestRealm", "PSV1=0.3.6")
		emit({ latest = U.Latest() or false, heard = PolestarDB.update.heard and PolestarDB.update.heard["Ana Smith"] and PolestarDB.update.heard["Ana Smith"].v or false, bob = PolestarDB.update.heard["Bob Smith"] or false })"#,
	);
	assert_eq!(single[0], json!({ "latest": false, "heard": "0.4.0", "bob": false }), "a single spoofed answer raises nothing; ours is no news");
}

#[test]
fn a_refused_probe_or_answer_is_skipped_quietly_and_not_tried_again() {
	let out = probe(
		r#"
		stub.messages = {}
		p.result = 12
		meet("target", { name = "Ana" })
		local a = { sent = #whispers(), probed = PolestarDB.update.probed["Ana Smith"] ~= nil }
		p.result = 3
		stub.advance(31)
		meet("target")
		p.result = 11
		hear("Bob Stone-TestRealm", "PSV1?0.3.5")
		stub.advance(3)
		emit({ a = a, b = #whispers(), messages = #stub.messages })"#,
	);
	assert_eq!(out[0], json!({ "a": { "sent": 1, "probed": true }, "b": 2, "messages": 0 }), "one attempt each, nothing in chat");
}

#[test]
fn no_probe_in_cities_or_inns_and_the_clients_kill_switch_or_the_setting_stops_probes_and_answers() {
	let out = probe(
		r#"
		local out = {}
		w.resting = true
		meet("target")
		out.resting = #whispers()
		w.resting = false
		stub.advance(31)
		meet("target")
		out.away = #whispers()
		-- Polestar Client's kill switch: no probes, no answers, the events gone.
		PolestarClientInfo = { latest = "0.3.6", checked = time(), releases = { "0.3.6" }, probe = false }
		U.Listen()
		stub.advance(31)
		meet("target")
		hear("Bob Stone-TestRealm", "PSV1?0.3.5")
		stub.advance(3)
		out.kill = { sent = #whispers(), probing = U.Probing() }
		PolestarClientInfo = nil
		U.Listen()
		-- The setting.
		Polestar.Set("update.probe", false)
		stub.advance(31)
		meet("target")
		hear("Cy Hill-TestRealm", "PSV1?0.3.5")
		stub.advance(3)
		out.setting = { sent = #whispers(), probing = U.Probing() }
		Polestar.Set("update.probe", true)
		out.back = U.Probing()
		emit(out)"#,
	);
	assert_eq!(
		out[0],
		json!({ "resting": 0, "away": 1, "kill": { "sent": 0, "probing": false }, "setting": { "sent": 0, "probing": false }, "back": true }),
		"a rest area (IsResting) skips; ClientInfo's probe = false and update.probe off send and answer nothing, the events unregistered"
	);
}

#[test]
fn at_most_20_probes_are_answered_a_session() {
	let out = probe(
		r#"
		for i = 1, 25 do hear("Pl" .. i .. " Stone-TestRealm", "PSV1?0.3.5") end
		stub.advance(3)
		emit({ answers = #whispers() })"#,
	);
	assert_eq!(out[0], json!({ "answers": 20 }));
}

// 1,000 mouseovers while a probe waits out PROBE_GAP, then 1,000 at the session's limit, through the game's
// event dispatch with Core's init, Compat and Update.lua alone (Engine and Names have mouseover handlers of their
// own): no work past the first comparison, no allocation, and at the limit the events are unregistered.
#[test]
fn a_thousand_mouseovers_at_the_limit_cost_one_comparison_each_and_allocate_nothing() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: r#"setmetatable(stub.addonMeta, { __index = function() return { Version = "0.3.6" } end })"#.into(),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Update.lua"])],
		// Party.lua (and its defaults) isn't loaded: sharing is on as saved.
		saved: vec![("Polestar".to_string(), "PolestarDB = { schema = 1, settings = { party = { share = true } } }".to_string())],
		login: true,
		script: format!(
			"{PROBE_HEAD}\n{}",
			r#"
		local frame
		for _, f in ipairs(stub.frames) do if f.events and f.events.UPDATE_MOUSEOVER_UNIT then frame = f end end
		meet("mouseover")           -- the probe goes out: the next ones wait PROBE_GAP
		local first = #whispers()
		local work = 0
		local probeTarget, unitName = U.ProbeTarget, UnitName
		U.ProbeTarget = function(...) work = work + 1 return probeTarget(...) end
		UnitName = function(...) work = work + 1 return unitName(...) end
		local onEvent = frame.scripts.OnEvent
		for i = 1, 20 do onEvent(frame, "UPDATE_MOUSEOVER_UNIT") end
		collectgarbage("collect"); collectgarbage("collect")
		collectgarbage("stop")
		local base = collectgarbage("count")
		for i = 1, 1000 do onEvent(frame, "UPDATE_MOUSEOVER_UNIT") end
		local gap = collectgarbage("count") - base
		collectgarbage("restart")
		local inGap = work
		-- At the session's limit: the events are gone, so a mouseover reaches nothing of Polestar's.
		U.PROBE_SESSION = 1
		U.Listen()
		collectgarbage("collect"); collectgarbage("collect")
		collectgarbage("stop")
		base = collectgarbage("count")
		for i = 1, 1000 do onEvent(frame, "UPDATE_MOUSEOVER_UNIT") end
		local limit = collectgarbage("count") - base
		collectgarbage("restart")
		emit({ first = first, gap = gap, limit = limit, inGap = inGap, atLimit = work - inGap, probing = U.Probing() })"#
		),
	});
	let o = &out[0];
	assert_eq!(o["first"], 1);
	assert_eq!((o["inGap"].as_i64(), o["atLimit"].as_i64(), o["probing"].as_bool()), (Some(0), Some(0), Some(false)), "{o}");
	let (gap, limit) = (o["gap"].as_f64().unwrap(), o["limit"].as_f64().unwrap());
	assert!(gap < 0.5 && limit < 0.5, "1,000 mouseovers allocated {gap:.2} KiB in the gap and {limit:.2} KiB at the limit");
}
