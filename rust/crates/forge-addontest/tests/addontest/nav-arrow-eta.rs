//! The arrow's trip time (addon/Polestar/Nav/Arrow.lua, #4209): calm while walking (no flicker from second to
//! second, no big jumps from a turn or a path measured again), still following real changes (a mount, a new route)
//! within a few seconds. Scripted walks at 60 frames a second, the shown time read every frame: on the compass
//! (no route: the closing speed) against tests/lua/stub_nav.lua, and on a route (the remaining route time) in its
//! small travel world.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::Value;

// Shared Lua: the arrow, and `walk(seconds, move)`: frames of 1/60 s, `move(t, dt)` placing the player before each;
// every change of the shown time as { t, text } (text false: hidden).
const PRELUDE: &str = r#"
local N = Polestar.Nav
local A = N.arrow
local nav = stub.nav
local sin, cos, sqrt, pi = math.sin, math.cos, math.sqrt, math.pi
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "T")
end
local clock, last = 0, nil
local function walk(seconds, move, log)
	log = log or {}
	local dt = 1 / 60
	for _ = 1, math.floor(seconds * 60 + 0.5) do
		move(clock, dt)
		stub.advance(dt)
		clock = clock + dt
		local s = A.etaText:IsShown() and A.etaText:GetText() or false
		if s ~= last then
			log[#log + 1] = { clock, s }
			last = s
		end
	end
	return log
end
local function shown() return A.etaText:IsShown() and A.etaText:GetText() or false end
-- Straight east at `speed` yd/s.
local function east(speed) return function(_, dt) nav.place(nav.player.wx + speed * dt, nav.player.wy) end end
"#;

fn compass(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}Polestar.Set(\"nav.navRouting\", false)\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// The travel world (stub.nav.useTravelWorld): flight paths 1 and 2 known, the arrow on the compass between stops.
fn routed(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!(
			"{PRELUDE}nav.faction = \"Alliance\"\nPolestar.CharState().flags.taxiSeen = {{ [0] = true, [1] = true }}\nnav.useTravelWorld(nil)\n\
			 Polestar.Set(\"nav.navRouting\", false)\nPolestar.CharState().flags.taxi = {{ [1] = true, [2] = true }}\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

fn mmss(t: &str) -> f64 {
	let t = t.trim_end_matches(" total");
	let parts: Vec<f64> = t.split(':').map(|p| p.parse::<f64>().unwrap_or(f64::NAN)).collect();
	parts[0] * 60.0 + parts[1]
}

/// The shown time's changes from `from` seconds on: (time, seconds or None while hidden).
fn changes(log: &Value, from: f64) -> Vec<(f64, Option<f64>)> {
	log.as_array()
		.unwrap()
		.iter()
		.filter_map(|e| {
			let t = e[0].as_f64()?;
			(t >= from).then(|| (t, e[1].as_str().map(mmss)))
		})
		.collect()
}

/// Most changes in any 10 s, and the largest step between two shown times.
fn calm(ch: &[(f64, Option<f64>)]) -> (usize, f64) {
	let worst = (0..ch.len()).map(|i| ch[i..].iter().take_while(|c| c.0 < ch[i].0 + 10.0).count()).max().unwrap_or(0);
	let shown: Vec<f64> = ch.iter().filter_map(|c| c.1).collect();
	let jump = shown.windows(2).map(|w| (w[1] - w[0]).abs()).fold(0.0, f64::max);
	(worst, jump)
}

// Walking toward the target with a weave (3 yd either side, a 4 s period, always at 7 yd/s): the closing speed swings
// between about 5 and 7 yd/s with each turn. Before #4209 the time changed at nearly every sample (20 times a
// second) by up to a third of its value.
#[test]
fn the_compass_time_holds_steady_while_weaving_toward_the_target() {
	let out = compass(
		r#"
		target(800, 0)
		stub.advance(0.2)
		local w = 2 * pi / 4
		local log = walk(40, function(t, dt)
			local vy = 3 * w * cos(w * t)
			nav.place(nav.player.wx + sqrt(49 - vy * vy) * dt, 3 * sin(w * t))
		end)
		emit({ log = log, left = N.GetDistance() })"#,
	);
	let ch = changes(&out["log"], 3.0);
	assert!(ch.iter().all(|c| c.1.is_some()), "never hidden while walking on: {:?}", ch);
	let (worst, jump) = calm(&ch);
	assert!(worst <= 4, "at most 4 changes in 10 s (5 s steps over a minute), got {worst}: {:?}", ch);
	assert!(jump <= 5.0, "steps of at most 5 s, got {jump}: {:?}", ch);
	// Still right: the true time at the weave's mean closing speed (about 6.3 yd/s) within 15%.
	let last = ch.last().unwrap().1.unwrap();
	let truth = out["left"].as_f64().unwrap() / 6.3;
	assert!((last - truth).abs() <= truth * 0.15, "shown {last} s, about {truth:.0} s left");
}

// Round an obstacle on the compass: 3 s straight, 3 s sideways (no closer), straight on. The time may grow (the
// detour costs time) but in steps, never a leap.
#[test]
fn the_compass_time_does_not_leap_while_walking_round_an_obstacle() {
	let out = compass(
		r#"
		target(500, 0)
		stub.advance(0.2)
		local log = walk(4, east(7))
		walk(3, function(_, dt) nav.place(nav.player.wx, nav.player.wy + 7 * dt) end, log)
		walk(12, east(7), log)
		emit({ log = log })"#,
	);
	let ch = changes(&out["log"], 1.0);
	assert!(ch.iter().all(|c| c.1.is_some()), "never hidden round the obstacle: {:?}", ch);
	let (worst, jump) = calm(&ch);
	assert!(jump <= 5.0, "steps of at most 5 s, got {jump}: {:?}", ch);
	assert!(worst <= 5, "at most 5 changes in 10 s, got {worst}: {:?}", ch);
}

// Mounting up (run speed 7 -> 9.8 yd/s, GetUnitSpeed's run speed) shows at once: within 2 s the shown time is the
// time at the new speed (within 5 s or 10%) and stays there.
#[test]
fn mounting_up_on_the_compass_settles_the_time_within_two_seconds() {
	let out = compass(
		r#"
		target(900, 0)
		stub.advance(0.2)
		walk(10, east(7))
		nav.runSpeed = 9.8
		local after = {}
		local t0 = clock
		walk(12, function(t, dt)
			nav.place(nav.player.wx + 9.8 * dt, 0)
			if t - t0 >= 2 then
				local s = shown()
				after[#after + 1] = { s, N.GetDistance() / 9.8 }
			end
		end)
		emit({ after = after })"#,
	);
	for e in out["after"].as_array().unwrap().iter().step_by(30) {
		let shown = mmss(text(&e[0]));
		let truth = e[1].as_f64().unwrap();
		assert!((shown - truth).abs() <= f64::max(5.0, truth * 0.1), "2 s after mounting: shown {shown} s, {truth:.0} s left");
	}
}

// On a route, the walk's time measured again (here: 60 s more, as when the walking engine's path comes in longer
// than the straight estimate) eases in over a few seconds in steps instead of one leap; a new target is shown at once.
#[test]
fn a_route_time_measured_again_eases_in_and_a_new_target_shows_at_once() {
	let out = routed(
		r#"
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		stub.advance(0.2)
		local T = N.travel
		local remaining, extra, asked = T.Remaining, 0, nil
		T.Remaining = function(...)
			local s = remaining(...)
			asked = s and s + extra
			return asked
		end
		local north = function(_, dt) nav.place(0, nav.player.wy + 7 * dt) end
		local log = walk(3, north)
		extra = 60
		walk(12, north, log)
		local settled = { shown(), asked }
		extra = 0
		target(0, -700, "Elsewhere")
		stub.advance(0.1)
		local fresh = { shown(), asked }
		emit({ log = log, settled = settled, fresh = fresh, active = T.Active() })"#,
	);
	assert_eq!(out["active"], true, "the new target is on a route too");
	let ch = changes(&out["log"], 0.5);
	let (_, jump) = calm(&ch);
	assert!(jump <= 5.0, "steps of at most 5 s, got {jump}: {:?}", ch);
	let (s, est) = (mmss(text(&out["settled"][0])), out["settled"][1].as_f64().unwrap());
	assert!((s - est).abs() <= 5.0, "12 s after the new measure: shown {s} s, estimate {est:.0} s");
	let (s, est) = (mmss(text(&out["fresh"][0])), out["fresh"][1].as_f64().unwrap());
	assert!((s - est).abs() <= 3.0, "a new target's time at once: shown {s} s, estimate {est:.0} s");
}

// Mounting up on a route's walk: the route time takes the new speed at once (Travel.Remaining's walk at the live
// run speed), within 2 s.
#[test]
fn mounting_up_on_a_route_walk_settles_the_route_time_within_two_seconds() {
	let out = routed(
		r#"
		nav.place(0, 400)
		target(0, -780, "Kobolds")
		stub.advance(0.2)
		local T = N.travel
		local remaining, asked = T.Remaining, nil
		T.Remaining = function(...)
			asked = remaining(...)
			return asked
		end
		local north = function(_, dt) nav.place(0, nav.player.wy + 7 * dt) end
		walk(3, north)
		nav.runSpeed = 9.8
		walk(2.5, function(_, dt) nav.place(0, nav.player.wy + 9.8 * dt) end)
		local legs, ci = N.GetRoute()
		local leg = legs[ci]
		local tx, ty = leg.to.wx, leg.to.wy
		local straight = sqrt((tx - nav.player.wx) ^ 2 + (ty - nav.player.wy) ^ 2)
		emit({ shown = shown(), asked = asked, walk = straight * 1.25 / 9.8, rest = leg.rest, kind = leg.kind })"#,
	);
	assert_eq!(out["kind"], "walk");
	let shown = mmss(text(&out["shown"]));
	let truth = out["walk"].as_f64().unwrap() + out["rest"].as_f64().unwrap();
	let asked = out["asked"].as_f64().unwrap();
	assert!((asked - truth).abs() <= 3.0, "the route time takes the mount's speed: {asked:.0} s, {truth:.0} s at 9.8 yd/s");
	assert!((shown - truth).abs() <= 5.0, "2.5 s after mounting: shown {shown} s, {truth:.0} s at the mount's speed");
}
