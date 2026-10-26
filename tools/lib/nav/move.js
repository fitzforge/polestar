'use strict';
// Movement profiles, speeds and costs for routes on the navigation grid
// (docs/ARCHITECTURE.md, "Navigation grid").
// Values checked 2026-10-15:
//
// - Run 7.0 yd/s, swim 4.722222 yd/s: cMaNGOS mangos-classic
//   src/game/Entities/Unit.cpp baseMoveSpeed[] (MOVE_RUN 7.0f, MOVE_SWIM 4.722222f).
// - Mount +60% from params.mountLevel (40), epic +100% at EPIC_LEVEL 60
//   (Classic riding: apprentice mounts at 40, epic mounts at 60; sim params mountMul 1.6).
//   Mounts do not swim faster and are not usable indoors.
// - Travel Form (Druid 30): +40%, "Only useable outdoors"
//   (classic spell 783; Forever 1.60.1.70374 keeps 40%, foreverdiff.com/spells/travel-form-783).
// - Aquatic Form (Druid 16): swim speed +50% (classic spell 1066, "Requires Level 16").
// - Ghost Wolf (Shaman 20): +40%, "Only useable outdoors" (classic spell 2645, classicdb.ch/?spell=2645).
// - Aspect of the Cheetah (Hunter 20): +30%, usable indoors (classic spell 5118).
// - Slopes (decided here): land time is multiplied by SLOPE_MUL of the
//   link's class: terrain gradient to 35° x1, to 50° x2, to 60° (steep)
//   x4, to 80° (climb) x10 (grid/format.js, grid/links.js).
// - Falls: about FALL_SECONDS plus the health they cost, refilled at
//   REGEN_FULL seconds per full bar (cMaNGOS Player::HandleFall: damage share
//   0.018 * h - 0.2426 from SAFE_FALL; none into water), plus a comfort
//   cost (decided here): FALL_COMFORT seconds and 1 s per yd of drop above
//   FALL_COMFORT_FREE, so chains of ledge drops lose to lifts and walks.
// - Lifts (decided here): LIFT_WAIT seconds plus the height at LIFT_SPEED.
// - Jumps: the distance at land speed plus JUMP_SECONDS (decided here).
// - Leaving an indoor surface for outdoor land with an outdoor-only speed
//   mode (mount, Travel Form, Ghost Wolf) costs REMOUNT seconds.
//
// profileFor({ cls, level, params }) -> profile
//   { name, run, swim, outdoor, indoor, remount, ref, mode }
//   outdoor: yd/s on outdoor land, indoor: on indoor land, swim; remount:
//   seconds per indoor -> outdoor transition; ref: the abstract graph it
//   searches (format.js REF_PROFILES); mode: what gives the outdoor speed.

const { FLAG, CLS, SAFE_FALL, LINK_SLOPE } = require('./grid/format');

const RUN = 7.0;
const SWIM = 4.722222;
const MOUNT_MUL = 1.6;
const EPIC_MUL = 2.0;
const EPIC_LEVEL = 60;
const MOUNT_LEVEL = 40;
const TRAVEL_FORM = { level: 30, mul: 1.4 };
const AQUATIC_FORM = { level: 16, mul: 1.5 };
const GHOST_WOLF = { level: 20, mul: 1.4 };
const CHEETAH = { level: 20, mul: 1.3 };
const REGEN_FULL = 20;
const REMOUNT = 1.5;
const FALL_SECONDS = 1;
const JUMP_SECONDS = 0.5;
const FALL_COMFORT = 3;
const FALL_COMFORT_FREE = 5;
const LIFT_WAIT = 15;
const LIFT_SPEED = 4;
// Time multiplier per stored link code (format.js): walk, steep, swim, jump, -, -, climb, slope (decided here).
const SLOPE_MUL = [1, 4, 1, 1, 1, 1, 10, 2];

// Cost terms of a stretch of route (abstract graph edges): outdoor and indoor
// yards times SLOPE_MUL, swim yards, jumps, fall seconds, remounts, lift seconds.
const TERMS = ['outdoor', 'indoor', 'swim', 'jumps', 'fallSec', 'remounts', 'liftSec'];

function classKey(cls) {
	return cls ? String(cls).toUpperCase().replace(/[^A-Z]/g, '') : '';
}

function profile(name, { run = RUN, swim = SWIM, outdoor = run, indoor = run, remount = 0, mode = 'run' }) {
	return { name, run, swim, outdoor, indoor, remount, mode, ref: outdoor >= run * 1.25 ? 'mount' : 'foot' };
}

// The profile of a character: class (file 'DRUID' or label 'Druid'), level,
// params (sim params means: runSpeed, mountLevel, mountMul).
function profileFor({ cls = null, level = 1, params = null } = {}) {
	const p = params || {};
	const run = p.runSpeed || RUN;
	const key = classKey(cls);
	let outdoor = run;
	let indoor = run;
	let swim = SWIM;
	let mode = 'run';
	const mountLevel = p.mountLevel || MOUNT_LEVEL;
	const better = (mul, m) => {
		if (run * mul > outdoor) {
			outdoor = run * mul;
			mode = m;
		}
	};
	if (level >= EPIC_LEVEL) better(EPIC_MUL, 'epic mount');
	else if (level >= mountLevel) better(p.mountMul || MOUNT_MUL, 'mount');
	if (key === 'DRUID' && level >= TRAVEL_FORM.level) better(TRAVEL_FORM.mul, 'travel form');
	if (key === 'DRUID' && level >= AQUATIC_FORM.level) swim = SWIM * AQUATIC_FORM.mul;
	if (key === 'SHAMAN' && level >= GHOST_WOLF.level) better(GHOST_WOLF.mul, 'ghost wolf');
	if (key === 'HUNTER' && level >= CHEETAH.level) {
		indoor = run * CHEETAH.mul;
		better(CHEETAH.mul, 'cheetah');
	}
	const remount = mode === 'run' || mode === 'cheetah' ? 0 : REMOUNT;
	const name = `${key ? key.toLowerCase() : 'any'} ${level}`;
	return profile(name, { run, swim, outdoor, indoor, remount, mode });
}

// The reference profiles the abstract graph is built for (format.js REF_PROFILES).
const REFS = {
	foot: profile('foot', {}),
	mount: profile('mount', { outdoor: RUN * MOUNT_MUL, remount: REMOUNT, mode: 'mount' }),
};

// Health share a fall of h yards costs (0 into water).
function fallDamage(h, intoWater = false) {
	if (intoWater || h < SAFE_FALL) return 0;
	return Math.min(1, Math.max(0, 0.018 * h - 0.2426));
}

function fallSeconds(h, intoWater = false) {
	return FALL_SECONDS + FALL_COMFORT + Math.max(0, h - FALL_COMFORT_FREE) + REGEN_FULL * fallDamage(h, intoWater);
}

function liftSeconds(h) {
	return LIFT_WAIT + Math.abs(h) / LIFT_SPEED;
}

// The route class (format.js CLS) of a link with code `code` from flags fa to fb.
function segmentClass(code, fa, fb) {
	if (code === CLS.WALK || code === LINK_SLOPE) return (fa | fb) & FLAG.INDOOR ? CLS.INDOOR : CLS.WALK;
	return code;
}

// Seconds of a link (stored code) over length d (yards, 3D) from an entry
// with flags fa to one with fb, for profile p (p.slopeMul: its own SLOPE_MUL;
// p.faceMul: a land link touching a FLAG.STEEP column, terrain steeper than
// the client walks up, costs that many times more).
function linkSeconds(p, code, fa, fb, d) {
	let s = code === CLS.SWIM ? d / p.swim : (d * (p.slopeMul || SLOPE_MUL)[code]) / ((fa | fb) & FLAG.INDOOR ? p.indoor : p.outdoor);
	if (p.faceMul && code !== CLS.SWIM && (fa | fb) & FLAG.STEEP) s *= p.faceMul;
	if (code === CLS.JUMP) s += JUMP_SECONDS;
	if (p.remount && fa & FLAG.INDOOR && !(fb & (FLAG.INDOOR | FLAG.SWIM))) s += p.remount;
	return s;
}

// Adds a link's cost terms to out (TERMS order).
function addLinkTerms(out, code, fa, fb, d) {
	if (code === CLS.SWIM) out[2] += d;
	else if ((fa | fb) & FLAG.INDOOR) out[1] += d * SLOPE_MUL[code];
	else out[0] += d * SLOPE_MUL[code];
	if (code === CLS.JUMP) out[3] += 1;
	if (fa & FLAG.INDOOR && !(fb & (FLAG.INDOOR | FLAG.SWIM))) out[5] += 1;
}

// Seconds of a set of cost terms for profile p (TERMS order).
function termSeconds(p, outdoor, indoor, swim, jumps, fallSec, remounts, liftSec) {
	return outdoor / p.outdoor + indoor / p.indoor + swim / p.swim + jumps * JUMP_SECONDS + fallSec + remounts * p.remount + liftSec;
}

// The fastest speed of a profile (admissible search heuristics).
function maxSpeed(p) {
	return Math.max(p.outdoor, p.indoor, p.swim);
}

module.exports = {
	profileFor, REFS, TERMS, SLOPE_MUL, fallDamage, fallSeconds, liftSeconds, segmentClass, linkSeconds, addLinkTerms, termSeconds, maxSpeed,
	RUN, SWIM, MOUNT_MUL, EPIC_MUL, EPIC_LEVEL, REGEN_FULL, REMOUNT, FALL_SECONDS, JUMP_SECONDS, LIFT_WAIT, LIFT_SPEED,
};
