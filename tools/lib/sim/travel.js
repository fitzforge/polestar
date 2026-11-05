'use strict';
// Travel between two points (docs/legacy/SIMULATION-js.md §1 "Travel graph"):
// walking or walk to a transport node + the network + walk from a node,
// whichever is cheaper. A walk is the walking router's when `sim walks` has
// routed it (tools/lib/sim/walks.js; × routeMul), else the straight line ×
// the continent's detour factor.
// The network: flights between known flight paths, boats/zeppelins/trams
// (average wait + ride) and walking between nodes of the same landmass.
// All-pairs shortest times over the nodes are kept per known-flight-path set
// (and mounted or not); learning one flight path updates the parent set's
// matrix in O(edges × N²) instead of recomputing it.
//
// Travel safety: a direct walk whose straight line crosses zones (other than
// the zones it starts and ends in) whose minimum mob level is DANGER_GAP or
// more above the character costs `deathRisk` seconds per such zone (deaths,
// corpse runs, detours), so the network path wins when it is safer. The
// crossed zones of a leg are sampled once (every 200 yd on run.danger) and
// cached by point pair.

const { NEAR_K, NEAR_CAND } = require('./run');

const SHORT = 400; // yards: below this, walking always wins
const DANGER_GAP = 5; // levels: zones this far above the character are dangerous to cross
const NONE = new Int32Array(0);

// Minimum levels (zoneMin: Map(zone -> level)) of the zones a straight line
// from (ax, ay) to (bx, by) crosses on danger grid g (world.danger's), not
// counting the end zones za and zb, highest first. Shared with sim walks,
// which re-routes a pair per level band only where this finds danger.
function crossedZones(g, zoneMin, ax, ay, bx, by, za, zb) {
	const dx = bx - ax;
	const dy = by - ay;
	const n = Math.ceil(Math.hypot(dx, dy) / g.cell);
	const seen = [];
	for (let i = 1; i < n; i++) {
		const gx = Math.floor((ax + (dx * i) / n) / g.cell) - g.gx0;
		const gy = Math.floor((ay + (dy * i) / n) / g.cell) - g.gy0;
		if (gx < 0 || gy < 0 || gx >= g.nx || gy >= g.ny) continue;
		const z = g.z[gx * g.ny + gy];
		if (!z || z === za || z === zb || seen.includes(z)) continue;
		seen.push(z);
	}
	const mins = [];
	for (const z of seen) {
		const m = zoneMin.get(z);
		if (m != null) mins.push(m);
	}
	return mins.length ? Int32Array.from(mins.sort((x, y) => y - x)) : NONE;
}

// opts.walk(a, b, level) -> yards or -1, a and b RUN point indices: walks from
// a lookup instead of run.walkRun. -1 means no routed walk: the leg then takes
// the straight line × detour, not world.walks. Node walks (node to node, point
// to its nearest nodes) take it at level 0, the sentinel for the base walk
// (band 0, no zone danger), and only where both ends are run points: a node
// point reaches the lookup only when the run indexes it (compileRun extraPts).
class Travel {
	constructor(run, tables, { cacheMax = 6000, walk = null } = {}) {
		this.run = run;
		this.walk = walk;
		this.t = tables;
		this.N = run.N;
		this.cacheMax = cacheMax;
		this.cache = new Map();
		this.crossCache = new Map();
		this.NP = run.ptList ? run.ptList.length : 0;
		this.NW = run.world ? run.world.points.length : 0;
		// Flight-path bit -> node.
		this.fpNode = [];
		for (let n = 0; n < run.N; n++) if (run.fpBit[n] >= 0) this.fpNode[run.fpBit[n]] = n;
		// Taxi edges by node.
		this.taxiFrom = Array.from({ length: run.N }, () => []);
		for (const [a, b, sec] of run.taxi) this.taxiFrom[a].push([b, sec]);
		// Walking yards between nodes and from each point to its near nodes:
		// routed where known, else the straight line × detour.
		const N = run.N;
		this.nodeWalk = new Float64Array(N * N).fill(Infinity);
		for (let i = 0; i < N; i++) {
			for (let j = 0; j < N; j++) {
				if (i === j || run.nodeR[i] !== run.nodeR[j]) continue;
				const r = this.routed(run.nodeW[i], run.nodeW[j]);
				this.nodeWalk[i * N + j] = r !== undefined ? r : Math.hypot(run.nodeX[i] - run.nodeX[j], run.nodeY[i] - run.nodeY[j]) * this.t.detour(run.nodeC[i]);
			}
		}
		// Each point's near nodes (near, NEAR_K per point, -1 past the last): of
		// its NEAR_CAND straight-line nearest (run.pNear), the NEAR_K a walk
		// reaches, fewest yards first; the straight-line nearest only where none
		// does (then every leg through them is Infinity, as their walks are).
		this.near = new Int32Array(this.NP * NEAR_K).fill(-1);
		this.nearWalk = new Float64Array(this.NP * NEAR_K);
		const cand = [];
		for (let a = 0; a < this.NP; a++) {
			cand.length = 0;
			for (let k = 0; k < NEAR_CAND; k++) {
				const n = run.pNear[a * NEAR_CAND + k];
				if (n < 0) break;
				const r = this.routed(run.ptList[a], run.nodeW[n]);
				cand.push([r !== undefined ? r : run.pNearD[a * NEAR_CAND + k] * this.t.detour(run.pC[a]), k, n]);
			}
			const walked = cand.filter((c) => c[0] < Infinity).sort((x, y) => x[0] - y[0] || x[1] - y[1]);
			const pick = walked.length ? walked : cand;
			for (let k = 0; k < NEAR_K && k < pick.length; k++) {
				this.near[a * NEAR_K + k] = pick[k][2];
				this.nearWalk[a * NEAR_K + k] = pick[k][0];
			}
		}
		this.base = [this.baseMatrix(false), this.baseMatrix(true)];
	}

	// Routed yards between world points a and b (× routeMul), or undefined:
	// from opts.walk at level 0 when both are run points and it has one, else
	// from world.walks.
	routed(a, b) {
		if (this.walk) {
			const ia = this.run.ptIndex.get(a);
			const ib = ia === undefined ? undefined : this.run.ptIndex.get(b);
			const r = ib === undefined ? -1 : this.walk(ia, ib, 0);
			if (r >= 0) return r * this.t.p.routeMul;
		}
		const w = this.run.walks;
		if (!w) return undefined;
		const r = w.get(a * this.NW + b);
		return r === undefined ? undefined : r * this.t.p.routeMul;
	}

	speed(mounted) {
		const p = this.t.p;
		return p.runSpeed * (mounted ? p.mountMul : 1);
	}

	baseMatrix(mounted) {
		const { run, N } = this;
		const p = this.t.p;
		const D = new Float32Array(N * N).fill(Infinity);
		const v = this.speed(mounted);
		for (let i = 0; i < N; i++) {
			D[i * N + i] = 0;
			for (let j = 0; j < N; j++) {
				if (i === j || run.nodeR[i] !== run.nodeR[j]) continue;
				D[i * N + j] = this.nodeWalk[i * N + j] / v;
			}
		}
		for (const [a, b, ride, wait] of run.rides) {
			const c = ride + wait * p.transportWait;
			if (c < D[a * N + b]) D[a * N + b] = c;
		}
		// Floyd-Warshall.
		for (let k = 0; k < N; k++) {
			for (let i = 0; i < N; i++) {
				const dik = D[i * N + k];
				if (dik === Infinity) continue;
				for (let j = 0; j < N; j++) {
					const c = dik + D[k * N + j];
					if (c < D[i * N + j]) D[i * N + j] = c;
				}
			}
		}
		return D;
	}

	// Matrix for `mask` (bits = run.fpBit of known flight masters) when the
	// parent matrix `D` (mask without node k) is known.
	learn(D, mask, k, mounted) {
		const key = mounted ? mask + 2 ** 51 : mask;
		let M = this.cache.get(key);
		if (M) return M;
		if (this.cache.size >= this.cacheMax) this.cache.clear();
		M = D.slice();
		const { run, N } = this;
		const over = this.t.p.flightOverhead;
		const edges = [];
		for (const [b, sec] of this.taxiFrom[k]) {
			const bb = run.fpBit[b];
			if (bb >= 0 && Math.floor(mask / 2 ** bb) % 2 === 1) {
				edges.push(k, b, sec + over);
			}
		}
		for (let a = 0; a < N; a++) {
			if (a === k) continue;
			const ab = run.fpBit[a];
			if (ab < 0 || Math.floor(mask / 2 ** ab) % 2 !== 1) continue;
			for (const [b, sec] of this.taxiFrom[a]) if (b === k) edges.push(a, k, sec + over);
		}
		for (let e = 0; e < edges.length; e += 3) {
			const a = edges[e];
			const b = edges[e + 1];
			const w = edges[e + 2];
			if (!(w < M[a * N + b])) continue;
			for (let i = 0; i < N; i++) {
				const ia = M[i * N + a];
				if (ia === Infinity) continue;
				const base = ia + w;
				for (let j = 0; j < N; j++) {
					const c = base + M[b * N + j];
					if (c < M[i * N + j]) M[i * N + j] = c;
				}
			}
		}
		this.cache.set(key, M);
		return M;
	}

	// Matrix for a known-flight-path set, always built the same way: from the
	// set without its highest bit, adding that node (cached by set). A route's
	// times therefore never depend on which routes were evaluated before
	// (Float32 sums taken in another order would round differently).
	matrixFor(mask, mounted) {
		if (mask === 0) return this.base[mounted ? 1 : 0];
		const key = mounted ? mask + 2 ** 51 : mask;
		const hit = this.cache.get(key);
		if (hit) return hit;
		let b = this.fpNode.length - 1;
		while (b > 0 && Math.floor(mask / 2 ** b) % 2 !== 1) b--;
		return this.learn(this.matrixFor(mask - 2 ** b, mounted), mask, this.fpNode[b], mounted);
	}

	// Minimum levels of the zones a straight walk from a to b crosses (not
	// counting the zones of a and b), highest first; cached per pair.
	crossed(a, b) {
		const key = a * this.NP + b;
		let c = this.crossCache.get(key);
		if (c) return c;
		const run = this.run;
		const g = run.danger && run.danger.get(run.pR[a]);
		c = g ? crossedZones(g, run.zoneMin, run.pX[a], run.pY[a], run.pX[b], run.pY[b], run.pMap[a], run.pMap[b]) : NONE;
		if (this.crossCache.size >= 200000) this.crossCache.clear();
		this.crossCache.set(key, c);
		return c;
	}

	// Seconds of the direct walk from point a to point b at speed v (yd/s) for
	// a character of `level`: routed yards (opts.walk or run.walkRun) or the
	// straight line × detour, plus `risk` seconds per crossed zone DANGER_GAP or
	// more above the level, unless the walk is short. Infinity across regions.
	// Sets this.lastRisk (zones priced) and this.lastShort (a short walk, which
	// always wins).
	directWalk(a, b, v, level, risk) {
		this.lastRisk = 0;
		this.lastShort = false;
		const run = this.run;
		if (run.pR[a] !== run.pR[b]) return Infinity;
		const d = Math.hypot(run.pX[a] - run.pX[b], run.pY[a] - run.pY[b]);
		const ry = this.walk ? this.walk(a, b, level) : run.walkRun ? run.walkRun[a * this.NP + b] : -1;
		const r = ry >= 0 ? ry * this.t.p.routeMul : undefined;
		let walk = (r !== undefined ? r : d * this.t.detour(run.pC[a])) / v;
		// A short walk always wins; a short line round a cliff is not short.
		if ((r !== undefined ? r : d) < SHORT) {
			this.lastShort = true;
			return walk;
		}
		if (risk > 0) {
			const mins = this.crossed(a, b);
			let k = 0;
			while (k < mins.length && mins[k] >= level + DANGER_GAP) k++;
			if (k) {
				walk += k * risk;
				this.lastRisk = k;
			}
		}
		return walk;
	}

	// Seconds from point a to point b (run point indices) with matrix D, for
	// a character of `level` (travel safety). Returns walking-only time when
	// that is cheaper. Sets this.lastMode: 0 walk, 1 network; this.lastRisk:
	// dangerous zones the chosen walk crosses; on a network leg this.lastNi /
	// this.lastNj: the nodes it walks to and from.
	leg(a, b, D, mounted, level = 60) {
		this.lastRisk = 0;
		if (a === b) return 0;
		const run = this.run;
		const v = this.speed(mounted);
		const walk = this.directWalk(a, b, v, level, this.t.p.deathRisk);
		if (this.lastShort) {
			this.lastMode = 0;
			return walk;
		}
		let best = walk;
		this.lastMode = 0;
		const N = this.N;
		const ka = a * NEAR_K;
		const kb = b * NEAR_K;
		for (let i = 0; i < NEAR_K; i++) {
			const ni = this.near[ka + i];
			if (ni < 0) break;
			const wi = this.nearWalk[ka + i] / v;
			if (wi >= best) continue;
			for (let j = 0; j < NEAR_K; j++) {
				const nj = this.near[kb + j];
				if (nj < 0) break;
				const dn = D[ni * N + nj];
				const c = wi + dn + this.nearWalk[kb + j] / v;
				if (c < best) {
					// A "network" path that only walks between nodes is a walk
					// (never cheaper than the direct one, which carries the
					// travel-safety cost): it does not count.
					if (ni === nj) continue;
					if (run.nodeR[ni] === run.nodeR[nj] && dn >= this.nodeWalk[ni * N + nj] / v - 0.05) continue;
					best = c;
					this.lastMode = 1;
					this.lastNi = ni;
					this.lastNj = nj;
				}
			}
		}
		if (this.lastMode === 1) this.lastRisk = 0;
		return best;
	}
}

module.exports = { Travel, SHORT, DANGER_GAP, crossedZones };
