//! Elites at an object's work (#1778): Berard's Journal, from Berard's Bookshelf in Pyrewood Village (A Recipe
//! For Death), lies beside Apothecary Berard, a level 16 elite, among the village's elite Watchers, Sentries and
//! Elders. A quest objective that is an object to use, or an item only objects give, is marked for each side with
//! the hostile elites standing at it, so Lookup's guides say "Elite: group advised" from the Codex, with no search
//! in game. An objective an NPC drops, or one to kill, is left alone: its own target says it (`eliteGroup`).
//!
//! The objective record gets `elites = { A?: { rank, lvl }, H?: { rank, lvl } }`: rank 1 elite, 2 rare elite, 3
//! boss (the highest among them), lvl the highest top level. A side is marked when at least half of the object's
//! spawn points (data/forever, every point) have an elite hostile to it within NEAR yards: of no side, or of the
//! other side's only ("AH" is friendly to both). Elites of no real level (above MAX_LEVEL) don't count, nor one of
//! no side that gives or takes a quest or has a role (a vendor, a trainer): a friendly NPC whose side the data
//! lacks (Keeper Remulos in Moonglade).

use forge_guide::js::{Obj, V};
use rustc_hash::FxHashMap;

use super::spawns::frame_of;
use super::util::{hypot, int_s, kstr};

/// Yards from an object's spawn point within which an elite is "at" it.
pub const NEAR: f64 = 40.0;
/// Above this level an NPC is no fight (9999: Anachronos).
const MAX_LEVEL: f64 = 63.0;
/// Grid cell (yards) of the elite index: NEAR, so a point's elites are in its cell and the eight around it.
const CELL: f64 = NEAR;

struct Elite {
	wx: f64,
	wy: f64,
	rank: f64,
	lvl: f64,
	/// Hostile to the Alliance, to the Horde.
	a: bool,
	h: bool,
}

/// Every spawn point of `rec` (data/forever's `spawns: { map: { f, pts, more } }`: `more` the points the cap
/// left out of `pts`) as (continent, wx, wy).
fn points(frames: &V, rec: &V) -> Vec<(f64, f64, f64)> {
	let mut out = Vec::new();
	for (map, s) in rec.get("spawns").entries() {
		let m = int_s(Some(&map.to_string())).unwrap_or(f64::NAN);
		let era = s.get("f").as_str() == Some("e");
		let Some(fr) = (if era { frame_of(frames, m, true) } else { frame_of(frames, m, false).or_else(|| frame_of(frames, m, true)) }) else { continue };
		for p in s.get("pts").items().into_iter().chain(s.get("more").items()) {
			let (x, y) = (p.num_at(0), p.num_at(1));
			if x.is_finite() && y.is_finite() {
				out.push((fr.c, fr.top + (y / 100.0) * (fr.bottom - fr.top), fr.left + (x / 100.0) * (fr.right - fr.left)));
			}
		}
	}
	out
}

fn cell(c: f64, wx: f64, wy: f64) -> (i64, i64, i64) {
	(c as i64, (wx / CELL).floor() as i64, (wy / CELL).floor() as i64)
}

/// The elites (rank 1-3) out in the world, indexed by grid cell.
fn index(npcs: &V, quests: &V, frames: &V) -> FxHashMap<(i64, i64, i64), Vec<Elite>> {
	let mut givers: rustc_hash::FxHashSet<String> = rustc_hash::FxHashSet::default();
	for (_, q) in quests.entries() {
		for end in ["start", "end"] {
			for n in q.get(end).get("npc").items() {
				givers.insert(kstr(&n));
			}
		}
	}
	let mut grid: FxHashMap<(i64, i64, i64), Vec<Elite>> = FxHashMap::default();
	for (id, n) in npcs.entries() {
		let rank = n.get("rank").num();
		if !(rank == 1.0 || rank == 2.0 || rank == 3.0) {
			continue;
		}
		let lvl = {
			let m = n.get("levelMax").num();
			if m > 0.0 {
				m
			} else {
				n.get("level").num()
			}
		};
		if lvl > MAX_LEVEL {
			continue;
		}
		let side = n.get("faction");
		let side = side.as_str().unwrap_or("");
		let a = !side.contains('A');
		let h = !side.contains('H');
		if !(a || h) || (side.is_empty() && (givers.contains(&*id) || !n.get("roles").items().is_empty())) {
			continue;
		}
		for (c, wx, wy) in points(frames, &n) {
			grid.entry(cell(c, wx, wy)).or_default().push(Elite { wx, wy, rank, lvl: if lvl > 0.0 { lvl } else { 0.0 }, a, h });
		}
	}
	grid
}

#[derive(Default, Clone, Copy)]
struct Mark {
	hits: usize,
	rank: f64,
	lvl: f64,
}

impl Mark {
	fn take(&mut self, e: &Elite) {
		if e.rank > self.rank {
			self.rank = e.rank;
		}
		if e.lvl > self.lvl {
			self.lvl = e.lvl;
		}
	}
}

/// The marks of a set of spawn points: per side, how many points have a hostile elite near, the highest rank
/// and level among those elites.
fn marks(grid: &FxHashMap<(i64, i64, i64), Vec<Elite>>, pts: &[(f64, f64, f64)]) -> (Mark, Mark) {
	let (mut a, mut h) = (Mark::default(), Mark::default());
	for &(c, wx, wy) in pts {
		let (cc, gx, gy) = cell(c, wx, wy);
		let (mut ha, mut hh) = (false, false);
		for dx in -1..=1 {
			for dy in -1..=1 {
				for e in grid.get(&(cc, gx + dx, gy + dy)).map(Vec::as_slice).unwrap_or(&[]) {
					if hypot(e.wx - wx, e.wy - wy) <= NEAR {
						if e.a {
							ha = true;
							a.take(e);
						}
						if e.h {
							hh = true;
							h.take(e);
						}
					}
				}
			}
		}
		a.hits += ha as usize;
		h.hits += hh as usize;
	}
	(a, h)
}

fn mark_v(m: &Mark) -> V {
	let o = Obj::new();
	o.set("rank", m.rank);
	if m.lvl > 0.0 {
		o.set("lvl", m.lvl);
	}
	V::Obj(o)
}

/// Sets `elites` on each objective of `quests` (the Codex's, by id) that is an object to use or an item only
/// objects give, from data/forever's `npcs`, `objects` and `items` and the map frames. -> the objectives marked.
pub fn mark(quests: &V, npcs: &V, objects: &V, items: &V, frames: &V) -> usize {
	let grid = index(npcs, quests, frames);
	let mut n = 0;
	for (_, q) in quests.entries() {
		for o in q.get("objectives").items() {
			let id = kstr(&o.get("id"));
			let sources: Vec<String> = match o.get("type").as_str() {
				Some("object") => vec![id],
				Some("item") => {
					let drops = items.get(&id).get("drops");
					// An item an NPC drops: the dropper says it, not the place.
					if !drops.get("npc").keys().is_empty() {
						continue;
					}
					drops.get("object").keys().iter().map(|k| k.to_string()).collect()
				}
				_ => continue,
			};
			let pts: Vec<(f64, f64, f64)> = sources.iter().flat_map(|s| points(frames, &objects.get(s))).collect();
			if pts.is_empty() {
				continue;
			}
			let (a, h) = marks(&grid, &pts);
			let half = pts.len().div_ceil(2);
			let out = Obj::new();
			if a.hits >= half {
				out.set("A", mark_v(&a));
			}
			if h.hits >= half {
				out.set("H", mark_v(&h));
			}
			if let (false, Some(rec)) = (out.keys().is_empty(), o.as_obj()) {
				rec.set("elites", V::Obj(out));
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

	// Map 9001: 1000 x 1000 yards at once (20 yards a map percent), Era frame.
	const FRAMES: &str = r#"{"era":{"9001":{"c":0,"left":1000,"right":-1000,"top":1000,"bottom":-1000}},"forever":{}}"#;

	#[test]
	fn an_object_s_work_among_hostile_elites_is_marked_for_each_side_it_is_hostile_to() {
		let frames = parse_json(FRAMES).unwrap();
		// A level 20-21 elite of no side and a level 30 Alliance elite beside the crate (63,42); a rare elite
		// boss-like 70 (no real level) too; a plain mob beside the far crate (20,20).
		let npcs = parse_json(
			r#"{"8001":{"rank":1,"level":20,"levelMax":21,"spawns":{"9001":{"f":"e","pts":[[63.2,42.2]]}}},
			"8002":{"rank":1,"level":30,"faction":"A","spawns":{"9001":{"f":"e","pts":[[62.8,41.8]]}}},
			"8004":{"rank":3,"level":9999,"spawns":{"9001":{"f":"e","pts":[[63,42]]}}},
			"8005":{"rank":1,"level":40,"faction":"AH","spawns":{"9001":{"f":"e","pts":[[63,42]]}}},
			"8006":{"rank":1,"level":50,"spawns":{"9001":{"f":"e","pts":[[63,42]]}}},
			"8007":{"rank":1,"level":52,"roles":["vendor"],"spawns":{"9001":{"f":"e","pts":[[63,42]]}}},
			"8003":{"rank":0,"level":19,"spawns":{"9001":{"f":"e","pts":[[20,20]]}}}}"#,
		)
		.unwrap();
		let objects = parse_json(
			r#"{"6002":{"spawns":{"9001":{"f":"e","pts":[[63,42]]}}},"6003":{"spawns":{"9001":{"f":"e","pts":[[20,20]]}}},
			"6004":{"spawns":{"9001":{"f":"e","pts":[[63,42],[10,90],[90,10]]}}}}"#,
		)
		.unwrap();
		let items = parse_json(r#"{"8100":{"drops":{"object":{"6002":100}}},"8101":{"drops":{"npc":{"8003":50},"object":{"6002":100}}}}"#).unwrap();
		let quests = parse_json(
			r#"{"7101":{"objectives":[{"type":"item","id":8100},{"type":"item","id":8101},{"type":"kill","id":8001}]},
			"7102":{"objectives":[{"type":"object","id":6002}]},"7103":{"objectives":[{"type":"object","id":6003}]},
			"7104":{"objectives":[{"type":"object","id":6004}]},
			"7105":{"start":{"npc":[8006]},"objectives":[]}}"#,
		)
		.unwrap();
		assert_eq!(mark(&quests, &npcs, &objects, &items, &frames), 2);
		let ledger = quests.get("7101").get("objectives").items()[0].get("elites");
		// For the Alliance only the brute (21); for the Horde the Watch Captain too (30). 8004 has no real level,
		// 8005 is friendly to both.
		assert_eq!(ledger.get("A").get("lvl").num(), 21.0);
		assert_eq!(ledger.get("A").get("rank").num(), 1.0);
		assert_eq!(ledger.get("H").get("lvl").num(), 30.0, "8006 gives a quest and 8007 sells: friendly NPCs whose side the data lacks");
		assert!(quests.get("7101").get("objectives").items()[1].get("elites").is_undef(), "an item an NPC drops: the dropper says it");
		assert!(quests.get("7101").get("objectives").items()[2].get("elites").is_undef(), "a kill keeps to its target");
		assert_eq!(quests.get("7102").get("objectives").items()[0].get("elites").get("H").get("lvl").num(), 30.0, "the crate itself");
		assert!(quests.get("7103").get("objectives").items()[0].get("elites").is_undef(), "a crate with no elite near");
		assert!(quests.get("7104").get("objectives").items()[0].get("elites").is_undef(), "one point of three among elites: not marked");
	}
}
