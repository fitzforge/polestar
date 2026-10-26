//! Zone level ranges (port of tools/lib/maps/zonelevels.js zoneLevels, default options as the
//! world calls it): spawn-weighted P10..P90 of normal-rank creatures friendly to neither
//! faction, critters more than 15 levels under the median dropped.

use crate::data::{Entity, Zone};
use forge_core::{js_round, round1};
use std::collections::BTreeMap;

pub struct ZoneLevel {
	pub id: u32,
	pub min: Option<f64>,
	pub max: Option<f64>,
	pub x: f64,
	pub y: f64,
	pub weight: f64,
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
		out.insert(
			id,
			ZoneLevel {
				id,
				min: percentile(&kept, 0.1),
				max: percentile(&kept, 0.9),
				x: round1(percentile(&two(&px), 0.5).unwrap_or(f64::NAN)),
				y: round1(percentile(&two(&py), 0.5).unwrap_or(f64::NAN)),
				weight: js_round(weight),
			},
		);
	}
	out
}
