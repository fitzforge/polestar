'use strict';
// Reference legs for forge-nav's leg parity (tests/legs_parity.rs): for a sample of a world's walk
// points (as walktables.js sends them, router.js snaps them: under, stand), the snapped end, its start
// legs (cch.js startOf: forward tile search, seeds, cells, pocket settle) and goal legs (cch.js
// distanceRows goalOf: path.js goalLegs, settle), for the faction's base profile and one band-10
// danger profile. Also the router's tags and the AreaTable zone map the Rust router reads.
// node legs-ref.js <world.json> <asksDir (asks.js out)> <out.json> [n=400] [seed=3]
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.resolve(__dirname, '../../../..');
const walks = require(`${ROOT}/tools/lib/sim/walks`);
const router = require(`${ROOT}/tools/lib/nav/router`);
const [worldFile, asksDir, out, nArg, seedArg] = process.argv.slice(2);
const n = Number(nArg || 400);
let seed = Number(seedArg || 3);
const rnd = () => ((seed = (Math.imul(seed, 1103515245) + 12345) >>> 0) / 4294967296);
const world = JSON.parse(fs.readFileSync(worldFile, 'utf8'));
const ends = JSON.parse(fs.readFileSync(path.join(asksDir, 'ends.json'), 'utf8')).ends;
const band10 = JSON.parse(fs.readFileSync(path.join(asksDir, 'asks-10.json'), 'utf8'));
const r = router.open(walks.GRID_DIR, { zones: walks.zonesOf(world), fingerprint: false });
const nav = r.nav;
const danger = band10.dangers.find((d) => d && Object.keys(d).length > 3);
const profiles = { base: r.profile({ faction: world.faction }), band10: r.profile({ faction: world.faction, danger }) };
const cellOf = router.cellKey;
const flat = (m) => { const o = []; for (const [k, y] of m) o.push(k, y); return o; };
const g = (c) => nav.graph(c);
function startLegs(A, p) {
	const ta = nav.tile(A.c, A.tile.col, A.tile.row);
	if (!ta) return null;
	const fw = nav.tileTree(ta, A.entry, A.cell.j * 256 + A.cell.i, p, false, 'fwdScratch');
	const gr = g(A.c);
	const ti = gr ? gr.at.get(A.tile.col * 65536 + A.tile.row) : undefined;
	const node = [], cost = [], yards = [], cells = [];
	if (ti !== undefined) {
		const info = gr.tiles[ti];
		for (let x = info.nodeBase; x < info.nodeBase + info.nodeCount; x++) {
			const e = gr.nodeEntry[x];
			if (fw.stamp[e] !== fw.gen) continue;
			node.push(x); cost.push(fw.dist[e]); yards.push(fw.yd[e]);
			cells.push(flat(nav.treeCells(ta, fw, e, false, cellOf, new Map())));
		}
	}
	return { node, cost, yards, cells };
}
const snapJson = (s) => s && { wx: s.wx, wy: s.wy, z: s.z, col: s.tile.col, row: s.tile.row, i: s.cell.i, j: s.cell.j, entry: s.entry, region: s.region, flags: s.flags };
// The walk points that were sent to the router (snapped by walks.gridSnap) on the big continents.
const cand = [];
ends.forEach((e, i) => { if (e[5] && (e[0] === 0 || e[0] === 1)) cand.push(i); });
const picks = [];
const seen = new Set();
while (picks.length < n && seen.size < cand.length) {
	const i = cand[Math.floor(rnd() * cand.length)];
	if (seen.has(i)) continue;
	seen.add(i);
	picks.push(i);
}
const t0 = Date.now();
const rows = [];
let ms = { snap: 0, start: 0, goal: 0 };
for (const i of picks) {
	const e = ends[i];
	const q = { c: e[0], wx: e[1], wy: e[2], z: e[3], under: true, stand: true };
	let t = Date.now();
	const A = nav.snap(q);
	ms.snap += Date.now() - t;
	const row = { pt: i, q: [e[0], e[1], e[2], e[3]], snap: snapJson(A) };
	if (A) {
		for (const [name, p] of Object.entries(profiles)) {
			t = Date.now();
			let S = startLegs(A, p);
			let settled = -1;
			if (S && !S.node.length) {
				nav.settleCandidates(A, p, false).some((E, k) => {
					const L2 = startLegs(E, p);
					if (L2 && L2.node.length) { S = L2; settled = k; return true; }
					return false;
				});
			}
			ms.start += Date.now() - t;
			t = Date.now();
			let L = nav.goalLegs(A.c, g(A.c), A, p, cellOf);
			let gs = -1;
			if (!L.nodes.length) {
				nav.settleCandidates(A, p, true).some((E, k) => {
					const L2 = nav.goalLegs(A.c, g(A.c), E, p, cellOf);
					if (L2.nodes.length) { L = L2; gs = k; return true; }
					return false;
				});
			}
			ms.goal += Date.now() - t;
			row[name] = { start: S && { settled, ...S }, goal: { settled: gs, node: Array.from(L.nodes), cost: Array.from(L.sec), yards: Array.from(L.yd), cells: L.cells.map((c) => Array.from(c)) } };
		}
	}
	rows.push(row);
}
// The router's AreaTable zones (router.js areaZones) for the Rust router: area -> zone.
const { loadAreas } = require(`${ROOT}/tools/lib/data/areas`);
const { DATA, SOURCES } = require(`${ROOT}/tools/lib/paths`);
const { zoneAreas } = require(`${ROOT}/tools/lib/nav/pack`);
const areas = loadAreas(SOURCES);
const zone = zoneAreas({ areaTable: [...areas.byId.values()].map((a) => ({ ID: a.id, ParentAreaID: a.parent })), zones: JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')) });
const areaZone = {};
for (const id of areas.byId.keys()) { const z = zone(0, id); if (z) areaZone[id] = z; }
const crypto = require('node:crypto');
const zonesTag = crypto.createHash('sha1').update(`${areas.build}\n`).update(fs.readFileSync(path.join(DATA, 'zones.json'))).digest('hex').slice(0, 12);
const hubsDoc = fs.existsSync(router.HUBS_FILE) ? fs.readFileSync(router.HUBS_FILE) : null;
const hubsTagFile = crypto.createHash('sha1').update(hubsDoc ? JSON.stringify(JSON.parse(hubsDoc)) : 'null').digest('hex').slice(0, 12);
fs.writeFileSync(out, JSON.stringify({
	faction: world.faction, groundKey: profiles.base.groundKey, edgeKey: require(`${ROOT}/tools/lib/nav/path`).edgeKey(0, profiles.base), hubsTag: hubsTagFile,
	hubsFileIsStringify: hubsDoc ? String(hubsDoc).trim() === JSON.stringify(JSON.parse(hubsDoc)) : null,
	danger, areaKey: profiles.band10.area.key, zonesTag, areaZone, ms, rows,
}));
console.log(`legs ${rows.length} ends in ${(Date.now() - t0) / 1000} s (snap ${ms.snap} ms, start ${ms.start} ms, goal ${ms.goal} ms); groundKey ${profiles.base.groundKey}; hubs file is JSON.stringify: ${hubsDoc ? String(hubsDoc).trim() === JSON.stringify(JSON.parse(hubsDoc)) : null}`);
