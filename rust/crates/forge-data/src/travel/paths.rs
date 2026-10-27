//! Walking paths learned from recorded play (port of tools/lib/travel/paths.js; see its header):
//! breadcrumbs snapped to a CELL-yard grid, consecutive distinct cells as edges, zone steps kept
//! for recorded crossings, chains of plain degree-2 nodes collapsed.

use forge_core::jsnum::{js_hypot, js_round};
use forge_guide::js::{cmp_utf16, str_to_num, V};
use indexmap::{IndexMap, IndexSet};

use super::geo::{round, Frame, Frames};
use super::taxi::LiveFrames;
use crate::recordings::Recording;

const CELL: f64 = 30.0;
const MAX_STEP: f64 = 150.0;
const MAX_SPEED: f64 = 25.0;

fn number(v: &V) -> f64 {
	match v {
		V::Num(n) => *n,
		V::Str(s) => str_to_num(s),
		V::Bool(b) => f64::from(u8::from(*b)),
		V::Null => 0.0,
		V::Undef => f64::NAN,
		V::Arr(a) => match a.len() {
			0 => 0.0,
			1 => number(&a.get(0)),
			_ => f64::NAN,
		},
		V::Obj(_) => f64::NAN,
	}
}

/// A recording's map bounds when every field is a finite number.
fn rec_frame(m: &V) -> Option<Frame> {
	if !m.truthy() {
		return None;
	}
	let f = |k: &str| number(&m.get(k));
	let ok = ["c", "left", "right", "top", "bottom"].iter().all(|k| f(k).is_finite());
	ok.then(|| Frame { c: f("c"), left: f("left"), right: f("right"), top: f("top"), bottom: f("bottom") })
}

pub fn live_frames_of(recordings: &[Recording]) -> LiveFrames {
	let mut out = LiveFrames::default();
	for r in recordings {
		let maps = r.rec.get("maps");
		let Some(o) = maps.as_obj() else { continue };
		for (id, m) in o.entries() {
			let n = str_to_num(&id) as i64;
			if let Some(b) = rec_frame(&m) {
				out.entry(n).or_insert(b);
			}
		}
	}
	out
}

#[derive(Clone, Debug)]
pub struct WalkPt {
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
	pub t: f64,
}

pub struct Walk {
	pub session: String,
	pub points: Vec<WalkPt>,
}

fn to_world(map: i64, x: f64, y: f64, rec: &V, frames: &Frames) -> Option<(f64, f64, f64)> {
	let b = rec_frame(&rec.get("maps").get(&map.to_string())).or_else(|| frames.frame(map))?;
	Some((b.c, b.top + (b.bottom - b.top) * (y / 100.0), b.left + (b.right - b.left) * (x / 100.0)))
}

/// recordedWalks: each session's breadcrumbs cut into walks -> (walks, unplaced).
pub fn recorded_walks(recordings: &[Recording], frames: &Frames) -> (Vec<Walk>, usize) {
	let mut walks = Vec::new();
	let mut unplaced = 0;
	for r in recordings {
		let s = r.rec.get("session");
		let session = if s.truthy() { s.to_js_string() } else { r.file.strip_suffix(".json").unwrap_or(&r.file).to_string() };
		let mut walk: Option<Walk> = None;
		let cut = |walk: &mut Option<Walk>, walks: &mut Vec<Walk>| {
			if let Some(w) = walk.take() {
				if !w.points.is_empty() {
					walks.push(w);
				}
			}
		};
		for ev in r.rec.get("events").items() {
			let e = ev.get("e");
			let kind = e.as_str().unwrap_or("");
			if e.is_str() && matches!(kind, "taxi" | "death" | "bind") {
				cut(&mut walk, &mut walks);
				continue;
			}
			if kind != "pos" {
				continue;
			}
			let map = number(&ev.get("map"));
			let x = number(&ev.get("x"));
			let y = number(&ev.get("y"));
			if !(map.is_finite() && map.fract() == 0.0 && x.is_finite() && y.is_finite()) {
				continue;
			}
			let map = map as i64;
			let Some((c, wx, wy)) = to_world(map, x, y, &r.rec, frames) else {
				unplaced += 1;
				cut(&mut walk, &mut walks);
				continue;
			};
			let t = number(&ev.get("t"));
			let p = WalkPt { c, wx, wy, map, t: if t.is_nan() { 0.0 } else { t } };
			if let Some(prev) = walk.as_ref().and_then(|w| w.points.last()) {
				let d = js_hypot(p.wx - prev.wx, p.wy - prev.wy);
				let dt = p.t - prev.t;
				if prev.c != p.c || d > MAX_STEP || (dt > 0.0 && d / dt > MAX_SPEED) {
					cut(&mut walk, &mut walks);
				}
			}
			walk.get_or_insert_with(|| Walk { session: session.clone(), points: Vec::new() }).points.push(p);
		}
		cut(&mut walk, &mut walks);
	}
	(walks, unplaced)
}

/// One step across a zone border.
pub struct ZoneStep {
	pub c: f64,
	pub from: (i64, f64, f64),
	pub to: (i64, f64, f64),
	pub session: String,
}

pub struct PathNode {
	pub id: usize,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
	pub gateway: Option<Vec<i64>>,
}

pub struct PathEdge {
	pub a: usize,
	pub b: usize,
	pub yards: f64,
	pub n: f64,
	pub sessions: Vec<String>,
}

pub struct Paths {
	pub nodes: Vec<PathNode>,
	pub edges: Vec<PathEdge>,
	pub sessions: Vec<String>,
	pub zone_steps: Vec<ZoneStep>,
	pub warnings: Vec<String>,
}

struct Cell {
	c: f64,
	gx: f64,
	gy: f64,
	sx: f64,
	sy: f64,
	n: f64,
	maps: IndexMap<i64, f64>,
	gateway: IndexSet<i64>,
}

struct Edge {
	a: String,
	b: String,
	n: f64,
	sessions: IndexSet<String>,
}

fn utf16_sorted(mut v: Vec<String>) -> Vec<String> {
	v.sort_by(|a, b| cmp_utf16(a, b));
	v
}

pub fn build_paths(recordings: &[Recording], frames: &Frames) -> Paths {
	let mut warnings = Vec::new();
	let mut cells: IndexMap<String, Cell> = IndexMap::new();
	let mut edges: IndexMap<String, Edge> = IndexMap::new();
	let mut zone_steps = Vec::new();
	let (walks, unplaced) = recorded_walks(recordings, frames);
	for w in &walks {
		// (point, cell key)
		let mut prev: Option<(&WalkPt, String)> = None;
		for p in &w.points {
			let gx = (p.wx / CELL).floor();
			let gy = (p.wy / CELL).floor();
			let key = format!("{}:{}:{}", forge_guide::js::num_str(p.c), forge_guide::js::num_str(gx), forge_guide::js::num_str(gy));
			let cell = cells.entry(key.clone()).or_insert_with(|| Cell { c: p.c, gx, gy, sx: 0.0, sy: 0.0, n: 0.0, maps: IndexMap::new(), gateway: IndexSet::new() });
			cell.sx += p.wx;
			cell.sy += p.wy;
			cell.n += 1.0;
			*cell.maps.entry(p.map).or_insert(0.0) += 1.0;
			if let Some((pp, ak)) = &prev {
				if *ak != key {
					if pp.map != p.map {
						for k in [ak.as_str(), key.as_str()] {
							let g = &mut cells.get_mut(k).unwrap().gateway;
							g.insert(pp.map);
							g.insert(p.map);
						}
						zone_steps.push(ZoneStep { c: p.c, from: (pp.map, pp.wx, pp.wy), to: (p.map, p.wx, p.wy), session: w.session.clone() });
					}
					let (k1, k2) = if cmp_utf16(ak, &key).is_lt() { (ak.clone(), key.clone()) } else { (key.clone(), ak.clone()) };
					let ek = format!("{k1}|{k2}");
					let e = edges.entry(ek).or_insert_with(|| Edge { a: k1, b: k2, n: 0.0, sessions: IndexSet::new() });
					e.n += 1.0;
					e.sessions.insert(w.session.clone());
				}
			}
			prev = Some((p, key));
		}
	}
	if unplaced > 0 {
		warnings.push(format!("learned paths: {unplaced} breadcrumb(s) on maps without bounds skipped"));
	}

	// Adjacency over cells that have edges: key -> neighbour -> edge key.
	let mut adj: IndexMap<String, IndexMap<String, String>> = IndexMap::new();
	for (ek, e) in &edges {
		adj.entry(e.a.clone()).or_default();
		adj.entry(e.b.clone()).or_default();
		adj.get_mut(&e.a).unwrap().insert(e.b.clone(), ek.clone());
		adj.get_mut(&e.b).unwrap().insert(e.a.clone(), ek.clone());
	}
	let pos = |key: &str| {
		let c = &cells[key];
		(c.sx / c.n, c.sy / c.n)
	};
	let len = |a: &str, b: &str| {
		let (p, q) = (pos(a), pos(b));
		js_hypot(p.0 - q.0, p.1 - q.1)
	};
	let keep: IndexSet<String> = adj.iter().filter(|(k, nb)| nb.len() != 2 || !cells[k.as_str()].gateway.is_empty()).map(|(k, _)| k.clone()).collect();
	// "k1|k2" -> (a, b, yards, n, sessions)
	let mut out: IndexMap<String, (String, String, f64, f64, IndexSet<String>)> = IndexMap::new();
	let mut visited: IndexSet<String> = IndexSet::new();
	let keys = utf16_sorted(adj.keys().cloned().collect());
	let add_edge = |out: &mut IndexMap<String, (String, String, f64, f64, IndexSet<String>)>, a: &str, b: &str, yards: f64, n: f64, sessions: IndexSet<String>| {
		if a == b {
			return;
		}
		let (k1, k2) = if cmp_utf16(a, b).is_lt() { (a, b) } else { (b, a) };
		let ek = format!("{k1}|{k2}");
		if out.get(&ek).is_none_or(|e| e.2 > yards) {
			out.insert(ek, (k1.to_string(), k2.to_string(), yards, n, sessions));
		}
	};
	for start in &keys {
		if !keep.contains(start) {
			continue;
		}
		for next in utf16_sorted(adj[start].keys().cloned().collect()) {
			let first = &edges[&adj[start][&next]];
			let ek = format!("{}|{}", first.a, first.b);
			if visited.contains(&ek) {
				continue;
			}
			visited.insert(ek);
			let mut yards = len(start, &next);
			let mut n = first.n;
			let mut sessions = first.sessions.clone();
			let mut prev = start.clone();
			let mut cur = next.clone();
			while !keep.contains(&cur) {
				let Some(nxt) = adj[&cur].keys().find(|k| **k != prev).cloned() else { break };
				let e = &edges[&adj[&cur][&nxt]];
				visited.insert(format!("{}|{}", e.a, e.b));
				yards += len(&cur, &nxt);
				n = n.min(e.n);
				for s in &e.sessions {
					sessions.insert(s.clone());
				}
				prev = cur;
				cur = nxt;
				if cur == *start {
					break;
				}
			}
			add_edge(&mut out, start, &cur, yards, n, sessions);
		}
	}
	for ek in utf16_sorted(edges.keys().cloned().collect()) {
		if visited.contains(&ek) {
			continue;
		}
		let e = &edges[&ek];
		add_edge(&mut out, &e.a, &e.b, len(&e.a, &e.b), e.n, e.sessions.clone());
	}
	// A learned path changes how the grid routes (another source): it needs trusted evidence,
	// the walks of two counted players or the maintainer's own (recordings.rs "Trust"),
	// each player (cohort, else contributor) once however many sessions, installs or tokens walked it.
	let mut who: IndexMap<String, IndexSet<String>> = IndexMap::new();
	for r in recordings {
		let s = r.rec.get("session");
		let session = if s.truthy() { s.to_js_string() } else { r.file.strip_suffix(".json").unwrap_or(&r.file).to_string() };
		let w = who.entry(session).or_default();
		if r.counts {
			w.insert(r.voter());
		}
	}
	out.retain(|_, e| {
		let mut c: IndexSet<String> = IndexSet::new();
		for s in &e.4 {
			if let Some(w) = who.get(s) {
				c.extend(w.iter().cloned());
			}
		}
		crate::recordings::trusted(&c)
	});

	let mut used: IndexSet<String> = IndexSet::new();
	for e in out.values() {
		used.insert(e.0.clone());
		used.insert(e.1.clone());
	}
	let mut ordered: Vec<String> = used.into_iter().collect();
	let by = |a: f64, b: f64| (a - b).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal);
	ordered.sort_by(|a, b| {
		let (ca, cb) = (&cells[a.as_str()], &cells[b.as_str()]);
		by(ca.c, cb.c).then(by(ca.gx, cb.gx)).then(by(ca.gy, cb.gy))
	});
	let index: IndexMap<&str, usize> = ordered.iter().enumerate().map(|(i, k)| (k.as_str(), i + 1)).collect();
	let nodes = ordered
		.iter()
		.map(|k| {
			let cell = &cells[k.as_str()];
			let p = pos(k);
			let mut maps: Vec<(i64, f64)> = cell.maps.iter().map(|(m, n)| (*m, *n)).collect();
			maps.sort_by(|a, b| by(b.1, a.1).then(a.0.cmp(&b.0)));
			let gateway = (!cell.gateway.is_empty()).then(|| {
				let mut g: Vec<i64> = cell.gateway.iter().copied().collect();
				g.sort();
				g
			});
			PathNode { id: index[k.as_str()], c: cell.c, wx: round(p.0, 1), wy: round(p.1, 1), map: maps[0].0, gateway }
		})
		.collect();
	let mut edge_list: Vec<PathEdge> =
		out.values().map(|e| PathEdge { a: index[e.0.as_str()], b: index[e.1.as_str()], yards: js_round(e.2), n: e.3, sessions: utf16_sorted(e.4.iter().cloned().collect()) }).collect();
	edge_list.sort_by(|x, y| x.a.cmp(&y.a).then(x.b.cmp(&y.b)));
	let mut all: IndexSet<String> = IndexSet::new();
	for e in &edge_list {
		for s in &e.sessions {
			all.insert(s.clone());
		}
	}
	let sessions = utf16_sorted(all.into_iter().collect());
	Paths { nodes, edges: edge_list, sessions, zone_steps, warnings }
}
