//! The sources of `forge data names` (names.rs) beside Polestar's own data, each read into id -> name maps
//! per kind (ports of tools/lib/i18n/names.js's DingDB part, names-wago.js, names-web.js and
//! tools/lib/data/pfquest.js's loadPfQuestNames):
//! - DingDB (Ding/DB/Locales/<locale>.lua of Ding! by Yendi, GPL-3.0, used with his permission:
//!   THIRD_PARTY.md), cloned into data/sources/ding and pinned: the checkout must sit at [`ding_pin`]'s commit
//!   and every file must have its sha256, or the build stops. Moving the pin is an edit here, after
//!   reading what changed.
//! - pfQuest's db/<locale> (MIT; Era names, no esMX).
//! - The Forever client's tables in each language, from wago.tools (`&locale=`), cached per build and
//!   language in data/sources/wago/<build>/<locale>/<Table>.csv: items (ItemSparse.Display_lang, then the
//!   Era client's for the items Forever's table lacks), map (Map.MapName_lang), encounter
//!   (DungeonEncounter.Name_lang), faction (Faction.Name_lang), taxi (TaxiNodes.Name_lang).
//! - Forever's quest data in each language from the web quest database, read only from what is cached in
//!   data/sources/web: list pages (names/<locale>/lists/<type>.json), the English lists to tell a
//!   translation from a name left in English (codex/lists for npcs, objects and items, names/enUS/lists
//!   for quests) and tooltips (names/<locale>/<type>/<id>.json). A name in brackets ("[Alba Fairmoon]")
//!   is one it has no translation for: no name.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

use forge_guide::i18n_files::lua_string;
use forge_guide::js::V;
use regex::Regex;
use sha2::{Digest, Sha256};

use crate::lua::lua_to_value;
use crate::sources::Http;
use crate::tables::{self, Product};

/// id -> name, ascending.
pub type Names = BTreeMap<i64, String>;

/// quest, npc, object, item: the kinds DingDB, pfQuest and the web data name.
pub const NAME_KINDS: [&str; 4] = ["quest", "npc", "object", "item"];

fn git(args: &[&str], cwd: &Path) -> Result<String, String> {
	let out = std::process::Command::new("git").args(args).current_dir(cwd).output().map_err(|e| e.to_string())?;
	if out.status.success() {
		Ok(String::from_utf8_lossy(&out.stdout).trim().to_string())
	} else {
		Err(String::from_utf8_lossy(&out.stderr).trim().to_string())
	}
}

fn sha256(file: &Path) -> Result<String, String> {
	let bytes = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok(Sha256::digest(&bytes).iter().map(|b| format!("{b:02x}")).collect())
}

// ---------------------------------------------------------------- DingDB

#[derive(Clone)]
pub struct Pin {
	pub repo: String,
	pub version: String,
	pub commit: String,
	/// (path in the checkout, sha256), sorted by path.
	pub files: Vec<(String, String)>,
}

/// DingDB at Ding v1.8.1. CREDITS.md ships beside the names.
pub fn ding_pin() -> Pin {
	let files = [
		("Ding/DB/CREDITS.md", "d32ce3d857766e88d0afd94d39eb0d4e3317ccc5538a46720f0ac743dfd64ab9"),
		("Ding/DB/Locales/deDE.lua", "a2f4ebd5caaadf07c1704c494b3a41442211298d61f527201eb0ab4af2d7d1ec"),
		("Ding/DB/Locales/esES.lua", "6bcc8a55f21723c641f7b8daa275649c548ea3eb08df3793197e75c4579ecf66"),
		("Ding/DB/Locales/esMX.lua", "380da93d12f47ede6b8e248a8d8096431de6a8865e9cd5cf8ff775cb78a90ceb"),
		("Ding/DB/Locales/frFR.lua", "5ba47c1ed481e9367c283adab21296103a63c3abe18dcfe7719e44f2d57d2469"),
		("Ding/DB/Locales/koKR.lua", "8efe170a161c47ed64b1e4d0c9048773f6e2ce594906e95fa005c63940375f45"),
		("Ding/DB/Locales/ptBR.lua", "e9c320db5293eabf638158daae947585878811e7ec493fa5763759c83f1cd1dd"),
		("Ding/DB/Locales/ruRU.lua", "3a7ec4e35701a690282ed0b5ec91240c8c7c62b1f0a32d0000e780f5d52f8636"),
		("Ding/DB/Locales/zhCN.lua", "c159cf9b6e2f4aa644fde6afc801168faf44273a4358ff7859ef3be5f9139646"),
		("Ding/DB/Locales/zhTW.lua", "61fb6753b026f50314583cd6cbd90eb5e2332c839d0de2ab2eb4122756312b4b"),
	];
	Pin {
		repo: "https://github.com/moust4ki/DingGuideWoWForever".into(),
		version: "v1.8.1".into(),
		commit: "fb0a06a43d054ab53b67e8d7af9743a9f8953ac3".into(),
		files: files.iter().map(|(p, h)| (p.to_string(), h.to_string())).collect(),
	}
}

pub const CREDITS: &str = "Ding/DB/CREDITS.md";

pub fn ding_file(locale: &str) -> String {
	format!("Ding/DB/Locales/{locale}.lua")
}

pub struct Ding {
	pub dir: PathBuf,
	/// None: a folder that is no checkout of its own.
	pub revision: Option<String>,
	pub pin: Pin,
	/// (path, sha256) of every pinned file, sorted.
	pub files: Vec<(String, String)>,
}

/// The commit a checkout rooted at dir is at, or None.
fn revision_of(dir: &Path) -> Option<String> {
	let top = git(&["rev-parse", "--show-toplevel"], dir).ok()?;
	if std::fs::canonicalize(top).ok()? != std::fs::canonicalize(dir).ok()? {
		return None;
	}
	git(&["rev-parse", "HEAD"], dir).ok()
}

/// Clones DingDB into dir when it is not there (not with `explicit`, a folder the user named, or
/// `offline`), moves the cache clone to the pinned commit, and checks every pinned file's sha256. A named
/// folder is used as it is: at another commit, or with a file that differs, it stops the build.
pub fn ensure_ding(dir: &Path, explicit: bool, offline: bool, pin: Pin, log: &dyn Fn(&str)) -> Result<Ding, String> {
	if !dir.join("Ding").join("DB").exists() {
		if explicit {
			return Err(format!("DingDB: {} has no Ding/DB folder", dir.display()));
		}
		if offline {
			return Err(format!("--offline: no cached DingDB at {} (run once without --offline)", dir.display()));
		}
		log(&format!("cloning {} into {}", pin.repo, dir.display()));
		if let Some(p) = dir.parent() {
			std::fs::create_dir_all(p).map_err(|e| format!("{}: {e}", p.display()))?;
		}
		let here = dir.parent().unwrap_or(Path::new("."));
		git(&["clone", "--quiet", &pin.repo, &dir.to_string_lossy()], here).map_err(|e| format!("git clone {} failed: {e}", pin.repo))?;
	}
	let mut revision = revision_of(dir);
	if !explicit && revision.is_none() {
		return Err(format!("DingDB: {} is not a git checkout; delete it to clone again, or pass --ding <dir>", dir.display()));
	}
	if let Some(rev) = &revision {
		if *rev != pin.commit {
			if explicit {
				return Err(format!(
					"DingDB: {} is at {rev}, the pin is {} ({}): check that out, or move the pin (ding_pin in rust/crates/forge-data/src/names_sources.rs)",
					dir.display(),
					pin.commit,
					pin.version
				));
			}
			let checkout = || git(&["-c", "advice.detachedHead=false", "checkout", "--quiet", &pin.commit], dir);
			let mut r = checkout();
			if r.is_err() && !offline {
				log(&format!("fetching {} for {}", pin.repo, pin.commit));
				let _ = git(&["fetch", "--quiet", "origin"], dir);
				r = checkout();
			}
			r.map_err(|e| format!("DingDB: cannot check out {} in {}: {e}", pin.commit, dir.display()))?;
			revision = revision_of(dir);
		}
	}
	let mut files = Vec::new();
	for (rel, want) in &pin.files {
		let file = dir.join(rel);
		if !file.exists() {
			return Err(format!("DingDB: {rel} is missing from {}", dir.display()));
		}
		let got = sha256(&file)?;
		if got != *want {
			return Err(format!(
				"DingDB: {rel} has sha256 {got}, the pin ({}, {}) says {want}: read what changed, then move the pin (ding_pin in rust/crates/forge-data/src/names_sources.rs)",
				pin.version,
				&pin.commit[..7.min(pin.commit.len())]
			));
		}
		files.push((rel.clone(), got));
	}
	Ok(Ding { dir: dir.to_path_buf(), revision, pin, files })
}

/// (id, name) pairs of a Lua list of {id, name}.
fn pairs(v: &V) -> Vec<(i64, String)> {
	v.items().iter().filter_map(|p| Some((p.at(0).as_num()? as i64, p.at(1).as_str()?.to_string()))).collect()
}

/// DingDB's names of each locale whose file the pin lists, read by Lua the way Ding loads them (the file
/// returns at once unless GetLocale() is its language). -> locale -> [quest, npc, object, item]
pub fn read_ding(ding: &Ding, locales: &[&str]) -> Result<BTreeMap<String, [Names; 4]>, String> {
	let mut out: BTreeMap<String, [Names; 4]> = locales.iter().map(|l| (l.to_string(), Default::default())).collect();
	let wanted: Vec<&str> = locales.iter().copied().filter(|l| ding.pin.files.iter().any(|(p, _)| *p == ding_file(l))).collect();
	if wanted.is_empty() {
		return Ok(out);
	}
	let calls: Vec<String> = wanted.iter().map(|l| format!("read({}, {})", lua_string(&ding.dir.join(ding_file(l)).to_string_lossy()), lua_string(l))).collect();
	let expr = format!(
		r#"
local out = {{}}
local function list(t)
  local l = {{}}
  for id, name in pairs(t) do
    if type(id) == "number" and type(name) == "string" then l[#l + 1] = {{ id, name }} end
  end
  return l
end
local function read(file, locale)
  GetLocale = function() return locale end
  local Ding = {{ DB = {{ names = {{ quests = {{}}, npcs = {{}}, objects = {{}}, items = {{}} }} }} }}
  local ok, err = __polestar_loaddata(file, "Ding", Ding)
  if not ok then error(err, 0) end
  local n = Ding.DB.names
  out[locale] = {{ quest = list(n.quests), npc = list(n.npcs), object = list(n.objects), item = list(n.items) }}
end
{}
return out"#,
		calls.join("\n")
	);
	let raw = lua_to_value(&[], "", &expr)?;
	for l in wanted {
		let into = out.get_mut(l).unwrap();
		for (k, kind) in NAME_KINDS.iter().enumerate() {
			into[k].extend(pairs(&raw.get(l).get(kind)));
		}
	}
	Ok(out)
}

// ---------------------------------------------------------------- pfQuest

/// One language's pfQuest names: quest, npc, object, item (title, unit, object and item names) and a
/// quest's objective text (its O).
#[derive(Default)]
pub struct PfNames {
	pub kinds: [Names; 4],
	pub objective: Names,
}

/// Names in other client languages: db/<locale>/{quests,units,objects,items}.lua assign
/// pfDB[<db>][<locale>]. pfQuest has no esMX: a locale without a folder comes back empty.
pub fn load_pfquest_names(dir: &Path, locales: &[&str]) -> Result<BTreeMap<String, PfNames>, String> {
	const FILES: [&str; 4] = ["quests", "units", "objects", "items"];
	let mut out = BTreeMap::new();
	for locale in locales {
		let mut names = PfNames::default();
		let folder = dir.join("db").join(locale);
		if folder.exists() {
			let files: Vec<PathBuf> = FILES.iter().map(|f| folder.join(format!("{f}.lua"))).filter(|f| f.exists()).collect();
			let refs: Vec<&Path> = files.iter().map(PathBuf::as_path).collect();
			let kinds = NAME_KINDS.iter().zip(FILES).map(|(k, f)| format!("{k} = \"{f}\"")).collect::<Vec<_>>().join(", ");
			let expr = format!(
				r#"
local out = {{ objective = {{}} }}
for kind, db in pairs({{ {kinds} }}) do
  local list = {{}}
  local t = rawget(pfDB, db) and rawget(pfDB[db], "{locale}") or {{}}
  for id, v in pairs(t) do
    local name = type(v) == "table" and v.T or v
    if type(id) == "number" and type(name) == "string" then list[#list + 1] = {{ id, name }} end
    if kind == "quest" and type(id) == "number" and type(v) == "table" and type(v.O) == "string" then
      out.objective[#out.objective + 1] = {{ id, v.O }}
    end
  end
  out[kind] = list
end
return out"#
			);
			let prelude = "\npfDB = setmetatable({}, { __index = function(t, k) local v = {} rawset(t, k, v) return v end })\n";
			let raw = lua_to_value(&refs, prelude, &expr)?;
			for (k, kind) in NAME_KINDS.iter().enumerate() {
				names.kinds[k].extend(pairs(&raw.get(kind)));
			}
			names.objective.extend(pairs(&raw.get("objective")));
		}
		out.insert(locale.to_string(), names);
	}
	Ok(out)
}

// ---------------------------------------------------------------- client tables

/// The kinds the client's tables name, with their table and field.
pub const TABLE_KINDS: [(&str, &str, &str); 5] =
	[("item", "ItemSparse", "Display_lang"), ("map", "Map", "MapName_lang"), ("encounter", "DungeonEncounter", "Name_lang"), ("faction", "Faction", "Name_lang"), ("taxi", "TaxiNodes", "Name_lang")];

/// Kind -> id -> name.
pub type KindNames = BTreeMap<&'static str, Names>;

pub struct ClientNames {
	/// locale -> kind -> names.
	pub names: BTreeMap<String, KindNames>,
	pub english: KindNames,
	/// (product, build): forever, then era.
	pub builds: Vec<(&'static str, String)>,
	/// The tables' URLs with `<locale>`, in load order.
	pub urls: Vec<String>,
}

fn table_file(sources: &Path, build: &str, locale: Option<&str>, table: &str) -> PathBuf {
	let mut p = sources.join("wago").join(build);
	if let Some(l) = locale {
		p = p.join(l);
	}
	p.join(format!("{table}.csv"))
}

/// The cached builds of the product holding every table of `kinds` in English and in every locale,
/// newest first.
fn complete_builds(sources: &Path, p: &Product, kinds: &[(&str, &str, &str)], locales: &[&str]) -> Vec<String> {
	let Ok(rd) = std::fs::read_dir(sources.join("wago")) else { return Vec::new() };
	let mut builds: Vec<String> = rd
		.flatten()
		.map(|e| e.file_name().to_string_lossy().to_string())
		.filter(|b| tables::is_build(b) && p.in_family(b))
		.filter(|b| std::iter::once(None).chain(locales.iter().map(|l| Some(*l))).all(|l| kinds.iter().all(|(_, t, _)| table_file(sources, b, l, t).exists())))
		.collect();
	builds.sort_by(|a, b| tables::compare_versions(a, b));
	builds.reverse();
	builds
}

/// The rows of `table` of `build` in `locale` (None: English): the cached CSV, else fetched and cached.
fn cached_table(sources: &Path, build: &str, table: &str, locale: Option<&str>, http: Option<&Http>, log: &dyn Fn(&str)) -> Result<crate::jsv::Rows, String> {
	if let Some(l) = locale {
		let b = l.as_bytes();
		if !(b.len() == 4 && b[..2].iter().all(u8::is_ascii_lowercase) && b[2..].iter().all(u8::is_ascii_uppercase)) {
			return Err(format!("wago: bad locale \"{l}\""));
		}
	}
	let file = table_file(sources, build, locale, table);
	if file.exists() {
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		return tables::parse_csv(&text);
	}
	let Some(http) = http else {
		return Err(format!("--offline: missing cached {}", file.display()));
	};
	let url = format!("{}{}", tables::table_url(table, build), locale.map(|l| format!("&locale={l}")).unwrap_or_default());
	log(&format!("fetching {url}"));
	let text = http.text(&url, 512 * 1024 * 1024)?;
	let rows = tables::parse_csv(&text)?;
	if rows.first().is_none_or(|r| !r.contains_key("ID")) {
		return Err(format!("{url}: not a DB2 CSV export"));
	}
	crate::sources::write_atomic(&file, text.as_bytes())?;
	Ok(rows)
}

/// JS String.prototype.trim's white space (and \s's).
pub fn js_space(c: char) -> bool {
	matches!(c, '\t' | '\n' | '\u{b}' | '\u{c}' | '\r' | ' ' | '\u{a0}' | '\u{1680}' | '\u{2000}'..='\u{200a}' | '\u{2028}' | '\u{2029}' | '\u{202f}' | '\u{205f}' | '\u{3000}' | '\u{feff}')
}

pub fn js_trim(s: &str) -> &str {
	s.trim_matches(js_space)
}

/// One build's tables of `kinds` in English and each language.
fn load_tables(
	sources: &Path,
	build: &str,
	locales: &[&str],
	kinds: &[(&'static str, &str, &str)],
	http: Option<&Http>,
	log: &dyn Fn(&str),
) -> Result<(BTreeMap<String, KindNames>, KindNames, Vec<String>), String> {
	let read = |locale: Option<&str>, table: &str, field: &str| -> Result<Names, String> {
		let mut m = Names::new();
		for r in cached_table(sources, build, table, locale, http, log)? {
			let id = r.get("ID").map(|s| forge_guide::js::str_to_num(s)).unwrap_or(f64::NAN);
			let name = r.get(field).map(|s| js_trim(s)).unwrap_or("");
			if id > 0.0 && !name.is_empty() {
				m.insert(id as i64, name.to_string());
			}
		}
		Ok(m)
	};
	let mut english = KindNames::new();
	let mut urls = Vec::new();
	for (kind, table, field) in kinds {
		english.insert(*kind, read(None, table, field)?);
		urls.push(format!("https://wago.tools/db2/{table}/csv?build={build}&locale=<locale>"));
	}
	let mut names = BTreeMap::new();
	for l in locales {
		let mut m = KindNames::new();
		for (kind, table, field) in kinds {
			m.insert(*kind, read(Some(l), table, field)?);
		}
		names.insert(l.to_string(), m);
	}
	Ok((names, english, urls))
}

/// The client tables of each language: Forever's, then the Era client's items for the ids Forever's lack.
/// Each product's build: `forever` when given (Forever only); else the newest wago.tools lists (offline:
/// none), falling back to the newest cached build holding every table this reads in English and in every
/// language asked. A product with no such build is an error: a pack without its instances, factions and
/// flight points is never written silently.
pub fn load_client_names(sources: &Path, locales: &[&str], forever: Option<&str>, offline: bool, log: &dyn Fn(&str)) -> Result<ClientNames, String> {
	let http = (!offline).then(Http::default_agent);
	let mut out = ClientNames {
		names: locales.iter().map(|l| (l.to_string(), TABLE_KINDS.iter().map(|k| (k.0, Names::new())).collect())).collect(),
		english: TABLE_KINDS.iter().map(|k| (k.0, Names::new())).collect(),
		builds: Vec::new(),
		urls: Vec::new(),
	};
	for (product, p, given, kinds) in [("forever", &tables::FOREVER, forever, &TABLE_KINDS[..]), ("era", &tables::ERA, None, &TABLE_KINDS[..1])] {
		let tries: Vec<String> = match given {
			Some(b) => vec![b.to_string()],
			None => {
				let mut t: Vec<String> = Vec::new();
				if let Some(h) = &http {
					if let Ok(b) = crate::sources::latest_build(h, p) {
						t.push(b);
					}
				}
				for b in complete_builds(sources, p, kinds, locales) {
					if !t.contains(&b) {
						t.push(b);
					}
				}
				t
			}
		};
		let mut got = None;
		let mut errors = Vec::new();
		for b in &tries {
			match load_tables(sources, b, locales, kinds, http.as_ref(), log) {
				Ok(g) => {
					got = Some((b.clone(), g));
					break;
				}
				Err(e) => errors.push(format!("{b}: {e}")),
			}
		}
		let Some((build, (names, english, urls))) = got else {
			let tables = kinds.iter().map(|k| k.1).collect::<Vec<_>>().join(", ");
			let why = if errors.is_empty() { " cached".to_string() } else { format!(": {}", errors.join("; ")) };
			return Err(format!("no {product} client tables ({tables}) for {}{why}; run once online, or pass the build", locales.join(", ")));
		};
		out.builds.push((product, build));
		out.urls.extend(urls);
		for (k, m) in english {
			let into = out.english.get_mut(k).unwrap();
			for (id, n) in m {
				into.entry(id).or_insert(n);
			}
		}
		for (l, kinds) in names {
			let lm = out.names.get_mut(&l).unwrap();
			for (k, m) in kinds {
				let into = lm.get_mut(k).unwrap();
				for (id, n) in m {
					into.entry(id).or_insert(n);
				}
			}
		}
	}
	Ok(out)
}

// ---------------------------------------------------------------- the web quest database

/// Everything cached for one language: names and the web data's English names per kind (quest, npc,
/// object, item), the quest objective texts (tooltips) and the first and last fetch dates (ISO).
#[derive(Default)]
pub struct WebNames {
	pub names: [Names; 4],
	pub english: [Names; 4],
	pub objective: Names,
	pub fetched: Option<(String, String)>,
}

fn read_json(file: &Path) -> Result<Option<serde_json::Value>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	serde_json::from_str(&text).map(Some).map_err(|e| format!("{}: {e}", file.display()))
}

fn unhtml(s: &str) -> String {
	static BR: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?i)<br\s*/?>").unwrap());
	static TAG: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"<[^>]*>").unwrap());
	static APOS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"&#0?39;").unwrap());
	let s = BR.replace_all(s, "\n");
	let s = TAG.replace_all(&s, "");
	let s = APOS.replace_all(&s, "'");
	s.replace("&quot;", "\"").replace("&nbsp;", " ").replace("&lt;", "<").replace("&gt;", ">").replace("&amp;", "&")
}

/// A name the web data has in this language: not empty, not "[English]" (no translation), not a
/// "[PH] ..." placeholder.
fn real_name(v: &serde_json::Value) -> Option<String> {
	static BRACKETED: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"^\[[^\n\r\u{2028}\u{2029}]*\]$").unwrap());
	static PH: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?i)^\[PH\]").unwrap());
	let s = js_trim(v.as_str()?);
	(!s.is_empty() && !BRACKETED.is_match(s) && !PH.is_match(s)).then(|| s.to_string())
}

/// A quest tooltip's objective text: the paragraph after the title, before the requirements.
fn quest_objective(tooltip: &serde_json::Value) -> Option<String> {
	static TITLE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"(?s)^.*?<b class="q">.*?</b>"#).unwrap());
	static PARA: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\n[\t\n\x0B\x0C\r \u{a0}\u{1680}\u{2000}-\u{200a}\u{2028}\u{2029}\u{202f}\u{205f}\u{3000}\u{feff}]*\n").unwrap());
	let body = TITLE.replace(tooltip.as_str()?, "");
	let text = unhtml(body.split("<span class=\"q\">").next().unwrap_or(""));
	PARA.split(&text).map(clean).find(|s| !s.is_empty())
}

/// A name as it is written into the pack: every run of white space (a line break too) one space, none at
/// the ends (JS's \s).
pub fn clean(s: &str) -> String {
	s.split(js_space).filter(|p| !p.is_empty()).collect::<Vec<_>>().join(" ")
}

fn num_id(v: &serde_json::Value) -> Option<i64> {
	v.as_f64().map(|n| n as i64)
}

/// The web quest database's names of one language, from the cache under `sources`/web. A missing cache
/// reads as no names.
pub fn load_web_names(sources: &Path, locale: &str) -> Result<WebNames, String> {
	let names_dir = sources.join("web").join("names").join(locale);
	let mut out = WebNames::default();
	let mut dates: Vec<String> = Vec::new();
	for (k, kind) in NAME_KINDS.iter().enumerate() {
		let en_file = if *kind == "quest" { sources.join("web/names/enUS/lists/quest.json") } else { sources.join("web/codex/lists").join(format!("{kind}.json")) };
		let rows = |doc: &Option<serde_json::Value>| -> Vec<(Option<String>, serde_json::Value)> {
			let mut v = Vec::new();
			for c in doc.as_ref().and_then(|d| d["chunks"].as_array()).into_iter().flatten() {
				for r in c["rows"].as_array().into_iter().flatten() {
					v.push((c["fetchedAt"].as_str().map(String::from), r.clone()));
				}
			}
			v
		};
		let en = read_json(&en_file)?;
		for (_, r) in rows(&en) {
			let name = &r["name"];
			let truthy = match name {
				serde_json::Value::Null => false,
				serde_json::Value::Bool(b) => *b,
				serde_json::Value::Number(n) => n.as_f64() != Some(0.0),
				serde_json::Value::String(s) => !s.is_empty(),
				_ => true,
			};
			if let (true, Some(id)) = (truthy, num_id(&r["id"])) {
				let text = match name {
					serde_json::Value::String(s) => s.clone(),
					other => other.to_string(),
				};
				out.english[k].insert(id, js_trim(&text).to_string());
			}
		}
		let list = read_json(&names_dir.join("lists").join(format!("{kind}.json")))?;
		for c in list.as_ref().and_then(|d| d["chunks"].as_array()).into_iter().flatten() {
			if let Some(d) = c["fetchedAt"].as_str() {
				dates.push(d.to_string());
			}
			for r in c["rows"].as_array().into_iter().flatten() {
				if let (Some(n), Some(id)) = (real_name(&r["name"]), num_id(&r["id"])) {
					out.names[k].insert(id, n);
				}
			}
		}
		let dir = names_dir.join(kind);
		let Ok(rd) = std::fs::read_dir(&dir) else { continue };
		let mut files: Vec<PathBuf> = rd.flatten().map(|e| e.path()).filter(|p| p.to_string_lossy().ends_with(".json")).collect();
		files.sort();
		for f in files {
			let Some(t) = read_json(&f)? else { continue };
			if t["notFound"].as_bool() == Some(true) || t.is_null() {
				continue;
			}
			if let Some(d) = t["fetchedAt"].as_str() {
				dates.push(d.to_string());
			}
			let n = real_name(&t["name"]);
			let Some(id) = num_id(&t["id"]) else { continue };
			if let Some(n) = &n {
				out.names[k].entry(id).or_insert_with(|| n.clone());
				if *kind == "quest" {
					if let Some(o) = quest_objective(&t["tooltip"]) {
						out.objective.insert(id, o);
					}
				}
			}
		}
	}
	dates.sort();
	if let (Some(first), Some(last)) = (dates.first(), dates.last()) {
		out.fetched = Some((first.clone(), last.clone()));
	}
	Ok(out)
}
