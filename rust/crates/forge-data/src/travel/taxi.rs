//! The flight network from TaxiNodes / TaxiPath / TaxiPathNode (port of
//! tools/lib/travel/taxi.js) and the NPC/object lookups (tools/lib/travel/entities.js).

use forge_core::jsnum::{js_hypot_n, js_round};
use forge_guide::js::{str_to_num, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

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
	path_points_where(rows, |_| true)
}

/// [`path_points`] of the paths `keep` takes alone.
fn path_points_where(rows: &Rows, keep: impl Fn(i64) -> bool) -> FxHashMap<i64, Vec<Pt>> {
	let mut by_path: FxHashMap<i64, Vec<Pt>> = FxHashMap::default();
	for r in rows {
		let Some(id) = num(r, "PathID").filter(|&n| n != 0.0) else { continue };
		if !keep(id as i64) {
			continue;
		}
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
	/// The frame x, y are in: "e" the map's Era frame; "l" its live frame, on a map Forever added (no
	/// Era frame: the Riverglades, Mount Hyjal).
	pub f: &'static str,
	pub faction: i32,
	pub npc: Option<(f64, String)>,
	/// The class alone that may fly from it (client file name: "DRUID"), None: every class.
	pub class: Option<&'static str>,
}

/// Taxi nodes the client lists with no character bit, for one class (TaxiNodes 62 and 63, Nighthaven:
/// Silva Fil'naveth and Bunthen Plainswind fly Druids out of Moonglade to Rut'theran Village and
/// Thunder Bluff; never a destination, the client's TaxiPath has those two flights out only).
const CLASS_NODES: [(i64, &str); 2] = [(62, "DRUID"), (63, "DRUID")];

/// How the client names the TaxiNodes rows it retired: Forever's "zzOLDBolder'ok, Riverglades",
/// "zzOLDRiverglades, Farholde Keep" (at Southshore's spot) and "zzOLDPowderfuse Port, Riverglades"
/// keep a faction and a character bit but no flight, and are no flight point.
const RETIRED: &str = "zzOLD";

/// One client's flight tables: its TaxiNodes, TaxiPath and TaxiPathNode rows.
pub struct TaxiTables<'a> {
	pub nodes: &'a Rows,
	pub paths: &'a Rows,
	pub points: &'a Rows,
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

/// Rows by ID, ascending.
fn by_id(rows: &Rows) -> Vec<&Row> {
	let mut out: Vec<&Row> = rows.iter().collect();
	out.sort_by(|a, b| by_num(num(a, "ID").unwrap_or(0.0), num(b, "ID").unwrap_or(0.0)));
	out
}

/// What a TaxiNodes row is placed by: the Era frames (`frames`, which tell an Era-frame map from a
/// map Forever added), the continents' maps, the flight masters with their spawns, the live frames.
struct Placer<'a> {
	frames: &'a Frames,
	continents: FxHashMap<i64, i64>,
	masters: Vec<(V, Vec<SpawnPt>)>,
	live: &'a LiveFrames,
}

impl Placer<'_> {
	/// The row as a node on a map of `on`, its flight master the nearest one within NPC_MATCH_YARDS:
	/// a node shown on a faction's flight map with a character bit, or a class's own node; else None
	/// (with a warning when the row was such a node but no map holds it).
	fn node(&self, r: &Row, on: &Frames, warnings: &mut Vec<String>) -> Option<Node> {
		let id = num(r, "ID").filter(|&n| n != 0.0)?;
		let flags = num(r, "Flags").unwrap_or(0.0);
		let faction = crate::jsv::to_int32(flags) & 3;
		let class = CLASS_NODES.iter().find(|(n, _)| *n == id as i64).map(|(_, c)| *c);
		if faction == 0 || !(num(r, "CharacterBitNumber").is_some_and(|n| n > 0.0) || class.is_some()) {
			return None;
		}
		let c = num(r, "ContinentID").unwrap_or(f64::NAN);
		let wx = num(r, "Pos_0").unwrap_or(f64::NAN);
		let wy = num(r, "Pos_1").unwrap_or(f64::NAN);
		let name = r.get("Name_lang").map(|s| s.trim().to_string()).unwrap_or_default();
		let id_s = forge_guide::js::num_str(id);
		if !(c.fract() == 0.0 && self.continents.contains_key(&(c as i64))) {
			warnings.push(format!("taxi node {id_s} \"{name}\": continent {} has no map frame, skipped", forge_guide::js::num_str(c)));
			return None;
		}
		// The flight master standing at this node: (npc, d).
		let mut matched: Option<(&V, f64)> = None;
		for (npc, pts) in &self.masters {
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
		let maps = matched.map(|(npc, _)| npc_maps_at(npc, self.frames, self.live, c, wx, wy)).unwrap_or_default();
		let Some(place) = place_point(on, c, wx, wy, &maps, &name) else {
			warnings.push(format!("taxi node {id_s} \"{name}\": no zone map holds ({}, {}), skipped", forge_guide::js::num_str(round(wx, 1)), forge_guide::js::num_str(round(wy, 1))));
			return None;
		};
		if matched.is_none() {
			warnings.push(format!("taxi node {id_s} \"{name}\": no flight master NPC within {} yd", NPC_MATCH_YARDS));
		}
		Some(Node {
			id,
			short: short_name(&name),
			name,
			c,
			wx: round(wx, 1),
			wy: round(wy, 1),
			map: place.map,
			x: place.x,
			y: place.y,
			f: if self.frames.frame(place.map).is_some() { "e" } else { "l" },
			faction,
			npc: matched.map(|(npc, _)| (npc.get("id").num(), npc.get("name").to_js_string())),
			class,
		})
	}
}

/// The flight network: the Classic Era client's nodes and flights (`era`) as they are, and with
/// `forever` the flight points the WoW Forever client adds: its TaxiNodes rows the Era table lacks,
/// kept by the same rule and none the client retired, with its TaxiPath flights to or from one along
/// its TaxiPathNode points (the flights between Era nodes stay Era's). Era nodes are placed on
/// `frames`, Forever's on `placing` (`frames`, and the live frame of a map Forever added).
pub fn build_taxi(era: &TaxiTables, forever: Option<&TaxiTables>, frames: &Frames, placing: &Frames, npcs: &V, live: &LiveFrames) -> Taxi {
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
	let placer = Placer { frames, continents: frames.continents(), masters, live };

	let mut nodes: Vec<Node> = Vec::new();
	let mut by_node: FxHashMap<i64, usize> = FxHashMap::default();
	for r in by_id(era.nodes) {
		if let Some(n) = placer.node(r, frames, &mut warnings) {
			by_node.insert(n.id as i64, nodes.len());
			nodes.push(n);
		}
	}
	let mut added: FxHashSet<i64> = FxHashSet::default();
	if let Some(fv) = forever {
		let era_ids: FxHashSet<i64> = era.nodes.iter().filter_map(|r| num(r, "ID")).map(|n| n as i64).collect();
		for r in by_id(fv.nodes) {
			let id = num(r, "ID").unwrap_or(0.0) as i64;
			if era_ids.contains(&id) || r.get("Name_lang").is_some_and(|n| n.trim_start().starts_with(RETIRED)) {
				continue;
			}
			if let Some(n) = placer.node(r, placing, &mut warnings) {
				added.insert(id);
				by_node.insert(id, nodes.len());
				nodes.push(n);
			}
		}
	}

	let mut legs: Vec<Leg> = Vec::new();
	add_legs(era, &nodes, &by_node, |_, _| true, &mut legs, &mut warnings);
	if let Some(fv) = forever {
		add_legs(fv, &nodes, &by_node, |a, b| added.contains(&(a.id as i64)) || added.contains(&(b.id as i64)), &mut legs, &mut warnings);
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

/// `t`'s flights between two different `nodes` that `keep(from, to)` takes, each along its
/// TaxiPathNode points (a straight line when it has none or a teleport), onto `legs`.
fn add_legs(t: &TaxiTables, nodes: &[Node], by_node: &FxHashMap<i64, usize>, keep: impl Fn(&Node, &Node) -> bool, legs: &mut Vec<Leg>, warnings: &mut Vec<String>) {
	let node_at = |r: &Row, col: &str| num(r, col).and_then(|n| if n.fract() == 0.0 { by_node.get(&(n as i64)).copied() } else { None });
	let flights: Vec<(&Row, usize, usize)> = by_id(t.paths)
		.into_iter()
		.filter_map(|r| {
			let (fi, ti) = (node_at(r, "FromTaxiNode")?, node_at(r, "ToTaxiNode")?);
			(fi != ti && keep(&nodes[fi], &nodes[ti])).then_some((r, fi, ti))
		})
		.collect();
	let wanted: FxHashSet<i64> = flights.iter().filter_map(|(r, _, _)| num(r, "ID")).map(|p| p as i64).collect();
	let points = path_points_where(t.points, |p| wanted.contains(&p));
	let empty = Vec::new();
	for (r, fi, ti) in flights {
		let (from, to) = (&nodes[fi], &nodes[ti]);
		let pid = num(r, "ID");
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

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn the_druids_nighthaven_nodes_are_kept_for_druids_alone() {
		// TaxiNodes 62/63 have no character bit; the client's paths fly Druids out of Moonglade only.
		let row = |kv: &[(&str, &str)]| -> Row { kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect() };
		let node = |id: &str, name: &str, x: &str, bit: &str, flags: &str| {
			row(&[("ID", id), ("Name_lang", name), ("Pos_0", x), ("Pos_1", "0"), ("ContinentID", "1"), ("Flags", flags), ("CharacterBitNumber", bit)])
		};
		let nodes = vec![node("63", "Nighthaven, Moonglade", "100", "0", "2"), node("22", "Thunder Bluff, Mulgore", "-100", "22", "2"), node("99", "Hidden, Nowhere", "50", "0", "2")];
		let paths = vec![row(&[("ID", "316"), ("FromTaxiNode", "63"), ("ToTaxiNode", "22"), ("Cost", "0")])];
		let era = forge_guide::js::parse_json(r#"{"1414":{"c":1,"left":5000,"right":-5000,"top":5000,"bottom":-5000},"1450":{"c":1,"left":1000,"right":-1000,"top":1000,"bottom":-1000}}"#).unwrap();
		let zones = forge_guide::js::parse_json(r#"{"1414":{"id":1414,"name":"Kalimdor","type":2},"1450":{"id":1450,"name":"Moonglade","type":3}}"#).unwrap();
		let frames = Frames::new(&era, &zones);
		let none = Vec::new();
		let taxi = build_taxi(&TaxiTables { nodes: &nodes, paths: &paths, points: &none }, None, &frames, &frames, &V::obj(), &LiveFrames::default());
		let class_of = |id: f64| taxi.nodes.iter().find(|n| n.id == id).map(|n| n.class);
		assert_eq!(class_of(63.0), Some(Some("DRUID")), "{:?}", taxi.warnings);
		assert_eq!(class_of(22.0), Some(None));
		assert_eq!(class_of(99.0), None, "another node with no character bit stays out");
		assert!(taxi.legs.iter().any(|l| l.from == 63.0 && l.to == 22.0));
	}

	#[test]
	fn the_forever_client_s_own_flight_points_join_the_era_network_which_stays_as_it_is() {
		let row = |kv: &[(&str, &str)]| -> Row { kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect() };
		let node = |id: &str, name: &str, wx: &str, wy: &str, flags: &str, bit: &str| {
			row(&[("ID", id), ("Name_lang", name), ("Pos_0", wx), ("Pos_1", wy), ("ContinentID", "0"), ("Flags", flags), ("CharacterBitNumber", bit)])
		};
		let path = |id: &str, from: &str, to: &str| row(&[("ID", id), ("FromTaxiNode", from), ("ToTaxiNode", to), ("Cost", "630")]);
		let point =
			|path: &str, i: &str, wx: &str, wy: &str| row(&[("PathID", path), ("NodeIndex", i), ("ContinentID", "0"), ("Loc_0", wx), ("Loc_1", wy), ("Loc_2", "0"), ("Flags", "0"), ("Delay", "0")]);
		// The Era client: Lakeshire and Morgan's Vigil, a flight each way (1179 and 1462 yards).
		let era_nodes = vec![node("5", "Lakeshire, Redridge", "-9429.1", "-2231.4", "1", "5"), node("71", "Morgan's Vigil, Burning Steppes", "-8364.6", "-2738.4", "1", "71")];
		let era_paths = vec![path("100", "5", "71"), path("101", "71", "5")];
		let era_points = vec![
			point("100", "0", "-9429.1", "-2231.4"),
			point("100", "1", "-8364.6", "-2738.4"),
			point("101", "0", "-8364.6", "-2738.4"),
			point("101", "1", "-9000", "-2000"),
			point("101", "2", "-9429.1", "-2231.4"),
		];
		// Forever's: the same two, Lakeshire moved and flown to on another track, a shorter flight of its own
		// between them; Farholde Keep on the Riverglades (no Era frame) with a flight each way to Lakeshire;
		// Powderfuse Port on no faction's flight map; a row the client retired.
		let fv_nodes = vec![
			node("5", "Lakeshire, Redridge", "-9400", "-2200", "1025", "5"),
			node("71", "Morgan's Vigil, Burning Steppes", "-8364.6", "-2738.4", "1025", "71"),
			node("3207", "zzOLDRiverglades, Farholde Keep", "-9104.1", "-4830.5", "1025", "15"),
			node("3275", "Powderfuse Port, Riverglades", "-8180.1", "-5616.3", "1024", "50"),
			node("3276", "Farholde Keep, Riverglades", "-9104.1", "-4830.5", "1025", "51"),
		];
		let fv_paths = vec![path("100", "5", "71"), path("101", "71", "5"), path("11582", "3275", "3276"), path("11584", "3276", "5"), path("11585", "5", "3276"), path("11590", "71", "5")];
		let fv_points = vec![
			point("100", "0", "-9400", "-2200"),
			point("100", "1", "-8364.6", "-2738.4"),
			point("101", "0", "-8364.6", "-2738.4"),
			point("101", "1", "-9429.1", "-2231.4"),
			point("11584", "0", "-9104.1", "-4830.5"),
			point("11584", "1", "-9429.1", "-2231.4"),
			point("11585", "0", "-9429.1", "-2231.4"),
			point("11585", "1", "-9104.1", "-4830.5"),
			point("11590", "0", "-8364.6", "-2738.4"),
			point("11590", "1", "-9429.1", "-2231.4"),
		];
		let era = forge_guide::js::parse_json(
			r#"{"1415":{"c":0,"left":16000,"right":-19199.9,"top":7466.6,"bottom":-16000},"1428":{"c":0,"left":-266.667,"right":-3195.833,"top":-7031.25,"bottom":-8983.333},"1433":{"c":0,"left":-1681.25,"right":-3852.084,"top":-8575,"bottom":-10022.916}}"#,
		)
		.unwrap();
		let forever = forge_guide::js::parse_json(r#"{"2548":{"c":0,"left":-1891.666,"right":-6741.666,"top":-6466.666,"bottom":-9700}}"#).unwrap();
		let zones = forge_guide::js::parse_json(
			r#"{"1415":{"id":1415,"name":"Eastern Kingdoms","type":2},"1428":{"id":1428,"name":"Burning Steppes","type":3},"1433":{"id":1433,"name":"Redridge Mountains","type":3},"2548":{"id":2548,"name":"Riverglades","type":3}}"#,
		)
		.unwrap();
		let npcs =
			forge_guide::js::parse_json(r#"{"257087":{"id":257087,"name":"Gretchen Mayberry","faction":"A","roles":["flightmaster"],"spawns":{"2548":{"f":"l","pts":[[60.62,81.49]]}}}}"#).unwrap();
		let frames = Frames::new(&era, &zones);
		let placing = frames.with_forever(&forever);
		let live: LiveFrames = [(2548, Frame::of(&forever.get("2548")))].into_iter().collect();
		let era_t = TaxiTables { nodes: &era_nodes, paths: &era_paths, points: &era_points };
		let fv_t = TaxiTables { nodes: &fv_nodes, paths: &fv_paths, points: &fv_points };
		let legs_of = |t: &Taxi| t.legs.iter().map(|l| (l.from as i64, l.to as i64, l.yards)).collect::<Vec<_>>();

		let alone = build_taxi(&era_t, None, &frames, &placing, &npcs, &live);
		let both = build_taxi(&era_t, Some(&fv_t), &frames, &placing, &npcs, &live);
		assert_eq!(alone.nodes.iter().map(|n| n.id).collect::<Vec<_>>(), [5.0, 71.0]);
		assert_eq!(legs_of(&alone), [(5, 71, 1179.0), (71, 5, 1462.0)]);
		assert_eq!(both.nodes.iter().map(|n| n.id).collect::<Vec<_>>(), [5.0, 71.0, 3276.0], "neither the retired row nor Powderfuse Port: {:?}", both.warnings);
		let lakeshire = &both.nodes[0];
		assert_eq!((lakeshire.wx, lakeshire.wy, lakeshire.map, lakeshire.f), (-9429.1, -2231.4, 1433, "e"), "the Era node where the Era client has it");
		let farholde = &both.nodes[2];
		assert_eq!((farholde.map, farholde.x, farholde.y, farholde.f, farholde.faction), (2548, 60.59, 81.57, "l", 1), "on the Riverglades' live frame");
		assert_eq!(farholde.npc, Some((257087.0, "Gretchen Mayberry".to_string())));
		assert_eq!(
			legs_of(&both),
			[(5, 71, 1179.0), (5, 3276, 2619.0), (71, 5, 1462.0), (3276, 5, 2619.0)],
			"Era's flights on Era's tracks, Forever's own flight between Era nodes left out, Farholde Keep's two added"
		);
		assert!(both.legs.iter().all(|l| l.track.is_some()));
		assert!(!both.warnings.iter().any(|w| w.contains("3276")), "{:?}", both.warnings);
	}
}
