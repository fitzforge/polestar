//! Spawn point reduction (port of tools/lib/data/spawns.js): round to two decimals, drop
//! near-identical points, cap the points kept per entity per map with an even spread
//! (farthest-point sampling from the point nearest the centroid); the distinct points the cap
//! leaves out are kept apart (`more`). Output sorted by x then y.

use forge_guide::js::{Obj, V};
use rustc_hash::FxHashMap;

use crate::jsv::{arr, round2};

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
