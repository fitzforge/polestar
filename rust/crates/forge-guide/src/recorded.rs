//! Players' recorded objective spots (#1963): where `forge record learn` found each objective line of a quest
//! done, from the Polestar Recorder's objective ticks (docs/forge/learn.md, "Objective spots"), in
//! data/recorded/quests.json beside the reference data. A goal bound to an objective (`quest Q.O`) takes the
//! trusted ones as its spawn areas (resolve.rs, recorded_areas).

use crate::data::Data;
use crate::heights::world_point;
use crate::js::V;
use crate::obj;

/// Counted voters each recorded spot needs when the snapshot's meta.json names none (`forge record learn`'s
/// MIN_SPOT_VOTERS, its `thresholds.spotVoters`).
pub const SPOT_VOTERS: f64 = 3.0;

/// A recorded spot in a goal's map and frame: centre (map percent), radius (yards), counted voters behind it.
#[derive(Clone, Debug, PartialEq)]
pub struct Spot {
	pub x: f64,
	pub y: f64,
	pub r: f64,
	pub counted: f64,
}

/// Whether a line of the game's objective list (its type; not a string: unknown) fits our data's objective kind.
fn fits(line: &V, kind: &str) -> bool {
	match line.as_str() {
		None => true,
		Some("monster") => matches!(kind, "kill" | "talk"),
		Some(t @ ("item" | "object" | "event")) => t == kind,
		_ => false,
	}
}

/// Whether the game's objective list the snapshot recorded (`list`; absent: not recorded) lines up with our
/// data's objectives in order: as many lines, each of a fitting type (`forge record learn`'s rule, so its lines
/// are our objectives' indexes).
fn lines_up(objectives: &[V], list: &V) -> bool {
	if !list.is_arr() || list.is_empty() {
		return true;
	}
	let kinds = list.items();
	kinds.len() == objectives.len() && kinds.iter().zip(objectives).all(|(k, o)| fits(k, o.get("type").as_str().unwrap_or("")))
}

/// The recorded spots of objective `oi` (1-based, our data's order) of `quest`, on `map` in frame `f` (`"e"` or
/// not): the spots of a trusted line that `data.spot_voters` or more counted voters each back, best-backed first.
/// A spot recorded on another map counts where its point lies on `map` (same continent, within its bounds); the
/// recordings' coordinates are the game client's, so its frame (map-frames.json `forever`, else `era`) places
/// them. Empty without any (no snapshot, no trusted line, lines that don't line up).
pub fn objective_spots(data: &Data, quest: &V, oi: f64, map: &V, f: &V) -> Vec<Spot> {
	let rec = data.recorded.get(&quest.to_js_string());
	let objectives = data.quest(quest).get("objectives").items();
	if !rec.truthy() || !(oi >= 1.0 && oi <= objectives.len() as f64) || !lines_up(&objectives, &rec.get("list")) {
		return Vec::new();
	}
	let Some(at) = rec.get("objectives").items().into_iter().find(|l| l.get("line").num() == oi).map(|l| l.get("at")) else { return Vec::new() };
	if at.get("status").as_str() != Some("trusted") {
		return Vec::new();
	}
	// The goal's map in its frame: world yards at its corners (heights.rs world_point; walks.rs walk_spot).
	let corner = |x: f64, y: f64| world_point(data, &obj! { "map" => map.clone(), "x" => x, "y" => y, "f" => f.clone() }.into());
	let (origin, far) = (corner(0.0, 0.0), corner(100.0, 100.0));
	if !origin.truthy() {
		return Vec::new();
	}
	let (top, left, bottom, right) = (origin.get("wx").num(), origin.get("wy").num(), far.get("wx").num(), far.get("wy").num());
	if bottom == top || right == left {
		return Vec::new();
	}
	let round2 = |n: f64| (n * 100.0).round() / 100.0;
	at.get("value")
		.items()
		.iter()
		.filter(|s| s.get("counted").num() >= data.spot_voters)
		.filter_map(|s| {
			let w = world_point(data, &obj! { "map" => s.get("map"), "x" => s.get("x"), "y" => s.get("y") }.into());
			if !w.truthy() || !w.get("c").strict_eq(&origin.get("c")) {
				return None;
			}
			let x = (w.get("wy").num() - left) / (right - left) * 100.0;
			let y = (w.get("wx").num() - top) / (bottom - top) * 100.0;
			((0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y) && s.get("r").num() >= 0.0).then(|| Spot { x: round2(x), y: round2(y), r: s.get("r").num(), counted: s.get("counted").num() })
		})
		.collect()
}
