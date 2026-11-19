//! Build-time item facts from the tracked Polestar_ItemDB files.

use std::collections::BTreeMap;
use std::io::ErrorKind;
use std::path::Path;

use forge_guide::js::{str_to_num, Obj, V};
use rustc_hash::FxHashMap;

use crate::factions::ALL_CLASSES;
use crate::gear::leveling::{read_item_rows, Rec};
use crate::jsv::to_int32;

use super::client::ClientFacts;

// Normalized ItemDB token, Forever ItemStatType code, and (for client-only
// alternatives) the canonical code that takes precedence if both are listed.
// Fallback spell codes follow the token amounts: equal sp and heal give 45;
// otherwise heal gives 41 and sp gives 42. In the client overlap, 762 equal
// pairs have 45 as their only spell-power code, and 128 unequal pairs have 41
// and 42. Forever's splpwr token supplies both amounts; spldmg and splheal
// supply them independently (gear/flb.rs). `armor` includes base armor.
// Fractions below are items with both token and code / items with the token,
// among 3,688 Codex items with client codes and a selected ItemDB row
// (Forever.lua over Items.lua, 1.60.1.70938).
// Names and semantics are from wowdbdefs/meta/enums/ItemStatType.dbde. Gear's
// ItemDB decoder normalizes on-disk mpr/hpr to mp5/hp5 before this mapping.
const STAT_CODES: &[(&str, i64, Option<i64>)] = &[
	("mana", 0, None),        // Era extractor item_mod
	("health", 1, None),      // Era extractor item_mod
	("agi", 3, None),         // Era extractor item_mod
	("str", 4, None),         // Era extractor item_mod
	("int", 5, None),         // Era extractor item_mod
	("spi", 6, None),         // Era extractor item_mod
	("sta", 7, None),         // Era extractor item_mod
	("defense", 12, None),    // 98/98
	("dodge", 13, None),      // 45/47
	("parry", 14, None),      // 8/9
	("block", 15, None),      // 11/11; only 6 also have 48
	("hit", 31, None),        // 113/113
	("spellHit", 31, None),   // 39/39
	("crit", 32, None),       // 249/249
	("spellCrit", 32, None),  // 121/121
	("ap", 38, None),         // Era extractor item_mod
	("rap", 39, None),        // 16/16
	("heal", 41, None),       // 223/1057
	("sp", 42, Some(45)),     // 134/964
	("mp5", 43, None),        // 191/203
	("sp", 45, None),         // 764/964
	("hp5", 46, None),        // 25/27
	("blockValue", 48, None), // 9/9; flat in both ItemDB and Forever
	("spHoly", 84, None),     // 18/18
	("spFire", 85, None),     // 45/45
	("spNature", 86, None),   // 6/8
	("spFrost", 87, None),    // 75/75
	("spShadow", 88, None),   // 49/50
	("spArcane", 89, None),   // 22/22
];

// Presence-only: 13–15, 31–32, 36–37, 47, 50–56, 83, 90–92, 96, 98, 112–115,
// 117, 119, 121, 124, 127, 128, 131, 132, 135, 136. The first five codes use
// ItemDB tokens for fallback presence; their ItemDB amounts are percentages,
// while Forever uses combat rating points (Gear.lua). Defense (12) is 1:1.
// The other codes have no mapped ItemDB token and come from the client.
const ITEMDB_PRESENCE_ONLY: &[i64] = &[13, 14, 15, 31, 32];

#[derive(Default)]
pub struct ItemDb {
	forever: FxHashMap<u64, Rec>,
	era: FxHashMap<u64, Rec>,
}

impl ItemDb {
	pub(crate) fn load(root: &Path, warnings: &mut Vec<String>) -> Result<Self, String> {
		let mut read = |file| {
			let path = format!("addon/Polestar_ItemDB/{file}");
			let text = match std::fs::read_to_string(root.join(&path)) {
				Ok(text) => text,
				Err(e) if e.kind() == ErrorKind::NotFound => {
					warnings.push(format!("{path}: missing, skipping Codex item fallback from this file"));
					return Ok(FxHashMap::default());
				}
				Err(e) => return Err(format!("{path}: {e}")),
			};
			read_table(&path, &text, warnings)
		};
		Ok(Self { forever: read("Forever.lua")?, era: read("Items.lua")? })
	}

	pub(crate) fn fill(&self, items: &Obj, client: Option<&ClientFacts>) {
		for item in items.values() {
			let id = item.get("id").num() as u64;
			let entry = self.forever.get(&id).map(|rec| ("forever", rec)).or_else(|| self.era.get(&id).map(|rec| ("era", rec)));
			if let Some((source, rec)) = entry {
				if !item.has("levelsSource") {
					item.set("levelsSource", source);
					item.set("reqLevel", rec.req.clone());
					item.set("itemLevel", rec.ilvl.clone());
					item.set("quality", rec.quality.clone());
					let mask = rec.allow.num();
					item.set("allowClass", if mask == 0.0 { ALL_CLASSES } else { to_int32(mask) & ALL_CLASSES });
				}
				if !item.has("typeSource") {
					item.set("typeSource", source);
					item.set("itemClass", rec.cls.clone());
					item.set("itemSubclass", rec.sub.clone());
					item.set("slot", rec.inv.clone());
				}
			}
			let codes = client.and_then(|client| client.items.get(&(id as i64))).map_or(&[][..], |item| &item.stat_codes);
			fill_stats(item, codes, entry);
		}
	}
}

// JSON: `stats` maps raw codes to signed amounts, with 0 for presence only.
// An omitted stats map is empty when levelsSource is set, unknown otherwise.
// All known amounts on one item come from the same selected ItemDB row, so
// `statAmountSource` applies to its nonzero amounts only.
fn fill_stats(item: V, client_codes: &[i64], entry: Option<(&str, &Rec)>) {
	let levels = item.get("levelsSource");
	let Some(levels) = levels.as_str() else { return };
	let from_client = levels == "client";
	let mut amounts: BTreeMap<i64, f64> = BTreeMap::new();
	if let Some((_, rec)) = entry {
		let stat = |token: &str| rec.stats.iter().find(|(key, _)| key == token).map(|(_, amount)| *amount);
		let sp = stat("sp");
		let combined_spell_power = !from_client && sp.is_some() && sp == stat("heal");
		for &(token, code, canonical) in STAT_CODES {
			let selected = if from_client {
				client_codes.contains(&code) && !canonical.is_some_and(|code| client_codes.contains(&code))
			} else {
				match code {
					41 | 42 => !combined_spell_power,
					45 => combined_spell_power,
					_ => true,
				}
			};
			if !selected {
				continue;
			}
			if let Some(amount) = stat(token) {
				amounts.insert(code, if ITEMDB_PRESENCE_ONLY.contains(&code) { 0.0 } else { amount });
			}
		}
	}
	if from_client {
		for &code in client_codes {
			amounts.entry(code).or_insert(0.0);
		}
	}
	if amounts.is_empty() {
		return;
	}
	let stats = Obj::new();
	let mut has_amount = false;
	for (code, amount) in amounts {
		has_amount |= amount != 0.0;
		stats.set(&code.to_string(), amount);
	}
	item.set("stats", stats);
	if let Some((source, _)) = entry.filter(|_| has_amount) {
		item.set("statAmountSource", source);
	}
}

fn read_table(path: &str, text: &str, warnings: &mut Vec<String>) -> Result<FxHashMap<u64, Rec>, String> {
	// Both generated tables close with `})` on its own line. Forever.lua then
	// registers leveling names, sources and quests, which share the same row syntax.
	let (table, _) = text.split_once("DB.Register(").and_then(|(_, body)| body.split_once("\n})")).ok_or_else(|| format!("{path}: missing DB.Register item table"))?;
	let mut skipped = 0;
	let mut first_id = None;
	let rows = read_item_rows(table, |id, row| {
		let mut parts = row.split(' ');
		if (0..6).all(|_| parts.next().is_some_and(|part| !part.trim().is_empty() && str_to_num(part).is_finite())) {
			return true;
		}
		skipped += 1;
		first_id.get_or_insert_with(|| id.to_owned());
		false
	})
	.map_err(|e| format!("{path}: {e}"))?;
	if let Some(id) = first_id {
		warnings.push(format!("{path}: skipped {skipped} item row(s) with invalid positional fields (first id: {id})"));
	}
	Ok(rows)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::codex::client::ClientItem;
	use forge_guide::js::parse_json;

	#[test]
	fn pins_itemdb_stat_codes_and_client_only_alternatives() {
		let mapped: Vec<_> = STAT_CODES.iter().map(|&(token, code, _)| format!("{token}={code}")).collect();
		assert_eq!(
			mapped.join(" "),
			"mana=0 health=1 agi=3 str=4 int=5 spi=6 sta=7 defense=12 dodge=13 parry=14 block=15 hit=31 spellHit=31 crit=32 spellCrit=32 ap=38 rap=39 heal=41 sp=42 mp5=43 sp=45 hp5=46 blockValue=48 spHoly=84 spFire=85 spNature=86 spFrost=87 spShadow=88 spArcane=89"
		);
		assert_eq!(STAT_CODES.iter().filter(|(_, _, canonical)| canonical.is_some()).copied().collect::<Vec<_>>(), [("sp", 42, Some(45))]);
		assert_eq!(ITEMDB_PRESENCE_ONLY, [13, 14, 15, 31, 32]);
	}

	#[test]
	fn fills_stat_coverage_and_amounts_from_the_selected_itemdb_row() {
		let db = ItemDb::load(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.."), &mut Vec::new()).unwrap();
		let items = parse_json(
			r#"{
				"862":{"id":862},
				"888":{"id":888},
				"1155":{"id":1155},
				"2271":{"id":2271},
				"6911":{"id":6911},
				"16947":{"id":16947},
			"19019":{"id":19019,"levelsSource":"client"},
			"17142":{"id":17142,"levelsSource":"client"},
				"19431":{"id":19431,"levelsSource":"client"},
				"19862":{"id":19862},
			"20257":{"id":20257},
			"20134":{"id":20134},
			"647":{"id":647},
			"4294967295":{"id":4294967295}
		}"#,
		)
		.unwrap();
		let mut client = ClientFacts::default();
		for (id, codes) in [(19019, vec![3, 7, 51, 55]), (17142, vec![32, 36]), (19431, vec![12, 15, 48])] {
			client.items.insert(id, ClientItem { stat_codes: codes, ..Default::default() });
		}
		db.fill(items.as_obj().unwrap(), Some(&client));
		let mut mismatches = Vec::new();
		let mut check = |id, levels, source, expected: &[(i64, f64)]| {
			let item = items.get(id);
			assert_eq!(item.get("levelsSource").as_str(), levels, "{id}");
			let amount_source = item.get("statAmountSource");
			let stats = item.get("stats");
			let stats_match = if expected.is_empty() {
				stats.is_nullish()
			} else {
				stats.as_obj().is_some_and(|row| row.keys().len() == expected.len() && expected.iter().all(|(code, amount)| row.get(&code.to_string()).as_num() == Some(*amount)))
			};
			if !stats_match || amount_source.as_str() != source {
				let expected_stats = Obj::new();
				for &(code, amount) in expected {
					expected_stats.set(&code.to_string(), amount);
				}
				mismatches.push(format!("{id}: {stats:?} ({amount_source:?}), expected {:?} ({source:?})", V::Obj(expected_stats)));
			}
		};
		check("862", Some("era"), Some("era"), &[(45, 7.0)]);
		check("888", Some("forever"), Some("forever"), &[(4, 4.0), (7, 4.0), (41, 15.0), (42, 5.0)]);
		check("1155", Some("forever"), Some("forever"), &[(6, 11.0), (45, 32.0)]);
		check("2271", Some("era"), Some("era"), &[(6, 3.0), (7, 2.0), (41, 24.0)]);
		check("6911", Some("forever"), Some("forever"), &[(7, 5.0), (42, 12.0)]);
		check("16947", Some("era"), Some("era"), &[(5, 24.0), (6, 12.0), (7, 20.0), (32, 0.0), (41, 27.0), (42, 9.0)]);
		check("19019", Some("client"), Some("forever"), &[(3, 5.0), (7, 8.0), (51, 0.0), (55, 0.0)]);
		check("17142", Some("client"), None, &[(32, 0.0), (36, 0.0)]);
		check("19431", Some("client"), Some("era"), &[(12, 13.0), (15, 0.0), (48, 24.0)]);
		check("19862", Some("era"), Some("era"), &[(12, 7.0), (15, 0.0), (48, 30.0)]);
		check("20257", Some("era"), Some("era"), &[(4, 10.0), (5, 9.0), (7, 9.0), (32, 0.0), (43, 7.0)]);
		check("20134", Some("era"), Some("era"), &[(4, 13.0), (6, 12.0), (7, 14.0), (32, 0.0)]);
		check("647", Some("era"), None, &[]);
		check("4294967295", None, None, &[]);
		assert!(mismatches.is_empty(), "{}", mismatches.join("\n"));
	}

	#[test]
	fn itemdb_ratings_keep_presence_without_amounts() {
		let row = crate::gear::leveling::decode(1.0, "1 20 15 2 4 1 dodge1 parry2 block3 hit1 spellHit1 crit2 spellCrit2").unwrap();
		let codes = [13, 14, 15, 31, 32];
		for levels in ["client", "forever", "era"] {
			let item = V::Obj(Obj::new());
			item.set("levelsSource", levels);
			let client_codes = if levels == "client" { &codes[..] } else { &[] };
			fill_stats(item.clone(), client_codes, Some(("era", &row)));
			let stats = item.get("stats");
			assert_eq!(codes.map(|code| stats.get(&code.to_string()).as_num()), [Some(0.0); 5], "{levels}");
			assert!(item.get("statAmountSource").is_nullish(), "{levels}");
		}
	}

	#[test]
	fn skips_itemdb_row_with_non_numeric_positional_part() {
		let path = "addon/Polestar_ItemDB/Forever.lua";
		let text = r#"DB.Register(nil, {
[744]="19 invalid 0 2 9 0",
[3456]="12 30 25 3 4 0",
})"#;
		let mut warnings = Vec::new();
		let rows = read_table(path, text, &mut warnings).unwrap();
		assert_eq!(rows.len(), 1);
		assert!(rows.contains_key(&3456));
		assert_eq!(warnings, [format!("{path}: skipped 1 item row(s) with invalid positional fields (first id: 744)")]);
	}
}
