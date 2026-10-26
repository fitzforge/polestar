//! The evaluator: plays an order of steps (accept / objective site / turn-in / grind to a
//! level) for one character and keeps time, level, XP and the counters. Port of
//! tools/lib/sim/evaluate.js (`step`, `grindTo`, `moveTo`, `doWork`, shared kill credit, the
//! full-log abandon, spot and zone returns), the model the judge and the gate measure hours in.
//! State is struct-of-Vecs with one write journal (array id, index, old value) so a search can
//! go back to any mark and replay from there.
//!
//! The spot term (`spot`) is adapted from Factoruide (https://github.com/brouznouf/factoruide,
//! plan/spot.rs), MIT, used with its author's permission.

use crate::run::{Run, Tables, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN, MOBL, W_BUY, W_ESCORT, W_KILL, W_USE};
use crate::travel::{Matrix, Travel, TravelBase};
use crate::walks::Walks;
use crate::xp::{LEVEL_XP, SHARE};
use std::sync::Arc;

/// Steps ahead a step looks for where the order goes next (the spot term): a change at step a
/// can change how steps a - NEXT_LOOK .. a are done.
pub const NEXT_LOOK: usize = 4;

/// Yards: a move this far from where the current stretch of work began starts a new one.
pub const SPOT_LEAVE: f64 = 600.0;
/// Levels below the character at which a full quest log gives up a quest.
pub const ABANDON_GAP: i64 = 6;
/// Seconds over which a walked leg is traced (Trace::Walk): a long walk the writer should state.
pub const WALK_TRACE_SEC: f64 = 180.0;
/// Seconds a planned (v1) hearth may cost over the travel the model would take instead.
pub const PLAN_HEARTH_SLACK: f64 = 120.0;
/// Along credit (Evaluator::along): yards from a walked leg, the share of an objective's kills
/// taken per passing leg [INFERENCE: the engine notes' pull rates], free pull distance.
pub const PASS_ALONG_YD: f64 = 150.0;
pub const ALONG_FRAC: f64 = 0.25;
pub const ALONG_FREE_YD: f64 = 60.0;

/// One step of an order: `kind` K_*, `q` quest index (K_GRIND: level), `task` (accept: its
/// start-item task or -1; K_TASK: the task; K_GRIND: XP into the level), `pt` run point.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct Step {
	pub kind: u8,
	pub q: u32,
	pub task: i32,
	pub pt: u32,
}

impl Step {
	pub fn grind(level: u32, xp: i32) -> Step {
		Step { kind: K_GRIND, q: level, task: xp, pt: u32::MAX }
	}
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
enum Arr {
	Done,
	Active,
	Task,
	Known,
	Zone,
	Ever,
	Killed,
	Cell,
	CampLast,
	CampTaken,
	AcceptT,
}

/// The scalars of a state (restored as a whole).
#[derive(Clone)]
pub struct Scalars {
	pub time: f64,
	pub level: usize,
	pub xp: f64,
	pub pos: u32,
	pub mask: u64,
	pub mounted: bool,
	pub d: Matrix,
	pub bind: i32,
	pub hearth_ready: f64,
	pub xp_quest: f64,
	pub xp_kill: f64,
	pub xp_grind: f64,
	pub travel_sec: f64,
	pub grind_sec: f64,
	pub quests_done: u32,
	pub finished: bool,
	pub hearths: u32,
	pub flights: u32,
	pub unreachable: u32,
	pub risk_crossings: f64,
	pub steps: u32,
	pub zone_changes: u32,
	pub zone_returns: u32,
	pub spot_returns: u32,
	pub shared_kills: f64,
	pub area_id: f64,
	pub area_pt: u32,
	pub open: u32,
	pub log_peak: u32,
	/// Kills credited along walks.
	pub along_kills: f64,
	/// v1's hearth lines met while the stone cools down (#576: hearths >= 60 min apart).
	pub plan_cooldown: u32,
	pub log_skipped: u32,
	pub log_abandoned: u32,
	/// Steps that did nothing (prerequisite, level, log, unreachable, not active, not done).
	pub noops: u32,
	/// Class training stops taken.
	pub trains: u32,
	/// Timed quests in the log (their legs are walked, `feasible`).
	pub timed_active: u32,
	/// When the latest limit of the timed quests in the log runs out (walk-only until then).
	pub timed_until: f64,
	/// Feasibility violations: a timed quest handed in after its limit.
	pub late: u32,
	/// What the time was spent on, for re-pricing under other parameters.
	pub c: Counters,
	/// Whether the last step's move was walked (no flight, boat or hearth): the passed-by guard.
	pub walked: bool,
}

/// A point to go back to (`Evaluator::mark` / `restore`).
#[derive(Clone)]
pub struct Mark {
	j: usize,
	s: Scalars,
}

impl Mark {
	pub fn scalars(&self) -> &Scalars {
		&self.s
	}
}

pub struct Evaluator<'a> {
	pub run: &'a Run,
	pub t: &'a Tables,
	pub walks: &'a dyn Walks,
	pub travel: Travel,
	pub done: Vec<u8>,
	pub active: Vec<u8>,
	pub task_done: Vec<u8>,
	pub known: Vec<u8>,
	pub ever_active: Vec<u8>,
	pub zone_seen: Vec<u8>,
	pub cell_area: Vec<f64>,
	/// Per camp: when it was last farmed and the mobs taken then (the camp fidelity term).
	pub camp_last: Vec<f64>,
	pub camp_taken: Vec<f64>,
	/// Per quest: when it was accepted (timed quests).
	pub accept_t: Vec<f64>,
	/// Where the order goes after the step being played (the spot fidelity term), u32::MAX
	/// when unknown.
	pub next_pt: u32,
	/// When set, each task's work seconds are appended (task, seconds): diagnostics.
	pub work_log: Option<Vec<(u32, f64)>>,
	/// When set, the route items the evaluator decides (binds, hearths, flights and boats,
	/// flight paths learned), with the step index they happen at: what a writer places.
	pub trace: Option<Vec<(u32, Trace)>>,
	/// The step being played is one v1 hearths to (TravelPlan::hearth).
	plan_hearth: bool,
	/// Plan items of steps that did nothing (another start's no-op step of a shared order):
	/// carried to the next step that does something (hearth, bind, flight paths).
	pub plan_pending: (bool, Option<u32>, Vec<u32>),
	/// The index of the step being played (step_in).
	pub at_step: u32,
	pub killed: Vec<f64>,
	act_lv: [i32; 64],
	pub level_times: [f64; 61],
	pub s: Scalars,
	journal: Vec<(Arr, u32, f64)>,
	/// Journal writes (mark/restore); off for plain replays and snapshot-based search.
	pub journaling: bool,
}

/// A whole state, copied (`Evaluator::snapshot` / `load`): what the search keeps every few
/// steps of the current order (a few tens of KB).
#[derive(Clone)]
pub struct Snap {
	done: Vec<u8>,
	active: Vec<u8>,
	task_done: Vec<u8>,
	known: Vec<u8>,
	ever_active: Vec<u8>,
	zone_seen: Vec<u8>,
	cell_area: Vec<f64>,
	camp_last: Vec<f64>,
	camp_taken: Vec<f64>,
	accept_t: Vec<f64>,
	killed: Vec<f64>,
	act_lv: [i32; 64],
	level_times: [f64; 61],
	pub s: Scalars,
}

fn start_scalars(run: &Run, d: Matrix) -> Scalars {
	Scalars {
		time: 0.0,
		level: 1,
		xp: 0.0,
		pos: run.start_pt,
		mask: 0,
		mounted: false,
		d,
		bind: -1,
		hearth_ready: 0.0,
		xp_quest: 0.0,
		xp_kill: 0.0,
		xp_grind: 0.0,
		travel_sec: 0.0,
		grind_sec: 0.0,
		quests_done: 0,
		finished: false,
		hearths: 0,
		flights: 0,
		unreachable: 0,
		risk_crossings: 0.0,
		steps: 0,
		zone_changes: 0,
		zone_returns: 0,
		spot_returns: 0,
		shared_kills: 0.0,
		area_id: 1.0,
		area_pt: run.start_pt,
		open: 0,
		log_peak: 0,
		along_kills: 0.0,
		plan_cooldown: 0,
		log_skipped: 0,
		log_abandoned: 0,
		noops: 0,
		trains: 0,
		timed_active: 0,
		timed_until: 0.0,
		late: 0,
		c: Counters::default(),
		walked: false,
	}
}

impl<'a> Evaluator<'a> {
	pub fn new(run: &'a Run, t: &'a Tables, walks: &'a dyn Walks, base: Arc<TravelBase>) -> Evaluator<'a> {
		let d = base.base[0].clone();
		let mut e = Evaluator {
			run,
			t,
			walks,
			travel: Travel::new(base),
			done: vec![0; run.n_quests()],
			active: vec![0; run.n_quests()],
			task_done: vec![0; run.task_pt.len()],
			known: vec![0; run.n_nodes],
			ever_active: vec![0; run.n_quests()],
			zone_seen: vec![0; run.zone_count.max(1)],
			cell_area: vec![0.0; run.cell_count.max(1)],
			camp_last: vec![0.0; run.camps.len()],
			camp_taken: vec![0.0; run.camps.len()],
			accept_t: vec![0.0; run.n_quests()],
			next_pt: u32::MAX,
			work_log: None,
			trace: None,
			plan_hearth: false,
			plan_pending: (false, None, Vec::new()),
			at_step: 0,
			killed: vec![0.0; run.w_kind.len().max(1)],
			act_lv: [0; 64],
			level_times: [0.0; 61],
			s: start_scalars(run, d),
			journal: Vec::with_capacity(1 << 14),
			journaling: false,
		};
		e.reset();
		e
	}

	// ---- state ----
	pub fn reset(&mut self) {
		self.journal.clear();
		self.done.fill(0);
		self.active.fill(0);
		self.task_done.fill(0);
		self.known.fill(0);
		self.ever_active.fill(0);
		self.zone_seen.fill(0);
		self.cell_area.fill(0.0);
		self.camp_last.fill(0.0);
		self.camp_taken.fill(0.0);
		self.accept_t.fill(0.0);
		self.killed.fill(0.0);
		self.act_lv = [0; 64];
		self.level_times = [0.0; 61];
		let r = self.run;
		self.zone_seen[r.p_zone[r.start_pt as usize] as usize] = 1;
		self.s = start_scalars(r, self.travel.base.base[0].clone());
		self.plan_pending = (false, None, Vec::new());
	}

	/// The whole state, copied.
	pub fn snapshot(&self) -> Snap {
		Snap {
			done: self.done.clone(),
			active: self.active.clone(),
			task_done: self.task_done.clone(),
			known: self.known.clone(),
			ever_active: self.ever_active.clone(),
			zone_seen: self.zone_seen.clone(),
			cell_area: self.cell_area.clone(),
			camp_last: self.camp_last.clone(),
			camp_taken: self.camp_taken.clone(),
			accept_t: self.accept_t.clone(),
			killed: self.killed.clone(),
			act_lv: self.act_lv,
			level_times: self.level_times,
			s: self.s.clone(),
		}
	}

	/// Back to a snapshot (clears the journal: marks taken before are void).
	pub fn load(&mut self, n: &Snap) {
		self.journal.clear();
		self.done.copy_from_slice(&n.done);
		self.active.copy_from_slice(&n.active);
		self.task_done.copy_from_slice(&n.task_done);
		self.known.copy_from_slice(&n.known);
		self.ever_active.copy_from_slice(&n.ever_active);
		self.zone_seen.copy_from_slice(&n.zone_seen);
		self.cell_area.copy_from_slice(&n.cell_area);
		self.camp_last.copy_from_slice(&n.camp_last);
		self.camp_taken.copy_from_slice(&n.camp_taken);
		self.accept_t.copy_from_slice(&n.accept_t);
		self.killed.copy_from_slice(&n.killed);
		self.act_lv = n.act_lv;
		self.level_times = n.level_times;
		self.s = n.s.clone();
		self.plan_pending = (false, None, Vec::new());
	}

	fn get(&self, a: Arr, i: usize) -> f64 {
		match a {
			Arr::Done => self.done[i] as f64,
			Arr::Active => self.active[i] as f64,
			Arr::Task => self.task_done[i] as f64,
			Arr::Known => self.known[i] as f64,
			Arr::Zone => self.zone_seen[i] as f64,
			Arr::Ever => self.ever_active[i] as f64,
			Arr::Killed => self.killed[i],
			Arr::Cell => self.cell_area[i],
			Arr::CampLast => self.camp_last[i],
			Arr::CampTaken => self.camp_taken[i],
			Arr::AcceptT => self.accept_t[i],
		}
	}

	fn put(&mut self, a: Arr, i: usize, v: f64) {
		match a {
			Arr::Done => self.done[i] = v as u8,
			Arr::Active => {
				let lv = self.run.q_lv[i];
				if v != 0.0 && self.active[i] == 0 {
					self.act_lv[lv] += 1;
				} else if v == 0.0 && self.active[i] != 0 {
					self.act_lv[lv] -= 1;
				}
				self.active[i] = v as u8;
			}
			Arr::Task => self.task_done[i] = v as u8,
			Arr::Known => self.known[i] = v as u8,
			Arr::Zone => self.zone_seen[i] = v as u8,
			Arr::Ever => self.ever_active[i] = v as u8,
			Arr::Killed => self.killed[i] = v,
			Arr::Cell => self.cell_area[i] = v,
			Arr::CampLast => self.camp_last[i] = v,
			Arr::CampTaken => self.camp_taken[i] = v,
			Arr::AcceptT => self.accept_t[i] = v,
		}
	}

	fn set(&mut self, a: Arr, i: usize, v: f64) {
		if self.journaling {
			let old = self.get(a, i);
			self.journal.push((a, i as u32, old));
		}
		self.put(a, i, v);
	}

	pub fn mark(&self) -> Mark {
		Mark { j: self.journal.len(), s: self.s.clone() }
	}

	/// Back to a mark (journaling must have been on since it).
	pub fn restore(&mut self, m: &Mark) {
		while self.journal.len() > m.j {
			let (a, i, old) = self.journal.pop().unwrap();
			self.put(a, i as usize, old);
		}
		for l in m.s.level + 1..=60 {
			self.level_times[l] = 0.0;
		}
		self.s = m.s.clone();
	}

	/// Level with the fraction into it (60: 60).
	pub fn level_now(&self) -> f64 {
		self.s.level as f64 + if self.s.level < 60 { self.s.xp / LEVEL_XP[self.s.level] } else { 0.0 }
	}

	/// XP since level 1 (the search's at-equal-XP estimate).
	pub fn total_xp(&self) -> f64 {
		crate::xp::LEVEL_XP[1..self.s.level.min(60)].iter().sum::<f64>() + self.s.xp
	}

	// ---- quest log ----
	fn abandonable(&self) -> i32 {
		let r = self.run;
		let max = self.s.level as i64 - ABANDON_GAP;
		let mut l: i64 = 0;
		while l <= max && l < 64 {
			if self.act_lv[l as usize] != 0 {
				for k in r.q_lv_start[l as usize]..r.q_lv_start[l as usize + 1] {
					let q = r.q_by_level[k] as usize;
					if self.active[q] != 0 {
						return q as i32;
					}
				}
			}
			l += 1;
		}
		-1
	}

	/// timed_until from the timed quests still in the log.
	fn timed_recount(&mut self) {
		let r = self.run;
		self.s.timed_until = (0..r.n_quests()).filter(|&x| self.active[x] != 0 && r.q_limit[x] > 0.0).map(|x| self.accept_t[x] + r.q_limit[x]).fold(0.0, f64::max);
	}

	fn abandon(&mut self, q: usize) {
		let r = self.run;
		self.set(Arr::Active, q, 0.0);
		if self.t.p.feasible && r.q_limit[q] > 0.0 {
			self.s.timed_active -= 1;
			self.timed_recount();
		}
		self.s.open -= 1;
		self.s.log_abandoned += 1;
		for t in r.q_task0[q]..r.q_task1[q] {
			let t = t as usize;
			if self.task_done[t] != 0 {
				self.set(Arr::Task, t, 0.0);
			}
			for w in r.task_w0[t]..r.task_w1[t] {
				if self.killed[w as usize] > 0.0 {
					self.set(Arr::Killed, w as usize, 0.0);
				}
			}
		}
	}

	// ---- XP and levels ----
	fn level_up(&mut self) {
		self.s.xp -= LEVEL_XP[self.s.level];
		self.s.level += 1;
		self.level_times[self.s.level] = self.s.time;
		if self.s.level >= 60 {
			self.s.level = 60;
			self.s.xp = 0.0;
			self.s.finished = true;
			return;
		}
		self.s.time += self.t.p.level_overhead;
		self.s.c.level_ups += 1.0;
		if !self.s.mounted && self.s.level as f64 >= self.t.p.mount_level {
			self.s.mounted = true;
			self.s.d = self.travel.matrix_for(self.s.mask, true);
		}
	}

	fn gain(&mut self, amount: f64) {
		self.s.xp += amount;
		while !self.s.finished && self.s.xp >= LEVEL_XP[self.s.level] {
			self.level_up();
		}
	}

	/// Grind until `level` (+ xp_into) at the best site for the current level.
	pub fn grind_to(&mut self, level: usize, xp_into: f64) {
		while !self.s.finished && (self.s.level < level || (self.s.level == level && self.s.xp < xp_into)) {
			let target = if self.s.level < level { LEVEL_XP[self.s.level] } else { xp_into };
			let need = target - self.s.xp;
			if need <= 0.0 {
				break;
			}
			let sec = need / self.t.grind_rate[self.s.level];
			self.s.time += sec;
			self.s.grind_sec += sec;
			self.s.xp_grind += need;
			self.s.c.grind_xp[self.s.level] += need;
			self.gain(need);
		}
	}

	// ---- travel ----
	fn learn_fp(&mut self, fp: usize) {
		let r = self.run;
		if self.known[fp] == 0 && r.fp_bit[fp] >= 0 {
			self.set(Arr::Known, fp, 1.0);
			self.s.mask |= 1u64 << r.fp_bit[fp];
			self.s.d = self.travel.matrix_for(self.s.mask, self.s.mounted);
			self.s.time += self.t.p.talk_sec;
			self.s.c.talks += 1.0;
			let at = self.at_step;
			if let Some(t) = self.trace.as_mut() {
				t.push((at, Trace::FlightPath { node: fp as u32 }));
			}
		}
	}

	/// v1's travel plan after a step: its bind and flight paths.
	fn plan_after(&mut self, st: Step) {
		let r = self.run;
		let Some(plan) = r.plan.as_ref() else { return };
		let Some(key) = r.step_key(st.kind, st.q, st.task) else { return };
		if let Some(fps) = plan.fp.get(&key) {
			for &fp in fps {
				self.learn_fp(fp as usize);
			}
		}
		if let Some(&inn) = plan.bind.get(&key) {
			self.bind_plan(inn);
		}
	}

	fn bind_plan(&mut self, inn: u32) {
		if inn as i32 != self.s.bind {
			let at = self.at_step;
			if let Some(t) = self.trace.as_mut() {
				t.push((at, Trace::Bind { inn, pt: self.run.inn_pt[inn as usize] }));
			}
			self.s.bind = inn as i32;
			self.s.time += self.t.p.talk_sec;
		}
	}

	fn learn_at(&mut self, pt: u32) {
		let r = self.run;
		let fp = r.p_fp[pt as usize];
		if fp >= 0 && self.known[fp as usize] == 0 {
			self.set(Arr::Known, fp as usize, 1.0);
			self.s.mask |= 1u64 << r.fp_bit[fp as usize];
			self.s.d = self.travel.matrix_for(self.s.mask, self.s.mounted);
			self.s.time += self.t.p.talk_sec;
			self.s.c.talks += 1.0;
			let at = self.at_step;
			if let Some(t) = self.trace.as_mut() {
				t.push((at, Trace::FlightPath { node: fp as u32 }));
			}
		}
		let inn = if r.plan.is_some() { -1 } else { r.p_inn[pt as usize] };
		if inn >= 0 {
			if inn != self.s.bind {
				let at = self.at_step;
				if let Some(t) = self.trace.as_mut() {
					t.push((at, Trace::Bind { inn: inn as u32, pt }));
				}
			}
			self.s.bind = inn;
		}
	}

	/// The seconds of a leg from a to b now (no state change).
	pub fn leg_now(&mut self, a: u32, b: u32) -> f64 {
		let d = self.s.d.clone();
		self.travel.leg(self.run, self.walks, a, b, &d, self.s.mounted, self.s.level as f64)
	}

	/// Travel to pt. False (nothing changes) when pt cannot be reached.
	/// Travel to pt; `walk_only`: on foot (no hearth, flight or boat: an escort, a timed quest).
	fn move_to(&mut self, pt: u32) -> bool {
		let walk_only = self.t.p.feasible && self.s.timed_active > 0 && self.s.time < self.s.timed_until;
		self.move_to_by(pt, walk_only)
	}

	fn move_to_by(&mut self, pt: u32, walk_only: bool) -> bool {
		if pt == self.s.pos {
			return true;
		}
		let d = self.s.d.clone();
		let (run, walks, mounted, level) = (self.run, self.walks, self.s.mounted, self.s.level as f64);
		let mut c = if walk_only {
			let w = self.travel.walk_leg(run, walks, self.s.pos, pt, mounted, level);
			if w.is_finite() {
				w
			} else {
				self.travel.leg(run, walks, self.s.pos, pt, &d, mounted, level)
			}
		} else {
			self.travel.leg(run, walks, self.s.pos, pt, &d, mounted, level)
		};
		let mut mode = self.travel.last_mode;
		let mut risk = self.travel.last_risk;
		let mut walk = self.travel.last_walk;
		let mut nodes = self.travel.last_nodes;
		let mut hearth = false;
		let p = &self.t.p;
		if !walk_only && self.s.bind >= 0 && self.s.time >= self.s.hearth_ready && c > 120.0 && (self.run.plan.is_none() || self.plan_hearth) {
			let from = run.inn_pt[self.s.bind as usize];
			let h = p.hearth_cast + self.travel.leg(run, walks, from, pt, &d, mounted, level);
			// v1's own hearth lines are taken unless the hearth is clearly worse (PLAN_HEARTH_SLACK):
			// the guide hearths there, and the walk the model prefers is the straight one.
			let better = if self.plan_hearth { h < c + PLAN_HEARTH_SLACK } else { h + 30.0 < c };
			if better {
				c = h;
				risk = self.travel.last_risk;
				mode = self.travel.last_mode;
				walk = self.travel.last_walk;
				nodes = self.travel.last_nodes;
				hearth = true;
				self.s.hearth_ready = self.s.time + p.hearth_cooldown;
				self.s.hearths += 1;
			} else if mode == 1 {
				self.s.flights += 1;
			}
		} else if mode == 1 {
			self.s.flights += 1;
		}
		if c == f64::INFINITY {
			return false;
		}
		if let Some(t) = self.trace.as_mut() {
			let from = self.s.pos;
			if hearth {
				t.push((self.at_step, Trace::Hearth { inn: self.s.bind as u32, to: pt }));
			}
			if mode == 1 {
				let start = if hearth { self.run.inn_pt[self.s.bind as usize] } else { from };
				let mut legs = Vec::new();
				if nodes.0 >= 0 && nodes.1 >= 0 {
					let (na, nb) = (nodes.0 as usize, nodes.1 as usize);
					legs.push(crate::travel::Leg::Walk { to: run.node_w[na], node: Some(na as u32) });
					legs.extend(self.travel.base.path(run, self.s.mask, &d, mounted, na, nb));
					legs.push(crate::travel::Leg::Walk { to: run.pt_list[pt as usize], node: None });
				}
				t.push((self.at_step, Trace::Network { from: start, to: pt, seconds: if hearth { c - self.t.p.hearth_cast } else { c }, legs }));
			} else if !hearth && c > WALK_TRACE_SEC {
				t.push((self.at_step, Trace::Walk { from, to: pt, seconds: c }));
			}
		}
		self.s.risk_crossings += risk;
		self.s.time += c;
		{
			let k = &mut self.s.c;
			let leg = if hearth { c - self.t.p.hearth_cast } else { c };
			if hearth {
				k.hearth_casts += 1.0;
			}
			self.s.walked = mode == 0 && !hearth;
			if mode == 0 {
				k.risks += risk;
				let m = usize::from(self.s.mounted);
				k.walk_yd[m][walk.1 as usize] += walk.0;
			} else {
				k.network_sec += leg;
			}
		}
		self.s.travel_sec += c;
		let (pi, si) = (pt as usize, self.s.pos as usize);
		if run.p_map[pi] != run.p_map[si] {
			self.s.zone_changes += 1;
			let z = run.p_zone[pi] as usize;
			if self.zone_seen[z] != 0 {
				self.s.zone_returns += 1;
			} else {
				self.set(Arr::Zone, z, 1.0);
			}
		}
		let a = self.s.area_pt as usize;
		let dx = run.p_x[pi] - run.p_x[a];
		let dy = run.p_y[pi] - run.p_y[a];
		if run.p_r[pi] != run.p_r[a] || dx * dx + dy * dy > SPOT_LEAVE * SPOT_LEAVE {
			self.s.area_id += 1.0;
			self.s.area_pt = pt;
		}
		if self.t.p.along && self.s.walked {
			self.along(self.s.pos, pt);
		}
		self.s.pos = pt;
		self.learn_at(pt);
		true
	}

	/// Along credit (engine rule R1): a walked leg from a to b passing within PASS_ALONG_YD of
	/// the site of an open quest's unfinished, non-elite kill objective (not the leg's own
	/// destination) kills ALONG_FRAC of what it needs there on the way: their kill time and XP,
	/// plus the pull out of the line beyond ALONG_FREE_YD; the work left at its own step shrinks
	/// (and a finished objective's trip is skipped: covered).
	fn along(&mut self, a: u32, b: u32) {
		let r = self.run;
		let (ai, bi) = (a as usize, b as usize);
		if r.p_r[ai] != r.p_r[bi] {
			return;
		}
		let (ax, ay, dx, dy) = (r.p_x[ai], r.p_y[ai], r.p_x[bi] - r.p_x[ai], r.p_y[bi] - r.p_y[ai]);
		let l2 = dx * dx + dy * dy;
		if l2 < 1.0 {
			return;
		}
		let mut credit: Vec<(usize, f64)> = Vec::new();
		for lv in 0..64usize {
			if self.act_lv[lv] == 0 {
				continue;
			}
			for k in r.q_lv_start[lv]..r.q_lv_start[lv + 1] {
				let q = r.q_by_level[k] as usize;
				if self.active[q] == 0 {
					continue;
				}
				for task in r.q_task0[q]..r.q_task1[q] {
					let task = task as usize;
					if self.task_done[task] != 0 {
						continue;
					}
					let s = r.task_pt[task] as usize;
					if r.p_r[s] != r.p_r[ai] || (r.p_x[s] - r.p_x[bi]).hypot(r.p_y[s] - r.p_y[bi]) <= PASS_ALONG_YD {
						continue;
					}
					let t = (((r.p_x[s] - ax) * dx + (r.p_y[s] - ay) * dy) / l2).clamp(0.0, 1.0);
					let d = (ax + t * dx - r.p_x[s]).hypot(ay + t * dy - r.p_y[s]);
					if d > PASS_ALONG_YD {
						continue;
					}
					for w in r.task_w0[task] as usize..r.task_w1[task] as usize {
						if r.w_kind[w] == W_KILL && !r.w_elite[w] && r.w_share[w].is_empty() {
							credit.push((w, d));
						}
					}
				}
			}
		}
		for (w, d) in credit {
			let need = self.kills_for(w) - self.killed[w];
			if need <= 1e-9 {
				continue;
			}
			let g = need.min(self.kills_for(w) * ALONG_FRAC);
			let l = self.s.level;
			let m = r.w_level[w] as usize;
			let xp_per = self.t.kill_x[l * MOBL + m];
			// The pull out of the line, as kill spacing (priced by the counters the same way).
			let gap = if self.t.p.spacing > 0.0 { 2.0 * (d - ALONG_FREE_YD).max(0.0) / self.t.p.spacing } else { 0.0 };
			let t_per = self.t.kill_t[l * MOBL + m] + gap * self.t.p.spacing / self.t.p.run_speed;
			// Only when it costs no more a kill than at its own site (the pull against the
			// camp's spacing).
			if gap > r.w_spacing[w] {
				continue;
			}
			self.count_kills(g, l, m, false, gap, false, t_per);
			self.s.time += g * t_per;
			self.s.along_kills += g;
			self.set(Arr::Killed, w, self.killed[w] + g);
			if xp_per > 0.0 && !self.s.finished {
				self.s.xp_kill += g * xp_per;
				self.gain(g * xp_per);
			}
		}
	}

	fn mark_spot(&mut self, pt: u32) {
		let c = self.run.p_cell[pt as usize] as usize;
		let a = self.cell_area[c];
		if a == self.s.area_id {
			return;
		}
		if a > 0.0 {
			self.s.spot_returns += 1;
		}
		self.set(Arr::Cell, c, self.s.area_id);
	}

	#[inline]
	fn kills_for(&self, w: usize) -> f64 {
		let r = self.run;
		if r.w_drop[w] {
			r.w_count[w] / self.t.p.drop_mul
		} else {
			r.w_count[w]
		}
	}

	fn share_kills(&mut self, w: usize, k: f64) {
		let r = self.run;
		for &b in &r.w_share[w] {
			let b = b as usize;
			let t = r.w_task[b] as usize;
			if self.task_done[t] != 0 || self.active[r.t_quest[t] as usize] == 0 {
				continue;
			}
			let need = self.kills_for(b) - self.killed[b];
			if need <= 1e-9 {
				continue;
			}
			let c = if k < need { k } else { need };
			self.set(Arr::Killed, b, self.killed[b] + c);
			self.s.shared_kills += c;
		}
	}

	fn covered(&self, task: usize) -> bool {
		let r = self.run;
		let w1 = r.task_w1[task] as usize;
		let w0 = r.task_w0[task] as usize;
		for w in w0..w1 {
			if r.w_kind[w] != W_KILL || !(self.killed[w] > 0.0) || self.killed[w] < self.kills_for(w) - 1e-9 {
				return false;
			}
		}
		w1 > w0
	}

	/// Mobs up at camp c now: the ones taken at its last farming, respawning continuously
	/// (camp.js `avail`).
	fn camp_avail(&self, c: usize) -> f64 {
		let k = &self.run.camps[c];
		let taken = self.camp_taken[c];
		if taken <= 0.0 {
			return k.spawns;
		}
		let back = (self.s.time - self.camp_last[c]) * k.spawns / k.respawn;
		k.spawns - (taken - back).max(0.0)
	}

	/// Seconds a kill work item's kills take at camp alternative `a` now (the spot choice's
	/// estimate: kill time at the camp's mob level and spacing, the fresh mobs at the kill rate,
	/// the rest at the respawn rate).
	fn camp_work_estimate(&self, w: usize, a: usize) -> f64 {
		let r = self.run;
		let p = &self.t.p;
		let (c, kills) = r.w_alts[w][a];
		let k = &r.camps[c as usize];
		let l = self.s.level;
		let mut n = kills * (1.0 + p.extra_kill);
		if r.w_drop[w] {
			n /= p.drop_mul;
		}
		let tk = self.t.kill_t[l * MOBL + k.mob as usize] * if r.w_elite[w] { p.elite_time } else { 1.0 } + k.spacing * p.spacing / p.run_speed;
		let up = self.camp_avail(c as usize).max(0.0);
		if n <= up {
			n * tk
		} else {
			up * tk + (n - up) * tk.max(k.respawn / k.spawns)
		}
	}

	/// Counters of `k` kills at player level l on mobs of level m (see Counters).
	fn count_kills(&mut self, k: f64, l: usize, m: usize, elite: bool, gap: f64, waits: bool, t_per: f64) {
		let c = &mut self.s.c;
		if waits {
			c.wait_sec += k * t_per;
			return;
		}
		let p = &self.t.p;
		let d = m as f64 - l as f64;
		let f = if d >= 0.0 { 1.0 + p.kill_up * d } else { (1.0 + p.kill_down * d).max(0.5) };
		let w60 = (l as f64 - 1.0) / 59.0;
		let e = usize::from(elite);
		c.kill[e][0] += k * f * (1.0 - w60);
		c.kill[e][1] += k * f * w60;
		c.kill_gap_yd += k * gap;
	}

	/// The work of a task. `alt`: the camp alternative chosen for its kill work item `w`
	/// (spots); others take their default camp (camps) or v1's site (neither).
	fn do_work(&mut self, task: usize, alt: Option<(usize, usize)>) {
		let r = self.run;
		let t = self.t;
		let p = &t.p;
		let w1 = r.task_w1[task] as usize;
		let mut w = r.task_w0[task] as usize;
		while w < w1 && !self.s.finished {
			let kind = r.w_kind[w];
			if kind == W_KILL {
				// The camp the kills are done at, with the camp term: (camp, kills needed there).
				let camp = if !p.camps || r.w_alts[w].is_empty() {
					None
				} else {
					// Chosen by the spot term, else the ground cheapest from the task's site
					// (out and back at run speed, plus its work now).
					let a = match alt {
						Some((aw, a)) if aw == w => a,
						_ => {
							let site = r.task_pt[task];
							(0..r.w_alts[w].len())
								.min_by(|&x, &y| {
									let c = |a: usize| 2.0 * r.straight(site, r.camps[r.w_alts[w][a].0 as usize].pt) / p.run_speed + self.camp_work_estimate(w, a);
									c(x).total_cmp(&c(y)).then(x.cmp(&y))
								})
								.unwrap()
						}
					};
					Some(r.w_alts[w][a])
				};
				let mut n = camp.map_or(r.w_count[w], |c| c.1) * (1.0 + p.extra_kill);
				if r.w_drop[w] {
					n /= p.drop_mul;
				}
				let had = self.killed[w];
				let shares = !r.w_share[w].is_empty();
				let base = if had > 0.0 || shares { self.kills_for(w) } else { 0.0 };
				if had > 0.0 {
					if had >= base - 1e-9 {
						w += 1;
						continue;
					}
					n *= (base - had) / base;
				}
				if shares {
					self.share_kills(w, base - had);
				}
				let elite = r.w_elite[w];
				let (m, walk, slow, mut up, gap) = match camp {
					None => (r.w_level[w] as usize, (r.w_spacing[w] * p.spacing) / (p.run_speed * 1.0), 0.0, f64::INFINITY, r.w_spacing[w]),
					Some((c, _)) => {
						let k = &r.camps[c as usize];
						(k.mob as usize, k.spacing * p.spacing / p.run_speed, k.respawn / k.spawns, self.camp_avail(c as usize).max(0.0), k.spacing)
					}
				};
				while n > 0.0 && !self.s.finished {
					let l = self.s.level;
					let xp_per = t.kill_x[l * MOBL + m] * if elite { 2.0 } else { 1.0 };
					let base_t = t.kill_t[l * MOBL + m] * if elite { p.elite_time } else { 1.0 } + walk;
					// Fresh mobs at the kill rate; once the camp is down, one a respawn share.
					let t_per = if up > 0.0 { base_t } else { base_t.max(slow) };
					let seg = if up > 0.0 && up < n { up } else { n };
					let waits = t_per > base_t;
					if xp_per <= 0.0 {
						self.count_kills(seg, l, m, elite, gap, waits, t_per);
						self.s.time += seg * t_per;
						n -= seg;
						if up > 0.0 {
							up -= seg;
						}
						continue;
					}
					let k = ((LEVEL_XP[l] - self.s.xp) / xp_per).ceil();
					if k >= seg {
						self.count_kills(seg, l, m, elite, gap, waits, t_per);
						self.s.time += seg * t_per;
						self.s.xp_kill += seg * xp_per;
						self.s.xp += seg * xp_per;
						n -= seg;
						if up > 0.0 {
							up -= seg;
						}
						if self.s.xp >= LEVEL_XP[l] {
							self.gain(0.0);
						}
					} else {
						self.count_kills(k, l, m, elite, gap, waits, t_per);
						self.s.time += k * t_per;
						self.s.xp_kill += k * xp_per;
						self.gain(k * xp_per);
						n -= k;
						if up > 0.0 {
							up -= k;
						}
					}
				}
				if let Some((c, _)) = camp {
					let c = c as usize;
					let left = self.run.camps[c].spawns - up.clamp(0.0, self.run.camps[c].spawns);
					self.set(Arr::CampTaken, c, left);
					self.set(Arr::CampLast, c, self.s.time);
				}
			} else if kind == W_USE {
				let mut n = r.w_count[w];
				if r.w_drop[w] {
					n /= p.drop_mul;
				}
				self.s.time += n * p.interact_sec;
				self.s.c.uses += n;
			} else if kind == W_ESCORT {
				self.s.time += p.escort_sec;
				self.s.c.escorts += 1.0;
			} else if kind == W_BUY {
				self.s.time += p.talk_sec;
				self.s.c.talks += 1.0;
			}
			w += 1;
		}
	}

	pub fn prereq_ok(&self, q: usize) -> bool {
		let r = self.run;
		if r.q_parent[q] >= 0 && self.active[r.q_parent[q] as usize] == 0 {
			return false;
		}
		for &e in &r.q_excl[q] {
			if self.active[e as usize] != 0 || self.done[e as usize] != 0 {
				return false;
			}
		}
		for &a in &r.q_all[q] {
			if self.done[a as usize] == 0 {
				return false;
			}
		}
		let pre = &r.q_pre[q];
		pre.is_empty() || pre.iter().any(|&p| self.done[p as usize] != 0)
	}

	/// Where a task is done (the spot term, after Factoruide's plan/spot.rs `spot`): with
	/// `spots`, a task whose first kill work item lives at several camps goes to the camp that
	/// costs the least from here, through its work, to where the order goes next (the next
	/// step's place, else the quest's ender); otherwise its own site.
	fn spot(&mut self, task: usize, pt: u32, q: usize) -> (u32, Option<(usize, usize)>) {
		let r = self.run;
		if !self.t.p.spots {
			return (pt, None);
		}
		let Some(w) = (r.task_w0[task] as usize..r.task_w1[task] as usize).find(|&w| r.w_kind[w] == W_KILL && r.w_alts[w].len() > 1) else {
			return (pt, None);
		};
		let next = if self.next_pt != u32::MAX { self.next_pt } else { r.q_ender[q] };
		let mut best = (f64::INFINITY, pt, None);
		for a in 0..r.w_alts[w].len() {
			let c = r.camps[r.w_alts[w][a].0 as usize].pt;
			let there = self.leg_now(self.s.pos, c);
			if there >= best.0 {
				continue;
			}
			let cost = there + self.camp_work_estimate(w, a) + self.leg_now(c, next);
			if cost < best.0 {
				best = (cost, c, Some((w, a)));
			}
		}
		(best.1, best.2)
	}

	/// Step i of an order, knowing where the order goes next (the spot term reads it).
	pub fn step_in(&mut self, steps: &[Step], i: usize) -> bool {
		self.at_step = i as u32;
		self.s.walked = false;
		self.next_pt = steps[i + 1..].iter().take(NEXT_LOOK).find(|s| s.kind != K_GRIND).map_or(u32::MAX, |s| s.pt);
		self.step(steps[i])
	}

	/// One step (evaluate.js `step`, sequence mode: nothing deferred). True when it did
	/// something; a step that does nothing changes no state (only the no-op counters).
	pub fn step(&mut self, st: Step) -> bool {
		if st.kind == K_GRIND {
			if self.s.finished {
				return false;
			}
			let t0 = self.s.time;
			self.grind_to(st.q as usize, st.task as f64);
			return self.s.time > t0;
		}
		self.plan_hearth = self.plan_pending.0 || self.run.plan.as_ref().is_some_and(|p| self.run.step_key(st.kind, st.q, st.task).is_some_and(|k| p.hearth.contains(&k)));
		if self.plan_hearth && self.s.bind >= 0 && self.s.time < self.s.hearth_ready {
			self.s.plan_cooldown += 1;
		}
		let ok = self.step_inner(st);
		self.plan_hearth = false;
		if !ok {
			self.s.noops += 1;
			if let Some(plan) = self.run.plan.as_ref() {
				if let Some(key) = self.run.step_key(st.kind, st.q, st.task) {
					let pd = &mut self.plan_pending;
					pd.0 |= plan.hearth.contains(&key);
					if let Some(&inn) = plan.bind.get(&key) {
						pd.1 = Some(inn);
					}
					if let Some(f) = plan.fp.get(&key) {
						pd.2.extend(f.iter().copied());
					}
				}
			}
		} else {
			let (_, inn, fps) = std::mem::take(&mut self.plan_pending);
			for fp in fps {
				self.learn_fp(fp as usize);
			}
			if let Some(inn) = inn {
				self.bind_plan(inn);
			}
			self.plan_after(st);
		}
		ok
	}

	fn step_inner(&mut self, st: Step) -> bool {
		let r = self.run;
		let q = st.q as usize;
		let pt = st.pt;
		let p = &self.t.p;
		match st.kind {
			K_ACCEPT => {
				if self.done[q] != 0 || self.active[q] != 0 || !self.prereq_ok(q) {
					return false;
				}
				let level = self.s.level as f64;
				let opens = (r.q_min_level[q] as f64 - p.gate_gap).max(r.q_level[q] as f64 - p.danger_gap - p.gate_gap);
				if level < opens {
					return false;
				}
				let full = self.s.open >= r.log_cap;
				let drop = if full { self.abandonable() } else { -1 };
				if full && drop < 0 {
					self.s.log_skipped += 1;
					return false;
				}
				if !self.move_to(pt) {
					self.s.unreachable += 1;
					return false;
				}
				if (self.s.level as i32) < r.q_min_level[q] {
					self.grind_to(r.q_min_level[q] as usize, 0.0);
				}
				if (self.s.level as f64) + self.t.p.danger_gap < r.q_level[q] as f64 {
					self.grind_to((r.q_level[q] as f64 - self.t.p.danger_gap) as usize, 0.0);
				}
				if drop >= 0 {
					self.abandon(drop as usize);
				}
				if st.task >= 0 {
					self.do_work(st.task as usize, None);
				}
				self.s.time += self.t.p.talk_sec;
				self.s.c.talks += 1.0;
				self.set(Arr::Active, q, 1.0);
				if self.t.p.feasible && r.q_limit[q] > 0.0 {
					self.set(Arr::AcceptT, q, self.s.time);
					self.s.timed_active += 1;
					self.s.timed_until = self.s.timed_until.max(self.s.time + r.q_limit[q]);
				}
				if self.ever_active[q] == 0 {
					self.set(Arr::Ever, q, 1.0);
				}
				self.s.open += 1;
				if self.s.open > self.s.log_peak {
					self.s.log_peak = self.s.open;
				}
			}
			K_TASK => {
				let task = st.task as usize;
				if self.active[q] == 0 || self.task_done[task] != 0 {
					return false;
				}
				let bag = self.t.p.feasible && r.task_bag.get(task).copied().unwrap_or(false);
				if !bag && !self.covered(task) {
					let (at, alt) = self.spot(task, pt, q);
					let escort = self.t.p.feasible && r.q_escort_task[q] == task as i32;
					let walk_only = escort || (self.t.p.feasible && self.s.timed_active > 0 && self.s.time < self.s.timed_until);
					if !self.move_to_by(at, walk_only) {
						self.s.unreachable += 1;
						return false;
					}
					let t0 = self.s.time;
					self.do_work(task, alt);
					if let Some(l) = self.work_log.as_mut() {
						l.push((task as u32, self.s.time - t0));
					}
				}
				self.set(Arr::Task, task, 1.0);
			}
			K_TURNIN => {
				if self.active[q] == 0 {
					return false;
				}
				for t in r.q_task0[q]..r.q_task1[q] {
					if self.task_done[t as usize] == 0 {
						return false;
					}
				}
				for &a in &r.q_after[q] {
					if self.done[a as usize] == 0 {
						return false;
					}
				}
				if !self.move_to(pt) {
					self.s.unreachable += 1;
					return false;
				}
				self.s.time += self.t.p.talk_sec;
				self.s.c.talks += 1.0;
				let d = self.s.level as i64 - r.q_level[q] as i64;
				let xp = self.t.q_full[q] * SHARE[d.clamp(0, 63) as usize];
				if self.t.p.feasible && r.q_limit[q] > 0.0 {
					self.s.timed_active -= 1;
					if self.s.time - self.accept_t[q] > r.q_limit[q] {
						self.s.late += 1;
					}
				}
				self.set(Arr::Active, q, 0.0);
				if self.t.p.feasible && r.q_limit[q] > 0.0 {
					self.timed_recount();
				}
				self.s.open -= 1;
				self.set(Arr::Done, q, 1.0);
				self.s.quests_done += 1;
				self.s.xp_quest += xp;
				self.gain(xp);
			}
			K_TRAIN => {
				// A class training stop: to the town's trainers, then train (no quest work,
				// so no spot mark).
				if !self.move_to(pt) {
					self.s.unreachable += 1;
					return false;
				}
				self.s.time += self.t.p.train_sec;
				self.s.c.trains += 1.0;
				self.s.trains += 1;
				return true;
			}
			_ => return false,
		}
		self.s.steps += 1;
		if pt == self.s.pos {
			self.mark_spot(pt);
		}
		true
	}

	/// Grind out to 60 (after the last step).
	pub fn finish(&mut self) {
		if !self.s.finished {
			self.grind_to(60, 0.0);
		}
	}

	/// Seconds to 60 (or the time reached).
	pub fn seconds(&self) -> f64 {
		if self.level_times[60] > 0.0 {
			self.level_times[60]
		} else {
			self.s.time
		}
	}

	/// Quests accepted at some point and never turned in.
	pub fn never_turned_in(&self) -> u32 {
		(0..self.run.n_quests()).filter(|&q| self.ever_active[q] != 0 && self.done[q] == 0).count() as u32
	}
}

/// What a route's time was spent on: re-pricing it under another parameter set is a dot
/// product (DeepResearch §1.3), exact for this route's decisions and levels. Held at the
/// route's own values (they change decisions or levels): killUp/killDown (in `kill`),
/// extraKill and dropMul (in the kill counts), the quest XP scales, the mount level.
#[derive(Clone, Debug, PartialEq)]
pub struct Counters {
	/// Kills × level-difference factor, [non-elite, elite][killSec1 weight, killSec60 weight].
	pub kill: [[f64; 2]; 2],
	/// Kills × yards between mobs.
	pub kill_gap_yd: f64,
	/// Seconds waiting for respawns (a camp down).
	pub wait_sec: f64,
	pub talks: f64,
	pub uses: f64,
	pub escorts: f64,
	pub trains: f64,
	pub level_ups: f64,
	pub hearth_casts: f64,
	/// Danger crossings priced (deathRisk each).
	pub risks: f64,
	/// Walked yards, [unmounted, mounted][routed, straight on continent 0, 1, other].
	pub walk_yd: [[f64; 4]; 2],
	/// Seconds of network legs (walks to nodes, flights, boats).
	pub network_sec: f64,
	/// Grinding XP by level.
	pub grind_xp: [f64; 61],
}

impl Default for Counters {
	fn default() -> Self {
		Counters {
			kill: [[0.0; 2]; 2],
			kill_gap_yd: 0.0,
			wait_sec: 0.0,
			talks: 0.0,
			uses: 0.0,
			escorts: 0.0,
			trains: 0.0,
			level_ups: 0.0,
			hearth_casts: 0.0,
			risks: 0.0,
			walk_yd: [[0.0; 4]; 2],
			network_sec: 0.0,
			grind_xp: [0.0; 61],
		}
	}
}

impl Counters {
	/// Seconds under parameters `p` (run: the grind spacing for the grind rates).
	pub fn seconds(&self, run: &Run, p: &crate::Params) -> f64 {
		let cf = p.class_factor;
		let mut t = cf * (self.kill[0][0] * p.kill_sec1 + self.kill[0][1] * p.kill_sec60);
		t += cf * p.elite_time * (self.kill[1][0] * p.kill_sec1 + self.kill[1][1] * p.kill_sec60);
		t += self.kill_gap_yd * p.spacing / p.run_speed;
		t += self.wait_sec;
		t += self.talks * p.talk_sec + self.uses * p.interact_sec + self.escorts * p.escort_sec + self.trains * p.train_sec;
		t += self.level_ups * p.level_overhead + self.hearth_casts * p.hearth_cast + self.risks * p.death_risk;
		for (m, row) in self.walk_yd.iter().enumerate() {
			let v = p.run_speed * if m == 1 { p.mount_mul } else { 1.0 };
			t += (row[0] * p.route_mul + row[1] * p.detour0 + row[2] * p.detour1 + row[3] * (p.detour0 + p.detour1) / 2.0) / v;
		}
		t += self.network_sec;
		let rate = crate::run::grind_rates(run, p);
		for l in 1..60 {
			if self.grind_xp[l] > 0.0 {
				t += self.grind_xp[l] / rate[l];
			}
		}
		t
	}
}

/// A route item the evaluator decides on the way (Evaluator::trace).
#[derive(Clone, Debug, PartialEq, serde::Serialize)]
#[serde(tag = "t", rename_all = "lowercase")]
pub enum Trace {
	/// Bound at an inn (the hearthstone's home): a `sethome` there.
	Bind { inn: u32, pt: u32 },
	/// Hearthed to the bound inn, on the way to `to`.
	Hearth { inn: u32, to: u32 },
	/// A leg over the transport network (flights, boats, zeppelins, trams) from `from` to `to`.
	Network {
		from: u32,
		to: u32,
		seconds: f64,
		/// The path the leg was priced on: walk to the first node, rides and flights, walk on.
		#[serde(skip_serializing_if = "Vec::is_empty")]
		legs: Vec<crate::travel::Leg>,
	},
	/// A long walk the leg was priced as (over WALK_TRACE_SEC): walked, no network.
	Walk { from: u32, to: u32, seconds: f64 },
	/// A flight path learned.
	#[serde(rename = "getfp")]
	FlightPath { node: u32 },
}
