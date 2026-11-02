//! QuestieDB's baked Forever store (QuestieDB_Forever.toc) and its support data (port of
//! tools/lib/data/questie.js). Reads the copy installed with the game; nothing of it is copied
//! into the repository. TOC metadata values are base64 CBOR (ids: zlib-compressed CBOR), chunked
//! as `~N~` + parts; field schemas come from the installed src/meta/*.lua run under Lua 5.1.

use std::io::Read;
use std::path::{Path, PathBuf};

use forge_guide::js::{cmp_utf16, num_str, Arr, Obj, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{lua_get, lua_get_i, lua_list};
use crate::lua::lua_to_value;

pub const REPO: &str = "https://github.com/Questie/QuestieDB";
pub const QUESTIE_REPO: &str = "https://github.com/Questie/Questie";
pub const TOC: &str = "QuestieDB_Forever.toc";
const ENTITIES: [(&str, &str); 4] = [("Quest", "questMeta.lua"), ("Npc", "npcMeta.lua"), ("Object", "objectMeta.lua"), ("Item", "itemMeta.lua")];

// ---------------------------------------------------------------- base64, CBOR

/// Node's lenient base64 (standard or URL alphabet, other characters skipped, stops at `=`).
pub fn base64(s: &str) -> Vec<u8> {
	let mut out = Vec::with_capacity(s.len() * 3 / 4);
	let (mut acc, mut bits) = (0u32, 0u32);
	for b in s.bytes() {
		let v = match b {
			b'A'..=b'Z' => b - b'A',
			b'a'..=b'z' => b - b'a' + 26,
			b'0'..=b'9' => b - b'0' + 52,
			b'+' | b'-' => 62,
			b'/' | b'_' => 63,
			b'=' => break,
			_ => continue,
		};
		acc = (acc << 6) | v as u32;
		bits += 6;
		if bits >= 8 {
			bits -= 8;
			out.push((acc >> bits) as u8);
			acc &= (1 << bits) - 1;
		}
	}
	out
}

#[derive(Clone)]
enum K {
	N(f64),
	S(String),
	B(bool),
}

fn key_string(k: &K) -> String {
	match k {
		K::N(n) => num_str(*n),
		K::S(s) => s.clone(),
		K::B(b) => b.to_string(),
	}
}

/// questie.js luaTable: keys exactly 1..n in order -> array, else an object.
fn lua_table(entries: Vec<(K, V)>) -> V {
	let dense = entries.iter().enumerate().all(|(i, (k, _))| matches!(k, K::N(n) if *n == (i + 1) as f64));
	if dense {
		return V::Arr(Arr::from_vec(entries.into_iter().map(|(_, v)| v).collect()));
	}
	let o = Obj::new();
	for (k, v) in entries {
		o.set(&key_string(&k), v);
	}
	V::Obj(o)
}

enum Item {
	V(V),
	Break,
}

struct Cbor<'a> {
	b: &'a [u8],
	o: usize,
}

impl Cbor<'_> {
	fn need(&self, n: usize) -> Result<(), String> {
		if self.o + n > self.b.len() {
			Err(format!("CBOR: truncated at byte {}", self.o))
		} else {
			Ok(())
		}
	}
	fn arg(&mut self, ai: u8) -> Result<i64, String> {
		Ok(match ai {
			0..=23 => ai as i64,
			24 => {
				self.need(1)?;
				self.o += 1;
				self.b[self.o - 1] as i64
			}
			25 => {
				self.need(2)?;
				self.o += 2;
				u16::from_be_bytes([self.b[self.o - 2], self.b[self.o - 1]]) as i64
			}
			26 => {
				self.need(4)?;
				self.o += 4;
				u32::from_be_bytes(self.b[self.o - 4..self.o].try_into().unwrap()) as i64
			}
			27 => {
				self.need(8)?;
				self.o += 8;
				let v = u64::from_be_bytes(self.b[self.o - 8..self.o].try_into().unwrap());
				if v > 9007199254740991 {
					return Err("CBOR: integer beyond 2^53".into());
				}
				v as i64
			}
			31 => -1,
			_ => return Err(format!("CBOR: reserved additional info {ai}")),
		})
	}
	fn val(&mut self) -> Result<V, String> {
		match self.item()? {
			Item::V(v) => Ok(v),
			Item::Break => Ok(V::Undef),
		}
	}
	fn item(&mut self) -> Result<Item, String> {
		self.need(1)?;
		let b = self.b[self.o];
		self.o += 1;
		let (mt, ai) = (b >> 5, b & 31);
		Ok(Item::V(match mt {
			0 => V::Num(self.arg(ai)? as f64),
			1 => V::Num(-1.0 - self.arg(ai)? as f64),
			2 | 3 => {
				let n = self.arg(ai)?;
				if n < 0 {
					let mut s = String::new();
					loop {
						match self.item()? {
							Item::Break => break,
							Item::V(p) => s.push_str(&p.to_js_string()),
						}
					}
					V::Str(s.into())
				} else {
					let n = n as usize;
					self.need(n)?;
					self.o += n;
					V::Str(String::from_utf8_lossy(&self.b[self.o - n..self.o]).into_owned().into())
				}
			}
			4 => {
				let n = self.arg(ai)?;
				let mut entries = Vec::new();
				if n < 0 {
					let mut i = 1;
					loop {
						match self.item()? {
							Item::Break => break,
							Item::V(v) => entries.push((K::N(i as f64), v)),
						}
						i += 1;
					}
				} else {
					for i in 1..=n {
						let v = self.val()?;
						entries.push((K::N(i as f64), v));
					}
				}
				lua_table(entries.into_iter().filter(|(_, v)| !v.is_nullish()).collect())
			}
			5 => {
				let n = self.arg(ai)?;
				let mut entries: Vec<(K, V)> = Vec::new();
				let mut add = |s: &mut Self, k: Item| -> Result<bool, String> {
					let Item::V(k) = k else { return Ok(false) };
					let v = s.val()?;
					if !k.is_nullish() && !v.is_nullish() {
						let key = match &k {
							V::Num(n) => K::N(*n),
							V::Str(x) => K::S(x.to_string()),
							V::Bool(b) => K::B(*b),
							o => K::S(o.to_js_string()),
						};
						entries.push((key, v));
					}
					Ok(true)
				};
				if n < 0 {
					loop {
						let k = self.item()?;
						if !add(self, k)? {
							break;
						}
					}
				} else {
					for _ in 0..n {
						let k = self.item()?;
						add(self, k)?;
					}
				}
				entries.sort_by(|a, b| match (&a.0, &b.0) {
					(K::N(x), K::N(y)) => (x - y).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal),
					(K::N(_), _) => std::cmp::Ordering::Less,
					(_, K::N(_)) => std::cmp::Ordering::Greater,
					_ => std::cmp::Ordering::Equal,
				});
				lua_table(entries)
			}
			6 => {
				self.arg(ai)?;
				return self.item();
			}
			_ => match ai {
				20 => V::Bool(false),
				21 => V::Bool(true),
				22 | 23 => V::Null,
				25 => {
					self.need(2)?;
					let h = u16::from_be_bytes([self.b[self.o], self.b[self.o + 1]]);
					self.o += 2;
					let e = ((h >> 10) & 31) as i32;
					let f = (h & 1023) as f64;
					let v = if e == 0 {
						f * 2f64.powi(-24)
					} else if e == 31 {
						if f != 0.0 {
							f64::NAN
						} else {
							f64::INFINITY
						}
					} else {
						(1.0 + f / 1024.0) * 2f64.powi(e - 15)
					};
					V::Num(if h & 0x8000 != 0 { -v } else { v })
				}
				26 => {
					self.need(4)?;
					self.o += 4;
					V::Num(f32::from_be_bytes(self.b[self.o - 4..self.o].try_into().unwrap()) as f64)
				}
				27 => {
					self.need(8)?;
					self.o += 8;
					V::Num(f64::from_be_bytes(self.b[self.o - 8..self.o].try_into().unwrap()))
				}
				31 => return Ok(Item::Break),
				_ => return Err(format!("CBOR: unsupported simple value {ai}")),
			},
		}))
	}
}

pub fn decode_cbor(b: &[u8]) -> Result<V, String> {
	let mut c = Cbor { b, o: 0 };
	let v = match c.item()? {
		Item::Break => return Err("CBOR: unexpected break".into()),
		Item::V(v) => v,
	};
	if c.o != b.len() {
		return Err(format!("CBOR: {} trailing bytes", b.len() - c.o));
	}
	Ok(v)
}

// ---------------------------------------------------------------- TOC store

/// `## Key: value` lines -> the first value of each key.
pub fn parse_toc(text: &str) -> FxHashMap<String, String> {
	let mut out = FxHashMap::default();
	let ws = |c: char| c.is_whitespace() || c == '\u{feff}';
	for line in text.split('\n') {
		let line = line.strip_suffix('\r').unwrap_or(line);
		let Some(rest) = line.strip_prefix("##") else { continue };
		let rest = rest.trim_start_matches(ws);
		let Some(colon) = rest.find(':') else { continue };
		let key = rest[..colon].trim_end_matches(ws);
		if key.is_empty() {
			continue;
		}
		let value = rest[colon + 1..].trim_matches(ws);
		out.entry(key.to_string()).or_insert_with(|| value.to_string());
	}
	out
}

fn stored_value(meta: &FxHashMap<String, String>, key: &str) -> Result<Option<String>, String> {
	let Some(value) = meta.get(key) else { return Ok(None) };
	if !value.starts_with('~') {
		return Ok(Some(value.clone()));
	}
	let inner = value.strip_prefix('~').and_then(|v| v.strip_suffix('~')).filter(|n| !n.is_empty() && n.bytes().all(|b| b.is_ascii_digit()));
	let Some(n) = inner else { return Ok(Some(value.clone())) };
	let n: usize = n.parse().map_err(|_| "QuestieDB: bad part count")?;
	let mut out = String::new();
	for i in 1..=n {
		let part = meta.get(&format!("{key}-{i}")).ok_or_else(|| format!("QuestieDB: metadata key {key} declares {n} parts but part {i} is missing"))?;
		out.push_str(part);
	}
	Ok(Some(out))
}

fn cbor_of(b64: &str) -> Result<V, String> {
	decode_cbor(&base64(b64))
}

pub struct Field {
	pub index: usize,
	pub name: String,
	pub kind: Option<String>,
	pub structure: Option<String>,
	pub constant: V,
}

pub struct Schema {
	pub prefix: String,
	pub fields: Vec<Field>,
}

fn load_metas(dir: &Path) -> Result<Vec<Schema>, String> {
	let files: Vec<PathBuf> = ENTITIES.iter().map(|(_, f)| dir.join("src").join("meta").join(f)).collect();
	for f in &files {
		if !f.exists() {
			return Err(format!("QuestieDB: missing src/meta/{}", f.file_name().unwrap().to_string_lossy()));
		}
	}
	let list: Vec<String> = files.iter().map(|f| format!("{:?}", f.to_string_lossy())).collect();
	let expr = format!("local out = {{}}\nfor i, p in ipairs({{ {} }}) do\n  local ok, m = __polestar_loaddata(p)\n  if not ok then error(m, 0) end\n  out[i] = m\nend\nreturn out", list.join(", "));
	let raw = lua_to_value(&[], "", &expr)?;
	let mut out = Vec::new();
	for (i, (entity, file)) in ENTITIES.iter().enumerate() {
		let m = lua_get_i(&raw, (i + 1) as i64);
		if lua_get(&m, "entity").as_str() != Some(entity) {
			return Err(format!("QuestieDB: {file} does not describe {entity}"));
		}
		let n = lua_get(&m, "fieldCount").num();
		let field = |name: &str, fi: usize| lua_get_i(&lua_get(&m, name), fi as i64);
		let mut fields = Vec::new();
		for fi in 1..=(if n.is_finite() { n as usize } else { 0 }) {
			let s = |v: V| v.as_str().map(str::to_string);
			fields.push(Field {
				index: fi,
				name: field("names", fi).to_js_string(),
				kind: s(field("types", fi)),
				structure: s(field("structures", fi)).filter(|x| !x.is_empty()),
				constant: field("constantValues", fi),
			});
		}
		out.push(Schema { prefix: format!("X-{}", lua_get(&m, "metaPrefix").to_js_string()), fields });
	}
	Ok(out)
}

fn field_default(f: &Field) -> V {
	if !f.constant.is_undef() {
		return f.constant.clone();
	}
	if f.kind.as_deref() == Some("number") {
		return V::Num(0.0);
	}
	if matches!(f.structure.as_deref(), Some("questgivers" | "objectives")) {
		return V::arr();
	}
	V::Undef
}

pub type Entities = IndexMap<i64, Obj>;

fn read_entities(meta: &FxHashMap<String, String>, schema: &Schema) -> Result<Entities, String> {
	let encoded = stored_value(meta, &format!("{}IDS", schema.prefix))?.ok_or_else(|| format!("QuestieDB: missing metadata key {}IDS", schema.prefix))?;
	let bytes = base64(&encoded);
	let mut z = flate2::read::ZlibDecoder::new(&bytes[..]);
	let mut buf = Vec::new();
	z.read_to_end(&mut buf).map_err(|e| format!("QuestieDB: IDS: {e}"))?;
	let ids = lua_list(&decode_cbor(&buf)?);
	let mut out = IndexMap::new();
	for idv in ids {
		let id = idv.num();
		let ids_ = num_str(id);
		let row = match stored_value(meta, &format!("{}{ids_}-S", schema.prefix))? {
			None => V::obj(),
			Some(s) => cbor_of(&s)?,
		};
		let p = lua_get(&row, "p").num();
		let p = if p.is_nan() || p == 0.0 { 0.0 } else { p };
		let rec = Obj::new();
		rec.set("id", id);
		for f in &schema.fields {
			let mut v = V::Undef;
			if f.constant.is_undef() {
				if f.kind.as_deref() == Some("table") {
					if (p / 2f64.powi(f.index as i32 - 1)).floor() % 2.0 == 1.0 {
						if let Some(t) = stored_value(meta, &format!("{}{ids_}-{}", schema.prefix, f.index))? {
							v = cbor_of(&t)?;
						}
					}
				} else {
					v = lua_get_i(&row, f.index as i64);
				}
			}
			rec.set(&f.name, if v.is_undef() { field_default(f) } else { v });
		}
		out.insert(id as i64, rec);
	}
	Ok(out)
}

// ---------------------------------------------------------------- support data

const SUPPORT_FILES: [&str; 7] = [
	"support/Forever/QuestXP/xpDB-classic.lua",
	"support/Forever/DropTables/classicItemDrops.lua",
	"support/Forever/DropTables/itemDropCorrections.lua",
	"support/Forever/FactionTemplates/factionTemplateClassic.lua",
	"support/Forever/Zones/areaIdToUiMapId.lua",
	"support/Forever/Zones/uiMapIdToAreaId.lua",
	"support/Forever/Zones/subZoneToParentZone.lua",
];
const ERA_TO_FOREVER: &str = "src/support/eraToForever.lua";

const SUPPORT_PRELUDE: &str = r#"
__modules = {}
local function __module(name)
  local m = __modules[name]
  if not m then m = { private = {} } __modules[name] = m end
  return m
end
QuestieLoader = {
  ImportModule = function(_, name) return __module(name) end,
  CreateModule = function(_, name) return __module(name) end,
}
-- QuestieDB's own field name
__module("DropDB").correctionKeys = { [("WOW" .. "HEAD")] = -1, PSERVER = -2 }
"#;
const SUPPORT_EXPR: &str = r#"
local function decode(s)
  if type(s) ~= "string" then return s end
  local f = assert(loadstring(s))
  setfenv(f, {})
  return f()
end
local function list(t)
  local out = {}
  if type(t) ~= "table" then return out end
  local keys = {}
  for k in pairs(t) do if type(k) == "number" then keys[#keys + 1] = k end end
  table.sort(keys)
  for i, k in ipairs(keys) do out[i] = { k, t[k] } end
  return out
end
local function nested(t)
  local out = list(t)
  for _, p in ipairs(out) do p[2] = list(p[2]) end
  return out
end
local m = __modules
local zone = (m.ZoneDB or {}).private or {}
local drops = m.QuestieClassicItemDrops or {}
local corr = m.QuestieItemDropCorrections or {}
return {
  xp = list((m.QuestXP or {}).db),
  -- QuestieDB's own field name
  web = nested(decode(drops[("wow" .. "head") .. "Data"])),
  pserver = nested(decode(drops.cmangosData)),
  corrections = nested(corr.Era),
  factionTemplates = list((m.QuestieDB or {}).factionTemplate),
  areaToUiMap = list(decode(zone.areaIdToUiMapId)),
  areaToUiMapOverride = list(decode(zone.areaIdToUiMapIdOverride)),
  uiMapToArea = list(decode(zone.uiMapIdToAreaId)),
  uiMapToAreaOverride = list(decode(zone.uiMapIdToAreaIdOverride)),
  subZones = list(decode(zone.subZoneToParentZone)),
  subZonesOverride = list(decode(zone.subZoneToParentZoneOverride)),
}"#;

/// `new Map(list.map(([k, v]) => [Number(k), value(v)]))`.
fn pairs_map<T>(list: &V, value: impl Fn(&V) -> T) -> IndexMap<i64, T> {
	let mut m = IndexMap::new();
	for p in list.items() {
		m.insert(p.at(0).num() as i64, value(&p.at(1)));
	}
	m
}

fn merged(base: &V, over: &V) -> IndexMap<i64, f64> {
	let mut m = pairs_map(base, V::num);
	for (k, v) in pairs_map(over, V::num) {
		m.insert(k, v);
	}
	m
}

pub type Rates = IndexMap<i64, IndexMap<i64, f64>>;

pub struct Drops {
	pub web: Rates,
	pub pserver: Rates,
	pub corrections: Rates,
}

pub struct EraToForever {
	pub ui_map_to_area: IndexMap<i64, i64>,
}

pub struct Info {
	pub title: Option<String>,
	pub version: Option<String>,
	pub author: Option<String>,
	pub build_commit: Option<String>,
	pub build_time: Option<String>,
}

pub struct Questie {
	pub dir: PathBuf,
	pub info: Info,
	pub flavor: Option<String>,
	pub contract: Option<String>,
	pub questie: Option<Info>,
	pub quests: Entities,
	pub npcs: Entities,
	pub objects: Entities,
	pub items: Entities,
	/// quest -> (level, xp)
	pub xp: IndexMap<i64, (Option<f64>, Option<f64>)>,
	pub drops: Drops,
	pub faction_templates: IndexMap<i64, f64>,
	pub area_to_ui_map: IndexMap<i64, f64>,
	pub ui_map_to_area: IndexMap<i64, f64>,
	pub era_to_forever: EraToForever,
	pub objective_first: FxHashMap<&'static str, FxHashSet<i64>>,
}

fn read_era_to_forever(file: &Path) -> EraToForever {
	let mut ui = IndexMap::new();
	let Ok(text) = std::fs::read_to_string(file) else { return EraToForever { ui_map_to_area: ui } };
	let head = "local uiMapToArea = {";
	if let Some(at) = text.find(head) {
		let body = &text[at + head.len()..];
		let body = &body[..body.find("\n}").unwrap_or(0)];
		let re = regex::Regex::new(r"\[([0-9]+)\][\s]*=[\s]*([0-9]+)").unwrap();
		for c in re.captures_iter(body) {
			ui.insert(c[1].parse().unwrap(), c[2].parse().unwrap());
		}
	}
	EraToForever { ui_map_to_area: ui }
}

fn load_support(dir: &Path) -> Result<(IndexMap<i64, (Option<f64>, Option<f64>)>, Drops, IndexMap<i64, f64>, IndexMap<i64, f64>, IndexMap<i64, f64>), String> {
	let files: Vec<PathBuf> = SUPPORT_FILES.iter().map(|f| dir.join(f)).filter(|f| f.exists()).collect();
	let refs: Vec<&Path> = files.iter().map(PathBuf::as_path).collect();
	let raw = lua_to_value(&refs, SUPPORT_PRELUDE, SUPPORT_EXPR)?;
	let or_null = |x: f64| (x != 0.0 && !x.is_nan()).then_some(x);
	let xp = pairs_map(&raw.get("xp"), |v| (or_null(lua_get_i(v, 1).num()), or_null(lua_get_i(v, 2).num())));
	let rates = |t: &V| pairs_map(t, |inner| pairs_map(inner, V::num));
	let drops = Drops { web: rates(&raw.get("web")), pserver: rates(&raw.get("pserver")), corrections: rates(&raw.get("corrections")) };
	Ok((xp, drops, pairs_map(&raw.get("factionTemplates"), V::num), merged(&raw.get("areaToUiMap"), &raw.get("areaToUiMapOverride")), merged(&raw.get("uiMapToArea"), &raw.get("uiMapToAreaOverride"))))
}

pub struct Rate {
	pub chance: f64,
	pub source: &'static str,
}

/// DropDB.GetItemDroprate: manual correction (or the source it names), then the private-server
/// table, then the web-sourced one.
pub fn drop_rate(d: &Drops, item: i64, npc: i64) -> Option<Rate> {
	let from = |t: &Rates| t.get(&item).and_then(|r| r.get(&npc)).copied();
	if let Some(v) = d.corrections.get(&item).and_then(|c| c.get(&npc)).copied() {
		if v >= 0.0 {
			return Some(Rate { chance: v, source: "questie" });
		}
		if v == -1.0 {
			if let Some(c) = from(&d.web) {
				return Some(Rate { chance: c, source: "web" });
			}
		}
		if v == -2.0 {
			if let Some(c) = from(&d.pserver) {
				return Some(Rate { chance: c, source: "cmangos" });
			}
		}
	}
	if let Some(c) = from(&d.pserver) {
		return Some(Rate { chance: c, source: "cmangos" });
	}
	from(&d.web).map(|c| Rate { chance: c, source: "web" })
}

/// m2a's tableRates: (corrected, server, observed) for one item and npc: a manual chance (no
/// table), else the server and observed tables' chances, less the one a correction rules out.
pub fn table_rates(d: &Drops, item: i64, npc: i64) -> (Option<f64>, Option<f64>, Option<f64>) {
	let from = |t: &Rates| t.get(&item).and_then(|r| r.get(&npc)).copied();
	let v = d.corrections.get(&item).and_then(|c| c.get(&npc)).copied();
	if let Some(v) = v.filter(|v| *v >= 0.0) {
		return (Some(v), None, None);
	}
	let server = from(&d.pserver);
	let observed = from(&d.web);
	(None, if v == Some(-1.0) && observed.is_some() { None } else { server }, if v == Some(-2.0) && server.is_some() { None } else { observed })
}

fn toc_info(file: &Path) -> Option<Info> {
	let text = std::fs::read_to_string(file).ok()?;
	let m = parse_toc(&text);
	let g = |k: &str| m.get(k).filter(|s| !s.is_empty()).cloned();
	Some(Info { title: g("Title"), version: g("Version"), author: g("Author"), build_commit: g("X-BUILD-COMMIT"), build_time: g("X-BUILD-TIME") })
}

/// The `*ObjectiveFirst[<quest>] = true` hints of the Forever correction scope.
fn read_objective_first(qdir: &Path) -> FxHashMap<&'static str, FxHashSet<i64>> {
	let mut out: FxHashMap<&'static str, FxHashSet<i64>> = ["killCredit", "object", "item", "event"].iter().map(|k| (*k, FxHashSet::default())).collect();
	let re = regex::Regex::new(r"(?-u:\b)(killCredit|object|item|event)ObjectiveFirst\[([0-9]+)\][\t\n\x0B\x0C\r \x{a0}\x{feff}]*=[\t\n\x0B\x0C\r \x{a0}\x{feff}]*true(?-u:\b)").unwrap();
	let root = qdir.join("src").join("corrections").join("Forever");
	let mut files = Vec::new();
	fn walk(dir: &Path, rel: &str, out: &mut Vec<(String, PathBuf)>) {
		let Ok(rd) = std::fs::read_dir(dir) else { return };
		for e in rd.flatten() {
			let name = e.file_name().to_string_lossy().to_string();
			let r = if rel.is_empty() { name.clone() } else { format!("{rel}/{name}") };
			let p = e.path();
			if p.is_dir() {
				walk(&p, &r, out);
			}
			out.push((r, p));
		}
	}
	walk(&root, "", &mut files);
	let mut lua: Vec<(String, PathBuf)> = files.into_iter().filter(|(r, p)| r.ends_with(".lua") && p.is_file()).collect();
	lua.sort_by(|a, b| cmp_utf16(&a.0, &b.0));
	for (_, p) in lua {
		let Ok(bytes) = std::fs::read(&p) else { continue };
		let text = String::from_utf8_lossy(&bytes);
		for line in text.split('\n') {
			// line.replace(/--.*$/, ''): the first `--` whose rest holds no line terminator.
			let mut cut = line.len();
			for (i, _) in line.match_indices("--") {
				if !line[i..].contains(['\n', '\r', '\u{2028}', '\u{2029}']) {
					cut = i;
					break;
				}
			}
			for c in re.captures_iter(&line[..cut]) {
				let kind = match &c[1] {
					"killCredit" => "killCredit",
					"object" => "object",
					"item" => "item",
					_ => "event",
				};
				if let Ok(n) = c[2].parse() {
					out.get_mut(kind).unwrap().insert(n);
				}
			}
		}
	}
	out
}

/// The QuestieDB folder for `dir`: itself or `<dir>/QuestieDB`.
pub fn questie_db_dir(dir: &Path) -> Option<PathBuf> {
	[dir.to_path_buf(), dir.join("QuestieDB")].into_iter().find(|d| d.join(TOC).exists())
}

pub fn read_questie(dir: &Path, log: &dyn Fn(&str)) -> Result<Questie, String> {
	let qdir = questie_db_dir(dir).ok_or_else(|| format!("QuestieDB: no {TOC} under {}", dir.display()))?;
	let toc = qdir.join(TOC);
	log(&format!("reading QuestieDB store {}", toc.display()));
	let meta = parse_toc(&std::fs::read_to_string(&toc).map_err(|e| format!("{}: {e}", toc.display()))?);
	let mode = meta.get("X-Mode").cloned().unwrap_or_else(|| "undefined".into());
	if mode != "baked" {
		return Err(format!("QuestieDB: {TOC} is not a baked store (X-Mode {mode})"));
	}
	let flavor = meta.get("X-Flavor").cloned();
	if flavor.as_deref() != Some("Forever") {
		return Err(format!("QuestieDB: {TOC} is flavor {}, not Forever", flavor.as_deref().unwrap_or("undefined")));
	}
	let metas = load_metas(&qdir)?;
	let quests = read_entities(&meta, &metas[0])?;
	let npcs = read_entities(&meta, &metas[1])?;
	let objects = read_entities(&meta, &metas[2])?;
	let items = read_entities(&meta, &metas[3])?;
	let parent = qdir.parent().unwrap_or(&qdir);
	let questie = toc_info(&parent.join("Questie").join("Questie_Camelot.toc")).or_else(|| toc_info(&parent.join("Questie").join("Questie.toc")));
	let info = toc_info(&toc).unwrap_or(Info { title: None, version: None, author: None, build_commit: None, build_time: None });
	let (xp, drops, faction_templates, area_to_ui_map, ui_map_to_area) = load_support(&qdir)?;
	Ok(Questie {
		era_to_forever: read_era_to_forever(&qdir.join(ERA_TO_FOREVER)),
		objective_first: read_objective_first(&qdir),
		dir: qdir,
		info,
		flavor,
		contract: meta.get("X-Contract-Version").filter(|s| !s.is_empty()).cloned(),
		questie,
		quests,
		npcs,
		objects,
		items,
		xp,
		drops,
		faction_templates,
		area_to_ui_map,
		ui_map_to_area,
	})
}

// ---------------------------------------------------------------- locating an install

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

fn wow_dirs(home: &Path) -> Vec<PathBuf> {
	let mut prefixes = Vec::new();
	let consider = |p: PathBuf, out: &mut Vec<PathBuf>| {
		if p.join("drive_c").is_dir() {
			out.push(p);
		}
	};
	for r in PREFIX_ROOTS {
		let root = home.join(r);
		if !root.is_dir() {
			continue;
		}
		consider(root.clone(), &mut prefixes);
		consider(root.join("pfx"), &mut prefixes);
		let mut kids: Vec<(String, PathBuf)> =
			std::fs::read_dir(&root).map(|rd| rd.flatten().filter(|e| e.path().is_dir()).map(|e| (e.file_name().to_string_lossy().to_string(), e.path())).collect()).unwrap_or_default();
		kids.sort_by(|a, b| a.0.cmp(&b.0));
		for (_, p) in kids {
			consider(p.clone(), &mut prefixes);
			consider(p.join("pfx"), &mut prefixes);
		}
	}
	let mut out: Vec<PathBuf> = prefixes.iter().flat_map(|p| WOW_DIRS.iter().map(move |w| p.join("drive_c").join(w))).collect();
	for n in ["C:\\Program Files (x86)\\World of Warcraft", "/Applications/World of Warcraft"] {
		out.push(PathBuf::from(n));
	}
	out.into_iter().filter(|p| p.is_dir()).collect()
}

fn read_flavor(dir: &Path) -> Option<String> {
	let t = std::fs::read_to_string(dir.join(".flavor.info")).ok()?;
	t.lines().map(str::trim).rfind(|l| !l.is_empty()).map(str::to_string)
}

/// QuestieDB's Forever store (a baked `QuestieDB_Forever.toc` of flavor Forever) in the first of
/// [`questie_search_dirs`] holding one.
pub fn detect_questie() -> Option<PathBuf> {
	questie_search_dirs().iter().find_map(|d| forever_store(d))
}

/// `dir` or `<dir>/QuestieDB` when it holds a baked Forever store.
fn forever_store(dir: &Path) -> Option<PathBuf> {
	let q = questie_db_dir(dir)?;
	let meta = parse_toc(&std::fs::read_to_string(q.join(TOC)).ok()?);
	(meta.get("X-Flavor").map(String::as_str) == Some("Forever") && meta.get("X-Mode").map(String::as_str) == Some("baked")).then_some(q)
}

/// Where QuestieDB is looked for: `$WOW_FOREVER_ADDONS`, then every client's AddOns folder, a live
/// Forever client's first (flavor wowf, or `_forever_`), then a `_classic_beta_` one (a leftover
/// beta has no .flavor.info), then the clients of a test server install (`~/Games/*/World of
/// Warcraft`, Fitz's forever-test), then any other client's.
pub fn questie_search_dirs() -> Vec<PathBuf> {
	let env = std::env::var_os("WOW_FOREVER_ADDONS").map(PathBuf::from);
	questie_search_dirs_in(std::env::var_os("HOME").map(PathBuf::from).as_deref(), env)
}

fn questie_search_dirs_in(home: Option<&Path>, env: Option<PathBuf>) -> Vec<PathBuf> {
	let mut dirs: Vec<PathBuf> = env.into_iter().filter(|p| p.is_dir()).collect();
	let Some(home) = home else { return dirs };
	let installs = std::fs::read_dir(home.join("Games")).map(|rd| rd.flatten().map(|e| e.path().join("World of Warcraft")).filter(|p| p.is_dir()).collect::<Vec<_>>()).unwrap_or_default();
	let mut installs: Vec<(bool, PathBuf)> = installs.into_iter().map(|p| (true, p)).collect();
	installs.sort();
	let mut found: Vec<(u8, PathBuf)> = Vec::new();
	let mut seen = FxHashSet::default();
	for (test, wow) in wow_dirs(home).into_iter().map(|w| (false, w)).chain(installs) {
		let mut names: Vec<String> = std::fs::read_dir(&wow).map(|rd| rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).collect()).unwrap_or_default();
		names.sort();
		for name in names {
			if !(name.len() > 2 && name.starts_with('_') && name.ends_with('_')) {
				continue;
			}
			let client = wow.join(&name);
			let addons = client.join("Interface").join("AddOns");
			let Ok(real) = std::fs::canonicalize(&client) else { continue };
			if !addons.is_dir() || !seen.insert(real) {
				continue;
			}
			let flavor = read_flavor(&client).unwrap_or_default();
			let rank = if test {
				2
			} else if flavor == "wowf" || flavor.to_lowercase().contains("forever") || name == "_forever_" {
				0
			} else if name == "_classic_beta_" {
				1
			} else {
				3
			};
			found.push((rank, addons));
		}
	}
	found.sort_by_key(|f| f.0);
	for (_, a) in found {
		if !dirs.contains(&a) {
			dirs.push(a);
		}
	}
	dirs
}

/// <AddOns>/<folder> in the first of `search_addons_dirs` holding it (tools/lib/addons.js findInstalledAddon).
pub fn find_installed_addon(folder: &str) -> Option<PathBuf> {
	search_addons_dirs().into_iter().map(|d| d.join(folder)).find(|p| p.is_dir())
}

/// tools/lib/addons.js searchAddonsDirs: $WOW_FOREVER_ADDONS, then the Forever clients' AddOns
/// folders (live before beta).
pub fn search_addons_dirs() -> Vec<PathBuf> {
	let mut dirs: Vec<PathBuf> = Vec::new();
	if let Some(e) = std::env::var_os("WOW_FOREVER_ADDONS") {
		let p = PathBuf::from(e);
		if p.is_dir() {
			dirs.push(p);
		}
	}
	let Some(home) = std::env::var_os("HOME").map(PathBuf::from) else { return dirs };
	let mut found: Vec<(bool, PathBuf)> = Vec::new();
	let mut seen = FxHashSet::default();
	for wow in wow_dirs(&home) {
		let mut names: Vec<String> = std::fs::read_dir(&wow).map(|rd| rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).collect()).unwrap_or_default();
		names.sort();
		for name in names {
			if !(name.len() > 2 && name.starts_with('_') && name.ends_with('_')) {
				continue;
			}
			let client = wow.join(&name);
			let Some(flavor) = read_flavor(&client) else { continue };
			let live = flavor == "wowf" || flavor.to_lowercase().contains("forever");
			let beta = name == "_classic_beta_" && flavor == "wow_classic_beta";
			if !live && !beta {
				continue;
			}
			let Ok(real) = std::fs::canonicalize(&client) else { continue };
			if seen.insert(real) {
				found.push((live, client.join("Interface").join("AddOns")));
			}
		}
	}
	for (_, a) in found.iter().filter(|f| f.0).chain(found.iter().filter(|f| !f.0)) {
		if a.is_dir() && !dirs.contains(a) {
			dirs.push(a.clone());
		}
	}
	dirs
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn cbor_maps_and_arrays() {
		// {1: "a", 2: "b"} -> array; {"p": 3, 2: 1} -> object with "2" first
		assert_eq!(forge_guide::js::stringify(&decode_cbor(&[0xa2, 0x01, 0x61, b'a', 0x02, 0x61, b'b']).unwrap(), None), "[\"a\",\"b\"]");
		assert_eq!(forge_guide::js::stringify(&decode_cbor(&[0xa2, 0x61, b'p', 0x03, 0x02, 0x01]).unwrap(), None), "{\"2\":1,\"p\":3}");
		assert_eq!(base64("aGk="), b"hi");
		let t = parse_toc("## X-Flavor: Forever\n## Title :  A b  \r\n");
		assert_eq!(t["X-Flavor"], "Forever");
		assert_eq!(t["Title"], "A b");
	}

	/// A fake home: a wine prefix with the clients `(name, flavor, store)` (flavor None: no
	/// .flavor.info; store: a baked Forever QuestieDB in its AddOns), and a test install under Games.
	fn home(tag: &str, clients: &[(&str, Option<&str>, bool)], test_install: bool) -> PathBuf {
		let h = std::env::temp_dir().join(format!("forge-questie-home-{tag}-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&h);
		let store = |addons: &Path| {
			let q = addons.join("QuestieDB");
			std::fs::create_dir_all(&q).unwrap();
			std::fs::write(q.join(TOC), "## X-Flavor: Forever\n## X-Mode: baked\n").unwrap();
		};
		let wow = h.join("Games/drive_c/Program Files (x86)/World of Warcraft");
		for (name, flavor, has) in clients {
			let c = wow.join(name);
			let addons = c.join("Interface/AddOns");
			std::fs::create_dir_all(&addons).unwrap();
			if let Some(f) = flavor {
				std::fs::write(c.join(".flavor.info"), format!("{f}\n")).unwrap();
			}
			if *has {
				store(&addons);
			}
		}
		if test_install {
			let addons = h.join("Games/forever-test/World of Warcraft/_classic_beta_/Interface/AddOns");
			std::fs::create_dir_all(&addons).unwrap();
			store(&addons);
		}
		h
	}

	fn detect_in(h: &Path) -> Option<PathBuf> {
		questie_search_dirs_in(Some(h), None).iter().find_map(|d| forever_store(d))
	}

	#[test]
	fn questie_found_in_a_leftover_beta_without_flavor_info() {
		// October 2026: the beta client was uninstalled; its folder kept QuestieDB but lost .flavor.info,
		// and the live client has no QuestieDB. The old search found nothing and the data was built
		// without it (975 quests fewer).
		let h = home("leftover", &[("_classic_beta_", None, true), ("_forever_", Some("wowf"), false), ("_retail_", Some("wow"), false)], false);
		assert!(detect_in(&h).is_some_and(|q| q.to_string_lossy().contains("_classic_beta_")), "{:?}", questie_search_dirs_in(Some(&h), None));
		let _ = std::fs::remove_dir_all(&h);
	}

	#[test]
	fn questie_in_the_live_client_first_then_beta_then_a_test_install() {
		let h = home("order", &[("_classic_beta_", Some("wow_classic_beta"), true), ("_forever_", Some("wowf"), true)], true);
		assert!(detect_in(&h).is_some_and(|q| q.to_string_lossy().contains("_forever_")));
		let h2 = home("test", &[("_forever_", Some("wowf"), false), ("_classic_era_", Some("wow_classic_era"), false)], true);
		assert!(detect_in(&h2).is_some_and(|q| q.to_string_lossy().contains("forever-test")));
		let h3 = home("none", &[("_forever_", Some("wowf"), false)], false);
		assert_eq!(detect_in(&h3), None);
		for d in [h, h2, h3] {
			let _ = std::fs::remove_dir_all(d);
		}
	}

	#[test]
	fn quest_drop_names_whats_missing() {
		let q = |n: usize, extra: &str| -> String {
			let mut v: Vec<String> = (1..=n).map(|i| format!("\"{i}\": {{\"title\": \"Q{i}\", \"source\": [\"pfquest\"]}}")).collect();
			if !extra.is_empty() {
				v.push(extra.into());
			}
			format!("{{{}}}", v.join(","))
		};
		let old = q(100, "\"9001\": {\"title\": \"Sticks and Bones\", \"source\": [\"questie-forever\"]}");
		assert!(crate::build::quest_drop(&old, &q(100, ""), crate::build::MAX_QUEST_DROP).is_ok(), "1 of 101 gone is within 5%");
		let e = crate::build::quest_drop(&old, &q(80, ""), crate::build::MAX_QUEST_DROP).unwrap_err();
		assert!(e.contains("from 101 to 80") && e.contains("21 quests are missing") && e.contains("pfquest 20 (81 Q81, 82 Q82, 83 Q83); questie-forever 1 (9001 Sticks and Bones)"), "{e}");
	}
}
