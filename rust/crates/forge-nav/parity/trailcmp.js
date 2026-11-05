'use strict';
// Recorded trails against each walking backend: per walk the trail (a /psrec trail export: map x,y and
// world wx,wy, no height), its ends, and each backend's walk between them (grid: router.js on
// data/local/nav4, bit-equal to forge-nav; Leffe: the format-4 Node reader, tolerant, bit-equal to
// forge-nav f4; hybrid: Leffe when his cost <= 1.2x the grid's; in-game engines: batch.lua jsonl
// results). Per backend: found, yards, seconds (cost / 7), points, height range, and how far the
// trail strays from its line (2D: each trail point's distance to the polyline; max and mean).
// POLESTAR_CHECKOUT=<checkout: tools/lib/nav/router.js, data/local/nav4> POLESTAR_JS=<checkout with the format-4
// Node reader> POLESTAR_LEFFE_NAV=<pack> node trailcmp.js <walks.json> <out.json>
//   walks.json: [{ id, title, map, profile, trail: <trail json>, label, from: [wx, wy, z], to: [wx, wy, z],
//                  ingame: { name: <jsonl> } }]
const fs = require('node:fs');
const path = require('node:path');
const { POLESTAR_CHECKOUT: OURS, POLESTAR_JS: NODE4, POLESTAR_LEFFE_NAV: PACK } = process.env;
const [WALKS, OUT] = process.argv.slice(2);
if (!OURS || !NODE4 || !PACK || !WALKS || !OUT) {
	console.error('usage: POLESTAR_CHECKOUT=<dir> POLESTAR_JS=<dir> POLESTAR_LEFFE_NAV=<dir> node trailcmp.js <walks.json> <out.json>');
	process.exit(2);
}
const walks = JSON.parse(fs.readFileSync(WALKS, 'utf8'));
const ours = require(`${OURS}/tools/lib/nav/router`).open(undefined, { fingerprint: false });
const { openNav4 } = require(`${NODE4}/tools/lib/nav/nav4`);
const his = openNav4({ dir: PACK, cacheMB: 2048, validate: 'tolerant' });
const pt = (m, e) => ({ c: m, map: m, x: e[0], y: e[1], wx: e[0], wy: e[1], z: e[2] });
const segDist = (p, a, b) => {
	const dx = b[0] - a[0], dy = b[1] - a[1];
	const L2 = dx * dx + dy * dy;
	const f = L2 > 0 ? Math.max(0, Math.min(1, ((p[0] - a[0]) * dx + (p[1] - a[1]) * dy) / L2)) : 0;
	return Math.hypot(a[0] + dx * f - p[0], a[1] + dy * f - p[1]);
};
const stray = (trail, pts) => {
	let max = 0, sum = 0;
	for (const q of trail) {
		let d = Infinity;
		for (let i = 1; i < pts.length; i++) d = Math.min(d, segDist(q, pts[i - 1], pts[i]));
		if (pts.length === 1) d = Math.hypot(q[0] - pts[0][0], q[1] - pts[0][1]);
		max = Math.max(max, d);
		sum += d;
	}
	return { max, mean: sum / trail.length };
};
const out = [];
for (const w of walks) {
	const tr = JSON.parse(fs.readFileSync(w.trail, 'utf8')).find((t) => t.label === w.label);
	const trail = tr.points.map((p) => [p.wx, p.wy]);
	let walked = 0;
	for (let i = 1; i < trail.length; i++) walked += Math.hypot(trail[i][0] - trail[i - 1][0], trail[i][1] - trail[i - 1][1]);
	const row = { id: w.id, title: w.title, map: w.map, profile: w.profile, from: w.from, to: w.to, trail: { points: trail, seconds: tr.points[tr.points.length - 1].t - tr.points[0].t, yards2d: walked }, backends: {} };
	const sum = (pts, yards, cost) => {
		const zs = pts.map((p) => p[2]).filter((z) => z != null);
		return { ok: true, yards, seconds: cost / 7, points: pts.length, minZ: Math.min(...zs), maxZ: Math.max(...zs), stray: stray(trail, pts), pts };
	};
	const g = ours.route(pt(w.map, w.from), pt(w.map, w.to), { faction: w.profile });
	row.backends.grid = g.ok ? sum(Array.from({ length: g.pts.length / 3 }, (_, i) => [g.pts[3 * i], g.pts[3 * i + 1], g.pts[3 * i + 2]]), g.yards, g.seconds * 7) : { ok: false, reason: g.reason };
	const h = his.route(pt(w.map, w.from), pt(w.map, w.to), { profile: w.profile });
	row.backends.leffe = h.ok ? sum(h.pts, h.yards, h.cost) : { ok: false, reason: h.reason };
	const G = row.backends.grid, L = row.backends.leffe;
	row.backends.hybrid = L.ok && (!G.ok || L.seconds <= 1.2 * G.seconds) ? { ...L, via: 'leffe' } : { ...G, via: 'grid' };
	for (const [name, file] of Object.entries(w.ingame || {})) {
		const r = fs.readFileSync(file, 'utf8').trim().split('\n').map((l) => JSON.parse(l)).find((x) => x.id === w.id);
		row.backends[name] = r && r.ok ? sum(r.points, r.yards, r.cost) : { ok: false, reason: r ? r.reason || r.error : 'not run' };
	}
	out.push(row);
	console.log(`${w.id}: trail ${row.trail.seconds.toFixed(1)} s, ${row.trail.yards2d.toFixed(0)} yd (2D)`);
	for (const [n, s] of Object.entries(row.backends)) {
		console.log(`  ${n.padEnd(7)} ${s.ok ? `${s.yards.toFixed(0)} yd ${s.seconds.toFixed(1)} s ${s.points} pts z ${s.minZ.toFixed(0)}-${s.maxZ.toFixed(0)} trail strays max ${s.stray.max.toFixed(1)} yd, mean ${s.stray.mean.toFixed(1)}${s.via ? ` (${s.via})` : ''}` : `no way (${s.reason})`}`);
	}
}
fs.writeFileSync(OUT, JSON.stringify(out));
