//! The Forever TrinityCore world database (advocaite/TrinityCore `forever`, GPL-2.0) as facts (port
//! of tools/lib/travel/forevertdb.js): data/local/forever-tdb/world.sqlite (local, never shipped)
//! -> <sources>/forever-tdb/extract.json, re-extracted when the database's _meta or the schema
//! changed; without the database an existing extract is used as it is.

use std::path::Path;

use forge_guide::js::{num_str, parse_json, stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};
use rusqlite::types::Value as Sq;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{arr, math_round, nums};

pub const SCHEMA: f64 = 7.0;
pub const SNIFFED: i64 = 70000;
const REPO_URL: &str = "https://github.com/advocaite/TrinityCore/tree/forever";
const SPAWN_MAPS: &str = "0,1,2991,2997";
const APPRENTICE_RIDING: [i64; 2] = [33388, 33389];

fn class_of_id(id: i64) -> Option<&'static str> {
	Some(match id {
		1 => "WARRIOR",
		2 => "PALADIN",
		3 => "HUNTER",
		4 => "ROGUE",
		5 => "PRIEST",
		7 => "SHAMAN",
		8 => "MAGE",
		9 => "WARLOCK",
		11 => "DRUID",
		_ => return None,
	})
}

/// One row: column -> value.
struct Row(Vec<(String, Sq)>);

impl Row {
	fn v(&self, k: &str) -> &Sq {
		self.0.iter().find(|(c, _)| c == k).map(|(_, v)| v).unwrap_or(&Sq::Null)
	}
	/// `Number`-like value (null -> NaN; text parsed).
	fn n(&self, k: &str) -> f64 {
		match self.v(k) {
			Sq::Integer(i) => *i as f64,
			Sq::Real(r) => *r,
			Sq::Text(t) => forge_guide::js::str_to_num(t),
			_ => f64::NAN,
		}
	}
	/// `x || 0`.
	fn n0(&self, k: &str) -> f64 {
		let n = self.n(k);
		if n.is_nan() {
			0.0
		} else {
			n
		}
	}
	fn i(&self, k: &str) -> i64 {
		self.n0(k) as i64
	}
	fn s(&self, k: &str) -> Option<String> {
		match self.v(k) {
			Sq::Text(t) => Some(t.clone()),
			Sq::Integer(i) => Some(i.to_string()),
			Sq::Real(r) => Some(num_str(*r)),
			_ => None,
		}
	}
	/// JS truthiness of the value.
	fn truthy(&self, k: &str) -> bool {
		match self.v(k) {
			Sq::Integer(i) => *i != 0,
			Sq::Real(r) => *r != 0.0 && !r.is_nan(),
			Sq::Text(t) => !t.is_empty(),
			Sq::Blob(_) => true,
			Sq::Null => false,
		}
	}
	/// The value as JS would hold it.
	fn js(&self, k: &str) -> V {
		match self.v(k) {
			Sq::Integer(i) => V::Num(*i as f64),
			Sq::Real(r) => V::Num(*r),
			Sq::Text(t) => V::str(t),
			_ => V::Null,
		}
	}
}

fn all(db: &rusqlite::Connection, sql: &str, params: &[&dyn rusqlite::ToSql]) -> Result<Vec<Row>, String> {
	let mut st = db.prepare(sql).map_err(|e| format!("{sql}: {e}"))?;
	let names: Vec<String> = st.column_names().iter().map(|s| s.to_string()).collect();
	let rows = st.query_map(params, |r| Ok(Row((0..names.len()).map(|i| (names[i].clone(), r.get::<_, Sq>(i).unwrap_or(Sq::Null))).collect()))).map_err(|e| format!("{sql}: {e}"))?;
	rows.collect::<Result<Vec<_>, _>>().map_err(|e| e.to_string())
}

fn open(file: &Path) -> Result<rusqlite::Connection, String> {
	rusqlite::Connection::open_with_flags(file, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY | rusqlite::OpenFlags::SQLITE_OPEN_NO_MUTEX).map_err(|e| format!("{}: {e}", file.display()))
}

fn db_meta(db: &rusqlite::Connection) -> Result<V, String> {
	let m: FxHashMap<String, Option<String>> = all(db, "select key, value from _meta", &[])?.into_iter().map(|r| (r.s("key").unwrap_or_default(), r.s("value"))).collect();
	let g = |k: &str| m.get(k).cloned().flatten().map(V::from).unwrap_or(V::Undef);
	let o = Obj::new();
	o.set("release", g("release"));
	o.set("releaseCommit", g("release_commit"));
	o.set("branchHead", g("branch_head"));
	o.set("sakhwoow", m.get("sakhwoow_commit").cloned().flatten().map(V::from).unwrap_or(V::Null));
	o.set("built", g("built"));
	o.set("source", REPO_URL);
	Ok(V::Obj(o))
}

fn tenth(v: f64) -> f64 {
	math_round(v * 10.0) / 10.0
}

#[derive(Clone)]
struct Prov {
	prov: &'static str,
	k: Option<f64>,
	n: Option<f64>,
}

fn row_prov(comment: Option<String>) -> Prov {
	let c = comment.unwrap_or_default().to_lowercase();
	let p = |prov| Prov { prov, k: None, n: None };
	if c.starts_with("vmangos") {
		return p("vmangos");
	}
	if c.starts_with("quest item of the creature query") {
		return p("placeholder");
	}
	// ForeverTDB's own comment prefix
	if c.starts_with(concat!("wow", "head")) {
		return p("page");
	}
	// /sniff:\s*(\d+)\s+of\s+(\d+)/
	if let Some(i) = c.find("sniff:") {
		let rest = c[i + 6..].trim_start();
		let d1: String = rest.chars().take_while(char::is_ascii_digit).collect();
		if !d1.is_empty() {
			let r2 = &rest[d1.len()..];
			let r2t = r2.trim_start();
			if r2t.len() < r2.len() {
				if let Some(r3) = r2t.strip_prefix("of") {
					let r3t = r3.trim_start();
					let d2: String = r3t.chars().take_while(char::is_ascii_digit).collect();
					if r3t.len() < r3.len() && !d2.is_empty() {
						return Prov { prov: "sniff", k: Some(d1.parse().unwrap()), n: Some(d2.parse().unwrap()) };
					}
				}
			}
		}
	}
	if c.contains("sniff") {
		return p("sniff");
	}
	p("custom")
}

#[derive(Clone)]
struct LootRow {
	item: i64,
	refr: bool,
	chance: f64,
	quest: bool,
	group: i64,
	min: f64,
	max: f64,
	prov: Prov,
}

fn loot_rows(db: &rusqlite::Connection, table: &str) -> Result<IndexMap<i64, Vec<LootRow>>, String> {
	let mut out: IndexMap<i64, Vec<LootRow>> = IndexMap::new();
	for r in all(db, &format!("select Entry, ItemType, Item, Chance, QuestRequired, GroupId, MinCount, MaxCount, Comment from {table}"), &[])? {
		let or1 = |k: &str| if r.truthy(k) { r.n(k) } else { 1.0 };
		out.entry(r.i("Entry")).or_default().push(LootRow {
			item: r.i("Item"),
			refr: r.n("ItemType") == 1.0,
			chance: r.n0("Chance"),
			quest: r.truthy("QuestRequired"),
			group: r.i("GroupId"),
			min: or1("MinCount"),
			max: or1("MaxCount"),
			prov: row_prov(r.s("Comment")),
		});
	}
	Ok(out)
}

#[derive(Clone)]
struct Got {
	p: f64,
	quest: bool,
	provs: IndexSet<&'static str>,
	k: Option<f64>,
	n: Option<f64>,
	mean: f64,
}

struct Resolver<'a> {
	rows: IndexMap<i64, Vec<LootRow>>,
	refs: &'a IndexMap<i64, Vec<LootRow>>,
	want: &'a FxHashSet<i64>,
	cache: FxHashMap<i64, IndexMap<i64, Got>>,
}

impl Resolver<'_> {
	fn flat(&self, list: &[LootRow], depth: u32) -> IndexMap<i64, Got> {
		let mut out: IndexMap<i64, Got> = IndexMap::new();
		let want = self.want;
		let add = |out: &mut IndexMap<i64, Got>, item: i64, p: f64, quest: bool, prov: &Prov, mean: f64| {
			if !(p > 0.0) || !want.contains(&item) {
				return;
			}
			match out.get_mut(&item) {
				None => {
					let mut provs = IndexSet::new();
					provs.insert(prov.prov);
					out.insert(item, Got { p, quest, provs, k: prov.k, n: prov.n, mean });
				}
				Some(cur) => {
					cur.p = 1.0 - (1.0 - cur.p) * (1.0 - p);
					cur.quest = cur.quest && quest;
					cur.provs.insert(prov.prov);
					cur.k = None;
					cur.n = None;
				}
			}
		};
		let mut groups: IndexMap<i64, Vec<&LootRow>> = IndexMap::new();
		for r in list {
			if r.refr {
				if depth >= 1 {
					continue;
				}
				let pr = r.chance.abs().min(100.0) / 100.0;
				let n = r.max.max(1.0);
				let sub = self.flat(self.refs.get(&r.item).map(Vec::as_slice).unwrap_or(&[]), depth + 1);
				for (it, v) in sub {
					let prov = Prov { prov: v.provs[0], k: None, n: None };
					add(&mut out, it, 1.0 - (1.0 - pr * v.p).powf(n), v.quest || r.quest, &prov, v.mean);
				}
			} else if r.group > 0 {
				groups.entry(r.group).or_default().push(r);
			} else {
				add(&mut out, r.item, r.chance.abs().min(100.0) / 100.0, r.quest, &r.prov, (r.min + r.max) / 2.0);
			}
		}
		for g in groups.values() {
			let explicit: f64 = g.iter().map(|r| if r.chance != 0.0 { r.chance.abs() } else { 0.0 }).sum();
			let zero = g.iter().filter(|r| r.chance == 0.0).count();
			let share = if zero > 0 { (100.0 - explicit).max(0.0) / zero as f64 } else { 0.0 };
			for r in g {
				add(&mut out, r.item, (if r.chance != 0.0 { r.chance.abs() } else { share }) / 100.0, r.quest, &r.prov, (r.min + r.max) / 2.0);
			}
		}
		out
	}

	fn get(&mut self, entry: i64) -> IndexMap<i64, Got> {
		if !self.cache.contains_key(&entry) {
			let list = self.rows.get(&entry).cloned().unwrap_or_default();
			let r = self.flat(&list, 0);
			self.cache.insert(entry, r);
		}
		self.cache[&entry].clone()
	}
}

fn sort_num_keys(o: &Obj) -> Obj {
	let out = Obj::new();
	let mut ks: Vec<(f64, forge_guide::js::Str)> = o.keys().into_iter().map(|k| (forge_guide::js::str_to_num(&k), k)).collect();
	ks.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
	for (_, k) in ks {
		out.set_str(k.clone(), o.get(&k));
	}
	out
}

/// The database -> the extract.
pub fn extract(file: &Path) -> Result<V, String> {
	let db = open(file)?;
	let meta = db_meta(&db)?;
	let sn: &dyn rusqlite::ToSql = &SNIFFED;

	// ---- quests ----
	let mut set: FxHashSet<i64> = all(&db, "select ID from quest_classic_level", &[])?.iter().map(|r| r.i("ID")).collect();
	for r in all(&db, "select ID from quest_template where VerifiedBuild >= ?", &[sn])? {
		set.insert(r.i("ID"));
	}
	let levels: FxHashMap<i64, Row> = all(&db, "select ID, QuestLevel, MinLevel, MaxLevel from quest_classic_level", &[])?.into_iter().map(|r| (r.i("ID"), r)).collect();
	let addon: FxHashMap<i64, Row> = all(&db, "select ID, NextQuestID, PrevQuestID, MaxLevel from quest_template_addon", &[])?.into_iter().map(|r| (r.i("ID"), r)).collect();
	let mut objs: IndexMap<i64, Vec<V>> = IndexMap::new();
	for r in all(&db, "select QuestID, Type, ObjectID, Amount from quest_objectives order by QuestID, \"Order\", StorageIndex", &[])? {
		if !set.contains(&r.i("QuestID")) {
			continue;
		}
		objs.entry(r.i("QuestID")).or_default().push(arr(vec![r.js("Type"), r.js("ObjectID"), r.js("Amount")]));
	}
	let quests = Obj::new();
	for r in all(&db, "select ID, VerifiedBuild, TimeAllowed, RewardNextQuest, QuestInfoID, RewardSpell, RewardDisplaySpell1, RewardXPDifficulty, RewardXPMultiplier, cast(AllowableRaces as text) races from quest_template", &[])? {
		let id = r.i("ID");
		if !set.contains(&id) {
			continue;
		}
		let lv = levels.get(&id);
		let ad = addon.get(&id);
		let q = Obj::new();
		q.set("sniffed", r.n0("VerifiedBuild") >= SNIFFED as f64);
		q.set("obj", arr(objs.get(&id).cloned().unwrap_or_default()));
		if r.n("TimeAllowed") > 0.0 {
			q.set("time", r.js("TimeAllowed"));
		}
		let next = if r.truthy("RewardNextQuest") { r.js("RewardNextQuest") } else if ad.is_some_and(|a| a.truthy("NextQuestID")) { ad.unwrap().js("NextQuestID") } else { V::Num(0.0) };
		if next.num() > 0.0 {
			q.set("next", next);
		}
		if let Some(a) = ad.filter(|a| a.truthy("PrevQuestID")) {
			q.set("prev", a.js("PrevQuestID"));
		}
		if ad.is_none() {
			q.set("noAddon", true);
		}
		if r.truthy("QuestInfoID") {
			q.set("info", r.js("QuestInfoID"));
		}
		let spell = if r.truthy("RewardSpell") { r.js("RewardSpell") } else if r.truthy("RewardDisplaySpell1") { r.js("RewardDisplaySpell1") } else { V::Num(0.0) };
		if spell.num() > 0.0 {
			q.set("rewardSpell", spell);
		}
		if r.n("RewardXPDifficulty") > 0.0 {
			q.set("xpDifficulty", r.js("RewardXPDifficulty"));
			let m = r.v("RewardXPMultiplier");
			if !matches!(m, Sq::Null) && r.n("RewardXPMultiplier") != 1.0 {
				q.set("xpMultiplier", r.js("RewardXPMultiplier"));
			}
		}
		if let Some(lv) = lv {
			q.set("level", lv.js("QuestLevel"));
			q.set("minLevel", lv.js("MinLevel"));
			let max = if lv.truthy("MaxLevel") { lv.js("MaxLevel") } else if ad.is_some_and(|a| a.truthy("MaxLevel")) { ad.unwrap().js("MaxLevel") } else { V::Num(0.0) };
			q.set("maxLevel", max);
		}
		let races = r.s("races").unwrap_or_default();
		let n: i128 = races.trim().parse().unwrap_or(0);
		q.set("races", ((n as i64) as u64).to_string());
		quests.set(&id.to_string(), q);
	}

	// ---- sniffed spawns ----
	let spawns = Obj::new();
	let mut spawned_ids: [IndexSet<i64>; 2] = Default::default();
	for (ki, (kind, table)) in [("npc", "creature"), ("object", "gameobject")].iter().enumerate() {
		let t = Obj::new();
		for r in all(&db, &format!("select id, map, position_x x, position_y y, position_z z, spawntimesecs t from {table} where VerifiedBuild >= ? and map in ({SPAWN_MAPS}) and coalesce(PhaseId, 0) = 0 and coalesce(PhaseGroup, 0) = 0 order by guid"), &[sn])? {
			let id = r.i("id");
			let k = id.to_string();
			if !t.has(&k) {
				t.set(&k, V::arr());
				spawned_ids[ki].insert(id);
			}
			t.get(&k).push(nums(&[r.n("map"), tenth(r.n("x")), tenth(r.n("y")), tenth(r.n("z")), r.n0("t")]));
		}
		spawns.set(kind, sort_num_keys(&t));
	}

	// ---- names ----
	let mut objective_npcs: FxHashSet<i64> = FxHashSet::default();
	for list in objs.values() {
		for o in list {
			let t = o.num_at(0);
			if t == 0.0 || t == 3.0 {
				objective_npcs.insert(o.num_at(1) as i64);
			}
		}
	}
	let c_level: FxHashMap<i64, Row> = all(&db, "select entry, level_min, level_max from creature_classic_level", &[])?.into_iter().map(|r| (r.i("entry"), r)).collect();
	let names = Obj::new();
	let nn = Obj::new();
	let want_npc: FxHashSet<i64> = spawned_ids[0].iter().copied().chain(objective_npcs.iter().copied()).collect();
	for r in all(&db, "select entry, name, trainer_class from creature_template", &[])? {
		let e = r.i("entry");
		if !want_npc.contains(&e) {
			continue;
		}
		let v = match c_level.get(&e) {
			Some(l) => arr(vec![r.js("name"), l.js("level_min"), l.js("level_max")]),
			None => arr(vec![r.js("name")]),
		};
		nn.set(&e.to_string(), v);
	}
	names.set("npc", sort_num_keys(&nn));
	let no = Obj::new();
	for r in all(&db, "select entry, name, type from gameobject_template", &[])? {
		let e = r.i("entry");
		if spawned_ids[1].contains(&e) {
			no.set(&e.to_string(), arr(vec![r.js("name"), r.js("type")]));
		}
	}
	names.set("object", sort_num_keys(&no));

	// ---- loot of the objective items ----
	let mut want: FxHashSet<i64> = FxHashSet::default();
	for list in objs.values() {
		for o in list {
			if o.num_at(0) == 1.0 {
				want.insert(o.num_at(1) as i64);
			}
		}
	}
	let refs = loot_rows(&db, "reference_loot_template")?;
	let spawned: [FxHashSet<i64>; 2] =
		[all(&db, "select distinct id from creature", &[])?.iter().map(|r| r.i("id")).collect(), all(&db, "select distinct id from gameobject", &[])?.iter().map(|r| r.i("id")).collect()];
	let sniffed_tpl: [FxHashSet<i64>; 2] = [
		all(&db, "select entry from creature_template where VerifiedBuild >= ?", &[sn])?.iter().map(|r| r.i("entry")).collect(),
		all(&db, "select entry from gameobject_template where VerifiedBuild >= ?", &[sn])?.iter().map(|r| r.i("entry")).collect(),
	];
	let loot_t: [Obj; 2] = [Obj::new(), Obj::new()];
	let record = |k: usize, ent: i64, got: IndexMap<i64, Got>| {
		for (item, v) in got {
			let flags = (spawned[k].contains(&ent) as i32) | ((sniffed_tpl[k].contains(&ent) as i32) << 1) | ((v.quest as i32) << 2);
			let ik = item.to_string();
			if !loot_t[k].has(&ik) {
				loot_t[k].set(&ik, Obj::new());
			}
			let mut provs: Vec<&str> = v.provs.iter().copied().collect();
			provs.sort();
			let has_n = v.n.is_some_and(|n| n != 0.0);
			loot_t[k].get(&ik).set(
				&ent.to_string(),
				arr(vec![
					V::Num(math_round(v.p * 1e5) / 1e3),
					V::str(&provs.join("+")),
					V::Num(flags as f64),
					if has_n { v.k.map(V::Num).unwrap_or(V::Null) } else { V::Null },
					if has_n { V::Num(v.n.unwrap()) } else { V::Null },
					V::Num(if v.mean != 0.0 && !v.mean.is_nan() { v.mean } else { 1.0 }),
				]),
			);
		}
	};
	let mut cr = Resolver { rows: loot_rows(&db, "creature_loot_template")?, refs: &refs, want: &want, cache: FxHashMap::default() };
	for r in all(&db, "select Entry, LootID from creature_template_difficulty where DifficultyID = 0 and LootID > 0", &[])? {
		let got = cr.get(r.i("LootID"));
		record(0, r.i("Entry"), got);
	}
	let mut gr = Resolver { rows: loot_rows(&db, "gameobject_loot_template")?, refs: &refs, want: &want, cache: FxHashMap::default() };
	for r in all(&db, "select entry, Data1 from gameobject_template where type = 3 and Data1 > 0", &[])? {
		let got = gr.get(r.i("Data1"));
		record(1, r.i("entry"), got);
	}
	let loot = Obj::new();
	loot.set("npc", sort_num_keys(&loot_t[0]));
	loot.set("object", sort_num_keys(&loot_t[1]));
	for t in [loot.get("npc"), loot.get("object")] {
		for (k, v) in t.entries() {
			t.set(&k, sort_num_keys(v.as_obj().unwrap()));
		}
	}

	// ---- sniffed vendors ----
	let vendors = Obj::new();
	for r in all(&db, "select entry, item from npc_vendor where VerifiedBuild >= ? and type = 1 order by entry, slot", &[sn])? {
		let k = r.i("entry").to_string();
		if !vendors.has(&k) {
			vendors.set(&k, V::arr());
		}
		vendors.get(&k).push(r.js("item"));
	}

	// ---- class trainers and training ----
	let tclass: FxHashMap<i64, Option<&str>> =
		all(&db, "select entry, trainer_class from creature_template where trainer_class > 0", &[])?.iter().map(|r| (r.i("entry"), class_of_id(r.i("trainer_class")))).collect();
	let links = all(&db, "select CreatureID, TrainerID from creature_trainer", &[])?;
	let mut linked: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for l in &links {
		linked.entry(l.i("TrainerID")).or_default().push(l.i("CreatureID"));
	}
	struct List {
		cls: String,
		vb: f64,
		rows: Vec<Row>,
	}
	let mut lists: IndexMap<i64, List> = IndexMap::new();
	for t in all(&db, "select Id, Greeting, VerifiedBuild from trainer where Type = 0", &[])? {
		let g = t.s("Greeting").unwrap_or_default();
		let mut cls: Option<String> = g
			.strip_prefix("Hello, ")
			.and_then(|r| {
				let w: String = r.chars().take_while(|c| c.is_ascii_alphanumeric() || *c == '_').collect();
				(!w.is_empty() && r[w.len()..].starts_with('!')).then_some(w)
			})
			.map(|w| w.to_uppercase())
			.filter(|w| (1..=11).filter_map(class_of_id).any(|c| c == w));
		if cls.is_none() {
			let cs: IndexSet<Option<&str>> = linked.get(&t.i("Id")).map(|l| l.iter().map(|c| tclass.get(c).copied().flatten()).collect()).unwrap_or_default();
			if cs.len() == 1 {
				if let Some(Some(c)) = cs.first() {
					cls = Some(c.to_string());
				}
			}
		}
		let Some(cls) = cls else { continue };
		let id: &dyn rusqlite::ToSql = &t.i("Id");
		let rows = all(&db, "select SpellId, MoneyCost, ReqLevel, VerifiedBuild from trainer_spell where TrainerId = ?", &[id])?;
		if rows.len() < 2 {
			continue;
		}
		lists.insert(t.i("Id"), List { cls, vb: t.n0("VerifiedBuild"), rows });
	}
	let trainers = Obj::new();
	let mut used: IndexMap<String, IndexSet<i64>> = IndexMap::new();
	for l in &links {
		let Some(list) = lists.get(&l.i("TrainerID")) else { continue };
		if !spawned[0].contains(&l.i("CreatureID")) {
			continue;
		}
		let k = l.i("CreatureID").to_string();
		if !trainers.has(&k) {
			trainers.set(&k, V::arr());
		}
		let cl = trainers.get(&k);
		if !cl.items().iter().any(|x| x.as_str() == Some(&list.cls)) {
			cl.push(list.cls.as_str());
		}
		used.entry(list.cls.clone()).or_default().insert(l.i("TrainerID"));
	}
	let training = Obj::new();
	let training_spells = Obj::new();
	let dropped = Obj::new();
	for (cls, ids) in &used {
		let mut spells: IndexMap<i64, (f64, f64)> = IndexMap::new();
		let mut zero: IndexMap<i64, f64> = IndexMap::new();
		let mut order: Vec<i64> = ids.iter().copied().collect();
		order.sort_by(|a, b| lists[b].vb.partial_cmp(&lists[a].vb).unwrap().then(a.cmp(b)));
		for id in order {
			let list = &lists[&id];
			if list.vb < SNIFFED as f64 {
				continue;
			}
			for r in &list.rows {
				let sp = r.i("SpellId");
				if r.n0("ReqLevel") > 0.0 {
					spells.entry(sp).or_insert((r.n0("MoneyCost"), r.n0("ReqLevel")));
				} else {
					zero.entry(sp).or_insert(r.n0("MoneyCost"));
				}
			}
		}
		dropped.set(cls, zero.keys().filter(|s| !spells.contains_key(*s)).count());
		let per = Obj::new();
		let list = Obj::new();
		for (&id, &(cost, lvl)) in &spells {
			let k = num_str(lvl);
			per.set(&k, per.get(&k).as_num().unwrap_or(0.0) + cost);
			if !list.has(&k) {
				list.set(&k, V::arr());
			}
			list.get(&k).push(nums(&[id as f64, cost]));
		}
		if !per.is_empty() {
			training.set(cls, sort_num_keys(&per));
			let ls = sort_num_keys(&list);
			for (k, v) in ls.entries() {
				let mut items = v.items();
				items.sort_by(|x, y| x.num_at(0).partial_cmp(&y.num_at(0)).unwrap());
				ls.set(&k, arr(items));
			}
			training_spells.set(cls, ls);
		}
	}
	for (k, v) in trainers.entries() {
		let mut items = v.items();
		items.sort_by(|a, b| forge_guide::js::cmp_utf16(a.as_str().unwrap_or(""), b.as_str().unwrap_or("")));
		trainers.set(&k, arr(items));
	}

	// ---- riding trainers ----
	let mut riding: IndexMap<i64, [f64; 4]> = IndexMap::new();
	for r in all(&db, "select ct.CreatureID c, ts.SpellId s, ts.MoneyCost m, ts.ReqLevel l, ts.VerifiedBuild vb from creature_trainer ct join trainer_spell ts on ts.TrainerId = ct.TrainerID", &[])? {
		if !APPRENTICE_RIDING.contains(&r.i("s")) || !spawned[0].contains(&r.i("c")) {
			continue;
		}
		let row = [r.n0("m"), r.n0("l"), if r.n0("vb") >= SNIFFED as f64 { 1.0 } else { 0.0 }, 0.0];
		let c = r.i("c");
		if riding.get(&c).is_none_or(|cur| row[2] > cur[2]) {
			riding.insert(c, row);
		}
	}
	for r in all(&db, "select g.CreatureID c, c.ConditionValue1 v from creature_template_gossip g join conditions c on c.SourceTypeOrReferenceId = 15 and c.SourceGroup = g.MenuID where c.ElseGroup = 0 and c.ConditionTypeOrReference = 16 and c.NegativeCondition = 0", &[])? {
		if let Some(row) = riding.get_mut(&r.i("c")) {
			row[3] = (crate::jsv::to_int32(row[3]) | crate::jsv::to_int32(r.n("v"))) as f64;
		}
	}
	let ro = Obj::new();
	for (c, row) in &riding {
		ro.set(&c.to_string(), nums(row));
	}

	let out = Obj::new();
	out.set("schema", SCHEMA);
	out.set("meta", meta);
	out.set("quests", sort_num_keys(&quests));
	out.set("spawns", spawns);
	out.set("names", names);
	out.set("loot", loot);
	out.set("vendors", sort_num_keys(&vendors));
	out.set("trainers", sort_num_keys(&trainers));
	out.set("training", training);
	out.set("trainingSpells", training_spells);
	out.set("trainingDropped", dropped);
	out.set("riding", sort_num_keys(&ro));
	Ok(V::Obj(out))
}

/// The extract (re-extracted into <sources>/forever-tdb/extract.json when the database's _meta or
/// the schema changed), or None without a database or an extract.
pub fn load(sources: &Path, db_file: &Path, log: &dyn Fn(&str)) -> Result<Option<V>, String> {
	let file = sources.join("forever-tdb").join("extract.json");
	let cached = if file.exists() { Some(parse_json(&std::fs::read_to_string(&file).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", file.display()))?) } else { None };
	if !db_file.exists() {
		if cached.is_none() {
			log(&format!("  Forever TDB: no {} and no extract: the world builds without it", db_file.display()));
		}
		return Ok(cached);
	}
	let meta = db_meta(&open(db_file)?)?;
	if let Some(c) = &cached {
		let m = c.get("meta");
		if c.get("schema").as_num() == Some(SCHEMA) && m.is_obj() && m.get("branchHead").strict_eq(&meta.get("branchHead")) && m.get("built").strict_eq(&meta.get("built")) {
			return Ok(cached);
		}
	}
	log(&format!("  Forever TDB: extracting {} + {} from {}", meta.get("release").to_js_string(), meta.get("branchHead").to_js_string().chars().take(8).collect::<String>(), db_file.display()));
	let data = extract(db_file)?;
	std::fs::create_dir_all(file.parent().unwrap()).map_err(|e| e.to_string())?;
	let tmp = file.with_extension("json.tmp");
	std::fs::write(&tmp, format!("{}\n", stringify(&data, None))).map_err(|e| e.to_string())?;
	std::fs::rename(&tmp, &file).map_err(|e| e.to_string())?;
	Ok(Some(data))
}

pub fn source_v() -> Obj {
	let o = Obj::new();
	o.set("name", "Forever TrinityCore world database (sniffed spawns, quest objectives, timers, loot, class trainers)");
	o.set("url", REPO_URL);
	o.set("license", "GPL-2.0; used as facts: objective counts, quest time limits and next quests, sniffed spawn positions, sniffed drop rates, class trainer lists and costs");
	o.set("copyright", "TrinityCore (https://www.trinitycore.org) and the advocaite/TrinityCore `forever` branch");
	o
}
