//! The judge's guards as per-route counters, cheap enough for the search to reject a move on:
//! avoidable returns (port of v2-route tools/lib/judge/returns.js `avoidableReturns`) and
//! passed-by (tools/lib/judge/passedby.js `passedBy`), on the sim's order instead of a guide's
//! goal stream.
//!
//! Differences from the judge, all from what an order holds: places are the order's steps' run
//! points (a guide also has goto/fly goals); an area is the world's (world.areas, the sim's
//! span 250 / hub 400 clusters) where the judge uses the quest atlas's; "near an area" is within
//! AWAY of one of its member points; a quest's giver is its world giver (and alternative givers),
//! not every spawn of the NPC; a leg is walked when the evaluator walked it (no flight, boat or
//! hearth); an objective's item is taken to come from where its task is done. The counts are
//! compared with the same order's v1 counts, so the guard is consistent with itself; the judge
//! stays the reference for the reported numbers.

use crate::eval::Step;
use crate::run::{Run, K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_core::{Frame, Projector};
use forge_world::atlas::{AtlasNode, GoalAt};
use forge_world::rules::level_ok;
use forge_world::{Atlas, GameData, World};
use rustc_hash::{FxHashMap, FxHashSet};

/// Yards: a visit to an area ends when the walk goes this far from it (returns.js AWAY).
pub const AWAY: f64 = 400.0;
/// Yards: a giver passed this close was open to pick up (returns.js PICKUP).
pub const PICKUP: f64 = 300.0;
/// Yards: passed-by radius, sample step and the "went away" distance (passedby.js).
pub const PB_RADIUS: f64 = 500.0;
pub const PB_STEP: f64 = 50.0;
pub const PB_LEFT: f64 = 1000.0;
/// Levels above the character a quest is in the accept window (sweep.js ACCEPT_ABOVE).
pub const ACCEPT_ABOVE: f64 = 2.0;

/// The judge's facts the guards read, per run: the quest atlas (areas, roles) and the quest
/// givers' spawn points (passed-by), mapped onto the run's points.
pub struct GuardData {
	/// Atlas area of each quest's accept, turn-in (per quest) and each task (per task), -1 none.
	area_accept: Vec<i32>,
	area_turnin: Vec<i32>,
	area_task: Vec<i32>,
	/// Per item task: the areas its item comes from or near (returns.js itemHere), sorted;
	/// None for other tasks (and items without places).
	item_areas: Vec<Option<Vec<usize>>>,
	/// Per atlas area: the run points within AWAY of it (sorted).
	near: FxHashMap<usize, Vec<u32>>,
	/// Per quest: its givers' areas, and the run points within PICKUP of a giver (sorted).
	give_areas: Vec<Vec<usize>>,
	pickup: Vec<Vec<u32>>,
	/// Per quest: quests whose taking closes it (excl, its breadcrumb target).
	closed_by: Vec<Vec<u32>>,
	/// Passed-by: giver spawn points of solo quests with XP, by (continent, cell x, cell y).
	grid: FxHashMap<(i64, i64, i64), Vec<(f64, f64, u32)>>,
	/// Per run point: a trainer town within TOWN_TRAIN_YD.
	near_town: Vec<bool>,
	/// Per run task: it kills an elite or rare mob (#156/#217/#175: no elite or rare camps).
	pub elite_rare: Vec<bool>,
}

/// Spawn points a giver record contributes (passedby.js spawnPoints cap).
const SPAWN_CAP: usize = 200;

fn node_dist(n: &AtlasNode, c: i64, x: f64, y: f64) -> f64 {
	if n.c != c {
		return f64::INFINITY;
	}
	n.pts.iter().fold((n.wx - x).hypot(n.wy - y), |m, s| m.min((s.0 - x).hypot(s.1 - y)))
}

impl GuardData {
	pub fn new(world: &World, run: &Run, rules: &forge_world::Rules, data: &GameData, atlas: &Atlas) -> GuardData {
		let pos: Vec<(i64, f64, f64)> = (0..run.pt_list.len()).map(|i| (run.p_c[i], run.p_x[i], run.p_y[i])).collect();
		let locate = |id: u32, t: &str, oi: Option<usize>, p: u32| -> i32 {
			let (c, wx, wy) = pos[p as usize];
			atlas.locate(&GoalAt { q: Some(id), t: t.into(), oi, c, wx, wy }).map_or(-1, |a| a as i32)
		};
		let nq = run.n_quests();
		let mut area_accept = vec![-1; nq];
		let mut area_turnin = vec![-1; nq];
		let mut area_task = vec![-1; run.task_pt.len()];
		let mut task_item_oi = vec![0u32; run.task_pt.len()];
		let mut give_areas = vec![Vec::new(); nq];
		let mut pickup = vec![Vec::new(); nq];
		let mut closed_by = vec![Vec::new(); nq];
		for q in 0..nq {
			let id = run.q_id[q];
			let wq = &world.quests[rules.open[&id]];
			area_accept[q] = locate(id, "accept", None, run.q_giver[q]);
			area_turnin[q] = locate(id, "turnin", None, run.q_ender[q]);
			let dq = data.quests.get(&id);
			for t in run.q_task0[q]..run.q_task1[q] {
				let ti = t - run.q_task0[q];
				let obj = wq.objs.iter().find(|o| o.task == Some(ti));
				let oi = obj.map(|o| o.oi as usize + 1);
				area_task[t as usize] = locate(id, "collect", oi, run.task_pt[t as usize]);
				let is_item = oi.and_then(|i| dq.and_then(|d| d.objectives.get(i - 1)).and_then(|o| o.as_ref())).is_some_and(|o| o.kind == "item");
				if is_item {
					task_item_oi[t as usize] = oi.unwrap_or(0) as u32;
				}
			}
			if let Some(r) = atlas.roles.get(&id) {
				give_areas[q] = r.give.iter().filter_map(|&n| atlas.nodes[n].area).collect();
				pickup[q] = (0..pos.len() as u32).filter(|&p| r.give.iter().any(|&n| node_dist(&atlas.nodes[n], pos[p as usize].0, pos[p as usize].1, pos[p as usize].2) <= PICKUP)).collect();
			}
			closed_by[q] = run.q_excl[q].clone();
			if wq.breadcrumb {
				if let Some(t) = wq.next.and_then(|n| run.q(n as u32)) {
					closed_by[q].push(t);
				}
			}
		}
		let mut used: Vec<usize> = area_accept.iter().chain(&area_turnin).chain(&area_task).filter(|&&a| a >= 0).map(|&a| a as usize).collect();
		used.sort_unstable();
		used.dedup();
		let near = used.into_iter().map(|a| (a, (0..pos.len() as u32).filter(|&p| atlas.area_dist(a, pos[p as usize].0, pos[p as usize].1, pos[p as usize].2) <= AWAY).collect())).collect();
		// Passed-by givers: the quests' start NPCs' and objects' spawns (passedby.js giverGrid).
		let proj = Projector::new(&data.frames);
		let mut grid: FxHashMap<(i64, i64, i64), Vec<(f64, f64, u32)>> = FxHashMap::default();
		for q in 0..nq {
			let id = run.q_id[q];
			let Some(rec) = data.quests.get(&id) else { continue };
			if rec.repeatable == Some(true) || !rec.xp.is_some_and(|x| x != 0.0 && !x.is_nan()) || !rules.solo_ok(id) {
				continue;
			}
			for (list, table) in [(&rec.start.npc, &data.npcs), (&rec.start.object, &data.objects)] {
				for &n in list {
					let Some(e) = u32::try_from(n).ok().and_then(|i| table.get(&i)) else { continue };
					for (&map, sp) in &e.spawns {
						let f = sp.f.as_deref().filter(|f| !f.is_empty()).map_or(Some(Frame::Era), Frame::parse);
						for p in sp.pts.iter().chain(sp.more.iter().flatten()).take(SPAWN_CAP) {
							let w = proj.point(map, p.first().copied().unwrap_or(f64::NAN), p.get(1).copied().unwrap_or(f64::NAN), f);
							if w.wx.is_finite() {
								grid.entry((w.c, (w.wx / PB_RADIUS).floor() as i64, (w.wy / PB_RADIUS).floor() as i64)).or_default().push((w.wx, w.wy, q as u32));
							}
						}
					}
				}
			}
		}
		let item_areas = (0..run.task_pt.len())
			.map(|t| {
				let oi = task_item_oi[t];
				if oi == 0 {
					return None;
				}
				let nodes = atlas.roles.get(&run.q_id[run.t_quest[t] as usize]).and_then(|r| r.obj.get(oi as usize - 1)).filter(|v| !v.is_empty())?;
				let mut v: Vec<usize> = (0..atlas.areas.len())
					.filter(|&a| {
						nodes.iter().any(|&n| {
							let nd = &atlas.nodes[n];
							nd.area == Some(a) || atlas.area_dist(a, nd.c, nd.wx, nd.wy) <= AWAY
						})
					})
					.collect();
				v.sort_unstable();
				Some(v)
			})
			.collect();
		let near_town = (0..run.pt_list.len() as u32).map(|p| run.towns.iter().any(|&t| run.straight(p, t) <= crate::profile::TOWN_TRAIN_YD)).collect();
		let elite_rare = elite_rare_tasks_of(run, data);
		GuardData { elite_rare, near_town, area_accept, area_turnin, area_task, item_areas, near, give_areas, pickup, closed_by, grid }
	}

	fn step_area(&self, run: &Run, s: &Step) -> i32 {
		match s.kind {
			K_ACCEPT => self.area_accept[s.q as usize],
			K_TURNIN => self.area_turnin[s.q as usize],
			K_TASK => self.area_task[s.task as usize],
			_ => {
				let _ = run;
				-1
			}
		}
	}

	fn near_area(&self, a: usize, pt: u32) -> bool {
		self.near.get(&a).is_some_and(|v| v.binary_search(&pt).is_ok())
	}

	/// returns.js itemHere: an item objective's item comes from this area or near it.
	fn item_here(&self, _run: &Run, task: usize, a: usize) -> bool {
		self.item_areas[task].as_ref().is_none_or(|v| v.binary_search(&a).is_ok())
	}
}

/// The guards' counts of an order.
#[derive(Clone, Debug, Default, PartialEq, Eq, serde::Serialize)]
pub struct GuardCounts {
	pub avoidable_returns: u32,
	pub wasted_trips: u32,
	pub passed_by: u32,
	pub passed_by_never: u32,
	/// Split work: returns to a place (within SPLIT_YD of an earlier stop, after going SPLIT_AWAY
	/// away) for work or training that could have been done on the earlier visit, with the
	/// player's window (quests up to SPLIT_ABOVE levels over the character). Total, and by zone.
	pub split_work: u32,
	pub split_by_zone: Vec<(u32, u32)>,
	/// Gaps of more than TRAIN_GAP levels between class trainings while the order passes a
	/// trainer town.
	pub training_gaps: u32,
	/// Separate visits (runs of consecutive quest steps located there) per atlas area, for areas
	/// visited more than once: never above v1's (or the current order's) for any area.
	pub area_visits: Vec<(u32, u32)>,
	/// #617: grinds done while a ready quest waits for its hand-in on the same trip.
	pub grind_before_handin: u32,
	/// #664/#663: trainings that are a bounce (their town near neither the step before nor after).
	pub train_bounces: u32,
	/// Tasks of the order that kill elite or rare mobs.
	pub elite_rare: u32,
}

/// Yards and levels of the split-work count.
pub const SPLIT_YD: f64 = 600.0;
pub const SPLIT_AWAY: f64 = 600.0;
pub const SPLIT_ABOVE: f64 = 4.0;
/// Most levels between class trainings when a trainer town is on the way.
pub const TRAIN_GAP: f64 = 4.0;

impl GuardCounts {
	/// Whether these counts stay within `bound` (avoidable returns, passed-by, training gaps, and
	/// split work in every zone).
	/// The judge's guards only (avoidable returns, passed-by) and training gaps: a pickup adds a
	/// stop by nature, so the visit counts (split work, area visits) don't bound it.
	pub fn within_judge(&self, bound: &GuardCounts) -> bool {
		self.avoidable_returns <= bound.avoidable_returns && self.passed_by <= bound.passed_by && self.training_gaps <= bound.training_gaps && self.feedback_within(bound)
	}

	/// The feedback guards (grind after the trip's hand-ins, no training bounce, no elite or
	/// rare camps).
	pub fn feedback_within(&self, bound: &GuardCounts) -> bool {
		self.grind_before_handin <= bound.grind_before_handin && self.train_bounces <= bound.train_bounces && self.elite_rare <= bound.elite_rare
	}

	pub fn within(&self, bound: &GuardCounts) -> bool {
		self.avoidable_returns <= bound.avoidable_returns
			&& self.passed_by <= bound.passed_by
			&& self.training_gaps <= bound.training_gaps
			&& self.feedback_within(bound)
			&& self.split_by_zone.iter().all(|&(z, n)| n <= bound.split_by_zone.iter().find(|x| x.0 == z).map_or(0, |x| x.1))
			&& self.area_visits.iter().all(|&(a, n)| n <= bound.area_visits.iter().find(|x| x.0 == a).map_or(1, |x| x.1))
	}
}

/// The order's walk: who was accepted and turned in when, levels after each step.
struct Walk<'a> {
	run: &'a Run,
	steps: &'a [Step],
	lv_after: Vec<f64>,
	accept_at: Vec<u32>,
	turnin_at: Vec<u32>,
}

const NEVER: u32 = u32::MAX;

impl Walk<'_> {
	fn done_by(&self, q: u32, t: usize) -> bool {
		self.turnin_at[q as usize] as usize <= t && self.turnin_at[q as usize] != NEVER
	}
	fn accepted_by(&self, q: u32, t: usize) -> bool {
		(self.accept_at[q as usize] != NEVER && self.accept_at[q as usize] as usize <= t) || self.done_by(q, t)
	}
	fn in_log_at(&self, q: u32, t: usize) -> bool {
		self.accept_at[q as usize] != NEVER && self.accept_at[q as usize] as usize <= t && !self.done_by(q, t)
	}
	fn ever(&self, q: u32) -> bool {
		self.accept_at[q as usize] != NEVER || self.turnin_at[q as usize] != NEVER
	}
	fn lvl(&self, t: usize) -> f64 {
		self.lv_after.get(t).copied().unwrap_or(1.0)
	}
	/// rules.js acceptableAt: open at the state after step t.
	fn acceptable(&self, q: u32, t: usize) -> bool {
		let r = self.run;
		let qi = q as usize;
		if self.accepted_by(q, t) || self.lvl(t) < r.q_min_level[qi] as f64 {
			return false;
		}
		if r.q_parent[qi] >= 0 && !self.in_log_at(r.q_parent[qi] as u32, t) {
			return false;
		}
		if r.q_excl[qi].iter().any(|&e| self.accepted_by(e, t)) || r.q_all[qi].iter().any(|&a| !self.done_by(a, t)) {
			return false;
		}
		r.q_pre[qi].is_empty() || r.q_pre[qi].iter().any(|&p| self.done_by(p, t))
	}
	fn in_window(&self, q: u32, t: usize) -> bool {
		self.run.q_level[q as usize] as f64 <= self.lvl(t).floor() + ACCEPT_ABOVE
	}
	fn pos(&self, i: usize) -> Option<(i64, f64, f64)> {
		let s = self.steps[i];
		(s.kind != K_GRIND).then(|| {
			let p = s.pt as usize;
			(self.run.p_c[p], self.run.p_x[p], self.run.p_y[p])
		})
	}
	fn pos_of(&self, p: u32) -> Option<(i64, f64, f64)> {
		let p = p as usize;
		Some((self.run.p_c[p], self.run.p_x[p], self.run.p_y[p]))
	}
	fn pt(&self, i: usize) -> Option<u32> {
		let s = self.steps[i];
		(s.kind != K_GRIND).then_some(s.pt)
	}
}

fn dist(a: (i64, f64, f64), b: (i64, f64, f64)) -> f64 {
	if a.0 != b.0 {
		f64::INFINITY
	} else {
		(a.1 - b.1).hypot(a.2 - b.2)
	}
}

/// Count the guards on an order: `lv_before[i]` the level before step i (search Current.lv),
/// `walked[i]` whether the leg into step i was walked.
pub fn guard_counts(g: &GuardData, run: &Run, steps: &[Step], lv_before: &[f64], walked: &[bool]) -> GuardCounts {
	// The judge counts to 60: the steps begun below it.
	let n = lv_before.iter().position(|&l| l >= 60.0).unwrap_or(steps.len()).min(steps.len());
	let steps = &steps[..n];
	let lv_after: Vec<f64> = (0..n).map(|i| lv_before.get(i + 1).copied().unwrap_or_else(|| lv_before.last().copied().unwrap_or(1.0).max(60.0))).collect();
	let mut accept_at = vec![NEVER; run.n_quests()];
	let mut turnin_at = vec![NEVER; run.n_quests()];
	for (i, s) in steps.iter().enumerate() {
		match s.kind {
			K_ACCEPT if accept_at[s.q as usize] == NEVER => accept_at[s.q as usize] = i as u32,
			K_TURNIN if turnin_at[s.q as usize] == NEVER => turnin_at[s.q as usize] = i as u32,
			_ => {}
		}
	}
	let w = Walk { run, steps, lv_after, accept_at, turnin_at };
	let mut c = GuardCounts::default();
	returns(g, &w, &mut c);
	split_work(g, &w, &mut c);
	training_gaps(g, &w, &mut c);
	area_visits(g, &w, &mut c);
	c.grind_before_handin = grind_before_handin(run, steps, &w.lv_after);
	c.train_bounces = train_bounces(run, steps);
	c.elite_rare = elite_rare_count(steps, &g.elite_rare);
	passed_by(g, &w, walked, &mut c, None);
	c
}

/// The quests the order passes by and never takes (passed_by_never), with the step whose leg
/// passes the giver first.
pub fn passed_never(g: &GuardData, run: &Run, steps: &[Step], lv_before: &[f64], walked: &[bool]) -> Vec<(u32, usize)> {
	let n = lv_before.iter().position(|&l| l >= 60.0).unwrap_or(steps.len()).min(steps.len());
	let steps = &steps[..n];
	let lv_after: Vec<f64> = (0..n).map(|i| lv_before.get(i + 1).copied().unwrap_or_else(|| lv_before.last().copied().unwrap_or(1.0).max(60.0))).collect();
	let mut accept_at = vec![NEVER; run.n_quests()];
	let mut turnin_at = vec![NEVER; run.n_quests()];
	for (i, s) in steps.iter().enumerate() {
		match s.kind {
			K_ACCEPT if accept_at[s.q as usize] == NEVER => accept_at[s.q as usize] = i as u32,
			K_TURNIN if turnin_at[s.q as usize] == NEVER => turnin_at[s.q as usize] = i as u32,
			_ => {}
		}
	}
	let w = Walk { run, steps, lv_after, accept_at, turnin_at };
	let mut c = GuardCounts::default();
	let mut out = Vec::new();
	passed_by(g, &w, walked, &mut c, Some(&mut out));
	out
}

fn quest_step(s: &Step) -> bool {
	matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)
}

/// returns.js: visits per area, and each later visit's quest steps judged at the previous
/// visit's departure.
fn returns(g: &GuardData, w: &Walk, c: &mut GuardCounts) {
	let steps = w.steps;
	let n = steps.len();
	// Steps per area, in order.
	let mut by_area: FxHashMap<i32, Vec<usize>> = FxHashMap::default();
	for (i, s) in steps.iter().enumerate() {
		if quest_step(s) {
			let a = g.step_area(w.run, s);
			if a >= 0 {
				by_area.entry(a).or_default().push(i);
			}
		}
	}
	let mut areas: Vec<i32> = by_area.keys().copied().collect();
	areas.sort_unstable();
	for a in areas {
		let idx = &by_area[&a];
		let au = a as usize;
		let near = |j: usize| w.pt(j).is_none_or(|p| g.near_area(au, p));
		// Visits: (first, last, depart, steps).
		let mut visits: Vec<(usize, usize, Vec<usize>)> = Vec::new();
		for &i in idx {
			if let Some(v) = visits.last_mut() {
				if (v.1 + 1..i).all(near) {
					v.1 = i;
					v.2.push(i);
					continue;
				}
			}
			visits.push((i, i, vec![i]));
		}
		if visits.len() < 2 {
			continue;
		}
		let depart = |v: &(usize, usize, Vec<usize>)| {
			let mut d = v.1;
			for j in v.1 + 1..n {
				if !near(j) {
					break;
				}
				d = j;
			}
			d
		};
		for k in 1..visits.len() {
			let d = depart(&visits[k - 1]);
			let v2 = &visits[k];
			let mut avoid = 0;
			for &i in &v2.2 {
				if judge_goal(g, w, i, au, d) {
					avoid += 1;
				}
			}
			if avoid > 0 {
				c.avoidable_returns += 1;
				if avoid == v2.2.len() {
					c.wasted_trips += 1;
				}
			}
		}
	}
}

/// returns.js judgeGoal: whether step i (in area a) could have been done by departure d.
fn judge_goal(g: &GuardData, w: &Walk, i: usize, a: usize, d: usize) -> bool {
	let s = w.steps[i];
	let q = s.q;
	if s.kind == K_ACCEPT {
		return w.acceptable(q, d) && w.in_window(q, d);
	}
	if !obtainable(g, w, q, d, a) || !w.in_window(q, d) {
		return false;
	}
	if s.kind == K_TASK {
		return g.item_here(w.run, s.task as usize, a);
	}
	// A turn-in: every objective step of the quest between d and it in or near this area, its
	// item from here.
	for j in d + 1..i {
		let x = w.steps[j];
		if x.q == q && x.kind == K_TASK {
			if g.step_area(w.run, &x) != a as i32 && !g.near_area(a, x.pt) {
				return false;
			}
			if !g.item_here(w.run, x.task as usize, a) {
				return false;
			}
		}
	}
	true
}

fn obtainable(g: &GuardData, w: &Walk, q: u32, d: usize, a: usize) -> bool {
	if w.in_log_at(q, d) {
		return true;
	}
	let qi = q as usize;
	if w.acceptable(q, d) && g.give_areas[qi].contains(&a) {
		return true;
	}
	if g.pickup[qi].is_empty() {
		return false;
	}
	for t in (0..=d).rev() {
		let Some(p) = w.pt(t) else { continue };
		if g.pickup[qi].binary_search(&p).is_ok() && w.acceptable(q, t) {
			return true;
		}
	}
	false
}

/// passedby.js: the quests the walk goes past (giver within PB_RADIUS of a walked leg) while
/// open and in the window, never taken or taken only after going PB_LEFT away.
fn passed_by(g: &GuardData, w: &Walk, walked: &[bool], c: &mut GuardCounts, mut out: Option<&mut Vec<(u32, usize)>>) {
	let steps = w.steps;
	let mut found: FxHashSet<u32> = FxHashSet::default();
	let mut rejected: FxHashSet<(u32, u32)> = FxHashSet::default();
	let mut prev: Option<usize> = None;
	let mut near: Vec<(f64, f64, u32)> = Vec::new();
	for i in 0..steps.len() {
		let Some(p) = w.pos(i) else { continue };
		let walk = prev.filter(|&j| walked.get(i).copied().unwrap_or(false) && w.pos(j).is_some_and(|x| x.0 == p.0));
		let from = walk.and_then(|j| w.pos(j)).unwrap_or(p);
		let t = walk.unwrap_or(i.saturating_sub(1));
		let lvl = w.lvl(t);
		let len = (p.1 - from.1).hypot(p.2 - from.2);
		let ns = ((len / PB_STEP).ceil() as usize).max(1);
		let k0 = if walk.is_some() { 1 } else { ns };
		for k in k0..=ns {
			let f = k as f64 / ns as f64;
			let (x, y) = (from.1 + (p.1 - from.1) * f, from.2 + (p.2 - from.2) * f);
			near.clear();
			let (cx, cy) = ((x / PB_RADIUS).floor() as i64, (y / PB_RADIUS).floor() as i64);
			for gx in cx - 1..=cx + 1 {
				for gy in cy - 1..=cy + 1 {
					if let Some(v) = g.grid.get(&(p.0, gx, gy)) {
						near.extend(v.iter().filter(|e| (e.0 - x).hypot(e.1 - y) <= PB_RADIUS));
					}
				}
			}
			for &(gx, gy, q) in &near {
				if found.contains(&q) || rejected.contains(&(q, t as u32)) {
					continue;
				}
				let qi = q as usize;
				let mut ok = level_ok(w.run.q_level[qi] as f64, lvl) && w.acceptable(q, t) && !g.closed_by[qi].iter().any(|&x| w.ever(x));
				if ok && w.ever(q) {
					let at = if w.accept_at[qi] != NEVER { w.accept_at[qi] } else { w.turnin_at[qi] } as usize;
					ok = (t + 1..at).any(|j| w.pos(j).is_some_and(|s| dist(s, (p.0, gx, gy)) > PB_LEFT));
				}
				if ok {
					found.insert(q);
					if !w.ever(q) {
						c.passed_by_never += 1;
						if let Some(o) = out.as_deref_mut() {
							o.push((q, t));
						}
					}
				} else {
					rejected.insert((q, t as u32));
				}
			}
		}
		prev = Some(i);
	}
	c.passed_by = found.len() as u32;
}

/// Split work (see GuardCounts::split_work).
fn split_work(_g: &GuardData, w: &Walk, c: &mut GuardCounts) {
	let run = w.run;
	let steps = w.steps;
	let n = steps.len();
	let mut by_zone: FxHashMap<u32, u32> = FxHashMap::default();
	let mut last_counted: Option<usize> = None;
	for i in 0..n {
		let s = steps[i];
		let work = s.kind == K_TASK || (s.kind == K_ACCEPT && run.q_accept[s.q as usize] >= 0) || s.kind == crate::run::K_TRAIN;
		if !work {
			continue;
		}
		let Some(pi) = w.pos(i) else { continue };
		// The latest earlier stop near here with a trip away in between.
		let mut away = false;
		let mut earlier = None;
		for j in (0..i).rev() {
			let Some(pj) = w.pos(j) else { continue };
			let d = dist(pj, pi);
			if d > SPLIT_AWAY {
				away = true;
			} else if away && d <= SPLIT_YD {
				earlier = Some(j);
				break;
			}
		}
		let Some(j) = earlier else { continue };
		let could = if s.kind == crate::run::K_TRAIN {
			w.lvl(j) >= w.lvl(i).floor() - 1.0
		} else {
			let q = s.q;
			let window = w.run.q_level[q as usize] as f64 <= w.lvl(j).floor() + SPLIT_ABOVE;
			window
				&& (w.in_log_at(q, j)
					|| (w.acceptable(q, j) && w.pos_of(run.q_giver[q as usize]).is_some_and(|g| dist(g, pi) <= SPLIT_YD || (0..=j).any(|k| w.pos(k).is_some_and(|pk| dist(pk, g) <= PICKUP)))))
		};
		if !could {
			continue;
		}
		// One count per return visit.
		if last_counted.is_some_and(|l| (l + 1..i).all(|k| w.pos(k).is_none_or(|pk| dist(pk, pi) <= SPLIT_AWAY))) {
			last_counted = Some(i);
			continue;
		}
		last_counted = Some(i);
		c.split_work += 1;
		*by_zone.entry(run.p_map[s.pt as usize]).or_default() += 1;
	}
	let mut v: Vec<(u32, u32)> = by_zone.into_iter().collect();
	v.sort_unstable();
	c.split_by_zone = v;
}

/// Training gaps (see GuardCounts::training_gaps): each time the order is at a trainer town more
/// than TRAIN_GAP levels after the last class training, a training missed (counted, and taken as
/// the last one from there on): dropping or moving a training out of reach raises the count.
fn training_gaps(g: &GuardData, w: &Walk, c: &mut GuardCounts) {
	let mut last = 1.0f64;
	for (i, s) in w.steps.iter().enumerate() {
		let l = w.lvl(i);
		if s.kind == crate::run::K_TRAIN {
			last = l;
		} else if s.kind != K_GRIND && g.near_town[s.pt as usize] && l > last + TRAIN_GAP {
			c.training_gaps += 1;
			last = l;
		}
	}
}

/// Visits per area (see GuardCounts::area_visits).
fn area_visits(g: &GuardData, w: &Walk, c: &mut GuardCounts) {
	let mut n: FxHashMap<u32, u32> = FxHashMap::default();
	let mut last = -1;
	for s in w.steps {
		if !quest_step(s) {
			continue;
		}
		let a = g.step_area(w.run, s);
		if a < 0 {
			continue;
		}
		if a != last {
			*n.entry(a as u32).or_default() += 1;
		}
		last = a;
	}
	let mut v: Vec<(u32, u32)> = n.into_iter().filter(|x| x.1 > 1).collect();
	v.sort_unstable();
	c.area_visits = v;
}

/// Yards and steps of the #617 guard: a hand-in this close to where a grind happens, this few
/// steps after it, is on the same trip.
pub const GRIND_TRIP_YD: f64 = 600.0;
pub const GRIND_TRIP_STEPS: usize = 15;

/// #617: grind steps that level the character while a quest whose work is all done before them
/// is handed in within GRIND_TRIP_STEPS steps, within GRIND_TRIP_YD of where the grind is
/// (its XP would have shortened the grind). `lv_after`: the level after each step.
pub fn grind_before_handin(run: &Run, steps: &[Step], lv_after: &[f64]) -> u32 {
	let n = steps.len().min(lv_after.len());
	let mut last_task = vec![-1i64; run.n_quests()];
	let mut n_bad = 0;
	let mut at: Option<u32> = None;
	for i in 0..n {
		let s = steps[i];
		if s.kind == K_TASK {
			last_task[s.q as usize] = i as i64;
		}
		if s.kind != K_GRIND {
			at = Some(s.pt);
			continue;
		}
		let before = if i == 0 { 1.0 } else { lv_after[i - 1] };
		let (Some(p), true) = (at, lv_after[i] > before + 1e-3) else { continue };
		let bad = (i + 1..(i + 1 + GRIND_TRIP_STEPS).min(n)).any(|j| {
			let t = steps[j];
			t.kind == K_TURNIN && run.straight(p, t.pt) <= GRIND_TRIP_YD && {
				let q = t.q as usize;
				let has_tasks = run.q_task0[q] < run.q_task1[q];
				!has_tasks || (last_task[q] >= 0 && last_task[q] < i as i64 && !steps[i + 1..j].iter().any(|x| x.kind == K_TASK && x.q == t.q))
			}
		});
		if bad {
			n_bad += 1;
		}
	}
	n_bad
}

/// #664/#663: trainings whose town is within TOWN_TRAIN_YD of neither the stop before nor the
/// stop after (a trip made for the trainer, not the next trainer on the way).
pub fn train_bounces(run: &Run, steps: &[Step]) -> u32 {
	let yd = crate::profile::TOWN_TRAIN_YD;
	let mut n = 0;
	for k in 0..steps.len() {
		if steps[k].kind != crate::run::K_TRAIN {
			continue;
		}
		let t = steps[k].pt;
		let prev = steps[..k].iter().rev().find(|x| x.kind != K_GRIND && x.kind != crate::run::K_TRAIN).map(|x| x.pt);
		let next = steps[k + 1..].iter().find(|x| x.kind != K_GRIND && x.kind != crate::run::K_TRAIN).map(|x| x.pt);
		let near = |p: Option<u32>| p.is_some_and(|p| run.straight(p, t) <= yd);
		if !near(prev) && !near(next) {
			n += 1;
		}
	}
	n
}

/// Task steps of the order whose task kills an elite or rare mob.
pub fn elite_rare_count(steps: &[Step], elite_rare: &[bool]) -> u32 {
	steps.iter().filter(|s| s.kind == K_TASK && elite_rare.get(s.task as usize).copied().unwrap_or(false)).count() as u32
}

/// Per run task: a kill objective on an elite (rank 1, 3) or rare (rank 2, 4) mob, or marked elite.
pub fn elite_rare_tasks_of(run: &Run, data: &GameData) -> Vec<bool> {
	(0..run.task_pt.len())
		.map(|t| {
			(run.task_w0[t] as usize..run.task_w1[t] as usize)
				.any(|w| run.w_kind[w] == crate::run::W_KILL && (run.w_elite[w] || data.npcs.get(&run.w_mob[w]).and_then(|n| n.rank).is_some_and(|r| r >= 1.0)))
		})
		.collect()
}
