//! Build-time item facts from the tracked Polestar_ItemDB files.

use std::io::ErrorKind;
use std::path::Path;

use forge_guide::js::{str_to_num, Obj};
use rustc_hash::FxHashMap;

use crate::factions::ALL_CLASSES;
use crate::gear::leveling::{read_item_rows, Rec};
use crate::jsv::to_int32;

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

	pub(crate) fn fill(&self, items: &Obj) {
		for item in items.values() {
			let id = item.get("id").num() as u64;
			let Some((source, rec)) = self.forever.get(&id).map(|rec| ("forever", rec)).or_else(|| self.era.get(&id).map(|rec| ("era", rec))) else { continue };
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
	use super::read_table;

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
