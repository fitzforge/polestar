//! The flow flags (forge_core::flow_flags, #1046): off, every pass and price is as before; on, the
//! sweep pass does work where the route already stands, the revisit price counts the flow guards and
//! the greedy reach widens the hub pickup. One test function: the flags are process-wide.

mod common;
use forge_sim::run::{K_ACCEPT, K_GRIND, K_TASK};
use forge_sim::search::edits::Mv;
use forge_sim::search::passby::{hub_pickup_reach, work_while_there, GREEDY_ALLOW_SEC, GREEDY_PICKUP_YD, HUB_PICKUP_ALLOW_SEC, HUB_PICKUP_YD, SWEEP_ALLOW_SEC};
use forge_sim::search::{pool, runs, Member, Problem};

#[test]
fn flow_flags_off_change_nothing_and_on_do_work_where_the_route_stands() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, common::pairs(r, &seed), pool(r, &rules, &seed, &m.tables));
	let counts = forge_sim::guards::GuardCounts { avoidable_returns: 2, split_work: 3, passed_by: 5, passed_by_never: 4, ..Default::default() };

	// Off: no sweep, no flow price, the pickup reach as it was.
	forge_core::flow_flags::set_for_tests(&[]);
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	assert!(work_while_there(&p, &mut mem, &mut |_| {}).is_empty(), "no sweep without the flag");
	assert_eq!(forge_sim::guards::flow_pen(&counts), 0.0, "no flow price without the flag");
	assert_eq!(hub_pickup_reach(), (HUB_PICKUP_YD, HUB_PICKUP_ALLOW_SEC));

	// Greedy: the wider reach.
	forge_core::flow_flags::set_for_tests(&["greedy"]);
	assert_eq!(hub_pickup_reach(), (GREEDY_PICKUP_YD, GREEDY_ALLOW_SEC));

	// Revisit: the flow counts priced (2 returns, 3 split works, 1 giver passed and taken later).
	forge_core::flow_flags::set_for_tests(&["revisit"]);
	let want = 2.0 * forge_sim::guards::RETURN_COST_SEC + 4.0 * forge_sim::guards::FLOW_COUNT_SEC;
	assert_eq!(forge_sim::guards::flow_pen(&counts), want);

	// Sweep: a task done on a return moves to the earlier stop on its ground, within the allowance,
	// after its accept.
	forge_core::flow_flags::set_for_tests(&["sweep"]);
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let kept = work_while_there(&p, &mut mem, &mut |l| eprintln!("{l}"));
	assert!(!kept.is_empty(), "v1's Orc order keeps some work for a return to its ground");
	for pk in &kept {
		assert!(pk.added <= SWEEP_ALLOW_SEC + 1e-6, "within the allowance: {:+.1} s", pk.added);
		let Mv::Move { s, to, .. } = pk.mv else { panic!("a move") };
		assert!(to < s, "earlier");
		let st = pk.before.steps[s];
		assert_eq!(st.kind, K_TASK);
		let at = mem.order.steps.iter().position(|x| x.kind == K_TASK && x.q == st.q && x.task == st.task).unwrap();
		let acc = mem.order.steps.iter().position(|x| x.kind == K_ACCEPT && x.q == st.q).unwrap();
		assert!(acc < at, "after its accept");
		assert!(mem.order.steps[..at].iter().rev().any(|x| x.kind != K_GRIND), "after a stop");
	}
	forge_core::flow_flags::set_for_tests(&[]);
}
