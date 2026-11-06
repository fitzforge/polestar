//! addon/Polestar_ItemDB/Forever.lua: Forever's item stats over the Era table (gear/forever.rs), and
//! which quests reward which gear, with where those items come from, from the Codex's sources
//! (data/forever/codex). Plus the ItemDB record format (itemdb/stats.js encode/decode).

use std::path::Path;

use forge_guide::js::{num_str, str_to_num, V};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;

use super::forever::Overlay;
use crate::jsv::math_round;

/// itemdb/stats.js STAT_KEYS, in emission order.
pub const STAT_KEYS: [&str; 29] = [
	"str",
	"agi",
	"sta",
	"int",
	"spi",
	"armor",
	"health",
	"mana",
	"ap",
	"rap",
	"sp",
	"spArcane",
	"spFire",
	"spFrost",
	"spHoly",
	"spNature",
	"spShadow",
	"heal",
	"crit",
	"hit",
	"spellCrit",
	"spellHit",
	"mp5",
	"hp5",
	"defense",
	"dodge",
	"parry",
	"block",
	"blockValue",
];

pub const PROFESSIONS: [&str; 13] =
	["Alchemy", "Blacksmithing", "Enchanting", "Engineering", "Leatherworking", "Tailoring", "Jewelcrafting", "Mining", "Herbalism", "Skinning", "Cooking", "First Aid", "Fishing"];

fn token(k: &str) -> &str {
	match k {
		"mp5" => "mpr",
		"hp5" => "hpr",
		_ => k,
	}
}

fn untoken(k: &str) -> &str {
	match k {
		"mpr" => "mp5",
		"hpr" => "hp5",
		_ => k,
	}
}

/// leveling.js `luaStr`.
fn lua_str(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n").replace('\r', ""))
}

/// An ItemDB record; the scalar fields as JS values (`String(x)` prints them).
#[derive(Clone)]
pub struct Rec {
	pub id: f64,
	pub inv: V,
	pub ilvl: V,
	pub req: V,
	pub quality: V,
	pub cls: V,
	pub sub: V,
	pub allow: V,
	pub unique: bool,
	pub stats: Vec<(String, f64)>,
	pub dmin: Option<f64>,
	pub dmax: Option<f64>,
	pub speed: Option<f64>,
}

impl Rec {
	fn stat(&self, k: &str) -> Option<f64> {
		self.stats.iter().find(|s| s.0 == k).map(|s| s.1)
	}
	fn set_stat(&mut self, k: &str, v: f64) {
		match self.stats.iter_mut().find(|s| s.0 == k) {
			Some(s) => s.1 = v,
			None => self.stats.push((k.to_string(), v)),
		}
	}
}

fn opt_str(n: Option<f64>) -> String {
	n.map(num_str).unwrap_or_else(|| "undefined".into())
}

fn truthy(n: f64) -> bool {
	n != 0.0 && !n.is_nan()
}

/// stats.js `encode`.
pub fn encode(rec: &Rec) -> String {
	let mut parts: Vec<String> = [&rec.inv, &rec.ilvl, &rec.req, &rec.quality, &rec.cls, &rec.sub].iter().map(|v| v.to_js_string()).collect();
	for k in STAT_KEYS {
		if let Some(v) = rec.stat(k).filter(|v| truthy(*v)) {
			parts.push(format!("{}{}", token(k), num_str(v)));
		}
	}
	if rec.speed.is_some_and(truthy) {
		parts.push(format!("dmin{}", opt_str(rec.dmin)));
		parts.push(format!("dmax{}", opt_str(rec.dmax)));
		parts.push(format!("speed{}", opt_str(rec.speed)));
	}
	if rec.allow.truthy() {
		parts.push(format!("cls{}", rec.allow.to_js_string()));
	}
	if rec.unique {
		parts.push("uniq1".into());
	}
	parts.join(" ")
}

/// stats.js `decode`. Stat values may carry decimals (ratings converted to percent: `crit0.5`).
pub fn decode(id: f64, s: &str) -> Result<Rec, String> {
	let parts: Vec<&str> = s.split(' ').collect();
	let n = |i: usize| V::Num(parts.get(i).map(|p| str_to_num(p)).unwrap_or(f64::NAN));
	let mut rec = Rec { id, inv: n(0), ilvl: n(1), req: n(2), quality: n(3), cls: n(4), sub: n(5), allow: V::Num(0.0), unique: false, stats: Vec::new(), dmin: None, dmax: None, speed: None };
	for tok in parts.iter().skip(6) {
		let split = tok.find(|c: char| !c.is_ascii_alphabetic()).unwrap_or(tok.len());
		let (name, num) = tok.split_at(split);
		let digits = num.strip_prefix('-').unwrap_or(num);
		let (int_part, frac) = digits.split_once('.').unwrap_or((digits, "0"));
		let all_digits = |d: &str| !d.is_empty() && d.bytes().all(|b| b.is_ascii_digit());
		if name.is_empty() || !all_digits(int_part) || !all_digits(frac) {
			return Err(format!("item {}: bad token \"{tok}\"", num_str(id)));
		}
		let v = str_to_num(num);
		match name {
			"dmin" => rec.dmin = Some(v),
			"dmax" => rec.dmax = Some(v),
			"speed" => rec.speed = Some(v),
			"cls" => rec.allow = V::Num(v),
			"uniq" => rec.unique = v == 1.0,
			_ => rec.set_stat(untoken(name), v),
		}
	}
	Ok(rec)
}

/// Era Items.lua text -> id -> record.
pub fn read_era_items(text: &str) -> Result<FxHashMap<u64, Rec>, String> {
	let re = regex::Regex::new(r#"\[(\d+)\]="([^"]*)""#).unwrap();
	let mut out = FxHashMap::default();
	for m in re.captures_iter(text) {
		let id = str_to_num(&m[1]);
		out.insert(id as u64, decode(id, &m[2])?);
	}
	Ok(out)
}

/// Codex providers that may not feed shipped data: the local extras (AtlasLoot, RareScanner, the
/// dungeon journal addon) and ForeverLevelingBiS, which Polestar no longer uses. A source counts
/// when at least one other provider has it.
const NOT_SHIPPED: [&str; 4] = ["flbis", "atlasloot", "rarescanner", "journal"];

fn release_safe(src: &Value) -> bool {
	src.get("from").and_then(Value::as_array).is_some_and(|f| f.iter().filter_map(Value::as_str).any(|p| !NOT_SHIPPED.contains(&p)))
}

fn read_json(p: &Path) -> Result<Value, String> {
	let b = std::fs::read(p).map_err(|e| format!("{}: {e} (run `forge data codex` first)", p.display()))?;
	serde_json::from_slice(&b).map_err(|e| format!("{}: {e}", p.display()))
}

/// The Codex output the gear data reads: data/forever/codex/{items,quests,npcs,meta}.json and
/// data/forever/zones.json (UiMap -> AreaTable area).
pub struct Codex {
	pub items: Value,
	pub quests: Value,
	pub npcs: Value,
	pub meta: Value,
	pub zones: Value,
}

impl Codex {
	pub fn read(data: &Path) -> Result<Codex, String> {
		let c = data.join("codex");
		Ok(Codex {
			items: read_json(&c.join("items.json"))?,
			quests: read_json(&c.join("quests.json"))?,
			npcs: read_json(&c.join("npcs.json"))?,
			meta: read_json(&c.join("meta.json"))?,
			zones: read_json(&data.join("zones.json"))?,
		})
	}

	/// A UiMap's AreaTable area (0: unknown).
	fn area(&self, ui_map: Option<f64>) -> f64 {
		ui_map.and_then(|m| self.zones.get(num_str(m)).and_then(|z| z.get("areaId")).and_then(Value::as_f64)).unwrap_or(0.0)
	}

	/// AreaTable area -> name (the first UiMap naming it).
	fn area_name(&self, area: f64) -> Option<String> {
		self.zones.as_object()?.values().find(|z| z.get("areaId").and_then(Value::as_f64) == Some(area)).and_then(|z| z.get("name")).and_then(Value::as_str).map(str::to_string)
	}
}

fn num_of(v: &Value, k: &str) -> Option<f64> {
	v.get(k).and_then(Value::as_f64)
}

#[derive(Default)]
pub struct Counts {
	pub items: usize,
	pub overlay: Overlay,
	pub quest: usize,
	pub drop: usize,
	pub crafted: usize,
	pub quests: usize,
	/// Codex sources left out as not release-safe.
	pub not_shipped: usize,
}

impl Counts {
	pub fn to_v(&self) -> V {
		let o = forge_guide::js::Obj::new();
		let n = |x: usize| V::Num(x as f64);
		o.set("items", n(self.items));
		o.set("newItems", n(self.overlay.new_items));
		o.set("retuned", n(self.overlay.retuned));
		o.set("unchanged", n(self.overlay.unchanged));
		let s = forge_guide::js::Obj::new();
		s.set("quest", n(self.quest));
		s.set("drop", n(self.drop));
		s.set("crafted", n(self.crafted));
		o.set("sources", V::Obj(s));
		o.set("quests", n(self.quests));
		o.set("notShipped", n(self.not_shipped));
		V::Obj(o)
	}
}

pub struct Pack {
	pub lua: String,
	pub counts: Counts,
	pub warnings: Vec<String>,
}

/// Forever.lua: `overlay` (Forever's records that differ from Era's) and the leveling sources of the
/// gear quests reward. `gear` holds every item id with a record (Era or Forever); `names` is the
/// Forever client's item names, for items the Codex has no name for; `build` the Forever build.
pub fn build_forever_pack(overlay: &[Rec], overlay_counts: Overlay, gear: &FxHashSet<u64>, names: &FxHashMap<u64, String>, codex: &Codex, build: &str) -> Result<Pack, String> {
	let mut warnings = Vec::new();
	let mut counts = Counts { overlay: overlay_counts, ..Counts::default() };
	let empty = serde_json::Map::new();
	let items = codex.items.as_object().unwrap_or(&empty);

	// Each gear item's release-safe quest sources: quest -> (choices, rewards) as the Codex lists them.
	let mut offered: FxHashMap<u64, (Vec<u64>, Vec<u64>)> = FxHashMap::default();
	for (id, it) in items {
		let Ok(id) = id.parse::<u64>() else { continue };
		if !gear.contains(&id) {
			continue;
		}
		for s in it.get("sources").and_then(Value::as_array).into_iter().flatten() {
			if s.get("type").and_then(Value::as_str) != Some("quest") {
				continue;
			}
			if !release_safe(s) {
				counts.not_shipped += 1;
				continue;
			}
			let Some(q) = num_of(s, "quest") else { continue };
			let e = offered.entry(q as u64).or_default();
			if s.get("choice").and_then(Value::as_bool) == Some(true) {
				e.0.push(id);
			} else {
				e.1.push(id);
			}
		}
	}

	// The quests, choices in the quest's own order (the Codex quest record), then any others by id.
	let in_order = |listed: Option<&Value>, mut ids: Vec<u64>| -> Vec<u64> {
		let mut out: Vec<u64> = listed.and_then(Value::as_array).into_iter().flatten().filter_map(Value::as_u64).filter(|i| ids.contains(i)).collect();
		let mut seen: FxHashSet<u64> = FxHashSet::default();
		out.retain(|i| seen.insert(*i));
		ids.sort_unstable();
		ids.dedup();
		out.extend(ids.into_iter().filter(|i| !seen.contains(i)));
		out
	};
	let mut quest_ids: Vec<u64> = offered.keys().copied().collect();
	quest_ids.sort_unstable();
	let mut quests: Vec<(u64, String)> = Vec::new();
	let mut kept: Vec<u64> = Vec::new();
	let mut item_quests: FxHashMap<u64, Vec<u64>> = FxHashMap::default();
	for qid in quest_ids {
		let (choices, rewards) = offered.remove(&qid).unwrap();
		let q = codex.quests.get(qid.to_string()).cloned().unwrap_or(Value::Null);
		let choices = in_order(q.get("choices"), choices);
		let rewards = in_order(q.get("rewards"), rewards);
		for &i in choices.iter().chain(rewards.iter()) {
			kept.push(i);
			item_quests.entry(i).or_default().push(qid);
		}
		let side = match q.get("faction").and_then(Value::as_str) {
			Some("A") => 1.0,
			Some("H") => 2.0,
			_ => 3.0,
		};
		let head = [
			num_of(&q, "level").unwrap_or(0.0),
			num_of(&q, "minLevel").unwrap_or(0.0),
			side,
			codex.area(num_of(&q, "zone")),
			num_of(&q, "races").unwrap_or(0.0),
			num_of(&q, "classes").unwrap_or(0.0),
			0.0,
		]
		.iter()
		.map(|n| num_str(*n))
		.collect::<Vec<_>>()
		.join(" ");
		let join = |l: &[u64]| l.iter().map(u64::to_string).collect::<Vec<_>>().join(",");
		let title = q.get("title").and_then(Value::as_str).unwrap_or("");
		quests.push((qid, format!("{head}|{}|{}|{title}", join(&choices), join(&rewards))));
	}
	counts.quests = quests.len();
	kept.sort_unstable();
	kept.dedup();
	counts.items = kept.len();

	// Names and sources of those items.
	let mut item_names: Vec<(u64, String)> = Vec::new();
	let mut src: Vec<(u64, String)> = Vec::new();
	let mut npcs: FxHashMap<u64, String> = FxHashMap::default();
	let mut zones: FxHashMap<u64, String> = FxHashMap::default();
	for &id in &kept {
		let it = items.get(&id.to_string());
		let name = it.and_then(|i| i.get("name")).and_then(Value::as_str).map(str::to_string).or_else(|| names.get(&id).cloned()).unwrap_or_default();
		item_names.push((id, name));
		let mut toks: Vec<String> = item_quests.get(&id).into_iter().flatten().map(|q| format!("q{q}")).collect();
		for s in it.and_then(|i| i.get("sources")).and_then(Value::as_array).into_iter().flatten() {
			match s.get("type").and_then(Value::as_str) {
				Some("drop") if release_safe(s) => {
					let npc = num_of(s, "npc").unwrap_or(0.0);
					let n = codex.npcs.get(num_str(npc));
					let zone = codex.area(n.and_then(|n| n.get("spawns")).and_then(|s| s.get(0)).and_then(|s| num_of(s, "map")));
					if let Some(name) = n.and_then(|n| n.get("name")).and_then(Value::as_str) {
						npcs.insert(npc as u64, name.to_string());
					}
					if zone > 0.0 {
						if let Some(z) = codex.area_name(zone) {
							zones.insert(zone as u64, z);
						}
					}
					toks.push(format!("d{}x{}z{}", num_str(npc), num_str(math_round(num_of(s, "chance").unwrap_or(0.0) * 10.0)), num_str(zone)));
				}
				Some("craft") if release_safe(s) => {
					let prof = s.get("profession").and_then(Value::as_str);
					let p = prof.and_then(|n| PROFESSIONS.iter().position(|x| *x == n)).map(|i| i + 1).unwrap_or(0);
					if p == 0 {
						warnings.push(format!("item {id}: unknown profession {}", prof.unwrap_or("?")));
					}
					toks.push(format!("c{}p{p}s{}", num_str(num_of(s, "spell").unwrap_or(0.0)), num_str(num_of(s, "skill").unwrap_or(0.0))));
				}
				_ => {}
			}
		}
		let mut seen = FxHashSet::default();
		toks.retain(|t| seen.insert(t.clone()));
		for t in &toks {
			match t.as_bytes()[0] {
				b'q' => counts.quest += 1,
				b'd' => counts.drop += 1,
				_ => counts.crafted += 1,
			}
		}
		src.push((id, toks.join(" ")));
	}
	for (_, q) in &quests {
		let area = q.split(' ').nth(3).and_then(|z| z.parse::<f64>().ok()).unwrap_or(0.0);
		if area > 0.0 {
			if let Some(z) = codex.area_name(area) {
				zones.insert(area as u64, z);
			}
		}
	}

	let codex_build = codex.meta.get("build").and_then(Value::as_str).unwrap_or("?");
	let built = codex.meta.get("builtAt").and_then(Value::as_str).map(|s| s.chars().take(10).collect::<String>()).unwrap_or_default();
	let mut lines: Vec<String> = vec![
		forge_guide::emit::header("lua", "forge data gear", &format!("the Forever client's item tables ({build}) and the Codex ({built})")),
		"-- See THIRD_PARTY.md. Facts only: Forever's item stats over the Era table, computed from".into(),
		"-- the Forever client's tables as its tooltips are, and which quests reward which gear, from".into(),
		"-- the Codex's release-safe sources (the game's tables, QuestieDB, pfQuest, recordings).".into(),
		"--   items   \"<inv> <ilvl> <req> <quality> <class> <subclass> [tokens]\" (Items.lua format)".into(),
		"--   src     q<quest> | d<npc>x<pct*10>z<zone> | c<spell>p<profession>s<skill>".into(),
		"--   quests  \"<level> <req> <side> <zone> <reqRace> <reqClass> <dungeon>|<choices>|<items>|<name>\"".into(),
		String::new(),
		"local DB = Polestar and Polestar.ItemDB".into(),
		"if not (DB and DB.Register and DB.RegisterLeveling) then return end".into(),
		String::new(),
		"DB.Register(nil, {".into(),
	];
	for r in overlay {
		lines.push(format!("[{}]={},", num_str(r.id), lua_str(&encode(r))));
	}
	lines.push("})".into());
	lines.push(String::new());
	lines.push(format!(
		"DB.RegisterLeveling({{ source = \"Codex\", version = {}, generated = {}, items = {}, quests = {} }}, {{",
		lua_str(codex_build),
		lua_str(&built),
		item_names.len(),
		quests.len()
	));
	lines.push(format!("professions = {{ {} }},", PROFESSIONS.iter().map(|p| lua_str(p)).collect::<Vec<_>>().join(", ")));
	lines.push("names = {".into());
	for (id, n) in &item_names {
		lines.push(format!("[{id}]={},", lua_str(n)));
	}
	lines.push("},".into());
	lines.push("src = {".into());
	for (id, s) in &src {
		lines.push(format!("[{id}]={},", lua_str(s)));
	}
	lines.push("},".into());
	lines.push("quests = {".into());
	for (id, s) in &quests {
		lines.push(format!("[{id}]={},", lua_str(s)));
	}
	lines.push("},".into());
	for (name, map) in [("npcs", &npcs), ("zones", &zones)] {
		lines.push(format!("{name} = {{"));
		let mut ids: Vec<(&u64, &String)> = map.iter().collect();
		ids.sort();
		for (id, n) in ids {
			lines.push(format!("[{id}]={},", lua_str(n)));
		}
		lines.push("},".into());
	}
	lines.push("})".into());
	lines.push(String::new());
	Ok(Pack { lua: lines.join("\n"), counts, warnings })
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	#[test]
	fn encode_decode_round_trip() {
		for s in ["13 31 26 3 2 15 agi7 dmin17 dmax33 speed1300 uniq1", "10 42 37 4 4 2 armor86 ap10 crit1 mpr4 cls8", "23 25 0 2 4 0", "1 30 25 2 4 2 crit0.5 spellCrit0.5"] {
			assert_eq!(encode(&decode(1.0, s).unwrap()), s);
		}
		assert!(decode(1.0, "1 2 3 4 5 6 x").is_err());
		assert!(decode(1.0, "1 2 3 4 5 6 crit0.").is_err());
		assert!(decode(1.0, "1 2 3 4 5 6 crit.5").is_err());
	}

	#[test]
	fn quest_gear_comes_from_release_safe_codex_sources_only() {
		let codex = Codex {
			items: json!({
				"100": { "name": "Choice A", "sources": [{ "type": "quest", "quest": 7, "choice": true, "from": ["web"] }, { "type": "drop", "npc": 5, "chance": 1.25, "from": ["questie", "pfquest"] }] },
				"101": { "name": "Choice B", "sources": [{ "type": "quest", "quest": 7, "choice": true, "from": ["recordings"] }, { "type": "craft", "spell": 9, "profession": "Tailoring", "skill": 50, "from": ["forever"] }] },
				"102": { "name": "Old list only", "sources": [{ "type": "quest", "quest": 8, "choice": true, "from": ["flbis"] }, { "type": "drop", "npc": 6, "chance": 2, "from": ["atlasloot"] }] },
				"103": { "name": "Not gear", "sources": [{ "type": "quest", "quest": 7, "from": ["web"] }] }
			}),
			quests: json!({ "7": { "title": "Seven", "level": 10, "minLevel": 8, "faction": "A", "zone": 1429, "races": null, "classes": null, "choices": [101, 100], "rewards": [] } }),
			npcs: json!({ "5": { "name": "Wolf", "spawns": [{ "map": 1429 }] } }),
			meta: json!({ "build": "1.60.1.1", "builtAt": "2026-11-06T22:00:00.000Z" }),
			zones: json!({ "1429": { "areaId": 12, "name": "Elwynn Forest" } }),
		};
		let gear: FxHashSet<u64> = [100, 101, 102].into_iter().collect();
		let p = build_forever_pack(&[], Overlay::default(), &gear, &FxHashMap::default(), &codex, "1.60.1.1").unwrap();
		assert!(p.lua.contains("[7]=\"10 8 1 12 0 0 0|101,100||Seven\",\n},"), "{}", p.lua);
		assert!(p.lua.contains("[100]=\"q7 d5x13z12\",\n[101]=\"q7 c9p6s50\",\n},"), "{}", p.lua);
		assert!(p.lua.contains("npcs = {\n[5]=\"Wolf\",\n},\nzones = {\n[12]=\"Elwynn Forest\",\n},"), "{}", p.lua);
		assert!(!p.lua.contains("Old list only") && !p.lua.contains("[8]="), "{}", p.lua);
		assert_eq!((p.counts.quests, p.counts.items, p.counts.not_shipped), (1, 2, 1));
	}
}
