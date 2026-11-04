//! tools/lib/codex/instances.js: the Codex's dungeons and raids from release-safe facts (the
//! Forever client's tables, npcs.json / items.json / objects.json, Recorder entrances, the curated
//! entrance table, guides' gotos, the cached web facts), and journal.js `zonePoint`.

use std::collections::BTreeSet;
use std::path::Path;
use std::sync::LazyLock;

use forge_guide::js::{str_to_num, Obj, V};
use regex::Regex;
use rustc_hash::{FxHashMap, FxHashSet};

use super::client::InstanceFacts;
use super::util::{by_num, key, kstr, math_round, norm, norm_s, num0, oentries, ord, round1, slug};

const MIN_LOOT: f64 = 1.0;
const OWN_LOOT: f64 = 5.0;
const BOSS_LOOT_CAP: usize = 30;
const ORIGINAL_MAPS: f64 = 1000.0;
const MAX_LEVEL: f64 = 60.0;
const ZONE_MAX: f64 = 20000.0;

static JUNK_NPC: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?i)^(?:\[|zz|Test |Monster - )|\(DND\)|(?-u:\b)DND(?-u:\b)|Trigger|Bunny|Invisible").unwrap());
static SKIP_MAP: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?i)^(?:<unused>|Test Dungeon|CashTest)|(?-u:\b)Test(?-u:\b)").unwrap());

/// journal.js `zonePoint(frames, c, wx, wy, prefer)` -> { map, x, y, f: null }.
pub fn zone_point(frames: &V, c: f64, wx: f64, wy: f64, prefer: &[f64]) -> Option<(f64, f64, f64)> {
	let mut best: Option<(f64, f64, f64, f64)> = None;
	for (id, f) in oentries(frames) {
		if f.get("c").num() != c {
			continue;
		}
		let (left, right, top, bottom) = (f.get("left").num(), f.get("right").num(), f.get("top").num(), f.get("bottom").num());
		let w = left - right;
		let h = top - bottom;
		if !(w > 0.0 && h > 0.0) || w > ZONE_MAX || h > ZONE_MAX {
			continue;
		}
		let x = ((left - wy) / w) * 100.0;
		let y = ((top - wx) / h) * 100.0;
		if x < 0.0 || x > 100.0 || y < 0.0 || y > 100.0 {
			continue;
		}
		let idn = str_to_num(&id);
		let off = (if prefer.contains(&idn) { 0.0 } else { 1e6 }) + (x - 50.0).powi(2) + (y - 50.0).powi(2);
		if best.is_none_or(|b| off < b.3) {
			best = Some((idn, round1(x), round1(y), off));
		}
	}
	best.map(|b| (b.0, b.1, b.2))
}

/// A `goto x,y "<label>"` line of a guide (curatedEntrances).
#[derive(Clone, Debug)]
pub struct GuideGoto {
	pub label: String,
	pub map: Option<f64>,
	pub zone: Option<String>,
	pub x: f64,
	pub y: f64,
}

/// instances.js `curatedEntrances(dir)`.
pub fn curated_entrances(dir: &Path) -> Vec<GuideGoto> {
	let mut out = Vec::new();
	if !dir.exists() {
		return out;
	}
	let mut files = forge_guide::project::find_guide_files(dir, false);
	files.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	for rel in files {
		let Ok(text) = std::fs::read_to_string(dir.join(&rel)) else { continue };
		let mut diag = forge_guide::diag::Diagnostics::new();
		let ast = forge_guide::parse::parse_guide(&text, &rel, &mut diag);
		for step in ast.get("steps").items() {
			for g in step.get("goals").items() {
				let text = g.get("text");
				if g.get("verb").as_str() != Some("goto") || !text.truthy() || g.get("x").is_nullish() {
					continue;
				}
				let zone = g.get("zone");
				let zone = if zone.truthy() { zone } else { V::Null };
				let cm = g.get("coordMap");
				let map = if !cm.is_nullish() {
					cm
				} else if zone.truthy() && !zone.get("map").is_nullish() {
					zone.get("map")
				} else {
					V::Null
				};
				out.push(GuideGoto {
					label: text.to_js_string(),
					map: (!map.is_nullish()).then(|| map.num()),
					zone: (zone.truthy() && zone.get("name").truthy()).then(|| zone.get("name").to_js_string()),
					x: g.get("x").num(),
					y: g.get("y").num(),
				});
			}
		}
	}
	out
}

/// An entrance: { map, x, y, f, approx? }.
pub fn entrance_v(map: f64, x: f64, y: f64, era: bool, approx: bool) -> V {
	let o = Obj::new();
	o.set("map", map);
	o.set("x", x);
	o.set("y", y);
	o.set("f", if era { V::str("e") } else { V::Null });
	if approx {
		o.set("approx", true);
	}
	V::Obj(o)
}

/// instances.js `chooseEntrance`: a table entry's `A` (the Alliance's own way in) rides along as entrance.A.
fn choose_entrance(name: &str, recorded: &V, table: &V, guides: &[GuideGoto], corpse: Option<&super::client::Corpse>, zones: &V, frames: &V, prefer: &[f64]) -> V {
	let e = choose_entrance_point(name, recorded, table, guides, corpse, zones, frames, prefer);
	let a = table.get("A");
	if let (Some(o), true) = (e.as_obj(), table.truthy() && a.get("map").truthy()) {
		let ao = Obj::new();
		ao.set("map", a.get("map").num());
		ao.set("x", round1(a.get("x").num()));
		ao.set("y", round1(a.get("y").num()));
		o.set("A", V::Obj(ao));
	}
	e
}

/// instances.js `chooseEntrancePoint`.
fn choose_entrance_point(name: &str, recorded: &V, table: &V, guides: &[GuideGoto], corpse: Option<&super::client::Corpse>, zones: &V, frames: &V, prefer: &[f64]) -> V {
	let mut rec = recorded.items();
	rec.sort_by(|a, b| ord(num0(&b.get("n")) - num0(&a.get("n"))));
	if let Some(r) = rec.first() {
		if r.get("map").truthy() {
			return entrance_v(r.get("map").num(), round1(r.get("x").num()), round1(r.get("y").num()), r.get("f").as_str() == Some("e"), false);
		}
	}
	if table.truthy() && table.get("map").truthy() {
		return entrance_v(table.get("map").num(), round1(table.get("x").num()), round1(table.get("y").num()), false, false);
	}
	let n = norm_s(name);
	let zone_id = |zname: &str| -> Option<f64> {
		let nz = norm_s(zname);
		zones.values().into_iter().find(|z| norm(&z.get("name")) == nz).map(|z| z.get("id").num())
	};
	let g = guides
		.iter()
		.find(|c| n.len() >= 5 && norm_s(&c.label).contains(&n) && (c.map.is_some_and(|m| m != 0.0) || c.zone.as_deref().is_some_and(|z| !z.is_empty() && zone_id(z).is_some_and(|x| x != 0.0))));
	if let Some(g) = g {
		let map = match g.map.filter(|m| *m != 0.0) {
			Some(m) => V::Num(m),
			None => g.zone.as_deref().and_then(zone_id).map(V::Num).unwrap_or(V::Null),
		};
		let o = Obj::new();
		o.set("map", map);
		o.set("x", round1(g.x));
		o.set("y", round1(g.y));
		o.set("f", V::Null);
		return V::Obj(o);
	}
	let Some(corpse) = corpse else { return V::Null };
	match zone_point(frames, corpse.c, corpse.x, corpse.y, prefer) {
		Some((map, x, y)) => entrance_v(map, x, y, false, true),
		None => V::Null,
	}
}

fn edit_within(a: &[u16], b: &[u16], max: usize) -> bool {
	if a.len().abs_diff(b.len()) > max {
		return false;
	}
	let mut prev: Vec<usize> = (0..=b.len()).collect();
	for i in 1..=a.len() {
		let mut cur = vec![i; b.len() + 1];
		let mut low = i;
		for j in 1..=b.len() {
			cur[j] = (prev[j] + 1).min(cur[j - 1] + 1).min(prev[j - 1] + usize::from(a[i - 1] != b[j - 1]));
			low = low.min(cur[j]);
		}
		if low > max {
			return false;
		}
		prev = cur;
	}
	prev[b.len()] <= max
}

pub struct Ctx<'a> {
	pub npcs: &'a V,
	pub items: &'a V,
	pub objects: &'a V,
	pub zones: &'a V,
	pub frames: &'a V,
	pub recorded: &'a V,
	pub entrance_table: &'a V,
	pub curated: &'a [GuideGoto],
	pub quality: &'a dyn Fn(f64) -> Option<f64>,
	pub web: Option<&'a V>,
}

pub struct Built {
	/// key -> Instance (insertion order).
	pub instances: Vec<(String, V)>,
	pub boss_instance: Vec<(f64, String)>,
	pub npc_instance: Vec<(f64, String)>,
}

/// (item, chance|null, common)
type LootRow = (f64, Option<f64>, bool);

fn chance_of(d: &V) -> f64 {
	math_round((d.get("count").num() / d.get("outof").num()) * 10000.0) / 100.0
}

fn spawnless(n: &V) -> bool {
	!n.get("spawns").values().iter().any(|s| s.truthy() && !s.get("pts").items().is_empty())
}

/// instances.js `buildInstances(facts, ctx)`.
pub fn build_instances(facts: &InstanceFacts, ctx: &Ctx) -> Built {
	let npcs_in = ctx.npcs;
	let items_in = ctx.items;
	let lfg = &facts.lfg_names;
	let empty = V::obj();
	let wh_npc = ctx.web.map(|w| w.get("npc")).filter(V::is_obj).unwrap_or_else(|| empty.clone());
	let wh_object = ctx.web.map(|w| w.get("object")).filter(V::is_obj).unwrap_or_else(|| empty.clone());

	let mut by_name: FxHashMap<String, Vec<f64>> = FxHashMap::default();
	let mut by_name_order: Vec<String> = Vec::new();
	let npc_entries = oentries(npcs_in);
	for (id, n) in &npc_entries {
		let k = norm(&n.get("name"));
		if !k.is_empty() {
			let e = by_name.entry(k.clone()).or_default();
			if e.is_empty() {
				by_name_order.push(k);
			}
			e.push(str_to_num(id));
		}
	}
	let npc_of = |id: f64| npcs_in.get(&key(id));
	// Object.keys(byName): index-like keys first, ascending.
	let (mut idx, rest): (Vec<String>, Vec<String>) = by_name_order.into_iter().partition(|k| super::util::index_key(k));
	idx.sort_by_key(|k| k.parse::<u64>().unwrap_or(0));
	idx.extend(rest);
	let by_name_order = idx;
	let spawnless_names: Vec<String> = by_name_order.iter().filter(|k| by_name[*k].iter().any(|&id| spawnless(&npc_of(id)))).cloned().collect();
	let mut wh_common: FxHashSet<(String, String)> = FxHashSet::default();
	let wh_npc_entries = oentries(&wh_npc);
	for (npc, w) in &wh_npc_entries {
		for d in w.get("drops").items() {
			if d.get("common").truthy() {
				wh_common.insert((npc.to_string(), kstr(&d.get("item"))));
			}
		}
	}
	let mut loot_of: FxHashMap<String, Vec<LootRow>> = FxHashMap::default();
	let item_entries = oentries(items_in);
	for (id, it) in &item_entries {
		for (npc, chance) in oentries(&it.get("drops").get("npc")) {
			let c = if matches!(chance, V::Null) { None } else { Some(chance.num()) };
			if let Some(c) = c {
				if !(c >= MIN_LOOT) {
					continue;
				}
			}
			let common = wh_common.contains(&(npc.to_string(), id.to_string()));
			loot_of.entry(npc.to_string()).or_default().push((str_to_num(id), c, common));
		}
	}
	for (npc, w) in &wh_npc_entries {
		for d in w.get("drops").items() {
			let c = chance_of(&d);
			let common = d.get("common").truthy();
			if !common || c >= MIN_LOOT {
				loot_of.entry(npc.to_string()).or_default().push((d.get("item").num(), Some(c), common));
			}
		}
	}
	let mut droppers: FxHashMap<String, BTreeSet<i64>> = FxHashMap::default();
	for (id, it) in &item_entries {
		for npc in it.get("drops").get("npc").keys() {
			droppers.entry(id.to_string()).or_default().insert(str_to_num(&npc) as i64);
		}
	}
	for (npc, w) in &wh_npc_entries {
		for d in w.get("drops").items() {
			if !d.get("common").truthy() {
				droppers.entry(kstr(&d.get("item"))).or_default().insert(str_to_num(npc) as i64);
			}
		}
	}
	let boss_items = |rows: &[LootRow]| -> Vec<f64> {
		let mut loot: Vec<(f64, Option<f64>, bool)> = Vec::new();
		let mut ix: FxHashMap<u64, usize> = FxHashMap::default();
		for &(item, c, common) in rows {
			match ix.get(&item.to_bits()) {
				None => {
					ix.insert(item.to_bits(), loot.len());
					loot.push((item, c, common));
				}
				Some(&i) => {
					let l = &mut loot[i];
					if let Some(c) = c {
						// `!(l.c >= c)`: null compares as 0.
						if !(l.1.unwrap_or(0.0) >= c) {
							l.1 = Some(c);
						}
					}
					if !common {
						l.2 = false;
					}
				}
			}
		}
		loot.sort_by(|a, b| {
			let d = (a.2 as i32 - b.2 as i32) as f64;
			let d = if d != 0.0 { d } else { b.1.unwrap_or(-1.0) - a.1.unwrap_or(-1.0) };
			ord(if d != 0.0 { d } else { a.0 - b.0 })
		});
		loot.into_iter().take(BOSS_LOOT_CAP).map(|l| l.0).collect()
	};
	let objects_in = ctx.objects;
	let obj_key = |id: &str| -> String {
		let o = objects_in.get(id).get("name");
		let w = wh_object.get(id).get("name");
		let name = if o.truthy() {
			o
		} else if w.truthy() {
			w
		} else {
			V::str(id)
		};
		format!("o{}", norm(&name))
	};
	let mut obj_loot_of: FxHashMap<String, Vec<LootRow>> = FxHashMap::default();
	let mut yielders: FxHashMap<String, FxHashSet<String>> = FxHashMap::default();
	for (id, it) in &item_entries {
		for npc in it.get("drops").get("npc").keys() {
			yielders.entry(id.to_string()).or_default().insert(format!("n{npc}"));
		}
		for (obj, chance) in oentries(&it.get("drops").get("object")) {
			yielders.entry(id.to_string()).or_default().insert(obj_key(&obj));
			let c = if matches!(chance, V::Null) { None } else { Some(chance.num()) };
			if c.is_none_or(|c| c >= MIN_LOOT) {
				obj_loot_of.entry(obj.to_string()).or_default().push((str_to_num(id), c, false));
			}
		}
	}
	for (npc, w) in &wh_npc_entries {
		for d in w.get("drops").items() {
			if !d.get("common").truthy() {
				yielders.entry(kstr(&d.get("item"))).or_default().insert(format!("n{npc}"));
			}
		}
	}
	for (obj, w) in oentries(&wh_object) {
		for d in w.get("drops").items() {
			if !d.get("common").truthy() {
				yielders.entry(kstr(&d.get("item"))).or_default().insert(obj_key(&obj));
			}
			let c = chance_of(&d);
			if c >= MIN_LOOT {
				obj_loot_of.entry(obj.to_string()).or_default().push((d.get("item").num(), Some(c), d.get("common").truthy()));
			}
		}
	}
	let mut map_of_area: FxHashMap<i64, f64> = FxHashMap::default();
	for m in &facts.maps {
		for &a in &m.inner {
			map_of_area.entry(a as i64).or_insert(m.id);
		}
	}
	// whMaps(w): the instance maps of the web facts' `location` areas, in first-seen order.
	let wh_maps = |w: &V| -> Vec<f64> {
		let mut out: Vec<f64> = Vec::new();
		for a in w.get("location").items() {
			if let Some(&m) = map_of_area.get(&(a.num() as i64)) {
				if m != 0.0 && !out.contains(&m) {
					out.push(m);
				}
			}
		}
		out
	};
	let id_union = |a: &V, b: &V| -> Vec<f64> {
		let mut s: BTreeSet<i64> = BTreeSet::new();
		let mut odd: Vec<f64> = Vec::new();
		for k in a.keys().into_iter().chain(b.keys()) {
			let n = str_to_num(&k);
			if n.fract() == 0.0 && n.is_finite() {
				s.insert(n as i64);
			} else if !odd.iter().any(|x| x.to_bits() == n.to_bits()) {
				odd.push(n);
			}
		}
		let mut out: Vec<f64> = s.into_iter().map(|x| x as f64).collect();
		out.extend(odd);
		out.sort_by(|a, b| by_num(*a, *b));
		out
	};
	let npc_ids = id_union(npcs_in, &wh_npc);
	let object_ids = id_union(objects_in, &wh_object);
	let npc_name = |id: f64| -> Option<String> {
		let a = npc_of(id).get("name");
		if a.truthy() {
			return Some(a.to_js_string());
		}
		let b = wh_npc.get(&key(id)).get("name");
		b.truthy().then(|| b.to_js_string())
	};
	let obj_name = |id: f64| -> Option<String> {
		let a = objects_in.get(&key(id)).get("name");
		if a.truthy() {
			return Some(a.to_js_string());
		}
		let b = wh_object.get(&key(id)).get("name");
		b.truthy().then(|| b.to_js_string())
	};
	let npc_level = |id: f64| -> f64 {
		let n = npc_of(id);
		let lv = if n.truthy() {
			let m = n.get("levelMax");
			if m.truthy() {
				m
			} else {
				n.get("level")
			}
		} else {
			V::Undef
		};
		let a = num0(&lv);
		if a != 0.0 {
			return a;
		}
		let w = wh_npc.get(&key(id));
		let l = if w.truthy() && w.get("level").truthy() { w.get("level").at(1) } else { V::Undef };
		num0(&l)
	};
	// Where each NPC and object is placed (placedIn's maps), and the ones that can be a boss.
	let places = |rec: &V, w: &V| -> Vec<f64> {
		let mut maps: Vec<f64> = rec.get("instances").items().iter().map(V::num).collect();
		maps.extend(wh_maps(w));
		maps
	};
	let npc_places: FxHashMap<u64, Vec<f64>> = npc_ids.iter().map(|&id| (id.to_bits(), places(&npc_of(id), &wh_npc.get(&key(id))))).collect();
	let placed_npc = |id: f64, map: f64| npc_places.get(&id.to_bits()).is_some_and(|m| m.contains(&map));
	let npc_cands: Vec<f64> =
		npc_ids.iter().copied().filter(|id| npc_places.get(&id.to_bits()).is_some_and(|m| !m.is_empty())).filter(|&id| npc_name(id).is_some_and(|n| !JUNK_NPC.is_match(&n))).collect();
	let obj_cands: Vec<(f64, Vec<f64>)> = object_ids
		.iter()
		.filter_map(|&id| {
			let name = obj_name(id)?;
			let o = objects_in.get(&key(id));
			if JUNK_NPC.is_match(&name) || o.get("roles").items().iter().any(|r| r.as_str() != Some("chest")) {
				return None;
			}
			let maps = places(&o, &wh_object.get(&key(id)));
			(!maps.is_empty()).then_some((id, maps))
		})
		.collect();
	let mut instances: Vec<(String, V)> = Vec::new();
	let mut boss_instance: Vec<(f64, String)> = Vec::new();
	let mut boss_has: FxHashSet<u64> = FxHashSet::default();
	let empty_obj = V::obj();
	for m in &facts.maps {
		if m.name.is_empty() || SKIP_MAP.is_match(&m.name) {
			continue;
		}
		let enc = facts.encounters.get(&(m.id as i64)).cloned().unwrap_or_default();
		if !lfg.contains(&norm_s(&m.name)) && !(m.id < ORIGINAL_MAPS && !enc.is_empty()) {
			continue;
		}
		let mut k = slug(&m.name);
		if instances.iter().any(|(x, _)| *x == k) {
			k = format!("{k}-{}", key(m.id));
		}
		let rec = ctx.recorded.get(&key(m.id));
		let rec = if rec.truthy() { rec } else { empty_obj.clone() };
		let rec_enc = rec.get("encounters");
		let level = facts.rec_min.get(&(m.id as i64)).copied().filter(|l| *l != 0.0);
		let forever = facts.era.as_ref().map(|e| !e.contains(&(m.id as i64))).unwrap_or(false);
		let pick = |name: &str| -> Option<f64> {
			let n = norm_s(name);
			let ids: Vec<f64> = by_name.get(&n).cloned().unwrap_or_default();
			let mut inside: Vec<f64> = ids.iter().copied().filter(|&id| placed_npc(id, m.id)).collect();
			if !inside.is_empty() {
				inside.sort_by(|a, b| by_num(*a, *b));
				return Some(inside[0]);
			}
			let elite = |id: f64| num0(&npc_of(id).get("rank")) >= 1.0;
			let d = |id: f64| -> f64 {
				let lv = num0(&npc_of(id).get("level"));
				match level {
					Some(l) if lv != 0.0 => (lv - l).abs(),
					_ => 0.0,
				}
			};
			let era = |id: f64| npc_of(id).get("source").items().iter().any(|s| s.as_str() == Some("pfquest"));
			let score = |id: f64| -> f64 { (if forever && era(id) { 4.0 } else { 0.0 }) + (if spawnless(&npc_of(id)) { 0.0 } else { 2.0 }) + (if elite(id) { 0.0 } else { 1.0 }) };
			if !ids.is_empty() {
				let mut s = ids.clone();
				s.sort_by(|a, b| {
					let x = score(*a) - score(*b);
					let x = if x != 0.0 { x } else { d(*a) - d(*b) };
					ord(if x != 0.0 { x } else { a - b })
				});
				return Some(s[0]);
			}
			if n.len() < 6 {
				return None;
			}
			let nu: Vec<u16> = n.encode_utf16().collect();
			let mut hits: Vec<f64> = Vec::new();
			for kname in &spawnless_names {
				if kname.starts_with(&n) || edit_within(&kname.encode_utf16().collect::<Vec<u16>>(), &nu, 2) {
					for &id in &by_name[kname] {
						if spawnless(&npc_of(id)) && !hits.contains(&id) {
							hits.push(id);
						}
					}
				}
			}
			if hits.len() == 1 {
				return Some(hits[0]);
			}
			let placed: Vec<f64> = hits.into_iter().filter(|&id| placed_npc(id, m.id)).collect();
			(placed.len() == 1).then(|| placed[0])
		};
		struct Boss {
			name: String,
			npcs: Vec<f64>,
			object: Option<f64>,
			items: Vec<f64>,
			role: Option<&'static str>,
			encounter: Option<f64>,
		}
		let mut bosses: Vec<Boss> = Vec::new();
		let objects_inside: Vec<f64> = obj_cands.iter().filter(|(_, maps)| maps.contains(&m.id)).map(|(id, _)| *id).collect();
		for e in &enc {
			let rec_npcs: Vec<f64> = rec_enc.get(&key(e.id)).get("npcs").items().iter().map(V::num).filter(|&id| npc_of(id).truthy()).collect();
			let mut npcs = rec_npcs;
			if npcs.is_empty() {
				if let Some(one) = pick(&e.name) {
					npcs = vec![one];
				} else {
					static SPLIT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\s+and\s+|\s*&\s*").unwrap());
					let parts: Vec<&str> = SPLIT.split(&e.name).filter(|p| !p.trim().is_empty()).collect();
					if parts.len() > 1 {
						npcs = parts.iter().filter_map(|p| pick(p)).filter(|x| *x != 0.0).collect();
					}
				}
			}
			let mut uniq: Vec<f64> = Vec::new();
			for id in npcs {
				if !uniq.contains(&id) {
					uniq.push(id);
				}
			}
			let npcs = uniq;
			let en = norm_s(&e.name);
			let object = if !npcs.is_empty() || en.len() < 5 {
				None
			} else {
				objects_inside.iter().copied().find(|&id| norm_s(&obj_name(id).unwrap_or_default()).ends_with(&en) && obj_loot_of.get(&key(id)).is_some_and(|l| !l.is_empty()))
			};
			let mut rows: Vec<LootRow> = npcs.iter().flat_map(|id| loot_of.get(&key(*id)).cloned().unwrap_or_default()).collect();
			if let Some(o) = object {
				rows.extend(obj_loot_of.get(&key(o)).cloned().unwrap_or_default());
			}
			let items = boss_items(&rows);
			for &id in &npcs {
				if boss_has.insert(id.to_bits()) {
					boss_instance.push((id, k.clone()));
				}
			}
			bosses.push(Boss { name: e.name.clone(), npcs, object, items, role: None, encounter: Some(e.id) });
		}
		let taken: FxHashSet<u64> = bosses.iter().flat_map(|b| b.npcs.iter().map(|x| x.to_bits())).collect();
		let mut extra: Vec<(f64, &'static str)> = Vec::new();
		for &nid in &npc_cands {
			if taken.contains(&nid.to_bits()) || !placed_npc(nid, m.id) {
				continue;
			}
			let n = npc_of(nid);
			let w = wh_npc.get(&key(nid));
			let rank = num0(&n.get("rank"));
			let wc = w.get("classification");
			let wc = wc.as_str().unwrap_or("");
			let rare = rank == 2.0 || rank == 4.0 || (w.truthy() && (wc == "rare" || wc == "rareelite"));
			let ranked = rare || rank == 3.0 || (w.truthy() && (wc == "boss" || w.get("boss").truthy()));
			let own = loot_of.get(&key(nid)).is_some_and(|rows| {
				rows.iter().any(|&(item, c, _)| c.is_some_and(|c| c >= OWN_LOOT) && (ctx.quality)(item).unwrap_or(0.0) >= 2.0 && droppers.get(&key(item)).is_some_and(|s| s.len() == 1))
			});
			if !ranked && !own {
				continue;
			}
			let placed = n.truthy() && (!n.get("instances").items().is_empty() || !spawnless(&n));
			extra.push((
				nid,
				if rare {
					"rare"
				} else if placed {
					"optional"
				} else {
					"event"
				},
			));
		}
		extra.sort_by(|a, b| {
			let d = npc_level(a.0) - npc_level(b.0);
			ord(if d != 0.0 { d } else { a.0 - b.0 })
		});
		for (id, role) in extra {
			bosses.push(Boss {
				name: npc_name(id).unwrap_or_default(),
				npcs: vec![id],
				object: None,
				items: boss_items(&loot_of.get(&key(id)).cloned().unwrap_or_default()),
				role: Some(role),
				encounter: None,
			});
			if boss_has.insert(id.to_bits()) {
				boss_instance.push((id, k.clone()));
			}
		}
		let mut chests: FxHashSet<String> = bosses.iter().filter_map(|b| b.object.map(|o| obj_key(&key(o)))).collect();
		for &id in &objects_inside {
			let ok = obj_key(&key(id));
			if chests.contains(&ok) {
				continue;
			}
			let rows = obj_loot_of.get(&key(id)).cloned().unwrap_or_default();
			let own = rows.iter().any(|&(item, c, _)| c.is_none_or(|c| c >= OWN_LOOT) && (ctx.quality)(item).unwrap_or(0.0) >= 2.0 && yielders.get(&key(item)).is_some_and(|s| s.len() == 1));
			let distinct: FxHashSet<u64> = rows.iter().map(|r| r.0.to_bits()).collect();
			if !own || distinct.len() < 2 {
				continue;
			}
			chests.insert(ok);
			bosses.push(Boss { name: obj_name(id).unwrap_or_default(), npcs: Vec::new(), object: Some(id), items: boss_items(&rows), role: Some("optional"), encounter: None });
		}
		let boss_levels: Vec<f64> = bosses.iter().flat_map(|b| b.npcs.iter().map(|&id| npc_level(id))).filter(|l| *l > 0.0).collect();
		let entry = facts.entry.get(&(m.id as i64)).copied().filter(|e| *e != 0.0);
		let min = match (level, entry) {
			(Some(l), Some(e)) => Some(l.max(e)),
			(l, _) => l,
		};
		let mut max = if boss_levels.is_empty() { None } else { Some(MAX_LEVEL.min(boss_levels.iter().copied().fold(f64::NEG_INFINITY, f64::max))) };
		if let (Some(x), Some(n)) = (max, min) {
			if x < n {
				max = Some(n);
			}
		}
		let levels = if min.is_some() || entry.is_some() || max.is_some() { V::from(vec![super::util::opt(entry), super::util::opt(min.or(max)), super::util::opt(max.or(min))]) } else { V::Null };
		let prefer: Vec<f64> = ctx.zones.values().into_iter().filter(|z| z.get("areaId").truthy() && m.zones.contains(&z.get("areaId").num())).map(|z| z.get("id").num()).collect();
		let entrance = choose_entrance(&m.name, &rec.get("entrances"), &ctx.entrance_table.get(&k), ctx.curated, m.corpse.as_ref(), ctx.zones, ctx.frames, &prefer);
		let inst = Obj::new();
		inst.set("key", k.as_str());
		inst.set("name", m.name.as_str());
		inst.set("kind", if m.raid { "raid" } else { "dungeon" });
		inst.set("forever", forever);
		inst.set("areaId", super::util::opt(m.area));
		inst.set("map", m.id);
		inst.set("entrance", entrance);
		inst.set("levels", levels);
		let bv: Vec<V> = bosses
			.iter()
			.map(|b| {
				let o = Obj::new();
				o.set("name", b.name.as_str());
				o.set("npc", b.npcs.first().map(|&x| V::Num(x)).unwrap_or(V::Null));
				o.set("items", super::util::nums(&b.items));
				if let Some(ob) = b.object.filter(|x| *x != 0.0) {
					o.set("object", ob);
				}
				if let Some(r) = b.role {
					o.set("role", r);
				}
				if let Some(e) = b.encounter.filter(|x| *x != 0.0) {
					o.set("encounter", e);
				}
				V::Obj(o)
			})
			.collect();
		inst.set("bosses", V::from(bv));
		instances.push((k, V::Obj(inst)));
	}
	let mut key_of_map: FxHashMap<u64, String> = FxHashMap::default();
	for (k, inst) in &instances {
		key_of_map.insert(inst.get("map").num().to_bits(), k.clone());
	}
	let mut npc_instance = boss_instance.clone();
	let mut has: FxHashSet<u64> = boss_has.clone();
	for &id in &npc_ids {
		if has.contains(&id.to_bits()) {
			continue;
		}
		let mut maps: Vec<f64> = npc_of(id).get("instances").items().iter().map(V::num).collect();
		maps.extend(wh_maps(&wh_npc.get(&key(id))));
		if let Some(k) = maps.iter().find_map(|x| key_of_map.get(&x.to_bits())) {
			has.insert(id.to_bits());
			npc_instance.push((id, k.clone()));
		}
	}
	Built { instances, boss_instance, npc_instance }
}

/// instances.js `loadEntranceTable()`: entrances.json -> { key: entry }.
pub fn load_entrance_table(text: &str) -> Result<V, String> {
	let raw = forge_guide::js::parse_json(text)?;
	let out = Obj::new();
	for e in raw.get("entrances").items() {
		out.set(&kstr(&e.get("key")), e.clone());
	}
	Ok(V::Obj(out))
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;

	#[test]
	fn a_table_entry_s_alliance_way_in_rides_along_as_entrance_a_whichever_point_wins_706() {
		let dalaran = parse_json(r#"{ "key": "city-of-dalaran", "map": 1416, "x": 8.5, "y": 59.2, "A": { "map": 1416, "x": 14.68, "y": 62.99 } }"#).unwrap();
		let none = V::Null;
		let e = choose_entrance("City of Dalaran", &none, &dalaran, &[], None, &none, &none, &[]);
		assert_eq!(e.get("A").get("map").num(), 1416.0);
		assert_eq!((e.get("A").get("x").num(), e.get("A").get("y").num()), (14.7, 63.0));
		assert_eq!((e.get("x").num(), e.get("y").num()), (8.5, 59.2));
		let recorded = parse_json(r#"[{ "map": 1416, "x": 8.6, "y": 59.3, "n": 1 }]"#).unwrap();
		let rec = choose_entrance("City of Dalaran", &recorded, &dalaran, &[], None, &none, &none, &[]);
		assert_eq!(rec.get("x").num(), 8.6, "the recording wins");
		assert_eq!(rec.get("A").get("x").num(), 14.7, "and keeps the Alliance way in");
		let one = parse_json(r#"{ "key": "deadmines", "map": 1436, "x": 42.5, "y": 71.7 }"#).unwrap();
		assert!(!choose_entrance("Deadmines", &none, &one, &[], None, &none, &none, &[]).get("A").truthy(), "one way in: no A");
	}

	#[test]
	fn the_curated_table_sends_the_alliance_into_the_city_of_dalaran_through_cantrips_and_crows() {
		let text = std::fs::read_to_string(concat!(env!("CARGO_MANIFEST_DIR"), "/../../../data/codex/entrances.json")).unwrap();
		let d = load_entrance_table(&text).unwrap().get("city-of-dalaran");
		let a = d.get("A");
		assert_eq!((a.get("map").num(), a.get("x").num(), a.get("y").num()), (1416.0, 14.7, 63.0));
		assert!(a.get("source").as_str().is_some_and(|s| s.starts_with("https://")));
		assert!(a.get("note").truthy());
	}
}
