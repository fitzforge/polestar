'use strict';
// Links between a tile's walkable entries and their neighbours (format.js):
//
// - Eight neighbours (diagonals only when both orthogonal moves are open), to
//   the walkable entry of the neighbouring column whose height is nearest,
//   when the two gaps overlap by AGENT_HEIGHT. Between two terrain entries
//   (the client's continuous heightfield) the gradient decides: column tops
//   are the highest point of the terrain over each column, so on curved
//   ground their difference outgrows any single triangle's slope. Gradient
//   up to GENTLE_MAX walk, to WALK_MAX walk at x1.5 (LINK_SLOPE), to
//   STEEP_MAX steep, to CLIMB_MAX climb (upward only: down such a slope one
//   slides, so it is part of a fall); beyond (up to JUMP) jump. A terrain
//   entry whose own surface is steeper than STEEP_MAX is no ground to stand
//   on whatever the gradient: it is only climbed into (upward within
//   CLIMB_MAX); along or down such a face one slides (a fall). Elsewhere
//   (d the horizontal distance, slope the steeper of the two entries', at
//   most WALK_MAX) walk or swim (either entry swim); beyond it, between two
//   WMO entries both at most STAIR_MAX steep, a rise of at most
//   STEP + d * tan(the upper entry's slope), at most STEP + JUMP, is walked as
//   a slope (LINK_SLOPE): a ramp or a stair's
//   treads whose foot lies between the column centres (a step onto the
//   slope, then the slope); up to STAIR_MAX gradient, a WMO staircase is
//   walked as a slope (LINK_SLOPE):
//   between two WMO entries, the treads in the upper one's column below it
//   (treadRise) climb from the lower entry in rises of at most STEP; steps
//   higher than that (the Ruins of Lordaeron's throne room into the
//   Undercity's lift halls: rises of 0.7 and 1.5 yd within one column, 2.2
//   yd in all) are a jump when every rise is at most JUMP and the whole at
//   most STEP + JUMP; else up to JUMP, jump. Between two swim surfaces
//   SWIM_STEP.
// - Walls (rasterise.js, format.js WALLS): no link crosses a wall on the
//   half-lines between the two columns (for a diagonal, the eight half-lines
//   of the four columns around the corner) between STEP and AGENT_HEIGHT
//   above the higher of the two surfaces: risers and kerbs below that are
//   stepped over, lintels and beams above it walked under.
// - Falls, one way: from a walkable entry (not swimming) in a direction with
//   no link, through columns open at its height, onto the highest entry below
//   it within FALL_REACH cells; a blocked entry on the way (a cliff's lip or
//   face, at most a step above) is slid past to the next column; no wall may
//   cross the way at the body's height. The landing must be stable
//   (stable(): a 2 x 2 block of level surfaces under STEEP_MAX holding it);
//   from an unstable one the fall goes on in the same direction to the next
//   landing below it, up to FALL_SLIDE cells in all, as one fall of the total
//   height. A fall needs a drop above JUMP and at most FALL_MAX
//   (FALL_MAX_WATER onto a swim surface).
//
// around: the 3 x 3 tiles centred on the tile, index (drow + 1) * 3 + (dcol + 1),
// null where there is none; a tile's `walls` (format.js wallIndex) may be
// null (no walls).

const {
	TILE_CELLS, CELL, STEP, JUMP, AGENT_HEIGHT, FALL_MAX, FALL_MAX_WATER, FALL_REACH, FALL_SLIDE, FLAG, CLS, NO_LINK, DIRS,
	GENTLE_MAX, WALK_MAX, STEEP_MAX, CLIMB_MAX, STAIR_MAX, LINK_SLOPE, HALF, wallBlocks,
} = require('./format');

const SWIM_STEP = 2.0; // yd between neighbouring swim surfaces (sloping rivers)
const FALL_SPAN = 2 * FALL_SLIDE + 1; // fall target offsets per axis
const RAD = Math.PI / 180;
const TAN = Float64Array.from({ length: 91 }, (_, d) => (d >= 90 ? 1e9 : Math.tan(d * RAD)));
const TAN_GENTLE = Math.tan(GENTLE_MAX * RAD);
const TAN_WALK = Math.tan(WALK_MAX * RAD);
const TAN_STEEP = Math.tan(STEEP_MAX * RAD);
const TAN_CLIMB = Math.tan(CLIMB_MAX * RAD);
const TAN_STAIR = Math.tan(STAIR_MAX * RAD);
const ORTHO = [0, 2, 4, 6];
const DIAG = [1, 3, 5, 7];
// For diagonal d: the two orthogonal directions it needs.
const SIDES = { 1: [0, 2], 3: [4, 2], 5: [4, 6], 7: [0, 6] };

// The tile and column k of column (i, j) relative to the centre tile, or -1.
function resolver(around) {
	let tile = null;
	return {
		get tile() {
			return tile;
		},
		col(i, j) {
			const dc = i < 0 ? -1 : i >= TILE_CELLS ? 1 : 0;
			const dr = j < 0 ? -1 : j >= TILE_CELLS ? 1 : 0;
			if (dc < -1 || dc > 1 || dr < -1 || dr > 1 || i < -TILE_CELLS || j < -TILE_CELLS || i >= 2 * TILE_CELLS || j >= 2 * TILE_CELLS) return -1;
			tile = around[(dr + 1) * 3 + (dc + 1)];
			if (!tile) return -1;
			return (j - dr * TILE_CELLS) * TILE_CELLS + (i - dc * TILE_CELLS);
		},
	};
}

const isTerrain = (f) => (f & (FLAG.TERRAIN | FLAG.SWIM)) === FLAG.TERRAIN;

// Where the upper of two entries tops a staircase: the highest rise between
// the lower entry's height zLo and the upper entry `up` over the treads
// under it in its column (the tops of entries first..up - 1 above zLo,
// walkable or not: a stair's treads are thin spans that its risers, walls,
// do not join).
function treadRise(zs, first, up, zLo) {
	let rise = 0;
	let prev = zs[up];
	for (let w = up - 1; w >= first && zs[w] > zLo; w--) {
		if (prev - zs[w] > rise) rise = prev - zs[w];
		prev = zs[w];
	}
	return Math.max(rise, prev - zLo);
}

// The highest rise under the top tread (treadRise from the tread just below
// `up`; 0 with no tread between).
function lowerRise(zs, first, up, zLo) {
	const w = up - 1;
	return w >= first && zs[w] > zLo ? treadRise(zs, first, w, zLo) : 0;
}

// The link code (format.js) from an entry with flags fa, slope sa to one with
// fb, sb, height change dz over horizontal h; -1 when there is none. riser:
// the highest rise of the treads between the two (treadRise; Infinity:
// unknown), lower: the highest under the top tread (lowerRise), for
// staircases.
function linkClass(fa, sa, fb, sb, dz, h, riser = Infinity, lower = Infinity) {
	const adz = Math.abs(dz);
	if (fa & fb & FLAG.SWIM) return adz <= SWIM_STEP ? CLS.SWIM : -1;
	// Onto a terrain face too steep to stand on: climbing up it only (a
	// gradient along the face, across its fall line, understates its slope).
	if (isTerrain(fb) && sb > STEEP_MAX) return dz > 0 && adz <= h * TAN_CLIMB ? CLS.CLIMB : -1;
	if (isTerrain(fa) && isTerrain(fb)) {
		if (adz <= Math.max(STEP, h * TAN_GENTLE)) return CLS.WALK;
		if (adz <= h * TAN_WALK) return LINK_SLOPE;
		if (adz <= h * TAN_STEEP) return CLS.STEEP;
		// Up a climb only: down it one slides, which is a fall (linkTile).
		if (adz <= h * TAN_CLIMB) return dz > 0 ? CLS.CLIMB : -1;
		return adz <= JUMP ? CLS.JUMP : -1;
	}
	if (adz > Math.max(STEP, h * TAN[Math.min(WALK_MAX, Math.max(sa, sb))])) {
		if ((fa & fb & FLAG.WMO) && !((fa | fb) & FLAG.SWIM)) {
			// Onto a walkable model slope whose foot lies between the two
			// columns: a step of up to STEP, then the slope across the column (a
			// stair's treads or a ramp's foot the column centres miss: the
			// Tirisfal zeppelin tower's top flight, 2.5 yd onto a 39 degree
			// ramp; the Ruins of Lordaeron's bell tower steps, a 0.4 yd riser and
			// a 37 degree ramp). Only between surfaces a stair could be (both at
			// most STAIR_MAX) and no more than STEP + JUMP in all (as steps and a
			// jump): along a steeper model slope (a rock face, a roof) the slope
			// rule alone decides, and a short steep face over a high riser (a tree
			// root's 42 degree flank 2.2 yd above the floor, 3.2 yd at the column
			// centre) is no ramp. The tower's flight turns, so its lower column is
			// on the ramp too (38 degrees).
			const [up, low] = dz > 0 ? [sb, sa] : [sa, sb];
			if (Math.max(low, up) <= STAIR_MAX && adz <= Math.min(STEP + JUMP, STEP + h * TAN[up])) return LINK_SLOPE;
			if (riser <= STEP && adz <= h * TAN_STAIR) return LINK_SLOPE;
			// Steps higher than a stair's (rises to STEP, the top one to
			// JUMP): steps and a jump onto the top.
			if (lower <= STEP && riser <= JUMP && adz <= STEP + JUMP) return CLS.JUMP;
		}
		return adz <= JUMP ? CLS.JUMP : -1;
	}
	return (fa | fb) & FLAG.SWIM ? CLS.SWIM : CLS.WALK;
}

function linkTile(around) {
	const t = around[4];
	const { n, z, ceil, flags, first } = t;
	const links = new Uint8Array(8 * n).fill(NO_LINK);
	const fallFrom = [];
	const fallTo = [];
	const r = resolver(around);
	const DIAG_H = CELL * Math.SQRT2;
	// A wall on half-line h of column (i, j) within (lo, hi).
	const wallAt = (i, j, h, lo, hi) => {
		const k2 = r.col(i, j);
		return k2 >= 0 && wallBlocks(r.tile.walls, k2, h, lo, hi);
	};
	// A wall between column (i, j) and its neighbour (i + dx, j + dy) within
	// (lo, hi): on the two half-lines between them, or for a diagonal on the
	// eight half-lines of the four columns around the shared corner.
	const walled = (i, j, dx, dy, lo, hi) => {
		const hx = dx > 0 ? HALF.E : HALF.W;
		const hy = dy > 0 ? HALF.S : HALF.N;
		const ox = (hx + 2) & 3;
		const oy = (hy + 2) & 3;
		if (dy === 0) return wallAt(i, j, hx, lo, hi) || wallAt(i + dx, j, ox, lo, hi);
		if (dx === 0) return wallAt(i, j, hy, lo, hi) || wallAt(i, j + dy, oy, lo, hi);
		return (
			wallAt(i, j, hx, lo, hi) || wallAt(i, j, hy, lo, hi)
			|| wallAt(i + dx, j, ox, lo, hi) || wallAt(i + dx, j, hy, lo, hi)
			|| wallAt(i, j + dy, oy, lo, hi) || wallAt(i, j + dy, hx, lo, hi)
			|| wallAt(i + dx, j + dy, ox, lo, hi) || wallAt(i + dx, j + dy, oy, lo, hi)
		);
	};
	const link = (s, i, j, d) => {
		const [dx, dy] = DIRS[d];
		const k2 = r.col(i + dx, j + dy);
		if (k2 < 0) return;
		const t2 = r.tile;
		const zs = z[s];
		const cs = ceil[s];
		let best = -1;
		let bestCls = -1;
		let bestAbs = Infinity;
		const f2 = t2.first;
		const h = d & 1 ? DIAG_H : CELL;
		const kS = j * TILE_CELLS + i;
		for (let v = f2[k2], e = f2[k2 + 1]; v < e; v++) {
			if (t2.flags[v] & FLAG.BLOCKED) continue;
			const zv = t2.z[v];
			if (Math.min(cs, t2.ceil[v]) - Math.max(zs, zv) < AGENT_HEIGHT) continue;
			const adz = Math.abs(zv - zs);
			if (adz >= bestAbs) continue;
			const riser = zv > zs ? treadRise(t2.z, f2[k2], v, zs) : treadRise(z, first[kS], s, zv);
			const lower = zv > zs ? lowerRise(t2.z, f2[k2], v, zs) : lowerRise(z, first[kS], s, zv);
			const cls = linkClass(flags[s], t.slope[s], t2.flags[v], t2.slope[v], zv - zs, h, riser, lower);
			if (cls < 0) continue;
			// No wall across the move between a step and a body height above the higher feet.
			const top = Math.max(zs, zv);
			if (walled(i, j, dx, dy, top + STEP, top + AGENT_HEIGHT)) continue;
			bestAbs = adz;
			best = v;
			bestCls = cls;
		}
		if (best < 0) return;
		links[s * 8 + d] = (bestCls << 5) | (best - f2[k2]);
	};
	// Open at height zs: an entry at most a step up whose gap holds the body.
	const open = (i, j, zs) => {
		const k2 = r.col(i, j);
		if (k2 < 0) return false;
		const t2 = r.tile;
		for (let v = t2.first[k2], e = t2.first[k2 + 1]; v < e; v++) if (t2.z[v] <= zs + STEP && t2.ceil[v] >= zs + AGENT_HEIGHT) return true;
		return false;
	};
	// Stable ground at entry v of column (i, j): under STEEP_MAX in a 2 x 2
	// block of level walkable surfaces under STEEP_MAX (format.js
	// STABLE_CELLS), no wall between them (a floor inside a solid is no
	// ground beside it).
	const stable = (i, j, t2, v) => {
		if (t2.flags[v] & FLAG.SWIM) return true;
		if (t2.slope[v] > STEEP_MAX) return false;
		const zv = t2.z[v];
		const level = (di, dj) => {
			if (walled(i, j, di, dj, zv + STEP, zv + AGENT_HEIGHT)) return false;
			const k3 = r.col(i + di, j + dj);
			if (k3 < 0) return false;
			const t3 = r.tile;
			for (let w = t3.first[k3], e = t3.first[k3 + 1]; w < e; w++) {
				if (!(t3.flags[w] & FLAG.BLOCKED) && t3.slope[w] <= STEEP_MAX && Math.abs(t3.z[w] - zv) <= STEP) return true;
			}
			return false;
		};
		// One of the four 2 x 2 blocks around the landing all level.
		for (const [a, b] of [[1, 1], [1, -1], [-1, 1], [-1, -1]]) if (level(a, 0) && level(0, b) && level(a, b)) return true;
		return false;
	};
	// The fall from (i, j) at height zs in direction (dx, dy): its landing ->
	// { reach, v (entry of that column) } or null.
	const fall = (i, j, zs, dx, dy) => {
		let top = zs; // the body's height while it slides
		let reach = 1;
		let firstLanding = true;
		while (reach <= FALL_SLIDE) {
			const ci = i + dx * reach;
			const cj = j + dy * reach;
			if (walled(ci - dx, cj - dy, dx, dy, top + STEP, top + AGENT_HEIGHT)) return null;
			const k2 = r.col(ci, cj);
			if (k2 < 0) return null;
			const t2 = r.tile;
			let land = -1;
			for (let v = t2.first[k2 + 1] - 1; v >= t2.first[k2]; v--) {
				if (t2.z[v] < top + STEP && t2.ceil[v] >= top + AGENT_HEIGHT) {
					land = v;
					break;
				}
			}
			if (land < 0) return null;
			if (t2.flags[land] & FLAG.BLOCKED) {
				// A lip or face: slide past it (the first landing within FALL_REACH).
				if (firstLanding && reach >= FALL_REACH) return null;
				reach++;
				continue;
			}
			// A first step down within JUMP is not a fall.
			if (firstLanding && t2.z[land] >= top - JUMP) return null;
			if (stable(ci, cj, t2, land)) return { reach, v: land - t2.first[k2], z: t2.z[land], swim: !!(t2.flags[land] & FLAG.SWIM) };
			firstLanding = false;
			top = t2.z[land];
			reach++;
		}
		return null;
	};
	for (let k = 0; k < TILE_CELLS * TILE_CELLS; k++) {
		const i = k & 255;
		const j = k >> 8;
		for (let s = first[k], e = first[k + 1]; s < e; s++) {
			if (flags[s] & FLAG.BLOCKED) continue;
			for (const d of ORTHO) link(s, i, j, d);
			for (const d of DIAG) {
				const [a, b] = SIDES[d];
				if (links[s * 8 + a] !== NO_LINK && links[s * 8 + b] !== NO_LINK) link(s, i, j, d);
			}
			if (flags[s] & FLAG.SWIM) continue;
			const zs = z[s];
			for (let d = 0; d < 8; d++) {
				if (links[s * 8 + d] !== NO_LINK) continue;
				const [dx, dy] = DIRS[d];
				if (d & 1) {
					const [a, b] = SIDES[d];
					if (!open(i + DIRS[a][0], j + DIRS[a][1], zs) || !open(i + DIRS[b][0], j + DIRS[b][1], zs)) continue;
				}
				const f = fall(i, j, zs, dx, dy);
				if (!f) continue;
				const h = zs - f.z;
				if (h <= JUMP || h > (f.swim ? FALL_MAX_WATER : FALL_MAX)) continue;
				fallFrom.push(s);
				fallTo.push((((dx * f.reach + FALL_SLIDE) * FALL_SPAN + (dy * f.reach + FALL_SLIDE)) << 5) | f.v);
			}
		}
	}
	return { links, fallFrom: Uint32Array.from(fallFrom), fallTo: Uint16Array.from(fallTo) };
}

// Decodes a fall target -> { di, dj, layer }.
function fallTarget(code) {
	const off = code >> 5;
	return { di: Math.floor(off / FALL_SPAN) - FALL_SLIDE, dj: (off % FALL_SPAN) - FALL_SLIDE, layer: code & 31 };
}

module.exports = { linkTile, linkClass, fallTarget, resolver, SWIM_STEP, FALL_SPAN };
