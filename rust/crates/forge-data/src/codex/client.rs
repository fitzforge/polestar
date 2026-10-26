//! The Forever client's tables -> the Codex's facts: build.js `clientFacts`, journal.js
//! `instanceMapsOf`, instances.js `instanceFacts`, and the cached wago.tools tables they read
//! (tools/lib/professions/tables.js `loadTables`, tools/lib/data/wago.js `pickBuild`, offline).

use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;

use forge_guide::races::CLASSES;
use rustc_hash::{FxHashMap, FxHashSet};

use super::util::{int_s, norm_s, num0_s};
use crate::jsv::{to_int32, Row, Rows};
use crate::tables::{compare_versions, parse_csv};

/// build.js TABLES: what the Codex reads from the Forever client.
pub const TABLES: [&str; 16] = [
	"Item",
	"ItemSparse",
	"ItemEffect",
	"ItemXItemEffect",
	"SpellEffect",
	"SpellName",
	"SkillLine",
	"SkillLineAbility",
	"Map",
	"AreaTable",
	"DungeonEncounter",
	"LFGDungeons",
	"MapDifficulty",
	"ContentTuning",
	"Mount",
	"BattlePetSpecies",
];
pub const ERA_BUILD: &str = "1.15.9.70003";
pub const ERA_TABLES: [&str; 4] = ["Item", "ItemSparse", "ItemEffect", "Map"];

const SKILL_MOUNTS: f64 = 777.0;
const SKILL_COMPANIONS: f64 = 778.0;
const AURA_MOUNTED: f64 = 78.0;
const EFFECT_AURA: f64 = 6.0;
const EFFECT_CREATE_ITEM: f64 = 24.0;
const TRIGGER_LEARN: f64 = 6.0;
const TRIGGER_USE: f64 = 0.0;
const CLASS_MOUNT_FALLBACK: [(i64, &str); 2] = [(5784, "WARLOCK"), (23161, "WARLOCK")];

pub type Tables = FxHashMap<&'static str, Rows>;

fn is_build(b: &str) -> bool {
	let parts: Vec<&str> = b.split('.').collect();
	parts.len() >= 2 && parts.iter().all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_digit()))
}

/// pickBuild({ product: 'forever', offline: true, tables }): the newest cached `1.6x.` build
/// holding every table.
pub fn newest_forever_build(sources: &Path, tables: &[&str]) -> Result<String, String> {
	let root = sources.join("wago");
	let mut builds: Vec<String> = std::fs::read_dir(&root).map(|rd| rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).collect()).unwrap_or_default();
	builds.retain(|b| {
		let bs = b.as_bytes();
		is_build(b) && b.starts_with("1.6") && bs.get(3).is_some_and(u8::is_ascii_digit) && bs.get(4) == Some(&b'.') && tables.iter().all(|t| root.join(b).join(format!("{t}.csv")).exists())
	});
	builds.sort_by(|a, b| compare_versions(a, b));
	builds.pop().ok_or_else(|| format!("--offline: no cached wago.tools build under {} (wow_classic_beta)", root.display()))
}

/// loadTables({ build, offline: true, tables }): every table's cached CSV rows.
pub fn load_tables(sources: &Path, build: &str, tables: &[&'static str], cwd: &Path) -> Result<Tables, String> {
	let mut out = Tables::default();
	for &t in tables {
		let file = sources.join("wago").join(build).join(format!("{t}.csv"));
		let text = std::fs::read_to_string(&file).map_err(|_| format!("--offline: missing cached {}", crate::jsv::relative(cwd, &file)))?;
		out.insert(t, parse_csv(&text)?);
	}
	Ok(out)
}

fn rows<'a>(t: &'a Tables, name: &str) -> &'a [Row] {
	t.get(name).map(Vec::as_slice).unwrap_or(&[])
}

fn col<'a>(r: &'a Row, c: &str) -> Option<&'a String> {
	r.get(c)
}

fn int(r: &Row, c: &str) -> Option<f64> {
	int_s(r.get(c))
}

fn truthy_int(r: &Row, c: &str) -> Option<f64> {
	int(r, c).filter(|n| *n != 0.0)
}

fn key(n: Option<f64>) -> i64 {
	n.map(|x| x as i64).unwrap_or(i64::MIN)
}

#[derive(Clone, Debug, Default)]
pub struct ClientItem {
	pub name: Option<String>,
	pub quality: Option<f64>,
	pub req_level: Option<f64>,
	pub buy_price: Option<f64>,
	pub min_faction: Option<f64>,
	pub min_standing: Option<f64>,
	pub pvp_rank: Option<f64>,
	pub req_skill: Option<f64>,
	pub req_skill_rank: Option<f64>,
	pub class_id: Option<f64>,
	pub subclass_id: Option<f64>,
	pub inventory_type: Option<f64>,
	pub learn: Option<f64>,
	pub use_: Option<f64>,
	pub era: bool,
}

#[derive(Default)]
pub struct ClientFacts {
	pub build: String,
	pub era_build: Option<String>,
	pub items: BTreeMap<i64, ClientItem>,
	pub spell_names: FxHashMap<i64, String>,
	pub mount_aura: FxHashSet<i64>,
	pub teaches: FxHashMap<i64, i64>,
	pub mount_spells: FxHashSet<i64>,
	pub mount_hidden: FxHashSet<i64>,
	pub pet_spells: FxHashSet<i64>,
	pub skill_lines: BTreeMap<i64, Option<String>>,
	pub skill_ability: FxHashMap<i64, Option<f64>>,
	pub mount_skill: Vec<i64>,
	pub companion_skill: Vec<i64>,
	pub spell_class: FxHashMap<i64, &'static str>,
	pub creates: FxHashMap<i64, Vec<i64>>,
	pub instance_maps: Vec<InstanceMap>,
	pub instances: Option<InstanceFacts>,
}

/// build.js `clientFacts(tables, build)`.
pub fn client_facts(tables: &Tables, build: &str) -> ClientFacts {
	let mut items: BTreeMap<i64, ClientItem> = BTreeMap::new();
	for r in rows(tables, "ItemSparse") {
		let Some(id) = truthy_int(r, "ID") else { continue };
		let min_faction = int(r, "MinFactionID");
		let raw_rank = int(r, "RequiredPVPRank");
		let mf = min_faction.filter(|f| *f > 0.0);
		let req_skill = truthy_int(r, "RequiredSkill");
		items.insert(
			id as i64,
			ClientItem {
				name: col(r, "Display_lang").filter(|s| !s.is_empty()).cloned(),
				quality: int(r, "OverallQualityID"),
				req_level: truthy_int(r, "RequiredLevel"),
				buy_price: truthy_int(r, "BuyPrice"),
				min_faction: mf,
				min_standing: mf.map(|_| int(r, "MinReputation").filter(|n| *n != 0.0).unwrap_or(0.0) + 1.0),
				pvp_rank: raw_rank.filter(|r| *r >= 5.0).map(|r| r - 4.0),
				req_skill,
				req_skill_rank: if req_skill.is_some() { truthy_int(r, "RequiredSkillRank") } else { None },
				..Default::default()
			},
		);
	}
	for r in rows(tables, "Item") {
		let Some(it) = int(r, "ID").and_then(|id| items.get_mut(&(id as i64))) else { continue };
		it.class_id = int(r, "ClassID");
		it.subclass_id = int(r, "SubclassID");
		it.inventory_type = int(r, "InventoryType");
	}
	let mut effects: FxHashMap<&str, &Row> = FxHashMap::default();
	for r in rows(tables, "ItemEffect") {
		effects.insert(r.get("ID").map(String::as_str).unwrap_or("undefined"), r);
	}
	let mut links: Vec<(Option<f64>, Option<&Row>)> =
		rows(tables, "ItemXItemEffect").iter().map(|r| (int(r, "ItemID"), effects.get(r.get("ItemEffectID").map(String::as_str).unwrap_or("undefined")).copied())).collect();
	for r in rows(tables, "ItemEffect") {
		if r.get("ParentItemID").is_some_and(|s| !s.is_empty()) {
			links.push((int(r, "ParentItemID"), Some(r)));
		}
	}
	let eid = |e: &Option<&Row>| e.and_then(|r| int(r, "ID")).unwrap_or(0.0);
	links.sort_by(|a, b| {
		let d = a.0.unwrap_or(0.0) - b.0.unwrap_or(0.0);
		let d = if d != 0.0 && !d.is_nan() { d } else { eid(&a.1) - eid(&b.1) };
		super::util::ord(d)
	});
	for (item, effect) in &links {
		let Some(it) = item.and_then(|i| items.get_mut(&(i as i64))) else { continue };
		let Some(effect) = effect else { continue };
		let Some(spell) = truthy_int(effect, "SpellID") else { continue };
		let trig = int(effect, "TriggerType");
		if trig == Some(TRIGGER_LEARN) && it.learn.is_none() {
			it.learn = Some(spell);
		} else if trig == Some(TRIGGER_USE) && it.use_.is_none() {
			it.use_ = Some(spell);
		}
	}
	let mut spell_names = FxHashMap::default();
	for r in rows(tables, "SpellName") {
		if let Some(name) = r.get("Name_lang") {
			spell_names.insert(key(int(r, "ID")), name.clone());
		}
	}
	let mut mount_aura = FxHashSet::default();
	let mut teaches: FxHashMap<i64, i64> = FxHashMap::default();
	let pet_creatures: FxHashSet<i64> = rows(tables, "BattlePetSpecies").iter().filter_map(|r| truthy_int(r, "CreatureID")).map(|x| x as i64).collect();
	let mut summons_pet = FxHashSet::default();
	for r in rows(tables, "SpellEffect") {
		let effect = int(r, "Effect");
		if effect == Some(28.0) && int(r, "EffectMiscValue_0").is_some_and(|c| pet_creatures.contains(&(c as i64))) {
			summons_pet.insert(key(int(r, "SpellID")));
		}
		if effect == Some(EFFECT_AURA) && int(r, "EffectAura") == Some(AURA_MOUNTED) {
			mount_aura.insert(key(int(r, "SpellID")));
		}
		if effect == Some(36.0) {
			if let Some(t) = truthy_int(r, "EffectTriggerSpell") {
				let s = key(int(r, "SpellID"));
				teaches.entry(s).or_insert(t as i64);
			}
		}
	}
	let mut skill_lines = BTreeMap::new();
	for r in rows(tables, "SkillLine") {
		skill_lines.insert(key(int(r, "ID")), r.get("DisplayName_lang").cloned());
	}
	let mut skill_ability: FxHashMap<i64, Option<f64>> = FxHashMap::default();
	let mut mount_skill = Vec::new();
	let mut companion_skill = Vec::new();
	let mut spell_class: FxHashMap<i64, &'static str> = FxHashMap::default();
	for r in rows(tables, "SkillLineAbility") {
		let Some(spell) = truthy_int(r, "Spell") else { continue };
		let spell = spell as i64;
		let line = int(r, "SkillLine");
		skill_ability.entry(spell).or_insert(line);
		if line == Some(SKILL_MOUNTS) {
			mount_skill.push(spell);
		}
		if line == Some(SKILL_COMPANIONS) {
			companion_skill.push(spell);
		}
		let mask = to_int32(truthy_int(r, "ClassMask").unwrap_or(0.0));
		let classes: Vec<&'static str> = CLASSES.iter().filter(|c| mask & (c.bit as i32) != 0).map(|c| c.file).collect();
		if classes.len() == 1 {
			spell_class.insert(spell, classes[0]);
		}
	}
	for (spell, cls) in CLASS_MOUNT_FALLBACK {
		spell_class.entry(spell).or_insert(cls);
	}
	let mut creates: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in rows(tables, "SpellEffect") {
		let spell = truthy_int(r, "SpellID");
		let item = truthy_int(r, "EffectItemType");
		let (Some(spell), Some(item)) = (spell, item) else { continue };
		if int(r, "Effect") != Some(EFFECT_CREATE_ITEM) || skill_ability.contains_key(&(spell as i64)) {
			continue;
		}
		let list = creates.entry(item as i64).or_default();
		if !list.contains(&(spell as i64)) {
			list.push(spell as i64);
		}
	}
	for list in creates.values_mut() {
		list.sort();
	}
	let mut mount_spells: FxHashSet<i64> = rows(tables, "Mount").iter().filter_map(|r| truthy_int(r, "SourceSpellID")).map(|x| x as i64).collect();
	let mount_names: FxHashSet<&str> = rows(tables, "Mount").iter().filter_map(|r| r.get("Name_lang").filter(|s| !s.is_empty()).map(String::as_str)).collect();
	for it in items.values() {
		let sp = it.use_.or(it.learn);
		if it.class_id == Some(15.0) {
			if let Some(sp) = sp {
				if spell_names.get(&(sp as i64)).is_some_and(|n| mount_names.contains(n.as_str())) {
					mount_spells.insert(sp as i64);
				}
			}
		}
	}
	let mount_hidden: FxHashSet<i64> =
		rows(tables, "Mount").iter().filter(|r| to_int32(truthy_int(r, "Flags").unwrap_or(0.0)) & 0x40 != 0).filter_map(|r| truthy_int(r, "SourceSpellID")).map(|x| x as i64).collect();
	let mut pet_spells: FxHashSet<i64> = rows(tables, "BattlePetSpecies").iter().filter_map(|r| truthy_int(r, "SummonSpellID")).map(|x| x as i64).collect();
	pet_spells.extend(summons_pet);
	let dedupe_sort = |v: Vec<i64>| -> Vec<i64> {
		let s: BTreeSet<i64> = v.into_iter().collect();
		s.into_iter().collect()
	};
	ClientFacts {
		build: build.to_string(),
		era_build: None,
		items,
		spell_names,
		mount_aura,
		teaches,
		mount_spells,
		mount_hidden,
		pet_spells,
		skill_lines,
		skill_ability,
		mount_skill: dedupe_sort(mount_skill),
		companion_skill: dedupe_sort(companion_skill),
		spell_class,
		creates,
		instance_maps: Vec::new(),
		instances: None,
	}
}

// ---------------------------------------------------------------------------
// Instance maps (journal.js instanceMapsOf)
// ---------------------------------------------------------------------------

#[derive(Clone, Debug)]
pub struct Corpse {
	pub c: f64,
	pub x: f64,
	pub y: f64,
}

#[derive(Clone, Debug)]
pub struct InstanceMap {
	pub id: f64,
	pub name: String,
	pub raid: bool,
	pub players: Option<f64>,
	pub area: Option<f64>,
	pub areas: Vec<f64>,
	pub inner: Vec<f64>,
	pub zones: Vec<f64>,
	pub corpse: Option<Corpse>,
}

/// journal.js `norm` of a client string.
fn jn(s: Option<&String>) -> String {
	super::util::jnorm_s(s.map(String::as_str).unwrap_or(""))
}

fn sorted(set: &BTreeSet<i64>) -> Vec<f64> {
	set.iter().map(|&x| x as f64).collect()
}

/// journal.js `instanceMapsOf(mapRows, areaRows)`.
pub fn instance_maps_of(map_rows: &[Row], area_rows: &[Row]) -> Vec<InstanceMap> {
	let mut areas_by_map: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	let mut area_names: FxHashMap<String, Vec<i64>> = FxHashMap::default();
	let mut area_row: FxHashMap<i64, &Row> = FxHashMap::default();
	for a in area_rows {
		let id = num0_s(a.get("ID"));
		if id == 0.0 {
			continue;
		}
		let id = id as i64;
		area_row.insert(id, a);
		areas_by_map.entry(num0_s(a.get("ContinentID")) as i64).or_default().push(id);
		let n = jn(a.get("AreaName_lang"));
		if !n.is_empty() {
			area_names.entry(n).or_default().push(id);
		}
	}
	let mut out = Vec::new();
	for r in map_rows {
		let ty = num0_s(r.get("InstanceType"));
		if ty != 1.0 && ty != 2.0 {
			continue;
		}
		let id = num0_s(r.get("ID"));
		let name = [r.get("MapName_lang"), r.get("Directory")].into_iter().flatten().find(|s| !s.is_empty()).cloned().unwrap_or_default();
		let c = num0_s(r.get("CorpseMapID"));
		let x = num0_s(r.get("Corpse_0"));
		let y = num0_s(r.get("Corpse_1"));
		let mut areas: BTreeSet<i64> = areas_by_map.get(&(id as i64)).map(|v| v.iter().copied().collect()).unwrap_or_default();
		let at = num0_s(r.get("AreaTableID"));
		if at != 0.0 {
			areas.insert(at as i64);
		}
		let inner = sorted(&areas);
		let mut zones = BTreeSet::new();
		for &a in area_names.get(&super::util::jnorm_s(&name)).map(Vec::as_slice).unwrap_or(&[]) {
			areas.insert(a);
			if let Some(row) = area_row.get(&a) {
				let parent = num0_s(row.get("ParentAreaID"));
				if num0_s(row.get("ContinentID")) == c && parent != 0.0 {
					zones.insert(parent as i64);
				}
			}
		}
		let players = num0_s(r.get("MaxPlayers"));
		out.push(InstanceMap {
			id,
			name,
			raid: ty == 2.0,
			players: (players != 0.0).then_some(players),
			area: (at != 0.0).then_some(at),
			areas: sorted(&areas),
			inner,
			zones: sorted(&zones),
			corpse: (c >= 0.0 && (x != 0.0 || y != 0.0)).then_some(Corpse { c, x, y }),
		});
	}
	out.sort_by(|a, b| super::util::by_num(a.id, b.id));
	out
}

// ---------------------------------------------------------------------------
// instances.js instanceFacts
// ---------------------------------------------------------------------------

#[derive(Clone, Debug)]
pub struct Encounter {
	pub id: f64,
	pub name: String,
	pub order: f64,
}

pub struct InstanceFacts {
	pub maps: Vec<InstanceMap>,
	pub encounters: FxHashMap<i64, Vec<Encounter>>,
	pub rec_min: FxHashMap<i64, f64>,
	pub entry: FxHashMap<i64, f64>,
	pub era: Option<FxHashSet<i64>>,
	pub lfg_names: FxHashSet<String>,
}

/// instances.js `instanceFacts(tables, eraMapRows)`.
pub fn instance_facts(tables: &Tables, era_map_rows: Option<&[Row]>) -> InstanceFacts {
	let maps = instance_maps_of(rows(tables, "Map"), rows(tables, "AreaTable"));
	// map -> difficulty -> rows (both in first-seen order; difficulty keys as JS object keys).
	let mut by_diff: Vec<(i64, Vec<(f64, Vec<Encounter>)>)> = Vec::new();
	for r in rows(tables, "DungeonEncounter") {
		let map = num0_s(r.get("MapID"));
		let Some(name) = r.get("Name_lang").filter(|s| !s.is_empty()) else { continue };
		if map == 0.0 {
			continue;
		}
		let map = map as i64;
		let diff = num0_s(r.get("DifficultyID"));
		let pos = match by_diff.iter().position(|(m, _)| *m == map) {
			Some(p) => p,
			None => {
				by_diff.push((map, Vec::new()));
				by_diff.len() - 1
			}
		};
		let diffs = &mut by_diff[pos].1;
		let dp = match diffs.iter().position(|(d, _)| *d == diff) {
			Some(p) => p,
			None => {
				diffs.push((diff, Vec::new()));
				diffs.len() - 1
			}
		};
		diffs[dp].1.push(Encounter { id: num0_s(r.get("ID")), name: name.clone(), order: num0_s(r.get("OrderIndex")) });
	}
	let mut encounters = FxHashMap::default();
	for (map, mut diffs) in by_diff {
		// Object.keys order: integer keys ascending.
		diffs.sort_by(|a, b| super::util::by_num(a.0, b.0));
		let normal: Vec<f64> = diffs.iter().map(|d| d.0).filter(|d| *d == 0.0 || *d == 1.0).collect();
		let using: Vec<f64> = if normal.is_empty() { vec![diffs.iter().map(|d| d.0).fold(f64::INFINITY, f64::min)] } else { normal };
		let mut list: Vec<Encounter> = using.iter().flat_map(|u| diffs.iter().filter(|d| d.0 == *u).flat_map(|d| d.1.clone())).collect();
		list.sort_by(|a, b| super::util::ord(if a.order - b.order != 0.0 { a.order - b.order } else { a.id - b.id }));
		let mut seen = FxHashSet::default();
		list.retain(|e| seen.insert(norm_s(&e.name)));
		encounters.insert(map, list);
	}
	let mut tuning: FxHashMap<i64, Option<f64>> = FxHashMap::default();
	for r in rows(tables, "ContentTuning") {
		let t = num0_s(r.get("MinLevelSquish"));
		tuning.insert(num0_s(r.get("ID")) as i64, (t != 0.0).then_some(t));
	}
	let tune = |r: &Row| tuning.get(&(num0_s(r.get("ContentTuningID")) as i64)).copied().flatten();
	let mut entry: FxHashMap<i64, f64> = FxHashMap::default();
	let mut rec_min: FxHashMap<i64, f64> = FxHashMap::default();
	let mut map_diffs: Vec<&Row> = rows(tables, "MapDifficulty").iter().collect();
	map_diffs.sort_by(|a, b| {
		let d = num0_s(a.get("DifficultyID")) - num0_s(b.get("DifficultyID"));
		super::util::ord(if d != 0.0 { d } else { num0_s(a.get("ID")) - num0_s(b.get("ID")) })
	});
	let at_least = regex::Regex::new(r"(?i)at least level (\d+)").unwrap();
	for r in map_diffs {
		let map = num0_s(r.get("MapID")) as i64;
		if let Some(m) = at_least.captures(r.get("Message_lang").map(String::as_str).unwrap_or("")) {
			if !entry.contains_key(&map) || entry[&map] == 0.0 {
				entry.insert(map, forge_guide::js::str_to_num(&m[1]));
			}
		}
		if let Some(t) = tune(r) {
			rec_min.entry(map).or_insert(t);
		}
	}
	let mut lfg_min: BTreeMap<i64, f64> = BTreeMap::new();
	for r in rows(tables, "LFGDungeons") {
		let ty = num0_s(r.get("TypeID"));
		if ty != 0.0 && ty != 2.0 {
			continue;
		}
		let Some(t) = tune(r) else { continue };
		let Some(name) = r.get("Name_lang").filter(|s| !s.is_empty()) else { continue };
		let n = norm_s(name);
		for m in &maps {
			let mn = norm_s(&m.name);
			if !mn.is_empty() && (n == mn || (n.starts_with(&mn) && mn.len() >= 6) || (n.ends_with(&mn) && mn.len() >= 6)) {
				let cur = lfg_min.get(&(m.id as i64)).copied().filter(|v| *v != 0.0).unwrap_or(f64::INFINITY);
				lfg_min.insert(m.id as i64, cur.min(t));
			}
		}
	}
	for (map, t) in lfg_min {
		rec_min.insert(map, t);
	}
	let era = era_map_rows.map(|rows| rows.iter().map(|r| num0_s(r.get("ID")) as i64).collect());
	let lfg_names = rows(tables, "LFGDungeons").iter().map(|r| norm_s(r.get("Name_lang").map(String::as_str).unwrap_or(""))).collect();
	InstanceFacts { maps, encounters, rec_min, entry, era, lfg_names }
}
