//! What givers' windows say about when a quest is offered: the OfferAudit rules (Fitz,
//! 2026-11-07), ported from the one-off audit that fixed #1132.
//!
//! - A refusal counts only from a giver's quest LIST (a gossip or greeting window): a quest the NPC
//!   starts (our data's giver, or offered by that NPC in any recording) that is absent from the list,
//!   not in the log and known not done. A window within [`DETAIL_S`] of a quest-detail window of the
//!   same NPC shows one quest (the one clicked, or the follow-up after a hand-in), so the rest of
//!   that NPC's quests are absent without being refused: it is never a refusal. Never seen is no
//!   evidence.
//! - A quest handed in less than [`STALE`] seconds before a window is unknown for that window (the
//!   client's log and completed lists lag), unless the window already offers a follow-up that needs
//!   it. A refusal within [`VOID_S`] of an offer of the same quest to the same character, at the same
//!   level with nothing handed in between, is void, and so is one of a quest already closed (a quest
//!   of its exclusive group or a follow-up done, or in the log).
//! - Recorders mostly follow our guides, so levels and prerequisites read from offered windows lean
//!   toward what the guides already do (co-occurrence). A prerequisite is `Confirmed` only when it is
//!   refusal-backed: never offered without it; refused without it by a character later offered the
//!   quest once it was handed in; and a clean unlock (nothing else that could explain it handed in,
//!   same level), an immediate unlock (offered within [`IMMEDIATE`] s of that hand-in), or present in
//!   every same-level unlock of two or more characters. Offered without it is `Contradicted`.
//! - Level: the lowest offered level bounds the minimum from above; the highest level refused with
//!   every required quest done, below that, bounds it from below.
//!
//! Everything here is per character; [`super`] turns characters into voters.

use std::rc::Rc;

use rustc_hash::{FxHashMap, FxHashSet};

/// Seconds after a hand-in during which a window may show the lists from before it.
pub const STALE: f64 = 2.0;
/// An offer this soon after a hand-in appeared on that hand-in.
pub const IMMEDIATE: f64 = 5.0;
/// A window this close to a quest-detail window of the same NPC is a detail window.
pub const DETAIL_S: f64 = 1.5;
/// A refusal with an offer of the same quest this close, nothing handed in between, is void.
pub const VOID_S: f64 = 30.0;

/// A giver's window (`offer` record).
#[derive(Clone, Debug, Default)]
pub struct Window {
	pub npc: Option<i64>,
	pub available: Vec<i64>,
	pub not_offered: Vec<i64>,
	pub active: Vec<i64>,
	pub log: Vec<i64>,
	pub done: Vec<i64>,
}

#[derive(Clone, Debug)]
pub enum Row {
	Level(i64),
	Window(Window),
	Detail(Option<i64>),
	/// An accept and the NPC whose window it came from (when known).
	Accept(i64, Option<i64>),
	Turnin(i64),
}

/// A row at a time (session start + the record's offset) on a client build.
#[derive(Clone, Debug)]
pub struct Timed {
	pub t: f64,
	pub build: i64,
	pub row: Row,
}

/// One character: its rows from every session, in time order, and who it is.
#[derive(Default)]
pub struct Char {
	pub race: Option<String>,
	pub class: Option<String>,
	pub faction: Option<String>,
	/// The voter it belongs to ([`super`]'s index).
	pub voter: usize,
	pub rows: Vec<Timed>,
	turnin: FxHashMap<i64, f64>,
	accept: FxHashMap<i64, f64>,
	first_done: FxHashMap<i64, f64>,
	turnin_times: Vec<(f64, i64)>,
	/// Recorded from the start (first level <= 3, never a level skipped): every hand-in is known.
	complete: bool,
}

impl Char {
	pub fn new(race: Option<String>, class: Option<String>, faction: Option<String>) -> Char {
		Char { race, class, faction, ..Char::default() }
	}

	/// Sorts the rows by time and indexes hand-ins, accepts and what is known done.
	pub fn prepare(&mut self) {
		self.rows.sort_by(|a, b| a.t.total_cmp(&b.t));
		let mut levels = Vec::new();
		for r in &self.rows {
			match &r.row {
				Row::Turnin(q) => {
					self.turnin.entry(*q).or_insert(r.t);
					self.first_done.entry(*q).or_insert(r.t);
					self.turnin_times.push((r.t, *q));
				}
				Row::Accept(q, _) => {
					self.accept.entry(*q).or_insert(r.t);
				}
				Row::Window(w) => {
					for q in &w.done {
						self.first_done.entry(*q).or_insert(r.t);
					}
				}
				Row::Level(l) => levels.push(*l),
				Row::Detail(_) => {}
			}
		}
		self.complete = levels.first().is_some_and(|l| *l <= 3) && levels.windows(2).all(|w| w[1] - w[0] <= 1);
	}

	pub fn done(&self, q: i64, t: f64) -> bool {
		self.first_done.get(&q).is_some_and(|d| *d <= t)
	}

	/// Known NOT completed at `t`: in the log then, accepted or handed in only later, or never handed
	/// in by a character recorded from the start.
	pub fn not_done(&self, q: i64, t: f64, log: &FxHashSet<i64>) -> bool {
		if self.done(q, t) {
			return false;
		}
		if self.complete || log.contains(&q) {
			return true;
		}
		if self.turnin.get(&q).is_some_and(|x| *x > t) {
			return true;
		}
		self.accept.get(&q).is_some_and(|x| *x > t)
	}

	/// Whether the character handed `q` in, or a window flagged it done, at any time.
	pub fn ever_done(&self, q: i64) -> bool {
		self.first_done.contains_key(&q)
	}
}

/// What our data says of a quest, as far as offers go.
#[derive(Clone, Debug, Default)]
pub struct QData {
	pub pre: Vec<i64>,
	pub pre_any: Vec<i64>,
	pub pre_all: Vec<i64>,
	pub excl: Vec<i64>,
	pub next: Option<i64>,
	pub min_level: Option<i64>,
	pub races: Option<i64>,
	pub classes: Option<i64>,
	pub givers: Vec<i64>,
}

impl QData {
	/// (all-of, any-of) prerequisites: `pre` alone is an any-of group (forge_guide's
	/// blocking_prereqs), and an any-of group of one quest is that quest.
	pub fn split(&self) -> (Vec<i64>, Vec<i64>) {
		let mut all = self.pre_all.clone();
		let mut any = self.pre_any.clone();
		if all.is_empty() && any.is_empty() && !self.pre.is_empty() {
			any = self.pre.clone();
		}
		if any.len() == 1 {
			all.append(&mut any);
			all.sort_unstable();
			all.dedup();
		}
		(all, any)
	}
}

/// The quests data, with each quest's follow-ups (quests naming it in `pre`/`preAll`).
pub struct Quests {
	pub q: FxHashMap<i64, QData>,
	followups: FxHashMap<i64, Vec<i64>>,
}

impl Quests {
	pub fn new(q: FxHashMap<i64, QData>) -> Quests {
		let mut followups: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
		for (id, d) in &q {
			for p in d.pre.iter().chain(&d.pre_all) {
				followups.entry(*p).or_default().push(*id);
			}
		}
		Quests { q, followups }
	}

	fn get(&self, id: i64) -> Option<&QData> {
		self.q.get(&id)
	}

	/// `p`'s earlier chain by our data (the quests `p` itself needs).
	fn ancestors(&self, p: i64) -> FxHashSet<i64> {
		let mut seen = FxHashSet::default();
		let mut todo = vec![p];
		while let Some(x) = todo.pop() {
			let Some(d) = self.get(x) else { continue };
			for y in d.pre.iter().chain(&d.pre_any).chain(&d.pre_all) {
				if seen.insert(*y) {
					todo.push(*y);
				}
			}
		}
		seen
	}
}

/// One quest seen in a window, or accepted.
pub struct Obs {
	pub c: usize,
	pub q: i64,
	pub t: f64,
	pub build: i64,
	pub level: Option<i64>,
	pub offered: bool,
	/// A refusal of a quest handed in or accepted less than [`STALE`] s before.
	pub stale: bool,
	pub log: Rc<FxHashSet<i64>>,
	/// Hand-ins less than [`STALE`] s before the window: unknown for it.
	pub just: Rc<FxHashSet<i64>>,
	pub accept: bool,
}

/// npc -> the quests it starts: our data's givers plus every quest a recorded window of it offered.
pub fn giver_map(quests: &Quests, chars: &[Char]) -> FxHashMap<i64, FxHashSet<i64>> {
	let mut g: FxHashMap<i64, FxHashSet<i64>> = FxHashMap::default();
	for (id, d) in &quests.q {
		for n in &d.givers {
			g.entry(*n).or_default().insert(*id);
		}
	}
	for c in chars {
		for r in &c.rows {
			if let Row::Window(w) = &r.row {
				if let Some(n) = w.npc {
					g.entry(n).or_default().extend(w.available.iter().copied());
				}
			}
		}
	}
	g
}

/// Every offer and refusal of the quests `wanted` keeps, per quest.
pub fn observations(chars: &[Char], quests: &Quests, givers: &FxHashMap<i64, FxHashSet<i64>>, wanted: &dyn Fn(i64) -> bool) -> FxHashMap<i64, Vec<Obs>> {
	let mut by_q: FxHashMap<i64, Vec<Obs>> = FxHashMap::default();
	let none: Rc<FxHashSet<i64>> = Rc::new(FxHashSet::default());
	for (ci, ch) in chars.iter().enumerate() {
		let mut dtimes: FxHashMap<Option<i64>, Vec<f64>> = FxHashMap::default();
		for r in &ch.rows {
			if let Row::Detail(n) = r.row {
				dtimes.entry(n).or_default().push(r.t);
			}
		}
		let mut level = None;
		let mut recent: Vec<(f64, i64)> = Vec::new();
		let mut accepted: Vec<(f64, i64)> = Vec::new();
		for r in &ch.rows {
			let t = r.t;
			match &r.row {
				Row::Level(l) => level = Some(*l),
				Row::Turnin(q) => recent.push((t, *q)),
				Row::Detail(_) => {}
				Row::Accept(q, _) => {
					accepted.push((t, *q));
					if wanted(*q) {
						by_q.entry(*q).or_default().push(Obs { c: ci, q: *q, t, build: r.build, level, offered: true, stale: false, log: none.clone(), just: none.clone(), accept: true });
					}
				}
				Row::Window(w) => {
					let detail = dtimes.get(&w.npc).is_some_and(|ts| ts.iter().any(|x| (x - t).abs() < DETAIL_S));
					let mut just: FxHashSet<i64> = recent.iter().filter(|(x, _)| t - x < STALE).map(|(_, q)| *q).collect();
					if !just.is_empty() {
						for q in &w.available {
							if let Some(d) = quests.get(*q) {
								for p in d.pre.iter().chain(&d.pre_any).chain(&d.pre_all) {
									just.remove(p);
								}
							}
						}
					}
					let took: FxHashSet<i64> = accepted.iter().filter(|(x, _)| t - x < STALE).map(|(_, q)| *q).collect();
					let log: Rc<FxHashSet<i64>> = Rc::new(w.log.iter().copied().collect());
					let just = Rc::new(just);
					for q in &w.available {
						if wanted(*q) {
							by_q.entry(*q).or_default().push(Obs { c: ci, q: *q, t, build: r.build, level, offered: true, stale: false, log: log.clone(), just: just.clone(), accept: false });
						}
					}
					if detail {
						continue;
					}
					let shown: FxHashSet<i64> = w.available.iter().chain(&w.active).chain(&w.log).chain(&w.done).copied().collect();
					let named: FxHashSet<i64> = w.not_offered.iter().copied().collect();
					let mut cands: Vec<i64> = named.iter().copied().collect();
					if let Some(g) = w.npc.and_then(|n| givers.get(&n)) {
						cands.extend(g.iter().filter(|q| !shown.contains(q) && !named.contains(q)));
					}
					for q in cands {
						if shown.contains(&q) || !wanted(q) {
							continue;
						}
						let derived = !named.contains(&q);
						if derived && !ch.not_done(q, t, &log) {
							continue;
						}
						let stale = just.contains(&q) || took.contains(&q);
						by_q.entry(q).or_default().push(Obs { c: ci, q, t, build: r.build, level, offered: false, stale, log: log.clone(), just: just.clone(), accept: false });
					}
				}
			}
		}
	}
	by_q
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum PreStatus {
	/// Refusal-backed (module doc).
	Confirmed,
	/// Always done when offered; no refusal evidence (co-occurrence: says nothing).
	Consistent,
	/// Offered without it.
	Contradicted,
	NoEvidence,
}

/// One candidate prerequisite of a quest, with the characters behind each kind of evidence.
pub struct PreRow {
	pub p: i64,
	pub in_data: bool,
	pub status: PreStatus,
	pub offered_with: FxHashSet<usize>,
	pub offered_without: FxHashSet<usize>,
	/// Refused without it, and later offered once it was handed in.
	pub backed: FxHashSet<usize>,
	/// The unlock evidence a confirmation needs is there (whether or not it was offered without it).
	pub unlock: bool,
}

/// A data exclusive-group member of a quest: who was refused the quest only because it was done
/// (otherwise qualified), and who was offered or did the quest with it done.
pub struct ExclRow {
	pub x: i64,
	pub closed: FxHashSet<usize>,
	pub open: FxHashSet<usize>,
}

/// What the windows say of one quest.
pub struct Evidence {
	pub prereqs: Vec<PreRow>,
	/// Our data's any-of group, and the characters offered it with none of the group done.
	pub any_of: Vec<i64>,
	pub any_of_none: FxHashSet<usize>,
	pub excl: Vec<ExclRow>,
	/// The lowest offered level, and the characters offered it there.
	pub min_offered: Option<(i64, FxHashSet<usize>)>,
	/// The highest level refused with every required quest done, below the lowest offered, and the
	/// characters refused there.
	pub max_refused: Option<(i64, FxHashSet<usize>)>,
	/// Characters offered it at all (any level).
	pub offered: FxHashSet<usize>,
	/// Per character, the first and last build of its windows of the quest.
	pub builds: FxHashMap<usize, (i64, i64)>,
}

const CLASS_BIT: [(&str, i64); 9] = [("WARRIOR", 1), ("PALADIN", 2), ("HUNTER", 4), ("ROGUE", 8), ("PRIEST", 16), ("SHAMAN", 64), ("MAGE", 128), ("WARLOCK", 256), ("DRUID", 1024)];
const RACE_BIT: [(&str, i64); 8] = [("Human", 1), ("Orc", 2), ("Dwarf", 4), ("NightElf", 8), ("Scourge", 16), ("Tauren", 32), ("Gnome", 64), ("Troll", 128)];

/// Qualified by our data's race and class masks. A character whose race or class is unknown (a
/// re-rolled character id) qualifies only for a quest with no mask.
fn data_eligible(ch: &Char, qd: &QData) -> bool {
	if let Some(rm) = qd.races.filter(|m| *m != 0) {
		let Some(race) = ch.race.as_deref() else { return false };
		if let Some((_, bit)) = RACE_BIT.iter().find(|(r, _)| *r == race) {
			if rm & bit == 0 {
				return false;
			}
		} else if race == "Skyborne" {
			let bit = if ch.faction.as_deref() == Some("Alliance") { 4294967296 } else { 8589934592 };
			if rm & bit == 0 {
				return false;
			}
		}
	}
	if let Some(cm) = qd.classes.filter(|m| *m != 0) {
		let Some(class) = ch.class.as_deref() else { return false };
		if let Some((_, bit)) = CLASS_BIT.iter().find(|(c, _)| *c == class) {
			if cm & bit == 0 {
				return false;
			}
		}
	}
	true
}

struct Transition {
	c: usize,
	turnins: Vec<i64>,
	level_change: bool,
	immediate: Vec<i64>,
}

/// The evidence of quest `q` from `obs` (its observations by the characters to count).
pub fn quest_evidence(q: i64, obs: &[&Obs], chars: &[Char], quests: &Quests) -> Evidence {
	let empty = QData::default();
	let qd = quests.get(q).unwrap_or(&empty);
	let offered: Vec<&Obs> = obs.iter().copied().filter(|o| o.offered).collect();
	let factions_off: FxHashSet<&str> = offered.iter().filter_map(|o| chars[o.c].faction.as_deref()).collect();
	let classes_off: FxHashSet<&str> = offered.iter().filter_map(|o| chars[o.c].class.as_deref()).collect();
	// Qualified by race/class/faction, by our data's masks (the recorded offers only show who
	// happened to open the window, so they never widen a refusal into a lock).
	let eligible = |c: usize| data_eligible(&chars[c], qd) && (factions_off.is_empty() || chars[c].faction.as_deref().is_some_and(|f| factions_off.contains(f)));
	let mut offers_by: FxHashMap<usize, Vec<&Obs>> = FxHashMap::default();
	for o in &offered {
		offers_by.entry(o.c).or_default().push(o);
	}
	// Quests that close this one: our data's exclusive group, and its own follow-ups.
	let mut closers: FxHashSet<i64> = qd.excl.iter().copied().collect();
	closers.extend(quests.followups.get(&q).into_iter().flatten().copied());
	closers.extend(qd.next);
	let closed = |o: &Obs| closers.iter().any(|x| chars[o.c].done(*x, o.t) || o.log.contains(x));
	let void = |o: &Obs| {
		if closed(o) {
			return true;
		}
		let ch = &chars[o.c];
		offers_by.get(&o.c).into_iter().flatten().any(|x| {
			let (lo, hi) = if x.t <= o.t { (x.t, o.t) } else { (o.t, x.t) };
			hi - lo <= VOID_S && x.level == o.level && !ch.turnin_times.iter().any(|(t, _)| lo < *t && *t <= hi)
		})
	};
	let refused: Vec<&Obs> = obs.iter().copied().filter(|o| !o.offered && !o.stale && !void(o) && eligible(o.c)).collect();
	let mut builds: FxHashMap<usize, (i64, i64)> = FxHashMap::default();
	for o in obs {
		let e = builds.entry(o.c).or_insert((o.build, o.build));
		e.0 = e.0.min(o.build);
		e.1 = e.1.max(o.build);
	}

	// Prerequisites: candidates from our data and from refusal -> offer transitions.
	let (all_of, any_of) = qd.split();
	let mut cand: Vec<i64> = Vec::new();
	let add = |cand: &mut Vec<i64>, p: i64| {
		if !cand.contains(&p) {
			cand.push(p);
		}
	};
	let mut transitions: Vec<Transition> = Vec::new();
	let mut per_char: FxHashMap<usize, Vec<&Obs>> = FxHashMap::default();
	for o in obs {
		per_char.entry(o.c).or_default().push(o);
	}
	let mut keys: Vec<usize> = per_char.keys().copied().collect();
	keys.sort_unstable();
	for c in &keys {
		let lst = per_char.get_mut(c).unwrap();
		lst.sort_by(|a, b| a.t.total_cmp(&b.t));
		let ch = &chars[*c];
		let mut last_ref: Option<&Obs> = None;
		for o in lst.iter() {
			if !o.offered {
				if !o.stale && eligible(o.c) && !void(o) {
					last_ref = Some(o);
				}
			} else if let Some(r) = last_ref.take() {
				let (t1, t2) = (r.t, o.t);
				// Hand-ins since the refusal, plus any made just before it (a window that may predate them).
				let between: Vec<i64> = ch.turnin_times.iter().filter(|(tt, qq)| (t1 < *tt || r.just.contains(qq)) && *tt <= t2 && *qq != q).map(|(_, qq)| *qq).collect();
				let immediate: Vec<i64> = ch.turnin_times.iter().filter(|(tt, qq)| t2 - IMMEDIATE <= *tt && *tt <= t2 && *qq != q).map(|(_, qq)| *qq).collect();
				for p in &between {
					add(&mut cand, *p);
				}
				transitions.push(Transition { c: *c, turnins: between, level_change: r.level.unwrap_or(0) != o.level.unwrap_or(0), immediate });
			}
		}
		// The first offer that came within IMMEDIATE s of a hand-in: a candidate (co-occurrence only).
		if let Some(first) = lst.iter().find(|o| o.offered) {
			for (tt, qq) in &ch.turnin_times {
				if first.t - IMMEDIATE <= *tt && *tt <= first.t && *qq != q {
					add(&mut cand, *qq);
				}
			}
		}
	}
	for p in all_of.iter().chain(&any_of) {
		add(&mut cand, *p);
	}

	let mut rows: Vec<PreRow> = Vec::new();
	let mut refused_without: FxHashMap<i64, FxHashSet<usize>> = FxHashMap::default();
	for p in &cand {
		let mut row = PreRow {
			p: *p,
			in_data: all_of.contains(p) || any_of.contains(p),
			status: PreStatus::NoEvidence,
			offered_with: FxHashSet::default(),
			offered_without: FxHashSet::default(),
			backed: FxHashSet::default(),
			unlock: false,
		};
		for o in &offered {
			let ch = &chars[o.c];
			if ch.done(*p, o.t) {
				row.offered_with.insert(o.c);
			} else if ch.not_done(*p, o.t, &o.log) {
				row.offered_without.insert(o.c);
			}
		}
		let rw = refused_without.entry(*p).or_default();
		for o in &refused {
			if o.just.contains(p) {
				continue;
			}
			if chars[o.c].not_done(*p, o.t, &o.log) {
				rw.insert(o.c);
			}
		}
		rows.push(row);
	}
	let contradicted: FxHashSet<i64> = rows.iter().filter(|r| !r.offered_without.is_empty()).map(|r| r.p).collect();
	let same_lvl: Vec<&Transition> = transitions.iter().filter(|t| !t.level_change).collect();
	for r in rows.iter_mut() {
		let p = r.p;
		let mine = quests.ancestors(p);
		let clean = same_lvl.iter().filter(|t| t.turnins.contains(&p) && t.turnins.iter().all(|x| *x == p || contradicted.contains(x) || mine.contains(x))).count();
		let immediate = same_lvl.iter().filter(|t| t.immediate.contains(&p)).count();
		let unlocked_by: FxHashSet<usize> = transitions.iter().filter(|t| t.turnins.contains(&p)).map(|t| t.c).collect();
		let in_all = !same_lvl.is_empty() && same_lvl.iter().all(|t| t.turnins.contains(&p));
		let backed: FxHashSet<usize> = refused_without[&p].intersection(&unlocked_by).copied().collect();
		r.unlock = !backed.is_empty() && (clean >= 1 || immediate >= 1 || (in_all && backed.len() >= 2));
		r.status = if r.offered_without.is_empty() && r.unlock {
			PreStatus::Confirmed
		} else if r.offered_without.is_empty() && !r.offered_with.is_empty() {
			PreStatus::Consistent
		} else if !r.offered_without.is_empty() {
			PreStatus::Contradicted
		} else {
			PreStatus::NoEvidence
		};
		r.backed = backed;
	}
	rows.sort_by_key(|r| r.p);
	// An any-of group: at least one done in every offered window.
	let mut any_of_none = FxHashSet::default();
	if !any_of.is_empty() {
		for o in &offered {
			let ch = &chars[o.c];
			if !any_of.iter().any(|p| ch.done(*p, o.t)) && any_of.iter().all(|p| ch.not_done(*p, o.t, &o.log)) {
				any_of_none.insert(o.c);
			}
		}
	}
	let status: FxHashMap<i64, PreStatus> = rows.iter().map(|r| (r.p, r.status)).collect();
	// A recorded unlock by one member of our data's any-of group stays an any-of requirement.
	let mut req_all: Vec<i64> = rows.iter().filter(|r| r.status == PreStatus::Confirmed && !any_of.contains(&r.p)).map(|r| r.p).collect();
	req_all.extend(all_of.iter().filter(|p| status.get(p) != Some(&PreStatus::Contradicted)));
	req_all.sort_unstable();
	req_all.dedup();
	let req_any: Vec<i64> = if any_of_none.is_empty() { any_of.clone() } else { Vec::new() };
	let qualified = |o: &Obs| {
		let ch = &chars[o.c];
		let known = |p: &i64| !o.just.contains(p) && ch.done(*p, o.t);
		req_all.iter().all(known) && (req_any.is_empty() || req_any.iter().any(known))
	};

	// Level.
	let min_offered = offered.iter().filter_map(|o| o.level).min().map(|ml| (ml, offered.iter().filter(|o| o.level == Some(ml)).map(|o| o.c).collect::<FxHashSet<usize>>()));
	let offered_chars: FxHashSet<usize> = offered.iter().map(|o| o.c).collect();
	// A quest offered only to one or two classes (by 3+ characters) our data doesn't mark: other
	// classes' refusals say nothing about its level.
	let cls_narrow = offered_chars.len() >= 3 && classes_off.len() <= 2;
	let ml = min_offered.as_ref().map(|m| m.0);
	let below: Vec<(i64, usize)> = refused
		.iter()
		.filter(|o| qualified(o) && (!cls_narrow || chars[o.c].class.as_deref().is_some_and(|c| classes_off.contains(c))))
		.filter_map(|o| o.level.map(|l| (l, o.c)))
		.filter(|(l, _)| ml.is_none_or(|m| *l < m))
		.collect();
	let max_refused = below.iter().map(|(l, _)| *l).max().map(|top| (top, below.iter().filter(|(l, _)| *l == top).map(|(_, c)| *c).collect::<FxHashSet<usize>>()));

	// Exclusive groups: refused only because a member was done (otherwise qualified), or offered /
	// done with it done.
	let mut excl = Vec::new();
	for x in &qd.excl {
		let mut row = ExclRow { x: *x, closed: FxHashSet::default(), open: FxHashSet::default() };
		for o in &offered {
			if chars[o.c].done(*x, o.t) {
				row.open.insert(o.c);
			}
		}
		for c in &offered_chars {
			if chars[*c].ever_done(q) && chars[*c].ever_done(*x) {
				row.open.insert(*c);
			}
		}
		for o in obs.iter().filter(|o| !o.offered && !o.stale && eligible(o.c)) {
			let ch = &chars[o.c];
			if (ch.done(*x, o.t) || o.log.contains(x)) && qualified(o) && ml.is_none_or(|m| o.level.is_some_and(|l| l >= m)) {
				row.closed.insert(o.c);
			}
		}
		row.closed.retain(|c| !row.open.contains(c));
		if !row.closed.is_empty() || !row.open.is_empty() {
			excl.push(row);
		}
	}
	Evidence { prereqs: rows, any_of, any_of_none, excl, min_offered, max_refused, offered: offered_chars, builds }
}
