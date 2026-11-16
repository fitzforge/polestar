//! Level fit (docs/forge/writer.md, "Work at the player's level"): quest work whose target or ground is
//! too far above the player's predicted level where the route has it goes to the route's later visit to
//! the same place where it fits, else the quest is left out.
//!
//! The predicted level is the route's own (`lvl` on each event, the planner's model). A task fits a
//! player of level P (the level rounded down) when its easiest target is at most P + 2 (an elite at
//! most P + 1) and the ground it sends the player into is too: the median level of the attackable
//! mobs within [`AREA_YD`] of the task's target spawns around the route's work point (each spawn spread
//! evenly over its levels) at most P + 2. Fyurie's Redridge (#977): Lieutenant Fangore (26) and the
//! Shadowhide gnolls of Galardell Valley (median 24) at 21.4.

use crate::input::{Data, Entity, Order, OrderT, Pt, World};
use forge_core::frames::{Frame, MapFrames, Projector};
use forge_core::jsnum::js_hypot;
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;

/// The mobs around a target spawn that make up the ground the player walks into.
pub const AREA_YD: f64 = 100.0;
/// The target spawns that count for a task: those this near the route's work point.
pub const GROUND_YD: f64 = 300.0;
/// A later route event this near the work point is a visit to the same place.
pub const VISIT_YD: f64 = 250.0;
/// A later route event this near a giver or ender stands at that NPC.
pub const NPC_YD: f64 = 120.0;
/// Fewer mobs than this around the targets: no ground level (a lone named mob).
const AREA_MIN: usize = 5;
/// Levels a target may be above the player (an elite: one less).
const TARGET_GAP: i64 = 2;
/// Levels the ground's median may be above the player.
const AREA_GAP: i64 = 2;
/// Levels the player may be over the quest at the later visit: past this the quest no longer pays its
/// full XP (forge-sim's SHARE).
const QUEST_OVER: i64 = 5;

/// What the rule did to the order.
#[derive(Debug, Default)]
pub struct Fit {
	pub order: Vec<Order>,
	/// The quests left out (with the quests after them in their chains).
	pub left_out: Vec<u32>,
	/// One line per decision (`level fit: ...`).
	pub log: Vec<String>,
}

/// The quests the rule leaves alone: the route's group families (taken with a solo fallback), the
/// route fixes' optional quests (written optional) and the quests the route fixes keep or include.
#[derive(Default)]
pub struct Exempt {
	pub quests: FxHashSet<u32>,
}

/// A spawn of an attackable mob: world place and its levels.
#[derive(Clone, Copy)]
struct Mob {
	c: i64,
	wx: f64,
	wy: f64,
	npc: u32,
	lo: i64,
	hi: i64,
}

const CELL: f64 = 100.0;

struct Grid {
	cells: FxHashMap<(i64, i64, i64), Vec<Mob>>,
}

impl Grid {
	fn near(&self, c: i64, wx: f64, wy: f64, r: f64, out: &mut Vec<Mob>) {
		let (x0, x1) = (((wx - r) / CELL).floor() as i64, ((wx + r) / CELL).floor() as i64);
		let (y0, y1) = (((wy - r) / CELL).floor() as i64, ((wy + r) / CELL).floor() as i64);
		for gx in x0..=x1 {
			for gy in y0..=y1 {
				if let Some(v) = self.cells.get(&(c, gx, gy)) {
					out.extend(v.iter().filter(|m| js_hypot(m.wx - wx, m.wy - wy) <= r));
				}
			}
		}
	}
}

/// An attackable mob: no faction, level 2 or more, no title or service (a vendor, trainer or guard of a
/// neutral town has them).
fn attackable(e: &Entity) -> bool {
	e.faction.as_deref().is_none_or(str::is_empty) && e.level.is_some_and(|l| l >= 2.0) && e.sub_name.as_deref().is_none_or(str::is_empty) && e.roles.iter().all(|r| r == "rare")
}

fn levels(e: &Entity) -> (i64, i64) {
	let lo = e.level.unwrap_or(0.0) as i64;
	let hi = e.level_max.map_or(lo, |h| h as i64);
	// (A range wider than 5 is a data slip, Rabid Longtooth's 8-48: its lowest.)
	(lo, if hi < lo || hi - lo > 5 { lo } else { hi })
}

fn grid(data: &Data, proj: &Projector) -> Grid {
	let mut cells: FxHashMap<(i64, i64, i64), Vec<Mob>> = FxHashMap::default();
	for (&npc, e) in &data.npcs {
		if !attackable(e) {
			continue;
		}
		let (lo, hi) = levels(e);
		for (&map, sp) in &e.spawns {
			let f = if sp.f.as_deref() == Some("l") { Frame::Live } else { Frame::Era };
			for q in &sp.pts {
				let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(f64::NAN));
				let w = proj.point(map, c(0), c(1), Some(f));
				if w.wx.is_finite() && w.wy.is_finite() {
					cells.entry((w.c, (w.wx / CELL).floor() as i64, (w.wy / CELL).floor() as i64)).or_default().push(Mob { c: w.c, wx: w.wx, wy: w.wy, npc, lo, hi });
				}
			}
		}
	}
	Grid { cells }
}

/// The median level of mobs, each spread evenly over its levels (a 23-24 gnoll is half 23, half 24).
fn median_level(mobs: &[Mob]) -> Option<i64> {
	let mut w: std::collections::BTreeMap<i64, f64> = std::collections::BTreeMap::new();
	for m in mobs {
		let n = (m.hi - m.lo + 1) as f64;
		for l in m.lo..=m.hi {
			*w.entry(l).or_default() += 1.0 / n;
		}
	}
	let half = w.values().sum::<f64>() / 2.0;
	let mut acc = 0.0;
	for (l, x) in w {
		acc += x;
		if acc >= half - 1e-9 {
			return Some(l);
		}
	}
	None
}

/// What a task asks of the player: its easiest target's level, whether that is an elite, and the
/// ground's median level.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Need {
	pub target: i64,
	pub elite: bool,
	pub area: Option<i64>,
}

impl Need {
	/// The task fits a player of this (fractional) level.
	pub fn fits(&self, lvl: f64) -> bool {
		let p = lvl.floor() as i64;
		self.target <= p + TARGET_GAP - i64::from(self.elite) && self.area.is_none_or(|a| a <= p + AREA_GAP)
	}
}

/// The level reads of a route's world and data (built once per route: the level fit and the pass-by
/// rule read them).
pub(crate) struct Ctx<'a> {
	pub(crate) world: &'a World,
	pub(crate) data: &'a Data,
	grid: Grid,
	/// World quest by id.
	pub(crate) wq: FxHashMap<u32, usize>,
}

impl<'a> Ctx<'a> {
	pub(crate) fn new(world: &'a World, data: &'a Data, frames: &MapFrames) -> Self {
		let proj = Projector::new(frames);
		Ctx { world, data, grid: grid(data, &proj), wq: world.quests.iter().enumerate().map(|(i, q)| (q.id, i)).collect() }
	}

	pub(crate) fn pt(&self, o: &Order) -> Option<Pt> {
		self.world.points.get(o.pt? as usize).copied().filter(|p| p.wx.is_finite())
	}

	fn near(a: Option<Pt>, b: Option<Pt>, yd: f64) -> bool {
		matches!((a, b), (Some(a), Some(b)) if a.c == b.c && js_hypot(a.wx - b.wx, a.wy - b.wy) <= yd)
	}

	/// The kill work of a task: (level, count, npc) per `["kill", level, count, _, _, npc]`.
	fn kills(&self, q: u32, t: Option<u32>) -> Vec<(f64, f64, u32)> {
		let Some(task) = self.wq.get(&q).and_then(|&i| self.world.quests[i].tasks.as_ref()).and_then(|ts| ts.get(t? as usize)) else { return Vec::new() };
		task.work
			.iter()
			.filter(|w| w.first().and_then(Value::as_str) == Some("kill"))
			.filter_map(|w| Some((w.get(1)?.as_f64()?, w.get(2).and_then(Value::as_f64).unwrap_or(0.0), w.get(5)?.as_u64()? as u32)))
			.collect()
	}

	/// The NPCs whose kills count for a task: its kill work's, its kill objectives' and its items' droppers.
	fn sources(&self, q: u32, t: u32) -> FxHashSet<u32> {
		let mut ids: FxHashSet<u32> = self.kills(q, Some(t)).into_iter().map(|k| k.2).collect();
		if let Some(&wi) = self.wq.get(&q) {
			for o in self.world.quests[wi].objs.iter().filter(|o| o.task == Some(t)) {
				let Some(id) = o.id.map(|x| x as u32) else { continue };
				match o.kind.as_deref() {
					Some("kill") => {
						ids.insert(id);
					}
					Some("item") => ids.extend(self.data.items.get(&id).and_then(|i| i.drops.as_ref()).into_iter().flat_map(|d| d.npc.keys().copied())),
					_ => {}
				}
			}
		}
		ids
	}

	/// What task `t` of quest `q` worked at `pt` asks (None: no kill work, or none of its targets near).
	pub(crate) fn need(&self, q: u32, t: Option<u32>, pt: Option<Pt>) -> Option<Need> {
		let (t, pt) = (t?, pt?);
		if self.kills(q, Some(t)).is_empty() {
			return None;
		}
		let ids = self.sources(q, t);
		let mut near = Vec::new();
		self.grid.near(pt.c, pt.wx, pt.wy, GROUND_YD, &mut near);
		let targets: Vec<Mob> = near.into_iter().filter(|m| ids.contains(&m.npc)).collect();
		let easiest = targets.iter().min_by_key(|m| (m.lo, m.npc))?;
		let elite = self.data.npcs.get(&easiest.npc).and_then(|e| e.rank).is_some_and(|r| r == 1.0 || r == 2.0);
		let mut ground: FxHashMap<(i64, i64, u32), Mob> = FxHashMap::default();
		let mut around = Vec::new();
		for m in &targets {
			around.clear();
			self.grid.near(m.c, m.wx, m.wy, AREA_YD, &mut around);
			for a in &around {
				// (A mob ten levels over the target is another place's: a boss in its tower, the Unseen.)
				if a.lo < easiest.lo + 10 {
					ground.insert(((a.wx * 10.0) as i64, (a.wy * 10.0) as i64, a.npc), *a);
				}
			}
		}
		let ground: Vec<Mob> = ground.into_values().collect();
		let area = if ground.len() >= AREA_MIN { median_level(&ground) } else { None };
		Some(Need { target: easiest.lo, elite, area })
	}

	fn quest_level(&self, q: u32) -> Option<i64> {
		self.data.quests.get(&q).and_then(|r| r.level).map(|l| l as i64)
	}

	/// Quest `x` can no longer be done without the quests in `gone`: one of its required quests is
	/// gone, or all of its one-of quests are (the world's `pre`, a negative id one of several; else
	/// the data's `pre` and `preAny`).
	fn needs(&self, x: u32, gone: &FxHashSet<u32>) -> bool {
		let (mut req, mut any): (Vec<u32>, Vec<u32>) = (Vec::new(), Vec::new());
		if let Some(ps) = self.wq.get(&x).and_then(|&i| self.world.quests[i].pre.as_ref()) {
			for &p in ps {
				if p < 0 {
					any.push(p.unsigned_abs() as u32)
				} else {
					req.push(p as u32)
				}
			}
		} else if let Some(r) = self.data.quests.get(&x) {
			for v in r.pre.iter().flatten().filter_map(Value::as_f64) {
				if v < 0.0 {
					any.push(v.abs() as u32)
				} else {
					req.push(v as u32)
				}
			}
			any.extend(r.pre_any.iter().flatten().filter_map(Value::as_f64).map(|v| v.abs() as u32));
		}
		req.iter().any(|p| gone.contains(p)) || (!any.is_empty() && any.iter().all(|p| gone.contains(p)))
	}
}

pub(crate) fn total_xp(lvl: f64) -> f64 {
	let f = (lvl.floor() as usize).clamp(1, 60);
	let below: f64 = forge_sim::xp::LEVEL_XP[1..f].iter().sum();
	below + if f < 60 { (lvl - f as f64) * forge_sim::xp::LEVEL_XP[f] } else { 0.0 }
}

pub(crate) fn level_of(mut xp: f64) -> f64 {
	let mut l = 1;
	while l < 60 && xp >= forge_sim::xp::LEVEL_XP[l] {
		xp -= forge_sim::xp::LEVEL_XP[l];
		l += 1;
	}
	l as f64 + if l < 60 { xp / forge_sim::xp::LEVEL_XP[l] } else { 0.0 }
}

pub(crate) fn name(data: &Data, q: u32) -> String {
	data.quests.get(&q).and_then(|r| r.title()).map_or_else(|| q.to_string(), |t| format!("{t} ({q})"))
}

/// The rule on a route's order.
pub fn fit(order: Vec<Order>, world: &World, data: &Data, frames: &MapFrames, exempt: &Exempt) -> Fit {
	fit_in(order, &Ctx::new(world, data, frames), exempt)
}

/// [`fit`] on level reads built for the route.
pub(crate) fn fit_in(order: Vec<Order>, cx: &Ctx, exempt: &Exempt) -> Fit {
	let data = cx.data;
	let mut o = order;
	let mut log = Vec::new();
	let mut left_out: Vec<u32> = Vec::new();
	let lvl = |e: &Order| e.lvl.unwrap_or(0.0);
	// (An event with no level, an old route's, is not judged.)
	let judged = |e: &Order| e.t == OrderT::Task && e.lvl.is_some() && e.q.is_some_and(|q| !exempt.quests.contains(&q));
	// The planner's grind inside a task (its level step beyond the XP of the kills it counts: the
	// model grinds to the work's level - 3 first), which the guide never writes.
	let grind = |o: &[Order], m: usize| -> f64 {
		let e = &o[m];
		let Some(next) = o.get(m + 1).map(lvl) else { return 0.0 };
		let p = lvl(e).floor() as i64;
		let kills: f64 = cx
			.kills(e.q.unwrap_or(0), e.task)
			.iter()
			.map(|&(l, n, npc)| n * forge_sim::xp::mob_xp(p, l as i64, data.npcs.get(&npc).and_then(|x| x.rank).is_some_and(|r| r == 1.0 || r == 2.0), true))
			.sum();
		(total_xp(next) - total_xp(lvl(e)) - kills).max(0.0)
	};
	// Each task's grind once the rule takes the task away from where the route has it: a later level is
	// read without the grinds inside the work it takes out on the way.
	let mut grinds: FxHashMap<(u32, Option<u32>), f64> = FxHashMap::default();
	for m in 0..o.len() {
		let e = &o[m];
		if judged(e) && cx.need(e.q.unwrap_or(0), e.task, cx.pt(e)).is_some_and(|n| !n.fits(lvl(e))) {
			grinds.insert((e.q.unwrap_or(0), e.task), grind(&o, m));
		}
	}
	let mut done: FxHashSet<(u32, Option<u32>)> = FxHashSet::default();
	let mut i = 0;
	while i < o.len() {
		let e = &o[i];
		if !judged(e) || done.contains(&(e.q.unwrap_or(0), e.task)) {
			i += 1;
			continue;
		}
		let (q, t, p) = (e.q.unwrap_or(0), e.task, cx.pt(e));
		let Some(need) = cx.need(q, t, p).filter(|n| !n.fits(lvl(e))) else {
			i += 1;
			continue;
		};
		done.insert((q, t));
		let here = lvl(e);
		// The route's later visit to the place where the task fits, while the quest still pays full XP.
		let qlvl = cx.quest_level(q);
		let mut j = None;
		let mut g = 0.0;
		for (k, x) in o.iter().enumerate().skip(i) {
			if let (Some(xq), OrderT::Task) = (x.q, x.t) {
				g += grinds.get(&(xq, x.task)).copied().unwrap_or(0.0);
			}
			if k == i || !Ctx::near(cx.pt(x), p, VISIT_YD) {
				continue;
			}
			let at = level_of((total_xp(lvl(x)) - g).max(0.0));
			if qlvl.is_none_or(|ql| (at.floor() as i64) <= ql + QUEST_OVER) && cx.need(q, t, p).is_some_and(|n| n.fits(at)) {
				j = Some(k);
				break;
			}
		}
		let mut why = if j.is_none() { Some("no later visit there at a level that fits") } else { None };
		// Its hand-in after it: at the route's next stop by the ender after that visit, with the
		// follow-ups taken right after it at the ender; another event of a follow-up before then fails.
		let ti = o.iter().enumerate().skip(i + 1).find(|(_, x)| x.t == OrderT::Turnin && x.q == Some(q)).map(|(k, _)| k);
		let mut kt = None;
		let mut carry: Vec<usize> = Vec::new();
		let just_q: FxHashSet<u32> = FxHashSet::from_iter([q]);
		if let (Some(jj), Some(tt)) = (j, ti) {
			// (The later visit may be the hand-in itself: the hand-in then waits for the next stop too.)
			if tt <= jj {
				let pe = cx.pt(&o[tt]);
				kt = (jj + 1..o.len()).find(|&k| Ctx::near(cx.pt(&o[k]), pe, NPC_YD));
				let mut m = tt + 1;
				while m < o.len() && o[m].t == OrderT::Accept && Ctx::near(cx.pt(&o[m]), pe, NPC_YD) && o[m].q.is_some_and(|x| cx.needs(x, &just_q)) {
					carry.push(m);
					m += 1;
				}
				if let Some(k) = kt {
					if (tt + 1..=k).any(|m| !carry.contains(&m) && o[m].q.is_some_and(|x| cx.needs(x, &just_q))) {
						why = Some("a follow-up comes before its later hand-in");
					}
				} else {
					why = Some("no later stop by its ender");
				}
			}
		}
		let gap = format!("target {}{} at {:.1}{}", need.target, if need.elite { " elite" } else { "" }, here, need.area.map_or(String::new(), |a| format!(", ground {a}")));
		if let Some(why) = why {
			// Left out, with every quest after it in its chain.
			let mut gone: FxHashSet<u32> = FxHashSet::from_iter([q]);
			loop {
				let more: FxHashSet<u32> = o.iter().filter_map(|x| x.q).filter(|x| !gone.contains(x) && cx.needs(*x, &gone)).collect();
				if more.is_empty() {
					break;
				}
				gone.extend(more);
			}
			let mut chain: Vec<u32> = gone.iter().copied().filter(|&x| x != q).collect();
			chain.sort_unstable();
			log.push(format!(
				"level fit: {} left out ({gap}; {why}){}",
				name(data, q),
				if chain.is_empty() { String::new() } else { format!(", and after it {}", chain.iter().map(|&x| name(data, x)).collect::<Vec<_>>().join(", ")) }
			));
			let mut gone_sorted: Vec<u32> = gone.iter().copied().collect();
			gone_sorted.sort_unstable();
			left_out.extend(gone_sorted);
			let removed_before = o[..i].iter().filter(|x| x.q.is_some_and(|x| gone.contains(&x))).count();
			o.retain(|x| !x.q.is_some_and(|x| gone.contains(&x)));
			i -= removed_before;
			continue;
		}
		let jj = j.unwrap_or(i);
		let anchor_desc = |x: &Order| format!("{:?} {}", x.t, x.q.map_or_else(String::new, |q| name(data, q))).to_lowercase();
		let mut line = format!("level fit: {} task {} moved after {} ({gap}; fits there at {:.1})", name(data, q), t.map_or(0, |t| t + 1), anchor_desc(&o[jj]), lvl(&o[jj]));
		// The accept goes with it when the route stands by its giver again on the way there, and no other
		// event of the quest that stays where it is comes before that stop: Mazzranache's scales, kept with
		// Poison Water's talons, came before the accept the gizzards took along (0.4.0, Tauren).
		let ai = (0..i).find(|&k| o[k].t == OrderT::Accept && o[k].q == Some(q));
		let mut moving: Vec<usize> = vec![i];
		let skip: FxHashSet<usize> = ti.filter(|_| kt.is_some()).into_iter().chain(carry.iter().copied()).collect();
		let acc_anchor = ai.and_then(|a| {
			let pa = cx.pt(&o[a]);
			let first_staying = (a + 1..o.len()).find(|&k| k != i && !skip.contains(&k) && o[k].q == Some(q)).unwrap_or(o.len());
			(i + 1..=jj).rev().find(|&k| k < first_staying && !skip.contains(&k) && Ctx::near(cx.pt(&o[k]), pa, NPC_YD))
		});
		if let (Some(a), Some(_)) = (ai, acc_anchor) {
			moving.push(a);
		}
		if kt.is_some() {
			moving.extend(ti);
			moving.extend(carry.iter().copied());
		}
		// Take the moving events out, then put each after its anchor (indices from before the take).
		let task_ev = o[i].clone();
		let acc_ev = ai.filter(|_| acc_anchor.is_some()).map(|a| o[a].clone());
		let tail_evs: Vec<Order> = if kt.is_some() { ti.into_iter().chain(carry.iter().copied()).map(|k| o[k].clone()).collect() } else { Vec::new() };
		let mut keep: Vec<Option<Order>> = o.drain(..).map(Some).collect();
		for &k in &moving {
			keep[k] = None;
		}
		// (Insert from the last anchor back, so earlier anchors keep their index.)
		let mut inserts: Vec<(usize, Vec<Order>)> = vec![(jj, vec![Order { lvl: o_lvl(&keep, jj), ..task_ev }])];
		if let (Some(a), Some(ev)) = (acc_anchor, acc_ev) {
			inserts.push((a, vec![ev]));
			line.push_str(", its accept with it");
		}
		if let Some(k) = kt {
			let l = o_lvl(&keep, k);
			inserts.push((k, tail_evs.into_iter().map(|x| Order { lvl: l, ..x }).collect()));
			line.push_str(", its hand-in at the next stop by its ender");
		}
		inserts.sort_by_key(|x| std::cmp::Reverse(x.0));
		let mut out: Vec<Order> = Vec::with_capacity(keep.len());
		let mut by_anchor: FxHashMap<usize, Vec<Order>> = FxHashMap::default();
		for (k, evs) in inserts {
			by_anchor.entry(k).or_default().extend(evs);
		}
		let mut next_i = None;
		for (k, slot) in keep.into_iter().enumerate() {
			if let Some(x) = slot {
				if k > i && next_i.is_none() {
					next_i = Some(out.len());
				}
				out.push(x);
			}
			if let Some(evs) = by_anchor.remove(&k) {
				out.extend(evs);
			}
		}
		o = out;
		log.push(line);
		i = next_i.unwrap_or(o.len());
	}
	Fit { order: o, left_out, log }
}

fn o_lvl(keep: &[Option<Order>], k: usize) -> Option<f64> {
	keep.get(k).and_then(|x| x.as_ref()).and_then(|x| x.lvl)
}
