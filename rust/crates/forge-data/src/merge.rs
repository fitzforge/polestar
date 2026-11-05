//! QuestieDB Forever records merged over the pfQuest tables (port of
//! tools/lib/data/questie-merge.js). Precedence: recordings > questie-forever > pfQuest.

use forge_guide::js::{Obj, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::factions::{ALL_CLASSES, ALL_RACES};
use crate::jsv::{arr, hypot, is_int, lua_get_i, lua_list, lua_pairs, nums, round2, strs, to_int32};
use crate::objectives::parse_count;
use crate::questie::{drop_rate, table_rates, Questie};
use crate::spawns::{points_of, reduce_spawns, spawn_record, SpawnOptions, P};

pub const SOURCE: &str = "questie-forever";
const NPC_FLAG_ROLES: [(f64, &str); 11] = [
	(4.0, "vendor"),
	(8.0, "flightmaster"),
	(16.0, "trainer"),
	(32.0, "spirithealer"),
	(64.0, "spirithealer"),
	(128.0, "innkeeper"),
	(256.0, "banker"),
	(2048.0, "battlemaster"),
	(4096.0, "auctioneer"),
	(8192.0, "stablemaster"),
	(16384.0, "repair"),
];

fn ids(v: &V) -> Vec<f64> {
	let mut out: Vec<f64> = Vec::new();
	for x in lua_list(v) {
		let n = x.num();
		if is_int(n) && n > 0.0 && !out.contains(&n) {
			out.push(n);
		}
	}
	out
}

fn num(v: &V) -> Option<f64> {
	let n = v.num();
	(n.is_finite() && n != 0.0).then_some(n)
}

fn opt(n: Option<f64>) -> V {
	n.map(V::Num).unwrap_or(V::Null)
}

/// Race mask -> None when unrestricted (bits 32/33 split arithmetically).
pub fn race_mask(v: &V) -> Option<f64> {
	let n = v.num();
	if !(is_int(n) && n.abs() <= 9007199254740991.0) || n <= 0.0 {
		return None;
	}
	let low = n % 4294967296.0;
	let high = (n / 4294967296.0).floor();
	if (to_int32(low) & ALL_RACES) == ALL_RACES && (to_int32(high) & 3) == 3 {
		return None;
	}
	Some(n)
}

pub fn class_mask(v: &V) -> Option<f64> {
	let n = v.num();
	if !is_int(n) || n <= 0.0 || (to_int32(n) & ALL_CLASSES) == ALL_CLASSES {
		return None;
	}
	Some(n)
}

fn sorted_roles(set: Vec<String>) -> V {
	let mut v: Vec<String> = Vec::new();
	for s in set {
		if !v.contains(&s) {
			v.push(s);
		}
	}
	v.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	arr(v.into_iter().map(V::from).collect())
}

fn str_list(v: &V) -> Vec<String> {
	v.items().iter().map(V::to_js_string).collect()
}

pub struct World {
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
}

pub struct Ctx<'a> {
	pub area_to_ui_map: &'a dyn Fn(f64) -> Option<i64>,
	pub live_maps: &'a dyn Fn(i64) -> bool,
	pub spawn_options: SpawnOptions,
	pub to_world: &'a dyn Fn(i64, &str, f64, f64) -> Option<World>,
	pub instance_of_area: &'a dyn Fn(f64) -> Option<i64>,
	/// CMaNGOS quest_template counts: quest -> { kill, object, item: [[id, count]] }.
	pub quest_counts: Option<&'a V>,
	/// The sim-v2 (m2a) npc and object rules: npc sides pfQuest's only, objects without mailbox
	/// sides, no npc flag 64, no service dedupe.
	pub sim: bool,
	/// One rate table per item (`dropScale`, `dropRatesMixedAvoided`).
	pub item_rules: bool,
}

struct Spawns {
	spawns: V,
	counts: IndexMap<i64, usize>,
	unmapped: usize,
}

fn questie_spawns(value: &V, ctx: &Ctx, so: SpawnOptions) -> Spawns {
	let mut per_map: IndexMap<i64, Vec<P>> = IndexMap::new();
	let mut unmapped = 0;
	for (area, rows) in lua_pairs(value) {
		let pts: Vec<V> = lua_list(&rows).into_iter().filter(|r| lua_get_i(r, 1).num() >= 0.0 && lua_get_i(r, 2).num() >= 0.0).collect();
		if pts.is_empty() {
			continue;
		}
		let Some(map) = (ctx.area_to_ui_map)(area.num()) else {
			unmapped += pts.len();
			continue;
		};
		let l = per_map.entry(map).or_default();
		for r in pts {
			l.push([lua_get_i(&r, 1).num(), lua_get_i(&r, 2).num()]);
		}
	}
	let mut maps: Vec<i64> = per_map.keys().copied().collect();
	maps.sort();
	let spawns = Obj::new();
	let mut counts = IndexMap::new();
	for map in maps {
		let r = reduce_spawns(&per_map[&map], so);
		if r.pts.is_empty() {
			continue;
		}
		spawns.set(&map.to_string(), spawn_record(if (ctx.live_maps)(map) { "l" } else { "e" }, &r));
		counts.insert(map, per_map[&map].len());
	}
	Spawns { spawns: V::Obj(spawns), counts, unmapped }
}

fn main_of(counts: &IndexMap<i64, usize>) -> Option<i64> {
	let (mut best, mut best_n) = (None, 0);
	for (&m, &n) in counts {
		if n > best_n || (n == best_n && best.is_some_and(|b| m < b)) {
			best = Some(m);
			best_n = n;
		}
	}
	best
}

fn npc_faction(r: &Obj) -> V {
	let f = r.get("friendlyToFaction");
	let Some(f) = f.as_str().filter(|f| matches!(*f, "A" | "H" | "AH")) else { return V::Null };
	let flags = r.get("npcFlags").num();
	let services = (if flags.is_nan() { 0.0 } else { flags }) > 3.0;
	let quests = lua_list(&r.get("questStarts")).len() + lua_list(&r.get("questEnds")).len() > 0;
	if f == "AH" && !services && !quests {
		V::Null
	} else {
		V::str(f)
	}
}

fn npc_record(r: &Obj, spawns: V, sim: bool) -> Obj {
	let rec = Obj::new();
	rec.set("id", r.get("id"));
	rec.set("name", r.get("name").as_rc_str().map(V::Str).unwrap_or(V::Null));
	let lo = num(&r.get("minLevel"));
	let hi = num(&r.get("maxLevel"));
	rec.set("level", opt(lo.or(hi)));
	if let (Some(l), Some(h)) = (lo, hi) {
		if h != l {
			rec.set("levelMax", h);
		}
	}
	if let Some(rank) = num(&r.get("rank")) {
		rec.set("rank", rank);
	}
	rec.set("faction", npc_faction(r));
	let flags = r.get("npcFlags").num();
	let flags = if flags.is_nan() { 0.0 } else { flags };
	let roles: Vec<String> = NPC_FLAG_ROLES.iter().filter(|(bit, _)| !(sim && *bit == 64.0) && (flags / bit).floor() % 2.0 == 1.0).map(|(_, r)| r.to_string()).collect();
	if !roles.is_empty() {
		rec.set("roles", sorted_roles(roles));
	}
	if let Some(s) = r.get("subName").as_str().filter(|s| !s.is_empty()) {
		rec.set("subName", s);
	}
	rec.set("spawns", spawns);
	rec
}

fn object_record(r: &Obj, spawns: V, templates: &IndexMap<i64, f64>, sim: bool) -> Obj {
	let rec = Obj::new();
	rec.set("id", r.get("id"));
	let name = r.get("name").as_rc_str();
	rec.set("name", name.clone().map(V::Str).unwrap_or(V::Null));
	if !sim && name.as_deref() == Some("Mailbox") {
		rec.set("roles", strs(&["mailbox"]));
		let fid = r.get("factionID").num();
		let enemies = if fid == 0.0 {
			Some(0.0)
		} else if is_int(fid) {
			templates.get(&(fid as i64)).copied()
		} else {
			None
		};
		let hostile = enemies.filter(|e| is_int(*e) && *e >= 0.0).map(|e| to_int32(e) & 6);
		rec.set(
			"faction",
			match hostile {
				Some(0) => V::str("AH"),
				Some(2) => V::str("H"),
				Some(4) => V::str("A"),
				_ => V::Null,
			},
		);
	}
	rec.set("spawns", spawns);
	rec
}

const SAME_SPAWN_YARDS: f64 = 30.0;

fn by_xy(a: &P, b: &P) -> std::cmp::Ordering {
	let d = a[0] - b[0];
	let d = if d != 0.0 { d } else { a[1] - b[1] };
	d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

/// Questie's spawns plus pfQuest's copies of the same spawns on maps Questie does not list.
fn merge_spawns(pf: &V, q: &V, ctx: &Ctx, all_maps: bool) -> V {
	let qo = q.as_obj().unwrap();
	if qo.is_empty() {
		return if pf.is_object() { pf.clone() } else { V::obj() };
	}
	let mut world: Vec<Option<World>> = Vec::new();
	let mut extra: Vec<Option<World>> = Vec::new();
	for (map, s) in qo.entries() {
		let m: i64 = map.parse().unwrap_or(0);
		let f = s.get("f").to_js_string();
		for [x, y] in points_of(&s.get("pts")) {
			world.push((ctx.to_world)(m, &f, x, y));
		}
		for [x, y] in points_of(&s.get("more")) {
			extra.push((ctx.to_world)(m, &f, x, y));
		}
	}
	let near = |w: &Option<World>, list: &[&Option<World>]| match w {
		None => false,
		Some(w) => list.iter().any(|q| q.as_ref().is_some_and(|q| q.c == w.c && hypot(q.wx - w.wx, q.wy - w.wy) <= SAME_SPAWN_YARDS)),
	};
	let world_r: Vec<&Option<World>> = world.iter().collect();
	let every: Vec<&Option<World>> = world.iter().chain(extra.iter()).collect();
	let out = qo.spread();
	if let Some(po) = pf.as_obj() {
		for (map, s) in po.entries() {
			if out.has(&map) {
				continue;
			}
			if all_maps {
				out.set_str(map, s);
				continue;
			}
			let m: i64 = map.parse().unwrap_or(0);
			let f = s.get("f").to_js_string();
			let at = |p: &P| (ctx.to_world)(m, &f, p[0], p[1]);
			let spts = points_of(&s.get("pts"));
			let keep: Vec<bool> = spts.iter().map(|p| near(&at(p), &world_r)).collect();
			let pts: Vec<P> = spts.iter().zip(&keep).filter(|(_, k)| **k).map(|(p, _)| *p).collect();
			let mut more: Vec<P> = spts.iter().zip(&keep).filter(|(_, k)| !**k).map(|(p, _)| *p).chain(points_of(&s.get("more"))).filter(|p| near(&at(p), &every)).collect();
			more.sort_by(by_xy);
			if !pts.is_empty() {
				out.set_str(map, spawn_record(&f, &crate::spawns::Reduced { pts, more }));
			}
		}
	}
	let mut keys: Vec<(f64, forge_guide::js::Str)> = out.keys().into_iter().map(|k| (forge_guide::js::str_to_num(&k), k)).collect();
	keys.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
	let sorted = Obj::new();
	for (n, k) in keys {
		sorted.set(&forge_guide::js::num_str(n), out.get(&k));
	}
	V::Obj(sorted)
}

fn merge_npc(pf: Option<&V>, q: Obj, ctx: &Ctx, counter: &mut usize) -> Obj {
	let Some(pf) = pf else {
		q.set("source", strs(&[SOURCE]));
		return q;
	};
	let out = Obj::new();
	out.set("id", pf.get("id"));
	let qn = q.get("name");
	out.set("name", if qn.truthy() { qn } else { pf.get("name") });
	let ql = q.get("level");
	out.set("level", if ql.is_nullish() { pf.get("level") } else { ql.clone() });
	let level_max = if !matches!(ql, V::Null) { q.get("levelMax") } else { pf.get("levelMax") };
	if !level_max.is_nullish() {
		out.set("levelMax", level_max);
	}
	let rank = if !matches!(ql, V::Null) { q.get("rank") } else { pf.get("rank") };
	if !rank.is_nullish() {
		out.set("rank", rank);
	}
	let q_roles = str_list(&q.get("roles"));
	let pf_roles = str_list(&pf.get("roles"));
	let pff = pf.get("faction");
	out.set(
		"faction",
		if !pff.is_nullish() {
			pff
		} else if !q_roles.is_empty() && !ctx.sim {
			q.get("faction")
		} else {
			V::Null
		},
	);
	if !q_roles.is_empty() && pf_roles.iter().any(|r| !q_roles.contains(r)) {
		*counter += 1;
	}
	let roles: Vec<String> = q_roles.iter().chain(&pf_roles).cloned().collect();
	if !roles.is_empty() {
		out.set("roles", sorted_roles(roles));
	}
	let sub = q.get("subName");
	if sub.truthy() {
		out.set("subName", sub);
	}
	out.set("spawns", merge_spawns(&pf.get("spawns"), &q.get("spawns"), ctx, false));
	let mut src = pf_source(pf);
	src.push(V::str(SOURCE));
	out.set("source", arr(src));
	out
}

fn pf_source(pf: &V) -> Vec<V> {
	let s = pf.get("source");
	if s.truthy() {
		s.items()
	} else {
		vec![V::str("pfquest")]
	}
}

const GATHER_ROLES: [&str; 4] = ["herb", "mine", "fishing", "chest"];

fn merge_object(pf: Option<&V>, q: Obj, ctx: &Ctx) -> Obj {
	let Some(pf) = pf else {
		q.set("source", strs(&[SOURCE]));
		return q;
	};
	let out = Obj::new();
	out.set("id", pf.get("id"));
	let qn = q.get("name");
	out.set("name", if qn.truthy() { qn } else { pf.get("name") });
	let q_roles = str_list(&q.get("roles"));
	let pf_roles = str_list(&pf.get("roles"));
	if ctx.sim {
		if pf.get("roles").truthy() {
			out.set("roles", pf.get("roles"));
		}
	} else {
		let roles: Vec<String> = q_roles.iter().chain(&pf_roles).cloned().collect();
		if !roles.is_empty() {
			out.set("roles", sorted_roles(roles));
		}
	}
	if ctx.sim {
	} else if q_roles.iter().any(|r| r == "mailbox") {
		out.set("faction", q.get("faction"));
	} else if pf.has("faction") && !pf.get("faction").is_undef() {
		out.set("faction", pf.get("faction"));
	}
	let all = pf_roles.iter().any(|r| GATHER_ROLES.contains(&r.as_str()));
	out.set("spawns", merge_spawns(&pf.get("spawns"), &q.get("spawns"), ctx, all));
	let mut src = pf_source(pf);
	src.push(V::str(SOURCE));
	out.set("source", arr(src));
	out
}

fn sorted_obj(m: &IndexMap<i64, V>) -> Obj {
	let mut ks: Vec<i64> = m.keys().copied().collect();
	ks.sort();
	let o = Obj::new();
	for k in ks {
		o.set(&k.to_string(), m[&k].clone());
	}
	o
}

fn merge_item(pf: Option<&V>, r: &Obj, q: &Questie, added: &mut usize) -> Obj {
	let rid = r.get("id").num() as i64;
	let pf_drop = |kind: &str, id: i64| pf.map(|p| p.get("drops").get(kind).get(&id.to_string())).filter(|v| !v.is_undef());
	let mut npc: IndexMap<i64, V> = IndexMap::new();
	for id in ids(&r.get("npcDrops")) {
		let id = id as i64;
		let v = match drop_rate(&q.drops, rid, id) {
			Some(rate) => V::Num(rate.chance),
			None => pf_drop("npc", id).unwrap_or(V::Null),
		};
		npc.insert(id, v);
	}
	let mut object: IndexMap<i64, V> = IndexMap::new();
	for id in ids(&r.get("objectDrops")) {
		let id = id as i64;
		object.insert(id, pf_drop("object", id).unwrap_or(V::Null));
	}
	let mut vendors: Vec<f64> = ids(&r.get("vendors"));
	let mut extra = 0;
	if let Some(pf) = pf {
		for (kind, m) in [("npc", &mut npc), ("object", &mut object)] {
			for (k, c) in pf.get("drops").get(kind).entries() {
				let k: i64 = k.parse().unwrap();
				if !m.contains_key(&k) {
					m.insert(k, c);
					extra += 1;
				}
			}
		}
		for v in pf.get("vendors").items() {
			let v = v.num();
			if !vendors.contains(&v) {
				vendors.push(v);
				extra += 1;
			}
		}
	}
	if extra > 0 && (r.get("npcDrops").truthy() || r.get("objectDrops").truthy() || r.get("vendors").truthy()) {
		*added += 1;
	}
	let out = Obj::new();
	out.set("id", r.get("id"));
	let name = r.get("name");
	out.set("name", if name.as_str().is_some_and(|s| !s.is_empty()) { name } else { pf.map(|p| p.get("name")).unwrap_or(V::Null) });
	let drops = Obj::new();
	drops.set("npc", sorted_obj(&npc));
	drops.set("object", sorted_obj(&object));
	out.set("drops", drops);
	vendors.sort_by(|a, b| a.partial_cmp(b).unwrap());
	out.set("vendors", nums(&vendors));
	if r.get("class").num() == 12.0 {
		out.set("questItem", true);
	}
	let mut containers = ids(&r.get("itemDrops"));
	if !containers.is_empty() {
		containers.sort_by(|a, b| a.partial_cmp(b).unwrap());
		out.set("containers", nums(&containers));
	}
	match pf {
		Some(p) => {
			let mut s = pf_source(p);
			s.push(V::str(SOURCE));
			out.set("source", arr(s));
		}
		None => out.set("source", strs(&[SOURCE])),
	}
	out
}

/// m2a's mergeItem: chances from one table per item (QuestieDB's server table when it rates any
/// of QuestieDB's droppers, else its observed table, else pfQuest's); `dropScale` names it.
fn merge_item_sim(pf: Option<&V>, r: &Obj, q: &Questie, added: &mut usize, mixed: &mut usize) -> Obj {
	let rid = r.get("id").num() as i64;
	let pf_rate = |id: &str| pf.map(|p| p.get("drops").get("npc").get(id)).filter(|v| !v.is_nullish());
	// [corrected, server, observed, pfquest]
	let mut rates: IndexMap<i64, [Option<V>; 4]> = IndexMap::new();
	for id in ids(&r.get("npcDrops")) {
		let id = id as i64;
		let t = table_rates(&q.drops, rid, id);
		rates.insert(id, [t.0.map(V::Num), t.1.map(V::Num), t.2.map(V::Num), pf_rate(&id.to_string())]);
	}
	let mut extra = 0;
	if let Some(p) = pf {
		for k in p.get("drops").get("npc").keys() {
			let n: i64 = k.parse().unwrap_or(0);
			if rates.contains_key(&n) {
				continue;
			}
			rates.insert(n, [None, None, None, pf_rate(&k)]);
			extra += 1;
		}
	}
	let table = (1..4).find(|&t| rates.values().any(|x| x[t].is_some()));
	let mut npc: IndexMap<i64, V> = IndexMap::new();
	let mut from_table = 0;
	for (&id, x) in &rates {
		let chance = x[0].clone().or_else(|| table.and_then(|t| x[t].clone())).unwrap_or(V::Null);
		if x[0].is_none() && !matches!(chance, V::Null) {
			from_table += 1;
		}
		if matches!(chance, V::Null) && x[1..].iter().any(Option::is_some) {
			*mixed += 1;
		}
		npc.insert(id, chance);
	}
	let corrected = rates.values().any(|x| x[0].is_some());
	let mut object: IndexMap<i64, V> = IndexMap::new();
	for id in ids(&r.get("objectDrops")) {
		let id = id as i64;
		let v = pf.map(|p| p.get("drops").get("object").get(&id.to_string())).filter(|v| !v.is_undef()).unwrap_or(V::Null);
		object.insert(id, v);
	}
	let mut vendors: Vec<f64> = ids(&r.get("vendors"));
	if let Some(p) = pf {
		for (k, c) in p.get("drops").get("object").entries() {
			let k: i64 = k.parse().unwrap();
			if !object.contains_key(&k) {
				object.insert(k, c);
				extra += 1;
			}
		}
		for v in p.get("vendors").items() {
			let v = v.num();
			if !vendors.contains(&v) {
				vendors.push(v);
				extra += 1;
			}
		}
	}
	if extra > 0 && (r.get("npcDrops").truthy() || r.get("objectDrops").truthy() || r.get("vendors").truthy()) {
		*added += 1;
	}
	let out = Obj::new();
	out.set("id", r.get("id"));
	let name = r.get("name");
	out.set("name", if name.as_str().is_some_and(|s| !s.is_empty()) { name } else { pf.map(|p| p.get("name")).unwrap_or(V::Null) });
	let drops = Obj::new();
	drops.set("npc", sorted_obj(&npc));
	drops.set("object", sorted_obj(&object));
	out.set("drops", drops);
	vendors.sort_by(|a, b| a.partial_cmp(b).unwrap());
	out.set("vendors", nums(&vendors));
	const SCALES: [&str; 4] = ["corrected", "server", "observed", "pfquest"];
	out.set(
		"dropScale",
		if from_table > 0 {
			V::str(SCALES[table.unwrap()])
		} else if corrected {
			V::str("corrected")
		} else {
			V::Null
		},
	);
	if r.get("class").num() == 12.0 {
		out.set("questItem", true);
	}
	let mut containers = ids(&r.get("itemDrops"));
	if !containers.is_empty() {
		containers.sort_by(|a, b| a.partial_cmp(b).unwrap());
		out.set("containers", nums(&containers));
	}
	match pf {
		Some(p) => {
			let mut s = pf_source(p);
			s.push(V::str(SOURCE));
			out.set("source", arr(s));
		}
		None => out.set("source", strs(&[SOURCE])),
	}
	out
}

// ---------------------------------------------------------------- quests

fn objective_text_of(lines: &V) -> Option<String> {
	let l: Vec<String> = lua_list(lines).into_iter().filter_map(|s| s.as_str().map(str::to_string)).collect();
	(!l.is_empty() && l.iter().any(|s| !s.is_empty())).then(|| l.join("$B"))
}

struct Names<'a> {
	npcs: &'a Obj,
	objects: &'a Obj,
	items: &'a Obj,
}

fn name_in(t: &Obj, id: f64) -> V {
	let e = t.get(&forge_guide::js::num_str(id));
	match e.get("name") {
		V::Str(s) => V::Str(s),
		_ => V::Null,
	}
}

struct QCtx<'a, 'b> {
	ctx: &'a Ctx<'b>,
	names: Names<'a>,
	mains: &'a FxHashMap<&'static str, FxHashMap<i64, i64>>,
	objective_first: &'a FxHashMap<&'static str, FxHashSet<i64>>,
	added_quests: usize,
	counts_filled: usize,
}

struct Entry {
	kind: &'static str,
	id: f64,
	text: V,
	credit: Vec<f64>,
}

/// The NPC giver's first spawn on `map`: (f, x, y).
fn giver_at(q: &Obj, map: i64, npcs: &Obj) -> Option<(String, f64, f64)> {
	let first = ids(&lua_get_i(&q.get("startedBy"), 1)).first().copied()?;
	let npc = npcs.get(&forge_guide::js::num_str(first));
	let s = npc.get("spawns").get(&map.to_string());
	let p = s.get("pts").at(0);
	if !s.is_obj() || !p.is_arr() {
		return None;
	}
	Some((s.get("f").to_js_string(), p.num_at(0), p.num_at(1)))
}

fn quest_objectives(q: &Obj, pf: Option<&V>, qc: &mut QCtx, npcs: &Obj) -> V {
	let text = objective_text_of(&q.get("objectivesText"));
	let o = q.get("objectives");
	let qid = q.get("id").num() as i64;
	let moved = |kind: &str| qc.objective_first.get(kind).is_some_and(|s| s.contains(&qid));
	let mut entries: Vec<Entry> = Vec::new();
	let mut add = |kind: &'static str, e: Entry| if moved(kind) { entries.insert(0, e) } else { entries.push(e) };
	let or_name = |v: V, f: &dyn Fn() -> V| if v.is_undef() { f() } else { v };
	for e in lua_list(&lua_get_i(&o, 1)) {
		let id = lua_get_i(&e, 1).num();
		add("creature", Entry { kind: "kill", id, text: or_name(lua_get_i(&e, 2), &|| name_in(qc.names.npcs, id)), credit: vec![] });
	}
	for e in lua_list(&lua_get_i(&o, 2)) {
		let id = lua_get_i(&e, 1).num();
		add("object", Entry { kind: "object", id, text: or_name(lua_get_i(&e, 2), &|| name_in(qc.names.objects, id)), credit: vec![] });
	}
	for e in lua_list(&lua_get_i(&o, 3)) {
		let id = lua_get_i(&e, 1).num();
		add("item", Entry { kind: "item", id, text: or_name(lua_get_i(&e, 2), &|| name_in(qc.names.items, id)), credit: vec![] });
	}
	for e in lua_list(&lua_get_i(&o, 5)) {
		let base = lua_get_i(&e, 2).num();
		add("killCredit", Entry { kind: "kill", id: base, text: or_name(lua_get_i(&e, 3), &|| name_in(qc.names.npcs, base)), credit: ids(&lua_get_i(&e, 1)) });
	}
	let valid: Vec<Entry> = entries.into_iter().filter(|e| is_int(e.id) && e.id > 0.0).collect();
	let all_names: Vec<String> = valid.iter().filter(|e| e.text.truthy()).map(|e| e.text.to_js_string()).collect();
	let pf_obj: Vec<V> = pf.map(|p| p.get("objectives").items()).unwrap_or_default();
	let mut out: Vec<Obj> = Vec::new();
	for e in &valid {
		let name = e.text.as_str();
		let count = parse_count(text.as_deref(), name, e.kind, &all_names);
		let count = match count {
			Some(c) => V::Num(c),
			None => pf_obj.iter().find(|p| p.get("type").as_str() == Some(e.kind) && p.get("id").num() == e.id).map(|p| p.get("count")).unwrap_or(V::Null),
		};
		let r = Obj::new();
		r.set("type", e.kind);
		r.set("id", e.id);
		r.set("count", count);
		r.set("text", if e.text.is_str() { e.text.clone() } else { V::Null });
		if e.credit.len() > 1 {
			r.set("credit", nums(&e.credit));
		}
		out.push(r);
	}
	let trig = q.get("triggerEnd");
	if trig.truthy() {
		let events: Vec<&V> = pf_obj.iter().filter(|p| p.get("type").as_str() == Some("event")).collect();
		let ev = Obj::new();
		ev.set("type", "event");
		ev.set("id", if events.len() == 1 { events[0].get("id") } else { V::Null });
		ev.set("count", V::Null);
		let t1 = lua_get_i(&trig, 1);
		ev.set("text", if t1.is_str() { t1 } else { V::Null });
		for (area, rows) in lua_pairs(&lua_get_i(&trig, 2)) {
			let map = (qc.ctx.area_to_ui_map)(area.num());
			let pts: Vec<V> = if map.is_some() { lua_list(&rows).into_iter().filter(|r| lua_get_i(r, 1).num() >= 0.0).collect() } else { vec![] };
			let f = if map.is_some_and(|m| (qc.ctx.live_maps)(m)) { "l" } else { "e" };
			let p = nearest_point(&pts, map, giver_at(q, map.unwrap_or(0), npcs).filter(|_| map.is_some()), f, qc.ctx);
			if let Some(p) = p {
				ev.set("map", opt(map.map(|m| m as f64)));
				ev.set("f", f);
				ev.set("x", round2(lua_get_i(&p, 1).num()));
				ev.set("y", round2(lua_get_i(&p, 2).num()));
				break;
			}
		}
		if moved("event") {
			out.insert(0, ev);
		} else {
			out.push(ev);
		}
	}
	if let Some(counts) = qc.ctx.quest_counts {
		let classic = counts.get(&qid.to_string());
		if classic.truthy() {
			qc.counts_filled += fill_counts(&out, &classic);
		}
	}
	arr(out.into_iter().map(V::Obj).collect())
}

fn nearest_point(rows: &[V], map: Option<i64>, at: Option<(String, f64, f64)>, f: &str, ctx: &Ctx) -> Option<V> {
	let tw = |pf: &str, x: f64, y: f64| map.and_then(|m| (ctx.to_world)(m, pf, x, y));
	let g = at.and_then(|(af, x, y)| tw(&af, x, y));
	let (Some(first), Some(g)) = (rows.first(), g) else { return rows.first().cloned() };
	let d = |r: &V| match tw(f, lua_get_i(r, 1).num(), lua_get_i(r, 2).num()) {
		Some(w) => hypot(w.wx - g.wx, w.wy - g.wy),
		None => f64::INFINITY,
	};
	let mut best = first.clone();
	let mut bd = d(first);
	for r in &rows[1..] {
		let dr = d(r);
		if dr < bd {
			best = r.clone();
			bd = dr;
		}
	}
	Some(best)
}

fn group_of(kind: &str) -> Option<&'static str> {
	match kind {
		"kill" | "event" => Some("kill"),
		"object" => Some("object"),
		"item" => Some("item"),
		_ => None,
	}
}

fn fill_counts(objectives: &[Obj], classic: &V) -> usize {
	let mut filled = 0;
	for o in objectives {
		let kind = o.get("type").to_js_string();
		let group = group_of(&kind);
		let slots: Vec<V> = group.map(|g| classic.get(g).items()).unwrap_or_default();
		if !matches!(o.get("count"), V::Null) || slots.is_empty() {
			continue;
		}
		let id = o.get("id");
		let mut counts: Vec<f64> = Vec::new();
		for s in &slots {
			if s.at(0).strict_eq(&id) {
				let n = s.num_at(1);
				if !counts.contains(&n) {
					counts.push(n);
				}
			}
		}
		if slots.len() == 1 && objectives.iter().filter(|p| group_of(&p.get("type").to_js_string()) == group).count() == 1 {
			let n = slots[0].num_at(1);
			if !counts.contains(&n) {
				counts.push(n);
			}
		}
		if counts.len() != 1 {
			continue;
		}
		o.set("count", counts[0]);
		filled += 1;
	}
	filled
}

struct QRec {
	title: Option<String>,
	level: Option<f64>,
	min_level: Option<f64>,
	races: Option<f64>,
	classes: Option<f64>,
	start: [Vec<f64>; 3],
	end: [Vec<f64>; 2],
	pre_any: Vec<f64>,
	pre_all: Vec<f64>,
	excl: Vec<f64>,
	next: Option<f64>,
	breadcrumbs: Vec<f64>,
	parent: Option<f64>,
	children: Vec<f64>,
	objectives: V,
	has_objectives: bool,
	objective_text: Option<String>,
	zone_or_sort: f64,
	skill: Option<f64>,
	skill_level: Option<f64>,
	max_level: Option<f64>,
	breadcrumb_for: Option<f64>,
	repeatable: bool,
	source_item: Option<f64>,
	required_items: Vec<f64>,
	reputation: Option<(f64, f64)>,
	min_rep: Option<(f64, f64)>,
}

fn quest_record(q: &Obj, pf: Option<&V>, qc: &mut QCtx, npcs: &Obj) -> QRec {
	let givers: Vec<V> = (1..=3).map(|i| lua_get_i(&q.get("startedBy"), i)).collect();
	let enders: Vec<V> = (1..=2).map(|i| lua_get_i(&q.get("finishedBy"), i)).collect();
	let skill = lua_list(&q.get("requiredSkill"));
	let rep = lua_list(&lua_get_i(&q.get("objectives"), 4));
	let min_rep = lua_list(&q.get("requiredMinRep"));
	let has_objectives = !lua_pairs(&q.get("objectives")).is_empty() || q.get("triggerEnd").truthy();
	let id = q.get("id").num();
	let pair = |l: &[V]| (l.len() >= 2 && num(&l[0]).is_some()).then(|| (l[0].num(), l[1].num()));
	let flags = q.get("specialFlags").num();
	QRec {
		title: q.get("name").as_str().filter(|s| !s.is_empty()).map(str::to_string),
		level: num(&q.get("questLevel")),
		min_level: num(&q.get("requiredLevel")),
		races: race_mask(&q.get("requiredRaces")),
		classes: class_mask(&q.get("requiredClasses")),
		start: [ids(&givers[0]), ids(&givers[1]), ids(&givers[2])],
		end: [ids(&enders[0]), ids(&enders[1])],
		pre_any: ids(&q.get("preQuestSingle")),
		pre_all: ids(&q.get("preQuestGroup")),
		excl: ids(&q.get("exclusiveTo")).into_iter().filter(|&x| x != id).collect(),
		next: num(&q.get("nextQuestInChain")),
		breadcrumbs: ids(&q.get("breadcrumbs")),
		parent: num(&q.get("parentQuest")),
		children: ids(&q.get("childQuests")),
		objectives: if has_objectives { quest_objectives(q, pf, qc, npcs) } else { V::arr() },
		has_objectives,
		objective_text: objective_text_of(&q.get("objectivesText")),
		zone_or_sort: {
			let z = q.get("zoneOrSort").num();
			if z.is_nan() {
				0.0
			} else {
				z
			}
		},
		skill: skill.first().and_then(num),
		skill_level: skill.get(1).and_then(num),
		max_level: num(&q.get("requiredMaxLevel")),
		breadcrumb_for: num(&q.get("breadcrumbForQuestId")),
		repeatable: (if flags.is_nan() { 0.0 } else { flags } % 2.0).floor() == 1.0,
		source_item: num(&q.get("sourceItemId")),
		required_items: ids(&q.get("requiredSourceItems")),
		reputation: pair(&rep),
		min_rep: pair(&min_rep),
	}
}

/// Givers/enders per kind: Questie's first, pfQuest's extras kept.
fn union_givers(q: &[Vec<f64>], pf: &V, keys: &[&str], counter: &mut usize) -> Obj {
	let out = Obj::new();
	let mut extra = 0;
	for (i, k) in keys.iter().enumerate() {
		let mut l = q[i].clone();
		for id in pf.get(k).items() {
			let id = id.num();
			if !l.contains(&id) {
				l.push(id);
				extra += 1;
			}
		}
		out.set(k, nums(&l));
	}
	if extra > 0 && q.iter().any(|l| !l.is_empty()) {
		*counter += 1;
	}
	out
}

fn base_quest(id: f64) -> V {
	let o = Obj::new();
	o.set("id", id);
	for k in ["title", "level", "minLevel", "races", "classes"] {
		o.set(k, V::Null);
	}
	let st = Obj::new();
	st.set("npc", V::arr());
	st.set("object", V::arr());
	st.set("item", V::arr());
	o.set("start", st);
	let en = Obj::new();
	en.set("npc", V::arr());
	en.set("object", V::arr());
	o.set("end", en);
	o.set("pre", V::arr());
	o.set("excl", V::arr());
	o.set("next", V::Null);
	o.set("objectives", V::arr());
	for k in ["objectiveText", "zone", "xp", "skill", "event"] {
		o.set(k, V::Null);
	}
	o.set("source", V::arr());
	V::Obj(o)
}

fn rep_v(r: (f64, f64)) -> Obj {
	let o = Obj::new();
	o.set("faction", r.0);
	o.set("value", r.1);
	o
}

fn merge_quest(id: f64, pf: Option<&V>, r: QRec, qc: &mut QCtx) -> Obj {
	let base = pf.cloned().unwrap_or_else(|| base_quest(id));
	let has = |v: Option<f64>, b: &str| v.map(V::Num).unwrap_or_else(|| base.get(b));
	let out = Obj::new();
	out.set("id", id);
	out.set("title", r.title.clone().map(V::from).unwrap_or_else(|| base.get("title")));
	out.set("level", has(r.level, "level"));
	out.set("minLevel", has(r.min_level, "minLevel"));
	out.set("races", opt(r.races));
	out.set("classes", opt(r.classes));
	out.set("start", union_givers(&r.start, &base.get("start"), &["npc", "object", "item"], &mut qc.added_quests));
	out.set("end", union_givers(&r.end, &base.get("end"), &["npc", "object"], &mut qc.added_quests));
	let pre = if pf.is_some() {
		base.get("pre")
	} else if !r.pre_any.is_empty() {
		nums(&r.pre_any)
	} else {
		nums(&r.pre_all)
	};
	out.set("pre", pre);
	let mut excl: Vec<f64> = crate::jsv::num_list(&base.get("excl"));
	for x in &r.excl {
		if !excl.contains(x) {
			excl.push(*x);
		}
	}
	out.set("excl", nums(&excl));
	out.set("next", has(r.next, "next"));
	out.set("objectives", if r.has_objectives { r.objectives.clone() } else { base.get("objectives") });
	out.set("objectiveText", r.objective_text.clone().map(V::from).unwrap_or_else(|| base.get("objectiveText")));
	out.set("zone", base.get("zone"));
	out.set("xp", base.get("xp"));
	out.set("skill", opt(r.skill));
	out.set("event", base.get("event"));
	let mut src = base.get("source").items();
	src.push(V::str(SOURCE));
	out.set("source", arr(src));
	if !r.pre_all.is_empty() {
		out.set("preAll", nums(&r.pre_all));
	}
	if !r.pre_any.is_empty() {
		out.set("preAny", nums(&r.pre_any));
	}
	if r.skill.is_some() {
		if let Some(l) = r.skill_level {
			out.set("skillLevel", l);
		}
	}
	if let Some(m) = r.max_level {
		out.set("maxLevel", m);
	}
	if let Some(b) = r.breadcrumb_for {
		out.set("breadcrumbFor", b);
	}
	if !r.breadcrumbs.is_empty() {
		out.set("breadcrumbs", nums(&r.breadcrumbs));
	}
	if let Some(p) = r.parent {
		out.set("parent", p);
	}
	if !r.children.is_empty() {
		out.set("children", nums(&r.children));
	}
	if r.repeatable {
		out.set("repeatable", true);
	}
	if let Some(s) = r.source_item {
		out.set("sourceItem", s);
	}
	if !r.required_items.is_empty() {
		out.set("requiredItems", nums(&r.required_items));
	}
	if let Some(rep) = r.reputation {
		out.set("reputation", rep_v(rep));
	}
	if let Some(rep) = r.min_rep {
		out.set("minRep", rep_v(rep));
	}
	if r.zone_or_sort > 0.0 {
		out.set("area", r.zone_or_sort);
	}
	if pf.is_none() || matches!(out.get("zone"), V::Null) {
		let main = |kind: &str, l: &V| l.at(0).as_num().and_then(|id| qc.mains[kind].get(&(id as i64)).copied());
		let st = out.get("start");
		let en = out.get("end");
		let z = main("npc", &st.get("npc")).or_else(|| main("object", &st.get("object"))).or_else(|| main("npc", &en.get("npc"))).or_else(|| main("object", &en.get("object"))).or_else(|| {
			if r.zone_or_sort > 0.0 {
				(qc.ctx.area_to_ui_map)(r.zone_or_sort)
			} else {
				None
			}
		});
		out.set("zone", z.map(|z| V::Num(z as f64)).unwrap_or(V::Null));
	}
	out
}

const COMPARED: [&str; 9] = ["title", "level", "minLevel", "races", "classes", "start", "end", "next", "objectives"];

fn quest_diff(pf: &V, merged: &Obj) -> Vec<&'static str> {
	let mut changed = Vec::new();
	for k in COMPARED {
		let (a, b) = if k == "objectives" {
			let f = |v: &V| v.items().iter().map(|o| format!("{}:{}", o.get("type").to_js_string(), o.get("id").to_js_string())).collect::<Vec<_>>().join("\u{0}");
			(f(&pf.get(k)), f(&merged.get(k)))
		} else {
			(forge_guide::js::stringify(&pf.get(k), None), forge_guide::js::stringify(&merged.get(k), None))
		};
		if a != b {
			changed.push(k);
		}
	}
	changed
}

pub struct Tables<'a> {
	pub quests: &'a Obj,
	pub npcs: &'a Obj,
	pub objects: &'a Obj,
	pub items: &'a Obj,
}

#[derive(Default)]
pub struct Stats {
	pub questie_only_quests: usize,
	pub questie_only_npcs: usize,
	pub questie_only_objects: usize,
	pub questie_only_items: usize,
	pub questie_quests: usize,
	pub questie_npcs: usize,
	pub questie_objects: usize,
	pub questie_items: usize,
	pub unmapped_questie_points: usize,
	pub quest_xp: usize,
	pub removed_quests: Vec<f64>,
	pub changed_quests: IndexMap<&'static str, usize>,
	pub objective_counts_from_classic_db: usize,
	pub items_regained_entries: usize,
	pub npcs_regained_roles: usize,
	pub quests_regained_givers: usize,
	pub reverse_links: usize,
	pub prereqs_cleaned: usize,
	pub corrections: usize,
	pub drop_rates_mixed_avoided: Option<usize>,
}

fn get_rec(t: &Obj, id: i64) -> Option<V> {
	let v = t.get(&id.to_string());
	(!v.is_undef()).then_some(v)
}

pub fn apply_questie(t: &Tables, qz: &Questie, ctx: &Ctx) -> Stats {
	let mut stats = Stats::default();
	let mut mains: FxHashMap<&'static str, FxHashMap<i64, i64>> = FxHashMap::default();
	mains.insert("npc", FxHashMap::default());
	mains.insert("object", FxHashMap::default());
	let mut roles_added = 0;
	let instances_of = |r: &Obj| {
		let mut areas: Vec<f64> = lua_pairs(&r.get("spawns")).iter().map(|(a, _)| a.num()).collect();
		let z = r.get("zoneID").num();
		if z > 0.0 {
			areas.push(z);
		}
		let mut out: Vec<i64> = Vec::new();
		for a in areas {
			if let Some(i) = (ctx.instance_of_area)(a) {
				if !out.contains(&i) {
					out.push(i);
				}
			}
		}
		out.sort();
		out
	};
	for (kind, table, source) in [("npc", t.npcs, &qz.npcs), ("object", t.objects, &qz.objects)] {
		for (&id, r) in source {
			let service = if kind == "npc" { r.get("npcFlags").num() > 3.0 } else { r.get("name").as_str() == Some("Mailbox") };
			let so = if service && !ctx.sim { SpawnOptions { dedupe: 0.0, ..ctx.spawn_options } } else { ctx.spawn_options };
			let sp = questie_spawns(&r.get("spawns"), ctx, so);
			stats.unmapped_questie_points += sp.unmapped;
			if let Some(m) = main_of(&sp.counts) {
				mains.get_mut(kind).unwrap().insert(id, m);
			}
			let pf = get_rec(table, id);
			if pf.is_none() {
				if kind == "npc" {
					stats.questie_only_npcs += 1
				} else {
					stats.questie_only_objects += 1
				}
			}
			let merged = if kind == "npc" {
				merge_npc(pf.as_ref(), npc_record(r, sp.spawns, ctx.sim), ctx, &mut roles_added)
			} else {
				merge_object(pf.as_ref(), object_record(r, sp.spawns, &qz.faction_templates, ctx.sim), ctx)
			};
			let inst = instances_of(r);
			if !inst.is_empty() {
				merged.set("instances", nums(&inst.iter().map(|&x| x as f64).collect::<Vec<_>>()));
			}
			table.set(&id.to_string(), merged);
			if kind == "npc" {
				stats.questie_npcs += 1
			} else {
				stats.questie_objects += 1
			}
		}
	}
	let mut added_items = 0;
	let mut mixed = 0;
	for (&id, r) in &qz.items {
		let pf = get_rec(t.items, id);
		if pf.is_none() {
			stats.questie_only_items += 1;
		}
		let it = if ctx.item_rules { merge_item_sim(pf.as_ref(), r, qz, &mut added_items, &mut mixed) } else { merge_item(pf.as_ref(), r, qz, &mut added_items) };
		t.items.set(&id.to_string(), it);
		stats.questie_items += 1;
	}
	if ctx.item_rules {
		// Items QuestieDB does not hold keep pfQuest's chances, on its scale.
		for it in t.items.values() {
			if !qz.items.contains_key(&(it.get("id").num() as i64)) {
				let rated = it.get("drops").get("npc").values().iter().any(|v| !v.is_nullish());
				it.set("dropScale", if rated { V::str("pfquest") } else { V::Null });
			}
		}
		stats.drop_rates_mixed_avoided = Some(mixed);
	}
	stats.items_regained_entries = added_items;
	stats.npcs_regained_roles = roles_added;

	let mut qc = QCtx { ctx, names: Names { npcs: t.npcs, objects: t.objects, items: t.items }, mains: &mains, objective_first: &qz.objective_first, added_quests: 0, counts_filled: 0 };
	for k in t.quests.keys() {
		let id: f64 = forge_guide::js::str_to_num(&k);
		if !qz.quests.contains_key(&(id as i64)) {
			stats.removed_quests.push(id);
		}
	}
	for (&id, q) in &qz.quests {
		let pf = get_rec(t.quests, id);
		let r = quest_record(q, pf.as_ref(), &mut qc, t.npcs);
		if r.title.is_none() && pf.is_none() {
			continue;
		}
		let merged = merge_quest(id as f64, pf.as_ref(), r, &mut qc);
		match &pf {
			Some(p) => {
				for k in quest_diff(p, &merged) {
					*stats.changed_quests.entry(k).or_insert(0) += 1;
				}
			}
			None => stats.questie_only_quests += 1,
		}
		t.quests.set(&id.to_string(), merged);
		stats.questie_quests += 1;
	}
	stats.quests_regained_givers = qc.added_quests;
	stats.objective_counts_from_classic_db = qc.counts_filled;

	// Reverse links: npc/object questStarts/questEnds and item startQuest.
	let mut link = |qid: f64, side: &str, kind: &str, eid: i64| {
		let q = t.quests.get(&forge_guide::js::num_str(qid));
		let list = q.get(side).get(kind);
		if !list.is_arr() || crate::jsv::includes_num(&list, eid as f64) {
			return;
		}
		list.push(eid as f64);
		stats.reverse_links += 1;
	};
	for (kind, source) in [("npc", &qz.npcs), ("object", &qz.objects)] {
		for (&eid, e) in source {
			for qid in lua_list(&e.get("questStarts")) {
				link(qid.num(), "start", kind, eid);
			}
			for qid in lua_list(&e.get("questEnds")) {
				link(qid.num(), "end", kind, eid);
			}
		}
	}
	for (&iid, it) in &qz.items {
		let sq = it.get("startQuest").num();
		if sq > 0.0 {
			link(sq, "start", "item", iid);
		}
	}
	for (&id, &(_, xp)) in &qz.xp {
		let q = t.quests.get(&id.to_string());
		let Some(xp) = xp else { continue };
		if q.is_undef() {
			continue;
		}
		q.set("xp", xp);
		stats.quest_xp += 1;
	}
	// Follow-up: the single quest listing this one as a prerequisite.
	let mut successors: IndexMap<String, Vec<V>> = IndexMap::new();
	for q in t.quests.values() {
		for p in q.get("pre").items() {
			successors.entry(p.to_js_string()).or_default().push(q.get("id"));
		}
	}
	for (p, list) in &successors {
		let q = t.quests.get(p);
		if !q.is_undef() && matches!(q.get("next"), V::Null) && list.len() == 1 && t.quests.has(&list[0].to_js_string()) {
			q.set("next", list[0].clone());
		}
	}
	for tab in [t.npcs, t.objects, t.items] {
		for e in tab.values() {
			if !e.get("source").truthy() {
				e.set("source", strs(&["pfquest"]));
			}
		}
	}
	for q in t.quests.values() {
		let mut bad = vec![q.get("id").num()];
		bad.extend(crate::jsv::num_list(&q.get("excl")));
		let mut touched = false;
		for key in ["pre", "preAll", "preAny"] {
			let l = q.get(key);
			if !l.is_arr() {
				continue;
			}
			let items = l.items();
			let kept: Vec<V> = items.iter().filter(|p| !bad.iter().any(|b| p.as_num() == Some(*b))).cloned().collect();
			if kept.len() == items.len() {
				continue;
			}
			touched = true;
			if key == "pre" || !kept.is_empty() {
				q.set(key, arr(kept));
			} else {
				q.as_obj().unwrap().delete(key);
			}
		}
		if touched {
			stats.prereqs_cleaned += 1;
		}
	}
	stats
}
