//! The world model per faction (schema 1 of tools/lib/sim/world.js; contents documented there):
//! typed for the Rust sim and judge, and written as the JS world JSON, key for key.

use crate::areas::Area;
use crate::camps::Camp;
use crate::json::{jnum, jopt};
use serde_json::{json, Map, Value};

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Point {
	pub c: i64,
	pub region: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: u32,
	pub z: Option<f64>,
}

#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct Heights {
	pub source: u32,
	pub floor: u32,
	pub hinted: u32,
	pub ambiguous: u32,
	pub none: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Node {
	/// 'fp' | 'dock' | 'lift' | 'portal'
	pub kind: &'static str,
	pub taxi: Option<f64>,
	pub name: String,
	pub pt: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Ride {
	pub a: u32,
	pub b: u32,
	pub seconds: f64,
	pub wait: f64,
	pub id: Value,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Inn {
	pub name: Value,
	pub pt: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Hub {
	pub pt: u32,
	pub zone: u32,
	pub size: u32,
	pub fp: i64,
	pub inn: i64,
	pub trainers: Vec<String>,
}

/// Work items: `['kill', mobLevel, count, elite, spacing, npcId]`, `['use', n]`, `['escort']`,
/// `['buy']`, `['visit']`, `['dungeon', index]`.
#[derive(Clone, Debug, PartialEq)]
pub enum Work {
	Kill { level: f64, count: f64, elite: bool, spacing: f64, npc: u32 },
	Use(f64),
	Escort,
	Buy,
	Visit,
	Dungeon(u32),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Task {
	pub pt: u32,
	pub work: Vec<Work>,
	/// Other places the same work is done (a task of one objective): an item's other friendly vendors
	/// for a buy, an object's other spawn sites for a use. World points; the planner picks among them
	/// by the order (forge-sim route::co_sited_tasks, eval's buys).
	pub alts: Vec<u32>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Obj {
	pub oi: i64,
	/// kill | item | object | event | talk
	pub kind: &'static str,
	pub id: Option<f64>,
	pub count: f64,
	pub item: Option<f64>,
	pub quest_item: bool,
	pub camps: Vec<u32>,
	/// 'npc:<id>' -> % | null, in insertion order.
	pub chances: Vec<(String, Option<f64>)>,
	pub task: Option<u32>,
	pub dur: Option<f64>,
}

/// Map position, percent of the zone map.
#[derive(Clone, Debug, PartialEq)]
pub struct Pos {
	pub map: u32,
	pub x: f64,
	pub y: f64,
	pub in_dungeon: bool,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Mech {
	pub kinds: Vec<String>,
	pub params: Vec<Value>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct ObjCamp {
	pub oi: i64,
	pub camps: Vec<u32>,
	pub chances: Vec<(String, Option<f64>)>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct WQuest {
	pub id: u32,
	pub title: String,
	pub level: f64,
	pub min_level: f64,
	pub races: Option<f64>,
	pub classes: Option<f64>,
	pub pre: Vec<i64>,
	pub excl: Vec<i64>,
	pub next: Option<f64>,
	pub xp: Option<f64>,
	/// None on dungeon-journal records (they carry no `noXp`).
	pub no_xp: Option<bool>,
	pub giver: u32,
	pub ender: u32,
	pub accept: Option<Task>,
	pub tasks: Vec<Task>,
	pub zone: u32,
	pub breadcrumb: bool,
	/// 'delivery' | 'startItem' | 'talk' | 'work'
	pub kind: &'static str,
	pub objs: Vec<Obj>,
	pub escort: bool,
	pub elite: bool,
	pub g_name: Option<String>,
	pub e_name: Option<String>,
	pub g_pos: Option<Pos>,
	pub e_pos: Option<Pos>,
	pub g_alt: Option<Vec<(String, u32)>>,
	pub limit: Option<f64>,
	pub mech: Option<Mech>,
	pub e_alt: Option<Vec<(String, u32)>>,
	pub start_from: Option<u32>,
	pub source_dur: Option<f64>,
	pub obj_camps: Option<Vec<ObjCamp>>,
	pub in_log: Option<i64>,
	pub pre_all: Vec<i64>,
	pub pre_rule: Option<&'static str>,
	pub after: Option<Vec<u32>>,
	pub tier: u32,
	pub hub_giver: i64,
	pub hub_ender: i64,
	/// A dungeons.json record: Some(dungeon index) when its work is inside the dungeon.
	pub dungeon: Option<u32>,
	/// Built from dungeons.json (layout of the JSON record differs).
	pub from_journal: bool,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Excluded {
	pub id: u32,
	pub title: Option<String>,
	pub reason: String,
	pub category: Option<String>,
	pub code: &'static str,
}

#[derive(Clone, Debug, PartialEq)]
pub struct SvcPt {
	pub pt: u32,
	pub npc: Option<u32>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct RidingStop {
	pub pt: u32,
	pub npc: u32,
	pub races: f64,
	pub vendor: Option<(u32, u32, Value, Value)>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct Services {
	pub trainer: Vec<(String, Vec<SvcPt>)>,
	pub repair: Vec<SvcPt>,
	pub food: Vec<SvcPt>,
	pub ammo: Vec<SvcPt>,
	pub inn: Vec<SvcPt>,
	pub flight: Vec<SvcPt>,
	pub riding: Vec<RidingStop>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Package {
	pub key: String,
	pub zone: u32,
	pub zone_name: String,
	pub band: f64,
	pub levels: (f64, f64),
	pub dungeon: Option<u32>,
	pub quests: Vec<u32>,
	pub steps: Vec<(u8, i64, i64, u32)>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Dungeon {
	pub key: Value,
	pub name: Value,
	pub min: Value,
	pub max: Value,
	pub pt: u32,
	pub zone: u32,
	pub bosses: Vec<f64>,
	pub boss_count: u32,
	pub quests: Vec<u32>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Danger {
	pub region: i64,
	pub gx0: i64,
	pub gy0: i64,
	pub nx: i64,
	pub ny: i64,
	pub cell: f64,
	pub z: Vec<u32>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Start {
	pub zone: String,
	pub pt: u32,
	pub quest: u32,
}

/// A graveyard the world's faction is resurrected at (World::graveyards): the game's graveyard
/// (WorldSafeLocs) id and name, the Spirit Healer's world point beside it (where the resurrection
/// puts the character, the `die` goal's place), where a released ghost appears (continent, x,
/// y, height: the death's distance is measured to it) and the zone maps (UiMap ids) whose deaths
/// may send the faction there.
#[derive(Clone, Debug, PartialEq)]
pub struct Graveyard {
	pub id: u32,
	pub name: String,
	pub pt: u32,
	pub loc: (i64, f64, f64, f64),
	pub maps: Vec<u32>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct PreRules {
	pub canonical: u32,
	pub journal: u32,
	pub next: u32,
	pub children: u32,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct Solo {
	pub counts: Vec<(&'static str, u32)>,
	pub repeat_no_xp: u32,
	pub instance_areas: Option<String>,
	pub overrides: (usize, usize, usize),
}

/// One faction's world (world.js buildWorld + getWorld's dataHash/inputs/questXp).
#[derive(Clone, Debug, PartialEq)]
pub struct World {
	pub faction: forge_core::Faction,
	pub band_width: f64,
	pub max_open: u32,
	pub points: Vec<Point>,
	pub heights: Heights,
	pub nodes: Vec<Node>,
	pub taxi: Vec<(u32, u32, Value)>,
	pub rides: Vec<Ride>,
	pub inns: Vec<Inn>,
	pub hubs: Vec<Hub>,
	pub quests: Vec<WQuest>,
	pub excluded: Vec<Excluded>,
	pub camps: Vec<Camp>,
	pub services: Services,
	/// point -> service kinds, ascending point.
	pub service_set: std::collections::BTreeMap<u32, Vec<String>>,
	pub areas: Vec<Area>,
	pub point_area: Vec<i32>,
	pub training: Value,
	pub training_spells: Value,
	pub riding: Value,
	pub classes: Vec<(String, Value)>,
	pub excluded_ids: Vec<u32>,
	pub solo: Solo,
	pub packages: Vec<Package>,
	pub dungeons: Vec<Dungeon>,
	pub grind_spacing: Vec<f64>,
	pub zone_min: std::collections::BTreeMap<u32, f64>,
	pub danger: Vec<Danger>,
	/// The faction's graveyards, by id (empty without the graveyard source).
	pub graveyards: Vec<Graveyard>,
	pub starts: Vec<(String, Start)>,
	pub zones: std::collections::BTreeMap<u32, String>,
	pub warnings: Vec<String>,
	pub pre_rules: PreRules,
	pub data_hash: Option<String>,
	pub inputs: Vec<(String, String)>,
	pub quest_xp: Value,
}

fn chances_value(c: &[(String, Option<f64>)]) -> Value {
	let mut m = Map::new();
	for (k, v) in c {
		m.insert(k.clone(), jopt(*v));
	}
	Value::Object(m)
}

fn alt_value(a: &[(String, u32)]) -> Value {
	let mut m = Map::new();
	for (k, v) in a {
		m.insert(k.clone(), json!(v));
	}
	Value::Object(m)
}

fn ids(v: &[i64]) -> Value {
	Value::Array(v.iter().map(|x| json!(x)).collect())
}

impl Work {
	pub fn to_value(&self) -> Value {
		match self {
			Work::Kill { level, count, elite, spacing, npc } => json!(["kill", jnum(*level), jnum(*count), u8::from(*elite), jnum(*spacing), npc]),
			Work::Use(n) => json!(["use", jnum(*n)]),
			Work::Escort => json!(["escort"]),
			Work::Buy => json!(["buy"]),
			Work::Visit => json!(["visit"]),
			Work::Dungeon(d) => json!(["dungeon", d]),
		}
	}
}

impl Task {
	pub fn to_value(&self) -> Value {
		let mut v = json!({ "pt": self.pt, "work": self.work.iter().map(Work::to_value).collect::<Vec<_>>() });
		if !self.alts.is_empty() {
			v["alts"] = json!(self.alts);
		}
		v
	}
}

impl Pos {
	pub fn to_value(&self) -> Value {
		let mut m = Map::new();
		m.insert("map".into(), json!(self.map));
		m.insert("x".into(), jnum(self.x));
		m.insert("y".into(), jnum(self.y));
		if self.in_dungeon {
			m.insert("inDungeon".into(), Value::Bool(true));
		}
		Value::Object(m)
	}
}

impl Obj {
	pub fn to_value(&self) -> Value {
		let mut m = Map::new();
		m.insert("oi".into(), json!(self.oi));
		m.insert("type".into(), json!(self.kind));
		m.insert("id".into(), jopt(self.id));
		m.insert("count".into(), jnum(self.count));
		m.insert("item".into(), jopt(self.item));
		m.insert("questItem".into(), Value::Bool(self.quest_item));
		m.insert("camps".into(), json!(self.camps));
		m.insert("chances".into(), chances_value(&self.chances));
		m.insert("task".into(), self.task.map(|t| json!(t)).unwrap_or(Value::Null));
		if let Some(d) = self.dur {
			m.insert("dur".into(), jnum(d));
		}
		Value::Object(m)
	}
}

impl WQuest {
	/// The JSON record, keys in the order world.js creates them.
	pub fn to_value(&self) -> Value {
		let mut m = Map::new();
		let put = |m: &mut Map<String, Value>, k: &str, v: Value| {
			m.insert(k.into(), v);
		};
		let pos = |p: &Option<Pos>| p.as_ref().map(Pos::to_value).unwrap_or(Value::Null);
		let name = |n: &Option<String>| n.clone().map(Value::String).unwrap_or(Value::Null);
		put(&mut m, "id", json!(self.id));
		put(&mut m, "title", json!(self.title));
		put(&mut m, "level", jnum(self.level));
		put(&mut m, "minLevel", jnum(self.min_level));
		put(&mut m, "races", jopt(self.races));
		put(&mut m, "classes", jopt(self.classes));
		put(&mut m, "pre", ids(&self.pre));
		put(&mut m, "excl", ids(&self.excl));
		put(&mut m, "next", jopt(self.next));
		put(&mut m, "xp", jopt(self.xp));
		if let Some(n) = self.no_xp {
			put(&mut m, "noXp", Value::Bool(n));
		}
		put(&mut m, "giver", json!(self.giver));
		put(&mut m, "ender", json!(self.ender));
		put(&mut m, "accept", self.accept.as_ref().map(Task::to_value).unwrap_or(Value::Null));
		put(&mut m, "tasks", Value::Array(self.tasks.iter().map(Task::to_value).collect()));
		put(&mut m, "zone", json!(self.zone));
		put(&mut m, "breadcrumb", Value::Bool(self.breadcrumb));
		if self.from_journal {
			put(&mut m, "escort", Value::Bool(self.escort));
			put(&mut m, "elite", Value::Bool(self.elite));
			if let Some(d) = self.dungeon {
				put(&mut m, "dungeon", json!(d));
			}
			put(&mut m, "kind", json!(self.kind));
			put(&mut m, "objs", Value::Array(self.objs.iter().map(Obj::to_value).collect()));
		} else {
			put(&mut m, "kind", json!(self.kind));
			put(&mut m, "objs", Value::Array(self.objs.iter().map(Obj::to_value).collect()));
			put(&mut m, "escort", Value::Bool(self.escort));
			put(&mut m, "elite", Value::Bool(self.elite));
		}
		put(&mut m, "gName", name(&self.g_name));
		put(&mut m, "eName", name(&self.e_name));
		put(&mut m, "gPos", pos(&self.g_pos));
		put(&mut m, "ePos", pos(&self.e_pos));
		if let Some(a) = &self.g_alt {
			put(&mut m, "gAlt", alt_value(a));
		}
		if let Some(l) = self.limit {
			put(&mut m, "limit", jnum(l));
		}
		if let Some(me) = &self.mech {
			let mut mm = Map::new();
			mm.insert("kinds".into(), json!(me.kinds));
			if !me.params.is_empty() {
				mm.insert("params".into(), Value::Array(me.params.clone()));
			}
			put(&mut m, "mech", Value::Object(mm));
		}
		if let Some(a) = &self.e_alt {
			put(&mut m, "eAlt", alt_value(a));
		}
		if let Some(s) = self.start_from {
			put(&mut m, "startFrom", json!(s));
		}
		if let Some(d) = self.source_dur {
			put(&mut m, "sourceDur", jnum(d));
		}
		if let Some(oc) = &self.obj_camps {
			put(&mut m, "objCamps", Value::Array(oc.iter().map(|o| json!([o.oi, o.camps, chances_value(&o.chances)])).collect()));
		}
		if let Some(l) = self.in_log {
			put(&mut m, "inLog", json!(l));
		}
		put(&mut m, "preAll", ids(&self.pre_all));
		if let Some(r) = self.pre_rule {
			put(&mut m, "preRule", json!(r));
		}
		if let Some(a) = &self.after {
			put(&mut m, "after", json!(a));
		}
		put(&mut m, "tier", json!(self.tier));
		put(&mut m, "hubGiver", json!(self.hub_giver));
		put(&mut m, "hubEnder", json!(self.hub_ender));
		Value::Object(m)
	}
}

fn svc(list: &[SvcPt]) -> Value {
	Value::Array(list.iter().map(|s| json!({ "pt": s.pt, "npc": s.npc })).collect())
}

impl World {
	/// The world as world.js writes it (`JSON.stringify` of this is the world file).
	pub fn to_value(&self) -> Value {
		let mut w = Map::new();
		let put = |w: &mut Map<String, Value>, k: &str, v: Value| {
			w.insert(k.into(), v);
		};
		put(&mut w, "schema", json!(1));
		put(&mut w, "builderVersion", json!(crate::build::BUILDER_VERSION));
		put(&mut w, "faction", json!(self.faction.name()));
		put(&mut w, "bandWidth", jnum(self.band_width));
		put(&mut w, "maxOpen", json!(self.max_open));
		put(&mut w, "points", Value::Array(self.points.iter().map(|p| json!([p.c, p.region, jnum(p.wx), jnum(p.wy), p.map, jopt(p.z)])).collect()));
		let h = &self.heights;
		put(&mut w, "heights", json!({ "source": h.source, "floor": h.floor, "hinted": h.hinted, "ambiguous": h.ambiguous, "none": h.none }));
		put(
			&mut w,
			"nodes",
			Value::Array(
				self.nodes
					.iter()
					.map(|n| {
						let mut m = Map::new();
						m.insert("kind".into(), json!(n.kind));
						if let Some(t) = n.taxi {
							m.insert("taxi".into(), jnum(t));
						}
						m.insert("name".into(), json!(n.name));
						m.insert("pt".into(), json!(n.pt));
						Value::Object(m)
					})
					.collect(),
			),
		);
		put(&mut w, "taxi", Value::Array(self.taxi.iter().map(|t| json!([t.0, t.1, t.2])).collect()));
		put(&mut w, "rides", Value::Array(self.rides.iter().map(|r| json!([r.a, r.b, jnum(r.seconds), jnum(r.wait), r.id])).collect()));
		put(&mut w, "inns", Value::Array(self.inns.iter().map(|i| json!({ "name": i.name, "pt": i.pt })).collect()));
		put(&mut w, "hubs", Value::Array(self.hubs.iter().map(|h| json!({ "pt": h.pt, "zone": h.zone, "size": h.size, "fp": h.fp, "inn": h.inn, "trainers": h.trainers })).collect()));
		put(&mut w, "quests", Value::Array(self.quests.iter().map(WQuest::to_value).collect()));
		put(
			&mut w,
			"excluded",
			Value::Array(
				self.excluded
					.iter()
					.map(|e| {
						let mut m = Map::new();
						m.insert("id".into(), json!(e.id));
						m.insert("title".into(), e.title.clone().map(Value::String).unwrap_or(Value::Null));
						m.insert("reason".into(), json!(e.reason));
						if let Some(c) = &e.category {
							m.insert("category".into(), json!(c));
						}
						m.insert("code".into(), json!(e.code));
						Value::Object(m)
					})
					.collect(),
			),
		);
		put(
			&mut w,
			"camps",
			Value::Array(
				self.camps
					.iter()
					.map(|c| {
						let mut m = Map::new();
						m.insert("id".into(), json!(c.id));
						m.insert("pt".into(), json!(c.pt));
						m.insert("c".into(), json!(c.c));
						m.insert("region".into(), json!(c.region));
						m.insert("radius".into(), jnum(c.radius));
						m.insert("spawns".into(), json!(c.spawns));
						m.insert("levelMin".into(), jopt(c.level_min));
						m.insert("levelMax".into(), jopt(c.level_max));
						m.insert("respawn".into(), jopt(c.respawn));
						m.insert("sources".into(), Value::Array(c.sources.iter().map(|s| json!({ "kind": s.kind.as_str(), "id": s.id, "spawns": s.spawns })).collect()));
						if c.elite {
							m.insert("elite".into(), Value::Bool(true));
						}
						Value::Object(m)
					})
					.collect(),
			),
		);
		let s = &self.services;
		let mut trainer = Map::new();
		for (cls, list) in &s.trainer {
			trainer.insert(cls.clone(), svc(list));
		}
		let mut sm = Map::new();
		sm.insert("trainer".into(), Value::Object(trainer));
		sm.insert("repair".into(), svc(&s.repair));
		sm.insert("food".into(), svc(&s.food));
		sm.insert("ammo".into(), svc(&s.ammo));
		sm.insert("inn".into(), svc(&s.inn));
		sm.insert("flight".into(), svc(&s.flight));
		sm.insert(
			"riding".into(),
			Value::Array(
				s.riding
					.iter()
					.map(|r| {
						let mut m = Map::new();
						m.insert("pt".into(), json!(r.pt));
						m.insert("npc".into(), json!(r.npc));
						m.insert("races".into(), jnum(r.races));
						if let Some((v, vpt, item, copper)) = &r.vendor {
							m.insert("vendor".into(), json!(v));
							m.insert("vendorPt".into(), json!(vpt));
							m.insert("item".into(), item.clone());
							m.insert("itemCopper".into(), copper.clone());
						}
						Value::Object(m)
					})
					.collect(),
			),
		);
		put(&mut w, "services", Value::Object(sm));
		let mut ss = Map::new();
		for (pt, kinds) in &self.service_set {
			ss.insert(pt.to_string(), json!(kinds));
		}
		put(&mut w, "serviceSet", Value::Object(ss));
		put(
			&mut w,
			"areas",
			Value::Array(
				self.areas
					.iter()
					.map(|a| {
						let k = &a.kinds;
						json!({ "id": a.id, "pt": a.pt, "c": a.c, "region": a.region, "members": a.members, "hub": a.hub,
                            "kinds": { "giver": k.giver, "ender": k.ender, "camp": k.camp, "service": k.service, "node": k.node, "task": k.task } })
					})
					.collect(),
			),
		);
		put(&mut w, "pointArea", json!(self.point_area));
		put(&mut w, "training", self.training.clone());
		put(&mut w, "trainingSpells", self.training_spells.clone());
		put(&mut w, "riding", self.riding.clone());
		let mut cl = Map::new();
		for (k, v) in &self.classes {
			cl.insert(k.clone(), v.clone());
		}
		put(&mut w, "classes", Value::Object(cl));
		put(&mut w, "excludedIds", json!(self.excluded_ids));
		let mut counts = Map::new();
		for (k, n) in &self.solo.counts {
			counts.insert((*k).into(), json!(n));
		}
		put(
			&mut w,
			"solo",
			json!({ "counts": counts, "repeatNoXp": self.solo.repeat_no_xp, "instanceAreas": self.solo.instance_areas,
                "overrides": { "exclude": self.solo.overrides.0, "allow": self.solo.overrides.1, "turninAfter": self.solo.overrides.2 } }),
		);
		put(
			&mut w,
			"packages",
			Value::Array(
				self.packages
					.iter()
					.map(|p| {
						let mut m = Map::new();
						m.insert("key".into(), json!(p.key));
						m.insert("zone".into(), json!(p.zone));
						m.insert("zoneName".into(), json!(p.zone_name));
						m.insert("band".into(), jnum(p.band));
						m.insert("levels".into(), json!([jnum(p.levels.0), jnum(p.levels.1)]));
						if let Some(d) = p.dungeon {
							m.insert("dungeon".into(), json!(d));
						}
						m.insert("quests".into(), json!(p.quests));
						m.insert("steps".into(), Value::Array(p.steps.iter().map(|s| json!([s.0, s.1, s.2, s.3])).collect()));
						Value::Object(m)
					})
					.collect(),
			),
		);
		put(
			&mut w,
			"dungeons",
			Value::Array(
				self.dungeons
					.iter()
					.map(|d| {
						json!({ "key": d.key, "name": d.name, "min": d.min, "max": d.max, "pt": d.pt, "zone": d.zone,
                            "bosses": d.bosses.iter().map(|b| jnum(*b)).collect::<Vec<_>>(), "bossCount": d.boss_count, "quests": d.quests })
					})
					.collect(),
			),
		);
		put(&mut w, "grind", json!({ "spacing": self.grind_spacing.iter().map(|s| jnum(*s)).collect::<Vec<_>>() }));
		let mut zm = Map::new();
		for (k, v) in &self.zone_min {
			zm.insert(k.to_string(), jnum(*v));
		}
		put(&mut w, "zoneMin", Value::Object(zm));
		put(&mut w, "danger", Value::Array(self.danger.iter().map(|d| json!({ "region": d.region, "gx0": d.gx0, "gy0": d.gy0, "nx": d.nx, "ny": d.ny, "cell": jnum(d.cell), "z": d.z })).collect()));
		// (A world built without the graveyard source has no key.)
		if !self.graveyards.is_empty() {
			put(
				&mut w,
				"graveyards",
				Value::Array(
					self.graveyards.iter().map(|g| json!({ "id": g.id, "name": g.name, "pt": g.pt, "loc": [g.loc.0, jnum(g.loc.1), jnum(g.loc.2), jnum(g.loc.3)], "maps": g.maps })).collect(),
				),
			);
		}
		let mut st = Map::new();
		for (race, s) in &self.starts {
			st.insert(race.clone(), json!({ "zone": s.zone, "pt": s.pt, "quest": s.quest }));
		}
		put(&mut w, "starts", Value::Object(st));
		let mut zs = Map::new();
		for (k, v) in &self.zones {
			zs.insert(k.to_string(), json!(v));
		}
		put(&mut w, "zones", Value::Object(zs));
		put(&mut w, "warnings", json!(self.warnings));
		let p = &self.pre_rules;
		put(&mut w, "preRules", json!({ "canonical": p.canonical, "journal": p.journal, "next": p.next, "children": p.children }));
		if let Some(h) = &self.data_hash {
			put(&mut w, "dataHash", json!(h));
			let mut inp = Map::new();
			for (k, v) in &self.inputs {
				inp.insert(k.clone(), json!(v));
			}
			put(&mut w, "inputs", Value::Object(inp));
			put(&mut w, "questXp", self.quest_xp.clone());
		}
		Value::Object(w)
	}

	/// The world file's bytes (`JSON.stringify(world)`).
	pub fn to_json(&self) -> String {
		crate::json::stringify(&self.to_value())
	}

	/// What the walks of this world are built from (forge-nav's `WalkWorld::from_json` reads no
	/// more): the faction, every point (its id, continent, region, x, y, zone, height), the zones'
	/// danger (`zoneMin`, `danger`), the places walked to (inns, nodes, starts, services, camps,
	/// packages, the graveyards' Spirit Healers, and per quest its giver, ender, alternatives,
	/// accept, tasks' and objectives' camps). A fix that changes none of them (a quest's text, xp,
	/// prerequisites, a rule) keeps the key, so forge build's walks stage is skipped; a new place
	/// changes it. SHA-1 hex.
	pub fn walks_key(&self) -> String {
		let v = self.to_value();
		let mut h = forge_core::key::ContentHasher::new();
		h.update(b"walks-key 1\n");
		for k in ["faction", "points", "zoneMin", "danger", "inns", "nodes", "starts", "services", "camps", "packages"] {
			h.update(k.as_bytes()).update(b"=").update(v[k].to_string().as_bytes()).update(b"\n");
		}
		let quests: Vec<Value> = v["quests"]
			.as_array()
			.into_iter()
			.flatten()
			.map(|q| {
				let tasks: Vec<Value> = q["tasks"].as_array().into_iter().flatten().map(|t| if t["alts"].is_null() { t["pt"].clone() } else { json!([t["pt"], t["alts"]]) }).collect();
				let camps: Vec<&Value> = q["objs"].as_array().into_iter().flatten().map(|o| &o["camps"]).collect();
				json!([q["giver"], q["ender"], q["gAlt"], q["eAlt"], q["accept"], tasks, camps])
			})
			.collect();
		h.update(b"quests=").update(Value::Array(quests).to_string().as_bytes());
		// The Spirit Healers are walked from (forge-nav WalkWorld: anchors).
		if !self.graveyards.is_empty() {
			let pts: Vec<u32> = self.graveyards.iter().map(|g| g.pt).collect();
			h.update(b"\ngraveyards=").update(json!(pts).to_string().as_bytes());
		}
		h.hex()
	}

	/// The graveyard a character of this world's faction dying at `p` is sent to, by the game's
	/// rule: of the graveyards its zone links to the faction, on the death's continent, the
	/// nearest (straight, with heights where both are known; the lower id on a tie). None: its
	/// zone links none.
	pub fn graveyard_for(&self, p: &Point) -> Option<usize> {
		let mut best: Option<(f64, usize)> = None;
		for (i, g) in self.graveyards.iter().enumerate() {
			if g.loc.0 != p.c || !g.maps.contains(&p.map) {
				continue;
			}
			let dz = p.z.map_or(0.0, |z| z - g.loc.3);
			let d = (g.loc.1 - p.wx).powi(2) + (g.loc.2 - p.wy).powi(2) + dz * dz;
			if best.is_none_or(|b| d < b.0) {
				best = Some((d, i));
			}
		}
		best.map(|b| b.1)
	}
}
