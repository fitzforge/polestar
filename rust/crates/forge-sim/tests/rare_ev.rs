//! Quests started by a rare drop are valued at expected value (route profiles): the chance of the
//! drop from the kills the route already makes of its source mobs, 1 − Π (1 − c)^kills; its
//! reward, and its chain's after it, at that chance; never farmed for.

mod common;
use forge_core::Faction;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{K_ACCEPT, K_TASK, K_TURNIN, W_KILL};
use forge_sim::{Model, Params};
use std::sync::Arc;

#[test]
fn a_rare_start_is_worth_its_chance_from_the_route_s_kills() {
	let o = common::orc();
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let seed = o.seed();
	let m0 = o.model(&[]);
	let run0 = &m0.run;
	let st = &seed.steps;
	// A mob the route kills for a task, and a later quest (taken by an npc, handed in later)
	// whose follow-up is in the order too.
	let (t, mob) = (0..st.len())
		.filter(|&i| st[i].kind == K_TASK)
		.find_map(|i| (run0.task_w0[st[i].task as usize]..run0.task_w1[st[i].task as usize]).find(|&w| run0.w_kind[w as usize] == W_KILL).map(|w| (i, run0.w_mob[w as usize])))
		.unwrap();
	let pos = |k: u8, q: u32| st.iter().position(|s| s.kind == k && s.q == q);
	let (x, y) = (t + 1..st.len())
		.filter(|&i| st[i].kind == K_ACCEPT && run0.q_accept[st[i].q as usize] < 0)
		.find_map(|i| {
			let x = st[i].q;
			let y = (0..run0.n_quests() as u32).find(|&y| run0.q_pre[y as usize].contains(&x) && pos(K_ACCEPT, y).is_some_and(|a| a > pos(K_TURNIN, x).unwrap_or(usize::MAX)))?;
			pos(K_TURNIN, x).map(|_| (x, y))
		})
		.expect("a quest after the kills, with a follow-up in the order");
	let xid = run0.q_id[x as usize];
	let model = |rare: Option<Vec<(u32, Vec<(u32, f64)>)>>| -> Model {
		let pr = Profile { rare: rare.map(Arc::new), ..Profile::average(Faction::Horde) };
		model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap().0
	};
	// (weight of x after its accept, x's reward XP, y's weight after its accept, y's reward XP)
	let play = |m: &Model| -> (f64, f64, f64, f64) {
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		let (mut wx, mut gx, mut wy, mut gy) = (1.0, 0.0, 1.0, 0.0);
		for k in 0..st.len() {
			let before = ev.s.xp_quest;
			ev.step_in(st, k);
			let w = |q: u32| ev.weight.get(q as usize).copied().unwrap_or(1.0);
			match (st[k].kind, st[k].q) {
				(K_ACCEPT, q) if q == x => wx = w(x),
				(K_ACCEPT, q) if q == y => wy = w(y),
				(K_TURNIN, q) if q == x => gx = ev.s.xp_quest - before,
				(K_TURNIN, q) if q == y => {
					gy = ev.s.xp_quest - before;
					break;
				}
				_ => {}
			}
		}
		(wx, gx, wy, gy)
	};
	let (_, gx0, _, gy0) = play(&model(None));
	let c = 0.03;
	let m = model(Some(vec![(xid, vec![(mob, c)])]));
	let (wx, gx, wy, gy) = play(&m);
	assert!(wx > 0.0 && wx < 1.0, "the chance from the kills so far: {wx}");
	assert!((gx - gx0 * wx).abs() < 1e-6 * gx0.max(1.0), "x's reward at its chance: {gx} vs {gx0} x {wx}");
	assert!((wy - wx).abs() < 1e-9, "the follow-up is had as often");
	assert!(gy < gy0, "its reward too");
	// No source the route kills: worth nothing.
	let (wx, gx, _, _) = play(&model(Some(vec![(xid, vec![(u32::MAX, c)])])));
	assert_eq!((wx, gx), (0.0, 0.0));
}
