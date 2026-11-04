//! `gear build` (tools/lib/gear/build.js): the inputs of Polestar's upgrade advice -> the addon's
//! data, byte for byte as `node tools/polestar.js gear build` writes it:
//!   addon/Polestar_ItemDB/Forever.lua      ForeverLevelingBiS: Forever item stats over the Era
//!                                          table, quest reward choices
//!   addon/Polestar_ItemDB/Polestar_ItemDB.toc, LICENSE-DATA.txt
//!   addon/Polestar/Gear/SpecData.lua       weight bands (Polestar + wowsims), racials
//!   addon/Polestar/Gear/LICENSE-DATA.txt
//!   data/forever/gear/report.json          counts and provenance (`builtAt` from Options)
//! Reads the installed ForeverLevelingBiS, addon/Polestar_ItemDB/Items.lua (`forge data itemdb`),
//! addon/Polestar/Gear/Weights.lua and the wowsims cache (data/sources/wowsims). Offline.

pub mod addonlua;
pub mod flb;
pub mod leveling;
pub mod specdata;
pub mod wowsims;

use std::path::{Path, PathBuf};

use forge_guide::js::{stringify, to_fixed, Arr, Obj, V};

pub const ITEMDB: &str = "Polestar_ItemDB";

pub struct Options {
	/// The checkout: addon/, package.json, data/sources/wowsims.
	pub root: PathBuf,
	/// The client's Interface/AddOns (None: detected, as tools/lib/addons.js resolveAddonsDir).
	pub addons: Option<PathBuf>,
	/// The wowsims cache (None: <root>/data/sources/wowsims).
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

/// The AddOns folder: the given one (if a folder), else the first detected.
fn resolve_addons_dir(explicit: Option<&Path>) -> Option<PathBuf> {
	match explicit {
		Some(p) => p.is_dir().then(|| std::path::absolute(p).unwrap_or_else(|_| p.to_path_buf())),
		None => crate::questie::search_addons_dirs().into_iter().next(),
	}
}

/// buildGear -> the files and the report.
pub fn build(opts: &Options) -> Result<Output, String> {
	let root = &opts.root;
	let mut gaps: Vec<String> = Vec::new();
	let mut warnings: Vec<String> = Vec::new();
	let item_dir = root.join("addon").join(ITEMDB);
	let era_file = item_dir.join("Items.lua");
	if !era_file.exists() {
		return Err(format!("addon/{ITEMDB}/Items.lua missing: run `forge data itemdb` first"));
	}

	// 1. ForeverLevelingBiS -> Polestar_ItemDB/Forever.lua
	let addons_root = resolve_addons_dir(opts.addons.as_deref());
	let flb_dir = addons_root.clone().unwrap_or_default().join(flb::ADDON);
	let flb = flb::read_forever_leveling_bis(&flb_dir)?;
	let pack = leveling::build_forever_pack(&flb, &read_text(&era_file)?)?;
	warnings.extend(pack.warnings.iter().cloned());
	let toc = emit_toc(&package_version(root), &["Items.lua", "Forever.lua"]);
	let flb_licence = read_text(&flb_dir.join("LICENSE"))?;
	let item_licence = notice("Forever.lua holds facts derived from ForeverLevelingBiS by Thunder:", &flb_licence);

	// 2. wowsims (the cache only)
	let sim_cache = opts.wowsims_cache.clone().unwrap_or_else(|| root.join("data").join("sources").join("wowsims"));
	let ws = match wowsims::read_wowsims(&sim_cache) {
		Ok(w) => Some(w),
		Err(e) => {
			gaps.push(format!("wowsims: {e}; the bands are Polestar's own weights"));
			warnings.push(format!("wowsims: not used ({e})"));
			None
		}
	};

	// 3. SpecData.lua and its notices
	let authored = specdata::authored_weights(&root.join("addon").join("Polestar").join("Gear").join("Weights.lua"))?;
	let (bands, band_counts) = specdata::weight_bands(ws.as_ref(), &authored);
	let spec_data = specdata::emit_spec_data(&bands, &specdata::racials(&flb.racials), ws.is_some(), &flb.meta.get("version"));
	let mut parts = vec![notice("SpecData.lua: racial gear traits derived from ForeverLevelingBiS by Thunder:", &flb_licence)];
	let ws_licence = sim_cache.join(wowsims::licence_rel());
	if ws.is_some() && ws_licence.exists() {
		parts.push(notice("SpecData.lua: stat weights derived from wowsims (https://github.com/wowsims):", &read_text(&ws_licence)?));
	}
	let gear_licence = parts.join("\n");

	let report = Obj::new();
	report.set("builtAt", V::str(&opts.built_at));
	let fm = Obj::new();
	for (k, v) in flb.meta.entries() {
		fm.set_str(k, v);
	}
	fm.set("pack", pack.counts.to_v());
	fm.set("bytes", V::Num(pack.lua.len() as f64));
	report.set("foreverLevelingBiS", V::Obj(fm.clone()));
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
		"ForeverLevelingBiS {} (data {}): {} items ({} Forever-only, {} retuned from Era, {} as in Era), {} quests; Forever.lua {} KiB\n",
		fm.get("version").to_js_string(),
		fm.get("generated").to_js_string(),
		c.items,
		c.new_items,
		c.retuned,
		c.unchanged,
		c.quests,
		to_fixed(pack.lua.len() as f64 / 1024.0, 0)
	);
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
