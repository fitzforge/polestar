//! Walk store, stage 1 parity (docs/forge/internals.md, "How a port was checked"): the store filled from
//! a walks file answers as walklookup.js does on a sample per faction, and the JS router's Horde tables
//! import under their keys.
//!
//! Golden: rust/tests/golden/nav-store (walks-<f>.bin from walktables.js routerWalks + walks.js
//! writeWalks, lookup-<f>.bin from lookup-sample.js's logic) and nav-walks (world-<f>.json, horde/
//! asks-<band>.{bin,json}, horde/ends.json, walktable/<key>.bin); POLESTAR_REF reads the old local
//! references (tests/common/mod.rs).
//! cargo test --release -p forge-nav --test store_parity -- --nocapture --test-threads=1

mod common;

use forge_nav::lookup::{Lookup, WalksDoc};
use forge_nav::psbn::Bin;
use forge_nav::store::{Answer, End, Model, NoRouter, Profile, WalkStore};
use serde_json::Value;
use std::time::Instant;

struct World {
	points: Vec<Vec<Value>>,
	zone_min: String,
}

fn world(refs: &common::Refs, faction: &str) -> World {
	let v: Value = serde_json::from_slice(&refs.world(faction)).unwrap();
	let points = v["points"].as_array().unwrap().iter().map(|p| p.as_array().unwrap().clone()).collect();
	let zone_min = forge_core::key::content_key(serde_json::to_string(&v["zoneMin"]).unwrap().as_bytes());
	World { points, zone_min }
}

/// The Lua router's ends: the world's points as they are.
fn world_ends(w: &World) -> Vec<End> {
	w.points.iter().map(|p| End::new(p[0].as_i64().unwrap() as i32, p[2].as_f64().unwrap(), p[3].as_f64().unwrap(), p[5].as_f64(), None)).collect()
}

fn i32_at(b: &[u8], o: usize) -> i32 {
	i32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}
fn f32_at(b: &[u8], o: usize) -> f32 {
	f32::from_le_bytes(b[o..o + 4].try_into().unwrap())
}

fn same(x: f32, y: f32) -> bool {
	x.to_bits() == y.to_bits() || (x.is_nan() && y.is_nan())
}

fn check_faction(faction: &str) {
	let lower = faction.to_lowercase();
	let refs = common::refs();
	let (w, bin, sample) = (world(&refs, &lower), refs.walks_bin(&lower), refs.lookup(&lower));
	let t0 = Instant::now();
	let doc = WalksDoc::read(&bin).unwrap();
	let nw = doc.nw().unwrap();
	assert_eq!(nw, w.points.len(), "walks file and world point counts");
	let lookup = Lookup::new(WalksDoc::read(&bin).unwrap(), nw);
	let read_ms = t0.elapsed().as_secs_f64() * 1e3;
	let ends = world_ends(&w);
	let (grid, style, smooth) = (doc.str("nav").unwrap().to_string(), doc.str("style").unwrap().to_string(), doc.smooth());
	let model_of = |band: i64| Model {
		grid: format!("lua:{grid}"),
		params: if band == 0 {
			format!("lua|{faction}|{style}|smooth={smooth}|oneWayDz=15|band=0")
		} else {
			format!("lua|{faction}|{style}|smooth={smooth}|oneWayDz=15|band={band}|dv=1|zoneMin={}", w.zone_min)
		},
	};
	let t1 = Instant::now();
	let mut store = WalkStore::new();
	let profiles = store.import_doc(doc, &ends, &model_of);
	let import_ms = t1.elapsed().as_secs_f64() * 1e3;
	let profile = |band: i64| profiles.iter().find(|p| p.0 == band).unwrap().1;
	// Ends shared by several world points (one answer per ends): counted, they are where the store may differ.
	let mut uniq = std::collections::HashSet::new();
	let shared = ends.iter().filter(|e| !uniq.insert((e.c, e.x.to_bits(), e.y.to_bits(), e.z.to_bits()))).count();

	let n = i32_at(&sample, 0) as usize;
	let check = |store: &WalkStore, label: &str| {
		let (mut bad_lookup, mut bad_store, mut bad_shared) = (0, 0, 0);
		for i in 0..n {
			let o = 4 + i * 32;
			let (a, b, band) = (i32_at(&sample, o) as i64, i32_at(&sample, o + 4) as i64, i32_at(&sample, o + 8) as i64);
			let (yd, gy, gc, got, has) = (f32_at(&sample, o + 12), f32_at(&sample, o + 16), f32_at(&sample, o + 20), i32_at(&sample, o + 24) != 0, i32_at(&sample, o + 28) != 0);
			// The walklookup port.
			let g = lookup.get(a, b, band);
			if !same(lookup.yd(a, b, band), yd) || g.is_some() != got || g.is_some_and(|g| !same(g.0, gy) || !same(g.1, gc)) || lookup.has(a, b, band) != has {
				bad_lookup += 1;
			}
			// The store, by ends.
			let s = store.get(&ends[a as usize], &ends[b as usize], profile(band));
			let syd = s.map(|x| x.yd as f32).unwrap_or(-1.0);
			let sget = s.filter(|x| x.yd.is_finite());
			if !same(syd, yd) || sget.is_some() != got || sget.is_some_and(|x| !same(x.yd as f32, gy) || !same(x.cost as f32, gc)) {
				let e = (&ends[a as usize], &ends[b as usize]);
				let dup = ends.iter().filter(|x| *x == e.0).count() > 1 || ends.iter().filter(|x| *x == e.1).count() > 1;
				if dup {
					bad_shared += 1;
				} else {
					bad_store += 1;
					if bad_store <= 5 {
						eprintln!("  {label} mismatch {a}->{b} band {band}: js yd {yd} get {got} {gy} {gc}; store {s:?}");
					}
				}
			}
		}
		(bad_lookup, bad_store, bad_shared)
	};
	let (bl, bs, bsh) = check(&store, "store");
	// Lookup timing: the sample's yd() calls.
	let t2 = Instant::now();
	let mut hits = 0;
	for i in 0..n {
		let o = 4 + i * 32;
		let p = profile(i32_at(&sample, o + 8) as i64);
		if store.get(&ends[i32_at(&sample, o) as usize], &ends[i32_at(&sample, o + 4) as usize], p).is_some() {
			hits += 1;
		}
	}
	let store_ns = t2.elapsed().as_nanos() as f64 / n as f64;
	let t3 = Instant::now();
	let bytes = store.encode();
	let enc_ms = t3.elapsed().as_secs_f64() * 1e3;
	let t4 = Instant::now();
	let back = WalkStore::decode(&bytes).unwrap();
	let dec_ms = t4.elapsed().as_secs_f64() * 1e3;
	let (_, bs2, bsh2) = check(&back, "decoded");
	// The router is asked only for what is missing: a NoRouter walk over the sample asks the pairs no band holds.
	let asks: Vec<(End, End, Profile)> = (0..n)
		.map(|i| {
			let o = 4 + i * 32;
			(ends[i32_at(&sample, o) as usize], ends[i32_at(&sample, o + 4) as usize], profile(i32_at(&sample, o + 8) as i64))
		})
		.collect();
	let mut warm = WalkStore::decode(&bytes).unwrap();
	let r = warm.walks(&asks, &mut NoRouter);
	let again = warm.walks(&asks, &mut NoRouter);
	println!(
		"{faction}: {n} sampled pairs; walklookup port mismatches {bl}; store mismatches {bs} (+{bsh} at ends shared by several world points, {shared} such points), decoded {bs2} (+{bsh2}); \
		 store {} answers / {} models; read {read_ms:.0} ms, import {import_ms:.0} ms, encode {enc_ms:.0} ms ({:.0} MB), decode {dec_ms:.0} ms; get {store_ns:.0} ns ({hits} hits); \
		 walks(): {} stored, {} routed, again {} routed",
		store.len(),
		store.models().len(),
		bytes.len() as f64 / 1e6,
		r.stored,
		r.routed,
		again.routed
	);
	assert_eq!(bl, 0, "walklookup port");
	assert_eq!(bs, 0, "store");
	assert_eq!(bs2, 0, "decoded store");
	assert_eq!(again.routed, 0, "asked twice");
	assert!(r.answers.iter().zip(&again.answers).all(|(x, y)| x.yd.to_bits() == y.yd.to_bits()));
	let _ = Answer::NONE;
}

#[test]
fn walks_files_answer_as_walklookup() {
	check_faction("Horde");
	check_faction("Alliance");
}

#[test]
fn saved_router_tables_import_by_key() {
	let refs = common::refs();
	let ends_doc: Value = serde_json::from_slice(&refs.ends()).unwrap();
	let ends: Vec<End> =
		ends_doc["ends"].as_array().unwrap().iter().map(|e| End::new(e[0].as_i64().unwrap() as i32, e[1].as_f64().unwrap(), e[2].as_f64().unwrap(), e[3].as_f64(), e[4].as_f64())).collect();
	let grid = format!("nav4:{}", ends_doc["gridBuiltAt"].as_str().unwrap());
	let mut store = WalkStore::new();
	let mut total = 0;
	for band in [0, 10] {
		let meta: Value = serde_json::from_slice(&refs.asks_json(band)).unwrap();
		let key = meta["key"].as_str().unwrap();
		let n = meta["n"].as_u64().unwrap() as usize;
		let Ok(bytes) = std::fs::read(refs.table_path(key)) else {
			panic!("band {band}: the saved router table for this world's asks ({key}) is missing: keys don't match");
		};
		let t = Bin::parse(&bytes[..]).unwrap();
		assert_eq!(t.header["key"].as_str(), Some(key), "band {band}: table key");
		assert_eq!(t.header["n"].as_u64(), Some(n as u64), "band {band}: pair count");
		let raw = refs.asks_bin(band);
		let col = |k: usize| (0..n).map(|i| i32_at(&raw, 4 * (k * n + i))).collect::<Vec<i32>>();
		let (src, dst) = (col(0), col(1));
		let (y, c) = (t.f64s("y").unwrap(), t.f64s("c").unwrap());
		let model = Model {
			grid: grid.clone(),
			params: if band == 0 {
				"node|2|de5e034b6fe042a8|227aa359e8ac|Horde|-||any|balanced|smooth=0.961|band=0".into()
			} else {
				format!("node|2|de5e034b6fe042a8|227aa359e8ac|Horde|-||any|balanced|smooth=0.961|band={band}|dv=1")
			},
		};
		let m = store.model(&model);
		let t0 = Instant::now();
		store.import_table(&y, &c, &src, &dst, &ends, m, 0.961, None);
		let ms = t0.elapsed().as_secs_f64() * 1e3;
		// Every pair answers as the table holds it (later duplicates of the same ends win: counted).
		let p = Profile { model: m, base: None };
		let key_of = |e: &End| (e.c, e.x.to_bits(), e.y.to_bits(), e.z.to_bits(), e.zf.to_bits());
		let mut last = std::collections::HashMap::new();
		for i in 0..n {
			last.insert((key_of(&ends[src[i] as usize]), key_of(&ends[dst[i] as usize])), i);
		}
		let mut bad = 0;
		let mut dup = 0;
		let mut walkable = 0;
		for i in 0..n {
			let got = store.get(&ends[src[i] as usize], &ends[dst[i] as usize], p).unwrap();
			let want = if y[i] >= 0.0 { Answer { yd: y[i] * 0.961, cost: c[i] } } else { Answer::NONE };
			if y[i] >= 0.0 {
				walkable += 1;
			}
			if got != want {
				if last[&(key_of(&ends[src[i] as usize]), key_of(&ends[dst[i] as usize]))] != i {
					dup += 1;
				} else {
					bad += 1;
				}
			}
		}
		total += n;
		println!("router table band {band}: key {key} matches; {n} pairs ({walkable} walkable) imported in {ms:.0} ms; {bad} differ, {dup} answered by a later pair with the same ends");
		assert_eq!(bad, 0);
	}
	println!("store: {} answers from {total} table pairs ({} distinct ends)", store.len(), ends.len());
}
