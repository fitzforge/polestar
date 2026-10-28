//! Pooled kills (route profiles): a kill work meets the mobs of the other open quests' kill
//! objectives on overlapping ground (their site within POOL_YD) and kills them as met, so a quest
//! held open over another's work in the same place needs less (or no) trip of its own.

mod common;
use forge_sim::eval::POOL_YD;
use forge_sim::run::{K_ACCEPT, K_TASK, W_KILL};

#[test]
fn an_open_objective_on_the_same_ground_is_killed_during_another_s_work() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	let kill = |t: usize| (r.task_w0[t] as usize..r.task_w1[t] as usize).find(|&w| r.w_kind[w] == W_KILL && !r.w_elite[w] && r.w_share[w].is_empty());
	let pos = |k: u8, q: u32| st.iter().position(|s| s.kind == k && s.q == q);
	// A kill task at i, and another quest's kill task at j > i on ground within POOL_YD, that
	// quest taken before i.
	let (i, j, wb) = (0..st.len())
		.filter(|&i| st[i].kind == K_TASK && kill(st[i].task as usize).is_some())
		.find_map(|i| {
			let a = r.task_pt[st[i].task as usize];
			(i + 1..st.len()).find_map(|j| {
				let (s, t) = (st[j], st[j].task as usize);
				if s.kind != K_TASK {
					return None;
				}
				let wb = kill(t)?;
				(s.q != st[i].q && pos(K_ACCEPT, s.q).is_some_and(|x| x < i) && r.p_r[a as usize] == r.p_r[r.task_pt[t] as usize] && r.straight(a, r.task_pt[t]) <= POOL_YD).then_some((i, j, wb))
			})
		})
		.expect("two open kill tasks on one ground");
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	for k in 0..i {
		ev.step_in(st, k);
	}
	let before = ev.killed[wb];
	ev.step_in(st, i);
	assert!(ev.killed[wb] > before, "the other objective's mobs are killed during the work at step {i}");
	assert!(ev.s.pooled_kills > 0.0);
	let _ = j;
}
