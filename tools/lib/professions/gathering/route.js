'use strict';
// Gathering routes: the projector of the reference data's map frames and weighted density clusters
// of spawn points (the stops of the farming loops: loop.js, farm.js).

const { makeProjector, dist } = require('../../route/geo');

function projector(data) {
	return makeProjector(data.mapFrames || data['map-frames'] || {});
}

// Every spawn of a spawns record: `pts` (the reference data's evenly spread
// points, at most its cap per map) and `more` (the rest).
function allPoints(s) {
	return s ? [...(s.pts || []), ...(s.more || [])] : [];
}

// Greedy weighted clustering: seed = point with the heaviest neighbourhood (the first in x, y, name
// order on a tie). A grid of `radius` cells finds each point's neighbours; a neighbourhood's weight is
// summed in that order, as the plain loop over every point would, so the result is the same.
function weightedClusters(points, radius, project) {
	const pts = points.slice().sort((a, b) => a.pt.x - b.pt.x || a.pt.y - b.pt.y || a.name.localeCompare(b.name));
	const cell = (p) => `${p.pt.c}|${Math.floor(p.pt.wx / radius)}|${Math.floor(p.pt.wy / radius)}`;
	const grid = new Map();
	pts.forEach((p, i) => {
		const k = cell(p);
		if (!grid.has(k)) grid.set(k, []);
		grid.get(k).push(i);
	});
	const near = pts.map((p) => {
		const gx = Math.floor(p.pt.wx / radius);
		const gy = Math.floor(p.pt.wy / radius);
		const list = [];
		for (let dx = -1; dx <= 1; dx++) for (let dy = -1; dy <= 1; dy++) for (const j of grid.get(`${p.pt.c}|${gx + dx}|${gy + dy}`) || []) if (dist(p.pt, pts[j].pt) <= radius) list.push(j);
		return list.sort((a, b) => a - b);
	});
	const taken = new Uint8Array(pts.length);
	const sum = (i) => {
		let w = 0;
		for (const j of near[i]) if (!taken[j]) w += pts[j].w;
		return w;
	};
	const weight = pts.map((p, i) => sum(i));
	let left = pts.length;
	const out = [];
	while (left) {
		let best = -1;
		let bestW = -1;
		for (let i = 0; i < pts.length; i++) {
			if (taken[i]) continue;
			if (weight[i] > bestW + 1e-9) {
				bestW = weight[i];
				best = i;
			}
		}
		const seed = pts[best];
		const members = near[best].filter((j) => !taken[j]);
		const touched = new Set();
		for (const j of members) {
			taken[j] = 1;
			left--;
			for (const k of near[j]) touched.add(k);
		}
		for (const k of touched) if (!taken[k]) weight[k] = sum(k);
		const x = members.reduce((s, j) => s + pts[j].pt.x, 0) / members.length;
		const y = members.reduce((s, j) => s + pts[j].pt.y, 0) / members.length;
		// Nodes of each kind the cluster holds (a pooled point counts its share).
		const counts = {};
		for (const j of members) counts[pts[j].name] = (counts[pts[j].name] || 0) + (pts[j].up === undefined ? 1 : pts[j].up);
		out.push({
			pt: project.point(seed.pt.map, Math.round(x * 10) / 10, Math.round(y * 10) / 10, seed.pt.f),
			w: bestW,
			counts,
		});
	}
	return out;
}

module.exports = { projector, allPoints, weightedClusters };
