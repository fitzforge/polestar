//! Port of tools/lib/dsl/places.js.
//! The location of `sethome`, `hearth`, `fly` and `getfp` against the places the game can report, the
//! place IDs (area, taxi node) of goals naming a place, and the innkeeper / flight master a location names.

use crate::areas::area_named;
use crate::candidates::{faction_tag, usable_by};
use crate::data::Data;
use crate::js::{cmp_utf16, V};
use crate::obj;

/// The part of a flight point's name before its first comma.
fn town(name: &V) -> String {
	let s = name.to_js_string();
	s.split(',').next().unwrap_or("").to_string()
}

fn zone_of(data: &Data, map: &V) -> Option<String> {
	if map.is_nullish() {
		return None;
	}
	let z = data.zone(map);
	if z.truthy() && z.get("name").truthy() {
		Some(z.get("name").to_js_string())
	} else {
		None
	}
}

/// `set(names)`: { names (deduped, sorted), lower (lowercased names as keys) }.
fn set(names: Vec<Option<String>>) -> V {
	let mut list: Vec<String> = Vec::new();
	for n in names.into_iter().flatten() {
		if !n.is_empty() && !list.contains(&n) {
			list.push(n);
		}
	}
	list.sort_by(|a, b| cmp_utf16(a, b));
	let lower = V::obj();
	for n in &list {
		lower.set(&n.to_lowercase(), true);
	}
	let names: Vec<V> = list.iter().map(|n| V::str(n)).collect();
	obj! { "names" => names, "lower" => lower }.into()
}

/// verb -> { names, lower }, memoised per data (getfp's `lower` accepts a full name or a town).
fn places_of(data: &Data) -> V {
	if let Some(v) = data.memo.borrow().get("places") {
		return v.clone();
	}
	let inns = data.inns().items();
	let nodes = data.flight_nodes().items();
	let mut inn_names: Vec<String> = Vec::new();
	for i in &inns {
		let names = i.get("names");
		let list = if names.is_arr() && !names.is_empty() { names.items() } else { vec![i.get("location")] };
		inn_names.extend(list.iter().map(|n| n.to_js_string()));
	}
	let some = |v: &[String]| v.iter().cloned().map(Some).collect::<Vec<_>>();
	let out = V::obj();
	if !inns.is_empty() {
		out.set("sethome", set(some(&inn_names)));
		let mut h = some(&inn_names);
		h.extend(inns.iter().map(|i| zone_of(data, &i.get("map"))));
		out.set("hearth", set(h));
	}
	if !nodes.is_empty() {
		let mut f: Vec<Option<String>> = nodes.iter().map(|n| Some(town(&n.get("name")))).collect();
		f.extend(some(&inn_names));
		f.extend(nodes.iter().map(|n| zone_of(data, &n.get("map"))));
		out.set("fly", set(f));
		let full = set(nodes.iter().map(|n| Some(n.get("name").to_js_string())).collect());
		let towns = set(nodes.iter().map(|n| Some(town(&n.get("name")))).collect());
		let lower = V::obj();
		for k in full.get("lower").keys().into_iter().chain(towns.get("lower").keys()) {
			lower.set(&k, true);
		}
		out.set("getfp", obj! { "names" => towns.get("names"), "lower" => lower });
	}
	data.memo.borrow_mut().insert("places", out.clone());
	out
}

/// Levenshtein distance over UTF-16 code units.
fn distance(a: &[u16], b: &[u16]) -> usize {
	let mut prev: Vec<usize> = (0..=b.len()).collect();
	for i in 1..=a.len() {
		let mut row = vec![i; b.len() + 1];
		for j in 1..=b.len() {
			row[j] = (prev[j] + 1).min(row[j - 1] + 1).min(prev[j - 1] + if a[i - 1] == b[j - 1] { 0 } else { 1 });
		}
		prev = row;
	}
	prev[b.len()]
}

/// Up to three known names closest to `location`.
fn closest(location: &str, names: &[V]) -> Vec<String> {
	let want = location.to_lowercase();
	let w16: Vec<u16> = want.encode_utf16().collect();
	let mut scored: Vec<(String, f64)> = Vec::new();
	for name in names {
		let name = name.to_js_string();
		let n = name.to_lowercase();
		let n16: Vec<u16> = n.encode_utf16().collect();
		if n.contains(want.as_str()) || want.contains(n.as_str()) {
			scored.push((name, (n16.len() as f64 - w16.len() as f64).abs() / 100.0));
		} else {
			let d = distance(&w16, &n16);
			if d <= 2usize.max(w16.len() / 3) {
				scored.push((name, d as f64));
			}
		}
	}
	scored.sort_by(|a, b| {
		let d = a.1 - b.1;
		if d != 0.0 && !d.is_nan() {
			return if d < 0.0 { std::cmp::Ordering::Less } else { std::cmp::Ordering::Greater };
		}
		if cmp_utf16(&a.0, &b.0) == std::cmp::Ordering::Less {
			std::cmp::Ordering::Less
		} else {
			std::cmp::Ordering::Greater
		}
	});
	scored.into_iter().take(3).map(|s| s.0).collect()
}

fn what(verb: &str) -> (&'static str, &'static str) {
	match verb {
		"sethome" => ("no inn has that bind location", "inn"),
		"hearth" => ("no inn stands there (an inn's area or the zone it is in)", "inn"),
		"fly" => ("no flight point lands there (its town, an inn's area or the zone it is in)", "flight"),
		_ => ("no flight point has that name", "flight"),
	}
}

/// `checkLocation(data, verb, location)`: Null when the location can match (or there is no data for the
/// verb), else { message, hint } for the warning.
pub fn check_location(data: &Data, verb: &str, location: &V) -> V {
	let places = places_of(data).get(verb);
	if !places.truthy() {
		return V::Null;
	}
	let Some(location) = location.as_str() else { return V::Null };
	if places.get("lower").has(&location.to_lowercase()) {
		return V::Null;
	}
	let (why, kind) = what(verb);
	let near = closest(location, &places.get("names").items());
	let look_up = format!("`polestar find --kind {kind}` lists every {}", if kind == "inn" { "inn" } else { "flight point" });
	let hint = if near.is_empty() { look_up } else { format!("did you mean {}? ({look_up})", near.iter().map(|n| format!("\"{n}\"")).collect::<Vec<_>>().join(" or ")) };
	obj! { "message" => format!("{verb} \"{location}\": {why}; the game never reports that name, so the goal never checks off by itself"), "hint" => hint }.into()
}

const LOCATION_VERBS: [&str; 5] = ["sethome", "hearth", "fly", "getfp", "enter"];

fn side_mask(s: &V) -> i32 {
	match s.as_str() {
		Some("Alliance") => 1,
		Some("Horde") => 2,
		_ => 0,
	}
}

/// JS ToInt32.
fn to_int32(v: &V) -> i32 {
	let n = v.num();
	if !n.is_finite() {
		return 0;
	}
	(n.trunc().rem_euclid(4294967296.0) as u32) as i32
}

/// The name a goal's area is found by, or None.
pub fn place_name(goal: &V) -> Option<String> {
	let t = goal.get("t");
	if LOCATION_VERBS.iter().any(|v| t.as_str() == Some(*v)) {
		return goal.get("location").as_str().map(str::to_string);
	}
	if t.as_str() == Some("goto") {
		return goal.get("text").as_str().map(str::to_string);
	}
	None
}

/// A goal's area ID, or Undef.
pub fn goal_area(data: &Data, goal: &V) -> V {
	let Some(name) = place_name(goal) else { return V::Undef };
	if name.is_empty() || !data.areas.truthy() {
		return V::Undef;
	}
	let zone = if !goal.get("map").is_undef() { data.zone(&goal.get("map")) } else { V::Null };
	let zone_area = if zone.truthy() { zone.get("areaId") } else { zone };
	let area = area_named(&data.areas, &V::str(&name), &zone_area);
	if area.truthy() {
		area.get("id")
	} else {
		V::Undef
	}
}

/// A getfp's or fly's taxi node ID, or Undef. `sides`: array of "Alliance" / "Horde".
pub fn goal_node(data: &Data, goal: &V, sides: &V) -> V {
	let t = goal.get("t");
	let location = goal.get("location");
	if (t.as_str() != Some("getfp") && t.as_str() != Some("fly")) || !location.is_str() {
		return V::Undef;
	}
	let nodes = data.flight_nodes().items();
	if !goal.get("npc").is_undef() {
		let own: Vec<&V> = nodes.iter().filter(|n| n.get("npc").strict_eq(&goal.get("npc"))).collect();
		if own.len() == 1 {
			return own[0].get("id");
		}
	}
	let named = named_node(&nodes, location.as_str().unwrap(), sides);
	if named.truthy() {
		named.get("id")
	} else {
		V::Undef
	}
}

/// The one taxi node whose name or town is `location` and that serves every faction in `sides`, or Null.
fn named_node(nodes: &[V], location: &str, sides: &V) -> V {
	let want = location.trim().to_lowercase();
	let mask = sides.items().iter().fold(0, |m, s| m | side_mask(s));
	let named: Vec<&V> = nodes
		.iter()
		.filter(|n| {
			let full = n.get("name").to_js_string().to_lowercase();
			(full == want || town(&V::str(&full)) == want) && (to_int32(&n.get("faction")) & mask) == mask
		})
		.collect();
	if named.len() == 1 {
		named[0].clone()
	} else {
		V::Null
	}
}

fn npc_name_or_null(v: &V) -> V {
	let n = v.get("npcName");
	if n.truthy() {
		n
	} else {
		V::Null
	}
}

/// A getfp's flight master, or Null: { npc, npcName }.
pub fn goal_flight_master(data: &Data, location: &V, sides: &V) -> V {
	let Some(location) = location.as_str() else { return V::Null };
	let node = named_node(&data.flight_nodes().items(), location, sides);
	if node.truthy() && node.get("npc").num() > 0.0 {
		obj! { "npc" => node.get("npc").num(), "npcName" => npc_name_or_null(&node) }.into()
	} else {
		V::Null
	}
}

/// A sethome's innkeeper, or Null: { npc, npcName }.
pub fn goal_innkeeper(data: &Data, location: &V, sides: &V) -> V {
	let Some(location) = location.as_str() else { return V::Null };
	let want = location.trim().to_lowercase();
	let named: Vec<V> = data
		.inns()
		.items()
		.into_iter()
		.filter(|i| {
			if !(i.get("npc").num() > 0.0) {
				return false;
			}
			let names = i.get("names");
			let names = if names.is_arr() && !names.is_empty() { names.items() } else { vec![i.get("location")] };
			if !names.iter().any(|n| n.to_js_string().to_lowercase() == want) {
				return false;
			}
			let npc = data.npc(&i.get("npc"));
			let npc = if npc.truthy() { npc } else { obj! { "faction" => V::Null, "roles" => crate::arr!["innkeeper"] }.into() };
			let tag = faction_tag(&npc, &V::Undef);
			sides.items().iter().all(|s| usable_by(tag.as_deref(), s))
		})
		.collect();
	if named.len() == 1 {
		obj! { "npc" => named[0].get("npc").num(), "npcName" => npc_name_or_null(&named[0]) }.into()
	} else {
		V::Null
	}
}

/// -> { places, withArea, getfp, withNode }.
pub fn place_counts(guides: &[V]) -> V {
	let (mut places, mut with_area, mut getfp, mut with_node) = (0u32, 0u32, 0u32, 0u32);
	for g in guides {
		for step in g.get("steps").items() {
			for goal in step.get("goals").items() {
				if place_name(&goal).is_some() {
					places += 1;
					if !goal.get("area").is_undef() {
						with_area += 1;
					}
				}
				if goal.get("t").as_str() == Some("getfp") {
					getfp += 1;
					if !goal.get("node").is_undef() {
						with_node += 1;
					}
				}
			}
		}
	}
	obj! { "places" => places, "withArea" => with_area, "getfp" => getfp, "withNode" => with_node }.into()
}
