//! Raw pfQuest database -> the reference-data schema (port of tools/lib/data/normalize.js).
//! Coordinates are re-keyed from AreaTable zone ids to UiMapIDs in the Era frame ("e").

use forge_guide::js::{Obj, V};
use indexmap::IndexMap;
use rustc_hash::FxHashMap;

use crate::factions::{ALL_CLASSES, ALL_RACES};
use crate::jsv::{arr, is_int, nums, round2, strs, to_int32};
use crate::objectives::parse_count;
use crate::pfquest::{IdMap, Raw};
use crate::spawns::{era_spawns, SpawnOptions};

const NPC_ROLES: [(&str, &str); 10] = [
	("auctioneer", "auctioneer"),
	("banker", "banker"),
	("battlemaster", "battlemaster"),
	("flight", "flightmaster"),
	("innkeeper", "innkeeper"),
	("rares", "rare"),
	("repair", "repair"),
	("spirithealer", "spirithealer"),
	("stablemaster", "stablemaster"),
	("vendor", "vendor"),
];
const OBJECT_ROLES: [(&str, &str); 6] = [("chests", "chest"), ("fish", "fishing"), ("herbs", "herb"), ("mailbox", "mailbox"), ("meetingstone", "meetingstone"), ("mines", "mine")];

/// `ids(v)`: positive integers of an array, first occurrence kept.
pub fn ids(v: &V) -> Vec<f64> {
	let mut out: Vec<f64> = Vec::new();
	if !v.is_arr() {
		return out;
	}
	for x in v.items() {
		let n = x.num();
		if is_int(n) && n > 0.0 && !out.contains(&n) {
			out.push(n);
		}
	}
	out
}

pub fn mask(v: &V, all: i32) -> Option<f64> {
	let n = v.num();
	if !is_int(n) || n <= 0.0 || (to_int32(n) & all) == all {
		return None;
	}
	Some(n)
}

pub fn int_or_null(v: &V) -> Option<f64> {
	let n = v.num();
	(n.is_finite() && n != 0.0).then_some(n)
}

pub fn opt_v(n: Option<f64>) -> V {
	n.map(V::Num).unwrap_or(V::Null)
}

/// "n" or "a-b" -> (level, levelMax when it differs).
pub fn parse_level(v: &V) -> (Option<f64>, Option<f64>) {
	if v.is_nullish() {
		return (None, None);
	}
	let s = v.to_js_string();
	let t = s.trim_matches(|c: char| c.is_whitespace());
	let parts: Vec<&str> = t.splitn(2, '-').collect();
	let digits = |x: &str| {
		let x = x.trim_matches(|c: char| c.is_whitespace());
		(!x.is_empty() && x.bytes().all(|b| b.is_ascii_digit())).then(|| x.parse::<f64>().unwrap())
	};
	// /^\s*(\d+)(?:\s*-\s*(\d+))?\s*$/: no whitespace inside the numbers
	let ok_num = |x: &str| !x.trim_matches(|c: char| c.is_whitespace()).contains(char::is_whitespace);
	let (lo, hi) = match parts.as_slice() {
		[a] if ok_num(a) => match digits(a) {
			Some(lo) => (lo, lo),
			None => return (None, None),
		},
		[a, b] if ok_num(a) && ok_num(b) => match (digits(a), digits(b)) {
			(Some(lo), Some(hi)) => (lo, hi),
			_ => return (None, None),
		},
		_ => return (None, None),
	};
	(Some(lo), (hi != lo).then_some(hi))
}

fn faction(v: &V) -> V {
	match v.as_str() {
		Some(s @ ("A" | "H" | "AH")) => V::str(s),
		_ => V::Null,
	}
}

fn roles_from(raw: &Raw, table: &[(&'static str, &'static str)], id: i64, positive: bool) -> Vec<&'static str> {
	let mut cats: Vec<(&'static str, &'static str)> = table.to_vec();
	cats.sort_by(|a, b| a.0.cmp(b.0));
	cats.into_iter().filter(|(cat, _)| raw.meta.get(*cat).is_some_and(|m| m.contains_key(&if positive { id } else { -id }))).map(|(_, role)| role).collect()
}

/// The map with the most raw points; ties -> the lower UiMapID.
fn main_map(coords: &V, resolve: &dyn Fn(f64) -> Option<i64>) -> Option<i64> {
	let mut counts: IndexMap<i64, usize> = IndexMap::new();
	if coords.is_arr() {
		for c in coords.items() {
			if !c.is_arr() {
				continue;
			}
			if let Some(m) = resolve(c.num_at(2)) {
				*counts.entry(m).or_insert(0) += 1;
			}
		}
	}
	let (mut best, mut best_n) = (None, 0);
	for (m, n) in counts {
		if n > best_n || (n == best_n && best.is_some_and(|b| m < b)) {
			best = Some(m);
			best_n = n;
		}
	}
	best
}

pub struct Stats {
	pub unmapped_points: usize,
	pub skipped_quests: usize,
}

fn normalize_spawn_table(
	source: &IdMap,
	names: &IdMap,
	raw: &Raw,
	roles: &[(&'static str, &'static str)],
	resolve: &dyn Fn(f64) -> Option<i64>,
	so: SpawnOptions,
	stats: &mut Stats,
	is_npc: bool,
) -> (Obj, FxHashMap<i64, i64>) {
	let out = Obj::new();
	let mut main = FxHashMap::default();
	for (&id, r) in source {
		let coords = r.get("coords");
		let list = if coords.is_arr() { coords.items() } else { Vec::new() };
		let (spawns, unmapped) = era_spawns(&list, resolve, so);
		stats.unmapped_points += unmapped;
		let rec = Obj::new();
		rec.set("id", id as f64);
		rec.set("name", names.get(&id).and_then(|n| n.as_rc_str()).map(V::Str).unwrap_or(V::Null));
		if is_npc {
			let (level, level_max) = parse_level(&r.get("lvl"));
			rec.set("level", opt_v(level));
			if let Some(m) = level_max {
				rec.set("levelMax", m);
			}
			if let Some(rank) = int_or_null(&r.get("rnk")) {
				rec.set("rank", rank);
			}
			rec.set("faction", faction(&r.get("fac")));
		}
		let rl = roles_from(raw, roles, id, is_npc);
		if !rl.is_empty() {
			rec.set("roles", strs(&rl));
		}
		rec.set("spawns", spawns);
		out.set(&id.to_string(), rec);
		if let Some(m) = main_map(&coords, resolve) {
			main.insert(id, m);
		}
	}
	(out, main)
}

fn build_objectives(q: &V, loc: Option<&V>, raw: &Raw, resolve: &dyn Fn(f64) -> Option<i64>) -> V {
	let text = loc.and_then(|l| l.get("O").as_str().map(str::to_string));
	let obj = q.get("obj");
	let mut entries: Vec<(&str, f64, Option<V>)> = Vec::new();
	let name_of = |m: &IdMap, id: f64| m.get(&(id as i64)).cloned();
	for id in ids(&obj.get("U")) {
		entries.push(("kill", id, name_of(&raw.loc_units, id)));
	}
	for id in ids(&obj.get("O")) {
		entries.push(("object", id, name_of(&raw.loc_objects, id)));
	}
	for id in ids(&obj.get("I")) {
		entries.push(("item", id, name_of(&raw.loc_items, id)));
	}
	for id in ids(&obj.get("A")) {
		entries.push(("event", id, None));
	}
	let all_names: Vec<String> = entries.iter().filter_map(|e| e.2.as_ref().filter(|n| n.truthy()).map(|n| n.to_js_string())).collect();
	let mut out = Vec::new();
	for (kind, id, name) in entries {
		let name_s = name.as_ref().and_then(|n| n.as_str().map(str::to_string));
		let count = if kind == "event" { None } else { parse_count(text.as_deref(), name_s.as_deref(), kind, &all_names) };
		let o = Obj::new();
		o.set("type", kind);
		o.set("id", id);
		o.set("count", opt_v(count));
		o.set("text", name_s.map(V::from).unwrap_or(V::Null));
		if kind == "event" {
			if let Some(at) = raw.areatrigger.get(&(id as i64)) {
				let coords = at.get("coords");
				if coords.is_arr() {
					if let Some(c) = coords.items().into_iter().find(|p| p.is_arr() && resolve(p.num_at(2)).is_some()) {
						o.set("map", resolve(c.num_at(2)).unwrap() as f64);
						o.set("f", "e");
						o.set("x", round2(c.num_at(0)));
						o.set("y", round2(c.num_at(1)));
					}
				}
			}
		}
		out.push(V::Obj(o));
	}
	arr(out)
}

pub struct Normalized {
	pub quests: Obj,
	pub npcs: Obj,
	pub objects: Obj,
	pub items: Obj,
	pub stats: Stats,
}

pub fn normalize(raw: &Raw, resolve: &dyn Fn(f64) -> Option<i64>, so: SpawnOptions) -> Normalized {
	let mut stats = Stats { unmapped_points: 0, skipped_quests: 0 };
	let (npcs, npc_main) = normalize_spawn_table(&raw.units, &raw.loc_units, raw, &NPC_ROLES, resolve, so, &mut stats, true);
	let (objects, object_main) = normalize_spawn_table(&raw.objects, &raw.loc_objects, raw, &OBJECT_ROLES, resolve, so, &mut stats, false);

	let quests = Obj::new();
	let mut successors: IndexMap<i64, Vec<i64>> = IndexMap::new();
	for (&id, q) in &raw.quests {
		let loc = raw.loc_quests.get(&id);
		let title = loc.and_then(|l| l.get("T").as_str().map(str::to_string)).filter(|t| !t.is_empty());
		let Some(title) = title else {
			stats.skipped_quests += 1;
			continue;
		};
		let start = q.get("start");
		let end = q.get("end");
		let pre = ids(&q.get("pre"));
		for &p in &pre {
			successors.entry(p as i64).or_default().push(id);
		}
		let (sn, so_, en, eo) = (ids(&start.get("U")), ids(&start.get("O")), ids(&end.get("U")), ids(&end.get("O")));
		let m = |t: &FxHashMap<i64, i64>, l: &[f64]| l.first().and_then(|x| t.get(&(*x as i64)).copied());
		let zone = m(&npc_main, &sn).or_else(|| m(&object_main, &so_)).or_else(|| m(&npc_main, &en)).or_else(|| m(&object_main, &eo));
		let rec = Obj::new();
		rec.set("id", id as f64);
		rec.set("title", title.as_str());
		rec.set("level", opt_v(int_or_null(&q.get("lvl"))));
		rec.set("minLevel", opt_v(int_or_null(&q.get("min"))));
		rec.set("races", opt_v(mask(&q.get("race"), ALL_RACES)));
		rec.set("classes", opt_v(mask(&q.get("class"), ALL_CLASSES)));
		let st = Obj::new();
		st.set("npc", nums(&sn));
		st.set("object", nums(&so_));
		st.set("item", nums(&ids(&start.get("I"))));
		rec.set("start", st);
		let en_o = Obj::new();
		en_o.set("npc", nums(&en));
		en_o.set("object", nums(&eo));
		rec.set("end", en_o);
		rec.set("pre", nums(&pre));
		rec.set("excl", nums(&ids(&q.get("close")).into_iter().filter(|&x| x != id as f64).collect::<Vec<_>>()));
		rec.set("next", V::Null);
		rec.set("objectives", build_objectives(q, loc, raw, resolve));
		rec.set("objectiveText", loc.and_then(|l| l.get("O").as_str().filter(|s| !s.is_empty()).map(V::str)).unwrap_or(V::Null));
		rec.set("zone", zone.map(|z| V::Num(z as f64)).unwrap_or(V::Null));
		rec.set("xp", V::Null);
		rec.set("skill", opt_v(int_or_null(&q.get("skill"))));
		rec.set("event", opt_v(int_or_null(&q.get("event"))));
		rec.set("source", strs(&["pfquest"]));
		quests.set(&id.to_string(), rec);
	}
	for (p, list) in &successors {
		let pk = p.to_string();
		if quests.has(&pk) && list.len() == 1 && quests.has(&list[0].to_string()) {
			quests.get(&pk).set("next", list[0] as f64);
		}
	}

	let items = Obj::new();
	for (&id, r) in &raw.items {
		let Some(name) = raw.loc_items.get(&id).and_then(|n| n.as_rc_str()) else { continue };
		let mut npc: IndexMap<i64, Option<f64>> = IndexMap::new();
		let mut object: IndexMap<i64, Option<f64>> = IndexMap::new();
		fn put(m: &mut IndexMap<i64, Option<f64>>, k: i64, chance: &V) {
			let c = chance.num();
			if k <= 0 || !c.is_finite() || c <= 0.0 {
				return;
			}
			match m.get(&k) {
				Some(Some(old)) if *old >= c => {}
				_ => {
					m.insert(k, Some(c));
				}
			}
		}
		for (&u, c) in &r.u {
			put(&mut npc, u, c);
		}
		for (&o, c) in &r.o {
			put(&mut object, o, c);
		}
		let ref0 = |m: &mut IndexMap<i64, Option<f64>>, k: i64| {
			if k > 0 && !m.contains_key(&k) {
				m.insert(k, None);
			}
		};
		for (&rf, c) in &r.r {
			let Some((ru, ro)) = raw.refloot.get(&rf) else { continue };
			let known = c.num() > 0.0;
			for &u in ru.keys() {
				if known {
					put(&mut npc, u, c)
				} else {
					ref0(&mut npc, u)
				}
			}
			for &o in ro.keys() {
				if known {
					put(&mut object, o, c)
				} else {
					ref0(&mut object, o)
				}
			}
		}
		let sorted = |m: &IndexMap<i64, Option<f64>>| {
			let mut ks: Vec<i64> = m.keys().copied().collect();
			ks.sort();
			let o = Obj::new();
			for k in ks {
				o.set(&k.to_string(), opt_v(m[&k]));
			}
			o
		};
		let rec = Obj::new();
		rec.set("id", id as f64);
		rec.set("name", name);
		let drops = Obj::new();
		drops.set("npc", sorted(&npc));
		drops.set("object", sorted(&object));
		rec.set("drops", drops);
		let mut vendors: Vec<f64> = r.v.keys().filter(|&&k| k > 0).map(|&k| k as f64).collect();
		vendors.sort_by(|a, b| a.partial_cmp(b).unwrap());
		rec.set("vendors", nums(&vendors));
		items.set(&id.to_string(), rec);
	}
	Normalized { quests, npcs, objects, items, stats }
}
