//! The installed Forever client as two knowledge-base sources (kb.rs TIERS):
//! - `client.cache`: the client's WDB caches, the server's answers about the quests, creatures and
//!   game objects the player has met (questcache.wdb, creaturecache.wdb, gameobjectcache.wdb). A
//!   quest record is the same data as a players' cache record of the EG Link output, so it is read
//!   into [`EgQuest`] (XP = QuestXP[level][difficulty] x multiplier, the game's rounding);
//! - `client`: the client's tables with the server's hotfix rows (DBCache.bin) applied: quest map
//!   areas (QuestPOIBlob/QuestPOIPoint), area triggers, QuestV2 (a quest the client keeps a
//!   completion bit for: proof that it exists, never of a removal), item names, durations, start
//!   quests and the quest-item class (ItemSparse, Item), placed game objects (GameObjects).
//!
//! Only derived values leave this module (ids, levels, counts, positions); no row is copied. The
//! tables come from the install (forge-gamedata) or a folder of table CSVs (`<Table>.csv`, as
//! `forge gamedata` writes them; read as they are, hotfixes not applied).

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_gamedata::hotfix::{self, DbCache};
use forge_gamedata::wdb::{self, Kind, WdbFile};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{col_num, col_str, Row, Rows};
use crate::players::{round_quest_xp, EgQuest, QuestXp};

const LOCALE: &str = "enUS";

/// Where the client is read from. Nothing set: no client.
#[derive(Clone, Debug, Default)]
pub struct Options {
	/// The World of Warcraft folder (its tables, and its product's `Cache` folder by default).
	pub wow: Option<PathBuf>,
	pub product: String,
	/// A WoWDBDefs checkout (types the install's tables and the hotfix rows).
	pub defs: PathBuf,
	/// The caches: a client `Cache` folder (`WDB/enUS/*.wdb`, `ADB/enUS/DBCache.bin`) or a folder
	/// holding the `.wdb` files and `DBCache.bin` themselves. None: the install's.
	pub cache: Option<PathBuf>,
	/// A folder of table CSVs read instead of the install's tables.
	pub tables: Option<PathBuf>,
}

/// A creaturecache record's facts.
#[derive(Clone, Debug, PartialEq)]
pub struct CacheNpc {
	pub name: String,
	pub subname: String,
	/// 0 normal, 1 elite, 2 rare elite, 3 boss, 4 rare.
	pub rank: i32,
}

/// The WDB caches (`client.cache`).
#[derive(Default)]
pub struct Cache {
	/// The build that wrote the caches.
	pub build: String,
	pub quests: IndexMap<i64, EgQuest>,
	pub titles: FxHashMap<i64, String>,
	pub npcs: IndexMap<i64, CacheNpc>,
	/// Game object id -> name.
	pub objects: IndexMap<i64, String>,
}

/// One quest map area: its uiMap and its outline in world coordinates (x north, y west).
#[derive(Clone, Debug, PartialEq)]
pub struct Area {
	pub ui_map: i64,
	pub pts: Vec<(f64, f64)>,
}

/// A quest's map areas by role.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Places {
	pub start: Vec<Area>,
	pub end: Vec<Area>,
	/// Objective index -> its areas.
	pub objectives: BTreeMap<i64, Vec<Area>>,
}

/// An area trigger: its continent, centre (world x, y) and size.
#[derive(Clone, Debug, PartialEq)]
pub struct Trigger {
	pub map: i64,
	pub x: f64,
	pub y: f64,
	pub radius: f64,
	/// A box trigger's (length, width).
	pub box_size: Option<(f64, f64)>,
}

/// An item's facts from ItemSparse and Item.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Item {
	pub name: String,
	/// Seconds in the bags (DurationInInventory, its sign dropped).
	pub duration: Option<f64>,
	/// Item.ClassID 12; None when Item has no row for it.
	pub quest_item: Option<bool>,
	/// The quest the item starts (ItemSparse.StartQuestID).
	pub start_quest: Option<i64>,
}

/// The tables with the hotfixes applied (`client`).
#[derive(Default)]
pub struct Tables {
	/// The tables' build (None: a CSV folder of unknown build).
	pub build: Option<String>,
	pub places: BTreeMap<i64, Places>,
	pub triggers: FxHashMap<i64, Trigger>,
	pub quests: FxHashSet<i64>,
	pub items: BTreeMap<i64, Item>,
	/// Game object id -> placements (continent, world x, world y).
	pub objects: BTreeMap<i64, Vec<(i64, f64, f64)>>,
	/// The client's QuestXP (None: the table is not there).
	pub quest_xp: Option<QuestXp>,
	/// Hotfix rows applied: (rows added or replaced, rows deleted).
	pub hotfixes: (usize, usize),
}

pub struct Client {
	pub cache: Option<Cache>,
	pub tables: Option<Tables>,
	pub warnings: Vec<String>,
}

/// The tables read: QuestXP for the cache's XP, the rest for the `client` facts.
const TABLES: [&str; 8] = ["QuestXP", "QuestPOIBlob", "QuestPOIPoint", "QuestV2", "AreaTrigger", "ItemSparse", "Item", "GameObjects"];

/// Reads the client (`fallback_xp`: QuestXP when the client's own is not there). None when the
/// options name no client.
pub fn load(o: &Options, fallback_xp: Option<&QuestXp>, log: &dyn Fn(&str)) -> Result<Option<Client>, String> {
	if o.wow.is_none() && o.cache.is_none() && o.tables.is_none() {
		return Ok(None);
	}
	let mut warnings = Vec::new();
	let cache_dir = match (&o.cache, &o.wow) {
		(Some(d), _) => Some(d.clone()),
		(None, Some(w)) => forge_gamedata::flavor_dir(w, &o.product).ok().map(|d| d.join("Cache")),
		_ => None,
	};
	let (wdb_dir, dbcache) = cache_dir.as_deref().map(cache_files).unwrap_or((None, None));
	let install = match (&o.tables, &o.wow) {
		(None, Some(w)) => match forge_gamedata::Client::open(w, &o.product, &o.defs) {
			Ok(c) => Some(c),
			Err(e) => {
				warnings.push(format!("client tables unreadable ({e})"));
				None
			}
		},
		_ => None,
	};
	let tables = if let Some(dir) = &o.tables {
		let mut got: FxHashMap<&str, Rows> = FxHashMap::default();
		for t in TABLES {
			match std::fs::read_to_string(dir.join(format!("{t}.csv"))) {
				Ok(text) => {
					got.insert(t, crate::tables::parse_csv(&text).map_err(|e| format!("{}: {e}", dir.join(format!("{t}.csv")).display()))?);
				}
				Err(_) => warnings.push(format!("client tables {}: no {t}.csv", dir.display())),
			}
		}
		log(&format!("reading client tables from {}", dir.display()));
		Some(derive_tables(&got, None, (0, 0)))
	} else if let Some(c) = &install {
		let mut got: FxHashMap<&str, Rows> = FxHashMap::default();
		for t in TABLES {
			match c.table(t, LOCALE) {
				Ok(tb) => {
					got.insert(t, crate::tables::table_rows(&tb));
				}
				Err(e) => warnings.push(format!("client {} {}: no {t} ({e})", o.product, c.storage.version)),
			}
		}
		let mut applied = (0, 0);
		if let Some(f) = &dbcache {
			match DbCache::read(f) {
				Ok(db) => applied = apply_hotfixes(c, &db, &mut got, &mut warnings),
				Err(e) => warnings.push(format!("client hotfixes unreadable ({e})")),
			}
		}
		log(&format!("reading {} {} client tables ({} hotfix rows applied, {} deleted)", o.product, c.storage.version, applied.0, applied.1));
		Some(derive_tables(&got, Some(c.storage.version.clone()), applied))
	} else {
		None
	};
	let cache = match wdb_dir {
		Some(dir) => {
			let xp = tables.as_ref().and_then(|t| t.quest_xp.as_ref()).or(fallback_xp);
			let prefix = install.as_ref().map(|c| {
				let [a, b, p, _] = c.build.0;
				format!("{a}.{b}.{p}.")
			});
			let c = read_cache(&dir, prefix.as_deref(), xp, &mut warnings)?;
			log(&format!("reading client caches {} (build {}): {} quests, {} creatures, {} objects", dir.display(), c.build, c.quests.len(), c.npcs.len(), c.objects.len()));
			Some(c)
		}
		None => {
			warnings.push(format!("client caches: no questcache.wdb under {}", cache_dir.as_deref().map(|d| d.display().to_string()).unwrap_or_else(|| "(no cache folder)".into())));
			None
		}
	};
	Ok(Some(Client { cache, tables, warnings }))
}

/// The WDB folder and DBCache.bin of a cache folder (a client `Cache` folder or the files' own).
fn cache_files(dir: &Path) -> (Option<PathBuf>, Option<PathBuf>) {
	let wdb = [dir.to_path_buf(), dir.join("WDB").join(LOCALE)].into_iter().find(|d| d.join(Kind::Quest.file_name()).is_file());
	let adb = [dir.join("DBCache.bin"), dir.join("ADB").join(LOCALE).join("DBCache.bin")].into_iter().find(|f| f.is_file());
	(wdb, adb)
}

/// The caches of a WDB folder (`build_prefix`: the install's `major.minor.patch.`, for the build
/// label; the files store only the build number).
pub fn read_cache(dir: &Path, build_prefix: Option<&str>, quest_xp: Option<&QuestXp>, warnings: &mut Vec<String>) -> Result<Cache, String> {
	let qf = WdbFile::read(&dir.join(Kind::Quest.file_name()))?;
	let mut c = Cache { build: format!("{}{}", build_prefix.unwrap_or(""), qf.build), ..Default::default() };
	let mut bad = 0;
	for (id, r) in qf.decode(Kind::Quest, wdb::decode_quest)? {
		match r {
			Ok(q) => {
				c.titles.insert(id as i64, q.log_title.clone());
				c.quests.insert(id as i64, cache_quest(&q, qf.build, quest_xp));
			}
			Err(_) => bad += 1,
		}
	}
	let read = |k: Kind| -> Option<WdbFile> { WdbFile::read(&dir.join(k.file_name())).ok() };
	if let Some(f) = read(Kind::Creature) {
		for (id, r) in f.decode(Kind::Creature, wdb::decode_creature)? {
			match r {
				Ok(n) => {
					c.npcs.insert(id as i64, CacheNpc { name: n.name[0].clone(), subname: n.title.clone(), rank: n.classification });
				}
				Err(_) => bad += 1,
			}
		}
	}
	if let Some(f) = read(Kind::GameObject) {
		for (id, r) in f.decode(Kind::GameObject, wdb::decode_gameobject)? {
			match r {
				Ok(g) => {
					c.objects.insert(id as i64, g.name[0].clone());
				}
				Err(_) => bad += 1,
			}
		}
	}
	if bad > 0 {
		warnings.push(format!("client caches {}: {bad} records did not decode", dir.display()));
	}
	c.quests.sort_keys();
	c.npcs.sort_keys();
	c.objects.sort_keys();
	Ok(c)
}

/// A float as its shortest f32 decimal (2.375, 0.1), not the f64 widening.
fn f32_value(v: f32) -> f64 {
	v.to_string().parse().unwrap_or(f64::from(v))
}

/// A questcache record in the EG Link output's terms. Objective kinds: 0 kill, 1 item, 2 object,
/// 3 talk, 10 an area trigger (an event with the trigger's id), others (criteria trees) an event
/// without an id.
pub fn cache_quest(q: &wdb::Quest, build: u32, quest_xp: Option<&QuestXp>) -> EgQuest {
	let pos = |n: i32| (n > 0).then_some(f64::from(n));
	let level = pos(q.quest_level);
	let diff = q.reward_xp_difficulty;
	let mult = f32_value(q.reward_xp_multiplier);
	let base = level.and_then(|l| quest_xp.and_then(|t| t.get(l as usize).copied().flatten())).and_then(|row| usize::try_from(diff).ok().and_then(|d| row.get(d).copied()));
	EgQuest {
		build: Some(f64::from(build)),
		level,
		min_level: pos(q.min_level),
		xp_difficulty: Some(f64::from(diff)),
		xp_multiplier: Some(mult),
		xp: base.map(|b| round_quest_xp(b * mult)),
		xp_observed: None,
		next: pos(q.reward_next_quest),
		start_item: pos(q.start_item),
		races: Some((q.allowable_races as u64).to_string()),
		objectives: q
			.objectives
			.iter()
			.map(|o| {
				let (kind, id) = match o.kind {
					0 => ("kill", pos(o.object_id)),
					1 => ("item", pos(o.object_id)),
					2 => ("object", pos(o.object_id)),
					3 => ("talk", pos(o.object_id)),
					10 => ("event", pos(o.object_id)),
					_ => ("event", None),
				};
				(kind.to_string(), id, pos(o.amount))
			})
			.collect(),
		start: Vec::new(),
		end: Vec::new(),
	}
}

fn int(r: &Row, c: &str) -> Option<i64> {
	let n = col_num(r, c);
	(n.is_finite() && n.fract() == 0.0).then_some(n as i64)
}

/// Applies DBCache.bin to the tables read: a valid row replaces or adds the record, a deleted
/// one removes it (a removed hotfix leaves the shipped row). -> (rows set, rows deleted).
fn apply_hotfixes(c: &forge_gamedata::Client, db: &DbCache, got: &mut FxHashMap<&str, Rows>, warnings: &mut Vec<String>) -> (usize, usize) {
	let names = match c.table_hashes() {
		Ok(n) => n,
		Err(e) => {
			warnings.push(format!("client hotfixes not applied ({e})"));
			return (0, 0);
		}
	};
	let [a, b, p, _] = c.build.0;
	let build = forge_gamedata::Build([a, b, p, db.build]);
	let mut done = (0, 0);
	for (t, rows) in got.iter_mut() {
		let Some((&hash, _)) = names.iter().find(|(_, n)| n.as_str() == *t) else { continue };
		if !db.entries.iter().any(|e| e.table_hash == hash) {
			continue;
		}
		let def = match c.definition(t, build) {
			Ok(d) => d,
			Err(e) => {
				warnings.push(format!("client hotfixes for {t} not applied ({e})"));
				continue;
			}
		};
		let hot = hotfix::rows(db, hash, &def, false);
		let failed: FxHashSet<u32> = hot.failures.iter().map(|(id, _)| *id).collect();
		let n = overlay(rows, crate::tables::table_rows(&hot.table), &failed);
		done.0 += n.0;
		done.1 += n.1;
	}
	done
}

/// Overlays hotfix rows (RecordID, Status, PushID, columns) on a table's rows by ID.
fn overlay(rows: &mut Rows, hot: Rows, failed: &FxHashSet<u32>) -> (usize, usize) {
	let mut at: FxHashMap<String, usize> = rows.iter().enumerate().map(|(i, r)| (col_str(r, "ID").to_string(), i)).collect();
	let mut deleted: FxHashSet<usize> = FxHashSet::default();
	let mut done = (0, 0);
	for mut h in hot {
		let id = h.remove("RecordID").unwrap_or_default();
		let status = h.remove("Status").and_then(|s| s.parse::<u8>().ok()).unwrap_or(0);
		h.remove("PushID");
		match status {
			hotfix::status::VALID if !id.parse::<u32>().is_ok_and(|i| failed.contains(&i)) => {
				h.insert("ID".into(), id.clone());
				match at.get(&id) {
					Some(&i) => {
						rows[i] = h;
						deleted.remove(&i);
					}
					None => {
						at.insert(id, rows.len());
						rows.push(h);
					}
				}
				done.0 += 1;
			}
			hotfix::status::DELETED => {
				if let Some(&i) = at.get(&id) {
					if deleted.insert(i) {
						done.1 += 1;
					}
				}
			}
			_ => {}
		}
	}
	if !deleted.is_empty() {
		let mut i = 0;
		rows.retain(|_| {
			let keep = !deleted.contains(&i);
			i += 1;
			keep
		});
	}
	done
}

/// The `client` facts of the tables (by table name; missing tables give no facts).
pub fn derive_tables(got: &FxHashMap<&str, Rows>, build: Option<String>, hotfixes: (usize, usize)) -> Tables {
	let empty = Rows::new();
	let t = |n: &str| got.get(n).unwrap_or(&empty);
	let mut out = Tables { build, hotfixes, quest_xp: got.get("QuestXP").and_then(|r| crate::players::quest_xp_of(r).ok()), ..Default::default() };

	// Quest map areas: ObjectiveIndex -1 the turn-in, 32 the pick-up, else the objective's index.
	let mut pts: FxHashMap<i64, Vec<(i64, f64, f64)>> = FxHashMap::default();
	for r in t("QuestPOIPoint") {
		let (Some(id), Some(blob)) = (int(r, "ID"), int(r, "QuestPOIBlobID")) else { continue };
		pts.entry(blob).or_default().push((id, col_num(r, "X"), col_num(r, "Y")));
	}
	let mut blobs: Vec<(i64, &Row)> = t("QuestPOIBlob").iter().filter_map(|r| int(r, "ID").map(|i| (i, r))).collect();
	blobs.sort_by_key(|(i, _)| *i);
	for (id, r) in blobs {
		let (Some(q), Some(oi), Some(ui_map)) = (int(r, "QuestID"), int(r, "ObjectiveIndex"), int(r, "UiMapID")) else { continue };
		let mut p = pts.remove(&id).unwrap_or_default();
		if p.is_empty() {
			continue;
		}
		p.sort_by_key(|x| x.0);
		let area = Area { ui_map, pts: p.into_iter().map(|(_, x, y)| (x, y)).collect() };
		let e = out.places.entry(q).or_default();
		match oi {
			-1 => e.end.push(area),
			32 => e.start.push(area),
			n => e.objectives.entry(n).or_default().push(area),
		}
	}

	for r in t("AreaTrigger") {
		let (Some(id), Some(map)) = (int(r, "ID"), int(r, "ContinentID")) else { continue };
		let (len, wid) = (col_num(r, "Box_length"), col_num(r, "Box_width"));
		let boxed = int(r, "ShapeType") == Some(1) || len > 0.0;
		out.triggers.insert(id, Trigger { map, x: col_num(r, "Pos_0"), y: col_num(r, "Pos_1"), radius: col_num(r, "Radius").max(0.0), box_size: boxed.then_some((len.max(0.0), wid.max(0.0))) });
	}

	out.quests = t("QuestV2").iter().filter_map(|r| int(r, "ID")).collect();

	let class: FxHashMap<i64, i64> = t("Item").iter().filter_map(|r| Some((int(r, "ID")?, int(r, "ClassID")?))).collect();
	for r in t("ItemSparse") {
		let Some(id) = int(r, "ID") else { continue };
		let d = int(r, "DurationInInventory").unwrap_or(0);
		out.items.insert(
			id,
			Item {
				name: col_str(r, "Display_lang").to_string(),
				duration: (d != 0).then_some(d.unsigned_abs() as f64),
				quest_item: class.get(&id).map(|&c| c == 12),
				start_quest: int(r, "StartQuestID").filter(|&q| q > 0),
			},
		);
	}

	for r in t("GameObjects") {
		let (Some(id), Some(map)) = (int(r, "ID"), int(r, "OwnerID")) else { continue };
		let (x, y) = (col_num(r, "Pos_0"), col_num(r, "Pos_1"));
		if (x == 0.0 && y == 0.0) || !x.is_finite() || !y.is_finite() {
			continue;
		}
		out.objects.entry(id).or_default().push((map, x, y));
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	fn row(kv: &[(&str, &str)]) -> Row {
		kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	#[test]
	fn overlay_sets_adds_and_deletes() {
		let mut rows = vec![row(&[("ID", "1"), ("A", "x")]), row(&[("ID", "2"), ("A", "y")]), row(&[("ID", "3"), ("A", "z")])];
		let hot = vec![
			row(&[("RecordID", "1"), ("Status", "1"), ("PushID", "9"), ("ID", "1"), ("A", "X")]),
			row(&[("RecordID", "4"), ("Status", "1"), ("PushID", "9"), ("ID", "4"), ("A", "new")]),
			row(&[("RecordID", "2"), ("Status", "2"), ("PushID", "9"), ("ID", ""), ("A", "")]),
			row(&[("RecordID", "3"), ("Status", "3"), ("PushID", "9"), ("ID", ""), ("A", "")]),
			row(&[("RecordID", "5"), ("Status", "1"), ("PushID", "9"), ("ID", ""), ("A", "")]),
		];
		let failed: FxHashSet<u32> = [5].into_iter().collect();
		assert_eq!(overlay(&mut rows, hot, &failed), (2, 1));
		let got: Vec<(&str, &str)> = rows.iter().map(|r| (col_str(r, "ID"), col_str(r, "A"))).collect();
		assert_eq!(got, vec![("1", "X"), ("3", "z"), ("4", "new")]);
	}
}
