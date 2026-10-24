//! The one availability rule (port of tools/lib/judge/rules.js available/levelOk/makeRules and
//! the character's quest set of tools/lib/sim/run.js compileRun + judge simRules): when a quest
//! is open to a character. The simulator and the judge both read it, so they agree.
//!
//! `Rules::new(world, race, cls, dungeons)` is the character's run view of the world: the
//! quests open to the race/class (questOpen, Zephras Isle for Skyborne only), their
//! prerequisites reduced to that set to a fixed point (compileRun), and the solo set (not
//! group work: an elite quest and every quest needing one, compile.js qGroup).

use crate::data::Quest;
use crate::prereqs::blocking_prereqs;
use crate::world::{WQuest, World};
use forge_core::{js_to_fixed, race_by_file, Faction, ALL_CLASSES, CLASSES};
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::BTreeMap;

/// The quest is grey below the whole level minus this (judge rules.js GREY_BELOW).
pub const GREY_BELOW: f64 = 5.0;
/// Levels above the character's a quest may be taken at (sim/v2/sweep.js ACCEPT_ABOVE).
pub const ACCEPT_ABOVE: f64 = 2.0;

/// A quest's prerequisites as a rule reads them.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Prereqs {
	pub any: Vec<i64>,
	pub all: Vec<i64>,
	pub parent: Option<i64>,
	pub excl: Vec<i64>,
}

/// The data's own prerequisites (rules.js dataPrereqs: blockingPrereqs, no parent rule).
pub fn data_prereqs(quests: &BTreeMap<u32, Quest>, rec: &Quest) -> Prereqs {
	let q = |id: i64| u32::try_from(id).ok().and_then(|i| quests.get(&i));
	let b = blocking_prereqs(rec, &q);
	Prereqs { any: b.any, all: b.all, parent: None, excl: rec.excl.clone() }
}

/// A character at a point of a walk: level, turned-in quests (`done`) and accepted ones
/// (`taken`: in the log or done), and optionally faction, race (file or label) and class.
pub struct State<'a> {
	pub level: f64,
	pub done: &'a dyn Fn(i64) -> bool,
	pub taken: &'a dyn Fn(i64) -> bool,
	pub faction: Option<Faction>,
	pub race: Option<&'a str>,
	pub cls: Option<&'a str>,
}

/// rules.js available(): Ok, or the first failed condition (for reports).
pub fn available(rec: Option<&Quest>, state: &State, quests: &BTreeMap<u32, Quest>, prereqs_of: Option<&dyn Fn(&Quest) -> Prereqs>) -> Result<(), String> {
	let Some(rec) = rec else { return Err("not in the data".into()) };
	let q = rec.id as i64;
	let title = |id: i64| u32::try_from(id).ok().and_then(|i| quests.get(&i)).map(|r| r.title.clone().unwrap_or_else(|| "undefined".into()));
	if rec.start.npc.is_empty() && rec.start.object.is_empty() {
		return Err("item-started".into());
	}
	if let (Some(race), Some(races)) = (state.race, rec.races.filter(|r| *r != 0.0)) {
		let key: String = race.to_lowercase().chars().filter(|c| !c.is_whitespace() && *c != '_' && *c != '-').collect();
		let r = forge_core::RACES.iter().find(|r| r.key == key || (key == "scourge" && r.file == "Scourge"));
		let bit = r.and_then(|r| match state.faction {
			Some(f) => Some(r.bit(f)).filter(|b| *b != 0),
			None => [r.alliance, r.horde].into_iter().find(|b| *b != 0),
		});
		if let Some(bit) = bit {
			if (races as u64) & bit == 0 {
				return Err("other race".into());
			}
		}
	}
	if let (Some(cls), Some(classes)) = (state.cls, rec.classes.filter(|c| *c != 0.0)) {
		if let Some(c) = CLASSES.iter().find(|c| c.key == cls.to_lowercase()) {
			if (classes as u64) & u64::from(c.bit) == 0 {
				return Err("other class".into());
			}
		}
	}
	if (state.taken)(q) || (state.done)(q) {
		return Err("already taken".into());
	}
	let b = match prereqs_of {
		Some(f) => f(rec),
		None => data_prereqs(quests, rec),
	};
	let mut missing: Vec<i64> = b.all.iter().copied().filter(|&p| !(state.done)(p)).collect();
	if missing.is_empty() && !b.any.is_empty() && !b.any.iter().any(|&p| (state.done)(p)) {
		missing = b.any.clone();
	}
	if !missing.is_empty() {
		let names: Vec<String> = missing.iter().map(|&p| format!("{p} {}", title(p).unwrap_or_default()).trim().to_string()).collect();
		return Err(format!("needs {} first", names.join(" / ")));
	}
	if let Some(p) = b.parent {
		if !(state.taken)(p) || (state.done)(p) {
			return Err(format!("needs {p} in the log"));
		}
	}
	if let Some(e) = b.excl.iter().find(|&&e| e != 0 && ((state.taken)(e) || (state.done)(e))) {
		return Err(format!("excluded by {e}"));
	}
	let min_l = rec.min_level.filter(|m| *m != 0.0 && !m.is_nan()).unwrap_or(1.0);
	if state.level < min_l {
		return Err(format!("level {} < minLevel {}", js_to_fixed(state.level, 1), forge_core::js_to_string(min_l)));
	}
	Ok(())
}

/// The simulator's accept window: not grey (quest level >= whole level - GREY_BELOW) and not
/// above whole level + ACCEPT_ABOVE.
pub fn level_ok(q_level: f64, level: f64) -> bool {
	let l = level.floor();
	let ql = if q_level != 0.0 && !q_level.is_nan() { q_level } else { 1.0 };
	ql >= l - GREY_BELOW && ql <= l + ACCEPT_ABOVE
}

/// A world quest open to a race bit / class (run.js questOpen). `rbit` 0: any race of the
/// faction; `cls` None: class masks allowing fewer than 5 classes are closed.
pub fn quest_open(q: &WQuest, faction: Faction, rbit: u64, cls: Option<u32>) -> bool {
	if let Some(r) = q.races.filter(|r| *r != 0.0) {
		let r = r as u64;
		if rbit != 0 {
			if r & rbit == 0 {
				return false;
			}
		} else if !faction.mask_open(r) {
			return false;
		}
	}
	if let Some(c) = q.classes.filter(|c| *c != 0.0) {
		let c = c as u32;
		if c & ALL_CLASSES != ALL_CLASSES {
			match cls {
				Some(bit) => {
					if c & bit == 0 {
						return false;
					}
				}
				None => {
					if (c & ALL_CLASSES).count_ones() < 5 {
						return false;
					}
				}
			}
		}
	}
	true
}

/// Zephras Isle is Skyborne-only: giver, ender, accept or task on the isle maps (run.js onIsle).
pub fn on_isle(world: &World, q: &WQuest) -> bool {
	let at = |pt: u32| matches!(world.points[pt as usize].map, 2521 | 2665);
	at(q.giver) || at(q.ender) || q.accept.as_ref().is_some_and(|a| at(a.pt)) || q.tasks.iter().any(|t| at(t.pt))
}

/// A race label ("Orc", "Undead", "Skyborne", "NightElf") -> its bit for the faction.
pub fn race_bit(race: &str, faction: Faction) -> u64 {
	let file = if race == "Undead" { "Scourge" } else { race };
	race_by_file(file).map_or(0, |r| r.bit(faction))
}

/// One character's view of a world: the open quest set with its reduced prerequisites
/// (compileRun) and the solo set (judge simRules).
pub struct Rules {
	/// Open quests by id -> index into `world.quests`.
	pub open: BTreeMap<u32, usize>,
	pre: FxHashMap<u32, Vec<i64>>,
	pre_all: FxHashMap<u32, Vec<i64>>,
	parent: FxHashMap<u32, i64>,
	excl: FxHashMap<u32, Vec<i64>>,
	group: FxHashSet<u32>,
}

impl Rules {
	/// race: a `starts` label; cls: a class label or file ("Warrior"/"WARRIOR"), None for any;
	/// dungeons: the 'dungeons' family (dungeon packages allowed).
	pub fn new(world: &World, race: &str, cls: Option<&str>, dungeons: bool) -> Rules {
		let faction = world.faction;
		let rbit = race_bit(race, faction);
		let cbit = cls.and_then(|c| CLASSES.iter().find(|x| x.file.eq_ignore_ascii_case(c))).map(|c| c.bit);
		let skyborne = race == "Skyborne";
		let by_id: FxHashMap<u32, usize> = world.quests.iter().enumerate().map(|(i, q)| (q.id, i)).collect();
		let excluded: FxHashSet<u32> = world.excluded_ids.iter().copied().collect();
		let is_open = |q: &WQuest| quest_open(q, faction, rbit, cbit) && (skyborne || !on_isle(world, q));
		let mut open: BTreeMap<u32, usize> = BTreeMap::new();
		for (i, q) in world.quests.iter().enumerate() {
			if is_open(q) && (dungeons || q.dungeon.is_none()) {
				open.insert(q.id, i);
			}
		}
		// Insertion order of the JS Map: world quest order.
		let mut order: Vec<u32> = world.quests.iter().filter(|q| open.contains_key(&q.id)).map(|q| q.id).collect();
		let blocks = |p: i64| u32::try_from(p).is_ok_and(|p| excluded.contains(&p) || by_id.get(&p).is_some_and(|&i| is_open(&world.quests[i])));
		let mut pre: FxHashMap<u32, Vec<i64>> = FxHashMap::default();
		let mut pre_all: FxHashMap<u32, Vec<i64>> = FxHashMap::default();
		let has = |open: &BTreeMap<u32, usize>, p: i64| u32::try_from(p).is_ok_and(|p| open.contains_key(&p));
		let mut changed = true;
		while changed {
			changed = false;
			for id in order.clone() {
				if !open.contains_key(&id) {
					continue;
				}
				let q = &world.quests[open[&id]];
				let mut kept = Vec::new();
				let mut blocked = false;
				for &p in &q.pre {
					if has(&open, p) {
						kept.push(p);
					} else if blocks(p) {
						blocked = true;
					}
				}
				let mut all = Vec::new();
				let mut all_blocked = false;
				for &p in &q.pre_all {
					if has(&open, p) {
						all.push(p);
					} else if blocks(p) {
						all_blocked = true;
					}
				}
				let par = q.in_log.is_some_and(|l| !has(&open, l) && blocks(l));
				let kid = q.after.iter().flatten().any(|&c| !has(&open, c as i64) && blocks(c as i64));
				if (kept.is_empty() && blocked) || all_blocked || par || kid {
					open.remove(&id);
					changed = true;
				} else {
					pre.insert(id, kept);
					pre_all.insert(id, all);
				}
			}
			order.retain(|id| open.contains_key(id));
		}
		let mut parent = FxHashMap::default();
		let mut excl = FxHashMap::default();
		for (&id, &i) in &open {
			let q = &world.quests[i];
			if let Some(l) = q.in_log.filter(|&l| has(&open, l)) {
				parent.insert(id, l);
			}
			excl.insert(id, q.excl.iter().copied().filter(|&e| has(&open, e)).collect::<Vec<_>>());
		}
		// Group work: elite, and every quest needing one (qGroup's fixed point, in id order).
		let mut group: FxHashSet<u32> = open.iter().filter(|(_, &i)| world.quests[i].elite).map(|(&id, _)| id).collect();
		let mut changed = true;
		while changed {
			changed = false;
			for (&id, &i) in &open {
				if group.contains(&id) {
					continue;
				}
				let g = |p: &i64| u32::try_from(*p).is_ok_and(|p| group.contains(&p));
				let ps = &pre[&id];
				let any = !ps.is_empty() && ps.iter().all(g);
				let all = pre_all[&id].iter().any(g) || world.quests[i].after.iter().flatten().any(|c| open.contains_key(c) && group.contains(c));
				if any || all {
					group.insert(id);
					changed = true;
				}
			}
		}
		Rules { open, pre, pre_all, parent, excl, group }
	}

	/// In the character's set and not group work (simRules soloOk).
	pub fn solo_ok(&self, q: u32) -> bool {
		self.open.contains_key(&q) && !self.group.contains(&q)
	}

	/// The character's prerequisites of a quest (simRules prereqsOf); the data's for a quest
	/// outside the set.
	pub fn prereqs_of(&self, rec: &Quest) -> Prereqs {
		match self.pre.get(&rec.id).filter(|_| self.open.contains_key(&rec.id)) {
			Some(any) => Prereqs { any: any.clone(), all: self.pre_all[&rec.id].clone(), parent: self.parent.get(&rec.id).copied(), excl: self.excl[&rec.id].clone() },
			None => {
				let mut one = BTreeMap::new();
				one.insert(rec.id, rec.clone());
				data_prereqs(&one, rec)
			}
		}
	}
}

/// A goal of a walk (judge walk.js): index, type, quest, objective, level before and after.
#[derive(Clone, Debug)]
pub struct Goal {
	pub i: usize,
	pub t: String,
	pub q: Option<i64>,
	pub oi: Option<i64>,
	pub lvl: f64,
	pub lvl_after: Option<f64>,
}

/// rules.js makeRules: the rule at goal t of a walk (after goal t; level = the level after it).
pub struct WalkRules<'a> {
	goals: &'a [Goal],
	quests: &'a BTreeMap<u32, Quest>,
	pub accept_at: FxHashMap<i64, usize>,
	pub turnin_at: FxHashMap<i64, usize>,
	pub work: FxHashMap<i64, Vec<usize>>,
	closed: crate::prereqs::ClosedBy,
}

const WORK_KINDS: [&str; 8] = ["kill", "collect", "interact", "use", "complete", "talk", "escort", "explore"];

impl<'a> WalkRules<'a> {
	pub fn new(goals: &'a [Goal], quests: &'a BTreeMap<u32, Quest>) -> Self {
		let mut accept_at = FxHashMap::default();
		let mut turnin_at = FxHashMap::default();
		let mut work: FxHashMap<i64, Vec<usize>> = FxHashMap::default();
		for (k, g) in goals.iter().enumerate() {
			let Some(q) = g.q else { continue };
			match g.t.as_str() {
				"accept" => {
					accept_at.entry(q).or_insert(g.i);
				}
				"turnin" => {
					turnin_at.entry(q).or_insert(g.i);
				}
				t if WORK_KINDS.contains(&t) => work.entry(q).or_default().push(k),
				_ => {}
			}
		}
		WalkRules { goals, quests, accept_at, turnin_at, work, closed: crate::prereqs::ClosedBy::new(quests) }
	}
	pub fn lvl_at(&self, t: usize) -> f64 {
		self.goals.get(t).map_or(1.0, |g| g.lvl_after.unwrap_or(g.lvl))
	}
	pub fn done_by(&self, p: i64, t: usize) -> bool {
		self.turnin_at.get(&p).is_some_and(|&x| x <= t)
	}
	pub fn accepted_by(&self, p: i64, t: usize) -> bool {
		self.accept_at.get(&p).is_some_and(|&x| x <= t) || self.done_by(p, t)
	}
	pub fn in_log_at(&self, q: i64, t: usize) -> bool {
		self.accept_at.get(&q).is_some_and(|&x| x <= t) && !self.done_by(q, t)
	}
	pub fn ever(&self, q: i64) -> bool {
		self.accept_at.contains_key(&q) || self.turnin_at.contains_key(&q)
	}
	/// acceptableAt(q, t) -> Ok or why not.
	pub fn acceptable_at(&self, q: i64, t: usize, prereqs_of: Option<&dyn Fn(&Quest) -> Prereqs>) -> Result<(), String> {
		let done = |p: i64| self.done_by(p, t);
		let taken = |p: i64| self.accepted_by(p, t);
		let st = State { level: self.lvl_at(t), done: &done, taken: &taken, faction: None, race: None, cls: None };
		available(u32::try_from(q).ok().and_then(|i| self.quests.get(&i)), &st, self.quests, prereqs_of)
	}
	/// A breadcrumb whose target the walk takes, or a quest whose excl partner it takes.
	pub fn closed_by_walk(&self, q: i64) -> bool {
		u32::try_from(q).ok().and_then(|i| self.quests.get(&i)).is_none() || self.closed.of(q, self.quests).iter().any(|&x| self.ever(x))
	}
}
