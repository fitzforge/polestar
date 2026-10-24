//! Passed by (port of the judge's passedby.js): the quests a walk goes past while they are open to the
//! character and does not take then.
//!
//! The walk is replayed on foot: each straight leg between two consecutive positioned goals on one
//! continent is sampled every `step` yards (flights, hearths, boats and continent changes are not
//! walked). At each sample every quest giver within `radius` yards is looked at with the state after
//! the leg's first goal: solo-doable, open by the walk rule (acceptableAt), in the accept window
//! (level_ok), worth XP, not repeatable, not closed by the walk. A quest so found is listed once, at
//! its first passing: 'never done', or 'done later at level N' when the walk takes it only after going
//! more than `left` yards from that giver (or to another continent).

use crate::walk::WalkGoal;
use forge_core::{js_hypot, js_round, js_to_fixed, Frame, Projector};
use forge_world::atlas::SubzoneOf;
use forge_world::data::{Entity, GameData, Quest};
use forge_world::rules::{level_ok, Prereqs, WalkRules};
use rustc_hash::{FxHashMap, FxHashSet};
use serde::Serialize;

pub const NOT_WALKED: [&str; 7] = ["fly", "hearth", "boat", "zeppelin", "portal", "taxi", "die"];
const SPAWN_CAP: usize = 200;

/// One quest passed by.
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Passed {
	pub level: f64,
	pub place: String,
	pub zone: String,
	pub q: u32,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub title: Option<String>,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub q_level: Option<f64>,
	pub min_level: Option<f64>,
	pub giver: String,
	pub dist: f64,
	pub xp: Option<f64>,
	pub status: String,
	pub later_level: Option<f64>,
	#[serde(rename = "ref")]
	pub ref_: String,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct PassedBy {
	pub radius: f64,
	pub count: usize,
	pub never: usize,
	pub later: usize,
	pub xp_never: f64,
	pub list: Vec<Passed>,
}

/// A giver spawn point in world yards.
#[derive(Clone, Debug)]
pub struct GiverPt {
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: u32,
	pub q: u32,
	pub giver: String,
}

/// A record's spawn points (the first `cap` per map) in world yards.
pub fn spawn_points(rec: Option<&Entity>, proj: &Projector, cap: usize) -> Vec<(i64, f64, f64, u32)> {
	let mut out = Vec::new();
	let Some(rec) = rec else { return out };
	for (&map, sp) in &rec.spawns {
		// No frame: the live map (passedby.js read Era).
		let f = sp.f.as_deref().filter(|f| !f.is_empty()).map_or(Some(Frame::Live), Frame::parse);
		for p in sp.pts.iter().chain(sp.more.iter().flatten()).take(cap) {
			let w = proj.point(map, p.first().copied().unwrap_or(f64::NAN), p.get(1).copied().unwrap_or(f64::NAN), f);
			if w.wx.is_finite() {
				out.push((w.c, w.wx, w.wy, map));
			}
		}
	}
	out
}

/// Giver spawn points of every solo-doable quest, in a grid of `cell` yards per continent.
pub struct GiverGrid {
	cell: f64,
	grid: FxHashMap<(i64, i64, i64), Vec<GiverPt>>,
}

impl GiverGrid {
	pub fn new(d: &GameData, proj: &Projector, solo_ok: &dyn Fn(u32) -> bool, cell: f64) -> GiverGrid {
		let mut grid: FxHashMap<(i64, i64, i64), Vec<GiverPt>> = FxHashMap::default();
		let mut add = |pt: (i64, f64, f64, u32), q: u32, giver: &str| {
			let k = (pt.0, (pt.1 / cell).floor() as i64, (pt.2 / cell).floor() as i64);
			grid.entry(k).or_default().push(GiverPt { c: pt.0, wx: pt.1, wy: pt.2, map: pt.3, q, giver: giver.to_string() });
		};
		for (&q, rec) in &d.quests {
			if rec.repeatable == Some(true) || !rec.xp.is_some_and(|x| x != 0.0 && !x.is_nan()) || !solo_ok(q) {
				continue;
			}
			for (list, table, kind) in [(&rec.start.npc, &d.npcs, "npc"), (&rec.start.object, &d.objects, "object")] {
				for &n in list {
					let e = u32::try_from(n).ok().and_then(|i| table.get(&i));
					let name = e.and_then(|e| e.name.clone()).filter(|s| !s.is_empty()).unwrap_or_else(|| format!("{kind} {n}"));
					for pt in spawn_points(e, proj, SPAWN_CAP) {
						add(pt, q, &name);
					}
				}
			}
		}
		GiverGrid { cell, grid }
	}

	/// Giver points within r yards of a point, with their distance (grid order).
	pub fn near(&self, c: i64, wx: f64, wy: f64, r: f64) -> Vec<(&GiverPt, f64)> {
		let mut out = Vec::new();
		let cell = self.cell;
		let (x0, x1) = (((wx - r) / cell).floor() as i64, ((wx + r) / cell).floor() as i64);
		let (y0, y1) = (((wy - r) / cell).floor() as i64, ((wy + r) / cell).floor() as i64);
		for x in x0..=x1 {
			for y in y0..=y1 {
				for e in self.grid.get(&(c, x, y)).into_iter().flatten() {
					let d = js_hypot(e.wx - wx, e.wy - wy);
					if d <= r {
						out.push((e, d));
					}
				}
			}
		}
		out
	}
}

/// A goal's source reference: `file:line` (JS prints a missing line as `undefined`).
pub fn goal_ref(g: &WalkGoal) -> String {
	if g.file.is_empty() {
		format!("goal {}", g.i)
	} else {
		format!("{}:{}", g.file, g.line.map_or_else(|| "undefined".to_string(), |l| l.to_string()))
	}
}

/// `+x.toFixed(1)`.
pub fn fixed1(x: f64) -> f64 {
	js_to_fixed(x, 1).parse().unwrap_or(f64::NAN)
}

/// zones.json name of a uiMapID, else `map <id>`.
pub fn zone_name(d: &GameData, m: u32) -> String {
	d.zones.get(&m).and_then(|z| z.name.clone()).filter(|s| !s.is_empty()).unwrap_or_else(|| format!("map {m}"))
}

struct Found {
	q: u32,
	lvl: f64,
	dist: f64,
	giver: String,
	gpt: (i64, f64, f64, u32),
	g: usize,
	open: bool,
}

/// The settings passedBy defaults to.
#[derive(Clone, Copy, Debug)]
pub struct Opts {
	pub radius: f64,
	pub step: f64,
	pub left: f64,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { radius: 500.0, step: 50.0, left: 1000.0 }
	}
}

/// passedBy({ goals, quests, npcs, objects, proj, soloOk, prereqsOf, subzone, radius, step, left, zoneName }).
pub fn passed_by(
	goals: &[WalkGoal],
	d: &GameData,
	proj: &Projector,
	solo_ok: &dyn Fn(u32) -> bool,
	prereqs_of: Option<&dyn Fn(&Quest) -> Prereqs>,
	subzone: Option<&dyn SubzoneOf>,
	o: Opts,
) -> PassedBy {
	let rg = crate::walk::rule_goals(goals);
	let rules = WalkRules::new(&rg, &d.quests);
	let grid = GiverGrid::new(d, proj, solo_ok, o.radius);
	let mut found: Vec<Found> = Vec::new();
	let mut found_at: FxHashMap<u32, usize> = FxHashMap::default();
	let mut rejected: FxHashSet<(u32, usize)> = FxHashSet::default();
	let mut prev: Option<&WalkGoal> = None;
	let mut open: Vec<usize> = Vec::new();
	let taken_at = |q: i64| rules.accept_at.get(&q).or_else(|| rules.turnin_at.get(&q)).copied();
	for g in goals {
		let Some(gw) = g.w else { continue };
		let walked = prev.is_some_and(|p| p.w.unwrap().c == gw.c) && !NOT_WALKED.contains(&g.t.as_str());
		let from = if walked { prev.unwrap().w.unwrap() } else { gw };
		let t = if walked { prev.unwrap().i } else { g.i.saturating_sub(1) };
		let l = rules.lvl_at(t);
		let len = js_hypot(gw.wx - from.wx, gw.wy - from.wy);
		let n = ((len / o.step).ceil() as usize).max(1);
		for k in (if walked { 1 } else { n })..=n {
			let (kf, nf) = (k as f64, n as f64);
			let (px, py) = (from.wx + ((gw.wx - from.wx) * kf) / nf, from.wy + ((gw.wy - from.wy) * kf) / nf);
			let mut seen: Vec<u32> = Vec::new();
			for (e, dd) in grid.near(gw.c, px, py, o.radius) {
				if let Some(&fi) = found_at.get(&e.q) {
					let have = &mut found[fi];
					if have.open {
						if !seen.contains(&e.q) {
							seen.push(e.q);
						}
						if dd < have.dist {
							have.dist = dd;
							have.giver = e.giver.clone();
							have.gpt = (e.c, e.wx, e.wy, e.map);
							have.g = g.i;
						}
					}
					continue;
				}
				if rejected.contains(&(e.q, t)) {
					continue;
				}
				let rec = &d.quests[&e.q];
				let qi = i64::from(e.q);
				let mut ok = level_ok(rec.level.unwrap_or(0.0), l) && rules.acceptable_at(qi, t, prereqs_of).is_ok() && !rules.closed_by_walk(qi);
				if ok && rules.ever(qi) {
					let a = taken_at(qi).unwrap();
					let mut away = false;
					let mut j = t + 1;
					while j < a && !away {
						if let Some(w) = goals[j].w {
							if w.c != e.c || js_hypot(w.wx - e.wx, w.wy - e.wy) > o.left {
								away = true;
							}
						}
						j += 1;
					}
					ok = away;
				}
				if !ok {
					rejected.insert((e.q, t));
					continue;
				}
				found_at.insert(e.q, found.len());
				found.push(Found { q: e.q, lvl: l, dist: dd, giver: e.giver.clone(), gpt: (e.c, e.wx, e.wy, e.map), g: g.i, open: true });
				if !seen.contains(&e.q) {
					seen.push(e.q);
				}
			}
			for &f in &open {
				if !seen.contains(&found[f].q) {
					found[f].open = false;
				}
			}
			let mut next: Vec<usize> = open.iter().copied().filter(|&f| found[f].open).collect();
			for q in &seen {
				let f = found_at[q];
				if found[f].open && !open.contains(&f) {
					next.push(f);
				}
			}
			open = next;
		}
		prev = Some(g);
	}
	let mut list: Vec<Passed> = found
		.iter()
		.map(|f| {
			let rec = &d.quests[&f.q];
			let a = taken_at(i64::from(f.q));
			let sz = subzone.and_then(|s| s.at(f.gpt.0, f.gpt.1, f.gpt.2));
			let zone = zone_name(d, f.gpt.3);
			let truthy = |x: Option<f64>| x.filter(|v| *v != 0.0 && !v.is_nan());
			Passed {
				level: fixed1(f.lvl),
				place: sz.map_or_else(|| zone.clone(), |s| s.name),
				zone,
				q: f.q,
				title: rec.title.clone(),
				q_level: rec.level,
				min_level: truthy(rec.min_level),
				giver: f.giver.clone(),
				dist: js_round(f.dist),
				xp: truthy(rec.xp),
				status: a.map_or_else(|| "never done".to_string(), |a| format!("done later at level {}", js_to_fixed(rules.lvl_at(a), 1))),
				later_level: a.map(|a| fixed1(rules.lvl_at(a))),
				ref_: goal_ref(&goals[f.g]),
			}
		})
		.collect();
	list.sort_by(|a, b| a.level.total_cmp(&b.level).then(a.dist.total_cmp(&b.dist)));
	let never: Vec<&Passed> = list.iter().filter(|x| x.later_level.is_none()).collect();
	PassedBy { radius: o.radius, count: list.len(), never: never.len(), later: list.len() - never.len(), xp_never: never.iter().map(|x| x.xp.unwrap_or(0.0)).sum(), list }
}
