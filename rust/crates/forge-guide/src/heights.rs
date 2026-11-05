//! Port of tools/lib/dsl/heights.js.
//! Goal heights (docs/GUIDE_FORMAT.md, "Heights"): a goal whose point stands for an NPC or object gets `z`,
//! the height of that entity's spawn within HEIGHT_YARDS of its world point (spawnz.json), never a guess.

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

/// The goal's height, or None (height_entity).
pub fn goal_height(data: &Data, goal: &V) -> Option<V> {
	let (kind, id) = height_entity(goal)?;
	spawn_height(data, kind, &id, goal)
}

/// A spawn spot's height ({ x, y } of the goal's `spots`, on the goal's map and frame), or None.
pub fn spot_height(data: &Data, goal: &V, spot: &V) -> Option<V> {
	let (kind, id) = height_entity(goal)?;
	let point: V = obj! { "map" => goal.get("map"), "x" => spot.get("x"), "y" => spot.get("y"), "f" => goal.get("f") }.into();
	spawn_height(data, kind, &id, &point)
}

/// A smart target's candidate's height ({ npc, map, x, y, f }), or None: by its own NPC.
pub fn candidate_height(data: &Data, cand: &V) -> Option<V> {
	if cand.get("npc").is_undef() || cand.get("map").is_undef() || cand.get("x").is_undef() || cand.get("y").is_undef() {
		return None;
	}
	spawn_height(data, "npc", &cand.get("npc"), cand)
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
