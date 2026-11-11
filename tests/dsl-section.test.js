'use strict';
// `section <Profession> <from>-<to>` (docs/GUIDE_FORMAT.md, "Sections"): a profession guide's skill range as a
// heading over the steps after it. The JS compiler side of forge-guide's dsl_section.rs test; tests/parity.sh keeps
// the two compilers' output equal. Also the generators' section lines (tools/lib/professions/sections.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { byBanners, byBands } = require('../tools/lib/professions/sections');

const HEAD = ['guide t/first-aid', 'title First Aid', 'category Professions', 'levels 1-60', 'zone Elwynn Forest', ''];
const text = (l) => `${[...HEAD, ...l].join('\n')}\n`;

test('sections head the steps after them with the profession\'s skill line', () => {
	const r = compile(text(['step Learn', '  train First Aid Apprentice', 'section First Aid 1-40', '', 'step Cloth', '  collect 2589 x41 @40,50', 'step Linen', '  craft 3275 until 40', 'section "First Aid" 40-50', 'step Heavy', '  learn 3276', '  craft 3276 until 50']));
	assert.deepEqual([r.errors, r.warnings], [[], []], r.text);
	const g = plain(r.guides[0]);
	assert.deepEqual(g.sections, [
		{ skill: 'First Aid', skillLine: 129, from: 1, to: 40 },
		{ skill: 'First Aid', skillLine: 129, from: 40, to: 50 },
	]);
	assert.deepEqual(g.steps.map((s) => s.section), [undefined, 1, 1, 2]);
	const linen = g.steps[2].goals[0];
	assert.deepEqual([linen.yellow, linen.grey], [30, 60]);
	const lua = emitGuides(r.guides.map((guide) => ({ guide })));
	assert.match(lua, /sections = \{ \{ skill = "First Aid", skillLine = 129, from = 1, to = 40 \}/);
	assert.match(lua, /section = 2,/);
	assert.match(lua, /untilSkill = 40, yellow = 30, grey = 60,/);
});

test('a malformed or empty section and a header key after one are errors; out of order warns', () => {
	const errs = (l) => compile(text(l)).errors.join('\n');
	for (const [line, want] of [
		['section First Aid', '`section` needs a profession and a skill range'],
		['section 1-40', '`section` needs a profession and a skill range'],
		['section First Aid 1-40 extra', '`section` needs a profession and a skill range'],
		['section First Aid 40-40', 'malformed skill range "40-40"'],
		['section Juggling 1-40', 'unknown profession "Juggling"'],
	]) {
		assert.ok(errs([line, 'step A', '  craft 3275 until 40']).includes(want), line);
	}
	assert.ok(errs(['step A', '  craft 3275 until 40', 'section First Aid 40-50']).includes('`section` has no steps under it'));
	assert.ok(errs(['section First Aid 1-40', 'faction Alliance', 'step A', '  craft 3275 until 40']).includes('unexpected `faction` in column 0'));
	const r = compile(text(['section First Aid 40-50', 'step A', '  learn 3276', '  craft 3276 until 50', 'section First Aid 1-40', 'step B', '  craft 3275 until 40']));
	assert.deepEqual(r.errors, []);
	assert.equal(r.warnings.filter((w) => w.includes("a guide's sections are one profession's skill ranges in rising order")).length, 1);
});

test('the generators write a section per ranged banner (a rangeless one leads into the next) or per crafting band', () => {
	const B = (s) => `# ---------------------------------------------------------------- ${s}`;
	const banners = byBanners([B('Apprentice'), '', 'step Learn', '  train Mining Apprentice', '', B('Mining 1-65'), '', 'step A', '  skill Mining 65', '', B('Expert Mining'), '', 'step B', '  train Mining Expert', '', B('Mining 125-155'), '', 'step C', '  skill Mining 155'].join('\n'), 'Mining');
	assert.deepEqual(banners.split('\n').filter((l) => /^section|^step/.test(l)), ['section Mining 1-65', 'step Learn', 'step A', 'section Mining 125-155', 'step B', 'step C']);
	const bands = byBands(['step Learn', '  train First Aid Apprentice', '', 'step Cloth', '  collect 2589 x41', '', 'step Linen', '  craft 3275 until 40', '', 'step Journeyman', '  train First Aid Journeyman', '', 'step Gate', '  skill "First Aid" 40', '', 'step Heavy', '  craft 3276 until 80', '', 'step Note', '  note Done'].join('\n'), 'First Aid');
	assert.deepEqual(bands.split('\n').filter((l) => /^section|^step/.test(l)), ['section First Aid 1-40', 'step Learn', 'step Cloth', 'step Linen', 'section First Aid 40-80', 'step Journeyman', 'step Gate', 'step Heavy', 'step Note']);
	assert.equal(byBanners(banners, 'Mining'), banners, 'idempotent');
});

test('a section\'s cloth counted with `collect … xN anywhere` gets no place; a quest, no count or a place are errors', () => {
	const r = compile(text(['section First Aid 1-40', 'step Cloth', '  collect 2589 x41 anywhere', 'step Linen', '  craft 3275 until 40']));
	assert.deepEqual([r.errors, r.warnings], [[], []], r.text);
	const cloth = plain(r.guides[0]).steps[0].goals[0];
	assert.deepEqual([cloth.t, cloth.item, cloth.count, cloth.map, cloth.x, cloth.candidates, cloth.fromNpcs], ['collect', 2589, 41, undefined, undefined, undefined, undefined]);
	const errs = compile(text(['step Cloth', '  collect 2589 anywhere', '  collect 2589 x2 anywhere nearest', '  collect 2589 x2 anywhere @40,50'])).errors.join('\n');
	assert.match(errs, /`collect … anywhere` needs a count: `collect <item> xN anywhere`/);
	assert.match(errs, /`collect … anywhere` has no place: drop `nearest`, `npc` or the coordinates/);
});
