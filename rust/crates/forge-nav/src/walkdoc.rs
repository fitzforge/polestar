//! A world's walks document from the walk store (port of tools/lib/sim/walks.js walkPoints,
//! anchorPoints, campPoints, radiusFor, sendAt, walkQueries, assembleBand, zoneSharer, walksDoc and
//! writeWalks, and walktables.js routerWalks' asks, danger tables and zoneTable). Each band's
//! asked pairs are answered by the store (by ends, grid and cost model; the rest routed in Rust),
//! assembled as routerWalks assembles a router table, and written as `walks-<faction>.bin`
//! (BIN_SCHEMA 5) that walklookup.js and forge-sim read.

use crate::cost::{danger_of, Area, Ground, Profile, ZoneGrid, Zones};
use crate::lookup::Band;
use crate::psbn::{self, Section};
use crate::store::{Answer, End, Profile as SP, WalkStore, ZoneCells};
use crate::walker::{walk_model, StoreRouter, Walker};
use forge_core::jsnum::{js_hypot, js_round};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{json, Map, Value};
use std::sync::Arc;

pub const RADIUS: f64 = 4000.0;
pub const ANCHOR_RADIUS: f64 = 12000.0;
pub const CAMP_RADIUS: f64 = 1500.0;
pub const CAMP_CAMP_RADIUS: f64 = 600.0;
pub const BANDS: [i64; 6] = [0, 10, 20, 30, 40, 50];
pub const ONE_WAY_DZ: f64 = 15.0;
pub const UNWALK_DZ: f64 = 40.0;
pub const DANGER_GAP: f64 = 4.0;
pub const STYLE: &str = "balanced";
const BIN_SCHEMA: i64 = 5;

/// A world point: continent, region, x, y, zone, height.
#[derive(Clone, Copy, Debug)]
pub struct Pt {
	pub c: i64,
	pub region: i64,
	pub x: f64,
	pub y: f64,
	pub zone: i64,
	pub z: Option<f64>,
}

/// What the walks read of a world file.
pub struct WalkWorld {
	pub faction: String,
	pub data_hash: String,
	pub points: Vec<Pt>,
	pub zone_min: Vec<(u16, f64)>,
	pub danger: Vec<ZoneGrid>,
	walk: Vec<usize>,
	plain: FxHashSet<usize>,
	anchors: FxHashSet<usize>,
}

fn num(v: &Value) -> Option<usize> {
	v.as_f64().map(|x| x as usize)
}

impl WalkWorld {
	pub fn from_json(bytes: &[u8], maps: &[i64]) -> Result<WalkWorld, String> {
		let w: Value = serde_json::from_slice(bytes).map_err(|e| e.to_string())?;
		let points: Vec<Pt> = w["points"]
			.as_array()
			.ok_or("world: no points")?
			.iter()
			.map(|p| Pt {
				c: p[0].as_i64().unwrap_or(0),
				region: p[1].as_i64().unwrap_or(0),
				x: p[2].as_f64().unwrap_or(0.0),
				y: p[3].as_f64().unwrap_or(0.0),
				zone: p[4].as_i64().unwrap_or(0),
				z: p[5].as_f64(),
			})
			.collect();
		let zone_min = w["zoneMin"].as_object().map(|o| o.iter().map(|(k, v)| (k.parse().unwrap_or(0), v.as_f64().unwrap_or(0.0))).collect()).unwrap_or_default();
		// walks.js zonesOf: each grid's continent, the first point's of its region.
		let mut c_of: FxHashMap<i64, i64> = FxHashMap::default();
		for p in &points {
			c_of.entry(p.region).or_insert(p.c);
		}
		let danger = w["danger"]
			.as_array()
			.into_iter()
			.flatten()
			.map(|g| ZoneGrid {
				c: c_of.get(&g["region"].as_i64().unwrap_or(-1)).copied().unwrap_or(-1) as u32,
				region: g["region"].as_i64().unwrap_or(-1),
				gx0: g["gx0"].as_i64().unwrap_or(0),
				gy0: g["gy0"].as_i64().unwrap_or(0),
				nx: g["nx"].as_i64().unwrap_or(0),
				ny: g["ny"].as_i64().unwrap_or(0),
				cell: g["cell"].as_f64().unwrap_or(200.0),
				z: g["z"].as_array().map(|a| a.iter().map(|v| v.as_u64().unwrap_or(0) as u16).collect()).unwrap_or_default(),
			})
			.collect();
		let n = points.len();
		let in_maps = |pt: usize| pt < n && maps.contains(&points[pt].c);
		// anchorPoints: inns, nodes, starts, services.
		let mut anchors = FxHashSet::default();
		let mut add_anchor = |v: &Value| {
			if let Some(pt) = num(&v["pt"]) {
				anchors.insert(pt);
			}
		};
		for x in w["inns"].as_array().into_iter().flatten().chain(w["nodes"].as_array().into_iter().flatten()) {
			add_anchor(x);
		}
		for x in w["starts"].as_object().into_iter().flat_map(|o| o.values()) {
			add_anchor(x);
		}
		for v in w["services"].as_object().into_iter().flat_map(|o| o.values()) {
			match v {
				Value::Array(a) => a.iter().for_each(&mut add_anchor),
				Value::Object(o) => o.values().flat_map(|x| x.as_array().cloned().unwrap_or_else(|| vec![x.clone()])).for_each(|x| add_anchor(&x)),
				_ => {}
			}
		}
		// walkPoints without and with camps.
		let mut set: FxHashSet<usize> = FxHashSet::default();
		let mut add = |v: &Value| {
			if let Some(pt) = num(v) {
				if in_maps(pt) {
					set.insert(pt);
				}
			}
		};
		for q in w["quests"].as_array().into_iter().flatten() {
			add(&q["giver"]);
			add(&q["ender"]);
			for k in ["gAlt", "eAlt"] {
				for v in q[k].as_object().into_iter().flat_map(|o| o.values()) {
					add(v);
				}
			}
			add(&q["accept"]["pt"]);
			for t in q["tasks"].as_array().into_iter().flatten() {
				add(&t["pt"]);
			}
		}
		for p in w["packages"].as_array().into_iter().flatten() {
			for s in p["steps"].as_array().into_iter().flatten() {
				add(&s[3]);
			}
		}
		for &pt in &anchors {
			if in_maps(pt) {
				set.insert(pt);
			}
		}
		let plain = set.clone();
		let camps = w["camps"].as_array().cloned().unwrap_or_default();
		for q in w["quests"].as_array().into_iter().flatten() {
			for o in q["objs"].as_array().into_iter().flatten() {
				for id in o["camps"].as_array().into_iter().flatten() {
					if let Some(c) = num(id).and_then(|i| camps.get(i)) {
						if let Some(pt) = num(&c["pt"]) {
							if in_maps(pt) {
								set.insert(pt);
							}
						}
					}
				}
			}
		}
		let mut walk: Vec<usize> = set.into_iter().collect();
		walk.sort_unstable();
		Ok(WalkWorld { faction: w["faction"].as_str().unwrap_or("").to_string(), data_hash: w["dataHash"].as_str().unwrap_or("").to_string(), points, zone_min, danger, walk, plain, anchors })
	}

	pub fn walk_points(&self) -> &[usize] {
		&self.walk
	}

	/// walks.js crossing: the highest minimum level of the zones the straight line crosses (end
	/// zones not counted), -inf for none (travel.js crossedZones).
	fn highest(&self, a: usize, b: usize) -> f64 {
		let (pa, pb) = (&self.points[a], &self.points[b]);
		let Some(g) = self.danger.iter().find(|g| g.region == pa.region) else { return f64::NEG_INFINITY };
		let (dx, dy) = (pb.x - pa.x, pb.y - pa.y);
		let n = (js_hypot(dx, dy) / g.cell).ceil() as i64;
		let mut seen: Vec<u16> = Vec::new();
		for i in 1..n {
			let gx = ((pa.x + (dx * i as f64) / n as f64) / g.cell).floor() as i64;
			let gy = ((pa.y + (dy * i as f64) / n as f64) / g.cell).floor() as i64;
			let (x, y) = (gx - g.gx0, gy - g.gy0);
			if x < 0 || y < 0 || x >= g.nx || y >= g.ny {
				continue;
			}
			let z = g.z[(x * g.ny + y) as usize];
			if z == 0 || z as i64 == pa.zone || z as i64 == pb.zone || seen.contains(&z) {
				continue;
			}
			seen.push(z);
		}
		seen.iter().filter_map(|z| self.zone_min.iter().find(|m| m.0 == *z).map(|m| m.1)).fold(f64::NEG_INFINITY, f64::max)
	}

	fn kind(&self, pt: usize) -> u8 {
		if self.anchors.contains(&pt) {
			0
		} else if !self.plain.contains(&pt) {
			1
		} else {
			2
		}
	}

	/// walks.js walkQueries: per source (ascending), its later points within reach, grouped by the
	/// target's zone in a danger band -> [(src, ids)].
	pub fn queries(&self, band: i64) -> Vec<(usize, Vec<usize>)> {
		let pts = &self.walk;
		let radius_for = |ka: u8, kb: u8| -> f64 {
			if ka == 0 && kb == 0 {
				RADIUS.max(ANCHOR_RADIUS)
			} else if ka == 1 && kb == 1 {
				RADIUS.min(CAMP_CAMP_RADIUS)
			} else if ka == 1 || kb == 1 {
				RADIUS.min(CAMP_RADIUS)
			} else {
				RADIUS
			}
		};
		let kinds: Vec<u8> = pts.iter().map(|&p| self.kind(p)).collect();
		let mut out = Vec::new();
		for i in 0..pts.len() {
			let src = pts[i];
			let a = &self.points[src];
			let mut groups: Vec<(i64, Vec<usize>)> = Vec::new();
			for j in i + 1..pts.len() {
				let t = pts[j];
				let b = &self.points[t];
				if b.c != a.c || b.region != a.region {
					continue;
				}
				if js_hypot(b.x - a.x, b.y - a.y) > radius_for(kinds[i], kinds[j]) {
					continue;
				}
				if band != 0 && self.highest(src, t) < band as f64 + DANGER_GAP {
					continue;
				}
				let g = if band != 0 { b.zone } else { 0 };
				match groups.iter_mut().find(|x| x.0 == g) {
					Some(x) => x.1.push(t),
					None => groups.push((g, vec![t])),
				}
			}
			for (_, ids) in groups {
				out.push((src, ids));
			}
		}
		out
	}

	fn descent(&self, a: usize, b: usize) -> bool {
		match (self.points[a].z, self.points[b].z) {
			(Some(x), Some(y)) => (x - y).abs() > ONE_WAY_DZ,
			_ => false,
		}
	}
}

/// What the router is sent for each world point (walks.js sendAt over gridSnap): the snapped
/// column's x, y with the point's own height and the surface's; the point itself unsnapped.
pub fn ends_of(world: &WalkWorld, walker: &Walker) -> Vec<End> {
	use rayon::prelude::*;
	let used: FxHashSet<usize> = world.walk.iter().copied().collect();
	(0..world.points.len())
		.into_par_iter()
		.map(|i| {
			let p = &world.points[i];
			if !used.contains(&i) {
				return End::new(p.c as i32, p.x, p.y, p.z, p.z);
			}
			let s = walker.nav.snap(&crate::legs::SnapAsk { c: p.c as u32, wx: p.x, wy: p.y, z: p.z, radius: 20.0, under: false, stand: false });
			match s {
				Some(s) => End::new(p.c as i32, s.wx, s.wy, p.z, Some(s.z)),
				None => End::new(p.c as i32, p.x, p.y, p.z, p.z),
			}
		})
		.collect()
}

/// Who answers a document's walks: the model of a danger table, the ends it is sent, the zone
/// an end lies in (for the danger tables), the router for the pairs the store lacks.
pub trait Backend: Sync {
	/// `router` in the document's header ("node": the walking grid's router).
	fn router_name(&self) -> &str;
	/// Walked yards per stored yard.
	fn smooth(&self) -> f64;
	/// The store model of a danger table (empty: the base walk).
	fn model(&self, danger: &[(u16, f64)]) -> crate::store::Model;
	/// Each world point's end as this backend is sent it.
	fn ends(&self, world: &WalkWorld) -> Vec<End>;
	/// router.js zoneAt at an end.
	fn zone_at(&self, e: &End) -> u16;
	/// A router answering the given models (their danger tables), with zone cells when asked.
	fn router<'a>(&'a self, models: Vec<(crate::store::Model, Vec<(u16, f64)>)>, cells: bool, band: i64) -> Box<dyn BackendRouter + 'a>;
}

/// A store router that also counts the pairs the straight line answered.
pub trait BackendRouter: crate::store::Router {
	fn straight(&self) -> usize {
		0
	}
}

impl BackendRouter for StoreRouter<'_> {
	fn straight(&self) -> usize {
		self.by_line
	}
}

/// The walking grid's backend: forge-nav's legs, CCH and coarse search (walker.rs).
pub struct GridBackend<'w> {
	pub walker: &'w Walker,
	pub pricing: Pricing,
}

impl Backend for GridBackend<'_> {
	fn router_name(&self) -> &str {
		"node"
	}
	fn smooth(&self) -> f64 {
		self.pricing.smooth
	}
	fn model(&self, danger: &[(u16, f64)]) -> crate::store::Model {
		let pr = &self.pricing;
		walk_model(&pr.grid_id, &pr.profile(danger), STYLE, pr.smooth, &pr.zones.tag)
	}
	fn ends(&self, world: &WalkWorld) -> Vec<End> {
		ends_of(world, self.walker)
	}
	fn zone_at(&self, e: &End) -> u16 {
		self.walker.zone_at(&self.pricing.zones, e.c as u32, e.x, e.y)
	}
	fn router<'a>(&'a self, models: Vec<(crate::store::Model, Vec<(u16, f64)>)>, cells: bool, band: i64) -> Box<dyn BackendRouter + 'a> {
		let pr = &self.pricing;
		let mut r = StoreRouter::new(self.walker, pr.smooth);
		r.cells = cells;
		for (m, d) in models {
			r.models.insert(m, (Arc::new(pr.profile(&d)), pr.zones.tag.clone()));
		}
		let tl = std::time::Instant::now();
		r.log = Some(Box::new(move |done, all| eprintln!("  band {band}: {done}/{all} pairs routed, {:.0} s", tl.elapsed().as_secs_f64())));
		Box::new(r)
	}
}

/// Everything a document's walks are priced by.
pub struct Pricing {
	pub grid_id: String,
	pub ground: Arc<Ground>,
	pub zones: Arc<Zones>,
	pub faction: Option<&'static str>,
	pub smooth: f64,
}

impl Pricing {
	pub fn profile(&self, danger: &[(u16, f64)]) -> Profile {
		Profile::walk(self.faction, self.ground.clone(), Area::new(danger, self.zones.clone()))
	}
}

/// A band's tally.
#[derive(Default, Debug, Clone)]
pub struct BandStats {
	pub band: i64,
	pub pairs: usize,
	pub stored: usize,
	pub routed: usize,
	pub straight: usize,
	pub failed: usize,
	pub tables: usize,
	pub ms: f64,
}

/// The walks document: header fields, pairs per band, unwalkable, zone shares (off, val, has).
pub struct Doc {
	pub header: Map<String, Value>,
	pub pairs: Vec<(i64, Vec<f64>)>,
	pub unwalkable: Vec<i32>,
	pub zones: (Vec<u32>, Vec<f64>, Vec<u8>),
}

fn alike(u: f64, v: f64) -> bool {
	(u - v).abs() <= 1f64.max(0.02 * u.min(v))
}

/// The table value of a stored answer (walktables.js: yards and cost rounded to 0.1, -1 none).
fn table_value(a: &Answer, smooth: f64) -> (f64, f64) {
	if a.yd >= 0.0 && a.yd.is_finite() {
		(forge_core::jsnum::round1(a.yd / smooth), forge_core::jsnum::round1(a.cost))
	} else {
		(-1.0, -1.0)
	}
}

/// routerWalks over the walk store: band by band, the asks answered (stored or routed),
/// assembled; base walks' zone shares from their cells.
pub fn build_doc(world: &WalkWorld, ends: &[End], store: &mut WalkStore, be: &dyn Backend, nav_fp: &str, log: &dyn Fn(&str), bands: &[i64]) -> (Doc, Vec<BandStats>) {
	let smooth = be.smooth();
	let mut header = Map::new();
	for (k, v) in [
		("schema", json!(BIN_SCHEMA)),
		("faction", json!(world.faction)),
		("dataHash", json!(world.data_hash)),
		("router", json!(be.router_name())),
		("nav", json!(nav_fp)),
		("smooth", json!(smooth)),
		("style", json!(STYLE)),
		("radius", json!(RADIUS as i64)),
		("anchorRadius", json!(ANCHOR_RADIUS as i64)),
		("bands", json!(bands)),
		("oneWayDz", json!(ONE_WAY_DZ as i64)),
		("points", json!(world.walk.len())),
		("nw", json!(world.points.len())),
	] {
		header.insert(k.into(), v);
	}
	let mut pairs_out = Vec::new();
	let mut unwalkable: Vec<i32> = Vec::new();
	let mut zones = (vec![0u32], Vec::new(), Vec::new());
	let mut stats = Vec::new();
	for &band in bands {
		let t0 = std::time::Instant::now();
		let qs = world.queries(band);
		// The band's asks: walkQueries' and, for the base walk, each descent's way back.
		let mut asks: Vec<(usize, Vec<usize>)> = qs.clone();
		if band == 0 {
			let mut back: Vec<(usize, Vec<usize>)> = Vec::new();
			let mut at: FxHashMap<usize, usize> = FxHashMap::default();
			for (src, ids) in &qs {
				for &t in ids {
					if !world.descent(*src, t) {
						continue;
					}
					let k = *at.entry(t).or_insert_with(|| {
						back.push((t, Vec::new()));
						back.len() - 1
					});
					back[k].1.push(*src);
				}
			}
			asks.extend(back);
		}
		// Each ask's danger table (router.js dangerOf over the ends' zones; the first target's).
		let mut models: FxHashMap<String, u32> = FxHashMap::default();
		let mut model_list: Vec<(crate::store::Model, Vec<(u16, f64)>)> = Vec::new();
		let mut store_asks: Vec<(End, End, SP)> = Vec::new();
		let mut pair_ix: Vec<(usize, usize)> = Vec::new();
		for (src, ids) in &asks {
			let danger = if band == 0 { Vec::new() } else { danger_of(band as f64, &world.zone_min, be.zone_at(&ends[*src]), be.zone_at(&ends[ids[0]])) };
			let model = be.model(&danger);
			let m = *models.entry(model.params.clone()).or_insert_with(|| {
				let m = store.model(&model);
				model_list.push((model.clone(), danger.clone()));
				m
			});
			for &t in ids {
				store_asks.push((ends[*src], ends[t], SP { model: m, base: None }));
				pair_ix.push((*src, t));
			}
		}
		let n = store_asks.len();
		let mut router = be.router(model_list, band == 0, band);
		let w = store.walks_cells(&store_asks, &mut *router, band == 0);
		// The band's answers by (src, dst).
		let mut exact: FxHashMap<(usize, usize), (f64, f64, Option<ZoneCells>)> = FxHashMap::default();
		exact.reserve(n);
		for (i, (&(a, b), cl)) in pair_ix.iter().zip(w.cells).enumerate() {
			let (y, c) = table_value(&w.answers[i], smooth);
			exact.insert((a, b), (y, c, if y >= 0.0 { cl } else { None }));
		}
		// walks.js assembleBand.
		let mut pairs: Vec<f64> = Vec::new();
		let (mut failed, mut missing) = (0, 0);
		let lookup = |a: usize, b: usize| exact.get(&(a, b)).or_else(|| exact.get(&(b, a)));
		for (src, ids) in &qs {
			for &t in ids {
				if band == 0 && world.descent(*src, t) {
					let (f, r) = (exact.get(&(*src, t)), exact.get(&(t, *src)));
					let (Some(f), Some(r)) = (f, r) else {
						match f.or(r).or_else(|| lookup(*src, t)) {
							None => missing += 1,
							Some(v) if v.0 >= 0.0 => pairs.extend([*src as f64, t as f64, v.0, v.1, 0.0]),
							_ => failed += 1,
						}
						continue;
					};
					let (f_ok, r_ok) = (f.0 >= 0.0, r.0 >= 0.0);
					if f_ok && r_ok && !(alike(f.0, r.0) && alike(f.1, r.1)) {
						pairs.extend([*src as f64, t as f64, f.0, f.1, 1.0, t as f64, *src as f64, r.0, r.1, 1.0]);
					} else if f_ok || r_ok {
						let v = if f_ok { f } else { r };
						pairs.extend([*src as f64, t as f64, v.0, v.1, 0.0]);
					} else {
						failed += 1;
						let (za, zb) = (world.points[*src].z.unwrap_or(0.0), world.points[t].z.unwrap_or(0.0));
						if (za - zb).abs() > UNWALK_DZ {
							unwalkable.extend([*src as i32, t as i32]);
						}
					}
					continue;
				}
				match lookup(*src, t) {
					None => missing += 1,
					Some(v) if v.0 >= 0.0 => pairs.extend([*src as f64, t as f64, v.0, v.1, 0.0]),
					_ => failed += 1,
				}
			}
		}
		assert_eq!(missing, 0, "walks: band {band}: {missing} walks the asks lack");
		if band == 0 {
			zones = zone_table(world, &pairs, &|a, b| exact.get(&(a, b)).or_else(|| lookup(a, b)).and_then(|v| v.2.clone()));
		}
		let st = BandStats { band, pairs: n, stored: w.stored, routed: w.routed, straight: router.straight(), failed, tables: models.len(), ms: t0.elapsed().as_secs_f64() * 1e3 };
		log(&format!(
			"band {band}: {n} pairs ({} danger tables): {} stored, {} routed ({} straight), {failed} not walkable, {} s",
			st.tables,
			st.stored,
			st.routed,
			st.straight,
			(st.ms / 1e3).round()
		));
		stats.push(st);
		pairs_out.push((band, pairs));
	}
	(Doc { header, pairs: pairs_out, unwalkable, zones }, stats)
}

/// walktables.js zoneTable over walks.js zoneSharer.
fn zone_table(world: &WalkWorld, base: &[f64], cells_of: &dyn Fn(usize, usize) -> Option<ZoneCells>) -> (Vec<u32>, Vec<f64>, Vec<u8>) {
	let n = base.len() / 5;
	let mut off = vec![0u32; n + 1];
	let mut has = vec![0u8; n];
	let mut val = Vec::new();
	for k in 0..n {
		let (a, b, y) = (base[5 * k] as usize, base[5 * k + 1] as usize, base[5 * k + 2]);
		let z = cells_of(a, b).and_then(|c| share(world, a, &c, y));
		if let Some(z) = &z {
			has[k] = 1;
			val.extend_from_slice(z);
		}
		off[k + 1] = val.len() as u32;
	}
	(off, val, has)
}

/// walks.js zoneSharer: yards Y per zone of a walk from a, by its cells on a's region's grid.
fn share(world: &WalkWorld, a: usize, cells: &[(u32, f32)], y: f64) -> Option<Vec<f64>> {
	if cells.is_empty() {
		return None;
	}
	let g = world.danger.iter().find(|g| g.region == world.points[a].region);
	let mut yd: Vec<(u16, f64)> = Vec::new();
	let mut total = 0.0;
	for &(key, v) in cells {
		let (gx, gy) = forge_core::cells::cell_xy(key as i64);
		let z = g.map(|g| g.at_cell(gx, gy)).unwrap_or(0);
		match yd.iter_mut().find(|x| x.0 == z) {
			Some(x) => x.1 += v as f64,
			None => yd.push((z, v as f64)),
		}
		total += v as f64;
	}
	if total.partial_cmp(&0.0) != Some(std::cmp::Ordering::Greater) {
		return None;
	}
	yd.sort_by_key(|x| x.0);
	Some(yd.iter().flat_map(|&(z, v)| [z as f64, js_round((v / total) * y * 10.0) / 10.0]).collect())
}

/// walks.js writeWalks' bytes (binfile.js): pairs of 5 per band, the band's lookup table, the
/// unwalkable pairs, the zone shares.
pub fn encode(doc: &Doc, smooth: f64) -> Vec<u8> {
	let nw = doc.header["nw"].as_u64().unwrap() as usize;
	let mut sections = Vec::new();
	for (band, p) in &doc.pairs {
		sections.push(Section::f64s(&format!("p{band}"), p));
		let t = Band::build(p, nw, 5, smooth);
		sections.push(Section::u32s(&format!("L{band}.offsets"), &t.offsets));
		sections.push(Section::i32s(&format!("L{band}.nbr"), &t.nbr));
		sections.push(Section::f32s(&format!("L{band}.yd"), &t.yd));
		sections.push(Section::f32s(&format!("L{band}.cost"), &t.cost));
		sections.push(Section::i32s(&format!("L{band}.src"), &t.src));
	}
	sections.push(Section::i32s("unwalkable", &doc.unwalkable));
	sections.push(Section::u32s("zoff", &doc.zones.0));
	sections.push(Section::f64s("zval", &doc.zones.1));
	sections.push(Section::u8s("zhas", &doc.zones.2));
	psbn::encode(&doc.header, &sections).0
}
