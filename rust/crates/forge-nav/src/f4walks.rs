//! Walks on Leffe's navigation maps (format 4, `f4`): the walks documents' backend (walkdoc.rs) over the
//! format-4 router, as the Node reader's simulator interface (tools/lib/nav/nav4/index.js
//! `open`) asks it: one FindMany per source and danger table (route_many: label yards, his cost), walked
//! yards = label yards × SMOOTH, zone cells from each target's chain of entrances (chainCells). The ends are the
//! world points themselves (his router snaps them, every surface in the cell when the height is unknown).
//! Danger is priced inside his search (his Costs: a uiMapID's multiplier); the ends' zones are exempt (dangerOf).
//!
//! His maps are private: they never ship. What ships is the walks they answered (the data pack's Leffe walk
//! stores, each end's zone on his maps kept beside them). `SavedF4Backend` answers from such a store alone,
//! with the same models as `F4Backend`; a pair the store lacks gets no walk, and the hybrid takes our grid's.
//! Credit: Leffe's navigation maps and reader; GPL-3.0-or-later.

use crate::f4::{Opts, Style, Validate, F4, P};
use crate::store::{Answer, End, Model, ZoneCells};
use crate::walkdoc::{Backend, BackendRouter, WalkWorld};
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use std::sync::atomic::{AtomicUsize, Ordering};

/// index.js SMOOTH: drawn yards per FindMany label yard.
pub const SMOOTH: f64 = 0.961;
/// The answers' version (part of every model). 2: Leffe's lift layer spliced in (its rides, the floor rule).
pub const MODEL_VERSION: u32 = 2;

pub struct F4Backend {
	pub f4: F4,
	/// The pack's identity (its Nav.xml and map headers' content key).
	pub pack_id: String,
	pub faction: Option<&'static str>,
}

impl F4Backend {
	/// The content key of a pack folder: Nav.xml and every Nav<map>.lua (the parts are named by them).
	pub fn pack_id(nav_dir: &std::path::Path) -> std::io::Result<String> {
		let mut h = forge_core::key::ContentHasher::new();
		h.update(&std::fs::read(nav_dir.join("Nav.xml"))?);
		let mut heads: Vec<_> = std::fs::read_dir(nav_dir)?
			.flatten()
			.filter_map(|e| e.file_name().to_str().map(String::from))
			.filter(|n| n.starts_with("Nav") && n.ends_with(".lua") && n[3..n.len() - 4].chars().all(|c| c.is_ascii_digit()))
			.collect();
		heads.sort();
		for n in heads {
			h.update(n.as_bytes()).update(&std::fs::read(nav_dir.join(&n))?);
		}
		Ok(h.hex())
	}

	fn opts(&self, danger: &[(u16, f64)], chains: bool) -> Opts {
		Opts { profile: self.faction, style: Style::Balanced, danger: danger.iter().map(|&(z, m)| (z as u32, m)).collect(), water_walking: false, validate: Validate::Tolerant, limit: None, chains }
	}

	/// index.js chainCells over F4: a target's yards per zone cell, rounded to 0.1 as the tables keep them.
	fn chain_cells(&self, map: u32, from: &End, to: &End, chain: &[i64], total: f64) -> ZoneCells {
		let p = |e: &End| P { x: e.x, y: e.y, z: if e.z.is_nan() { None } else { Some(e.z) } };
		self.f4.chain_cells(map, p(from), p(to), chain, total).into_iter().map(|(k, y)| (k as u32, forge_core::jsnum::round1(y) as f32)).collect()
	}
}

/// The store model of a danger table on Leffe pack `pack_id` with lift layer `lifts` (its hash's 12 hex, or
/// "none"): F4Backend's and SavedF4Backend's alike.
fn model_of(pack_id: &str, lifts: &str, faction: Option<&str>, danger: &[(u16, f64)]) -> Model {
	let mut d = danger.to_vec();
	d.sort_by_key(|x| x.0);
	let dk = d.iter().map(|(z, m)| format!("{z}:{}", forge_core::jsnum::js_to_string(*m))).collect::<Vec<_>>().join(",");
	Model {
		grid: format!("leffe:{pack_id}"),
		params: format!("{}|balanced|tolerant|danger={dk}|smooth={}|lifts={lifts}|v={MODEL_VERSION}", faction.unwrap_or("-"), forge_core::jsnum::js_to_string(SMOOTH)),
	}
}

fn end_key(e: &End) -> [u64; 4] {
	[e.c as u64, e.x.to_bits(), e.y.to_bits(), e.z.to_bits()]
}

/// Leffe's walks without his maps: the models of the pack a store was built on, each end's zone as the store
/// kept it (0 where it kept none: such an end is new, so the store holds none of its walks either), and a
/// router that answers nothing (no walk: the hybrid falls back to our grid).
pub struct SavedF4Backend {
	pub pack_id: String,
	/// The lift layer the saved walks were answered with (from the store's models).
	pub lifts: String,
	pub faction: Option<&'static str>,
	zones: FxHashMap<[u64; 4], u16>,
}

impl SavedF4Backend {
	pub fn new(store: &crate::store::WalkStore, (pack_id, lifts): (String, String), faction: Option<&'static str>, ends: &[End]) -> SavedF4Backend {
		let zones = ends.iter().filter_map(|e| store.zone(e).map(|z| (end_key(e), z))).collect();
		SavedF4Backend { pack_id, lifts, faction, zones }
	}
	/// Ends with a kept zone.
	pub fn zones_known(&self) -> usize {
		self.zones.len()
	}
}

impl Backend for SavedF4Backend {
	fn router_name(&self) -> &str {
		"leffe"
	}
	fn smooth(&self) -> f64 {
		SMOOTH
	}
	fn model(&self, danger: &[(u16, f64)]) -> Model {
		model_of(&self.pack_id, &self.lifts, self.faction, danger)
	}
	fn ends(&self, world: &WalkWorld) -> Vec<End> {
		world.points.iter().map(|p| End::new(p.c as i32, p.x, p.y, p.z, p.z)).collect()
	}
	fn zone_at(&self, e: &End) -> u16 {
		self.zones.get(&end_key(e)).copied().unwrap_or(0)
	}
	fn router<'a>(&'a self, _: Vec<(Model, Vec<(u16, f64)>)>, _: bool, _: i64) -> Box<dyn BackendRouter + 'a> {
		Box::new(Unanswered)
	}
}

struct Unanswered;
impl BackendRouter for Unanswered {}
impl crate::store::Router for Unanswered {
	fn walks(&mut self, _: &Model, pairs: &[(End, End)], _: bool) -> Vec<(Answer, Option<ZoneCells>)> {
		vec![(Answer::NONE, None); pairs.len()]
	}
}

impl Backend for F4Backend {
	fn router_name(&self) -> &str {
		"leffe"
	}
	fn smooth(&self) -> f64 {
		SMOOTH
	}
	fn model(&self, danger: &[(u16, f64)]) -> Model {
		model_of(&self.pack_id, self.f4.lift_layer().map_or("none", |id| &id[..12]), self.faction, danger)
	}
	fn ends(&self, world: &WalkWorld) -> Vec<End> {
		world.points.iter().map(|p| End::new(p.c as i32, p.x, p.y, p.z, p.z)).collect()
	}
	fn zone_at(&self, e: &End) -> u16 {
		self.f4.zone_at(e.c as u32, e.x, e.y).unwrap_or(0) as u16
	}
	fn router<'a>(&'a self, models: Vec<(Model, Vec<(u16, f64)>)>, cells: bool, band: i64) -> Box<dyn BackendRouter + 'a> {
		Box::new(F4Router { be: self, models: models.into_iter().collect(), cells, band, done: AtomicUsize::new(0), t0: std::time::Instant::now() })
	}
}

struct F4Router<'a> {
	be: &'a F4Backend,
	models: FxHashMap<Model, Vec<(u16, f64)>>,
	cells: bool,
	band: i64,
	done: AtomicUsize,
	t0: std::time::Instant,
}

impl BackendRouter for F4Router<'_> {}

impl crate::store::Router for F4Router<'_> {
	fn walks(&mut self, model: &Model, pairs: &[(End, End)], cells: bool) -> Vec<(Answer, Option<ZoneCells>)> {
		let danger = self.models.get(model).unwrap_or_else(|| panic!("f4: no danger table for model {}", model.params)).clone();
		let cells = cells && self.cells;
		// One FindMany per source end (first-seen order), its targets in pair order.
		let mut rows: Vec<(End, Vec<usize>)> = Vec::new();
		let mut by: FxHashMap<[u64; 4], usize> = FxHashMap::default();
		for (i, (a, _)) in pairs.iter().enumerate() {
			let k = [a.c as u64, a.x.to_bits(), a.y.to_bits(), a.z.to_bits()];
			let r = *by.entry(k).or_insert_with(|| {
				rows.push((*a, Vec::new()));
				rows.len() - 1
			});
			rows[r].1.push(i);
		}
		let o = self.be.opts(&danger, cells);
		let all = pairs.len();
		let answers: Vec<Vec<(usize, Answer, Option<ZoneCells>)>> = rows
			.par_iter()
			.map(|(a, idx)| {
				let p = |e: &End| P { x: e.x, y: e.y, z: if e.z.is_nan() { None } else { Some(e.z) } };
				let targets: Vec<P> = idx.iter().map(|&i| p(&pairs[i].1)).collect();
				let m = self.be.f4.route_many(a.c as u32, p(a), &targets, &o);
				let out = idx
					.iter()
					.enumerate()
					.map(|(j, &i)| {
						if m.costs[j] < 0.0 {
							return (i, Answer::NONE, None);
						}
						let y = forge_core::jsnum::round1(m.yards[j]);
						let cl = if cells { m.chains.as_ref().and_then(|c| c[j].as_ref()).map(|ch| self.be.chain_cells(a.c as u32, a, &pairs[i].1, ch, m.yards[j])) } else { None };
						(i, Answer { yd: y * SMOOTH, cost: forge_core::jsnum::round1(m.costs[j]) }, cl)
					})
					.collect();
				let d = self.done.fetch_add(idx.len(), Ordering::Relaxed) + idx.len();
				if d / 50_000 != (d - idx.len()) / 50_000 {
					eprintln!("  band {}: {d}/{all} pairs on Leffe's maps, {:.0} s", self.band, self.t0.elapsed().as_secs_f64());
				}
				out
			})
			.collect();
		let mut out = vec![(Answer::NONE, None); pairs.len()];
		for (i, a, c) in answers.into_iter().flatten() {
			out[i] = (a, c);
		}
		out
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::store::{Profile, WalkStore};

	/// A store written by a build on Leffe's maps answers a build without them: the same models (danger tables
	/// priced over the zones it kept for each end), its walks for the pairs it holds, no walk for a pair it lacks
	/// (the hybrid then takes the grid's), and the pack it holds the most walks of.
	#[test]
	fn saved_walks_answer_without_his_maps() {
		let (a, b, c) = (End::new(1, 10.0, 20.0, Some(5.0), Some(5.0)), End::new(1, 30.0, 40.0, Some(6.0), Some(6.0)), End::new(1, 50.0, 60.0, Some(7.0), Some(7.0)));
		let danger = vec![(1412u16, 2.0)];
		let mut s = WalkStore::new();
		let base = s.model(&model_of("p1", "abc", Some("Horde"), &[]));
		let band = s.model(&model_of("p1", "abc", Some("Horde"), &danger));
		let old = s.model(&model_of("p0", "abc", Some("Horde"), &[]));
		// An older answer version of p1 (before the lift layer) never wins, however many walks it holds.
		let stale = s.model(&Model { grid: "leffe:p1".into(), params: "Horde|balanced|tolerant|danger=|smooth=0.961|v=1".into() });
		for k in 0..5 {
			s.put(&End::new(1, k as f64, 0.0, None, None), &a, stale, Answer { yd: 1.0, cost: 1.0 });
		}
		s.put(&a, &b, base, Answer { yd: 100.0, cost: 90.0 });
		s.put(&b, &a, base, Answer { yd: 101.0, cost: 91.0 });
		s.put(&a, &b, band, Answer { yd: 100.0, cost: 180.0 });
		s.put(&a, &c, old, Answer { yd: 5.0, cost: 5.0 });
		s.set_zone(&a, 1412);
		s.set_zone(&b, 1456);
		let mut s = WalkStore::decode(&s.encode()).unwrap();
		assert_eq!(s.leffe_pack(), Some(("p1".to_string(), "abc".to_string())), "the pack and lift layer with the most walks of this version");
		let be = SavedF4Backend::new(&s, s.leffe_pack().unwrap(), Some("Horde"), &[a, b, c]);
		assert_eq!((be.zone_at(&a), be.zone_at(&b), be.zone_at(&c)), (1412, 1456, 0), "zones kept through encode/decode; none for a new end");
		assert_eq!(be.model(&danger), model_of("p1", "abc", Some("Horde"), &danger), "the band's model is the one his maps' build stored");
		let mut r = be.router(Vec::new(), true, 0);
		let asks = [(a, b, Profile { model: base, base: None }), (a, b, Profile { model: band, base: None }), (a, c, Profile { model: base, base: None })];
		let w = s.walks(&asks, &mut *r);
		assert_eq!(w.answers[0], Answer { yd: 100.0, cost: 90.0 });
		assert_eq!(w.answers[1], Answer { yd: 100.0, cost: 180.0 });
		assert_eq!(w.answers[2], Answer::NONE, "a pair the store lacks gets no walk (the grid's in the hybrid)");
		assert_eq!((w.stored, w.routed), (2, 1));
	}
}
