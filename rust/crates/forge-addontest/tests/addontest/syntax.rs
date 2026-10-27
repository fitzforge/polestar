//! Static checks over every addon folder: each Lua file compiles under Lua 5.1, writes no globals outside the
//! allowlist, and is loaded by a manifest; every manifest reference exists.

use forge_addontest::luac::globals_written;
use forge_addontest::run::{addons_dir, root, toc_entries, xml_files};
use regex::Regex;
use std::collections::HashSet;
use std::fs;
use std::path::{Path, PathBuf};

const ALLOWED_GLOBAL: &str = r"^(Polestar|PolestarDB|PolestarCharDB|PolestarRecorderDB|PolestarRecorderCharDB|PolestarRecorderAck|PolestarRecorder_Command|Polestar_NavEngine|PolestarPathData|PolestarNavChokepoints|SLASH_POLESTAR\d+|SLASH_POLESTARREC\d+|SLASH_POLESTARWAY\d+|BINDING_HEADER_POLESTAR|BINDING_NAME_POLESTAR_\w+)$";

// Globals one file may write: the TomTom stand-in owns `TomTom` while TomTom is not installed; the walking
// router's cost table is `Polestar_NavCosts` (tools and the eval harness read it).
fn file_globals(rel: &str) -> &'static [&'static str] {
	match rel {
		"addon/Polestar/Nav/Journey.lua" => &["TomTom"],
		"addon/Polestar_Nav/Routing/Costs.lua" => &["Polestar_NavCosts"],
		_ => &[],
	}
}

fn walk(dir: &Path, ext: &str) -> Vec<PathBuf> {
	let mut entries: Vec<_> = fs::read_dir(dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())).map(|e| e.unwrap()).collect();
	entries.sort_by_key(|e| e.file_name());
	let mut out = Vec::new();
	for entry in entries {
		let p = entry.path();
		if entry.file_type().unwrap().is_dir() {
			out.extend(walk(&p, ext));
		} else if entry.file_name().to_string_lossy().to_lowercase().ends_with(ext) {
			out.push(p);
		}
	}
	out
}

fn addon_dirs() -> Vec<PathBuf> {
	let mut entries: Vec<_> = fs::read_dir(addons_dir()).unwrap().map(|e| e.unwrap()).collect();
	entries.sort_by_key(|e| e.file_name());
	entries.into_iter().filter(|e| e.file_type().unwrap().is_dir()).map(|e| e.path()).collect()
}

fn lua_files() -> Vec<PathBuf> {
	addon_dirs().iter().flat_map(|d| walk(d, ".lua")).collect()
}

/// A path relative to the checkout root, with `/` separators.
fn rel(p: &Path) -> String {
	let r = p.strip_prefix(root()).unwrap_or(p);
	r.components().map(|c| c.as_os_str().to_string_lossy().into_owned()).collect::<Vec<_>>().join("/")
}

#[test]
fn every_addon_lua_file_compiles_under_lua_5_1() {
	let failures: Vec<String> = lua_files().iter().filter_map(|f| globals_written(f).err()).collect();
	assert_eq!(failures, Vec::<String>::new());
}

#[test]
fn addon_code_only_writes_allowlisted_globals() {
	let allowed = Regex::new(ALLOWED_GLOBAL).unwrap();
	let mut violations: Vec<String> = Vec::new();
	for file in lua_files() {
		let r = rel(&file);
		let own = file_globals(&r);
		for name in globals_written(&file).unwrap_or_default() {
			if !allowed.is_match(&name) && !own.contains(&name.as_str()) {
				let v = format!("{r}: {name}");
				if !violations.contains(&v) {
					violations.push(v);
				}
			}
		}
	}
	assert_eq!(violations, Vec::<String>::new());
}

fn loaded_files(dir: &Path, problems: &mut Vec<String>) -> Result<HashSet<PathBuf>, String> {
	let mut loaded = HashSet::new();
	for entry in toc_entries(dir)? {
		let target = dir.join(entry.replace('\\', "/"));
		if !target.exists() {
			problems.push(format!("{}: TOC lists missing {entry}", rel(dir)));
			continue;
		}
		if target.to_string_lossy().to_lowercase().ends_with(".xml") {
			loaded.insert(target.clone());
			for f in xml_files(&target)? {
				loaded.insert(f);
			}
		} else {
			loaded.insert(target);
		}
	}
	Ok(loaded)
}

#[test]
fn manifests_reference_existing_files_and_load_every_lua_file() {
	let mut problems = Vec::new();
	for dir in addon_dirs() {
		let loaded = match loaded_files(&dir, &mut problems) {
			Ok(l) => l,
			Err(e) => {
				problems.push(e);
				continue;
			}
		};
		for file in walk(&dir, ".lua") {
			if !loaded.contains(&file) {
				problems.push(format!("{} is not loaded by any manifest", rel(&file)));
			}
		}
	}
	assert_eq!(problems, Vec::<String>::new());
}
