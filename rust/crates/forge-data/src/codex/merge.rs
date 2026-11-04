//! build.js `mergeCodex(inputs)` for a release build (no AtlasLoot, RareScanner or
//! dungeons.json): data/forever + the client facts + the cached web facts + ForeverLevelingBiS +
//! the curated tables -> the Codex.

use std::collections::BTreeSet;

use forge_guide::js::{str_to_num, Obj, V};
use forge_guide::races::CLASSES;
use rustc_hash::{FxHashMap, FxHashSet};

use super::instances::{build_instances, Ctx};
use super::spawns::{spawns_of, spawns_v};
use super::util::{by_num, int, junk, key, kstr, math_round, norm_name, nums, oentries, opt, or_m1, ord, round1, slug};
use super::Inputs;

const RANK: [(&str, f64); 13] = [
	("recordings", 0.0),
	("client", 1.0),
	("curated", 2.0),
	("guides", 3.0),
	("questie", 4.0),
	("flbis", 4.0),
	("rarescanner", 4.0),
	("dungeons", 4.0),
	("journal", 4.0),
	("forever", 4.0),
	("pfquest", 5.0),
	("atlasloot", 5.0),
	("web", 6.0),
];
const RANK_UNKNOWN: f64 = 7.0;
const TYPE_ORDER: [&str; 10] = ["vendor", "quest", "gift", "craft", "rep", "pvp", "drop", "object", "container", "world"];
const WORLD_DROP_NPCS: usize = 12;
const LOOT_CAP: usize = 150;
const SERVICE_ROLES: [&str; 11] = ["vendor", "repair", "innkeeper", "banker", "auctioneer", "flightmaster", "battlemaster", "spirithealer", "stablemaster", "trainer", "weapon"];
const STANDING_FLOOR: [f64; 8] = [-42000.0, -6000.0, -3000.0, 0.0, 3000.0, 9000.0, 21000.0, 42000.0];

fn rank(f: &str) -> Option<f64> {
	RANK.iter().find(|(n, _)| *n == f).map(|(_, r)| *r)
}

fn key_field(ty: &str) -> Option<&'static str> {
	match ty {
		"vendor" | "drop" | "gift" => Some("npc"),
		"object" => Some("object"),
		"quest" => Some("quest"),
		"craft" => Some("spell"),
		"rep" => Some("faction"),
		"container" => Some("item"),
		_ => None,
	}
}

fn source_fields(ty: &str) -> &'static [&'static str] {
	match ty {
		"vendor" => &["npc", "cost", "limited"],
		"drop" => &["npc", "chance", "instance"],
		"object" => &["object", "chance"],
		"quest" => &["quest", "choice"],
		"gift" => &["npc", "spell"],
		"craft" => &["spell", "skillLine", "profession", "skill"],
		"rep" => &["faction", "standing", "npc"],
		"pvp" => &["rank", "npc"],
		"container" => &["item", "chance"],
		"world" => &["minLevel", "maxLevel"],
		_ => &[],
	}
}

fn cap(ty: &str) -> Option<usize> {
	match ty {
		"drop" => Some(10),
		"object" => Some(6),
		"vendor" => Some(10),
		"container" => Some(6),
		_ => None,
	}
}

fn is_service(role: &str) -> bool {
	SERVICE_ROLES.contains(&role)
}

/// `fromLabels(list)`.
fn from_labels(list: &V) -> Vec<String> {
	let mut out: Vec<String> = Vec::new();
	let mut add = |s: &str| {
		if !out.iter().any(|x| x == s) {
			out.push(s.to_string());
		}
	};
	for s in list.items() {
		let s = s.to_js_string();
		if s.starts_with("questie") {
			add("questie");
		} else if s == "pfquest" {
			add("pfquest");
		} else if s.starts_with("record") {
			add("recordings");
		} else if rank(&s).is_some() {
			add(&s);
		}
	}
	if out.is_empty() {
		out.push("forever".into());
	}
	out
}

fn from_v(list: &[String]) -> V {
	V::from(list.iter().map(|s| V::str(s)).collect::<Vec<V>>())
}

fn from_of(s: &V) -> Vec<String> {
	s.get("from").items().iter().map(V::to_js_string).collect()
}

fn sort_from(from: Vec<String>) -> Vec<String> {
	let mut u: Vec<String> = Vec::new();
	for f in from {
		if !u.contains(&f) {
			u.push(f);
		}
	}
	u.sort_by(|a, b| {
		let d = rank(a).unwrap_or(RANK_UNKNOWN) - rank(b).unwrap_or(RANK_UNKNOWN);
		if d != 0.0 {
			ord(d)
		} else if a < b {
			std::cmp::Ordering::Less
		} else {
			std::cmp::Ordering::Greater
		}
	});
	u
}

fn standing_of(value: f64) -> f64 {
	let mut s = 1.0;
	for (i, f) in STANDING_FLOOR.iter().enumerate() {
		if value >= *f {
			s = (i + 1) as f64;
		}
	}
	s
}

/// `questRep(q)` -> (faction, standing).
pub fn quest_rep(q: &V) -> Option<(V, f64)> {
	let mut best: Option<(V, f64)> = None;
	if !q.truthy() {
		return None;
	}
	for r in [q.get("minRep"), q.get("reputation")] {
		if !r.truthy() || !r.get("faction").truthy() || !r.get("value").is_num() {
			continue;
		}
		let standing = standing_of(r.get("value").num());
		if standing <= 1.0 {
			continue;
		}
		if best.as_ref().is_none_or(|b| standing > b.1) {
			best = Some((r.get("faction"), standing));
		}
	}
	best
}

fn side_of(side: &V) -> V {
	match side {
		V::Str(s) if &**s == "Alliance" || &**s == "A" => V::str("A"),
		V::Str(s) if &**s == "Horde" || &**s == "H" => V::str("H"),
		V::Num(n) if *n == 1.0 => V::str("A"),
		V::Num(n) if *n == 2.0 => V::str("H"),
		_ => V::Null,
	}
}

fn faction_of_races(races: &V) -> V {
	let Some(r) = int(races).filter(|r| *r != 0.0) else { return V::Null };
	let r = crate::jsv::to_int32(r);
	// FACTION_RACES: Alliance 1|4|8|64 = 77, Horde 2|16|32|128 = 178.
	let a = r & 77 != 0;
	let h = r & 178 != 0;
	if a && !h {
		V::str("A")
	} else if h && !a {
		V::str("H")
	} else {
		V::Null
	}
}

/// `new RegExp(`\\b${word}\\b`).test(s)` for an ASCII word.
fn has_word(s: &str, word: &str) -> bool {
	let wc = |c: u8| c.is_ascii_alphanumeric() || c == b'_';
	let b = s.as_bytes();
	let mut from = 0;
	while let Some(p) = s[from..].find(word) {
		let at = from + p;
		let end = at + word.len();
		let before = at == 0 || !wc(b[at - 1]);
		let after = end == b.len() || !wc(b[end]);
		if before && after && !word.is_empty() {
			return true;
		}
		from = at + 1;
		while from < s.len() && !s.is_char_boundary(from) {
			from += 1;
		}
		if from >= s.len() {
			break;
		}
	}
	false
}

/// A candidate source: `{ type, ...fields, from }` (from: an array shared by an input's candidates).
#[derive(Clone)]
pub struct Cand {
	pub ty: &'static str,
	f: [(&'static str, V); 4],
	from: V,
}

impl Cand {
	fn get(&self, k: &str) -> V {
		self.f.iter().find(|(n, _)| !n.is_empty() && *n == k).map(|(_, v)| v.clone()).unwrap_or(V::Undef)
	}
	fn set(&mut self, k: &'static str, v: V) {
		match self.f.iter_mut().find(|(n, _)| *n == k) {
			Some(e) => e.1 = v,
			None => {
				let slot = self.f.iter_mut().find(|(n, _)| n.is_empty()).expect("codex: a candidate source has at most four fields");
				*slot = (k, v);
			}
		}
	}
	fn rank(&self) -> f64 {
		match &self.from {
			V::Arr(a) => a.0.borrow().iter().map(|f| f.as_str().and_then(rank).unwrap_or(RANK_UNKNOWN)).fold(f64::INFINITY, f64::min),
			_ => f64::INFINITY,
		}
	}
}

fn src(ty: &'static str, fields: &[(&'static str, V)], from: &V) -> Cand {
	let mut f: [(&'static str, V); 4] = Default::default();
	for (slot, field) in f.iter_mut().zip(fields) {
		*slot = field.clone();
	}
	Cand { ty, f, from: from.clone() }
}

fn nonnull(v: &V) -> bool {
	!matches!(v, V::Undef | V::Null | V::Bool(false))
}

/// `sortFrom(list.flatMap((c) => c.from))`.
fn sort_from_cands<'a>(srcs: impl Iterator<Item = &'a Cand>) -> Vec<String> {
	let mut u: Vec<forge_guide::js::Str> = Vec::new();
	for s in srcs {
		if let V::Arr(a) = &s.from {
			for f in a.0.borrow().iter() {
				let f = f.as_rc_str().unwrap_or_else(|| f.to_js_string().into());
				if !u.contains(&f) {
					u.push(f);
				}
			}
		}
	}
	sort_from(u.iter().map(|s| s.to_string()).collect())
}

/// `finalizeSources(cands, npcLevel, isBoss, onCut)`; onCut gets each cut source's type and npc.
fn finalize_sources(cands: &[&Cand], npc_level: &dyn Fn(&V) -> Option<(f64, f64)>, is_boss: &dyn Fn(&V) -> bool, on_cut: &mut dyn FnMut(&str, &V)) -> Vec<Obj> {
	// `${c.type}|${c[kf]}`: numbers by value (a string spelling one is the same key).
	#[derive(PartialEq, Eq, Hash)]
	enum K {
		Num(u64),
		Str(String),
	}
	let mut groups: Vec<Vec<&Cand>> = Vec::new();
	let mut gix: FxHashMap<(&'static str, K), usize> = FxHashMap::default();
	for c in cands {
		let kv = key_field(c.ty).map(|kf| c.get(kf)).unwrap_or(V::str(""));
		let k = match kv {
			V::Num(n) => K::Num(if n == 0.0 { 0 } else { n.to_bits() }),
			v => {
				let s = v.to_js_string();
				let n = str_to_num(&s);
				if !s.is_empty() && forge_guide::js::num_str(n) == s {
					K::Num(if n == 0.0 { 0 } else { n.to_bits() })
				} else {
					K::Str(s)
				}
			}
		};
		match gix.entry((c.ty, k)) {
			std::collections::hash_map::Entry::Occupied(e) => groups[*e.get()].push(c),
			std::collections::hash_map::Entry::Vacant(e) => {
				e.insert(groups.len());
				groups.push(vec![c]);
			}
		}
	}
	// Merged sources: (type, fields, the group's candidates by rank).
	struct M<'a> {
		ty: &'static str,
		f: Vec<(&'static str, V)>,
		list: Vec<&'a Cand>,
		world_from: Option<Vec<String>>,
	}
	impl M<'_> {
		fn get(&self, k: &str) -> V {
			self.f.iter().find(|(n, _)| *n == k).map(|(_, v)| v.clone()).unwrap_or(V::Undef)
		}
	}
	let mut out: Vec<M> = Vec::new();
	for list in groups {
		let mut ranked: Vec<(f64, &Cand)> = list.into_iter().map(|c| (c.rank(), c)).collect();
		ranked.sort_by(|a, b| ord(a.0 - b.0));
		let ty = ranked[0].1.ty;
		let mut f = Vec::new();
		for name in source_fields(ty) {
			for (_, c) in &ranked {
				let v = c.get(name);
				if nonnull(&v) {
					f.push((*name, v));
					break;
				}
			}
		}
		out.push(M { ty, f, list: ranked.into_iter().map(|(_, c)| c).collect(), world_from: None });
	}
	let drops: Vec<usize> = (0..out.len()).filter(|&i| out[i].ty == "drop").collect();
	if drops.len() > WORLD_DROP_NPCS && !out.iter().any(|s| s.ty == "world") {
		let levels: Vec<(f64, f64)> = drops.iter().filter_map(|&i| npc_level(&out[i].get("npc"))).collect();
		if !levels.is_empty() {
			let from = sort_from_cands(drops.iter().flat_map(|&i| out[i].list.iter().copied()));
			let f = vec![("minLevel", V::Num(levels.iter().map(|l| l.0).fold(f64::INFINITY, f64::min))), ("maxLevel", V::Num(levels.iter().map(|l| l.1).fold(f64::NEG_INFINITY, f64::max)))];
			out.push(M { ty: "world", f, list: Vec::new(), world_from: Some(from) });
		}
	}
	// (type index, chance ?? -1, instance ? 1 : 0, key) per source, then the JS comparator.
	let mut keyed: Vec<(f64, f64, f64, f64, M)> = out
		.into_iter()
		.map(|s| {
			let tix = TYPE_ORDER.iter().position(|t| *t == s.ty).map(|i| i as f64).unwrap_or(-1.0);
			let k = match key_field(s.ty) {
				Some(kf) => {
					let n = s.get(kf).num();
					if n.is_nan() {
						0.0
					} else {
						n
					}
				}
				None => 0.0,
			};
			let inst = if s.get("instance").truthy() { 1.0 } else { 0.0 };
			(tix, or_m1(&s.get("chance")), inst, k, s)
		})
		.collect();
	let or = |d: f64, next: &dyn Fn() -> f64| if d != 0.0 && !d.is_nan() { d } else { next() };
	keyed.sort_by(|a, b| ord(or(a.0 - b.0, &|| or(b.1 - a.1, &|| or(b.2 - a.2, &|| a.3 - b.3)))));
	let mut seen: FxHashMap<&'static str, usize> = FxHashMap::default();
	let mut kept = Vec::new();
	for (.., s) in keyed {
		let n = seen.entry(s.ty).or_insert(0);
		*n += 1;
		let keep = cap(s.ty).is_none_or(|c| *n <= c) || (s.ty == "drop" && s.get("instance").truthy() && is_boss(&s.get("npc")));
		if !keep {
			on_cut(s.ty, &s.get("npc"));
			continue;
		}
		let o = Obj::new();
		o.set("type", s.ty);
		for (k, v) in &s.f {
			o.set(k, v.clone());
		}
		let from = match s.world_from {
			Some(f) => f,
			None => sort_from_cands(s.list.iter().copied()),
		};
		o.set("from", from_v(&from));
		kept.push(o);
	}
	kept
}

fn objective_of(o: &V, escort: bool, tame: bool) -> V {
	let out = Obj::new();
	out.set("type", o.get("type"));
	let nn = |v: V| if v.is_nullish() { V::Null } else { v };
	out.set("id", nn(o.get("id")));
	out.set("count", nn(o.get("count")));
	out.set("text", nn(o.get("text")));
	if tame && o.get("type").as_str() == Some("kill") {
		out.set("tame", true);
	}
	let fin = |v: V| matches!(v, V::Num(n) if n.is_finite());
	if o.get("type").as_str() == Some("event") && !escort && int(&o.get("map")).is_some_and(|m| m != 0.0) && fin(o.get("x")) && fin(o.get("y")) {
		out.set("map", int(&o.get("map")).unwrap());
		out.set("x", round1(o.get("x").num()));
		out.set("y", round1(o.get("y").num()));
		if o.get("f").truthy() {
			out.set("f", o.get("f"));
		}
	}
	V::Obj(out)
}

fn tames_with_rod(q: &V) -> bool {
	let t = q.get("objectiveText");
	let t = if t.truthy() { t.to_js_string() } else { String::new() };
	let lower = t.to_ascii_lowercase();
	// /\bTaming Rod to tame\b/i
	has_word(&lower, "taming rod to tame")
}

pub struct Merged {
	pub items: Obj,
	pub npcs: Obj,
	pub objects: Obj,
	pub quests: Obj,
	pub instances: Obj,
	pub zones: Obj,
	pub factions: Obj,
	pub spells: Obj,
	pub frames: Obj,
	/// evidence.noPvp, evidence.cut.{drop, rare, treasure} (parity's).
	pub no_pvp: Vec<f64>,
	pub cut_drop: Obj,
	pub cut_rare: Obj,
	pub cut_treasure: Obj,
	pub warnings: Vec<String>,
}

/// An ordered set of strings (JS Set).
#[derive(Default, Clone)]
struct OSet(Vec<String>);

impl OSet {
	fn add(&mut self, s: &str) {
		if !self.0.iter().any(|x| x == s) {
			self.0.push(s.to_string());
		}
	}
	fn has(&self, s: &str) -> bool {
		self.0.iter().any(|x| x == s)
	}
	fn delete(&mut self, s: &str) {
		self.0.retain(|x| x != s);
	}
}

pub fn merge_codex(inputs: &Inputs) -> Merged {
	let fv = &inputs.forever;
	let al = inputs.atlasloot.as_ref();
	let rs = inputs.rarescanner.as_ref();
	let dungeon_list: Vec<V> = fv.dungeons.get("dungeons").items();
	let flb = inputs.flbis.as_ref();
	let cl = inputs.client.as_ref();
	let zones_in = &fv.zones;
	let frames_in = &fv.map_frames;
	let mut warnings: Vec<String> = Vec::new();
	let empty = V::obj();

	// ----- zones, factions
	let zones = Obj::new();
	for (id, z) in oentries(zones_in) {
		let o = Obj::new();
		o.set("id", str_to_num(&id));
		o.set("name", z.get("name"));
		zones.set_str(id, V::Obj(o));
	}
	let factions = Obj::new();
	for (id, f) in oentries(&fv.factions) {
		let o = Obj::new();
		o.set("id", str_to_num(&id));
		o.set("name", f.get("name"));
		let side = f.get("side");
		o.set("side", if side.truthy() { side } else { V::Null });
		factions.set_str(id, V::Obj(o));
	}
	for f in al.map(|a| a.get("factions").items()).unwrap_or_default() {
		let fid = f.get("factionId");
		if fid.truthy() && !factions.has(&fid.to_js_string()) && f.get("name").truthy() {
			let o = Obj::new();
			o.set("id", fid.clone());
			o.set("name", f.get("name"));
			o.set("side", V::Null);
			factions.set(&fid.to_js_string(), V::Obj(o));
		}
	}

	// ----- npcs
	let npcs = Obj::new();
	let mut npc_roles: Vec<(String, OSet)> = Vec::new();
	let mut role_ix: FxHashMap<String, usize> = FxHashMap::default();
	let set_roles = |npc_roles: &mut Vec<(String, OSet)>, role_ix: &mut FxHashMap<String, usize>, id: &str, set: OSet| match role_ix.get(id) {
		Some(&i) => npc_roles[i].1 = set,
		None => {
			role_ix.insert(id.to_string(), npc_roles.len());
			npc_roles.push((id.to_string(), set));
		}
	};
	for (id, n) in oentries(&fv.npcs) {
		let name = n.get("name");
		if !name.truthy() || junk(&name.to_js_string()) {
			continue;
		}
		let rank = int(&n.get("rank"));
		let roles = n.get("roles");
		let has_rare = roles.items().iter().any(|r| r.as_str() == Some("rare"));
		let o = Obj::new();
		o.set("id", str_to_num(&id));
		o.set("name", name);
		let sub = n.get("subName");
		if sub.truthy() {
			o.set("subName", sub);
		}
		o.set("level", opt(int(&n.get("level"))));
		o.set("levelMax", opt(int(&n.get("levelMax"))));
		let fac = n.get("faction");
		o.set("faction", if matches!(fac.as_str(), Some("A" | "H" | "AH")) { fac } else { V::Null });
		o.set("rare", rank == Some(2.0) || rank == Some(4.0) || has_rare);
		o.set("elite", rank == Some(1.0) || rank == Some(2.0) || rank == Some(3.0));
		o.set("boss", rank == Some(3.0));
		o.set("instance", V::Null);
		o.set("roles", V::arr());
		o.set("spawns", spawns_v(&spawns_of(&n.get("spawns"), zones_in, frames_in, false)));
		npcs.set(&id, V::Obj(o));
		let mut set = OSet::default();
		for r in roles.items() {
			set.add(&r.to_js_string());
		}
		set_roles(&mut npc_roles, &mut role_ix, &id, set);
	}
	// The cached web facts, release build only.
	let wh = if al.is_some() { None } else { inputs.web.as_ref() };
	let wh_npc = wh.map(|w| w.get("npc")).unwrap_or_else(|| empty.clone());
	let wh_object = wh.map(|w| w.get("object")).unwrap_or_else(|| empty.clone());
	let wh_item = wh.map(|w| w.get("item")).unwrap_or_else(|| empty.clone());
	let wh_spell = wh.map(|w| w.get("spell")).unwrap_or_else(|| empty.clone());
	if let Some(wh) = wh {
		for (id, w) in oentries(&wh_npc) {
			let cls = w.get("classification");
			let cls = cls.as_str().unwrap_or("");
			let rare_w = cls == "rare" || cls == "rareelite";
			let live = Obj::new();
			for (m, pts) in oentries(&w.get("spawns")) {
				let s = Obj::new();
				s.set("f", V::Null);
				s.set("pts", pts);
				live.set_str(m, V::Obj(s));
			}
			let spawns = spawns_of(&V::Obj(live), zones_in, frames_in, false);
			let mut rec = npcs.get(&id);
			if !rec.truthy() {
				let name = w.get("name");
				let ok = if rare_w { !spawns.is_empty() } else { !spawns.is_empty() || !w.get("drops").items().is_empty() };
				if !name.truthy() || junk(&name.to_js_string()) || !ok {
					continue;
				}
				let elite = matches!(cls, "rareelite" | "elite" | "boss");
				let o = Obj::new();
				o.set("id", str_to_num(&id));
				o.set("name", name);
				o.set("level", V::Null);
				o.set("levelMax", V::Null);
				o.set("faction", V::Null);
				o.set("rare", rare_w);
				o.set("elite", elite);
				o.set("boss", cls == "boss");
				o.set("instance", V::Null);
				o.set("roles", V::arr());
				o.set("spawns", spawns_v(&spawns));
				npcs.set(&id, V::Obj(o.clone()));
				rec = V::Obj(o);
				let mut set = OSet::default();
				if rare_w {
					set.add("rare");
				}
				set_roles(&mut npc_roles, &mut role_ix, &id, set);
			}
			let wl = w.get("level");
			if rec.get("level").is_nullish() && wl.truthy() {
				rec.set("level", wl.at(0));
				rec.set("levelMax", if !wl.at(1).strict_eq(&wl.at(0)) { wl.at(1) } else { V::Null });
			}
			if rare_w && !rec.get("rare").truthy() {
				rec.set("rare", true);
				if cls == "rareelite" {
					rec.set("elite", true);
				}
				let i = role_ix[&*id];
				npc_roles[i].1.add("rare");
			}
			if rec.get("spawns").items().is_empty() && !spawns.is_empty() {
				rec.set("spawns", spawns_v(&spawns));
			}
		}
		for (id, r) in oentries(&wh.get("listed").get("npc")) {
			let rec = npcs.get(&id);
			if !rec.truthy() || !rec.get("level").is_nullish() || !r.get("level").truthy() {
				continue;
			}
			let l = r.get("level");
			rec.set("level", l.at(0));
			rec.set("levelMax", if !l.at(1).strict_eq(&l.at(0)) { l.at(1) } else { V::Null });
		}
	}
	let add_role = |npc_roles: &mut Vec<(String, OSet)>, role_ix: &mut FxHashMap<String, usize>, id: &str, role: &str| {
		if !npcs.has(id) {
			return;
		}
		match role_ix.get(id) {
			Some(&i) => npc_roles[i].1.add(role),
			None => {
				role_ix.insert(id.to_string(), npc_roles.len());
				let mut s = OSet::default();
				s.add(role);
				npc_roles.push((id.to_string(), s));
			}
		}
	};
	let mut skill_line_of: Vec<(String, f64)> = Vec::new();
	let set_skill = |m: &mut Vec<(String, f64)>, name: &str, v: f64| match m.iter_mut().find(|(n, _)| n == name) {
		Some(e) => e.1 = v,
		None => m.push((name.to_string(), v)),
	};
	for (id, p) in oentries(&fv.professions) {
		set_skill(&mut skill_line_of, &p.get("name").to_js_string(), str_to_num(&id));
		let mut trainers: Vec<V> = Vec::new();
		let mut push = |t: V| {
			if !trainers.iter().any(|x| x.strict_eq(&t)) {
				trainers.push(t);
			}
		};
		for list in p.get("trainers").values() {
			for t in list.items() {
				push(t);
			}
		}
		for r in p.get("ranks").items() {
			for list in r.get("trainers").values() {
				for t in list.items() {
					push(t);
				}
			}
		}
		for t in trainers {
			let t = kstr(&t);
			add_role(&mut npc_roles, &mut role_ix, &t, "trainer");
			add_role(&mut npc_roles, &mut role_ix, &t, &format!("trainer:{id}"));
		}
	}
	if let Some(cl) = cl {
		for (id, name) in &cl.skill_lines {
			if let Some(name) = name.as_deref().filter(|n| !n.is_empty()) {
				if !skill_line_of.iter().any(|(n, _)| n == name) {
					skill_line_of.push((name.to_string(), *id as f64));
				}
			}
		}
	}
	for (id, t) in oentries(&fv.trainers) {
		for c in t.get("classes").items() {
			add_role(&mut npc_roles, &mut role_ix, &id, "trainer");
			add_role(&mut npc_roles, &mut role_ix, &id, &format!("class:{}", c.to_js_string()));
		}
	}

	// RareScanner rares (rows outside Forever's zones dropped). npc -> its loot, by npc.
	let mut rare_loot: Vec<(String, Vec<f64>)> = Vec::new();
	if let Some(rs) = rs {
		let mut rows: Vec<(f64, Vec<V>)> = Vec::new();
		for r in rs.get("rares").items() {
			let npc = r.get("npc");
			if !npc.truthy() || !zones_in.get(&r.get("map").to_js_string()).truthy() {
				continue;
			}
			match rows.iter_mut().find(|x| x.0 == npc.num()) {
				Some(x) => x.1.push(r),
				None => rows.push((npc.num(), vec![r])),
			}
		}
		rows.sort_by(|a, b| ord(a.0 - b.0));
		for (npc, list) in rows {
			let id = key(npc);
			let mut rec = npcs.get(&id);
			let name = if rec.truthy() { rec.get("name") } else { list.iter().map(|r| r.get("name")).find(V::truthy).unwrap_or(V::Undef) };
			if !name.truthy() {
				continue;
			}
			if !rec.truthy() {
				let o = Obj::new();
				o.set("id", npc);
				o.set("name", name);
				o.set("level", V::Null);
				o.set("levelMax", V::Null);
				o.set("faction", V::Null);
				o.set("rare", true);
				o.set("elite", false);
				o.set("boss", false);
				o.set("instance", V::Null);
				o.set("roles", V::arr());
				o.set("spawns", V::arr());
				npcs.set(&id, V::Obj(o));
				rec = npcs.get(&id);
				set_roles(&mut npc_roles, &mut role_ix, &id, OSet::default());
			}
			rec.set("rare", true);
			if rec.get("spawns").items().is_empty() {
				let by_map = Obj::new();
				for r in &list {
					let pts = r.get("points");
					let pts: Vec<V> = if pts.truthy() && !pts.items().is_empty() {
						pts.items()
					} else if !r.get("x").is_nullish() {
						vec![V::from(vec![r.get("x"), r.get("y")])]
					} else {
						Vec::new()
					};
					let m = r.get("map").to_js_string();
					if !by_map.has(&m) {
						let o = Obj::new();
						o.set("f", V::Null);
						o.set("pts", V::arr());
						by_map.set(&m, V::Obj(o));
					}
					for p in pts {
						by_map.get(&m).get("pts").push(p);
					}
				}
				rec.set("spawns", spawns_v(&spawns_of(&V::Obj(by_map), zones_in, frames_in, false)));
			}
			let i = match rare_loot.iter().position(|x| x.0 == id) {
				Some(i) => i,
				None => {
					rare_loot.push((id.clone(), Vec::new()));
					rare_loot.len() - 1
				}
			};
			for r in &list {
				for it in r.get("loot").items() {
					let n = it.num();
					if !rare_loot[i].1.contains(&n) {
						rare_loot[i].1.push(n);
					}
				}
			}
		}
	}

	// ----- instances. A release build: the client tables, npcs.json and items.json. A
	// --local-extras build: AtlasLoot dungeons and raids, entrances and Forever bosses from
	// dungeons.json.
	let instances = Obj::new();
	let boss_instance = Obj::new();
	let npc_instance = Obj::new();
	let mut dungeons_by_name: Vec<(String, V)> = Vec::new();
	for d in &dungeon_list {
		let n = norm_name(&d.get("name").to_js_string());
		match dungeons_by_name.iter_mut().find(|x| x.0 == n) {
			Some(x) => x.1 = d.clone(),
			None => dungeons_by_name.push((n, d.clone())),
		}
	}
	let mut used_dungeons: Vec<String> = Vec::new();
	let mut dungeon_key: Vec<(String, String)> = Vec::new(); // dungeons.json key -> instance key
	let mut atlas_key: Vec<(String, String)> = Vec::new(); // AtlasLoot instance key -> instance key
	let set_pair = |m: &mut Vec<(String, String)>, k: String, v: String| match m.iter_mut().find(|x| x.0 == k) {
		Some(x) => x.1 = v,
		None => m.push((k, v)),
	};
	let lookup = |m: &[(String, String)], k: &str| m.iter().find(|x| x.0 == k).map(|x| x.1.clone());
	// AtlasLoot names are sometimes key-derived: exact normalised name first, then a unique prefix
	// match either way.
	let match_dungeon = |inst: &V| -> Option<V> {
		let s = |k: &str| {
			let v = inst.get(k);
			if v.truthy() {
				v.to_js_string()
			} else {
				String::new()
			}
		};
		for n in [norm_name(&s("name")), norm_name(&s("key"))] {
			if !n.is_empty() {
				if let Some(d) = dungeons_by_name.iter().find(|x| x.0 == n) {
					return Some(d.1.clone());
				}
			}
		}
		let n = norm_name(&if inst.get("name").truthy() { s("name") } else { s("key") });
		if n.encode_utf16().count() < 6 {
			return None;
		}
		let hits: Vec<&(String, V)> = dungeons_by_name.iter().filter(|(dn, _)| dn.starts_with(&n) || n.starts_with(dn.as_str())).collect();
		(hits.len() == 1).then(|| hits[0].1.clone())
	};
	let entrance_of = |d: &V| -> V {
		let e = d.get("entrance");
		if !e.truthy() {
			return V::Null;
		}
		let o = Obj::new();
		o.set("map", e.get("map"));
		o.set("x", round1(e.get("x").num()));
		o.set("y", round1(e.get("y").num()));
		o.set("f", if e.get("f").as_str() == Some("e") { V::str("e") } else { V::Null });
		V::Obj(o)
	};
	let loot_items = |b: &V| -> V { V::from(b.get("loot").items().into_iter().map(|l| l.get("item")).filter(V::truthy).collect::<Vec<V>>()) };
	let set_boss = |boss_instance: &Obj, n: &V, k: &str| {
		let id = n.to_js_string();
		if !boss_instance.get(&id).truthy() {
			boss_instance.set(&id, k);
		}
	};
	for inst in al.map(|a| a.get("instances").items()).unwrap_or_default() {
		let kind = inst.get("kind").to_js_string();
		if kind != "dungeon" && kind != "raid" {
			continue;
		}
		let d = match_dungeon(&inst);
		// The DungeonJournal key when it covers the instance (what Dungeons and Journal use).
		let k = match &d {
			Some(d) => slug(&d.get("key").to_js_string()),
			None => slug(&if inst.get("name").truthy() { inst.get("name") } else { inst.get("key") }.to_js_string()),
		};
		if k.is_empty() || instances.has(&k) {
			continue;
		}
		let ak = if inst.get("key").truthy() { inst.get("key") } else { inst.get("name") }.to_js_string();
		set_pair(&mut atlas_key, ak, k.clone());
		if let Some(d) = &d {
			used_dungeons.push(d.get("key").to_js_string());
			set_pair(&mut dungeon_key, d.get("key").to_js_string(), k.clone());
		}
		let entrance = d.as_ref().map(entrance_of).unwrap_or(V::Null);
		let bosses: Vec<V> = Vec::new();
		let bosses_v = V::from(bosses);
		for b in inst.get("bosses").items() {
			let bn = b.get("npc");
			let npc = if bn.is_arr() { bn.at(0).clone_nullish() } else { bn.clone_nullish() };
			let mut its: Vec<V> = Vec::new();
			for i in b.get("items").items() {
				let it = i.get("item");
				if it.truthy() && !its.iter().any(|x| x.strict_eq(&it)) {
					its.push(it);
				}
			}
			let o = Obj::new();
			o.set("name", b.get("name"));
			o.set("npc", npc);
			o.set("items", V::from(its));
			bosses_v.push(V::Obj(o));
			let ns: Vec<V> = if bn.is_arr() {
				bn.items()
			} else if bn.truthy() {
				vec![bn.clone()]
			} else {
				Vec::new()
			};
			for n in ns {
				set_boss(&boss_instance, &n, &k);
			}
		}
		// DungeonJournal bosses AtlasLoot lacks (Forever's own encounters).
		if let Some(d) = &d {
			for b in d.get("bosses").items() {
				let bn = b.get("npc");
				if !bn.truthy() || bosses_v.items().iter().any(|x| x.get("npc").strict_eq(&bn)) {
					continue;
				}
				let o = Obj::new();
				o.set("name", b.get("name"));
				o.set("npc", bn.clone());
				o.set("items", loot_items(&b));
				bosses_v.push(V::Obj(o));
				set_boss(&boss_instance, &bn, &k);
			}
		}
		let o = Obj::new();
		o.set("key", k.as_str());
		o.set(
			"name",
			match &d {
				Some(d) if d.get("name").truthy() => d.get("name"),
				_ => inst.get("name"),
			},
		);
		o.set("kind", kind.as_str());
		o.set("forever", inst.get("forever").truthy());
		o.set("areaId", inst.get("areaId").clone_nullish());
		o.set("map", V::Null);
		o.set("entrance", entrance);
		let lv = inst.get("levels");
		o.set(
			"levels",
			if lv.truthy() {
				lv
			} else {
				match &d {
					Some(d) if d.get("levels").truthy() => {
						let l = d.get("levels");
						V::from(vec![l.get("min"), l.get("min"), l.get("max")])
					}
					_ => V::Null,
				}
			},
		);
		o.set("bosses", bosses_v);
		instances.set(&k, V::Obj(o));
	}
	for d in &dungeon_list {
		let dk = d.get("key").to_js_string();
		if used_dungeons.contains(&dk) {
			continue;
		}
		let k = slug(&if d.get("key").truthy() { d.get("key") } else { d.get("name") }.to_js_string());
		if instances.has(&k) {
			continue;
		}
		set_pair(&mut dungeon_key, dk, k.clone());
		let o = Obj::new();
		o.set("key", k.as_str());
		o.set("name", d.get("name"));
		o.set("kind", "dungeon");
		o.set("forever", true);
		o.set("areaId", V::Null);
		o.set("map", V::Null);
		o.set("entrance", entrance_of(d));
		let l = d.get("levels");
		o.set("levels", if l.truthy() { V::from(vec![l.get("min"), l.get("min"), l.get("max")]) } else { V::Null });
		let bosses: Vec<V> = d
			.get("bosses")
			.items()
			.into_iter()
			.map(|b| {
				let o = Obj::new();
				o.set("name", b.get("name"));
				o.set("npc", b.get("npc").clone_nullish());
				o.set("items", loot_items(&b));
				V::Obj(o)
			})
			.collect();
		o.set("bosses", V::from(bosses));
		instances.set(&k, V::Obj(o));
		for b in d.get("bosses").items() {
			if b.get("npc").truthy() {
				set_boss(&boss_instance, &b.get("npc"), &k);
			}
		}
	}
	if al.is_none() && !fv.dungeons.truthy() {
		if let Some(facts) = cl.and_then(|c| c.instances.as_ref()) {
			let cl = cl.unwrap();
			let quality = |id: f64| cl.items.get(&(id as i64)).and_then(|c| c.quality);
			let built = build_instances(
				facts,
				&Ctx {
					npcs: &fv.npcs,
					items: &fv.items,
					objects: &fv.objects,
					zones: zones_in,
					frames: &frames_in.get("forever").clone_or_obj(),
					recorded: &fv.instances,
					entrance_table: &inputs.entrance_table,
					curated: &inputs.entrances,
					quality: &quality,
					web: wh,
				},
			);
			for (k, v) in built.instances {
				instances.set(&k, v);
			}
			for (id, k) in built.boss_instance {
				boss_instance.set(&key(id), k.as_str());
			}
			for (id, k) in built.npc_instance {
				npc_instance.set(&key(id), k.as_str());
			}
		}
	}
	for (npc, k) in boss_instance.entries() {
		if !npc_instance.has(&npc) {
			npc_instance.set_str(npc, k);
		}
	}
	for (npc, k) in npc_instance.entries() {
		if npcs.has(&npc) && !boss_instance.get(&npc).truthy() {
			npcs.get(&npc).set("instance", k);
		}
	}
	for (npc, k) in boss_instance.entries() {
		if !npcs.has(&npc) {
			let nid = str_to_num(&npc);
			let boss = instances.get(&k.to_js_string()).get("bosses").items().into_iter().find(|b| matches!(b.get("npc"), V::Num(n) if n == nid));
			let Some(boss) = boss else { continue };
			if !boss.get("name").truthy() {
				continue;
			}
			let o = Obj::new();
			o.set("id", nid);
			o.set("name", boss.get("name"));
			o.set("level", V::Null);
			o.set("levelMax", V::Null);
			o.set("faction", V::Null);
			o.set("rare", false);
			o.set("elite", true);
			o.set("boss", true);
			o.set("instance", k.clone());
			o.set("roles", V::arr());
			o.set("spawns", V::arr());
			npcs.set(&npc, V::Obj(o));
			set_roles(&mut npc_roles, &mut role_ix, &npc, OSet::default());
		}
		let n = npcs.get(&npc);
		n.set("boss", true);
		n.set("elite", true);
		n.set("instance", k);
	}
	for (npc, k) in npc_instance.entries() {
		let n = npcs.get(&npc);
		if n.truthy() && n.get("rare").truthy() && k.truthy() && !rare_loot.iter().any(|x| *x.0 == *npc) && n.get("spawns").items().is_empty() {
			n.set("rare", false);
			if let Some(&i) = role_ix.get(&*npc) {
				npc_roles[i].1.delete("rare");
			}
		}
	}
	// Object.entries(npcRoles): index-like ids ascending, then the rest in insertion order.
	let mut role_order: Vec<usize> = (0..npc_roles.len()).collect();
	role_order.sort_by(|&a, &b| {
		let (ka, kb) = (&npc_roles[a].0, &npc_roles[b].0);
		match (super::util::index_key(ka), super::util::index_key(kb)) {
			(true, true) => ka.parse::<u64>().unwrap().cmp(&kb.parse::<u64>().unwrap()),
			(true, false) => std::cmp::Ordering::Less,
			(false, true) => std::cmp::Ordering::Greater,
			_ => a.cmp(&b),
		}
	});
	for i in role_order {
		let (id, set) = &mut npc_roles[i];
		let npc = npcs.get(id);
		if !npc.truthy() {
			continue;
		}
		let source = fv.npcs.get(id);
		if set.has("trainer") {
			let sub = npc.get("subName");
			let title = if sub.truthy() { sub.to_js_string() } else { String::new() }.to_lowercase();
			for c in CLASSES.iter() {
				if has_word(&title, c.name) {
					set.add(&format!("class:{}", c.file));
				}
			}
			if has_word(&title, "weapon master") {
				set.add("weapon");
			}
		}
		let mut roles = set.0.clone();
		roles.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
		npc.set("roles", V::from(roles.iter().map(|r| V::str(r)).collect::<Vec<V>>()));
		if source.truthy() && roles.iter().any(|r| is_service(r)) {
			let mut spawns = spawns_of(&source.get("spawns"), zones_in, frames_in, true);
			let facts = wh_npc.get(id);
			if spawns.is_empty() && facts.truthy() {
				let live = Obj::new();
				for (m, pts) in oentries(&facts.get("spawns")) {
					let s = Obj::new();
					s.set("f", V::Null);
					s.set("pts", pts);
					live.set_str(m, V::Obj(s));
				}
				spawns = spawns_of(&V::Obj(live), zones_in, frames_in, true);
			}
			if !spawns.is_empty() {
				npc.set("spawns", spawns_v(&spawns));
			}
		}
	}
	for npc in npcs.values() {
		if npc.get("subName").truthy() && !npc.get("roles").items().iter().any(|r| is_service(&r.to_js_string())) {
			npc.as_obj().unwrap().delete("subName");
		}
	}

	// ----- items
	let mut cands: Vec<(f64, Vec<Cand>)> = Vec::new();
	let mut cand_ix: FxHashMap<u64, usize> = FxHashMap::default();
	let mut add = |item: f64, s: Cand| {
		if item == 0.0 || item.is_nan() {
			return;
		}
		match cand_ix.get(&item.to_bits()) {
			Some(&i) => cands[i].1.push(s),
			None => {
				cand_ix.insert(item.to_bits(), cands.len());
				cands.push((item, vec![s]));
			}
		}
	};
	let names = Obj::new();
	let cl_item = |id: &str| cl.and_then(|c| c.items.get(&(str_to_num(id) as i64)));
	for (id, it) in oentries(&fv.items) {
		names.set(&id, it.get("name"));
		let from = from_v(&from_labels(&it.get("source")));
		let idn = str_to_num(&id);
		for (npc, chance) in oentries(&it.get("drops").get("npc")) {
			if npcs.has(&npc) {
				let ch = chance.num();
				add(
					idn,
					src(
						"drop",
						&[("npc", V::Num(str_to_num(&npc))), ("chance", if ch != 0.0 && !ch.is_nan() { V::Num(ch) } else { V::Null }), ("instance", nn_or_null(npc_instance.get(&npc)))],
						&from,
					),
				);
			}
		}
		for (obj, chance) in oentries(&it.get("drops").get("object")) {
			let ch = chance.num();
			add(idn, src("object", &[("object", V::Num(str_to_num(&obj))), ("chance", if ch != 0.0 && !ch.is_nan() { V::Num(ch) } else { V::Null })], &from));
		}
		for npc in it.get("vendors").items() {
			let n = npcs.get(&kstr(&npc));
			if n.truthy() && !n.get("spawns").items().is_empty() {
				let cost = cl_item(&id).and_then(|c| c.buy_price);
				add(idn, src("vendor", &[("npc", V::Num(npc.num())), ("cost", opt(cost))], &from));
			}
		}
		for c in it.get("containers").items() {
			add(idn, src("container", &[("item", V::Num(c.num()))], &from));
		}
	}
	let web_from = from_v(&["web".to_string()]);
	if wh.is_some() {
		for (npc, w) in oentries(&wh_npc) {
			if !npcs.has(&npc) {
				continue;
			}
			for d in w.get("drops").items() {
				let ch = math_round((d.get("count").num() / d.get("outof").num()) * 10000.0) / 100.0;
				add(d.get("item").num(), src("drop", &[("npc", V::Num(str_to_num(&npc))), ("chance", V::Num(ch)), ("instance", nn_or_null(npc_instance.get(&npc)))], &web_from));
			}
		}
		for (obj, w) in oentries(&wh_object) {
			for d in w.get("drops").items() {
				let ch = math_round((d.get("count").num() / d.get("outof").num()) * 10000.0) / 100.0;
				add(d.get("item").num(), src("object", &[("object", V::Num(str_to_num(&obj))), ("chance", V::Num(ch))], &web_from));
			}
		}
	}
	let forever_from = from_v(&["forever".to_string()]);
	let recipe_spell = Obj::new();
	for (line, p) in oentries(&fv.professions) {
		for r in p.get("recipes").items() {
			if r.get("item").truthy() {
				let skill = r.get("learnedAt");
				add(
					r.get("item").num(),
					src(
						"craft",
						&[("spell", r.get("spell")), ("skillLine", V::Num(str_to_num(&line))), ("profession", p.get("name")), ("skill", if skill.is_nullish() { V::Null } else { skill })],
						&forever_from,
					),
				);
			}
			if r.get("recipeItem").truthy() {
				recipe_spell.set(&kstr(&r.get("recipeItem")), r.get("spell"));
			}
		}
	}
	if let Some(al) = al {
		let atlas_from = from_v(&["atlasloot".to_string()]);
		let rates = al.get("droprates");
		for inst in al.get("instances").items() {
			let kind = inst.get("kind").to_js_string();
			let k = if kind == "dungeon" || kind == "raid" {
				let ak = if inst.get("key").truthy() { inst.get("key") } else { inst.get("name") }.to_js_string();
				lookup(&atlas_key, &ak).map(|k| V::str(&k)).unwrap_or(V::Null)
			} else {
				V::Null
			};
			for b in inst.get("bosses").items() {
				let bn = b.get("npc");
				let npc = if bn.is_arr() { bn.at(0) } else { bn };
				for i in b.get("items").items() {
					if !i.get("item").truthy() {
						continue;
					}
					let ch = i.get("chance");
					if npc.truthy() {
						let chance = if !ch.is_nullish() {
							ch.clone()
						} else {
							let r = rates.get(&kstr(&npc));
							if r.truthy() {
								r.get(&kstr(&i.get("item"))).clone_nullish()
							} else {
								V::Null
							}
						};
						add(i.get("item").num(), src("drop", &[("npc", npc.clone()), ("chance", chance), ("instance", k.clone())], &atlas_from));
					}
					for obj in b.get("object").items() {
						add(i.get("item").num(), src("object", &[("object", obj), ("chance", ch.clone_nullish())], &atlas_from));
					}
				}
			}
		}
		for c in al.get("crafting").items() {
			if !c.get("item").truthy() || !c.get("spell").truthy() {
				continue;
			}
			let prof = c.get("profession").to_js_string();
			if let Some((_, line)) = skill_line_of.iter().find(|(n, _)| *n == prof) {
				add(
					c.get("item").num(),
					src("craft", &[("spell", c.get("spell")), ("skillLine", V::Num(*line)), ("profession", c.get("profession")), ("skill", c.get("skill").clone_nullish())], &atlas_from),
				);
			}
		}
		for f in al.get("factions").items() {
			if !f.get("factionId").truthy() {
				continue;
			}
			for r in f.get("rewards").items() {
				add(r.get("item").num(), src("rep", &[("faction", f.get("factionId")), ("standing", r.get("standing").clone_nullish())], &atlas_from));
			}
		}
		for p in al.get("pvp").items() {
			add(p.get("item").num(), src("pvp", &[("rank", p.get("rank").clone_nullish())], &atlas_from));
		}
	}
	let rs_from = from_v(&["rarescanner".to_string()]);
	for (npc, loot) in &rare_loot {
		for &it in loot {
			add(it, src("drop", &[("npc", V::Num(str_to_num(npc)))], &rs_from));
		}
	}
	// Quest rewards: quest -> (rewards, choices) (JS Sets of numbers).
	let mut quest_rewards: FxHashMap<String, (Vec<f64>, Vec<f64>)> = FxHashMap::default();
	let mut qr_order: Vec<String> = Vec::new();
	let mut reward = |qr: &mut FxHashMap<String, (Vec<f64>, Vec<f64>)>, quest: &str, item: f64, choice: bool| {
		let e = qr.entry(quest.to_string()).or_insert_with(|| {
			qr_order.push(quest.to_string());
			(Vec::new(), Vec::new())
		});
		let l = if choice { &mut e.1 } else { &mut e.0 };
		if !l.iter().any(|x| x.to_bits() == item.to_bits() || (x.is_nan() && item.is_nan())) {
			l.push(item);
		}
	};
	let quests_in = &fv.quests;
	for (qid, q) in oentries(quests_in) {
		let r = q.get("rewards");
		if !r.truthy() {
			continue;
		}
		let from = from_v(&from_labels(&q.get("source")));
		for it in r.get("items").items() {
			reward(&mut quest_rewards, &qid, it.num(), false);
			add(it.num(), src("quest", &[("quest", V::Num(str_to_num(&qid)))], &from));
		}
		for it in r.get("choices").items() {
			reward(&mut quest_rewards, &qid, it.num(), true);
			add(it.num(), src("quest", &[("quest", V::Num(str_to_num(&qid))), ("choice", V::Bool(true))], &from));
		}
	}
	let rep_table = &inputs.rep_table;
	let curated_from = from_v(&["curated".to_string()]);
	for rows in rep_table.values() {
		for g in rows.items() {
			if !g.get("quest").truthy() {
				continue;
			}
			let gq = kstr(&g.get("quest"));
			if !quests_in.get(&gq).truthy() {
				let name = g.get("name");
				warnings.push(format!("repgates.json: {} {}: quest {gq} is not in the Codex", kstr(&g.get("item")), if name.truthy() { name.to_js_string() } else { String::new() }));
				continue;
			}
			reward(&mut quest_rewards, &gq, g.get("item").num(), g.get("choice").truthy());
			add(g.get("item").num(), src("quest", &[("quest", g.get("quest")), ("choice", if g.get("choice").truthy() { V::Bool(true) } else { V::Null })], &curated_from));
		}
	}
	let flb_quests = flb.map(|f| f.get("quests")).unwrap_or_else(|| empty.clone());
	let flbis_from = from_v(&["flbis".to_string()]);
	for (qid, q) in oentries(&flb_quests) {
		for it in q.get("rewards").get("items").items() {
			reward(&mut quest_rewards, &qid, it.num(), false);
			add(it.num(), src("quest", &[("quest", V::Num(str_to_num(&qid)))], &flbis_from));
		}
		for it in q.get("rewards").get("choices").items() {
			reward(&mut quest_rewards, &qid, it.num(), true);
			add(it.num(), src("quest", &[("quest", V::Num(str_to_num(&qid))), ("choice", V::Bool(true))], &flbis_from));
		}
	}
	let mut dungeon_quests: Vec<(f64, V)> = Vec::new();
	let mut dungeon_items: Vec<(f64, V, V)> = Vec::new(); // item -> (name, quality): Forever dungeon loot the other tables may lack
	let dungeons_from = from_v(&["dungeons".to_string()]);
	let mut item_ref = |x: &V| -> f64 {
		if x.is_obj() {
			let it = x.get("item");
			if it.truthy() && x.get("name").truthy() && !dungeon_items.iter().any(|d| d.0 == it.num()) {
				dungeon_items.push((it.num(), x.get("name"), x.get("quality").clone_nullish()));
			}
			return it.num();
		}
		x.num()
	};
	for d in &dungeon_list {
		let k = lookup(&dungeon_key, &d.get("key").to_js_string()).map(|k| V::str(&k)).unwrap_or(V::Null);
		for b in d.get("bosses").items() {
			for l in b.get("loot").items() {
				let item = item_ref(&l);
				if item != 0.0 && !item.is_nan() && b.get("npc").truthy() {
					add(item, src("drop", &[("npc", b.get("npc")), ("instance", k.clone())], &dungeons_from));
				}
			}
		}
		for q in d.get("quests").items() {
			let qid = q.get("id");
			match dungeon_quests.iter_mut().find(|x| x.0 == qid.num()) {
				Some(x) => x.1 = q.clone(),
				None => dungeon_quests.push((qid.num(), q.clone())),
			}
			let qk = kstr(&qid);
			for x in q.get("rewards").get("items").items() {
				let it = item_ref(&x);
				reward(&mut quest_rewards, &qk, it, false);
				add(it, src("quest", &[("quest", qid.clone())], &dungeons_from));
			}
			for x in q.get("rewards").get("choices").items() {
				let it = item_ref(&x);
				reward(&mut quest_rewards, &qk, it, true);
				add(it, src("quest", &[("quest", qid.clone()), ("choice", V::Bool(true))], &dungeons_from));
			}
		}
	}
	for (id, name, _) in &dungeon_items {
		if !names.get(&key(*id)).truthy() {
			names.set(&key(*id), name.clone());
		}
	}
	for (qid, q) in oentries(quests_in) {
		let w = q.get("web");
		if !w.truthy() {
			continue;
		}
		let had = quest_rewards.contains_key(&*qid);
		for (list, choice) in [(w.get("choices"), true), (w.get("items"), false)] {
			for pair in list.items() {
				let it = pair.at(0).num();
				if had {
					let h = &quest_rewards[&*qid];
					if h.0.contains(&it) || h.1.contains(&it) {
						continue;
					}
				}
				reward(&mut quest_rewards, &qid, it, choice);
				add(it, src("quest", &[("quest", V::Num(str_to_num(&qid))), ("choice", if choice { V::Bool(true) } else { V::Null })], &web_from));
			}
		}
	}
	if let Some(flb) = flb {
		for (id, it) in oentries(&flb.get("items")) {
			if it.get("name").truthy() && !names.get(&id).truthy() {
				names.set(&id, it.get("name"));
			}
			let idn = str_to_num(&id);
			for s in it.get("sources").items() {
				let ty = s.get("type");
				let ty = ty.as_str().unwrap_or("");
				if ty == "quest" && s.get("id").truthy() {
					let fq = flb_quests.get(&kstr(&s.get("id")));
					let choice = fq.truthy() && fq.get("rewards").truthy() && fq.get("rewards").get("choices").items().iter().any(|c| matches!(c, V::Num(n) if *n == idn));
					add(idn, src("quest", &[("quest", s.get("id")), ("choice", if choice { V::Bool(true) } else { V::Null })], &flbis_from));
				} else if ty == "drop" && s.get("npcId").truthy() {
					let pct = s.get("pct");
					add(
						idn,
						src("drop", &[("npc", s.get("npcId")), ("chance", if pct.truthy() { pct } else { V::Null }), ("instance", nn_or_null(npc_instance.get(&kstr(&s.get("npcId")))))], &flbis_from),
					);
				} else if ty == "crafted" && s.get("spellId").truthy() {
					let prof = s.get("profession").to_js_string();
					if let Some((_, line)) = skill_line_of.iter().find(|(n, _)| *n == prof) {
						let skill = s.get("skill");
						add(
							idn,
							src(
								"craft",
								&[("spell", s.get("spellId")), ("skillLine", V::Num(*line)), ("profession", s.get("profession")), ("skill", if skill.is_nullish() { V::Null } else { skill })],
								&flbis_from,
							),
						);
					}
				}
			}
		}
	}

	let al_collections = al.map(|a| a.get("collections").items()).unwrap_or_default();
	if al.is_some() {
		for c in &al_collections {
			let it = c.get("item");
			if it.truthy() && !names.get(&kstr(&it)).truthy() {
				if let Some(ci) = cl.and_then(|cl| cl.items.get(&(it.num() as i64))) {
					names.set(&kstr(&it), ci.name.as_deref().map(V::str).unwrap_or(V::Null));
				}
			}
		}
	}

	// Collectible classification.
	let mut mount_items: FxHashSet<i64> = FxHashSet::default();
	let mut pet_items: FxHashSet<i64> = FxHashSet::default();
	let mut tabard_items: FxHashSet<i64> = FxHashSet::default();
	for c in &al_collections {
		let id = c.get("item").num() as i64;
		match c.get("group").as_str() {
			Some("Mounts") => {
				mount_items.insert(id);
			}
			Some("Companions") => {
				pet_items.insert(id);
			}
			Some("Tabards") => {
				tabard_items.insert(id);
			}
			_ => {}
		}
	}
	if let Some(rs) = rs {
		for list in rs.get("mounts").values() {
			for it in list.items() {
				mount_items.insert(it.num() as i64);
			}
		}
		for list in rs.get("pets").values() {
			for it in list.items() {
				pet_items.insert(it.num() as i64);
			}
		}
	}
	if let Some(cl) = cl {
		for (&id, it) in &cl.items {
			let learn = it.learn.map(|x| x as i64);
			let use_ = it.use_.map(|x| x as i64);
			let mut spells: Vec<i64> = Vec::new();
			for x in [learn, use_].into_iter().flatten() {
				spells.push(x);
				if let Some(&t) = cl.teaches.get(&x) {
					if t != 0 {
						spells.push(t);
					}
				}
			}
			let spell = spells.iter().copied().find(|x| cl.mount_spells.contains(x) || cl.pet_spells.contains(x)).or(learn).or(use_);
			let ids = key(id as f64);
			if (it.class_id == Some(15.0) && it.subclass_id == Some(5.0)) || learn.is_some_and(|l| cl.mount_aura.contains(&l)) || spell.is_some_and(|s| cl.mount_spells.contains(&s)) {
				mount_items.insert(id);
				if !names.get(&ids).truthy() && !it.era {
					names.set(&ids, it.name.as_deref().map(V::str).unwrap_or(V::Null));
				}
			} else if (it.class_id == Some(15.0) && it.subclass_id == Some(2.0) && learn.is_some()) || spell.is_some_and(|s| cl.pet_spells.contains(&s)) {
				pet_items.insert(id);
				if !names.get(&ids).truthy() && !it.era {
					names.set(&ids, it.name.as_deref().map(V::str).unwrap_or(V::Null));
				}
			}
		}
	}

	let listed: FxHashSet<u64> = al_collections.iter().map(|c| c.get("item").num().to_bits()).chain(inputs.curated.iter().map(|x| x.to_bits())).collect();
	let curated_gates = &inputs.curated_gates;
	let hidden_mount = |spell: &V| cl.is_some_and(|c| spell.truthy() && c.mount_hidden.contains(&(spell.num() as i64)));
	let status_of = |id: f64, kind: &str, sources: &[Obj], spell: &V| -> V {
		if sources.is_empty() {
			return V::str("nosource");
		}
		if kind != "mount" && kind != "pet" {
			return V::Null;
		}
		if listed.contains(&id.to_bits()) {
			return V::Null;
		}
		if al.is_none() && !(kind == "mount" && hidden_mount(spell)) {
			return V::Null;
		}
		let era_vendor = |s: &Obj| s.get("type").as_str() == Some("vendor") && from_of(&V::Obj(s.clone())).iter().any(|f| f == "pfquest");
		if sources.iter().all(era_vendor) {
			V::str("retired")
		} else {
			V::Null
		}
	};
	let npc_level = |id: &V| -> Option<(f64, f64)> {
		let n = npcs.get(&kstr(id));
		if !n.truthy() || !n.get("level").truthy() {
			return None;
		}
		let l = n.get("level").num();
		let m = n.get("levelMax");
		Some((l, if m.truthy() { m.num() } else { l }))
	};
	let items = Obj::new();
	let mut faction_by_name: FxHashMap<String, V> = FxHashMap::default();
	for f in factions.values() {
		faction_by_name.insert(norm_name(&f.get("name").to_js_string()), f.get("id"));
	}
	let mut no_pvp: Vec<f64> = Vec::new();
	let cut_drop = Obj::new();
	let cut_rare = Obj::new();
	let cut_treasure = Obj::new();
	let mut all_ids: BTreeSet<i64> = BTreeSet::new();
	for k in names.keys() {
		all_ids.insert(str_to_num(&k) as i64);
	}
	for (id, _) in &cands {
		all_ids.insert(*id as i64);
	}
	let client_from = from_v(&["client".to_string()]);
	let guides_from = from_v(&["guides".to_string()]);
	let questie_from = from_v(&["questie".to_string()]);
	for id in all_ids {
		let idf = id as f64;
		let ids = key(idf);
		let c = cl.and_then(|cl| cl.items.get(&id));
		let nm = names.get(&ids);
		let name = if nm.truthy() { nm } else { c.and_then(|c| c.name.as_deref()).map(V::str).unwrap_or(V::Null) };
		if !name.truthy() {
			continue;
		}
		let name_s = name.to_js_string();
		// The item's candidates (shared) and the ones added here.
		let shared: &[Cand] = cand_ix.get(&idf.to_bits()).map(|&i| cands[i].1.as_slice()).unwrap_or(&[]);
		// A reputation candidate naming no npc (AtlasLoot's) takes the item's first vendor (only
		// candidates are vendors, so it is known here already).
		let filled: Option<Vec<Cand>> = shared.iter().any(|s| s.ty == "rep" && s.get("npc").is_nullish()).then(|| {
			let vendor = shared.iter().find(|s| s.ty == "vendor").map(|s| s.get("npc"));
			let mut v = shared.to_vec();
			if let Some(npc) = vendor {
				for s in v.iter_mut().filter(|s| s.ty == "rep" && s.get("npc").is_nullish()) {
					s.set("npc", npc.clone());
				}
			}
			v
		});
		let base: &[Cand] = filled.as_deref().unwrap_or(shared);
		let mut list: Vec<Cand> = Vec::new();
		let first_vendor = |list: &[Cand]| -> V { base.iter().chain(list.iter()).find(|s| s.ty == "vendor").map(|s| s.get("npc")).unwrap_or(V::Null) };
		if let Some(c) = c {
			if let Some(mf) = c.min_faction {
				let v = first_vendor(&list);
				list.push(src("rep", &[("faction", V::Num(mf)), ("standing", opt(c.min_standing)), ("npc", v)], &client_from));
			}
		}
		let tip = wh_item.get(&ids);
		if tip.truthy() {
			let v = first_vendor(&list);
			for r in tip.get("rep").items() {
				if let Some(faction) = faction_by_name.get(&norm_name(&r.get("faction").to_js_string())) {
					if faction.truthy() {
						list.push(src("rep", &[("faction", faction.clone()), ("standing", r.get("standing")), ("npc", v.clone())], &web_from));
					}
				}
			}
			if tip.get("pvpRank").truthy() {
				list.push(src("pvp", &[("rank", tip.get("pvpRank")), ("npc", v.clone())], &web_from));
			}
			if !tip.get("pvpRank").truthy() {
				no_pvp.push(idf);
			}
		}
		for g in curated_gates.get(&ids).items() {
			let faction = if g.get("faction").truthy() { g.get("faction") } else { faction_by_name.get(&norm_name(&g.get("factionName").to_js_string())).cloned().unwrap_or(V::Undef) };
			if faction.truthy() {
				list.push(src("rep", &[("faction", faction), ("standing", g.get("standing")), ("npc", g.get("npc"))], &guides_from));
			}
		}
		if let Some(cl) = cl {
			for &spell in cl.creates.get(&id).map(Vec::as_slice).unwrap_or(&[]) {
				for npc in wh_spell.get(&key(spell as f64)).get("usedBy").items() {
					if npcs.has(&kstr(&npc)) {
						list.push(src("gift", &[("npc", npc), ("spell", V::Num(spell as f64))], &web_from));
					}
				}
			}
		}
		for g in rep_table.get(&ids).items() {
			if g.get("name").truthy() && g.get("name").to_js_string() != name_s {
				warnings.push(format!("repgates.json: {ids} is \"{name_s}\" in the Codex, not \"{}\"", g.get("name").to_js_string()));
			}
			for npc in g.get("npcs").items() {
				if base.iter().chain(list.iter()).any(|s| matches!(s.ty, "vendor" | "gift") && s.get("npc").strict_eq(&npc)) {
					list.push(src("rep", &[("faction", g.get("faction")), ("standing", g.get("standing")), ("npc", npc)], &curated_from));
				} else {
					warnings.push(format!("repgates.json: {ids} {name_s}: npc {} neither sells nor gives it in the Codex", kstr(&npc)));
				}
			}
		}
		if let Some(c) = c {
			if let Some(pr) = c.pvp_rank {
				let v = first_vendor(&list);
				list.push(src("pvp", &[("rank", V::Num(pr)), ("npc", v)], &client_from));
			}
		}
		let fv_vendor = first_vendor(&list);
		for s in list.iter_mut() {
			if s.ty == "rep" && s.get("npc").is_nullish() && !fv_vendor.is_nullish() {
				s.set("npc", fv_vendor.clone());
			}
		}
		let quest_srcs: Vec<V> = base.iter().chain(list.iter()).filter(|x| x.ty == "quest").map(|s| s.get("quest")).collect();
		for q in quest_srcs {
			if let Some((faction, standing)) = quest_rep(&quests_in.get(&kstr(&q))) {
				list.push(src("rep", &[("faction", faction), ("standing", V::Num(standing)), ("npc", V::Null)], &questie_from));
			}
		}
		for g in rep_table.get(&ids).items() {
			if g.get("quest").truthy() && base.iter().chain(list.iter()).any(|s| s.ty == "quest" && s.get("quest").strict_eq(&g.get("quest"))) {
				list.push(src("rep", &[("faction", g.get("faction")), ("standing", g.get("standing")), ("npc", V::Null)], &curated_from));
			}
		}
		let all: Vec<&Cand> = base.iter().chain(list.iter()).collect();
		let sources = finalize_sources(&all, &npc_level, &|npc: &V| boss_instance.get(&kstr(npc)).truthy(), &mut |ty: &str, npc: &V| {
			if ty == "drop" {
				let l = cut_drop.get(&ids);
				let l = if l.is_arr() {
					l
				} else {
					let a = V::arr();
					cut_drop.set(&ids, a.clone());
					a
				};
				l.push(npc.clone());
			}
		});
		if sources.is_empty() && junk(&name_s) {
			continue;
		}
		let kind = if mount_items.contains(&id) {
			"mount"
		} else if pet_items.contains(&id) {
			"pet"
		} else if c.is_some_and(|c| c.class_id == Some(9.0)) || recipe_spell.get(&ids).truthy() {
			"recipe"
		} else if tabard_items.contains(&id) || c.is_some_and(|c| c.inventory_type == Some(19.0)) {
			"tabard"
		} else {
			"item"
		};
		let spell = match kind {
			"mount" | "pet" => opt(c.and_then(|c| c.learn.or(c.use_))),
			"recipe" => {
				let r = recipe_spell.get(&ids);
				if r.truthy() {
					r
				} else {
					opt(c.and_then(|c| c.learn))
				}
			}
			_ => V::Null,
		};
		let mut rep_faction = opt(c.and_then(|c| c.min_faction));
		let mut rep_standing = if rep_faction.truthy() { opt(c.and_then(|c| c.min_standing)) } else { V::Null };
		if !rep_faction.truthy() {
			let vendors: Vec<V> = sources.iter().filter(|s| matches!(s.get("type").as_str(), Some("vendor" | "gift"))).map(|s| s.get("npc")).collect();
			let rep = sources.iter().find(|s| s.get("type").as_str() == Some("rep") && s.get("faction").truthy() && s.get("standing").truthy() && vendors.iter().any(|v| v.strict_eq(&s.get("npc"))));
			if let Some(rep) = rep {
				rep_faction = rep.get("faction");
				rep_standing = rep.get("standing");
			}
		}
		let status = status_of(idf, kind, &sources, &spell);
		let o = Obj::new();
		o.set("id", idf);
		o.set("name", name);
		o.set(
			"quality",
			match c.and_then(|c| c.quality) {
				Some(q) => V::Num(q),
				None => dungeon_items.iter().find(|d| d.0 == idf).map(|d| d.2.clone()).unwrap_or(V::Null),
			},
		);
		o.set("kind", kind);
		o.set("spell", spell);
		o.set("reqLevel", opt(c.and_then(|c| c.req_level)));
		o.set("repFaction", rep_faction);
		o.set("repStanding", rep_standing);
		o.set("reqSkill", opt(c.and_then(|c| c.req_skill)));
		o.set("reqSkillRank", opt(c.and_then(|c| c.req_skill_rank)));
		o.set("status", status);
		o.set("sources", V::from(sources.into_iter().map(V::Obj).collect::<Vec<V>>()));
		items.set(&ids, V::Obj(o));
	}
	for (id, rows) in rep_table.entries() {
		if !items.has(&id) {
			let name = rows.at(0).get("name");
			warnings.push(format!("repgates.json: item {id} {} is not in the Codex", if name.truthy() { name.to_js_string() } else { String::new() }));
		}
	}

	// ----- spells
	let spells = Obj::new();
	if let Some(cl) = cl {
		let mut ids: Vec<f64> = items.keys().iter().map(|k| str_to_num(k)).collect();
		ids.sort_by(|a, b| by_num(*a, *b));
		for id in ids {
			let it = items.get(&key(id));
			let kind = it.get("kind").to_js_string();
			let sp = it.get("spell");
			if (kind == "mount" || kind == "pet") && sp.truthy() && !spells.has(&kstr(&sp)) {
				let spn = sp.num() as i64;
				let o = Obj::new();
				o.set("kind", kind.as_str());
				o.set("item", id);
				o.set("name", cl.spell_names.get(&spn).filter(|s| !s.is_empty()).map(|s| V::str(s)).unwrap_or_else(|| it.get("name")));
				o.set("class", cl.spell_class.get(&spn).map(|c| V::str(c)).unwrap_or(V::Null));
				spells.set(&kstr(&sp), V::Obj(o));
			}
		}
		for &spell in &cl.mount_skill {
			let k = key(spell as f64);
			if spells.has(&k) || !cl.mount_aura.contains(&spell) {
				continue;
			}
			let o = Obj::new();
			o.set("kind", "mount");
			o.set("item", V::Null);
			o.set("name", cl.spell_names.get(&spell).filter(|s| !s.is_empty()).cloned().unwrap_or_else(|| format!("Spell {spell}")));
			o.set("class", cl.spell_class.get(&spell).map(|c| V::str(c)).unwrap_or(V::Null));
			spells.set(&k, V::Obj(o));
		}
		for &spell in &cl.companion_skill {
			let k = key(spell as f64);
			if spells.has(&k) {
				continue;
			}
			let o = Obj::new();
			o.set("kind", "pet");
			o.set("item", V::Null);
			o.set("name", cl.spell_names.get(&spell).filter(|s| !s.is_empty()).cloned().unwrap_or_else(|| format!("Spell {spell}")));
			o.set("class", V::Null);
			spells.set(&k, V::Obj(o));
		}
	}

	// ----- objects
	let mut want_objects: FxHashSet<u64> = FxHashSet::default();
	for it in items.values() {
		for s in it.get("sources").items() {
			if s.get("type").as_str() == Some("object") {
				want_objects.insert(s.get("object").num().to_bits());
			}
		}
	}
	for inst in instances.values() {
		for b in inst.get("bosses").items() {
			if b.get("object").truthy() {
				want_objects.insert(b.get("object").num().to_bits());
			}
		}
	}
	for q in quests_in.values() {
		for o in q.get("start").get("object").items() {
			want_objects.insert(o.num().to_bits());
		}
		for o in q.get("end").get("object").items() {
			want_objects.insert(o.num().to_bits());
		}
		for o in q.get("objectives").items() {
			if o.get("type").as_str() == Some("object") && o.get("id").truthy() {
				want_objects.insert(o.get("id").num().to_bits());
			}
		}
	}
	let objects = Obj::new();
	for (id, o) in oentries(&fv.objects) {
		let roles = o.get("roles").items();
		let treasure = roles.iter().any(|r| r.as_str() == Some("chest"));
		let mailbox = roles.iter().any(|r| r.as_str() == Some("mailbox"));
		if !treasure && !mailbox && !want_objects.contains(&str_to_num(&id).to_bits()) {
			continue;
		}
		let name = o.get("name");
		if !name.truthy() || junk(&name.to_js_string()) {
			continue;
		}
		let r = Obj::new();
		r.set("id", str_to_num(&id));
		r.set("name", name);
		r.set("treasure", treasure);
		r.set("spawns", spawns_v(&spawns_of(&o.get("spawns"), zones_in, frames_in, mailbox)));
		if mailbox {
			r.set("mailbox", true);
			let f = o.get("faction");
			r.set("faction", if matches!(f.as_str(), Some("A" | "H" | "AH")) { f } else { V::Null });
		}
		objects.set(&id, V::Obj(r));
	}
	// RareScanner treasures (rows outside Forever's zones dropped): object -> its loot.
	let mut treasure_loot: Vec<(String, Vec<f64>)> = Vec::new();
	for t in rs.map(|r| r.get("treasures").items()).unwrap_or_default() {
		let obj = t.get("object");
		if !obj.truthy() || !zones_in.get(&t.get("map").to_js_string()).truthy() {
			continue;
		}
		let id = kstr(&obj);
		let mut o = objects.get(&id);
		if !o.truthy() {
			let fo = fv.objects.get(&id);
			let name = if fo.truthy() && fo.get("name").truthy() { fo.get("name") } else { t.get("name") };
			if !name.truthy() {
				continue;
			}
			let r = Obj::new();
			r.set("id", obj.clone());
			r.set("name", name);
			r.set("treasure", true);
			r.set("spawns", V::arr());
			objects.set(&id, V::Obj(r));
			o = objects.get(&id);
		}
		o.set("treasure", true);
		if o.get("spawns").items().is_empty() {
			let pts = t.get("points");
			let pts = if pts.truthy() && !pts.items().is_empty() { pts } else { V::from(vec![V::from(vec![t.get("x"), t.get("y")])]) };
			let by_map = Obj::new();
			let m = Obj::new();
			m.set("f", V::Null);
			m.set("pts", pts);
			by_map.set(&t.get("map").to_js_string(), V::Obj(m));
			o.set("spawns", spawns_v(&spawns_of(&V::Obj(by_map), zones_in, frames_in, false)));
		}
		let i = match treasure_loot.iter().position(|x| x.0 == id) {
			Some(i) => i,
			None => {
				treasure_loot.push((id.clone(), Vec::new()));
				treasure_loot.len() - 1
			}
		};
		for it in t.get("loot").items() {
			let n = it.num();
			if !treasure_loot[i].1.contains(&n) {
				treasure_loot[i].1.push(n);
			}
		}
	}

	// ----- quests
	let quests = Obj::new();
	let mut quest_ids: BTreeSet<i64> = BTreeSet::new();
	for k in quests_in.keys() {
		quest_ids.insert(str_to_num(&k) as i64);
	}
	for k in &qr_order {
		quest_ids.insert(str_to_num(k) as i64);
	}
	let quest_of = |qid: &V| -> V {
		let q = quests_in.get(&kstr(qid));
		if q.truthy() {
			q
		} else {
			V::Null
		}
	};
	let list_or_empty = |v: V| if v.truthy() { v } else { V::arr() };
	for id in quest_ids {
		let idf = id as f64;
		let ids = key(idf);
		let q = quests_in.get(&ids);
		let r = quest_rewards.get(&ids);
		let sorted = |l: &[f64]| {
			let mut v = l.to_vec();
			v.sort_by(|a, b| by_num(*a, *b));
			nums(&v)
		};
		let rewards = r.map(|r| sorted(&r.0)).unwrap_or_else(V::arr);
		let choices = r.map(|r| sorted(&r.1)).unwrap_or_else(V::arr);
		if q.truthy() {
			let o = Obj::new();
			o.set("id", idf);
			o.set("title", q.get("title"));
			o.set("level", opt(int(&q.get("level"))));
			o.set("minLevel", opt(int(&q.get("minLevel"))));
			o.set("faction", faction_of_races(&q.get("races")));
			o.set("races", opt(int(&q.get("races"))));
			o.set("classes", opt(int(&q.get("classes"))));
			let s = q.get("start");
			let e = q.get("end");
			let start = Obj::new();
			start.set("npc", list_or_empty(s.get("npc")));
			start.set("object", list_or_empty(s.get("object")));
			start.set("item", list_or_empty(s.get("item")));
			o.set("start", V::Obj(start));
			let end = Obj::new();
			end.set("npc", list_or_empty(e.get("npc")));
			end.set("object", list_or_empty(e.get("object")));
			o.set("end", V::Obj(end));
			let escort = forge_guide::escort::is_escort(&q);
			let tame = tames_with_rod(&q);
			let objectives: Vec<V> =
				q.get("objectives").items().iter().filter(|o| matches!(o.get("type").as_str(), Some("kill" | "item" | "object" | "event"))).map(|o| objective_of(o, escort, tame)).collect();
			o.set("objectives", V::from(objectives));
			let pre = forge_guide::prereqs::blocking_prereqs(&q, &quest_of);
			o.set("pre", pre.get("all"));
			o.set("preAny", pre.get("any"));
			o.set("zone", opt(int(&q.get("zone"))));
			o.set("rewards", rewards);
			o.set("choices", choices);
			if int(&q.get("xp")).is_some_and(|x| x > 0.0) {
				o.set("xp", int(&q.get("xp")).unwrap());
			}
			if let Some((faction, standing)) = quest_rep(&q) {
				o.set("repFaction", faction);
				o.set("repStanding", standing);
			}
			quests.set(&ids, V::Obj(o));
			continue;
		}
		let f = flb_quests.get(&ids);
		let d = dungeon_quests.iter().find(|x| x.0 == idf).map(|x| x.1.clone()).unwrap_or(V::Undef);
		let title = if f.truthy() && f.get("name").truthy() {
			f.get("name")
		} else if d.truthy() {
			d.get("title")
		} else {
			V::Undef
		};
		if !title.truthy() {
			continue;
		}
		// `(f && f.x) ?? (d && d.y)`
		let pick = |fv: V, dk: &str| {
			if f.truthy() && !fv.is_nullish() {
				fv
			} else if d.truthy() {
				d.get(dk)
			} else {
				V::Undef
			}
		};
		let o = Obj::new();
		o.set("id", idf);
		o.set("title", title);
		o.set("level", opt(int(&pick(f.get("level"), "level"))));
		let ml = f.get("minLevel");
		o.set("minLevel", opt(int(&pick(if ml.is_nullish() { f.get("reqLevel") } else { ml }, "minLevel"))));
		o.set(
			"faction",
			if f.truthy() {
				side_of(&f.get("side"))
			} else if d.truthy() {
				side_of(&d.get("faction"))
			} else {
				V::Null
			},
		);
		o.set("races", V::Null);
		o.set("classes", V::Null);
		let start = Obj::new();
		let sid = f.get("start").get("id");
		start.set("npc", if f.get("start").truthy() && sid.truthy() { V::from(vec![sid]) } else { V::arr() });
		start.set("object", V::arr());
		start.set("item", V::arr());
		o.set("start", V::Obj(start));
		let end = Obj::new();
		end.set("npc", V::arr());
		end.set("object", V::arr());
		o.set("end", V::Obj(end));
		o.set("objectives", V::arr());
		o.set("pre", V::arr());
		o.set("preAny", V::arr());
		o.set("zone", V::Null);
		o.set("rewards", rewards);
		o.set("choices", choices);
		quests.set(&ids, V::Obj(o));
	}
	for rows in rep_table.values() {
		for g in rows.items() {
			if !g.get("quest").truthy() {
				continue;
			}
			let q = quests.get(&kstr(&g.get("quest")));
			if !q.truthy() {
				continue;
			}
			if q.get("repFaction").truthy() && (!q.get("repFaction").strict_eq(&g.get("faction")) || !q.get("repStanding").strict_eq(&g.get("standing"))) {
				warnings.push(format!(
					"repgates.json: quest {} asks {}/{} here, {}/{} in QuestieDB",
					kstr(&g.get("quest")),
					kstr(&g.get("faction")),
					kstr(&g.get("standing")),
					kstr(&q.get("repFaction")),
					kstr(&q.get("repStanding"))
				));
			}
			q.set("repFaction", g.get("faction"));
			q.set("repStanding", g.get("standing"));
		}
	}

	// ----- loot of rares and treasures
	let mut holder_of: FxHashMap<u64, Option<String>> = FxHashMap::default();
	for (item, list) in &cands {
		for s in list {
			let h = match s.ty {
				"drop" => format!("n{}", kstr(&s.get("npc"))),
				"object" => format!("o{}", kstr(&s.get("object"))),
				_ => continue,
			};
			let e = holder_of.entry(item.to_bits());
			match e {
				std::collections::hash_map::Entry::Vacant(v) => {
					v.insert(Some(h));
				}
				std::collections::hash_map::Entry::Occupied(mut o) => {
					if o.get().as_deref() != Some(h.as_str()) {
						o.insert(None);
					}
				}
			}
		}
	}
	// key -> [(item, chance)] in insertion order.
	type Chances = (Vec<(f64, Option<f64>)>, FxHashMap<u64, usize>);
	let mut npc_chances: FxHashMap<String, Chances> = FxHashMap::default();
	let mut object_chances: FxHashMap<String, Chances> = FxHashMap::default();
	for (item, list) in &cands {
		for s in list {
			let (table, k) = match s.ty {
				"drop" => (&mut npc_chances, kstr(&s.get("npc"))),
				"object" => (&mut object_chances, kstr(&s.get("object"))),
				_ => continue,
			};
			let m = table.entry(k).or_default();
			let ch = s.get("chance");
			let chance = if ch.is_nullish() { None } else { Some(ch.num()) };
			match m.1.get(&item.to_bits()) {
				None => {
					m.1.insert(item.to_bits(), m.0.len());
					m.0.push((*item, chance));
				}
				Some(&i) => {
					let best = &mut m.0[i];
					if let Some(c) = chance {
						if best.1.is_none_or(|b| c > b) {
							best.1 = Some(c);
						}
					}
				}
			}
		}
	}
	let loot_of = |rec: &V, holder: &str, chances: &Chances, listed: &[f64], cut: &Obj| {
		let mut ids: Vec<f64> = Vec::new();
		for id in listed.iter().chain(chances.0.iter().map(|(id, _)| id)) {
			if items.has(&key(*id)) && !ids.contains(id) {
				ids.push(*id);
			}
		}
		let own = |id: f64| -> f64 {
			if holder_of.get(&id.to_bits()).and_then(|h| h.as_deref()) == Some(holder) {
				0.0
			} else {
				1.0
			}
		};
		let ch = |id: f64| chances.1.get(&id.to_bits()).and_then(|&i| chances.0[i].1).unwrap_or(-1.0);
		let q = |id: f64| or_m1(&items.get(&key(id)).get("quality"));
		ids.sort_by(|&a, &b| {
			let d = own(a) - own(b);
			let d = if d != 0.0 { d } else { ch(b) - ch(a) };
			let d = if d != 0.0 { d } else { q(b) - q(a) };
			ord(if d != 0.0 { d } else { a - b })
		});
		rec.set("loot", nums(&ids[..ids.len().min(LOOT_CAP)]));
		if ids.len() > LOOT_CAP {
			cut.set(&kstr(&rec.get("id")), nums(&ids[LOOT_CAP..]));
		}
	};
	let none: Chances = Default::default();
	for (id, n) in npcs.entries() {
		if n.get("rare").truthy() {
			let listed = rare_loot.iter().find(|x| *x.0 == *id).map(|x| x.1.as_slice()).unwrap_or(&[]);
			loot_of(&n, &format!("n{id}"), npc_chances.get(&*id).unwrap_or(&none), listed, &cut_rare);
		} else {
			n.set("loot", V::arr());
		}
	}
	for (id, o) in objects.entries() {
		if o.get("treasure").truthy() {
			let listed = treasure_loot.iter().find(|x| *x.0 == *id).map(|x| x.1.as_slice()).unwrap_or(&[]);
			loot_of(&o, &format!("o{id}"), object_chances.get(&*id).unwrap_or(&none), listed, &cut_treasure);
		} else {
			o.set("loot", V::arr());
		}
	}

	// ----- NPCs nobody can meet
	let mut ref_npcs: FxHashSet<u64> = FxHashSet::default();
	for it in items.values() {
		for s in it.get("sources").items() {
			if s.get("npc").truthy() {
				ref_npcs.insert(s.get("npc").num().to_bits());
			}
		}
	}
	for q in quests.values() {
		for n in q.get("start").get("npc").items() {
			ref_npcs.insert(n.num().to_bits());
		}
		for n in q.get("end").get("npc").items() {
			ref_npcs.insert(n.num().to_bits());
		}
		for o in q.get("objectives").items() {
			if o.get("type").as_str() == Some("kill") && o.get("id").truthy() {
				ref_npcs.insert(o.get("id").num().to_bits());
			}
		}
	}
	for i in instances.values() {
		for b in i.get("bosses").items() {
			if b.get("npc").truthy() {
				ref_npcs.insert(b.get("npc").num().to_bits());
			}
		}
	}
	for (id, n) in npcs.entries() {
		if n.get("spawns").items().is_empty() && n.get("roles").items().is_empty() && !n.get("rare").truthy() && !n.get("boss").truthy() && !ref_npcs.contains(&str_to_num(&id).to_bits()) {
			npcs.delete(&id);
		}
	}

	// ----- Era frames referenced
	let frames = Obj::new();
	let era = frames_in.get("era");
	let want = |m: &V, f: &V| {
		if f.as_str() == Some("e") {
			let e = era.get(&kstr(m));
			if e.truthy() {
				frames.set(&kstr(m), e);
			}
		}
	};
	for n in npcs.values() {
		for s in n.get("spawns").items() {
			want(&s.get("map"), &s.get("f"));
		}
	}
	for o in objects.values() {
		for s in o.get("spawns").items() {
			want(&s.get("map"), &s.get("f"));
		}
	}
	for i in instances.values() {
		let e = i.get("entrance");
		if e.truthy() {
			want(&e.get("map"), &e.get("f"));
		}
	}
	Merged { items, npcs, objects, quests, instances, zones, factions, spells, frames, no_pvp, cut_drop, cut_rare, cut_treasure, warnings }
}

fn nn_or_null(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::Null
	}
}

trait OrObj {
	fn clone_or_obj(&self) -> V;
	/// `x ?? null`.
	fn clone_nullish(&self) -> V;
}

impl OrObj for V {
	fn clone_or_obj(&self) -> V {
		if self.truthy() {
			self.clone()
		} else {
			V::obj()
		}
	}
	fn clone_nullish(&self) -> V {
		if self.is_nullish() {
			V::Null
		} else {
			self.clone()
		}
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn words_and_standings() {
		assert!(has_word("warrior trainer", "warrior"));
		assert!(!has_word("warriors", "warrior"));
		assert!(has_word("use the taming rod to tame a beast", "taming rod to tame"));
		assert_eq!(standing_of(3000.0), 5.0);
		assert_eq!(standing_of(-100.0), 3.0);
	}
}
