'use strict';
// Format-3 `label` and `along [until <label>]` step lines: parsed, checked across the guide, emitted into
// Guides.lua, and a pack using either is format 2.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { compile, guideText, plain, fixtureData } = require('./helpers/dsl');
const { readManifest } = require('../tools/lib/pack/manifest');
const { buildPackFiles, packFormat } = require('../tools/lib/dsl/project');

const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');

function stepsOf(lines) {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, [], r.text);
	return plain(r.guides[0].steps);
}

function errorsOf(lines) {
	return compile(guideText(lines)).errors.join('\n');
}

const lineNo = (lines, needle) => guideText(lines).split('\n').findIndex((l) => l.trim() === needle) + 1;

test('`label` names a step; `along` marks a step as along-the-way, with or without `until`', () => {
	const steps = stepsOf([
		'step Kill boars on the way', '  along until turnin', '  kill 6 x5',
		'step Look for the book', '  along', '  collect 750',
		'step Travel', '  goto 47.6,35.1',
		'step Hand in', '  label turnin', '  accept 783',
	]);
	assert.equal(steps[0].along, 'turnin');
	assert.equal(steps[1].along, true);
	assert.equal(steps[2].along, undefined);
	assert.equal(steps[3].label, 'turnin');
	assert.equal(steps[0].label, undefined);
});

test('labels allow letters, digits, - and _; keywords are case-insensitive, labels are not', () => {
	const steps = stepsOf(['step A', '  ALONG UNTIL Camp_2', '  kill 6', 'step B', '  Label Camp_2', '  accept 783']);
	assert.equal(steps[0].along, 'Camp_2');
	assert.equal(steps[1].label, 'Camp_2');
	assert.match(errorsOf(['step A', '  along until camp_2', '  kill 6', 'step B', '  label Camp_2', '  accept 783']), /unknown label "camp_2"/);
});

test('errors: malformed lines, duplicates, unknown or backward `until` targets, at the right line', () => {
	assert.match(errorsOf(['step A', '  label', '  accept 783']), /`label` needs a name/);
	assert.match(errorsOf(['step A', '  label two words', '  accept 783']), /`label` needs a name/);
	assert.match(errorsOf(['step A', '  label a.b', '  accept 783']), /malformed label "a\.b"/);
	assert.match(errorsOf(['step A', '  label x', '  label y', '  accept 783']), /duplicate `label` in step/);
	assert.match(errorsOf(['step A', '  along', '  along', '  kill 6']), /duplicate `along` in step/);
	assert.match(errorsOf(['step A', '  along later', '  kill 6']), /`along` takes nothing or `until <label>`/);
	assert.match(errorsOf(['step A', '  along until', '  kill 6']), /`along` takes nothing or `until <label>`/);

	const dup = ['step A', '  label x', '  accept 783', 'step B', '  label x', '  kill 6'];
	const dupErr = errorsOf(dup);
	assert.match(dupErr, new RegExp(`:${lineNo(dup, 'label x') + 3}: duplicate label "x" \\(first at line ${lineNo(dup, 'label x')}\\)`));

	const unknown = ['step A', '  along until nowhere', '  kill 6'];
	assert.match(errorsOf(unknown), new RegExp(`:${lineNo(unknown, 'along until nowhere')}: unknown label "nowhere"`));

	const back = ['step A', '  label here', '  accept 783', 'step B', '  along until here', '  kill 6'];
	assert.match(errorsOf(back), /`along until here` must name a later step/);
	const self = ['step A', '  label here', '  along until here', '  kill 6'];
	assert.match(errorsOf(self), /`along until here` must name a later step/);
});

function pack(lines) {
	const { manifest } = readManifest(MINI);
	const r = compile(guideText(lines), fixtureData(), { pack: 'mini' });
	assert.deepEqual(r.errors, [], r.text);
	return { manifest, guides: r.guides, files: buildPackFiles({ guides: r.guides, manifest, data: fixtureData() }) };
}

const HDR = ['guide mini/a', 'title A', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', ''];

test('Guides.lua carries label and along in a fixed order: title, note, label, only, when, along, goals', () => {
	const { files } = pack([...HDR, 'step One', '  along until end', '  only Warrior', '  when level < 5', '  tip Go', '  kill 6', 'step Two', '  label end', '  accept 783']);
	const lua = files['Guides.lua'];
	assert.match(lua, /title = "One",\n\t*note = "Go",\n\t*only = \{ classes = \{ "WARRIOR" \} \},\n\t*when = \{ "level", "<", 5 \},\n\t*along = "end",\n\t*goals = \{/);
	assert.match(lua, /title = "Two",\n\t*label = "end",\n\t*goals = \{/);
	const bare = pack([...HDR, 'step One', '  along', '  kill 6', 'step Two', '  accept 783']).files['Guides.lua'];
	assert.match(bare, /along = true,\n/);
});

test('a pack using `label` or `along` is format 3', () => {
	assert.equal(packFormat(pack([...HDR, 'step One', '  label a', '  accept 783']).guides), 3);
	assert.equal(packFormat(pack([...HDR, 'step One', '  along', '  kill 6', 'step Two', '  accept 783']).guides), 3);
	assert.equal(packFormat(pack([...HDR, 'step One', '  accept 783']).guides), 2);
	assert.match(pack([...HDR, 'step One', '  label a', '  accept 783']).files['Pack.lua'], /format = 3,/);
});
