'use strict';
// Format-2 `when` lines on steps: parsed by parse.js, names resolved by
// resolve.js, emitted into Guides.lua by emit.js, and a pack using one is
// written as format 2 (docs/parity plan, Task 1.3).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { compile, guideText, plain, fixtureData } = require('./helpers/dsl');
const { readManifest } = require('../tools/lib/pack/manifest');
const { buildPackFiles } = require('../tools/lib/dsl/project');
const { NEEDS } = require('../tools/lib/pack/format');

const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');

function stepsOf(lines) {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, [], r.text);
	return plain(r.guides[0].steps);
}

function errorsOf(lines) {
	return compile(guideText(lines)).errors;
}

test('a step `when` line becomes the step\'s predicate', () => {
	const steps = stepsOf(['step One', '  when onquest 7', '  accept 783', 'step Two', '  accept 783']);
	assert.deepEqual(steps[0].when, ['onquest', 7]);
	assert.equal(steps[1].when, undefined);
});

test('`when` may come anywhere in the step and combines with `only`', () => {
	const steps = stepsOf(['step One', '  accept 783', '  only Warrior', '  when not turnedin 783 and level >= 2']);
	assert.deepEqual(steps[0].when, ['all', ['not', ['turnedin', 783]], ['level', '>=', 2]]);
	assert.deepEqual(steps[0].only, { classes: ['WARRIOR'] });
});

test('profession and faction names resolve to ids; ids pass through', () => {
	const steps = stepsOf([
		'step One', '  when skill Mining >= 50', '  accept 783',
		'step Two', '  when rep Stormwind >= Friendly', '  accept 783',
		'step Three', '  when skill 186 >= 1 or rep 72 < 4', '  accept 783',
	]);
	assert.deepEqual(steps[0].when, ['skill', 186, '>=', 50]);
	assert.deepEqual(steps[1].when, ['rep', 72, '>=', 5]);
	assert.deepEqual(steps[2].when, ['any', ['skill', 186, '>=', 1], ['rep', 72, '<', 4]]);
});

test('errors: parse errors, unknown names, duplicates and notes are reported at the `when` line', () => {
	const text = guideText(['step One', '  when onquest', '  accept 783']);
	const line = text.split('\n').findIndex((l) => l.trim() === 'when onquest') + 1;
	const errs = errorsOf(['step One', '  when onquest', '  accept 783']);
	assert.equal(errs.length, 1);
	assert.match(errs[0], new RegExp(`:${line}: .*\`when\`.*quest id`));

	assert.match(errorsOf(['step One', '  when skill Basketweaving >= 1', '  accept 783']).join('\n'), /unknown profession "Basketweaving"/);
	assert.match(errorsOf(['step One', '  when rep "Nobody Faction" >= Friendly', '  accept 783']).join('\n'), /unknown faction "Nobody Faction"/);
	assert.match(errorsOf(['step One', '  when onquest 7', '  when onquest 8', '  accept 783']).join('\n'), /duplicate `when`/);
	assert.match(errorsOf(['step One', '  when', '  accept 783']).join('\n'), /`when`.*empty/);
	assert.match(errorsOf(['step One', '  when onquest 7 -- hi', '  accept 783']).join('\n'), /notes/);
});

function pack(lines) {
	const { manifest } = readManifest(MINI);
	const r = compile(guideText(lines), fixtureData(), { pack: 'mini' });
	assert.deepEqual(r.errors, [], r.text);
	return { manifest, files: buildPackFiles({ guides: r.guides, manifest, data: fixtureData() }) };
}

test('Guides.lua carries `when` as a Lua table after `only`', () => {
	const { files } = pack(['guide mini/w', 'title W', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '', 'step One', '  only Warrior', '  when onquest 7 and has 750 x2', '  accept 783']);
	const lua = files['Guides.lua'];
	assert.match(lua, /only = \{ classes = \{ "WARRIOR" \} \},\n\t*when = \{ "all", \{ "onquest", 7 \}, \{ "item", 750, ">=", 2 \} \},\n/);
});

test('a pack using `when` is format 2; one without stays format 1', () => {
	assert.equal(NEEDS[2], '0.3.0');
	const two = pack(['guide mini/w', 'title W', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '', 'step One', '  when onquest 7', '  accept 783']);
	const toc2 = two.files[`${two.manifest.folder}.toc`];
	assert.match(toc2, /## X-Polestar-Format: 2\n/);
	assert.match(toc2, /## X-Polestar-Needs: 0\.3\.0\n/);
	assert.match(two.files['Pack.lua'], /format = 2,/);

	const one = pack(['guide mini/w', 'title W', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '', 'step One', '  accept 783']);
	const toc1 = one.files[`${one.manifest.folder}.toc`];
	assert.match(toc1, /## X-Polestar-Format: 1\n/);
	assert.match(toc1, /## X-Polestar-Needs: 0\.1\.0\n/);
	assert.match(one.files['Pack.lua'], /format = 1,/);
	assert.doesNotMatch(one.files['Guides.lua'], /when =/);
});
