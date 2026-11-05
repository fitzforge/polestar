//! Walks parity: forge-nav's router (Rust legs + the coarse search with danger priced on the
//! fly) against the JS router's Horde tables (router.js distanceRows through walktables.js
//! routerWalks: base band and band 10, one row per search) on the asks. Costs (seconds × run,
//! rounded to 0.1 as the tables store them) equal; yards within the router port's tolerance (1 yd or 1 %); same
//! walkable set; base cells close; each band row's danger table is router.js dangerOf over the
//! ends' zones. Golden: rust/tests/golden/nav-walks (asks.js's asks-<band>.{bin,json}, ends.json,
//! areazones.json, walktable/<key>.bin) on the grid of nav-grid; POLESTAR_REF reads the old local
//! references (tests/common/mod.rs).
//! ROWS=<n per band> (default 300) cargo test --release -p forge-nav --test walks_parity -- --nocapture

mod common;

use forge_nav::cost::{Area, Ground, Profile, Zones};
use forge_nav::grid::Grid;
use forge_nav::legs::SnapAsk;
use forge_nav::psbn::Bin;
use forge_nav::walker::{hubs_file, Row, Walker};
use serde_json::Value;
use std::sync::Arc;
use std::time::Instant;

fn i32_at(b: &[u8], o: usize) -> i32 {
	i32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}

fn round1(v: f64) -> f64 {
	forge_core::jsnum::round1(v)
}

#[test]
fn walks_match_router_tables() {
	let refs = common::refs();
	let dir = refs.grid.clone();
	let az: Value = serde_json::from_slice(&refs.areazones()).unwrap();
	let ends: Value = serde_json::from_slice(&refs.ends()).unwrap();
	let ends = ends["ends"].as_array().unwrap();
	let grid = Arc::new(Grid::open(&dir, 1536).unwrap());
	let roads_tag = az["groundKey"].as_str().unwrap().split('|').nth(1).unwrap().to_string();
	let ground = Arc::new(Ground::load(&dir, &roads_tag, &[0, 1], std::fs::read(hubs_file(&dir)).ok().as_deref()).unwrap());
	assert_eq!(Profile::walk(Some("Horde"), ground.clone(), None).ground_key, az["groundKey"].as_str().unwrap(), "groundKey");
	let zones = Arc::new(Zones {
		of_area: az["zones"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_u64().unwrap() as u16)).collect(),
		tag: az["tag"].as_str().unwrap().into(),
		grids: Vec::new(),
	});
	let mut walker = Walker::new(grid.clone());
	walker.use_cch = std::env::var("CCH").map(|v| v != "0").unwrap_or(true);
	let per_band: usize = std::env::var("ROWS").ok().and_then(|v| v.parse().ok()).unwrap_or(300);
	let ask_of = |pt: usize, full: bool| {
		let e = &ends[pt];
		SnapAsk {
			c: e[0].as_u64().unwrap() as u32,
			wx: e[1].as_f64().unwrap(),
			wy: e[2].as_f64().unwrap(),
			z: if full { e[4].as_f64() } else { e[3].as_f64() },
			radius: 20.0,
			under: true,
			stand: true,
		}
	};
	let pool = rayon::ThreadPoolBuilder::new().num_threads(3).build().unwrap();
	let mut fails = Vec::new();
	for band in [0usize, 10] {
		let meta: Value = serde_json::from_slice(&refs.asks_json(band)).unwrap();
		let n = meta["n"].as_u64().unwrap() as usize;
		let raw = refs.asks_bin(band);
		let col = |k: usize| (0..n).map(|i| i32_at(&raw, 4 * (k * n + i))).collect::<Vec<i32>>();
		let (src, dst, dk) = (col(0), col(1), col(2));
		let t = refs.table(meta["key"].as_str().unwrap());
		let t = Bin::parse(&t[..]).unwrap();
		let (ty, tc) = (t.f64s("y").unwrap(), t.f64s("c").unwrap());
		let (txoff, tx) = (t.u32s("xoff").unwrap(), t.f32s("x").unwrap());
		// Rows: runs of pairs with one source and one danger table.
		let mut rows: Vec<(usize, usize)> = Vec::new();
		let mut i = 0;
		while i < n {
			let mut j = i + 1;
			while j < n && src[j] == src[i] && dk[j] == dk[i] {
				j += 1;
			}
			rows.push((i, j));
			i = j;
		}
		// ONLY_C: the rows of one continent alone (profiling).
		if let Some(c) = std::env::var("ONLY_C").ok().and_then(|v| v.parse::<u64>().ok()) {
			rows.retain(|r| ends[src[r.0] as usize][0].as_u64() == Some(c));
		}
		// A fixed sample of rows, spread over the table.
		let step = (rows.len() / per_band).max(1);
		let sample: Vec<(usize, usize)> = rows.iter().step_by(step).take(per_band).copied().collect();
		let pairs: usize = sample.iter().map(|r| r.1 - r.0).sum();
		// Each sampled band row's danger table is router.js dangerOf over the ends' zones (zoneAt).
		let mut danger_rule_differs = 0;
		if band != 0 {
			let world: Value = serde_json::from_slice(&refs.world("horde")).unwrap();
			let zone_mins: Vec<(u16, f64)> = world["zoneMin"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect();
			for &(a, _) in &sample {
				let (s, t) = (ask_of(src[a] as usize, false), ask_of(dst[a] as usize, false));
				let d = forge_nav::cost::danger_of(band as f64, &zone_mins, walker.zone_at(&zones, s.c, s.wx, s.wy), walker.zone_at(&zones, t.c, t.wx, t.wy));
				let want: Vec<(u16, f64)> = meta["dangers"][dk[a] as usize]
					.as_object()
					.map(|o| {
						let mut v: Vec<(u16, f64)> = o.iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect();
						v.sort_by_key(|x| x.0);
						v
					})
					.unwrap_or_default();
				if d != want {
					danger_rule_differs += 1;
				}
			}
			println!("band {band}: dangerOf over zoneAt differs from the table's danger on {danger_rule_differs} of {} rows", sample.len());
		}
		// Group by danger table: one profile each.
		let mut by_dk: std::collections::BTreeMap<i32, Vec<(usize, usize)>> = Default::default();
		for r in &sample {
			by_dk.entry(dk[r.0]).or_default().push(*r);
		}
		let t0 = Instant::now();
		let mut got: Vec<(usize, f64, f64, Option<Vec<(u32, f64)>>)> = Vec::new();
		let mut retried_full = 0;
		let mut stats_all = Vec::new();
		let mut slot_of: std::collections::HashMap<usize, usize> = Default::default();
		let chunk: usize = std::env::var("CHUNK").ok().and_then(|v| v.parse().ok()).unwrap_or(3000);
		for (d, all_rs) in &by_dk {
			let danger: Vec<(u16, f64)> = meta["dangers"][*d as usize].as_object().map(|o| o.iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect()).unwrap_or_default();
			let p = Profile::walk(Some("Horde"), ground.clone(), Area::new(&danger, zones.clone()));
			for rs in all_rs.chunks(chunk) {
				let ask_rows: Vec<Row> = rs.iter().map(|&(a, b)| Row { source: ask_of(src[a] as usize, false), targets: (a..b).map(|x| ask_of(dst[x] as usize, false)).collect() }).collect();
				let (out, st) = pool.install(|| walker.rows(&ask_rows, &p, &zones.tag, band == 0)).unwrap();
				stats_all.push(st);
				// Not walked at the points' own heights: again at the grid's (walktables.js `again`).
				let mut again: Vec<(usize, Vec<usize>)> = Vec::new();
				for (ri, &(a, b)) in rs.iter().enumerate() {
					let mut retry = Vec::new();
					for x in a..b {
						let w = &out[ri][x - a];
						let ok = w.seconds >= 0.0 && w.yards >= 0.0;
						slot_of.insert(x, got.len());
						got.push((
							x,
							if ok { round1(w.yards) } else { -1.0 },
							if ok { round1(w.seconds * 7.0) } else { -1.0 },
							w.cells.as_ref().map(|c| c.0.iter().map(|(k, y)| (*k, round1(*y))).collect()),
						));
						let (s, e) = (&ends[src[a] as usize], &ends[dst[x] as usize]);
						if !ok && (s[3] != s[4] || e[3] != e[4]) {
							retry.push(x);
						}
					}
					if !retry.is_empty() {
						again.push((a, retry));
					}
				}
				drop(out);
				if !again.is_empty() {
					let ask_rows: Vec<Row> = again.iter().map(|(a, xs)| Row { source: ask_of(src[*a] as usize, true), targets: xs.iter().map(|&x| ask_of(dst[x] as usize, true)).collect() }).collect();
					let (out, _) = pool.install(|| walker.rows(&ask_rows, &p, &zones.tag, band == 0)).unwrap();
					for ((_, xs), o) in again.iter().zip(out) {
						for (&x, w) in xs.iter().zip(o) {
							if w.seconds >= 0.0 && w.yards >= 0.0 {
								retried_full += 1;
								got[slot_of[&x]] = (x, round1(w.yards), round1(w.seconds * 7.0), w.cells.as_ref().map(|c| c.0.iter().map(|(k, y)| (*k, round1(*y))).collect()));
							}
						}
					}
				}
			}
		}
		let ms = t0.elapsed().as_secs_f64() * 1e3;
		// Compare.
		let (mut walk_set_differ, mut cost_exact, mut cost_tenth, mut cost_off, mut yd_exact, mut yd_1pct, mut yd_far) = (0, 0, 0, 0, 0, 0, 0);
		let (mut cells_close, mut cells_far, mut yd_max_rel) = (0, 0, 0f64);
		// Bit for bit: yards as stored (0.1), the cells in the table's order and float32 yards.
		let (mut yd_differ, mut cells_differ) = (0, 0);
		for (x, y, c, cl) in &got {
			let (wy, wc) = (ty[*x], tc[*x]);
			if (wy >= 0.0) != (*y >= 0.0) {
				walk_set_differ += 1;
				if walk_set_differ <= 5 {
					eprintln!("  band {band} pair {x} ({}->{}): table {wy}/{wc}, rust {y}/{c}", src[*x], dst[*x]);
				}
				continue;
			}
			if wy < 0.0 {
				continue;
			}
			let dc = (c - wc).abs();
			if dc == 0.0 {
				cost_exact += 1;
			} else if dc <= 0.1 + 1e-9 {
				cost_tenth += 1;
			} else {
				cost_off += 1;
				if cost_off <= 5 {
					eprintln!("  band {band} pair {x}: cost table {wc} rust {c} (yards {wy} / {y})");
				}
			}
			let r = (y - wy).abs() / wy.max(1.0);
			yd_max_rel = yd_max_rel.max(r);
			if *y != wy {
				yd_differ += 1;
			}
			if (y - wy).abs() <= 0.1 + 1e-9 {
				yd_exact += 1;
			} else if r <= 0.01 {
				yd_1pct += 1;
			} else {
				yd_far += 1;
			}
			if let Some(cl) = cl {
				let want: Vec<(u32, f64)> = (txoff[*x] as usize..txoff[*x + 1] as usize).step_by(2).map(|k| (tx[k] as u32, tx[k + 1] as f64)).collect();
				let close = want.len() == cl.len() && want.iter().all(|(k, yv)| cl.iter().find(|c| c.0 == *k).is_some_and(|c| (c.1 - yv).abs() <= 1.0f64.max(0.01 * yv)));
				if close {
					cells_close += 1;
				} else {
					cells_far += 1;
				}
				if want.len() != cl.len() || want.iter().zip(cl).any(|(w, g)| w.0 != g.0 || (w.1 as f32).to_bits() != (g.1 as f32).to_bits()) {
					cells_differ += 1;
				}
			}
		}
		let legs_ms: f64 = stats_all.iter().map(|s| s.legs_ms).sum();
		let search_ms: f64 = stats_all.iter().map(|s| s.search_ms).sum();
		let retried: usize = stats_all.iter().map(|s| s.retried).sum();
		let relaxed: u64 = stats_all.iter().map(|s| s.relaxed).sum();
		println!(
			"band {band}: {} rows / {pairs} pairs ({} danger tables) in {ms:.0} ms on 3 threads (legs {legs_ms:.0} ms, search {search_ms:.0} ms, {relaxed} edges relaxed, {retried} pairs retried as routeMany, {retried_full} at full heights); \
			 walkable set differs {walk_set_differ}; cost equal {cost_exact}, ±0.1 {cost_tenth}, off {cost_off}; yards ±0.1 {yd_exact}, ≤1% {yd_1pct}, >1% {yd_far} (max rel {yd_max_rel:.4}), not equal {yd_differ}; cells close {cells_close}, far {cells_far}, not equal {cells_differ}",
			sample.len(),
			by_dk.len()
		);
		fails.push((band, walk_set_differ, cost_off + danger_rule_differs));
		if refs.golden {
			// The golden's tables are the JS router's own on the synthetic grid: costs and yards may not differ.
			// Cells hold the router port's tolerance (137 of 708 base pairs differ in order or float32 bits).
			assert_eq!((cost_tenth, yd_differ, cells_far), (0, 0, 0), "band {band}: costs ±0.1, yards not equal, cells far");
		}
	}
	let (s, g) = walker.legs_kept();
	println!("legs kept: {s} starts, {g} goals");
	for (band, w, c) in fails {
		assert_eq!(w, 0, "band {band}: walkable set");
		assert_eq!(c, 0, "band {band}: costs");
	}
}
