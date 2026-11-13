'use strict';
// Honest play must sample class branches throughout a next chain, using the
// first guide's eligibility. These tests need only the committed DSL data.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { playtest } = require('../tools/lib/playtest');
const manifest = require('../guides/pack.json');

const unfinished = '  accept 783\n  turnin 783\n  accept 7\n  turnin 7';
const guide = (id, header, body) => `guide forever/test/${id}\ntitle ${id}\nlevels 1-10\nzone Elwynn Forest\nfaction Alliance\n${header}\n\n${body}\n`;

async function run(endHeader, endBody, { rootHeader = '', ...options } = {}) {
	const dir = tmpdir();
	fs.writeFileSync(path.join(dir, '01-start.guide'), guide('start', `next forever/test/end\n${rootHeader}`, 'step Begin\n  note Begin'));
	fs.writeFileSync(path.join(dir, '02-end.guide'), guide('end', endHeader, endBody));
	const result = await playtest({ dir, manifest, official: true, dataDir: path.join(__dirname, 'fixtures/dsl/data'), honest: true, kb: null, ...options });
	assert.deepEqual(result.diag.errors, [], JSON.stringify(result.diag));
	return result.findings.filter((f) => f.rule === 'R5');
}

for (const [name, header, body] of [
	['step', '', `step Mage work\n  only Mage\n${unfinished}`],
	['goal', '', `step Mage work\n${unfinished} only Mage`],
	['header', 'class Mage', `step Mage work\n${unfinished}`],
]) {
	test(`honest play catches an unfinished quest behind a class named only in a later guide's ${name}`, async () => {
		const findings = await run(header, body);
		const mage = findings.find((f) => f.cls === 'MAGE');
		assert.ok(mage, 'the later Mage branch must be played as Mage');
		assert.equal(mage.guide, 'forever/test/end');
		assert.match(mage.reason, /has 0\/10 from earlier lines/);
	});
}

test('filtering to a later guide still samples its class and plays its chain', async () => {
	const findings = await run('', `step Mage work\n  only Mage\n${unfinished}`, { filter: '02-end' });
	assert.equal(findings.length, 1);
	assert.equal(findings[0].cls, 'MAGE');
});

test('an explicit class filter overrides the classes named later in the chain', async () => {
	const body = `step Mage work\n  only Mage\n${unfinished}`;
	assert.deepEqual(await run('', body, { classes: ['WARRIOR'] }), []);
	assert.equal((await run('', body, { classes: ['MAGE'] }))[0].cls, 'MAGE');
});

test('a later Druid branch adds an eligible race, while the root race and class headers remain authoritative', async () => {
	const body = `step Druid work\n  only Druid\n${unfinished}`;
	const findings = await run('', body);
	assert.equal(findings.length, 1);
	assert.equal(findings[0].race, 'NightElf');
	assert.equal(findings[0].cls, 'DRUID');
	assert.deepEqual(await run('', body, { rootHeader: 'race Human' }), []);
	assert.deepEqual(await run('', body, { rootHeader: 'class Warrior' }), []);
});

test('chain sampling retains one eligible class that the chain never names', async () => {
	const findings = await run('', `step Mage greeting\n  only Mage\n  note Hello\n\nstep Work\n${unfinished}`);
	assert.deepEqual(findings.map((f) => f.cls).sort(), ['MAGE', 'WARRIOR']);
});
