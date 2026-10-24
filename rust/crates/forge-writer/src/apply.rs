//! Apply a route found by the Rust simulator's search (forge-sim, seeded with v1's order)
//! to v1's guides: v1 improved, written in v1's own lines (port of
//! tools/lib/improve/apply-route.js; the output is byte for byte the JS writer's).
//!
//! The route: order = [{ t: accept | turnin | task | train | level, q, task, pt, from }],
//! `from` the v1 goal line the item is ('guides/forever/....guide:LINE'), 'inserted' for an
//! added quest, 'train stop' for an added training stop; diff.dropped: the quests it leaves out.
//!
//! The writer:
//!   - v1's goal lines go in the route's order. Consecutive lines of one v1 step stay one step
//!     (its title, `only`/`when`/`zone`/`loop` lines on every piece; tips, `label`, `along`,
//!     `image` and the comments above it on the first piece). A goal line the route does not
//!     name goes with the next goal line of its step the route names (the last one when none
//!     follows); a step with none goes whole before the piece holding the next named line.
//!   - An added quest: `accept Q` at its giver, each objective once at the first of its tasks,
//!     `turnin Q`, as steps of their own where the route puts them. A training stop: `train class`.
//!   - A dropped quest's goal lines go.
//!   - Guides: the chain's guides keep their headers; each guide boundary is put where the
//!     fewest lines land outside their own v1 guide. A piece in another zone gets a `zone` line.
//!   - A changed guide gets a comment block after its header naming the route, the quests added
//!     and dropped there and how many goals moved in.

use crate::guide::{is_goal, next_of, parse_guide, races_of, Key, Kind, Line, Step};
use crate::input::{Data, Entity, Item, ItemT, Order, OrderT, Pt, Route, World};
use crate::jsre::{head, head_ws, is_step, num, split_comment, split_sentences, starts_num, trim, trim_end};
use crate::post;
use crate::re;
use forge_core::frames::{Frame, MapFrames, Projector, RoutePoint};
use forge_core::jsnum::{js_hypot, js_to_fixed, js_to_string};
use forge_world::atlas::SubzoneOf;
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::BTreeMap;

// Yards from a flight master within which v1's `fly` line is flown from.
// A flight between known paths away from the ends is written when it saves this much walking.
const FLY_SAVES_YD: f64 = 1500.0;
const FLY_FROM_YD: f64 = 300.0;
// A typed point this far from the route's point for the same work is another camp.
const TYPED_FAR_YD: f64 = 1000.0;
// Yards from a v1 boat or zeppelin goto within which the route's characters take it.
const RIDE_FROM_YD: f64 = 1500.0;
// Yards from the route's point within which a spawn is the camp it went to.
const ARRIVAL_CAMP_YD: f64 = 300.0;
// Yards from an inn within which a route event is "at the inn".
const BIND_AT_YD: f64 = 250.0;
// Yards from a quest's ender within which a spawn is "the camp at the ender".
const ENDER_CAMP_YD: f64 = 400.0;
// Mob kinds dropping an item beyond which it is a zone-wide drop.
const WIDE_DROPPERS: usize = 20;
// Yards a zone change may span with no travel line (honest playtest R1).
const ZONE_STEP_YD: f64 = 600.0;

pub const FACTION_RACES_HORDE: [&str; 5] = ["Orc", "Troll", "Tauren", "Undead", "Skyborne"];
pub const FACTION_RACES_ALLIANCE: [&str; 5] = ["Human", "Dwarf", "Gnome", "NightElf", "Skyborne"];
pub const ALL_RACES: [&str; 9] = ["Orc", "Troll", "Tauren", "Undead", "Skyborne", "Human", "Dwarf", "Gnome", "NightElf"];
const CLASSES: [&str; 9] = ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"];

pub fn faction_races(faction: Option<&str>) -> Vec<String> {
	match faction {
		Some("Horde") => FACTION_RACES_HORDE.iter().map(|s| s.to_string()).collect(),
		Some("Alliance") => FACTION_RACES_ALLIANCE.iter().map(|s| s.to_string()).collect(),
		_ => Vec::new(),
	}
}

/// What apply_route reads. `guides`: the guides folder's files, by path relative to it
/// ("forever/horde/orc-troll/01-durotar.guide").
pub struct Inputs<'a> {
	pub route: &'a Route,
	pub guides: &'a BTreeMap<String, String>,
	pub world: &'a World,
	pub data: &'a Data,
	pub frames: &'a MapFrames,
	/// The client's area at a world point (the walking grid's area ids); None: not known.
	pub area_at: Option<&'a dyn SubzoneOf>,
	/// R4 (engine rule): a v1 `level N` the route's grind item reaches earlier is written with the
	/// route's fraction (`level 15.91`). Off: the JS writer's bytes.
	pub level_fraction: bool,
	/// The route's own legs (engine rule r8c 1): between two of the route's items in
	/// different places, the route's own leg (its flight, boat, hearth, else a walk) is written and v1's
	/// travel lines between them are the other races'; flight masters are chosen by walking yards. Off:
	/// v1's travel stands where it moves them (the JS writer's).
	pub route_travel: bool,
	/// Routed walking yards between world points (the walk store), where it has them.
	pub walks: Option<&'a dyn forge_sim::walks::Walks>,
}

/// What apply_route wrote: the chain's guides (relative path, text), in chain order.
#[derive(Debug, Default)]
pub struct Output {
	pub files: Vec<(String, String)>,
	pub unwritable: Vec<u32>,
	pub added: Vec<u32>,
	pub dropped: Vec<u32>,
	pub moved: usize,
	pub unplaced: usize,
	pub log: Vec<String>,
	/// For the travel repair (travel.rs): the chain, its races and the guides other races play too.
	pub travel: crate::travel::Travel,
}

/// `guides/<rel>.guide:N` -> (rel, N), `path.join` normalized.
fn rel_of(from: Option<&str>) -> Option<(String, u32)> {
	let m = re!(r"^(.*\.guide):(\d+)$").captures(from?)?;
	// (Some routes name the guides folder twice: guides/guides/forever/….)
	let mut rel = &m[1];
	while let Some(r) = rel.strip_prefix("guides/") {
		rel = r;
	}
	Some((normalize(rel), m[2].parse().ok()?))
}

fn normalize(p: &str) -> String {
	let mut out: Vec<&str> = Vec::new();
	for part in p.split('/') {
		match part {
			"" | "." => {}
			".." => {
				out.pop();
			}
			_ => out.push(part),
		}
	}
	out.join("/")
}

/// The quest a line works or hands in: `accept|turnin|complete Q` or `quest Q[.N]`.
pub fn quest_of(text: &str) -> Option<u32> {
	if let Some(m) = re!(r"^\s+(?:accept|turnin|complete)\s+(\d+)\b").captures(text) {
		return m[1].parse().ok();
	}
	re!(r"\bquest\s+(\d+)(?:\.\d+)?\b").captures(text).and_then(|m| m[1].parse().ok())
}

/// `quests[s]` for a string from a line: only the canonical spelling of a number is a key.
pub fn qkey(s: &str) -> Option<u32> {
	if s.len() > 1 && s.starts_with('0') {
		return None;
	}
	s.parse().ok()
}

/// The `only` list at the end of a line's code (`\sonly\s+(\S+)\s*$`).
pub fn line_only(text: &str) -> Option<&str> {
	let code = split_comment(text).0;
	re!(r"\sonly\s+(\S+)\s*$").captures(code).map(|m| m.get(1).unwrap().as_str())
}

fn only_classes(list: Option<&str>) -> bool {
	list.is_some_and(|l| l.split(',').any(|x| CLASSES.contains(&trim(x))))
}

fn is_word_at(text: &str, word: &str) -> bool {
	head(text) == Some(word)
}

/// `/^\s+word\s/`.
fn is_head_ws(text: &str, word: &str) -> bool {
	head_ws(text) == Some(word)
}

/// A spawn near the route's point: its map and the coordinates written for it.
#[derive(Clone, Debug)]
struct Near {
	map: u32,
	d: f64,
	at: String,
}

struct Ins {
	title: String,
	lines: Vec<String>,
	map: Option<u32>,
}

#[derive(Clone, Debug)]
enum PieceKind {
	/// Route lines of its own (an added quest, a training stop) or only route items (`lines` empty).
	Ins {
		pt: Option<u32>,
		map: Option<u32>,
		title: Option<String>,
		lines: Vec<String>,
		q: Option<u32>,
		t: Option<OrderT>,
		to_way: bool,
	},
	Orphan(usize),
	Step {
		step: usize,
		keys: Vec<Key>,
	},
}

#[derive(Clone, Debug)]
struct Piece {
	gi: i64,
	kind: PieceKind,
	items: Option<Vec<Item>>,
}

struct FlyFrom {
	f0: usize,
	dest: usize,
}

/// What the writing reads: the chain, its steps, the route's lines and the world.
struct Ctx<'a> {
	/// The route's v1 lines in v1's order (step, line): a gap between two of them adjacent here is v1's own.
	v1_rank: FxHashMap<Key, usize>,
	route_travel: bool,
	walks: Option<&'a dyn forge_sim::walks::Walks>,
	world: &'a World,
	data: &'a Data,
	proj: Projector,
	era: FxHashSet<u32>,
	area_at: Option<&'a dyn SubzoneOf>,
	guide_races: Vec<Vec<String>>,
	steps: Vec<Step>,
	step_of: FxHashMap<Key, usize>,
	named: FxHashSet<Key>,
	key_pt: FxHashMap<Key, u32>,
	/// v1 `level` lines the route's grind items name -> the route's target.
	level_at: FxHashMap<Key, f64>,
	ender_keys: FxHashSet<Key>,
	items_at_line: FxHashMap<Key, Vec<Item>>,
	before: FxHashMap<Key, Vec<Line>>,
	after: FxHashMap<Key, Vec<Line>>,
	orphan: FxHashMap<Key, Vec<usize>>,
	carried: FxHashSet<Key>,
	has_items: bool,
	route_races: Vec<String>,
	other_races: Vec<String>,
	dropped: FxHashSet<u32>,
	dropped_items: FxHashSet<u32>,
	v1_piers: Vec<Pier>,
	wq: FxHashMap<u32, usize>,
	zone_ids: Vec<(u32, String)>,
}

struct Pier {
	x: String,
	y: String,
	/// " live" when v1's coordinates are the live map's.
	live: String,
	kind: String,
	dest: String,
	zone: String,
}

impl<'a> Ctx<'a> {
	fn w(&self, pt: Option<u32>) -> Option<Pt> {
		self.world.points.get(pt? as usize).copied()
	}

	fn zone_name(&self, map: Option<u32>) -> Option<String> {
		self.world.zones.get(&map?).filter(|z| !z.is_empty()).cloned()
	}

	fn covers(&self, dst: usize, src: usize) -> bool {
		let d = &self.guide_races[dst];
		let r = &self.guide_races[src];
		d.is_empty() || (!r.is_empty() && r.iter().all(|x| d.contains(x)))
	}

	fn shared(&self, file: usize) -> bool {
		self.guide_races.get(file).is_none_or(|r| r.is_empty())
	}

	fn step_line(&self, key: Key) -> Option<&Line> {
		self.steps[*self.step_of.get(&key)?].line(key.1)
	}

	/// The races a step or line's `only` list names (None: none named).
	fn only_races(list: Option<&str>) -> Option<Vec<String>> {
		let rs: Vec<String> = list?.split(',').map(|x| trim(x).to_string()).filter(|x| ALL_RACES.contains(&x.strip_prefix('!').unwrap_or(x))).collect();
		(!rs.is_empty()).then_some(rs)
	}

	/// Every character of the route's races sees it.
	fn for_all_r(&self, list: Option<&str>) -> bool {
		let Some(l) = list else { return true };
		if l.is_empty() {
			return true;
		}
		if only_classes(Some(l)) {
			return false;
		}
		let Some(rs) = Self::only_races(Some(l)) else { return true };
		if rs.iter().any(|r| r.starts_with('!')) {
			return !rs.iter().any(|r| self.route_races.iter().any(|x| r.get(1..) == Some(x.as_str())));
		}
		self.route_races.iter().all(|r| rs.contains(r))
	}

	fn others_only(&self, text: &str) -> String {
		let code = split_comment(text).0;
		let tail = re!(r"\s--\s.*$").find(text).map_or("", |m| m.as_str());
		format!("{} only {}{}", trim_end(code), self.other_races.join(","), tail)
	}

	fn dropped_line(&self, text: &str, key: Option<Key>) -> bool {
		if let Some(bag) = re!(r"^\s+collect\s+(\d+)\b").captures(text) {
			if !re!(r"\bquest\s+\d").is_match(text) && bag[1].parse().is_ok_and(|b: u32| self.dropped_items.contains(&b)) && !key.is_some_and(|k| self.named.contains(&k)) {
				return true;
			}
		}
		quest_of(text).is_some_and(|q| self.dropped.contains(&q))
	}

	fn coords_of(&self, pt: Option<u32>) -> String {
		let Some(p) = self.w(pt) else { return String::new() };
		let b = self.proj.bounds(p.map);
		if b.right == b.left {
			return String::new();
		}
		let x = ((p.wy - b.left) / (b.right - b.left)) * 100.0;
		let y = ((p.wx - b.top) / (b.bottom - b.top)) * 100.0;
		if !((0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)) {
			return String::new();
		}
		let live = !self.era.contains(&p.map);
		format!(" @{},{} map {}{}", js_to_fixed(x, 1), js_to_fixed(y, 1), p.map, if live { " live" } else { "" })
	}

	fn frame_area(&self, map: u32) -> f64 {
		let b = self.proj.bounds(map);
		((b.bottom - b.top) * (b.right - b.left)).abs()
	}

	/// The spawn of a target nearest the route's point (see apply-route.js spawnNear).
	fn spawn_near(&self, recs: &[&Entity], pt: Option<u32>) -> Option<Near> {
		struct C {
			map: u32,
			w: RoutePoint,
			d: f64,
			/// The spawn as the data gives it: x, y in its own frame.
			raw: (f64, f64, Frame),
		}
		let p = self.w(pt);
		let mut all: Vec<C> = Vec::new();
		for rec in recs {
			for (&map, sp) in &rec.spawns {
				let f = if sp.f.as_deref() == Some("l") { Frame::Live } else { Frame::Era };
				for q in &sp.pts {
					let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
					let w = self.proj.point(map, c(0), c(1), Some(f));
					if !w.wx.is_finite() || !((0.0..=100.0).contains(&w.x) && (0.0..=100.0).contains(&w.y)) {
						continue;
					}
					let d = match p {
						Some(p) if w.c == p.c => js_hypot(w.wx - p.wx, w.wy - p.wy),
						_ => 1e9,
					};
					all.push(C { map, w, d, raw: (c(0), c(1), f) });
				}
			}
		}
		if all.is_empty() {
			return None;
		}
		let mut bi = 0;
		for (i, c) in all.iter().enumerate() {
			if c.d < all[bi].d {
				bi = i;
			}
		}
		let best = &all[bi];
		let twins: Vec<usize> = (0..all.len()).filter(|&i| all[i].map != best.map && all[i].w.c == best.w.c && js_hypot(all[i].w.wx - best.w.wx, all[i].w.wy - best.w.wy) <= 60.0).collect();
		if !twins.is_empty() {
			let cands: Vec<usize> = std::iter::once(bi).chain(twins).collect();
			let zone = self.area_at.and_then(|a| a.at(best.w.c, best.w.wx, best.w.wy));
			let matched = zone.and_then(|z| cands.iter().copied().find(|&i| self.data.zones.get(&all[i].map).is_some_and(|zz| zz.area_id == Some(z.zone_id as f64))));
			bi = matched.unwrap_or_else(|| {
				let mut a = cands[0];
				for &b in &cands[1..] {
					if self.frame_area(all[b].map) < self.frame_area(all[a].map) {
						a = b;
					}
				}
				a
			});
		}
		// The spawn in its own frame: the compiler finds a pin's spawns in the pin's frame, so a live
		// spawn written as Era coordinates matched none of them, and the goal showed one pin instead of
		// the pin with every other place the target spawns.
		let best = &all[bi];
		let (x, y, f) = best.raw;
		Some(Near { map: best.map, d: best.d, at: format!(" @{},{} map {}{}", js_to_fixed(x, 1), js_to_fixed(y, 1), best.map, if f == Frame::Live { " live" } else { "" }) })
	}

	fn map_of_pt(&self, pt: Option<u32>) -> Option<u32> {
		self.w(pt).map(|p| p.map)
	}

	fn targets(&self, kind: &str, id: f64) -> Vec<&Entity> {
		let id = if id >= 0.0 && id.fract() == 0.0 && id <= u32::MAX as f64 { Some(id as u32) } else { None };
		let Some(id) = id else { return Vec::new() };
		match kind {
			"kill" | "talk" => self.data.npcs.get(&id).into_iter().collect(),
			"object" => self.data.objects.get(&id).into_iter().collect(),
			"item" => {
				let Some(d) = self.data.items.get(&id).and_then(|i| i.drops.as_ref()) else { return Vec::new() };
				d.object.keys().filter_map(|o| self.data.objects.get(o)).chain(d.npc.keys().filter_map(|n| self.data.npcs.get(n))).collect()
			}
			_ => Vec::new(),
		}
	}

	fn inn_name(&self, i: Option<usize>) -> Option<&str> {
		self.world.inns.get(i?)?.name.as_deref().filter(|n| !n.is_empty())
	}

	fn inn_pt(&self, name: &str) -> Option<u32> {
		self.world.inns.iter().find(|i| i.name.as_deref() == Some(name))?.pt
	}

	/// Where a v1 line is done: the route's point for it, else its quest giver or ender, else the
	/// flight master it learns.
	fn line_pt(&self, l: &Line) -> Option<u32> {
		if let Some(&p) = self.key_pt.get(&l.key()) {
			return Some(p);
		}
		if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(&l.text) {
			let q = &self.world.quests[*self.wq.get(&m[2].parse().ok()?)?];
			return if &m[1] == "accept" { q.giver } else { q.ender };
		}
		if let Some(m) = re!(r#"^\s+sethome\s+"([^"]+)""#).captures(&l.text) {
			return self.inn_pt(&m[1]);
		}
		let m = re!(r#"^\s+getfp\s+"([^"]+)""#).captures(&l.text)?;
		self.world.nodes[self.fp_by_name(&m[1])?].pt
	}

	fn fp_by_name(&self, name: &str) -> Option<usize> {
		self.world.nodes.iter().position(|n| n.kind == "fp" && (n.name == name || n.name.split(',').next() == Some(name)))
	}

	/// The known flight path nearest pt on its continent.
	fn fp_near_known(&self, pt: Option<u32>, known: &FxHashSet<usize>) -> Option<usize> {
		let p = self.w(pt)?;
		let mut best = None;
		let mut bd = f64::INFINITY;
		for &i in known {
			let n = &self.world.nodes[i];
			if n.kind != "fp" {
				continue;
			}
			let Some(q) = self.w(n.pt) else { continue };
			if q.c != p.c {
				continue;
			}
			let d = js_hypot(q.wx - p.wx, q.wy - p.wy);
			if d < bd || (d == bd && best.is_some_and(|b| i < b)) {
				bd = d;
				best = Some(i);
			}
		}
		best
	}

	/// Walking yards between two world points: the walk store's, else the straight line (same continent).
	fn walk_yd(&self, a: Option<u32>, b: Option<u32>) -> f64 {
		let (Some(pa), Some(pb)) = (self.w(a), self.w(b)) else { return f64::INFINITY };
		if pa.c != pb.c {
			return f64::INFINITY;
		}
		if a == b {
			return 0.0;
		}
		self.walks.and_then(|w| w.yards(a.unwrap(), b.unwrap())).unwrap_or_else(|| js_hypot(pa.wx - pb.wx, pa.wy - pb.wy))
	}

	/// The route's leg from `start` to `to` on one continent: the flight between known flight paths
	/// quickest by walking yards to and from them, when it beats the walk. -> (from, to) nodes.
	fn best_flight(&self, start: Option<u32>, to: Option<u32>, known: &FxHashSet<usize>) -> Option<(usize, usize)> {
		const WALK_YPS: f64 = 7.0;
		const FLY_YPS: f64 = 25.0;
		const FLY_S: f64 = 60.0;
		let p = self.w(start)?;
		let fps: Vec<usize> = known.iter().copied().filter(|&k| self.world.nodes.get(k).is_some_and(|n| n.kind == "fp" && self.w(n.pt).is_some_and(|q| q.c == p.c))).collect();
		let walk = self.walk_yd(start, to) / WALK_YPS;
		let mut best: Option<(f64, usize, usize)> = None;
		for &a in &fps {
			let wa = self.walk_yd(start, self.world.nodes[a].pt) / WALK_YPS;
			if wa >= walk {
				continue;
			}
			for &b in &fps {
				if a == b {
					continue;
				}
				let (Some(qa), Some(qb)) = (self.w(self.world.nodes[a].pt), self.w(self.world.nodes[b].pt)) else { continue };
				let s = wa + js_hypot(qa.wx - qb.wx, qa.wy - qb.wy) / FLY_YPS + FLY_S + self.walk_yd(self.world.nodes[b].pt, to) / WALK_YPS;
				if s < walk && best.is_none_or(|x| s < x.0) {
					best = Some((s, a, b));
				}
			}
		}
		best.map(|(_, a, b)| (a, b))
	}

	fn fp_near(&self, pt: Option<u32>) -> Option<usize> {
		let p = self.w(pt);
		let mut best = None;
		let mut bd = f64::INFINITY;
		for (i, n) in self.world.nodes.iter().enumerate() {
			if n.kind != "fp" {
				continue;
			}
			let q = self.w(n.pt);
			let (Some(p), Some(q)) = (p, q) else { continue };
			if q.c != p.c {
				continue;
			}
			let d = js_hypot(q.wx - p.wx, q.wy - p.wy);
			if d < bd {
				bd = d;
				best = Some(i);
			}
		}
		best
	}

	/// The sea crossing from A's continent to B's (see apply-route.js crossing).
	fn crossing(&self, a: Pt, b: Pt) -> Option<Crossing> {
		let mut best = None;
		let mut bd = f64::INFINITY;
		let kind_re = re!(r"(?i)\((boat|zeppelin|tram)\)$");
		for r in &self.world.rides {
			let na = r.a.and_then(|i| self.world.nodes.get(i));
			let nb = r.b.and_then(|i| self.world.nodes.get(i));
			let (Some(na), Some(nb)) = (na, nb) else { continue };
			if na.kind != "dock" || nb.kind != "dock" {
				continue;
			}
			let Some(k) = kind_re.captures(&na.name) else { continue };
			if !kind_re.is_match(&nb.name) {
				continue;
			}
			let (Some(f), Some(t)) = (self.w(na.pt), self.w(nb.pt)) else { continue };
			if f.c != a.c || t.c != b.c {
				continue;
			}
			let d = js_hypot(f.wx - a.wx, f.wy - a.wy) + js_hypot(t.wx - b.wx, t.wy - b.wy);
			if d < bd {
				bd = d;
				let k1 = &k[1];
				let mut kind = k1[..1].to_uppercase();
				kind.push_str(&k1[1..].to_lowercase());
				best = Some(Crossing { dep: na.pt, arr: nb.pt, kind, dest: re!(r"(?i)\s*\((boat|zeppelin|tram)\)$").replace(&nb.name, "").into_owned() });
			}
		}
		best
	}

	/// v1 trains in the step of the route's next v1 line, or in a step before it that the
	/// route writes with it (the Orgrimmar stop after Kargath).
	fn v1_trains_next(&self, order: &[Order], i: usize) -> bool {
		let races_ok = |list: Option<&str>| -> bool {
			match Self::only_races(list) {
				None => true,
				Some(rs) => self.for_all_r(Some(&rs.join(","))),
			}
		};
		for o in &order[i + 1..] {
			let Some(key) = o.key else { continue };
			let mut steps: Vec<usize> = self.orphan.get(&key).cloned().unwrap_or_default();
			if let Some(&st) = self.step_of.get(&key) {
				steps.push(st);
			}
			return steps.iter().any(|&x| {
				let s = &self.steps[x];
				s.lines.iter().any(|l| re!(r"^\s+train\s+class\b").is_match(&l.text) && races_ok(line_only(&l.text)))
					&& !s.lines.iter().any(|l| is_head_ws(&l.text, "only") && !races_ok(Some(trim(&re!(r"^\s+only\s+").replace(&l.text, "")))))
			});
		}
		false
	}
}

struct Crossing {
	dep: Option<u32>,
	arr: Option<u32>,
	kind: String,
	dest: String,
}

fn coords_re(s: &str) -> Option<[String; 4]> {
	let c = re!(r"^ @([\d.]+),([\d.]+) map (\d+)( live)?").captures(s)?;
	Some([c[1].to_string(), c[2].to_string(), c[3].to_string(), c.get(4).map_or(String::new(), |m| m.as_str().to_string())])
}

fn opt_str(z: &Option<String>) -> &str {
	z.as_deref().unwrap_or("null")
}

fn truthy(z: &Option<String>) -> bool {
	z.as_deref().is_some_and(|s| !s.is_empty())
}

pub fn apply_route(inp: &Inputs) -> Result<Output, String> {
	let route = inp.route;
	let data = inp.data;
	let world = inp.world;
	let mut log = Vec::new();
	let quest = |q: u32| data.quests.get(&q);
	let dedup = |xs: &[u32]| -> Vec<u32> {
		let mut seen = FxHashSet::default();
		xs.iter().copied().filter(|x| seen.insert(*x)).collect()
	};
	let mut dropped_list = dedup(route.diff.as_ref().map_or(&[][..], |d| &d.dropped));
	let added_list = dedup(route.diff.as_ref().map_or(&[][..], |d| &d.added));
	// A quest v1 offers only after an optional start the route does not take (Manhunt, 147, in a
	// step `when turnedin 123`, the rare Gruff Swiftbite's Gold Pickup Schedule, #553) is not the
	// route's to drop: v1's lines stay for the player who found the start.
	{
		let taken: FxHashSet<u32> = route.order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
		let left_out: FxHashSet<u32> = dropped_list.iter().copied().collect();
		let mut follows: FxHashSet<u32> = FxHashSet::default();
		for text in inp.guides.values() {
			let mut gated = false;
			for l in text.split('\n') {
				if re!(r"^step\s").is_match(l) {
					gated = false;
				} else if let Some(m) = re!(r"^\s+when\s+(?:turnedin|onquest|complete)\s+([\d ,]+)").captures(l) {
					gated = m[1].split([',', ' ']).filter_map(|x| x.parse::<u32>().ok()).any(|q| !taken.contains(&q) && !left_out.contains(&q));
				} else if gated {
					if let Some(q) = quest_of(l) {
						follows.insert(q);
					}
				}
			}
		}
		dropped_list.retain(|q| !follows.contains(q));
	}
	let dropped: FxHashSet<u32> = dropped_list.iter().copied().collect();

	// The chain's files in chain order: by the median route position of their lines (a line
	// moved far ahead must not reorder the guides).
	let mut pos_of: Vec<(String, Vec<usize>)> = Vec::new();
	let mut pos_idx: FxHashMap<String, usize> = FxHashMap::default();
	for (i, o) in route.order.iter().enumerate() {
		let Some((f, _)) = rel_of(o.from.as_deref()) else { continue };
		let k = *pos_idx.entry(f.clone()).or_insert_with(|| {
			pos_of.push((f, Vec::new()));
			pos_of.len() - 1
		});
		pos_of[k].1.push(i);
	}
	let median = |xs: &Vec<usize>| xs[xs.len() >> 1];
	let mut by_median: Vec<usize> = (0..pos_of.len()).collect();
	by_median.sort_by_key(|&k| median(&pos_of[k].1));
	let read = |f: &str| -> Result<&String, String> { inp.guides.get(f).ok_or_else(|| format!("apply-route: no guide {f}")) };
	// The chain's order is v1's (each guide's first `next`), from the guide of the route's
	// first line; guides it does not reach follow by the median of their route positions.
	let mut chain: Vec<String> = Vec::new();
	let mut f = if by_median.is_empty() { None } else { route.order.iter().find_map(|o| rel_of(o.from.as_deref())).map(|r| r.0) };
	while let Some(ff) = f.take() {
		if !pos_idx.contains_key(&ff) || chain.contains(&ff) {
			break;
		}
		let text = read(&ff)?;
		chain.push(ff);
		f = next_of(text).map(|id| normalize(&format!("{id}.guide")));
	}
	// The chain the addon plays (the travel repair plays it), before the others.
	let played_chain = chain.clone();
	for &k in &by_median {
		if !chain.contains(&pos_of[k].0) {
			chain.push(pos_of[k].0.clone());
		}
	}
	let file_idx: FxHashMap<String, usize> = chain.iter().enumerate().map(|(i, f)| (f.clone(), i)).collect();
	let key_of = |from: Option<&str>| -> Option<Key> {
		let (f, n) = rel_of(from)?;
		Some((*file_idx.get(&f)?, n))
	};
	let mut guides = Vec::new();
	for (i, f) in chain.iter().enumerate() {
		guides.push(parse_guide(i, read(f)?));
	}
	// Who plays a guide: its `race` header (none: every race of the faction).
	let guide_races: Vec<Vec<String>> = guides.iter().map(|g| races_of(&g.header)).collect();
	// Every step, by file:line of its lines.
	let mut steps: Vec<Step> = Vec::new();
	let mut guide_steps: Vec<std::ops::Range<usize>> = Vec::new();
	let mut headers = Vec::new();
	for g in guides {
		let start = steps.len();
		for mut s in g.steps {
			s.k = steps.len();
			steps.push(s);
		}
		guide_steps.push(start..steps.len());
		headers.push((g.header, g.header_zone));
	}
	let mut step_of: FxHashMap<Key, usize> = FxHashMap::default();
	for (k, s) in steps.iter().enumerate() {
		for l in &s.lines {
			step_of.insert(l.key(), k);
		}
	}
	let step_line = |steps: &[Step], step_of: &FxHashMap<Key, usize>, key: Key| -> Option<Line> { steps[*step_of.get(&key)?].line(key.1).cloned() };

	// A task's objectives go to the v1 line of each (`quest Q.N`).
	let mut obj_lines: FxHashMap<String, Vec<Key>> = FxHashMap::default();
	for st in &steps {
		for l in &st.lines {
			if l.kind != Kind::Goal {
				continue;
			}
			if let Some(m) = re!(r"\bquest\s+(\d+\.\d+)\b").captures(&l.text) {
				obj_lines.entry(m[1].to_string()).or_default().push(l.key());
			}
		}
	}
	let mut wq: FxHashMap<u32, usize> = FxHashMap::default();
	for (i, q) in world.quests.iter().enumerate() {
		wq.insert(q.id, i);
	}
	// Items the chain's v1 lines buy or count in the bags (no quest of their own).
	let mut v1_gets: FxHashSet<u32> = FxHashSet::default();
	for st in &steps {
		for l in &st.lines {
			if let Some(m) = re!(r"^\s+(buy|collect)\s+(\d+)\b").captures(&l.text) {
				if !re!(r"\bquest\s+\d").is_match(&l.text) {
					if let Ok(x) = m[2].parse() {
						v1_gets.insert(x);
					}
				}
			}
		}
	}

	let mut order0: Vec<Order> = route.order.clone();
	for o in &mut order0 {
		o.key = key_of(o.from.as_deref());
	}
	// Two route events v1 does in one step, one right after the other: no travel between them.
	let same_step = |a: Option<&Order>, b: Option<&Order>| -> bool {
		let (Some(ka), Some(kb)) = (a.and_then(|o| o.key), b.and_then(|o| o.key)) else { return false };
		step_of.get(&ka).is_some_and(|s| step_of.get(&kb) == Some(s))
	};
	// An item-started accept the route takes before the rest of its v1 step: written with that
	// step's next event (Merrick's Bow).
	let mut reordered = order0;
	let mut i: isize = 0;
	while (i as usize) < reordered.len() {
		let iu = i as usize;
		let o = &reordered[iu];
		let item_started = o.t == OrderT::Accept && o.q.and_then(quest).is_some_and(|r| !r.start_items().is_empty());
		if !item_started {
			i += 1;
			continue;
		}
		let Some(st) = o.key.and_then(|k| step_of.get(&k)).copied() else {
			i += 1;
			continue;
		};
		let in_step = |x: Option<&Order>| x.and_then(|x| x.key).and_then(|k| step_of.get(&k)) == Some(&st);
		if in_step(reordered.get(iu + 1)) {
			i += 1;
			continue;
		}
		let Some(j) = (iu + 1..reordered.len()).find(|&k| in_step(reordered.get(k))) else {
			i += 1;
			continue;
		};
		let o = reordered.remove(iu);
		reordered.insert(j - 1, o);
		// i-- then i++: look at index i again.
	}
	let has_items = reordered.iter().any(|o| !o.items().is_empty());
	let mut ender_keys: FxHashSet<Key> = FxHashSet::default();
	let mut together: Vec<Order> = Vec::with_capacity(reordered.len());
	for (i, o) in reordered.iter().enumerate() {
		let travel = o.items().iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network));
		let strip = travel
			&& ((i > 0 && same_step(reordered.get(i - 1), Some(o))) || {
				// So too travel to a task handed in right after in its own v1 step.
				let nx = reordered.get(i + 1);
				let handed = o.t == OrderT::Task && nx.is_some_and(|nx| nx.t == OrderT::Turnin && nx.q == o.q && same_step(Some(o), Some(nx)) && o.from != nx.from);
				handed && {
					match o.key.and_then(|k| step_line(&steps, &step_of, k)) {
						Some(l) if re!(r"^\s+(kill|collect|interact)\s+\d+").is_match(&l.text) && !re!(r"@\s*[\d.]").is_match(&l.text) => {
							ender_keys.insert(l.key());
							true
						}
						_ => false,
					}
				}
			});
		let mut o = o.clone();
		if strip {
			o.items = Some(o.items().iter().filter(|x| !matches!(x.t, ItemT::Hearth | ItemT::Network)).cloned().collect());
		}
		together.push(o);
	}
	// A bind the route makes at a `train` event goes to the next event at the inn.
	let p_of = |pt: Option<u32>| pt.and_then(|p| world.points.get(p as usize).copied());
	let near_inn = |o: &Order, x: &Item| -> bool {
		let a = p_of(o.pt);
		let b = p_of(if x.inn_pt.is_some() { x.inn_pt } else { x.pt });
		matches!((a, b), (Some(a), Some(b)) if a.c == b.c && js_hypot(a.wx - b.wx, a.wy - b.wy) <= BIND_AT_YD)
	};
	for i in 0..together.len() {
		if together[i].t != OrderT::Train || together[i].items.is_none() {
			continue;
		}
		let binds: Vec<Item> = together[i].items().iter().filter(|y| y.t == ItemT::Bind).cloned().collect();
		for x in binds {
			let mut j = i + 1;
			while j < together.len() && !(together[j].t != OrderT::Train && near_inn(&together[j], &x)) && !together[j].items().iter().any(|y| matches!(y.t, ItemT::Bind | ItemT::Hearth)) {
				j += 1;
			}
			if j >= together.len() || together[j].t == OrderT::Train || !near_inn(&together[j], &x) {
				continue;
			}
			let its = together[i].items.as_mut().unwrap();
			if let Some(p) = its.iter().position(|y| *y == x) {
				its.remove(p);
			}
			together[j].items.get_or_insert_with(Vec::new).push(x);
		}
	}
	// v1's crossings: `goto x,y "Boat to Stormwind"` and its zone.
	let mut v1_piers = Vec::new();
	for st in &steps {
		for l in &st.lines {
			let Some(m) = re!(r#"^\s+goto\s+([\d.]+),([\d.]+)\s+"(Boat|Zeppelin|Tram|Ship) to ([^"]+)"( live)?"#).captures(&l.text) else { continue };
			if truthy(&l.zone) && !re!(r"\bmap\s+\d").is_match(&l.text) {
				v1_piers.push(Pier {
					x: m[1].to_string(),
					y: m[2].to_string(),
					live: m.get(5).map_or(String::new(), |x| x.as_str().to_string()),
					kind: if &m[3] == "Ship" { "Boat".into() } else { m[3].to_string() },
					dest: re!(r"\s+Harbou?r$").replace(&m[4], "").into_owned(),
					zone: l.zone.clone().unwrap(),
				});
			}
		}
	}
	let mut route_order: Vec<Order> = Vec::new();
	// v1 lines a route item goes with (a bind at a shop v1 buys from).
	let mut items_at_line: FxHashMap<Key, Vec<Item>> = FxHashMap::default();
	let wide_item = |id: Option<f64>| id.and_then(|x| data.items.get(&(x as u32))).is_some_and(|it| it.npc_droppers() > WIDE_DROPPERS);
	let cx_route_travel = inp.route_travel;
	for o in &together {
		let r = if o.t == OrderT::Task { o.key } else { None };
		let wobjs: Vec<&crate::input::WObj> = match (r, o.q.and_then(|q| wq.get(&q))) {
			(Some(_), Some(&wi)) => world.quests[wi].objs.iter().filter(|x| x.task == o.task).collect(),
			_ => Vec::new(),
		};
		let mut keys: Vec<Key> = Vec::new();
		for x in &wobjs {
			let Some(oi) = x.oi else { continue };
			let ks = obj_lines.get(&format!("{}.{}", opt_num(o.q), js_to_string(oi + 1.0)));
			let Some(ks) = ks else { continue };
			let k = ks.iter().find(|k2| Some(k2.0) == r.map(|r| r.0)).or(ks.first()).copied();
			if let Some(k) = k {
				if !keys.contains(&k) {
					keys.push(k);
				}
			}
		}
		if keys.is_empty() {
			// A task whose line is no work line of its quest: its work is written where the
			// route does it, as an added quest's is; else the guide leaves it to the turn-in.
			let line = r.and_then(|k| step_line(&steps, &step_of, k)).map_or(String::new(), |l| l.text);
			let q = opt_num(o.q);
			let work = crate::jsre::compile(&format!(r"^\s+(kill|collect|interact|use|talk|complete)\b.*\bquest\s+{q}(\.\d+)?\b|^\s+complete\s+{q}\b"));
			let rq = o.q.and_then(quest);
			let item_start = rq.is_some_and(|r| !r.start_items().is_empty());
			let event = !wobjs.is_empty() && wobjs.iter().all(|x| x.kind.as_deref() == Some("event"));
			let wide = rq.is_some_and(|r| r.objectives().any(|x| x.is("item") && wide_item(x.id)));
			let bought = rq.is_some_and(|r| r.objectives().any(|x| x.is("item") && x.id.is_some_and(|id| v1_gets.contains(&(id as u32)))));
			let sourceless = !wobjs.is_empty()
				&& wobjs.iter().all(|x| {
					if x.kind.as_deref() != Some("item") {
						return false;
					}
					match x.id.and_then(|id| data.items.get(&(id as u32))) {
						None => true,
						Some(it) => {
							let (n, ob) = it.drops.as_ref().map_or((0, 0), |d| (d.npc.len(), d.object.len()));
							n == 0 && ob == 0 && it.vendors.as_ref().is_none_or(|v| v.is_empty())
						}
					}
				});
			let wide_task = !wobjs.is_empty() && wobjs.iter().all(|x| x.kind.as_deref() == Some("item") && wide_item(x.id));
			// A task the route names by v1's optional turn-in (a hand-in from the bags, "if you carry
			// them": the 60 Wool Cloth in Stormwind) is that hand-in, not a farm of its own.
			let bag_turnin = cx_route_travel && o.q.is_some_and(|q| crate::jsre::compile(&format!(r"^\s+turnin\s+{q}\b.*\boptional\b")).is_match(split_comment(&line).0));
			if r.is_some() && (sourceless || wide_task || bag_turnin) && !work.is_match(&line) {
				continue;
			}
			if let (Some(r), true) = (r, bought && !work.is_match(&line)) {
				// Its bind or flight path goes with v1's buy line.
				let keep: Vec<Item> = o.items().iter().filter(|x| matches!(x.t, ItemT::Bind | ItemT::Getfp)).cloned().collect();
				if !keep.is_empty() {
					let ids: FxHashSet<u32> = rq.unwrap().objectives().filter(|x| x.is("item") && x.id.is_some_and(|id| v1_gets.contains(&(id as u32)))).map(|x| x.id.unwrap() as u32).collect();
					let here = step_of.get(&r).copied();
					let mut at = None;
					for st in &steps {
						if here.is_some_and(|h| st.k > h) {
							break;
						}
						for l in &st.lines {
							if let Some(m) = re!(r"^\s+(buy|collect)\s+(\d+)\b").captures(&l.text) {
								if m[2].parse().is_ok_and(|x: u32| ids.contains(&x)) {
									at = Some(l.key());
								}
							}
						}
					}
					if let Some(at) = at {
						items_at_line.entry(at).or_default().extend(keep);
					}
				}
				continue;
			}
			if r.is_some() && !item_start && !event && !(wide && rq.is_some_and(|r| r.repeatable())) && !work.is_match(&line) {
				let mut x = o.clone();
				x.v1from = x.from.take();
				x.from = Some("inserted".into());
				x.key = None;
				route_order.push(x);
			} else {
				route_order.push(o.clone());
			}
			continue;
		}
		for k in keys {
			let mut x = o.clone();
			x.from = Some(format!("guides/{}:{}", chain[k.0], k.1));
			x.key = Some(k);
			route_order.push(x);
		}
	}
	let v1key = |o: &Order| key_of(o.v1from.as_deref());

	// The route's v1 lines, first use only; dropped quests' lines out.
	let mut named: FxHashSet<Key> = FxHashSet::default();
	let mut named_list: Vec<Key> = Vec::new();
	let mut key_pt: FxHashMap<Key, u32> = FxHashMap::default();
	for o in &route_order {
		let Some(k) = o.key else { continue };
		if named.insert(k) {
			named_list.push(k);
		}
		if let Some(pt) = o.pt {
			key_pt.entry(k).or_insert(pt);
		}
	}
	let in_route: FxHashSet<u32> = route_order.iter().filter_map(|o| o.q).collect();
	let mut work_key: FxHashMap<u32, Key> = FxHashMap::default();
	let mut turn_key: FxHashMap<u32, Key> = FxHashMap::default();
	let mut accept_at: FxHashMap<u32, usize> = FxHashMap::default();
	let mut key_at: FxHashMap<Key, usize> = FxHashMap::default();
	for (i, o) in route_order.iter().enumerate() {
		if let Some(k) = o.key {
			key_at.entry(k).or_insert(i);
		}
		if o.t == OrderT::Accept {
			if let Some(q) = o.q {
				accept_at.entry(q).or_insert(i);
			}
		}
	}
	for o in &route_order {
		let (Some(k), Some(q)) = (o.key, o.q) else { continue };
		if o.t == OrderT::Task {
			work_key.entry(q).or_insert(k);
		}
		if o.t == OrderT::Turnin {
			turn_key.entry(q).or_insert(k);
		}
	}
	let faction_list = faction_races(route.faction.as_deref());
	let route_races: Vec<String> = if !guide_races.is_empty() && !guide_races[0].is_empty() { guide_races[0].clone() } else { route.start.iter().filter(|s| !s.is_empty()).cloned().collect() };
	let other_races: Vec<String> = faction_list.iter().filter(|r| !route_races.contains(r)).cloned().collect();
	// Items that start a dropped quest or are its objectives: a bag count of them goes too.
	let mut dropped_items: FxHashSet<u32> = FxHashSet::default();
	for &q in &dropped_list {
		if let Some(rec) = quest(q) {
			dropped_items.extend(rec.start_items().iter().copied());
			for o in rec.objectives() {
				if o.is("item") {
					if let Some(id) = o.id {
						dropped_items.insert(id as u32);
					}
				}
			}
		}
	}

	// Every v1 goal line in v1's order; a quest's line counts against a gap (the route changed v1's
	// order there: it left out or moved work v1 does between).
	let v1_rank: FxHashMap<Key, usize> = {
		let mut r = FxHashMap::default();
		let mut n = 0;
		// (Lines only some characters see, other races' or classes', do not count.)
		let everyone = |l: Option<&str>| l.is_none_or(|l| !l.split(',').any(|x| ALL_RACES.contains(&trim(x)) || CLASSES.contains(&trim(x))));
		for st in &steps {
			let step_only = st.lines.iter().find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(&l.text, "")).to_string());
			for l in &st.lines {
				let theirs = !everyone(step_only.as_deref()) || !everyone(line_only(&l.text));
				if l.kind == Kind::Goal && (named.contains(&l.key()) || (quest_of(&l.text).is_some() && !theirs)) {
					r.insert(l.key(), n);
					n += 1;
				}
			}
		}
		r
	};
	let mut cx = Ctx {
		v1_rank,
		route_travel: inp.route_travel,
		walks: inp.walks,
		world,
		data,
		proj: Projector::new(inp.frames),
		era: inp.frames.era.keys().filter_map(|k| k.parse().ok()).collect(),
		area_at: inp.area_at,
		guide_races,
		steps,
		step_of,
		named,
		key_pt,
		level_at: if inp.level_fraction { level_targets(&route_order, data) } else { FxHashMap::default() },
		ender_keys,
		items_at_line,
		before: FxHashMap::default(),
		after: FxHashMap::default(),
		orphan: FxHashMap::default(),
		carried: FxHashSet::default(),
		has_items,
		route_races,
		other_races,
		dropped,
		dropped_items,
		v1_piers,
		wq,
		zone_ids: world.zones.iter().map(|(k, v)| (*k, v.clone())).collect(),
	};
	let mut anchor_of: FxHashMap<Key, Key> = FxHashMap::default();
	fn put_at(m: &mut FxHashMap<Key, Vec<Line>>, anchor_of: &mut FxHashMap<Key, Key>, k2: Key, ls: Vec<Line>, front: bool) {
		for l in &ls {
			anchor_of.insert(l.key(), k2);
		}
		let e = m.entry(k2).or_default();
		if front {
			let mut v = ls;
			v.append(e);
			*e = v;
		} else {
			e.extend(ls);
		}
	}
	// An objective line the chain writes twice is written once.
	let obj_sig = |text: &str| -> Option<String> { re!(r"^\s+(kill|collect|interact|use|talk)\s+(\d+)\b.*?\bquest\s+(\d+\.\d+)").captures(text).map(|m| format!("{} {} {}", &m[1], &m[2], &m[3])) };
	let mut sigs: FxHashMap<String, Vec<usize>> = FxHashMap::default();
	for s in &cx.steps {
		for l in &s.lines {
			if cx.named.contains(&l.key()) {
				if let Some(g) = obj_sig(&l.text) {
					sigs.entry(g).or_default().push(s.file);
				}
			}
		}
	}
	let mut twice: FxHashSet<Key> = FxHashSet::default();
	// An accept or turn-in the route names on another line is written once, at the route's place.
	let mut event_file: FxHashMap<String, usize> = FxHashMap::default();
	for o in &route_order {
		let Some(k) = o.key else { continue };
		let t = match o.t {
			OrderT::Accept => "accept",
			OrderT::Turnin => "turnin",
			_ => continue,
		};
		event_file.entry(format!("{t} {}", opt_num(o.q))).or_insert(k.0);
	}
	for s in &cx.steps {
		for l in &s.lines {
			if l.kind != Kind::Goal || cx.named.contains(&l.key()) {
				continue;
			}
			let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(&l.text) else { continue };
			if let Some(&f) = event_file.get(&format!("{} {}", &m[1], &m[2])) {
				if cx.covers(f, s.file) {
					twice.insert(l.key());
				}
			}
		}
	}

	for s in &cx.steps {
		for l in &s.lines {
			if l.kind != Kind::Goal || cx.named.contains(&l.key()) {
				continue;
			}
			let Some(g) = obj_sig(&l.text) else { continue };
			// (v1's reminder in a step the route visits before the turn-in stays: see `reminder`.)
			let q: Option<u32> = g.rsplit(' ').next().and_then(|o| o.split('.').next()).and_then(|q| q.parse().ok());
			let at_turn = q.and_then(|q| turn_key.get(&q)).and_then(|tk| key_at.get(tk)).copied();
			if at_turn.is_some_and(|t| s.lines.iter().any(|x| cx.named.contains(&x.key()) && key_at.get(&x.key()).is_some_and(|&v| v < t))) {
				continue;
			}
			if sigs.get(&g).is_some_and(|fs| fs.iter().any(|&f| cx.covers(f, s.file))) {
				twice.insert(l.key());
			} else {
				sigs.entry(g).or_default().push(s.file);
			}
		}
	}
	let core = |t: &str| -> String { trim(&re!(r"\s@\s*[\d.,]+(\s+map\s+\d+)?").replace(split_comment(t).0, "")).to_string() };
	let mut before = std::mem::take(&mut cx.before);
	let mut after = std::mem::take(&mut cx.after);
	let mut carried: FxHashSet<Key> = FxHashSet::default();
	for si in 0..cx.steps.len() {
		let s = &cx.steps[si];
		let goals: Vec<Line> = s.lines.iter().filter(|l| l.kind == Kind::Goal && !cx.dropped_line(&l.text, Some(l.key())) && !twice.contains(&l.key())).cloned().collect();
		let named_in: Vec<Line> = goals.iter().filter(|l| cx.named.contains(&l.key())).cloned().collect();
		let mut pend: Vec<Line> = Vec::new();
		for l in &goals {
			let key = l.key();
			// A line of a quest the route works elsewhere goes with the quest's first work,
			// else before its turn-in, so it never comes before the accept.
			let q = if cx.named.contains(&key) { None } else { quest_of(&l.text) };
			let dst = q.and_then(|q| work_key.get(&q).or(turn_key.get(&q)).copied());
			// A quest the route gives no work of its own keeps its v1 line in its v1 step when
			// that step comes after the accept (Grenka's Claw).
			let stays = q.is_some_and(|q| {
				!work_key.contains_key(&q) && !named_in.is_empty() && accept_at.get(&q).is_some_and(|&a| named_in.iter().all(|x| key_at.get(&x.key()).map_or(-1, |&v| v as i64) > a as i64))
			});
			// v1's reminder of an objective the route works elsewhere, in a step of its own the route
			// visits before the turn-in (the Raptor Horns among the Dry Hills lions, #274): it stays
			// in its step (the addon passes it once the horns are in).
			let reminder = q.is_some_and(|q| {
				let wl = work_key.get(&q).and_then(|&wk| cx.step_line(wk));
				let same = wl.is_some_and(|wl| obj_sig(&wl.text).is_some() && obj_sig(&wl.text) == obj_sig(&l.text));
				let at_turn = turn_key.get(&q).and_then(|tk| key_at.get(tk)).copied();
				same && at_turn.is_some_and(|t| named_in.iter().any(|x| key_at.get(&x.key()).is_some_and(|&v| v < t)))
			});
			if let Some(q) = q.filter(|_| !stays && !reminder && re!(r"\bquest\s+\d").is_match(&l.text) && dst.is_some_and(|d| cx.covers(d.0, s.file))) {
				carried.insert(key);
				// The same goal as the work line it would follow: once is enough.
				let wl = work_key.get(&q).and_then(|&wk| cx.step_line(wk));
				if wl.is_some_and(|wl| core(&wl.text) == core(&l.text)) {
					continue;
				}
				if let Some(&wk) = work_key.get(&q) {
					put_at(&mut after, &mut anchor_of, wk, vec![l.clone()], false);
				} else {
					put_at(&mut before, &mut anchor_of, turn_key[&q], vec![l.clone()], false);
				}
				continue;
			}
			if named_in.is_empty() {
				continue;
			}
			// The reminder goes with the work line before it in its step (the Raptor Horns with
			// Vrang's hides, #274), when the route names one.
			if reminder {
				if let Some(prev) = named_in.iter().filter(|x| x.n < l.n).max_by_key(|x| x.n) {
					carried.insert(key);
					// Before the route's own work of the objective it is an extra, not a wait
					// (five horns from three raptors held the Dry Hills step).
					let mut line = l.clone();
					let q = q.unwrap();
					let before_work = work_key.get(&q).and_then(|wk| key_at.get(wk)).is_some_and(|&w| key_at.get(&prev.key()).is_some_and(|&p| p < w));
					if before_work && !re!(r"\boptional\b").is_match(&line.text) {
						let (code, rest) = split_comment(&line.text);
						line.text = format!("{} optional{}", code.trim_end(), rest);
					}
					put_at(&mut after, &mut anchor_of, prev.key(), vec![line], false);
					continue;
				}
			}
			// An optional extra the route does not model stays with the step's first piece (the
			// piece the route works first).
			let ka = |x: &Line| key_at.get(&x.key()).map_or(f64::INFINITY, |&v| v as f64);
			let mut first_named = &named_in[0];
			for b in &named_in[1..] {
				if ka(b) < ka(first_named) {
					first_named = b;
				}
			}
			if !cx.named.contains(&key) && re!(r"\boptional\b").is_match(&l.text) && l.n > named_in[0].n && !re!(r"\bonly\b").is_match(&l.text) {
				put_at(&mut after, &mut anchor_of, first_named.key(), vec![l.clone()], false);
				continue;
			}
			if cx.named.contains(&key) {
				if !pend.is_empty() {
					put_at(&mut before, &mut anchor_of, key, std::mem::take(&mut pend), true);
				}
				pend.clear();
			} else {
				pend.push(l.clone());
			}
		}
		let drop_all = s.lines.iter().any(|l| l.kind == Kind::Goal) && !goals.iter().any(|l| !carried.contains(&l.key()));
		let twice_keys: Vec<Key> = s.lines.iter().map(|l| l.key()).filter(|k| twice.contains(k)).collect();
		carried.extend(twice_keys);
		// Gotos after a step's last goal lead to the next step's place.
		let mut trail = None;
		if !pend.is_empty() && !named_in.is_empty() {
			if pend.iter().all(|l| is_head_ws(&l.text, "goto")) {
				trail = Some(pend);
			} else {
				put_at(&mut after, &mut anchor_of, named_in.last().unwrap().key(), pend, false);
			}
		}
		let s = &mut cx.steps[si];
		s.named = named_in;
		s.drop_all = drop_all;
		s.trail = trail;
	}
	for si in 0..cx.steps.len() {
		let Some(trail) = cx.steps[si].trail.clone() else { continue };
		let s = &cx.steps[si];
		match cx.steps.get(s.k + 1) {
			Some(t) if t.file == s.file && !t.named.is_empty() => put_at(&mut before, &mut anchor_of, t.named[0].key(), trail, true),
			_ => put_at(&mut after, &mut anchor_of, s.named.last().unwrap().key(), trail, false),
		}
	}
	cx.before = before;
	cx.after = after;
	cx.carried = carried;
	// A step the route names no line of, titled for a quest the chain leaves out: goes.
	let mut left_out_titles: FxHashSet<&str> = FxHashSet::default();
	for (q, rec) in &data.quests {
		let Some(t) = rec.title() else { continue };
		if in_route.contains(q) {
			continue;
		}
		if cx.dropped.contains(q) {
			left_out_titles.insert(t);
		}
	}
	let left_out_title = |cx: &Ctx, st: &Step| -> bool {
		left_out_titles.contains(trim(&re!(r"^step\s*").replace(&st.title, ""))) && st.lines.iter().all(|l| l.kind != Kind::Goal || cx.dropped_line(&l.text, None) || quest_of(&l.text).is_none())
	};
	// A v1 step whose goals all go but whose tip tells the way on keeps the way (The Great Lift).
	let mut dropped_words: FxHashSet<String> = FxHashSet::default();
	let item_name = |it: u32| data.items.get(&it).and_then(|i| i.name.clone()).unwrap_or_default();
	for &q in &dropped_list {
		let rec = quest(q);
		let mut names: Vec<String> = vec![rec.and_then(|r| r.title.clone()).unwrap_or_default()];
		if let Some(rec) = rec {
			names.extend(rec.start_items().iter().map(|&it| item_name(it)));
			names.extend(rec.objectives().filter(|o| o.is("item")).map(|o| o.id.map_or(String::new(), |id| item_name(id as u32))));
		}
		for nm in names {
			for w in re!(r"[^A-Za-z']+").split(&nm) {
				let w = w.strip_suffix("'s").unwrap_or(w);
				if w.len() >= 5 {
					dropped_words.insert(w.to_lowercase());
				}
			}
		}
	}
	let way_step = |st: &mut Step| -> bool {
		let Some(tip_at) = st.lines.iter().position(|l| is_head_ws(&l.text, "tip")) else { return false };
		let at = st.lines.iter().find_map(|l| {
			if l.kind == Kind::Goal {
				re!(r"@\s*([\d.]+)\s*,\s*([\d.]+)(\s+map\s+\d+)?").captures(&l.text).map(|m| (m[1].to_string(), m[2].to_string(), m.get(3).map_or(String::new(), |x| x.as_str().to_string())))
			} else {
				None
			}
		});
		let Some(at) = at else { return false };
		if !truthy(&st.zone) {
			return false;
		}
		let tip = st.lines[tip_at].clone();
		let body = re!(r"^\s+tip\s+").replace(&tip.text, "").into_owned();
		let kept: Vec<&str> =
			split_sentences(&body).into_iter().filter(|sen| !re!(r"[^A-Za-z']+").split(sen).any(|w| dropped_words.contains(&w.strip_suffix("'s").unwrap_or(w).to_lowercase()))).collect();
		if kept.is_empty() {
			return false;
		}
		let title = trim(&re!(r"^step\s+").replace(&st.title, "")).to_string();
		let n0 = st.lines.iter().find(|l| l.kind == Kind::Goal).unwrap().n;
		let mut lines: Vec<Line> = st.lines.iter().enumerate().filter(|(i, l)| l.kind != Kind::Goal && *i != tip_at).map(|(_, l)| l.clone()).collect();
		lines.push(Line { text: format!("  tip {}", kept.join(" ")), ..tip });
		lines.push(Line { n: n0, text: format!("  goto {},{} \"{}\"{}", at.0, at.1, title, at.2), kind: Kind::Goal, file: st.file, zone: st.zone.clone() });
		st.lines = lines;
		st.way = true;
		true
	};
	// Steps with no named line: before the next named line of the chain.
	let mut waiting: Vec<usize> = Vec::new();
	for si in 0..cx.steps.len() {
		if cx.steps[si].named.is_empty() {
			let keep = (!cx.steps[si].drop_all || way_step(&mut cx.steps[si])) && !left_out_title(&cx, &cx.steps[si]);
			if keep {
				waiting.push(si);
			}
			continue;
		}
		if !waiting.is_empty() {
			let key = cx.steps[si].named[0].key();
			for &os in &waiting {
				for l in &cx.steps[os].lines {
					anchor_of.insert(l.key(), key);
				}
			}
			cx.orphan.insert(key, std::mem::take(&mut waiting));
		}
	}
	let tail = waiting;

	let mut order = post::item_accepts(post::timed_order(route_order, &cx.steps, &cx.named, &anchor_of, data), &cx.steps, &cx.named, &anchor_of, data);

	// ---- pieces in the route's order ----
	let mut pieces: Vec<Piece> = Vec::new();
	let mut seen: FxHashSet<Key> = FxHashSet::default();
	let mut obj_done: FxHashSet<String> = FxHashSet::default();
	// An added quest whose item objectives the world has no source for is not written.
	let mut unwritable: Vec<u32> = Vec::new();
	for &q in &added_list {
		let has_item = quest(q).is_some_and(|r| r.objectives().any(|o| o.is("item")));
		let wobjs = cx.wq.get(&q).map_or(0, |&i| world.quests[i].objs.len());
		if has_item && wobjs == 0 {
			unwritable.push(q);
		}
	}
	let ins_lines = |cx: &Ctx, obj_done: &mut FxHashSet<String>, o: &Order| -> Option<Ins> {
		let q = o.q;
		if q.is_some_and(|q| unwritable.contains(&q)) {
			return None;
		}
		let rec = q.and_then(quest);
		let wobjs: &[crate::input::WObj] = q.and_then(|q| cx.wq.get(&q)).map_or(&[], |&i| &world.quests[i].objs);
		let qs = opt_num(q);
		let rec_title = rec.and_then(|r| r.title()).map(str::to_string);
		if matches!(o.t, OrderT::Accept | OrderT::Turnin) {
			let st = rec.and_then(|r| if o.t == OrderT::Accept { r.start.as_ref() } else { r.end.as_ref() });
			let who: Vec<&Entity> = st.map_or(Vec::new(), |st| st.npc.iter().filter_map(|n| data.npcs.get(n)).chain(st.object.iter().filter_map(|x| data.objects.get(x))).collect());
			let near = cx.spawn_near(&who, o.pt);
			let npc_name = st.and_then(|st| st.npc.first()).and_then(|n| data.npcs.get(n)).and_then(|n| n.name.clone()).filter(|n| !n.is_empty());
			let t = if o.t == OrderT::Accept { "accept" } else { "turnin" };
			return Some(Ins { title: npc_name.or(rec_title).unwrap_or_else(|| format!("Quest {qs}")), lines: vec![format!("  {t} {qs}")], map: near.map_or(cx.map_of_pt(o.pt), |n| Some(n.map)) });
		}
		if o.t == OrderT::Train {
			return Some(Ins { title: "Class trainer".into(), lines: vec!["  train class".into()], map: cx.map_of_pt(o.pt) });
		}
		if o.t != OrderT::Task {
			return None;
		}
		let objs: Vec<&crate::input::WObj> = wobjs.iter().filter(|x| x.task == o.task).collect();
		let use_: Vec<&crate::input::WObj> = if objs.is_empty() { wobjs.iter().collect() } else { objs };
		let mut lines: Vec<String> = Vec::new();
		let mut map: Option<u32> = None;
		for x in use_ {
			let oi = x.oi.unwrap_or(f64::NAN);
			if !obj_done.insert(format!("{qs}.{}", js_to_string(oi))) {
				continue;
			}
			// The data's objective, when it has one, names the verb and the objective number.
			let d = rec.and_then(|r| r.objective(x.oi()));
			let d = if oi.is_nan() { None } else { d };
			let kind = if let Some(d) = d { d.kind.clone() } else { x.kind.clone() };
			let id = match d {
				Some(d) if d.id.is_some() => d.id,
				_ => x.id,
			};
			let verb = match kind.as_deref() {
				Some("kill") => Some("kill"),
				Some("item") => Some("collect"),
				Some("object") => Some("interact"),
				Some("talk") => Some("talk"),
				_ => None,
			};
			let rf = if d.is_some() { format!(" quest {qs}.{}", js_to_string(oi + 1.0)) } else { String::new() };
			if let (Some(verb), Some(id)) = (verb, id) {
				let near = cx.spawn_near(&cx.targets(kind.as_deref().unwrap(), id), o.pt);
				let c = near.as_ref().map_or_else(|| cx.coords_of(o.pt), |n| n.at.clone());
				lines.push(format!("  {verb} {}{rf}{c}", js_to_string(id)));
				if map.is_none() {
					map = near.map_or(cx.map_of_pt(o.pt), |n| Some(n.map));
				}
			} else {
				// An event: the arrow goes to the route's point for it.
				if let Some(c) = re!(r"^ @([\d.]+),([\d.]+) map \d+( live)?").captures(&cx.coords_of(o.pt)) {
					lines.push(format!("  goto {},{}{}", &c[1], &c[2], c.get(3).map_or("", |m| m.as_str())));
				}
				if d.is_some() {
					lines.push(format!("  complete {qs}"));
				}
				if map.is_none() {
					map = cx.map_of_pt(o.pt);
				}
			}
		}
		// v1 hands the quest in as optional: its work written for it is too.
		let vl = v1key(o).and_then(|k| cx.step_line(k));
		let opt = vl.is_some_and(|vl| re!(r"\boptional\b").is_match(split_comment(&vl.text).0));
		let lines: Vec<String> = if opt {
			lines
				.into_iter()
				.map(|l| {
					if re!(r"^\s+(kill|collect|interact|talk)\s").is_match(&l) && !re!(r"\boptional\b").is_match(&l) {
						re!(r"(\s+--\s.*)?$").replacen(&l, 1, |m: &regex::Captures| format!(" optional{}", &m[0])).into_owned()
					} else {
						l
					}
				})
				.collect()
		} else {
			lines
		};
		(!lines.is_empty()).then(|| Ins { title: rec_title.unwrap_or_else(|| format!("Quest {qs}")), lines, map })
	};
	let mut oi = 0;
	while oi < order.len() {
		let o = order[oi].clone();
		let Some(key) = o.key else {
			// A training stop where v1's next steps train anyway: v1's (its travel goes with the
			// next event).
			if o.t == OrderT::Train && cx.v1_trains_next(&order, oi) {
				if !o.items().is_empty() && oi + 1 < order.len() {
					let mut its: Vec<Item> = o.items().iter().filter(|x| matches!(x.t, ItemT::Network | ItemT::Hearth)).cloned().collect();
					its.extend(order[oi + 1].items().iter().cloned());
					order[oi + 1].items = Some(its);
				}
				oi += 1;
				continue;
			}
			let Some(x) = ins_lines(&cx, &mut obj_done, &o) else {
				if !o.items().is_empty() {
					pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt: o.pt, map: None, title: None, lines: Vec::new(), q: None, t: None, to_way: false }, items: o.items.clone() });
				}
				oi += 1;
				continue;
			};
			let p = cx.w(o.pt);
			// A training stop right after another one, or after a v1 step that trains, adds nothing.
			if o.t == OrderT::Train {
				if let Some(last) = pieces.last() {
					let skip = match &last.kind {
						PieceKind::Ins { t, .. } => *t == Some(OrderT::Train),
						PieceKind::Step { step, keys } => keys.iter().any(|k| re!(r"^\s+train class\b").is_match(&cx.steps[*step].line(k.1).unwrap().text)),
						PieceKind::Orphan(_) => false,
					};
					if skip {
						oi += 1;
						continue;
					}
				}
			}
			let merged = match pieces.last_mut() {
				Some(Piece { kind: PieceKind::Ins { pt, title, lines, .. }, .. }) if *pt == o.pt && title.as_deref() == Some(x.title.as_str()) && o.items().is_empty() => {
					lines.extend(x.lines.iter().cloned());
					true
				}
				_ => false,
			};
			if !merged {
				pieces.push(Piece {
					gi: -1,
					kind: PieceKind::Ins { pt: o.pt, map: x.map.or(p.map(|p| p.map)), title: Some(x.title), lines: x.lines, q: o.q, t: Some(o.t), to_way: false },
					items: if o.items().is_empty() { None } else { o.items.clone() },
				});
			}
			oi += 1;
			continue;
		};
		oi += 1;
		if !seen.insert(key) {
			if !o.items().is_empty() {
				pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt: o.pt, map: None, title: None, lines: Vec::new(), q: None, t: None, to_way: false }, items: o.items.clone() });
			}
			continue;
		}
		let Some(&s) = cx.step_of.get(&key) else {
			log.push(format!("apply-route: {} is in no step; left out", o.from.as_deref().unwrap_or("undefined")));
			continue;
		};
		let mut its = if o.items().is_empty() { None } else { o.items.clone() };
		// The route's travel comes before a way step.
		if let (Some(orph), Some(i)) = (cx.orphan.get(&key), &its) {
			if orph.iter().any(|&os| cx.steps[os].way) && i.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)) {
				pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt: o.pt, map: None, title: None, lines: Vec::new(), q: None, t: None, to_way: true }, items: its.take() });
			}
		}
		if let Some(orph) = cx.orphan.get(&key) {
			for &os in orph {
				pieces.push(Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None });
			}
		}
		let gi = cx.steps[s].file as i64;
		match pieces.last_mut() {
			Some(Piece { kind: PieceKind::Step { step, keys }, .. }) if *step == s && its.is_none() => keys.push(key),
			_ => pieces.push(Piece { gi, kind: PieceKind::Step { step: s, keys: vec![key] }, items: its }),
		}
	}
	for os in tail {
		pieces.push(Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None });
	}

	// ---- guide boundaries: fewest pieces outside their own guide ----
	let n = pieces.len();
	let ng = chain.len();
	let mut cut: Vec<usize> = vec![0];
	for k in 1..ng {
		let room = ng - k;
		let k = k as i64;
		let c0 = *cut.last().unwrap();
		let mut best = c0 + 1;
		let mut best_cost = i64::MAX;
		let mut cost_before = 0i64;
		let mut cost_after = 0i64;
		for p in &pieces[c0..] {
			if p.gi >= 0 && p.gi < k {
				cost_after += 1;
			}
		}
		let mut p = c0;
		while p as i64 <= n as i64 - room as i64 {
			if p > c0 && cost_before + cost_after <= best_cost {
				best_cost = cost_before + cost_after;
				best = p;
			}
			if p < n && pieces[p].gi >= 0 {
				if pieces[p].gi >= k {
					cost_before += 1;
				} else {
					cost_after -= 1;
				}
			}
			p += 1;
		}
		cut.push(best);
	}
	cut.push(n);

	// ---- writing ----
	let mut wr = Writer {
		cx: &cx,
		route_pt: None,
		pos: None,
		known: FxHashSet::default(),
		first_piece: FxHashSet::default(),
		prev_key: None,
		done: Vec::new(),
		carry: Vec::new(),
		leg_done: None,
		pending_orphans: Vec::new(),
		away: Vec::new(),
		fresh_fps: FxHashSet::default(),
		away_undo: Vec::new(),
		written: FxHashSet::default(),
		g: GuideState::default(),
	};
	// Pieces the cut put in a guide whose players do not include their own guide's are also
	// written at the start of their own guide.
	let mut copies: Vec<Vec<usize>> = vec![Vec::new(); ng];
	for gi in 0..ng {
		for i in cut[gi]..cut[gi + 1].max(cut[gi]) {
			let p = &pieces[i];
			if p.gi >= 0 && p.gi as usize != gi && !cx.covers(gi, p.gi as usize) {
				copies[p.gi as usize].push(i);
			}
		}
	}
	let mut files: Vec<(String, String)> = Vec::new();
	let mut moved_total = 0usize;
	for gi in 0..ng {
		let (header, header_zone) = &headers[gi];
		let item_only: Vec<String> = if cx.shared(gi) && !cx.other_races.is_empty() { vec![format!("  only {}", cx.route_races.join(","))] } else { Vec::new() };
		let goal_only = if item_only.is_empty() { String::new() } else { format!(" only {}", cx.route_races.join(",")) };
		wr.g = GuideState { zone: Some(header_zone.clone()), item_only, goal_only, ..GuideState::default() };
		// (A guide starts with everyone where its first step is: v1's guides end their detours.)
		wr.away.clear();
		wr.away_undo.clear();
		let mut add_q: Vec<u32> = Vec::new();
		let mut moved = 0usize;
		for &pi in &copies[gi] {
			let p = &pieces[pi];
			let s0 = match &p.kind {
				PieceKind::Orphan(os) => *os,
				PieceKind::Step { step, .. } => *step,
				PieceKind::Ins { .. } => unreachable!(),
			};
			let had = wr.first_piece.remove(&s0);
			match &p.kind {
				PieceKind::Orphan(os) => wr.step_lines(*os, None, true, None),
				PieceKind::Step { step, keys } => wr.step_lines(*step, Some(keys), false, None),
				PieceKind::Ins { .. } => {}
			}
			if had {
				wr.first_piece.insert(s0);
			}
		}
		let mut last_pt: Option<u32> = None;
		let end = cut[gi + 1].max(cut[gi]);
		for i in cut[gi]..end {
			// The route's hearth leaves from where it was: before v1's steps that come between
			// it and the piece it is for.
			let is_orphan = |p: &Piece| matches!(p.kind, PieceKind::Orphan(_));
			// A class's own step of v1 before the hearth stays before it (the Warrior's Twitching
			// Antennae in the Field of Giants before the hearth to Camp Taurajo): the hearth
			// leaves from after the leading class steps.
			let class_step = |p: &Piece| match p.kind {
				PieceKind::Orphan(si) => cx.steps[si].lines.iter().any(|l| is_head_ws(&l.text, "only") && only_classes(Some(trim(&re!(r"^\s+only\s+").replace(&l.text, ""))))),
				_ => false,
			};
			let run_start = {
				let mut r = i;
				// (The run starts in this guide: the guide's own first steps are a run of their own.)
				let floor = if cx.route_travel { cut[gi] } else { 0 };
				while r > floor && is_orphan(&pieces[r - 1]) {
					r -= 1;
				}
				r
			};
			let first_plain = is_orphan(&pieces[i]) && !class_step(&pieces[i]) && (run_start..i).all(|k| class_step(&pieces[k]));
			if first_plain {
				// (The route's own legs: the piece may be in the next guide, the steps here are its place.)
				let lim = if cx.route_travel { pieces.len() } else { end };
				let mut j = i;
				while j < lim && is_orphan(&pieces[j]) {
					j += 1;
				}
				// The route's own legs: its whole leg (hearth and flights) leaves first; the steps v1
				// writes before the piece are at its place (the Orgrimmar trainer after the way there).
				let leg = |x: &Item| if cx.route_travel { matches!(x.t, ItemT::Hearth | ItemT::Network) } else { x.t == ItemT::Hearth };
				if j < lim && pieces.get(j).is_some_and(|q| !is_orphan(q) && q.items.as_ref().is_some_and(|its| its.iter().any(&leg))) {
					if cx.route_travel {
						wr.leg_done = Some(j);
						wr.gap_decide(gi);
						wr.pending_orphans = (i..j)
							.filter_map(|k| match pieces[k].kind {
								PieceKind::Orphan(os) => {
									let pg = pieces[k].gi;
									let only_for = if pg >= 0 && pg as usize != gi && cx.covers(gi, pg as usize) && !cx.guide_races[pg as usize].is_empty() && cx.guide_races[gi].is_empty() {
										Some(cx.guide_races[pg as usize].clone())
									} else {
										None
									};
									Some((k, os, cx.steps[os].zone.clone(), only_for))
								}
								_ => None,
							})
							.collect();
					}
					let its = pieces[j].items.take().unwrap();
					let (h, rest): (Vec<Item>, Vec<Item>) = its.into_iter().partition(|x| leg(x));
					wr.write_items(&h, false);
					wr.pending_orphans.clear();
					pieces[j].items = Some(rest);
					wr.g.v1_moves.clear();
				}
			}
			if wr.written.contains(&i) {
				continue;
			}
			wr.fresh_fps.clear();
			let p = pieces[i].clone();
			let mut its = p.items.clone();
			let mut moves = its.as_ref().is_some_and(|its| its.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)));
			if !is_orphan(&p) {
				// v1 moves the character here itself: the route's own hearth and flights are not written.
				let mut kinds: FxHashSet<&'static str> = wr.g.v1_moves.iter().map(|m| m.1).collect();
				if let PieceKind::Step { keys, .. } = &p.kind {
					for l in cx.before.get(&keys[0]).map_or(&[][..], |v| &v[..]) {
						if !cx.for_all_r(line_only(&l.text)) {
							continue;
						}
						if (is_head_ws(&l.text, "fly") && wr.fly_ok(&l.text)) || re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(&l.text) {
							kinds.insert("pre");
						}
					}
				}
				let v1_did = !kinds.is_empty();
				let (is_ins, ins_pt, ins_lines_empty) = match &p.kind {
					PieceKind::Ins { pt, lines, .. } => (true, *pt, lines.is_empty()),
					_ => (false, None, false),
				};
				let first_pt = match &p.kind {
					PieceKind::Ins { pt, .. } => *pt,
					PieceKind::Step { keys, .. } => cx.key_pt.get(&keys[0]).copied(),
					PieceKind::Orphan(_) => None,
				};
				let near_route = |wr: &Writer| -> bool {
					match (cx.w(first_pt), cx.w(wr.route_pt)) {
						(Some(a), Some(b)) => a.c == b.c && js_hypot(a.wx - b.wx, a.wy - b.wy) <= ZONE_STEP_YD,
						_ => false,
					}
				};
				// The route's own legs (structural): between two route items whose v1 lines are not
				// adjacent in v1 (the route changed the order), or that the route travels between itself,
				// the route's own leg is written (its items, else a walk) and v1's travel lines in the gap
				// are dropped for the route's races, unless they are what the route does (the same flight).
				let first_key = match &p.kind {
					PieceKind::Step { keys, .. } => Some(keys[0]),
					_ => None,
				};
				let v1_gap = match (wr.prev_key, first_key) {
					(Some(a), Some(b)) => cx.v1_rank.get(&b).copied() == cx.v1_rank.get(&a).map(|r| r + 1),
					_ => false,
				};
				let leg_done = wr.leg_done == Some(i);
				if leg_done {
					wr.leg_done = None;
				}
				let long = cx.route_travel && (moves || !v1_gap || leg_done);
				if long {
					// The route's flight, when v1 writes the same one: v1's line stands, the route writes none.
					let fly_to: Option<String> = its.as_ref().and_then(|v| v.iter().find(|x| x.t == ItemT::Network)).and_then(|x| {
						// (The sim's own path: its first flight's end.)
						if let Some(legs) = x.legs.as_ref().filter(|l| !l.is_empty()) {
							let mut to = None;
							for l in legs.iter().skip_while(|l| l.k.as_deref() != Some("fly")) {
								if l.k.as_deref() != Some("fly") {
									break;
								}
								to = l.to;
							}
							return to.and_then(|t| cx.world.nodes.get(t as usize)).map(|n| n.name.clone());
						}
						let (a, b) = (cx.w(x.from)?, cx.w(x.to)?);
						if a.c != b.c {
							return None;
						}
						cx.best_flight(x.from, x.to, &wr.known).map(|(_, f1)| cx.world.nodes[f1].name.clone())
					});
					let same_flight = |l: &str| -> bool {
						let Some(to) = &fly_to else { return false };
						re!(r#"^\s+fly\s+"([^"]+)""#).captures(l).is_some_and(|m| to == &m[1] || to.split(',').next() == Some(&m[1]))
					};
					let mut kept_same = false;
					let ks: Vec<usize> = wr.g.v1_moves.iter().map(|m| m.0).chain(wr.g.waypoints.iter().map(|w| w.k)).collect();
					for k in ks {
						if let Some(b) = wr.g.body[k].clone() {
							if same_flight(&b) {
								kept_same = true;
								continue;
							}
							if line_only(&b).is_none() {
								wr.g.body[k] = if cx.shared(gi) && !cx.other_races.is_empty() { Some(cx.others_only(&b)) } else { None };
								wr.undo_away(k);
							}
						}
					}
					for (g0, k) in std::mem::take(&mut wr.carry) {
						if let Some(b) = wr.done[g0].1[k].clone() {
							if same_flight(&b) {
								kept_same = true;
								continue;
							}
							if line_only(&b).is_none() {
								wr.done[g0].1[k] = if cx.shared(g0) && !cx.other_races.is_empty() { Some(cx.others_only(&b)) } else { None };
							}
						}
					}
					if let PieceKind::Step { keys, .. } = &p.kind {
						for l in cx.before.get(&keys[0]).map_or(&[][..], |v| &v[..]) {
							if !cx.for_all_r(line_only(&l.text)) {
								continue;
							}
							if same_flight(&l.text) {
								kept_same = true;
								continue;
							}
							if is_head_ws(&l.text, "fly") || is_head_ws(&l.text, "hearth") || re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(&l.text) {
								wr.g.gate_pre.insert(l.key());
							}
						}
					}
					if kept_same {
						its = its.map(|v| v.into_iter().filter(|x| x.t != ItemT::Network).collect());
						moves = its.as_ref().is_some_and(|v| v.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)));
					}
					if !moves && !kept_same && !leg_done && !(is_ins && ins_lines_empty) {
						wr.travel_to(wr.route_pt, first_pt);
					}
					wr.g.waypoints.clear();
					wr.g.v1_moves.clear();
				} else if cx.route_travel {
					// v1's own gap: its travel lines stand.
					wr.carry.clear();
					wr.g.waypoints.clear();
					wr.g.v1_moves.clear();
				} else if moves && v1_did {
					let same = |x: &Item| matches!((cx.w(x.from), cx.w(x.to)), (Some(a), Some(b)) if a.c == b.c);
					let f = its.take().unwrap();
					let f: Vec<Item> = f.into_iter().filter(|x| !(x.t == ItemT::Network && (kinds.contains("fly") || kinds.contains("pre") || (kinds.contains("ride") && same(x))))).collect();
					moves = f.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network));
					its = Some(f);
				} else if !moves && !wr.g.v1_moves.is_empty() && near_route(&wr) {
					// The route is there already: v1's travel steps before it are the other races'.
					let ks: Vec<usize> = wr.g.v1_moves.iter().map(|m| m.0).collect();
					for k in ks {
						wr.g.body[k] = if cx.shared(gi) && !cx.other_races.is_empty() { wr.g.body[k].as_ref().map(|b| cx.others_only(b)) } else { None };
					}
				}
				if !long && !moves && !wr.g.waypoints.is_empty() && near_route(&wr) {
					let a0 = cx.w(wr.route_pt).unwrap();
					let b0 = cx.w(first_pt).unwrap();
					let wps = std::mem::take(&mut wr.g.waypoints);
					for wp in wps {
						if wp.c != b0.c {
							continue;
						}
						let far = js_hypot(wp.wx - a0.wx, wp.wy - a0.wy) > ZONE_STEP_YD && js_hypot(wp.wx - b0.wx, wp.wy - b0.wy) > ZONE_STEP_YD;
						if far {
							if let Some(b) = wr.g.body[wp.k].clone() {
								if line_only(&b).is_none() {
									wr.g.body[wp.k] = if cx.shared(gi) && !cx.other_races.is_empty() { Some(cx.others_only(&b)) } else { None };
								}
							}
						}
					}
				}
				wr.g.waypoints.clear();
				if !long && !moves && !v1_did && !(is_ins && ins_lines_empty) {
					let first_line = match &p.kind {
						PieceKind::Ins { lines, .. } => lines[0].clone(),
						PieceKind::Step { step, keys } => cx.before.get(&keys[0]).and_then(|v| v.first()).map_or_else(|| cx.steps[*step].line(keys[0].1).unwrap().text.clone(), |l| l.text.clone()),
						PieceKind::Orphan(_) => unreachable!(),
					};
					if !re!(r"^\s+(goto|fly|hearth|enter|die)\b").is_match(&first_line) {
						wr.travel_to(last_pt, first_pt);
					}
				}
				let _ = ins_pt;
				wr.g.v1_moves.clear();
			}
			let to_way = matches!(p.kind, PieceKind::Ins { to_way: true, .. });
			if let Some(its) = its.as_ref().filter(|v| !v.is_empty()) {
				wr.write_items(its, to_way);
			}
			if let PieceKind::Ins { pt, lines, .. } = &p.kind {
				if lines.is_empty() {
					if pt.is_some() {
						last_pt = *pt;
						wr.route_pt = *pt;
						wr.pos = *pt;
					}
					continue;
				}
			}
			let only_for: Option<Vec<String>> = if p.gi >= 0 && p.gi as usize != gi && !cx.covers(gi, p.gi as usize) {
				None
			} else if p.gi >= 0 && p.gi as usize != gi && !cx.guide_races[p.gi as usize].is_empty() && cx.guide_races[gi].is_empty() {
				Some(cx.guide_races[p.gi as usize].clone())
			} else {
				None
			};
			match &p.kind {
				PieceKind::Orphan(os) => {
					wr.come_back_to_step(*os);
					// (Everyone's step: the walk there.)
					if cx.route_travel && !cx.steps[*os].lines.iter().any(|l| is_head_ws(&l.text, "only")) {
						let mut at = wr.pos;
						wr.walk_to_step(*os, &mut at);
						wr.pos = at;
					}
					wr.step_lines(*os, None, true, only_for.as_deref());
					if p.gi as usize != gi {
						moved += 1;
					}
					last_pt = None;
				}
				PieceKind::Ins { pt, map, title, lines, q, t, .. } => {
					wr.g.body.push(Some(String::new()));
					wr.g.body.push(Some(format!("step {}", title.as_deref().unwrap_or("null"))));
					wr.zone_line(cx.zone_name(*map));
					wr.flush_arrival();
					wr.g.body.extend(lines.iter().map(|l| Some(l.clone())));
					if *t == Some(OrderT::Accept) {
						if let Some(q) = q {
							add_q.push(*q);
						}
					}
					wr.prev_key = None;
					if pt.is_some() {
						last_pt = *pt;
						wr.route_pt = *pt;
						wr.pos = *pt;
					}
				}
				PieceKind::Step { step, keys } => {
					wr.g.arrived = if p.items.as_ref().is_some_and(|its| its.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network))) { Some(keys.iter().copied().collect()) } else { None };
					if cx.route_travel {
						wr.come_back(keys.iter().find_map(|k| cx.step_line(*k).and_then(|l| cx.line_pt(l))));
					}
					wr.step_lines(*step, Some(keys), false, only_for.as_deref());
					wr.g.arrived = None;
					wr.g.v1_moves.clear();
					if p.gi as usize != gi {
						moved += keys.len();
					}
					wr.prev_key = keys.last().copied();
					let lk = keys.iter().rev().find(|k| cx.key_pt.contains_key(k));
					last_pt = lk.map(|k| cx.key_pt[k]);
					if last_pt.is_some() {
						wr.route_pt = last_pt;
						wr.pos = last_pt;
					}
				}
			}
		}
		if !wr.g.arrival.is_empty() {
			wr.g.body.push(Some(String::new()));
			wr.g.body.push(Some("step Inn and flight master".into()));
			let a = std::mem::take(&mut wr.g.arrival);
			wr.g.body.extend(a.into_iter().map(Some));
		}
		let drop_here: Vec<u32> = dropped_list
			.iter()
			.copied()
			.filter(|&q| {
				let r = crate::jsre::compile(&format!(r"^\s+(accept|turnin|complete)\s+{q}\b|\bquest\s+{q}(\.\d+)?\b"));
				guide_steps[gi].clone().any(|si| cx.steps[si].lines.iter().any(|l| r.is_match(&l.text)))
			})
			.collect();
		let title = |q: &u32| format!("{} ({q})", quest(*q).and_then(|r| r.title()).map_or_else(|| q.to_string(), str::to_string));
		let hours = |h: &Option<crate::input::Hours>| h.as_ref().map_or("?".to_string(), |h| h.hours60.map_or("NaN".into(), |x| js_to_fixed(x, 1)));
		let mut note = vec![
			String::new(),
			format!(
				"# v1 improved: order from the simulator's search ({} {}, {} tries, seeded with v1's order;",
				route.start.as_deref().unwrap_or(""),
				route.faction.as_deref().unwrap_or(""),
				route.tries.filter(|t| *t != 0.0 && !t.is_nan()).map_or("?".into(), js_to_string)
			),
			format!("# {} h -> {} h to 60 in the model), written by polestar apply-route.", hours(&route.v1), hours(&route.improved)),
		];
		if !add_q.is_empty() {
			note.push(format!("# Added here: {}.", add_q.iter().map(title).collect::<Vec<_>>().join(", ")));
		}
		if !drop_here.is_empty() {
			note.push(format!("# Left out: {}.", drop_here.iter().map(title).collect::<Vec<_>>().join(", ")));
		}
		if moved > 0 {
			note.push(format!("# {moved} goals moved in from other guides of the chain."));
		}
		note.push("# The notes above describe v1's order; the steps below are the improved one.".into());
		let body = std::mem::take(&mut wr.g.body);
		if cx.route_travel {
			let ks: Vec<usize> = wr.g.v1_moves.iter().map(|m| m.0).chain(wr.g.waypoints.iter().map(|w| w.k)).collect();
			wr.carry.extend(ks.into_iter().map(|k| (gi, k)));
		}
		wr.done.push((header.iter().cloned().chain(note).collect(), body));
		moved_total += moved;
	}
	for (gi, (head, body)) in std::mem::take(&mut wr.done).into_iter().enumerate() {
		let all: Vec<String> = head.into_iter().chain(body.into_iter().flatten()).collect();
		let text = post::no_empty_steps(all).join("\n");
		let text = re!(r"\n{3,}").replace_all(&text, "\n\n").into_owned();
		files.push((chain[gi].clone(), text));
	}
	drop(wr);
	// A post-pass moves a line only into a guide whose players include its own's.
	let may = |dst: usize, src: usize| cx.covers(dst, src);
	let mut texts: Vec<String> = files.iter().map(|f| f.1.clone()).collect();
	post::fix_order(&mut texts, &in_route, &may);
	let worked: FxHashSet<u32> = order.iter().filter(|o| o.t == OrderT::Task).filter_map(|o| o.q).collect();
	post::fix_item_turnins(&mut texts, data, world, &may, &worked, &in_route);
	let shared_files: Vec<bool> = (0..ng).map(|i| cx.shared(i)).collect();
	post::fix_hearths(&mut texts, &cx.route_races, &cx.other_races, &shared_files);
	post::dedupe_only(&mut texts, &faction_list);
	let sources: Vec<&str> = chain.iter().map(|f| inp.guides.get(f).map_or("", |s| s.as_str())).collect();
	post::no_riding(&mut texts, &sources);
	for (f, t) in files.iter_mut().zip(texts) {
		f.1 = t;
	}
	let unplaced = named_list.iter().filter(|k| !seen.contains(k)).count();
	let travel = crate::travel::Travel {
		chain: played_chain,
		route_races: cx.route_races.clone(),
		other_races: cx.other_races.clone(),
		shared: (0..ng).filter(|&i| cx.shared(i)).map(|i| chain[i].clone()).collect(),
		faction: route.faction.clone(),
	};
	Ok(Output { travel, files, added: added_list.iter().copied().filter(|q| !unwritable.contains(q)).collect(), unwritable, dropped: dropped_list, moved: moved_total, unplaced, log })
}

fn opt_num(q: Option<u32>) -> String {
	q.map_or("undefined".into(), |q| q.to_string())
}

struct Waypoint {
	k: usize,
	c: i64,
	wx: f64,
	wy: f64,
}

/// One guide's writing state.
#[derive(Default)]
struct GuideState {
	/// v1 travel lines (fly, hearth, boat or zeppelin goto) before the piece's first line, when the
	/// route's own leg takes the characters there: the other races'.
	gate_pre: FxHashSet<Key>,
	/// The route's arrival lines wait for the step's first (travel) line.
	hold_arrival: bool,
	body: Vec<Option<String>>,
	zone: Option<String>,
	/// The v1 step written last, and whether the step being written follows another step than in v1.
	last_step: Option<usize>,
	new_before: bool,
	/// Body indices of v1 travel lines every route character follows, since the route's last piece.
	v1_moves: Vec<(usize, &'static str)>,
	/// v1's goto-only steps since the route's last piece.
	waypoints: Vec<Waypoint>,
	/// Keys of the piece being written when the route travels to it.
	arrived: Option<FxHashSet<Key>>,
	/// Arrival items (flight path, bind) waiting for the next step's goals.
	arrival: Vec<String>,
	item_only: Vec<String>,
	goal_only: String,
}

struct Writer<'c, 'a> {
	cx: &'c Ctx<'a>,
	/// The route's last point, across guides.
	route_pt: Option<u32>,
	/// Where the route's characters are as the guide is written.
	pos: Option<u32>,
	/// Flight paths the route has learned so far.
	known: FxHashSet<usize>,
	first_piece: FxHashSet<usize>,
	/// The last v1 line of the route's previous piece (None after one of the route's own).
	prev_key: Option<Key>,
	/// Guides written so far (header and note, body), finished after the last (a gap that ends in a
	/// later guide drops v1's travel lines in the earlier one).
	done: Vec<(Vec<String>, Vec<Option<String>>)>,
	/// v1 travel lines of a gap still open at a guide's end: (guide, body index).
	carry: Vec<(usize, usize)>,
	/// The piece whose leg was written before the v1 steps in front of it.
	leg_done: Option<usize>,
	/// v1's steps in front of a piece whose leg is being written: (piece, step, zone, only list).
	pending_orphans: Vec<(usize, usize, Option<String>, Option<Vec<String>>)>,
	/// Classes on a detour of their own (their `only` list, where they flew).
	away: Vec<(String, Option<String>)>,
	/// The flight paths the items being written learn.
	fresh_fps: FxHashSet<usize>,
	/// The detours a v1 travel line (body index) ended, while the route may still gate it.
	away_undo: Vec<(usize, Vec<(String, Option<String>)>)>,
	/// Pieces already written on the way.
	written: FxHashSet<usize>,
	g: GuideState,
}

impl Writer<'_, '_> {
	/// v1's steps waiting in front of the piece that lie in the zone of `at`: written now, on the way.
	/// Returns whether one of them flies the route's `next` flight (v1's line then stands for it).
	fn flush_orphans_at(&mut self, at: &mut Option<u32>, next: Option<&crate::input::Leg>) -> bool {
		let cx = self.cx;
		let next_fly: Option<String> = next.filter(|l| l.k.as_deref() == Some("fly")).and_then(|l| cx.world.nodes.get(l.to? as usize)).map(|n| n.name.clone());
		let mut v1_flies = false;
		let Some(z) = cx.w(*at).and_then(|p| cx.zone_name(Some(p.map))) else { return false };
		let here: Vec<(usize, usize, Option<String>, Option<Vec<String>>)> = self.pending_orphans.iter().filter(|o| o.2.as_deref() == Some(z.as_str())).cloned().collect();
		if here.is_empty() {
			return false;
		}
		// In order, up to the last one here (the steps before it go with it).
		let last = self.pending_orphans.iter().rposition(|o| o.2.as_deref() == Some(z.as_str())).unwrap();
		let now: Vec<(usize, usize, Option<String>, Option<Vec<String>>)> = self.pending_orphans.drain(..=last).collect();
		for (pi, si, _, only) in now {
			self.walk_to_step(si, at);
			let step = &cx.steps[si];
			// The route changed this gap: v1's travel in these steps is the other races', unless it is
			// the route's own next flight.
			let step_for_all = cx.for_all_r(step.lines.iter().find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(&l.text, "")).to_string()).as_deref());
			for l in &step.lines {
				let t = &l.text;
				let travel = is_head_ws(t, "fly") || is_head_ws(t, "hearth") || re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(t);
				if !travel || !step_for_all || !cx.for_all_r(line_only(t)) {
					continue;
				}
				if let (Some(to), Some(m)) = (&next_fly, re!(r#"^\s+fly\s+"([^"]+)""#).captures(t)) {
					if to == &m[1] && !v1_flies {
						v1_flies = true;
						continue;
					}
				}
				self.g.gate_pre.insert(l.key());
			}
			self.come_back_to_step(si);
			self.step_lines(si, None, true, only.as_deref());
			self.written.insert(pi);
		}
		v1_flies
	}

	/// The route's own leg starts here: v1's travel lines of the gap so far are the other races'.
	fn gap_decide(&mut self, gi: usize) {
		let cx = self.cx;
		let gate = |b: &String, g0: usize| -> Option<String> {
			if cx.shared(g0) && !cx.other_races.is_empty() {
				Some(cx.others_only(b))
			} else {
				None
			}
		};
		let ks: Vec<usize> = self.g.v1_moves.iter().map(|m| m.0).chain(self.g.waypoints.iter().map(|w| w.k)).collect();
		for k in ks {
			if let Some(b) = self.g.body[k].clone() {
				if line_only(&b).is_none() {
					self.g.body[k] = gate(&b, gi);
					self.undo_away(k);
				}
			}
		}
		for (g0, k) in std::mem::take(&mut self.carry) {
			if let Some(b) = self.done[g0].1[k].clone() {
				if line_only(&b).is_none() {
					self.done[g0].1[k] = gate(&b, g0);
				}
			}
		}
		self.g.v1_moves.clear();
		self.g.waypoints.clear();
	}

	fn push(&mut self, s: impl Into<String>) {
		self.g.body.push(Some(s.into()));
	}

	fn zone_line(&mut self, z: Option<String>) {
		if truthy(&z) && z != self.g.zone {
			self.push(format!("  zone {}", z.as_deref().unwrap()));
			self.g.zone = z;
		}
	}

	/// A move between pieces from different places with no travel line of its own.
	fn goto_step(&mut self, pt: Option<u32>, label: &str, with_only: bool) {
		let cx = self.cx;
		let Some(mut c) = coords_re(&cx.coords_of(pt)) else { return };
		let zn = cx.zone_name(c[2].parse().ok());
		// A crossing v1 writes in this zone: v1's pier.
		if re!(r"^(Boat|Zeppelin|Tram) to (.+)$").is_match(label) {
			let to = &label[label.find(" to ").unwrap() + 4..];
			let kind = label.split(' ').next().unwrap();
			if let Some(p) = cx.v1_piers.iter().find(|v| Some(&v.zone) == zn.as_ref() && v.kind == kind && (to.starts_with(&v.dest) || v.dest.starts_with(to))) {
				c = [p.x.clone(), p.y.clone(), c[2].clone(), p.live.clone()];
			}
		}
		self.push("");
		self.push(format!("step {label}"));
		if with_only {
			let extra = self.g.item_only.clone();
			for e in extra {
				self.push(e);
			}
		}
		if with_only && !self.g.item_only.is_empty() {
			self.push(format!("  zone {}", opt_str(&zn)));
			self.push(format!("  goto {},{} \"{label}\"{}", c[0], c[1], c[3]));
			if zn != self.g.zone {
				self.g.zone = None;
			}
			return;
		}
		self.zone_line(zn);
		self.push(format!("  goto {},{} \"{label}\"{}", c[0], c[1], c[3]));
	}

	fn travel_to(&mut self, a: Option<u32>, b: Option<u32>) {
		let cx = self.cx;
		if cx.route_travel {
			self.come_back(a);
		}
		let (Some(pa), Some(pb)) = (cx.w(a), cx.w(b)) else { return };
		if pa.c != pb.c {
			if let Some(best) = cx.crossing(pa, pb) {
				self.goto_step(best.dep, &format!("{} to {}", best.kind, best.dest), false);
			}
			self.goto_step(b, &cx.zone_name(Some(pb.map)).unwrap_or_else(|| "Onward".into()), false);
		} else if pa.map != pb.map && js_hypot(pa.wx - pb.wx, pa.wy - pb.wy) > ZONE_STEP_YD {
			self.goto_step(b, &cx.zone_name(Some(pb.map)).unwrap_or_else(|| "Onward".into()), false);
		}
	}

	fn arrival_at(&self, l: &Line) -> Option<Near> {
		let cx = self.cx;
		let key = l.key();
		if !self.g.arrived.as_ref().is_some_and(|a| a.contains(&key)) || !cx.key_pt.contains_key(&key) {
			return None;
		}
		let m = re!(r"^\s+(kill|collect|interact)\s+(\d+)\b.*\bquest\s+(\d+)").captures(&l.text)?;
		if re!(r"@\s*[\d.]").is_match(&l.text) || re!(r"\b(npc|object)\s+\d").is_match(&l.text) {
			return None;
		}
		// Handed in in the same step: the camp at the ender instead.
		if let Some(&st) = cx.step_of.get(&key) {
			if cx.steps[st].lines.iter().any(|x| turnin_of(&x.text, &m[3])) {
				return None;
			}
		}
		let kind = match &m[1] {
			"kill" => "kill",
			"collect" => "item",
			_ => "object",
		};
		let near = cx.spawn_near(&cx.targets(kind, num(&m[2])), cx.key_pt.get(&key).copied())?;
		(near.d <= ARRIVAL_CAMP_YD).then_some(near)
	}

	fn placed(&self, l: &Line) -> String {
		let cx = self.cx;
		let key = l.key();
		// A work line the route takes far from v1's typed point, with the target's spawns at the
		// route's own point: there (Gahz'ridian at Marvon's, not back at the Dunemaul compound).
		if let (true, Some(&rpt)) = (cx.named.contains(&key), cx.key_pt.get(&key)) {
			if let Some(m) = re!(r"^\s+(kill|collect|interact)\s+(\d+)\b.*\bquest\s+\d+.*?@\s*([\d.]+)\s*,\s*([\d.]+)(?:\s+map\s+(\d+))?").captures(split_comment(&l.text).0) {
				let map_id: Option<u32> = m.get(5).and_then(|x| x.as_str().parse().ok()).or_else(|| cx.zone_ids.iter().find(|(_, z)| Some(z) == l.zone.as_ref()).map(|(k, _)| *k));
				let r = cx.w(Some(rpt));
				if let (Some(map_id), Some(r)) = (map_id, r) {
					let typed = cx.proj.point(map_id, num(&m[3]), num(&m[4]), Some(Frame::Era));
					let far = typed.wx.is_finite() && (typed.c != r.c || js_hypot(typed.wx - r.wx, typed.wy - r.wy) > TYPED_FAR_YD);
					let kind = match &m[1] {
						"kill" => "kill",
						"collect" => "item",
						_ => "object",
					};
					// (A collect only of an item that drops at few places and no vendor sells: never
					// the capitals' cloth donations, whose v1 point is the hand-in.)
					let local_item = kind != "item"
						|| m[2].parse::<u32>().ok().and_then(|id| cx.data.items.get(&id)).is_some_and(|it| it.vendors.as_ref().is_none_or(|v| v.is_empty()) && it.npc_droppers() <= WIDE_DROPPERS);
					if far && local_item {
						if let Some(near) = cx.spawn_near(&cx.targets(kind, num(&m[2])), Some(rpt)) {
							if near.d <= ARRIVAL_CAMP_YD {
								let code = re!(r"\s@\s*[\d.]+\s*,\s*[\d.]+(\s+map\s+\d+)?(\s+live)?").replace(split_comment(&l.text).0, "").into_owned();
								return format!("{}{}{}", trim_end(&code), near.at, split_comment(&l.text).1);
							}
						}
					}
				}
			}
		}
		// An accept the route takes at another of the quest's givers than the one v1 names (WANTED:
		// Andre Firebeard from Steamwheedle Port's poster, not Gadgetzan's): that giver.
		if let (true, Some(&rpt)) = (cx.named.contains(&key), cx.key_pt.get(&key)) {
			if let Some(m) = re!(r"^\s+accept\s+(\d+)\b.*?\b(npc|object)\s+(\d+)").captures(split_comment(&l.text).0) {
				let q: u32 = m[1].parse().unwrap_or(0);
				let kind = if &m[2] == "npc" { "kill" } else { "object" };
				let named_id: u32 = m[3].parse().unwrap_or(0);
				if let Some(st) = cx.data.quests.get(&q).and_then(|r| r.start.as_ref()) {
					let ids: &[u32] = if &m[2] == "npc" { &st.npc } else { &st.object };
					let at = |id: u32| cx.spawn_near(&cx.targets(kind, id as f64), Some(rpt)).map_or(f64::INFINITY, |n| n.d);
					if at(named_id) > ARRIVAL_CAMP_YD {
						if let Some(&other) = ids.iter().filter(|&&i| i != named_id).min_by(|a, b| at(**a).total_cmp(&at(**b))) {
							if at(other) <= ARRIVAL_CAMP_YD {
								// (v1's comment names the other giver's place: it goes.)
								let code = re!(r"\b(npc|object)\s+\d+").replace(split_comment(&l.text).0, format!("{} {other}", &m[2]).as_str()).into_owned();
								return trim_end(&code).to_string();
							}
						}
					}
				}
			}
		}
		if let Some(n) = self.arrival_at(l) {
			let (code, rest) = split_comment(&l.text);
			return format!("{}{}{}", trim_end(code), n.at, rest);
		}
		// v1's own goal lines keep their place as v1 wrote it; a goal handed in in its own step,
		// now after another step than in v1: its camp is the one at the quest's ender.
		let st = cx.step_of.get(&key).copied();
		let ok = self.g.new_before || self.g.arrived.as_ref().is_some_and(|a| a.contains(&key)) || cx.ender_keys.contains(&key);
		if ok {
			if let (Some(m), Some(st)) = (re!(r"^\s+(kill|collect|interact)\s+(\d+)\b.*\bquest\s+(\d+)\b").captures(&l.text), st) {
				if !re!(r"@\s*[\d.]").is_match(&l.text) && !re!(r"\b(npc|object)\s+\d").is_match(&l.text) {
					let tin = cx.steps[st].lines.iter().find(|x| x.kind == Kind::Goal && turnin_of(&x.text, &m[3]));
					if let Some(&tpt) = tin.and_then(|t| cx.key_pt.get(&t.key())) {
						let kind = match &m[1] {
							"kill" => "kill",
							"collect" => "item",
							_ => "object",
						};
						if let Some(near) = cx.spawn_near(&cx.targets(kind, num(&m[2])), Some(tpt)) {
							if near.d <= ENDER_CAMP_YD {
								let (code, rest) = split_comment(&l.text);
								return format!("{}{}{}", trim_end(code), near.at, rest);
							}
						}
					}
				}
			}
		}
		l.text.clone()
	}

	/// v1's flight is flown by the route's characters when they are at a flight master on the
	/// flight's continent.
	fn fly_ok(&self, text: &str) -> bool {
		let cx = self.cx;
		let Some(fl) = re!(r#"^\s+fly\s+"([^"]+)""#).captures(text) else { return true };
		if self.pos.is_none() {
			return true;
		}
		let f0 = cx.fp_near(self.pos);
		let p0 = cx.w(self.pos);
		let q0 = f0.and_then(|f| cx.w(cx.world.nodes[f].pt));
		let d0 = cx.fp_by_name(&fl[1]).and_then(|d| cx.w(cx.world.nodes[d].pt));
		if let (Some(d0), Some(p0)) = (d0, p0) {
			if d0.c == p0.c && js_hypot(d0.wx - p0.wx, d0.wy - p0.wy) <= FLY_FROM_YD {
				return false;
			}
		}
		matches!((q0, p0, d0), (Some(q0), Some(p0), Some(d0)) if d0.c == q0.c && js_hypot(q0.wx - p0.wx, q0.wy - p0.wy) <= FLY_FROM_YD)
	}

	/// v1's boat or zeppelin goto is taken by the route's characters when its dock is near them.
	fn ride_ok(&self, text: &str) -> bool {
		let cx = self.cx;
		if self.pos.is_none() {
			return true;
		}
		let Some(gm) = re!(r"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)").captures(text) else { return true };
		let map_id: Option<u32> = match re!(r"\bmap\s+(\d+)").captures(text) {
			Some(mm) => mm[1].parse().ok(),
			None => cx.zone_ids.iter().find(|(_, z)| Some(z) == self.g.zone.as_ref()).map(|(k, _)| *k),
		};
		let Some(map_id) = map_id else { return true };
		let w = cx.proj.point(map_id, num(&gm[1]), num(&gm[2]), Some(Frame::Era));
		let Some(p0) = cx.w(self.pos) else { return true };
		if !w.wx.is_finite() {
			return true;
		}
		w.c == p0.c && js_hypot(w.wx - p0.wx, w.wy - p0.wy) <= RIDE_FROM_YD
	}

	fn flush_arrival(&mut self) {
		let a = std::mem::take(&mut self.g.arrival);
		self.g.body.extend(a.into_iter().map(Some));
	}

	fn fly_step(&mut self, f0: usize, dest_name: &str) {
		let cx = self.cx;
		let c0 = coords_re(&cx.coords_of(cx.world.nodes[f0].pt));
		self.push("");
		self.push(format!("step Fly to {dest_name}"));
		let extra = self.g.item_only.clone();
		for e in extra {
			self.push(e);
		}
		if let Some(c0) = c0 {
			let zn = cx.zone_name(c0[2].parse().ok());
			self.push(format!("  zone {}", opt_str(&zn)));
			self.g.zone = zn;
			self.push(format!("  goto {},{} \"{} flight master\"{}", c0[0], c0[1], cx.world.nodes[f0].name, c0[3]));
		}
		self.push(format!("  fly \"{dest_name}\""));
	}

	/// The route's items before the step they happen on the way to (see apply-route.js writeItems).
	fn write_items(&mut self, its: &[Item], to_way: bool) {
		let cx = self.cx;
		for x in its {
			// A flight path v1's line (for everyone) has learned already: not again.
			if x.t == ItemT::Getfp {
				let had = x.node.is_some_and(|n| self.known.contains(&n));
				if let Some(n) = x.node {
					if self.known.insert(n) {
						self.fresh_fps.insert(n);
					}
				}
				if had {
					continue;
				}
			}
			match x.t {
				ItemT::Hearth if cx.inn_name(x.inn).is_some() => {
					// (Everyone hearths, wherever they are.)
					self.away.clear();
					let name = cx.inn_name(x.inn).unwrap().to_string();
					self.push("");
					self.push(format!("step Hearth to {name}"));
					let extra = self.g.item_only.clone();
					for e in extra {
						self.push(e);
					}
					self.push(format!("  hearth \"{name}\""));
					if let Some(p) = cx.inn_pt(&name) {
						self.pos = Some(p);
					}
					// The route's hearth item ends where the route goes on to from the inn (Ratchet's inn,
					// then Gadgetzan): that part of the leg is its own flight or walk.
					let inn = x.inn_pt.or_else(|| cx.inn_pt(&name));
					// (Unless the route writes that leg itself next: its flight item.)
					if cx.route_travel && x.to.is_some() && inn.is_some() && x.to != inn && !its.iter().any(|y| y.t == ItemT::Network) {
						let (Some(a), Some(b)) = (cx.w(inn), cx.w(x.to)) else { continue };
						if a.c == b.c && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
							let on = Item { t: ItemT::Network, inn: None, pt: None, inn_pt: None, used: None, returns: None, from: inn, to: x.to, node: None, legs: x.legs.clone() };
							self.write_items(&[on], to_way);
						}
					}
				}
				ItemT::Network if cx.route_travel && x.legs.as_ref().is_some_and(|l| !l.is_empty()) => {
					// The sim's own path: written as it is.
					self.come_back(x.from);
					self.pos = x.to;
					let mut at = x.from;
					// Consecutive flights are one (the flight master flies the hops: Shadowprey to Orgrimmar).
					let mut legs: Vec<crate::input::Leg> = Vec::new();
					for l in x.legs.as_ref().unwrap() {
						match (legs.last_mut(), l.k.as_deref()) {
							(Some(last), Some("fly")) if last.k.as_deref() == Some("fly") && last.to == l.from => last.to = l.to,
							_ => legs.push(l.clone()),
						}
					}
					for l in &legs {
						// v1's steps waiting at this place on the way (Orgrimmar's trainer before the zeppelin).
						if self.flush_orphans_at(&mut at, Some(l)) {
							// v1's own line flies it.
							at = l.to.and_then(|b| cx.world.nodes.get(b as usize)).and_then(|n| n.pt);
							continue;
						}
						match l.k.as_deref() {
							Some("fly") => {
								let (Some(a), Some(b)) = (l.from.map(|v| v as usize), l.to.map(|v| v as usize)) else { continue };
								if a >= cx.world.nodes.len() || b >= cx.world.nodes.len() {
									continue;
								}
								let name = cx.world.nodes[b].name.clone();
								self.fly_step(a, &name);
								if !self.g.item_only.is_empty() {
									self.g.zone = None;
								}
								at = cx.world.nodes[b].pt;
							}
							Some("ride") => {
								let Some(r) = l.ride.and_then(|r| cx.world.rides.get(r)) else { continue };
								let (Some(na), Some(nb)) = (r.a.and_then(|i| cx.world.nodes.get(i)), r.b.and_then(|i| cx.world.nodes.get(i))) else { continue };
								// (A lift is part of the walk.)
								if r.kind != Some("lift") {
									let kind = match r.kind.unwrap_or("boat") {
										"zeppelin" => "Zeppelin",
										"tram" => "Tram",
										"portal" => "Portal",
										_ => "Boat",
									};
									// (A portal's end is named by its zone.)
									let dest = if kind == "Portal" {
										cx.w(nb.pt).and_then(|p| cx.zone_name(Some(p.map))).unwrap_or_default()
									} else {
										re!(r"(?i)\s*\((boat|zeppelin|tram)\)$").replace(&nb.name, "").into_owned()
									};
									self.goto_step(na.pt, &format!("{kind} to {dest}"), true);
								}
								at = nb.pt;
							}
							_ => {
								// (A walk to a node: the node's point.)
								let to = l.node.and_then(|n| cx.world.nodes.get(n)).and_then(|n| n.pt).or(l.to).or(x.to);
								if let (Some(a), Some(b)) = (cx.w(at), cx.w(to)) {
									if a.c == b.c && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
										self.goto_step(to, &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
									}
								}
								at = to;
							}
						}
					}
					self.flush_orphans_at(&mut at, None);
					// The walk on to the leg's end.
					if let (Some(a), Some(b)) = (cx.w(at), cx.w(x.to)) {
						if at != x.to && a.c == b.c && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
							self.goto_step(x.to, &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
						}
					}
				}
				ItemT::Network => {
					if cx.route_travel {
						self.come_back(x.from);
					}
					self.pos = x.to;
					let (Some(a), Some(b)) = (cx.w(x.from), cx.w(x.to)) else { continue };
					let mut start = x.from;
					// v1's own transport goto just written: no second one.
					let n = self.g.body.len();
					let rode = self.g.body[n.saturating_sub(12)..]
						.iter()
						.any(|l| l.as_deref().is_some_and(|l| re!(r#"(?i)^\s+goto\s.*"(Zeppelin|Boat|Tram|Ship) to"#).is_match(l) && (!cx.route_travel || cx.for_all_r(line_only(l)))));
					if a.c != b.c {
						let Some(best) = cx.crossing(a, b) else { continue };
						if !rode && cx.route_travel {
							// To the dock first: the flight quickest by walking yards, when it beats the walk.
							if let Some((g0, g1)) = cx.best_flight(x.from, best.dep, &self.known) {
								let name = cx.world.nodes[g1].name.clone();
								self.fly_step(g0, &name);
								if !self.g.item_only.is_empty() {
									self.g.zone = None;
								}
							}
							self.goto_step(best.dep, &format!("{} to {}", best.kind, best.dest), true);
						} else if !rode {
							// To the dock first: a flight between known flight paths when it is far.
							let g0 = cx.fp_near(x.from);
							let g1 = cx.fp_near(best.dep);
							let dp = cx.w(best.dep).unwrap();
							if let (Some(g0), Some(g1)) = (g0, g1) {
								if g0 != g1 && self.known.contains(&g0) && self.known.contains(&g1) && js_hypot(dp.wx - a.wx, dp.wy - a.wy) > ZONE_STEP_YD {
									let name = cx.world.nodes[g1].name.clone();
									self.fly_step(g0, &name);
									if !self.g.item_only.is_empty() {
										self.g.zone = None;
									}
								}
							}
							self.goto_step(best.dep, &format!("{} to {}", best.kind, best.dest), true);
						}
						start = best.arr;
					}
					let mut f0 = cx.fp_near(start);
					let mut f1 = cx.fp_near(x.to);
					let mut flown = match (f0, f1) {
						(Some(f0), Some(f1)) => f0 != f1 && self.known.contains(&f0) && self.known.contains(&f1),
						_ => false,
					};
					// The route's own leg: the flight quickest by walking yards to and from the flight
					// masters (Sun Rock for Desolace, not Thunder Bluff; Darkshire for the Swamp, not
					// Lakeshire through the mountains), else the walk.
					if cx.route_travel {
						match cx.best_flight(start, x.to, &self.known) {
							Some((a, b)) => {
								f0 = Some(a);
								f1 = Some(b);
								flown = true;
							}
							None => flown = false,
						}
					}
					// The flight paths nearest the ends not both known: the known ones nearest
					// them, when the walks to and from them are well short of the walk itself
					// (Camp Taurajo's for Thunder Bluff's path, not 3,000 yd through the
					// mountains; Camp Taurajo's for the Great Lift).
					if !flown && !cx.route_travel {
						let k0 = cx.fp_near_known(start, &self.known);
						let k1 = cx.fp_near_known(x.to, &self.known);
						if let (Some(k0), Some(k1)) = (k0, k1) {
							let d = |p: Option<u32>, q: Option<u32>| match (cx.w(p), cx.w(q)) {
								(Some(p), Some(q)) if p.c == q.c => js_hypot(p.wx - q.wx, p.wy - q.wy),
								_ => f64::INFINITY,
							};
							let walks = d(start, cx.world.nodes[k0].pt) + d(cx.world.nodes[k1].pt, x.to);
							if k0 != k1 && walks + FLY_SAVES_YD < d(start, x.to) {
								f0 = Some(k0);
								f1 = Some(k1);
								flown = true;
							}
						}
					}
					if !flown {
						// Walked: a goto there.
						let am = if a.c != b.c { -1 } else { a.map as i64 };
						if !to_way && (b.map as i64 != am || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
							self.goto_step(x.to, &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
						}
						continue;
					}
					let (f0, f1) = (f0.unwrap(), f1.unwrap());
					// v1's step just written already takes the character there: no flight back to it.
					let last_title =
						self.g.body.iter().rev().filter_map(|l| l.as_deref()).find(|l| re!(r"^step\s").is_match(l)).map_or(String::new(), |l| re!(r"^step\s+").replace(l, "").into_owned());
					let f1name = cx.world.nodes[f1].name.clone();
					if f1name.split(',').next() == Some(last_title.as_str()) {
						let target = format!("step {last_title}");
						let idx = self.g.body.iter().rposition(|l| l.as_deref() == Some(target.as_str()));
						let from = idx.unwrap_or(self.g.body.len().saturating_sub(1));
						if self.g.body[from..].iter().any(|l| l.as_deref().is_some_and(|l| is_head_ws(l, "getfp"))) {
							continue;
						}
					}
					let zb = self.g.zone.clone();
					self.fly_step(f0, &f1name);
					if !self.g.item_only.is_empty() && self.g.zone != zb {
						self.g.zone = None;
					}
					// The route's own leg goes on on foot from where the flight lands, into another zone
					// or far (Sun Rock Retreat to the Gizelton caravan in Desolace).
					if cx.route_travel && !to_way {
						if let (Some(l), Some(t)) = (cx.w(cx.world.nodes[f1].pt), cx.w(x.to)) {
							if l.map != t.map || js_hypot(l.wx - t.wx, l.wy - t.wy) > ZONE_STEP_YD {
								self.goto_step(x.to, &cx.zone_name(Some(t.map)).unwrap_or_else(|| "Onward".into()), true);
							}
						}
					}
				}
				ItemT::Getfp => {
					// At the arrival: in the step the route arrives for.
					if let Some(n) = x.node.and_then(|n| cx.world.nodes.get(n)) {
						if n.kind == "fp" {
							self.g.arrival.push(format!("  getfp \"{}\"{}", n.name, self.g.goal_only));
						}
					}
				}
				ItemT::Bind if (x.used == Some(true) || x.returns.unwrap_or(0.0) >= 2.0) && cx.inn_name(x.inn).is_some() => {
					// Used by a hearth, or a town the route comes back to twice or more.
					self.g.arrival.push(format!("  sethome \"{}\"{}", cx.inn_name(x.inn).unwrap(), self.g.goal_only));
				}
				_ => {}
			}
		}
	}

	fn step_lines(&mut self, si: usize, keys: Option<&[Key]>, whole: bool, only_for: Option<&[String]>) {
		let cx = self.cx;
		let s = &cx.steps[si];
		// A step only some characters play does not change the zone the others read the next
		// step's coordinates in.
		self.g.new_before = s.k > 0 && self.g.last_step != Some(s.k - 1) && cx.steps[s.k - 1].file == s.file;
		self.g.last_step = Some(si);
		let zone_before = self.g.zone.clone();
		let only_for = only_for.filter(|o| !o.is_empty());
		let for_some = only_for.is_some() || s.lines.iter().any(|l| is_head_ws(&l.text, "only"));
		let step_only_line = s.lines.iter().find(|l| is_head_ws(&l.text, "only"));
		let step_list: Option<String> = match (only_for, step_only_line) {
			(Some(o), _) => Some(o.join(",")),
			(None, Some(l)) => Some(trim(&re!(r"^\s+only\s+").replace(&l.text, "")).to_string()),
			_ => None,
		};
		let first = self.first_piece.insert(si);
		if first {
			for p in &s.pre {
				self.push(p.clone());
			}
		} else {
			self.push("");
		}
		// Arrived by the route's travel somewhere else than v1's step: the step is named for the
		// place the lines now lead to.
		let moved = if self.g.arrived.is_some() { s.lines.iter().find(|l| self.arrival_at(l).is_some()) } else { None };
		let mut title = s.title.clone();
		if let (Some(moved), Some(area_at)) = (moved, cx.area_at) {
			if let Some(p0) = cx.w(cx.key_pt.get(&moved.key()).copied()) {
				if let Some(a) = area_at.at(p0.c, p0.wx, p0.wy) {
					if !a.name.is_empty() && a.name != a.zone && !s.title.contains(&a.name) {
						title = format!("step {}", a.name);
					}
				}
			}
		}
		self.push(title.clone());
		// A start guide's step written in a guide more races play: only theirs.
		if let Some(o) = only_for {
			if !s.lines.iter().any(|l| is_head_ws(&l.text, "only")) {
				self.push(format!("  only {}", o.join(",")));
			}
		}
		let has_zone = s.lines.iter().any(|l| is_head_ws(&l.text, "zone"));
		if !has_zone && s.zone_in != self.g.zone {
			self.zone_line(s.zone_in.clone());
		}
		for l in &s.lines {
			if l.kind == Kind::Every || (first && matches!(l.kind, Kind::First | Kind::Other)) {
				self.push(l.text.clone());
				if is_head_ws(&l.text, "zone") {
					self.g.zone = Some(trim(&re!(r"^\s+zone\s+").replace(&l.text, "")).to_string());
				}
			}
		}
		// A class-only step is no place for everyone's bind: its own step then.
		if !self.g.arrival.is_empty() && s.lines.iter().any(|l| is_head_ws(&l.text, "only")) {
			let keep = std::mem::take(&mut self.g.arrival);
			let at = self.g.body.iter().rposition(|l| l.as_deref() == Some(title.as_str())).expect("title just written");
			let mut ins: Vec<Option<String>> = vec![Some("step Inn and flight master".into())];
			ins.extend(keep.into_iter().map(Some));
			ins.push(Some(String::new()));
			self.g.body.splice(at..at, ins);
		}
		// The route's arrival (its bind, its flight path) comes after the step's own travel there: a step
		// that starts with v1's flight or walk to the place binds once arrived (the Darkshire bind after
		// the flight to Darkshire).
		let leads_travel = self.cx.route_travel
			&& match keys {
				Some(ks) => {
					let first = self.cx.before.get(&ks[0]).and_then(|v| v.first()).map(|l| l.text.clone()).or_else(|| s.line(ks[0].1).map(|l| l.text.clone()));
					first.is_some_and(|t| re!(r"^\s+(fly|goto|hearth)\s").is_match(&t))
				}
				None => s.lines.iter().find(|l| l.kind == Kind::Goal).is_some_and(|l| re!(r"^\s+(fly|goto|hearth)\s").is_match(&l.text)),
			};
		if leads_travel {
			self.g.hold_arrival = true;
		} else {
			self.flush_arrival();
		}
		let own = self.g.zone.clone();
		let mut away = false;
		let mut put = |w: &mut Self, l: &Line| {
			w.put(si, l, &own, &mut away, step_list.as_deref(), step_only_line);
		};
		if whole {
			for l in &s.lines {
				if l.kind == Kind::Goal && !cx.dropped_line(&l.text, Some(l.key())) && !cx.carried.contains(&l.key()) {
					put(self, l);
				}
			}
		} else {
			let keys = keys.unwrap();
			// A piece of nothing but `complete` (an escort, an event) keeps its step's gotos.
			let texts: Vec<&str> = keys.iter().map(|k| s.line(k.1).unwrap().text.as_str()).collect();
			let anchored = keys.iter().flat_map(|k| cx.before.get(k).into_iter().flatten().chain(cx.after.get(k).into_iter().flatten()));
			let mut anchored_goto = false;
			for l in anchored {
				if is_head_ws(&l.text, "goto") {
					anchored_goto = true;
				}
			}
			if texts.iter().all(|t| is_head_ws(t, "complete")) && !anchored_goto {
				let gotos: Vec<&Line> = s.lines.iter().filter(|l| is_head_ws(&l.text, "goto")).collect();
				for l in &gotos {
					self.push(l.text.clone());
				}
				// None in the step: the route's point for the work, in the step's zone.
				let kp = cx.key_pt.get(&keys[0]).copied();
				let p = if gotos.is_empty() && kp.is_some() { cx.w(kp) } else { None };
				if let Some(p) = p {
					if cx.zone_name(Some(p.map)) == self.g.zone {
						if let Some(c) = re!(r"^ @([\d.]+),([\d.]+)").captures(&cx.coords_of(kp)) {
							self.push(format!("  goto {},{}", &c[1], &c[2]));
						}
					}
				}
			}
			for k in keys {
				for l in cx.before.get(k).into_iter().flatten() {
					put(self, l);
				}
				put(self, s.line(k.1).unwrap());
				for l in cx.after.get(k).into_iter().flatten() {
					put(self, l);
				}
			}
		}
		if first {
			if let Some(post) = &s.post {
				for p in post {
					self.push(p.clone());
				}
			}
		}
		// The zone is sticky for those who saw the step: the next step everyone sees names its zone again.
		if for_some && self.g.zone != zone_before {
			self.g.zone = None;
		}
		// A class's own detour (it flies to its trainer) leaves those classes away from the route;
		// a flight or hearth written for everyone brings everyone along.
		if cx.route_travel {
			let at = self.g.body.iter().rposition(|l| l.as_deref() == Some(title.as_str())).unwrap_or(0);
			let moved: Vec<String> = self.g.body[at..].iter().flatten().filter(|l| is_head_ws(l, "fly") || is_head_ws(l, "hearth")).cloned().collect();
			// (v1's travel the route may still give the other races: undone with it.)
			let pending: Vec<usize> = self.g.v1_moves.iter().map(|m| m.0).filter(|&k| k >= at).collect();
			let class_list = step_list.as_deref().filter(|l| only_classes(Some(l)) && Ctx::only_races(Some(l)).is_none());
			// (On foot into another zone: a detour too, walked back.)
			let own_zone = s.lines.iter().find(|l| is_head_ws(&l.text, "zone")).map(|l| trim(&re!(r"^\s+zone\s+").replace(split_comment(&l.text).0, "")).to_string()).or_else(|| s.zone_in.clone());
			let route_zone = cx.w(self.route_pt).and_then(|p| cx.zone_name(Some(p.map)));
			let walked = route_zone.is_some() && own_zone.is_some() && own_zone != route_zone;
			if let Some(cl) = class_list {
				if moved.iter().any(|l| line_only(l).is_none()) || walked {
					let to = moved.iter().rev().find_map(|l| re!(r#"^\s+fly\s+"([^"]+)""#).captures(l).map(|m| m[1].to_string()));
					// (Several classes' detours: each comes back from where it went last.)
					for a in self.away.iter_mut() {
						a.0 = a.0.split(',').filter(|c| !cl.split(',').any(|x| x == *c)).collect::<Vec<_>>().join(",");
					}
					self.away.retain(|a| !a.0.is_empty());
					match self.away.iter_mut().find(|a| a.1 == to) {
						Some(a) => {
							for c in cl.split(',') {
								if !a.0.split(',').any(|x| x == c) {
									a.0 = format!("{},{c}", a.0);
								}
							}
						}
						None => self.away.push((cl.to_string(), to)),
					}
				}
			} else if !for_some && moved.iter().any(|l| line_only(l).is_none()) {
				let had = std::mem::take(&mut self.away);
				if !had.is_empty() {
					for k in pending {
						self.away_undo.push((k, had.clone()));
					}
				}
			}
		}
	}

	/// v1's travel line at body index `k` is the other races' after all: the detours it ended are
	/// not over.
	fn undo_away(&mut self, k: usize) {
		if let Some(i) = self.away_undo.iter().position(|u| u.0 == k) {
			let (_, had) = self.away_undo.remove(i);
			for a in had {
				if !self.away.contains(&a) {
					self.away.push(a);
				}
			}
		}
	}

	/// The walk to a v1 step the route did not place, from `at`, when it is in another zone or far
	/// and the step has no travel of its own; `at` moves on to where the step ends.
	fn walk_to_step(&mut self, si: usize, at: &mut Option<u32>) {
		let cx = self.cx;
		let step = &cx.steps[si];
		let pts: Vec<u32> = step.lines.iter().filter_map(|l| cx.line_pt(l)).collect();
		let travels = step.lines.iter().any(|l| ["goto", "fly", "hearth"].iter().any(|h| is_head_ws(&l.text, h)));
		if let (Some(&p0), false) = (pts.first(), travels) {
			if let (Some(a), Some(b)) = (cx.w(*at), cx.w(Some(p0))) {
				if a.c == b.c && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
					self.goto_step(Some(p0), &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
				}
			}
		}
		if let Some(&p1) = pts.last() {
			*at = Some(p1);
		}
	}

	/// Before a v1 step everyone plays: the classes away come back to its place.
	fn come_back_to_step(&mut self, si: usize) {
		let cx = self.cx;
		if !cx.route_travel || self.away.is_empty() {
			return;
		}
		let s = &cx.steps[si];
		if s.lines.iter().any(|l| is_head_ws(&l.text, "only")) {
			return;
		}
		let to = s.lines.iter().find_map(|l| cx.line_pt(l));
		self.come_back(to);
	}

	/// The classes away on their own detour come back to `to`, where the route goes on from: by the
	/// flight master nearest it, from the one they flew to (else on foot).
	fn come_back(&mut self, to: Option<u32>) {
		let cx = self.cx;
		if to.is_none() {
			return;
		}
		for (cl, there) in std::mem::take(&mut self.away) {
			let there_fm = there.as_deref().and_then(|t| cx.fp_by_name(t));
			// (A flight path learnt at the place the route goes to is not known before it.)
			let known: FxHashSet<usize> = self.known.difference(&self.fresh_fps).copied().collect();
			// (Walked away: walked back.)
			let fm = if there.is_some() { cx.fp_near_known(to, &known) } else { None };
			let master = |i: usize| -> Option<(String, [String; 4])> { Some((cx.zone_name(cx.w(cx.world.nodes[i].pt).map(|p| p.map))?, coords_re(&cx.coords_of(cx.world.nodes[i].pt))?)) };
			self.push("");
			match fm.filter(|&f| Some(f) != there_fm) {
				Some(f) => {
					let name = cx.world.nodes[f].name.split(',').next().unwrap_or("").to_string();
					self.push(format!("step Back to {name}"));
					self.push(format!("  only {cl}"));
					if let Some((z, c)) = there_fm.and_then(master) {
						self.push(format!("  zone {z}"));
						self.push(format!("  goto {},{} \"{} flight master\"{}", c[0], c[1], cx.world.nodes[there_fm.unwrap()].name, c[3]));
					}
					self.push(format!("  fly \"{name}\""));
				}
				None => {
					let Some(c) = coords_re(&cx.coords_of(to)) else { continue };
					let z = cx.zone_name(c[2].parse().ok()).unwrap_or_default();
					self.push(format!("step Back to {z}"));
					self.push(format!("  only {cl}"));
					self.push(format!("  zone {z}"));
					self.push(format!("  goto {},{} \"{z}\"{}", c[0], c[1], c[3]));
				}
			}
			self.g.zone = None;
		}
	}

	fn put(&mut self, si: usize, l: &Line, own: &Option<String>, away: &mut bool, step_list: Option<&str>, step_only_line: Option<&Line>) {
		let cx = self.cx;
		let s = &cx.steps[si];
		let lsi = cx.step_of.get(&l.key()).copied().unwrap_or(si);
		let ls = &cx.steps[lsi];
		// A line carried from a step in another zone gets a step of its own in that zone.
		if lsi != si && truthy(&ls.zone) && ls.zone != *own {
			self.push("");
			self.push(ls.title.clone());
			if ls.zone != self.g.zone {
				self.push(format!("  zone {}", ls.zone.as_deref().unwrap()));
				self.g.zone = ls.zone.clone();
			}
			*away = true;
		} else if *away {
			self.push("");
			self.push(s.title.clone());
			if *own != self.g.zone {
				self.push(format!("  zone {}", opt_str(own)));
				self.g.zone = own.clone();
			}
			*away = false;
		}
		// Typed coordinates are read in the zone v1 wrote them in.
		if truthy(&l.zone) && l.zone != self.g.zone && re!(r"(@\s*[\d.]+\s*,|^\s+goto\s+[\d.]+\s*,)").is_match(&l.text) && !re!(r"\bmap\s+\d").is_match(&l.text) {
			self.push(format!("  zone {}", l.zone.as_deref().unwrap()));
			self.g.zone = l.zone.clone();
		}
		if let Some(fp) = re!(r#"^\s+getfp\s+"([^"]+)""#).captures(&l.text) {
			if let Some(k) = cx.fp_by_name(&fp[1]) {
				self.known.insert(k);
			}
		}
		let key = l.key();
		let mut text: Option<String> = Some(match cx.level_at.get(&key) {
			Some(&lvl) => level_line(&self.placed(l), lvl),
			None => self.placed(l),
		});
		let theirs = |t: &str| if cx.shared(l.file) && !cx.other_races.is_empty() { Some(cx.others_only(t)) } else { None };
		// Binds and hearths are the route's: v1's are the other races'.
		if let Some(t) = text.clone() {
			if matches!(head_ws(&t), Some("sethome" | "hearth")) && line_only(&t).is_none() && cx.has_items && !cx.named.contains(&key) {
				text = theirs(&t);
			}
		}
		let transport = |t: &str| re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(t);
		// v1's travel before the piece the route's own leg takes them to: the other races'.
		if self.g.gate_pre.remove(&key) {
			if let Some(t) = text.clone() {
				if line_only(&t).is_none() {
					text = theirs(&t);
				}
			}
		}
		// v1's flight, for everyone, when the route's characters are at a flight master on the
		// flight's continent; else the other races'.
		let mut fly_from: Option<FlyFrom> = None;
		if let Some(t) = text.clone() {
			if !cx.route_travel && transport(&t) && line_only(&t).is_none() && cx.for_all_r(step_list) && !self.ride_ok(&t) {
				text = theirs(&t);
			}
		}
		if let Some(t) = text.clone() {
			if !cx.route_travel && is_head_ws(&t, "fly") && line_only(&t).is_none() && cx.for_all_r(step_list) && !self.fly_ok(&t) {
				// The route's characters fly there from the flight master nearest them, when both
				// flight paths are known: their own flight step.
				let dest = re!(r#"^\s+fly\s+"([^"]+)""#).captures(&t).and_then(|m| cx.fp_by_name(&m[1]));
				let f0 = if self.pos.is_some() { cx.fp_near(self.pos) } else { None };
				if let (Some(dest), Some(f0)) = (dest, f0) {
					let (wf, wd) = (cx.w(cx.world.nodes[f0].pt), cx.w(cx.world.nodes[dest].pt));
					if f0 != dest && matches!((wf, wd), (Some(a), Some(b)) if a.c == b.c) && self.known.contains(&f0) && self.known.contains(&dest) {
						fly_from = Some(FlyFrom { f0, dest });
					}
				}
				text = theirs(&t);
			}
		}
		if let Some(ff) = fly_from {
			let zb = self.g.zone.clone();
			let name = cx.world.nodes[ff.dest].name.clone();
			self.fly_step(ff.f0, &name);
			if !self.g.item_only.is_empty() {
				self.g.zone = None;
			}
			self.pos = cx.world.nodes[ff.dest].pt;
			self.push("");
			self.push(s.title.clone());
			if let Some(sol) = step_only_line {
				self.push(sol.text.clone());
			}
			if truthy(&zb) && zb != self.g.zone {
				self.push(format!("  zone {}", zb.as_deref().unwrap()));
				self.g.zone = zb;
			}
		}
		self.g.body.push(text.clone());
		if self.g.hold_arrival {
			self.g.hold_arrival = false;
			self.flush_arrival();
		}
		let Some(text) = text else { return };
		if let Some(lo) = line_only(&text) {
			if !cx.for_all_r(Some(lo)) {
				return;
			}
		}
		if let Some(its) = cx.items_at_line.get(&key) {
			for x in its {
				if x.t == ItemT::Bind {
					if let Some(name) = cx.inn_name(x.inn) {
						self.push(format!("  sethome \"{name}\"{}", self.g.goal_only));
					}
				} else if x.t == ItemT::Getfp {
					if let Some(n) = x.node.and_then(|n| cx.world.nodes.get(n)).filter(|n| n.kind == "fp") {
						self.push(format!("  getfp \"{}\"{}", n.name, self.g.goal_only));
						self.known.insert(x.node.unwrap());
					}
				}
			}
		}
		// v1's travel, for everyone: which moves every route character.
		let all_r = cx.for_all_r(step_list) && cx.for_all_r(line_only(&text));
		let fl2 = re!(r#"^\s+fly\s+"([^"]+)""#).captures(&text);
		if all_r {
			if let Some(d) = fl2.as_ref().and_then(|m| cx.fp_by_name(&m[1])) {
				self.pos = cx.world.nodes[d].pt;
			}
		}
		// A boat or zeppelin: where it lands is not known here.
		if all_r && transport(&text) {
			self.pos = None;
		}
		// A step of nothing but gotos: a waypoint on the way.
		if all_r && !s.way {
			if let Some(gm) = re!(r"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)").captures(&text) {
				if s.lines.iter().filter(|x| x.kind == Kind::Goal).all(|x| is_head_ws(&x.text, "goto")) {
					let mm = re!(r"\bmap\s+(\d+)").captures(&text);
					let map_id: Option<u32> = match &mm {
						Some(mm) => mm[1].parse().ok(),
						None => cx.zone_ids.iter().find(|(_, z)| Some(z) == self.g.zone.as_ref()).map(|(k, _)| *k),
					};
					if let Some(map_id) = map_id {
						let w = cx.proj.point(map_id, num(&gm[1]), num(&gm[2]), Some(Frame::Era));
						if w.wx.is_finite() {
							self.g.waypoints.push(Waypoint { k: self.g.body.len() - 1, c: w.c, wx: w.wx, wy: w.wy });
						}
					}
				}
			}
		}
		if all_r && !s.way && !cx.named.contains(&key) {
			// (A plain goto is a waypoint, often to a cave mouth: not travel.)
			let kind = if fl2.is_some() {
				Some("fly")
			} else if transport(&text) {
				Some("ride")
			} else {
				None
			};
			if let Some(kind) = kind {
				self.g.v1_moves.push((self.g.body.len() - 1, kind));
			}
		}
	}
}

/// R4: the route's grind items on v1 `level` lines -> their targets, when no quest the route accepts
/// before its next grind needs a level the fraction does not reach.
fn level_targets(order: &[Order], data: &Data) -> FxHashMap<Key, f64> {
	let mut out = FxHashMap::default();
	for (i, o) in order.iter().enumerate() {
		let (OrderT::Level, Some(k), Some(lvl)) = (o.t, o.key, o.lvl) else { continue };
		// A grind that unlocks accepts (the last one, to 60, is the route's end: not shortened).
		let accepts: Vec<&Order> = order[i + 1..].iter().take_while(|x| x.t != OrderT::Level).filter(|x| x.t == OrderT::Accept).collect();
		let ok = !accepts.is_empty() && lvl < 59.0 && accepts.iter().all(|x| x.q.and_then(|q| data.quests.get(&q)).and_then(|r| r.min_level).is_none_or(|m| m <= lvl.floor()));
		if ok {
			out.insert(k, lvl);
		}
	}
	out
}

/// R4: `level N` as the route's grind target when the route reaches N's unlock at least a tenth of a level
/// earlier: `level 15.91` (whole percent; a share that rounds to 0% or 100% is the whole level).
pub fn level_line(text: &str, lvl: f64) -> String {
	let Some(m) = re!(r"^(\s+level\s+)(\d+)(\s.*)?$").captures(text) else { return text.to_string() };
	let n: f64 = m[2].parse().unwrap_or(0.0);
	if !(lvl < n - 0.1 + 1e-9 && lvl > n - 1.0) {
		return text.to_string();
	}
	let floor = lvl.floor();
	let pct = ((lvl - floor) * 100.0).round() as i64;
	let v = match pct {
		0 => format!("{}", floor as i64),
		100 => format!("{}", floor as i64 + 1),
		p if p % 10 == 0 => format!("{}.{}", floor as i64, p / 10),
		p => format!("{}.{p:02}", floor as i64),
	};
	format!("{}{v}{}", &m[1], m.get(3).map_or("", |x| x.as_str()))
}

/// `^\s+turnin\s+Q\b` for the digits Q.
fn turnin_of(text: &str, q: &str) -> bool {
	if !is_word_at(text, "turnin") {
		return false;
	}
	let body = text.trim_start_matches(crate::jsre::is_ws);
	let rest = &body["turnin".len()..];
	let digits = rest.trim_start_matches(crate::jsre::is_ws);
	digits.len() < rest.len() && starts_num(digits, q)
}

#[allow(dead_code)]
fn _goal(text: &str) -> bool {
	is_goal(text) && is_step(text)
}
