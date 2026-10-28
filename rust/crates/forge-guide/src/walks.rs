//! Walking NPCs (docs/GUIDE_FORMAT.md, "Spawn areas", walkers): an NPC whose spawn walks a path or
//! wanders (moves.json, from CMaNGOS classic-db's movement) is met anywhere on that ground, so a goal at
//! it gets the ground as its one spawn area: the map circles it and the arrow counts it as reached.

use crate::data::Data;
use crate::heights::{height_entity, world_point, HEIGHT_YARDS};
use crate::js::{hypot, V};
use crate::obj;

/// A walk reaching at least this many yards from its centre makes the NPC a walker.
pub const WALK_YARDS: f64 = 20.0;

/// The walk of the NPC a goal's point stands for: (instance map, centre wx, wy, radius) in world yards,
/// when that NPC's spawn within HEIGHT_YARDS of the point walks WALK_YARDS or more.
pub fn npc_walk(data: &Data, goal: &V) -> Option<(V, f64, f64, f64)> {
	if !data.moves.truthy() {
		return None;
	}
	let (kind, id) = height_entity(goal)?;
	if kind != "npc" {
		return None;
	}
	let p = world_point(data, goal);
	if !p.truthy() {
		return None;
	}
	let (c, wx, wy) = (p.get("c"), p.get("wx").num(), p.get("wy").num());
	let mut best: Option<(f64, (V, f64, f64, f64))> = None;
	for e in data.moves.get("npc").get(&id.to_js_string()).items() {
		if !e.at(0).strict_eq(&c) {
			continue;
		}
		let d = hypot(e.at(1).num() - wx, e.at(2).num() - wy);
		if d <= HEIGHT_YARDS && best.as_ref().is_none_or(|b| d < b.0) {
			best = Some((d, (c.clone(), e.at(3).num(), e.at(4).num(), e.at(5).num())));
		}
	}
	best.map(|b| b.1).filter(|w| w.3 >= WALK_YARDS)
}

/// A walker's goal with no spawn areas of its own: its walk as the one spot { x, y, r, n } (map
/// percent in the goal's map and frame, the radius in yards).
pub fn walk_spot(data: &Data, goal: &V) -> Option<V> {
	if goal.get("spots").truthy() {
		return None;
	}
	let (_, cx, cy, r) = npc_walk(data, goal)?;
	let origin = world_point(data, &obj! { "map" => goal.get("map"), "x" => 0.0, "y" => 0.0, "f" => goal.get("f") }.into());
	let corner = world_point(data, &obj! { "map" => goal.get("map"), "x" => 100.0, "y" => 100.0, "f" => goal.get("f") }.into());
	let (top, left) = (origin.get("wx").num(), origin.get("wy").num());
	let (bottom, right) = (corner.get("wx").num(), corner.get("wy").num());
	if bottom == top || right == left {
		return None;
	}
	let round = |v: f64| (v * 100.0).round() / 100.0;
	let x = round((cy - left) / (right - left) * 100.0);
	let y = round((cx - top) / (bottom - top) * 100.0);
	Some(V::from(vec![V::from(obj! { "x" => x, "y" => y, "r" => r.ceil(), "n" => 1.0 })]))
}
