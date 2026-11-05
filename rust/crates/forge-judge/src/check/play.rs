//! Rules from how Polestar plays a step (Engine.lua, GUIDE_FORMAT.md): the arrow leads to the step's
//! first open blocking goal in written order; `loop` makes the step's gotos one search circuit for all
//! its field goals; `along until` lists quest-counted goals to do while travelling. They read the walk
//! as written: `along` goals at their own steps (not moved to where the addon credits them).

use super::*;

/// Two field objectives' spawn areas overlap within this many yards (spot centres).
pub const OVERLAP_YD: f64 = 150.0;
/// A travel leg passes an objective's spawns within this many yards.
pub const PASSES_YD: f64 = 60.0;
/// An along line's objective is off its legs farther than this.
pub const ALONG_OFF_YD: f64 = 300.0;
/// The arrow's first goal is this much farther from the step's entry than another goal: the long way.
pub const ARROW_SLACK_YD: f64 = 200.0;

/// A required, quest-counted field goal (kill, collect, interact) the arrow leads to.
pub fn is_field(g: &WalkGoal) -> bool {
	matches!(g.t.as_str(), "kill" | "collect" | "interact") && g.q.is_some() && !g.optional
}

/// A goal's spawn area: its spots, else its point.
pub fn area(g: &WalkGoal) -> Vec<WPt> {
	if g.spots.is_empty() {
		g.w.into_iter().collect()
	} else {
		g.spots.clone()
	}
}

/// The nearest two points of two areas, yards.
pub fn area_dist(a: &[WPt], b: &[WPt]) -> f64 {
	a.iter().flat_map(|p| b.iter().map(move |q| dist(*p, *q))).fold(f64::INFINITY, f64::min)
}

/// Yards from `p` to the segment `a`-`b` (infinite across continents).
pub fn seg_dist(p: WPt, a: WPt, b: WPt) -> f64 {
	if p.c != a.c || a.c != b.c {
		return f64::INFINITY;
	}
	let (dx, dy) = (b.wx - a.wx, b.wy - a.wy);
	let l2 = dx * dx + dy * dy;
	let t = if l2 > 0.0 { (((p.wx - a.wx) * dx + (p.wy - a.wy) * dy) / l2).clamp(0.0, 1.0) } else { 0.0 };
	(p.wx - a.wx - t * dx).hypot(p.wy - a.wy - t * dy)
}

/// The goal is where the walk is: a travel line, or a required quest goal of a step the route stops at
/// (not `along`, not optional).
fn walk_is_at(g: &WalkGoal) -> bool {
	g.w.is_some() && g.along.is_none() && (is_move(g) || (g.q.is_some() && !g.optional))
}

/// A step of the walk: its guide and step line.
fn step_key(g: &WalkGoal) -> (&str, Option<u32>) {
	(g.guide.as_str(), g.step)
}

/// Index of quest `q`'s first accept and first turn-in.
fn firsts(goals: &[WalkGoal]) -> (FxHashMap<i64, usize>, FxHashMap<i64, usize>) {
	let (mut acc, mut tin) = (FxHashMap::default(), FxHashMap::default());
	for (i, g) in goals.iter().enumerate() {
		if let Some(q) = g.q {
			match g.t.as_str() {
				"accept" => {
					acc.entry(q).or_insert(i);
				}
				"turnin" => {
					tin.entry(q).or_insert(i);
				}
				_ => {}
			}
		}
	}
	(acc, tin)
}

/// Quest `q` is in the log at walk index `i`: taken at or before it, not handed in before it.
fn in_log(acc: &FxHashMap<i64, usize>, tin: &FxHashMap<i64, usize>, q: i64, i: usize) -> bool {
	acc.get(&q).is_some_and(|&a| a <= i) && tin.get(&q).is_none_or(|&t| t > i)
}

/// Rule `merge` (warn): field objectives whose spawn areas overlap ([`OVERLAP_YD`]) written apart in one
/// visit: (a) worked in separate steps though the later one's quest was in the log at the earlier one and
/// the walk did not leave between them; (b) in one step without `loop` whose arrow order leads from an
/// area to another more than [`TRIP_YD`] away and back to the first. `loops`: the (guide, step line) of
/// `loop` steps.
pub fn merges(goals: &[WalkGoal], loops: &FxHashSet<(String, u32)>) -> Vec<Violation> {
	let (acc, tin) = firsts(goals);
	let mut out = Vec::new();
	let mut seen: FxHashSet<(i64, Option<i64>)> = FxHashSet::default();
	for (j, b) in goals.iter().enumerate() {
		if !is_field(b) || b.along.is_some() {
			continue;
		}
		let key = (b.q.unwrap(), b.oi);
		if !seen.insert(key) {
			continue;
		}
		let ab = area(b);
		// The latest earlier field goal of another objective, in another step, near this one.
		for i in (0..j).rev() {
			let a = &goals[i];
			// The walk left this ground: the visit ended.
			if walk_is_at(a) && a.w.is_some_and(|p| area_dist(&[p], &ab) > TRIP_YD) && !is_field(a) {
				break;
			}
			if !is_field(a) || a.along.is_some() || (a.q, a.oi) == (b.q, b.oi) || step_key(a) == step_key(b) {
				continue;
			}
			let d = area_dist(&area(a), &ab);
			if d > OVERLAP_YD || !in_log(&acc, &tin, key.0, i) {
				continue;
			}
			// Left between them: a stop or travel line far from both areas.
			let aa = area(a);
			let left = goals[i + 1..j].iter().any(|x| walk_is_at(x) && x.w.is_some_and(|p| area_dist(&[p], &aa) > TRIP_YD && area_dist(&[p], &ab) > TRIP_YD));
			if left {
				break;
			}
			out.push(Violation::at(
				b,
				"merge",
				Level::Warn,
				format!("{} has a step of its own, though it was in the log at {} ({}), {d:.0} yd away in the same visit: one step (with `loop`) could do both", title(b), line_of(a), title(a)),
			));
			break;
		}
	}
	// (b) one step's arrow order leaves an area and comes back to it.
	let mut k = 0;
	while k < goals.len() {
		let key = step_key(&goals[k]);
		let end = (k..goals.len()).find(|&x| step_key(&goals[x]) != key).unwrap_or(goals.len());
		let is_loop = goals[k].step.is_some_and(|s| loops.contains(&(goals[k].guide.clone(), s)));
		let field: Vec<usize> = (k..end).filter(|&x| is_field(&goals[x]) && goals[x].along.is_none()).collect();
		if !is_loop {
			for (n, &c) in field.iter().enumerate().skip(2) {
				let ac = area(&goals[c]);
				let back = field[..n].iter().enumerate().find_map(|(m, &a)| {
					let aa = area(&goals[a]);
					let d = area_dist(&aa, &ac);
					(d <= OVERLAP_YD).then_some(())?;
					field[m + 1..n].iter().find(|&&x| area_dist(&area(&goals[x]), &aa) > TRIP_YD && area_dist(&area(&goals[x]), &ac) > TRIP_YD).map(|&x| (a, x, d))
				});
				if let Some((a, x, d)) = back {
					out.push(Violation::at(
						&goals[c],
						"merge",
						Level::Warn,
						format!(
							"the arrow leads from {} ({}) to {} ({}), then back here, {d:.0} yd from the first: order the step's goals by ground or make it a `loop`",
							title(&goals[a]),
							line_of(&goals[a]),
							title(&goals[x]),
							line_of(&goals[x])
						),
					));
				}
			}
		}
		k = end;
	}
	out
}

fn title(g: &WalkGoal) -> String {
	match (&g.title, g.q) {
		(Some(t), Some(q)) => format!("{t} ({q}{})", g.oi.map_or(String::new(), |o| format!(".{o}"))),
		(_, Some(q)) => format!("quest {q}{}", g.oi.map_or(String::new(), |o| format!(".{o}"))),
		_ => g.t.clone(),
	}
}

/// The walk's travel legs: consecutive places the walk is at (indices), longer than [`TRIP_YD`].
fn legs(goals: &[WalkGoal]) -> Vec<(usize, usize)> {
	let at: Vec<usize> = (0..goals.len()).filter(|&i| walk_is_at(&goals[i])).collect();
	at.windows(2).filter(|w| dist(goals[w[0]].w.unwrap(), goals[w[1]].w.unwrap()) > TRIP_YD && goals[w[0]].w.unwrap().c == goals[w[1]].w.unwrap().c).map(|w| (w[0], w[1])).collect()
}

/// Where an `along` goal's list ends: the first goal of its `until` label's step after it in its guide,
/// a bare `along` at the guide's end.
fn until_of(goals: &[WalkGoal], i: usize) -> usize {
	let g = &goals[i];
	let until = g.along.as_deref().unwrap_or("");
	let same = |x: &WalkGoal| x.guide == g.guide;
	if !until.is_empty() {
		if let Some(k) = (i + 1..goals.len()).take_while(|&k| same(&goals[k])).find(|&k| goals[k].label.as_deref() == Some(until)) {
			return k;
		}
	}
	(i + 1..goals.len()).take_while(|&k| same(&goals[k])).last().unwrap_or(i)
}

/// Rule `along` (warn): (a) a travel leg longer than [`TRIP_YD`] that passes within [`PASSES_YD`] of the
/// spawns of an objective in the log, worked later (not at the leg's end), with no `along` line covering
/// the leg; (b) an `along` line whose objective has no spawn within [`ALONG_OFF_YD`] of the legs it covers.
pub fn alongs(goals: &[WalkGoal]) -> Vec<Violation> {
	let (acc, tin) = firsts(goals);
	let ls = legs(goals);
	let mut out = Vec::new();
	// Each objective's spawns (every field goal of it).
	let mut spawns: FxHashMap<(i64, Option<i64>), Vec<WPt>> = FxHashMap::default();
	for g in goals.iter().filter(|g| is_field(g)) {
		spawns.entry((g.q.unwrap(), g.oi)).or_default().extend(g.spots.iter().copied());
	}
	// (b) and the legs each along line covers.
	let mut covers: FxHashMap<(i64, Option<i64>), Vec<(usize, usize)>> = FxHashMap::default();
	for (i, g) in goals.iter().enumerate() {
		if g.along.is_none() || !matches!(g.t.as_str(), "kill" | "collect" | "interact") || g.q.is_none() {
			continue;
		}
		let u = until_of(goals, i);
		covers.entry((g.q.unwrap(), g.oi)).or_default().push((i, u));
		let own = &spawns.get(&(g.q.unwrap(), g.oi)).cloned().unwrap_or_default();
		// The legs walked while the line is listed: ending after it, starting before its until step.
		let mine: Vec<&(usize, usize)> = ls.iter().filter(|(a, b)| *b > i && *a < u).collect();
		if own.is_empty() || mine.is_empty() {
			continue;
		}
		let d = own.iter().flat_map(|p| mine.iter().map(move |(a, b)| seg_dist(*p, goals[*a].w.unwrap(), goals[*b].w.unwrap()))).fold(f64::INFINITY, f64::min);
		if d > ALONG_OFF_YD {
			out.push(Violation::at(g, "along", Level::Warn, format!("{} is listed along the way, but no leg it covers passes within {d:.0} yd of its spawns", title(g))));
		}
	}
	// (a) legs passing an open objective's spawns, uncovered.
	let mut told: FxHashSet<(i64, Option<i64>)> = FxHashSet::default();
	for &(a, b) in &ls {
		let (pa, pb) = (goals[a].w.unwrap(), goals[b].w.unwrap());
		for (&key, sp) in &spawns {
			if told.contains(&key) || !in_log(&acc, &tin, key.0, a) {
				continue;
			}
			// Worked later, not at the leg's end step, and not worked already.
			let work = |x: &WalkGoal| is_field(x) && x.along.is_none() && (x.q, x.oi) == (Some(key.0), key.1);
			if goals[..=a].iter().any(work) {
				continue;
			}
			let Some(later) = goals[b..].iter().find(|x| work(x)) else { continue };
			if step_key(later) == step_key(&goals[b]) {
				continue;
			}
			let d = sp.iter().map(|p| seg_dist(*p, pa, pb)).fold(f64::INFINITY, f64::min);
			if d > PASSES_YD {
				continue;
			}
			if covers.get(&key).is_some_and(|c| c.iter().any(|&(s, u)| s < b && u >= b)) {
				continue;
			}
			told.insert(key);
			out.push(Violation::at(
				&goals[a],
				"along",
				Level::Warn,
				format!("the way to {} passes {d:.0} yd from {}'s spawns, in the log and worked later at {}: an `along` line could do it on the way", line_of(&goals[b]), title(later), line_of(later)),
			));
		}
	}
	out.sort_by_key(|v| (v.file.clone(), v.line));
	out
}

/// Rule `arrow-order` (warn): a step of two or more field goals (not a `loop`) whose first one, where the
/// arrow leads, is more than [`ARROW_SLACK_YD`] farther from where the step is entered than another.
pub fn arrow_order(goals: &[WalkGoal], loops: &FxHashSet<(String, u32)>) -> Vec<Violation> {
	let mut out = Vec::new();
	let mut k = 0;
	let mut here: Option<WPt> = None;
	while k < goals.len() {
		let key = step_key(&goals[k]);
		let end = (k..goals.len()).find(|&x| step_key(&goals[x]) != key).unwrap_or(goals.len());
		let is_loop = goals[k].step.is_some_and(|s| loops.contains(&(goals[k].guide.clone(), s)));
		let required: Vec<usize> = (k..end).filter(|&x| goals[x].along.is_none() && !goals[x].optional && goals[x].t != "note").collect();
		let field: Vec<usize> = required.iter().copied().filter(|&x| is_field(&goals[x])).collect();
		if let (false, Some(entry), Some(&first)) = (is_loop, here, required.first()) {
			if field.len() >= 2 && field[0] == first {
				let d = |x: usize| area(&goals[x]).iter().map(|p| dist(entry, *p)).fold(f64::INFINITY, f64::min);
				let d0 = d(first);
				if let Some((o, dn)) = field[1..].iter().map(|&x| (x, d(x))).min_by(|a, b| a.1.total_cmp(&b.1)) {
					if d0.is_finite() && d0 > dn + ARROW_SLACK_YD {
						out.push(Violation::at(
							&goals[first],
							"arrow-order",
							Level::Warn,
							format!("the arrow leads first to {} {d0:.0} yd from where the step starts, past {} at {dn:.0} yd: write the nearer goal first", title(&goals[first]), title(&goals[o])),
						));
					}
				}
			}
		}
		if let Some(p) = (k..end).rev().find_map(|x| goals[x].w.filter(|_| walk_is_at(&goals[x]))) {
			here = Some(p);
		}
		k = end;
	}
	out
}
