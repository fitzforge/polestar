//! Port of tools/lib/questdb/cluster.js.
//! Spawn clusters: the points of one entity on one map become a few centroids with a radius, measured in
//! yards through the map's frame.

use crate::js::{hypot, math_round, V};
use crate::obj;

/// Yards per map percent along x and y for a frame { left, right, top, bottom } (Null: 30 x 20).
pub fn scale_of(frame: &V) -> (f64, f64) {
	if !frame.truthy() {
		return (30.0, 20.0);
	}
	((frame.get("right").num() - frame.get("left").num()).abs() / 100.0, (frame.get("bottom").num() - frame.get("top").num()).abs() / 100.0)
}

fn round1(n: f64) -> f64 {
	math_round(n * 10.0) / 10.0
}

fn cmp_num(d: f64) -> std::cmp::Ordering {
	if d < 0.0 {
		std::cmp::Ordering::Less
	} else if d > 0.0 {
		std::cmp::Ordering::Greater
	} else {
		std::cmp::Ordering::Equal
	}
}

/// `Math.max(a, b)` (NaN wins).
fn jmax(a: f64, b: f64) -> f64 {
	if a.is_nan() || b.is_nan() {
		f64::NAN
	} else {
		a.max(b)
	}
}

struct Cluster {
	x: f64,
	y: f64,
	sum_x: f64,
	sum_y: f64,
	members: Vec<(f64, f64)>,
}

/// `clusterPoints(points, frame, { radius, cap, minRadius })`: points = [[x, y], ...] in map percent
/// (JS defaults: radius 70, cap f64::INFINITY, min_radius 0). -> [{ x, y, r, n }] largest first.
pub fn cluster_points(points: &[V], frame: &V, radius: f64, cap: f64, min_radius: f64) -> Vec<V> {
	let (sx, sy) = scale_of(frame);
	let fin = |v: V| matches!(v, V::Num(n) if n.is_finite());
	let mut pts: Vec<(f64, f64)> = points.iter().filter(|p| p.is_arr() && fin(p.at(0)) && fin(p.at(1))).map(|p| (p.at(0).num(), p.at(1).num())).collect();
	pts.sort_by(|a, b| {
		let d = a.0 - b.0;
		if d != 0.0 {
			cmp_num(d)
		} else {
			cmp_num(a.1 - b.1)
		}
	});
	if pts.is_empty() {
		return Vec::new();
	}
	let dist = |ax: f64, ay: f64, bx: f64, by: f64| hypot((ax - bx) * sx, (ay - by) * sy);

	let mut clusters: Vec<Cluster> = Vec::new();
	for &(x, y) in &pts {
		let home = match clusters.iter().position(|c| dist(x, y, c.x, c.y) <= radius) {
			Some(i) => i,
			None => {
				clusters.push(Cluster { x, y, sum_x: 0.0, sum_y: 0.0, members: Vec::new() });
				clusters.len() - 1
			}
		};
		let h = &mut clusters[home];
		h.members.push((x, y));
		h.sum_x += x;
		h.sum_y += y;
		h.x = h.sum_x / h.members.len() as f64;
		h.y = h.sum_y / h.members.len() as f64;
	}

	for _ in 0..2 {
		let mut next: Vec<Cluster> = clusters.iter().map(|c| Cluster { x: c.x, y: c.y, sum_x: 0.0, sum_y: 0.0, members: Vec::new() }).collect();
		for &(x, y) in &pts {
			let mut best = 0;
			let mut best_d = f64::INFINITY;
			for (i, c) in next.iter().enumerate() {
				let d = dist(x, y, c.x, c.y);
				if d < best_d {
					best_d = d;
					best = i;
				}
			}
			let b = &mut next[best];
			b.members.push((x, y));
			b.sum_x += x;
			b.sum_y += y;
		}
		clusters = next.into_iter().filter(|c| !c.members.is_empty()).collect();
		for c in clusters.iter_mut() {
			c.x = c.sum_x / c.members.len() as f64;
			c.y = c.sum_y / c.members.len() as f64;
		}
	}

	let mut out: Vec<(f64, f64, f64, usize)> = clusters
		.iter()
		.map(|c| {
			let x = round1(c.x);
			let y = round1(c.y);
			let mut r = 0.0f64;
			for &(mx, my) in &c.members {
				r = jmax(r, dist(mx, my, x, y));
			}
			(x, y, jmax(min_radius, r.ceil()), c.members.len())
		})
		.collect();
	out.sort_by(|a, b| {
		if a.3 != b.3 {
			return b.3.cmp(&a.3);
		}
		let d = a.0 - b.0;
		if d != 0.0 {
			cmp_num(d)
		} else {
			cmp_num(a.1 - b.1)
		}
	});
	let take = if cap.is_finite() { cap.max(0.0) as usize } else { usize::MAX };
	out.into_iter().take(take).map(|(x, y, r, n)| obj! { "x" => x, "y" => y, "r" => r, "n" => n }.into()).collect()
}
