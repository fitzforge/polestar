//! Camps for one objective (port of tools/lib/sim/camps.js): single linkage on the spawns of
//! every source (two spawns within LINK_R chain into one camp) while a camp spans at most
//! MAX_SPAN. A camp is its geometry and its source set; chances belong to the objective.
//! (world.js marks a camp with an elite source `elite`; camps.js's header predates that.)

use crate::data::Kind;
use forge_core::{js_hypot, round1};
use rustc_hash::FxHashMap;

pub const LINK_R: f64 = 80.0;
pub const MAX_SPAN: f64 = 350.0;

/// A deduplicated spawn of an entity (world.js sites().spawns).
#[derive(Clone, Copy, Debug)]
pub struct SpawnPt {
	pub c: i64,
	pub region: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: u32,
}

#[derive(Clone, Copy, Debug)]
pub struct CampSource {
	pub kind: Kind,
	pub id: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct CampSourceCount {
	pub kind: Kind,
	pub id: u32,
	pub spawns: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Camp {
	pub id: u32,
	pub pt: u32,
	pub c: i64,
	pub region: i64,
	pub radius: f64,
	pub spawns: u32,
	pub level_min: Option<f64>,
	pub level_max: Option<f64>,
	pub respawn: Option<f64>,
	pub sources: Vec<CampSourceCount>,
	pub elite: bool,
}

/// The camp before it gets its id and elite flag.
pub struct NewCamp {
	pub pt: u32,
	pub c: i64,
	pub region: i64,
	pub radius: f64,
	pub spawns: u32,
	pub level_min: Option<f64>,
	pub level_max: Option<f64>,
	pub respawn: Option<f64>,
	pub sources: Vec<CampSourceCount>,
}

pub trait CampHost {
	fn spawns_of(&mut self, kind: Kind, id: u32) -> Vec<SpawnPt>;
	fn level_of(&self, kind: Kind, id: u32) -> Option<f64>;
	fn respawn_of(&self, kind: Kind, id: u32) -> Option<f64>;
	fn point_at(&mut self, kind: Kind, id: u32, s: &SpawnPt) -> u32;
	fn add_camp(&mut self, camp: NewCamp) -> u32;
}

/// camps.js buildCamps -> camp ids, in the order their groups were first made.
pub fn build_camps(sources: &[CampSource], host: &mut dyn CampHost) -> Vec<u32> {
	struct R {
		src: CampSource,
		s: SpawnPt,
	}
	let mut raw: Vec<R> = Vec::new();
	for src in sources {
		for s in host.spawns_of(src.kind, src.id) {
			raw.push(R { src: *src, s });
		}
	}
	let d = |a: &R, b: &R| js_hypot(a.s.wx - b.s.wx, a.s.wy - b.s.wy);
	// groups[g]: member indices into raw; alive[g]: still in the Set; groups made in order.
	let mut groups: Vec<Vec<usize>> = Vec::new();
	let mut alive: Vec<bool> = Vec::new();
	let mut group_of: Vec<usize> = vec![usize::MAX; raw.len()];
	let mut cell: FxHashMap<(i64, i64, i64), Vec<usize>> = FxHashMap::default();
	let fits = |raw: &[R], a: &[usize], b: &[usize]| -> bool {
		let (mut x0, mut x1, mut y0, mut y1) = (f64::INFINITY, f64::NEG_INFINITY, f64::INFINITY, f64::NEG_INFINITY);
		for &i in a.iter().chain(b) {
			let s = &raw[i].s;
			x0 = x0.min(s.wx);
			x1 = x1.max(s.wx);
			y0 = y0.min(s.wy);
			y1 = y1.max(s.wy);
		}
		js_hypot(x1 - x0, y1 - y0) <= MAX_SPAN || a.iter().all(|&i| b.iter().all(|&j| d(&raw[i], &raw[j]) <= MAX_SPAN))
	};
	for r in 0..raw.len() {
		let gx = (raw[r].s.wx / LINK_R).floor() as i64;
		let gy = (raw[r].s.wy / LINK_R).floor() as i64;
		let region = raw[r].s.region;
		let mut near: Vec<usize> = Vec::new();
		for dx in -1..=1 {
			for dy in -1..=1 {
				if let Some(list) = cell.get(&(region, gx + dx, gy + dy)) {
					for &q in list {
						let g = group_of[q];
						if !near.contains(&g) && d(&raw[q], &raw[r]) <= LINK_R {
							near.push(g);
						}
					}
				}
			}
		}
		// mine: None = the singleton [r] not yet a group; Some(g) = merged into group g.
		let mut mine: Option<usize> = None;
		for g in near {
			let mine_members: Vec<usize> = match mine {
				None => vec![r],
				Some(m) => groups[m].clone(),
			};
			if !fits(&raw, &groups[g], &mine_members) {
				continue;
			}
			groups[g].extend_from_slice(&mine_members);
			if mine_members.len() > 1 {
				if let Some(m) = mine {
					alive[m] = false;
				}
			}
			mine = Some(g);
		}
		let g = match mine {
			Some(g) => g,
			None => {
				groups.push(vec![r]);
				alive.push(true);
				groups.len() - 1
			}
		};
		let members = groups[g].clone();
		for x in members {
			group_of[x] = g;
		}
		cell.entry((region, gx, gy)).or_default().push(r);
	}
	let mut out = Vec::new();
	for (g, members) in groups.iter().enumerate() {
		if !alive[g] {
			continue;
		}
		let n = members.len() as f64;
		let mut cx = 0.0;
		let mut cy = 0.0;
		for &i in members {
			cx += raw[i].s.wx;
		}
		for &i in members {
			cy += raw[i].s.wy;
		}
		cx /= n;
		cy /= n;
		let mut at = members[0];
		for &i in members {
			if js_hypot(raw[i].s.wx - cx, raw[i].s.wy - cy) < js_hypot(raw[at].s.wx - cx, raw[at].s.wy - cy) {
				at = i;
			}
		}
		let mut level_min = f64::INFINITY;
		let mut level_max = f64::NEG_INFINITY;
		let mut respawns = Vec::new();
		let mut srcs: Vec<CampSourceCount> = Vec::new();
		for &i in members {
			let src = raw[i].src;
			let ex = match srcs.iter().position(|x| x.kind == src.kind && x.id == src.id) {
				Some(p) => p,
				None => {
					srcs.push(CampSourceCount { kind: src.kind, id: src.id, spawns: 0 });
					if let Some(l) = host.level_of(src.kind, src.id) {
						level_min = level_min.min(l);
						level_max = level_max.max(l);
					}
					srcs.len() - 1
				}
			};
			srcs[ex].spawns += 1;
			if let Some(rs) = host.respawn_of(src.kind, src.id) {
				respawns.push(rs);
			}
		}
		respawns.sort_by(|a, b| a.partial_cmp(b).unwrap());
		let mut radius = 0.0f64;
		for &i in members {
			radius = radius.max(d(&raw[i], &raw[at]));
		}
		let atr = &raw[at];
		let pt = host.point_at(atr.src.kind, atr.src.id, &atr.s);
		out.push(host.add_camp(NewCamp {
			pt,
			c: atr.s.c,
			region: atr.s.region,
			radius: round1(radius),
			spawns: members.len() as u32,
			level_min: level_min.is_finite().then_some(level_min),
			level_max: level_max.is_finite().then_some(level_max),
			respawn: (!respawns.is_empty()).then(|| respawns[respawns.len() / 2]),
			sources: srcs,
		}));
	}
	out
}
