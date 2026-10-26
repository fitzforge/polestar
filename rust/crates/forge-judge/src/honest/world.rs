//! The honest playtest's world (honest:111-245): the data's lookups, built once for every persona ([`Ctx`]),
//! and one character's state ([`World`]).

use super::{Finding, HonestOpts, Kb, Persona};
use forge_guide::data::Data;
use forge_guide::js::V;
use rustc_hash::{FxHashMap, FxHashSet};
use std::cell::RefCell;
use std::rc::Rc;

/// An id as a map key (JS Map keys by `===`; ids are numbers, a missing one is its own key).
pub type Id = i64;
pub const NO_ID: Id = i64::MIN;

pub fn id_of(v: &V) -> Id {
	match v {
		V::Num(n) if n.is_finite() => *n as Id,
		_ => NO_ID,
	}
}

/// `x != null` for an id field.
pub fn has(v: &V) -> bool {
	!v.is_nullish()
}

/// A world point (planner geo.js `{ c, wx, wy }`).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Wpt {
	pub c: f64,
	pub wx: f64,
	pub wy: f64,
}

#[derive(Clone, Copy)]
struct Frame {
	c: f64,
	left: f64,
	right: f64,
	top: f64,
	bottom: f64,
}

/// planner/geo.js Geo over map-frames.json: the asked frame set (`e` Era, else live) first, then the other.
/// (core's Projector converts live spawns into the Era frame; the planner's Geo, which honest reads, does not.)
pub struct Geo {
	era: FxHashMap<Id, Frame>,
	live: FxHashMap<Id, Frame>,
}

impl Geo {
	pub fn new(frames: &V) -> Geo {
		let set = |v: V| -> FxHashMap<Id, Frame> {
			v.entries()
				.into_iter()
				.map(|(k, b)| {
					let n = |key: &str| b.get(key).num();
					(forge_guide::js::str_to_num(&k) as Id, Frame { c: n("c"), left: n("left"), right: n("right"), top: n("top"), bottom: n("bottom") })
				})
				.collect()
		};
		Geo { era: set(frames.get("era")), live: set(frames.get("forever")) }
	}

	pub fn to_world(&self, map: Id, x: f64, y: f64, era: bool) -> Option<Wpt> {
		let (a, b) = if era { (&self.era, &self.live) } else { (&self.live, &self.era) };
		let f = a.get(&map).or_else(|| b.get(&map))?;
		Some(Wpt { c: f.c, wx: f.top + (f.bottom - f.top) * (y / 100.0), wy: f.left + (f.right - f.left) * (x / 100.0) })
	}
}

pub fn dist(a: Option<Wpt>, b: Option<Wpt>) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.c == b.c => forge_core::js_hypot(a.wx - b.wx, a.wy - b.wy),
		_ => f64::INFINITY,
	}
}

/// The data's lookups, shared by every persona's play.
pub struct Ctx<'d> {
	pub data: &'d Data,
	pub geo: Geo,
	/// taxi nodes in data order, by id.
	pub nodes: Vec<V>,
	pub node_ix: FxHashMap<Id, usize>,
	/// item -> quests whose objectives ask for it (Object.values(data.quests) order).
	pub needing: FxHashMap<Id, Vec<Id>>,
	names: RefCell<Option<Rc<FxHashMap<String, Vec<Id>>>>>,
	/// npc -> (quest, item) of item-started quests whose starter the npc drops (kill's starters).
	pub starters: FxHashMap<Id, Vec<(Id, Id)>>,
	/// object -> items it drops (interact).
	pub object_items: FxHashMap<Id, Vec<Id>>,
	npc_pts: RefCell<FxHashMap<Id, Rc<Vec<Wpt>>>>,
	obj_pts: RefCell<FxHashMap<Id, Rc<Vec<Wpt>>>>,
	/// transport ends (Some world point each; JS skips none: an end without a frame is never near).
	pub docks: Vec<Option<Wpt>>,
}

fn key(id: Id) -> String {
	id.to_string()
}

impl<'d> Ctx<'d> {
	pub fn new(data: &'d Data) -> Ctx<'d> {
		let geo = Geo::new(&data.map_frames);
		let nodes = data.travel.get("taxi").get("nodes").items();
		let mut node_ix = FxHashMap::default();
		for (i, n) in nodes.iter().enumerate() {
			node_ix.insert(id_of(&n.get("id")), i);
		}
		let mut needing: FxHashMap<Id, Vec<Id>> = FxHashMap::default();
		let mut starters: FxHashMap<Id, Vec<(Id, Id)>> = FxHashMap::default();
		for q in data.quests.values() {
			let qid = id_of(&q.get("id"));
			for o in q.get("objectives").items() {
				if o.get("type").as_str() == Some("item") {
					needing.entry(id_of(&o.get("id"))).or_default().push(qid);
				}
			}
			for i in q.get("start").get("item").items() {
				let it = data.items.get(&i.to_js_string());
				let drops = it.get("drops").get("npc");
				if drops.is_obj() {
					for n in drops.keys() {
						starters.entry(forge_guide::js::str_to_num(&n) as Id).or_default().push((qid, id_of(&i)));
					}
				}
			}
		}
		let mut object_items: FxHashMap<Id, Vec<Id>> = FxHashMap::default();
		for (item, it) in data.items.entries() {
			let drops = it.get("drops").get("object");
			if drops.is_obj() {
				for o in drops.keys() {
					object_items.entry(forge_guide::js::str_to_num(&o) as Id).or_default().push(forge_guide::js::str_to_num(&item) as Id);
				}
			}
		}
		let mut ctx = Ctx {
			data,
			geo,
			nodes,
			node_ix,
			needing,
			names: RefCell::new(None),
			starters,
			object_items,
			npc_pts: RefCell::new(FxHashMap::default()),
			obj_pts: RefCell::new(FxHashMap::default()),
			docks: Vec::new(),
		};
		let mut docks = Vec::new();
		for t in data.travel.get("transports").items() {
			for end in [t.get("a"), t.get("b")] {
				if end.truthy() {
					docks.push(ctx.world(&end.get("map"), &end.get("x"), &end.get("y"), &end.get("f")));
				}
			}
		}
		ctx.docks = docks;
		ctx
	}

	/// `w.world(map, x, y, f)`: null without a map, x or y, or without a frame.
	pub fn world(&self, map: &V, x: &V, y: &V, f: &V) -> Option<Wpt> {
		if map.is_nullish() || x.is_nullish() || y.is_nullish() {
			return None;
		}
		self.geo.to_world(map.num() as Id, x.num(), y.num(), f.as_str() == Some("e"))
	}

	pub fn quest(&self, q: Id) -> V {
		if q == NO_ID {
			V::Undef
		} else {
			self.data.quests.get(&key(q))
		}
	}
	pub fn item(&self, i: Id) -> V {
		if i == NO_ID {
			V::Undef
		} else {
			self.data.items.get(&key(i))
		}
	}
	pub fn npc(&self, n: Id) -> V {
		if n == NO_ID {
			V::Undef
		} else {
			self.data.npcs.get(&key(n))
		}
	}
	pub fn object(&self, o: Id) -> V {
		if o == NO_ID {
			V::Undef
		} else {
			self.data.objects.get(&key(o))
		}
	}

	fn id_str(v: &V) -> String {
		v.to_js_string()
	}

	pub fn title_of(&self, q: &V) -> String {
		let t = self.data.quests.get(&Self::id_str(q)).get("title");
		if t.truthy() {
			t.to_js_string()
		} else {
			format!("quest {}", q.to_js_string())
		}
	}
	pub fn item_name(&self, i: &V) -> String {
		let t = self.data.items.get(&Self::id_str(i)).get("name");
		if t.truthy() {
			t.to_js_string()
		} else {
			format!("item {}", i.to_js_string())
		}
	}
	pub fn npc_name(&self, n: &V) -> String {
		let t = self.data.npcs.get(&Self::id_str(n)).get("name");
		if t.truthy() {
			t.to_js_string()
		} else {
			format!("NPC {}", n.to_js_string())
		}
	}
	pub fn object_name(&self, o: &V) -> String {
		let t = self.data.objects.get(&Self::id_str(o)).get("name");
		if t.truthy() {
			t.to_js_string()
		} else {
			format!("object {}", o.to_js_string())
		}
	}

	pub fn zone_name(&self, map: &V) -> String {
		let z = self.data.zones.get(&map.to_js_string());
		let n = z.get("name");
		if z.truthy() && n.truthy() {
			n.to_js_string()
		} else {
			format!("map {}", map.to_js_string())
		}
	}

	/// NPC ids by lower-case name (Object.values(data.npcs) order).
	pub fn names(&self) -> Rc<FxHashMap<String, Vec<Id>>> {
		if let Some(n) = &*self.names.borrow() {
			return n.clone();
		}
		let mut m: FxHashMap<String, Vec<Id>> = FxHashMap::default();
		for n in self.data.npcs.values() {
			let name = n.get("name");
			let k = if name.truthy() { name.to_js_string().to_lowercase() } else { String::new() };
			if k.is_empty() {
				continue;
			}
			m.entry(k).or_default().push(id_of(&n.get("id")));
		}
		let rc = Rc::new(m);
		*self.names.borrow_mut() = Some(rc.clone());
		rc
	}

	fn spawn_pts(&self, rec: &V) -> Vec<Wpt> {
		let spawns = rec.get("spawns");
		let mut out = Vec::new();
		if !rec.truthy() || !spawns.truthy() {
			return out;
		}
		for (map, s) in spawns.entries() {
			let map = V::Num(forge_guide::js::str_to_num(&map));
			let f = s.get("f");
			for list in [s.get("pts"), s.get("more")] {
				for p in list.items() {
					if let Some(w) = self.world(&map, &p.at(0), &p.at(1), &f) {
						out.push(w);
					}
				}
			}
		}
		out
	}

	/// Yards from w to the nearest spawn of npc (Infinity without one on w's continent).
	pub fn npc_dist(&self, npc: Id, w: Option<Wpt>) -> f64 {
		let Some(w) = w else { return f64::INFINITY };
		let pts = {
			let cached = self.npc_pts.borrow().get(&npc).cloned();
			match cached {
				Some(p) => p,
				None => {
					let p = Rc::new(self.spawn_pts(&self.npc(npc)));
					self.npc_pts.borrow_mut().insert(npc, p.clone());
					p
				}
			}
		};
		pts.iter().map(|p| dist(Some(*p), Some(w))).fold(f64::INFINITY, |a, d| if d < a { d } else { a })
	}

	pub fn obj_dist(&self, obj: Id, w: Option<Wpt>) -> f64 {
		let Some(w) = w else { return f64::INFINITY };
		let pts = {
			let cached = self.obj_pts.borrow().get(&obj).cloned();
			match cached {
				Some(p) => p,
				None => {
					let p = Rc::new(self.spawn_pts(&self.object(obj)));
					self.obj_pts.borrow_mut().insert(obj, p.clone());
					p
				}
			}
		};
		pts.iter().map(|p| dist(Some(*p), Some(w))).fold(f64::INFINITY, |a, d| if d < a { d } else { a })
	}
}

/// A taxi node key or a flight path name (JS `known` holds node ids and unresolved locations).
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum NodeKey {
	Id(Id),
	Name(String),
	Other(String),
}

impl NodeKey {
	pub fn of(v: &V) -> NodeKey {
		match v {
			V::Num(n) => NodeKey::Id(*n as Id),
			V::Str(s) => NodeKey::Name(s.to_string()),
			v => NodeKey::Other(v.to_js_string()),
		}
	}
}

/// Where the character stands: the line's `{ map, x, y, f }` and its world point.
#[derive(Clone)]
pub struct Pos {
	pub map: V,
	pub x: V,
	pub y: V,
	pub f: V,
	pub w: Option<Wpt>,
}

/// A quest in the log.
pub struct Entry {
	pub credit: Vec<f64>,
	/// Index into `worked` at the accept.
	pub since: usize,
	/// Where it was accepted (R10): guide, file, line, step, title, reporting.
	pub at: Option<super::rules::At>,
}

impl Entry {
	pub fn get(&self, i: usize) -> f64 {
		self.credit.get(i).copied().unwrap_or(0.0)
	}
	pub fn set(&mut self, i: usize, v: f64) {
		if self.credit.len() <= i {
			self.credit.resize(i + 1, 0.0);
		}
		self.credit[i] = v;
	}
}

/// A worked goal (what the knowledge base's coverage reads).
pub struct Worked {
	pub t: String,
	pub quest: V,
	pub item: V,
	pub npc: V,
	pub object: V,
	pub from_id: V,
}

impl Worked {
	pub fn of(x: &V) -> Worked {
		Worked { t: x.get("t").to_js_string(), quest: x.get("quest"), item: x.get("item"), npc: x.get("npc"), object: x.get("object"), from_id: x.get("fromId") }
	}
}

pub struct World<'c, 'd> {
	pub ctx: &'c Ctx<'d>,
	pub persona: Persona,
	pub kb: Option<&'c Kb>,
	pub opts: HonestOpts,
	pub level: f64,
	/// The quest log in JS Map order (set on a held quest keeps its place).
	pub log: Vec<(Id, Entry)>,
	pub done: FxHashSet<Id>,
	pub bags: FxHashMap<Id, f64>,
	pub known: FxHashSet<NodeKey>,
	pub bound: V,
	pub pos: Option<Pos>,
	/// Bumped on each move (JS: a new `pos` object; the writer's trace compares them).
	pub pos_gen: u64,
	/// The goals played (playChain `trace`).
	pub trace: Option<Vec<super::TraceRow>>,
	pub travelled: Option<&'static str>,
	pub worked: Vec<Worked>,
	pub findings: Vec<Finding>,
	pub step: String,
	pub pos_step: String,
	/// Non-legacy rule state (R8-R10).
	pub rules: super::rules::State,
}

impl<'c, 'd> World<'c, 'd> {
	pub fn new(ctx: &'c Ctx<'d>, persona: Persona, kb: Option<&'c Kb>, opts: &HonestOpts) -> Self {
		World {
			ctx,
			persona,
			kb,
			opts: opts.clone(),
			level: 1.0,
			log: Vec::new(),
			done: FxHashSet::default(),
			bags: FxHashMap::default(),
			known: FxHashSet::default(),
			bound: V::Null,
			pos: None,
			pos_gen: 0,
			trace: None,
			travelled: None,
			worked: Vec::new(),
			findings: Vec::new(),
			step: String::new(),
			pos_step: String::new(),
			rules: Default::default(),
		}
	}

	/// Whether the character's faction can use taxi node n (1 Alliance, 2 Horde, else both).
	pub fn usable(&self, n: &V) -> bool {
		let side = match self.persona.faction.as_str() {
			"Alliance" => 1.0,
			"Horde" => 2.0,
			_ => 0.0,
		};
		let f = n.get("faction").as_num();
		side == 0.0 || (f != Some(1.0) && f != Some(2.0)) || f == Some(side)
	}

	/// The taxi node of a getfp or fly line: its `node`, else by name among the usable ones.
	pub fn node(&self, x: &V) -> Option<V> {
		let nd = x.get("node");
		if has(&nd) {
			if let Some(&i) = self.ctx.node_ix.get(&id_of(&nd)) {
				return Some(self.ctx.nodes[i].clone());
			}
		}
		let loc = x.get("location");
		let name = if loc.truthy() { loc.to_js_string().to_lowercase() } else { String::new() };
		self.ctx.nodes.iter().find(|n| self.usable(n) && (n.get("short").to_js_string().to_lowercase() == name || n.get("name").to_js_string().to_lowercase() == name)).cloned()
	}

	pub fn has(&self, item: Id, n: f64) -> bool {
		self.bags.get(&item).copied().unwrap_or(0.0) >= n
	}
	pub fn bag(&self, item: Id) -> f64 {
		self.bags.get(&item).copied().unwrap_or(0.0)
	}
	pub fn give(&mut self, item: &V, n: f64) {
		if has(item) {
			*self.bags.entry(id_of(item)).or_insert(0.0) += n;
		}
	}
	pub fn give_id(&mut self, item: Id, n: f64) {
		*self.bags.entry(item).or_insert(0.0) += n;
	}
	pub fn take(&mut self, item: Id, n: f64) {
		let v = (self.bag(item) - n).max(0.0);
		self.bags.insert(item, v);
	}

	pub fn held(&self, q: Id) -> bool {
		self.log.iter().any(|(k, _)| *k == q)
	}
	pub fn entry(&mut self, q: Id) -> Option<&mut Entry> {
		self.log.iter_mut().find(|(k, _)| *k == q).map(|(_, e)| e)
	}
	pub fn log_delete(&mut self, q: Id) {
		self.log.retain(|(k, _)| *k != q);
	}

	pub fn held_needing(&self, item: Id) -> bool {
		self.ctx.needing.get(&item).is_some_and(|qs| qs.iter().any(|q| self.held(*q)))
	}

	/// A goal tied to objective oi (1-based) of a held quest credits all of it (at least n).
	pub fn credit(&mut self, q: Id, oi: f64, n: f64) {
		let quest = self.ctx.quest(q);
		let Some(e) = self.entry(q) else { return };
		let i = oi as i64 - 1;
		if i < 0 {
			return;
		}
		let o = quest.get("objectives").at(i as usize);
		let count = o.get("count");
		let need = if o.truthy() && count.truthy() { count.num() } else { 1.0 };
		let i = i as usize;
		let v = (e.get(i) + n).max(need);
		e.set(i, v);
	}

	pub fn accepted(&mut self, q: Id, at: Option<super::rules::At>) {
		let entry = Entry { credit: Vec::new(), since: self.worked.len(), at };
		match self.log.iter_mut().find(|(k, _)| *k == q) {
			Some(slot) => slot.1 = entry,
			None => self.log.push((q, entry)),
		}
		let quest = self.ctx.quest(q);
		if quest.truthy() && quest.get("sourceItem").truthy() {
			let si = quest.get("sourceItem");
			self.give(&si, 1.0);
		}
		if !self.opts.legacy {
			super::rules::log_grew(self);
		}
	}
}
