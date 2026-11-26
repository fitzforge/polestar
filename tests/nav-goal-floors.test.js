'use strict';
// Guide goals in the capitals at an NPC's or object's floor that the shipped walking maps don't reach
// (tools/lib/nav/eval/goalfloors.js): Zilzibin Drumlore's house in Orgrimmar's Drag had no floor on the maps, and the
// arrow pointed straight at him through the wall (#4146); Gretta Finespindle's shop in Ironforge's Great Forge was not
// joined to the walkway, and the walk went off towards the Mystic Ward (#4133). Every goal with a height in the six
// capitals is walked to from its city's flight master on addon/Polestar_Nav's maps; a goal the walk misses fails the
// test unless KNOWN lists it, and a KNOWN goal the walk now reaches fails it too, so the list only shrinks. A new
// one is a building the maps don't join (a grid join, docs/nav/REPACK.md) or a goal point off its NPC (data/places.json).
//
// Needs data/forever (forge data build) and luajit or lua5.1; skips without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { needs, DATA } = require('./helpers/data');

const ROOT = path.join(__dirname, '..');
const lua = ['luajit', 'lua5.1'].find((b) => spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' }).status === 0);
const skip = needs('map-frames.json', 'zones.json', 'travel.json') || (lua ? false : 'no luajit or lua5.1');

const CAPITALS = new Set([1453, 1454, 1455, 1456, 1457, 1458]);

// "<uiMapID> <x>,<y> <z>: <why>" of the goals the walk still misses, each with what is known of it.
const KNOWN = [
	"1453 49.36,85.92 29.7: Jennea Cannon, in the Wizard's Sanctum's chamber, reached only by its portal (data/crossings.json areas, #1970)",
	"1453 49.68,85.87 29.7: Jennea Cannon, the same chamber",
	'1453 53.82,81.26 97.4: Clavicus Knavingham, up a stair in the Mage Quarter: no floor of the walking maps at his height',
	"1453 79.86,69.94 95.1: Doc Mixilpixil, on SI:7's lower floor: no floor of the walking maps at his height",
	"1454 35.58,87.31 44.1: Ur'kyo, the Darkbriar Lodge: no floor of either map joins the city there (docs/NAV_QA.md, known gaps)",
	'1454 37.93,87.43 43.6: Vehena, the Darkbriar Lodge',
	"1454 38.9,85.96 43: Uthel'nay, the Darkbriar Lodge",
	"1454 39.1,86.19 43: Uthel'nay, the Darkbriar Lodge",
	"1455 18.4,51.48 502: Gwenna Firebrew, the Stonefire Tavern: no stored way through its lower doorway (nav-reported.rs, the ignored Ironforge case)",
	'1455 55.42,58.84 505.9: Reyna Stonebranch: her floor is not joined to the way players walk in by',
	'1457 35.06,9.55 1367: Arch Druid Fandral Staghelm, the top of the Cenarion Enclave\'s druids\' building, off the maps (#1338: the guides walk to its door first)',
];

test('every guide goal with a height in the capitals is walked to on its floor from the city\'s flight master (#4146, #4133)', { skip }, () => {
	const { Geo } = require('../tools/lib/planner/geo');
	const { runQueries } = require('../tools/lib/nav/eval/run');
	const { goalPoints, goalFloorQueries, judgeGoalFloors } = require('../tools/lib/nav/eval/goalfloors');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const geo = new Geo(read('map-frames.json'), read('zones.json'));
	const srcs = [['Polestar_Guides', null], ['Polestar_Guides_Alliance', 'Alliance'], ['Polestar_Guides_Horde', 'Horde']].map(([part, side]) => ({
		src: fs.readFileSync(path.join(ROOT, 'addon', part, 'Guides.lua'), 'utf8'),
		side,
	}));
	const points = goalPoints(srcs, geo, { maps: CAPITALS });
	const { queries, meta } = goalFloorQueries(points, read('travel.json').taxi.nodes, read('travel.json').transit.portals);
	assert.ok(queries.length >= 300, `the capitals' goals with a height were found (${queries.length})`);
	const { results } = runQueries({ navDir: path.join(ROOT, 'addon', 'Polestar_Nav'), queries, lua, warm: true });
	const missed = judgeGoalFloors(results, meta).map((m) => `${m.map} ${m.x},${m.y} ${m.z}`);
	const known = KNOWN.map((k) => k.split(':')[0]);
	assert.deepEqual(missed.filter((m) => !known.includes(m)), [], 'goals the walk misses (new): see the head of this file');
	assert.deepEqual(known.filter((k) => !missed.includes(k)), [], 'KNOWN goals the walk reaches now: take them off the list');
});
