//! The world builder (port of tools/lib/sim/world.js buildWorld, BUILDER_VERSION 30). Every
//! step keeps the JS order of iteration and of floating-point operations, so the world equals
//! the JS world bit for bit (docs/forge/internals.md, "How a port was checked"). Comments name the JS they port; the
//! reasons behind each rule are documented in world.js.

use crate::areas::build_areas;
use crate::camps::{build_camps, Camp, CampHost, CampSource, NewCamp, SpawnPt};
use crate::data::{Entity, GameData, Item, Kind, Quest};
use crate::floors::{floor_of, Floors};
use crate::json::{entries, finite, js_str, num, present, truthy};
use crate::prereqs::blocking_prereqs;
use crate::solo::{self, Overrides};
use crate::tour::{plan_order, Step, StepKind};
use crate::world::*;
use crate::zonelevels::zone_levels;
use forge_core::frames::Rect;
use forge_core::{js_hypot, js_round, js_to_string, round1, Faction};
use regex::Regex;
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{json, Value};
use std::collections::BTreeMap;
use std::rc::Rc;

pub const BUILDER_VERSION: u32 = 30;
const RIDE_PAIR_YD: f64 = 60.0;
const CITY_LIFT_FLOOR: [(&str, &str); 5] =
	[("lift-thunder-bluff-north", "top"), ("lift-thunder-bluff-west", "top"), ("lift-undercity-east", "bottom"), ("lift-undercity-south", "bottom"), ("lift-undercity-west", "bottom")];
const PROFESSION_SORTS: [i64; 9] = [24, 101, 121, 181, 182, 201, 264, 304, 324];
const BATTLEGROUNDS: [u32; 3] = [1459, 1460, 1461];
const DANGER_CELL: f64 = 200.0;
const SITE_R: f64 = 70.0;
const DUP_R: f64 = 10.0;
const SPAWN_DUP_R: f64 = 4.0;
const VOTE_R: f64 = 150.0;
const HUB_R: f64 = 150.0;
const NEAR_HUB: f64 = 200.0;
pub const MAX_OPEN: u32 = 40;
const MIN_START_DROP: f64 = 1.0;
const UNKNOWN_DROP: f64 = 30.0;
const UNKNOWN_QUEST_DROP: f64 = 60.0;
const USED_OBJECT_TYPES: [f64; 5] = [2.0, 5.0, 8.0, 10.0, 22.0];
const USED_OBJECT_RESPAWN: f64 = 1.0;
const OBJECT_RESPAWN_EST: f64 = 180.0;
const OBJECT_QUEST_DROP: f64 = 100.0;
const HEIGHT_YARDS: f64 = 15.0;
const HINT_YARDS: f64 = SITE_R;
const Z_STEP: f64 = 3.0;
const LIFT_END_R: f64 = 150.0;
const LIFT_END_Z: f64 = 25.0;
const PORTAL_NEAR: f64 = 1500.0;

fn island(map: u32) -> i64 {
	match map {
		1438 | 1457 => 1,
		2521 | 2665 => 2,
		_ => 0,
	}
}

fn region_of(c: i64, map: u32) -> i64 {
	c * 10 + island(map)
}

/// Zephras Isle exits per faction: (name, isle map, x, y, mainland c, wx, wy, map, ride, wait).
struct Exit {
	name: &'static str,
	a: (u32, f64, f64),
	b: (i64, f64, f64, u32),
	ab: f64,
	wait: f64,
}

fn skyborne_exits(f: Faction) -> [Exit; 1] {
	match f {
		Faction::Horde => [Exit { name: "Zephras Isle airship", a: (2521, 57.92, 80.78), b: (1, -658.0, 426.0, 1412), ab: 90.0, wait: 60.0 }],
		Faction::Alliance => [Exit { name: "Zephras Isle zeppelin + Skyborne portal", a: (2521, 65.81, 83.44), b: (0, -8840.6, 489.7, 1453), ab: 110.0, wait: 60.0 }],
	}
}

enum StartSpec {
	Quest(u32, &'static str),
	Skyborne,
}

fn starts_of(f: Faction) -> Vec<(&'static str, StartSpec)> {
	match f {
		Faction::Horde => vec![
			("Orc", StartSpec::Quest(4641, "Durotar")),
			("Troll", StartSpec::Quest(4641, "Durotar")),
			("Tauren", StartSpec::Quest(747, "Mulgore")),
			("Undead", StartSpec::Quest(363, "Tirisfal Glades")),
			("Skyborne", StartSpec::Skyborne),
		],
		Faction::Alliance => vec![
			("Human", StartSpec::Quest(783, "Elwynn Forest")),
			("Dwarf", StartSpec::Quest(179, "Dun Morogh")),
			("Gnome", StartSpec::Quest(179, "Dun Morogh")),
			("NightElf", StartSpec::Quest(456, "Teldrassil")),
			("Skyborne", StartSpec::Skyborne),
		],
	}
}

/// World options (world.js buildWorld opts).
#[derive(Clone)]
pub struct BuildOptions {
	pub faction: Faction,
	pub band_width: f64,
	pub max_open: u32,
	/// Race -> (zone name, start quest).
	pub extra_starts: Vec<(String, String, u32)>,
	pub overrides: Overrides,
}

impl BuildOptions {
	pub fn new(faction: Faction) -> BuildOptions {
		BuildOptions { faction, band_width: 5.0, max_open: MAX_OPEN, extra_starts: Vec::new(), overrides: Overrides::shipped() }
	}
}

fn friendly(fac: Option<&str>, faction: Faction) -> bool {
	match fac {
		None | Some("") => true,
		Some(f) => match f.to_lowercase().as_str() {
			"a" | "alliance" => faction == Faction::Alliance,
			"h" | "horde" => faction == Faction::Horde,
			_ => true,
		},
	}
}

fn npc_level(raw: &Entity, fallback: Option<f64>) -> Option<f64> {
	let Some(lo) = raw.level.filter(|l| l.is_finite()) else { return fallback };
	let hi = raw.level_max.unwrap_or(lo);
	Some(js_round((lo + if hi.is_finite() { hi } else { lo }) / 2.0))
}

fn elite_rank(r: Option<f64>) -> bool {
	matches!(r, Some(x) if x == 1.0 || x == 2.0 || x == 3.0)
}

fn has_recorded_drop(item: &Item) -> bool {
	item.drops.as_ref().is_some_and(|d| Kind::BOTH.iter().any(|&k| d.of(k).values().any(|c| c.is_some_and(|c| c > 0.0))))
}

fn unknown_drop(item: &Item) -> f64 {
	if item.quest_item == Some(true) {
		UNKNOWN_QUEST_DROP
	} else {
		UNKNOWN_DROP
	}
}

/// Greedy density clustering on world points (world.js cluster).
struct Cl {
	seed: usize,
	members: Vec<usize>,
	cx: f64,
	cy: f64,
	size: u32,
}

fn cell_key(gx: i64, gy: i64) -> i64 {
	gx * 100003 + gy
}

fn cluster(pts: &[(i64, f64, f64)], r: f64) -> Vec<Cl> {
	let n = pts.len();
	if n == 0 {
		return Vec::new();
	}
	let mut cell: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
	for (i, p) in pts.iter().enumerate() {
		cell.entry(cell_key((p.1 / r).floor() as i64, (p.2 / r).floor() as i64)).or_default().push(i);
	}
	let r2 = r * r;
	let nb: Vec<Vec<usize>> = (0..n)
		.map(|i| {
			let mut out = Vec::new();
			let gx = (pts[i].1 / r).floor() as i64;
			let gy = (pts[i].2 / r).floor() as i64;
			for dx in -1..=1 {
				for dy in -1..=1 {
					if let Some(list) = cell.get(&cell_key(gx + dx, gy + dy)) {
						for &j in list {
							if pts[j].0 != pts[i].0 {
								continue;
							}
							let ddx = pts[j].1 - pts[i].1;
							let ddy = pts[j].2 - pts[i].2;
							if ddx * ddx + ddy * ddy <= r2 {
								out.push(j);
							}
						}
					}
				}
			}
			out
		})
		.collect();
	let mut order: Vec<usize> = (0..n).collect();
	order.sort_by(|&a, &b| nb[b].len().cmp(&nb[a].len()).then(a.cmp(&b)));
	let mut used = vec![false; n];
	let mut out = Vec::new();
	for s in order {
		if used[s] {
			continue;
		}
		let members: Vec<usize> = nb[s].iter().copied().filter(|&j| !used[j]).collect();
		for &j in &members {
			used[j] = true;
		}
		let mut cx = 0.0;
		let mut cy = 0.0;
		for &j in &members {
			cx += pts[j].1;
			cy += pts[j].2;
		}
		let len = members.len() as f64;
		out.push(Cl { seed: s, size: members.len() as u32, cx: cx / len, cy: cy / len, members });
	}
	out
}

/// A spawn record of an entity in world yards (sites()).
#[derive(Clone, Copy)]
struct Sp {
	c: i64,
	wx: f64,
	wy: f64,
	region: i64,
	map: u32,
	f_live: Option<bool>,
	edge: f64,
}

#[derive(Clone, Debug)]
pub(crate) struct Site {
	pt: u32,
	size: u32,
	spacing: f64,
	#[allow(dead_code)]
	map: u32,
	f: Option<String>,
}

pub(crate) struct Ent {
	id: u32,
	name: String,
	friendly: bool,
	total: usize,
	sites: Vec<Site>,
	spawns: Vec<SpawnPt>,
	rank: Option<f64>,
	faction: Option<String>,
	raw_level: Option<f64>,
	raw_level_max: Option<f64>,
}

impl Ent {
	fn level(&self, fallback: Option<f64>) -> Option<f64> {
		npc_level(&Entity { level: self.raw_level, level_max: self.raw_level_max, ..Entity::default() }, fallback)
	}
	fn faction_truthy(&self) -> bool {
		self.faction.as_deref().is_some_and(|f| !f.is_empty())
	}
}

type PointKey = (i64, u64, u64, Option<i64>);

fn bits(x: f64) -> u64 {
	(x + 0.0).to_bits()
}

pub(crate) struct Builder<'a> {
	d: &'a GameData,
	faction: Faction,
	era: FxHashMap<u32, Rect>,
	live: FxHashMap<u32, Rect>,
	pub(crate) points: Vec<Point>,
	point_idx: FxHashMap<PointKey, u32>,
	pub(crate) heights: Heights,
	floors: &'a dyn Floors,
	floor_memo: FxHashMap<(i64, u64, u64, Option<u64>), Option<(f64, u32)>>,
	/// Places the floors source didn't know (a cache built for other points).
	pub(crate) floor_misses: u32,
	vote_grid: Option<FxHashMap<(i64, i64, i64), Vec<(u32, u32)>>>,
	vote_cache: FxHashMap<(i64, i64, i64), Rc<Vec<(u32, u32)>>>,
	site_cache: FxHashMap<(Kind, i64), Option<Rc<Ent>>>,
	pub(crate) camps: Vec<Camp>,
}

impl<'a> Builder<'a> {
	fn new(d: &'a GameData, faction: Faction, floors: &'a dyn Floors) -> Self {
		let (era, live) = d.frame_maps();
		let rect = |m: FxHashMap<u32, forge_core::Bounds>| m.into_iter().filter_map(|(k, b)| Some((k, b.rect()?))).collect();
		Builder {
			d,
			faction,
			era: rect(era),
			live: rect(live),
			points: Vec::new(),
			point_idx: FxHashMap::default(),
			heights: Heights::default(),
			floors,
			floor_memo: FxHashMap::default(),
			floor_misses: 0,
			vote_grid: None,
			vote_cache: FxHashMap::default(),
			site_cache: FxHashMap::default(),
			camps: Vec::new(),
		}
	}

	fn allowed_map(&self, m: u32) -> bool {
		self.d.zones.get(&m).is_some_and(|z| z.kind == Some(3.0)) && !BATTLEGROUNDS.contains(&m)
	}

	fn frame_of(&self, map: u32, live: bool) -> Option<Rect> {
		if live {
			if let Some(b) = self.live.get(&map) {
				return Some(*b);
			}
		}
		self.era.get(&map).or_else(|| self.live.get(&map)).copied()
	}

	/// (c, wx, wy) of map percent.
	fn to_world(&self, map: u32, x: f64, y: f64, live: bool) -> (i64, f64, f64) {
		match self.frame_of(map, live) {
			Some(b) => (b.c, b.top + ((b.bottom - b.top) * y) / 100.0, b.left + ((b.right - b.left) * x) / 100.0),
			None => (1000 + map as i64, -10.0 * y, -10.0 * x),
		}
	}

	fn inner_box(&self, map: u32, live: bool) -> Option<(i64, f64, f64, f64, f64)> {
		let fr = self.frame_of(map, live)?;
		if (fr.right - fr.left).abs() > 0.0 && (fr.bottom - fr.top).abs() > 0.0 {
			Some((fr.c, fr.left.min(fr.right), fr.left.max(fr.right), fr.top.min(fr.bottom), fr.top.max(fr.bottom)))
		} else {
			None
		}
	}

	// maps/inner.js moreInner(b, a).
	fn inner_map(&self, a: &Sp, b: &Sp) -> bool {
		let bb = self.inner_box(a.map, a.f_live == Some(true));
		let aa = self.inner_box(b.map, b.f_live == Some(true));
		let enclosed = |x: Option<(i64, f64, f64, f64, f64)>| x.is_some_and(|x| (x.2 - x.1).max(x.4 - x.3) <= 1500.0);
		if enclosed(bb) && !enclosed(aa) {
			return true;
		}
		match (bb, aa) {
			(Some(b), Some(a)) if b.0 == a.0 => b.1 >= a.1 && b.2 <= a.2 && b.3 >= a.3 && b.4 <= a.4 && (b.2 - b.1) * (b.4 - b.3) < (a.2 - a.1) * (a.4 - a.3),
			_ => false,
		}
	}

	fn spawnz_list(&self, kind: Kind, id: u32) -> &[Vec<Option<f64>>] {
		self.d.spawnz.as_ref().and_then(|s| s.of(kind).get(&id)).map(Vec::as_slice).unwrap_or(&[])
	}

	fn height_of(&self, kind: Kind, id: u32, c: i64, wx: f64, wy: f64, yards: f64) -> Option<f64> {
		let mut best = None;
		let mut bd = yards;
		for s in self.spawnz_list(kind, id) {
			if s.first().copied().flatten() != Some(c as f64) {
				continue;
			}
			let g = |i: usize| s.get(i).copied().flatten().unwrap_or(0.0);
			let d = js_hypot(g(1) - wx, g(2) - wy);
			if d <= bd {
				bd = d;
				best = s.get(3).copied().flatten();
			}
		}
		best
	}

	fn entity_point(&mut self, kind: Kind, id: u32, c: i64, wx: f64, wy: f64, map: u32) -> u32 {
		let z = self.height_of(kind, id, c, wx, wy, HEIGHT_YARDS);
		let hint = if z.is_none() { self.height_of(kind, id, c, wx, wy, HINT_YARDS) } else { None };
		self.add_point(c, wx, wy, map, z, hint)
	}

	fn floor_at(&mut self, c: i64, wx: f64, wy: f64, hint: Option<f64>) -> Option<(f64, u32)> {
		let k = (c, bits(wx), bits(wy), hint.map(bits));
		if let Some(v) = self.floor_memo.get(&k) {
			return *v;
		}
		let v = match self.floors.surfaces(c, wx, wy) {
			Some(s) => floor_of(&s, hint),
			None => {
				self.floor_misses += 1;
				None
			}
		};
		self.floor_memo.insert(k, v);
		v
	}

	pub(crate) fn add_point(&mut self, c: i64, wx: f64, wy: f64, map: u32, z: Option<f64>, hint: Option<f64>) -> u32 {
		let rx = js_round(wx * 10.0) / 10.0;
		let ry = js_round(wy * 10.0) / 10.0;
		let region = region_of(c, map);
		let (z, from) = match z {
			Some(z) => (Some(z), 0),
			None => match self.floor_at(c, rx, ry, hint) {
				None => (None, 4),
				Some((z, floors)) => (
					Some(z),
					if floors < 2 {
						1
					} else if hint.is_some() {
						2
					} else {
						3
					},
				),
			},
		};
		let key = (region, bits(rx), bits(ry), z.map(|z| js_round(z / Z_STEP) as i64));
		if let Some(&i) = self.point_idx.get(&key) {
			return i;
		}
		let i = self.points.len() as u32;
		self.points.push(Point { c, region, wx: rx, wy: ry, map, z: z.map(|z| js_round(z * 10.0) / 10.0) });
		self.point_idx.insert(key, i);
		match from {
			0 => self.heights.source += 1,
			1 => self.heights.floor += 1,
			2 => self.heights.hinted += 1,
			3 => self.heights.ambiguous += 1,
			_ => self.heights.none += 1,
		}
		i
	}

	pub(crate) fn dist(&self, a: u32, b: u32) -> f64 {
		let (pa, pb) = (&self.points[a as usize], &self.points[b as usize]);
		if pa.region != pb.region {
			return f64::INFINITY;
		}
		js_hypot(pa.wx - pb.wx, pa.wy - pb.wy)
	}

	// ---- zone vote ----
	fn votes(&mut self, region: i64, wx: f64, wy: f64) -> Rc<Vec<(u32, u32)>> {
		let gx = (wx / VOTE_R).floor() as i64;
		let gy = (wy / VOTE_R).floor() as i64;
		if let Some(v) = self.vote_cache.get(&(region, gx, gy)) {
			return v.clone();
		}
		if self.vote_grid.is_none() {
			let mut grid: FxHashMap<(i64, i64, i64), Vec<(u32, u32)>> = FxHashMap::default();
			for set in [&self.d.npcs, &self.d.objects] {
				for raw in set.values() {
					for (&map, sp) in &raw.spawns {
						if !self.allowed_map(map) {
							continue;
						}
						let live = sp.f.as_deref() == Some("l");
						for q in &sp.pts {
							if q.len() < 2 {
								continue;
							}
							let (c, x, y) = self.to_world(map, q[0], q[1], live);
							let k = (region_of(c, map), (x / VOTE_R).floor() as i64, (y / VOTE_R).floor() as i64);
							let m = grid.entry(k).or_default();
							match m.iter_mut().find(|e| e.0 == map) {
								Some(e) => e.1 += 1,
								None => m.push((map, 1)),
							}
						}
					}
				}
			}
			self.vote_grid = Some(grid);
		}
		let grid = self.vote_grid.as_ref().expect("vote grid");
		let mut out: Vec<(u32, u32)> = Vec::new();
		for dx in -1..=1 {
			for dy in -1..=1 {
				if let Some(m) = grid.get(&(region, gx + dx, gy + dy)) {
					for &(map, n) in m {
						match out.iter_mut().find(|e| e.0 == map) {
							Some(e) => e.1 += n,
							None => out.push((map, n)),
						}
					}
				}
			}
		}
		let out = Rc::new(out);
		self.vote_cache.insert((region, gx, gy), out.clone());
		out
	}

	/// dedupeMaps' `better(a, b)` (> 0: a's map is the better home).
	fn better(&mut self, a: &Sp, b: &Sp, per_map: &[(u32, u32)]) -> f64 {
		if a.map == b.map {
			return a.edge - b.edge;
		}
		if self.inner_map(a, b) {
			return 1.0;
		}
		if self.inner_map(b, a) {
			return -1.0;
		}
		let v = self.votes(a.region, a.wx, a.wy);
		let get = |m: u32| v.iter().find(|e| e.0 == m).map_or(0.0, |e| e.1 as f64);
		let r = get(a.map) - get(b.map);
		if r != 0.0 {
			return r;
		}
		let pm = |m: u32| per_map.iter().find(|e| e.0 == m).map_or(0.0, |e| e.1 as f64);
		let r = pm(a.map) - pm(b.map);
		if r != 0.0 {
			return r;
		}
		a.edge - b.edge
	}

	/// world.js sites(kind, id).
	pub(crate) fn sites(&mut self, kind: Kind, id: i64) -> Option<Rc<Ent>> {
		if let Some(v) = self.site_cache.get(&(kind, id)) {
			return v.clone();
		}
		let out = self.make_sites(kind, id).map(Rc::new);
		self.site_cache.insert((kind, id), out.clone());
		out
	}

	fn make_sites(&mut self, kind: Kind, id: i64) -> Option<Ent> {
		let d = self.d;
		let raw = u32::try_from(id).ok().and_then(|i| d.entities(kind).get(&i))?;
		let mut all: Vec<Sp> = Vec::new();
		for (&map, sp) in &raw.spawns {
			if !self.allowed_map(map) {
				continue;
			}
			let live = sp.f.as_deref() == Some("l");
			let f_live = sp.f.as_deref().map(|f| f == "l");
			for p in sp.pts.iter().chain(sp.more.iter().flatten()) {
				if p.len() < 2 {
					continue;
				}
				let (c, wx, wy) = self.to_world(map, p[0], p[1], live);
				let edge = p[0].min(100.0 - p[0]).min(p[1]).min(100.0 - p[1]);
				all.push(Sp { c, wx, wy, region: region_of(c, map), map, f_live, edge });
			}
		}
		if all.is_empty() {
			return None;
		}
		// dedupeMaps
		let mut per_map: Vec<(u32, u32)> = Vec::new();
		for p in &all {
			match per_map.iter_mut().find(|e| e.0 == p.map) {
				Some(e) => e.1 += 1,
				None => per_map.push((p.map, 1)),
			}
		}
		let map_pts: Vec<Sp> = if per_map.len() < 2 {
			all
		} else {
			let mut cell: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
			for (i, p) in all.iter().enumerate() {
				cell.entry(cell_key((p.wx / DUP_R).floor() as i64, (p.wy / DUP_R).floor() as i64)).or_default().push(i);
			}
			let mut drop = vec![false; all.len()];
			for i in 0..all.len() {
				let p = all[i];
				let gx = (p.wx / DUP_R).floor() as i64;
				let gy = (p.wy / DUP_R).floor() as i64;
				'dx: for dx in -1..=1 {
					if drop[i] {
						break;
					}
					for dy in -1..=1 {
						if drop[i] {
							continue 'dx;
						}
						let list = cell.get(&cell_key(gx + dx, gy + dy)).cloned().unwrap_or_default();
						for j in list {
							let q = all[j];
							if drop[j] || q.map == p.map || q.region != p.region || js_hypot(q.wx - p.wx, q.wy - p.wy) > DUP_R {
								continue;
							}
							if self.better(&q, &p, &per_map) > 0.0 {
								drop[i] = true;
								break;
							}
							drop[j] = true;
						}
					}
				}
			}
			all.into_iter().enumerate().filter(|(i, _)| !drop[*i]).map(|(_, p)| p).collect()
		};
		let mut pts: Vec<Sp> = Vec::new();
		for p in map_pts {
			if !pts.iter().any(|u| u.region == p.region && js_hypot(u.wx - p.wx, u.wy - p.wy) <= SPAWN_DUP_R) {
				pts.push(p);
			}
		}
		let flat: Vec<(i64, f64, f64)> = pts.iter().map(|p| (p.region, p.wx, p.wy)).collect();
		let mut sites = Vec::new();
		for c in cluster(&flat, SITE_R) {
			let mut home = pts[c.seed];
			for &m in &c.members {
				if self.better(&pts[m], &home, &per_map) > 0.0 {
					home = pts[m];
				}
			}
			let pt = self.entity_point(kind, id as u32, home.c, c.cx, c.cy, home.map);
			sites.push(Site { pt, size: c.size, spacing: spacing_of(&pts, &c.members), map: home.map, f: home.f_live.map(|l| if l { "l".to_string() } else { "e".to_string() }) });
		}
		// f: the spawn's own frame string (anything not "l" projects through Era).
		Some(Ent {
			id: id as u32,
			name: raw.name.clone().unwrap_or_else(|| format!("{} {}", kind.as_str(), id)),
			friendly: kind == Kind::Object || friendly(raw.faction.as_deref(), self.faction),
			total: pts.len(),
			sites,
			spawns: pts.iter().map(|p| SpawnPt { c: p.c, region: p.region, wx: p.wx, wy: p.wy, map: p.map }).collect(),
			rank: raw.rank,
			faction: raw.faction.clone(),
			raw_level: raw.level,
			raw_level_max: raw.level_max,
		})
	}

	/// posOf(site).
	fn pos_of(&self, pt: u32, f: Option<&str>) -> Pos {
		let p = self.points[pt as usize];
		match self.frame_of(p.map, f == Some("l")) {
			None => Pos { map: p.map, x: round1(-p.wy / 10.0), y: round1(-p.wx / 10.0), in_dungeon: false },
			Some(b) => Pos { map: p.map, x: round1(((p.wy - b.left) * 100.0) / (b.right - b.left)), y: round1(((p.wx - b.top) * 100.0) / (b.bottom - b.top)), in_dungeon: false },
		}
	}

	/// bestSite(ent, anchor): score = min(size, 12) / (1 + d/400).
	fn best_site(&self, ent: &Ent, anchor: Option<u32>) -> Site {
		let mut best: Option<&Site> = None;
		let mut bs = f64::NEG_INFINITY;
		for s in &ent.sites {
			let d = anchor.map_or(0.0, |a| self.dist(s.pt, a));
			if !d.is_finite() && anchor.is_some() {
				continue;
			}
			let sc = (s.size.min(12) as f64) / (1.0 + d / 400.0);
			if sc > bs {
				bs = sc;
				best = Some(s);
			}
		}
		best.unwrap_or(&ent.sites[0]).clone()
	}
}

fn spacing_of(pts: &[Sp], members: &[usize]) -> f64 {
	if members.len() < 2 {
		return 0.0;
	}
	let m = &members[..members.len().min(60)];
	let mut sum = 0.0;
	for &i in m {
		let mut best = f64::INFINITY;
		for &j in members {
			if i == j {
				continue;
			}
			let d = js_hypot(pts[i].wx - pts[j].wx, pts[i].wy - pts[j].wy);
			if d < best {
				best = d;
			}
		}
		sum += best;
	}
	sum / m.len() as f64
}

// ---- camps host ----
struct Host<'b, 'a> {
	b: &'b mut Builder<'a>,
}

impl CampHost for Host<'_, '_> {
	fn spawns_of(&mut self, kind: Kind, id: u32) -> Vec<SpawnPt> {
		self.b.sites(kind, id as i64).map(|e| e.spawns.clone()).unwrap_or_default()
	}
	fn level_of(&self, kind: Kind, id: u32) -> Option<f64> {
		if kind != Kind::Npc {
			return None;
		}
		self.b.d.npcs.get(&id).and_then(|n| npc_level(n, None))
	}
	fn respawn_of(&self, kind: Kind, id: u32) -> Option<f64> {
		if kind == Kind::Object {
			let f = self.b.d.object_facts.as_ref().and_then(|o| o.get(&id));
			if let Some(f) = f {
				if f.kind.is_some_and(|t| USED_OBJECT_TYPES.contains(&t)) {
					return Some(USED_OBJECT_RESPAWN);
				}
				if let Some(r) = f.respawn.filter(|r| *r > 0.0) {
					return Some(r);
				}
			}
			return Some(OBJECT_RESPAWN_EST);
		}
		let mut r: Vec<f64> = self.b.spawnz_list(kind, id).iter().filter_map(|s| s.get(4).copied().flatten()).filter(|x| x.is_finite()).collect();
		r.sort_by(|a, b| a.partial_cmp(b).unwrap());
		(!r.is_empty()).then(|| r[r.len() / 2])
	}
	fn point_at(&mut self, kind: Kind, id: u32, s: &SpawnPt) -> u32 {
		self.b.entity_point(kind, id, s.c, s.wx, s.wy, s.map)
	}
	fn add_camp(&mut self, camp: NewCamp) -> u32 {
		let elite = camp.sources.iter().any(|s| s.kind == Kind::Npc && elite_rank(self.b.d.npcs.get(&s.id).and_then(|n| n.rank)));
		let id = self.b.camps.len() as u32;
		self.b.camps.push(Camp {
			id,
			pt: camp.pt,
			c: camp.c,
			region: camp.region,
			radius: camp.radius,
			spawns: camp.spawns,
			level_min: camp.level_min,
			level_max: camp.level_max,
			respawn: camp.respawn,
			sources: camp.sources,
			elite,
		});
		id
	}
}

/// A drop source with its chance (world.js `sources`).
#[derive(Clone, Copy)]
struct Src {
	kind: Kind,
	id: u32,
	chance: Option<f64>,
}

fn chances_of(sources: &[Src]) -> Vec<(String, Option<f64>)> {
	let mut out: Vec<(String, Option<f64>)> = Vec::new();
	for s in sources {
		let k = format!("{}:{}", s.kind.as_str(), s.id);
		match out.iter_mut().find(|e| e.0 == k) {
			Some(e) => e.1 = s.chance,
			None => out.push((k, s.chance)),
		}
	}
	out
}

struct Located {
	pt: u32,
	work: Work,
	ois: Vec<i64>,
}

struct Regexes {
	talk: Regex,
	deed: Regex,
	defend: Regex,
	unused: Regex,
	escort: Regex,
	count: Regex,
	food: Regex,
	ammo: Regex,
}

impl Regexes {
	fn new() -> Regexes {
		let r = |s: &str| Regex::new(s).expect("regex");
		Regexes {
			talk: r(r"(?i)^\s*(speak|listen|talk|hear|show|wait|watch)(?-u:\b)"),
			deed: r(r"(?i)^\s*(find|heal|use|locate|keep searching)(?-u:\b)"),
			defend: r(r"(?i)(?-u:\b)protect(?-u:\b)|(?-u:\b)defend(?-u:\b)|(?-u:\b)keep .* safe|(?-u:\b)guide .* safely|(?-u:\b)lead .* to safety|(?-u:\b)escape(?-u:\b)"),
			unused: r(r"(?i)(?-u:\b)(UNUSED|NYI|TEST|DEPRECATED)(?-u:\b)|^\[|<.*>|\(123\)"),
			escort: r(r"(?i)escort"),
			count: r(r"^\s*[A-Za-z']+\s+([0-9]+)(?-u:\b)"),
			food: r(r"(?i)innkeeper|food|drink|baker|butcher|general (goods|supplies)|bartender"),
			ammo: r(r"(?i)bowyer|gunsmith|ammunition|arrows|bullets"),
		}
	}
}

/// dsl/escort.js isEscort.
pub fn is_escort(q: &Quest, escort_re: &Regex) -> bool {
	if let Some(b) = q.escort {
		return b;
	}
	q.objectives.iter().flatten().any(|o| o.kind == "event" && o.text.as_deref().is_some_and(|t| escort_re.is_match(t))) || q.objective_text.as_deref().is_some_and(|t| escort_re.is_match(t))
}

fn sorted_unique(mut v: Vec<i64>) -> Vec<i64> {
	v.sort_unstable();
	v.dedup();
	v
}

/// Builds one faction's world. `floors`: heights for points without a spawn's (the walking
/// grid; FloorCache reads the JS builder's cache). -> (world, floor places the source lacked).
pub fn build_world(d: &GameData, opts: &BuildOptions, floors: &dyn Floors) -> Result<(World, u32), String> {
	let faction = opts.faction;
	let band_width = opts.band_width;
	let max_open = opts.max_open;
	let mut warnings: Vec<String> = Vec::new();
	let re = Regexes::new();
	let mut b = Builder::new(d, faction, floors);
	let zone_name = |m: u32| d.zones.get(&m).and_then(|z| z.name.clone()).filter(|n| !n.is_empty()).unwrap_or_else(|| format!("map {m}"));
	let empty = Value::Null;
	let travel = d.travel.as_ref().unwrap_or(&empty);

	// ---- reference: taxi/transport/inns ----
	let mut nodes: Vec<Node> = Vec::new();
	let mut node_by_taxi: Vec<(String, u32)> = Vec::new();
	let fbit = f64::from(faction.bit());
	let fac_ok = |v: Option<&Value>| (num(v) as i64 & fbit as i64) != 0;
	let mut fp_npc: Vec<(String, Option<u32>)> = Vec::new();
	let arr = |v: Option<&Value>| v.and_then(Value::as_array).cloned().unwrap_or_default();
	let u32of = |v: Option<&Value>| -> u32 {
		let n = num(v);
		if n.is_finite() && n >= 0.0 {
			n as u32
		} else {
			0
		}
	};
	let taxi_doc = travel.get("taxi");
	for n in arr(taxi_doc.and_then(|t| t.get("nodes"))) {
		if !fac_ok(n.get("faction")) {
			continue;
		}
		let c = num(n.get("c")) as i64;
		let (wx, wy, map) = (num(n.get("wx")), num(n.get("wy")), u32of(n.get("map")));
		let pt = if truthy(n.get("npc")) { b.entity_point(Kind::Npc, u32of(n.get("npc")), c, wx, wy, map) } else { b.add_point(c, wx, wy, map, None, None) };
		let key = js_str(n.get("id"));
		node_by_taxi.push((key.clone(), nodes.len() as u32));
		let npc = num(n.get("npc"));
		fp_npc.push((key, (npc != 0.0 && !npc.is_nan()).then_some(npc as u32)));
		let name = if truthy(n.get("short")) { js_str(n.get("short")) } else { js_str(n.get("name")) };
		nodes.push(Node { kind: "fp", taxi: finite(n.get("id")), name, pt });
	}
	let taxi_node = |k: &str| node_by_taxi.iter().find(|e| e.0 == k).map(|e| e.1);
	let mut taxi: Vec<(u32, u32, Value)> = Vec::new();
	for l in arr(taxi_doc.and_then(|t| t.get("legs"))) {
		if let (Some(a), Some(bb)) = (taxi_node(&js_str(l.get("from"))), taxi_node(&js_str(l.get("to")))) {
			taxi.push((a, bb, l.get("cost").cloned().unwrap_or(Value::Null)));
		}
	}
	let end_z = |end: &Value| -> Option<f64> {
		let z = match end.get("board").filter(|b| truthy(Some(b))).and_then(|b| finite(b.get("z"))) {
			Some(z) => Some(z),
			None => finite(end.get("z")),
		};
		z.filter(|z| z.is_finite())
	};
	let mut rides: Vec<Ride> = Vec::new();
	for t in arr(travel.get("transports")) {
		if !fac_ok(t.get("faction")) {
			continue;
		}
		let (ta, tb) = (&t["a"], &t["b"]);
		let da = ta.get("board").filter(|x| truthy(Some(x))).unwrap_or(ta);
		let db = tb.get("board").filter(|x| truthy(Some(x))).unwrap_or(tb);
		let kind = js_str(t.get("kind"));
		let a = nodes.len() as u32;
		let pa = b.add_point(num(ta.get("c")) as i64, num(da.get("wx")), num(da.get("wy")), u32of(ta.get("map")), end_z(ta), None);
		nodes.push(Node { kind: "dock", taxi: None, name: format!("{} ({kind})", js_str(ta.get("name"))), pt: pa });
		let bn = nodes.len() as u32;
		let pb = b.add_point(num(tb.get("c")) as i64, num(db.get("wx")), num(db.get("wy")), u32of(tb.get("map")), end_z(tb), None);
		nodes.push(Node { kind: "dock", taxi: None, name: format!("{} ({kind})", js_str(tb.get("name"))), pt: pb });
		let or0 = |v: Option<&Value>| if truthy(v) { num(v) } else { 0.0 };
		let id = t.get("id").cloned().unwrap_or(Value::Null);
		rides.push(Ride { a, b: bn, seconds: num(t.get("ab")), wait: or0(t.get("waitA")), id: id.clone() });
		rides.push(Ride { a: bn, b: a, seconds: num(t.get("ba")), wait: or0(t.get("waitB")), id });
	}
	let transit = travel.get("transit");
	let services_doc = transit.and_then(|t| t.get("services"));
	// Lifts.
	let mut city_of_area: FxHashMap<i64, u32> = FxHashMap::default();
	for z in d.zones.values() {
		if let Some(a) = z.area_id {
			if b.allowed_map(z.id) {
				city_of_area.insert(a as i64, z.id);
			}
		}
	}
	for (id, s) in entries(services_doc) {
		if s.get("kind").and_then(Value::as_str) != Some("lift") {
			continue;
		}
		if present(s.get("faction")) && !fac_ok(s.get("faction")) {
			continue;
		}
		let c = num(s.get("c")) as i64;
		let (wx, wy) = (num(s.get("wx")), num(s.get("wy")));
		let smap = finite(s.get("map")).map(|m| m as u32);
		let shared = match smap {
			Some(m) => Some(m),
			None => {
				let v = b.votes(c * 10, wx, wy);
				let mut best = None;
				let mut bn = 0;
				for &(map, n) in v.iter() {
					if n > bn {
						best = Some(map);
						bn = n;
					}
				}
				best
			}
		};
		let bottom = finite(s.get("bottom"));
		let top = finite(s.get("top"));
		let (bottom_map, top_map) = match smap {
			Some(m) => (Some(m), Some(m)),
			None => {
				let floors = [lift_floor(&mut b, c, wx, wy, s.get("bottom")), lift_floor(&mut b, c, wx, wy, s.get("top"))];
				let city = city_of_area.get(&(num(s.get("area")) as i64)).copied().filter(|_| num(s.get("area")).is_finite());
				if let Some(city) = city.filter(|_| floors[0].0 + floors[1].0 > 0) {
					let v = b.votes(c * 10, wx, wy);
					let mut outer = None;
					let mut on = 0;
					for &(map, n) in v.iter() {
						if map != city && n > on {
							outer = Some(map);
							on = n;
						}
					}
					let outer = outer.unwrap_or(city);
					if floors[0].0 >= floors[1].0 {
						(Some(city), Some(outer))
					} else {
						(Some(outer), Some(city))
					}
				} else {
					let pick = |i: usize| {
						let here = &floors[i];
						let other = &floors[1 - i];
						let mut best = shared;
						let mut bs = f64::NEG_INFINITY;
						for &(map, n) in &here.1 {
							let o = if other.0 > 0 { other.1.iter().find(|e| e.0 == map).map_or(0.0, |e| e.1 as f64) / other.0 as f64 } else { 0.0 };
							let score = n as f64 / here.0 as f64 - o;
							if score > bs {
								best = Some(map);
								bs = score;
							}
						}
						best
					};
					(pick(0), pick(1))
				}
			}
		};
		if let Some((_, want)) = CITY_LIFT_FLOOR.iter().find(|e| e.0 == id) {
			let city = city_of_area.get(&(num(s.get("area")) as i64)).copied();
			let got = if bottom_map == city && top_map != city {
				Some("bottom")
			} else if top_map == city && bottom_map != city {
				Some("top")
			} else {
				None
			};
			if got != Some(*want) {
				let m = |x: Option<u32>| x.map_or("null".to_string(), |v| v.to_string());
				warnings.push(format!("lift {id}: the city (map {}) should be its {want} end; got bottom {}, top {}", m(city), m(bottom_map), m(top_map)));
			}
		}
		let a = nodes.len() as u32;
		let pa = b.add_point(c, wx, wy, bottom_map.unwrap_or(0), bottom, None);
		nodes.push(Node { kind: "lift", taxi: None, name: format!("{id} (bottom)"), pt: pa });
		let bn = nodes.len() as u32;
		let pb = b.add_point(c, wx, wy, top_map.unwrap_or(0), top, None);
		nodes.push(Node { kind: "lift", taxi: None, name: format!("{id} (top)"), pt: pb });
		let or0 = |v: Option<&Value>| if truthy(v) { num(v) } else { 0.0 };
		let ride = s.get("ride");
		let wait = s.get("wait");
		rides.push(Ride { a, b: bn, seconds: num(ride.and_then(|r| r.get("a"))), wait: or0(wait.and_then(|w| w.get("a"))), id: json!(id) });
		rides.push(Ride { a: bn, b: a, seconds: num(ride.and_then(|r| r.get("b"))), wait: or0(wait.and_then(|w| w.get("b"))), id: json!(id) });
	}
	for r in &mut rides {
		let key = js_str(Some(&r.id));
		if let Some(svc) = services_doc.and_then(|s| s.get(&key)) {
			if svc.get("kind").and_then(Value::as_str) == Some("tram") {
				let or0 = |v: Option<&Value>| if truthy(v) { num(v) } else { 0.0 };
				r.seconds += or0(svc.get("pre")) + or0(svc.get("post"));
			}
		}
	}
	let inn_ok = |inn: &Value| -> bool {
		let npc = d.npcs.get(&u32of(inn.get("npc"))).filter(|_| present(inn.get("npc")));
		npc.is_none_or(|n| friendly(n.faction.as_deref(), faction))
	};
	let mut anchors: Vec<(i64, f64, f64)> = nodes.iter().filter(|n| n.kind == "fp").map(|n| (b.points[n.pt as usize].region, b.points[n.pt as usize].wx, b.points[n.pt as usize].wy)).collect();
	for inn in arr(travel.get("inns")) {
		if inn_ok(&inn) {
			anchors.push((region_of(num(inn.get("c")) as i64, u32of(inn.get("map"))), num(inn.get("wx")), num(inn.get("wy"))));
		}
	}
	let own_end = |e: &Value| {
		let region = region_of(num(e.get("c")) as i64, u32of(e.get("map")));
		anchors.iter().any(|x| x.0 == region && js_hypot(x.1 - num(e.get("wx")), x.2 - num(e.get("wy"))) <= PORTAL_NEAR)
	};
	for p in arr(transit.and_then(|t| t.get("portals"))) {
		if present(p.get("faction")) && !fac_ok(p.get("faction")) {
			continue;
		}
		if !own_end(&p["a"]) || !own_end(&p["b"]) {
			continue;
		}
		let (pa_, pb_) = (&p["a"], &p["b"]);
		let a = nodes.len() as u32;
		let pa = b.add_point(num(pa_.get("c")) as i64, num(pa_.get("wx")), num(pa_.get("wy")), u32of(pa_.get("map")), end_z(pa_), None);
		nodes.push(Node { kind: "portal", taxi: None, name: js_str(p.get("id")), pt: pa });
		let bn = nodes.len() as u32;
		let pb = b.add_point(num(pb_.get("c")) as i64, num(pb_.get("wx")), num(pb_.get("wy")), u32of(pb_.get("map")), end_z(pb_), None);
		nodes.push(Node { kind: "portal", taxi: None, name: format!("{} (arrival)", js_str(p.get("id"))), pt: pb });
		let secs = if truthy(p.get("seconds")) { num(p.get("seconds")) } else { 5.0 };
		rides.push(Ride { a, b: bn, seconds: secs, wait: 0.0, id: p.get("id").cloned().unwrap_or(Value::Null) });
	}
	for x in skyborne_exits(faction) {
		let (c, wx, wy) = b.to_world(x.a.0, x.a.1, x.a.2, true);
		let a = nodes.len() as u32;
		let pa = b.add_point(c, wx, wy, x.a.0, None, None);
		nodes.push(Node { kind: "dock", taxi: None, name: x.name.into(), pt: pa });
		let bn = nodes.len() as u32;
		let pb = b.add_point(x.b.0, x.b.1, x.b.2, x.b.3, None, None);
		nodes.push(Node { kind: "dock", taxi: None, name: format!("{} (arrival)", x.name), pt: pb });
		rides.push(Ride { a, b: bn, seconds: x.ab, wait: x.wait, id: json!(x.name) });
	}
	let mut inns: Vec<Inn> = Vec::new();
	for inn in arr(travel.get("inns")) {
		if !inn_ok(&inn) {
			continue;
		}
		let c = num(inn.get("c")) as i64;
		let (wx, wy, map) = (num(inn.get("wx")), num(inn.get("wy")), u32of(inn.get("map")));
		let pt = if truthy(inn.get("npc")) { b.entity_point(Kind::Npc, u32of(inn.get("npc")), c, wx, wy, map) } else { b.add_point(c, wx, wy, map, None, None) };
		inns.push(Inn { name: inn.get("location").cloned().unwrap_or(Value::Null), pt });
	}

	// ---- quests ----
	let mut excluded: Vec<Excluded> = Vec::new();
	let mut camp_cache: FxHashMap<String, Vec<u32>> = FxHashMap::default();
	let mut reward_items: FxHashSet<i64> = FxHashSet::default();
	for r in d.quests.values() {
		if let Some(w) = &r.web {
			for e in w.items.iter().chain(&w.choices) {
				reward_items.insert(num(e.first()) as i64);
			}
		}
	}
	let solo = &opts.overrides;
	let quest_areas = d.quest_areas.as_ref();
	let mut dungeon_quest_ids: FxHashSet<i64> = FxHashSet::default();
	for dg in arr(d.dungeons.as_ref().and_then(|x| x.get("dungeons"))) {
		for dq in arr(dg.get("quests")) {
			if !truthy(dq.get("hidden")) {
				dungeon_quest_ids.insert(num(dq.get("id")) as i64);
			}
		}
	}
	let mut solo_out: FxHashMap<u32, &'static str> = FxHashMap::default();
	let mut solo_counts: Vec<(&'static str, u32)> = solo::CATEGORIES.iter().map(|c| (*c, 0)).collect();
	let cat_static = |c: &str| -> &'static str { solo::CATEGORIES.iter().find(|x| **x == c).copied().unwrap_or("dungeon") };
	let mut repeat_no_xp = 0u32;
	// Handover rules for quests the data holds, validated (world.js; rules.js checkRules).
	let hand_rules: Vec<crate::data::Handover> = d.handovers().into_iter().filter(|r| d.quests.contains_key(&(r.quest as u32)) && r.quest.fract() == 0.0).collect();
	for r in &hand_rules {
		let fail = |m: String| Err(format!("handover rule {}: {m} (source {})", r.id, crate::json::stringify(r.raw.get("source").unwrap_or(&Value::Null))));
		if !(r.objective.fract() == 0.0 && r.objective >= 0.0) {
			return fail("objective must be an objective index (0-based)".into());
		}
		if !d.npcs.contains_key(&(r.npc as u32)) {
			return fail(format!("npc {} not in the world or the data", js_to_string(r.npc)));
		}
		if !d.items.contains_key(&(r.item as u32)) {
			return fail(format!("item {} not in the world or the data", js_to_string(r.item)));
		}
		let q = &d.quests[&(r.quest as u32)];
		let o = q.objectives.get(r.objective as usize).and_then(Option::as_ref);
		if !o.is_some_and(|o| o.kind == "item" && o.id == Some(r.item)) {
			return fail(format!("quest {} has no item objective {} for item {}", js_to_string(r.quest), js_to_string(r.objective), js_to_string(r.item)));
		}
		let n = &d.npcs[&(r.npc as u32)];
		if !n.spawns.iter().any(|(m, sp)| b.allowed_map(*m) && sp.pts.iter().any(|p| p.len() >= 2)) {
			return fail(format!("npc {} has no open-world spawn", js_to_string(r.npc)));
		}
	}
	let handover_of = |qid: u32, oi: usize| hand_rules.iter().find(|r| r.quest == qid as f64 && r.objective == oi as f64);

	let mut quests: Vec<WQuest> = Vec::new();
	let mut timed_ids: FxHashSet<u32> = FxHashSet::default();
	for (&id, raw) in &d.quests {
		let races = raw.races.filter(|r| *r != 0.0 && !r.is_nan()).unwrap_or(0.0);
		if races != 0.0 && !faction.mask_open(races as u64) {
			excluded.push(Excluded { id, title: raw.title.clone(), reason: "other faction".into(), category: None, code: "faction" });
			continue;
		}
		let mut ex = |excluded: &mut Vec<Excluded>, reason: String, category: Option<&'static str>, code: &'static str| {
			excluded.push(Excluded { id, title: raw.title.clone(), reason, category: category.map(String::from), code });
			if let Some(c) = category {
				solo_out.insert(id, c);
				if let Some(e) = solo_counts.iter_mut().find(|e| e.0 == c) {
					e.1 += 1;
				}
			}
		};
		let title = raw.title.clone().unwrap_or_else(|| format!("Quest {id}"));
		if re.unused.is_match(&title) {
			ex(&mut excluded, "unused/test quest".into(), None, "unused");
			continue;
		}
		if raw.event.is_some_and(|e| e != 0.0 && !e.is_nan()) {
			ex(&mut excluded, "seasonal event".into(), None, "event");
			continue;
		}
		let strict = !solo.allow.contains_key(&id);
		let sort_id = raw.zone.filter(|z| *z < 0.0).map(|z| -z);
		let skill = raw.skill.is_some_and(|s| s != 0.0 && !s.is_nan());
		if strict && (skill || sort_id.is_some_and(|s| PROFESSION_SORTS.contains(&(s as i64)) && s.fract() == 0.0)) {
			ex(&mut excluded, "profession".into(), None, "profession");
			continue;
		}
		let min_raw = raw.min_level.unwrap_or(0.0);
		let level = match raw.level.filter(|l| *l > 0.0) {
			Some(l) => l,
			None => {
				if min_raw != 0.0 && !min_raw.is_nan() {
					min_raw
				} else {
					1.0
				}
			}
		};
		let min_level = if min_raw > 0.0 { min_raw } else { (level - 5.0).max(1.0) };
		if min_level >= 60.0 {
			ex(&mut excluded, "needs level 60 (mount swaps, endgame)".into(), None, "endgame");
			continue;
		}
		let mut inst: Option<&'static str> = None;
		if strict {
			if let Some(listed) = solo.exclude.get(&id) {
				let cat = listed.category.as_deref().map(cat_static);
				ex(&mut excluded, format!("listed: {}", listed.reason), cat, "listed");
				continue;
			}
			inst = raw.area.filter(|a| a.fract() == 0.0 && *a >= 0.0).and_then(|a| quest_areas.and_then(|q| q.areas.get(&(a as u32)).copied())).or(if dungeon_quest_ids.contains(&(id as i64)) {
				Some("dungeon")
			} else {
				None
			});
			if raw.reputation.as_ref().is_some_and(|r| r.value.unwrap_or(0.0) > solo::FRIENDLY) {
				ex(&mut excluded, "needs reputation above Friendly".into(), Some("reputation"), "reputation");
				continue;
			}
		}
		let ex_inst = |ex: &mut dyn FnMut(&mut Vec<Excluded>, String, Option<&'static str>, &'static str), excluded: &mut Vec<Excluded>, inst: &'static str| {
			ex(excluded, format!("{inst} quest (instance area or dungeons.json)"), Some(inst), "dungeon");
		};
		let solo_dropper = |e: &Ent| !strict || !(elite_rank(e.rank) || e.level(Some(0.0)).unwrap_or(0.0) >= level + solo::HIGH_DROPPER);
		let start = &raw.start;
		let end = &raw.end;
		let end_anchor = |b: &mut Builder| -> Option<u32> {
			for k in Kind::BOTH {
				for &eid in end.of(k) {
					if let Some(e) = b.sites(k, eid) {
						if e.friendly {
							return Some(b.best_site(&e, None).pt);
						}
					}
				}
			}
			None
		};
		let mut giver: Option<u32> = None;
		let mut accept: Option<Task> = None;
		let mut g_name: Option<String> = None;
		let mut g_pos: Option<Pos> = None;
		'g: for k in Kind::BOTH {
			for &gid in start.of(k) {
				if let Some(e) = b.sites(k, gid) {
					if e.friendly {
						let anchor = if e.sites.len() > 1 { end_anchor(&mut b) } else { None };
						let s = b.best_site(&e, anchor);
						giver = Some(s.pt);
						g_name = Some(e.name.clone());
						g_pos = Some(b.pos_of(s.pt, s.f.as_deref()));
						break 'g;
					}
				}
			}
		}
		struct StartBest {
			e: Rc<Ent>,
			kind: Kind,
			chance: f64,
			score: f64,
			item_name: Option<String>,
		}
		let mut start_high: Option<StartBest> = None;
		let mut start_elite = false;
		let start_at = |b: &mut Builder, sb: &StartBest| -> (u32, String, Pos, Task) {
			let s = b.best_site(&sb.e, None);
			let name = format!("{} (drop: {})", sb.item_name.clone().filter(|n| !n.is_empty()).unwrap_or_else(|| "item".into()), sb.e.name);
			let n = 100.0 / sb.chance.min(100.0);
			let work = if sb.kind == Kind::Npc {
				Work::Kill { level: sb.e.level(Some(level)).unwrap_or(level), count: n, elite: elite_rank(sb.e.rank), spacing: s.spacing, npc: sb.e.id }
			} else {
				Work::Use(n)
			};
			(s.pt, name, b.pos_of(s.pt, s.f.as_deref()), Task { pt: s.pt, work: vec![work] })
		};
		if giver.is_none() {
			let mut best: Option<StartBest> = None;
			for &item_id in &start.item {
				let Some(item) = u32::try_from(item_id).ok().and_then(|i| d.items.get(&i)) else { continue };
				let Some(drops) = &item.drops else { continue };
				let recorded = has_recorded_drop(item);
				for k in Kind::BOTH {
					for (&eid, &ch) in drops.of(k) {
						let chance = match ch {
							None => {
								if recorded {
									0.0
								} else {
									unknown_drop(item)
								}
							}
							Some(c) => {
								if c.is_nan() {
									0.0
								} else {
									c
								}
							}
						};
						if chance < MIN_START_DROP {
							continue;
						}
						let Some(e) = b.sites(k, eid as i64) else { continue };
						if k == Kind::Npc && e.friendly && e.faction_truthy() {
							continue;
						}
						let score = chance * (e.total.min(20) as f64);
						let cand = StartBest { e: e.clone(), kind: k, chance, score, item_name: item.name.clone() };
						if k == Kind::Npc && !solo_dropper(&e) {
							if start_high.as_ref().is_none_or(|h| score > h.score) {
								start_high = Some(cand);
							}
							continue;
						}
						if best.as_ref().is_none_or(|h| score > h.score) {
							best = Some(cand);
						}
					}
				}
			}
			if let Some(bs) = best {
				let (pt, n, p, t) = start_at(&mut b, &bs);
				giver = Some(pt);
				g_name = Some(n);
				g_pos = Some(p);
				accept = Some(t);
			}
		}
		let mut start_from: Option<u32> = None;
		if giver.is_none() {
			if let Some(&from) = solo.start_item_from.get(&id) {
				let src = d.quests.get(&from);
				'sf: for k in Kind::BOTH {
					for &eid in src.map(|s| s.end.of(k)).unwrap_or(&[]) {
						let Some(e) = b.sites(k, eid) else { continue };
						if !e.friendly {
							continue;
						}
						let s = b.best_site(&e, None);
						giver = Some(s.pt);
						let st = src.and_then(|s| s.title.clone()).unwrap_or_else(|| "undefined".to_string());
						g_name = Some(format!("{} (turn in {st} for the item)", e.name));
						g_pos = Some(b.pos_of(s.pt, s.f.as_deref()));
						start_from = src.map(|s| s.id);
						break 'sf;
					}
				}
			}
		}
		if giver.is_none() {
			if let Some(sh) = &start_high {
				let (pt, n, p, t) = start_at(&mut b, sh);
				giver = Some(pt);
				g_name = Some(n);
				g_pos = Some(p);
				accept = Some(t);
				start_elite = elite_rank(sh.e.rank);
			}
		}
		let Some(giver) = giver else {
			match inst {
				Some(i) => ex_inst(&mut ex, &mut excluded, i),
				None => ex(&mut excluded, "no located quest giver".into(), None, "no-giver"),
			}
			continue;
		};
		// Ender.
		let mut ender: Option<u32> = None;
		let mut e_name = None;
		let mut e_pos = None;
		'e: for k in Kind::BOTH {
			for &eid in end.of(k) {
				if let Some(e) = b.sites(k, eid) {
					if e.friendly {
						let s = b.best_site(&e, Some(giver));
						ender = Some(s.pt);
						e_name = Some(e.name.clone());
						e_pos = Some(b.pos_of(s.pt, s.f.as_deref()));
						break 'e;
					}
				}
			}
		}
		let Some(ender) = ender else {
			match inst {
				Some(i) => ex_inst(&mut ex, &mut excluded, i),
				None => ex(&mut excluded, "no located turn-in".into(), None, "no-ender"),
			}
			continue;
		};
		let alts = |b: &mut Builder, list: &crate::data::Ends, g: bool| -> Option<Vec<(String, u32)>> {
			let mut out: Vec<(String, u32)> = Vec::new();
			let mut n = 0;
			for k in Kind::BOTH {
				for &eid in list.of(k) {
					let Some(e) = b.sites(k, eid) else { continue };
					if !e.friendly {
						continue;
					}
					let anchor = if g {
						if e.sites.len() > 1 {
							end_anchor(b)
						} else {
							None
						}
					} else {
						Some(giver)
					};
					let pt = b.best_site(&e, anchor).pt;
					let key = format!("{}:{eid}", k.as_str());
					match out.iter_mut().find(|x| x.0 == key) {
						Some(x) => x.1 = pt,
						None => out.push((key, pt)),
					}
					n += 1;
				}
			}
			(n > 1).then_some(out)
		};
		let g_alt = alts(&mut b, start, true);
		let e_alt = alts(&mut b, end, false);
		// Objectives.
		let objs = &raw.objectives;
		let mut located: Vec<Located> = Vec::new();
		let mut missing: Option<String> = None;
		let mut missing_cat: Option<&'static str> = None;
		let mut missing_code: &'static str = "";
		let mut elite = start_elite;
		let mut obj_camps: Vec<ObjCamp> = Vec::new();
		let mut obj_list: Vec<Obj> = Vec::new();
		let dur_of = |it: Option<f64>| -> f64 {
			let Some(it) = it else { return 0.0 };
			let dd = d.items.get(&(it as u32)).filter(|_| it.fract() == 0.0 && it >= 0.0).and_then(|i| i.duration).unwrap_or(f64::NAN);
			if dd > 0.0 {
				dd
			} else {
				0.0
			}
		};
		let add_obj =
			|obj_list: &mut Vec<Obj>, oi: i64, kind: &'static str, oid: Option<f64>, count: Option<f64>, item: Option<f64>, qi: bool, camps: Vec<u32>, chances: Vec<(String, Option<f64>)>| {
				let dur = dur_of(item);
				obj_list.push(Obj { oi, kind, id: oid, count: count.unwrap_or(1.0), item, quest_item: qi, camps, chances, task: None, dur: (dur != 0.0).then_some(dur) });
			};
		let mut outside = false;
		let escort = is_escort(raw, &re.escort);
		let timed_event = escort
			|| (raw.escort != Some(false)
				&& objs.iter().flatten().any(|o| {
					o.kind == "event" && {
						let parts: Vec<&str> = [o.text.as_deref(), raw.objective_text.as_deref()].into_iter().flatten().filter(|s| !s.is_empty()).collect();
						re.defend.is_match(&parts.join(" "))
					}
				}));
		let no_event = escort && !objs.iter().flatten().any(|o| o.kind == "event");
		let mut arrivals: Vec<i64> = Vec::new();
		let mut events: Vec<&crate::data::Objective> = Vec::new();
		let mut event_ois: Vec<i64> = Vec::new();
		let mq = d.mechanics.as_ref().and_then(|m| m.quests.get(&id));
		let mut summoned: Vec<(u32, u32)> = Vec::new();
		let mut made_at: Vec<(u32, u32)> = Vec::new();
		for p in mq.map(|m| m.params.as_slice()).unwrap_or(&[]) {
			if !truthy(p.get("drives")) {
				continue;
			}
			let place = |b: &mut Builder| -> Option<u32> {
				let positions = p.get("place").and_then(|pl| pl.get("positions")).and_then(Value::as_array)?;
				let pos = positions.iter().find(|x| finite(x.get("map")).is_some_and(|m| b.allowed_map(m as u32)))?;
				let map = num(pos.get("map")) as u32;
				let (c, wx, wy) = b.to_world(map, num(pos.get("x")), num(pos.get("y")), true);
				Some(b.add_point(c, wx, wy, map, None, None))
			};
			let kind = p.get("kind").and_then(Value::as_str);
			if kind == Some("summon-by-item") && present(p.get("npc")) {
				if let Some(pt) = place(&mut b) {
					let npc = num(p.get("npc")) as u32;
					match summoned.iter_mut().find(|e| e.0 == npc) {
						Some(e) => e.1 = pt,
						None => summoned.push((npc, pt)),
					}
				}
			} else if kind == Some("use-item-at-place") && present(p.get("produces")) {
				if let Some(pt) = place(&mut b) {
					let prod = p.get("produces").unwrap();
					let list: Vec<&Value> = match prod {
						Value::Array(a) => a.iter().collect(),
						x => vec![x],
					};
					for it in list {
						let it = num(Some(it)) as u32;
						match made_at.iter_mut().find(|e| e.0 == it) {
							Some(e) => e.1 = pt,
							None => made_at.push((it, pt)),
						}
					}
				}
			}
		}
		let summon_work = |located: &mut Vec<Located>, elite: &mut bool, oi: i64, npc_id: u32, count: f64| {
			let n = d.npcs.get(&npc_id);
			let el = n.is_some_and(|n| elite_rank(n.rank));
			if el {
				*elite = true;
			}
			let pt = summoned.iter().find(|e| e.0 == npc_id).map(|e| e.1).expect("summoned");
			located.push(Located { pt, work: Work::Use(1.0), ois: vec![oi] });
			let lvl = n.and_then(|n| npc_level(n, Some(level))).unwrap_or(level);
			located.push(Located { pt, work: Work::Kill { level: lvl, count, elite: el, spacing: 0.0, npc: npc_id }, ois: vec![oi] });
		};
		let own = |list: &[i64], nid: f64| list.iter().any(|&x| x as f64 == nid);
		let obj_text = raw.objective_text.clone().unwrap_or_default();
		for (oi, o) in objs.iter().enumerate() {
			let Some(o) = o else { continue };
			let oi = oi as i64;
			let count = o.count.filter(|c| *c > 0.0).unwrap_or(1.0);
			let oid = o.id;
			let oid_i = oid.filter(|x| x.fract() == 0.0).map(|x| x as i64).unwrap_or(-1);
			match o.kind.as_str() {
				"kill" => {
					if summoned.iter().any(|e| Some(e.0 as f64) == oid) {
						summon_work(&mut located, &mut elite, oi, oid_i as u32, count);
						add_obj(&mut obj_list, oi, "kill", oid, Some(count), None, false, Vec::new(), Vec::new());
						continue;
					}
					let Some(e) = b.sites(Kind::Npc, oid_i) else {
						missing = Some(format!("kill objective npc {} has no open-world spawns", oid.map_or("null".into(), js_to_string)));
						missing_code = "unplaceable";
						outside = true;
						break;
					};
					let s = b.best_site(&e, Some(giver));
					let nid = oid.unwrap_or(f64::NAN);
					let talk = re.talk.is_match(&obj_text);
					let fac_up = e.faction.as_deref().map_or("NULL".to_string(), str::to_uppercase);
					let own_faction = fac_up == faction.letter();
					let deed = own_faction && re.deed.is_match(&obj_text);
					if no_event && e.faction_truthy() && e.friendly {
						arrivals.push(oi);
						add_obj(&mut obj_list, oi, "event", Some(nid), Some(1.0), None, false, Vec::new(), Vec::new());
						continue;
					}
					if e.faction_truthy() && e.friendly && (own(&start.npc, nid) || own(&end.npc, nid) || talk || deed) {
						let n = if deed { count } else { 1.0 };
						located.push(Located { pt: s.pt, work: Work::Use(n), ois: vec![oi] });
						add_obj(&mut obj_list, oi, "talk", Some(nid), Some(n), None, false, Vec::new(), Vec::new());
						continue;
					}
					if e.faction_truthy() && !e.friendly && talk {
						continue;
					}
					let el = elite_rank(e.rank);
					if el {
						elite = true;
					}
					located.push(Located { pt: s.pt, work: Work::Kill { level: e.level(Some(level)).unwrap_or(level), count, elite: el, spacing: s.spacing, npc: e.id }, ois: vec![oi] });
					let src = [Src { kind: Kind::Npc, id: e.id, chance: Some(100.0) }];
					let kill_camps = if solid_source(d, faction, Kind::Npc, oid_i) || el { Some(camps_for(&mut b, &mut camp_cache, &src)) } else { None };
					if let Some(kc) = &kill_camps {
						obj_camps.push(ObjCamp { oi, camps: kc.clone(), chances: chances_of(&src) });
					}
					add_obj(&mut obj_list, oi, "kill", Some(e.id as f64), Some(count), None, false, kill_camps.unwrap_or_default(), chances_of(&src));
				}
				"object" => {
					let Some(e) = b.sites(Kind::Object, oid_i) else {
						missing = Some(format!("object objective {} has no open-world spawns", oid.map_or("null".into(), js_to_string)));
						missing_code = "unplaceable";
						outside = true;
						break;
					};
					located.push(Located { pt: b.best_site(&e, Some(giver)).pt, work: Work::Use(count), ois: vec![oi] });
					add_obj(&mut obj_list, oi, "object", oid, Some(count), None, false, Vec::new(), Vec::new());
				}
				"item" => {
					let item = u32::try_from(oid_i).ok().and_then(|i| d.items.get(&i));
					let qi = item.is_some_and(|i| i.quest_item == Some(true));
					if let Some(hand) = handover_of(id, oi as usize) {
						let e = b.sites(Kind::Npc, hand.npc as i64).expect("handover npc has spawns");
						located.push(Located { pt: b.best_site(&e, Some(giver)).pt, work: Work::Use(1.0), ois: vec![oi] });
						add_obj(&mut obj_list, oi, "talk", Some(hand.npc), Some(1.0), oid, qi, Vec::new(), Vec::new());
						continue;
					}
					let summoner = summoned.iter().map(|e| e.0).find(|n| item.and_then(|i| i.drops.as_ref()).is_some_and(|dr| dr.npc.contains_key(n)));
					if let Some(sn) = summoner {
						let it = item.unwrap();
						let ch = it.drops.as_ref().unwrap().npc[&sn].unwrap_or(0.0);
						let n = if ch >= 50.0 { count } else { ((count * 100.0) / if ch > 0.0 { ch } else { unknown_drop(it) }).ceil() };
						summon_work(&mut located, &mut elite, oi, sn, n);
						add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, Vec::new(), Vec::new());
						continue;
					}
					if let Some(&(_, pt)) = made_at.iter().find(|e| Some(e.0 as f64) == oid) {
						located.push(Located { pt, work: Work::Use(count), ois: vec![oi] });
						add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, Vec::new(), Vec::new());
						continue;
					}
					let mut item_camps: Vec<u32> = Vec::new();
					let mut item_chances: Vec<(String, Option<f64>)> = Vec::new();
					struct Best {
						e: Rc<Ent>,
						kind: &'static str,
						chance: f64,
						s: Site,
						cost: f64,
					}
					let mut best: Option<Best> = None;
					let mut any_drop = false;
					let mut skipped_rare = false;
					let mut high_best: Option<Best> = None;
					let mut high_src: Vec<Src> = Vec::new();
					if let Some((it, drops)) = item.and_then(|i| i.drops.as_ref().map(|dr| (i, dr))) {
						let mut sources: Vec<Src> = Vec::new();
						for k in Kind::BOTH {
							for (&eid, &ch) in drops.of(k) {
								let mut chance = ch;
								if k == Kind::Npc && (!solid_source(d, faction, k, eid as i64) || chance.is_some_and(|c| !(c >= solo::MIN_DROP))) {
									continue;
								}
								if k == Kind::Object {
									chance = object_chance(d, eid, it, chance);
								}
								sources.push(Src { kind: k, id: eid, chance });
							}
						}
						if !sources.is_empty() {
							let ids = camps_for(&mut b, &mut camp_cache, &sources);
							if !ids.is_empty() {
								obj_camps.push(ObjCamp { oi, camps: ids.clone(), chances: chances_of(&sources) });
							}
							item_camps = ids;
							item_chances = chances_of(&sources);
						}
						let recorded = has_recorded_drop(it);
						let giver_region = b.points[giver as usize].region;
						let mut recorded_near: Option<bool> = None;
						for k in Kind::BOTH {
							for (&eid, &ch) in drops.of(k) {
								if ch.is_none() && recorded {
									if recorded_near.is_none() {
										let mut near = false;
										'nr: for k2 in Kind::BOTH {
											for (&eid2, &c2) in drops.of(k2) {
												if !c2.is_some_and(|c| c > 0.0) {
													continue;
												}
												let e2 = b.sites(k2, eid2 as i64);
												if e2.is_none_or(|e2| e2.sites.iter().any(|s| b.points[s.pt as usize].region == giver_region)) {
													near = true;
													break 'nr;
												}
											}
										}
										recorded_near = Some(near);
									}
									if recorded_near == Some(true) {
										continue;
									}
								}
								let chance = match ch {
									None => unknown_drop(it),
									Some(c) => (if c.is_nan() { 0.0 } else { c }).min(100.0),
								};
								if chance <= 0.0 {
									continue;
								}
								any_drop = true;
								let Some(e) = b.sites(k, eid as i64) else { continue };
								let friendly_npc = k == Kind::Npc && e.friendly && e.faction_truthy();
								let handed = friendly_npc && chance >= 50.0;
								if strict && ((friendly_npc && !handed) || (k == Kind::Npc && e.rank == Some(4.0)) || chance < solo::MIN_DROP) {
									skipped_rare = true;
									continue;
								}
								if !handed && k == Kind::Npc && !solo_dropper(&e) {
									high_src.push(Src { kind: Kind::Npc, id: eid, chance: ch });
									let s = b.best_site(&e, Some(giver));
									let dd = b.dist(s.pt, giver);
									let cost = 100.0 / chance + if dd.is_finite() { dd / 300.0 } else { 1e6 };
									if high_best.as_ref().is_none_or(|h| cost < h.cost) {
										high_best = Some(Best { e: e.clone(), kind: "npc", chance, s, cost });
									}
									continue;
								}
								let s = b.best_site(&e, Some(giver));
								let dd = b.dist(s.pt, giver);
								let cost =
									(if handed { 1.0 } else { 100.0 / chance }) + (if dd.is_finite() { dd / 300.0 } else { 1e6 }) + (if k == Kind::Npc && elite_rank(e.rank) { 4.0 } else { 0.0 });
								if best.as_ref().is_none_or(|h| cost < h.cost) {
									best = Some(Best { e: e.clone(), kind: if handed { "talk" } else { k.as_str() }, chance, s, cost });
								}
							}
						}
					}
					if let Some(bst) = best {
						let n = (count * 100.0) / bst.chance;
						match bst.kind {
							"talk" => located.push(Located { pt: bst.s.pt, work: Work::Use(1.0), ois: vec![oi] }),
							"npc" => {
								let el = elite_rank(bst.e.rank);
								if el {
									elite = true;
								}
								located.push(Located {
									pt: bst.s.pt,
									work: Work::Kill { level: bst.e.level(Some(level)).unwrap_or(level), count: n, elite: el, spacing: bst.s.spacing, npc: bst.e.id },
									ois: vec![oi],
								});
							}
							_ => located.push(Located { pt: bst.s.pt, work: Work::Use(n), ois: vec![oi] }),
						}
						add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, item_camps, item_chances);
					} else {
						let mut v: Option<Site> = None;
						let mut vd = f64::INFINITY;
						for &vid in item.and_then(|i| i.vendors.as_deref()).unwrap_or(&[]) {
							let Some(e) = b.sites(Kind::Npc, vid) else { continue };
							if !e.friendly {
								continue;
							}
							let s = b.best_site(&e, Some(giver));
							let dd = b.dist(s.pt, giver);
							let dd = if dd.is_finite() { dd } else { 1e9 };
							if v.is_none() || dd < vd {
								v = Some(s);
								vd = dd;
							}
						}
						if let Some(v) = v {
							located.push(Located { pt: v.pt, work: Work::Buy, ois: vec![oi] });
							add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, item_camps, item_chances);
						} else if let Some(hb) = high_best {
							let n = (count * 100.0) / hb.chance;
							let el = elite_rank(hb.e.rank);
							if el {
								elite = true;
							}
							located.push(Located {
								pt: hb.s.pt,
								work: Work::Kill { level: hb.e.level(Some(level)).unwrap_or(level), count: n, elite: el, spacing: hb.s.spacing, npc: hb.e.id },
								ois: vec![oi],
							});
							let ids = camps_for(&mut b, &mut camp_cache, &high_src);
							if !ids.is_empty() {
								obj_camps.push(ObjCamp { oi, camps: ids.clone(), chances: chances_of(&high_src) });
							}
							add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, ids, chances_of(&high_src));
						} else if skipped_rare {
							missing = Some(format!("item objective {} drops below 1%", oid.map_or("null".into(), js_to_string)));
							missing_cat = Some("rareDrop");
							missing_code = "rare-drop";
							break;
						} else if !any_drop {
							let handout = raw.source_item.is_some_and(|s| s > 0.0)
								|| !raw.required_items.is_empty()
								|| start.item.iter().any(|&x| Some(x as f64) == oid)
								|| solo.turnin_after.contains_key(&id)
								|| reward_items.contains(&oid_i)
								|| item.and_then(|i| i.containers.as_ref()).is_some_and(|c| !c.is_empty());
							if !handout {
								missing = Some(format!("item objective {} has no source", oid.map_or("null".into(), js_to_string)));
								missing_code = "unsourced-item";
								outside = true;
								break;
							}
							located.push(Located { pt: giver, work: Work::Use(1.0), ois: vec![oi] });
							add_obj(&mut obj_list, oi, "item", oid, Some(count), oid, qi, item_camps, item_chances);
							outside = true;
						} else {
							missing = Some(format!("item objective {} drops only outside the open world", oid.map_or("null".into(), js_to_string)));
							missing_code = "outside";
							outside = true;
							break;
						}
					}
				}
				"event" => {
					events.push(o);
					event_ois.push(oi);
				}
				_ => {}
			}
		}
		if missing.is_none() && no_event {
			if objs.is_empty() {
				arrivals.push(-1);
				add_obj(&mut obj_list, -1, "event", None, Some(1.0), None, false, Vec::new(), Vec::new());
			}
			if !arrivals.is_empty() {
				located.push(Located { pt: giver, work: Work::Escort, ois: arrivals.clone() });
			}
		}
		if missing.is_none() && !events.is_empty() {
			let placed: Vec<&&crate::data::Objective> =
				events.iter().filter(|o| o.map.is_some() && o.x.is_some_and(f64::is_finite) && o.y.is_some_and(f64::is_finite) && b.allowed_map(o.map.unwrap() as u32)).collect();
			if !placed.is_empty() {
				let mut best: Option<(u32, f64, &crate::data::Objective)> = None;
				for o in placed {
					let map = o.map.unwrap() as u32;
					let (c, wx, wy) = b.to_world(map, o.x.unwrap(), o.y.unwrap(), o.f.as_deref() == Some("l"));
					let pt = b.add_point(c, wx, wy, map, None, None);
					let dd = b.dist(pt, giver);
					if best.as_ref().is_none_or(|x| dd < x.1) {
						best = Some((pt, dd, o));
					}
				}
				let (pt, _, bo) = best.unwrap();
				let n = re.count.captures(bo.text.as_deref().unwrap_or("")).and_then(|c| c.get(1)).map_or(f64::NAN, |m| m.as_str().parse::<f64>().unwrap_or(f64::NAN));
				let work = if timed_event {
					Work::Escort
				} else if n > 1.0 {
					Work::Use(n)
				} else {
					Work::Visit
				};
				located.push(Located { pt, work, ois: event_ois.clone() });
			} else if timed_event || events.iter().all(|o| o.map.is_none()) {
				located.push(Located { pt: giver, work: Work::Escort, ois: event_ois.clone() });
				outside = true;
			} else {
				missing = Some("event objective outside the open world".into());
				missing_code = "outside";
				outside = true;
			}
		}
		if missing.is_none() {
			for (k, o) in events.iter().enumerate() {
				add_obj(&mut obj_list, event_ois[k], "event", o.id, o.count, None, false, Vec::new(), Vec::new());
			}
		}
		if let (Some(i), true) = (inst, outside) {
			ex_inst(&mut ex, &mut excluded, i);
			continue;
		}
		if let Some(m) = missing {
			ex(&mut excluded, m, missing_cat, missing_code);
			continue;
		}
		// Tasks.
		let mut tasks: Vec<Task> = Vec::new();
		let mut task_of_oi: Vec<(i64, u32)> = Vec::new();
		for l in located {
			let ti = match tasks.iter().position(|x| b.dist(x.pt, l.pt) <= SITE_R) {
				Some(t) => t,
				None => {
					tasks.push(Task { pt: l.pt, work: Vec::new() });
					tasks.len() - 1
				}
			};
			tasks[ti].work.push(l.work);
			for oi in l.ois {
				match task_of_oi.iter_mut().find(|e| e.0 == oi) {
					Some(e) => e.1 = ti as u32,
					None => task_of_oi.push((oi, ti as u32)),
				}
			}
		}
		obj_list.sort_by_key(|o| o.oi);
		for ob in &mut obj_list {
			if let Some(e) = task_of_oi.iter().find(|e| e.0 == ob.oi) {
				ob.task = Some(e.1);
			}
		}
		let kind = if accept.is_some() || start_from.is_some() {
			"startItem"
		} else if !obj_list.is_empty() {
			"work"
		} else if ender != giver {
			"delivery"
		} else {
			"talk"
		};
		let xp = raw.xp.filter(|x| *x > 0.0);
		let mech = mq.and_then(|m| {
			let kinds: Vec<String> = m.kinds.iter().filter(|k| k.drives).map(|k| k.kind.clone()).collect();
			let params: Vec<Value> = m
				.params
				.iter()
				.filter(|p| truthy(p.get("drives")))
				.map(|p| {
					let mut p = p.clone();
					if let Some(o) = p.as_object_mut() {
						o.shift_remove("drives");
					}
					p
				})
				.collect();
			(!kinds.is_empty()).then_some(Mech { kinds, params })
		});
		let sd = dur_of(raw.source_item);
		let q = WQuest {
			id,
			title,
			level,
			min_level,
			races: (races != 0.0).then_some(races),
			classes: raw.classes.filter(|c| *c != 0.0 && !c.is_nan()),
			pre: raw.pre.clone(),
			excl: raw.excl.clone(),
			next: raw.next.filter(|n| *n != 0.0 && !n.is_nan()),
			xp,
			no_xp: Some(raw.repeatable == Some(true) && xp.is_none()),
			giver,
			ender,
			accept,
			tasks,
			zone: b.points[giver as usize].map,
			breadcrumb: objs.is_empty() && !escort,
			kind,
			objs: obj_list,
			escort,
			elite,
			g_name,
			e_name,
			g_pos,
			e_pos,
			g_alt,
			limit: raw.limit.filter(|l| *l > 0.0),
			mech,
			e_alt,
			start_from,
			source_dur: (sd != 0.0).then_some(sd),
			obj_camps: (!obj_camps.is_empty()).then_some(obj_camps),
			in_log: raw.parent.map(|p| p as i64),
			pre_all: Vec::new(),
			pre_rule: None,
			after: None,
			tier: 0,
			hub_giver: -1,
			hub_ender: -1,
			dungeon: None,
			from_journal: false,
		};
		if timed_event {
			timed_ids.insert(id);
		}
		quests.push(q);
	}
	// Repeatables without a recorded reward.
	let mut needed: FxHashSet<i64> = FxHashSet::default();
	for r in d.quests.values() {
		needed.extend(r.pre.iter().copied());
		needed.extend(r.pre_any.iter().flatten().copied());
		needed.extend(r.pre_all.iter().flatten().copied());
	}
	for kids in solo.turnin_after.values() {
		needed.extend(kids.iter().map(|&k| k as i64));
	}
	for &src in solo.start_item_from.values() {
		needed.insert(src as i64);
	}
	let mut i = quests.len();
	while i > 0 {
		i -= 1;
		if quests[i].no_xp != Some(true) {
			continue;
		}
		let qid = quests[i].id;
		if needed.contains(&(qid as i64)) || solo.allow.contains_key(&qid) {
			repeat_no_xp += 1;
			continue;
		}
		let q = quests.remove(i);
		excluded.push(Excluded { id: q.id, title: Some(q.title), reason: "repeatable without a recorded reward (no XP)".into(), category: Some("repeatable".into()), code: "repeatable" });
		solo_out.insert(q.id, "repeatable");
		if let Some(e) = solo_counts.iter_mut().find(|e| e.0 == "repeatable") {
			e.1 += 1;
		}
	}
	let mut by_id: FxHashMap<u32, usize> = quests.iter().enumerate().map(|(i, q)| (q.id, i)).collect();

	// ---- dungeons ----
	let mut dungeons: Vec<Dungeon> = Vec::new();
	for dgv in arr(d.dungeons.as_ref().and_then(|x| x.get("dungeons"))) {
		let ent = dgv.get("entrance").filter(|e| truthy(Some(e)));
		let ent_map = ent.and_then(|e| finite(e.get("map"))).map(|m| m as u32);
		let ent_live = ent.is_some_and(|e| e.get("f").and_then(Value::as_str) == Some("l"));
		let Some(ent_map) = ent_map.filter(|m| b.frame_of(*m, ent_live).is_some()) else {
			warnings.push(format!("dungeon {}: entrance has no Era map frame", js_str(dgv.get("name"))));
			continue;
		};
		let ent = ent.unwrap();
		let (c, wx, wy) = b.to_world(ent_map, num(ent.get("x")), num(ent.get("y")), ent_live);
		let di = dungeons.len() as u32;
		let bosses: Vec<f64> = arr(dgv.get("bosses"))
			.iter()
			.filter_map(|bo| {
				let l = bo.get("level");
				match l {
					Some(Value::Number(n)) => n.as_f64(),
					Some(x) if truthy(Some(x)) && finite(x.get("max")).is_some() => Some(js_round((num(x.get("min")) + num(x.get("max"))) / 2.0)),
					_ => None,
				}
			})
			.collect();
		let levels = dgv.get("levels");
		let dmin = levels.and_then(|l| l.get("min")).cloned().unwrap_or(Value::Null);
		let dpt = b.add_point(c, wx, wy, ent_map, None, None);
		let mut dg = Dungeon {
			key: dgv.get("key").cloned().unwrap_or(Value::Null),
			name: dgv.get("name").cloned().unwrap_or(Value::Null),
			min: dmin.clone(),
			max: levels.and_then(|l| l.get("max")).cloned().unwrap_or(Value::Null),
			pt: dpt,
			zone: ent_map,
			bosses,
			boss_count: arr(dgv.get("bosses")).len() as u32,
			quests: Vec::new(),
		};
		let dname = js_str(dgv.get("name"));
		let ent_f = ent.get("f").and_then(Value::as_str).map(String::from);
		let add_quest = |b: &mut Builder, quests: &mut Vec<WQuest>, by_id: &mut FxHashMap<u32, usize>, dq: &Value, inside: bool| -> Option<u32> {
			let qid = num(dq.get("id"));
			let qid_u = qid as u32;
			let fac_ok = match dq.get("faction") {
				None | Some(Value::Null) => true,
				Some(f) => f.as_str() == Some(faction.name()),
			};
			if by_id.contains_key(&qid_u) || !fac_ok {
				return None;
			}
			let raw = d.quests.get(&qid_u);
			let or = |v: f64| if v != 0.0 && !v.is_nan() { Some(v) } else { None };
			let level = or(num(dq.get("level"))).or_else(|| raw.and_then(|r| r.level).and_then(or)).unwrap_or_else(|| num(Some(&dmin)));
			let dj_point = |b: &mut Builder, pos: Option<&Value>| -> u32 {
				let ok = pos.filter(|p| truthy(Some(p))).filter(|p| {
					!truthy(p.get("inDungeon"))
						&& present(p.get("map"))
						&& finite(p.get("x")).is_some()
						&& finite(p.get("y")).is_some()
						&& b.frame_of(num(p.get("map")) as u32, p.get("f").and_then(Value::as_str) == Some("l")).is_some()
				});
				match ok {
					None => dpt,
					Some(p) => {
						let map = num(p.get("map")) as u32;
						let (c, wx, wy) = b.to_world(map, num(p.get("x")), num(p.get("y")), p.get("f").and_then(Value::as_str) == Some("l"));
						b.add_point(c, wx, wy, map, None, None)
					}
				}
			};
			let giver = dj_point(b, dq.get("start"));
			let ender = dj_point(b, dq.get("end"));
			let dj_pos = |b: &Builder, pos: Option<&Value>| -> Pos {
				match pos.filter(|p| truthy(Some(p)) && !truthy(p.get("inDungeon")) && present(p.get("map")) && finite(p.get("x")).is_some()) {
					Some(p) => Pos { map: num(p.get("map")) as u32, x: num(p.get("x")), y: num(p.get("y")), in_dungeon: false },
					None => {
						let mut p = b.pos_of(dpt, ent_f.as_deref());
						p.in_dungeon = true;
						p
					}
				}
			};
			let dj_name = |pos: Option<&Value>| -> Option<String> {
				let p = pos.filter(|p| truthy(Some(p)));
				match p {
					Some(p) if present(p.get("id")) => {
						let id = num(p.get("id")) as u32;
						let e = if p.get("kind").and_then(Value::as_str) == Some("object") { d.objects.get(&id) } else { d.npcs.get(&id) };
						e.and_then(|e| e.name.clone())
					}
					_ => p.filter(|p| truthy(p.get("inDungeon"))).map(|_| format!("inside {dname}")),
				}
			};
			let chain = arr(dq.get("chain"));
			let pre: Vec<i64> = if !chain.is_empty() { vec![num(chain.last()) as i64] } else { raw.map(|r| r.pre.clone()).unwrap_or_default() };
			let classes = {
				let list = arr(dq.get("classes"));
				let m = if list.is_empty() { 0 } else { list.iter().fold(0u32, |m, c| m | forge_core::class_by_file(&js_str(Some(c)).to_uppercase()).map_or(0, |c| c.bit)) };
				if m != 0 {
					Some(m as f64)
				} else {
					raw.and_then(|r| r.classes).filter(|c| *c != 0.0)
				}
			};
			let title = dq
				.get("title")
				.filter(|t| truthy(Some(t)))
				.map(|t| js_str(Some(t)))
				.or_else(|| raw.and_then(|r| r.title.clone()).filter(|t| !t.is_empty()))
				.unwrap_or_else(|| format!("Quest {}", js_str(dq.get("id"))));
			let dxp = num(dq.get("xp"));
			let q = WQuest {
				id: qid_u,
				title,
				level,
				min_level: or(num(dq.get("minLevel"))).or_else(|| raw.and_then(|r| r.min_level).and_then(or)).unwrap_or((level - 5.0).max(1.0)),
				races: raw.and_then(|r| r.races).filter(|r| *r != 0.0),
				classes,
				pre,
				excl: raw.map(|r| r.excl.clone()).unwrap_or_default(),
				next: raw.and_then(|r| r.next).filter(|n| *n != 0.0),
				xp: if dxp > 0.0 { Some(dxp) } else { raw.and_then(|r| r.xp).filter(|x| *x > 0.0) },
				no_xp: None,
				giver,
				ender,
				accept: None,
				tasks: if inside { vec![Task { pt: dpt, work: vec![Work::Dungeon(di)] }] } else { Vec::new() },
				zone: b.points[giver as usize].map,
				breadcrumb: !inside,
				kind: if inside {
					"work"
				} else if ender != giver {
					"delivery"
				} else {
					"talk"
				},
				objs: Vec::new(),
				escort: false,
				elite: inside,
				g_name: dj_name(dq.get("start")),
				e_name: dj_name(dq.get("end")),
				g_pos: Some(dj_pos(b, dq.get("start"))),
				e_pos: Some(dj_pos(b, dq.get("end"))),
				g_alt: None,
				limit: None,
				mech: None,
				e_alt: None,
				start_from: None,
				source_dur: None,
				obj_camps: None,
				in_log: None,
				pre_all: Vec::new(),
				pre_rule: None,
				after: None,
				tier: 0,
				hub_giver: -1,
				hub_ender: -1,
				dungeon: inside.then_some(di),
				from_journal: true,
			};
			by_id.insert(qid_u, quests.len());
			quests.push(q);
			Some(qid_u)
		};
		for dq in arr(dgv.get("quests")) {
			if truthy(dq.get("hidden")) {
				continue;
			}
			if let Some(q) = add_quest(&mut b, &mut quests, &mut by_id, &dq, true) {
				dg.quests.push(q);
			}
		}
		for (_, cq) in entries(dgv.get("chainQuests")) {
			let inside = truthy(cq.get("dungeon")) && cq.get("dungeon") == dgv.get("key");
			if !inside && solo_out.contains_key(&(num(cq.get("id")) as u32)) {
				continue;
			}
			add_quest(&mut b, &mut quests, &mut by_id, cq, inside);
		}
		dungeons.push(dg);
	}
	for (di, dg) in dungeons.iter_mut().enumerate() {
		let extra: Vec<u32> = quests.iter().filter(|q| q.dungeon == Some(di as u32) && !dg.quests.contains(&q.id)).map(|q| q.id).collect();
		dg.quests.extend(extra);
	}

	// ---- prerequisites ----
	let quest_of = |id: i64| u32::try_from(id).ok().and_then(|i| d.quests.get(&i));
	let has_pre_data = |raw: Option<&Quest>| {
		raw.is_some_and(|r| {
			!r.pre.is_empty()
				|| r.pre_any.as_ref().is_some_and(|v| !v.is_empty())
				|| r.pre_all.as_ref().is_some_and(|v| !v.is_empty())
				|| !r.breadcrumbs.is_empty()
				|| r.breadcrumb_for.is_some_and(|b| b > 0.0)
		})
	};
	let mut pre_rules = PreRules::default();
	for q in &mut quests {
		let Some(raw) = d.quests.get(&q.id) else {
			q.pre_all = Vec::new();
			if !q.pre.is_empty() {
				q.pre_rule = Some("journal");
				pre_rules.journal += 1;
			}
			continue;
		};
		let bl = blocking_prereqs(raw, &quest_of);
		q.pre = bl.any;
		q.pre_all = match q.start_from {
			Some(sf) => {
				let mut v = bl.all;
				if !v.contains(&(sf as i64)) {
					v.push(sf as i64);
				}
				let mut seen = Vec::new();
				v.retain(|x| {
					let new = !seen.contains(x);
					seen.push(*x);
					new
				});
				v
			}
			None => bl.all,
		};
		if has_pre_data(Some(raw)) {
			q.pre_rule = Some("canonical");
			pre_rules.canonical += 1;
		}
	}
	let mut next_of: BTreeMap<u32, Vec<i64>> = BTreeMap::new();
	for q in &quests {
		let Some(n) = q.next else { continue };
		if n.fract() != 0.0 || n < 0.0 || !by_id.contains_key(&(n as u32)) {
			continue;
		}
		next_of.entry(n as u32).or_default().push(q.id as i64);
	}
	for (t, src) in next_of {
		let f = &mut quests[by_id[&t]];
		if !f.pre.is_empty() || !f.pre_all.is_empty() || has_pre_data(d.quests.get(&t)) {
			continue;
		}
		f.pre = sorted_unique(src);
		f.pre_rule = Some("next");
		pre_rules.next += 1;
	}
	let mut children = 0;
	let excluded_nonfaction: FxHashSet<u32> = excluded.iter().filter(|e| e.code != "faction").map(|e| e.id).collect();
	for q in &mut quests {
		let Some(l) = q.in_log else { continue };
		let lu = u32::try_from(l).ok();
		if !lu.is_some_and(|l| by_id.contains_key(&l)) && !lu.is_some_and(|l| excluded_nonfaction.contains(&l)) {
			q.in_log = None;
			continue;
		}
		q.pre.retain(|&p| p != l);
		q.pre_all.retain(|&p| p != l);
		children += 1;
	}
	for (parent, kids) in &solo.turnin_after {
		if let Some(&i) = by_id.get(parent) {
			quests[i].after = Some(kids.clone());
		}
	}
	pre_rules.children = children;
	let mut followers: FxHashSet<i64> = FxHashSet::default();
	for q in &quests {
		followers.extend(q.pre.iter().copied());
	}
	for q in &mut quests {
		let mut ex: Vec<i64> = q.excl.iter().copied().filter(|&e| e != q.id as i64 && u32::try_from(e).is_ok_and(|e| by_id.contains_key(&e))).collect();
		ex = sorted_unique(ex);
		q.excl = ex;
		let chain_end = !q.pre.is_empty() && !followers.contains(&(q.id as i64));
		q.tier = if q.breadcrumb {
			3
		} else if timed_ids.contains(&q.id) || q.elite {
			7
		} else if chain_end {
			6
		} else {
			5
		};
	}

	// ---- services ----
	let mut services = Services::default();
	{
		let add = |b: &mut Builder, list: &mut Vec<SvcPt>, id: u32| {
			if let Some(s) = b.sites(Kind::Npc, id as i64) {
				for site in &s.sites {
					if !list.iter().any(|x| x.pt == site.pt) {
						list.push(SvcPt { pt: site.pt, npc: Some(id) });
					}
				}
			}
		};
		for n in d.npcs.values() {
			if !friendly(n.faction.as_deref(), faction) {
				continue;
			}
			let roles = n.roles.as_deref().unwrap_or(&[]);
			let sub = n.sub_name.as_deref().unwrap_or("");
			let has = |r: &str| roles.iter().any(|x| x == r);
			if has("repair") {
				add(&mut b, &mut services.repair, n.id);
			}
			if has("vendor") && re.food.is_match(sub) {
				add(&mut b, &mut services.food, n.id);
			}
			if has("vendor") && re.ammo.is_match(sub) {
				add(&mut b, &mut services.ammo, n.id);
			}
			if has("innkeeper") {
				add(&mut b, &mut services.inn, n.id);
			}
		}
		for (_, t) in entries(d.trainers.as_ref()) {
			let tid = num(t.get("id"));
			let Some(n) = d.npcs.get(&(tid as u32)).filter(|_| tid.fract() == 0.0 && tid >= 0.0) else { continue };
			if !friendly(n.faction.as_deref(), faction) {
				continue;
			}
			for cls in arr(t.get("classes")) {
				let cls = js_str(Some(&cls));
				let idx = match services.trainer.iter().position(|e| e.0 == cls) {
					Some(i) => i,
					None => {
						services.trainer.push((cls, Vec::new()));
						services.trainer.len() - 1
					}
				};
				let mut list = std::mem::take(&mut services.trainer[idx].1);
				add(&mut b, &mut list, tid as u32);
				services.trainer[idx].1 = list;
			}
		}
		for l in [&mut services.repair, &mut services.food, &mut services.ammo, &mut services.inn] {
			l.sort_by_key(|x| x.pt);
		}
		for (_, l) in &mut services.trainer {
			l.sort_by_key(|x| x.pt);
		}
	}
	services.flight =
		nodes.iter().filter(|n| n.kind == "fp").map(|n| SvcPt { pt: n.pt, npc: fp_npc.iter().find(|e| Some(e.0.as_str()) == n.taxi.map(js_to_string).as_deref()).and_then(|e| e.1) }).collect();
	services.flight.sort_by_key(|x| x.pt);
	let ride_doc = d.training.as_ref().and_then(|t| t.get("riding")).filter(|r| truthy(Some(r)));
	let mut riding = Value::Null;
	if let Some(rd) = ride_doc.filter(|rd| !arr(rd.get("trainers")).is_empty()) {
		let mut vendor_sites: Vec<(u32, u32, Value, Value)> = Vec::new();
		for (vid, v) in entries(rd.get("vendors")) {
			let vid_n: u32 = vid.parse().unwrap_or(0);
			let e = d.npcs.get(&vid_n).filter(|n| friendly(n.faction.as_deref(), faction)).and_then(|_| b.sites(Kind::Npc, vid_n as i64));
			if let Some(e) = e {
				for s in &e.sites {
					vendor_sites.push((s.pt, vid_n, v.get(0).cloned().unwrap_or(Value::Null), v.get(1).cloned().unwrap_or(Value::Null)));
				}
			}
		}
		for t in arr(rd.get("trainers")) {
			let tid = num(t.get("id")) as u32;
			let e = d.npcs.get(&tid).filter(|n| friendly(n.faction.as_deref(), faction)).and_then(|_| b.sites(Kind::Npc, tid as i64));
			let Some(e) = e else { continue };
			for s in &e.sites {
				let a = b.points[s.pt as usize];
				let mut best = None;
				let mut bd = RIDE_PAIR_YD;
				for v in &vendor_sites {
					let bp = b.points[v.0 as usize];
					if bp.c != a.c {
						continue;
					}
					let dd = js_hypot(bp.wx - a.wx, bp.wy - a.wy);
					if dd <= bd {
						bd = dd;
						best = Some(v);
					}
				}
				let races = if truthy(t.get("races")) { num(t.get("races")) } else { 0.0 };
				services.riding.push(RidingStop { pt: s.pt, npc: tid, races, vendor: best.map(|v| (v.1, v.0, v.3.clone(), v.2.clone())) });
			}
		}
		services.riding.sort_by_key(|r| r.pt);
		if !services.riding.is_empty() {
			riding = json!({ "level": rd.get("level").cloned().unwrap_or(Value::Null), "cost": rd.get("cost").cloned().unwrap_or(Value::Null) });
		}
	}
	let mut service_set: BTreeMap<u32, Vec<String>> = BTreeMap::new();
	{
		let mut mark = |kind: &str, pts: Vec<u32>| {
			for pt in pts {
				let k = service_set.entry(pt).or_default();
				if !k.iter().any(|x| x == kind) {
					k.push(kind.to_string());
				}
			}
		};
		for (cls, list) in &services.trainer {
			mark(&format!("trainer:{cls}"), list.iter().map(|s| s.pt).collect());
		}
		mark("repair", services.repair.iter().map(|s| s.pt).collect());
		mark("food", services.food.iter().map(|s| s.pt).collect());
		mark("ammo", services.ammo.iter().map(|s| s.pt).collect());
		mark("inn", services.inn.iter().map(|s| s.pt).collect());
		mark("flight", services.flight.iter().map(|s| s.pt).collect());
		mark("riding", services.riding.iter().map(|s| s.pt).collect());
	}
	let training = d.training.as_ref().and_then(|t| t.get("classes")).filter(|c| truthy(Some(c))).cloned().unwrap_or_else(|| json!({}));
	let training_spells = d.training.as_ref().and_then(|t| t.get("spells")).filter(|c| truthy(Some(c))).cloned().unwrap_or(Value::Null);
	let mut classes: Vec<(String, Value)> = Vec::new();
	for (race, sides) in entries(d.races.as_ref()) {
		if let Some(side) = sides.get(faction.name()).filter(|s| truthy(Some(s))) {
			let label = if forge_core::race_by_file(race).is_some() { forge_core::race_label(race).to_string() } else { race.clone() };
			let v = side.get("classes").cloned().unwrap_or(Value::Null);
			match classes.iter_mut().find(|e| e.0 == label) {
				Some(e) => e.1 = v,
				None => classes.push((label, v)),
			}
		}
	}
	let mut excluded_ids: Vec<u32> = excluded.iter().filter(|e| e.code != "faction").map(|e| e.id).collect();
	excluded_ids.sort_unstable();
	excluded_ids.dedup();

	// ---- hubs ----
	let mut uniq_hub: Vec<u32> = quests.iter().flat_map(|q| [q.giver, q.ender]).collect();
	uniq_hub.sort_unstable();
	uniq_hub.dedup();
	let hub_pts: Vec<(i64, f64, f64)> = uniq_hub.iter().map(|&i| (b.points[i as usize].region, b.points[i as usize].wx, b.points[i as usize].wy)).collect();
	let hub_cl = cluster(&hub_pts, HUB_R);
	let mut hubs: Vec<Hub> = Vec::new();
	let mut hub_of_point: FxHashMap<u32, i64> = FxHashMap::default();
	let mut trainer_pts: Vec<(u32, Vec<String>)> = Vec::new();
	for (tid, t) in entries(d.trainers.as_ref()) {
		let Ok(tid) = tid.parse::<i64>() else { continue };
		let Some(e) = b.sites(Kind::Npc, tid) else { continue };
		if !e.friendly {
			continue;
		}
		let cls: Vec<String> = arr(t.get("classes")).iter().map(|c| js_str(Some(c))).collect();
		for s in &e.sites {
			trainer_pts.push((s.pt, cls.clone()));
		}
	}
	for c in hub_cl {
		let seed_pt = b.points[uniq_hub[c.seed] as usize];
		let center = b.add_point(seed_pt.c, c.cx, c.cy, seed_pt.map, None, None);
		let mut fp = -1i64;
		let mut fpd = NEAR_HUB;
		for (i, n) in nodes.iter().enumerate() {
			if n.kind != "fp" {
				continue;
			}
			let dd = b.dist(n.pt, center);
			if dd <= fpd {
				fpd = dd;
				fp = i as i64;
			}
		}
		let mut inn = -1i64;
		let mut innd = NEAR_HUB;
		for (i, n) in inns.iter().enumerate() {
			let dd = b.dist(n.pt, center);
			if dd <= innd {
				innd = dd;
				inn = i as i64;
			}
		}
		let mut trainers: Vec<String> = Vec::new();
		for t in &trainer_pts {
			if b.dist(t.0, center) <= NEAR_HUB {
				for cl in &t.1 {
					if !trainers.contains(cl) {
						trainers.push(cl.clone());
					}
				}
			}
		}
		trainers.sort_by(|a, b| js_str_cmp(a, b));
		let h = hubs.len() as i64;
		hubs.push(Hub { pt: center, zone: b.points[center as usize].map, size: c.size, fp, inn, trainers });
		for &m in &c.members {
			hub_of_point.insert(uniq_hub[m], h);
		}
	}

	// ---- packages ----
	let mut band_of: FxHashMap<u32, f64> = FxHashMap::default();
	let mut sorted: Vec<usize> = (0..quests.len()).collect();
	sorted.sort_by(|&a, &bb| quests[a].level.partial_cmp(&quests[bb].level).unwrap().then(quests[a].id.cmp(&quests[bb].id)));
	let band_idx = |lvl: f64| ((lvl.max(1.0) - 1.0) / band_width).floor();
	for _ in 0..3 {
		for &qi in &sorted {
			let q = &quests[qi];
			let mut bd = band_idx(q.level);
			let pres: Vec<i64> = q.pre.iter().copied().chain(q.in_log).collect();
			for p in pres {
				let Some(&pi) = u32::try_from(p).ok().and_then(|p| by_id.get(&p)) else { continue };
				let pq = &quests[pi];
				let Some(&pb) = band_of.get(&(p as u32)) else { continue };
				if pq.zone != q.zone {
					continue;
				}
				if q.level <= (pb + 1.0) * band_width + 2.0 && pb < bd {
					bd = pb;
				}
			}
			band_of.insert(q.id, bd);
		}
	}
	struct G {
		zone: u32,
		band: f64,
		steps: Vec<(StepKind, usize, i64, u32)>,
	}
	let mut groups: Vec<G> = Vec::new();
	let mut gidx: FxHashMap<(u32, u64), usize> = FxHashMap::default();
	for (qi, q) in quests.iter().enumerate() {
		if q.dungeon.is_some() {
			continue;
		}
		let band = band_of[&q.id];
		let mut add_step = |kind: StepKind, task: i64, pt: u32| {
			let zone = b.points[pt as usize].map;
			let k = (zone, bits(band));
			let g = *gidx.entry(k).or_insert_with(|| {
				groups.push(G { zone, band, steps: Vec::new() });
				groups.len() - 1
			});
			groups[g].steps.push((kind, qi, task, pt));
		};
		add_step(StepKind::Accept, -1, q.accept.as_ref().map_or(q.giver, |a| a.pt));
		for (i, t) in q.tasks.iter().enumerate() {
			add_step(StepKind::Task, i as i64, t.pt);
		}
		add_step(StepKind::Turnin, -1, q.ender);
	}
	let mut gorder: Vec<usize> = (0..groups.len()).collect();
	gorder.sort_by(|&a, &bb| groups[a].band.partial_cmp(&groups[bb].band).unwrap().then(groups[a].zone.cmp(&groups[bb].zone)));
	let mut packages: Vec<Package> = Vec::new();
	let fmt = js_to_string;
	for gi in gorder {
		let g = &groups[gi];
		let steps: Vec<Step> =
			g.steps.iter().map(|s| Step { kind: s.0, q: quests[s.1].id, task: s.2, pt: s.3, pre: &quests[s.1].pre, in_log: quests[s.1].in_log, after: quests[s.1].after.as_deref() }).collect();
		let order = plan_order(&steps, &|a, bb| b.dist(a, bb));
		let mut chunks: Vec<Vec<usize>> = Vec::new();
		let mut cur: Vec<usize> = Vec::new();
		let mut open = 0u32;
		for s in order {
			if steps[s].kind == StepKind::Accept && open >= max_open {
				chunks.push(std::mem::take(&mut cur));
				open = 0;
			}
			match steps[s].kind {
				StepKind::Accept => open += 1,
				StepKind::Turnin if open > 0 => open -= 1,
				_ => {}
			}
			cur.push(s);
		}
		if !cur.is_empty() {
			chunks.push(cur);
		}
		let nchunks = chunks.len();
		for (ci, ch) in chunks.into_iter().enumerate() {
			let mut qs: Vec<u32> = Vec::new();
			for &s in &ch {
				if !qs.contains(&steps[s].q) {
					qs.push(steps[s].q);
				}
			}
			let lv: Vec<f64> = qs.iter().map(|id| quests[by_id[id]].level).collect();
			let lo = lv.iter().copied().fold(f64::INFINITY, f64::min);
			let hi = lv.iter().copied().fold(f64::NEG_INFINITY, f64::max);
			let suffix = if nchunks > 1 { ((b'a' + ci as u8) as char).to_string() } else { String::new() };
			packages.push(Package {
				key: format!("{} {}-{}{suffix}", zone_name(g.zone), fmt(g.band * band_width + 1.0), fmt((g.band + 1.0) * band_width)),
				zone: g.zone,
				zone_name: zone_name(g.zone),
				band: g.band,
				levels: (lo, hi),
				dungeon: None,
				quests: qs,
				steps: ch
					.iter()
					.map(|&s| {
						let st = &steps[s];
						let k = match st.kind {
							StepKind::Accept => 0,
							StepKind::Task => 1,
							StepKind::Turnin => 2,
						};
						(k, st.q as i64, st.task, st.pt)
					})
					.collect(),
			});
		}
	}
	for (di, dg) in dungeons.iter().enumerate() {
		let qs: Vec<usize> = dg.quests.iter().filter_map(|id| by_id.get(id).copied()).collect();
		let near = |pick: &dyn Fn(usize) -> u32| -> Vec<usize> {
			let mut out = Vec::new();
			let mut left = qs.clone();
			let mut cur = dg.pt;
			while !left.is_empty() {
				let mut bi = 0;
				for i in 1..left.len() {
					if b.dist(cur, pick(left[i])) < b.dist(cur, pick(left[bi])) {
						bi = i;
					}
				}
				let x = left.remove(bi);
				out.push(x);
				cur = pick(x);
			}
			out
		};
		let mut accepts = near(&|q| quests[q].giver);
		accepts.reverse();
		let turnins = near(&|q| quests[q].ender);
		let mut steps: Vec<(u8, i64, i64, u32)> = accepts.iter().map(|&q| (0, quests[q].id as i64, -1, quests[q].giver)).collect();
		steps.push((4, di as i64, -1, dg.pt));
		steps.extend(turnins.iter().map(|&q| (2u8, quests[q].id as i64, -1i64, quests[q].ender)));
		let dmin = num(Some(&dg.min));
		packages.push(Package {
			key: format!("Dungeon: {}", js_str(Some(&dg.name))),
			zone: dg.zone,
			zone_name: zone_name(dg.zone),
			band: band_idx(dmin),
			levels: (dmin, num(Some(&dg.max))),
			dungeon: Some(di as u32),
			quests: qs.iter().map(|&q| quests[q].id).collect(),
			steps,
		});
	}

	// ---- grinding spacing ----
	let mut spacing: Vec<Option<f64>> = vec![None; 64];
	for (&id, raw) in &d.npcs {
		if raw.faction.as_deref().is_some_and(|f| !f.is_empty()) || elite_rank(raw.rank) || raw.rank == Some(4.0) || raw.roles.as_ref().is_some_and(|r| !r.is_empty()) {
			continue;
		}
		let lvl = npc_level(raw, Some(0.0)).unwrap_or(0.0);
		if !(1.0..=63.0).contains(&lvl) {
			continue;
		}
		let n: usize = raw.spawns.values().map(|s| s.pts.len()).sum();
		if n < 10 {
			continue;
		}
		let Some(e) = b.sites(Kind::Npc, id as i64) else { continue };
		let l = lvl as usize;
		for s in &e.sites {
			if s.size < 8 || s.spacing <= 0.0 {
				continue;
			}
			if spacing[l].is_none_or(|x| s.spacing < x) {
				spacing[l] = Some(round1(s.spacing));
			}
		}
	}
	for l in 1..=63usize {
		if spacing[l].is_none() {
			let mut best = None;
			let mut dd = 1usize;
			while dd < 63 && best.is_none() {
				let lo = if l >= dd && l - dd >= 1 {
					spacing[l - dd]
				} else if l == dd {
					spacing[0]
				} else {
					None
				};
				let hi = spacing.get(l + dd).copied().flatten();
				best = lo.or(hi);
				dd += 1;
			}
			spacing[l] = Some(best.unwrap_or(30.0));
		}
		spacing[l] = Some(spacing[l].unwrap().max(12.0));
	}
	spacing[0] = spacing[1];
	let grind_spacing: Vec<f64> = spacing.into_iter().map(|x| x.unwrap_or(f64::NAN)).collect();

	// ---- travel safety ----
	let mut zone_min: BTreeMap<u32, f64> = BTreeMap::new();
	for (id, z) in zone_levels(&d.npcs, &d.zones, &[]) {
		if let Some(m) = z.min.filter(|m| m.is_finite()) {
			zone_min.insert(id, m);
		}
	}
	let mut cell_count: BTreeMap<i64, Vec<((i64, i64), Vec<(u32, u32)>)>> = BTreeMap::new();
	let mut cell_index: FxHashMap<(i64, i64, i64), usize> = FxHashMap::default();
	for raw in d.npcs.values() {
		for (&map, sp) in &raw.spawns {
			if !b.allowed_map(map) {
				continue;
			}
			let live = sp.f.as_deref() == Some("l");
			for p in &sp.pts {
				if p.len() < 2 {
					continue;
				}
				let (c, wx, wy) = b.to_world(map, p[0], p[1], live);
				let region = region_of(c, map);
				let k = ((wx / DANGER_CELL).floor() as i64, (wy / DANGER_CELL).floor() as i64);
				let cells = cell_count.entry(region).or_default();
				let idx = *cell_index.entry((region, k.0, k.1)).or_insert_with(|| {
					cells.push((k, Vec::new()));
					cells.len() - 1
				});
				let m = &mut cells[idx].1;
				match m.iter_mut().find(|e| e.0 == map) {
					Some(e) => e.1 += 1,
					None => m.push((map, 1)),
				}
			}
		}
	}
	let mut danger: Vec<Danger> = Vec::new();
	for (region, cells) in cell_count {
		let (mut gx0, mut gy0, mut gx1, mut gy1) = (i64::MAX, i64::MAX, i64::MIN, i64::MIN);
		for ((gx, gy), _) in &cells {
			gx0 = gx0.min(*gx);
			gy0 = gy0.min(*gy);
			gx1 = gx1.max(*gx);
			gy1 = gy1.max(*gy);
		}
		let nx = gx1 - gx0 + 1;
		let ny = gy1 - gy0 + 1;
		let mut z = vec![0u32; (nx * ny) as usize];
		for ((gx, gy), m) in &cells {
			let mut sorted = m.clone();
			sorted.sort_by_key(|e| e.0);
			let mut best = 0;
			let mut bn = 0;
			for (map, n) in sorted {
				if n > bn {
					bn = n;
					best = map;
				}
			}
			z[((gx - gx0) * ny + (gy - gy0)) as usize] = best;
		}
		let mut frontier: Vec<usize> = (0..z.len()).filter(|&i| z[i] != 0).collect();
		let mut ring = 0;
		while ring < 3 && !frontier.is_empty() {
			let mut add: BTreeMap<usize, u32> = BTreeMap::new();
			for &i in &frontier {
				let x = (i as i64) / ny;
				let y = (i as i64) % ny;
				for (dx, dy) in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
					let (xx, yy) = (x + dx, y + dy);
					if xx < 0 || yy < 0 || xx >= nx || yy >= ny {
						continue;
					}
					let j = (xx * ny + yy) as usize;
					if z[j] != 0 || add.contains_key(&j) {
						continue;
					}
					add.insert(j, z[i]);
				}
			}
			let mut next = Vec::new();
			for (j, v) in add {
				z[j] = v;
				next.push(j);
			}
			frontier = next;
			ring += 1;
		}
		danger.push(Danger { region, gx0, gy0, nx, ny, cell: DANGER_CELL, z });
	}

	// ---- starts ----
	let mut starts: Vec<(String, Start)> = Vec::new();
	for (race, spec) in starts_of(faction) {
		let (qid, zname) = match spec {
			StartSpec::Quest(q, z) => (Some(q), z.to_string()),
			StartSpec::Skyborne => {
				let mut follows: FxHashMap<i64, u32> = FxHashMap::default();
				for q in &quests {
					for &p in q.pre.iter().chain(&q.pre_all) {
						*follows.entry(p).or_default() += 1;
					}
				}
				let sky = faction.skyborne_bit();
				let mut cand: Vec<&WQuest> = quests
					.iter()
					.filter(|q| {
						let m = b.points[q.giver as usize].map;
						(m == 2521 || m == 2665) && q.pre.is_empty() && q.pre_all.is_empty() && q.level <= 1.0 && q.races.is_none_or(|r| (r as u64) & sky != 0)
					})
					.collect();
				cand.sort_by(|a, bb| {
					let fa = follows.get(&(a.id as i64)).copied().unwrap_or(0);
					let fb = follows.get(&(bb.id as i64)).copied().unwrap_or(0);
					fb.cmp(&fa).then(a.id.cmp(&bb.id))
				});
				(cand.first().map(|q| q.id), "Zephras Isle".to_string())
			}
		};
		match qid.and_then(|q| by_id.get(&q)) {
			Some(&qi) => starts.push((race.to_string(), Start { zone: zname, pt: quests[qi].giver, quest: quests[qi].id })),
			None => warnings.push(format!("start quest {} for {race} not in the world", qid.map_or("null".into(), |q| q.to_string()))),
		}
	}
	for (race, zone, quest) in &opts.extra_starts {
		match by_id.get(quest) {
			Some(&qi) => {
				let s = Start { zone: zone.clone(), pt: quests[qi].giver, quest: *quest };
				match starts.iter_mut().find(|e| &e.0 == race) {
					Some(e) => e.1 = s,
					None => starts.push((race.clone(), s)),
				}
			}
			None => warnings.push(format!("start quest {quest} for {race} not in the world")),
		}
	}
	for q in &mut quests {
		q.hub_giver = hub_of_point.get(&q.giver).copied().unwrap_or(-1);
		q.hub_ender = hub_of_point.get(&q.ender).copied().unwrap_or(-1);
	}
	let floor_misses = b.floor_misses;
	let mut zones: BTreeMap<u32, String> = BTreeMap::new();
	for p in &b.points {
		zones.entry(p.map).or_insert_with(|| zone_name(p.map));
	}
	by_id.clear();
	let mut world = World {
		faction,
		band_width,
		max_open,
		points: std::mem::take(&mut b.points),
		heights: b.heights,
		nodes,
		taxi,
		rides,
		inns,
		hubs,
		quests,
		excluded,
		camps: std::mem::take(&mut b.camps),
		services,
		service_set,
		areas: Vec::new(),
		point_area: Vec::new(),
		training,
		training_spells,
		riding,
		classes,
		excluded_ids,
		solo: Solo { counts: solo_counts, repeat_no_xp, instance_areas: quest_areas.map(|q| q.build.clone()), overrides: (solo.exclude.len(), solo.allow.len(), solo.turnin_after.len()) },
		packages,
		dungeons,
		grind_spacing,
		zone_min,
		danger,
		starts,
		zones,
		warnings,
		pre_rules,
		data_hash: None,
		inputs: Vec::new(),
		quest_xp: Value::Null,
	};
	let (areas, point_area) = build_areas(&world, 250.0, 400.0);
	world.areas = areas;
	world.point_area = point_area;
	Ok((world, floor_misses))
}

/// JS default sort (UTF-16 code units) for ASCII-ish strings.
fn js_str_cmp(a: &str, b: &str) -> std::cmp::Ordering {
	a.encode_utf16().cmp(b.encode_utf16())
}

/// liftFloor(s, z) -> (floor spawns placed on some map, map -> spawns in first-seen order).
fn lift_floor(b: &mut Builder, c: i64, wx: f64, wy: f64, z: Option<&Value>) -> (u32, Vec<(u32, u32)>) {
	let mut out = (0u32, Vec::new());
	let Some(z) = finite(z) else { return out };
	let d = b.d;
	for k in Kind::BOTH {
		let Some(list) = d.spawnz.as_ref().map(|s| s.of(k)) else { continue };
		for (&id, recs) in list {
			for r in recs {
				let g = |i: usize| r.get(i).copied().flatten();
				let (Some(rc), Some(rx), Some(ry)) = (g(0), g(1), g(2)) else { continue };
				let Some(rz) = g(3).filter(|z| z.is_finite()) else { continue };
				if rc != c as f64 || (rz - z).abs() > LIFT_END_Z || js_hypot(rx - wx, ry - wy) > LIFT_END_R {
					continue;
				}
				// mapsOfSpawn(kind, id, r0, r1, r2).
				let mut maps: Vec<u32> = Vec::new();
				if let Some(raw) = d.entities(k).get(&id) {
					for (&map, sp) in &raw.spawns {
						if !b.allowed_map(map) {
							continue;
						}
						for p in &sp.pts {
							if p.len() < 2 {
								continue;
							}
							let (wc, px, py) = b.to_world(map, p[0], p[1], sp.f.as_deref() == Some("l"));
							if wc == rc as i64 && js_hypot(px - rx, py - ry) <= HEIGHT_YARDS && !maps.contains(&map) {
								maps.push(map);
							}
						}
					}
				}
				if maps.is_empty() {
					continue;
				}
				out.0 += 1;
				for m in maps {
					match out.1.iter_mut().find(|e: &&mut (u32, u32)| e.0 == m) {
						Some(e) => e.1 += 1,
						None => out.1.push((m, 1)),
					}
				}
			}
		}
	}
	out
}

fn solid_source(d: &GameData, faction: Faction, kind: Kind, id: i64) -> bool {
	if kind != Kind::Npc {
		return true;
	}
	let Some(n) = u32::try_from(id).ok().and_then(|i| d.npcs.get(&i)) else { return false };
	let fac = n.faction.as_deref().filter(|f| !f.is_empty());
	!elite_rank(n.rank) && n.rank != Some(4.0) && !(fac.is_some() && friendly(fac, faction))
}

fn object_chance(d: &GameData, id: u32, item: &Item, chance: Option<f64>) -> Option<f64> {
	let f = d.object_facts.as_ref().and_then(|o| o.get(&id));
	if f.is_some_and(|f| f.kind.is_some_and(|t| USED_OBJECT_TYPES.contains(&t))) {
		return Some(100.0);
	}
	if let Some(l) = f.and_then(|f| f.loot.as_ref()).and_then(|l| l.get(&item.id.to_string())) {
		if l.first().copied().unwrap_or(0.0) != 0.0 {
			let g = |i: usize| l.get(i).copied().unwrap_or(f64::NAN);
			return Some((g(0).abs() * (g(1) + g(2))) / 2.0);
		}
	}
	if chance.is_none() && item.quest_item == Some(true) {
		Some(OBJECT_QUEST_DROP)
	} else {
		chance
	}
}

fn camps_for(b: &mut Builder, cache: &mut FxHashMap<String, Vec<u32>>, sources: &[Src]) -> Vec<u32> {
	let mut placed: Vec<CampSource> = Vec::new();
	for s in sources {
		if b.sites(s.kind, s.id as i64).is_some_and(|e| !e.spawns.is_empty()) {
			placed.push(CampSource { kind: s.kind, id: s.id });
		}
	}
	let mut keys: Vec<String> = placed.iter().map(|s| format!("{}:{}", s.kind.as_str(), s.id)).collect();
	keys.sort();
	let key = keys.join(",");
	if let Some(v) = cache.get(&key) {
		return v.clone();
	}
	let ids = build_camps(&placed, &mut Host { b });
	cache.insert(key, ids.clone());
	ids
}
