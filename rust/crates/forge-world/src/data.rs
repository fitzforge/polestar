//! Typed loaders for data/forever (route/model.js loadData + sim world.js loadSimData) and the
//! few client/CMaNGOS side tables the world reads. Every id-keyed table is a `BTreeMap`, so
//! iteration is in ascending id order, which is how JS iterates objects with integer keys.
//! The world never reads meta.json.

use crate::csv::parse_csv;
use crate::solo::{instance_areas, InstanceAreas};
use forge_core::{Bounds, MapFrames};
use rustc_hash::FxHashMap;
use serde::Deserialize;
use serde_json::Value;
use std::collections::BTreeMap;

pub type Error = Box<dyn std::error::Error + Send + Sync>;

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Ends {
	pub npc: Vec<i64>,
	pub object: Vec<i64>,
	pub item: Vec<i64>,
}

impl Ends {
	pub fn of(&self, kind: Kind) -> &[i64] {
		match kind {
			Kind::Npc => &self.npc,
			Kind::Object => &self.object,
		}
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Objective {
	#[serde(rename = "type")]
	pub kind: String,
	pub id: Option<f64>,
	pub count: Option<f64>,
	pub text: Option<String>,
	pub map: Option<f64>,
	pub f: Option<String>,
	pub x: Option<f64>,
	pub y: Option<f64>,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Reputation {
	pub value: Option<f64>,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct WebQuest {
	pub items: Vec<Vec<Value>>,
	pub choices: Vec<Vec<Value>>,
}

/// A quests.json record (fields the world, the rules and the atlas read).
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default, rename_all = "camelCase")]
pub struct Quest {
	pub id: u32,
	pub title: Option<String>,
	pub level: Option<f64>,
	pub min_level: Option<f64>,
	pub max_level: Option<f64>,
	pub races: Option<f64>,
	pub classes: Option<f64>,
	pub start: Ends,
	pub end: Ends,
	pub pre: Vec<i64>,
	pub pre_any: Option<Vec<i64>>,
	pub pre_all: Option<Vec<i64>>,
	pub excl: Vec<i64>,
	pub next: Option<f64>,
	pub objectives: Vec<Option<Objective>>,
	pub objective_text: Option<String>,
	pub zone: Option<f64>,
	pub area: Option<f64>,
	pub xp: Option<f64>,
	pub skill: Option<f64>,
	pub event: Option<f64>,
	pub source_item: Option<f64>,
	pub required_items: Vec<Value>,
	pub repeatable: Option<bool>,
	pub breadcrumbs: Vec<i64>,
	pub breadcrumb_for: Option<f64>,
	pub parent: Option<f64>,
	pub children: Vec<i64>,
	pub escort: Option<bool>,
	pub reputation: Option<Reputation>,
	pub limit: Option<f64>,
	pub web: Option<WebQuest>,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Spawn {
	pub f: Option<String>,
	pub pts: Vec<Vec<f64>>,
	pub more: Option<Vec<Vec<f64>>>,
}

/// An npcs.json or objects.json record.
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default, rename_all = "camelCase")]
pub struct Entity {
	pub id: u32,
	pub name: Option<String>,
	pub level: Option<f64>,
	pub level_max: Option<f64>,
	pub rank: Option<f64>,
	pub faction: Option<String>,
	pub roles: Option<Vec<String>>,
	pub sub_name: Option<String>,
	pub spawns: BTreeMap<u32, Spawn>,
	/// An object's lock (data corrections: Benedict's Chest opens only with Benedict's Key).
	pub lock: Option<Lock>,
}

/// What opens a locked object.
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Lock {
	pub item: Option<u32>,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Drops {
	pub npc: BTreeMap<u32, Option<f64>>,
	pub object: BTreeMap<u32, Option<f64>>,
}

impl Drops {
	pub fn of(&self, kind: Kind) -> &BTreeMap<u32, Option<f64>> {
		match kind {
			Kind::Npc => &self.npc,
			Kind::Object => &self.object,
		}
	}
}

/// An items.json record (drops, vendors and the flags the world reads).
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default, rename_all = "camelCase")]
pub struct Item {
	pub id: u32,
	pub name: Option<String>,
	pub drops: Option<Drops>,
	pub vendors: Option<Vec<i64>>,
	pub quest_item: Option<bool>,
	pub duration: Option<f64>,
	pub containers: Option<Vec<Value>>,
}

#[derive(Clone, Debug, Default, Deserialize)]
pub struct Zone {
	pub id: u32,
	pub name: Option<String>,
	#[serde(rename = "areaId")]
	pub area_id: Option<f64>,
	pub parent: Option<f64>,
	#[serde(rename = "type")]
	pub kind: Option<f64>,
}

/// spawnz.json: `[instanceMap, x, y, z, respawn?]` per spawn, x north and y west, yards.
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Spawnz {
	pub npc: BTreeMap<u32, Vec<Vec<Option<f64>>>>,
	pub object: BTreeMap<u32, Vec<Vec<Option<f64>>>>,
}

impl Spawnz {
	pub fn of(&self, kind: Kind) -> &BTreeMap<u32, Vec<Vec<Option<f64>>>> {
		match kind {
			Kind::Npc => &self.npc,
			Kind::Object => &self.object,
		}
	}
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct MechKind {
	pub kind: String,
	pub drives: bool,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct MechQuest {
	pub kinds: Vec<MechKind>,
	pub params: Vec<Value>,
}

#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct Mechanics {
	pub quests: BTreeMap<u32, MechQuest>,
}

/// CMaNGOS classic-db gameobject facts: `{ type, respawn, loot: { item: [chance, min, max] } }`.
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct ObjectFact {
	#[serde(rename = "type")]
	pub kind: Option<f64>,
	pub respawn: Option<f64>,
	pub loot: Option<BTreeMap<String, Vec<f64>>>,
}

/// CMaNGOS classic-db's graveyards (forge-data cmangos.rs `extract_graveyards`): `links` are
/// `[graveyard, zone (AreaTable id), team (0 any, 67 Horde, 469 Alliance)]`, `locs` the graveyards'
/// places `{ graveyard: [map, x, y, z, name] }` (x north, y west, yards).
#[derive(Clone, Debug, Default, Deserialize)]
#[serde(default)]
pub struct CmGraveyards {
	pub links: Vec<[f64; 3]>,
	pub locs: BTreeMap<u32, (f64, f64, f64, f64, String)>,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub enum Kind {
	Npc,
	Object,
}

impl Kind {
	pub const BOTH: [Kind; 2] = [Kind::Npc, Kind::Object];
	pub fn as_str(self) -> &'static str {
		match self {
			Kind::Npc => "npc",
			Kind::Object => "object",
		}
	}
}

/// The handover rules (sim/rules.json kind `handover`, R9b) the world reads.
#[derive(Clone, Debug)]
pub struct Handover {
	pub id: String,
	pub quest: f64,
	pub objective: f64,
	pub item: f64,
	pub npc: f64,
	pub raw: Value,
}

/// Every input of a world, parsed.
#[derive(Default)]
pub struct GameData {
	pub quests: BTreeMap<u32, Quest>,
	pub npcs: BTreeMap<u32, Entity>,
	pub objects: BTreeMap<u32, Entity>,
	pub items: BTreeMap<u32, Item>,
	pub zones: BTreeMap<u32, Zone>,
	pub frames: MapFrames,
	pub travel: Option<Value>,
	pub trainers: Option<Value>,
	pub dungeons: Option<Value>,
	pub training: Option<Value>,
	pub races: Option<Value>,
	pub mechanics: Option<Mechanics>,
	pub spawnz: Option<Spawnz>,
	/// Client instance areas (Map.csv + AreaTable.csv of the newest cached Forever build).
	pub quest_areas: Option<InstanceAreas>,
	pub object_facts: Option<BTreeMap<u32, ObjectFact>>,
	/// CMaNGOS graveyards (the deathskip's graveyard table, World::graveyards).
	pub graveyards: Option<CmGraveyards>,
	/// rules.json's rules (all kinds; the world reads `handover`).
	pub rules: Vec<Value>,
	/// QuestXP rows by level: 10 tiers (index 0 unused, `null` in JSON).
	pub quest_xp: Option<Vec<Option<Vec<f64>>>>,
}

/// Where the inputs come from: a file name relative to its root -> bytes, or None when absent.
/// Roots: "data" (data/forever), "sources" (data/sources), "rules" (the sim rules file).
pub trait Source {
	fn read(&self, root: &str, name: &str) -> Option<Vec<u8>>;
	/// File names in a directory of a root (for the newest client build); empty when unknown.
	fn list(&self, _root: &str, _dir: &str) -> Vec<String> {
		Vec::new()
	}
}

fn parse<T: serde::de::DeserializeOwned>(name: &str, bytes: &[u8]) -> Result<T, Error> {
	serde_json::from_slice(bytes).map_err(|e| format!("{name}: {e}").into())
}

/// The newest cached Forever client build (1.6x) with Map.csv and AreaTable.csv (solo.js foreverBuild).
pub fn forever_build(src: &dyn Source) -> Option<String> {
	let mut ok: Vec<String> = src
		.list("sources", "wago")
		.into_iter()
		.filter(|b| {
			let re = b.starts_with("1.6") && b.len() > 4 && b.as_bytes()[3].is_ascii_digit() && b.as_bytes()[4] == b'.';
			re && ["Map.csv", "AreaTable.csv"].iter().all(|f| src.read("sources", &format!("wago/{b}/{f}")).is_some())
		})
		.collect();
	let parts = |s: &str| -> Vec<f64> { s.split('.').map(|p| p.parse::<f64>().unwrap_or(f64::NAN)).collect() };
	ok.sort_by(|a, b| {
		let (pa, pb) = (parts(a), parts(b));
		for i in 0..4 {
			let (x, y) = (pa.get(i).copied().unwrap_or(0.0), pb.get(i).copied().unwrap_or(0.0));
			let (x, y) = (if x.is_nan() { 0.0 } else { x }, if y.is_nan() { 0.0 } else { y });
			if x != y {
				return x.partial_cmp(&y).unwrap();
			}
		}
		std::cmp::Ordering::Equal
	});
	ok.pop()
}

/// CMaNGOS classic-db revision the object facts are cached under (cmangos.js DB_REV, first 12).
pub const CMANGOS_REV12: &str = "22b51464f162";
/// The QuestXP table's build (game/xp.js QUESTXP_BUILD).
pub const QUESTXP_BUILD: &str = "1.15.9.70003";

impl GameData {
	/// Parses every world input from a source.
	pub fn from_source(src: &dyn Source) -> Result<GameData, Error> {
		let need = |name: &str| -> Result<Vec<u8>, Error> { src.read("data", name).ok_or_else(|| format!("{name} not found (run `forge data build`)").into()) };
		let opt = |name: &str| src.read("data", name);
		let mut d = GameData { quests: parse("quests.json", &need("quests.json")?)?, npcs: parse("npcs.json", &need("npcs.json")?)?, ..GameData::default() };
		if let Some(b) = opt("objects.json") {
			d.objects = parse("objects.json", &b)?;
		}
		if let Some(b) = opt("items.json") {
			d.items = parse("items.json", &b)?;
		}
		if let Some(b) = opt("zones.json") {
			d.zones = parse("zones.json", &b)?;
		}
		if let Some(b) = opt("map-frames.json") {
			d.frames = MapFrames::from_json(&b).map_err(|e| format!("map-frames.json: {e}"))?;
		}
		for (name, slot) in [("travel.json", &mut d.travel), ("trainers.json", &mut d.trainers), ("dungeons.json", &mut d.dungeons), ("training.json", &mut d.training), ("races.json", &mut d.races)] {
			if let Some(b) = opt(name) {
				*slot = Some(parse(name, &b)?);
			}
		}
		if let Some(b) = opt("mechanics.json") {
			d.mechanics = Some(parse("mechanics.json", &b)?);
		}
		if let Some(b) = opt("spawnz.json") {
			d.spawnz = Some(parse("spawnz.json", &b)?);
		}
		if let Some(build) = forever_build(src) {
			let read = |f: &str| -> Result<String, Error> {
				let b = src.read("sources", &format!("wago/{build}/{f}")).ok_or_else(|| format!("missing {f}"))?;
				Ok(String::from_utf8(b)?)
			};
			let maps = parse_csv(&read("Map.csv")?)?;
			let areas = parse_csv(&read("AreaTable.csv")?)?;
			d.quest_areas = Some(InstanceAreas { build, areas: instance_areas(&maps, &areas) });
		}
		if let Some(b) = src.read("sources", &format!("cmangos/{CMANGOS_REV12}/gameobject_facts.json")) {
			d.object_facts = Some(parse("gameobject_facts.json", &b)?);
		}
		if let Some(b) = src.read("sources", &format!("cmangos/{CMANGOS_REV12}/graveyards.json")) {
			d.graveyards = Some(parse("graveyards.json", &b)?);
		}
		if let Some(b) = src.read("rules", "rules.json") {
			let doc: Value = parse("rules.json", &b)?;
			if doc.get("schema").and_then(Value::as_f64) != Some(1.0) || !doc.get("rules").is_some_and(Value::is_array) {
				return Err("rules.json: expected { schema: 1, rules: [...] }".into());
			}
			d.rules = doc["rules"].as_array().cloned().unwrap_or_default();
		}
		if let Some(b) = src.read("sources", &format!("wago/{QUESTXP_BUILD}/QuestXP.csv")) {
			d.quest_xp = Some(parse_quest_xp(&String::from_utf8(b)?)?);
		}
		Ok(d)
	}

	/// The giver rules (rules.json kind `giver`): quest -> the NPC of its several givers it is taken
	/// from (Report to Gryan Stoutmantle from Deputy Rainer on the road into Westfall, #416).
	pub fn giver_rule(&self, quest: u32) -> Option<u32> {
		self.rules
			.iter()
			.filter(|r| r.get("kind").and_then(Value::as_str) == Some("giver"))
			.find(|r| r.get("quest").and_then(Value::as_u64) == Some(u64::from(quest)))
			.and_then(|r| r.get("npc").and_then(Value::as_u64))
			.and_then(|n| u32::try_from(n).ok())
	}

	/// The handover rules (rules.json kind `handover`), in file order.
	pub fn handovers(&self) -> Vec<Handover> {
		self.rules
			.iter()
			.filter(|r| r.get("kind").and_then(Value::as_str) == Some("handover"))
			.map(|r| Handover {
				id: r.get("id").and_then(Value::as_str).unwrap_or("").to_string(),
				quest: crate::json::num(r.get("quest")),
				objective: crate::json::num(r.get("objective")),
				item: crate::json::num(r.get("item")),
				npc: crate::json::num(r.get("npc")),
				raw: r.clone(),
			})
			.collect()
	}

	pub fn entities(&self, kind: Kind) -> &BTreeMap<u32, Entity> {
		match kind {
			Kind::Npc => &self.npcs,
			Kind::Object => &self.objects,
		}
	}

	/// Era and Forever frames keyed by map id.
	pub fn frame_maps(&self) -> (FxHashMap<u32, Bounds>, FxHashMap<u32, Bounds>) {
		let conv = |m: &FxHashMap<String, Bounds>| m.iter().filter_map(|(k, b)| Some((k.parse().ok()?, *b))).collect();
		(conv(&self.frames.era), conv(&self.frames.forever))
	}
}

/// QuestXP.csv -> rows[level] = [tier0..tier9] (game/xp.js parseQuestXp).
pub fn parse_quest_xp(text: &str) -> Result<Vec<Option<Vec<f64>>>, Error> {
	let mut rows: Vec<Option<Vec<f64>>> = Vec::new();
	for r in parse_csv(text)? {
		let lvl = crate::json::num(r.get("ID").map(|s| Value::String(s.clone())).as_ref());
		if lvl.fract() != 0.0 || !lvl.is_finite() || lvl < 1.0 {
			continue;
		}
		let lvl = lvl as usize;
		let tiers = (0..10)
			.map(|i| {
				let v = crate::json::num(r.get(&format!("Difficulty_{i}")).map(|s| Value::String(s.clone())).as_ref());
				if v.is_nan() {
					0.0
				} else {
					v
				}
			})
			.collect();
		if rows.len() <= lvl {
			rows.resize(lvl + 1, None);
		}
		rows[lvl] = Some(tiers);
	}
	if rows.get(1).is_none_or(Option::is_none) || rows.get(60).is_none_or(Option::is_none) {
		return Err("QuestXP table lacks levels 1-60".into());
	}
	Ok(rows)
}

/// Files on disk: data/forever, data/sources and the rules file.
#[cfg(feature = "native")]
pub struct DirSource {
	pub data: std::path::PathBuf,
	pub sources: Option<std::path::PathBuf>,
	pub rules: Option<std::path::PathBuf>,
}

#[cfg(feature = "native")]
impl DirSource {
	/// A repository checkout: data/forever, data/sources, data/rules.json.
	pub fn repo(root: &std::path::Path) -> DirSource {
		DirSource { data: root.join("data/forever"), sources: Some(root.join("data/sources")), rules: Some(root.join("data/rules.json")) }
	}
	fn root(&self, root: &str) -> Option<&std::path::Path> {
		match root {
			"data" => Some(&self.data),
			"sources" => self.sources.as_deref(),
			"rules" => self.rules.as_deref().and_then(std::path::Path::parent),
			_ => None,
		}
	}
}

#[cfg(feature = "native")]
impl Source for DirSource {
	fn read(&self, root: &str, name: &str) -> Option<Vec<u8>> {
		if root == "rules" {
			return self.rules.as_ref().and_then(|p| std::fs::read(p).ok());
		}
		std::fs::read(self.root(root)?.join(name)).ok()
	}
	fn list(&self, root: &str, dir: &str) -> Vec<String> {
		let Some(r) = self.root(root) else { return Vec::new() };
		std::fs::read_dir(r.join(dir)).map(|it| it.filter_map(|e| e.ok()?.file_name().into_string().ok()).collect()).unwrap_or_default()
	}
}
