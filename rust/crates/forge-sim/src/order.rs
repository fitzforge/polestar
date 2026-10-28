//! Orders: the steps a route plays, where each came from, the seed built from v1's chain, the
//! rules every order keeps (a quest's own order and v1's deliberate orders), and the diff of
//! two orders.

use crate::eval::{Evaluator, Step};
use crate::profile::TOWN_TRAIN_YD;

/// Straight yards a trainer town may lie off a leg on one continent and still be on the way.
pub const TOWN_ON_WAY_YD: f64 = 400.0;
/// Seconds a trainer town may add to a long leg and still be on the way.
pub const TOWN_ON_WAY_SEC: f64 = 90.0;
use crate::run::{Run, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};
use crate::seq::{compile_events, Event};
use serde::Serialize;
use serde_json::Value;

/// Where a step came from: a goal index of the seed chain (>= 0), INSERTED (the search added
/// it) or TRAIN_STOP - k (the k-th `train class` stop the profile added: each its own id, so the
/// search can hold every training near its level).
pub const INSERTED: i64 = -1;
pub const TRAIN_STOP: i64 = -2;

#[derive(Clone, Debug, PartialEq)]
pub struct Order {
	pub steps: Vec<Step>,
	pub origin: Vec<i64>,
}

impl Order {
	pub fn len(&self) -> usize {
		self.steps.len()
	}
	pub fn is_empty(&self) -> bool {
		self.steps.is_empty()
	}
	/// Quests (run indices) whose accept is in the order.
	pub fn quests(&self) -> Vec<u32> {
		let mut v: Vec<u32> = self.steps.iter().filter(|s| s.kind == K_ACCEPT).map(|s| s.q).collect();
		v.sort_unstable();
		v.dedup();
		v
	}
}

/// Play an order from the start; per step whether it did something; seconds to 60.
pub fn play_order(ev: &mut Evaluator, steps: &[Step]) -> (f64, Vec<bool>) {
	ev.reset();
	let mut did = Vec::with_capacity(steps.len());
	for i in 0..steps.len() {
		did.push(!ev.s.finished && ev.step_in(steps, i));
	}
	ev.finish();
	(ev.seconds(), did)
}

/// The seed: v1's chain as steps, keeping only steps that do something in the model (the
/// rest change nothing: a turn-in's repeated objective sites, accepts of quests the character
/// can't have; a training with no new rank to teach), then, with `train_stops`, a `train class`
/// stop where the order passes or stops at a trainer town with a new rank to learn
/// (Evaluator::teaches_at).
pub fn seed_order(ev: &mut Evaluator, events: &[Event], train_stops: bool) -> Order {
	let run = ev.run;
	let (tagged, _) = compile_events(run, events, ev.t.p.feasible);
	let steps: Vec<Step> = tagged.iter().map(|t| t.step).collect();
	let (_, did) = play_order(ev, &steps);
	let mut o = Order { steps: Vec::new(), origin: Vec::new() };
	for (k, t) in tagged.iter().enumerate() {
		// A training right after a training is the same visit to the trainer.
		let dup = t.step.kind == K_TRAIN && o.steps.last().is_some_and(|l| l.kind == K_TRAIN);
		if did[k] && !dup {
			o.steps.push(t.step);
			o.origin.push(events[t.ev as usize].src);
		}
	}
	if !train_stops || run.towns.is_empty() {
		return o;
	}
	// v1's own trainings by level: no stop added where one of them comes within a level.
	ev.reset();
	let mut v1_train: Vec<(usize, f64)> = Vec::new();
	for (k, &s) in o.steps.iter().enumerate() {
		if s.kind == K_TRAIN {
			v1_train.push((k, ev.level_now()));
		}
		ev.step(s);
	}
	let v1_soon = |k: usize, lv: f64| v1_train.iter().any(|&(j, l)| j > k && l < lv + 1.0);
	let mut out = Order { steps: Vec::with_capacity(o.len() + 40), origin: Vec::with_capacity(o.len() + 40) };
	ev.reset();
	// Out of the starting valley: past LEFT_VALLEY_YD from the start point; its trainers no
	// longer count as a town.
	let mut left = false;
	let mut towns: Vec<u32> = run.towns.clone();
	for (k, &s) in o.steps.iter().enumerate() {
		if !left && s.kind != K_GRIND && run.straight(run.start_pt, s.pt) > crate::profile::LEFT_VALLEY_YD {
			left = true;
			towns.retain(|t| !run.valley_towns.contains(t));
		}
		// A long leg that passes a trainer town (the town costs at most TOWN_ON_WAY_SEC more):
		// training there, on the way.
		if s.kind != K_GRIND
			&& s.kind != K_TRAIN
			&& !ev.s.finished
			&& !v1_soon(k, ev.level_now())
			&& !towns.iter().any(|&t| run.straight(s.pt, t) <= TOWN_TRAIN_YD)
		{
			let a = ev.s.pos;
			let direct = ev.leg_now(a, s.pt);
			if direct > TOWN_ON_WAY_SEC {
				// On the way: within TOWN_ON_WAY_YD of the straight line on one continent (a town
				// reached by flying out and back is a trip, not a stop: Orgrimmar from Stonetalon);
				// across a sea, a town on either shore's continent by time.
				let on_line = |t: u32| {
					let (x, y, z) = (run.straight(a, t), run.straight(t, s.pt), run.straight(a, s.pt));
					if z.is_finite() {
						x + y - z <= TOWN_ON_WAY_YD
					} else {
						x.is_finite() || y.is_finite()
					}
				};
				let teach: Vec<u32> = towns.iter().copied().filter(|&t| on_line(t) && ev.teaches_at(t).is_some()).collect();
				let via = teach.iter().map(|&t| (t, ev.leg_now(a, t) + ev.leg_now(t, s.pt))).min_by(|x, y| x.1.total_cmp(&y.1));
				if let Some((t, v)) = via.filter(|v| v.1 <= direct + TOWN_ON_WAY_SEC) {
					let _ = v;
					let st = Step { kind: K_TRAIN, q: 0, task: -1, pt: t };
					ev.step(st);
					out.steps.push(st);
					out.origin.push(TRAIN_STOP - out.steps.iter().filter(|x| x.kind == K_TRAIN).count() as i64);
				}
			}
		}
		// (v1's own training that teaches nothing here does nothing: left out.)
		if ev.step(s) || s.kind != K_TRAIN {
			out.steps.push(s);
			out.origin.push(o.origin[k]);
		}
		if s.kind == K_TRAIN || s.kind == K_GRIND || ev.s.finished || v1_soon(k, ev.level_now()) {
			continue;
		}
		// A stop at a trainer town with a new rank to learn: training there.
		let near = towns.iter().copied().filter(|&t| run.straight(s.pt, t) <= TOWN_TRAIN_YD && ev.teaches_at(t).is_some()).min_by(|&a, &b| run.straight(s.pt, a).total_cmp(&run.straight(s.pt, b)));
		if let Some(t) = near {
			let st = Step { kind: K_TRAIN, q: 0, task: -1, pt: t };
			ev.step(st);
			out.steps.push(st);
			out.origin.push(TRAIN_STOP - out.steps.iter().filter(|x| x.kind == K_TRAIN).count() as i64);
		}
	}
	place_trains(ev, &mut out);
	due_trains(ev, &mut out);
	out
}

/// Steps either side an added training may move to (place_trains).
pub const TRAIN_PLACE_REACH: usize = 40;

/// Each added training (origin TRAIN_STOP - k) moved to the cheapest place by straight detour
/// within TRAIN_PLACE_REACH steps where the character has the same new ranks (the level's
/// floor no lower), no other training between: on the visit to its town, not as a bounce out
/// of a visit near it (the Earthen Ring, Brakk).
fn place_trains(ev: &mut Evaluator, out: &mut Order) {
	let run = ev.run;
	let mut k = 0;
	while k < out.len() {
		if out.origin[k] > TRAIN_STOP {
			k += 1;
			continue;
		}
		ev.reset();
		let mut lv = Vec::with_capacity(out.len());
		for s in &out.steps {
			lv.push(ev.level_now());
			ev.step(*s);
		}
		let s = out.steps.remove(k);
		let g = out.origin.remove(k);
		let need = lv[k].floor();
		let mut loc = Vec::with_capacity(out.len());
		let mut at = run.start_pt;
		for x in &out.steps {
			if x.kind != K_GRIND {
				at = x.pt;
			}
			loc.push(at);
		}
		let lvl_at = |j: usize| if j < k { lv[j] } else { lv.get(j + 1).copied().unwrap_or(60.0) };
		let d = |a: u32, b: u32| {
			let x = run.straight(a, b);
			if x.is_finite() {
				x
			} else {
				1.0e6
			}
		};
		let lo = k.saturating_sub(TRAIN_PLACE_REACH);
		let hi = (k + TRAIN_PLACE_REACH).min(out.len());
		let mut best = (f64::INFINITY, k);
		for j in lo..=hi {
			let crosses = if j < k { out.steps[j..k].iter().any(|x| x.kind == K_TRAIN) } else { out.steps[k..j].iter().any(|x| x.kind == K_TRAIN) };
			if crosses || lvl_at(j).floor() < need || j == 0 {
				continue;
			}
			let prev = loc[j - 1];
			let c = if j == out.len() { d(prev, s.pt) } else { d(prev, s.pt) + d(s.pt, loc[j]) - d(prev, loc[j]) };
			if c < best.0 - 1e-9 {
				best = (c, j);
			}
		}
		// Next to another training: that one covers it.
		let j = best.1;
		let twin = (j > 0 && out.steps[j - 1].kind == K_TRAIN) || out.steps.get(j).is_some_and(|x| x.kind == K_TRAIN);
		if twin {
			k = j;
			continue;
		}
		out.steps.insert(j, s);
		out.origin.insert(j, g);
		k = j + 1;
	}
}

/// Trainings inside a field stretch: a training whose steps either side (grind checkpoints skipped)
/// are both work away from its town (beyond the hub reach, crate::hubs::HUB_YD): the trip to the
/// trainer splits the field work (RevNightElf3, c13 Shadowglen: the level-4 training between the
/// cave's tasks). A kept move adds none (search::Member::replay).
pub fn field_trains(run: &Run, steps: &[Step]) -> u32 {
	let away = |x: &Step, t: &Step| x.kind == K_TASK && run.straight(x.pt, t.pt) > crate::hubs::HUB_YD;
	let mut it = steps.iter().filter(|s| s.kind != K_GRIND);
	let (Some(mut a), Some(mut b)) = (it.next(), it.next()) else { return 0 };
	let mut n = 0;
	for c in it {
		if b.kind == K_TRAIN && away(a, b) && away(c, b) {
			n += 1;
		}
		(a, b) = (b, c);
	}
	n
}

/// Levels a class rank may wait for its training at most (the route benchmark, Human 12-30: the
/// level 20, 22 and 24 ranks waited from the 19.3 training in Lakeshire to 25.7 at Goldshire, where
/// a player trains at 20 in Stormwind during Redridge).
pub const TRAIN_DUE_GAP: f64 = 4.0;
/// Steps after a rank comes due a training is placed within (at a flight master there).
pub const TRAIN_DUE_REACH: usize = 80;
/// A training due's `task` (a training's floor level otherwise; none below it): the guards know it
/// for a trip to the trainer made by design (guards::train_bounces leaves it out).
pub const TRAIN_DUE_TASK: i32 = -2;

/// A training due: where the character reaches a level with a new rank (the training table's) and
/// the order's next training comes TRAIN_DUE_GAP or more levels later (or never), a training at a
/// trainer town that teaches it, right after a stop at a flight master within TRAIN_DUE_REACH steps
/// (a trip from the route's own flight path, not a walk out of a camp): the stop and town where the
/// trip, with what the town costs the classes it has no trainer for (Evaluator::train_price), costs
/// least over going on. Each rank level once; none where no flight master is passed.
pub fn due_trains(ev: &mut Evaluator, out: &mut Order) {
	let run = ev.run;
	if run.towns.is_empty() {
		return;
	}
	let mut done: Vec<u32> = Vec::new();
	'again: loop {
		// Levels before each step, the steps whose training teaches something.
		ev.reset();
		let mut lv = Vec::with_capacity(out.len());
		let mut trains: Vec<usize> = Vec::new();
		for (k, s) in out.steps.iter().enumerate() {
			lv.push(ev.level_now());
			if ev.step(*s) && s.kind == K_TRAIN {
				trains.push(k);
			}
		}
		ev.reset();
		for k in 0..out.len() {
			let s = out.steps[k];
			let rank = ev.teaches_at(s.pt);
			if let Some(rank) = rank.filter(|r| !done.contains(r) && s.kind != K_TRAIN) {
				let next = trains.iter().find(|&&t| t >= k).map_or(f64::INFINITY, |&t| lv[t]);
				if next >= rank as f64 + TRAIN_DUE_GAP {
					done.push(rank);
					// The stop at a flight master within reach (not next to a training, the character
					// not finished) where the trip to the nearest teaching town and on to the next
					// stop costs least over going on directly.
					ev.reset();
					for x in &out.steps[..k] {
						ev.step(*x);
					}
					let mut best: Option<(f64, usize, u32)> = None;
					for j in k..(k + TRAIN_DUE_REACH).min(out.len()) {
						let x = out.steps[j];
						ev.step(x);
						let twin = x.kind == K_TRAIN || out.steps.get(j + 1).is_some_and(|y| y.kind == K_TRAIN);
						if x.kind == K_GRIND || twin || ev.s.finished || run.p_fp[x.pt as usize] < 0 || ev.teaches_at(x.pt).is_none() {
							continue;
						}
						let left = run.straight(run.start_pt, x.pt) > crate::profile::LEFT_VALLEY_YD;
						let next = out.steps[j + 1..].iter().find(|y| y.kind != K_GRIND).map(|y| y.pt);
						let towns: Vec<u32> = run.towns.iter().copied().filter(|t| !(left && run.valley_towns.contains(t))).collect();
						for t in towns {
							// The town's price for the classes it has no trainer for too (c14, Human: a
							// trip from Felwood to Darnassus, which trains no Paladin, Mage or Warlock).
							let (go, on, direct) = (ev.leg_now(x.pt, t), next.map_or(0.0, |n| ev.leg_now(t, n)), next.map_or(0.0, |n| ev.leg_now(x.pt, n)));
							let c = go + on - direct + ev.train_price(t);
							if c.is_finite() && best.is_none_or(|b| c < b.0) {
								best = Some((c, j, t));
							}
						}
					}
					if let Some((_, j, t)) = best {
						out.steps.insert(j + 1, Step { kind: K_TRAIN, q: 0, task: TRAIN_DUE_TASK, pt: t });
						// A new added training's own origin (the guards find a training by it).
						let g = out.origin.iter().copied().filter(|&g| g < TRAIN_STOP).min().unwrap_or(TRAIN_STOP) - 1;
						out.origin.insert(j + 1, g);
					}
					continue 'again;
				}
			}
			ev.step(s);
		}
		break;
	}
}

/// A precedence rule: every step of kind `ka` of quest `qa` before every step of kind `kb` of
/// quest `qb` (run quest indices), when both are in the order.
#[derive(Clone, Copy, Debug)]
pub struct Pair {
	pub ka: u8,
	pub qa: u32,
	pub kb: u8,
	pub qb: u32,
	/// Run task indices when a step is a task of one objective (a record's third element: the
	/// objective's index); -1: every step of that kind.
	pub ta: i32,
	pub tb: i32,
}

impl Pair {
	pub fn new(ka: u8, qa: u32, kb: u8, qb: u32) -> Pair {
		Pair { ka, qa, kb, qb, ta: -1, tb: -1 }
	}
}

/// A record's step (`[kind, quest, objective?]`) as (kind, run quest, run task or -1); None when
/// the quest is not in the run, or the objective names no task of it (said on the console: a
/// record that silently did nothing hid #102, #555, #612).
fn record_step(run: &Run, v: &Value, what: &str) -> Option<(u8, u32, i32)> {
	let k = match v[0].as_str().unwrap_or("") {
		"accept" => K_ACCEPT,
		"task" => K_TASK,
		_ => K_TURNIN,
	};
	let id = v[1].as_u64()? as u32;
	let q = run.q(id)?;
	let t = match v.get(2).and_then(Value::as_u64) {
		None => -1,
		Some(i) => match rule_task(run, q, i) {
			Some(t) => t,
			None => {
				eprintln!("route-fixes {what}: quest {id} has no objective {i}: the record is left out");
				return None;
			}
		},
	};
	Some((k, q, t))
}

/// v1's deliberate orders (route fixes `deliberate`) for this run's quests.
pub fn deliberate_pairs(run: &Run) -> Vec<Pair> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	let mut v = Vec::new();
	for p in doc["pairs"].as_array().into_iter().flatten() {
		let (Some((ka, qa, ta)), Some((kb, qb, tb))) = (record_step(run, &p["a"], "pair"), record_step(run, &p["b"], "pair")) else { continue };
		v.push(Pair { ka, qa, kb, qb, ta, tb });
	}
	v
}

/// Checks an order keeps its rules: each quest's accept before its objective sites before its
/// turn-in, and the deliberate pairs. Scratch space sized for the run.
pub struct Checker {
	/// Per quest, per kind (accept, task, turn-in): first and last position (-1: none).
	first: Vec<[i32; 3]>,
	last: Vec<[i32; 3]>,
	seen: Vec<u32>,
	/// Quest ids by run index (for `broken`'s words).
	ids: Vec<u32>,
}

impl Checker {
	pub fn new(run: &Run) -> Checker {
		Checker { first: vec![[-1; 3]; run.n_quests()], last: vec![[-1; 3]; run.n_quests()], seen: Vec::new(), ids: run.q_id.clone() }
	}

	pub fn valid(&mut self, steps: &[Step], pairs: &[Pair], feas: &Feas) -> bool {
		self.broken(steps, pairs, feas).is_none()
	}

	/// The first rule an order breaks, in words (None: it keeps them all): a skip ledger names the
	/// rule that refused a quest (the route benchmark: Protect Kaya, Hilary's Necklace and A Free Lunch cut as
	/// `player-report` with no record behind them).
	pub fn broken(&mut self, steps: &[Step], pairs: &[Pair], feas: &Feas) -> Option<String> {
		for &q in &self.seen {
			self.first[q as usize] = [-1; 3];
			self.last[q as usize] = [-1; 3];
		}
		self.seen.clear();
		for (i, s) in steps.iter().enumerate() {
			let k = match s.kind {
				K_ACCEPT => 0,
				K_TASK => 1,
				K_TURNIN => 2,
				_ => continue,
			};
			let q = s.q as usize;
			if self.first[q] == [-1; 3] {
				self.seen.push(s.q);
			}
			if self.first[q][k] < 0 {
				self.first[q][k] = i as i32;
			}
			self.last[q][k] = i as i32;
		}
		let id = |q: u32| self.ids.get(q as usize).copied().unwrap_or(q);
		for &q in &self.seen {
			let (f, l) = (self.first[q as usize], self.last[q as usize]);
			// accept < tasks < turn-in, where present
			if f[0] >= 0 && ((f[1] >= 0 && f[1] < f[0]) || (f[2] >= 0 && f[2] < f[0])) {
				return Some(format!("quest order: quest {}'s accept after its work or hand-in", id(q)));
			}
			if f[2] >= 0 && l[1] > f[2] {
				return Some(format!("quest order: quest {}'s work after its hand-in", id(q)));
			}
		}
		for p in pairs {
			let ia = match p.ka {
				K_ACCEPT => 0,
				K_TASK => 1,
				_ => 2,
			};
			let ib = match p.kb {
				K_ACCEPT => 0,
				K_TASK => 1,
				_ => 2,
			};
			let la = if p.ta >= 0 { steps.iter().rposition(|s| s.kind == K_TASK && s.q == p.qa && s.task == p.ta).map_or(-1, |x| x as i32) } else { self.last[p.qa as usize][ia] };
			let fb = if p.tb >= 0 { steps.iter().position(|s| s.kind == K_TASK && s.q == p.qb && s.task == p.tb).map_or(-1, |x| x as i32) } else { self.first[p.qb as usize][ib] };
			if la >= 0 && fb >= 0 && la > fb {
				return Some(format!("deliberate pair: {} {} before {} {}", kind_name(p.ka), id(p.qa), kind_name(p.kb), id(p.qb)));
			}
		}
		// Item needs: B's step needs A handed in before it.
		for n in &feas.needs {
			let fb = match n.task {
				t if t >= 0 => steps.iter().position(|s| s.kind == K_TASK && s.q == n.qb && s.task == t).map_or(-1, |x| x as i32),
				_ => self.first[n.qb as usize][kind_ix(n.kb)],
			};
			if fb < 0 {
				continue;
			}
			let ta = match n.task_a {
				t if t >= 0 => steps.iter().position(|s| s.kind == K_TASK && s.q == n.qa && s.task == t).map_or(-1, |x| x as i32),
				_ => self.first[n.qa as usize][kind_ix(n.ka)],
			};
			if ta < 0 || ta > fb {
				return Some(format!("feasibility: {} {} after {} {} ({})", kind_name(n.kb), id(n.qb), kind_name(n.ka), id(n.qa), n.why));
			}
		}
		for t in &feas.together {
			let a = steps.iter().rposition(|s| s.kind == t.ka && s.q == t.qa && (t.ta < 0 || s.task == t.ta));
			let b = steps.iter().position(|s| s.kind == t.kb && s.q == t.qb && (t.tb < 0 || s.task == t.tb));
			if let (Some(a), Some(b)) = (a, b) {
				// a == b: one step is both ends (nothing between them).
				if b < a || (b > a && steps[a + 1..b].iter().any(|s| !t.near.contains(&s.pt))) {
					return Some(format!("deliberate together: {} {} right after {} {}", kind_name(t.kb), id(t.qb), kind_name(t.ka), id(t.qa)));
				}
			}
		}
		for &q in &feas.keep {
			if self.first[q as usize][0] < 0 {
				return Some(format!("deliberate keep: quest {} not taken", id(q)));
			}
		}
		for &q in &feas.skip {
			if self.first[q as usize][0] >= 0 {
				return Some(format!("override skip: quest {} taken", id(q)));
			}
		}
		for r in &feas.south {
			let Some(end) = steps.iter().position(|s| s.kind == r.kind && s.q == r.q) else { continue };
			let mut last: Option<f64> = None;
			for s in &steps[..end] {
				// The quest the stretch ends at is taken before it (Deputy Rainer, on the road in).
				if !matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) || s.q == r.q {
					continue;
				}
				let (m, x) = r.px[s.pt as usize];
				if m != r.map {
					continue;
				}
				if last.is_some_and(|l| x > l + r.tol) {
					return Some(format!("deliberate southward: map {} before {} {}", r.map, kind_name(r.kind), id(r.q)));
				}
				last = Some(x);
			}
		}
		// Escorts: nothing between the accept and the escort but talks at the giver.
		for e in &feas.escorts {
			let ia = self.first[e.q as usize][0];
			if ia < 0 {
				continue;
			}
			let Some(it) = steps.iter().position(|s| s.kind == K_TASK && s.q == e.q && s.task == e.task) else { continue };
			for s in &steps[ia as usize + 1..it] {
				let at_giver = matches!(s.kind, K_ACCEPT | K_TURNIN) && e.near.binary_search(&s.pt).is_ok();
				if !at_giver {
					return Some(format!("escort: quest {} walked from its giver, a step between its accept and its escort", id(e.q)));
				}
			}
		}
		None
	}
}

/// How an improved order differs from the seed, by quest (ids).
#[derive(Clone, Debug, Default, Serialize)]
pub struct Diff {
	pub added: Vec<u32>,
	pub dropped: Vec<u32>,
	/// Quests whose accept or turn-in moved by more than MOVED_RANK places among the quest
	/// events (accepts and turn-ins), with the shift.
	pub moved: Vec<(u32, i64)>,
	/// Of the quest events (accepts, turn-ins) in both orders: how many are really reordered
	/// (outside the longest run kept in v1's relative order), by distinct quest with the
	/// largest shift among the common events; the rest of `moved` only shifted because steps
	/// were added or dropped around them.
	pub common_events: usize,
	pub reordered_events: usize,
	pub reordered: Vec<(u32, i64)>,
	pub shifted_only: usize,
	pub train_stops: (usize, usize),
	pub zone_returns: (u32, u32),
	pub spot_returns: (u32, u32),
	pub zone_changes: (u32, u32),
}

/// A quest event that moved this many places among the order's accepts and turn-ins counts
/// as moved.
pub const MOVED_RANK: i64 = 5;

pub fn diff(run: &Run, a: &Order, b: &Order) -> Diff {
	let qa = a.quests();
	let qb = b.quests();
	let ids = |v: &[u32]| v.iter().map(|&q| run.q_id[q as usize]).collect::<Vec<u32>>();
	let added: Vec<u32> = qb.iter().copied().filter(|q| qa.binary_search(q).is_err()).collect();
	let dropped: Vec<u32> = qa.iter().copied().filter(|q| qb.binary_search(q).is_err()).collect();
	let rank = |o: &Order| {
		let mut m = rustc_hash::FxHashMap::default();
		let mut r = 0i64;
		for s in &o.steps {
			if s.kind == K_ACCEPT || s.kind == K_TURNIN {
				m.insert((s.kind, s.q), r);
				r += 1;
			}
		}
		m
	};
	let (ra, rb) = (rank(a), rank(b));
	let mut moved: Vec<(u32, i64)> = Vec::new();
	for (k, &x) in &ra {
		if let Some(&y) = rb.get(k) {
			if (y - x).abs() > MOVED_RANK && !moved.iter().any(|m| m.0 == run.q_id[k.1 as usize]) {
				moved.push((run.q_id[k.1 as usize], y - x));
			}
		}
	}
	moved.sort_unstable();
	// Common events in b's order, as their rank among the common events of a.
	let common = |o: &Order, other: &rustc_hash::FxHashMap<(u8, u32), i64>| -> Vec<(u8, u32)> {
		o.steps.iter().filter(|s| (s.kind == K_ACCEPT || s.kind == K_TURNIN) && other.contains_key(&(s.kind, s.q))).map(|s| (s.kind, s.q)).collect()
	};
	let ca = common(a, &rb);
	let cb = common(b, &ra);
	let pos_a: rustc_hash::FxHashMap<(u8, u32), i64> = ca.iter().enumerate().map(|(i, k)| (*k, i as i64)).collect();
	let seq: Vec<i64> = cb.iter().map(|k| pos_a[k]).collect();
	let keep = lis_members(&seq);
	let mut reordered: Vec<(u32, i64)> = Vec::new();
	let mut reordered_events = 0;
	for (j, k) in cb.iter().enumerate() {
		if keep[j] {
			continue;
		}
		reordered_events += 1;
		let id = run.q_id[k.1 as usize];
		let shift = j as i64 - seq[j];
		match reordered.iter_mut().find(|m| m.0 == id) {
			Some(m) if shift.abs() > m.1.abs() => m.1 = shift,
			Some(_) => {}
			None => reordered.push((id, shift)),
		}
	}
	reordered.sort_unstable();
	let shifted_only = moved.iter().filter(|m| reordered.binary_search_by_key(&m.0, |r| r.0).is_err()).count();
	let trains = |o: &Order| o.steps.iter().filter(|s| s.kind == K_TRAIN).count();
	Diff { added: ids(&added), dropped: ids(&dropped), moved, common_events: cb.len(), reordered_events, reordered, shifted_only, train_stops: (trains(a), trains(b)), ..Default::default() }
}

/// Which elements form a longest strictly increasing subsequence (patience sorting).
pub fn lis_members(seq: &[i64]) -> Vec<bool> {
	let mut tails: Vec<usize> = Vec::new();
	let mut prev = vec![usize::MAX; seq.len()];
	for i in 0..seq.len() {
		let k = tails.partition_point(|&t| seq[t] < seq[i]);
		if k > 0 {
			prev[i] = tails[k - 1];
		}
		if k == tails.len() {
			tails.push(i);
		} else {
			tails[k] = i;
		}
	}
	let mut keep = vec![false; seq.len()];
	let mut i = tails.last().copied().unwrap_or(usize::MAX);
	while i != usize::MAX {
		keep[i] = true;
		i = prev[i];
	}
	keep
}

/// A hash of an order and its replay (FNV-1a over each step and the bits of the time after it,
/// then the seconds to 60): native and wasm builds must give the same.
pub fn action_hash(ev: &mut Evaluator, steps: &[Step]) -> u64 {
	let mut h: u64 = 0xcbf2_9ce4_8422_2325;
	let mut mix = |x: u64| {
		for b in x.to_le_bytes() {
			h ^= u64::from(b);
			h = h.wrapping_mul(0x0100_0000_01b3);
		}
	};
	ev.reset();
	for i in 0..steps.len() {
		let s = steps[i];
		if !ev.s.finished {
			ev.step_in(steps, i);
		}
		mix(u64::from(s.kind) | u64::from(s.q) << 8 | (s.task as u32 as u64) << 40);
		mix(u64::from(s.pt));
		mix(ev.s.time.to_bits());
	}
	ev.finish();
	mix(ev.seconds().to_bits());
	h
}

/// The pairs an order breaks (indices into `pairs`).
pub fn broken_pairs(steps: &[Step], pairs: &[Pair]) -> Vec<usize> {
	let rank = |k: u8| match k {
		K_ACCEPT => 0usize,
		K_TASK => 1,
		_ => 2,
	};
	let mut first: rustc_hash::FxHashMap<(u32, usize), usize> = rustc_hash::FxHashMap::default();
	let mut last: rustc_hash::FxHashMap<(u32, usize), usize> = rustc_hash::FxHashMap::default();
	for (i, s) in steps.iter().enumerate() {
		if matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) {
			first.entry((s.q, rank(s.kind))).or_insert(i);
			last.insert((s.q, rank(s.kind)), i);
		}
	}
	let la = |p: &Pair| if p.ta >= 0 { steps.iter().rposition(|s| s.kind == K_TASK && s.q == p.qa && s.task == p.ta) } else { last.get(&(p.qa, rank(p.ka))).copied() };
	let fb = |p: &Pair| if p.tb >= 0 { steps.iter().position(|s| s.kind == K_TASK && s.q == p.qb && s.task == p.tb) } else { first.get(&(p.qb, rank(p.kb))).copied() };
	(0..pairs.len()).filter(|&k| matches!((la(&pairs[k]), fb(&pairs[k])), (Some(a), Some(b)) if a > b)).collect()
}

fn kind_ix(k: u8) -> usize {
	match k {
		K_ACCEPT => 0,
		K_TASK => 1,
		_ => 2,
	}
}

fn kind_name(k: u8) -> &'static str {
	match k {
		K_ACCEPT => "accept",
		K_TASK => "task",
		_ => "turnin",
	}
}

/// B's step (kind kb; a K_TASK with `task` >= 0: that task) needs quest A handed in before it,
/// and A in the order at all (an item only A's reward gives).
#[derive(Clone, Debug)]
pub struct Need {
	pub kb: u8,
	pub qb: u32,
	pub task: i32,
	/// A's step: its turn-in (ka K_TURNIN), or, when the providing quest is not in the run (the
	/// Applejack Still: repeatable, no XP), the order's step v1 does just before it (an anchor).
	pub ka: u8,
	pub qa: u32,
	pub task_a: i32,
	pub why: String,
}

/// An escort quest: its escort task, and the run points within ESCORT_HUB_YD of its giver.
#[derive(Clone, Debug)]
pub struct Escort {
	pub q: u32,
	pub task: i32,
	pub near: Vec<u32>,
}

/// Yards: steps this close to an escort's giver may come between its accept and the escort
/// (talks at the same NPCs).
pub const ESCORT_HUB_YD: f64 = 40.0;

/// Feasibility rules every order keeps (beyond a quest's own order and v1's pairs).
#[derive(Clone, Debug, Default)]
pub struct Feas {
	pub needs: Vec<Need>,
	pub escorts: Vec<Escort>,
	/// Quests the order keeps (route fixes `deliberate` `keep`).
	pub keep: Vec<u32>,
	/// Quests never in the order (route fixes `overrides` `skip`, `revert` of an insert).
	pub skip: Vec<u32>,
	/// Stretches walked one way (route fixes `deliberate` `southward`).
	pub south: Vec<South>,
	/// Steps done together (route fixes `deliberate` `together`).
	pub together: Vec<Together>,
	/// v1 grind checkpoints (by origin) that guard no gate (route::free_grinds): a kept edit may
	/// drop them. Every other grind checkpoint stays.
	pub free_grinds: Vec<i64>,
}

impl Feas {
	/// The rules with only the keeps the order holds (its quest accepted). A kept quest whose steps
	/// do nothing (Teldrassil 940 in Human's v1 at 48, its bark never handed in) is gone from the
	/// cleaned order; judged against it, every insertion reads as breaking a deliberate record.
	pub fn held_by(&self, steps: &[Step]) -> Feas {
		let keep = self.keep.iter().copied().filter(|&q| steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q)).collect();
		Feas { keep, ..self.clone() }
	}
}

/// Step B right after step A: between them only steps at B's place (within ESCORT_HUB_YD).
#[derive(Clone, Debug)]
pub struct Together {
	pub ka: u8,
	pub qa: u32,
	pub kb: u8,
	pub qb: u32,
	/// Run task indices when the steps are tasks (-1: any step of that kind).
	pub ta: i32,
	pub tb: i32,
	pub near: Vec<u32>,
}

/// Before the first step of kind `kind` of quest `q`, the steps on map `map` go south: world x
/// (north) never rises by more than `tol` yards from one to the next.
#[derive(Clone, Debug)]
pub struct South {
	pub map: u32,
	pub kind: u8,
	pub q: u32,
	pub tol: f64,
	/// Per run point: (map, world x).
	pub px: std::sync::Arc<Vec<(u32, f64)>>,
}

/// The route fixes' `deliberate` `after` rules for a run: one step (a task by its index in the quest) after
/// another, as item needs are checked.
/// A route-fixes step's index (`["task", q, i]`) as the run task: the quest's objective `i`
/// (0-based, as the judge reads the record: `collect … quest q.(i+1)`), at the task it is
/// worked at (Run::task_objs); a record naming an objective worked at no task of its own (the
/// Runecloth of the Scourge cauldrons, from the bags, at the reagents' task) names that task.
/// None: the quest has no such objective or task in the run (never another quest's task).
pub fn rule_task(run: &Run, q: u32, i: u64) -> Option<i32> {
	let (t0, t1) = (run.q_task0[q as usize], run.q_task1[q as usize]);
	if i < 64 {
		if let Some(t) = (t0..t1).find(|&t| run.task_objs.get(t as usize).is_some_and(|b| b >> i & 1 == 1)) {
			return Some(t as i32);
		}
	}
	(t0 + (i as u32) < t1).then(|| (t0 + i as u32) as i32)
}

pub fn deliberate_after(run: &Run) -> Vec<Need> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	let kind = |s: &str| match s {
		"accept" => K_ACCEPT,
		"task" => K_TASK,
		_ => K_TURNIN,
	};
	// (A task index the run has no task for: the rule is not this run's.)
	let task = |q: u32, v: &Value| -> Option<i32> { v.as_u64().map_or(Some(-1), |t| rule_task(run, q, t)) };
	doc["after"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|r| {
			let (a, b) = (&r["a"], &r["b"]);
			let qa = a[1].as_u64().and_then(|q| run.q(q as u32))?;
			let qb = b[1].as_u64().and_then(|q| run.q(q as u32))?;
			Some(Need { kb: kind(b[0].as_str()?), qb, task: task(qb, &b[2])?, ka: kind(a[0].as_str()?), qa, task_a: task(qa, &a[2])?, why: r["why"].as_str().unwrap_or("").to_string() })
		})
		.collect()
}

/// The route fixes' `deliberate` `stay` rules: each matching step of v1's order (every task of the quest
/// when no index is given) keeps v1's neighbours: after the quest step v1 does just before it and
/// before the one v1 does just after it (of other quests).
pub fn deliberate_stay(run: &Run, seed: &[Step]) -> Vec<Need> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	let kind = |s: &str| match s {
		"accept" => K_ACCEPT,
		"task" => K_TASK,
		_ => K_TURNIN,
	};
	let entries: Vec<(u8, u32, Option<u32>, String)> = doc["stay"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|r| {
			let s = &r["s"];
			Some((kind(s[0].as_str()?), run.q(s[1].as_u64()? as u32)?, s[2].as_u64().map(|t| t as u32), r["why"].as_str().unwrap_or("").to_string()))
		})
		.collect();
	stay_needs(run, seed, &entries)
}

/// Stay rules (kind, quest, task index within the quest, why): each matching step of `seed`
/// (every task of the quest when no index) after the quest step v1 does just before it and
/// before the one just after it (of other quests).
pub fn stay_needs(run: &Run, seed: &[Step], entries: &[(u8, u32, Option<u32>, String)]) -> Vec<Need> {
	let quest_step = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	let tk = |s: &Step| if s.kind == K_TASK { s.task } else { -1 };
	let mut out = Vec::new();
	for (k, q, t, why) in entries {
		let (k, q) = (*k, *q);
		let want = match t {
			Some(t) => match rule_task(run, q, u64::from(*t)) {
				Some(x) => Some(x),
				None => continue,
			},
			None => None,
		};
		for (i, x) in seed.iter().enumerate() {
			if x.kind != k || x.q != q || want.is_some_and(|t| x.task != t) {
				continue;
			}
			if let Some(p) = seed[..i].iter().rev().find(|y| quest_step(y) && y.q != q) {
				out.push(Need { kb: x.kind, qb: q, task: tk(x), ka: p.kind, qa: p.q, task_a: tk(p), why: why.clone() });
			}
			if let Some(n) = seed[i + 1..].iter().find(|y| quest_step(y) && y.q != q) {
				out.push(Need { kb: n.kind, qb: n.q, task: tk(n), ka: x.kind, qa: q, task_a: tk(x), why: why.clone() });
			}
		}
	}
	out
}

/// The route fixes' `overrides` ([`crate::fixes`]).
pub fn overrides_doc() -> Value {
	crate::fixes::get()["overrides"].clone()
}

/// The overrides for a run: include (quest, anchor step after which its accept goes), skip,
/// revert (stay steps; keep quests; skip quests). Run indices; quests not in the run are left
/// out (listed in `missing` by id).
#[derive(Clone, Debug, Default)]
pub struct Overrides {
	pub include: Vec<(u32, Option<(u8, u32)>)>,
	pub skip: Vec<u32>,
	pub keep: Vec<u32>,
	pub stay: Vec<(u8, u32, Option<u32>)>,
	/// `pairs` ({a: [kind, q], b: [kind, q], why}, route fixes `deliberate`'s shape): precedence rules
	/// from player reports, kept as deliberate pairs are, and v1's order is made to keep them.
	pub pairs: Vec<Pair>,
	pub missing: Vec<u32>,
	/// Quest id -> (reason, issue) of each override, for the ledgers.
	pub why: rustc_hash::FxHashMap<u32, (String, String)>,
}

pub fn overrides_for(run: &Run, doc: &Value) -> Overrides {
	let kind = |s: &str| match s {
		"accept" => K_ACCEPT,
		"task" => K_TASK,
		_ => K_TURNIN,
	};
	let mut o = Overrides::default();
	let note = |o: &mut Overrides, id: u32, r: &Value, what: &str| {
		let reason = r["reason"].as_str().unwrap_or("").to_string();
		let issue = r["issue"].as_str().map(String::from).or_else(|| r["issue"].as_u64().map(|n| format!("#{n}"))).unwrap_or_default();
		o.why.insert(id, (format!("{what}: {reason}"), issue));
	};
	for r in doc["include"].as_array().into_iter().flatten() {
		let Some(id) = r["q"].as_u64().map(|x| x as u32) else { continue };
		note(&mut o, id, r, "include");
		let Some(q) = run.q(id) else {
			o.missing.push(id);
			continue;
		};
		let after = r["after"].as_array().and_then(|a| Some((kind(a.first()?.as_str()?), run.q(a.get(1)?.as_u64()? as u32)?)));
		o.include.push((q, after));
	}
	for r in doc["skip"].as_array().into_iter().flatten() {
		let Some(id) = r["q"].as_u64().map(|x| x as u32) else { continue };
		note(&mut o, id, r, "skip");
		match run.q(id) {
			Some(q) => o.skip.push(q),
			None => o.missing.push(id),
		}
	}
	for r in doc["revert"].as_array().into_iter().flatten() {
		if let Some(s) = r["s"].as_array() {
			let (Some(k), Some(id)) = (s.first().and_then(Value::as_str), s.get(1).and_then(Value::as_u64)) else { continue };
			note(&mut o, id as u32, r, "revert");
			if let Some(q) = run.q(id as u32) {
				o.stay.push((kind(k), q, s.get(2).and_then(Value::as_u64).map(|t| t as u32)));
			}
			continue;
		}
		let Some(id) = r["q"].as_u64().map(|x| x as u32) else { continue };
		note(&mut o, id, r, "revert");
		let Some(q) = run.q(id) else { continue };
		match r["edit"].as_str() {
			Some("drop") => o.keep.push(q),
			_ => o.skip.push(q),
		}
	}
	for p in doc["pairs"].as_array().into_iter().flatten() {
		let (a, b) = (&p["a"], &p["b"]);
		let (Some(ia), Some(ib)) = (a[1].as_u64(), b[1].as_u64()) else { continue };
		let (Some((ka, qa, ta)), Some((kb, qb, tb))) = (record_step(run, a, "pair"), record_step(run, b, "pair")) else { continue };
		o.pairs.push(Pair { ka, qa, kb, qb, ta, tb });
		let why = p["why"].as_str().unwrap_or("");
		o.why.entry(ib as u32).or_insert_with(|| (format!("pair: after {} {ia}: {why}", a[0].as_str().unwrap_or("")), String::new()));
	}
	o
}

/// The order with each pair it breaks kept: the `b` steps that come before the last `a` step,
/// and the later steps of b's quest before it (its task and turn-in after its accept), move to
/// just after that `a` step, in their order; with them, the steps between of the quests that
/// need b's quest handed in (its follow-ups, theirs in turn), which would otherwise be taken
/// before it opens them (the route benchmark: a pair moving Buzzbox 827's crawler legs after
/// Fruit of the Sea left Buzzbox 411, 323 and 525 accepted before 827 was handed in: dropped).
/// `needs(f, x)`: quest f needs quest x handed in (order::follows).
pub fn keep_pairs(seed: &Order, pairs: &[Pair], needs: &dyn Fn(u32, u32) -> bool) -> Order {
	let rank = |k: u8| match k {
		K_ACCEPT => 0usize,
		K_TASK => 1,
		_ => 2,
	};
	let mut out = seed.clone();
	for p in pairs {
		let is = |s: &Step, q: u32, k: u8, t: i32| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && s.q == q && rank(s.kind) == rank(k) && (t < 0 || s.task == t);
		let Some(last_a) = out.steps.iter().rposition(|s| is(s, p.qa, p.ka, p.ta)) else { continue };
		// (b one objective's task: that task and b's turn-in.)
		let mut moved: Vec<usize> = (0..last_a)
			.filter(|&i| {
				let s = &out.steps[i];
				matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && s.q == p.qb && rank(s.kind) >= rank(p.kb) && !(p.tb >= 0 && s.kind == K_TASK && s.task != p.tb)
			})
			.collect();
		if moved.is_empty() {
			continue;
		}
		// The follow-ups' steps between, when b's hand-in moves (transitively).
		let mut later: Vec<u32> = moved.iter().filter(|&&i| out.steps[i].kind == K_TURNIN).map(|&i| out.steps[i].q).collect();
		let mut k = 0;
		while k < later.len() {
			let x = later[k];
			for i in moved[0]..last_a {
				let s = out.steps[i];
				if matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && !moved.contains(&i) && (later.contains(&s.q) || (s.kind == K_ACCEPT && needs(s.q, x))) {
					if !later.contains(&s.q) {
						later.push(s.q);
					}
					moved.push(i);
				}
			}
			k += 1;
		}
		moved.sort_unstable();
		moved.dedup();
		let block: Vec<(Step, i64)> = moved.iter().map(|&i| (out.steps[i], out.origin[i])).collect();
		for &i in moved.iter().rev() {
			out.steps.remove(i);
			out.origin.remove(i);
		}
		let at = last_a + 1 - moved.len();
		for (k, (s, g)) in block.into_iter().enumerate() {
			out.steps.insert(at + k, s);
			out.origin.insert(at + k, g);
		}
	}
	out
}

/// Whether quest f needs quest x handed in first (one of its `pre`, all of `all`, its parent).
pub fn follows(run: &Run, f: u32, x: u32) -> bool {
	let f = f as usize;
	run.q_pre[f].contains(&x) || run.q_all[f].contains(&x) || run.q_parent[f] == x as i32
}

/// Yards within which two steps are at the same stop (one NPC, or NPCs side by side).
pub const SAME_STOP_YD: f64 = 40.0;

/// The order with each breadcrumb (`crumbs`: (breadcrumb, the quest it leads to), run indices)
/// handed in before its follow-up is taken, when the follow-up's accept comes first at the same
/// stop (every step from it to the hand-in within SAME_STOP_YD of it): taking the follow-up first
/// closes the breadcrumb in the game (RevA2: 2872/2873, 3763/3764).
pub fn breadcrumbs_first(run: &Run, crumbs: &[(u32, u32)], o: &Order) -> Order {
	let mut out = o.clone();
	for &(b, f) in crumbs {
		let (Some(t), Some(a)) = (out.steps.iter().position(|s| s.kind == K_TURNIN && s.q == b), out.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == f)) else { continue };
		if a > t || out.steps[a..t].iter().any(|s| s.q == b) || !out.steps[a..=t].iter().all(|s| s.kind != crate::run::K_GRIND && run.straight(s.pt, out.steps[a].pt) <= SAME_STOP_YD) {
			continue;
		}
		let (s, g) = (out.steps.remove(t), out.origin.remove(t));
		out.steps.insert(a, s);
		out.origin.insert(a, g);
	}
	out
}

/// The order with each `after` need it breaks kept, where both steps are on one map (route-fixes
/// `deliberate.after`: the Arcane Quickener's cauldron reagents before its quickener, after[8],
/// after[12]): the `b` step, and the later steps of b's quest before the `a` step (its turn-in;
/// its tasks after an accept), move to just after `a`, in their order. Returns the order and a
/// note per need repaired.
pub fn keep_after(run: &Run, seed: &Order, needs: &[Need]) -> (Order, Vec<String>) {
	let rank = |k: u8| match k {
		K_ACCEPT => 0usize,
		K_TASK => 1,
		_ => 2,
	};
	let mut out = seed.clone();
	let mut notes = Vec::new();
	for n in needs {
		let is = |s: &Step, k: u8, q: u32, t: i32| s.kind == k && s.q == q && (k != K_TASK || t < 0 || s.task == t);
		let Some(ib) = out.steps.iter().position(|s| is(s, n.kb, n.qb, n.task)) else { continue };
		let Some(ia) = out.steps.iter().rposition(|s| is(s, n.ka, n.qa, n.task_a)) else {
			// The step it needs is not in v1's order at all: another task of the same quest (the
			// cauldron's Runecloth, from the bags): it goes in just before.
			if n.ka == K_TASK && n.qa == n.qb && n.task_a >= 0 {
				out.steps.insert(ib, Step { kind: K_TASK, q: n.qa, task: n.task_a, pt: run.task_pt[n.task_a as usize] });
				out.origin.insert(ib, INSERTED);
				notes.push(format!("v1's order breaks ({}): the task it needs goes in just before it", n.why));
			}
			continue;
		};
		if ib > ia || run.p_map[out.steps[ib].pt as usize] != run.p_map[out.steps[ia].pt as usize] {
			continue;
		}
		let moved: Vec<usize> = (ib..ia).filter(|&i| i == ib || (matches!(out.steps[i].kind, K_ACCEPT | K_TASK | K_TURNIN) && out.steps[i].q == n.qb && rank(out.steps[i].kind) > rank(n.kb))).collect();
		let block: Vec<(Step, i64)> = moved.iter().map(|&i| (out.steps[i], out.origin[i])).collect();
		for &i in moved.iter().rev() {
			out.steps.remove(i);
			out.origin.remove(i);
		}
		let at = ia + 1 - moved.len();
		for (k, (s, g)) in block.into_iter().enumerate() {
			out.steps.insert(at + k, s);
			out.origin.insert(at + k, g);
		}
		notes.push(format!("v1's order breaks ({}): its step moved after the one it needs", n.why));
	}
	(out, notes)
}

/// The order with each `together` rule it breaks kept (route-fixes `deliberate.together`: the
/// Beached Sea Creature handed in with the Beached Sea Turtle): the `b` step moves to just after
/// the `a` step, with the steps of b's quest that must stay on its side of it (its later steps
/// when it moves later, its earlier ones when it moves earlier), in their order. A record is how
/// a reviewer says "do these together", so v1's order breaking it is repaired, not the record
/// dropped. Returns the order and a note per rule repaired.
pub fn keep_together(run: &Run, seed: &Order, rules: &[Together]) -> (Order, Vec<String>) {
	let rank = |k: u8| match k {
		K_ACCEPT => 0usize,
		K_TASK => 1,
		_ => 2,
	};
	let mut out = seed.clone();
	let mut notes = Vec::new();
	let mut c = Checker::new(run);
	for t in rules {
		let one = Feas { together: vec![t.clone()], ..Default::default() };
		if c.valid(&out.steps, &[], &one) {
			continue;
		}
		let is = |s: &Step, k: u8, q: u32, tk: i32| s.kind == k && s.q == q && (tk < 0 || s.task == tk);
		let (Some(ia), Some(ib)) = (out.steps.iter().rposition(|s| is(s, t.ka, t.qa, t.ta)), out.steps.iter().position(|s| is(s, t.kb, t.qb, t.tb))) else { continue };
		let of_b = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && s.q == t.qb;
		// b later (past a): b and b's later steps before a. b earlier (back to a): b's earlier
		// steps between a and b, then b.
		let moved: Vec<usize> = if ib < ia {
			(ib..ia).filter(|&i| i == ib || (of_b(&out.steps[i]) && rank(out.steps[i].kind) > rank(t.kb))).collect()
		} else {
			(ia + 1..=ib).filter(|&i| i == ib || (of_b(&out.steps[i]) && rank(out.steps[i].kind) < rank(t.kb))).collect()
		};
		let mut next = out.clone();
		let block: Vec<(Step, i64)> = moved.iter().map(|&i| (next.steps[i], next.origin[i])).collect();
		for &i in moved.iter().rev() {
			next.steps.remove(i);
			next.origin.remove(i);
		}
		let a_now = next.steps.iter().rposition(|s| is(s, t.ka, t.qa, t.ta)).expect("a stays");
		for (k, (s, g)) in block.into_iter().enumerate() {
			next.steps.insert(a_now + 1 + k, s);
			next.origin.insert(a_now + 1 + k, g);
		}
		if c.valid(&next.steps, &[], &one) {
			out = next;
			notes.push(format!("v1's order breaks together {} {}: the step moved next to the one it goes with", run.q_id[t.qa as usize], run.q_id[t.qb as usize]));
		}
	}
	(out, notes)
}

/// The order with the overrides applied: skipped quests out; included quests in (the accept
/// after its anchor, else at the stop nearest its giver; each task and the turn-in at the
/// cheapest place by straight detour within INCLUDE_SPAN steps after the accept).
pub fn apply_overrides(run: &Run, seed: &Order, o: &Overrides) -> Order {
	let keep: Vec<bool> = seed.steps.iter().map(|s| !(matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN) && o.skip.contains(&s.q))).collect();
	let mut out = Order { steps: seed.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: seed.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
	let d = |a: u32, b: u32| {
		let x = run.straight(a, b);
		if x.is_finite() {
			x
		} else {
			1.0e6
		}
	};
	for &(q, after) in &o.include {
		if out.steps.iter().any(|s| s.q == q && s.kind == K_ACCEPT) {
			continue;
		}
		let quest = crate::seq::quest_steps(run, q);
		let giver = run.q_giver[q as usize];
		let acc = match after.and_then(|(k, a)| out.steps.iter().rposition(|s| s.kind == k && s.q == a)) {
			Some(i) => i + 1,
			None => (0..out.len()).filter(|&i| out.steps[i].kind != K_GRIND).min_by(|&a, &b| d(out.steps[a].pt, giver).total_cmp(&d(out.steps[b].pt, giver))).map_or(out.len(), |i| i + 1),
		};
		out.steps.insert(acc, quest[0]);
		out.origin.insert(acc, INSERTED);
		let mut latest = acc;
		for &x in &quest[1..] {
			let lo = if x.kind == K_TASK { acc + 1 } else { latest + 1 };
			let hi = (lo + INCLUDE_SPAN).min(out.len());
			let mut best = (f64::INFINITY, lo.min(out.len()));
			let mut prev = out.steps[..lo.min(out.len())].iter().rev().find(|s| s.kind != K_GRIND).map_or(run.start_pt, |s| s.pt);
			for j in lo.min(out.len())..=hi {
				// A grind step has no point (u32::MAX): inserting before it costs the leg there only.
				let next = out.steps.get(j).filter(|s| s.kind != K_GRIND).map(|s| s.pt);
				let c = match next {
					Some(n) => d(prev, x.pt) + d(x.pt, n) - d(prev, n),
					None => d(prev, x.pt),
				};
				if c < best.0 {
					best = (c, j);
				}
				if let Some(s) = out.steps.get(j).filter(|s| s.kind != K_GRIND) {
					prev = s.pt;
				}
			}
			out.steps.insert(best.1, x);
			out.origin.insert(best.1, INSERTED);
			if x.kind == K_TASK {
				latest = latest.max(best.1);
			} else {
				latest = best.1;
			}
		}
	}
	out
}

/// Steps after an included quest's accept its tasks and turn-in may go.
pub const INCLUDE_SPAN: usize = 300;

/// The route fixes' `deliberate` `optional` quests (run indices) with why.
pub fn deliberate_optional_why(run: &Run) -> Vec<(u32, String)> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	doc["optional"].as_array().into_iter().flatten().filter_map(|x| Some((run.q(x["q"].as_u64()? as u32)?, x["why"].as_str().unwrap_or("").to_string()))).collect()
}

/// The route fixes' `deliberate` `optional` quests (run indices).
pub fn deliberate_optional(run: &Run) -> Vec<u32> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	doc["optional"].as_array().into_iter().flatten().filter_map(|x| x["q"].as_u64().and_then(|q| run.q(q as u32))).collect()
}

/// The route fixes' `deliberate` `together` rules for a run.
pub fn deliberate_together(run: &Run) -> Vec<Together> {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	let kind = |s: &str| match s {
		"accept" => K_ACCEPT,
		"task" => K_TASK,
		_ => K_TURNIN,
	};
	doc["together"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|t| {
			let qa = t["a"][1].as_u64().and_then(|q| run.q(q as u32))?;
			let qb = t["b"][1].as_u64().and_then(|q| run.q(q as u32))?;
			let kb = kind(t["b"][0].as_str()?);
			let task = |q: u32, v: &Value| -> Option<i32> { v.as_u64().map_or(Some(-1), |x| rule_task(run, q, x)) };
			let (ta, tb) = (task(qa, &t["a"][2])?, task(qb, &t["b"][2])?);
			let pb = match kb {
				K_ACCEPT => run.q_giver[qb as usize],
				K_TURNIN => run.q_ender[qb as usize],
				K_TASK if tb >= 0 => run.task_pt[tb as usize],
				// A task of the quest without its objective's index: its first objective's place.
				K_TASK if run.q_task1[qb as usize] > run.q_task0[qb as usize] => run.task_pt[run.q_task0[qb as usize] as usize],
				_ => return None,
			};
			let near = (0..run.pt_list.len() as u32).filter(|&p| run.straight(pb, p) <= ESCORT_HUB_YD).collect();
			Some(Together { ka: kind(t["a"][0].as_str()?), qa, kb, qb, ta, tb, near })
		})
		.collect()
}

/// The route fixes' `deliberate` `keep` and `southward` rules for a run.
pub fn deliberate_feas(run: &Run) -> (Vec<u32>, Vec<South>) {
	let fixes = crate::fixes::get();
	let doc = &fixes["deliberate"];
	let keep = doc["keep"].as_array().into_iter().flatten().filter_map(|k| k["q"].as_u64().and_then(|q| run.q(q as u32))).collect();
	let px = std::sync::Arc::new((0..run.pt_list.len()).map(|p| (run.p_map[p], run.p_x[p])).collect::<Vec<_>>());
	let south = doc["southward"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|r| {
			let q = r["until"][1].as_u64().and_then(|q| run.q(q as u32))?;
			let kind = match r["until"][0].as_str()? {
				"accept" => K_ACCEPT,
				"task" => K_TASK,
				_ => K_TURNIN,
			};
			Some(South { map: r["map"].as_u64()? as u32, kind, q, tol: r["tolYd"].as_f64().unwrap_or(80.0), px: px.clone() })
		})
		.collect();
	(keep, south)
}

impl Feas {
	/// The escorts of a run.
	pub fn escorts_of(run: &Run) -> Vec<Escort> {
		(0..run.n_quests())
			.filter(|&q| run.q_escort_task[q] >= 0)
			.map(|q| {
				let g = run.q_giver[q];
				let near = (0..run.pt_list.len() as u32).filter(|&p| run.straight(g, p) <= ESCORT_HUB_YD).collect();
				Escort { q: q as u32, task: run.q_escort_task[q], near }
			})
			.collect()
	}

	/// Leave out the rules v1's own order breaks (they can't be v1's), naming them.
	pub fn keep_seed(&mut self, run: &Run, seed: &[Step], log: &mut Vec<String>) {
		let mut c = Checker::new(run);
		let none: Vec<Pair> = Vec::new();
		let all = std::mem::take(&mut self.needs);
		for n in all {
			let one = Feas { needs: vec![n.clone()], ..Default::default() };
			if c.valid(seed, &none, &one) {
				self.needs.push(n);
			} else {
				log.push(format!("v1 breaks item need: {} {} before {} ({}): left out", run.q_id[n.qa as usize], "turnin", run.q_id[n.qb as usize], n.why));
			}
		}
		let keep = std::mem::take(&mut self.keep);
		for q in keep {
			let one = Feas { keep: vec![q], ..Default::default() };
			if c.valid(seed, &none, &one) {
				self.keep.push(q);
			}
		}
		let together = std::mem::take(&mut self.together);
		for t in together {
			let one = Feas { together: vec![t.clone()], ..Default::default() };
			if c.valid(seed, &none, &one) {
				self.together.push(t);
			} else {
				log.push(format!("v1 breaks together {} {}: left out", run.q_id[t.qa as usize], run.q_id[t.qb as usize]));
			}
		}
		let south = std::mem::take(&mut self.south);
		for r in south {
			let one = Feas { south: vec![r.clone()], ..Default::default() };
			if c.valid(seed, &none, &one) {
				self.south.push(r);
			} else {
				log.push(format!("v1 breaks the southward rule before {}: left out", run.q_id[r.q as usize]));
			}
		}
		let all = std::mem::take(&mut self.escorts);
		for e in all {
			let one = Feas { escorts: vec![e.clone()], ..Default::default() };
			if c.valid(seed, &none, &one) {
				self.escorts.push(e);
			} else {
				log.push(format!("v1 does other steps during escort {}: left unconstrained", run.q_id[e.q as usize]));
			}
		}
	}
}
