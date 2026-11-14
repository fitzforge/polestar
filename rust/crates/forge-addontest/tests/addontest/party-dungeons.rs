//! Party sync with dungeons in the route (Quests/Party.lua, Core/Engine.lua): two Polestar players in one party
//! on the shipped Barrens guide (horde/02-the-barrens, compiled with the reference data; skipped with a note
//! without it), Ana with "Dungeons in my route" on Run them, Ben on Skip them, each client its own Lua state with
//! the fake world and party (tests/lua/stub_party.lua), the test carrying each one's addon messages to the other
//! (as party-pair.rs). Their dungeon answers travel as "2R|":
//! - "N steps ahead/behind" counts only the steps that apply to both: Wailing Caverns' pick-ups and run, which
//!   apply to Ana alone, never put Ben behind, on either side;
//! - Ana's "Sync to my guide" at the run asks Ben whether he runs it with them (Run it this time / Not now) instead
//!   of moving him onto a step that is not his; Not now changes nothing, Run it this time answers that dungeon only
//!   (Run, "Dungeons in my route" still Skip) and brings him to the door, its quests or not; under the run's floor
//!   he cannot follow;
//! - Ana at the door: Ben is offered once "Your party is running Wailing Caverns: run it with them?"; Run it this
//!   time brings in its pick-ups still ahead of him, then the run; Not now keeps his route and is not asked again;
//!   under the floor there is no offer; and Ana's run never waits on Ben for quests he does not have.

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{lua_string, Addon, RunAddon, Session};
use forge_guide::project::find_guide_files;
use serde_json::{json, Value};

const SYNC: f64 = 20.0;
const GUIDE: &str = "forever/horde/02-the-barrens";

/// The guide's pack, compiled from guides/ with the reference data, as the Lua that loads it; None (and a note)
/// without the data.
fn pack() -> Option<(String, forge_addontest::dsl::TestPack)> {
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	// The whole tree compiled, as it ships (a guide alone misses the guides chaining into it); the Barrens guide packed.
	let dir = root().join("guides");
	let texts: Vec<(String, String)> = find_guide_files(&dir, false).iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, &data, None);
	let guide: Vec<_> = compiled.guides.iter().filter(|g| g.get("id").to_js_string() == GUIDE).cloned().collect();
	assert_eq!(guide.len(), 1, "{GUIDE} compiled");
	let pack = write_test_pack(&guide, &data, &our_manifest());
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	Some((format!("do local ns = {{}}\n{}\nend", lines.join("\n")), pack))
}

// Before the addon: the player (an Orc Warrior of `level` in the Barrens, "Ana Smith" or "Ben Stone"), the quests
// in the log, and the relay helpers of party-pair.rs.
fn before(me: &str, level: u32, log: &str) -> String {
	let (first, surname) = me.split_once(' ').unwrap();
	format!(
		r#"
local base = UnitName
function UnitName(unit) if unit == "player" then return {f}, {s} end return base(unit) end
function UnitNameUnmodified(unit) if unit == "player" then return {f}, {s} end return base(unit) end
local w = stub.world
w.addMap(1413, {{ name = "The Barrens", c = 1, left = 2622.9166, right = -7510.4166, top = 1612.4999, bottom = -5143.75 }})
w.race, w.raceName, w.class, w.className, w.classID, w.faction = "Orc", "Orc", "WARRIOR", "Warrior", 1, "Horde"
w.level = {level}
w.moveTo(1413, 52.0, 30.0)
for q, counts in pairs({log}) do w.onQuest(q, counts) end
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
function relayIn(sender, prefix, text)
	if stub.party.prefixes[prefix] then stub.party.receive(sender, text, "PARTY", prefix) end
end"#,
		f = lua_string(first),
		s = lua_string(surname),
	)
}

// After login: the guide's Wailing Caverns steps (WC.run, WC.picks, WC.all), the live step, and helpers.
const HELPERS: &str = r#"
E, P, G = Polestar.Engine, Polestar.Party, nil
WC = { picks = {}, all = {}, solo = {} }
function scan()
	G = E.GetGuide()
	for i, s in ipairs(G.steps) do
		for _, p in ipairs(s.when or {}) do
			if p.k == "dungeon" and p.map == 43 then
				if p.neg then WC.solo[#WC.solo + 1] = i else WC.all[#WC.all + 1] = i end
				for _, g in ipairs(s.goals) do
					if g.t == "enter" and not p.neg then WC.run = i end
					if g.t == "accept" and not p.neg and WC.picks[#WC.picks] ~= i then WC.picks[#WC.picks + 1] = i end
				end
			end
		end
	end
end
function live() return E.GetLiveStep() end
-- The steps from a to b (a < b) both have, by an oracle of their own: no step another class's or race's (the
-- engine's class and race rule only), none of Wailing Caverns' own (Ben skips it), none of its solo way (Ana runs it).
function sharedBetween(a, b)
	local n, me = 0, { class = "WARRIOR", race = "Orc", faction = "Horde" }
	for s = a, b - 1 do
		local step, dungeon = G.steps[s], false
		for _, p in ipairs(step.when or {}) do if p.k == "dungeon" then dungeon = true end end
		if not dungeon and not E.StepHiddenFor(step, me) then n = n + 1 end
	end
	return n
end
function lastPopup()
	local p = stub.popups[#stub.popups]
	return p and { which = p.which, text = p.args[1] } or false
end
function popupData() local p = stub.popups[#stub.popups]; return p and p.args[3] end
"#;

/// A client logged in as `me` on the Barrens guide with "Dungeons in my route" `route`, its steps before `upto`
/// (Lua, an expression run after the guide's steps are scanned) skipped so the route stands there.
fn client(loads: &str, me: &str, level: u32, log: &str, route: &str, upto: &str) -> Session {
	let saved = format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ dungeons = {} }} }} }}", lua_string(route));
	let script = format!(
		r#"{loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.Engine.SetGuide({gid})
stub.advance(1)
{HELPERS}
scan()
-- The route played up to step `upto`: the quests its steps before it hand in done, the ones they take and leave
-- in the log, each step before it passed (its dungeon's steps only for a character who runs it, its solo way only
-- for one who skips it).
local upto, runs = {upto}, {runs}
local done, taken, me = {{}}, {{}}, {{ class = "WARRIOR", race = "Orc", faction = "Horde" }}
for s = 1, upto - 1 do
	local step, dungeon, solo = G.steps[s], false, false
	for _, p in ipairs(step.when or {{}}) do
		if p.k == "dungeon" then if p.neg then solo = true else dungeon = true end end
	end
	if not E.StepHiddenFor(step, me) and (runs or not dungeon) and not (runs and solo) then
		for _, g in ipairs(step.goals) do
			if g.quest and g.t == "accept" then taken[g.quest] = true elseif g.quest and g.t == "turnin" then done[g.quest] = true end
		end
	end
end
local list = {{}}
for q in pairs(done) do list[#list + 1] = q; taken[q] = nil end
stub.world.complete(list)
for q in pairs(taken) do if not stub.world.log[q] then stub.world.onQuest(q, {{}}) end end
local sk = Polestar.CharState().skipped
sk[G.id] = sk[G.id] or {{}}
for s = 1, upto - 1 do sk[G.id][s] = true end
stub.fire("QUEST_LOG_UPDATE")
Polestar.Engine.SetGuide({gid})
stub.advance(1)"#,
		gid = lua_string(GUIDE),
		runs = route == "run"
	);
	Session::open(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: before(me, level, log),
		saved: vec![("Polestar".to_string(), saved)],
		addons: vec![Addon::name("Polestar")],
		login: false,
		script,
	})
	.unwrap_or_else(|e| panic!("{e}"))
}

struct Pair<'a> {
	clients: Vec<(&'a mut Session, &'static str)>,
}

impl Pair<'_> {
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

// Ana carries Wailing Caverns' quests (Nalpak's, Ebru's, Mebok's, Bigglefuzz's) and stands at its run.
const ANA_LOG: &str = "{ [1486] = { 20 }, [1487] = { 1 }, [1491] = { 6 }, [959] = { 1 } }";

/// Ana at the run, Ben `before` steps of the guide before Nalpak and Ebru's pick-up (a solo step), grouped and
/// synced; `ben_level` his level.
fn grouped(loads: &str, ben_level: u32, before: u32) -> (Session, Session) {
	let mut ana = client(loads, "Ana Smith", 22, ANA_LOG, "run", "WC.run");
	let mut ben = client(loads, "Ben Stone", ben_level, "{}", "skip", &format!("WC.picks[#WC.picks] - {before}"));
	ana.run("stub.party.join('Ben', nil, 'Stone')");
	ben.run("stub.party.join('Ana', nil, 'Smith')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(SYNC);
	drop(pair);
	(ana, ben)
}

#[test]
fn party_dungeons_steps_ahead_count_only_the_steps_both_have_on_either_side() {
	let Some((loads, _pack)) = pack() else { return };
	let (mut ana, mut ben) = grouped(&loads, 22, 6);
	let (a, b) = (get(&mut ana, "live()"), get(&mut ben, "live()"));
	assert_eq!(a, get(&mut ana, "WC.run"), "Ana stands at Wailing Caverns' run");
	assert!(b.as_i64() < a.as_i64(), "Ben is before it: {b} {a}");
	let n = get(&mut ben, &format!("sharedBetween({b}, {a})")).as_i64().unwrap();
	let raw = a.as_i64().unwrap() - b.as_i64().unwrap();
	assert!(n < raw, "Wailing Caverns' steps lie between ({n} shared of {raw})");
	assert_eq!(get(&mut ben, "(Polestar.Party.StepLine())"), json!(format!("Ana: {n} steps ahead")), "Ben's line");
	assert_eq!(get(&mut ana, "(Polestar.Party.StepLine())"), json!(format!("Ben: {n} steps behind")), "Ana's line: Ben's \"2R|\" says he skips it");
}

#[test]
fn party_dungeons_sync_at_the_run_asks_ben_to_run_it_with_them_not_now_changes_nothing() {
	let Some((loads, _pack)) = pack() else { return };
	let (mut ana, mut ben) = grouped(&loads, 22, 6);
	let before = get(&mut ben, "live()");
	ana.run("Polestar.Party.RequestSync()");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(1.0);
	drop(pair);
	let popup = get(&mut ben, "lastPopup()");
	assert_eq!(popup["which"], "POLESTAR_PARTY_DUNGEON", "the dungeon's prompt, not the plain sync");
	assert!(popup["text"].as_str().unwrap().contains("Your party is running Wailing Caverns: run it with them?"), "{popup}");
	assert_eq!(get(&mut ben, "{ StaticPopupDialogs.POLESTAR_PARTY_DUNGEON.button1, StaticPopupDialogs.POLESTAR_PARTY_DUNGEON.button2 }"), json!(["Run it this time", "Not now"]));
	assert_eq!(get(&mut ben, "live()"), before, "nothing moves before the answer");
	ben.run("StaticPopupDialogs.POLESTAR_PARTY_DUNGEON.OnCancel(nil, popupData(), 'clicked')");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(1.0);
	drop(pair);
	assert_eq!(
		get(&mut ben, "{ live(), Polestar.CharState().dungeons[43] == nil, Polestar.Get('behavior.dungeons'), P.DungeonOffer() or false }"),
		json!([before, true, "skip", false]),
		"Not now: his route, his answers, and no offer again this session"
	);
	let said = get(&mut ana, "stub.messages");
	assert!(said.as_array().unwrap().iter().any(|m| m.as_str().unwrap_or("").contains("Ben declined to sync")), "{said}");
}

#[test]
fn party_dungeons_sync_at_the_run_run_it_this_time_answers_that_dungeon_only_and_brings_ben_to_the_door() {
	let Some((loads, _pack)) = pack() else { return };
	let (mut ana, mut ben) = grouped(&loads, 22, 6);
	ana.run("Polestar.Party.RequestSync()");
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(1.0);
	drop(pair);
	ben.run("StaticPopupDialogs.POLESTAR_PARTY_DUNGEON.OnAccept(nil, popupData())");
	ben.run("stub.advance(1)");
	assert_eq!(
		get(&mut ben, "{ live() == WC.run, Polestar.CharState().dungeons[43], Polestar.Get('behavior.dungeons'), E.GetStepView(live()).status }"),
		json!([true, true, "skip", "current"]),
		"at the door with them, Wailing Caverns alone set to Run, though he holds none of its quests"
	);
	let mut pair = Pair { clients: vec![(&mut ana, "Ana Smith"), (&mut ben, "Ben Stone")] };
	pair.play(3.0);
	drop(pair);
	let said = get(&mut ana, "stub.messages");
	assert!(said.as_array().unwrap().iter().any(|m| m.as_str().unwrap_or("").contains("Ben synced to your guide")), "{said}");
	assert_eq!(get(&mut ana, "(Polestar.Party.StepLine())"), json!("Ben: on this step"));
}

#[test]
fn party_dungeons_ana_at_the_door_ben_is_offered_once_run_it_this_time_brings_in_its_pick_ups() {
	let Some((loads, _pack)) = pack() else { return };
	let (mut ana, mut ben) = grouped(&loads, 22, 6);
	let offer = get(&mut ben, "P.DungeonOffer() or false");
	assert_eq!(offer, json!({ "map": 43, "name": "Wailing Caverns", "names": ["Ana"] }));
	ben.run("Polestar.UI.GuideFrame.Layout()");
	let banner = get(&mut ben, "{ Polestar.UI.GuideFrame.parts.banner.psKind, Polestar.UI.GuideFrame.parts.banner.Text:GetText(), Polestar.UI.GuideFrame.parts.banner.Jump.Label:GetText(), Polestar.UI.GuideFrame.parts.banner.Later.Label:GetText() }");
	assert_eq!(banner, json!(["partyDungeon", "Your party is running Wailing Caverns: run it with them?\nNot now keeps your route as it is.", "Run it this time", "Not now"]));
	let before = get(&mut ben, "live()");
	ben.run("Polestar.UI.GuideFrame.parts.banner.Jump:Click(); stub.advance(1)");
	assert_eq!(get(&mut ben, "{ Polestar.CharState().dungeons[43], Polestar.Get('behavior.dungeons'), P.DungeonOffer() or false }"), json!([true, "skip", false]));
	// His route now takes the pick-ups still ahead of him, then the run; nothing behind him comes back.
	let after = get(&mut ben, "live()");
	assert!(after.as_i64() >= before.as_i64(), "never back: {before} -> {after}");
	let pick = get(&mut ben, "{ WC.picks[#WC.picks] >= live(), E.GetStepView(WC.picks[#WC.picks]).status }");
	assert_eq!(pick[0], true, "Nalpak and Ebru's pick-up is still ahead of him");
	assert!(pick[1] != "na" && pick[1] != "skipped", "and now applies: {pick}");
	// Ana's run never waits on Ben for quests he does not have.
	assert_eq!(get(&mut ana, "(function() local names = P.StepWait() return names and #names or 0 end)()"), json!(0));
}

#[test]
fn party_dungeons_not_now_keeps_the_route_and_under_the_floor_there_is_no_offer_and_no_sync() {
	let Some((loads, _pack)) = pack() else { return };
	let (_ana, mut ben) = grouped(&loads, 22, 6);
	let before = get(&mut ben, "live()");
	ben.run("Polestar.UI.GuideFrame.Layout(); Polestar.UI.GuideFrame.parts.banner.Later:Click(); stub.advance(1)");
	assert_eq!(get(&mut ben, "{ live(), Polestar.CharState().dungeons[43] == nil, P.DungeonOffer() or false }"), json!([before, true, false]), "Not now: once a session");
	// Under the run's floor (its own level gate, as the route's floors are written): no offer, and a sync onto it is
	// one he cannot follow.
	let (mut ana2, mut low) = grouped(&loads, 14, 6);
	low.run("table.insert(G.steps[WC.run].when, { k = 'level', op = '>=', n = 20 }); stub.advance(0.5)");
	assert_eq!(get(&mut low, "P.DungeonOffer() or false"), json!(false));
	ana2.run("Polestar.Party.RequestSync()");
	let mut pair = Pair { clients: vec![(&mut ana2, "Ana Smith"), (&mut low, "Ben Stone")] };
	pair.play(1.0);
	drop(pair);
	assert_eq!(get(&mut low, "lastPopup()"), json!(false), "no prompt");
	let said = get(&mut low, "stub.messages");
	assert!(said.as_array().unwrap().iter().any(|m| m.as_str().unwrap_or("").contains("is below its level")), "{said}");
	let heard = get(&mut ana2, "stub.messages");
	assert!(heard.as_array().unwrap().iter().any(|m| m.as_str().unwrap_or("").contains("Ben can't sync")), "{heard}");
}

#[test]
fn party_dungeons_the_answers_message_round_trips_and_older_decoders_drop_it() {
	let out = forge_addontest::emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		addons: vec![Addon::name("Polestar")],
		script: r#"
local P = Polestar.Party
local text = P.EncodeRoute({ all = "skip", maps = { [43] = true, [36] = false } })
emit(text)
emit(P.DecodeRoute(text))
local later = P.DecodeRoute("2R|r||later")
emit({ later.all, next(later.maps) == nil })
emit({ P.DecodeRoute("2R|x|") == nil, P.DecodeRoute("2R|s|43:1x") == nil, P.DecodeRoute("1R|s|") == nil })
emit({ P.Decode(text) == nil, P.DecodePos(text) == nil, P.DecodeUnit(text) == nil, P.DecodeAt(text) == nil, P.DecodeDone(text) == nil, P.DecodeRest(text) == nil, P.DecodeAnswer(text) == nil, P.DecodeHello(text) == nil })
stub.login()
Polestar.Set("behavior.dungeons", "ask")
Polestar.Engine.ChooseDungeon(43, true)
emit(P.EncodeRoute(P.MyRoute()))"#
			.into(),
		..Default::default()
	});
	assert_eq!(out[0], "2R|s|36:0,43:1");
	assert_eq!(out[1], json!({ "all": "skip", "maps": { "36": false, "43": true } }));
	assert_eq!(out[2], json!(["run", true]), "a later version's fields ignored");
	assert_eq!(out[3], json!([true, true, true]));
	assert_eq!(out[4], json!([true, true, true, true, true, true, true, true]), "every other decoder (what older Polestar runs) drops it");
	assert_eq!(out[5], "2R|a|43:1");
}

// The same rules on a route of its own, with no reference data (they run everywhere): engine-dungeon-route.rs's
// route, the Deadmines' pick-up (1), two solo steps (2, 3), the run's own stop (4), the run (5), its hand-in (6), a
// solo hand-in (7). The player is Ben; Ana is a party member heard on the party channel (stub_party.lua).
const ROUTE: &str = r#"
local DM = { k = "dungeon", name = "The Deadmines", map = 36 }
Polestar.RegisterGuide({
	id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Scout Riell", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Echo Ridge", goals = {
			{ t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, npcName = "Marshal McBride", map = 1429, x = 47.5, y = 40.0 },
		} },
		{ title = "Sentinel Hill", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
			{ t = "accept", quest = 167, title = "Oh Brother. . .", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "The Deadmines", when = { DM, { k = "onquest", q = { 214, 167 } } }, goals = {
			{ t = "enter", location = "The Deadmines", map = 1429, x = 42.0, y = 70.0 },
			{ t = "complete", quest = 214, title = "Red Silk Bandanas" },
		} },
		{ title = "Scout Riell", when = { DM, { k = "complete", q = 214 } }, goals = {
			{ t = "turnin", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})"#;

const ROUTE_WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(10)"#;

// Logged in on the route with Ana in the party (heard running Polestar); `ana(step, route)`: her place ("1P|",
// "2P|") and, when given, her dungeon answers ("2R|"); `take(q)` accepts quest q.
const ROUTE_SETUP: &str = r#"
stub.login()
stub.fire("QUEST_LOG_UPDATE") -- the client fills the quest log right after login
E, P, p, w = Polestar.Engine, Polestar.Party, stub.party, stub.world
E.SetGuide("test/route")
stub.advance(0.6)
G = E.GetGuide()
p.join("Ana")
p.set("Ana", { class = "WARRIOR", classID = 1, race = "Human", raceID = 1 })
stub.advance(1)
p.receive("Ana-TestRealm", "1Y|0.4.0")
stub.advance(1)
function ana(step, route)
	p.receive("Ana-TestRealm", "1P|" .. step .. "|0.4.0|test|1|test/route")
	p.receive("Ana-TestRealm", "2P|" .. P.StepKey(G, step) .. "|test/route")
	if route then p.receive("Ana-TestRealm", route) end
	stub.advance(1)
end
function take(q) w.accept(q, { 1 }); stub.advance(0.6) end
function live() return E.GetLiveStep() end
function answers()
	local out = {}
	for _, s in ipairs(p.sent) do if s.text:match("^2A|") then out[#out + 1] = s.text end end
	return out
end"#;

fn route(dungeons: &str, script: &str) -> Vec<Value> {
	forge_addontest::emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_party.lua"],
		before: ROUTE_WORLD.into(),
		saved: vec![("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ dungeons = {} }} }} }}", lua_string(dungeons)))],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Maps/Maps.lua", "UI/UI.xml", "Quests/QuestDB.lua", "Quests/Party.lua"])],
		script: format!("{}\n{ROUTE}\n{ROUTE_SETUP}\n{script}", forge_addontest::TEST_PACK),
		..Default::default()
	})
}

#[test]
fn party_dungeons_on_a_route_of_its_own_the_steps_ahead_leave_out_the_dungeon_steps_one_of_you_skips() {
	// Ben skips the Deadmines (at step 2); Ana runs it (at the run, 5): steps 2 and 3 are both of theirs, 4 Ana's alone.
	let ben_skips = route("skip", r#"ana(5, "2R|r|"); emit({ live(), (P.StepLine()) })"#);
	assert_eq!(ben_skips[0], json!([2, "Ana: 2 steps ahead"]));
	// Ben runs it (at the run, every quest taken); Ana skips it (at 2): her "2R|" leaves step 4 out for her too. An
	// older client sends none, and then step 4 counts, as before.
	let ben_runs = route(
		"run",
		r#"take(214); take(7); take(15); take(167)
		ana(2, "2R|s|"); emit({ live(), (P.StepLine()) })"#,
	);
	assert_eq!(ben_runs[0], json!([5, "Ana: 2 steps behind"]));
	let older = route(
		"run",
		r#"take(214); take(7); take(15); take(167)
		ana(2); emit({ live(), (P.StepLine()) })"#,
	);
	assert_eq!(older[0], json!([5, "Ana: 3 steps behind"]), "without her answers, her steps are counted as before");
}

#[test]
fn party_dungeons_on_a_route_of_its_own_ana_at_the_run_offers_ben_to_run_it_with_them_once() {
	let out = route(
		"skip",
		r#"ana(5, "2R|r|")
		local offer = P.DungeonOffer()
		P.AnswerDungeonOffer(36, true); stub.advance(0.6)
		emit({ offer = offer, answer = Polestar.CharState().dungeons[36], all = Polestar.Get("behavior.dungeons"),
			live = live(), s4 = E.GetStepView(4).status, again = P.DungeonOffer() or false })"#,
	);
	assert_eq!(out[0]["offer"], json!({ "map": 36, "name": "The Deadmines", "names": ["Ana"] }));
	assert_eq!(out[0]["answer"], true, "Run it this time: this dungeon only");
	assert_eq!(out[0]["all"], "skip", "Dungeons in my route stays");
	assert_eq!(out[0]["live"], 2, "nothing moves back or jumps");
	assert_eq!(out[0]["s4"], "upcoming", "its pick-ups still ahead come with it");
	assert_eq!(out[0]["again"], false, "once a session");
	// Not now: the route stays, and it is not offered again.
	let not_now = route(
		"skip",
		r#"ana(5, "2R|r|"); P.AnswerDungeonOffer(36, false); stub.advance(0.6)
		emit({ Polestar.CharState().dungeons[36] == nil, live(), E.GetStepView(4).status, P.DungeonOffer() or false })"#,
	);
	assert_eq!(not_now[0], json!([true, 2, "na", false]), "its pick-ups ahead stay out of the route");
	// No offer when Ana does not run it, or when Ben is under the run's floor (its level gate).
	let skips = route("skip", r#"ana(5, "2R|s|"); emit(P.DungeonOffer() or false)"#);
	assert_eq!(skips[0], false);
	let low = route("skip", r#"table.insert(G.steps[5].when, { k = "level", op = ">=", n = 20 }); ana(5, "2R|r|"); emit(P.DungeonOffer() or false)"#);
	assert_eq!(low[0], false, "under the floor: no offer");
}

#[test]
fn party_dungeons_on_a_route_of_its_own_a_sync_onto_the_run_asks_and_run_it_this_time_takes_ben_to_the_door() {
	let accept = route(
		"skip",
		r#"ana(5, "2R|r|")
		p.receive("Ana-TestRealm", "2G|" .. P.StepKey(G, 5) .. "|test/route"); stub.advance(0.5)
		local pop = stub.popups[#stub.popups]
		local before = live()
		StaticPopupDialogs[pop.which].OnAccept(nil, pop.args[3]); stub.advance(0.6)
		emit({ which = pop.which, before = before, live = live(), s5 = E.GetStepView(5).status, answer = Polestar.CharState().dungeons[36], sent = answers() })"#,
	);
	assert_eq!(accept[0]["which"], "POLESTAR_PARTY_DUNGEON");
	assert_eq!(accept[0]["before"], 2);
	assert_eq!(accept[0]["live"], 5, "at the door with Ana, without its quests");
	assert_eq!(accept[0]["s5"], "current");
	assert_eq!(accept[0]["answer"], true);
	assert_eq!(accept[0]["sent"], json!(["2A|y"]));
	let decline = route(
		"skip",
		r#"ana(5, "2R|r|")
		p.receive("Ana-TestRealm", "2G|" .. P.StepKey(G, 5) .. "|test/route"); stub.advance(0.5)
		local pop = stub.popups[#stub.popups]
		StaticPopupDialogs[pop.which].OnCancel(nil, pop.args[3], "clicked"); stub.advance(0.6)
		emit({ live = live(), answer = Polestar.CharState().dungeons[36] == nil, sent = answers() })"#,
	);
	assert_eq!(decline[0], json!({ "live": 2, "answer": true, "sent": ["2A|n"] }));
	// Under the floor: no prompt, "cannot".
	let low = route(
		"skip",
		r#"table.insert(G.steps[5].when, { k = "level", op = ">=", n = 20 }); ana(5, "2R|r|")
		p.receive("Ana-TestRealm", "2G|" .. P.StepKey(G, 5) .. "|test/route"); stub.advance(0.5)
		emit({ popups = #stub.popups, live = live(), sent = answers() })"#,
	);
	assert_eq!(low[0], json!({ "popups": 0, "live": 2, "sent": ["2A|x"] }));
}
