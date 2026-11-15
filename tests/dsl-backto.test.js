'use strict';
// The compiler side of a step's `backto` (pack format 11; docs/GUIDE_FORMAT.md, "Going back"):
// the line, its label and predicate checks, the emitted table and the pack format. The JS twin of
// forge-guide's tests/guide/dsl_backto.rs; the engine side is tests/engine-backto.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { importString, decodeImport, LIMITS } = require('../tools/lib/pack/importstring');
const { formatFor, BACKTO_FORMAT, FORMAT, NEEDS } = require('../tools/lib/pack/format');

const emit = (r) => emitGuides(r.guides.map((guide) => ({ guide, source: null })), false);
const ROUND = ['step Take it', '  label round', '  accept 783', 'step Hand it in', '  turnin 783', '  backto round when level<6', 'step Then', '  task "Go on"'];

test('`backto <label> [when <predicate>]` names this step or an earlier one', () => {
	const r = compile(guideText(ROUND));
	assert.deepEqual(r.errors, [], r.text);
	const steps = plain(r.guides[0].steps);
	assert.deepEqual(steps[1].backto, { to: 'round', when: { k: 'level', op: '<', n: 6 } });
	assert.ok(emit(r).includes('\t\t\t\t\tbackto = { to = "round", when = { k = "level", op = "<", n = 6 } },\n'));
	const bare = compile(guideText(['step A', '  label a', '  accept 783', '  backto a']));
	assert.deepEqual(bare.errors, [], bare.text);
	assert.deepEqual(plain(bare.guides[0].steps)[0].backto, { to: 'a' });
	assert.ok(emit(bare).includes('\t\t\t\t\tbackto = { to = "a" },\n'));
});

test('a label that is missing or on a later step, a second `backto` and a malformed line are errors', () => {
	const ahead = guideText(['step A', '  backto b', '  accept 783', 'step B', '  label b', '  turnin 783']);
	assert.deepEqual(compile(ahead).errors, [`test.guide:${lineOf(ahead, 'backto b')}: \`backto b\` must name this step or an earlier one (the label is on line ${lineOf(ahead, 'label b')}); \`skipto\` jumps ahead`]);
	const unknown = guideText(['step A', '  backto nowhere', '  accept 783']);
	assert.deepEqual(compile(unknown).errors, [`test.guide:${lineOf(unknown, 'backto nowhere')}: unknown label "nowhere"`]);
	for (const bad of ['backto', 'backto a b', 'backto a when', 'backto "a"', 'backto a! when level<6', 'backto a when group 783', 'backto a when nonsense']) {
		assert.ok(compile(guideText(['step A', '  label a', `  ${bad}`, '  accept 783'])).errors.length >= 1, bad);
	}
	assert.ok(compile(guideText(['step A', '  label a', '  backto a', '  backto a', '  accept 783'])).errors.some((e) => e.includes('a second `backto`')));
});

test('`backto` is not for an `along` step, and its `when done` names a label of the guide', () => {
	const along = guideText(['step A', '  label a', '  accept 783', 'step On the way', '  along until b', '  backto a', '  kill 6', 'step B', '  label b', '  turnin 783']);
	assert.ok(compile(along).errors.some((e) => e.startsWith(`test.guide:${lineOf(along, 'backto a')}: an \`along\` step is never the step the route is at`)));
	const done = guideText(['step A', '  label a', '  accept 783', '  backto a when !done nowhere']);
	assert.deepEqual(compile(done).errors, [`test.guide:${lineOf(done, 'backto a when !done nowhere')}: unknown label "nowhere"`]);
	const ok = compile(guideText(['step A', '  label a', '  accept 783', 'step B', '  label b', '  task "Once"', 'step C', '  turnin 783', '  backto a when !done b']));
	assert.deepEqual(ok.errors, [], ok.text);
});

test('format 11: a guide with a `backto` step, read by Polestar 0.4.1 and later', () => {
	assert.equal(BACKTO_FORMAT, 11);
	assert.equal(NEEDS[BACKTO_FORMAT], '0.4.1');
	assert.equal(formatFor(compile(guideText(ROUND)).guides), BACKTO_FORMAT);
	assert.equal(formatFor(compile(guideText(['step A', '  label a', '  accept 783', '  backto a'])).guides), BACKTO_FORMAT, 'with no predicate too');
	assert.equal(formatFor(compile(guideText(['step A', '  accept 783'])).guides), FORMAT);
});

test('an import string carries a `backto`, and counts the quests of its predicate against the cap the addon reads', () => {
	const manifest = { id: 'yendi', license: 'MIT' };
	const step = (when) => ({ label: 'a', backto: when ? { to: 'a', when } : { to: 'a' }, goals: [{ t: 'level', level: 2 }] });
	const guide = (when) => ({ id: 'yendi/round', title: 'Round', steps: [step(when)] });
	const fine = importString(guide({ k: 'onquest', q: [7, 783] }), { manifest, data: null });
	assert.equal(fine.error, undefined);
	const read = decodeImport(fine.text);
	assert.equal(read.format, BACKTO_FORMAT);
	assert.deepEqual(read.guide.steps[0].backto, { to: 'a', when: { k: 'onquest', q: [7, 783] } });
	assert.deepEqual(decodeImport(importString(guide(), { manifest, data: null }).text).guide.steps[0].backto, { to: 'a' });
	const quests = Array.from({ length: LIMITS.pre + 1 }, (_, i) => i + 1);
	const { error } = importString(guide({ k: 'onquest', q: quests }), { manifest, data: null });
	assert.ok(error && error.includes('yendi/round: guide.steps[1].backto.when.q has '), error);
});
