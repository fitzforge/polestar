//! Port of tools/lib/dsl/farmspots.js.
//! Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, "Smart logic", Farm spots): where to
//! kill mobs that drop the item. spot = { map, x, y, f, faction, npc, npcName, lvl = { min, max }, rate, spawns };
//! `rate` is items per looted kill (the drop chance times `yield_of`). Clusters of fewer than MIN_SPAWNS go while
//! the continent has others; each zone keeps its best cluster per safety and 5-level band; MAX_PER_CONTINENT of
//! those per continent, round-robin over (safety, 10-level band).

use crate::cluster::cluster_points;
use crate::data::Data;
use crate::js::{cmp_utf16, hypot, math_round, num_str, V};
use crate::obj;
use std::cmp::Ordering;

pub const MIN_CHANCE: f64 = 2.0;
pub const TOWN_YARDS: f64 = 90.0;
const CLUSTER_YARDS: f64 = 70.0;
pub const MAX_PER_CONTINENT: usize = 32;
pub const MIN_SPAWNS: f64 = 3.0;
const BAND: f64 = 5.0;
const PER_NPC_MAP: f64 = 4.0;
const SERVICE_ROLES: [&str; 9] = ["vendor", "innkeeper", "repair", "flightmaster", "banker", "stablemaster", "auctioneer", "battlemaster", "spirithealer"];
/// Mobs whose kill costs reputation a player wants (Timbermaw furbolgs): never a farm spot.
pub const PROTECTED_MOBS: [f64; 13] = [6184.0, 6185.0, 6186.0, 6187.0, 6188.0, 6189.0, 6651.0, 11516.0, 11552.0, 11553.0, 11555.0, 11557.0, 11558.0];
/// A map's copy of an npc's spawns whose every point lies this close (yards) to another copy's is that spot seen over the border.
const DUP_YARDS: f64 = 30.0;

/// Items a looted kill yields per drop chance, from players' recordings (farmspots.js YIELD); 1 for any other item.
pub fn yield_of(item: f64) -> f64 {
	match item as i64 {
		769 => 0.77,
		2589 => 1.53,
		2592 => 1.54,
		2672 => 0.83,
		2673 => 0.78,
		2674 => 0.95,
		2677 => 0.61,
		3173 => 0.72,
		3685 => 0.43,
		3731 => 0.56,
		4306 => 1.56,
		4338 => 1.48,
		5469 => 0.73,
		5470 => 0.45,
		6889 => 0.97,
		12184 => 0.59,
		12207 => 0.81,
		14047 => 1.47,
		14227 => 2.2,
		_ => 1.0,
	}
}

fn round2(n: f64) -> f64 {
	let r = math_round(n * 100.0) / 100.0;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

fn round3(n: f64) -> f64 {
	math_round(n * 1000.0) / 1000.0
}

fn sign(d: f64) -> Ordering {
	if d < 0.0 {
		Ordering::Less
	} else if d > 0.0 {
		Ordering::Greater
	} else {
		Ordering::Equal
	}
}

fn is_service(roles: &V) -> bool {
	roles.is_arr() && roles.items().iter().any(|r| SERVICE_ROLES.iter().any(|s| r.as_str() == Some(*s)))
}

/// Zone safety for a map: "A" | "H" | "AH", or None (not farmable).
pub fn zone_safety(data: &Data, map: &V) -> Option<String> {
	if let Some(z) = crate::gathering::zone(map) {
		return Some(z.side.to_string());
	}
	let info = data.zone(map);
	let fr = data.frame(map);
	let c = fr.get("c");
	if info.truthy() && info.get("type").as_num() == Some(3.0) && fr.truthy() && (c.as_num() == Some(0.0) || c.as_num() == Some(1.0)) {
		Some("AH".into())
	} else {
		None
	}
}

/// Town markers per map (map key -> [{ x, y, npc, service }, ...]): every spawn of a faction-tagged or service npc,
/// with its npc id (a tagged mob that drops the item is a farm, not a town: see farm_spots_of).
fn town_points(data: &Data) -> V {
	if let Some(v) = data.memo.borrow().get("farmspots.towns") {
		return v.clone();
	}
	let by_map = V::obj();
	for n in data.npcs.values() {
		if !n.truthy() || !n.get("spawns").truthy() {
			continue;
		}
		let f = n.get("faction");
		let tagged = matches!(f.as_str(), Some("A" | "H" | "AH"));
		let service = is_service(&n.get("roles"));
		if !tagged && !service {
			continue;
		}
		let id = crate::js::str_to_num(&n.get("id").to_js_string());
		for s in data.spawns("npc", &n.get("id")) {
			let key = s.get("map").to_js_string();
			if !by_map.has(&key) {
				by_map.set(&key, V::arr());
			}
			let list = by_map.get(&key);
			for p in s.get("pts").items() {
				list.push(obj! { "x" => p.at(0).num(), "y" => p.at(1).num(), "npc" => id, "service" => service });
			}
		}
	}
	data.memo.borrow_mut().insert("farmspots.towns", by_map.clone());
	by_map
}

fn yard_scale(data: &Data, map: &V) -> (f64, f64) {
	let fr = data.frame(map);
	if !fr.truthy() {
		return (30.0, 20.0);
	}
	((fr.get("right").num() - fr.get("left").num()).abs() / 100.0, (fr.get("bottom").num() - fr.get("top").num()).abs() / 100.0)
}

/// The maps where an npc's spawns are only another map's spawns seen over the zone border (farmspots.js overlapMaps):
/// of two Era-frame copies on one continent whose points all lie within DUP_YARDS of the other's, the one nearer its
/// map's edge goes (the higher map id on a tie).
fn overlap_maps(data: &Data, spawns: &[V]) -> Vec<f64> {
	struct Copy {
		map: f64,
		c: V,
		world: Vec<(f64, f64)>,
		edge: f64,
	}
	let mut copies: Vec<Copy> = Vec::new();
	for s in spawns {
		let map = s.get("map");
		if s.get("f").as_str() != Some("e") {
			continue;
		}
		let fr = data.era_frame(&map);
		if !fr.truthy() {
			continue;
		}
		let mut pts = s.get("pts").items();
		pts.extend(s.get("more").items());
		let (top, bottom, left, right) = (fr.get("top").num(), fr.get("bottom").num(), fr.get("left").num(), fr.get("right").num());
		let world = pts.iter().map(|p| (top + (bottom - top) * p.at(1).num() / 100.0, left + (right - left) * p.at(0).num() / 100.0)).collect();
		let edge = pts.iter().map(|p| p.at(0).num().min(100.0 - p.at(0).num()).min(p.at(1).num()).min(100.0 - p.at(1).num())).fold(f64::NEG_INFINITY, f64::max);
		copies.push(Copy { map: map.num(), c: fr.get("c"), world, edge });
	}
	let mut out: Vec<f64> = Vec::new();
	for (i, a) in copies.iter().enumerate() {
		for (k, b) in copies.iter().enumerate() {
			if i == k || !a.c.strict_eq(&b.c) || out.contains(&b.map) {
				continue;
			}
			let nearer = a.edge < b.edge || (a.edge == b.edge && a.map > b.map);
			if nearer && a.world.iter().all(|p| b.world.iter().any(|q| hypot(p.0 - q.0, p.1 - q.1) <= DUP_YARDS)) {
				out.push(a.map);
				break;
			}
		}
	}
	out
}

/// `farmSpots(data, itemId)`: [spot] sorted by continent, then rate × spawns (best first), map, x, y.
/// Memoised per data and item (the item id keyed by type and value, like a JS Map).
pub fn farm_spots(data: &Data, item_id: &V) -> V {
	let key = match item_id {
		V::Num(n) => format!("n:{}", num_str(*n)),
		V::Str(s) => format!("s:{s}"),
		other => format!("o:{}", other.to_js_string()),
	};
	let by_item = data.memo.borrow().get("farmspots.spots").cloned();
	let by_item = match by_item {
		Some(v) => v,
		None => {
			let v = V::obj();
			data.memo.borrow_mut().insert("farmspots.spots", v.clone());
			v
		}
	};
	if !by_item.has(&key) {
		let spots = farm_spots_of(data, item_id);
		by_item.set(&key, spots);
	}
	by_item.get(&key)
}

struct Cand {
	spot: V,
	c: V,
	score: f64,
}

fn farm_spots_of(data: &Data, item_id: &V) -> V {
	let it = data.item(item_id);
	let drops = if it.truthy() && it.get("drops").truthy() && it.get("drops").get("npc").truthy() { it.get("drops").get("npc") } else { V::obj() };
	let yield_item = yield_of(crate::js::str_to_num(&item_id.to_js_string()));
	let towns = town_points(data);
	// The droppers (farmspots.js): normal or rare, no service, never a Timbermaw furbolg; an untagged mob is each
	// side's where the zone is safe for it, a mob tagged for one faction is the other side's, one tagged for both nobody's.
	struct Dropper {
		id: f64,
		npc: V,
		chance: f64,
		foe: &'static str,
	}
	let mut droppers: Vec<Dropper> = Vec::new();
	let mut ids: Vec<f64> = drops.keys().iter().map(|k| crate::js::str_to_num(k)).collect();
	ids.sort_by(|a, b| sign(a - b));
	for id in ids {
		let idv = V::Num(id);
		let ch = drops.get(&num_str(id)).num();
		let chance = if ch != 0.0 && !ch.is_nan() { ch } else { 0.0 };
		if chance < MIN_CHANCE {
			continue;
		}
		let npc = data.npc(&idv);
		if !npc.truthy() || PROTECTED_MOBS.contains(&id) {
			continue;
		}
		let rank = npc.get("rank");
		if !(rank.is_nullish() || rank.as_num() == Some(0.0) || rank.as_num() == Some(4.0)) {
			continue;
		}
		if is_service(&npc.get("roles")) {
			continue;
		}
		let f = npc.get("faction");
		let foe = match f.as_str() {
			Some("A") => "H",
			Some("H") => "A",
			_ if f.truthy() => continue,
			_ => "AH",
		};
		droppers.push(Dropper { id, npc, chance, foe });
	}
	let farmers: Vec<f64> = droppers.iter().map(|d| d.id).collect();
	struct Camp {
		d: usize,
		map: V,
		f: V,
		side: String,
		open: Vec<V>,
		lo: f64,
		hi: f64,
	}
	struct Member {
		x: f64,
		y: f64,
		rate: f64,
		lo: f64,
		hi: f64,
		npc: f64,
		name: String,
	}
	let mut camps: Vec<Camp> = Vec::new();
	let mut by_map_side: Vec<(String, Vec<Member>)> = Vec::new();
	for (di, d) in droppers.iter().enumerate() {
		let spawns = data.spawns("npc", &V::Num(d.id));
		let seen_over = overlap_maps(data, &spawns);
		for s in spawns {
			let map = s.get("map");
			if seen_over.contains(&map.num()) {
				continue;
			}
			let Some(zone) = zone_safety(data, &map) else { continue };
			let side = if d.foe == "AH" {
				zone.clone()
			} else if zone == "AH" || zone == d.foe {
				d.foe.to_string()
			} else {
				continue;
			};
			let (sx, sy) = yard_scale(data, &map);
			let markers: Vec<V> = towns.get(&map.to_js_string()).items().into_iter().filter(|m| m.get("service").truthy() || !farmers.contains(&m.get("npc").num())).collect();
			let mut pts = s.get("pts").items();
			pts.extend(s.get("more").items());
			let open: Vec<V> = pts.into_iter().filter(|p| !markers.iter().any(|m| hypot((p.at(0).num() - m.get("x").num()) * sx, (p.at(1).num() - m.get("y").num()) * sy) <= TOWN_YARDS)).collect();
			if open.is_empty() {
				continue;
			}
			let l = d.npc.get("level").num();
			let lo = if l != 0.0 && !l.is_nan() { l } else { 1.0 };
			let lm = d.npc.get("levelMax").num();
			let lm = if lm != 0.0 && !lm.is_nan() { lm } else { lo };
			let hi = if lm.is_nan() { lm } else { lo.max(lm) };
			let key = format!("{}|{}", map.to_js_string(), side);
			let rate = (d.chance / 100.0) * yield_item;
			let at = match by_map_side.iter().position(|e| e.0 == key) {
				Some(i) => i,
				None => {
					by_map_side.push((key, Vec::new()));
					by_map_side.len() - 1
				}
			};
			for p in &open {
				by_map_side[at].1.push(Member { x: p.at(0).num(), y: p.at(1).num(), rate, lo, hi, npc: d.id, name: d.npc.get("name").to_js_string() });
			}
			camps.push(Camp { d: di, map: map.clone(), f: s.get("f"), side, open, lo, hi });
		}
	}
	let mut all: Vec<Cand> = Vec::new();
	for k in &camps {
		let d = &droppers[k.d];
		let fr = data.frame(&k.map);
		let (sx, sy) = yard_scale(data, &k.map);
		let era = k.f.as_str() == Some("e") && (data.era_frame(&k.map).truthy() || data.map_frames.get("era").keys().is_empty());
		let key = format!("{}|{}", k.map.to_js_string(), k.side);
		let pool = &by_map_side.iter().find(|e| e.0 == key).unwrap().1;
		for c in cluster_points(&k.open, &fr, CLUSTER_YARDS, PER_NPC_MAP, 0.0) {
			let (cx, cy) = (c.get("x").num(), c.get("y").num());
			let members: Vec<&Member> = pool.iter().filter(|m| hypot((m.x - cx) * sx, (m.y - cy) * sy) <= CLUSTER_YARDS).collect();
			let spot = obj! { "map" => k.map.clone(), "x" => round2(cx), "y" => round2(cy) };
			if era {
				spot.set("f", "e");
			}
			spot.set("faction", k.side.as_str());
			// Named for the kind most of the camp is (the lowest id on a tie; first-seen order as a JS Map).
			let mut kinds: Vec<(f64, usize)> = Vec::new();
			for m in &members {
				match kinds.iter_mut().find(|e| e.0 == m.npc) {
					Some(e) => e.1 += 1,
					None => kinds.push((m.npc, 1)),
				}
			}
			let count = |id: f64, kinds: &Vec<(f64, usize)>| kinds.iter().find(|e| e.0 == id).map_or(0, |e| e.1);
			let mut main = d.id;
			for &(id, n) in &kinds {
				let cur = count(main, &kinds);
				if n > cur || (n == cur && id < main) {
					main = id;
				}
			}
			spot.set("npc", main);
			let name = if main == d.id { d.npc.get("name").to_js_string() } else { members.iter().find(|m| m.npc == main).unwrap().name.clone() };
			spot.set("npcName", name);
			let lo = members.iter().fold(k.lo, |a, m| a.min(m.lo));
			let hi = members.iter().fold(k.hi, |a, m| a.max(m.hi));
			spot.set("lvl", obj! { "min" => lo, "max" => hi });
			let rate = if members.is_empty() { round3((d.chance / 100.0) * yield_item) } else { round3(members.iter().fold(0.0, |a, m| a + m.rate) / members.len() as f64) };
			spot.set("rate", rate);
			let n = c.get("n").num().max(members.len() as f64);
			spot.set("spawns", n);
			all.push(Cand { spot: spot.into(), c: if fr.truthy() { fr.get("c") } else { V::Null }, score: rate * n });
		}
	}
	let mut by_continent: Vec<(V, Vec<usize>)> = Vec::new();
	for (i, a) in all.iter().enumerate() {
		match by_continent.iter_mut().find(|(c, _)| c.strict_eq(&a.c)) {
			Some(e) => e.1.push(i),
			None => by_continent.push((a.c.clone(), vec![i])),
		}
	}
	let order = |a: &usize, b: &usize| -> Ordering {
		let (a, b) = (&all[*a], &all[*b]);
		let f = |k: &str| a.spot.get(k).num() - b.spot.get(k).num();
		let chain = [b.score - a.score, f("map"), f("x"), f("y")];
		for d in chain {
			if d != 0.0 && !d.is_nan() {
				return sign(d);
			}
		}
		Ordering::Equal
	};
	by_continent.sort_by(|(a, _), (b, _)| {
		if matches!(a, V::Null) {
			Ordering::Greater
		} else if matches!(b, V::Null) {
			Ordering::Less
		} else {
			sign(a.num() - b.num())
		}
	});
	let out = V::arr();
	for (_, members) in by_continent {
		let members: Vec<usize> =
			if members.iter().any(|i| all[*i].spot.get("spawns").num() >= MIN_SPAWNS) { members.into_iter().filter(|i| all[*i].spot.get("spawns").num() >= MIN_SPAWNS).collect() } else { members };
		// Each zone's best camp per safety and level band (first-seen key order, as a JS Map).
		let mut best: Vec<(String, usize)> = Vec::new();
		for i in members {
			let s = &all[i].spot;
			let key = format!("{}|{}|{}", s.get("faction").to_js_string(), s.get("map").to_js_string(), num_str((s.get("lvl").get("min").num() / BAND).floor()));
			match best.iter_mut().find(|b| b.0 == key) {
				Some(b) => {
					if order(&i, &b.1) == Ordering::Less {
						b.1 = i;
					}
				}
				None => best.push((key, i)),
			}
		}
		let mut groups: Vec<(String, Vec<usize>)> = Vec::new();
		for (_, i) in best {
			let s = &all[i].spot;
			let key = format!("{}|{}", s.get("faction").to_js_string(), num_str((s.get("lvl").get("min").num() / 10.0).floor()));
			match groups.iter_mut().find(|g| g.0 == key) {
				Some(g) => g.1.push(i),
				None => groups.push((key, vec![i])),
			}
		}
		groups.sort_by(|a, b| cmp_utf16(&a.0, &b.0));
		let lists: Vec<Vec<usize>> = groups
			.into_iter()
			.map(|(_, mut l)| {
				l.sort_by(order);
				l
			})
			.collect();
		let mut kept: Vec<usize> = Vec::new();
		let mut round = 0;
		while kept.len() < MAX_PER_CONTINENT {
			let mut layer: Vec<usize> = lists.iter().filter_map(|l| l.get(round).copied()).collect();
			layer.sort_by(order);
			if layer.is_empty() {
				break;
			}
			let room = MAX_PER_CONTINENT - kept.len();
			kept.extend(layer.into_iter().take(room));
			round += 1;
		}
		kept.sort_by(order);
		for i in kept {
			out.push(all[i].spot.clone());
		}
	}
	out
}
