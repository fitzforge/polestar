//! Boats, zeppelins and the Deeprun Tram (port of tools/lib/travel/transports.js; see its header
//! for every rule): curated transports, their stops from TaxiPathNode loops, ends placed at dock
//! NPCs/objects, and board points and heights from the navigation grid (path.js openNav, through
//! forge-nav's reader).

use std::path::Path;

use forge_core::jsnum::{js_hypot_n, js_round};
use forge_guide::js::{num_str, str_to_num, V};
use forge_nav::grid::{cell_centre, cell_of, flag, Grid, Tile, CELL, TILE_CELLS};
use forge_nav::legs::{is_open, SNAP_OPEN, SNAP_REGION};
use rustc_hash::FxHashMap;

use super::geo::{dist2d, is_jump, round, Frame, Frames, Pt, W};
use super::taxi::{index_by_name, num, path_points, spawn_points, LiveFrames, SpawnPt};
use crate::jsv::Rows;

pub const TRANSPORT_SPEED: f64 = 30.0;
pub const LOAD_SECONDS: f64 = 10.0;
const TRAM_WAIT: f64 = 30.0;
const ANCHOR_YARDS: f64 = 120.0;
const STOP_MERGE_YARDS: f64 = 40.0;
pub const BOARD_YARDS: f64 = 30.0;
pub const END_Z_YARDS: f64 = 10.0;
const SPAWN_Z_YARDS: f64 = 15.0;

const A: i32 = 1;
const H: i32 = 2;
const BOTH: i32 = 3;

#[derive(Clone, Copy)]
enum AnchorKind {
	Npc,
	Object,
}

struct Anchor {
	kind: AnchorKind,
	name: &'static str,
	position: bool,
}

struct TEnd {
	name: &'static str,
	area: f64,
	zone: i64,
	anchor: Option<Anchor>,
	near: Option<(f64, f64)>,
	trigger: i64,
}

struct TDef {
	id: &'static str,
	kind: &'static str,
	faction: i32,
	forever: bool,
	path: i64,
	a: TEnd,
	b: TEnd,
	inside: [i64; 2],
}

const fn end(name: &'static str, area: f64, zone: i64) -> TEnd {
	TEnd { name, area, zone, anchor: None, near: None, trigger: 0 }
}
const fn npc(mut e: TEnd, name: &'static str) -> TEnd {
	e.anchor = Some(Anchor { kind: AnchorKind::Npc, name, position: true });
	e
}
const fn object(mut e: TEnd, name: &'static str) -> TEnd {
	e.anchor = Some(Anchor { kind: AnchorKind::Object, name, position: false });
	e
}
const fn boat(id: &'static str, kind: &'static str, faction: i32, forever: bool, path: i64, a: TEnd, b: TEnd) -> TDef {
	TDef { id, kind, faction, forever, path, a, b, inside: [0, 0] }
}

const TRANSPORTS: [TDef; 13] = [
	boat("boat-bootybay-ratchet", "boat", BOTH, false, 241, npc(end("Booty Bay", 35.0, 1434), "Wharfmaster Lozgil"), npc(end("Ratchet", 392.0, 1413), "Wharfmaster Dizzywig")),
	boat("boat-menethil-theramore", "boat", A, false, 292, object(end("Menethil Harbor", 150.0, 1437), "Boat to Theramore"), end("Theramore", 513.0, 1445)),
	boat("boat-menethil-southshore", "boat", A, true, 11167, end("Menethil Harbor", 150.0, 1437), end("Southshore", 271.0, 1424)),
	boat("boat-southshore-auberdine", "boat", A, true, 11167, end("Southshore", 271.0, 1424), object(end("Auberdine", 442.0, 1439), "Boat to Menethil")),
	boat("boat-menethil-auberdine", "boat", A, true, 11167, end("Menethil Harbor", 150.0, 1437), object(end("Auberdine", 442.0, 1439), "Boat to Menethil")),
	boat("boat-stormwind-auberdine", "boat", A, true, 11616, end("Stormwind Harbor", 17203.0, 1453), end("Auberdine", 442.0, 1439)),
	boat(
		"boat-tanaris-powderfuse",
		"boat",
		BOTH,
		true,
		11391,
		npc(end("Steamwheedle Port", 977.0, 1446), "Wharfmaster Steamfizzle"),
		npc(end("Powderfuse Port", 16727.0, 2548), "Wharfmaster Whizzbuzz"),
	),
	boat("boat-auberdine-ruttheran", "boat", A, false, 293, object(end("Auberdine", 442.0, 1439), "Boat to Teldrassil"), end("Rut'theran Village", 702.0, 1438)),
	boat(
		"boat-feathermoon",
		"boat",
		A,
		false,
		303,
		TEnd { near: Some((31.0, 39.5)), ..end("Feathermoon Stronghold", 1116.0, 1444) },
		TEnd { near: Some((43.0, 43.0)), ..end("The Forgotten Coast", 1108.0, 1444) },
	),
	boat("zeppelin-orgrimmar-undercity", "zeppelin", H, false, 302, npc(end("Orgrimmar", 1637.0, 1411), "Frezza"), npc(end("Undercity", 1497.0, 1420), "Zapetta")),
	boat("zeppelin-orgrimmar-gromgol", "zeppelin", H, false, 285, npc(end("Orgrimmar", 1637.0, 1411), "Snurk Bucksquick"), npc(end("Grom'gol", 117.0, 1434), "Nez'raz")),
	boat("zeppelin-undercity-gromgol", "zeppelin", H, false, 301, npc(end("Undercity", 1497.0, 1420), "Hin Denburg"), npc(end("Grom'gol", 117.0, 1434), "Squibby Overspeck")),
	TDef {
		id: "tram-stormwind-ironforge",
		kind: "tram",
		faction: A,
		forever: false,
		path: 0,
		a: TEnd { trigger: 2173, ..end("Stormwind", 1519.0, 1453) },
		b: TEnd { trigger: 2175, ..end("Ironforge", 1537.0, 1455) },
		inside: [2166, 2171],
	},
];

/// A placed end: a transport's (with source), a portal's or a teleport's destination.
#[derive(Clone, Debug)]
pub struct End {
	pub name: String,
	pub area: Option<f64>,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub f: &'static str,
	pub source: Option<String>,
	pub board: Option<(f64, f64, f64)>,
	pub z: Option<f64>,
}

#[derive(Clone, Debug)]
pub struct Transport {
	pub id: String,
	pub kind: String,
	pub faction: i32,
	pub a: End,
	pub b: End,
	pub ab: f64,
	pub ba: f64,
	pub wait_a: f64,
	pub wait_b: f64,
	pub source: String,
	/// path, client, the ends' TaxiPathNode stops (boats and zeppelins).
	pub path: Option<(i64, &'static str, W, W)>,
}

/// The navigation grid: path.js openNav's tile, regionSize and isOpen.
pub struct Nav {
	grid: Grid,
}

impl Nav {
	/// None: no grid there (nav.available false).
	pub fn open(dir: &Path) -> Option<Nav> {
		let grid = Grid::open(dir, 256).ok()?;
		let available = grid.index.get("continents").and_then(|c| c.as_object()).is_some_and(|o| !o.is_empty());
		available.then_some(Nav { grid })
	}

	fn tile(&self, c: f64, col: i64, row: i64) -> Option<std::sync::Arc<Tile>> {
		if c.fract() != 0.0 || c < 0.0 {
			return None;
		}
		self.grid.tile(c as u32, col, row)
	}

	fn region_size(&self, c: f64, col: i64, row: i64, e: usize) -> Option<u32> {
		self.grid.region_size(c as u32, col as u32, row as u32, e as u32)
	}

	fn is_open(&self, t: &Tile, k: usize, e: usize) -> bool {
		if let Some(&v) = t.open.lock().get(&(e as u32)) {
			return v;
		}
		let v = is_open(t, k, e, SNAP_OPEN);
		t.open.lock().insert(e as u32, v);
		v
	}

	/// Whether entry e of column k is a snap candidate (big enough region, open both ways).
	fn usable(&self, c: f64, col: i64, row: i64, t: &Tile, k: usize, e: usize) -> Option<Option<u32>> {
		let size = self.region_size(c, col, row, e);
		if size.is_some_and(|s| s < SNAP_REGION) || !self.is_open(t, k, e) {
			return None;
		}
		Some(size)
	}
}

/// The dry surfaces of one grid column.
fn dry_surfaces(t: &Tile, k: usize) -> Vec<usize> {
	let (lo, hi) = (t.first[k] as usize, t.first[k + 1] as usize);
	let mut water = f64::NEG_INFINITY;
	for e in lo..hi {
		if t.flags[e] & flag::SWIM != 0 && t.z[e] as f64 > water {
			water = t.z[e] as f64;
		}
	}
	(lo..hi).filter(|&e| t.flags[e] & (flag::SWIM | flag::BLOCKED) == 0 && t.z[e] as f64 > water).collect()
}

pub fn on_dry_ground(nav: &Nav, c: f64, wx: f64, wy: f64) -> bool {
	let (col, row, i, j) = cell_of(wx, wy);
	nav.tile(c, col, row).is_some_and(|t| !dry_surfaces(&t, (j * TILE_CELLS as i64 + i) as usize).is_empty())
}

/// Where passengers board when an end's point is not on dry ground: (wx, wy, z), or None.
fn board_point(nav: &Nav, e: &End) -> Option<(f64, f64, f64)> {
	if on_dry_ground(nav, e.c, e.wx, e.wy) {
		return None;
	}
	let (c, wx, wy) = (e.c, e.wx, e.wy);
	let (acol, arow, ai, aj) = cell_of(wx, wy);
	let r = (BOARD_YARDS / CELL).ceil() as i64;
	let tc = TILE_CELLS as i64;
	// (d, s, z, wx, wy)
	let mut best: Option<(f64, f64, f64, f64, f64)> = None;
	for dj in -r..=r {
		for di in -r..=r {
			let gi = acol * tc + ai + di;
			let gj = arow * tc + aj + dj;
			let col = gi.div_euclid(tc);
			let row = gj.div_euclid(tc);
			let i = gi - col * tc;
			let j = gj - row * tc;
			let (cx, cy) = cell_centre(col, row, i, j);
			let d = dist2d((cx, cy), (wx, wy));
			if d > BOARD_YARDS {
				continue;
			}
			let Some(t) = nav.tile(c, col, row) else { continue };
			let k = (j * tc + i) as usize;
			for s_e in dry_surfaces(&t, k) {
				let Some(size) = nav.usable(c, col, row, &t, k, s_e) else { continue };
				let s = size.map(|v| v as f64).unwrap_or(0.0);
				let z = t.z[s_e] as f64;
				let better = match best {
					None => true,
					Some((bd, bs, bz, _, _)) => d < bd || (d == bd && (s > bs || (s == bs && z < bz))),
				};
				if better {
					best = Some((d, s, z, cx, cy));
				}
			}
		}
	}
	best.map(|(_, _, z, x, y)| (round(x, 1), round(y, 1), round(z, 1)))
}

/// The height of an end on dry ground: the dry surface of its column nearest `z` within
/// END_Z_YARDS (boardPoint's rules), one decimal.
pub fn end_height(nav: &Nav, c: f64, wx: f64, wy: f64, z: Option<f64>) -> Option<f64> {
	let z = z.filter(|z| z.is_finite())?;
	let (col, row, i, j) = cell_of(wx, wy);
	let t = nav.tile(c, col, row)?;
	let k = (j * TILE_CELLS as i64 + i) as usize;
	let mut best: Option<(f64, f64)> = None;
	for e in dry_surfaces(&t, k) {
		if nav.usable(c, col, row, &t, k, e).is_none() {
			continue;
		}
		let d = (t.z[e] as f64 - z).abs();
		if d <= END_Z_YARDS && best.is_none_or(|b| d < b.0) {
			best = Some((d, t.z[e] as f64));
		}
	}
	best.map(|b| round(b.1, 1))
}

/// A loop's docked stop: its points' indices and delay.
struct Stop {
	c: f64,
	wx: f64,
	wy: f64,
	idx: Vec<usize>,
	delay: f64,
}

fn stops_of(points: &[Pt]) -> Vec<Stop> {
	let mut stops: Vec<Stop> = Vec::new();
	for (k, p) in points.iter().enumerate() {
		if crate::jsv::to_int32(p.flags) & 2 == 0 || p.delay == 0.0 || p.delay.is_nan() {
			continue;
		}
		if let Some(same) = stops.iter_mut().find(|s| s.c == p.c && dist2d((s.wx, s.wy), (p.wx, p.wy)) <= STOP_MERGE_YARDS) {
			same.idx.push(k);
			same.delay = same.delay.max(p.delay);
		} else {
			stops.push(Stop { c: p.c, wx: p.wx, wy: p.wy, idx: vec![k], delay: p.delay });
		}
	}
	stops
}

struct Sail {
	yards: f64,
	teleports: usize,
	docked: f64,
}

fn sail_between(points: &[Pt], stops: &[Stop], from: usize, to: usize) -> Sail {
	let mut stop_at: FxHashMap<usize, usize> = FxHashMap::default();
	for (si, s) in stops.iter().enumerate() {
		for &k in &s.idx {
			stop_at.insert(k, si);
		}
	}
	let mut best: Option<Sail> = None;
	for &i in &stops[from].idx {
		for &j in &stops[to].idx {
			let leg = sail(points, stops, i, j, &stop_at, [from, to]);
			let better = match &best {
				None => true,
				Some(b) => leg.teleports < b.teleports || (leg.teleports == b.teleports && leg.yards < b.yards),
			};
			if better {
				best = Some(leg);
			}
		}
	}
	best.unwrap()
}

fn sail(points: &[Pt], stops: &[Stop], i: usize, j: usize, stop_at: &FxHashMap<usize, usize>, ends: [usize; 2]) -> Sail {
	let mut yards = 0.0;
	let mut teleports = 0;
	let mut calls: Vec<usize> = Vec::new();
	let n = points.len();
	let mut k = i;
	while k != j {
		if k != i {
			if let Some(&s) = stop_at.get(&k) {
				if !ends.contains(&s) && !calls.contains(&s) {
					calls.push(s);
				}
			}
		}
		let a = &points[k];
		let b = &points[(k + 1) % n];
		if is_jump(a, b) {
			teleports += 1;
		} else {
			yards += js_hypot_n(&[b.wx - a.wx, b.wy - a.wy, b.z - a.z]);
		}
		k = (k + 1) % n;
	}
	let mut docked = 0.0;
	for s in calls {
		docked += stops[s].delay;
	}
	Sail { yards, teleports, docked }
}

fn same_frame(a: &Frame, b: &Frame) -> bool {
	a.c == b.c && (a.left - b.left).abs() < 0.01 && (a.right - b.right).abs() < 0.01 && (a.top - b.top).abs() < 0.01 && (a.bottom - b.bottom).abs() < 0.01
}

fn zone_frame(frames: &Frames, live: &LiveFrames, zone: i64) -> Option<(Frame, &'static str)> {
	let era = frames.frame(zone);
	if let Some(l) = live.get(&zone) {
		if era.is_none_or(|e| !same_frame(&e, l)) {
			return Some((*l, "l"));
		}
	}
	era.map(|e| (e, "e"))
}

/// (x, y, f) of a world point on a zone's map (its live frame where Forever redrew it), or None.
pub fn in_zone(frames: &Frames, live: &LiveFrames, zone: i64, c: f64, wx: f64, wy: f64) -> Option<(f64, f64, &'static str)> {
	let (b, f) = zone_frame(frames, live, zone)?;
	if b.c != c {
		return None;
	}
	let x = ((wy - b.left) / (b.right - b.left)) * 100.0;
	let y = ((wx - b.top) / (b.bottom - b.top)) * 100.0;
	((0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)).then_some((x, y, f))
}

struct AnchorInfo {
	label: String,
	pts: Vec<(SpawnPt, f64)>,
	kind: &'static str,
}

fn find_anchor(anchor: &Anchor, npcs: &FxHashMap<String, Vec<V>>, objects: &FxHashMap<String, Vec<V>>, frames: &Frames, live: &LiveFrames, zone: i64) -> Result<AnchorInfo, String> {
	let (list, label, kind) = match anchor.kind {
		AnchorKind::Npc => (npcs.get(anchor.name), format!("npc \"{}\"", anchor.name), "npc"),
		AnchorKind::Object => (objects.get(anchor.name), format!("object \"{}\"", anchor.name), "object"),
	};
	let Some(list) = list.filter(|l| !l.is_empty()) else { return Err(format!("{label} not found")) };
	let mut pts = Vec::new();
	for e in list {
		for p in spawn_points(e, frames, live) {
			if p.map == zone {
				pts.push((p, e.get("id").num()));
			}
		}
	}
	if pts.is_empty() {
		return Err(format!("{label} does not spawn on map {zone}"));
	}
	Ok(AnchorInfo { label, pts, kind })
}
fn endpoint(end: &TEnd, frames: &Frames, live: &LiveFrames, stop: Option<W>, anchor: Option<&Result<AnchorInfo, String>>, warnings: &mut Vec<String>, id: &str) -> Option<End> {
	let zone_name = frames.name(end.zone).unwrap_or_else(|| end.zone.to_string());
	let mut source: Option<String> = None;
	let mut pos: Option<W> = None;
	match anchor {
		Some(Ok(info)) => {
			let mut best = &info.pts[0];
			if let Some(s) = stop {
				for p in &info.pts {
					if dist2d((p.0.wx, p.0.wy), (s.wx, s.wy)) < dist2d((best.0.wx, best.0.wy), (s.wx, s.wy)) {
						best = p;
					}
				}
			}
			let d = stop.map(|s| dist2d((best.0.wx, best.0.wy), (s.wx, s.wy))).unwrap_or(0.0);
			if stop.is_some() && d > ANCHOR_YARDS {
				warnings.push(format!("{id}: {} is {} yd from the {} stop; stop used", info.label, num_str(js_round(d)), end.name));
			} else if end.anchor.as_ref().is_some_and(|a| a.position) {
				pos = Some(W { c: best.0.c, wx: best.0.wx, wy: best.0.wy });
				let bare = info.label.split_once(' ').map(|x| x.1).unwrap_or(&info.label);
				let at = if stop.is_some() { format!(", {} yd from the TaxiPathNode stop", num_str(js_round(d))) } else { String::new() };
				source = Some(format!("{} {} ({bare}){at}", info.kind, num_str(best.1)));
			} else {
				source = Some(format!("TaxiPathNode stop, checked against {} ({} yd)", info.label, num_str(js_round(d))));
			}
		}
		Some(Err(e)) => warnings.push(format!("{id}: {e}")),
		None => {}
	}
	let pos = match pos {
		Some(p) => p,
		None => {
			let s = stop?;
			source.get_or_insert_with(|| "TaxiPathNode stop".to_string());
			s
		}
	};
	let Some((x, y, f)) = in_zone(frames, live, end.zone, pos.c, pos.wx, pos.wy) else {
		warnings.push(format!("{id}: {} dock is not on {zone_name}", end.name));
		return None;
	};
	Some(End { name: end.name.to_string(), area: Some(end.area), c: pos.c, wx: round(pos.wx, 1), wy: round(pos.wy, 1), map: end.zone, x: round(x, 2), y: round(y, 2), f, source, board: None, z: None })
}

fn pick_stop(stops: &[Stop], end: &TEnd, frames: &Frames, live: &LiveFrames, anchor: Option<&Result<AnchorInfo, String>>) -> Option<usize> {
	let cands: Vec<usize> = (0..stops.len()).filter(|&i| in_zone(frames, live, end.zone, stops[i].c, stops[i].wx, stops[i].wy).is_some()).collect();
	if cands.is_empty() {
		return None;
	}
	let r: Option<(f64, f64)> = if let Some((x, y)) = end.near {
		frames.to_world(end.zone, x, y).map(|w| (w.wx, w.wy))
	} else if let Some(Ok(info)) = anchor {
		Some((info.pts[0].0.wx, info.pts[0].0.wy))
	} else {
		None
	};
	let Some(r) = r else { return if cands.len() == 1 { Some(cands[0]) } else { None } };
	let d = |i: usize| dist2d((stops[i].wx, stops[i].wy), r);
	let mut best = cands[0];
	for &s in &cands[1..] {
		if d(s) < d(best) {
			best = s;
		}
	}
	Some(best)
}

/// The height of the NPC an end is placed at (spawnz.json), within SPAWN_Z_YARDS.
fn anchor_height(spawnz: &V, end: &End, anchor: Option<&Anchor>, info: Option<&Result<AnchorInfo, String>>) -> Option<f64> {
	if !spawnz.truthy() || !anchor.is_some_and(|a| a.position) {
		return None;
	}
	let Some(Ok(info)) = info else { return None };
	let mut ids: Vec<f64> = Vec::new();
	for p in &info.pts {
		if !ids.contains(&p.1) {
			ids.push(p.1);
		}
	}
	let mut best: Option<(f64, f64)> = None;
	let table = spawnz.get(info.kind);
	for id in ids {
		for s in table.get(&num_str(id)).items() {
			let (c, wx, wy, z) = (s.at(0).num(), s.at(1).num(), s.at(2).num(), s.at(3).num());
			let d = if c == end.c { dist2d((wx, wy), (end.wx, end.wy)) } else { f64::INFINITY };
			if d <= SPAWN_Z_YARDS && best.is_none_or(|b| d < b.0) {
				best = Some((d, z));
			}
		}
	}
	best.map(|b| b.1)
}

pub struct Built {
	pub transports: Vec<Transport>,
	pub warnings: Vec<String>,
}
pub fn build_transports(
	taxi_path_nodes: &Rows,
	area_triggers: &Rows,
	forever: Option<(&Rows, &str)>,
	forever_error: &str,
	frames: &Frames,
	npcs: &V,
	objects: &V,
	live: &LiveFrames,
	nav: Option<&Nav>,
	spawnz: &V,
) -> Built {
	let mut warnings = Vec::new();
	let npc_idx = index_by_name(npcs);
	let obj_idx = index_by_name(objects);
	let era_pts = path_points(taxi_path_nodes);
	let forever_pts = forever.map(|(rows, _)| path_points(rows));
	let forever_build = forever.map(|f| f.1).unwrap_or("null");
	let mut triggers: FxHashMap<i64, (f64, f64, f64, f64)> = FxHashMap::default();
	for r in area_triggers {
		let id = num(r, "ID").map(|n| n as i64).unwrap_or(i64::MIN);
		let g = |c: &str| num(r, c).unwrap_or(f64::NAN);
		triggers.insert(id, (g("ContinentID"), g("Pos_0"), g("Pos_1"), num(r, "Pos_2").filter(|&z| z != 0.0).unwrap_or(0.0)));
	}
	let mut out = Vec::new();
	for t in &TRANSPORTS {
		let (mut a, mut b);
		let (ab, ba, wait_a, wait_b, source);
		let mut ends: Option<(W, W)> = None;
		let heights: [Option<f64>; 2];
		if t.kind == "tram" {
			let get = |id: i64| triggers.get(&id).copied();
			let (Some(ta), Some(tb), Some(ia), Some(ib)) = (get(t.a.trigger), get(t.b.trigger), get(t.inside[0]), get(t.inside[1])) else {
				warnings.push(format!("{}: AreaTrigger {}/{}/{}/{} missing, skipped", t.id, t.a.trigger, t.b.trigger, t.inside[0], t.inside[1]));
				continue;
			};
			let w = |x: (f64, f64, f64, f64)| W { c: x.0, wx: x.1, wy: x.2 };
			a = endpoint(&t.a, frames, live, Some(w(ta)), None, &mut warnings, t.id);
			b = endpoint(&t.b, frames, live, Some(w(tb)), None, &mut warnings, t.id);
			if let Some(a) = a.as_mut() {
				a.source = Some(format!("AreaTrigger {}", t.a.trigger));
			}
			if let Some(b) = b.as_mut() {
				b.source = Some(format!("AreaTrigger {}", t.b.trigger));
			}
			heights = [Some(ta.3), Some(tb.3)];
			let inside = dist2d((ib.1, ib.2), (ia.1, ia.2));
			ab = inside / TRANSPORT_SPEED + 2.0 * LOAD_SECONDS;
			ba = ab;
			wait_a = TRAM_WAIT;
			wait_b = TRAM_WAIT;
			source = format!("AreaTrigger {}-{} ({} yd inside the tram), speed {} yd/s, {} s wait (estimates)", t.inside[0], t.inside[1], num_str(js_round(inside)), TRANSPORT_SPEED, TRAM_WAIT);
		} else {
			let points = if t.forever { forever_pts.as_ref() } else { Some(&era_pts) };
			let Some(points) = points else {
				warnings.push(format!("{}: no WoW Forever client tables ({forever_error}), skipped", t.id));
				continue;
			};
			let path_label = if t.forever { format!("TaxiPath {} (WoW Forever client {forever_build})", t.path) } else { format!("TaxiPath {}", t.path) };
			let pts = match points.get(&t.path) {
				Some(p) if p.len() >= 2 => p,
				_ => {
					warnings.push(format!("{}: {path_label} has no points, skipped", t.id));
					continue;
				}
			};
			let stops = stops_of(pts);
			let anchor_a = t.a.anchor.as_ref().map(|an| find_anchor(an, &npc_idx, &obj_idx, frames, live, t.a.zone));
			let anchor_b = t.b.anchor.as_ref().map(|an| find_anchor(an, &npc_idx, &obj_idx, frames, live, t.b.zone));
			let sa = pick_stop(&stops, &t.a, frames, live, anchor_a.as_ref());
			let sb = pick_stop(&stops, &t.b, frames, live, anchor_b.as_ref());
			let (Some(sa), Some(sb)) = (sa, sb) else {
				warnings.push(format!("{}: {path_label} has no distinct stops in {} and {}, skipped", t.id, t.a.name, t.b.name));
				continue;
			};
			if sa == sb {
				warnings.push(format!("{}: {path_label} has no distinct stops in {} and {}, skipped", t.id, t.a.name, t.b.name));
				continue;
			}
			let ws = |s: &Stop| W { c: s.c, wx: s.wx, wy: s.wy };
			a = endpoint(&t.a, frames, live, Some(ws(&stops[sa])), anchor_a.as_ref(), &mut warnings, t.id);
			ends = Some((ws(&stops[sa]), ws(&stops[sb])));
			b = endpoint(&t.b, frames, live, Some(ws(&stops[sb])), anchor_b.as_ref(), &mut warnings, t.id);
			heights =
				[a.as_ref().and_then(|a| anchor_height(spawnz, a, t.a.anchor.as_ref(), anchor_a.as_ref())), b.as_ref().and_then(|b| anchor_height(spawnz, b, t.b.anchor.as_ref(), anchor_b.as_ref()))];
			let fwd = sail_between(pts, &stops, sa, sb);
			let back = sail_between(pts, &stops, sb, sa);
			let docked = stops.iter().fold(0.0, |s, st| s + st.delay);
			let sailing = |l: &Sail| l.yards / TRANSPORT_SPEED + l.teleports as f64 * LOAD_SECONDS;
			let cycle = sailing(&fwd) + sailing(&back) + docked;
			ab = sailing(&fwd) + fwd.docked;
			ba = sailing(&back) + back.docked;
			wait_a = cycle / 2.0;
			wait_b = wait_a;
			let calls = if fwd.docked != 0.0 || back.docked != 0.0 { format!(", {} s / {} s docked at stops on the way", num_str(fwd.docked), num_str(back.docked)) } else { String::new() };
			source = format!(
				"{path_label}: {} yd / {} yd between stops{calls}, {} s docked per loop, speed {} yd/s (estimate)",
				num_str(js_round(fwd.yards)),
				num_str(js_round(back.yards)),
				num_str(docked),
				TRANSPORT_SPEED
			);
		}
		let (Some(mut a), Some(mut b)) = (a, b) else {
			warnings.push(format!("{}: an end could not be placed, skipped", t.id));
			continue;
		};
		if let Some(nav) = nav {
			for (i, e) in [&mut a, &mut b].into_iter().enumerate() {
				if let Some(board) = board_point(nav, e) {
					e.board = Some(board);
				} else if !on_dry_ground(nav, e.c, e.wx, e.wy) {
					warnings.push(format!("{}: the {} end is not on dry ground and has no dry ground within {} yd", t.id, e.name, BOARD_YARDS));
				} else if let Some(h) = heights[i] {
					match end_height(nav, e.c, e.wx, e.wy, Some(h)) {
						Some(z) => e.z = Some(z),
						None => warnings.push(format!("{}: the {} end has no walkable surface within {} yd of its height {}", t.id, e.name, END_Z_YARDS, num_str(round(h, 1)))),
					}
				}
			}
		}
		out.push(Transport {
			id: t.id.to_string(),
			kind: t.kind.to_string(),
			faction: t.faction,
			a,
			b,
			ab: js_round(ab),
			ba: js_round(ba),
			wait_a: js_round(wait_a),
			wait_b: js_round(wait_b),
			source,
			path: ends.map(|(ea, eb)| (t.path, if t.forever { "forever" } else { "era" }, ea, eb)),
		});
	}
	Built { transports: out, warnings }
}

/// `Number(v)` of a cell (CSV text) as JS reads it.
pub fn number(s: Option<&String>) -> f64 {
	s.map(|s| str_to_num(s)).unwrap_or(f64::NAN)
}
