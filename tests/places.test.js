'use strict';
// `find --kind inn|flight` lists the inns and flight points of travel.json.
// The compiler's check of sethome, hearth, fly and getfp against them is
// forge-guide's (rust/crates/forge-guide/tests/places.rs).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA_DIR, guideText } = require('./helpers/dsl');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics, format } = require('../tools/lib/dsl/diag');
const findCmd = require('../tools/commands/find');

const INNS = [
	{ location: 'Goldshire', names: ['Goldshire'], npc: 295, npcName: 'Innkeeper Farley', map: 1429, x: 43.77, y: 65.8 },
	{ location: 'Thunderbrew Distillery', names: ['Thunderbrew Distillery', 'Kharanos'], npc: 1247, npcName: 'Innkeeper Belm', map: 1426, x: 47.38, y: 52.52 },
	{ location: "Grom'gol Base Camp", names: ["Grom'gol Base Camp"], npc: 5814, npcName: 'Innkeeper Thulbek', map: 1434, x: 31.5, y: 29.8 },
];
const NODES = [
	{ id: 2, name: 'Stormwind, Elwynn', short: 'Stormwind', map: 1453, x: 66.3, y: 62.67, faction: 1, npc: 352, npcName: 'Dungar Longdrink' },
	{ id: 20, name: "Grom'gol, Stranglethorn", short: "Grom'gol", map: 1434, x: 32.54, y: 29.36, faction: 2, npc: 1387, npcName: 'Thysta' },
];

// The test data with a travel.json holding `travel`.
function dataWith(travel) {
	const dir = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(dir, f));
	fs.writeFileSync(path.join(dir, 'travel.json'), `${JSON.stringify(travel)}\n`);
	return { dir, data: loadData(dir) };
}
const full = dataWith({ inns: INNS, taxi: { nodes: NODES } });

test('find --kind inn lists every inn with its innkeeper and coordinates; a text matches any of its names or its zone', async () => {
	const all = await quiet(() => findCmd.run(['--kind', 'inn', '--data', full.dir]));
	assert.equal(all.result, 0, all.out);
	assert.deepEqual(all.out.split('\n'), [
		'sethome "Goldshire"  # Innkeeper Farley (npc 295), Elwynn Forest 43.8,65.8',
		"sethome \"Grom'gol Base Camp\"  # Innkeeper Thulbek (npc 5814), Stranglethorn Vale 31.5,29.8",
		'sethome "Thunderbrew Distillery"  # Innkeeper Belm (npc 1247), Dun Morogh 47.4,52.5',
		'# the game may also report "Kharanos"',
	]);
	const json = await quiet(() => findCmd.run(['kharanos', '--kind', 'inn', '--json', '--data', full.dir]));
	assert.equal(json.result, 0, json.out);
	assert.deepEqual(JSON.parse(json.out), [
		{
			kind: 'inn',
			id: 1247,
			name: 'Thunderbrew Distillery',
			names: ['Thunderbrew Distillery', 'Kharanos'],
			npc: 1247,
			npcName: 'Innkeeper Belm',
			zone: 'Dun Morogh',
			map: 1426,
			x: 47.38,
			y: 52.52,
			line: 'sethome "Thunderbrew Distillery"  # Innkeeper Belm (npc 1247), Dun Morogh 47.4,52.5',
			notes: ['# the game may also report "Kharanos"'],
		},
	]);
	const zone = await quiet(() => findCmd.run(['stranglethorn', '--kind', 'inn', '--data', full.dir]));
	assert.match(zone.out, /^sethome "Grom'gol Base Camp"/);
});

test('find --kind flight lists every flight point with its side, master and coordinates; --faction keeps one side', async () => {
	const all = await quiet(() => findCmd.run(['--kind', 'flight', '--data', full.dir]));
	assert.equal(all.result, 0, all.out);
	assert.deepEqual(all.out.split('\n'), [
		"getfp \"Grom'gol\"  # Grom'gol, Stranglethorn, Horde: Thysta (npc 1387), Stranglethorn Vale 32.5,29.4",
		'getfp "Stormwind"  # Stormwind, Elwynn, Alliance: Dungar Longdrink (npc 352), Stormwind City 66.3,62.7',
	]);
	const json = await quiet(() => findCmd.run(['stormwind', '--kind', 'flight', '--json', '--data', full.dir]));
	assert.deepEqual(JSON.parse(json.out).map((r) => [r.kind, r.id, r.name, r.node, r.faction, r.zone, r.x, r.y]), [['flight', 2, 'Stormwind', 'Stormwind, Elwynn', 'Alliance', 'Stormwind City', 66.3, 62.67]]);
	const horde = await quiet(() => findCmd.run(['--kind', 'flight', '--faction', 'Horde', '--data', full.dir]));
	assert.deepEqual(horde.out.split('\n').map((l) => l.split('  #')[0]), ["getfp \"Grom'gol\""]);
	// Every line parses as a goal.
	for (const line of [...all.out.split('\n'), 'sethome "Goldshire"  # Innkeeper Farley (npc 295), Elwynn Forest 43.8,65.8']) {
		const diag = new Diagnostics();
		parseGuide(`${guideText(['step S', `  ${line}`])}`, 'find.guide', diag);
		assert.deepEqual(diag.errors.map(format), [], line);
	}
	// Without travel.json: the file to build, not "nothing matches".
	const none = await quiet(() => findCmd.run(['--kind', 'flight', '--data', DATA_DIR]));
	assert.equal(none.result, 1);
	assert.match(none.out, /is missing travel\.json/);
});
