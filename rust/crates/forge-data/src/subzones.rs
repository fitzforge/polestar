//! `forge data subzones`: the subzone names of the walking maps' areas in each client language,
//! Subzones.lua in the language folders addon/Polestar_<locale> (beside Names.lua; docs/ARCHITECTURE.md,
//! "Names"). The runtime side: Polestar.Names' kind "subzone" (addon/Polestar/Core/Names.lua), which the
//! arrow's floor by subzone reads (addon/Polestar/Nav/Walk.lua, named).
//!
//! A walking map's area (maps format 3: Polestar_Nav's `areaNames`, `forge nav pack`) is a WMOAreaTable
//! row, and the walking maps name it as the client names the subzone there, in English: the row's
//! AreaName, else the AreaTable name of its AreaTableID (forge-navbuild's geom::Tables::from_csv). The
//! client tells addons only that name, in its own language (GetSubZoneText), and no Lua API names a
//! WMOAreaTable row, so this writes each row's name by the same rule from the Forever client's own
//! WMOAreaTable and AreaTable in each language (wago.tools, &locale=, cached as `forge data names` caches
//! its tables), for the rows whose name there is not the English one the walking maps carry (the runtime's
//! fallback). The tables are [`BUILD`]'s, the build the data is built from: a data folder that names
//! another one stops the build rather than have names from another client build.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_guide::i18n_files::lua_string;
use forge_guide::locales::locale as locale_info;
use rustc_hash::FxHashMap;

use crate::jsv::{col_num, col_str, Rows};
use crate::lua::lua_to_value;
use crate::names_sources::cached_table;
use crate::sources::Http;

pub const COMMAND: &str = "forge data subzones";
/// The file in each language folder.
pub const FILE: &str = "Subzones.lua";
/// The Polestar.Names kind the file fills.
pub const KIND: &str = "subzone";
/// The Forever client build of the tables: the one the data is built from, the build data/forever's
/// meta.json names in its client tables source (data_pin; tests/data/subzones.rs holds the two equal). The
/// walking maps' rows (from the 1.60.1.70532 grid) are all in it, named alike in English and every language.
pub const BUILD: &str = "1.60.1.70888";
/// The client tables read (`forge data sources --only builders` caches them in English).
pub const TABLES: [&str; 2] = ["WMOAreaTable", "AreaTable"];

/// The walking maps' areas collected from their metadata files.
const AREAS: &str = r#"
local out = {}
for _, d in pairs(PolestarPathData or {}) do
  if type(d) == "table" and type(d.areaNames) == "table" then
    for id, name in pairs(d.areaNames) do
      if type(id) == "number" and type(name) == "string" then out[#out + 1] = { id, name } end
    end
  end
end
return out"#;

/// A walking map's metadata file: Nav<map>.lua (its parts are Nav<map>_<n>.lua).
fn is_meta(file: &str) -> bool {
	file.strip_prefix("Nav").and_then(|f| f.strip_suffix(".lua")).is_some_and(|m| !m.is_empty() && m.bytes().all(|b| b.is_ascii_digit()))
}

/// The walking maps' areas: each WMOAreaTable row id their metadata (Nav<map>.lua in `nav`, the folder
/// addon/Polestar_Nav/Nav) names in `areaNames`, with that English name. An error when no map has one.
pub fn walking_areas(nav: &Path) -> Result<BTreeMap<i64, String>, String> {
	let rd = std::fs::read_dir(nav).map_err(|e| format!("{}: {e}", nav.display()))?;
	let mut files: Vec<PathBuf> = rd.flatten().filter(|e| is_meta(&e.file_name().to_string_lossy())).map(|e| e.path()).collect();
	files.sort();
	let refs: Vec<&Path> = files.iter().map(PathBuf::as_path).collect();
	let mut out = BTreeMap::new();
	for pair in lua_to_value(&refs, "", AREAS)?.items() {
		let p = pair.items();
		if let (Some(id), Some(name)) = (p.first().and_then(|v| v.as_num()), p.get(1).and_then(|v| v.as_str())) {
			out.insert(id as i64, name.to_string());
		}
	}
	if out.is_empty() {
		return Err(format!("no walking map in {} names its areas (areaNames): pack them with `forge nav pack` first", nav.display()));
	}
	Ok(out)
}

/// Each WMOAreaTable row's subzone name as the client shows it there: the row's AreaName, else the
/// AreaTable name of its AreaTableID, untrimmed (GetSubZoneText's text); rows with neither are left out.
pub fn subzone_names(wmo: &Rows, areas: &Rows) -> BTreeMap<i64, String> {
	let area: FxHashMap<i64, &str> = areas.iter().filter(|r| col_num(r, "ID") > 0.0).map(|r| (col_num(r, "ID") as i64, col_str(r, "AreaName_lang"))).collect();
	let mut out = BTreeMap::new();
	for r in wmo {
		let id = col_num(r, "ID");
		if !(id > 0.0) {
			continue;
		}
		let own = col_str(r, "AreaName_lang");
		let name = if own.is_empty() { area.get(&(col_num(r, "AreaTableID") as i64)).copied().unwrap_or("") } else { own };
		if !name.is_empty() {
			out.insert(id as i64, name.to_string());
		}
	}
	out
}

/// One language's names: the walking maps' rows whose name in `names` (subzone_names of that language) is
/// not their English one.
pub fn translated(areas: &BTreeMap<i64, String>, names: &BTreeMap<i64, String>) -> BTreeMap<i64, String> {
	areas.iter().filter_map(|(id, en)| names.get(id).filter(|n| *n != en).map(|n| (*id, n.clone()))).collect()
}

/// One language's Subzones.lua: LuaChunks text (forge-core luachunks) of "<id>\t<name>" lines, the name
/// luachunks::field-escaped, registered through Polestar.Names.AddChunk with the language's locale under
/// the kind "subzone", as Names.lua registers its kinds (names::names_lua). `sources`: what the header
/// names as its sources.
pub fn subzones_lua(locale: &str, names: &BTreeMap<i64, String>, sources: &str) -> Result<String, String> {
	use forge_core::luachunks;
	let language = locale_info(locale).ok_or_else(|| format!("unknown locale {locale}"))?.language;
	let mut out = format!(
		"{}\n-- The subzone names of the walking maps' areas in {language} ({locale}), for Polestar.Names' kind \"{KIND}\"\n-- (addon/Polestar/Core/Names.lua), which the arrow's floor by subzone reads (addon/Polestar/Nav/Walk.lua):\n-- one a line, \"<WMOAreaTable row id>\\t<name>\" (% ; , : | tab and line breaks as %XX), the rows whose name\n-- here is not the English one Polestar_Nav's walking maps carry. Names of the game belong to Blizzard\n-- Entertainment.\n\nlocal N = Polestar and Polestar.Names\nif not (N and N.AddChunk) then return end\nlocal function R(kind, lo, hi, text) N.AddChunk({}, kind, lo, hi, text) end\n",
		forge_guide::emit::header("lua", COMMAND, sources),
		lua_string(locale)
	);
	let records: Vec<(i64, String)> = names.iter().map(|(id, n)| (*id, luachunks::field(n))).collect();
	for c in luachunks::chunks(&records, luachunks::Options::default()) {
		out.push_str(&format!("R({}, {}, {}, {})\n", lua_string(KIND), c.lo, c.hi, luachunks::long_string(&c.text)));
	}
	Ok(out)
}

pub struct Options {
	/// The checkout (package.json, addon/Polestar/Polestar.toc).
	pub root: PathBuf,
	pub locales: Vec<String>,
	pub offline: bool,
	/// The client build of the tables ([`BUILD`]).
	pub build: String,
	pub sources: PathBuf,
	/// The data whose client build the tables must be (data/forever).
	pub data: PathBuf,
	/// The walking maps' metadata (addon/Polestar_Nav/Nav).
	pub nav: PathBuf,
	pub out: PathBuf,
}

impl Options {
	/// The defaults under `root`, every locale.
	pub fn new(root: &Path) -> Options {
		Options {
			root: root.to_path_buf(),
			locales: forge_guide::locales::LOCALE_CODES.map(String::from).to_vec(),
			offline: false,
			build: BUILD.to_string(),
			sources: root.join("data/sources"),
			data: root.join("data/forever"),
			nav: root.join("addon/Polestar_Nav/Nav"),
			out: root.join("addon"),
		}
	}
}

pub struct Written {
	pub locale: String,
	/// Its rows named in its language (0: no file).
	pub names: usize,
	pub bytes: usize,
}

pub struct Report {
	pub build: String,
	/// The walking maps' areas.
	pub areas: usize,
	/// The areas whose English name in the build is not the walking maps'.
	pub english_differs: usize,
	pub written: Vec<Written>,
}

/// The Forever client build the data in `data` is built from: the build in the revision of its meta.json's
/// "World of Warcraft: Forever client tables" source (as the guide compile's pinned-build check reads it);
/// None when the data names none (or there is no data).
pub fn data_pin(data: &Path) -> Option<String> {
	let doc: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(data.join("meta.json")).ok()?).ok()?;
	let src = doc["sources"].as_array()?.iter().find(|s| s["name"].as_str().is_some_and(|n| n.starts_with("World of Warcraft: Forever client tables")))?;
	let rev = src["revision"].as_str()?;
	rev.split(|c: char| !(c.is_ascii_digit() || c == '.')).find(|w| crate::tables::is_build(w)).map(str::to_string)
}

pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<Report, String> {
	for l in &o.locales {
		if locale_info(l).is_none() {
			return Err(format!("unknown locale {l} (one of {})", forge_guide::locales::LOCALE_CODES.join(", ")));
		}
	}
	let build = o.build.as_str();
	if let Some(pin) = data_pin(&o.data) {
		if pin != build {
			return Err(format!(
				"the data ({}) is built from Forever client build {pin}, and the subzone names would come from {build}: the names must be the client's of the data's build. Set subzones::BUILD to {pin} (its test holds it to the data's), or rebuild the data",
				o.data.display()
			));
		}
	}
	let areas = walking_areas(&o.nav)?;
	let http = (!o.offline).then(Http::default_agent);
	let read = |locale: Option<&str>| -> Result<BTreeMap<i64, String>, String> {
		let [wmo, area] = TABLES.map(|t| cached_table(&o.sources, build, t, locale, http.as_ref(), log));
		Ok(subzone_names(&wmo?, &area?))
	};
	let english = read(None)?;
	let english_differs = areas.iter().filter(|(id, n)| english.get(id) != Some(n)).count();
	let meta = crate::names::meta(&o.root)?;
	let sources = format!("the client's WMOAreaTable and AreaTable ({build}, wago.tools) for the walking maps' areas");
	let mut written = Vec::new();
	for l in &o.locales {
		let names = translated(&areas, &read(Some(l.as_str()))?);
		let dir = o.out.join(forge_guide::toc::language_addon(l));
		let file = dir.join(FILE);
		if names.is_empty() {
			if file.exists() {
				std::fs::remove_file(&file).map_err(|e| format!("{}: {e}", file.display()))?;
			}
			written.push(Written { locale: l.to_string(), names: 0, bytes: 0 });
			continue;
		}
		let lua = subzones_lua(l, &names, &sources)?;
		std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		std::fs::write(&file, &lua).map_err(|e| format!("{}: {e}", file.display()))?;
		let name = forge_guide::toc::language_addon(l);
		let toc = dir.join(format!("{name}.toc"));
		std::fs::write(&toc, forge_guide::toc::language_toc(l, &meta.iface, &meta.version)).map_err(|e| format!("{}: {e}", toc.display()))?;
		written.push(Written { locale: l.to_string(), names: names.len(), bytes: lua.len() });
	}
	Ok(Report { build: build.to_string(), areas: areas.len(), english_differs, written })
}

impl Report {
	/// The text report, one line each.
	pub fn lines(&self) -> Vec<String> {
		let mut out = vec![format!("{} walking map areas; client tables {}", self.areas, self.build)];
		if self.english_differs > 0 {
			out.push(format!("{} of them named otherwise in English at {} than the walking maps name them", self.english_differs, self.build));
		}
		for w in &self.written {
			out.push(if w.names == 0 {
				format!("{}: every area named as in English; no {FILE}", w.locale)
			} else {
				format!("{}: {} areas named, {} KB", w.locale, w.names, forge_core::jsnum::js_to_fixed(w.bytes as f64 / 1024.0, 0))
			});
		}
		out
	}
}
