//! Quests the route walks past: each one the order passes by and never takes (the guards'
//! passed-by, the judge's rule) is WORTHWHILE or RIGHTLY SKIPPED; the pickup pass inserts the
//! worthwhile ones where they are passed; and the long single-quest trips metric.
//!
//! Worthwhile: an insertable solo quest in the level window, not grey by its turn-in, whose XP
//! per minute of added time (its detour plus its work, grind excluded) is at least the route's
//! own XP per minute at that level, or half of it when the detour is under DETOUR_CHEAP_SEC.
//! The cost is measured, not estimated: the order with the quest inserted (edits::insertion) is
//! replayed and the time outside grinding compared.

use super::edits::{chain_insertion, chain_quests, insertion, joins_at, seg_dist, twin_trainings, Mv};
use super::{cheapest_k, d, locs, Current, Member, Problem};
use crate::eval::{Evaluator, Step};
use crate::guards::{hub_counts, passed_never, GuardData};
use crate::hubs::{loop_order, Fix, HubCounts, HubData};
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
	/// Worthwhile as a chain: the quests it opens taken with it (ids, the quest first; empty when
	/// it is worthwhile alone or not at all).
	pub chain: Vec<u32>,
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

/// Insertion places tried, best first, until one where the quest's chain is open.
const PLACES_TRIED: usize = 4;

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
	// Only the rules the order holds (A Free Lunch, Raven Hill, Philmor's Favor in Human's cut were
	// `player-report` skips: every insertion broke the keep of a quest the cleaned order had lost;
	// c14 Tauren, Undead, Skyborne and Night Elf refused every quest they pass by on a need or a
	// pair their own order already breaks).
	let feas = p.feas.held_by(&m.order.steps);
	let p_feas = &feas;
	let pairs = crate::order::held_pairs(&m.order.steps, &p.pairs);
	let p_pairs = &pairs;
	let mut out = Vec::new();
	for (q, t) in never {
		let qi = q as usize;
		let lvl = c.lv[t];
		let local = local_rate(c, lvl);
		let mut v = Passed { q, id: run.q_id[qi], at: t, lvl, worthwhile: false, reason: String::new(), xp: 0.0, cost_sec: 0.0, detour_sec: 0.0, rate: 0.0, local, chain: Vec::new() };
		let skip = |v: &mut Passed, r: String| v.reason = r;
		if let Some(i) = ins.filter(|i| !i.ok(q)) {
			skip(&mut v, category(&i.why(q)));
		} else if run.q_level[qi] as f64 <= gray_level(lvl + 1.0) {
			skip(&mut v, "grey by its turn-in".into());
		} else if !Member::level_ok(p, qi, lvl) {
			skip(&mut v, if (run.q_level[qi] as f64) > lvl { "too high there".into() } else { "too low there".into() });
		} else if let Some(mut mv) = insertion(p, m, q, &loc, live, 0) {
			// (The best place may come before its prerequisite's hand-in at the same stop: Return to the
			// Bulwark from the Dalson's cauldron 5231 is handed in at, B3; or break a rule there: inside
			// another quest's escort. The next places too.)
			for nth in 1..PLACES_TRIED {
				let (cand, _, _) = mv.apply(&m.order).expect("insertion applies");
				if check.valid(&cand.steps, p_pairs, p_feas) && tally(&mut ev, &cand.steps).noops <= base.noops {
					break;
				}
				match insertion(p, m, q, &loc, live, nth) {
					Some(next) => mv = next,
					None => break,
				}
			}
			let (cand, _, _) = mv.apply(&m.order).expect("insertion applies");
			if let Some(why) = check.broken(&cand.steps, p_pairs, p_feas) {
				// The rule by name: a deliberate record is a player report, a feasibility rule is not.
				skip(&mut v, format!("breaks a rule where it is passed: {why}"));
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
						// Value a chain, not a quest (planner rule 1): the quest with the quests it
						// opens, their XP over their added time.
						if let Some(cm) = chain_insertion(p, &m.order, &m.lv, live, q) {
							let (cc, _, _) = cm.apply(&m.order).expect("chain applies");
							let y = tally(&mut ev, &cc.steps);
							let (xp, cost) = (y.xp - base.xp, y.busy - base.busy);
							let rate = if cost <= 1.0 { f64::INFINITY } else { xp / (cost / 60.0) };
							if y.noops <= base.noops && check.valid(&cc.steps, p_pairs, p_feas) && xp > 0.0 && rate >= local {
								(v.xp, v.cost_sec, v.rate, v.worthwhile) = (xp, cost, rate, true);
								v.chain = chain_quests(&cm).into_iter().map(|x| run.q_id[x as usize]).collect();
							}
						}
					}
					if !v.worthwhile {
						let pts: Vec<u32> = (run.q_task0[qi]..run.q_task1[qi]).map(|t| run.task_pt[t as usize]).chain([run.q_ender[qi]]).collect();
						let off = pts.iter().any(|&pt| loc.iter().all(|&l| d(run, l, pt) > OFF_ROUTE_YD));
						skip(&mut v, if off { "work or turn-in leads off the route".into() } else { "low XP for its detour, alone and with the quests it opens".into() });
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
			// the rules and the guards; a quest worthwhile as a chain with the quests it opens.
			let mvs: Vec<Mv> = if v.chain.is_empty() {
				(0..PICKUP_PLACES).filter_map(|nth| insertion(p, m, v.q, &loc, live, nth)).collect()
			} else {
				chain_insertion(p, &m.order, &m.lv, live, v.q).into_iter().collect()
			};
			let mut got = None;
			for mv in mvs {
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

/// Seconds the hub pickup pass lets one quest taken on an earlier visit add to the hours to 60
/// (Fitz: taking what the player stands next to and doing it with the work there is worth a
/// little model time: Baron Longshore at the first Ratchet visit, +47 s).
pub const HUB_PICKUP_ALLOW_SEC: f64 = 180.0;

/// Yards from a quest's giver a stop is an earlier visit for the hub pickup pass: the player
/// stands next to the giver there (order::SAME_STOP_YD). The search's joins count a hub stop
/// (edits::JOIN_YD); a pickup the replay finds cheap from 100 yd off is a stop of its own (c14
/// Human: Rest and Relaxation taken at 1.3 from the Abbey, Falkhaan 140 yd off by the stables).
pub const HUB_PICKUP_YD: f64 = crate::order::SAME_STOP_YD;

/// One quest the hub pickup pass took on an earlier visit to its giver.
pub struct HubPickup {
	pub mv: Mv,
	pub before: Order,
	pub lv: Vec<f64>,
	/// Seconds it added to the hours to 60 (negative: it saved time).
	pub added: f64,
	pub hours: f64,
}

/// Pick up what the route stands next to (a player review: "Ratchet gives 2 quests while 5 others
/// are available you could do while doing those 2"): each quest the order takes on a later visit
/// to its giver (a stop within HUB_PICKUP_YD of it) although it was open on an earlier one is
/// taken on the earlier visit (edits::joins:
/// its work beside work on its ground, its turn-in on the next visit to its ender), kept when the
/// order keeps its rules, no guard worsens and the hours to 60 rise by at most
/// HUB_PICKUP_ALLOW_SEC. Rounds until none is kept.
pub fn hub_pickup(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<u32> = Default::default();
	// One quest at a time, its candidates against the order as it is now (the latest earlier visit
	// first), the first kept.
	loop {
		let cands: Vec<Mv> = joins_at(p, m, HUB_PICKUP_YD).into_iter().filter(|mv| matches!(mv, Mv::Join { q, .. } if !tried.contains(q))).collect();
		let Some(Mv::Join { q, .. }) = cands.first() else { break };
		let q = *q;
		tried.insert(q);
		let now = m.total();
		let mut got = None;
		for mv in cands.into_iter().filter(|mv| matches!(mv, Mv::Join { q: x, .. } if *x == q)) {
			let Some((cand, a, b)) = mv.apply(&m.order) else { continue };
			if a >= m.live || !m.check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(&cand) > twin_trainings(&m.order) {
				continue;
			}
			m.allow = HUB_PICKUP_ALLOW_SEC;
			let r = m.replay(p, &cand, a, b);
			m.allow = 0.0;
			if let Some(r) = r {
				got = Some((mv, cand, r));
				break;
			}
		}
		let Some((mv, cand, (next, gc))) = got else { continue };
		let before = m.order.clone();
		let lv = m.lv.clone();
		m.guard_now = gc;
		for (c, cur) in m.ctxs.iter_mut().zip(next) {
			c.cur = cur;
		}
		m.order = cand;
		m.refresh();
		let added = m.total() - now;
		log(&format!("hub pickup {}: {:+.1} min", run.q_id[q as usize], added / 60.0));
		kept.push(HubPickup { mv, before, lv, added, hours: m.total() / 3600.0 });
	}
	kept
}

/// Seconds a quest done from the bags may add when taken, done and handed in at once (bag_ties):
/// a tie, the model's XP moved a few minutes (c13 Orc: +0 to +20 s per cloth donation).
pub const BAG_TIE_SEC: f64 = 30.0;

/// A quest done from the bags (edits::bag_join: the cloth donations, the cloth carried, their ender
/// at their giver) accepted, done and handed in at once, where the search and the hub pickup pass left
/// it for a later trip (FlowDiag fix 5, c13: Runecloth 7826 accepted at 1788, handed in at 1803, the
/// written guide walking past the ready hand-in; the pickup refused it for the avoidable return its
/// guard counts at the later visit, there for other quests anyway): kept when the order keeps its
/// rules, no guard rises beyond its bound and the hours to 60 rise by at most BAG_TIE_SEC. A tie: an
/// avoidable return it adds in an area need not be paid for by a gain.
pub fn bag_ties(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<u32> = Default::default();
	loop {
		let live = m.live.min(m.order.len());
		let Some(mv) = (0..live).filter(|&i| !tried.contains(&m.order.steps[i].q)).find_map(|i| super::edits::bag_join(p, m, i)) else { break };
		let Mv::Join { q, .. } = mv else { break };
		tried.insert(q);
		let Some((cand, a, b)) = mv.apply(&m.order) else { continue };
		if a >= m.live || !m.check.valid(&cand.steps, &p.pairs, &p.feas) {
			continue;
		}
		let now = m.total();
		(m.allow, m.tie) = (BAG_TIE_SEC, true);
		let r = m.replay(p, &cand, a, b);
		(m.allow, m.tie) = (0.0, false);
		let Some((next, gc)) = r else { continue };
		let (before, lv) = (m.order.clone(), m.lv.clone());
		m.guard_now = gc;
		for (c, cur) in m.ctxs.iter_mut().zip(next) {
			c.cur = cur;
		}
		m.order = cand;
		m.refresh();
		let added = m.total() - now;
		log(&format!("bag tie {}: {:+.1} min", run.q_id[q as usize], added / 60.0));
		kept.push(HubPickup { mv, before, lv, added, hours: m.total() / 3600.0 });
	}
	kept
}

/// Yards: two objectives whose spawn spots come this close are one camp (the check's `merge`
/// OVERLAP_YD).
pub const CAMP_YD: f64 = 150.0;
/// Yards: a stop this far from both camps' spots ends the visit (the check's TRIP_YD).
pub const CAMP_LEAVE_YD: f64 = 300.0;
/// Most moves the camp gather pass keeps (a bound on its rounds).
pub const CAMP_GATHER_MAX: usize = 400;
/// Most steps between a camp's two halves.
pub const CAMP_GAP_STEPS: usize = 40;
/// Yards: a field trip's camp this close to a later trip's camp is the same ground (the camp
/// revisit pass; c14 Orc: Feralas' Rogue Vale screechers 250 yd from Zorbin's fuel).
pub const REVISIT_CAMP_YD: f64 = CAMP_LEAVE_YD;
/// Most steps between a field trip and the later trip to its ground.
pub const REVISIT_GAP_STEPS: usize = 120;

/// A task's spawn area: its objectives' compiled spawn spots (Run::task_spots), else its site.
fn task_area(run: &crate::run::Run, t: usize) -> Vec<(i64, f64, f64)> {
	match run.task_spots.get(t).filter(|v| !v.is_empty()) {
		Some(v) => v.clone(),
		None => {
			let p = run.task_pt[t] as usize;
			vec![(run.p_c[p], run.p_x[p], run.p_y[p])]
		}
	}
}

/// Yards between two spawn areas (closest spots on one continent).
fn area_dist(a: &[(i64, f64, f64)], b: &[(i64, f64, f64)]) -> f64 {
	let mut best = f64::INFINITY;
	for x in a {
		for y in b {
			if x.0 == y.0 {
				best = best.min((x.1 - y.1).hypot(x.2 - y.2));
			}
		}
	}
	best
}

/// A camp worked in two halves in one visit (c10: 63 places, an NPC step or a nearby sub-area in
/// the middle: Guard Parker, Kalaran Windblade, Smeed...), by the check's `merge` rule: two
/// objective steps whose spawn spots come within CAMP_YD, the later one's quest in the log at the
/// earlier, no stop between them CAMP_LEAVE_YD from both areas. Candidates: the later objective
/// right after the earlier, or the earlier right before the later (the in-between steps then come
/// after, or before, the joined work; the order's rules keep an accept before the work it opens and
/// a hand-in after the work it needs).
pub fn camp_gathers(p: &Problem, m: &Member) -> Vec<Mv> {
	split_camps(&p.model.run, &m.order, m.live)
}

/// camp_gathers over an order (`live`: the steps a move may touch).
fn split_camps(run: &crate::run::Run, o: &Order, live: usize) -> Vec<Mv> {
	let live = live.min(o.len());
	let accepted_before = |q: u32, i: usize| o.steps[..i].iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	let at = |k: usize| {
		let pt = o.steps[k].pt as usize;
		[(run.p_c[pt], run.p_x[pt], run.p_y[pt])]
	};
	let mut out = Vec::new();
	for i in 0..live {
		if o.steps[i].kind != K_TASK {
			continue;
		}
		let a = task_area(run, o.steps[i].task as usize);
		for j in i + 2..live.min(i + CAMP_GAP_STEPS + 2) {
			let s = o.steps[j];
			if s.kind != K_TASK || s.q == o.steps[i].q || !accepted_before(s.q, i) {
				continue;
			}
			let b = task_area(run, s.task as usize);
			if area_dist(&a, &b) > CAMP_YD {
				continue;
			}
			// Left between them: a stop far from both areas.
			if (i + 1..j).any(|k| o.steps[k].kind != K_GRIND && area_dist(&at(k), &a) > CAMP_LEAVE_YD && area_dist(&at(k), &b) > CAMP_LEAVE_YD) {
				continue;
			}
			// Only when something else stands between them.
			if (i + 1..j).any(|k| o.steps[k].kind != K_GRIND && !(o.steps[k].kind == K_TASK && area_dist(&task_area(run, o.steps[k].task as usize), &a) <= CAMP_YD)) {
				out.push(Mv::Move { s: j, e: j, to: i + 1, kind: "gather" });
				out.push(Mv::Move { s: i, e: i, to: j - 1, kind: "gather" });
			}
			break;
		}
	}
	out
}

/// The first of the indices `ks`, in their order, for which `f(member, k)` gives Some: tried a
/// chunk at a time on the threads, on twins of `m` (Member::twin, built on first use; the caller
/// keeps them in step with `m`). `f` reads the member's state only (a replay), so the first is the
/// one a loop over `ks` on `m` itself finds.
fn first_some<'a, T: Send>(p: &Problem<'a>, m: &Member<'a>, twins: &mut Vec<Member<'a>>, ks: &[usize], f: impl Fn(&mut Member<'a>, usize) -> Option<T> + Sync + Send) -> Option<(usize, T)> {
	if ks.is_empty() {
		return None;
	}
	if twins.is_empty() {
		*twins = (0..crate::threads().max(1)).map(|_| m.twin(p)).collect();
	}
	for chunk in ks.chunks(twins.len()) {
		let got = crate::par_each_mut(twins, chunk.len(), |t, i| f(t, chunk[i]));
		if let Some(x) = got.into_iter().zip(chunk).find_map(|(r, &k)| r.map(|v| (k, v))) {
			return Some(x);
		}
	}
	None
}

/// The camp gather pass: each camp worked in two halves (camp_gathers) joined, the first candidate
/// that keeps the order's rules, worsens no guard and adds at most HUB_PICKUP_ALLOW_SEC (what the
/// player sees beats model minutes). Rounds until none is kept.
pub fn camp_gather<'a>(p: &Problem<'a>, m: &mut Member<'a>, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	// Each candidate's checks before its replay (they read the order only), on the threads: the
	// candidate order and where it changes, or None.
	let screen = |m: &Member, cands: &[Mv]| -> Vec<Option<(Order, usize, usize)>> {
		let twins = twin_trainings(&m.order);
		crate::par_map_with(
			cands.len(),
			|| crate::order::Checker::new(run),
			|check, k| {
				let (cand, a, b) = cands[k].apply(&m.order)?;
				if a >= m.live || !check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(&cand) > twins {
					return None;
				}
				// Fewer split camps, or nothing (c11: a join that split the next camp, then back, 400
				// times over: the steps between drifted and quests fell out of their chains).
				(split_camps(run, &cand, m.live).len() < cands.len()).then_some((cand, a, b))
			},
		)
	};
	let mut kept = Vec::new();
	let mut twins = Vec::new();
	for _round in 0..8 {
		let mut any = false;
		loop {
			// (The candidates depend on the order only: built again after a kept move.)
			let cands = camp_gathers(p, m);
			let mut ok = screen(m, &cands);
			let ks: Vec<usize> = (0..ok.len()).filter(|&k| ok[k].is_some()).collect();
			let Some((k, (next, gc))) = first_some(p, m, &mut twins, &ks, |t, k| {
				let (cand, a, b) = ok[k].as_ref()?;
				t.allow = HUB_PICKUP_ALLOW_SEC;
				let r = t.replay(p, cand, *a, *b);
				t.allow = 0.0;
				r
			}) else {
				break;
			};
			let (cand, a, _) = ok[k].take().expect("a screened candidate");
			let mv = cands[k].clone();
			let now = m.total();
			let before = m.order.clone();
			let lv = m.lv.clone();
			m.guard_now = gc;
			for (c, cur) in m.ctxs.iter_mut().zip(next) {
				c.cur = cur;
			}
			m.order = cand;
			m.refresh();
			for t in &mut twins {
				t.take(m);
			}
			let added = m.total() - now;
			log(&format!("camp gather at step {a}: {:+.1} min", added / 60.0));
			kept.push(HubPickup { mv, before, lv, added, hours: m.total() / 3600.0 });
			any = true;
			if kept.len() >= CAMP_GATHER_MAX {
				return kept;
			}
		}
		if !any {
			break;
		}
	}
	kept
}

/// A field trip to ground the order comes back to later (c14 Orc: Feralas II rides west for the
/// Rogue Vale screechers and OOX-22, hearths out, then crosses the zone again to Zorbin's giants
/// beside them; Stranglethorn II flies to Mistvale for Mok'thardin's sinew, and comes back for
/// Unbagwa and Shaky's giblets on the same gorillas, walking Booty Bay's quests in between): the
/// steps moved to right before the later visit's task on the same ground (camps within
/// REVISIT_CAMP_YD, at most REVISIT_GAP_STEPS on). Two kinds of candidate: a trip (the steps walked
/// into from the one arrived at by flight, boat or hearth, to the last walked one) before a later
/// trip there; and a visit (the steps around a task within CAMP_YD of its camp) before a later
/// visit to that camp (a task within CAMP_YD) the walk left it for (a stop CAMP_YD from both: Booty Bay is within CAMP_LEAVE_YD
/// of Mistvale's gorillas). One of each per trip or visit, its first such later task.
pub fn camp_revisits(p: &Problem, m: &Member) -> Vec<Mv> {
	let run = &p.model.run;
	let o = &m.order;
	let c = &m.ctxs[0];
	let live = m.live.min(o.len());
	let mut prev = run.start_pt;
	// Whether the leg into step k stays in the field: walked, or no move.
	let field: Vec<bool> = (0..o.len())
		.map(|k| {
			let s = o.steps[k];
			if s.kind == K_GRIND {
				return true;
			}
			let stays = s.pt == prev || c.cur.wk.get(c.off + k).is_some_and(|w| w.walked);
			prev = s.pt;
			stays
		})
		.collect();
	let mut out = Vec::new();
	let mut k = 0;
	while k < live {
		// One trip: bs (arrived at not by walking) ..= be (the last walked into).
		let bs = k;
		let mut be = k;
		while be + 1 < live && field[be + 1] {
			be += 1;
		}
		k = be + 1;
		if be + 1 >= live || !(bs..=be).all(|x| matches!(o.steps[x].kind, K_ACCEPT | K_TASK | K_TURNIN | K_GRIND)) {
			continue;
		}
		let areas: Vec<Vec<(i64, f64, f64)>> = (bs..=be).filter(|&x| o.steps[x].kind == K_TASK).map(|x| task_area(run, o.steps[x].task as usize)).collect();
		if areas.is_empty() {
			continue;
		}
		let mine = |q: u32| (bs..=be).any(|x| o.steps[x].q == q && o.steps[x].kind != K_GRIND);
		let later = (be + 1..live.min(be + 1 + REVISIT_GAP_STEPS)).find(|&j| {
			let s = o.steps[j];
			s.kind == K_TASK && !mine(s.q) && {
				let b = task_area(run, s.task as usize);
				areas.iter().any(|a| area_dist(a, &b) <= REVISIT_CAMP_YD)
			}
		});
		// (A later trip: a leg not walked between.)
		if let Some(j) = later.filter(|&j| j > be + 1 && (be + 1..=j).any(|x| !field[x])) {
			out.extend(revisit_moves(run, o, bs, be, j, live));
		}
	}
	// Trips across water and back (c15 Night Elf: Darkshore -> the boat to Stormwind to train and
	// hand in A Fishy Peril at 13.66 -> hearth to Auberdine -> the boat to Westfall at 14.37): a
	// stretch on one walk region between two on another, done on the next trip to its region (at
	// most REVISIT_GAP_STEPS on).
	let blocks = region_blocks(run, o, live);
	for w in blocks.windows(3) {
		let ((_, _, ra), (bs, be, rb), (_, _, rc)) = (w[0], w[1], w[2]);
		if ra != rc || ra == rb || !(bs..=be).all(|x| matches!(o.steps[x].kind, K_ACCEPT | K_TASK | K_TURNIN | K_TRAIN | K_GRIND)) {
			continue;
		}
		if let Some(&(js, _, _)) = blocks.iter().find(|b| b.0 > be + 1 && b.2 == rb && b.0 <= be + REVISIT_GAP_STEPS) {
			out.extend(revisit_moves(run, o, bs, be, js, live));
		}
	}
	// Visits: a camp left (a stop CAMP_YD from both) and come back to.
	let at = |k: usize| {
		let pt = o.steps[k].pt as usize;
		[(run.p_c[pt], run.p_x[pt], run.p_y[pt])]
	};
	let mut i = 0;
	while i < live {
		if o.steps[i].kind != K_TASK {
			i += 1;
			continue;
		}
		let a = task_area(run, o.steps[i].task as usize);
		let near = |k: usize| o.steps[k].kind == K_GRIND || area_dist(&at(k), &a) <= CAMP_YD;
		let (mut vs, mut ve) = (i, i);
		while vs > 0 && near(vs - 1) && o.steps[vs - 1].kind != K_GRIND {
			vs -= 1;
		}
		while ve + 1 < live && near(ve + 1) && o.steps[ve + 1].kind != K_GRIND {
			ve += 1;
		}
		// (Every task's own visit: an earlier task's visit may hold it, its own later ground another.)
		i += 1;
		let mine = |q: u32| (vs..=ve).any(|x| o.steps[x].q == q);
		let later = (ve + 1..live.min(ve + 1 + REVISIT_GAP_STEPS)).find(|&j| {
			let s = o.steps[j];
			s.kind == K_TASK && !mine(s.q) && area_dist(&a, &task_area(run, s.task as usize)) <= CAMP_YD
		});
		if let Some(j) = later {
			let b = task_area(run, o.steps[j].task as usize);
			let left = (ve + 1..j).any(|k| o.steps[k].kind != K_GRIND && area_dist(&at(k), &a) > CAMP_YD && area_dist(&at(k), &b) > CAMP_YD);
			if left {
				for mv in revisit_moves(run, o, vs, ve, j, live) {
					if !out.contains(&mv) {
						out.push(mv);
					}
				}
			}
		}
	}
	out
}

/// Steps s..=e done on the later visit to their ground that begins at step j: right before j, or
/// right after the visit (the steps from j on its ground, CAMP_YD of j's camp). With them go the
/// steps between of their quests (a hand-in after the moved work: c14's Mok'thardin hand-in at
/// Grom'gol right after the sinew) and of the quests those hand-ins open, in turn: after the
/// visit, each in its order (before it, they would leave the ground between). A Move, or a Seq
/// of one-step moves.
fn revisit_moves(run: &crate::run::Run, o: &Order, s: usize, e: usize, j: usize, live: usize) -> Vec<Mv> {
	let quest = |k: usize| matches!(o.steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN);
	let mut qs: Vec<u32> = (s..=e).filter(|&k| quest(k)).map(|k| o.steps[k].q).collect();
	let mut deps: Vec<usize> = Vec::new();
	let mut changed = true;
	while changed {
		changed = false;
		for k in e + 1..j {
			if !quest(k) || deps.contains(&k) {
				continue;
			}
			let x = o.steps[k];
			let opened = x.kind == K_ACCEPT && qs.iter().any(|&q| (s..=e).chain(deps.iter().copied()).any(|i| o.steps[i].kind == K_TURNIN && o.steps[i].q == q) && crate::order::follows(run, x.q, q));
			if qs.contains(&x.q) || opened {
				deps.push(k);
				if !qs.contains(&x.q) {
					qs.push(x.q);
				}
				changed = true;
			}
		}
	}
	deps.sort_unstable();
	// The later visit: j and the steps after it on its ground (j's camp, else its stop).
	let b = if o.steps[j].kind == K_TASK {
		task_area(run, o.steps[j].task as usize)
	} else {
		let pt = o.steps[j].pt as usize;
		vec![(run.p_c[pt], run.p_x[pt], run.p_y[pt])]
	};
	let mut je = j;
	while je + 1 < live.min(o.len())
		&& (o.steps[je + 1].kind == K_GRIND || {
			let pt = o.steps[je + 1].pt as usize;
			area_dist(&[(run.p_c[pt], run.p_x[pt], run.p_y[pt])], &b) <= CAMP_YD
		}) {
		je += 1;
	}
	// Each step (original index) put back before an original index, or after one (in turn).
	let seq = |plan: &[(usize, bool, usize)]| -> Option<Mv> {
		let mut cur: Vec<usize> = (0..o.len()).collect();
		let mut mvs = Vec::new();
		for &(k, after, t) in plan {
			let from = cur.iter().position(|&x| x == k)?;
			cur.remove(from);
			let p = cur.iter().position(|&x| x == t)?;
			let to = if after { p + 1 } else { p };
			cur.insert(to, k);
			if to != from {
				mvs.push(Mv::Move { s: from, e: from, to, kind: "revisit" });
			}
		}
		match mvs.len() {
			0 => None,
			_ => Some(Mv::Seq { kind: "revisit", mvs }),
		}
	};
	let chain = |first: usize, ks: &mut dyn Iterator<Item = usize>| -> Vec<(usize, bool, usize)> {
		let mut anchor = first;
		ks.map(|k| {
			let x = (k, true, anchor);
			anchor = k;
			x
		})
		.collect()
	};
	let mut out = Vec::new();
	// Before j, the rest after the visit.
	let mut before: Vec<(usize, bool, usize)> = (s..=e).map(|k| (k, false, j)).collect();
	before.extend(chain(je, &mut deps.iter().copied()));
	out.extend(seq(&before));
	// After the visit, the rest after them.
	out.extend(seq(&chain(je, &mut (s..=e).chain(deps.iter().copied()))));
	out
}

/// An order's stretches on one walk region (Run::p_r; a grind checkpoint on the region before it):
/// (first step, last step, region), over its steps played before 60.
fn region_blocks(run: &crate::run::Run, o: &Order, live: usize) -> Vec<(usize, usize, i64)> {
	let mut out: Vec<(usize, usize, i64)> = Vec::new();
	for k in 0..live.min(o.len()) {
		let r = if o.steps[k].kind == K_GRIND {
			match out.last() {
				Some(b) => b.2,
				None => continue,
			}
		} else {
			run.p_r[o.steps[k].pt as usize]
		};
		match out.last_mut() {
			Some(b) if b.2 == r => b.1 = k,
			_ => out.push((k, k, r)),
		}
	}
	out
}

/// Times an order (its steps played before 60) goes from one walk region to another: the boats,
/// zeppelins and flights across water (c15 Night Elf's Stormwind trip and back before Westfall).
pub fn region_changes(run: &crate::run::Run, o: &Order, live: usize) -> usize {
	region_blocks(run, o, live).len().saturating_sub(1)
}

/// Returns to ground in an order (`live`: its steps played before 60): each task whose nearest
/// earlier task on the same ground (camps within REVISIT_CAMP_YD, at most REVISIT_GAP_STEPS back)
/// was left between them (a stop more than CAMP_YD from both camps).
pub fn camp_returns(run: &crate::run::Run, o: &Order, live: usize) -> usize {
	let live = live.min(o.len());
	let at = |k: usize| {
		let pt = o.steps[k].pt as usize;
		[(run.p_c[pt], run.p_x[pt], run.p_y[pt])]
	};
	let areas: Vec<Option<Vec<(i64, f64, f64)>>> = (0..live).map(|k| (o.steps[k].kind == K_TASK).then(|| task_area(run, o.steps[k].task as usize))).collect();
	let mut n = 0;
	for k in 0..live {
		let Some(b) = &areas[k] else { continue };
		let prev = (k.saturating_sub(REVISIT_GAP_STEPS)..k).rev().find(|&i| areas[i].as_ref().is_some_and(|a| area_dist(a, b) <= REVISIT_CAMP_YD));
		if let Some(i) = prev {
			let a = areas[i].as_ref().unwrap();
			if (i + 1..k).any(|x| o.steps[x].kind != K_GRIND && area_dist(&at(x), a) > CAMP_YD && area_dist(&at(x), b) > CAMP_YD) {
				n += 1;
			}
		}
	}
	n
}

/// The camp revisit pass: each field trip to ground the order comes back to (camp_revisits) done on
/// the later trip, kept when the order keeps its rules, no guard worsens, and fewer returns to
/// ground (camp_returns) or crossings of water (region_changes) are left, neither rising, with the
/// hours to 60 rising by at most HUB_PICKUP_ALLOW_SEC, or as many with the hours not rising.
/// Rounds until none is kept.
pub fn camp_revisit<'a>(p: &Problem<'a>, m: &mut Member<'a>, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let mut kept = Vec::new();
	// Each candidate's checks before its replay (they read the order and its run only), on the
	// threads: the candidate order, where it changes and whether it leaves fewer returns to
	// ground or crossings of water, or None.
	let screen = |m: &Member, cands: &[Mv]| -> Vec<Option<(Order, usize, usize, bool)>> {
		let (rn, xn) = (camp_returns(run, &m.order, m.live), region_changes(run, &m.order, m.live));
		let twins = twin_trainings(&m.order);
		crate::par_map_with(
			cands.len(),
			|| crate::order::Checker::new(run),
			|check, k| {
				let (cand, a, b) = cands[k].apply(&m.order)?;
				// (Nothing moved at or past the cap: a start's own part only, its shared tail kept.)
				if a >= m.live || b >= m.cap || !check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(&cand) > twins {
					return None;
				}
				// Fewer returns to ground or crossings of water (neither rising), within the allowance;
				// as many, only a move that adds no time (a time-saving one the search missed).
				let (rc, xc) = (camp_returns(run, &cand, m.live), region_changes(run, &cand, m.live));
				(rc <= rn && xc <= xn).then_some((cand, a, b, rc < rn || xc < xn))
			},
		)
	};
	let mut twins = Vec::new();
	loop {
		// (The candidates depend on the order and its run only: built again after a kept move.)
		let cands = camp_revisits(p, m);
		let mut ok = screen(m, &cands);
		let ks: Vec<usize> = (0..ok.len()).filter(|&k| ok[k].is_some()).collect();
		let Some((k, (next, gc))) = first_some(p, m, &mut twins, &ks, |t, k| {
			let (cand, a, b, fewer) = ok[k].as_ref()?;
			t.allow = if *fewer { HUB_PICKUP_ALLOW_SEC } else { 0.0 };
			let r = t.replay(p, cand, *a, *b);
			t.allow = 0.0;
			r
		}) else {
			break;
		};
		let (cand, a, _, _) = ok[k].take().expect("a screened candidate");
		let mv = cands[k].clone();
		let now = m.total();
		let before = m.order.clone();
		let lv = m.lv.clone();
		m.guard_now = gc;
		for (c, cur) in m.ctxs.iter_mut().zip(next) {
			c.cur = cur;
		}
		m.order = cand;
		m.refresh();
		for t in &mut twins {
			t.take(m);
		}
		let added = m.total() - now;
		log(&format!("camp revisit at step {a}: {:+.1} min", added / 60.0));
		kept.push(HubPickup { mv, before, lv, added, hours: m.total() / 3600.0 });
		if kept.len() >= CAMP_GATHER_MAX {
			break;
		}
	}
	kept
}

/// Seconds the hub sweep lets one accept or hand-in done where it is ready (in the hub visit,
/// on the leg past its NPC) add to the hours to 60: what a quest taken where the player stands
/// may cost (HUB_PICKUP_ALLOW_SEC).
pub const HUB_SWEEP_ALLOW_SEC: f64 = HUB_PICKUP_ALLOW_SEC;
/// Seconds a hub visit's loop order may add (its XP comes a few steps sooner or later).
pub const HUB_LOOP_ALLOW_SEC: f64 = 30.0;
/// Places tried for a step in its visit (the cheapest by straight detour).
pub const SWEEP_PLACES: usize = 3;
/// Times a refused sweep fix is tried, each after another move was kept.
pub const SWEEP_TRIES: u32 = 3;
/// The replay's allowance when a pass checks its own on the exact replay (keep_seq): no bound.
const EXACT_ALLOW: f64 = 1.0e9;

/// The hub sweep (Fitz in Brill, c12: "all over the place"): at a hub, what is ready there is done
/// in that visit, and a ready hand-in or accept whose NPC a walked leg passes is done on the way.
/// First each step the hub counts point at (crate::hubs: left ready at a visit, walked past) moves
/// into its visit or onto its leg, one at a time, kept when the order keeps its rules, no guard
/// worsens, the hub counts drop and the hours to 60 rise by at most HUB_SWEEP_ALLOW_SEC (the route
/// still comes back later when that saves more). Then each visit's stops go in the order of the
/// shortest walk through them (hubs::loop_order), within HUB_LOOP_ALLOW_SEC.
pub fn hub_sweep(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	// A fix refused is tried again after another move is kept (that move may be what it waited
	// for: a follow-up handed in first), at most SWEEP_TRIES times; each kept move lowers the counts,
	// so the rounds end.
	let mut tried: rustc_hash::FxHashMap<(u8, u32, i32, bool), (u32, usize)> = Default::default();
	loop {
		let (now, fixes) = hub_scan(p, h, m);
		let mut any = false;
		for fix in fixes {
			let st = m.order.steps[fix.step()];
			let t = tried.entry((st.kind, st.q, st.task, matches!(fix, Fix::Leg { .. }))).or_insert((0, usize::MAX));
			// (Not again before another move is kept: `t.1` is the kept count it was last tried at.)
			if t.0 >= SWEEP_TRIES || t.1 == kept.len() || plan_hearth(run, st) {
				continue;
			}
			*t = (t.0 + 1, kept.len());
			for mv in sweep_moves(run, &m.order, fix) {
				let got = match keep_seq(p, m, h, std::slice::from_ref(&mv), now, HUB_SWEEP_ALLOW_SEC, 0.0, |n, o| n.sum() < o.sum()) {
					// Its own quest's next step may need to follow (a hand-in ready once the accept
					// moves, now passed on the way): the two together.
					Tried::Retry(cand) => {
						follow_ups(p, h, run, &cand, st.q).into_iter().find_map(|mv2| match keep_seq(p, m, h, &[mv.clone(), mv2], now, HUB_SWEEP_ALLOW_SEC, 0.0, |n, o| n.sum() < o.sum()) {
							Tried::Kept(v) => Some(v),
							_ => None,
						})
					}
					Tried::Kept(v) => Some(v),
					Tried::No => None,
				};
				if let Some(pks) = got {
					for pk in pks {
						if let Mv::Move { to, kind, .. } = &pk.mv {
							log(&format!("{kind} at step {to}: {:+.1} min", pk.added / 60.0));
						}
						kept.push(pk);
					}
					any = true;
					break;
				}
			}
			if any {
				break;
			}
		}
		if !any {
			break;
		}
	}
	// Each visit's loop.
	let mut k = 0;
	loop {
		let live = m.live.min(m.order.len());
		let (vs, _, _) = crate::hubs::visits(h, run, &m.order.steps[..live]);
		let Some(&v) = vs.get(k) else { break };
		k += 1;
		if v.e < v.s + 2 {
			continue;
		}
		let c = &m.ctxs[0];
		let entry = c.cur.steps[..v.s + c.off].iter().rev().find(|s| s.kind != K_GRIND).map_or(run.start_pt, |s| s.pt);
		let exit = m.order.steps[v.e + 1..].iter().find(|s| s.kind != K_GRIND).map(|s| s.pt);
		let keep = |x: &Step, y: &Step| loop_keep(p, x, y);
		let Some((seq, _, _)) = loop_order(run, &m.order.steps, v.s, v.e, entry, exit, &keep) else { continue };
		// A v1 hearth line stays on the step it arrives at.
		if seq.iter().enumerate().any(|(n, &i)| i != v.s + n && plan_hearth(run, m.order.steps[i])) {
			continue;
		}
		let perm = seq.iter().map(|&i| i - v.s).collect();
		let (now, _) = hub_scan(p, h, m);
		if let Tried::Kept(pks) = keep_seq(p, m, h, &[Mv::Reorder { s: v.s, perm }], now, HUB_LOOP_ALLOW_SEC, 0.0, |n, o| n.sum() <= o.sum()) {
			for pk in pks {
				log(&format!("hub loop at step {}: {:+.1} min", v.s, pk.added / 60.0));
				kept.push(pk);
			}
		}
	}
	kept
}

/// Seconds a hub batch may add to the hours to 60 (a return saved is worth what a quest taken
/// where the player stands is: HUB_PICKUP_ALLOW_SEC).
pub const HUB_BATCH_ALLOW_SEC: f64 = HUB_PICKUP_ALLOW_SEC;
/// Most accepts and hand-ins a hub return may hold to be folded into the next visit.
pub const BATCH_STEPS: usize = 2;
/// Levels lower than before an objective may come after a hub batch (its hand-in's XP comes at
/// the next visit), where it is under level.
pub const BATCH_LEVEL_SLACK: f64 = 0.5;
/// Levels within which a whole visit to a hub is folded into the next visit there (RevA2-3, c13:
/// Stormwind and Ironforge at 58.6 and again at 59.4, mostly cloth, ~15-20 min and a boat).
pub const BATCH_NEAR_LEVELS: f64 = 1.0;

/// Fewer hub returns (planner rule 6: Razor Hill 8 visits in ours where 5
/// suffice, Bloodhoof 9-10 where 6 do; come back when several hand-ins are ready together, not for
/// one hand-in the search found cheap): a return to a hub for at most BATCH_STEPS accepts and
/// hand-ins, a hand-in among them, or a whole visit of quest steps and trainings whose next visit to
/// the hub comes within BATCH_NEAR_LEVELS levels, folded into the next visit to that hub. Kept when
/// the order keeps its rules, no guard worsens, the hub's visits drop and the hours to 60 rise by at
/// most HUB_BATCH_ALLOW_SEC. The planner's straight-line hub counts guard it here; the written
/// guides' check (flow_fixes) undoes one it finds walked past.
pub fn hub_batch(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<Vec<(u8, u32, i32)>> = Default::default();
	loop {
		let live = m.live.min(m.order.len());
		let (vs, _, _) = crate::hubs::visits(h, run, &m.order.steps[..live]);
		let lim = m.live;
		let visits_of = |o: &Order, hub_pt: u32| {
			let (vs, of, _) = crate::hubs::visits(h, run, &o.steps[..lim.min(o.len())]);
			o.steps.iter().position(|s| s.pt == hub_pt && s.kind != K_GRIND).map_or(0, |i| vs.iter().filter(|v| of[i] != usize::MAX && v.hub == vs[of[i]].hub).count())
		};
		let mut any = false;
		for (k, v) in vs.iter().enumerate() {
			let steps = &m.order.steps[v.s..=v.e];
			let quest = |x: &Step| matches!(x.kind, K_ACCEPT | K_TURNIN);
			let Some(w) = vs[k + 1..].iter().find(|x| x.hub == v.hub) else { continue };
			let short = steps.len() <= BATCH_STEPS && steps.iter().all(quest) && steps.iter().any(|x| x.kind == K_TURNIN) && vs[..k].iter().any(|x| x.hub == v.hub);
			let near = steps.iter().all(|x| matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN | K_TRAIN)) && m.lv.get(w.s).zip(m.lv.get(v.s)).is_some_and(|(b, a)| b - a <= BATCH_NEAR_LEVELS);
			if !short && !near {
				continue;
			}
			let key: Vec<(u8, u32, i32)> = steps.iter().map(|x| (x.kind, x.q, x.task)).collect();
			if !tried.insert(key) || steps.iter().any(|&x| plan_hearth(run, x)) {
				continue;
			}
			let mv = Mv::Move { s: v.s, e: v.e, to: w.s - (v.e - v.s + 1), kind: "hub batch" };
			let Some((cand, _, _)) = mv.apply(&m.order) else { continue };
			let pt = steps[0].pt;
			if visits_of(&cand, pt) >= visits_of(&m.order, pt) {
				continue;
			}
			let (now, _) = hub_scan(p, h, m);
			if let Tried::Kept(pks) = keep_seq(p, m, h, &[mv], now, HUB_BATCH_ALLOW_SEC, BATCH_LEVEL_SLACK, |n, o| n.left_ready <= o.left_ready && n.walked_past <= o.walked_past) {
				for pk in pks {
					log(&format!("hub batch at step {}: {:+.1} min", v.s, pk.added / 60.0));
					kept.push(pk);
				}
				any = true;
				break;
			}
		}
		if !any {
			break;
		}
	}
	kept
}

/// Seconds the stay-on-continent pass lets a trip's removal add to the hours to 60 (flow beats
/// model minutes: two zeppelins and two hearths for quests at 40-60 % XP are a player's worst
/// placement of them; the cost is in the edit list).
pub const STAY_ALLOW_SEC: f64 = 900.0;

/// Stay on the continent (planner rule 2): each low trip (guards::low_trips) taken
/// out by the cheapest of edits::trip_drops' variants that removes it (its low quests, its every
/// quest, or every quest with the continent's zone block in its place), kept when the order keeps
/// its rules, no guard rises and the hours to 60 rise by at most STAY_ALLOW_SEC. Rounds until none
/// is kept.
pub fn stay_on_continent(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let low = |c: &Current| crate::guards::low_trip_count(run, &c.steps, c.levels());
	let mut kept = Vec::new();
	for _round in 0..8 {
		let before = low(&m.ctxs[0].cur);
		if before == 0 {
			break;
		}
		let now = m.total();
		// Each variant priced by its exact replay; the cheapest that removes a low trip first.
		let mut ranked: Vec<(f64, Mv)> = Vec::new();
		for mv in super::edits::trip_drops(p, m).into_iter().map(|x| match x {
			Mv::Seq { mvs, .. } => Mv::Seq { kind: "stay on continent", mvs },
			x => x,
		}) {
			let Some((cand, a, b)) = mv.apply(&m.order) else { continue };
			if a >= m.live || !m.check.valid(&cand.steps, &p.pairs, &p.feas) {
				continue;
			}
			m.allow = EXACT_ALLOW;
			let r = m.replay(p, &cand, a, b);
			m.allow = 0.0;
			let Some((next, _)) = r else { continue };
			if low(&next[0]) < before {
				ranked.push((next.iter().map(|c| c.total).sum::<f64>() - now, mv));
			}
		}
		ranked.sort_by(|x, y| x.0.total_cmp(&y.0));
		if ranked.is_empty() {
			log(&format!("stay on the continent: {before} low trip(s), no removal of one keeps the rules"));
		}
		let mut any = false;
		for (cost, mv) in ranked {
			if cost > STAY_ALLOW_SEC {
				log(&format!("stay on the continent: the cheapest removal adds {:+.1} min: refused", cost / 60.0));
				break;
			}
			let (hub, _) = hub_scan(p, h, m);
			// (The quests taken out leave the work after them up to a level lower.)
			if let Tried::Kept(pks) = keep_seq(p, m, h, &[mv], hub, STAY_ALLOW_SEC, 1.0, |_, _| true) {
				for pk in pks {
					log(&format!("stay on the continent: {:+.1} min", pk.added / 60.0));
					kept.push(pk);
				}
				any = true;
				break;
			}
		}
		if !any {
			break;
		}
	}
	kept
}

/// Minutes one grind top-up takes at most (the planner's grind rule: no grind block over
/// about 15 model minutes; grinds to partial levels at camps, a top-up before a hub's hand-ins).
pub const TOPUP_MIN: f64 = crate::route::GRIND_BLOCK_MIN;
/// Minutes of the model's own grind (before an accept or work under its level) worth a checkpoint.
pub const TOPUP_IMPLICIT_MIN: f64 = 1.0;
/// Seconds a top-up move may add to the hours to 60 (flow over model minutes).
pub const TOPUP_ALLOW_SEC: f64 = HUB_PICKUP_ALLOW_SEC;
/// Seconds a split of a checkpoint over TOPUP_MIN may add, at most the grind over TOPUP_MIN it
/// removes (GRIND_EXCESS_WEIGHT 1; flow over hours: c14 Human's Feralas 44-45 and Tanaris 46-47
/// grinds, 208 and 213 minutes in one block, split for 9.4 and 7.5 model minutes).
pub const TOPUP_SPLIT_ALLOW_SEC: f64 = DEFER_ALLOW_SEC;
/// Steps before a checkpoint its top-ups may go back to past its own zone stay (the stays before,
/// not past another checkpoint): a stay with too few camps of its own (c14 Human's Burning Steppes
/// 50.3-51 and 51.6-52, 228 and 144 minutes, came at the start of the stay).
pub const TOPUP_REACH: usize = 80;

/// One grind of the first character's replay: the order step it happens at, its minutes, the
/// level before and after it, and whether the step is a checkpoint (else the model's own grind
/// before an accept or work under its level).
struct Grind {
	i: usize,
	min: f64,
	from: f64,
	to: f64,
	explicit: bool,
}

fn grinds_of(p: &Problem, o: &Order) -> Vec<Grind> {
	let steps = p.steps_for(0, &o.steps);
	let off = steps.len() - o.len();
	let mut ev = p.ctxs[0].model.evaluator(p.walks);
	ev.reset();
	let mut out = Vec::new();
	for i in 0..steps.len() {
		if ev.s.finished {
			break;
		}
		let (g0, l0) = (ev.s.grind_sec, ev.level_now());
		ev.step_in(&steps, i);
		let dg = ev.s.grind_sec - g0;
		if dg > 0.0 && i >= off {
			out.push(Grind { i: i - off, min: dg / 60.0, from: l0, to: ev.level_now(), explicit: steps[i].kind == K_GRIND });
		}
	}
	out
}

/// A grind checkpoint to fractional level `to`.
fn checkpoint(to: f64) -> Step {
	let l = (to.floor() as usize).clamp(1, 59);
	Step::grind(l as u32, ((to - l as f64).max(0.0) * crate::xp::LEVEL_XP[l]).round() as i32)
}

/// Weight of a grind block's minutes over TOPUP_MIN against route minutes (the route review's
/// grind rule G1: price grind as a cost, so early hard work waits for the level instead): an excess
/// minute counts this many minutes more.
pub const GRIND_EXCESS_WEIGHT: f64 = 1.0;
/// Seconds a deferral may add to the hours to 60.
pub const DEFER_ALLOW_SEC: f64 = 600.0;
/// Seconds of route time plus weighted excess grind a deferral must save.
const MIN_DEFER_GAIN: f64 = 60.0;

/// Seconds a training moved out of a field stretch may add to the hours to 60.
pub const TRAIN_OUT_ALLOW_SEC: f64 = 60.0;

/// Trainings out of field stretches (order::field_trains; RevNightElf3, c13 Shadowglen: the level-4
/// training between the cave's tasks): each to right before the stretch's first task, else right
/// after its last, kept when the order keeps its rules, no guard rises and the hours to 60 rise by at
/// most TRAIN_OUT_ALLOW_SEC.
pub fn trains_out_of_field(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<i64> = Default::default();
	loop {
		let o = &m.order;
		let live = m.live.min(o.len());
		let away = |i: usize, t: u32| o.steps[i].kind == K_TASK && run.straight(o.steps[i].pt, t) > crate::hubs::HUB_YD;
		// The first training (not tried) inside a field stretch, and the stretch's ends.
		let found = (0..live).filter(|&k| o.steps[k].kind == K_TRAIN && !tried.contains(&o.origin[k])).find_map(|k| {
			let t = o.steps[k].pt;
			let positioned = |i: &usize| o.steps[*i].kind != K_GRIND;
			let (a, b) = ((0..k).rev().find(positioned)?, (k + 1..o.len()).find(positioned)?);
			if !away(a, t) || !away(b, t) {
				return None;
			}
			let mut s = a;
			while s > 0 && (o.steps[s - 1].kind == K_GRIND || away(s - 1, t)) {
				s -= 1;
			}
			let mut e = b;
			while e + 1 < o.len() && (o.steps[e + 1].kind == K_GRIND || away(e + 1, t)) {
				e += 1;
			}
			Some((k, s, e))
		});
		let Some((k, s, e)) = found else { break };
		tried.insert(m.order.origin[k]);
		for to in [s, e] {
			let mv = Mv::Move { s: k, e: k, to, kind: "train at the hub" };
			let (now, _) = hub_scan(p, h, m);
			if let Tried::Kept(pks) = keep_seq(p, m, h, &[mv], now, TRAIN_OUT_ALLOW_SEC, 0.0, |_, _| true) {
				for pk in pks {
					log(&format!("training out of the field at step {k}: {:+.1} min", pk.added / 60.0));
					kept.push(pk);
				}
				break;
			}
		}
	}
	kept
}

/// Seconds of grind over TOPUP_MIN in the blocks of a replay.
fn grind_excess(gs: &[Grind]) -> f64 {
	gs.iter().map(|g| (g.min - TOPUP_MIN).max(0.0) * 60.0).sum()
}

/// Seconds of grinding to 60 in the first character's replay of an order.
fn grind_sec(p: &Problem, o: &Order) -> f64 {
	let steps = p.steps_for(0, &o.steps);
	let mut ev = p.ctxs[0].model.evaluator(p.walks);
	ev.reset();
	for i in 0..steps.len() {
		if ev.s.finished {
			break;
		}
		ev.step_in(&steps, i);
	}
	ev.finish();
	ev.s.grind_sec
}

/// Seconds of route cost (grinding weighted) a hub revisit may add: an extra visit carrying a
/// chain's quest XP is worth some model time (Fitz's flow policy).
pub const REVISIT_ALLOW_SEC: f64 = 600.0;
/// Grind seconds a hub revisit must remove.
pub const REVISIT_MIN_GRIND_SEC: f64 = 300.0;

/// Hubs visited again at the level their chains open (edits::revisit_moves), the hub's ready steps
/// moved into the visit (the hub sweep's fixes). Kept when it removes REVISIT_MIN_GRIND_SEC of
/// grinding or more, the order keeps its rules (no step doing nothing, no late hand-in, no hearth on
/// cooldown, the quest log, training shifts and gaps, the feedback guards), and the route's cost
/// plus RETURN_COST_SEC for each flow count it raises (avoidable returns, passed-by, split work,
/// left ready, walked past) rises by at most REVISIT_ALLOW_SEC: an extra visit is worth it when
/// the chain's XP pays for the walking it adds (Fitz's flow policy, priced). Best grind removed
/// first; rounds until none is kept.
pub fn hub_revisits(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<(Vec<u32>, usize)> = Default::default();
	loop {
		let g0 = grind_sec(p, &m.order);
		let moves = super::edits::revisit_moves(p, m);
		// Each move's grind removed (a replay of its order), on the threads.
		let lessened: Vec<Option<f64>> = crate::par_map(moves.len(), |i| moves[i].apply(&m.order).map(|(cand, _, _)| g0 - grind_sec(p, &cand)));
		let mut cands: Vec<(f64, Mv, Vec<u32>, (Vec<u32>, usize))> = Vec::new();
		for (mv, less) in moves.into_iter().zip(lessened) {
			let qs = super::edits::revisit_quests(&mv);
			let at = if let Mv::Seq { mvs, .. } = &mv { mvs.first().and_then(|x| if let Mv::Insert { at, .. } = x { at.first().map(|a| a.0) } else { None }).unwrap_or(0) } else { 0 };
			let key = (qs, at);
			if tried.contains(&key) {
				continue;
			}
			let Some(less) = less else { continue };
			let ids: Vec<u32> = key.0.iter().map(|&q| run.q_id[q as usize]).collect();
			if less < REVISIT_MIN_GRIND_SEC {
				tried.insert(key);
				log(&format!("hub revisit {ids:?}: refused, {:.0} min less grind", less / 60.0));
				continue;
			}
			cands.push((less, mv, ids, key));
		}
		cands.sort_by(|a, b| b.0.total_cmp(&a.0));
		// Each candidate is tried once (its key's first time); they read the order only until one
		// is kept, so they are settled and judged on the threads a chunk at a time, then taken in
		// order (the refusals logged) up to the first kept.
		let mut first_time = tried.clone();
		let fresh: Vec<bool> = cands.iter().map(|c| first_time.insert(c.3.clone())).collect();
		let (now, _) = hub_scan(p, h, m);
		let mut any = false;
		let chunk = crate::threads().max(1);
		let mut lo = 0;
		'chunks: while lo < cands.len() {
			let hi = (lo + chunk).min(cands.len());
			let mm: &Member = m;
			let judged = crate::par_map_with(
				hi - lo,
				|| crate::order::Checker::new(run),
				|check, j| {
					let (_, mv, _, key) = &cands[lo + j];
					if !fresh[lo + j] {
						return None;
					}
					let (first, _, _) = mv.apply(&mm.order)?;
					// The revisit's hub visit done in one sweep: what is ready there moved into it.
					let mut mvs = vec![mv.clone()];
					let mut cand = first;
					if let Some(at) = cand.steps.iter().position(|s| s.kind == K_ACCEPT && key.0.contains(&s.q)) {
						for _ in 0..REVISIT_SETTLE {
							let Some(sm) = settle_move(p, h, mm, &cand, at) else { break };
							let Some((next, _, _)) = sm.apply(&cand) else { break };
							cand = next;
							mvs.push(sm);
						}
					}
					let verdict = judge_revisit(p, mm, check, h, &cand, now);
					Some((mvs, cand, verdict))
				},
			);
			for (j, got) in judged.into_iter().enumerate() {
				let (less, _, ids, key) = &cands[lo + j];
				tried.insert(key.clone());
				let Some((mvs, cand, verdict)) = got else { continue };
				match verdict {
					Ok((next, gc, priced)) => {
						let before = m.order.clone();
						let lv = m.lv.clone();
						let t0 = m.total();
						m.guard_now = gc;
						for (c, cur) in m.ctxs.iter_mut().zip(next) {
							c.cur = cur;
						}
						m.order = cand;
						m.refresh();
						let (added, hours) = (m.total() - t0, m.total() / 3600.0);
						log(&format!("hub revisit {ids:?} (+{} settled): {:+.1} min ({:+.1} priced), {:.0} min less grind", mvs.len() - 1, added / 60.0, priced / 60.0, less / 60.0));
						let mut b = before;
						let last = mvs.len() - 1;
						for (k, mv) in mvs.into_iter().enumerate() {
							let next = mv.apply(&b).map_or_else(|| b.clone(), |x| x.0);
							kept.push(HubPickup { mv, before: std::mem::replace(&mut b, next), lv: lv.clone(), added: if k == last { added } else { 0.0 }, hours });
						}
						any = true;
						break 'chunks;
					}
					Err(why) => log(&format!("hub revisit {ids:?} (+{} settled): refused: {why}", mvs.len() - 1)),
				}
			}
			lo = hi;
		}
		if !any {
			break;
		}
	}
	kept
}

/// Steps moved into a hub revisit's visit at most (its hub's ready accepts and hand-ins).
const REVISIT_SETTLE: usize = 8;

/// A move into the visit holding step `at` of `cand` for a step of the hub ready then and done on a
/// later return (the hub sweep's fix), its cheapest place; None when none is left.
fn settle_move(p: &Problem, h: &HubData, m: &Member, cand: &Order, at: usize) -> Option<Mv> {
	let run = &p.model.run;
	let c = &super::runs(p, cand)[0];
	let off = m.ctxs[0].off;
	let mut fixes = Vec::new();
	hub_counts(h, run, &c.steps, c.levels(), c.walked(), Some(&mut fixes));
	fixes.into_iter().find_map(|f| match f {
		Fix::Visit { j, s, e, after } if s >= off && s - off <= at && at <= e - off => {
			sweep_moves(run, cand, Fix::Visit { j: j - off, s: s - off, e: e - off, after: after.max(off) - off }).into_iter().next()
		}
		_ => None,
	})
}

/// A hub revisit's candidate judged: its runs and guard counts and its priced cost (seconds: the
/// cost change plus RETURN_COST_SEC per flow count raised) when it keeps the rules and the price is
/// within REVISIT_ALLOW_SEC, else why not.
fn judge_revisit(p: &Problem, m: &Member, check: &mut crate::order::Checker, h: &HubData, cand: &Order, hub_now: HubCounts) -> Result<(Vec<super::Current>, crate::guards::GuardCounts, f64), String> {
	let run = &p.model.run;
	if !check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(cand) > twin_trainings(&m.order) || crate::order::field_trains(run, &cand.steps) > crate::order::field_trains(run, &m.order.steps)
	{
		return Err("breaks a rule".into());
	}
	let rs = super::runs(p, cand);
	for (n, c) in rs.iter().zip(&m.ctxs) {
		let cur = &c.cur;
		if n.noops > cur.noops || n.late > cur.late || n.plan_cool > cur.plan_cool || (n.log_peak > p.log_bound && n.log_peak > cur.log_peak) {
			return Err(format!("no-ops {}->{}, late {}->{}, hearth on cooldown {}->{}, log {}", cur.noops, n.noops, cur.late, n.late, cur.plan_cool, n.plan_cool, n.log_peak));
		}
	}
	if !m.levels_ok_by(p, cand, &rs, 0.0) {
		return Err("an objective moved under its level".into());
	}
	if !m.gate_ok(p, &rs) {
		return Err("a quest taken under its minimum level".into());
	}
	let dt = rs.iter().map(|c| c.total).sum::<f64>() - m.total();
	let mut raised = 0u32;
	let mut why = vec![format!("{:+.1} min cost", dt / 60.0)];
	let gc = match &p.guard {
		Some(g) => {
			let (b, c) = (&m.guard_now, g.counts(run, &rs[0]));
			if c.training_gaps > b.training_gaps || !c.feedback_within(b) || g.train_shifts(cand, &rs[0]) > 0 {
				return Err("a training or feedback guard".into());
			}
			let hc = ctx_counts(p, h, |k| &rs[k], None);
			for (name, x, y) in [
				("avoidable returns", b.avoidable_returns, c.avoidable_returns),
				("passed-by", b.passed_by, c.passed_by),
				("split work", b.split_work, c.split_work),
				("left ready", hub_now.left_ready, hc.left_ready),
				("walked past", hub_now.walked_past, hc.walked_past),
			] {
				if y > x {
					raised += y - x;
					why.push(format!("{name} {x}->{y}"));
				}
			}
			c
		}
		None => m.guard_now.clone(),
	};
	let priced = dt + f64::from(raised) * crate::guards::RETURN_COST_SEC;
	if priced > REVISIT_ALLOW_SEC {
		return Err(format!("{:+.1} min priced: {}", priced / 60.0, why.join(", ")));
	}
	Ok((rs, gc, priced))
}

/// Defer early hard work (the planner's grind rule G1: Orc 30.7 h of grind in 14 blocks
/// over 15 minutes, 11 of them the model's own before an accept or work taken too early: Kodo
/// Roundup at 30.6, 56 minutes; Chapter I at 33.9, 165): the step the model grinds before, and its
/// quest's steps after it, go to where the character reaches that level by questing, each at its
/// cheapest place from there. Kept when the route time plus GRIND_EXCESS_WEIGHT × the grind over
/// TOPUP_MIN per block drops, the order keeps its rules, no guard rises and the hours to 60 rise by
/// at most DEFER_ALLOW_SEC.
pub fn defer_hard_work(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<(u32, i32)> = Default::default();
	loop {
		let gs = grinds_of(p, &m.order);
		let Some(g) = gs.iter().find(|g| !g.explicit && g.min > TOPUP_MIN && !tried.contains(&(m.order.steps[g.i].q, m.order.steps[g.i].task))) else { break };
		let o = &m.order;
		let s = o.steps[g.i];
		tried.insert((s.q, s.task));
		if !matches!(s.kind, K_ACCEPT | K_TASK) || g.i >= m.live {
			log(&format!("defer hard work at step {}: a grind of {:.0} min before a step that is not work or an accept", g.i, g.min));
			continue;
		}
		let q = s.q;
		// The quest and the quests of the order that need it handed in (theirs in turn): they wait
		// with it, else they would be taken before it opens them (RevA2: the Un'Goro 49-50 grind).
		let mut chain: Vec<u32> = vec![q];
		let mut c = 0;
		while c < chain.len() {
			let x = chain[c];
			for f in o.steps.iter().filter(|y| y.kind == K_ACCEPT && crate::order::follows(run, y.q, x)).map(|y| y.q).collect::<Vec<_>>() {
				if !chain.contains(&f) {
					chain.push(f);
				}
			}
			c += 1;
		}
		let mine = |x: &Step| chain.contains(&x.q) && matches!(x.kind, K_ACCEPT | K_TASK | K_TURNIN);
		// The order without the quest's steps (what Drop leaves), and its levels.
		let keep: Vec<bool> = o.steps.iter().map(|x| !mine(x)).collect();
		let rest: Vec<Step> = o.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect();
		let lv_rest: Vec<f64> = m.lv.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect();
		let before = |k: usize| o.steps[..k].iter().filter(|x| mine(x)).count();
		// Where questing reaches the level the grind went to (the order's levels after the grind
		// carry its levels: without it, they are that much lower).
		let r0 = g.i - before(g.i);
		let need = g.to + (g.to - g.from);
		let Some(j) = (r0..lv_rest.len().min(rest.len())).find(|&k| lv_rest[k] >= need - 0.05) else {
			log(&format!("defer hard work ({}) at step {}: questing never reaches {:.1}", run.q_id[s.q as usize], g.i, g.to));
			continue;
		};
		// The quest's steps before the grind stay; from it on, each at its cheapest place from there
		// (indices into the order as it grows).
		let mut mvs: Vec<Mv> = chain.iter().map(|&x| Mv::Drop { q: x }).collect();
		let mut cur = rest;
		let mut cursor: Option<usize> = None;
		for (placed, (k, x)) in o.steps.iter().enumerate().filter(|(_, x)| mine(x)).enumerate() {
			let at = if k < g.i {
				k - before(k) + placed
			} else {
				let from = *cursor.get_or_insert(j + placed);
				let loc = locs(run, &cur);
				let at = cheapest_k(run, &cur, &loc, x.pt, from.min(cur.len()), (from + super::edits::INSERT_REACH).min(cur.len()), 1).first().copied().unwrap_or(cur.len());
				cursor = Some(at + 1);
				at
			};
			cur.insert(at, *x);
			mvs.push(Mv::Insert { q: x.q, at: vec![(at, *x)] });
		}
		let mv = Mv::Seq { kind: "defer hard work", mvs };
		let Some((cand, _, _)) = mv.apply(&m.order) else { continue };
		// Route time plus the weighted excess grind, before and after.
		let now = m.total();
		let after_total: f64 = super::runs(p, &cand).iter().map(|c| c.total).sum();
		let (ea, eb) = (grind_excess(&grinds_of(p, &cand)), grind_excess(&gs));
		if after_total + GRIND_EXCESS_WEIGHT * ea >= now + GRIND_EXCESS_WEIGHT * eb - MIN_DEFER_GAIN {
			log(&format!(
				"defer hard work ({}) at step {}: refused, {:+.1} min and {:.0} -> {:.0} min of grind over {TOPUP_MIN} min",
				run.q_id[q as usize],
				g.i,
				(after_total - now) / 60.0,
				eb / 60.0,
				ea / 60.0
			));
			continue;
		}
		let (hub, _) = hub_scan(p, h, m);
		if let Tried::Kept(pks) = keep_seq(p, m, h, &[mv], hub, DEFER_ALLOW_SEC, 0.0, |_, _| true) {
			for pk in pks {
				log(&format!("defer hard work ({}) at step {}: {:+.1} min, a grind of {:.0} min", run.q_id[q as usize], g.i, pk.added / 60.0, g.min));
				kept.push(pk);
			}
		}
	}
	kept
}

/// The planner's grind rule: whatever grind the route keeps is explicit and in pieces. The model's own
/// grind before an accept or work under its level (TOPUP_IMPLICIT_MIN or more) becomes a checkpoint
/// at the last camp of the zone stay before it (its last objective step there), else right before
/// the step; a checkpoint over TOPUP_MIN is split into top-ups of at most that, spread over
/// the camps before it in its zone stay (and the stays before it within TOPUP_REACH steps when its
/// own has too few), each grinding its share on top of the level questing reaches there, the
/// checkpoint keeping its own target. A camp whose quest's hand-in waits near it (the #617 guard,
/// guards::handin_waits) has its top-up after that hand-in instead. Kept when the order keeps its
/// rules, no guard rises, the grind it splits or surfaces is smaller and the hours to 60 rise by at
/// most TOPUP_ALLOW_SEC (a split: the grind over TOPUP_MIN it removes, up to
/// TOPUP_SPLIT_ALLOW_SEC). Rounds until none is kept.
pub fn grind_topups(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<(usize, bool)> = Default::default();
	loop {
		let gs = grinds_of(p, &m.order);
		// A grind to an accept's minimum level is a gate the game holds (it refuses the quest): written
		// as a level step right before the accept, however short (RevH2: 4971 taken at 52.75, minimum 53).
		let gate = |g: &Grind| !g.explicit && m.order.steps.get(g.i).is_some_and(|s| s.kind == K_ACCEPT && g.from < f64::from(run.q_min_level[s.q as usize]));
		let Some(g) = gs.iter().find(|g| !tried.contains(&(g.i, g.explicit)) && if g.explicit { g.min > TOPUP_MIN } else { g.min >= TOPUP_IMPLICIT_MIN || gate(g) }) else { break };
		tried.insert((g.i, g.explicit));
		let is_gate = gate(g);
		let o = &m.order;
		let loc = locs(run, &o.steps);
		let map = run.p_map[loc[g.i] as usize];
		// The camps of the zone stay before the step: its objective steps, latest first; a split
		// takes the stays before too when its own has too few (TOPUP_REACH, not past a checkpoint).
		let mut lo = g.i;
		let mut camps: Vec<usize> = Vec::new();
		let mut stay_camps = None;
		for k in (0..g.i).rev() {
			if run.p_map[loc[k] as usize] != map && stay_camps.is_none() {
				stay_camps = Some(camps.len());
				if !g.explicit || camps.len() + 1 >= (g.min / TOPUP_MIN).ceil() as usize {
					break;
				}
			}
			if stay_camps.is_some() && (o.steps[k].kind == K_GRIND || g.i - k > TOPUP_REACH) {
				break;
			}
			lo = k;
			if o.steps[k].kind == K_TASK {
				camps.push(k);
			}
		}
		let stay_camps = stay_camps.unwrap_or(camps.len());
		// Where in the stay a grind may go: not on the trip of a hand-in that waits (#617; c14 Human:
		// every split of the Un'Goro 49.5-51 and Burning Steppes 51-52 grinds put a piece right after
		// a camp whose quest was handed in a few steps on, and the guard refused it). Each camp's
		// top-up at the first such place from it: right after it, else after the hand-ins.
		let mut last_task = vec![-1i64; run.n_quests()];
		for (k, s) in o.steps[..lo].iter().enumerate() {
			if s.kind == K_TASK {
				last_task[s.q as usize] = k as i64;
			}
		}
		let mut clean = vec![false; g.i + 1];
		for s in lo..=g.i {
			if s > lo && o.steps[s - 1].kind == K_TASK {
				last_task[o.steps[s - 1].q as usize] = (s - 1) as i64;
			}
			clean[s] = s > 0 && o.steps[s - 1].kind != K_GRIND && !crate::guards::handin_waits(run, &o.steps, s, loc[s - 1], &last_task);
		}
		// Each camp's place, latest first, and whether the camp is in the step's own stay.
		let mut slots: Vec<(usize, bool)> = Vec::new();
		for (n, &c) in camps.iter().enumerate() {
			if let Some(s) = (c + 1..=g.i).find(|&s| clean[s]).filter(|s| !slots.iter().any(|x| x.0 == *s)) {
				slots.push((s, n < stay_camps));
			}
		}
		// Inserts in turn, latest place first (earlier indices stay put).
		let mut at: Vec<(usize, f64)> = Vec::new();
		if g.explicit {
			let n = (g.min / TOPUP_MIN).ceil() as usize;
			// The pieces spread over the places (not a run of top-ups at the last camps).
			let places: Vec<usize> = slots.iter().map(|x| x.0).filter(|&s| s < g.i).collect();
			let k = places.len().min(n - 1);
			let mut pieces: Vec<usize> = (0..k).map(|j| places[j * places.len() / k]).collect();
			pieces.sort_unstable();
			let parts = pieces.len() + 1;
			// Each piece grinds its share on top of the level questing has reached there (a target
			// shared out from the checkpoint's own level alone left the earliest piece most of the
			// grind: the quests between the pieces raise the level too). The earliest place first.
			let mut last = 0.0f64;
			for (k, &s) in pieces.iter().enumerate() {
				let to = (m.lv.get(s).copied().unwrap_or(g.from) + (g.to - g.from) * (k + 1) as f64 / parts as f64).min(g.to).max(last);
				last = to;
				at.push((s, to));
			}
		} else if is_gate {
			at.push((g.i, g.to));
		} else {
			at.push((slots.first().filter(|x| x.1).map_or(g.i, |x| x.0), g.to));
		}
		if at.is_empty() {
			continue;
		}
		at.sort_by_key(|a| std::cmp::Reverse(a.0));
		let mvs: Vec<Mv> = at.iter().map(|&(j, to)| Mv::Insert { q: 0, at: vec![(j, checkpoint(to))] }).collect();
		let mv = Mv::Seq { kind: "grind top-up", mvs };
		let Some((cand, _, _)) = mv.apply(&m.order) else { continue };
		// Smaller: the split block's longest piece, or less of the model's own grind there.
		let after = grinds_of(p, &cand);
		let better = if g.explicit {
			let biggest = |gs: &[Grind]| gs.iter().filter(|x| x.explicit).map(|x| x.min).fold(0.0, f64::max);
			after.iter().filter(|x| x.explicit && x.min > TOPUP_MIN).count() < gs.iter().filter(|x| x.explicit && x.min > TOPUP_MIN).count() || biggest(&after) < biggest(&gs) - 1e-6
		} else {
			let implicit = |gs: &[Grind]| gs.iter().filter(|x| !x.explicit).map(|x| x.min).sum::<f64>();
			implicit(&after) < implicit(&gs) - if is_gate { 1e-6 } else { 0.5 }
		};
		if !better {
			continue;
		}
		let (now, _) = hub_scan(p, h, m);
		// A split may cost what it removes of the grind over TOPUP_MIN, up to TOPUP_SPLIT_ALLOW_SEC.
		let allow = if g.explicit { (grind_excess(&gs) - grind_excess(&after)).clamp(TOPUP_ALLOW_SEC, TOPUP_SPLIT_ALLOW_SEC) } else { TOPUP_ALLOW_SEC };
		if let Tried::Kept(pks) = keep_seq(p, m, h, &[mv], now, allow, 0.0, |n, o| n.left_ready <= o.left_ready && n.walked_past <= o.walked_past) {
			for pk in pks {
				log(&format!("grind top-up at step {}: {:+.1} min", g.i, pk.added / 60.0));
				kept.push(pk);
			}
		}
	}
	kept
}

/// The accept level rule's pass (crate::gate) over what the order still takes under a quest's
/// minimum level in some character's run (v1's own lines; a record the seed's repairs could not
/// keep otherwise; a shared tail a start reaches lower than the canonical one): each such accept,
/// earliest first, goes to the first later place where every character meets the level and that
/// picks up its giver, no later than its quest's first objective or hand-in (gate::later_places),
/// the first of them that keeps the order's rules and adds no no-op or late hand-in; with none, a
/// level step to the minimum goes right before it (the grind the model made there unseen, now
/// written: grind_topups' gate). Kept for correctness, whatever it costs (the game refuses the
/// quest under its minimum). Run before grind_topups, so a level step is left only where no later
/// stop by the giver comes before its work.
pub fn accept_gates(p: &Problem, m: &mut Member, log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let mut kept = Vec::new();
	let mut tried: rustc_hash::FxHashSet<u32> = Default::default();
	// The first accept some character takes under its minimum, not tried yet (canonical index).
	let first = |m: &Member, tried: &rustc_hash::FxHashSet<u32>| -> Option<usize> {
		(0..m.order.len().min(m.cap)).find(|&i| {
			let s = m.order.steps[i];
			s.kind == K_ACCEPT
				&& !tried.contains(&s.q)
				&& m.ctxs.iter().enumerate().any(|(k, c)| c.cur.lv.get(i + c.off).is_some_and(|&l| crate::gate::is_under(&p.ctxs[k].model.run, &c.cur.steps[i + c.off], l)))
		})
	};
	while let Some(i) = first(m, &tried) {
		let s = m.order.steps[i];
		tried.insert(s.q);
		let id = run.q_id[s.q as usize];
		let min = f64::from(run.q_min_level[s.q as usize]);
		let lv_at = m.ctxs.iter().map(|c| c.cur.lv.get(i + c.off).copied().unwrap_or(60.0)).fold(f64::INFINITY, f64::min);
		// (Each character's levels on the order without it: what the model ground there is gone.)
		let Some((rest, _, _)) = (Mv::DropStep { i }).apply(&m.order) else { continue };
		let rr = super::runs(p, &rest);
		let level_ok = |j: usize| rr.iter().zip(&m.ctxs).all(|(c, x)| c.lv.get(j + x.off).is_none_or(|&l| l + crate::gate::EPS >= min));
		let places = crate::gate::later_places(run, &rest.steps, i, s.q, s.pt, &level_ok);
		// (Before the move cap: a start's own part keeps its shared tail.)
		let lv_to = |j: usize| rr.iter().zip(&m.ctxs).map(|(c, x)| c.lv.get(j + x.off).copied().unwrap_or(60.0)).fold(f64::INFINITY, f64::min);
		let mut mvs: Vec<(Mv, String)> = places
			.iter()
			.filter(|&&j| j < m.cap)
			.take(crate::gate::PLACES_TRIED)
			.map(|&j| (Mv::Move { s: i, e: i, to: j, kind: "accept gate" }, format!("taken {} steps later by its giver at level {:.2}", j - i, lv_to(j))))
			.collect();
		mvs.push((
			Mv::Seq { kind: "accept gate", mvs: vec![Mv::Insert { q: 0, at: vec![(i, checkpoint(min))] }] },
			format!("no later stop by its giver at level {min} before its work: a level step to {min} before it"),
		));
		let mut done = false;
		for (mv, how) in mvs {
			let Some((cand, _, _)) = mv.apply(&m.order) else { continue };
			if !m.check.valid(&cand.steps, &p.pairs, &p.feas) {
				continue;
			}
			let rs = super::runs(p, &cand);
			let worse = rs.iter().zip(&m.ctxs).any(|(n, c)| n.noops > c.cur.noops || n.late > c.cur.late);
			let still = rs.iter().enumerate().any(|(k, c)| crate::gate::under_min(&p.ctxs[k].model.run, &c.steps, &c.lv).contains(&id));
			if worse || still || !m.gate_ok(p, &rs) {
				continue;
			}
			let (before, lv, now) = (m.order.clone(), m.lv.clone(), m.total());
			if let Some(g) = &p.guard {
				m.guard_now = g.counts(run, &rs[0]);
			}
			for (c, cur) in m.ctxs.iter_mut().zip(rs) {
				c.cur = cur;
			}
			m.order = cand;
			m.refresh();
			log(&format!("accept gate {id} at step {i}: level {lv_at:.2}, under its minimum {min}: {how}, {:+.1} min", (m.total() - now) / 60.0));
			kept.push(HubPickup { mv, before, lv, added: m.total() - now, hours: m.total() / 3600.0 });
			done = true;
			break;
		}
		if !done {
			log(&format!("accept gate {id} at step {i}: level {lv_at:.2}, under its minimum {min}: left (no move keeps the order's rules)"));
		}
	}
	kept
}

/// Seconds one fix from the written guides' check may add to the hours to 60 (a hand-in done at
/// the stop the player walks past is worth what a quest taken where the player stands is).
pub const FLOW_ALLOW_SEC: f64 = HUB_PICKUP_ALLOW_SEC;
/// No bound from the planner's hub counts: they are what missed the finding (a hub batch undone).
const NO_HUB_BOUND: HubCounts = HubCounts { left_ready: u32::MAX, walked_past: u32::MAX, passed_accepts: u32::MAX };

/// The written guides' findings (crate::flow: `walked-past`, `dup-trip`, `bounce`, `feel-return` on
/// the guides the route was written as) as moves on the member's order, one at a time against the
/// order as it is:
/// - a hub batch (`batches`, hub_batch's kept moves: guarded by the planner's straight-line counts
///   only) whose steps a finding names is undone, its steps back after the step they followed,
///   when the order keeps its rules, no guard worsens and it adds at most what the batch saved
///   plus HUB_BATCH_ALLOW_SEC;
/// - an avoidable return (`feel-return`, RevHuman3: late Elwynn crossed east-west twice) moves as
///   one block, its lines right after the visit before's last line;
/// - else each of its lines moves earlier to the stop the walk passed: right after `after`, else
///   right before `before`;
///
/// each kept like a hub sweep move (the order's rules, no guard and no hub count rising) within
/// FLOW_ALLOW_SEC, a line's own quest's next step with it when that is what it needs.
///
/// Whether the round helped is the check's to say on the guides written again (stage::shared_faction).
pub fn flow_fixes(p: &Problem, m: &mut Member, findings: &[crate::flow::Finding], batches: &[HubPickup], log: &mut dyn FnMut(&str)) -> Vec<HubPickup> {
	let run = &p.model.run;
	let own;
	let h = match &p.guard {
		Some(g) => &g.data.hub,
		None => {
			own = HubData::new(run);
			&own
		}
	};
	// A line's steps in an order (indices).
	let steps_of = |o: &Order, (k, id): crate::flow::Line| -> Vec<usize> {
		let Some(q) = run.q(id) else { return Vec::new() };
		o.steps.iter().enumerate().filter(|(_, s)| s.kind == k && s.q == q).map(|(i, _)| i).collect()
	};
	let mut kept = Vec::new();
	let mut seen: rustc_hash::FxHashSet<(Vec<crate::flow::Line>, Option<crate::flow::Line>, Option<crate::flow::Line>)> = Default::default();
	let mut undone = vec![false; batches.len()];
	for f in findings {
		if !seen.insert((f.lines.clone(), f.after, f.before)) {
			continue;
		}
		let names = |s: &Step| f.lines.iter().any(|&(k, id)| s.kind == k && run.q(id) == Some(s.q));
		let mut fixed = false;
		// (The latest first: undone in the reverse of the order they were made.)
		for (b, pk) in batches.iter().enumerate().rev() {
			let Mv::Move { s, e, .. } = pk.mv else { continue };
			if undone[b] || !pk.before.steps[s..=e].iter().any(names) {
				continue;
			}
			undone[b] = true;
			let Some(mvs) = undo_moves(&m.order, pk) else { continue };
			if let Tried::Kept(pks) = keep_seq(p, m, h, &mvs, NO_HUB_BOUND, (-pk.added).max(0.0) + HUB_BATCH_ALLOW_SEC, BATCH_LEVEL_SLACK, |_, _| true) {
				log(&format!("hub batch undone ({}): {:+.1} min", f.text, pks.iter().map(|x| x.added).sum::<f64>() / 60.0));
				kept.extend(pks);
				fixed = true;
			}
		}
		if fixed {
			continue;
		}
		// An avoidable return: its lines together, right after the visit before's last line.
		if f.rule == crate::flow::BLOCK_RULE {
			let mut js: Vec<usize> = f.lines.iter().filter_map(|&l| steps_of(&m.order, l).first().copied()).collect();
			js.sort_unstable();
			js.dedup();
			let Some(&j0) = js.first() else { continue };
			let Some(a) = f.after.and_then(|a| steps_of(&m.order, a).into_iter().rfind(|&x| x < j0)) else { continue };
			if js.iter().any(|&j| j >= m.live || plan_hearth(run, m.order.steps[j])) {
				continue;
			}
			let block: Vec<Step> = js.iter().map(|&j| m.order.steps[j]).collect();
			let Some(mvs) = place_after(&m.order, m.order.steps[a], &block, "written check") else { continue };
			let (now, _) = hub_scan(p, h, m);
			if let Tried::Kept(pks) = keep_seq(p, m, h, &mvs, now, FLOW_ALLOW_SEC, 0.0, |_, _| true) {
				log(&format!("written check, a return's work on the visit before ({}): {:+.1} min", f.text, pks.iter().map(|x| x.added).sum::<f64>() / 60.0));
				kept.extend(pks);
			}
			continue;
		}
		for &line in &f.lines {
			let Some(&j) = steps_of(&m.order, line).first() else { continue };
			if j >= m.live || plan_hearth(run, m.order.steps[j]) {
				continue;
			}
			let after = f.after.and_then(|a| steps_of(&m.order, a).into_iter().rfind(|&x| x < j));
			let before = f.before.and_then(|b| steps_of(&m.order, b).into_iter().find(|&x| x < j && after.is_none_or(|a| x > a)));
			let mut tos: Vec<usize> = after.map(|a| a + 1).into_iter().chain(before).filter(|&t| t < j).collect();
			tos.dedup();
			let q = m.order.steps[j].q;
			for to in tos {
				let mv = Mv::Move { s: j, e: j, to, kind: "written check" };
				let (now, _) = hub_scan(p, h, m);
				let got = match keep_seq(p, m, h, std::slice::from_ref(&mv), now, FLOW_ALLOW_SEC, 0.0, |_, _| true) {
					Tried::Retry(cand) => follow_ups(p, h, run, &cand, q).into_iter().find_map(|mv2| match keep_seq(p, m, h, &[mv.clone(), mv2], now, FLOW_ALLOW_SEC, 0.0, |_, _| true) {
						Tried::Kept(v) => Some(v),
						_ => None,
					}),
					Tried::Kept(v) => Some(v),
					Tried::No => None,
				};
				if let Some(pks) = got {
					log(&format!("written check at step {to} ({}): {:+.1} min", f.text, pks.iter().map(|x| x.added).sum::<f64>() / 60.0));
					kept.extend(pks);
					break;
				}
			}
		}
	}
	kept
}

/// The moves that undo a hub batch on the order as it is now: each step it moved back right after
/// the step it followed before the batch (place_after).
fn undo_moves(o: &Order, pk: &HubPickup) -> Option<Vec<Mv>> {
	let Mv::Move { s, e, .. } = pk.mv else { return None };
	let prev = *pk.before.steps[..s].iter().rev().find(|x| x.kind != K_GRIND)?;
	place_after(o, prev, &pk.before.steps[s..=e], "hub batch undone")
}

/// The moves that put `block`'s steps (found by value) right after step `prev`, in their order, one
/// after the other; None when one of them is no longer in the order or nothing would move.
fn place_after(o: &Order, mut prev: Step, block: &[Step], kind: &'static str) -> Option<Vec<Mv>> {
	let mut cur = o.clone();
	let mut mvs = Vec::new();
	for &x in block {
		let i = cur.steps.iter().position(|y| *y == x)?;
		let a = cur.steps.iter().position(|y| *y == prev)?;
		let to = if i <= a { a } else { a + 1 };
		if to != i {
			let mv = Mv::Move { s: i, e: i, to, kind };
			cur = mv.apply(&cur)?.0;
			mvs.push(mv);
		}
		prev = x;
	}
	(!mvs.is_empty()).then_some(mvs)
}

/// The hub counts of the runs `cur(k)` (one per character of `p`), added over Problem::hub_ctxs:
/// the canonical character's and every other start's, each by its own run, its own part before the
/// tail included (c14: the Skyborne's Journey to Sentinel Hill, taken before the join, and the
/// Dwarves' MacKreel's Moonshine are hand-ins the canonical Human never makes). With `fixes`, their
/// fixes as (the character's prefix length, the fix in its steps).
pub fn ctx_counts<'c>(p: &Problem, h: &HubData, cur: impl Fn(usize) -> &'c super::Current, mut fixes: Option<&mut Vec<(usize, Fix)>>) -> HubCounts {
	let mut n = HubCounts::default();
	for k in p.hub_ctxs() {
		let c = cur(k);
		let mut f = Vec::new();
		n += hub_counts(p.ctx_hub(k, h), &p.ctxs[k].model.run, &c.steps, c.levels(), c.walked(), fixes.is_some().then_some(&mut f));
		if let Some(out) = fixes.as_deref_mut() {
			let off = p.ctxs[k].prefix.len();
			out.extend(f.into_iter().map(|x| (off, x)));
		}
	}
	n
}

/// The hub counts of the member's order (ctx_counts), and their fixes as indices into the order (the
/// steps of a shared tail's prefix are not the order's: left out), each once.
fn hub_scan(p: &Problem, h: &HubData, m: &Member) -> (HubCounts, Vec<Fix>) {
	let mut raw = Vec::new();
	let n = ctx_counts(p, h, |k| &m.ctxs[k].cur, Some(&mut raw));
	let live = m.live.min(m.order.len());
	let mut fixes: Vec<Fix> = Vec::new();
	for (off, f) in raw {
		let f = match f {
			Fix::Visit { j, s, e, after } if j >= off && e >= off && j - off < live => Fix::Visit { j: j - off, s: s.max(off) - off, e: e - off, after: after.max(off) - off },
			Fix::Leg { j, i } if i >= off && j - off < live => Fix::Leg { j: j - off, i: i - off },
			_ => continue,
		};
		if !fixes.contains(&f) {
			fixes.push(f);
		}
	}
	(n, fixes)
}

/// The moves a fix offers: the step into its visit at its SWEEP_PLACES cheapest places after what
/// it needs, or onto its leg.
fn sweep_moves(run: &crate::run::Run, o: &Order, fix: Fix) -> Vec<Mv> {
	match fix {
		Fix::Visit { j, s, e, after } => {
			let loc = locs(run, &o.steps);
			cheapest_k(run, &o.steps, &loc, o.steps[j].pt, (s + 1).max(after + 1), e + 1, SWEEP_PLACES).into_iter().map(|to| Mv::Move { s: j, e: j, to, kind: "hub sweep" }).collect()
		}
		Fix::Leg { j, i } => vec![Mv::Move { s: j, e: j, to: i, kind: "on the way" }],
	}
}

/// After a sweep move refused only for the hub counts it raised: the moves the candidate's own
/// fixes (ctx_counts) offer for another step of the same quest.
fn follow_ups(p: &Problem, h: &HubData, run: &crate::run::Run, cand: &Order, q: u32) -> Vec<Mv> {
	let rs = super::runs(p, cand);
	let mut raw = Vec::new();
	ctx_counts(p, h, |k| &rs[k], Some(&mut raw));
	let mut fixes: Vec<Fix> = Vec::new();
	for (off, f) in raw {
		let x = f.step();
		if x < off || cand.steps[x - off].q != q || !matches!(cand.steps[x - off].kind, K_ACCEPT | K_TURNIN) {
			continue;
		}
		let f = match f {
			Fix::Visit { j, s, e, after } if s >= off => Fix::Visit { j: j - off, s: s - off, e: e - off, after: after.max(off) - off },
			Fix::Leg { j, i } if i >= off => Fix::Leg { j: j - off, i: i - off },
			_ => continue,
		};
		if !fixes.contains(&f) {
			fixes.push(f);
		}
	}
	fixes.into_iter().flat_map(|f| sweep_moves(run, cand, f).into_iter().take(1)).collect()
}

/// A sweep attempt: kept (one row per move); refused by its replay or the hub counts it raises
/// (the candidate: a follow-up move may settle it); or refused.
enum Tried {
	Kept(Vec<HubPickup>),
	Retry(Order),
	No,
}

/// Keep sweep moves made in turn when the order keeps its rules, its replay adds at most `allow`
/// seconds and raises no guard, no objective comes more than `slack` levels lower where it is under
/// level (Member::levels_ok_by), the hub counts don't rise one by one and `better(new, now)` holds.
fn keep_seq(p: &Problem, m: &mut Member, h: &HubData, mvs: &[Mv], now_hub: HubCounts, allow: f64, slack: f64, better: impl Fn(&HubCounts, &HubCounts) -> bool) -> Tried {
	let mut cand = m.order.clone();
	let mut befores = Vec::with_capacity(mvs.len());
	let (mut a, mut b) = (usize::MAX, 0);
	for mv in mvs {
		let Some((next, x, y)) = mv.apply(&cand) else { return Tried::No };
		befores.push(std::mem::replace(&mut cand, next));
		(a, b) = (a.min(x), b.max(y));
	}
	let reach = b;
	let b = (b + mvs.len()).min(cand.len() - 1);
	// (Nothing moved at or past the cap: a start's own part only, its shared tail kept.)
	if a >= m.live || reach >= m.cap || !m.check.valid(&cand.steps, &p.pairs, &p.feas) || twin_trainings(&cand) > twin_trainings(&m.order) {
		return Tried::No;
	}
	let now = m.total();
	// Priced by the exact replay (the windowed estimate is not sure enough for a hand-in moved
	// earlier: Orc's golden order, +180 s estimated for -31 s exact), the allowance checked on it.
	m.allow = EXACT_ALLOW;
	let r = m.replay(p, &cand, a, b);
	m.allow = 0.0;
	// (A refused replay may be the guard the follow-up would settle: retried with it.)
	let Some((next, gc)) = r else { return Tried::Retry(cand) };
	// No more split work either (the replay with an allowance bounds only the judge's guards).
	if p.guard.is_some() && gc.split_work > m.guard_now.split_work {
		return Tried::Retry(cand);
	}
	if next.iter().map(|c| c.total).sum::<f64>() - now > allow {
		return Tried::Retry(cand);
	}
	// Every start's hub counts (ctx_counts), not the canonical start's alone.
	let hc = ctx_counts(p, h, |k| &next[k], None);
	if !m.levels_ok_by(p, &cand, &next, slack) {
		return Tried::No;
	}
	if hc.left_ready > now_hub.left_ready || hc.walked_past > now_hub.walked_past || !better(&hc, &now_hub) {
		return Tried::Retry(cand);
	}
	let lv = m.lv.clone();
	m.guard_now = gc;
	for (c, cur) in m.ctxs.iter_mut().zip(next) {
		c.cur = cur;
	}
	m.order = cand;
	m.refresh();
	let (added, hours) = (m.total() - now, m.total() / 3600.0);
	let last = mvs.len() - 1;
	Tried::Kept(mvs.iter().zip(befores).enumerate().map(|(k, (mv, before))| HubPickup { mv: mv.clone(), before, lv: lv.clone(), added: if k == last { added } else { 0.0 }, hours }).collect())
}

/// Whether step x must stay ahead of step y in a hub's loop (x before y now): steps of one quest,
/// of quests one chain links (prerequisites, exclusions, a parent), or a deliberate or feasibility
/// rule names together. Trainings and other stops are free (the replay prices them).
pub fn loop_keep(p: &Problem, x: &Step, y: &Step) -> bool {
	let quest = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	if !quest(x) || !quest(y) {
		return false;
	}
	if x.q == y.q {
		return true;
	}
	let run = &p.model.run;
	let chain = |a: u32, b: u32| {
		let bi = b as usize;
		run.q_pre[bi].contains(&a) || run.q_all[bi].contains(&a) || run.q_after[bi].contains(&a) || run.q_excl[bi].contains(&a) || run.q_parent[bi] == a as i32
	};
	let both = |qa: u32, qb: u32| (qa == x.q && qb == y.q) || (qa == y.q && qb == x.q);
	chain(x.q, y.q) || chain(y.q, x.q) || p.pairs.iter().any(|r| both(r.qa, r.qb)) || p.feas.needs.iter().any(|r| both(r.qa, r.qb)) || p.feas.together.iter().any(|r| both(r.qa, r.qb))
}

/// A step v1's travel plan hearths to.
fn plan_hearth(run: &crate::run::Run, s: Step) -> bool {
	run.plan.as_ref().is_some_and(|pl| run.step_key(s.kind, s.q, s.task).is_some_and(|k| pl.hearth.contains(&k)))
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
			if ev.hearth_clock() < ev.s.hearth_ready {
				h.planned_on_cooldown += 1;
			}
		}
		let before = ev.s.hearths;
		let t0 = ev.hearth_clock();
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
