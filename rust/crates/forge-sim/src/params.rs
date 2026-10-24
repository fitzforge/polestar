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
	("transportWait", 1.0),
	("hearthCast", 10.0),
	("hearthCooldown", 3600.0),
	("levelOverhead", 60.0),
	("grindEff", 0.7),
	("grindWeight", 2.5),
	("zoneChange", 450.0),
	("zoneReturn", 0.0),
	("spotReturn", 0.0),
	("wastedAccept", 0.0),
	("gateGap", 2.0),
	("dangerGap", 5.0),
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
];

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
	pub transport_wait: f64,
	pub hearth_cast: f64,
	pub hearth_cooldown: f64,
	pub level_overhead: f64,
	pub grind_eff: f64,
	pub grind_weight: f64,
	pub zone_change: f64,
	pub zone_return: f64,
	pub spot_return: f64,
	pub wasted_accept: f64,
	pub gate_gap: f64,
	pub danger_gap: f64,
	pub death_risk: f64,
	pub rested_share: f64,
	pub train_sec: f64,
	pub vendor_sec: f64,
	pub camps: bool,
	pub spots: bool,
	pub feasible: bool,
	/// Along credit: kills of open quests' kill objectives on walks that pass their site.
	pub along: bool,
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
			transport_wait: get("transportWait"),
			hearth_cast: get("hearthCast"),
			hearth_cooldown: get("hearthCooldown"),
			level_overhead: get("levelOverhead"),
			grind_eff: get("grindEff"),
			grind_weight: get("grindWeight"),
			zone_change: get("zoneChange"),
			zone_return: get("zoneReturn"),
			spot_return: get("spotReturn"),
			wasted_accept: get("wastedAccept"),
			gate_gap: get("gateGap"),
			danger_gap: get("dangerGap"),
			death_risk: get("deathRisk"),
			rested_share: get("restedShare"),
			train_sec: get("trainSec"),
			vendor_sec: get("vendorSec"),
			camps: get("camps") > 0.0,
			spots: get("spots") > 0.0,
			feasible: get("feasible") > 0.0,
			along: get("along") > 0.0,
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
