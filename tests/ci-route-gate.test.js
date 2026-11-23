'use strict';
// tools/ci-route-gate.js (#3654, docs/CI.md "Route integrity"): the chain an edit replays, what the edited guides
// lose and where each quest went, the level model's guide-end drops and the honest playtest's new findings.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { chain, removals, levelDrops, newHonest } = require('../tools/ci-route-gate');
const { tmpdir } = require('./helpers/tmp');

// A tree with leveling guides: { 'horde/a': { next, body } } -> its folder.
function tree(spec) {
	const root = tmpdir('route-gate-');
	for (const [name, g] of Object.entries(spec)) {
		const file = path.join(root, 'guides', 'forever', `${name}.guide`);
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(file, `guide forever/${name}\nfaction Horde\n${g.next ? `next forever/${g.next}\n` : ''}\n${g.body || ''}`);
	}
	return root;
}

// fn run with the working folder at dir (the head tree), as the gate runs.
function inside(dir, fn) {
	const was = process.cwd();
	process.chdir(dir);
	try {
		return fn();
	} finally {
		process.chdir(was);
	}
}

test('chain: each edited guide and the next three of its chain, each once', () => {
	const spec = { 'horde/a': { next: 'horde/b' }, 'horde/b': { next: 'horde/c' }, 'horde/c': { next: 'horde/d' }, 'horde/d': { next: 'horde/e' }, 'horde/e': {} };
	const head = tree(spec);
	const base = tree(spec);
	assert.deepEqual(inside(head, () => chain(base, ['guides/forever/horde/a.guide', 'guides/forever/horde/c.guide', 'guides/locales/deDE/forever/horde/a.lua'])), [
		'forever/horde/a', 'forever/horde/b', 'forever/horde/c', 'forever/horde/d', 'forever/horde/e',
	]);
	assert.deepEqual(inside(head, () => chain(base, ['addon/Polestar/Core/Core.lua'])), []);
});

test('removals: a goal the edited guide lost, with the quest\'s new place or gone from the route', () => {
	const base = tree({
		'horde/a': { body: 'step One\n  accept 100\n  kill 5 quest 100.1\nstep Two\n  accept 200\n  turnin 100\n' },
		'horde/b': { body: 'step Three\n  turnin 200\n' },
	});
	const head = tree({
		'horde/a': { body: 'step One\n  accept 100\n  kill 5 quest 100.1\n  turnin 100\n' },
		'horde/b': { body: 'step Three\n  accept 200\n' },
	});
	const r = inside(head, () => removals(base, ['guides/forever/horde/a.guide', 'guides/forever/horde/b.guide']));
	assert.deepEqual(r.rows.map((x) => [x.guide, x.goal, x.step, x.now]), [
		['forever/horde/a', 'accept 200', 'Two', 'forever/horde/b: Three'],
		['forever/horde/b', 'turnin 200', 'Three', 'forever/horde/b: Three'],
	]);
	assert.deepEqual(r.gone, []);
	const gone = tree({ 'horde/a': { body: 'step One\n  accept 100\n  kill 5 quest 100.1\n  turnin 100\n' }, 'horde/b': { body: 'step Three\n' } });
	assert.deepEqual(inside(gone, () => removals(base, ['guides/forever/horde/a.guide', 'guides/forever/horde/b.guide'])).gone, ['200']);
});

test('levels: every guide end reached lower, by race, class and guide', () => {
	const dir = tmpdir('route-gate-levels-');
	const run = (ends) => [{ race: 'Orc', cls: 'WARRIOR', rows: Object.entries(ends).map(([id, end]) => ({ id, start: 1, end })) }];
	fs.writeFileSync(path.join(dir, 'base.json'), JSON.stringify(run({ a: 12.5, b: 20, c: 30 })));
	fs.writeFileSync(path.join(dir, 'head.json'), JSON.stringify(run({ a: 12.1, b: 20.2, c: 29.9 })));
	assert.deepEqual(levelDrops(path.join(dir, 'base.json'), path.join(dir, 'head.json')), [
		{ key: 'Orc WARRIOR a', before: 12.5, after: 12.1, drop: 0.4 },
		{ key: 'Orc WARRIOR c', before: 30, after: 29.9, drop: 0.1 },
	]);
});

test('honest: only failing findings the base lacks, step numbers left out', () => {
	const dir = tmpdir('route-gate-honest-');
	const f = (rule, step, reason, severity = 'fail') => ({ rule, severity, guide: 'g', step, line: step * 3, title: 'T', reason });
	fs.writeFileSync(path.join(dir, 'base.json'), JSON.stringify({ findings: [f('R1', 3, 'no travel line')] }));
	fs.writeFileSync(path.join(dir, 'head.json'), JSON.stringify({ findings: [f('R1', 4, 'no travel line'), f('R2', 5, 'not offered'), f('R3', 6, 'a warning', 'warn')] }));
	assert.deepEqual(newHonest(path.join(dir, 'base.json'), path.join(dir, 'head.json')), ['R2 | g | T | not offered']);
});
