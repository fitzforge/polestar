//! The accept level rule (forge_sim::gate): no quest is accepted where the model's level is under
//! its minimum, on the golden Orc slice. c19r took Lazy Peons (5441, minimum 3) at the Den at 2.6:
//! the c17 record `together accept 4402 / accept 5441` moved it to Galgar's Cactus Apple Surprise,
//! and nothing checked the level (the evaluator ground the rest of level 2 there unseen).

mod common;
use forge_sim::gate::{levels, under_min};
use forge_sim::order::{keep_records, Order, Together};
use forge_sim::run::{K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_sim::search::passby::accept_gates;
use forge_sim::search::{pool, runs, search, Member, Mode, Problem, SearchOpts};

fn problem<'a>(o: &'a common::Orc, m: &'a forge_sim::Model, seed: &Order) -> Problem<'a> {
	let r = &m.run;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	Problem::single(m, &o.walks, common::pairs(r, seed), pool(r, &rules, seed, &m.tables))
}

/// The golden seed with 5441's accept right after 4402's (what the together record asks), and
/// whether that takes it under its minimum.
fn den_order(o: &common::Orc, m: &forge_sim::Model) -> (Order, u32, u32) {
	let r = &m.run;
	let seed = o.seed();
	let (a, b) = (r.q(4402).expect("4402 in the slice"), r.q(5441).expect("5441 in the slice"));
	let ia = seed.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == a).expect("4402's accept");
	let ib = seed.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == b).expect("5441's accept");
	assert!(ib > ia + 1, "v1 takes Lazy Peons later than Galgar's quest");
	let mut o2 = seed.clone();
	let (s, g) = (o2.steps.remove(ib), o2.origin.remove(ib));
	o2.steps.insert(ia + 1, s);
	o2.origin.insert(ia + 1, g);
	(o2, a, b)
}

#[test]
fn a_record_repair_never_takes_a_quest_under_its_minimum_level() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let mut ev = m.evaluator(&o.walks);
	let (a, b) = (r.q(4402).unwrap(), r.q(5441).unwrap());
	let t = Together { ka: K_ACCEPT, qa: a, kb: K_ACCEPT, qb: b, ta: -1, tb: -1, near: Vec::new() };
	assert!(!under_min(r, &seed.steps, &levels(&mut ev, &seed.steps)).contains(&5441), "v1 takes it at its level");
	// Without the rule (no evaluator): the repair takes Lazy Peons beside Galgar's, under level 3.
	let (plain, _) = keep_records(r, &seed, &[], &[], std::slice::from_ref(&t), &[], None);
	assert!(under_min(r, &plain.steps, &levels(&mut ev, &plain.steps)).contains(&5441), "the c19r case: the repair alone takes it under its minimum");
	// With it: at its giver's next stop at level 3 before its work, or the repair refused; named.
	let (out, notes) = keep_records(r, &seed, &[], &[], &[t], &[], Some(&mut ev));
	let lv = levels(&mut ev, &out.steps);
	assert!(!under_min(r, &out.steps, &lv).contains(&5441), "{notes:?}");
	assert!(notes.iter().any(|n| n.contains("quest 5441") && n.contains("under its minimum 3")), "{notes:?}");
	let acc = out.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == b).unwrap();
	let work = out.steps.iter().position(|s| s.q == b && matches!(s.kind, K_TASK | K_TURNIN)).unwrap();
	assert!(acc < work, "taken before its work");
}

#[test]
fn the_pass_takes_what_is_left_under_its_minimum_at_its_giver_s_next_stop_or_behind_a_level_step() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let (bad, _, b) = den_order(&o, &m);
	let p = problem(&o, &m, &bad);
	let before = &runs(&p, &bad)[0];
	assert!(under_min(r, &before.steps, before.levels()).contains(&5441), "the c19r order takes it at {:.2}", before.levels()[bad.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == b).unwrap()]);
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut log = Vec::new();
	let kept = accept_gates(&p, &mut mem, &mut |s| log.push(s.to_string()));
	assert!(!kept.is_empty(), "{log:?}");
	let after = &runs(&p, &mem.order)[0];
	assert!(under_min(r, &after.steps, after.levels()).is_empty(), "{log:?}");
	assert!(log.iter().any(|l| l.starts_with("accept gate 5441")), "{log:?}");
	let k = mem.order.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == b).unwrap();
	let work = mem.order.steps.iter().position(|s| s.q == b && matches!(s.kind, K_TASK | K_TURNIN)).unwrap();
	assert!(k < work, "before its work");
	let lv = after.levels()[k];
	assert!(lv >= 3.0 - 1e-9, "at its minimum: {lv:.2}");
	if mem.order.steps[k - 1].kind != K_GRIND {
		assert!(forge_sim::gate::picks_up(r, &mem.order.steps, k, mem.order.steps[k].pt), "at a stop by its giver");
	}
}

#[test]
fn the_search_never_takes_a_quest_under_its_minimum_level() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let was = {
		let c = &runs(&p, &seed)[0];
		under_min(r, &c.steps, c.levels())
	};
	let opts = SearchOpts { mode: Mode::Free, tries: 6000, members: 2, seed: 7, share_every: 250, ..Default::default() };
	let out = search(&p, &seed, &opts, None);
	let c = &runs(&p, &out.best)[0];
	let now = under_min(r, &c.steps, c.levels());
	assert!(now.iter().all(|q| was.contains(q)), "the search took {:?} under their minimum (the seed: {was:?})", now.iter().filter(|q| !was.contains(q)).collect::<Vec<_>>());
	assert!(out.stats.refused[7] > 0, "the rule refused moves: {:?}", out.stats.refused);
}
