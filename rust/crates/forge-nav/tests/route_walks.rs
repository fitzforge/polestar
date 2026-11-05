//! A route's walks through the walk store (measurement and parity; the nav port's timings): a route's
//! walked legs (its `walk` actions) and every pair of the places it visits within 4000 yd on one
//! continent (what its decisions can ask), base Horde profile, as walktables.js sends ends (asks.js
//! ends.json). Cold: empty store, fresh router (snaps, legs, coarse data read); warm: the same asks
//! again (all from the store). The straight-line fast path's share, and its answers against the
//! router's for the same pairs. The JS router's base table imported into a store answers the pairs it
//! holds as the Rust router does. Golden: rust/tests/golden/nav-walks (route-horde.json, a synthetic
//! route over its world) on the grid of nav-grid; POLESTAR_REF reads the old local references
//! (the reset-base Orc Warrior route; tests/common/mod.rs).
//! cargo test --release -p forge-nav --test route_walks -- --nocapture

mod common;

use forge_nav::cost::{Area, Ground, Profile, Zones};
use forge_nav::grid::Grid;
use forge_nav::psbn::Bin;
use forge_nav::store::{Answer, End, Model, Profile as SP, WalkStore};
use forge_nav::walker::{hubs_file, StoreRouter, Walker};
use serde_json::Value;
use std::sync::Arc;
use std::time::Instant;

fn i32_at(b: &[u8], o: usize) -> i32 {
	i32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}

#[test]
fn route_walks_cold_and_warm() {
	let refs = common::refs();
	let dir = refs.grid.clone();
	let (az, route) = (refs.areazones(), refs.route());
	let az: Value = serde_json::from_slice(&az).unwrap();
	let route: Value = serde_json::from_slice(&route).unwrap();
	let ends_doc: Value = serde_json::from_slice(&refs.ends()).unwrap();
	let ends: Vec<End> =
		ends_doc["ends"].as_array().unwrap().iter().map(|e| End::new(e[0].as_i64().unwrap() as i32, e[1].as_f64().unwrap(), e[2].as_f64().unwrap(), e[3].as_f64(), e[4].as_f64())).collect();
	let world: Value = serde_json::from_slice(&refs.world("horde")).unwrap();
	let pts = world["points"].as_array().unwrap();
	let zone_mins: Vec<(u16, f64)> = world["zoneMin"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_f64().unwrap())).collect();
	// The asks: walked legs, then the visited places' pairs.
	let acts = route["actions"].as_array().unwrap();
	let mut legs: Vec<(usize, usize, f64)> = Vec::new();
	let mut visited = std::collections::BTreeSet::new();
	for a in acts {
		if let Some(p) = a["pt"].as_u64() {
			visited.insert(p as usize);
		}
		if a["act"] == "walk" {
			if let (Some(f), Some(t)) = (a["from"].as_u64(), a["pt"].as_u64()) {
				legs.push((f as usize, t as usize, a["level"].as_f64().unwrap_or(1.0)));
			}
		}
	}
	let visited: Vec<usize> = visited.into_iter().filter(|&p| matches!(ends[p].c, 0 | 1)).collect();
	let mut near: Vec<(usize, usize)> = Vec::new();
	for (x, &a) in visited.iter().enumerate() {
		for &b in &visited[x + 1..] {
			let (pa, pb) = (&pts[a], &pts[b]);
			if pa[0] == pb[0] && pa[1] == pb[1] && forge_core::jsnum::js_hypot(pa[2].as_f64().unwrap() - pb[2].as_f64().unwrap(), pa[3].as_f64().unwrap() - pb[3].as_f64().unwrap()) <= 4000.0 {
				near.push((a, b));
			}
		}
	}
	let grid = Arc::new(Grid::open(&dir, 1024).unwrap());
	let roads_tag = az["groundKey"].as_str().unwrap().split('|').nth(1).unwrap().to_string();
	let ground = Arc::new(Ground::load(&dir, &roads_tag, &[0, 1], std::fs::read(hubs_file(&dir)).ok().as_deref()).unwrap());
	let zones = Arc::new(Zones {
		of_area: az["zones"].as_object().unwrap().iter().map(|(k, v)| (k.parse().unwrap(), v.as_u64().unwrap() as u16)).collect(),
		tag: az["tag"].as_str().unwrap().into(),
		grids: Vec::new(),
	});
	let grid_id = format!("nav4:{}", ends_doc["gridBuiltAt"].as_str().unwrap());
	let base_model = Model { grid: grid_id.clone(), params: "node|2|de5e034b6fe042a8|227aa359e8ac|Horde|-||any|balanced|smooth=0.961|band=0".into() };
	let base_p = Arc::new(Profile::walk(Some("Horde"), ground.clone(), None));
	let pool = rayon::ThreadPoolBuilder::new().num_threads(3).build().unwrap();
	let mut lines = Vec::new();

	// Cold and warm, base profile, straight line on.
	for (label, asks_pts) in [("walked legs", legs.iter().map(|l| (l.0, l.1)).collect::<Vec<_>>()), ("visited places' pairs ≤4000 yd", near.clone())] {
		let walker = Walker::new(grid.clone());
		let mut store = WalkStore::new();
		let m = store.model(&base_model);
		let prof = SP { model: m, base: None };
		let asks: Vec<(End, End, SP)> = asks_pts.iter().map(|&(a, b)| (ends[a], ends[b], prof)).collect();
		let mut router = StoreRouter::new(&walker, 0.961);
		router.models.insert(base_model.clone(), (base_p.clone(), zones.tag.clone()));
		let t0 = Instant::now();
		let cold = pool.install(|| store.walks(&asks, &mut router));
		let cold_ms = t0.elapsed().as_secs_f64() * 1e3;
		let t1 = Instant::now();
		let warm = pool.install(|| store.walks(&asks, &mut router));
		let warm_ms = t1.elapsed().as_secs_f64() * 1e3;
		assert_eq!(warm.routed, 0);
		assert!(cold.answers.iter().zip(&warm.answers).all(|(x, y)| x == y));
		let (legs_ms, search_ms): (f64, f64) = router.stats.iter().fold((0.0, 0.0), |a, s| (a.0 + s.legs_ms, a.1 + s.search_ms));
		lines.push(format!(
			"{label}: {} asks ({} distinct asked); cold {cold_ms:.0} ms (straight line {} = {:.1} %, router {}: legs {legs_ms:.0} ms, search {search_ms:.0} ms), warm {warm_ms:.1} ms ({:.2} µs a walk)",
			asks.len(),
			cold.routed,
			router.by_line,
			100.0 * router.by_line as f64 / cold.routed.max(1) as f64,
			router.by_router,
			1e3 * warm_ms / asks.len() as f64
		));
		// The straight line's answers against the router's for the same pairs.
		if label == "visited places' pairs ≤4000 yd" {
			let mut store2 = WalkStore::new();
			let m2 = store2.model(&base_model);
			let asks2: Vec<(End, End, SP)> = asks.iter().map(|x| (x.0, x.1, SP { model: m2, base: None })).collect();
			let mut r2 = StoreRouter::new(&walker, 0.961);
			r2.straight = false;
			r2.models.insert(base_model.clone(), (base_p.clone(), zones.tag.clone()));
			let full = pool.install(|| store2.walks(&asks2, &mut r2));
			let mut diffs: Vec<f64> = Vec::new();
			let mut ydiffs: Vec<f64> = Vec::new();
			let mut walk_differs = 0;
			for (i, (a, b, _)) in asks.iter().enumerate() {
				let (sa, sb) = (walker.snap(&StoreRouterAsk::of(a)), walker.snap(&StoreRouterAsk::of(b)));
				let line = match (sa, sb) {
					(Some(sa), Some(sb)) => walker.straight(&sa, &sb, &base_p, false),
					_ => None,
				};
				if line.is_none() {
					continue;
				}
				let (x, y) = (cold.answers[i], full.answers[i]);
				if (x.yd >= 0.0) != (y.yd >= 0.0) {
					walk_differs += 1;
					continue;
				}
				diffs.push((x.cost - y.cost) / y.cost.max(0.1));
				ydiffs.push((x.yd - y.yd) / y.yd.max(0.1));
			}
			diffs.sort_by(|a, b| a.partial_cmp(b).unwrap());
			ydiffs.sort_by(|a, b| a.partial_cmp(b).unwrap());
			let q = |v: &[f64], f: f64| if v.is_empty() { 0.0 } else { v[((v.len() - 1) as f64 * f) as usize] };
			lines.push(format!(
				"straight line vs router on its {} pairs: walkable differs {walk_differs}; cost (line - router)/router min {:.4} p50 {:.4} max {:.4}; yards min {:.4} p50 {:.4} max {:.4}",
				diffs.len(),
				q(&diffs, 0.0),
				q(&diffs, 0.5),
				q(&diffs, 1.0),
				q(&ydiffs, 0.0),
				q(&ydiffs, 0.5),
				q(&ydiffs, 1.0)
			));
			// The plain rule (no road-in-reach or slack check): its share and its answers against the router's.
			let mut plain = Walker::new(grid.clone());
			plain.straight_exact = false;
			let (mut n_plain, mut pd): (usize, Vec<f64>) = (0, Vec::new());
			for (i, (a, b, _)) in asks.iter().enumerate() {
				let (Some(sa), Some(sb)) = (plain.snap(&StoreRouterAsk::of(a)), plain.snap(&StoreRouterAsk::of(b))) else { continue };
				let Some(w) = plain.straight(&sa, &sb, &base_p, false) else { continue };
				n_plain += 1;
				let y = full.answers[i];
				if y.yd >= 0.0 {
					pd.push((forge_core::jsnum::round1(w.seconds * 7.0) - y.cost) / y.cost.max(0.1));
				}
			}
			pd.sort_by(|a, b| a.partial_cmp(b).unwrap());
			let over = pd.iter().filter(|&&d| d > 0.01).count();
			lines.push(format!(
				"plain straight-line rule: {n_plain} of {} asks ({:.1} %); cost (line - router)/router min {:.4} p50 {:.4} p95 {:.4} max {:.4}; {over} over +1 %",
				asks.len(),
				100.0 * n_plain as f64 / asks.len() as f64,
				q(&pd, 0.0),
				q(&pd, 0.5),
				q(&pd, 0.95),
				q(&pd, 1.0)
			));
			// The saved base table, imported, against the Rust router (straight off) on the pairs it holds.
			let meta: Value = serde_json::from_slice(&refs.asks_json(0)).unwrap();
			let n = meta["n"].as_u64().unwrap() as usize;
			let raw = refs.asks_bin(0);
			let col = |k: usize| (0..n).map(|i| i32_at(&raw, 4 * (k * n + i))).collect::<Vec<i32>>();
			let t = refs.table(meta["key"].as_str().unwrap());
			let t = Bin::parse(&t[..]).unwrap();
			let mut tab = WalkStore::new();
			let mt = tab.model(&base_model);
			tab.import_table(&t.f64s("y").unwrap(), &t.f64s("c").unwrap(), &col(0), &col(1), &ends, mt, 0.961, None);
			let (mut held, mut cost_eq, mut yd_close) = (0, 0, 0);
			for (i, (a, b, _)) in asks.iter().enumerate() {
				let Some(x) = tab.get(a, b, SP { model: mt, base: None }) else { continue };
				held += 1;
				let y = full.answers[i];
				if x.cost == y.cost || (x.yd < 0.0 && y.yd < 0.0) {
					cost_eq += 1;
				}
				if (x.yd < 0.0 && y.yd < 0.0) || (x.yd - y.yd).abs() <= 0.1 + 0.01 * x.yd {
					yd_close += 1;
				}
			}
			lines.push(format!("saved base table holds {held} of these asks: Rust router cost equal on {cost_eq}, yards within 1 % on {yd_close}"));
			assert_eq!(walk_differs, 0);
		}
	}
	// Band walks by level (danger in the search): legs walked at levels 10-19 under band 10.
	let walker = Walker::new(grid.clone());
	let mut store = WalkStore::new();
	let mut router = StoreRouter::new(&walker, 0.961);
	let mut asks = Vec::new();
	for &(a, b, level) in &legs {
		if !(10.0..20.0).contains(&level) || !matches!(ends[a].c, 0 | 1) {
			continue;
		}
		let za = walker.zone_at(&zones, ends[a].c as u32, ends[a].x, ends[a].y);
		let zb = walker.zone_at(&zones, ends[b].c as u32, ends[b].x, ends[b].y);
		let d = forge_nav::cost::danger_of(10.0, &zone_mins, za, zb);
		let key = d.iter().map(|(z, m)| format!("{z}:{m}")).collect::<Vec<_>>().join(",");
		let model = Model { grid: grid_id.clone(), params: format!("node|2|de5e034b6fe042a8|227aa359e8ac|Horde|{key}|any|balanced|smooth=0.961") };
		let m = store.model(&model);
		router.models.entry(model).or_insert_with(|| (Arc::new(Profile::walk(Some("Horde"), ground.clone(), Area::new(&d, zones.clone()))), zones.tag.clone()));
		asks.push((ends[a], ends[b], SP { model: m, base: None }));
	}
	let t0 = Instant::now();
	let cold = pool.install(|| store.walks(&asks, &mut router));
	let cold_ms = t0.elapsed().as_secs_f64() * 1e3;
	let t1 = Instant::now();
	let warm = pool.install(|| store.walks(&asks, &mut router));
	lines.push(format!(
		"band-10 walked legs (levels 10-19): {} asks over {} danger tables; cold {cold_ms:.0} ms (straight {}, router {}), warm {:.2} ms; {} walkable",
		asks.len(),
		router.models.len(),
		router.by_line,
		router.by_router,
		t1.elapsed().as_secs_f64() * 1e3,
		warm.answers.iter().filter(|a: &&Answer| a.yd >= 0.0).count()
	));
	let _ = cold;
	for l in lines {
		println!("{l}");
	}
}

/// The ask StoreRouter sends for an end (own height).
struct StoreRouterAsk;
impl StoreRouterAsk {
	fn of(e: &End) -> forge_nav::legs::SnapAsk {
		forge_nav::legs::SnapAsk { c: e.c as u32, wx: e.x, wy: e.y, z: if e.z.is_nan() { None } else { Some(e.z) }, radius: 20.0, under: true, stand: true }
	}
}
