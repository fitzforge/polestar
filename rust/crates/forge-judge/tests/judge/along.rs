//! The judge's walk plays `along` steps as the addon does: their goals are done on the walk the route
//! already takes, not walked to where the along step stands (RsWriter's engine pass writes them; the
//! judge walked to each one at its step: about +0.9 h on r8).

use forge_judge::walk::{along_on_the_way, WPt, WalkGoal};

fn goal(i: usize, t: &str, q: Option<i64>, oi: Option<i64>, x: f64, along: Option<&str>, label: Option<&str>) -> WalkGoal {
	let w = WPt { c: 1, wx: x, wy: 0.0, map: 1413 };
	WalkGoal {
		i,
		guide: "forever/test/01-barrens".into(),
		file: "01-barrens.guide".into(),
		line: Some(10 + i as u32),
		step: Some(i as u32 + 1),
		t: t.into(),
		q,
		oi,
		optional: false,
		passing: false,
		map: Some(1413),
		w: Some(w),
		npc: None,
		level: None,
		title: None,
		lvl: 15.0,
		time: 0.0,
		lvl_after: 15.0,
		time_after: 0.0,
		grind: f64::NAN,
		pos: Some(w),
		along: along.map(str::to_string),
		label: label.map(str::to_string),
		item: None,
		spots: Vec::new(),
		class: false,
	}
}

/// Yards walked from goal to goal.
fn walked(goals: &[WalkGoal]) -> f64 {
	goals.windows(2).map(|p| (p[0].w.unwrap().wx - p[1].w.unwrap().wx).abs()).sum()
}

/// The Harpy Lieutenant rings (875): taken at the Crossroads, listed `along until q875` there, other work
/// on the way, the labelled step at the Dry Hills where the route kills the harpies.
fn barrens() -> Vec<WalkGoal> {
	vec![
		goal(0, "accept", Some(875), None, 0.0, None, None),
		goal(1, "collect", Some(875), Some(0), 3000.0, Some("q875"), None),
		goal(2, "accept", Some(903), None, 0.0, None, None),
		goal(3, "kill", Some(903), Some(0), 1500.0, None, None),
		goal(4, "collect", Some(875), Some(0), 3000.0, None, Some("q875")),
		goal(5, "turnin", Some(875), None, 0.0, None, None),
	]
}

#[test]
fn along_goal_is_not_walked_to_at_its_step() {
	let as_written = barrens();
	// Before: the along goal walked to where its step stands, then back for the rest.
	assert_eq!(walked(&as_written), 3000.0 + 3000.0 + 1500.0 + 1500.0 + 3000.0);
	let played = along_on_the_way(as_written);
	// After: the labelled step does the rings; no detour.
	assert_eq!(played.iter().filter(|g| g.q == Some(875) && g.t == "collect").count(), 1);
	assert_eq!(walked(&played), 1500.0 + 1500.0 + 3000.0);
	assert!(played.iter().enumerate().all(|(i, g)| g.i == i));
}

#[test]
fn along_goal_with_no_later_copy_is_credited_at_its_label() {
	let mut g = barrens();
	g.remove(4);
	g.insert(4, goal(4, "kill", Some(904), Some(0), 3000.0, None, Some("q875")));
	let played = along_on_the_way(g);
	let at = |t: &str, q: i64| played.iter().position(|x| x.t == t && x.q == Some(q)).unwrap();
	// Done on arrival at the labelled step, before its own goals.
	assert_eq!(at("collect", 875), at("kill", 904) - 1);
	assert!(at("collect", 875) > at("kill", 903));
}

#[test]
fn along_copy_of_a_goal_later_in_the_labelled_step_goes() {
	let mut g = barrens();
	// The labelled step starts with another goal, the rings second.
	g.insert(4, goal(4, "kill", Some(904), Some(0), 3000.0, None, Some("q875")));
	let played = along_on_the_way(g);
	assert_eq!(played.iter().filter(|g| g.q == Some(875) && g.t == "collect").count(), 1);
}
