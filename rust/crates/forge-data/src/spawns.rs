//! Spawn point reduction (port of tools/lib/data/spawns.js): round to two decimals, drop
//! near-identical points, cap the points kept per entity per map with an even spread
//! (farthest-point sampling from the point nearest the centroid); the distinct points the cap
//! leaves out are kept apart (`more`). Output sorted by x then y.

use forge_guide::js::{Obj, V};
use rustc_hash::FxHashMap;

use crate::jsv::{arr, round2};
use crate::maps::Frame;

pub type P = [f64; 2];

#[derive(Clone, Copy, Debug)]
pub struct SpawnOptions {
	pub cap: usize,
	pub dedupe: f64,
}

pub const DEFAULTS: SpawnOptions = SpawnOptions { cap: 24, dedupe: 0.3 };

fn by_xy(a: &P, b: &P) -> std::cmp::Ordering {
	let d = a[0] - b[0];
	let d = if d != 0.0 { d } else { a[1] - b[1] };
	d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

fn dedupe(points: &[P], eps: f64) -> Vec<P> {
	let mut sorted = points.to_vec();
	sorted.sort_by(by_xy);
	let mut out: Vec<P> = Vec::new();
	if eps <= 0.0 {
		for p in sorted {
			if out.last().is_none_or(|l| l[0] != p[0] || l[1] != p[1]) {
				out.push(p);
			}
		}
		return out;
	}
	let mut grid: FxHashMap<(i64, i64), Vec<P>> = FxHashMap::default();
	let eps2 = eps * eps;
	for p in sorted {
		let gx = (p[0] / eps).floor() as i64;
		let gy = (p[1] / eps).floor() as i64;
		let mut near = false;
		'o: for dx in -1..=1 {
			for dy in -1..=1 {
				let Some(cell) = grid.get(&(gx + dx, gy + dy)) else { continue };
				for q in cell {
					let ex = q[0] - p[0];
					let ey = q[1] - p[1];
					if ex * ex + ey * ey <= eps2 {
						near = true;
						break 'o;
					}
				}
			}
		}
		if near {
			continue;
		}
		grid.entry((gx, gy)).or_default().push(p);
		out.push(p);
	}
	out
}

/// Indices into `points` of the spread pick (sorted by x, y).
fn spread(points: &[P], cap: usize) -> Vec<usize> {
	if points.len() <= cap {
		return (0..points.len()).collect();
	}
	let (mut cx, mut cy) = (0.0, 0.0);
	for p in points {
		cx += p[0];
		cy += p[1];
	}
	cx /= points.len() as f64;
	cy /= points.len() as f64;
	let mut first = 0;
	let mut best = f64::INFINITY;
	for (i, p) in points.iter().enumerate() {
		let dx = p[0] - cx;
		let dy = p[1] - cy;
		let d = dx * dx + dy * dy;
		if d < best {
			best = d;
			first = i;
		}
	}
	let mut min_d = vec![f64::INFINITY; points.len()];
	let mut chosen = Vec::new();
	let mut next = first;
	while chosen.len() < cap {
		chosen.push(next);
		let [px, py] = points[next];
		min_d[next] = -1.0;
		let mut far: i64 = -1;
		let mut far_d = -1.0;
		for i in 0..points.len() {
			if min_d[i] < 0.0 {
				continue;
			}
			let dx = points[i][0] - px;
			let dy = points[i][1] - py;
			let d = dx * dx + dy * dy;
			if d < min_d[i] {
				min_d[i] = d;
			}
			if min_d[i] > far_d {
				far_d = min_d[i];
				far = i as i64;
			}
		}
		if far < 0 {
			break;
		}
		next = far as usize;
	}
	chosen.sort_by(|&a, &b| by_xy(&points[a], &points[b]));
	chosen
}

fn valid_points(points: &[P]) -> Vec<P> {
	points
		.iter()
		.filter_map(|p| {
			let x = round2(p[0]);
			let y = round2(p[1]);
			(x.is_finite() && y.is_finite() && (0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)).then_some([x, y])
		})
		.collect()
}

pub struct Reduced {
	pub pts: Vec<P>,
	pub more: Vec<P>,
}

pub fn reduce_spawns(points: &[P], o: SpawnOptions) -> Reduced {
	let all = dedupe(&valid_points(points), o.dedupe);
	let pick = spread(&all, o.cap);
	let pts: Vec<P> = pick.iter().map(|&i| all[i]).collect();
	if pts.len() == all.len() {
		return Reduced { pts, more: Vec::new() };
	}
	let mut kept = vec![false; all.len()];
	for &i in &pick {
		kept[i] = true;
	}
	let more = all.iter().enumerate().filter(|(i, _)| !kept[*i]).map(|(_, p)| *p).collect();
	Reduced { pts, more }
}

pub fn points_v(pts: &[P]) -> V {
	arr(pts.iter().map(|p| arr(vec![V::Num(p[0]), V::Num(p[1])])).collect())
}

/// `{ f, pts }` plus `more` when the cap left points out.
pub fn spawn_record(f: &str, r: &Reduced) -> V {
	let o = Obj::new();
	o.set("f", f);
	o.set("pts", points_v(&r.pts));
	if !r.more.is_empty() {
		o.set("more", points_v(&r.more));
	}
	V::Obj(o)
}

/// `[[x, y], ...]` of a JS points array (`Number` of each).
pub fn points_of(v: &V) -> Vec<P> {
	v.items().iter().map(|p| [p.num_at(0), p.num_at(1)]).collect()
}

/// pfQuest coords `[[x, y, areaId, respawn], ...]` -> spawns per UiMapID (era frame) and the
/// points dropped because their area has no UiMap.
pub fn era_spawns(coords: &[V], resolve_area: &dyn Fn(f64) -> Option<i64>, o: SpawnOptions) -> (V, usize) {
	let mut per_map: Vec<(i64, Vec<P>)> = Vec::new();
	let mut unmapped = 0;
	for c in coords {
		if !c.is_arr() || c.len() < 3 {
			continue;
		}
		let Some(map) = resolve_area(c.num_at(2)) else {
			unmapped += 1;
			continue;
		};
		let p = [c.num_at(0), c.num_at(1)];
		match per_map.iter_mut().find(|(m, _)| *m == map) {
			Some((_, l)) => l.push(p),
			None => per_map.push((map, vec![p])),
		}
	}
	per_map.sort_by_key(|(m, _)| *m);
	let spawns = Obj::new();
	for (map, pts) in per_map {
		let r = reduce_spawns(&pts, o);
		if !r.pts.is_empty() {
			spawns.set(&map.to_string(), spawn_record("e", &r));
		}
	}
	(V::Obj(spawns), unmapped)
}

/// A city's map spans at most this many yards across, a zone's more.
pub const INNER_MAX: f64 = 1500.0;

/// A continent's map spans at least this many yards across, a zone's less (the widest, The
/// Barrens, about 10,000). A zone's box can lie inside another zone's (Mulgore's inside The
/// Barrens'), so a map's size, not its box, tells a continent.
pub const CONTINENT_MIN: f64 = 20000.0;

/// Two points of one entity on two maps this close (yards) are one spawn listed twice.
pub const SAME_SPAWN_YARDS: f64 = 30.0;

fn extent(f: &Frame) -> f64 {
	(f.right - f.left).abs().max((f.bottom - f.top).abs())
}

/// Whether a map's frame is a city's: at most INNER_MAX yards across.
pub fn city(f: Option<&Frame>) -> bool {
	f.is_some_and(|f| extent(f) <= INNER_MAX)
}

/// Whether a map's frame is a continent's: at least CONTINENT_MIN yards across.
pub fn continent(f: Option<&Frame>) -> bool {
	f.is_some_and(|f| extent(f) >= CONTINENT_MIN)
}

/// Whether frame `a` holds frame `b` inside it: one continent, `b`'s box within `a`'s and smaller.
fn holds(a: Option<&Frame>, b: Option<&Frame>) -> bool {
	let (Some(a), Some(b)) = (a, b) else { return false };
	let bx = (b.left.min(b.right), b.left.max(b.right), b.top.min(b.bottom), b.top.max(b.bottom));
	let ax = (a.left.min(a.right), a.left.max(a.right), a.top.min(a.bottom), a.top.max(a.bottom));
	b.c == a.c && bx.0 >= ax.0 && bx.1 <= ax.1 && bx.2 >= ax.2 && bx.3 <= ax.3 && (bx.1 - bx.0) * (bx.3 - bx.2) < (ax.1 - ax.0) * (ax.3 - ax.2)
}

/// Whether `b` is the inner one of two maps that hold one place, the one the Codex lists first: a
/// city's map beside a zone's, or a frame inside the other's.
pub fn more_inner(b: Option<&Frame>, a: Option<&Frame>) -> bool {
	(city(b) && !city(a)) || holds(a, b)
}

/// One point of one map's list (`more`: the cap's leftovers), in world yards.
struct Placed {
	map: usize,
	more: bool,
	i: usize,
	c: f64,
	wx: f64,
	wy: f64,
}

/// One copy per spawn on a continent's map: a spawn listed on a continent's map and on a zone's or a
/// city's stays off the continent's. A city's map and its zone's keep theirs here (a city's
/// rectangle reaches past its walls, so which of the two holds a point is the sources' to say:
/// merge.rs keeps QuestieDB's), as do two zones whose rectangles overlap. A map left without `pts`
/// takes its `more`, or goes. `frame_of(map, f)`: the frame a map's points are in. -> the new
/// spawns and the points dropped, None when nothing changes.
pub fn drop_map_copies(spawns: &V, frame_of: &dyn Fn(i64, &str) -> Option<Frame>) -> Option<(V, usize)> {
	let entries = spawns.entries();
	let frames: Vec<Option<Frame>> = entries
		.iter()
		.map(|(key, s)| {
			let id = forge_guide::js::str_to_num(key);
			id.is_finite().then(|| frame_of(id as i64, &s.get("f").to_js_string())).flatten()
		})
		.collect();
	// outer[a][b]: map a is a continent's and map b a zone's or a city's.
	let outer: Vec<Vec<bool>> = (0..frames.len()).map(|a| (0..frames.len()).map(|b| continent(frames[a].as_ref()) && frames[b].is_some() && !continent(frames[b].as_ref())).collect()).collect();
	if !outer.iter().flatten().any(|x| *x) {
		return None;
	}
	let lists: Vec<[Vec<P>; 2]> = entries.iter().map(|(_, s)| [points_of(&s.get("pts")), points_of(&s.get("more"))]).collect();
	let mut placed: Vec<Placed> = Vec::new();
	for (map, fr) in frames.iter().enumerate() {
		let Some(fr) = fr else { continue };
		for (k, list) in lists[map].iter().enumerate() {
			for (i, p) in list.iter().enumerate() {
				placed.push(Placed { map, more: k == 1, i, c: fr.c, wx: fr.top + (fr.bottom - fr.top) * p[1] / 100.0, wy: fr.left + (fr.right - fr.left) * p[0] / 100.0 });
			}
		}
	}
	let cell = |p: &Placed| (p.c as i64, (p.wx / SAME_SPAWN_YARDS).floor() as i64, (p.wy / SAME_SPAWN_YARDS).floor() as i64);
	let mut grid: FxHashMap<(i64, i64, i64), Vec<usize>> = FxHashMap::default();
	for (j, p) in placed.iter().enumerate() {
		grid.entry(cell(p)).or_default().push(j);
	}
	// A continent's point goes when a zone's or a city's map holds the same spawn.
	let copy = |a: &Placed| {
		let (c, gx, gy) = cell(a);
		(gx - 1..=gx + 1).any(|x| {
			(gy - 1..=gy + 1).any(|y| grid.get(&(c, x, y)).is_some_and(|l| l.iter().map(|&o| &placed[o]).any(|b| outer[a.map][b.map] && (a.wx - b.wx).hypot(a.wy - b.wy) <= SAME_SPAWN_YARDS)))
		})
	};
	let mut gone: Vec<[Vec<bool>; 2]> = lists.iter().map(|[a, b]| [vec![false; a.len()], vec![false; b.len()]]).collect();
	let mut n = 0;
	for p in &placed {
		if copy(p) {
			gone[p.map][p.more as usize][p.i] = true;
			n += 1;
		}
	}
	if n == 0 {
		return None;
	}
	let out = Obj::new();
	for (map, (key, s)) in entries.iter().enumerate() {
		let keep = |k: usize| -> Vec<P> { lists[map][k].iter().zip(&gone[map][k]).filter(|(_, g)| !**g).map(|(p, _)| *p).collect() };
		let (pts, more) = (keep(0), keep(1));
		let r = if pts.is_empty() { reduce_spawns(&more, SpawnOptions { dedupe: 0.0, ..DEFAULTS }) } else { Reduced { pts, more } };
		if r.pts.is_empty() {
			continue;
		}
		let rec = Obj::new();
		for (k, v) in s.entries() {
			if &*k != "pts" && &*k != "more" {
				rec.set(&k, v);
			}
		}
		rec.set("pts", points_v(&r.pts));
		if !r.more.is_empty() {
			rec.set("more", points_v(&r.more));
		}
		out.set(key, V::Obj(rec));
	}
	Some((V::Obj(out), n))
}

/// Two points of one entity on two zones' maps this close (yards) are one spawn listed twice (#2875).
pub const ZONE_COPY_YARDS: f64 = 5.0;

/// Two zones' map frames overlap along their border, so the sources list a spawn there on the wrong zone's map, or
/// on both (#2875: The Ancient Egg, in The Hinterlands, read on Arathi Highlands' map near Hammerfall). A point on a
/// zone's map that the walking grid puts in another zone (`zone_of(c, wx, wy)`: the map of the grid's area there)
/// moves to that zone's map when its frame holds the point (`home(map)`: the frame kind and frame a new entry takes),
/// or just goes when the entity lists that spawn there already (within ZONE_COPY_YARDS). Continents' and cities'
/// maps keep theirs (drop_map_copies), and so do the maps `keep` names (Forever's new zones, whose areas an older
/// grid does not know). `frame_of(map, f)`: the frame a map's points are in. -> the new spawns (maps in ascending
/// order, each map that lost or gained a point reduced again) and the points moved or dropped, None when nothing
/// changes.
pub fn rehome_zone_points(
	spawns: &V,
	frame_of: &dyn Fn(i64, &str) -> Option<Frame>,
	home: &dyn Fn(i64) -> Option<(&'static str, Frame)>,
	zone_of: &dyn Fn(f64, f64, f64) -> Option<i64>,
	keep: &dyn Fn(i64) -> bool,
) -> Option<(V, usize)> {
	let zone = |f: Option<&Frame>| f.is_some() && !continent(f) && !city(f);
	let to_world = |f: &Frame, p: &P| (f.top + (f.bottom - f.top) * p[1] / 100.0, f.left + (f.right - f.left) * p[0] / 100.0);
	let to_pct = |f: &Frame, wx: f64, wy: f64| [round2((wy - f.left) / (f.right - f.left) * 100.0), round2((wx - f.top) / (f.bottom - f.top) * 100.0)];
	struct Map {
		id: i64,
		f: String,
		frame: Option<Frame>,
		pts: Vec<P>,
		changed: bool,
	}
	let entries = spawns.entries();
	let mut maps: Vec<Map> = entries
		.iter()
		.map(|(key, s)| {
			let id = forge_guide::js::str_to_num(key);
			let f = s.get("f").to_js_string();
			let frame = id.is_finite().then(|| frame_of(id as i64, &f)).flatten();
			let mut pts = points_of(&s.get("pts"));
			pts.extend(points_of(&s.get("more")));
			Map { id: if id.is_finite() { id as i64 } else { -1 }, f, frame, pts, changed: false }
		})
		.collect();
	let mut moved: Vec<(i64, f64, f64, f64)> = Vec::new();
	for m in maps.iter_mut() {
		let Some(f) = m.frame.filter(|f| zone(Some(f)) && !keep(m.id)) else { continue };
		let id = m.id;
		let before = m.pts.len();
		m.pts.retain(|p| {
			let (wx, wy) = to_world(&f, p);
			let Some(z) = zone_of(f.c, wx, wy).filter(|z| *z != id) else { return true };
			let Some((_, h)) = home(z).filter(|(_, h)| zone(Some(h)) && h.c == f.c) else { return true };
			let q = to_pct(&h, wx, wy);
			if !((0.0..=100.0).contains(&q[0]) && (0.0..=100.0).contains(&q[1])) {
				return true;
			}
			moved.push((z, f.c, wx, wy));
			false
		});
		m.changed = m.pts.len() != before;
	}
	if moved.is_empty() {
		return None;
	}
	let n = moved.len();
	for (z, c, wx, wy) in moved {
		if !maps.iter().any(|m| m.id == z) {
			let Some((kind, h)) = home(z) else { continue };
			maps.push(Map { id: z, f: kind.to_string(), frame: Some(h), pts: Vec::new(), changed: true });
		}
		let m = maps.iter_mut().find(|m| m.id == z).unwrap();
		let Some(f) = m.frame.filter(|f| f.c == c) else { continue };
		if !m.pts.iter().any(|p| {
			let (x, y) = to_world(&f, p);
			(x - wx).hypot(y - wy) <= ZONE_COPY_YARDS
		}) {
			m.pts.push(to_pct(&f, wx, wy));
			m.changed = true;
		}
	}
	maps.sort_by_key(|m| m.id);
	let out = Obj::new();
	for m in maps {
		let key = m.id.to_string();
		let old = entries.iter().find(|(k, _)| **k == *key).map(|(_, s)| s.clone());
		if !m.changed {
			if let Some(s) = old {
				out.set(&key, s);
			}
			continue;
		}
		let r = reduce_spawns(&m.pts, SpawnOptions { dedupe: 0.0, ..DEFAULTS });
		if r.pts.is_empty() {
			continue;
		}
		let rec = Obj::new();
		rec.set("f", m.f.as_str());
		for (k, v) in old.map(|s| s.entries()).unwrap_or_default() {
			if &*k != "pts" && &*k != "more" && &*k != "f" {
				rec.set(&k, v);
			}
		}
		rec.set("pts", points_v(&r.pts));
		if !r.more.is_empty() {
			rec.set("more", points_v(&r.more));
		}
		out.set(&key, V::Obj(rec));
	}
	Some((V::Obj(out), n))
}

/// A player opening an NPC's window stands this close to it (yards).
pub const WINDOW_YARDS: f64 = 10.0;
/// An NPC's points this close to the one players open its windows at are copies of that one (yards): the sources'
/// packed points around where a service NPC stands (#2738: Kor'gar's eight around Powderfuse Port).
pub const PACKED_YARDS: f64 = 100.0;
/// The players a packed NPC's kept point needs behind it.
pub const PACKED_PLAYERS: usize = 5;
/// The share of the players who opened the NPC's windows on the map that stood at the kept point.
pub const PACKED_AGREE: f64 = 0.8;

/// A service NPC listed at several points packed around where it stands keeps the one players open its windows at
/// (#2738): on each map with two or more points, the point most players' window spots (`spots_of(map)`, one per
/// player, in the map's Forever frame) lie within WINDOW_YARDS of, when PACKED_PLAYERS and PACKED_AGREE of those
/// players stood there; its other points within PACKED_YARDS go, farther ones stay (another place it stands).
/// `frame_of(map, f)`: the frame a map's points are in. -> the new spawns and the points dropped, None when nothing
/// changes.
pub fn settle_packed(spawns: &V, frame_of: &dyn Fn(i64, &str) -> Option<Frame>, spots_of: &dyn Fn(i64) -> Vec<P>) -> Option<(V, usize)> {
	let to_world = |f: &Frame, p: &P| (f.top + (f.bottom - f.top) * p[1] / 100.0, f.left + (f.right - f.left) * p[0] / 100.0);
	let out = Obj::new();
	let mut dropped = 0;
	for (key, s) in spawns.entries() {
		out.set(&key, s.clone());
		let id = forge_guide::js::str_to_num(&key);
		if !id.is_finite() {
			continue;
		}
		let mut pts = points_of(&s.get("pts"));
		pts.extend(points_of(&s.get("more")));
		let (Some(f), Some(live)) = (frame_of(id as i64, &s.get("f").to_js_string()), frame_of(id as i64, "l")) else { continue };
		let players = spots_of(id as i64);
		if pts.len() < 2 || players.len() < PACKED_PLAYERS {
			continue;
		}
		let world: Vec<(f64, f64)> = pts.iter().map(|p| to_world(&f, p)).collect();
		let mut votes = vec![0usize; pts.len()];
		for p in &players {
			let (x, y) = to_world(&live, p);
			let near = world.iter().enumerate().map(|(i, w)| (i, (w.0 - x).hypot(w.1 - y))).min_by(|a, b| a.1.total_cmp(&b.1));
			if let Some((i, _)) = near.filter(|(_, d)| *d <= WINDOW_YARDS) {
				votes[i] += 1;
			}
		}
		let best = (0..pts.len()).max_by(|&a, &b| votes[a].cmp(&votes[b]).then(b.cmp(&a))).unwrap();
		if votes[best] < PACKED_PLAYERS || (votes[best] as f64) < PACKED_AGREE * players.len() as f64 {
			continue;
		}
		let keep: Vec<P> = (0..pts.len()).filter(|&i| i == best || (world[i].0 - world[best].0).hypot(world[i].1 - world[best].1) > PACKED_YARDS).map(|i| pts[i]).collect();
		if keep.len() == pts.len() {
			continue;
		}
		dropped += pts.len() - keep.len();
		let r = reduce_spawns(&keep, SpawnOptions { dedupe: 0.0, ..DEFAULTS });
		let rec = Obj::new();
		for (k, v) in s.entries() {
			if &*k != "pts" && &*k != "more" {
				rec.set(&k, v);
			}
		}
		rec.set("pts", points_v(&r.pts));
		if !r.more.is_empty() {
			rec.set("more", points_v(&r.more));
		}
		out.set(&key, V::Obj(rec));
	}
	(dropped > 0).then_some((V::Obj(out), dropped))
}

/// Whether an NPC is listed at four or more points within PACKED_YARDS of one of them on one map (the build lists
/// the service NPCs it could not settle so, #2738).
pub fn packed(spawns: &V, frame_of: &dyn Fn(i64, &str) -> Option<Frame>) -> bool {
	spawns.entries().iter().any(|(key, s)| {
		let id = forge_guide::js::str_to_num(key);
		let Some(f) = id.is_finite().then(|| frame_of(id as i64, &s.get("f").to_js_string())).flatten() else { return false };
		let mut pts = points_of(&s.get("pts"));
		pts.extend(points_of(&s.get("more")));
		let w: Vec<(f64, f64)> = pts.iter().map(|p| (f.top + (f.bottom - f.top) * p[1] / 100.0, f.left + (f.right - f.left) * p[0] / 100.0)).collect();
		w.iter().any(|a| w.iter().filter(|b| (a.0 - b.0).hypot(a.1 - b.1) <= PACKED_YARDS).count() >= 4)
	})
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::{parse_json, stringify};

	// The Hinterlands (1425) and Arathi Highlands (1417), their frames (map-frames.json): Arathi's reaches north past
	// the border.
	const HINTERLANDS: Frame = Frame { c: 0.0, left: -1575.0, right: -5425.0, top: 1466.667, bottom: -1100.0 };
	const ARATHI: Frame = Frame { c: 0.0, left: -866.667, right: -4466.667, top: -133.333, bottom: -2533.333 };

	fn frame(map: i64) -> Option<Frame> {
		match map {
			1425 => Some(HINTERLANDS),
			1417 => Some(ARATHI),
			_ => None,
		}
	}

	// #2875: The Ancient Egg (object 175889) lies in The Hinterlands at 57.48,86.69, where players loot it; the sources
	// read it on Arathi Highlands' map (81.15,26.04 here), whose frame holds the same world point. Where the walking
	// grid gives The Hinterlands there, the point moves to that map, and a copy listed on both maps keeps the
	// Hinterlands' one; where the grid gives nothing sure (gridzones.rs: the egg's own chunk is Arathi's, beside The
	// Hinterlands'), or the map is one `keep` names, the point stays as the sources (and the egg's correction) say.
	#[test]
	fn a_spawn_on_the_wrong_zone_s_map_goes_to_the_zone_the_walking_grid_puts_it_in_2875() {
		let (wx, wy) = (HINTERLANDS.top + (HINTERLANDS.bottom - HINTERLANDS.top) * 0.8669, HINTERLANDS.left + (HINTERLANDS.right - HINTERLANDS.left) * 0.5748);
		let on_arathi = [round2((wy - ARATHI.left) / (ARATHI.right - ARATHI.left) * 100.0), round2((wx - ARATHI.top) / (ARATHI.bottom - ARATHI.top) * 100.0)];
		assert_eq!(on_arathi, [81.15, 26.04], "Arathi's frame holds the egg");
		let frame_of = |m: i64, _: &str| frame(m);
		let home = |m: i64| frame(m).map(|f| ("e", f));
		let none = |_: i64| false;
		// The grid: The Hinterlands north of a line 100 yards south of the egg, Arathi south of it.
		let zone_of = |_: f64, x: f64, _: f64| Some(if x > wx - 100.0 { 1425 } else { 1417 });
		let egg = parse_json(&format!(r#"{{"1417":{{"f":"e","pts":[[{},{}],[50,50]]}}}}"#, on_arathi[0], on_arathi[1])).unwrap();
		let (out, n) = rehome_zone_points(&egg, &frame_of, &home, &zone_of, &none).unwrap();
		assert_eq!(n, 1);
		assert_eq!(stringify(&out, None), r#"{"1417":{"f":"e","pts":[[50,50]]},"1425":{"f":"e","pts":[[57.48,86.69]]}}"#);
		let both = parse_json(&format!(r#"{{"1417":{{"f":"e","pts":[[{},{}]]}},"1425":{{"f":"e","pts":[[57.5,86.7]]}}}}"#, on_arathi[0], on_arathi[1])).unwrap();
		let (out, n) = rehome_zone_points(&both, &frame_of, &home, &zone_of, &none).unwrap();
		assert_eq!((n, stringify(&out, None)), (1, r#"{"1425":{"f":"e","pts":[[57.5,86.7]]}}"#.to_string()), "one spawn listed twice");
		assert!(rehome_zone_points(&parse_json(r#"{"1425":{"f":"e","pts":[[57.48,86.69]]}}"#).unwrap(), &frame_of, &home, &zone_of, &none).is_none(), "already home");
		assert!(rehome_zone_points(&egg, &frame_of, &home, &|_, _, _| None, &none).is_none(), "nothing sure from the grid: as the sources say");
		assert!(rehome_zone_points(&egg, &frame_of, &home, &zone_of, &|m| m == 1417).is_none(), "a map kept as the sources give it");
	}

	// #2738: a service NPC with eight points packed a few map percent around Powderfuse Port (The Riverglades, its
	// Forever frame), where 35 players opened his windows at 77.6-77.7,50.9-51.0, keeps the point they stood at; a
	// point in another town stays. Players spread over his walk, or too few of them, leave the points as they are.
	#[test]
	fn a_packed_service_npc_keeps_the_point_players_open_its_windows_at_2738() {
		const RIVERGLADES: Frame = Frame { c: 0.0, left: -1891.666, right: -6741.666, top: -6466.666, bottom: -9700.0 };
		let frame_of = |m: i64, _: &str| (m == 2548).then_some(RIVERGLADES);
		let korgar = r#"{"2548":{"f":"l","pts":[[76.1,50.2],[76.9,51.8],[77.2,49.9],[77.66,50.97],[78.1,52.0],[78.4,50.1],[78.9,51.4],[79.2,50.6],[40,40]]}}"#;
		let spawns = parse_json(korgar).unwrap();
		let at = |n: usize| (0..n).map(|i| [77.6 + (i % 3) as f64 * 0.05, 50.9 + (i % 2) as f64 * 0.1]).collect::<Vec<P>>();
		let (out, n) = settle_packed(&spawns, &frame_of, &|_| at(35)).unwrap();
		assert_eq!((n, stringify(&out, None)), (7, r#"{"2548":{"f":"l","pts":[[40,40],[77.66,50.97]]}}"#.to_string()));
		assert!(settle_packed(&spawns, &frame_of, &|_| at(4)).is_none(), "four players");
		let walk = |_: i64| (0..20).map(|i| [76.0 + i as f64 * 0.17, 50.0 + (i % 4) as f64 * 0.5]).collect::<Vec<P>>();
		assert!(settle_packed(&spawns, &frame_of, &walk).is_none(), "windows all along a walk");
		assert!(packed(&spawns, &frame_of) && !packed(&out, &frame_of));
	}
}
