'use strict';
// Which grid columns of a continent the walking maps count as road
// (pack.js: a cell is road when any of its columns is). The roads layer
// (layers/roads.js) holds raw weights, 0-255 per column; the client paints
// roads thin and blends their edges, and a road's texture fades out in
// places, so a plain threshold leaves a road in pieces a route will not
// follow. Decided 2026-10-16 (the pathing v2 tuning):
// - hysteresis: a column is road at weight STRONG (half the alpha), or at
//   WEAK when 8-connected through columns of at least WEAK to a STRONG one;
// - gap bridging: the ends of two road pieces within BRIDGE_YD of each other
//   are joined (a band BAND columns wide along the straight segment between
//   them) when the pieces run on towards each other (the ends' outward
//   directions oppose: cosine of one with the other reversed at least AGREE,
//   and each looks across the gap: cosine with the gap at least AHEAD) and
//   our grid walks the straight segment dry (nav.lineRuns: no swim on it).
// A piece's tips: the column farthest from any other, then every local
// maximum of the walked distance from it, at least TIP_GAP columns apart. An
// end lies at the centroid of the piece's columns under DIR_NEAR (walked) from
// a tip, its direction from the centroid of those DIR_NEAR to DIR_FAR away.
//
//   const mask = roadMask({ c, tiles: ['col_row', ...], weights: (col, row) => Uint8Array(65536) | null, nav, log })
//   // mask: Map 'col_row' -> Uint8Array(65536) (1 road; index j * 256 + i), the tiles with weights;
//   // mask.stats: { strong, weak, pieces, ends, bridges, bridgedColumns, refused }

const { CELL, TILE_CELLS, FLAG, CLS, cellCentre, tileKey } = require('./grid/format');

const STRONG = 128;
const WEAK = 32;
const BRIDGE_YD = 100;
const BRIDGE = Math.floor(BRIDGE_YD / CELL); // columns
const AGREE = 0.7;
const AHEAD = 0.5;
const BAND = 1; // columns either side of a bridge's centre line
const MIN_PIECE = 8; // columns: smaller pieces have no ends
const TIP_GAP = 12;
const DIR_NEAR = 6;
const DIR_FAR = 20;

const N8 = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]];

function roadMask({ c, tiles, weights, nav = null, log = () => {} }) {
	const W = new Map();
	for (const key of tiles) {
		const [col, row] = key.split('_').map(Number);
		const w = weights(col, row);
		if (w) W.set(key, w);
	}
	const mask = new Map([...W.keys()].map((key) => [key, new Uint8Array(TILE_CELLS * TILE_CELLS)]));
	// Global columns: gx = col * 256 + i (east), gy = row * 256 + j (south); a key packs both.
	const SPAN = 1 << 14;
	const at = (gx, gy, m) => {
		if (gx < 0 || gy < 0) return null;
		const t = m.get(tileKey(gx >> 8, gy >> 8));
		return t ? [t, (gy & 255) * TILE_CELLS + (gx & 255)] : null;
	};
	const weight = (gx, gy) => {
		const p = at(gx, gy, W);
		return p ? p[0][p[1]] : 0;
	};
	const isRoad = (gx, gy) => {
		const p = at(gx, gy, mask);
		return !!p && p[0][p[1]] === 1;
	};
	const setRoad = (gx, gy) => {
		const p = at(gx, gy, mask);
		if (!p || p[0][p[1]]) return false;
		p[0][p[1]] = 1;
		return true;
	};
	const stats = { strong: 0, weak: 0, pieces: 0, ends: 0, bridges: 0, bridgedColumns: 0, refused: 0 };
	// (a) Hysteresis: from every strong column through columns of at least WEAK.
	const queue = [];
	for (const [key, w] of W) {
		const [col, row] = key.split('_').map(Number);
		const m = mask.get(key);
		for (let k = 0; k < w.length; k++) {
			if (w[k] < STRONG) continue;
			m[k] = 1;
			stats.strong++;
			queue.push((row * TILE_CELLS + (k >> 8)) * SPAN + col * TILE_CELLS + (k & 255));
		}
	}
	for (let q = 0; q < queue.length; q++) {
		const gx = queue[q] % SPAN;
		const gy = Math.floor(queue[q] / SPAN);
		for (const [dx, dy] of N8) {
			if (weight(gx + dx, gy + dy) >= WEAK && setRoad(gx + dx, gy + dy)) {
				stats.weak++;
				queue.push((gy + dy) * SPAN + gx + dx);
			}
		}
	}
	// (b) Pieces (8-connected), their ends and the ends' outward directions.
	const seen = new Set();
	const ends = []; // { piece, gx, gy, dx, dy }
	const bfs = (start, inPiece, limit = Infinity) => {
		const dist = new Map([[start, 0]]);
		const order = [start];
		for (let q = 0; q < order.length; q++) {
			const d = dist.get(order[q]);
			if (d >= limit) continue;
			const gx = order[q] % SPAN;
			const gy = Math.floor(order[q] / SPAN);
			for (const [dx, dy] of N8) {
				const n = (gy + dy) * SPAN + gx + dx;
				if (!dist.has(n) && inPiece(n)) {
					dist.set(n, d + 1);
					order.push(n);
				}
			}
		}
		return { dist, order };
	};
	for (const seed of queue) {
		if (seen.has(seed)) continue;
		const { order: piece } = bfs(seed, (n) => !seen.has(n) && isRoad(n % SPAN, Math.floor(n / SPAN)));
		for (const n of piece) seen.add(n);
		stats.pieces++;
		if (piece.length < MIN_PIECE) continue;
		const members = new Set(piece);
		const inPiece = (n) => members.has(n);
		const far = (from) => {
			const r = bfs(from, inPiece);
			return { ...r, last: r.order[r.order.length - 1] };
		};
		const a = far(piece[0]).last;
		const { dist } = far(a);
		const xy = (n) => [n % SPAN, Math.floor(n / SPAN)];
		const tips = [a];
		const maxima = piece.filter((n) => {
			const [gx, gy] = xy(n);
			return N8.every(([dx, dy]) => {
				const m = (gy + dy) * SPAN + gx + dx;
				return !members.has(m) || dist.get(m) <= dist.get(n);
			});
		});
		maxima.sort((p, q) => dist.get(q) - dist.get(p) || p - q);
		for (const n of maxima) {
			const [gx, gy] = xy(n);
			if (tips.every((t) => Math.hypot(t % SPAN - gx, Math.floor(t / SPAN) - gy) >= TIP_GAP)) tips.push(n);
		}
		// An end: the centroid of the piece's columns under DIR_NEAR (walked) from the tip (the middle of a wide
		// road's end, not its corner); its direction from the centroid of those DIR_NEAR to DIR_FAR away out to it.
		for (const t of tips) {
			const local = bfs(t, inPiece, DIR_FAR);
			const near = [0, 0, 0];
			const far = [0, 0, 0];
			for (const [n, d] of local.dist) {
				const s = d < DIR_NEAR ? near : far;
				s[0] += n % SPAN;
				s[1] += Math.floor(n / SPAN);
				s[2]++;
			}
			if (!far[2]) continue;
			const ex = near[0] / near[2];
			const ey = near[1] / near[2];
			const vx = ex - far[0] / far[2];
			const vy = ey - far[1] / far[2];
			const len = Math.hypot(vx, vy);
			if (len < 1e-9) continue;
			ends.push({ piece: stats.pieces, gx: Math.round(ex), gy: Math.round(ey), dx: vx / len, dy: vy / len });
		}
	}
	stats.ends = ends.length;
	// Bridges: candidate pairs, nearest first, each end used once.
	const grid = new Map();
	const cellKey = (gx, gy) => `${Math.floor(gx / BRIDGE)},${Math.floor(gy / BRIDGE)}`;
	ends.forEach((e, i) => {
		const k = cellKey(e.gx, e.gy);
		if (!grid.has(k)) grid.set(k, []);
		grid.get(k).push(i);
	});
	const pairs = [];
	ends.forEach((e, i) => {
		const bx = Math.floor(e.gx / BRIDGE);
		const by = Math.floor(e.gy / BRIDGE);
		for (let x = bx - 1; x <= bx + 1; x++) {
			for (let y = by - 1; y <= by + 1; y++) {
				for (const j of grid.get(`${x},${y}`) || []) {
					const f = ends[j];
					if (j <= i || f.piece === e.piece) continue;
					const gap = Math.hypot(f.gx - e.gx, f.gy - e.gy);
					if (gap > BRIDGE || gap < 1) continue;
					const ux = (f.gx - e.gx) / gap;
					const uy = (f.gy - e.gy) / gap;
					if (-(e.dx * f.dx + e.dy * f.dy) < AGREE || e.dx * ux + e.dy * uy < AHEAD || -(f.dx * ux + f.dy * uy) < AHEAD) continue;
					pairs.push([gap, i, j]);
				}
			}
		}
	});
	pairs.sort((p, q) => p[0] - q[0] || p[1] - q[1] || p[2] - q[2]);
	const used = new Set();
	const world = (gx, gy) => ({ c, ...cellCentre(gx >> 8, gy >> 8, gx & 255, gy & 255) });
	for (const [gap, i, j] of pairs) {
		if (used.has(i) || used.has(j)) continue;
		const e = ends[i];
		const f = ends[j];
		if (nav) {
			// Walkable straight across, dry all the way: a gap over a river or a lake is no road.
			const A = nav.snap({ ...world(e.gx, e.gy), radius: 4 });
			const B = nav.snap({ ...world(f.gx, f.gy), radius: 4 });
			const runs = A && B && !((A.flags | B.flags) & FLAG.SWIM) ? nav.lineRuns(A, B) : null;
			if (!runs || runs.some((r) => r.cls === CLS.SWIM)) {
				stats.refused++;
				continue;
			}
		}
		used.add(i);
		used.add(j);
		stats.bridges++;
		const steps = Math.ceil(gap * 2);
		for (let s = 0; s <= steps; s++) {
			const x = Math.round(e.gx + ((f.gx - e.gx) * s) / steps);
			const y = Math.round(e.gy + ((f.gy - e.gy) * s) / steps);
			for (let ox = -BAND; ox <= BAND; ox++) for (let oy = -BAND; oy <= BAND; oy++) if (setRoad(x + ox, y + oy)) stats.bridgedColumns++;
		}
	}
	log(`roads ${c}: ${stats.strong} strong columns, ${stats.weak} joined by hysteresis, ${stats.pieces} pieces, ${stats.ends} ends, ${stats.bridges} gaps bridged (${stats.bridgedColumns} columns), ${stats.refused} refused (not walkable)`);
	mask.stats = stats;
	return mask;
}

module.exports = { roadMask, STRONG, WEAK, BRIDGE_YD, AGREE, AHEAD };
