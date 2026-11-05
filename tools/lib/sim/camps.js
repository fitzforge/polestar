'use strict';
// Camps for one objective (sim v2 §1): single linkage on the spawns of every
// source (two spawns within LINK_R chain into one camp) while a camp spans at
// most MAX_SPAN. A source is a kill target, or a dropper at >= 1% or with no
// recorded rate; elites and rares never are (the solo filter decides those
// quests elsewhere). A camp is its geometry and its source set only: drop
// chances belong to the objective (world objCamps).

const LINK_R = 80;
const MAX_SPAN = 350;

// sources: [{ kind, id }]; spawnsOf(kind, id) -> [{ c, region, wx, wy, map }] (deduped);
// levelOf(kind, id) -> level | null; respawnOf(kind, id) -> seconds | null;
// pointAt(kind, id, spawn) -> world point id; addCamp(camp) -> id.
// -> campId[]. camp: { pt, c, region, radius, spawns, levelMin, levelMax, respawn, sources: [{ kind, id, spawns }] }
// pt: the spawn nearest the camp's centre (walkable); radius: yards from it to the farthest member spawn.
function buildCamps({ sources, spawnsOf, levelOf, respawnOf, addCamp, pointAt }) {
	const raw = [];
	for (const src of sources) for (const s of spawnsOf(src.kind, src.id)) raw.push({ src, s });
	const d = (a, b) => Math.hypot(a.s.wx - b.s.wx, a.s.wy - b.s.wy);
	const box = (g) => {
		let x0 = Infinity, x1 = -Infinity, y0 = Infinity, y1 = -Infinity;
		for (const r of g) {
			x0 = Math.min(x0, r.s.wx); x1 = Math.max(x1, r.s.wx);
			y0 = Math.min(y0, r.s.wy); y1 = Math.max(y1, r.s.wy);
		}
		return Math.hypot(x1 - x0, y1 - y0);
	};
	// The bounding box's diagonal bounds the span: the pairwise check only when it is over.
	const fits = (A, B) => box(A.concat(B)) <= MAX_SPAN || A.every((a) => B.every((b) => d(a, b) <= MAX_SPAN));
	const cell = new Map();
	const ck = (r, gx, gy) => `${r.s.region}:${gx}:${gy}`;
	const groupOf = new Map();
	const groups = new Set();
	for (const r of raw) {
		const gx = Math.floor(r.s.wx / LINK_R);
		const gy = Math.floor(r.s.wy / LINK_R);
		const near = [];
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				for (const q of cell.get(ck(r, gx + dx, gy + dy)) || []) {
					const g = groupOf.get(q);
					if (!near.includes(g) && d(q, r) <= LINK_R) near.push(g);
				}
			}
		}
		let mine = [r];
		for (const g of near) {
			if (!fits(g, mine)) continue;
			for (const x of mine) g.push(x);
			if (mine.length > 1) groups.delete(mine);
			mine = g;
		}
		if (mine.length === 1) groups.add(mine);
		for (const x of mine) groupOf.set(x, mine);
		const k = ck(r, gx, gy);
		if (!cell.has(k)) cell.set(k, []);
		cell.get(k).push(r);
	}
	return [...groups].map((g) => {
		const cx = g.reduce((n, r) => n + r.s.wx, 0) / g.length;
		const cy = g.reduce((n, r) => n + r.s.wy, 0) / g.length;
		const at = g.reduce((m, r) => (Math.hypot(r.s.wx - cx, r.s.wy - cy) < Math.hypot(m.s.wx - cx, m.s.wy - cy) ? r : m), g[0]);
		let levelMin = Infinity;
		let levelMax = -Infinity;
		const respawns = [];
		const srcs = [];
		for (const r of g) {
			let ex = srcs.find((x) => x.kind === r.src.kind && x.id === r.src.id);
			if (!ex) {
				ex = { kind: r.src.kind, id: r.src.id, spawns: 0 };
				srcs.push(ex);
				const lvl = levelOf(r.src.kind, r.src.id);
				if (lvl != null) {
					levelMin = Math.min(levelMin, lvl);
					levelMax = Math.max(levelMax, lvl);
				}
			}
			ex.spawns++;
			const rs = respawnOf(r.src.kind, r.src.id);
			if (rs != null) respawns.push(rs);
		}
		respawns.sort((a, b) => a - b);
		// The camp's extent: yards from pt to the farthest member spawn.
		const radius = Math.round(g.reduce((m, r) => Math.max(m, d(r, at)), 0) * 10) / 10;
		return addCamp({
			pt: pointAt(at.src.kind, at.src.id, at.s), c: at.s.c, region: at.s.region, radius, spawns: g.length,
			levelMin: Number.isFinite(levelMin) ? levelMin : null,
			levelMax: Number.isFinite(levelMax) ? levelMax : null,
			respawn: respawns.length ? respawns[Math.floor(respawns.length / 2)] : null,
			sources: srcs,
		});
	});
}

module.exports = { buildCamps, LINK_R, MAX_SPAN };
