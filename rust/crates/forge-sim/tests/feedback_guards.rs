//! The four player-feedback guards, each failing on an order built to break it and passing on
//! v1's (RouteFeedback F06 #617 grind after the trip's hand-ins, F58 #576 hearths >= 60 min
//! apart, F12 #664 train at the next trainer on the way, F82 no elite or rare camps).

mod common;
use forge_core::Faction;
use forge_sim::guards::{elite_rare_count, grind_before_handin, train_bounces};
use forge_sim::order::Order;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{TravelPlan, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN, W_KILL};
use forge_sim::{Model, Params, Step};

/// The level after each step of an order.
fn levels(m: &Model, o: &common::Orc, steps: &[Step]) -> Vec<f64> {
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	steps
		.iter()
		.map(|&s| {
			if !ev.s.finished {
				ev.step(s);
			}
			ev.level_now()
		})
		.collect()
}

#[test]
fn grind_waits_for_the_trips_hand_ins() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let run = &m.run;
	let base = grind_before_handin(run, &seed.steps, &levels(&m, &o, &seed.steps));
	// A grind put right before a hand-in at the same place whose work is done: the guard fails.
	let mut found = false;
	for j in 1..seed.len() {
		let t = seed.steps[j];
		let prev = seed.steps[j - 1];
		if t.kind != K_TURNIN || prev.kind == K_GRIND || run.straight(prev.pt, t.pt) > 100.0 || run.q_task0[t.q as usize] == run.q_task1[t.q as usize] {
			continue;
		}
		let lv = levels(&m, &o, &seed.steps[..j]);
		let l = lv.last().copied().unwrap_or(1.0);
		if l >= 59.0 {
			break;
		}
		let g = Step::grind(l.floor() as u32 + 1, 0);
		let mut bad = seed.steps.clone();
		bad.insert(j, g);
		let mut good = seed.steps.clone();
		good.insert(j + 1, g);
		let (b, gd) = (grind_before_handin(run, &bad, &levels(&m, &o, &bad)), grind_before_handin(run, &good, &levels(&m, &o, &good)));
		if b > base && gd <= base {
			found = true;
			break;
		}
	}
	assert!(found, "a grind before a ready hand-in on the trip is caught; after it, not");
}

#[test]
fn training_is_on_the_way() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let run = &m.run;
	let base = train_bounces(run, &seed.steps);
	let k = seed.steps.iter().position(|s| s.kind == K_TRAIN).expect("a training");
	let town = seed.steps[k].pt;
	let far = |p: u32| run.straight(p, town) > 2000.0;
	let at =
		(k + 2..seed.len()).find(|&i| seed.steps[i].kind != K_GRIND && seed.steps[i - 1].kind != K_GRIND && far(seed.steps[i].pt) && far(seed.steps[i - 1].pt)).expect("a stretch far from the town");
	let mut bad = seed.steps.clone();
	let t = bad.remove(k);
	bad.insert(at - 1, t);
	assert!(train_bounces(run, &bad) > base, "a training moved away from every stop is a bounce");
	assert!(train_bounces(run, &seed.steps) <= base, "v1's own trainings pass");
}

#[test]
fn no_elite_or_rare_camps() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let run = &m.run;
	let flags: Vec<bool> = (0..run.task_pt.len()).map(|t| (run.task_w0[t] as usize..run.task_w1[t] as usize).any(|w| run.w_elite[w])).collect();
	let base = elite_rare_count(&seed.steps, &flags);
	let in_seed = |q: u32| seed.steps.iter().any(|s| s.q == q && s.kind == K_ACCEPT);
	let q = (0..run.n_quests() as u32).find(|&q| !in_seed(q) && (run.q_task0[q as usize]..run.q_task1[q as usize]).any(|t| flags[t as usize])).expect("an elite quest");
	let mut bad = seed.steps.clone();
	bad.push(Step { kind: K_ACCEPT, q, task: run.q_accept[q as usize], pt: run.q_giver[q as usize] });
	for t in run.q_task0[q as usize]..run.q_task1[q as usize] {
		bad.push(Step { kind: K_TASK, q, task: t as i32, pt: run.task_pt[t as usize] });
	}
	assert!(elite_rare_count(&bad, &flags) > base, "an elite camp added is caught");
	assert_eq!(elite_rare_count(&seed.steps, &flags), base, "v1's order passes");
}

#[test]
fn hearths_sixty_minutes_apart() {
	let o = common::orc();
	// (v1's plan lines only: no hearth the route chooses itself.)
	let base = Params::effective(common::params_doc().as_ref(), None, &[("freeHearth".into(), 0.0)]);
	let m0 = o.model(&[]);
	let seed: Order = o.seed();
	let run0 = &m0.run;
	let key = |s: Step| run0.step_key(s.kind, s.q, s.task);
	let quest_steps: Vec<usize> = (0..seed.len()).filter(|&i| key(seed.steps[i]).is_some()).collect();
	let bind_at = key(seed.steps[quest_steps[0]]).unwrap();
	// The inn nearest the start (Razor Hill).
	let first = seed.steps[quest_steps[0]].pt;
	let inn = (0..run0.inn_pt.len()).min_by(|&a, &b| run0.straight(first, run0.inn_pt[a]).total_cmp(&run0.straight(first, run0.inn_pt[b]))).unwrap() as u32;
	let model_with = |hearths: &[usize]| -> Model {
		let mut plan = TravelPlan::default();
		plan.bind.insert(bind_at, inn);
		for &i in hearths {
			plan.hearth.insert(key(seed.steps[i]).unwrap());
		}
		let pr = Profile { plan: Some(std::sync::Arc::new(plan)), ..Profile::average(Faction::Horde) };
		model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap().0
	};
	// (hearths cast, plan lines played on cooldown, seconds to the end, time before each step)
	let play = |m: &Model| -> (u32, u32, f64, Vec<f64>) {
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		let mut at = Vec::with_capacity(seed.len());
		for k in 0..seed.len() {
			at.push(ev.s.time);
			if ev.s.finished {
				continue;
			}
			ev.step_in(&seed.steps, k);
		}
		(ev.s.hearths, ev.s.plan_cooldown, ev.s.time, at)
	};
	// Two consecutive quest steps far from the bind: the first hearth is taken, the second line
	// comes minutes later, while the stone cools down: it is caught, and the route travels there.
	let mut found = false;
	for w in quest_steps.windows(2).skip(5).take(150) {
		let (h1, c1, _, _) = play(&model_with(&[w[0]]));
		if h1 == 0 || c1 != 0 {
			continue;
		}
		let mut m = model_with(&[w[0], w[1]]);
		let (h2, c2, t2, at) = play(&m);
		assert!(c2 > c1, "a second hearth line minutes after the first is caught");
		assert_eq!(h2, h1, "no second cast: the stone is cooling down, the route travels");
		assert!(at[w[1]] - at[w[0]] < 3600.0, "the second line comes within the hour");
		// F58: the plan keeps no hearth line the order meets on cooldown (the search starts from
		// none, and a kept edit never adds one): the line goes, nothing else changes.
		let cut = forge_sim::route::drop_cooling_hearths(&mut m, &o.walks, &seed.steps);
		assert_eq!(cut, vec![key(seed.steps[w[1]]).unwrap()], "the line on cooldown leaves the plan");
		let (h3, c3, t3, _) = play(&m);
		assert_eq!((h3, c3), (h1, 0), "no plan hearth on cooldown is left");
		assert_eq!(t3, t2, "the route travels as it did: the line was never cast");
		// The margin (hearthMargin 0.25): a line 60 to 75 min after the cast still finds the stone
		// cooling (the written guide's walk is timed faster than the route).
		let k = (w[0] + 1..seed.len()).find(|&k| key(seed.steps[k]).is_some() && at[k] - at[w[0]] > 3700.0 && at[k] - at[w[0]] < 4400.0).expect("a step 62-73 min after the cast");
		let (h4, c4, _, _) = play(&model_with(&[w[0], k]));
		assert_eq!((h4, c4), (h1, 1), "a line 62-73 min after the cast waits for the margin");
		found = true;
		break;
	}
	assert!(found, "a planned hearth the route takes");
}

#[test]
fn kill_work_waits_for_mobs_within_three_levels() {
	// A7, A8 (Khan Dez'hepah worked at 30, the lvl-26 Lieutenant Fangore at 21): a quest taken five
	// levels under (the accept window allows it) and its kills done at once, on mobs four or more
	// levels up: the character grinds to the mobs' level (at most the quest's) - workGap (3) first; with the rule off
	// (workGap 0), it does not.
	let o = common::orc();
	let m0 = o.model(&[]);
	let run = &m0.run;
	// (The mobs' level, capped at the quest's.)
	let top = |q: usize, t: u32| (run.task_w0[t as usize]..run.task_w1[t as usize]).filter(|&w| run.w_kind[w as usize] == W_KILL).map(|w| run.w_level[w as usize].min(run.q_level[q])).max();
	let kill_task = |q: usize| (run.q_task0[q]..run.q_task1[q]).find(|&t| top(q, t).is_some_and(|m| m - (run.q_level[q] - 5) > 3));
	let q = (0..run.n_quests())
		.find(|&q| run.q_level[q] >= 8 && run.q_pre[q].is_empty() && run.q_all[q].is_empty() && run.q_min_level[q] <= run.q_level[q] - 5 && kill_task(q).is_some())
		.expect("a kill quest on mobs near its level");
	let t = kill_task(q).unwrap();
	let lvl = run.q_level[q];
	let steps = [
		Step::grind((lvl - 5) as u32, 0),
		Step { kind: K_ACCEPT, q: q as u32, task: run.q_accept[q], pt: run.q_giver[q] },
		Step { kind: K_TASK, q: q as u32, task: t as i32, pt: run.task_pt[t as usize] },
	];
	// Grind seconds at the kill step.
	let play = |m: &Model| -> f64 {
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		ev.step_in(&steps, 0);
		assert!(ev.step_in(&steps, 1), "taken");
		assert_eq!(ev.level_now().floor() as i32, lvl - 5, "taken five levels under");
		let g0 = ev.s.grind_sec;
		assert!(ev.step_in(&steps, 2), "the kill step is played");
		ev.s.grind_sec - g0
	};
	assert!(play(&m0) > 0.0, "grinds up before the kills");
	assert_eq!(play(&o.model(&[("workGap".into(), 0.0)])), 0.0, "the rule off: the kills at once");
}

#[test]
fn a_quest_with_no_fight_is_taken_without_grinding_up_to_it() {
	// G6: The Green Hills of Stranglethorn (pages put together, no kill of its own) taken at 33 for
	// its level 40: no grind to quest level - 5 (dangerGap) first; a kill quest still grinds.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let fights = |q: usize| (run.q_task0[q]..run.q_task1[q]).any(|t| (run.task_w0[t as usize]..run.task_w1[t as usize]).any(|w| matches!(run.w_kind[w as usize], W_KILL | forge_sim::run::W_ESCORT)));
	let pick = |f: bool| (0..run.n_quests()).find(|&q| run.q_level[q] >= 10 && run.q_pre[q].is_empty() && run.q_all[q].is_empty() && run.q_min_level[q] <= run.q_level[q] - 7 && fights(q) == f).expect("a quest");
	// Grind seconds at the accept, taken seven levels under (the accept window's edge).
	let grind = |q: usize| -> f64 {
		let steps = [Step::grind((run.q_level[q] - 7) as u32, 0), Step { kind: K_ACCEPT, q: q as u32, task: run.q_accept[q], pt: run.q_giver[q] }];
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		ev.step_in(&steps, 0);
		let g0 = ev.s.grind_sec;
		assert!(ev.step_in(&steps, 1), "taken");
		ev.s.grind_sec - g0
	};
	assert_eq!(grind(pick(false)), 0.0, "no fight: taken at once");
	assert!(grind(pick(true)) > 0.0, "a kill quest: grinds to its level - 5 first");
}
