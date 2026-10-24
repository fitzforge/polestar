//! Recorder overlay (port of tools/lib/data/recordings.js): data/recordings/*.json, live Forever
//! observations, applied over the merged tables. See the JS file's header for every rule.

use std::path::Path;

use forge_guide::js::{cmp_utf16, parse_json, stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};
use rustc_hash::FxHashMap;
use sha2::{Digest, Sha256};

use crate::jsv::{arr, hypot, nums, round2};
use crate::objectives::parse_progress_text;
use crate::spawns::{points_of, reduce_spawns, spawn_record, SpawnOptions, P};

pub struct Recording {
	pub file: String,
	pub rec: V,
}

pub fn read_recordings(dir: &Path) -> Result<Vec<Recording>, String> {
	let Ok(rd) = std::fs::read_dir(dir) else { return Ok(Vec::new()) };
	let mut files: Vec<String> = rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).filter(|f| f.ends_with(".json")).collect();
	files.sort_by(|a, b| cmp_utf16(a, b));
	let mut out = Vec::new();
	for file in files {
		let text = std::fs::read_to_string(dir.join(&file)).map_err(|e| format!("recording {file}: {e}"))?;
		let rec = parse_json(&text).map_err(|e| format!("recording {file}: {e}"))?;
		if rec.get("schema").as_num() != Some(1.0) || !rec.get("events").is_arr() {
			return Err(format!("recording {file}: expected {{ schema: 1, events: [...] }}"));
		}
		out.push(Recording { file, rec });
	}
	Ok(out)
}

/// meta.json's revision of the recordings: sha256 over file names and contents, 16 hex digits.
pub fn revision(recs: &[Recording]) -> String {
	let mut h = Sha256::new();
	for r in recs {
		h.update(r.file.as_bytes());
		h.update(b"\0");
		h.update(stringify(&r.rec, None).as_bytes());
		h.update(b"\0");
	}
	h.finalize().iter().map(|b| format!("{b:02x}")).collect::<String>()[..16].to_string()
}

fn pos_int(v: &V) -> Option<i64> {
	let n = v.num();
	(n.is_finite() && n.fract() == 0.0 && n > 0.0).then_some(n as i64)
}

struct Coord {
	map: i64,
	x: f64,
	y: f64,
}

fn coord(ev: &V) -> Option<Coord> {
	let map = pos_int(&ev.get("map"))?;
	let (x, y) = (ev.get("x").num(), ev.get("y").num());
	if !x.is_finite() || !y.is_finite() || !(0.0..=100.0).contains(&x) || !(0.0..=100.0).contains(&y) {
		return None;
	}
	Some(Coord { map, x, y })
}

fn same(a: &V, b: &str) -> bool {
	a.as_str().is_some_and(|a| a.trim().to_lowercase() == b.trim().to_lowercase())
}

fn ids(v: &V) -> Vec<i64> {
	let mut out: Vec<i64> = Vec::new();
	if v.is_arr() {
		for x in v.items() {
			if let Some(n) = pos_int(&x) {
				if !out.contains(&n) {
					out.push(n);
				}
			}
		}
	}
	out
}

fn front(list: &V, id: i64) {
	if !list.items().iter().any(|x| x.as_num() == Some(id as f64)) {
		if let V::Arr(a) = list {
			a.0.borrow_mut().insert(0, V::Num(id as f64));
		}
	}
}

fn new_quest(id: i64) -> Obj {
	let o = Obj::new();
	o.set("id", id as f64);
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
	o.set("source", arr(vec![V::str("recorder")]));
	o
}

fn has_str(list: &V, s: &str) -> bool {
	list.items().iter().any(|x| x.as_str() == Some(s))
}

fn canonical(e: &V, keys: &[&str]) -> V {
	let src = e.as_obj().unwrap();
	let out = Obj::new();
	for k in keys {
		if src.has(k) {
			out.set(k, src.get(k));
		}
	}
	for (k, v) in src.entries() {
		if !out.has(&k) {
			out.set_str(k, v);
		}
	}
	V::Obj(out)
}

const NPC_KEYS: [&str; 10] = ["id", "name", "level", "levelMax", "rank", "faction", "roles", "spawns", "instances", "encounter"];
const OBJECT_KEYS: [&str; 6] = ["id", "name", "roles", "faction", "spawns", "instances"];
/// sim-v2: objects carry no side.
const OBJECT_KEYS_SIM: [&str; 5] = ["id", "name", "roles", "spawns", "instances"];
const QUEST_KEYS: [&str; 20] =
	["id", "title", "level", "minLevel", "races", "classes", "start", "end", "pre", "excl", "next", "objectives", "objectiveText", "zone", "xp", "xpSamples", "rewards", "skill", "event", "source"];
const FACTION_KEYS: [&str; 5] = ["id", "name", "side", "parent", "source"];
const MIN_KILLS: f64 = 10.0;
const ENTRANCE_RADIUS: f64 = 1.5;
const FULL_XP_LEVELS: f64 = 5.0;

fn rank_of(cls: &str) -> Option<f64> {
	Some(match cls {
		"normal" | "trivial" | "minus" => 0.0,
		"elite" => 1.0,
		"rareelite" => 2.0,
		"worldboss" => 3.0,
		"rare" => 4.0,
		_ => return None,
	})
}

pub struct Db<'a> {
	pub quests: &'a Obj,
	pub npcs: &'a Obj,
	pub objects: &'a Obj,
	pub items: &'a Obj,
	pub zones: &'a Obj,
	pub factions: &'a Obj,
	pub instances: &'a Obj,
}

#[derive(Default)]
pub struct Stats {
	pub recordings: usize,
	pub events: usize,
	pub recorder_only_quests: usize,
	pub touched_quests: usize,
	pub recorder_only_factions: usize,
	pub recorded_kills: usize,
	pub recorded_loots: usize,
	pub recorded_sightings: usize,
	pub recorded_drop_chances: usize,
	pub recorded_treasures: usize,
	pub recorded_instances: usize,
	pub recorded_encounters: usize,
}

type ByMap = IndexMap<i64, Vec<P>>;

struct Inst {
	name: Option<String>,
	kind: Option<String>,
	encounters: IndexMap<i64, Enc>,
}

struct Enc {
	name: Option<String>,
	npcs: IndexSet<i64>,
	kills: usize,
}

struct Overlay<'a> {
	db: &'a Db<'a>,
	so: SpawnOptions,
	live_maps: &'a dyn Fn(i64) -> bool,
	stats: Stats,
	touched: IndexSet<i64>,
	touched_entities: IndexMap<String, (&'static str, i64)>,
	live: [IndexMap<i64, ByMap>; 2],
	recorded_objectives: IndexMap<i64, IndexMap<i64, Slot>>,
	xp_seen: IndexMap<i64, Vec<(&'static str, i64, Option<i64>)>>,
	faction_parent: IndexMap<i64, i64>,
	faction_side: FxHashMap<i64, String>,
	rewards: FxHashMap<i64, (u8, V)>,
	// finds
	kills: FxHashMap<i64, f64>,
	windows: [FxHashMap<i64, f64>; 2],
	loots: [IndexMap<i64, IndexMap<i64, f64>>; 2],
	found: [IndexMap<i64, ByMap>; 2],
	killed: IndexMap<i64, ByMap>,
	rank: IndexMap<i64, f64>,
	levels: IndexMap<i64, (i64, i64)>,
	roles: [IndexMap<i64, IndexSet<String>>; 2],
	inside: [IndexMap<i64, IndexSet<i64>>; 2],
	encounter_of: IndexMap<i64, i64>,
	entrances: IndexMap<i64, ByMap>,
	inst: IndexMap<i64, Inst>,
}

#[derive(Default)]
struct Slot {
	name: Option<String>,
	max: Option<f64>,
	kind: Option<String>,
	id: Option<i64>,
}

fn table_of<'a>(db: &'a Db, kind: &str) -> &'a Obj {
	if kind == "npc" {
		db.npcs
	} else {
		db.objects
	}
}

fn k_ix(kind: &str) -> usize {
	if kind == "npc" {
		0
	} else {
		1
	}
}

fn push_point(m: &mut IndexMap<i64, ByMap>, id: i64, c: &Coord) {
	m.entry(id).or_default().entry(c.map).or_default().push([c.x, c.y]);
}

impl<'a> Overlay<'a> {
	fn quest(&mut self, id: i64) -> V {
		let k = id.to_string();
		if !self.db.quests.has(&k) {
			self.db.quests.set(&k, new_quest(id));
			self.stats.recorder_only_quests += 1;
		}
		self.touched.insert(id);
		self.db.quests.get(&k)
	}

	fn entity(&mut self, kind: &'static str, id: i64, name: &V) -> V {
		let t = table_of(self.db, kind);
		let k = id.to_string();
		if !t.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			if kind == "npc" {
				o.set("level", V::Null);
				o.set("faction", V::Null);
			}
			o.set("spawns", Obj::new());
			t.set(&k, o);
		}
		let e = t.get(&k);
		if let Some(n) = name.as_str().filter(|n| !n.is_empty()) {
			e.set("name", n);
		}
		self.touched_entities.insert(format!("{kind}:{id}"), (kind, id));
		e
	}

	fn item_entry(&mut self, id: i64, name: &V) {
		let k = id.to_string();
		if !self.db.items.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			let d = Obj::new();
			d.set("npc", Obj::new());
			d.set("object", Obj::new());
			o.set("drops", d);
			o.set("vendors", V::arr());
			self.db.items.set(&k, o);
		}
		if let Some(n) = name.as_str().filter(|n| !n.is_empty()) {
			self.db.items.get(&k).set("name", n);
		}
	}

	fn live_point(&mut self, kind: &'static str, id: i64, name: &V, ev: &V) -> V {
		let e = self.entity(kind, id, name);
		if let Some(c) = coord(ev) {
			push_point(&mut self.live[k_ix(kind)], id, &c);
		}
		e
	}

	fn xp_obs(&mut self, qid: i64, kind: &'static str, value: &V, lvl: &V) {
		let Some(xp) = pos_int(value) else { return };
		self.xp_seen.entry(qid).or_default().push((kind, xp, pos_int(lvl)));
	}

	fn slot(&mut self, q: i64, oi: i64) -> &mut Slot {
		self.recorded_objectives.entry(q).or_default().entry(oi).or_default()
	}

	fn faction(&mut self, id: i64, name: &V) -> V {
		let k = id.to_string();
		if !self.db.factions.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			o.set("side", V::Null);
			o.set("parent", V::Null);
			o.set("source", V::arr());
			self.db.factions.set(&k, o);
			self.stats.recorder_only_factions += 1;
		}
		let f = self.db.factions.get(&k);
		if let Some(n) = name.as_str() {
			if !n.trim().is_empty() {
				f.set("name", n.trim());
			}
		}
		let src = f.get("source");
		if !has_str(&src, "recorder") {
			src.push("recorder");
		}
		f
	}

	fn faction_dump(&mut self, dump: &V) {
		let entries: Vec<(V, V)> = match dump {
			V::Arr(_) => dump.items().into_iter().map(|d| (if d.truthy() { d.get("id") } else { d.clone() }, d)).collect(),
			V::Obj(o) => o.entries().into_iter().map(|(k, v)| (V::Str(k), v)).collect(),
			_ => Vec::new(),
		};
		for (key, d) in entries {
			let id = pos_int(&key).or_else(|| {
				if d.truthy() {
					pos_int(&{
						let i = d.get("id");
						if i.is_nullish() {
							d.get("factionID")
						} else {
							i
						}
					})
				} else {
					None
				}
			});
			let Some(id) = id else { continue };
			if !d.is_obj() {
				continue;
			}
			self.faction(id, &d.get("name"));
			let p = {
				let a = d.get("parent");
				if !a.is_nullish() {
					a
				} else {
					let b = d.get("parentID");
					if !b.is_nullish() {
						b
					} else {
						d.get("parentFactionID")
					}
				}
			};
			if let Some(p) = pos_int(&p) {
				if p != id {
					self.faction_parent.insert(id, p);
				}
			}
			if let Some(s) = d.get("side").as_str().filter(|s| *s == "Alliance" || *s == "Horde") {
				self.faction_side.insert(id, s.to_string());
			}
		}
	}

	fn rewards_observe(&mut self, qid: i64, ev: &V, weight: u8) {
		let items = ids(&ev.get("items"));
		let choices = ids(&ev.get("choices"));
		let frame_money = pos_int(&ev.get("rewardMoney"));
		if items.is_empty() && choices.is_empty() && frame_money.is_none() {
			return;
		}
		let money = frame_money.or(if weight == 2 { pos_int(&ev.get("money")) } else { None });
		if let Some((w, _)) = self.rewards.get(&qid) {
			if *w > weight {
				return;
			}
		}
		let o = Obj::new();
		o.set("items", nums(&items.iter().map(|&x| x as f64).collect::<Vec<_>>()));
		o.set("choices", nums(&choices.iter().map(|&x| x as f64).collect::<Vec<_>>()));
		o.set("money", money.map(|m| V::Num(m as f64)).unwrap_or(V::Null));
		self.rewards.insert(qid, (weight, V::Obj(o)));
	}

	// ---- finds
	fn unit(&mut self, id: i64, ev: &V) {
		self.entity("npc", id, &ev.get("npcName"));
		let cls = ev.get("cls").to_js_string();
		if ev.get("cls").is_str() || !ev.get("cls").is_undef() {
			if let Some(r) = rank_of(&cls) {
				self.rank.insert(id, r);
			}
		}
		if cls == "rare" || cls == "rareelite" {
			self.roles[0].entry(id).or_default().insert("rare".into());
		}
		if let Some(l) = pos_int(&ev.get("npcLvl")) {
			let r = self.levels.get(&id).map(|&(a, b)| (a.min(l), b.max(l))).unwrap_or((l, l));
			self.levels.insert(id, r);
		}
		self.where_(0, id, ev);
	}

	fn where_(&mut self, k: usize, id: i64, ev: &V) {
		if let Some(i) = pos_int(&ev.get("inst")) {
			self.inside[k].entry(id).or_default().insert(i);
		}
	}

	fn instance(&mut self, id: i64, ev: &V) -> &mut Inst {
		let i = self.inst.entry(id).or_insert_with(|| Inst { name: None, kind: None, encounters: IndexMap::new() });
		if let Some(n) = ev.get("instName").as_str().filter(|n| !n.is_empty()) {
			i.name = Some(n.to_string());
		}
		if let Some(t) = ev.get("instType").as_str().filter(|t| *t == "party" || *t == "raid") {
			i.kind = Some(t.to_string());
		}
		i
	}

	fn handle_find(&mut self, ev: &V) -> bool {
		let npc = pos_int(&ev.get("npc"));
		let obj = pos_int(&ev.get("object"));
		match ev.get("e").as_str().unwrap_or("") {
			"rare" => {
				let Some(npc) = npc else { return true };
				self.unit(npc, ev);
				self.roles[0].entry(npc).or_default().insert("rare".into());
				if let Some(c) = coord(ev) {
					push_point(&mut self.found[0], npc, &c);
				}
				self.stats.recorded_sightings += 1;
				true
			}
			"treasure" => {
				let Some(obj) = obj else { return true };
				self.entity("object", obj, &ev.get("objName"));
				self.roles[1].entry(obj).or_default().insert("chest".into());
				if let Some(c) = coord(ev) {
					push_point(&mut self.found[1], obj, &c);
				}
				self.where_(1, obj, ev);
				self.stats.recorded_sightings += 1;
				true
			}
			"slain" => {
				let Some(npc) = npc else { return true };
				self.unit(npc, ev);
				if let Some(c) = coord(ev) {
					push_point(&mut self.killed, npc, &c);
				}
				if !ev.get("denied").truthy() {
					*self.kills.entry(npc).or_insert(0.0) += 1.0;
				}
				self.stats.recorded_kills += 1;
				true
			}
			"drop" => {
				let list: Vec<V> = ev.get("items").items().into_iter().filter(|i| i.truthy() && pos_int(&i.get("item")).is_some()).collect();
				let kind = if npc.is_some() {
					Some("npc")
				} else if obj.is_some() {
					Some("object")
				} else {
					None
				};
				let gather = ev.get("gather");
				if kind.is_none() || (kind == Some("npc") && gather.truthy()) {
					if let Some(n) = npc {
						self.unit(n, ev);
					}
					return true;
				}
				let kind = kind.unwrap();
				let id = npc.or(obj).unwrap();
				if kind == "npc" {
					self.unit(id, ev);
				} else {
					self.entity("object", id, &ev.get("objName"));
					self.where_(1, id, ev);
					if let Some(c) = coord(ev) {
						push_point(&mut self.found[1], id, &c);
					}
					let role = match gather.as_str() {
						Some("herb") => Some("herb"),
						Some("mine") => Some("mine"),
						_ if !gather.truthy() && list.iter().any(|i| !i.get("q").truthy()) => Some("chest"),
						_ => None,
					};
					if let Some(r) = role {
						self.roles[1].entry(id).or_default().insert(r.into());
					}
				}
				let k = k_ix(kind);
				*self.windows[k].entry(id).or_insert(0.0) += 1.0;
				let mut seen: IndexSet<i64> = IndexSet::new();
				for i in &list {
					seen.insert(pos_int(&i.get("item")).unwrap());
				}
				for item in seen {
					*self.loots[k].entry(id).or_default().entry(item).or_insert(0.0) += 1.0;
					self.item_entry(item, &V::Undef);
				}
				self.loots[k].entry(id).or_default();
				self.stats.recorded_loots += 1;
				true
			}
			"enter" => {
				let Some(id) = pos_int(&ev.get("inst")) else { return true };
				self.instance(id, ev);
				if let Some(c) = coord(ev) {
					push_point(&mut self.entrances, id, &c);
				}
				true
			}
			"encounter" => {
				let id = pos_int(&ev.get("inst"));
				let Some(enc) = pos_int(&ev.get("enc")) else { return true };
				let bosses = ids(&ev.get("npcs"));
				for &b in &bosses {
					self.entity("npc", b, &V::Null);
					self.encounter_of.insert(b, enc);
					if let Some(i) = id {
						self.inside[0].entry(b).or_default().insert(i);
					}
				}
				let Some(id) = id else { return true };
				let ok = ev.get("ok").truthy();
				let enc_name = ev.get("encName");
				let e = self.instance(id, ev).encounters.entry(enc).or_insert_with(|| Enc { name: None, npcs: IndexSet::new(), kills: 0 });
				if let Some(n) = enc_name.as_str().filter(|n| !n.is_empty()) {
					e.name = Some(n.to_string());
				}
				for b in bosses {
					e.npcs.insert(b);
				}
				if ok {
					e.kills += 1;
				}
				true
			}
			_ => false,
		}
	}

	fn join(&self, e: &V, by_map: &ByMap, fill_only: bool) {
		let spawns = e.get("spawns");
		for (&map, pts) in by_map {
			let cur = spawns.get(&map.to_string());
			if !cur.is_undef() && (fill_only || (cur.get("f").as_str() != Some("l") && (self.live_maps)(map))) {
				continue;
			}
			let all: Vec<P> = if cur.is_undef() { pts.clone() } else { points_of(&cur.get("pts")).into_iter().chain(points_of(&cur.get("more"))).chain(pts.iter().copied()).collect() };
			let r = reduce_spawns(&all, self.so);
			if !r.pts.is_empty() {
				let f = if cur.is_undef() { "l".to_string() } else { cur.get("f").to_js_string() };
				spawns.set(&map.to_string(), spawn_record(&f, &r));
			}
		}
	}

	fn apply_finds(&mut self) {
		let db = self.db;
		let mut chances = 0;
		for kind in ["npc", "object"] {
			let k = k_ix(kind);
			for (&id, m) in &self.loots[k] {
				let of = if kind == "npc" {
					self.kills.get(&id).copied().unwrap_or(0.0).max(self.windows[0].get(&id).copied().unwrap_or(0.0))
				} else {
					self.windows[1].get(&id).copied().unwrap_or(f64::NAN)
				};
				for (&item, &n) in m {
					let it = db.items.get(&item.to_string());
					if !it.truthy() {
						continue;
					}
					if !it.get("drops").truthy() {
						let d = Obj::new();
						d.set("npc", Obj::new());
						d.set("object", Obj::new());
						it.set("drops", d);
					}
					if !it.get("drops").get(kind).truthy() {
						it.get("drops").set(kind, Obj::new());
					}
					let cur = it.get("drops").get(kind).get(&id.to_string());
					if of >= MIN_KILLS || cur.is_nullish() {
						it.get("drops").get(kind).set(&id.to_string(), round2((100.0 * n) / of));
						chances += 1;
					}
					if !it.get("seen").truthy() {
						it.set("seen", Obj::new());
					}
					if !it.get("seen").get(kind).truthy() {
						it.get("seen").set(kind, Obj::new());
					}
					let s = Obj::new();
					s.set("n", n);
					s.set("of", of);
					it.get("seen").get(kind).set(&id.to_string(), s);
					let src = it.get("source");
					if src.is_arr() {
						if !has_str(&src, "recorder") {
							src.push("recorder");
						}
					} else if !src.truthy() {
						it.set("source", arr(vec![V::str("recorder")]));
					}
				}
			}
		}
		for (&id, &r) in &self.rank {
			db.npcs.get(&id.to_string()).set("rank", r);
		}
		for (&id, &(lo, hi)) in &self.levels {
			let e = db.npcs.get(&id.to_string());
			let lvl = e.get("level").as_num().filter(|x| x.fract() == 0.0);
			let lmax = e.get("levelMax").as_num().filter(|x| x.fract() == 0.0);
			let min = lvl.map_or(lo as f64, |l| l.min(lo as f64));
			let max = (lmax.or(lvl).unwrap_or(hi as f64)).max(hi as f64);
			e.set("level", min);
			if max > min {
				e.set("levelMax", max);
			} else {
				e.as_obj().unwrap().delete("levelMax");
			}
		}
		let mut treasures = 0;
		for kind in ["npc", "object"] {
			let k = k_ix(kind);
			let t = table_of(db, kind);
			for (&id, set) in &self.roles[k] {
				let e = t.get(&id.to_string());
				let mut all: Vec<String> = e.get("roles").items().iter().map(V::to_js_string).collect();
				for r in set {
					if !all.contains(r) {
						all.push(r.clone());
					}
				}
				let mut dedup: Vec<String> = Vec::new();
				for r in all {
					if !dedup.contains(&r) {
						dedup.push(r);
					}
				}
				dedup.sort_by(|a, b| cmp_utf16(a, b));
				e.set("roles", arr(dedup.into_iter().map(V::from).collect()));
				if kind == "object" && set.contains("chest") {
					treasures += 1;
				}
			}
			for (&id, set) in &self.inside[k] {
				let e = t.get(&id.to_string());
				let mut all: Vec<f64> = e.get("instances").items().iter().map(V::num).collect();
				for &i in set {
					if !all.contains(&(i as f64)) {
						all.push(i as f64);
					}
				}
				all.sort_by(|a, b| a.partial_cmp(b).unwrap());
				e.set("instances", nums(&all));
			}
			for (&id, by_map) in &self.found[k] {
				self.join(&t.get(&id.to_string()), by_map, false);
			}
		}
		for (&id, by_map) in &self.killed {
			self.join(&db.npcs.get(&id.to_string()), by_map, true);
		}
		for (&id, &enc) in &self.encounter_of {
			db.npcs.get(&id.to_string()).set("encounter", enc as f64);
		}
		let mut encounters = 0;
		let mut ids: Vec<i64> = self.inst.keys().copied().collect();
		ids.sort();
		for id in ids {
			let i = &self.inst[&id];
			let cur = db.instances.get(&id.to_string());
			let out = if cur.truthy() {
				cur
			} else {
				let o = Obj::new();
				o.set("id", id as f64);
				o.set("name", V::Null);
				o.set("type", V::Null);
				o.set("entrances", V::arr());
				o.set("encounters", Obj::new());
				o.set("source", V::arr());
				V::Obj(o)
			};
			if let Some(n) = &i.name {
				out.set("name", n.as_str());
			}
			if let Some(t) = &i.kind {
				out.set("type", t.as_str());
			}
			if let Some(pts) = self.entrances.get(&id) {
				let mut maps: Vec<(&i64, &Vec<P>)> = pts.iter().collect();
				maps.sort_by_key(|(m, _)| **m);
				let mut list: Vec<(i64, f64, f64, usize)> = Vec::new();
				for (&map, l) in maps {
					for (x, y, n) in clusters(l, ENTRANCE_RADIUS) {
						list.push((map, x, y, n));
					}
				}
				list.sort_by(|a, b| b.3.cmp(&a.3).then(a.0.cmp(&b.0)));
				out.set(
					"entrances",
					arr(list
						.into_iter()
						.map(|(map, x, y, n)| {
							let o = Obj::new();
							o.set("map", map as f64);
							o.set("x", x);
							o.set("y", y);
							o.set("n", n);
							V::Obj(o)
						})
						.collect()),
				);
			}
			let mut encs: Vec<(&i64, &Enc)> = i.encounters.iter().collect();
			encs.sort_by_key(|(k, _)| **k);
			for (&enc, e) in encs {
				let o = Obj::new();
				o.set("name", e.name.as_deref().map(V::str).unwrap_or(V::Null));
				let mut n: Vec<f64> = e.npcs.iter().map(|&x| x as f64).collect();
				n.sort_by(|a, b| a.partial_cmp(b).unwrap());
				o.set("npcs", nums(&n));
				o.set("kills", e.kills);
				out.get("encounters").set(&enc.to_string(), o);
				encounters += 1;
			}
			let src = out.get("source");
			if !has_str(&src, "recorder") {
				src.push("recorder");
			}
			db.instances.set(&id.to_string(), out);
		}
		self.stats.recorded_drop_chances = chances;
		self.stats.recorded_treasures = treasures;
		self.stats.recorded_instances = self.inst.len();
		self.stats.recorded_encounters = encounters;
	}
}

/// Greedy clusters within `radius` -> (x, y, n), biggest first, then by x, y.
fn clusters(points: &[P], radius: f64) -> Vec<(f64, f64, usize)> {
	let mut out: Vec<(f64, f64, usize)> = Vec::new();
	for &[x, y] in points {
		match out.iter_mut().find(|k| hypot(k.0 / k.2 as f64 - x, k.1 / k.2 as f64 - y) <= radius) {
			Some(c) => {
				c.0 += x;
				c.1 += y;
				c.2 += 1;
			}
			None => out.push((x, y, 1)),
		}
	}
	let mut r: Vec<(f64, f64, usize)> = out.into_iter().map(|(sx, sy, n)| (round2(sx / n as f64), round2(sy / n as f64), n)).collect();
	r.sort_by(|a, b| b.2.cmp(&a.2).then(a.0.partial_cmp(&b.0).unwrap()).then(a.1.partial_cmp(&b.1).unwrap()));
	r
}

/// Recorded objectives matched to existing ones (by name, else id); recorded counts win and
/// recorded indices reorder; unmatched ones are appended.
fn merge_objectives(q: &V, slots: &IndexMap<i64, Slot>) {
	let objs = q.get("objectives");
	let mut list: Vec<V> = objs.items();
	let mut oi_of: IndexMap<usize, i64> = IndexMap::new();
	let mut keys: Vec<i64> = slots.keys().copied().collect();
	keys.sort();
	for oi in keys {
		let s = &slots[&oi];
		let mut idx = s.name.as_ref().and_then(|name| {
			list.iter().enumerate().position(|(i, o)| {
				!oi_of.contains_key(&i)
					&& !name.is_empty()
					&& (same(&o.get("text"), name) || o.get("text").as_str().is_some_and(|t| format!("{t}s").trim().to_lowercase() == name.trim().to_lowercase()))
			})
		});
		if idx.is_none() {
			if let Some(id) = s.id {
				idx =
					list.iter().enumerate().position(|(i, o)| !oi_of.contains_key(&i) && o.get("id").as_num() == Some(id as f64) && s.kind.as_ref().is_none_or(|k| o.get("type").as_str() == Some(k)));
			}
		}
		let idx = match idx {
			None => {
				let o = Obj::new();
				o.set("type", s.kind.clone().unwrap_or_else(|| "event".into()));
				o.set("id", s.id.map(|x| V::Num(x as f64)).unwrap_or(V::Null));
				o.set("count", s.max.filter(|m| *m != 0.0).map(V::Num).unwrap_or(V::Null));
				o.set("text", s.name.clone().filter(|n| !n.is_empty()).map(V::from).unwrap_or(V::Null));
				list.push(V::Obj(o));
				list.len() - 1
			}
			Some(i) => {
				if let Some(m) = s.max.filter(|m| *m != 0.0) {
					list[i].set("count", m);
				}
				i
			}
		};
		oi_of.insert(idx, oi);
	}
	let n = list.len();
	let mut result: Vec<Option<V>> = vec![None; n];
	let mut rest: std::collections::VecDeque<V> = std::collections::VecDeque::new();
	for (i, o) in list.into_iter().enumerate() {
		match oi_of.get(&i) {
			Some(&oi) if oi - 1 < n as i64 && result[(oi - 1) as usize].is_none() => result[(oi - 1) as usize] = Some(o),
			_ => rest.push_back(o),
		}
	}
	let out: Vec<V> = result.into_iter().map(|r| r.or_else(|| rest.pop_front()).unwrap_or(V::Undef)).collect();
	q.set("objectives", arr(out));
}

fn resolve_xp(q: &V, list: &[(&'static str, i64, Option<i64>)]) {
	let mut pick: Vec<&(&str, i64, Option<i64>)> = list.iter().filter(|o| o.0 == "base").collect();
	if pick.is_empty() {
		let level = q.get("level");
		pick = list.iter().filter(|o| o.0 != "base" && (matches!(level, V::Null) || o.2.is_some_and(|l| (l as f64) <= level.num() + FULL_XP_LEVELS))).collect();
	}
	let Some(&first) = pick.first() else { return };
	let mut best = first;
	for o in &pick {
		if o.1 > best.1 {
			best = o;
		}
	}
	q.set("xp", best.1 as f64);
	q.set("xpSamples", pick.len());
	let tag = format!("recorder:xp-{}", best.0);
	let src = q.get("source");
	if !has_str(&src, &tag) {
		src.push(tag.as_str());
	}
}

fn resolve_factions(factions: &Obj, parents: &IndexMap<i64, i64>, sides: &FxHashMap<i64, String>) {
	let parent_of = |id: i64| factions.get(&id.to_string()).get("parent").as_num().map(|p| p as i64);
	let ancestor_of = |id: i64, target: i64| {
		let mut seen = rustc_hash::FxHashSet::default();
		let mut cur = Some(id);
		while let Some(c) = cur.filter(|c| *c != 0 && !seen.contains(c)) {
			if c == target {
				return true;
			}
			seen.insert(c);
			cur = if factions.has(&c.to_string()) { parent_of(c) } else { None };
		}
		false
	};
	let mut ids: Vec<i64> = parents.keys().copied().collect();
	ids.sort();
	for id in ids {
		let f = factions.get(&id.to_string());
		let p = parents[&id];
		if matches!(f.get("parent"), V::Null) && factions.has(&p.to_string()) && !ancestor_of(p, id) {
			f.set("parent", p as f64);
		}
	}
	let side_of = |id: i64| -> V {
		let mut seen = rustc_hash::FxHashSet::default();
		let mut cur = Some(id);
		while let Some(c) = cur.filter(|c| *c != 0 && factions.has(&c.to_string()) && !seen.contains(c)) {
			seen.insert(c);
			let s = factions.get(&c.to_string()).get("side");
			if s.truthy() {
				return s;
			}
			if let Some(x) = sides.get(&c) {
				return V::str(x);
			}
			cur = parent_of(c);
		}
		V::Null
	};
	for key in factions.keys() {
		let f = factions.get(&key);
		if !has_str(&f.get("source"), "recorder") {
			continue;
		}
		if !f.get("side").truthy() {
			f.set("side", side_of(f.get("id").num() as i64));
		}
		factions.set_str(key, canonical(&f, &FACTION_KEYS));
	}
}

pub fn apply_recordings(db: &Db, recordings: &[Recording], so: SpawnOptions, live_maps: &dyn Fn(i64) -> bool, sim: bool) -> Stats {
	let mut ov = Overlay {
		db,
		so,
		live_maps,
		stats: Stats { recordings: recordings.len(), ..Stats::default() },
		touched: IndexSet::new(),
		touched_entities: IndexMap::new(),
		live: Default::default(),
		recorded_objectives: IndexMap::new(),
		xp_seen: IndexMap::new(),
		faction_parent: IndexMap::new(),
		faction_side: FxHashMap::default(),
		rewards: FxHashMap::default(),
		kills: FxHashMap::default(),
		windows: Default::default(),
		loots: Default::default(),
		found: Default::default(),
		killed: IndexMap::new(),
		rank: IndexMap::new(),
		levels: IndexMap::new(),
		roles: Default::default(),
		inside: Default::default(),
		encounter_of: IndexMap::new(),
		entrances: IndexMap::new(),
		inst: IndexMap::new(),
	};
	for Recording { rec, .. } in recordings {
		for (map_id, m) in rec.get("maps").entries() {
			let Some(id) = pos_int(&V::Str(map_id)) else { continue };
			if !db.zones.has(&id.to_string()) && m.truthy() && m.get("name").is_str() {
				let z = Obj::new();
				z.set("id", id as f64);
				z.set("name", m.get("name"));
				z.set("areaId", V::Null);
				z.set("parent", pos_int(&m.get("parent")).map(|p| V::Num(p as f64)).unwrap_or(V::Null));
				let t = m.get("type").num();
				z.set("type", if t.is_finite() { V::Num(t) } else { V::Null });
				db.zones.set(&id.to_string(), z);
			}
		}
		ov.faction_dump(&rec.get("factions"));
		for ev in rec.get("events").items() {
			let Some(e) = ev.get("e").as_rc_str() else { continue };
			if !ev.truthy() {
				continue;
			}
			ov.stats.events += 1;
			let qid = pos_int(&ev.get("q"));
			let npc = pos_int(&ev.get("npc"));
			match (&*e, qid) {
				("accept", Some(qid)) => {
					let q = ov.quest(qid);
					if let Some(t) = ev.get("title").as_str().filter(|t| !t.is_empty()) {
						q.set("title", t);
					}
					if let Some(l) = pos_int(&ev.get("qlvl")) {
						q.set("level", l as f64);
					}
					ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
					ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
					if let Some(n) = npc {
						front(&q.get("start").get("npc"), n);
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						front(&q.get("start").get("object"), o);
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
					if let Some(i) = pos_int(&ev.get("item")) {
						front(&q.get("start").get("item"), i);
					}
					if let Some(c) = coord(&ev) {
						if !q.get("zone").truthy() {
							q.set("zone", c.map as f64);
						}
					}
					ov.rewards_observe(qid, &ev, 1);
				}
				("turnin", Some(qid)) => {
					let q = ov.quest(qid);
					ov.xp_obs(qid, "turnin", &ev.get("xpReward"), &ev.get("lvl"));
					if let Some(n) = npc {
						front(&q.get("end").get("npc"), n);
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						front(&q.get("end").get("object"), o);
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
					ov.rewards_observe(qid, &ev, 2);
				}
				("reward", Some(qid)) => {
					ov.quest(qid);
					ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
					ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
				}
				("progress", Some(qid)) => {
					ov.quest(qid);
					let oi = pos_int(&ev.get("oi"));
					let p = ev.get("text").as_str().and_then(parse_progress_text);
					let (Some(oi), Some(p)) = (oi, p) else { continue };
					let kind = match ev.get("type").as_str() {
						Some("monster") => Some("kill"),
						Some("item") => Some("item"),
						Some("object") => Some("object"),
						_ => None,
					};
					let s = ov.slot(qid, oi);
					s.name = Some(p.name);
					s.max = Some(s.max.unwrap_or(0.0).max(p.max));
					s.kind = kind.map(str::to_string).or(s.kind.take()).or(if p.slain { Some("kill".into()) } else { None });
				}
				("kill" | "loot", _) => {
					let id = if &*e == "kill" { npc } else { pos_int(&ev.get("item")) };
					let Some(id) = id else { continue };
					if &*e == "kill" {
						ov.entity("npc", id, &ev.get("npcName"));
					} else {
						ov.item_entry(id, &ev.get("itemName"));
					}
					if let (Some(q), Some(oi)) = (qid, pos_int(&ev.get("oi"))) {
						let kind = if &*e == "kill" { "kill" } else { "item" };
						let s = ov.slot(q, oi);
						s.id = Some(id);
						if s.kind.is_none() {
							s.kind = Some(kind.into());
						}
					}
				}
				_ => {
					if ov.handle_find(&ev) {
					} else if let (Some(role), Some(n)) = (
						match &*e {
							"gossip" => Some(None),
							"trainer" => Some(Some("trainer")),
							"vendor" => Some(Some("vendor")),
							"fp" => Some(Some("flightmaster")),
							_ => None,
						},
						npc,
					) {
						let ent = ov.live_point("npc", n, &ev.get("npcName"), &ev);
						if let Some(r) = role {
							let mut roles: Vec<String> = ent.get("roles").items().iter().map(V::to_js_string).collect();
							if !roles.iter().any(|x| x == r) {
								roles.push(r.into());
							}
							roles.sort_by(|a, b| cmp_utf16(a, b));
							ent.set("roles", arr(roles.into_iter().map(V::from).collect()));
						}
					} else if &*e == "rep" {
						if let Some(id) = pos_int(&ev.get("faction")) {
							ov.faction(id, &ev.get("factionName"));
						}
					}
				}
			}
		}
	}
	let objectives = std::mem::take(&mut ov.recorded_objectives);
	for (qid, slots) in &objectives {
		let q = db.quests.get(&qid.to_string());
		if q.truthy() {
			merge_objectives(&q, slots);
		}
	}
	for kind in ["npc", "object"] {
		let t = table_of(db, kind);
		for (&id, by_map) in &ov.live[k_ix(kind)] {
			let e = t.get(&id.to_string());
			for (&map, pts) in by_map {
				let r = reduce_spawns(pts, so);
				if r.pts.is_empty() {
					continue;
				}
				e.get("spawns").set(&map.to_string(), spawn_record("l", &r));
			}
		}
	}
	ov.apply_finds();
	for (kind, id) in ov.touched_entities.values() {
		let t = table_of(db, kind);
		let k = id.to_string();
		t.set(
			&k,
			canonical(
				&t.get(&k),
				if *kind == "npc" {
					&NPC_KEYS[..]
				} else if sim {
					&OBJECT_KEYS_SIM[..]
				} else {
					&OBJECT_KEYS[..]
				},
			),
		);
	}
	let mut touched: Vec<i64> = ov.touched.iter().copied().collect();
	touched.sort();
	for id in touched {
		let q = db.quests.get(&id.to_string());
		let src = q.get("source");
		if !has_str(&src, "recorder") {
			src.push("recorder");
		}
		if let Some(list) = ov.xp_seen.get(&id) {
			resolve_xp(&q, list);
		}
		if let Some((_, r)) = ov.rewards.get(&id) {
			q.set("rewards", r.clone());
		}
		db.quests.set(&id.to_string(), canonical(&q, &QUEST_KEYS));
	}
	ov.stats.touched_quests = ov.touched.len();
	resolve_factions(db.factions, &ov.faction_parent, &ov.faction_side);
	ov.stats
}
