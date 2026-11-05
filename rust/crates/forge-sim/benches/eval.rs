//! Evaluations per second: a full replay of v1's Orc order (v1 model and camps + spots), and
//! search tries (windowed replay with the estimate), on the committed golden (rust/tests/golden/sim).

#[path = "../tests/common/mod.rs"]
mod common;
use criterion::{criterion_group, criterion_main, Criterion};
use forge_sim::order::{deliberate_pairs, play_order};
use forge_sim::search::{pool, runs, Member, Problem};

fn bench(c: &mut Criterion) {
	let o = common::orc();
	let seed = o.seed();
	for (name, over) in [("v1", vec![]), ("camps+spots", vec![("camps".to_string(), 1.0), ("spots".to_string(), 1.0)])] {
		let m = o.model(&over);
		let mut ev = m.evaluator(&o.walks);
		c.bench_function(&format!("full replay, {name}"), |b| b.iter(|| play_order(&mut ev, &seed.steps).0));
		let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
		let p = Problem::single(&m, &o.walks, deliberate_pairs(&m.run), pool(&m.run, &rules, &seed, &m.tables));
		let start = runs(&p, &seed);
		let mut mem = Member::new(&p, seed.clone(), &start, 1);
		c.bench_function(&format!("search try, {name}"), |b| b.iter(|| mem.try_one(&p)));
	}
}

criterion_group! { name = benches; config = Criterion::default().sample_size(20); targets = bench }
criterion_main!(benches);
