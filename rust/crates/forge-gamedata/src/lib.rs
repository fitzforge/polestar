//! The installed WoW client's own tables, read locally: CASC storage (`casc`), BLTE (`blte`),
//! DB2 WDC3-5 (`db2`) typed by WoWDBDefs definitions read at runtime (`dbd`), and CSV the way
//! wago.tools exports it (`csv`). Read-only on the game folder; nothing of Blizzard's is
//! shipped or cached by this crate.
//! The client's local caches of what the server sent it are read too: the WDB quest, creature
//! and gameobject caches (`wdb`) and the DBCache.bin hotfix rows (`hotfix`).
//!
//! ```no_run
//! let client = forge_gamedata::Client::open(
//! 	&forge_gamedata::find_install().unwrap(), "wow_classic_beta", "data/sources/wowdbdefs".as_ref()).unwrap();
//! let areas = client.table("AreaTable", "enUS").unwrap();
//! let name = areas.column("AreaName_lang").unwrap();
//! for r in 0..areas.rows() {
//! 	let _ = areas.str(&areas.row(r)[name]);
//! }
//! ```

pub mod blte;
pub mod casc;
pub mod completeness;
pub mod csv;
pub mod db2;
pub mod dbd;
pub mod hotfix;
pub mod wdb;

use std::path::{Path, PathBuf};

use rustc_hash::FxHashMap;

pub use casc::Storage;
pub use db2::{Column, Table, Value};
pub use dbd::Build;

/// One product's installed build plus the WoWDBDefs checkout that types its tables.
pub struct Client {
	pub storage: Storage,
	pub build: Build,
	defs: PathBuf,
	/// Table name -> DB2 fileDataID (WoWDBDefs `manifest.json`).
	pub manifest: FxHashMap<String, u32>,
}

impl Client {
	/// `install`: the World of Warcraft folder (holding `.build.info` and `Data/`); `product`:
	/// e.g. `wow_classic_beta` or `wowf`; `wowdbdefs`: a WoWDBDefs checkout (with
	/// `definitions/` and `manifest.json`).
	pub fn open(install: &Path, product: &str, wowdbdefs: &Path) -> Result<Client, String> {
		let storage = Storage::open(install, product)?;
		let build = Build::parse(&storage.version).ok_or_else(|| format!("{product}: unreadable version {:?}", storage.version))?;
		let manifest = dbd::manifest(&wowdbdefs.join("manifest.json"))?;
		Ok(Client { storage, build, defs: wowdbdefs.join("definitions"), manifest })
	}

	/// The DB2 fileDataID of a table.
	pub fn fdid(&self, table: &str) -> Result<u32, String> {
		self.manifest.get(table).copied().ok_or_else(|| format!("{table}: not in WoWDBDefs manifest.json (no DB2 fileDataID)"))
	}

	/// The raw DB2 bytes of a table (and the TACT keys of chunks left zero-filled).
	pub fn db2_bytes(&self, table: &str, locale: &str) -> Result<blte::Decoded, String> {
		let flag = casc::locale_flag(locale).ok_or_else(|| format!("unknown locale {locale}"))?;
		let fdid = self.fdid(table)?;
		let s = &self.storage;
		let ckey = s.ckey_of(fdid, flag).ok_or_else(|| format!("{table}: fileDataID {fdid} is not in the {} {} root", s.product, s.version))?;
		let ekey = s.ekey_of(&ckey).ok_or_else(|| format!("{table}: content key {} is not in the encoding file", casc::hex(&ckey)))?;
		if !s.has_ekey(&ekey) {
			return Err(format!("{table} ({locale}): fileDataID {fdid} is not in the local storage (is the {locale} text locale installed?)"));
		}
		s.read_ckey(&ckey).map_err(|e| format!("{table}: {e}"))
	}

	/// A table decoded with the WoWDBDefs definition for its layout and this build.
	pub fn table(&self, table: &str, locale: &str) -> Result<Table, String> {
		let decoded = self.db2_bytes(table, locale)?;
		let dbd = dbd::Dbd::load(&self.defs, table)?;
		let layout = db2::layout_hash(&decoded.data).map_err(|e| format!("{table}: {e}"))?;
		let def = dbd.select(layout, Some(self.build)).ok_or_else(|| format!("{table}: no WoWDBDefs definition for layout {layout:08X} or build {}", self.build))?;
		let mut t = db2::read(decoded.data, def).map_err(|e| format!("{table}: {e}"))?;
		if !decoded.encrypted.is_empty() {
			t.notes.push(format!("BLTE chunks encrypted with TACT key(s) {} left zero-filled", decoded.encrypted.join(", ")));
		}
		Ok(t)
	}

	/// The WoWDBDefs definition of `table` for `build` (for rows without a layout hash, such as
	/// hotfixes, typed by the build that wrote them).
	pub fn definition(&self, table: &str, build: Build) -> Result<dbd::Definition, String> {
		let dbd = dbd::Dbd::load(&self.defs, table)?;
		dbd.for_build(build).cloned().ok_or_else(|| format!("{table}: no WoWDBDefs definition lists build {build}"))
	}

	/// Table hash -> table name (WoWDBDefs `manifest.json`).
	pub fn table_hashes(&self) -> Result<FxHashMap<u32, String>, String> {
		let root = self.defs.parent().unwrap_or(&self.defs);
		dbd::table_hashes(&root.join("manifest.json"))
	}

	/// Every table WoWDBDefs knows with a fileDataID in this build's root, sorted by name.
	pub fn tables(&self) -> Vec<(&str, u32)> {
		let wanted: rustc_hash::FxHashSet<u32> = self.manifest.values().copied().collect();
		let mut present = rustc_hash::FxHashSet::default();
		self.storage.each_root_entry(|fdid, _, _| {
			if wanted.contains(&fdid) {
				present.insert(fdid);
			}
		});
		let mut v: Vec<(&str, u32)> = self.manifest.iter().filter(|(_, f)| present.contains(f)).map(|(n, &f)| (n.as_str(), f)).collect();
		v.sort_unstable();
		v
	}
}

/// Wine prefix roots under the home folder (as tools/lib/addons.js searches them).
const PREFIX_ROOTS: &[&str] = &[
	".wine",
	"Games",
	"Faugus",
	".local/share/wineprefixes",
	".local/share/lutris/prefixes",
	".local/share/bottles/bottles",
	".var/app/com.usebottles.bottles/data/bottles/bottles",
	".local/share/Steam/steamapps/compatdata",
	".steam/steam/steamapps/compatdata",
	".var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata",
];
const WOW_DIRS: &[&str] = &["Program Files (x86)/World of Warcraft", "Program Files/World of Warcraft", "Games/World of Warcraft", "World of Warcraft"];

/// How [`find_install`] chose the World of Warcraft folder.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Found {
	/// `$POLESTAR_WOW_DIR`
	Env,
	/// the folder remembered in the config file ([`config_file`])
	Config,
	/// the first install found by searching ([`search_installs`])
	Search,
}

/// The World of Warcraft folder: `$POLESTAR_WOW_DIR`, else the one remembered in the config file
/// (a command given `--wow` remembers it, [`remember_wow`]), else the first install found by
/// [`search_installs`].
pub fn find_install() -> Option<PathBuf> {
	find_install_how().map(|(p, _)| p)
}

/// [`find_install`] and how the folder was chosen.
pub fn find_install_how() -> Option<(PathBuf, Found)> {
	if let Some(d) = std::env::var_os("POLESTAR_WOW_DIR") {
		return Some((PathBuf::from(d), Found::Env));
	}
	if let Some(d) = remembered_wow().filter(|d| d.join(".build.info").is_file()) {
		return Some((d, Found::Config));
	}
	search_installs().into_iter().next().map(|d| (d, Found::Search))
}

/// Every World of Warcraft folder with a `.build.info`: the Wine prefixes under the home folder
/// (the places tools/lib/addons.js looks), then the native installs (`C:\Program Files (x86)\World
/// of Warcraft`, `/Applications/World of Warcraft`), in that order, each once.
pub fn search_installs() -> Vec<PathBuf> {
	let ok = |p: &Path| p.join(".build.info").is_file();
	let mut out: Vec<PathBuf> = Vec::new();
	let mut seen: Vec<PathBuf> = Vec::new();
	let mut push = |d: PathBuf| {
		if !ok(&d) {
			return;
		}
		// The same install reached through a symlinked prefix is listed once.
		let real = d.canonicalize().unwrap_or_else(|_| d.clone());
		if !seen.contains(&real) {
			seen.push(real);
			out.push(d);
		}
	};
	let home = std::env::var_os("HOME").or_else(|| std::env::var_os("USERPROFILE")).map(PathBuf::from);
	if let Some(home) = home {
		for root in PREFIX_ROOTS {
			let root = home.join(root);
			if !root.is_dir() {
				continue;
			}
			let mut prefixes = vec![root.clone(), root.join("pfx")];
			if let Ok(rd) = std::fs::read_dir(&root) {
				let mut kids: Vec<PathBuf> = rd.filter_map(|e| e.ok()).map(|e| e.path()).filter(|p| p.is_dir()).collect();
				kids.sort();
				for k in kids {
					prefixes.push(k.join("pfx"));
					prefixes.insert(prefixes.len() - 1, k);
				}
			}
			for p in prefixes {
				for w in WOW_DIRS {
					push(p.join("drive_c").join(w));
				}
			}
		}
	}
	for d in ["C:\\Program Files (x86)\\World of Warcraft", "/Applications/World of Warcraft"] {
		push(PathBuf::from(d));
	}
	out
}

/// Forge's config file: `$POLESTAR_FORGE_CONFIG`, else `polestar-forge/config.toml` in the user's
/// config folder (`$XDG_CONFIG_HOME` or `~/.config` on Linux, `~/Library/Application Support` on
/// macOS, `%APPDATA%` on Windows). None when no home folder is known.
pub fn config_file() -> Option<PathBuf> {
	if let Some(f) = std::env::var_os("POLESTAR_FORGE_CONFIG") {
		return Some(PathBuf::from(f));
	}
	let var = |k: &str| std::env::var_os(k).filter(|v| !v.is_empty()).map(PathBuf::from);
	let dir = if cfg!(windows) {
		var("APPDATA")
	} else if cfg!(target_os = "macos") {
		var("HOME").map(|h| h.join("Library").join("Application Support"))
	} else {
		var("XDG_CONFIG_HOME").or_else(|| var("HOME").map(|h| h.join(".config")))
	}?;
	Some(dir.join("polestar-forge").join("config.toml"))
}

/// The `wow = "<folder>"` line of the config file, if any.
pub fn remembered_wow() -> Option<PathBuf> {
	let text = std::fs::read_to_string(config_file()?).ok()?;
	text.lines().find_map(|l| {
		let (k, v) = l.split_once('=')?;
		(k.trim() == "wow").then(|| PathBuf::from(unquote(v.trim())))
	})
}

fn unquote(v: &str) -> String {
	match v.strip_prefix('"').and_then(|x| x.strip_suffix('"')) {
		Some(inner) => inner.replace("\\\"", "\"").replace("\\\\", "\\"),
		None => v.to_string(),
	}
}

/// Remembers `wow` (a folder holding `.build.info`) in the config file, keeping its other lines.
/// -> the config file written, or None when it already held that folder.
pub fn remember_wow(wow: &Path) -> Result<Option<PathBuf>, String> {
	if !wow.join(".build.info").is_file() {
		return Err(format!("{}: no .build.info (not a World of Warcraft folder)", wow.display()));
	}
	let wow = wow.canonicalize().unwrap_or_else(|_| wow.to_path_buf());
	if remembered_wow().as_deref() == Some(wow.as_path()) {
		return Ok(None);
	}
	let file = config_file().ok_or("no config folder (no home folder)")?;
	let old = std::fs::read_to_string(&file).unwrap_or_default();
	let path = wow.display().to_string().replace('\\', "\\\\").replace('"', "\\\"");
	let mut lines: Vec<String> = old.lines().filter(|l| l.split_once('=').is_none_or(|(k, _)| k.trim() != "wow")).map(String::from).collect();
	lines.push(format!("wow = \"{path}\""));
	if let Some(dir) = file.parent() {
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	}
	std::fs::write(&file, format!("{}\n", lines.join("\n"))).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(Some(file))
}

/// Removes the remembered folder from the config file. -> whether one was remembered.
pub fn forget_wow() -> Result<bool, String> {
	let Some(file) = config_file() else { return Ok(false) };
	let Ok(old) = std::fs::read_to_string(&file) else { return Ok(false) };
	let kept: Vec<&str> = old.lines().filter(|l| l.split_once('=').is_none_or(|(k, _)| k.trim() != "wow")).collect();
	if kept.len() == old.lines().count() {
		return Ok(false);
	}
	std::fs::write(&file, if kept.is_empty() { String::new() } else { format!("{}\n", kept.join("\n")) }).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(true)
}

/// The client folder of `product` in `install` (`_classic_beta_` for wow_classic_beta,
/// `_forever_` for wowf): the `_<name>_` folder whose `.flavor.info` names the product.
pub fn flavor_dir(install: &Path, product: &str) -> Result<PathBuf, String> {
	let rd = std::fs::read_dir(install).map_err(|e| format!("{}: {e}", install.display()))?;
	let mut dirs: Vec<PathBuf> = rd.filter_map(|e| e.ok()).map(|e| e.path()).filter(|p| p.file_name().and_then(|n| n.to_str()).is_some_and(|n| n.starts_with('_') && n.ends_with('_'))).collect();
	dirs.sort();
	dirs.into_iter()
		.find(|d| std::fs::read_to_string(d.join(".flavor.info")).is_ok_and(|t| t.lines().map(str::trim).rfind(|l| !l.is_empty()) == Some(product)))
		.ok_or_else(|| format!("{}: no client folder whose .flavor.info names {product}", install.display()))
}
