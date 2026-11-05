//! Counters × parameters (DeepResearch §1.3): an order's counters priced under its own
//! parameters give its time exactly; under other draws they approximate a full replay (the
//! order's decisions and levels held). Prints the error per draw.

mod common;
use forge_sim::order::play_order;
use forge_sim::params::draws;
use forge_sim::Params;

#[test]
fn counters_reprice_the_route() {
	let o = common::orc();
	let seed = o.seed();
	for over in [vec![], vec![("camps".to_string(), 1.0), ("spots".to_string(), 1.0)]] {
		let m = o.model(&over);
		let mut ev = m.evaluator(&o.walks);
		let (secs, _) = play_order(&mut ev, &seed.steps);
		let priced = ev.s.c.seconds(&m.run, &m.tables.p);
		eprintln!("{over:?}: replay {:.4} h, counters {:.4} h", secs / 3600.0, priced / 3600.0);
		assert!((priced - ev.s.time).abs() < 1e-6 * ev.s.time, "counters price the route's own time");
		let c = ev.s.c.clone();
		let mut worst: f64 = 0.0;
		for d in draws(common::params_doc().as_ref(), 8, 7) {
			let mut all = over.clone();
			all.extend(d);
			let md = o.model(&all);
			let mut evd = md.evaluator(&o.walks);
			let (full, _) = play_order(&mut evd, &seed.steps);
			let p: &Params = &md.tables.p;
			let est = c.seconds(&m.run, p);
			let err = (est - full) / full;
			worst = worst.max(err.abs());
			eprintln!("  draw: full {:.2} h, counters {:.2} h ({:+.1} %)", full / 3600.0, est / 3600.0, 100.0 * err);
		}
		assert!(worst < 0.25, "counters within 25 % of a full replay under a draw");
	}
}
