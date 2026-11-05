'use strict';
// The arrow's aids from the navigation grid (tools/lib/nav/aids.js) on
// synthetic tiles built by the real grid build: a ridge with a tunnel, an
// open plain, a cave; captions, ids and the crossings schema. Two zones
// split the tile at its middle chunk line (x = 266.7 yd): West Vale (area
// 101) and East Ridge (area 102).

const test = require('node:test');
const assert = require('node:assert/strict');
const { Scene, ADT, QUAD } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid } = require('../tools/lib/nav/grid/build');
const { openNav } = require('../tools/lib/nav/path');
const { Frames } = require('../tools/lib/travel/geo');
const { validateCrossings } = require('../tools/lib/travel/crossings');
const { generateAids, zoneResolver, slug } = require('../tools/lib/nav/aids');

const WEST = 9001;
const EAST = 9002;
const zones = {
	[WEST]: { id: WEST, name: 'West Vale', areaId: 101, parent: null, type: 3 },
	[EAST]: { id: EAST, name: 'East Ridge', areaId: 102, parent: null, type: 3 },
};
const frame = { c: 0, left: 0, right: -ADT, top: 0, bottom: -ADT }; // tile (32, 32): x% = local x / ADT, y% = local y / ADT
const frames = new Frames({ [WEST]: frame, [EAST]: frame }, zones);
// Area 1011 (a subzone of West Vale) shows the ParentAreaID walk.
const zoneOfArea = zoneResolver({ zones, areaRows: [{ ID: '101', ParentAreaID: '0' }, { ID: '102', ParentAreaID: '0' }, { ID: '1011', ParentAreaID: '101' }], frames });

// Chunk areas: west half West Vale (its northern row the subzone), east half East Ridge; or one zone.
const split = () => {
	const a = new Uint16Array(256);
	for (let cy = 0; cy < 16; cy++) for (let cx = 0; cx < 16; cx++) a[cy * 16 + cx] = cx < 8 ? (cy === 0 ? 1011 : 101) : 102;
	return a;
};
const single = () => new Uint16Array(256).fill(101);

async function navOf(s, areas) {
	const dir = tmpdir('polestar-aids-');
	await buildGrid({
		outDir: dir, workers: 0,
		continents: [{ c: 0, name: 'test', tiles: [{ col: s.col, row: s.row }] }],
		geometryJob: () => ({ geom: { ...s.geom(), areas: areas() } }),
	});
	return openNav({ dir });
}

const local = (p) => ({ x: (-p.wy / ADT) * 100, y: (-p.wx / ADT) * 100 }); // world -> map percent of the test frame

test('zones: an area walks up ParentAreaID to the zone map naming it', () => {
	assert.equal(zoneOfArea(0, 1011), WEST);
	assert.equal(zoneOfArea(0, 102), EAST);
	assert.equal(zoneOfArea(0, 999), null);
	assert.equal(zoneOfArea(1, 101), null, 'a zone map of another continent');
	assert.equal(slug("Un'Goro Crater -- Silithus"), 'ungoro-crater-silithus');
});

test('a ridge with a tunnel: one crossing through it, captioned as a tunnel, valid', async () => {
	// A ridge (WMO, top 30) along the border, cut by a 12 yd tunnel (indoor floor, roof at 4).
	const s = new Scene();
	s.box(250, 0, -1, 283, 250, 30).box(250, 262, -1, 283, ADT, 30).box(250, 250, 4, 283, 262, 30);
	s.floor(240, 250, 293, 262, 0.5, 2);
	const nav = await navOf(s, split);
	const { doc, stats } = await generateAids({ nav, frames, zoneOfArea, continents: [0] });
	assert.deepEqual(stats.errors, []);
	assert.equal(doc.open.length, 0, 'the ridge is not open ground');
	assert.equal(doc.crossings.length, 1, JSON.stringify(doc.crossings));
	const x = doc.crossings[0];
	assert.equal(x.id, 'west-vale--east-ridge');
	assert.equal(x.a.map, WEST);
	assert.equal(x.b.map, EAST);
	assert.equal(x.ab, 'Walk through the tunnel to East Ridge');
	assert.equal(x.ba, 'Walk through the tunnel to West Vale');
	assert.equal(x.oneWay, undefined);
	// The ends lie 25-60 yd inside each zone, by the tunnel's mouth; the radius is half its width.
	assert.ok(x.a.x * ADT / 100 < 266.7 - 20 && x.a.x * ADT / 100 > 266.7 - 70, `a at x ${x.a.x}%`);
	assert.ok(x.b.x * ADT / 100 > 266.7 + 20 && x.b.x * ADT / 100 < 266.7 + 70, `b at x ${x.b.x}%`);
	for (const end of [x.a, x.b]) assert.ok(Math.abs((end.y * ADT) / 100 - 256) < 8, `end on the tunnel's line (y ${(end.y * ADT) / 100})`);
	assert.ok(x.a.radius >= 3 && x.a.radius <= 10, `radius ${x.a.radius}`);
	// The whole document is a valid crossings file (schema 1, Era frame, source and build).
	assert.equal(doc.schema, 1);
	assert.equal(doc.frame, 'e');
	assert.ok(doc.source);
	assert.deepEqual(validateCrossings(JSON.parse(JSON.stringify(doc)), frames).errors, []);
});

test('an open plain: the zones are an open pair, no crossings', async () => {
	const s = new Scene();
	const nav = await navOf(s, split);
	const { doc, stats } = await generateAids({ nav, frames, zoneOfArea, continents: [0] });
	assert.deepEqual(stats.errors, []);
	assert.deepEqual(doc.open, [{ a: WEST, b: EAST }]);
	assert.equal(doc.crossings.length, 0);
});

test('a cave: a chain from its mouth to the target inside, merged for two targets', async () => {
	// A sheer hill (terrain at 40, x 200-400, y 150-400) with a cave under it:
	// a corridor in from the west face (holed there) to a chamber.
	const inHill = (x, y) => x >= 200 && x <= 400 && y >= 150 && y <= 400;
	const s = new Scene({
		height: (x, y) => (inHill(x, y) ? 40 : 0),
		hole: (x, y) => x > 200 - QUAD && x < 200 + QUAD && y > 256 && y < 276,
	});
	s.floor(180, 260, 330, 272, 0.5, 2).floor(330, 240, 370, 300, 0.5, 2);
	const nav = await navOf(s, single);
	const deep = { ...s.world(355, 285), map: WEST, name: 'Cave Boss', kind: 'goal' };
	const near = { ...s.world(340, 266), map: WEST, name: 'Cave Chest', kind: 'goal' };
	const open = { ...s.world(100, 100), map: WEST, name: 'Field', kind: 'goal' };
	const { doc, stats } = await generateAids({ nav, frames, zoneOfArea, targets: [{ c: 0, ...deep }, { c: 0, ...near }, { c: 0, ...open }], continents: [0] });
	assert.deepEqual(stats.errors, []);
	assert.equal(stats.continents[0].pockets, 2, JSON.stringify(stats.continents[0].notPockets));
	assert.equal(doc.chains.length, 1, 'one cave, one chain');
	const ch = doc.chains[0];
	assert.equal(ch.id, 'west-vale-cave-boss');
	assert.equal(ch.name, 'Cave Boss');
	assert.equal(ch.open, 'mouth');
	const [mouth, ...rest] = ch.nodes;
	assert.equal(mouth.caption, 'Enter the cave');
	assert.equal(mouth.back, 'Leave the cave');
	for (const n of rest) assert.equal(n.caption, 'Follow the path');
	// The mouth is at the corridor's entrance, outside the hill; the last node at the deepest target.
	const m = { x: (mouth.x * ADT) / 100, y: (mouth.y * ADT) / 100 };
	assert.ok(m.x < 215 && m.x > 120 && Math.abs(m.y - 266) < 25, `mouth at ${m.x}, ${m.y}`);
	const last = rest[rest.length - 1];
	const lp = { x: (last.x * ADT) / 100, y: (last.y * ADT) / 100 };
	assert.ok(Math.hypot(lp.x - 355, lp.y - 285) < 10, `last node at ${lp.x}, ${lp.y}`);
	// Every target in the cave is within the planner's capture of a node past the mouth.
	const nearL = local(near);
	assert.ok(rest.some((n) => Math.hypot(((n.x - nearL.x) * ADT) / 100, ((n.y - nearL.y) * ADT) / 100) <= Math.max(2 * n.radius, 30)), 'the chest is inside the chain');
	assert.deepEqual(validateCrossings(JSON.parse(JSON.stringify(doc)), frames).errors, []);
});

test('pocket tests in worker threads give what one thread gives', async () => {
	const inHill = (x, y) => x >= 200 && x <= 400 && y >= 150 && y <= 400;
	const s = new Scene({
		height: (x, y) => (inHill(x, y) ? 40 : 0),
		hole: (x, y) => x > 200 - QUAD && x < 200 + QUAD && y > 256 && y < 276,
	});
	s.floor(180, 260, 330, 272, 0.5, 2).floor(330, 240, 370, 300, 0.5, 2);
	const nav = await navOf(s, single);
	const targets = [];
	for (let x = 20; x < 180; x += 18) for (let y = 20; y < 500; y += 50) targets.push({ c: 0, ...s.world(x, y), map: WEST, name: `Field ${x} ${y}`, kind: 'goal' });
	targets.push({ c: 0, ...s.world(355, 285), map: WEST, name: 'Cave Boss', kind: 'goal' });
	const one = await generateAids({ nav, frames, zoneOfArea, targets, continents: [0] });
	const many = await generateAids({ nav: openNav({ dir: nav.dir }), frames, zoneOfArea, targets, continents: [0], workers: 2 });
	assert.ok(targets.length >= 80, 'enough targets for the threads');
	assert.deepEqual(many.doc.chains, one.doc.chains);
	assert.deepEqual(many.stats.continents[0].notPockets, one.stats.continents[0].notPockets);
	assert.equal(one.doc.chains.length, 1);
});

test('nav aids writes aids.json in its grid\'s folder: --dir without --out never overwrites data/local/nav/aids.json', () => {
	const path = require('node:path');
	const nav = require('../tools/commands/nav');
	const { ROOT } = require('../tools/lib/paths');
	const dir = tmpdir('polestar-nav-aids-');
	assert.equal(nav.aidsOut({ dir }), path.join(dir, 'aids.json'));
	assert.equal(nav.aidsOut({}), path.join(ROOT, 'data', 'local', 'nav', 'aids.json'));
	assert.equal(nav.aidsOut({ dir, out: path.join(dir, 'x.json') }), path.join(dir, 'x.json'));
});
