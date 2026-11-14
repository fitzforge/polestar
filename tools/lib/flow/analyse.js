'use strict';
// What a player feels as bad flow on one walk (tools/lib/flow/walk.js), docs/ROUTE-FEEL.md has the definitions:
//   passed givers / enders   a giver within 40 yd (hub tier: 120 yd) of the walk offering a quest the character can
//                            take then, that the guide takes later; a finished quest's ender passed, handed in later
//   deferred work            the walk crosses an objective's spawn area with the quest in the log (missed merge: with
//                            the quest takeable from a giver already passed) and the guide comes back for it later
//   backtracks               a stop within 60 yd of one left under 30 min before, after walking over 150 yd away
//   hub revisits, zigzags    a hub visited again within 20 min; a hub's stops walked in a longer order than nearest-first
//   retrace, reversals       ground walked twice; consecutive legs turning back
//   organisation             quests carried into later guides, picked up long before their work, never handed in
//   dungeon excursions       stops there only for dungeon steps, with their cost

const { WALK_YPS, dist, parseSpots, pyRound } = require('./data');
const { HUB, NEAR, STOP_YD, SAMPLE_YD, OBJ_TYPES, NEUTRAL, Counter, list, truthy, minBy } = require('./walk');

const AWAY = 150.0;          // the walk left the place in between
const LATER_S = 180.0;       // at least 3 min of clock later
const RETURN_YD = 60.0;      // backtracks
const RETURN_S = 30 * 60;
const REVISIT_S = 20 * 60;   // hub revisits
// Organisation: quests held across guides, picked up long before their work; dungeon trips of their own
const EARLY_S = 60 * 60;          // a pick-up made this long before the quest's first work is early
const CARRY_FAR_S = 120 * 60;     // a quest held across a guide's end this long is carried far ...
const CARRY_FAR_SPAN = 3;         // ... and so is one held through a whole guide (accepted and handed in 3+ guides apart)
const DETOUR_YD = 60.0;           // a stop whose detour is longer than this is a trip of its own

// Python-like text of a value (None for a missing one), so labels read the same as the audit's earlier output.
const py = (v) => (v == null ? 'None' : String(v));

// [entry index, point] along every walked path, the index of the goal the path leads to.
function* samples(entries) {
	for (const e of entries) {
		const p = e.path;
		if (!p) continue;
		const [c, pts] = p;
		for (let k = 0; k < pts.length - 1; k++) {
			const [ax, ay] = pts[k];
			const [bx, by] = pts[k + 1];
			const d = Math.hypot(bx - ax, by - ay);
			const n = Math.max(1, Math.trunc(d / SAMPLE_YD));
			const last = k === pts.length - 2 ? 1 : 0;
			for (let s = 0; s < n + last; s++) {
				const f = s / n;
				yield [e.i, [c, ax + (bx - ax) * f, ay + (by - ay) * f]];
			}
		}
	}
}

class Grid {
	constructor(cell) {
		this.cell = cell;
		this.g = new Map();
	}

	key(c, x, y) {
		return `${c}|${x}|${y}`;
	}

	add(p, item) {
		const k = this.key(p[0], Math.floor(p[1] / this.cell), Math.floor(p[2] / this.cell));
		if (!this.g.has(k)) this.g.set(k, []);
		this.g.get(k).push([p, item]);
	}

	* near(p, r) {
		const c = this.cell;
		const cx = Math.floor(p[1] / c), cy = Math.floor(p[2] / c);
		const k = Math.floor(r / c) + 1;
		for (let dx = -k; dx <= k; dx++) {
			for (let dy = -k; dy <= k; dy++) {
				const items = this.g.get(this.key(p[0], cx + dx, cy + dy));
				if (items) yield* items;
			}
		}
	}
}

const INDOOR_RE = /\b(inside|indoors|upstairs|top floor|below ground|basement|cellar|in the (inn|town hall|tavern|barracks|chapel|church|keep|tower))\b/i;
const BUILDING_YD = 30;

// Within one town visit, the moves into or out of a building (an NPC whose goal note says inside, upstairs, below
// ground; indoor NPCs within BUILDING_YD of each other are one building) and the re-entries (going back into a building
// the visit already left).
function buildingMoves(E, idx) {
	const npc = idx.filter((i) => ['accept', 'turnin', 'train', 'sethome'].includes(E[i].goal.t) && E[i].pos);
	const reps = [];
	let cur = null, doors = 0, reent = 0;
	const left = new Set();
	for (const i of npc) {
		const g = E[i].goal;
		let b = null;
		if (INDOOR_RE.test(g.note || '')) {
			const p = E[i].pos;
			const hit = reps.find(([q]) => q[0] === p[0] && dist(q, p) <= BUILDING_YD);
			b = hit ? hit[1] : reps.length;
			reps.push([p, b]);
		}
		if (b !== cur) {
			doors += (cur !== null ? 1 : 0) + (b !== null ? 1 : 0);
			if (cur !== null) left.add(cur);
			if (b !== null && left.has(b)) reent += 1;
			cur = b;
		}
	}
	return [doors, reent];
}

// Shortest walk a -> every point of pts (any order) -> b; exact up to 7 points, else greedy + 2-opt.
function openPath(a, pts, b) {
	const n = pts.length;
	if (n <= 7) {
		let best = Infinity;
		const perm = pts.map((_, i) => i);
		const used = new Array(n).fill(false);
		const cur = [];
		const rec = () => {
			if (cur.length === n) {
				let d = dist(a, pts[cur[0]]);
				for (let k = 0; k < n - 1; k++) d += dist(pts[cur[k]], pts[cur[k + 1]]);
				d += dist(pts[cur[n - 1]], b);
				if (d < best) best = d;
				return;
			}
			for (const i of perm) {
				if (used[i]) continue;
				used[i] = true;
				cur.push(i);
				rec();
				cur.pop();
				used[i] = false;
			}
		};
		rec();
		return best;
	}
	let order = [];
	const rest = pts.map((_, i) => i);
	let cur = a;
	while (rest.length) {
		const k = minBy(rest, (z) => dist(cur, pts[z]));
		order.push(k);
		rest.splice(rest.indexOf(k), 1);
		cur = pts[k];
	}
	const total = (o) => {
		let d = dist(a, pts[o[0]]);
		for (let k = 0; k < o.length - 1; k++) d += dist(pts[o[k]], pts[o[k + 1]]);
		return d + dist(pts[o[o.length - 1]], b);
	};
	let best = total(order);
	let improved = true;
	while (improved) {
		improved = false;
		for (let i = 0; i < n - 1; i++) {
			for (let j = i + 1; j < n; j++) {
				const o2 = [...order.slice(0, i), ...order.slice(i, j + 1).reverse(), ...order.slice(j + 1)];
				const t2 = total(o2);
				if (t2 < best - 1e-6) {
					order = o2;
					best = t2;
					improved = true;
				}
			}
		}
	}
	return best;
}

// Single-linkage clusters of [key, pos] within r yards: lists of keys.
function cluster(items, r) {
	const parent = new Map(items.map(([k]) => [k, k]));
	const find = (k) => {
		while (parent.get(k) !== k) {
			parent.set(k, parent.get(parent.get(k)));
			k = parent.get(k);
		}
		return k;
	};
	const grid = new Grid(r);
	for (const [k, p] of items) {
		for (const [gp, k2] of grid.near(p, r)) if (dist(gp, p) <= r) parent.set(find(k), find(k2));
		grid.add(p, k);
	}
	const out = new Map();
	for (const [k] of items) {
		const root = find(k);
		if (!out.has(root)) out.set(root, []);
		out.get(root).push(k);
	}
	return [...out.values()];
}

function hubName(E, members) {
	const names = [];
	const set = new Set(members);
	for (const e of E) {
		const go = e.goal;
		if (set.has(go.npc) && go.npcName && !names.includes(go.npcName)) names.push(go.npcName);
	}
	return names.slice(0, 3).join(', ');
}

function goalLabel(go) {
	const t = go.t;
	if (t === 'accept' || t === 'turnin') return `${t} ${py(go.title)} (${py(go.quest)})`;
	if (OBJ_TYPES.has(t)) return `${t} ${go.target || go.itemName || go.objName || go.npcName || ''} for ${py(go.title)}`;
	return `${t} ${go.location || go.npcName || ''}`.trim();
}

function analyse(w, quests, proj) {
	const E = w.entries;
	const n = E.length;
	const acc = w.acceptAt, tin = w.turninAt, ready = w.readyAt;
	const INF = 1e9;
	const getI = (m, q) => (m.has(q) ? m.get(q) : INF);
	const doneBefore = (q, j) => getI(tin, q) < j;
	const inLog = (q, j) => getI(acc, q) < j && j <= getI(tin, q);
	const acceptable = (q, j) => {
		const ia = acc.get(q);
		const go = E[ia].goal;
		if (j >= ia) return false;
		const L = j > 0 ? E[j - 1].level : 1;
		if (go.minLevel && L < go.minLevel) return false;
		if (go.qlvl && go.qlvl > L + 3) return false;
		for (const c of list(go.closedBy)) if (getI(acc, c) < j) return false;
		// Every prerequisite must be met at j: `pre` lists are any-of, `preAll` all-of; a prerequisite the walk never
		// hands in is not met.
		const qd = quests[String(q)] || {};
		const preAny = new Set([...list(go.pre), ...list(qd.pre), ...list(qd.preAny)]);
		if (preAny.size && ![...preAny].some((p) => doneBefore(p, j))) return false;
		for (const p of new Set([...list(go.preAll), ...list(qd.preAll)])) if (!doneBefore(p, j)) return false;
		return true;
	};

	// --- targets: givers (later accepts), enders (later turn-ins), objective areas
	const giv = new Grid(HUB);
	for (const [q, ia] of acc) {
		const e = E[ia];
		const go = e.goal;
		if (e.pos == null || !(go.npc || go.object) || e.along) continue;
		giv.add(e.pos, ['accept', q, ia]);
	}
	for (const [q, it] of tin) {
		const e = E[it];
		if (e.pos == null || e.along || !acc.has(q)) continue;
		giv.add(e.pos, ['turnin', q, it]);
	}
	const areas = new Grid(150.0);
	for (const e of E) {
		const go = e.goal;
		if (OBJ_TYPES.has(go.t) && go.quest != null && !e.along && e.pos != null) {
			for (const sp of parseSpots(go, proj)) areas.add(sp[0], [e.i, sp[1], sp[2], sp[3]]);
		}
	}

	const firstPass = new Map();   // "kind|q" -> { j, d, pos, closed, near_j, kind, q }
	const objPass = new Map();     // entry index of objective -> { j, kind, pos }
	for (const [j, p] of samples(E)) {
		for (const [gp, [kind, q, k]] of giv.near(p, HUB)) {
			if (k <= j) continue;
			const d = dist(p, gp);
			if (d > HUB) continue;
			const key = `${kind}|${q}`;
			const fp = firstPass.get(key);
			if (fp && fp.closed) continue;
			const ok = kind === 'accept' ? acceptable(q, j) : getI(ready, q) < j && inLog(q, j);
			if (!ok) continue;
			if (!fp) {
				firstPass.set(key, { kind, q, j, d, pos: gp, closed: false, near_j: d <= NEAR ? j : null });
			} else {
				if (d < fp.d) fp.d = d;
				if (d <= NEAR && fp.near_j === null) fp.near_j = j;
			}
		}
		for (const [ap, [k, r, , lvl]] of areas.near(p, 150.0)) {
			if (k <= j || objPass.has(k)) continue;
			if (dist(p, ap) > r) continue;
			const q = E[k].goal.quest;
			const L = j > 0 ? E[j - 1].level : 1;
			if (lvl && lvl > L + 2) continue;
			if (inLog(q, j)) {
				objPass.set(k, { j, kind: 'deferred', pos: ap });
			} else if (acc.has(q) && acc.get(q) > j && acceptable(q, j)) {
				const fp = firstPass.get(`accept|${q}`);
				if (fp && fp.j <= j) objPass.set(k, { j, kind: 'missed-merge', pos: ap });
			}
		}
	}

	const awayBetween = (pos, j0, j1) => {
		for (let k = j0; k < j1; k++) if (E[k].pos != null && dist(E[k].pos, pos) > AWAY) return true;
		return false;
	};

	const findings = [];
	const late = new Map();
	for (const fp of firstPass.values()) {
		const { kind, q } = fp;
		const k = kind === 'accept' ? acc.get(q) : tin.get(q);
		const j = fp.near_j !== null ? fp.near_j : fp.j;
		const tier = fp.near_j !== null ? 'near' : 'hub';
		if (E[k].t0 - E[j].t0 < LATER_S || !awayBetween(fp.pos, j, k)) continue;
		const f = {
			type: kind === 'accept' ? 'passed-giver' : 'passed-ender', tier, quest: q, zone: E[j].zone,
			title: E[k].goal.title ?? null, npc: E[k].goal.npcName || E[k].goal.objName || null,
			pass_gid: E[j].gid, pass_step: E[j].step, take_gid: E[k].gid, take_step: E[k].step,
			min_between: pyRound((E[k].t0 - E[j].t0) / 60, 1), closest_yd: pyRound(fp.d), k, j,
		};
		findings.push(f);
		late.set(k, f);
	}
	for (const [k, op] of objPass) {
		const j = op.j;
		if (E[k].t0 - E[j].t0 < LATER_S || !awayBetween(op.pos, j, k)) continue;
		const go = E[k].goal;
		const f = {
			type: op.kind, tier: 'area', quest: go.quest, title: go.title ?? null, zone: E[j].zone,
			target: go.target || go.itemName || go.objName || go.npcName || null,
			pass_gid: E[j].gid, pass_step: E[j].step, take_gid: E[k].gid, take_step: E[k].step,
			min_between: pyRound((E[k].t0 - E[j].t0) / 60, 1), k, j,
		};
		findings.push(f);
		late.set(k, f);
	}

	// --- stops
	const stops = [];
	let cur = null;
	for (const e of E) {
		if (e.pos == null || e.along) continue;
		if (cur !== null && e.mode === 'walk' && dist(e.pos, cur.last) <= STOP_YD) {
			cur.idx.push(e.i);
			cur.last = e.pos;
		} else {
			cur = { idx: [e.i], first: e.pos, last: e.pos, mode: e.mode };
			stops.push(cur);
		}
	}
	stops.forEach((s, si) => {
		s.si = si;
		s.blocking = s.idx.filter((i) => !NEUTRAL.has(E[i].goal.t));
		s.late = s.blocking.filter((i) => late.has(i));
		s.avoidable = s.blocking.length > 0 && s.late.length === s.blocking.length;
		s.t_in = E[s.idx[0]].t0;
		s.t_out = E[s.idx[s.idx.length - 1]].t1;
		s.gid = E[s.idx[0]].gid;
		s.step = E[s.idx[0]].step;
	});
	const cost = new Counter(), costZone = new Counter();
	stops.forEach((s, si) => {
		s.detour = 0.0;
		if (!s.avoidable) return;
		const a = si > 0 ? stops[si - 1].last : null;
		const b = si + 1 < stops.length ? stops[si + 1].first : null;
		if (a !== null && b !== null && s.first[0] === a[0] && a[0] === b[0] && stops[si + 1].mode === 'walk' && s.mode === 'walk') {
			const det = dist(a, s.first) + dist(s.last, b) - dist(a, b);
			s.detour = Math.max(0.0, det);
			cost.add(s.gid, s.detour / WALK_YPS / 60);
			costZone.add(E[s.idx[0]].zone, s.detour / WALK_YPS / 60);
		}
		for (const i of s.late) late.get(i).detour_min = pyRound(s.detour / WALK_YPS / 60, 1);
	});

	// --- backtracks
	const backs = [];
	stops.forEach((s, si) => {
		if (s.mode !== 'walk') return;
		for (let pj = si - 1; pj >= 0; pj--) {
			const p = stops[pj];
			if (s.t_in - p.t_out > RETURN_S) break;
			if (dist(p.last, s.first) > RETURN_YD && dist(p.first, s.first) > RETURN_YD) continue;
			let far = 0;
			for (let x = pj + 1; x < si; x++) far = Math.max(far, dist(stops[x].first, s.first));
			if (far > AWAY && far < Infinity) {
				backs.push({
					type: 'backtrack', gid: s.gid, step: s.step, from_step: p.step, zone: E[s.idx[0]].zone, from_gid: p.gid,
					min_since: pyRound((s.t_in - p.t_out) / 60, 1), yd_out: pyRound(far), avoidable: s.avoidable,
					goals: s.blocking.map((i) => goalLabel(E[i].goal)).slice(0, 6),
				});
			}
			break;
		}
	});

	// --- hubs
	const npcpos = new Map();
	for (const e of E) {
		const go = e.goal;
		if ((go.t === 'accept' || go.t === 'turnin') && e.pos != null && go.npc && !npcpos.has(go.npc)) npcpos.set(go.npc, e.pos);
	}
	const hubs = cluster([...npcpos.entries()], HUB);
	const hubOfNpc = new Map();
	hubs.forEach((members, hi) => {
		if (members.length >= 3) for (const m of members) hubOfNpc.set(m, hi);
	});
	const hubgrid = new Grid(HUB);
	for (const [npc, hi] of hubOfNpc) hubgrid.add(npcpos.get(npc), hi);
	const visits = [];
	for (const s of stops) {
		let hi = null;
		for (const [gp, h] of hubgrid.near(s.first, 60)) {
			if (dist(gp, s.first) <= 60) {
				hi = h;
				break;
			}
		}
		if (hi === null) continue;
		const last = visits[visits.length - 1];
		if (last && last.hub === hi && last.end_stop.si === s.si - 1) {
			last.stops.push(s);
			last.end_stop = s;
		} else {
			visits.push({ hub: hi, stops: [s], end_stop: s });
		}
	}
	// in-hub zigzag: yards walked from where the player enters the hub (the stop before) through its stops to where they
	// go next, against the shortest order of the same stops between those ends
	const zig = new Counter();
	const zigEx = [];
	for (const v of visits) {
		const st = v.stops;
		if (st.length < 2) continue;
		const ai = st[0].si - 1, bi = st[st.length - 1].si + 1;
		const ent = ai >= 0 && st[0].mode === 'walk' ? stops[ai].last : st[0].first;
		const ext = bi < stops.length && stops[bi].mode === 'walk' ? stops[bi].first : st[st.length - 1].last;
		if (ent[0] !== st[0].first[0] || ext[0] !== st[0].first[0]) continue;
		const pts = st.map((x) => x.first);
		let walked = dist(ent, pts[0]);
		for (let k = 0; k < pts.length - 1; k++) walked += dist(pts[k], pts[k + 1]);
		walked += dist(pts[pts.length - 1], ext);
		const ex = walked - openPath(ent, pts, ext);
		if (ex > 40 && ex < Infinity) {
			zig.add(st[0].gid, ex);
			zigEx.push({
				type: 'hub-zigzag', gid: st[0].gid, step: st[0].step, to_step: st[st.length - 1].step, to_gid: st[st.length - 1].gid,
				zone: E[st[0].idx[0]].zone, extra_yd: pyRound(ex), hub: hubName(E, hubs[v.hub]),
			});
		}
	}

	// ground walked twice: walked ground within 25 yd of ground walked 3-45 min before (outside hubs)
	const retrace = new Counter(), walkedZone = new Counter(), retraceG = new Counter(), walkedG = new Counter();
	const rgrid = new Grid(25.0);
	const hgrid = new Grid(60.0);
	for (const npc of hubOfNpc.keys()) hgrid.add(npcpos.get(npc), 1);
	for (const [j, p] of samples(E)) {
		const z = E[j].zone;
		const tj = E[j].t0;
		walkedZone.add(z, SAMPLE_YD);
		walkedG.add(E[j].gid, SAMPLE_YD);
		let inHub = false;
		for (const [hp] of hgrid.near(p, 60)) {
			if (dist(hp, p) <= 60) {
				inHub = true;
				break;
			}
		}
		if (inHub) continue;
		let hit = false;
		for (const [gp, tt] of rgrid.near(p, 25)) {
			if (tj - tt >= 180 && tj - tt <= 2700 && dist(gp, p) <= 25) {
				hit = true;
				break;
			}
		}
		if (hit) {
			retrace.add(z, SAMPLE_YD);
			retraceG.add(E[j].gid, SAMPLE_YD);
		}
		rgrid.add(p, tj);
	}

	// direction reversals: consecutive travel legs (>= 60 yd, not inside field work) turning more than 120 degrees
	const revs = [];
	const legs = [];
	for (let si = 1; si < stops.length; si++) {
		const a = stops[si - 1], b = stops[si];
		if (b.mode !== 'walk' || a.last[0] !== b.first[0]) {
			legs.push(null);
			continue;
		}
		const field = a.idx.some((i) => OBJ_TYPES.has(E[i].goal.t)) && b.idx.some((i) => OBJ_TYPES.has(E[i].goal.t));
		const d = dist(a.last, b.first);
		legs.push(field || d < 60 ? null : [a, b, d]);
	}
	for (let k = 1; k < legs.length; k++) {
		const l1 = legs[k - 1], l2 = legs[k];
		if (!l1 || !l2) continue;
		const v1 = [l1[1].first[1] - l1[0].last[1], l1[1].first[2] - l1[0].last[2]];
		const v2 = [l2[1].first[1] - l2[0].last[1], l2[1].first[2] - l2[0].last[2]];
		const cosang = (v1[0] * v2[0] + v1[1] * v2[1]) / (Math.hypot(...v1) * Math.hypot(...v2));
		if (cosang < -0.5) {
			const s = l2[0];
			revs.push({
				type: 'reversal', gid: s.gid, step: s.step, zone: E[s.idx[0]].zone, in_yd: pyRound(l1[2]), out_yd: pyRound(l2[2]),
				at: s.blocking.slice(0, 3).map((i) => goalLabel(E[i].goal)).join('; ') || goalLabel(E[s.idx[0]].goal),
			});
		}
	}
	// hub visits and the sweeps between them
	const hubv = [];
	let prevEnd = null;
	for (const v of visits) {
		const idx = v.stops.flatMap((s) => s.idx);
		const accN = idx.filter((i) => E[i].goal.t === 'accept').length;
		const tinN = idx.filter((i) => E[i].goal.t === 'turnin').length;
		let sweepQ = null, sweepMin = null;
		if (prevEnd !== null) {
			const qs = new Set();
			for (let i = prevEnd + 1; i < idx[0]; i++) if (OBJ_TYPES.has(E[i].goal.t) && E[i].goal.quest) qs.add(E[i].goal.quest);
			sweepQ = qs.size;
			sweepMin = pyRound((E[idx[0]].t0 - E[prevEnd].t1) / 60, 1);
		}
		const [doorsN, reentries] = buildingMoves(E, idx);
		hubv.push({
			zone: E[idx[0]].zone, gid: E[idx[0]].gid, step: E[idx[0]].step, accepts: accN, turnins: tinN, sweep_q: sweepQ,
			sweep_min: sweepMin, hub: v.hub, doors: doorsN, reentries,
		});
		prevEnd = idx[idx.length - 1];
	}
	const revisits = [];
	const lastv = new Map();
	for (const v of visits) {
		const h = v.hub;
		const pv = lastv.get(h);
		if (pv) {
			const gap = v.stops[0].t_in - pv.stops[pv.stops.length - 1].t_out;
			if (gap <= REVISIT_S) {
				const avoid = v.stops.every((s) => s.avoidable || !s.blocking.length) && v.stops.some((s) => s.blocking.length);
				revisits.push({
					type: 'hub-revisit', gid: v.stops[0].gid, step: v.stops[0].step, zone: E[v.stops[0].idx[0]].zone,
					prev_step: pv.stops[0].step, min_since: pyRound(gap / 60, 1), avoidable: avoid, hub: hubName(E, hubs[h]),
				});
			}
		}
		lastv.set(h, v);
	}

	// --- log usage
	const ev = [];
	for (const [q, ia] of acc) {
		ev.push([ia, 1]);
		if (tin.has(q)) ev.push([tin.get(q) + 0.5, -1]);
	}
	ev.sort((x, y) => x[0] - y[0] || x[1] - y[1]);
	let curN = 0, logMax = 0;
	for (const [, dlt] of ev) {
		curN += dlt;
		if (curN > logMax) logMax = curN;
	}
	const logByGid = new Counter();
	curN = 0;
	for (const [i, dlt] of ev) {
		curN += dlt;
		const ii = Math.min(Math.trunc(i), n - 1);
		const gid = E[ii].gid;
		logByGid.set(gid, Math.max(logByGid.get(gid), curN));
	}

	const res = {
		findings, backtracks: backs, revisits, cost, zig, zig_ex: zigEx, cost_zone: costZone, retrace, walked_zone: walkedZone,
		reversals: revs, retrace_g: retraceG, walked_g: walkedG, hubv, log_max: logMax, log_by_gid: logByGid, stops: stops.length,
		stop_list: stops,
	};
	res.org = organise(w, quests);
	res.dng = dungeonFlow(w, res);
	return res;
}

// How organised the branch's quests are. Per quest taken: where it was picked up, first worked (its first objective
// goal) and handed in.
//   carried  handed in in a later guide than its pick-up; span = guides from pick-up to hand-in, both counted; far: span
//            >= CARRY_FAR_SPAN (held through a whole guide) or held >= CARRY_FAR_S; crumb: a quest with no objectives
//   early    picked up EARLY_S or more before its first work
//   never    picked up and not handed in by the chain's end
// and the quest log's time-weighted mean, over the chain and per guide.
function organise(w, quests) {
	const E = w.entries;
	const order = new Map();
	for (const e of E) if (!order.has(e.gid)) order.set(e.gid, order.size);
	const firstWork = new Map();
	for (const e of E) {
		const q = e.goal.quest;
		if (q != null && OBJ_TYPES.has(e.goal.t) && !firstWork.has(q)) firstWork.set(q, e.i);
	}
	const carried = [], early = [], never = [];
	for (const [q, ia] of w.acceptAt) {
		const ea = E[ia];
		const qd = quests[String(q)] || {};
		const base = { quest: q, title: ea.goal.title ?? null, gid: ea.gid, step: ea.step, zone: ea.zone, dng: ea.dng || null, lv: ea.lv ?? null };
		const it = w.turninAt.get(q);
		if (it === undefined) {
			never.push(base);
		} else if (E[it].gid !== ea.gid) {
			const et = E[it];
			const span = order.get(et.gid) - order.get(ea.gid) + 1;
			const held = et.t0 - ea.t1;
			carried.push({
				...base, to_gid: et.gid, to_step: et.step, span, min: pyRound(held / 60, 1),
				far: span >= CARRY_FAR_SPAN || held >= CARRY_FAR_S, crumb: !truthy(qd.objectives) && !firstWork.has(q),
			});
		}
		const iw = firstWork.get(q);
		if (iw !== undefined && iw > ia && E[iw].t0 - ea.t1 >= EARLY_S) {
			early.push({
				...base, work_gid: E[iw].gid, work_step: E[iw].step, min: pyRound((E[iw].t0 - ea.t1) / 60, 1),
				span: order.get(E[iw].gid) - order.get(ea.gid) + 1,
			});
		}
	}
	// the log over time: +1 at each pick-up, -1 at each hand-in
	const ev = [];
	for (const [q, ia] of w.acceptAt) {
		ev.push([E[ia].t1, 1]);
		if (w.turninAt.has(q)) ev.push([E[w.turninAt.get(q)].t0, -1]);
	}
	ev.sort((x, y) => x[0] - y[0] || x[1] - y[1]);
	const segs = [];
	let n = 0;
	ev.forEach(([t, dlt], k) => {
		n += dlt;
		const t2 = k + 1 < ev.length ? ev[k + 1][0] : w.endT;
		if (t2 > t) segs.push([t, t2, n]);
	});
	const spanG = new Map();
	for (const e of E) {
		const [a, b] = spanG.get(e.gid) || [Infinity, -Infinity];
		spanG.set(e.gid, [Math.min(a, e.t0), Math.max(b, e.t1 ?? e.t0)]);
	}
	const meanOver = (a, b) => {
		if (b <= a) return 0.0;
		let s = 0;
		for (const [t1, t2, k] of segs) if (t2 > a && t1 < b) s += k * (Math.min(t2, b) - Math.max(t1, a));
		return s / (b - a);
	};
	const t0 = ev.length ? ev[0][0] : 0.0;
	const logMeanG = {};
	for (const [gid, [a, b]] of spanG) logMeanG[gid] = pyRound(meanOver(a, b), 1);
	return { carried, early, never, log_mean: pyRound(meanOver(t0, w.endT), 1), log_mean_g: logMeanG };
}

// With dungeons in the route (`dungeons`), what the dungeon steps (`when dungeon`) cost the walk.
//   excursions  each run of stops that are there only for dungeon steps (every goal that holds the step is a dungeon
//               step's; travel-only stops between them count in), with the stops before and after it: a pick-up trip, a
//               hand-in (return) trip, an errand of both, or a run (it has the door, `enter`). Cost: the travel of the
//               excursion and on to the next stop, less the walk from the stop before to the stop after (straight, when
//               the next stop is walked to on one continent; else the travel on is left out). A run's cost is its door
//               detour. Only excursions costing more than DETOUR_YD count.
//   carry       per dungeon quest (any of its goals in a dungeon step): minutes and guides from its pick-up to its first
//               work (the run, mostly), and from there to its hand-in.
function dungeonFlow(w, r) {
	const E = w.entries;
	const stops = r.stop_list;
	const order = new Map();
	for (const e of E) if (!order.has(e.gid)) order.set(e.gid, order.size);
	const cls = (s) => {
		const dng = s.idx.some((i) => E[i].dng);
		if (s.blocking.length && s.blocking.every((i) => E[i].dng)) return 'D';
		if (!s.blocking.length) return dng ? 'D' : 'X';
		return 'R';
	};
	const kinds = stops.map(cls);
	const exc = [];
	let k = 0;
	while (k < stops.length) {
		if (kinds[k] !== 'D') {
			k += 1;
			continue;
		}
		let j = k;
		while (j + 1 < stops.length && (kinds[j + 1] === 'D' || kinds[j + 1] === 'X')) j += 1;
		while (kinds[j] === 'X') j -= 1;
		const p = k - 1, nx = j + 1;
		if (p >= 0 && nx < stops.length) {
			const idx = stops.slice(k, nx).flatMap((s) => s.idx);
			const P = stops[p], N = stops[nx];
			let travel = 0;
			for (const i of idx) travel += E[i].move_s || 0;
			const n0 = E[N.idx[0]];
			const walkedOn = N.mode === 'walk' && P.last[0] === N.first[0];
			const cost = walkedOn ? travel + (n0.move_s || 0) - dist(P.last, N.first) / WALK_YPS : travel;
			const gt = new Set(idx.filter((i) => E[i].dng).map((i) => E[i].goal.t));
			const kind = gt.has('enter') ? 'run' : gt.has('accept') && !gt.has('turnin') ? 'pick-up' : gt.has('turnin') && !gt.has('accept') ? 'hand-in' : 'errand';
			if (cost * WALK_YPS > DETOUR_YD) {
				const first = E[idx[0]];
				const door = idx.map((i) => E[i]).find((e) => e.goal.t === 'enter');
				exc.push({
					type: `dungeon-${kind}`, gid: first.gid, step: first.step, zone: first.zone,
					dungeon: (idx.map((i) => E[i]).find((e) => e.dng) || {}).dng || null, min: pyRound(cost / 60, 1),
					flight: idx.some((i) => E[i].mode === 'fly'), walked_on: walkedOn, from_step: P.step, from_gid: P.gid,
					to_step: N.step, to_gid: N.gid, door_step: door ? door.step : null,
					goals: idx.filter((i) => !NEUTRAL.has(E[i].goal.t)).map((i) => goalLabel(E[i].goal)).slice(0, 6),
				});
			}
		}
		k = j + 1;
	}
	const firstWork = new Map();
	for (const e of E) {
		const q = e.goal.quest;
		if (q != null && OBJ_TYPES.has(e.goal.t) && !firstWork.has(q)) firstWork.set(q, e);
	}
	const dq = [...new Set(E.filter((e) => e.dng && e.goal.quest != null).map((e) => e.goal.quest))].sort((a, b) => a - b);
	const carry = [];
	for (const q of dq) {
		const ia = w.acceptAt.get(q);
		if (ia === undefined) continue;
		const ea = E[ia], ew = firstWork.get(q);
		const it = w.turninAt.get(q);
		const et = it !== undefined ? E[it] : null;
		const c = { quest: q, title: ea.goal.title ?? null, gid: ea.gid, step: ea.step, dungeon: ea.dng || null };
		if (ew && ew.i > ia) {
			Object.assign(c, {
				work_gid: ew.gid, work_step: ew.step, to_run_min: pyRound((ew.t0 - ea.t1) / 60, 1),
				to_run_span: order.get(ew.gid) - order.get(ea.gid) + 1,
			});
			if (et) Object.assign(c, { after_run_min: pyRound((et.t0 - ew.t1) / 60, 1), after_run_span: order.get(et.gid) - order.get(ew.gid) + 1 });
		}
		if (et) Object.assign(c, { turnin_gid: et.gid, turnin_step: et.step });
		carry.push(c);
	}
	return { excursions: exc, carry };
}

module.exports = { analyse, organise, dungeonFlow, goalLabel, openPath, cluster, Grid, samples, EARLY_S, CARRY_FAR_S, CARRY_FAR_SPAN, DETOUR_YD, WALK_YPS };
