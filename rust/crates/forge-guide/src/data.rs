//! Reference data with the resolver's lookups. Port of tools/lib/dsl/data.js.
//! Tables stay JS values (`V`), so every port reads them as the JS does; the loader takes file texts
//! ([`Data::from_texts`]) so the core API needs no file system ([`load_data`] reads a folder, native only).

use crate::js::{is_integer, parse_json, V};
use crate::obj;
use rustc_hash::FxHashMap;
use std::cell::RefCell;

pub const FILES: [&str; 7] = ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"];
pub const OPTIONAL: [&str; 7] = ["professions", "factions", "trainers", "races", "travel", "spawnz", "moves"];

/// Classic skill lines (game facts), so `skill <Profession> <N>` resolves without professions.json.
pub const BUILTIN_PROFESSIONS: [(u32, &str); 13] = [
	(171, "Alchemy"),
	(164, "Blacksmithing"),
	(333, "Enchanting"),
	(202, "Engineering"),
	(182, "Herbalism"),
	(165, "Leatherworking"),
	(186, "Mining"),
	(393, "Skinning"),
	(197, "Tailoring"),
	(185, "Cooking"),
	(356, "Fishing"),
	(129, "First Aid"),
	(762, "Riding"),
];

fn builtin(i: usize) -> V {
	let (id, name) = BUILTIN_PROFESSIONS[i];
	obj! { "id" => id, "name" => name }.into()
}

pub fn zone_type_rank(t: &V) -> i32 {
	match t.as_num() {
		Some(3.0) => 0,
		Some(n) if n == 4.0 || n == 5.0 || n == 6.0 => 1,
		_ => 2,
	}
}

fn lower_key(s: &str) -> String {
	s.trim().to_lowercase()
}

/// Ids of a JS object's keys that are integers, ascending (`Object.keys(raw).map(Number).filter(isInteger)`).
fn int_ids(raw: &V) -> Vec<f64> {
	let mut ids: Vec<f64> = raw.keys().iter().map(|k| crate::js::str_to_num(k)).filter(|n| is_integer(*n) && raw.get(&crate::js::num_str(*n)).is_object()).collect();
	ids.sort_by(|a, b| a.partial_cmp(b).unwrap());
	ids
}

pub struct Data {
	pub quests: V,
	pub npcs: V,
	pub objects: V,
	pub items: V,
	pub zones: V,
	pub map_frames: V,
	pub meta: V,
	pub dir: Option<String>,
	pub missing: Vec<String>,
	pub missing_core: Vec<String>,
	pub has_professions: bool,
	pub has_factions: bool,
	pub has_trainers: bool,
	pub trainers_raw: V,
	pub races: V,
	pub travel: V,
	/// spawnz.json ({ npc, object } -> id -> [[instance map, x, y, z]]) or Null.
	pub spawnz: V,
	/// moves.json ({ npc } -> id -> [[instance map, x, y, centre x, centre y, radius]]: the ground a
	/// walking creature's spawn covers, world yards) or Null.
	pub moves: V,
	/// solo.js loadInstances ({ areas, maps }) or Null.
	pub instances: V,
	/// tools/lib/data/areas.js loadAreas or Null.
	pub areas: V,
	pub professions: FxHashMap<i64, V>,
	pub profession_by_name: FxHashMap<String, V>,
	pub recipe_by_spell: FxHashMap<i64, V>,
	pub factions: FxHashMap<i64, V>,
	pub faction_by_name: FxHashMap<String, Vec<V>>,
	pub zone_by_name: FxHashMap<String, Vec<V>>,
	pub has_xp: bool,
	class_trainers: RefCell<Option<V>>,
	roles: RefCell<FxHashMap<String, Vec<f64>>>,
	/// Memo slots for ports that cache per data object (JS WeakMap/WeakSet keyed by data).
	pub memo: RefCell<FxHashMap<&'static str, V>>,
}

/// The raw tables by file name (without `.json`), plus `instances` and `areas`.
pub struct Raw {
	pub tables: FxHashMap<String, V>,
	pub instances: V,
	pub areas: V,
}

impl Data {
	/// `new Data(raw, { dir, missing })`.
	pub fn new(raw: Raw, dir: Option<String>, missing: Vec<String>) -> Data {
		let t = |n: &str| raw.tables.get(n).cloned().filter(|v| !v.is_nullish()).unwrap_or_else(V::obj);
		let missing_core = missing.iter().filter(|f| FILES.contains(&f.trim_end_matches(".json"))).cloned().collect();
		let has = |f: &str| !missing.iter().any(|m| m == f);
		let spawnz = raw.tables.get("spawnz").cloned().unwrap_or_default();
		let spawnz = if spawnz.is_obj() && has("spawnz.json") { spawnz } else { V::Null };
		let moves = raw.tables.get("moves").cloned().unwrap_or_default();
		let moves = if moves.is_obj() && has("moves.json") { moves } else { V::Null };
		let mut d = Data {
			quests: t("quests"),
			npcs: t("npcs"),
			objects: t("objects"),
			items: t("items"),
			zones: t("zones"),
			map_frames: t("map-frames"),
			meta: t("meta"),
			dir,
			missing_core,
			has_professions: has("professions.json"),
			has_factions: has("factions.json"),
			has_trainers: has("trainers.json"),
			trainers_raw: t("trainers"),
			races: t("races"),
			travel: t("travel"),
			spawnz,
			moves,
			instances: if raw.instances.is_nullish() { V::Null } else { raw.instances },
			areas: if raw.areas.is_nullish() { V::Null } else { raw.areas },
			professions: FxHashMap::default(),
			profession_by_name: FxHashMap::default(),
			recipe_by_spell: FxHashMap::default(),
			factions: FxHashMap::default(),
			faction_by_name: FxHashMap::default(),
			zone_by_name: FxHashMap::default(),
			has_xp: false,
			class_trainers: RefCell::new(None),
			roles: RefCell::new(FxHashMap::default()),
			memo: RefCell::new(FxHashMap::default()),
			missing,
		};
		d.index_professions(&t("professions"));
		d.index_factions(&t("factions"));
		let mut order: Vec<String> = Vec::new();
		for z in d.zones.values() {
			let name = z.get("name");
			if !name.truthy() {
				continue;
			}
			let key = name.to_js_string().to_lowercase();
			let e = d.zone_by_name.entry(key.clone()).or_default();
			if e.is_empty() {
				order.push(key);
			}
			e.push(z);
		}
		for list in d.zone_by_name.values_mut() {
			let num0 = |v: &V| if v.truthy() { v.num() } else { 0.0 };
			list.sort_by(|a, b| {
				zone_type_rank(&a.get("type"))
					.cmp(&zone_type_rank(&b.get("type")))
					.then((num0(&a.get("system")) - num0(&b.get("system"))).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal))
					.then((a.get("id").num() - b.get("id").num()).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal))
			});
		}
		d.has_xp = d.quests.values().iter().any(|q| q.get("xp").as_num().is_some_and(|x| x > 0.0));
		d
	}

	/// The data from file texts: `texts` maps a file name (`quests`, `map-frames`, ...) to its JSON text;
	/// absent files are missing. A core file that does not parse is an error; an optional one is missing.
	pub fn from_texts(texts: &FxHashMap<String, String>, instances: V, areas: V, dir: Option<String>) -> Result<Data, String> {
		let mut tables = FxHashMap::default();
		let mut missing = Vec::new();
		for name in FILES.iter().chain(OPTIONAL.iter()) {
			match texts.get(*name) {
				None => {
					missing.push(format!("{name}.json"));
					tables.insert(name.to_string(), V::obj());
				}
				Some(text) => match parse_json(text) {
					Ok(v) => {
						tables.insert(name.to_string(), v);
					}
					Err(e) => {
						if !OPTIONAL.contains(name) {
							return Err(format!("{name}.json: {e}"));
						}
						missing.push(format!("{name}.json"));
						tables.insert(name.to_string(), V::obj());
					}
				},
			}
		}
		Ok(Data::new(Raw { tables, instances, areas }, dir, missing))
	}

	/// `emptyData()`: no reference data at all (`--no-data`).
	pub fn empty() -> Data {
		let missing = FILES.iter().chain(OPTIONAL.iter()).map(|n| format!("{n}.json")).collect();
		Data::new(Raw { tables: FxHashMap::default(), instances: V::Null, areas: V::Null }, None, missing)
	}

	fn table_get(t: &V, id: &V) -> V {
		let v = t.get(&id.to_js_string());
		if v.truthy() {
			v
		} else {
			V::Null
		}
	}
	pub fn quest(&self, id: &V) -> V {
		Self::table_get(&self.quests, id)
	}
	pub fn npc(&self, id: &V) -> V {
		Self::table_get(&self.npcs, id)
	}
	pub fn object(&self, id: &V) -> V {
		Self::table_get(&self.objects, id)
	}
	pub fn item(&self, id: &V) -> V {
		Self::table_get(&self.items, id)
	}
	pub fn zone(&self, id: &V) -> V {
		Self::table_get(&self.zones, id)
	}

	/// Classes a race file can be on one side; [] when unknown.
	pub fn race_classes(&self, race_file: &str, side: &str) -> V {
		let c = self.races.get(race_file).get(side).get("classes");
		if c.truthy() {
			c
		} else {
			V::arr()
		}
	}

	/// A quest's objectives in data order: [{ index, kind, id, name, count }].
	pub fn quest_objectives(&self, quest_id: &V) -> Vec<V> {
		let q = self.quest(quest_id);
		let objs = q.get("objectives");
		if !q.truthy() || !objs.is_arr() {
			return Vec::new();
		}
		objs.items()
			.into_iter()
			.enumerate()
			.map(|(i, o)| {
				let kind: V = if o.truthy() && o.get("type").truthy() { o.get("type").to_js_string().into() } else { "event".into() };
				let id = if o.truthy() && !o.get("id").is_nullish() { o.get("id") } else { V::Null };
				let e = if id.is_nullish() {
					V::Null
				} else {
					match kind.as_str().unwrap() {
						"kill" => self.npc(&id),
						"item" => self.item(&id),
						"object" => self.object(&id),
						_ => V::Null,
					}
				};
				let name: V = if e.truthy() && e.get("name").truthy() && !e.get("name").to_js_string().is_empty() {
					e.get("name").to_js_string().into()
				} else if o.truthy() && o.get("text").truthy() {
					o.get("text").to_js_string().into()
				} else {
					V::Null
				};
				let count: V = if o.truthy() && o.get("count").num() > 0.0 { o.get("count").num().into() } else { V::Null };
				obj! { "index" => i + 1, "kind" => kind, "id" => id, "name" => name, "count" => count }.into()
			})
			.collect()
	}

	fn index_professions(&mut self, raw: &V) {
		for id in int_ids(raw) {
			let p = raw.get(&crate::js::num_str(id)).as_obj().unwrap().spread();
			p.set("id", id);
			let p = V::Obj(p);
			self.professions.insert(id as i64, p.clone());
			if p.get("name").truthy() {
				self.profession_by_name.insert(lower_key(&p.get("name").to_js_string()), p.clone());
			}
			for r in p.get("recipes").items() {
				let spell = if r.truthy() { r.get("spell").num() } else { f64::NAN };
				if is_integer(spell) && spell > 0.0 && !self.recipe_by_spell.contains_key(&(spell as i64)) {
					self.recipe_by_spell.insert(spell as i64, obj! { "recipe" => r.clone(), "profession" => p.clone() }.into());
				}
			}
		}
		for i in 0..BUILTIN_PROFESSIONS.len() {
			let k = lower_key(BUILTIN_PROFESSIONS[i].1);
			self.profession_by_name.entry(k).or_insert_with(|| builtin(i));
		}
	}

	/// Profession by name (professions.json, else the Classic built-ins) or Null.
	pub fn profession_named(&self, name: &str) -> V {
		self.profession_by_name.get(&lower_key(name)).cloned().unwrap_or(V::Null)
	}

	pub fn profession(&self, skill_line: &V) -> V {
		let n = skill_line.num();
		if let Some(p) = self.professions.get(&(n as i64)).filter(|_| is_integer(n)) {
			return p.clone();
		}
		BUILTIN_PROFESSIONS.iter().position(|b| b.0 as f64 == n).map(builtin).unwrap_or(V::Null)
	}

	/// { recipe, profession } or Null.
	pub fn recipe(&self, spell: &V) -> V {
		let n = spell.num();
		if !is_integer(n) {
			return V::Null;
		}
		self.recipe_by_spell.get(&(n as i64)).cloned().unwrap_or(V::Null)
	}

	fn index_factions(&mut self, raw: &V) {
		for id in int_ids(raw) {
			let f = raw.get(&crate::js::num_str(id)).as_obj().unwrap().spread();
			f.set("id", id);
			let f = V::Obj(f);
			self.factions.insert(id as i64, f.clone());
			if !f.get("name").truthy() {
				continue;
			}
			self.faction_by_name.entry(lower_key(&f.get("name").to_js_string())).or_default().push(f);
		}
	}

	/// Class trainers as [{ id, classes }] sorted by id.
	pub fn class_trainers(&self) -> V {
		if let Some(v) = self.class_trainers.borrow().as_ref() {
			return v.clone();
		}
		let mut list: Vec<V> = if self.has_trainers {
			self.trainers_raw
				.values()
				.into_iter()
				.filter(|t| t.truthy() && t.get("id").num() > 0.0 && t.get("classes").is_arr() && !t.get("classes").is_empty())
				.map(|t| {
					let classes: Vec<V> = t.get("classes").items().iter().map(|c| V::from(c.to_js_string())).collect();
					obj! { "id" => t.get("id").num(), "classes" => classes }.into()
				})
				.collect()
		} else {
			crate::trainers::curated_trainer_list(self)
		};
		list.sort_by(|a, b| a.get("id").num().partial_cmp(&b.get("id").num()).unwrap());
		let v: V = list.into();
		*self.class_trainers.borrow_mut() = Some(v.clone());
		v
	}

	/// Npc ids with a role ("vendor", "innkeeper", ...), ascending.
	pub fn npcs_with_role(&self, role: &str) -> Vec<f64> {
		if let Some(v) = self.roles.borrow().get(role) {
			return v.clone();
		}
		let mut ids: Vec<f64> = self.npcs.values().into_iter().filter(|n| n.truthy() && n.get("roles").items().iter().any(|r| r.as_str() == Some(role))).map(|n| n.get("id").num()).collect();
		ids.sort_by(|a, b| a.partial_cmp(b).unwrap());
		self.roles.borrow_mut().insert(role.to_string(), ids.clone());
		ids
	}

	pub fn inns(&self) -> V {
		let i = self.travel.get("inns");
		if i.is_arr() {
			i
		} else {
			V::arr()
		}
	}

	pub fn flight_nodes(&self) -> V {
		let n = self.travel.get("taxi").get("nodes");
		if n.is_arr() {
			n
		} else {
			V::arr()
		}
	}

	pub fn faction(&self, id: &V) -> V {
		let n = id.num();
		if !is_integer(n) {
			return V::Null;
		}
		self.factions.get(&(n as i64)).cloned().unwrap_or(V::Null)
	}

	/// { faction, ambiguous: [factions] | null } or Null (lowest id wins).
	pub fn faction_named(&self, name: &str) -> V {
		match self.faction_by_name.get(&lower_key(name)) {
			Some(list) if !list.is_empty() => {
				let amb: V = if list.len() > 1 { list.clone().into() } else { V::Null };
				obj! { "faction" => list[0].clone(), "ambiguous" => amb }.into()
			}
			_ => V::Null,
		}
	}

	/// { zone, ambiguous: [zones] | null } or Null.
	pub fn zone_named(&self, name: &str) -> V {
		match self.zone_by_name.get(&name.to_lowercase()) {
			Some(list) if !list.is_empty() => {
				let best = &list[0];
				let sys = |z: &V| if z.get("system").truthy() { z.get("system").num() } else { 0.0 };
				let tied: Vec<V> = list.iter().filter(|z| zone_type_rank(&z.get("type")) == zone_type_rank(&best.get("type")) && sys(z) == sys(best)).cloned().collect();
				let amb: V = if tied.len() > 1 { tied.into() } else { V::Null };
				obj! { "zone" => best.clone(), "ambiguous" => amb }.into()
			}
			_ => V::Null,
		}
	}

	pub fn era_frame(&self, map: &V) -> V {
		let f = self.map_frames.get("era").get(&map.to_js_string());
		if f.truthy() {
			f
		} else {
			V::Null
		}
	}

	/// The Era frame, else the Forever one.
	pub fn frame(&self, map: &V) -> V {
		let e = self.era_frame(map);
		if e.truthy() {
			return e;
		}
		let f = self.map_frames.get("forever").get(&map.to_js_string());
		if f.truthy() {
			f
		} else {
			V::Null
		}
	}

	/// { w, h } in yards, or Null.
	pub fn map_size(&self, map: &V) -> V {
		let fr = self.frame(map);
		if !fr.truthy() {
			return V::Null;
		}
		let w = (fr.get("right").num() - fr.get("left").num()).abs();
		let h = (fr.get("bottom").num() - fr.get("top").num()).abs();
		if w > 0.0 && h > 0.0 {
			obj! { "w" => w, "h" => h }.into()
		} else {
			V::Null
		}
	}

	/// Entity spawns as [{ map, f, pts, more }] sorted by map id.
	pub fn spawns(&self, kind: &str, id: &V) -> Vec<V> {
		let e = match kind {
			"npc" => self.npc(id),
			"object" => self.object(id),
			_ => V::Null,
		};
		if !e.truthy() || !e.get("spawns").truthy() {
			return Vec::new();
		}
		let sp = e.get("spawns");
		let ok = |p: &V| p.is_arr() && p.len() >= 2;
		let mut out: Vec<V> = sp
			.keys()
			.iter()
			.map(|m| {
				let s = sp.get(m);
				let pts: Vec<V> = s.get("pts").items().into_iter().filter(ok).collect();
				let more: Vec<V> = s.get("more").items().into_iter().filter(ok).collect();
				obj! { "map" => crate::js::str_to_num(m), "f" => s.get("f"), "pts" => pts, "more" => more }.into()
			})
			.filter(|s: &V| !s.get("pts").is_empty())
			.collect();
		// stable sort by map like Array.prototype.sort
		out.sort_by(|a, b| a.get("map").num().partial_cmp(&b.get("map").num()).unwrap());
		out
	}
}

/// The guide verb for each objective kind (an event has none).
pub fn objective_verb(kind: &str) -> Option<&'static str> {
	match kind {
		"kill" => Some("kill"),
		"item" => Some("collect"),
		"object" => Some("interact"),
		_ => None,
	}
}

/// One objective of quest_objectives as "7.1 = kill Kobold Vermin x10".
pub fn objective_label(quest_id: &V, o: &V) -> String {
	let what = if o.get("name").truthy() {
		o.get("name").to_js_string()
	} else if !o.get("id").is_nullish() {
		format!("{} {}", o.get("kind"), o.get("id"))
	} else {
		"unnamed".into()
	};
	let kind = o.get("kind").to_js_string();
	let verb = objective_verb(&kind).map(str::to_string).unwrap_or(kind);
	let count = if o.get("count").truthy() { format!(" x{}", o.get("count")) } else { String::new() };
	format!("{}.{} = {} {}{}", quest_id, o.get("index"), verb, what, count)
}

/// `loadData(dir)` (native): reads dir/<name>.json and the instance/area tables from dir/../sources.
#[cfg(feature = "native")]
pub fn load_data(dir: &std::path::Path) -> Result<Data, String> {
	let mut texts = FxHashMap::default();
	for name in FILES.iter().chain(OPTIONAL.iter()) {
		let file = dir.join(format!("{name}.json"));
		if let Ok(t) = std::fs::read_to_string(&file) {
			texts.insert(name.to_string(), t);
		}
	}
	let sources = dir.join("..").join("sources");
	let instances = crate::solo::load_instances(&sources);
	let areas = crate::areas::load_areas(&sources);
	Data::from_texts(&texts, instances, areas, Some(dir.to_string_lossy().into_owned()))
}

/// Whether dir holds any core file.
#[cfg(feature = "native")]
pub fn has_core_data(dir: &std::path::Path) -> bool {
	FILES.iter().any(|n| dir.join(format!("{n}.json")).exists())
}
