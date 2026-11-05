'use strict';
// Regenerates rust/tests/golden/{nav-walks,nav-legs,nav-store} (their README.md) on the synthetic grid of
// rust/tests/golden/nav-grid: a synthetic sim world per faction, the JS walks (walktables.js routerWalks
// on the js backend: router.js distanceRows over path.js), each band's asks and router table as
// parity/asks.js dumped them, the legs of parity/legs-ref.js, the walks files and walklookup.js samples of
// parity/lookup-sample.js, and a short synthetic route.
//
//   node regen.js <js root> <golden dir (rust/tests/golden)>
//
// <js root>: the scratch repository copy nav-grid/regen.js built its grid in (data/local/nav4, its
// data/ and layers); this writes its addon/Polestar_Nav/PACK.json, data/sim and cas/ too.
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const [jsRoot, goldenArg] = process.argv.slice(2);
if (!jsRoot || !goldenArg) throw new Error('usage: node regen.js <js root> <golden dir>');
const ROOT = path.resolve(jsRoot);
const GOLDEN = path.resolve(goldenArg);
process.env.POLESTAR_GRID = path.join(ROOT, 'data', 'local', 'nav4');
process.env.POLESTAR_CAS = path.join(ROOT, 'cas');
const walks = require(path.join(ROOT, 'tools/lib/sim/walks'));
const { routerWalks, bandKey } = require(path.join(ROOT, 'tools/lib/sim/walktables'));
const router = require(path.join(ROOT, 'tools/lib/nav/router'));
const { buildLookup } = require(path.join(ROOT, 'tools/lib/sim/walklookup'));
const { edgeKey } = require(path.join(ROOT, 'tools/lib/nav/path'));
const { ADT } = require(path.join(ROOT, 'tools/lib/nav/grid/format'));

const BANDS = [10, 20];
const SIM = path.join(ROOT, 'data', 'sim');
const OUT = { walks: path.join(GOLDEN, 'nav-walks'), legs: path.join(GOLDEN, 'nav-legs'), store: path.join(GOLDEN, 'nav-store') };

// --- The world (nav-grid/regen.js's geography: E east, S south; wx = -S, wy = -E). ---
const zoneOfArea = { 9001: 1901, 9011: 1901, 9002: 1902, 9021: 1902, 9003: 1903, 9004: 1904 };
function areaOf(E, S) {
	if (E < 330) return E < 160 && S < 260 ? 9011 : 9001;
	if (E < 600) return S > 700 ? 9021 : 9002;
	return S > 760 ? 9004 : 9003;
}
// Places [E, S, z (null: none), label]: open ground in every zone, the mesa top and its foot (the lift),
// the house's floors, the lake (swim), the WMO pool, the doorway, the maze, the model plateau and its
// ramp, the enclosure (another region), the hole, the cliff plateau and its ramp, the bridge, near the
// hubs, off the grid.
const PLACES = [
	[40, 40, 0, 'west field'], [120, 60, 0, 'mill'], [90, 130, null, 'keep (Alliance hub)'], [250, 250, 0, 'meadow'],
	[130, 375, 60, 'mesa top'], [215, 375, 0, 'mesa foot'], [205, 380, null, 'elevator'],
	[320, 100, 0.2, 'house hall'], [400, 150, 6, 'house upper floor'], [420, 120, 14, 'house roof'], [310, 130, null, 'house door'],
	[480, 40, 0, 'ridge north'], [450, 300, 0, 'ridge middle'], [560, 480, 0, 'ridge south'],
	[760, 280, -1.5, 'lake middle'], [690, 230, null, 'lake shore'], [920, 110, 5, 'pool'], [835, 455, 0, 'doorway east'], [828, 455, 0, 'doorway west'],
	[640, 300, 0, 'road south'], [700, 110, 0, 'road east'], [1000, 100, 0, 'road end'], [900, 470, null, 'marsh camp (Horde hub)'],
	[260, 600, 0, 'maze west'], [430, 860, 0, 'maze east'], [100, 633, 20, 'plateau top'], [210, 633, 5, 'plateau ramp'], [300, 640, 0, 'plateau foot'],
	[110, 983, 0, 'enclosure'], [415, 948, null, 'hole edge'],
	[960, 960, 30, 'cliff top'], [800, 910, 12, 'cliff ramp'], [840, 980, 0, 'cliff foot'], [820, 940, 12, 'bridge'], [700, 1000, 0, 'south moor'],
	[1030, 600, 0, 'east edge'], [600, 1040, 0, 'south edge'], [1200, 300, 0, 'off the grid'],
];
function world(faction) {
	const points = PLACES.map(([E, S, z]) => [0, 1, -S, -E, zoneOfArea[areaOf(E, S)], z]);
	// One point on continent 1 (no walking maps there): never walked.
	points.push([1, 2, 100, 100, 0, null]);
	const n = points.length;
	const quests = [];
	for (let i = 0; i + 2 < n; i += 3) quests.push({ id: 900 + i, giver: i, ender: i + 1, tasks: [{ pt: i + 2 }], objs: [] });
	// The danger grid of region 1 (200 yd cells): the zones the chunks' areas give, at each cell's centre.
	const cell = 200;
	const gx0 = -6;
	const gy0 = -6;
	const nx = 6;
	const ny = 6;
	const z = [];
	for (let gx = 0; gx < nx; gx++) for (let gy = 0; gy < ny; gy++) z.push(zoneOfArea[areaOf(-((gy + gy0) * cell + cell / 2), -((gx + gx0) * cell + cell / 2))]);
	return {
		faction, dataHash: `synthetic-golden-${faction.toLowerCase()}`, points, quests, packages: [],
		inns: [{ pt: 0 }, { pt: 21 }], nodes: [{ pt: 6 }], starts: {}, services: {}, camps: {},
		zoneMin: { 1901: 1, 1902: 25, 1903: 8, 1904: 15 },
		danger: [{ region: 1, gx0, gy0, nx, ny, cell, z }],
	};
}

const write = (file, data) => {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, data);
};

// --- asks.js: each band's asks (pair order), the danger tables, the ends, the band key. ---
function asksOf(w, r, band) {
	const P = w.points;
	const snap = walks.gridSnap(w, r.nav);
	const at = walks.sendAt(P, snap, false);
	const full = walks.sendAt(P, snap, true);
	const key = walks.placeKeys(P);
	const maps = new Set([0]);
	const descent = (a, b) => P[a][5] != null && P[b][5] != null && Math.abs(P[a][5] - P[b][5]) > walks.ONE_WAY_DZ;
	const wq = walks.walkQueries(w, { radius: walks.RADIUS, anchorRadius: walks.ANCHOR_RADIUS, style: walks.STYLE, maps, band, snap, camps: true });
	const asks = wq.queries.map((q) => ({ q, src: q.src, ids: q.ids }));
	if (band === 0) {
		const back = new Map();
		for (const q of wq.queries) for (const t of q.ids) {
			if (!descent(q.src, t)) continue;
			if (!back.has(t)) back.set(t, []);
			back.get(t).push(q.src);
		}
		for (const [src, ids] of back) asks.push({ q: { map: P[src][0], from: at(src), targets: ids.map(at), src, ids }, src, ids });
	}
	for (const a of asks) {
		const q = a.q;
		const to = q.to || q.targets[0];
		a.danger = band ? router.dangerOf(band, w.zoneMin, r.zoneAt(q.map, q.from[0], q.from[1]), r.zoneAt(q.map, to[0], to[1])) : null;
		a.dkey = a.danger ? JSON.stringify(Object.keys(a.danger).sort((x, y) => x - y).map((zz) => [zz, a.danger[zz]])) : '';
	}
	if (band) {
		const keyed = asks.map((a, i) => [a.dkey, i, a]);
		keyed.sort((x, y) => (x[0] < y[0] ? -1 : x[0] > y[0] ? 1 : x[1] - y[1]));
		asks.splice(0, asks.length, ...keyed.map((x) => x[2]));
	}
	let n = 0;
	for (const a of asks) n += a.ids.length;
	const src = new Int32Array(n);
	const dst = new Int32Array(n);
	const dk = new Int32Array(n);
	const dangers = [];
	const dIndex = new Map();
	let o = 0;
	for (const a of asks) {
		if (!dIndex.has(a.dkey)) {
			dIndex.set(a.dkey, dangers.length);
			dangers.push(a.danger);
		}
		for (const t of a.ids) {
			src[o] = a.src;
			dst[o] = t;
			dk[o] = dIndex.get(a.dkey);
			o++;
		}
	}
	const tkey = bandKey({ router: r, faction: w.faction, style: walks.STYLE, band, zoneMin: w.zoneMin, asks, key, at, full });
	const ends = P.map((p, i) => {
		const a = at(i);
		const f = full(i);
		return [p[0], a[0], a[1], a[2], f[2], snap(i) ? 1 : 0];
	});
	return { n, src, dst, dk, dangers, tkey, ends, bin: Buffer.concat([Buffer.from(src.buffer), Buffer.from(dst.buffer), Buffer.from(dk.buffer)]) };
}

// --- legs-ref.js: snapped ends, start and goal legs, base and band-10 profiles. ---
function legsRef(w, r, ends, danger) {
	const nav = r.nav;
	const profiles = { base: r.profile({ faction: w.faction }), band10: r.profile({ faction: w.faction, danger }) };
	const cellOf = router.cellKey;
	const flat = (m) => {
		const o = [];
		for (const [k, y] of m) o.push(k, y);
		return o;
	};
	const g = (c) => nav.graph(c);
	function startLegs(A, p) {
		const ta = nav.tile(A.c, A.tile.col, A.tile.row);
		if (!ta) return null;
		const fw = nav.tileTree(ta, A.entry, A.cell.j * 256 + A.cell.i, p, false, 'fwdScratch');
		const gr = g(A.c);
		const ti = gr ? gr.at.get(A.tile.col * 65536 + A.tile.row) : undefined;
		const node = [];
		const cost = [];
		const yards = [];
		const cells = [];
		if (ti !== undefined) {
			const info = gr.tiles[ti];
			for (let x = info.nodeBase; x < info.nodeBase + info.nodeCount; x++) {
				const e = gr.nodeEntry[x];
				if (fw.stamp[e] !== fw.gen) continue;
				node.push(x);
				cost.push(fw.dist[e]);
				yards.push(fw.yd[e]);
				cells.push(flat(nav.treeCells(ta, fw, e, false, cellOf, new Map())));
			}
		}
		return { node, cost, yards, cells };
	}
	const snapJson = (s) => s && { wx: s.wx, wy: s.wy, z: s.z, col: s.tile.col, row: s.tile.row, i: s.cell.i, j: s.cell.j, entry: s.entry, region: s.region, flags: s.flags };
	const rows = [];
	ends.forEach((e, i) => {
		if (e[0] !== 0) return;
		// At the points' own heights and at none (snap's own choice).
		for (const z of e[3] == null ? [null] : [e[3], null]) {
			const q = { c: e[0], wx: e[1], wy: e[2], z, under: true, stand: true };
			const A = nav.snap(q);
			const row = { pt: i, q: [e[0], e[1], e[2], z], snap: snapJson(A) };
			if (A) {
				for (const [name, p] of Object.entries(profiles)) {
					let S = startLegs(A, p);
					let settled = -1;
					if (S && !S.node.length) {
						nav.settleCandidates(A, p, false).some((E, k) => {
							const L2 = startLegs(E, p);
							if (L2 && L2.node.length) {
								S = L2;
								settled = k;
								return true;
							}
							return false;
						});
					}
					let L = nav.goalLegs(A.c, g(A.c), A, p, cellOf);
					let gs = -1;
					if (!L.nodes.length) {
						nav.settleCandidates(A, p, true).some((E, k) => {
							const L2 = nav.goalLegs(A.c, g(A.c), E, p, cellOf);
							if (L2.nodes.length) {
								L = L2;
								gs = k;
								return true;
							}
							return false;
						});
					}
					row[name] = { start: S && { settled, ...S }, goal: { settled: gs, node: Array.from(L.nodes), cost: Array.from(L.sec), yards: Array.from(L.yd), cells: L.cells.map((c) => Array.from(c)) } };
				}
			}
			rows.push(row);
		}
	});
	const az = router.areaZoneTable();
	return {
		faction: w.faction, groundKey: profiles.base.groundKey, edgeKey: edgeKey(0, profiles.base),
		danger, areaKey: profiles.band10.area.key, zonesTag: az.tag, areaZone: az.zones, rows,
	};
}

// --- lookup-sample.js: walklookup's answers on a sample of pairs (n x 32 bytes). ---
function lookupSample(doc, n, seed0) {
	let seed = seed0;
	const rnd = () => ((seed = (Math.imul(seed, 1103515245) + 12345) >>> 0) / 4294967296);
	const NW = doc.nw;
	const L = buildLookup(doc, NW);
	const bands = L.bands;
	const pickIn = (band) => {
		const t = doc.lookup[band];
		const k = Math.floor(rnd() * t.nbr.length);
		let lo = 0;
		let hi = NW;
		while (hi - lo > 1) {
			const m = (lo + hi) >> 1;
			if (t.offsets[m] <= k) lo = m;
			else hi = m;
		}
		return [lo, t.nbr[k]];
	};
	const buf = Buffer.alloc(4 + n * 32);
	buf.writeInt32LE(n, 0);
	const uw = doc.unwalkable;
	for (let i = 0; i < n; i++) {
		const r = rnd();
		let a;
		let b;
		let band = bands[Math.floor(rnd() * bands.length)];
		if (r < 0.45) [a, b] = pickIn(0);
		else if (r < 0.65) {
			const bb = bands[1 + Math.floor(rnd() * (bands.length - 1))];
			[a, b] = pickIn(bb);
			band = rnd() < 0.8 ? bb : band;
		} else if (r < 0.75 && uw.length) {
			const k = 2 * Math.floor(rnd() * (uw.length / 2));
			[a, b] = rnd() < 0.5 ? [uw[k], uw[k + 1]] : [uw[k + 1], uw[k]];
		} else {
			a = Math.floor(rnd() * NW);
			b = Math.floor(rnd() * NW);
		}
		if (rnd() < 0.1) [a, b] = [b, a];
		const yd = L.yd(a, b, band);
		const g = L.get(a, b, band);
		const o = 4 + i * 32;
		buf.writeInt32LE(a, o);
		buf.writeInt32LE(b, o + 4);
		buf.writeInt32LE(band, o + 8);
		buf.writeFloatLE(yd, o + 12);
		buf.writeFloatLE(g ? g[0] : -1, o + 16);
		buf.writeFloatLE(g ? g[1] : -1, o + 20);
		buf.writeInt32LE(g ? 1 : 0, o + 24);
		buf.writeInt32LE(L.has(a, b, band) ? 1 : 0, o + 28);
	}
	return buf;
}

for (const d of [...Object.values(OUT), SIM, process.env.POLESTAR_CAS, path.join(ROOT, 'walks-out')]) {
	if (d !== OUT.walks && d !== OUT.legs && d !== OUT.store) fs.rmSync(d, { recursive: true, force: true });
	else for (const f of fs.existsSync(d) ? fs.readdirSync(d) : []) if (!['regen.js', 'README.md', '.gitattributes'].includes(f)) fs.rmSync(path.join(d, f), { recursive: true, force: true });
}
write(path.join(ROOT, 'addon', 'Polestar_Nav', 'PACK.json'), `${JSON.stringify({ synthetic: true, maps: { 0: {} } })}\n`);
for (const faction of ['Horde', 'Alliance']) {
	const lower = faction.toLowerCase();
	const w = world(faction);
	write(path.join(OUT.walks, `world-${lower}.json`), `${JSON.stringify(w)}\n`);
	const got = routerWalks(w, { simDir: SIM, backend: 'js', bands: BANDS, log: console.log });
	// Written outside data/sim: writeWalks moves a data/sim file into the shared store.
	const walksDir = path.join(ROOT, 'walks-out');
	walks.writeWalks(walksDir, got.doc, { nw: w.points.length });
	write(path.join(OUT.store, `walks-${lower}.bin`), fs.readFileSync(walks.walksFile(walksDir, faction)));
	const doc = walks.readWalks(walksDir, faction);
	write(path.join(OUT.store, `lookup-${lower}.bin`), lookupSample(doc, 4000, 1));
	console.log(`${faction}: ${got.routed} pairs routed, ${got.failed} not walkable; tables ${got.tables.map((t) => `${t.band}:${t.key}`).join(' ')}`);
	if (faction !== 'Horde') continue;
	// The Horde asks, tables and ends (asks.js), on the router routerWalks asked.
	const r = router.open(walks.GRID_DIR, { zones: walks.zonesOf(w), backend: 'js' });
	let ends = null;
	let band10 = null;
	for (const band of [0, 10]) {
		const a = asksOf(w, r, band);
		const t = got.tables.find((x) => x.band === band);
		if (!t || t.key !== a.tkey) throw new Error(`band ${band}: asks key ${a.tkey}, routerWalks' table ${t && t.key}`);
		write(path.join(OUT.walks, 'horde', `asks-${band}.bin`), a.bin);
		write(path.join(OUT.walks, 'horde', `asks-${band}.json`), JSON.stringify({ band, n: a.n, key: a.tkey, dangers: a.dangers }));
		write(path.join(OUT.walks, 'walktable', `${a.tkey}.bin`), fs.readFileSync(path.join(process.env.POLESTAR_CAS, 'walktable', `${a.tkey}.bin`)));
		ends = a.ends;
		if (band === 10) band10 = a;
	}
	const index = JSON.parse(fs.readFileSync(path.join(walks.GRID_DIR, 'index.json'), 'utf8'));
	write(path.join(OUT.walks, 'horde', 'ends.json'), JSON.stringify({ faction, dataHash: w.dataHash, gridBuiltAt: index.builtAt, ends }));
	const base = r.profile({ faction });
	const az = router.areaZoneTable();
	write(path.join(OUT.walks, 'areazones.json'), JSON.stringify({ groundKey: base.groundKey, tag: az.tag, zones: az.zones }));
	// The band-10 danger table with the most zones, for the legs.
	const danger = band10.dangers.filter(Boolean).sort((x, y) => Object.keys(y).length - Object.keys(x).length)[0];
	write(path.join(OUT.legs, 'legs-horde.json.gz'), zlib.gzipSync(JSON.stringify(legsRef(w, r, ends, danger)), { level: 9 }));
	// A route: walks between consecutive places, levels 8 to 22 (route_walks.rs reads `walk` actions).
	const order = [0, 1, 3, 5, 6, 4, 7, 8, 11, 12, 19, 14, 15, 20, 21, 22, 17, 18, 23, 24, 27, 26, 25, 32, 31, 30, 34, 13, 2, 9];
	const actions = [{ act: 'start', pt: order[0], level: 8 }];
	for (let i = 1; i < order.length; i++) actions.push({ act: 'walk', from: order[i - 1], pt: order[i], level: 8 + Math.floor((14 * i) / order.length) });
	write(path.join(OUT.walks, 'route-horde.json'), `${JSON.stringify({ synthetic: true, faction, actions })}\n`);
	console.log(`legs: ${PLACES.length} places; band-10 danger ${JSON.stringify(danger)}; ADT ${ADT}`);
}
