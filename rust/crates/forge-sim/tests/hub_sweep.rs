//! The hub sweep (Fitz in Brill, c12: sent to pick up a quest past three quest givers he would come
//! back to, and back and forth in town): what is ready at a hub is done in the visit there, in the
//! order of the shortest walk through its NPCs.

mod common;
use forge_sim::guards::hub_counts;
use forge_sim::hubs::{loop_order, visits, HubData};
use forge_sim::order::Order;
use forge_sim::run::{Run, K_ACCEPT, K_TURNIN};
use forge_sim::search::passby::{hub_sweep, loop_keep};
use forge_sim::search::{pool, runs, Member, Problem};
use forge_sim::Step;

/// The hub counts of an order (its first character).
fn left_ready(p: &Problem, h: &HubData, o: &Order) -> u32 {
	let c = &runs(p, o)[0];
	hub_counts(h, &p.model.run, &c.steps, c.levels(), c.walked(), None).left_ready
}

/// Three hand-ins of different quests at three NPCs of one hub visit, which can wait for the next
/// visit to that hub (no follow-up taken before it): the visit and the next one. (Hand-ins: the
/// hub pickup pass already takes an accept on an earlier visit.)
fn three_at_a_hub(h: &HubData, r: &Run, o: &Order) -> Option<(usize, usize, Vec<usize>)> {
	let (vs, _, _) = visits(h, r, &o.steps);
	for (k, v) in vs.iter().enumerate() {
		let Some(w) = vs[k + 1..].iter().find(|w| w.hub == v.hub && w.s >= v.leave) else { continue };
		let free = |i: usize| {
			let s = o.steps[i];
			let between = &o.steps[v.e + 1..w.s];
			let follows = |x: &Step| {
				x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&s.q) || r.q_all[x.q as usize].contains(&s.q) || r.q_after[x.q as usize].contains(&s.q) || r.q_parent[x.q as usize] == s.q as i32)
			};
			s.kind == K_TURNIN && !between.iter().any(|x| x.q == s.q || follows(x)) && !o.steps[v.s..=v.e].iter().any(|x| x.q != s.q && follows(x))
		};
		let mut pick: Vec<usize> = Vec::new();
		for i in v.s..=v.e {
			let s = o.steps[i];
			if free(i) && pick.iter().all(|&j| o.steps[j].pt != s.pt && o.steps[j].q != s.q) {
				pick.push(i);
			}
		}
		if pick.len() >= 3 {
			pick.truncate(3);
			return Some((k, k + vs[k + 1..].iter().position(|x| x.s == w.s).unwrap() + 1, pick));
		}
	}
	None
}

#[test]
fn three_ready_npcs_at_a_hub_are_done_in_one_visit_in_loop_order() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let (vk, wk, pick) = three_at_a_hub(&h, r, &seed).expect("a hub visit of v1's Orc order with three NPCs whose steps can wait");
	let (vs, _, _) = visits(&h, r, &seed.steps);
	let (v, w) = (vs[vk], vs[wk]);
	// The bad order: the three left for the next visit to the hub (Brill: Coleman, Sevren, Gretchen
	// on a return).
	let mut bad = Order { steps: Vec::new(), origin: Vec::new() };
	let moved: Vec<(Step, i64)> = pick.iter().map(|&i| (seed.steps[i], seed.origin[i])).collect();
	for i in 0..seed.len() {
		if i == w.s {
			for &(s, g) in &moved {
				bad.steps.push(s);
				bad.origin.push(g);
			}
		}
		if !pick.contains(&i) {
			bad.steps.push(seed.steps[i]);
			bad.origin.push(seed.origin[i]);
		}
	}
	assert_eq!(runs(&p, &bad)[0].noops, runs(&p, &seed)[0].noops, "the bad order plays every step");
	let was = left_ready(&p, &h, &bad);
	assert!(was >= 3, "the three are left ready at the first visit: {was}");
	// In one visit, the first: the visit of a step of it that stayed.
	let anchor = (v.s..=v.e).find(|i| !pick.contains(i)).map(|i| seed.steps[i]).expect("a step stays in the visit");
	let pos = |o: &Order, s: Step| o.steps.iter().position(|x| x.kind == s.kind && x.q == s.q && x.task == s.task && x.pt == s.pt).unwrap();
	let in_first = |o: &Order| {
		let (_, of, _) = visits(&h, r, &o.steps);
		let a = of[pos(o, anchor)];
		moved.iter().all(|&(s, _)| of[pos(o, s)] == a)
	};
	assert!(!in_first(&bad), "the bad order does them on the return");
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut log = |s: &str| eprintln!("{s}");
	let kept = hub_sweep(&p, &mut mem, &mut log);
	assert!(!kept.is_empty(), "the sweep keeps moves");
	let now = left_ready(&p, &h, &mem.order);
	assert!(now + 3 <= was, "fewer left ready: {was} -> {now}");
	assert!(in_first(&mem.order), "the three are done in the first visit");
	// In loop order: no order of its stops that keeps the quests' rules walks 20 yd less.
	let (vs2, of2, _) = visits(&h, r, &mem.order.steps);
	let x = vs2[of2[pos(&mem.order, anchor)]];
	let entry = mem.order.steps[..x.s].iter().rev().find(|s| s.kind != forge_sim::run::K_GRIND).map_or(r.start_pt, |s| s.pt);
	let exit = mem.order.steps[x.e + 1..].iter().find(|s| s.kind != forge_sim::run::K_GRIND).map(|s| s.pt);
	let keep = |a: &Step, b: &Step| loop_keep(&p, a, b);
	assert!(loop_order(r, &mem.order.steps, x.s, x.e, entry, exit, &keep).is_none(), "the visit's stops are in loop order");
}

#[test]
fn a_ready_hand_in_whose_ender_the_walk_passes_is_done_on_the_way() {
	use forge_sim::hubs::{LEAVE_YD, PAST_YD};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let walked = runs(&p, &seed)[0].walked().to_vec();
	let st = &seed.steps;
	let pt = |i: usize| (st[i].kind != forge_sim::run::K_GRIND).then_some(st[i].pt);
	// Yards from a point to the straight leg a->b.
	let seg = |x: u32, a: u32, b: u32| {
		let (px, py, ax, ay, bx, by) = (r.p_x[x as usize], r.p_y[x as usize], r.p_x[a as usize], r.p_y[a as usize], r.p_x[b as usize], r.p_y[b as usize]);
		let (dx, dy) = (bx - ax, by - ay);
		let t = if dx * dx + dy * dy > 0.0 { (((px - ax) * dx + (py - ay) * dy) / (dx * dx + dy * dy)).clamp(0.0, 1.0) } else { 0.0 };
		if r.p_r[x as usize] == r.p_r[a as usize] && r.p_r[a as usize] == r.p_r[b as usize] {
			(px - ax - t * dx).hypot(py - ay - t * dy)
		} else {
			f64::INFINITY
		}
	};
	// A hand-in, a walked leg after it passing its ender (not ending there), then a step away from
	// it, with nothing of its quest or its follow-ups in between: handed in after that step instead.
	let (j, leg, away) = (0..st.len())
		.filter(|&j| st[j].kind == K_TURNIN)
		.find_map(|j| {
			let e = st[j].pt;
			let blocks = |x: &Step| {
				x.q == st[j].q || (x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&st[j].q) || r.q_all[x.q as usize].contains(&st[j].q) || r.q_after[x.q as usize].contains(&st[j].q)))
			};
			let mut prev = j;
			for i in j + 1..(j + 40).min(st.len()) {
				if blocks(&st[i]) {
					return None;
				}
				let Some(b) = pt(i) else { continue };
				let a = pt(prev).unwrap();
				prev = i;
				if !walked[i].walked || r.straight(b, e) <= PAST_YD || r.straight(a, e) <= LEAVE_YD || seg(e, a, b) > PAST_YD {
					continue;
				}
				let away = (i..(i + 10).min(st.len())).find(|&k| pt(k).is_some_and(|x| r.straight(x, e) > LEAVE_YD) && !st[i..=k].iter().any(&blocks))?;
				return Some((j, i, away));
			}
			None
		})
		.expect("a hand-in whose ender a later walked leg passes");
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(j), bad.origin.remove(j));
	bad.steps.insert(away, s);
	bad.origin.insert(away, g);
	let past = |o: &Order| {
		let c = &runs(&p, o)[0];
		hub_counts(&h, r, &c.steps, c.levels(), c.walked(), None).walked_past
	};
	let was = past(&bad);
	assert!(was >= 1, "the bad order walks past the ready hand-in");
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut log = |s: &str| eprintln!("{s}");
	hub_sweep(&p, &mut mem, &mut log);
	assert!(past(&mem.order) < was, "walked past fewer");
	let now = mem.order.steps.iter().position(|x| x.kind == K_TURNIN && x.q == s.q).unwrap();
	let leg_end = mem.order.steps.iter().position(|x| *x == seed.steps[leg]).unwrap();
	assert!(now < leg_end, "handed in on the leg past its ender, not after it: at {now}, the leg ends at {leg_end}");
}

/// FlowDiag fix 3 (c13: Grom'gol 596, Brackenwall 1273, the Steamwheedle boat): a leg by flight or
/// boat walks to its departure node and from its arrival node, and those walks pass NPCs. A ready
/// hand-in whose ender the walk to (or from) the flight master passes, handed in after the flight,
/// is walked past on that leg (before: only legs walked all the way counted, so the planner never saw
/// it).
#[test]
fn a_ready_hand_in_passed_on_the_walk_to_a_flight_master_is_walked_past() {
	use forge_sim::hubs::{Fix, LEAVE_YD, PAST_YD};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let moved = runs(&p, &seed)[0].walked().to_vec();
	let st = &seed.steps;
	let pt = |i: usize| (st[i].kind != forge_sim::run::K_GRIND).then_some(st[i].pt);
	let xy = |x: u32| (r.p_r[x as usize], r.p_x[x as usize], r.p_y[x as usize]);
	let node = |n: i32| (r.node_r[n as usize], r.node_x[n as usize], r.node_y[n as usize]);
	// Yards from a point to the straight leg a->b.
	let seg = |x: (i64, f64, f64), a: (i64, f64, f64), b: (i64, f64, f64)| {
		if x.0 != a.0 || a.0 != b.0 {
			return f64::INFINITY;
		}
		let (dx, dy) = (b.1 - a.1, b.2 - a.2);
		let t = if dx * dx + dy * dy > 0.0 { (((x.1 - a.1) * dx + (x.2 - a.2) * dy) / (dx * dx + dy * dy)).clamp(0.0, 1.0) } else { 0.0 };
		(x.1 - a.1 - t * dx).hypot(x.2 - a.2 - t * dy)
	};
	// A hand-in, then a flown leg (not out of the hand-in itself) whose walk to its departure node or
	// from its arrival node passes the ender, its end far from the ender, nothing of its quest or its
	// follow-ups in between.
	let (j, i) = (0..st.len())
		.filter(|&j| st[j].kind == K_TURNIN)
		.find_map(|j| {
			let e = st[j].pt;
			let blocks = |x: &Step| {
				x.q == st[j].q || (x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&st[j].q) || r.q_all[x.q as usize].contains(&st[j].q) || r.q_after[x.q as usize].contains(&st[j].q)))
			};
			let mut prev = j;
			for i in j + 1..(j + 60).min(st.len()) {
				if blocks(&st[i]) {
					return None;
				}
				let Some(b) = pt(i) else { continue };
				let a = pt(prev).unwrap();
				let first = prev == j;
				prev = i;
				let mv = moved[i];
				if first || mv.walked || (mv.dep < 0 && mv.arr < 0) || r.straight(b, e) <= LEAVE_YD {
					continue;
				}
				let dep = if mv.dep >= 0 { seg(xy(e), xy(a), node(mv.dep)) } else { f64::INFINITY };
				let arr = if mv.arr >= 0 { seg(xy(e), node(mv.arr), xy(b)) } else { f64::INFINITY };
				if dep.min(arr) <= PAST_YD - 5.0 {
					return Some((j, i));
				}
			}
			None
		})
		.expect("a hand-in whose ender the walk to or from a later flight passes");
	// The bad order: handed in right after the flight.
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(j), bad.origin.remove(j));
	bad.steps.insert(i, s);
	bad.origin.insert(i, g);
	let c = &runs(&p, &bad)[0];
	assert!(!c.walked()[i - 1].walked && (c.walked()[i - 1].dep >= 0 || c.walked()[i - 1].arr >= 0), "the leg into step {} is still flown", i - 1);
	let mut fixes = Vec::new();
	let n = hub_counts(&h, r, &c.steps, c.levels(), c.walked(), Some(&mut fixes));
	assert!(n.walked_past >= 1, "the hand-in is walked past");
	assert!(fixes.contains(&Fix::Leg { j: i, i: i - 1 }), "handed in on the flown leg's walk: {fixes:?}");
	// A shared tail counts every start's run (c14: the Skyborne's Journey to Sentinel Hill and the
	// Dwarves' MacKreel's Moonshine, walked past where the canonical Human never takes them): another
	// start's context (mapped, its own part as the prefix) adds its walked past to the bound a move
	// keeps; a draw of the canonical start's model does not.
	use forge_sim::search::passby::ctx_counts;
	use forge_sim::search::{CtxSpec, Mapper};
	let one = runs(&p, &bad);
	let alone = ctx_counts(&p, &h, |k| &one[k], None);
	let mut two = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	two.ctxs.push(CtxSpec { model: &m, prefix: vec![Step::grind(0, 0)], map: Some(Mapper::new(r, r)), name: "Troll".into(), hub: Default::default() });
	two.ctxs.push(CtxSpec { model: &m, prefix: Vec::new(), map: None, name: "draw".into(), hub: Default::default() });
	let rs = runs(&two, &bad);
	let both = ctx_counts(&two, &h, |k| &rs[k], None);
	assert_eq!(alone.walked_past, n.walked_past);
	assert!(both.walked_past >= 2 * alone.walked_past, "the second start's walked past counted: {both:?} vs {alone:?}");
	assert!(both.walked_past < 3 * alone.walked_past, "the draw not counted: {both:?} vs {alone:?}");
}

/// c14 Orc Feralas 167-170: flown from Camp Mojache to Gadgetzan, walked to the Steamwheedle dock and
/// boated to Stonard with three Steamwheedle hand-ins ready, handed in on the way back. The walk
/// between two nodes inside a network path (Moved::via) passes NPCs too: a ready hand-in whose ender
/// only that walk passes is walked past on the leg (before: only the walk to the departure node and
/// the one from the arrival node counted).
#[test]
fn a_ready_hand_in_passed_on_a_walk_between_a_flight_and_a_boat_is_walked_past() {
	use forge_sim::eval::Moved;
	use forge_sim::hubs::{Fix, LEAVE_YD, PAST_YD};
	use forge_sim::travel::NO_VIA;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let st = &seed.steps;
	let xy = |x: u32| (r.p_r[x as usize], r.p_x[x as usize], r.p_y[x as usize]);
	let node = |n: usize| (r.node_r[n], r.node_x[n], r.node_y[n]);
	let seg = |x: (i64, f64, f64), a: (i64, f64, f64), b: (i64, f64, f64)| {
		if x.0 != a.0 || a.0 != b.0 {
			return f64::INFINITY;
		}
		let (dx, dy) = (b.1 - a.1, b.2 - a.2);
		let t = if dx * dx + dy * dy > 0.0 { (((x.1 - a.1) * dx + (x.2 - a.2) * dy) / (dx * dx + dy * dy)).clamp(0.0, 1.0) } else { 0.0 };
		(x.1 - a.1 - t * dx).hypot(x.2 - a.2 - t * dy)
	};
	let n = r.node_r.len();
	// A hand-in whose ender a walk between two transport nodes passes, then a later step far from
	// the ender, nothing of its quest or its follow-ups in between: the leg into that step stands for
	// a network leg walking between those nodes.
	let (j, i, via) = (0..st.len())
		.filter(|&j| st[j].kind == K_TURNIN)
		.find_map(|j| {
			let e = st[j].pt;
			let pair = (0..n).flat_map(|u| (0..n).map(move |v| (u, v))).find(|&(u, v)| u != v && seg(xy(e), node(u), node(v)) <= PAST_YD - 5.0)?;
			let blocks = |x: &Step| {
				x.q == st[j].q || (x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&st[j].q) || r.q_all[x.q as usize].contains(&st[j].q) || r.q_after[x.q as usize].contains(&st[j].q)))
			};
			let mut prev = j;
			for i in j + 1..(j + 60).min(st.len()) {
				if blocks(&st[i]) {
					return None;
				}
				if st[i].kind == forge_sim::run::K_GRIND {
					continue;
				}
				let first = prev == j;
				prev = i;
				if !first && r.straight(st[i].pt, e) > LEAVE_YD {
					return Some((j, i, pair));
				}
			}
			None
		})
		.expect("a hand-in whose ender a walk between two nodes passes");
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(j), bad.origin.remove(j));
	bad.steps.insert(i, s);
	bad.origin.insert(i, g);
	let c = &runs(&p, &bad)[0];
	// The leg into step i - 1 by the network: no walk to a departure node or from an arrival node,
	// only the walk between the two nodes.
	let count = |v| {
		let mut wk = c.walked().to_vec();
		wk[i - 1] = Moved { walked: false, dep: -1, arr: -1, via: v };
		let mut fixes = Vec::new();
		(hub_counts(&h, r, &c.steps, c.levels(), &wk, Some(&mut fixes)), fixes)
	};
	let mut v = NO_VIA;
	v[0] = (via.0 as i16, via.1 as i16);
	let ((with, fixes), (without, before)) = (count(v), count(NO_VIA));
	// (The hand-in may be walked past on an earlier leg too: the leg the fix names tells them apart.)
	let leg = Fix::Leg { j: i, i: i - 1 };
	assert!(with.walked_past >= 1 && with.walked_past >= without.walked_past, "{with:?} vs {without:?}");
	assert!(fixes.contains(&leg), "handed in on the network leg's walk: {fixes:?}");
	assert!(!before.contains(&leg), "the walk between the nodes was not read before: {before:?}");
}

/// A hand-in left ready at two visits to its hub goes into the earlier one (c14 Orc, Ratchet:
/// WANTED: Baron Longshore moved into the later visit was still left ready at the one before, each
/// sweep move refused for the unchanged count).
#[test]
fn a_hand_in_left_ready_at_two_visits_goes_into_the_earlier() {
	use forge_sim::hubs::Fix;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let (vs, _, _) = visits(&h, r, &seed.steps);
	// Three visits to one hub, and a hand-in of the first whose quest and follow-ups wait until the
	// third: the hand-in moved to the third.
	let follows = |x: &Step, q: u32| {
		x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&q) || r.q_all[x.q as usize].contains(&q) || r.q_after[x.q as usize].contains(&q) || r.q_parent[x.q as usize] == q as i32)
	};
	let (i, v2, v3) = vs
		.iter()
		.enumerate()
		.find_map(|(k, v1)| {
			let (k2, v2) = vs.iter().enumerate().skip(k + 1).find(|(_, w)| w.hub == v1.hub && w.s >= v1.leave)?;
			let v3 = vs[k2 + 1..].iter().find(|w| w.hub == v1.hub && w.s >= v2.leave)?;
			(v1.s..=v1.e)
				.find(|&i| {
					let s = seed.steps[i];
					s.kind == K_TURNIN && !seed.steps[i + 1..v3.s].iter().any(|x| x.q == s.q || follows(x, s.q))
				})
				.map(|i| (i, *v2, *v3))
		})
		.expect("a hand-in of a visit with two later visits to its hub, nothing of its quest before the third");
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(i), bad.origin.remove(i));
	let at = v3.s - 1;
	bad.steps.insert(at, s);
	bad.origin.insert(at, g);
	assert_eq!(runs(&p, &bad)[0].noops, runs(&p, &seed)[0].noops, "the bad order plays every step");
	let c = &runs(&p, &bad)[0];
	let mut fixes = Vec::new();
	hub_counts(&h, r, &c.steps, c.levels(), c.walked(), Some(&mut fixes));
	// (Indices of the bad order: steps before the hand-in's old place one lower.)
	let second = v2.s - 1;
	let fix = fixes.iter().find_map(|f| match *f {
		Fix::Visit { j, s, e, .. } if j == at => Some((s, e)),
		_ => None,
	});
	let (fs, fe) = fix.expect("the hand-in is left ready at an earlier visit");
	assert!(fe < second, "the fix names the first visit ({fs}..={fe}), not the second (from {second})");
	let was = left_ready(&p, &h, &bad);
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut log = |s: &str| eprintln!("{s}");
	hub_sweep(&p, &mut mem, &mut log);
	let now = left_ready(&p, &h, &mem.order);
	let back = mem.order.steps.iter().position(|x| x.kind == s.kind && x.q == s.q && x.task == s.task).unwrap();
	assert!(now < was && back < second, "handed in at the first visit: left ready {was} -> {now}, at step {back}");
}
