//! Hand in while there (forge_sim::turnin; the hub sweep's `hand in while there` move, the written
//! check's `finished-near` fed back, `forge sim route --audit`): c19r Orc and Troll killed Sarkoth
//! (790) 150 yd from Hana'zua, went on to the Den, the Lazy Peons and the Burning Blade Coven, and
//! came back to Hana'zua for the hand-in and Sarkoth's follow-up (804).

mod common;

use forge_sim::flow::Finding;
use forge_sim::guards::hub_counts;
use forge_sim::hubs::{Fix, HubData};
use forge_sim::order::Order;
use forge_sim::run::{Run, K_ACCEPT, K_TASK, K_TURNIN};
use forge_sim::search::passby::{flow_fixes, hub_sweep};
use forge_sim::search::{pool, runs, Member, Problem};
use forge_sim::turnin::{scan, Kind, Line, Wait};

/// The golden v1 Orc order with Sarkoth's hand-in and 804's accept moved after the Burning Blade
/// Coven's work (c19r's order), and the index of Sarkoth's task.
fn sarkoth_late(r: &Run, seed: &Order) -> (Order, usize) {
	let q = |id: u32| r.q(id).unwrap();
	let at = |o: &Order, k: u8, id: u32| o.steps.iter().position(|s| s.kind == k && s.q == q(id)).unwrap();
	let mut bad = seed.clone();
	for _ in 0..2 {
		let j = at(&bad, K_TURNIN, 790).min(at(&bad, K_ACCEPT, 804));
		let (s, g) = (bad.steps.remove(j), bad.origin.remove(j));
		// (After 794's work: the Burning Blade Coven, 356 yd from Hana'zua; 804's accept after 790's hand-in.)
		let to = if s.kind == K_TURNIN { at(&bad, K_TASK, 794) + 1 } else { at(&bad, K_TURNIN, 790) + 1 };
		bad.steps.insert(to, s);
		bad.origin.insert(to, g);
	}
	let task = at(&bad, K_TASK, 790);
	(bad, task)
}

#[test]
fn a_quest_finished_near_its_ender_is_handed_in_before_the_walk_goes_away() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let (bad, task) = sarkoth_late(r, &seed);
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut log = |s: &str| eprintln!("{s}");
	hub_sweep(&p, &mut mem, &mut log);
	let st = &mem.order.steps;
	let pos = |k: u8, id: u32| st.iter().position(|s| s.kind == k && r.q_id[s.q as usize] == id).unwrap();
	let (t, j, f) = (pos(K_TASK, 790), pos(K_TURNIN, 790), pos(K_ACCEPT, 804));
	assert_eq!((j, f), (t + 1, t + 2), "Sarkoth handed in and 804 taken right after the kill (task at {t}; was at {task}): {:?}", &st[t..=f.max(j)]);
}

#[test]
fn the_planner_counts_a_hand_in_made_on_a_trip_back_and_points_at_where_it_was_finished() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let h = HubData::new(r);
	let count = |o: &Order, f: Option<&mut Vec<Fix>>| {
		let c = &runs(&p, o)[0];
		hub_counts(&h, r, &c.steps, c.levels(), c.walked(), f)
	};
	// v1 hands Sarkoth in after the valley's scorpids and cactuses, never 300 yd from Hana'zua.
	assert_eq!(count(&seed, None).finished_near, 0);
	let (bad, task) = sarkoth_late(r, &seed);
	let mut fixes = Vec::new();
	assert!(count(&bad, Some(&mut fixes)).finished_near >= 1);
	let j = bad.steps.iter().position(|s| s.kind == K_TURNIN && r.q_id[s.q as usize] == 790).unwrap();
	assert!(fixes.contains(&Fix::Near { j, n: 1, to: task + 1 }), "{fixes:?}");
}

#[test]
fn the_written_checks_finished_near_moves_the_hand_in_and_its_follow_up_as_one_block() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let (bad, _) = sarkoth_late(r, &seed);
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let f = Finding { start: "Orc".into(), rule: "finished-near".into(), text: "test".into(), lines: vec![(K_TURNIN, 790), (K_ACCEPT, 804)], after: Some((K_TASK, 790)), before: None };
	let kept = flow_fixes(&p, &mut mem, &[f], &[], &mut |s| eprintln!("{s}"));
	assert!(!kept.is_empty(), "kept");
	let st = &mem.order.steps;
	let pos = |k: u8, id: u32| st.iter().position(|s| s.kind == k && r.q_id[s.q as usize] == id).unwrap();
	let t = pos(K_TASK, 790);
	assert_eq!((pos(K_TURNIN, 790), pos(K_ACCEPT, 804)), (t + 1, t + 2));
}

/// A walk on a line (x yards; a negative x is another continent), as forge_sim::turnin reads it.
struct W {
	stops: Vec<(Kind, u32, f64, f64)>,
	min: Vec<(u32, f64)>,
	follows: Vec<(u32, u32)>,
	/// The ender behind a cliff: no walk reaches it within REACH_YD.
	cliff: bool,
}

impl Line for W {
	fn len(&self) -> usize {
		self.stops.len()
	}
	fn kind(&self, i: usize) -> Kind {
		self.stops[i].0
	}
	fn quest(&self, i: usize) -> u32 {
		self.stops[i].1
	}
	fn yd(&self, a: usize, b: usize) -> f64 {
		let (x, y) = (self.stops[a].2, self.stops[b].2);
		if (x < 0.0) != (y < 0.0) {
			f64::INFINITY
		} else {
			(x - y).abs()
		}
	}
	fn reach(&self, _a: usize, _b: usize) -> bool {
		!self.cliff
	}
	fn same_place(&self, a: usize, b: usize) -> bool {
		self.yd(a, b) < 1.0
	}
	fn lvl_after(&self, i: usize) -> f64 {
		self.stops[i].3
	}
	fn ready_after(&self, j: usize) -> Option<usize> {
		let q = self.stops[j].1;
		let acc = (0..j).rev().find(|&i| self.stops[i].0 == Kind::Accept && self.stops[i].1 == q)?;
		Some((acc..j).rev().find(|&i| self.stops[i].0 == Kind::Work && self.stops[i].1 == q).unwrap_or(acc))
	}
	fn min_level(&self, q: u32) -> f64 {
		self.min.iter().find(|x| x.0 == q).map_or(0.0, |x| x.1)
	}
	fn follows(&self, f: u32, q: u32) -> bool {
		self.follows.contains(&(f, q))
	}
}

#[test]
fn waiting_is_right_for_a_follow_up_above_the_level_or_a_return_there_anyway() {
	use Kind::*;
	// The giver at 0; the quest done at 150; the walk on to 400; back to the giver.
	let walk = |back: Vec<(Kind, u32, f64, f64)>| {
		let mut v = vec![(Accept, 1, 0.0, 3.0), (Work, 1, 150.0, 3.0), (Work, 2, 400.0, 4.0)];
		v.extend(back);
		W { stops: v, min: Vec::new(), follows: vec![(3, 1)], cliff: false }
	};
	// A trip back for the hand-in and the follow-up alone: hand in after the work at 150.
	let w = walk(vec![(Turnin, 1, 0.0, 4.0), (Accept, 3, 0.0, 4.0), (Work, 3, 900.0, 5.0)]);
	let x = scan(&w);
	assert_eq!(x.len(), 1);
	assert_eq!((x[0].j, x[0].follow.clone(), x[0].at, x[0].away, x[0].wait), (3, vec![4], 1, 2, Option::<Wait>::None));
	assert!(x[0].blocker(&w));
	// ... unless the follow-up needs level 5 and the walk is at 3 there (the minimum: info).
	let mut w2 = walk(vec![(Turnin, 1, 0.0, 5.0), (Accept, 3, 0.0, 5.0)]);
	w2.min = vec![(3, 5.0)];
	assert!(matches!(scan(&w2)[0].wait, Some(Wait::Level { q: 3, .. })));
	// ... or the walk comes back anyway: another quest's accept beside the ender (30 yd).
	let w3 = W { ..walk(vec![(Accept, 9, 30.0, 4.0), (Turnin, 1, 0.0, 4.0)]) };
	assert!(matches!(scan(&w3)[0].wait, Some(Wait::Returns { other: 3, .. })));
	// Another hand-in made on a trip back is no reason for this one's.
	let w4 = W {
		stops: vec![(Accept, 1, 0.0, 3.0), (Accept, 5, 0.0, 3.0), (Work, 1, 150.0, 3.0), (Work, 5, 140.0, 3.0), (Work, 2, 400.0, 4.0), (Turnin, 5, 0.0, 4.0), (Turnin, 1, 0.0, 4.0)],
		min: Vec::new(),
		follows: Vec::new(),
		cliff: false,
	};
	assert!(scan(&w4).iter().all(|x| x.wait.is_none()) && scan(&w4).len() == 2);
	// Not near (finished 200 yd off), or never 300 yd away: nothing.
	let w5 = W { stops: vec![(Accept, 1, 0.0, 3.0), (Work, 1, 200.0, 3.0), (Work, 2, 400.0, 4.0), (Turnin, 1, 0.0, 4.0)], min: Vec::new(), follows: Vec::new(), cliff: false };
	assert!(scan(&w5).is_empty());
	let w6 = W { stops: vec![(Accept, 1, 0.0, 3.0), (Work, 1, 150.0, 3.0), (Work, 2, 290.0, 4.0), (Turnin, 1, 0.0, 4.0)], min: Vec::new(), follows: Vec::new(), cliff: false };
	assert!(scan(&w6).is_empty());
	// Another continent is away; above level 30 a warning, not a blocker.
	let w7 = W { stops: vec![(Accept, 1, 0.0, 40.0), (Work, 1, 150.0, 40.0), (Move, 0, -5.0, 40.0), (Turnin, 1, 0.0, 41.0)], min: Vec::new(), follows: Vec::new(), cliff: false };
	let x = scan(&w7);
	assert!(x.len() == 1 && x[0].far.is_infinite() && !x[0].blocker(&w7));
	// An ender the walk cannot reach from there (a cliff): not near.
	let w8 = W { cliff: true, ..walk(vec![(Turnin, 1, 0.0, 4.0)]) };
	assert!(scan(&w8).is_empty());
}

#[test]
fn the_audit_flags_sarkoth_on_a_written_order() {
	let o = common::orc();
	let pts = &o.world.points;
	// The world point nearest a quest's ender/giver: Hana'zua; the valley's other stops by the c19r order.
	let w790 = o.world.quests.iter().find(|q| q.id == 790).unwrap();
	let (hana, den) = (w790.ender, o.world.quests.iter().find(|q| q.id == 804).unwrap().ender);
	let near = (0..pts.len() as u32).find(|&p| {
		p != hana && pts[p as usize].c == pts[hana as usize].c && pts[p as usize].region == pts[hana as usize].region && {
			let d = (pts[p as usize].wx - pts[hana as usize].wx).hypot(pts[p as usize].wy - pts[hana as usize].wy);
			(100.0..150.0).contains(&d)
		}
	});
	let near = near.expect("a point 100-150 yd from Hana'zua");
	let away = (0..pts.len() as u32)
		.find(|&p| {
			pts[p as usize].c == pts[hana as usize].c
				&& pts[p as usize].region == pts[hana as usize].region
				&& (pts[p as usize].wx - pts[hana as usize].wx).hypot(pts[p as usize].wy - pts[hana as usize].wy) > 350.0
		})
		.unwrap();
	let e = |t: &str, q: u32, pt: u32, lvl: f64| serde_json::json!({ "t": t, "q": q, "pt": pt, "lvl": lvl, "from": format!("{t} {q}") });
	let order = vec![e("accept", 790, hana, 3.0), e("task", 790, near, 3.0), e("task", 794, away, 4.0), e("turnin", 790, hana, 4.8), e("accept", 804, hana, 5.0), e("turnin", 804, den, 5.0)];
	let a = forge_sim::turnin::audit_order(&o.world, None, &order);
	assert_eq!(a.len(), 1, "{a:?}");
	assert_eq!((a[0].q, a[0].near.j, a[0].near.at, a[0].near.follow.clone(), a[0].blocker), (790, 3, 1, vec![4], true));
	// Handed in right after the kill: nothing.
	let order = vec![e("accept", 790, hana, 3.0), e("task", 790, near, 3.0), e("turnin", 790, hana, 3.2), e("accept", 804, hana, 3.2), e("task", 794, away, 4.0), e("turnin", 804, den, 5.0)];
	assert!(forge_sim::turnin::audit_order(&o.world, None, &order).is_empty());
}
