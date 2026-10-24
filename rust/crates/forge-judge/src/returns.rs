//! Avoidable returns (port of the judge's returns.js): a walk comes back to an area for quest work it
//! could have done on its last visit there.
//!
//! Areas are the quest atlas's; each quest goal sits in the area of its own giver, ender or objective
//! camp (`Atlas::locate`). A visit to an area is its goals up to the walk going more than AWAY yards
//! from the area's camps; the departure is the last goal before that. Each quest goal of a later visit
//! is judged against the state at the previous visit's departure (accept: open and in the accept
//! window; objective/turn-in: obtainable by then, in the window, its item from this area, a turn-in's
//! objectives worked here). Also: quests left behind (open at a departure, never taken) and the same
//! mob camp worked twice.

use crate::passedby::{fixed1, goal_ref};
use crate::walk::WalkGoal;
use forge_core::{js_hypot, js_to_fixed, js_to_string};
use forge_world::atlas::{Atlas, GoalAt};
use forge_world::data::{GameData, Quest};
use forge_world::rules::{level_ok, Prereqs, WalkRules, ACCEPT_ABOVE};
use rustc_hash::FxHashMap;
use serde::Serialize;

pub const AWAY: f64 = 400.0;
pub const PICKUP: f64 = 300.0;
pub const RUN_YPS: f64 = 7.0;
pub const EXAMPLES: usize = 15;
const WORK: [&str; 8] = ["kill", "collect", "interact", "use", "complete", "talk", "escort", "explore"];
const SERVICE: [&str; 7] = ["train", "vendor", "sethome", "getfp", "repair", "learn", "buy"];

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Summary {
	pub avoidable_returns: usize,
	pub wasted_trips: usize,
	pub avoidable_goals: usize,
	pub extra_minutes: f64,
	pub left_behind: usize,
	pub same_mob_avoidable: usize,
	pub area_visits: usize,
	pub returns: usize,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct AreaRow {
	pub area: String,
	pub zone: String,
	pub visits: usize,
	pub avoidable_returns: usize,
	pub wasted_trips: usize,
	pub avoidable_goals: usize,
	pub extra_minutes: f64,
}

#[derive(Clone, Debug, Serialize)]
pub struct Visit1 {
	pub levels: String,
	pub quests: Vec<String>,
	pub from: String,
	pub to: String,
}

#[derive(Clone, Debug, Serialize)]
pub struct JudgedGoal {
	pub t: String,
	pub q: Option<i64>,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub title: Option<String>,
	pub avoidable: bool,
	pub why: String,
	#[serde(rename = "ref")]
	pub ref_: String,
}

#[derive(Clone, Debug, Serialize)]
pub struct Visit2 {
	pub levels: String,
	pub from: String,
	pub to: String,
	pub goals: Vec<JudgedGoal>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Example {
	pub area: String,
	pub zone: String,
	pub wasted: bool,
	pub extra_minutes: Option<f64>,
	pub v1: Visit1,
	pub v2: Visit2,
	pub why: Option<String>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LeftBehind {
	pub q: u32,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub title: Option<String>,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub level: Option<f64>,
	pub xp: Option<f64>,
	pub area: String,
	pub zone: String,
	pub at_level: f64,
	#[serde(rename = "ref")]
	pub ref_: String,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SameMob {
	pub mob: String,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub area: Option<String>,
	pub first: String,
	pub second: String,
	pub first_level: f64,
	pub second_level: f64,
	pub why: String,
	pub ref_first: String,
	pub ref_second: String,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Returns {
	pub summary: Summary,
	pub areas: Vec<AreaRow>,
	pub examples: Vec<Example>,
	pub left_behind: Vec<LeftBehind>,
	pub same_mob: Vec<SameMob>,
}

struct Visit {
	idx: Vec<usize>,
	first: usize,
	last: usize,
	depart: usize,
}

struct Ret {
	a: usize,
	v1: (usize, usize),
	v2: (usize, usize),
	judged: Vec<(usize, bool, String)>,
	avoidable: usize,
	wasted: bool,
	extra_yd: Option<f64>,
}

type Pt = Option<(i64, f64, f64)>;

fn dist(a: Pt, b: Pt) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.0 == b.0 => js_hypot(a.1 - b.1, a.2 - b.2),
		_ => f64::INFINITY,
	}
}

fn pt(g: &WalkGoal) -> Pt {
	g.w.map(|w| (w.c, w.wx, w.wy))
}

/// avoidableReturns({ goals, atlas, quests, soloOk, prereqsOf, examples }).
pub fn avoidable_returns(goals: &[WalkGoal], atlas: &Atlas, d: &GameData, solo_ok: &dyn Fn(u32) -> bool, prereqs_of: Option<&dyn Fn(&Quest) -> Prereqs>, examples: usize) -> Returns {
	let rg = crate::walk::rule_goals(goals);
	let rules = WalkRules::new(&rg, &d.quests);
	let qrec = |q: i64| u32::try_from(q).ok().and_then(|i| d.quests.get(&i));
	let title = |q: i64| format!("{} [{q}]", qrec(q).and_then(|r| r.title.clone()).filter(|t| !t.is_empty()).unwrap_or_else(|| q.to_string()));
	let qlevel = |q: i64| qrec(q).and_then(|r| r.level);
	let qlevel_s = |q: i64| qlevel(q).map_or_else(|| "undefined".to_string(), js_to_string);
	let area_name = |a: Option<usize>| a.map(|a| atlas.areas[a].name.clone());
	let fx = |x: f64| js_to_fixed(x, 1);
	let is_quest_goal = |g: &WalkGoal| g.q.is_some() && g.w.is_some() && (g.t == "accept" || g.t == "turnin" || WORK.contains(&g.t.as_str()));
	let garea: Vec<Option<usize>> = goals
		.iter()
		.map(|g| {
			if !is_quest_goal(g) {
				return None;
			}
			let w = g.w.unwrap();
			atlas.locate(&GoalAt { q: g.q.and_then(|q| u32::try_from(q).ok()), t: g.t.clone(), oi: g.oi.and_then(|o| usize::try_from(o).ok()), c: w.c, wx: w.wx, wy: w.wy })
		})
		.collect();
	// Work goals per quest, in first-seen quest order (rules.js walkIndex insertion order).
	let mut work_order: Vec<i64> = Vec::new();
	for q in goals.iter().filter(|g| WORK.contains(&g.t.as_str())).filter_map(|g| g.q) {
		if !work_order.contains(&q) {
			work_order.push(q);
		}
	}
	let work = |q: i64| rules.work.get(&q).map_or(&[][..], Vec::as_slice);

	// ---- visits ----
	let mut by_area: Vec<(usize, Vec<usize>)> = Vec::new();
	let mut area_pos: FxHashMap<usize, usize> = FxHashMap::default();
	for g in goals {
		let Some(a) = garea[g.i] else { continue };
		let k = *area_pos.entry(a).or_insert_with(|| {
			by_area.push((a, Vec::new()));
			by_area.len() - 1
		});
		by_area[k].1.push(g.i);
	}
	let near = |a: usize, g: &WalkGoal| g.w.map_or(f64::INFINITY, |w| atlas.area_dist(a, w.c, w.wx, w.wy)) <= AWAY;
	let mut visits_of: Vec<(usize, Vec<Visit>)> = Vec::new();
	for (a, idx) in &by_area {
		let a = *a;
		let mut vs: Vec<Visit> = Vec::new();
		for &i in idx {
			if let Some(cur) = vs.last_mut() {
				let left = (cur.last + 1..i).any(|j| goals[j].w.is_some() && !near(a, &goals[j]));
				if !left {
					cur.idx.push(i);
					cur.last = i;
					continue;
				}
			}
			vs.push(Visit { idx: vec![i], first: i, last: i, depart: i });
		}
		for v in &mut vs {
			let mut dd = v.last;
			for (j, g) in goals.iter().enumerate().skip(v.last + 1) {
				if g.w.is_some() && !near(a, g) {
					break;
				}
				dd = j;
			}
			v.depart = dd;
		}
		visits_of.push((a, vs));
	}

	// ---- obtainability ----
	let giver_nodes = |q: i64| u32::try_from(q).ok().and_then(|q| atlas.roles.get(&q)).map_or(&[][..], |r| r.give.as_slice());
	let node_near = |n: usize, p: Pt, r: f64| {
		let n = &atlas.nodes[n];
		dist(Some((n.c, n.wx, n.wy)), p) <= r || n.pts.iter().any(|s| dist(Some((n.c, s.0, s.1)), p) <= r)
	};
	let obtainable = |q: i64, dd: usize, a: Option<usize>| -> (bool, String) {
		if rules.in_log_at(q, dd) {
			return (true, format!("in the log since {}", goal_ref(&goals[rules.accept_at[&q]])));
		}
		let r = rules.acceptable_at(q, dd, prereqs_of);
		let gs = giver_nodes(q);
		if r.is_ok() && gs.iter().any(|&n| atlas.nodes[n].area == a) {
			return (true, format!("giver here, open at level {}", fx(rules.lvl_at(dd))));
		}
		if !gs.is_empty() {
			for t in (0..=dd).rev() {
				let p = pt(&goals[t]);
				if p.is_none() || !gs.iter().any(|&n| node_near(n, p, PICKUP)) {
					continue;
				}
				if rules.acceptable_at(q, t, prereqs_of).is_ok() {
					let g0 = &atlas.nodes[gs[0]];
					let an = area_name(g0.area).unwrap_or_else(|| "undefined".into());
					return (true, format!("open at {} ({an}) when passed at level {}, {}", g0.name, fx(rules.lvl_at(t)), goal_ref(&goals[t])));
				}
			}
		}
		match r {
			Ok(()) => (false, "its giver is elsewhere and was not passed while open".into()),
			Err(why) => (false, why),
		}
	};
	let in_window = |q: i64, dd: usize| qlevel(q).filter(|l| *l != 0.0 && !l.is_nan()).unwrap_or(1.0) <= rules.lvl_at(dd).floor() + ACCEPT_ABOVE;
	let obj_nodes = |q: i64, oi: Option<i64>| -> &[usize] {
		let r = u32::try_from(q).ok().and_then(|q| atlas.roles.get(&q));
		match (r, oi) {
			(Some(r), Some(oi)) if oi >= 1 => r.obj.get((oi - 1) as usize).map_or(&[][..], Vec::as_slice),
			_ => &[],
		}
	};
	let item_here = |q: i64, oi: Option<i64>, a: usize| -> Result<(), String> {
		let o = match (qrec(q), oi) {
			(Some(r), Some(oi)) if oi >= 1 => r.objectives.get((oi - 1) as usize).and_then(Option::as_ref),
			_ => None,
		};
		let Some(o) = o.filter(|o| o.kind == "item") else { return Ok(()) };
		let ns = obj_nodes(q, oi);
		if ns.is_empty() || ns.iter().any(|&n| atlas.nodes[n].area == Some(a) || atlas.area_dist(a, atlas.nodes[n].c, atlas.nodes[n].wx, atlas.nodes[n].wy) <= AWAY) {
			return Ok(());
		}
		let best = ns.iter().copied().fold(ns[0], |b, n| if atlas.nodes[n].n > atlas.nodes[b].n { n } else { b });
		let what = o.text.clone().filter(|t| !t.is_empty()).unwrap_or_else(|| format!("item {}", o.id.map_or_else(|| "undefined".into(), js_to_string)));
		let bn = &atlas.nodes[best];
		Err(format!("{what} comes from {} in {}", bn.name, area_name(bn.area).filter(|s| !s.is_empty()).unwrap_or_else(|| "another area".into())))
	};
	let judge_goal = |g: &WalkGoal, a: usize, dd: usize| -> (bool, String) {
		let q = g.q.unwrap();
		let ld = rules.lvl_at(dd);
		if g.t == "accept" {
			if let Err(why) = rules.acceptable_at(q, dd, prereqs_of) {
				return (false, why);
			}
			if !in_window(q, dd) {
				return (false, format!("level {}, quest level {}", fx(ld), qlevel_s(q)));
			}
			return (true, format!("open at the last visit (level {}), giver here", fx(ld)));
		}
		let ob = obtainable(q, dd, Some(a));
		if !ob.0 {
			return ob;
		}
		if !in_window(q, dd) {
			return (false, format!("level {}, quest level {}", fx(ld), qlevel_s(q)));
		}
		if WORK.contains(&g.t.as_str()) {
			if let Err(why) = item_here(q, g.oi, a) {
				return (false, why);
			}
		} else {
			for &wi in work(q) {
				let w = &goals[wi];
				if w.i <= dd || w.i >= g.i {
					continue;
				}
				if garea[w.i] != Some(a) && !(w.w.is_some() && near(a, w)) {
					let an = area_name(garea[w.i]).filter(|s| !s.is_empty()).unwrap_or_else(|| "another place".into());
					return (false, format!("its objective was worked at {an} after the last visit ({})", goal_ref(w)));
				}
				if let Err(why) = item_here(q, w.oi, a) {
					return (false, why);
				}
			}
		}
		ob
	};

	// ---- returns ----
	let last_pos_before = |i: usize| (0..i).rev().find_map(|j| pt(&goals[j]));
	let first_pos_after = |i: usize| (i + 1..goals.len()).find_map(|j| pt(&goals[j]));
	let mut returns: Vec<Ret> = Vec::new();
	for (a, vs) in &visits_of {
		let a = *a;
		for k in 1..vs.len() {
			let (v1, v2) = (&vs[k - 1], &vs[k]);
			let dd = v1.depart;
			let judged: Vec<(usize, bool, String)> = v2
				.idx
				.iter()
				.map(|&i| {
					let (ok, why) = judge_goal(&goals[i], a, dd);
					(i, ok, why)
				})
				.collect();
			let avoidable = judged.iter().filter(|x| x.1).count();
			let service = (v2.first..=v2.depart).any(|j| SERVICE.contains(&goals[j].t.as_str()) && goals[j].w.is_some() && near(a, &goals[j]));
			let wasted = avoidable > 0 && avoidable == judged.len() && !service;
			let extra_yd = if wasted {
				let (prev, next) = (last_pos_before(v2.first), first_pos_after(v2.depart));
				let (pa, pb) = (pt(&goals[v2.first]), pt(&goals[v2.last]));
				let x = dist(prev, pa) + dist(pb, next) - dist(prev, next);
				x.is_finite().then(|| x.max(0.0))
			} else {
				None
			};
			returns.push(Ret { a, v1: (k - 1, 0), v2: (k, 0), judged, avoidable, wasted, extra_yd });
		}
	}
	let visit = |a: usize, k: usize| -> &Visit { &visits_of.iter().find(|(x, _)| *x == a).unwrap().1[k] };
	let wasted_n = returns.iter().filter(|r| r.wasted).count();
	let avoidable_n = returns.iter().filter(|r| r.avoidable > 0).count();
	let extra_yd: f64 = returns.iter().filter(|r| r.wasted).map(|r| r.extra_yd.unwrap_or(0.0)).sum();
	let lv = |v: &Visit| format!("{}-{}", fx(rules.lvl_at(v.first.saturating_sub(1))), fx(rules.lvl_at(v.depart)));
	let zone_of = |a: usize| atlas.areas[a].subzone.as_ref().map_or_else(|| format!("map {}", atlas.areas[a].map), |s| s.zone.clone());
	let minutes = |yd: f64| fixed1(yd / RUN_YPS / 60.0);
	let example = |r: &Ret| {
		let (v1, v2) = (visit(r.a, r.v1.0), visit(r.a, r.v2.0));
		let mut qs: Vec<i64> = Vec::new();
		for &i in &v1.idx {
			let q = goals[i].q.unwrap();
			if !qs.contains(&q) {
				qs.push(q);
			}
		}
		Example {
			area: atlas.areas[r.a].name.clone(),
			zone: zone_of(r.a),
			wasted: r.wasted,
			extra_minutes: r.extra_yd.map(minutes),
			v1: Visit1 { levels: lv(v1), quests: qs.into_iter().map(title).collect(), from: goal_ref(&goals[v1.first]), to: goal_ref(&goals[v1.depart]) },
			v2: Visit2 {
				levels: lv(v2),
				from: goal_ref(&goals[v2.first]),
				to: goal_ref(&goals[v2.last]),
				goals: r
					.judged
					.iter()
					.map(|(i, ok, why)| {
						let g = &goals[*i];
						JudgedGoal { t: g.t.clone(), q: g.q, title: g.q.and_then(qrec).and_then(|x| x.title.clone()), avoidable: *ok, why: why.clone(), ref_: goal_ref(g) }
					})
					.collect(),
			},
			why: r.judged.iter().find(|x| x.1).map(|x| x.2.clone()),
		}
	};
	let mut ranked: Vec<&Ret> = returns.iter().filter(|r| r.avoidable > 0).collect();
	ranked
		.sort_by(|a, b| (b.wasted as i32 - a.wasted as i32).cmp(&0).then_with(|| (b.extra_yd.unwrap_or(0.0) - a.extra_yd.unwrap_or(0.0)).total_cmp(&0.0)).then_with(|| b.avoidable.cmp(&a.avoidable)));

	// ---- per area ----
	let mut areas: Vec<AreaRow> = visits_of
		.iter()
		.filter(|(_, vs)| vs.len() > 1)
		.map(|(a, vs)| {
			let rs: Vec<&Ret> = returns.iter().filter(|r| r.a == *a).collect();
			AreaRow {
				area: atlas.areas[*a].name.clone(),
				zone: zone_of(*a),
				visits: vs.len(),
				avoidable_returns: rs.iter().filter(|r| r.avoidable > 0).count(),
				wasted_trips: rs.iter().filter(|r| r.wasted).count(),
				avoidable_goals: rs.iter().map(|r| r.avoidable).sum(),
				extra_minutes: minutes(rs.iter().map(|r| r.extra_yd.unwrap_or(0.0)).sum()),
			}
		})
		.filter(|a| a.avoidable_goals > 0)
		.collect();
	areas.sort_by(|a, b| b.extra_minutes.total_cmp(&a.extra_minutes).then(b.avoidable_goals.cmp(&a.avoidable_goals)));

	// ---- left behind ----
	let mut left_behind: Vec<LeftBehind> = Vec::new();
	let mut left_seen: Vec<u32> = Vec::new();
	for (a, vs) in &visits_of {
		for v in vs {
			for &q in &atlas.areas[*a].give {
				let qi = i64::from(q);
				let rec = d.quests.get(&q);
				let xp = rec.and_then(|r| r.xp).filter(|x| *x != 0.0 && !x.is_nan());
				if left_seen.contains(&q) || rules.ever(qi) || !solo_ok(q) || xp.is_none() || rules.closed_by_walk(qi) {
					continue;
				}
				if !level_ok(qlevel(qi).unwrap_or(0.0), rules.lvl_at(v.depart)) || rules.acceptable_at(qi, v.depart, prereqs_of).is_err() {
					continue;
				}
				left_seen.push(q);
				left_behind.push(LeftBehind {
					q,
					title: rec.and_then(|r| r.title.clone()),
					level: qlevel(qi),
					xp,
					area: atlas.areas[*a].name.clone(),
					zone: zone_of(*a),
					at_level: fixed1(rules.lvl_at(v.depart)),
					ref_: goal_ref(&goals[v.depart]),
				});
			}
		}
	}
	left_behind.sort_by(|a, b| a.at_level.total_cmp(&b.at_level));

	// ---- same mob twice ----
	let mut same_mob: Vec<SameMob> = Vec::new();
	let work_qs: Vec<i64> = work_order.iter().copied().filter(|&q| u32::try_from(q).is_ok_and(|q| atlas.roles.contains_key(&q))).collect();
	let camp_of: Vec<Vec<&str>> = work_qs
		.iter()
		.map(|&q| {
			let mut out: Vec<&str> = Vec::new();
			for &wi in work(q) {
				for &n in obj_nodes(q, goals[wi].oi) {
					let k = atlas.nodes[n].key.as_str();
					if !out.contains(&k) {
						out.push(k);
					}
				}
			}
			out
		})
		.collect();
	for a in 0..work_qs.len() {
		for b in a + 1..work_qs.len() {
			let (qa, qb) = (work_qs[a], work_qs[b]);
			let Some(shared) = camp_of[a].iter().find(|k| camp_of[b].contains(k)) else { continue };
			let (wa, wb) = (work(qa), work(qb));
			let (first, second, q2, q1) = if wa[wa.len() - 1] < wb[0] {
				(wa, wb, qb, qa)
			} else if wb[wb.len() - 1] < wa[0] {
				(wb, wa, qa, qb)
			} else {
				continue;
			};
			let (end, start) = (&goals[first[first.len() - 1]], &goals[second[0]]);
			let node = atlas.node(shared).unwrap();
			let away = (end.i + 1..start.i).any(|j| goals[j].w.is_some() && dist(pt(&goals[j]), pt(end)) > AWAY);
			if !away {
				continue;
			}
			let ob = obtainable(q2, end.i, node.area);
			if !ob.0 || !in_window(q2, end.i) {
				continue;
			}
			same_mob.push(SameMob {
				mob: node.name.clone(),
				area: area_name(node.area),
				first: title(q1),
				second: title(q2),
				first_level: fixed1(rules.lvl_at(end.i)),
				second_level: fixed1(rules.lvl_at(start.i)),
				why: ob.1,
				ref_first: goal_ref(end),
				ref_second: goal_ref(start),
			});
		}
	}

	let area_visits = visits_of.iter().map(|(_, vs)| vs.len()).sum();
	Returns {
		summary: Summary {
			avoidable_returns: avoidable_n,
			wasted_trips: wasted_n,
			avoidable_goals: returns.iter().map(|r| r.avoidable).sum(),
			extra_minutes: minutes(extra_yd),
			left_behind: left_behind.len(),
			same_mob_avoidable: same_mob.len(),
			area_visits,
			returns: returns.len(),
		},
		areas,
		examples: ranked.into_iter().take(examples).map(example).collect(),
		left_behind,
		same_mob,
	}
}
