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
