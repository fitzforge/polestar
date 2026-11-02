//! A deliberate `together` pair whose task has its work at several camps is done at its camp nearest
//! its pair (RevH1 c13, #274: the Raptor Horns with Vrang's hides in the Dry Hills, not at the Raptor
//! Grounds 2981 yd off, which split the Dry Hills visit). Its own test binary: it sets the route fixes.

mod common;
use forge_sim::run::W_KILL;
use serde_json::json;

fn fixes(together: serde_json::Value) {
	forge_sim::fixes::set(json!({ "deliberate": { "together": together }, "overrides": {} }));
}

#[test]
fn a_together_task_takes_its_camp_nearest_its_pair() {
	let o = common::orc();
	fixes(json!([]));
	let before = o.model(&[]);
	let r = &before.run;
	// A task (b) whose first kill work lives at several camps, and another quest's task (a) nearer a
	// camp of b's other than b's own site: the pair the rule would put together. (Each named by one of
	// its objectives, as a record names a task: route fixes `["task", q, i]`, i 0-based.)
	let named = |t: usize| r.t_quest[t] >= 0 && r.task_objs[t] != 0;
	let first_kill = |t: usize| (r.task_w0[t] as usize..r.task_w1[t] as usize).find(|&w| r.w_kind[w] == W_KILL && r.w_alts[w].len() > 1);
	let pick = (0..r.task_pt.len()).filter(|&tb| named(tb)).filter_map(|tb| first_kill(tb).map(|w| (tb, w))).find_map(|(tb, w)| {
		let qb = r.t_quest[tb];
		(0..r.task_pt.len()).filter(|&ta| named(ta) && r.t_quest[ta] != qb).find_map(|ta| {
			let to = r.task_pt[ta];
			let near = r.w_alts[w].iter().map(|x| r.camps[x.0 as usize].pt).min_by(|x, y| r.straight(*x, to).total_cmp(&r.straight(*y, to)))?;
			(r.straight(near, to) + 500.0 < r.straight(r.task_pt[tb], to)).then_some((ta, tb, near))
		})
	});
	let (ta, tb, near) = pick.expect("a task with camps and another quest's task nearer one of them than its site");
	let (qa, qb) = (r.q_id[r.t_quest[ta] as usize], r.q_id[r.t_quest[tb] as usize]);
	let obj = |t: usize| r.task_objs[t].trailing_zeros();
	fixes(json!([{ "a": ["task", qa, obj(ta)], "b": ["task", qb, obj(tb)], "why": "test" }]));
	let after = o.model(&[]);
	let r2 = &after.run;
	assert_ne!(r.task_pt[tb], near, "the camp nearest the pair is not the task's own site");
	assert_eq!(r2.task_pt[tb], near, "task {tb} (quest {qb}) at its camp nearest quest {qa}'s task, not its site {}", r.task_pt[tb]);
	assert_eq!(r2.task_pt[ta], r.task_pt[ta], "the pair's own place stays");
}
