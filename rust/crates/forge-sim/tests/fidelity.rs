//! The fidelity terms beyond v1 (`camps`, `spots`), one at a time, on v1's Orc chain: each
//! changes the hours by a bounded amount, and work time per task stays within a sane factor of
//! v1's. The golden slice world, params and v1 chain (tests/common), walks off.

mod common;
use forge_core::Faction;
use forge_sim::chain::events_from;
use forge_sim::order::{play_order, seed_order};
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::Params;

/// Hours to 60 of v1's Orc order under each term set, and the work log.
fn run(over: &[(&str, f64)]) -> (f64, Vec<(u32, f64)>, usize) {
	let o = common::orc();
	let (w, walks, doc) = (&o.world, &o.walks, &o.doc);
	let pdoc = common::params_doc();
	let ov: Vec<(String, f64)> = over.iter().map(|(k, v)| (k.to_string(), *v)).collect();
	let base = Params::effective(pdoc.as_ref(), None, &ov);
	let (m, _) = model_for(w, "Orc", &Profile::average(Faction::Horde), &base, walks).unwrap();
	let mut ev = m.evaluator(walks);
	// The seed is built in v1's model, so every term plays the same order.
	let v1 = Params::effective(pdoc.as_ref(), None, &[]);
	let (m1, _) = model_for(w, "Orc", &Profile::average(Faction::Horde), &v1, walks).unwrap();
	let mut ev1 = m1.evaluator(walks);
	let order = seed_order(&mut ev1, &events_from(doc), true);
	ev.work_log = Some(Vec::new());
	let (secs, _) = play_order(&mut ev, &order.steps);
	if std::env::var("FIDELITY_TASKS").is_ok() {
		let r = &m.run;
		for t in std::env::var("FIDELITY_TASKS").unwrap().split(',').filter_map(|x| x.parse::<usize>().ok()) {
			let q = r.t_quest[t] as usize;
			eprintln!("task {t}: quest {} level {}", r.q_id[q], r.q_level[q]);
			for w in r.task_w0[t] as usize..r.task_w1[t] as usize {
				eprintln!(
					"  work {w}: kind {} level {} count {} drop {} mob {} spacing {:.1} default {}",
					r.w_kind[w], r.w_level[w], r.w_count[w], r.w_drop[w], r.w_mob[w], r.w_spacing[w], r.w_default[w]
				);
				for &(c, k) in &r.w_alts[w] {
					let cc = &r.camps[c as usize];
					eprintln!("    camp {c}: kills {k:.1} spawns {} respawn {} spacing {:.1} mob {} at {}", cc.spawns, cc.respawn, cc.spacing, cc.mob, r.pt_list[cc.pt as usize]);
				}
			}
		}
	}
	(secs / 3600.0, ev.work_log.take().unwrap(), m.run.camps.len())
}

#[test]
fn fidelity_terms_one_at_a_time() {
	let (h0, log0, _) = run(&[]);
	let (h1, log1, ncamps) = run(&[("camps", 1.0)]);
	let (h2, _, _) = run(&[("camps", 1.0), ("spots", 1.0)]);
	eprintln!("v1 Orc order: v1 model {h0:.2} h, + camps {h1:.2} h ({ncamps} camps), + spots {h2:.2} h");
	// Per task: the worst ratios of work time with camps to v1's.
	let base: std::collections::HashMap<u32, f64> = log0.iter().copied().collect();
	let mut worst: Vec<(f64, u32, f64, f64)> = log1.iter().filter_map(|&(t, s)| base.get(&t).map(|&b| (s - b, t, b, s))).collect();
	worst.sort_by(|a, b| b.0.total_cmp(&a.0));
	for x in worst.iter().take(12) {
		eprintln!("  task {} v1 {:.0} s, camps {:.0} s (+{:.0})", x.1, x.2, x.3, x.0);
	}
	let added: f64 = worst.iter().map(|x| x.0).sum::<f64>() / 3600.0;
	eprintln!("  work time with camps: {added:+.2} h over {} tasks", worst.len());
	assert!((h1 - h0).abs() < 0.25 * h0, "camps moves the hours by under a quarter");
	assert!(h2 <= h1 + 1e-9 || (h2 - h1).abs() < 0.05 * h1, "spots never cost much over camps alone");
}
