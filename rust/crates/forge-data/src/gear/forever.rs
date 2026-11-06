//! Forever's item stats from the Forever client's own tables, in Items.lua's record form, and the
//! overlay of those that differ from Classic Era's (addon/Polestar_ItemDB/Items.lua).
//!
//! Forever's ItemSparse has no stat amounts, weapon damage or armor columns: the client computes them
//! from the item level, quality and slot, as its tooltips do.
//!   stats    StatPercentEditor_i x RandPropPoints[item level].<quality>F_<slot group> / 10000, rounded
//!            (Good for poor to uncommon, Superior for rare, Epic above); the slot groups are
//!            0 head/chest/legs/two-hand/robe, 1 shoulder/waist/feet/hands/trinket, 2 neck/wrist/
//!            finger/shield/back/held in off-hand, 3 one-hand weapons, 4 ranged/thrown/relic.
//!   ratings  crit, hit, dodge, parry and block come as ratings: converted to the percent Polestar's
//!            weights use at the client's rates, the same at every level (gametables/combatratings.txt,
//!            and combatratingsmultbyilvl.txt is 1 for every item level): 14 crit = 1%, 10 hit, 12 dodge,
//!            15 parry, 5 block. Crit and hit ratings count for spells too. Haste and expertise (10 per
//!            1%) are left out: Polestar's weights have no key for them.
//!   armor    ItemArmorTotal[ilvl].<material> x ArmorLocation[slot] x ItemArmorQuality[ilvl], rounded;
//!            shields ItemArmorShield[ilvl]; plus any bonus armor stat.
//!   weapons  DPS from ItemDamageOneHand/TwoHand/Ranged/Thrown/Wand[ilvl][quality]; min = floor(DPS x
//!            speed x (1 - variance/2)), max = round(DPS x speed x (1 + variance/2)).
//!   casters  Flags_4 0x100: a caster weapon, its damage 0.74 (two-hand) or 2/3 (one-hand) of that;
//!            0x200 adds spell damage and healing of 2 x the slot-group-0 budget; 0x400 healing of
//!            3.75 x and spell damage of 1.25 x it.
//!   equip    on-equip spells (ItemXItemEffect -> ItemEffect -> SpellEffect) as itemdb reads Era's.
//! Checked against Classic Era's stated values for the items Forever kept (stats, armor, weapon
//! damage agree) and Forever's published item values (see the gear report of the change that added
//! this, PR #1014).

use std::collections::BTreeMap;

use forge_guide::js::V;
use rustc_hash::FxHashMap;

use super::client::Tables;
use super::leveling::{encode, Rec};
use crate::itemdb::{add, equip_stats, index_tables, int, skip_name, Stats, EQUIPPABLE};
use crate::jsv::{col_num, col_str, Row, Rows};

/// Forever stat types (ItemModType) -> Polestar stat keys.
fn stat_key(t: i64) -> Option<&'static [&'static str]> {
	Some(match t {
		0 => &["mana"],
		1 => &["health"],
		3 => &["agi"],
		4 => &["str"],
		5 => &["int"],
		6 => &["spi"],
		7 => &["sta"],
		12 => &["defense"],
		38 => &["ap"],
		39 => &["rap"],
		41 => &["heal"],
		42 => &["sp"],
		43 => &["mp5"],
		45 => &["sp", "heal"],
		46 => &["hp5"],
		48 => &["blockValue"],
		50 => &["armor"],
		84 => &["spHoly"],
		85 => &["spFire"],
		86 => &["spNature"],
		87 => &["spFrost"],
		88 => &["spShadow"],
		89 => &["spArcane"],
		_ => return None,
	})
}

/// Rating stat types -> (Polestar keys, rating per 1%).
fn rating(t: i64) -> Option<(&'static [&'static str], f64)> {
	Some(match t {
		13 => (&["dodge"], 12.0),
		14 => (&["parry"], 15.0),
		15 => (&["block"], 5.0),
		31 => (&["hit", "spellHit"], 10.0),
		32 => (&["crit", "spellCrit"], 14.0),
		_ => return None,
	})
}

/// Stat types Polestar's weights have no use for (resistances, profession skills): not counted as gaps.
fn ignored(t: i64) -> bool {
	(51..=56).contains(&t) || t == 124
}

const CASTER: i64 = 0x100;
const CASTER_SPELL: i64 = 0x200;
const CASTER_HEAL: i64 = 0x400;

fn slot_group(inv: i64) -> Option<usize> {
	Some(match inv {
		1 | 5 | 7 | 17 | 20 => 0,
		3 | 6 | 8 | 10 | 12 => 1,
		2 | 9 | 11 | 14 | 16 | 23 => 2,
		13 | 21 | 22 => 3,
		15 | 25 | 26 | 28 => 4,
		_ => return None,
	})
}

fn quality_column(q: i64) -> &'static str {
	match q {
		..=2 => "Good",
		3 | 7 => "Superior",
		_ => "Epic",
	}
}

fn round(x: f64) -> f64 {
	(x + 0.5).floor()
}

struct Lookup<'a> {
	rand_prop: FxHashMap<i64, &'a Row>,
	armor_quality: FxHashMap<i64, &'a Row>,
	armor_shield: FxHashMap<i64, &'a Row>,
	armor_total: FxHashMap<i64, &'a Row>,
	armor_location: FxHashMap<i64, &'a Row>,
	damage: FxHashMap<&'static str, FxHashMap<i64, &'a Row>>,
}

fn by<'a>(rows: &'a Rows, key: &str) -> FxHashMap<i64, &'a Row> {
	rows.iter().map(|r| (int(r, key), r)).collect()
}

const DAMAGE: [&str; 5] = ["ItemDamageOneHand", "ItemDamageTwoHand", "ItemDamageRanged", "ItemDamageThrown", "ItemDamageWand"];

impl<'a> Lookup<'a> {
	fn new(t: &'a Tables) -> Lookup<'a> {
		Lookup {
			rand_prop: by(t.get("RandPropPoints"), "ID"),
			armor_quality: by(t.get("ItemArmorQuality"), "ID"),
			armor_shield: by(t.get("ItemArmorShield"), "ItemLevel"),
			armor_total: by(t.get("ItemArmorTotal"), "ItemLevel"),
			armor_location: by(t.get("ArmorLocation"), "ID"),
			damage: DAMAGE.iter().map(|&n| (n, by(t.get(n), "ItemLevel"))).collect(),
		}
	}

	fn budget(&self, ilvl: i64, quality: i64, group: usize) -> f64 {
		self.rand_prop.get(&ilvl).map(|r| col_num(r, &format!("{}F_{group}", quality_column(quality)))).filter(|n| n.is_finite()).unwrap_or(0.0)
	}

	fn armor(&self, ilvl: i64, quality: i64, inv: i64, sub: i64) -> i64 {
		if sub == 6 {
			return self.armor_shield.get(&ilvl).map(|r| round(col_num(r, &format!("Quality_{quality}"))) as i64).unwrap_or(0);
		}
		let (material, modifier) = match sub {
			1 => ("Cloth", "Clothmodifier"),
			2 => ("Leather", "Leathermodifier"),
			3 => ("Mail", "Chainmodifier"),
			4 => ("Plate", "Platemodifier"),
			_ => return 0,
		};
		let inv = if inv == 20 { 5 } else { inv };
		let (Some(total), Some(loc), Some(q)) = (self.armor_total.get(&ilvl), self.armor_location.get(&inv), self.armor_quality.get(&ilvl)) else { return 0 };
		let a = col_num(total, material) * col_num(loc, modifier) * col_num(q, &format!("Qualitymod_{quality}"));
		if a.is_finite() {
			round(a) as i64
		} else {
			0
		}
	}

	fn damage_table(inv: i64, sub: i64) -> Option<&'static str> {
		Some(match inv {
			13 | 21 | 22 => "ItemDamageOneHand",
			17 => "ItemDamageTwoHand",
			26 if sub == 19 => "ItemDamageWand",
			15 | 26 => "ItemDamageRanged",
			25 => "ItemDamageThrown",
			_ => return None,
		})
	}

	/// (min, max) damage, or None for no weapon.
	fn weapon(&self, row: &Row, inv: i64, sub: i64, ilvl: i64, quality: i64, flags4: i64) -> Option<(f64, f64)> {
		let speed = int(row, "ItemDelay");
		let table = Self::damage_table(inv, sub)?;
		if speed <= 0 {
			return None;
		}
		let mut dps = self.damage.get(table)?.get(&ilvl).map(|r| col_num(r, &format!("Quality_{quality}")))?;
		if !dps.is_finite() || dps <= 0.0 {
			return None;
		}
		if flags4 & CASTER != 0 {
			dps *= if inv == 17 { 0.74 } else { 2.0 / 3.0 };
		}
		let variance = col_num(row, "DmgVariance");
		let variance = if variance.is_finite() { variance } else { 0.0 };
		let swing = dps * speed as f64 / 1000.0;
		let (min, max) = ((swing * (1.0 - variance / 2.0)).floor(), round(swing * (1.0 + variance / 2.0)));
		(max > 0.0).then_some((min, max))
	}
}

fn add_f(stats: &mut Stats, key: &str, n: f64) {
	if n == 0.0 {
		return;
	}
	match stats.iter_mut().find(|s| s.0 == key) {
		Some(s) => s.1 += n,
		None => stats.push((key.to_string(), n)),
	}
}

/// The Forever records and what was left out (reason -> count), plus the stat types not used
/// (type -> items).
pub struct Extracted {
	pub items: Vec<Rec>,
	pub skipped: BTreeMap<&'static str, usize>,
	pub unmapped: BTreeMap<i64, usize>,
}

/// Every equippable item of the Forever tables as an ItemDB record.
pub fn extract(t: &Tables) -> Extracted {
	let lk = Lookup::new(t);
	let index = index_tables(t.get("Item"), t.get("ItemEffect"), Some(t.get("ItemXItemEffect")), t.get("SpellEffect"));
	let skip = skip_name();
	let mut items = Vec::new();
	let mut skipped: BTreeMap<&'static str, usize> = BTreeMap::new();
	let mut unmapped: BTreeMap<i64, usize> = BTreeMap::new();
	for row in t.get("ItemSparse") {
		let id = int(row, "ID");
		let inv = int(row, "InventoryType");
		if !EQUIPPABLE.contains(&inv) {
			*skipped.entry("slot").or_default() += 1;
			continue;
		}
		if skip.is_match(col_str(row, "Display_lang")) {
			*skipped.entry("name").or_default() += 1;
			continue;
		}
		let Some(&(cls, sub)) = index.class.get(&id) else {
			*skipped.entry("no-item-row").or_default() += 1;
			continue;
		};
		let (ilvl, quality, flags4) = (int(row, "ItemLevel"), int(row, "OverallQualityID"), int(row, "Flags_4"));
		let budget = slot_group(inv).map(|g| lk.budget(ilvl, quality, g)).unwrap_or(0.0);
		let mut stats = Stats::new();
		for i in 0..10 {
			let ty = int(row, &format!("StatModifier_bonusStat_{i}"));
			let alloc = int(row, &format!("StatPercentEditor_{i}"));
			if ty < 0 || alloc == 0 {
				continue;
			}
			let amount = round(alloc as f64 * budget / 10000.0);
			if let Some(keys) = stat_key(ty) {
				for k in keys {
					add(&mut stats, k, amount as i64);
				}
			} else if let Some((keys, per)) = rating(ty) {
				for k in keys {
					add_f(&mut stats, k, amount / per);
				}
			} else if !ignored(ty) {
				*unmapped.entry(ty).or_default() += 1;
			}
		}
		let b0 = lk.budget(ilvl, quality, 0);
		if flags4 & CASTER_SPELL != 0 {
			add(&mut stats, "sp", (2.0 * b0) as i64);
			add(&mut stats, "heal", (2.0 * b0) as i64);
		}
		if flags4 & CASTER_HEAL != 0 {
			add(&mut stats, "sp", (1.25 * b0).floor() as i64);
			add(&mut stats, "heal", round(3.75 * b0) as i64);
		}
		if cls == 4 {
			add(&mut stats, "armor", lk.armor(ilvl, quality, inv, sub));
		}
		for spell in index.equip.get(&id).into_iter().flatten() {
			equip_stats(index.effects.get(spell).map(Vec::as_slice).unwrap_or(&[]), &mut stats);
		}
		for s in stats.iter_mut() {
			s.1 = (s.1 * 100.0).round() / 100.0;
		}
		let weapon = if cls == 2 { lk.weapon(row, inv, sub, ilvl, quality, flags4) } else { None };
		let allow = int(row, "AllowableClass");
		let n = |x: i64| V::Num(x as f64);
		items.push(Rec {
			id: id as f64,
			inv: n(inv),
			ilvl: n(ilvl),
			req: n(int(row, "RequiredLevel")),
			quality: n(quality),
			cls: n(cls),
			sub: n(sub),
			allow: n(if allow > 0 && (allow & 0x5df) != 0x5df { allow } else { 0 }),
			unique: int(row, "MaxCount") == 1,
			stats,
			dmin: weapon.map(|w| w.0),
			dmax: weapon.map(|w| w.1),
			speed: weapon.map(|_| int(row, "ItemDelay") as f64),
		});
	}
	items.sort_by(|a, b| a.id.total_cmp(&b.id));
	Extracted { items, skipped, unmapped }
}

/// How the Forever records compare with Era's.
#[derive(Default, Debug, PartialEq, Eq)]
pub struct Overlay {
	/// Forever-only items.
	pub new_items: usize,
	/// In both, Forever's record differs.
	pub retuned: usize,
	/// In both, the same.
	pub unchanged: usize,
}

/// The records Forever.lua registers over Items.lua: Forever-only items and those Forever changed.
pub fn overlay(forever: &[Rec], era: &FxHashMap<u64, Rec>) -> (Vec<Rec>, Overlay) {
	let mut out = Vec::new();
	let mut c = Overlay::default();
	for r in forever {
		match era.get(&(r.id as u64)) {
			None => {
				c.new_items += 1;
				out.push(r.clone());
			}
			Some(e) if encode(e) != encode(r) => {
				c.retuned += 1;
				out.push(r.clone());
			}
			Some(_) => c.unchanged += 1,
		}
	}
	(out, c)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::gear::client::Tables;

	fn row(kv: &[(&str, &str)]) -> Row {
		kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	fn tables(rows: Vec<(&'static str, Rows)>) -> Tables {
		Tables { build: "1.60.1.1".into(), tables: rows.into_iter().collect(), hotfix_dir: None, applied: Vec::new(), warnings: Vec::new() }
	}

	fn budget_rows() -> Vec<(&'static str, Rows)> {
		vec![
			("RandPropPoints", vec![row(&[("ID", "25"), ("GoodF_0", "9"), ("GoodF_1", "7"), ("GoodF_2", "5"), ("GoodF_3", "4"), ("GoodF_4", "3"), ("SuperiorF_0", "12")])]),
			("ItemArmorTotal", vec![row(&[("ItemLevel", "25"), ("Cloth", "100"), ("Leather", "200"), ("Mail", "300"), ("Plate", "400")])]),
			("ArmorLocation", vec![row(&[("ID", "5"), ("Clothmodifier", "0.16"), ("Leathermodifier", "0.16"), ("Chainmodifier", "0.16"), ("Platemodifier", "0.16")])]),
			("ItemArmorQuality", vec![row(&[("ID", "25"), ("Qualitymod_2", "1"), ("Qualitymod_3", "1.1")])]),
			("ItemArmorShield", vec![]),
			("ItemDamageOneHand", vec![row(&[("ItemLevel", "25"), ("Quality_2", "10")])]),
			("ItemDamageTwoHand", vec![row(&[("ItemLevel", "25"), ("Quality_2", "16.8")])]),
			("ItemDamageRanged", vec![]),
			("ItemDamageThrown", vec![]),
			("ItemDamageWand", vec![]),
		]
	}

	#[test]
	fn computes_stats_ratings_armor_damage_and_caster_spell_power_like_the_client() {
		let mut t = budget_rows();
		t.push((
			"ItemSparse",
			vec![
				// a robe: int 4000/10000 x 9 = 3.6 -> 4, crit rating 7000 x 9 / 10000 = 6.3 -> 6 -> 0.43%
				row(&[
					("ID", "1"),
					("Display_lang", "Robe"),
					("InventoryType", "20"),
					("ItemLevel", "25"),
					("OverallQualityID", "2"),
					("RequiredLevel", "20"),
					("AllowableClass", "-1"),
					("StatModifier_bonusStat_0", "5"),
					("StatPercentEditor_0", "4000"),
					("StatModifier_bonusStat_1", "32"),
					("StatPercentEditor_1", "7000"),
					("StatModifier_bonusStat_2", "-1"),
					("Flags_4", "0"),
				]),
				// a caster staff: damage x 0.74, +18 spell damage and healing (2 x 9)
				row(&[
					("ID", "2"),
					("Display_lang", "Rod"),
					("InventoryType", "17"),
					("ItemLevel", "25"),
					("OverallQualityID", "2"),
					("ItemDelay", "3800"),
					("DmgVariance", "0.4"),
					("AllowableClass", "-1"),
					("StatModifier_bonusStat_0", "-1"),
					("Flags_4", "768"),
				]),
				// a sword: 10 DPS x 2.0 s, variance 0.6 -> 14-26
				row(&[
					("ID", "3"),
					("Display_lang", "Sword"),
					("InventoryType", "13"),
					("ItemLevel", "25"),
					("OverallQualityID", "2"),
					("ItemDelay", "2000"),
					("DmgVariance", "0.6"),
					("AllowableClass", "-1"),
					("MaxCount", "1"),
					("StatModifier_bonusStat_0", "-1"),
					("Flags_4", "0"),
				]),
				row(&[("ID", "4"), ("Display_lang", "Monster - Sword"), ("InventoryType", "13")]),
				row(&[("ID", "5"), ("Display_lang", "Shirt"), ("InventoryType", "4")]),
			],
		));
		t.push((
			"Item",
			vec![row(&[("ID", "1"), ("ClassID", "4"), ("SubclassID", "1")]), row(&[("ID", "2"), ("ClassID", "2"), ("SubclassID", "10")]), row(&[("ID", "3"), ("ClassID", "2"), ("SubclassID", "7")])],
		));
		t.push(("ItemEffect", vec![row(&[("ID", "50"), ("TriggerType", "1"), ("SpellID", "900")])]));
		t.push(("ItemXItemEffect", vec![row(&[("ItemID", "1"), ("ItemEffectID", "50")])]));
		t.push(("SpellEffect", vec![row(&[("SpellID", "900"), ("Effect", "6"), ("EffectAura", "85"), ("EffectBasePointsF", "3"), ("EffectMiscValue_0", "0"), ("EffectIndex", "0")])]));
		let ex = extract(&tables(t));
		let enc: Vec<String> = ex.items.iter().map(encode).collect();
		assert_eq!(enc, vec!["20 25 20 2 4 1 int4 armor16 crit0.43 spellCrit0.43 mpr3", "17 25 0 2 2 10 sp18 heal18 dmin37 dmax57 speed3800", "13 25 0 2 2 7 dmin14 dmax26 speed2000 uniq1"]);
		assert_eq!(ex.skipped.into_iter().collect::<Vec<_>>(), vec![("name", 1), ("slot", 1)]);
		// The addon reads what encode writes, decimals included.
		let back = crate::gear::leveling::decode(1.0, &enc[0]).unwrap();
		assert_eq!(encode(&back), enc[0]);
	}

	#[test]
	fn the_overlay_holds_forever_only_and_changed_items() {
		let rec = |id: f64, ilvl: f64| Rec {
			id,
			inv: V::Num(1.0),
			ilvl: V::Num(ilvl),
			req: V::Num(0.0),
			quality: V::Num(2.0),
			cls: V::Num(4.0),
			sub: V::Num(1.0),
			allow: V::Num(0.0),
			unique: false,
			stats: Vec::new(),
			dmin: None,
			dmax: None,
			speed: None,
		};
		let era: FxHashMap<u64, Rec> = [(1, rec(1.0, 10.0)), (2, rec(2.0, 10.0))].into_iter().collect();
		let (out, c) = overlay(&[rec(1.0, 10.0), rec(2.0, 12.0), rec(3.0, 5.0)], &era);
		assert_eq!(out.iter().map(|r| r.id).collect::<Vec<_>>(), vec![2.0, 3.0]);
		assert_eq!(c, Overlay { new_items: 1, retuned: 1, unchanged: 1 });
	}
}
