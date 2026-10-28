//! The writer's inputs, typed: the route (forge-sim's search output), the simulator world
//! the route's points index, and the game data it reads (quests, npcs, objects, items, zones).
//! Every field is optional as the JS writer reads it (`(x || {}).y || []`), so small worlds and
//! data sets (the tests') parse too.

use serde::{Deserialize, Deserializer};
use serde_json::Value;
use std::collections::BTreeMap;

fn lenient_num<'de, D: Deserializer<'de>>(d: D) -> Result<Option<f64>, D::Error> {
	Ok(Value::deserialize(d)?.as_f64())
}

fn lenient_u32<'de, D: Deserializer<'de>>(d: D) -> Result<Option<u32>, D::Error> {
	Ok(Value::deserialize(d)?.as_u64().map(|x| x as u32))
}

fn lenient_usize<'de, D: Deserializer<'de>>(d: D) -> Result<Option<usize>, D::Error> {
	Ok(Value::deserialize(d)?.as_u64().map(|x| x as usize))
}

fn lenient_str<'de, D: Deserializer<'de>>(d: D) -> Result<Option<String>, D::Error> {
	Ok(match Value::deserialize(d)? {
		Value::String(s) => Some(s),
		_ => None,
	})
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum OrderT {
	Accept,
	Turnin,
	Task,
	Train,
	Level,
	/// Riding training at a riding trainer (`npc`), placed by the planner at 40 or later.
	Ride,
	Other,
}

impl<'de> Deserialize<'de> for OrderT {
	fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
		Ok(match Value::deserialize(d)?.as_str() {
			Some("accept") => OrderT::Accept,
			Some("turnin") => OrderT::Turnin,
			Some("task") => OrderT::Task,
			Some("train") => OrderT::Train,
			Some("level") => OrderT::Level,
			Some("ride") => OrderT::Ride,
			_ => OrderT::Other,
		})
	}
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ItemT {
	Bind,
	Hearth,
	Network,
	Getfp,
	/// A deathskip (`die` at a graveyard's Spirit Healer).
	Deathskip,
	Other,
}

impl<'de> Deserialize<'de> for ItemT {
	fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
		Ok(match Value::deserialize(d)?.as_str() {
			Some("bind") => ItemT::Bind,
			Some("hearth") => ItemT::Hearth,
			Some("network") => ItemT::Network,
			Some("getfp") => ItemT::Getfp,
			Some("deathskip") => ItemT::Deathskip,
			_ => ItemT::Other,
		})
	}
}

/// A route item: a bind, hearth, flight leg (`network`), flight path learned (`getfp`) or deathskip.
#[derive(Clone, Debug, Deserialize, PartialEq)]
pub struct Item {
	pub t: ItemT,
	#[serde(default, deserialize_with = "lenient_usize")]
	pub inn: Option<usize>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub pt: Option<u32>,
	#[serde(default, rename = "innPt", deserialize_with = "lenient_u32")]
	pub inn_pt: Option<u32>,
	#[serde(default)]
	pub used: Option<bool>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub returns: Option<f64>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub from: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub to: Option<u32>,
	#[serde(default, deserialize_with = "lenient_usize")]
	pub node: Option<usize>,
	/// The sim's own path for a travel item (walks, flights between nodes, rides), when it gives it.
	#[serde(default)]
	pub legs: Option<Vec<Leg>>,
	/// A deathskip's graveyard (world.graveyards index), the spot died at (world point) and one of
	/// its mobs (npc id).
	#[serde(default, deserialize_with = "lenient_usize")]
	pub gy: Option<usize>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub spot: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub npc: Option<u32>,
}

/// One part of a travel item's path: `walk` to a point, `fly` between taxi nodes, `ride` a boat or
/// zeppelin (world.rides index).
#[derive(Clone, Debug, Deserialize, PartialEq)]
pub struct Leg {
	#[serde(default, deserialize_with = "lenient_str")]
	pub k: Option<String>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub from: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub to: Option<u32>,
	#[serde(default, deserialize_with = "lenient_usize")]
	pub ride: Option<usize>,
	/// For a walk: the taxi or dock node walked to.
	#[serde(default, deserialize_with = "lenient_usize")]
	pub node: Option<usize>,
}

/// One event of the route's order.
#[derive(Clone, Debug, Deserialize)]
pub struct Order {
	pub t: OrderT,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub q: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub task: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub pt: Option<u32>,
	#[serde(default, deserialize_with = "lenient_str")]
	pub from: Option<String>,
	#[serde(default)]
	pub items: Option<Vec<Item>>,
	/// The character's level before the event (routes before the `target` field: for a `level` item,
	/// the grind target).
	#[serde(default, deserialize_with = "lenient_num")]
	pub lvl: Option<f64>,
	/// A `level` item's fractional grind target (15.91).
	#[serde(default, deserialize_with = "lenient_num")]
	pub target: Option<f64>,
	/// A `ride` item's riding trainer.
	#[serde(default, deserialize_with = "lenient_u32")]
	pub npc: Option<u32>,
	/// The v1 line an event written as an added quest's came from.
	#[serde(skip)]
	pub v1from: Option<String>,
	/// `from` as a chain line (file index, line), when it is one.
	#[serde(skip)]
	pub key: Option<crate::guide::Key>,
}

impl Order {
	pub fn items(&self) -> &[Item] {
		self.items.as_deref().unwrap_or(&[])
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Hours {
	#[serde(default, deserialize_with = "lenient_num")]
	pub hours60: Option<f64>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Diff {
	#[serde(default)]
	pub added: Vec<u32>,
	#[serde(default)]
	pub dropped: Vec<u32>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Route {
	/// The data the route's world was built from (its point ids are that world's).
	#[serde(default, rename = "dataHash", deserialize_with = "lenient_str")]
	pub data_hash: Option<String>,
	#[serde(default, deserialize_with = "lenient_str")]
	pub faction: Option<String>,
	#[serde(default, deserialize_with = "lenient_str")]
	pub start: Option<String>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub tries: Option<f64>,
	#[serde(default)]
	pub v1: Option<Hours>,
	#[serde(default)]
	pub improved: Option<Hours>,
	#[serde(default)]
	pub diff: Option<Diff>,
	#[serde(default)]
	pub order: Vec<Order>,
	/// The faction's shared route (forge-sim's shared_faction): `joinAt`, the guide stem (in any
	/// folder) from whose first step on every start of the faction plays the same order (older
	/// routes: `joinAfter`, the guide after which).
	#[serde(default)]
	pub shared: Option<Value>,
}

/// A world point: `[c, region, wx, wy, map, z?]`.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Pt {
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: u32,
}

impl<'de> Deserialize<'de> for Pt {
	fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
		let v: Vec<Value> = Vec::deserialize(d)?;
		let f = |i: usize| v.get(i).and_then(Value::as_f64).unwrap_or(f64::NAN);
		Ok(Pt { c: f(0) as i64, wx: f(2), wy: f(3), map: f(4) as u32 })
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct WObj {
	#[serde(default, deserialize_with = "lenient_num")]
	pub oi: Option<f64>,
	#[serde(default, rename = "type", deserialize_with = "lenient_str")]
	pub kind: Option<String>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub id: Option<f64>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub task: Option<u32>,
}

impl WObj {
	pub fn oi(&self) -> usize {
		self.oi.unwrap_or(0.0) as usize
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct WQuest {
	pub id: u32,
	/// How long the item a delivery starts from lasts, seconds (Scalding Mornbrew Delivery: 300).
	#[serde(default, rename = "sourceDur", deserialize_with = "lenient_num")]
	pub source_dur: Option<f64>,
	#[serde(default)]
	pub objs: Vec<WObj>,
	/// The points of its quest giver and ender.
	#[serde(default, deserialize_with = "lenient_u32")]
	pub giver: Option<u32>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub ender: Option<u32>,
	/// The quests that close it once taken (its exclusive partners, and for a breadcrumb the quest it
	/// leads to).
	#[serde(default)]
	pub excl: Vec<i64>,
	/// Its tasks (the route's `task` index is a position here): the hand-in is ready once each is done.
	#[serde(default)]
	pub tasks: Option<Vec<WTask>>,
	/// The quests before it, as the world has them (a negative id: any one of them).
	#[serde(default)]
	pub pre: Option<Vec<i64>>,
}

/// One task of a world quest: its work, `[kind, ...]` each (`["buy"]`, `["kill", n, ...]`).
#[derive(Clone, Debug, Default, Deserialize)]
pub struct WTask {
	#[serde(default)]
	pub work: Vec<Vec<Value>>,
}

impl WTask {
	pub fn is(&self, kind: &str) -> bool {
		self.work.iter().any(|w| w.first().and_then(Value::as_str) == Some(kind))
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Inn {
	#[serde(default, deserialize_with = "lenient_str")]
	pub name: Option<String>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub pt: Option<u32>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Node {
	#[serde(default)]
	pub kind: String,
	#[serde(default)]
	pub name: String,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub pt: Option<u32>,
}

/// A ride between two docks: `[nodeA, nodeB, seconds, wait, id]`.
#[derive(Clone, Copy, Debug)]
pub struct Ride {
	pub a: Option<usize>,
	pub b: Option<usize>,
	/// Its kind, from the id's head: `boat`, `zeppelin`, `tram`, `portal`, `lift`.
	pub kind: Option<&'static str>,
}

impl<'de> Deserialize<'de> for Ride {
	fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
		let v: Vec<Value> = Vec::deserialize(d)?;
		let f = |i: usize| v.get(i).and_then(Value::as_u64).map(|x| x as usize);
		let id = v.get(4).and_then(Value::as_str).unwrap_or("");
		// (Zephras Isle's way off, the airship or the zeppelin and Skyborne portal: `exit`.)
		let kind = ["boat", "zeppelin", "tram", "portal", "lift"].into_iter().find(|k| id.starts_with(k)).or_else(|| id.starts_with("Zephras Isle").then_some("exit"));
		Ok(Ride { a: f(0), b: f(1), kind })
	}
}

/// The simulator world (world-horde.json, world-alliance.json): the parts the writer reads.
#[derive(Clone, Debug, Default, Deserialize)]
pub struct World {
	#[serde(default)]
	pub points: Vec<Pt>,
	#[serde(default)]
	pub quests: Vec<WQuest>,
	#[serde(default)]
	pub zones: BTreeMap<u32, String>,
	#[serde(default)]
	pub inns: Vec<Inn>,
	#[serde(default)]
	pub nodes: Vec<Node>,
	#[serde(default)]
	pub rides: Vec<Ride>,
	/// The faction's graveyards (forge-world World::graveyards): name and Spirit Healer's point.
	#[serde(default)]
	pub graveyards: Vec<Graveyard>,
	/// The data the world was built from (the walk store must be built on the same).
	#[serde(default, rename = "dataHash", deserialize_with = "lenient_str")]
	pub data_hash: Option<String>,
}

/// A graveyard of the world (the parts the writer reads).
#[derive(Clone, Debug, Default, Deserialize)]
pub struct Graveyard {
	#[serde(default, deserialize_with = "lenient_str")]
	pub name: Option<String>,
	#[serde(default, deserialize_with = "lenient_u32")]
	pub pt: Option<u32>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Ends {
	#[serde(default)]
	pub npc: Vec<u32>,
	#[serde(default)]
	pub object: Vec<u32>,
	#[serde(default)]
	pub item: Vec<u32>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct DObj {
	#[serde(default, rename = "type", deserialize_with = "lenient_str")]
	pub kind: Option<String>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub id: Option<f64>,
}

impl DObj {
	pub fn is(&self, k: &str) -> bool {
		self.kind.as_deref() == Some(k)
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Quest {
	#[serde(default, deserialize_with = "lenient_str")]
	pub title: Option<String>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub level: Option<f64>,
	#[serde(default)]
	pub start: Option<Ends>,
	#[serde(default)]
	pub end: Option<Ends>,
	#[serde(default)]
	pub objectives: Option<Vec<Option<DObj>>>,
	#[serde(default)]
	pub repeatable: Option<Value>,
	#[serde(default, rename = "minLevel", deserialize_with = "lenient_num")]
	pub min_level: Option<f64>,
	/// The races that may take it (race bits; Skyborne past 32 bits), None or 0: any.
	#[serde(default, deserialize_with = "lenient_num")]
	pub races: Option<f64>,
	/// The classes that may take it (class bits), None or 0: any.
	#[serde(default, deserialize_with = "lenient_num")]
	pub classes: Option<f64>,
	/// The quests before it (ids; a negative one: any of them).
	#[serde(default)]
	pub pre: Option<Vec<Value>>,
	/// The quests one of which comes before it (ids).
	#[serde(default, rename = "preAny")]
	pub pre_any: Option<Vec<Value>>,
}

impl Quest {
	/// The quest's title when it has one (JS truthy).
	pub fn title(&self) -> Option<&str> {
		self.title.as_deref().filter(|t| !t.is_empty())
	}
	pub fn start_items(&self) -> &[u32] {
		self.start.as_ref().map_or(&[], |s| &s.item)
	}
	pub fn objectives(&self) -> impl Iterator<Item = &DObj> {
		static NONE: DObj = DObj { kind: None, id: None };
		self.objectives.iter().flatten().map(|o| o.as_ref().unwrap_or(&NONE))
	}
	pub fn objective(&self, i: usize) -> Option<&DObj> {
		self.objectives.as_ref()?.get(i)?.as_ref()
	}
	pub fn repeatable(&self) -> bool {
		match &self.repeatable {
			Some(Value::Bool(b)) => *b,
			Some(Value::Null) | None => false,
			Some(Value::Number(n)) => n.as_f64().is_some_and(|x| x != 0.0),
			Some(Value::String(s)) => !s.is_empty(),
			Some(_) => true,
		}
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Spawn {
	#[serde(default, deserialize_with = "lenient_str")]
	pub f: Option<String>,
	#[serde(default)]
	pub pts: Vec<Vec<Option<f64>>>,
}

/// An npc or object: its name and spawns by map.
#[derive(Clone, Debug, Default, Deserialize)]
pub struct Entity {
	#[serde(default, deserialize_with = "lenient_str")]
	pub name: Option<String>,
	/// "Mage Trainer" and the like.
	#[serde(default, rename = "subName", deserialize_with = "lenient_str")]
	pub sub_name: Option<String>,
	/// "A", "H", or both.
	#[serde(default, deserialize_with = "lenient_str")]
	pub faction: Option<String>,
	#[serde(default)]
	pub spawns: BTreeMap<u32, Spawn>,
	/// An npc's level (its lowest).
	#[serde(default, deserialize_with = "lenient_num")]
	pub level: Option<f64>,
	/// An npc's rank: 1 elite, 2 rare elite, 3 boss, 4 rare.
	#[serde(default, deserialize_with = "lenient_num")]
	pub rank: Option<f64>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Drops {
	#[serde(default)]
	/// Droppers -> their drop chance in percent (null: unknown).
	pub npc: BTreeMap<u32, Value>,
	#[serde(default)]
	pub object: BTreeMap<u32, serde::de::IgnoredAny>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct GameItem {
	#[serde(default, deserialize_with = "lenient_str")]
	pub name: Option<String>,
	#[serde(default)]
	pub drops: Option<Drops>,
	#[serde(default)]
	/// The NPCs that sell it (ids).
	pub vendors: Option<Vec<serde_json::Value>>,
	#[serde(default, deserialize_with = "lenient_num")]
	pub duration: Option<f64>,
}

impl GameItem {
	pub fn npc_droppers(&self) -> usize {
		self.drops.as_ref().map_or(0, |d| d.npc.len())
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Zone {
	#[serde(default, rename = "areaId", deserialize_with = "lenient_num")]
	pub area_id: Option<f64>,
}

/// data/forever's quests, npcs, objects, items and zones.
#[derive(Clone, Debug, Default)]
pub struct Data {
	pub quests: BTreeMap<u32, Quest>,
	pub npcs: BTreeMap<u32, Entity>,
	pub objects: BTreeMap<u32, Entity>,
	pub items: BTreeMap<u32, GameItem>,
	pub zones: BTreeMap<u32, Zone>,
}
