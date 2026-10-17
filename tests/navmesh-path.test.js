'use strict';
// Routes on the navigation grid (tools/lib/nav/path.js, move.js) over
// synthetic tiles built by the real build (grid/build.js), and one real
// route when data/local/nav holds a build.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Scene, ADT } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid, liftPoints } = require('../tools/lib/nav/grid/build');
const { openNav } = require('../tools/lib/nav/path');
const { profileFor, RUN, SWIM, REMOUNT, LIFT_WAIT, LIFT_SPEED } = require('../tools/lib/nav/move');
const { Space, MinHeap } = require('../tools/lib/nav/grid/search');
const { CLS, encodeGraph, decodeGraph } = require('../tools/lib/nav/grid/format');

async function navOf(...scenes) {
	const dir = tmpdir('polestar-nav-');
	const byKey = new Map(scenes.map((s) => [`${s.col}_${s.row}`, s]));
	await buildGrid({
		outDir: dir, workers: 0,
		continents: [{ c: 0, name: 'test', tiles: scenes.map((s) => ({ col: s.col, row: s.row })) }],
		geometryJob: (c, t) => ({ geom: byKey.get(`${t.col}_${t.row}`).geom() }),
	});
	return { nav: openNav({ dir }), dir };
}

// Yards of a route's segments of class cls.
function yardsOf(r, cls) {
	let y = 0;
	for (let s = 0; s < r.cls.length; s++) {
		if (r.cls[s] !== cls) continue;
		const o = s * 3;
		y += Math.hypot(r.pts[o + 3] - r.pts[o], r.pts[o + 4] - r.pts[o + 1], r.pts[o + 5] - r.pts[o + 2]);
	}
	return y;
}

const foot = profileFor({ cls: 'Warrior', level: 10 });
const mounted = profileFor({ cls: 'Warrior', level: 60 });

test('profiles: run, mount from level 40, epic at 60, class forms', () => {
	assert.equal(foot.outdoor, RUN);
	assert.equal(profileFor({ level: 40 }).outdoor, RUN * 1.6);
	assert.equal(mounted.outdoor, RUN * 2);
	assert.equal(mounted.indoor, RUN, 'no mount indoors');
	assert.equal(mounted.swim, SWIM, 'mounts do not swim faster');
	assert.equal(profileFor({ cls: 'DRUID', level: 30 }).outdoor, RUN * 1.4);
	assert.equal(profileFor({ cls: 'Druid', level: 16 }).swim, SWIM * 1.5);
	assert.equal(profileFor({ cls: 'Shaman', level: 20 }).indoor, RUN, 'Ghost Wolf is outdoors only');
	assert.equal(profileFor({ cls: 'Hunter', level: 20 }).indoor, RUN * 1.3);
	assert.equal(profileFor({ level: 45, params: { mountLevel: 50 } }).outdoor, RUN);
});

test('routes are optimal on a maze and smoothing only shortens them', async () => {
	const s = new Scene();
	// Walls with alternating gaps: a zigzag through x = 100..400.
	for (let w = 0; w < 5; w++) {
		const x = 100 + w * 60;
		if (w % 2 === 0) s.box(x, 0, -1, x + 4, 440, 12);
		else s.box(x, 60, -1, x + 4, ADT, 12);
	}
	const { nav } = await navOf(s);
	const a = nav.snap(s.world(50, 250));
	const b = nav.snap(s.world(460, 250));
	const r = nav.route(a, b, foot);
	assert.ok(r.ok, r.reason);
	// The cell path's cost equals plain Dijkstra's over the whole tile.
	const cells = nav.search(0, () => true, a, b, foot, Infinity);
	const t = nav.tile(0, 32, 32);
	const space = new Space([t]);
	const dist = new Float64Array(t.n).fill(Infinity);
	const kOf = new Int32Array(t.n);
	const heap = new MinHeap();
	dist[a.entry] = 0;
	kOf[a.entry] = a.cell.j * 256 + a.cell.i;
	heap.push(0, a.entry);
	while (heap.size) {
		const u = heap.pop();
		if (heap.top > dist[u]) continue;
		const cnt = space.expand(0, u, kOf[u], foot);
		for (let x = 0; x < cnt; x++) {
			const v = space.outTo[x];
			if (dist[u] + space.outCost[x] < dist[v]) {
				dist[v] = dist[u] + space.outCost[x];
				kOf[v] = space.outK[x];
				heap.push(dist[v], v);
			}
		}
	}
	assert.ok(Math.abs(cells.C[cells.n - 1] - dist[b.entry]) < 1e-6, `A* ${cells.C[cells.n - 1]} vs Dijkstra ${dist[b.entry]}`);
	assert.ok(r.seconds <= dist[b.entry] + 1e-6 && r.seconds > dist[b.entry] * 0.8, `smoothed ${r.seconds}`);
	// It winds through all five gaps: far longer than the straight line, and every leg is walkable.
	assert.ok(r.yards > 410 + 4 * 300, `yards ${r.yards}`);
	for (let p = 0; p + 3 < r.pts.length; p += 3) {
		assert.ok(nav.los({ c: 0, wx: r.pts[p], wy: r.pts[p + 1], z: r.pts[p + 2] }, { c: 0, wx: r.pts[p + 3], wy: r.pts[p + 4], z: r.pts[p + 5] }), `leg ${p / 3}`);
	}
	assert.equal(nav.los(a, b), false);
});

test('swimming: mounts do not swim, the swim leg runs at swim speed', async () => {
	// A lake across the middle with a land bridge far to the south.
	const s = new Scene({ height: (x, y) => (x > 150 && x < 350 && y < 440 ? -6 : 0) });
	s.water(150, 0, 350, 440, 0, 1);
	const { nav } = await navOf(s);
	const a = s.world(100, 100);
	const b = s.world(400, 100);
	const onFoot = nav.route(a, b, foot);
	assert.ok(onFoot.ok, onFoot.reason);
	assert.ok(onFoot.byClass.swim > 0, 'on foot it swims straight across');
	const swimYards = yardsOf(onFoot, CLS.SWIM);
	assert.ok(Math.abs(onFoot.byClass.swim - swimYards / SWIM) < 0.05 * onFoot.byClass.swim + 0.5, `${onFoot.byClass.swim} s for ${swimYards} yd`);
	const epic = nav.route(a, b, mounted);
	assert.ok(epic.ok, epic.reason);
	const epicSwim = yardsOf(epic, CLS.SWIM);
	if (epicSwim > 0) assert.ok(Math.abs(epic.byClass.swim - epicSwim / SWIM) < 0.05 * epic.byClass.swim + 0.5, 'mounted swimming is swim speed');
	assert.ok(epic.seconds < onFoot.seconds);
});

test('open sea: fatigue water (MH2O deep) is never swum; the coast, shallow sea, still is', async () => {
	// A strait of ocean across the tile (x 150..350, sea bed 6 yd down): deep in the middle 100 yd, or not at all.
	const sea = (deep) => {
		const s = new Scene({ height: (x) => (x > 150 && x < 350 ? -6 : 0) });
		s.water(150, 0, 350, ADT, 0, 2);
		if (deep) s.water(200, 0, 300, ADT, 0, 2, true);
		return s;
	};
	const open = sea(true);
	const { nav, dir } = await navOf(open);
	const r = nav.route(open.world(100, 250), open.world(400, 250), foot);
	assert.equal(r.ok, false, 'no way across the open sea');
	const near = nav.route(open.world(100, 250), open.world(175, 250), foot);
	assert.ok(near.ok && near.byClass.swim > 0, 'a swim near the coast');
	const { decodeTile, FLAG } = require('../tools/lib/nav/grid/format');
	const t = decodeTile(fs.readFileSync(path.join(dir, 'tiles', '0', '32_32.nav.gz')));
	const k = 120 * 256 + 120; // x 251, y 251: deep
	assert.equal(t.flags[t.first[k]] & (FLAG.SWIM | FLAG.BLOCKED), FLAG.SWIM | FLAG.BLOCKED, 'fatigue water is a blocked swim surface');
	const shallow = sea(false);
	const across = (await navOf(shallow)).nav.route(shallow.world(100, 250), shallow.world(400, 250), foot);
	assert.ok(across.ok && across.byClass.swim > 0, 'the same strait without fatigue is swum');
});

test('indoors: no mount speed, a remount on the way out', async () => {
	const s = new Scene({ height: () => 0 });
	// A long indoor floor (WMO indoor) raised half a yard, walled along both sides.
	s.floor(100, 240, 400, 260, 0.5, 2);
	s.box(100, 236, -1, 400, 240, 8).box(100, 260, -1, 400, 264, 8);
	s.box(96, 0, -1, 100, 236, 8).box(96, 264, -1, 100, ADT, 8).box(400, 0, -1, 404, 236, 8).box(400, 264, -1, 404, ADT, 8);
	const { nav } = await navOf(s);
	const a = s.world(60, 250);
	const b = s.world(440, 250);
	const r = nav.route(a, b, mounted);
	assert.ok(r.ok, r.reason);
	const indoorYards = yardsOf(r, CLS.INDOOR);
	assert.ok(indoorYards > 280, `indoor ${indoorYards} yd`);
	assert.ok(Math.abs(r.byClass.indoor - (indoorYards / RUN + REMOUNT)) < 1, `indoor ${r.byClass.indoor} s`);
});

test('falls: down one way with their damage, never back up', async () => {
	// A model plateau (top 20) in the west, sheer on every side, ground below.
	const s = new Scene();
	s.box(50, 50, -1, 150, 150, 20);
	const { nav } = await navOf(s);
	const top = s.world(100, 100, 20); // on top (the box hides a pocket of ground inside)
	const ground = s.world(400, 100);
	const down = nav.route(top, ground, foot);
	assert.ok(down.ok, down.reason);
	assert.equal(down.falls.length, 1);
	assert.ok(down.falls[0].h > 17 && down.falls[0].h < 21, `fall ${down.falls[0].h}`);
	assert.ok(Math.abs(down.falls[0].damage - (0.018 * down.falls[0].h - 0.2426)) < 0.002);
	assert.ok(down.byClass.fall > 1, 'a fall costs its second plus the health');
	const up = nav.route(ground, top, foot);
	assert.equal(up.ok, false);
	assert.equal(up.reason, 'no path');
});
test('lifts: an elevator joins a mesa top to the ground both ways, landing where its car rises to, not on the shaft roof', async () => {
	// A sheer mesa (top 60) with an elevator spawn at its east edge, under a
	// shaft roof at 75 that is higher than the top landing.
	const s = new Scene();
	s.box(50, 50, -1, 250, 450, 60);
	s.floor(248, 244, 260, 256, 75, 1);
	const dir = tmpdir('polestar-nav-');
	const spawn = s.world(253, 250);
	await buildGrid({
		outDir: dir, workers: 0, continents: [{ c: 0, name: 'test', tiles: [{ col: 32, row: 32 }] }],
		geometryJob: () => ({ geom: s.geom() }), liftPoints: [{ ...spawn, name: 'Mesa Elevator', id: 1, rise: 60.4 }],
	});
	const nav = openNav({ dir });
	const lifts = JSON.parse(fs.readFileSync(path.join(dir, 'lifts.json'), 'utf8'))[0];
	assert.equal(lifts.length, 1);
	assert.ok(Math.abs(lifts[0].h - 60) < 1, `rise ${lifts[0].h}`);
	assert.ok(Math.abs(lifts[0].b.z - 60) < 1, `top landing ${lifts[0].b.z}, not the roof`);
	const top = s.world(150, 250, 60);
	const ground = s.world(400, 250);
	const down = nav.route(top, ground, foot);
	assert.ok(down.ok, down.reason);
	assert.ok([...down.cls].includes(CLS.LIFT), 'rides the lift down');
	assert.ok(Math.abs(down.byClass.lift - (LIFT_WAIT + 60 / LIFT_SPEED)) < 1, `lift ${down.byClass.lift} s`);
	const up = nav.route(ground, top, foot);
	assert.ok(up.ok && [...up.cls].includes(CLS.LIFT), 'and up');
});

test('lift points: objects the client animates as transports rising at least LIFT_MIN, not signs or doors', () => {
	const geo = { toWorld: (map, x, y) => ({ c: 0, wx: x, wy: y }) };
	const spawn = (x, y) => ({ 1: { f: 'e', pts: [[x, y]] } });
	const objects = [
		{ id: 1, name: 'Mesa Elevator', spawns: spawn(10, 20) },
		{ id: 2, name: 'Elevator to Mulgore', spawns: spawn(30, 40) },
		{ id: 3, name: 'lowerLdoor', spawns: spawn(50, 60) },
		{ id: 4, name: 'Vator', spawns: spawn(70, 80) },
		{ id: 5, name: 'Ferry', spawns: spawn(90, 10) },
	];
	const travel = new Map([[1, { rise: 61.2, sway: 0 }], [3, { rise: 8.1, sway: 0 }], [4, { rise: 100, sway: 0 }], [5, { rise: 20, sway: 300 }]]);
	const pts = liftPoints(objects, geo, travel);
	assert.deepEqual(pts.map((p) => [p.id, p.rise, p.wx, p.wy]), [[1, 61.2, 10, 20], [4, 100, 70, 80]]);
});


test('regions: an enclosure no fall reaches is unreachable without a search', async () => {
	const s = new Scene();
	s.box(100, 100, -1, 200, 104, 40).box(100, 196, -1, 200, 200, 40).box(100, 100, -1, 104, 200, 40).box(196, 100, -1, 200, 200, 40);
	const { nav } = await navOf(s);
	const r = nav.route(s.world(50, 50), s.world(150, 150), foot);
	assert.equal(r.ok, false);
	assert.equal(r.reason, 'different regions');
});

test('snap: without a height an indoor floor beats the hill above it', async () => {
	// A hill (terrain at 30) over a cave floor (WMO indoor at 0), the cave open to the east.
	const s = new Scene({ height: (x, y) => (x > 100 && x < 300 && y > 100 && y < 300 ? 30 : 0) });
	s.floor(150, 150, 400, 250, 0.2, 2).box(150, 146, 0.2, 300, 150, 30).box(150, 250, 0.2, 300, 254, 30);
	const { nav } = await navOf(s);
	const p = s.world(200, 200);
	assert.ok(nav.snap(p).flags & 8, 'indoor first');
	assert.ok(Math.abs(nav.snap(p).z - 0.2) < 0.01);
	assert.equal(nav.snap({ ...p, prefer: 'ground' }).z, 30);
	assert.equal(nav.snap({ ...p, z: 28 }).z, 30);
	assert.ok(Math.abs(nav.snap({ ...p, z: 1 }).z - 0.2) < 0.01);
	assert.ok(nav.snap({ ...s.world(20, 20), prefer: 'indoor' }) && !(nav.snap({ ...s.world(20, 20), prefer: 'indoor' }).flags & 8), 'no indoor floor in reach: ground');
});

test('snap: without a height a point over an indoor floor takes that floor, not a roof over it, the terrain under it or a storey below', async () => {
	// A city floor (WMO indoor) at 0 over terrain at -40, with a roof at 30
	// over a pillar from 1 to 29 (the floor under the pillar is blocked by
	// its clearance, the pillar top by the roof), a closed room, and a pocket
	// floor at -20 under the city floor.
	const s = new Scene({ height: () => -40 });
	s.floor(50, 50, 450, 450, 0);
	s.box(200.5, 200.5, 1, 201.5, 201.5, 29, 2).floor(150, 150, 250, 250, 30);
	s.box(350, 350, 0, 350.5, 370, 5, 2).box(369.5, 350, 0, 370, 370, 5, 2).box(350, 350, 0, 370, 350.5, 5, 2).box(350, 369.5, 0, 370, 370, 5, 2);
	s.floor(100, 100, 106, 106, -20);
	const { nav } = await navOf(s);
	const near = (p, z) => Math.abs(p.z - z) < 0.05;
	const pillar = nav.snap(s.world(201, 201));
	assert.ok(near(pillar, 0) && pillar.flags & 8, `under the roof: the floor, not the roof (z ${pillar.z})`);
	const roomAt = s.world(360, 360);
	const room = nav.snap(roomAt);
	assert.ok(near(room, 0), `in the closed room: the floor beside it, not the terrain (z ${room.z})`);
	assert.ok(Math.hypot(room.wx - roomAt.wx, room.wy - roomAt.wy) > 9, 'outside the room\'s walls');
	assert.ok(near(nav.snap(s.world(103, 103)), 0), 'over a pocket a storey below: the floor');
	assert.ok(near(nav.snap(s.world(300, 120)), 0), 'the open floor');
	assert.ok(near(nav.snap({ ...s.world(201, 201), z: 29 }), 30), 'with a height: the surface nearest in 3D');
});

test('long routes cross tiles through the abstract graph', async () => {
	const tiles = [32, 33, 34].map((col) => new Scene({ col }));
	// A wall across the middle tile from the north edge to y = 450.
	tiles[1].box(250, 0, -1, 254, 450, 15);
	const { nav, dir } = await navOf(...tiles);
	const a = tiles[0].world(100, 100);
	const b = tiles[2].world(400, 100);
	const r = nav.route(a, b, foot);
	assert.ok(r.ok, r.reason);
	assert.ok(r.tiles >= 3);
	// Round the wall's south end.
	let south = 0;
	for (let p = 0; p < r.pts.length; p += 3) south = Math.max(south, tiles[0].north - r.pts[p]);
	assert.ok(south > 450, `reaches y ${south}`);
	const straight = Math.hypot(a.wx - b.wx, a.wy - b.wy);
	assert.ok(r.yards > straight + 100 && r.yards < straight + 400, `yards ${r.yards}`);
	// The graph file round-trips.
	const g = nav.graph(0);
	const back = decodeGraph(encodeGraph(g));
	assert.deepEqual([...back.nodeEntry], [...g.nodeEntry]);
	assert.deepEqual([...back.graphs[1].terms], [...g.graphs[1].terms]);
	assert.ok(fs.existsSync(path.join(dir, 'index.json')));
});

test('abstract graph: slope links cost their yards, no lift ride, so the graph prices a route as it is walked', async () => {
	// Rolling hills (gradients to about 45°) over two tiles: many LINK_SLOPE links, no lift.
	const height = (x, y) => Math.sin(x / 12) * 9 + Math.cos(y / 15) * 6;
	const tiles = [32, 33].map((col) => new Scene({ col, height }));
	const { nav } = await navOf(...tiles);
	const g = nav.graph(0);
	for (const gr of g.graphs) for (let x = 6; x < gr.terms.length; x += 7) assert.equal(gr.terms[x], 0, 'no lift seconds');
	const A = nav.snap(tiles[0].world(60, 250));
	const B = nav.snap(tiles[1].world(450, 260));
	const abs = nav.abstractPath(0, A, B, foot);
	const r = nav.route(A, B, foot);
	assert.ok(r.ok, r.reason);
	assert.ok(Math.abs(r.seconds - abs.seconds) < 0.05 * abs.seconds, `route ${r.seconds.toFixed(1)} s, graph ${abs.seconds.toFixed(1)} s`);
});

const NAV = path.join(__dirname, '..', 'data', 'local', 'nav');
const navIndex = fs.existsSync(path.join(NAV, 'index.json')) ? JSON.parse(fs.readFileSync(path.join(NAV, 'index.json'), 'utf8')) : null;
const realSkip = !navIndex ? 'no navigation build in data/local/nav (node tools/polestar.js nav build)' : !require('../tools/lib/nav/grid/format').TILE_VERSIONS.includes(navIndex.version) ? `data/local/nav is tile version ${navIndex.version}: rebuild it (node tools/polestar.js nav build)` : false;

test('real: Kharanos to inside Frostmane Hold goes through the cave mouth, not over the hills', { skip: realSkip }, () => {
	const nav = openNav({ dir: NAV });
	// Dun Morogh (uiMap 1426, Era frame): Kharanos 46.7,53.0 -> inside Frostmane Hold 23.0,52.5.
	const kharanos = { c: 0, wx: -5617.25, wy: -497.89 };
	const hold = { c: 0, wx: -5600.83, wy: 669.33 };
	const r = nav.route(kharanos, hold, foot);
	assert.ok(r.ok, r.reason);
	assert.ok(r.to.flags & 8, 'the end is inside the cave');
	// Walking over the hills means climbing them: the route never rises far
	// above its end points' level, and it walks a stretch indoors at the end.
	let maxZ = -Infinity;
	for (let p = 2; p < r.pts.length; p += 3) maxZ = Math.max(maxZ, r.pts[p]);
	assert.ok(maxZ < Math.max(r.from.z, r.to.z) + 60, `highest point ${maxZ.toFixed(1)}`);
	assert.ok(r.byClass.indoor > 5, `indoors ${r.byClass.indoor} s`);
	assert.ok(r.yards < 1.6 * Math.hypot(kharanos.wx - hold.wx, kharanos.wy - hold.wy));
});

test('real: Thunder Bluff center to the Mulgore lift base takes the Mesa Elevator, with no fall', { skip: realSkip }, () => {
	const nav = openNav({ dir: NAV });
	// Thunder Bluff (uiMap 1456) 50,50 -> Mulgore (1412) 37.5,33, Era frames.
	const r = nav.route({ c: 1, wx: -1197.92, wy: -5.21 }, { c: 1, wx: -1403.17, wy: 121.35 }, foot);
	assert.ok(r.ok, r.reason);
	assert.ok([...r.cls].includes(CLS.LIFT), 'rides a lift');
	assert.ok(Math.abs(r.byClass.lift - (LIFT_WAIT + 61.4 / LIFT_SPEED)) < 2, `lift ${r.byClass.lift.toFixed(1)} s`);
	assert.equal(r.falls.length, 0, `falls ${JSON.stringify(r.falls)}`);
});

test('real: Kharanos to Thelsamar costs no more than through the South Gate tunnel', { skip: realSkip }, () => {
	const nav = openNav({ dir: NAV });
	// Dun Morogh (1426) 46.7,53.0 -> Loch Modan (1432) 35,47, via the tunnel mouths 1426 80.15,52.59 and 1432 22.34,70.01 (Era frames).
	const pts = [{ c: 0, wx: -5617.25, wy: -497.89 }, { c: 0, wx: -5603.79, wy: -2145.3 }, { c: 0, wx: -5775.39, wy: -2609.96 }, { c: 0, wx: -5352.1, wy: -2959.17 }];
	const direct = nav.route(pts[0], pts[3], foot);
	assert.ok(direct.ok, direct.reason);
	let via = 0;
	for (let i = 0; i < 3; i++) {
		const leg = nav.route(pts[i], pts[i + 1], foot);
		assert.ok(leg.ok, leg.reason);
		via += leg.seconds;
	}
	assert.ok(direct.seconds <= via, `direct ${direct.seconds.toFixed(1)} s, via the tunnel ${via.toFixed(1)} s`);
});

// The least distance from (wx, wy) to a route's polyline.
function distTo(r, wx, wy) {
	let best = Infinity;
	for (let p = 0; p + 3 < r.pts.length; p += 3) {
		const ax = r.pts[p], ay = r.pts[p + 1], bx = r.pts[p + 3], by = r.pts[p + 4];
		const L2 = (bx - ax) ** 2 + (by - ay) ** 2;
		const u = L2 ? Math.max(0, Math.min(1, ((wx - ax) * (bx - ax) + (wy - ay) * (by - ay)) / L2)) : 0;
		best = Math.min(best, Math.hypot(ax + u * (bx - ax) - wx, ay + u * (by - ay) - wy));
	}
	return best;
}

test('real: the Ruins of Lordaeron to the Trade Quarter ride an Undervator down from the throne room', { skip: realSkip }, () => {
	const nav = openNav({ dir: NAV });
	// Tirisfal Glades (1420) 65.0,60.5 -> Undercity (1458) 66.2,37.8, Era frames.
	const r = nav.route({ c: 0, wx: 2014.94, wy: 96.15 }, { c: 0, wx: 1635.99, wy: 238.09 }, foot);
	assert.ok(r.ok, r.reason);
	assert.ok([...r.cls].includes(CLS.LIFT), 'rides a lift');
	// Through the throne room's round hall (the steps down to the lift halls), not the sewers.
	assert.ok(distTo(r, 1640, 240) < 25, `throne room ${distTo(r, 1640, 240).toFixed(0)} yd off`);
	assert.ok(r.yards < 1000, `yards ${r.yards.toFixed(0)} (round by the sewers about 1,700)`);
});

test('real: Razor Hill to the Valley of Strength goes through the Orgrimmar gate', { skip: realSkip }, () => {
	const nav = openNav({ dir: NAV });
	// Durotar (1411) 51.5,41.6 (Razor Hill inn) -> Orgrimmar (1454) 54.1,68.4 (Innkeeper Gryshka), Era frames.
	const r = nav.route({ c: 1, wx: 341.93, wy: -4685.56 }, { c: 1, wx: 1634.05, wy: -4439.41 }, foot);
	assert.ok(r.ok, r.reason);
	assert.ok(Math.abs(r.to.z - 15.5) < 1.5, `the inn's floor, not its roof (z ${r.to.z.toFixed(1)})`);
	// The gate's tunnel (1411 45.5,12 to the valley), not the rocks east of it.
	assert.ok(distTo(r, 1424, -4372) < 15, `gate ${distTo(r, 1424, -4372).toFixed(0)} yd off`);
	assert.equal(r.byClass.climb, 0, `climb ${r.byClass.climb} s`);
});
