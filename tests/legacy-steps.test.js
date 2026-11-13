'use strict';
// tools/legacy-steps.js and renamed guides: an earlier release's guide that the
// current pack renamed (its renamed.json, `forge guide renumber`) is the same
// guide under the new id, so its changed steps are kept under the new id, where
// a save moved there at login looks for them (Core/Guides.lua, Own.moveRenamed).

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.join(__dirname, '..');
const DATA = path.join(ROOT, 'tests/fixtures/dsl/data');

function guide(id, steps) {
	return `guide ${id}\ntitle Northshire Valley\nfaction Alliance\nlevels 1-6\nzone Elwynn Forest\n\n${steps}`;
}

function run(renamed) {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-legacy-'));
	const write = (rel, text) => {
		fs.mkdirSync(path.dirname(path.join(dir, rel)), { recursive: true });
		fs.writeFileSync(path.join(dir, rel), text);
	};
	// The earlier release: two steps. Now: the first one only, under a new id.
	write('old/forever/alliance/03-vale.guide', guide('forever/alliance/03-vale', 'step Deputy Willem\n  accept 783\n\nstep Back\n  turnin 783\n'));
	write('now/forever/alliance/01-vale.guide', guide('forever/alliance/01-vale', 'step Deputy Willem\n  accept 783\n'));
	if (renamed) write('now/renamed.json', JSON.stringify(renamed));
	const out = path.join(dir, 'LegacySteps.lua');
	const r = spawnSync(process.execPath, [path.join(ROOT, 'tools/legacy-steps.js'), '--old', path.join(dir, 'old'), '--current', path.join(dir, 'now'), '--data', DATA, '--out', out], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	const text = fs.readFileSync(out, 'utf8');
	fs.rmSync(dir, { recursive: true, force: true });
	return text;
}

test('an earlier release\'s steps of a renamed guide are kept under its new id', () => {
	const text = run({ 'forever/alliance/03-vale': 'forever/alliance/01-vale' });
	assert.match(text, /\t\["forever\/alliance\/01-vale"\] = \{\n\t\t\[\d+\] = "turnin:783",\n\t\},/);
	assert.doesNotMatch(text, /03-vale/);
});

test('without renamed.json a guide of another id is another guide', () => {
	assert.doesNotMatch(run(null), /01-vale|03-vale/);
});
