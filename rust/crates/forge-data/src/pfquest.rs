//! pfQuest (github.com/shagu/pfQuest, MIT, (c) Eric Mauser "Shagu") as a data source (port of
//! tools/lib/data/pfquest.js): the cached checkout, its licence, and its vanilla database read
//! through Lua 5.1. The checkout is cloned at its pin by `forge data sources` (sources.rs), not here.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_guide::js::V;

use crate::lua::lua_to_value;

pub const REPO: &str = "https://github.com/shagu/pfQuest";
const DATA_FILES: [&str; 7] = ["quests", "units", "objects", "items", "refloot", "areatrigger", "meta"];
const LOC_FILES: [&str; 4] = ["quests", "units", "objects", "items"];
const REQUIRED: [&str; 4] = ["quests", "units", "objects", "items"];

pub struct Checkout {
	pub dir: PathBuf,
	pub revision: Option<String>,
	pub warnings: Vec<String>,
}

fn git(args: &[&str], cwd: &Path) -> Option<String> {
	let out = std::process::Command::new("git").args(args).current_dir(cwd).output().ok()?;
	out.status.success().then(|| String::from_utf8_lossy(&out.stdout).trim().to_string())
}

/// ensurePfQuest with `offline` (or an explicit folder): the checkout as it is.
pub fn ensure(dir: &Path, explicit: bool) -> Result<Checkout, String> {
	if !dir.join("db").exists() {
		return Err(if explicit {
			format!("pfQuest directory {} has no db/ folder", dir.display())
		} else {
			format!("no pfQuest checkout at {}: run forge data sources --only pfquest, or pass --pfquest <dir>", dir.display())
		});
	}
	let mut warnings = Vec::new();
	let rooted = git(&["rev-parse", "--show-toplevel"], dir).and_then(|top| Some(std::fs::canonicalize(top).ok()? == std::fs::canonicalize(dir).ok()?)).unwrap_or(false);
	let revision = if rooted { git(&["rev-parse", "HEAD"], dir).filter(|s| !s.is_empty()) } else { None };
	if revision.is_none() {
		warnings.push(format!("pfQuest: {} is not a git checkout; revision unknown", dir.display()));
	}
	Ok(Checkout { dir: dir.to_path_buf(), revision, warnings })
}

pub struct License {
	pub license: String,
	pub copyright: Option<String>,
	pub notice: String,
}

/// Errors unless the checkout's licence is MIT.
pub fn check_license(dir: &Path) -> Result<License, String> {
	let file = ["LICENSE", "LICENSE.md", "LICENSE.txt"].iter().map(|f| dir.join(f)).find(|f| f.exists()).ok_or_else(|| format!("pfQuest: no LICENSE file in {}; refusing to use it", dir.display()))?;
	let notice = std::fs::read_to_string(&file).map_err(|e| e.to_string())?.replace("\r\n", "\n");
	let notice = notice.trim_matches(|c: char| c.is_whitespace() || c == '\u{feff}').to_string();
	let starts = notice.strip_prefix("MIT License").is_some_and(|r| !r.starts_with(|c: char| c.is_alphanumeric() || c == '_'));
	let mit = starts && notice.contains("Permission is hereby granted, free of charge") && notice.contains("THE SOFTWARE IS PROVIDED \"AS IS\"");
	if !mit {
		return Err(format!("pfQuest: {} is not the MIT license; refusing to use it", file.file_name().unwrap().to_string_lossy()));
	}
	let copyright = notice
		.split('\n')
		.find(|l| {
			let t = l.trim();
			t.len() >= 9 && t[..9].eq_ignore_ascii_case("copyright") && !t[9..].starts_with(|c: char| c.is_alphanumeric() || c == '_')
		})
		.map(|l| l.trim().to_string())
		.filter(|s| !s.is_empty());
	Ok(License { license: "MIT".into(), copyright, notice })
}

const PRELUDE: &str = r#"
pfDB = setmetatable({}, { __index = function(t, k) local v = {} rawset(t, k, v) return v end })
"#;

const EXPR: &str = r#"
local function cmp(a, b)
  local ta, tb = type(a), type(b)
  if ta ~= tb then return ta < tb end
  return a < b
end
local function list(t)
  local out = {}
  if type(t) ~= "table" then return out end
  local keys = {}
  for k in pairs(t) do keys[#keys + 1] = k end
  table.sort(keys, cmp)
  for i, k in ipairs(keys) do out[i] = { k, t[k] } end
  return out
end
local function data(name) return rawget(pfDB, name) and pfDB[name].data or {} end
local function loc(name) return rawget(pfDB, name) and pfDB[name].enUS or {} end
local items = {}
for i, p in ipairs(list(data("items"))) do
  local r = type(p[2]) == "table" and p[2] or {}
  items[i] = { p[1], { U = list(r.U), O = list(r.O), V = list(r.V), R = list(r.R) } }
end
local refloot = {}
for i, p in ipairs(list(data("refloot"))) do
  local r = type(p[2]) == "table" and p[2] or {}
  refloot[i] = { p[1], { U = list(r.U), O = list(r.O) } }
end
local meta = {}
for _, p in ipairs(list(rawget(pfDB, "meta") or {})) do
  if type(p[2]) == "table" then meta[#meta + 1] = { p[1], list(p[2]) } end
end
return {
  quests = list(data("quests")), units = list(data("units")), objects = list(data("objects")),
  items = items, refloot = refloot, areatrigger = list(data("areatrigger")), meta = meta,
  loc = { quests = list(loc("quests")), units = list(loc("units")), objects = list(loc("objects")), items = list(loc("items")) },
}
"#;

/// id -> value, ascending (the Lua side sorts every list).
pub type IdMap = BTreeMap<i64, V>;

pub struct ItemRow {
	pub u: IdMap,
	pub o: IdMap,
	pub v: IdMap,
	pub r: IdMap,
}

pub struct Raw {
	pub quests: IdMap,
	pub units: IdMap,
	pub objects: IdMap,
	pub items: BTreeMap<i64, ItemRow>,
	pub refloot: BTreeMap<i64, (IdMap, IdMap)>,
	pub areatrigger: IdMap,
	pub meta: BTreeMap<String, IdMap>,
	pub loc_quests: IdMap,
	pub loc_units: IdMap,
	pub loc_objects: IdMap,
	pub loc_items: IdMap,
}

fn pairs_of(v: &V) -> Vec<V> {
	v.items()
}

/// `new Map(pairs.map(([k, v]) => [Number(k), v]))` (keys that are not integers dropped).
fn to_map(v: &V) -> IdMap {
	let mut m = IdMap::new();
	for p in pairs_of(v) {
		let k = p.at(0).num();
		if k.is_finite() && k == k.trunc() {
			m.insert(k as i64, p.at(1));
		}
	}
	m
}

pub fn load(dir: &Path) -> Result<Raw, String> {
	let db = dir.join("db");
	let mut files = Vec::new();
	for name in DATA_FILES {
		let f = db.join(format!("{name}.lua"));
		if f.exists() {
			files.push(f);
		} else if REQUIRED.contains(&name) {
			return Err(format!("pfQuest: missing db/{name}.lua"));
		}
	}
	for name in LOC_FILES {
		let f = db.join("enUS").join(format!("{name}.lua"));
		if !f.exists() {
			return Err(format!("pfQuest: missing db/enUS/{name}.lua"));
		}
		files.push(f);
	}
	let refs: Vec<&Path> = files.iter().map(PathBuf::as_path).collect();
	let raw = lua_to_value(&refs, PRELUDE, EXPR)?;
	let mut items = BTreeMap::new();
	for p in pairs_of(&raw.get("items")) {
		let r = p.at(1);
		items.insert(p.at(0).num() as i64, ItemRow { u: to_map(&r.get("U")), o: to_map(&r.get("O")), v: to_map(&r.get("V")), r: to_map(&r.get("R")) });
	}
	let mut refloot = BTreeMap::new();
	for p in pairs_of(&raw.get("refloot")) {
		let r = p.at(1);
		refloot.insert(p.at(0).num() as i64, (to_map(&r.get("U")), to_map(&r.get("O"))));
	}
	let mut meta = BTreeMap::new();
	for p in pairs_of(&raw.get("meta")) {
		meta.insert(p.at(0).to_js_string(), to_map(&p.at(1)));
	}
	let loc = raw.get("loc");
	Ok(Raw {
		quests: to_map(&raw.get("quests")),
		units: to_map(&raw.get("units")),
		objects: to_map(&raw.get("objects")),
		items,
		refloot,
		areatrigger: to_map(&raw.get("areatrigger")),
		meta,
		loc_quests: to_map(&loc.get("quests")),
		loc_units: to_map(&loc.get("units")),
		loc_objects: to_map(&loc.get("objects")),
		loc_items: to_map(&loc.get("items")),
	})
}
