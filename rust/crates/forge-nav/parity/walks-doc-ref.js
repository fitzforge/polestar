'use strict';
// Reference walks document for forge walks' parity: walktables.js routerWalks' assembly of a world's
// bands from saved router tables (no routing: each band's asks, its table read by asks.js's pair order,
// walks.js assembleBand, the base walk's zone shares), written by walks.js writeWalks.
// node walks-doc-ref.js <world.json> <asksDir> <tablesDir> <outSimDir> <navFp> [bands=0,10]
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.resolve(__dirname, '../../../..');
const walks = require(`${ROOT}/tools/lib/sim/walks`);
const { open, dangerOf } = require(`${ROOT}/tools/lib/nav/router`);
const { readBin } = require(`${ROOT}/tools/lib/sim/binfile`);
const [worldFile, asksDir, tablesDir, out, navFp, bandsArg] = process.argv.slice(2);
const bands = (bandsArg || '0,10').split(',').map(Number);
const world = JSON.parse(fs.readFileSync(worldFile, 'utf8'));
const P = world.points;
const maps = new Set(Object.keys(JSON.parse(fs.readFileSync(path.join(ROOT, 'addon/Polestar_Nav/PACK.json'), 'utf8')).maps).map(Number));
const router = open(walks.GRID_DIR, { zones: walks.zonesOf(world), fingerprint: false });
const snap = walks.gridSnap(world, router.nav);
const at = walks.sendAt(P, snap, false);
const descent = (a, b) => P[a][5] != null && P[b][5] != null && Math.abs(P[a][5] - P[b][5]) > walks.ONE_WAY_DZ;
const doc = walks.walksDoc(world, { router: 'node', nav: navFp, smooth: router.smooth, style: walks.STYLE, radius: walks.RADIUS, anchorRadius: walks.ANCHOR_RADIUS, bands });
for (const band of bands) {
	const wq = walks.walkQueries(world, { radius: walks.RADIUS, anchorRadius: walks.ANCHOR_RADIUS, style: walks.STYLE, maps, band, snap, camps: true });
	doc.points = wq.points.length;
	const asks = wq.queries.map((q) => ({ q, src: q.src, ids: q.ids }));
	if (band === 0) {
		const back = new Map();
		for (const q of wq.queries) for (const t of q.ids) {
			if (!descent(q.src, t)) continue;
			if (!back.has(t)) back.set(t, []);
			back.get(t).push(q.src);
		}
		for (const [src, ids] of back) asks.push({ q: { map: P[src][0], from: at(src), targets: ids.map(at) }, src, ids });
	}
	for (const a of asks) {
		const to = a.q.to || a.q.targets[0];
		a.danger = band ? dangerOf(band, world.zoneMin, router.zoneAt(a.q.map, a.q.from[0], a.q.from[1]), router.zoneAt(a.q.map, to[0], to[1])) : null;
		a.dkey = a.danger ? JSON.stringify(Object.keys(a.danger).sort((x, y) => x - y).map((z) => [z, a.danger[z]])) : '';
	}
	if (band) {
		const keyed = asks.map((a, i) => [a.dkey, i, a]);
		keyed.sort((x, y) => (x[0] < y[0] ? -1 : x[0] > y[0] ? 1 : x[1] - y[1]));
		asks.splice(0, asks.length, ...keyed.map((x) => x[2]));
	}
	let n = 0;
	for (const a of asks) n += a.ids.length;
	const meta = JSON.parse(fs.readFileSync(path.join(asksDir, `asks-${band}.json`), 'utf8'));
	if (meta.n !== n) throw new Error(`band ${band}: ${n} asks, the saved table ${meta.n}`);
	const raw = fs.readFileSync(path.join(asksDir, `asks-${band}.bin`));
	const src = new Int32Array(n);
	const dst = new Int32Array(n);
	let o = 0;
	for (const a of asks) for (const t of a.ids) {
		src[o] = a.src;
		dst[o] = t;
		if (raw.readInt32LE(4 * o) !== a.src || raw.readInt32LE(4 * (n + o)) !== t) throw new Error(`band ${band}: pair ${o} is not the saved table's`);
		o++;
	}
	const { sections: t } = readBin(path.join(tablesDir, `${meta.key}.bin`));
	const key = new Map();
	for (let i = 0; i < n; i++) key.set(src[i] * P.length + dst[i], i);
	const answer = (i) => (i === undefined ? undefined : [t.y[i], t.c[i], t.xoff[i + 1] > t.xoff[i] ? t.x.subarray(t.xoff[i], t.xoff[i + 1]) : null]);
	const exact = (a, b) => answer(key.get(a * P.length + b));
	const lookup = (a, b) => exact(a, b) || exact(b, a);
	const r = walks.assembleBand(world, wq.queries, band, lookup, exact, doc.unwalkable);
	if (r.missing) throw new Error(`band ${band}: ${r.missing} missing`);
	doc.pairs[band] = Float64Array.from(r.pairs);
	if (band === 0) {
		// walktables.js zoneTable
		const share = walks.zoneSharer(world);
		const base = doc.pairs[0];
		const m = base.length / 5;
		const off = new Uint32Array(m + 1);
		const has = new Uint8Array(m);
		const val = [];
		for (let k = 0; k < m; k++) {
			const v = exact(base[5 * k], base[5 * k + 1]) || lookup(base[5 * k], base[5 * k + 1]);
			const z = share(base[5 * k], v && v[2], base[5 * k + 2]);
			if (z) { has[k] = 1; val.push(...z); }
			off[k + 1] = val.length;
		}
		doc.zones = { off, has, val: Float64Array.from(val) };
	}
	console.log(`band ${band}: ${n} asks, ${r.pairs.length / 5} pairs, ${r.failed} failed`);
}
fs.mkdirSync(out, { recursive: true });
console.log(walks.writeWalks(out, doc, { nw: P.length }));
