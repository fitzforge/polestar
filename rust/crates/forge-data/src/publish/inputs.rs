//! The publish inputs: the KB, the public data builds, CMaNGOS classic-db (a sqlite load of the
//! dump), ForeverTDB and Factoruide's own row sources. Every input but the public builds is
//! optional; a missing one only leaves the fields it backs without support.

use std::path::Path;

use rusqlite::{Connection, OpenFlags};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::{Map, Value};

use crate::tdb::SNIFFED;

pub fn open_ro(p: &Path) -> Result<Connection, String> {
	Connection::open_with_flags(p, OpenFlags::SQLITE_OPEN_READ_ONLY | OpenFlags::SQLITE_OPEN_NO_MUTEX).map_err(|e| format!("{}: {e}", p.display()))
}

fn e(p: &Path) -> impl Fn(rusqlite::Error) -> String + '_ {
	move |x| format!("{}: {x}", p.display())
}

fn int(v: rusqlite::types::Value) -> i64 {
	use rusqlite::types::Value as Sq;
	match v {
		Sq::Integer(i) => i,
		Sq::Real(f) => f as i64,
		Sq::Text(s) => s.trim().parse::<f64>().map(|f| f as i64).unwrap_or(0),
		_ => 0,
	}
}

fn text(v: rusqlite::types::Value) -> String {
	use rusqlite::types::Value as Sq;
	match v {
		Sq::Text(s) => s,
		Sq::Integer(i) => i.to_string(),
		Sq::Real(f) => f.to_string(),
		_ => String::new(),
	}
}

/// Rows of `sql` as column-name -> value maps.
fn rows(db: &Connection, p: &Path, sql: &str) -> Result<Vec<FxHashMap<String, rusqlite::types::Value>>, String> {
	let mut st = db.prepare(sql).map_err(e(p))?;
	let names: Vec<String> = st.column_names().iter().map(|s| s.to_string()).collect();
	let it = st
		.query_map([], |r| {
			let mut m = FxHashMap::default();
			for (i, n) in names.iter().enumerate() {
				m.insert(n.clone(), r.get::<_, rusqlite::types::Value>(i)?);
			}
			Ok(m)
		})
		.map_err(e(p))?;
	it.collect::<Result<Vec<_>, _>>().map_err(e(p))
}

fn columns(db: &Connection, table: &str) -> FxHashSet<String> {
	let mut out = FxHashSet::default();
	if let Ok(mut st) = db.prepare(&format!("pragma table_info({table})")) {
		if let Ok(it) = st.query_map([], |r| r.get::<_, String>(1)) {
			out.extend(it.flatten());
		}
	}
	out
}

trait Get {
	fn i(&self, k: &str) -> i64;
	fn s(&self, k: &str) -> String;
}

impl Get for FxHashMap<String, rusqlite::types::Value> {
	fn i(&self, k: &str) -> i64 {
		self.get(k).cloned().map(int).unwrap_or(0)
	}
	fn s(&self, k: &str) -> String {
		self.get(k).cloned().map(text).unwrap_or_default()
	}
}

// ---------------------------------------------------------------- KB

pub struct Fact {
	pub kind: String,
	pub id: i64,
	pub field: String,
	pub value: String,
	pub source: String,
	pub confidence: String,
}

pub struct Alt {
	pub source: String,
	pub value: String,
	pub agrees: bool,
}

pub struct MechanicRow {
	pub quest: i64,
	pub kind: String,
	pub status: String,
	pub drives: i64,
	pub confidence: String,
	pub sources: Vec<String>,
}

pub struct StepRow {
	pub quest: i64,
	pub n: i64,
	pub action: String,
	pub target_kind: String,
	pub target: i64,
	/// The step's item (a loot or use step), 0 when none.
	pub item: i64,
	pub count: i64,
	pub place: String,
	pub text: String,
	pub confidence: String,
	pub source: String,
	pub evidence: String,
	/// game-data | community once the KB carries rewritten notes (`basis`); empty before.
	pub basis: String,
}

pub struct Kb {
	pub facts: Vec<Fact>,
	pub alts: FxHashMap<(String, i64, String), Vec<Alt>>,
	/// Source label -> tier (lower wins).
	pub tiers: FxHashMap<String, f64>,
	/// The KB tells site-sourced Factoruide rows apart (`factoruide.web`).
	pub factoruide_split: bool,
	/// id -> title (the KB's quests table).
	pub quests: Vec<(i64, String)>,
	pub npcs: Vec<(i64, String)>,
	pub objects: Vec<(i64, String)>,
	pub items: Vec<(i64, String)>,
	/// item -> droppers (kind, id).
	pub drop_items: FxHashSet<i64>,
	pub npcs_with_spawns: FxHashSet<i64>,
	pub objects_with_spawns: FxHashSet<i64>,
	pub mechanics: Vec<MechanicRow>,
	/// None until the KB's steps carry `source` and `evidence`.
	pub steps: Option<Vec<StepRow>>,
}

pub fn load_kb(p: &Path) -> Result<Kb, String> {
	let db = open_ro(p)?;
	let mut facts = Vec::new();
	for r in rows(&db, p, "select kind, id, field, value, source, confidence from facts order by kind, id, field")? {
		facts.push(Fact { kind: r.s("kind"), id: r.i("id"), field: r.s("field"), value: r.s("value"), source: r.s("source"), confidence: r.s("confidence") });
	}
	let mut alts: FxHashMap<(String, i64, String), Vec<Alt>> = FxHashMap::default();
	for r in rows(&db, p, "select kind, id, field, source, value, agrees from alternatives")? {
		alts.entry((r.s("kind"), r.i("id"), r.s("field"))).or_default().push(Alt { source: r.s("source"), value: r.s("value"), agrees: r.i("agrees") != 0 });
	}
	// Facts with only check-only values have no facts row: their alternatives are the candidates.
	let have: FxHashSet<(String, i64, String)> = facts.iter().map(|f| (f.kind.clone(), f.id, f.field.clone())).collect();
	let mut extra: Vec<&(String, i64, String)> = alts.keys().filter(|k| !have.contains(*k)).collect();
	extra.sort();
	for (kind, id, field) in extra {
		facts.push(Fact { kind: kind.clone(), id: *id, field: field.clone(), value: String::new(), source: String::new(), confidence: "low".into() });
	}
	let mut tiers = FxHashMap::default();
	for r in rows(&db, p, "select name, tier from sources")? {
		let t = match r.get("tier") {
			Some(rusqlite::types::Value::Real(f)) => *f,
			Some(rusqlite::types::Value::Integer(i)) => *i as f64,
			_ => 9.0,
		};
		tiers.insert(r.s("name"), t);
	}
	let factoruide_split = tiers.contains_key("factoruide.web");
	let pairs = |sql: &str| -> Result<Vec<(i64, String)>, String> { Ok(rows(&db, p, sql)?.into_iter().map(|r| (r.i("id"), r.s("name"))).collect()) };
	let quests = pairs("select id, coalesce(title, '') name from quests order by id")?;
	let npcs = pairs("select id, coalesce(name, '') name from npcs order by id")?;
	let objects = pairs("select id, coalesce(name, '') name from objects order by id")?;
	let items = pairs("select id, coalesce(name, '') name from items order by id")?;
	let drop_items = rows(&db, p, "select distinct item from drops")?.into_iter().map(|r| r.i("item")).collect();
	let mut npcs_with_spawns = FxHashSet::default();
	let mut objects_with_spawns = FxHashSet::default();
	for r in rows(&db, p, "select distinct kind, id from spawns")? {
		match r.s("kind").as_str() {
			"npc" => npcs_with_spawns.insert(r.i("id")),
			"object" => objects_with_spawns.insert(r.i("id")),
			_ => false,
		};
	}
	let mut mechanics = Vec::new();
	for r in rows(&db, p, "select quest, kind, status, confidence, drives, sources from mechanics order by quest, kind")? {
		let sources = serde_json::from_str::<Vec<String>>(&r.s("sources")).unwrap_or_default();
		mechanics.push(MechanicRow { quest: r.i("quest"), kind: r.s("kind"), status: r.s("status"), drives: r.i("drives"), confidence: r.s("confidence"), sources });
	}
	let sc = columns(&db, "steps");
	let steps = if sc.contains("source") && sc.contains("evidence") {
		let mut out = Vec::new();
		let basis = if sc.contains("basis") { "basis" } else { "''" };
		let item = if sc.contains("item") { "item" } else { "0" };
		for r in
			rows(&db, p, &format!("select quest, n, action, target_kind, target, {item} item, count, place, fact, confidence, source, evidence, {basis} basis from steps order by quest, n, rowid"))?
		{
			out.push(StepRow {
				quest: r.i("quest"),
				n: r.i("n"),
				action: r.s("action"),
				target_kind: r.s("target_kind"),
				target: r.i("target"),
				item: r.i("item"),
				count: r.i("count"),
				place: r.s("place"),
				text: r.s("fact"),
				confidence: r.s("confidence"),
				source: r.s("source"),
				evidence: r.s("evidence"),
				basis: r.s("basis"),
			});
		}
		Some(out)
	} else {
		None
	};
	Ok(Kb { facts, alts, tiers, factoruide_split, quests, npcs, objects, items, drop_items, npcs_with_spawns, objects_with_spawns, mechanics, steps })
}

// ---------------------------------------------------------------- Factoruide row sources

/// Factoruide's own row `sources` (its sqlite), for telling its site-sourced rows apart until
/// the KB carries `factoruide.web`.
#[derive(Default)]
pub struct Factoruide {
	quest: FxHashMap<i64, FxHashSet<String>>,
	npc: FxHashMap<i64, FxHashSet<String>>,
	relation: FxHashMap<(i64, String), FxHashSet<String>>,
	objective: FxHashMap<i64, FxHashSet<String>>,
}

/// Factoruide row origins that are not the site (QuestieDB counts since it ships in the tier).
const FAC_OK: &[&str] = &["vmangos", "att", "pfquest", "client_cache", "collector", "collector_seen", "player_cache", "manual", "questie"];

fn site_origin(s: &str) -> bool {
	// The site's own origin tags in Factoruide ("<site>" and "<site>_series").
	const P: [&str; 2] = ["wow", "head"];
	s.starts_with(&P.concat())
}

fn split(s: &str) -> FxHashSet<String> {
	s.split(',').map(str::trim).filter(|x| !x.is_empty()).map(String::from).collect()
}

pub fn load_factoruide(p: &Path) -> Result<Factoruide, String> {
	let db = open_ro(p)?;
	let mut f = Factoruide::default();
	for r in rows(&db, p, "select id, sources from m_quest")? {
		f.quest.insert(r.i("id"), split(&r.s("sources")));
	}
	for r in rows(&db, p, "select id, sources from m_npc")? {
		f.npc.insert(r.i("id"), split(&r.s("sources")));
	}
	for r in rows(&db, p, "select quest_id, role, sources from m_quest_relation")? {
		f.relation.entry((r.i("quest_id"), r.s("role").to_lowercase())).or_default().extend(split(&r.s("sources")));
	}
	for r in rows(&db, p, "select quest_id, source from m_quest_objective")? {
		f.objective.entry(r.i("quest_id")).or_default().extend(split(&r.s("source")));
	}
	Ok(f)
}

impl Factoruide {
	/// The row behind a KB fact has a shippable origin and no site origin.
	pub fn ok(&self, kind: &str, id: i64, field: &str) -> bool {
		let empty = FxHashSet::default();
		let s = if kind == "npc" {
			self.npc.get(&id).unwrap_or(&empty)
		} else if field == "start" || field == "end" {
			self.relation.get(&(id, field.to_string())).unwrap_or(&empty)
		} else if field == "objectives" && self.objective.get(&id).is_some_and(|s| !s.is_empty()) {
			&self.objective[&id]
		} else {
			self.quest.get(&id).unwrap_or(&empty)
		};
		s.iter().any(|x| FAC_OK.contains(&x.as_str())) && !s.iter().any(|x| site_origin(x))
	}
}

// ---------------------------------------------------------------- CMaNGOS classic-db

#[derive(Default)]
pub struct CmQuest {
	pub prev: i64,
	pub breadcrumb_for: i64,
	pub info: i64,
	pub zone: i64,
	pub money: i64,
	pub repeatable: bool,
	/// (kind, id, count)
	pub rewards: Vec<(&'static str, i64, i64)>,
}

#[derive(Default)]
pub struct CmNpc {
	pub faction: i64,
	pub rank: Option<i64>,
}

/// CMaNGOS classic-db: quest and creature facts from the dump's quest_facts.json extract, and,
/// from its sqlite load when present, loot, game object and item names and the flags the
/// extract does not carry.
#[derive(Default)]
pub struct Cm {
	pub quest: FxHashMap<i64, CmQuest>,
	pub npc: FxHashMap<i64, CmNpc>,
	/// id -> (name, type)
	pub object: FxHashMap<i64, (String, i64)>,
	pub item: FxHashMap<i64, String>,
	/// (item, kind, entity, chance percent)
	pub loot: Vec<(i64, &'static str, i64, f64)>,
}

/// quest_facts.json (forge_data::cmangos::load_quest_facts) into `cm`.
pub fn load_cm_facts(sources: &Path, cm: &mut Cm) -> Result<(), String> {
	let v = crate::cmangos::load_quest_facts(sources)?;
	let n = |x: &forge_guide::js::V| if x.truthy() { x.num() as i64 } else { 0 };
	for (id, q) in v.get("quest").entries() {
		let Ok(id) = id.parse::<i64>() else { continue };
		let mut c = CmQuest { prev: n(&q.get("prev")), info: n(&q.get("type")), zone: n(&q.get("zone")), money: n(&q.get("money")), ..Default::default() };
		for (k, kind) in [("items", "item"), ("choices", "choice"), ("rep", "rep")] {
			for e in q.get(k).items() {
				let id = n(&e.at(0));
				if id > 0 {
					c.rewards.push((kind, id, n(&e.at(1))));
				}
			}
		}
		cm.quest.insert(id, c);
	}
	for (id, t) in v.get("npc").entries() {
		let Ok(id) = id.parse::<i64>() else { continue };
		cm.npc.entry(id).or_default().faction = n(&t.at(4));
	}
	Ok(())
}

/// Loot rows of one table: loot id -> [(item, chance)], equal-chance group members sharing the
/// group's remainder; reference rows (mincountOrRef < 0) are left out.
fn loot_table(db: &Connection, p: &Path, table: &str) -> Result<FxHashMap<i64, Vec<(i64, f64)>>, String> {
	let mut by: FxHashMap<i64, Vec<(i64, f64, i64)>> = FxHashMap::default();
	let mut st = db.prepare(&format!("select entry, item, ChanceOrQuestChance, groupid, mincountOrRef from {table}")).map_err(e(p))?;
	let it = st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, i64>(1)?, r.get::<_, f64>(2)?, r.get::<_, i64>(3)?, r.get::<_, i64>(4)?))).map_err(e(p))?;
	for x in it {
		let (entry, item, ch, group, minc) = x.map_err(e(p))?;
		if minc < 0 {
			continue;
		}
		by.entry(entry).or_default().push((item, ch.abs(), group));
	}
	let mut out: FxHashMap<i64, Vec<(i64, f64)>> = FxHashMap::default();
	for (entry, list) in by {
		let mut groups: FxHashMap<i64, (f64, usize)> = FxHashMap::default();
		for (_, ch, g) in &list {
			if *g > 0 {
				let s = groups.entry(*g).or_default();
				if *ch > 0.0 {
					s.0 += ch;
				} else {
					s.1 += 1;
				}
			}
		}
		let v = list
			.into_iter()
			.map(|(item, ch, g)| {
				let ch = if ch == 0.0 && g > 0 {
					let (sum, n) = groups[&g];
					((100.0 - sum).max(0.0)) / n.max(1) as f64
				} else {
					ch
				};
				(item, ch)
			})
			.collect();
		out.insert(entry, v);
	}
	Ok(out)
}

/// The classic-db sqlite load into `cm`: loot, object and item names, ranks, repeatable and
/// breadcrumb flags.
pub fn load_cm_db(p: &Path, cm: &mut Cm) -> Result<(), String> {
	let db = open_ro(p)?;
	for d in rows(&db, p, "select entry, SpecialFlags, BreadcrumbForQuestId from quest_template")? {
		let q = cm.quest.entry(d.i("entry")).or_default();
		q.repeatable = d.i("SpecialFlags") & 1 != 0;
		q.breadcrumb_for = d.i("BreadcrumbForQuestId");
	}
	let mut loot_of_npc: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in rows(&db, p, "select Entry, Rank, LootId from creature_template")? {
		cm.npc.entry(r.i("Entry")).or_default().rank = Some(r.i("Rank"));
		if r.i("LootId") > 0 {
			loot_of_npc.entry(r.i("LootId")).or_default().push(r.i("Entry"));
		}
	}
	let mut chest: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in rows(&db, p, "select entry, name, type, data1 from gameobject_template")? {
		cm.object.insert(r.i("entry"), (r.s("name"), r.i("type")));
		if r.i("type") == 3 && r.i("data1") > 0 {
			chest.entry(r.i("data1")).or_default().push(r.i("entry"));
		}
	}
	for r in rows(&db, p, "select entry, name from item_template")? {
		cm.item.insert(r.i("entry"), r.s("name"));
	}
	for (loot, list) in loot_table(&db, p, "creature_loot_template")? {
		for npc in loot_of_npc.get(&loot).into_iter().flatten() {
			for (item, ch) in &list {
				cm.loot.push((*item, "npc", *npc, *ch));
			}
		}
	}
	for (loot, list) in loot_table(&db, p, "gameobject_loot_template")? {
		for obj in chest.get(&loot).into_iter().flatten() {
			for (item, ch) in &list {
				cm.loot.push((*item, "object", *obj, *ch));
			}
		}
	}
	Ok(())
}

// ---------------------------------------------------------------- ForeverTDB

pub struct TdbQuest {
	pub info: i64,
	pub sort: i64,
	pub repeatable: bool,
	pub prev: i64,
	pub breadcrumb_for: i64,
	pub rewards: Vec<(&'static str, i64, Option<i64>)>,
}

#[derive(Default)]
pub struct Tdb {
	/// Sniffed quests (VerifiedBuild at or above the Forever sniff build) only: the inherited
	/// rows carry another client's rewards.
	pub quest: FxHashMap<i64, TdbQuest>,
	pub money: FxHashMap<i64, i64>,
	pub disabled: FxHashSet<i64>,
	/// entry -> (faction template, classification), sniffed rows.
	pub npc: FxHashMap<i64, (i64, i64)>,
	/// entry -> (name, type), sniffed rows.
	pub object: FxHashMap<i64, (String, i64)>,
}

pub fn load_tdb(p: &Path) -> Result<Tdb, String> {
	let db = open_ro(p)?;
	let mut t = Tdb::default();
	let addon: FxHashMap<i64, (i64, i64, i64)> = rows(&db, p, "select ID, SpecialFlags, PrevQuestID, BreadcrumbForQuestId from quest_template_addon")?
		.into_iter()
		.map(|r| (r.i("ID"), (r.i("SpecialFlags"), r.i("PrevQuestID"), r.i("BreadcrumbForQuestId"))))
		.collect();
	for r in rows(&db, p, &format!("select * from quest_template where VerifiedBuild >= {SNIFFED}"))? {
		let id = r.i("ID");
		let (special, prev, bc) = addon.get(&id).copied().unwrap_or_default();
		let mut rewards = Vec::new();
		for n in 1..=4 {
			if r.i(&format!("RewardItem{n}")) > 0 {
				rewards.push(("item", r.i(&format!("RewardItem{n}")), Some(r.i(&format!("RewardAmount{n}")))));
			}
		}
		for n in 1..=6 {
			if r.i(&format!("RewardChoiceItemID{n}")) > 0 {
				rewards.push(("choice", r.i(&format!("RewardChoiceItemID{n}")), Some(r.i(&format!("RewardChoiceItemQuantity{n}")))));
			}
		}
		for n in 1..=5 {
			let f = r.i(&format!("RewardFactionID{n}"));
			if f > 0 {
				let o = r.i(&format!("RewardFactionOverride{n}"));
				rewards.push(("rep", f, (o != 0).then_some(o / 100)));
			}
		}
		t.quest.insert(id, TdbQuest { info: r.i("QuestInfoID"), sort: r.i("QuestSortID"), repeatable: special & 1 != 0, prev, breadcrumb_for: bc, rewards });
	}
	for r in rows(&db, p, "select ID, RewardMoney from quest_classic_money where RewardMoney > 0")? {
		t.money.insert(r.i("ID"), r.i("RewardMoney"));
	}
	for r in rows(&db, p, "select entry from disables where sourceType = 1")? {
		t.disabled.insert(r.i("entry"));
	}
	for r in rows(&db, p, &format!("select entry, faction, Classification from creature_template where VerifiedBuild >= {SNIFFED}"))? {
		t.npc.insert(r.i("entry"), (r.i("faction"), r.i("Classification")));
	}
	for r in rows(&db, p, &format!("select entry, name, type from gameobject_template where VerifiedBuild >= {SNIFFED}"))? {
		t.object.insert(r.i("entry"), (r.s("name"), r.i("type")));
	}
	Ok(t)
}

// ---------------------------------------------------------------- public data builds

/// One public data build's tables (data/forever-shaped JSON).
pub struct BuildData {
	pub quests: Map<String, Value>,
	pub npcs: Map<String, Value>,
	pub objects: Map<String, Value>,
	pub items: Map<String, Value>,
	pub meta: Value,
	pub frames: Vec<u8>,
	/// zones.json: zone name -> uiMap id (a zone map before other map types on a shared name).
	pub zone_ids: FxHashMap<String, u32>,
	/// CMaNGOS spawnz.json: kind -> id -> [[map, x, y, z]].
	pub spawnz: Value,
}

fn read_json(p: &Path) -> Result<Value, String> {
	let b = std::fs::read(p).map_err(|x| format!("{}: {x}", p.display()))?;
	serde_json::from_slice(&b).map_err(|x| format!("{}: {x}", p.display()))
}

fn table(v: Value, key: &str) -> Map<String, Value> {
	match v {
		Value::Object(mut m) if m.get(key).is_some_and(Value::is_object) => m.remove(key).and_then(|x| x.as_object().cloned()).unwrap_or_default(),
		Value::Object(m) => m,
		_ => Map::new(),
	}
}

fn zone_ids(z: &Value) -> FxHashMap<String, u32> {
	let mut best: FxHashMap<String, (bool, u32)> = FxHashMap::default();
	for (k, v) in z.as_object().into_iter().flatten() {
		let (Some(name), Ok(id)) = (v.get("name").and_then(Value::as_str), k.parse::<u32>()) else { continue };
		let zone = v.get("type").and_then(Value::as_i64) == Some(3);
		let e = best.entry(name.to_string()).or_insert((zone, id));
		if (zone && !e.0) || (zone == e.0 && id < e.1) {
			*e = (zone, id);
		}
	}
	best.into_iter().map(|(k, (_, id))| (k, id)).collect()
}

pub fn load_build(dir: &Path) -> Result<BuildData, String> {
	Ok(BuildData {
		quests: table(read_json(&dir.join("quests.json"))?, "quests"),
		npcs: table(read_json(&dir.join("npcs.json"))?, "npcs"),
		objects: table(read_json(&dir.join("objects.json"))?, "objects"),
		items: table(read_json(&dir.join("items.json"))?, "items"),
		meta: read_json(&dir.join("meta.json"))?,
		frames: std::fs::read(dir.join("map-frames.json")).map_err(|x| format!("{}: {x}", dir.join("map-frames.json").display()))?,
		zone_ids: zone_ids(&read_json(&dir.join("zones.json")).unwrap_or(Value::Null)),
		spawnz: read_json(&dir.join("spawnz.json")).unwrap_or(Value::Null),
	})
}

impl BuildData {
	/// The Forever client build the tables come from (meta.json), without the product name.
	pub fn client_build(&self) -> Option<String> {
		for s in self.meta.get("sources")?.as_array()? {
			let name = s.get("name").and_then(Value::as_str).unwrap_or("");
			if name.contains("Forever client tables") {
				let rev = s.get("revision").and_then(Value::as_str)?;
				return Some(rev.rsplit(' ').next().unwrap_or(rev).to_string());
			}
		}
		None
	}

	/// The MIT notice pfQuest ships (meta.json).
	pub fn pfquest_notice(&self) -> Option<String> {
		for s in self.meta.get("sources")?.as_array()? {
			if s.get("name").and_then(Value::as_str) == Some("pfQuest") {
				return s.get("notice").and_then(Value::as_str).map(String::from);
			}
		}
		None
	}

	/// A build row's `source` tags as KB-style labels; tags that name no independent origin map
	/// to themselves (and so back nothing). A build without QuestieDB leaves its pfQuest entity
	/// rows untagged: those are pfQuest's.
	pub fn labels(&self, row: &Value) -> Vec<String> {
		let mut out: Vec<String> = Vec::new();
		for t in row.get("source").and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_str) {
			let l = match t {
				"pfquest" => "pfquest",
				t if t.starts_with("questie") => "questie",
				t if t.contains("record") => "recorder",
				t if t.starts_with("cmangos") => "cmangos",
				t => t,
			}
			.to_string();
			if !out.contains(&l) {
				out.push(l);
			}
		}
		if out.is_empty() && row.is_object() && !self.has_questie() {
			out.push("pfquest".into());
		}
		out
	}

	fn has_questie(&self) -> bool {
		self.meta.get("sources").and_then(Value::as_array).into_iter().flatten().any(|s| s.get("name").and_then(Value::as_str).is_some_and(|n| n.contains("QuestieDB")))
	}
}
