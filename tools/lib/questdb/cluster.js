'use strict';
// Spawn clusters for the quest database: the points of one entity on one map
// become a few centroids with a radius, so a camp of twenty wolves is one
// marker instead of twenty. Distances are measured in yards through the map's
// frame (map percent is not square): its Era frame, else its Forever one for
// a map Forever added (Zephras Isle); the result is deterministic.

// Yards per map percent along x and y for a frame { left, right, top, bottom };
// maps without a frame fall back to a mid-sized zone (3000 x 2000 yd).
function scaleOf(frame) {
	if (!frame) return { sx: 30, sy: 20 };
	return { sx: Math.abs(frame.right - frame.left) / 100, sy: Math.abs(frame.bottom - frame.top) / 100 };
}

const round1 = (n) => Math.round(n * 10) / 10;

// points: [[x, y], ...] in map percent. Returns clusters sorted by size
// (largest first, ties by position): [{ x, y, r, n }], r in whole yards.
// Every point lies in one cluster unless `cap` keeps only the largest.
// opts: { radius (yd, default 70), cap (max clusters, default none), minRadius (yd, default 0) }
function clusterPoints(points, frame, opts = {}) {
	const radius = opts.radius ?? 70;
	const cap = opts.cap ?? Infinity;
	const minRadius = opts.minRadius ?? 0;
	const { sx, sy } = scaleOf(frame);
	const pts = points
		.filter((p) => Array.isArray(p) && Number.isFinite(p[0]) && Number.isFinite(p[1]))
		.map((p) => [p[0], p[1]])
		.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
	if (pts.length === 0) return [];
	const dist = (ax, ay, bx, by) => Math.hypot((ax - bx) * sx, (ay - by) * sy);

	// Leader pass: each point joins the first cluster whose running centroid
	// is within `radius`, else starts a new one.
	let clusters = [];
	for (const [x, y] of pts) {
		let home = null;
		for (const c of clusters) {
			if (dist(x, y, c.x, c.y) <= radius) {
				home = c;
				break;
			}
		}
		if (!home) {
			home = { x, y, sumX: 0, sumY: 0, members: [] };
			clusters.push(home);
		}
		home.members.push([x, y]);
		home.sumX += x;
		home.sumY += y;
		home.x = home.sumX / home.members.length;
		home.y = home.sumY / home.members.length;
	}

	// Two refinement passes: reassign every point to its nearest centroid.
	for (let pass = 0; pass < 2; pass++) {
		const next = clusters.map((c) => ({ x: c.x, y: c.y, sumX: 0, sumY: 0, members: [] }));
		for (const [x, y] of pts) {
			let best = next[0];
			let bestD = Infinity;
			for (const c of next) {
				const d = dist(x, y, c.x, c.y);
				if (d < bestD) {
					bestD = d;
					best = c;
				}
			}
			best.members.push([x, y]);
			best.sumX += x;
			best.sumY += y;
		}
		clusters = next.filter((c) => c.members.length > 0);
		for (const c of clusters) {
			c.x = c.sumX / c.members.length;
			c.y = c.sumY / c.members.length;
		}
	}

	// The radius is measured from the centre as emitted (rounded), so the
	// circle drawn there covers every member.
	const out = clusters.map((c) => {
		const x = round1(c.x);
		const y = round1(c.y);
		let r = 0;
		for (const [mx, my] of c.members) r = Math.max(r, dist(mx, my, x, y));
		return { x, y, r: Math.max(minRadius, Math.ceil(r)), n: c.members.length };
	});
	out.sort((a, b) => b.n - a.n || a.x - b.x || a.y - b.y);
	return out.slice(0, cap);
}

module.exports = { clusterPoints, scaleOf };
