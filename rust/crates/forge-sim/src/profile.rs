//! Class-agnostic profiles: the route is planned for a class profile, not a class.
//!
//! - kill speed: the faction's classes' mean `classFactor` (average), or its slowest / fastest
//!   class (the shared route is scored over all three);
//! - class quests are out (the run is compiled with no class: run.js questOpen with cls null
//!   closes 1-4-class quests);
//! - class training is a stop: `train class` at the trainers of a town (a hub with
//!   TOWN_TRAINERS or more class trainers, not a starting valley), at each new even level (new
//!   ranks come at even levels: no trip for ranks not learnable yet) where the order passes
//!   within TOWN_TRAIN_YD of a town, plus v1's own class-agnostic `train class` goals; the
//!   per-level overhead keeps only vendoring and repairs (levelOverhead − trainSec /
//!   TRAIN_EVERY), since the stops price training themselves.

use crate::params::{class_factor, faction_classes, Params};
use forge_world::World;

/// Class trainers a hub needs to count as a town for `train class`.
pub const TOWN_TRAINERS: usize = 4;
/// Levels between training stops (v1's guides train every second level or so).
pub const TRAIN_EVERY: usize = 2;
/// A town this close to a stop of the order is "on the way" (decide.js TOWN_TRAIN_YD).
pub const TOWN_TRAIN_YD: f64 = 600.0;

#[derive(Clone, Debug, PartialEq)]
pub struct Profile {
	pub name: &'static str,
	pub class_factor: f64,
	pub train_stops: bool,
	/// v1's travel plan for the run (route::improve sets it from the seed).
	pub plan: Option<std::sync::Arc<crate::run::TravelPlan>>,
}

impl Profile {
	/// The gate's model: v1's evaluator as the judge runs it (classFactor prior 1, training in
	/// the per-level overhead).
	pub fn gate() -> Profile {
		Profile { name: "gate", class_factor: 1.0, train_stops: false, plan: None }
	}

	fn factors(f: forge_core::Faction) -> Vec<f64> {
		faction_classes(f).iter().filter_map(|c| class_factor(c)).collect()
	}

	pub fn average(f: forge_core::Faction) -> Profile {
		let v = Profile::factors(f);
		Profile { name: "avg", class_factor: v.iter().sum::<f64>() / v.len() as f64, train_stops: true, plan: None }
	}

	pub fn slow(f: forge_core::Faction) -> Profile {
		Profile { name: "slow", class_factor: Profile::factors(f).into_iter().fold(f64::MIN, f64::max), train_stops: true, plan: None }
	}

	pub fn fast(f: forge_core::Faction) -> Profile {
		Profile { name: "fast", class_factor: Profile::factors(f).into_iter().fold(f64::MAX, f64::min), train_stops: true, plan: None }
	}

	/// The three profiles the shared route is scored over.
	pub fn trio(f: forge_core::Faction) -> [Profile; 3] {
		[Profile::slow(f), Profile::average(f), Profile::fast(f)]
	}

	/// Parameters under this profile.
	pub fn params(&self, base: &Params) -> Params {
		let mut p = base.clone();
		p.class_factor = self.class_factor;
		if self.train_stops {
			p.feasible = true;
			p.along = true;
			p.level_overhead = (p.level_overhead - p.train_sec / TRAIN_EVERY as f64).max(0.0);
		}
		p
	}
}

/// Yards: a hub this close to a race's start point is its starting valley (Valley of Trials,
/// Northshire...): only that race trains there, and only before leaving it.
pub const VALLEY_YD: f64 = 300.0;
/// Yards from the start point past which the character has left its starting valley.
pub const LEFT_VALLEY_YD: f64 = 500.0;
/// Yards: trainer hubs this close on one map are one town (a capital's trainers stand in
/// several halls: Orgrimmar's are never TOWN_TRAINERS in one hub).
pub const TOWN_MERGE_YD: f64 = 600.0;

/// World points of the faction's towns: trainer hubs (merged within TOWN_MERGE_YD on a map)
/// with TOWN_TRAINERS or more class trainers, at the hub with the most; other races' starting
/// valleys left out. With the second list: those that are `start`'s own valley.
pub fn town_points(world: &World, start: Option<u32>) -> (Vec<u32>, Vec<u32>) {
	let classes: Vec<String> = faction_classes(world.faction).iter().map(|c| c.to_uppercase()).collect();
	let pt = |p: u32| &world.points[p as usize];
	let near = |a: u32, b: u32, yd: f64| {
		let (p, q) = (pt(a), pt(b));
		p.region == q.region && (p.wx - q.wx).hypot(p.wy - q.wy) <= yd
	};
	let hubs: Vec<(u32, Vec<&String>)> = world.hubs.iter().map(|h| (h.pt, h.trainers.iter().filter(|t| classes.contains(t)).collect::<Vec<_>>())).filter(|h| !h.1.is_empty()).collect();
	let mut v = Vec::new();
	let mut own = Vec::new();
	// A starting valley's trainers stand alone (Northshire is not part of Goldshire).
	let in_valley = |h: u32| world.starts.iter().any(|(_, st)| near(h, st.pt, VALLEY_YD));
	for (k, (p, t)) in hubs.iter().enumerate() {
		// Clusters by single linkage on a map; each cluster's town is its biggest hub.
		let mut members = vec![k];
		let alone = in_valley(*p);
		let mut i = 0;
		while i < members.len() {
			let m = hubs[members[i]].0;
			for (j, h) in hubs.iter().enumerate() {
				if !alone && !in_valley(h.0) && !members.contains(&j) && pt(h.0).map == pt(m).map && near(h.0, m, TOWN_MERGE_YD) {
					members.push(j);
				}
			}
			i += 1;
		}
		let best = members.iter().copied().max_by(|&a, &b| hubs[a].1.len().cmp(&hubs[b].1.len()).then(hubs[b].0.cmp(&hubs[a].0))).unwrap();
		if best != k {
			continue;
		}
		let mut all: Vec<&String> = members.iter().flat_map(|&m| hubs[m].1.iter().copied()).collect();
		all.sort_unstable();
		all.dedup();
		if all.len() < TOWN_TRAINERS || t.is_empty() {
			continue;
		}
		let valley_of = |st: u32| near(*p, st, VALLEY_YD);
		if world.starts.iter().any(|(_, st)| valley_of(st.pt)) {
			if start.is_some_and(valley_of) {
				own.push(*p);
				v.push(*p);
			}
			continue;
		}
		v.push(*p);
	}
	v.sort_unstable();
	v.dedup();
	(v, own)
}
