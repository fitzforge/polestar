'use strict';
// Areas: the places a route chooses between. Every point the simulator stops
// at (quest givers and enders with their alternatives, task and accept
// points, objective camps, service NPCs, inns, transport nodes) belongs to
// exactly one area of its region.
//
// Greedy and deterministic, in three steps:
//   1. Hub seeds. A world hub qualifies with at least 3 givers, or when it
//      owns a flight master or inn (the nearest of the hubs that list it).
//      Qualifying seeds closer than hubSpan/2 merge into the one with more
//      givers (lower hub index on a tie), so a town is one hub area.
//   2. Towns first. Every member within hubSpan/2 of a hub seed on its region
//      joins the nearest such hub (lower hub index on a tie). Any two members
//      of a hub area are then within hubSpan of each other.
//   3. The rest, in ascending point index, by complete linkage: a point joins
//      the area (of its region) with the nearest member among those whose
//      every member is within span of it (lower area id on a tie), or starts
//      a new area.
// Distances are straight lines in world yards: walk costs are not known for
// every pair (camps are walked later), so the areas do not follow walls.
// Ids: hub areas in hub order (hubs that got no member are dropped), then
// the other areas in creation order. An area's pt is the member nearest its
// centroid.
//
// buildAreas(world, { span, hubSpan }) -> {
//   areas: [{ id, pt, c, region, members: [pt ascending], hub,
//             kinds: { giver, ender, camp, service, node, task } (members of each kind) }],
//   pointArea: Int32Array(points.length), -1 = no area }

const CELL = 50;
const KIND = { giver: 1, ender: 2, camp: 4, service: 8, node: 16, task: 32 };
const HUB_GIVERS = 3;

function buildAreas(world, { span = 250, hubSpan = 400 } = {}) {
	const P = world.points;
	const hubs = world.hubs || [];
	const nodes = world.nodes || [];
	const inns = world.inns || [];
	const kindOf = new Uint8Array(P.length);
	const mark = (pt, k) => {
		if (pt != null && pt >= 0) kindOf[pt] |= k;
	};
	for (const q of world.quests) {
		mark(q.giver, KIND.giver);
		mark(q.ender, KIND.ender);
		for (const pt of Object.values(q.gAlt || {})) mark(pt, KIND.giver);
		for (const pt of Object.values(q.eAlt || {})) mark(pt, KIND.ender);
		for (const t of q.tasks || []) mark(t.pt, KIND.task);
		if (q.accept) mark(q.accept.pt, KIND.task);
		for (const o of q.objs || []) for (const c of o.camps) mark(world.camps[c].pt, KIND.camp);
	}
	for (const pt of Object.keys(world.serviceSet || {})) mark(Number(pt), KIND.service);
	for (const inn of inns) mark(inn.pt, KIND.service);
	for (const n of nodes) mark(n.pt, KIND.node);
	const dist = (a, b) => Math.hypot(P[a][2] - P[b][2], P[a][3] - P[b][3]);

	// 1. Hub seeds.
	const givers = hubs.map(() => new Set());
	for (const q of world.quests) if (q.hubGiver != null && q.hubGiver >= 0 && givers[q.hubGiver]) givers[q.hubGiver].add(q.giver);
	const owns = new Uint8Array(hubs.length);
	const own = (field, idx, pt) => {
		let best = -1;
		let bestD = Infinity;
		hubs.forEach((h, i) => {
			if (h[field] !== idx || P[h.pt][1] !== P[pt][1]) return;
			const d = dist(h.pt, pt);
			if (d < bestD) [best, bestD] = [i, d];
		});
		if (best >= 0) owns[best] = 1;
	};
	nodes.forEach((n, i) => {
		if (n.kind === 'fp') own('fp', i, n.pt);
	});
	inns.forEach((n, i) => own('inn', i, n.pt));
	const qualifying = [];
	hubs.forEach((h, i) => {
		if (givers[i].size >= HUB_GIVERS || owns[i]) qualifying.push(i);
	});
	const kept = [];
	for (const i of qualifying.slice().sort((a, b) => givers[b].size - givers[a].size || a - b)) {
		const pt = hubs[i].pt;
		if (!kept.some((k) => P[hubs[k].pt][1] === P[pt][1] && dist(hubs[k].pt, pt) < hubSpan / 2)) kept.push(i);
	}
	kept.sort((a, b) => a - b);

	// 2. Towns first. groups[g] = { region, hub, members }; hub groups are 0..kept.length-1.
	const groups = kept.map((i) => ({ region: P[hubs[i].pt][1], hub: true, members: [] }));
	const owner = new Int32Array(P.length).fill(-1);
	for (let pt = 0; pt < P.length; pt++) {
		if (!kindOf[pt]) continue;
		let best = -1;
		let bestD = Infinity;
		kept.forEach((h, g) => {
			const s = hubs[h].pt;
			if (P[s][1] !== P[pt][1]) return;
			const d = dist(s, pt);
			if (d <= hubSpan / 2 && d < bestD) [best, bestD] = [g, d];
		});
		if (best < 0) continue;
		groups[best].members.push(pt);
		owner[pt] = best;
	}

	// 3. The rest: complete linkage within span. The grid holds members of
	// non-hub groups by 50 yd cell.
	const grid = new Map();
	const cellKey = (region, gx, gy) => `${region}:${gx}:${gy}`;
	const reach = Math.ceil(span / CELL);
	for (let pt = 0; pt < P.length; pt++) {
		if (!kindOf[pt] || owner[pt] >= 0) continue;
		const [, region, x, y] = P[pt];
		const gx = Math.floor(x / CELL);
		const gy = Math.floor(y / CELL);
		const nearest = new Map(); // group -> nearest member distance
		for (let dx = -reach; dx <= reach; dx++) {
			for (let dy = -reach; dy <= reach; dy++) {
				const list = grid.get(cellKey(region, gx + dx, gy + dy));
				if (!list) continue;
				for (const m of list) {
					const d = dist(m, pt);
					if (d > span) continue;
					const g = owner[m];
					if (!nearest.has(g) || d < nearest.get(g)) nearest.set(g, d);
				}
			}
		}
		let best = -1;
		let bestD = Infinity;
		for (const [g, d] of nearest) {
			if (d > bestD || (d === bestD && g > best)) continue;
			if (groups[g].members.every((m) => dist(m, pt) <= span)) [best, bestD] = [g, d];
		}
		if (best < 0) {
			best = groups.length;
			groups.push({ region, hub: false, members: [] });
		}
		groups[best].members.push(pt);
		owner[pt] = best;
		const k = cellKey(region, gx, gy);
		if (!grid.has(k)) grid.set(k, []);
		grid.get(k).push(pt);
	}

	const areas = [];
	const idOf = new Int32Array(groups.length).fill(-1);
	groups.forEach((gr, g) => {
		const ms = gr.members;
		if (!ms.length) return;
		let cx = 0;
		let cy = 0;
		for (const m of ms) {
			cx += P[m][2];
			cy += P[m][3];
		}
		cx /= ms.length;
		cy /= ms.length;
		let pt = ms[0];
		let pd = Infinity;
		const kinds = { giver: 0, ender: 0, camp: 0, service: 0, node: 0, task: 0 };
		for (const m of ms) {
			const d = Math.hypot(P[m][2] - cx, P[m][3] - cy);
			if (d < pd) [pt, pd] = [m, d];
			for (const [k, bit] of Object.entries(KIND)) if (kindOf[m] & bit) kinds[k]++;
		}
		idOf[g] = areas.length;
		areas.push({ id: areas.length, pt, c: P[pt][0], region: gr.region, members: ms, hub: gr.hub, kinds });
	});
	const pointArea = new Int32Array(P.length).fill(-1);
	for (let pt = 0; pt < P.length; pt++) if (owner[pt] >= 0) pointArea[pt] = idOf[owner[pt]];
	return { areas, pointArea };
}

module.exports = { buildAreas };
