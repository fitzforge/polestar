//! The interface's translation keys (port of tools/lib/i18n/keys.js): every literal L["..."] and
//! ns.LC("context", "text") in an addon (docs/ARCHITECTURE.md, "Localisation"), read with a small Lua
//! tokenizer (forge-guide's) so strings in comments and inside other strings never count, plus the
//! keys code looks up from data (L[category], L[race], ...), listed below where they come from.

use forge_guide::i18n_files::tokenize;
use forge_guide::js::{cmp_utf16, parse_json};
use regex::Regex;
use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

/// Where a key is used: its file (relative to the addon, with /) and line, or `data` for a key code
/// looks up from data (line 0).
#[derive(Clone, Debug, PartialEq)]
pub struct Use {
	pub file: String,
	pub line: usize,
	pub data: bool,
}

/// Every key with its uses, in the order the keys are first used.
#[derive(Default)]
pub struct Keys {
	pub list: Vec<(String, Vec<Use>)>,
	index: HashMap<String, usize>,
}

impl Keys {
	fn add(&mut self, key: String, u: Use) {
		match self.index.get(&key) {
			Some(&i) => self.list[i].1.push(u),
			None => {
				self.index.insert(key.clone(), self.list.len());
				self.list.push((key, vec![u]));
			}
		}
	}
	pub fn has(&self, key: &str) -> bool {
		self.index.contains_key(key)
	}
	pub fn get(&self, key: &str) -> Option<&[Use]> {
		self.index.get(key).map(|&i| &self.list[i].1[..])
	}
	pub fn len(&self) -> usize {
		self.list.len()
	}
	pub fn is_empty(&self) -> bool {
		self.list.is_empty()
	}
	/// (key, the files that use it) as forge-guide's locale file writer takes them.
	pub fn by_file(&self) -> Vec<(String, Vec<String>)> {
		self.list.iter().map(|(k, w)| (k.clone(), w.iter().map(|u| u.file.clone()).collect())).collect()
	}
}

/// Keys in one Lua source: (key, line) for L["text"] and LC("ctx", "text").
pub fn keys_in_source(src: &str, file: &str) -> Result<Vec<(String, usize)>, String> {
	let t = tokenize(src, file)?;
	let at = |i: usize| t.get(i);
	let is = |i: usize, v: &str| at(i).is_some_and(|x| x.1 == v);
	let string = |i: usize| at(i).filter(|x| x.0 == "string");
	let mut out = Vec::new();
	for i in 0..t.len() {
		if t[i].0 != "name" {
			continue;
		}
		if t[i].1 == "L" && is(i + 1, "[") && is(i + 3, "]") {
			if let Some(s) = string(i + 2) {
				out.push((s.1.clone(), s.2));
			}
		} else if t[i].1 == "LC" && is(i + 1, "(") && is(i + 3, ",") && is(i + 5, ")") {
			if let (Some(c), Some(s)) = (string(i + 2), string(i + 4)) {
				out.push((format!("{}: {}", c.1, s.1), s.2));
			}
		}
	}
	Ok(out)
}

/// Keys code looks up with a variable (L[c]): text that comes from data. Each list names where its
/// values come from; a value added there is added here.
pub const DATA_KEYS: &[(&str, &[&str])] = &[
	// The guide format's categories (docs/GUIDE_FORMAT.md, `category`; UI/Picker.lua CATEGORIES, UI.Category).
	("UI/Picker.lua", &["Leveling", "Class", "Professions", "Reputation", "Exploration", "Legacy", "Collectibles", "Miscellaneous"]),
	// UI.RaceName: Forever's race files (forge-guide races.rs) as RACE_NAMES words them, where the client has
	// no name for the race (Skyborne) or no C_CreatureInfo.GetRaceInfo; UI.ClassName when the client has no
	// LOCALIZED_CLASS_NAMES_MALE.
	("UI/UI.lua", &["Human", "Orc", "Dwarf", "Night Elf", "Undead", "Tauren", "Gnome", "Troll", "Skyborne", "Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"]),
	// Lookup.PROFESSIONS (Lookup/Sources.lua), shown through L[name] in Lookup/Guide.lua.
	("Lookup/Sources.lua", &["Alchemy", "Blacksmithing", "Enchanting", "Engineering", "Herbalism", "Leatherworking", "Mining", "Skinning", "Tailoring", "Cooking", "Fishing", "First Aid"]),
	// Engine's skillName: a skill goal's name through L when the client has no name for its skill line (the
	// professions above, and Riding).
	("Core/Engine.lua", &["Riding"]),
	// ns.stage (Core/Init.lua), the chip beside the version (Theme/Widgets.lua).
	("Core/Init.lua", &["Beta"]),
];

/// The spec labels of Gear/Weights.lua (`label = "..."` in a spec row), shown through L[spec.label].
fn spec_labels(addon_dir: &Path) -> Vec<String> {
	static RE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"\{\s*key\s*=\s*"[^"]+",\s*label\s*=\s*"((?:[^"\\]|\\.)*)""#).unwrap());
	let Ok(src) = std::fs::read_to_string(addon_dir.join("Gear/Weights.lua")) else { return Vec::new() };
	RE.captures_iter(&src).map(|m| m[1].to_string()).collect()
}

/// The spec names of Talents/Builds.lua (`specs = { "...", ... }` per class), shown through L[...].
fn talent_specs(addon_dir: &Path) -> Vec<String> {
	static SPECS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?-u:\b)specs\s*=\s*\{([^}]*)\}").unwrap());
	static STR: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#""((?:[^"\\]|\\.)*)""#).unwrap());
	let Ok(src) = std::fs::read_to_string(addon_dir.join("Talents/Builds.lua")) else { return Vec::new() };
	SPECS.captures_iter(&src).flat_map(|m| STR.captures_iter(m.get(1).unwrap().as_str()).map(|s| s[1].to_string()).collect::<Vec<_>>()).collect()
}

/// The attunement table's notes (`root`/data/codex/attunements.json `note`), shown through L[a.note]
/// on the Dungeons Attunement tab and in its guide.
fn attunement_notes(root: &Path, addon_dir: &Path) -> Result<Vec<String>, String> {
	let file = root.join("data/codex/attunements.json");
	if !addon_dir.join("Dungeons/Attune.lua").exists() {
		return Ok(Vec::new());
	}
	let Ok(text) = std::fs::read_to_string(&file) else { return Ok(Vec::new()) };
	let doc = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let mut out: Vec<String> = Vec::new();
	for a in doc.get("attunements").items() {
		if let Some(n) = a.get("note").as_str().filter(|n| !n.is_empty()) {
			if !out.iter().any(|x| x == n) {
				out.push(n.to_string());
			}
		}
	}
	Ok(out)
}

/// Every .lua under `dir` (each folder in name order), skipping the folder `skip`.
fn lua_files(dir: &Path, skip: &Path, out: &mut Vec<PathBuf>) -> Result<(), String> {
	let mut ents: Vec<_> = std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?.flatten().collect();
	ents.sort_by(|a, b| cmp_utf16(&a.file_name().to_string_lossy(), &b.file_name().to_string_lossy()));
	for d in ents {
		let p = dir.join(d.file_name());
		if d.file_type().is_ok_and(|t| t.is_dir()) {
			if p != skip {
				lua_files(&p, skip, out)?;
			}
		} else if d.file_name().to_string_lossy().ends_with(".lua") {
			out.push(p);
		}
	}
	Ok(())
}

/// The keys of the addon in `addon_dir` (an absolute path) with where each is used, in the order the
/// addon loads its files (TOC, XML manifests; a folder without a TOC, a test's, in name order), then
/// the keys from data. `root`: the checkout (its data/codex/attunements.json).
pub fn extract_keys(root: &Path, addon_dir: &Path) -> Result<Keys, String> {
	let mut all = Vec::new();
	lua_files(addon_dir, &addon_dir.join("Locales"), &mut all)?;
	let name = addon_dir.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
	let order: Vec<PathBuf> = if addon_dir.join(format!("{name}.toc")).exists() { forge_addontest::run::dir_files(addon_dir)? } else { Vec::new() };
	let mut files: Vec<&PathBuf> = order.iter().filter(|f| all.contains(f)).collect();
	files.extend(all.iter().filter(|f| !order.contains(f)));
	let mut keys = Keys::default();
	for f in files {
		let rel = f.strip_prefix(addon_dir).unwrap_or(f).to_string_lossy().replace('\\', "/");
		let src = std::fs::read_to_string(f).map_err(|e| format!("{}: {e}", f.display()))?;
		for (key, line) in keys_in_source(&src, &rel)? {
			keys.add(key, Use { file: rel.clone(), line, data: false });
		}
	}
	let data = |file: &str| Use { file: file.into(), line: 0, data: true };
	for (file, list) in DATA_KEYS {
		if addon_dir.join(file).exists() {
			for key in *list {
				keys.add(key.to_string(), data(file));
			}
		}
	}
	for key in spec_labels(addon_dir) {
		keys.add(key, data("Gear/Weights.lua"));
	}
	for key in talent_specs(addon_dir) {
		keys.add(key, data("Talents/Builds.lua"));
	}
	for key in attunement_notes(root, addon_dir)? {
		keys.add(key, data("Dungeons/Attune.lua"));
	}
	Ok(keys)
}
