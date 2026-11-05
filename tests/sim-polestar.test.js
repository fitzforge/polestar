'use strict';
// Polestar route extractor (docs/legacy/SIMULATION-js.md §5) on a synthetic sample in
// tests/fixtures/sim/polestar: invented guide names and ids.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');

const { loadPolestarRoutes } = require('../tools/lib/sim/baselines/polestar');

const FIX = path.join(__dirname, 'fixtures', 'sim');
const GUIDES = path.join(FIX, 'polestar', 'guides');
const DATA = path.join(FIX, 'polestar', 'data');

const ids = (seq, t) => seq.events.filter((e) => e.t === t).map((e) => e.q);

const routes = (opts) => loadPolestarRoutes({ guidesDir: GUIDES, dataDir: DATA, race: 'Orc', ...opts });

test('polestar: default route, conditions and missing quests', () => {
	const r = routes();
	const def = r.default;
	assert.equal(def.source, 'polestar');
	assert.deepEqual(
		def.guides.map((g) => [g.id, g.file]),
		[
			['forever/horde/orc/01-start', 'forever/horde/orc/01-start.guide'],
			['forever/horde/02-north', 'forever/horde/02-north.guide'],
			['forever/horde/03-end', 'forever/horde/03-end.guide'],
		],
	);
	assert.deepEqual(
		def.events.map((e) => (e.t === 'guide' ? { t: 'guide', title: e.title, zone: e.zone, levels: e.levels } : e)),
		[
			{ t: 'guide', title: 'Start', zone: 'Testvale', levels: [1, 5] },
			{ t: 'accept', q: 90001 },
			{ t: 'complete', q: 90001, obj: 1 }, // kill + collect for one objective: once
			{ t: 'accept', q: 90003 }, // `only !Druid` kept with the class unknown; `only Warlock` dropped
			{ t: 'turnin', q: 90001 },
			{ t: 'level', level: 3, xp: null },
			{ t: 'guide', title: 'North', zone: 'Testvale', levels: [5, 8] },
			{ t: 'accept', q: 90010 },
			{ t: 'turnin', q: 90010 },
			{ t: 'guide', title: 'End', zone: 'Testvale', levels: [8, 10] },
			{ t: 'accept', q: 90030 },
			{ t: 'level', level: 10, xp: null },
		],
	);
	assert.deepEqual(def.missing, [90030]); // fixture quests.json lacks it

	assert.deepEqual(ids(routes({ cls: 'Warlock' }).default, 'accept'), [90001, 90002, 90003, 90010, 90030]);
	assert.deepEqual(ids(routes({ cls: 'Druid' }).default, 'accept'), [90001, 90010, 90030]);
	assert.equal(routes({ race: 'Skyborne', faction: 'Horde' }), null);
});

test('polestar: every path through the route choices, and the graph', () => {
	const r = routes();
	assert.equal(r.mode, 'all');
	assert.deepEqual(
		r.variants.map((v) => [v.label, v.sequence.guides.map((g) => g.id)]),
		[
			['default', ['forever/horde/orc/01-start', 'forever/horde/02-north', 'forever/horde/03-end']],
			['02-south@01-start', ['forever/horde/orc/01-start', 'forever/horde/02-south', 'forever/horde/03-end']],
			[
				'02-south@01-start + 02-north@02-south',
				['forever/horde/orc/01-start', 'forever/horde/02-south', 'forever/horde/02-north', 'forever/horde/03-end'],
			],
		],
	);
	assert.deepEqual(r.variants[2].choices, [
		{ from: 'forever/horde/orc/01-start', to: 'forever/horde/02-south' },
		{ from: 'forever/horde/02-south', to: 'forever/horde/02-north' },
	]);
	assert.equal(r.variants[0].sequence, r.default);
	assert.deepEqual(
		r.graph.nodes.map((n) => [n.id, n.levels]),
		[
			['forever/horde/orc/01-start', [1, 5]],
			['forever/horde/02-north', [5, 8]],
			['forever/horde/02-south', [5, 8]],
			['forever/horde/03-end', [8, 10]],
		],
	);
	assert.deepEqual(r.graph.edges, [
		{ from: 'forever/horde/orc/01-start', to: 'forever/horde/02-north', default: true },
		{ from: 'forever/horde/orc/01-start', to: 'forever/horde/02-south', default: false },
		{ from: 'forever/horde/02-north', to: 'forever/horde/03-end', default: true },
		{ from: 'forever/horde/02-south', to: 'forever/horde/03-end', default: true },
		{ from: 'forever/horde/02-south', to: 'forever/horde/02-north', default: false },
	]);

	// Above the path cap: the default route plus one changed choice each.
	const capped = routes({ maxPaths: 2 });
	assert.equal(capped.mode, 'single-change');
	assert.deepEqual(
		capped.variants.map((v) => [v.label, v.sequence.guides.map((g) => g.id)]),
		[
			['default', ['forever/horde/orc/01-start', 'forever/horde/02-north', 'forever/horde/03-end']],
			['02-south@01-start', ['forever/horde/orc/01-start', 'forever/horde/02-south', 'forever/horde/03-end']],
		],
	);
});
