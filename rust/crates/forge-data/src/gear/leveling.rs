//! tools/lib/gear/leveling.js (+ the itemdb/stats.js encode/decode it uses): ForeverLevelingBiS ->
//! addon/Polestar_ItemDB/Forever.lua, Forever's item stats over the Era table and where each
//! leveling item comes from.

use forge_guide::js::{num_str, str_to_num, Obj, V};
use rustc_hash::{FxHashMap, FxHashSet};

use super::flb::Flb;
use crate::jsv::{math_round, to_int32};

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

const SCRAPED: [&str; 21] =
	["str", "agi", "sta", "int", "spi", "armor", "health", "mana", "ap", "rap", "sp", "heal", "spArcane", "spFire", "spFrost", "spHoly", "spNature", "spShadow", "defense", "dps", "rdps"];

const EQUIPPABLE: [f64; 23] = [1.0, 2.0, 3.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 20.0, 21.0, 22.0, 23.0, 25.0, 26.0, 28.0];

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

/// stats.js `decode`.
pub fn decode(id: f64, s: &str) -> Result<Rec, String> {
	let parts: Vec<&str> = s.split(' ').collect();
	let n = |i: usize| V::Num(parts.get(i).map(|p| str_to_num(p)).unwrap_or(f64::NAN));
	let mut rec = Rec { id, inv: n(0), ilvl: n(1), req: n(2), quality: n(3), cls: n(4), sub: n(5), allow: V::Num(0.0), unique: false, stats: Vec::new(), dmin: None, dmax: None, speed: None };
	for tok in parts.iter().skip(6) {
		let split = tok.find(|c: char| !c.is_ascii_alphabetic()).unwrap_or(tok.len());
		let (name, num) = tok.split_at(split);
		let digits = num.strip_prefix('-').unwrap_or(num);
		if name.is_empty() || digits.is_empty() || !digits.bytes().all(|b| b.is_ascii_digit()) {
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
fn read_era_items(text: &str) -> Result<FxHashMap<u64, Rec>, String> {
	let re = regex::Regex::new(r#"\[(\d+)\]="([^"]*)""#).unwrap();
	let mut out = FxHashMap::default();
	for m in re.captures_iter(text) {
		let id = str_to_num(&m[1]);
		out.insert(id as u64, decode(id, &m[2])?);
	}
	Ok(out)
}

/// `a || b` over JS values.
fn or(a: V, b: impl FnOnce() -> V) -> V {
	if a.truthy() {
		a
	} else {
		b()
	}
}

fn record_of(it: &V, era: Option<&Rec>) -> Rec {
	let mut stats: Vec<(String, f64)> = Vec::new();
	if let Some(e) = era {
		for (k, v) in &e.stats {
			if !SCRAPED.contains(&k.as_str()) {
				stats.push((k.clone(), *v));
			}
		}
	}
	let mut rec = Rec {
		id: it.get("id").num(),
		inv: it.get("slot"),
		ilvl: or(it.get("itemLevel"), || or(era.map(|e| e.ilvl.clone()).unwrap_or(V::Undef), || V::Num(0.0))),
		req: match era {
			Some(e) => e.req.clone(),
			None => or(it.get("reqLevel"), || V::Num(0.0)),
		},
		quality: {
			let q = it.get("quality");
			if !q.is_nullish() {
				q
			} else {
				match era.map(|e| e.quality.clone()) {
					Some(q) if !q.is_nullish() => q,
					_ => V::Num(1.0),
				}
			}
		},
		cls: it.get("class"),
		sub: match it.get("subclass") {
			V::Num(n) if n < 0.0 => V::Num(0.0),
			s => s,
		},
		allow: {
			let mask = it.get("classMask");
			if mask.truthy() && (to_int32(mask.num()) & 0x5df) != 0x5df {
				mask
			} else {
				era.map(|e| e.allow.clone()).unwrap_or(V::Num(0.0))
			}
		},
		unique: era.is_some_and(|e| e.unique),
		stats,
		dmin: None,
		dmax: None,
		speed: None,
	};
	for (k, v) in it.get("polestar").entries() {
		if &*k == "dps" || &*k == "rdps" {
			continue;
		}
		if STAT_KEYS.contains(&&*k) && v.truthy() {
			rec.set_stat(&k, math_round(v.num()));
		}
	}
	let w = it.get("weapon");
	if w.truthy() && w.get("max").num() > 0.0 && w.get("speed").num() > 0.0 {
		rec.dmin = Some(math_round(w.get("min").num()));
		rec.dmax = Some(math_round(w.get("max").num()));
		rec.speed = Some(math_round(w.get("speed").num() * 1000.0));
	} else if let Some(e) = era.filter(|e| e.speed.is_some_and(truthy)) {
		rec.dmin = e.dmin;
		rec.dmax = e.dmax;
		rec.speed = e.speed;
	}
	rec
}

/// A JS Map keyed by number, insertion ordered.
#[derive(Default)]
struct NumMap(Vec<(f64, V)>);
impl NumMap {
	fn set(&mut self, k: f64, v: V) {
		match self.0.iter_mut().find(|e| e.0 == k || (e.0.is_nan() && k.is_nan())) {
			Some(e) => e.1 = v,
			None => self.0.push((k, v)),
		}
	}
	fn sorted(&self) -> Vec<(f64, V)> {
		let mut v = self.0.clone();
		v.sort_by(|a, b| (a.0 - b.0).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
		v
	}
}

fn source_tokens(it: &V, npcs: &mut NumMap, zones: &mut NumMap, warn: &mut Vec<String>) -> Vec<String> {
	let mut out: Vec<String> = Vec::new();
	for s in it.get("sources").items() {
		let ty = s.get("type");
		let ty = ty.as_str().unwrap_or("");
		if ty == "quest" && s.get("id").truthy() {
			out.push(format!("q{}", s.get("id").to_js_string()));
		} else if ty == "drop" {
			let npc = or(s.get("npcId"), || V::Num(0.0));
			if npc.truthy() {
				npcs.set(npc.num(), s.get("npc"));
			}
			if s.get("zoneId").truthy() && s.get("zone").truthy() {
				zones.set(s.get("zoneId").num(), s.get("zone"));
			}
			let pct = or(s.get("pct"), || V::Num(0.0)).num();
			out.push(format!("d{}x{}z{}", npc.to_js_string(), num_str(math_round(pct * 10.0)), or(s.get("zoneId"), || V::Num(0.0)).to_js_string()));
		} else if ty == "crafted" && s.get("spellId").truthy() {
			let prof = s.get("profession");
			let p = prof.as_str().and_then(|n| PROFESSIONS.iter().position(|x| *x == n)).map(|i| i + 1).unwrap_or(0);
			if p == 0 {
				warn.push(format!("item {}: unknown profession {}", it.get("id").to_js_string(), prof.to_js_string()));
			}
			out.push(format!("c{}p{p}s{}", s.get("spellId").to_js_string(), or(s.get("skill"), || V::Num(0.0)).to_js_string()));
		} else {
			warn.push(format!("item {}: source type {} not kept", it.get("id").to_js_string(), s.get("type").to_js_string()));
		}
	}
	let mut seen = FxHashSet::default();
	out.retain(|t| seen.insert(t.clone()));
	out
}

#[derive(Default)]
pub struct Counts {
	pub items: usize,
	pub new_items: usize,
	pub retuned: usize,
	pub unchanged: usize,
	pub quest: usize,
	pub drop: usize,
	pub crafted: usize,
	pub quests: usize,
	pub skipped_slot: usize,
}

impl Counts {
	pub fn to_v(&self) -> V {
		let o = Obj::new();
		let n = |x: usize| V::Num(x as f64);
		o.set("items", n(self.items));
		o.set("newItems", n(self.new_items));
		o.set("retuned", n(self.retuned));
		o.set("unchanged", n(self.unchanged));
		let s = Obj::new();
		s.set("quest", n(self.quest));
		s.set("drop", n(self.drop));
		s.set("crafted", n(self.crafted));
		o.set("sources", V::Obj(s));
		o.set("quests", n(self.quests));
		o.set("skippedSlot", n(self.skipped_slot));
		V::Obj(o)
	}
}

pub struct Pack {
	pub lua: String,
	pub counts: Counts,
	pub warnings: Vec<String>,
}

fn sorted_num_keys(o: &Obj) -> Vec<(f64, forge_guide::js::Str)> {
	let mut ids: Vec<(f64, forge_guide::js::Str)> = o.keys().into_iter().map(|k| (str_to_num(&k), k)).collect();
	ids.sort_by(|a, b| (a.0 - b.0).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
	ids
}

/// buildForeverPack(flb, eraText).
pub fn build_forever_pack(flb: &Flb, era_text: &str) -> Result<Pack, String> {
	let era = read_era_items(era_text)?;
	let mut warnings = Vec::new();
	let mut overlay: Vec<Rec> = Vec::new();
	let mut names: Vec<(f64, V)> = Vec::new();
	let mut src: Vec<(f64, String)> = Vec::new();
	let mut npcs = NumMap::default();
	let mut zones = NumMap::default();
	for (k, v) in flb.zones.entries() {
		zones.set(str_to_num(&k), v);
	}
	let mut counts = Counts::default();
	let mut used_quests: FxHashSet<u64> = FxHashSet::default();
	for (id, key) in sorted_num_keys(&flb.items) {
		let it = flb.items.get(&key);
		if !matches!(it.get("slot"), V::Num(s) if EQUIPPABLE.contains(&s)) {
			counts.skipped_slot += 1;
			continue;
		}
		counts.items += 1;
		let e = if id >= 0.0 && id.fract() == 0.0 { era.get(&(id as u64)) } else { None };
		let rec = record_of(&it, e);
		match e {
			None => {
				counts.new_items += 1;
				overlay.push(rec);
			}
			Some(e) if encode(&rec) != encode(e) => {
				counts.retuned += 1;
				overlay.push(rec);
			}
			Some(_) => counts.unchanged += 1,
		}
		names.push((id, it.get("name")));
		let toks = source_tokens(&it, &mut npcs, &mut zones, &mut warnings);
		for t in &toks {
			match t.as_bytes()[0] {
				b'q' => {
					counts.quest += 1;
					used_quests.insert(str_to_num(&t[1..]).to_bits());
				}
				b'd' => counts.drop += 1,
				_ => counts.crafted += 1,
			}
		}
		if !toks.is_empty() {
			src.push((id, toks.join(" ")));
		}
	}

	let kept: FxHashSet<u64> = names.iter().map(|(id, _)| id.to_bits()).collect();
	let in_kept = |v: &V| matches!(v, V::Num(n) if kept.contains(&(if *n == 0.0 { 0.0f64 } else { *n }).to_bits()));
	let mut quests: Vec<(f64, String)> = Vec::new();
	for (qid, key) in sorted_num_keys(&flb.quests) {
		let q = flb.quests.get(&key);
		let r = or(q.get("rewards"), || V::Obj(Obj::new()));
		let list = |k: &str| -> Vec<String> { or(r.get(k), || V::Arr(forge_guide::js::Arr::new())).items().into_iter().filter(|i| in_kept(i)).map(|i| i.to_js_string()).collect() };
		let choices = list("choices");
		let items = list("items");
		if choices.is_empty() && items.is_empty() && !used_quests.contains(&qid.to_bits()) {
			continue;
		}
		counts.quests += 1;
		let start = q.get("start");
		let zone = if start.truthy() { or(start.get("zoneId"), || V::Num(0.0)) } else { V::Num(0.0) };
		let head = [
			or(q.get("level"), || V::Num(0.0)),
			or(q.get("reqLevel"), || V::Num(0.0)),
			or(q.get("side"), || V::Num(3.0)),
			zone,
			or(q.get("reqRace"), || V::Num(0.0)),
			or(q.get("reqClass"), || V::Num(0.0)),
			V::Num(if q.get("type").as_str() == Some("Dungeon") { 1.0 } else { 0.0 }),
		]
		.iter()
		.map(|v| if v.is_nullish() { String::new() } else { v.to_js_string() })
		.collect::<Vec<_>>()
		.join(" ");
		quests.push((qid, format!("{head}|{}|{}|{}", choices.join(","), items.join(","), or(q.get("name"), || V::str("")).to_js_string())));
	}

	let m = &flb.meta;
	let version = m.get("version").to_js_string();
	let generated = m.get("generated");
	let mut lines: Vec<String> = vec![
		forge_guide::emit::header("lua", "forge data gear", &format!("ForeverLevelingBiS {version} by Thunder (data {}), MIT licence", or(generated.clone(), || V::str("?")).to_js_string())),
		"-- See THIRD_PARTY.md. Facts only: Forever item stats over the Era table, and".into(),
		"-- where each leveling item comes from.".into(),
		"--   items   \"<inv> <ilvl> <req> <quality> <class> <subclass> [tokens]\" (Items.lua format)".into(),
		"--   src     q<quest> | d<npc>x<pct*10>z<zone> | c<spell>p<profession>s<skill>".into(),
		"--   quests  \"<level> <req> <side> <zone> <reqRace> <reqClass> <dungeon>|<choices>|<items>|<name>\"".into(),
		String::new(),
		"local DB = Polestar and Polestar.ItemDB".into(),
		"if not (DB and DB.Register and DB.RegisterLeveling) then return end".into(),
		String::new(),
		"DB.Register(nil, {".into(),
	];
	for r in &overlay {
		lines.push(format!("[{}]={},", num_str(r.id), lua_str(&encode(r))));
	}
	lines.push("})".into());
	lines.push(String::new());
	lines.push(format!(
		"DB.RegisterLeveling({{ source = \"ForeverLevelingBiS\", version = {}, generated = {}, licence = \"MIT\", items = {}, quests = {} }}, {{",
		lua_str(&version),
		lua_str(&or(generated, || V::str("")).to_js_string()),
		names.len(),
		quests.len()
	));
	lines.push(format!("professions = {{ {} }},", PROFESSIONS.iter().map(|p| lua_str(p)).collect::<Vec<_>>().join(", ")));
	lines.push("names = {".into());
	for (id, n) in &names {
		lines.push(format!("[{}]={},", num_str(*id), lua_str(&n.to_js_string())));
	}
	lines.push("},".into());
	lines.push("src = {".into());
	for (id, s) in &src {
		lines.push(format!("[{}]={},", num_str(*id), lua_str(s)));
	}
	lines.push("},".into());
	lines.push("quests = {".into());
	for (id, s) in &quests {
		lines.push(format!("[{}]={},", num_str(*id), lua_str(s)));
	}
	lines.push("},".into());
	for (name, map) in [("npcs", &npcs), ("zones", &zones)] {
		lines.push(format!("{name} = {{"));
		for (id, n) in map.sorted() {
			lines.push(format!("[{}]={},", num_str(id), lua_str(&n.to_js_string())));
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

	#[test]
	fn encode_decode_round_trip() {
		for s in ["13 31 26 3 2 15 agi7 dmin17 dmax33 speed1300 uniq1", "10 42 37 4 4 2 armor86 ap10 crit1 mpr4 cls8", "23 25 0 2 4 0"] {
			assert_eq!(encode(&decode(1.0, s).unwrap()), s);
		}
		assert!(decode(1.0, "1 2 3 4 5 6 x").is_err());
	}
}
