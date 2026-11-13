'use strict';
// Explicit knowledge-base paths must not silently disable the honest
// playtest's required-mechanics checks. Fixtures need no private data or Lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DatabaseSync } = require('node:sqlite');
const { quiet } = require('./helpers/cli');
const { DATA_DIR, fixtureData } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const cmd = require('../tools/commands/playtest');
const { playtest } = require('../tools/lib/playtest');
const { KB_FILE } = require('../tools/lib/playtest-honest');

function fixture() {
	const dir = tmpdir('polestar-playtest-kb-');
	fs.writeFileSync(path.join(dir, 'mage.guide'), [
		'guide test/mage', 'title Mage fixture', 'faction Alliance', 'class Mage',
		'race Human', 'levels 1-10', 'zone Elwynn Forest', 'step Kobolds',
		'  accept 7', '  kill 6 x10 quest 7.1', '  turnin 7', '',
	].join('\n'));
	return { dir, args: ['--honest', '--guides', dir, '--data', DATA_DIR, '--class', 'Mage'] };
}

function knowledgeBase(dir) {
	const file = path.join(dir, 'mechanics.sqlite');
	const db = new DatabaseSync(file);
	try {
		// A synthetic required action, independent of any live quest mechanics.
		db.exec(`CREATE TABLE steps (quest INTEGER, n INTEGER, action TEXT, target_kind TEXT, target INTEGER, item INTEGER, fact TEXT, drives INTEGER);
			INSERT INTO steps VALUES (7, 1, 'use-item', 'item', 772, 772, 'Synthetic required action', 1);`);
	} finally {
		db.close();
	}
	return file;
}

for (const format of ['text', 'json']) {
	test(`--honest rejects a missing explicit knowledge base (${format})`, async () => {
		const { dir, args } = fixture();
		const missing = path.join(dir, 'missing.sqlite');
		const r = await quiet(() => cmd.run([...args, '--kb', missing, '--format', format]));
		assert.equal(r.result, 1, r.out);
		assert.match(r.out, /knowledge base/i);
		assert.ok(r.out.includes(missing), r.out);
		assert.doesNotMatch(r.out, /playtest --honest ok|"ok":\s*true/);
	});
}

test('the playtest library reports a missing explicit knowledge base as a diagnostic', async () => {
	const { dir } = fixture();
	const missing = path.join(dir, 'missing.sqlite');
	const r = await playtest({ dir, official: true, data: fixtureData(), classes: ['MAGE'], honest: true, kb: missing });
	assert.equal(r.diag.hasErrors(), true);
	assert.match(JSON.stringify(r.diag.errors), /knowledge base/i);
	assert.ok(JSON.stringify(r.diag.errors).includes(missing));
});

test('an explicit knowledge base still reports a required action omitted by the guide', async () => {
	const { dir, args } = fixture();
	const kb = knowledgeBase(dir);
	const r = await quiet(() => cmd.run([...args, '--kb', kb, '--format', 'json']));
	assert.equal(r.result, 1, r.out);
	const report = JSON.parse(r.out);
	assert.equal(report.ok, false);
	assert.equal(report.played, 1);
	assert.ok(report.findings.some((f) => f.rule === 'R5' && f.severity === 'fail' && /required step 1 \(use-item .*\) has no line/.test(f.reason)), r.out);
});

test('kb: null intentionally disables optional knowledge-base checks', async () => {
	const { dir } = fixture();
	const options = { dir, official: true, data: fixtureData(), classes: ['MAGE'], honest: true };
	const withKb = await playtest({ ...options, kb: knowledgeBase(dir) });
	assert.ok(withKb.findings.some((f) => f.rule === 'R5' && /required step/.test(f.reason)));
	const withoutKb = await playtest({ ...options, kb: null });
	assert.equal(withoutKb.diag.hasErrors(), false);
	assert.equal(withoutKb.played, 1);
	assert.deepEqual(withoutKb.findings, []);
});

test('an omitted default knowledge base remains optional when absent', async (t) => {
	const { args } = fixture();
	const existsSync = fs.existsSync;
	// Keep this independent of a contributor's local KB without touching it.
	t.mock.method(fs, 'existsSync', (file) => file === KB_FILE ? false : existsSync(file));
	const r = await quiet(() => cmd.run([...args, '--format', 'json']));
	assert.equal(r.result, 0, r.out);
	const report = JSON.parse(r.out);
	assert.equal(report.ok, true);
	assert.equal(report.played, 1);
	assert.deepEqual(report.findings, []);
});
