//! Engine.lua's rules on the loaded tab: which steps apply (`only`, `when`), goal statuses (goalDone per
//! verb, unavailable and never-had marks), step selection (computeCurrent, `skipto` jumps, placement),
//! latches, arrival, candidate and spawn-area picks, and the hand-over through `next`. Each function
//! names the Lua it ports; the replay (play.rs) drives them the way the stub world's events do.

use super::model::{Along, Cand, Goal, Guide, Only, Pred, Rank, T};
use super::script::Hooks;
use super::world::World;
use rustc_hash::{FxHashMap, FxHashSet};

const DEFAULT_RADIUS: f64 = 8.0;
const MIN_INTERVAL: f64 = 0.1;
pub(crate) const ARRIVAL_POLL: f64 = 0.5;
const PLACE_SECONDS: f64 = 10.0;
const DIE_RADIUS: f64 = 40.0;
const UNMEASURED: f64 = 1e9;
const PLANNED: usize = 8;
const RUN_SPEED: f64 = 7.0;
const CROSS_CONTINENT: f64 = 3600.0;
const TOO_HIGH: f64 = 3.0;
const SPOT_SWITCH: f64 = 40.0;
const SPOT_LEAVE: f64 = 4.0;
const SPOT_FORGET: f64 = 300.0;

/// A goal of a guide: (guide index, step, goal), 1-based like the Lua.
pub(crate) type GRef = (usize, usize, usize);

/// Why a quest's goals read as skipped (unavailableFor's mark).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Reason {
	Skipped,
	Closed,
	Pre,
	Level,
	Offer,
}

#[derive(Clone, Copy, Debug)]
pub(crate) struct Mark {
	pub reason: Reason,
	pub accept: GRef,
	pub by: Option<u32>,
}

/// A stored check-off: the player's tick or a result the engine latched (`true`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Check {
	Latched,
	Tick,
}

/// The kind of the open NPC window (onNpcFrame).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Kind {
	Talk,
	Train,
	Vendor,
	Sethome,
}

#[derive(Clone, Debug, Default)]
struct Pick {
	gen: u64,
	list: Vec<usize>,
	i: usize,
}

#[derive(Clone, Copy, Debug)]
pub(crate) enum TimerKind {
	Flush,
	Tick(u64),
}

#[derive(Clone, Copy, Debug)]
pub(crate) struct Timer {
	pub at: f64,
	pub kind: TimerKind,
}

/// `behavior.groupQuests`: the answer at every group quest.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Groups {
	Do,
	Skip,
	/// "ask" (the setting's default): no answer, a group quest's step waits for the player.
	Ask,
}

/// done, cur, max of a goal (goalDone).
#[derive(Clone, Copy, Debug, Default)]
pub(crate) struct Done {
	pub done: bool,
	pub cur: Option<f64>,
	pub max: Option<f64>,
}

impl Done {
	fn yes() -> Done {
		Done { done: true, cur: None, max: None }
	}
	fn no() -> Done {
		Done::default()
	}
	fn of(b: bool) -> Done {
		Done { done: b, cur: None, max: None }
	}
}

/// The view status of a goal (goalStatus / goalView).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Status {
	Done,
	Na,
	Skipped,
	Active,
	Pending,
}

impl Status {
	pub fn as_str(self) -> &'static str {
		match self {
			Status::Done => "done",
			Status::Na => "na",
			Status::Skipped => "skipped",
			Status::Active => "active",
			Status::Pending => "pending",
		}
	}
}

/// A step's focus group (stepGroups): who, its goals, its place.
pub(crate) struct Group {
	pub kind: u8,
	pub id: Option<u32>,
	pub goals: Vec<usize>,
	pub map: bool,
	pub pending: usize,
}

/// The engine and the stub world it reads, as one Lua state.
pub(crate) struct Sim<'a> {
	pub gs: &'a [Guide],
	pub by_id: FxHashMap<&'a str, usize>,
	pub w: World,
	pub wd: &'a super::WorldData,
	/// CharState().flags.inn: bind location (lower case) -> the innkeeper learned at bind time (Nav onBound).
	inn_flags: FxHashMap<String, u32>,
	pub groups_answer: Groups,
	// refreshPlayer
	pl_level: f64,
	pl_xp: f64,
	pl_xp_max: f64,
	have_player: bool,
	// the loaded (only) tab
	pub guide: Option<usize>,
	pub current: Option<usize>,
	pub computed: Option<usize>,
	passed_up_to: usize,
	auto_chain: bool,
	saw_incomplete: bool,
	pub placing: Option<f64>,
	/// Engine.Goto/Next's view of another step than the live one (`pin`, `pinDone`).
	pin: Option<usize>,
	pin_done: Option<bool>,
	/// behavior.autoNextGuide: a finished guide hands over through `next` (on by default; playGuide
	/// without a hand-over turns it off).
	pub auto_next: bool,
	/// Test scripts' wraps of the stub world's helpers and of GetStepView (see [`Hooks`]).
	pub hooks: Option<Box<dyn Hooks + 'a>>,
	completed_fired: FxHashSet<usize>,
	level_seen: f64,
	turned_in: FxHashSet<u32>,
	open_npc: Option<u32>,
	open_kind: Option<Kind>,
	pub log_ready: bool,
	arrived: FxHashSet<GRef>,
	unavailable: FxHashMap<u32, Mark>,
	offered: FxHashSet<u32>,
	opened: FxHashSet<usize>,
	placed_through: FxHashSet<usize>,
	chain_seen: FxHashSet<usize>,
	caught_up: FxHashSet<usize>,
	context_gen: u64,
	picks: FxHashMap<GRef, Pick>,
	spot_chosen: FxHashMap<GRef, usize>,
	spot_seen: FxHashMap<(GRef, usize), f64>,
	asking: FxHashSet<usize>,
	pub waypoint: Option<GRef>,
	// CharState
	manual: FxHashMap<usize, FxHashMap<(usize, usize), Check>>,
	skipped_steps: FxHashMap<usize, FxHashSet<usize>>,
	skipped_goals: FxHashMap<usize, FxHashSet<(usize, usize)>>,
	when_held: FxHashMap<usize, FxHashSet<usize>>,
	class_train_visit: Option<f64>,
	fp: FxHashSet<String>,
	routes: FxHashMap<usize, usize>,
	skipped_quests: FxHashSet<u32>,
	// clock (wow_stub.lua timers)
	pub now: f64,
	last_eval: f64,
	scheduled: bool,
	pub timers: Vec<Timer>,
	ticker: Option<u64>,
	next_handle: u64,
}

fn same(a: Option<&str>, b: Option<&str>) -> bool {
	match (a, b) {
		(Some(a), Some(b)) => a.to_lowercase() == b.to_lowercase(),
		_ => false,
	}
}

fn norm_race(r: &str) -> String {
	let r = r.to_lowercase();
	if r == "scourge" {
		"undead".into()
	} else {
		r
	}
}

/// Guides.lua listMatches: no `!x` equals the value and, with any positive entry, one does.
fn list_matches(list: &[String], value: &str, race: bool) -> bool {
	if list.is_empty() {
		return true;
	}
	let norm = |s: &str| if race { norm_race(s) } else { s.to_lowercase() };
	let value = norm(value);
	let (mut positives, mut hit) = (false, false);
	for e in list {
		let (neg, e) = match e.strip_prefix('!') {
			Some(rest) => (true, rest),
			None => (false, e.as_str()),
		};
		let e = norm(e);
		if neg {
			if e == value {
				return false;
			}
		} else {
			positives = true;
			if e == value {
				hit = true;
			}
		}
	}
	hit || !positives
}

/// Compat greyLevel / IsQuestTrivial (no trivial range in the stub).
pub(crate) fn trivial(qlvl: f64, level: f64) -> bool {
	let grey = if level <= 5.0 {
		0.0
	} else if level <= 39.0 {
		level - 5.0 - (level / 10.0).floor()
	} else if level <= 59.0 {
		level - 1.0 - (level / 5.0).floor()
	} else {
		level - 9.0
	};
	qlvl <= grey
}

fn rank_cap(goal: &Goal) -> Option<f64> {
	let r = match &goal.rank {
		Some(Rank::Num(n)) => *n,
		Some(Rank::Name(s)) => match s.to_lowercase().as_str() {
			"apprentice" => 1.0,
			"journeyman" => 2.0,
			"expert" => 3.0,
			"artisan" => 4.0,
			other => other.parse().ok()?,
		},
		None => return None,
	};
	if r <= 4.0 {
		return [75.0, 150.0, 225.0, 300.0].get(r as usize - 1).copied().or(if r < 1.0 { None } else { Some(r) });
	}
	Some(r)
}

fn is_profession_train(goal: &Goal) -> bool {
	goal.t == T::Train && (goal.skill_line.is_some() || goal.skill.is_some()) && rank_cap(goal).is_some()
}

/// isManual: goals only the player's tick (or a latched interaction) completes.
pub(crate) fn is_manual(goal: &Goal) -> bool {
	match goal.t {
		T::Train if is_profession_train(goal) => false,
		T::Talk | T::Hearth | T::Getfp | T::Fly | T::Train | T::Vendor | T::Task => true,
		T::Kill | T::Interact | T::Use => goal.quest.is_none(),
		T::Craft => craft_mode(goal) == 2,
		_ => false,
	}
}

/// craftMode: 0 skill, 1 count, 2 manual.
fn craft_mode(goal: &Goal) -> u8 {
	if goal.until_skill.is_some() && (goal.skill_line.is_some() || goal.skill.is_some()) {
		0
	} else if goal.item.is_some() {
		1
	} else {
		2
	}
}

fn blocks(goal: &Goal) -> bool {
	goal.t != T::Note && !goal.optional
}

fn is_quest_goal(goal: &Goal) -> bool {
	goal.quest.is_some() && matches!(goal.t, T::Accept | T::Turnin | T::Complete | T::Kill | T::Collect | T::Interact | T::Use)
}

pub(crate) fn is_bag_count(goal: &Goal) -> bool {
	matches!(goal.t, T::Buy | T::Money | T::Abandon | T::Destroy) || (goal.t == T::Collect && goal.quest.is_none()) || (goal.t == T::Craft && craft_mode(goal) == 1)
}

fn latchable(goal: &Goal) -> bool {
	matches!(goal.t, T::Goto | T::Explore | T::Die | T::Sethome | T::Hearth | T::Fly | T::Getfp | T::Enter | T::Buy | T::Money | T::Destroy)
		|| (goal.t == T::Collect && goal.quest.is_none())
		|| (goal.t == T::Craft && craft_mode(goal) == 1)
		|| (goal.t == T::Train && goal.class)
}

fn missing_pre(pre: &Option<Vec<u32>>, pre_all: &Option<Vec<u32>>, done: impl Fn(u32) -> bool) -> Option<u32> {
	if let Some(all) = pre_all {
		for &q in all {
			if !done(q) {
				return Some(q);
			}
		}
	}
	if let Some(any) = pre {
		if !any.is_empty() {
			if any.iter().any(|&q| done(q)) {
				return None;
			}
			return Some(any[0]);
		}
	}
	None
}

impl<'a> Sim<'a> {
	pub fn new(gs: &'a [Guide], w: World, wd: &'a super::WorldData, groups_answer: Groups) -> Sim<'a> {
		let by_id = gs.iter().enumerate().map(|(i, g)| (g.id.as_str(), i)).collect();
		Sim {
			gs,
			by_id,
			w,
			wd,
			inn_flags: FxHashMap::default(),
			groups_answer,
			pl_level: 1.0,
			pl_xp: 0.0,
			pl_xp_max: 0.0,
			have_player: false,
			guide: None,
			current: None,
			computed: None,
			passed_up_to: 0,
			auto_chain: false,
			saw_incomplete: false,
			placing: None,
			pin: None,
			pin_done: None,
			auto_next: true,
			hooks: None,
			completed_fired: FxHashSet::default(),
			level_seen: 0.0,
			turned_in: FxHashSet::default(),
			open_npc: None,
			open_kind: None,
			log_ready: false,
			arrived: FxHashSet::default(),
			unavailable: FxHashMap::default(),
			offered: FxHashSet::default(),
			opened: FxHashSet::default(),
			placed_through: FxHashSet::default(),
			chain_seen: FxHashSet::default(),
			caught_up: FxHashSet::default(),
			context_gen: 0,
			picks: FxHashMap::default(),
			spot_chosen: FxHashMap::default(),
			spot_seen: FxHashMap::default(),
			asking: FxHashSet::default(),
			waypoint: None,
			manual: FxHashMap::default(),
			skipped_steps: FxHashMap::default(),
			skipped_goals: FxHashMap::default(),
			when_held: FxHashMap::default(),
			class_train_visit: None,
			fp: FxHashSet::default(),
			routes: FxHashMap::default(),
			skipped_quests: FxHashSet::default(),
			now: 0.0,
			last_eval: f64::NEG_INFINITY,
			scheduled: false,
			timers: Vec::new(),
			ticker: None,
			next_handle: 0,
		}
	}

	pub fn gd(&self) -> &'a Guide {
		let gs: &'a [Guide] = self.gs;
		&gs[self.guide.expect("a loaded guide")]
	}

	fn gi(&self) -> usize {
		self.guide.expect("a loaded guide")
	}

	// ------------------------------------------------------------------ live state helpers

	/// refreshPlayer: the stub's level, XP; a level-up event ahead of UnitLevel wins.
	pub fn refresh_player(&mut self) {
		self.have_player = true;
		self.pl_level = self.w.level;
		self.pl_xp = self.w.xp;
		self.pl_xp_max = self.w.xp_max;
		if self.level_seen > self.pl_level {
			self.pl_level = self.level_seen;
			self.pl_xp = 0.0;
		}
	}

	pub fn quest_done(&self, q: u32) -> bool {
		self.turned_in.contains(&q) || self.w.completed.contains(&q)
	}

	/// Guides.Matches(only, player).
	pub fn matches(&self, only: &Option<Only>) -> bool {
		let Some(o) = only else { return true };
		list_matches(&o.classes, &self.w.class, false) && list_matches(&o.races, &self.w.race, true) && list_matches(&o.factions, &self.w.faction, false)
	}

	/// Guides.GuideMatches.
	fn guide_matches(&self, g: &Guide) -> bool {
		if let Some(f) = &g.faction {
			if f.to_lowercase() != self.w.faction.to_lowercase() {
				return false;
			}
		}
		list_matches(&g.races, &self.w.race, true) && list_matches(&g.classes, &self.w.class, false)
	}

	fn cand_matches(&self, c: &Cand) -> bool {
		if let Some(f) = &c.faction {
			if f != "AH" {
				let code = match self.w.faction.as_str() {
					"Alliance" => "A",
					"Horde" => "H",
					_ => return false,
				};
				if !f.contains(code) {
					return false;
				}
			}
		}
		list_matches(&c.races, &self.w.race, true) && list_matches(&c.classes, &self.w.class, false)
	}

	fn missing_pre_of(&self, pre: &Option<Vec<u32>>, pre_all: &Option<Vec<u32>>) -> Option<u32> {
		missing_pre(pre, pre_all, |q| self.quest_done(q))
	}

	fn skill_rank(&self, line: Option<u32>, name: Option<&str>) -> Option<(f64, f64)> {
		line.and_then(|l| self.w.skill_rank(&l.to_string())).or_else(|| name.and_then(|n| self.w.skill_rank(n).or_else(|| self.w.skill_rank(&n.to_lowercase()))))
	}

	// ------------------------------------------------------------------ CharState

	fn checked(&self, s: usize, g: usize) -> bool {
		self.manual.get(&self.gi()).is_some_and(|m| m.contains_key(&(s, g)))
	}

	fn check_of(&self, s: usize, g: usize) -> Option<Check> {
		self.manual.get(&self.gi()).and_then(|m| m.get(&(s, g)).copied())
	}

	fn set_check(&mut self, s: usize, g: usize, c: Check) -> bool {
		let m = self.manual.entry(self.gi()).or_default();
		if m.contains_key(&(s, g)) {
			return false;
		}
		m.insert((s, g), c);
		true
	}

	pub fn is_skipped(&self, s: usize) -> bool {
		self.skipped_steps.get(&self.gi()).is_some_and(|k| k.contains(&s))
	}

	fn goal_skipped(&self, s: usize, g: usize) -> bool {
		self.skipped_goals.get(&self.gi()).is_some_and(|k| k.contains(&(s, g)))
	}

	fn held(&self, s: usize) -> bool {
		self.when_held.get(&self.gi()).is_some_and(|k| k.contains(&s))
	}

	// ------------------------------------------------------------------ `only` and `when`

	/// stepApplies.
	pub fn step_applies(&mut self, s: usize) -> bool {
		let step = self.gd().step(s);
		self.matches(&step.only) && (step.when.is_none() || self.when_holds(s))
	}

	/// Own.whenHolds: stored as held, or skipped: applies; else its predicates live.
	fn when_holds(&mut self, s: usize) -> bool {
		if self.held(s) || self.is_skipped(s) {
			return true;
		}
		self.when_fails(s).is_none()
	}

	fn when_fails(&mut self, s: usize) -> Option<usize> {
		let gd = self.gd();
		for (i, p) in gd.step(s).when.iter().flatten().enumerate() {
			if !self.predicate_holds(p) {
				return Some(i);
			}
		}
		None
	}

	/// Own.availableNow.
	fn available_now(&self, p: &Pred) -> bool {
		let Some(&q) = p.q.first() else { return false };
		if self.w.on_quest(q) || self.quest_done(q) {
			return false;
		}
		if let Some(min) = p.min_level {
			if self.pl_level < min {
				return false;
			}
		}
		if self.missing_pre_of(&p.pre, &p.pre_all).is_some() {
			return false;
		}
		!p.closed_by.iter().flatten().any(|&by| self.w.on_quest(by) || self.quest_done(by))
	}

	/// Own.groupAnswer (no per-quest answers in a replay: the setting's).
	fn group_answer(&self, _q: u32) -> Option<Groups> {
		(self.groups_answer != Groups::Ask).then_some(self.groups_answer)
	}

	/// Own.predicateHolds.
	pub fn predicate_holds(&mut self, p: &Pred) -> bool {
		let cmp = |op: Option<&str>, a: f64, b: f64| match op {
			Some("<") => a < b,
			Some("<=") => a <= b,
			Some(">") => a > b,
			Some(">=") => a >= b,
			_ => false,
		};
		let q0 = p.q.first().copied();
		let ok = match p.k.as_str() {
			"level" => {
				let (mut level, mut n) = (self.pl_level, p.n.unwrap_or(0.0));
				if let Some(frac) = p.frac {
					if self.pl_xp_max > 0.0 {
						level += self.pl_xp / self.pl_xp_max;
					}
					n += frac;
				}
				return cmp(p.op.as_deref(), level, n);
			}
			"money" => return cmp(p.op.as_deref(), self.w.money, p.n.unwrap_or(0.0)),
			"onquest" => p.q.iter().any(|&q| self.w.on_quest(q)),
			"complete" => q0.is_some_and(|q| self.w.ready(q)),
			"turnedin" => q0.is_some_and(|q| self.quest_done(q)),
			"available" => self.available_now(p),
			"has" => p.item.is_some_and(|i| self.w.item_count(i) >= p.n.unwrap_or(1.0)),
			// Gear advice cannot judge in the stub: the item counts as an upgrade.
			"upgrade" => true,
			"zone" | "subzone" => {
				let (zone, sub) = self.w.zone_text();
				same(if p.k == "zone" { zone } else { sub }, p.name.as_deref())
			}
			"bound" => same(self.w.bind_location(), p.name.as_deref()),
			// Engine.DungeonChosen: no dungeon is ever chosen in a replay.
			"dungeon" => false,
			"done" => p.label.as_deref().is_some_and(|l| self.label_done(l)),
			"skill" => self.skill_rank(p.skill_line, p.name.as_deref()).map_or(0.0, |r| r.0) >= p.n.unwrap_or(0.0),
			// No cooldowns run in the stub.
			"cooldown" => false,
			// No spellbook in the stub: no spell is known.
			"knows" => false,
			"group" => match q0.and_then(|q| self.group_answer(q)) {
				None => return true,
				Some(a) => a == Groups::Do,
			},
			_ => false,
		};
		if p.neg {
			!ok
		} else {
			ok
		}
	}

	/// Own.optionHolds: a `next` option's `when`.
	fn option_holds(&mut self, from: usize, id: &str) -> bool {
		let gs: &'a [Guide] = self.gs;
		let Some(list) = gs[from].next_when.get(id) else { return true };
		if !self.have_player {
			self.refresh_player();
		}
		list.iter().all(|p| self.predicate_holds(p))
	}

	/// Own.groupPending: the quest of the first unanswered `group` predicate (route waits there).
	fn group_pending(&mut self, s: usize) -> bool {
		let step = self.gd().step(s);
		if step.along != Along::No {
			return false;
		}
		let Some(when) = &step.when else { return false };
		for p in when {
			if p.k == "group" {
				if let Some(&q) = p.q.first() {
					if self.group_answer(q).is_none() && self.group_open(s, q) {
						return true;
					}
				}
			}
		}
		false
	}

	/// Own.groupOpen.
	fn group_open(&mut self, s: usize, q: u32) -> bool {
		if self.quest_done(q) || self.skipped_quests.contains(&q) {
			return false;
		}
		if self.w.on_quest(q) {
			return true;
		}
		let gd = self.gd();
		let mut takes = false;
		for (gi, goal) in gd.step(s).goals.iter().enumerate() {
			if goal.t == T::Accept && goal.quest == Some(q) {
				takes = true;
				let low = goal.min_level.is_some_and(|l| self.pl_level < l);
				if self.goal_applies(s, gi + 1) && self.unavailable_for(s, gi + 1, 0).is_none() && !low && self.missing_pre_of(&goal.pre, &goal.pre_all).is_none() {
					return true;
				}
			}
		}
		!takes
	}

	/// Own.labelDone (`when done <label>`).
	fn label_done(&mut self, label: &str) -> bool {
		let Some(&s) = self.gd().labels.get(label) else { return false };
		if self.is_skipped(s) || self.asking.contains(&s) {
			return false;
		}
		self.asking.insert(s);
		let ok = self.step_applies(s) && self.goals_done(s);
		self.asking.remove(&s);
		ok
	}

	/// Own.latchWhen: store a passed step's `when` outcome (held, or failed as a skip).
	fn latch_when(&mut self, s: usize) {
		let step = self.gd().step(s);
		if !self.log_ready || step.when.is_none() || !self.matches(&step.only) {
			return;
		}
		if self.held(s) || self.is_skipped(s) {
			return;
		}
		let gi = self.gi();
		if self.when_fails(s).is_none() {
			self.when_held.entry(gi).or_default().insert(s);
		} else {
			self.skipped_steps.entry(gi).or_default().insert(s);
		}
	}

	fn latch_caught_up(&mut self, passed: usize) {
		let gi = self.gi();
		if !self.log_ready || self.caught_up.contains(&gi) {
			return;
		}
		self.caught_up.insert(gi);
		for s in 1..=passed {
			self.latch_when(s);
		}
	}

	/// Own.alongListed.
	fn along_listed(&mut self, s: usize) -> bool {
		let Some(live) = self.computed else { return false };
		if s >= live {
			return false;
		}
		let step = self.gd().step(s);
		if step.along == Along::No || self.is_skipped(s) || !self.step_applies(s) {
			return false;
		}
		if let Along::Until(l) = &step.along {
			if let Some(&stop) = self.gd().labels.get(l) {
				if live >= stop {
					return false;
				}
			}
		}
		true
	}

	// ------------------------------------------------------------------ availability

	/// Own.preBlocked.
	fn pre_blocked(&mut self, s: usize, g: usize, depth: u32) -> Option<u32> {
		let a = self.gd().goal(s, g);
		self.missing_pre_of(&a.pre, &a.pre_all)?;
		if let Some(all) = &a.pre_all {
			for &p in all {
				if !self.quest_done(p) && !self.coming(p, depth) {
					return Some(p);
				}
			}
		}
		if let Some(any) = &a.pre {
			if !any.is_empty() {
				for &p in any {
					if self.quest_done(p) || self.coming(p, depth) {
						return None;
					}
				}
				return Some(any[0]);
			}
		}
		None
	}

	/// Own.coming: the guide still turns p in for the character, or only has it for others.
	fn coming(&mut self, p: u32, depth: u32) -> bool {
		let gd = self.gd();
		let gi = self.gi();
		let empty = Vec::new();
		let turnins = gd.turnins.get(&p).unwrap_or(&empty);
		let mut mine = false;
		for t in turnins {
			let tg = gd.goal(t.s, t.g);
			if self.step_applies(t.s) && self.matches(&tg.only) {
				mine = true;
				let skipped = self.is_skipped(t.s) || self.goal_skipped(t.s, t.g);
				let ticked = self.manual.get(&gi).is_some_and(|m| m.contains_key(&(t.s, t.g)));
				if !tg.optional && self.goal_applies(t.s, t.g) && !skipped && !ticked && self.unavailable_for(t.s, t.g, depth + 1).is_none() {
					return true;
				}
			}
		}
		if mine {
			return false;
		}
		let accepts = gd.accepts.get(&p).unwrap_or(&empty);
		for t in accepts {
			if self.step_applies(t.s) && self.matches(&gd.goal(t.s, t.g).only) {
				return false;
			}
		}
		turnins.len() + accepts.len() > 0
	}

	/// unavailableFor: the goal's quest is skipped, closed for good, refused by its giver this session
	/// (a mark), or its accept lacks a prerequisite the route no longer brings.
	pub fn unavailable_for(&mut self, s: usize, g: usize, depth: u32) -> Option<Reason> {
		let gd = self.gd();
		let gi = self.gi();
		let goal = gd.goal(s, g);
		let q = goal.quest?;
		if self.skipped_quests.contains(&q) && !self.quest_done(q) {
			return Some(Reason::Skipped);
		}
		if self.w.on_quest(q) || self.quest_done(q) {
			return None;
		}
		let own = goal.t == T::Accept;
		let list: Vec<(usize, usize)> = if own { vec![(s, g)] } else { gd.accepts.get(&q).map(|l| l.iter().map(|a| (a.s, a.g)).collect()).unwrap_or_default() };
		for &(as_, ag) in &list {
			let a = gd.goal(as_, ag);
			for &by in a.closed_by.iter().flatten() {
				if self.w.on_quest(by) || self.quest_done(by) {
					let accept = (gi, as_, ag);
					let keep = self.unavailable.get(&q).is_some_and(|u| u.reason == Reason::Closed && u.accept == accept && u.by == Some(by));
					if !keep {
						self.unavailable.insert(q, Mark { reason: Reason::Closed, accept, by: Some(by) });
					}
					return Some(Reason::Closed);
				}
			}
		}
		let mut u = self.unavailable.get(&q).copied();
		if u.is_some_and(|u| u.reason == Reason::Closed) {
			self.unavailable.remove(&q);
			u = None;
		}
		if u.is_some() || self.offered.contains(&q) || depth > 8 {
			return u.map(|u| u.reason);
		}
		for &(as_, ag) in &list {
			let a = gd.goal(as_, ag);
			if (a.pre.is_some() || a.pre_all.is_some()) && self.pre_blocked(as_, ag, depth).is_some() {
				return Some(Reason::Pre);
			}
		}
		None
	}

	/// orphaned: a turn-in or objective of a quest the character neither has nor has done, with no
	/// accept for them at or before its step.
	fn orphaned(&mut self, s: usize, g: usize) -> bool {
		let gd = self.gd();
		let gi = self.gi();
		let goal = gd.goal(s, g);
		let Some(q) = goal.quest else { return false };
		if goal.t == T::Accept || goal.direct {
			return false;
		}
		if self.w.on_quest(q) || self.quest_done(q) {
			return false;
		}
		let empty = Vec::new();
		for a in gd.accepts.get(&q).unwrap_or(&empty) {
			let ag = gd.goal(a.s, a.g);
			let skipped = self.skipped_steps.get(&gi).is_some_and(|k| k.contains(&a.s));
			let ticked = self.manual.get(&gi).is_some_and(|m| m.contains_key(&(a.s, a.g)));
			if a.s <= s && !ag.optional && !skipped && !ticked && self.step_applies(a.s) && self.matches(&ag.only) {
				return false;
			}
		}
		true
	}

	/// goalApplies: `only`, the profession gate, not orphaned (skipGrey and the catch-up are off).
	pub fn goal_applies(&mut self, s: usize, g: usize) -> bool {
		let goal = self.gd().goal(s, g);
		if !self.matches(&goal.only) {
			return false;
		}
		if goal.prof_line.is_some() || goal.prof_name.is_some() {
			let held = goal.quest.is_some_and(|q| self.w.on_quest(q) || self.quest_done(q));
			if !held {
				let rank = self.skill_rank(goal.prof_line, goal.prof_name.as_deref()).map(|r| r.0);
				if rank.unwrap_or(0.0) < goal.prof_rank.unwrap_or(1.0) {
					return false;
				}
			}
		}
		!self.orphaned(s, g)
	}

	// ------------------------------------------------------------------ done rules

	/// objectiveState.
	fn objective_state(&self, goal: &Goal) -> Done {
		let q = goal.quest.unwrap();
		if self.quest_done(q) {
			return Done::yes();
		}
		if !self.w.on_quest(q) {
			return Done::no();
		}
		let (mut cur, mut max, mut finished) = (None, None, false);
		if let Some(oi) = goal.oi {
			let Some(objs) = self.w.objectives(q) else { return Done::no() };
			if let Some(o) = objs.get(oi as usize - 1) {
				cur = Some(o.fulfilled);
				max = Some(o.required);
				finished = o.finished;
			}
		}
		if self.w.ready(q) {
			return Done { done: true, cur, max };
		}
		Done { done: finished, cur, max }
	}

	fn count_state(&self, goal: &Goal) -> Done {
		let need = goal.count.unwrap_or(1.0);
		let have = goal.item.map_or(0.0, |i| self.w.item_count(i));
		Done { done: have >= need, cur: Some(if have < need { have } else { need }), max: Some(need) }
	}

	/// Own.starterTaken.
	fn starter_taken(&mut self, s: usize, g: usize) -> bool {
		let gd = self.gd();
		let goal = gd.goal(s, g);
		if goal.count.unwrap_or(1.0) != 1.0 {
			return false;
		}
		let goals = &gd.step(s).goals;
		for j in g + 1..=goals.len() {
			let a = &goals[j - 1];
			if a.item == goal.item {
				if a.t == T::Collect && a.quest.is_none() {
					return false;
				}
				if a.t == T::Accept && a.npc.is_none() && a.object.is_none() && self.goal_applies(s, j) {
					let q = a.quest.unwrap_or(0);
					return self.w.on_quest(q) || self.quest_done(q);
				}
			}
		}
		false
	}

	/// Own.abandonedByGuide.
	fn abandoned_by_guide(&self, q: u32, s: usize) -> bool {
		let Some(list) = self.gd().abandons.get(&q) else { return false };
		for a in list {
			if a.s >= s {
				if self.check_of(a.s, a.g) == Some(Check::Latched) {
					return true;
				}
				if self.computed.is_some_and(|c| a.s <= c) && !self.w.on_quest(q) {
					return true;
				}
			}
		}
		false
	}

	/// inPlace: the zone or subzone text is the goal's place (no area names in the stub: its location).
	fn in_place(&self, goal: &Goal) -> bool {
		let (zone, sub) = self.w.zone_text();
		same(zone, goal.location.as_deref()) || same(sub, goal.location.as_deref())
	}

	fn fp_known(&self, goal: &Goal) -> bool {
		if goal.node.is_some() {
			return false;
		}
		let want = goal.location.as_deref().unwrap_or("").to_lowercase();
		self.fp.iter().any(|n| {
			let n = n.to_lowercase();
			n == want || n.split(',').next() == Some(want.as_str())
		})
	}

	/// Own.nothingToTrain: the class trainer was visited at this level, or the even level below.
	fn nothing_to_train(&self) -> bool {
		let Some(visit) = self.class_train_visit else { return false };
		if !self.have_player {
			return false;
		}
		let level = self.pl_level;
		visit <= level && level - visit <= level % 2.0
	}

	fn level_reached(&self, level: f64, frac: Option<f64>) -> bool {
		let lvl = self.pl_level;
		match frac {
			Some(f) if lvl == level => self.pl_xp_max > 0.0 && self.pl_xp / self.pl_xp_max >= f,
			_ => lvl >= level,
		}
	}

	/// goalDone: done, cur, max of goal g of step s.
	pub fn goal_done(&mut self, s: usize, g: usize) -> Done {
		if self.checked(s, g) {
			return Done::yes();
		}
		let gd = self.gd();
		let goal = gd.goal(s, g);
		let q = goal.quest;
		match goal.t {
			T::Accept => {
				let q = q.unwrap_or(0);
				Done::of(self.w.on_quest(q) || self.quest_done(q) || self.abandoned_by_guide(q, s))
			}
			T::Turnin => {
				let q = q.unwrap_or(0);
				if goal.direct {
					return Done::of(self.w.completed.contains(&q));
				}
				Done::of(self.quest_done(q))
			}
			T::Complete => {
				let q = q.unwrap_or(0);
				if self.quest_done(q) || self.w.ready(q) {
					return Done::yes();
				}
				match self.w.objectives(q) {
					Some(objs) => {
						let (mut cur, mut max) = (0.0, 0.0);
						for o in objs {
							max += o.required;
							cur += o.fulfilled.min(o.required);
						}
						Done { done: false, cur: Some(cur), max: Some(max) }
					}
					None => Done::no(),
				}
			}
			T::Kill | T::Interact | T::Use => {
				if q.is_some() {
					self.objective_state(goal)
				} else {
					Done::no()
				}
			}
			T::Collect => {
				if q.is_some() {
					return self.objective_state(goal);
				}
				if self.starter_taken(s, g) {
					return Done::yes();
				}
				self.count_state(goal)
			}
			T::Buy => self.count_state(goal),
			T::Goto => {
				if self.arrived.contains(&(self.gi(), s, g)) {
					return Done::yes();
				}
				let goals = &gd.step(s).goals;
				let mut leads = true;
				for j in g + 1..=goals.len() {
					let later = &goals[j - 1];
					if later.t == T::Goto {
						if (self.arrived.contains(&(self.gi(), s, j)) || self.checked(s, j)) && self.goal_applies(s, j) {
							return Done::yes();
						}
					} else if later.t != T::Note && self.goal_applies(s, j) {
						if self.goal_done(s, j).done {
							return Done::yes();
						}
						leads = false;
					}
				}
				Done::of(leads && self.next_step_done(s))
			}
			T::Train if is_profession_train(goal) => {
				let max = self.skill_rank(goal.skill_line, goal.skill.as_deref()).map(|r| r.1);
				Done::of(max.unwrap_or(0.0) >= rank_cap(goal).unwrap_or(f64::INFINITY))
			}
			T::Train if goal.class && self.nothing_to_train() => Done::yes(),
			T::Talk | T::Train | T::Vendor | T::Task => Done::no(),
			T::Abandon => Done::of(!self.w.on_quest(q.unwrap_or(0))),
			T::Destroy => Done::of(goal.item.map_or(0.0, |i| self.w.item_count(i)) == 0.0),
			T::Money => Done::of(self.w.money >= goal.money.unwrap_or(0.0)),
			T::Sethome => {
				let Some(loc) = &goal.location else { return Done::no() };
				let want = self.find_inn(goal.npc, Some(loc));
				if want.is_some() && self.bound_inn() == want {
					return Done::yes();
				}
				Done::of(same(self.w.bind_location(), Some(loc)))
			}
			T::Enter => Done::of(self.in_place(goal)),
			T::Hearth | T::Fly => {
				if self.in_place(goal) {
					return Done::yes();
				}
				let goals = &gd.step(s).goals;
				for j in g + 1..=goals.len() {
					if self.goal_applies(s, j) {
						let later = &goals[j - 1];
						match later.t {
							T::Hearth | T::Fly => {
								if self.in_place(later) || self.checked(s, j) {
									return Done::yes();
								}
							}
							T::Goto => {
								if self.arrived.contains(&(self.gi(), s, j)) || self.checked(s, j) {
									return Done::yes();
								}
							}
							T::Note => {}
							_ => {
								if self.goal_done(s, j).done {
									return Done::yes();
								}
							}
						}
					}
				}
				Done::no()
			}
			T::Getfp => Done::of(self.fp_known(goal)),
			T::Level => Done::of(self.level_reached(goal.level.unwrap_or(1.0), goal.frac)),
			T::Skill => {
				let target = goal.level.unwrap_or(0.0);
				let rank = self.skill_rank(goal.skill_line, goal.skill.as_deref()).map_or(0.0, |r| r.0);
				Done { done: rank >= target, cur: Some(rank.min(target)), max: Some(target) }
			}
			T::Cast => Done::no(),
			T::Learn => Done::of(goal.spell.is_some_and(|sp| self.w.spells.contains(&sp))),
			T::Craft => match craft_mode(goal) {
				0 => {
					let target = goal.until_skill.unwrap_or(0.0);
					let rank = self.skill_rank(goal.skill_line, goal.skill.as_deref()).map_or(0.0, |r| r.0);
					Done { done: rank >= target, cur: Some(rank.min(target)), max: Some(target) }
				}
				1 => self.count_state(goal),
				_ => Done::no(),
			},
			T::Rep => match goal.faction.and_then(|f| self.w.factions.get(&f)) {
				Some(&standing) => Done::of(standing >= goal.standing.unwrap_or(0.0)),
				None => Done::no(),
			},
			T::Explore => Done::of(self.arrived.contains(&(self.gi(), s, g)) || self.explored_at(goal)),
			T::Die => Done::of(self.arrived.contains(&(self.gi(), s, g))),
			T::Achieve => match goal.achievement.and_then(|a| self.w.achievements.get(&a)) {
				Some((completed, criteria)) => match goal.criteria {
					Some(c) => Done::of(*completed || criteria.get(c as usize - 1).is_some_and(|x| x.2)),
					None => Done::of(*completed),
				},
				None => Done::no(),
			},
			T::Note | T::Other => Done::no(),
		}
	}

	fn explored_at(&self, goal: &Goal) -> bool {
		let (Some(map), Some(x), Some(y)) = (goal.map, goal.x, goal.y) else { return false };
		self.w.areas.iter().any(|&(m, x1, y1, x2, y2, id)| m == map && x >= x1 && x <= x2 && y >= y1 && y <= y2 && self.w.explored.contains(&id))
	}

	/// Own.goalsDone: every blocking goal that applies is done or unavailable.
	pub fn goals_done(&mut self, s: usize) -> bool {
		let n = self.gd().step(s).goals.len();
		for g in 1..=n {
			let goal = self.gd().goal(s, g);
			if blocks(goal) && self.goal_applies(s, g) && self.unavailable_for(s, g, 0).is_none() && !self.goal_done(s, g).done {
				return false;
			}
		}
		true
	}

	/// stepDone.
	pub fn step_done(&mut self, s: usize) -> bool {
		if self.gd().step(s).along != Along::No {
			return true;
		}
		if self.group_pending(s) {
			return false;
		}
		self.goals_done(s)
	}

	/// Own.nextStepDone.
	fn next_step_done(&mut self, s: usize) -> bool {
		let n = self.gd().steps.len();
		for k in s + 1..=n {
			if self.step_applies(k) {
				let step = self.gd().step(k);
				if step.only.is_some() || self.is_skipped(k) {
					return false;
				}
				for g in 1..=step.goals.len() {
					let goal = &step.goals[g - 1];
					if goal.only.is_none() && blocks(goal) && is_quest_goal(goal) && self.goal_applies(k, g) && self.goal_done(k, g).done {
						return self.step_done(k);
					}
				}
				return false;
			}
		}
		false
	}

	/// goalStatus.
	pub fn goal_status(&mut self, s: usize, g: usize, current: bool) -> (Status, Done) {
		if !self.goal_applies(s, g) {
			return (Status::Na, Done::no());
		}
		let d = self.goal_done(s, g);
		if d.done {
			return (Status::Done, d);
		}
		if self.unavailable_for(s, g, 0).is_some() || self.goal_skipped(s, g) {
			return (Status::Skipped, d);
		}
		(if current { Status::Active } else { Status::Pending }, d)
	}

	/// stepStatusOf: "na" when the step does not apply; else whether it is the current step.
	pub fn step_status(&mut self, s: usize) -> Option<bool> {
		if !self.step_applies(s) {
			return None;
		}
		Some(self.current == Some(s))
	}

	// ------------------------------------------------------------------ placement and current step

	fn anchor_step(&mut self) -> usize {
		let n = self.gd().steps.len();
		for s in (1..=n).rev() {
			let step = self.gd().step(s);
			if step.only.is_none() {
				for g in 1..=step.goals.len() {
					let goal = &step.goals[g - 1];
					if goal.only.is_none() && !goal.optional && is_quest_goal(goal) && self.goal_applies(s, g) {
						let d = self.goal_done(s, g);
						if d.done || (goal.oi.is_some() && d.cur.unwrap_or(0.0) > 0.0) {
							return s;
						}
					}
				}
			}
		}
		0
	}

	fn open_goal(&mut self, s: usize, g: usize) -> bool {
		blocks(self.gd().goal(s, g)) && self.goal_applies(s, g) && self.unavailable_for(s, g, 0).is_none() && !self.goal_done(s, g).done
	}

	fn gated(&self, goal: &Goal) -> Option<Reason> {
		if goal.t != T::Accept {
			return None;
		}
		if goal.min_level.is_some_and(|l| self.pl_level < l) {
			return Some(Reason::Level);
		}
		if self.missing_pre_of(&goal.pre, &goal.pre_all).is_some() {
			return Some(Reason::Pre);
		}
		None
	}

	/// place(): where the quest log puts the player in a guide just loaded (skipGrey and the catch-up
	/// off: no quest is left out and no guide passes whole).
	fn place(&mut self) {
		let gd = self.gd();
		let gi = self.gi();
		let n = gd.steps.len();
		let anchor = self.anchor_step();
		let mut start = None;
		for s in 1..=n {
			if self.step_applies(s) && !self.is_skipped(s) && !self.step_done(s) {
				let (mut started, mut doable) = (false, false);
				for g in 1..=gd.step(s).goals.len() {
					if self.open_goal(s, g) {
						let goal = gd.goal(s, g);
						if goal.t == T::Accept {
							doable = doable || self.gated(goal).is_none();
						} else if is_quest_goal(goal) && self.w.on_quest(goal.quest.unwrap()) {
							started = true;
						}
					}
				}
				if start.is_none() && (started || doable) {
					start = Some(s);
				}
			}
		}
		let limit = start.unwrap_or(anchor);
		let mut here = false;
		if let Some(st) = start {
			if anchor < st {
				if let Some((c, px, py)) = self.w.player_world() {
					for g in 1..=gd.step(st).goals.len() {
						let Some((map, x, y, era, _)) = self.pos_of(st, g) else { continue };
						if self.open_goal(st, g) {
							if let Some((gc, gx, gy)) = self.w.map_to_world(map, x, y, era) {
								if gc == c && (gx - px).powi(2) + (gy - py).powi(2) <= 150.0 * 150.0 {
									here = true;
									break;
								}
							}
						}
					}
				}
			}
		}
		let travel = |t: T| matches!(t, T::Goto | T::Fly | T::Hearth | T::Explore | T::Die);
		for s in 1..limit {
			if self.step_applies(s) && !self.is_skipped(s) && !self.step_done(s) {
				let behind = s < anchor;
				let mut passes = true;
				for g in 1..=gd.step(s).goals.len() {
					let goal = gd.goal(s, g);
					let soft = is_manual(goal) || latchable(goal) || is_bag_count(goal);
					if self.open_goal(s, g) && self.gated(goal).is_none() && !(soft && behind) && !(here && travel(goal.t)) {
						passes = false;
						break;
					}
				}
				if passes {
					for g in 1..=gd.step(s).goals.len() {
						if self.open_goal(s, g) {
							let goal = gd.goal(s, g);
							match self.gated(goal) {
								Some(why) => {
									self.unavailable.insert(goal.quest.unwrap(), Mark { reason: why, accept: (gi, s, g), by: None });
								}
								None => {
									self.manual.entry(gi).or_default().insert((s, g), Check::Latched);
								}
							}
						}
					}
				}
			}
		}
	}

	/// Own.jump: the first `skipto` whose predicate holds skips s up to the labelled step.
	fn jump(&mut self, s: usize) -> bool {
		let gd = self.gd();
		let step = gd.step(s);
		let Some(skipto) = &step.skipto else { return false };
		if !self.log_ready || self.held(s) {
			return false;
		}
		for (to, when) in skipto {
			let Some(&t) = gd.labels.get(to) else { continue };
			if t > s && self.predicate_holds(when) {
				let sk = self.skipped_steps.entry(self.gi()).or_default();
				for k in s..t {
					sk.insert(k);
				}
				return true;
			}
		}
		false
	}

	/// computeCurrent: the first applicable, not skipped, not done step (placing first).
	fn compute_current(&mut self) -> Option<usize> {
		if self.placing.is_some() {
			self.place();
		}
		let n = self.gd().steps.len();
		(1..=n).find(|&s| self.step_applies(s) && !self.is_skipped(s) && !self.step_done(s) && !self.jump(s))
	}

	/// latchPassed: store the live-done latchable goals of steps the route just moved past.
	fn latch_passed(&mut self, from: usize, to: usize) {
		for s in from..=to {
			self.latch_when(s);
			if self.step_applies(s) {
				for g in 1..=self.gd().step(s).goals.len() {
					if latchable(self.gd().goal(s, g)) && self.goal_applies(s, g) && !self.checked(s, g) && self.goal_done(s, g).done {
						self.set_check(s, g, Check::Latched);
					}
				}
			}
		}
	}

	/// latchInStep: met bag counts (and the live step's landed flights and hearths) stay met.
	fn latch_in_step(&mut self, s: usize, live: bool) {
		if !self.step_applies(s) {
			return;
		}
		for g in 1..=self.gd().step(s).goals.len() {
			let goal = self.gd().goal(s, g);
			let t = goal.t;
			if ((is_bag_count(goal) && (live || t != T::Abandon)) || (live && matches!(t, T::Fly | T::Hearth | T::Enter)))
				&& self.goal_applies(s, g)
				&& !self.checked(s, g)
				&& self.goal_done(s, g).done
			{
				self.set_check(s, g, Check::Latched);
			}
		}
	}

	// ------------------------------------------------------------------ candidates and spawn areas

	fn far_seconds(&self, goal: &Goal, c: &Cand) -> (f64, f64) {
		let level = self.pl_level;
		let (lo, hi) = match c.lvl {
			Some((a, b)) => (a.unwrap_or(level), b.unwrap_or(level)),
			None => (level, level),
		};
		let gap = lo - level;
		let mob = ((lo + hi) / 2.0 + 0.5).floor();
		let diff = mob - level;
		let mut kpm = if trivial(mob, level) {
			2.5
		} else if diff >= 1.0 {
			1.0
		} else if diff >= -4.0 {
			1.5
		} else {
			2.0
		};
		kpm *= (c.spawns.unwrap_or(8.0) / 8.0).min(1.0);
		let mut need = goal.count.unwrap_or(1.0) - goal.item.map_or(0.0, |i| self.w.item_count(i));
		if need < 1.0 {
			need = 1.0;
		}
		let rate = c.rate.unwrap_or(1.0);
		if rate <= 0.0 || kpm <= 0.0 {
			return (UNMEASURED, gap);
		}
		(need / (rate * kpm) * 60.0, gap)
	}

	/// pickFor: the candidates the character may use, nearest first (straight line; Nav's travel
	/// estimate is the direct one in a replay).
	fn pick_for(&mut self, gr: GRef) -> (Vec<usize>, usize) {
		if let Some(p) = self.picks.get(&gr) {
			if p.gen == self.context_gen {
				return (p.list.clone(), p.i);
			}
		}
		let gs: &'a [Guide] = self.gs;
		let goal = gs[gr.0].goal(gr.1, gr.2);
		let cands = goal.candidates.as_deref().unwrap_or(&[]);
		let here = self.w.player_map_position();
		let hw = here.and_then(|(m, x, y)| self.w.map_to_world(m, x, y, false));
		let farm = goal.t == T::Collect && goal.quest.is_none();
		let mut list = Vec::new();
		let n = cands.len();
		let (mut tier, mut cost, mut extra, mut order, mut gap) = (vec![0.0f64; n], vec![0.0f64; n], vec![0.0f64; n], vec![0.0f64; n], vec![0.0f64; n]);
		let mut reasonable = false;
		for (i, c) in cands.iter().enumerate() {
			if !self.cand_matches(c) {
				continue;
			}
			list.push(i);
			order[i] = (i + 1) as f64 * 1e-6;
			if farm {
				let (e, g) = self.far_seconds(goal, c);
				extra[i] = e;
				gap[i] = g;
				if g < TOO_HIGH {
					reasonable = true;
				}
			}
			let cw = match (c.map, c.x, c.y) {
				(Some(m), Some(x), Some(y)) => self.w.map_to_world(m, x, y, c.era),
				_ => None,
			};
			let line = match (hw, cw) {
				(Some((hc, hx, hy)), Some((cc, cx, cy))) if hc == cc => Some(((cx - hx).powi(2) + (cy - hy).powi(2)).sqrt() / RUN_SPEED),
				_ => None,
			};
			tier[i] = if line.is_some() { 0.0 } else { 1.0 };
			cost[i] = line.unwrap_or(if here.is_some_and(|h| Some(h.0) == c.map) { 0.0 } else { UNMEASURED });
		}
		if farm && reasonable {
			list.retain(|&i| gap[i] < TOO_HIGH);
		}
		let better = |a: usize, b: usize, cost: &[f64]| -> std::cmp::Ordering {
			if tier[a] != tier[b] {
				return tier[a].total_cmp(&tier[b]);
			}
			if !reasonable && gap[a] != gap[b] {
				return gap[a].total_cmp(&gap[b]);
			}
			(cost[a] + extra[a] + order[a]).total_cmp(&(cost[b] + extra[b] + order[b]))
		};
		list.sort_by(|&a, &b| better(a, b, &cost));
		if let Some((hm, hx, hy)) = here {
			for &i in list.iter().take(PLANNED) {
				let c = &cands[i];
				let (Some(m), Some(x), Some(y)) = (c.map, c.x, c.y) else { continue };
				let a = self.w.map_to_world(hm, hx, hy, false);
				let b = self.w.map_to_world(m, x, y, c.era);
				if let (Some(a), Some(b)) = (a, b) {
					cost[i] = if a.0 != b.0 { CROSS_CONTINENT } else { ((b.1 - a.1).powi(2) + (b.2 - a.2).powi(2)).sqrt() / RUN_SPEED };
				}
			}
			list.sort_by(|&a, &b| better(a, b, &cost));
		}
		let i = if list.is_empty() { 0 } else { 1 };
		self.picks.insert(gr, Pick { gen: self.context_gen, list: list.clone(), i });
		(list, i)
	}

	/// chosen: the goal's chosen candidate (index into its candidates).
	pub fn chosen(&mut self, s: usize, g: usize) -> Option<usize> {
		self.gd().goal(s, g).candidates.as_ref()?;
		let (list, i) = self.pick_for((self.gi(), s, g));
		if i == 0 {
			None
		} else {
			list.get(i - 1).copied()
		}
	}

	/// npcOf: the chosen candidate's NPC, else the goal's.
	pub fn npc_of(&mut self, s: usize, g: usize) -> (Option<u32>, Option<String>) {
		let goal = self.gd().goal(s, g);
		match self.chosen(s, g) {
			Some(i) => {
				let c = &goal.candidates.as_ref().unwrap()[i];
				(c.npc, c.npc_name.clone())
			}
			None => (goal.npc, goal.npc_name.clone()),
		}
	}

	fn spot_edge(&self, goal: &Goal, k: usize, c: i64, px: f64, py: f64) -> Option<f64> {
		let s = &goal.spots.as_ref()?[k];
		let (sc, wx, wy) = self.w.map_to_world(goal.map?, s.x, s.y, goal.era)?;
		if sc != c {
			return None;
		}
		let d = ((wx - px).powi(2) + (wy - py).powi(2)).sqrt() - s.r.unwrap_or(0.0);
		Some(if d > 0.0 { d } else { 0.0 })
	}

	/// Spots.repick (no spot picked by hand, never moving on).
	fn spot_repick(&mut self, gr: GRef, pos: Option<(i64, f64, f64)>) -> bool {
		let gs: &'a [Guide] = self.gs;
		let goal = gs[gr.0].goal(gr.1, gr.2);
		let Some(spots) = goal.spots.as_ref() else { return false };
		let now = self.now;
		let spread = goal.spread;
		let reach = goal.r.unwrap_or(DEFAULT_RADIUS);
		let cur = self.spot_chosen.get(&gr).copied();
		if cur.is_some() && pos.is_none() {
			return false;
		}
		let edges: Vec<Option<f64>> = (0..spots.len()).map(|k| pos.and_then(|(c, px, py)| self.spot_edge(goal, k, c, px, py))).collect();
		let edge = |k: usize| edges[k];
		let cur_d = cur.and_then(edge);
		if cur.is_some() && cur_d.is_none() {
			return false;
		}
		if pos.is_some() && spread {
			for k in 0..spots.len() {
				if edge(k).is_some_and(|d| d <= reach) {
					self.spot_seen.insert((gr, k), now);
				}
			}
		}
		if cur.is_some() && spread && cur_d.is_some_and(|d| d <= reach + SPOT_LEAVE) {
			return false;
		}
		let fresh = |k: usize| {
			let t = if spread { self.spot_seen.get(&(gr, k)).copied() } else { None };
			match t {
				None => true,
				Some(t) if now - t > SPOT_FORGET => true,
				Some(_) => pos.is_some() && edge(k).is_some_and(|d| d <= reach),
			}
		};
		let at = cur.map_or(0, |k| k + 1) as i64;
		let n = spots.len() as i64;
		let (mut best, mut best_key, mut old, mut old_t): (Option<usize>, Option<f64>, Option<usize>, Option<f64>) = (None, None, None, None);
		for (k, s) in spots.iter().enumerate() {
			if s.alt {
				continue;
			}
			if fresh(k) {
				let i = k as i64 + 1;
				let key = edge(k).unwrap_or(1e9 + ((i - at - 1).rem_euclid(n)) as f64);
				if best_key.is_none_or(|b| key < b) {
					best = Some(k);
					best_key = Some(key);
				}
			} else {
				let t = self.spot_seen.get(&(gr, k)).copied();
				if old_t.is_none() || t.is_some_and(|t| old_t.is_some_and(|o| t < o)) {
					old = Some(k);
					old_t = t;
				}
			}
		}
		let best = best.or(old);
		let mut new = cur;
		if let Some(b) = best {
			let switch = match (cur, cur_d, best_key) {
				(None, _, _) => true,
				(Some(c), _, _) if !fresh(c) => true,
				(_, None, _) => true,
				(_, Some(d), Some(k)) => k < d - SPOT_SWITCH,
				_ => false,
			};
			if switch {
				new = Some(b);
			}
		}
		let new = new.unwrap_or(0);
		if Some(new) == cur {
			return false;
		}
		self.spot_chosen.insert(gr, new);
		true
	}

	fn spot_get(&mut self, gr: GRef) -> Option<usize> {
		if !self.spot_chosen.contains_key(&gr) {
			let pos = self.w.player_world();
			self.spot_repick(gr, pos);
		}
		self.spot_chosen.get(&gr).copied()
	}

	/// posOf: the chosen candidate's place, the chosen spawn area's (with its radius), else the goal's.
	pub fn pos_of(&mut self, s: usize, g: usize) -> Option<(u32, f64, f64, bool, Option<f64>)> {
		let gd = self.gd();
		let goal = gd.goal(s, g);
		if let Some(i) = self.chosen(s, g) {
			let c = &goal.candidates.as_ref().unwrap()[i];
			return Some((c.map?, c.x?, c.y?, c.era, None));
		}
		if let Some(spots) = goal.spots.as_ref() {
			if let Some(k) = self.spot_get((self.gi(), s, g)) {
				let sp = &spots[k];
				return Some((goal.map?, sp.x, sp.y, goal.era, sp.r));
			}
		}
		Some((goal.map?, goal.x?, goal.y?, goal.era, None))
	}

	// ------------------------------------------------------------------ focus groups and waypoint

	/// whoOf: 0 here, 1 npc, 2 object.
	fn who_of(&mut self, s: usize, g: usize) -> (u8, Option<u32>) {
		let goal = self.gd().goal(s, g);
		if matches!(goal.t, T::Accept | T::Turnin | T::Talk | T::Train | T::Vendor | T::Sethome | T::Getfp | T::Learn | T::Buy | T::Interact) {
			let (npc, _) = self.npc_of(s, g);
			if npc.is_some() {
				return (1, npc);
			}
			if goal.object.is_some() && !(goal.t == T::Interact && goal.quest.is_some()) {
				return (2, goal.object);
			}
		}
		(0, None)
	}

	fn still_blocks(&mut self, s: usize, g: usize) -> bool {
		blocks(self.gd().goal(s, g)) && self.goal_applies(s, g) && self.unavailable_for(s, g, 0).is_none() && !self.goal_done(s, g).done
	}

	/// stepGroups -> groups, focus.
	pub(crate) fn step_groups(&mut self, s: usize) -> (Vec<Group>, Option<usize>) {
		let n = self.gd().step(s).goals.len();
		let mut groups: Vec<Group> = Vec::new();
		let mut cur: Option<usize> = None;
		let mut held: Vec<usize> = Vec::new();
		for g in 1..=n {
			if !self.goal_applies(s, g) {
				match cur {
					Some(c) => groups[c].goals.push(g),
					None => held.push(g),
				}
			} else {
				let (kind, id) = self.who_of(s, g);
				if cur.is_none_or(|c| groups[c].kind != kind || groups[c].id != id) {
					groups.push(Group { kind, id, goals: std::mem::take(&mut held), map: false, pending: 0 });
					cur = Some(groups.len() - 1);
				}
				groups[cur.unwrap()].goals.push(g);
			}
		}
		if !held.is_empty() {
			groups.insert(0, Group { kind: 0, id: None, goals: held, map: false, pending: 0 });
		}
		let mut focus = None;
		for k in 0..groups.len() {
			let goals = groups[k].goals.clone();
			let mut pending = 0;
			for g in goals {
				if self.still_blocks(s, g) {
					pending += 1;
				}
				if !groups[k].map && self.goal_applies(s, g) && self.pos_of(s, g).is_some() {
					groups[k].map = true;
				}
			}
			groups[k].pending = pending;
			if focus.is_none() && pending > 0 {
				focus = Some(k);
			}
		}
		(groups, focus)
	}

	fn is_header(&mut self, s: usize, g: usize, grp: &Group) -> bool {
		let step = self.gd().step(s);
		let goal = &step.goals[g - 1];
		if goal.t != T::Goto || step.title.is_none() || goal.text != step.title || grp.kind != 0 {
			return false;
		}
		for &j in &grp.goals {
			if j != g && step.goals[j - 1].t != T::Note && self.goal_applies(s, j) {
				return true;
			}
		}
		false
	}

	/// Own.currentGoal -> goal, header.
	fn current_goal(&mut self, s: usize, grp: &Group) -> (Option<usize>, Option<usize>) {
		let (mut header, mut optional) = (None, None);
		for &g in &grp.goals {
			let goal = self.gd().goal(s, g);
			if goal.t != T::Note && self.goal_applies(s, g) && self.unavailable_for(s, g, 0).is_none() && !self.goal_skipped(s, g) && !self.goal_done(s, g).done {
				if self.is_header(s, g, grp) {
					header = header.or(Some(g));
				} else if !goal.optional {
					let h = header.or_else(|| grp.goals.iter().copied().find(|&j| j > g && self.is_header(s, j, grp) && !self.goal_done(s, j).done));
					return (Some(g), h);
				} else {
					optional = optional.or(Some(g));
				}
			}
		}
		(optional.or(header), header)
	}

	/// waypointOf: the goal leads the arrow when it has a place and is open.
	fn waypoint_of(&mut self, s: usize, g: usize, at: bool) -> bool {
		let has = if at { true } else { self.pos_of(s, g).is_some() };
		has && self.goal_applies(s, g) && self.unavailable_for(s, g, 0).is_none() && !self.goal_skipped(s, g) && !self.goal_done(s, g).done
	}

	/// findWaypoint: the arrow's goal of the current step (for the spawn-area poll).
	fn find_waypoint(&mut self) -> Option<GRef> {
		let cur = self.current?;
		let (groups, focus) = self.step_groups(cur);
		let grp = &groups[focus?];
		let (cg, header) = self.current_goal(cur, grp);
		let gi = self.gi();
		if let Some(g) = cg {
			if self.waypoint_of(cur, g, false) {
				return Some((gi, cur, g));
			}
		}
		if let Some(h) = header {
			if self.waypoint_of(cur, h, false) {
				return Some((gi, cur, h));
			}
		}
		for rank in 1..=3 {
			for &g in &grp.goals {
				let goal = self.gd().goal(cur, g);
				let r = if goal.t == T::Note {
					3
				} else if goal.optional {
					2
				} else {
					1
				};
				if r == rank && self.waypoint_of(cur, g, false) {
					return Some((gi, cur, g));
				}
			}
		}
		let cg = cg?;
		self.gd().goal(cur, cg).quest?;
		let fk = focus.unwrap();
		if grp.map {
			return self.waypoint_of(cur, cg, true).then_some((gi, cur, cg));
		}
		let q = self.gd().goal(cur, cg).quest;
		for k in (0..fk).rev() {
			let before = &groups[k];
			if before.map && before.goals.iter().any(|&j| self.gd().goal(cur, j).quest == q) {
				return self.waypoint_of(cur, cg, true).then_some((gi, cur, cg));
			}
		}
		None
	}

	/// The waypoint goal when it has spawn areas (Spots.waypointGoal).
	fn waypoint_spots(&self) -> Option<GRef> {
		let wp = self.waypoint?;
		if Some(wp.0) != self.guide || Some(wp.1) != self.current {
			return None;
		}
		self.gs[wp.0].goal(wp.1, wp.2).spots.as_ref().map(|_| wp)
	}

	/// The reads signature() and the window make at each evaluation of the current step: candidate picks
	/// and the spawn areas stepGroups places.
	fn signature(&mut self) {
		let Some(cur) = self.current else { return };
		for g in 1..=self.gd().step(cur).goals.len() {
			self.goal_status(cur, g, true);
			if self.gd().goal(cur, g).candidates.is_some() {
				self.chosen(cur, g);
			}
		}
		self.step_groups(cur);
	}

	// ------------------------------------------------------------------ latches

	/// latch(kind, npc): an NPC interaction checks off the live step's talk/train/vendor (sethome) goals.
	pub fn latch(&mut self, kind: Kind, npc: Option<u32>) -> bool {
		if self.guide.is_none() || self.current.is_none() || !self.have_player {
			return false;
		}
		let mut hit = false;
		for pass in 0..2 {
			let s = if pass == 0 { self.current } else { self.computed };
			let Some(s) = s else { continue };
			if pass == 1 && Some(s) == self.current {
				continue;
			}
			for g in 1..=self.gd().step(s).goals.len() {
				let goal = self.gd().goal(s, g);
				let t_ok = match kind {
					Kind::Talk => goal.t == T::Talk,
					Kind::Train => goal.t == T::Train,
					Kind::Vendor => goal.t == T::Vendor,
					Kind::Sethome => goal.t == T::Sethome,
				};
				let mut ok = t_ok && self.goal_applies(s, g);
				if ok {
					ok = match kind {
						Kind::Talk => goal.npc == npc,
						// Engine.IsSethomeInnkeeper: a located sethome needs its inn's innkeeper (never known here).
						Kind::Sethome => goal.location.is_none() || (npc.is_some() && npc == self.find_inn(goal.npc, goal.location.as_deref()).map(|k| self.wd.inns[k].npc).or(goal.npc)),
						Kind::Train if is_profession_train(goal) => false,
						_ => match (&goal.candidates, npc) {
							(Some(cands), Some(n)) => cands.iter().any(|c| c.npc == Some(n)),
							_ => true,
						},
					};
				}
				if ok && self.set_check(s, g, Check::Latched) {
					hit = true;
				}
			}
		}
		hit
	}

	fn latch_open_frame(&mut self) -> bool {
		if self.open_npc.is_none() && self.open_kind.is_none() {
			return false;
		}
		let mut hit = if self.open_npc.is_some() { self.latch(Kind::Talk, self.open_npc) } else { false };
		if matches!(self.open_kind, Some(Kind::Train) | Some(Kind::Vendor)) {
			hit = self.latch(self.open_kind.unwrap(), self.open_npc) || hit;
		}
		hit
	}

	/// Own.latchTurnin: a `turnin ... direct` hand-in checks off its goal in the live step.
	fn latch_turnin(&mut self, q: u32) {
		if self.guide.is_none() {
			return;
		}
		for pass in 0..2 {
			let s = if pass == 0 { self.current } else { self.computed };
			let Some(s) = s else { continue };
			if pass == 1 && Some(s) == self.current {
				continue;
			}
			for g in 1..=self.gd().step(s).goals.len() {
				let goal = self.gd().goal(s, g);
				if goal.t == T::Turnin && goal.direct && goal.quest == Some(q) && self.goal_applies(s, g) {
					self.set_check(s, g, Check::Latched);
				}
			}
		}
	}

	/// Own.latchCast.
	pub fn latch_cast(&mut self, spell: u32) -> bool {
		if self.guide.is_none() {
			return false;
		}
		let mut hit = false;
		let mut steps = Vec::new();
		if let Some(c) = self.current {
			steps.push(c);
		}
		if let Some(c) = self.computed {
			if Some(c) != self.current {
				steps.push(c);
			}
		}
		for s in self.gd().along.clone() {
			if Some(s) != self.current && Some(s) != self.computed && self.along_listed(s) {
				steps.push(s);
			}
		}
		for s in steps {
			for g in 1..=self.gd().step(s).goals.len() {
				let goal = self.gd().goal(s, g);
				if goal.t == T::Cast && goal.spell == Some(spell) && self.goal_applies(s, g) && self.set_check(s, g, Check::Latched) {
					hit = true;
				}
			}
		}
		hit
	}

	// ------------------------------------------------------------------ events

	/// requestUpdate: one evaluation, at most every MIN_INTERVAL.
	pub fn request_update(&mut self) {
		if self.scheduled || self.guide.is_none() {
			return;
		}
		self.scheduled = true;
		let wait = self.last_eval + MIN_INTERVAL - self.now;
		self.timers.push(Timer { at: self.now + if wait > 0.0 { wait } else { 0.0 }, kind: TimerKind::Flush });
	}

	pub fn flush(&mut self) {
		self.scheduled = false;
		self.evaluate();
	}

	/// Own.clearMarks: a level-up or turn-in clears the unavailable marks (refusals of passed steps stay).
	pub fn clear_marks(&mut self) {
		if !self.have_player {
			self.unavailable.clear();
			return;
		}
		self.refresh_player();
		let mut passed = FxHashSet::default();
		if let Some(gi) = self.guide {
			for (&q, u) in &self.unavailable {
				if u.accept.0 == gi && u.accept.1 <= self.passed_up_to && u.reason != Reason::Closed {
					passed.insert(q);
				}
			}
		}
		let keys: Vec<u32> = self.unavailable.keys().copied().collect();
		for q in keys {
			let u = self.unavailable[&q];
			let now = if passed.contains(&q) {
				let a = self.gs[u.accept.0].goal(u.accept.1, u.accept.2);
				Some(if a.min_level.is_some_and(|l| self.pl_level < l) {
					Reason::Level
				} else if self.missing_pre_of(&a.pre, &a.pre_all).is_some() {
					Reason::Pre
				} else {
					Reason::Offer
				})
			} else {
				None
			};
			match now {
				Some(r) if u.reason == Reason::Offer || r != Reason::Offer => {
					if u.reason != Reason::Offer {
						self.unavailable.get_mut(&q).unwrap().reason = r;
					}
				}
				_ => {
					self.unavailable.remove(&q);
				}
			}
		}
	}

	/// checkOffers("gossip"): a gossip window listing no quests marks the live step's accepts at that
	/// giver unavailable.
	pub fn check_offers_gossip(&mut self, npc: Option<u32>) {
		if !self.have_player {
			return;
		}
		let Some(npc) = npc else { return };
		let (Some(_), Some(cur)) = (self.guide, self.current) else { return };
		let gi = self.gi();
		for g in 1..=self.gd().step(cur).goals.len() {
			let goal = self.gd().goal(cur, g);
			let Some(q) = goal.quest else { continue };
			if goal.t == T::Accept
				&& (goal.npc == Some(npc) || goal.object == Some(npc))
				&& self.goal_applies(cur, g)
				&& !self.w.on_quest(q)
				&& !self.quest_done(q)
				&& !self.unavailable.contains_key(&q)
			{
				let reason = if goal.min_level.is_some_and(|l| self.pl_level < l) {
					Reason::Level
				} else if self.missing_pre_of(&goal.pre, &goal.pre_all).is_some() {
					Reason::Pre
				} else {
					Reason::Offer
				};
				self.unavailable.insert(q, Mark { reason, accept: (gi, cur, g), by: None });
			}
		}
	}

	pub fn on_quest_accepted(&mut self, q: u32) {
		self.request_update();
		self.unavailable.remove(&q);
	}

	pub fn on_log_update(&mut self) {
		self.request_update();
		self.log_ready = true;
	}

	pub fn on_turned_in(&mut self, q: u32) {
		self.turned_in.insert(q);
		if self.have_player {
			self.latch_turnin(q);
		}
		self.clear_marks();
		self.request_update();
	}

	pub fn on_level_up(&mut self, level: f64) {
		if level > self.level_seen {
			self.level_seen = level;
		}
		self.clear_marks();
		self.request_update();
	}

	pub fn on_context(&mut self) {
		self.context_gen += 1;
		self.request_update();
	}

	pub fn on_bound(&mut self) {
		if self.have_player {
			self.latch(Kind::Sethome, self.w.npc_unit);
		}
		self.request_update();
		// Nav onBound: remember which inn the bind location means (the innkeeper, else the nearest inn).
		let Some(loc) = self.w.bind_location().map(str::to_lowercase) else { return };
		let mut inn = self.w.npc_unit.and_then(|n| self.wd.inns.iter().rposition(|i| i.npc == n));
		if inn.is_none() {
			if let Some((c, px, py)) = self.w.player_world() {
				let mut best = 60.0;
				for (k, i) in self.wd.inns.iter().enumerate() {
					let d = if i.c != c { f64::INFINITY } else { ((i.wx - px).powi(2) + (i.wy - py).powi(2)).sqrt() };
					if d <= best {
						best = d;
						inn = Some(k);
					}
				}
			}
		}
		if let Some(k) = inn {
			self.inn_flags.insert(loc, self.wd.inns[k].npc);
		}
	}

	/// Nav.FindInn(npc, name): the inn of an innkeeper, else of a bind location name.
	fn find_inn(&self, npc: Option<u32>, name: Option<&str>) -> Option<usize> {
		let inns = &self.wd.inns;
		npc.and_then(|n| inns.iter().rposition(|i| i.npc == n)).or_else(|| {
			let key = name?.to_lowercase();
			inns.iter().rposition(|i| i.names.iter().any(|x| x.to_lowercase() == key))
		})
	}

	/// Nav.BoundInn: the inn learned for the bind location, else the inn of that name.
	fn bound_inn(&self) -> Option<usize> {
		let key = self.w.bind_location()?.to_lowercase();
		let inns = &self.wd.inns;
		if let Some(&n) = self.inn_flags.get(&key) {
			if let Some(k) = inns.iter().rposition(|i| i.npc == n) {
				return Some(k);
			}
		}
		inns.iter().rposition(|i| i.names.iter().any(|x| x.to_lowercase() == key))
	}

	/// onNpcFrame(kind).
	pub fn on_npc_frame(&mut self, kind: Kind) {
		let npc = self.w.npc_unit;
		self.open_npc = npc;
		self.open_kind = Some(kind);
		if self.have_player {
			if npc.is_some() {
				self.latch(Kind::Talk, npc);
			}
			if kind != Kind::Talk {
				self.latch(kind, npc);
			}
		}
		self.request_update();
	}

	/// noteClassTrainer: a trainer window of the character's class: trained at this level.
	pub fn note_class_trainer(&mut self) {
		let Some(npc) = self.open_npc else { return };
		let is = self.wd.class_trainers.get(&npc).is_some_and(|cls| cls.contains(&self.w.class));
		if !is {
			return;
		}
		self.refresh_player();
		self.class_train_visit = Some(self.pl_level);
	}

	pub fn on_frame_closed(&mut self) {
		self.open_npc = None;
		self.open_kind = None;
	}

	// ------------------------------------------------------------------ arrival

	fn arrive_loaded(&mut self, c: i64, px: f64, py: f64) -> bool {
		let (Some(_), Some(cur)) = (self.guide, self.current) else { return false };
		let gi = self.gi();
		let step = self.gd().step(cur);
		let mut hit = false;
		for g in 1..=step.goals.len() {
			let goal = &step.goals[g - 1];
			if !matches!(goal.t, T::Goto | T::Explore | T::Die) || self.arrived.contains(&(gi, cur, g)) || !self.goal_applies(cur, g) {
				continue;
			}
			let gw = match (goal.map, goal.x, goal.y) {
				(Some(m), Some(x), Some(y)) => self.w.map_to_world(m, x, y, goal.era),
				_ => None,
			};
			let r = goal.r.unwrap_or(if goal.t == T::Die { DIE_RADIUS } else { DEFAULT_RADIUS });
			let (gc, gx, gy) = match gw {
				Some((gc, gx, gy)) => (Some(gc), gx, gy),
				None => (None, 0.0, 0.0),
			};
			let mut here = gc == Some(c) && (gx - px).powi(2) + (gy - py).powi(2) <= r * r;
			if !here && goal.t == T::Goto && step.title.is_some() && goal.text == step.title {
				for j in 1..=step.goals.len() {
					let other = &step.goals[j - 1];
					if j != g && other.t != T::Goto && other.t != T::Note && self.goal_applies(cur, j) && self.reached(cur, j, c, px, py) {
						here = true;
						break;
					}
				}
			}
			if here {
				self.arrived.insert((gi, cur, g));
				hit = true;
			}
		}
		hit
	}

	/// Own.reached.
	fn reached(&mut self, s: usize, g: usize, c: i64, px: f64, py: f64) -> bool {
		let Some((map, x, y, era, area)) = self.pos_of(s, g) else { return false };
		let Some((gc, gx, gy)) = self.w.map_to_world(map, x, y, era) else { return false };
		if gc != c {
			return false;
		}
		let r = area.unwrap_or(0.0) + self.gd().goal(s, g).r.unwrap_or(DEFAULT_RADIUS);
		(gx - px).powi(2) + (gy - py).powi(2) <= r * r
	}

	/// checkArrival (the ticker and PLAYER_UNGHOST).
	pub fn check_arrival(&mut self) {
		if self.guide.is_none() {
			return;
		}
		let Some((c, px, py)) = self.w.player_world() else { return };
		let mut hit = self.arrive_loaded(c, px, py);
		if let Some(sg) = self.waypoint_spots() {
			if self.spot_repick(sg, Some((c, px, py))) {
				hit = true;
			}
		}
		if hit {
			self.request_update();
		}
	}

	fn needs_arrival(&mut self) -> bool {
		let (Some(_), Some(cur)) = (self.guide, self.current) else { return false };
		for g in 1..=self.gd().step(cur).goals.len() {
			let t = self.gd().goal(cur, g).t;
			if matches!(t, T::Goto | T::Explore | T::Die) && self.goal_applies(cur, g) && !self.goal_done(cur, g).done {
				return true;
			}
		}
		false
	}

	fn update_ticker(&mut self) {
		let need = self.needs_arrival() || self.waypoint_spots().is_some();
		if need && self.ticker.is_none() {
			self.next_handle += 1;
			let h = self.next_handle;
			self.ticker = Some(h);
			self.timers.push(Timer { at: self.now + ARRIVAL_POLL, kind: TimerKind::Tick(h) });
		} else if !need && self.ticker.is_some() {
			self.ticker = None;
		}
	}

	/// A ticker firing: polls arrival and schedules its next tick (cancelled tickers do nothing).
	pub fn tick(&mut self, h: u64) {
		if self.ticker != Some(h) {
			return;
		}
		self.check_arrival();
		if self.ticker == Some(h) {
			self.timers.push(Timer { at: self.now + ARRIVAL_POLL, kind: TimerKind::Tick(h) });
		}
	}

	// ------------------------------------------------------------------ evaluation and hand-over

	/// resetLoaded: a new guide in the tab.
	pub fn reset_loaded(&mut self, gi: usize, auto: bool) {
		if !auto {
			self.completed_fired.remove(&gi);
		}
		self.guide = Some(gi);
		self.current = None;
		self.computed = None;
		self.passed_up_to = 0;
		self.auto_chain = auto;
		self.saw_incomplete = false;
		self.pin = None;
		self.pin_done = None;
		self.placing = Some(self.now + PLACE_SECONDS);
		self.opened.insert(gi);
	}

	/// The login's tab (restoredTab): opened for the player, placed on its first evaluation.
	pub fn open_tab(&mut self, gi: usize) {
		self.guide = Some(gi);
		self.current = None;
		self.computed = None;
		self.passed_up_to = 0;
		self.auto_chain = true;
		self.saw_incomplete = false;
		self.pin = None;
		self.pin_done = None;
		self.placing = Some(self.now + PLACE_SECONDS);
		self.opened.insert(gi);
	}

	/// routeNext: the guide to continue with (one option, the remembered one, or the recommended one).
	fn route_next(&mut self, from: usize) -> Option<usize> {
		let gs: &'a [Guide] = self.gs;
		let f = &gs[from];
		let Some(choices) = &f.next_choices else { return f.next.as_deref().and_then(|id| self.by_id.get(id).copied()) };
		if !self.have_player {
			self.refresh_player();
		}
		let mut options = Vec::new();
		for id in choices {
			let Some(&g) = self.by_id.get(id.as_str()) else { continue };
			if self.guide_matches(&gs[g]) && self.option_holds(from, id) {
				options.push(g);
			}
		}
		match options.len() {
			0 => None,
			1 => Some(options[0]),
			_ => {
				if let Some(&r) = self.routes.get(&from) {
					if options.contains(&r) {
						return Some(r);
					}
				}
				// rankRoutes: not outlevelled, then quickest (1-minute bands) to the guide's start, then author order.
				let here = self.w.player_world();
				let mut best: Option<(usize, f64, f64)> = None;
				for &o in &options {
					let a = if gs[o].max_level.is_some_and(|m| self.pl_level >= m) { 1.0 } else { 0.0 };
					let secs = here.and_then(|(c, px, py)| {
						let start = gs[o].steps.iter().flat_map(|s| &s.goals).find_map(|x| Some((x.map?, x.x?, x.y?, x.era)))?;
						let (gc, gx, gy) = self.w.map_to_world(start.0, start.1, start.2, start.3)?;
						Some(if gc != c { CROSS_CONTINENT } else { ((gx - px).powi(2) + (gy - py).powi(2)).sqrt() / RUN_SPEED })
					});
					let b = secs.map_or(f64::INFINITY, |s| (s / 60.0).floor());
					if best.is_none_or(|(_, k1, k2)| a < k1 || (a == k1 && b < k2)) {
						best = Some((o, a, b));
					}
				}
				best.map(|b| b.0)
			}
		}
	}

	/// evaluateLoaded(active).
	fn evaluate_loaded(&mut self) {
		let Some(gi) = self.guide else {
			self.current = None;
			self.computed = None;
			return;
		};
		let gate = self.start_gate();
		self.computed = match gate {
			Some(s) => Some(s),
			None => self.compute_current(),
		};
		let was_placing = self.placing.is_some();
		if let Some(p) = self.placing {
			if self.log_ready || self.now >= p {
				self.placing = None;
			}
		}
		let placed = was_placing && self.placing.is_none();
		if self.computed.is_some() {
			self.saw_incomplete = true;
		}
		let n = self.gd().steps.len();
		let passed = self.computed.unwrap_or(n + 1) - 1;
		if passed > self.passed_up_to {
			self.latch_passed(self.passed_up_to + 1, passed);
		}
		self.latch_caught_up(passed);
		self.passed_up_to = passed;
		// The view of another step: released once it is the live step (or no longer applies); while the
		// step looked at gets done it follows forward, behind the live step up to it, ahead of it to the
		// next open step, its transient goals latched like any step the route moves past.
		if let Some(p) = self.pin {
			if self.computed == Some(p) || p > n || !self.step_applies(p) {
				self.pin = None;
			}
		}
		if let Some(p) = self.pin {
			let done = self.step_done(p);
			if done && self.pin_done != Some(true) {
				self.latch_passed(p, p);
				let limit = self.computed.filter(|&c| c > p);
				self.pin = self.next_open(p, limit);
				self.pin_done = self.pin.map(|q| self.step_done(q));
			} else {
				self.pin_done = Some(done);
			}
		}
		let new_current = self.pin.or(self.computed);
		let changed = new_current != self.current;
		let mut latched = false;
		if let Some(nc) = new_current {
			self.latch_in_step(nc, Some(nc) == self.computed);
		}
		if let (Some(_), Some(c)) = (self.pin, self.computed) {
			self.latch_in_step(c, true);
		}
		if changed {
			self.current = new_current;
			if let Some(cur) = self.current {
				let goals = self.gd().step(cur).goals.len();
				let mut pos = None;
				let mut have_pos = false;
				for g in 1..=goals {
					let goal = self.gd().goal(cur, g);
					if goal.candidates.is_some() {
						self.picks.remove(&(gi, cur, g));
					}
					if goal.spots.is_some() && self.spot_chosen.contains_key(&(gi, cur, g)) {
						if !have_pos {
							pos = self.w.player_world();
							have_pos = true;
						}
						if pos.is_some() {
							self.spot_repick((gi, cur, g), pos);
						}
					}
				}
				latched = self.latch_open_frame();
			}
		}
		self.signature();
		self.waypoint = self.find_waypoint();
		if latched {
			self.request_update();
		}
		if self.current.is_none() && !self.completed_fired.contains(&gi) {
			self.completed_fired.insert(gi);
			let through = self.placed_through.remove(&gi);
			let may_chain = (self.auto_chain || self.saw_incomplete || through) && self.auto_next;
			let next = self.route_next(gi);
			if let Some(nx) = next {
				let again = through && !self.chain_seen.contains(&nx) && nx != gi;
				if may_chain && (again || !self.completed_fired.contains(&nx)) && Some(nx) != self.guide {
					if through {
						self.chain_seen.insert(gi);
						self.completed_fired.remove(&nx);
					}
					self.opened.remove(&gi);
					self.reset_loaded(nx, true);
					self.evaluate_loaded();
					return;
				}
			}
		}
		if placed {
			self.chain_seen.clear();
			self.opened.remove(&gi);
		}
	}

	/// evaluate(): every tab (one), then the arrival poll.
	pub fn evaluate(&mut self) {
		self.last_eval = self.now;
		self.refresh_player();
		self.evaluate_loaded();
		self.update_ticker();
	}

	/// Own.startGate: a Class guide the character cannot start yet holds at its opening.
	fn start_gate(&mut self) -> Option<usize> {
		let gd = self.gd();
		if gd.category.as_deref() != Some("Class") {
			return None;
		}
		let gi = self.gi();
		if self.skipped_steps.get(&gi).is_some_and(|k| !k.is_empty()) || self.skipped_goals.get(&gi).is_some_and(|k| !k.is_empty()) || self.manual.get(&gi).is_some_and(|m| !m.is_empty()) {
			return None;
		}
		for step in &gd.steps {
			for goal in &step.goals {
				if let Some(q) = goal.quest {
					if self.w.on_quest(q) || self.quest_done(q) {
						return None;
					}
				}
			}
		}
		let level = self.pl_level;
		for (i, step) in gd.steps.iter().enumerate() {
			if !self.matches(&step.only) {
				continue;
			}
			let (mut opening, mut need, mut doable, mut accept_level, mut pre) = (false, 0.0f64, false, None::<f64>, false);
			for goal in &step.goals {
				if !self.matches(&goal.only) {
					continue;
				}
				if goal.t == T::Level {
					opening = true;
					need = need.max(goal.level.unwrap_or(0.0));
				} else if goal.t == T::Accept {
					opening = true;
					match goal.min_level {
						Some(l) if level < l => {
							if accept_level.is_none_or(|a| l < a) {
								accept_level = Some(l);
							}
						}
						_ => {
							if self.missing_pre_of(&goal.pre, &goal.pre_all).is_some() {
								pre = true;
							} else if !goal.closed_by.iter().flatten().any(|&by| self.w.on_quest(by) || self.quest_done(by)) {
								doable = true;
							}
						}
					}
				}
			}
			if opening {
				if !doable {
					if let Some(a) = accept_level {
						need = need.max(a);
					}
				}
				if need > level || (!doable && pre) {
					return Some(i + 1);
				}
				return None;
			}
		}
		None
	}

	// ------------------------------------------------------------------ player actions on the engine

	/// Engine.ToggleGoal: the player's tick (false when the goal is a note or already done).
	pub fn toggle_goal(&mut self, s: usize, g: usize) -> bool {
		if self.guide.is_none() {
			return false;
		}
		let goal = self.gd().goal(s, g);
		if goal.t == T::Note {
			return false;
		}
		self.refresh_player();
		let gi = self.gi();
		if self.manual.get(&gi).is_some_and(|m| m.contains_key(&(s, g))) {
			self.manual.get_mut(&gi).unwrap().remove(&(s, g));
		} else if self.goal_done(s, g).done {
			return false;
		} else {
			self.manual.entry(gi).or_default().insert((s, g), Check::Tick);
		}
		self.placing = None;
		self.evaluate();
		true
	}

	/// Engine.Skip: skip the live step for good (a step looked at: the view moves to the next applicable one).
	pub fn skip(&mut self) {
		let (Some(gi), Some(cur)) = (self.guide, self.current) else { return };
		self.refresh_player();
		self.placing = None;
		self.skipped_steps.entry(gi).or_default().insert(cur);
		if let Some(p) = self.pin {
			let next = self.next_applicable(p);
			self.view_step(next);
		}
		self.evaluate();
	}

	/// nextOpen: the first applicable step after `from` still open, below `limit`.
	fn next_open(&mut self, from: usize, limit: Option<usize>) -> Option<usize> {
		let end = limit.unwrap_or(self.gd().steps.len() + 1);
		(from + 1..end).find(|&s| self.step_applies(s) && !self.is_skipped(s) && !self.step_done(s))
	}

	/// nextApplicable.
	fn next_applicable(&mut self, from: usize) -> Option<usize> {
		let n = self.gd().steps.len();
		(from + 1..=n).find(|&s| self.step_applies(s))
	}

	#[cfg(feature = "native")]
	/// clearInStep: forget the in-step bag-count latches of step s (the player's ticks stay).
	fn clear_in_step(&mut self, s: usize) {
		let gi = self.gi();
		let gd = self.gd();
		let Some(m) = self.manual.get_mut(&gi) else { return };
		for (g, goal) in gd.step(s).goals.iter().enumerate() {
			if is_bag_count(goal) && m.get(&(s, g + 1)) == Some(&Check::Latched) {
				m.remove(&(s, g + 1));
			}
		}
	}

	/// Own.view: look at step s instead of the live one (None, or the live step: back to it).
	fn view_step(&mut self, s: Option<usize>) {
		match s {
			Some(s) if self.computed != Some(s) => {
				self.pin = Some(s);
				self.pin_done = Some(self.step_done(s));
			}
			_ => {
				self.pin = None;
				self.pin_done = None;
			}
		}
	}

	#[cfg(feature = "native")]
	/// Engine.Goto(i): look at step i, a jump back or ahead that changes nothing, except that a skipped
	/// step jumped to is open again.
	pub fn goto(&mut self, i: usize) {
		let Some(gi) = self.guide else { return };
		if i == 0 || i > self.gd().steps.len() {
			return;
		}
		self.refresh_player();
		if !self.step_applies(i) {
			return;
		}
		self.placing = None;
		if self.skipped_steps.get_mut(&gi).is_some_and(|k| k.remove(&i)) {
			// A jumped step looked at again takes no jump, or the route would jump straight back.
			if self.gd().step(i).skipto.is_some() {
				self.when_held.entry(gi).or_default().insert(i);
			}
		}
		let comp = self.compute_current();
		if let Some(c) = comp {
			if i < c && self.current == Some(c) {
				self.clear_in_step(c);
			}
		}
		self.computed = comp;
		self.view_step(Some(i));
		self.evaluate();
	}
}
