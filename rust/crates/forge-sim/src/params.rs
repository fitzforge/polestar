//! Model parameters: port of tools/lib/sim/params.js (PRIORS means, CLASS_FACTOR, OBJECTIVES,
//! `effective` + `means`) for what the evaluator reads. `data/sim/params.json`'s calibrated
//! means replace the priors' (only questEstScale and questXpScale are fitted today).

use serde_json::Value;

/// Prior means of params.js PRIORS (name, mean). Only the mean matters for a deterministic run.
pub const PRIORS: &[(&str, f64)] = &[
	("runSpeed", 7.0),
	("mountLevel", 40.0),
	("mountMul", 1.6),
	("detour0", 1.35),
	("detour1", 1.3),
	("routeMul", 1.0),
	("killSec1", 11.0),
	("killSec60", 30.0),
	("killUp", 0.1),
	("killDown", 0.05),
	("eliteTime", 3.5),
	("classFactor", 1.0),
	("spacing", 1.0),
	("talkSec", 6.0),
	("interactSec", 8.0),
	("escortSec", 240.0),
	("dropMul", 1.0),
	("extraKill", 0.043),
	("questXpScale", 1.0),
	("questEstScale", 1.0),
	("flightOverhead", 20.0),
	// Taxi speed, yd/s (the world's taxi edges are path yards): 4 flights recorded in game (the
	// addon's learned flight times, boarding to landing) give 29.9 yd/s, each within 1 s
	// (model.md).
	("flightSpeed", 30.0),
	("transportWait", 1.0),
	("hearthCast", 10.0),
	("hearthCooldown", 3600.0),
	// Route profiles: a cast waits hearthCooldown × (1 + hearthMargin) after the last (F58: forge judge
	// check times the written guide on straight legs, its gaps 52-55 min where the route's were 60).
	("hearthMargin", 0.25),
	("levelOverhead", 60.0),
	("grindEff", 0.7),
	("grindWeight", 2.5),
	("zoneChange", 450.0),
	("zoneReturn", 0.0),
	("spotReturn", 0.0),
	("wastedAccept", 0.0),
	("gateGap", 2.0),
	("dangerGap", 5.0),
	// Most levels the mobs of kill work may be above the character (A7, A8: Khan Dez'hepah worked at
	// 30, the lvl-26 Lieutenant Fangore at 21 are not solo-safe): further under, the route grinds up
	// first. The route profiles only (feasible); the gate's model keeps v1's.
	("workGap", 3.0),
	("deathRisk", 300.0),
	("restedShare", 0.0),
	("trainSec", 60.0),
	("vendorSec", 60.0),
	// Fidelity terms beyond v1 (0 = v1's model, 1 = on): kill work at its camps (spawns,
	// respawn, spacing, mob level, drop chance per camp), and objective spots chosen on the way.
	("camps", 0.0),
	("spots", 0.0),
	// Feasibility rules beyond v1 (1 = on; the route profiles turn them on, the gate's model and
	// parity keep v1's): an escort is walked from its giver to its end, and a timed quest's legs
	// are walked (no hearth, flight or boat while it runs).
	("feasible", 0.0),
	("along", 0.0),
	("pool", 0.0),
	// Hearths the route chooses (1 = on, the route profiles only): see eval FREE_HEARTH_GAIN_SEC.
	("freeHearth", 1.0),
	// Tauren's racial Plainsrunning (1 = on; model_for turns it on for Tauren route profiles): on
	// foot out of combat, +1% run speed every 5 s to +30% (plainsrunning_sec).
	("plainsrunning", 0.0),
	// Deathskips (1 = on: `--deathskips`, off by default; the route profiles only): a leg may die near
	// where it starts and go on from the graveyard the game resurrects at (eval DEATHSKIP_GAIN_SEC).
	// deathskipSec: being killed, releasing and the Spirit Healer, an estimate (~30 s pulling mobs to
	// die to, ~30 s the healer). deathskipLevel: the highest level a route deathskips at, Forever's
	// last without resurrection sickness (Polestar's death helper, QoL/Death.lua: none through 10,
	// then 600 s); above it each second of sickness costs sicknessSlow seconds (the debuff slows
	// kills; walking, flights and talks lose nothing).
	("deathskips", 0.0),
	("deathskipSec", 60.0),
	("deathskipLevel", 10.0),
	("sicknessSlow", 0.5),
];

/// Plainsrunning (the game's data: spell 1259918, a 1 s periodic trigger with values 5 and 30, its
/// stacking speed aura 1299038 +1% per stack; Fitz's recorded trails on a Tauren, 2026-10-23: the
/// run speed climbs from 7.00 by 0.07 every 5.0 s (median of 109 steps; the first after 4-5 s) to
/// 9.10, and is back at 7.00 after standing still): seconds per stack, speed per stack, stacks.
pub const PLAINS_STEP_SEC: f64 = 5.0;
pub const PLAINS_STACK: f64 = 0.01;
pub const PLAINS_STACKS: f64 = 30.0;

/// Seconds of an on-foot walk that takes `base` seconds at the run speed, for a character whose
/// speed climbs with Plainsrunning from the start of the walk (each walk starts at no stack: a stop
/// at a quest giver, a fight or a lift resets it).
pub fn plainsrunning_sec(base: f64) -> f64 {
	if base <= 0.0 || !base.is_finite() {
		return base;
	}
	// Run-speed seconds covered by the end of stack k: d(k) = step * (k + stack * k (k - 1) / 2).
	let (st, a) = (PLAINS_STEP_SEC, PLAINS_STACK);
	let d = |k: f64| st * (k + a * k * (k - 1.0) / 2.0);
	// The last whole stack reached: d(k) <= base, k <= stacks.
	let qa = st * a / 2.0;
	let qb = st * (1.0 - a / 2.0);
	let k = ((-qb + (qb * qb + 4.0 * qa * base).sqrt()) / (2.0 * qa)).floor().clamp(0.0, PLAINS_STACKS);
	let k = if d(k + 1.0) <= base && k < PLAINS_STACKS { k + 1.0 } else { k };
	st * k + (base - d(k)) / (1.0 + a * k)
}

/// Kill-speed priors by class (params.js CLASS_FACTOR; lower is faster).
pub const CLASS_FACTOR: &[(&str, f64)] = &[("Warrior", 1.15), ("Paladin", 1.1), ("Hunter", 0.8), ("Rogue", 1.0), ("Priest", 1.05), ("Shaman", 1.0), ("Mage", 0.9), ("Warlock", 0.85), ("Druid", 1.0)];

/// The evaluator's parameters (params.js `means(effective(...))`).
#[derive(Clone, Debug, PartialEq)]
pub struct Params {
	pub run_speed: f64,
	pub mount_level: f64,
	pub mount_mul: f64,
	pub detour0: f64,
	pub detour1: f64,
	pub route_mul: f64,
	pub kill_sec1: f64,
	pub kill_sec60: f64,
	pub kill_up: f64,
	pub kill_down: f64,
	pub elite_time: f64,
	pub class_factor: f64,
	pub spacing: f64,
	pub talk_sec: f64,
	pub interact_sec: f64,
	pub escort_sec: f64,
	pub drop_mul: f64,
	pub extra_kill: f64,
	pub quest_xp_scale: f64,
	pub quest_est_scale: f64,
	pub flight_overhead: f64,
	/// Taxi speed, yd/s.
	pub flight_speed: f64,
	pub transport_wait: f64,
	pub hearth_cast: f64,
	pub hearth_cooldown: f64,
	pub hearth_margin: f64,
	pub level_overhead: f64,
	pub grind_eff: f64,
	pub grind_weight: f64,
	pub zone_change: f64,
	pub zone_return: f64,
	pub spot_return: f64,
	pub wasted_accept: f64,
	pub gate_gap: f64,
	pub danger_gap: f64,
	pub work_gap: f64,
	pub death_risk: f64,
	pub rested_share: f64,
	pub train_sec: f64,
	pub vendor_sec: f64,
	pub camps: bool,
	pub spots: bool,
	pub feasible: bool,
	/// Along credit: kills of open quests' kill objectives on walks that pass their site.
	pub along: bool,
	/// Pooled kills: other open objectives' mobs met at a kill work's overlapping ground (pool).
	pub pool: bool,
	/// Hearths the route chooses where no v1 hearth line is (route profiles).
	pub free_hearth: bool,
	/// Tauren's Plainsrunning on walks on foot (plainsrunning_sec).
	pub plainsrunning: bool,
	/// Deathskips (eval Evaluator::deathskip).
	pub deathskips: bool,
	pub deathskip_sec: f64,
	pub deathskip_level: f64,
	pub sickness_slow: f64,
}

impl Params {
	/// From name -> value pairs (unknown names ignored, missing ones the prior).
	pub fn from_pairs(pairs: &[(String, f64)]) -> Params {
		let get = |k: &str| pairs.iter().rev().find(|(n, _)| n == k).map(|(_, v)| *v).or_else(|| PRIORS.iter().find(|(n, _)| *n == k).map(|(_, v)| *v)).unwrap_or(0.0);
		Params {
			run_speed: get("runSpeed"),
			mount_level: get("mountLevel"),
			mount_mul: get("mountMul"),
			detour0: get("detour0"),
			detour1: get("detour1"),
			route_mul: get("routeMul"),
			kill_sec1: get("killSec1"),
			kill_sec60: get("killSec60"),
			kill_up: get("killUp"),
			kill_down: get("killDown"),
			elite_time: get("eliteTime"),
			class_factor: get("classFactor"),
			spacing: get("spacing"),
			talk_sec: get("talkSec"),
			interact_sec: get("interactSec"),
			escort_sec: get("escortSec"),
			drop_mul: get("dropMul"),
			extra_kill: get("extraKill"),
			quest_xp_scale: get("questXpScale"),
			quest_est_scale: get("questEstScale"),
			flight_overhead: get("flightOverhead"),
			flight_speed: get("flightSpeed"),
			transport_wait: get("transportWait"),
			hearth_cast: get("hearthCast"),
			hearth_cooldown: get("hearthCooldown"),
			hearth_margin: get("hearthMargin"),
			level_overhead: get("levelOverhead"),
			grind_eff: get("grindEff"),
			grind_weight: get("grindWeight"),
			zone_change: get("zoneChange"),
			zone_return: get("zoneReturn"),
			spot_return: get("spotReturn"),
			wasted_accept: get("wastedAccept"),
			gate_gap: get("gateGap"),
			danger_gap: get("dangerGap"),
			work_gap: get("workGap"),
			death_risk: get("deathRisk"),
			rested_share: get("restedShare"),
			train_sec: get("trainSec"),
			vendor_sec: get("vendorSec"),
			camps: get("camps") > 0.0,
			spots: get("spots") > 0.0,
			feasible: get("feasible") > 0.0,
			along: get("along") > 0.0,
			pool: get("pool") > 0.0,
			free_hearth: get("freeHearth") > 0.0,
			plainsrunning: get("plainsrunning") > 0.0,
			deathskips: get("deathskips") > 0.0,
			deathskip_sec: get("deathskipSec"),
			deathskip_level: get("deathskipLevel"),
			sickness_slow: get("sicknessSlow"),
		}
	}

	/// params.js `means(effective(doc, cls, 'time', overrides))`: the priors, the calibrated
	/// means of a params.json document, the class's kill factor, then the overrides.
	pub fn effective(doc: Option<&Value>, cls: Option<&str>, overrides: &[(String, f64)]) -> Params {
		let mut pairs: Vec<(String, f64)> = PRIORS.iter().map(|(k, v)| (k.to_string(), *v)).collect();
		if let Some(cal) = doc.and_then(|d| d.get("calibrated")).and_then(Value::as_object) {
			for (k, v) in cal {
				if let Some(m) = v.get("mean").and_then(Value::as_f64).filter(|m| m.is_finite()) {
					pairs.push((k.clone(), m));
				}
			}
		}
		if let Some(f) = cls.and_then(class_factor) {
			pairs.push(("classFactor".into(), f));
		}
		pairs.extend(overrides.iter().cloned());
		Params::from_pairs(&pairs)
	}

	/// The walking detour of a continent (run.js makeTables `detour`).
	#[inline]
	pub fn detour(&self, c: i64) -> f64 {
		match c {
			0 => self.detour0,
			1 => self.detour1,
			_ => (self.detour0 + self.detour1) / 2.0,
		}
	}
}

/// A class's kill factor (title case or any case).
pub fn class_factor(cls: &str) -> Option<f64> {
	CLASS_FACTOR.iter().find(|(c, _)| c.eq_ignore_ascii_case(cls)).map(|(_, f)| *f)
}

/// Classes a faction plays in Forever (for the class-agnostic profiles).
pub fn faction_classes(faction: forge_core::Faction) -> &'static [&'static str] {
	match faction {
		forge_core::Faction::Horde => &["Warrior", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"],
		_ => &["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Mage", "Warlock", "Druid"],
	}
}

/// The spread of params.js PRIORS for the time parameters the evaluator reads: (name, sd, lo,
/// hi). Policy parameters, levels and the class factor (the profiles set it) are not drawn.
pub const SPREAD: &[(&str, f64, f64, f64)] = &[
	("runSpeed", 0.15, 6.5, 7.5),
	("detour0", 0.12, 1.05, 2.0),
	("detour1", 0.12, 1.05, 2.0),
	("routeMul", 0.05, 0.9, 1.3),
	("killSec1", 3.0, 6.0, 30.0),
	("killSec60", 6.0, 15.0, 60.0),
	("killUp", 0.04, 0.0, 0.3),
	("killDown", 0.02, 0.0, 0.12),
	("eliteTime", 1.0, 1.5, 8.0),
	("spacing", 0.25, 0.4, 2.5),
	("talkSec", 2.0, 2.0, 15.0),
	("interactSec", 3.0, 2.0, 25.0),
	("escortSec", 90.0, 60.0, 600.0),
	("dropMul", 0.2, 0.5, 2.0),
	("extraKill", 0.038, 0.0, 0.8),
	("questXpScale", 0.1, 0.5, 1.5),
	("questEstScale", 0.12, 0.5, 1.6),
	("flightOverhead", 8.0, 5.0, 60.0),
	("transportWait", 0.3, 0.3, 2.0),
	("levelOverhead", 40.0, 0.0, 300.0),
	("grindEff", 0.12, 0.35, 1.1),
	("deathRisk", 150.0, 0.0, 1200.0),
];

/// A set of parameter draws: per draw, the values that differ from the mean (params.js
/// `sample`: normal around the mean, truncated to the bounds; calibrated mean/sd where
/// params.json has them). Deterministic for the seed; libm, so native and wasm agree.
pub fn draws(doc: Option<&Value>, k: usize, seed: u64) -> Vec<Vec<(String, f64)>> {
	let cal = doc.and_then(|d| d.get("calibrated")).and_then(Value::as_object);
	let mut rng = crate::rng::Rng::new(seed);
	(0..k)
		.map(|_| {
			SPREAD
				.iter()
				.map(|&(name, sd0, lo, hi)| {
					let prior = PRIORS.iter().find(|(n, _)| *n == name).map_or(0.0, |x| x.1);
					let c = cal.and_then(|c| c.get(name));
					let mean = c.and_then(|c| c.get("mean")).and_then(Value::as_f64).unwrap_or(prior);
					let sd = c.and_then(|c| c.get("sd")).and_then(Value::as_f64).unwrap_or(sd0);
					(name.to_string(), (mean + sd * rng.normal()).clamp(lo, hi))
				})
				.collect()
		})
		.collect()
}

/// Sampled parameter sets from a JSON file: an array of {name: value} objects (e.g. a
/// calibration's posterior draws).
pub fn draws_from_json(v: &Value) -> Vec<Vec<(String, f64)>> {
	v.as_array().into_iter().flatten().filter_map(Value::as_object).map(|o| o.iter().filter_map(|(k, x)| x.as_f64().map(|x| (k.clone(), x))).collect()).collect()
}
