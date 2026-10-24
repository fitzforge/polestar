//! The Forever knowledge base (port of tools/lib/data/kb.js on sim-v2): one fact per (kind, id,
//! field), chosen from every source by one precedence, the other sources' values kept as
//! alternatives; the winners are written back into the tables, so data/forever is the KB's choice.
//! The KB itself is data/local/kb/forever-kb.sqlite (+ verify-in-game.json). See the JS file's
//! header and docs/ARCHITECTURE.md "Knowledge base" for the rules.

use std::path::{Path, PathBuf};

use forge_guide::js::{num_str, parse_json, stringify, Obj, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{arr, hypot, math_round, nums, to_int32};
use crate::players::{round_quest_xp, Eg, EgQuest, QuestXp, Vo};

const TIERS: [(&str, f64); 24] = [
	("recorder", 0.0),
	("correction", 0.0),
	("tdb", 1.0),
	("client", 1.0),
	("eg.observed", 1.4),
	("eg", 1.5),
	("client.cache", 1.5),
	("page", 2.0),
	("foreverdb.seen", 3.0),
	("forevervo.seen", 3.0),
	("foreverdb", 3.1),
	("foreverdb.vendor", 3.2),
	("foreverdb.xp", 3.3),
	("questie", 4.0),
	("factoruide", 6.0),
	("factoruide.collector", 6.0),
	("factoruide.web", 6.0),
	("web", 6.5),
	("classic", 7.0),
	("foreverdb.classic", 7.0),
	("tdb.inherited", 7.0),
	("pfquest", 8.0),
	("eg.objectives", 9.0),
	("cmangos", 9.0),
];

/// Sources kept only to show which values an independent source confirms (the public tier, `forge
/// data publish`): recorded as alternatives, never a winner and never counted as agreement, so the
/// KB's choices and confidences are what they were without them.
const CHECK_ONLY: [&str; 3] = ["eg.objectives", "cmangos", "tdb.inherited"];
fn check_only(s: &str) -> bool {
	CHECK_ONLY.contains(&s)
}

fn label(s: &str) -> &str {
	match s {
		"correction" => "Polestar corrections",
		"tdb" => "Forever TrinityCore world DB, sniffed rows",
		"page" => "web quest-database pages",
		"foreverdb.seen" => "ForeverDB: players seen data",
		"foreverdb" => "ForeverDB: game cache",
		"foreverdb.vendor" => "ForeverDB: vendors and trainers",
		"foreverdb.xp" => "ForeverDB: captured XP",
		"questie" => "QuestieDB (Questie-Forever)",
		"client" => "Forever client tables with the server's hotfixes (the installed client)",
		"client.cache" => "Forever client caches (the server's quest, creature and object answers)",
		"factoruide" => "Factoruide",
		"factoruide.collector" => "Factoruide in-game collector",
		"factoruide.web" => "Factoruide rows from web sources",
		"eg.objectives" => "EG Link output: objectives as listed (the starting item kept)",
		"cmangos" => "CMaNGOS classic-db quest and creature templates",
		"web" => "web verdicts",
		"classic" => "CMaNGOS / VMaNGOS classic reference",
		"foreverdb.classic" => "ForeverDB Classic reference",
		"tdb.inherited" => "Forever TrinityCore world DB, inherited rows",
		"pfquest" => "pfQuest",
		"eg" => "EG Link output: players game caches (server quest answers)",
		"eg.observed" => "EG Link output: observed turn-in XP",
		"forevervo.seen" => "forever-vo in-game dialog captures",
		o => o,
	}
}

fn tier_raw(s: &str) -> f64 {
	TIERS.iter().find(|(n, _)| *n == s).map(|(_, t)| *t).unwrap_or(9.0)
}

const CAPTURED_XP: [&str; 5] = ["foreverdb.xp", "factoruide.collector", "eg", "eg.observed", "client.cache"];
fn captured(s: &str) -> bool {
	CAPTURED_XP.contains(&s)
}

/// The fields the client's tables decide (`client`): places, items, placed objects, existence.
/// Quest and NPC scalars come from the server, so the tables never decide those.
fn client_field(field: &str) -> bool {
	matches!(field, "start_place" | "end_place" | "in_client" | "placement" | "name" | "duration" | "quest_item" | "start_quest")
		|| field.starts_with("objective_place:")
		|| field.starts_with("objective_trigger:")
}

fn tier_of(source: &str, field: &str) -> f64 {
	if source == "client" && !client_field(field) {
		9.0
	} else if field == "xp" && captured(source) {
		tier_raw(source).min(1.5)
	} else {
		tier_raw(source)
	}
}

const VERIFY_FIELDS: [&str; 6] = ["races", "classes", "side", "react", "spawns", "status"];
fn verify_field(f: &str) -> bool {
	VERIFY_FIELDS.contains(&f)
}
const OBSERVED: [&str; 5] = ["eg", "forevervo.seen", "foreverdb.seen", "factoruide.collector", "foreverdb"];

fn decides_verify(field: &str, tier: f64) -> bool {
	tier <= if field == "races" || field == "classes" { 1.5 } else { 1.0 }
}

// ---- normalized values ----
const CLASS_BITS: [(i32, &str); 9] = [(1, "Warrior"), (2, "Paladin"), (4, "Hunter"), (8, "Rogue"), (16, "Priest"), (64, "Shaman"), (128, "Mage"), (256, "Warlock"), (1024, "Druid")];
const CLASS_ALL: i32 = 1503;
const RACE_BITS: [(u64, &str, char); 10] = [
	(1, "Human", 'A'),
	(2, "Orc", 'H'),
	(4, "Dwarf", 'A'),
	(8, "NightElf", 'A'),
	(16, "Undead", 'H'),
	(32, "Tauren", 'H'),
	(64, "Gnome", 'A'),
	(128, "Troll", 'H'),
	(1 << 32, "HighOrderSkyborne", 'A'),
	(1 << 33, "WindshaperSkyborne", 'H'),
];
const RACE_A: u64 = 1 | 4 | 8 | 64 | (1 << 32);
const RACE_H: u64 = 2 | 16 | 32 | 128 | (1 << 33);
fn race_classes(b: u64) -> &'static [i32] {
	match b {
		1 => &[1, 2, 3, 4, 5, 8, 9],
		2 => &[1, 3, 4, 7, 8, 9],
		4 => &[1, 2, 3, 4, 5, 7],
		8 => &[1, 3, 4, 5, 11],
		16 => &[1, 2, 4, 5, 8, 9],
		32 => &[1, 3, 7, 11],
		64 => &[1, 4, 5, 8, 9],
		128 => &[1, 3, 4, 5, 7, 8, 9],
		b if b == 1 << 32 => &[1, 3, 4, 8, 11],
		_ => &[1, 3, 4, 7, 11],
	}
}

fn norm_classes(mask: &V) -> String {
	let n = if mask.truthy() { mask.num() } else { 0.0 };
	let m = to_int32(n) & CLASS_ALL;
	if m == 0 || m == CLASS_ALL {
		return "any".into();
	}
	CLASS_BITS.iter().filter(|(b, _)| m & b != 0).map(|(_, n)| *n).collect::<Vec<_>>().join("/")
}

/// BigInt of a mask: a decimal string, or a number rounded; as an unsigned 64-bit value.
fn mask_u64(mask: &V) -> u64 {
	match mask {
		V::Str(s) => {
			let s = if s.is_empty() { "0" } else { s };
			s.trim().parse::<i128>().map(|x| x as u64).unwrap_or(0)
		}
		v => {
			let n = if v.truthy() { v.num() } else { 0.0 };
			(math_round(n) as i128) as u64
		}
	}
}

fn norm_races(mask: &V, classes: &V) -> String {
	let mut m = mask_u64(mask) & (RACE_A | RACE_H);
	if mask.truthy() && m == 0 {
		return "no-playable-race".into();
	}
	if !mask.truthy() {
		m = RACE_A | RACE_H;
	}
	let cn = if classes.truthy() { classes.num() } else { 0.0 };
	let cm = to_int32(cn) & CLASS_ALL;
	if cm != 0 && cm != CLASS_ALL {
		let ids: Vec<i32> = (0..11).filter(|k| cm & (1 << k) != 0).map(|k| k + 1).collect();
		let mut keep = 0u64;
		for (b, _, _) in RACE_BITS {
			if race_classes(b).iter().any(|c| ids.contains(c)) {
				keep |= b;
			}
		}
		m &= keep;
		if m == 0 {
			return "no-playable-race".into();
		}
	}
	if m == RACE_A | RACE_H {
		return "any".into();
	}
	if m == RACE_A {
		return "alliance".into();
	}
	if m == RACE_H {
		return "horde".into();
	}
	RACE_BITS.iter().filter(|(b, _, _)| m & b != 0).map(|(_, n, _)| *n).collect::<Vec<_>>().join("/")
}

fn race_mask_of(v: &str) -> Option<f64> {
	let r = v.split(" (").next().unwrap_or("");
	match r {
		"alliance" => return Some(RACE_A as f64),
		"horde" => return Some(RACE_H as f64),
		"any" | "no-playable-race" => return None,
		_ => {}
	}
	let names: Vec<&str> = r.split('/').collect();
	let bits: Vec<u64> = RACE_BITS.iter().filter(|(_, n, _)| names.contains(n)).map(|(b, _, _)| *b).collect();
	(bits.len() == names.len()).then(|| bits.iter().fold(0u64, |a, b| a | b) as f64)
}

fn junk(s: &str) -> bool {
	thread_local! {
		static RE: regex::Regex = regex::Regex::new(r"(?i)<NYI>|\[UNUSED\]|(?-u:\b)Reuse Me(?-u:\b)|(?-u:\b)DEPRECATED(?-u:\b)|^zz|\[PH\]|^<TXT>|(?-u:\b)UNUSED(?-u:\b)|(?-u:\b)OLD(?-u:\b)$").unwrap();
	}
	RE.with(|r| r.is_match(s))
}

fn level_range(v: &V) -> (f64, f64) {
	let s = v.to_js_string();
	let parts: Vec<f64> = s.split('-').map(forge_guide::js::str_to_num).collect();
	let a = parts[0];
	let b = parts.get(1).copied().unwrap_or(f64::NAN);
	(a, if b.is_finite() { b } else { a })
}

fn usable(field: &str, v: &V) -> bool {
	if v.is_nullish() || v.as_str() == Some("") {
		return false;
	}
	if (field == "start" || field == "end") && v.as_str() == Some("none") {
		return false;
	}
	match field {
		"level" | "min_level" | "xp" => v.num() > 0.0,
		"npc_level" => level_range(v).0 > 0.0,
		"title" | "name" | "subname" => !junk(&v.to_js_string()),
		_ => true,
	}
}

fn side_of_races(races: &str) -> String {
	let r = races.split(" (").next().unwrap_or("");
	match r {
		"any" | "no-playable-race" => return "both".into(),
		"alliance" => return "A".into(),
		"horde" => return "H".into(),
		_ => {}
	}
	let names: Vec<&str> = r.split('/').collect();
	let mut sides: Vec<char> = Vec::new();
	for (_, n, s) in RACE_BITS {
		if names.contains(&n) && !sides.contains(&s) {
			sides.push(s);
		}
	}
	if sides.len() == 1 {
		sides[0].to_string()
	} else {
		"both".into()
	}
}

/// `${k}:${Number(v)}` pairs, deduplicated, sorted by kind then id, joined by ','.
fn ents(pairs: &[(String, f64)]) -> String {
	let mut s: Vec<String> = Vec::new();
	for (k, v) in pairs {
		let t = format!("{k}:{}", num_str(*v));
		if !s.contains(&t) {
			s.push(t);
		}
	}
	let key = |t: &str| {
		let (a, b) = t.split_once(':').unwrap();
		(a.to_string(), forge_guide::js::str_to_num(b))
	};
	s.sort_by(|a, b| {
		let (ka, na) = key(a);
		let (kb, nb) = key(b);
		ka.cmp(&kb).then(na.partial_cmp(&nb).unwrap_or(std::cmp::Ordering::Equal))
	});
	s.join(",")
}

fn parse_ents(v: &V) -> Vec<(String, f64)> {
	if !v.truthy() || v.as_str() == Some("none") {
		return Vec::new();
	}
	v.to_js_string()
		.split([',', ';'])
		.filter(|t| !t.is_empty())
		.map(|t| {
			let mut it = t.split(':');
			let k = it.next().unwrap_or("").to_string();
			let i = it.next().map(forge_guide::js::str_to_num).unwrap_or(f64::NAN);
			(k, i)
		})
		.collect()
}

fn obj_kind(k: &str) -> Option<&'static str> {
	Some(match k {
		"kill" => "c",
		"item" => "i",
		"object" => "o",
		"event" => "e",
		"talk" => "x",
		_ => return None,
	})
}

fn objs(list: &[(String, V, V)]) -> String {
	if list.is_empty() {
		return "none".into();
	}
	list.iter()
		.map(|(k, i, c)| format!("{}:{}:{}", obj_kind(k).unwrap_or("x"), if i.truthy() { i.to_js_string() } else { "?".into() }, if c.truthy() { c.to_js_string() } else { "?".into() }))
		.collect::<Vec<_>>()
		.join(";")
}

struct PObj {
	k: String,
	id: Option<f64>,
	n: Option<f64>,
}

fn parse_objs(v: &V) -> Vec<PObj> {
	if !v.truthy() || v.as_str() == Some("none") {
		return Vec::new();
	}
	v.to_js_string()
		.split(';')
		.map(|t| {
			let mut it = t.split(':');
			let k = it.next().unwrap_or("").to_string();
			let i = it.next();
			let c = it.next();
			let num = |x: Option<&str>| match x {
				Some("?") => None,
				Some(s) => Some(forge_guide::js::str_to_num(s)),
				None => Some(f64::NAN),
			};
			PObj { k, id: num(i), n: num(c) }
		})
		.collect()
}

fn norm_title(v: &V) -> String {
	let s = if v.is_nullish() { String::new() } else { v.to_js_string() };
	let lower = s.to_lowercase();
	let mut out = String::new();
	let mut ws = false;
	for c in lower.chars() {
		if crate::objectives::is_js_space(c) {
			ws = true;
		} else {
			if ws && !out.is_empty() {
				out.push(' ');
			}
			ws = false;
			out.push(c);
		}
	}
	out
}

fn same(field: &str, a: &V, b: &V) -> bool {
	if a.is_nullish() || b.is_nullish() {
		return false;
	}
	match field {
		"title" | "name" | "subname" => norm_title(a) == norm_title(b),
		"npc_level" => {
			let (a0, a1) = level_range(a);
			let (b0, b1) = level_range(b);
			(a0 <= b0 && b1 <= a1) || (b0 <= a0 && a1 <= b1)
		}
		"start" | "end" => {
			let f = |v: &V| ents(&parse_ents(v).into_iter().filter(|(k, _)| k != "item").collect::<Vec<_>>());
			f(a) == f(b)
		}
		_ => a.to_js_string() == b.to_js_string(),
	}
}

fn same_xp(a: &V, b: &V, ca: bool, cb: bool) -> bool {
	let (x, y) = (a.num(), b.num());
	x == y || ((ca || cb) && (x - y).abs() <= 5f64.max(0.03 * x.max(y)))
}

// ---- the project's own fields, attributed per field ----
struct Corr {
	quest: FxHashMap<i64, Vec<String>>,
	npc: FxHashMap<i64, Vec<String>>,
	object: FxHashMap<i64, Vec<String>>,
}

fn corrected_fields(c: &V) -> Corr {
	let mut quest = FxHashMap::default();
	for (id, e) in c.get("quests").entries() {
		quest.insert(forge_guide::js::str_to_num(&id) as i64, e.get("set").keys().iter().map(|k| k.to_string()).collect());
	}
	let ent = |kind: &str| {
		let mut m = FxHashMap::default();
		for (id, e) in c.get(kind).entries() {
			let mut l: Vec<String> = e.get("set").keys().iter().map(|k| k.to_string()).collect();
			if e.get("addSpawns").truthy() {
				l.push("spawns".into());
			}
			m.insert(forge_guide::js::str_to_num(&id) as i64, l);
		}
		m
	};
	Corr { npc: ent("npcs"), object: ent("objects"), quest }
}

fn src_tags(r: &V) -> Vec<String> {
	r.get("source").items().iter().map(V::to_js_string).collect()
}

fn project_quest_source(q: &V, field: &str, corr: &Corr) -> &'static str {
	let tags = src_tags(q);
	if let Some(c) = corr.quest.get(&(q.get("id").num() as i64)) {
		let keys: &[&str] = match field {
			"title" => &["title"],
			"level" => &["level"],
			"min_level" => &["minLevel"],
			"xp" => &["xp"],
			"start" => &["start"],
			"end" => &["end"],
			"objectives" => &["objectives"],
			"races" => &["races"],
			"classes" => &["classes"],
			"prereqs" => &["pre", "preAny", "preAll"],
			f => {
				if c.iter().any(|k| k == f) {
					return "correction";
				}
				&[]
			}
		};
		if keys.iter().any(|k| c.iter().any(|x| x == k)) {
			return "correction";
		}
	}
	let has = |t: &str| tags.iter().any(|x| x == t);
	if if field == "xp" { tags.iter().any(|t| t.starts_with("recorder:xp")) } else { has("recorder") } {
		return "recorder";
	}
	if field == "xp" {
		if has("web:xp") || tags.iter().any(|t| t.starts_with("webdb:xp")) {
			return "page";
		}
		if has("webcache:xp") {
			return "web";
		}
	}
	if (field == "title" && has("web:title")) || (field == "level" && has("web:level")) || (field == "min_level" && has("web:minLevel")) {
		return "page";
	}
	if tags.iter().any(|t| t.starts_with("page:") && &t[5..] == field) {
		return "page";
	}
	if has("questie-forever") {
		"questie"
	} else {
		"pfquest"
	}
}

fn project_npc_source(n: &V, field: &str, corr: &Corr) -> &'static str {
	if let Some(c) = corr.npc.get(&(n.get("id").num() as i64)) {
		let k = match field {
			"npc_level" => "level",
			"subname" => "subName",
			f => f,
		};
		if c.iter().any(|x| x == k) {
			return "correction";
		}
	}
	let tags = src_tags(n);
	if tags.iter().any(|t| t == "recorder") {
		return "recorder";
	}
	if tags.iter().any(|t| t == "questie-forever") {
		"questie"
	} else {
		"pfquest"
	}
}

fn project_object_source(o: &V, field: &str, corr: &Corr) -> &'static str {
	if let Some(c) = corr.object.get(&(o.get("id").num() as i64)) {
		if c.iter().any(|x| x == field) {
			return "correction";
		}
	}
	if src_tags(o).iter().any(|t| t == "questie-forever") {
		"questie"
	} else {
		"pfquest"
	}
}

// ---- frames ----
#[derive(Clone)]
struct W {
	map: String,
	c: f64,
	wx: f64,
	wy: f64,
}

struct Frames<'a> {
	era: &'a V,
	fv: &'a V,
	live: &'a FxHashSet<i64>,
}

impl Frames<'_> {
	fn frame(&self, map: &str, f: &str) -> Option<V> {
		let fv = self.fv.get(map);
		if f == "l" && fv.truthy() {
			return Some(fv);
		}
		let e = self.era.get(map);
		if e.truthy() {
			return Some(e);
		}
		fv.truthy().then_some(fv)
	}
	fn to_world(&self, map: &str, x: f64, y: f64, f: &str) -> Option<(f64, f64, f64)> {
		let b = self.frame(map, f)?;
		let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
		Some((b.get("c").num(), top + ((bottom - top) * y) / 100.0, left + ((right - left) * x) / 100.0))
	}
	fn our_world(&self, rec: &V) -> Vec<W> {
		let mut out = Vec::new();
		for (m, sp) in rec.get("spawns").entries() {
			let f = if sp.get("f").as_str() == Some("l") && self.live.contains(&(forge_guide::js::str_to_num(&m) as i64)) { "l" } else { "e" };
			for p in sp.get("pts").items().into_iter().chain(sp.get("more").items()) {
				if let Some((c, wx, wy)) = self.to_world(&m, p.num_at(0), p.num_at(1), f) {
					out.push(W { map: m.to_string(), c, wx, wy });
				}
			}
		}
		out
	}
	fn fact_world(&self, v: &str, f: &str) -> Vec<W> {
		v.split(' ')
			.filter(|t| !t.is_empty())
			.filter_map(|t| {
				let (m, xy) = t.split_once(':').map(|(a, b)| (a, b.split(':').next().unwrap_or(""))).unwrap_or((t, ""));
				let mut it = xy.split(',').map(forge_guide::js::str_to_num);
				let (x, y) = (it.next().unwrap_or(f64::NAN), it.next().unwrap_or(f64::NAN));
				self.to_world(m, x, y, f).map(|(c, wx, wy)| W { map: m.to_string(), c, wx, wy })
			})
			.collect()
	}
	fn fact_worlds(&self, v: &str) -> Vec<Vec<W>> {
		let has_live = v.split(' ').any(|t| self.live.contains(&(forge_guide::js::str_to_num(t.split(':').next().unwrap_or("")) as i64)) && !t.split(':').next().unwrap_or("").is_empty());
		if has_live {
			vec![self.fact_world(v, "e"), self.fact_world(v, "l")]
		} else {
			vec![self.fact_world(v, "e")]
		}
	}
}

fn set_distance(a: &[W], b: &[W]) -> Option<f64> {
	let maps: FxHashSet<&str> = a.iter().map(|p| p.map.as_str()).filter(|m| b.iter().any(|q| q.map == *m)).collect();
	if maps.is_empty() {
		return None;
	}
	let aa: Vec<&W> = a.iter().filter(|p| maps.contains(p.map.as_str())).collect();
	let bb: Vec<&W> = b.iter().filter(|p| maps.contains(p.map.as_str())).collect();
	let (s, l) = if aa.len() <= bb.len() { (aa, bb) } else { (bb, aa) };
	let mut worst = 0f64;
	for p in s {
		let mut best = f64::INFINITY;
		for q in &l {
			if q.c == p.c {
				best = best.min(hypot(q.wx - p.wx, q.wy - p.wy));
			}
		}
		worst = worst.max(best);
	}
	worst.is_finite().then(|| math_round(worst))
}

// ---- the alternative sources ----
#[derive(Clone)]
struct Fact {
	field: String,
	source: String,
	value: V,
	note: Option<String>,
}

struct Alt {
	facts: FxHashMap<String, Vec<Fact>>,
	versions: IndexMap<String, Option<String>>,
}

fn read_facts(file: &Path) -> Result<Option<Alt>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let db = rusqlite::Connection::open_with_flags(file, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|e| format!("{}: {e}", file.display()))?;
	let mut facts: FxHashMap<String, Vec<Fact>> = FxHashMap::default();
	let mut st = db.prepare("select kind, id, field, source, value, note from facts where source != 'project' and kind in ('quest', 'npc', 'object')").map_err(|e| e.to_string())?;
	let mut rows = st.query([]).map_err(|e| e.to_string())?;
	let txt = |v: rusqlite::types::Value| -> V {
		match v {
			rusqlite::types::Value::Text(t) => V::str(&t),
			rusqlite::types::Value::Integer(i) => V::Num(i as f64),
			rusqlite::types::Value::Real(r) => V::Num(r),
			_ => V::Null,
		}
	};
	while let Some(r) = rows.next().map_err(|e| e.to_string())? {
		let kind: String = r.get(0).map_err(|e| e.to_string())?;
		let id = txt(r.get(1).map_err(|e| e.to_string())?);
		let field: String = r.get(2).map_err(|e| e.to_string())?;
		let source: String = r.get(3).map_err(|e| e.to_string())?;
		let value = txt(r.get(4).map_err(|e| e.to_string())?);
		let note: Option<String> = r.get(5).ok();
		let k = format!("{kind}:{}", id.to_js_string());
		let field = if kind == "npc" && field == "level" { "npc_level".to_string() } else { field };
		facts.entry(k).or_default().push(Fact { field, source, value, note });
	}
	drop(rows);
	drop(st);
	let mut versions = IndexMap::new();
	let mut st = db.prepare("select name, version from sources").map_err(|e| e.to_string())?;
	let rows = st
		.query_map([], |r| {
			let n: String = r.get(0)?;
			let v: rusqlite::types::Value = r.get(1)?;
			Ok((n, v))
		})
		.map_err(|e| e.to_string())?;
	for r in rows {
		let (n, v) = r.map_err(|e| e.to_string())?;
		let s = match v {
			rusqlite::types::Value::Null => None,
			rusqlite::types::Value::Text(t) => Some(t),
			rusqlite::types::Value::Integer(i) => Some(i.to_string()),
			rusqlite::types::Value::Real(r) => Some(num_str(r)),
			rusqlite::types::Value::Blob(_) => Some(String::new()),
		};
		versions.insert(n, s);
	}
	Ok(Some(Alt { facts, versions }))
}

const ALL_RACES: &str = "18446744073709551615";

fn ends_pairs(e: &[(String, f64)]) -> Vec<(String, f64)> {
	e.to_vec()
}

fn push_fact(out: &mut Alt, key: String, field: &str, source: &str, value: Option<String>, note: Option<String>) {
	let Some(v) = value.filter(|v| !v.is_empty()) else { return };
	out.facts.entry(key).or_default().push(Fact { field: field.into(), source: source.into(), value: V::str(&v), note });
}

/// A players' (or the client's own) cache of the server's quest answers as `source` facts.
fn add_cache_quests(out: &mut Alt, recs: &IndexMap<i64, EgQuest>, titles: Option<&FxHashMap<i64, String>>, source: &str, quests: &Obj) {
	let add = |out: &mut Alt, id: i64, field: &str, source: &str, value: Option<String>, note: Option<String>| push_fact(out, format!("quest:{id}"), field, source, value, note);
	let o = |x: Option<f64>| x.map(num_str).unwrap_or_else(|| "null".into());
	for (&id, r) in recs {
		let q = quests.get(&id.to_string());
		if q.is_undef() || r.build.is_none() {
			continue;
		}
		if let Some(t) = titles.and_then(|t| t.get(&id)) {
			add(out, id, "title", source, Some(t.clone()), None);
		}
		if r.level.is_some_and(|l| l > 0.0) {
			add(out, id, "level", source, r.level.map(num_str), None);
		}
		if r.min_level.is_some_and(|l| l > 0.0) {
			add(out, id, "min_level", source, r.min_level.map(num_str), None);
		}
		if r.xp.is_some_and(|l| l > 0.0) {
			add(out, id, "xp", source, r.xp.map(num_str), Some(format!("difficulty {} x {}", o(r.xp_difficulty), o(r.xp_multiplier))));
		}
		if r.xp_observed.is_some_and(|l| l > 0.0) {
			add(out, id, "xp", &format!("{source}.observed"), r.xp_observed.map(num_str), Some("observed turn-in".into()));
		}
		if !r.start.is_empty() {
			add(out, id, "start", source, Some(ents(&ends_pairs(&r.start))), None);
		}
		if !r.end.is_empty() {
			add(out, id, "end", source, Some(ents(&ends_pairs(&r.end))), None);
		}
		let list: Vec<(String, V, V)> = r
			.objectives
			.iter()
			.filter(|(k, oid, _)| !(k == "item" && oid.is_some() && *oid == r.start_item))
			.map(|(k, i, c)| (k.clone(), i.map(V::Num).unwrap_or(V::Null), c.map(V::Num).unwrap_or(V::Null)))
			.collect();
		if !list.is_empty() {
			add(out, id, "objectives", source, Some(objs(&list)), None);
		}
		// The list as EG gives it, the starting item kept (a check-only source: others list it).
		if source == "eg" && list.len() != r.objectives.len() {
			let full: Vec<(String, V, V)> = r.objectives.iter().map(|(k, i, c)| (k.clone(), i.map(V::Num).unwrap_or(V::Null), c.map(V::Num).unwrap_or(V::Null))).collect();
			add(out, id, "objectives", "eg.objectives", Some(objs(&full)), None);
		}
		if let Some(races) = r.races.as_ref().filter(|r| !r.is_empty() && r.as_str() != ALL_RACES && r.as_str() != "0") {
			let nr = norm_races(&V::str(races), &q.get("classes"));
			add(out, id, "races", source, Some(nr.clone()), Some(format!("raw {races}")));
			add(out, id, "side", source, Some(side_of_races(&nr)), None);
		}
	}
}

fn add_extra_facts(alt: Option<Alt>, eg: Option<&Eg>, vo: Option<&Vo>, cache: Option<&crate::client::Cache>, quests: &Obj) -> Alt {
	let mut out = alt.unwrap_or(Alt { facts: FxHashMap::default(), versions: IndexMap::new() });
	let add = |out: &mut Alt, id: i64, field: &str, source: &str, value: Option<String>, note: Option<String>| push_fact(out, format!("quest:{id}"), field, source, value, note);
	if let Some(eg) = eg {
		out.versions.insert("eg".into(), Some(eg.commit[..12].to_string()));
		out.versions.insert("eg.observed".into(), Some(eg.commit[..12].to_string()));
		add_cache_quests(&mut out, &eg.quests, None, "eg", quests);
	}
	if let Some(c) = cache {
		out.versions.insert("client.cache".into(), Some(c.build.clone()));
		add_cache_quests(&mut out, &c.quests, Some(&c.titles), "client.cache", quests);
		for (&id, n) in &c.npcs {
			let key = format!("npc:{id}");
			push_fact(&mut out, key.clone(), "name", "client.cache", Some(n.name.clone()), None);
			push_fact(&mut out, key.clone(), "subname", "client.cache", Some(n.subname.clone()), None);
			push_fact(&mut out, key, "rank", "client.cache", Some(n.rank.to_string()), None);
		}
		for (&id, name) in &c.objects {
			push_fact(&mut out, format!("object:{id}"), "name", "client.cache", Some(name.clone()), None);
		}
	}
	if let Some(vo) = vo {
		out.versions.insert("forevervo.seen".into(), Some(vo.commit[..12].to_string()));
		for (&id, (s, e)) in &vo.quests {
			if quests.get(&id.to_string()).is_undef() {
				continue;
			}
			if !s.is_empty() {
				add(&mut out, id, "start", "forevervo.seen", Some(ents(s)), None);
			}
			if !e.is_empty() {
				add(&mut out, id, "end", "forevervo.seen", Some(ents(e)), None);
			}
		}
	}
	out
}

/// World coordinates (x north, y west) as a frame's percent, 2 decimals.
fn frame_pct(b: &V, wx: f64, wy: f64) -> (f64, f64) {
	let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
	(crate::jsv::round2((wy - left) / (right - left) * 100.0), crate::jsv::round2((wx - top) / (bottom - top) * 100.0))
}

/// The Forever frame (uiMap) of a point on continent `c`: `prefer` when it holds the point, else
/// the smallest frame holding it (the lower uiMap on a tie). -> (uiMap, x, y).
fn frame_of(fv: &V, c: i64, wx: f64, wy: f64, prefer: Option<&str>) -> Option<(String, f64, f64)> {
	let inside = |b: &V| {
		let (x, y) = frame_pct(b, wx, wy);
		(b.get("c").num() == c as f64 && (0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)).then_some((x, y))
	};
	if let Some(p) = prefer {
		if let Some((x, y)) = inside(&fv.get(p)) {
			return Some((p.to_string(), x, y));
		}
	}
	let mut best: Option<(f64, String, f64, f64)> = None;
	for (m, b) in fv.entries() {
		let Some((x, y)) = inside(&b) else { continue };
		let size = ((b.get("right").num() - b.get("left").num()) * (b.get("bottom").num() - b.get("top").num())).abs();
		if best.as_ref().is_none_or(|(s, _, _, _)| size < *s) {
			best = Some((size, m.to_string(), x, y));
		}
	}
	best.map(|(_, m, x, y)| (m, x, y))
}

/// Quest map areas in our Forever frames, as JSON: [{ map, f: "l", pts: [[x, y], ...] }]
/// (areas on a uiMap without a frame dropped).
fn areas_value(fv: &V, areas: &[crate::client::Area]) -> Option<String> {
	let list: Vec<V> = areas
		.iter()
		.filter_map(|a| {
			let b = fv.get(&a.ui_map.to_string());
			if !b.truthy() {
				return None;
			}
			let o = Obj::new();
			o.set("map", a.ui_map as f64);
			o.set("f", "l");
			o.set(
				"pts",
				arr(a
					.pts
					.iter()
					.map(|&(wx, wy)| {
						let (x, y) = frame_pct(&b, wx, wy);
						arr(vec![V::Num(x), V::Num(y)])
					})
					.collect()),
			);
			Some(V::Obj(o))
		})
		.collect();
	(!list.is_empty()).then(|| stringify(&arr(list), None))
}

/// The `client` facts of the client's tables for the quests, items and objects we have.
fn add_client_facts(out: &mut Alt, t: &crate::client::Tables, fv: &V, quests: &Obj, items: &Obj, objects: &Obj) {
	out.versions.insert("client".into(), t.build.clone());
	let src = "client";
	for (&id, p) in &t.places {
		if quests.get(&id.to_string()).is_undef() {
			continue;
		}
		let key = format!("quest:{id}");
		push_fact(out, key.clone(), "start_place", src, areas_value(fv, &p.start), None);
		push_fact(out, key.clone(), "end_place", src, areas_value(fv, &p.end), None);
		for (n, a) in &p.objectives {
			push_fact(out, key.clone(), &format!("objective_place:{n}"), src, areas_value(fv, a), None);
		}
	}
	for q in quests.values() {
		let id = q.get("id").num() as i64;
		let key = format!("quest:{id}");
		if t.quests.contains(&id) {
			push_fact(out, key.clone(), "in_client", src, Some("yes".into()), Some("QuestV2".into()));
		}
		for (i, o) in q.get("objectives").items().iter().enumerate() {
			if o.get("type").as_str() != Some("event") || !o.get("id").truthy() {
				continue;
			}
			let tid = o.get("id").num() as i64;
			let Some(tr) = t.triggers.get(&tid) else { continue };
			let prefer = o.get("map");
			let prefer = prefer.truthy().then(|| prefer.to_js_string());
			let Some((m, x, y)) = frame_of(fv, tr.map, tr.x, tr.y, prefer.as_deref()) else { continue };
			let v = Obj::new();
			v.set("trigger", tid as f64);
			v.set("map", forge_guide::js::str_to_num(&m));
			v.set("f", "l");
			v.set("x", x);
			v.set("y", y);
			match tr.box_size {
				Some((l, w)) => v.set("box", arr(vec![V::Num(l), V::Num(w)])),
				None => v.set("radius", tr.radius),
			}
			push_fact(out, key.clone(), &format!("objective_trigger:{i}"), src, Some(stringify(&V::Obj(v), None)), None);
		}
	}
	for (&id, it) in &t.items {
		if items.get(&id.to_string()).is_undef() {
			continue;
		}
		let key = format!("item:{id}");
		push_fact(out, key.clone(), "name", src, Some(it.name.clone()), None);
		push_fact(out, key.clone(), "duration", src, it.duration.map(num_str), None);
		push_fact(out, key.clone(), "quest_item", src, it.quest_item.map(|q| if q { "yes" } else { "no" }.to_string()), None);
		push_fact(out, key, "start_quest", src, it.start_quest.map(|q| q.to_string()), None);
	}
	for (&id, list) in &t.objects {
		if objects.get(&id.to_string()).is_undef() {
			continue;
		}
		let pts: Vec<String> = list.iter().filter_map(|&(c, wx, wy)| frame_of(fv, c, wx, wy, None)).map(|(m, x, y)| format!("{m}:{},{}", num_str(x), num_str(y))).collect();
		if !pts.is_empty() {
			push_fact(out, format!("object:{id}"), "placement", src, Some(pts.join(" ")), None);
		}
	}
}

/// A classic race mask in Forever's terms: a whole classic side (all four races) also has that
/// side's Skyborne race.
fn forever_mask(classic: f64) -> String {
	let mut m = (classic.max(0.0) as u64) & 0xff;
	if m & 77 == 77 {
		m |= 1 << 32;
	}
	if m & 178 == 178 {
		m |= 1 << 33;
	}
	m.to_string()
}

/// The check-only sources (CHECK_ONLY) and the Factoruide split, added to the fact check's facts:
/// - `tdb.inherited`: the Forever TDB's quest rows that were not sniffed (level, minimum level,
///   races and side, objectives); the sniffed ones come in as `tdb` through the fact check;
/// - `cmangos`: CMaNGOS classic-db's quest_template, quest relations and creature_template
///   (cmangos.rs quest_facts.json);
/// - `factoruide.web`: Factoruide facts whose own row lists the web quest-database pages among its sources
///   (Factoruide's sqlite: m_npc, m_quest, m_quest_relation, m_quest_objective `sources`).
fn add_check_facts(out: &mut Alt, tdb: Option<&V>, classic: Option<&V>, factoruide: Option<&Path>, quests: &Obj, npcs: &Obj) -> Result<(), String> {
	let add = |out: &mut Alt, key: String, field: &str, source: &str, value: String| {
		if !value.is_empty() {
			out.facts.entry(key).or_default().push(Fact { field: field.into(), source: source.into(), value: V::str(&value), note: None });
		}
	};
	let pos = |x: f64| (x > 0.0).then(|| num_str(x));
	if let Some(tdb) = tdb {
		for (qid, tq) in tdb.get("quests").entries() {
			let q = quests.get(&qid);
			if !q.truthy() || tq.get("sniffed").truthy() {
				continue;
			}
			let key = format!("quest:{qid}");
			for (field, col) in [("level", "level"), ("min_level", "minLevel")] {
				if let Some(v) = pos(tq.get(col).num()) {
					add(out, key.clone(), field, "tdb.inherited", v);
				}
			}
			let races = tq.get("races");
			if races.truthy() && races.to_js_string() != ALL_RACES && races.to_js_string() != "0" {
				let nr = norm_races(&races, &q.get("classes"));
				add(out, key.clone(), "side", "tdb.inherited", side_of_races(&nr));
				add(out, key.clone(), "races", "tdb.inherited", nr);
			}
			let list: Vec<(String, V, V)> = tq
				.get("obj")
				.items()
				.iter()
				.filter_map(|o| {
					let k = match o.num_at(0) as i64 {
						0 | 3 => "kill",
						1 => "item",
						2 => "object",
						_ => return None,
					};
					Some((k.to_string(), V::Num(o.num_at(1)), V::Num(o.num_at(2))))
				})
				.collect();
			if !list.is_empty() {
				add(out, key, "objectives", "tdb.inherited", objs(&list));
			}
		}
	}
	if let Some(cm) = classic {
		for (qid, cq) in cm.get("quest").entries() {
			let q = quests.get(&qid);
			if !q.truthy() {
				continue;
			}
			let key = format!("quest:{qid}");
			add(out, key.clone(), "title", "cmangos", cq.get("title").to_js_string());
			for (field, col) in [("level", "level"), ("min_level", "minLevel")] {
				if let Some(v) = pos(cq.get(col).num()) {
					add(out, key.clone(), field, "cmangos", v);
				}
			}
			let classes = cq.get("classes");
			let nr = norm_races(&V::str(&forever_mask(cq.get("races").num())), &classes);
			let nr = if cq.get("races").num() == 0.0 { "any".to_string() } else { nr };
			add(out, key.clone(), "side", "cmangos", side_of_races(&nr));
			add(out, key.clone(), "races", "cmangos", nr);
			add(out, key.clone(), "classes", "cmangos", norm_classes(&classes));
			let list: Vec<(String, V, V)> = cq
				.get("obj")
				.items()
				.iter()
				.map(|o| {
					let k = match o.at(0).as_str() {
						Some("c") => "kill",
						Some("o") => "object",
						_ => "item",
					};
					(k.to_string(), V::Num(o.num_at(1)), V::Num(o.num_at(2)))
				})
				.collect();
			add(out, key.clone(), "objectives", "cmangos", objs(&list));
			for (field, kinds) in [("start", &["npc", "object", "item"][..]), ("end", &["npc", "object"][..])] {
				let pairs: Vec<(String, f64)> = cq
					.get(field)
					.items()
					.iter()
					.filter_map(|e| {
						let t = e.to_js_string();
						let (k, i) = t.split_once(':')?;
						kinds.contains(&k).then(|| (k.to_string(), forge_guide::js::str_to_num(i)))
					})
					.collect();
				add(out, key.clone(), field, "cmangos", if pairs.is_empty() { "none".into() } else { ents(&pairs) });
			}
		}
		for (nid, row) in cm.get("npc").entries() {
			if !npcs.get(&nid).truthy() {
				continue;
			}
			let key = format!("npc:{nid}");
			add(out, key.clone(), "name", "cmangos", row.at(0).to_js_string());
			add(out, key.clone(), "subname", "cmangos", row.at(1).to_js_string());
			let (lo, hi) = (row.num_at(2), row.num_at(3));
			if lo > 0.0 {
				add(out, key, "npc_level", "cmangos", if hi > lo { format!("{}-{}", num_str(lo), num_str(hi)) } else { num_str(lo) });
			}
		}
	}
	if let Some(file) = factoruide.filter(|f| f.exists()) {
		let db = rusqlite::Connection::open_with_flags(file, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|e| format!("{}: {e}", file.display()))?;
		// The web quest-database's tag in Factoruide's `sources` (and its series variant).
		let tag = concat!("wow", "head");
		let site = |s: &str| s.split(',').any(|x| x.trim().starts_with(tag));
		let read = |sql: &str| -> Result<FxHashMap<String, bool>, String> {
			let mut m: FxHashMap<String, bool> = FxHashMap::default();
			let mut st = db.prepare(sql).map_err(|e| format!("factoruide: {e}"))?;
			let rows = st.query_map([], |r| Ok((r.get::<_, rusqlite::types::Value>(0)?, r.get::<_, Option<String>>(1)?))).map_err(|e| e.to_string())?;
			for r in rows {
				let (k, s) = r.map_err(|e| e.to_string())?;
				let k = match k {
					rusqlite::types::Value::Integer(i) => i.to_string(),
					rusqlite::types::Value::Text(t) => t,
					_ => continue,
				};
				let e = m.entry(k).or_insert(false);
				*e |= s.as_deref().is_some_and(site);
			}
			Ok(m)
		};
		let npc = read("select id, sources from m_npc")?;
		let quest = read("select id, sources from m_quest")?;
		let start = read("select quest_id, sources from m_quest_relation where lower(role) = 'start'")?;
		let end = read("select quest_id, sources from m_quest_relation where lower(role) = 'end'")?;
		let objective = read("select quest_id, source from m_quest_objective")?;
		for (key, list) in out.facts.iter_mut() {
			let (kind, id) = key.split_once(':').unwrap_or(("", ""));
			// `status` (Factoruide's removed quests) stays Factoruide's own verdict.
			for f in list.iter_mut().filter(|f| f.source == "factoruide" && f.field != "status") {
				let from_site = match (kind, f.field.as_str()) {
					("npc", _) => npc.get(id).copied(),
					("quest", "start") => start.get(id).copied(),
					("quest", "end") => end.get(id).copied(),
					("quest", "objectives") => objective.get(id).copied().or_else(|| quest.get(id).copied()),
					("quest", _) => quest.get(id).copied(),
					_ => None,
				};
				if from_site == Some(true) {
					f.source = "factoruide.web".into();
				}
			}
		}
		let v = out.versions.get("factoruide").cloned().flatten();
		out.versions.insert("factoruide.web".into(), v);
	}
	Ok(())
}

// ---- the KB build ----
#[derive(Clone)]
struct Cand {
	source: String,
	value: V,
	note: Option<String>,
	project: bool,
}

struct Decision {
	win: Cand,
	win_ix: usize,
	valid: Vec<Cand>,
}

pub struct KbInputs<'a> {
	pub quests: &'a Obj,
	pub npcs: &'a Obj,
	pub objects: &'a Obj,
	pub items: &'a Obj,
	/// { era, forever? } frames.
	pub frames: V,
	pub zones: &'a Obj,
	pub live: FxHashSet<i64>,
	pub corrections: V,
	/// The fact check's local database (a local-only source); None: none.
	pub facts_file: Option<PathBuf>,
	pub tdb: Option<V>,
	/// CMaNGOS classic-db's quest and creature facts (cmangos.rs quest_facts.json): check-only.
	pub classic: Option<V>,
	/// Factoruide's sqlite, to tell its rows from web sources (`factoruide.web`).
	pub factoruide_file: Option<PathBuf>,
	pub quest_xp: Option<QuestXp>,
	/// { npc, object } spawn heights (mutated: the TDB's sniffed spawns).
	pub spawnz: Option<(V, V)>,
	pub training: Option<V>,
	pub trainers: Option<V>,
	pub mechanics: MechFiles,
	pub v2_quests: FxHashSet<i64>,
	pub eg: Option<Eg>,
	pub vo: Option<Vo>,
	/// The installed client: its caches (`client.cache`) and tables (`client`).
	pub client: Option<crate::client::Client>,
	pub kb_file: Option<PathBuf>,
	pub verify_file: Option<PathBuf>,
}

pub struct MechFiles {
	pub quest_mechanics: PathBuf,
	pub quest_steps: PathBuf,
	pub tdb_layer: PathBuf,
	pub web: PathBuf,
	/// The committed, editable layer (data/mechanics-public.json): its `quests` merged over the private
	/// layers by the same rules. The corrections' `mechanics` (forever-db/corrections/mechanics.json and
	/// the private overlay's; hand-checked, always driving) go over everything.
	pub public: PathBuf,
	/// The readings' evidence (data/local/mechanics/evidence/<quest>.json): where each step's and
	/// gotcha's quotes come from, kept with the step as its `evidence` (the public pack ships no step
	/// that quotes the web quest-database pages' text or comments).
	pub evidence: PathBuf,
}

/// A quote's origin class: `comment` (a page comment), else the page section or `data` as the
/// evidence file names it.
fn evidence_class(from: &str) -> String {
	match from.split_once(':') {
		Some((k, _)) => k.to_string(),
		None => from.to_string(),
	}
}

/// One quest's evidence: step n -> origin classes, gotcha fact -> origin classes.
fn read_evidence(dir: &Path, quest: &str) -> (FxHashMap<String, Vec<String>>, FxHashMap<String, Vec<String>>) {
	let (mut steps, mut gotchas) = (FxHashMap::default(), FxHashMap::default());
	let Ok(text) = std::fs::read_to_string(dir.join(format!("{quest}.json"))) else { return (steps, gotchas) };
	let Ok(d) = parse_json(&text) else { return (steps, gotchas) };
	let classes = |e: &V| -> Vec<String> {
		let mut c: Vec<String> = e.get("evidence").items().iter().map(|x| evidence_class(&x.get("from").to_js_string())).collect();
		c.sort();
		c.dedup();
		c
	};
	for st in d.get("reading").get("steps").items() {
		steps.insert(st.get("n").to_js_string(), classes(&st));
	}
	for g in d.get("reading").get("gotchas").items() {
		gotchas.insert(g.get("fact").to_js_string(), classes(&g));
	}
	(steps, gotchas)
}

pub struct Change {
	table: &'static str,
	id: f64,
	field: String,
	from: V,
	to: V,
	source: String,
}

/// The credits of the sources whose facts the knowledge base wrote into data/forever (meta.json's
/// sources, and so every LICENSE-DATA.txt written from it): EG Link (CC BY 4.0, with its attribution),
/// forever-vo and Factoruide, each only when one of its facts won.
fn kb_credits(used: &dyn Fn(&str) -> bool, eg: bool, vo: bool, factoruide: bool) -> Vec<V> {
	let mut credits = Vec::new();
	if eg && (used("eg") || used("eg.observed")) {
		let o = Obj::new();
		o.set("name", crate::players::EG_NAME);
		o.set("url", crate::players::EG_URL);
		o.set("revision", crate::players::EG_COMMIT);
		o.set("license", "CC BY 4.0; facts used: quest levels, XP, objectives and counts, next quests, givers and enders, races, quest-tied drop rates");
		o.set("copyright", crate::players::EG_CREDIT);
		credits.push(V::Obj(o));
	}
	if vo && used("forevervo.seen") {
		let o = Obj::new();
		o.set("name", crate::players::VO_NAME);
		o.set("url", crate::players::VO_URL);
		o.set("revision", crate::players::VO_COMMIT);
		o.set("license", format!("{}; quest givers and enders captured in game, used as facts", crate::players::VO_LICENSE));
		o.set("copyright", "forever-vo contributors");
		credits.push(V::Obj(o));
	}
	if factoruide && used("factoruide") {
		let o = Obj::new();
		o.set("name", "Factoruide databases (with the VMaNGOS values they carry)");
		o.set("url", "https://github.com/Factoruide");
		o.set("revision", V::Null);
		o.set("license", "GPL-2.0-or-later, taken under GPL-3.0; facts used where the sources above lack them");
		o.set("copyright", "Factoruide contributors");
		credits.push(V::Obj(o));
	}
	credits
}

pub struct KbOut {
	pub changes: usize,
	pub tdb_used: bool,
	pub credits: Vec<V>,
	pub mechanics: Obj,
	pub training: Option<V>,
	pub trainers: Option<V>,
	pub spawnz_changed: bool,
	/// { byClass, tdb, eg, mechanics } for meta.json.
	pub report: Obj,
	pub spawnz: Option<(V, V)>,
}

type Row = Vec<V>;

struct Kb<'a> {
	inp: &'a KbInputs<'a>,
	changes: Vec<Change>,
	verify_xp: FxHashMap<String, f64>,
	fact_rows: Vec<Row>,
	alt_rows: Vec<Row>,
	verify: IndexMap<String, (String, f64, V, Vec<V>)>,
	pos: [usize; 3],
}

fn conflict(field: &str, ours: V, others: Vec<(String, String)>, applied: Option<bool>) -> V {
	let o = Obj::new();
	o.set("field", field);
	o.set("ours", ours);
	o.set(
		"others",
		arr(others
			.into_iter()
			.map(|(s, v)| {
				let x = Obj::new();
				x.set("source", s.as_str());
				x.set("value", v.as_str());
				V::Obj(x)
			})
			.collect()),
	);
	if let Some(a) = applied {
		o.set("applied", a);
	}
	V::Obj(o)
}

impl Kb<'_> {
	fn change(&mut self, table: &'static str, id: f64, field: &str, from: V, to: V, source: &str) {
		self.changes.push(Change { table, id, field: field.into(), from, to, source: source.into() });
	}
	fn verify_add(&mut self, kind: &str, id: f64, name: V, c: V) {
		let k = format!("{kind}:{}", num_str(id));
		self.verify.entry(k).or_insert_with(|| (kind.to_string(), id, name, Vec::new())).3.push(c);
	}
	fn tdb_xp(&self, id: &str) -> Option<f64> {
		let tdb = self.inp.tdb.as_ref()?;
		let tq = tdb.get("quests").get(id);
		if !tq.truthy() {
			return None;
		}
		let level = if tq.get("level").truthy() { tq.get("level") } else { self.inp.quests.get(id).get("level") };
		let d = tq.get("xpDifficulty");
		if !d.truthy() {
			return None;
		}
		let qx = self.inp.quest_xp.as_ref()?;
		let l = level.num();
		if !(l.is_finite() && l.fract() == 0.0 && l >= 0.0) {
			return None;
		}
		let row = qx.get(l as usize).copied().flatten()?;
		let di = d.num();
		if !(di.fract() == 0.0 && di >= 0.0) {
			return None;
		}
		let base = *row.get(di as usize)?;
		let m = tq.get("xpMultiplier");
		Some(round_quest_xp(base * if m.is_nullish() { 1.0 } else { m.num() }))
	}

	fn eq(field: &str, a: &Cand, b: &Cand) -> bool {
		if field == "xp" {
			same_xp(&a.value, &b.value, captured(&a.source), captured(&b.source))
		} else {
			same(field, &a.value, &b.value)
		}
	}

	fn decide(&mut self, kind: &str, id: f64, field: &str, cands: &[Cand]) -> Option<Decision> {
		let valid: Vec<Cand> = cands.iter().filter(|c| usable(field, &c.value)).cloned().collect();
		if valid.is_empty() {
			return None;
		}
		// valid[i] is cands[map[i]] (identity).
		let cand_ix: Vec<usize> = cands.iter().enumerate().filter(|(_, c)| usable(field, &c.value)).map(|(i, _)| i).collect();
		let mut ranked: Vec<usize> = (0..valid.len()).filter(|&i| !check_only(&valid[i].source)).collect();
		if ranked.is_empty() {
			// Only check-only values: kept as alternatives, no fact.
			for c in &valid {
				self.alt_rows.push(vec![V::str(kind), V::Num(id), V::str(field), V::str(&c.source), V::str(&c.value.to_js_string()), V::Num(0.0)]);
			}
			return None;
		}
		ranked.sort_by(|&a, &b| tier_of(&valid[a].source, field).partial_cmp(&tier_of(&valid[b].source, field)).unwrap());
		let mut win = ranked[0];
		if field == "xp" && cands[0].project && cands[0].value.num() > 0.0 {
			let server = if kind == "quest" { self.tdb_xp(&num_str(id)) } else { None };
			let backs = |v: &V| server.is_some_and(|s| same_xp(&V::Num(s), v, true, false));
			let ours = cands[0].value.num();
			let lone = |i: usize| {
				let c = &valid[i];
				(c.source == "page" || c.source == "factoruide" || c.source == "factoruide.web")
					&& c.value.num() < 0.97 * ours
					&& !valid.iter().enumerate().any(|(j, o)| {
						j != i
							&& !o.project && o.source != "page"
							&& o.source != "factoruide"
							&& o.source != "factoruide.web"
							&& !check_only(&o.source)
							&& same_xp(&o.value, &c.value, captured(&o.source), false)
					}) && !backs(&c.value)
					&& (server.is_none() || backs(&cands[0].value))
			};
			let kept = ranked.iter().copied().find(|&i| !lone(i)).unwrap_or(win);
			if let Some(s) = server {
				if !backs(&valid[kept].value) && !backs(&cands[0].value) && valid[kept].value.num() < 0.97 * ours {
					self.verify_xp.insert(num_str(id), s);
				}
			}
			win = kept;
		}
		if verify_field(field) && !decides_verify(field, tier_of(&valid[win].source, field)) {
			if let Some(i) = cand_ix.iter().position(|&ci| ci == 0) {
				win = i;
			}
		}
		let w = valid[win].clone();
		let agree = valid.iter().enumerate().filter(|(i, c)| *i != win && !check_only(&c.source) && Self::eq(field, c, &w)).count();
		let t = tier_of(&w.source, field);
		let confidence = if t <= 1.0 || agree >= 1 {
			"high"
		} else if t <= 4.0 {
			"medium"
		} else {
			"low"
		};
		self.fact_rows.push(vec![
			V::str(kind),
			V::Num(id),
			V::str(field),
			V::str(&w.value.to_js_string()),
			V::str(&w.source),
			V::str(confidence),
			V::Num((agree + 1) as f64),
			V::Num(valid.iter().filter(|c| !check_only(&c.source)).count() as f64),
		]);
		for (i, c) in valid.iter().enumerate() {
			if i != win {
				self.alt_rows.push(vec![V::str(kind), V::Num(id), V::str(field), V::str(&c.source), V::str(&c.value.to_js_string()), V::Num(if Self::eq(field, c, &w) { 1.0 } else { 0.0 })]);
			}
		}
		Some(Decision { win: w, win_ix: win, valid })
	}
}

fn tag(rec: &V, t: &str) {
	if !rec.get("source").is_arr() {
		rec.set("source", V::arr());
	}
	let s = rec.get("source");
	if !s.items().iter().any(|x| x.as_str() == Some(t)) {
		s.push(t);
	}
}

fn has_spawn(t: &Obj, id: &str) -> bool {
	let e = t.get(id);
	e.truthy() && !e.get("spawns").keys().is_empty()
}

fn sorted_keys(o: &Obj) -> Obj {
	let mut ks: Vec<(f64, forge_guide::js::Str)> = o.keys().into_iter().map(|k| (forge_guide::js::str_to_num(&k), k)).collect();
	ks.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
	let out = Obj::new();
	for (n, k) in ks {
		out.set(&num_str(n), o.get(&k));
	}
	out
}

const MISPLACED_YD: f64 = 300.0;
const MISSING_YD: f64 = 40.0;
const PRIOR_WEIGHT: f64 = 2.0;
const NPC_PRIOR_QUEST: f64 = 60.0;
const NPC_PRIOR_OTHER: f64 = 30.0;
const OBJECT_PRIOR: f64 = 100.0;

fn or_arr(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::arr()
	}
}

fn or_obj(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::obj()
	}
}

fn s(v: &str) -> V {
	V::str(v)
}

fn ents_of(v: &V, kinds: &[&str]) -> Vec<(String, f64)> {
	let mut l = Vec::new();
	for k in kinds {
		for x in v.get(k).items() {
			l.push((k.to_string(), x.num()));
		}
	}
	l
}

fn includes(a: &V, x: f64) -> bool {
	a.items().iter().any(|v| v.as_num() == Some(x))
}

/// Builds the KB over the tables (mutated) and writes it.
pub fn build_kb(inp: &KbInputs, log: &dyn Fn(&str)) -> Result<KbOut, String> {
	let (quests, npcs, objects, items) = (inp.quests, inp.npcs, inp.objects, inp.items);
	let corr = corrected_fields(&inp.corrections);
	let era = inp.frames.get("era");
	let fvv = inp.frames.get("forever");
	let ft = Frames { era: &era, fv: &fvv, live: &inp.live };
	let mut alt = add_extra_facts(
		match &inp.facts_file {
			Some(f) => read_facts(f)?,
			None => None,
		},
		inp.eg.as_ref(),
		inp.vo.as_ref(),
		inp.client.as_ref().and_then(|c| c.cache.as_ref()),
		quests,
	);
	add_check_facts(&mut alt, inp.tdb.as_ref(), inp.classic.as_ref(), inp.factoruide_file.as_deref(), quests, npcs)?;
	if let Some(t) = inp.client.as_ref().and_then(|c| c.tables.as_ref()) {
		add_client_facts(&mut alt, t, &fvv, quests, items, objects);
	}
	let alt = alt;
	let tdb = inp.tdb.as_ref();
	let mut kb = Kb { inp, changes: Vec::new(), verify_xp: FxHashMap::default(), fact_rows: Vec::new(), alt_rows: Vec::new(), verify: IndexMap::new(), pos: [0; 3] };
	let alt_of = |kind: &str, id: f64| -> Vec<Fact> { alt.facts.get(&format!("{kind}:{}", num_str(id))).cloned().unwrap_or_default() };
	let to_cand = |a: &Fact| Cand { source: a.source.clone(), value: a.value.clone(), note: a.note.clone(), project: false };
	let npc_faction = |id: f64| -> V { npcs.get(&num_str(id)).get("faction") };

	// ---- quests ----
	for q in quests.values() {
		let id = q.get("id").num();
		let a = alt_of("quest", id);
		let races = norm_races(&q.get("races"), &q.get("classes"));
		let none = |x: String| if x.is_empty() { "none".to_string() } else { x };
		let ours: Vec<(&str, V)> = vec![
			("title", q.get("title")),
			("level", q.get("level")),
			("min_level", q.get("minLevel")),
			("xp", q.get("xp")),
			("start", s(&none(ents(&ents_of(&q.get("start"), &["npc", "object", "item"]))))),
			("end", s(&none(ents(&ents_of(&q.get("end"), &["npc", "object"]))))),
			("races", s(&races)),
			("side", s(&side_of_races(&races))),
			("classes", s(&norm_classes(&q.get("classes")))),
		];
		let our = |f: &str| ours.iter().find(|(k, _)| *k == f).map(|(_, v)| v.clone()).unwrap_or(V::Undef);
		for field in ["title", "level", "min_level", "xp", "start", "end", "races", "side", "classes"] {
			let mut cands = vec![Cand { source: project_quest_source(&q, field, &corr).into(), value: our(field), note: None, project: true }];
			cands.extend(a.iter().filter(|x| x.field == field && x.source != "foreverdb.classic").map(to_cand));
			let n_main = cands.len();
			cands.extend(a.iter().filter(|x| x.field == field && x.source == "foreverdb.classic").map(to_cand));
			let d = kb.decide("quest", id, field, &cands);
			if field == "xp" {
				if let Some(&server) = kb.verify_xp.get(&num_str(id)) {
					let w = &d.as_ref().unwrap().win;
					let c = conflict("xp (server XP backs neither)", s(&our("xp").to_js_string()), vec![(w.source.clone(), w.value.to_js_string()), ("tdb".into(), num_str(server))], Some(true));
					kb.verify_add("quest", id, q.get("title"), c);
				}
			}
			let Some(d) = d else { continue };
			if d.win.project {
				if verify_field(field) {
					let others: Vec<(String, String)> = d
						.valid
						.iter()
						.enumerate()
						.filter(|(i, c)| *i != d.win_ix && !c.project && c.source != "foreverdb.classic" && c.source != "web" && !check_only(&c.source) && !Kb::eq(field, c, &d.win))
						.map(|(_, c)| (c.source.clone(), c.value.to_js_string()))
						.collect();
					if !others.is_empty() {
						kb.verify_add("quest", id, q.get("title"), conflict(field, s(&d.win.value.to_js_string()), others, None));
					}
				}
				continue;
			}
			let w = d.win.clone();
			let _ = n_main;
			if Kb::eq(field, &w, &cands[0]) {
				continue;
			}
			match field {
				"title" => {
					if tier_of(&w.source, field) > 3.0 {
						continue;
					}
					kb.change("quests", id, "title", q.get("title"), w.value.clone(), &w.source);
					q.set("title", w.value.clone());
				}
				"level" | "min_level" | "xp" => {
					let v = w.value.num();
					if !v.is_finite() {
						continue;
					}
					let key = match field {
						"level" => "level",
						"min_level" => "minLevel",
						_ => "xp",
					};
					kb.change("quests", id, key, q.get(key), V::Num(v), &w.source);
					q.set(key, v);
				}
				"start" | "end" => {
					let kinds: &[&str] = if field == "start" { &["npc", "object", "item"] } else { &["npc", "object"] };
					let win: Vec<(String, f64)> = parse_ents(&w.value).into_iter().filter(|(k, _)| k == "npc" || k == "object").collect();
					if win.is_empty() || !win.iter().all(|(k, v)| has_spawn(if k == "npc" { npcs } else { objects }, &num_str(*v))) {
						kb.verify_add(
							"quest",
							id,
							q.get("title"),
							conflict(&format!("{field} (not applied: an NPC or object without spawns)"), our(field), vec![(w.source.clone(), w.value.to_js_string())], None),
						);
						continue;
					}
					let prev = q.get(field);
					let prev_o = prev.as_obj().cloned().unwrap_or_default();
					let next = prev_o.spread();
					let observed = OBSERVED.contains(&w.source.as_str());
					for k in ["npc", "object"] {
						let theirs: Vec<f64> = win.iter().filter(|(kk, _)| kk == k).map(|(_, v)| *v).collect();
						let pk: Vec<f64> = prev.get(k).items().iter().map(V::num).collect();
						let list: Vec<f64> = if observed {
							pk.iter().copied().chain(theirs.iter().copied().filter(|v| !pk.contains(v))).collect()
						} else {
							pk.iter().copied().filter(|v| theirs.contains(v)).chain(theirs.iter().copied().filter(|v| !pk.contains(v))).collect()
						};
						next.set(k, nums(&list));
					}
					if our("side").as_str() == Some("both") {
						let facs: Vec<String> = next.get("npc").items().iter().map(|n| npc_faction(n.num())).filter(V::truthy).map(|f| f.to_js_string()).collect();
						for n in prev.get("npc").items() {
							let f = npc_faction(n.num());
							if f.truthy() {
								let f = f.to_js_string();
								if f != "AH" && !facs.contains(&f) && !facs.iter().any(|x| x == "AH") && !includes(&next.get("npc"), n.num()) {
									next.get("npc").push(n.clone());
								}
							}
						}
					}
					for k in kinds {
						if !next.get(k).truthy() {
							let pv = prev.get(k);
							next.set(k, if pv.truthy() { pv } else { V::arr() });
						}
					}
					let ordered = Obj::new();
					for k in prev_o.keys() {
						ordered.set_str(k.clone(), next.get(&k));
					}
					for k in next.keys() {
						if !ordered.has(&k) {
							ordered.set_str(k.clone(), next.get(&k));
						}
					}
					let same_list = |k: &str| {
						let a = ordered.get(k);
						let b = prev.get(k);
						stringify(&or_arr(a), None) == stringify(&or_arr(b), None)
					};
					if same_list("npc") && same_list("object") {
						continue;
					}
					kb.change("quests", id, field, prev.clone(), V::Obj(ordered.clone()), &w.source);
					q.set(field, ordered);
				}
				_ => {
					if !decides_verify(field, tier_of(&w.source, field)) {
						// falls through to the tag
					} else {
						if field == "side" {
							continue;
						}
						let v = if field == "races" {
							race_mask_of(&w.value.to_js_string())
						} else {
							let note = w.note.clone().unwrap_or_default();
							note.find("raw ").and_then(|i| {
								let r = &note[i + 4..];
								let neg = r.starts_with('-');
								let digits: String = r[neg as usize..].chars().take_while(char::is_ascii_digit).collect();
								(!digits.is_empty()).then(|| forge_guide::js::str_to_num(&format!("{}{digits}", if neg { "-" } else { "" })))
							})
						};
						let Some(v) = v.filter(|v| v.is_finite()) else { continue };
						let cur = q.get(field);
						if (norm_races(&V::Num(v), &q.get("classes")) == norm_races(&q.get("races"), &q.get("classes")) && field == "races") || v == cur.num() {
							continue;
						}
						kb.change("quests", id, field, if cur.is_nullish() { V::Null } else { cur }, V::Num(v), &w.source);
						q.set(field, v);
					}
				}
			}
			tag(&q, &format!("kb:{}:{field}", w.source));
		}

		// objective counts
		let our_objs = q.get("objectives").items();
		let obj_cands: Vec<Cand> = a.iter().filter(|x| x.field == "objectives" && x.source != "foreverdb.classic").map(to_cand).collect();
		let mut oc = vec![Cand {
			source: project_quest_source(&q, "objectives", &corr).into(),
			value: s(&objs(&our_objs.iter().map(|o| (o.get("type").to_js_string(), o.get("id"), o.get("count"))).collect::<Vec<_>>())),
			note: None,
			project: true,
		}];
		oc.extend(obj_cands.iter().cloned());
		kb.decide("quest", id, "objectives", &oc);
		for o in &our_objs {
			let Some(k) = obj_kind(&o.get("type").to_js_string()) else { continue };
			if o.get("id").is_nullish() {
				continue;
			}
			let oid = o.get("id").num();
			let our_tier = if o.get("count").num() > 0.0 { tier_of(project_quest_source(&q, "objectives", &corr), "objectives") } else { f64::INFINITY };
			let mut best: Option<(f64, f64, String)> = None;
			for c in &obj_cands {
				let Some(m) = parse_objs(&c.value).into_iter().find(|x| x.k == k && x.id == Some(oid) && x.n.is_some_and(|n| n > 0.0)) else { continue };
				let t = tier_of(&c.source, "objectives");
				if best.as_ref().is_none_or(|b| t < b.0) {
					best = Some((t, m.n.unwrap(), c.source.clone()));
				}
			}
			if let Some((t, n, src)) = best {
				if t < our_tier && n != o.get("count").num() {
					kb.change(
						"quests",
						id,
						&format!("objective count {} {}", o.get("type").to_js_string(), o.get("id").to_js_string()),
						if o.get("count").is_nullish() { V::Null } else { o.get("count") },
						V::Num(n),
						&src,
					);
					o.set("count", n);
					tag(&q, &format!("kb:{src}:count"));
				}
			}
		}
		// visibility
		if let Some(st) = a.iter().find(|x| x.field == "status" && x.source == "factoruide") {
			if st.value.as_str() == Some("removed") {
				let mut others = vec![("factoruide".to_string(), "removed".to_string())];
				others.extend(a.iter().filter(|x| x.field == "seen_in_game").map(|x| (x.source.clone(), format!("seen ({})", x.value.to_js_string()))));
				others.extend(a.iter().filter(|x| x.field == "in_client").map(|x| (x.source.clone(), "in the client's quest table".to_string())));
				kb.verify_add("quest", id, q.get("title"), conflict("visibility", s("in the data"), others, None));
			}
		}
		// The client's map areas, area triggers and quest table: facts it alone holds.
		let mut client_fields: Vec<&str> = Vec::new();
		for x in a.iter().filter(|x| x.source == "client") {
			if !client_fields.contains(&x.field.as_str()) {
				client_fields.push(&x.field);
			}
		}
		for field in client_fields {
			let cands: Vec<Cand> = a.iter().filter(|x| x.field == field).map(to_cand).collect();
			kb.decide("quest", id, field, &cands);
		}
	}

	// ---- npcs ----
	for n in npcs.values() {
		let id = n.get("id").num();
		let a = alt_of("npc", id);
		let lvl = n.get("level");
		let lmax = n.get("levelMax");
		let our_level = if lvl.is_nullish() {
			V::Null
		} else if !lmax.is_nullish() && !lmax.strict_eq(&lvl) {
			s(&format!("{}-{}", lvl.to_js_string(), lmax.to_js_string()))
		} else {
			s(&lvl.to_js_string())
		};
		let fac = n.get("faction");
		let ours = [("name", n.get("name")), ("subname", n.get("subName")), ("npc_level", our_level.clone()), ("react", if fac.truthy() { fac } else { V::Null })];
		for (field, ov) in ours {
			let mut cands = vec![Cand { source: project_npc_source(&n, field, &corr).into(), value: ov, note: None, project: true }];
			cands.extend(a.iter().filter(|x| x.field == field && x.source != "foreverdb.classic").map(to_cand));
			let Some(d) = kb.decide("npc", id, field, &cands) else { continue };
			if d.win.project {
				if field == "react" {
					let others: Vec<(String, String)> = d
						.valid
						.iter()
						.enumerate()
						.filter(|(i, c)| *i != d.win_ix && !c.project && !Kb::eq(field, c, &d.win) && c.source != "web" && !check_only(&c.source))
						.map(|(_, c)| (c.source.clone(), c.value.to_js_string()))
						.collect();
					if !others.is_empty() {
						kb.verify_add("npc", id, n.get("name"), conflict("side", s(&d.win.value.to_js_string()), others, None));
					}
				}
				continue;
			}
			if field == "react" || Kb::eq(field, &d.win, &cands[0]) {
				continue;
			}
			if field == "name" || field == "subname" {
				let key = if field == "name" { "name" } else { "subName" };
				let cur = n.get(key);
				kb.change("npcs", id, key, if cur.is_nullish() { V::Null } else { cur }, d.win.value.clone(), &d.win.source);
				n.set(key, d.win.value.clone());
			} else {
				let (lo, hi) = level_range(&d.win.value);
				if !lo.is_finite() {
					continue;
				}
				kb.change("npcs", id, "level", our_level.clone(), d.win.value.clone(), &d.win.source);
				n.set("level", lo);
				if hi != lo || n.has("levelMax") {
					n.set("levelMax", hi);
				}
			}
			tag(&n, &format!("kb:{}:{field}", d.win.source));
		}
		// The rank (classification) the client caches hold.
		if a.iter().any(|x| x.field == "rank") {
			let cur = n.get("rank");
			let ov = s(&num_str(if cur.truthy() { cur.num() } else { 0.0 }));
			let mut cands = vec![Cand { source: project_npc_source(&n, "rank", &corr).into(), value: ov, note: None, project: true }];
			cands.extend(a.iter().filter(|x| x.field == "rank").map(to_cand));
			if let Some(d) = kb.decide("npc", id, "rank", &cands) {
				let v = d.win.value.num();
				if !d.win.project && !Kb::eq("rank", &d.win, &cands[0]) && v.is_finite() {
					kb.change("npcs", id, "rank", if cur.is_nullish() { V::Null } else { cur }, V::Num(v), &d.win.source);
					match n.as_obj() {
						Some(o) if v == 0.0 => {
							o.delete("rank");
						}
						_ => n.set("rank", v),
					}
					tag(&n, &format!("kb:{}:rank", d.win.source));
				}
			}
		}
		let spawn_alts: Vec<&Fact> = a.iter().filter(|x| x.field == "spawns" && x.source != "foreverdb.classic").collect();
		let tdb_has = tdb.is_some_and(|t| t.get("spawns").get("npc").get(&num_str(id)).truthy()) && !src_tags(&n).iter().any(|t| t == "pfquest");
		if !spawn_alts.is_empty() && !tdb_has {
			let mine = ft.our_world(&n);
			let mut others: Vec<(String, f64, String)> = Vec::new();
			for x in spawn_alts {
				let val = x.value.to_js_string();
				let mut dist: Option<f64> = None;
				if !mine.is_empty() {
					for theirs in ft.fact_worlds(&val) {
						let d = if theirs.is_empty() { None } else { set_distance(&mine, &theirs) };
						if let Some(d) = d {
							if dist.is_none_or(|x| d < x) {
								dist = Some(d);
							}
						}
					}
				}
				kb.alt_rows.push(vec![s("npc"), V::Num(id), s("spawns"), s(&x.source), s(&utf16_slice(&val, 2000)), V::Num(if dist.is_some_and(|d| d <= 40.0) { 1.0 } else { 0.0 })]);
				if let Some(d) = dist {
					kb.pos[if d <= 40.0 {
						0
					} else if d <= 100.0 {
						1
					} else {
						2
					}] += 1;
					if d > 40.0 {
						others.push((x.source.clone(), d, val.split(' ').take(6).collect::<Vec<_>>().join(" ")));
					}
				}
			}
			if !others.is_empty() {
				let c = Obj::new();
				c.set("field", "position");
				c.set("ours", n.get("spawns").keys().iter().map(|k| k.to_string()).collect::<Vec<_>>().join(","));
				let yards = others.iter().map(|o| o.1).fold(f64::NEG_INFINITY, f64::max);
				c.set(
					"others",
					arr(others
						.into_iter()
						.map(|(src, y, v)| {
							let o = Obj::new();
							o.set("source", src.as_str());
							o.set("yards", y);
							o.set("value", v.as_str());
							V::Obj(o)
						})
						.collect()),
				);
				c.set("yards", yards);
				kb.verify_add("npc", id, n.get("name"), V::Obj(c));
			}
		}
	}

	// ---- objects: the lock ----
	for o in objects.values() {
		let id = o.get("id").num();
		let a: Vec<Fact> = alt_of("object", id).into_iter().filter(|x| x.field == "lock").collect();
		let lock = o.get("lock");
		if lock.is_nullish() && a.is_empty() {
			continue;
		}
		let mut cands = vec![Cand { source: project_object_source(&o, "lock", &corr).into(), value: if lock.is_nullish() { V::Null } else { s(&stringify(&lock, None)) }, note: None, project: true }];
		cands.extend(a.iter().map(to_cand));
		let Some(d) = kb.decide("object", id, "lock", &cands) else { continue };
		if d.win.project || Kb::eq("lock", &d.win, &cands[0]) {
			continue;
		}
		let nl = match &d.win.value {
			V::Str(t) => parse_json(t).map_err(|e| e.to_string())?,
			v => v.clone(),
		};
		kb.change("objects", id, "lock", if lock.is_nullish() { V::Null } else { lock }, nl.clone(), &d.win.source);
		o.set("lock", nl);
	}

	// ---- objects: the client caches' names, the client's placed objects ----
	for o in objects.values() {
		let id = o.get("id").num();
		let a = alt_of("object", id);
		if a.iter().any(|x| x.field == "name") {
			let cur = o.get("name");
			let mut cands = vec![Cand { source: project_object_source(&o, "name", &corr).into(), value: cur.clone(), note: None, project: true }];
			cands.extend(a.iter().filter(|x| x.field == "name").map(to_cand));
			if let Some(d) = kb.decide("object", id, "name", &cands) {
				if !d.win.project && !Kb::eq("name", &d.win, &cands[0]) {
					kb.change("objects", id, "name", if cur.is_nullish() { V::Null } else { cur }, d.win.value.clone(), &d.win.source);
					o.set("name", d.win.value.clone());
					tag(&o, &format!("kb:{}:name", d.win.source));
				}
			}
		}
		let Some(p) = a.iter().find(|x| x.field == "placement") else { continue };
		kb.decide("object", id, "placement", &[to_cand(p)]);
		let mine = ft.our_world(&o);
		let val = p.value.to_js_string();
		let mut worst: Option<f64> = None;
		for t in ft.fact_world(&val, "l") {
			let best = mine.iter().filter(|m| m.c == t.c).map(|m| hypot(m.wx - t.wx, m.wy - t.wy)).fold(f64::INFINITY, f64::min);
			if best.is_finite() {
				worst = Some(worst.map_or(best, |w| w.max(best)));
			}
		}
		if let Some(y) = worst.filter(|y| *y > MISSING_YD) {
			let c = Obj::new();
			c.set("field", "position");
			c.set("ours", o.get("spawns").keys().iter().map(|k| k.to_string()).collect::<Vec<_>>().join(","));
			let x = Obj::new();
			x.set("source", p.source.as_str());
			x.set("yards", math_round(y));
			x.set("value", val.split(' ').take(6).collect::<Vec<_>>().join(" "));
			c.set("others", arr(vec![V::Obj(x)]));
			c.set("yards", math_round(y));
			kb.verify_add("object", id, o.get("name"), V::Obj(c));
		}
	}

	// ---- items: the client's tables ----
	if inp.client.as_ref().is_some_and(|c| c.tables.is_some()) {
		let mut starts: FxHashMap<i64, Vec<f64>> = FxHashMap::default();
		for q in quests.values() {
			for i in q.get("start").get("item").items() {
				starts.entry(i.num() as i64).or_default().push(q.get("id").num());
			}
		}
		for it in items.values() {
			let id = it.get("id").num();
			let a = alt_of("item", id);
			if a.is_empty() {
				continue;
			}
			let src: &str = if src_tags(&it).iter().any(|t| t == "questie-forever") { "questie" } else { "pfquest" };
			let dur = it.get("duration");
			let ours =
				[("name", it.get("name")), ("duration", if dur.truthy() { s(&dur.to_js_string()) } else { V::Null }), ("quest_item", s(if it.get("questItem").truthy() { "yes" } else { "no" }))];
			for (field, ov) in ours {
				if !a.iter().any(|x| x.field == field) {
					continue;
				}
				let mut cands = vec![Cand { source: src.into(), value: ov.clone(), note: None, project: true }];
				cands.extend(a.iter().filter(|x| x.field == field).map(to_cand));
				let Some(d) = kb.decide("item", id, field, &cands) else { continue };
				if d.win.project || Kb::eq(field, &d.win, &cands[0]) {
					continue;
				}
				let w = d.win.value.clone();
				match field {
					"name" => {
						kb.change("items", id, "name", ov, w.clone(), &d.win.source);
						it.set("name", w);
					}
					"duration" => {
						kb.change("items", id, "duration", ov, V::Num(w.num()), &d.win.source);
						it.set("duration", w.num());
					}
					_ => {
						let yes = w.as_str() == Some("yes");
						kb.change("items", id, "questItem", V::Bool(!yes), V::Bool(yes), &d.win.source);
						match it.as_obj() {
							Some(o) if !yes => {
								o.delete("questItem");
							}
							_ => it.set("questItem", yes),
						}
					}
				}
				tag(&it, &format!("kb:{}:{field}", d.win.source));
			}
			// The quest the item starts: the quest gains the item as a starter.
			let Some(f) = a.iter().find(|x| x.field == "start_quest") else { continue };
			let ours_q = starts.get(&(id as i64)).map(|l| s(&l.iter().map(|q| num_str(*q)).collect::<Vec<_>>().join(","))).unwrap_or(V::Null);
			let cands = vec![Cand { source: src.into(), value: ours_q, note: None, project: true }, to_cand(f)];
			let Some(d) = kb.decide("item", id, "start_quest", &cands) else { continue };
			if d.win.project {
				continue;
			}
			let qid = d.win.value.num();
			let q = quests.get(&num_str(qid));
			if !q.truthy() || includes(&q.get("start").get("item"), id) {
				continue;
			}
			let st = q.get("start");
			if st.get("item").as_arr().is_none() {
				st.set("item", V::arr());
			}
			st.get("item").push(V::Num(id));
			kb.change("quests", qid, "start item", V::Null, V::Num(id), &d.win.source);
			tag(&q, &format!("kb:{}:start", d.win.source));
		}
	}

	// ---- the TDB ----
	let tdb_report = Obj::new();
	for k in [
		"countsFilled",
		"idsFixed",
		"nextFilled",
		"preFilled",
		"limits",
		"spawnIds",
		"spawnsReplaced",
		"spawnsAdded",
		"entitiesAdded",
		"ratesFilled",
		"droppersAdded",
		"trainersAdded",
		"trainingClasses",
		"vendors",
	] {
		tdb_report.set(k, 0.0);
	}
	let bump = |o: &Obj, k: &str, by: f64| o.set(k, o.get(k).as_num().unwrap_or(0.0) + by);
	let mut spawnz_changed = false;
	let mut training = inp.training.clone();
	let mut trainers = inp.trainers.clone();
	let mut spawnz = inp.spawnz.clone();
	if let Some(tdb) = tdb {
		let bh12: String = tdb.get("meta").get("branchHead").to_js_string().chars().take(12).collect();
		let tkind = |t: f64| match t as i64 {
			0 | 3 => Some("kill"),
			1 => Some("item"),
			2 => Some("object"),
			_ => None,
		};
		let name_of = |kind: &str, id: f64| -> Option<String> {
			let ours = (if kind == "item" { items } else { npcs }).get(&num_str(id));
			if ours.truthy() && ours.get("name").truthy() {
				return Some(ours.get("name").to_js_string());
			}
			if kind == "item" {
				return None;
			}
			let t = tdb.get("names").get("npc").get(&num_str(id));
			t.truthy().then(|| t.at(0).to_js_string())
		};
		let eg = inp.eg.as_ref();
		for (qid, tq) in tdb.get("quests").entries() {
			let q = quests.get(&qid);
			if !q.truthy() {
				continue;
			}
			let qidn = forge_guide::js::str_to_num(&qid);
			let sniffed = tq.get("sniffed").truthy();
			let src = if sniffed { "tdb" } else { "tdb.inherited" };
			let mut text_parts = vec![{
				let t = q.get("objectiveText");
				if t.truthy() {
					t.to_js_string()
				} else {
					String::new()
				}
			}];
			for o in q.get("objectives").items() {
				let t = o.get("text");
				text_parts.push(if t.truthy() { t.to_js_string() } else { String::new() });
			}
			let text = text_parts.join(" ");
			let says = |sv: Option<String>| sv.is_some_and(|x| !x.is_empty() && text.to_lowercase().contains(&x.to_lowercase()));
			let mut tobjs: Vec<(&str, f64, f64, bool)> = tq.get("obj").items().iter().filter_map(|o| tkind(o.num_at(0)).map(|k| (k, o.num_at(1), o.num_at(2), false))).collect();
			let mut unmatched: Vec<V> = Vec::new();
			for o in q.get("objectives").items() {
				let ty = o.get("type").to_js_string();
				if !["kill", "item", "object"].contains(&ty.as_str()) {
					continue;
				}
				let Some(mi) = tobjs.iter().position(|t| !t.3 && t.0 == ty && t.1 == o.get("id").num()) else {
					unmatched.push(o);
					continue;
				};
				tobjs[mi].3 = true;
				let mn = tobjs[mi].2;
				let count = o.get("count");
				let label = format!("objective count {} {}", ty, o.get("id").to_js_string());
				if mn > 0.0 && !(count.num() > 0.0) {
					kb.change("quests", qidn, &label, if count.is_nullish() { V::Null } else { count }, V::Num(mn), src);
					o.set("count", mn);
					tag(&q, &format!("kb:{src}:count"));
					bump(&tdb_report, "countsFilled", 1.0);
				} else if mn > 0.0 && sniffed && count.num() != mn {
					let has = |n: &str| count_in_text(&text, n);
					if has(&num_str(mn)) && !has(&count.to_js_string()) {
						kb.change("quests", qidn, &label, count, V::Num(mn), "tdb");
						o.set("count", mn);
						tag(&q, "kb:tdb:count");
					} else {
						kb.verify_add("quest", qidn, q.get("title"), conflict("objective count", s(&count.to_js_string()), vec![("tdb".into(), num_str(mn))], Some(false)));
					}
				}
			}
			if sniffed {
				for o in unmatched {
					let ty = o.get("type").to_js_string();
					if ty == "object" {
						continue;
					}
					let Some(mi) = tobjs.iter().position(|t| !t.3 && t.0 == ty) else { continue };
					tobjs[mi].3 = true;
					let (mid, mn) = (tobjs[mi].1, tobjs[mi].2);
					let kind = if ty == "item" { "item" } else { "npc" };
					let ok = says(name_of(kind, mid))
						&& !says(name_of(kind, o.get("id").num()))
						&& (if kind == "item" { items.get(&num_str(mid)).truthy() } else { has_spawn(npcs, &num_str(mid)) || tdb.get("spawns").get("npc").get(&num_str(mid)).truthy() });
					if ok {
						kb.change("quests", qidn, &format!("objective {ty} id"), V::Num(o.get("id").num()), V::Num(mid), "tdb");
						o.set("id", mid);
						if mn > 0.0 && !(o.get("count").num() > 0.0) {
							o.set("count", mn);
						}
						tag(&q, "kb:tdb:objective");
						bump(&tdb_report, "idsFixed", 1.0);
					} else {
						kb.verify_add("quest", qidn, q.get("title"), conflict("objective id", s(&o.get("id").to_js_string()), vec![("tdb".into(), num_str(mid))], Some(false)));
					}
				}
			}
			let eg_next = eg.and_then(|e| e.quests.get(&(qidn as i64))).and_then(|r| r.next);
			let tnext = tq.get("next");
			if tnext.truthy() && !q.get("next").truthy() && quests.get(&tnext.to_js_string()).truthy() && (sniffed || eg_next.is_none()) {
				kb.change("quests", qidn, "next", V::Null, tnext.clone(), src);
				q.set("next", tnext.clone());
				tag(&q, &format!("kb:{src}:next"));
				bump(&tdb_report, "nextFilled", 1.0);
			}
			let no_pre = !["pre", "preAny", "preAll", "breadcrumbs"].iter().any(|k| q.get(k).is_arr() && !q.get(k).is_empty());
			let prev = tq.get("prev");
			if sniffed && prev.num() > 0.0 && no_pre && quests.get(&prev.to_js_string()).truthy() {
				let cur = q.get("pre");
				kb.change("quests", qidn, "pre", if cur.truthy() { cur } else { V::arr() }, arr(vec![prev.clone()]), "tdb");
				q.set("pre", arr(vec![prev.clone()]));
				tag(&q, "kb:tdb:pre");
				bump(&tdb_report, "preFilled", 1.0);
			}
			let time = tq.get("time");
			if time.num() > 0.0 && !q.get("limit").strict_eq(&time) {
				let cur = q.get("limit");
				kb.change("quests", qidn, "limit", if cur.is_nullish() { V::Null } else { cur }, time.clone(), src);
				q.set("limit", time.clone());
				bump(&tdb_report, "limits", 1.0);
			}
			let rs = tq.get("rewardSpell");
			if rs.num() > 0.0 && q.get("rewardSpell").is_nullish() {
				kb.change("quests", qidn, "rewardSpell", V::Null, rs.clone(), src);
				q.set("rewardSpell", rs.clone());
				bump(&tdb_report, "rewardSpells", 1.0);
			}
		}
		let w = apply_tdb_world(&mut kb, tdb, spawnz.as_mut());
		for (k, v) in w.entries() {
			tdb_report.set_str(k, v);
		}
		spawnz_changed = tdb_report.get("spawnIds").num() > 0.0 && spawnz.is_some();
		if let Some(t) = trainers.as_ref() {
			let t2 = t.as_obj().unwrap().spread();
			for (id, classes) in tdb.get("trainers").entries() {
				let n = npcs.get(&id);
				if t2.get(&id).truthy() || !n.truthy() || n.get("spawns").keys().is_empty() {
					continue;
				}
				let e = Obj::new();
				e.set("id", forge_guide::js::str_to_num(&id));
				e.set("name", n.get("name"));
				e.set("classes", classes.clone());
				e.set("sources", arr(vec![s("forever-tdb")]));
				t2.set_str(id.clone(), e);
				kb.change("trainers", forge_guide::js::str_to_num(&id), "trainer", V::Null, classes, "tdb");
				bump(&tdb_report, "trainersAdded", 1.0);
			}
			trainers = Some(V::Obj(t2));
		}
		let tt = tdb.get("training");
		if let Some(tr) = training.as_ref().filter(|_| tt.truthy() && !tt.keys().is_empty()) {
			let n = tr.as_obj().unwrap().spread();
			n.set("source", format!("forever-tdb {bh12} (classes it lists); {}", tr.get("source").to_js_string()));
			let classes = tr.get("classes").as_obj().map(Obj::spread).unwrap_or_default();
			n.set("classes", classes.clone());
			for (cls, per) in tt.entries() {
				let cur = classes.get(&cls);
				if cur.is_undef() || stringify(&cur, None) != stringify(&per, None) {
					kb.change("training", f64::NAN, "cost per level", if cur.truthy() { cur } else { V::Null }, per.clone(), "tdb");
				}
				classes.set_str(cls, per);
				bump(&tdb_report, "trainingClasses", 1.0);
			}
			let ts = tdb.get("trainingSpells");
			if ts.truthy() {
				n.set("spells", ts.as_obj().unwrap().spread());
			}
			training = Some(V::Obj(n));
		}
		let ride: Vec<(String, V)> = tdb.get("riding").entries().into_iter().filter(|(id, _)| has_spawn(npcs, id)).map(|(k, v)| (k.to_string(), v)).collect();
		if let Some(tr) = training.as_ref().filter(|_| !ride.is_empty()) {
			let mut rs: Vec<&V> = ride.iter().map(|(_, r)| r).collect();
			rs.sort_by(|a, b| {
				let d = b.num_at(2) - a.num_at(2);
				let d = if d != 0.0 { d } else { a.num_at(1) - b.num_at(1) };
				let d = if d != 0.0 { d } else { b.num_at(0) - a.num_at(0) };
				d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
			});
			let best = rs[0];
			let mut tl: Vec<(f64, f64)> = ride
				.iter()
				.map(|(id, r)| {
					(forge_guide::js::str_to_num(id), {
						let x = r.num_at(3);
						if x == 0.0 || x.is_nan() {
							0.0
						} else {
							x
						}
					})
				})
				.collect();
			tl.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());
			let riding = Obj::new();
			riding.set("level", best.at(1));
			riding.set("cost", best.at(0));
			riding.set(
				"trainers",
				arr(tl
					.into_iter()
					.map(|(id, races)| {
						let o = Obj::new();
						o.set("id", id);
						o.set("races", races);
						V::Obj(o)
					})
					.collect()),
			);
			riding.set("source", format!("forever-tdb {bh12} (Apprentice Riding{})", if best.at(2).truthy() { ", sniffed list" } else { "" }));
			let n = tr.as_obj().unwrap().spread();
			n.set("riding", riding);
			training = Some(V::Obj(n));
			tdb_report.set("ridingTrainers", ride.len());
		}
	}

	// ---- EG Link output and the client's caches: next quests, missing objectives ----
	let eg_report = Obj::new();
	for k in ["nextFilled", "objectivesAdded", "ratesFilled", "droppersAdded"] {
		eg_report.set(k, 0.0);
	}
	let client_report = Obj::new();
	for k in ["nextFilled", "objectivesAdded"] {
		client_report.set(k, 0.0);
	}
	let caches: Vec<(&IndexMap<i64, EgQuest>, &str, &Obj)> =
		inp.eg.as_ref().map(|e| (&e.quests, "eg", &eg_report)).into_iter().chain(inp.client.as_ref().and_then(|c| c.cache.as_ref()).map(|c| (&c.quests, "client.cache", &client_report))).collect();
	for (recs, source, report) in caches {
		for (&qid, r) in recs {
			let q = quests.get(&qid.to_string());
			if !q.truthy() || r.build.is_none() {
				continue;
			}
			let qidn = qid as f64;
			if let Some(nx) = r.next {
				if !q.get("next").truthy() && quests.get(&num_str(nx)).truthy() {
					kb.change("quests", qidn, "next", V::Null, V::Num(nx), source);
					q.set("next", nx);
					tag(&q, &format!("kb:{source}:next"));
					bump(report, "nextFilled", 1.0);
				}
			}
			let start_items = q.get("start").get("item");
			let source_item = q.get("sourceItem");
			let list: Vec<(&str, f64, Option<f64>)> = r
				.objectives
				.iter()
				.filter_map(|(k, oid, n)| {
					let ty = match k.as_str() {
						"kill" => "kill",
						"item" => "item",
						"object" => "object",
						_ => return None,
					};
					let oid_v = oid.map(V::Num).unwrap_or(V::Null);
					let excluded = ty == "item" && ((oid.is_some() && *oid == r.start_item) || oid.is_some_and(|o| includes(&start_items, o)) || oid_v.strict_eq(&source_item));
					(!excluded).then_some((ty, oid.unwrap_or(f64::NAN), *n))
				})
				.collect();
			let usable: Vec<&(&str, f64, Option<f64>)> = list
				.iter()
				.filter(|(k, oid, _)| match *k {
					"kill" => has_spawn(npcs, &num_str(*oid)),
					"object" => has_spawn(objects, &num_str(*oid)),
					_ => items.get(&num_str(*oid)).truthy(),
				})
				.collect();
			if q.get("objectives").is_empty() && !usable.is_empty() && usable.len() == list.len() {
				let objs = arr(usable
					.iter()
					.map(|(k, oid, n)| {
						let o = Obj::new();
						o.set("type", *k);
						o.set("id", *oid);
						o.set("count", n.filter(|x| *x > 0.0).map(V::Num).unwrap_or(V::Null));
						o.set("text", V::Null);
						V::Obj(o)
					})
					.collect());
				q.set("objectives", objs.clone());
				kb.change("quests", qidn, "objectives", V::arr(), objs, source);
				tag(&q, &format!("kb:{source}:objectives"));
				bump(report, "objectivesAdded", 1.0);
			}
		}
	}
	if let Some(eg) = inp.eg.as_ref() {
		for (&item_id, kinds) in &eg.drops {
			let it = items.get(&item_id.to_string());
			if !it.truthy() || !it.get("drops").truthy() {
				continue;
			}
			for (ki, kind) in ["npc", "object"].iter().enumerate() {
				let mut drops = it.get("drops").get(kind);
				if !drops.truthy() {
					drops = V::obj();
					it.get("drops").set(kind, drops.clone());
				}
				let prior = if *kind == "npc" {
					if it.get("questItem").truthy() {
						NPC_PRIOR_QUEST
					} else {
						NPC_PRIOR_OTHER
					}
				} else {
					OBJECT_PRIOR
				};
				for (&ent, &(pct, k, n)) in &kinds[ki] {
					let rate = if n > 0.0 { math_round((1000.0 * (k + (PRIOR_WEIGHT * prior) / 100.0)) / (n + PRIOR_WEIGHT)) / 10.0 } else { pct };
					let ek = ent.to_string();
					if drops.has(&ek) {
						if !drops.get(&ek).is_nullish() {
							continue;
						}
						drops.set(&ek, rate);
						kb.change("items", item_id as f64, &format!("drop {kind}"), V::Null, V::Num(rate), "eg");
						bump(&eg_report, "ratesFilled", 1.0);
					} else if it.get("questItem").truthy() && has_spawn(if *kind == "npc" { npcs } else { objects }, &ek) && rate >= 1.0 {
						let recs = drops.as_obj().unwrap().spread();
						recs.set(&ek, rate);
						it.get("drops").set(kind, sorted_keys(&recs));
						kb.change("items", item_id as f64, &format!("dropper {kind}"), V::Null, s(&format!("{ek}:{}", num_str(rate))), "eg");
						bump(&eg_report, "droppersAdded", 1.0);
					} else {
						continue;
					}
					tag(&it, "kb:eg:drops");
				}
			}
		}
	}

	// ---- mechanics ----
	let mech = build_mechanics(&inp.mechanics, quests, &inp.corrections.get("mechanics"))?;

	// ---- verify-in-game ----
	let mut relevant: [FxHashMap<i64, i32>; 2] = Default::default();
	for q in quests.values() {
		let in_v2 = inp.v2_quests.contains(&(q.get("id").num() as i64));
		let mut mark = |k: usize, id: f64| *relevant[k].entry(id as i64).or_insert(0) |= if in_v2 { 2 } else { 1 };
		for r in ["start", "end"] {
			for (ki, k) in ["npc", "object"].iter().enumerate() {
				for x in q.get(r).get(k).items() {
					mark(ki, x.num());
				}
			}
		}
		for o in q.get("objectives").items() {
			match o.get("type").as_str() {
				Some("kill") => mark(0, o.get("id").num()),
				Some("object") => mark(1, o.get("id").num()),
				_ => {}
			}
		}
	}
	let rank_of = |kind: &str, id: f64| -> f64 {
		if kind == "quest" {
			return if inp.v2_quests.contains(&(id as i64)) { 0.0 } else { 2.0 };
		}
		let r = match kind {
			"npc" => relevant[0].get(&(id as i64)).copied().unwrap_or(0),
			"object" => relevant[1].get(&(id as i64)).copied().unwrap_or(0),
			_ => 0,
		};
		if r & 2 != 0 {
			0.0
		} else if r & 1 != 0 {
			1.0
		} else {
			3.0
		}
	};
	let mut verify_list: Vec<(f64, f64, String, f64, V, Vec<V>)> = kb
		.verify
		.values()
		.map(|(kind, id, name, conflicts)| {
			let yards = conflicts.iter().map(|c| c.get("yards").as_num().filter(|y| *y != 0.0 && !y.is_nan()).unwrap_or(0.0)).fold(0.0, f64::max);
			(rank_of(kind, *id), yards, kind.clone(), *id, name.clone(), conflicts.clone())
		})
		.collect();
	verify_list.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap().then(b.1.partial_cmp(&a.1).unwrap()).then(a.2.cmp(&b.2)).then(a.3.partial_cmp(&b.3).unwrap()));
	let verify_v: Vec<V> = verify_list
		.iter()
		.map(|(rank, yards, kind, id, name, conflicts)| {
			let o = Obj::new();
			o.set("kind", kind.as_str());
			o.set("id", *id);
			o.set("name", name.clone());
			o.set("conflicts", arr(conflicts.clone()));
			o.set("rank", *rank);
			o.set("yards", *yards);
			V::Obj(o)
		})
		.collect();
	let pos_v = {
		let o = Obj::new();
		o.set("under40", kb.pos[0]);
		o.set("from40to100", kb.pos[1]);
		o.set("over100", kb.pos[2]);
		o
	};
	let vc = verify_counts(&verify_v);
	vc.set("positionComparisons", pos_v);

	// ---- write ----
	if let Some(f) = &inp.kb_file {
		write_kb(f, &kb, quests, npcs, objects, items, &verify_v, &mech, tdb, training.as_ref(), trainers.as_ref(), &alt.versions)?;
	}
	if let Some(f) = &inp.verify_file {
		std::fs::create_dir_all(f.parent().unwrap()).map_err(|e| e.to_string())?;
		let o = Obj::new();
		o.set("schema", 1.0);
		o.set("counts", vc.clone());
		o.set("entities", arr(verify_v.clone()));
		std::fs::write(f, format!("{}\n", stringify(&V::Obj(o), Some("\t")))).map_err(|e| format!("{}: {e}", f.display()))?;
	}
	let by_class = Obj::new();
	for c in &kb.changes {
		let k = format!("{}.{}", c.table, class_field(&c.field));
		if !by_class.has(&k) {
			by_class.set(&k, Obj::new());
		}
		let b = by_class.get(&k);
		b.set(&c.source, b.get(&c.source).as_num().unwrap_or(0.0) + 1.0);
	}
	log(&format!("  knowledge base: {} facts, {} alternatives, {} changes, {} to verify in game", kb.fact_rows.len(), kb.alt_rows.len(), kb.changes.len(), verify_v.len()));
	let used = |src: &str| kb.changes.iter().any(|c| c.source == src || c.source.starts_with(&format!("{src}.")));
	let credits = kb_credits(&used, inp.eg.is_some(), inp.vo.is_some(), inp.factoruide_file.is_some());
	let report = Obj::new();
	report.set("byClass", by_class);
	report.set("tdb", tdb_report);
	report.set("eg", eg_report);
	report.set("client", client_report);
	report.set("mechanics", mech.counts.clone());
	report.set("verify", vc);
	Ok(KbOut {
		changes: kb.changes.len(),
		tdb_used: tdb.is_some() && kb.changes.iter().any(|c| c.source.starts_with("tdb")),
		credits,
		mechanics: mech.out,
		training,
		trainers,
		spawnz_changed,
		report,
		spawnz,
	})
}

/// `new RegExp('(^|[^0-9])' + n + '([^0-9]|$)').test(text)` for a number's text.
fn count_in_text(text: &str, n: &str) -> bool {
	if n.is_empty() {
		return true;
	}
	let b = text.as_bytes();
	let mut from = 0;
	while let Some(i) = text[from..].find(n) {
		let at = from + i;
		let before = at == 0 || !b[at - 1].is_ascii_digit();
		let end = at + n.len();
		let after = end == b.len() || !b[end].is_ascii_digit();
		if before && after {
			return true;
		}
		from = at + 1;
		while !text.is_char_boundary(from) {
			from += 1;
		}
	}
	false
}

fn class_field(f: &str) -> String {
	// / (kill|item|object|event|talk) -?\d+$/ then / (kill|item|object) id$/ -> ' id'
	let mut out = f.to_string();
	for k in ["kill", "item", "object", "event", "talk"] {
		let pre = format!(" {k} ");
		if let Some(i) = out.rfind(&pre) {
			let tail = &out[i + pre.len()..];
			let t = tail.strip_prefix('-').unwrap_or(tail);
			if !t.is_empty() && t.bytes().all(|c| c.is_ascii_digit()) {
				out.truncate(i);
				break;
			}
		}
	}
	for k in ["kill", "item", "object"] {
		let suf = format!(" {k} id");
		if out.ends_with(&suf) {
			let l = out.len() - suf.len();
			out.truncate(l);
			out.push_str(" id");
			break;
		}
	}
	out
}

/// The first `n` UTF-16 units of `s` (a cut surrogate pair leaves U+FFFD, as node writes it).
fn utf16_slice(s: &str, n: usize) -> String {
	let u: Vec<u16> = s.encode_utf16().collect();
	if u.len() <= n {
		return s.to_string();
	}
	String::from_utf16_lossy(&u[..n])
}

fn verify_counts(list: &[V]) -> Obj {
	let c = Obj::new();
	c.set("entities", list.len());
	let by_rank = Obj::new();
	let by_field = Obj::new();
	let (mut p0, mut p1, mut p2) = (0, 0, 0);
	for e in list {
		let r = e.get("rank").to_js_string();
		by_rank.set(&r, by_rank.get(&r).as_num().unwrap_or(0.0) + 1.0);
		for x in e.get("conflicts").items() {
			let f = x.get("field").to_js_string();
			by_field.set(&f, by_field.get(&f).as_num().unwrap_or(0.0) + 1.0);
			if f == "position" {
				for o in x.get("others").items() {
					let y = o.get("yards").num();
					if y <= 40.0 {
						p0 += 1;
					} else if y <= 100.0 {
						p1 += 1;
					} else {
						p2 += 1;
					}
				}
			}
		}
	}
	c.set("byRank", by_rank);
	c.set("byField", by_field);
	let p = Obj::new();
	p.set("under40", p0);
	p.set("from40to100", p1);
	p.set("over100", p2);
	c.set("position", p);
	c
}

/// The TDB's sniffed spawns, drop rates and droppers (kb.js applyTdbWorld).
fn apply_tdb_world(kb: &mut Kb, tdb: &V, spawnz: Option<&mut (V, V)>) -> Obj {
	let inp = kb.inp;
	let (quests, npcs, objects, items) = (inp.quests, inp.npcs, inp.objects, inp.items);
	let r = Obj::new();
	for k in ["spawnIds", "spawnsReplaced", "spawnsAdded", "entitiesAdded", "ratesFilled", "droppersAdded"] {
		r.set(k, 0.0);
	}
	r.set("vendors", tdb.get("vendors").keys().len());
	let bump = |k: &str, by: f64| r.set(k, r.get(k).num() + by);
	let era = inp.frames.get("era");
	let fv = inp.frames.get("forever");
	let frame_of = |map: &str, f: &str| -> Option<V> {
		let x = fv.get(map);
		if f == "l" && x.truthy() {
			return Some(x);
		}
		let e = era.get(map);
		if e.truthy() {
			return Some(e);
		}
		x.truthy().then_some(x)
	};
	let to_world = |map: &str, x: f64, y: f64, f: &str| -> Option<(f64, f64, f64)> {
		let b = frame_of(map, f)?;
		let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
		Some((b.get("c").num(), top + ((bottom - top) * y) / 100.0, left + ((right - left) * x) / 100.0))
	};
	let to_pct = |b: &V, wx: f64, wy: f64| -> [f64; 2] {
		let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
		[math_round(((wy - left) / (right - left)) * 1e4) / 100.0, math_round(((wx - top) / (bottom - top)) * 1e4) / 100.0]
	};
	let inside = |p: &[f64; 2]| (0.0..=100.0).contains(&p[0]) && (0.0..=100.0).contains(&p[1]);
	let mut zone_maps: Vec<(String, &str, V, f64)> = Vec::new();
	for (set, f) in [("era", "e"), ("forever", "l")] {
		for (id, b) in inp.frames.get(set).entries() {
			let z = inp.zones.get(&id);
			let (dl, dt) = ((b.get("right").num() - b.get("left").num()).abs(), (b.get("bottom").num() - b.get("top").num()).abs());
			if !z.truthy() || z.get("type").num() != 3.0 || dl < 1.0 || dt < 1.0 {
				continue;
			}
			let live = inp.live.contains(&(forge_guide::js::str_to_num(&id) as i64));
			if f == "l" && era.get(&id).truthy() && !live {
				continue;
			}
			if f == "e" && live && fv.get(&id).truthy() {
				continue;
			}
			let area = ((b.get("right").num() - b.get("left").num()) * (b.get("bottom").num() - b.get("top").num())).abs();
			zone_maps.push((id.to_string(), f, b, area));
		}
	}
	zone_maps.sort_by(|a, b| a.3.partial_cmp(&b.3).unwrap().then(forge_guide::js::str_to_num(&a.0).partial_cmp(&forge_guide::js::str_to_num(&b.0)).unwrap()));
	let our_points = |ent: &V| -> Vec<(f64, f64, f64)> {
		let mut out = Vec::new();
		for (map, sp) in ent.get("spawns").entries() {
			let f = sp.get("f").to_js_string();
			for p in sp.get("pts").items().into_iter().chain(sp.get("more").items()) {
				if let Some(w) = to_world(&map, p.num_at(0), p.num_at(1), &f) {
					out.push(w);
				}
			}
		}
		out
	};
	let place = |ent: &V, row: &V| -> f64 {
		let (c, wx, wy) = (row.num_at(0), row.num_at(1), row.num_at(2));
		for (map, sp) in ent.get("spawns").entries() {
			let Some(b) = frame_of(&map, &sp.get("f").to_js_string()) else { continue };
			if b.get("c").num() != c {
				continue;
			}
			let p = to_pct(&b, wx, wy);
			if inside(&p) {
				if sp.get("pts").len() < 24 {
					sp.get("pts").push(nums(&p));
				} else {
					if !sp.get("more").truthy() {
						sp.set("more", V::arr());
					}
					sp.get("more").push(nums(&p));
				}
				return 1.0;
			}
		}
		for (zid, zf, zb, _) in &zone_maps {
			if zb.get("c").num() != c {
				continue;
			}
			let p = to_pct(zb, wx, wy);
			if !inside(&p) {
				continue;
			}
			let cur = ent.get("spawns");
			let mut recs: Vec<f64> = cur.keys().iter().map(|k| forge_guide::js::str_to_num(k)).collect();
			recs.push(forge_guide::js::str_to_num(zid));
			recs.sort_by(|a, b| a.partial_cmp(b).unwrap());
			let spawns = Obj::new();
			for k in recs {
				let ks = num_str(k);
				let e = cur.get(&ks);
				spawns.set(
					&ks,
					if e.truthy() {
						e
					} else {
						let o = Obj::new();
						o.set("f", *zf);
						o.set("pts", V::arr());
						V::Obj(o)
					},
				);
			}
			ent.set("spawns", spawns);
			ent.get("spawns").get(zid).get("pts").push(nums(&p));
			return 1.0;
		}
		0.0
	};
	let near = |pts: &[(f64, f64, f64)], row: &V, yd: f64| pts.iter().any(|w| w.0 == row.num_at(0) && hypot(w.1 - row.num_at(1), w.2 - row.num_at(2)) <= yd);
	let forever_only = |ent: &V| !(ent.get("source").is_arr() && src_tags(ent).iter().any(|t| t == "pfquest"));

	let mut named: [FxHashSet<i64>; 2] = Default::default();
	for q in quests.values() {
		for o in q.get("objectives").items() {
			match o.get("type").as_str() {
				Some("kill") => {
					named[0].insert(o.get("id").num() as i64);
				}
				Some("object") => {
					named[1].insert(o.get("id").num() as i64);
				}
				_ => {}
			}
		}
		for k in ["start", "end"] {
			for (ki, kind) in ["npc", "object"].iter().enumerate() {
				for id in q.get(k).get(kind).items() {
					named[ki].insert(id.num() as i64);
				}
			}
		}
	}
	// drops
	let shrunk = |e: &V, prior: f64| if e.num_at(4) > 0.0 { math_round((1000.0 * (e.num_at(3) + (PRIOR_WEIGHT * prior) / 100.0)) / (e.num_at(4) + PRIOR_WEIGHT)) / 10.0 } else { e.num_at(0) };
	let sniff_rate = |e: &V| (to_int32(e.num_at(2)) & 2) != 0 && e.at(1).to_js_string().split('+').any(|p| p == "sniff") && !e.at(1).to_js_string().contains("placeholder");
	for (ki, kind) in ["npc", "object"].iter().enumerate() {
		for (item_id, ents_) in tdb.get("loot").get(kind).entries() {
			let it = items.get(&item_id);
			if !it.truthy() || !it.get("drops").truthy() {
				continue;
			}
			let mut drops = it.get("drops").get(kind);
			if !drops.truthy() {
				drops = V::obj();
				it.get("drops").set(kind, drops.clone());
			}
			let prior = if *kind == "npc" {
				if it.get("questItem").truthy() {
					NPC_PRIOR_QUEST
				} else {
					NPC_PRIOR_OTHER
				}
			} else {
				OBJECT_PRIOR
			};
			for (ent, e) in ents_.entries() {
				let rate = |x: f64| math_round((if sniff_rate(&e) { shrunk(&e, prior) } else { e.num_at(0) }) * (if *kind == "object" { x } else { 1.0 }) * 100.0) / 100.0;
				let mult = {
					let m = e.num_at(5);
					if m == 0.0 || m.is_nan() {
						1.0
					} else {
						m
					}
				};
				let iid = forge_guide::js::str_to_num(&item_id);
				if drops.has(&ent) {
					if drops.get(&ent).is_nullish() && sniff_rate(&e) {
						let v = rate(mult);
						drops.set(&ent, v);
						kb.change("items", iid, &format!("drop {kind}"), V::Null, V::Num(v), "tdb");
						bump("ratesFilled", 1.0);
					}
				} else if it.get("questItem").truthy() && (to_int32(e.num_at(2)) & 1) != 0 && !e.at(1).to_js_string().contains("placeholder") && e.num_at(0) >= 1.0 {
					let recs = drops.as_obj().unwrap().spread();
					recs.set_str(ent.clone(), rate(mult));
					let sorted = sorted_keys(&recs);
					it.get("drops").set(kind, sorted.clone());
					kb.change("items", iid, &format!("dropper {kind}"), V::Null, s(&format!("{ent}:{}", sorted.get(&ent).to_js_string())), if sniff_rate(&e) { "tdb" } else { "tdb.inherited" });
					named[ki].insert(forge_guide::js::str_to_num(&ent) as i64);
					bump("droppersAdded", 1.0);
					tag(&it, "kb:tdb:drops");
				}
			}
		}
	}
	// sniffed spawns
	let mut z = spawnz;
	for (ki, kind) in ["npc", "object"].iter().enumerate() {
		let table = if ki == 0 { npcs } else { objects };
		for (id, rows) in tdb.get("spawns").get(kind).entries() {
			let mut ent = table.get(&id);
			let idn = forge_guide::js::str_to_num(&id);
			let tbl = if ki == 0 { "npcs" } else { "objects" };
			if !ent.truthy() {
				let nm = tdb.get("names").get(kind).get(&id);
				if !named[ki].contains(&(idn as i64)) || !nm.truthy() {
					continue;
				}
				let o = Obj::new();
				o.set("id", idn);
				o.set("name", nm.at(0));
				if ki == 0 {
					if nm.at(1).truthy() {
						o.set("level", nm.at(1));
						o.set("levelMax", nm.at(2));
					}
					o.set("faction", V::Null);
				}
				o.set("spawns", Obj::new());
				o.set("source", arr(vec![s("forever-tdb")]));
				table.set_str(id.clone(), o);
				ent = table.get(&id);
				kb.change(tbl, idn, "entity", V::Null, nm.at(0), "tdb");
				bump("entitiesAdded", 1.0);
			} else if !forever_only(&ent) {
				continue;
			}
			let before = stringify(&or_obj(ent.get("spawns")), None);
			let ours = our_points(&ent);
			if !ent.get("spawns").truthy() {
				ent.set("spawns", Obj::new());
			}
			let rows_v = rows.items();
			let mut added = 0.0;
			if !ours.is_empty() && !rows_v.iter().any(|row| near(&ours, row, MISPLACED_YD)) {
				ent.set("spawns", Obj::new());
				for row in &rows_v {
					added += place(&ent, row);
				}
				if added > 0.0 {
					bump("spawnsReplaced", 1.0);
					kb.change(tbl, idn, "spawns (replaced: misplaced)", parse_json(&before).unwrap_or(V::Null), ent.get("spawns"), "tdb");
				} else {
					ent.set("spawns", parse_json(&before).unwrap_or(V::obj()));
				}
			} else {
				for row in &rows_v {
					if !near(&ours, row, MISSING_YD) {
						added += place(&ent, row);
					}
				}
				if added > 0.0 {
					bump("spawnsAdded", added);
					kb.change(tbl, idn, "spawns (added)", V::Null, V::Num(added), "tdb");
				}
			}
			if added == 0.0 && ours.is_empty() {
				continue;
			}
			bump("spawnIds", 1.0);
			if added > 0.0 {
				tag(&ent, "kb:tdb:spawns");
			}
			if let Some(zz) = z.as_deref_mut() {
				let zt = if ki == 0 { &mut zz.0 } else { &mut zz.1 };
				if !zt.truthy() {
					*zt = V::obj();
				}
				let prev = zt.get(&id).items();
				let keep: Vec<V> =
					prev.into_iter().filter(|sp| !rows_v.iter().any(|row| row.num_at(0) == sp.num_at(0) && hypot(row.num_at(1) - sp.num_at(1), row.num_at(2) - sp.num_at(2)) < 1.0)).collect();
				let mut all = keep;
				for row in &rows_v {
					all.push(if ki == 0 {
						nums(&[row.num_at(0), row.num_at(1), row.num_at(2), row.num_at(3), row.num_at(4)])
					} else {
						nums(&[row.num_at(0), row.num_at(1), row.num_at(2), row.num_at(3)])
					});
				}
				zt.set(&id, arr(all));
			}
		}
	}
	r
}

pub struct Mech {
	pub out: Obj,
	pub counts: Obj,
	kinds: Vec<Row>,
	steps: Vec<Row>,
}

fn read_json_v(p: &Path) -> Result<V, String> {
	if !p.exists() {
		return Ok(V::Null);
	}
	parse_json(&std::fs::read_to_string(p).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", p.display()))
}

fn group_of(src: &str) -> String {
	match src {
		"player-notes" | "quest-text" => "page".into(),
		"server" => "cmangos".into(),
		"forever-data" => "data".into(),
		"server-forever" => "tdb".into(),
		"web" => "web".into(),
		o => o.into(),
	}
}

fn build_mechanics(files: &MechFiles, quests: &Obj, corrections: &V) -> Result<Mech, String> {
	let mq = read_json_v(&files.quest_mechanics)?.get("quests");
	let sq = read_json_v(&files.quest_steps)?.get("quests");
	let tl = read_json_v(&files.tdb_layer)?.get("quests");
	let w = read_json_v(&files.web)?.get("quests");
	let public = read_json_v(&files.public)?;
	let pl = public.get("quests");
	let counts = Obj::new();
	for k in ["quests", "kinds", "driving", "refuted", "tdbConfirmed", "tdbAdded", "webConfirmed", "webRefuted", "steps", "drivingSteps", "corrected"] {
		counts.set(k, 0.0);
	}
	let bump = |k: &str, by: f64| counts.set(k, counts.get(k).as_num().unwrap_or(0.0) + by);
	let out = Obj::new();
	let mut rk: Vec<Row> = Vec::new();
	let mut rs: Vec<Row> = Vec::new();
	let mut ids: Vec<String> = Vec::new();
	for k in mq.keys().into_iter().chain(sq.keys()).chain(pl.keys()).chain(corrections.keys()) {
		if !ids.iter().any(|x| **x == *k) && quests.get(&k).truthy() {
			ids.push(k.to_string());
		}
	}
	ids.sort_by(|a, b| forge_guide::js::str_to_num(a).partial_cmp(&forge_guide::js::str_to_num(b)).unwrap_or(std::cmp::Ordering::Equal));
	for id in ids {
		let idn = forge_guide::js::str_to_num(&id);
		let m = mq.get(&id);
		let t = tl.get(&id);
		let wq = w.get(&id);
		let mut web: Vec<(String, V)> = Vec::new();
		for f in wq.get("facts").items() {
			if f.get("kind").as_str() == Some("mechanic") && f.get("claim").truthy() {
				let k = f.get("claim").get("kind").to_js_string();
				let v = f.get("claim").get("verdict");
				match web.iter_mut().find(|(x, _)| *x == k) {
					Some(e) => e.1 = v,
					None => web.push((k, v)),
				}
			}
		}
		let wv_of = |k: &str| web.iter().find(|(x, _)| x == k).map(|(_, v)| v.clone()).unwrap_or(V::Undef);
		let mut kinds: Vec<Obj> = Vec::new();
		for k in m.get("kinds").items() {
			let kname = k.get("kind").to_js_string();
			let mut sources: Vec<String> = Vec::new();
			for x in k.get("sources").items() {
				let x = x.to_js_string();
				if !sources.contains(&x) {
					sources.push(x);
				}
			}
			let tv = t.get("verdicts").get(&kname);
			if tv.as_str() == Some("confirmed") {
				if !sources.iter().any(|x| x == "server-forever") {
					sources.push("server-forever".into());
				}
				bump("tdbConfirmed", 1.0);
			}
			let wv = wv_of(&kname);
			if wv.as_str() == Some("confirmed") {
				if !sources.iter().any(|x| x == "web") {
					sources.push("web".into());
				}
				bump("webConfirmed", 1.0);
			}
			let k_has_server = k.get("sources").items().iter().any(|x| x.as_str() == Some("server"));
			if tv.as_str() == Some("refuted") || (wv.as_str() == Some("refuted") && !k_has_server && tv.as_str() != Some("confirmed")) {
				bump("refuted", 1.0);
				if wv.as_str() == Some("refuted") {
					bump("webRefuted", 1.0);
				}
				rk.push(vec![
					V::Num(idn),
					s(&kname),
					s("refuted"),
					s(if tv.as_str() == Some("refuted") { "server-forever" } else { "web" }),
					s("high"),
					V::Num(0.0),
					s(&stringify(&arr(sources.iter().map(|x| s(x)).collect()), None)),
				]);
				continue;
			}
			let mut groups: Vec<String> = Vec::new();
			for x in &sources {
				let g = group_of(x);
				if !groups.contains(&g) {
					groups.push(g);
				}
			}
			let kc = k.get("confidence");
			let confidence = if tv.as_str() == Some("confirmed") {
				"high"
			} else if kc.as_str() == Some("low") {
				"low"
			} else if groups.len() >= 2 && kc.as_str() == Some("high") {
				"high"
			} else {
				"medium"
			};
			let drives = confidence == "high" || groups.len() >= 2;
			let mut srt = sources.clone();
			srt.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
			let o = Obj::new();
			o.set("kind", kname.as_str());
			o.set("confidence", confidence);
			o.set("sources", arr(srt.iter().map(|x| s(x)).collect()));
			o.set("drives", drives);
			kinds.push(o);
		}
		for k in t.get("added").items() {
			let ks = k.to_js_string();
			if let Some(had) = kinds.iter().find(|x| x.get("kind").as_str() == Some(&ks)) {
				let srcs = had.get("sources").items();
				if srcs.len() == 1 && srcs[0].as_str() == Some("server-forever") {
					bump("tdbAdded", 1.0);
				}
				continue;
			}
			let o = Obj::new();
			o.set("kind", k.clone());
			o.set("confidence", "medium");
			o.set("sources", arr(vec![s("server-forever")]));
			o.set("drives", false);
			kinds.push(o);
			bump("tdbAdded", 1.0);
		}
		for r in m.get("refuted").items() {
			let rk_ = r.get("kind").to_js_string();
			let in_m = m.get("kinds").items().iter().any(|x| x.get("kind").as_str() == Some(&rk_));
			if kinds.iter().any(|x| x.get("kind").as_str() == Some(&rk_)) || (t.get("verdicts").get(&rk_).as_str() == Some("refuted") && in_m) {
				continue;
			}
			bump("refuted", 1.0);
			let by = r.get("by");
			let srcs = r.get("sources");
			rk.push(vec![V::Num(idn), s(&rk_), s("refuted"), if by.truthy() { by } else { s("server-forever") }, s("high"), V::Num(0.0), s(&stringify(&or_arr(srcs), None))]);
		}
		let drive_kind = |k: &str| kinds.iter().find(|x| x.get("kind").as_str() == Some(k)).map(|x| x.get("drives").truthy());
		let mut params: Vec<Obj> = Vec::new();
		for p in m.get("params").items() {
			let pk = p.get("kind").to_js_string();
			let Some(dk) = drive_kind(&pk) else { continue };
			let o = Obj::new();
			for (k, v) in p.entries() {
				if !matches!(&*k, "source" | "confidence" | "checkedAt") {
					o.set_str(k, v);
				}
			}
			o.set("source", p.get("source"));
			o.set("drives", dk && p.get("confidence").as_str() != Some("low"));
			params.push(o);
		}
		let tdb_facts: Vec<V> = t
			.get("facts")
			.items()
			.into_iter()
			.filter(|f| f.get("kind").truthy() && drive_kind(&f.get("kind").to_js_string()).is_some())
			.map(|f| {
				let o = Obj::new();
				o.set("kind", f.get("kind"));
				o.set("fact", f.get("how"));
				let tr = f.get("trigger");
				o.set("trigger", if tr.truthy() { tr } else { V::Null });
				V::Obj(o)
			})
			.collect();
		let or_null = |v: V| if v.truthy() { v } else { V::Null };
		let (ev_steps, ev_gotchas) = read_evidence(&files.evidence, &id);
		let mut steps: Vec<Obj> = Vec::new();
		for st in sq.get(&id).get("steps").items() {
			let structured = matches!(st.get("source").as_str(), Some("server" | "forever-data"));
			let action = st.get("action").to_js_string();
			let kind_for = match action.as_str() {
				"summon" => Some("summon-by-item"),
				"use" => Some(if st.get("place").truthy() { "use-item-at-place" } else { "use-item-on-mob" }),
				"escort" => Some("escort"),
				"interact" => Some("object-click"),
				"buy" => Some("vendor-buy"),
				"make" => Some("crafted"),
				_ => None,
			};
			let kd = kind_for.and_then(|kf| kinds.iter().find(|x| x.get("kind").as_str() == Some(kf)));
			let drives = st.get("confidence").as_str() == Some("high") && (structured || kd.is_some_and(|k| k.get("drives").truthy() && k.get("sources").len() >= 2));
			let o = Obj::new();
			o.set("n", st.get("n"));
			o.set("action", st.get("action"));
			o.set("target", or_null(st.get("target")));
			o.set("item", or_null(st.get("item")));
			let c = st.get("count");
			o.set("count", if c.is_nullish() { V::Null } else { c });
			o.set("place", or_null(st.get("place")));
			o.set("fact", st.get("fact"));
			o.set("confidence", or_null(st.get("confidence")));
			o.set("drives", drives);
			o.set("_source", or_null(st.get("source")));
			o.set("_evidence", arr(ev_steps.get(&st.get("n").to_js_string()).cloned().unwrap_or_default().iter().map(|x| s(x)).collect()));
			steps.push(o);
		}
		let pq = pl.get(&id);
		if pq.truthy() {
			let refuted = apply_public_mechanics(&pq, &t.get("verdicts"), &mut kinds, &mut params, &mut steps);
			bump("public", 1.0);
			if refuted > 0 {
				bump("publicRefuted", refuted as f64);
			}
		}
		let corr = corrections.get(&id);
		if corr.truthy() {
			apply_mech_correction(&corr, &mut kinds, &mut params, &steps)?;
			bump("corrected", 1.0);
		}
		let gotchas: Vec<Obj> = sq
			.get(&id)
			.get("gotchas")
			.items()
			.into_iter()
			.filter(|g| g.truthy() && g.get("fact").truthy() && g.get("confidence").as_str() != Some("low"))
			.map(|g| {
				let o = Obj::new();
				o.set("fact", g.get("fact"));
				o.set("confidence", or_null(g.get("confidence")));
				o.set("drives", false);
				o.set("_source", or_null(g.get("source")));
				o.set("_evidence", arr(ev_gotchas.get(&g.get("fact").to_js_string()).cloned().unwrap_or_default().iter().map(|x| s(x)).collect()));
				o
			})
			.collect();
		if kinds.is_empty() && steps.is_empty() && gotchas.is_empty() {
			continue;
		}
		bump("quests", 1.0);
		bump("kinds", kinds.len() as f64);
		bump("driving", kinds.iter().filter(|k| k.get("drives").truthy()).count() as f64);
		bump("steps", steps.len() as f64);
		bump("drivingSteps", steps.iter().filter(|k| k.get("drives").truthy()).count() as f64);
		bump("gotchas", gotchas.len() as f64);
		let e = Obj::new();
		e.set("kinds", arr(kinds.iter().cloned().map(V::Obj).collect()));
		if !params.is_empty() {
			e.set("params", arr(params.iter().cloned().map(V::Obj).collect()));
		}
		if !tdb_facts.is_empty() {
			e.set("server", arr(tdb_facts));
		}
		// The mechanics file keeps its shape: the provenance (`_source`, `_evidence`) goes only into the
		// KB's steps table.
		let bare = |o: &Obj| -> V {
			let b = Obj::new();
			for (k, v) in o.entries() {
				if !k.starts_with('_') {
					b.set_str(k, v);
				}
			}
			V::Obj(b)
		};
		if !steps.is_empty() {
			e.set("steps", arr(steps.iter().map(bare).collect()));
		}
		if !gotchas.is_empty() {
			e.set("gotchas", arr(gotchas.iter().map(bare).collect()));
		}
		out.set(&id, e);
		let sc = |v: V| -> V {
			match v {
				V::Undef | V::Null => V::Null,
				V::Obj(_) | V::Arr(_) => s(&stringify(&v, None)),
				o => o,
			}
		};
		for k in &kinds {
			let srcs: Vec<String> = k.get("sources").items().iter().map(V::to_js_string).collect();
			rk.push(vec![
				V::Num(idn),
				k.get("kind"),
				s("kept"),
				s(&srcs.join(",")),
				k.get("confidence"),
				V::Num(if k.get("drives").truthy() { 1.0 } else { 0.0 }),
				s(&stringify(&k.get("sources"), None)),
			]);
		}
		for st in &steps {
			let tg = st.get("target");
			let it = st.get("item");
			rs.push(vec![
				V::Num(idn),
				sc(st.get("n")),
				sc(st.get("action")),
				if tg.truthy() { sc(tg.get("type")) } else { V::Null },
				if tg.truthy() { sc(tg.get("id")) } else { V::Null },
				if it.truthy() { sc(it.get("id")) } else { V::Null },
				sc(st.get("count")),
				if st.get("place").truthy() { s(&stringify(&st.get("place"), None)) } else { V::Null },
				sc(st.get("fact")),
				sc(st.get("confidence")),
				V::Num(if st.get("drives").truthy() { 1.0 } else { 0.0 }),
				sc(st.get("_source")),
				s(&stringify(&st.get("_evidence"), None)),
			]);
		}
		for g in &gotchas {
			rs.push(vec![
				V::Num(idn),
				V::Null,
				s("gotcha"),
				V::Null,
				V::Null,
				V::Null,
				V::Null,
				V::Null,
				g.get("fact"),
				g.get("confidence"),
				V::Num(0.0),
				sc(g.get("_source")),
				s(&stringify(&g.get("_evidence"), None)),
			]);
		}
	}
	Ok(Mech { out, counts, kinds: rk, steps: rs })
}

/// A quest's entry of the public mechanics layer, merged over the private layers by their rules: a
/// kind gains the source `public` (its own source group), and is high and drives as any kind does
/// (high, or two source groups agreeing); a kind the server refutes is not added (-> how many);
/// params join a kept kind as the private ones do; a step replaces the step with its `n` or is
/// added, and drives as a private step does (high, and a driving kind two sources agree on).
fn apply_public_mechanics(p: &V, verdicts: &V, kinds: &mut Vec<Obj>, params: &mut Vec<Obj>, steps: &mut Vec<Obj>) -> usize {
	let mut refuted = 0;
	for k in p.get("kinds").items() {
		let kname = k.get("kind").to_js_string();
		if verdicts.get(&kname).as_str() == Some("refuted") {
			refuted += 1;
			continue;
		}
		let pc = k.get("confidence").as_str().unwrap_or("medium").to_string();
		match kinds.iter().find(|x| x.get("kind").as_str() == Some(&kname)) {
			Some(had) => {
				let mut srcs: Vec<String> = had.get("sources").items().iter().map(V::to_js_string).collect();
				if !srcs.iter().any(|x| x == "public") {
					srcs.push("public".into());
				}
				srcs.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
				let mut groups: Vec<String> = Vec::new();
				for x in &srcs {
					let g = group_of(x);
					if !groups.contains(&g) {
						groups.push(g);
					}
				}
				let was = had.get("confidence").to_js_string();
				let confidence = if was == "high" || (groups.len() >= 2 && pc == "high" && was != "low") { "high" } else { was.as_str() };
				had.set("confidence", confidence);
				had.set("sources", arr(srcs.iter().map(|x| s(x)).collect()));
				had.set("drives", confidence == "high" || groups.len() >= 2);
			}
			None => {
				let confidence = if matches!(pc.as_str(), "high" | "low") { pc.as_str() } else { "medium" };
				let o = Obj::new();
				o.set("kind", kname.as_str());
				o.set("confidence", confidence);
				o.set("sources", arr(vec![s("public")]));
				o.set("drives", confidence == "high");
				kinds.push(o);
			}
		}
	}
	let drive_kind = |kinds: &[Obj], k: &str| kinds.iter().find(|x| x.get("kind").as_str() == Some(k)).map(|x| x.get("drives").truthy());
	for pp in p.get("params").items() {
		let pk = pp.get("kind").to_js_string();
		let Some(dk) = drive_kind(kinds, &pk) else { continue };
		let item = pp.get("item");
		let item = if item.is_nullish() { V::Null } else { item };
		let row = Obj::new();
		for (k, v) in pp.entries() {
			if !matches!(&*k, "source" | "confidence" | "note") {
				row.set_str(k, v);
			}
		}
		row.set("source", "public");
		row.set("drives", dk && pp.get("confidence").as_str() != Some("low"));
		match params.iter().position(|x| {
			x.get("kind").as_str() == Some(&pk) && {
				let xi = x.get("item");
				(if xi.is_nullish() { V::Null } else { xi }).strict_eq(&item)
			}
		}) {
			Some(i) => params[i] = row,
			None => params.push(row),
		}
	}
	let or_null = |v: V| if v.truthy() { v } else { V::Null };
	for st in p.get("steps").items() {
		let action = st.get("action").to_js_string();
		let kind_for = match action.as_str() {
			"summon" => Some("summon-by-item"),
			"use" => Some(if st.get("place").truthy() { "use-item-at-place" } else { "use-item-on-mob" }),
			"escort" => Some("escort"),
			"interact" => Some("object-click"),
			"buy" => Some("vendor-buy"),
			"make" => Some("crafted"),
			_ => None,
		};
		let kd = kind_for.and_then(|kf| kinds.iter().find(|x| x.get("kind").as_str() == Some(kf)));
		let drives = st.get("confidence").as_str() == Some("high") && kd.is_some_and(|k| k.get("drives").truthy() && k.get("sources").len() >= 2);
		let o = Obj::new();
		o.set("n", st.get("n"));
		o.set("action", st.get("action"));
		o.set("target", or_null(st.get("target")));
		o.set("item", or_null(st.get("item")));
		let c = st.get("count");
		o.set("count", if c.is_nullish() { V::Null } else { c });
		o.set("place", or_null(st.get("place")));
		o.set("fact", st.get("fact"));
		o.set("confidence", or_null(st.get("confidence")));
		o.set("drives", drives);
		o.set("_source", "public");
		o.set("_evidence", V::arr());
		let n = st.get("n").to_js_string();
		match steps.iter().position(|x| x.get("n").to_js_string() == n) {
			Some(i) => steps[i] = o,
			None => steps.push(o),
		}
	}
	steps.sort_by(|a, b| a.get("n").num().partial_cmp(&b.get("n").num()).unwrap_or(std::cmp::Ordering::Equal));
	refuted
}

fn apply_mech_correction(c: &V, kinds: &mut Vec<Obj>, params: &mut Vec<Obj>, steps: &[Obj]) -> Result<(), String> {
	for p in c.get("params").items() {
		let pk = p.get("kind").to_js_string();
		if let Some(k) = kinds.iter().find(|x| x.get("kind").as_str() == Some(&pk)) {
			let mut srcs: Vec<String> = k.get("sources").items().iter().map(V::to_js_string).collect();
			if !srcs.iter().any(|x| x == "correction") {
				srcs.push("correction".into());
			}
			srcs.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
			k.set("confidence", "high");
			k.set("sources", arr(srcs.iter().map(|x| s(x)).collect()));
			k.set("drives", true);
		} else {
			let o = Obj::new();
			o.set("kind", pk.as_str());
			o.set("confidence", "high");
			o.set("sources", arr(vec![s("correction")]));
			o.set("drives", true);
			kinds.push(o);
		}
		let item = p.get("item");
		let item = if item.is_nullish() { V::Null } else { item };
		let row = Obj::new();
		for (k, v) in p.entries() {
			row.set_str(k, v);
		}
		row.set("source", "correction");
		row.set("drives", true);
		match params.iter().position(|x| {
			x.get("kind").as_str() == Some(&pk) && {
				let xi = x.get("item");
				(if xi.is_nullish() { V::Null } else { xi }).strict_eq(&item)
			}
		}) {
			Some(i) => params[i] = row,
			None => params.push(row),
		}
	}
	for (n, st) in c.get("steps").entries() {
		let Some(s0) = steps.iter().find(|x| x.get("n").to_js_string() == *n) else { return Err(format!("mechanics correction: no step {n} to correct")) };
		s0.set("confidence", "high");
		s0.set("drives", true);
		s0.set("_source", "correction");
		for (k, v) in st.get("set").entries() {
			s0.set_str(k, v);
		}
	}
	Ok(())
}

fn sql_val(v: &V) -> rusqlite::types::Value {
	use rusqlite::types::Value as Q;
	match v {
		V::Undef | V::Null => Q::Null,
		V::Bool(b) => Q::Integer(*b as i64),
		V::Num(n) if n.is_nan() => Q::Null,
		V::Num(n) if n.fract() == 0.0 && n.abs() < 9.2e18 => Q::Integer(*n as i64),
		V::Num(n) => Q::Real(*n),
		V::Str(t) => Q::Text(t.to_string()),
		o => Q::Text(o.to_js_string()),
	}
}
fn write_kb(
	file: &Path,
	kb: &Kb,
	quests: &Obj,
	npcs: &Obj,
	objects: &Obj,
	items: &Obj,
	verify: &[V],
	mech: &Mech,
	tdb: Option<&V>,
	training: Option<&V>,
	trainers: Option<&V>,
	versions: &IndexMap<String, Option<String>>,
) -> Result<(), String> {
	std::fs::create_dir_all(file.parent().unwrap()).map_err(|e| e.to_string())?;
	let tmp = PathBuf::from(format!("{}.tmp", file.display()));
	let _ = std::fs::remove_file(&tmp);
	let mut db = rusqlite::Connection::open(&tmp).map_err(|e| format!("{}: {e}", tmp.display()))?;
	let e = |x: rusqlite::Error| x.to_string();
	db.execute_batch(
		"pragma journal_mode=off; pragma synchronous=off;
create table sources(name text primary key, tier real, label text, version text);
create table facts(kind text, id integer, field text, value text, source text, confidence text, agree integer, total integer, primary key(kind, id, field));
create table alternatives(kind text, id integer, field text, source text, value text, agrees integer);
create table quests(id integer primary key, title text, level integer, min_level integer, max_level integer, races text, classes integer, xp integer, next integer, time_limit integer, zone integer, sources text);
create table objectives(quest integer, idx integer, type text, target integer, count integer, text text);
create table givers(quest integer, role text, kind text, ent integer);
create table npcs(id integer primary key, name text, subname text, level integer, level_max integer, faction text, rank integer, sources text);
create table objects(id integer primary key, name text, sources text);
create table items(id integer primary key, name text, quest_item integer, duration integer, sources text);
create table spawns(kind text, id integer, map integer, frame text, x real, y real);
create table drops(item integer, kind text, ent integer, chance real);
create table vendors(npc integer, item integer, source text);
create table trainers(npc integer, class text, source text);
create table training(class text, level integer, copper integer, source text);
create table mechanics(quest integer, kind text, status text, source text, confidence text, drives integer, sources text);
create table steps(quest integer, n integer, action text, target_kind text, target integer, item integer, count integer, place text, fact text, confidence text, drives integer, source text, evidence text);
create table verify_in_game(rank integer, kind text, id integer, name text, yards integer, conflicts text);
create table changes(tbl text, id integer, field text, before text, after text, source text);",
	)
	.map_err(e)?;
	let tx = db.transaction().map_err(e)?;
	{
		let run = |sql: &str, rows: &mut dyn Iterator<Item = Vec<V>>| -> Result<(), String> {
			let mut st = tx.prepare(sql).map_err(e)?;
			for r in rows {
				st.execute(rusqlite::params_from_iter(r.iter().map(sql_val))).map_err(e)?;
			}
			Ok(())
		};
		let bh = tdb.map(|t| format!("{} {}", t.get("meta").get("release").to_js_string(), t.get("meta").get("branchHead").to_js_string().chars().take(12).collect::<String>()));
		run(
			"insert into sources values (?,?,?,?)",
			&mut TIERS.iter().map(|(name, tier)| {
				let ver = versions.get(*name).cloned().flatten().filter(|v| !v.is_empty()).or_else(|| if name.starts_with("tdb") { bh.clone() } else { None });
				vec![s(name), V::Num(*tier), s(label(name)), ver.map(|v| s(&v)).unwrap_or(V::Null)]
			}),
		)?;
		run("insert or replace into facts values (?,?,?,?,?,?,?,?)", &mut kb.fact_rows.iter().cloned())?;
		run("insert into alternatives values (?,?,?,?,?,?)", &mut kb.alt_rows.iter().cloned())?;
		let nn = |v: V| if v.is_nullish() { V::Null } else { v };
		let mut qrows = Vec::new();
		let mut orows = Vec::new();
		let mut grows = Vec::new();
		for q in quests.values() {
			let id = q.get("id");
			let races = q.get("races");
			qrows.push(vec![
				id.clone(),
				nn(q.get("title")),
				nn(q.get("level")),
				nn(q.get("minLevel")),
				nn(q.get("maxLevel")),
				if races.is_nullish() { V::Null } else { s(&races.to_js_string()) },
				nn(q.get("classes")),
				nn(q.get("xp")),
				nn(q.get("next")),
				nn(q.get("limit")),
				nn(q.get("zone")),
				s(&stringify(&or_arr(q.get("source")), None)),
			]);
			for (i, o) in q.get("objectives").items().iter().enumerate() {
				orows.push(vec![id.clone(), V::Num(i as f64), o.get("type"), nn(o.get("id")), nn(o.get("count")), nn(o.get("text"))]);
			}
			for role in ["start", "end"] {
				for kind in ["npc", "object", "item"] {
					for x in q.get(role).get(kind).items() {
						grows.push(vec![id.clone(), s(role), s(kind), x]);
					}
				}
			}
		}
		run("insert into quests values (?,?,?,?,?,?,?,?,?,?,?,?)", &mut qrows.into_iter())?;
		run("insert into objectives values (?,?,?,?,?,?)", &mut orows.into_iter())?;
		run("insert into givers values (?,?,?,?)", &mut grows.into_iter())?;
		let mut nrows = Vec::new();
		let mut srows = Vec::new();
		for (kind, table) in [("npc", npcs), ("object", objects)] {
			for e in table.values() {
				if kind == "npc" {
					nrows.push(vec![
						e.get("id"),
						nn(e.get("name")),
						nn(e.get("subName")),
						nn(e.get("level")),
						nn(e.get("levelMax")),
						nn(e.get("faction")),
						nn(e.get("rank")),
						s(&stringify(&or_arr(e.get("source")), None)),
					]);
				}
				for (map, sp) in e.get("spawns").entries() {
					let f = sp.get("f");
					for p in sp.get("pts").items().into_iter().chain(sp.get("more").items()) {
						srows.push(vec![s(kind), e.get("id"), V::Num(forge_guide::js::str_to_num(&map)), if f.truthy() { f.clone() } else { s("e") }, p.at(0), p.at(1)]);
					}
				}
			}
		}
		run("insert into npcs values (?,?,?,?,?,?,?,?)", &mut nrows.into_iter())?;
		run("insert into spawns values (?,?,?,?,?,?)", &mut srows.into_iter())?;
		run("insert into objects values (?,?,?)", &mut objects.values().into_iter().map(|e| vec![e.get("id"), nn(e.get("name")), s(&stringify(&or_arr(e.get("source")), None))]))?;
		let mut irows = Vec::new();
		let mut drows = Vec::new();
		let mut vrows = Vec::new();
		for it in items.values() {
			irows.push(vec![it.get("id"), nn(it.get("name")), V::Num(if it.get("questItem").truthy() { 1.0 } else { 0.0 }), nn(it.get("duration")), s(&stringify(&or_arr(it.get("source")), None))]);
			for kind in ["npc", "object"] {
				for (ent, c) in it.get("drops").get(kind).entries() {
					drows.push(vec![it.get("id"), s(kind), V::Num(forge_guide::js::str_to_num(&ent)), c]);
				}
			}
			for v in it.get("vendors").items() {
				vrows.push(vec![v, it.get("id"), s("data")]);
			}
		}
		if let Some(t) = tdb {
			for (npc, list) in t.get("vendors").entries() {
				for item in list.items() {
					vrows.push(vec![V::Num(forge_guide::js::str_to_num(&npc)), item, s("tdb")]);
				}
			}
		}
		run("insert into items values (?,?,?,?,?)", &mut irows.into_iter())?;
		run("insert into drops values (?,?,?,?)", &mut drows.into_iter())?;
		run("insert into vendors values (?,?,?)", &mut vrows.into_iter())?;
		let mut trows = Vec::new();
		if let Some(t) = trainers {
			for e in t.values() {
				let srcs: Vec<String> = e.get("sources").items().iter().map(V::to_js_string).collect();
				for c in e.get("classes").items() {
					trows.push(vec![e.get("id"), c, s(&srcs.join(","))]);
				}
			}
		}
		run("insert into trainers values (?,?,?)", &mut trows.into_iter())?;
		let mut trrows = Vec::new();
		if let Some(t) = training {
			for (cls, per) in t.get("classes").entries() {
				for (lvl, cu) in per.entries() {
					trrows.push(vec![s(&cls), V::Num(forge_guide::js::str_to_num(&lvl)), cu, t.get("source")]);
				}
			}
		}
		run("insert into training values (?,?,?,?)", &mut trrows.into_iter())?;
		run("insert into mechanics values (?,?,?,?,?,?,?)", &mut mech.kinds.iter().cloned())?;
		run("insert into steps values (?,?,?,?,?,?,?,?,?,?,?,?,?)", &mut mech.steps.iter().cloned())?;
		run(
			"insert into verify_in_game values (?,?,?,?,?,?)",
			&mut verify.iter().map(|e| vec![e.get("rank"), e.get("kind"), e.get("id"), nn(e.get("name")), e.get("yards"), s(&stringify(&e.get("conflicts"), None))]),
		)?;
		run(
			"insert into changes values (?,?,?,?,?,?)",
			&mut kb.changes.iter().map(|c| {
				let j = |v: &V| utf16_slice(&stringify(if v.is_undef() { &V::Null } else { v }, None), 4000);
				vec![s(c.table), V::Num(c.id), s(&c.field), s(&j(&c.from)), s(&j(&c.to)), s(&c.source)]
			}),
		)?;
	}
	tx.commit().map_err(e)?;
	db.execute_batch("create index alt_key on alternatives(kind, id, field); create index obj_q on objectives(quest); create index giv_q on givers(quest); create index sp_id on spawns(kind, id); create index dr_item on drops(item); create index st_q on steps(quest); create index me_q on mechanics(quest)").map_err(e)?;
	drop(db);
	std::fs::rename(&tmp, file).map_err(|e| e.to_string())?;
	Ok(())
}

pub fn mechanics_source() -> V {
	let o = Obj::new();
	o.set("name", "Polestar quest mechanics: kinds, parameters and steps (facts in our own words), checked against the Forever TrinityCore world DB");
	o.set("url", V::Null);
	o.set("license", "Polestar original work; structured facts from CMaNGOS classic-db (GPL-3.0) and the Forever TrinityCore world DB (GPL-2.0) used as facts");
	o.set("copyright", "TrinityCore and the advocaite/TrinityCore `forever` branch; CMaNGOS (https://github.com/cmangos/classic-db)");
	V::Obj(o)
}

#[cfg(test)]
mod tests {
	#[test]
	fn kb_credits_name_eg_link_and_factoruide_when_their_facts_win() {
		let used = |s: &str| s == "eg" || s == "factoruide";
		let c = kb_credits(&used, true, true, true);
		let names: Vec<String> = c.iter().map(|v| v.get("name").to_js_string()).collect();
		assert_eq!(names.len(), 2, "{names:?}");
		assert!(names[0].starts_with("EG Link"));
		assert!(c[0].get("copyright").to_js_string().contains("CC BY 4.0"));
		assert!(names[1].starts_with("Factoruide"));
		assert!(kb_credits(&|_| false, true, true, true).is_empty());
		assert!(kb_credits(&used, false, false, false).is_empty());
	}

	use super::*;

	fn kind(k: &str, conf: &str, sources: &[&str], drives: bool) -> Obj {
		let o = Obj::new();
		o.set("kind", k);
		o.set("confidence", conf);
		o.set("sources", arr(sources.iter().map(|x| s(x)).collect()));
		o.set("drives", drives);
		o
	}

	#[test]
	fn public_mechanics_merge_by_the_private_rules() {
		let p = parse_json(
			r#"{
				"kinds": [
					{ "kind": "object-click", "confidence": "high" },
					{ "kind": "summon-by-item" },
					{ "kind": "escort", "confidence": "high" }
				],
				"params": [{ "kind": "object-click", "item": 5, "objects": [7] }, { "kind": "timed", "sec": 60 }],
				"steps": [
					{ "n": 2, "action": "interact", "target": { "type": "object", "id": 7 }, "fact": "Open the crate.", "confidence": "high" },
					{ "n": 3, "action": "turnin", "fact": "Hand it in.", "confidence": "high" }
				],
				"note": "test"
			}"#,
		)
		.unwrap();
		let verdicts = parse_json(r#"{ "escort": "refuted" }"#).unwrap();
		let mut kinds = vec![kind("object-click", "medium", &["server"], false)];
		let mut params = Vec::new();
		let step = Obj::new();
		step.set("n", 2.0);
		step.set("action", "kill");
		let mut steps = vec![step];
		let refuted = apply_public_mechanics(&p, &verdicts, &mut kinds, &mut params, &mut steps);
		assert_eq!(refuted, 1, "the server refutes escort: not added");
		// A kind two source groups agree on, one of them high: high, drives.
		let oc = &kinds[0];
		assert_eq!(oc.get("confidence").as_str(), Some("high"));
		assert!(oc.get("drives").truthy());
		assert_eq!(stringify(&oc.get("sources"), None), r#"["public","server"]"#);
		// A public-only kind keeps its own confidence (default medium) and does not drive alone.
		let sb = &kinds[1];
		assert_eq!((sb.get("kind").as_str(), sb.get("confidence").as_str(), sb.get("drives").truthy()), (Some("summon-by-item"), Some("medium"), false));
		assert_eq!(kinds.len(), 2);
		// Params join a kept kind only.
		assert_eq!(params.len(), 1);
		assert_eq!(params[0].get("source").as_str(), Some("public"));
		assert!(params[0].get("drives").truthy());
		// Step 2 replaced, step 3 added; a step drives when its kind drives and two sources agree.
		assert_eq!(steps.len(), 2);
		assert_eq!(steps[0].get("action").as_str(), Some("interact"));
		assert!(steps[0].get("drives").truthy());
		assert!(!steps[1].get("drives").truthy());
	}

	fn fact_of(alt: &Alt, key: &str, field: &str, source: &str) -> Option<String> {
		alt.facts.get(key)?.iter().find(|f| f.field == field && f.source == source).map(|f| f.value.to_js_string())
	}

	#[test]
	fn client_sources_rank_and_encode() {
		// Tiers: the caches beside eg (and they decide races), the tables at 1.0 for their fields
		// only.
		assert_eq!((tier_of("client.cache", "title"), tier_of("client.cache", "xp"), tier_of("client.cache", "objectives")), (1.5, 1.5, 1.5));
		assert!(decides_verify("races", tier_of("client.cache", "races")));
		assert!(tier_of("client.cache", "level") < tier_of("page", "level"));
		assert!(tier_of("tdb", "level") <= tier_of("client.cache", "level"));
		for f in ["start_place", "end_place", "objective_place:0", "objective_trigger:1", "in_client", "name", "duration", "quest_item", "start_quest", "placement"] {
			assert_eq!(tier_of("client", f), 1.0, "{f}");
		}
		for f in ["title", "level", "xp", "objectives", "races", "start", "end", "npc_level"] {
			assert_eq!(tier_of("client", f), 9.0, "{f}");
		}
		assert!(TIERS.iter().any(|(n, _)| *n == "client") && TIERS.iter().any(|(n, _)| *n == "client.cache"));
		assert!(!check_only("client") && !check_only("client.cache") && captured("client.cache"));

		let obj = |t: &str| parse_json(t).unwrap().as_obj().unwrap().clone();
		let quests = obj(r#"{"1221": {"id": 1221, "classes": null, "objectives": [{"type": "event", "id": 98, "count": null, "map": 1436}]}}"#);
		let items = obj(r#"{"10441": {"id": 10441}}"#);
		let objects = obj(r#"{"179000": {"id": 179000}}"#);
		let fv = parse_json(r#"{"1436": {"c": 0, "left": 1000, "right": -1000, "top": 0, "bottom": -2000}, "1415": {"c": 0, "left": 5000, "right": -5000, "top": 5000, "bottom": -5000}}"#).unwrap();

		// client.cache: the quest record through the EG path, plus the title; creatures and objects.
		let mut cache = crate::client::Cache { build: "1.60.1.70450".into(), ..Default::default() };
		cache.quests.insert(
			1221,
			EgQuest {
				build: Some(70450.0),
				level: Some(26.0),
				min_level: Some(20.0),
				xp_difficulty: Some(5.0),
				xp_multiplier: Some(2.375),
				xp: Some(5000.0),
				start_item: Some(6755.0),
				races: Some((RACE_A).to_string()),
				objectives: vec![("kill".into(), Some(4128.0), Some(8.0)), ("item".into(), Some(6755.0), Some(1.0)), ("event".into(), Some(98.0), Some(1.0)), ("event".into(), None, Some(1.0))],
				..Default::default()
			},
		);
		cache.titles.insert(1221, "Blueleaf Tubers".into());
		cache.npcs.insert(3434, crate::client::CacheNpc { name: "Gamon".into(), subname: String::new(), rank: 1 });
		cache.objects.insert(179000, "Chest".into());
		let mut alt = add_extra_facts(None, None, None, Some(&cache), &quests);
		let q = |f: &str| fact_of(&alt, "quest:1221", f, "client.cache");
		assert_eq!(q("title").as_deref(), Some("Blueleaf Tubers"));
		assert_eq!((q("level").as_deref(), q("min_level").as_deref(), q("xp").as_deref()), (Some("26"), Some("20"), Some("5000")));
		// The starting item is no objective; an area trigger is an event with its id, a criteria
		// tree one without.
		assert_eq!(q("objectives").as_deref(), Some("c:4128:8;e:98:1;e:?:1"));
		assert_eq!((q("races").as_deref(), q("side").as_deref()), (Some("alliance"), Some("A")));
		assert_eq!(fact_of(&alt, "npc:3434", "name", "client.cache").as_deref(), Some("Gamon"));
		assert_eq!(fact_of(&alt, "npc:3434", "subname", "client.cache"), None);
		assert_eq!(fact_of(&alt, "npc:3434", "rank", "client.cache").as_deref(), Some("1"));
		assert_eq!(fact_of(&alt, "object:179000", "name", "client.cache").as_deref(), Some("Chest"));
		assert_eq!(alt.versions.get("client.cache").cloned().flatten().as_deref(), Some("1.60.1.70450"));

		// client: places in our frames (the smaller frame holding a point), triggers, items, objects.
		let mut t = crate::client::Tables { build: Some("1.60.1.70532".into()), ..Default::default() };
		let area = |pts: Vec<(f64, f64)>| crate::client::Area { ui_map: 1436, pts };
		let mut p = crate::client::Places { start: vec![area(vec![(-1000.0, 0.0)])], ..Default::default() };
		p.objectives.insert(0, vec![area(vec![(-500.0, 500.0), (-1500.0, 0.0)]), crate::client::Area { ui_map: 9999, pts: vec![(1.0, 1.0)] }]);
		t.places.insert(1221, p);
		t.places.insert(5, crate::client::Places { start: vec![area(vec![(0.0, 0.0)])], ..Default::default() });
		t.triggers.insert(98, crate::client::Trigger { map: 0, x: -400.0, y: 200.0, radius: 30.0, box_size: None });
		t.quests.extend([1221, 5]);
		t.items.insert(10441, crate::client::Item { name: "Glowing Shard".into(), duration: Some(3600.0), quest_item: Some(true), start_quest: Some(6981) });
		t.items.insert(2454, crate::client::Item { name: "Elixir".into(), ..Default::default() });
		t.objects.insert(179000, vec![(0, -1000.0, 0.0), (0, 4000.0, 4000.0), (1, 0.0, 0.0)]);
		add_client_facts(&mut alt, &t, &fv, &quests, &items, &objects);
		let c = |k: &str, f: &str| fact_of(&alt, k, f, "client");
		assert_eq!(c("quest:1221", "start_place").as_deref(), Some(r#"[{"map":1436,"f":"l","pts":[[50,50]]}]"#));
		assert_eq!(c("quest:1221", "end_place"), None);
		assert_eq!(c("quest:1221", "objective_place:0").as_deref(), Some(r#"[{"map":1436,"f":"l","pts":[[25,25],[50,75]]}]"#));
		assert_eq!(c("quest:1221", "objective_trigger:0").as_deref(), Some(r#"{"trigger":98,"map":1436,"f":"l","x":40,"y":20,"radius":30}"#));
		assert_eq!(c("quest:1221", "in_client").as_deref(), Some("yes"));
		// Quests and items we lack get no facts.
		assert!(!alt.facts.contains_key("quest:5") && !alt.facts.contains_key("item:2454"));
		assert_eq!((c("item:10441", "name").as_deref(), c("item:10441", "duration").as_deref()), (Some("Glowing Shard"), Some("3600")));
		assert_eq!((c("item:10441", "quest_item").as_deref(), c("item:10441", "start_quest").as_deref()), (Some("yes"), Some("6981")));
		// A point outside every frame of its continent is dropped.
		assert_eq!(c("object:179000", "placement").as_deref(), Some("1436:50,50 1415:10,10"));
		assert_eq!(alt.versions.get("client").cloned().flatten().as_deref(), Some("1.60.1.70532"));
	}
}
