//! Spawn heights for the Codex's NPC and object places (#1024). A place is a map point (`spawns_of` clusters),
//! and a map point has no height: an NPC standing under or over another floor (Apothecary Zamah in the Pools of
//! Vision, under Spirit Rise) is walked to on the top surface. Each place gets `z`, the height of the entity's
//! nearest spawn in spawnz.json within HEIGHT_YARDS of it, as the guides' goals do (forge-guide heights.rs), never
//! a guess; an entity with a single spawn on the place's continent gives it within LONE_YARDS (the place is that
//! spawn read from another source: Clarice Foster's Thunder Bluff point lies 22 yd from her spawn). A place
//! without one keeps none.

use forge_guide::js::V;

use super::spawns::frame_of;
use super::util::hypot;

/// How far a place may lie from the spawn whose height it takes (forge-guide's HEIGHT_YARDS).
pub const HEIGHT_YARDS: f64 = 15.0;
/// ... when that spawn is the entity's only one on the continent.
pub const LONE_YARDS: f64 = 40.0;

/// A place's world point: (continent, wx, wy), in its own frame (`f: 'e'` Era, else Forever's, else Era's).
fn world(frames: &V, s: &V) -> Option<(f64, f64, f64)> {
	let map = s.get("map").num();
	let era = s.get("f").as_str() == Some("e");
	let fr = if era { frame_of(frames, map, true) } else { frame_of(frames, map, false).or_else(|| frame_of(frames, map, true)) }?;
	Some((fr.c, fr.top + (s.get("y").num() / 100.0) * (fr.bottom - fr.top), fr.left + (s.get("x").num() / 100.0) * (fr.right - fr.left)))
}

/// The height at `place` of the entity whose spawns (spawnz.json rows `[continent, wx, wy, z, ...]`) are `rows`.
fn height_at(frames: &V, rows: &[V], place: &V) -> Option<f64> {
	let (c, wx, wy) = world(frames, place)?;
	let mut best: Option<(f64, f64)> = None;
	let mut on_continent = 0;
	for r in rows {
		let (rc, rx, ry, rz) = (r.num_at(0), r.num_at(1), r.num_at(2), r.num_at(3));
		if rc != c || !rz.is_finite() {
			continue;
		}
		on_continent += 1;
		let d = hypot(rx - wx, ry - wy);
		if best.is_none_or(|(bd, _)| d < bd) {
			best = Some((d, rz));
		}
	}
	let reach = if on_continent == 1 { LONE_YARDS } else { HEIGHT_YARDS };
	best.filter(|(d, _)| *d <= reach).map(|(_, z)| z)
}

/// Sets `z` on every place of `records` (the Codex's npcs or objects, by id) that has a height in `spawnz`
/// (spawnz.json's "npc" or "object" table). -> the number of places given one.
pub fn add_heights(records: &V, spawnz: &V, frames: &V) -> usize {
	let mut n = 0;
	for (id, rec) in records.entries() {
		let rows = spawnz.get(&id);
		if !rows.is_arr() {
			continue;
		}
		let rows = rows.items();
		for s in rec.get("spawns").items() {
			if let (Some(z), Some(o)) = (height_at(frames, &rows, &s), s.as_obj()) {
				o.set("z", z);
				n += 1;
			}
		}
	}
	n
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;

	// Thunder Bluff's frame (map-frames.json) and Apothecary Zamah's spawn (CMaNGOS and the Forever server agree).
	const FRAMES: &str = r#"{"era":{"1456":{"c":1,"left":516.667,"right":-527.083,"top":-850,"bottom":-1545.833}},"forever":{}}"#;

	#[test]
	fn a_place_takes_the_height_of_the_spawn_within_15_yards_of_it_or_40_of_a_lone_spawn_and_none_further() {
		let frames = parse_json(FRAMES).unwrap();
		let npcs = parse_json(
			r#"{"3419":{"spawns":[{"map":1456,"x":22.8,"y":20.9,"f":"e"},{"map":1456,"x":40,"y":40,"f":"e"}]},
			"5543":{"spawns":[{"map":1456,"x":27.2,"y":24.4,"f":"e"}]},
			"9999":{"spawns":[{"map":1456,"x":27.2,"y":24.4,"f":"e"}]},
			"3030":{"spawns":[{"map":1456,"x":22.8,"y":21.1,"f":"e"}]}}"#,
		)
		.unwrap();
		// Clarice Foster's Codex point in Thunder Bluff lies 22 yd from her only spawn; 9999 has the same spawn
		// and another one elsewhere on the continent.
		let spawnz = parse_json(r#"{"3419":[[1,-995.4,278.6,112,250]],"5543":[[1,-1033.7,215.3,110.8]],"9999":[[1,-1033.7,215.3,110.8],[1,-2000,0,50]]}"#).unwrap();
		assert_eq!(add_heights(&npcs, &spawnz, &frames), 2);
		let zamah = npcs.get("3419").get("spawns").items();
		assert_eq!(zamah[0].get("z").num(), 112.0, "Zamah's place in the Pools of Vision has her height");
		assert!(zamah[1].get("z").is_undef(), "a place far from every spawn has none");
		assert_eq!(npcs.get("5543").get("spawns").items()[0].get("z").num(), 110.8, "a lone spawn 22 yd off gives its height");
		assert!(npcs.get("9999").get("spawns").items()[0].get("z").is_undef(), "one of several 22 yd off does not");
		assert!(npcs.get("3030").get("spawns").items()[0].get("z").is_undef(), "an NPC without spawn heights has none");
	}
}
