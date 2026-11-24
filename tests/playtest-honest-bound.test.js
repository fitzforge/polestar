'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { loadData } = require('../tools/lib/dsl/data');
const { compileSources } = require('../tools/lib/dsl/project');
const { playChain } = require('../tools/lib/playtest-honest');

const data = loadData(path.join(__dirname, 'fixtures/dsl/data'));
const human = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
const brokenWork = '  accept 33\n  turnin 33\n'; // Fixture quest needs an objective first.

function play(...bodies) {
	const sources = bodies.map((body, i) => ({
		file: `bound-${i}.guide`, source: `bound-${i}.guide`,
		text: `guide test/bound-${i}\ntitle Bound conditions\nfaction Alliance\nrace Human\nlevels 1-60\nzone Elwynn Forest\n\n${body}`,
	}));
	const { guides, diag } = compileSources(sources, data);
	assert.deepEqual(diag.list.filter((d) => d.severity === 'error'), []);
	assert.equal(guides.length, bodies.length);
	return playChain(guides, data, human).filter((f) => f.rule === 'R5').map((f) => f.title);
}

for (const [place, neg, runs] of [
	['Goldshire', '', true], ['Goldshire', '!', false],
	['Moonbrook', '', false], ['Moonbrook', '!', true],
	['gOlDsHiRe', '', true], ['gOlDsHiRe', '!', false],
]) {
	test(`honest play evaluates compiled when ${neg}bound "${place}" after setting home`, () => {
		assert.deepEqual(play(`step Bind\n  sethome "Goldshire"\n\nstep Conditional work\n  when ${neg}bound "${place}"\n${brokenWork}`), runs ? ['Conditional work'] : []);
	});
}

test('honest play carries binding between guides and only applies a rebind in a played step', () => {
	assert.deepEqual(play(
		'step Bind\n  sethome "Goldshire"\n\nstep Skipped rebind\n  when bound "Moonbrook"\n  sethome "Moonbrook"\n',
		`step Kept binding\n  when !bound "Goldshire"\n${brokenWork}\nstep Rebind\n  sethome "Moonbrook"\n\nstep Old binding\n  when bound "Goldshire"\n${brokenWork}\nstep New binding\n  when bound "Moonbrook"\n${brokenWork}`,
	), ['New binding']);
});

test('honest play keeps its existing unknown-binding assumption until a sethome', () => {
	assert.deepEqual(play(`step Unknown positive\n  when bound "Goldshire"\n${brokenWork}`), ['Unknown positive']);
	assert.deepEqual(play(`step Unknown negative\n  when !bound "Goldshire"\n${brokenWork}`), []);
});
