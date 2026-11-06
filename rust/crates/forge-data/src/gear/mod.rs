//! `forge data gear`: the inputs of Polestar's upgrade advice -> the addon's data:
//!   addon/Polestar_ItemDB/Forever.lua      Forever's item stats over the Era table (gear/forever.rs,
//!                                          from the Forever client's tables), and which quests
//!                                          reward which gear (gear/leveling.rs, from the Codex)
//!   addon/Polestar_ItemDB/Polestar_ItemDB.toc, LICENSE-DATA.txt
//!   addon/Polestar/Gear/SpecData.lua       weight bands (Polestar + wowsims), racial traits
//!                                          (gear/racials.rs, from the Forever client's racial spells)
//!   addon/Polestar/Gear/LICENSE-DATA.txt
//!   data/forever/gear/report.json          counts and provenance (`builtAt` from Options)
//! Reads the Forever client's tables (cached wago.tools tables, the client's hotfixes over them:
//! gear/client.rs), addon/Polestar_ItemDB/Items.lua (`forge data itemdb`), the Codex's output
//! (data/forever/codex, `forge data codex`), addon/Polestar/Gear/Weights.lua and the wowsims cache.

pub mod addonlua;
pub mod client;
pub mod flb;
pub mod forever;
pub mod leveling;
pub mod racials;
pub mod specdata;
pub mod wowsims;

use std::path::{Path, PathBuf};

use forge_guide::js::{stringify, to_fixed, Arr, Obj, V};
use rustc_hash::{FxHashMap, FxHashSet};

pub const ITEMDB: &str = "Polestar_ItemDB";

pub struct Options {
	/// The checkout: addon/, package.json.
	pub root: PathBuf,
	/// The source cache (None: <root>/data/sources): wago.tools tables, hotfixes, wowsims.
	pub sources: Option<PathBuf>,
	/// data/forever (None: <root>/data/forever): the Codex under codex/, zones.json, meta.json.
	pub data: Option<PathBuf>,
	/// The Forever build (None: the newest cached holding every table; online the newest listed).
	pub build: Option<String>,
	/// The hotfix CSVs (None: <sources>/hotfix/<build> when it exists).
	pub hotfixes: Option<PathBuf>,
	/// Cached tables only.
	pub offline: bool,
	/// The wowsims cache (None: <sources>/wowsims).
	pub wowsims_cache: Option<PathBuf>,
	/// report.json builtAt (ISO 8601, as `new Date().toISOString()` prints it).
	pub built_at: String,
}

pub struct Output {
	/// Relative path (from the checkout) -> text.
	pub files: Vec<(String, String)>,
	/// report.json's value.
	pub report: V,
	/// Pack warnings and log lines (stderr in JS).
	pub warnings: Vec<String>,
	/// What `gear build` prints on stdout.
	pub summary: String,
}

/// itemdb/build.js `emitToc(version, files)`.
pub fn emit_toc(version: &str, files: &[&str]) -> String {
	let mut l: Vec<String> = vec!["## Interface: 16001".into(), "## Title: Polestar Item Data".into(), "## Notes: Item stats for Polestar's gear advice. Loaded on demand.".into()];
	l.extend(forge_guide::toc::toc_lines(ITEMDB));
	l.extend([
		"## Author: Polestar".into(),
		"## X-License: GPL-3.0-only".into(),
		format!("## Version: {version}"),
		"## Category: Polestar".into(),
		"## Group: Polestar".into(),
		"## LoadOnDemand: 1".into(),
		"## Dependencies: Polestar".into(),
		String::new(),
	]);
	l.extend(files.iter().map(|f| f.to_string()));
	l.push(String::new());
	l.join("\n")
}

/// itemdb/build.js `packageVersion()`: package.json's version, else 0.0.0.
pub fn package_version(root: &Path) -> String {
	std::fs::read_to_string(root.join("package.json"))
		.ok()
		.and_then(|t| forge_guide::js::parse_json(&t).ok())
		.map(|v| v.get("version"))
		.filter(|v| v.truthy())
		.map(|v| v.to_js_string())
		.unwrap_or_else(|| "0.0.0".into())
}

fn notice(what: &str, text: &str) -> String {
	format!("{what}\n\n{}\n", forge_guide::lexer::js_trim(text))
}

fn read_text(p: &Path) -> Result<String, String> {
	std::fs::read(p).map(|b| String::from_utf8_lossy(&b).into_owned()).map_err(|e| format!("{}: {e}", p.display()))
}

/// pfQuest's licence notice as data/forever/meta.json records it (the Codex's sources include it).
fn pfquest_notice(data: &Path) -> Option<String> {
	let meta: serde_json::Value = serde_json::from_slice(&std::fs::read(data.join("meta.json")).ok()?).ok()?;
	meta.get("sources")?.as_array()?.iter().find(|s| s.get("name").and_then(|n| n.as_str()) == Some("pfQuest"))?.get("notice")?.as_str().map(str::to_string)
}

const ITEMDB_NOTICE: &str = "Polestar_ItemDB: Items.lua and Forever.lua hold game data (c) Blizzard Entertainment, read from
the Classic Era and Forever client tables and used as facts for interoperability. Forever.lua's
quest rewards and item sources come from Polestar's Codex (`forge data codex`), built from
release-safe sources only: the client tables, QuestieDB facts (credited, used with the Questie
maintainers' agreement), pfQuest (MIT), the web quest database's per-entity Forever facts, and
Polestar's own recordings and guides. See THIRD_PARTY.md.";

/// The gear build -> the files and the report.
pub fn build(opts: &Options) -> Result<Output, String> {
	build_logged(opts, &|_| {})
}

pub fn build_logged(opts: &Options, log: &dyn Fn(&str)) -> Result<Output, String> {
	let root = &opts.root;
	let sources = opts.sources.clone().unwrap_or_else(|| root.join("data").join("sources"));
	let data = opts.data.clone().unwrap_or_else(|| root.join("data").join("forever"));
	let mut gaps: Vec<String> = Vec::new();
	let mut warnings: Vec<String> = Vec::new();
	let item_dir = root.join("addon").join(ITEMDB);
	let era_file = item_dir.join("Items.lua");
	if !era_file.exists() {
		return Err(format!("addon/{ITEMDB}/Items.lua missing: run `forge data itemdb` first"));
	}

	// 1. The Forever client's tables -> Forever's item records and racial traits.
	let t = client::load(&sources, opts.build.as_deref(), opts.hotfixes.as_deref(), opts.offline, log)?;
	warnings.extend(t.warnings.iter().cloned());
	if t.hotfix_dir.is_none() {
		gaps.push(format!("no client hotfixes for {} (sources/hotfix/{}): items the server pushed are missing", t.build, t.build));
	}
	let ex = forever::extract(&t);
	let era = leveling::read_era_items(&read_text(&era_file)?)?;
	let (overlay, ov) = forever::overlay(&ex.items, &era);
	let gear: FxHashSet<u64> = era.keys().copied().chain(ex.items.iter().map(|r| r.id as u64)).collect();
	let names: FxHashMap<u64, String> = t.get("ItemSparse").iter().map(|r| (crate::itemdb::int(r, "ID") as u64, crate::jsv::col_str(r, "Display_lang").to_string())).collect();
	let rac = racials::racials(&t);

	// 2. The Codex -> which quests reward which gear.
	let codex = leveling::Codex::read(&data)?;
	let pack = leveling::build_forever_pack(&overlay, ov, &gear, &names, &codex, &t.build)?;
	warnings.extend(pack.warnings.iter().cloned());
	let toc = emit_toc(&package_version(root), &["Items.lua", "Forever.lua"]);
	let item_licence = match pfquest_notice(&data) {
		Some(n) => format!("{ITEMDB_NOTICE}\n\n{}", notice("pfQuest:", &n)),
		None => format!("{ITEMDB_NOTICE}\n"),
	};

	// 3. wowsims (the cache only)
	let sim_cache = opts.wowsims_cache.clone().unwrap_or_else(|| sources.join("wowsims"));
	let ws = match wowsims::read_wowsims(&sim_cache) {
		Ok(w) => Some(w),
		Err(e) => {
			gaps.push(format!("wowsims: {e}; the bands are Polestar's own weights"));
			warnings.push(format!("wowsims: not used ({e})"));
			None
		}
	};

	// 4. SpecData.lua and its notices
	let authored = specdata::authored_weights(&root.join("addon").join("Polestar").join("Gear").join("Weights.lua"))?;
	let (bands, band_counts) = specdata::weight_bands(ws.as_ref(), &authored);
	let spec_data = specdata::emit_spec_data(&bands, &rac, ws.is_some(), &t.build);
	let mut parts = vec![format!("SpecData.lua: racial gear traits from the Forever client's racial spells (build {}), game data (c) Blizzard Entertainment, used as facts.\n", t.build)];
	let ws_licence = sim_cache.join(wowsims::licence_rel());
	if ws.is_some() && ws_licence.exists() {
		parts.push(notice("SpecData.lua: stat weights derived from wowsims (https://github.com/wowsims):", &read_text(&ws_licence)?));
	}
	let gear_licence = parts.join("\n");

	let report = Obj::new();
	report.set("builtAt", V::str(&opts.built_at));
	let fc = Obj::new();
	fc.set("build", V::str(&t.build));
	fc.set("hotfixes", match &t.hotfix_dir {
		Some(_) => V::Arr(Arr::from_vec(
			t.applied
				.iter()
				.map(|a| {
					let o = Obj::new();
					o.set("table", V::str(&a.table));
					o.set("replaced", V::Num(a.replaced as f64));
					o.set("added", V::Num(a.added as f64));
					o.set("deleted", V::Num(a.deleted as f64));
					V::Obj(o)
				})
				.collect(),
		)),
		None => V::Null,
	});
	fc.set("records", V::Num(ex.items.len() as f64));
	let sk = Obj::new();
	for (k, n) in &ex.skipped {
		sk.set(k, V::Num(*n as f64));
	}
	fc.set("skipped", V::Obj(sk));
	let un = Obj::new();
	for (k, n) in &ex.unmapped {
		un.set(&k.to_string(), V::Num(*n as f64));
	}
	fc.set("unmappedStatTypes", V::Obj(un));
	report.set("foreverClient", V::Obj(fc));
	let lv = Obj::new();
	lv.set("codex", V::Obj({
		let o = Obj::new();
		for k in ["build", "builtAt"] {
			if let Some(s) = codex.meta.get(k).and_then(|v| v.as_str()) {
				o.set(k, V::str(s));
			}
		}
		o
	}));
	lv.set("pack", pack.counts.to_v());
	lv.set("bytes", V::Num(pack.lua.len() as f64));
	report.set("forever", V::Obj(lv));
	let rv = Obj::new();
	for (race, traits) in &rac {
		rv.set(&race.to_string(), V::Arr(Arr::from_vec(traits.iter().map(|t| V::str(&t.name)).collect())));
	}
	report.set("racials", V::Obj(rv));
	report.set(
		"wowsims",
		match &ws {
			Some(w) => {
				let o = Obj::new();
				o.set("meta", V::Obj(w.meta.clone()));
				o.set("bands", band_counts.clone());
				o.set("rejected", V::Num(w.rejected as f64));
				V::Obj(o)
			}
			None => V::Null,
		},
	);
	report.set("specDataBytes", V::Num(spec_data.len() as f64));
	report.set("gaps", V::Arr(Arr::from_vec(gaps.iter().map(|g| V::str(g)).collect())));
	let report = V::Obj(report);
	let report_text = stringify(&report, Some("\t"));

	// The stdout of `gear build`.
	let c = &pack.counts;
	let mut summary = format!(
		"Forever client {}{}: {} item records ({} Forever-only, {} retuned from Era, {} as in Era); Codex {}: {} quests reward {} gear items; Forever.lua {} KiB\n",
		t.build,
		if t.hotfix_dir.is_some() { " with its hotfixes" } else { "" },
		ex.items.len(),
		c.overlay.new_items,
		c.overlay.retuned,
		c.overlay.unchanged,
		codex.meta.get("builtAt").and_then(|v| v.as_str()).unwrap_or("?"),
		c.quests,
		c.items,
		to_fixed(pack.lua.len() as f64 / 1024.0, 0)
	);
	summary.push_str(&format!("racial traits: {} races\n", rac.len()));
	if let Some(w) = ws.as_ref() {
		summary.push_str(&format!(
			"wowsims: {} specs, {} level bands blended with a sim, {} authored only; {} sim sets rejected\n",
			band_counts.get("specs").to_js_string(),
			band_counts.get("simBands").to_js_string(),
			band_counts.get("authoredOnly").to_js_string(),
			w.rejected
		));
	}
	summary.push_str(&format!("SpecData.lua {} KiB\n", to_fixed(spec_data.len() as f64 / 1024.0, 0)));
	for g in &gaps {
		summary.push_str(&format!("gap: {g}\n"));
	}

	Ok(Output {
		files: vec![
			(format!("addon/{ITEMDB}/Forever.lua"), pack.lua),
			(format!("addon/{ITEMDB}/{ITEMDB}.toc"), toc),
			(format!("addon/{ITEMDB}/LICENSE-DATA.txt"), item_licence),
			("addon/Polestar/Gear/SpecData.lua".into(), spec_data),
			("addon/Polestar/Gear/LICENSE-DATA.txt".into(), gear_licence),
			("data/forever/gear/report.json".into(), report_text),
		],
		report,
		warnings,
		summary,
	})
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn toc_lists_both_files() {
		let t = emit_toc("1.2.3", &["Items.lua", "Forever.lua"]);
		assert!(t.starts_with("## Interface: 16001\n## Title: Polestar Item Data\n"));
		assert!(t.ends_with("## Version: 1.2.3\n## Category: Polestar\n## Group: Polestar\n## LoadOnDemand: 1\n## Dependencies: Polestar\n\nItems.lua\nForever.lua\n"));
	}
}
