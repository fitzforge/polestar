//! Quests the route walks past: each one the order passes by and never takes (the guards'
//! passed-by, the judge's rule) is WORTHWHILE or RIGHTLY SKIPPED; the pickup pass inserts the
//! worthwhile ones where they are passed; and the long single-quest trips metric.
//!
//! Worthwhile: an insertable solo quest in the level window, not grey by its turn-in, whose XP
//! per minute of added time (its detour plus its work, grind excluded) is at least the route's
//! own XP per minute at that level, or half of it when the detour is under DETOUR_CHEAP_SEC.
//! The cost is measured, not estimated: the order with the quest inserted (edits::insertion) is
//! replayed and the time outside grinding compared.

use super::edits::{insertion, seg_dist, twin_trainings, Mv};
use super::{d, locs, Current, Member, Problem};
use crate::eval::Evaluator;
use crate::guards::{passed_never, GuardData};
use crate::insertable::Insertable;
use crate::order::Order;
use crate::run::{K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};
use crate::xp::SHARE;

/// A detour this short makes half the route's rate enough.
pub const DETOUR_CHEAP_SEC: f64 = 60.0;
/// Seconds the pickup pass lets one worthwhile quest add to the hours to 60.
pub const PICKUP_ALLOW_SEC: f64 = 120.0;
/// Places tried per pickup (the cheapest accepts by straight detour).
pub const PICKUP_PLACES: usize = 9;
/// Yards from every stop of the order past which a quest's work or turn-in leads off the route.
pub const OFF_ROUTE_YD: f64 = 500.0;
/// A single-quest trip longer than this (seconds, round trip) at under half the route's rate
/// is a long single-quest trip.
pub const LONG_TRIP_SEC: f64 = 180.0;

/// The classic grey level: quests at or below it are grey.
pub fn gray_level(level: f64) -> f64 {
	let l = level.floor();
	if l <= 5.0 {
		0.0
	} else if l < 40.0 {
		l - (l / 10.0).floor() - 5.0
	} else {
		l - (l / 5.0).floor() - 1.0
	}
}

/// The route's XP per minute while the character is at `level` (grinding included).
pub fn local_rate(c: &Current, level: f64) -> f64 {
	let lo = level.floor().min(59.0);
	let n = c.lv.len();
	let a = c.lv.iter().position(|&l| l >= lo).unwrap_or(0);
	let b = c.lv.iter().position(|&l| l >= lo + 1.0).unwrap_or(n.saturating_sub(1));
	if b <= a || c.ts[b] <= c.ts[a] {
		let t = c.ts.last().copied().unwrap_or(1.0).max(1.0);
		return c.xs.last().copied().unwrap_or(0.0) / t * 60.0;
	}
	(c.xs[b] - c.xs[a]) / (c.ts[b] - c.ts[a]) * 60.0
}

/// One passed-by quest's verdict.
#[derive(Clone, Debug, serde::Serialize)]
pub struct Passed {
	pub q: u32,
	pub id: u32,
	/// The step whose leg passes its giver first, and the level there.
	pub at: usize,
	pub lvl: f64,
	pub worthwhile: bool,
	/// Rightly skipped: why (empty when worthwhile).
	pub reason: String,
	pub xp: f64,
	pub cost_sec: f64,
	pub detour_sec: f64,
	/// XP per minute of the quest, and the route's at that level.
	pub rate: f64,
	pub local: f64,
}

/// A replay's time outside grinding, quest and kill XP, no-ops, and per task its work seconds.
struct Tally {
	busy: f64,
	xp: f64,
	noops: u32,
	work: Vec<(u32, f64)>,
}

fn tally(ev: &mut Evaluator, steps: &[crate::eval::Step]) -> Tally {
	ev.reset();
	ev.work_log = Some(Vec::new());
	for i in 0..steps.len() {
		if ev.s.finished {
			break;
		}
		ev.step_in(steps, i);
	}
	ev.finish();
	let t = Tally { busy: ev.seconds() - ev.s.grind_sec, xp: ev.s.xp_quest + ev.s.xp_kill, noops: ev.s.noops, work: ev.work_log.take().unwrap_or_default() };
	ev.work_log = None;
	t
}

/// The insertable verdict's reason as a category.
fn category(why: &str) -> String {
	let w = why.to_lowercase();
	if w.contains("kb") || w.contains("no known source") || w.contains("not in quests") {
		"uncertain data".into()
	} else if w.contains("group") || w.contains("dungeon") || w.contains("raid") || w.contains("pvp") || w.contains("elite") {
		"elite/group".into()
	} else if w.contains("start") || w.contains("drops") || w.contains("item") && w.contains('%') {
		format!("rare start ({why})")
	} else {
		why.to_string()
	}
}

/// Classify every quest the member's order passes by and never takes.
pub fn classify(p: &Problem, m: &Member, ins: Option<&Insertable>, g: &GuardData) -> Vec<Passed> {
	let run = &p.model.run;
	let c = &m.ctxs[0].cur;
	let never = passed_never(g, run, &c.steps, &c.lv, &c.wk);
	let mut ev = p.ctxs[0].model.evaluator(p.walks);
	let base = tally(&mut ev, &m.order.steps);
	let loc = locs(run, &m.order.steps);
	let live = m.live.min(m.order.len());
	let mut check = crate::order::Checker::new(run);
	let mut out = Vec::new();
	for (q, t) in never {
		let qi = q as usize;
		let lvl = c.lv[t];
		let local = local_rate(c, lvl);
		let mut v = Passed { q, id: run.q_id[qi], at: t, lvl, worthwhile: false, reason: String::new(), xp: 0.0, cost_sec: 0.0, detour_sec: 0.0, rate: 0.0, local };
		let skip = |v: &mut Passed, r: String| v.reason = r;
		if let Some(i) = ins.filter(|i| !i.ok(q)) {
			skip(&mut v, category(&i.why(q)));
		} else if run.q_level[qi] as f64 <= gray_level(lvl + 1.0) {
			skip(&mut v, "grey by its turn-in".into());
		} else if !Member::level_ok(p, qi, lvl) {
			skip(&mut v, if (run.q_level[qi] as f64) > lvl { "too high there".into() } else { "too low there".into() });
		} else if let Some(mv) = insertion(p, m, q, &loc, live, 0) {
			let (cand, _, _) = mv.apply(&m.order).expect("insertion applies");
			if !check.valid(&cand.steps, &p.pairs, &p.feas) {
				skip(&mut v, "breaks a deliberate order or feasibility rule".into());
			} else {
				let x = tally(&mut ev, &cand.steps);
				if x.noops > base.noops {
					skip(&mut v, "chain not open there (prerequisite)".into());
				} else {
					v.xp = x.xp - base.xp;
					v.cost_sec = x.busy - base.busy;
					let work: f64 = x.work.iter().filter(|(tk, _)| (run.q_task0[qi]..run.q_task1[qi]).contains(tk)).map(|w| w.1).sum();
					v.detour_sec = (v.cost_sec - work - 2.0 * p.model.tables.p.talk_sec).max(0.0);
					v.rate = if v.cost_sec <= 1.0 { f64::INFINITY } else { v.xp / (v.cost_sec / 60.0) };
					v.worthwhile = v.xp > 0.0 && (v.rate >= local || (v.detour_sec < DETOUR_CHEAP_SEC && v.rate >= 0.5 * local));
					if !v.worthwhile {
						let pts: Vec<u32> = (run.q_task0[qi]..run.q_task1[qi]).map(|t| run.task_pt[t as usize]).chain([run.q_ender[qi]]).collect();
						let off = pts.iter().any(|&pt| loc.iter().all(|&l| d(run, l, pt) > OFF_ROUTE_YD));
						skip(&mut v, if off { "work or turn-in leads off the route".into() } else { "low XP for its detour".into() });
					}
				}
			}
		} else {
			let giver = run.q_giver[qi];
			let takeable = (1..live).any(|j| seg_dist(run, loc[j - 1], loc[j], giver) <= super::PASSED_BY_YD && Member::level_ok(p, qi, m.lv[j]));
			skip(&mut v, if takeable { "its work or turn-in is in a zone the route does not reach soon after".into() } else { "passed only where the level window is closed".into() });
		}
		out.push(v);
	}
	out
}

/// One pickup the pass kept.
pub struct Pickup {
	pub mv: Mv,
	pub before: Order,
	pub lv: Vec<f64>,
	pub v: Passed,
	/// Seconds the insert added to the hours to 60 (negative: it saved time).
	pub added: f64,
	pub hours: f64,
}

/// Insert worthwhile passed-by quests where they are passed, best rate first: each kept when
/// the order keeps its rules, no guard worsens, and the hours to 60 rise by at most
/// PICKUP_ALLOW_SEC. Rounds until none is kept.
/// Also returns, per quest id refused, why (the minutes and the guard counts at its cheapest
/// place that keeps the rules).
pub fn pickup(p: &Problem, m: &mut Member, ins: Option<&Insertable>, g: &GuardData, log: &mut dyn FnMut(&str)) -> (Vec<Pickup>, rustc_hash::FxHashMap<u32, String>) {
	let run = &p.model.run;
	let mut kept = Vec::new();
	let mut refused: rustc_hash::FxHashMap<u32, String> = Default::default();
	let mut tried: rustc_hash::FxHashSet<u32> = Default::default();
	for _round in 0..4 {
		let mut ws: Vec<Passed> = classify(p, m, ins, g).into_iter().filter(|v| v.worthwhile && !tried.contains(&v.q)).collect();
		if ws.is_empty() {
			break;
		}
		ws.sort_by(|a, b| (b.rate / b.local).total_cmp(&(a.rate / a.local)).then(a.q.cmp(&b.q)));
		let mut any = false;
		for v in ws {
			tried.insert(v.q);
			let loc = locs(run, &m.order.steps);
			let live = m.live.min(m.order.len());
			let now = m.total();
			// The cheapest few places to take it (by the straight detour), the first that keeps
			// the rules and the guards.
			let mut got = None;
			for nth in 0..PICKUP_PLACES {
				let Some(mv) = insertion(p, m, v.q, &loc, live, nth) else { continue };
				let Some((cand, a, b)) = mv.apply(&m.order) else { continue };
				if a >= m.live || !m.check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(&cand) > twin_trainings(&m.order) {
					continue;
				}
				m.allow = PICKUP_ALLOW_SEC;
				let r = m.replay(p, &cand, a, b);
				m.allow = 0.0;
				if let Some(r) = r {
					got = Some((mv, cand, r));
					break;
				}
			}
			let Some((mv, cand, (next, gc))) = got else {
				let why = refusal(p, m, v.q, &loc, live, now);
				log(&format!("pickup {}: refused: {why}", run.q_id[v.q as usize]));
				refused.insert(run.q_id[v.q as usize], why);
				continue;
			};
			let before = m.order.clone();
			let lv = m.lv.clone();
			m.guard_now = gc;
			for (c, cur) in m.ctxs.iter_mut().zip(next) {
				c.cur = cur;
			}
			m.order = cand;
			m.refresh();
			let added = m.total() - now;
			log(&format!("pickup {}: {:+.1} min", run.q_id[v.q as usize], added / 60.0));
			refused.remove(&run.q_id[v.q as usize]);
			kept.push(Pickup { mv, before, lv, v, added, hours: m.total() / 3600.0 });
			any = true;
		}
		if !any {
			break;
		}
	}
	(kept, refused)
}

/// Why a pickup was refused: at its cheapest place that keeps the rules, the minutes it adds
/// and the guard counts it would raise; or that no place keeps the rules.
fn refusal(p: &Problem, m: &mut Member, q: u32, loc: &[u32], live: usize, now: f64) -> String {
	let run = &p.model.run;
	for nth in 0..PICKUP_PLACES {
		let Some(mv) = insertion(p, m, q, loc, live, nth) else { continue };
		let Some((cand, a, _)) = mv.apply(&m.order) else { continue };
		if a >= m.live || !m.check.valid(&cand.steps, &p.pairs, &p.feas) {
			continue;
		}
		let rs = super::runs(p, &cand);
		let dt = (rs.iter().map(|c| c.total).sum::<f64>() - now) / 60.0;
		let mut raised = Vec::new();
		if let Some(gd) = &p.guard {
			let (b, c) = (&m.guard_now, gd.counts(run, &rs[0]));
			for (name, x, y) in [
				("avoidable returns", b.avoidable_returns, c.avoidable_returns),
				("passed-by", b.passed_by, c.passed_by),
				("training gaps", b.training_gaps, c.training_gaps),
				("grind before a hand-in", b.grind_before_handin, c.grind_before_handin),
				("training bounces", b.train_bounces, c.train_bounces),
				("elite/rare camps", b.elite_rare, c.elite_rare),
			] {
				if y > x {
					raised.push(format!("{name} {x}->{y}"));
				}
			}
		}
		let cur = &m.ctxs[0].cur;
		if rs[0].noops > cur.noops {
			raised.push("a step that does nothing".into());
		}
		if rs[0].late > cur.late {
			raised.push("a late timed turn-in".into());
		}
		if rs[0].log_peak > p.log_bound && rs[0].log_peak > cur.log_peak {
			raised.push(format!("quest log {}", rs[0].log_peak));
		}
		if rs[0].plan_cool > cur.plan_cool {
			raised.push("a v1 hearth line on cooldown".into());
		}
		if dt * 60.0 > PICKUP_ALLOW_SEC {
			raised.push(format!("{dt:+.1} min, over the 2-minute allowance"));
		}
		return if raised.is_empty() { format!("{dt:+.1} min (another check)") } else { raised.join(", ") };
	}
	"no place on the route keeps the quest order and deliberate orders".into()
}

/// A long single-quest trip: steps of one quest only between other stops, costing more than
/// LONG_TRIP_SEC round trip at under half the route's rate.
#[derive(Clone, Debug, serde::Serialize)]
pub struct Trip {
	pub id: u32,
	pub at: usize,
	pub lvl: f64,
	pub sec: f64,
	pub xp: f64,
	pub rate: f64,
	pub local: f64,
}

/// The order's long single-quest trips.
pub fn long_trips(p: &Problem, order: &Order, c: &Current) -> Vec<Trip> {
	let run = &p.model.run;
	let steps = &order.steps;
	let is_q = |k: usize| matches!(steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN);
	// Segments: maximal runs of one quest's steps (grinds skipped), with the stops around them.
	let mut segs: Vec<(usize, usize, usize, usize)> = Vec::new();
	let mut i = 0;
	while i < steps.len() {
		if !is_q(i) {
			i += 1;
			continue;
		}
		let q = steps[i].q;
		let mut e = i;
		while e + 1 < steps.len() && (steps[e + 1].kind == K_GRIND || (is_q(e + 1) && steps[e + 1].q == q)) {
			e += 1;
		}
		while steps[e].kind == K_GRIND {
			e -= 1;
		}
		let prev = (0..i).rev().find(|&k| steps[k].kind != K_GRIND);
		let next = (e + 1..steps.len()).find(|&k| steps[k].kind != K_GRIND);
		if let (Some(a), Some(b)) = (prev, next) {
			if is_q(a) || steps[a].kind == K_TRAIN {
				segs.push((a, i, e, b));
			}
		}
		i = e + 1;
	}
	let mut ev = p.ctxs[0].model.evaluator(p.walks);
	ev.reset();
	let mut out = Vec::new();
	let mut s = 0;
	let mut t0 = 0.0;
	let mut x0 = 0.0;
	for k in 0..steps.len() {
		if ev.s.finished {
			break;
		}
		if s < segs.len() && segs[s].1 == k {
			t0 = ev.s.time;
			x0 = ev.total_xp();
		}
		ev.step_in(steps, k);
		while s < segs.len() && segs[s].2 == k {
			let (a, st, _, b) = segs[s];
			let q = steps[st].q as usize;
			let back = ev.leg_now(steps[k].pt, steps[b].pt);
			let direct = ev.leg_now(steps[a].pt, steps[b].pt);
			let sec = ev.s.time - t0 + back - direct;
			let lvl = ev.level_now();
			let dl = (ev.s.level as i64 - run.q_level[q] as i64).clamp(0, 63) as usize;
			// XP of the trip: what it earned (kills, its turn-in) plus the quest's reward when the
			// turn-in comes later (the trip serves it).
			let has_turnin = steps[st..=k].iter().any(|x| x.kind == K_TURNIN);
			let xp = ev.total_xp() - x0 + if has_turnin { 0.0 } else { p.model.tables.q_full[q] * SHARE[dl] };
			let local = local_rate(c, lvl);
			let rate = if sec > 0.0 { xp / (sec / 60.0) } else { f64::INFINITY };
			if sec > LONG_TRIP_SEC && rate < 0.5 * local {
				out.push(Trip { id: run.q_id[q], at: st, lvl, sec, xp, rate, local });
			}
			s += 1;
		}
	}
	out
}

/// Hearths of an order (#576: casts at least 60 min of play apart): the model's casts, the
/// shortest gap between two, and v1's planned hearth lines met while the stone was cooling down.
#[derive(Clone, Debug, Default, serde::Serialize)]
pub struct Hearths {
	pub casts: u32,
	pub min_gap_min: f64,
	pub planned_lines: u32,
	pub planned_on_cooldown: u32,
}

pub fn hearths(p: &Problem, order: &Order) -> Hearths {
	let run = &p.model.run;
	let mut ev = p.ctxs[0].model.evaluator(p.walks);
	ev.reset();
	let mut h = Hearths { min_gap_min: f64::INFINITY, ..Default::default() };
	let mut last: Option<f64> = None;
	for k in 0..order.len() {
		if ev.s.finished {
			break;
		}
		let s = order.steps[k];
		let planned = run.plan.as_ref().is_some_and(|pl| run.step_key(s.kind, s.q, s.task).is_some_and(|key| pl.hearth.contains(&key)));
		if planned {
			h.planned_lines += 1;
			if ev.s.time < ev.s.hearth_ready {
				h.planned_on_cooldown += 1;
			}
		}
		let before = ev.s.hearths;
		let t0 = ev.s.time;
		ev.step_in(&order.steps, k);
		if ev.s.hearths > before {
			h.casts += 1;
			if let Some(l) = last {
				h.min_gap_min = h.min_gap_min.min((t0 - l) / 60.0);
			}
			last = Some(t0);
		}
	}
	if !h.min_gap_min.is_finite() {
		h.min_gap_min = 0.0;
	}
	h
}
