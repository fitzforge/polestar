//! The client tables the travel planner is built from (port of tools/lib/travel/sources.js,
//! offline): cached wago.tools CSVs under <sources>/wago/<build>/<Table>.csv, the newest cached
//! build of the product holding every table unless one is given.

use std::path::Path;

use indexmap::IndexMap;

use crate::jsv::Rows;
use crate::tables::{compare_versions, parse_csv, table_url};

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Product {
	Era,
	Forever,
	Transit,
}

pub const TABLES: &[&str] = &["TaxiNodes", "TaxiPath", "TaxiPathNode", "AreaTrigger"];
pub const FOREVER_TABLES: &[&str] = &["TaxiPathNode"];
pub const TRANSIT_TABLES: &[&str] = &["TransportAnimation", "SpellEffect", "SpellName", "SpellMisc", "SpellCastTimes", "SpellReagents", "SkillLineAbility"];

impl Product {
	fn key(self) -> &'static str {
		match self {
			Product::Era => "wow_classic_era",
			_ => "wow_classic_beta",
		}
	}
	fn tables(self) -> &'static [&'static str] {
		match self {
			Product::Era => TABLES,
			Product::Forever => FOREVER_TABLES,
			Product::Transit => TRANSIT_TABLES,
		}
	}
	/// era `^1\.1[0-5]\.`, forever `^1\.6\d\.`.
	fn family(self, b: &str) -> bool {
		let s = b.as_bytes();
		if s.len() < 5 || &s[..2] != b"1." || s[4] != b'.' {
			return false;
		}
		match self {
			Product::Era => s[2] == b'1' && (b'0'..=b'5').contains(&s[3]),
			_ => s[2] == b'6' && s[3].is_ascii_digit(),
		}
	}
}

fn columns(table: &str) -> &'static [&'static str] {
	match table {
		"TaxiNodes" => &["ID", "Name_lang", "Pos_0", "Pos_1", "ContinentID", "Flags", "CharacterBitNumber"],
		"TaxiPath" => &["ID", "FromTaxiNode", "ToTaxiNode", "Cost"],
		"TaxiPathNode" => &["PathID", "NodeIndex", "ContinentID", "Loc_0", "Loc_1", "Loc_2", "Flags", "Delay"],
		"AreaTrigger" => &["ID", "ContinentID", "Pos_0", "Pos_1", "Pos_2"],
		"TransportAnimation" => &["TransportID", "TimeIndex", "Pos_0", "Pos_1", "Pos_2"],
		"SpellEffect" => &["SpellID", "DifficultyID", "Effect", "ImplicitTarget_1"],
		"SpellName" => &["ID", "Name_lang"],
		"SpellMisc" => &["SpellID", "DifficultyID", "CastingTimeIndex"],
		"SpellCastTimes" => &["ID", "Base"],
		"SpellReagents" => &["SpellID", "Reagent_0", "ReagentCount_0"],
		"SkillLineAbility" => &["Spell", "ClassMask"],
		_ => &[],
	}
}

fn check_columns(table: &str, rows: &Rows, at: &str) -> Result<(), String> {
	if rows.is_empty() {
		return Err(format!("{at}: {table} has no rows"));
	}
	let missing: Vec<&str> = columns(table).iter().copied().filter(|c| !rows[0].contains_key(*c)).collect();
	if !missing.is_empty() {
		return Err(format!("{at}: {table} lacks column(s) {}", missing.join(", ")));
	}
	Ok(())
}

/// BUILD_RE `^\d+(\.\d+)+$`.
fn is_build(b: &str) -> bool {
	let parts: Vec<&str> = b.split('.').collect();
	parts.len() >= 2 && parts.iter().all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_digit()))
}

pub struct Loaded {
	pub build: String,
	pub tables: IndexMap<&'static str, Rows>,
	pub urls: IndexMap<&'static str, String>,
	pub warnings: Vec<String>,
}

impl Loaded {
	pub fn rows(&self, t: &str) -> &Rows {
		&self.tables[t]
	}
}

/// loadTravelTables, offline.
pub fn load_travel_tables(sources: &Path, build: Option<&str>, product: Product) -> Result<Loaded, String> {
	let cache_root = sources.join("wago");
	let chosen = match build {
		Some(b) => b.to_string(),
		None => {
			let mut cached: Vec<String> = std::fs::read_dir(&cache_root).map(|rd| rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).collect()).unwrap_or_default();
			cached.retain(|b| is_build(b) && product.family(b) && product.tables().iter().all(|t| cache_root.join(b).join(format!("{t}.csv")).exists()));
			cached.sort_by(|a, b| compare_versions(a, b));
			cached.pop().ok_or_else(|| format!("--offline: no cached {} build with {} under {}", product.key(), product.tables().join(", "), cache_root.display()))?
		}
	};
	if !is_build(&chosen) {
		return Err(format!("travel sources: \"{chosen}\" is not a build version"));
	}
	let dir = cache_root.join(&chosen);
	let mut tables = IndexMap::new();
	let mut urls = IndexMap::new();
	for &t in product.tables() {
		let file = dir.join(format!("{t}.csv"));
		urls.insert(t, table_url(t, &chosen));
		if !file.exists() {
			return Err(format!("--offline: missing cached {}", file.display()));
		}
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		let rows = parse_csv(&text).map_err(|e| format!("{}: {e}", file.display()))?;
		check_columns(t, &rows, &file.display().to_string())?;
		tables.insert(t, rows);
	}
	Ok(Loaded { build: chosen, tables, urls, warnings: Vec::new() })
}
