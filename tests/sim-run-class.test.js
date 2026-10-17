'use strict';
// `sim run --class` and `sim robust --class` (docs/SIMULATION.md §5) take the
// class in any case, as compare and bench do: as typed, `priest` missed
// CLASS_BITS and every class quest dropped out of the search.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const sim = require('../tools/lib/sim');
const { run } = require('../tools/commands/sim');
const robust = require('../tools/lib/sim/robust');

test('sim run passes the class on in the model\'s own case', async () => {
	const seen = [];
	const saved = sim.runCharacter;
	sim.runCharacter = async (o) => {
		seen.push(o.cls);
		throw new Error('stop here');
	};
	try {
		await quiet(() => run(['run', '--faction', 'Alliance', '--race', 'Dwarf', '--class', 'priest']));
	} finally {
		sim.runCharacter = saved;
	}
	assert.deepEqual(seen, ['Priest']);
});

test('sim run and sim robust refuse a name that is not a class', async () => {
	for (const cmd of ['run', 'robust']) {
		const { result, out } = await quiet(() => run([cmd, '--faction', 'Horde', '--race', 'Orc', '--class', 'Cleric']));
		assert.equal(result, 2, out);
		assert.match(out, new RegExp(`sim ${cmd}: --class must be one of`));
	}
});

test('sim robust --class mage reads the Mage result and scores it as a Mage', async () => {
	const root = tmpdir('polestar-sim-');
	const dirs = syn.writeDataDir(root);
	const o = { ...dirs, offline: true, extraStarts: syn.START, log: () => {} };
	await sim.runCharacter({ ...o, faction: 'Horde', race: 'Orc', cls: 'Mage', paths: 300, seed: 9, jobsPerRound: 2, constructions: 1, anneal: 50, workers: 1, benchMs: 0, bandWidth: 2 });

	const { result, out } = await quiet(() => robust.command({ faction: 'Horde', race: 'Orc', class: 'mage', draws: 40, top: 3, workers: 1 }, o));
	assert.equal(result, 0, out);
	assert.match(out, /robustness Horde Orc \(Mage, solo\)/);
	const doc = JSON.parse(fs.readFileSync(path.join(dirs.simDir, 'results', 'horde-orc-mage-robust.json'), 'utf8'));
	assert.equal(doc.class, 'Mage');
});
