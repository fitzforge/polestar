'use strict';
// Steps of places only (#4467, docs/GUIDE_FORMAT.md "Steps of places only"): in a leveling guide a step whose goals
// are only gotos, a flight or `enter` compiles `via = true`, a hidden hint on the way to the step after it, and
// `keep <kind> <reason>` keeps one a step of its own (`keep = "<kind>"`). The JS compiler side of forge-guide's
// dsl_via.rs test; tests/parity.sh keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');

const head = (category) => ['guide t/main', 'title Test', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', ...(category ? [`category ${category}`] : []), ''];
const text = (lines, category) => `${[...head(category), ...lines].join('\n')}\n`;

const ROUTE = [
	'step Into Goldshire',
	'  tip Follow the road south.',
	'  goto 42.1,65.9 "Goldshire"',
	'step Smith Argus',
	'  goto 41.7,65.5',
	'  accept 7',
	'step The mine door',
	'  keep door the walking maps have no way into the mine: its mouth first',
	'  goto 39.5,82.4 "Fargodeep Mine"',
	'step Kobolds',
	'  kill 6',
];

test('a leveling step of places only compiles as a via; one with work, or kept, stays a step', () => {
	const r = compile(text(ROUTE));
	assert.deepEqual(r.errors, [], r.text);
	const steps = plain(r.guides[0]).steps;
	assert.deepEqual(steps.map((s) => [s.via, s.keep]), [[true, undefined], [undefined, undefined], [undefined, 'door'], [undefined, undefined]]);
	// The via keeps its goals and its index: saves, legs and labels point where they did.
	assert.equal(steps[0].goals[0].t, 'goto');
	const lua = emitGuides(r.guides.map((guide) => ({ guide })));
	assert.match(lua, /title = "Into Goldshire",\n\s+note = "Follow the road south.",\n\s+via = true,/);
	assert.match(lua, /keep = "door",/);
});

test('a trailing run of steps of places only stays as written: the guide ends there (a pack of places only too)', () => {
	const r = compile(text(['step Into Goldshire', '  goto 42.1,65.9 "Goldshire"', 'step Smith Argus', '  goto 41.7,65.5', '  accept 7', 'step The road west', '  goto 30.0,60.0', 'step Westfall', '  goto 10.0,60.0']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0]).steps.map((s) => s.via), [true, undefined, undefined, undefined]);
	const places = compile(text(['step A', '  goto 42.1,65.9', 'step B', '  goto 41.7,65.5']));
	assert.deepEqual(plain(places.guides[0]).steps.map((s) => s.via), [undefined, undefined]);
});

test('other categories keep every step as written, and say so of a `keep`', () => {
	const r = compile(text(ROUTE, 'Class'));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0]).steps.map((s) => [s.via, s.keep]), [[undefined, undefined], [undefined, undefined], [undefined, undefined], [undefined, undefined]]);
	assert.ok(r.warnings.some((w) => w.includes("`keep` is for a leveling guide's step of places only")), r.text);
});

test('`keep` needs a known kind and a reason, and only fits a step of places only', () => {
	const errs = (line) => compile(text(['step A', line, '  goto 42.1,65.9', 'step B', '  kill 6'])).errors.join('\n');
	assert.match(errs('  keep'), /`keep` needs a kind: door, instance, boarding, phasing, safety/);
	assert.match(errs('  keep shortcut it is quicker'), /`keep` needs a kind/);
	assert.match(errs('  keep door'), /`keep door` needs its reason/);
	assert.match(compile(text(['step A', '  keep door a', '  keep door b', '  goto 42.1,65.9'])).errors.join('\n'), /duplicate `keep` in step/);
	const r = compile(text(['step A', '  keep door the smith is inside', '  goto 41.7,65.5', '  accept 7']));
	assert.deepEqual(r.errors, []);
	assert.ok(r.warnings.some((w) => w.includes('`keep` is for a step of places only')), r.text);
	assert.equal(plain(r.guides[0]).steps[0].keep, undefined);
});
