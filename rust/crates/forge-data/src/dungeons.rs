//! `dungeons build` (port of tools/lib/data/dungeonjournal.js and tools/commands/dungeons.js):
//! data/forever/dungeons.json from the installed ForeverDungeonJournal addon (no licence: read
//! locally, the output stays local) and data/forever. Only facts are taken (ids, names, levels,
//! coordinates, rewards, chains); none of its prose.

use std::path::{Path, PathBuf};

use forge_guide::data::Data;
use forge_guide::js::{stringify, Obj, V};
use forge_guide::{arr, obj};
use indexmap::{IndexMap, IndexSet};
use regex::Regex;
use std::sync::LazyLock;

use crate::jsv::{round2, to_int32};

pub const FOLDER: &str = "ForeverDungeonJournal";
const DATA_FILES: [&str; 9] = ["Dungeons", "DungeonEntrances", "DungeonRoutes", "Bosses", "QuestMaps", "QuestChains", "QuestRewards", "QuestShareability", "QuestUpdates"];
const CONSTANTS: [(&str, &str); 1] = [("ALBA_FAIRMOON_LOCATION", "Alba Fairmoon, Sentinel Hill inn, Westfall")];

/// `<questId>:start|end` -> (map, x, y, f, npc, note, ref): positions found by hand.
const WEB_POSITIONS: [(&str, f64, f64, f64, &str, &str, &str, &str); 1] =
	[("95189:end", 1453.0, 80.21, 38.35, "l", "Lady Dena Kennedy", "In the Royal Gallery of Stormwind Keep", "npcs.json npc 1748")];

const ABBREVIATIONS: [(&str, &[&str]); 14] = [
	("Hall of Thanes", &["HoT"]),
	("Ragefire Chasm", &["RFC"]),
	("Ruins of Lordaeron", &["RoL"]),
	("The Deadmines", &["DM", "VC", "Deadmines"]),
	("Wailing Caverns", &["WC"]),
	("Shadowfang Keep", &["SFK"]),
	("Blackfathom Deeps", &["BFD"]),
	("Excavation Site: Wetlands", &["Excavation"]),
	("The Stockade", &["Stocks", "Stockade"]),
	("City of Dalaran", &["Dalaran"]),
	("Gnomeregan", &["Gnomer"]),
	("Razorfen Kraul", &["RFK"]),
	("Scarlet Monastery: Graveyard", &["SM", "GY"]),
	("Scarlet Monastery: Library", &["SM", "Lib"]),
];

const CLASS_BITS: [(&str, i32); 9] = [("WARRIOR", 1), ("PALADIN", 2), ("HUNTER", 4), ("ROGUE", 8), ("PRIEST", 16), ("SHAMAN", 64), ("MAGE", 128), ("WARLOCK", 256), ("DRUID", 1024)];

fn faction_races(side: &str) -> i32 {
	forge_guide::races::FACTION_RACES.iter().find(|(s, _)| *s == side).map(|(_, m)| *m as i32).unwrap_or(0)
}

macro_rules! re {
	($name:ident, $pat:expr) => {
		static $name: LazyLock<Regex> = LazyLock::new(|| Regex::new($pat).unwrap());
	};
}
re!(TOC_LINE, r"^##\s*(Title|Version|Author|Interface)\s*:\s*(.*?)\s*$");
re!(PARENS_SPACED, r"\s*\(.*?\)\s*");
re!(PARENS, r"\(.*?\)");
re!(NOT_NAME, r"(?i)^(item start|use |follow |keep |you |stone tablet|the quest|drops?|found|dropped|extra-destructive)");
re!(WS, r"\s+");
re!(INSIDE, r"(?-u:\b)inside(?-u:\b)");
re!(AT_ENTRANCE, r"(?i)(?-u:\b)(near|by|at) the (dungeon|instance) (entrance|portal)(?-u:\b)|(?-u:\b)near the dungeon entrance(?-u:\b)");
re!(SUBNAME, r":\s*(.+)$");
re!(LEVEL_RANGE, r"^([0-9]+)\s*-\s*([0-9]+)$");
re!(DIGITS, r"^[0-9]+$");
re!(MONEY_PART, r"(?i)^([0-9][0-9,]*\s*[gsc]\s*)+$");
re!(MONEY, r"(?i)([0-9][0-9,]*)\s*([gsc])");
re!(DROPS, r"(?i)inside|drops? from|dropped by");
re!(SLUG_NON, r"[^a-z0-9]+");

/// The installed addon folder: `source` when given (None when not a folder), else the first
/// AddOns folder holding it.
pub fn find_dungeon_journal(source: Option<&Path>) -> Option<PathBuf> {
	match source {
		Some(s) => s.is_dir().then(|| s.to_path_buf()),
		None => crate::questie::find_installed_addon(FOLDER),
	}
}

/// `## Key: value` lines of the addon's TOC -> { title, version, author, interface }.
pub fn read_toc(dir: &Path) -> Obj {
	let out = Obj::new();
	let Ok(text) = std::fs::read_to_string(dir.join(format!("{FOLDER}.toc"))) else { return out };
	for line in text.split('\n') {
		let line = line.strip_suffix('\r').unwrap_or(line);
		if let Some(m) = TOC_LINE.captures(line) {
			out.set(&m[1].to_lowercase(), &m[2]);
		}
	}
	out
}

/// A Lua string literal for any text (non-printable bytes as \ddd).
fn lua_string(s: &str) -> String {
	let mut out = String::from("\"");
	for b in s.bytes() {
		if b == 0x22 || b == 0x5c {
			out.push('\\');
			out.push(b as char);
		} else if (0x20..0x7f).contains(&b) {
			out.push(b as char);
		} else {
			out.push_str(&format!("\\{b}"));
		}
	}
	out.push('"');
	out
}

/// Runs the data files under Lua 5.1 the way the client does -> the namespace without Constants.
pub fn load_dungeon_journal(dir: &Path) -> Result<V, String> {
	let files: Vec<PathBuf> = DATA_FILES.iter().map(|f| dir.join("Data").join(format!("{f}.lua"))).collect();
	let missing: Vec<String> = files.iter().filter(|f| !f.exists()).map(|f| f.strip_prefix(dir).unwrap_or(f).to_string_lossy().to_string()).collect();
	if !missing.is_empty() {
		return Err(format!("DungeonJournal at {} is missing {}", dir.display(), missing.join(", ")));
	}
	let constants: Vec<String> = CONSTANTS.iter().map(|(k, v)| format!("{k} = {}", lua_string(v))).collect();
	let list: Vec<String> = files.iter().map(|f| lua_string(&f.to_string_lossy())).collect();
	let prelude = format!(
		"\nlocal __ns = {{ Constants = {{ {} }} }}\nForeverDungeonJournal_NS = __ns\nForeverDungeonJournal = __ns\nfor _, p in ipairs({{ {} }}) do\n  local ok, err = __polestar_loaddata(p, {}, __ns)\n  if not ok then error(err, 0) end\nend\n__dj = __ns",
		constants.join(", "),
		list.join(", "),
		lua_string(FOLDER)
	);
	crate::lua::lua_to_value(&[], &prelude, "local t = {} for k, v in pairs(__dj) do if k ~= \"Constants\" then t[k] = v end end return t")
}

// --- Lua-shaped values -------------------------------------------------------

/// A Lua sequence as a list: arrays stay, objects with integer keys come back in key order.
fn list(v: &V) -> Vec<V> {
	match v {
		V::Arr(_) => v.items(),
		V::Obj(o) => {
			let mut ks: Vec<(f64, V)> = o.entries().into_iter().filter(|(k, _)| !k.is_empty() && k.bytes().all(|b| b.is_ascii_digit())).map(|(k, v)| (k.parse::<f64>().unwrap(), v)).collect();
			ks.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());
			ks.into_iter().map(|(_, v)| v).collect()
		}
		_ => Vec::new(),
	}
}

fn by_id(table: &V, id: f64) -> V {
	if !table.is_object() {
		return V::Undef;
	}
	table.get(&forge_guide::js::num_str(id))
}

fn pct(v: &V) -> f64 {
	round2(v.num() * 100.0)
}

/// `String(v || '')`.
fn text(v: &V) -> String {
	if v.truthy() {
		v.to_js_string()
	} else {
		String::new()
	}
}

fn num_or_null(n: f64) -> V {
	if n.is_nan() || n == 0.0 {
		V::Null
	} else {
		V::Num(n)
	}
}

pub fn slug(name: &str) -> String {
	let s = name.to_lowercase();
	let s = s.strip_prefix("the ").unwrap_or(&s).replace(['\'', '’'], "");
	let s = SLUG_NON.replace_all(&s, "-");
	let s = s.strip_prefix('-').unwrap_or(&s);
	s.strip_suffix('-').unwrap_or(s).to_string()
}

fn level_range(v: &V) -> V {
	let s = text(v);
	match LEVEL_RANGE.captures(s.trim()) {
		Some(m) => V::Obj(obj! { "min" => m[1].parse::<f64>().unwrap(), "max" => m[2].parse::<f64>().unwrap() }),
		None => V::Null,
	}
}

fn boss_level(v: &V) -> V {
	if v.is_nullish() || v.as_str() == Some("") {
		return V::Null;
	}
	let r = level_range(v);
	if r.truthy() {
		return r;
	}
	let s = v.to_js_string();
	if DIGITS.is_match(&s) {
		V::Num(forge_guide::js::str_to_num(&s))
	} else {
		V::Null
	}
}

fn item_list(v: &V) -> Vec<V> {
	let mut out = Vec::new();
	for t in list(v) {
		let a = list(&t);
		let g = |i: usize| a.get(i).cloned().unwrap_or(V::Undef);
		if !(g(0).num() > 0.0) {
			continue;
		}
		let it = obj! { "item" => g(0).num(), "name" => text(&g(1)) };
		let q = g(2).num();
		if q.is_finite() && q == q.trunc() {
			it.set("quality", q);
		}
		if g(3).num() > 1.0 {
			it.set("count", g(3).num());
		}
		out.push(V::Obj(it));
	}
	out
}

/// Money in copper from a reward summary ("1g 50s  •  Ironforge +100"), or null.
pub fn parse_money(v: &V) -> V {
	for part in text(v).split(['•', '\n']) {
		let t = part.trim();
		if !MONEY_PART.is_match(t) {
			continue;
		}
		let mut copper = 0.0;
		for m in MONEY.captures_iter(t) {
			let n = forge_guide::js::str_to_num(&m[1].replace(',', ""));
			copper += match m[2].to_lowercase().as_str() {
				"g" => n * 10000.0,
				"s" => n * 100.0,
				_ => n,
			};
		}
		if copper > 0.0 {
			return V::Num(copper);
		}
	}
	V::Null
}

// --- quest positions ---------------------------------------------------------

/// The NPC a pickup/turn-in text names: the part before the first comma, when it reads like a name.
pub fn npc_name_of(v: &V) -> Option<String> {
	let t = text(v);
	let head = t.split(',').next().unwrap_or("");
	let head = PARENS_SPACED.replace_all(head, " ");
	let head = head.trim();
	if head.is_empty() || NOT_NAME.is_match(head) {
		return None;
	}
	if !head.starts_with(|c: char| c.is_ascii_uppercase()) || WS.split(head).count() > 5 {
		return None;
	}
	Some(head.to_string())
}

fn dungeon_words(name: &str) -> Vec<String> {
	let l = name.to_lowercase();
	let mut w = vec![l.clone(), l.strip_prefix("the ").unwrap_or(&l).to_string(), "the dungeon".into(), "the instance".into()];
	if let Some(m) = SUBNAME.captures(name) {
		let sub = m[1].to_lowercase();
		w.push(format!("the {sub}"));
		w.push(sub);
	}
	w
}

pub fn says_inside(v: &V, dungeon: &str) -> bool {
	let t = text(v).to_lowercase();
	if !INSIDE.is_match(&t) {
		return false;
	}
	dungeon_words(dungeon).iter().any(|w| t.contains(&format!("inside {w}")))
}

fn says_at_entrance(v: &V) -> bool {
	AT_ENTRANCE.is_match(&text(v))
}

fn zone_hint(data: &Data, v: &V) -> V {
	let t = text(v);
	let mut parts: Vec<String> = t.split(',').skip(1).map(|s| PARENS.replace_all(s, "").trim().to_string()).filter(|s| !s.is_empty()).collect();
	parts.reverse();
	for part in parts {
		let mut z = data.zone_named(&part);
		if !z.truthy() {
			z = data.zone_named(&format!("{part} City"));
		}
		if z.truthy() {
			return V::Obj(obj! { "map" => z.get("zone").get("id") });
		}
	}
	V::Null
}

struct NameIndex {
	by_name: IndexMap<String, Vec<V>>,
	dj: IndexMap<String, V>,
}

impl NameIndex {
	fn new(data: &Data) -> Self {
		let mut by_name: IndexMap<String, Vec<V>> = IndexMap::new();
		for n in data.npcs.values() {
			if !n.truthy() || !n.get("name").truthy() || !n.get("spawns").truthy() || n.get("spawns").keys().is_empty() {
				continue;
			}
			by_name.entry(n.get("name").to_js_string().to_lowercase()).or_default().push(n.get("id"));
		}
		NameIndex { by_name, dj: IndexMap::new() }
	}
	fn add_dj(&mut self, e: &V) {
		if !e.truthy() || e.get("mapID").is_undef() {
			return;
		}
		let tn = e.get("targetName");
		let name = if tn.truthy() { tn.to_js_string() } else { text(&e.get("label")).split(" — ").next().unwrap_or("").trim().to_string() };
		if name.is_empty() {
			return;
		}
		self.dj.entry(name.to_lowercase()).or_insert_with(|| e.clone());
	}
	fn npcs(&self, name: Option<&str>) -> Vec<V> {
		name.and_then(|n| self.by_name.get(&n.to_lowercase()).cloned()).unwrap_or_default()
	}
	fn dj_entry(&self, name: Option<&str>) -> V {
		name.and_then(|n| self.dj.get(&n.to_lowercase()).cloned()).unwrap_or(V::Null)
	}
}

fn dj_point(e: &V, source: &str, kind: &str, name: V) -> V {
	V::Obj(obj! { "map" => e.get("mapID").num(), "x" => pct(&e.get("x")), "y" => pct(&e.get("y")), "f" => "l", "source" => source, "kind" => kind, "name" => name })
}

struct Boss {
	name: String,
	npc: V,
	aliases: Vec<String>,
	loot: Vec<V>,
	out: V,
}

struct Ctx<'a> {
	name: String,
	entrance: V,
	bosses: Vec<Boss>,
	data: &'a Data,
	names: &'a NameIndex,
	details: V,
	start_maps: V,
	shareable: V,
	coverage: IndexMap<String, f64>,
	unresolved: Vec<(String, f64, &'static str)>,
}

fn spread(dst: &Obj, src: &V) {
	for (k, v) in src.entries() {
		dst.set(&k, v);
	}
}

/// A chain in doing order: DungeonJournal's list, with every prerequisite our data names put
/// before the quest that needs it, recursively. The quest itself is left out.
fn with_data_pre(data: &Data, dj_chain: &[f64], id: f64, side: &V) -> Vec<f64> {
	fn add(data: &Data, qid: f64, id: f64, dj_chain: &[f64], side: &V, out: &mut Vec<f64>, visiting: &mut IndexSet<u64>) {
		if out.contains(&qid) || visiting.contains(&qid.to_bits()) {
			return;
		}
		visiting.insert(qid.to_bits());
		let q = our_quest(data, qid);
		let pre: Vec<f64> = if q.truthy() && q.get("pre").is_arr() { q.get("pre").items().iter().map(|p| p.num()).filter(|p| *p > 0.0).collect() } else { Vec::new() };
		if !pre.is_empty() && !pre.iter().any(|p| out.contains(p)) {
			let takes = |pq: &V| !pq.truthy() || !side.truthy() || race_ok(pq, &side.to_js_string());
			let pick = pre.iter().find(|p| dj_chain.contains(p)).or_else(|| pre.iter().find(|p| takes(&our_quest(data, **p))));
			if let Some(&p) = pick {
				add(data, p, id, dj_chain, side, out, visiting);
			}
		}
		visiting.shift_remove(&qid.to_bits());
		if qid != id {
			out.push(qid);
		}
	}
	let mut out = Vec::new();
	let mut visiting = IndexSet::new();
	for &c in dj_chain {
		add(data, c, id, dj_chain, side, &mut out, &mut visiting);
	}
	add(data, id, id, dj_chain, side, &mut out, &mut visiting);
	out
}

fn race_ok(q: &V, side: &str) -> bool {
	if !q.truthy() || q.get("races").is_nullish() {
		return true;
	}
	let mask = faction_races(if side == "Alliance" { "Alliance" } else { "Horde" });
	(to_int32(q.get("races").num()) & mask) != 0
}

fn classes_of(mask: &V) -> V {
	let m = mask.num();
	if !(m > 0.0) {
		return V::Null;
	}
	let out: Vec<V> = CLASS_BITS.iter().filter(|(_, b)| to_int32(m) & b != 0).map(|(c, _)| V::from(*c)).collect();
	if !out.is_empty() && out.len() < CLASS_BITS.len() {
		V::from(out)
	} else {
		V::Null
	}
}

fn faction_of(v: &V) -> V {
	match v.as_str() {
		Some("Alliance") | Some("Horde") => v.clone(),
		_ => V::Null,
	}
}

/// Our quest record, never the copy dungeons.json feeds into the data.
fn our_quest(data: &Data, id: f64) -> V {
	let q = data.quest(&V::Num(id));
	if !q.truthy() {
		return V::Null;
	}
	let src = q.get("source");
	if src.is_arr() && src.len() == 1 && src.at(0).as_str() == Some("dungeonjournal") {
		return V::Null;
	}
	q
}

fn spawn_point(data: &Data, cands: &[V], hint: &V, source: &str, name: &V) -> V {
	let zone_map = if hint.truthy() { hint.get("map") } else { V::Null };
	let prev = if hint.truthy() && !hint.get("x").is_undef() { hint.clone() } else { V::Null };
	let p = forge_guide::resolve::pick_spawn(data, cands, &zone_map, &prev, &[], None, false, f64::NAN);
	if !p.truthy() || p.get("map").is_undef() {
		return V::Null;
	}
	if hint.truthy() && source == "data-npc" && !strict_eq(&p.get("map"), &hint.get("map")) {
		return V::Null;
	}
	let cand = p.get("cand");
	let kind = cand.get("kind").to_js_string();
	let e = if kind == "npc" { data.npc(&cand.get("id")) } else { data.object(&cand.get("id")) };
	let nm = if e.truthy() && e.get("name").truthy() { V::from(e.get("name").to_js_string()) } else { name.clone() };
	V::Obj(obj! {
		"map" => p.get("map"), "x" => p.get("x"), "y" => p.get("y"),
		"f" => if p.get("f").as_str() == Some("e") { "e" } else { "l" },
		"source" => source, "kind" => kind, "id" => cand.get("id"), "name" => nm,
	})
}

fn strict_eq(a: &V, b: &V) -> bool {
	match (a, b) {
		(V::Num(x), V::Num(y)) => x == y,
		(V::Str(x), V::Str(y)) => x == y,
		(V::Null, V::Null) | (V::Undef, V::Undef) => true,
		(V::Bool(x), V::Bool(y)) => x == y,
		_ => false,
	}
}

fn opt_name(n: &Option<String>) -> V {
	n.as_ref().map(|s| V::from(s.as_str())).unwrap_or(V::Null)
}

/// Where a quest starts or ends (see dungeonjournal.js place()).
fn place(id: f64, which: &str, info: &V, ctx: &Ctx) -> V {
	let data = ctx.data;
	let start = which == "start";
	let q = our_quest(data, id);
	let txt = if start { info.get("pickup") } else { info.get("turnin") };
	let npc_name = npc_name_of(&txt);
	let own = if start {
		let a = info.get("startMap");
		if a.truthy() {
			a
		} else {
			let b = by_id(&ctx.start_maps, id);
			if b.truthy() {
				b
			} else {
				info.get("map")
			}
		}
	} else {
		info.get("turninMap")
	};
	let dj_entry = if own.truthy() && !own.get("mapID").is_undef() { own } else { ctx.names.dj_entry(npc_name.as_deref()) };
	let dj = if dj_entry.truthy() {
		let tn = dj_entry.get("targetName");
		let nm = match &npc_name {
			Some(n) if !n.is_empty() => V::from(n.as_str()),
			_ => {
				if tn.truthy() {
					tn
				} else {
					V::Null
				}
			}
		};
		dj_point(&dj_entry, "dj", "npc", nm)
	} else {
		V::Null
	};
	let ids = if q.truthy() {
		let x = if start { q.get("start") } else { q.get("end") };
		if x.truthy() {
			x
		} else {
			V::obj()
		}
	} else {
		V::obj()
	};
	let mut cands: Vec<V> = Vec::new();
	for (kind, key) in [("npc", "npc"), ("object", "object")] {
		for i in ids.get(key).items() {
			cands.push(V::Obj(obj! { "kind" => kind, "id" => i }));
		}
	}
	let name_v = opt_name(&npc_name);
	if !cands.is_empty() {
		let p = spawn_point(data, &cands, &dj, "data", &name_v);
		if p.truthy() {
			return p;
		}
	}
	let entrance = &ctx.entrance;
	let with_entrance = |pairs: &[(&str, V)]| {
		let o = Obj::new();
		spread(&o, entrance);
		for (k, v) in pairs {
			o.set(k, v.clone());
		}
		V::Obj(o)
	};
	if start {
		let si = info.get("startItem");
		let item: Option<Vec<V>> = if si.truthy() { Some(list(&si)) } else { None };
		let qi = q.get("start").get("item");
		let data_item = if q.truthy() && cands.is_empty() && (if qi.truthy() { qi.len() } else { 0 }) > 0 { qi.at(0).num() } else { f64::NAN };
		if data_item.is_finite() && data_item != 0.0 {
			let di = data.item(&V::Num(data_item));
			return V::Obj(obj! { "source" => "data", "kind" => "item", "item" => data_item, "name" => if di.truthy() { V::from(di.get("name").to_js_string()) } else { V::Null } });
		}
		if let Some(item) = &item {
			let g = |i: usize| item.get(i).cloned().unwrap_or(V::Undef);
			if g(0).num() > 0.0 {
				let iid = g(0).num();
				let iname = text(&g(1));
				if data.item(&V::Num(iid)).truthy() {
					return V::Obj(obj! { "kind" => "item", "item" => iid, "name" => iname, "source" => "data" });
				}
				if entrance.truthy() && (says_inside(&txt, &ctx.name) || says_inside(&g(3), &ctx.name) || DROPS.is_match(&text(&g(3)))) {
					return with_entrance(&[("kind", V::from("item")), ("item", V::Num(iid)), ("name", V::from(iname)), ("source", V::from("entrance")), ("inDungeon", V::Bool(true))]);
				}
			}
		}
		if info.get("startObject").truthy() && entrance.truthy() {
			let so = list(&info.get("startObject"));
			let nm = text(&so.first().cloned().unwrap_or(V::Undef));
			return with_entrance(&[("source", V::from("entrance")), ("kind", V::from("object")), ("name", V::from(nm)), ("inDungeon", V::Bool(true))]);
		}
	}
	if entrance.truthy() && (says_inside(&txt, &ctx.name) || (start && info.get("startsInDungeon").truthy() && npc_name.as_deref().is_none_or(str::is_empty))) {
		return with_entrance(&[("source", V::from("entrance")), ("kind", V::from("npc")), ("name", name_v.clone()), ("inDungeon", V::Bool(true))]);
	}
	let namesakes = ctx.names.npcs(npc_name.as_deref());
	let hint = if dj.truthy() { dj.clone() } else { zone_hint(data, &txt) };
	if !namesakes.is_empty() && (namesakes.len() == 1 || hint.truthy()) {
		let c: Vec<V> = namesakes.iter().map(|n| V::Obj(obj! { "kind" => "npc", "id" => n.clone() })).collect();
		let p = spawn_point(data, &c, &hint, "data-npc", &name_v);
		if p.truthy() {
			return p;
		}
	}
	if dj.truthy() {
		return dj;
	}
	let key = format!("{}:{which}", forge_guide::js::num_str(id));
	if let Some(w) = WEB_POSITIONS.iter().find(|w| w.0 == key) {
		let nm = if w.5.is_empty() { name_v.clone() } else { V::from(w.5) };
		return V::Obj(obj! { "map" => w.1, "x" => w.2, "y" => w.3, "f" => if w.4.is_empty() { "l" } else { w.4 }, "source" => "web", "kind" => "npc", "name" => nm, "note" => w.6, "ref" => w.7 });
	}
	if entrance.truthy() && says_at_entrance(&txt) {
		return with_entrance(&[("source", V::from("entrance")), ("kind", V::from("npc")), ("name", name_v)]);
	}
	V::Null
}

fn track(ctx: &mut Ctx, id: f64, which: &'static str, p: &V) {
	let key = if p.truthy() { p.get("source").to_js_string() } else { "none".into() };
	*ctx.coverage.entry(key).or_insert(0.0) += 1.0;
	if !p.truthy() {
		ctx.unresolved.push((ctx.name.clone(), id, which));
	}
}

fn xp_of(id: f64, q: &V, dj: &V, fallback: &V, o: &Obj) {
	let (xp, src) = if q.truthy() && q.get("xp").is_num() && q.get("xp").num() > 0.0 {
		(q.get("xp"), V::from("data"))
	} else {
		let fb = by_id(fallback, id).num();
		if fb > 0.0 {
			(V::Num(fb), V::from("dungeonjournal"))
		} else if dj.truthy() && dj.get("liveXPFallback").num() > 0.0 {
			(V::Num(dj.get("liveXPFallback").num()), V::from("dungeonjournal"))
		} else {
			(V::Null, V::Null)
		}
	};
	o.set("xp", xp);
	o.set("xpSource", src);
}

fn text_mentions(v: &V, b: &Boss) -> bool {
	let t = text(v).to_lowercase();
	std::iter::once(&b.name).chain(b.aliases.iter()).any(|n| !n.is_empty() && t.contains(&n.to_lowercase()))
}

fn drops_from(it: &V, b: &Boss) -> bool {
	it.truthy() && it.get("drops").truthy() && b.npc.truthy() && it.get("drops").get("npc").truthy() && !it.get("drops").get("npc").get(&b.npc.to_js_string()).is_undef()
}

/// Boss indexes whose kill (or drop) a quest's objectives need.
fn bosses_for(q: &V, dj: &V, ctx: &Ctx) -> Vec<usize> {
	let objs = if q.truthy() && q.get("objectives").truthy() { q.get("objectives").items() } else { Vec::new() };
	let mut out = Vec::new();
	for (i, b) in ctx.bosses.iter().enumerate() {
		let mut hit = false;
		for o in &objs {
			let t = o.get("type");
			if t.as_str() == Some("kill") && b.npc.truthy() && o.get("id").num() == b.npc.num() {
				hit = true;
			}
			if t.as_str() == Some("item") {
				let oid = o.get("id").num();
				if b.loot.iter().any(|l| l.get("item").num() == oid) {
					hit = true;
				}
				if drops_from(&ctx.data.item(&o.get("id")), b) {
					hit = true;
				}
			}
		}
		let obj_text = if dj.truthy() { dj.get("objective") } else { V::Undef };
		if text_mentions(&obj_text, b) {
			hit = true;
		}
		if hit {
			out.push(i);
		}
	}
	out
}

/// The boss whose drop starts a quest.
fn drop_boss(item: &Option<Vec<V>>, ctx: &Ctx) -> Option<usize> {
	let item = item.as_ref()?;
	let g = |i: usize| item.get(i).cloned().unwrap_or(V::Undef);
	let id = g(0).num();
	let it = ctx.data.item(&g(0));
	for (i, b) in ctx.bosses.iter().enumerate() {
		if b.loot.iter().any(|l| l.get("item").num() == id) {
			return Some(i);
		}
		if drops_from(&it, b) {
			return Some(i);
		}
		if text_mentions(&g(3), b) {
			return Some(i);
		}
	}
	None
}

fn rewards_of(dj: &V) -> V {
	let main = item_list(&dj.get("rewardItems"));
	let extra = item_list(&dj.get("additionalRewardItems"));
	if dj.get("rewardChoice").truthy() {
		V::Obj(obj! { "items" => V::from(extra), "choices" => V::from(main) })
	} else {
		let mut all = main;
		all.extend(extra);
		V::Obj(obj! { "items" => V::from(all), "choices" => arr![] })
	}
}

fn level_of(q: &V, fallback: &V, key: &str) -> V {
	if q.truthy() && q.get(key).num() > 0.0 {
		V::Num(q.get(key).num())
	} else {
		num_or_null(fallback.num())
	}
}

fn title_of(q: &V, fallback: &V) -> V {
	if q.truthy() && q.get("title").truthy() {
		V::from(q.get("title").to_js_string())
	} else {
		V::from(text(fallback))
	}
}

fn classes_for(class_only: &V, q: &V) -> V {
	if class_only.truthy() {
		arr![class_only.to_js_string().to_uppercase()]
	} else {
		classes_of(&if q.truthy() { q.get("classes") } else { q.clone() })
	}
}

fn shareable_of(ctx: &Ctx, id: f64) -> V {
	match by_id(&ctx.shareable, id) {
		V::Bool(b) => V::Bool(b),
		_ => V::Null,
	}
}

fn money_fallback(table: &V, id: f64) -> V {
	let n = by_id(table, id).num();
	if n > 0.0 {
		V::Num(n)
	} else {
		V::Null
	}
}

fn main_quest(dj: &V, ctx: &mut Ctx, xp_fallback: &V, money_fb: &V) -> Obj {
	let id = dj.get("id").num();
	let q = our_quest(ctx.data, id);
	let start = place(id, "start", dj, ctx);
	let end = place(id, "end", dj, ctx);
	track(ctx, id, "start", &start);
	track(ctx, id, "end", &end);
	let si = dj.get("startItem");
	let start_item: Option<Vec<V>> = if si.truthy() { Some(list(&si)) } else { None };
	let boss = drop_boss(&start_item, ctx);
	let sides: Vec<&str> = ["Alliance", "Horde"].into_iter().filter(|s| race_ok(&q, s)).collect();
	let mut faction = faction_of(&dj.get("faction"));
	if !faction.truthy() && sides.len() == 1 {
		faction = V::from(sides[0]);
	}
	let mut money = parse_money(&dj.get("rewardSummary"));
	if !money.truthy() {
		money = parse_money(&dj.get("rewards"));
	}
	if !money.truthy() {
		money = money_fallback(money_fb, id);
	}
	let o = obj! {
		"id" => id,
		"title" => title_of(&q, &dj.get("name")),
		"faction" => faction,
		"level" => level_of(&q, &dj.get("level"), "level"),
		"minLevel" => level_of(&q, &dj.get("requires"), "minLevel"),
		"classes" => classes_for(&dj.get("classOnly"), &q),
	};
	xp_of(id, &q, dj, xp_fallback, &o);
	o.set("money", money);
	o.set("rewards", rewards_of(dj));
	o.set("start", start.clone());
	o.set("end", end);
	o.set("startItem", start_item_of(&start_item));
	o.set("startBoss", boss.map(|i| V::from(ctx.bosses[i].name.as_str())).unwrap_or(V::Null));
	let near = if start.truthy() && start.get("inDungeon").truthy() && boss.is_none() {
		ctx.bosses.iter().find(|b| text_mentions(&dj.get("pickup"), b)).map(|b| V::from(b.name.as_str())).filter(|v| v.truthy()).unwrap_or(V::Null)
	} else {
		V::Null
	};
	o.set("startNear", near);
	let bosses: Vec<V> = bosses_for(&q, dj, ctx).into_iter().map(|i| V::from(ctx.bosses[i].name.as_str())).collect();
	o.set("bosses", V::from(bosses));
	o.set("inData", q.truthy());
	o.set("shareable", shareable_of(ctx, id));
	o
}

fn start_item_of(item: &Option<Vec<V>>) -> V {
	match item {
		Some(a) if a.first().is_some_and(|v| v.num() > 0.0) => V::Obj(obj! { "item" => a[0].num(), "name" => text(&a.get(1).cloned().unwrap_or(V::Undef)) }),
		_ => V::Null,
	}
}

fn chain_quest(id: f64, link: &V, ctx: &mut Ctx, xp_fallback: &V, money_fb: &V, reward_fb: &V, faction: &V) -> Obj {
	let q = our_quest(ctx.data, id);
	let det = by_id(&ctx.details, id);
	let det = if det.truthy() { det } else { V::obj() };
	let info = Obj::new();
	spread(&info, &det);
	info.set("startMap", V::Undef);
	let info = V::Obj(info);
	let start = place(id, "start", &info, ctx);
	let end = place(id, "end", &info, ctx);
	track(ctx, id, "start", &start);
	track(ctx, id, "end", &end);
	let fb = by_id(reward_fb, id);
	let rewards = obj! { "items" => arr![], "choices" => arr![] };
	if fb.truthy() {
		let items = V::from(item_list(&fb.get("items")));
		rewards.set(if fb.get("choice").truthy() { "choices" } else { "items" }, items);
	}
	let link_name = if link.truthy() { link.get("name") } else { V::Undef };
	let o = obj! {
		"id" => id,
		"title" => title_of(&q, &link_name),
		"faction" => faction.clone(),
		"level" => level_of(&q, &det.get("level"), "level"),
		"minLevel" => level_of(&q, &det.get("requires"), "minLevel"),
		"classes" => classes_for(&det.get("classOnly"), &q),
	};
	xp_of(id, &q, &V::Null, xp_fallback, &o);
	o.set("money", money_fallback(money_fb, id));
	o.set("rewards", rewards);
	o.set("start", start);
	o.set("end", end);
	let si = det.get("startItem");
	o.set("startItem", if si.truthy() { start_item_of(&Some(list(&si))) } else { V::Null });
	o.set("inData", q.truthy());
	o.set("shareable", shareable_of(ctx, id));
	o
}

pub struct Report {
	/// source -> quest ends placed by it ("none": unplaced).
	pub coverage: IndexMap<String, f64>,
	/// (dungeon, quest, "start" | "end")
	pub unresolved: Vec<(String, f64, &'static str)>,
}

fn or_obj(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::obj()
	}
}

/// dungeons.json's dataset from the loaded journal (`load_dungeon_journal`), the data and the TOC.
pub fn build_dungeons(raw: &V, data: &Data, toc: &Obj) -> (V, Report) {
	let db = or_obj(raw.get("DB"));
	let order: Vec<String> = list(&raw.get("ORDER")).into_iter().map(|n| n.to_js_string()).filter(|n| db.get(n).truthy()).collect();
	let chains = or_obj(raw.get("QUEST_PREREQ_CHAINS"));
	let details = or_obj(raw.get("QUEST_PREREQ_DETAILS"));
	let start_maps = or_obj(raw.get("QUEST_START_MAPS"));
	let xp_fallback = or_obj(raw.get("FOREVER_QUEST_XP_FALLBACK"));
	let reward_fb = or_obj(raw.get("PREREQ_REWARD_ITEMS_FALLBACK"));
	let money_fb = or_obj(raw.get("PREREQ_REWARD_MONEY_FALLBACK"));
	let boss_levels = or_obj(raw.get("BOSS_LEVELS"));
	let mut names = NameIndex::new(data);
	for e in start_maps.values() {
		names.add_dj(&e);
	}
	for d in details.values() {
		if d.truthy() {
			names.add_dj(&d.get("map"));
			names.add_dj(&d.get("turninMap"));
		}
	}
	for n in &order {
		for q in list(&db.get(n).get("quests")) {
			if q.truthy() {
				names.add_dj(&q.get("startMap"));
			}
		}
	}
	let mut home_of: IndexMap<u64, String> = IndexMap::new();
	for n in &order {
		for q in list(&db.get(n).get("quests")) {
			if q.truthy() && q.get("id").truthy() {
				home_of.entry(q.get("id").num().to_bits()).or_insert_with(|| n.clone());
			}
		}
	}
	let mut coverage = IndexMap::new();
	let mut unresolved = Vec::new();
	let shareable = or_obj(raw.get("QUEST_SHAREABILITY_AUDIT"));
	let mut dungeons = Vec::new();
	for name in &order {
		let d = db.get(name);
		let ent = d.get("entrance");
		let entrance =
			if ent.truthy() && ent.get("mapID").truthy() { V::Obj(obj! { "map" => ent.get("mapID").num(), "x" => pct(&ent.get("x")), "y" => pct(&ent.get("y")), "f" => "l" }) } else { V::Null };
		let levels_for = boss_levels.get(name);
		let bosses: Vec<Boss> = list(&d.get("bosses"))
			.into_iter()
			.filter(|b| b.truthy() && b.get("name").truthy() && !b.get("trash").truthy())
			.map(|b| {
				let bname = b.get("name").to_js_string();
				let npc = if b.get("npcID").num() > 0.0 { V::Num(b.get("npcID").num()) } else { V::Null };
				let aliases: Vec<String> = list(&b.get("aliases")).iter().map(|a| a.to_js_string()).collect();
				let level = boss_level(&if levels_for.is_object() { levels_for.get(&bname) } else { V::Undef });
				let loot: Vec<V> = list(&b.get("loot"))
					.iter()
					.map(list)
					.filter(|l| l.first().is_some_and(|v| v.num() > 0.0))
					.map(|l| {
						let g = |i: usize| l.get(i).cloned().unwrap_or(V::Undef);
						let q = g(3).num();
						V::Obj(obj! {
							"item" => g(0).num(),
							"name" => text(&g(1)),
							"slot" => if g(2).truthy() { V::from(g(2).to_js_string()) } else { V::Null },
							"quality" => if q.is_finite() && q == q.trunc() { V::Num(q) } else { V::Null },
						})
					})
					.collect();
				let out = V::Obj(obj! { "name" => bname.as_str(), "npc" => npc.clone(), "level" => level, "rare" => b.get("rare").truthy(), "loot" => V::from(loot.clone()) });
				Boss { name: bname, npc, aliases, loot, out }
			})
			.collect();
		let mut ctx = Ctx {
			name: name.clone(),
			entrance: entrance.clone(),
			bosses,
			data,
			names: &names,
			details: details.clone(),
			start_maps: start_maps.clone(),
			shareable: shareable.clone(),
			coverage: std::mem::take(&mut coverage),
			unresolved: std::mem::take(&mut unresolved),
		};
		let mut seen: IndexSet<u64> = IndexSet::new();
		let mut quests: Vec<Obj> = Vec::new();
		let chain_quests = Obj::new();
		for q in list(&d.get("quests")) {
			if !q.truthy() || !(q.get("id").num() > 0.0) || seen.contains(&q.get("id").num().to_bits()) {
				continue;
			}
			let id = q.get("id").num();
			seen.insert(id.to_bits());
			let chain_list = list(&by_id(&chains, id));
			let self_i = chain_list.iter().position(|c| c.get("id").num() == id);
			let (before, after): (Vec<V>, Vec<V>) = match self_i {
				Some(i) => (chain_list[..i].to_vec(), chain_list[i + 1..].to_vec()),
				None => (chain_list.clone(), Vec::new()),
			};
			let real = |c: &V| c.truthy() && c.get("id").num() > 0.0 && !c.get("itemStep").truthy() && c.get("id").num() < 1_000_000.0;
			let entry = main_quest(&q, &mut ctx, &xp_fallback, &money_fb);
			let dj_chain: Vec<f64> = before.iter().filter(|c| real(c)).map(|c| c.get("id").num()).collect();
			let chain = with_data_pre(data, &dj_chain, id, &entry.get("faction"));
			let follow: Vec<f64> = after.iter().filter(|c| real(c)).map(|c| c.get("id").num()).collect();
			entry.set("chain", V::from(chain.iter().map(|n| V::Num(*n)).collect::<Vec<_>>()));
			entry.set("followUps", V::from(follow.iter().map(|n| V::Num(*n)).collect::<Vec<_>>()));
			let steps: Vec<V> = before.iter().filter(|c| c.truthy() && !real(c)).map(|c| V::from(c.get("name").to_js_string())).collect();
			if !steps.is_empty() {
				entry.set("itemSteps", V::from(steps));
			}
			if q.get("hideFromMainList").truthy() {
				entry.set("hidden", true);
			}
			let faction = entry.get("faction");
			for cid in chain.iter().chain(follow.iter()) {
				let key = forge_guide::js::num_str(*cid);
				if !chain_quests.get(&key).truthy() {
					let link = chain_list.iter().find(|c| c.get("id").num() == *cid).cloned().unwrap_or(V::Undef);
					let cq = chain_quest(*cid, &link, &mut ctx, &xp_fallback, &money_fb, &reward_fb, &faction);
					chain_quests.set(&key, cq);
				}
				if let Some(home) = home_of.get(&cid.to_bits()) {
					if home != name {
						chain_quests.get(&key).set("dungeon", slug(home));
					}
				}
			}
			quests.push(entry);
		}
		let lv = level_range(&d.get("level"));
		let lv = if lv.truthy() { lv } else { V::Obj(obj! { "min" => 1.0, "max" => 60.0 }) };
		let factions: Vec<V> = ["Alliance", "Horde"]
			.into_iter()
			.filter(|s| quests.iter().any(|q| !q.get("hidden").truthy() && (!q.get("faction").truthy() || q.get("faction").as_str() == Some(s))))
			.map(V::from)
			.collect();
		let zone_name = if entrance.truthy() {
			let z = data.zone(&entrance.get("map"));
			if z.truthy() {
				V::from(z.get("name").to_js_string())
			} else {
				V::Null
			}
		} else {
			V::Null
		};
		let abbr: Vec<V> = ABBREVIATIONS.iter().find(|(n, _)| n == name).map(|(_, a)| a.iter().map(|s| V::from(*s)).collect()).unwrap_or_default();
		dungeons.push(V::Obj(obj! {
			"key" => slug(name),
			"name" => name.as_str(),
			"levels" => lv,
			"zone" => if entrance.truthy() { entrance.get("map") } else { V::Null },
			"zoneName" => zone_name,
			"entrance" => entrance,
			"abbreviations" => V::from(abbr),
			"factions" => V::from(factions),
			"bosses" => V::from(ctx.bosses.iter().map(|b| b.out.clone()).collect::<Vec<_>>()),
			"quests" => V::from(quests.into_iter().map(V::Obj).collect::<Vec<_>>()),
			"chainQuests" => chain_quests,
		}));
		coverage = ctx.coverage;
		unresolved = ctx.unresolved;
	}
	let tv = |k: &str| {
		let v = toc.get(k);
		if v.truthy() {
			v
		} else {
			V::Null
		}
	};
	let dataset = V::Obj(obj! {
		"source" => V::Obj(obj! { "name" => "DungeonJournal", "addon" => FOLDER, "title" => tv("title"), "version" => tv("version"), "author" => tv("author"), "license" => V::Null }),
		"dungeons" => V::from(dungeons),
	});
	(dataset, Report { coverage, unresolved })
}

/// `dungeons build`: dungeons.json's text from the addon folder (`source`, else the installed one)
/// and data/forever (`data_dir`). -> (text, dungeon count, report)
pub fn run(source: Option<&Path>, data_dir: &Path) -> Result<(String, usize, Report), String> {
	let dir = find_dungeon_journal(source).ok_or_else(|| format!("dungeons: {FOLDER} not found{}", source.map(|s| format!(" at {}", s.display())).unwrap_or_default()))?;
	let toc = read_toc(&dir);
	let raw = load_dungeon_journal(&dir)?;
	let data = forge_guide::data::load_data(data_dir)?;
	let (dataset, report) = build_dungeons(&raw, &data, &toc);
	let n = dataset.get("dungeons").len();
	Ok((format!("{}\n", stringify(&dataset, Some("\t"))), n, report))
}
