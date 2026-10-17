'use strict';
// The grid in Shortest Path Forever's walking-map format
// (tools/lib/nav/pack.js) on synthetic tiles built by the real grid build,
// read back with his decoder's logic in Node (helpers/spfnav.js). Ids in
// test names are rows of docs/superpowers/specs/2026-10-15-spf-issues.md.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { Scene, ADT } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid } = require('../tools/lib/nav/grid/build');
const { packNav, cellGridFromDir, buildHpa, encodeMaps, nodeClass, capitalAreas, readLayers, BLOCK_BYTES, PART_BYTES, ZQ } = require('../tools/lib/nav/pack');
const Costs = require('../tools/lib/nav/costs');
const { FLAG } = require('../tools/lib/nav/grid/format');
const { runAddon, tocEntries, ADDONS } = require('./helpers/lua');
const S = require('./helpers/spfnav');

const CELL = ADT / 256;

async function gridOf(...scenes) {
	const dir = tmpdir('polestar-pack-');
	const byKey = new Map(scenes.map((s) => [`${s.col}_${s.row}`, s]));
	await buildGrid({
		outDir: dir, workers: 0,
		continents: [{ c: 0, name: 'test', tiles: scenes.map((s) => ({ col: s.col, row: s.row })) }],
		geometryJob: (c, t) => ({ geom: byKey.get(`${t.col}_${t.row}`).geom() }),
	});
	return dir;
}

async function packOf(scenes, cells = 128) {
	const dir = await gridOf(...scenes);
	const files = await packNav({ dir, cells, global: 'TestPathData' });
	return { dir, files, D: S.loadPack(files, 0) };
}

// Ground for the classes, two tiles (col 32 west of col 33): in tile 32 a north-south road (local x 200-220), an
// indoor floor plate at x 300-340 (indoor) and one at x 40-80 (indoor city: the city layer says the chunks west of
// x 160 lie in a capital), a Horde hub over the east border; in tile 33 a gentle hill (35°), a steep one (48°) and
// an Alliance hub over the west border. -> { dir, layers, a, b, hubs } (built once)
let ground = null;
const groundOf = () => (ground = ground || buildGround());
async function buildGround() {
	const a = new Scene({ col: 32 });
	const b = new Scene({ col: 33, height: (x, y) => Math.max(0, 0.7 * (60 - Math.hypot(x - 300, y - 150)), 1.1 * (40 - Math.hypot(x - 380, y - 400))) });
	a.floor(300, 60, 340, 100, 0.5).floor(40, 60, 80, 100, 0.5);
	const dir = await gridOf(a, b);
	const road = Buffer.alloc(256 * 256);
	for (let j = 0; j < 256; j++) for (let i = Math.floor(200 / CELL); i < Math.ceil(220 / CELL); i++) road[j * 256 + i] = 255;
	const tenth = (v) => Math.round(v * 10) / 10; // hubs.json's precision
	const at = (s, x, y, r) => {
		const w = s.world(x, y);
		return [tenth(w.wx), tenth(w.wy), r];
	};
	const hubs = [
		{ id: 'horde-camp', side: 'Horde', name: 'Mor\'shan "Camp"', areaId: 2357, disks: [at(a, 525, 300, 20), at(a, 520, 330, 12)] },
		{ id: 'alliance-post', side: 'Alliance', name: 'Post', areaId: 87, disks: [at(b, 10, 150, 20)] },
	];
	const layers = {
		roads: (c, col) => (col === 32 ? road : null),
		hubs: { 0: hubs },
		city: (c, wx, wy) => wy > a.west - 160,
	};
	return { dir, layers, a, b, hubs };
}

// The decoded cluster and node of a scene point (the base surface, or the surface nearest z).
function at(D, s, x, y, z) {
	const w = s.world(x, y);
	const p = S.locate(D, w.wx, w.wy);
	const cl = S.decodeCluster(D, p.k);
	const node = z === undefined ? (cl.val[p.lc] ? p.lc : null) : S.surface(cl.C, cl.val, cl.z, cl.at, p.lc, -1, z);
	return { ...p, cl, node };
}

test('pack: a wall on a cell edge closes the step, a door through it opens (spf-issues themes: wall cuts)', async () => {
	// A thin wall (0.3 yd) along x = 100 columns, on a 128-cell edge, across
	// the whole tile but for a 6 yd door at y 300..306.
	const s = new Scene();
	const x = 100 * CELL;
	s.box(x - 0.15, -1, -1, x + 0.15, 300, 10).box(x - 0.15, 306, -1, x + 0.15, ADT + 1, 10);
	const { D } = await packOf([s]);
	const west = at(D, s, x - 1, 150);
	const east = at(D, s, x + 1, 150);
	assert.equal(west.k, east.k);
	assert.ok(west.cl.val[west.lc] && west.cl.val[east.lc], 'both sides walkable');
	assert.equal(Math.abs(west.lc - east.lc), 1, 'neighbouring cells');
	const lower = Math.min(west.lc, east.lc);
	assert.ok(Math.floor(west.cl.m[lower] / 16) & 2, 'the +y step across the wall is closed');
	const reach = S.reach(west.cl, west.node);
	assert.ok(reach.has(east.node), 'round through the door');
	const door = at(D, s, x - 1, 303);
	const doorLower = Math.min(door.lc, door.lc - 1);
	assert.equal(Math.floor(door.cl.m[doorLower] / 16) & 2, 0, 'the door is open');
	// Without the door the two sides never meet.
	const s2 = new Scene();
	s2.box(x - 0.15, -1, -1, x + 0.15, ADT + 1, 10);
	const p2 = await packOf([s2]);
	const w2 = at(p2.D, s2, x - 1, 150);
	const e2 = at(p2.D, s2, x + 1, 150);
	assert.equal(S.reach(w2.cl, w2.node).has(e2.node), false, 'no way through a closed wall');
});

test('pack: a ridge too steep to walk is not crossed, a gentle one is (the Barrens ridge north of Camp Taurajo)', async () => {
	// Terrain ridges along x = 260: 70° flanks (our grid climbs them upward
	// only, a fall the other way) and 27° flanks.
	const steep = new Scene({ height: (x) => Math.max(0, 40 - 2.75 * Math.abs(x - 260)) });
	const gentle = new Scene({ height: (x) => Math.max(0, 20 - 0.5 * Math.abs(x - 260)) });
	for (const [s, crossed] of [[steep, false], [gentle, true]]) {
		const { D } = await packOf([s]);
		const a = at(D, s, 150, 250);
		const b = at(D, s, 370, 250);
		assert.ok(a.node !== null && b.node !== null);
		assert.equal(S.reach(a.cl, a.node).has(b.node), crossed, crossed ? 'over the gentle ridge' : 'never over the steep ridge');
	}
});

test('pack: floors stack over the ground and a ramp joins them; the street over a canal snaps to the street (C6)', async () => {
	// A 60 x 60 yd platform 10 yd up over flat ground, a ramp (about 27°) from the ground onto its west edge.
	const s = new Scene();
	s.box(200, 200, 9.5, 260, 260, 10, 1);
	s.quad([180, 220, 0], [200, 220, 10], [200, 240, 10], [180, 240, 0], 1);
	const { D } = await packOf([s]);
	const p = at(D, s, 230, 230);
	const { cl } = p;
	const first = cl.at.get(-(p.lc + 1));
	assert.ok(first !== undefined && first >= cl.N, 'a floor over the cell');
	assert.equal(cl.at.get(first), p.lc);
	assert.notEqual(cl.at.get(first + 1), p.lc, 'one floor');
	// The base is the larger region's surface, then the higher (gen_nav.py); both are one region here.
	const [low, high] = cl.z[p.lc] < cl.z[first] ? [p.lc, first] : [first, p.lc];
	assert.ok(Math.abs(cl.z[low]) <= ZQ, `the ground (${cl.z[low]})`);
	assert.ok(Math.abs(cl.z[high] - 10) <= ZQ, `the platform (${cl.z[high]})`);
	assert.equal(S.surface(cl.C, cl.val, cl.z, cl.at, p.lc, -1, 10.2), high, 'a point on the platform stands on it');
	assert.equal(S.surface(cl.C, cl.val, cl.z, cl.at, p.lc, -1, 0.3), low, 'a point under it stands on the ground');
	const ground = at(D, s, 100, 230);
	assert.ok(S.reach(cl, ground.node).has(high), 'up the ramp onto the platform');
	assert.ok(S.reach(cl, high).has(low), 'and down to the ground under it');
});

test('pack: round trip through the decoder: cells, flags, heights, floors and graph agree with the cell grid', async () => {
	// Two tiles side by side (col 32 west of col 33), a wall on their border with a 30 yd gap, a platform with a ramp.
	const a = new Scene({ col: 32 });
	const b = new Scene({ col: 33, height: (x, y) => Math.sin(y / 30) * 3 });
	a.box(ADT - 0.3, -1, -1, ADT - 0.02, 200, 10).box(ADT - 0.3, 230, -1, ADT - 0.02, ADT + 1, 10);
	a.box(100, 100, 9.5, 160, 160, 10, 1).quad([80, 120, 0], [100, 120, 10], [100, 140, 10], [80, 140, 0], 1);
	const dir = await gridOf(a, b);
	for (const cells of [67, 128]) {
		const { cg } = await cellGridFromDir({ dir, c: 0, C: cells });
		const hpa = buildHpa(cg);
		const maps = encodeMaps(cg, hpa);
		const files = await packNav({ dir, cells, global: 'TestPathData' });
		const D = S.loadPack(files, 0);
		assert.equal(D.cells, cells);
		const NB = cg.GW * cg.GH;
		let floors = 0;
		for (const [k, cl] of cg.clusters) {
			assert.equal(D.grid[k + 1], maps.grid.get(k));
			const dc = S.decodeCluster(D, k);
			for (let l = 0; l < cells * cells; l++) {
				assert.equal(dc.val[l], cl.val[l], `value of ${k}:${l}`);
				assert.equal(Math.floor(dc.m[l] / 16), cl.flags[l], `flags of ${k}:${l}`);
				if (cl.val[l]) assert.equal(dc.z[l], cl.zq[l] * ZQ, `height of ${k}:${l}`);
			}
			for (let f = cl.floorStart; f < cl.floorEnd; f++) {
				const node = cells * cells + f - cl.floorStart;
				assert.equal(dc.at.get(node), (Math.floor(cg.floorCell[f] / cg.GH) % cells) * cells + (cg.floorCell[f] % cg.GH) % cells);
				assert.equal(dc.z[node], Math.round(cg.floorZ[f]));
				floors++;
				// Every link of the floor inside the cluster decodes to the same surface.
				for (const v of cg.links.get(NB + f) || []) {
					if (cg.clusterOfCell(cg.cellOf(v)) !== k) continue;
					const want = v >= NB ? cells * cells + v - NB - cl.floorStart : (Math.floor(v / cg.GH) % cells) * cells + (v % cg.GH) % cells;
					assert.ok(S.movesOf(dc, node).some(([t]) => t === want), `floor ${node} of ${k} steps to ${want}`);
					assert.ok(S.movesOf(dc, want).some(([t]) => t === node), `and back from ${want}`);
				}
			}
			const graph = S.decodeGraph(D, k);
			for (const e of graph) {
				assert.ok(e.cell < cells * cells, `an entrance names its local cell (${e.cell})`);
				assert.ok(S.surface(dc.C, dc.val, dc.z, dc.at, e.cell, e.layer, 0) !== null, 'an entrance stands on a surface');
				// No layers: no hub, so every profile prices an edge alike (maps format 2: Alliance, Horde, none).
				for (const edge of e.edges) assert.ok(edge.costs[0] === edge.costs[2] && edge.costs[1] === edge.costs[2] && edge.costs[2] > 0 && edge.yards > 0, `one cost for every profile, and yards (${edge.costs}, ${edge.yards})`);
			}
		}
		assert.ok(floors > 0, 'the platform is a floor');
		// The border wall: every crossing between the clusters lies in the gap.
		const crossing = [];
		for (const k of cg.clusters.keys()) {
			for (const e of S.decodeGraph(D, k)) {
				if (e.edges.some((x) => x.offset !== 4)) crossing.push((cg.CX0 * ADT + (Math.floor(k / cg.NY) * cells + Math.floor((e.cell % (cells * cells)) / cells) + 0.5) * (ADT / cells)));
			}
		}
		assert.ok(crossing.length >= 2, `entrances across the border (${cells} cells)`);
		for (const wx of crossing) {
			const y = a.north - wx;
			assert.ok(y > 200 - ADT / cells && y < 230 + ADT / cells, `a crossing at y ${y.toFixed(1)} lies in the gap`);
		}
	}
});

test('pack: deterministic', async () => {
	const s = new Scene({ height: (x, y) => Math.sin(x / 40) * 5 + Math.cos(y / 50) * 4 });
	s.box(100, 100, -1, 103, 300, 10).box(300, 50, 6, 360, 120, 6.5, 2);
	const dir = await gridOf(s);
	const one = await packNav({ dir, cells: 67 });
	const two = await packNav({ dir, cells: 67 });
	assert.deepEqual([...one.entries()], [...two.entries()]);
	const g = await groundOf();
	const three = await packNav({ dir: g.dir, cells: 128, layers: g.layers });
	const four = await packNav({ dir: g.dir, cells: 128, layers: g.layers });
	assert.deepEqual([...three.entries()], [...four.entries()], 'with the ground layers too');
});

test('pack: nodeClass: steep slope > indoor > road > gentle slope > normal; indoor in a capital is indoor city; hub bits on top', () => {
	const { CLASS, SLOPE, HUB_ALLIANCE, HUB_HORDE } = Costs;
	const steep = SLOPE.STEEP;
	const gentle = SLOPE.GENTLE;
	assert.equal(nodeClass({}), CLASS.NORMAL);
	assert.equal(nodeClass({ tslope: steep, road: true }), CLASS.STEEP, 'a steep road stays steep');
	assert.equal(nodeClass({ tslope: steep, surfaceFlags: FLAG.INDOOR }), CLASS.STEEP);
	assert.equal(nodeClass({ surfaceFlags: FLAG.INDOOR, road: true }), CLASS.INDOOR, 'an indoor road is indoor');
	assert.equal(nodeClass({ surfaceFlags: FLAG.INDOOR, areaCity: true }), CLASS.CITY, 'indoor in a capital is indoor city');
	assert.equal(nodeClass({ areaCity: true }), CLASS.NORMAL, 'outdoors in a capital is plain ground');
	assert.equal(nodeClass({ tslope: gentle, road: true }), CLASS.ROAD, 'a gentle road is a road (roads are graded)');
	assert.equal(nodeClass({ tslope: gentle }), CLASS.GENTLE);
	assert.equal(nodeClass({ tslope: gentle - 1 }), CLASS.NORMAL);
	assert.equal(nodeClass({ tslope: steep - 1 }), CLASS.GENTLE);
	assert.equal(nodeClass({ road: true, hubBits: HUB_ALLIANCE | HUB_HORDE | 64 }), CLASS.ROAD | HUB_ALLIANCE | HUB_HORDE, 'both hub bits, nothing else');
});

test('pack: costs.js is Routing/Costs.lua\'s table (the packer prices the graph as the router prices a step)', () => {
	const [got] = runAddon({
		addons: [{ name: 'Polestar_Nav', files: ['Routing/Costs.lua'] }],
		script: `local K = Polestar_NavCosts
local m = {}
for c = 0, 31 do m[c + 1] = { K.Mult(c, "Alliance"), K.Mult(c, "Horde"), K.Mult(c, nil) } end
emit({ class = K.CLASS, hubs = { K.HUB_ALLIANCE, K.HUB_HORDE }, hub = K.HUB, min = K.MIN, m = m })`,
	}).emitted;
	assert.deepEqual(got.class, Costs.CLASS);
	assert.deepEqual(got.hubs, [Costs.HUB_ALLIANCE, Costs.HUB_HORDE]);
	assert.equal(got.hub, Costs.HUB);
	assert.equal(got.min, Costs.MIN);
	for (let c = 0; c < 32; c++) assert.deepEqual(got.m[c], Costs.PROFILES.map((p) => Costs.mult(c, p)), `class byte ${c}`);
});

test('pack: capitalAreas: the AreaTable\'s capitals (Flags_0 & 0x100) and every area under one', () => {
	const rows = [
		{ ID: 1, ParentAreaID: 0, Flags_0: 65 }, // Dun Morogh
		{ ID: 1519, ParentAreaID: 0, Flags_0: 312 }, // Stormwind City
		{ ID: 1617, ParentAreaID: 1519, Flags_0: 1073741888 }, // Valley of Heroes
		{ ID: 9, ParentAreaID: 1617, Flags_0: 0 },
		{ ID: 809, ParentAreaID: 1, Flags_0: 1073741888 }, // Gates of Ironforge
	];
	assert.deepEqual([...capitalAreas(rows)].sort((a, b) => a - b), [9, 1519, 1617]);
});

test('pack: maps format 2: the class field round-trips through the router\'s decoder, hub bits on every cell a disk touches, the hubs in the metadata', async () => {
	const { dir, layers, a, b, hubs } = await groundOf();
	const files = await packNav({ dir, cells: 128, layers });
	const { cg } = await cellGridFromDir({ dir, c: 0, C: 128, layers });
	const meta = files.get('Nav0.lua');
	assert.match(meta, /^\tformat = 2,$/m);
	assert.match(meta, /^\tprofiles = \{ "Alliance", "Horde" \},$/m);
	assert.match(meta, /^\tcounts = \{ graph = \d+, grid = \d+, height = \d+, floor = \d+, class = \d+ \},$/m);
	assert.match(meta, /^\tpacked = \{ graph = \{\}, grid = \{\}, height = \{\}, floor = \{\}, class = \{\} \},$/m);
	const D = S.loadPack(files, 0);
	const keep = path.join(tmpdir('polestar-pack-ns-'), 'keep-ns.lua');
	fs.writeFileSync(keep, 'local _, ns = ...\nstub.navNs = ns\n');
	const nav = path.join(ADDONS, 'Polestar_Nav');
	const mapFiles = [];
	const out = tmpdir('polestar-pack-v2-');
	for (const [name, text] of files) {
		fs.writeFileSync(path.join(out, name), text);
		mapFiles.push(path.join(out, name));
	}
	const [got] = runAddon({
		stubs: ['stub_encoding.lua'],
		before: mapFiles.map((f) => `dofile(${JSON.stringify(f)})`).join('\n'),
		addons: [{ name: 'Polestar_Nav', files: [...tocEntries(nav).filter((f) => !f.endsWith('.xml')), path.relative(nav, keep)] }],
		script: `local G = stub.navNs.PathGrid
local D = PolestarPathData[0]
local st = G.State(0)
local out = { has = Polestar_NavEngine.HasData(0), format = D.format, profiles = D.profiles, hubs = D.hubs, clusters = {}, graph = {} }
for k = 0, D.nx * D.ny - 1 do
	local val = G.grid(st, k)
	if val then
		local cls = {}
		for i = 1, #val do cls[i] = st.cls[k][i] end
		out.clusters[#out.clusters + 1] = { k = k, cls = cls }
	end
	for _, id in ipairs(G.nodesOf(st, k)) do
		local adj = {}
		for i, v in ipairs(G.adjacent(st, id)) do adj[i] = v end
		out.graph[#out.graph + 1] = { id = id, adj = adj }
	end
end
emit(out)`,
	}).emitted;
	assert.equal(got.has, true, 'API.lua keeps the map: its counts hold the class field');
	assert.equal(got.format, 2);
	assert.deepEqual(got.profiles, ['Alliance', 'Horde']);
	assert.deepEqual(got.hubs.map((h) => [h.id, h.side, h.name, h.areaId, h.disks]), hubs.map((h) => [h.id, h.side, h.name, h.areaId, h.disks]));
	// The classes the router decodes are the packer's, node for node (base cells, then floors).
	const NB = cg.GW * cg.GH;
	const seen = new Set();
	assert.equal(got.clusters.length, cg.clusters.size);
	for (const { k, cls } of got.clusters) {
		const cl = cg.clusters.get(k);
		const want = [...cl.cls];
		for (let f = cl.floorStart; f < cl.floorEnd; f++) want.push(cg.floorClass[f]);
		assert.deepEqual(cls, want, `cluster ${k}: the router's classes`);
		assert.deepEqual(S.decodeCluster(D, k).cls, want, `cluster ${k}: Node's decode agrees`);
		want.forEach((c, i) => {
			if (i < 128 * 128 ? cl.val[i] : true) seen.add(c & 7).add(c & 24);
		});
	}
	for (const c of [1, 2, 3, 4, 5, 8, 16]) assert.ok(seen.has(c), `some node of class ${c} (seen ${[...seen].sort((x, y) => x - y)})`);
	// Hub bits: a surface carries its side's bit exactly when its cell's square meets one of that side's disks.
	const cs = ADT / 128;
	const touches = (gx, gy, side) => hubs.filter((h) => h.side === side).some((h) => h.disks.some(([hx, hy, r]) => {
		const x0 = cg.CX0 * ADT + gx * cs;
		const y0 = cg.CY0 * ADT + gy * cs;
		return Math.hypot(Math.max(x0 - hx, 0, hx - x0 - cs), Math.max(y0 - hy, 0, hy - y0 - cs)) <= r;
	}));
	let marked = 0;
	for (const [k, cl] of cg.clusters) {
		for (let l = 0; l < 128 * 128; l++) {
			if (!cl.val[l]) continue;
			const gx = Math.floor(k / cg.NY) * 128 + Math.floor(l / 128);
			const gy = (k % cg.NY) * 128 + (l % 128);
			assert.equal(!!(cl.cls[l] & 8), touches(gx, gy, 'Alliance'), `Alliance bit of ${gx},${gy}`);
			assert.equal(!!(cl.cls[l] & 16), touches(gx, gy, 'Horde'), `Horde bit of ${gx},${gy}`);
			if (cl.cls[l] & 24) marked++;
		}
	}
	assert.ok(marked > 40, `hub cells (${marked})`);
	// The router's decoded graph is the packer's: target, costAlliance, costHorde, costNone, yards per edge.
	const ids = new Map(got.graph.map((g) => [g.id, g.adj]));
	let edges = 0;
	for (const k of cg.clusters.keys()) {
		S.decodeGraph(D, k).forEach((e, i) => {
			const want = e.edges.flatMap((x) => [(k + (Math.floor(x.offset / 3) - 1) * D.ny + (x.offset % 3) - 1) * 4096 + x.node, ...x.costs, x.yards]);
			assert.deepEqual(ids.get(k * 4096 + i), want, `entrance ${k}:${i}`);
			edges += e.edges.length;
		});
	}
	assert.ok(edges > 0, 'a graph');
});

// The zone field's run-length (pack.js HEADER): a symbol < 48 starts a 2-symbol uiMapID, one >= 48 repeats the
// previous one (symbol - 47) more times. -> 256 uiMapIDs by chunk (cx // 8) * 16 + (cy // 8) of the cluster's cells.
function decodeZones(s) {
	const B = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	const out = [];
	for (let i = 0; i < s.length; ) {
		const a = B.indexOf(s[i]);
		if (a < 48) {
			out.push(a * 64 + B.indexOf(s[i + 1]));
			i += 2;
		} else {
			for (let r = 47; r < a; r++) out.push(out[out.length - 1]);
			i++;
		}
	}
	return out;
}

test('pack: the zone field: each chunk\'s zone (its area up to a zone, as a uiMapID) in the cluster\'s own axes; a tile without areas writes none', async () => {
	// Tile 32: Western Plaguelands (area 28, uiMap 1422) in its north half, Silverpine (130, 1421) in the south, and
	// one chunk of Tirisfal (85, 1420) at its south-west corner (asymmetric: a flipped axis puts it elsewhere). Tile
	// 33 (east of it) has no areas.
	const span = ADT / 16;
	const areaAt = (x, y) => (x < span && y > ADT - span ? 85 : y < ADT / 2 ? 28 : 130);
	const a = new Scene({ col: 32, areas: areaAt });
	const b = new Scene({ col: 33, areas: null });
	const dir = await gridOf(a, b);
	const UIMAP = { 28: 1422, 130: 1421, 85: 1420 };
	const layers = { zone: (c, areaId) => UIMAP[areaId] || 0 };
	const files = await packNav({ dir, cells: 128, layers });
	const meta = files.get('Nav0.lua');
	const D = S.loadPack(files, 0);
	const zone = {};
	for (const m of meta.matchAll(/^\t\t\[(\d+)\] = "([A-Za-z0-9+/]*)",$/gm)) zone[Number(m[1])] = m[2];
	assert.match(meta, /^\tzone = \{$/m, 'the metadata carries the zone field');
	const ka = S.locate(D, a.world(10, 10).wx, a.world(10, 10).wy).k;
	const kb = S.locate(D, b.world(10, 10).wx, b.world(10, 10).wy).k;
	assert.notEqual(ka, kb);
	assert.deepEqual(Object.keys(zone).map(Number), [ka + 1], 'only the tile with areas has a zone string');
	const z = decodeZones(zone[ka + 1]);
	assert.equal(z.length, 256);
	let corner = 0;
	for (let cy = 0; cy < 16; cy++) {
		for (let cx = 0; cx < 16; cx++) {
			const [x, y] = [(cx + 0.5) * span, (cy + 0.5) * span];
			const w = a.world(x, y);
			const p = S.locate(D, w.wx, w.wy);
			const q = Math.floor(Math.floor(p.lc / 128) / 8) * 16 + Math.floor((p.lc % 128) / 8);
			assert.equal(z[q], UIMAP[areaAt(x, y)], `chunk at local ${x.toFixed(0)},${y.toFixed(0)} (cluster chunk ${q})`);
			if (z[q] === 1420) corner++;
		}
	}
	assert.equal(corner, 1, 'one Tirisfal chunk');
	// Without the zone layer, or with no chunk in a zone, no field is written.
	assert.doesNotMatch((await packNav({ dir, cells: 128 })).get('Nav0.lua'), /zone = /);
	assert.doesNotMatch((await packNav({ dir, cells: 128, layers: { zone: () => 0 } })).get('Nav0.lua'), /zone = /);
});

test('pack: readLayers resolves a chunk\'s zone up its AreaTable parents to a zone of zones.json, with no map frame (Riverglades, a Forever zone)', async () => {
	// Riverglades (area 16591, uiMap 2548) has no Era map frame; Sunnyglade (16723) is its subzone, Lakeshire (69) is
	// Redridge's (44, 1433); area 7 is no zone's.
	const areaAt = (x, y) => (y < ADT / 4 ? 16723 : y < ADT / 2 ? 16591 : x < ADT / 2 ? 69 : 7);
	const dir = await gridOf(new Scene({ col: 32, areas: areaAt }));
	const layerDir = tmpdir('polestar-pack-layers-');
	fs.writeFileSync(path.join(layerDir, 'hubs.json'), '{}');
	fs.mkdirSync(path.join(layerDir, 'roads'));
	fs.writeFileSync(path.join(layerDir, 'roads', 'index.json'), '{}');
	// Area 900 is a zones.json entry of another type (6, a battleground or instance-like map) inside Riverglades; 901
	// lies in it: only a zone (type 3) counts, so both resolve to Riverglades, never to 2600.
	const areaTable = [
		{ ID: 16591, ParentAreaID: 0, Flags_0: 0 }, { ID: 16723, ParentAreaID: 16591, Flags_0: 0 },
		{ ID: 44, ParentAreaID: 0, Flags_0: 0 }, { ID: 69, ParentAreaID: 44, Flags_0: 0 }, { ID: 7, ParentAreaID: 0, Flags_0: 0 },
		{ ID: 900, ParentAreaID: 16591, Flags_0: 0 }, { ID: 901, ParentAreaID: 900, Flags_0: 0 },
	];
	const zones = {
		1415: { id: 1415, name: 'Eastern Kingdoms', areaId: null, type: 2 },
		1433: { id: 1433, name: 'Redridge Mountains', areaId: 44, type: 3 },
		2548: { id: 2548, name: 'Riverglades', areaId: 16591, type: 3 },
		2600: { id: 2600, name: 'Not a zone', areaId: 900, type: 6 },
	};
	const layers = readLayers({ dir: layerDir, areaTable, zones });
	assert.equal(typeof layers.zone, 'function', 'readLayers gives the zone layer from the AreaTable and zones.json');
	assert.deepEqual([16723, 16591, 69, 44, 7, 0, 900, 901].map((a) => layers.zone(0, a) || 0), [2548, 2548, 1433, 1433, 0, 0, 2548, 2548]);
	const files = await packNav({ dir, cells: 128, layers });
	const D = S.loadPack(files, 0);
	const [, s] = /^\t\t\[\d+\] = "([A-Za-z0-9+/]*)",$/m.exec(files.get('Nav0.lua'));
	const z = decodeZones(s);
	for (const [x, y] of [[100, 50], [100, 200], [100, 400], [400, 400]]) {
		const w = new Scene({ col: 32 }).world(x, y);
		const p = S.locate(D, w.wx, w.wy);
		const q = Math.floor(Math.floor(p.lc / 128) / 8) * 16 + Math.floor((p.lc % 128) / 8);
		assert.equal(z[q], { 16723: 2548, 16591: 2548, 69: 1433, 7: 0 }[areaAt(x, y)], `local ${x},${y}`);
	}
});

// The cost from node src to node dst on a decoded cluster, a step into node v costing length * cs * mult(class of
// v), times swim in water (Routing/Path.lua search).
function gridCost(dc, src, dst, mult, cs, swim) {
	const g = new Map([[src, 0]]);
	const heap = [[0, src]];
	const push = (item) => {
		let i = heap.push(item) - 1;
		while (i > 0 && heap[(i - 1) >> 1][0] > heap[i][0]) {
			[heap[i], heap[(i - 1) >> 1]] = [heap[(i - 1) >> 1], heap[i]];
			i = (i - 1) >> 1;
		}
	};
	const pop = () => {
		const top = heap[0];
		const last = heap.pop();
		if (heap.length) {
			heap[0] = last;
			for (let i = 0; ; ) {
				let m = i;
				for (const c of [2 * i + 1, 2 * i + 2]) if (c < heap.length && heap[c][0] < heap[m][0]) m = c;
				if (m === i) break;
				[heap[i], heap[m]] = [heap[m], heap[i]];
				i = m;
			}
		}
		return top;
	};
	const done = new Set();
	while (heap.length) {
		const [d, u] = pop();
		if (done.has(u)) continue;
		if (u === dst) return d;
		done.add(u);
		for (const [v, len] of S.movesOf(dc, u)) {
			const c = d + len * cs * mult(dc.cls[v]) * (dc.val[v] === 2 ? swim : 1);
			if (!g.has(v) || c < g.get(v)) {
				g.set(v, c);
				push([c, v]);
			}
		}
	}
	return Infinity;
}

test('pack: per-profile graph costs are the local grid\'s costs under each profile, yards the walked length', async () => {
	const { dir, layers } = await groundOf();
	const D = S.loadPack(await packNav({ dir, cells: 128, layers }), 0);
	const cs = ADT / 128;
	const mults = Costs.PROFILES.map((p) => (c) => Costs.mult(c, p));
	let intra = 0;
	let inter = 0;
	const differs = [false, false];
	for (let k = 0; k < D.nx * D.ny; k++) {
		const dc = S.decodeCluster(D, k);
		if (!dc) continue;
		const graph = S.decodeGraph(D, k);
		const nodeOf = (e) => S.surface(dc.C, dc.val, dc.z, dc.at, e.cell, e.layer, 0);
		for (const e of graph) {
			const src = nodeOf(e);
			for (const x of e.edges) {
				const tk = k + (Math.floor(x.offset / 3) - 1) * D.ny + (x.offset % 3) - 1;
				if (tk === k) {
					// Dijkstra on the decoded cluster, a step into node v costing length * cs * mult(class of v) (x swim in water).
					const dst = nodeOf(graph[x.node]);
					mults.forEach((mult, p) => {
						const cost = gridCost(dc, src, dst, mult, cs, D.swim);
						assert.ok(Math.abs(cost - x.costs[p]) <= 0.5 + 1e-6, `cluster ${k}: edge cost ${x.costs[p]} under ${Costs.PROFILES[p]}, the grid's ${cost}`);
					});
					// Yards: the walked length of a way costing costNone, each yard costing MIN to the steepest class's.
					assert.ok(x.yards <= x.costs[2] / Costs.MIN + 1 && x.yards >= x.costs[2] / (Math.max(...Costs.MULT) * D.swim) - 1, `yards ${x.yards} for cost ${x.costs[2]}`);
					if (x.costs[0] > x.costs[2]) differs[0] = true;
					if (x.costs[1] > x.costs[2]) differs[1] = true;
					intra++;
				} else {
					// Across the border: one step into the target cluster's entrance.
					const td = S.decodeCluster(D, tk);
					const te = S.decodeGraph(D, tk)[x.node];
					const v = S.surface(td.C, td.val, td.z, td.at, te.cell, te.layer, 0);
					const len = Math.abs(x.yards - cs) < 0.5 ? 1 : Math.SQRT2;
					mults.forEach((mult, p) => assert.equal(x.costs[p], Math.round(len * cs * mult(td.cls[v]) * (td.val[v] === 2 ? D.swim : 1)), `crossing cost under ${Costs.PROFILES[p]}`));
					if (x.costs[0] > x.costs[2]) differs[0] = true;
					if (x.costs[1] > x.costs[2]) differs[1] = true;
					inter++;
				}
			}
		}
	}
	assert.ok(intra > 10 && inter > 10, `edges inside (${intra}) and across (${inter}) clusters`);
	assert.deepEqual(differs, [true, true], 'a Horde hub prices some Alliance edge higher, an Alliance hub some Horde edge');
});

test('pack: blocks fit the client\'s 16 KB inflate buffer, parts stay under 512 KB, a decoded cluster fits Path.cacheKB / 8 (C17)', async () => {
	// Rolling hills, a walled pen and three two-storey houses with outside stairs (floors over the ground).
	const s = new Scene({ height: (x, y) => Math.sin(x / 40) * 6 + Math.cos(y / 30) * 5 });
	s.box(100, 100, -10, 102, 300, 8).box(300, 100, -10, 302, 300, 8).box(100, 100, -10, 300, 102, 8);
	for (let i = 0; i < 3; i++) s.box(350 + i * 50, 350, 9.5, 380 + i * 50, 380, 10, 1).quad([340 + i * 50, 360, 0], [350 + i * 50, 360, 10], [350 + i * 50, 370, 10], [340 + i * 50, 370, 0], 1);
	const { files, D } = await packOf([s], 128);
	for (const [name, src] of files) {
		assert.ok(Buffer.byteLength(src) <= PART_BYTES, `${name} within a part`);
		for (const line of src.matchAll(/^data\.packed\.\w+\[\d+\] = \{(.*)\}$/gm)) {
			for (const m of line[1].matchAll(/"([A-Za-z0-9+/=]+)"/g)) assert.ok(zlib.inflateSync(Buffer.from(m[1], 'base64')).length <= BLOCK_BYTES);
		}
	}
	assert.deepEqual([...files.keys()].slice(0, 2), ['Nav0.lua', 'Nav0_1.lua'], 'the metadata file first, then its parts');
	assert.match(files.get('Nav0.lua'), /^TestPathData = TestPathData or \{\}$/m);
	// PathGrid.lua gridSize: array capacity * 48 bytes + 320, 64 per `at` entry, 128 + 32 per link of a linked node.
	const cl = S.decodeCluster(D, 0);
	let cap = 1;
	while (cap < cl.nodes) cap *= 2;
	let bytes = cap * 48 + 320 + cl.at.size * 64;
	for (const l of cl.links.values()) bytes += 128 + l.length * 32;
	assert.ok(bytes / 1024 <= 24576 / 8, `${(bytes / 1024).toFixed(0)} KB per cluster`);
});

test('pack: a floor across a tile border is an entrance on its own cell and layer, and a route climbs onto it (SpfUpstream: Path.lua:185 trace(R, nil))', async () => {
	// A platform 10 yd up across the border of tiles 32 and 33 (west to east), over flat ground, a ramp onto it in tile 32.
	const a = new Scene({ col: 32 });
	const b = new Scene({ col: 33 });
	a.box(480, 200, 9.5, ADT, 260, 10, 1).quad([460, 220, 0], [480, 220, 10], [480, 240, 10], [460, 240, 0], 1);
	b.box(0, 200, 9.5, 40, 260, 10, 1);
	const dir = await gridOf(a, b);
	for (const cells of [67, 128]) {
		const D = S.loadPack(await packNav({ dir, cells }), 0);
		const C2 = cells * cells;
		let floorEntrances = 0;
		let onPlatform = 0;
		for (let k = 0; k < D.nx * D.ny; k++) {
			if (!D.graph[k + 1]) continue;
			const dc = S.decodeCluster(D, k);
			for (const e of S.decodeGraph(D, k)) {
				assert.ok(e.cell < C2, `entrance cell ${e.cell} is a local cell (${cells} cells)`);
				const node = S.surface(dc.C, dc.val, dc.z, dc.at, e.cell, e.layer, 0);
				assert.ok(node !== null, `entrance ${e.cell}:${e.layer} decodes to a node`);
				if (e.layer > 0) {
					floorEntrances++;
					assert.ok(node >= C2 && dc.at.get(node) === e.cell, 'a floor entrance is a floor of its cell');
				}
				if (Math.abs(dc.z[node] - 10) <= 1) {
					onPlatform++;
				}
			}
		}
		assert.ok(floorEntrances > 0, `stacked surfaces cross the border through floor entrances (${cells} cells)`);
		assert.ok(onPlatform > 0, `the platform crosses the border (${cells} cells)`);
		// From the ground west of the ramp up onto the platform's floor at the border, inside tile 32's cluster.
		const ground = a.world(400, 230);
		const edge = a.world(ADT - 2, 230);
		const g = S.locate(D, ground.wx, ground.wy);
		const p = S.locate(D, edge.wx, edge.wy);
		const dc = S.decodeCluster(D, g.k);
		const top = S.surface(dc.C, dc.val, dc.z, dc.at, p.lc, -1, 10);
		assert.ok(Math.abs(dc.z[top] - 10) <= 1);
		assert.ok(S.reach(dc, g.lc).has(top), `up the ramp onto the platform at the border (${cells} cells)`);
	}
});

test('pack: a road crossing a tile border is an entrance where it crosses, one per road, none added beside a chunk entrance (Fitz, Ratchet, 2026-10-16)', async () => {
	// Two flat tiles (32 west of 33); the border's chunk entrances fall every ~13 cells (cells 19, 32, ..., 70 north
	// of the tiles' south edge). Road A crosses at cells ~25-26, between two of them; road B at cells ~70, on one.
	const a = new Scene({ col: 32 });
	const b = new Scene({ col: 33 });
	const dir = await gridOf(a, b);
	const cellY = (gx) => ADT - (gx + 0.5) * (ADT / 128); // local y of cell row gx's centre
	const road = Buffer.alloc(256 * 256);
	for (const y of [cellY(25.5), cellY(70)]) for (let j = Math.floor((y - 4) / CELL); j < Math.ceil((y + 4) / CELL); j++) for (let i = 0; i < 256; i++) road[j * 256 + i] = 255;
	const plain = (await cellGridFromDir({ dir, c: 0, C: 128 })).cg;
	const { cg } = await cellGridFromDir({ dir, c: 0, C: 128, layers: { roads: () => road } });
	const crossings = (g) => {
		const out = new Map();
		for (const [key, e] of buildHpa(g).edges) if (g.clusterOfCell(g.cellOf(e.a)) !== g.clusterOfCell(g.cellOf(e.b))) out.set(key, e);
		return out;
	};
	const before = crossings(plain);
	const after = crossings(cg);
	const isRoad = (n) => (cg.nodeClass(n) & 7) === Costs.CLASS.ROAD;
	const row = (n) => Math.floor(cg.cellOf(n) / cg.GH) % 128;
	for (const [key, e] of before) assert.ok(after.has(key), `the chunk entrance at cell ${row(e.a)} stays`);
	assert.ok(![...before.values()].some((e) => isRoad(e.a) && row(e.a) < 40), 'road A crosses away from every chunk entrance');
	assert.ok([...before.values()].some((e) => isRoad(e.a) && isRoad(e.b) && Math.abs(row(e.a) - 70) <= 1), 'road B crosses on a chunk entrance');
	const added = [...after].filter(([key]) => !before.has(key)).map(([, e]) => e);
	assert.equal(added.length, 1, `one entrance added (at cells ${added.map((e) => row(e.a)).join(', ')})`);
	assert.ok(isRoad(added[0].a) && isRoad(added[0].b), 'on the road on both sides');
	assert.ok(Math.abs(row(added[0].a) - 25.5) <= 1.5, `in road A's crossing (cell ${row(added[0].a)})`);
	assert.equal(row(added[0].a), row(added[0].b), 'the straight crossing');
});

test('pack: a dry strip crossing a tile border beside water is an entrance of its own when every chunk entrance there lies in the water (Fitz, Auberdine pier, 2026-10-17)', async () => {
	// Two flat tiles (32 west of 33); along the border (40 yd each side) the ground drops 3 yd under water level with
	// the land, but for a dry strip at cells 24-27 north of the tiles' south edge (a beach or a pier's root), between
	// the chunk entrances at 19 and 32. Land and water are one region on each side, so the border's crossings are one
	// group and his chunk entrances all fall in the water.
	const cellY = (gx) => ADT - (gx + 0.5) * (ADT / 128); // local y of cell row gx's centre
	const strip = [cellY(28) + 0.01, cellY(23) - 0.01]; // local y, north to south
	const inStrip = (y) => y > strip[0] && y < strip[1];
	const a = new Scene({ col: 32, height: (x, y) => (x > ADT - 40 && !inStrip(y) ? -3 : 0) });
	const b = new Scene({ col: 33, height: (x, y) => (x < 40 && !inStrip(y) ? -3 : 0) });
	for (const [s, x0, x1] of [[a, ADT - 40, ADT], [b, 0, 40]]) s.water(x0, 0, x1, strip[0], 0).water(x0, strip[1], x1, ADT, 0);
	const { cg } = await cellGridFromDir({ dir: await gridOf(a, b), c: 0, C: 128 });
	const dry = (e) => cg.nodeValue(e.a) === 1 && cg.nodeValue(e.b) === 1;
	const row = (n) => Math.floor(cg.cellOf(n) / cg.GH) % 128;
	const crossings = [...buildHpa(cg).edges.values()].filter((e) => cg.clusterOfCell(cg.cellOf(e.a)) !== cg.clusterOfCell(cg.cellOf(e.b)));
	assert.ok(crossings.filter((e) => !dry(e)).length >= 8, 'the chunk entrances along the border, in the water');
	const dryOnes = crossings.filter(dry);
	assert.equal(dryOnes.length, 1, `one dry entrance (at cells ${dryOnes.map((e) => row(e.a)).join(', ')})`);
	const [e] = dryOnes;
	assert.ok(row(e.a) >= 24 && row(e.a) <= 27, `in the dry strip (cell ${row(e.a)})`);
	assert.equal(row(e.a), row(e.b), 'the straight crossing');
});

test('pack: shipPack writes the files, PACK.json and Nav.xml; checkPack finds a changed, missing or unlisted file; the same date gives the same bytes', async () => {
	const { shipPack, checkPack } = require('../tools/lib/nav/pack');
	const dir = await gridOf(new Scene());
	const out = path.join(tmpdir('polestar-pack-ship-'), 'Polestar_Nav');
	fs.mkdirSync(path.join(out, 'Nav'), { recursive: true });
	fs.writeFileSync(path.join(out, 'Nav', 'Nav0_9.lua'), 'stale\n');
	fs.writeFileSync(path.join(out, 'Nav', 'Nav2991_1.lua'), 'his old map\n');
	const files = await packNav({ dir, cells: 67, continents: [0], date: '2026-10-16' });
	const res = shipPack(files, out);
	assert.deepEqual(res.removed, ['Nav/Nav0_9.lua', 'Nav/Nav2991_1.lua'], 'parts the pack no longer has, of any map of ours (Zephras Isle too)');
	const m = JSON.parse(fs.readFileSync(path.join(out, 'PACK.json'), 'utf8'));
	assert.equal(m.cells, 67);
	assert.equal(m.date, '2026-10-16');
	assert.deepEqual(Object.keys(m.files), [...files.keys()].map((n) => `Nav/${n}`));
	assert.match(fs.readFileSync(path.join(out, 'Nav', 'Nav0.lua'), 'utf8'), /^-- Generated by `node tools\/polestar\.js nav pack --cells 67` from the navigation grid \(.*\) on 2026-10-16\. Do not edit/);
	const xml = fs.readFileSync(path.join(out, 'Nav', 'Nav.xml'), 'utf8');
	assert.deepEqual([...xml.matchAll(/file="([^"]+)"/g)].map((x) => x[1]), [...files.keys()], 'the packed maps');
	assert.deepEqual(checkPack(out), []);
	fs.appendFileSync(path.join(out, 'Nav', 'Nav0.lua'), '-- edited\n');
	fs.writeFileSync(path.join(out, 'Nav', 'Nav0_7.lua'), '\n');
	fs.rmSync(path.join(out, 'Nav', 'Nav0_1.lua'));
	assert.deepEqual(checkPack(out), ['Nav/Nav0.lua differs from PACK.json', 'Nav/Nav0_1.lua is missing', 'Nav/Nav0_7.lua is not listed in PACK.json']);
	const again = await packNav({ dir, cells: 67, continents: [0], date: '2026-10-16' });
	assert.deepEqual([...again.entries()], [...files.entries()], 'deterministic');
});

test('pack: a tile the grid lists but cannot read (missing, truncated, another version) stops the pack, naming it', async () => {
	const a = new Scene({ col: 32 });
	const b = new Scene({ col: 33 });
	const tile = (dir) => path.join(dir, 'tiles', '0', '33_32.nav.gz');
	const missing = await gridOf(a, b);
	fs.rmSync(tile(missing));
	await assert.rejects(packNav({ dir: missing, cells: 67 }), /^Error: pack: tile 0\/33_32: ENOENT/);
	const truncated = await gridOf(a, b);
	fs.writeFileSync(tile(truncated), fs.readFileSync(tile(truncated)).subarray(0, 100));
	await assert.rejects(packNav({ dir: truncated, cells: 67 }), /^Error: pack: tile 0\/33_32: /);
	const older = await gridOf(a, b);
	const raw = zlib.gunzipSync(fs.readFileSync(tile(older)));
	raw.writeUInt32LE(2, 4); // the tile format's version
	fs.writeFileSync(tile(older), zlib.gzipSync(raw));
	await assert.rejects(packNav({ dir: older, cells: 67 }), /^Error: pack: tile 0\/33_32: nav tile version 2, expected 3 or 4$/);
});
