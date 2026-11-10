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
