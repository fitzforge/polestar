//! Movement profiles, speeds and costs for routes on the navigation grid (port of
//! tools/lib/nav/move.js; docs/ARCHITECTURE.md, "Navigation grid").
//! Values checked 2026-10-15:
//!
//! - Run 7.0 yd/s, swim 4.722222 yd/s: cMaNGOS mangos-classic
//!   src/game/Entities/Unit.cpp baseMoveSpeed[] (MOVE_RUN 7.0f, MOVE_SWIM 4.722222f).
//! - Mount +60% from params.mountLevel (40), epic +100% at EPIC_LEVEL 60
//!   (Classic riding: apprentice mounts at 40, epic mounts at 60; sim params mountMul 1.6).
//!   Mounts do not swim faster and are not usable indoors.
//! - Travel Form (Druid 30): +40%, "Only useable outdoors"
//!   (Classic spell 783; Forever 1.60.1.70374 keeps 40%, foreverdiff.com/spells/travel-form-783).
//! - Aquatic Form (Druid 16): swim speed +50% (Classic spell 1066, "Requires Level 16").
//! - Ghost Wolf (Shaman 20): +40%, "Only useable outdoors" (Classic spell 2645, classicdb.ch/?spell=2645).
//! - Aspect of the Cheetah (Hunter 20): +30%, usable indoors (Classic spell 5118).
//! - Slopes (decided here): land time is multiplied by SLOPE_MUL of the
//!   link's class: terrain gradient to 35° x1, to 50° x2, to 60° (steep)
//!   x4, to 80° (climb) x10 (grid/format.js, grid/links.js).
//! - Falls: about FALL_SECONDS plus the health they cost, refilled at
//!   REGEN_FULL seconds per full bar (cMaNGOS Player::HandleFall: damage share
//!   0.018 * h - 0.2426 from SAFE_FALL; none into water), plus a comfort
//!   cost (decided here): FALL_COMFORT seconds and 1 s per yd of drop above
//!   FALL_COMFORT_FREE, so chains of ledge drops lose to lifts and walks.
//! - Lifts (decided here): LIFT_WAIT seconds plus the height at LIFT_SPEED.
//! - Jumps: the distance at land speed plus JUMP_SECONDS (decided here).
//! - Leaving an indoor surface for outdoor land with an outdoor-only speed
//!   mode (mount, Travel Form, Ghost Wolf) costs REMOUNT seconds.
//!
//! profile_for(cls, level, params) -> profile
//!   { name, run, swim, outdoor, indoor, remount, ref, mode }
//!   outdoor: yd/s on outdoor land, indoor: on indoor land, swim; remount:
//!   seconds per indoor -> outdoor transition; ref: the abstract graph it
//!   searches (format.js REF_PROFILES); mode: what gives the outdoor speed.

use crate::fmath;
use crate::format::{cls, flag, LINK_SLOPE, SAFE_FALL};

pub const RUN: f64 = 7.0;
pub const SWIM: f64 = 4.722222;
pub const MOUNT_MUL: f64 = 1.6;
pub const EPIC_MUL: f64 = 2.0;
pub const EPIC_LEVEL: f64 = 60.0;
pub const MOUNT_LEVEL: f64 = 40.0;
const TRAVEL_FORM: (f64, f64) = (30.0, 1.4);
const AQUATIC_FORM: (f64, f64) = (16.0, 1.5);
const GHOST_WOLF: (f64, f64) = (20.0, 1.4);
const CHEETAH: (f64, f64) = (20.0, 1.3);
pub const REGEN_FULL: f64 = 20.0;
pub const REMOUNT: f64 = 1.5;
pub const FALL_SECONDS: f64 = 1.0;
pub const JUMP_SECONDS: f64 = 0.5;
const FALL_COMFORT: f64 = 3.0;
const FALL_COMFORT_FREE: f64 = 5.0;
pub const LIFT_WAIT: f64 = 15.0;
pub const LIFT_SPEED: f64 = 4.0;
/// Time multiplier per stored link code (format.js): walk, steep, swim, jump, -, -, climb, slope (decided here).
pub const SLOPE_MUL: [f64; 8] = [1.0, 4.0, 1.0, 1.0, 1.0, 1.0, 10.0, 2.0];

/// Cost terms of a stretch of route (abstract graph edges): outdoor and indoor
/// yards times SLOPE_MUL, swim yards, jumps, fall seconds, remounts, lift seconds.
pub const TERMS: [&str; 7] = ["outdoor", "indoor", "swim", "jumps", "fallSec", "remounts", "liftSec"];

#[derive(Clone, Debug, PartialEq)]
pub struct Profile {
	pub name: String,
	pub run: f64,
	pub swim: f64,
	pub outdoor: f64,
	pub indoor: f64,
	pub remount: f64,
	pub mode: &'static str,
	/// `ref`: "mount" or "foot".
	pub reference: &'static str,
}

/// Sim params means (profileFor's `params`); None or 0 = the default.
#[derive(Clone, Debug, Default)]
pub struct Params {
	pub run_speed: Option<f64>,
	pub mount_level: Option<f64>,
	pub mount_mul: Option<f64>,
}

fn class_key(cls: Option<&str>) -> String {
	match cls {
		Some(c) if !c.is_empty() => c.to_uppercase().chars().filter(|ch| ch.is_ascii_uppercase()).collect(),
		_ => String::new(),
	}
}

/// `x || dflt` for a number.
fn or(x: Option<f64>, dflt: f64) -> f64 {
	match x {
		Some(v) if v != 0.0 && !v.is_nan() => v,
		_ => dflt,
	}
}

fn profile(name: String, run: f64, swim: f64, outdoor: f64, indoor: f64, remount: f64, mode: &'static str) -> Profile {
	Profile { name, run, swim, outdoor, indoor, remount, mode, reference: if outdoor >= run * 1.25 { "mount" } else { "foot" } }
}

/// The profile of a character: class (file 'DRUID' or label 'Druid'), level,
/// params (sim params means: runSpeed, mountLevel, mountMul).
pub fn profile_for(cls: Option<&str>, level: f64, params: Option<&Params>) -> Profile {
	let dflt = Params::default();
	let p = params.unwrap_or(&dflt);
	let run = or(p.run_speed, RUN);
	let key = class_key(cls);
	let mut outdoor = run;
	let mut indoor = run;
	let mut swim = SWIM;
	let mut mode = "run";
	let mount_level = or(p.mount_level, MOUNT_LEVEL);
	let better = |mul: f64, m: &'static str, outdoor: &mut f64, mode: &mut &'static str| {
		if run * mul > *outdoor {
			*outdoor = run * mul;
			*mode = m;
		}
	};
	if level >= EPIC_LEVEL {
		better(EPIC_MUL, "epic mount", &mut outdoor, &mut mode);
	} else if level >= mount_level {
		better(or(p.mount_mul, MOUNT_MUL), "mount", &mut outdoor, &mut mode);
	}
	if key == "DRUID" && level >= TRAVEL_FORM.0 {
		better(TRAVEL_FORM.1, "travel form", &mut outdoor, &mut mode);
	}
	if key == "DRUID" && level >= AQUATIC_FORM.0 {
		swim = SWIM * AQUATIC_FORM.1;
	}
	if key == "SHAMAN" && level >= GHOST_WOLF.0 {
		better(GHOST_WOLF.1, "ghost wolf", &mut outdoor, &mut mode);
	}
	if key == "HUNTER" && level >= CHEETAH.0 {
		indoor = run * CHEETAH.1;
		better(CHEETAH.1, "cheetah", &mut outdoor, &mut mode);
	}
	let remount = if mode == "run" || mode == "cheetah" { 0.0 } else { REMOUNT };
	let name = format!("{} {}", if key.is_empty() { "any".to_string() } else { key.to_lowercase() }, fmath::num_to_string(level));
	profile(name, run, swim, outdoor, indoor, remount, mode)
}

/// The reference profiles the abstract graph is built for, in format.js REF_PROFILES order
/// (REFS.foot, REFS.mount).
pub fn refs() -> [Profile; 2] {
	[profile("foot".into(), RUN, SWIM, RUN, RUN, 0.0, "run"), profile("mount".into(), RUN, SWIM, RUN * MOUNT_MUL, RUN, REMOUNT, "mount")]
}

/// Health share a fall of h yards costs (0 into water).
pub fn fall_damage(h: f64, into_water: bool) -> f64 {
	if into_water || h < SAFE_FALL {
		return 0.0;
	}
	fmath::min(1.0, fmath::max(0.0, 0.018 * h - 0.2426))
}

pub fn fall_seconds(h: f64, into_water: bool) -> f64 {
	FALL_SECONDS + FALL_COMFORT + fmath::max(0.0, h - FALL_COMFORT_FREE) + REGEN_FULL * fall_damage(h, into_water)
}

pub fn lift_seconds(h: f64) -> f64 {
	LIFT_WAIT + h.abs() / LIFT_SPEED
}

/// The route class (format.js CLS) of a link with code `code` from flags fa to fb.
pub fn segment_class(code: u8, fa: u8, fb: u8) -> u8 {
	if code == cls::WALK || code == LINK_SLOPE {
		return if (fa | fb) & flag::INDOOR != 0 { cls::INDOOR } else { cls::WALK };
	}
	code
}

/// Seconds of a link (stored code) over length d (yards, 3D) from an entry
/// with flags fa to one with fb, for profile p.
pub fn link_seconds(p: &Profile, code: u8, fa: u8, fb: u8, d: f64) -> f64 {
	let mut s = if code == cls::SWIM { d / p.swim } else { (d * SLOPE_MUL[code as usize]) / (if (fa | fb) & flag::INDOOR != 0 { p.indoor } else { p.outdoor }) };
	if code == cls::JUMP {
		s += JUMP_SECONDS;
	}
	if p.remount != 0.0 && !p.remount.is_nan() && fa & flag::INDOOR != 0 && fb & (flag::INDOOR | flag::SWIM) == 0 {
		s += p.remount;
	}
	s
}

/// Adds a link's cost terms to out (TERMS order).
pub fn add_link_terms(out: &mut [f64; 7], code: u8, fa: u8, fb: u8, d: f64) {
	if code == cls::SWIM {
		out[2] += d;
	} else if (fa | fb) & flag::INDOOR != 0 {
		out[1] += d * SLOPE_MUL[code as usize];
	} else {
		out[0] += d * SLOPE_MUL[code as usize];
	}
	if code == cls::JUMP {
		out[3] += 1.0;
	}
	if fa & flag::INDOOR != 0 && fb & (flag::INDOOR | flag::SWIM) == 0 {
		out[5] += 1.0;
	}
}

/// Seconds of a set of cost terms for profile p (TERMS order).
pub fn term_seconds(p: &Profile, outdoor: f64, indoor: f64, swim: f64, jumps: f64, fall_sec: f64, remounts: f64, lift_sec: f64) -> f64 {
	outdoor / p.outdoor + indoor / p.indoor + swim / p.swim + jumps * JUMP_SECONDS + fall_sec + remounts * p.remount + lift_sec
}

/// The fastest speed of a profile (admissible search heuristics).
pub fn max_speed(p: &Profile) -> f64 {
	fmath::max(fmath::max(p.outdoor, p.indoor), p.swim)
}
