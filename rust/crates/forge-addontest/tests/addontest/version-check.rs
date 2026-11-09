//! Quests/VersionCheck.lua: Polestar says its version to the guild and the raid in a hidden addon
//! message ("1H|<version>", Party.lua's hello), answers an older one ("1Y|<version>") at most once per
//! 5 minutes a channel, and says once a session when a guildmate or group member runs a newer release.
//! Against the fake client: tests/lua/stub_party.lua for the guild, the group and the addon channel.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Quests/Party.lua", "Quests/VersionCheck.lua"];

const HELPERS: &str = r#"
local V, P, p = Polestar.VersionCheck, Polestar.Party, stub.party
-- What went to the guild or the raid, as "<channel> <text>".
local function sends()
	local out = {}
	for _, m in ipairs(p.sent) do
		if m.chatType ~= "PARTY" then out[#out + 1] = m.chatType .. " " .. m.text end
	end
	return table.concat(out, "; ")
end
local function notices()
	local out = {}
	for _, m in ipairs(stub.messages) do
		if m:find("newer Polestar", 1, true) then out[#out + 1] = m end
	end
	return out
end"#;

// A player on Polestar `version`, in a guild at login or not, with `saved` settings.
fn run_as(version: &str, guild: bool, saved: Option<&str>, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: format!("stub.addonMeta.Polestar = {{ Version = \"{version}\" }}\nstub.party.inGuild = {guild}"),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		addons: vec![Addon::files("Polestar", FILES)],
		login: true,
		script: format!("{HELPERS}\n{script}"),
	})
}

const NOTICE: &str = "A newer Polestar (0.3.8) is out: update with the Polestar Client, the CurseForge app or the zip.";

#[test]
fn version_check_only_release_versions_count_and_compare_as_numbers() {
	let out = run_as(
		"0.3.7",
		false,
		None,
		r#"
emit({ V.IsRelease("0.3.7"), V.IsRelease("0.3.10"), V.IsRelease("10.0.0") })
emit({ V.IsRelease("dev"), V.IsRelease("0.3.0-rc.1"), V.IsRelease("0.2.5-test.1"), V.IsRelease("0.1.0-test"), V.IsRelease("1.0"),
	V.IsRelease("0.3.7.1"), V.IsRelease("12345.0.0"), V.IsRelease(""), V.IsRelease(" 0.3.7"), V.IsRelease(37), V.IsRelease(nil) })
emit({ P.Newer("0.3.10", "0.3.9"), P.Newer("0.3.9", "0.3.10"), P.Newer("0.3.7", "0.3.7"), P.Newer("1.0.0", "0.9.9") })"#,
	);
	assert_eq!(out[0], json!([true, true, true]));
	assert_eq!(out[1], json!([false, false, false, false, false, false, false, false, false, false, false]), "dev, test and candidate builds, malformed text");
	assert_eq!(out[2], json!([true, false, false, true]));
}

#[test]
fn version_check_the_version_goes_to_the_guild_once_15_seconds_after_login_and_again_only_after_rejoining() {
	let out = run_as(
		"0.3.7",
		true,
		None,
		r#"
stub.advance(14); emit(sends())
stub.advance(2); emit(sends())
p.sent = {}
p.guild(true); stub.advance(10); emit(sends())
stub.advance(600); emit(sends())
p.guild(false); stub.advance(10); emit(sends())
p.guild(true); stub.advance(4.9); emit(sends())
stub.advance(0.2); emit(sends())"#,
	);
	assert_eq!(out[0], "", "not before the guild's channel is up");
	assert_eq!(out[1], "GUILD 1H|0.3.7", "the version and nothing else");
	assert_eq!(out[2], "", "a guild update while in it (a rank change) sends nothing");
	assert_eq!(out[3], "", "never on a timer");
	assert_eq!(out[4], "", "out of the guild");
	assert_eq!(out[5], "");
	assert_eq!(out[6], "GUILD 1H|0.3.7", "joining a guild announces 5 s later");
}

#[test]
fn version_check_joining_a_guild_or_a_raid_announces_never_a_battleground_raid_or_a_dev_build() {
	let out = run_as(
		"0.3.7",
		false,
		None,
		r#"
stub.advance(20); emit(sends())
p.guild(true); stub.advance(6); emit(sends())
p.sent = {}
p.join("Ana"); p.raid(true); stub.advance(6); emit(sends())
p.sent = {}
p.raid(true); stub.advance(6); emit(sends())
p.disband(); stub.advance(1)
function IsInInstance() return true, "pvp" end
p.join("Ben"); p.raid(true); stub.advance(10); emit(sends())"#,
	);
	assert_eq!(out[0], "", "not in a guild at login");
	assert_eq!(out[1], "GUILD 1H|0.3.7");
	assert_eq!(out[2], "RAID 1H|0.3.7");
	assert_eq!(out[3], "", "once a raid");
	assert_eq!(out[4], "", "no raid messages in a battleground");

	let out = run_as(
		"0.3.8-rc.1",
		true,
		None,
		r#"
stub.advance(20); emit(sends())
p.receive("Ana-TestRealm", "1H|0.3.0", "GUILD"); stub.advance(13); emit(sends())
p.receive("Ana-TestRealm", "1Y|9.0.0", "GUILD"); emit(#notices())"#,
	);
	assert_eq!(out, vec![json!(""), json!(""), json!(0)], "a candidate build announces, answers and is told nothing");
}

#[test]
fn version_check_a_newer_release_is_said_once_a_session_older_and_the_same_are_not() {
	let out = run_as(
		"0.3.7",
		true,
		None,
		r#"
p.receive("Ana-TestRealm", "1H|0.3.6", "GUILD")
p.receive("Ana-TestRealm", "1H|0.3.7", "GUILD")
emit(#notices())
p.receive("Ben-TestRealm", "1Y|0.3.8", "GUILD")
emit(notices())
p.receive("Cy-TestRealm", "1H|0.4.0", "RAID")
p.receive("Cy-TestRealm", "1H|0.3.10", "PARTY")
p.receive("Dee-TestRealm", "1Y|0.3.9", "GUILD")
emit(#notices())"#,
	);
	assert_eq!(out[0], 0, "older and the same say nothing");
	let lines = out[1].as_array().unwrap();
	assert_eq!(lines.len(), 1);
	assert!(text(&lines[0]).ends_with(NOTICE), "{lines:?}");
	assert!(!text(&lines[0]).contains("Ben"), "no names: {lines:?}");
	assert_eq!(out[2], 1, "once a session, whoever says what");
}

#[test]
fn version_check_the_notice_can_be_turned_off_and_the_party_s_hello_feeds_it() {
	let off = "PolestarDB = { schema = 1, settings = { version = { notice = false } } }";
	let out = run_as(
		"0.3.7",
		true,
		Some(off),
		r#"
p.receive("Ana-TestRealm", "1Y|0.3.8", "GUILD")
emit(#notices())
Polestar.Set("version.notice", true)
p.receive("Ana-TestRealm", "1H|0.3.8")
emit(#notices())"#,
	);
	assert_eq!(out[0], 0, "off: nothing said");
	assert_eq!(out[1], 1, "back on, a party member's hello carries the version too");
}

#[test]
fn version_check_malformed_foreign_and_own_messages_are_ignored() {
	let out = run_as(
		"0.3.7",
		true,
		None,
		r#"
stub.advance(20)
p.sent = {}
local bad = { "1H|", "1H|dev", "1H|0.3.8-rc.1", "1H|0.3.8|x", "1H|0.3.8 ", "2H|0.3.8", "1X|0.3.8", "1H|0.3", "1H|99999.0.0",
	"1H|0.3.8.1", "1|33:5/8", "1P|8|0.3.8|test|4|test/g", "", "1H|0.3.0-test.1", "1Y|0.2" }
for _, t in ipairs(bad) do p.receive("Ana-TestRealm", t, "GUILD") end
p.receive("Ana-TestRealm", "1H|0.3.8", "WHISPER")
p.receive("Ana-TestRealm", "1H|0.3.8", "GUILD", "PolestarT1")
p.receive("Testchar-TestRealm", "1H|0.3.8", "GUILD")
p.receive("Testchar-TestRealm", "1H|0.3.0", "GUILD")
p.receive(p.SECRET, "1H|0.3.8", "GUILD")
p.receive("Ana-TestRealm", p.SECRET, "GUILD")
p.receive("Ana-TestRealm", "1H|0.3.8", p.SECRET)
stub.advance(15)
emit({ notices = #notices(), sent = sends() })"#,
	);
	assert_eq!(out[0], json!({ "notices": 0, "sent": "" }));
}

#[test]
fn version_check_an_older_announce_is_answered_once_per_5_minutes_unless_someone_else_answered_first() {
	let out = run_as(
		"0.3.7",
		true,
		None,
		r#"
stub.advance(20)
p.sent = {}
p.receive("Ana-TestRealm", "1H|0.3.5", "GUILD")
stub.advance(1.9); emit(sends())
stub.advance(10.2); emit(sends())
p.sent = {}
p.receive("Ben-TestRealm", "1H|0.3.6", "GUILD"); stub.advance(13); emit(sends())
stub.advance(300)
p.receive("Cy-TestRealm", "1H|0.3.7", "GUILD"); p.receive("Dee-TestRealm", "1H|0.3.9", "GUILD"); stub.advance(13); emit(sends())
p.receive("Ed-TestRealm", "1H|0.3.6", "RAID"); stub.advance(13); emit(sends())
p.receive("Jo-TestRealm", "1H|0.3.6", "PARTY"); stub.advance(13); emit(sends())
p.receive("Ed-TestRealm", "1H|0.3.6", "GUILD"); stub.advance(13); emit(sends())
stub.advance(300); p.sent = {}
p.receive("Fay-TestRealm", "1H|0.3.6", "GUILD")
stub.advance(1); p.receive("Gus-TestRealm", "1Y|0.3.7", "GUILD")
stub.advance(12); emit(sends())
p.receive("Hal-TestRealm", "1H|0.3.6", "GUILD")
stub.advance(1); p.receive("Ivy-TestRealm", "1Y|0.3.6", "GUILD")
stub.advance(12); emit(sends())"#,
	);
	assert_eq!(out[0], "", "the answer waits a random 2-12 s");
	assert_eq!(out[1], "GUILD 1Y|0.3.7");
	assert_eq!(out[2], "", "one answer per 5 minutes");
	assert_eq!(out[3], "", "the same or a newer version gets no answer");
	assert_eq!(out[4], "", "not in a raid: nothing to the raid");
	assert_eq!(out[5], "", "the party's hello is Party.lua's to answer");
	assert_eq!(out[6], "GUILD 1Y|0.3.7", "5 minutes on, answered again");
	assert_eq!(out[7], "", "someone else answered with our version first");
	assert_eq!(out[8], "GUILD 1Y|0.3.7", "an older answer covers nothing");
}

#[test]
fn version_check_a_refused_announce_is_tried_again_30_seconds_later_up_to_3_times() {
	let out = run_as(
		"0.3.7",
		true,
		None,
		r#"
p.result = 3
stub.advance(16); emit(#p.sent)
stub.advance(30); emit(#p.sent)
stub.advance(30); emit(#p.sent)
stub.advance(100); emit(#p.sent)
p.sent = {}; p.result = 0
p.guild(true); stub.advance(10); emit(#p.sent)
p.guild(false); p.guild(true); stub.advance(6); emit(sends())"#,
	);
	assert_eq!(out[..4], [json!(1), json!(2), json!(3), json!(3)], "3 tries, then it gives up");
	assert_eq!(out[4], 0, "given up until the guild is left");
	assert_eq!(out[5], "GUILD 1H|0.3.7");
}

#[test]
fn version_check_its_one_switch_sits_in_the_group_section_on_by_default() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: String::new(),
		saved: vec![],
		addons: vec![Addon::files(
			"Polestar",
			&["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "UI/UI.xml", "Quests/Party.lua", "Quests/VersionCheck.lua"],
		)],
		login: true,
		script: r#"
local keys = {}
Polestar.Widgets.OnOptionsRegistered(function(spec)
	for _, c in ipairs(spec.controls) do
		if c.key and c.key:sub(1, 8) == "version." then keys[#keys + 1] = spec.page .. "/" .. spec.tab .. "/" .. spec.section .. "/" .. c.key end
	end
end)
emit(keys)
emit(Polestar.Get("version.notice"))"#
			.into(),
	});
	assert_eq!(out[0], json!(["Questing/Quests/Group/version.notice"]));
	assert_eq!(out[1], true);
}
