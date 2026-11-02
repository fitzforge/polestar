//! World positions (continent, world yards) -> our per-map spawn points (map percent): the knowledge
//! base's sniffed spawns (kb.rs) and the release build's sniffed gathering nodes
//! ([`add_gathering_nodes`]) place a TDB row on the entity's own map when it lies inside it, else on
//! the smallest zone map that holds it.

use forge_guide::js::{num_str, str_to_num, Obj, V};
use rustc_hash::FxHashSet;

use crate::jsv::{hypot, math_round, nums};

/// A sniffed node spawn within this of one we have is that one (yards). Nodes of a kind can stand a
/// few dozen yards apart (herbs along a stream), so it is tighter than the knowledge base's 40.
pub const NODE_SAME_YD: f64 = 10.0;

pub struct Placer {
	era: V,
	fv: V,
	/// (map id, frame kind "e"/"l", frame, area), smallest first.
	zone_maps: Vec<(String, &'static str, V, f64)>,
}

fn to_pct(b: &V, wx: f64, wy: f64) -> [f64; 2] {
	let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
	[math_round(((wy - left) / (right - left)) * 1e4) / 100.0, math_round(((wx - top) / (bottom - top)) * 1e4) / 100.0]
}

fn inside(p: &[f64; 2]) -> bool {
	(0.0..=100.0).contains(&p[0]) && (0.0..=100.0).contains(&p[1])
}

impl Placer {
	/// `frames`: { era, forever } frame sets (map-frames.json); `zones`: zones.json; `live`: the maps
	/// whose Forever frame replaces the Era one.
	pub fn new(frames: &V, zones: &Obj, live: &FxHashSet<i64>) -> Placer {
		let era = frames.get("era");
		let fv = frames.get("forever");
		let mut zone_maps: Vec<(String, &'static str, V, f64)> = Vec::new();
		for (set, f) in [("era", "e"), ("forever", "l")] {
			for (id, b) in frames.get(set).entries() {
				let z = zones.get(&id);
				let (dl, dt) = ((b.get("right").num() - b.get("left").num()).abs(), (b.get("bottom").num() - b.get("top").num()).abs());
				// A system map (UiMap System, e.g. 2665 beside Zephras Isle 2521) is no map a player opens.
				if !z.truthy() || z.get("type").num() != 3.0 || z.get("system").truthy() || dl < 1.0 || dt < 1.0 {
					continue;
				}
				let is_live = live.contains(&(str_to_num(&id) as i64));
				if f == "l" && era.get(&id).truthy() && !is_live {
					continue;
				}
				if f == "e" && is_live && fv.get(&id).truthy() {
					continue;
				}
				let area = ((b.get("right").num() - b.get("left").num()) * (b.get("bottom").num() - b.get("top").num())).abs();
				zone_maps.push((id.to_string(), f, b, area));
			}
		}
		zone_maps.sort_by(|a, b| a.3.partial_cmp(&b.3).unwrap().then(str_to_num(&a.0).partial_cmp(&str_to_num(&b.0)).unwrap()));
		Placer { era, fv, zone_maps }
	}

	fn frame_of(&self, map: &str, f: &str) -> Option<V> {
		let x = self.fv.get(map);
		if f == "l" && x.truthy() {
			return Some(x);
		}
		let e = self.era.get(map);
		if e.truthy() {
			return Some(e);
		}
		x.truthy().then_some(x)
	}

	/// A map point -> (continent, world x, world y).
	pub fn to_world(&self, map: &str, x: f64, y: f64, f: &str) -> Option<(f64, f64, f64)> {
		let b = self.frame_of(map, f)?;
		let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
		Some((b.get("c").num(), top + ((bottom - top) * y) / 100.0, left + ((right - left) * x) / 100.0))
	}

	/// Every spawn point of an entity (`pts` and `more`) in world yards.
	pub fn our_points(&self, ent: &V) -> Vec<(f64, f64, f64)> {
		let mut out = Vec::new();
		for (map, sp) in ent.get("spawns").entries() {
			let f = sp.get("f").to_js_string();
			for p in sp.get("pts").items().into_iter().chain(sp.get("more").items()) {
				if let Some(w) = self.to_world(&map, p.num_at(0), p.num_at(1), &f) {
					out.push(w);
				}
			}
		}
		out
	}

	/// Adds a TDB row (`[continent, wx, wy, ...]`) to the entity's spawns: on a map it already has
	/// that holds the point (to `pts` up to 24, then `more`), else on the smallest zone map holding
	/// it. 1 when placed, 0 when no map holds it.
	pub fn place(&self, ent: &V, row: &V) -> f64 {
		let (c, wx, wy) = (row.num_at(0), row.num_at(1), row.num_at(2));
		for (map, sp) in ent.get("spawns").entries() {
			let Some(b) = self.frame_of(&map, &sp.get("f").to_js_string()) else { continue };
			if b.get("c").num() != c {
				continue;
			}
			let p = to_pct(&b, wx, wy);
			if inside(&p) {
				if sp.get("pts").len() < 24 {
					sp.get("pts").push(nums(&p));
				} else {
					if !sp.get("more").truthy() {
						sp.set("more", V::arr());
					}
					sp.get("more").push(nums(&p));
				}
				return 1.0;
			}
		}
		for (zid, zf, zb, _) in &self.zone_maps {
			if zb.get("c").num() != c {
				continue;
			}
			let p = to_pct(zb, wx, wy);
			if !inside(&p) {
				continue;
			}
			let cur = ent.get("spawns");
			let mut recs: Vec<f64> = cur.keys().iter().map(|k| str_to_num(k)).collect();
			recs.push(str_to_num(zid));
			recs.sort_by(|a, b| a.partial_cmp(b).unwrap());
			let spawns = Obj::new();
			for k in recs {
				let ks = num_str(k);
				let e = cur.get(&ks);
				spawns.set(
					&ks,
					if e.truthy() {
						e
					} else {
						let o = Obj::new();
						o.set("f", *zf);
						o.set("pts", V::arr());
						V::Obj(o)
					},
				);
			}
			ent.set("spawns", spawns);
			ent.get("spawns").get(zid).get("pts").push(nums(&p));
			return 1.0;
		}
		0.0
	}
}

/// Whether a TDB row lies within `yd` of one of `pts` on its continent.
pub fn near(pts: &[(f64, f64, f64)], row: &V, yd: f64) -> bool {
	pts.iter().any(|w| w.0 == row.num_at(0) && hypot(w.1 - row.num_at(1), w.2 - row.num_at(2)) <= yd)
}

/// Gathering nodes (objects with the `herb`, `mine` or `fishing` role) gain the TDB's sniffed spawns
/// our sources lack: the nodes of Forever's new zones (Zephras Isle) and the ones Forever moved.
/// Add-only: a sniff covers a few maps, so a node it does not show is not gone. Returns the number
/// of spawns added.
pub fn add_gathering_nodes(objects: &Obj, tdb: &V, placer: &Placer) -> usize {
	let mut added = 0usize;
	for (id, rows) in tdb.get("spawns").get("object").entries() {
		let ent = objects.get(&id);
		if !ent.truthy() || !ent.get("roles").items().iter().any(|r| matches!(r.as_str(), Some("herb" | "mine" | "fishing"))) {
			continue;
		}
		if !ent.get("spawns").truthy() {
			ent.set("spawns", Obj::new());
		}
		let mut ours = placer.our_points(&ent);
		for row in rows.items() {
			if near(&ours, &row, NODE_SAME_YD) {
				continue;
			}
			if placer.place(&ent, &row) > 0.0 {
				added += 1;
				ours.push((row.num_at(0), row.num_at(1), row.num_at(2)));
			}
		}
	}
	added
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::{parse_json, stringify};

	// One zone map 10 (continent 0, 1000 x 1000 yd) and its system twin 11.
	fn placer() -> Placer {
		let frames = parse_json(r#"{"era":{},"forever":{"10":{"c":0,"left":1000,"right":0,"top":1000,"bottom":0},"11":{"c":0,"left":1000,"right":0,"top":1000,"bottom":0.01}}}"#).unwrap();
		let zones = parse_json(r#"{"10":{"id":10,"type":3},"11":{"id":11,"type":3,"system":1}}"#).unwrap();
		let live: FxHashSet<i64> = [10, 11].into_iter().collect();
		Placer::new(&frames, zones.as_obj().unwrap(), &live)
	}

	#[test]
	fn sniffed_nodes_are_added_once_on_the_zone_map() {
		let objects = parse_json(r#"{"1":{"id":1,"name":"Peacebloom","roles":["herb"],"spawns":{"10":{"f":"l","pts":[[50,50]]}}},"2":{"id":2,"name":"Crate","spawns":{}}}"#).unwrap();
		// Map 10 point (50, 50) is world (500, 500); x north, y west.
		let tdb = parse_json(r#"{"spawns":{"object":{"1":[[0,500,505,0,120],[0,800,200,0,120],[0,801,201,0,120]],"2":[[0,300,300,0,120]],"3":[[0,100,100,0,120]]}}}"#).unwrap();
		let added = add_gathering_nodes(objects.as_obj().unwrap(), &tdb, &placer());
		// The spawn 5 yd from ours is ours; the far one is added; its neighbour 1.4 yd away is the same spawn.
		assert_eq!(added, 1);
		assert_eq!(stringify(&objects.get("1").get("spawns"), None), r#"{"10":{"f":"l","pts":[[50,50],[80,20]]}}"#);
		// Not a gathering node, or not in our objects: left alone.
		assert_eq!(stringify(&objects.get("2").get("spawns"), None), "{}");
	}

	#[test]
	fn a_node_without_our_spawns_goes_to_the_player_map_not_the_system_map() {
		let objects = parse_json(r#"{"1":{"id":1,"name":"Copper Vein","roles":["mine"]}}"#).unwrap();
		let tdb = parse_json(r#"{"spawns":{"object":{"1":[[0,250,750,0,120]]}}}"#).unwrap();
		assert_eq!(add_gathering_nodes(objects.as_obj().unwrap(), &tdb, &placer()), 1);
		assert_eq!(stringify(&objects.get("1").get("spawns"), None), r#"{"10":{"f":"l","pts":[[25,75]]}}"#);
	}
}
