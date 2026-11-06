//! Racial gear traits from the Forever client's racial spells: the passive spells of the racial
//! skill lines (SkillLine category 9, SkillLineAbility rows for one race), read from SpellEffect and
//! SpellEquippedItems. What changes which item is better:
//!   aura 137 (total stat %)       -> statMult of that stat (misc 0-4 str/agi/sta/int/spi, -1 all)
//!   aura 133 (total health %)     -> statMult sta (each point of stamina gives that much more health)
//!   aura 178, power 0 (max mana %)-> statMult int (each point of intellect gives that much more mana)
//!   aura 290/52 (crit chance)     -> weaponCrit, only when SpellEquippedItems limits it to weapon
//!                                    subclasses (a crit bonus for everything changes no comparison)
//! A trait keeps its SkillLineAbility class mask (0: every class).

use std::collections::BTreeMap;

use rustc_hash::FxHashMap;

use super::client::Tables;
use crate::itemdb::int;
use crate::jsv::{col_num, col_str, Row};

const RACIAL_CATEGORY: i64 = 9;
const ALL_CLASSES: i64 = 0x5df;
const STATS: [&str; 5] = ["str", "agi", "sta", "int", "spi"];

#[derive(Debug, Clone, PartialEq)]
pub struct Trait {
	pub spell: i64,
	pub name: String,
	/// SkillLineAbility ClassMask; 0: every class.
	pub class_mask: i64,
	pub stat_mult: Vec<(String, f64)>,
	/// (percent, weapon subclasses)
	pub weapon_crit: Option<(f64, Vec<i64>)>,
}

/// Race ID -> its traits (by spell ID).
pub type Racials = BTreeMap<i64, Vec<Trait>>;

fn race_of(mask: i64) -> Option<i64> {
	(mask > 0 && mask.count_ones() == 1).then(|| mask.trailing_zeros() as i64 + 1)
}

fn bits(mask: i64) -> Vec<i64> {
	(0..32).filter(|b| mask & (1 << b) != 0).collect()
}

fn mult(stats: &mut Vec<(String, f64)>, key: &str, pct: f64) {
	let m = 1.0 + pct / 100.0;
	match stats.iter_mut().find(|s| s.0 == key) {
		Some(s) => s.1 *= m,
		None => stats.push((key.to_string(), m)),
	}
}

/// The racial traits of the Forever tables.
pub fn racials(t: &Tables) -> Racials {
	let racial_lines: std::collections::HashSet<i64> = t.get("SkillLine").iter().filter(|r| int(r, "CategoryID") == RACIAL_CATEGORY).map(|r| int(r, "ID")).collect();
	let mut effects: FxHashMap<i64, Vec<&Row>> = FxHashMap::default();
	for r in t.get("SpellEffect") {
		effects.entry(int(r, "SpellID")).or_default().push(r);
	}
	let mut limits: FxHashMap<i64, &Row> = FxHashMap::default();
	for r in t.get("SpellEquippedItems") {
		limits.insert(int(r, "SpellID"), r);
	}
	let names: FxHashMap<i64, &str> = t.get("SpellName").iter().map(|r| (int(r, "ID"), col_str(r, "Name_lang"))).collect();
	let mut out = Racials::new();
	let mut abilities: Vec<&Row> = t.get("SkillLineAbility").iter().filter(|r| racial_lines.contains(&int(r, "SkillLine"))).collect();
	abilities.sort_by_key(|r| (int(r, "RaceMasks_0"), int(r, "Spell")));
	for a in abilities {
		let Some(race) = race_of(int(a, "RaceMasks_0")) else { continue };
		let spell = int(a, "Spell");
		let mut effs: Vec<&&Row> = effects.get(&spell).into_iter().flatten().collect();
		effs.sort_by_key(|e| int(e, "EffectIndex"));
		let mut tr = Trait { spell, name: names.get(&spell).copied().unwrap_or("").to_string(), class_mask: int(a, "ClassMask"), stat_mult: Vec::new(), weapon_crit: None };
		if tr.class_mask < 0 || tr.class_mask & ALL_CLASSES == ALL_CLASSES {
			tr.class_mask = 0;
		}
		for e in effs {
			if int(e, "Effect") != 6 || int(e, "DifficultyID") != 0 {
				continue;
			}
			let pct = col_num(e, "EffectBasePointsF");
			let pct = if pct.is_finite() { pct } else { int(e, "EffectBasePoints") as f64 };
			let misc = int(e, "EffectMiscValue_0");
			match int(e, "EffectAura") {
				137 if misc == -1 => STATS.iter().for_each(|s| mult(&mut tr.stat_mult, s, pct)),
				137 if (0..5).contains(&misc) => mult(&mut tr.stat_mult, STATS[misc as usize], pct),
				133 => mult(&mut tr.stat_mult, "sta", pct),
				178 if misc == 0 => mult(&mut tr.stat_mult, "int", pct),
				290 | 52 => {
					if let Some(l) = limits.get(&spell).filter(|l| int(l, "EquippedItemClass") == 2 && int(l, "EquippedItemSubclass") > 0) {
						tr.weapon_crit = Some((pct, bits(int(l, "EquippedItemSubclass"))));
					}
				}
				_ => {}
			}
		}
		for s in tr.stat_mult.iter_mut() {
			s.1 = (s.1 * 10000.0).round() / 10000.0;
		}
		if !tr.stat_mult.is_empty() || tr.weapon_crit.is_some() {
			out.entry(race).or_default().push(tr);
		}
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::jsv::Rows;

	fn row(kv: &[(&str, &str)]) -> Row {
		kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	#[test]
	fn reads_stat_multipliers_class_masks_and_only_weapon_limited_crit() {
		let t: Vec<(&'static str, Rows)> = vec![
			(
				"SkillLine",
				vec![row(&[("ID", "754"), ("CategoryID", "9")]), row(&[("ID", "753"), ("CategoryID", "9")]), row(&[("ID", "125"), ("CategoryID", "9")]), row(&[("ID", "43"), ("CategoryID", "6")])],
			),
			(
				"SkillLineAbility",
				vec![
					row(&[("SkillLine", "754"), ("Spell", "20598"), ("RaceMasks_0", "1"), ("ClassMask", "0")]),
					row(&[("SkillLine", "754"), ("Spell", "20597"), ("RaceMasks_0", "1"), ("ClassMask", "0")]),
					row(&[("SkillLine", "753"), ("Spell", "20591"), ("RaceMasks_0", "64"), ("ClassMask", "400")]),
					row(&[("SkillLine", "125"), ("Spell", "20574"), ("RaceMasks_0", "2"), ("ClassMask", "-1")]),
					row(&[("SkillLine", "43"), ("Spell", "999"), ("RaceMasks_0", "1"), ("ClassMask", "0")]),
				],
			),
			(
				"SpellEffect",
				vec![
					row(&[("SpellID", "20598"), ("Effect", "6"), ("EffectAura", "137"), ("EffectBasePointsF", "10"), ("EffectMiscValue_0", "4"), ("EffectIndex", "0")]),
					row(&[("SpellID", "20597"), ("Effect", "6"), ("EffectAura", "290"), ("EffectBasePointsF", "1"), ("EffectMiscValue_0", "0"), ("EffectIndex", "0")]),
					row(&[("SpellID", "20591"), ("Effect", "6"), ("EffectAura", "178"), ("EffectBasePointsF", "5"), ("EffectMiscValue_0", "0"), ("EffectIndex", "0")]),
					row(&[("SpellID", "20574"), ("Effect", "6"), ("EffectAura", "290"), ("EffectBasePointsF", "1"), ("EffectMiscValue_0", "0"), ("EffectIndex", "0")]),
					row(&[("SpellID", "999"), ("Effect", "6"), ("EffectAura", "137"), ("EffectBasePointsF", "50"), ("EffectMiscValue_0", "0"), ("EffectIndex", "0")]),
				],
			),
			(
				"SpellName",
				vec![
					row(&[("ID", "20598"), ("Name_lang", "The Human Spirit")]),
					row(&[("ID", "20591"), ("Name_lang", "Expansive Mind")]),
					row(&[("ID", "20574"), ("Name_lang", "Axe Specialization")]),
				],
			),
			// The Orc's crit counts with axes (subclasses 0, 1); the Human's has no limit.
			("SpellEquippedItems", vec![row(&[("SpellID", "20574"), ("EquippedItemClass", "2"), ("EquippedItemSubclass", "3")])]),
		];
		let tables = Tables { build: "1.60.1.1".into(), tables: t.into_iter().collect(), hotfix_dir: None, applied: Vec::new(), warnings: Vec::new() };
		let r = racials(&tables);
		let human = Trait { spell: 20598, name: "The Human Spirit".into(), class_mask: 0, stat_mult: vec![("spi".into(), 1.1)], weapon_crit: None };
		let orc = Trait { spell: 20574, name: "Axe Specialization".into(), class_mask: 0, stat_mult: Vec::new(), weapon_crit: Some((1.0, vec![0, 1])) };
		let gnome = Trait { spell: 20591, name: "Expansive Mind".into(), class_mask: 400, stat_mult: vec![("int".into(), 1.05)], weapon_crit: None };
		assert_eq!(r, [(1, vec![human]), (2, vec![orc]), (7, vec![gnome])].into_iter().collect::<Racials>());
	}
}
