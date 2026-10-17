'use strict';
// `sim compare --class` (docs/SIMULATION.md §5, §6) on the synthetic world
// (tests/fixtures/sim/synthetic.js): a chain's `only <Class>` goals and the
// class's own quests are scored only when a class is named, and the run writes
// its own files so the class-agnostic ones are left alone.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { compareCommand, benchCommand } = require('../tools/lib/sim/compare');

// Our chain: the Orc starting zone, with 508 "Mage Lesson" (classes 128) behind
// an `only Mage` condition, as the leveling guides carry their class quests.
function fixture() {
	const root = tmpdir();
	const dirs = syn.writeDataDir(root);
	const ours = path.join(root, 'guides');
	const file = path.join(ours, 'forever/horde/orc/01-start.guide');
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, `${[
		'guide forever/horde/orc/01-start', 'title Start', 'faction Horde', 'race Orc', 'levels 1-5', 'zone Testvale', '',
		'step Rats', '  accept 501', '  kill 10 x8 quest 501.1', '  turnin 501',
		'step Lesson', '  only Mage', '  accept 508', '  kill 10 x2 quest 508.1', '  turnin 508',
	].join('\n')}\n`);
	return { ...dirs, ours, benchDir: path.join(root, 'bench') };
}

const opts = (f) => ({ dataDir: f.dataDir, simDir: f.simDir, sourcesDir: f.sourcesDir, benchDir: f.benchDir, offline: true, extraStarts: syn.START, log: () => {} });
const row = (file) => JSON.parse(fs.readFileSync(file, 'utf8')).rows.find((x) => x.id === 'polestar');

test('sim compare --class scores the chain for that class and writes its own file', async () => {
	const f = fixture();
	const o = opts(f);

	const bare = await quiet(() => compareCommand({ faction: 'Horde', race: 'Orc', guides: f.ours }, o));
	assert.equal(bare.result, 0, bare.out);
	const mage = await quiet(() => compareCommand({ faction: 'Horde', race: 'Orc', class: 'Mage', guides: f.ours }, o));
	assert.equal(mage.result, 0, mage.out);

	const plain = path.join(f.benchDir, 'compare-horde-orc.json');
	const byClass = path.join(f.benchDir, 'compare-horde-orc-mage.json');
	assert.ok(fs.existsSync(plain), 'the class-agnostic file is still written');
	assert.ok(fs.existsSync(byClass), 'the class run writes compare-<faction>-<race>-<class>.json');

	// 508 is open to one class, so it counts only for the Mage.
	assert.equal(row(byClass).quests, row(plain).quests + 1, 'the Mage Lesson is scored for a Mage and not otherwise');
	assert.equal(JSON.parse(fs.readFileSync(byClass, 'utf8')).class, 'Mage');
	assert.equal(JSON.parse(fs.readFileSync(plain, 'utf8')).class, 'any');
	assert.match(mage.out, /Horde Orc \(Mage\)/);
});

test('sim compare --class rejects a name that is not a class, rather than scoring nothing', async () => {
	const f = fixture();
	const { result, out } = await quiet(() => compareCommand({ faction: 'Horde', race: 'Orc', class: 'Cleric', guides: f.ours }, opts(f)));
	assert.notEqual(result, 0, out);
	assert.match(out, /--class must be one of/);
	assert.doesNotMatch(out, /Cleric.*scored/);
});

test('sim bench --class carries the class into its table and file name', async () => {
	const f = fixture();
	const { result, out } = await quiet(() => benchCommand({ faction: 'Horde', race: 'Orc', class: 'Mage' }, opts(f)));
	assert.equal(result, 0, out);
	assert.ok(fs.existsSync(path.join(f.benchDir, 'bench-horde-orc-mage.json')), 'bench-<faction>-<race>-<class>.json');
	assert.equal(JSON.parse(fs.readFileSync(path.join(f.benchDir, 'bench-horde-orc-mage.json'), 'utf8')).class, 'Mage');
	assert.match(out, /bench Horde Orc \(Mage\)/);
});
