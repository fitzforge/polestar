//! Port of tools/lib/dsl/heights.js.
//! Goal heights (docs/GUIDE_FORMAT.md, "Heights"): a goal whose point stands for an NPC or object gets `z`,
//! the height of that entity's spawn within HEIGHT_YARDS of its world point (spawnz.json), never a guess.
//! A `use` or `interact` bound to a quest objective (`quest Q.O`) whose target is an object or a creature stands
//! for that one (#1782: the Rod of Helcular used at the Flame of Azel, in the Foothill Caverns under Darrow Hill).

use crate::data::Data;
use crate::js::{hypot, V};
use crate::obj;

pub const HEIGHT_YARDS: f64 = 15.0;
pub const HEIGHT_VERBS: [&str; 11] = ["accept", "turnin", "talk", "kill", "interact", "buy", "train", "vendor", "sethome", "getfp", "learn"];

/// The NPC or object a goal's point stands for: (kind, id) or None.
pub fn height_entity(goal: &V) -> Option<(&'static str, V)> {
	let t = goal.get("t");
	if !HEIGHT_VERBS.iter().any(|v| t.as_str() == Some(*v)) || goal.get("candidates").truthy() || goal.get("x").is_undef() || goal.get("y").is_undef() || goal.get("map").is_undef() {
		return None;
	}
	if !goal.get("npc").is_undef() {
		return Some(("npc", goal.get("npc")));
	}
	if !goal.get("object").is_undef() {
		return Some(("object", goal.get("object")));
	}
	None
}

/// A goal's world point { c, wx, wy } in its frame, or Null without bounds.
pub fn world_point(data: &Data, goal: &V) -> V {
	let map = goal.get("map");
	let fr = if goal.get("f").as_str() == Some("e") {
		data.era_frame(&map)
	} else {
		let f = data.map_frames.get("forever").get(&map.to_js_string());
		if f.truthy() {
			f
		} else {
			data.era_frame(&map)
		}
	};
	if !fr.truthy() {
		return V::Null;
	}
	let (top, bottom, left, right) = (fr.get("top").num(), fr.get("bottom").num(), fr.get("left").num(), fr.get("right").num());
	obj! { "c" => fr.get("c"), "wx" => top + ((bottom - top) * goal.get("y").num()) / 100.0, "wy" => left + ((right - left) * goal.get("x").num()) / 100.0 }.into()
}

/// The height at `point` ({ map, x, y, f }) of an entity, or None: the z of its nearest spawn on the
/// point's instance map, when that spawn is within HEIGHT_YARDS.
pub fn spawn_height(data: &Data, kind: &str, id: &V, point: &V) -> Option<V> {
	if !data.spawnz.truthy() {
		return None;
	}
	let list = data.spawnz.get(kind).get(&id.to_js_string());
	if !list.is_arr() {
		return None;
	}
	let p = world_point(data, point);
	if !p.truthy() {
		return None;
	}
	let (c, wx, wy) = (p.get("c"), p.get("wx").num(), p.get("wy").num());
	let mut best: Option<(f64, V)> = None;
	for e in list.items() {
		if !e.at(0).strict_eq(&c) {
			continue;
		}
		let d = hypot(e.at(1).num() - wx, e.at(2).num() - wy);
		if d <= HEIGHT_YARDS && best.as_ref().is_none_or(|b| d < b.0) {
			best = Some((d, e.at(3)));
		}
	}
	best.map(|b| b.1)
}

/// The object or creature a `use` or `interact` goal bound to a quest objective (`quest Q.O`, no npc or object
/// of its own) is done at: the objective's (type object; kill or talk: a creature), or None.
pub fn objective_entity(data: &Data, goal: &V) -> Option<(&'static str, V)> {
	let t = goal.get("t");
	if !(t.as_str() == Some("use") || t.as_str() == Some("interact")) || goal.get("candidates").truthy() || goal.get("x").is_undef() || goal.get("y").is_undef() || goal.get("map").is_undef() {
		return None;
	}
	if !goal.get("npc").is_undef() || !goal.get("object").is_undef() || goal.get("quest").is_undef() {
		return None;
	}
	let oi = goal.get("oi").as_num().filter(|i| *i >= 1.0 && i.fract() == 0.0)?;
	let o = data.quest(&goal.get("quest")).get("objectives").items().get(oi as usize - 1).cloned()?;
	let kind = match o.get("type").as_str() {
		Some("object") => "object",
		Some("kill") | Some("talk") => "npc",
		_ => return None,
	};
	let id = o.get("id");
	if id.is_undef() {
		return None;
	}
	Some((kind, id))
}

/// What a goal without an NPC or object of its own is done at: a `collect`'s sources (the creatures it drops from,
/// `fromNpcs`; its one source, `fromKind` npc or object, `fromId`) and a `level … grind` goal's creature (#1782: the
/// Rod of Helcular from the Foothill Caverns' yetis, under Darrow Hill).
pub fn source_entities(goal: &V) -> Vec<(&'static str, V)> {
	if goal.get("candidates").truthy() || goal.get("x").is_undef() || goal.get("y").is_undef() || goal.get("map").is_undef() {
		return Vec::new();
	}
	match goal.get("t").as_str() {
		Some("collect") => {
			let mut out: Vec<(&'static str, V)> = goal.get("fromNpcs").items().iter().map(|n| ("npc", n.get("npc"))).filter(|e| !e.1.is_undef()).collect();
			let kind = match goal.get("fromKind").as_str() {
				Some("object") => Some("object"),
				Some("npc") => Some("npc"),
				_ => None,
			};
			if let Some(kind) = kind.filter(|_| !goal.get("fromId").is_undef()) {
				if !out.iter().any(|e| e.0 == kind && e.1.strict_eq(&goal.get("fromId"))) {
					out.push((kind, goal.get("fromId")));
				}
			}
			out
		}
		Some("level") if !goal.get("grind").is_undef() => vec![("npc", goal.get("grind"))],
		_ => Vec::new(),
	}
}

/// The entities a goal's point stands for: its NPC or object (height_entity), else the objective's (objective_entity),
/// else its sources (source_entities).
fn entities(data: &Data, goal: &V) -> Vec<(&'static str, V)> {
	if let Some(e) = height_entity(goal).or_else(|| objective_entity(data, goal)) {
		return vec![e];
	}
	source_entities(goal)
}

/// The height at `point` of the nearest spawn of any of `list` within HEIGHT_YARDS, or None.
fn nearest_height(data: &Data, list: &[(&'static str, V)], point: &V) -> Option<V> {
	if list.is_empty() {
		return None;
	}
	if list.len() == 1 {
		return spawn_height(data, list[0].0, &list[0].1, point);
	}
	let p = world_point(data, point);
	if !data.spawnz.truthy() || !p.truthy() {
		return None;
	}
	let (c, wx, wy) = (p.get("c"), p.get("wx").num(), p.get("wy").num());
	let mut best: Option<(f64, V)> = None;
	for (kind, id) in list {
		for e in data.spawnz.get(kind).get(&id.to_js_string()).items() {
			if !e.at(0).strict_eq(&c) {
				continue;
			}
			let d = hypot(e.at(1).num() - wx, e.at(2).num() - wy);
			if d <= HEIGHT_YARDS && best.as_ref().is_none_or(|b| d < b.0) {
				best = Some((d, e.at(3)));
			}
		}
	}
	best.map(|b| b.1)
}

/// Yards within which a goal's point is a goal-heights.json point.
pub const POINT_YARDS: f64 = 5.0;

/// The height data/goal-heights.json gives a goal's point (a record within POINT_YARDS), or None: the floor
/// players' recordings show such a goal done on where no NPC or object says (inside a mine or cave, #1782).
pub fn point_height(data: &Data, goal: &V) -> Option<V> {
	if !data.goal_heights.is_arr() || goal.get("candidates").truthy() || goal.get("map").is_undef() || goal.get("x").is_undef() || goal.get("y").is_undef() {
		return None;
	}
	let p = world_point(data, goal);
	if !p.truthy() {
		return None;
	}
	let (c, wx, wy) = (p.get("c"), p.get("wx").num(), p.get("wy").num());
	let mut best: Option<(f64, V)> = None;
	for r in data.goal_heights.items() {
		let f = if r.get("frame").as_str() == Some("era") { "e" } else { "l" };
		let at: V = obj! { "map" => r.get("map"), "x" => r.get("x"), "y" => r.get("y"), "f" => f }.into();
		let q = world_point(data, &at);
		if !q.truthy() || !q.get("c").strict_eq(&c) || r.get("z").as_num().is_none() {
			continue;
		}
		let d = hypot(q.get("wx").num() - wx, q.get("wy").num() - wy);
		if d <= POINT_YARDS && best.as_ref().is_none_or(|b| d < b.0) {
			best = Some((d, r.get("z")));
		}
	}
	best.map(|b| b.1)
}

/// The goal's height, or None (entities, else point_height).
pub fn goal_height(data: &Data, goal: &V) -> Option<V> {
	nearest_height(data, &entities(data, goal), goal).or_else(|| point_height(data, goal))
}

/// A spawn spot's height ({ x, y } of the goal's `spots`, on the goal's map and frame), or None.
pub fn spot_height(data: &Data, goal: &V, spot: &V) -> Option<V> {
	let list = entities(data, goal);
	if list.is_empty() {
		return None;
	}
	let point: V = obj! { "map" => goal.get("map"), "x" => spot.get("x"), "y" => spot.get("y"), "f" => goal.get("f") }.into();
	nearest_height(data, &list, &point)
}

/// A smart target's candidate's height ({ npc, map, x, y, f }), or None: by its own NPC.
pub fn candidate_height(data: &Data, cand: &V) -> Option<V> {
	if cand.get("npc").is_undef() || cand.get("map").is_undef() || cand.get("x").is_undef() || cand.get("y").is_undef() {
		return None;
	}
	spawn_height(data, "npc", &cand.get("npc"), cand)
}

/// A `goto` without a height that leads to a goal with one (a later goal of its own step, or one of the next
/// step) whose point lies within HEIGHT_YARDS of its own gets that goal's height, the nearest such goal's: the
/// walk to the place ends on the floor the goal is done on (#1786: "Azurelode Mine" at the miners, over the hill
/// the mine runs under). `steps`: a guide's resolved steps, in order.
pub fn goto_heights(data: &Data, steps: &[V]) {
	for (i, step) in steps.iter().enumerate() {
		let goals = step.get("goals").items();
		for (k, goto) in goals.iter().enumerate() {
			if goto.get("t").as_str() != Some("goto") || !goto.get("z").is_undef() || goto.get("map").is_undef() || goto.get("x").is_undef() || goto.get("y").is_undef() {
				continue;
			}
			let p = world_point(data, goto);
			if !p.truthy() {
				continue;
			}
			let (c, wx, wy) = (p.get("c"), p.get("wx").num(), p.get("wy").num());
			let next = steps.get(i + 1).map(|s| s.get("goals").items()).unwrap_or_default();
			let mut best: Option<(f64, V)> = None;
			for g in goals[k + 1..].iter().chain(next.iter()) {
				if g.get("z").is_undef() || g.get("map").is_undef() || g.get("x").is_undef() || g.get("y").is_undef() {
					continue;
				}
				let q = world_point(data, g);
				if !q.truthy() || !q.get("c").strict_eq(&c) {
					continue;
				}
				let d = hypot(q.get("wx").num() - wx, q.get("wy").num() - wy);
				if d <= HEIGHT_YARDS && best.as_ref().is_none_or(|b| d < b.0) {
					best = Some((d, g.get("z")));
				}
			}
			if let Some((_, z)) = best {
				goto.set("z", z);
			}
		}
	}
}

/// -> { eligible, withZ, candidates, candidatesWithZ, spots, spotsWithZ }.
pub fn height_counts(guides: &[V]) -> V {
	let (mut eligible, mut with_z, mut candidates, mut candidates_with_z, mut spots, mut spots_with_z) = (0u32, 0u32, 0u32, 0u32, 0u32, 0u32);
	for g in guides {
		for step in g.get("steps").items() {
			for goal in step.get("goals").items() {
				for c in goal.get("candidates").items() {
					if c.get("npc").is_undef() {
						continue;
					}
					candidates += 1;
					if !c.get("z").is_undef() {
						candidates_with_z += 1;
					}
				}
				if height_entity(&goal).is_none() {
					continue;
				}
				eligible += 1;
				if !goal.get("z").is_undef() {
					with_z += 1;
				}
				for s in goal.get("spots").items() {
					spots += 1;
					if !s.get("z").is_undef() {
						spots_with_z += 1;
					}
				}
			}
		}
	}
	obj! { "eligible" => eligible, "withZ" => with_z, "candidates" => candidates, "candidatesWithZ" => candidates_with_z, "spots" => spots, "spotsWithZ" => spots_with_z }.into()
}
