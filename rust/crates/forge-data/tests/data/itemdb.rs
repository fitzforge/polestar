//! `forge data itemdb` on synthetic Classic Era item tables cached as CSV: what each item's entry
//! holds (stats, armor, summed weapon damage, equip auras, class mask, unique), what is left out, the
//! entry format the addon decodes, and the build offline to a TOC and Items.lua, the same on rerun.

use std::collections::BTreeMap;

use forge_data::gear::leveling::{decode, encode};
use forge_data::itemdb::{build, Options};

/// One ItemSparse row (every column the extractor reads) as CSV.
fn sparse(id: i64, name: &str, inv: i64, over: &[(&str, &str)], stats: &[(i64, i64)], damage: &[(i64, i64)]) -> BTreeMap<String, String> {
	let mut r: BTreeMap<String, String> = [
		("ID", id.to_string()),
		("Display_lang", name.to_string()),
		("ItemLevel", "10".into()),
		("RequiredLevel", "5".into()),
		("InventoryType", inv.to_string()),
		("OverallQualityID", "2".into()),
		("AllowableClass", "-1".into()),
		("MaxCount", "0".into()),
		("ItemDelay", "0".into()),
		("Resistances_0", "0".into()),
	]
	.into_iter()
	.map(|(k, v)| (k.to_string(), v))
	.collect();
	for i in 0..10 {
		let (s, a) = stats.get(i).copied().unwrap_or((-1, 0));
		r.insert(format!("StatModifier_bonusStat_{i}"), s.to_string());
		r.insert(format!("StatModifier_bonusAmount_{i}"), a.to_string());
	}
	for i in 0..5 {
		let (lo, hi) = damage.get(i).copied().unwrap_or((0, 0));
		r.insert(format!("MinDamage_{i}"), lo.to_string());
		r.insert(format!("MaxDamage_{i}"), hi.to_string());
	}
	for (k, v) in over {
		r.insert(k.to_string(), v.to_string());
	}
	r
}

fn csv(rows: &[BTreeMap<String, String>]) -> String {
	let head: Vec<&String> = rows[0].keys().collect();
	let esc = |v: &str| if v.contains([',', '"', '\n']) { format!("\"{}\"", v.replace('"', "\"\"")) } else { v.to_string() };
	let mut out = vec![head.iter().map(|h| h.as_str()).collect::<Vec<_>>().join(",")];
	for r in rows {
		out.push(head.iter().map(|h| esc(r.get(*h).map(String::as_str).unwrap_or(""))).collect::<Vec<_>>().join(","));
	}
	out.join("\n") + "\n"
}

fn rows(header: &str, lines: &[String]) -> String {
	format!("{header}\n{}\n", lines.join("\n"))
}

fn aura(i: &mut usize, spell: i64, aura: i64, base: i64, misc: i64, index: i64) -> String {
	*i += 1;
	format!("{i},{spell},0,{index},6,{aura},{base},1,{misc}")
}

fn tables(dir: &std::path::Path) {
	let items = vec![
		sparse(1482, "Shadowfang", 21, &[("ItemLevel", "24"), ("RequiredLevel", "19"), ("OverallQualityID", "3"), ("ItemDelay", "2700")], &[], &[(29, 55), (4, 8)]),
		sparse(2041, "Tunic", 5, &[("ItemLevel", "24"), ("RequiredLevel", "0"), ("Resistances_0", "92")], &[(7, 5), (3, 11)], &[]),
		sparse(16922, "Leggings", 7, &[("AllowableClass", "16"), ("MaxCount", "1"), ("Resistances_0", "101")], &[(5, 21), (6, 21), (7, 16)], &[]),
		sparse(3001, "Ring", 11, &[], &[], &[]),
		sparse(3002, "Shield", 14, &[("Resistances_0", "500")], &[], &[]),
		sparse(3003, "Monster - Sword", 13, &[("ItemDelay", "2000")], &[], &[(1, 2)]),
		sparse(3004, "Deprecated Old Belt", 6, &[], &[], &[]),
		sparse(210000, "Season Choker", 2, &[], &[], &[]),
		sparse(3005, "Shirt", 4, &[], &[], &[]),
		sparse(3006, "No Item Row", 1, &[], &[], &[]),
		sparse(3007, "Every Class", 1, &[("AllowableClass", "1503")], &[], &[]),
	];
	std::fs::write(dir.join("ItemSparse.csv"), csv(&items)).unwrap();
	let item: Vec<String> = [1482, 2041, 16922, 3001, 3002, 3003, 3004, 210000, 3005, 3007]
		.iter()
		.map(|&id: &i64| {
			format!(
				"{id},{},{}",
				if id == 1482 || id == 3003 { 2 } else { 4 },
				if id == 1482 {
					7
				} else if id == 3002 {
					6
				} else {
					1
				}
			)
		})
		.collect();
	std::fs::write(dir.join("Item.csv"), rows("ID,ClassID,SubclassID", &item)).unwrap();
	let mut n = 0;
	let effect: Vec<String> = [(2041, 1, 100), (16922, 1, 101), (16922, 1, 102), (16922, 0, 999), (3001, 1, 103), (3001, 1, 104), (3001, 1, 105), (3001, 1, 106)]
		.iter()
		.chain((107..=114).map(|s| (3002, 1, s)).collect::<Vec<_>>().iter())
		.map(|(it, t, s)| {
			n += 1;
			format!("{n},{it},{t},{s}")
		})
		.collect();
	std::fs::write(dir.join("ItemEffect.csv"), rows("ID,ParentItemID,TriggerType,SpellID", &effect)).unwrap();
	let mut i = 0;
	let spells = vec![
		aura(&mut i, 100, 99, 17, 0, 0),
		aura(&mut i, 100, 124, 17, 0, 1),
		aura(&mut i, 101, 135, 45, 126, 0),
		aura(&mut i, 102, 85, 6, 0, 0),
		aura(&mut i, 999, 99, 500, 0, 0),
		aura(&mut i, 103, 13, 11, 126, 0),
		aura(&mut i, 104, 13, 9, 4, 0),
		aura(&mut i, 105, 57, 0, 0, 0),
		aura(&mut i, 106, 55, 1, 0, 0),
		aura(&mut i, 107, 30, 6, 95, 0),
		aura(&mut i, 108, 564, 14, 0, 0),
		aura(&mut i, 109, 51, 1, 0, 0),
		aura(&mut i, 110, 22, 49, 1, 0),
		aura(&mut i, 111, 124, 9, 0, 0),
		aura(&mut i, 112, 52, 0, 0, 0),
		aura(&mut i, 113, 54, 0, 0, 0),
		aura(&mut i, 114, 161, 2, 0, 0),
	];
	std::fs::write(dir.join("SpellEffect.csv"), rows("ID,SpellID,DifficultyID,EffectIndex,Effect,EffectAura,EffectBasePoints,EffectDieSides,EffectMiscValue_0", &spells)).unwrap();
}

#[test]
fn itemdb_entries_what_is_left_out_and_the_build_offline_the_same_on_rerun() {
	let root = crate::common::scratch("itemdb");
	let cache = root.join("sources/wago/1.15.9.1");
	std::fs::create_dir_all(&cache).unwrap();
	tables(&cache);
	let mut o = Options::new(&root);
	o.sources = root.join("sources");
	o.out = root.join("Polestar_ItemDB");
	o.offline = true;
	let r = build(&o, &|_| panic!("offline: nothing is fetched")).unwrap();
	assert_eq!((r.build.as_str(), r.count), ("1.15.9.1", 6));
	assert_eq!(r.skipped.iter().map(|(k, v)| (*k, *v)).collect::<Vec<_>>(), [("name", 2), ("no-item-row", 1), ("season", 1), ("slot", 1)]);
	let lua = std::fs::read_to_string(o.out.join("Items.lua")).unwrap();
	let entries: BTreeMap<i64, String> = lua
		.lines()
		.filter_map(|l| {
			let (id, rest) = l.strip_prefix('[')?.split_once("]=\"")?;
			Some((id.parse().ok()?, rest.trim_end_matches("\",").to_string()))
		})
		.collect();
	assert_eq!(entries.keys().copied().collect::<Vec<_>>(), [1482, 2041, 3001, 3002, 3007, 16922]);
	assert_eq!(entries[&1482], "21 24 19 3 2 7 dmin33 dmax63 speed2700", "summed weapon damage over the schools");
	assert_eq!(entries[&2041], "5 24 0 2 4 1 agi11 sta5 armor92 ap18", "a melee and a ranged AP aura of one size are plain AP");
	assert_eq!(entries[&16922], "7 10 5 2 4 1 sta16 int21 spi21 armor101 heal46 mpr7 cls16 uniq1");
	assert_eq!(entries[&3001], "11 10 5 2 4 1 sp12 spFire10 spellCrit1 spellHit2");
	assert_eq!(entries[&3002], "14 10 5 2 4 6 armor550 rap10 crit1 hit1 hp5 defense7 block2 blockValue15".replace("hp5", "hpr3"));
	assert_eq!(entries[&3007], "1 10 5 2 4 1", "all nine classes: no class mask");
	for (id, s) in &entries {
		for tok in s.split(' ').skip(6) {
			let k = tok.find(|c: char| c == '-' || c.is_ascii_digit()).unwrap();
			assert!(k > 0 && tok[..k].bytes().all(|b| b.is_ascii_alphabetic()), "{tok}: letters then digits");
		}
		assert_eq!(&encode(&decode(*id as f64, s).unwrap()), s, "round trip");
	}
	assert!(lua.contains("DB.Register({ schema = 1, build = \"1.15.9.1\", count = 6 }, {\n"));
	let toc = std::fs::read_to_string(o.out.join("Polestar_ItemDB.toc")).unwrap();
	for line in ["## Interface: 16001", "## LoadOnDemand: 1", "## Dependencies: Polestar", "Items.lua"] {
		assert!(toc.lines().any(|l| l == line), "{line}");
	}
	build(&o, &|_| {}).unwrap();
	assert_eq!(std::fs::read_to_string(o.out.join("Items.lua")).unwrap(), lua, "byte-identical on rerun");
}
