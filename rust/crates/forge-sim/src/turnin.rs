//! Hand in while there: a quest finished within [`NEAR_YD`] of its ender is handed in before the
//! route walks [`AWAY_YD`] or more away, not on a trip back later (c19r Orc and Troll: Sarkoth 790
//! killed 150 yd from Hana'zua, handed in only after the Burning Blade Coven, 372 yd away and back;
//! the Troll route's own guide hands it in right after the valley loop).
//!
//! One reading of a walk, three callers: the planner's hub counts on its order (crate::hubs:
//! GuardCounts::finished_near, the hub sweep's `hand in while there` move), the judge's
//! `finished-near` rule on the written guides (forge-judge check/hub.rs), and `forge sim route
//! --audit` on written routes ([`audit_order`]). Each gives the walk as a [`Line`]: its stops, the
//! yards between them, when a hand-in is ready and the quest facts.
//!
//! Waiting is right, and the finding only a note ([`Wait`]), when
//! - a follow-up its ender gives with the hand-in needs a level the walk has not reached where the
//!   quest was finished (the player comes back for it anyway), or
//! - the route returns to the ender anyway (the hand-in's visit there does other work: an accept, a
//!   hand-in, a training, work within [`crate::hubs::HUB_YD`]) and handing in now costs a detour
//!   (more than [`NO_DETOUR_YD`]).
//!
//! Yards are straight (as the hub rules read them). An ender the walk cannot reach from where the
//! quest was finished is not near: where the pipeline has walks (the planner, the audit with a walk
//! store), a walk over [`REACH_YD`] between the two (a cliff, a wall) rules it out ([`Line::reach`];
//! c19r's Sarkoth kill to Hana'zua is 150 yd straight, 161 walked).

/// Yards from the ender within which a finished quest is handed in before the route goes on.
pub const NEAR_YD: f64 = 160.0;
/// The longest walk to the ender from where the quest was finished that is still near (half as long
/// again as NEAR_YD: a curve round a slope, not a way round a cliff).
pub const REACH_YD: f64 = 1.5 * NEAR_YD;
/// Yards from the ender that make going on a trip away (and the later hand-in a trip back).
pub const AWAY_YD: f64 = 300.0;
/// A detour this short is none: the ender is on the way.
pub const NO_DETOUR_YD: f64 = 1.0;
/// A finding where the quest was finished under this level is a blocker (routes 1-30), above it a
/// warning.
pub const BLOCKER_UNDER: f64 = 31.0;
/// Level slack for a follow-up's minimum (the replay's fractions only).
const LVL_EPS: f64 = 1e-6;

/// What a stop of the walk is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
	Accept,
	/// Quest work (an objective).
	Work,
	Turnin,
	/// Another stop at an NPC or a service (a training, an inn, a vendor).
	Npc,
	/// Travel (a goto, a flight master): where the walk is, nothing done there.
	Move,
	/// Not a place on the walk (a grind checkpoint, an along or optional goal, a note).
	None,
}

/// A walk as this rule reads it. Stops are indices `0..len()`.
pub trait Line {
	fn len(&self) -> usize;
	fn is_empty(&self) -> bool {
		self.len() == 0
	}
	fn kind(&self, i: usize) -> Kind;
	/// The stop's quest (0: none).
	fn quest(&self, i: usize) -> u32;
	/// Yards between two placed stops (infinite across continents or regions).
	fn yd(&self, a: usize, b: usize) -> f64;
	/// The walk from stop `a` reaches stop `b` (the ender) within [`REACH_YD`]; true where no walk is
	/// known.
	fn reach(&self, _a: usize, _b: usize) -> bool {
		true
	}
	/// Two placed stops are the same place (one NPC).
	fn same_place(&self, a: usize, b: usize) -> bool;
	/// The level after stop `i`.
	fn lvl_after(&self, i: usize) -> f64;
	/// The stop after which hand-in `j` is ready (its quest's last work, else its accept); None:
	/// not known to be ready before `j`.
	fn ready_after(&self, j: usize) -> Option<usize>;
	/// The quest's minimum level (0 when unknown).
	fn min_level(&self, q: u32) -> f64;
	/// Quest `f` follows quest `q` (q handed in opens it).
	fn follows(&self, f: u32, q: u32) -> bool;
}

/// Why waiting is right here.
#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Wait {
	/// Follow-up `q` accepted with the hand-in needs level `min`; the walk is at `lvl` where the
	/// quest was finished.
	Level { q: u32, min: f64, lvl: f64 },
	/// The route returns to the ender anyway (stop `other` of the hand-in's visit there), and
	/// handing in now walks `detour` yards more.
	Returns { other: usize, detour: f64 },
}

/// A hand-in made on a trip back: the quest was finished near its ender, and the route went away first.
#[derive(Clone, Debug, PartialEq)]
pub struct Near {
	/// The hand-in.
	pub j: usize,
	/// The accepts of its follow-ups at the same NPC right after it (they go with it).
	pub follow: Vec<usize>,
	/// The stop after which it was ready.
	pub ready: usize,
	/// The last stop within NEAR_YD of the ender before the route went away: hand in right after it.
	pub at: usize,
	/// The first stop AWAY_YD or more from the ender after that.
	pub away: usize,
	/// The farthest the route went from the ender before the hand-in (infinite: another continent).
	pub far: f64,
	pub wait: Option<Wait>,
}

impl Near {
	/// The walk's level where the quest was finished decides blocker or warning; a wait is a note.
	pub fn blocker(&self, l: &dyn Line) -> bool {
		self.wait.is_none() && l.lvl_after(self.at) < BLOCKER_UNDER
	}
}

fn placed(l: &dyn Line, i: usize) -> bool {
	l.kind(i) != Kind::None
}

/// The hand-ins of a walk made on a trip back, with why waiting is right where it is.
pub fn scan(l: &dyn Line) -> Vec<Near> {
	let n = l.len();
	let mut out: Vec<Near> = Vec::new();
	for j in 0..n {
		if l.kind(j) != Kind::Turnin {
			continue;
		}
		let Some(ready) = l.ready_after(j).filter(|&r| r < j) else { continue };
		let near = |k: usize| placed(l, k) && l.yd(k, j) <= NEAR_YD && l.reach(k, j);
		let Some(near_k) = (ready..j).find(|&k| near(k)) else { continue };
		let Some(away) = (near_k + 1..j).find(|&k| placed(l, k) && l.yd(k, j) >= AWAY_YD) else { continue };
		let at = (near_k..away).rev().find(|&k| near(k)).unwrap_or(near_k);
		let far = (at + 1..j).filter(|&k| placed(l, k)).map(|k| l.yd(k, j)).fold(0.0, f64::max);
		let q = l.quest(j);
		let follow = (j + 1..n).take_while(|&x| l.kind(x) == Kind::Accept && l.same_place(x, j) && l.follows(l.quest(x), q)).collect();
		out.push(Near { j, follow, ready, at, away, far, wait: None });
	}
	// The hand-ins on a trip back and their follow-ups: no reason for each other's trip.
	let mut own = vec![false; n];
	for x in &out {
		own[x.j] = true;
		for &f in &x.follow {
			own[f] = true;
		}
	}
	for x in &mut out {
		let lvl = l.lvl_after(x.at);
		if let Some(&f) = x.follow.iter().find(|&&f| l.min_level(l.quest(f)) > lvl + LVL_EPS) {
			x.wait = Some(Wait::Level { q: l.quest(f), min: l.min_level(l.quest(f)), lvl });
			continue;
		}
		// The hand-in's visit: the placed stops around it within HUB_YD of the ender.
		let at_ender = |k: usize| l.yd(k, x.j) <= crate::hubs::HUB_YD;
		let mut visit = Vec::new();
		for k in (0..x.j).rev().filter(|&k| placed(l, k)) {
			if !at_ender(k) {
				break;
			}
			visit.push(k);
		}
		for k in (x.j + 1..n).filter(|&k| placed(l, k)) {
			if !at_ender(k) {
				break;
			}
			visit.push(k);
		}
		let Some(other) = visit.into_iter().filter(|&k| !own[k] && l.kind(k) != Kind::Move).min() else { continue };
		let Some(nx) = (x.at + 1..n).find(|&k| placed(l, k)) else { continue };
		let detour = l.yd(x.at, x.j) + l.yd(x.j, nx) - l.yd(x.at, nx);
		if detour > NO_DETOUR_YD {
			x.wait = Some(Wait::Returns { other, detour });
		}
	}
	out
}

/// Straight yards between two world points of `world` (infinite across continents and regions).
pub fn world_yd(world: &forge_world::World, a: u32, b: u32) -> f64 {
	let (Some(pa), Some(pb)) = (world.points.get(a as usize), world.points.get(b as usize)) else { return f64::INFINITY };
	if pa.c != pb.c || pa.region != pb.region {
		return f64::INFINITY;
	}
	(pa.wx - pb.wx).hypot(pa.wy - pb.wy)
}

/// The walk store's walk from world point `a` to `b` is within REACH_YD (true where it has none).
pub fn world_reach(walks: Option<&dyn crate::Walks>, a: u32, b: u32) -> bool {
	walks.and_then(|w| w.yards(a, b)).filter(|&y| y >= 0.0).is_none_or(|y| y <= REACH_YD)
}

/// A written route's `order` (routes/<Start>.json: each entry's `t`, `q`, `pt` a world point and
/// `lvl` the level before it) as a [`Line`].
struct OrderLine<'a> {
	world: &'a forge_world::World,
	walks: Option<&'a dyn crate::Walks>,
	order: &'a [serde_json::Value],
	quests: rustc_hash::FxHashMap<u32, &'a forge_world::world::WQuest>,
}

impl OrderLine<'_> {
	fn pt(&self, i: usize) -> Option<u32> {
		self.order[i]["pt"].as_u64().and_then(|p| u32::try_from(p).ok())
	}
}

impl Line for OrderLine<'_> {
	fn len(&self) -> usize {
		self.order.len()
	}
	fn kind(&self, i: usize) -> Kind {
		if self.pt(i).is_none() {
			return Kind::None;
		}
		match self.order[i]["t"].as_str().unwrap_or("") {
			"accept" => Kind::Accept,
			"task" => Kind::Work,
			"turnin" => Kind::Turnin,
			"train" | "ride" | "visit" => Kind::Npc,
			_ => Kind::Move,
		}
	}
	fn quest(&self, i: usize) -> u32 {
		self.order[i]["q"].as_u64().and_then(|q| u32::try_from(q).ok()).unwrap_or(0)
	}
	fn yd(&self, a: usize, b: usize) -> f64 {
		match (self.pt(a), self.pt(b)) {
			(Some(x), Some(y)) => world_yd(self.world, x, y),
			_ => f64::INFINITY,
		}
	}
	fn reach(&self, a: usize, b: usize) -> bool {
		match (self.pt(a), self.pt(b)) {
			(Some(x), Some(y)) => world_reach(self.walks, x, y),
			_ => true,
		}
	}
	fn same_place(&self, a: usize, b: usize) -> bool {
		self.pt(a).is_some() && self.pt(a) == self.pt(b)
	}
	fn lvl_after(&self, i: usize) -> f64 {
		let lv = |k: usize| self.order.get(k).and_then(|e| e["lvl"].as_f64());
		lv(i + 1).or_else(|| lv(i)).unwrap_or(1.0)
	}
	fn ready_after(&self, j: usize) -> Option<usize> {
		let (q, kind) = (self.quest(j), |i: usize| self.order[i]["t"].as_str().unwrap_or(""));
		let acc = (0..j).rev().find(|&i| kind(i) == "accept" && self.quest(i) == q)?;
		Some((acc..j).rev().find(|&i| kind(i) == "task" && self.quest(i) == q).unwrap_or(acc))
	}
	fn min_level(&self, q: u32) -> f64 {
		self.quests.get(&q).map_or(0.0, |w| w.min_level)
	}
	fn follows(&self, f: u32, q: u32) -> bool {
		let (Some(fw), Some(qw)) = (self.quests.get(&f), self.quests.get(&q)) else { return false };
		fw.pre.contains(&i64::from(q)) || fw.pre_all.contains(&i64::from(q)) || qw.next.is_some_and(|n| n as u32 == f)
	}
}

/// One hand-in of a written route made on a trip back ([`scan`] on its `order`).
#[derive(Clone, Debug, PartialEq)]
pub struct Audit {
	pub near: Near,
	pub q: u32,
	/// Yards from the ender where it was finished (stop `near.at`).
	pub at_yd: f64,
	/// The level where it was finished.
	pub lvl: f64,
	pub blocker: bool,
	/// The `from` of the hand-in's entry and of the stop it was finished at.
	pub from: String,
	pub at_from: String,
}

/// The hand-ins of a route's `order` made on a trip back (`forge sim route --audit`): world points
/// from `world`, straight yards, the walk store `walks` where given for the reach ([`world_reach`]).
pub fn audit_order(world: &forge_world::World, walks: Option<&dyn crate::Walks>, order: &[serde_json::Value]) -> Vec<Audit> {
	let l = OrderLine { world, walks, order, quests: world.quests.iter().map(|q| (q.id, q)).collect() };
	let from = |i: usize| order[i]["from"].as_str().unwrap_or("").to_string();
	scan(&l)
		.into_iter()
		.map(|near| Audit { q: l.quest(near.j), at_yd: l.yd(near.at, near.j), lvl: l.lvl_after(near.at), blocker: near.blocker(&l), from: from(near.j), at_from: from(near.at), near })
		.collect()
}
