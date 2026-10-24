//! The flight network from TaxiNodes / TaxiPath / TaxiPathNode (port of
//! tools/lib/travel/taxi.js) and the NPC/object lookups (tools/lib/travel/entities.js).

use forge_core::jsnum::{js_hypot_n, js_round};
use forge_guide::js::{str_to_num, V};
use indexmap::IndexMap;
use rustc_hash::FxHashMap;

use super::geo::{dist2d, is_jump, place_point, round, Frame, Frames, Pt};
use crate::jsv::{Row, Rows};

pub const NPC_MATCH_YARDS: f64 = 60.0;
pub const TRACK_TOLERANCE: f64 = 10.0;

pub type LiveFrames = FxHashMap<i64, Frame>;

/// `num(v)`: Number(v) when finite.
pub fn num(r: &Row, col: &str) -> Option<f64> {
	let n = r.get(col).map(|s| str_to_num(s)).unwrap_or(f64::NAN);
	n.is_finite().then_some(n)
}

/// A spawn point in world space.
#[derive(Clone, Debug)]
pub struct SpawnPt {
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub f: &'static str,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
}

/// entities.js spawnPoints.
pub fn spawn_points(entity: &V, frames: &Frames, live: &LiveFrames) -> Vec<SpawnPt> {
	let mut out = Vec::new();
	let spawns = entity.get("spawns");
	let Some(o) = spawns.as_obj() else { return out };
	for (k, s) in o.entries() {
		let map = str_to_num(&k) as i64;
		let is_live = s.get("f").as_str() == Some("l");
		for p in s.get("pts").items() {
			let (x, y) = (p.at(0).num(), p.at(1).num());
			let w = if is_live {
				live.get(&map).map(|b| (b.c, b.top + (b.bottom - b.top) * (y / 100.0), b.left + (b.right - b.left) * (x / 100.0)))
			} else {
				frames.to_world(map, x, y).map(|w| (w.c, w.wx, w.wy))
			};
			if let Some((c, wx, wy)) = w {
				out.push(SpawnPt { map, x, y, f: if is_live { "l" } else { "e" }, c, wx, wy });
			}
		}
	}
	out
}

/// entities.js indexByName: name -> entities, ids ascending.
pub fn index_by_name(table: &V) -> FxHashMap<String, Vec<V>> {
	let mut idx: FxHashMap<String, Vec<V>> = FxHashMap::default();
	let Some(o) = table.as_obj() else { return idx };
	let mut ids: Vec<(f64, V)> = o.entries().into_iter().map(|(k, v)| (str_to_num(&k), v)).collect();
	ids.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
	for (_, e) in ids {
		if !e.truthy() || !e.get("name").truthy() {
			continue;
		}
		idx.entry(e.get("name").to_js_string()).or_default().push(e);
	}
	idx
}

/// Ramer-Douglas-Peucker on wx, wy.
fn simplify(pts: &[Pt], tolerance: f64) -> Vec<Pt> {
	let mut keep = vec![false; pts.len()];
	keep[0] = true;
	keep[pts.len() - 1] = true;
	let mut stack = vec![(0usize, pts.len() - 1)];
	while let Some((a, b)) = stack.pop() {
		let (pa, pb) = (&pts[a], &pts[b]);
		let (dx, dy) = (pb.wx - pa.wx, pb.wy - pa.wy);
		let len = dist2d((dx, dy), (0.0, 0.0));
		let (mut far, mut worst) = (0usize, tolerance);
		for (i, p) in pts.iter().enumerate().take(b).skip(a + 1) {
			let d = if len > 0.0 { (dx * (pa.wy - p.wy) - dy * (pa.wx - p.wx)).abs() / len } else { dist2d((p.wx, p.wy), (pa.wx, pa.wy)) };
			if d > worst {
				worst = d;
				far = i;
			}
		}
		if far > 0 {
			keep[far] = true;
			stack.push((a, far));
			stack.push((far, b));
		}
	}
	pts.iter().zip(keep).filter(|(_, k)| *k).map(|(p, _)| *p).collect()
}

fn track(pts: &[Pt]) -> Option<Vec<f64>> {
	if pts.len() < 2 || path_length(pts).1 > 0 {
		return None;
	}
	Some(simplify(pts, TRACK_TOLERANCE).iter().flat_map(|p| [js_round(p.wx), js_round(p.wy)]).collect())
}

fn short_name(name: &str) -> String {
	match name.find(',') {
		Some(i) if i > 0 => name[..i].trim().to_string(),
		_ => name.trim().to_string(),
	}
}

/// (yards, teleports).
pub fn path_length(points: &[Pt]) -> (f64, usize) {
	let mut yards = 0.0;
	let mut teleports = 0;
	for w in points.windows(2) {
		let (a, b) = (&w[0], &w[1]);
		if is_jump(a, b) {
			teleports += 1;
			continue;
		}
		yards += js_hypot_n(&[b.wx - a.wx, b.wy - a.wy, b.z - a.z]);
	}
	(yards, teleports)
}

/// TaxiPathNode rows -> path id -> points by NodeIndex.
pub fn path_points(rows: &Rows) -> FxHashMap<i64, Vec<Pt>> {
	let mut by_path: FxHashMap<i64, Vec<Pt>> = FxHashMap::default();
	for r in rows {
		let Some(id) = num(r, "PathID").filter(|&n| n != 0.0) else { continue };
		let z = |c: &str| num(r, c).unwrap_or(0.0);
		by_path.entry(id as i64).or_default().push(Pt {
			i: num(r, "NodeIndex").unwrap_or(0.0),
			c: num(r, "ContinentID").unwrap_or(f64::NAN),
			wx: num(r, "Loc_0").unwrap_or(f64::NAN),
			wy: num(r, "Loc_1").unwrap_or(f64::NAN),
			z: z("Loc_2"),
			flags: z("Flags"),
			delay: z("Delay"),
		});
	}
	for pts in by_path.values_mut() {
		pts.sort_by(|a, b| a.i.partial_cmp(&b.i).unwrap_or(std::cmp::Ordering::Equal));
	}
	by_path
}

pub struct Node {
	pub id: f64,
	pub name: String,
	pub short: String,
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub faction: i32,
	pub npc: Option<(f64, String)>,
}

pub struct Leg {
	pub path: f64,
	pub from: f64,
	pub to: f64,
	pub yards: f64,
	pub cost: f64,
	pub track: Option<Vec<f64>>,
}

pub struct Taxi {
	pub nodes: Vec<Node>,
	pub legs: Vec<Leg>,
	pub warnings: Vec<String>,
}

fn by_num(a: f64, b: f64) -> std::cmp::Ordering {
	(a - b).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

pub fn build_taxi(nodes_rows: &Rows, paths_rows: &Rows, path_node_rows: &Rows, frames: &Frames, npcs: &V, live: &LiveFrames) -> Taxi {
	let mut warnings = Vec::new();
	let mut masters: Vec<(f64, V)> = npcs
		.as_obj()
		.map(|o| o.values())
		.unwrap_or_default()
		.into_iter()
		.filter(|n| n.get("roles").items().iter().any(|r| r.as_str() == Some("flightmaster")))
		.map(|n| (n.get("id").num(), n))
		.collect();
	masters.sort_by(|a, b| by_num(a.0, b.0));
	let masters: Vec<(V, Vec<SpawnPt>)> = masters
		.into_iter()
		.map(|(_, n)| {
			let pts = spawn_points(&n, frames, live);
			(n, pts)
		})
		.collect();
	let continents = frames.continents();

	let mut nodes: Vec<Node> = Vec::new();
	let mut by_id: FxHashMap<i64, usize> = FxHashMap::default();
	let mut rows: Vec<&Row> = nodes_rows.iter().collect();
	rows.sort_by(|a, b| by_num(num(a, "ID").unwrap_or(0.0), num(b, "ID").unwrap_or(0.0)));
	for r in rows {
		let Some(id) = num(r, "ID").filter(|&n| n != 0.0) else { continue };
		let flags = num(r, "Flags").unwrap_or(0.0);
		let faction = crate::jsv::to_int32(flags) & 3;
		if faction == 0 || !(num(r, "CharacterBitNumber").is_some_and(|n| n > 0.0)) {
			continue;
		}
		let c = num(r, "ContinentID").unwrap_or(f64::NAN);
		let wx = num(r, "Pos_0").unwrap_or(f64::NAN);
		let wy = num(r, "Pos_1").unwrap_or(f64::NAN);
		let name = r.get("Name_lang").map(|s| s.trim().to_string()).unwrap_or_default();
		let id_s = forge_guide::js::num_str(id);
		if !(c.fract() == 0.0 && continents.contains_key(&(c as i64))) {
			warnings.push(format!("taxi node {id_s} \"{name}\": continent {} has no map frame, skipped", forge_guide::js::num_str(c)));
			continue;
		}
		// The flight master standing at this node: (npc, d).
		let mut matched: Option<(&V, f64)> = None;
		for (npc, pts) in &masters {
			let f = npc.get("faction");
			let side = match f.as_str() {
				Some("A") => 1,
				Some("H") => 2,
				_ => 3,
			};
			if side & faction == 0 {
				continue;
			}
			for p in pts {
				if p.c != c {
					continue;
				}
				let d = dist2d((p.wx, p.wy), (wx, wy));
				if d <= NPC_MATCH_YARDS && matched.is_none_or(|m| d < m.1) {
					matched = Some((npc, d));
				}
			}
		}
		let maps = matched.map(|(npc, _)| npc_maps_at(npc, frames, live, c, wx, wy)).unwrap_or_default();
		let Some(place) = place_point(frames, c, wx, wy, &maps, &name) else {
			warnings.push(format!("taxi node {id_s} \"{name}\": no zone map holds ({}, {}), skipped", forge_guide::js::num_str(round(wx, 1)), forge_guide::js::num_str(round(wy, 1))));
			continue;
		};
		if matched.is_none() {
			warnings.push(format!("taxi node {id_s} \"{name}\": no flight master NPC within {} yd", NPC_MATCH_YARDS));
		}
		by_id.insert(id as i64, nodes.len());
		nodes.push(Node {
			id,
			short: short_name(&name),
			name,
			c,
			wx: round(wx, 1),
			wy: round(wy, 1),
			map: place.map,
			x: place.x,
			y: place.y,
			faction,
			npc: matched.map(|(npc, _)| (npc.get("id").num(), npc.get("name").to_js_string())),
		});
	}

	let points = path_points(path_node_rows);
	let mut legs: Vec<Leg> = Vec::new();
	let mut paths: Vec<&Row> = paths_rows.iter().collect();
	paths.sort_by(|a, b| by_num(num(a, "ID").unwrap_or(0.0), num(b, "ID").unwrap_or(0.0)));
	let node_at = |r: &Row, col: &str| num(r, col).and_then(|n| if n.fract() == 0.0 { by_id.get(&(n as i64)).copied() } else { None });
	for r in paths {
		let (Some(fi), Some(ti)) = (node_at(r, "FromTaxiNode"), node_at(r, "ToTaxiNode")) else { continue };
		if fi == ti {
			continue;
		}
		let (from, to) = (&nodes[fi], &nodes[ti]);
		let pid = num(r, "ID");
		let empty = Vec::new();
		let pts = pid.and_then(|p| points.get(&(p as i64))).unwrap_or(&empty);
		let raw_id = r.get("ID").map(String::as_str).unwrap_or("undefined");
		if from.c != to.c {
			warnings.push(format!("taxi path {raw_id}: {} -> {} crosses continents, skipped", from.name, to.name));
			continue;
		}
		let (mut yards, teleports) = path_length(pts);
		if pts.len() < 2 || teleports > 0 {
			warnings.push(format!("taxi path {raw_id}: {} -> {} has {}; straight line used", from.name, to.name, if pts.len() < 2 { "no points" } else { "a teleport" }));
			yards = dist2d((from.wx, from.wy), (to.wx, to.wy));
		}
		legs.push(Leg { path: pid.unwrap_or(f64::NAN), from: from.id, to: to.id, yards: js_round(yards), cost: num(r, "Cost").filter(|&n| n != 0.0).unwrap_or(0.0), track: track(pts) });
	}
	legs.sort_by(|a, b| by_num(a.from, b.from).then(by_num(a.to, b.to)).then(by_num(a.path, b.path)));
	// One leg per ordered pair: the shortest when Blizzard lists several.
	let mut seen: IndexMap<(i64, i64), usize> = IndexMap::new();
	for (i, l) in legs.iter().enumerate() {
		let k = (l.from as i64, l.to as i64);
		match seen.get(&k) {
			Some(&j) if legs[j].yards <= l.yards => {}
			_ => {
				seen.insert(k, i);
			}
		}
	}
	let mut keep: Vec<usize> = seen.values().copied().collect();
	keep.sort_by(|&a, &b| by_num(legs[a].from, legs[b].from).then(by_num(legs[a].to, legs[b].to)));
	let mut slots: Vec<Option<Leg>> = legs.into_iter().map(Some).collect();
	let unique = keep.into_iter().map(|i| slots[i].take().unwrap()).collect();
	Taxi { nodes, legs: unique, warnings }
}

/// Maps on which the matched NPC spawns at the node.
fn npc_maps_at(npc: &V, frames: &Frames, live: &LiveFrames, c: f64, wx: f64, wy: f64) -> Vec<i64> {
	let mut maps: Vec<i64> = Vec::new();
	for p in spawn_points(npc, frames, live) {
		if p.c == c && dist2d((p.wx, p.wy), (wx, wy)) <= NPC_MATCH_YARDS && !maps.contains(&p.map) {
			maps.push(p.map);
		}
	}
	maps.sort();
	maps
}
