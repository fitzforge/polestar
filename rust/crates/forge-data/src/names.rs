//! `forge data names`: the names of Polestar's data in each client language, Names.lua in the
//! load-on-demand language folder addon/Polestar_<locale> it shares with our guides' texts
//! (forge_guide::toc::language_addon; docs/ARCHITECTURE.md, "Names"; the runtime side is
//! addon/Polestar/Core/Names.lua). Port of tools/lib/i18n/names.js and the JS `i18n names` command.
//!
//! Kinds: quest, npc, object and item (the ids the data names), and map (instances), encounter (dungeon
//! bosses and events), faction, taxi (flight points) and objective (a quest's objective text, for the
//! dungeon quests whose objective is an event no name covers).
//!
//! Sources, per id, the first one with a name that is no English name winning (names_sources.rs):
//!   1. The Forever client's own tables in that language (items, map, encounter, faction, taxi).
//!   2. The web quest database's Forever pages in that language, only what is cached: the only source
//!      for the names of Forever's own quests, NPCs and objects.
//!   3. DingDB (pinned), whose base data comes from QuestieDB, so --no-questie leaves it out.
//!   4. pfQuest's db/<locale>, for the names DingDB lacks.
//!
//! Only the ids Polestar's data names are kept: the compiled guides (addon/Polestar_Guides/Guides.lua),
//! the quest database (addon/Polestar_QuestDB), the Codex's data (data/forever/codex), the travel data's
//! flight points (addon/Polestar/Nav/TravelData.lua) and the lifts' objects (Polestar_Nav's
//! Chokepoints.lua).

use std::collections::{BTreeMap, BTreeSet, HashMap, HashSet};
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

use forge_guide::i18n_files::lua_string;
use forge_guide::locales::locale as locale_info;
use regex::Regex;

use crate::lua::lua_to_value;
use crate::names_sources::{self as src, ClientNames, PfNames, WebNames};
pub use crate::names_sources::{clean, ding_pin, Ding, Names, Pin, NAME_KINDS};

pub const PACK_KINDS: [&str; 9] = ["quest", "npc", "object", "item", "map", "encounter", "faction", "taxi", "objective"];
pub const SOURCE_KEYS: [&str; 4] = ["wago", "web", "ding", "pfquest"];
const COMMAND: &str = "forge data names";
const OBJECTIVE: usize = 8;
const ENCOUNTER: usize = 5;

fn kind_index(k: &str) -> usize {
	PACK_KINDS.iter().position(|x| *x == k).unwrap()
}

// ---------------------------------------------------------------- the ids Polestar's data names

const LIST: &str = r#"
local function list(set)
  local l = {}
  for id in pairs(set) do l[#l + 1] = id end
  table.sort(l)
  return l
end
return { quest = list(__ids.quest), npc = list(__ids.npc), object = list(__ids.object), item = list(__ids.item) }"#;

/// Every compiled guide's goals, candidates, reagents and rewards: the keys quest, npc, object and item,
/// the quests of pre, preAll and closedBy (one id or a list) and of preTitles (its keys), the prose's
/// {kind:id} tokens (names), and a collect's sources (fromId, fromAlsoId, of kind fromKind).
const GUIDE_WALK: &str = r#"
__ids = { quest = {}, npc = {}, object = {}, item = {} }
local KIND = { quest = "quest", npc = "npc", object = "object", item = "item" }
local QUESTS = { pre = true, preAll = true, closedBy = true }
local function add(kind, v) if type(v) == "number" then __ids[kind][v] = true end end
local function walk(t)
  for k, v in pairs(t) do
    if KIND[k] then add(KIND[k], v)
    elseif QUESTS[k] then
      if type(v) == "table" then for _, q in ipairs(v) do add("quest", q) end else add("quest", v) end
    elseif k == "preTitles" and type(v) == "table" then
      for q in pairs(v) do add("quest", q) end
    elseif k == "names" and type(v) == "table" then
      for key in pairs(v) do
        local kind, id = tostring(key):match("^(%l+):(%d+)$")
        if KIND[kind] then add(KIND[kind], tonumber(id)) end
      end
    end
    if type(v) == "table" then walk(v) end
  end
  local from = (t.fromKind == "npc" or t.fromKind == "object") and t.fromKind or "npc"
  add(from, t.fromId)
  add(from, t.fromAlsoId)
end
Polestar = { RegisterGuide = function(g) if type(g) == "table" then walk(g) end return true end }
"#;

/// The quest database's ids: the "\n<id>\t" lines of each kind's LuaChunks text (Q.AddChunk).
const QUESTDB_ADD: &str = r#"
__ids = { quest = {}, npc = {}, object = {}, item = {} }
local KIND = { quests = "quest", npcs = "npc", objects = "object", items = "item" }
Polestar = { QuestDB = { AddChunk = function(kind, lo, hi, text)
  local into = KIND[kind] and __ids[KIND[kind]]
  if into and type(text) == "string" then for id in text:gmatch("\n(%-?%d+)\t") do into[tonumber(id)] = true end end
end } }
"#;

const QUESTDB_FILES: [&str; 4] = ["Quests.lua", "Npcs.lua", "Objects.lua", "Items.lua"];
const CODEX_FILES: [&str; 4] = ["quests.json", "npcs.json", "objects.json", "items.json"];

/// The ids of quest, npc, object and item, and how many each input names (guides, questdb, codex).
pub struct UsedIds {
	pub ids: [BTreeSet<i64>; 4],
	pub counts: Vec<(&'static str, [usize; 4])>,
}

fn lua_sets(v: &forge_guide::js::V) -> [BTreeSet<i64>; 4] {
	NAME_KINDS.map(|k| v.get(k).items().iter().filter_map(|x| x.as_num()).map(|n| n as i64).collect())
}

fn read_json(file: &Path) -> Result<serde_json::Value, String> {
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))
}

fn read_json_if(file: &Path) -> Result<Option<serde_json::Value>, String> {
	if file.exists() {
		read_json(file).map(Some)
	} else {
		Ok(None)
	}
}

/// JS Number(key) of an object key, when it is an integer.
fn key_id(k: &str) -> Option<i64> {
	let n = forge_guide::js::str_to_num(k);
	(n.is_finite() && n == n.trunc()).then_some(n as i64)
}

pub fn used_ids(guides: &Path, questdb: &Path, codex: &Path) -> Result<UsedIds, String> {
	if !guides.exists() {
		return Err(format!("no compiled guides at {}: run forge guide compile, or pass --guides <Guides.lua>", guides.display()));
	}
	let q_files: Vec<PathBuf> = QUESTDB_FILES.iter().map(|f| questdb.join(f)).collect();
	if q_files.iter().any(|f| !f.exists()) {
		return Err(format!("the quest database is not built (no {}): run forge data questdb, or pass --questdb <Polestar_QuestDB folder>", questdb.join("Quests.lua").display()));
	}
	let c_files: Vec<PathBuf> = CODEX_FILES.iter().map(|f| codex.join(f)).collect();
	if c_files.iter().any(|f| !f.exists()) {
		return Err(format!("the Codex data is not built (no {}): run forge data codex, or pass --codex <data/forever/codex folder>", c_files[0].display()));
	}
	// Polestar's own pack keeps each faction's guides in a part beside it (Polestar_Guides_Alliance, _Horde).
	let parts: Vec<PathBuf> = match (guides.parent(), guides.file_name()) {
		(Some(dir), Some(file)) => {
			let folder = dir.file_name().map(|f| f.to_string_lossy().into_owned()).unwrap_or_default();
			let up = dir.parent().unwrap_or(Path::new("."));
			forge_guide::project::FACTION_PARTS.iter().map(|f| up.join(forge_guide::project::part_addon(&folder, f)).join(file)).filter(|p| p.exists()).collect()
		}
		_ => Vec::new(),
	};
	let g_files: Vec<&Path> = std::iter::once(guides).chain(parts.iter().map(PathBuf::as_path)).collect();
	let g = lua_sets(&lua_to_value(&g_files, GUIDE_WALK, LIST)?);
	let q_refs: Vec<&Path> = q_files.iter().map(PathBuf::as_path).collect();
	let q = lua_sets(&lua_to_value(&q_refs, QUESTDB_ADD, LIST)?);
	let mut c: [BTreeSet<i64>; 4] = Default::default();
	for (k, f) in c_files.iter().enumerate() {
		if let Some(o) = read_json(f)?.as_object() {
			c[k] = o.keys().filter_map(|k| key_id(k)).collect();
		}
	}
	let mut ids: [BTreeSet<i64>; 4] = Default::default();
	let mut counts = Vec::new();
	for (name, sets) in [("guides", g), ("questdb", q), ("codex", c)] {
		counts.push((name, [sets[0].len(), sets[1].len(), sets[2].len(), sets[3].len()]));
		for (k, s) in sets.into_iter().enumerate() {
			ids[k].extend(s);
		}
	}
	Ok(UsedIds { ids, counts })
}

/// The ids of the kinds beside quest, npc, object and item.
pub struct ExtraIds {
	pub map: BTreeSet<i64>,
	pub faction: BTreeSet<i64>,
	pub taxi: BTreeSet<i64>,
	pub objective: BTreeSet<i64>,
	pub lift_object: BTreeSet<i64>,
}

fn js_num(v: &serde_json::Value) -> f64 {
	match v {
		serde_json::Value::Number(n) => n.as_f64().unwrap_or(f64::NAN),
		serde_json::Value::String(s) => forge_guide::js::str_to_num(s),
		serde_json::Value::Bool(b) => f64::from(u8::from(*b)),
		serde_json::Value::Null => 0.0,
		_ => f64::NAN,
	}
}

/// JS String(n) of an integral number as an object key.
fn num_key(n: f64) -> Option<String> {
	(n.is_finite() && n == n.trunc()).then(|| format!("{}", n as i64))
}

fn truthy(v: &serde_json::Value) -> bool {
	match v {
		serde_json::Value::Null => false,
		serde_json::Value::Bool(b) => *b,
		serde_json::Value::Number(n) => n.as_f64().is_some_and(|x| x != 0.0),
		serde_json::Value::String(s) => !s.is_empty(),
		_ => true,
	}
}

/// Instance maps (codex instances.json), factions (codex factions.json), flight points (TravelData.lua's
/// taxi rows), the objectives of the dungeon quests (journal.json) with an objective that is an event or
/// names nothing by id (codex quests.json), and the lifts' game objects the walking map's chokepoints name
/// (`liftObject = <id>`). A missing input leaves its kind empty.
pub fn extra_ids(codex: &Path, travel: &Path, chokepoints: &Path) -> Result<ExtraIds, String> {
	let mut out = ExtraIds { map: BTreeSet::new(), faction: BTreeSet::new(), taxi: BTreeSet::new(), objective: BTreeSet::new(), lift_object: BTreeSet::new() };
	if let Some(serde_json::Value::Object(o)) = read_json_if(&codex.join("instances.json"))? {
		for i in o.values() {
			let m = js_num(&i["map"]);
			if m > 0.0 {
				out.map.insert(m as i64);
			}
		}
	}
	if let Some(serde_json::Value::Object(o)) = read_json_if(&codex.join("factions.json"))? {
		for k in o.keys() {
			let n = forge_guide::js::str_to_num(k);
			if n > 0.0 {
				out.faction.insert(n as i64);
			}
		}
	}
	if chokepoints.exists() {
		static LIFT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\bliftObject[\t\n\x0B\x0C\r ]*=[\t\n\x0B\x0C\r ]*([0-9]+)").unwrap());
		let text = std::fs::read_to_string(chokepoints).map_err(|e| format!("{}: {e}", chokepoints.display()))?;
		for c in LIFT.captures_iter(&text) {
			out.lift_object.insert(forge_guide::js::str_to_num(&c[1]) as i64);
		}
	}
	if travel.exists() {
		let expr = format!(
			r#"
local ids = {{}}
local Nav = setmetatable({{ RegisterTravelData = function(d)
  for _, t in ipairs(type(d) == "table" and d.taxi or {{}}) do if type(t[1]) == "number" then ids[#ids + 1] = t[1] end end
end }}, {{ __index = function() return function() end end }})
local ns = {{ Nav = Nav }}
local ok, err = __polestar_loaddata({}, "Polestar", ns)
if not ok then error(err, 0) end
return ids"#,
			lua_string(&travel.to_string_lossy())
		);
		for v in lua_to_value(&[], "", &expr)?.items() {
			if let Some(n) = v.as_num() {
				out.taxi.insert(n as i64);
			}
		}
	}
	let journal = read_json_if(&codex.join("journal.json"))?;
	let quests = read_json_if(&codex.join("quests.json"))?.unwrap_or(serde_json::Value::Null);
	let quest_of = |n: f64| -> Option<&serde_json::Value> { num_key(n).and_then(|k| quests.get(&k)).filter(|q| truthy(q)) };
	let mut in_journal = BTreeSet::new();
	static QKEY: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"(?i)quest|chain|pre").unwrap());
	fn walk<'a>(v: &serde_json::Value, key: &str, quest_of: &dyn Fn(f64) -> Option<&'a serde_json::Value>, into: &mut BTreeSet<i64>) {
		match v {
			serde_json::Value::Array(a) => {
				for x in a {
					walk(x, key, quest_of, into);
				}
			}
			serde_json::Value::Object(o) => {
				if let Some(id) = o.get("id").and_then(|i| i.as_f64()) {
					if quest_of(id).is_some() {
						into.insert(id as i64);
					}
				}
				for (k, x) in o {
					walk(x, k, quest_of, into);
				}
			}
			serde_json::Value::Number(n) => {
				let n = n.as_f64().unwrap_or(f64::NAN);
				if QKEY.is_match(key) && quest_of(n).is_some() {
					into.insert(n as i64);
				}
			}
			_ => {}
		}
	}
	if let Some(j) = &journal {
		let root = match j.get("dungeons") {
			Some(d) if truthy(d) => d,
			_ => j,
		};
		walk(root, "", &quest_of, &mut in_journal);
	}
	for id in in_journal {
		let q = quest_of(id as f64).unwrap();
		let objectives = q.get("objectives").and_then(|o| o.as_array());
		if objectives.into_iter().flatten().any(|o| truthy(o) && (o.get("type").and_then(|t| t.as_str()) == Some("event") || o.get("id").is_none_or(|i| i.is_null()))) {
			out.objective.insert(id);
		}
	}
	Ok(out)
}

// ---------------------------------------------------------------- merging

/// pfQuest's objective text: its $B line breaks as spaces (other $ tokens stay).
fn objective_text(s: &str) -> String {
	clean(&s.replace("$B", " ").replace("$b", " "))
}

/// Markers of content the game does not use (test, placeholder, retired), in English and the client
/// languages: a name holding one is no name.
static PLACEHOLDER: LazyLock<Regex> = LazyLock::new(|| {
	Regex::new(r"(?i)\[(?:PH|TMP|UNUSED|NOT USED|DEPRECATED|NYI|DNT|INUTILIS[ÉE]|P[ÉE]RIM[ÉE]|OBSOLETO|VERALTET)\]|<(?:NYI|TXT|UNUSED|PH|TMP|DEPRECATED)>|\((?:PH|TMP|NYI|DNT|UNUSED|DEPRECATED|TEST|JEFFTEST|OLD[0-9]*|тест|시험용|测试|測試)\)|^zzOLD|(?-u:\b)DEPRECATED(?-u:\b)").unwrap()
});

fn usable(s: &str) -> bool {
	!s.is_empty() && !PLACEHOLDER.is_match(s)
}

/// English names to tell a translation from a string left in English, per pack kind.
pub type English = [HashMap<i64, HashSet<String>>; 9];

pub fn add_english(english: &mut English, kind: &str, id: i64, name: &str) {
	let n = clean(name);
	if !n.is_empty() {
		english[kind_index(kind)].entry(id).or_default().insert(n);
	}
}

/// The ids to name per pack kind; None: every id the client's table has (encounters).
pub type IdSets = [Option<BTreeSet<i64>>; 9];

/// One language's names.
#[derive(Default)]
pub struct Built {
	pub names: [Names; 9],
	/// The ids whose every name is English.
	pub english: [BTreeSet<i64>; 9],
	/// Per kind, the names each source gave (SOURCE_KEYS order).
	pub from: [[usize; 4]; 9],
}

impl Built {
	pub fn total(&self) -> usize {
		self.names.iter().map(Names::len).sum()
	}
}

pub struct Inputs<'a> {
	pub ids: &'a IdSets,
	/// None: --no-questie.
	pub ding: Option<&'a BTreeMap<String, [Names; 4]>>,
	/// With enUS among its locales.
	pub pf: &'a BTreeMap<String, PfNames>,
	pub wago: Option<&'a BTreeMap<String, src::KindNames>>,
	pub web: Option<&'a BTreeMap<String, WebNames>>,
	pub english: &'a English,
}

/// Per id the first source with a name that is no English name wins, so any real translation beats a
/// string some source left in English; an id whose names are all English gets none (the English shows
/// anyway). A name with a placeholder marker is none.
pub fn build_names(locales: &[&str], i: &Inputs) -> BTreeMap<String, Built> {
	let mut out = BTreeMap::new();
	let en = i.pf.get("enUS");
	for &locale in locales {
		let w = i.wago.and_then(|m| m.get(locale));
		let h = i.web.and_then(|m| m.get(locale));
		let d = i.ding.and_then(|m| m.get(locale));
		let p = i.pf.get(locale);
		let mut b = Built::default();
		for (k, kind) in PACK_KINDS.iter().enumerate() {
			let wk = w.and_then(|w| w.get(kind));
			let list: Vec<i64> = match &i.ids[k] {
				Some(s) => s.iter().copied().collect(),
				None => wk.map(|m| m.keys().copied().collect()).unwrap_or_default(),
			};
			let text = |s: &str| if k == OBJECTIVE { objective_text(s) } else { clean(s) };
			fn pf_of(p: Option<&PfNames>, k: usize, id: i64) -> Option<&String> {
				p.and_then(|p| if k == OBJECTIVE { p.objective.get(&id) } else { p.kinds.get(k).and_then(|m| m.get(&id)) })
			}
			for id in list {
				let mut english: HashSet<String> = HashSet::new();
				if let Some(set) = i.english[k].get(&id) {
					english.extend(set.iter().map(|n| text(n)).filter(|n| !n.is_empty()));
				}
				for n in [pf_of(en, k, id), h.and_then(|h| h.english.get(k)).and_then(|m| m.get(&id))].into_iter().flatten() {
					let t = text(n);
					if !t.is_empty() {
						english.insert(t);
					}
				}
				let candidates: Vec<(usize, Option<&String>)> = if k == OBJECTIVE {
					vec![(1, h.and_then(|h| h.objective.get(&id))), (3, pf_of(p, k, id))]
				} else {
					vec![(0, wk.and_then(|m| m.get(&id))), (1, h.and_then(|h| h.names.get(k)).and_then(|m| m.get(&id))), (2, d.and_then(|d| d.get(k)).and_then(|m| m.get(&id))), (3, pf_of(p, k, id))]
				};
				let named: Vec<(usize, String)> = candidates.into_iter().map(|(s, v)| (s, v.map(|v| text(v)).unwrap_or_default())).filter(|(_, v)| usable(v)).collect();
				match named.iter().find(|(_, v)| !english.contains(v)) {
					Some((s, v)) => {
						b.names[k].insert(id, v.clone());
						b.from[k][*s] += 1;
					}
					None => {
						if !named.is_empty() {
							b.english[k].insert(id);
						}
					}
				}
			}
		}
		out.insert(locale.to_string(), b);
	}
	out
}

// ---------------------------------------------------------------- output

/// What the pack was built from.
pub struct Sources<'a> {
	/// The client tables' (product, build) and URLs.
	pub wago: Option<(&'a [(&'static str, String)], &'a [String])>,
	/// None unless some language's web names were cached.
	pub web: Option<&'a BTreeMap<String, WebNames>>,
	pub ding: Option<&'a Ding>,
	/// pfQuest's folder (its licence) and revision.
	pub pf_dir: Option<&'a Path>,
	pub pf_revision: Option<&'a str>,
}

pub fn source_label(s: &Sources) -> String {
	let mut parts = Vec::new();
	if let Some((builds, _)) = s.wago {
		parts.push(format!("the client's tables ({}, wago.tools)", builds.iter().map(|b| b.1.as_str()).collect::<Vec<_>>().join(", ")));
	}
	if s.web.is_some() {
		parts.push("the web quest database".into());
	}
	if let Some(d) = s.ding {
		parts.push(format!("DingDB {}", d.pin.version));
	}
	parts.push(format!("pfQuest{}", s.pf_revision.map(|r| format!(" {}", &r[..7.min(r.len())])).unwrap_or_default()));
	if parts.len() > 1 {
		let last = parts.pop().unwrap();
		format!("{} and {last}", parts.join(", "))
	} else {
		parts.pop().unwrap()
	}
}

const KIND_WORDS: [(&str, &str); 9] = [
	("quest", "quests"),
	("NPC", "NPCs"),
	("object", "objects"),
	("item", "items"),
	("instance", "instances"),
	("encounter", "encounters"),
	("faction", "factions"),
	("flight point", "flight points"),
	("quest objective", "quest objectives"),
];

pub fn license_text(locale: &str, built: &Built, s: &Sources) -> Result<String, String> {
	let language = locale_info(locale).ok_or_else(|| format!("unknown locale {locale}"))?.language;
	let counts = |si: usize| {
		let parts: Vec<String> =
			(0..9).filter(|&k| built.from[k][si] > 0).map(|k| format!("{} {}", built.from[k][si], if built.from[k][si] == 1 { KIND_WORDS[k].0 } else { KIND_WORDS[k].1 })).collect();
		if parts.is_empty() {
			"none".to_string()
		} else {
			parts.join(", ")
		}
	};
	let title = format!("Polestar names ({locale}): third-party notices");
	let mut out: Vec<String> = vec![
		title.clone(),
		"=".repeat(title.encode_utf16().count()),
		String::new(),
		"The names in this folder (quests, NPCs, objects, items, instances, dungeon".into(),
		"encounters, factions, flight points and some quest objectives) are the game's".into(),
		format!("texts in {language}, for Polestar. Names and texts of the game belong to"),
		"Blizzard Entertainment. They come from the sources below, in this order, the".into(),
		"first one with a name for an id winning.".into(),
		String::new(),
	];
	if let Some((builds, urls)) = s.wago {
		out.push("World of Warcraft client tables, via wago.tools".into());
		out.push("-----------------------------------------------".into());
		for (product, build) in builds {
			let what = match *product {
				"forever" => "World of Warcraft: Forever (wow_classic_beta)",
				"era" => "Classic Era (wow_classic_era), for the items Forever's table lacks",
				p => p,
			};
			out.push(format!("Build: {build}, {what}"));
		}
		let mut urls = urls.to_vec();
		urls.sort();
		for u in urls {
			out.push(format!("Table: {}", u.replacen("<locale>", locale, 1)));
		}
		out.push("The client's own strings: names only.".into());
		out.push(format!("Names taken: {}.", counts(0)));
		out.push(String::new());
	}
	if let Some(wh) = s.web.and_then(|w| w.get(locale)) {
		out.push("The web quest database, World of Warcraft: Forever pages".into());
		out.push("--------------------------------------------------------".into());
		out.push(format!("Pages: the {language} list pages and tooltips"));
		if let Some((first, last)) = &wh.fetched {
			out.push(format!("Read: {} to {}", first.chars().take(10).collect::<String>(), last.chars().take(10).collect::<String>()));
		}
		out.push("Public web pages; the game's names only (facts), credited in THIRD_PARTY.md.".into());
		out.push(format!("Names taken: {}.", counts(1)));
		out.push(String::new());
	}
	if let Some(d) = s.ding {
		out.push("DingDB, the game database of Ding! by Yendi (@moust4ki)".into());
		out.push("-------------------------------------------------------".into());
		out.push(format!("URL: {}", d.pin.repo));
		out.push(format!("Version: {}, commit {}", d.pin.version, d.pin.commit));
		let mine = src::ding_file(locale);
		for (p, h) in d.files.iter().filter(|(p, _)| *p == mine || p == src::CREDITS) {
			out.push(format!("File: {p} (sha256 {h})"));
		}
		out.push("License: GPL-3.0 (Copyright Yendi), used in Polestar with his permission".into());
		out.push("(THIRD_PARTY.md in the Polestar repository).".into());
		out.push(format!("Names taken: {}.", counts(2)));
		out.push("DingDB's base data is generated from Questie and QuestieDB: see CREDITS.md".into());
		out.push("beside this file.".into());
		out.push(String::new());
	} else {
		out.push("Built with --no-questie: no names from DingDB (whose base data comes from".into());
		out.push("QuestieDB).".into());
		out.push(String::new());
	}
	out.push("pfQuest database by Shagu".into());
	out.push("-------------------------".into());
	out.push(format!("URL: {}", crate::pfquest::REPO));
	if let Some(r) = s.pf_revision {
		out.push(format!("Revision: {r}"));
	}
	out.push(format!("Files: db/{locale}/{{quests,units,objects,items}}.lua"));
	out.push("License: MIT".into());
	out.push(format!("Names taken: {} (the ones the sources above lack).", counts(3)));
	if let Some(dir) = s.pf_dir {
		let notice = crate::pfquest::check_license(dir)?.notice;
		if !notice.is_empty() {
			out.push(String::new());
			out.push(notice);
		}
	}
	out.push(String::new());
	Ok(out.join("\n"))
}

/// The TOC's version and interface.
pub struct Meta {
	pub version: String,
	pub iface: String,
}

/// package.json's version and addon/Polestar/Polestar.toc's interface under `root`.
pub fn meta(root: &Path) -> Result<Meta, String> {
	let pkg = read_json(&root.join("package.json"))?;
	let version = pkg["version"].as_str().ok_or("package.json has no version")?.to_string();
	let iface = forge_guide::project::core_interface(root)?;
	Ok(Meta { version, iface })
}

/// One language's Names.lua: per kind, LuaChunks text (forge-core luachunks) of "<id>\t<name>" lines, the
/// name luachunks::field-escaped, registered through Polestar.Names.AddChunk with the pack's locale (the
/// runtime keeps the client's own only). `sources`: what the header names as the pack's sources.
pub fn names_lua(locale: &str, built: &Built, sources: &str) -> Result<String, String> {
	use forge_core::luachunks;
	let language = locale_info(locale).ok_or_else(|| format!("unknown locale {locale}"))?.language;
	let mut out = format!(
		"{}\n-- Names in {language} ({locale}) for Polestar.Names (addon/Polestar/Core/Names.lua), by kind.\n-- One name a line, \"<id>\\t<name>\" (% ; , : | tab and line breaks as %XX), read on demand.\n-- Sources and licences: LICENSE-DATA.txt.\n\nlocal N = Polestar and Polestar.Names\nif not (N and N.AddChunk) then return end\nlocal function R(kind, lo, hi, text) N.AddChunk({}, kind, lo, hi, text) end\n",
		forge_guide::emit::header("lua", COMMAND, sources),
		lua_string(locale)
	);
	for (k, kind) in PACK_KINDS.iter().enumerate() {
		let records: Vec<(i64, String)> = built.names[k].iter().map(|(id, n)| (*id, luachunks::field(n))).collect();
		let chunks = luachunks::chunks(&records, luachunks::Options::default());
		for c in &chunks {
			out.push_str(&format!("R({}, {}, {}, {})\n", lua_string(kind), c.lo, c.hi, luachunks::long_string(&c.text)));
		}
	}
	Ok(out)
}

/// One language's files in its language folder: (file name, text). The TOC is the folder's, the same
/// one `forge guide compile` writes beside its Texts.lua (forge_guide::toc::language_toc).
pub fn emit_names_addon(locale: &str, built: &Built, meta: &Meta, s: &Sources) -> Result<Vec<(String, String)>, String> {
	locale_info(locale).ok_or_else(|| format!("unknown locale {locale}"))?;
	let name = forge_guide::toc::language_addon(locale);
	let toc = forge_guide::toc::language_toc(locale, &meta.iface, &meta.version);
	let lua = names_lua(locale, built, &source_label(s))?;
	let mut files = vec![(format!("{name}.toc"), toc), ("Names.lua".into(), lua), ("LICENSE-DATA.txt".into(), license_text(locale, built, s)?)];
	if let Some(d) = s.ding {
		let f = d.dir.join(src::CREDITS);
		files.push(("CREDITS.md".into(), std::fs::read_to_string(&f).map_err(|e| format!("{}: {e}", f.display()))?));
	}
	Ok(files)
}

/// The files of a language folder `forge data names` owns (the TOC aside): what it removes when a
/// language is left without names or a source drops out. Texts.lua is `forge guide compile`'s.
const NAMES_FILES: [&str; 3] = ["Names.lua", "LICENSE-DATA.txt", "CREDITS.md"];

pub struct Written {
	pub locale: String,
	pub dir: PathBuf,
	pub bytes: usize,
}

/// Writes each language with names into its language folder addons_dir/Polestar_<locale>, leaving our
/// guides' Texts.lua there alone: the names' files the folder no longer gets are removed, and those of
/// a language left without any (the folder too once it holds no texts). The retired
/// Polestar_Names_<locale> folder (before 0.3.0) is removed.
pub fn write_names_addons(out: &BTreeMap<String, Built>, addons_dir: &Path, meta: &Meta, s: &Sources) -> Result<Vec<Written>, String> {
	let mut written = Vec::new();
	fn io(p: &Path) -> impl Fn(std::io::Error) -> String + '_ {
		move |e| format!("{}: {e}", p.display())
	}
	for (locale, built) in out {
		let retired = addons_dir.join(format!("Polestar_Names_{locale}"));
		if retired.is_dir() {
			std::fs::remove_dir_all(&retired).map_err(io(&retired))?;
		}
		let dir = addons_dir.join(forge_guide::toc::language_addon(locale));
		let files = if built.total() == 0 { Vec::new() } else { emit_names_addon(locale, built, meta, s)? };
		for f in NAMES_FILES {
			let p = dir.join(f);
			if p.exists() && !files.iter().any(|(n, _)| n == f) {
				std::fs::remove_file(&p).map_err(io(&p))?;
			}
		}
		if files.is_empty() {
			if dir.is_dir() && !dir.join("Texts.lua").exists() {
				std::fs::remove_dir_all(&dir).map_err(io(&dir))?;
			}
			continue;
		}
		std::fs::create_dir_all(&dir).map_err(io(&dir))?;
		let mut bytes = 0;
		for (f, text) in &files {
			std::fs::write(dir.join(f), text).map_err(io(&dir.join(f)))?;
			bytes += text.len();
		}
		written.push(Written { locale: locale.clone(), dir, bytes });
	}
	Ok(written)
}

/// The ids whose every name is the English one, per locale and kind, merged into `file`
/// (data/local/names-same-as-english.json; the locales built this run replace theirs).
pub fn write_same_as_english(out: &BTreeMap<String, Built>, file: &Path) -> Result<(), String> {
	let mut doc = match read_json_if(file)? {
		Some(serde_json::Value::Object(o)) => o,
		_ => serde_json::Map::new(),
	};
	for (locale, built) in out {
		let mut m = serde_json::Map::new();
		for (k, kind) in PACK_KINDS.iter().enumerate() {
			if !built.english[k].is_empty() {
				m.insert(kind.to_string(), built.english[k].iter().copied().collect());
			}
		}
		doc.insert(locale.clone(), serde_json::Value::Object(m));
	}
	if let Some(p) = file.parent() {
		std::fs::create_dir_all(p).map_err(|e| format!("{}: {e}", p.display()))?;
	}
	std::fs::write(file, format!("{}\n", serde_json::Value::Object(doc))).map_err(|e| format!("{}: {e}", file.display()))
}

// ---------------------------------------------------------------- the command

pub struct Options {
	/// The checkout (package.json, addon/Polestar/Polestar.toc, data/local).
	pub root: PathBuf,
	pub locales: Vec<String>,
	pub offline: bool,
	pub no_questie: bool,
	pub no_tables: bool,
	pub build: Option<String>,
	pub sources: PathBuf,
	/// Some: a folder the user named (used as it is).
	pub ding: Option<PathBuf>,
	/// The DingDB pin (ding_pin()).
	pub pin: Pin,
	pub pfquest: Option<PathBuf>,
	pub guides: PathBuf,
	pub questdb: PathBuf,
	pub codex: PathBuf,
	pub travel: PathBuf,
	pub chokepoints: PathBuf,
	pub out: PathBuf,
	/// Writes data/local/names-same-as-english.json (a build into the checkout's addon folder).
	pub same_as_english: bool,
}

impl Options {
	/// The defaults under `root`, every locale.
	pub fn new(root: &Path) -> Options {
		Options {
			root: root.to_path_buf(),
			locales: forge_guide::locales::LOCALE_CODES.map(String::from).to_vec(),
			offline: false,
			no_questie: false,
			no_tables: false,
			build: None,
			sources: root.join("data/sources"),
			ding: None,
			pin: ding_pin(),
			pfquest: None,
			guides: root.join("addon/Polestar_Guides/Guides.lua"),
			questdb: root.join("addon/Polestar_QuestDB"),
			codex: root.join("data/forever/codex"),
			travel: root.join("addon/Polestar/Nav/TravelData.lua"),
			chokepoints: root.join("addon/Polestar_Nav/Nav/Chokepoints.lua"),
			out: root.join("addon"),
			same_as_english: true,
		}
	}
}

/// What a run built and wrote, for the report.
pub struct Report {
	pub locales: Vec<String>,
	pub ids: IdSets,
	pub counts: Vec<(&'static str, [usize; 4])>,
	pub builds: Option<Vec<(&'static str, String)>>,
	/// locale -> fetched (first, last), when the web names are used.
	pub web: Option<BTreeMap<String, Option<(String, String)>>>,
	/// (version, commit, revision).
	pub ding: Option<(String, String, Option<String>)>,
	pub pf_revision: Option<String>,
	pub built: BTreeMap<String, Built>,
	pub written: Vec<Written>,
	pub warnings: Vec<String>,
}

pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<Report, String> {
	let wanted: Vec<&str> = o.locales.iter().map(String::as_str).collect();
	for l in &wanted {
		if locale_info(l).is_none() {
			return Err(format!("unknown locale {l} (one of {})", forge_guide::locales::LOCALE_CODES.join(", ")));
		}
	}
	let used = used_ids(&o.guides, &o.questdb, &o.codex)?;
	let extra = extra_ids(&o.codex, &o.travel, &o.chokepoints)?;
	let [quest, npc, mut object, item] = used.ids;
	object.extend(extra.lift_object.iter().copied());
	let ids: IdSets = [Some(quest), Some(npc), Some(object), Some(item), Some(extra.map), None, Some(extra.faction), Some(extra.taxi), Some(extra.objective)];

	let pf_dir = o.pfquest.clone().unwrap_or_else(|| o.sources.join("pfQuest"));
	let pf_info = crate::pfquest::ensure(&pf_dir, o.pfquest.is_some())?;
	let warnings = pf_info.warnings.clone();
	let ding = if o.no_questie { None } else { Some(src::ensure_ding(&o.ding.clone().unwrap_or_else(|| o.sources.join("ding")), o.ding.is_some(), o.offline, o.pin.clone(), log)?) };
	let mut pf_locales = wanted.clone();
	pf_locales.push("enUS");
	let pf = src::load_pfquest_names(&pf_info.dir, &pf_locales)?;
	let ding_names = ding.as_ref().map(|d| src::read_ding(d, &wanted)).transpose()?;

	let mut english: English = Default::default();
	let tables: Option<ClientNames> = if o.no_tables { None } else { Some(src::load_client_names(&o.sources, &wanted, o.build.as_deref(), o.offline, log)?) };
	if let Some(t) = &tables {
		for (kind, m) in &t.english {
			for (id, n) in m {
				add_english(&mut english, kind, *id, n);
			}
		}
	}
	for (k, file) in CODEX_FILES.iter().enumerate() {
		let f = o.codex.join(file);
		if let Some(serde_json::Value::Object(m)) = read_json_if(&f)? {
			for (id, r) in m {
				let n = match (r.get("name"), r.get("title")) {
					(Some(v), _) if truthy(v) => v,
					(_, Some(v)) => v,
					_ => continue,
				};
				if let (Some(n), Some(id)) = (n.as_str(), key_id(&id)) {
					add_english(&mut english, NAME_KINDS[k], id, n);
				}
			}
		}
	}
	let web: BTreeMap<String, WebNames> = wanted.iter().map(|l| Ok((l.to_string(), src::load_web_names(&o.sources, l)?))).collect::<Result<_, String>>()?;
	let built = build_names(&wanted, &Inputs { ids: &ids, ding: ding_names.as_ref(), pf: &pf, wago: tables.as_ref().map(|t| &t.names), web: Some(&web), english: &english });
	if tables.is_some() {
		for l in &wanted {
			for kind in ["map", "faction", "taxi"] {
				let k = kind_index(kind);
				let n = ids[k].as_ref().map_or(0, BTreeSet::len);
				if n > 0 && built[*l].names[k].is_empty() {
					return Err(format!("{l}: no {kind} names from the client tables ({n} wanted); nothing written"));
				}
			}
		}
	}
	let web_used = web.values().any(|w| w.fetched.is_some());
	let sources = Sources {
		wago: tables.as_ref().map(|t| (t.builds.as_slice(), t.urls.as_slice())),
		web: web_used.then_some(&web),
		ding: ding.as_ref(),
		pf_dir: Some(&pf_info.dir),
		pf_revision: pf_info.revision.as_deref(),
	};
	let meta = meta(&o.root)?;
	let written = write_names_addons(&built, &o.out, &meta, &sources)?;
	if o.same_as_english {
		write_same_as_english(&built, &o.root.join("data/local/names-same-as-english.json"))?;
	}
	Ok(Report {
		locales: o.locales.clone(),
		ids,
		counts: used.counts,
		builds: tables.map(|t| t.builds),
		web: web_used.then(|| web.iter().map(|(l, w)| (l.clone(), w.fetched.clone())).collect()),
		ding: ding.map(|d| (d.pin.version, d.pin.commit, d.revision)),
		pf_revision: pf_info.revision,
		built,
		written,
		warnings,
	})
}

impl Report {
	fn lacking(&self, l: &str) -> [Option<usize>; 9] {
		let b = &self.built[l];
		std::array::from_fn(|k| self.ids[k].as_ref().map(|s| s.iter().filter(|id| !b.names[k].contains_key(id) && !b.english[k].contains(id)).count()))
	}

	fn same_as_english(&self, l: &str) -> [Option<usize>; 9] {
		let b = &self.built[l];
		std::array::from_fn(|k| self.ids[k].as_ref().map(|_| b.english[k].len()))
	}

	/// The `--json` document (the JS's, two-space indented).
	pub fn json(&self) -> String {
		use serde_json::{json, Map, Value};
		let kinds = |f: &dyn Fn(usize) -> Value| -> Value { Value::Object(PACK_KINDS.iter().enumerate().map(|(k, n)| (n.to_string(), f(k))).collect()) };
		let opt = |a: [Option<usize>; 9]| -> Value { Value::Object(PACK_KINDS.iter().zip(a).filter_map(|(n, v)| v.map(|v| (n.to_string(), json!(v)))).collect()) };
		let mut ids = match kinds(&|k| self.ids[k].as_ref().map_or(Value::Null, |s| json!(s.len()))) {
			Value::Object(m) => m,
			_ => unreachable!(),
		};
		ids.insert(
			"sources".into(),
			Value::Object(self.counts.iter().map(|(s, c)| (s.to_string(), Value::Object(NAME_KINDS.iter().zip(c).map(|(k, n)| (k.to_string(), json!(n))).collect()))).collect()),
		);
		let locales: Map<String, Value> = self
			.locales
			.iter()
			.map(|l| {
				let b = &self.built[l.as_str()];
				let w = self.written.iter().find(|w| w.locale == *l);
				let from = kinds(&|k| Value::Object(SOURCE_KEYS.iter().zip(b.from[k]).map(|(s, n)| (s.to_string(), json!(n))).collect()));
				(
					l.clone(),
					json!({ "names": kinds(&|k| json!(b.names[k].len())), "lacking": opt(self.lacking(l)), "sameAsEnglish": opt(self.same_as_english(l)), "from": from, "bytes": w.map_or(0, |w| w.bytes) }),
				)
			})
			.collect();
		let doc = json!({
			"ids": Value::Object(ids),
			"wago": self.builds.as_ref().map_or(Value::Null, |b| Value::Object(b.iter().map(|(p, v)| (p.to_string(), json!(v))).collect())),
			"web": self.web.as_ref().map_or(Value::Null, |w| Value::Object(w.iter().map(|(l, f)| (l.clone(), f.as_ref().map_or(Value::Null, |(a, b)| json!({ "first": a, "last": b })))).collect())),
			"ding": self.ding.as_ref().map_or(Value::Null, |(v, c, r)| json!({ "version": v, "commit": c, "revision": r })),
			"pfquest": { "revision": self.pf_revision },
			"locales": Value::Object(locales),
		});
		serde_json::to_string_pretty(&doc).unwrap()
	}

	/// The text report, one line each.
	pub fn lines(&self, cwd: &Path) -> Vec<String> {
		const WORDS: [&str; 9] = ["quest", "NPC", "object", "item", "instance", "encounter", "faction", "flight point", "quest objective"];
		const SOURCE_WORDS: [&str; 4] = ["client tables", "the web quest database", "DingDB", "pfQuest"];
		let plural = |n: usize, w: &str| format!("{n} {w}{}", if n == 1 { "" } else { "s" });
		let id_line = |c: &[Option<usize>]| c.iter().enumerate().filter_map(|(k, n)| n.map(|n| plural(n, WORDS[k]))).collect::<Vec<_>>().join(", ");
		let mut out = Vec::new();
		let all: Vec<Option<usize>> = self.ids.iter().map(|s| s.as_ref().map(BTreeSet::len)).collect();
		out.push(format!("ids Polestar's data names: {}{}", id_line(&all), if self.ids[ENCOUNTER].is_none() { ", every encounter" } else { "" }));
		for (s, c) in &self.counts {
			out.push(format!("  {s}: {}", id_line(&c.map(Some))));
		}
		out.push(match &self.builds {
			Some(b) => format!("client tables: {}", b.iter().map(|(p, v)| format!("{p} {v}")).collect::<Vec<_>>().join(", ")),
			None => "client tables left out".into(),
		});
		let mut dates: Vec<&String> = self.web.iter().flat_map(|w| w.values()).flatten().flat_map(|(a, b)| [a, b]).collect();
		dates.sort();
		out.push(match (dates.first(), dates.last()) {
			(Some(a), Some(b)) => format!("web quest database: the cache, read {} to {}", &a[..10.min(a.len())], &b[..10.min(b.len())]),
			_ => "web quest database: nothing cached".into(),
		});
		out.push(match &self.ding {
			Some((v, c, _)) => format!("DingDB {v} ({}): every pinned file matches its sha256", &c[..7]),
			None => "DingDB left out (--no-questie)".into(),
		});
		out.push(format!("pfQuest {}", self.pf_revision.as_deref().map_or("(revision unknown)".into(), |r| r[..7.min(r.len())].to_string())));
		for l in &self.locales {
			let b = &self.built[l.as_str()];
			let Some(w) = self.written.iter().find(|w| w.locale == *l) else {
				out.push(format!("{l}: no names; no folder"));
				continue;
			};
			let from: Vec<String> = (0..4).map(|s| format!("{} {}", SOURCE_WORDS[s], (0..9).map(|k| b.from[k][s]).sum::<usize>())).collect();
			let sizes: Vec<Option<usize>> = b.names.iter().map(|m| Some(m.len())).collect();
			let dir = pathdiff(&w.dir, cwd);
			out.push(format!(
				"{l}: {} ({}); the English one for {}; none for {}; {}, {} KB",
				id_line(&sizes),
				from.join(", "),
				id_line(&self.same_as_english(l)),
				id_line(&self.lacking(l)),
				if dir.is_empty() { ".".into() } else { dir },
				forge_core::jsnum::js_to_fixed(w.bytes as f64 / 1024.0, 0)
			));
		}
		out
	}
}

/// path.relative(cwd, p) for the report.
fn pathdiff(p: &Path, cwd: &Path) -> String {
	let a: Vec<_> = p.components().collect();
	let b: Vec<_> = cwd.components().collect();
	let common = a.iter().zip(&b).take_while(|(x, y)| x == y).count();
	let mut parts: Vec<String> = std::iter::repeat_n("..".to_string(), b.len() - common).collect();
	parts.extend(a[common..].iter().map(|c| c.as_os_str().to_string_lossy().to_string()));
	parts.join("/")
}
