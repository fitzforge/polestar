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
use crate::jsre::{head, head_ws, is_step, num, split_comment, split_sentences, starts_nonspace, starts_num, trim, trim_end};
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
/// A quest-starting drop below this chance (percent), or of unknown chance, is never required.
const RARE_START_PCT: f64 = 5.0;
const ZONE_STEP_YD: f64 = 600.0;
/// A later piece of a v1 step this far from its first piece is somewhere else (named for its own place).
const FAR_PIECE_YD: f64 = 400.0;
/// Guides with no route line the played chain passes through on to one with route lines.
const PASS_THROUGH_GUIDES: usize = 2;

pub const FACTION_RACES_HORDE: [&str; 5] = ["Orc", "Troll", "Tauren", "Undead", "Skyborne"];
pub const FACTION_RACES_ALLIANCE: [&str; 5] = ["Human", "Dwarf", "Gnome", "NightElf", "Skyborne"];
pub const ALL_RACES: [&str; 9] = ["Orc", "Troll", "Tauren", "Undead", "Skyborne", "Human", "Dwarf", "Gnome", "NightElf"];
pub(crate) const CLASSES: [&str; 9] = ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"];

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
	/// Files of the faction's shared route after its join: every start plays them in the same
	/// order, so they are written for everyone (no per-race splits).
	tail: Vec<bool>,
	steps: Vec<Step>,
	step_of: FxHashMap<Key, usize>,
	named: FxHashSet<Key>,
	key_pt: FxHashMap<Key, u32>,
	/// The route's level at each of its v1 lines.
	key_lvl: FxHashMap<Key, f64>,
	/// v1 `level` lines the route's grind items name -> the route's target.
	level_at: FxHashMap<Key, f64>,
	ender_keys: FxHashSet<Key>,
	items_at_line: FxHashMap<Key, Vec<Item>>,
	/// v1's buy lines of a timed item the route buys at several stops (two Arcane Quickeners, one
	/// before each cauldron): one at each, written where each is bought.
	buy_each: FxHashSet<Key>,
	/// Every v1 buy line of a timed item the route names.
	timed_buy: FxHashSet<Key>,
	before: FxHashMap<Key, Vec<Line>>,
	after: FxHashMap<Key, Vec<Line>>,
	orphan: FxHashMap<Key, Vec<usize>>,
	carried: FxHashSet<Key>,
	has_items: bool,
	route_races: Vec<String>,
	other_races: Vec<String>,
	dropped: FxHashSet<u32>,
	/// v1 lines of quests none of their guide's races may take (Desperate Prayer, now Dwarf-only, in
	/// the Human start guide).
	race_dropped: FxHashSet<Key>,
	dropped_items: FxHashSet<u32>,
	v1_piers: Vec<Pier>,
	/// v1's accepts and turn-ins in a shared guide of quests the route takes in a guide only its races
	/// play (Orcs and Trolls do the Barrens' Stagnant Oasis in their own guide): the other races'.
	others_dup: FxHashSet<Key>,
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
		!self.tail.get(file).copied().unwrap_or(false) && self.guide_races.get(file).is_none_or(|r| r.is_empty())
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
		if key.is_some_and(|k| self.race_dropped.contains(&k)) {
			return true;
		}
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

	/// A spawn of `e` within `yd` of `p`.
	fn spawn_within(&self, e: &Entity, p: Pt, yd: f64) -> bool {
		e.spawns.iter().any(|(&map, sp)| {
			let f = if sp.f.as_deref() == Some("l") { Frame::Live } else { Frame::Era };
			sp.pts.iter().any(|q| {
				let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
				let w = self.proj.point(map, c(0), c(1), Some(f));
				w.wx.is_finite() && w.c == p.c && js_hypot(w.wx - p.wx, w.wy - p.wy) <= yd
			})
		})
	}

	/// The classes whose trainer of the faction (`fac`: 'H' or 'A') stands within `yd` of a point.
	fn trainer_classes_near(&self, pt: Option<u32>, fac: char, yd: f64) -> FxHashSet<&'static str> {
		let mut out = FxHashSet::default();
		let Some(p) = self.w(pt) else { return out };
		for n in self.data.npcs.values() {
			let Some(cl) = n.sub_name.as_deref().and_then(|s| s.strip_suffix(" Trainer")).and_then(|c| CLASSES.iter().copied().find(|x| *x == c)) else { continue };
			if out.contains(cl) || !n.faction.as_deref().is_some_and(|f| f.contains(fac)) {
				continue;
			}
			if self.spawn_within(n, p, yd) {
				out.insert(cl);
			}
		}
		out
	}

	/// How many spawns a work line's target has (a camp of mobs; one is a named mob or a single object).
	fn work_spawns(&self, line: &str) -> usize {
		let n = |e: Option<&Entity>| e.map_or(0, |e| e.spawns.values().map(|s| s.pts.len()).sum::<usize>());
		let Some(m) = re!(r"^\s+(kill|collect|interact)\s+(\d+)\b").captures(split_comment(line).0) else { return 0 };
		let Ok(id) = m[2].parse::<u32>() else { return 0 };
		match &m[1] {
			"kill" => n(self.data.npcs.get(&id)),
			"interact" => n(self.data.objects.get(&id)),
			_ => self.data.items.get(&id).and_then(|i| i.drops.as_ref()).map_or(0, |d| d.npc.keys().map(|k| n(self.data.npcs.get(k))).sum::<usize>() + d.object.keys().map(|k| n(self.data.objects.get(k))).sum::<usize>()),
		}
	}

	/// A work line's target spawns: (map, x, y, world point), each in its own frame (Redridge's
	/// mobs are on the live map only).
	fn work_spawn_pts(&self, line: &str) -> Vec<(u32, f64, f64, Pt)> {
		let Some(m) = re!(r"^\s+(kill|collect|interact)\s+(\d+)\b").captures(split_comment(line).0) else { return Vec::new() };
		let Ok(id) = m[2].parse::<u32>() else { return Vec::new() };
		let ents: Vec<&Entity> = match &m[1] {
			"kill" => self.data.npcs.get(&id).into_iter().collect(),
			"interact" => self.data.objects.get(&id).into_iter().collect(),
			_ => self.data.items.get(&id).and_then(|i| i.drops.as_ref()).map_or(Vec::new(), |d| d.npc.keys().filter_map(|n| self.data.npcs.get(n)).chain(d.object.keys().filter_map(|o| self.data.objects.get(o))).collect()),
		};
		let mut out = Vec::new();
		for e in ents {
			for (&map, sp) in &e.spawns {
				let f = if sp.f.as_deref() == Some("l") { Frame::Live } else { Frame::Era };
				for q in &sp.pts {
					let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
					let w = self.proj.point(map, c(0), c(1), Some(f));
					if w.wx.is_finite() {
						out.push((map, c(0), c(1), Pt { c: w.c, wx: w.wx, wy: w.wy, map }));
					}
				}
			}
		}
		out
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

	/// A timed item's buy line where the route buys it, on its own: for one (`one`), and at the vendor
	/// nearest the route's point (alone in its step, `buy` would take the data's first vendor:
	/// Apothecary Dithers at the Bulwark, not Alchemist Arbington at Chillwind Camp).
	fn buy_at(&self, text: &str, pt: Option<u32>, one: bool) -> String {
		let (code, comment) = split_comment(text);
		let mut code = if one { re!(r"\s+x\d+\b").replace(code, "").into_owned() } else { code.to_string() };
		if !re!(r"\bnpc\s+\d").is_match(&code) {
			let item = re!(r"^\s+buy\s+(\d+)").captures(&code).and_then(|m| m[1].parse::<u32>().ok()).and_then(|id| self.data.items.get(&id));
			let vendors: Vec<f64> = item.and_then(|it| it.vendors.as_ref()).map(|v| v.iter().filter_map(serde_json::Value::as_f64).collect()).unwrap_or_default();
			let best = vendors.iter().filter_map(|&v| self.spawn_near(&self.targets("talk", v), pt).map(|n| (v, n.d))).min_by(|a, b| a.1.total_cmp(&b.1));
			if let Some((v, _)) = best {
				let t = code.trim_end().len();
				code = format!("{} npc {}{}", &code[..t], js_to_string(v), &code[t..]);
			}
		}
		format!("{code}{comment}")
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

	/// Where a written line is done, read in `zone`: its typed coordinates, else its quest's giver or
	/// ender.
	fn text_pt(&self, l: &str, zone: Option<&str>) -> Option<Pt> {
		let code = split_comment(l).0;
		if let Some(m) = re!(r"(?:@\s*|^\s+goto\s+)([\d.]+)\s*,\s*([\d.]+)").captures(code) {
			if re!(r"\bmap\s+\d").is_match(code) {
				return None;
			}
			let map = self.zone_ids.iter().find(|(_, z)| Some(z.as_str()) == zone)?.0;
			let p = self.proj.point(map, num(&m[1]), num(&m[2]), Some(Frame::Era));
			return p.wx.is_finite().then_some(Pt { c: p.c as i64, wx: p.wx, wy: p.wy, map });
		}
		let m = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code)?;
		let q = &self.world.quests[*self.wq.get(&m[2].parse().ok()?)?];
		self.w(if &m[1] == "accept" { q.giver } else { q.ender })
	}

	/// Where a step's first `collect` or `kill` target, or `train`, `vendor` or `talk` NPC, spawns, for a
	/// step with no quest NPC line.
	fn step_spawn_pt(&self, si: usize) -> Option<Pt> {
		self.steps[si].lines.iter().filter(|l| l.kind == Kind::Goal).find_map(|l| {
			let m = re!(r"^\s+(collect|kill|train|vendor|talk)\s+(\d+)\b").captures(split_comment(&l.text).0)?;
			// (A trainer's or vendor's id is an NPC's: the riding trainers.)
			let kind = if &m[1] == "collect" { "item" } else { "kill" };
			let recs = self.targets(kind, m[2].parse::<f64>().ok()?);
			recs.iter().find_map(|r| {
				r.spawns.iter().find_map(|(&map, sp)| {
					let f = if sp.f.as_deref() == Some("l") { Frame::Live } else { Frame::Era };
					let q = sp.pts.first()?;
					let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
					let w = self.proj.point(map, c(0), c(1), Some(f));
					w.wx.is_finite().then_some(Pt { c: w.c as i64, wx: w.wx, wy: w.wy, map })
				})
			})
		})
	}

	/// A flight path learnt or a bind written on arrival in a town goes into the town's loop, at the
	/// end of the step nearest its NPC (FlowDiag 8: Thunder Bluff's flight master after the Elder Rise
	/// hand-ins, not first on the way in). The town's loop: the steps for everyone after it in the
	/// same zone, with no travel on, within [`TOWN_YD`] of the NPC.
	fn services_at_npc(&self, mut out: Vec<String>) -> Vec<String> {
		const TOWN_YD: f64 = 350.0;
		struct S {
			start: usize,
			end: usize,
			zone: Option<String>,
		}
		let zone_re = re!(r"^\s*zone\s+(.+?)\s*$");
		let mut steps: Vec<S> = Vec::new();
		let mut zone: Option<String> = None;
		let mut i = 0;
		while i < out.len() {
			if !is_step(&out[i]) {
				if let Some(m) = zone_re.captures(&out[i]) {
					zone = Some(m[1].to_string());
				}
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
				j += 1;
			}
			let z0 = zone.clone();
			for l in &out[i + 1..j] {
				if let Some(m) = zone_re.captures(split_comment(l).0) {
					zone = Some(m[1].to_string());
				}
			}
			// (The zone a step's lines are read in: its own `zone` line, else the one before.)
			steps.push(S { start: i, end: j, zone: if zone != z0 { zone.clone() } else { z0 } });
			i = j;
		}
		let svc_re = re!(r#"^\s+(getfp|sethome)\s+"([^"]+)""#);
		let travels = |l: &str| matches!(head_ws(l), Some("fly" | "hearth")) || re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(l);
		let mut moves: Vec<(usize, usize)> = Vec::new();
		for (si, s) in steps.iter().enumerate() {
			for li in s.start + 1..s.end {
				let l = &out[li];
				let Some(m) = svc_re.captures(split_comment(l).0) else { continue };
				let npc = if &m[1] == "getfp" { self.fp_by_name(&m[2]).and_then(|f| self.w(self.world.nodes[f].pt)) } else { self.w(self.inn_pt(&m[2])) };
				let Some(npc) = npc else { continue };
				let near = |k: usize, from: usize| -> Option<f64> {
					let t = &steps[k];
					out[from..t.end].iter().filter(|x| !svc_re.is_match(x)).filter_map(|x| self.text_pt(x, t.zone.as_deref())).filter(|p| p.c == npc.c).map(|p| js_hypot(p.wx - npc.wx, p.wy - npc.wy)).reduce(f64::min)
				};
				// (Only after the travel into the town in its own step.)
				if out[li + 1..s.end].iter().any(|x| travels(x)) {
					continue;
				}
				let mut best = (si, near(si, s.start + 1).unwrap_or(f64::INFINITY));
				for k in si + 1..steps.len() {
					let t = &steps[k];
					let body = &out[t.start + 1..t.end];
					if t.zone != s.zone || body.iter().any(|x| re!(r"^\s+only\s").is_match(x) || travels(x)) {
						break;
					}
					let Some(d) = near(k, t.start + 1) else { continue };
					if d > TOWN_YD {
						break;
					}
					if d < best.1 {
						best = (k, d);
					}
				}
				if best.0 != si {
					moves.push((li, steps[best.0].end));
				}
			}
		}
		if moves.is_empty() {
			return out;
		}
		// (Each line goes after the last goal of its new step.)
		let mut ins: FxHashMap<usize, Vec<String>> = FxHashMap::default();
		for &(li, end) in &moves {
			let mut at = end;
			while at > 0 && !is_goal(&out[at - 1]) {
				at -= 1;
			}
			ins.entry(at).or_default().push(std::mem::take(&mut out[li]));
		}
		let gone: FxHashSet<usize> = moves.iter().map(|m| m.0).collect();
		let mut res = Vec::with_capacity(out.len());
		for (i, l) in out.into_iter().enumerate() {
			if !gone.contains(&i) {
				res.push(l);
			}
			if let Some(v) = ins.remove(&(i + 1)) {
				res.extend(v);
			}
		}
		res
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

	/// A boat on one continent whose landing is by `b` (an island: Feathermoon Stronghold's dock):
	/// (departure dock, landing dock) node indices.
	fn island_boat(&self, b: Pt) -> Option<(usize, usize)> {
		self.world
			.rides
			.iter()
			.filter(|r| r.kind == Some("boat"))
			.filter_map(|r| Some((r.a?, r.b?)))
			.filter_map(|(da, db)| {
				let (pa, pb) = (self.w(self.world.nodes.get(da)?.pt)?, self.w(self.world.nodes.get(db)?.pt)?);
				let d = js_hypot(pb.wx - b.wx, pb.wy - b.wy);
				(pa.c == pb.c && pb.c == b.c && d <= ZONE_STEP_YD && js_hypot(pa.wx - b.wx, pa.wy - b.wy) > d).then_some(((da, db), d))
			})
			.min_by(|x, y| x.1.total_cmp(&y.1))
			.map(|x| x.0)
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

/// The route's lines that v1 steps with none of the route's lines wait for (a class's own step goes
/// before the next step the route names, #345, also in the next guide of v1's chain): that step's
/// first named line, which the class step is written before. The hub tour leaves it where the route has it, so the class step keeps
/// its place (the Warlocks' Perrine's Chest before Brill's turn-ins, not after a hand-in taken on the
/// way; the Druids' Turak step before the Crossroads).
fn anchor_lines(inp: &Inputs) -> FxHashSet<(String, u32)> {
	let mut named: FxHashMap<String, FxHashSet<u32>> = FxHashMap::default();
	// (Each named line's first place in the route's order: a class step waits for the step's line the
	// route does first, not its first line as v1 wrote it, U5.)
	let mut at: FxHashMap<(String, u32), usize> = FxHashMap::default();
	let mut first: Option<String> = None;
	for (i, o) in inp.route.order.iter().enumerate() {
		if let Some((f, n)) = rel_of(o.from.as_deref()) {
			first.get_or_insert_with(|| f.clone());
			named.entry(f.clone()).or_default().insert(n);
			at.entry((f, n)).or_insert(i);
		}
	}
	// v1's chain from the route's first guide, then any other guide the route names.
	let mut files: Vec<String> = Vec::new();
	let mut f = first;
	while let Some(ff) = f.take().filter(|ff| !files.contains(ff)) {
		let Some(text) = inp.guides.get(&ff) else { break };
		f = next_of(text).map(|id| normalize(&format!("{id}.guide")));
		files.push(ff);
	}
	let mut rest: Vec<&String> = named.keys().filter(|k| !files.contains(k)).collect();
	rest.sort();
	files.extend(rest.into_iter().cloned());
	let none = FxHashSet::default();
	let mut out = FxHashSet::default();
	let mut waiting = false;
	// (Every step waiting is some characters' own, a class's: U5's earliest line applies.)
	let mut all_only = true;
	for f in &files {
		let Some(text) = inp.guides.get(f) else { continue };
		let ns = named.get(f).unwrap_or(&none);
		for s in parse_guide(0, text).steps {
			let goals: Vec<u32> = s.lines.iter().filter(|l| l.kind == Kind::Goal).map(|l| l.n).collect();
			let mine: Vec<u32> = goals.iter().copied().filter(|n| ns.contains(n)).collect();
			if mine.is_empty() {
				if !goals.is_empty() {
					waiting = true;
					all_only &= s.lines.iter().take_while(|l| l.kind != Kind::Goal).any(|l| is_head_ws(&l.text, "only"));
				}
			} else {
				if waiting {
					let n = if all_only { mine.iter().copied().min_by_key(|&n| at.get(&(f.clone(), n)).copied().unwrap_or(usize::MAX)).unwrap() } else { mine[0] };
					out.insert((f.clone(), n));
				}
				waiting = false;
				all_only = true;
			}
		}
	}
	out
}

pub fn apply_route(inp: &Inputs) -> Result<Output, String> {
	let data = inp.data;
	let world = inp.world;
	// With the route's own legs, the order walks each hub in one sweep (hub.rs).
	let mut log = Vec::new();
	let toured;
	let route = if inp.route_travel {
		let pinned = anchor_lines(inp);
		let (order, moved) = crate::hub::tour(inp.route.order.clone(), world, data, &|o: &Order| rel_of(o.from.as_deref()).is_some_and(|k| pinned.contains(&k)), &crate::hub::fix_pairs());
		log.extend(moved);
		toured = Route { order, ..inp.route.clone() };
		&toured
	} else {
		inp.route
	};
	let quest = |q: u32| data.quests.get(&q);
	let dedup = |xs: &[u32]| -> Vec<u32> {
		let mut seen = FxHashSet::default();
		xs.iter().copied().filter(|x| seen.insert(*x)).collect()
	};
	let mut dropped_list = dedup(route.diff.as_ref().map_or(&[][..], |d| &d.dropped));
	let added_list = dedup(route.diff.as_ref().map_or(&[][..], |d| &d.added));
	// v1's accepts of a quest closed by one the route takes (Daily Delivery once Young Crocolisk
	// Skins is in the log, #615): the game no longer offers it, so v1's lines go (the seed never had
	// it either, so the route's diff does not name it).
	{
		let taken: FxHashSet<u32> = route.order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
		for text in inp.guides.values() {
			for l in text.split('\n') {
				let Some(q) = re!(r"^\s+accept\s+(\d+)\b").captures(l).and_then(|m| m[1].parse::<u32>().ok()) else { continue };
				if taken.contains(&q) || dropped_list.contains(&q) {
					continue;
				}
				if world.quests.iter().find(|w| w.id == q).is_some_and(|w| w.excl.iter().any(|&p| u32::try_from(p).is_ok_and(|p| taken.contains(&p)))) {
					dropped_list.push(q);
				}
			}
		}
	}
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
	// The chain the addon plays (the travel repair and the engine play it): v1's `next` links from the
	// same first guide, through a guide the route has no line in on to the next one it has (Orc's own
	// Barrens guide, all of whose lines the one shared route writes in the shared Barrens guide).
	let mut played_chain: Vec<String> = Vec::new();
	let mut f = chain.first().cloned();
	while let Some(ff) = f.take() {
		if played_chain.contains(&ff) {
			break;
		}
		let Some(text) = inp.guides.get(&ff) else { break };
		if !pos_idx.contains_key(&ff) {
			// (Only on the way to a guide the route has lines in.)
			let mut ahead = next_of(text).map(|id| normalize(&format!("{id}.guide")));
			let mut hops = 0;
			while let Some(a) = ahead.as_ref().filter(|a| !pos_idx.contains_key(*a) && hops < PASS_THROUGH_GUIDES) {
				hops += 1;
				ahead = inp.guides.get(a).and_then(|t| next_of(t)).map(|id| normalize(&format!("{id}.guide")));
			}
			if ahead.is_none_or(|a| !pos_idx.contains_key(&a)) {
				break;
			}
		}
		played_chain.push(ff);
		f = next_of(text).map(|id| normalize(&format!("{id}.guide")));
	}
	for &k in &by_median {
		if !chain.contains(&pos_of[k].0) {
			chain.push(pos_of[k].0.clone());
		}
	}
	// (A shared guide the start plays in its own part, before the faction's join, comes before the join
	// guide in the chain: the Night Elves' Darkshore before Westfall, which v1 chains after it; else the
	// cut wrote Darkshore's Auberdine accepts into Westfall, the shared guide the start does not keep.)
	let join_at = route.shared.as_ref().and_then(|s| s.get("joinAt")).and_then(|v| v.as_str());
	let join_step = route.shared.as_ref().and_then(|s| s.get("joinStep")).and_then(|v| v.as_u64()).map(|v| v as usize);
	if let (Some(join_at), Some(js)) = (join_at, join_step) {
		if let Some(ji) = chain.iter().position(|f| f.rsplit('/').next() == Some(&format!("{join_at}.guide"))) {
			let mut own_part: Vec<String> = Vec::new();
			for o in &route.order[..js.min(route.order.len())] {
				if let Some((f, _)) = rel_of(o.from.as_deref()) {
					if chain.iter().position(|c| *c == f).is_some_and(|i| i > ji) && !own_part.contains(&f) {
						own_part.push(f);
					}
				}
			}
			if !own_part.is_empty() {
				chain.retain(|c| !own_part.contains(c));
				for (n, f) in own_part.into_iter().enumerate() {
					chain.insert(ji + n, f);
				}
			}
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
	// A task on v1's optional "on the way" line whose finishing line (the same goal, required) has a
	// step of its own the route names nothing else in (Rime's Wrath's small lake, thmastin): the route
	// names the finishing line, so that step is written where the route finishes the work, and the
	// optional line stays in its own step (below: `on_way`).
	{
		let keys: FxHashSet<Key> = order0.iter().filter_map(|o| o.key).collect();
		let goal = |t: &str| re!(r"\s+optional\b").replace(trim(split_comment(t).0), "").split_whitespace().take(4).collect::<Vec<_>>().join(" ");
		for o in order0.iter_mut().filter(|o| o.t == OrderT::Task) {
			let Some(k) = o.key else { continue };
			let Some(l) = step_line(&steps, &step_of, k) else { continue };
			if !re!(r"\soptional\b").is_match(split_comment(&l.text).0) {
				continue;
			}
			let want = goal(&l.text);
			let fin = steps
				.iter()
				.filter(|st| st.file == k.0)
				.flat_map(|st| st.lines.iter())
				.find(|x| x.kind == Kind::Goal && x.key().1 > k.1 && !re!(r"\soptional\b").is_match(split_comment(&x.text).0) && goal(&x.text) == want);
			let Some(fin) = fin else { continue };
			let Some(&fs) = step_of.get(&fin.key()) else { continue };
			if steps[fs].lines.iter().any(|x| x.kind == Kind::Goal && x.key() != fin.key() && keys.contains(&x.key())) {
				continue;
			}
			o.key = Some(fin.key());
		}
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
		// (Never past its own quest's work or hand-in: Williden's Journal, handed in before the
		// route's second stegodon visit.)
		let q = o.q;
		if reordered[iu + 1..j].iter().any(|x| x.q == q && x.t != OrderT::Accept) {
			i += 1;
			continue;
		}
		let o = reordered.remove(iu);
		reordered.insert(j - 1, o);
		// i-- then i++: look at index i again.
	}
	let has_items = reordered.iter().any(|o| !o.items().is_empty());
	let mut ender_keys: FxHashSet<Key> = FxHashSet::default();
	let mut together: Vec<Order> = Vec::with_capacity(reordered.len());
	for (i, o) in reordered.iter().enumerate() {
		let travel = o.items().iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip));
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
			o.items = Some(o.items().iter().filter(|x| !matches!(x.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip)).cloned().collect());
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
	// v1's buy lines of a timed item -> the route's tasks they buy for.
	let mut timed_buys: FxHashMap<Key, usize> = FxHashMap::default();
	// v1 lines a route item goes with (a bind at a shop v1 buys from).
	let mut items_at_line: FxHashMap<Key, Vec<Item>> = FxHashMap::default();
	let wide_item = |id: Option<f64>| id.and_then(|x| data.items.get(&(x as u32))).is_some_and(|it| it.npc_droppers() > WIDE_DROPPERS);
	let cx_route_travel = inp.route_travel;
	// The travel of a task the guide leaves to its turn-in (a bag hand-in, a sourceless item): carried on
	// to the route's next event, which is reached by way of it (the Undercity leg of Elixir of Agony's
	// potion on the way to Tarren Mill, else the Shamans' Brazier was the only way there).
	let mut carry: Vec<Item> = Vec::new();
	// Quests whose task the guide leaves to v1's optional bag turn-in: worked where the route works them.
	let mut bag_worked: FxHashSet<u32> = FxHashSet::default();
	let mut carried_o: Order;
	for o in &together {
		let o = if carry.is_empty() {
			o
		} else {
			carried_o = o.clone();
			let mut its = std::mem::take(&mut carry);
			its.extend(carried_o.items().iter().cloned());
			carried_o.items = Some(its);
			&carried_o
		};
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
				carry.extend(o.items().iter().cloned());
				if bag_turnin {
					bag_worked.extend(o.q);
				}
				continue;
			}
			if let (Some(r), true) = (r, bought && !work.is_match(&line)) {
				// An item that lasts a while (an Arcane Quickener, 30 minutes): v1's buy line goes where
				// the route buys it, after the work before the turn-in that spends it (lint_timed).
				let timed = rq
					.unwrap()
					.objectives()
					.any(|x| x.is("item") && x.id.is_some_and(|id| v1_gets.contains(&(id as u32)) && data.items.get(&(id as u32)).is_some_and(|it| it.duration.is_some_and(|d| d > 0.0))));
				// (Every bought item, at the route's buy: an untimed one too, where the route buys it on
				// its way, the Soothing Spices at the Crossroads, FlowDiag 6.)
				if timed || cx_route_travel {
					let ids: FxHashSet<u32> = rq.unwrap().objectives().filter(|x| x.is("item")).filter_map(|x| x.id).map(|id| id as u32).collect();
					let here = step_of.get(&r).copied();
					let buy = steps
						.iter()
						.take_while(|st| here.is_none_or(|h| st.k <= h))
						.flat_map(|st| st.lines.iter())
						.filter(|l| re!(r"^\s+buy\s+(\d+)\b").captures(&l.text).is_some_and(|m| m[1].parse().is_ok_and(|x: u32| ids.contains(&x))))
						.last()
						.map(Line::key);
					if let Some(at) = buy {
						if timed {
							*timed_buys.entry(at).or_default() += 1;
						}
						let mut x = o.clone();
						x.key = Some(at);
						route_order.push(x);
						continue;
					}
				}
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
				carry.extend(o.items().iter().filter(|x| !matches!(x.t, ItemT::Bind | ItemT::Getfp)).cloned());
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
		// (The event's items, its way there first, go with its first line: one leg for the event, not
		// one per objective line, The Hammer May Fall's two ogres written after the same flight twice, F5.)
		for (n, k) in keys.into_iter().enumerate() {
			let mut x = o.clone();
			x.from = Some(format!("guides/{}:{}", chain[k.0], k.1));
			x.key = Some(k);
			if n > 0 {
				x.items = None;
			}
			route_order.push(x);
		}
	}
	let v1key = |o: &Order| key_of(o.v1from.as_deref());

	// The route's v1 lines, first use only; dropped quests' lines out.
	let mut named: FxHashSet<Key> = FxHashSet::default();
	let mut named_list: Vec<Key> = Vec::new();
	let mut key_pt: FxHashMap<Key, u32> = FxHashMap::default();
	let mut key_lvl: FxHashMap<Key, f64> = FxHashMap::default();
	for o in &route_order {
		let Some(k) = o.key else { continue };
		if named.insert(k) {
			named_list.push(k);
		}
		if let Some(pt) = o.pt {
			key_pt.entry(k).or_insert(pt);
		}
		if let Some(l) = o.lvl {
			key_lvl.entry(k).or_insert(l);
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
	// The shared route's tail: the files whose every route step comes at or after the first step from
	// a `joinAt` guide (a file stem, in any folder: orc-troll/02-the-barrens or horde/02-the-barrens);
	// for routes before `joinAt`, the files whose every route step comes after the join (the last
	// step from the `joinAfter` guide, else from the start's own race guides).
	let tail: Vec<bool> = match &route.shared {
		Some(sh) => {
			let file_of = |o: &crate::input::Order| rel_of(o.from.as_deref()).and_then(|r| file_idx.get(&r.0).copied());
			let mut first: Vec<Option<usize>> = vec![None; chain.len()];
			for (i, o) in route.order.iter().enumerate() {
				if let Some(fi) = file_of(o) {
					first[fi].get_or_insert(i);
				}
			}
			if let Some(j) = sh.get("joinAt").and_then(serde_json::Value::as_str) {
				let stem = format!("{j}.guide");
				let is_join = |fi: usize| chain[fi] == stem || chain[fi].ends_with(&format!("/{stem}"));
				let start = route.order.iter().position(|o| file_of(o).is_some_and(is_join));
				(0..chain.len()).map(|fi| guide_races[fi].is_empty() && matches!((start, first[fi]), (Some(s), Some(f)) if f >= s)).collect()
			} else {
				let join = sh.get("joinAfter").and_then(serde_json::Value::as_str).map(|j| format!("{j}.guide"));
				let at_join = |fi: usize| match &join {
					Some(j) if chain.iter().any(|f| f.ends_with(j.as_str())) => chain[fi].ends_with(j.as_str()),
					_ => !guide_races[fi].is_empty(),
				};
				let last = route.order.iter().enumerate().filter(|(_, o)| file_of(o).is_some_and(at_join)).map(|(i, _)| i).max();
				(0..chain.len()).map(|fi| guide_races[fi].is_empty() && matches!((last, first[fi]), (Some(l), Some(f)) if f > l)).collect()
			}
		}
		None => vec![false; chain.len()],
	};
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
	let faction = route.faction.as_deref().and_then(forge_core::Faction::parse);
	let race_bit = |name: &str| -> Option<u64> {
		let f = faction?;
		if name.eq_ignore_ascii_case("skyborne") {
			return Some(f.skyborne_bit());
		}
		forge_core::RACES.iter().find(|r| r.file.eq_ignore_ascii_case(name) || r.key.eq_ignore_ascii_case(name)).map(|r| r.bit(f)).filter(|b| *b != 0)
	};
	let mut race_dropped: FxHashSet<Key> = FxHashSet::default();
	for st in &steps {
		let Some(races) = guide_races.get(st.file as usize).filter(|r| !r.is_empty()) else { continue };
		let bits: Option<Vec<u64>> = races.iter().map(|r| race_bit(r)).collect();
		let Some(bits) = bits else { continue };
		for l in &st.lines {
			let Some(q) = quest_of(&l.text) else { continue };
			let mask = quest(q).and_then(|d| d.races).filter(|m| *m > 0.0 && m.fract() == 0.0).map(|m| m as u64);
			if mask.is_some_and(|m| bits.iter().all(|b| m & b == 0)) {
				race_dropped.insert(l.key());
			}
		}
	}
	let mut cx = Ctx {
		race_dropped,
		v1_rank,
		route_travel: inp.route_travel,
		walks: inp.walks,
		world,
		data,
		proj: Projector::new(inp.frames),
		era: inp.frames.era.keys().filter_map(|k| k.parse().ok()).collect(),
		area_at: inp.area_at,
		guide_races,
		tail,
		steps,
		step_of,
		named,
		key_pt,
		key_lvl,
		level_at: if inp.level_fraction { level_targets(&route_order, data) } else { FxHashMap::default() },
		ender_keys,
		items_at_line,
		buy_each: timed_buys.iter().filter(|(_, &n)| n > 1).map(|(&k, _)| k).collect(),
		timed_buy: timed_buys.keys().copied().collect(),
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
		others_dup: FxHashSet::default(),
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
	// An objective line the chain writes twice is written once, when the two are for some of the same
	// characters: the Paladins' own Shadowvale elixir bottles stay beside everyone else's (95314).
	let obj_sig = |text: &str| -> Option<String> { re!(r"^\s+(kill|collect|interact|use|talk)\s+(\d+)\b.*?\bquest\s+(\d+\.\d+)").captures(text).map(|m| format!("{} {} {}", &m[1], &m[2], &m[3])) };
	// (Who a line is for: its own `only`, else its step's; None: everyone.)
	let audience = |s: &Step, l: &Line| -> Option<Vec<String>> {
		let list = line_only(&l.text).map(str::to_string).or_else(|| s.lines.iter().take_while(|x| x.kind != Kind::Goal).find(|x| is_head_ws(&x.text, "only")).map(|x| trim(&re!(r"^\s+only\s+").replace(split_comment(&x.text).0, "")).to_string()))?;
		Some(list.split(',').map(|x| trim(x).to_string()).collect())
	};
	// (A class list and a race list share characters: Human Paladins are in both, U1.)
	let overlap = |a: &Option<Vec<String>>, b: &Option<Vec<String>>| match (a, b) {
		(Some(a), Some(b)) => {
			let classes = |v: &Vec<String>| v.iter().all(|x| CLASSES.contains(&x.trim_start_matches('!')));
			a.iter().any(|x| b.contains(x)) || classes(a) != classes(b)
		}
		_ => true,
	};
	let mut sigs: FxHashMap<String, Vec<(usize, Option<Vec<String>>)>> = FxHashMap::default();
	for s in &cx.steps {
		for l in &s.lines {
			if cx.named.contains(&l.key()) {
				if let Some(g) = obj_sig(&l.text) {
					sigs.entry(g).or_default().push((s.file, audience(s, l)));
				}
			}
		}
	}
	let mut twice: FxHashSet<Key> = FxHashSet::default();
	// An accept or turn-in the route names on another line is written once, at the route's place.
	let mut event_file: FxHashMap<String, Key> = FxHashMap::default();
	for o in &route_order {
		let Some(k) = o.key else { continue };
		let t = match o.t {
			OrderT::Accept => "accept",
			OrderT::Turnin => "turnin",
			_ => continue,
		};
		event_file.entry(format!("{t} {}", opt_num(o.q))).or_insert(k);
	}
	let mut others_dup: FxHashSet<Key> = FxHashSet::default();
	let mut others_q: FxHashSet<(usize, u32)> = FxHashSet::default();
	for s in &cx.steps {
		for l in &s.lines {
			if l.kind != Kind::Goal || cx.named.contains(&l.key()) {
				continue;
			}
			let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(&l.text) else { continue };
			if let Some(&k) = event_file.get(&format!("{} {}", &m[1], &m[2])) {
				// (Unless the route's line is for only some characters and this one for none of them or
				// for everyone: the Druids' own Return to Nessa hand-in, #402; the Paladins' own Shadowvale
				// turn-in beside everyone else's, 95314. Who: the line's `only`, else its step's.)
				let theirs = cx.step_of.get(&k).and_then(|&i| cx.steps[i].lines.iter().find(|x| x.key() == k).and_then(|x| audience(&cx.steps[i], x)));
				let apart = match (&theirs, audience(s, l)) {
					(Some(_), None) => true,
					(a, b) => !overlap(a, &b),
				};
				if cx.covers(k.0, s.file) && !apart {
					twice.insert(l.key());
				} else if !apart && cx.shared(s.file) && !cx.covers(k.0, s.file) {
					others_dup.insert(l.key());
					if let Ok(q) = m[2].parse::<u32>() {
						others_q.insert((s.file, q));
					}
				}
			}
		}
	}
	// v1's accept or turn-in of a quest the route takes by its own (inserted) event, and the collect of
	// the item that starts it when the route's accept writes that collect itself: the route's lines
	// stand (the Gold Pickup Schedule's accept twice, and v1's hand-in before it, pack error 123). So do
	// its work lines when the route works it only by its own events and the world knows them (v1's
	// collect left before the route's later accept, Zephras Isle 93736).
	let ins_ev: FxHashSet<(OrderT, u32)> = route_order.iter().filter(|o| o.key.is_none() && matches!(o.t, OrderT::Accept | OrderT::Turnin)).filter_map(|o| Some((o.t, o.q?))).collect();
	let keyed_task: FxHashSet<u32> = route_order.iter().filter(|o| o.key.is_some() && o.t == OrderT::Task).filter_map(|o| o.q).collect();
	let ins_task: FxHashSet<u32> = route_order
		.iter()
		.filter(|o| o.key.is_none() && o.t == OrderT::Task)
		.filter_map(|o| o.q)
		.filter(|q| !keyed_task.contains(q) && cx.wq.get(q).is_some_and(|&i| !world.quests[i].objs.is_empty()))
		.collect();
	let drop_start = |q: u32| quest(q).is_some_and(|r| !r.start_items().is_empty() && r.start.as_ref().is_some_and(|s| s.npc.is_empty() && s.object.is_empty()));
	let start_items: FxHashSet<u32> = ins_ev.iter().filter(|(t, q)| *t == OrderT::Accept && drop_start(*q)).flat_map(|(_, q)| quest(*q).map_or(&[][..], |r| r.start_items()).iter().copied()).collect();
	for s in &cx.steps {
		for l in &s.lines {
			if l.kind != Kind::Goal || cx.named.contains(&l.key()) {
				continue;
			}
			let code = split_comment(&l.text).0;
			let ev = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code).and_then(|m| Some((if &m[1] == "accept" { OrderT::Accept } else { OrderT::Turnin }, m[2].parse::<u32>().ok()?)));
			let start_collect = re!(r"^\s+collect\s+(\d+)\b").captures(code).filter(|_| !re!(r"\bquest\s+\d").is_match(code)).and_then(|m| m[1].parse::<u32>().ok()).is_some_and(|it| start_items.contains(&it));
			let ins_work = re!(r"^\s+(kill|collect|interact|use|talk)\s+\d+.*?\bquest\s+(\d+)\.").captures(code).and_then(|m| m[2].parse::<u32>().ok()).is_some_and(|q| ins_task.contains(&q));
			if ev.is_some_and(|e| ins_ev.contains(&e)) || start_collect || ins_work {
				if cx.shared(s.file) && !cx.other_races.is_empty() {
					others_dup.insert(l.key());
				} else {
					twice.insert(l.key());
				}
			}
		}
	}
	// (Their work lines in that guide too: the quest is not held there.)
	for s in &cx.steps {
		for l in &s.lines {
			if l.kind == Kind::Goal && !cx.named.contains(&l.key()) && quest_of(&l.text).is_some_and(|q| others_q.contains(&(s.file, q))) {
				others_dup.insert(l.key());
			}
		}
	}
	cx.others_dup = others_dup;

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
			let who = audience(s, l);
			if sigs.get(&g).is_some_and(|fs| fs.iter().any(|(f, a)| cx.covers(*f, s.file) && overlap(a, &who))) {
				twice.insert(l.key());
			} else {
				sigs.entry(g).or_default().push((s.file, who));
			}
		}
	}
	// A goal the route works at v1's optional "on the way" line, whose required line v1 wrote later
	// is written once, at the route's line (above): there it is required, so the hand-in never waits
	// on goals no step holds (Mazzranache's four parts, 766, all optional at the route's work and
	// the finishing step gone).
	let mut required: FxHashMap<String, (usize, String)> = FxHashMap::default();
	for l in cx.steps.iter().flat_map(|s| s.lines.iter()) {
		let (code, rest) = split_comment(&l.text);
		if twice.contains(&l.key()) && !re!(r"\soptional\b").is_match(code) {
			if let Some(g) = obj_sig(&l.text) {
				required.entry(g).or_insert_with(|| (code.len(), rest.to_string()));
			}
		}
	}
	for s in cx.steps.iter_mut() {
		for l in s.lines.iter_mut() {
			let (code, rest) = split_comment(&l.text);
			if !cx.named.contains(&l.key()) || !re!(r"\soptional\b").is_match(code) {
				continue;
			}
			if let Some((width, comment)) = obj_sig(&l.text).and_then(|g| required.get(&g)) {
				let code = re!(r"\s+optional\b").replace(code, "").into_owned();
				// (v1's comment on the required line, "-- Prairie Wolf Heart", when the route's has none.)
				l.text = if rest.is_empty() && !comment.is_empty() { format!("{:<w$}{comment}", trim_end(&code), w = *width) } else { format!("{code}{rest}") };
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
		let mut extra_anchor: Option<Key> = None;
		// Lines done at an NPC (an accept, a hand-in, a training): who they are for, not where.
		let npc_lines = |ls: &[Line]| ls.iter().all(|l| ["accept", "turnin", "train"].iter().any(|w| is_head_ws(&l.text, w)));
		// The named line before the pending ones in v1's order.
		let mut prev_named: Option<Key> = None;
		let at = |k: &Key| key_at.get(k).copied();
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
			// v1's required line of a goal the route names by v1's optional "on the way" line before it
			// (counted on the walk past, finished here: Rime's Wrath's elementals, thmastin): it stays
			// in its own later step.
			let finisher = q.is_some_and(|q| {
				let goal = |t: &str| re!(r"\s+optional\b").replace(&core(t), "").into_owned();
				!re!(r"\soptional\b").is_match(split_comment(&l.text).0)
					&& work_key
						.get(&q)
						.and_then(|&wk| cx.step_line(wk))
						.is_some_and(|wl| wl.key().0 == key.0 && wl.key().1 < key.1 && re!(r"\soptional\b").is_match(split_comment(&wl.text).0) && goal(&wl.text) == goal(&l.text))
			});
			// v1's optional "on the way" line of work the route finishes in a later step (above): it
			// stays in its step.
			let on_way = q.is_some_and(|q| {
				re!(r"\soptional\b").is_match(split_comment(&l.text).0)
					&& work_key.get(&q).is_some_and(|wk| cx.step_of.get(wk) != Some(&si) && key_at.get(wk).is_some_and(|&w| named_in.iter().any(|x| key_at.get(&x.key()).is_some_and(|&v| v < w))))
			});
			// v1's unnamed collect of an item a named kill of its own step drops (the Warlocks' Rattlecage
			// skulls with Rattling the Rattlecages, #345): with that kill, wherever the route works it,
			// when the route takes its quest before then.
			let dropper_kill = (!cx.named.contains(&key))
				.then(|| re!(r"^\s+collect\s+(\d+)\b.*\bquest\s+\d").captures(split_comment(&l.text).0).and_then(|m| m[1].parse::<u32>().ok()))
				.flatten()
				.and_then(|item| cx.data.items.get(&item))
				.and_then(|it| it.drops.as_ref())
				.and_then(|d| {
					named_in.iter().find(|x| re!(r"^\s+kill\s+(\d+)\b").captures(split_comment(&x.text).0).and_then(|m| m[1].parse::<u32>().ok()).is_some_and(|npc| d.npc.contains_key(&npc)))
				})
				.map(|x| x.key())
				.filter(|kk| q.and_then(|q| accept_at.get(&q)).is_none_or(|&a| key_at.get(kk).is_some_and(|&k| a < k)));
			if let Some(kk) = dropper_kill {
				carried.insert(key);
				put_at(&mut after, &mut anchor_of, kk, vec![l.clone()], false);
				continue;
			}
			if let Some(q) = q.filter(|_| !stays && !reminder && !finisher && !on_way && re!(r"\bquest\s+\d").is_match(&l.text) && dst.is_some_and(|d| cx.covers(d.0, s.file))) {
				carried.insert(key);
				// The same goal as the work line it would follow: once is enough.
				// (For the same characters only: the Paladins' own line beside everyone's stays, U1.)
				let wl = work_key.get(&q).and_then(|&wk| Some((cx.step_line(wk)?, &cx.steps[*cx.step_of.get(&wk)?])));
				if wl.is_some_and(|(wl, ws)| core(&wl.text) == core(&l.text) && audience(ws, wl) == audience(s, l)) {
					continue;
				}
				if let Some(&wk) = work_key.get(&q) {
					put_at(&mut after, &mut anchor_of, wk, vec![l.clone()], false);
				} else {
					put_at(&mut before, &mut anchor_of, turn_key[&q], vec![l.clone()], false);
				}
				continue;
			}
			// v1's accept or turn-in for other characters than the route's line of the same event (the
			// Paladins' own 95314 hand-in to Carolai Anise, beside everyone else's): right after that
			// line, `only` its step's audience.
			let twin = (!cx.named.contains(&key)).then(|| re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(split_comment(&l.text).0)).flatten().and_then(|m| event_file.get(&format!("{} {}", &m[1], &m[2])).copied());
			// (Not a line of a class's own run of steps, which takes its own way there: the Druids'
			// Return to Nessa after their Moonglade trip, N1.)
			let step_only = |st: &Step| st.lines.iter().take_while(|x| x.kind != Kind::Goal).find(|x| is_head_ws(&x.text, "only")).map(|x| trim(split_comment(&x.text).0).to_string());
			let class_run = s.k > 0 && cx.steps[s.k - 1].file == s.file && step_only(s).is_some() && step_only(&cx.steps[s.k - 1]) == step_only(s);
			if let Some(k) = twin.filter(|&k| k != key && cx.covers(k.0, s.file) && !class_run) {
				let theirs = cx.step_of.get(&k).and_then(|&i| cx.steps[i].lines.iter().find(|x| x.key() == k).and_then(|x| audience(&cx.steps[i], x)));
				let mine = audience(s, l);
				if theirs.is_some() && mine.is_some() && !overlap(&theirs, &mine) {
					carried.insert(key);
					let mut line = l.clone();
					if line_only(&line.text).is_none() {
						let (code, rest) = split_comment(&l.text);
						line.text = format!("{} only {}{}", code.trim_end(), mine.unwrap().join(","), rest);
					}
					put_at(&mut after, &mut anchor_of, k, vec![line], false);
					continue;
				}
			}
			if named_in.is_empty() {
				continue;
			}
			// The reminder goes with the work line before it in its step (the Raptor Horns with
			// Vrang's hides, #274), when the route names one.
			if reminder || on_way {
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
				// An item that drops nearer another piece's work goes with that piece (Croaky's Head:
				// Croaky roams the murloc shore, with the Torn Murloc Fins, #221); the optional lines
				// right after it go with it.
				let item = re!(r"^\s+collect\s+(\d+)\b").captures(split_comment(&l.text).0).and_then(|m| m[1].parse::<f64>().ok());
				let near = |x: &Line| item.and_then(|id| cx.spawn_near(&cx.targets("item", id), cx.key_pt.get(&x.key()).copied())).map_or(f64::INFINITY, |n| n.d);
				// (The item that starts a quest the route takes in this step: right before that accept.)
				let starts = item.and_then(|id| {
					named_in
						.iter()
						.find(|x| re!(r"^\s+accept\s+(\d+)").captures(&x.text).and_then(|m| m[1].parse::<u32>().ok()).and_then(quest).is_some_and(|r| r.start_items().contains(&(id as u32))))
				});
				if let Some(acc) = starts {
					put_at(&mut before, &mut anchor_of, acc.key(), vec![l.clone()], false);
					extra_anchor = None;
					continue;
				}
				let anchor = match item {
					Some(_) => named_in.iter().filter(|x| near(x).is_finite()).min_by(|a, b| near(a).total_cmp(&near(b))).map_or(first_named.key(), Line::key),
					None => extra_anchor.unwrap_or(first_named.key()),
				};
				extra_anchor = Some(anchor);
				put_at(&mut after, &mut anchor_of, anchor, vec![l.clone()], false);
				continue;
			}
			extra_anchor = None;
			if cx.named.contains(&key) {
				if !pend.is_empty() {
					// v1's NPC lines between two named lines go with the one the route does later: the
					// class scrolls and training between Sarvis' Rattling the Rattlecages and Elreth's The
					// Damned stay with Sarvis' second visit when the route takes The Damned on the first.
					match prev_named.filter(|p| npc_lines(&pend) && matches!((at(&key), at(p)), (Some(k), Some(p)) if k < p)) {
						Some(p) => put_at(&mut after, &mut anchor_of, p, std::mem::take(&mut pend), false),
						None => put_at(&mut before, &mut anchor_of, key, std::mem::take(&mut pend), true),
					}
				}
				pend.clear();
				prev_named = Some(key);
			} else {
				pend.push(l.clone());
			}
		}
		let drop_all = s.lines.iter().any(|l| l.kind == Kind::Goal) && !goals.iter().any(|l| !carried.contains(&l.key()));
		let twice_keys: Vec<Key> = s.lines.iter().map(|l| l.key()).filter(|k| twice.contains(k)).collect();
		carried.extend(twice_keys);
		// Gotos after a step's last goal lead to the next step's place. (Also after a vendor line: the
		// boat goto closing Auberdine's last visit does not come along with Expanding Horizons, which
		// the route takes on the first, A8.)
		let mut trail = None;
		if !pend.is_empty() && !named_in.is_empty() {
			let n_goto = pend.iter().rev().take_while(|l| is_head_ws(&l.text, "goto")).count();
			let gotos = pend.split_off(pend.len() - n_goto);
			if !pend.is_empty() {
				put_at(&mut after, &mut anchor_of, named_in.last().unwrap().key(), pend, false);
			}
			if !gotos.is_empty() {
				trail = Some(gotos);
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
		let last_at = s.named.iter().filter_map(|x| key_at.get(&x.key()).copied()).max();
		match cx.steps.get(s.k + 1) {
			// (Kept in its own step when the route goes on straight to that step: v1's walk to Frostmane
			// Hold stays with the bears counted on the way, thmastin.)
			Some(t) if t.file == s.file && !t.named.is_empty() && !(last_at.is_some() && t.named.iter().filter_map(|x| key_at.get(&x.key()).copied()).min() == last_at.map(|a| a + 1)) => {
				put_at(&mut before, &mut anchor_of, t.named[0].key(), trail, true)
			}
			// (After the step's line the route does last: v1's boat goto stays the step's end when the
			// route splits the step, A15.)
			_ => {
				let last = s.named.iter().max_by_key(|x| key_at.get(&x.key()).copied().unwrap_or(0)).unwrap().key();
				put_at(&mut after, &mut anchor_of, last, trail, false)
			}
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
	// Steps with no named line: before the next named step's line the route does first (U5: not its
	// first line as v1 wrote it; read in the route's order before the hub tour, as anchor_lines does,
	// which the tour keeps last in its visit).
	let route_at: FxHashMap<Key, usize> = {
		let mut m = FxHashMap::default();
		for (i, o) in inp.route.order.iter().enumerate() {
			if let Some(k) = key_of(o.from.as_deref()) {
				m.entry(k).or_insert(i);
			}
		}
		m
	};
	// (Items the route buys at a line of its own: v1's other step that only buys them is a trip for
	// nothing, the Ratchet spice step closing the Arathi guide, FlowDiag 6.)
	let buy_re = re!(r"^\s+buy\s+(\d+)\b");
	let mut named_buys: FxHashSet<u32> = cx.named.iter().filter_map(|&k| cx.step_line(k)).filter_map(|l| buy_re.captures(&l.text).and_then(|m| m[1].parse().ok())).collect();
	// (And the items a route task's quest asks for that its step buys: the task keyed to the hand-in.)
	for o in route_order.iter().filter(|o| o.t == OrderT::Task) {
		let (Some(k), Some(r)) = (o.key.or_else(|| key_of(o.from.as_deref())), o.q.and_then(quest)) else { continue };
		let Some(&s) = cx.step_of.get(&k) else { continue };
		let items: Vec<u32> = r.objectives().filter(|x| x.is("item")).filter_map(|x| x.id.map(|i| i as u32)).collect();
		named_buys.extend(cx.steps[s].lines.iter().filter_map(|l| buy_re.captures(&l.text).and_then(|m| m[1].parse::<u32>().ok())).filter(|i| items.contains(i)));
	}
	let mut waiting: Vec<usize> = Vec::new();
	for si in 0..cx.steps.len() {
		if cx.steps[si].named.is_empty() {
			let goals: Vec<&Line> = cx.steps[si].lines.iter().filter(|l| l.kind == Kind::Goal && !is_head_ws(&l.text, "note")).collect();
			// (Its travel and its bind or flight path are only the way to the buy.)
			let work: Vec<&&Line> = goals.iter().filter(|l| !matches!(head_ws(&l.text), Some("fly" | "goto" | "hearth" | "sethome" | "getfp"))).collect();
			let bought = !work.is_empty() && work.iter().all(|l| buy_re.captures(&l.text).and_then(|m| m[1].parse::<u32>().ok()).is_some_and(|i| named_buys.contains(&i)));
			// (Nor v1's step that only learns a flight path or binds, when the route writes its own:
			// everyone's boat from Booty Bay to Ratchet and back for Ratchet's flight path, FlowDiag 9.
			// A guide's last step stays: it is where the guide leaves everyone.)
			let last_of_guide = si + 1 >= cx.steps.len() || cx.steps[si + 1].file != cx.steps[si].file;
			let service_only = !last_of_guide && inp.route_travel && !goals.is_empty() && goals.iter().all(|l| matches!(head_ws(&l.text), Some("getfp" | "sethome")));
			let keep = !bought && !service_only && (!cx.steps[si].drop_all || way_step(&mut cx.steps[si])) && !left_out_title(&cx, &cx.steps[si]);
			if keep {
				waiting.push(si);
			}
			continue;
		}
		if !waiting.is_empty() {
			let all_only = waiting.iter().all(|&os| cx.steps[os].lines.iter().take_while(|l| l.kind != Kind::Goal).any(|l| is_head_ws(&l.text, "only")));
			let key = if !all_only { cx.steps[si].named[0].key() } else { cx.steps[si].named.iter().map(|l| l.key()).min_by_key(|k| route_at.get(k).copied().unwrap_or(usize::MAX)).unwrap() };
			for &os in &waiting {
				for l in &cx.steps[os].lines {
					anchor_of.insert(l.key(), key);
				}
			}
			cx.orphan.insert(key, std::mem::take(&mut waiting));
		}
	}
	let tail = waiting;

	let mut order = post::item_accepts(post::timed_order(route_order, &cx.steps, &cx.named, &anchor_of, data, world), &cx.steps, &cx.named, &anchor_of, data);

	// ---- pieces in the route's order ----
	let mut pieces: Vec<Piece> = Vec::new();
	let mut bind_at_line: Vec<(Key, Item)> = Vec::new();
	let mut seen: FxHashSet<Key> = FxHashSet::default();
	// v1's buy lines written at the route's buy elsewhere (not again in their step).
	let mut moved_buys: FxHashSet<Key> = FxHashSet::default();
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
		// Riding training the planner places where v1 has no line for it: the trainer by name.
		if o.t == OrderT::Ride {
			let n = o.npc?;
			let name = data.npcs.get(&n).and_then(|x| x.name.clone()).filter(|x| !x.is_empty());
			let line = match name {
				Some(nm) => format!("  train {n}                          -- {nm}: riding"),
				None => format!("  train {n}"),
			};
			return Some(Ins { title: "Riding trainer".into(), lines: vec![line], map: cx.map_of_pt(o.pt) });
		}
		if matches!(o.t, OrderT::Accept | OrderT::Turnin) {
			let st = rec.and_then(|r| if o.t == OrderT::Accept { r.start.as_ref() } else { r.end.as_ref() });
			let who: Vec<&Entity> = st.map_or(Vec::new(), |st| st.npc.iter().filter_map(|n| data.npcs.get(n)).chain(st.object.iter().filter_map(|x| data.objects.get(x))).collect());
			let near = cx.spawn_near(&who, o.pt);
			let npc_name = st.and_then(|st| st.npc.first()).and_then(|n| data.npcs.get(n)).and_then(|n| n.name.clone()).filter(|n| !n.is_empty());
			let t = if o.t == OrderT::Accept { "accept" } else { "turnin" };
			// A quest an item starts, the item a drop (Message in a Bottle: the note in a bottle on the
			// shore, one in four): the item's collect first, and the quest optional, never a wait for it.
			let drop_start = rec.is_some_and(|r| !r.start_items().is_empty() && r.start.as_ref().is_some_and(|s| s.npc.is_empty() && s.object.is_empty()));
			if drop_start {
				let r = rec.unwrap();
				let mut lines = Vec::new();
				let mut map = None;
				if o.t == OrderT::Accept {
					for &it in r.start_items() {
						let near = cx.spawn_near(&cx.targets("item", it as f64), o.pt);
						let c = near.as_ref().map_or_else(|| cx.coords_of(o.pt), |n| n.at.clone());
						map = map.or(near.map(|n| n.map));
						lines.push(format!("  collect {it} x1 optional{c}"));
					}
				}
				// (Its hand-in only for a player who found the item and holds the quest: never required.)
				if o.t == OrderT::Turnin {
					lines.push(format!("  when onquest {qs}"));
				}
				lines.push(if o.t == OrderT::Accept { format!("  {t} {qs} optional") } else { format!("  {t} {qs}") });
				let item_name = r.start_items().first().and_then(|i| data.items.get(i)).and_then(|i| i.name.clone()).filter(|n| !n.is_empty());
				let title = if o.t == OrderT::Accept { item_name.or(rec_title) } else { npc_name.or(rec_title) };
				return Some(Ins { title: title.unwrap_or_else(|| format!("Quest {qs}")), lines, map: map.or_else(|| near.map_or(cx.map_of_pt(o.pt), |n| Some(n.map))) });
			}
			return Some(Ins { title: npc_name.or(rec_title).unwrap_or_else(|| format!("Quest {qs}")), lines: vec![format!("  {t} {qs}")], map: near.map_or(cx.map_of_pt(o.pt), |n| Some(n.map)) });
		}
		if o.t == OrderT::Train {
			return Some(Ins { title: "Class trainer".into(), lines: vec!["  train class".into()], map: cx.map_of_pt(o.pt) });
		}
		if o.t != OrderT::Task {
			return None;
		}
		let objs: Vec<&crate::input::WObj> = wobjs.iter().filter(|x| x.task == o.task).collect();
		// (No objective of that task: those with no task of their own, not every objective of the quest. A
		// task index the world has none for, the route fixes' Runecloth before the Arcane Quickener, writes
		// nothing: its objective is v1's line with the others, and the quickener's comes after its buy.)
		let use_: Vec<&crate::input::WObj> = if objs.is_empty() { wobjs.iter().filter(|x| x.task.is_none()).collect() } else { objs };
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
	// v1's own training steps the route did not place (orphans of the events just after a route
	// training, at about its level): written with it, a single trainer visit. v1 writes them a few
	// steps on (Orgrimmar and the Druids' Thunder Bluff after Regthar's first hand-in), a second trip.
	let trains = |s: usize| cx.steps[s].lines.iter().any(|l| re!(r"^\s+train\s+class\b").is_match(&l.text));
	// A v1 step that only travels to a trainer and trains, left over by a route that plans its own
	// training: a trip the route does not make (Orgrimmar at 23 after Regthar). It goes.
	let route_trains = cx.route_travel && order.iter().any(|o| o.t == OrderT::Train);
	let just_training = |s: usize| cx.steps[s].lines.iter().filter(|l| l.kind == Kind::Goal).all(|l| re!(r"^\s+(train\s+class|fly|goto|hearth|getfp)\b").is_match(&l.text));
	let spare_training = |s: usize| route_trains && trains(s) && just_training(s);
	// The classes a step's training lines are for (None: everyone; a step for some races only covers
	// no class for all).
	let train_classes = |s: usize| -> Option<FxHashSet<String>> {
		let st = &cx.steps[s];
		let step_only = st.lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(split_comment(&l.text).0, "")).to_string());
		let mut out: FxHashSet<String> = FxHashSet::default();
		for l in st.lines.iter().filter(|l| re!(r"^\s+train\s+class\b").is_match(&l.text)) {
			let Some(list) = line_only(&l.text).map(str::to_string).or_else(|| step_only.clone()) else { return None };
			if only_classes(Some(&list)) && Ctx::only_races(Some(&list)).is_none() {
				out.extend(list.split(',').map(|c| trim(c).to_string()));
			}
		}
		Some(out)
	};
	// A step's continent: its first placed line's, else its zone's.
	let step_cont = |s: usize| -> Option<i64> {
		let st = &cx.steps[s];
		if let Some(p) = cx.w(st.lines.iter().find_map(|l| cx.line_pt(l))) {
			return Some(p.c as i64);
		}
		let map = cx.zone_ids.iter().find(|(_, n)| Some(n) == st.zone.as_ref()).map(|(k, _)| *k)?;
		let p = cx.proj.point(map, 50.0, 50.0, Some(Frame::Era));
		p.wx.is_finite().then_some(p.c as i64)
	};
	// -> (the steps written with the training, the ones it leaves nothing to: a second Thunder Bluff
	// step for classes another pulled step trains already). Only steps on the trainer's continent
	// (not the Undead Paladins' Brill trainer at an Orgrimmar training).
	// (The v1 training steps right after one the route moves or pulls, the Druids' Thunder Bluff after
	// Orgrimmar, come with it even when v1's order reaches them later.)
	let orphan_set: FxHashSet<usize> = cx.orphan.values().flatten().copied().chain(tail.iter().copied()).collect();
	let train_orphans = |order: &[Order], from: usize, lvl: Option<f64>, at: Option<u32>, seed: Option<usize>, pulled: &FxHashSet<usize>| -> (Vec<usize>, Vec<usize>) {
		const SAME_TRAINING_LVL: f64 = 1.5;
		let at_c = cx.w(at).map(|p| p.c as i64);
		let (mut out, mut dup): (Vec<usize>, Vec<usize>) = (Vec::new(), Vec::new());
		let mut covered: Option<FxHashSet<String>> = Some(FxHashSet::default());
		let mut consider = |os: usize, out: &mut Vec<usize>, dup: &mut Vec<usize>| -> bool {
			if !trains(os) || pulled.contains(&os) || out.contains(&os) || dup.contains(&os) {
				return false;
			}
			if at_c.is_some_and(|a| step_cont(os).is_some_and(|c| c != a)) {
				return false;
			}
			// (A step with other work than training comes only from the trainer's own town: the Druids'
			// Heeding the Call from Kal in Dolanaar stays at Dolanaar, not with a Darnassus training.)
			let at_z = cx.w(at).and_then(|p| cx.zone_name(Some(p.map)));
			if !just_training(os) && at_z.is_some() && cx.steps[os].zone != at_z {
				return false;
			}
			let cls = train_classes(os);
			let known = match (&covered, &cls) {
				(None, _) => true,
				(Some(c), Some(s)) => !s.is_empty() && s.is_subset(c),
				(Some(_), None) => false,
			};
			if known && just_training(os) {
				dup.push(os);
				return true;
			}
			covered = match (covered.take(), cls) {
				(Some(mut c), Some(s)) => {
					c.extend(s);
					Some(c)
				}
				_ => None,
			};
			out.push(os);
			true
		};
		for o2 in &order[from..] {
			if o2.t == OrderT::Train || o2.lvl.zip(lvl).is_some_and(|(b, a)| b - a > SAME_TRAINING_LVL) {
				break;
			}
			let Some(k) = o2.key else { continue };
			for &os in cx.orphan.get(&k).into_iter().flatten() {
				consider(os, &mut out, &mut dup);
			}
		}
		let mut anchors: Vec<usize> = seed.into_iter().chain(out.iter().copied()).collect();
		while let Some(a) = anchors.pop() {
			let mut n = a + 1;
			while n < cx.steps.len() && cx.steps[n].file == cx.steps[a].file && orphan_set.contains(&n) && trains(n) {
				if consider(n, &mut out, &mut dup) && out.last() == Some(&n) {
					anchors.push(n);
				}
				n += 1;
			}
		}
		(out, dup)
	};
	let mut pulled: FxHashSet<usize> = FxHashSet::default();
	// A zone's continent, and the zone a piece is written in.
	let zone_c = |z: &Option<String>| -> Option<i64> {
		let map = cx.zone_ids.iter().find(|(_, n)| Some(n) == z.as_ref()).map(|(k, _)| *k)?;
		let p = cx.proj.point(map, 50.0, 50.0, Some(Frame::Era));
		p.wx.is_finite().then_some(p.c as i64)
	};
	let piece_zone = |p: &Piece| -> Option<String> {
		match &p.kind {
			PieceKind::Step { step, .. } => cx.steps[*step].zone.clone(),
			PieceKind::Orphan(s) => cx.steps[*s].zone.clone(),
			PieceKind::Ins { pt, map, lines, .. } if !lines.is_empty() => cx.zone_name(map.or_else(|| cx.w(*pt).map(|w| w.map))),
			PieceKind::Ins { .. } => None,
		}
	};
	// v1's training steps a route training stop defers to (below): theirs, kept.
	let mut keep: FxHashSet<usize> = FxHashSet::default();
	// v1 steps waiting for a later pass of the route through their zone: order index -> steps, written
	// right after that event's piece.
	let mut deferred: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
	// Classes whose training waits for the route's pass by their trainer: order index -> classes.
	let mut deferred_train: BTreeMap<usize, Vec<&str>> = BTreeMap::new();
	let mut oi = 0;
	while oi < order.len() {
		if let Some(v) = oi.checked_sub(1).and_then(|p| deferred.remove(&p)) {
			pieces.extend(v.into_iter().map(|os| Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None }));
		}
		if let Some((p, cls)) = oi.checked_sub(1).and_then(|p| deferred_train.remove(&p).map(|c| (p, c))) {
			let pt = order[p].pt;
			let lines = vec![format!("  train class only {}", cls.join(","))];
			pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt, map: cx.w(pt).map(|w| w.map), title: Some("Class trainer".into()), lines, q: None, t: Some(OrderT::Train), to_way: false }, items: None });
		}
		let o = order[oi].clone();
		let Some(key) = o.key else {
			// A training stop where v1's next steps train anyway: v1's (its travel goes with the
			// next event).
			if o.t == OrderT::Train && cx.v1_trains_next(&order, oi) {
				if let Some(k) = order[oi + 1..].iter().find_map(|n| n.key) {
					keep.extend(cx.orphan.get(&k).into_iter().flatten().copied().filter(|&s| trains(s)));
				}
				if !o.items().is_empty() && oi + 1 < order.len() {
					let mut its: Vec<Item> = o.items().iter().filter(|x| matches!(x.t, ItemT::Network | ItemT::Hearth | ItemT::Deathskip)).cloned().collect();
					its.extend(order[oi + 1].items().iter().cloned());
					order[oi + 1].items = Some(its);
				}
				oi += 1;
				continue;
			}
			let x = if o.t == OrderT::Level { level_ins(&cx, &order, oi) } else { ins_lines(&cx, &mut obj_done, &o) };
			let Some(x) = x else {
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
			let mut x = x;
			let (pull, dup) = if o.t == OrderT::Train { train_orphans(&order, oi + 1, o.lvl, o.pt, None, &pulled) } else { (Vec::new(), Vec::new()) };
			pulled.extend(dup);
			if !pull.is_empty() {
				// (Everyone v1's steps train needs no line of the route's own; the rest keep it.)
				let covered: Option<FxHashSet<String>> = pull.iter().try_fold(FxHashSet::default(), |mut acc: FxHashSet<String>, &s| {
					acc.extend(train_classes(s)?);
					Some(acc)
				});
				let rest: Vec<&str> = covered.map_or_else(Vec::new, |c| CLASSES.iter().copied().filter(|k| !c.contains(*k)).collect());
				x.lines = if rest.is_empty() { Vec::new() } else { vec![format!("  train class only {}", rest.join(","))] };
			}
			// A training stop in a town with no trainer for some classes (Razor Hill has no Mage
			// trainer): those train at the route's next pass by one of theirs (Sen'jin Village), within
			// a level and a half; else at the route's next training stop (Darnassus' Paladins, Shamans,
			// Mages and Warlocks were sent over the sea half a level after Ironforge, A6); with none
			// left, the stop's line sends them to the nearest as before.
			if o.t == OrderT::Train && cx.route_travel {
				const TRAINER_YD: f64 = 150.0;
				const NEXT_TRAINER_LVL: f64 = 1.5;
				let fac = if route.faction.as_deref().is_some_and(|f| f.starts_with('H')) { 'H' } else { 'A' };
				let here = cx.trainer_classes_near(o.pt, fac, TRAINER_YD);
				let line_cls: Option<Vec<&str>> = x.lines.first().map(|l| match re!(r"\bonly\s+([A-Za-z,]+)").captures(l) {
					Some(m) => CLASSES.iter().copied().filter(|c| m[1].split(',').any(|x| x == *c)).collect(),
					None => CLASSES.to_vec(),
				});
				if let (false, Some(cls)) = (here.is_empty(), line_cls) {
					let mut keep: Vec<&str> = Vec::new();
					for cl in cls {
						if here.contains(cl) {
							keep.push(cl);
							continue;
						}
						let later = order[oi + 1..]
							.iter()
							.take_while(|n| n.lvl.zip(o.lvl).is_none_or(|(b, a)| b - a <= NEXT_TRAINER_LVL) && n.t != OrderT::Train)
							.position(|n| cx.trainer_classes_near(n.pt, fac, TRAINER_YD).contains(cl));
						match later {
							Some(d) => deferred_train.entry(oi + 1 + d).or_default().push(cl),
							None if order[oi + 1..].iter().any(|n| n.t == OrderT::Train) => {}
							None => keep.push(cl),
						}
					}
					if keep.len() != CLASSES.len() {
						x.lines = if keep.is_empty() { Vec::new() } else { vec![format!("  train class only {}", keep.join(","))] };
					}
				}
			}
			let merged = match pieces.last_mut() {
				Some(Piece { kind: PieceKind::Ins { pt, title, lines, .. }, .. }) if pull.is_empty() && *pt == o.pt && title.as_deref() == Some(x.title.as_str()) && o.items().is_empty() => {
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
			for os in pull {
				pulled.insert(os);
				pieces.push(Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None });
			}
			oi += 1;
			continue;
		};
		oi += 1;
		if !seen.insert(key) {
			// Another stop's buy of a timed item: one more there, in a step of v1's title.
			if cx.buy_each.contains(&key) {
				if let (Some(&st), Some(l)) = (cx.step_of.get(&key), cx.step_line(key)) {
					let title = re!(r"^step\s+").replace(&cx.steps[st].title, "").into_owned();
					let p = cx.w(o.pt);
					pieces.push(Piece {
						gi: -1,
						kind: PieceKind::Ins { pt: o.pt, map: p.map(|p| p.map), title: Some(title), lines: vec![cx.buy_at(&l.text, o.pt, true)], q: o.q, t: Some(o.t), to_way: false },
						items: o.items.clone(),
					});
					continue;
				}
			}
			if !o.items().is_empty() {
				pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt: o.pt, map: None, title: None, lines: Vec::new(), q: None, t: None, to_way: false }, items: o.items.clone() });
			}
			continue;
		}
		let Some(&s) = cx.step_of.get(&key) else {
			log.push(format!("apply-route: {} is in no step; left out", o.from.as_deref().unwrap_or("undefined")));
			continue;
		};
		// A buy the route makes far from v1's step (the Soothing Spices bought at the Crossroads on the
		// way to Ratchet, not after the walk back to Swamp Eye Jarl, FlowDiag 6): at the route's event,
		// in a step of the place. The event is v1's buy line, or a task of a quest whose item v1's step
		// buys (the task keyed to the hand-in line; the hand-in stays the route's later event).
		let buy_line = cx.step_line(key).filter(|l| is_head_ws(&l.text, "buy")).or_else(|| {
			let items: Vec<u32> = quest(o.q.filter(|_| o.t == OrderT::Task)?)?.objectives().filter(|x| x.is("item")).filter_map(|x| x.id.map(|i| i as u32)).collect();
			cx.steps[s].lines.iter().find(|l| re!(r"^\s+buy\s+(\d+)\b").captures(&l.text).and_then(|m| m[1].parse::<u32>().ok()).is_some_and(|i| items.contains(&i)))
		});
		if let Some(l) = buy_line {
			let v1_at = cx.steps[s].lines.iter().filter(|x| x.key() != l.key()).find_map(|x| cx.line_pt(x));
			if let (Some(a), Some(b)) = (cx.w(o.pt), cx.w(v1_at)) {
				if a.c != b.c || a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD {
					let title = cx.area_at.and_then(|ar| ar.at(a.c, a.wx, a.wy)).map(|ar| ar.name).filter(|n| !n.is_empty()).or_else(|| cx.zone_name(Some(a.map))).unwrap_or_else(|| re!(r"^step\s+").replace(&cx.steps[s].title, "").into_owned());
					pieces.push(Piece {
						gi: -1,
						kind: PieceKind::Ins { pt: o.pt, map: Some(a.map), title: Some(title), lines: vec![if re!(r"\bnearest\b").is_match(&l.text) { l.text.clone() } else { cx.buy_at(&l.text, o.pt, false) }], q: o.q, t: Some(o.t), to_way: false },
						items: o.items.clone(),
					});
					moved_buys.insert(l.key());
					seen.insert(l.key());
					if l.key() != key {
						seen.remove(&key);
					}
					continue;
				}
			}
		}
		// (Items the writer does not write, a long walk's trace, do not split a step.)
		let mut its = if o.items().iter().all(|x| matches!(x.t, ItemT::Other)) { None } else { o.items.clone() };
		// A bind at the inn v1's own step binds at, inside the step the piece before writes: it goes
		// with v1's `sethome` line, not a step of its own (Thunderbrew Distillery after Tannok).
		if let (Some(i), Some(Piece { kind: PieceKind::Step { step, .. }, .. })) = (&its, pieces.last()) {
			let v1_bind = |x: &Item| {
				let name = cx.inn_name(x.inn)?;
				cx.steps[s].lines.iter().find(|l| re!(r#"^\s+sethome\s+"([^"]+)""#).captures(&l.text).is_some_and(|m| &m[1] == name)).map(|l| l.key())
			};
			if *step == s && i.iter().all(|x| x.t == ItemT::Other || (x.t == ItemT::Bind && v1_bind(x).is_some())) {
				for x in i.iter().filter(|x| x.t == ItemT::Bind) {
					bind_at_line.push((v1_bind(x).unwrap(), x.clone()));
				}
				its = None;
			}
		}
		// The route's travel comes before a way step.
		if let (Some(orph), Some(i)) = (cx.orphan.get(&key), &its) {
			if orph.iter().any(|&os| cx.steps[os].way) && i.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip)) {
				pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt: o.pt, map: None, title: None, lines: Vec::new(), q: None, t: None, to_way: true }, items: its.take() });
			}
		}
		if let Some(orph) = cx.orphan.get(&key) {
			let here_c = cx.w(o.pt).map(|p| p.c as i64);
			for &os in orph.iter().filter(|os| !pulled.contains(os) && (keep.contains(os) || !spare_training(**os))) {
				let piece = Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None };
				// A v1 step the route did not place is written before the route's next v1 line; when
				// that line is in another zone than the step's own place, the step goes on the route's
				// nearer pass there instead: a recent one (or any, over the sea), else a later one at
				// about the same level. (The Undead Paladins' Bandarion Keep quests after the Barrens; the
				// Paladins' Undercity trainer and the Shamans' Sepulcher brazier at the route's own
				// Undercity stop, not after the Tarren Mill accepts.) Not v1's way steps, nor travel only.
				let st = &cx.steps[os];
				let movable = !st.way && st.lines.iter().any(|l| l.kind == Kind::Goal && !re!(r"^\s+(goto|fly|hearth)\b").is_match(&l.text));
				// (A step of a class's own run, written right after the run's step before it: it stays with its
				// run, in v1's order, the Druids' Body and Heart before the boat, N1.)
				let step_only = |x: &Step| x.lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only")).map(|l| trim(split_comment(&l.text).0).to_string());
				let in_run = os > 0 && matches!(pieces.last(), Some(Piece { kind: PieceKind::Orphan(p), .. }) if *p == os - 1) && cx.steps[os - 1].file == st.file && step_only(st).is_some() && step_only(&cx.steps[os - 1]) == step_only(st);
				let movable = movable && !in_run;
				// (Where the step is: its first placed line, else its zone; a step whose lines are
				// elsewhere than its zone, the Warriors' Islander on Fray Island in a Stormwind step, by
				// its place.)
				let place = cx.w(st.lines.iter().find_map(|l| cx.line_pt(l)));
				let (step_c, step_z) = match place {
					Some(p) => (Some(p.c as i64), cx.zone_name(Some(p.map))),
					None => (zone_c(&st.zone), st.zone.clone()),
				};
				let here_z = cx.w(o.pt).and_then(|p| cx.zone_name(Some(p.map)));
				// (A class's own step whose quests the route is not yet level for, the Paladins' Tome of
				// Divinity at 9.7 with level 12 needed: on the route's first later pass through its zone
				// at that level. Only when none of its accepts is on level: Stormwind's class quests for
				// four classes are not all carried to the next Stormwind visit for Elune's Grace's 20; a
				// single accept under its level waits on its own, held.)
				let class_only = st.lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only")).is_some_and(|l| {
					let list = trim(&re!(r"^\s+only\s+").replace(split_comment(&l.text).0, "")).to_string();
					only_classes(Some(&list)) && Ctx::only_races(Some(&list)).is_none()
				});
				let need = st.lines.iter().filter_map(|l| re!(r"^\s+accept\s+(\d+)\b").captures(&l.text)).filter_map(|m| m[1].parse::<u32>().ok()).filter_map(|q| quest(q).and_then(|r| r.min_level)).reduce(f64::min).unwrap_or(0.0);
				if class_only && o.lvl.is_some_and(|l| l < need) {
					// (Only a pass in a guide for the step's own players: deferred into a shared guide, a
					// start's class step is lost with the canonical start's writing, the Dwarf Paladins'
					// Tome of Divinity at Ironforge, D1.)
					// (An event with no v1 line, a training stop, is in the guide of the route's v1 line before it.)
					let guide_at = |d: usize| order[..=oi + d].iter().rev().find_map(|n| n.key).map(|k| k.0);
					let at_z = order[oi..]
						.iter()
						.enumerate()
						.position(|(d, n)| n.lvl.is_some_and(|l| l >= need) && cx.w(n.pt).and_then(|p| cx.zone_name(Some(p.map))) == step_z && guide_at(d).is_some_and(|g| cx.guide_races[g] == cx.guide_races[st.file]));
					// (Not past the route's own events of its quests, nor v1's steps with them on the way:
					// Agent Kearnen's hand-in in Westfall, Fizzule's for Deep Cover, would come before the
					// accept they wait on.)
					let own: FxHashSet<u32> = st.lines.iter().filter_map(|l| quest_of(&l.text)).collect();
					let crosses = |d: usize| {
						order[oi..oi + d].iter().any(|n| {
							n.q.is_some_and(|q| own.contains(&q))
								|| n.key.and_then(|k| cx.orphan.get(&k)).into_iter().flatten().any(|&s2| s2 != os && cx.steps[s2].lines.iter().filter_map(|l| quest_of(&l.text)).any(|q| own.contains(&q)))
						})
					};
					if let Some(d) = at_z.filter(|&d| !crosses(d)) {
						deferred.entry(oi + d).or_default().push(os);
						continue;
					}
				}
				// (A city under or beside the zone the route is in counts as here: the Undercity's Magic
				// Quarter from the Ruins of Lordaeron, U6.)
				let close = matches!((place, cx.w(o.pt)), (Some(a), Some(b)) if a.c == b.c && js_hypot(a.wx - b.wx, a.wy - b.wy) <= ZONE_STEP_YD);
				if movable && !close && step_z.is_some() && here_z.is_some() && step_z != here_z {
					const RECENT_PIECES: usize = 12;
					const SAME_VISIT_LVL: f64 = 2.0;
					let over_sea = matches!((step_c, here_c), (Some(a), Some(b)) if a != b);
					let last = pieces.iter().rposition(|p| piece_zone(p).is_some_and(|z| step_z.as_ref() == Some(&z)));
					// (Or a pass at about this level, however many steps back: v1's Orgrimmar training and
					// riding steps at the route's Orgrimmar stop, not after the Feralas work that followed
					// it, a flight from Gadgetzan written as a walk.)
					let lvl_at = |j: usize| {
						pieces[..=j].iter().rev().find_map(|p| match &p.kind {
							PieceKind::Step { keys, .. } => keys.iter().filter_map(|k| cx.key_lvl.get(k).copied()).reduce(f64::max),
							_ => None,
						})
					};
					// (Not a step with travel of its own, the Druids' flight to Rut'theran from Auberdine: it
					// starts where v1 has it.)
					let own_travel = st.lines.iter().any(|l| re!(r"^\s+(fly|hearth|goto)\b").is_match(&l.text));
					let same_visit = |j: usize| !own_travel && lvl_at(j).zip(o.lvl).is_some_and(|(a, b)| b - a <= SAME_VISIT_LVL);
					// (Never back into an earlier guide: the Undead's "Riding at 40" written in the 30-40
					// Stranglethorn guide, at its Undercity start, #404.)
					let not_earlier = |j: usize| pieces[j].gi < 0 || pieces[j].gi >= st.file as i64;
					if let Some(j) = last.filter(|&j| not_earlier(j) && (over_sea || pieces.len() - j <= RECENT_PIECES || same_visit(j))) {
						// (Only where its quests are taken by then: not the Warriors' Affray, whose
						// Islander comes from Stormwind later, back to an earlier pass in the Barrens.)
						let acc_re = re!(r"^\s+accept\s+(\d+)\b");
						let mut taken: FxHashSet<u32> = FxHashSet::default();
						for p in &pieces[..=j] {
							let lines: Vec<&str> = match &p.kind {
								PieceKind::Step { step, keys } => keys.iter().filter_map(|k| cx.steps[*step].line(k.1)).map(|l| l.text.as_str()).collect(),
								PieceKind::Orphan(s) => cx.steps[*s].lines.iter().map(|l| l.text.as_str()).collect(),
								PieceKind::Ins { lines, .. } => lines.iter().map(String::as_str).collect(),
							};
							taken.extend(lines.iter().filter_map(|t| acc_re.captures(t)).filter_map(|m| m[1].parse::<u32>().ok()));
						}
						let own: FxHashSet<u32> = st.lines.iter().filter_map(|l| acc_re.captures(&l.text)).filter_map(|m| m[1].parse::<u32>().ok()).collect();
						// (Nor back past a piece written since with a line of one of its quests: Body and Heart's
						// hand-in before the Moonkin Stone's Lunaclaw, N1.)
						let all_q: FxHashSet<u32> = st.lines.iter().filter_map(|l| quest_of(&l.text)).collect();
						let since = pieces[j + 1..].iter().any(|p| {
							let lines: Vec<&str> = match &p.kind {
								PieceKind::Step { step, keys } => keys.iter().filter_map(|k| cx.steps[*step].line(k.1)).map(|l| l.text.as_str()).collect(),
								PieceKind::Orphan(s) => cx.steps[*s].lines.iter().map(|l| l.text.as_str()).collect(),
								PieceKind::Ins { lines, .. } => lines.iter().map(String::as_str).collect(),
							};
							lines.iter().filter_map(|t| quest_of(t)).any(|q| all_q.contains(&q))
						});
						let ready = !since && st.lines.iter().filter(|l| l.kind == Kind::Goal && !acc_re.is_match(&l.text)).filter_map(|l| quest_of(&l.text)).all(|q| own.contains(&q) || taken.contains(&q));
						if ready {
							// (Before that pass's way on, when it is the last thing there: the Trolls' riding
							// step in Durotar before the zeppelin to Grom'gol, not after it.)
							let travel_only = |p: &Piece| {
								let s = match &p.kind {
									PieceKind::Step { step, .. } => *step,
									PieceKind::Orphan(s) => *s,
									PieceKind::Ins { .. } => return false,
								};
								let goals: Vec<&Line> = cx.steps[s].lines.iter().filter(|l| l.kind == Kind::Goal).collect();
								!goals.is_empty() && goals.iter().all(|l| re!(r"^\s+(goto|fly|hearth)\b").is_match(&l.text))
							};
							let at = if j > 0 && travel_only(&pieces[j]) { j } else { j + 1 };
							pieces.insert(at, piece);
							continue;
						}
					}
					// (A later pass there at about this level: the step waits for it.)
					let later = order[oi..].iter().take_while(|n| n.lvl.zip(o.lvl).is_none_or(|(b, a)| b - a <= SAME_VISIT_LVL)).position(|n| cx.w(n.pt).and_then(|p| cx.zone_name(Some(p.map))) == step_z && n.key.is_none_or(|k| cx.guide_races[k.0] == cx.guide_races[st.file]));
					if let Some(d) = later {
						deferred.entry(oi + d).or_default().push(os);
						continue;
					}
				}
				pieces.push(piece);
			}
		}
		let gi = cx.steps[s].file as i64;
		// (v1's training line the route trains by in another city, its Stormwind trainer for v1's
		// Ironforge line: written at the route's trainer, not as a trip to v1's.)
		let train_zone = cx.w(o.pt).and_then(|p| cx.zone_name(Some(p.map)));
		// (Only a step whose other lines the route writes at their own events: the class quests Maxan
		// hands out at Kharanos, which it does not name, are v1's there with the training.)
		let just_trains = cx.steps[s].lines.iter().filter(|l| l.kind == Kind::Goal).all(|l| cx.named.contains(&l.key()) || re!(r"^\s+(train\s+class|fly|goto|hearth)\b").is_match(&l.text));
		let elsewhere = o.t == OrderT::Train && just_trains && train_zone.is_some() && cx.steps[s].zone.is_some() && train_zone != cx.steps[s].zone;
		if let (true, Some(l)) = (elsewhere, cx.step_line(key)) {
			pieces.push(Piece {
				gi: -1,
				kind: PieceKind::Ins { pt: o.pt, map: cx.w(o.pt).map(|p| p.map), title: Some("Class trainer".into()), lines: vec![l.text.clone()], q: None, t: Some(OrderT::Train), to_way: false },
				items: its,
			});
		} else {
			match pieces.last_mut() {
				Some(Piece { kind: PieceKind::Step { step, keys }, .. }) if *step == s && its.is_none() => keys.push(key),
				_ => pieces.push(Piece { gi, kind: PieceKind::Step { step: s, keys: vec![key] }, items: its }),
			}
		}
		// (A v1 training line the route moved: v1's other training steps of that level come with it,
		// once the route is done in its step.)
		if o.t == OrderT::Train && order.get(oi).and_then(|n| n.key).and_then(|k| cx.step_of.get(&k)) != Some(&s) {
			let (pull, dup) = train_orphans(&order, oi, o.lvl, o.pt, Some(s), &pulled);
			pulled.extend(dup);
			for os in pull {
				pulled.insert(os);
				pieces.push(Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None });
			}
		}
	}
	for (_, v) in std::mem::take(&mut deferred) {
		pieces.extend(v.into_iter().map(|os| Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None }));
	}
	for (p, cls) in std::mem::take(&mut deferred_train) {
		let pt = order[p].pt;
		let lines = vec![format!("  train class only {}", cls.join(","))];
		pieces.push(Piece { gi: -1, kind: PieceKind::Ins { pt, map: cx.w(pt).map(|w| w.map), title: Some("Class trainer".into()), lines, q: None, t: Some(OrderT::Train), to_way: false }, items: None });
	}
	for os in tail.into_iter().filter(|os| !pulled.contains(os) && (keep.contains(os) || !spare_training(*os))) {
		pieces.push(Piece { gi: cx.steps[os].file as i64, kind: PieceKind::Orphan(os), items: None });
	}
	for (k, x) in bind_at_line {
		cx.items_at_line.entry(k).or_default().push(x);
	}

	// One training stop per town visit, the later one (Thunder Bluff at 12: v1's `train class` on
	// arrival, then the route's two stops, M5): an earlier stop whose classes the visit's later ones
	// all train goes.
	if cx.route_travel {
		const VISIT_YD: f64 = 300.0;
		let train_re = re!(r"^\s+train\s+class\b");
		// (A training line's classes: its `only`, else its step's, else every class.)
		let classes_of = |line: &str, step_only: Option<&str>| -> FxHashSet<&'static str> {
			let list = line_only(line).or(step_only).unwrap_or("");
			let named: FxHashSet<&'static str> = CLASSES.iter().copied().filter(|c| list.split(',').any(|x| trim(x) == *c)).collect();
			if named.is_empty() {
				CLASSES.iter().copied().collect()
			} else {
				named
			}
		};
		let step_only = |s: usize| cx.steps[s].lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(split_comment(&l.text).0, "")).to_string());
		// (A piece's training lines: their v1 keys, None for the route's own, and their classes.)
		let trainings = |p: &Piece| -> Vec<(Option<Key>, FxHashSet<&'static str>)> {
			match &p.kind {
				PieceKind::Ins { lines, .. } => lines.iter().filter(|l| train_re.is_match(l)).map(|l| (None, classes_of(l, None))).collect(),
				PieceKind::Step { step, keys } => {
					let so = step_only(*step);
					keys.iter().filter_map(|k| cx.steps[*step].line(k.1)).filter(|l| train_re.is_match(&l.text)).map(|l| (Some(l.key()), classes_of(&l.text, so.as_deref()))).collect()
				}
				PieceKind::Orphan(s) => {
					let so = step_only(*s);
					cx.steps[*s].lines.iter().filter(|l| train_re.is_match(&l.text)).map(|l| (Some(l.key()), classes_of(&l.text, so.as_deref()))).collect()
				}
			}
		};
		let at = |p: &Piece| -> Option<Pt> {
			cx.w(match &p.kind {
				PieceKind::Step { keys, .. } => keys.iter().find_map(|k| cx.key_pt.get(k).copied()),
				PieceKind::Ins { pt, .. } => *pt,
				PieceKind::Orphan(os) => cx.steps[*os].lines.iter().find_map(|l| cx.line_pt(l)),
			})
		};
		let travels = |p: &Piece| p.items.as_ref().is_some_and(|its| its.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)));
		for i in 0..pieces.len() {
			let mine = trainings(&pieces[i]);
			let Some(here) = at(&pieces[i]).filter(|_| !mine.is_empty()) else { continue };
			let mut later: FxHashSet<&'static str> = FxHashSet::default();
			for q in &pieces[i + 1..] {
				if travels(q) || at(q).is_some_and(|p| p.c != here.c || p.map != here.map || js_hypot(p.wx - here.wx, p.wy - here.wy) > VISIT_YD) {
					break;
				}
				later.extend(trainings(q).into_iter().flat_map(|t| t.1));
			}
			if !mine.iter().all(|t| t.1.is_subset(&later)) {
				continue;
			}
			match &mut pieces[i].kind {
				PieceKind::Ins { lines, title, .. } => {
					lines.retain(|l| !train_re.is_match(l));
					if lines.is_empty() {
						*title = None;
					}
				}
				_ => moved_buys.extend(mine.into_iter().filter_map(|t| t.0)),
			}
		}
	}

	// ---- guide boundaries: fewest pieces outside their own guide ----
	let n = pieces.len();
	let ng = chain.len();
	// A cut between two pieces at one place, with no travel between them, splits a town visit over two
	// guides (Shady Rest's 1268 closing one guide, 1251 and 1269 opening the next, FlowDiag 6): it costs
	// as much as this many pieces left out of their own guide.
	const VISIT_CUT_COST: i64 = 4;
	const VISIT_YD: f64 = 300.0;
	let piece_pt = |p: &Piece| -> Option<Pt> {
		match &p.kind {
			PieceKind::Step { keys, .. } => cx.w(keys.iter().find_map(|k| cx.key_pt.get(k).copied())),
			PieceKind::Ins { pt, .. } => cx.w(*pt),
			// (A step with no NPC line: where its first kill or collect target spawns, Perrine's Chest.)
			PieceKind::Orphan(os) => cx.w(cx.steps[*os].lines.iter().find_map(|l| cx.line_pt(l))).or_else(|| cx.step_spawn_pt(*os)),
		}
	};
	// A v1 step the route does not take, far from the town visit it lands in the middle of, goes after
	// that visit: a detour between two stops at one place is a trip out and back (Dokimi's crates at the
	// Crossroads between two Ratchet stops, FlowDiag 7; the Shamans' flight to Islen between two
	// Nesingwary stops, FlowDiag 2). Not past a line of one of its quests, nor past the route's travel.
	{
		let near = |a: Option<Pt>, b: Option<Pt>| matches!((a, b), (Some(a), Some(b)) if a.c == b.c && a.map == b.map && js_hypot(a.wx - b.wx, a.wy - b.wy) <= VISIT_YD);
		let travels = |p: &Piece| p.items.as_ref().is_some_and(|its| its.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)));
		let quests_of = |p: &Piece| -> FxHashSet<u32> {
			match &p.kind {
				PieceKind::Step { step, keys } => keys.iter().filter_map(|k| cx.steps[*step].line(k.1)).filter_map(|l| quest_of(&l.text)).collect(),
				PieceKind::Orphan(s) => cx.steps[*s].lines.iter().filter_map(|l| quest_of(&l.text)).collect(),
				PieceKind::Ins { q, .. } => q.iter().copied().collect(),
			}
		};
		let mut i = 1;
		while i + 1 < pieces.len() {
			let PieceKind::Orphan(os) = pieces[i].kind else {
				i += 1;
				continue;
			};
			// (A run of such steps goes together: the Shamans' flight to Islen and their hearth back. v1's
			// travel for everyone at the run's end stays where it is: it is the way on to the route's next
			// place, the flight to Thelsamar before Hammertoe's Digsite.)
			let everyones_travel = |s: usize| {
				let st = &cx.steps[s];
				let goals: Vec<&Line> = st.lines.iter().filter(|l| l.kind == Kind::Goal).collect();
				!st.lines.iter().any(|l| is_head_ws(&l.text, "only")) && !goals.is_empty() && goals.iter().all(|l| re!(r"^\s+(goto|fly|hearth)\b").is_match(&l.text))
			};
			let mut k = i + 1;
			while k < pieces.len() && matches!(pieces[k].kind, PieceKind::Orphan(_)) {
				k += 1;
			}
			let mut e = k;
			while e > i && matches!(pieces[e - 1].kind, PieceKind::Orphan(s) if everyones_travel(s)) {
				e -= 1;
			}
			if e == i {
				i = k;
				continue;
			}
			let here = piece_pt(&pieces[i - 1]);
			let place = piece_pt(&pieces[i]);
			let own: FxHashSet<u32> = pieces[i..e].iter().flat_map(|p| quests_of(p)).collect();
			// (A recent piece at the step's own place, with no travel and none of its quests' lines
			// since: the step goes right after it, done while there, not a trip back (Perrine's Chest
			// at the Scarlet camp, not after the walk to Brill, S1).)
			if !cx.steps[os].way && (place.is_none() || !near(here, place)) {
				const BACK_PIECES: usize = 8;
				// (Or the piece of v1's step just before it that accepts its quest: the Warriors' scales
				// on Thunder Ridge right after Uzzek's Far Watch accept, not after the Crossroads, T2.)
				let accepts_own = |p: &Piece| match &p.kind {
					PieceKind::Step { step, .. } => *step + 1 == os && cx.steps[*step].lines.iter().any(|l| is_head_ws(&l.text, "accept") && quest_of(&l.text).is_some_and(|q| own.contains(&q))),
					_ => false,
				};
				// (A step at an NPC looks back only to the route's piece just before it, its neighbour;
				// field work with no NPC, the chest at the camp, past the town visit since.)
				let at_npc = cx.steps[os].lines.iter().any(|l| cx.line_pt(l).is_some());
				let back = if at_npc { 1 } else { BACK_PIECES };
				let mut b = i;
				let mut found = None;
				let mut routes_seen = 0;
				while b > 0 && i - b < BACK_PIECES && routes_seen < back {
					b -= 1;
					let p = &pieces[b];
					if !matches!(p.kind, PieceKind::Orphan(_)) {
						routes_seen += 1;
					}
					if (!matches!(p.kind, PieceKind::Orphan(_)) && near(piece_pt(p), place)) || accepts_own(p) {
						found = Some(b);
						break;
					}
					if travels(p) || !(p.gi < 0 || p.gi == pieces[i].gi) || !quests_of(p).is_disjoint(&own) {
						break;
					}
				}
				if let Some(b) = found {
					let run: Vec<Piece> = pieces.drain(i..e).collect();
					let n_run = run.len();
					pieces.splice(b + 1..b + 1, run);
					i = e.max(b + 1 + n_run);
					continue;
				}
			}
			// (A run of nothing but v1's way steps stays: it is the way on.)
			let all_way = pieces[i..e].iter().all(|p| matches!(p.kind, PieceKind::Orphan(s) if cx.steps[s].way));
			// (Between two of the route's lines at one NPC, a step a few yards off still splits that stop:
			// the Undead Priests' Aelthalyste between Faranell's hand-in and his next quest.)
			let at = |a: Option<Pt>, b: Option<Pt>, yd: f64| matches!((a, b), (Some(a), Some(b)) if a.c == b.c && a.map == b.map && js_hypot(a.wx - b.wx, a.wy - b.wy) <= yd);
			const SAME_NPC_YD: f64 = 30.0;
			let splits_npc = k < pieces.len() && at(here, piece_pt(&pieces[k]), SAME_NPC_YD) && !at(here, place, SAME_NPC_YD);
			if k >= pieces.len() || all_way || travels(&pieces[k]) || !near(here, piece_pt(&pieces[k])) || (near(here, place) && !splits_npc) || place.is_none() {
				i = k;
				continue;
			}
			// (Not into another audience's guide's pieces: the start's own step would land in a shared
			// guide, which is the canonical start's writing.)
			let players = &cx.guide_races[cx.steps[os].file];
			let same_players = |p: &Piece| p.gi < 0 || cx.guide_races[p.gi as usize] == *players;
			let mut j = k;
			while j < pieces.len() && !travels(&pieces[j]) && same_players(&pieces[j]) && near(here, piece_pt(&pieces[j])) && quests_of(&pieces[j]).is_disjoint(&own) {
				j += 1;
			}
			let run: Vec<Piece> = pieces.drain(i..e).collect();
			let at = j - (e - i);
			let n_run = run.len();
			pieces.splice(at..at, run);
			i = at + n_run;
		}
	}
	let mid_visit: Vec<bool> = (0..=n)
		.map(|p| {
			// (Around v1's steps the route does not place, written between: the route's own pieces.)
			let orphan = |q: &Piece| matches!(q.kind, PieceKind::Orphan(_));
			let travels = |q: &Piece| q.items.as_ref().is_some_and(|its| its.iter().any(|x| matches!(x.t, ItemT::Hearth | ItemT::Network)));
			if p == 0 || p >= n {
				return false;
			}
			let Some(a) = (0..p).rev().find(|&q| !orphan(&pieces[q])) else { return false };
			let Some(b) = (p..n).find(|&q| !orphan(&pieces[q])) else { return false };
			if (a + 1..=b).any(|q| travels(&pieces[q])) {
				return false;
			}
			matches!((piece_pt(&pieces[a]), piece_pt(&pieces[b])), (Some(a), Some(b)) if a.c == b.c && a.map == b.map && js_hypot(a.wx - b.wx, a.wy - b.wy) <= VISIT_YD)
		})
		.collect();
	let mut cut: Vec<usize> = vec![0];
	for k in 1..ng {
		let room = ng - k;
		let k = k as i64;
		let c0 = *cut.last().unwrap();
		// (Only between two guides for the same players: a start's own guide and a shared one keep their
		// own pieces, Far Watch's hand-ins in Durotar.)
		let same_players = cx.guide_races[k as usize - 1] == cx.guide_races[k as usize];
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
			let cost = cost_before + cost_after + if same_players && mid_visit[p] { VISIT_CUT_COST } else { 0 };
			if p > c0 && cost <= best_cost {
				best_cost = cost;
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
		home: None,
		first_piece: FxHashSet::default(),
		pre_done: FxHashSet::default(),
		notes_left: Vec::new(),
		piece_at: FxHashMap::default(),
		route_lvl: None,
		held: Vec::new(),
		prev_key: None,
		done: Vec::new(),
		carry: Vec::new(),
		leg_done: None,
		pending_orphans: Vec::new(),
		away: Vec::new(),
		fresh_fps: FxHashSet::default(),
		away_undo: Vec::new(),
		written: FxHashSet::default(),
		skip: std::mem::take(&mut moved_buys),
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
		wr.g = GuideState { zone: Some(header_zone.clone()), item_only, goal_only, file: gi, ..GuideState::default() };
		// (A guide starts with everyone where its first step is: v1's guides end their detours. Not a
		// class's own flight off on the route's way, the Shamans' Ironforge trainer at the end of
		// Duskwood: they fly back to where the next guide begins.)
		if cx.route_travel {
			wr.away.retain(|a| a.1.is_some());
		} else {
			wr.away.clear();
		}
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
			// (The route's races did it in their own guide: the copy is the other races', Regthar's
			// Kolkar Leaders written again in the shared Barrens guide for an Orc who took it already.)
			let others = (cx.shared(gi) && !cx.other_races.is_empty()).then(|| cx.other_races.clone());
			match &p.kind {
				PieceKind::Orphan(os) => wr.step_lines(*os, None, true, others.as_deref()),
				PieceKind::Step { step, keys } => wr.step_lines(*step, Some(keys), false, others.as_deref()),
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
				let leg = |x: &Item| if cx.route_travel { matches!(x.t, ItemT::Hearth | ItemT::Network | ItemT::Deathskip) } else { x.t == ItemT::Hearth };
				// (A leg whose run reaches into the next guide's own first steps is that guide's to open
				// with: the hearth to Thelsamar, its bind, then the way to Gadgetzan, all in Un'Goro's, not
				// the way in this guide and a bounce back to the bind in the next, A18.)
				let next_guide = cut[gi + 1];
				let into_next = j >= next_guide && i < next_guide;
				if j < lim && !into_next && pieces.get(j).is_some_and(|q| !is_orphan(q) && q.items.as_ref().is_some_and(|its| its.iter().any(&leg))) {
					if cx.route_travel {
						wr.leg_done = Some(j);
						wr.gap_decide(gi);
						// (The next guide's own steps stay in it: a player who starts there binds at
						// Thelsamar before Un'Goro's hearth, #171.)
						wr.pending_orphans = (i..j.min(cut[gi + 1]))
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
			// A deathskip comes before the way there, which is everyone's: a player without deathskips
			// passes its `die` step and travels on from where they are.
			if let Some(v) = its.as_mut() {
				let (d, rest): (Vec<Item>, Vec<Item>) = std::mem::take(v).into_iter().partition(|x| x.t == ItemT::Deathskip);
				*v = rest;
				wr.write_items(&d, false);
			}
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
					// (v1's waypoint into the place the piece works, a cave's mouth: the way in, kept — the
					// arrow would cut through the rock to the eggs at the back of Shadowthread Cave, #328.)
					const INTO_YD: f64 = 250.0;
					let into = |w: &Waypoint| cx.w(first_pt).is_some_and(|b| b.c == w.c && js_hypot(b.wx - w.wx, b.wy - w.wy) <= INTO_YD);
					let ks: Vec<usize> = wr.g.v1_moves.iter().map(|m| m.0).chain(wr.g.waypoints.iter().filter(|w| !into(w)).map(|w| w.k)).collect();
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
						let from = wr.route_pt;
						let saved = wr.class_legs(&p.kind);
						let gated = if saved.is_empty() { wr.g.item_only.first().map(|l| trim(&re!(r"^\s+only\s+").replace(l, "")).to_string()) } else { None };
						let n = wr.g.body.len();
						// (A guide's first piece: from where the route was in the guide before, on its continent:
						// the walk to Feathermoon. A sea crossing there is v1's own opening travel's.)
						let opening = cx.route_travel && !wr.g.body.iter().flatten().any(|l| l.starts_with("step ")) && matches!((cx.w(wr.route_pt), cx.w(first_pt)), (Some(a), Some(b)) if a.c == b.c);
						wr.travel_to(if opening { last_pt.or(wr.route_pt) } else { last_pt }, first_pt);
						wr.g.item_only = saved;
						let flew = wr.g.body[n..].iter().flatten().any(|l| re!(r"^\s+(fly|hearth)\s").is_match(l));
						if let Some(list) = gated.filter(|l| flew && cx.route_travel && only_classes(Some(l)) && Ctx::only_races(Some(l)).is_none()) {
							wr.left_behind(&list, from);
						}
					}
				}
				let _ = ins_pt;
				wr.g.v1_moves.clear();
			}
			let to_way = matches!(p.kind, PieceKind::Ins { to_way: true, .. });
			if let Some(its) = its.as_ref().filter(|v| !v.is_empty()) {
				let from = wr.route_pt;
				let saved = wr.class_legs(&p.kind);
				let gated = if saved.is_empty() { wr.g.item_only.first().map(|l| trim(&re!(r"^\s+only\s+").replace(l, "")).to_string()) } else { None };
				wr.write_items(its, to_way);
				wr.g.item_only = saved;
				// (The route's way to a class's own stop leaves the other classes where they were: they
				// come on to where the route goes on from, the Warrior's flight to Ratchet for The Affray.)
				if let Some(list) = gated.filter(|l| cx.route_travel && only_classes(Some(l)) && Ctx::only_races(Some(l)).is_none()) {
					if its.iter().any(|x| matches!(x.t, ItemT::Network | ItemT::Hearth)) {
						wr.left_behind(&list, from);
					}
				}
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
					// A v1 grind step the route does not grind at (it reaches the level on quests), in a
					// zone the route has left: not sent back there (A2: the Fungal Vale after the hearth
					// to Ratchet). In the zone the route is in, it stays (a player behind grinds there).
					let st = &cx.steps[*os];
					let goals: Vec<&Line> = st.lines.iter().filter(|l| l.kind == Kind::Goal && !is_head_ws(&l.text, "goto")).collect();
					let grind_only = !goals.is_empty() && goals.iter().all(|l| is_head_ws(&l.text, "level"));
					// (With the route's own legs, the route grinds where it means to: v1's grind step, and
					// its optional dungeon's note, go, A5.)
					if cx.route_travel && goals.iter().any(|l| is_head_ws(&l.text, "level")) && goals.iter().all(|l| is_head_ws(&l.text, "level") || is_head_ws(&l.text, "note")) {
						continue;
					}
					// (Over the sea from where the route is: a zone next door is a short way back.)
					let continent = |z: &Option<String>| -> Option<i64> {
						let map = cx.zone_ids.iter().find(|(_, n)| Some(n) == z.as_ref()).map(|(k, _)| *k)?;
						let p = cx.proj.point(map, 50.0, 50.0, Some(Frame::Era));
						p.wx.is_finite().then_some(p.c as i64)
					};
					let here = cx.w(wr.pos.or(wr.route_pt)).map(|p| p.c as i64).or_else(|| continent(&wr.g.zone));
					if grind_only && truthy(&st.zone) && here.is_some() && continent(&st.zone).is_some_and(|c| Some(c) != here) {
						continue;
					}
					// (v1's way into a zone, its goal left out, when the route is already there: the Great
					// Lift between two Mirage Raceway stops.)
					if cx.route_travel && st.way && truthy(&st.zone) && cx.w(wr.pos.or(wr.route_pt)).and_then(|h| cx.zone_name(Some(h.map))).as_ref() == st.zone.as_ref() {
						continue;
					}
					// (v1's bind stop at a town the route has already left, Ironforge's "the last guide binds
					// here" after the route flew on to Southshore's boat: the route binds where it means to.
					// Not walked back to.)
					let bind_only = cx.route_travel
						&& !st.lines.iter().any(|l| is_head_ws(&l.text, "only"))
						&& st.lines.iter().any(|l| is_head_ws(&l.text, "sethome"))
						&& st.lines.iter().filter(|l| l.kind == Kind::Goal).all(|l| re!(r"^\s+(sethome|getfp|goto|fly|hearth)\b").is_match(&l.text));
					if bind_only {
						let at = cx.w(st.lines.iter().find_map(|l| cx.line_pt(l)));
						let here = cx.w(wr.pos.or(wr.route_pt));
						let left = match (at, here) {
							(Some(a), Some(h)) => a.map != h.map || js_hypot(a.wx - h.wx, a.wy - h.wy) > ZONE_STEP_YD,
							// (Placed by its zone only.)
							(None, Some(h)) => truthy(&st.zone) && cx.zone_name(Some(h.map)).is_some_and(|z| Some(&z) != st.zone.as_ref()),
							_ => false,
						};
						if left {
							continue;
						}
					}
					// (A step with nothing for everyone, only some races' lines and a flight path the route
					// learns where it goes: those races' step, no walk there for the rest — v1's "To the
					// Undercity" for the Skyborne's Sylvanas between two Beren's Peril stops.)
					let has_only = st.lines.iter().any(|l| is_head_ws(&l.text, "only"));
					let race_gate: Option<Vec<String>> = (cx.route_travel && !has_only && only_for.is_none())
						.then(|| {
							let goals: Vec<&Line> = st.lines.iter().filter(|l| l.kind == Kind::Goal && !is_head_ws(&l.text, "goto") && !is_head_ws(&l.text, "getfp")).collect();
							let mut races: Vec<String> = Vec::new();
							for l in &goals {
								let list = re!(r"\sonly\s+([!A-Za-z,]+)").captures(split_comment(&l.text).0).map(|m| m.get(1).unwrap().as_str()).filter(|x| !only_classes(Some(x)))?;
								for r in Ctx::only_races(Some(list))? {
									if !races.contains(&r) {
										races.push(r);
									}
								}
							}
							(!races.is_empty()).then_some(races)
						})
						.flatten();
					let gated = race_gate.is_some();
					let only_for = race_gate.or(only_for);
					wr.come_back_to_step(*os);
					// (Everyone's step: the walk there. Not to a step of nothing but optional lines, or lines of
					// quests the route does not take: no one walks out for them, The Collector and Manhunt, H2.)
					let goals: Vec<&Line> = st.lines.iter().filter(|l| l.kind == Kind::Goal && !matches!(head_ws(&l.text), Some("goto" | "fly" | "hearth" | "note"))).collect();
					let side = !goals.is_empty() && goals.iter().all(|l| re!(r"\boptional\b").is_match(split_comment(&l.text).0) || quest_of(&l.text).is_some_and(|q| !in_route.contains(&q)));
					if cx.route_travel && !has_only && !gated && !side {
						let mut at = wr.pos;
						wr.walk_to_step(*os, &mut at);
						wr.pos = at;
					}
					// (A class's own step the route's order left away from its place: that class's way there.)
					let flown = if cx.route_travel { wr.class_way_to_step(*os) } else { None };
					wr.step_lines(*os, None, true, only_for.as_deref());
					if let Some((list, to)) = flown {
						for a in wr.away.iter_mut().filter(|a| a.0 == list && a.1.is_none()) {
							a.1 = Some(to.clone());
						}
					}
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
		// (Class accepts still held go on into the next guide, to the route's next pass by their
		// giver at their level; at the chain's end, all of them.)
		// (Not into a guide for other players: a start's class accept held into the shared guides is
		// lost with the canonical start's writing of them, D1.)
		if !wr.held.is_empty() {
			wr.flush_held(None, gi + 1 == ng || cx.guide_races[gi + 1] != cx.guide_races[gi]);
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
	// (Each quest task's first work point on the route, and the quest's first, for the area steps.)
	let mut task_pt: FxHashMap<(u32, Option<u32>), u32> = FxHashMap::default();
	for o in order.iter().filter(|o| o.t == OrderT::Task) {
		if let (Some(q), Some(p)) = (o.q, o.pt) {
			task_pt.entry((q, o.task)).or_insert(p);
			task_pt.entry((q, None)).or_insert(p);
		}
	}
	let notes_left = std::mem::take(&mut wr.notes_left);
	for (gi, (head, body)) in std::mem::take(&mut wr.done).into_iter().enumerate() {
		let left = notes_left.iter().filter(|(g, _)| *g == gi).flat_map(|(_, ls)| ls.iter().cloned());
		let all: Vec<String> = head.into_iter().chain(left).chain(body.into_iter().flatten()).collect();
		let v = post::no_dead_end_legs(all);
		let v = post::no_class_round_trips(v);
		let v = cx.services_at_npc(v);
		let steps = post::same_place_pieces(post::no_empty_steps(v));
		let text = steps.join("\n");
		let text = re!(r"\n{3,}").replace_all(&text, "\n\n").into_owned();
		files.push((chain[gi].clone(), text));
	}
	drop(wr);
	// A post-pass moves a line only into a guide whose players include its own's.
	let may = |dst: usize, src: usize| cx.covers(dst, src);
	let mut texts: Vec<String> = files.iter().map(|f| f.1.clone()).collect();
	post::fix_order(&mut texts, &in_route, &may);
	post::premature_class_turnins(&mut texts, &in_route);
	// (The route's own tasks too: one the guide leaves to its bag turn-in, the scourgestones, is still
	// worked where the route works it; its turn-in is not moved after the last line that gets the item.)
	let worked: FxHashSet<u32> = order.iter().filter(|o| o.t == OrderT::Task).filter_map(|o| o.q).chain(bag_worked.iter().copied()).collect();
	post::fix_item_turnins(&mut texts, data, world, &may, &worked, &in_route);
	post::tag_quest_collects(&mut texts, data, &in_route);
	let shared_files: Vec<bool> = (0..ng).map(|i| cx.shared(i)).collect();
	post::fix_hearths(&mut texts, &cx.route_races, &cx.other_races, &shared_files);
	post::dedupe_only(&mut texts, &faction_list);
	let sources: Vec<&str> = chain.iter().map(|f| inp.guides.get(f).map_or("", |s| s.as_str())).collect();
	post::no_riding(&mut texts, &sources);
	if cx.route_travel {
		post::no_walk_after_flight(&mut texts);
		post::one_service_line(&mut texts);
	}
	post::class_only_lines(&mut texts, data);
	if cx.route_travel {
		post::repeat_training(&mut texts);
		post::class_only_steps(&mut texts);
		for t in texts.iter_mut() {
			*t = post::class_trip_audience(t.split('\n').map(str::to_string).collect()).join("\n");
		}
		// (Twice: a hand-in moved up opens its follow-up there too, Aramis' Holy Light.)
		for _ in 0..2 {
			for (fi, q, only) in early_accepts(&cx, &mut texts, &order) {
				log.push(format!("early accept: {} {q} {only}", chain[fi]));
			}
		}
	}
	if cx.route_travel {
		for t in texts.iter_mut() {
			*t = area_work_steps(&cx, t.split('\n').map(str::to_string).collect(), &task_pt).join("\n");
			*t = same_npc_steps(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
			*t = same_place_steps(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
			*t = tips_follow_their_npc(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
			*t = npc_titles(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
			*t = re!(r"\n{3,}").replace_all(t, "\n\n").into_owned();
		}
	}
	// Last: nothing ahead of the hand-in of a quest it depends on.
	let route_q: FxHashSet<u32> = order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
	for (fi, q) in post::prereq_order(&mut texts, data, &route_q, &|dst, src| cx.guide_races[dst] == cx.guide_races[src]) {
		log.push(format!("after its prerequisite: {} {q}", chain[fi]));
	}
	if cx.route_travel {
		for t in texts.iter_mut() {
			*t = stale_skip_notes(&cx, t.split('\n').map(str::to_string).collect(), &route_q).join("\n");
		}
	}
	if cx.route_travel {
		for t in texts.iter_mut() {
			*t = dup_goto_steps(t.split('\n').map(str::to_string).collect()).join("\n");
		}
	}
	if cx.route_travel {
		for t in texts.iter_mut() {
			*t = empty_sections(t.split('\n').map(str::to_string).collect()).join("\n");
			*t = dup_tips(t.split('\n').map(str::to_string).collect()).join("\n");
		}
	}
	for t in texts.iter_mut() {
		if cx.route_travel {
			*t = hub_steps(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
			*t = sweep_goals(&cx, t.split('\n').map(str::to_string).collect()).join("\n");
		}
		*t = re!(r"\n{3,}").replace_all(t, "\n\n").into_owned();
	}
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
		cls: None,
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
	/// The guide being written (its index in the chain).
	file: usize,
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
	/// The inn the route's character is bound at.
	home: Option<usize>,
	first_piece: FxHashSet<usize>,
	/// (written guide, step) whose comment block and opening lines are written.
	pre_done: FxHashSet<(usize, usize)>,
	/// A guide's notes its first step left behind when it moved into another guide: (guide, lines),
	/// written after the guide's header.
	notes_left: Vec<(usize, Vec<String>)>,
	/// Where the first piece of each v1 step written so far is (the route's point).
	piece_at: FxHashMap<usize, u32>,
	/// The route's level at its last v1 line written.
	route_lvl: Option<f64>,
	/// Class accepts the route is not yet level for, and the lines of their quests after them: (the
	/// level needed, the giver's zone, the quests, the lines), written at the route's first later
	/// step in that zone at that level (the Paladins' Tome of Divinity, level 12, at Goldshire at 10).
	held: Vec<(f64, Option<String>, Vec<u32>, Vec<String>)>,
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
	/// v1 lines already written at another of the route's events (a buy where the route buys).
	skip: FxHashSet<Key>,
	g: GuideState,
}

impl Writer<'_, '_> {
	/// v1's steps waiting in front of the piece that lie in the zone of `at`: written now, on the way;
	/// those before them for a zone still `ahead` on the route's path wait for it.
	/// Returns whether one of them flies the route's `next` flight (v1's line then stands for it).
	fn flush_orphans_at(&mut self, at: &mut Option<u32>, next: Option<&crate::input::Leg>, ahead: &[String]) -> bool {
		let cx = self.cx;
		let next_fly: Option<String> = next.filter(|l| l.k.as_deref() == Some("fly")).and_then(|l| cx.world.nodes.get(l.to? as usize)).map(|n| n.name.clone());
		let mut v1_flies = false;
		let Some(z) = cx.w(*at).and_then(|p| cx.zone_name(Some(p.map))) else { return false };
		// (A class's own flight off (the Druids' Thunder Bluff trainer) waiting further on: written at the
		// flight master the route walks away from, not at the zeppelin dock it walks to, where no flight
		// master is.)
		let leaves_fm = next.is_some_and(|l| l.k.as_deref() != Some("fly")) && at.is_some() && cx.world.nodes.iter().any(|n| n.kind == "fp" && n.pt == *at);
		// (Only a flight this flight master flies: on its continent, not The Sepulcher from Orgrimmar.)
		let here_c = cx.w(*at).map(|p| p.c);
		let flies_off = |o: &(usize, usize, Option<String>, Option<Vec<String>>)| {
			let st = &cx.steps[o.1];
			let list = st.lines.iter().find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(&l.text, "")).to_string());
			let first_fly = st.lines.iter().find_map(|l| re!(r#"^\s+fly\s+"([^"]+)""#).captures(&l.text).map(|m| m[1].to_string()));
			let reachable = first_fly.and_then(|d| cx.fp_by_name(&d)).and_then(|d| cx.w(cx.world.nodes[d].pt)).is_some_and(|d| Some(d.c) == here_c);
			only_classes(list.as_deref()) && Ctx::only_races(list.as_deref()).is_none() && reachable
		};
		let last_zone = self.pending_orphans.iter().rposition(|o| o.2.as_deref() == Some(z.as_str()));
		let last_fm = if leaves_fm { self.pending_orphans.iter().rposition(flies_off) } else { None };
		// In order, up to the last one here (the steps before it go with it, but those for a place the
		// path reaches later).
		let Some(last) = last_zone.max(last_fm) else { return false };
		let mut now: Vec<(usize, usize, Option<String>, Option<Vec<String>>)> = Vec::new();
		let mut wait = Vec::new();
		for (k, o) in self.pending_orphans.drain(..=last).enumerate() {
			let later = k < last && o.2.as_deref().is_some_and(|oz| oz != z && ahead.iter().any(|a| a == oz)) && !(last_fm == Some(k));
			if later {
				wait.push(o);
			} else {
				now.push(o);
			}
		}
		self.pending_orphans.splice(0..0, wait);
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
			// v1's goto to this pier written since the last travel (the end of v1's Auberdine step, the
			// route doing more in Auberdine after it): this step is the way on, the last thing there (A15).
			let last_travel = self.g.body.iter().rposition(|l| l.as_deref().is_some_and(|l| re!(r#"^\s+(fly|hearth)\s|^\s+goto\s.*"(Boat|Zeppelin|Tram|Ship) to"#).is_match(l)));
			if let Some(k) = last_travel {
				let b = self.g.body[k].clone().unwrap();
				let pier = re!(r#"^\s+goto\s+([\d.]+),([\d.]+)\s+"(\w+) to"#).captures(&b).is_some_and(|m| m[1] == c[0] && m[2] == c[1] && &m[3] == kind);
				// (A goto in a step only some play, another class's own crossing, is theirs.)
				let step_at = self.g.body[..k].iter().rposition(|l| l.as_deref().is_some_and(|l| l.starts_with("step "))).unwrap_or(0);
				let for_some = self.g.body[step_at..k].iter().flatten().any(|l| is_head_ws(l, "only"));
				if pier && !for_some && line_only(&b).is_none() {
					self.g.body[k] = if self.g.item_only.is_empty() { None } else { Some(cx.others_only(&b)) };
				}
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
		// Always named: a step some characters skip (a class's trainer) may have moved the others'
		// zone context, and the goto's coordinates read on the step's zone.
		if let Some(z) = zn.as_deref().filter(|z| !z.is_empty()) {
			self.push(format!("  zone {z}"));
			self.g.zone = zn.clone();
		}
		self.push(format!("  goto {},{} \"{label}\"{}", c[0], c[1], c[3]));
	}

	fn travel_to(&mut self, a: Option<u32>, b: Option<u32>) {
		let cx = self.cx;
		// (The classes away come back to where the route goes on, not to where it leaves from: the
		// Mages and Warlocks via Goldshire's on the way to Rainer after a training stop, H4; the Dwarf
		// class steps in Ironforge not walked back out to Dun Morogh before everyone's walk into
		// Ironforge.)
		if cx.route_travel {
			self.come_back(b.or(a));
		}
		let (Some(pa), Some(pb)) = (cx.w(a), cx.w(b)) else { return };
		if pa.c != pb.c {
			if let Some(best) = cx.crossing(pa, pb) {
				self.goto_step(best.dep, &format!("{} to {}", best.kind, best.dest), false);
			}
			self.goto_step(b, &cx.zone_name(Some(pb.map)).unwrap_or_else(|| "Onward".into()), false);
		} else if pa.map != pb.map && js_hypot(pa.wx - pb.wx, pa.wy - pb.wy) > ZONE_STEP_YD {
			// (An island the route walks to, Feathermoon Stronghold off the Forgotten Coast: the flight
			// toward its boat, then the boat.)
			if cx.route_travel {
				if let Some((dep, arr)) = cx.island_boat(pb).filter(|&(dep, _)| cx.w(cx.world.nodes[dep].pt).is_some_and(|d| js_hypot(d.wx - pa.wx, d.wy - pa.wy) < js_hypot(pb.wx - pa.wx, pb.wy - pa.wy))) {
					if let Some((f0, f1)) = cx.best_flight(a, cx.world.nodes[dep].pt, &self.known) {
						let name = cx.world.nodes[f1].name.clone();
						self.fly_step(f0, &name);
					}
					let to = re!(r"(?i)\s*\((boat|zeppelin|tram)\)$").replace(&cx.world.nodes[arr].name, "").into_owned();
					self.goto_step(cx.world.nodes[dep].pt, &format!("Boat to {to}"), false);
					return;
				}
			}
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
		if cx.timed_buy.contains(&key) {
			return cx.buy_at(&l.text, cx.key_pt.get(&key).copied(), cx.buy_each.contains(&key));
		}
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

	/// v1's flight just written (for everyone) lands where `b` is (Vesprystus' quest flight to
	/// Auberdine, which the route takes by boat): the route writes no way of its own (#402, #403).
	fn v1_flew_to(&self, b: Pt) -> bool {
		let cx = self.cx;
		let n = self.g.body.len();
		self.g.body[n.saturating_sub(12)..]
			.iter()
			.filter_map(|l| l.as_deref())
			.filter(|l| cx.for_all_r(line_only(l)))
			.filter_map(|l| re!(r#"^\s+fly\s+"([^"]+)""#).captures(l))
			.any(|m| cx.fp_by_name(&m[1]).and_then(|d| cx.w(cx.world.nodes[d].pt)).is_some_and(|d| d.c == b.c && js_hypot(d.wx - b.wx, d.wy - b.wy) <= ZONE_STEP_YD))
	}

	/// The way to a step only some classes play is theirs (the Undercity leg before the class
	/// trainers' step, A9): its `only` on the legs written for it; -> the lines to put back after.
	/// A step for other races than some of the route's is not: the route's way stays its races' (the
	/// shared tail's riding stop on Kildar's Orc line, which a Troll travels too).
	fn class_legs(&mut self, kind: &PieceKind) -> Vec<String> {
		let saved = self.g.item_only.clone();
		if let PieceKind::Step { step, .. } = kind {
			let cx = self.cx;
			let st = &cx.steps[*step];
			let only = st.lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only"));
			let list = only.map(|o| trim(&re!(r"^\s+only\s+").replace(split_comment(&o.text).0, "")).to_string());
			let other_races = list.as_deref().is_some_and(|l| !only_classes(Some(l)) && Ctx::only_races(Some(l)).is_some() && !cx.for_all_r(Some(l)));
			if let (true, false, Some(o)) = (saved.is_empty(), other_races, only) {
				self.g.item_only = vec![o.text.clone()];
			}
		}
		saved
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
		// Where it lands: the steps after it read their goals there (v1's own fly steps name it).
		let landing = cx.fp_by_name(dest_name).and_then(|d| coords_re(&cx.coords_of(cx.world.nodes[d].pt))).and_then(|c| cx.zone_name(c[2].parse().ok()));
		if let Some(z) = landing.filter(|z| Some(z) != self.g.zone.as_ref()) {
			self.push(format!("  zone {z}"));
			// (A step some characters skip moves only theirs: the next step names its zone again.)
			self.g.zone = if self.g.item_only.is_empty() { Some(z) } else { None };
		}
	}

	/// The route's items before the step they happen on the way to (see apply-route.js writeItems).
	fn write_items(&mut self, its: &[Item], to_way: bool) {
		let cx = self.cx;
		for x in its {
			if x.t == ItemT::Bind {
				self.home = x.inn;
			}
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
							// v1's steps waiting at the inn (the next guide's Thelsamar bind after the hearth there),
							// before the way on to Searing Gorge, not walked back to after it.
							let mut at = inn;
							self.pos = inn;
							let ahead: Vec<String> = cx.zone_name(Some(b.map)).into_iter().collect();
							self.flush_orphans_at(&mut at, None, &ahead);
							let on = Item {
								t: ItemT::Network,
								inn: None,
								pt: None,
								inn_pt: None,
								used: None,
								returns: None,
								from: inn,
								to: x.to,
								node: None,
								legs: x.legs.clone(),
								gy: None,
								spot: None,
								npc: None,
							};
							self.write_items(&[on], to_way);
						}
					}
				}
				ItemT::Network if cx.route_travel && x.legs.as_ref().is_some_and(|l| !l.is_empty()) => {
					// The sim's own path: written as it is. (A path that starts on foot: the classes that
					// walked off follow it from where they are.)
					let walk_first = x.legs.as_ref().and_then(|l| l.first()).is_some_and(|l| !matches!(l.k.as_deref(), Some("fly") | Some("ride")));
					self.rejoin(x.from, walk_first);
					// (Unless v1's flight just written lands there: Vesprystus' quest flight, #402. Nor at a
					// guide's start when the guide before ends where the leg goes: the Skyborne isle's own walk
					// to the Crossroads, not again from the Mulgore lift in the Barrens guide.)
					let ended_there = !self.g.body.iter().flatten().any(|l| l.starts_with("step ")) && self.done.last().and_then(|d| self.last_place(&d.1)).zip(cx.w(x.to)).is_some_and(|(p, b)| p.c == b.c && js_hypot(p.wx - b.wx, p.wy - b.wy) <= ZONE_STEP_YD);
					if ended_there || cx.w(x.to).is_some_and(|b| self.v1_flew_to(b)) {
						self.pos = x.to;
						continue;
					}
					// (Where the characters are along the path: v1's steps waiting on the way are reached
					// from there, not from the path's end over the sea, A9.)
					self.pos = x.from;
					let mut at = x.from;
					// Consecutive flights are one (the flight master flies the hops: Shadowprey to Orgrimmar).
					let mut legs: Vec<crate::input::Leg> = Vec::new();
					for l in x.legs.as_ref().unwrap() {
						match (legs.last_mut(), l.k.as_deref()) {
							(Some(last), Some("fly")) if last.k.as_deref() == Some("fly") && last.to == l.from => last.to = l.to,
							_ => legs.push(l.clone()),
						}
					}
					// The zones each leg starts in, and the path's end: a v1 step waiting for a place the path
					// reaches later is written there, not taken along by a step for a place it reaches first
					// (the Orgrimmar trainer stays for Orgrimmar, not written at the Tirisfal dock before the
					// zeppelin to it because the Undead's riding step after it is in Tirisfal).
					let stop_zones: Vec<Option<String>> = {
						let mut p = at;
						let mut zs = Vec::with_capacity(legs.len() + 1);
						for l in &legs {
							zs.push(cx.w(p).and_then(|w| cx.zone_name(Some(w.map))));
							p = match l.k.as_deref() {
								Some("fly") => l.to.and_then(|b| cx.world.nodes.get(b as usize)).and_then(|n| n.pt),
								Some("ride") => l.ride.and_then(|r| cx.world.rides.get(r)).and_then(|r| r.b).and_then(|i| cx.world.nodes.get(i)).and_then(|n| n.pt),
								_ => l.node.and_then(|n| cx.world.nodes.get(n)).and_then(|n| n.pt).or(l.to).or(x.to),
							};
						}
						zs.push(cx.w(x.to).and_then(|w| cx.zone_name(Some(w.map))));
						zs
					};
					for (k, l) in legs.iter().enumerate() {
						self.pos = at;
						let ahead: Vec<String> = stop_zones[k + 1..].iter().flatten().cloned().collect();
						let start = at;
						// v1's steps waiting at this place on the way (Orgrimmar's trainer before the zeppelin).
						if self.flush_orphans_at(&mut at, Some(l), &ahead) {
							// v1's own line flies it.
							at = l.to.and_then(|b| cx.world.nodes.get(b as usize)).and_then(|n| n.pt);
							continue;
						}
						// The classes off on a detour of their own (a class step just written on the way) rejoin
						// before everyone's next leg, not after it (A9: the Druids' Thunder Bluff flight before
						// the walk into Tanaris), where it starts; on a walk only those that flew off.
						let walk = !matches!(l.k.as_deref(), Some("fly") | Some("ride"));
						self.rejoin(start, walk);
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
								// (A lift is part of the walk. A portal the route's last stop stands on is taken by
								// that stop, the quest's interact with it: the Skyborne Portal to Stormwind, A10.)
								let taken = r.kind == Some("portal") && x.from.is_some() && x.from == na.pt && at == na.pt;
								if r.kind != Some("lift") && !taken {
									let kind = match r.kind.unwrap_or("boat") {
										"zeppelin" => "Zeppelin",
										"tram" => "Tram",
										"portal" => "Portal",
										"exit" => "Leave Zephras Isle",
										_ => "Boat",
									};
									// (A portal's end, and Zephras Isle's way off, are named by its zone: not the
									// world's internal "(arrival)" node, A10.)
									let dest = if kind == "Portal" || kind == "Leave Zephras Isle" {
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
					self.pos = at;
					self.flush_orphans_at(&mut at, None, &[]);
					self.rejoin(x.to, true);
					// The walk on to the leg's end.
					if let (Some(a), Some(b)) = (cx.w(at), cx.w(x.to)) {
						if at != x.to && a.c == b.c && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
							self.goto_step(x.to, &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
						}
					}
					self.pos = x.to;
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
					// v1's flight just written lands where the route goes (Vesprystus' quest flight to
					// Auberdine, which the route takes by boat): no way of the route's own (#402, #403).
					if self.v1_flew_to(b) {
						continue;
					}
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
				ItemT::Deathskip => {
					// `die` at the graveyard's Spirit Healer (the arrow leads to him); the tip says where to
					// die, as a death elsewhere may send the player to another graveyard.
					let Some(g) = x.gy.and_then(|g| cx.world.graveyards.get(g)) else { continue };
					let healer = x.pt.or(g.pt);
					let (Some(name), Some(c)) = (g.name.clone(), coords_re(&cx.coords_of(healer))) else { continue };
					let zn = cx.zone_name(c[2].parse().ok());
					self.push("");
					self.push(format!("step Deathskip to {name}"));
					let extra = self.g.item_only.clone();
					for e in extra {
						self.push(e);
					}
					if let Some(z) = zn.as_deref().filter(|z| !z.is_empty()) {
						self.push(format!("  zone {z}"));
					}
					let mob = x.npc.and_then(|n| cx.data.npcs.get(&n)).and_then(|e| e.name.clone()).filter(|n| !n.is_empty());
					if let (Some(mob), Some(s)) = (mob, coords_re(&cx.coords_of(x.spot))) {
						let place = if s[2] == c[2] { String::new() } else { cx.zone_name(s[2].parse().ok()).map_or(String::new(), |z| format!(" in {z}")) };
						self.push(format!(
							"  tip Die to the mobs at {},{}{place} ({mob}): a death there sends you to this graveyard. Release your spirit and take the Spirit Healer's resurrection.",
							s[0], s[1]
						));
					}
					self.push(format!("  die \"{name}\" @{},{} map {}{}", c[0], c[1], c[2], c[3]));
					// (Players without deathskips pass the step, staying where they are: the writer's place
					// stays too, and the next step names its zone again.)
					self.g.zone = None;
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
		// (A step's comment block and opening lines once per written guide: copies of a guide's first
		// step written again in it do not repeat its header, F7.)
		let first = self.first_piece.insert(si) && self.pre_done.insert((self.g.file, si));
		if first {
			// (A guide's first step moved into another guide leaves its guide's notes behind, the
			// comment block above it: only its own section rule, `# ---- Darkshire`, comes along.)
			let first_of_guide = s.k == 0 || cx.steps[s.k - 1].file != s.file;
			let from = if first_of_guide && s.file != self.g.file { s.pre.iter().rposition(|p| p.starts_with("# --")).unwrap_or(s.pre.len()) } else { 0 };
			if from > 0 {
				self.notes_left.push((s.file, s.pre[..from].to_vec()));
			}
			for p in &s.pre[from..] {
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
		// (The route's level here, for v1's grind lines it does not name.)
		if let Some(l) = keys.into_iter().flatten().filter_map(|k| cx.key_lvl.get(k).copied()).reduce(f64::max) {
			self.route_lvl = Some(self.route_lvl.map_or(l, |r| r.max(l)));
		}
		// (Class accepts held for this level, in this step's zone: their own step before it.)
		if !self.held.is_empty() {
			let zone_here = s.zone.clone().or_else(|| s.zone_in.clone());
			self.flush_held(zone_here.as_ref(), false);
		}
		// A later piece of a v1 step that the route works far from the step's first piece (the Swoop
		// Gizzard out on the plains, not at v1's Thunderhorn well, A11) is named for where it is (its
		// area, else its target), not for v1's place: the title would send the player back there.
		let here = keys.and_then(|ks| ks.first()).and_then(|k| cx.key_pt.get(k).copied());
		if first {
			if let Some(p) = here {
				self.piece_at.insert(si, p);
			}
		} else if title == s.title {
			if let (Some(p0), Some(p1)) = (self.piece_at.get(&si).and_then(|&p| cx.w(Some(p))), cx.w(here)) {
				if p0.c == p1.c && js_hypot(p0.wx - p1.wx, p0.wy - p1.wy) > FAR_PIECE_YD {
					let area = cx.area_at.and_then(|a| a.at(p1.c, p1.wx, p1.wy)).filter(|a| !a.name.is_empty() && a.name != a.zone && !s.title.contains(&a.name)).map(|a| a.name);
					let target = || {
						let l = s.line(keys?.first()?.1)?;
						let m = re!(r"^\s+(collect|kill)\s+(\d+)\b").captures(split_comment(&l.text).0)?;
						let id: u32 = m[2].parse().ok()?;
						if &m[1] == "collect" { cx.data.items.get(&id)?.name.clone() } else { cx.data.npcs.get(&id)?.name.clone() }
					};
					if let Some(n) = area.or_else(target) {
						title = format!("step {n}");
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

	/// Where a written guide's last step leaves everyone: its last `getfp`'s flight master or `goto`
	/// (read in the step's zone) for everyone.
	fn last_place(&self, body: &[Option<String>]) -> Option<Pt> {
		let cx = self.cx;
		let lines: Vec<&str> = body.iter().flatten().map(String::as_str).collect();
		let start = lines.iter().rposition(|l| l.starts_with("step "))?;
		let step = &lines[start..];
		if step.iter().any(|l| is_head_ws(l, "only")) {
			return None;
		}
		let zone = lines[..=start].iter().chain(step.iter()).rev().find_map(|l| re!(r"^\s*zone\s+(.+?)\s*$").captures(l).map(|m| m[1].to_string()));
		for l in step.iter().rev() {
			if line_only(l).is_some() {
				continue;
			}
			if let Some(m) = re!(r#"^\s+getfp\s+"([^"]+)""#).captures(l) {
				return cx.fp_by_name(&m[1]).and_then(|f| cx.w(cx.world.nodes[f].pt));
			}
			if let Some(m) = re!(r"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)").captures(l) {
				let map = cx.zone_ids.iter().find(|(_, z)| Some(z) == zone.as_ref())?.0;
				let p = cx.proj.point(map, num(&m[1]), num(&m[2]), Some(Frame::Era));
				return p.wx.is_finite().then_some(Pt { c: p.c as i64, wx: p.wx, wy: p.wy, map });
			}
		}
		None
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
				// (Within one zone in a guide other races share: the step's own goals lead there; a
				// goto step for the route's races alone is a bare bounce between the others' steps,
				// the Orcs' "The Barrens" gotos in the Crossroads guide.)
				let same_zone_shared = a.map == b.map && !self.g.item_only.is_empty();
				if a.c == b.c && !same_zone_shared && (a.map != b.map || js_hypot(a.wx - b.wx, a.wy - b.wy) > ZONE_STEP_YD) {
					self.goto_step(Some(p0), &cx.zone_name(Some(b.map)).unwrap_or_else(|| "Onward".into()), true);
				}
			}
		}
		if let Some(&p1) = pts.last() {
			*at = Some(p1);
		}
	}

	/// A class's own v1 step (`only <classes>`) the route's order left away from its place: that
	/// class's way there when the step has none (Spirit Rise in Thunder Bluff written after the
	/// Crossroads), and the walk to the nearest flight master when the step flies from where none is
	/// (the Druids' Thunder Bluff flight after the Gelkis grind). -> (classes, flight path flown to)
	/// when it flies them there.
	fn class_way_to_step(&mut self, si: usize) -> Option<(String, String)> {
		const AT_FM_YD: f64 = 100.0;
		let cx = self.cx;
		let s = &cx.steps[si];
		let list = s.lines.iter().take_while(|l| l.kind != Kind::Goal).find(|l| is_head_ws(&l.text, "only")).map(|l| trim(&re!(r"^\s+only\s+").replace(split_comment(&l.text).0, "")).to_string())?;
		if !only_classes(Some(&list)) || Ctx::only_races(Some(&list)).is_some() {
			return None;
		}
		// (Only for classes with the route: one away on a detour of its own is somewhere this does not
		// know, a Druid gone up into Darnassus or off to Moonglade by its own spell.)
		let classes: Vec<&str> = list.split(',').map(trim).collect();
		if self.away.iter().any(|a| a.0.split(',').any(|c| classes.contains(&trim(c)))) {
			return None;
		}
		let from = self.pos.or(self.route_pt);
		let here = cx.w(from)?;
		let first = s.lines.iter().find(|l| l.kind == Kind::Goal)?;
		let n = self.g.body.len();
		let saved = std::mem::replace(&mut self.g.item_only, vec![format!("  only {list}")]);
		let mut out = None;
		if is_head_ws(&first.text, "fly") {
			if let Some(f) = cx.fp_near_known(from, &self.known) {
				if let Some(fp) = cx.w(cx.world.nodes[f].pt) {
					if fp.c == here.c && js_hypot(fp.wx - here.wx, fp.wy - here.wy) > AT_FM_YD {
						let name = cx.world.nodes[f].name.clone();
						self.goto_step(cx.world.nodes[f].pt, &format!("{name} flight master"), true);
					}
				}
			}
		} else if !s.lines.iter().any(|l| ["goto", "fly", "hearth"].iter().any(|h| is_head_ws(&l.text, h))) {
			// (Its place: its first located line, else the flight master of its zone, the Shamans'
			// Orgrimmar trainer.)
			let zone_fm = || {
				let z = s.lines.iter().find(|l| is_head_ws(&l.text, "zone")).map(|l| trim(&re!(r"^\s+zone\s+").replace(split_comment(&l.text).0, "")).to_string()).or_else(|| s.zone.clone())?;
				cx.world.nodes.iter().find(|n| n.kind == "fp" && cx.w(n.pt).and_then(|p| cx.zone_name(Some(p.map))).as_deref() == Some(z.as_str())).and_then(|n| n.pt)
			};
			let p0 = s.lines.iter().find_map(|l| cx.line_pt(l)).or_else(zone_fm);
			if let Some(b) = cx.w(p0) {
				if b.c == here.c && (b.map != here.map || js_hypot(b.wx - here.wx, b.wy - here.wy) > ZONE_STEP_YD) {
					// (A flight only: a walk this far is no way the player takes, and a place with no known
					// flight path near it, Moonglade, is reached by the class's own means.)
					if let Some((f0, f1)) = cx.best_flight(from, p0, &self.known) {
						let name = cx.world.nodes[f1].name.clone();
						self.fly_step(f0, &name);
						out = Some((list.clone(), name));
					}
				} else if b.c != here.c {
					// (Over the sea: the boat or zeppelin there, the Shamans' hop from Grom'gol to Orgrimmar;
					// a flight toward its dock first when it saves the walk.)
					if let Some(best) = cx.crossing(here, b) {
						if let Some((f0, f1)) = cx.best_flight(from, best.dep, &self.known) {
							let name = cx.world.nodes[f1].name.clone();
							self.fly_step(f0, &name);
						} else if let Some(d) = cx.w(best.dep).filter(|d| d.map != here.map && js_hypot(d.wx - here.wx, d.wy - here.wy) > ZONE_STEP_YD) {
							// (No flight there: the walk to the dock's zone, then the ride, the Undead Paladins'
							// walk from the Crossroads to Orgrimmar's tower.)
							if let Some(z) = cx.zone_name(Some(d.map)) {
								self.goto_step(best.dep, &z, true);
							}
						}
						self.goto_step(best.dep, &format!("{} to {}", best.kind, best.dest), true);
					}
				}
			}
		}
		self.g.item_only = saved;
		if self.g.body.len() != n {
			self.g.zone = None;
		}
		out
	}

	/// The held class accepts the route is now level for, in `zone`, each written as a step of its
	/// own at its giver; `all`: every one, level or not (the chain's end).
	fn flush_held(&mut self, zone: Option<&String>, all: bool) {
		let cx = self.cx;
		let lvl = self.route_lvl.unwrap_or(0.0);
		let (now, keep): (Vec<_>, Vec<_>) = std::mem::take(&mut self.held).into_iter().partition(|h| all || (h.0 <= lvl && (h.1.is_none() || h.1.as_ref() == zone)));
		self.held = keep;
		for (need, z, qs, lines) in now {
			// (The giver the step meets: the line's own `npc`, else one with a spawn in the step's zone,
			// else the quest's first: Tarshaw in Razor Hill for 1505, not Torm Ragetotem, T6.)
			let givers: &[u32] = qs.first().and_then(|q| cx.data.quests.get(q)).and_then(|r| r.start.as_ref()).map_or(&[], |s| &s.npc[..]);
			let line_npc = lines.first().and_then(|l| re!(r"\bnpc\s+(\d+)").captures(split_comment(l).0)).and_then(|m| m[1].parse::<u32>().ok());
			let map = z.as_ref().and_then(|z| cx.zone_ids.iter().find(|(_, n)| n == z).map(|(k, _)| *k));
			let in_zone = givers.iter().copied().find(|n| map.is_some_and(|m| cx.data.npcs.get(n).is_some_and(|e| e.spawns.contains_key(&m))));
			let pick = line_npc.or(in_zone).or(givers.first().copied());
			let giver = pick.and_then(|n| cx.data.npcs.get(&n)).and_then(|n| n.name.clone());
			self.push("");
			self.push(format!("step {}", giver.unwrap_or_else(|| "Class quest".into())));
			if z.is_some() && z != self.g.zone {
				self.push(format!("  zone {}", z.as_deref().unwrap()));
				self.g.zone = z;
			}
			// (Written before the route is level for it, at a guide's end: behind the level it needs.)
			if need > lvl {
				let only = lines.first().and_then(|l| line_only(l)).map_or(String::new(), |o| format!(" only {o}"));
				self.push(format!("  level {}{only}", need.ceil() as u32));
			}
			for l in lines {
				self.push(l);
			}
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
		// (A waypoint step, v1's goto to a cave's mouth: back to where the steps after it go, before it.)
		let to = s.lines.iter().find_map(|l| cx.line_pt(l)).or_else(|| {
			let way = s.lines.iter().filter(|l| l.kind == Kind::Goal).all(|l| is_head_ws(&l.text, "goto"));
			if !way {
				return None;
			}
			cx.steps[si + 1..].iter().take_while(|t| t.file == s.file).take(3).find_map(|t| t.lines.iter().find_map(|l| cx.line_pt(l)))
		});
		self.come_back(to);
	}

	/// The classes away come back to `to` before everyone's next leg; on a walk only those that flew
	/// off: those that walked off follow everyone's walk from where they are (v1's own Priest step in
	/// Orgrimmar, the Warrior's Affray on Fray Island), not back to where it starts first.
	fn rejoin(&mut self, to: Option<u32>, walk: bool) {
		if walk {
			self.away.retain(|a| a.1.is_some());
		}
		self.come_back(to);
	}

	/// The route's way just written was for `list`'s classes only: the others stay at `from`, away
	/// from the route, by the known flight master nearest it (else on foot), until they come on
	/// where the route goes on.
	fn left_behind(&mut self, list: &str, from: Option<u32>) {
		let cx = self.cx;
		let gone: Vec<&str> = list.split(',').map(trim).collect();
		let rest: Vec<String> = CLASSES.iter().filter(|c| !gone.contains(c)).map(|c| c.to_string()).collect();
		if rest.is_empty() {
			return;
		}
		let there = cx.fp_near_known(from, &self.known).filter(|&f| matches!((cx.w(from), cx.w(cx.world.nodes[f].pt)), (Some(a), Some(b)) if a.c == b.c));
		self.away.push((rest.join(","), there.map(|f| cx.world.nodes[f].name.clone())));
	}

	/// The classes away on their own detour come back to `to`, where the route goes on from: by the
	/// flight master nearest it, from the one they flew to (else on foot).
	/// The zone of the last step written so far for some of the classes `cl` only (`only Paladin` for
	/// `Paladin,Hunter`).
	fn last_zone_of(&self, cl: &str) -> Option<String> {
		let body: Vec<&str> = self.g.body.iter().flatten().map(String::as_str).collect();
		let mine: Vec<&str> = cl.split(',').map(trim).collect();
		let theirs = |l: &str| l.strip_prefix("  only ").is_some_and(|o| o.split(',').all(|c| mine.contains(&trim(c))));
		let s = (0..body.len()).rev().find(|&i| body[i].starts_with("step ") && body[i + 1..].iter().take_while(|l| !l.starts_with("step ")).any(|l| theirs(l)))?;
		body[s + 1..].iter().take_while(|l| !l.starts_with("step ")).find_map(|l| l.strip_prefix("  zone ").map(str::to_string))
	}

	fn come_back(&mut self, to: Option<u32>) {
		let cx = self.cx;
		if to.is_none() {
			return;
		}
		// Where the route goes on is over the sea: the classes rejoin it on the way there (the shared
		// zeppelin), not by a walk to the other continent (A9, the Undercity trainers).
		if let (Some(t), Some(p)) = (cx.w(to), cx.w(self.pos.or(self.route_pt))) {
			if t.c != p.c {
				self.away.clear();
				return;
			}
		}
		for (cl, there) in std::mem::take(&mut self.away) {
			let there_fm = there.as_deref().and_then(|t| cx.fp_by_name(t));
			// (Flown off to the other continent, the Druids in Darnassus: not flown back over the sea here.)
			if matches!((there_fm.and_then(|f| cx.w(cx.world.nodes[f].pt)), cx.w(to)), (Some(f), Some(t)) if f.c != t.c) {
				continue;
			}
			// (Gone to where the route goes on: they are there, the Dwarf class steps in Ironforge before
			// everyone's way into it. Flown: their flight master near it; walked: their last step in its
			// zone.)
			if matches!((there_fm.and_then(|f| cx.w(cx.world.nodes[f].pt)), cx.w(to)), (Some(f), Some(t)) if f.c == t.c && f.map == t.map && js_hypot(f.wx - t.wx, f.wy - t.wy) <= ZONE_STEP_YD) {
				continue;
			}
			if there.is_none() && cx.w(to).and_then(|t| cx.zone_name(Some(t.map))).is_some_and(|z| self.last_zone_of(&cl).as_deref() == Some(z.as_str())) {
				continue;
			}
			// (A flight path learnt at the place the route goes to is not known before it.)
			let known: FxHashSet<usize> = self.known.difference(&self.fresh_fps).copied().collect();
			// (Walked away: walked back.)
			let fm = if there.is_some() { cx.fp_near_known(to, &known) } else { None };
			let master = |i: usize| -> Option<(String, [String; 4])> { Some((cx.zone_name(cx.w(cx.world.nodes[i].pt).map(|p| p.map))?, coords_re(&cx.coords_of(cx.world.nodes[i].pt))?)) };
			// (They flew to the flight master nearest where the route goes on: they are there already,
			// not walked on to the route's point to fly back from it, the Shaman's Brine at Camp Taurajo.)
			if fm.is_some() && fm == there_fm {
				continue;
			}
			self.push("");
			// (Already nearer where the route goes on than that flight master: walked, the Paladins
			// flown from Thelsamar to Ironforge down to the gates, not flown back to Thelsamar first.)
			let d_to = |n: usize| match (cx.w(cx.world.nodes[n].pt), cx.w(to)) {
				(Some(a), Some(b)) if a.c == b.c => js_hypot(a.wx - b.wx, a.wy - b.wy),
				_ => f64::INFINITY,
			};
			let nearer = |f: usize| there_fm.is_some_and(|t| d_to(t) <= d_to(f));
			match fm.filter(|&f| Some(f) != there_fm && !nearer(f)) {
				Some(f) => {
					let name = cx.world.nodes[f].name.split(',').next().unwrap_or("").to_string();
					self.push(format!("step Back to {name}"));
					self.push(format!("  only {cl}"));
					if let Some((z, c)) = there_fm.and_then(master) {
						self.push(format!("  zone {z}"));
						self.push(format!("  goto {},{} \"{} flight master\"{}", c[0], c[1], cx.world.nodes[there_fm.unwrap()].name, c[3]));
					}
					self.push(format!("  fly \"{name}\""));
					// (The route goes on away from that flight master, in another zone or far: on to it, the
					// Paladins' Tome of Nobility from Stormwind back to Watcher Biggs in the Swamp.)
					if let (Some(fp), Some(t), Some(c)) = (cx.w(cx.world.nodes[f].pt), cx.w(to), coords_re(&cx.coords_of(to))) {
						if fp.c == t.c && (fp.map != t.map || js_hypot(fp.wx - t.wx, fp.wy - t.wy) > ZONE_STEP_YD) {
							let z = cx.zone_name(Some(t.map)).unwrap_or_default();
							self.push(format!("  zone {z}"));
							self.push(format!("  goto {},{} \"{z}\"{}", c[0], c[1], c[3]));
						}
					}
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
		if self.skip.contains(&l.key()) {
			return;
		}
		// v1's grind line the route has no level event at, with the route's own legs: the route writes
		// its own grinds where it grinds (level_ins); v1's would be a grind for nothing, re-levelled, with
		// its step's tip from elsewhere ("Grind to 51" with a Tanaris tip in Un'Goro, A5).
		if cx.route_travel && !cx.named.contains(&l.key()) && is_head_ws(&l.text, "level") {
			return;
		}
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
			None => {
				// v1's grind to a level the route reaches only later, on quests (the free route's Barrens
				// at 13 past v1's "level 20" step): a player behind catches up to where the route is,
				// not a grind ahead of it (six hours in the written walk).
				let t = self.placed(l);
				let ahead = re!(r"^\s+level\s+(\d+)\b").captures(&t).and_then(|m| m[1].parse::<f64>().ok()).zip(self.route_lvl).filter(|(n, r)| !cx.named.contains(&key) && r + 1.0 < *n);
				match ahead {
					Some((_, r)) => re!(r"^(\s+level\s+)\d+").replace(&t, format!("${{1}}{}", level_str(r))).into_owned(),
					None => t,
				}
			}
		});
		// A quest started by an item that only drops, at a low or unknown chance (Nibbled-On Book,
		// PR322): its collect and its accept, and the accepts of the quests after it in its chain (Book
		// Inventory), are optional, never a wait for the drop. (Their hand-ins and work stay: they wait
		// only for a player who holds the quest, Croaky's Head at Ridgepoint Tower, #221.)
		if let Some(t) = text.clone() {
			let code = split_comment(&t).0;
			if !re!(r"\boptional\b").is_match(code) {
				let rare_item = |id: u32| {
					cx.data.items.get(&id).is_some_and(|it| {
						let d = it.drops.as_ref();
						let npc = d.map_or(0, |d| d.npc.len());
						let obj = d.map_or(0, |d| d.object.len());
						npc > 0 && obj == 0 && it.vendors.as_ref().is_none_or(|v| v.is_empty()) && d.is_some_and(|d| d.npc.values().all(|c| c.as_f64().is_none_or(|c| c < RARE_START_PCT)))
					})
				};
				let starts = |id: u32| cx.data.quests.values().any(|q| q.start_items().contains(&id));
				fn rare_chain(cx: &Ctx, q: u32, depth: usize, rare_item: &dyn Fn(u32) -> bool) -> bool {
					let Some(r) = cx.data.quests.get(&q) else { return false };
					let own = !r.start_items().is_empty() && r.start.as_ref().is_some_and(|s| s.npc.is_empty() && s.object.is_empty()) && r.start_items().iter().all(|&i| rare_item(i));
					own || (depth < 6 && r.pre.iter().flatten().filter_map(|p| p.as_f64()).any(|p| rare_chain(cx, p.abs() as u32, depth + 1, rare_item)))
				}
				let rare = if let Some(m) = re!(r"^\s+collect\s+(\d+)\b").captures(code).filter(|_| !re!(r"\bquest\s+\d").is_match(code)) {
					m[1].parse::<u32>().ok().is_some_and(|id| rare_item(id) && starts(id))
				} else if re!(r"^\s+accept\s+\d").is_match(code) {
					quest_of(code).is_some_and(|q| rare_chain(cx, q, 0, &rare_item))
				} else {
					false
				};
				if rare {
					let tail = re!(r"\s--\s.*$").find(&t).map_or("", |m| m.as_str());
					text = Some(format!("{} optional{tail}", trim_end(code)));
				}
			}
		}
		// A class quest's line with no `only` of its own or its step's: its classes (Ogtinc's
		// Priest-only hand-in in a step written for everyone).
		if let Some(t) = text.clone() {
			// (The step as written: a piece of v1's Priest step may be written without its `only`, W-01.)
			let at = self.g.body.iter().rposition(|l| l.as_deref().is_some_and(|l| l.starts_with("step "))).unwrap_or(0);
			let step_gated = self.g.body[at..].iter().flatten().any(|x| is_head_ws(x, "only"));
			let mask = quest_of(&t).and_then(|q| cx.data.quests.get(&q)).and_then(|d| d.classes).filter(|m| *m > 0.0 && m.fract() == 0.0).map(|m| m as u32);
			let has_only = re!(r"\sonly\s+\S").is_match(split_comment(&t).0);
			if let (false, false, Some(m)) = (step_gated, has_only, mask) {
				let names: Vec<String> = forge_core::CLASSES.iter().filter(|c| m & c.bit != 0).map(|c| format!("{}{}", c.key[..1].to_uppercase(), &c.key[1..])).collect();
				if !names.is_empty() && names.len() < forge_core::CLASSES.len() {
					let code = split_comment(&t).0;
					let tail = re!(r"\s--\s.*$").find(&t).map_or("", |m| m.as_str());
					text = Some(format!("{} only {}{tail}", trim_end(code), names.join(",")));
				}
			}
		}
		// A line carried out of a step only some classes play keeps that step's `only` (the Warrior's
		// Speak with Thun'grim hand-in written at Camp Taurajo).
		if lsi != si {
			if let (Some(t), Some(o)) = (text.clone(), ls.lines.iter().take_while(|x| x.kind != Kind::Goal).find(|x| is_head_ws(&x.text, "only"))) {
				if line_only(&t).is_none() {
					let list = trim(&re!(r"^\s+only\s+").replace(&o.text, "")).to_string();
					let code = split_comment(&t).0;
					let tail = re!(r"\s--\s.*$").find(&t).map_or("", |m| m.as_str());
					text = Some(format!("{} only {list}{tail}", trim_end(code)));
				}
			}
		}
		let theirs = |t: &str| if cx.shared(l.file) && !cx.other_races.is_empty() { Some(cx.others_only(t)) } else { None };
		// Binds and hearths are the route's: v1's are the other races'.
		if let Some(t) = text.clone() {
			// (v1's bind at the inn the route's character is bound at already ticks at once: it stays,
			// so a player who starts at this guide binds before its hearth, #171.)
			// (Nor does v1's bind where the route binds at that inn on this line: v1's line, with its
			// innkeeper, is the route's.)
			let bind_here = |name: &str| cx.items_at_line.get(&key).is_some_and(|its| its.iter().any(|x| x.t == ItemT::Bind && cx.inn_name(x.inn) == Some(name)));
			let at_home = re!(r#"^\s+sethome\s+"([^"]+)""#).captures(&t).is_some_and(|m| (self.home.is_some() && cx.inn_name(self.home) == Some(&m[1])) || bind_here(&m[1]));
			// (A class's own hearth back to where everyone is bound is that class's way back from its
			// detour: the Shamans' hearth to Grom'gol after Islen Waterseer.)
			let class_home = step_list.is_some_and(|l| only_classes(Some(l)) && Ctx::only_races(Some(l)).is_none())
				&& re!(r#"^\s+hearth\s+"([^"]+)""#).captures(&t).is_some_and(|m| self.home.is_some() && cx.inn_name(self.home) == Some(&m[1]));
			if matches!(head_ws(&t), Some("sethome" | "hearth")) && line_only(&t).is_none() && cx.has_items && !cx.named.contains(&key) && !at_home && !class_home {
				text = theirs(&t);
			}
		}
		let transport = |t: &str| re!(r#"(?i)^\s+goto\s.*"(?:Boat|Zeppelin|Tram|Ship)\b[^"]*""#).is_match(t);
		// v1's accept or turn-in of a quest the route takes in its races' own guide: the other races'.
		if cx.others_dup.contains(&key) {
			if let Some(t) = text.clone().filter(|t| line_only(t).is_none()) {
				text = theirs(&t);
			}
		}
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
		// With the route's own legs, v1's flight for everyone to where the route already is ("fly
		// Crossroads" in the Crossroads step the route's flight just landed in, F8): nothing to fly.
		if cx.route_travel {
			if let Some(t) = text.clone() {
				let dest = re!(r#"^\s+fly\s+"([^"]+)""#).captures(&t).and_then(|m| cx.fp_by_name(&m[1])).and_then(|d| cx.w(cx.world.nodes[d].pt));
				if let (Some(d), Some(p), None) = (dest, cx.w(self.pos), line_only(&t)) {
					if cx.for_all_r(step_list) && d.c == p.c && js_hypot(d.wx - p.wx, d.wy - p.wy) <= FLY_FROM_YD {
						text = theirs(&t);
					}
				}
			}
		}
		// A class's own accept the route is not yet level for, and its quest's lines after it: held
		// for the route's first later step in this zone at that level.
		if cx.route_travel && !cx.named.contains(&key) {
			if let Some(t) = text.clone() {
				let code = split_comment(&t).0;
				let class_line = line_only(&t).or(step_list).is_some_and(|o| only_classes(Some(o)) && Ctx::only_races(Some(o)).is_none());
				let q = quest_of(&t);
				if let Some(h) = q.and_then(|q| self.held.iter_mut().find(|h| h.2.contains(&q))) {
					h.3.push(if line_only(&t).is_none() { step_list.map_or(t.clone(), |o| format!("{} only {o}{}", trim_end(code), re!(r"\s--\s.*$").find(&t).map_or("", |m| m.as_str()))) } else { t.clone() });
					return;
				}
				if let (true, Some(m)) = (class_line, re!(r"^\s+accept\s+(\d+)\b").captures(code)) {
					let need = m[1].parse::<u32>().ok().and_then(|q| cx.data.quests.get(&q)).and_then(|r| r.min_level);
					// (In a start's own guide before guides for other players, held would carry it into
					// them, lost with the canonical start's writing: it stays here, behind the level it
					// needs, the Dwarf Paladins' Tome of Divinity, D1.)
					let own_end = !cx.guide_races[s.file].is_empty() && cx.guide_races.get(s.file + 1).is_some_and(|n| *n != cx.guide_races[s.file]);
					if let (Some(need), Some(lvl), true) = (need, self.route_lvl, own_end) {
						if lvl < need && !self.g.body.iter().rev().take_while(|b| b.as_deref().is_none_or(|b| !b.starts_with("step "))).any(|b| b.as_deref().is_some_and(|b| is_head_ws(b, "level"))) {
							let only = line_only(&t).or(step_list).map_or(String::new(), |o| format!(" only {o}"));
							self.push(format!("  level {}{only}", need.ceil() as u32));
						}
					}
					if let (Some(need), Some(lvl), false) = (need, self.route_lvl, own_end) {
						if lvl < need {
							let line = if line_only(&t).is_none() { format!("{} only {}{}", trim_end(code), step_list.unwrap_or(""), re!(r"\s--\s.*$").find(&t).map_or("", |m| m.as_str())) } else { t.clone() };
							self.held.push((need, s.zone.clone().or_else(|| self.g.zone.clone()), vec![m[1].parse().unwrap()], vec![line]));
							return;
						}
					}
				}
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
					self.home = x.inn;
					let v1_bind = cx.for_all_r(line_only(&text)) && re!(r#"^\s+sethome\s+"([^"]+)""#).captures(&text).is_some_and(|m| cx.inn_name(x.inn) == Some(&m[1]));
					if let Some(name) = cx.inn_name(x.inn).filter(|_| !v1_bind) {
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
		// (The grind's target; a route without one wrote it as the level.)
		let (OrderT::Level, Some(k), Some(lvl)) = (o.t, o.key, o.target.or(o.lvl)) else { continue };
		// A grind that unlocks accepts (the last one, to 60, is the route's end: not shortened).
		let accepts: Vec<&Order> = order[i + 1..].iter().take_while(|x| x.t != OrderT::Level).filter(|x| x.t == OrderT::Accept).collect();
		let ok = !accepts.is_empty() && lvl < 59.0 && accepts.iter().all(|x| x.q.and_then(|q| data.quests.get(&q)).and_then(|r| r.min_level).is_none_or(|m| m <= lvl.floor()));
		if ok {
			out.insert(k, lvl);
		}
	}
	out
}

/// A grind top-up the route inserts (a `level` item with no v1 line, at its fractional `target`): a step
/// of its own at the route's point for it, the camp of the work before it, skipped by a player already
/// there (`when level<N`). Its tip says what it is for: the hand-ins after it, which finish the next
/// level. None for a grind v1 has a line for (written there) or one with no target.
fn level_ins(cx: &Ctx, order: &[Order], oi: usize) -> Option<Ins> {
	let o = &order[oi];
	let lvl = o.target.filter(|_| o.key.is_none())?;
	let n = level_str(lvl);
	// The camp: the objective worked last before it, its target by name.
	let work = order[..oi].iter().rev().find(|x| x.t == OrderT::Task);
	let target = work.and_then(|w| {
		let objs = &cx.world.quests[*cx.wq.get(&w.q?)?].objs;
		let obj = objs.iter().find(|x| x.task == w.task).or_else(|| objs.first())?;
		let id = obj.id?;
		let ents = match obj.kind.as_deref() {
			Some("item") => cx.data.items.get(&(id as u32)).and_then(|i| i.drops.as_ref()).map_or(Vec::new(), |d| d.npc.keys().filter_map(|n| cx.data.npcs.get(n)).collect()),
			Some("kill") => cx.targets("kill", id),
			_ => Vec::new(),
		};
		ents.into_iter().find_map(|e| e.name.clone()).filter(|s| !s.is_empty())
	});
	let pt = o.pt.or_else(|| work.and_then(|w| w.pt));
	let at = cx.coords_of(pt);
	let label = target.clone().unwrap_or_else(|| "Grind spot".into());
	let mut lines = vec![format!("  when level<{n}")];
	// The hand-ins it tops up for: the turn-ins that follow it, where they are.
	let hub = order[oi + 1..].iter().find(|x| x.t == OrderT::Turnin).and_then(|t| cx.w(t.pt)).and_then(|p| {
		cx.area_at.and_then(|a| a.at(p.c, p.wx, p.wy)).map(|a| a.name).filter(|s| !s.is_empty() && !s.starts_with("area ")).or_else(|| cx.zone_name(Some(p.map)))
	});
	let next = lvl.floor() as i64 + 1;
	lines.push(match &hub {
		Some(h) => format!("  tip Top up here to level {n} before the hand-ins at {h}: they take you to level {next}."),
		None => format!("  tip Top up here to level {n} before the hand-ins that follow: they take you to level {next}."),
	});
	if !at.is_empty() {
		lines.push(format!("  goto {} \"{label}\"", at.trim_start().trim_start_matches('@')));
	}
	lines.push(match &target {
		Some(t) => format!("  level {n}                          -- grind on {t}"),
		None => format!("  level {n}"),
	});
	Some(Ins { title: format!("Level {n}"), lines, map: cx.map_of_pt(pt) })
}

/// R4: `level N` as the route's grind target when the route reaches N's unlock at least a tenth of a level
/// earlier: `level 15.91` (whole percent; a share that rounds to 0% or 100% is the whole level).
pub fn level_line(text: &str, lvl: f64) -> String {
	let Some(m) = re!(r"^(\s+level\s+)(\d+)(\s.*)?$").captures(text) else { return text.to_string() };
	let n: f64 = m[2].parse().unwrap_or(0.0);
	if !(lvl < n - 0.1 + 1e-9 && lvl > n - 1.0) {
		return text.to_string();
	}
	format!("{}{}{}", &m[1], level_str(lvl), m.get(3).map_or("", |x| x.as_str()))
}

/// A level as a `level` line writes it: whole percent, a share that rounds to 0% or 100% the whole level.
fn level_str(lvl: f64) -> String {
	let floor = lvl.floor();
	let pct = ((lvl - floor) * 100.0).round() as i64;
	match pct {
		0 => format!("{}", floor as i64),
		100 => format!("{}", floor as i64 + 1),
		p if p % 10 == 0 => format!("{}.{}", floor as i64, p / 10),
		p => format!("{}.{p:02}", floor as i64),
	}
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

/// Consecutive steps that only work quest objectives (kill, collect, interact) at places where each
/// other's targets live too, by the route's points for them, become one step: everything there
/// as you meet it (the Barrens plains: plainstriders, raptors and zhevra, not one animal at a time).
fn area_work_steps(cx: &Ctx, lines: Vec<String>, task_pt: &FxHashMap<(u32, Option<u32>), u32>) -> Vec<String> {
	// (A target counts as there when it has a spawn this near the other's work point.)
	const TOGETHER_YD: f64 = 150.0;
	// (And the two work points no farther apart than this.)
	const AREA_YD: f64 = 700.0;
	// (A camp: a target with fewer spawns is a named mob or one object, worked on its own.)
	const CAMP_SPAWNS: usize = 3;
	struct Block {
		start: usize,
		end: usize,
		pt: Option<u32>,
		work: Vec<usize>,
		zone: Option<String>,
		/// The step's own `only` list (a shared guide's step for the route's races).
		only: Option<String>,
		/// Lines of objectives that ride along at their own point (one object, a race's own).
		riders: Vec<usize>,
		/// Its `label`.
		label: Option<String>,
	}
	let work_re = re!(r"^\s+(kill|collect|interact)\s+\d+\b.*?\bquest\s+(\d+)");
	let mut blocks: Vec<Block> = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let body = &lines[i + 1..j];
		let mut ok = true;
		let mut work = Vec::new();
		let mut pt = None;
		let mut zone = None;
		let mut only = None;
		let mut riders = Vec::new();
		let mut label = None;
		let mut rider_pt = None;
		let mut only_pt = None;
		// (The route's point for a work line's task, else for its quest's first. A line with no
		// objective number is the objective of its target: `collect 1129 quest 101` is the ghoul
		// fangs, not the quest's first task, the skeleton fingers across the forest.)
		let route_pt = |code: &str, q: &str| -> Option<u32> {
			let q = q.parse::<u32>().ok();
			let objs = q.and_then(|q| cx.wq.get(&q)).map_or(&[][..], |&wi| &cx.world.quests[wi].objs[..]);
			let oi = re!(r"\bquest\s+\d+\.(\d+)").captures(code).and_then(|o| o[1].parse::<usize>().ok()).map(|n| n.saturating_sub(1));
			let obj = match oi {
				Some(oi) => objs.iter().find(|x| x.oi() == oi),
				None => re!(r"^\s+(kill|collect|interact)\s+(\d+)\b").captures(code).and_then(|m| {
					let kind = match &m[1] {
						"kill" => "kill",
						"collect" => "item",
						_ => "object",
					};
					let id = m[2].parse::<f64>().ok();
					objs.iter().find(|x| x.kind.as_deref() == Some(kind) && x.id == id)
				}),
			};
			let task = obj.and_then(|x| x.task);
			q.and_then(|q| task.and_then(|t| task_pt.get(&(q, Some(t)))).or_else(|| task_pt.get(&(q, None))).copied())
		};
		for (k, l) in body.iter().enumerate() {
			if l.trim().is_empty() {
				continue;
			}
			let code = split_comment(l).0;
			if let Some(z) = re!(r"^\s+zone\s+(.+)$").captures(code) {
				zone = Some(trim(&z[1]).to_string());
				continue;
			}
			if let Some(o) = re!(r"^\s+only\s+(.+)$").captures(code) {
				only = Some(trim(&o[1]).to_string());
				continue;
			}
			if let Some(o) = re!(r"^\s+label\s+(\S+)\s*$").captures(code) {
				label = Some(o[1].to_string());
				continue;
			}
			// (An event objective at its own point, Bramblescar's `complete 4921 @…`, is done there too.)
			// (And a bag count of an item, `collect 5075 x1`, or an event: they ride along.)
			if re!(r"^\s+complete\s+\d+").is_match(code) || re!(r"^\s+collect\s+\d+(\s+x\d+)?(\s+optional)?\s*$").is_match(code) {
				continue;
			}
			if re!(r"^\s+(tip|note)\s").is_match(code) {
				continue;
			}
			// (An accept at the camp, the giver among the mobs: in its place among the goals.)
			if re!(r"^\s+accept\s+\d+(\s+optional)?\s*$").is_match(code) {
				continue;
			}
			match work_re.captures(code) {
				// (A camp, also one only some characters work, keeping its `only`: the Warlocks' and
				// the others' Vile Familiars, worked with the valley's other camps.)
				Some(m) if cx.work_spawns(code) >= CAMP_SPAWNS => {
					if !code.contains(" only ") {
						if pt.is_none() {
							pt = route_pt(code, &m[2]);
						}
					} else if only_pt.is_none() {
						only_pt = route_pt(code, &m[2]);
					}
					work.push(i + 1 + k);
				}
				// (A race's own single target or one object, Furlbrow's Wardrobe, rides along at its point.)
				Some(m) if code.contains(" only ") || cx.work_spawns(code) > 0 => {
					if rider_pt.is_none() && !code.contains(" only ") {
						rider_pt = route_pt(code, &m[2]);
					}
					riders.push(i + 1 + k);
				}
				_ => ok = false,
			}
		}
		let pt = pt.or(rider_pt).or(only_pt);
		// (A step whose zone line is not where the route works it, "... and Bugs" with `zone Stormwind
		// City` for the Swamp of Sorrows: left as it is.)
		let zone_here = zone.is_none() || cx.w(pt).and_then(|p| cx.zone_name(Some(p.map))) == zone;
		if ok && (!work.is_empty() || riders.iter().any(|&k| !lines[k].contains(" only "))) && pt.is_some() && zone_here {
			blocks.push(Block { start: i, end: j, pt, work, zone, only, riders, label });
		}
		i = j;
	}
	// Runs of blocks with only blank lines between.
	// (Section comments between them, "# ---- The Crossroads", go before the merged step; so do along
	// steps, "Blackrock Champion on the way", unless their list ends at one of the merged steps; so do
	// stops at an NPC on that ground handing in none of the group's quests: Guard Parker at Three
	// Corners between the gnolls and the thrashers, Abercrombie's shack by Raven Hill, A9.)
	let quest_re = re!(r"^\s+(accept|turnin)\s+(\d+)\s*$");
	let npc_stop = |k: usize, end: usize, quests: &FxHashSet<u32>, ground: &[Pt]| -> bool {
		let mut any = false;
		for x in lines[k + 1..end].iter().take_while(|x| !x.trim().is_empty()) {
			let code = split_comment(x).0;
			if re!(r"^\s+(tip|zone)\s").is_match(code) {
				continue;
			}
			let Some(m) = quest_re.captures(code) else { return false };
			let Some(q) = m[2].parse::<u32>().ok() else { return false };
			if &m[1] == "turnin" && quests.contains(&q) {
				return false;
			}
			let Some(&wi) = cx.wq.get(&q) else { return false };
			let wqq = &cx.world.quests[wi];
			let Some(p) = cx.w(if &m[1] == "accept" { wqq.giver } else { wqq.ender }) else { return false };
			if !ground.iter().any(|g| g.c == p.c && js_hypot(g.wx - p.wx, g.wy - p.wy) <= 2.0 * TOGETHER_YD) {
				return false;
			}
			any = true;
		}
		any
	};
	let blank_between = |a: &Block, b: &Block, labels: &[&str], quests: &FxHashSet<u32>, ground: &[Pt]| {
		let mut in_along = false;
		(a.end..b.start).all(|k| {
			let l = &lines[k];
			if is_step(l) {
				let body = lines[k + 1..b.start].iter().take_while(|x| !x.trim().is_empty());
				in_along = body.filter_map(|x| re!(r"^\s+along\b(?:\s+until\s+(\S+))?").captures(split_comment(x).0)).next().is_some_and(|m| m.get(1).is_none_or(|u| !labels.contains(&u.as_str())))
					|| npc_stop(k, b.start, quests, ground);
				return in_along;
			}
			if l.trim().is_empty() {
				in_along = false;
				return true;
			}
			in_along || l.starts_with('#')
		})
	};
	let mut groups: Vec<Vec<usize>> = Vec::new();
	for bi in 0..blocks.len() {
		if let Some(g) = groups.last_mut() {
			let a = &blocks[g[0]];
			let last = &blocks[*g.last().unwrap()];
			let b = &blocks[bi];
			let close = matches!((cx.w(a.pt), cx.w(b.pt)), (Some(p), Some(q)) if p.c == q.c && js_hypot(p.wx - q.wx, p.wy - q.wy) <= AREA_YD);
			// (A step with no zone line is in its work point's zone: the Ruins of Alterac's mages and
			// Strahnbrad's `zone Alterac Mountains` are one ground.)
			let zone_of = |blk: &Block| blk.zone.clone().or_else(|| cx.w(blk.pt).and_then(|p| cx.zone_name(Some(p.map))));
			let zone_ok = (b.zone.is_none() || zone_of(b) == zone_of(a)) && b.only == a.only;
			// (Each other's targets on the same ground: two of their spawns near the route's work
			// points for them within TOGETHER_YD; or the later one's targets on the earlier one's
			// ground in numbers, worked there too, not after a walk elsewhere: the eggs on the
			// makrura's beach.)
			let on_ground = |blk: &Block, at: Option<u32>| -> Vec<Pt> {
				let Some(p) = cx.w(at) else { return Vec::new() };
				blk.work.iter().chain(blk.riders.iter().filter(|&&k| !lines[k].contains(" only "))).flat_map(|&k| cx.work_spawn_pts(&lines[k])).map(|s| s.3).filter(|w| w.c == p.c && js_hypot(w.wx - p.wx, w.wy - p.wy) <= 2.0 * TOGETHER_YD).collect()
			};
			// (The group's ground so far, every step's.)
			let sa: Vec<Pt> = g.iter().flat_map(|&x| on_ground(&blocks[x], blocks[x].pt)).collect();
			let sb = on_ground(b, b.pt);
			let sb_here = on_ground(b, last.pt);
			let overlap = |x: &[Pt], y: &[Pt]| x.iter().any(|p| y.iter().any(|q| js_hypot(p.wx - q.wx, p.wy - q.wy) <= TOGETHER_YD));
			let both = close && overlap(&sa, &sb);
			// (One object needs one spawn there.)
			let here = sb_here.len() >= if b.work.is_empty() { 1 } else { CAMP_SPAWNS } && overlap(&sa, &sb_here);
			let labels: Vec<&str> = g.iter().chain(std::iter::once(&bi)).filter_map(|&x| blocks[x].label.as_deref()).collect();
			// (The group's quests, which a stop between may not hand in, and its ground and the next's.)
			let group_q: FxHashSet<u32> = g.iter().flat_map(|&x| blocks[x].work.iter().chain(blocks[x].riders.iter())).filter_map(|&k| work_re.captures(split_comment(&lines[k]).0).and_then(|m| m[2].parse::<u32>().ok())).collect();
			let ground: Vec<Pt> = sa.iter().chain(sb.iter()).copied().collect();
			if blank_between(last, b, &labels, &group_q, &ground) && zone_ok && (both || here) {
				let at = last.pt;
				g.push(bi);
				// (Worked on the earlier one's ground: its circuit is there.)
				if !both {
					blocks[bi].pt = at;
				}
				continue;
			}
		}
		groups.push(vec![bi]);
	}
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut at = 0;
	// (A single step: when it works two quests or more, its own goals in one search circuit too.)
	// (Some characters' own lines do not count: one camp for two classes' quests is one target.)
	let quests_of = |b: &Block| b.work.iter().filter(|&&k| !lines[k].contains(" only ")).filter_map(|&k| work_re.captures(split_comment(&lines[k]).0).and_then(|m| m[2].parse::<u32>().ok())).collect::<FxHashSet<u32>>().len();
	// (The labels of merged steps after the first's: references to them go to the merged step's.)
	let mut relabel: Vec<(String, String)> = Vec::new();
	for g in groups.iter().filter(|g| g.iter().any(|&b| !blocks[b].work.is_empty()) && (g.len() > 1 || quests_of(&blocks[g[0]]) > 1)) {
		let first = &blocks[g[0]];
		let last = &blocks[*g.last().unwrap()];
		out.extend(lines[at..first.start].iter().cloned());
		for w in g.windows(2) {
			let mut k = blocks[w[0]].end;
			while k < blocks[w[1]].start {
				if is_step(&lines[k]) {
					let e = (k + 1..blocks[w[1]].start).find(|&x| lines[x].trim().is_empty()).unwrap_or(blocks[w[1]].start);
					out.extend(lines[k..e].iter().cloned());
					out.push(String::new());
					k = e;
					continue;
				}
				if lines[k].starts_with('#') {
					out.push(lines[k].clone());
				}
				k += 1;
			}
		}
		let p = cx.w(first.pt);
		let area = p.and_then(|p| cx.area_at.and_then(|a| a.at(p.c, p.wx, p.wy))).map(|a| a.name).filter(|n| !n.is_empty()).or_else(|| p.and_then(|p| cx.zone_name(Some(p.map))));
		out.push(match area {
			Some(a) => format!("step {a}: kill these as you meet them"),
			None => lines[first.start].clone(),
		});
		let mut labels = g.iter().filter_map(|&b| blocks[b].label.clone());
		if let Some(keep) = labels.next() {
			out.push(format!("  label {keep}"));
			relabel.extend(labels.map(|l| (l, keep.clone())));
		}
		if let Some(o) = &first.only {
			out.push(format!("  only {o}"));
		}
		// (The step's zone, else its work point's: the goals' points read on it.)
		if let Some(z) = first.zone.clone().or_else(|| p.and_then(|p| cx.zone_name(Some(p.map)))) {
			out.push(format!("  zone {z}"));
		}
		let mut tips: Vec<&String> = Vec::new();
		for &b in g {
			for l in &lines[blocks[b].start + 1..blocks[b].end] {
				if re!(r"^\s+tip\s").is_match(l) && !tips.contains(&l) {
					tips.push(l);
				}
			}
		}
		out.extend(tips.into_iter().cloned());
		// (Every goal in written order, each with its own place; a goal two of the steps both list is
		// written once.)
		let mut seen: FxHashSet<String> = FxHashSet::default();
		for &b in g {
			for l in &lines[blocks[b].start + 1..blocks[b].end] {
				let code = trim_end(split_comment(l).0).to_string();
				if !l.trim().is_empty() && !re!(r"^\s+(zone|tip|only|label)\s").is_match(&code) && seen.insert(code) {
					out.push(l.clone());
				}
			}
		}
		out.push(String::new());
		at = last.end;
	}
	out.extend(lines[at..].iter().cloned());
	for (old, new) in &relabel {
		let r = regex::Regex::new(&format!(r"^(\s+(?:along\s+until|skipto|.*\bdone)\s+){}\b", regex::escape(old))).unwrap();
		for l in out.iter_mut() {
			if r.is_match(l) {
				*l = r.replace(l, format!("${{1}}{new}")).into_owned();
			}
		}
	}
	out
}

/// A named target (fewer spawns than a camp's) this many levels over a step's camps is worked last.
const HARD_LEVEL_GAP: f64 = 3.0;

/// A step's field goals (kill, collect, interact for a quest objective, for everyone, not optional; not
/// in a `loop` or `along` step) in the order a player sweeps them from where the step is entered: the
/// nearest target's ground first, then the nearest from there. A named target that is elite, or
/// HARD_LEVEL_GAP levels over the step's camps, goes last (Maggot Eye at 11 on the far hill of Garren's
/// Haunt, after the Rot Hides north of Brill, Fitz). Merged area steps are always swept; other steps
/// when the arrow would lead first to a goal more than the judge's ARROW_SLACK_YD farther than another
/// (`arrow-order`) or to a hard target before a camp. The goals of a quest with an `interact` keep their
/// order (the object first, then what it brings). A tip naming a target goes in its target's order.
fn sweep_goals(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	const CAMP_SPAWNS: usize = 3;
	// (A goal for a whole quest, `kill 423 quest 246` with no objective, is a field goal too: the
	// Lakeridge Highway's gnolls, poachers and thrashers, swept, not left in v1's order, A9.)
	let field_re = re!(r"^\s+(kill|collect|interact)\s+(\d+)\b.*?\bquest\s+(\d+)(?:\.\d+)?\b");
	let d = |a: Pt, b: Pt| if a.c == b.c { js_hypot(a.wx - b.wx, a.wy - b.wy) } else { f64::INFINITY };
	let at_zone = |zone: &Option<String>, x: f64, y: f64| -> Option<Pt> {
		let map = cx.zone_ids.iter().find(|(_, n)| Some(n) == zone.as_ref()).map(|(k, _)| *k)?;
		let p = cx.proj.point(map, x, y, Some(Frame::Era));
		p.wx.is_finite().then_some(Pt { c: p.c as i64, wx: p.wx, wy: p.wy, map })
	};
	let spawns_of = |line: &str| -> Vec<Pt> { cx.work_spawn_pts(line).into_iter().map(|s| s.3).collect() };
	let nearest = |pts: &[Pt], from: Pt| -> Option<(f64, Pt)> { pts.iter().map(|p| (d(from, *p), *p)).min_by(|a, b| a.0.total_cmp(&b.0)) };
	// (Where a line leaves the player: its coordinates, its NPC, its flight master or inn.)
	let place = |l: &str, zone: &Option<String>, here: Option<Pt>| -> Option<Pt> {
		let code = split_comment(l).0;
		if let Some(m) = re!(r"(?:^\s+goto\s+|@\s*)([\d.]+)\s*,\s*([\d.]+)").captures(code) {
			return at_zone(zone, num(&m[1]), num(&m[2]));
		}
		if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code) {
			let q = cx.data.quests.get(&m[2].parse::<u32>().ok()?)?;
			let e = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() }?;
			let [n] = e.npc.as_slice() else { return None };
			let pts = spawns_of(&format!("  kill {n}"));
			return match here {
				Some(h) => nearest(&pts, h).map(|x| x.1),
				None => pts.first().copied(),
			};
		}
		if let Some(m) = re!(r#"^\s+getfp\s+"([^"]+)""#).captures(code) {
			return cx.fp_by_name(&m[1]).and_then(|f| cx.w(cx.world.nodes[f].pt));
		}
		if let Some(m) = re!(r#"^\s+hearth\s+"([^"]+)""#).captures(code) {
			return cx.w(cx.inn_pt(&m[1]));
		}
		if field_re.is_match(code) {
			return here.and_then(|h| nearest(&spawns_of(code), h).map(|x| x.1));
		}
		None
	};
	// (A goal's target npcs: the mob, or the item's droppers that spawn.)
	let targets = |line: &str| -> Vec<&Entity> {
		let Some(m) = field_re.captures(split_comment(line).0) else { return Vec::new() };
		let id: u32 = m[2].parse().unwrap_or(0);
		match &m[1] {
			"kill" => cx.data.npcs.get(&id).into_iter().collect(),
			"collect" => cx.data.items.get(&id).and_then(|i| i.drops.as_ref()).map_or(Vec::new(), |dr| dr.npc.keys().filter_map(|n| cx.data.npcs.get(n)).filter(|e| !e.spawns.is_empty()).collect()),
			_ => Vec::new(),
		}
	};
	// (A target's level: a camp's its easiest dropper's, the Rot Hides' ichor from the 6s north of Brill
	// as well as Silverpine's 12s; a named target's its own.)
	let level = |line: &str, lo: bool| {
		let ls = targets(line).into_iter().filter_map(|e| e.level);
		if lo {
			ls.fold(f64::INFINITY, f64::min)
		} else {
			ls.fold(f64::NEG_INFINITY, f64::max)
		}
	};
	let mut out = lines.clone();
	let mut here: Option<Pt> = None;
	let mut zone: Option<String> = None;
	let mut i = 0;
	while i < lines.len() {
		if let Some(z) = re!(r"^zone\s+(.+?)\s*$").captures(&lines[i]) {
			zone = Some(z[1].to_string());
		}
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let body: Vec<usize> = (i + 1..j).collect();
		let has = |w: &str| body.iter().any(|&k| is_head_ws(&lines[k], w));
		for &k in &body {
			if let Some(z) = re!(r"^\s+zone\s+(.+?)\s*$").captures(split_comment(&lines[k]).0) {
				zone = Some(z[1].to_string());
			}
		}
		// (A quest taken in the step, its accept from an item a goal here brings, the Flute of Xavaric:
		// its goals stay where they are, after the accept, never swept ahead of it.)
		let accepted_here: Vec<String> = body.iter().filter_map(|&k| re!(r"^\s+accept\s+(\d+)\b").captures(split_comment(&lines[k]).0).map(|m| m[1].to_string())).collect();
		let field: Vec<usize> = body
			.iter()
			.copied()
			.filter(|&k| {
				let c = split_comment(&lines[k]).0;
				field_re.is_match(c) && !re!(r"\s(optional|only)\b").is_match(c) && !accepted_here.iter().any(|q| field_re.captures(c).is_some_and(|m| &m[3] == q))
			})
			.collect();
		let mut order: Option<Vec<usize>> = None;
		if let (false, false, true, Some(entry)) = (has("loop"), has("along"), field.len() >= 2, here) {
			let spawns: Vec<Vec<Pt>> = field.iter().map(|&k| spawns_of(&lines[k])).collect();
			let camp = |x: usize| cx.work_spawns(&lines[field[x]]) >= CAMP_SPAWNS;
			let camp_lvl = (0..field.len()).filter(|&x| camp(x)).map(|x| level(&lines[field[x]], true)).filter(|l| l.is_finite()).fold(f64::NEG_INFINITY, f64::max);
			let hard = |x: usize| {
				!camp(x)
					&& (targets(&lines[field[x]]).iter().any(|e| matches!(e.rank.map(|r| r as i64), Some(1..=3)))
						|| (camp_lvl.is_finite() && level(&lines[field[x]], false) >= camp_lvl + HARD_LEVEL_GAP))
			};
			let quest = |x: usize| field_re.captures(split_comment(&lines[field[x]]).0).map(|m| m[3].to_string());
			let kept: FxHashSet<String> = (0..field.len()).filter(|&x| re!(r"^\s+interact\s").is_match(&lines[field[x]])).filter_map(quest).collect();
			let merged = lines[i].ends_with(": kill these as you meet them");
			// (Runs of field lines with no other goal between: an accept or hand-in between stays where it
			// is, and so do the lines on each side of it, Yaw Sharpmane's hunts in turn.)
			let mut runs: Vec<Vec<usize>> = vec![vec![0]];
			for x in 1..field.len() {
				let apart = (field[x - 1] + 1..field[x]).any(|k| is_goal(split_comment(&lines[k]).0));
				if apart {
					runs.push(vec![x]);
				} else {
					runs.last_mut().unwrap().push(x);
				}
			}
			let mut ord: Vec<usize> = (0..field.len()).collect();
			let mut cur = entry;
			for run in &runs {
				// (A later run starts where the goal before it leaves the player.)
				let before = if run[0] == 0 { body[0]..field[0] } else { field[run[0] - 1] + 1..field[run[0]] };
				for k in before {
					if let Some(p) = place(&lines[k], &zone, Some(cur)) {
						cur = p;
					}
				}
				let start = cur;
				let dist0 = |x: usize| nearest(&spawns[x], start).map_or(f64::INFINITY, |n| n.0);
				let off = run[1..].iter().any(|&x| dist0(run[0]) > dist0(x) + forge_judge::check::ARROW_SLACK_YD) || run.iter().enumerate().any(|(a, &x)| hard(x) && run[a + 1..].iter().any(|&y| !hard(y)));
				if run.len() < 2 || !(merged || off) {
					if let Some(p) = run.last().and_then(|&x| nearest(&spawns[x], cur)) {
						cur = p.1;
					}
					continue;
				}
				let mut swept: Vec<usize> = Vec::new();
				for last in [false, true] {
					let mut left: Vec<usize> = run.iter().copied().filter(|&x| hard(x) == last).collect();
					while !left.is_empty() {
						// (A quest with an `interact` goes in its own order.)
						let ok = |x: usize| quest(x).is_none_or(|q| !kept.contains(&q) || !left.iter().any(|&y| y < x && quest(y).as_ref() == Some(&q)));
						let near = |x: usize| nearest(&spawns[x], cur);
						let pi = (0..left.len()).filter(|&p| ok(left[p])).min_by(|&a, &b| near(left[a]).map_or(f64::INFINITY, |n| n.0).total_cmp(&near(left[b]).map_or(f64::INFINITY, |n| n.0))).unwrap_or(0);
						let x = left.remove(pi);
						if let Some((_, p)) = near(x) {
							cur = p;
						}
						swept.push(x);
					}
				}
				for (slot, x) in run.iter().zip(swept) {
					ord[*slot] = x;
				}
			}
			if ord.iter().enumerate().any(|(a, &b)| a != b) {
				order = Some(ord);
			}
		}
		if let Some(ord) = &order {
			for (slot, &x) in ord.iter().enumerate() {
				out[field[slot]] = lines[field[x]].clone();
			}
			// (The tips: one naming a target in its target's order; one naming none stays after the one before it.)
			let rank: Vec<usize> = (0..field.len()).map(|x| ord.iter().position(|&y| y == x).unwrap()).collect();
			let names: Vec<Vec<String>> = field
				.iter()
				.map(|&k| {
					let mut v: Vec<String> = targets(&lines[k]).iter().filter_map(|e| e.name.clone()).collect();
					if let Some(m) = re!(r"^\s+(collect|interact)\s+(\d+)\b").captures(split_comment(&lines[k]).0) {
						let id: u32 = m[2].parse().unwrap_or(0);
						let n = if &m[1] == "collect" { cx.data.items.get(&id).and_then(|i| i.name.clone()) } else { cx.data.objects.get(&id).and_then(|o| o.name.clone()) };
						v.extend(n);
					}
					v.into_iter().filter(|n| !n.is_empty()).map(|n| n.to_lowercase()).collect()
				})
				.collect();
			let tips: Vec<usize> = body.iter().copied().filter(|&k| is_head_ws(&lines[k], "tip")).collect();
			let mut key = 0usize;
			let mut keyed: Vec<(usize, usize, usize)> = Vec::new();
			for (n, &k) in tips.iter().enumerate() {
				let t = lines[k].to_lowercase();
				if let Some(r) = (0..field.len()).filter(|&x| names[x].iter().any(|nm| t.contains(nm.as_str()))).map(|x| rank[x]).min() {
					key = r;
				}
				keyed.push((key, n, k));
			}
			keyed.sort();
			for (slot, &(_, _, k)) in keyed.iter().enumerate() {
				out[tips[slot]] = lines[k].clone();
			}
		}
		// (Where the step leaves the player: its last placed line, its last goal in sweep order; a step
		// only some play, or along the way, leaves everyone where they were.)
		if !has("only") && !has("along") {
			for &k in &body {
				if let Some(p) = place(&out[k], &zone, here) {
					here = Some(p);
				}
			}
		}
		i = j;
	}
	out
}

/// Consecutive steps whose every goal is an accept or turn-in at one and the same NPC are one step,
/// the first's (Teeri's two steps on Zephras Isle, Valennia's three).
fn same_npc_steps(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	// (The NPC of a step: every goal an accept from it or a turn-in to it; None: some other goal.)
	let npc_of = |body: &[String]| -> Option<u32> {
		let mut npc: Option<u32> = None;
		let mut any = false;
		for l in body {
			let code = split_comment(l).0;
			if l.trim().is_empty() || re!(r"^\s+(tip|note)\s").is_match(code) {
				continue;
			}
			let m = re!(r"^\s+(accept|turnin)\s+(\d+)\s*(?:optional\s*)?$").captures(code)?;
			let q = cx.data.quests.get(&m[2].parse::<u32>().ok()?)?;
			let st = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() }?;
			let [n] = st.npc.as_slice() else { return None };
			if npc.is_some_and(|x| x != *n) {
				return None;
			}
			npc = Some(*n);
			any = true;
		}
		npc.filter(|_| any)
	};
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut i = 0;
	// (The NPC of the step last written and where its body ends in `out`.)
	let mut last: Option<(u32, usize)> = None;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			if !lines[i].trim().is_empty() {
				last = None;
			}
			out.push(lines[i].clone());
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let body: Vec<String> = lines[i + 1..j].to_vec();
		let n = npc_of(&body);
		match (n, last) {
			(Some(n), Some((m, end))) if n == m => {
				let add: Vec<String> = body.into_iter().filter(|l| !l.trim().is_empty()).collect();
				let k = add.len();
				out.splice(end..end, add);
				last = Some((m, end + k));
			}
			_ => {
				out.push(lines[i].clone());
				let end = out.len() + body.iter().take_while(|l| !l.trim().is_empty()).count();
				out.extend(body);
				last = n.map(|n| (n, end));
			}
		}
		i = j;
	}
	out
}

/// A step right after one with the same title, for the same characters, with no travel of its own
/// (comments and blank lines between), whose first placed goal stands within 200 yd of the other's,
/// is the same place: one step, the first's. Its tip's way in ("Follow the road east out of the
/// valley to Sen'jin Village") goes: the player is there. (Not the later pieces of v1's "Stormwind
/// class quests" at Agent Kearnen in Westfall or Rohan in Ironforge: titled alike, far apart.)
fn same_place_steps(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	const SAME_PLACE_YD: f64 = 200.0;
	let way_in = re!(r"^(Follow|Head|Go|Ride|Walk|Run|Return|Travel|Cross|Climb|Take the road)\b");
	// (Where a step's first placed goal stands: an accept's giver, a turn-in's ender, a target's spawn.)
	let place = |body: &[String]| -> Option<Pt> {
		body.iter().find_map(|l| {
			let code = split_comment(l).0;
			if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code) {
				let q = &cx.world.quests[*cx.wq.get(&m[2].parse().ok()?)?];
				return cx.w(if &m[1] == "accept" { q.giver } else { q.ender });
			}
			cx.work_spawn_pts(l).first().map(|s| s.3)
		})
	};
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	// (The title, `only` list, zone and place of the step last written, and where its body ends in `out`.)
	let mut last: Option<(String, Option<String>, Option<String>, usize, Option<Pt>)> = None;
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			if !lines[i].trim().is_empty() && !lines[i].starts_with('#') {
				last = None;
			}
			out.push(lines[i].clone());
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let body: Vec<String> = lines[i + 1..j].to_vec();
		let head_of = |w: &str| body.iter().find(|l| head_ws(l) == Some(w)).map(|l| trim(split_comment(l).0).to_string());
		let (only, zone) = (head_of("only"), head_of("zone"));
		// (Travel of its own: a way somewhere else. A search circuit, an along list or a condition: not
		// a step to add goals to, nor to add to another.)
		let travels = body.iter().any(|l| re!(r"^\s+(goto|fly|hearth|label)\b").is_match(l));
		let special = body.iter().any(|l| re!(r"^\s+(loop|along|when|skipto)\b").is_match(l));
		let here = place(&body);
		let near = |p: &Option<Pt>| matches!((p, &here), (Some(a), Some(b)) if a.c == b.c && js_hypot(a.wx - b.wx, a.wy - b.wy) <= SAME_PLACE_YD);
		let into = last.as_ref().filter(|(t, o, z, _, p)| *t == lines[i] && *o == only && (zone.is_none() || zone == *z) && !travels && !special && near(p)).map(|l| l.3);
		match into {
			Some(end) => {
				let add: Vec<String> = body
					.iter()
					.filter(|l| !l.trim().is_empty() && head_ws(l) != Some("zone") && head_ws(l) != Some("only"))
					.filter_map(|l| {
						if head_ws(l) != Some("tip") {
							return Some(l.clone());
						}
						let text = re!(r"^\s+tip\s+").replace(l, "").into_owned();
						let kept: Vec<&str> = split_sentences(&text).into_iter().filter(|s| !way_in.is_match(trim(s))).collect();
						(!kept.is_empty()).then(|| format!("  tip {}", kept.join(" ")))
					})
					.collect();
				let k = add.len();
				out.splice(end..end, add);
				if let Some(l) = last.as_mut() {
					l.3 = end + k;
				}
			}
			None => {
				out.push(lines[i].clone());
				let end = out.len() + body.iter().take_while(|l| !l.trim().is_empty()).count();
				out.extend(body);
				last = (!special).then(|| (lines[i].clone(), only, zone, end, here));
			}
		}
		i = j;
	}
	out
}

/// Consecutive steps at one hub (every goal an NPC's: an accept, a hand-in, a training, a bind, a
/// flight path, a vendor or a buy; the givers and enders linked within [`crate::hub::HUB_YD`]) for the
/// same characters are one visit: one step, the first's, its lines in the route's order (the hub
/// tour's sweep). The later steps' tips lose their way in, and an `along` list between them goes after
/// the visit (Brill's Burgess, Sevren and Terrence, written as four steps from v1's four, #740).
fn hub_steps(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	let way_in = re!(r"^(Follow|Head|Go|Ride|Walk|Run|Return|Travel|Cross|Climb|Take the road|Back)\b");
	// (A step's NPC points, None when a goal is not an NPC's.)
	let npc_pts = |body: &[String]| -> Option<Vec<Pt>> {
		let mut pts = Vec::new();
		for l in body {
			let code = split_comment(l).0;
			let Some(w) = head_ws(code) else { continue };
			if !is_goal(code) || w == "note" {
				continue;
			}
			match w {
				"accept" | "turnin" => {
					let m = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code)?;
					let q = &cx.world.quests[*cx.wq.get(&m[2].parse().ok()?)?];
					pts.push(cx.w(if &m[1] == "accept" { q.giver } else { q.ender })?);
				}
				"train" | "sethome" | "getfp" | "vendor" | "buy" | "goto" | "fly" | "hearth" => {}
				_ => return None,
			}
		}
		Some(pts)
	};
	let near = |a: &[Pt], b: &[Pt]| b.iter().all(|p| a.iter().any(|q| q.c == p.c && js_hypot(q.wx - p.wx, q.wy - p.wy) <= crate::hub::HUB_YD));
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	// The visit being written: its points, `only`, zone and where its body ends in `out`; `along` steps
	// held for after it.
	let mut cur: Option<(Vec<Pt>, Option<String>, Option<String>, usize)> = None;
	let mut held: Vec<String> = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			if !lines[i].trim().is_empty() && !lines[i].starts_with('#') {
				cur = None;
				out.append(&mut held);
			}
			if held.is_empty() {
				out.push(lines[i].clone());
			} else {
				held.push(lines[i].clone());
			}
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let body: Vec<String> = lines[i + 1..j].to_vec();
		let head_of = |w: &str| body.iter().find(|l| head_ws(l) == Some(w)).map(|l| trim(split_comment(l).0).to_string());
		let (only, zone) = (head_of("only"), head_of("zone"));
		// (An along list between two steps of the visit waits for its end.)
		if cur.is_some() && body.iter().any(|l| head_ws(l) == Some("along")) {
			held.extend(lines[i..j].iter().cloned());
			i = j;
			continue;
		}
		let own = body.iter().any(|l| re!(r"^\s+(goto|fly|hearth|label|loop|along|when|skipto)\b").is_match(l));
		let pts = npc_pts(&body);
		let into = match (&cur, &pts) {
			// (A step with no giver or ender of its own, a `buy nearest` at Ratchet, is not placed here.)
			(Some((at, o, z, end)), Some(p)) if !own && *o == only && (zone.is_none() || zone == *z) && !p.is_empty() && near(at, p) => Some(*end),
			_ => None,
		};
		match into {
			Some(end) => {
				let add: Vec<String> = body
					.iter()
					.filter(|l| !l.trim().is_empty() && head_ws(l) != Some("zone") && head_ws(l) != Some("only"))
					.filter_map(|l| {
						if head_ws(l) != Some("tip") {
							return Some(l.clone());
						}
						let text = re!(r"^\s+tip\s+").replace(l, "").into_owned();
						let kept: Vec<&str> = split_sentences(&text).into_iter().filter(|s| !way_in.is_match(trim(s))).collect();
						(!kept.is_empty()).then(|| format!("  tip {}", kept.join(" ")))
					})
					.collect();
				let k = add.len();
				out.splice(end..end, add);
				let c = cur.as_mut().unwrap();
				c.0.extend(pts.unwrap());
				c.3 = end + k;
			}
			None => {
				out.append(&mut held);
				out.push(lines[i].clone());
				let end = out.len() + body.iter().take_while(|l| !l.trim().is_empty()).count();
				out.extend(body.iter().cloned());
				// (A step that is not at the hub, or is someone else's, starts no visit.)
				let start = pts.filter(|p| !p.is_empty() && !body.iter().any(|l| re!(r"^\s+(loop|along|when|skipto)\b").is_match(l)));
				cur = start.map(|p| (p, only, zone, end));
			}
		}
		i = j;
	}
	out.append(&mut held);
	out
}

/// v1's note or tip sentence telling the player to skip a quest ("Rhapsody's cocktail needs parts
/// from Kalimdor: skip it", "his quest is not on this route") goes where the route takes that quest
/// (A10, H2-7: Rhapsody's 1452, Sprinkle's 2641, Whiskey Slim's grog). The quest: one the route
/// takes that an NPC the sentence names gives, not handed in in that step.
fn stale_skip_notes(cx: &Ctx, lines: Vec<String>, taken: &FxHashSet<u32>) -> Vec<String> {
	// ("Skip it" is about the step's own NPC: its quest the route takes there. "Not on this route" is
	// about the quest anywhere.)
	let skip_re = re!(r"(?i)\bskip (it|them)\b");
	let off_route_re = re!(r"(?i)\bnot on this route\b");
	// (An NPC's names a sentence may use: its full name, its first word of five letters or more.)
	let names_of = |n: u32| -> Vec<String> {
		let Some(name) = cx.data.npcs.get(&n).and_then(|x| x.name.clone()).filter(|x| !x.is_empty()) else { return Vec::new() };
		let first = name.split_whitespace().next().filter(|w| w.len() >= 5 && *w != name).map(str::to_string);
		std::iter::once(name).chain(first).collect()
	};
	let mut by_name: FxHashMap<String, Vec<u32>> = FxHashMap::default();
	for &q in taken {
		for &n in cx.data.quests.get(&q).and_then(|r| r.start.as_ref()).map_or(&[][..], |s| &s.npc[..]) {
			for nm in names_of(n) {
				by_name.entry(nm).or_default().push(q);
			}
		}
	}
	let mut out = lines;
	let mut i = 0;
	while i < out.len() {
		if !is_step(&out[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < out.len() && !is_step(&out[j]) && !starts_nonspace(&out[j]) {
			j += 1;
		}
		let handed: FxHashSet<u32> = out[i + 1..j].iter().filter_map(|l| re!(r"^\s+turnin\s+(\d+)\b").captures(l).and_then(|m| m[1].parse().ok())).collect();
		let accepted: FxHashSet<u32> = out[i + 1..j].iter().filter_map(|l| re!(r"^\s+accept\s+(\d+)\b").captures(l).and_then(|m| m[1].parse().ok())).collect();
		let mut k = i + 1;
		while k < j {
			let Some(m) = re!(r"^(\s+(?:note|tip)\s+)(.*)$").captures(&out[k]) else {
				k += 1;
				continue;
			};
			let (head, body) = (m[1].to_string(), m[2].to_string());
			let stale = |sen: &str| {
				let (here, anywhere) = (skip_re.is_match(sen), off_route_re.is_match(sen));
				(here || anywhere)
					&& by_name.iter().any(|(nm, qs)| {
						regex::Regex::new(&format!(r"\b{}\b", regex::escape(nm))).unwrap().is_match(sen) && qs.iter().any(|q| !handed.contains(q) && (anywhere || accepted.contains(q)))
					})
			};
			let sens = split_sentences(&body);
			// (A bare "Skip it." after a sentence that goes, goes with it.)
			let gone: Vec<bool> = sens.iter().scan(false, |prev, s| {
				let g = stale(s) || (*prev && re!(r"(?i)^\s*skip (it|them)\.?\s*$").is_match(s));
				*prev = g;
				Some(g)
			}).collect();
			if !gone.iter().any(|&g| g) {
				k += 1;
				continue;
			}
			let kept: Vec<&str> = sens.into_iter().zip(gone).filter(|(_, g)| !g).map(|(s, _)| s).collect();
			if kept.is_empty() {
				out.remove(k);
				j -= 1;
			} else {
				out[k] = format!("{head}{}", kept.join(" "));
				k += 1;
			}
		}
		i = j;
	}
	out
}

/// A section rule (`# ---- Menethil Harbor`) with no step under it, the next rule right after (blank
/// lines between), goes: its steps went elsewhere in the route (RevA1-3 A11, three rules in a row in
/// Ashenvale). A guide's last rule stays.
fn empty_sections(lines: Vec<String>) -> Vec<String> {
	let rule = |l: &str| l.starts_with("# --");
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	for (i, l) in lines.iter().enumerate() {
		// (The blank lines left are folded after.)
		if rule(l) && lines[i + 1..].iter().find(|x| !x.trim().is_empty()).is_some_and(|x| rule(x)) {
			continue;
		}
		out.push(l.clone());
	}
	out
}

/// A step's tip that another tip of the step already says, word for word at its start ("Captain
/// Stoutfist stands in Menethil Keep." beside "... Menethil Keep, a short walk from Karl Boran."), goes
/// (RevA1-3 A11: two pieces of v1's steps met in one).
fn dup_tips(lines: Vec<String>) -> Vec<String> {
	let tip_text = |l: &str| re!(r"^\s+tip\s+(.+?)\s*$").captures(l).map(|m| m[1].trim_end_matches('.').to_string());
	let mut drop: FxHashSet<usize> = FxHashSet::default();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let tips: Vec<(usize, String)> = (i + 1..j).filter_map(|k| tip_text(&lines[k]).map(|t| (k, t))).collect();
		for (a, ta) in &tips {
			// (Of two the same, the later goes.)
			if tips.iter().any(|(b, tb)| b != a && tb.starts_with(ta.as_str()) && (tb.len() > ta.len() || b < a)) {
				drop.insert(*a);
			}
		}
		i = j;
	}
	lines.into_iter().enumerate().filter(|(k, _)| !drop.contains(k)).map(|(_, l)| l).collect()
}

/// A step of nothing but one goto (and its zone) right before another such step to the same point
/// goes: the arrow is there already (Silverpine Forest twice at 45.6,42.4; "Durotar" then "Zeppelin to
/// Undercity" at one dock, F8). The later one stays, its label the more particular.
fn dup_goto_steps(lines: Vec<String>) -> Vec<String> {
	let goto_re = re!(r#"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)(\s+map\s+\d+)?(\s+live)?\s*("[^"]*")?\s*$"#);
	// (A step's body when it is one goto and at most a zone: (its end, the goto's point).)
	let lone_goto = |lines: &[String], i: usize| -> Option<(usize, String)> {
		if !is_step(&lines[i]) {
			return None;
		}
		let mut j = i + 1;
		let mut at = None;
		let mut zone = String::new();
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) && !lines[j].trim().is_empty() {
			let code = split_comment(&lines[j]).0;
			if let Some(m) = goto_re.captures(code) {
				if at.is_some() {
					return None;
				}
				at = Some(format!("{},{}{}{}", &m[1], &m[2], m.get(3).map_or("", |x| x.as_str()), m.get(4).map_or("", |x| x.as_str())));
			} else if is_head_ws(code, "zone") {
				zone = trim(code).to_string();
			} else {
				return None;
			}
			j += 1;
		}
		// (Both in one zone, named: the same point.)
		at.filter(|_| !zone.is_empty()).map(|a| (j, format!("{zone} {a}")))
	};
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut i = 0;
	while i < lines.len() {
		if let Some((end, at)) = lone_goto(&lines, i) {
			// (The next step, past blank lines only.)
			let mut n = end;
			while n < lines.len() && lines[n].trim().is_empty() {
				n += 1;
			}
			if n < lines.len() && lone_goto(&lines, n).is_some_and(|(_, b)| b == at) {
				i = n;
				continue;
			}
		}
		out.push(lines[i].clone());
		i += 1;
	}
	out
}

/// A step titled for an NPC none of its accepts and hand-ins is at, its first goal an accept or
/// hand-in at another NPC, is named for that NPC: a piece of v1's step the route split off, Deputy
/// Willem's accept in the step titled "Eagan Peltskinner" (RevHuman3 H7), Senator Mehr's and Frast's
/// in "Earthseer Farsen" (D5). (After the tips follow their NPCs: they find a split step's pieces by
/// its title.)
fn npc_titles(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	let npc_of = |l: &str| -> Option<u32> {
		let m = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(split_comment(l).0)?;
		let q = cx.data.quests.get(&m[2].parse::<u32>().ok()?)?;
		let e = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() }?;
		let [n] = e.npc.as_slice() else { return None };
		Some(*n)
	};
	let name = |n: u32| cx.data.npcs.get(&n).and_then(|e| e.name.clone()).filter(|x| !x.is_empty());
	// (A title that is an NPC's name.)
	let npc_names: FxHashSet<&str> = cx.data.npcs.values().filter_map(|e| e.name.as_deref()).collect();
	let mut out = lines.clone();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let titled = re!(r"^step\s+").replace(&lines[i], "").into_owned();
		let goals: Vec<&String> = lines[i + 1..j].iter().filter(|l| is_goal(l) && !matches!(head_ws(l), Some("goto" | "note"))).collect();
		let npcs: Vec<Option<u32>> = goals.iter().map(|l| npc_of(l)).collect();
		let at_titled = npcs.iter().flatten().any(|&n| name(n).as_deref() == Some(titled.as_str()));
		if let Some(Some(n)) = npcs.first() {
			if !at_titled && name(*n).is_some_and(|nm| nm != titled) && npc_names.contains(titled.as_str()) {
				out[i] = format!("step {}", name(*n).unwrap());
			}
		}
		i = j;
	}
	out
}

/// A tip clause of a split v1 step that names an NPC none of its piece's goals is at, while a later piece
/// of that step (the same title, later in the guide) has a goal at that NPC, goes with that piece: the
/// tip belongs to the goal there (#742: "Calvin ... wants a duel" stayed on the first piece, which holds
/// only Simmer's quest; the duel is taken after Brill). A clause is a sentence, or a part of one between
/// semicolons. A clause that also names one of its own piece's NPCs stays.
fn tips_follow_their_npc(cx: &Ctx, lines: Vec<String>) -> Vec<String> {
	let mut steps: Vec<(usize, usize)> = Vec::new();
	for i in 0..lines.len() {
		if is_step(&lines[i]) {
			let end = (i + 1..lines.len()).find(|&j| is_step(&lines[j]) || starts_nonspace(&lines[j])).unwrap_or(lines.len());
			steps.push((i, end));
		}
	}
	// (The NPCs a step's goals are at: its accepts' givers, its turn-ins' enders, a goal's `npc`.)
	let npcs_at = |(a, b): (usize, usize)| -> Vec<u32> {
		let mut out = Vec::new();
		for l in &lines[a + 1..b] {
			let code = split_comment(l).0;
			if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code) {
				if let Some(q) = m[2].parse::<u32>().ok().and_then(|q| cx.data.quests.get(&q)) {
					let ends = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() };
					out.extend(ends.map(|e| e.npc.clone()).unwrap_or_default());
				}
			}
			if is_goal(l) {
				out.extend(re!(r"\bnpc\s+(\d+)").captures_iter(code).filter_map(|m| m[1].parse::<u32>().ok()));
			}
		}
		out
	};
	let words_of = |text: &str| -> FxHashSet<String> { re!(r"[^A-Za-z']+").split(text).map(|w| w.strip_suffix("'s").unwrap_or(w).to_string()).filter(|w| !w.is_empty()).collect() };
	let name_words = |ids: &[u32]| -> FxHashSet<String> {
		ids.iter().filter_map(|id| cx.data.npcs.get(id).and_then(|e| e.name.clone())).flat_map(|n| words_of(&n)).filter(|w| w.len() >= 4 && w.starts_with(|c: char| c.is_ascii_uppercase())).collect()
	};
	let end_with_stop = |s: String| if s.ends_with(['.', '!', '?']) { s } else { format!("{s}.") };
	// (Line index -> its new text, None to drop it; step title line -> tips to add to it.)
	let mut set: FxHashMap<usize, Option<String>> = FxHashMap::default();
	let mut add: BTreeMap<usize, Vec<String>> = BTreeMap::new();
	// (A sentence's first letter up: "the Gallows' is ..." left by a clause that moved, U2.)
	let capital = |c: String| match c.get(..1) {
		Some(first) => format!("{}{}", first.to_uppercase(), &c[1..]),
		None => c,
	};
	for (k, &st) in steps.iter().enumerate() {
		// (Every tip line of the piece; and the other pieces of its step before it as well as after, U2.)
		let tis: Vec<usize> = (st.0 + 1..st.1).filter(|&j| head_ws(&lines[j]) == Some("tip")).collect();
		let later: Vec<usize> = (0..steps.len()).filter(|&k2| k2 != k && lines[steps[k2].0] == lines[st.0]).collect();
		if later.is_empty() {
			continue;
		}
		let own = npcs_at(st);
		let own_words = name_words(&own);
		for ti in tis {
			let body = re!(r"^\s+tip\s+").replace(&lines[ti], "").into_owned();
			let mut kept: Vec<String> = Vec::new();
			let mut moved = false;
			for sentence in split_sentences(&body) {
				let (mut stay, mut go): (Vec<&str>, Vec<(usize, &str)>) = (Vec::new(), Vec::new());
				for clause in sentence.split("; ") {
					let w = words_of(clause);
					let to = later.iter().copied().find(|&k2| {
						let theirs: Vec<u32> = npcs_at(steps[k2]).into_iter().filter(|n| !own.contains(n)).collect();
						let their_words = name_words(&theirs);
						let names_theirs = their_words.iter().any(|x| !own_words.contains(x) && w.contains(x));
						let names_own = own_words.iter().any(|x| !their_words.contains(x) && w.contains(x));
						names_theirs && !names_own
					});
					match to {
						Some(k2) => go.push((k2, clause)),
						None => stay.push(clause),
					}
				}
				if !stay.is_empty() {
					kept.push(end_with_stop(capital(stay.join("; "))));
				}
				for (k2, clause) in go {
					let c = end_with_stop(capital(clause.to_string()));
					// (Once: the piece there may say it already, Gordo's tip twice.)
					let there = (steps[k2].0 + 1..steps[k2].1).any(|j| head_ws(&lines[j]) == Some("tip") && lines[j].contains(c.trim_end_matches('.')));
					let e = add.entry(steps[k2].0).or_default();
					if !there && !e.contains(&c) {
						e.push(c);
					}
					moved = true;
				}
			}
			if moved {
				set.insert(ti, (!kept.is_empty()).then(|| format!("  tip {}", kept.join(" "))));
			}
		}
	}
	if add.is_empty() {
		return lines;
	}
	// (Into the piece's own tip, first, or a tip line of its own after its title's `only`/`zone`/`label`.)
	let mut before: BTreeMap<usize, String> = BTreeMap::new();
	for (title, tips) in add {
		let &(a, b) = steps.iter().find(|s| s.0 == title).unwrap();
		let text = tips.join(" ");
		match (a + 1..b).find(|&j| head_ws(&lines[j]) == Some("tip")) {
			Some(j) => {
				let old = set.get(&j).cloned().unwrap_or_else(|| Some(lines[j].clone()));
				let rest = old.map(|o| re!(r"^\s+tip\s+").replace(&o, "").into_owned()).filter(|r| !r.contains(&text));
				set.insert(j, Some(match rest {
					Some(r) => format!("  tip {text} {r}"),
					None => format!("  tip {text}"),
				}));
			}
			None => {
				let at = (a + 1..b).find(|&j| !matches!(head_ws(&lines[j]), Some("only" | "zone" | "label"))).unwrap_or(b);
				before.insert(at, format!("  tip {text}"));
			}
		}
	}
	let mut out = Vec::with_capacity(lines.len() + before.len());
	for (i, l) in lines.into_iter().enumerate() {
		if let Some(t) = before.remove(&i) {
			out.push(t);
		}
		match set.remove(&i) {
			Some(Some(t)) => out.push(t),
			Some(None) => {}
			None => out.push(l),
		}
	}
	out.extend(before.into_values());
	out
}

/// v1's accept of a quest the route does not take itself (a class's or race's own: Venya's imp quest,
/// Sarvis' scroll for Aramis), written where v1 had it, goes to the earliest step whose goals stand
/// within [`EARLY_YD`] of its giver where it is takeable: the route's level there is the quest's
/// minimum or more, its prerequisites are handed in before, and the step is for the same characters
/// (none `only`, or the line's own). Its `only` goes with it. Its hand-in then goes to the first step
/// after its accept and its work whose goals stand by its ender, when that is earlier. Returns the
/// accepts moved: (file, quest, the line's `only`).
fn early_accepts(cx: &Ctx, texts: &mut [String], order: &[Order]) -> Vec<(usize, u32, String)> {
	const EARLY_YD: f64 = 40.0;
	let route_acc: FxHashSet<u32> = order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| o.q).collect();
	let mut lvl_of: FxHashMap<(bool, u32), f64> = FxHashMap::default();
	for o in order {
		if let (Some(q), Some(l), true) = (o.q, o.lvl, matches!(o.t, OrderT::Accept | OrderT::Turnin)) {
			lvl_of.entry((o.t == OrderT::Accept, q)).or_insert(l);
		}
	}
	// (An NPC's spawns, when it stands in a few places only.)
	let npc_pts = |n: u32| -> Vec<Pt> {
		let Some(e) = cx.data.npcs.get(&n) else { return Vec::new() };
		let mut out = Vec::new();
		for (&map, sp) in &e.spawns {
			if sp.f.as_deref() == Some("l") {
				continue;
			}
			for p in &sp.pts {
				let c = |i: usize| p.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
				let w = cx.proj.point(map, c(0), c(1), Some(Frame::Era));
				if w.wx.is_finite() {
					out.push(Pt { c: w.c, wx: w.wx, wy: w.wy, map });
				}
			}
		}
		if out.len() > 3 { Vec::new() } else { out }
	};
	// (Where a line's NPC stands: its `npc`, else the quest's one giver or ender; a quest several NPCs
	// give, Report to Gryan Stoutmantle, names no place.)
	let ends = |line: &str, q: u32, giver: bool| -> Vec<Pt> {
		if let Some(n) = re!(r"\snpc\s+(\d+)").captures(split_comment(line).0).and_then(|m| m[1].parse::<u32>().ok()) {
			return npc_pts(n);
		}
		let Some(r) = cx.data.quests.get(&q) else { return Vec::new() };
		let e = if giver { r.start.as_ref() } else { r.end.as_ref() };
		match e.map(|e| e.npc.as_slice()) {
			Some([n]) => npc_pts(*n),
			_ => Vec::new(),
		}
	};
	let near = |a: &[Pt], b: &[Pt]| a.iter().any(|p| b.iter().any(|q| p.c == q.c && js_hypot(p.wx - q.wx, p.wy - q.wy) <= EARLY_YD));
	let acc_re = re!(r"^\s+accept\s+(\d+)\b");
	let tin_re = re!(r"^\s+turnin\s+(\d+)\b");
	let mut moved_all = Vec::new();
	let mut lvl = 1.0f64;
	let mut handed: FxHashSet<u32> = FxHashSet::default();
	for (fi, t) in texts.iter_mut().enumerate() {
		let lines: Vec<String> = t.split('\n').map(str::to_string).collect();
		// The steps: (title line, body end), and per step its places, `only`, whether it takes lines, and
		// the level and the quests handed in by its end.
		struct S {
			start: usize,
			end: usize,
			places: Vec<Pt>,
			only: Option<String>,
			open: bool,
			lvl: f64,
			handed: FxHashSet<u32>,
		}
		let mut steps: Vec<S> = Vec::new();
		let mut i = 0;
		while i < lines.len() {
			if !is_step(&lines[i]) {
				i += 1;
				continue;
			}
			let mut j = i + 1;
			while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
				j += 1;
			}
			let body = &lines[i + 1..j];
			let mut places = Vec::new();
			// (The step's own level: the lowest route level of its lines.)
			let mut own: Option<f64> = None;
			for l in body {
				let code = split_comment(l).0;
				if let Some(m) = acc_re.captures(code) {
					let q: u32 = m[1].parse().unwrap_or(0);
					places.extend(ends(l, q, true));
					if let Some(&v) = lvl_of.get(&(true, q)) {
						own = Some(own.map_or(v, |o: f64| o.min(v)));
					}
				} else if let Some(m) = tin_re.captures(code) {
					let q: u32 = m[1].parse().unwrap_or(0);
					places.extend(ends(l, q, false));
					if let Some(&v) = lvl_of.get(&(false, q)) {
						own = Some(own.map_or(v, |o: f64| o.min(v)));
					}
					handed.insert(q);
				}
			}
			let only = body.iter().find(|l| head_ws(l) == Some("only")).map(|l| trim(&re!(r"^\s+only\s+").replace(split_comment(l).0, "")).to_string());
			let open = !body.iter().any(|l| re!(r"^\s+(when|skipto|along|loop)\b").is_match(l));
			steps.push(S { start: i, end: j, places, only, open, lvl: own.unwrap_or(f64::INFINITY), handed: handed.clone() });
			i = j;
		}
		// (The level at a step is no more than at any later one: a line out of the route's order does not
		// raise it, 5680 at level 20 written in Silverpine at 16.)
		for si in (0..steps.len()).rev() {
			let next = steps.get(si + 1).map_or(f64::INFINITY, |n| n.lvl);
			steps[si].lvl = steps[si].lvl.min(next);
		}
		for s in steps.iter_mut() {
			if s.lvl.is_infinite() {
				s.lvl = lvl;
			}
			lvl = lvl.max(s.lvl);
		}
		// The moves: (line, to step, the line as written there).
		let mut moves: Vec<(usize, usize, String)> = Vec::new();
		let mut moved_q: FxHashMap<u32, usize> = FxHashMap::default();
		for (si, s) in steps.iter().enumerate() {
			if !s.open {
				continue;
			}
			for k in s.start + 1..s.end {
				let code = split_comment(&lines[k]).0;
				let Some(q) = acc_re.captures(code).and_then(|m| m[1].parse::<u32>().ok()) else { continue };
				if route_acc.contains(&q) || re!(r"\sitem\s+\d").is_match(code) {
					continue;
				}
				let Some(r) = cx.data.quests.get(&q) else { continue };
				let giver = ends(&lines[k], q, true);
				if giver.is_empty() {
					continue;
				}
				// (After a hand-in at its giver in its own step, v1's chain the data may not name: Cat Form
				// taken from Dendrite once the relics are in.)
				if (s.start + 1..k).any(|k2| tin_re.captures(split_comment(&lines[k2]).0).and_then(|m| m[1].parse::<u32>().ok()).is_some_and(|q2| near(&ends(&lines[k2], q2, false), &giver))) {
					continue;
				}
				let own_only = line_only(&lines[k]).map(str::to_string);
				let audience = own_only.clone().or_else(|| s.only.clone());
				let min = r.min_level.unwrap_or(1.0);
				let pre: Vec<i64> = r.pre.iter().flatten().filter_map(|v| v.as_i64()).collect();
				let pre_ok = |h: &FxHashSet<u32>| {
					let all = pre.iter().filter(|&&p| p > 0).all(|&p| h.contains(&(p as u32)));
					let any: Vec<i64> = pre.iter().filter(|&&p| p < 0).map(|p| -p).collect();
					all && (any.is_empty() || any.iter().any(|&p| h.contains(&(p as u32))))
				};
				let Some(to) = (0..si).find(|&ti| {
					let t = &steps[ti];
					t.open && (t.only.is_none() || t.only == s.only) && t.lvl >= min && pre_ok(&t.handed) && near(&t.places, &giver)
				}) else {
					continue;
				};
				let line = match (&own_only, &s.only) {
					(None, Some(so)) => {
						let tail = re!(r"\s--\s.*$").find(&lines[k]).map_or(String::new(), |m| m.as_str().to_string());
						format!("{} only {so}{tail}", trim_end(code))
					}
					_ => lines[k].clone(),
				};
				moves.push((k, to, line));
				moved_q.insert(q, to);
				moved_all.push((fi, q, audience.unwrap_or_default()));
			}
		}
		// Their hand-ins: the first step after the accept and the quest's work by the ender.
		for (si, s) in steps.iter().enumerate() {
			if !s.open {
				continue;
			}
			for k in s.start + 1..s.end {
				let code = split_comment(&lines[k]).0;
				let Some(q) = tin_re.captures(code).and_then(|m| m[1].parse::<u32>().ok()) else { continue };
				let Some(&acc) = moved_q.get(&q) else { continue };
				let work_re = regex::Regex::new(&format!(r"\bquest\s+{q}\b|^\s+complete\s+{q}\b")).unwrap();
				let last_work = steps.iter().position(|x| (x.start + 1..x.end).any(|y| work_re.is_match(split_comment(&lines[y]).0))).map_or(acc, |w| {
					steps.iter().rposition(|x| (x.start + 1..x.end).any(|y| work_re.is_match(split_comment(&lines[y]).0))).unwrap_or(w).max(acc)
				});
				let ender = ends(&lines[k], q, false);
				let Some(to) = (last_work..si).find(|&ti| {
					let t = &steps[ti];
					t.open && (t.only.is_none() || t.only == s.only) && near(&t.places, &ender)
				}) else {
					continue;
				};
				let line = match (line_only(&lines[k]), &s.only) {
					(None, Some(so)) => {
						let tail = re!(r"\s--\s.*$").find(&lines[k]).map_or(String::new(), |m| m.as_str().to_string());
						format!("{} only {so}{tail}", trim_end(code))
					}
					_ => lines[k].clone(),
				};
				moves.push((k, to, line));
			}
		}
		if moves.is_empty() {
			continue;
		}
		// Rewrite: moved lines go at the end of their step's body, in the order they came.
		let from: FxHashSet<usize> = moves.iter().map(|m| m.0).collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len());
		for (si, s) in steps.iter().enumerate() {
			let prev_end = if si == 0 { 0 } else { steps[si - 1].end };
			out.extend(lines[prev_end..s.start].iter().cloned());
			let kept: Vec<&String> = lines[s.start + 1..s.end].iter().enumerate().filter(|(k, _)| !from.contains(&(s.start + 1 + k))).map(|(_, l)| l).collect();
			let mut add: Vec<&(usize, usize, String)> = moves.iter().filter(|m| m.1 == si).collect();
			add.sort_by_key(|m| m.0);
			// (A step left with no goal goes, unless a label names it.)
			if add.is_empty() && !kept.iter().any(|l| is_goal(l) || head_ws(l) == Some("label")) && lines[s.start + 1..s.end].iter().any(|l| is_goal(l)) {
				continue;
			}
			out.push(lines[s.start].clone());
			let last_goal = kept.iter().rposition(|l| !l.trim().is_empty()).map_or(0, |p| p + 1);
			out.extend(kept[..last_goal].iter().map(|l| (*l).clone()));
			out.extend(add.into_iter().map(|m| m.2.clone()));
			out.extend(kept[last_goal..].iter().map(|l| (*l).clone()));
		}
		out.extend(lines[steps.last().map_or(0, |s| s.end)..].iter().cloned());
		*t = out.join("\n");
	}
	moved_all
}

#[cfg(test)]
mod tests {
	use super::*;

	fn v(xs: &[&str]) -> Vec<String> {
		xs.iter().map(|x| x.to_string()).collect()
	}

	#[test]
	fn a_section_rule_with_no_step_under_it_goes() {
		let lines: Vec<String> = ["step A", "  accept 1", "", "# ---- Menethil Harbor", "", "# ---- Back to Menethil", "", "# ---- Spoils", "", "step B", "  accept 2", "", "# ---- End"].iter().map(|s| s.to_string()).collect();
		let out = empty_sections(lines);
		assert_eq!(out.iter().filter(|l| l.starts_with("# --")).collect::<Vec<_>>(), ["# ---- Spoils", "# ---- End"]);
	}

	#[test]
	fn a_tip_another_tip_of_the_step_already_says_goes() {
		let lines: Vec<String> = ["step Menethil", "  accept 464", "  tip Captain Stoutfist stands in Menethil Keep, a short walk from Karl Boran.", "  accept 98190", "  tip Captain Stoutfist stands in Menethil Keep.", "  accept 98230", "", "step B", "  tip Captain Stoutfist stands in Menethil Keep.", "  accept 2"]
			.iter()
			.map(|s| s.to_string())
			.collect();
		let out = dup_tips(lines);
		assert_eq!(out.iter().filter(|l| l.contains("Stoutfist")).count(), 2, "{out:#?}");
		assert!(out.contains(&"  tip Captain Stoutfist stands in Menethil Keep, a short walk from Karl Boran.".to_string()));
	}

	#[test]
	fn a_lone_goto_step_before_one_to_the_same_point_goes() {
		// c13 Stonetalon (F8): "Silverpine Forest" twice at 45.6,42.4; "Durotar" then "Zeppelin to
		// Undercity" at one dock. Another zone's same numbers are another place.
		let lines = v(&[
			"step Durotar", "  zone Durotar", "  goto 50.8,13.5 \"Durotar\"", "",
			"step Zeppelin to Undercity", "  zone Durotar", "  goto 50.8,13.5 \"Zeppelin to Undercity\"", "",
			"step Silverpine Forest", "  zone Silverpine Forest", "  goto 45.6,42.4 \"Silverpine Forest\"", "",
			"step Silverpine Forest", "  zone Silverpine Forest", "  goto 45.6,42.4 \"Silverpine Forest\"", "",
			"step Elsewhere", "  zone Tirisfal Glades", "  goto 45.6,42.4 \"Elsewhere\"", "",
		]);
		let out = dup_goto_steps(lines);
		assert_eq!(out.iter().filter(|l| l.starts_with("step ")).cloned().collect::<Vec<_>>(), v(&["step Zeppelin to Undercity", "step Silverpine Forest", "step Elsewhere"]), "{out:#?}");
	}
}
