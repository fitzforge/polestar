//! Port of tools/lib/dsl/farmspots.js.
//! Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, "Smart logic", Farm spots): where to
//! kill mobs that drop the item. spot = { map, x, y, f, faction, npc, npcName, lvl = { min, max }, rate, spawns }.

use crate::cluster::cluster_points;
use crate::data::Data;
use crate::js::{cmp_utf16, hypot, math_round, num_str, V};
use crate::obj;
use std::cmp::Ordering;

pub const MIN_CHANCE: f64 = 2.0;
pub const TOWN_YARDS: f64 = 90.0;
const CLUSTER_YARDS: f64 = 70.0;
pub const MAX_PER_CONTINENT: usize = 16;
const PER_NPC_MAP: f64 = 4.0;
const SERVICE_ROLES: [&str; 9] = ["vendor", "innkeeper", "repair", "flightmaster", "banker", "stablemaster", "auctioneer", "battlemaster", "spirithealer"];

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

/// Town markers per map (map key -> [[x, y], ...]): every spawn of a faction-tagged or service npc.
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
		for s in data.spawns("npc", &n.get("id")) {
			let key = s.get("map").to_js_string();
			if !by_map.has(&key) {
				by_map.set(&key, V::arr());
			}
			let list = by_map.get(&key);
			for p in s.get("pts").items() {
				list.push(p);
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
	let towns = town_points(data);
	let mut all: Vec<Cand> = Vec::new();
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
		if !npc.truthy() {
			continue;
		}
		let rank = npc.get("rank");
		if !(rank.is_nullish() || rank.as_num() == Some(0.0) || rank.as_num() == Some(4.0)) {
			continue;
		}
		if npc.get("faction").truthy() {
			continue;
		}
		if is_service(&npc.get("roles")) {
			continue;
		}
		for s in data.spawns("npc", &idv) {
			let map = s.get("map");
			let Some(faction) = zone_safety(data, &map) else { continue };
			let (sx, sy) = yard_scale(data, &map);
			let markers = towns.get(&map.to_js_string()).items();
			let open: Vec<V> =
				s.get("pts").items().into_iter().filter(|p| !markers.iter().any(|m| hypot((p.at(0).num() - m.at(0).num()) * sx, (p.at(1).num() - m.at(1).num()) * sy) <= TOWN_YARDS)).collect();
			if open.is_empty() {
				continue;
			}
			let fr = data.frame(&map);
			let era = s.get("f").as_str() == Some("e") && (data.era_frame(&map).truthy() || data.map_frames.get("era").keys().is_empty());
			for c in cluster_points(&open, &fr, CLUSTER_YARDS, PER_NPC_MAP, 0.0) {
				let spot = obj! { "map" => map.clone(), "x" => round2(c.get("x").num()), "y" => round2(c.get("y").num()) };
				if era {
					spot.set("f", "e");
				}
				spot.set("faction", faction.as_str());
				spot.set("npc", id);
				spot.set("npcName", npc.get("name").to_js_string());
				let l = npc.get("level").num();
				let lo = if l != 0.0 && !l.is_nan() { l } else { 1.0 };
				let lm = npc.get("levelMax").num();
				let lm = if lm != 0.0 && !lm.is_nan() { lm } else { lo };
				let hi = if lm.is_nan() { lm } else { lo.max(lm) };
				spot.set("lvl", obj! { "min" => lo, "max" => hi });
				let rate = round3((chance / 100.0).min(1.0));
				spot.set("rate", rate);
				let n = c.get("n").num();
				spot.set("spawns", n);
				all.push(Cand { spot: spot.into(), c: if fr.truthy() { fr.get("c") } else { V::Null }, score: rate * n });
			}
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
		let mut groups: Vec<(String, Vec<usize>)> = Vec::new();
		for i in members {
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
