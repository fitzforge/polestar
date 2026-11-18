//! Saved levels obey the same starting-level cutoff as the simulator, while keeping the recorded
//! prefix hydrated for callers that use the levels without truncating their goal list.

use forge_judge::walk::{DumpLevels, LevelModel, WalkGoal};

fn goals(n: usize) -> Vec<WalkGoal> {
	(0..n)
		.map(|i| WalkGoal {
			i,
			guide: "recorded/test".into(),
			file: String::new(),
			line: None,
			step: None,
			t: "goto".into(),
			q: None,
			oi: None,
			optional: false,
			passing: false,
			map: None,
			w: None,
			npc: None,
			level: None,
			title: None,
			lvl: 0.0,
			time: 0.0,
			lvl_after: 0.0,
			time_after: 0.0,
			grind: f64::NAN,
			pos: None,
			along: None,
			label: None,
			item: None,
			class: false,
			spots: Vec::new(),
			location: None,
			land: None,
		})
		.collect()
}

fn recorded() -> DumpLevels {
	DumpLevels(vec![[1.0, 0.0, 2.25, 60.0], [2.25, 60.0, 3.0, 120.0], [3.0, 120.0, 4.0, 180.0]])
}

fn levels(g: &WalkGoal) -> [f64; 4] {
	[g.lvl, g.time, g.lvl_after, g.time_after]
}

#[test]
fn cuts_before_the_first_goal_starting_at_or_above_the_requested_level() {
	// The goal crossing the threshold stays, even when it finishes above it. The next goal's
	// starting level decides the cut; fractional thresholds and equality have the same rule.
	for (to, expected) in [(1.0, 0), (2.0, 1), (2.25, 1), (2.5, 2), (3.0, 2), (4.0, 3), (61.0, 3)] {
		let mut g = goals(3);
		assert_eq!(recorded().replay(&mut g, to), expected, "to={to}");
	}
}

#[test]
fn hydrates_the_whole_recorded_prefix_even_after_the_returned_cut() {
	let dump = recorded();
	let mut g = goals(4);
	let cut = dump.replay(&mut g, 2.0);
	// guidetext parity consumes these values and deliberately ignores the returned cut.
	assert_eq!(g[..3].iter().map(levels).collect::<Vec<_>>(), dump.0);
	assert_eq!(levels(&g[3]), [0.0; 4], "an unrecorded goal is left untouched");
	assert_eq!(cut, 1);
}

#[test]
fn recording_or_goal_list_end_still_bounds_the_walk() {
	for (goal_count, recording_count, expected) in [(3, 0, 0), (3, 1, 1), (3, 2, 2), (2, 3, 2), (0, 3, 0)] {
		let mut g = goals(goal_count);
		let dump = DumpLevels(recorded().0[..recording_count].to_vec());
		assert_eq!(dump.replay(&mut g, 61.0), expected, "{goal_count} goals, {recording_count} recorded rows");
		assert_eq!(g[..expected].iter().map(levels).collect::<Vec<_>>(), dump.0[..expected]);
	}
}

#[test]
fn unknown_recorded_levels_do_not_count_as_reaching_the_cutoff() {
	// The CLI represents missing/null recorded numbers as NaN. It is not evidence that the
	// threshold was reached: keep looking for the first positive `lvl >= to` comparison.
	let dump = DumpLevels(vec![[1.0, 0.0, 2.0, 60.0], [f64::NAN, 60.0, 3.0, 120.0], [3.0, 120.0, 4.0, 180.0]]);
	let mut g = goals(3);
	assert_eq!(dump.replay(&mut g, 2.0), 2);
	assert!(g[1].lvl.is_nan());
	// Preserve the model's comparison semantics for an unknown threshold, as SimLevels does;
	// deciding whether the CLI accepts such an option is a separate input-validation concern.
	assert_eq!(dump.replay(&mut g, f64::NAN), 3);
}
