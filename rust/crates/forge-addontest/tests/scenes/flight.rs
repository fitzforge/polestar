//! A flight from Orgrimmar to the Crossroads (an Orc at the flight master, the flight map opened, the Crossroads
//! taken, on the taxi until the timer's estimate runs out, landed at the Crossroads), with Freedoom Arcade on and
//! off (maps.flightArcade). What the player meets:
//!
//! - off: the flight timer, nothing of the Arcade (no card, nothing loaded), no chat line, no sound;
//! - on: the card asking "Do you want to play Doom while waiting?" once, gone with a minute left and on landing;
//!   no chat line, no sound;
//! - on, Play pressed: the game opens; 10 seconds before landing it is saved, paused and put away; the landing says
//!   once how to continue; two fights after the landing say nothing more (#2899: 0.4.1 ended each of them with
//!   "combat over. Type /doom to get back to Doom.").
//!
//! In every case the one flight taken is the player's (TakeTaxiNode once: qol.flightAutoTake is off by default)
//! and nothing else is done for them. Each second of the flight (20 client frames) is timed, but for the seconds
//! the game is open (it draws every frame: its cost, not Polestar's).

use crate::common::{play, release_or_skip, Play};
use forge_addontest::assert_timing;
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.faction, w.race, w.raceName, w.raceID, w.class, w.className, w.classID = "Horde", "Orc", "Orc", 2, "WARRIOR", "Warrior", 1
w.level = 20
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -3680.601, right = -5083.206, top = 2273.877, bottom = 1338.461, parent = 1411 })
w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5139.583 })
w.moveTo(1454, 45.1, 63.9)
w.zone, w.subzone = "Orgrimmar", "Valley of Strength"
"#;

/// The flight; `PLAY` true presses the card's Play. Emits what the player met.
const FLIGHT: &str = r#"
local w, S = stub.world, stub.scenes
stub.advance(3)
local function card()
	local c = stub.frame("PolestarArcadeOffer")
	return c ~= nil and c:IsShown() and c.mode or false
end
local function timerShown()
	local f = stub.frame("PolestarFlightTimer")
	return f ~= nil and f:IsShown() or false
end
local s = Scene.snap()
-- Doras, Orgrimmar's wind rider master.
w.taxi(3310, "Orgrimmar, Durotar", { "Crossroads, The Barrens", "Thunder Bluff, Mulgore" })
stub.advance(1)
TakeTaxiNode(2)
stub.advance(1)
local to, left = Polestar.Maps.GetFlight()
local out = { to = to or false, left = left or false, timer = timerShown(), cards = {}, ticks = {}, game = false, notices = {} }
local function note(at)
	local c = card()
	local last = out.cards[#out.cards]
	if not last or last[2] ~= c then out.cards[#out.cards + 1] = { at, c } end
end
note(0)
if PLAY and card() then
	stub.frame("PolestarArcadeOffer").Ask.Play:Click()
	stub.advance(1)
	local A = FreedoomArcade
	if A and A.G and A.G.InitNew then A.G.InitNew(2, 1, 1) end
	out.game = FreedoomArcadeAPI and FreedoomArcadeAPI.IsOpen and FreedoomArcadeAPI.IsOpen() or false
end
-- The seconds the game is open are its own (it draws every frame): only the others are Polestar's to time.
local function playing() return FreedoomArcadeAPI and FreedoomArcadeAPI.IsOpen and FreedoomArcadeAPI.IsOpen() or false end
out.played = 0
for i = 1, math.ceil(left or 120) + 2 do
	if playing() then
		stub.advance(1)
		out.played = out.played + 1
	else
		out.ticks[#out.ticks + 1] = Scene.work(function() stub.advance(1) end).ms
	end
	note(i)
end
out.beforeLanding = { open = FreedoomArcadeAPI and FreedoomArcadeAPI.IsOpen and FreedoomArcadeAPI.IsOpen() or false, timer = timerShown() }
-- The Crossroads' wind rider master.
w.moveTo(1413, 51.5, 30.41)
S.land()
stub.advance(3)
note("landed")
out.flight = Scene.since(s)
out.landed = { timer = timerShown(), card = card(), onTaxi = UnitOnTaxi("player"), arcadeLoaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade") and true or false }
-- Two fights after the landing.
s = Scene.snap()
for i = 1, 2 do
	stub.inCombat = true
	stub.fire("PLAYER_REGEN_DISABLED")
	stub.advance(2)
	stub.inCombat = false
	stub.fire("PLAYER_REGEN_ENABLED")
	stub.advance(2)
end
out.after = Scene.since(s)
emit(out)
"#;

fn fly(arcade: bool, press_play: bool) -> Value {
	let set = if arcade { "" } else { "Polestar.Set(\"maps.flightArcade\", false)" };
	play(&Play { stubs: vec!["stub_scenes_world.lua"], before: WORLD.into(), script: format!("{set}\nlocal PLAY = {press_play}\n{FLIGHT}"), ..Default::default() }).remove(0)
}

fn lines(d: &Value) -> Vec<String> {
	d["lines"].as_array().map(|a| a.iter().map(|l| l.as_str().unwrap_or("").replace("|cffff4040", "").replace("|cff4fd1c5", "").replace("|r", "")).collect()).unwrap_or_default()
}

/// The flight itself: the timer up, the player's one TakeTaxiNode the only action, the timer gone on landing, and
/// each second of it within budget.
fn flown(case: &str, out: &Value) {
	assert_eq!(out["to"], "Crossroads", "{case}: the flight timer's destination");
	let left = out["left"].as_f64().unwrap_or(0.0);
	assert!(left >= 60.0, "{case}: the flight is {left} s by the timer, too short for the Arcade's offer");
	assert_eq!(out["timer"], true, "{case}: no flight timer on the taxi");
	let d = &out["flight"];
	assert_eq!(d["auto"], json!({ "TakeTaxiNode": 1 }), "{case}: actions during the flight (the player's own TakeTaxiNode only): {}", d["actions"]);
	assert_eq!(d["rares"], 0, "{case}: rare alerts on the flight");
	assert_eq!(d["alertTotal"], 0, "{case}: raid-warning, error-frame lines or flashes on the flight: {}", d["alerts"]);
	assert_eq!(out["landed"]["timer"], false, "{case}: the flight timer stays up after landing");
	assert_eq!(out["landed"]["card"], false, "{case}: the Arcade card stays up after landing");
	assert_eq!(out["landed"]["onTaxi"], false);
	let after = &out["after"];
	let said = lines(after);
	assert!(said.is_empty(), "{case}: 2 fights after landing: {} chat lines: {said:?}", said.len());
	assert_eq!(after["autoTotal"], 0, "{case}: actions in the fights after landing: {}", after["actions"]);
	let t: Vec<f64> = out["ticks"].as_array().unwrap().iter().map(|v| v.as_f64().unwrap()).collect();
	let mean = t.iter().sum::<f64>() / t.len() as f64;
	let worst = t.iter().cloned().fold(0.0, f64::max);
	// 0.4.1.1: 1.0-1.1 ms a second of flight on average (20 frames: the timer, the Arcade driver), 2.4 ms at worst.
	assert_timing!(mean <= 3.0, "{case}: a second of flight took {mean:.2} ms on average (budget 3 ms, {} seconds)", t.len());
	assert_timing!(worst <= 8.0, "{case}: the slowest second of flight took {worst:.2} ms (budget 8 ms)");
}

#[test]
fn a_flight_with_the_arcade_off_shows_the_timer_and_nothing_of_the_arcade() {
	let Some(_) = release_or_skip() else { return };
	let out = fly(false, false);
	flown("Arcade off", &out);
	assert_eq!(out["cards"], json!([[0, false]]), "Arcade off: its card showed: {}", out["cards"]);
	assert_eq!(out["landed"]["arcadeLoaded"], false, "Arcade off: Polestar_Arcade was loaded");
	let d = &out["flight"];
	let said = lines(d);
	assert!(said.is_empty(), "Arcade off: {} chat lines on the flight: {said:?}", said.len());
	assert_eq!(d["sounds"], 0, "Arcade off: sounds on the flight: {}", d["soundIds"]);
}

#[test]
fn a_flight_with_the_arcade_on_asks_once_and_lands_clean() {
	let Some(_) = release_or_skip() else { return };
	let out = fly(true, false);
	flown("Arcade on", &out);
	let cards = out["cards"].as_array().unwrap();
	let left = out["left"].as_f64().unwrap();
	assert_eq!(cards.first().map(|c| &c[1]), Some(&json!("ask")), "Arcade on: the flight did not start with the card asking: {}", out["cards"]);
	assert_eq!(cards.len(), 2, "Arcade on: the card should ask, then go with a minute left: {}", out["cards"]);
	assert_eq!(cards[1][1], false);
	let gone = cards[1][0].as_f64().unwrap_or(-1.0);
	assert!((left - 60.0 - gone).abs() <= 2.0, "Arcade on: the card went {gone} s into a {left} s flight, not with a minute left");
	assert_eq!(out["landed"]["arcadeLoaded"], false, "Arcade on, not played: Polestar_Arcade was loaded");
	let d = &out["flight"];
	let said = lines(d);
	assert!(said.is_empty(), "Arcade on: {} chat lines on the flight: {said:?}", said.len());
	assert_eq!(d["sounds"], 0, "Arcade on: sounds on the flight: {}", d["soundIds"]);
}

#[test]
fn a_flight_with_the_arcade_played_puts_it_away_before_landing_and_later_fights_say_nothing_2899() {
	let Some(_) = release_or_skip() else { return };
	let out = fly(true, true);
	assert_eq!(out["game"], true, "Play on the card did not open the game (cards: {})", out["cards"]);
	assert_eq!(out["beforeLanding"]["open"], false, "the game is still open when the taxi lands");
	let left = out["left"].as_f64().unwrap_or(0.0);
	let played = out["played"].as_f64().unwrap_or(0.0);
	assert!((left - 10.0 - played).abs() <= 3.0, "the game was open {played} s of a {left} s flight: not put away 10 s before landing");
	assert_eq!(out["landed"]["arcadeLoaded"], true);
	let d = &out["flight"];
	let said = lines(d);
	assert_eq!(said.len(), 1, "Arcade played: the flight should end with one line saying how to continue, got {said:?}");
	assert!(said[0].contains("Freedoom Arcade") && said[0].contains("continue"), "Arcade played: the landing said {said:?}");
	assert!(d["sounds"].as_u64().unwrap() <= 1, "Arcade played: {} sounds on the flight (the landing banner may chime once): {}", d["sounds"], d["soundIds"]);
	flown("Arcade played", &out);
}
