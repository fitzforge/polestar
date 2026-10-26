//! The four player-feedback guards, each failing on an order built to break it and passing on
//! v1's (RouteFeedback F06 #617 grind after the trip's hand-ins, F58 #576 hearths >= 60 min
//! apart, F12 #664 train at the next trainer on the way, F82 no elite or rare camps).

mod common;
use forge_core::Faction;
use forge_sim::guards::{elite_rare_count, grind_before_handin, train_bounces};
use forge_sim::order::Order;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{TravelPlan, K_ACCEPT, K_GRIND, K_TASK, K_TRAIN, K_TURNIN};
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
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let m0 = o.model(&[]);
	let seed: Order = o.seed();
	let run0 = &m0.run;
	let key = |s: Step| run0.step_key(s.kind, s.q, s.task);
	let quest_steps: Vec<usize> = (0..seed.len()).filter(|&i| key(seed.steps[i]).is_some()).collect();
	let bind_at = key(seed.steps[quest_steps[0]]).unwrap();
	// The inn nearest the start (Razor Hill).
	let first = seed.steps[quest_steps[0]].pt;
	let inn = (0..run0.inn_pt.len()).min_by(|&a, &b| run0.straight(first, run0.inn_pt[a]).total_cmp(&run0.straight(first, run0.inn_pt[b]))).unwrap() as u32;
	let with = |hearths: &[usize]| -> (u32, u32) {
		let mut plan = TravelPlan::default();
		plan.bind.insert(bind_at, inn);
		for &i in hearths {
			plan.hearth.insert(key(seed.steps[i]).unwrap());
		}
		let pr = Profile { plan: Some(std::sync::Arc::new(plan)), ..Profile::average(Faction::Horde) };
		let m = model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap().0;
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		for k in 0..seed.len() {
			if ev.s.finished {
				break;
			}
			ev.step_in(&seed.steps, k);
		}
		(ev.s.hearths, ev.s.plan_cooldown)
	};
	// Two consecutive quest steps far from the bind: the first hearth is taken, the second line
	// comes while the stone cools down.
	let mut found = false;
	for w in quest_steps.windows(2).skip(5).take(150) {
		let (h1, c1) = with(&[w[0]]);
		if h1 == 0 || c1 != 0 {
			continue;
		}
		let (_, c2) = with(&[w[0], w[1]]);
		assert!(c2 > c1, "a second hearth line minutes after the first is caught");
		found = true;
		break;
	}
	assert!(found, "a planned hearth the route takes");
}
