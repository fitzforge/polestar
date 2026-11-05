//! `forge data itemdb` (port of tools/lib/itemdb/{build,stats}.js): the Classic Era client's item
//! tables -> the load-on-demand data addon addon/Polestar_ItemDB (Items.lua + TOC) that
//! Polestar.Gear scores items from. Same inputs give byte-identical output.
//!
//! Columns read (wow_classic_era 1.15.9.70003):
//!   ItemSparse   ID, Display_lang, ItemLevel, RequiredLevel, InventoryType, OverallQualityID,
//!                AllowableClass (-1 any), MaxCount (1 unique), StatModifier_bonusStat_0..9
//!                (ItemModType, -1 none), StatModifier_bonusAmount_0..9, ItemDelay (ms),
//!                MinDamage_0..4 / MaxDamage_0..4, Resistances_0 (armor)
//!   Item         ID, ClassID, SubclassID
//!   ItemEffect   ParentItemID, TriggerType (1 = on equip), SpellID
//!   SpellEffect  SpellID, Effect (6 = apply aura), EffectAura, EffectBasePoints, EffectDieSides,
//!                EffectMiscValue_0, EffectIndex, DifficultyID
//! Classic "equip" bonuses (attack power, spell damage, crit, mp5...) are spells with an aura.
//! Left out: Season of Discovery items (ID >= 190000), NPC-only "Monster - " weapons,
//! deprecated/test items, and slots that carry no stats worth scoring.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_guide::js::{num_str, V};
use rustc_hash::FxHashMap;

use crate::gear::leveling::{encode, Rec};
use crate::jsv::{col_str, Row, Rows};

pub const TABLES: [&str; 4] = ["ItemSparse", "Item", "ItemEffect", "SpellEffect"];
pub const ADDON: &str = "Polestar_ItemDB";
pub const SCHEMA: u32 = 1;
/// The data addon is loaded on demand into every player's client: keep it small.
pub const SIZE_BUDGET: usize = 1024 * 1024;
pub const COMMAND: &str = "forge data itemdb";

const EQUIPPABLE: [i64; 23] = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 21, 22, 23, 25, 26, 28];
const SOD_ITEM_MIN: i64 = 190000;
const ALL_MAGIC: i64 = 126;

fn item_mod(m: i64) -> Option<&'static str> {
	Some(match m {
		0 => "mana",
		1 => "health",
		3 => "agi",
		4 => "str",
		5 => "int",
		6 => "spi",
		7 => "sta",
		38 => "ap",
		_ => return None,
	})
}

fn school(m: i64) -> Option<&'static str> {
	Some(match m {
		2 => "spHoly",
		4 => "spFire",
		8 => "spNature",
		16 => "spFrost",
		32 => "spShadow",
		64 => "spArcane",
		_ => return None,
	})
}

/// stats.js `int`: `Math.trunc(Number(v))`, 0 when not finite.
fn int(r: &Row, c: &str) -> i64 {
	let n = crate::jsv::col_num(r, c);
	if n.is_finite() {
		n.trunc() as i64
	} else {
		0
	}
}

type Stats = Vec<(String, f64)>;

fn add(stats: &mut Stats, key: &str, n: i64) {
	if n == 0 {
		return;
	}
	match stats.iter_mut().find(|s| s.0 == key) {
		Some(s) => s.1 += n as f64,
		None => stats.push((key.to_string(), n as f64)),
	}
}

/// One equip spell's aura effects -> stats.
fn equip_stats(effects: &[&Row], stats: &mut Stats) {
	let mut auras: FxHashMap<i64, i64> = FxHashMap::default();
	for e in effects {
		if int(e, "Effect") != 6 || int(e, "DifficultyID") != 0 {
			continue;
		}
		let aura = int(e, "EffectAura");
		let amount = int(e, "EffectBasePoints") + int(e, "EffectDieSides");
		let misc = int(e, "EffectMiscValue_0");
		auras.insert(aura, amount);
		match aura {
			13 => {
				if misc & ALL_MAGIC == ALL_MAGIC {
					add(stats, "sp", amount);
				} else if let Some(s) = school(misc) {
					add(stats, s, amount);
				}
			}
			135 => add(stats, "heal", amount),
			85 if misc == 0 => add(stats, "mp5", amount),
			161 => add(stats, "hp5", amount),
			52 => add(stats, "crit", amount),
			54 => add(stats, "hit", amount),
			55 => add(stats, "spellHit", amount),
			57 => add(stats, "spellCrit", amount),
			552 if misc & ALL_MAGIC == ALL_MAGIC => add(stats, "spellCrit", amount),
			47 => add(stats, "parry", amount),
			49 => add(stats, "dodge", amount),
			51 => add(stats, "block", amount),
			564 => add(stats, "blockValue", amount),
			30 if misc == 95 => add(stats, "defense", amount),
			22 if misc == 1 => add(stats, "armor", amount),
			_ => {}
		}
	}
	// +Attack Power bonuses are a melee (99) and a ranged (124) aura of the same size: plain "ap".
	let melee = auras.get(&99).copied();
	let ranged = auras.get(&124).copied();
	if let Some(m) = melee {
		add(stats, "ap", m);
	}
	if let Some(r) = ranged {
		if melee != Some(r) {
			add(stats, "rap", r);
		}
	}
}

struct Index<'a> {
	class: FxHashMap<i64, (i64, i64)>,
	equip: FxHashMap<i64, Vec<i64>>,
	effects: FxHashMap<i64, Vec<&'a Row>>,
}

fn index_tables<'a>(item: &'a Rows, item_effect: &'a Rows, spell_effect: &'a Rows) -> Index<'a> {
	let mut class = FxHashMap::default();
	for r in item {
		class.insert(int(r, "ID"), (int(r, "ClassID"), int(r, "SubclassID")));
	}
	let mut equip: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in item_effect {
		if int(r, "TriggerType") != 1 {
			continue;
		}
		let (it, spell) = (int(r, "ParentItemID"), int(r, "SpellID"));
		if it == 0 || spell == 0 {
			continue;
		}
		equip.entry(it).or_default().push(spell);
	}
	let wanted: rustc_hash::FxHashSet<i64> = equip.values().flatten().copied().collect();
	let mut effects: FxHashMap<i64, Vec<&Row>> = FxHashMap::default();
	for r in spell_effect {
		let s = int(r, "SpellID");
		if wanted.contains(&s) {
			effects.entry(s).or_default().push(r);
		}
	}
	for rows in effects.values_mut() {
		rows.sort_by_key(|r| int(r, "EffectIndex"));
	}
	Index { class, equip, effects }
}

fn skip_name() -> regex::Regex {
	regex::Regex::new(r"(?i)^Monster - |\bdeprecated\b|^(QA)?test\b|\[PH\]|\bunused\b|\bDEBUG\b").unwrap()
}

fn extract_item(row: &Row, index: &Index, skip: &regex::Regex) -> Result<Rec, &'static str> {
	let id = int(row, "ID");
	let inv = int(row, "InventoryType");
	if !EQUIPPABLE.contains(&inv) {
		return Err("slot");
	}
	if id >= SOD_ITEM_MIN {
		return Err("season");
	}
	if skip.is_match(col_str(row, "Display_lang")) {
		return Err("name");
	}
	let &(cls, sub) = index.class.get(&id).ok_or("no-item-row")?;
	let mut stats = Stats::new();
	for i in 0..10 {
		if let Some(k) = item_mod(int(row, &format!("StatModifier_bonusStat_{i}"))) {
			add(&mut stats, k, int(row, &format!("StatModifier_bonusAmount_{i}")));
		}
	}
	add(&mut stats, "armor", int(row, "Resistances_0"));
	for spell in index.equip.get(&id).into_iter().flatten() {
		equip_stats(index.effects.get(spell).map(Vec::as_slice).unwrap_or(&[]), &mut stats);
	}
	let (mut dmin, mut dmax) = (0, 0);
	for i in 0..5 {
		dmin += int(row, &format!("MinDamage_{i}"));
		dmax += int(row, &format!("MaxDamage_{i}"));
	}
	let speed = int(row, "ItemDelay");
	let allow = int(row, "AllowableClass");
	let n = |x: i64| V::Num(x as f64);
	let weapon = dmax > 0 && speed > 0;
	Ok(Rec {
		id: id as f64,
		inv: n(inv),
		ilvl: n(int(row, "ItemLevel")),
		req: n(int(row, "RequiredLevel")),
		quality: n(int(row, "OverallQualityID")),
		cls: n(cls),
		sub: n(sub),
		// 0x5df: all nine classes.
		allow: n(if allow > 0 && (allow & 0x5df) != 0x5df { allow } else { 0 }),
		unique: int(row, "MaxCount") == 1,
		stats,
		dmin: weapon.then_some(dmin as f64),
		dmax: weapon.then_some(dmax as f64),
		speed: weapon.then_some(speed as f64),
	})
}

/// ItemSparse, Item, ItemEffect, SpellEffect rows -> (records by id, left out: reason -> count).
pub fn extract_items(sparse: &Rows, item: &Rows, item_effect: &Rows, spell_effect: &Rows) -> (Vec<Rec>, BTreeMap<&'static str, usize>) {
	let index = index_tables(item, item_effect, spell_effect);
	let skip = skip_name();
	let mut items = Vec::new();
	let mut skipped = BTreeMap::new();
	for row in sparse {
		match extract_item(row, &index, &skip) {
			Ok(r) => items.push(r),
			Err(why) => *skipped.entry(why).or_default() += 1,
		}
	}
	items.sort_by(|a, b| a.id.total_cmp(&b.id));
	(items, skipped)
}

fn lua_str(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

/// Items.lua: one Register call.
pub fn emit_lua(items: &[Rec], build: &str) -> String {
	let mut l = vec![
		forge_guide::emit::header("lua", COMMAND, "the Blizzard Classic Era client tables"),
		format!("-- Blizzard Classic Era client tables (wago.tools build {build}): ItemSparse, Item,"),
		"-- ItemEffect, SpellEffect. Game data (c) Blizzard Entertainment, used as facts.".into(),
		"-- Entry: \"<inventoryType> <itemLevel> <requiredLevel> <quality> <classID> <subclassID>".into(),
		"-- [<stat><n> ...] [dmin<n> dmax<n> speed<ms>] [cls<classMask>] [uniq1]\"; mpr = mp5, hpr = hp5.".into(),
		String::new(),
		"local DB = Polestar and Polestar.ItemDB".into(),
		"if not (DB and DB.Register) then return end".into(),
		String::new(),
		format!("DB.Register({{ schema = {SCHEMA}, build = {}, count = {} }}, {{", lua_str(build), items.len()),
	];
	for r in items {
		l.push(format!("[{}]={},", num_str(r.id), lua_str(&encode(r))));
	}
	l.push("})".into());
	l.push(String::new());
	l.join("\n")
}

pub struct Options {
	pub root: PathBuf,
	pub sources: PathBuf,
	pub out: PathBuf,
	/// Classic Era build (None: the newest listed, offline the newest cached).
	pub build: Option<String>,
	pub offline: bool,
}

impl Options {
	pub fn new(root: &Path) -> Options {
		Options { root: root.to_path_buf(), sources: root.join("data").join("sources"), out: root.join("addon").join(ADDON), build: None, offline: false }
	}
}

pub struct Output {
	pub build: String,
	pub count: usize,
	pub bytes: usize,
	pub skipped: BTreeMap<&'static str, usize>,
	pub warnings: Vec<String>,
}

/// Builds and writes Items.lua and the TOC into `o.out`.
pub fn build(o: &Options, log: &dyn Fn(&str)) -> Result<Output, String> {
	let (build, tables, warnings) = crate::sources::client_tables(&o.sources, &crate::tables::ERA, o.build.as_deref(), &TABLES, o.offline, log)?;
	let t = |n: &str| &tables.iter().find(|(k, _)| k == n).unwrap().1;
	let (items, skipped) = extract_items(t("ItemSparse"), t("Item"), t("ItemEffect"), t("SpellEffect"));
	if items.is_empty() {
		return Err(format!("build {build}: no equippable items found (wrong tables?)"));
	}
	let lua = emit_lua(&items, &build);
	crate::sources::write_atomic(&o.out.join("Items.lua"), lua.as_bytes())?;
	let files: Vec<&str> = ["Items.lua", "Forever.lua"].into_iter().filter(|f| *f == "Items.lua" || o.out.join(f).exists()).collect();
	let toc = crate::gear::emit_toc(&crate::gear::package_version(&o.root), &files);
	let tf = o.out.join(format!("{ADDON}.toc"));
	std::fs::write(&tf, toc).map_err(|e| format!("{}: {e}", tf.display()))?;
	Ok(Output { build, count: items.len(), bytes: lua.len(), skipped, warnings })
}

#[cfg(test)]
mod tests {
	use super::*;

	fn row(kv: &[(&str, &str)]) -> Row {
		kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	#[test]
	fn extracts_stats_equip_bonuses_weapons_and_skips() {
		let sparse = vec![
			row(&[
				("ID", "10"),
				("Display_lang", "Blade"),
				("InventoryType", "13"),
				("ItemLevel", "20"),
				("RequiredLevel", "15"),
				("OverallQualityID", "2"),
				("AllowableClass", "-1"),
				("MaxCount", "1"),
				("StatModifier_bonusStat_0", "4"),
				("StatModifier_bonusAmount_0", "3"),
				("StatModifier_bonusStat_1", "-1"),
				("MinDamage_0", "10"),
				("MaxDamage_0", "20"),
				("ItemDelay", "2000"),
			]),
			row(&[("ID", "11"), ("Display_lang", "Robe"), ("InventoryType", "20"), ("AllowableClass", "16"), ("Resistances_0", "40")]),
			row(&[("ID", "12"), ("Display_lang", "Monster - Axe"), ("InventoryType", "13")]),
			row(&[("ID", "13"), ("Display_lang", "Shirt"), ("InventoryType", "4")]),
			row(&[("ID", "200000"), ("Display_lang", "Rune"), ("InventoryType", "1")]),
			row(&[("ID", "14"), ("Display_lang", "Ring"), ("InventoryType", "11")]),
		];
		let item = vec![row(&[("ID", "10"), ("ClassID", "2"), ("SubclassID", "7")]), row(&[("ID", "11"), ("ClassID", "4"), ("SubclassID", "1")]), row(&[("ID", "12"), ("ClassID", "2")])];
		let effect = vec![row(&[("ParentItemID", "11"), ("TriggerType", "1"), ("SpellID", "500")])];
		let spell = vec![
			row(&[("SpellID", "500"), ("Effect", "6"), ("EffectAura", "13"), ("EffectBasePoints", "6"), ("EffectDieSides", "1"), ("EffectMiscValue_0", "126"), ("EffectIndex", "0")]),
			row(&[("SpellID", "500"), ("Effect", "6"), ("EffectAura", "99"), ("EffectBasePoints", "9"), ("EffectDieSides", "1"), ("EffectIndex", "1")]),
			row(&[("SpellID", "500"), ("Effect", "6"), ("EffectAura", "124"), ("EffectBasePoints", "9"), ("EffectDieSides", "1"), ("EffectIndex", "2")]),
			row(&[("SpellID", "500"), ("Effect", "6"), ("EffectAura", "85"), ("EffectBasePoints", "3"), ("EffectDieSides", "1"), ("EffectMiscValue_0", "0"), ("EffectIndex", "3")]),
		];
		let (items, skipped) = extract_items(&sparse, &item, &effect, &spell);
		let enc: Vec<String> = items.iter().map(encode).collect();
		assert_eq!(enc, vec!["13 20 15 2 2 7 str3 dmin10 dmax20 speed2000 uniq1", "20 0 0 0 4 1 armor40 ap10 sp7 mpr4 cls16"]);
		assert_eq!(skipped.into_iter().collect::<Vec<_>>(), vec![("name", 1), ("no-item-row", 1), ("season", 1), ("slot", 1)]);
		let lua = emit_lua(&items, "1.15.9.70003");
		assert!(lua.starts_with("-- Generated by `forge data itemdb`"));
		assert!(lua.contains("DB.Register({ schema = 1, build = \"1.15.9.70003\", count = 2 }, {\n[10]=\"13 20 15 2 2 7 str3"));
		// The addon reads what encode writes.
		let back = crate::gear::leveling::decode(11.0, &enc[1]).unwrap();
		assert_eq!(encode(&back), enc[1]);
	}
}
