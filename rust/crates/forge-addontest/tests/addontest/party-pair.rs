//! Two Polestar players in one party, each client its own Lua state (forge_addontest::Session) with the fake
//! world and party (tests/lua/stub_party.lua), the test carrying each one's addon messages to the other as
//! Forever's client does: on the party channel, only to clients that registered the prefix, and back to the
//! sender too, under the sender's full name. Forever's characters have a surname: UnitName gives
//! ("Ana", "Smith") and the sender reads "Ana Smith-Realm" ("Ana Smith" once Ambiguate drops this realm).
//! Neither player types or clicks anything: joining a group (or logging in or reloading in one) is enough
//! for sync to start and the party panel to open, and a panel a player closed stays closed (#1018).

use forge_addontest::{lua_string, Addon, RunAddon, Session};
use serde_json::{json, Value};

/// Seconds for a whole sync: a hello 3-6 s after the roster has someone new, the answer (a snapshot asking
/// theirs) 3-6 s after it arrives, and their snapshot 3-6 s after that.
const SYNC: f64 = 20.0;

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "UI/UI.xml", "Quests/QuestDB.lua", "Quests/Party.lua"];

/// UnitName's two returns for a full name: ("Ana", "Smith"), or the name alone.
fn parts(full: &str) -> (String, String) {
	match full.split_once(' ') {
		Some((first, surname)) => (lua_string(first), lua_string(surname)),
		None => (lua_string(full), "nil".into()),
	}
}

/// Lua run before the addon loads: this client's player is `me` ("Ana Smith"), with `log` (quest id ->
/// counts) in the quest log, and `already` the party members it has before logging in (no roster event).
/// `complete`: UnitName("player") gives the name whole ("Ana Smith") and UnitNameUnmodified splits it, as
/// other addons on Forever found; else UnitName splits it too.
fn before(me: &str, log: &str, already: &[&str], complete: bool) -> String {
	let members = already
		.iter()
		.map(|n| {
			let (first, surname) = parts(n);
			format!("{{ name = {first}, surname = {surname}, online = true }}")
		})
		.collect::<Vec<_>>()
		.join(", ");
	let (first, surname) = parts(me);
	let player = if complete { lua_string(me) } else { format!("{first}, {surname}") };
	format!(
		r#"
local base = UnitName
function UnitName(unit) if unit == "player" then return {player} end return base(unit) end
function UnitNameUnmodified(unit) if unit == "player" then return {first}, {surname} end return base(unit) end
for q, counts in pairs({log}) do stub.world.onQuest(q, counts) end
stub.party.members = {{ {members} }}
-- What went out on the party's addon channel since the last call: {{ {{ prefix, text }}, ... }}.
function relayOut()
	relayed = relayed or 0
	local out = {{}}
	for i = relayed + 1, #stub.party.sent do
		local m = stub.party.sent[i]
		if m.chatType == "PARTY" and #stub.party.members > 0 then out[#out + 1] = {{ m.prefix, m.text }} end
	end
	relayed = #stub.party.sent
	emit(out)
end
-- The client hands a message on only for a prefix an addon registered.
function relayIn(sender, prefix, text)
	if stub.party.prefixes[prefix] then stub.party.receive(sender, text, "PARTY", prefix) end
end
function panelShown()
	local f = Polestar.UI.PartyPanel.Frame()
	return f ~= nil and f:IsShown()
end
function seen()
	local out = {{}}
	for _, m in ipairs(Polestar.Party.Members()) do
		local qs = {{}}
		for q, counts in pairs(m.quests) do
			local parts = {{}}
			for i, c in ipairs(counts) do parts[i] = c[1] .. "/" .. c[2] end
			qs[#qs + 1] = q .. ":" .. table.concat(parts, ",")
		end
		table.sort(qs)
		out[#out + 1] = m.name .. " " .. table.concat(qs, ";")
	end
	return out
end"#,
	)
}

/// A client logged in as `me`; `saved` restores its PolestarDB (None: never set anything, as a player who
/// installed 0.3.3 and touched no option).
fn client(me: &str, log: &str, already: &[&str], saved: Option<&str>) -> Session {
	client_with(me, log, already, saved, false)
}

fn client_with(me: &str, log: &str, already: &[&str], saved: Option<&str>, complete: bool) -> Session {
	Session::open(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: before(me, log, already, complete),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		addons: vec![Addon::files("Polestar", FILES)],
		login: true,
		script: String::new(),
	})
	.unwrap_or_else(|e| panic!("{e}"))
}

/// The party: each client with the name its messages arrive under.
struct Pair<'a> {
	clients: Vec<(&'a mut Session, &'static str)>,
}

impl Pair<'_> {
	/// Carries what each client sent to every client (itself included, as the game echoes party messages).
	fn relay(&mut self) {
		let mut mail = Vec::new();
		for (s, name) in self.clients.iter_mut() {
			let out = s.run("relayOut()");
			for m in out[0].as_array().cloned().unwrap_or_default() {
				mail.push((format!("{name}-TestRealm"), m[0].as_str().unwrap().to_string(), m[1].as_str().unwrap().to_string()));
			}
		}
		for (s, _) in self.clients.iter_mut() {
			for (sender, prefix, text) in &mail {
				s.run(&format!("relayIn({}, {}, {})", lua_string(sender), lua_string(prefix), lua_string(text)));
			}
		}
	}

	/// `seconds` of play, in tenths, the messages carried after each.
	fn play(&mut self, seconds: f64) {
		for _ in 0..(seconds * 10.0).round() as usize {
			for (s, _) in self.clients.iter_mut() {
				s.run("stub.advance(0.1)");
			}
			self.relay();
		}
	}
}

fn get(s: &mut Session, expr: &str) -> Value {
	s.run(&format!("emit({expr})")).remove(0)
}

#[test]
fn pair_a_fresh_group_of_two_polestar_players_both_doing_nothing_both_panels_open_and_sync_within_the_join_delay() {
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &[], None);
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &[], None);
	ana.run("stub.party.join('Ben', nil, 'Stone')");
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(1.0);
	drop(pair);
	assert_eq!(get(&mut ana, "panelShown()"), false, "nobody heard yet: no panel");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(6.0);
	drop(pair);
	assert_eq!(get(&mut ana, "panelShown()"), true, "Ana's panel opened by itself on Ben's hello");
	assert_eq!(get(&mut ben, "panelShown()"), true, "Ben's panel opened by itself on Ana's hello");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC - 7.0);
	drop(pair);
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4"]));
	assert_eq!(get(&mut ben, "seen()"), json!(["Ana 33:0/8"]));
	assert_eq!(get(&mut ana, "#Polestar.Party.Roster()"), 1);
}

#[test]
fn pair_a_member_already_in_the_group_at_login_or_reload_gets_synced_without_anyone_doing_anything() {
	// Ben has been in the group with Ana a while; Ana logs in (or reloads) with him already there.
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &[], None);
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &["Ben Stone"], None);
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	// Ben's client heard nothing from Ana's before her login: her addon was not running.
	ben.run("stub.advance(20); relayOut()");
	assert_eq!(get(&mut ben, "panelShown()"), false);
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana, "panelShown()"), true, "after her login");
	assert_eq!(get(&mut ben, "panelShown()"), true);
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4"]));
	assert_eq!(get(&mut ben, "seen()"), json!(["Ana 33:0/8"]));
	// Then Ana reloads: a new client state, the group already there, her settings as saved.
	let mut ana2 = client("Ana Smith", "{ [33] = { 8 } }", &["Ben Stone"], None);
	ben.run("stub.world.progress(60, 1, 2)");
	let mut pair = Pair { clients: vec![(&mut ana2, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana2, "panelShown()"), true, "after her reload");
	assert_eq!(get(&mut ana2, "seen()"), json!(["Ben 60:2/4"]));
}

#[test]
fn pair_both_logging_in_already_grouped_sync_and_open_their_panels() {
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &["Ben Stone"], None);
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &["Ana Smith"], None);
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(json!([get(&mut ana, "panelShown()"), get(&mut ben, "panelShown()")]), json!([true, true]));
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4"]));
	assert_eq!(get(&mut ben, "seen()"), json!(["Ana 33:0/8"]));
}

#[test]
fn pair_a_third_polestar_player_joining_is_heard_by_both_and_hears_both() {
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &[], None);
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &[], None);
	let mut cy = client("Cy Reed", "{ [70] = { 3 } }", &[], None);
	ana.run("stub.party.join('Ben', nil, 'Stone')");
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	ana.run("stub.party.join('Cy', nil, 'Reed')");
	ben.run("stub.party.join('Cy', nil, 'Reed')");
	cy.run("stub.party.join('Ana', nil, 'Smith'); stub.party.join('Ben', nil, 'Stone')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone"), (&mut cy, "Cy Reed")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut cy, "seen()"), json!(["Ana 33:0/8", "Ben 60:0/4"]));
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4", "Cy 70:0/3"]));
	assert_eq!(get(&mut cy, "panelShown()"), true);
}

#[test]
fn pair_a_name_the_client_did_not_have_at_login_still_syncs_once_their_hello_arrives() {
	// At Ana's login the client has Ben in the group but not yet his name ("Unknown"), and no roster event
	// follows when it arrives.
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &["Ana Smith"], None);
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &["Unknown"], None);
	ana.run("stub.party.members[1].name, stub.party.members[1].surname = 'Ben', 'Stone'");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4"]));
	assert_eq!(get(&mut ben, "seen()"), json!(["Ana 33:0/8"]));
	assert_eq!(json!([get(&mut ana, "panelShown()"), get(&mut ben, "panelShown()")]), json!([true, true]));
}

#[test]
fn pair_a_panel_the_player_closed_stays_closed_through_more_messages_and_a_reload_and_comes_back_on_asking() {
	let mut ana = client("Ana Smith", "{ [33] = { 8 } }", &[], None);
	let mut ben = client("Ben Stone", "{ [60] = { 4 } }", &[], None);
	ana.run("stub.party.join('Ben', nil, 'Stone')");
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana, "panelShown()"), true);
	ana.run("Polestar.UI.PartyPanel.Frame().Close:Click()");
	assert_eq!(get(&mut ana, "panelShown()"), false, "closed");
	ben.run("stub.world.progress(60, 1, 3)");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(6.0);
	drop(pair);
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:3/4"]), "sync goes on");
	assert_eq!(get(&mut ana, "panelShown()"), false, "the panel stays closed");
	let saved = format!("PolestarDB = {{ schema = 1, settings = {{ party = {{ panel = {} }} }} }}", get(&mut ana, "Polestar.Get('party.panel')"));
	assert_eq!(saved, "PolestarDB = { schema = 1, settings = { party = { panel = false } } }", "remembered");
	let mut ana2 = client("Ana Smith", "{ [33] = { 8 } }", &["Ben Stone"], Some(&saved));
	let mut pair = Pair { clients: vec![(&mut ana2, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana2, "seen()"), json!(["Ben 60:3/4"]));
	assert_eq!(get(&mut ana2, "panelShown()"), false, "still closed after a reload");
	ana2.run("Polestar.RunCommand('party')");
	assert_eq!(get(&mut ana2, "panelShown()"), true, "/polestar party brings it back");
}

#[test]
fn pair_with_the_player_s_own_name_given_whole_by_unitname_both_still_sync_and_open_their_panels() {
	let mut ana = client_with("Ana Smith", "{ [33] = { 8 } }", &[], None, true);
	let mut ben = client_with("Ben Stone", "{ [60] = { 4 } }", &[], None, true);
	ana.run("stub.party.join('Ben', nil, 'Stone')");
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	assert_eq!(get(&mut ana, "seen()"), json!(["Ben 60:0/4"]));
	assert_eq!(get(&mut ben, "seen()"), json!(["Ana 33:0/8"]));
	assert_eq!(json!([get(&mut ana, "panelShown()"), get(&mut ben, "panelShown()")]), json!([true, true]));
}
