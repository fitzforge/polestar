//! The Forever client's tables the gear data reads: the cached wago.tools tables of one build, with
//! the rows the server pushed over them (the client's hotfix cache, DBCache.bin) applied on top.
//!
//! The hotfixes are read from CSVs that `forge gamedata hotfix --table <T> --status all --out
//! <sources>/hotfix/<build>/<T>.csv` writes (RecordID, Status, PushID, then the table's columns).
//! Per record the entry with the highest PushID counts: valid (1) replaces or adds the row, deleted
//! (2) removes it, removed (3) and not public (4) leave the shipped row.

use std::path::{Path, PathBuf};

use rustc_hash::FxHashMap;

use crate::jsv::{Row, Rows};

/// Item stats: ItemSparse, Item, the equip spells (ItemEffect, ItemXItemEffect, SpellEffect) and the
/// tables the client computes stats, armor and weapon damage from.
pub const ITEM_TABLES: [&str; 15] = [
	"ItemSparse",
	"Item",
	"ItemEffect",
	"ItemXItemEffect",
	"SpellEffect",
	"RandPropPoints",
	"ItemArmorQuality",
	"ItemArmorShield",
	"ItemArmorTotal",
	"ArmorLocation",
	"ItemDamageOneHand",
	"ItemDamageTwoHand",
	"ItemDamageRanged",
	"ItemDamageThrown",
	"ItemDamageWand",
];
/// Racial traits: the racial skill lines' passive spells and their weapon limits.
pub const RACIAL_TABLES: [&str; 4] = ["SkillLine", "SkillLineAbility", "SpellName", "SpellEquippedItems"];

pub fn all_tables() -> Vec<&'static str> {
	ITEM_TABLES.iter().chain(RACIAL_TABLES.iter()).copied().collect()
}

/// What the hotfix cache changed in one table.
#[derive(Default, Clone, Debug, PartialEq, Eq)]
pub struct Applied {
	pub table: String,
	pub replaced: usize,
	pub added: usize,
	pub deleted: usize,
}

pub struct Tables {
	pub build: String,
	pub tables: FxHashMap<&'static str, Rows>,
	/// The hotfix folder read (None: none found), and what it changed per table.
	pub hotfix_dir: Option<PathBuf>,
	pub applied: Vec<Applied>,
	pub warnings: Vec<String>,
}

impl Tables {
	pub fn get(&self, t: &str) -> &Rows {
		static EMPTY: Rows = Vec::new();
		self.tables.get(t).unwrap_or(&EMPTY)
	}
}

fn num(r: &Row, c: &str) -> i64 {
	crate::itemdb::int(r, c)
}

/// Applies one table's hotfix rows (`hot`, as `forge gamedata hotfix` writes them) to `rows`.
pub fn apply_hotfixes(table: &str, rows: &mut Rows, hot: &Rows) -> Applied {
	let mut latest: FxHashMap<i64, &Row> = FxHashMap::default();
	for r in hot {
		let id = num(r, "RecordID");
		match latest.get(&id) {
			Some(p) if num(p, "PushID") > num(r, "PushID") => {}
			_ => {
				latest.insert(id, r);
			}
		}
	}
	let mut at: FxHashMap<i64, usize> = rows.iter().enumerate().map(|(i, r)| (num(r, "ID"), i)).collect();
	let mut out = Applied { table: table.to_string(), ..Applied::default() };
	let mut gone: Vec<usize> = Vec::new();
	let mut ids: Vec<i64> = latest.keys().copied().collect();
	ids.sort_unstable();
	for id in ids {
		let h = latest[&id];
		match num(h, "Status") {
			1 => {
				let mut row: Row = h.iter().filter(|(k, _)| !matches!(k.as_str(), "RecordID" | "Status" | "PushID")).map(|(k, v)| (k.clone(), v.clone())).collect();
				row.insert("ID".into(), id.to_string());
				match at.get(&id) {
					Some(&i) => {
						rows[i] = row;
						out.replaced += 1;
					}
					None => {
						at.insert(id, rows.len());
						rows.push(row);
						out.added += 1;
					}
				}
			}
			2 => {
				if let Some(&i) = at.get(&id) {
					gone.push(i);
					out.deleted += 1;
				}
			}
			_ => {}
		}
	}
	gone.sort_unstable();
	for i in gone.into_iter().rev() {
		rows.remove(i);
	}
	out
}

/// The Forever build's tables (`build`: that build, None: the newest cached one holding every table,
/// online the newest wago.tools lists), with the hotfixes in `hotfix_dir` (None: `<sources>/hotfix/<build>`
/// when it exists).
pub fn load(sources: &Path, build: Option<&str>, hotfix_dir: Option<&Path>, offline: bool, log: &dyn Fn(&str)) -> Result<Tables, String> {
	let names = all_tables();
	let (build, loaded, warnings) = crate::sources::client_tables(sources, &crate::tables::FOREVER, build, &names, offline, log)?;
	let mut tables: FxHashMap<&'static str, Rows> = FxHashMap::default();
	for (n, rows) in loaded {
		if let Some(&k) = names.iter().find(|k| **k == n) {
			tables.insert(k, rows);
		}
	}
	let dir = match hotfix_dir {
		Some(d) => Some(d.to_path_buf()),
		None => Some(sources.join("hotfix").join(&build)).filter(|d| d.is_dir()),
	};
	let mut applied = Vec::new();
	if let Some(d) = &dir {
		if !d.is_dir() {
			return Err(format!("{}: no such hotfix folder", d.display()));
		}
		for &t in &names {
			let f = d.join(format!("{t}.csv"));
			if !f.exists() {
				continue;
			}
			let text = std::fs::read_to_string(&f).map_err(|e| format!("{}: {e}", f.display()))?;
			let hot = crate::tables::parse_csv(&text)?;
			let rows = tables.get_mut(t).ok_or_else(|| format!("{t}: not loaded"))?;
			applied.push(apply_hotfixes(t, rows, &hot));
		}
	}
	Ok(Tables { build, tables, hotfix_dir: dir, applied, warnings })
}

#[cfg(test)]
mod tests {
	use super::*;

	fn row(kv: &[(&str, &str)]) -> Row {
		kv.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	#[test]
	fn hotfixes_replace_add_and_delete_rows_by_their_latest_push() {
		let mut rows = vec![row(&[("ID", "1"), ("X", "a")]), row(&[("ID", "2"), ("X", "b")]), row(&[("ID", "3"), ("X", "c")])];
		let hot = vec![
			row(&[("RecordID", "1"), ("Status", "1"), ("PushID", "5"), ("ID", "0"), ("X", "old")]),
			row(&[("RecordID", "1"), ("Status", "1"), ("PushID", "9"), ("ID", "0"), ("X", "new")]),
			row(&[("RecordID", "2"), ("Status", "2"), ("PushID", "3"), ("ID", "0"), ("X", "")]),
			row(&[("RecordID", "3"), ("Status", "3"), ("PushID", "4"), ("ID", "0"), ("X", "gone")]),
			row(&[("RecordID", "7"), ("Status", "1"), ("PushID", "4"), ("ID", "0"), ("X", "added")]),
		];
		let a = apply_hotfixes("T", &mut rows, &hot);
		assert_eq!(a, Applied { table: "T".into(), replaced: 1, added: 1, deleted: 1 });
		let got: Vec<(String, String)> = rows.iter().map(|r| (r["ID"].clone(), r["X"].clone())).collect();
		assert_eq!(got, vec![("1".into(), "new".into()), ("3".into(), "c".into()), ("7".into(), "added".into())]);
	}
}
