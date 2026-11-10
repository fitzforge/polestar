//! Where a quest objective is done, from the spots its line ticked (`progress` records), learned per
//! player first and combined across players (docs/forge/learn.md "Objective spots"):
//!
//! 1. each voter's tick points (yards, per map) are linked into clusters ([`LINK_YD`]); a cluster
//!    stands for that voter as the median of its points;
//! 2. a voter's cluster more than [`NOISE_YD`] from every other voter's is noise (once three or more
//!    voters ticked the line);
//! 3. the voters' clusters are linked across voters ([`LINK_YD`]); in each spot, a voter more than
//!    max([`OUTLIER_MIN_YD`], 3 × MAD) from the voters' median is set aside, and the spot is the
//!    median of the remaining voters' medians, its radius the 80th percentile distance of their
//!    points;
//! 4. a spot only one voter backs is dropped when another spot has three or more.

use rustc_hash::{FxHashMap, FxHashSet};

/// Points (and voters' clusters) this close are one cluster.
pub const LINK_YD: f64 = 60.0;
/// A voter's cluster this far from every other voter's is noise.
pub const NOISE_YD: f64 = 200.0;
/// The least distance from the voters' median that sets a voter aside (else 3 × MAD).
pub const OUTLIER_MIN_YD: f64 = 40.0;

/// One tick point, in yards on its map.
#[derive(Clone, Copy, Debug)]
pub struct Pt {
	pub voter: usize,
	pub map: i64,
	pub x: f64,
	pub y: f64,
}

/// A learned spot: its centre (yards), radius (yards) and the voters behind it (ascending).
#[derive(Clone, Debug)]
pub struct Spot {
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub r: f64,
	pub voters: Vec<usize>,
}

pub struct Spots {
	pub spots: Vec<Spot>,
	/// Voters whose every point was set aside (noise or outliers): they disagree.
	pub outliers: FxHashSet<usize>,
}

fn dist(a: (f64, f64), b: (f64, f64)) -> f64 {
	(a.0 - b.0).hypot(a.1 - b.1)
}

fn median(v: Vec<f64>) -> f64 {
	crate::recordings::median(v)
}

fn centre(points: &[(f64, f64)]) -> (f64, f64) {
	(median(points.iter().map(|p| p.0).collect()), median(points.iter().map(|p| p.1).collect()))
}

/// Single-linkage components of `points` within `radius`: a component index per point.
fn components(points: &[(f64, f64)], radius: f64) -> Vec<usize> {
	let n = points.len();
	let mut parent: Vec<usize> = (0..n).collect();
	fn find(p: &mut [usize], mut i: usize) -> usize {
		while p[i] != i {
			p[i] = p[p[i]];
			i = p[i];
		}
		i
	}
	for i in 0..n {
		for j in (i + 1)..n {
			if dist(points[i], points[j]) <= radius {
				let (a, b) = (find(&mut parent, i), find(&mut parent, j));
				if a != b {
					parent[a.max(b)] = a.min(b);
				}
			}
		}
	}
	let mut ids: FxHashMap<usize, usize> = FxHashMap::default();
	(0..n)
		.map(|i| {
			let r = find(&mut parent, i);
			let k = ids.len();
			*ids.entry(r).or_insert(k)
		})
		.collect()
}

/// A voter's cluster: its median and its points.
struct VCluster {
	voter: usize,
	map: i64,
	at: (f64, f64),
	points: Vec<(f64, f64)>,
}

/// The 80th percentile of `d` (nearest rank).
fn p80(mut d: Vec<f64>) -> f64 {
	if d.is_empty() {
		return 0.0;
	}
	d.sort_by(f64::total_cmp);
	let k = ((d.len() as f64) * 0.8).ceil() as usize;
	d[k.clamp(1, d.len()) - 1]
}

/// The spots of one objective line from its tick points (module doc).
pub fn locate(points: &[Pt]) -> Spots {
	// 1. Per voter and map, its clusters.
	let mut by: FxHashMap<(usize, i64), Vec<(f64, f64)>> = FxHashMap::default();
	for p in points {
		by.entry((p.voter, p.map)).or_default().push((p.x, p.y));
	}
	let mut keys: Vec<(usize, i64)> = by.keys().copied().collect();
	keys.sort_unstable();
	let mut vcs: Vec<VCluster> = Vec::new();
	for k in keys {
		let pts = &by[&k];
		let comp = components(pts, LINK_YD);
		let n = comp.iter().max().map_or(0, |m| m + 1);
		for c in 0..n {
			let mine: Vec<(f64, f64)> = pts.iter().zip(&comp).filter(|(_, x)| **x == c).map(|(p, _)| *p).collect();
			vcs.push(VCluster { voter: k.0, map: k.1, at: centre(&mine), points: mine });
		}
	}
	// Voters with a point set aside (noise or outlier).
	let mut aside: FxHashSet<usize> = FxHashSet::default();
	// 2. Noise: far from every other voter's cluster (with three voters or more: of two far apart,
	// neither is the odd one).
	let many = vcs.iter().map(|v| v.voter).collect::<FxHashSet<usize>>().len() >= 3;
	let keep: Vec<bool> = vcs.iter().map(|v| !many || vcs.iter().any(|o| o.voter != v.voter && o.map == v.map && dist(o.at, v.at) <= NOISE_YD)).collect();
	for (v, k) in vcs.iter().zip(&keep) {
		if !k {
			aside.insert(v.voter);
		}
	}
	let vcs: Vec<VCluster> = vcs.into_iter().zip(keep).filter(|(_, k)| *k).map(|(v, _)| v).collect();
	// 3. Spots across voters, per map.
	let mut maps: Vec<i64> = vcs.iter().map(|v| v.map).collect();
	maps.sort_unstable();
	maps.dedup();
	let mut spots: Vec<Spot> = Vec::new();
	for m in maps {
		let on: Vec<&VCluster> = vcs.iter().filter(|v| v.map == m).collect();
		let comp = components(&on.iter().map(|v| v.at).collect::<Vec<_>>(), LINK_YD);
		let n = comp.iter().max().map_or(0, |x| x + 1);
		for c in 0..n {
			// Each voter once: the median of its points in this spot.
			let mut pts: FxHashMap<usize, Vec<(f64, f64)>> = FxHashMap::default();
			for (v, _) in on.iter().zip(&comp).filter(|(_, x)| **x == c) {
				pts.entry(v.voter).or_default().extend(&v.points);
			}
			let mut voters: Vec<usize> = pts.keys().copied().collect();
			voters.sort_unstable();
			let at_of = |v: &usize| centre(&pts[v]);
			let mid = centre(&voters.iter().map(at_of).collect::<Vec<_>>());
			let d: Vec<f64> = voters.iter().map(|v| dist(at_of(v), mid)).collect();
			let limit = OUTLIER_MIN_YD.max(3.0 * median(d.clone()));
			let kept: Vec<usize> = voters.iter().zip(&d).filter(|(_, d)| **d <= limit).map(|(v, _)| *v).collect();
			aside.extend(voters.iter().filter(|v| !kept.contains(v)));
			if kept.is_empty() {
				continue;
			}
			let mid = centre(&kept.iter().map(at_of).collect::<Vec<_>>());
			let r = p80(kept.iter().flat_map(|v| pts[v].iter().map(|p| dist(*p, mid))).collect());
			spots.push(Spot { map: m, x: mid.0, y: mid.1, r, voters: kept });
		}
	}
	// 4. Single-voter spots go when one has three voters or more.
	let mut single: FxHashSet<usize> = FxHashSet::default();
	if spots.iter().any(|s| s.voters.len() >= 3) {
		single.extend(spots.iter().filter(|s| s.voters.len() == 1).map(|s| s.voters[0]));
		spots.retain(|s| s.voters.len() > 1);
	}
	spots.sort_by(|a, b| b.voters.len().cmp(&a.voters.len()).then(a.map.cmp(&b.map)).then(a.x.total_cmp(&b.x)).then(a.y.total_cmp(&b.y)));
	let kept: FxHashSet<usize> = spots.iter().flat_map(|s| s.voters.iter().copied()).collect();
	// A voter whose own spot went in step 4 ticked somewhere else: not a disagreement.
	let outliers = aside.into_iter().filter(|v| !kept.contains(v) && !single.contains(v)).collect();
	Spots { spots, outliers }
}
