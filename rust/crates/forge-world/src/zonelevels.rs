//! Zone level ranges (port of tools/lib/maps/zonelevels.js zoneLevels, default options as the
//! world calls it): spawn-weighted P10..P90 of normal-rank creatures friendly to neither
//! faction, critters more than 15 levels under the median dropped.
//!
//! Danger floors (#1490): a zone's danger (Nav/Danger.lua, the world's travel safety, nav eval)
//! is priced from its lowest level, the P10. Where a low pocket at the zone's edge pulls the P10
//! well under the ground most walks cross, DANGER_FLOORS names the level that ground starts at;
//! the zone's range (the world map's label, the Engine's candidates) keeps its P10.

use crate::data::{Entity, Zone};
use forge_core::{js_round, round1};
use std::collections::BTreeMap;

/// (uiMapID, danger floor, why). The low-pocket sweep flags a zone whose ground (the area-weighted
/// median of 400 yd squares' own P10) sits 4 or more levels above its P10; a floor is set where the
/// client's sub-zone levels (AreaTable ExplorationLevel, lower quartile) agree and walks cross the
/// zone on the way elsewhere. Swept 2026-11-09 over every zone with a range: Alterac Mountains only
/// (Stranglethorn Vale's rise from 32 in the north is the zone's entry, not a pocket; Tirisfal Glades'
/// and Zephras Isle's matter only at levels 1-3 inside their own start zones; Moonglade's sub-zones say
/// 15, so the two sources disagree there).
pub const DANGER_FLOORS: &[(u32, f64, &str)] = &[(
	1416,
	30.0,
	"Alterac Mountains: P10 24 from the Lordamere Lake murlocs (15-19) and the bears on the Hillsbrad border (20-26); \
	 Strahnbrad, the Crushridge ogres and the Syndicate are 30-40. Ground 30, sub-zones' lower quartile 30.",
)];

pub struct ZoneLevel {
	pub id: u32,
	pub min: Option<f64>,
	pub max: Option<f64>,
	pub x: f64,
	pub y: f64,
	pub weight: f64,
	/// DANGER_FLOORS' floor, when it is above min: what zone danger prices the zone from.
	pub danger: Option<f64>,
}

impl ZoneLevel {
	/// The level zone danger prices the zone from: its danger floor, else its lowest level.
	pub fn danger_level(&self) -> Option<f64> {
		self.danger.or(self.min)
	}
}

/// Spawn-weighted percentile of [(value, weight)] sorted by value.
pub fn percentile(sorted: &[(f64, f64)], p: f64) -> Option<f64> {
	let total: f64 = sorted.iter().fold(0.0, |s, x| s + x.1);
	if total <= 0.0 {
		return None;
	}
	let mut acc = 0.0;
	for s in sorted {
		acc += s.1;
		if acc >= p * total - 1e-9 {
			return Some(s.0);
		}
	}
	sorted.last().map(|s| s.0)
}

fn by_value(v: &mut [(f64, f64, f64)]) {
	// Array.prototype.sort is stable; so is sort_by.
	v.sort_by(|a, b| (a.0 - b.0).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
}

/// -> zone id -> its range, for zones with one (sparse: maps held to the sparse thresholds).
pub fn zone_levels(npcs: &BTreeMap<u32, Entity>, zones: &BTreeMap<u32, Zone>, sparse: &[u32]) -> BTreeMap<u32, ZoneLevel> {
	let mut levels: BTreeMap<u32, Vec<(f64, f64)>> = BTreeMap::new();
	let mut xs: BTreeMap<u32, Vec<(f64, f64, f64)>> = BTreeMap::new();
	let mut ys: BTreeMap<u32, Vec<(f64, f64, f64)>> = BTreeMap::new();
	let mut all: BTreeMap<u32, f64> = BTreeMap::new();
	let mut hostile: BTreeMap<u32, f64> = BTreeMap::new();
	for npc in npcs.values() {
		let lo = npc.level.unwrap_or(0.0);
		let eligible = npc.faction.is_none() && npc.rank.is_none() && lo > 0.0;
		let lmax = npc.level_max.filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(lo);
		let hi = lo.max(lmax);
		for (&map, spawn) in &npc.spawns {
			let pts = &spawn.pts;
			if pts.is_empty() {
				continue;
			}
			*all.entry(map).or_default() += pts.len() as f64;
			if !eligible {
				continue;
			}
			*hostile.entry(map).or_default() += pts.len() as f64;
			let per = 1.0 / (hi - lo + 1.0);
			let lv = levels.entry(map).or_default();
			let mut l = lo;
			while l <= hi {
				lv.push((l, pts.len() as f64 * per));
				l += 1.0;
			}
			let mid = (lo + hi) / 2.0;
			for p in pts {
				xs.entry(map).or_default().push((p.first().copied().unwrap_or(f64::NAN), 1.0, mid));
				ys.entry(map).or_default().push((p.get(1).copied().unwrap_or(f64::NAN), 1.0, mid));
			}
		}
	}
	let mut out = BTreeMap::new();
	for (&id, zone) in zones {
		if zone.kind != Some(3.0) {
			continue;
		}
		let weight = hostile.get(&id).copied().unwrap_or(0.0);
		let share = weight / all.get(&id).copied().filter(|x| *x != 0.0).unwrap_or(1.0);
		let thin = sparse.contains(&id);
		if weight < if thin { 30.0 } else { 100.0 } || share < if thin { 0.2 } else { 0.4 } {
			continue;
		}
		let mut samples = levels.get(&id).cloned().unwrap_or_default();
		samples.sort_by(|a, b| (a.0 - b.0).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
		let median = percentile(&samples, 0.5).unwrap_or(f64::NAN);
		let floor = median - 15.0;
		let kept: Vec<(f64, f64)> = samples.into_iter().filter(|s| s.0 >= floor).collect();
		let mut px: Vec<(f64, f64, f64)> = xs.get(&id).into_iter().flatten().copied().filter(|s| s.2 >= floor).collect();
		let mut py: Vec<(f64, f64, f64)> = ys.get(&id).into_iter().flatten().copied().filter(|s| s.2 >= floor).collect();
		by_value(&mut px);
		by_value(&mut py);
		let two = |v: &[(f64, f64, f64)]| v.iter().map(|s| (s.0, s.1)).collect::<Vec<_>>();
		let min = percentile(&kept, 0.1);
		let danger = DANGER_FLOORS.iter().find(|f| f.0 == id).map(|f| f.1).filter(|f| min.is_some_and(|m| *f > m));
		out.insert(
			id,
			ZoneLevel {
				id,
				min,
				max: percentile(&kept, 0.9),
				x: round1(percentile(&two(&px), 0.5).unwrap_or(f64::NAN)),
				y: round1(percentile(&two(&py), 0.5).unwrap_or(f64::NAN)),
				weight: js_round(weight),
				danger,
			},
		);
	}
	out
}
