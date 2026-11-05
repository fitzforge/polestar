//! Chokepoints of each continent for the journey's named walk steps (port of
//! tools/lib/nav/chokepoints.js): lift landings, gates, bridges, tunnels, cave and building mouths
//! and passes, found on the grid and the arrow's aids; no place is named by hand.
//!
//! Rules (decided 2026-10-15):
//! - lift: both landings of every lift of the grid (lifts.json), one entry per landing (landings
//!   within LIFT_SAME yd and STEP in height are one); liftEnd top or bottom, `pair` the other end.
//! - cave, building, pass: the mouth of each approach chain of the aids; a cave's or building's
//!   mouth is where the chain's line first reaches an indoor surface, centred on the indoor
//!   boundary around it (indoor_mouth). A chain whose line is indoors from its first step (it starts
//!   inside: no doorway on its way) or drops onto indoor ground down a shaft (the Undercity's lifts)
//!   gives no entry: its "mouth" would be a spot inside the city, captioned "Walk to the ... cave
//!   mouth" (2026-10-23).
//! - bridge, tunnel, pass: each zone crossing of the aids at the middle of its two ends.
//! - bridge (from the grid): a deck of model surfaces over water or air, narrow, long, with two
//!   separate ends; gate (from the grid): outdoor ground under a low WMO span with two ends.
//! - A grid bridge or gate within MERGE yd of an aids entry of its kind is that entry; an aids pass
//!   there becomes it. A grid gate elsewhere is left out.

use super::layers::{AreaName, AreaTable, Frames};
use crate::grid::{cell_centre, cell_of, flag, Grid, CELL, DIRS, NO_LINK, STEP, TILE_CELLS};
use crate::legs::{Nav, SnapAsk};
use forge_core::jsnum::{js_hypot, js_round, js_to_string};
use rustc_hash::FxHashMap;
use serde_json::Value;

const LIFT_SAME: f64 = 8.0;
pub const MERGE: f64 = 25.0;
const BRIDGE_DROP: f64 = 8.0;
const DECK_THICK: f64 = 2.0;
const DECK_MIN: usize = 20;
const DECK_WIDTH: f64 = 15.0;
const SPAN_MIN: f64 = 12.0;
const WET_SHARE: f64 = 0.25;
const ENDS_APART: f64 = 0.6;
const COVER: f64 = 12.0;
const GATE_MIN: usize = 6;
const GATE_WIDTH: f64 = 14.0;
pub const R_MIN: f64 = 6.0;
pub const R_MAX: f64 = 30.0;
const MOUTH_STEP: f64 = 2.0;
const MOUTH_R: f64 = 10.0;
const MOUTH_SPAN: f64 = 4.0;
const MOUTH_REACH: f64 = 20.0;
/// A line reaching indoor ground this far below the ground it stood on went down a shaft, not through a door.
const SHAFT: f64 = 12.0;

/// Where an approach chain's line first stands on an indoor surface (indoor_mouth).
enum Mouth {
	/// It never does.
	None,
	/// The doorway there: (wx, wy, z, r).
	Door((f64, f64, f64, f64)),
	/// Indoors from its first step, or down a shaft: it passes no doorway.
	NoDoorway,
}

fn round1(v: f64) -> f64 {
	js_round(v * 10.0) / 10.0
}

/// A side of a bridge, tunnel or pass.
#[derive(Clone, Debug, PartialEq)]
pub struct Side {
	pub wx: f64,
	pub wy: f64,
	pub area: String,
	pub zone_area: Option<u32>,
}

/// One chokepoint, in UnitPosition's frame (wx north, wy west), yards.
#[derive(Clone, Debug, PartialEq)]
pub struct Choke {
	pub wx: f64,
	pub wy: f64,
	pub z: Option<f64>,
	pub r: f64,
	pub kind: String,
	pub name: String,
	pub area: Option<u32>,
	pub zone: String,
	pub zone_area: Option<u32>,
	pub lift: Option<String>,
	/// The lift's GameObject entry, as a Lua literal (lifts.json's id: a number, or a string).
	pub lift_object: Option<String>,
	pub lift_end: Option<&'static str>,
	pub pair: Option<usize>,
	pub sides: Option<Vec<Side>>,
}

fn place_names(p: Option<AreaName>) -> (String, Option<u32>, String, Option<u32>) {
	match p {
		Some(a) => (a.name, Some(a.area), a.zone, Some(a.zone_area)),
		None => (String::new(), None, String::new(), None),
	}
}

struct Ctx<'a> {
	nav: &'a Nav,
	c: u32,
	areas: &'a AreaTable,
}

impl Ctx<'_> {
	fn place(&self, wx: f64, wy: f64) -> Option<AreaName> {
		let (col, row, i, j) = cell_of(wx, wy);
		let t = self.nav.grid.tile(self.c, col, row)?;
		self.areas.names(t.areas[((j >> 4) * 16 + (i >> 4)) as usize] as u32)
	}

	fn snap(&self, wx: f64, wy: f64, z: Option<f64>, radius: f64) -> Option<crate::legs::Snapped> {
		self.nav.snap(&SnapAsk { c: self.c, wx, wy, z, radius, under: false, stand: false })
	}

	fn z_of(&self, wx: f64, wy: f64) -> Option<f64> {
		self.snap(wx, wy, None, 15.0).map(|s| round1(s.z))
	}

	fn entry(&self, wx: f64, wy: f64, z: Option<f64>, r: f64, kind: &str, at: (f64, f64)) -> Choke {
		let (name, area, zone, zone_area) = place_names(self.place(at.0, at.1));
		Choke { wx, wy, z, r, kind: kind.into(), name, area, zone, zone_area, lift: None, lift_object: None, lift_end: None, pair: None, sides: None }
	}

	/// The surface nearest `z` (any when None) within `radius` yd of a point -> (its height, its flags).
	fn surface(&self, wx: f64, wy: f64, z: Option<f64>, radius: f64) -> Option<(f64, u8)> {
		self.snap(wx, wy, z, radius).map(|s| (s.z, s.flags))
	}
}

/// Where the polyline first stands on an indoor surface -> the mouth there (`snap` as
/// Ctx::surface); its height follows the surface it is on. A line indoors from its first step (it
/// starts inside: the Undercity, Orgrimmar) or reaching indoor ground more than SHAFT yd below the
/// ground it stood on (down the Undercity's lift shafts) passes no doorway.
fn indoor_mouth(snap: &dyn Fn(f64, f64, Option<f64>, f64) -> Option<(f64, u8)>, pts: &[(f64, f64)]) -> Mouth {
	let mut z: Option<f64> = None;
	for i in 1..pts.len() {
		let (a, b) = (pts[i - 1], pts[i]);
		let n = ((js_hypot(b.0 - a.0, b.1 - a.1) / MOUTH_STEP).ceil() as i64).max(1);
		for s in if i == 1 { 0 } else { 1 }..=n {
			let wx = a.0 + ((b.0 - a.0) * s as f64) / n as f64;
			let wy = a.1 + ((b.1 - a.1) * s as f64) / n as f64;
			let Some((at_z, at_flags)) = snap(wx, wy, z, 3.0) else { continue };
			if at_flags & flag::INDOOR != 0 {
				return match z {
					Some(z) if z - at_z <= SHAFT => Mouth::Door(mouth_around(snap, wx, wy, at_z)),
					_ => Mouth::NoDoorway,
				};
			}
			z = Some(at_z);
		}
	}
	Mouth::None
}

/// The doorway around an indoor point at height z (the point itself when no outdoor ground at its
/// height is near): within MOUTH_REACH yd, every MOUTH_STEP yd, indoor surfaces within MOUTH_SPAN of
/// that height with outdoor ground at the same height a step away; centred on them, its radius
/// reaching the furthest (at least MOUTH_R). -> (wx, wy, z, r)
fn mouth_around(snap: &dyn Fn(f64, f64, Option<f64>, f64) -> Option<(f64, u8)>, wx: f64, wy: f64, z: f64) -> (f64, f64, f64, f64) {
	let kind = |x: f64, y: f64| -> u8 {
		match snap(x, y, Some(z), 1.0) {
			Some((qz, qflags)) if (qz - z).abs() <= MOUTH_SPAN => {
				if qflags & flag::INDOOR != 0 {
					2
				} else {
					1
				}
			}
			_ => 0,
		}
	};
	let mut edge = Vec::new();
	let r = (MOUTH_REACH / MOUTH_STEP).floor() as i64;
	for i in -r..=r {
		for j in -r..=r {
			if i * i + j * j > r * r {
				continue;
			}
			let x = wx + i as f64 * MOUTH_STEP;
			let y = wy + j as f64 * MOUTH_STEP;
			if kind(x, y) != 2 {
				continue;
			}
			if [(1.0, 0.0), (-1.0, 0.0), (0.0, 1.0), (0.0, -1.0)].iter().any(|&(di, dj)| kind(x + di * MOUTH_STEP, y + dj * MOUTH_STEP) == 1) {
				edge.push((x, y));
			}
		}
	}
	if edge.is_empty() {
		return (wx, wy, round1(z), MOUTH_R);
	}
	let mx = edge.iter().fold(0.0, |s, p| s + p.0) / edge.len() as f64;
	let my = edge.iter().fold(0.0, |s, p| s + p.1) / edge.len() as f64;
	let far = edge.iter().map(|&(x, y)| js_hypot(x - mx, y - my)).fold(f64::NEG_INFINITY, f64::max);
	(mx, my, round1(z), R_MAX.min(MOUTH_R.max((far + MOUTH_STEP).ceil())))
}

fn caption_kind(caption: &str) -> Option<&'static str> {
	match caption {
		"Enter the cave" => Some("cave"),
		"Go inside" => Some("building"),
		"Follow the path up" | "Follow the path" => Some("pass"),
		_ => None,
	}
}

#[derive(Clone, Copy)]
struct Col {
	col: i64,
	row: i64,
	k: usize,
	e: usize,
	z: f32,
	wx: f64,
	wy: f64,
	wet: bool,
}

/// Grid scan of one continent: deck (bridge) and covered (gate) columns -> components -> entries.
fn grid_chokepoints(cx: &Ctx, grid: &Grid) -> Vec<Choke> {
	let c = cx.c;
	let tiles: Vec<(i64, i64)> = grid.index["continents"][c.to_string()]["tiles"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|k| {
			let (a, b) = k.as_str()?.split_once('_')?;
			Some((a.parse().ok()?, b.parse().ok()?))
		})
		.collect();
	// Key `${col}_${row}:${k}` (the JS sorts these strings).
	let key = |col: i64, row: i64, k: usize| format!("{col}_{row}:{k}");
	let mut deck: FxHashMap<String, Col> = FxHashMap::default();
	let mut cover: FxHashMap<String, Col> = FxHashMap::default();
	for &(col, row) in &tiles {
		let Some(t) = grid.tile(c, col, row) else { continue };
		let (first, z, ceil, flags) = (&t.first, &t.z, &t.ceil, &t.flags);
		for k in 0..TILE_CELLS * TILE_CELLS {
			let (mut have_deck, mut have_cover) = (false, false);
			let (lo, hi) = (first[k] as i64, first[k + 1] as i64);
			let mut e = hi - 1;
			while e >= lo {
				let eu = e as usize;
				let f = flags[eu];
				if f & (flag::BLOCKED | flag::SWIM | flag::INDOOR) != 0 {
					e -= 1;
					continue;
				}
				let model = f & (flag::WMO | flag::M2);
				if model != 0 && !have_deck {
					let mut below = e - 1;
					while below >= lo
						&& flags[below as usize] & flag::BLOCKED != 0
						&& flags[below as usize] & (flag::SWIM | flag::TERRAIN) == 0
						&& z[eu] as f64 - z[below as usize] as f64 <= DECK_THICK
					{
						below -= 1;
					}
					if below >= lo && (flags[below as usize] & flag::SWIM != 0 || z[eu] as f64 - z[below as usize] as f64 >= BRIDGE_DROP) {
						let p = cell_centre(col, row, (k & 255) as i64, (k >> 8) as i64);
						deck.insert(key(col, row, k), Col { col, row, k, e: eu, z: z[eu], wx: p.0, wy: p.1, wet: flags[below as usize] & flag::SWIM != 0 });
						have_deck = true;
					}
				}
				if model == 0 && !have_cover && e + 1 < hi && flags[eu + 1] & flag::WMO != 0 && ceil[eu] as f64 - z[eu] as f64 <= COVER {
					let p = cell_centre(col, row, (k & 255) as i64, (k >> 8) as i64);
					cover.insert(key(col, row, k), Col { col, row, k, e: eu, z: z[eu], wx: p.0, wy: p.1, wet: false });
					have_cover = true;
				}
				e -= 1;
			}
		}
	}
	let neighbour = |q: &Col, d: usize| -> (i64, i64, usize) {
		let mut i = (q.k & 255) as i64 + DIRS[d].0 as i64;
		let mut j = (q.k >> 8) as i64 + DIRS[d].1 as i64;
		let (mut col, mut row) = (q.col, q.row);
		if i < 0 {
			col -= 1;
			i += 256;
		} else if i > 255 {
			col += 1;
			i -= 256;
		}
		if j < 0 {
			row -= 1;
			j += 256;
		} else if j > 255 {
			row += 1;
			j -= 256;
		}
		(col, row, (j * 256 + i) as usize)
	};
	let mut out = Vec::new();
	for (set, kind, min, width) in [(&deck, "bridge", DECK_MIN, DECK_WIDTH), (&cover, "gate", GATE_MIN, GATE_WIDTH)] {
		let mut seen: rustc_hash::FxHashSet<String> = Default::default();
		let mut starts: Vec<(&String, &Col)> = set.iter().collect();
		starts.sort_by(|a, b| a.0.encode_utf16().cmp(b.0.encode_utf16()));
		for (start, q0) in starts {
			if seen.contains(start) {
				continue;
			}
			seen.insert(start.clone());
			let mut comp = vec![*q0];
			let mut contacts: Vec<(f64, f64)> = Vec::new();
			let mut x = 0;
			while x < comp.len() {
				let q = comp[x];
				x += 1;
				let t = grid.tile(c, q.col, q.row).unwrap();
				for d in 0..8 {
					let code = t.links[q.e * 8 + d];
					if code == NO_LINK {
						continue;
					}
					let (ncol, nrow, nk) = neighbour(&q, d);
					let kk = key(ncol, nrow, nk);
					if let Some(other) = set.get(&kk).filter(|o| (o.z as f64 - q.z as f64).abs() <= 1.6) {
						if !seen.contains(&kk) {
							seen.insert(kk);
							comp.push(*other);
						}
						continue;
					}
					let Some(t2) = grid.tile(c, ncol, nrow) else { continue };
					let e2 = t2.first[nk] as usize + (code & 31) as usize;
					if t2.flags[e2] & (flag::SWIM | flag::INDOOR | flag::BLOCKED) != 0 {
						continue;
					}
					let p = cell_centre(ncol, nrow, (nk & 255) as i64, (nk >> 8) as i64);
					contacts.push(p);
				}
			}
			if comp.len() < min {
				continue;
			}
			let far = |a: Col| comp.iter().fold(a, |b, q| if js_hypot(q.wx - a.wx, q.wy - a.wy) > js_hypot(b.wx - a.wx, b.wy - a.wy) { *q } else { b });
			let a = far(comp[0]);
			let b = far(a);
			let span = js_hypot(a.wx - b.wx, a.wy - b.wy) + CELL;
			if (comp.len() as f64 * CELL * CELL) / span > width {
				continue;
			}
			if kind == "bridge" && (span < SPAN_MIN || (comp.iter().filter(|q| q.wet).count() as f64) < WET_SHARE * comp.len() as f64) {
				continue;
			}
			let mut groups: Vec<Vec<(f64, f64)>> = Vec::new();
			for &p in &contacts {
				let hit: Vec<usize> = (0..groups.len()).filter(|&g| groups[g].iter().any(|x| js_hypot(x.0 - p.0, x.1 - p.1) <= 2.5 * CELL)).collect();
				if hit.is_empty() {
					groups.push(vec![p]);
				} else {
					let mut merged: Vec<(f64, f64)> = hit.iter().flat_map(|&g| groups[g].clone()).collect();
					merged.push(p);
					for &g in hit.iter().rev() {
						groups.remove(g);
					}
					groups.push(merged);
				}
			}
			if groups.len() != 2 {
				continue;
			}
			let centre = |gr: &[(f64, f64)]| (gr.iter().fold(0.0, |s, p| s + p.0) / gr.len() as f64, gr.iter().fold(0.0, |s, p| s + p.1) / gr.len() as f64);
			let (c1, c2) = (centre(&groups[0]), centre(&groups[1]));
			if kind == "bridge" && js_hypot(c1.0 - c2.0, c1.1 - c2.1) < ENDS_APART * span {
				continue;
			}
			let mx = comp.iter().fold(0.0, |s, q| s + q.wx) / comp.len() as f64;
			let my = comp.iter().fold(0.0, |s, q| s + q.wy) / comp.len() as f64;
			let mid = comp.iter().fold(comp[0], |b, q| if js_hypot(q.wx - mx, q.wy - my) < js_hypot(b.wx - mx, b.wy - my) { *q } else { b });
			let sides = groups
				.iter()
				.map(|gr| {
					let p = gr[gr.len() >> 1];
					Side { wx: round1(p.0), wy: round1(p.1), area: cx.place(p.0, p.1).map(|a| a.name).unwrap_or_default(), zone_area: None }
				})
				.collect();
			let mut ch = cx.entry(round1(mid.wx), round1(mid.wy), Some(round1(mid.z as f64)), js_round(R_MAX.min(R_MIN.max(span / 2.0))), kind, (mid.wx, mid.wy));
			ch.sides = Some(sides);
			out.push(ch);
		}
	}
	out
}

/// One continent's chokepoints. aids: aids.json (or Null); lifts: lifts.json's list for c.
pub fn chokepoints(nav: &Nav, c: u32, aids: &Value, lifts: &[Value], frames: &Frames, areas: &AreaTable) -> Vec<Choke> {
	let cx = Ctx { nav, c, areas };
	let mut list: Vec<Choke> = Vec::new();
	struct Landing {
		id: String,
		id_num: Value,
		lift: String,
		wx: f64,
		wy: f64,
		z: f64,
		pair: Option<usize>,
		end: &'static str,
	}
	let mut landings: Vec<Landing> = Vec::new();
	for l in lifts {
		let id = if l["id"].is_string() { lua_str(&js_value_string(&l["id"])) } else { js_value_string(&l["id"]) };
		let mut ends = [0usize; 2];
		for (n, x) in [&l["a"], &l["b"]].into_iter().enumerate() {
			let g = |k: &str| x[k].as_f64().unwrap_or(0.0);
			let (k, xz) = (g("k") as usize, g("z"));
			let p = cell_centre(g("col") as i64, g("row") as i64, (k & 255) as i64, (k >> 8) as i64);
			let i = landings.iter().position(|y| y.id_num == l["id"] && js_hypot(y.wx - p.0, y.wy - p.1) <= LIFT_SAME && (y.z - xz).abs() <= STEP);
			ends[n] = match i {
				Some(i) => i,
				None => {
					landings.push(Landing { id: id.clone(), id_num: l["id"].clone(), lift: js_value_string(&l["name"]), wx: p.0, wy: p.1, z: xz, pair: None, end: "" });
					landings.len() - 1
				}
			};
		}
		let [a, b] = ends;
		landings[a].pair.get_or_insert(b);
		landings[b].pair.get_or_insert(a);
		landings[a].end = if landings[a].z > landings[b].z { "top" } else { "bottom" };
		landings[b].end = if landings[b].z > landings[a].z { "top" } else { "bottom" };
	}
	let base = list.len();
	for l in &landings {
		let mut ch = cx.entry(round1(l.wx), round1(l.wy), Some(round1(l.z)), R_MIN, "lift", (l.wx, l.wy));
		ch.lift = Some(l.lift.clone());
		ch.lift_object = Some(l.id.clone());
		ch.lift_end = Some(l.end);
		ch.pair = l.pair.map(|p| base + p);
		list.push(ch);
	}
	let near = |list: &[Choke], wx: f64, wy: f64, kind: &str| list.iter().position(|x| x.kind == kind && js_hypot(x.wx - wx, x.wy - wy) <= MERGE);
	let world = |p: &Value| -> Option<(u32, f64, f64)> { frames.to_world(p["map"].as_f64()? as u32, p["x"].as_f64()?, p["y"].as_f64()?) };
	for ch in aids["chains"].as_array().into_iter().flatten() {
		let n0 = &ch["nodes"][0];
		let Some(kind) = caption_kind(n0["caption"].as_str().unwrap_or("")) else { continue };
		let Some(w) = world(n0).filter(|w| w.0 == c) else { continue };
		let radius = n0["radius"].as_f64().filter(|r| *r != 0.0).unwrap_or(R_MIN);
		let mut at = (w.1, w.2, cx.z_of(w.1, w.2), R_MIN.max(R_MAX.min(radius)));
		if kind == "cave" || kind == "building" {
			let pts: Vec<(f64, f64)> = ch["nodes"].as_array().into_iter().flatten().filter_map(world).filter(|p| p.0 == c).map(|p| (p.1, p.2)).collect();
			match indoor_mouth(&|x, y, z, r| cx.surface(x, y, z, r), &pts) {
				Mouth::NoDoorway => continue,
				Mouth::Door(m) => at = (m.0, m.1, Some(m.2), m.3),
				Mouth::None => {}
			}
		}
		if near(&list, at.0, at.1, kind).is_some() {
			continue;
		}
		list.push(cx.entry(round1(at.0), round1(at.1), at.2, at.3, kind, (at.0, at.1)));
	}
	for x in aids["crossings"].as_array().into_iter().flatten() {
		let (Some(a), Some(b)) = (world(&x["a"]), world(&x["b"])) else { continue };
		if a.0 != c || b.0 != c {
			continue;
		}
		let caption = [&x["ab"], &x["ba"]].iter().filter_map(|v| v.as_str()).find(|s| !s.is_empty()).unwrap_or("").to_lowercase();
		if caption.contains("lift") {
			continue;
		}
		let kind = if caption.contains("bridge") {
			"bridge"
		} else if caption.contains("tunnel") {
			"tunnel"
		} else {
			"pass"
		};
		let wx = (a.1 + b.1) / 2.0;
		let wy = (a.2 + b.2) / 2.0;
		if near(&list, wx, wy, kind).is_some() {
			continue;
		}
		let sides = [a, b]
			.iter()
			.map(|p| {
				let at = cx.place(p.1, p.2);
				Side { wx: round1(p.1), wy: round1(p.2), area: at.as_ref().map(|a| a.zone.clone()).unwrap_or_default(), zone_area: at.map(|a| a.zone_area).filter(|z| *z != 0) }
			})
			.collect();
		let radius = x["a"]["radius"].as_f64().filter(|r| *r != 0.0).unwrap_or(R_MIN);
		let mut ch = cx.entry(round1(wx), round1(wy), cx.z_of(wx, wy), R_MIN.max(R_MAX.min(radius)), kind, (wx, wy));
		ch.sides = Some(sides);
		list.push(ch);
	}
	for g in grid_chokepoints(&cx, &nav.grid) {
		if near(&list, g.wx, g.wy, &g.kind).is_some() {
			continue;
		}
		if let Some(p) = near(&list, g.wx, g.wy, "pass") {
			// The pass keeps its own ids where the grid's place has no area (the JS spreads { name: '', zone: '' }).
			let place = cx.place(g.wx, g.wy);
			let e = &mut list[p];
			e.kind = g.kind.clone();
			e.wx = g.wx;
			e.wy = g.wy;
			e.z = g.z;
			match place {
				Some(a) => {
					e.name = a.name;
					e.area = Some(a.area);
					e.zone = a.zone;
					e.zone_area = Some(a.zone_area);
				}
				None => {
					e.name = String::new();
					e.zone = String::new();
				}
			}
			continue;
		}
		if g.kind == "bridge" {
			list.push(g);
		}
	}
	for x in list.iter_mut() {
		if x.name.is_empty() {
			if !x.zone.is_empty() {
				x.name = x.zone.clone();
				x.area = x.zone_area;
			} else {
				x.name = x.kind.clone();
				x.area = None;
			}
		}
		if x.zone.is_empty() {
			x.zone = x.name.clone();
			x.zone_area = x.area;
		}
		let (zone, zone_area) = (x.zone.clone(), x.zone_area);
		for s in x.sides.iter_mut().flatten() {
			if !s.area.is_empty() {
				continue;
			}
			s.area = zone.clone();
			if zone_area.is_some_and(|z| z != 0) {
				s.zone_area = zone_area;
			}
		}
		if x.area == Some(0) {
			x.area = None;
		}
		if x.zone_area == Some(0) {
			x.zone_area = None;
		}
	}
	list
}

/// String(v) of a JSON value as the JS writes it into Lua.
fn js_value_string(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		Value::Number(n) => js_to_string(n.as_f64().unwrap_or(0.0)),
		Value::Null => "null".into(),
		Value::Bool(b) => b.to_string(),
		other => other.to_string(),
	}
}

fn lua_str(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\""))
}

/// { c: entries } -> Chokepoints.lua (global PolestarNavChokepoints); `gen` is its first line.
pub fn chokepoints_lua(by_map: &[(u32, Vec<Choke>)], gen: &str) -> String {
	let global = "PolestarNavChokepoints";
	let mut lines = vec![
		gen.to_string(),
		"-- Chokepoints a walk passes, for its named steps (tools/lib/nav/chokepoints.js; Nav/Walk.lua reads them).".into(),
		"-- Per continent: { wx, wy, z, r, kind, name, area?, zone, zoneArea?, sides?, liftEnd?, lift?, liftObject?, pair? } in UnitPosition's frame".into(),
		"-- (area, zoneArea: AreaTable ids of name and zone, for their names in the client's language; liftObject: the lift's GameObject)".into(),
		"-- (wx north, wy west), yards; kind lift | gate | bridge | tunnel | cave | building | pass; pair indexes this list.".into(),
		format!("{global} = {global} or {{}}"),
	];
	let mut maps: Vec<&(u32, Vec<Choke>)> = by_map.iter().collect();
	maps.sort_by_key(|m| m.0);
	let n = js_to_string;
	for (c, list) in maps {
		lines.push(format!("{global}[{c}] = {{"));
		for x in list {
			let mut f: Vec<String> = vec![format!("wx = {}", n(x.wx)), format!("wy = {}", n(x.wy))];
			if let Some(z) = x.z {
				f.push(format!("z = {}", n(z)));
			}
			f.push(format!("r = {}", n(x.r)));
			f.push(format!("kind = {}", lua_str(&x.kind)));
			f.push(format!("name = {}", lua_str(&x.name)));
			if let Some(a) = x.area {
				f.push(format!("area = {a}"));
			}
			f.push(format!("zone = {}", lua_str(&x.zone)));
			if let Some(a) = x.zone_area {
				f.push(format!("zoneArea = {a}"));
			}
			if let Some(l) = &x.lift {
				f.push(format!("lift = {}", lua_str(l)));
			}
			if let Some(l) = &x.lift_object {
				f.push(format!("liftObject = {l}"));
			}
			if let Some(l) = x.lift_end {
				f.push(format!("liftEnd = {}", lua_str(l)));
			}
			if let Some(p) = x.pair {
				f.push(format!("pair = {}", p + 1));
			}
			if let Some(sides) = &x.sides {
				let s: Vec<String> = sides
					.iter()
					.map(|s| {
						let mut v = vec![format!("wx = {}", n(s.wx)), format!("wy = {}", n(s.wy)), format!("area = {}", lua_str(&s.area))];
						if let Some(z) = s.zone_area {
							v.push(format!("zoneArea = {z}"));
						}
						format!("{{ {} }}", v.join(", "))
					})
					.collect();
				f.push(format!("sides = {{ {} }}", s.join(", ")));
			}
			lines.push(format!("\t{{ {} }},", f.join(", ")));
		}
		lines.push("}".into());
	}
	format!("{}\n", lines.join("\n"))
}

#[cfg(test)]
mod tests {
	use super::*;

	// A cave or building mouth is a doorway: indoor ground with outdoor ground at its height beside
	// it (tests/navmesh-chokepoints.test.js's scene, as surfaces). A hut: an indoor floor at 0.2
	// (x 100..140, y 100..140), open to the west, walled (tops at 6) on its other sides. A hall: an
	// indoor floor 40 yd down (x, y 300..360) under a hole in the ground (the shaft) at x, y 320..340.
	fn surfaces(x: f64, y: f64) -> Vec<(f64, u8)> {
		let mut out = Vec::new();
		let hut = (100.0..=140.0).contains(&x) && (100.0..=140.0).contains(&y);
		let wall = !hut && (100.0..=144.0).contains(&x) && (96.0..=144.0).contains(&y);
		let hole = x > 320.0 && x < 340.0 && y > 320.0 && y < 340.0;
		if hut {
			out.push((0.2, flag::WMO | flag::INDOOR));
		} else if wall {
			out.push((6.0, flag::WMO));
		} else if !hole {
			out.push((0.0, flag::TERRAIN));
		}
		if (300.0..=360.0).contains(&x) && (300.0..=360.0).contains(&y) {
			out.push((-40.0, flag::WMO | flag::INDOOR));
		}
		out
	}

	// The surface nearest z, else the highest.
	fn snap(x: f64, y: f64, z: Option<f64>, _radius: f64) -> Option<(f64, u8)> {
		let s = surfaces(x, y);
		match z {
			Some(z) => s.into_iter().min_by(|a, b| (a.0 - z).abs().total_cmp(&(b.0 - z).abs())),
			None => s.into_iter().max_by(|a, b| a.0.total_cmp(&b.0)),
		}
	}

	#[test]
	fn a_chain_into_a_hut_at_ground_level_has_its_mouth_at_the_door() {
		let Mouth::Door((wx, wy, z, r)) = indoor_mouth(&snap, &[(60.0, 120.0), (120.0, 120.0)]) else { panic!("the hut's doorway") };
		assert_eq!((wx, wy), (100.0, 120.0), "centred on the hut's open side");
		assert_eq!(z, 0.2, "at ground level");
		assert_eq!(r, 22.0, "reaching across the whole doorway");
	}

	#[test]
	fn a_chain_down_a_shaft_or_indoors_from_its_first_step_has_no_mouth() {
		assert!(matches!(indoor_mouth(&snap, &[(330.0, 280.0), (330.0, 330.0), (330.0, 345.0)]), Mouth::NoDoorway), "down the shaft onto the sunken hall");
		assert!(matches!(indoor_mouth(&snap, &[(120.0, 120.0), (60.0, 120.0)]), Mouth::NoDoorway), "starting inside the hut");
		assert!(matches!(indoor_mouth(&snap, &[(0.0, 0.0), (50.0, 0.0)]), Mouth::None), "never indoors");
	}
}
