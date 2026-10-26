//! Transport timing (addon/Polestar/Nav/Transit.lua) and its generator (tools/lib/travel/timetable.js,
//! cmangos.js), after Shortest Path Forever by Cillian Berragan: departure maths (phase, wrap, boarding),
//! untimed average waits, sightings and the ride observer correcting a drifted one, the guild/group sync's
//! validation, class teleports, lifts; the generator's transport model, expected waits, lift tracks, portals
//! and teleports, and a deterministic `travel build`. Ids in test names cite docs/NAV_QA.md.

use forge_addontest::run::root;
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use regex::Regex;
use serde_json::{json, Value};
use std::fs;
use std::path::{Path, PathBuf};

// --- the addon ---------------------------------------------------------------

fn transit() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Nav/Transit.lua"])
}

// A boat loop of 100 s: docked at A 0-20 s, at B 50-70 s; and a lift.
const DATA: &str = r#"
local T = Polestar.Transit
T.Register({
	routes = {
		r = { kind = "boat", period = 100000, fit = { samples = 10, span = 15000, speed = 12 },
			stops = { { 0, 20000, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0 } },
			frames = { { 0, 20000, 0, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0, 0 }, { 100000, 100000, 0, 0, 0, 1 } } },
		lift = { kind = "lift", period = 30000, fit = { samples = 5, span = 4000, speed = 8 },
			stops = { { 0, 5000, 0, 500, 500, 100 }, { 15000, 20000, 0, 500, 500, 0 } },
			frames = { { 0, 5000, 0, 500, 500, 0, 100 }, { 15000, 20000, 0, 500, 500, 0, 0 }, { 30000, 30000, 0, 500, 500, 1, 100 } } },
	},
	services = {
		["boat-x"] = { kind = "boat", name = "A - B", ends = { "A", "B" }, board = 10, pre = 0, post = 0,
			wait = { a = 60, b = 60 }, ride = { a = 30, b = 30 }, routes = { { route = "r", a = { 1 }, b = { 2 } } } },
		["lift-x"] = { kind = "lift", name = "The Test Lift", c = 0, wx = 500, wy = 500, top = 100, bottom = 0, board = 2, pre = 0, post = 0,
			wait = { a = 17, b = 17 }, ride = { a = 10, b = 10 }, routes = { { route = "lift", a = { 1 }, b = { 2 } } } },
	},
	teleports = {
		{ spell = 3567, name = "Teleport: Orgrimmar", cast = 10, reagents = { 17031, 1 }, to = { "Orgrimmar", 1, 1469.9, -4221.5, 1454, 38.57, 85.95, "e" } },
		{ spell = 18960, name = "Teleport: Moonglade", cast = 10, to = { "Moonglade", 1, 7991.9, -2679.8, 1450, 56.26, 32.46, "e" } },
		{ spell = 556, name = "Astral Recall", cast = 10, bind = true },
	},
})
local function nowMs() return T.Now() * 1000 end
-- A sighting putting the loop at phase p (ms) now.
local function at(p, source) return { epoch = nowMs() - p, seen = math.floor(T.Now()), source = source or "you" } end
local function round(v) return v and math.floor(v * 10 + 0.5) / 10 end
-- The sighting held for a route (the store is per realm; there is one here).
local function held(id) for _, s in pairs(Polestar.DB().transit or {}) do return s[id] end end
"#;

fn lua_with(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon { addons: vec![transit()], login: true, before: before.into(), script: format!("{DATA}{script}"), ..Default::default() })
}

fn lua(script: &str) -> Vec<Value> {
	lua_with(script, "")
}

#[test]
fn c9_an_untimed_loop_costs_its_expected_wait_and_is_captioned_as_an_average_never_no_sighting_yet() {
	let out = lua(r#"
		local w, r, timed = T.NextDeparture("boat", "boat-x", T.Now(), "a")
		emit({ w, r, timed })
		emit(T.Caption("boat", "boat-x", T.Now(), "a"))
		emit(T.NextArrival("boat", "boat-x", T.Now(), "a") == nil)
		emit(T.NextDeparture("boat", "nope", T.Now(), "a") == nil)
	"#);
	assert_eq!(out[0], json!([60, 30, false]));
	assert_eq!(out[1], "Boat: average wait 1:00");
	assert_eq!(out[2], true, "no countdown to an arrival nobody has timed");
	assert_eq!(out[3], true);
}

#[test]
fn c9_an_untimed_average_wait_is_not_worded_as_a_countdown_since_it_stays_the_same_as_time_passes_364() {
	let out = lua(r#"
		local c, w = {}, {}
		for i = 1, 3 do
			if i > 1 then stub.advance(60) end
			c[#c + 1] = T.Caption("boat", "boat-x", T.Now(), "a")
			w[#w + 1] = (T.NextDeparture("boat", "boat-x", T.Now(), "a"))
		end
		emit(c)
		emit(w)
	"#);
	let captions = &out[0];
	let waits = &out[1];
	assert_eq!(*waits, json!([60, 60, 60]), "the expected wait does not move");
	assert_eq!(*captions, json!(["Boat: average wait 1:00", "Boat: average wait 1:00", "Boat: average wait 1:00"]));
	for c in captions.as_array().unwrap() {
		assert!(!is_match(text(c), r"Next boat in|leaves in"));
	}
}

#[test]
fn departure_maths_docked_too_late_to_board_arriving_wrapping_past_phase_zero() {
	let out = lua(r#"
		local function case(p, side)
			T.ForgetSightings()
			T.Sighted("r", at(p))
			local w, r, timed = T.NextDeparture("boat", "boat-x", T.Now(), side or "a")
			return { round(w), round(r), timed, T.Caption("boat", "boat-x", T.Now(), side or "a") }
		end
		emit(case(10000))   -- docked at A, leaves in 10 s: just boardable
		emit(case(15000))   -- docked, leaves in 5 s < 10 s to board: the next visit
		emit(case(40000))   -- at sea: A again in 60 s
		emit(case(95000))   -- wraps: docks at A in 5 s
		emit(case(60000, "b")) -- docked at B, leaves in 10 s, back at A 30 s later
		-- the transport entry itself works as the id
		emit(round(T.NextDeparture("boat", { id = "boat-x" }, T.Now(), "b")))
	"#);
	assert_eq!(out[0], json!([10, 30, true, "Boat docked, leaves in 0:10"]));
	assert_eq!(out[1], json!([105, 30, true, "Boat docked, leaves in 0:05"]), "the caption still says when this one leaves");
	assert_eq!(out[2], json!([80, 30, true, "Next boat in 1:00"]));
	assert_eq!(out[3], json!([25, 30, true, "Next boat in 0:05"]));
	assert_eq!(out[4], json!([10, 30, true, "Boat docked, leaves in 0:10"]));
	assert_eq!(out[5], 10);
}

#[test]
fn sightings_a_recent_own_ride_is_not_replaced_by_another_player_s_a_newer_own_one_is_stale_ones_expire() {
	let out = lua(r#"
		local s = Polestar.DB().transit
		T.Sighted("r", { epoch = nowMs() - 1000, seen = math.floor(T.Now()) - 100, source = "player" })
		emit(T.Sighted("r", at(10000, "you")))
		emit(T.Sighted("r", { epoch = nowMs() - 30000, seen = math.floor(T.Now()) + 1, source = "player" }))
		emit({ T.Sighted("r", { epoch = nowMs() - 20000, seen = math.floor(T.Now()) + 2, source = "you" }), round(T.NextDeparture("boat", "boat-x", T.Now(), "a")) })
		stub.advance(6 * 3600 + 5)
		emit({ select(3, T.NextDeparture("boat", "boat-x", T.Now(), "a")) })
	"#);
	assert_eq!(out[0], true);
	assert_eq!(out[1], false, "another player's sighting does not replace your ride of the last hour");
	assert_eq!(out[2], json!([true, 100]));
	assert_eq!(out[3], json!([false]), "six hours on, the loop is untimed again (a restart resets it)");
}

#[test]
fn the_ride_observer_times_a_loop_from_the_positions_along_it_and_corrects_a_drifted_sighting_c5_unreadable_positions_are_skipped() {
	let out = lua(r#"
		-- The boat really is at phase 25 s now; a guildmate's sighting says 45 s.
		TRUE_EPOCH = nowMs() - 25000
		T.Sighted("r", { epoch = nowMs() - 45000, seen = math.floor(T.Now()), source = "player" })
		emit(round(T.NextDeparture("boat", "boat-x", T.Now(), "b")))
		SECRET = false
		function UnitPosition(unit)
			if SECRET then return "secret", "secret", 0, 0 end
			local p = (nowMs() - TRUE_EPOCH) % 100000
			if p < 20000 then return 0, 0, 0, 0 end -- docked at A
			if p > 50000 and p < 70000 then return 3000, 0, 0, 0 end -- docked at B
			if p > 50000 then return 3000 * (100000 - p) / 30000, 0, 0, 0 end -- sailing back
			return 3000 * (p - 20000) / 30000, 0, 0, 0
		end
		issecretvalue = function(v) return v == "secret" end
		stub.advance(25) -- riding from phase 25 s to 50 s
		emit(round(T.NextDeparture("boat", "boat-x", T.Now(), "b")))
		local held = held("r")
		-- epochs are kept modulo the loop
		local off = (held.epoch - TRUE_EPOCH) % 100000
		emit(math.min(off, 100000 - off) < 1500)
		emit(held.source)
		local said = false
		for _, m in ipairs(stub.messages) do if m:find("Timed the A %- B from your ride", 1) then said = true end end
		emit(said)
		SECRET = true
		stub.advance(3)
		emit(true)
	"#);
	assert_eq!(out[0], 25, "the drifted sighting thinks the boat docks at B in 5 s and leaves 25 s from now");
	// True phase 50 s after the ride: docked at B until 70 s, leaves in 20 s.
	assert_eq!(out[1], 20);
	assert_eq!(out[2], true);
	assert_eq!(out[3], "you");
	assert_eq!(out[4], true);
	assert_eq!(out[5], true);
}

// Forever's client gives UnitPosition a height of exactly 0 (Core/Compat.lua reads it as no height). Taken as
// real, a ride on a track up in the air (a zeppelin at 120 yd) was 120 yd off its track and never timed.
#[test]
fn c5_a_ride_is_timed_when_the_client_reports_its_height_as_0_along_a_track_up_in_the_air() {
	let out = emitted(&RunAddon {
		addons: vec![transit()],
		login: true,
		script: r#"
			local T = Polestar.Transit
			T.Register({
				routes = {
					zep = { kind = "zeppelin", period = 100000, fit = { samples = 10, span = 15000, speed = 12 },
						stops = { { 0, 20000, 0, 0, 0 }, { 50000, 70000, 0, 3000, 0 } },
						frames = { { 0, 20000, 0, 0, 0, 0, 120 }, { 50000, 70000, 0, 3000, 0, 0, 120 }, { 100000, 100000, 0, 0, 0, 1, 120 } } },
				},
				services = {
					["zep-x"] = { kind = "zeppelin", name = "A - B", ends = { "A", "B" }, board = 10, pre = 0, post = 0,
						wait = { a = 60, b = 60 }, ride = { a = 30, b = 30 }, routes = { { route = "zep", a = { 1 }, b = { 2 } } } },
				},
			})
			local function nowMs() return T.Now() * 1000 end
			local EPOCH = nowMs() - 25000
			function UnitPosition()
				local p = (nowMs() - EPOCH) % 100000
				return 3000 * math.min(1, math.max(0, (p - 20000) / 30000)), 0, 0, 0
			end
			stub.advance(25)
			local s
			for _, realm in pairs(Polestar.DB().transit or {}) do s = realm.zep end
			emit(s and s.source or false)
		"#
		.into(),
		..Default::default()
	});
	assert_eq!(out[0], "you", "timed from the ride, matched on the ground plane");
}

#[test]
fn lifts_found_near_a_crossing_listed_untimed_average_captions_then_timed_either_landing_when_the_side_is_unknown_k3() {
	let out = lua(r#"
		emit({ T.LiftNear(0, 510, 495) })
		emit(T.LiftNear(0, 900, 900) == nil)
		emit(T.Lifts())
		emit(T.Caption("lift", "lift-x", T.Now(), "top"))
		T.Sighted("lift", at(16000))
		emit({ T.Caption("lift", "lift-x", T.Now(), "top"), T.Caption("lift", "lift-x", T.Now(), "bottom") })
		emit(round(T.NextDeparture("lift", "lift-x", T.Now(), nil)))
	"#);
	assert_eq!(out[0], json!(["lift-x", "The Test Lift"]));
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!([{ "id": "lift-x", "name": "The Test Lift", "c": 0, "wx": 500, "wy": 500, "top": 100, "bottom": 0 }]));
	assert_eq!(out[3], "Lift: average wait 0:17");
	assert_eq!(out[4], json!(["Next lift in 0:14", "Lift here, leaves in 0:04"]));
	assert_eq!(out[5], 4, "no side: the landing it leaves first");
}

#[test]
fn sync_shared_sightings_are_validated_unknown_future_stale_out_of_loop_dropped_a_whisper_is_ignored_a_guild_query_gets_your_own() {
	let out = lua_with(
		r#"
		Polestar.Set("nav.shareTransit", true) -- off by default: players opt in
		local now = T.Now()
		local s = { epoch = nowMs() - 12345, seen = math.floor(now) }
		local text = T.encode("r", s)
		local back = T.decode(text, now).r
		emit({ text, back.epoch == s.epoch })
		local msg = table.concat({
			"r:" .. math.floor(now) .. ":1000",
			"ghost:" .. math.floor(now) .. ":1000",
			"lift:" .. (math.floor(now) + 60) .. ":1000",
			"lift:" .. (math.floor(now) - 7 * 3600) .. ":1000",
			"r:" .. math.floor(now) .. ":100000",
		}, ";")
		local got = {}
		for id in pairs(T.decode(msg, now)) do got[#got + 1] = id end
		emit(got)
		stub.fire("CHAT_MSG_ADDON", "PolestarT1", "Slift:" .. math.floor(now) .. ":16000", "WHISPER", "Stranger-Realm")
		emit(held("lift") == nil)
		stub.fire("CHAT_MSG_ADDON", "PolestarT1", "Slift:" .. math.floor(now) .. ":16000", "GUILD", "Friend")
		local held = held("lift")
		emit({ held.source, T.Caption("lift", "lift-x", T.Now(), "bottom") })
		T.Sighted("r", at(10000, "you"))
		stub.fire("CHAT_MSG_ADDON", "PolestarT1", "Q", "GUILD", "Friend")
		local before = #SENT
		stub.advance(13) -- the reply waits 2-12 s
		local last = SENT[#SENT]
		emit({ last[1], last[2], last[3], before })
	"#,
		"SENT = {}; C_ChatInfo = { RegisterAddonMessagePrefix = function() return true end, SendAddonMessage = function(...) SENT[#SENT + 1] = { ... } end }",
	);
	let round1 = &out[0];
	let reply = &out[4];
	assert!(is_match(text(&round1[0]), r"^r:\d+:12345$"));
	assert_eq!(round1[1], true);
	assert_eq!(out[1], json!(["r"]));
	assert_eq!(out[2], true);
	assert_eq!(out[3], json!(["player", "Lift here, leaves in 0:04"]));
	assert_eq!(json!([reply[0], reply[2]]), json!(["PolestarT1", "GUILD"]));
	assert_eq!(reply[3], 0, "security L4: no reply at once");
	assert!(is_match(text(&reply[1]), r"^Sr:\d+:10000$"), "only your own sightings answer a query; the guildmate's lift is not echoed");
}

#[test]
fn class_teleports_known_spells_with_their_reagents_cooldowns_counted_the_setting_turns_them_off_11_still_offered_after_a_skipped_hearth() {
	let out = lua(r#"
		KNOWN = { [3567] = true, [18960] = true, [556] = true }
		RUNES = 0
		COOL = {}
		C_SpellBook = { IsSpellKnown = function(id) return KNOWN[id] or false end }
		C_Item = { GetItemCount = function(id) return id == 17031 and RUNES or 0 end }
		C_Spell = { GetSpellCooldown = function(id) local c = COOL[id]; return c and { startTime = c[1], duration = c[2] } or { startTime = 0, duration = 0 } end }
		local function names(list)
			local out = {}
			for _, t in ipairs(list) do out[#out + 1] = { t.name, t.ready, t.to and t.to.map or false, t.bind or false } end
			return out
		end
		emit(names(T.Teleports(T.Now())))
		RUNES = 2
		emit(names(T.Teleports(T.Now())))
		stub.advance(10)
		COOL[556] = { GetTime(), 900 }
		COOL[3567] = { GetTime(), 1.5 } -- the global cooldown does not count
		emit(names(T.Teleports(T.Now())))
		Polestar.Set("nav.teleports", false)
		emit(#T.Teleports(T.Now()))
	"#);
	assert_eq!(out[0], json!([["Teleport: Moonglade", 0, 1450, false], ["Astral Recall", 0, false, true]]), "no Rune of Teleportation: no city teleport");
	assert_eq!(out[1], json!([["Teleport: Orgrimmar", 0, 1454, false], ["Teleport: Moonglade", 0, 1450, false], ["Astral Recall", 0, false, true]]));
	let cooling: Vec<Value> = out[2].as_array().unwrap().iter().map(|t| json!([t[0], t[1]])).collect();
	assert_eq!(json!(cooling), json!([["Teleport: Orgrimmar", 0], ["Teleport: Moonglade", 0], ["Astral Recall", 900]]));
	assert_eq!(out[3], 0);
}

fn walk(dir: &Path, compat: &Path, offenders: &mut Vec<String>) {
	let mut entries: Vec<_> = fs::read_dir(dir).unwrap().map(|e| e.unwrap()).collect();
	entries.sort_by_key(|e| e.file_name());
	for e in entries {
		let p = e.path();
		if e.file_type().unwrap().is_dir() {
			walk(&p, compat, offenders);
		} else if e.file_name().to_string_lossy().ends_with(".lua") && p != compat && is_match(&String::from_utf8_lossy(&fs::read(&p).unwrap()), r"\bUnitPosition\b") {
			offenders.push(p.strip_prefix(root()).unwrap().display().to_string());
		}
	}
}

#[test]
fn c5_unitposition_is_read_in_one_place_core_compat_lua() {
	let mut offenders = Vec::new();
	let compat = root().join("addon").join("Polestar").join("Core").join("Compat.lua");
	walk(&root().join("addon").join("Polestar"), &compat, &mut offenders);
	assert_eq!(offenders, Vec::<String>::new());
}

// --- review fixes ---------------------------------------------------------------

fn travel_data() -> PathBuf {
	root().join("addon").join("Polestar").join("Nav").join("TravelData.lua")
}

const P0_1_SCRIPT: &str = r#"
			local T = Polestar.Transit
			local now = T.Now()
			T.Sighted("path-285", { epoch = now * 1000 - 1000, seen = math.floor(now), source = "you" })
			local w, r, timed = T.NextDeparture("zeppelin", "zeppelin-orgrimmar-gromgol", now, "a")
			emit({ w, r, timed, T.Caption("zeppelin", "zeppelin-orgrimmar-gromgol", now, "b") ~= nil })
			for _, id in ipairs({ @ROUTES@ }) do
				T.Sighted(id, { epoch = now * 1000 - 7000, seen = math.floor(now), source = "you" })
			end
			local out = {}
			for _, id in ipairs({ @SERVICES@ }) do
				for _, side in ipairs({ "a", "b" }) do
					local wait, ride, t = T.NextDeparture("x", id, now, side)
					local arrive = T.NextArrival("x", id, now, side)
					out[#out + 1] = { id, side, wait ~= nil and wait == wait and wait < 1e6, ride ~= nil and ride == ride and ride < 1e6, t, arrive ~= nil, T.Caption("x", id, now, side) ~= nil }
				end
			end
			emit(out)
		"#;

fn captures(text: &str, pattern: &str) -> Vec<String> {
	Regex::new(pattern).unwrap().captures_iter(text).map(|c| c[1].to_string()).collect()
}

fn quoted(ids: &[String]) -> String {
	ids.iter().map(|s| serde_json::to_string(s).unwrap()).collect::<Vec<_>>().join(", ")
}

#[test]
fn review_p0_1_the_committed_traveldata_lua_s_timetables_index_stops_from_1_a_sighting_on_every_loop_times_every_service() {
	let file = fs::read_to_string(travel_data()).unwrap();
	let route_ids = captures(&file, r#"(?m)^\t\t\t\["([\w-]+)"\] = \{ kind = "#);
	let service_ids = captures(&file, r#"(?m)^\t\t\t\["([\w-]+)"\] = \{(?:area=\d+,|areas=\{[\d,]+\},)?board="#);
	assert!(route_ids.iter().any(|s| s == "path-285") && service_ids.iter().any(|s| s == "zeppelin-orgrimmar-gromgol"));
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: P0_1_SCRIPT.replace("@ROUTES@", &quoted(&route_ids)).replace("@SERVICES@", &quoted(&service_ids)),
		..Default::default()
	});
	let cars = captures(&file, r#"(?m)^\t\t\t\["lift-great-lift"\] = \{ kind = "lift".*\n\t+stops = (.*),$"#);
	let zep = &out[0];
	let all = out[1].as_array().unwrap();
	assert_eq!(zep[2], true, "timed");
	let wait = zep[0].as_f64().unwrap();
	assert!((10.0..=303.5 + 10.0).contains(&wait), "wait {} s within one loop", zep[0]);
	assert!((zep[1].as_f64().unwrap() - 78.4).abs() < 1.0, "Orgrimmar -> Grom'gol ride {} s", zep[1]);
	assert_eq!(zep[3], true);
	for row in all {
		let r = row.as_array().unwrap();
		assert_eq!(json!(r[2..]), json!([true, true, true, true, true]), "{} side {}", text(&r[0]), text(&r[1]));
	}
	assert_eq!(all.len(), service_ids.len() * 2);
	assert!(is_match(&cars[0], r"^\{\{0,5000,1,[^}]*,1\},\{0,5000,1,[^}]*,2\},"), "review P3-14: the Great Lift's stops keep their car");
}

fn build_of(file: &Path) -> Option<String> {
	let t = fs::read_to_string(file).unwrap();
	Regex::new(r"Classic Era[^\n]*\(wago\.tools build\s*(?:\n--\s*)?([\d.]+)").unwrap().captures(&t).map(|c| c[1].to_string())
}

#[test]
fn review_p2_2_flightpaths_lua_and_traveldata_lua_are_built_from_the_same_classic_era_tables() {
	let travel = build_of(&travel_data());
	let flights = build_of(&root().join("addon").join("Polestar").join("Maps").join("FlightPaths.lua"));
	assert!(travel.as_deref().is_some_and(|t| is_match(t, r"^1\.15\.")), "TravelData.lua build {}", travel.as_deref().unwrap_or("null"));
	assert_eq!(flights, travel);
}

// Two cars on one lift loop, 20 yd apart: car 1 at x = 0 starts at the top, car 2 at x = 20 at the bottom;
// each rides 10 s and rests 5 s at each end.
const TWO_CARS: &str = r#"
local T = Polestar.Transit
T.Register({
	routes = {
		duo = { kind = "lift", period = 30000, fit = { samples = 5, span = 4000, speed = 8 },
			stops = { { 0, 5000, 0, 0, 0, 100, 1 }, { 0, 5000, 0, 20, 0, 0, 2 }, { 15000, 20000, 0, 0, 0, 0, 1 }, { 15000, 20000, 0, 20, 0, 100, 2 } },
			frames = {
				{ 0, 5000, 0, 0, 0, 0, 100 }, { 15000, 20000, 0, 0, 0, 0, 0 }, { 30000, 30000, 0, 0, 0, 1, 100 },
				{ 0, 5000, 0, 20, 0, 0, 0 }, { 15000, 20000, 0, 20, 0, 0, 100 }, { 30000, 30000, 0, 20, 0, 1, 0 },
			} },
	},
	services = {
		["lift-duo"] = { kind = "lift", name = "The Duo Lift", c = 0, wx = 10, wy = 0, top = 100, bottom = 0, board = 2, pre = 0, post = 0,
			wait = { a = 9.5, b = 9.5 }, ride = { a = 10, b = 10 }, routes = { { route = "duo", a = { 1, 4 }, b = { 2, 3 } } } },
	},
})
"#;

#[test]
fn review_p3_14_riding_one_car_of_a_two_car_lift_the_next_stop_is_that_car_s_landing_not_the_other_car_s() {
	let out = emitted(&RunAddon {
		addons: vec![transit()],
		login: true,
		script: format!(
			"{TWO_CARS}{}",
			r#"
			local function nowMs() return T.Now() * 1000 end
			local EPOCH = nowMs() - 5000 -- car 2 leaves the bottom now
			function UnitPosition()
				local p = (nowMs() - EPOCH) % 30000
				local z
				if p < 5000 then z = 0 elseif p < 15000 then z = 100 * (p - 5000) / 10000
				elseif p < 20000 then z = 100 else z = 100 * (1 - (p - 20000) / 10000) end
				return 20, 0, z, 0
			end
			stub.advance(22) -- up, rest at the top, and on the way down again
			local r = T.Riding()
			emit(r and { r.dock, math.floor(r.arriveIn + 0.5) } or false)
		"#
		),
		..Default::default()
	});
	assert_eq!(out[0], json!(["bottom", 3]), "car 2 descends to the bottom; car 1 reaches the top at the same moment");
}

const SHARE_TAIL: &str = r#"
Polestar.Set("nav.shareTransit", true)
FIRED = {}
Polestar.On("NAV_TRANSIT", function(changed, own)
	local ids = {}
	for id in pairs(changed or {}) do ids[#ids + 1] = id end
	table.sort(ids)
	FIRED[#FIRED + 1] = { table.concat(ids, ","), own or false }
end)
local function msg(text, chatType, sender) stub.fire("CHAT_MSG_ADDON", "PolestarT1", text, chatType or "GUILD", sender or "Friend") end
"#;

const SHARE_STUBS: &str = r#"SENT = {}; C_ChatInfo = { RegisterAddonMessagePrefix = function() return true end, SendAddonMessage = function(...) SENT[#SENT + 1] = { ... } end }; GetNormalizedRealmName = function() return "TestRealm" end"#;

fn share_with(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon { addons: vec![transit()], login: true, before: format!("{SHARE_STUBS}; {before}"), script: format!("{DATA}{SHARE_TAIL}{script}"), ..Default::default() })
}

fn share(script: &str) -> Vec<Value> {
	share_with(script, "")
}

#[test]
fn security_m1_other_realms_instance_chat_and_a_battleground_raid_are_not_this_realm_s_boat_times() {
	let out = share_with(
		r#"
		local now = math.floor(T.Now())
		local function lift() return held("lift") ~= nil end
		local out = {}
		msg("Slift:" .. now .. ":16000", "GUILD", "Friend-OtherRealm"); out[#out + 1] = lift()
		msg("Slift:" .. now .. ":16000", "INSTANCE_CHAT", "Friend"); out[#out + 1] = lift()
		INSIDE = "pvp"
		msg("Slift:" .. now .. ":16000", "RAID", "Friend"); out[#out + 1] = lift()
		INSIDE = nil
		msg("Slift:" .. now .. ":16000", "RAID", "Friend-TestRealm"); out[#out + 1] = lift()
		emit(out)
	"#,
		r#"function IsInInstance() if INSIDE then return true, INSIDE end return false, "none" end"#,
	);
	assert_eq!(out[0], json!([false, false, false, true]));
}

#[test]
fn security_m2_your_own_ride_always_replaces_a_shared_time_and_a_shared_time_dated_ahead_counts_as_now() {
	let out = share(
		r#"
		local now = math.floor(T.Now())
		msg("Sr:" .. (now + 5) .. ":1000")
		emit(held("r").seen == now)
		emit(T.Sighted("r", { epoch = T.Now() * 1000 - 40000, seen = now, source = "you" }) and held("r").source)
	"#,
	);
	assert_eq!(out[0], true);
	assert_eq!(out[1], "you");
}

#[test]
fn security_m3_shared_times_retime_the_route_at_most_every_20_s_naming_the_transports_changed_your_own_ride_at_once() {
	let out = share(
		r#"
		local now = math.floor(T.Now())
		msg("Sr:" .. now .. ":1000")
		emit(#FIRED)
		for i = 1, 5 do stub.advance(1); msg("Sr:" .. (now + i) .. ":" .. (1000 + i * 1000)); msg("Slift:" .. (now + i) .. ":1000") end
		emit(#FIRED)
		stub.advance(20)
		emit(FIRED[#FIRED])
		T.Sighted("r", { epoch = T.Now() * 1000 - 40000, seen = math.floor(T.Now()), source = "you" })
		emit(FIRED[#FIRED])
	"#,
	);
	assert_eq!(out[0], 1, "the first shared time applies at once");
	assert_eq!(out[1], 1, "ten more within 20 s wait");
	assert_eq!(out[2], json!(["boat-x,lift-x", false]), "then one event for all of them");
	assert_eq!(out[3], json!(["boat-x", true]));
}

#[test]
fn security_l4_a_query_is_answered_after_a_random_wait_and_not_when_another_reply_already_covered_your_times() {
	let out = share(
		r#"
		local now = math.floor(T.Now())
		T.Sighted("r", { epoch = T.Now() * 1000 - 10000, seen = now, source = "you" })
		msg("Q")
		msg("Sr:" .. now .. ":10000", "GUILD", "Other")
		stub.advance(13)
		emit(#SENT)
		stub.advance(31)
		msg("Q")
		stub.advance(13)
		emit(#SENT)
	"#,
	);
	assert_eq!(out[0], 0, "someone else answered with the same time");
	assert_eq!(out[1], 1);
}

// KEPT IN JS: the CMaNGOS transport model: cruising, short hops and acceleration | expected wait over a uniform phase: half the gap plus boarding, and the sooner of independent loops | classic-db extraction: spawns, portal and teleport destinations from the SQL dump | lift tracks, portals and teleports from TransportAnimation, classic-db and the spell tables | `travel build` with timetable sources: Transit data in TravelData.lua, loaded by the addon, byte-identical on every run | the model reproduces every period CMaNGOS classic-db sniffed (local client tables) | review P3-16, security L9: the CMaNGOS dump is pinned by hash and size; a corrupt cached copy is fetched again | security L10: only digits-and-dots builds name a cache folder; a carriage return is escaped in generated Lua | second review L10b: wago.js takes only digits-and-dots builds from wago.tools; crossings Lua escapes a carriage return
