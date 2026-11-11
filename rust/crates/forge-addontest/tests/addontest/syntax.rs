//! Static checks over every addon folder: each Lua file compiles under Lua 5.1, writes no globals outside the
//! allowlist, and is loaded by a manifest; every manifest reference exists.

use forge_addontest::luac::globals_written;
use forge_addontest::run::{addons_dir, root, toc_entries, xml_files};
use regex::Regex;
use std::collections::HashSet;
use std::fs;
use std::path::{Path, PathBuf};

const ALLOWED_GLOBAL: &str = r"^(Polestar|PolestarDB|PolestarCharDB|PolestarRecorderDB|PolestarRecorderCharDB|PolestarRecorderAck|PolestarClientInfo|PolestarRecorder_Command|Polestar_NavEngine|PolestarPathData|PolestarNavChokepoints|SLASH_POLESTAR\d+|SLASH_POLESTARREC\d+|SLASH_POLESTARWAY\d+|SLASH_POLESTAR_RL\d+|BINDING_TAG_POLESTAR|BINDING_NAME_POLESTAR_\w+)$";

// Globals one file may write: the TomTom stand-in owns `TomTom` while TomTom is not installed; the walking
// router's cost table is `Polestar_NavCosts` (tools and the eval harness read it); the addon compartment
// calls the handlers the .toc names (`AddonCompartmentFunc` and friends), which must be globals.
fn file_globals(rel: &str) -> &'static [&'static str] {
	match rel {
		"addon/Polestar/Nav/Journey.lua" => &["TomTom"],
		"addon/Polestar_Nav/Routing/Costs.lua" => &["Polestar_NavCosts"],
		"addon/Polestar/Maps/MinimapButton.lua" => &["Polestar_OnAddonCompartmentClick", "Polestar_OnAddonCompartmentEnter", "Polestar_OnAddonCompartmentLeave"],
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

// Lua 5.1 caps a chunk at 200 locals in scope at once; a file at the cap fails to load the moment a merge adds one
// more top-level local. Every file's main chunk keeps 10 spare (at most 190).
const MAIN_LOCALS_MAX: usize = 190;
// UI/GuideFrame.lua (198) is replaced by the 0.3.8 settings split; drop it from here when that lands.
const MAIN_LOCALS_EXEMPT: &[&str] = &["addon/Polestar/UI/GuideFrame.lua"];

/// The most locals a file's main chunk holds in scope at once: 200 less the most extra locals declared ahead of
/// it that still compile.
fn main_chunk_locals(src: &[u8]) -> usize {
	let lua = mlua::Lua::new();
	let fits = |extra: usize| {
		let mut prefixed = if extra == 0 { Vec::new() } else { format!("local {}; ", (0..extra).map(|i| format!("_x{i}")).collect::<Vec<_>>().join(",")).into_bytes() };
		prefixed.extend_from_slice(src);
		lua.load(&prefixed[..]).into_function().is_ok()
	};
	assert!(fits(0), "the file must compile");
	let (mut lo, mut hi) = (0, 200); // fits(lo); the answer lies in lo..hi
	while lo < hi {
		let mid = (lo + hi + 1) / 2;
		if fits(mid) {
			lo = mid;
		} else {
			hi = mid - 1;
		}
	}
	200 - lo
}

#[test]
fn every_addon_lua_files_main_chunk_keeps_spare_locals() {
	let mut over = Vec::new();
	for file in lua_files() {
		let r = rel(&file);
		if MAIN_LOCALS_EXEMPT.contains(&r.as_str()) {
			continue;
		}
		let n = main_chunk_locals(&fs::read(&file).unwrap());
		if n > MAIN_LOCALS_MAX {
			over.push(format!("{r}: {n} locals in its main chunk (at most {MAIN_LOCALS_MAX}: group some into a table)"));
		}
	}
	assert_eq!(over, Vec::<String>::new());
}

#[test]
fn the_main_chunk_locals_count_is_the_most_in_scope_at_once() {
	let decls = |n: usize| (0..n).map(|i| format!("local a{i} = {i}\n")).collect::<String>();
	assert_eq!(main_chunk_locals(decls(185).as_bytes()), 185);
	assert_eq!(main_chunk_locals(format!("do\n{}end\n{}", decls(150), decls(100)).as_bytes()), 150);
	assert_eq!(main_chunk_locals(b"local function f() local a, b, c = 1, 2, 3 end"), 1);
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
