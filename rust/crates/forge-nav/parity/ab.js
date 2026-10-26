'use strict';
// A/B of the walking maps on acceptance walks: our walking grid (this checkout's router.js on data/local/nav4: path.js
// route, the drawn line the pipeline's walks are priced on) against Leffe's navigation maps (the format-4 Node reader,
// bit-identical to the Rust port), each walk's expectations judged by nav eval's compare.js.
// POLESTAR_JS=<checkout with the format-4 Node reader> POLESTAR_V1=<v1 checkout, built data/forever> POLESTAR_LEFFE_NAV=<pack>
//   node ab.js <out.json> <corpus.json>... [--only id,id] [--ours-only | --his-only]
//   corpus: acceptance.json-shaped files ({ routes }); entries { ref: id } are skipped (the base corpus holds them).
const fs = require('node:fs');
const path = require('node:path');
const { POLESTAR_JS: NODE4, POLESTAR_V1: V1, POLESTAR_LEFFE_NAV: PACK } = process.env;
const OURS = path.resolve(__dirname, '../../../..');
if (!NODE4 || !V1 || !PACK || process.argv.length < 4) {
	console.error('usage: POLESTAR_JS=<dir> POLESTAR_V1=<dir> POLESTAR_LEFFE_NAV=<dir> node ab.js <out.json> <corpus.json>... [--only id,id] [--ours-only | --his-only]');
	process.exit(2);
}
const args = process.argv.slice(2);
const flag = (k) => {
	const i = args.indexOf(k);
	if (i < 0) return null;
	const v = args[i + 1];
	args.splice(i, 2);
	return v;
};
const only = flag('--only');
const out = args[0];
const files = args.slice(1);
const { Geo } = require(`${NODE4}/tools/lib/planner/geo`);
const { resolveRoutes } = require(`${NODE4}/tools/lib/nav/eval/run`);
const { evaluateExpectations } = require(`${NODE4}/tools/lib/nav/eval/compare`);
const { metrics } = require(`${NODE4}/tools/lib/nav/eval/metrics`);
const DATA = path.join(V1, 'data/forever');
const geo = new Geo(JSON.parse(fs.readFileSync(`${DATA}/map-frames.json`, 'utf8')), JSON.parse(fs.readFileSync(`${DATA}/zones.json`, 'utf8')));
let routes = [];
for (const f of files) {
	const doc = JSON.parse(fs.readFileSync(f, 'utf8'));
	for (const r of doc.routes || doc) {
		if (r.ref) continue;
		if (only && !only.split(',').includes(r.id)) continue;
		try {
			routes.push(...resolveRoutes([{ expect: [{ type: 'ok' }], ...r }], geo).map((x) => ({ ...x, corpus: path.basename(f) })));
		} catch (e) {
			console.error(`skip ${r.id}: ${e.message}`);
		}
	}
}
routes = routes.filter((r) => r.map === 0 || r.map === 1);
console.error(`${routes.length} walks`);
const ours = require(`${OURS}/tools/lib/nav/router`).open(undefined, { fingerprint: false });
const { openNav4 } = require(`${NODE4}/tools/lib/nav/nav4`);
const his = openNav4({ dir: PACK, cacheMB: 3072, validate: 'tolerant' });
const pt = (r, e) => ({ c: r.map, map: r.map, x: e[0], y: e[1], wx: e[0], wy: e[1], z: e[2] });
const rows = [];
for (const r of routes) {
	const row = { id: r.id, corpus: r.corpus, map: r.map, profile: r.profile, tags: r.tags || [], outcome: r.outcome, from: r.from, to: r.to };
	for (const [name, run] of [
		['ours', () => {
			const x = ours.route(pt(r, r.from), pt(r, r.to), { faction: r.profile });
			return x.ok ? { ok: true, pts: Array.from({ length: x.pts.length / 3 }, (_, i) => [x.pts[3 * i], x.pts[3 * i + 1], x.pts[3 * i + 2]]), yards: x.yards, cost: x.seconds * 7, hubs: x.hubs, falls: x.falls } : { ok: false, reason: x.reason };
		}],
		['his', () => {
			const x = his.route(pt(r, r.from), pt(r, r.to), { profile: r.profile });
			return x.ok ? { ok: true, pts: x.pts, yards: x.yards, cost: x.cost, jumps: x.jumps, events: x.events } : { ok: false, reason: x.reason };
		}],
	]) {
		const t0 = performance.now();
		let res;
		try {
			res = run();
		} catch (e) {
			res = { ok: false, reason: `error: ${e.message}` };
		}
		res.ms = Math.round(performance.now() - t0);
		const route = { ...r, result: res, metrics: res.ok ? metrics({ ...res, map: r.map }) : null };
		row[name] = { ok: res.ok, reason: res.reason || null, yards: res.ok ? res.yards : null, cost: res.ok ? res.cost : null, ms: res.ms, points: res.ok ? res.pts.length : 0, maxZ: res.ok ? Math.max(...res.pts.map((p) => (p[2] == null ? -Infinity : p[2]))) : null, minZ: res.ok ? Math.min(...res.pts.map((p) => (p[2] == null ? Infinity : p[2]))) : null, events: res.events ? res.events.map((e) => e.kind || e.type || e) : undefined, checks: evaluateExpectations(route), pts: res.ok ? res.pts : null };
	}
	rows.push(row);
	const p = (s) => (s.ok ? `${Math.round(s.yards)} yd ${s.checks.every((c) => c.pass !== false) ? 'pass' : 'FAIL'}` : `none (${s.reason})`);
	console.error(`${r.id}: ours ${p(row.ours)} ${row.ours.ms} ms | his ${p(row.his)} ${row.his.ms} ms`);
}
fs.writeFileSync(out, JSON.stringify({ pack: PACK, rows }));
