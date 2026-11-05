//! The source files the sim world reads beside data/forever (forge-world GameData): the Forever
//! client's Map and AreaTable as wago.tools CSVs, the QuestXP table, and the CMaNGOS classic-db
//! extracts (gameobject facts, graveyards, escort paths). Written under `<out>/` with the layout of
//! data/sources, so a forge build reads them without any JS-built or downloaded file.
//!
//! From the installed client (forge-gamedata) when one is given: Map.csv is byte-identical to
//! wago.tools' CSV, AreaTable.csv holds the same rows in the DB2's record order (wago lists ID 676
//! after 242), and the client's QuestXP equals Classic Era 1.15.9.70003's byte for byte, so it goes
//! where the world looks for it (game/xp.js QUESTXP_BUILD). Else copied from the wago.tools cache.

use std::path::{Path, PathBuf};

use crate::tables::Source;

/// game/xp.js QUESTXP_BUILD: where the world reads QuestXP.csv.
pub const QUESTXP_BUILD: &str = "1.15.9.70003";
const CMANGOS: [&str; 3] = ["gameobject_facts.json", "graveyards.json", "escort_paths.json"];

pub struct Output {
	/// The Forever build the CSVs are filed under.
	pub forever_build: String,
	/// Path relative to the sources folder -> bytes.
	pub files: Vec<(String, Vec<u8>)>,
}

fn version_key(b: &str) -> Vec<u64> {
	b.split('.').map(|p| p.parse().unwrap_or(0)).collect()
}

/// The newest cached Forever build (1.6x) holding Map.csv and AreaTable.csv.
fn cached_forever_build(sources: &Path) -> Option<String> {
	let wago = sources.join("wago");
	let mut ok: Vec<String> = std::fs::read_dir(&wago)
		.ok()?
		.flatten()
		.filter_map(|e| e.file_name().into_string().ok())
		.filter(|b| b.starts_with("1.6") && b.len() > 4 && b.as_bytes()[3].is_ascii_digit() && b.as_bytes()[4] == b'.')
		.filter(|b| ["Map.csv", "AreaTable.csv"].iter().all(|f| wago.join(b).join(f).is_file()))
		.collect();
	ok.sort_by_key(|b| version_key(b));
	ok.pop()
}

fn read(p: &Path) -> Result<Vec<u8>, String> {
	std::fs::read(p).map_err(|e| format!("{}: {e}", p.display()))
}

/// The sim's source files from `forever` (the installed client or the wago cache) and the CMaNGOS
/// dump or its cached extracts under `sources`.
pub fn build(sources: &Path, forever: &Source) -> Result<Output, String> {
	let mut files = Vec::new();
	let forever_build = match forever {
		Source::Client { wow, product, defs } => {
			let c = forge_gamedata::Client::open(wow, product, defs)?;
			let b = c.storage.version.clone();
			for t in ["Map", "AreaTable"] {
				files.push((format!("wago/{b}/{t}.csv"), forge_gamedata::csv::write_table(&c.table(t, "enUS")?)));
			}
			files.push((format!("wago/{QUESTXP_BUILD}/QuestXP.csv"), forge_gamedata::csv::write_table(&c.table("QuestXP", "enUS")?)));
			b
		}
		Source::Saved => {
			let b = crate::tables::newest_saved_build(sources, &crate::tables::FOREVER).ok_or_else(|| format!("no client tables saved under {}", crate::tables::saved_root(sources).display()))?;
			for t in ["Map", "AreaTable"] {
				files.push((format!("wago/{b}/{t}.csv"), read(&crate::tables::saved_root(sources).join(&b).join(format!("{t}.csv")))?));
			}
			files.push((format!("wago/{QUESTXP_BUILD}/QuestXP.csv"), read(&sources.join("wago").join(QUESTXP_BUILD).join("QuestXP.csv"))?));
			b
		}
		Source::Wago => {
			let b = cached_forever_build(sources).ok_or_else(|| format!("no cached Forever build with Map.csv and AreaTable.csv under {}", sources.join("wago").display()))?;
			for t in ["Map", "AreaTable"] {
				files.push((format!("wago/{b}/{t}.csv"), read(&sources.join("wago").join(&b).join(format!("{t}.csv")))?));
			}
			files.push((format!("wago/{QUESTXP_BUILD}/QuestXP.csv"), read(&sources.join("wago").join(QUESTXP_BUILD).join("QuestXP.csv"))?));
			b
		}
	};
	let rev = &crate::cmangos::DB_REV[..12];
	for name in CMANGOS {
		files.push((format!("cmangos/{rev}/{name}"), crate::cmangos::extract_text(sources, name)?.into_bytes()));
	}
	Ok(Output { forever_build, files })
}

/// Writes the files under `out` (each atomically).
pub fn write(out: &Path, o: &Output) -> Result<Vec<PathBuf>, String> {
	let mut written = Vec::new();
	for (rel, bytes) in &o.files {
		let file = out.join(rel);
		std::fs::create_dir_all(file.parent().unwrap()).map_err(|e| format!("{}: {e}", file.display()))?;
		let tmp = file.with_extension("tmp");
		std::fs::write(&tmp, bytes).map_err(|e| format!("{}: {e}", tmp.display()))?;
		std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
		written.push(file);
	}
	Ok(written)
}
