//! The flow flags (forge_core::flow_flags, #1046): off, every pass and price is as before; on, the
//! sweep pass does work where the route already stands, the revisit price counts the flow guards and
//! the greedy reach widens the hub pickup, and the zone-left price counts quests a zone is left with.
//! One test function: the flags are process-wide.

mod common;
use forge_sim::run::{K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_sim::search::edits::Mv;
use forge_sim::search::passby::{hub_pickup_reach, pickup_bar, work_while_there, GREEDY_ALLOW_SEC, GREEDY_PICKUP_YD, HUB_PICKUP_ALLOW_SEC, HUB_PICKUP_YD, SWEEP_ALLOW_SEC};
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
	assert_eq!(pickup_bar(), (1.0, 0.5), "the route's rate, half on a cheap detour");

	// Greedy: the wider reach.
	forge_core::flow_flags::set_for_tests(&["greedy"]);
	assert_eq!(hub_pickup_reach(), (GREEDY_PICKUP_YD, GREEDY_ALLOW_SEC));

	// Coverage: marginal pickups at half the rate.
	forge_core::flow_flags::set_for_tests(&["coverage"]);
	assert_eq!(pickup_bar(), (0.5, 0.25));

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

	// Zoneleft: a quest the route leaves its zone without, open and on level there, counts once; the
	// count is priced at ZONE_LEFT_SEC; without the flag it is neither counted nor priced.
	let mut data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&common::golden().join("world/root"))).unwrap();
	// (The slice records few rewards: every quest gets one, so the zone's quests count.)
	for q in data.quests.values_mut() {
		q.xp.get_or_insert(500.0);
	}
	let atlas = forge_world::Atlas::build(&o.world, &data, None);
	let g = forge_sim::guards::GuardData::new(&o.world, r, &rules, &data, &atlas, &o.walks);
	let zone_left = |ord: &forge_sim::order::Order| runs(&p, ord)[0].guard_counts(&g, r).zone_left;
	forge_core::flow_flags::set_for_tests(&["zoneleft"]);
	let base = zone_left(&seed);
	let needed = |q: u32| (0..r.n_quests()).any(|x| r.q_pre[x].contains(&q) || r.q_all[x].contains(&q) || r.q_parent[x] == q as i32);
	let without = |q: u32| {
		let mut o2 = forge_sim::order::Order { steps: Vec::new(), origin: Vec::new() };
		for (k, st) in seed.steps.iter().enumerate() {
			if st.q != q || !matches!(st.kind, K_ACCEPT | K_TASK | K_TURNIN) {
				o2.steps.push(*st);
				o2.origin.push(seed.origin[k]);
			}
		}
		o2
	};
	let candidates: Vec<u32> = seed.steps.iter().filter(|st| st.kind == K_ACCEPT && !needed(st.q)).map(|st| st.q).take(40).collect();
	let left = candidates.iter().copied().find(|&q| zone_left(&without(q)) == base + 1);
	assert!(left.is_some(), "dropping one of v1's quests leaves its zone with it ({base} before)");
	let priced = forge_sim::guards::GuardCounts { zone_left: 3, ..Default::default() };
	assert_eq!(forge_sim::guards::flow_pen(&priced), 3.0 * forge_sim::guards::ZONE_LEFT_SEC);
	assert!(forge_sim::guards::flow_head() > 0.0, "a candidate may cost model time before its counts are read");
	forge_core::flow_flags::set_for_tests(&[]);
	assert_eq!(zone_left(&without(left.unwrap())), 0, "not counted without the flag");
	assert_eq!(forge_sim::guards::flow_pen(&priced), 0.0);
}
