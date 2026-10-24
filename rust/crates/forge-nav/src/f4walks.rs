//! Walks on Leffe's navigation maps (format 4, `f4`): the walks documents' backend (walkdoc.rs) over the
//! format-4 router, as the Node reader's simulator interface (tools/lib/nav/nav4/index.js
//! `open`) asks it: one FindMany per source and danger table (route_many: label yards, his cost), walked
//! yards = label yards × SMOOTH, zone cells from each target's chain of entrances (chainCells). The ends are the
//! world points themselves (his router snaps them, every surface in the cell when the height is unknown).
//! Danger is priced inside his search (his Costs: a uiMapID's multiplier); the ends' zones are exempt (dangerOf).
//! Credit: Leffe's navigation maps and reader; GPL-3.0-or-later.

use crate::f4::{Opts, Style, Validate, F4, P};
use crate::store::{Answer, End, Model, ZoneCells};
use crate::walkdoc::{Backend, BackendRouter, WalkWorld};
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use std::sync::atomic::{AtomicUsize, Ordering};

/// index.js SMOOTH: drawn yards per FindMany label yard.
pub const SMOOTH: f64 = 0.961;
/// The answers' version (part of every model).
pub const MODEL_VERSION: u32 = 1;

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

impl Backend for F4Backend {
	fn router_name(&self) -> &str {
		"leffe"
	}
	fn smooth(&self) -> f64 {
		SMOOTH
	}
	fn model(&self, danger: &[(u16, f64)]) -> Model {
		let mut d = danger.to_vec();
		d.sort_by_key(|x| x.0);
		let dk = d.iter().map(|(z, m)| format!("{z}:{}", forge_core::jsnum::js_to_string(*m))).collect::<Vec<_>>().join(",");
		Model {
			grid: format!("leffe:{}", self.pack_id),
			params: format!("{}|balanced|tolerant|danger={dk}|smooth={}|v={MODEL_VERSION}", self.faction.unwrap_or("-"), forge_core::jsnum::js_to_string(SMOOTH)),
		}
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
