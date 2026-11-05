//! guidecheck: a reader's check of written leveling guides (docs/ARCHITECTURE.md, `forge guide check`).
//! Every line of a chain (a folder of guides, in file-name order) is read as the player reads it, against
//! the reference data: each line that lacks what it needs from the lines before it is a failure, with the
//! cheapest repair for it.
//!
//! The rules were answer set programming (guide.lp, solved by clingo); they are stratified and each failure
//! picks its repair alone (one fix per failure, the cheapest), so they are plain Rust here: [`facts`] reads
//! the chain into the facts the rules use, [`check`] derives the failures and their repairs.
//!
//! Rules: itemStart (an item-started quest accepted before anything gives its item), useBefore, unsourced
//! (no source in the data or the guide), bagBefore (a quest-only drop bagged before its quest is held),
//! giver/ender, objective (a turn-in with a part never worked since the accept), kbStep (the knowledge
//! base's required step never written), noAccept, travel (a new zone with no line that moves the player),
//! continent.

use crate::data::Data;
use crate::diag::Diagnostics;
use crate::js::V;
use forge_core::jsnum::js_round;
use rustc_hash::{FxHashMap, FxHashSet};

/// Steps whose `goto` is a ride: it crosses water or a continent.
fn ride_title(t: &str) -> bool {
	crate::re!(r"(?i)^(boat|zeppelin|tram|portal|lift|ride|take the (boat|zeppelin|tram|portal))\b").is_match(t)
}
fn ride_text(t: &str) -> bool {
	crate::re!(r"(?i)\b(boat|zeppelin|tram|portal|lift|ship)\b").is_match(t)
}
/// Lines that move the player to a new place.
const MOVES: [&str; 5] = ["goto", "enter", "fly", "hearth", "die"];
/// Map types (zones.json, UIMapType).
const CONTINENT: f64 = 2.0;
const ZONE: f64 = 3.0;
/// Each capital and the zone its gates open on.
const CITY_ZONE: [(&str, &str); 6] =
	[("Orgrimmar", "Durotar"), ("Thunder Bluff", "Mulgore"), ("Undercity", "Tirisfal Glades"), ("Stormwind City", "Elwynn Forest"), ("Ironforge", "Dun Morogh"), ("Darnassus", "Teldrassil")];
/// A move goes at most this many lines (about a zone's work): further is another part of the route.
pub const MAX_MOVE: i64 = 150;
const GENERAL_DROPPERS: usize = 200;
const START_ABOVE: f64 = 3.0;
const FAR: i64 = 100000;

/// The rules, in the order the summary lists them.
pub const RULES: [&str; 11] = ["itemStart", "useBefore", "unsourced", "bagBefore", "giver", "ender", "objective", "kbStep", "noAccept", "travel", "continent"];

/// One knowledge-base step (the honest playtest's loadKb).
#[derive(Clone, Debug, PartialEq)]
pub struct KbStep {
	pub n: i64,
	pub action: String,
	pub kind: Option<String>,
	pub target: Option<i64>,
	pub item: Option<i64>,
}

/// The knowledge base's required steps by quest, in `n` order.
pub type Kb = FxHashMap<i64, Vec<KbStep>>;

/// JS `keys(x)`: an array's values, else an object's keys, as strings.
pub fn keys(x: &V) -> Vec<String> {
	if x.is_arr() {
		x.items().iter().map(V::to_js_string).collect()
	} else {
		x.keys().iter().map(|k| k.to_string()).collect()
	}
}

fn id_of(v: &V) -> Option<i64> {
	if v.is_nullish() || v.is_undef() {
		None
	} else {
		Some(v.num() as i64)
	}
}

// ---- the chain -----------------------------------------------------------------

/// One step of the chain.
#[derive(Clone, Debug)]
pub struct Step {
	pub k: usize,
	pub fi: usize,
	pub title: String,
	/// Its first and last source lines.
	pub src: usize,
	pub end: usize,
	pub when: V,
	pub goals: Vec<usize>,
	pub zone_in: Option<String>,
	pub zone_out: Option<String>,
}

/// One goal line of the chain.
#[derive(Clone, Debug, Default)]
pub struct Line {
	pub i: usize,
	pub k: usize,
	pub fi: usize,
	pub file: String,
	pub line: usize,
	pub verb: String,
	pub quest: Option<i64>,
	pub oi: Option<i64>,
	pub item: Option<i64>,
	pub npc: Option<i64>,
	pub object: Option<i64>,
	pub count: Option<f64>,
	pub level: Option<f64>,
	pub from_id: Option<i64>,
	/// `npc`, `object` or `item` written as a modifier.
	pub explicit: bool,
	pub optional: bool,
	pub map: Option<i64>,
	pub x: Option<f64>,
	pub y: Option<f64>,
	pub zone: Option<i64>,
	pub cont: Option<i64>,
	pub text: String,
	pub zone_spec: Option<String>,
}

/// One guide file of the chain.
#[derive(Clone, Debug)]
pub struct File {
	pub file: String,
	pub text: String,
	pub src: Vec<String>,
	pub header: Vec<String>,
	pub zone: Option<String>,
	pub steps: Vec<usize>,
}

/// A chain's guides as the player reads them. `lines[0]` is a placeholder: line indices start at 1, so
/// "earlier" is a plain `j < i`.
#[derive(Clone, Debug, Default)]
pub struct Chain {
	pub files: Vec<File>,
	pub steps: Vec<Step>,
	pub lines: Vec<Line>,
	pub errors: Vec<(String, usize, String)>,
}

/// A `zone` line's argument for a parsed zone spec ({ name } | { map }).
fn zone_spec(z: &V) -> Option<String> {
	if !z.truthy() {
		return None;
	}
	if !z.get("name").is_nullish() {
		return Some(z.get("name").to_js_string());
	}
	if !z.get("map").is_nullish() {
		return Some(format!("map {}", z.get("map").to_js_string()));
	}
	None
}

fn ancestor(zones: &V, map: i64, ty: f64) -> Option<i64> {
	let mut m = zones.get(&map.to_string());
	for _ in 0..8 {
		if !m.truthy() {
			return None;
		}
		if m.get("type").num() == ty && m.get("type").is_num() {
			return id_of(&m.get("id"));
		}
		m = if m.get("parent").is_nullish() { V::Null } else { zones.get(&m.get("parent").to_js_string()) };
	}
	None
}

/// The zone and continent a map belongs to (a cave or city map: its zone's).
pub fn place_of(zones: &V, map: Option<i64>) -> (Option<i64>, Option<i64>) {
	let Some(map) = map else { return (None, None) };
	let zone = ancestor(zones, map, ZONE).filter(|z| *z != 0).unwrap_or(map);
	(Some(zone), ancestor(zones, map, CONTINENT))
}

/// The chain of `files` ((path, text), in play order) against `data`.
pub fn load_chain(files: &[(String, String)], data: &Data) -> Chain {
	let mut chain = Chain { lines: vec![Line::default()], ..Default::default() };
	for (file, text) in files {
		let src: Vec<String> = text.split('\n').map(String::from).collect();
		let mut diag = Diagnostics::new();
		let ast = crate::parse::parse_guide(text, file, &mut diag);
		if !ast.truthy() {
			chain.errors.push((file.clone(), 1, "the guide does not parse".into()));
			continue;
		}
		let fi = chain.files.len();
		let steps = ast.get("steps").items();
		let first_step = if steps.is_empty() { src.len() + 1 } else { steps[0].get("line").num() as usize };
		let mut zone_now = zone_spec(&ast.get("header").get("zone"));
		chain.files.push(File {
			file: file.clone(),
			text: text.clone(),
			src: src.clone(),
			header: src[..first_step.saturating_sub(1).min(src.len())].to_vec(),
			zone: zone_now.clone(),
			steps: Vec::new(),
		});
		let res = if ast.get("id").truthy() { crate::resolve::resolve_guide(&ast, data, &mut diag, None, None) } else { V::Null };
		// Resolved goals by source line (a resolved step can hold fewer goals).
		let mut by_line: FxHashMap<usize, V> = FxHashMap::default();
		for s in res.get("steps").items() {
			for g in s.get("goals").items() {
				let l = g.hidden("_line");
				if !l.is_nullish() {
					by_line.insert(l.num() as usize, g);
				}
			}
		}
		for (si, s) in steps.iter().enumerate() {
			let next = if si + 1 < steps.len() { steps[si + 1].get("line").num() as usize } else { src.len() + 1 };
			let zone_in = zone_now.clone();
			let goals = s.get("goals").items();
			if let Some(last) = goals.last() {
				zone_now = zone_spec(&last.get("zone")).or(zone_now);
			}
			let k = chain.steps.len();
			let when = if s.get("when").is_arr() { s.get("when") } else { V::arr() };
			let title = if s.get("title").truthy() { s.get("title").to_js_string() } else { String::new() };
			chain.steps.push(Step { k, fi, title, src: s.get("line").num() as usize, end: next - 1, when, goals: Vec::new(), zone_in, zone_out: zone_now.clone() });
			chain.files[fi].steps.push(k);
			for g in &goals {
				let gl = g.get("line").num() as usize;
				let r = by_line.get(&gl).cloned().unwrap_or_else(V::obj);
				let either = |a: &V, b: &V| if !a.is_nullish() { id_of(a) } else { id_of(b) };
				let map = id_of(&r.get("map"));
				let (zone, cont) = place_of(&data.zones, map);
				let verb = g.get("verb").to_js_string();
				let i = chain.lines.len();
				let num_of = |v: V| if v.is_nullish() { None } else { Some(v.num()) };
				let count = if !g.get("count").is_nullish() { num_of(g.get("count")) } else { num_of(r.get("count")) };
				chain.lines.push(Line {
					i,
					k,
					fi,
					file: file.clone(),
					line: gl,
					quest: either(&g.get("quest"), &r.get("quest")),
					oi: either(&g.get("oi"), &r.get("oi")),
					item: either(&g.get("item"), &r.get("item")),
					npc: either(&r.get("npc"), &g.get("npc")),
					object: either(&r.get("object"), &g.get("object")),
					count,
					level: if verb == "level" && !g.get("level").is_nullish() { Some(g.get("level").num()) } else { None },
					from_id: id_of(&r.get("fromId")),
					explicit: ["npcExplicit", "objectExplicit", "itemExplicit"].iter().any(|k| g.get(k).truthy()),
					optional: g.get("optional").truthy(),
					map,
					x: num_of(r.get("x")),
					y: num_of(r.get("y")),
					zone,
					cont,
					text: src.get(gl.wrapping_sub(1)).cloned().unwrap_or_default(),
					zone_spec: zone_spec(&g.get("zone")),
					verb,
				});
				chain.steps[k].goals.push(i);
			}
		}
	}
	chain
}

// ---- facts ------------------------------------------------------------------------

/// An item a quest needs held that drops only while the quest is held: a quest item, or no vendor and fewer
/// than 200 creatures drop it.
pub fn held_only_item(it: &V) -> bool {
	if !it.truthy() {
		return false;
	}
	if it.get("questItem").truthy() {
		return true;
	}
	if !keys(&it.get("vendors")).is_empty() {
		return false;
	}
	keys(&it.get("drops").get("npc")).len() < GENERAL_DROPPERS
}

/// A step's `when has <item>` items.
pub fn when_has(when: &V) -> Vec<i64> {
	when.items().iter().filter(|p| p.get("k").as_str() == Some("has") && !p.get("neg").truthy() && !p.get("item").is_nullish()).map(|p| p.get("item").num() as i64).collect()
}

/// The facts the rules read (one field per guide.lp predicate).
#[derive(Default, Debug)]
pub struct Facts {
	pub n: usize,
	pub acc: FxHashMap<usize, i64>,
	pub accitem: FxHashMap<usize, i64>,
	pub tin: FxHashMap<usize, i64>,
	pub cmp: FxHashMap<usize, i64>,
	pub goal: FxHashMap<usize, (i64, i64)>,
	pub col: FxHashMap<usize, i64>,
	pub kil: FxHashMap<usize, i64>,
	pub int: FxHashMap<usize, i64>,
	pub use_: FxHashMap<usize, i64>,
	pub buy: FxHashMap<usize, i64>,
	pub lnpc: FxHashMap<usize, i64>,
	pub expl: FxHashSet<usize>,
	pub hasw: FxHashSet<(usize, i64)>,
	pub trav: FxHashSet<usize>,
	pub ride: FxHashSet<usize>,
	pub zchg: Vec<(usize, usize, i64, i64)>,
	pub cchg: Vec<(usize, usize)>,
	/// turn-in line -> (quest, its accept line)
	pub pair: FxHashMap<usize, (i64, usize)>,
	pub istart: Vec<(i64, i64)>,
	pub giv: FxHashSet<(i64, i64)>,
	pub givo: FxHashSet<(i64, i64)>,
	pub multig: FxHashSet<i64>,
	pub endr: FxHashSet<(i64, i64)>,
	pub endo: FxHashSet<(i64, i64)>,
	pub multie: FxHashSet<i64>,
	pub oitem: Vec<(i64, i64, i64)>,
	pub okill: Vec<(i64, i64, i64)>,
	pub oobj: Vec<(i64, i64, i64)>,
	pub oother: Vec<(i64, i64)>,
	pub qgives: FxHashSet<(i64, i64)>,
	pub qrew: FxHashSet<(i64, i64)>,
	pub dropn: Vec<(i64, i64, i64)>,
	pub dropo: Vec<(i64, i64, i64)>,
	pub vend: FxHashSet<i64>,
	pub dsrc: FxHashSet<i64>,
	pub heldonly: FxHashSet<i64>,
	pub hardstart: FxHashSet<usize>,
	pub gd: Vec<(usize, i64, i64)>,
	pub gdo: Vec<(usize, i64, i64)>,
	pub lid: FxHashMap<usize, i64>,
	pub lany: FxHashSet<(usize, i64)>,
	pub kbs: Vec<(i64, i64)>,
	pub kbitem: FxHashSet<(i64, i64, i64)>,
	pub kbany: FxHashSet<(i64, i64, i64)>,
	pub kbcmp: FxHashSet<(i64, i64)>,
}

/// The rules' facts for a chain and the data it touches; `kb`: the knowledge base's required steps (None: none).
pub fn facts(chain: &Chain, data: &Data, kb: Option<&Kb>) -> Facts {
	let mut f = Facts { n: chain.lines.len() - 1, ..Default::default() };
	let mut quests: Vec<i64> = Vec::new();
	let mut items: Vec<i64> = Vec::new();
	let mut npcs: FxHashSet<i64> = FxHashSet::default();
	let mut objects: FxHashSet<i64> = FxHashSet::default();
	let add = |v: &mut Vec<i64>, x: i64| {
		if !v.contains(&x) {
			v.push(x)
		}
	};
	let lines = &chain.lines;
	for i in 1..lines.len() {
		let l = &lines[i];
		let step = &chain.steps[l.k];
		if let Some(q) = l.quest {
			add(&mut quests, q);
		}
		if let Some(it) = l.item {
			add(&mut items, it);
		}
		match l.verb.as_str() {
			"accept" => {
				if let Some(q) = l.quest {
					f.acc.insert(i, q);
				}
				if let Some(it) = l.item {
					f.accitem.insert(i, it);
				}
			}
			"turnin" => {
				if let Some(q) = l.quest {
					f.tin.insert(i, q);
				}
			}
			"complete" => {
				if let Some(q) = l.quest {
					match l.oi {
						Some(k) => {
							f.goal.insert(i, (q, k));
						}
						None => {
							f.cmp.insert(i, q);
						}
					}
				}
			}
			"collect" => {
				if let Some(it) = l.item {
					f.col.insert(i, it);
				}
			}
			"kill" => {
				if let Some(n) = l.npc {
					f.kil.insert(i, n);
					npcs.insert(n);
				}
			}
			"interact" => {
				if let Some(o) = l.object {
					f.int.insert(i, o);
					objects.insert(o);
				}
			}
			"use" => {
				if let Some(it) = l.item {
					f.use_.insert(i, it);
				}
			}
			"buy" => {
				if let Some(it) = l.item {
					f.buy.insert(i, it);
				}
			}
			_ => {}
		}
		if let (Some(q), Some(k)) = (l.quest, l.oi) {
			if !["accept", "turnin", "complete"].contains(&l.verb.as_str()) {
				f.goal.insert(i, (q, k));
			}
		}
		if (l.verb == "accept" || l.verb == "turnin") && l.explicit {
			f.expl.insert(i);
		}
		if let Some(npc) = l.npc.filter(|_| l.verb == "accept" || l.verb == "turnin") {
			f.lnpc.insert(i, npc);
		}
		for it in when_has(&step.when) {
			f.hasw.insert((i, it));
			add(&mut items, it);
		}
		if MOVES.contains(&l.verb.as_str()) {
			f.trav.insert(i);
		}
		if l.verb == "hearth" || (l.verb == "goto" && (ride_title(&step.title) || ride_text(&l.text))) {
			f.ride.insert(i);
		}
	}
	// Place changes between consecutive placed lines. A capital and the zone around it are one place.
	let zname = |z: i64| data.zones.get(&z.to_string()).get("name").as_str().map(String::from);
	let city = |a: &Option<String>| CITY_ZONE.iter().find(|(c, _)| Some(c.to_string()) == *a).map(|(_, z)| z.to_string());
	// As the JS compares them: a zone without a name matches a city's missing entry too.
	let same_city = |a: i64, b: i64| {
		let (na, nb) = (zname(a), zname(b));
		city(&na) == nb || city(&nb) == na
	};
	let mut prev = 0;
	for i in 1..lines.len() {
		let l = &lines[i];
		let Some(z) = l.zone else { continue };
		if prev != 0 {
			let p = &lines[prev];
			let pz = p.zone.unwrap();
			if pz != z && !same_city(pz, z) {
				f.zchg.push((prev, i, pz, z));
			}
			if let (Some(a), Some(b)) = (p.cont, l.cont) {
				if a != b {
					f.cchg.push((prev, i));
				}
			}
		}
		prev = i;
	}
	// Each turn-in's accept: the last accept of its quest before it.
	let mut last_acc: FxHashMap<i64, usize> = FxHashMap::default();
	for i in 1..lines.len() {
		let l = &lines[i];
		let Some(q) = l.quest else { continue };
		if l.verb == "accept" {
			last_acc.insert(q, i);
		}
		if l.verb == "turnin" {
			if let Some(&j) = last_acc.get(&q) {
				f.pair.insert(i, (q, j));
			}
		}
	}
	// Reference data for the chain's quests and the items they touch.
	for &q in &quests {
		let d = data.quests.get(&q.to_string());
		if !d.truthy() {
			continue;
		}
		let st = d.get("start");
		let giver_n = keys(&st.get("npc")).len() + keys(&st.get("object")).len();
		if giver_n == 0 {
			for it in keys(&st.get("item")) {
				let it: i64 = it.parse().unwrap_or(0);
				f.istart.push((q, it));
				add(&mut items, it);
			}
		}
		for n in keys(&st.get("npc")) {
			f.giv.insert((q, n.parse().unwrap_or(0)));
		}
		for o in keys(&st.get("object")) {
			f.givo.insert((q, o.parse().unwrap_or(0)));
		}
		if giver_n > 1 {
			f.multig.insert(q);
		}
		let en = d.get("end");
		for n in keys(&en.get("npc")) {
			f.endr.insert((q, n.parse().unwrap_or(0)));
		}
		for o in keys(&en.get("object")) {
			f.endo.insert((q, o.parse().unwrap_or(0)));
		}
		if keys(&en.get("npc")).len() + keys(&en.get("object")).len() > 1 {
			f.multie.insert(q);
		}
		for (k, o) in d.get("objectives").items().iter().enumerate() {
			let kk = k as i64 + 1;
			let id = o.get("id").num() as i64;
			match o.get("type").as_str() {
				Some("item") => {
					f.oitem.push((q, kk, id));
					add(&mut items, id);
				}
				Some("kill") => f.okill.push((q, kk, id)),
				Some("object") => f.oobj.push((q, kk, id)),
				_ => f.oother.push((q, kk)),
			}
		}
		if d.get("sourceItem").truthy() {
			f.qgives.insert((q, d.get("sourceItem").num() as i64));
		}
		for r in d.get("web").get("items").items() {
			let r = if r.is_arr() { r.at(0) } else { r };
			f.qrew.insert((q, r.num() as i64));
		}
	}
	for &it in &items {
		let d = data.items.get(&it.to_string());
		if !d.truthy() {
			continue;
		}
		let mut sourced = false;
		// The chain's own mobs and objects, plus the best dropper (a repair's source).
		let mut droppers = |kind: &str, set: &FxHashSet<i64>, out: &mut Vec<(i64, i64, i64)>| {
			let drops = d.get("drops").get(kind);
			let all: Vec<(String, i64)> = drops
				.entries()
				.iter()
				.map(|(e, c)| {
					let v = js_round(c.num() * 100.0);
					(e.to_string(), if v.is_nan() { 0 } else { v as i64 })
				})
				.collect();
			if all.is_empty() {
				return;
			}
			sourced = true;
			let mut top = &all[0];
			for a in &all {
				if a.1 > top.1 {
					top = a;
				}
			}
			for (e, c) in &all {
				let eid: i64 = e.parse().unwrap_or(0);
				if set.contains(&eid) || *e == top.0 {
					out.push((it, eid, *c));
				}
			}
		};
		droppers("npc", &npcs, &mut f.dropn);
		droppers("object", &objects, &mut f.dropo);
		if !keys(&d.get("vendors")).is_empty() {
			f.vend.insert(it);
			sourced = true;
		}
		if !keys(&d.get("containers")).is_empty() {
			sourced = true;
		}
		if sourced {
			f.dsrc.insert(it);
		}
		if held_only_item(&d) {
			f.heldonly.insert(it);
		}
	}
	hard_starts(chain, data, &mut f);
	kb_facts(chain, kb, &mut f);
	dist_facts(chain, data, &mut f);
	f
}

/// An item-started accept whose item's droppers are all rares, elites or 3+ levels above the player there
/// (the last `level N` line, else the guide's lowest level): the item may never come.
fn hard_starts(chain: &Chain, data: &Data, f: &mut Facts) {
	let mut lvl: f64 = 1.0;
	let mut fi = usize::MAX;
	for i in 1..chain.lines.len() {
		let l = &chain.lines[i];
		if l.fi != fi {
			fi = l.fi;
			if let Some(m) = crate::re!(r"(?m)^levels\s+(\d+)").captures(&chain.files[fi].header.join("\n")) {
				lvl = lvl.max(m[1].parse().unwrap_or(0.0));
			}
		}
		if let Some(v) = l.level {
			lvl = lvl.max(v);
		}
		if l.verb != "accept" {
			continue;
		}
		let q = data.quests.get(&l.quest.map(|q| q.to_string()).unwrap_or_default());
		let st = q.get("start");
		if !keys(&st.get("npc")).is_empty() || !keys(&st.get("object")).is_empty() {
			continue;
		}
		let its: Vec<String> = match l.item {
			Some(it) => vec![it.to_string()],
			None => keys(&st.get("item")),
		};
		let droppers: Vec<String> = its.iter().flat_map(|it| keys(&data.items.get(it).get("drops").get("npc"))).collect();
		let objs: usize = its.iter().map(|it| keys(&data.items.get(it).get("drops").get("object")).len()).sum();
		if droppers.is_empty() || objs > 0 {
			continue;
		}
		let hard = droppers.iter().all(|e| {
			let n = data.npcs.get(e);
			let rank = n.get("rank");
			let level = if n.get("level").is_nullish() { f64::NAN } else { n.get("level").num() };
			(rank.is_num() && [1.0, 2.0, 4.0].contains(&rank.num())) || level >= lvl + START_ABOVE
		});
		if hard {
			f.hardstart.insert(i);
		}
	}
}

/// Distance (map percent x 10; another map: FAR) from a point to the nearest spawn on its map.
fn nearest(spawns: &V, map: Option<i64>, x: Option<f64>, y: Option<f64>) -> i64 {
	let (Some(map), Some(x)) = (map, x) else { return FAR };
	let s = spawns.get(&map.to_string());
	if !s.truthy() {
		return FAR;
	}
	let y = y.unwrap_or(f64::NAN);
	let mut best = FAR;
	for p in s.get("pts").items() {
		let d = js_round(10.0 * (p.at(0).num() - x).hypot(p.at(1).num() - y));
		if !d.is_nan() {
			best = best.min(d as i64);
		}
	}
	best
}

/// The distance from the route's point (the last placed line before) to each giver or ender of an accept or
/// turn-in whose quest has several, or whose resolved NPC is none of them.
fn dist_facts(chain: &Chain, data: &Data, f: &mut Facts) {
	let mut at: Option<usize> = None;
	for i in 1..chain.lines.len() {
		let l = &chain.lines[i];
		if l.verb == "accept" || l.verb == "turnin" {
			let d = data.quests.get(&l.quest.map(|q| q.to_string()).unwrap_or_default());
			let side = if l.verb == "accept" { d.get("start") } else { d.get("end") };
			if d.truthy() && side.truthy() {
				let ns = keys(&side.get("npc"));
				let os = keys(&side.get("object"));
				let wrong = l.npc.is_some_and(|n| !ns.contains(&n.to_string()));
				if ns.len() + os.len() > 1 || wrong {
					let p = at.map(|a| &chain.lines[a]).unwrap_or(l);
					for n in &ns {
						f.gd.push((i, n.parse().unwrap_or(0), nearest(&data.npcs.get(n).get("spawns"), p.map, p.x, p.y)));
					}
					for o in &os {
						f.gdo.push((i, o.parse().unwrap_or(0), nearest(&data.objects.get(o).get("spawns"), p.map, p.x, p.y)));
					}
				}
			}
		}
		if l.map.is_some() && l.x.is_some() && l.verb != "accept" && l.verb != "turnin" {
			at = Some(i);
		}
	}
}

const BY_ITEM: [&str; 3] = ["use-item", "combine", "buy"];

fn kb_facts(chain: &Chain, kb: Option<&Kb>, f: &mut Facts) {
	let Some(kb) = kb else { return };
	let mut done: FxHashSet<i64> = FxHashSet::default();
	for i in 1..chain.lines.len() {
		let l = &chain.lines[i];
		if let Some(it) = l.item {
			f.lid.insert(i, it);
		}
		for v in [l.item, l.npc, l.object, l.from_id].into_iter().flatten() {
			f.lany.insert((i, v));
		}
		let Some(q) = l.quest else { continue };
		if l.verb != "turnin" || !done.insert(q) {
			continue;
		}
		for st in kb.get(&q).map(Vec::as_slice).unwrap_or(&[]) {
			f.kbs.push((q, st.n));
			if let Some(item) = st.item.filter(|_| BY_ITEM.contains(&st.action.as_str())) {
				f.kbitem.insert((q, st.n, item));
			} else {
				for v in [st.item, st.target].into_iter().flatten() {
					f.kbany.insert((q, st.n, v));
				}
			}
			if st.action == "collect-object" || st.action == "buy" {
				f.kbcmp.insert((q, st.n));
			}
		}
	}
}

// ---- the rules -------------------------------------------------------------------

/// A repair term: its name and arguments (guide.lp's fix/5 last argument).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Fix {
	pub name: String,
	pub args: Vec<i64>,
}

fn fix(name: &str, args: &[i64]) -> Fix {
	Fix { name: name.into(), args: args.to_vec() }
}

/// One failure: its rule, line and arguments (guide.lp's fail/4) and the cheapest repair.
#[derive(Clone, Debug)]
pub struct Failure {
	pub rule: &'static str,
	pub i: usize,
	pub a: i64,
	pub b: i64,
	pub fix: Option<Fix>,
}

/// guide.lp: the failures of a chain and, for each, the cheapest repair.
pub fn check(f: &Facts) -> Vec<Failure> {
	let n = f.n;
	let lines = 1..=n;
	// Where an item can come from.
	let mut src: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
	let mut push_src = |it: i64, j: usize| src.entry(it).or_default().push(j);
	for (&j, &it) in &f.col {
		push_src(it, j);
	}
	for (&j, &o) in &f.int {
		for &(it, oo, _) in &f.dropo {
			if oo == o {
				push_src(it, j);
			}
		}
	}
	for (&j, &it) in &f.buy {
		push_src(it, j);
	}
	for (&j, &q) in &f.acc {
		for &(qq, it) in &f.qgives {
			if qq == q {
				push_src(it, j);
			}
		}
	}
	for (&j, &q) in &f.tin {
		for &(qq, it) in &f.qrew {
			if qq == q {
				push_src(it, j);
			}
		}
	}
	for v in src.values_mut() {
		v.sort_unstable();
		v.dedup();
	}
	let mut killsrc: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
	for (&j, &nn) in &f.kil {
		for &(it, d, _) in &f.dropn {
			if d == nn {
				killsrc.entry(it).or_default().push(j);
			}
		}
	}
	for v in killsrc.values_mut() {
		v.sort_unstable();
		v.dedup();
	}
	let srcs = |it: i64| src.get(&it).map(Vec::as_slice).unwrap_or(&[]);
	let kills = |it: i64| killsrc.get(&it).map(Vec::as_slice).unwrap_or(&[]);
	let start_bag = |it: i64| f.istart.iter().any(|&(_, x)| x == it) && !f.dsrc.contains(&it) && srcs(it).is_empty() && kills(it).is_empty();
	let istart_of = |q: i64| f.istart.iter().filter(move |&&(qq, _)| qq == q).map(|&(_, it)| it);
	// need(It,I): what line I needs.
	let needs = |i: usize, it: i64| f.accitem.get(&i) == Some(&it) || f.use_.get(&i) == Some(&it) || f.acc.get(&i).is_some_and(|&q| istart_of(q).any(|x| x == it));
	let had = |it: i64, i: usize| needs(i, it) && (srcs(it).iter().any(|&j| j < i) || (f.acc.contains_key(&i) && kills(it).iter().any(|&j| j < i)) || f.hasw.contains(&(i, it)) || start_bag(it));
	let mut fails: Vec<(&'static str, usize, i64, i64)> = Vec::new();
	let mut add = |r: &'static str, i: usize, a: i64, b: i64| {
		if !fails.contains(&(r, i, a, b)) {
			fails.push((r, i, a, b));
		}
	};
	// R2 itemStart.
	for i in lines.clone() {
		if let Some(&q) = f.acc.get(&i) {
			let startok = istart_of(q).any(|it| had(it, i));
			if !startok && !f.accitem.contains_key(&i) {
				for it in istart_of(q) {
					add("itemStart", i, q, it);
				}
			}
			if let Some(&it) = f.accitem.get(&i) {
				if !had(it, i) {
					add("itemStart", i, q, it);
				}
			}
		}
	}
	// R3 items.
	let goal_q = |i: usize| f.goal.get(&i).copied();
	let other_src = |it: i64, i: usize| f.col.get(&i) == Some(&it) && srcs(it).iter().any(|&j| j != i && f.col.get(&j) != Some(&it));
	let mut unsourced0: FxHashSet<(usize, i64)> = FxHashSet::default();
	for i in lines.clone() {
		if let Some(&it) = f.use_.get(&i) {
			if !f.dsrc.contains(&it) && srcs(it).is_empty() && !start_bag(it) {
				add("unsourced", i, it, 0);
				unsourced0.insert((i, it));
			}
		}
		if let Some(&it) = f.col.get(&i) {
			match goal_q(i) {
				Some((q, k)) => {
					if f.oitem.contains(&(q, k, it)) && !f.dsrc.contains(&it) && !other_src(it, i) {
						add("unsourced", i, it, q);
					}
				}
				None => {
					if !f.dsrc.contains(&it) && !other_src(it, i) {
						add("unsourced", i, it, 0);
						unsourced0.insert((i, it));
					}
				}
			}
		}
	}
	for i in lines.clone() {
		if let Some(&it) = f.use_.get(&i) {
			if !had(it, i) && !unsourced0.contains(&(i, it)) {
				add("useBefore", i, it, 0);
			}
		}
	}
	let accs_of = |q: i64| {
		let mut v: Vec<usize> = f.acc.iter().filter(|(_, &qq)| qq == q).map(|(&j, _)| j).collect();
		v.sort_unstable();
		v
	};
	let tins_of = |q: i64| {
		let mut v: Vec<usize> = f.tin.iter().filter(|(_, &qq)| qq == q).map(|(&j, _)| j).collect();
		v.sort_unstable();
		v
	};
	for i in lines.clone() {
		let Some(&it) = f.col.get(&i) else { continue };
		if !f.heldonly.contains(&it) || goal_q(i).is_some() {
			continue;
		}
		// In the facts' order (the quests as the chain meets them), as clingo printed them.
		let mut qs: Vec<i64> = Vec::new();
		for &(q, _, x) in &f.oitem {
			if x == it && !qs.contains(&q) {
				qs.push(q);
			}
		}
		for q in qs {
			// bag(I,Q); held: an accept before I with no turn-in between it and I.
			let accs = accs_of(q);
			let tins = tins_of(q);
			let held = accs.iter().any(|&j| j < i && !tins.iter().any(|&t| j < t && t < i));
			let accl = accs.iter().any(|&j| j > i);
			if !held && accl {
				add("bagBefore", i, it, q);
			}
		}
	}
	// R4 giver / ender.
	let hasgiv = |q: i64| f.giv.iter().any(|&(qq, _)| qq == q) || f.givo.iter().any(|&(qq, _)| qq == q);
	let hasend = |q: i64| f.endr.iter().any(|&(qq, _)| qq == q) || f.endo.iter().any(|&(qq, _)| qq == q);
	for i in lines.clone() {
		if let Some(&q) = f.acc.get(&i) {
			if let Some(&nn) = f.lnpc.get(&i) {
				if hasgiv(q) && !f.giv.contains(&(q, nn)) && !f.accitem.contains_key(&i) && istart_of(q).next().is_none() {
					add("giver", i, q, nn);
				}
			}
			if f.multig.contains(&q) && !f.expl.contains(&i) && !f.accitem.contains_key(&i) {
				add("giver", i, q, 0);
			}
		}
		if let Some(&q) = f.tin.get(&i) {
			if let Some(&nn) = f.lnpc.get(&i) {
				if hasend(q) && !f.endr.contains(&(q, nn)) {
					add("ender", i, q, nn);
				}
			}
			if f.multie.contains(&q) && !f.expl.contains(&i) {
				add("ender", i, q, 0);
			}
		}
	}
	// R5 objectives.
	let mut parts: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for &(q, k, _) in &f.oitem {
		parts.entry(q).or_default().push(k);
	}
	for &(q, k, _) in &f.okill {
		parts.entry(q).or_default().push(k);
	}
	for &(q, k, _) in &f.oobj {
		parts.entry(q).or_default().push(k);
	}
	for &(q, k) in &f.oother {
		parts.entry(q).or_default().push(k);
	}
	for v in parts.values_mut() {
		v.sort_unstable();
		v.dedup();
	}
	let mut pairs: Vec<(usize, i64, usize)> = f.pair.iter().map(|(&i, &(q, j))| (i, q, j)).collect();
	pairs.sort_unstable();
	for &(i, q, j) in &pairs {
		let range = (j + 1)..i;
		let any_in = |pred: &dyn Fn(usize) -> bool| range.clone().any(pred);
		let cmp_in = any_in(&|g| f.cmp.get(&g) == Some(&q));
		for &k in parts.get(&q).map(Vec::as_slice).unwrap_or(&[]) {
			let mut cov = any_in(&|g| f.goal.get(&g) == Some(&(q, k))) || cmp_in;
			if !cov {
				for &(qq, kk, nn) in &f.okill {
					if qq == q && kk == k && any_in(&|g| f.kil.get(&g) == Some(&nn)) {
						cov = true;
					}
				}
				for &(qq, kk, o) in &f.oobj {
					if qq == q && kk == k && any_in(&|g| f.int.get(&g) == Some(&o)) {
						cov = true;
					}
				}
				for &(qq, kk, it) in &f.oitem {
					if qq != q || kk != k {
						continue;
					}
					let by_kill = any_in(&|g| f.kil.get(&g).is_some_and(|nn| f.dropn.iter().any(|&(x, d, _)| x == it && d == *nn)));
					let by_obj = any_in(&|g| f.int.get(&g).is_some_and(|o| f.dropo.iter().any(|&(x, d, _)| x == it && d == *o)));
					let by_col = any_in(&|g| f.col.get(&g) == Some(&it) || f.buy.get(&g) == Some(&it));
					// Bagged before the accept (anyone can loot it) and not handed in elsewhere since.
					let early = !f.heldonly.contains(&it)
						&& (1..j).any(|g| f.col.get(&g) == Some(&it) && !f.tin.iter().any(|(&t, &q2)| q2 != q && g < t && t < i && f.oitem.iter().any(|&(x, _, y)| x == q2 && y == it)));
					if by_kill || by_obj || by_col || early || f.qgives.contains(&(q, it)) {
						cov = true;
					}
				}
			}
			if !cov {
				add("objective", i, q, k);
			}
		}
		// The knowledge base's required steps.
		for &(qq, nn) in &f.kbs {
			if qq != q {
				continue;
			}
			let ok = f.kbitem.iter().any(|&(x, m, it)| x == q && m == nn && any_in(&|g| f.lid.get(&g) == Some(&it)))
				|| f.kbany.iter().any(|&(x, m, v)| x == q && m == nn && any_in(&|g| f.lany.contains(&(g, v))))
				|| (f.kbcmp.contains(&(q, nn)) && cmp_in);
			if !ok {
				add("kbStep", i, q, nn);
			}
		}
	}
	for i in lines.clone() {
		if let Some(&q) = f.tin.get(&i) {
			if !f.pair.contains_key(&i) {
				add("noAccept", i, q, 0);
			}
		}
	}
	// R1 travel.
	for &(j, i, z1, z2) in &f.zchg {
		let moved = ((j + 1)..=i).any(|k| f.trav.contains(&k)) || f.ride.contains(&j);
		if !moved {
			add("travel", i, z1, z2);
		}
	}
	for &(j, i) in &f.cchg {
		if !(j..=i).any(|k| f.ride.contains(&k)) {
			add("continent", i, j as i64, 0);
		}
	}
	// ---- repairs: one per failure, the cheapest.
	let needfix: Vec<(usize, i64)> = fails.iter().filter(|x| x.0 == "itemStart").map(|x| (x.1, x.3)).chain(fails.iter().filter(|x| x.0 == "useBefore").map(|x| (x.1, x.2))).collect();
	let in_reach = |i: usize, j: usize| j > i && (j as i64) <= i as i64 + MAX_MOVE;
	let later = |i: usize, it: i64, item_start: bool| {
		let mut v: Vec<usize> = srcs(it).iter().copied().filter(|&j| in_reach(i, j)).collect();
		if item_start {
			v.extend(kills(it).iter().copied().filter(|&j| in_reach(i, j)));
		}
		v.sort_unstable();
		v.dedup();
		v
	};
	// later(I,_,J) is over every item line I needs fixed; drag counts the quest's goals and turn-ins between.
	let mv = |i: usize, j: usize| {
		let mut gs: FxHashSet<usize> = FxHashSet::default();
		if needfix.iter().any(|&(x, _)| x == i) {
			if let Some(&q) = f.acc.get(&i) {
				for g in (i + 1)..j {
					if f.goal.get(&g).is_some_and(|&(qq, _)| qq == q) || f.tin.get(&g) == Some(&q) {
						gs.insert(g);
					}
				}
			}
		}
		1 + (j - i) as i64 / 40 + 3 * gs.len() as i64
	};
	let best = |it: i64| -> Option<i64> { f.dropn.iter().chain(f.dropo.iter()).filter(|x| x.0 == it).map(|x| x.2).chain(f.vend.contains(&it).then_some(10000)).max() };
	let mut out: Vec<Failure> = Vec::new();
	for &(rule, i, a, b) in &fails {
		let mut opts: Vec<(Fix, i64)> = Vec::new();
		match rule {
			"itemStart" => {
				let it = b;
				let l = later(i, it, true);
				// later(I,It,J) from either needfix rule of this line and item.
				for &j in &l {
					opts.push((fix("move", &[j as i64]), mv(i, j)));
				}
				let p = best(it);
				if let Some(p) = p.filter(|&p| p > 0) {
					opts.push((fix("source", &[it]), 4 + (10000 - p) / 1000));
				}
				if p.is_none_or(|p| p < 1000) && !f.hardstart.contains(&i) {
					opts.push((fix("whenhas", &[it]), 2));
				}
				if f.hardstart.contains(&i) && l.is_empty() {
					opts.push((fix("whenhas", &[it]), 1));
				}
			}
			"useBefore" => {
				let it = a;
				// The item may also be an itemStart item of this line: its kills count as later too.
				let is_start = fails.iter().any(|x| x.0 == "itemStart" && x.1 == i && x.3 == it);
				for &j in &later(i, it, is_start) {
					opts.push((fix("move", &[j as i64]), mv(i, j) + 2));
				}
				for &j in &later(i, it, is_start) {
					if f.col.get(&j) == Some(&it) && f.dsrc.contains(&it) {
						opts.push((fix("copy", &[j as i64]), 2));
					}
				}
				if let Some(p) = best(it).filter(|&p| p > 0) {
					opts.push((fix("source", &[it]), 4 + (10000 - p) / 1000));
				}
			}
			"bagBefore" => {
				for j in accs_of(b) {
					if j > i {
						opts.push((fix("move", &[j as i64]), 1 + (j - i) as i64 / 40));
					}
				}
				opts.push((fix("drop", &[]), 3));
			}
			"unsourced" => opts.push((fix("leaveout", &[]), 1)),
			"giver" | "ender" => {
				let (np, op) = if rule == "giver" { (&f.giv, &f.givo) } else { (&f.endr, &f.endo) };
				for &(ii, nn, d) in &f.gd {
					if ii == i && np.contains(&(a, nn)) {
						opts.push((fix("npc", &[nn]), d));
					}
				}
				for &(ii, o, d) in &f.gdo {
					if ii == i && op.contains(&(a, o)) {
						opts.push((fix("object", &[o]), d));
					}
				}
			}
			"objective" => {
				let nogoal = f.oitem.iter().any(|&(q, k, it)| q == a && k == b && !f.dsrc.contains(&it) && !f.qgives.contains(&(q, it)));
				if !nogoal {
					opts.push((fix("addgoal", &[a, b]), 1));
				}
			}
			"kbStep" => opts.push((fix("addkb", &[a, b]), 1)),
			"noAccept" => opts.push((fix("addaccept", &[a]), 1)),
			"travel" => opts.push((fix("travel", &[]), 1)),
			"continent" => opts.push((fix("ride", &[]), 1)),
			_ => {}
		}
		// A fix's cost: the sum of its distinct weights (guide.lp's #minimize counts each weight once).
		let mut costs: Vec<(Fix, Vec<i64>)> = Vec::new();
		for (fx, w) in opts {
			match costs.iter_mut().find(|c| c.0 == fx) {
				Some(c) => {
					if !c.1.contains(&w) {
						c.1.push(w);
					}
				}
				None => costs.push((fx, vec![w])),
			}
		}
		let costs: Vec<(Fix, i64)> = costs.into_iter().map(|(fx, ws)| (fx, ws.iter().sum())).collect();
		// Among equally cheap repairs clingo's optimum (guide.lp) took the second listed, when there were
		// several: so do we, for the same repairs.
		let min = costs.iter().map(|c| c.1).min();
		let tied: Vec<&Fix> = costs.iter().filter(|c| Some(c.1) == min).map(|c| &c.0).collect();
		let fix = tied.get(1).or(tied.first()).map(|f| (*f).clone());
		out.push(Failure { rule, i, a, b, fix });
	}
	out
}

// ---- words ---------------------------------------------------------------------

struct Namer<'a>(&'a Data);

impl Namer<'_> {
	fn name(t: &V, key: &str, kind: &str, id: i64) -> String {
		let v = t.get(&id.to_string()).get(key);
		format!("{} ({id})", if v.truthy() { v.to_js_string() } else { kind.to_string() })
	}
	fn q(&self, id: i64) -> String {
		Self::name(&self.0.quests, "title", "quest", id)
	}
	fn it(&self, id: i64) -> String {
		Self::name(&self.0.items, "name", "item", id)
	}
	fn npc(&self, id: i64) -> String {
		Self::name(&self.0.npcs, "name", "NPC", id)
	}
	fn obj(&self, id: i64) -> String {
		Self::name(&self.0.objects, "name", "object", id)
	}
	fn zone(&self, id: Option<i64>) -> String {
		let id = id.unwrap_or(0);
		let v = self.0.zones.get(&id.to_string()).get("name");
		if v.truthy() {
			v.to_js_string()
		} else {
			format!("map {id}")
		}
	}
	fn part(&self, q: i64, k: i64) -> String {
		let o = self.0.quests.get(&q.to_string()).get("objectives").at((k - 1).max(0) as usize);
		if k < 1 || !o.truthy() {
			return "?".into();
		}
		let what = if o.get("text").truthy() { o.get("text") } else { o.get("id") };
		let count = if o.get("count").truthy() { o.get("count").to_js_string() } else { "1".into() };
		format!("{} {} x{count}", o.get("type").to_js_string(), what.to_js_string())
	}
}

fn describe(f: &Failure, chain: &Chain, n: &Namer) -> String {
	let (a, b) = (f.a, f.b);
	match f.rule {
		"itemStart" => format!("{} is accepted before anything in the guide gives {}, the item that starts it", n.q(a), n.it(b)),
		"useBefore" => format!("use {} before any line gives it", n.it(a)),
		"unsourced" => format!("{} has no source in the data and no earlier line gives it", n.it(a)),
		"bagBefore" => format!("{} is collected before {} is held: it drops only while the quest is in the log", n.it(a), n.q(b)),
		"giver" => {
			if b != 0 {
				format!("{} does not give {}", n.npc(b), n.q(a))
			} else {
				format!("{} has several givers and the line names none", n.q(a))
			}
		}
		"ender" => {
			if b != 0 {
				format!("{} does not take {}", n.npc(b), n.q(a))
			} else {
				format!("{} has several enders and the line names none", n.q(a))
			}
		}
		"objective" => format!("{} is turned in with part {b} ({}) never worked since the accept", n.q(a), n.part(a, b)),
		"kbStep" => format!("{} is turned in with the knowledge base's required step {b} never written since the accept", n.q(a)),
		"noAccept" => format!("{} is turned in but never accepted", n.q(a)),
		"travel" => format!("the guide moves from {} to {} with no line that takes the player there", n.zone(Some(a)), n.zone(Some(b))),
		"continent" => {
			let from = chain.lines.get(a as usize).and_then(|l| l.zone);
			let to = chain.lines.get(f.i).and_then(|l| l.zone);
			format!("the guide changes continent ({} to {}) with no boat, zeppelin, portal or hearth", n.zone(from), n.zone(to))
		}
		r => r.to_string(),
	}
}

fn basename(p: &str) -> &str {
	p.rsplit(['/', '\\']).next().unwrap_or(p)
}

fn repair_text(fix: &Option<Fix>, chain: &Chain, n: &Namer) -> String {
	let Some(fix) = fix else { return "none found".into() };
	let at = |li: i64| match chain.lines.get(li as usize).filter(|_| li > 0) {
		Some(l) => format!("{}:{}", basename(&l.file), l.line),
		None => format!("line {li}"),
	};
	let a = fix.args.first().copied().unwrap_or(0);
	let b = fix.args.get(1).copied().unwrap_or(0);
	match fix.name.as_str() {
		"move" => format!("move it after {} (it gives what this line needs)", at(a)),
		"copy" => format!("copy {} (the collect that gets it) before it", at(a)),
		"source" => format!("add a step that gets {} before it", n.it(a)),
		"whenhas" => format!("gate it on `when has {a}` (a rare drop)"),
		"drop" => "drop the bag count".into(),
		"leaveout" => "leave the quest out of the route (nothing gives the item)".into(),
		"npc" => format!("name `npc {a}`, {}", n.npc(a)),
		"object" => format!("name `object {a}`, {}", n.obj(a)),
		"addgoal" => format!("add the goal for {a}.{b} before the turn-in"),
		"addkb" => format!("add the knowledge base's step {a}.{b} (its buy, use or loot) before the turn-in"),
		"addaccept" => format!("add `accept {a}` before the turn-in"),
		"travel" => "add a travel step to the next place (writer travel pass)".into(),
		"ride" => "add the boat, zeppelin or portal step (writer travel pass)".into(),
		other => other.into(),
	}
}

/// A failure as reported: where, what and the repair in words.
#[derive(Clone, Debug)]
pub struct Reported {
	pub rule: &'static str,
	pub file: String,
	pub line: usize,
	pub message: String,
	pub repair: String,
	pub fix: Option<Fix>,
	pub i: usize,
	pub args: [i64; 2],
}

/// checkFiles: the chain of `files` against `data`, its failures in line order (then rule name).
pub fn check_files(files: &[(String, String)], data: &Data, kb: Option<&Kb>) -> (Chain, Vec<Reported>) {
	let chain = load_chain(files, data);
	let f = facts(&chain, data, kb);
	let n = Namer(data);
	let mut out: Vec<Reported> = chain
		.errors
		.iter()
		.map(|(file, line, message)| Reported { rule: "parse", file: file.clone(), line: *line, message: message.clone(), repair: "none".into(), fix: None, i: 0, args: [0, 0] })
		.collect();
	let mut fails = check(&f);
	fails.sort_by(|x, y| x.i.cmp(&y.i).then_with(|| x.rule.cmp(y.rule)));
	for x in fails {
		let l = &chain.lines[x.i];
		out.push(Reported {
			rule: x.rule,
			file: l.file.clone(),
			line: l.line,
			message: describe(&x, &chain, &n),
			repair: repair_text(&x.fix, &chain, &n),
			fix: x.fix.clone(),
			i: x.i,
			args: [x.a, x.b],
		});
	}
	(chain, out)
}

/// findChains: every folder of .guide files under `dir`, one chain per folder, in file-name order; catch-up
/// guides are left out (branches).
#[cfg(feature = "native")]
pub fn find_chains(dir: &std::path::Path) -> Vec<Vec<std::path::PathBuf>> {
	let mut chains = Vec::new();
	fn walk(d: &std::path::Path, out: &mut Vec<Vec<std::path::PathBuf>>) {
		let Ok(rd) = std::fs::read_dir(d) else { return };
		let mut ents: Vec<_> = rd.flatten().collect();
		ents.sort_by_key(|e| e.file_name());
		let catchup = crate::re!(r"(?i)catchup");
		let mut guides: Vec<std::path::PathBuf> = ents
			.iter()
			.filter(|e| e.file_type().is_ok_and(|t| t.is_file()))
			.map(|e| e.file_name().to_string_lossy().into_owned())
			.filter(|n| n.ends_with(".guide") && !catchup.is_match(n))
			.map(|n| d.join(n))
			.collect();
		guides.sort_by(|a, b| crate::js::cmp_utf16(&a.to_string_lossy(), &b.to_string_lossy()));
		if !guides.is_empty() {
			out.push(guides);
		}
		for e in &ents {
			let name = e.file_name().to_string_lossy().into_owned();
			if e.file_type().is_ok_and(|t| t.is_dir()) && name != "node_modules" && !name.starts_with('.') {
				walk(&e.path(), out);
			}
		}
	}
	walk(dir, &mut chains);
	chains
}
