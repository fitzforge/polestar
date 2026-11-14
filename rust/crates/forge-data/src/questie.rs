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

/// Loaded in this order into one state: QuestieDB 1.0.13's player-trace XP rows
/// (`xpDB-traces.lua`, `QuestXP.db[id] = {level, xp}`) come after the classic table and win.
const SUPPORT_FILES: [&str; 8] = [
	"support/Forever/QuestXP/xpDB-classic.lua",
	"support/Forever/QuestXP/xpDB-traces.lua",
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
	/// What the faction/class Dynamic Corrections changed in the entities above.
	pub dynamic: Dynamic,
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

// ---------------------------------------------------------------- Dynamic Corrections

/// QuestieDB applies its Dynamic Corrections at query time, per character (faction, class): the
/// baked store doesn't hold them. The stand-ins the providers call; the driver sets the globals.
const DYNAMIC_PRELUDE: &str = r#"
__faction, __class = "Horde", "WARRIOR"
function UnitFactionGroup() return __faction, __faction end
function UnitClassBase() return __class end
function UnitClass() return __class, __class end
"#;

/// Loads config, enums and metas the way src/corrections/compat.lua builds its module stand-ins,
/// then every Dynamic provider the config declares for the Forever flavor (in config order: a
/// later provider overrides an earlier one per field, as at query time), and calls each once per
/// faction and playable class. Rows come back as lists, so ids and field indices stay numbers.
const DYNAMIC_EXPR: &str = r#"
local root = %ROOT%
local ns = {}
local function run(rel)
  local ok, res = __polestar_loaddata(root .. "/" .. rel, "QuestieDB", ns)
  if not ok then error("QuestieDB " .. rel .. ": " .. tostring(res), 0) end
  return res
end
run("src/config.lua")
local config = ns.config
local flavor = config.flavorByName.Forever
local specs = {}
for _, spec in ipairs(config.ownedCorrections or {}) do
  if spec.dynamic and config.correctionApplies(spec, flavor) then specs[#specs + 1] = spec end
end
if #specs == 0 then return { runs = {} } end
for _, f in ipairs(config.enumFiles) do run(f) end
local C = ns.Enum
local active = { classKeys = true, npcFlags = true }
local function pick(name)
  local shared = (not active[name]) and C[name] or nil
  if shared ~= nil then return shared end
  local by = C.byExpansion
  local v = by[flavor.expansion] and by[flavor.expansion][name]
  if v == nil and flavor.rules then v = by[flavor.rules][name] end
  if v == nil then error("QuestieDB: unknown constant " .. name, 0) end
  return v
end
local DB = {}
local captured = {}
for _, et in ipairs(config.entityTypes) do
  local m = run("src/meta/" .. et.name:sub(1, 1):lower() .. et.name:sub(2) .. "Meta.lua")
  local k = {}
  for index, name in pairs(m.names) do
    k[name] = index
    k[name .. "_add"] = index + 1000
    k[name .. "_remove"] = index - 1000
  end
  DB[et.keysField] = k
  local r = {}
  for name, index in pairs(k) do r[index] = name end
  DB[et.keysField .. "Reversed"] = r
  local t = {}
  DB[et.dataField] = t
  captured[et.name] = t
end
for _, n in ipairs({ "raceKeys", "classKeys", "sortKeys", "specialFlags", "factionIDs", "questFlags", "npcFlags", "itemClasses", "waypointPresets" }) do
  DB[n] = pick(n)
end
local order = config.expansionOrder
local modules = {
  QuestieDB = DB,
  ZoneDB = { zoneIDs = pick("zoneIDs") },
  QuestieProfessions = { professionKeys = pick("professionKeys"), specializationKeys = pick("specializationKeys"), rankNames = pick("rankNames") },
  QuestieCorrections = { killCreditObjectiveFirst = {}, objectObjectiveFirst = {}, itemObjectiveFirst = {}, eventObjectiveFirst = {}, spellObjectiveFirst = {} },
  Phasing = { phases = pick("phases") },
  l10n = setmetatable({}, { __call = function(_, text) return text end }),
  Expansions = { Era = order.Classic, Classic = order.Classic, Tbc = order.TBC, Wotlk = order.Wotlk, Cata = order.Cata, MoP = order.MoP, Current = order[flavor.rules or flavor.expansion] },
}
local function module(_, name) modules[name] = modules[name] or {} return modules[name] end
QuestieLoader = { ImportModule = module, CreateModule = module }
Questie = {}
for k, v in pairs(C.iconTypes or {}) do Questie[k] = v end
local providers = {}
for _, spec in ipairs(specs) do
  run("src/corrections/" .. spec.file)
  for _, fn in ipairs(spec.dynamic) do providers[#providers + 1] = { spec = spec, fn = fn } end
end
local classKeys = pick("classKeys")
local all = classKeys.ALL_CLASSES
local classes = {}
for name, bit in pairs(classKeys) do
  local b = bit
  while b > 1 and b % 2 == 0 do b = b / 2 end
  if bit > 0 and b == 1 and (all == nil or math.floor(all / bit) % 2 == 1) then classes[#classes + 1] = { name = name, bit = bit } end
end
table.sort(classes, function(a, b) return a.bit < b.bit end)
local function sorted(t)
  local ks, other = {}, 0
  for k in pairs(t) do if type(k) == "number" then ks[#ks + 1] = k else other = other + 1 end end
  table.sort(ks)
  return ks, other
end
local runs = {}
for _, faction in ipairs({ "Horde", "Alliance" }) do
  for _, c in ipairs(classes) do
    __faction, __class = faction, c.name
    local layers = {}
    for _, p in ipairs(providers) do
      for _, t in pairs(captured) do for id in pairs(t) do t[id] = nil end end
      local m = modules[p.spec.module]
      local f = m and m[p.fn]
      if type(f) ~= "function" then error("QuestieDB " .. p.spec.file .. ": no " .. p.spec.module .. ":" .. p.fn, 0) end
      local result = f(m) or {}
      local ids, skipped = sorted(result)
      local rows = {}
      for _, id in ipairs(ids) do
        local fields = result[id]
        local list = {}
        if type(fields) == "table" then
          local idx, other = sorted(fields)
          skipped = skipped + other
          for _, i in ipairs(idx) do list[#list + 1] = { i, fields[i] } end
        else
          skipped = skipped + 1
        end
        rows[#rows + 1] = { id, list }
      end
      for _, t in pairs(captured) do for _ in pairs(t) do skipped = skipped + 1 end end
      layers[#layers + 1] = { provider = p.spec.file .. ":" .. p.fn, datatype = p.spec.datatype, rows = rows, skipped = skipped }
    end
    runs[#runs + 1] = { faction = faction, class = c.name, layers = layers }
  end
end
return { runs = runs }
"#;

/// What the Dynamic Corrections changed in the store (logged, and listed in meta.json).
#[derive(Default)]
pub struct Dynamic {
	/// `<file>:<function>` of each provider, in apply order.
	pub providers: Vec<String>,
	/// The class tokens evaluated, once per faction.
	pub classes: Vec<String>,
	/// Giver/ender lists widened to the union of every character's list: (entity, id, field).
	pub unioned: Vec<(&'static str, i64, String)>,
	/// Fields every character reads alike, differently from the store: taken.
	pub agreed: Vec<(&'static str, i64, String)>,
	/// Fields characters read differently: kept as the store has them (last: only classes differ
	/// within a faction).
	pub kept: Vec<(&'static str, i64, String, bool)>,
	/// Writes not applied: operation keys (`<field>_add`/`_remove`), unknown or constant fields,
	/// tables in scalar fields, non-numeric ids, direct `QuestieDB.<x>Data` writes.
	pub skipped: usize,
}

/// A Lua string literal for `s` (every byte outside printable ASCII escaped).
fn lua_str(s: &str) -> String {
	let mut out = String::from("\"");
	for b in s.bytes() {
		match b {
			b'"' | b'\\' => {
				out.push('\\');
				out.push(b as char);
			}
			0x20..=0x7e => out.push(b as char),
			_ => out.push_str(&format!("\\{b}")),
		}
	}
	out.push('"');
	out
}

/// A value's identity for comparing characters' reads: object keys sorted, empty tables alike.
fn canon(v: &V) -> String {
	match v {
		V::Undef | V::Null => "null".into(),
		V::Bool(b) => b.to_string(),
		V::Num(n) => num_str(*n),
		V::Str(s) => forge_guide::js::stringify(&V::Str(s.clone()), None),
		V::Arr(a) => format!("[{}]", a.to_vec().iter().map(canon).collect::<Vec<_>>().join(",")),
		V::Obj(o) => {
			let mut e: Vec<(String, String)> = o.entries().into_iter().filter(|(_, x)| !x.is_nullish()).map(|(k, x)| (k.to_string(), canon(&x))).collect();
			if e.is_empty() {
				return "[]".into();
			}
			e.sort_by(|a, b| match (a.0.parse::<f64>(), b.0.parse::<f64>()) {
				(Ok(x), Ok(y)) => x.total_cmp(&y),
				_ => a.0.cmp(&b.0),
			});
			format!("{{{}}}", e.into_iter().map(|(k, x)| format!("{k}:{x}")).collect::<Vec<_>>().join(","))
		}
	}
}

fn is_empty_table(v: &V) -> bool {
	matches!(v, V::Arr(a) if a.is_empty()) || matches!(v, V::Obj(o) if o.is_empty())
}

/// `{{npcs}, {objects}, {items}}` slot by slot: the store's ids some character still reads
/// first, then every other id in run order.
fn union_givers(store: &V, reads: &[V]) -> V {
	let ids = |v: &V, slot: i64| -> Vec<f64> { lua_list(&lua_get_i(v, slot)).iter().map(V::num).filter(|n| n.is_finite()).collect() };
	let mut slots: Vec<Vec<f64>> = Vec::new();
	for slot in 1..=3 {
		let read: Vec<Vec<f64>> = reads.iter().map(|r| ids(r, slot)).collect();
		let mut l: Vec<f64> = ids(store, slot).into_iter().filter(|x| read.iter().any(|r| r.contains(x))).collect();
		for x in read.into_iter().flatten() {
			if !l.contains(&x) {
				l.push(x);
			}
		}
		slots.push(l);
	}
	while slots.last().is_some_and(Vec::is_empty) {
		slots.pop();
	}
	V::Arr(Arr::from_vec(slots.into_iter().map(|l| V::Arr(Arr::from_vec(l.into_iter().map(V::Num).collect()))).collect()))
}

/// Runs QuestieDB's Dynamic Corrections for every faction and class and folds them into the
/// store's entities: giver/ender lists become the union of what every character reads (Polestar
/// filters givers by the NPC's faction); any other field changes only when every character reads
/// the same value.
fn apply_dynamic(qdir: &Path, metas: &[Schema], ents: &mut [&mut Entities; 4]) -> Result<Dynamic, String> {
	let expr = DYNAMIC_EXPR.replace("%ROOT%", &lua_str(&qdir.to_string_lossy()));
	let raw = lua_to_value(&[], DYNAMIC_PRELUDE, &expr)?;
	let runs = lua_list(&raw.get("runs"));
	let mut out = Dynamic::default();
	let factions: Vec<String> = runs.iter().map(|r| r.get("faction").to_js_string()).collect();
	if let Some(first) = runs.first() {
		out.providers = lua_list(&first.get("layers")).iter().map(|l| l.get("provider").to_js_string()).collect();
	}
	out.classes = runs.iter().filter(|r| r.get("faction").to_js_string() == factions[0]).map(|r| r.get("class").to_js_string()).collect();
	// per run, per entity type: id -> field index -> what that character reads
	type Reads = FxHashMap<i64, FxHashMap<usize, V>>;
	let mut reads: Vec<[Reads; 4]> = Vec::with_capacity(runs.len());
	for run in &runs {
		let mut r: [Reads; 4] = Default::default();
		for layer in lua_list(&run.get("layers")) {
			let dt = layer.get("datatype").to_js_string();
			let d = ENTITIES.iter().position(|(e, _)| *e == dt).ok_or_else(|| format!("QuestieDB: Dynamic Correction {} for unknown entity {dt}", layer.get("provider").to_js_string()))?;
			out.skipped += layer.get("skipped").num() as usize;
			for row in lua_list(&layer.get("rows")) {
				let id = lua_get_i(&row, 1).num() as i64;
				for pair in lua_list(&lua_get_i(&row, 2)) {
					let idx = lua_get_i(&pair, 1).num();
					let value = lua_get_i(&pair, 2);
					let Some(f) = (idx >= 1.0 && idx.fract() == 0.0).then(|| metas[d].fields.get(idx as usize - 1)).flatten() else {
						out.skipped += 1;
						continue;
					};
					if !f.constant.is_undef() || (f.kind.as_deref() != Some("table") && !is_empty_table(&value) && (value.is_arr() || value.is_obj())) {
						out.skipped += 1;
						continue;
					}
					// `[key] = {}` deletes: the field reads its default
					let value = if is_empty_table(&value) { field_default(f) } else { value };
					r[d].entry(id).or_default().insert(f.index, value);
				}
			}
		}
		reads.push(r);
	}
	for (d, (entity, _)) in ENTITIES.iter().enumerate() {
		let ids: std::collections::BTreeSet<i64> = reads.iter().flat_map(|r| r[d].keys().copied()).collect();
		for id in ids {
			let exists = ents[d].contains_key(&id);
			// an entity only some characters' corrections create exists for those characters only
			let part: Vec<usize> = (0..runs.len()).filter(|&r| exists || reads[r][d].contains_key(&id)).collect();
			let rec = ents[d]
				.entry(id)
				.or_insert_with(|| {
					let o = Obj::new();
					o.set("id", id as f64);
					for f in &metas[d].fields {
						o.set(&f.name, field_default(f));
					}
					o
				})
				.clone();
			let fields: std::collections::BTreeSet<usize> = part.iter().filter_map(|&r| reads[r][d].get(&id)).flat_map(|m| m.keys().copied()).collect();
			for idx in fields {
				let f = &metas[d].fields[idx - 1];
				let store = rec.get(&f.name);
				let finals: Vec<V> = part.iter().map(|&r| reads[r][d].get(&id).and_then(|m| m.get(&idx)).cloned().unwrap_or_else(|| store.clone())).collect();
				let keys: Vec<String> = finals.iter().map(canon).collect();
				if keys.iter().all(|k| *k == keys[0]) {
					if keys[0] != canon(&store) {
						rec.set(&f.name, finals[0].clone());
						out.agreed.push((entity, id, f.name.clone()));
					}
				} else if f.structure.as_deref() == Some("questgivers") {
					let u = union_givers(&store, &finals);
					if canon(&u) != canon(&store) {
						rec.set(&f.name, u);
						out.unioned.push((entity, id, f.name.clone()));
					}
				} else {
					let by_class = factions.iter().all(|fac| {
						let mut k = part.iter().zip(&keys).filter(|(&r, _)| factions[r] == *fac).map(|(_, k)| k);
						let first = k.next();
						k.all(|x| Some(x) == first)
					});
					out.kept.push((entity, id, f.name.clone(), !by_class));
				}
			}
		}
	}
	Ok(out)
}

fn log_dynamic(d: &Dynamic, log: &dyn Fn(&str)) {
	let class_only = d.kept.iter().filter(|k| k.3).count();
	log(&format!(
		"QuestieDB Dynamic Corrections: {} providers run as Horde and Alliance × {} classes; {} giver/ender lists unioned, {} fields every character reads alike taken, {} fields kept from the store ({} differ only by class), {} writes skipped",
		d.providers.len(),
		d.classes.len(),
		d.unioned.len(),
		d.agreed.len(),
		d.kept.len(),
		class_only,
		d.skipped
	));
	let list = |l: &mut dyn Iterator<Item = String>| l.collect::<Vec<_>>().join(" ");
	if !d.unioned.is_empty() {
		log(&format!("  unioned: {}", list(&mut d.unioned.iter().map(|(e, id, f)| format!("{e} {id} {f}")))));
	}
	if !d.agreed.is_empty() {
		log(&format!("  taken: {}", list(&mut d.agreed.iter().map(|(e, id, f)| format!("{e} {id} {f}")))));
	}
}

/// The QuestieDB folder for `dir`: itself or `<dir>/QuestieDB`.
pub fn questie_db_dir(dir: &Path) -> Option<PathBuf> {
	[dir.to_path_buf(), dir.join("QuestieDB")].into_iter().find(|d| d.join(TOC).exists())
}

pub fn read_questie(dir: &Path, log: &dyn Fn(&str)) -> Result<Questie, String> {
	let qdir =
		questie_db_dir(dir).ok_or_else(|| format!("QuestieDB: no {TOC} under {}: use a QuestieDB release (its baked store holds the Static Corrections), not a repository checkout", dir.display()))?;
	let toc = qdir.join(TOC);
	log(&format!("reading QuestieDB store {}", toc.display()));
	let meta = parse_toc(&std::fs::read_to_string(&toc).map_err(|e| format!("{}: {e}", toc.display()))?);
	let mode = meta.get("X-Mode").cloned().unwrap_or_else(|| "undefined".into());
	if mode != "baked" {
		return Err(format!("QuestieDB: {TOC} is not a baked store (X-Mode {mode}): use a QuestieDB release (its baked store holds the Static Corrections), not a repository checkout"));
	}
	let flavor = meta.get("X-Flavor").cloned();
	if flavor.as_deref() != Some("Forever") {
		return Err(format!("QuestieDB: {TOC} is flavor {}, not Forever", flavor.as_deref().unwrap_or("undefined")));
	}
	let metas = load_metas(&qdir)?;
	let mut quests = read_entities(&meta, &metas[0])?;
	let mut npcs = read_entities(&meta, &metas[1])?;
	let mut objects = read_entities(&meta, &metas[2])?;
	let mut items = read_entities(&meta, &metas[3])?;
	let dynamic = apply_dynamic(&qdir, &metas, &mut [&mut quests, &mut npcs, &mut objects, &mut items])?;
	log_dynamic(&dynamic, log);
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
		dynamic,
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

	/// A QuestieDB release's correction surface in miniature: config, one enum file, the four
	/// metas, a legacy faction provider (one class-dependent field) and a Forever one over it.
	fn dynamic_fixture() -> PathBuf {
		let d = std::env::temp_dir().join(format!("forge-questie-dynamic-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&d);
		let w = |rel: &str, text: &str| {
			let p = d.join(rel);
			std::fs::create_dir_all(p.parent().unwrap()).unwrap();
			std::fs::write(p, text).unwrap();
		};
		w(
			"src/config.lua",
			r#"local _, LibQuestieDB = ...
local config = {}
config.expansionOrder = { Classic = 1 }
config.flavorByName = { Forever = { name = "Forever", expansion = "Forever", rules = "Classic" } }
config.entityTypes = {
  { name = "Quest", keysField = "questKeys", dataField = "questData" }, { name = "Npc", keysField = "npcKeys", dataField = "npcData" },
  { name = "Item", keysField = "itemKeys", dataField = "itemData" }, { name = "Object", keysField = "objectKeys", dataField = "objectData" },
}
config.enumFiles = { "src/corrections/enum/constants.lua" }
config.ownedCorrections = {
  { owned = "Forever", file = "Forever/legacy/legacyQuestFixes.lua", module = "LegacyQuestFixes", datatype = "Quest", static = {"Load"}, dynamic = {"LoadFactionFixes"} },
  { owned = "Forever", file = "Forever/foreverQuestFixes.lua", module = "ForeverQuestFixes", datatype = "Quest", static = {"Load"}, dynamic = {"LoadDynamic"} },
  { owned = "Vanilla", file = "Era/notShipped.lua", module = "Other", datatype = "Quest", dynamic = {"LoadFactionFixes"} },
}
function config.correctionApplies(spec, flavor) return spec.owned == flavor.name end
if LibQuestieDB then LibQuestieDB.config = config end
return config
"#,
		);
		w(
			"src/corrections/enum/constants.lua",
			r#"local _, LibQuestieDB = ...
local C = {}
LibQuestieDB.Enum = C
for _, n in ipairs({ "raceKeys", "sortKeys", "specialFlags", "factionIDs", "questFlags", "itemClasses", "waypointPresets", "professionKeys", "specializationKeys", "rankNames", "phases" }) do C[n] = {} end
C.zoneIDs = { UNDERCITY = 1497, STORMWIND_CITY = 1519 }
C.byExpansion = { Classic = { classKeys = { NONE = 0, WARRIOR = 1, PALADIN = 2, DEATH_KNIGHT = 32, DRUID = 1024, ALL_CLASSES = 1027 }, npcFlags = {} }, Forever = {} }
"#,
		);
		let meta = |entity: &str, fields: &[(&str, &str, &str)]| {
			let keys: Vec<String> = fields.iter().enumerate().map(|(i, f)| format!("{} = {}", f.0, i + 1)).collect();
			let names: Vec<String> = fields.iter().map(|f| format!("'{}'", f.0)).collect();
			let types: Vec<String> = fields.iter().map(|f| format!("'{}'", f.1)).collect();
			let structures: Vec<String> = fields.iter().enumerate().filter(|(_, f)| !f.2.is_empty()).map(|(i, f)| format!("[{}] = '{}'", i + 1, f.2)).collect();
			format!(
				"local _, LibQuestieDB = ...\nlocal meta = {{ entity = '{entity}', metaPrefix = '{entity}-', fieldCount = {}, keys = {{ {} }}, names = {{ {} }}, types = {{ {} }}, structures = {{ {} }} }}\nreturn meta\n",
				fields.len(),
				keys.join(", "),
				names.join(", "),
				types.join(", "),
				structures.join(", ")
			)
		};
		let quest = [
			("name", "string", ""),
			("startedBy", "table", "questgivers"),
			("finishedBy", "table", "questgivers"),
			("objectivesText", "table", "stringarray"),
			("zoneOrSort", "number", ""),
			("nextQuestInChain", "number", ""),
			("requiredRaces", "number", ""),
		];
		w("src/meta/questMeta.lua", &meta("Quest", &quest));
		for (file, entity) in [("npcMeta.lua", "Npc"), ("objectMeta.lua", "Object"), ("itemMeta.lua", "Item")] {
			w(&format!("src/meta/{file}"), &meta(entity, &[("name", "string", "")]));
		}
		w(
			"src/corrections/Forever/legacy/legacyQuestFixes.lua",
			r#"local L = QuestieLoader:CreateModule("LegacyQuestFixes")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
QuestieLoader:ImportModule("QuestieCorrections").itemObjectiveFirst[5] = true
function L:LoadFactionFixes()
  local questKeys = QuestieDB.questKeys
  local playerClass = UnitClassBase("player")
  local byClass = ({ WARRIOR = 7, PALADIN = 8, DRUID = 9 })[playerClass]
  local horde = {
    [100] = { [questKeys.startedBy] = {{3045, 6018}} },
    [101] = { [questKeys.nextQuestInChain] = byClass },
    [102] = { [questKeys.zoneOrSort] = 1497 },
    [200] = { [questKeys.finishedBy] = {{999}} },
  }
  local alliance = {
    [100] = { [questKeys.startedBy] = {{918, 4163}} },
    [101] = { [questKeys.nextQuestInChain] = byClass },
    [102] = { [questKeys.zoneOrSort] = 1519 },
    [200] = { [questKeys.finishedBy] = {{999}} },
  }
  if UnitFactionGroup("Player") == "Horde" then return horde else return alliance end
end
"#,
		);
		w(
			"src/corrections/Forever/foreverQuestFixes.lua",
			r#"local F = QuestieLoader:CreateModule("ForeverQuestFixes")
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")
local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
function F:LoadDynamic()
  local questKeys = QuestieDB.questKeys
  local zoneIDs = ZoneDB.zoneIDs
  local horde = {
    [102] = { [questKeys.requiredRaces] = {} },
    [200] = { [questKeys.finishedBy] = {{211022}}, [questKeys.objectivesText] = {"Bring it to Owen."}, [questKeys.zoneOrSort] = zoneIDs.UNDERCITY },
    [300] = { [questKeys.name] = "Horde only", [questKeys.startedBy] = {{5}} },
    [103] = { [questKeys.zoneOrSort] = {1, 2} },
    [104] = { [questKeys.startedBy_add] = {{9}} },
  }
  local alliance = {
    [102] = { [questKeys.requiredRaces] = {} },
    [200] = { [questKeys.finishedBy] = {{211033}}, [questKeys.objectivesText] = {"Bring it to Jennea."}, [questKeys.zoneOrSort] = zoneIDs.STORMWIND_CITY },
  }
  if UnitFactionGroup("Player") == "Horde" then return horde else return alliance end
end
"#,
		);
		d
	}

	#[test]
	fn dynamic_corrections_union_givers_and_keep_what_characters_read_differently() {
		let d = dynamic_fixture();
		let metas = load_metas(&d).unwrap();
		let rec = |id: i64, set: &[(&str, V)]| {
			let o = Obj::new();
			o.set("id", id as f64);
			for f in &metas[0].fields {
				o.set(&f.name, set.iter().find(|s| s.0 == f.name).map(|s| s.1.clone()).unwrap_or_else(|| field_default(f)));
			}
			o
		};
		let j = |s: &str| forge_guide::js::parse_json(s).unwrap();
		let mut quests: Entities = IndexMap::new();
		quests.insert(100, rec(100, &[("startedBy", j("[[3328,4583]]"))]));
		quests.insert(101, rec(101, &[]));
		quests.insert(102, rec(102, &[("zoneOrSort", V::Num(17.0)), ("requiredRaces", V::Num(178.0))]));
		quests.insert(200, rec(200, &[("finishedBy", j("[[211033]]")), ("zoneOrSort", V::Num(1519.0))]));
		let (mut npcs, mut objects, mut items) = (IndexMap::new(), IndexMap::new(), IndexMap::new());
		let dy = apply_dynamic(&d, &metas, &mut [&mut quests, &mut npcs, &mut objects, &mut items]).unwrap();
		let _ = std::fs::remove_dir_all(&d);
		let get = |id: i64, f: &str| forge_guide::js::stringify(&quests[&id].get(f), None);

		assert_eq!(dy.providers, ["Forever/legacy/legacyQuestFixes.lua:LoadFactionFixes", "Forever/foreverQuestFixes.lua:LoadDynamic"]);
		assert_eq!(dy.classes, ["WARRIOR", "PALADIN", "DRUID"], "playable classes only, by class bit");
		// each faction's givers replace the store's; the record holds both factions'
		assert_eq!(get(100, "startedBy"), "[[3045,6018,918,4163]]");
		// Forever's provider overrides the legacy one; the store's ender stays first
		assert_eq!(get(200, "finishedBy"), "[[211033,211022]]");
		// scalars the factions read differently stay as the store has them
		assert_eq!(get(200, "zoneOrSort"), "1519");
		assert!(quests[&200].get("objectivesText").is_undef());
		assert_eq!(get(102, "zoneOrSort"), "17");
		assert_eq!(get(101, "nextQuestInChain"), "0");
		// both factions delete it (`{}`): the default
		assert_eq!(get(102, "requiredRaces"), "0");
		// an entity only Horde characters get, read alike by all of them
		assert_eq!(get(300, "name"), "\"Horde only\"");
		assert_eq!(get(300, "startedBy"), "[[5]]");
		let mut kept: Vec<String> = dy.kept.iter().map(|k| format!("{} {} {}", k.1, k.2, k.3)).collect();
		kept.sort();
		assert_eq!(kept, ["101 nextQuestInChain true", "102 zoneOrSort false", "200 objectivesText false", "200 zoneOrSort false"]);
		assert_eq!(dy.unioned.len(), 2);
		let mut taken: Vec<String> = dy.agreed.iter().map(|k| format!("{} {}", k.1, k.2)).collect();
		taken.sort();
		assert_eq!(taken, ["102 requiredRaces", "300 name", "300 startedBy"]);
		// a table in a number field and an operation key, for each of the three Horde characters
		assert_eq!(dy.skipped, 6);
		assert!(!quests.contains_key(&103) && !quests.contains_key(&104), "skipped writes create nothing");
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
