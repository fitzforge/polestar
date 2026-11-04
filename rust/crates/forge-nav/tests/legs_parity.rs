//! Legs parity: path.js legs (parity/legs-ref.js's logic, rust/tests/golden/nav-walks/regen.js) against
//! forge-nav's on every walk point of the golden synthetic world, at its own height and at none: snapped
//! ends equal, start and goal legs' nodes equal, seconds equal (1e-9 relative), yards and zone cells within
//! the router port's yard tolerance (1 yd or 1 %) (ties may take another way of equal seconds); the router's tags (groundKey,
//! edgeKey, the danger area's key) and its AreaTable zones equal. Golden: rust/tests/golden/nav-legs on the
//! grid of nav-grid; POLESTAR_REF reads the old local references (tests/common/mod.rs).
//! cargo test --release -p forge-nav --test legs_parity -- --nocapture

mod common;

use forge_nav::cost::{Area, Ground, Profile, Zones};
use forge_nav::grid::Grid;
use forge_nav::legs::{Cells, Legs, Nav, SnapAsk, Tree};
use rayon::prelude::*;
use serde_json::Value;
use std::sync::Arc;
use std::time::Instant;

fn rel(a: f64, b: f64) -> f64 {
	if a == b {
		0.0
	} else {
		(a - b).abs() / a.abs().max(b.abs())
	}
}

fn cells_of(v: &Value) -> Cells {
	let a: Vec<f64> = v.as_array().unwrap().iter().map(|x| x.as_f64().unwrap()).collect();
	Cells(a.chunks_exact(2).map(|c| (c[0] as u32, c[1])).collect())
}

/// Cells compared as the router port accepts yards: same keys, each within 1 yd or 1 % (a tie may walk
/// another way of equal seconds through other cells: counted apart).
fn cells_close(a: &Cells, b: &Cells) -> bool {
	if a.0.len() != b.0.len() {
		return false;
	}
	a.0.iter().all(|(k, y)| b.0.iter().find(|x| x.0 == *k).is_some_and(|x| (x.1 - y).abs() <= 1.0f64.max(0.01 * y)))
}

#[derive(Default, Debug)]
struct Tally {
	legs: usize,
	nodes_differ: usize,
	/// A start's legs given by one side only (no tile, no graph there).
	legs_presence_differ: usize,
	settle_differ: usize,
	seconds_max_rel: f64,
	yards_max_rel: f64,
	yards_over_1pct: usize,
	seeds: usize,
	cells_exact: usize,
	cells_close: usize,
	cells_far: usize,
}

fn compare(t: &mut Tally, want: &Value, got: &Legs, settled_got: Option<usize>, label: &str) {
	t.legs += 1;
	let settled = want["settled"].as_i64().unwrap();
	if settled != settled_got.map(|x| x as i64).unwrap_or(-1) {
		t.settle_differ += 1;
	}
	let nodes: Vec<u32> = want["node"].as_array().unwrap().iter().map(|x| x.as_u64().unwrap() as u32).collect();
	if nodes != got.nodes {
		t.nodes_differ += 1;
		if t.nodes_differ <= 3 {
			eprintln!("  {label}: nodes differ: js {} rust {}", nodes.len(), got.nodes.len());
		}
		return;
	}
	let cost = want["cost"].as_array().unwrap();
	let yards = want["yards"].as_array().unwrap();
	let cells = want["cells"].as_array().unwrap();
	for x in 0..nodes.len() {
		t.seeds += 1;
		t.seconds_max_rel = t.seconds_max_rel.max(rel(cost[x].as_f64().unwrap(), got.sec[x]));
		let ry = rel(yards[x].as_f64().unwrap(), got.yd[x]);
		t.yards_max_rel = t.yards_max_rel.max(ry);
		if ry > 0.01 {
			t.yards_over_1pct += 1;
		}
		let wc = cells_of(&cells[x]);
		let gc = &got.cells.as_ref().unwrap()[x];
		if wc.0.len() == gc.0.len() && wc.0.iter().zip(&gc.0).all(|(a, b)| a.0 == b.0 && a.1.to_bits() == b.1.to_bits()) {
			t.cells_exact += 1;
		} else if cells_close(&wc, gc) {
			t.cells_close += 1;
		} else {
			t.cells_far += 1;
		}
	}
}

#[test]
fn legs_match_path_js() {
	let refs = common::refs();
	let r: Value = serde_json::from_slice(&refs.legs()).unwrap();
	let dir = refs.grid.clone();
	let grid = Arc::new(Grid::open(&dir, 1024).unwrap());
	let gk = r["groundKey"].as_str().unwrap();
	let roads_tag = gk.split('|').nth(1).unwrap();
	let hubs = std::fs::read(dir.parent().unwrap().join("nav-layers/hubs.json")).ok();
	let hubs_trim = hubs.as_ref().map(|h| std::str::from_utf8(h).unwrap().trim().as_bytes().to_vec());
	let ground = Arc::new(Ground::load(&dir, roads_tag, &[0, 1], hubs_trim.as_deref()).unwrap());
	let zones = Arc::new(Zones {
		of_area: r["areaZone"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_u64().unwrap() as u16)).collect(),
		tag: r["zonesTag"].as_str().unwrap().into(),
		grids: Vec::new(),
	});
	if refs.golden {
		// router.js areaZones / areaZoneTable over the golden's synthetic AreaTable and zones.json.
		let data = common::golden_dir().join("nav-grid/data");
		let build = std::fs::read_to_string(data.join("build.txt")).unwrap();
		let z = Zones::from_area_table(&std::fs::read_to_string(data.join("AreaTable.csv")).unwrap(), build.trim(), &std::fs::read(data.join("zones.json")).unwrap()).unwrap();
		assert_eq!(z.tag, zones.tag, "zonesTag");
		assert_eq!(z.of_area, zones.of_area, "the AreaTable's zones");
	}
	let faction: &'static str = if r["faction"] == "Horde" { "Horde" } else { "Alliance" };
	let base = Profile::walk(Some(faction), ground.clone(), None);
	assert_eq!(base.ground_key, gk, "groundKey (roads tag, hubs tag from hubs.json, faction)");
	assert_eq!(base.edge_key(0), r["edgeKey"].as_str().unwrap(), "edgeKey");
	let danger: Vec<(u16, f64)> = r["danger"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect();
	let band = Profile::walk(Some(faction), ground.clone(), Area::new(&danger, zones.clone()));
	assert_eq!(band.area.as_ref().unwrap().key, r["areaKey"].as_str().unwrap());
	let nav = Nav::new(grid.clone());
	let rows = r["rows"].as_array().unwrap();
	let rows: Vec<&Value> = rows.iter().collect();
	let threads = 3;
	let pool = rayon::ThreadPoolBuilder::new().num_threads(threads).build().unwrap();
	let mut timings = Vec::new();
	let mut tallies = Vec::new();
	for (name, p) in [("base", &base), ("band10", &band)] {
		// Twice: cold (tiles read) and warm (tiles cached), on `threads` threads, one place each.
		for pass in ["cold", "warm"] {
			let t0 = Instant::now();
			let out: Vec<_> = pool.install(|| {
				rows.par_iter()
					.map_init(Tree::default, |sc, row| {
						let q = &row["q"];
						let ask = SnapAsk { c: q[0].as_u64().unwrap() as u32, wx: q[1].as_f64().unwrap(), wy: q[2].as_f64().unwrap(), z: q[3].as_f64(), radius: 20.0, under: true, stand: true };
						let a = nav.snap(&ask)?;
						let g = grid.graph(a.c)?;
						let s = nav.start_of(&g, &a, p, sc, true);
						let gl = nav.goal_of(&g, &a, p, sc, true);
						Some((a, s, gl))
					})
					.collect()
			});
			timings.push(format!("{name} {pass}: {:.0} ms", t0.elapsed().as_secs_f64() * 1e3));
			if pass == "cold" && name == "band10" {
				continue;
			}
			if pass == "warm" {
				let mut snap_bad = 0;
				let (mut ts, mut tg) = (Tally::default(), Tally::default());
				for (row, got) in rows.iter().zip(&out) {
					let want = &row["snap"];
					match got {
						None => {
							if !want.is_null() {
								snap_bad += 1;
							}
						}
						Some((a, s, (gl, gs))) => {
							let same = !want.is_null()
								&& want["entry"].as_u64() == Some(a.entry as u64)
								&& want["col"].as_u64() == Some(a.col as u64)
								&& want["row"].as_u64() == Some(a.row as u64)
								&& want["i"].as_u64() == Some(a.i as u64)
								&& want["j"].as_u64() == Some(a.j as u64)
								&& want["z"].as_f64() == Some(a.z)
								&& want["wx"].as_f64() == Some(a.wx)
								&& want["wy"].as_f64() == Some(a.wy)
								&& want["region"].as_u64().map(|x| x as u32) == a.region;
							if !same {
								snap_bad += 1;
								if snap_bad <= 3 {
									eprintln!("  snap differs at point {}: js {want} rust {a:?}", row["pt"]);
								}
								continue;
							}
							let w = &row[name];
							if w["start"].is_null() != s.is_none() {
								ts.legs_presence_differ += 1;
							}
							if let Some((l, k, _)) = s {
								compare(&mut ts, &w["start"], l, *k, "start");
							}
							compare(&mut tg, &w["goal"], gl, *gs, "goal");
						}
					}
				}
				println!("{name}: {} ends, snaps differing {snap_bad}\n  start {ts:?}\n  goal  {tg:?}", rows.len());
				tallies.push((snap_bad, ts, tg));
			}
		}
	}
	println!("rust ({threads} threads): {}", timings.join(", "));
	for (snap_bad, ts, tg) in tallies {
		assert_eq!(snap_bad, 0);
		for t in [ts, tg] {
			assert_eq!(t.nodes_differ, 0);
			assert_eq!(t.legs_presence_differ, 0);
			assert_eq!(t.settle_differ, 0);
			assert!(t.seconds_max_rel < 1e-9, "seconds {}", t.seconds_max_rel);
			if refs.golden {
				// The JS legs on the synthetic grid: yards and zone cells bit for bit too.
				assert_eq!(t.yards_max_rel, 0.0, "yards");
				assert_eq!(t.cells_exact, t.seeds, "cells not equal: {t:?}");
			}
		}
	}
}
