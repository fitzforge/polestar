//! The hybrid walks (`--nav hybrid`): Leffe's navigation maps first, our walking grid where his maps fall short.
//! Two walks documents of one world (the grid's and Leffe's, each built from its own store) are merged walk by
//! walk: Leffe's answer is taken when it exists and costs at most `slack` × the grid's (both cost models price a
//! yard alike: seconds × the same ground, hub and danger multipliers, ~1.02-1.05 per yard on the acceptance walks);
//! else the grid's (his maps leave some city parts unjoined, and without Leffe's lift layer beside them they have no
//! lifts, so his way there is a detour or none). Every walk records which backend answered (counts in the stats; the
//! base walks' list in `backend`).

use crate::lookup::WalksDoc;
use crate::walkdoc::Doc;
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::json;

/// Leffe's walk is kept while it costs at most this many times the grid's.
pub const SLACK: f64 = 1.2;

#[derive(Clone, Copy)]
struct W {
	yd: f64,
	cost: f64,
	/// The pair's index in its document (zone shares of base walks).
	k: usize,
	both: bool,
}

fn directed(p: &[f64]) -> FxHashMap<(u32, u32), W> {
	let mut m = FxHashMap::default();
	for (k, e) in p.chunks_exact(5).enumerate() {
		let (a, b) = (e[0] as u32, e[1] as u32);
		let w = W { yd: e[2], cost: e[3], k, both: e[4] == 0.0 };
		m.insert((a, b), w);
		if w.both {
			m.insert((b, a), w);
		}
	}
	m
}

/// Per band and backend: walks taken from the grid (`grid`), from Leffe (`leffe`); among the grid's, the fallbacks:
/// those his maps had no way for (`leffeNone`: unreachable or failed there) or a way over the slack (`leffeDetour`);
/// among his, those the grid had no way for (`gridNone`).
pub fn merge(grid: &WalksDoc, leffe: &WalksDoc, slack: f64) -> Result<(Doc, serde_json::Value), String> {
	if ["dataHash", "walksKey", "nw"].iter().any(|k| grid.header.get(*k) != leffe.header.get(*k)) {
		return Err("hybrid: the two walks documents are of different worlds".into());
	}
	let mut header = grid.header.clone();
	header.insert("router".into(), json!("hybrid"));
	header.insert("hybridSlack".into(), json!(slack));
	let mut pairs_out = Vec::new();
	let mut stats = Vec::new();
	let mut zones = (vec![0u32], Vec::new(), Vec::new());
	let mut walkable: FxHashSet<(u32, u32)> = FxHashSet::default();
	for (bi, band) in grid.bands.iter().enumerate() {
		let li = leffe.bands.iter().position(|b| b == band).ok_or(format!("hybrid: Leffe's document has no band {band}"))?;
		let (g, l) = (directed(&grid.pairs[bi]), directed(&leffe.pairs[li]));
		// Each directed walk: (from Leffe?, the walk).
		let mut keys: Vec<(u32, u32)> = g.keys().chain(l.keys()).copied().collect::<FxHashSet<_>>().into_iter().collect();
		keys.sort_unstable();
		let mut pick: FxHashMap<(u32, u32), (bool, W)> = FxHashMap::default();
		let (mut n_g, mut n_l, mut none, mut detour, mut grid_none) = (0usize, 0usize, 0usize, 0usize, 0usize);
		for k in &keys {
			let c = match (g.get(k), l.get(k)) {
				(Some(gw), Some(lw)) if lw.cost <= slack * gw.cost => (true, *lw),
				(Some(gw), Some(_)) => {
					detour += 1;
					(false, *gw)
				}
				(Some(gw), None) => {
					none += 1;
					(false, *gw)
				}
				(None, Some(lw)) => {
					grid_none += 1;
					(true, *lw)
				}
				(None, None) => unreachable!(),
			};
			if c.0 {
				n_l += 1;
			} else {
				n_g += 1;
			}
			pick.insert(*k, c);
		}
		// Emit: a pair both ways when both directions took the same both-ways walk, else each direction one-way.
		let mut out: Vec<f64> = Vec::new();
		let mut src: Vec<(bool, usize)> = Vec::new();
		for &(a, b) in &keys {
			let (fl, w) = pick[&(a, b)];
			if a > b {
				if let Some(&(rl, rw)) = pick.get(&(b, a)) {
					if rl == fl && rw.k == w.k && w.both {
						continue; // emitted from (b, a)
					}
				}
			}
			let same_back = pick.get(&(b, a)).is_some_and(|&(rl, rw)| rl == fl && rw.k == w.k && w.both);
			out.extend([a as f64, b as f64, w.yd, w.cost, if same_back { 0.0 } else { 1.0 }]);
			src.push((fl, w.k));
			if *band == 0 {
				walkable.insert((a, b));
				walkable.insert((b, a));
			}
		}
		if *band == 0 {
			for &(fl, k) in &src {
				let z = if fl { leffe.zones.as_ref() } else { grid.zones.as_ref() };
				if let Some((off, val, has)) = z {
					if has[k] != 0 {
						zones.1.extend_from_slice(&val[off[k] as usize..off[k + 1] as usize]);
						zones.2.push(1);
					} else {
						zones.2.push(0);
					}
				} else {
					zones.2.push(0);
				}
				zones.0.push(zones.1.len() as u32);
			}
		}
		stats.push(json!({"band": band, "walks": keys.len(), "grid": n_g, "leffe": n_l, "leffeNone": none, "leffeDetour": detour, "gridNone": grid_none}));
		pairs_out.push((*band, out));
	}
	// Unwalkable: either document's, where the merged base holds no walk.
	let mut unwalkable = Vec::new();
	let mut seen = FxHashSet::default();
	for u in grid.unwalkable.chunks_exact(2).chain(leffe.unwalkable.chunks_exact(2)) {
		let k = (u[0].min(u[1]), u[0].max(u[1]));
		if !walkable.contains(&(u[0] as u32, u[1] as u32)) && seen.insert(k) {
			unwalkable.extend([u[0], u[1]]);
		}
	}
	Ok((Doc { header, pairs: pairs_out, unwalkable, zones }, json!({ "slack": slack, "bands": stats })))
}

/// One log line per band of merge's stats: where the merged walks came from and how many fell back to the grid.
pub fn summary(stats: &serde_json::Value) -> Vec<String> {
	let n = |b: &serde_json::Value, k: &str| b[k].as_u64().unwrap_or(0);
	stats["bands"]
		.as_array()
		.map(|bands| {
			bands
				.iter()
				.map(|b| {
					format!(
						"hybrid band {}: {} walks, {} on Leffe's maps, {} on the grid ({} grid fallbacks: Leffe had no way for {}, a detour over {}x for {}); {} on Leffe's maps only",
						n(b, "band"),
						n(b, "walks"),
						n(b, "leffe"),
						n(b, "grid"),
						n(b, "leffeNone") + n(b, "leffeDetour"),
						n(b, "leffeNone"),
						stats["slack"].as_f64().unwrap_or(SLACK),
						n(b, "leffeDetour"),
						n(b, "gridNone")
					)
				})
				.collect()
		})
		.unwrap_or_default()
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::Map;

	fn doc(router: &str, pairs: &[[f64; 5]], unwalkable: &[i32]) -> WalksDoc {
		let mut header = Map::new();
		header.insert("router".into(), json!(router));
		header.insert("dataHash".into(), json!("w"));
		header.insert("nw".into(), json!(4));
		WalksDoc { header, bands: vec![0], pairs: vec![pairs.iter().flatten().copied().collect()], lookup: vec![None], unwalkable: unwalkable.to_vec(), zones: None }
	}

	/// A pair Leffe's maps cannot reach (unreachable there, the grid walks it) keeps the grid's walk and is not
	/// unwalkable; his way is kept where he has one within the slack; the fallbacks are counted and logged.
	#[test]
	fn unreachable_on_leffe_falls_back_to_the_grid() {
		// 0-1: both, Leffe cheaper. 1-2: the grid only (Leffe lists it unwalkable). 2-3: Leffe a detour. 0-3: Leffe only.
		let grid = doc("grid", &[[0.0, 1.0, 100.0, 100.0, 0.0], [1.0, 2.0, 200.0, 220.0, 0.0], [2.0, 3.0, 50.0, 50.0, 0.0]], &[]);
		let leffe = doc("leffe", &[[0.0, 1.0, 95.0, 90.0, 0.0], [2.0, 3.0, 90.0, 90.0, 0.0], [0.0, 3.0, 300.0, 300.0, 0.0]], &[1, 2]);
		let (merged, stats) = merge(&grid, &leffe, SLACK).unwrap();
		let p = &merged.pairs[0].1;
		let walk = |a: f64, b: f64| p.chunks_exact(5).find(|e| (e[0], e[1]) == (a, b) || (e[0], e[1]) == (b, a) && e[4] == 0.0).map(|e| (e[2], e[3]));
		assert_eq!(walk(1.0, 2.0), Some((200.0, 220.0)), "Leffe's unreachable pair takes the grid's walk");
		assert_eq!(walk(0.0, 1.0), Some((95.0, 90.0)), "Leffe's way where he has one");
		assert_eq!(walk(2.0, 3.0), Some((50.0, 50.0)), "a detour over the slack takes the grid's");
		assert_eq!(walk(0.0, 3.0), Some((300.0, 300.0)), "a pair only Leffe walks");
		assert!(merged.unwalkable.is_empty(), "the grid walks 1-2: not unwalkable ({:?})", merged.unwalkable);
		let b = &stats["bands"][0];
		assert_eq!((b["leffeNone"].as_u64(), b["leffeDetour"].as_u64(), b["gridNone"].as_u64()), (Some(2), Some(2), Some(2)), "{b}");
		let lines = summary(&stats);
		assert_eq!(lines.len(), 1);
		assert!(lines[0].contains("4 grid fallbacks: Leffe had no way for 2"), "{}", lines[0]);
	}
}
