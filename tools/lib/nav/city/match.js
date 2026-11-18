'use strict';
// `nav city match`: one area's recorded on-foot movement (nav city extract's <priv>/<uiMap>.jsonl) map-matched onto the
// walking grid's surfaces. The recordings carry no height (Forever's UnitPosition gives none), so each breadcrumb's
// floor is recovered with a hidden-Markov match (Viterbi):
//   candidates   the walkable surfaces of the breadcrumb's column, plus each level within 2 columns the column lacks
//                (4 for an NPC window whose NPC's level the column lacks)
//   transitions  the shortest walk on the grid between consecutive breadcrumbs (bounded at 2.5 x the chord + 30 yd);
//                only the excess over the chord + 8% + 3 yd costs. Where the grid has no walk between two breadcrumbs
//                on one level (within 8 yd of height, 60 yd apart at most) the match jumps (cost 20) and records a
//                grid hole (gaps.json: a door, threshold or stair the grid closes)
//   evidence     NPC windows pin the floor to the NPC's spawn height (spawnz.json; within 4 yd free, else 50 + 10/yd:
//                BV Addon Suite - Routing's idea); the indoors flag is evidence for an indoor surface (outdoors says
//                nothing: city streets are indoor WMO groups); the swim flag; terrain just under a model surface (a
//                street over the ground it was built on) costs 3
//   two passes   pass 1 keeps only pieces holding an anchor; pass 2 matches all with pass 1's surfaces as a prior (a
//                surface no anchored piece walked, in a column where another one was, costs 15). An anchor whose
//                floor the chain can't reach restarts the chain at the anchor.
// Writes <priv>/<uiMap>/: density.bin (12 bytes per graph node: u16 people, u16 people outside the held-out fifth, u32
// sessions, u32 passes), trips.json (walks between stops), gaps.json (grid holes), stats.json, graph.json (the graph's
// box, to check the gate builds the same one). People are split by a hash of their contributor id: 1 in 5 held out
// (`test`), never counted in the training counts. PRIVATE outputs.
//
//   segmentsOf(session, map, frames, npcZ, cut, { stops }) -> pieces of continuous on-foot movement: [{ t, wx, wy, flags,
//     z (an anchor's NPC height), kind, npc, stop }]; stops: extra event kinds that end a walk (world trips: objective
//     ticks, gathering) besides NPC windows and flights
//   makeMatcher(g, { prior }) -> { viterbi(seg, st), expand(seg, piece, st, gaps, wi, test) -> { full, at } }

const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const { AreaGraph, CITIES, FLAG, toWorld } = require('./graph');

const isTest = (who) => crypto.createHash('sha1').update(String(who)).digest()[0] % 5 === 0;
const ANCHOR_KINDS = new Set(['vendor', 'trainer', 'turnin', 'accept', 'offer', 'gossip', 'fp', 'bind', 'detail']);
const STOP_KINDS = new Set(['vendor', 'trainer', 'turnin', 'accept', 'offer', 'gossip', 'fp', 'bind', 'detail', 'land', 'taxi']);
const BREAK_KINDS = new Set(['land', 'taxi', 'enter', 'death', 'revive']);
const JUMP_DZ = 8;
const JUMP_CHORD = 60;
const JUMP_COST = 20;
const OFF_ANCHORED = 15;
const BEAM = 150;

// The NPC's spawn height nearest (within 12 yd) to a world point on continent c, or null.
function spawnHeight(spawnz, c) {
	return (npc, wx, wy) => {
		const s = npc && spawnz[String(npc)];
		if (!s) return null;
		let best = null;
		let bd = 12;
		for (const [sc, x, y, z] of s) {
			if (sc !== c) continue;
			const d = Math.hypot(x - wx, y - wy);
			if (d < bd) {
				bd = d;
				best = z;
			}
		}
		return best;
	};
}

const blankCut = () => ({ samples: 0, dead: 0, mounted: 0, swim: 0, seconds: 0, segments: 0, breaks: { gap: 0, speed: 0, event: 0, nomatch: 0, anchor: 0 }, anchors: 0, anchorsWithZ: 0 });

function segmentsOf(s, map, frames, npcZ, cut = blankCut(), { stops = null } = {}) {
	const segs = [];
	let cur = [];
	const flush = () => {
		if (cur.length >= 2) segs.push(cur);
		cur = [];
	};
	for (const [t, k, m, x, y, fl, , ex] of s.ev) {
		if (BREAK_KINDS.has(k) || (k === 'ride' && ex && ex.on)) {
			if ((STOP_KINDS.has(k) || (stops && stops.has(k))) && m === map && x !== null && cur.length) {
				const [wx, wy] = toWorld(frames, map, x, y);
				cur.push({ t, wx, wy, flags: null, z: null, kind: k, npc: null, stop: true });
			}
			if (cur.length) cut.breaks.event++;
			flush();
			if (k === 'land' && m === map && x !== null) {
				const [wx, wy] = toWorld(frames, map, x, y);
				cur.push({ t, wx, wy, flags: null, z: null, kind: k, npc: null, stop: true });
			}
			continue;
		}
		if (m !== map || x === null || x === undefined) {
			if (m !== null && m !== undefined && m !== map) flush();
			continue;
		}
		const [wx, wy] = toWorld(frames, map, x, y);
		if (k === 'pos') {
			cut.samples++;
			if (fl !== null && fl & 32) {
				cut.dead++;
				flush();
				continue;
			}
			if (fl !== null && fl & 1) cut.mounted++;
			if (fl !== null && fl & 2) cut.swim++;
			const last = cur[cur.length - 1];
			if (last) {
				const dt = t - last.t;
				const d = Math.hypot(wx - last.wx, wy - last.wy);
				if (dt > 180) {
					cut.breaks.gap++;
					flush();
				} else if (d > 4 + 30 * Math.max(dt, 1)) {
					cut.breaks.speed++;
					flush();
				} else if (dt < 60) cut.seconds += dt;
			}
			cur.push({ t, wx, wy, flags: fl === undefined ? null : fl, z: null, kind: 'pos' });
		} else if (ANCHOR_KINDS.has(k) && ex && ex.npc) {
			cut.anchors++;
			const z = npcZ(ex.npc, wx, wy);
			if (z !== null) cut.anchorsWithZ++;
			const last = cur[cur.length - 1];
			if (last && Math.hypot(wx - last.wx, wy - last.wy) < 0.5 && last.npc === ex.npc) continue;
			cur.push({ t, wx, wy, flags: null, z, kind: k, npc: ex.npc, stop: true });
		} else if (stops && stops.has(k)) {
			const last = cur[cur.length - 1];
			if (last && last.kind === k && Math.hypot(wx - last.wx, wy - last.wy) < 20) continue;
			cur.push({ t, wx, wy, flags: null, z: null, kind: k, npc: null, stop: true });
		}
	}
	flush();
	cut.segments += segs.length;
	return segs;
}

// The matcher of one graph. prior (optional): { anch: Uint16Array per node, colAnch: Uint8Array per column }, pass 2's
// floor prior.
function makeMatcher(g, { prior = null } = {}) {
	function candidatesFor(s) {
		const ci = g.colIndex(s.wx, s.wy);
		if (ci < 0) return [];
		const li = ci % g.W;
		const lj = (ci - li) / g.W;
		const cs = g.colNodes(ci);
		const R = s.z !== null && !cs.some((v) => Math.abs(g.nz[v] - s.z) <= 4) ? 4 : 2;
		for (let r = 1; r <= R; r++) {
			for (let dj = -r; dj <= r; dj++) {
				for (let di = -r; di <= r; di++) {
					if (Math.max(Math.abs(di), Math.abs(dj)) !== r) continue;
					const a = li + di;
					const b = lj + dj;
					if (a < 0 || b < 0 || a >= g.W || b >= g.H) continue;
					for (const u of g.colNodes(b * g.W + a)) {
						if (r > 2 && Math.abs(g.nz[u] - s.z) > 4) continue;
						if (!cs.some((v) => Math.abs(g.nz[v] - g.nz[u]) <= 3)) cs.push(u);
					}
				}
			}
		}
		return cs;
	}

	function emission(v, s) {
		let c = 0;
		if (s.flags !== null && s.flags !== undefined) {
			if ((s.flags & 4) && !(g.nflags[v] & FLAG.INDOOR)) c += 8;
			if (((s.flags & 2) !== 0) !== ((g.nflags[v] & FLAG.SWIM) !== 0)) c += 10;
		}
		if (g.nflags[v] & FLAG.TERRAIN) {
			for (const u of g.colNodes(g.ncol[v])) {
				if (u !== v && (g.nflags[u] & (FLAG.WMO | FLAG.M2)) && g.nz[u] > g.nz[v] + 0.5 && g.nz[u] < g.nz[v] + 8) {
					c += 3;
					break;
				}
			}
		}
		if (prior && !prior.anch[v] && prior.colAnch[g.ncol[v]]) c += OFF_ANCHORED;
		if (s.z !== null) {
			const dz = Math.abs(g.nz[v] - s.z);
			if (dz > 4) c += 50 + 10 * (dz - 4);
		}
		return c;
	}

	function viterbi(seg, st) {
		const K = seg.length;
		const cand = seg.map(candidatesFor);
		const score = [cand[0].map((v) => emission(v, seg[0]))];
		const back = [cand[0].map(() => -1)];
		const jump = [cand[0].map(() => false)];
		const pieces = [];
		let start = 0;
		const finish = (end) => {
			if (end < start) return;
			let bi = -1;
			let bs = Infinity;
			score[end].forEach((x, j) => {
				if (x < bs) {
					bs = x;
					bi = j;
				}
			});
			if (bi < 0) return;
			const nodes = new Array(end - start + 1);
			const jumps = new Set();
			for (let i = end, j = bi; i >= start; i--) {
				nodes[i - start] = cand[i][j];
				if (jump[i][j]) jumps.add(i - start);
				j = back[i][j];
			}
			pieces.push({ from: start, to: end, nodes, jumps });
		};
		for (let i = 1; i < K; i++) {
			const a = seg[i - 1];
			const b = seg[i];
			const chord = Math.hypot(a.wx - b.wx, a.wy - b.wy);
			const bound = 2.5 * chord + 30;
			const sc = cand[i].map(() => Infinity);
			const bk = cand[i].map(() => -1);
			const jp = cand[i].map(() => false);
			const em = cand[i].map((v) => emission(v, b));
			if (cand[i].length && score[i - 1].some((x) => x < Infinity)) {
				const goal = g.local(b.wx, b.wy);
				const best = Math.min(...score[i - 1]);
				cand[i - 1].forEach((sv, j) => {
					const base = score[i - 1][j];
					if (base === Infinity || base > best + BEAM) return;
					g.search([[sv, 0]], cand[i], { bound, goal });
					cand[i].forEach((tv, q) => {
						const d = g.d(tv);
						if (d === Infinity || d > bound) {
							if (chord > JUMP_CHORD || Math.abs(g.nz[tv] - g.nz[sv]) > JUMP_DZ) return;
							const c = base + JUMP_COST + 0.5 * chord + em[q];
							if (c < sc[q]) {
								sc[q] = c;
								bk[q] = j;
								jp[q] = true;
							}
							return;
						}
						const c = base + Math.max(0, d - 1.08 * chord - 3) + em[q];
						if (c < sc[q]) {
							sc[q] = c;
							bk[q] = j;
							jp[q] = false;
						}
					});
				});
			}
			score[i] = sc;
			back[i] = bk;
			jump[i] = jp;
			const lost = b.z !== null && cand[i].some((v) => Math.abs(g.nz[v] - b.z) <= 4) && !cand[i].some((v, q) => Math.abs(g.nz[v] - b.z) <= 4 && sc[q] < Infinity);
			if (lost || !sc.some((x) => x < Infinity)) {
				st.breaks[lost ? 'anchor' : 'nomatch']++;
				finish(i - 1);
				start = i;
				score[i] = em.slice();
				back[i] = cand[i].map(() => -1);
				jump[i] = cand[i].map(() => false);
			}
		}
		finish(K - 1);
		return pieces;
	}

	// A piece's walk on the grid through its samples (a jump adds the next sample's surface alone): full node list and,
	// per sample, its index in it. Grid holes go to gaps.
	function expand(seg, pc, st, gaps, wi, test) {
		const n = pc.to - pc.from + 1;
		const full = [pc.nodes[0]];
		const at = [0];
		for (let i = 1; i < n; i++) {
			const a = pc.nodes[i - 1];
			const b = pc.nodes[i];
			const A = seg[pc.from + i - 1];
			const B = seg[pc.from + i];
			if (pc.jumps.has(i)) {
				st.jumps++;
				if (gaps) gaps.push({ a: [+A.wx.toFixed(1), +A.wy.toFixed(1)], b: [+B.wx.toFixed(1), +B.wy.toFixed(1)], za: +g.nz[a].toFixed(1), zb: +g.nz[b].toFixed(1), chord: +Math.hypot(A.wx - B.wx, A.wy - B.wy).toFixed(1), dt: +(B.t - A.t).toFixed(1), who: wi, test });
				full.push(b);
			} else if (a === b) {
				// same surface
			} else {
				g.search([[a, 0]], [b], { goal: g.local(B.wx, B.wy), bound: 2.5 * Math.hypot(B.wx - A.wx, B.wy - A.wy) + 31 });
				const p = g.pathTo(b);
				if (p) for (let q = 1; q < p.length; q++) full.push(p[q]);
				else full.push(b);
			}
			at.push(full.length - 1);
		}
		return { full, at };
	}

	return { viterbi, expand };
}

// A walk between two stops of a matched piece, or null when it is not one: stops at least 50 yd apart with 2+
// breadcrumbs between, a different NPC at each end.
function tripOf(g, seg, pc, full, at, lastStop, i) {
	const A = seg[pc.from + lastStop];
	const B = seg[pc.from + i];
	const straight = Math.hypot(A.wx - B.wx, A.wy - B.wy);
	if (straight < 50 || i - lastStop - 1 < 2 || (A.npc && A.npc === B.npc)) return null;
	const sub = full.slice(at[lastStop], at[i] + 1);
	let jumps = 0;
	for (let q = lastStop + 1; q <= i; q++) if (pc.jumps.has(q)) jumps++;
	return {
		t: [A.t, B.t], jumps,
		A: { wx: A.wx, wy: A.wy, z: g.nz[pc.nodes[lastStop]], node: pc.nodes[lastStop], kind: A.kind, npc: A.npc, anchored: A.z !== null },
		B: { wx: B.wx, wy: B.wy, z: g.nz[pc.nodes[i]], node: pc.nodes[i], kind: B.kind, npc: B.npc, anchored: B.z !== null },
		straight, L: g.pathYards(sub), dt: B.t - A.t, nPos: i - lastStop - 1, path: sub,
		samples: seg.slice(pc.from + lastStop, pc.from + i + 1).map((x) => [+x.wx.toFixed(1), +x.wy.toFixed(1)]),
	};
}

function matchArea({ map, grid, frames, spawnz, priv, log = () => {} }) {
	const t0 = Date.now();
	const city = CITIES[map];
	const out = path.join(priv, String(map));
	fs.mkdirSync(out, { recursive: true });
	const g = AreaGraph.forMap(map, { grid, frames });
	const npcZ = spawnHeight(spawnz, g.c);
	log(`${city ? city.name : map}: graph ${g.n} nodes, ${g.m} edges`);
	const sessions = fs.readFileSync(path.join(priv, `${map}.jsonl`), 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
	sessions.sort((a, b) => (a.who < b.who ? -1 : a.who > b.who ? 1 : a.sid < b.sid ? -1 : 1));
	const whoIdx = new Map();
	for (const s of sessions) if (!whoIdx.has(s.who)) whoIdx.set(s.who, whoIdx.size);
	const cut = blankCut();
	const segsOf = sessions.map((s) => segmentsOf(s, map, frames, npcZ, cut));

	function run(pass, prior) {
		const m = makeMatcher(g, { prior });
		const st = { ...blankCut(), matched: 0, jumps: 0, samplesInAnchoredSegments: 0, indoorFlagged: 0, indoorAgree: 0 };
		const people = new Uint16Array(g.n);
		const peopleTrain = new Uint16Array(g.n);
		const sess = new Uint32Array(g.n);
		const passes = new Uint32Array(g.n);
		const lastWho = new Int32Array(g.n).fill(-1);
		const lastSess = new Int32Array(g.n).fill(-1);
		const trips = [];
		const gaps = [];
		sessions.forEach((s, sIdx) => {
			const wi = whoIdx.get(s.who);
			const test = isTest(s.who);
			for (const seg of segsOf[sIdx]) {
				for (const pc of m.viterbi(seg, st)) {
					const piece = seg.slice(pc.from, pc.to + 1);
					const anchored = piece.some((x) => x.z !== null);
					if (pass === 1 && !anchored) continue;
					const nPos = piece.filter((x) => x.kind === 'pos').length;
					st.matched += nPos;
					if (anchored) st.samplesInAnchoredSegments += nPos;
					piece.forEach((smp, i) => {
						if (smp.kind === 'pos' && smp.flags !== null && smp.flags & 4) {
							st.indoorFlagged++;
							if (g.nflags[pc.nodes[i]] & FLAG.INDOOR) st.indoorAgree++;
						}
					});
					const { full, at } = m.expand(seg, pc, st, gaps, wi, test);
					for (const v of full) {
						passes[v]++;
						if (lastSess[v] !== sIdx) {
							lastSess[v] = sIdx;
							sess[v]++;
						}
						if (lastWho[v] !== wi) {
							lastWho[v] = wi;
							people[v]++;
							if (!test) peopleTrain[v]++;
						}
					}
					if (pass === 1) continue;
					let lastStop = -1;
					for (let i = 0; i < piece.length; i++) {
						if (!piece[i].stop) continue;
						if (lastStop >= 0) {
							const t = tripOf(g, seg, pc, full, at, lastStop, i);
							if (t) trips.push({ who: wi, test, sid: sIdx, fac: s.fac, ...t });
						}
						lastStop = i;
					}
				}
			}
			if (sIdx % 400 === 0) log(`pass ${pass} ${sIdx}/${sessions.length} ${((Date.now() - t0) / 1000).toFixed(0)} s`);
		});
		return { st, people, peopleTrain, sess, passes, trips, gaps };
	}

	const r1 = run(1, null);
	const colAnch = new Uint8Array(g.W * g.H);
	for (let v = 0; v < g.n; v++) if (r1.people[v]) colAnch[g.ncol[v]] = 1;
	const pass1 = { matched: r1.st.matched, surfaces: r1.people.reduce((s, x) => s + (x > 0), 0) };
	const { st, people, peopleTrain, sess, passes, trips, gaps } = run(2, { anch: r1.people, colAnch });
	const buf = Buffer.alloc(g.n * 12);
	for (let v = 0; v < g.n; v++) {
		buf.writeUInt16LE(people[v], 12 * v);
		buf.writeUInt16LE(peopleTrain[v], 12 * v + 2);
		buf.writeUInt32LE(sess[v], 12 * v + 4);
		buf.writeUInt32LE(passes[v], 12 * v + 8);
	}
	fs.writeFileSync(path.join(out, 'density.bin'), buf);
	fs.writeFileSync(path.join(out, 'trips.json'), JSON.stringify(trips));
	fs.writeFileSync(path.join(out, 'gaps.json'), JSON.stringify(gaps));
	fs.writeFileSync(path.join(out, 'graph.json'), JSON.stringify({ map, c: g.c, n: g.n, W: g.W, H: g.H, gi0: g.gi0, gj0: g.gj0, grid: path.resolve(grid) }));
	const stats = {
		map, sessions: sessions.length, people: whoIdx.size, ...st, ...cut, breaks: { ...cut.breaks, nomatch: st.breaks.nomatch, anchor: st.breaks.anchor }, pass1,
		hoursMoving: Math.round(cut.seconds / 3600), trips: trips.length, testTrips: trips.filter((x) => x.test).length, gaps: gaps.length, nodes: g.n,
		trodden3: people.reduce((s, x) => s + (x >= 3), 0), ms: Date.now() - t0,
	};
	fs.writeFileSync(path.join(out, 'stats.json'), JSON.stringify(stats, null, 1));
	return stats;
}

module.exports = { matchArea, spawnHeight, isTest, segmentsOf, makeMatcher, tripOf, blankCut, ANCHOR_KINDS };
