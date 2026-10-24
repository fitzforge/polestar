//! `forge doctor`: what Forge finds and what `forge build` would use: the game folder (and how it
//! was chosen), every build in it and every other install, Forever's quest data addon, the data
//! (a checkout's data/sources or the data pack), the table definitions, Leffe's navigation maps,
//! the walking grid and the walks backend, with the fix for anything missing.

use std::path::{Path, PathBuf};
use std::process::ExitCode;

pub(super) const USAGE: &str = "usage: forge doctor [--wow <folder>] [--forget] [--root <checkout>] [--pack <dir>] [--grid <dir>] [--leffe <dir>]

Prints what Forge finds and what `forge build` would use, with the fix for anything missing:
the game folder and how it was chosen (--wow, $POLESTAR_WOW_DIR, the remembered folder, a
search), every build in it and every other install found, Forever's quest data addon, the data
(the checkout's data/sources, else the data pack), the table definitions, Leffe's navigation
maps, the walking grid and the walks backend. Exits 1 when the build could not run.

  --wow <folder>   the game folder (remembered in the config file for later runs)
  --forget         forget the remembered game folder
  --root, --pack, --grid, --leffe   as for forge build";

/// The maps the leveling routes walk: Eastern Kingdoms, Kalimdor, Zephras Isle.
const MAPS: [u32; 3] = [0, 1, 2991];

/// The product Forge reads (the Forever client).
const PRODUCT: &str = "wow_classic_beta";

fn line(ok: bool, what: &str, text: &str) {
	println!("{} {what:<22} {text}", if ok { "ok  " } else { "MISS" });
}

/// Something optional that is missing: the build runs without it.
fn note(what: &str, text: &str) {
	println!("note {what:<22} {text}");
}

fn fix(text: &str) {
	println!("     {:<22} fix: {text}", "");
}

pub fn main() -> ExitCode {
	let args: Vec<String> = super::args().skip(1).collect();
	let val = |k: &str| args.iter().position(|a| a == k).and_then(|i| args.get(i + 1)).cloned();
	for (i, a) in args.iter().enumerate() {
		let takes = ["--wow", "--root", "--pack", "--grid", "--leffe"].contains(&a.as_str());
		let is_value = i > 0 && ["--wow", "--root", "--pack", "--grid", "--leffe"].contains(&args[i - 1].as_str());
		if !(takes || is_value || a == "--forget") {
			eprintln!("forge doctor: unexpected {a}\n{USAGE}");
			return ExitCode::from(2);
		}
	}
	let cwd = std::env::current_dir().unwrap_or_default();
	let abs = |p: String| {
		let p = PathBuf::from(p);
		if p.is_absolute() {
			p
		} else {
			cwd.join(p)
		}
	};
	let mut ready = true;

	// The config file and the remembered folder.
	if args.iter().any(|a| a == "--forget") {
		match forge_gamedata::forget_wow() {
			Ok(true) => println!("forgot the remembered game folder"),
			Ok(false) => println!("no game folder was remembered"),
			Err(e) => eprintln!("forge doctor: {e}"),
		}
	}
	if let Some(w) = val("--wow").map(abs) {
		match forge_gamedata::remember_wow(&w) {
			Ok(Some(f)) => println!("remembered {} in {}", w.display(), f.display()),
			Ok(None) => {}
			Err(e) => {
				line(false, "game folder", &e);
				return ExitCode::from(1);
			}
		}
	}

	println!("Game");
	if let Some(w) = forge::game_running_warning() {
		note("game closed", &w);
	}
	let mut client_dir: Option<PathBuf> = None;
	let found = forge_gamedata::find_install_how();
	match &found {
		Some((dir, how)) => {
			let how = match how {
				forge_gamedata::Found::Env => "from $POLESTAR_WOW_DIR",
				forge_gamedata::Found::Config => "remembered",
				forge_gamedata::Found::Search => "found by searching",
			};
			line(dir.join(".build.info").is_file(), "game folder", &format!("{} ({how})", dir.display()));
			match forge_gamedata::casc::read_build_info(dir) {
				Ok(rows) => {
					for r in &rows {
						let reads = if r.product == PRODUCT { "  <- Forge reads this one" } else { "" };
						println!("     {:<22} {} {}{}{reads}", "", r.product, r.version, if r.active { "" } else { " (inactive)" });
					}
					if !rows.iter().any(|r| r.product == PRODUCT) {
						line(false, "Forever client", &format!("no {PRODUCT} build in this folder"));
						fix("install World of Warcraft: Forever with the launcher, or pass --wow <the folder that holds it>");
						ready = false;
					} else {
						match forge_gamedata::casc::Storage::open(dir, PRODUCT) {
							Ok(s) => {
								line(true, "Forever client", &format!("{PRODUCT} {} opens", s.version));
								client_dir = Some(dir.clone());
							}
							Err(e) => {
								line(false, "Forever client", &e);
								fix("let the launcher finish installing or updating (or run its Scan and Repair)");
								ready = false;
							}
						}
					}
				}
				Err(e) => {
					line(false, "builds", &e);
					ready = false;
				}
			}
		}
		None => {
			line(false, "game folder", "not found");
			fix("pass --wow <the folder holding .build.info and Data> once (it is remembered), or set POLESTAR_WOW_DIR");
			ready = false;
		}
	}
	let chosen = found.as_ref().map(|(d, _)| d.clone());
	let others: Vec<PathBuf> = forge_gamedata::search_installs().into_iter().filter(|d| Some(d) != chosen.as_ref()).collect();
	for d in &others {
		println!("     {:<22} also installed: {}", "", d.display());
	}
	match (forge_gamedata::config_file(), forge_gamedata::remembered_wow()) {
		(Some(f), Some(w)) => println!("     {:<22} config {} remembers {}", "", f.display(), w.display()),
		(Some(f), None) => println!("     {:<22} config {} (no folder remembered; --wow remembers one)", "", f.display()),
		(None, _) => {}
	}
	match forge_data::questie::detect_questie() {
		Some(q) => line(true, "Forever's quest data", &q.display().to_string()),
		None => {
			note("Forever's quest data", "the addon is not installed in a Forever client: forge builds without it, with fewer quest facts");
			fix("install the quest data addon (QuestieDB) in your Forever client's AddOns folder");
		}
	}

	println!("Data");
	let root = val("--root").map(abs).or_else(|| cwd.ancestors().find(|d| d.join("data/sources").is_dir()).map(Path::to_path_buf));
	let pack_dir = val("--pack").map(abs).or_else(forge::fetch::default_pack_dir);
	let pack_ok = pack_dir.as_ref().is_some_and(|d| d.join(forge::pack::MANIFEST).is_file());
	let data_root = match (&root, &pack_dir) {
		(Some(r), _) if r.join("data/sources").is_dir() => {
			line(true, "data", &format!("the checkout's data/sources ({})", r.display()));
			Some(r.clone())
		}
		(_, Some(p)) if pack_ok => {
			line(true, "data", &format!("the data pack {}", p.display()));
			Some(p.clone())
		}
		_ => {
			line(false, "data", "no checkout with data/sources here and no data pack");
			fix(&format!(
				"run from inside a Polestar checkout with data/sources, or forge data fetch (into {}) once a public data pack is published",
				pack_dir.as_ref().map_or("--dest <dir>".into(), |p| p.display().to_string())
			));
			ready = false;
			None
		}
	};
	if pack_ok && root.as_ref().is_some_and(|r| r.join("data/sources").is_dir()) {
		println!("     {:<22} the data pack {} is there too (used without a checkout)", "", pack_dir.as_ref().unwrap().display());
	}
	if let Some(r) = &data_root {
		let defs = r.join("data/sources/wowdbdefs/definitions");
		line(defs.is_dir(), "table definitions", &defs.display().to_string());
		if !defs.is_dir() {
			fix("check out the table definitions (WoWDBDefs) into data/sources/wowdbdefs");
			ready = false;
		}
	}

	// Is the install complete for the continents the grid is built for? (Needs the table
	// definitions for Map.)
	let mut incomplete = false;
	if let (Some(dir), Some(r)) = (&client_dir, &data_root) {
		let defs = r.join("data/sources/wowdbdefs");
		if defs.join("definitions").is_dir() {
			let mut maps = forge::grid_continents(&r.join("data/forever"), None);
			if maps.is_empty() {
				maps = MAPS.to_vec();
			}
			let t = std::time::Instant::now();
			match forge_gamedata::Client::open(dir, PRODUCT, &defs).and_then(|c| forge_gamedata::completeness::check(&c, Some(&maps))) {
				Ok(rep) if rep.complete() => {
					line(true, "install complete", &format!("every file of the continents is in the archives ({} files, {:.1} s)", rep.files_checked, t.elapsed().as_secs_f64()))
				}
				Ok(rep) => {
					incomplete = true;
					let n: usize = rep.maps.iter().map(|m| m.missing.len()).sum();
					line(false, "install complete", &format!("no: {n} files of the continents are not in the archives:"));
					for l in rep.lines() {
						println!("     {:<22}   {l}", "");
					}
					fix(forge_gamedata::completeness::FIX);
					println!("     {:<22} (the data still builds; the grid stage refuses this install unless --allow-incomplete)", "");
				}
				Err(e) => line(false, "install complete", &format!("could not check: {e}")),
			}
		}
	}

	println!("Walks");
	let leffe = forge::find_leffe(val("--leffe").map(abs).as_deref(), pack_dir.as_deref());
	match &leffe {
		Some(l) => line(true, "Leffe's maps", &l.display().to_string()),
		None => {
			note("Leffe's maps", "not found: walks are priced on our grid alone");
			fix("--leffe <dir> or POLESTAR_LEFFE_NAV=<dir>");
		}
	}
	let given = val("--grid").map(abs).or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from));
	match (&given, &client_dir) {
		(Some(g), _) => {
			let ok = g.join("index.json").is_file();
			line(ok, "walking grid", &format!("{} (given)", g.display()));
			if !ok {
				fix("give a built grid (its index.json), or leave --grid out and forge build builds one from the client");
				ready = false;
			}
		}
		(None, Some(_)) if incomplete => {
			line(false, "walking grid", "forge build builds it from the client into <out>/grid, but refuses this incomplete install");
			fix("run Scan and Repair in the launcher, or pass --allow-incomplete to forge build (the grid is then wrong where files are missing)");
			ready = false;
		}
		(None, Some(_)) => line(true, "walking grid", "forge build builds it from the client into <out>/grid (kept while the client's build is unchanged)"),
		(None, None) => {
			let grid_root = root.clone().or_else(|| data_root.clone()).unwrap_or_else(|| cwd.clone());
			let grid = forge::grid_dir(None, &grid_root);
			let ok = grid.join("index.json").is_file();
			line(ok, "walking grid", &format!("{} (no client to build one)", grid.display()));
			if !ok {
				fix("install the game (forge build then builds the grid), or --grid <a built grid>");
				ready = false;
			}
		}
	}
	line(true, "walks backend", if leffe.is_some() { "hybrid (Leffe's maps first, our grid where they have no way)" } else { "grid" });

	println!();
	if ready {
		println!("forge build can run.");
		ExitCode::SUCCESS
	} else {
		println!("forge build cannot run yet: see the fixes above.");
		ExitCode::from(1)
	}
}
