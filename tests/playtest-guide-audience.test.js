'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { quiet } = require('./helpers/cli');
const { compile, fixtureData, DATA_DIR } = require('./helpers/dsl');
const { playChain, honestPlay } = require('../tools/lib/playtest-honest');
const cmd = require('../tools/commands/playtest');

const HUMAN = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
const body = (broken) => `  accept 783\n  turnin 783\n  accept 7\n${broken ? '' : '  kill 6 x10 quest 7.1\n'}  turnin 7`;
const guide = (id, header, steps) => `guide test/${id}\ntitle ${id}\nlevels 1-10\nzone Elwynn Forest\n${header}\n\n${steps}\n`;

function pack(header, broken = false, rootHeader = 'faction Alliance') {
	const dir = tmpdir('honest-guide-audience-');
	fs.writeFileSync(path.join(dir, '01-start.guide'), guide('start', `${rootHeader}\nnext test/end`, 'step Begin\n  note Begin'));
	fs.writeFileSync(path.join(dir, '02-end.guide'), guide('end', header, `step Work\n${body(broken)}`));
	return ['--honest', '--guides', dir, '--data', DATA_DIR];
}

for (const broken of [false, true]) test(`selecting a Mage-only tail as Warrior reports nothing played (${broken ? 'broken' : 'clean'})`, async () => {
	const args = pack('faction Alliance\nclass Mage', broken);
	const result = await quiet(() => cmd.run([...args, '--filter', '02-end', '--class', 'Warrior', '--format', 'json']));
	assert.equal(result.result, 1, result.out);
	assert.match(result.out, /nothing played/);
	assert.doesNotMatch(result.out, /"ok"|R5/);
	const context = await quiet(() => cmd.run([...args, '--filter', '01-start', '--class', 'Warrior', '--format', 'json']));
	assert.equal(context.result, 0, context.out);
	assert.equal(JSON.parse(context.out).played, 1);
});

test('automatic and explicit matching classes still play the selected tail', async () => {
	for (const broken of [false, true]) for (const classes of [[], ['--class', 'Mage']]) {
		const result = await quiet(() => cmd.run([...pack('faction Alliance\nclass Mage', broken), '--filter', '02-end', ...classes, '--format', 'json']));
		assert.equal(result.result, broken ? 1 : 0, result.out);
		const report = JSON.parse(result.out);
		assert.equal(report.played, 1);
		assert.deepEqual(report.findings.filter((f) => f.rule === 'R5').map((f) => f.cls), broken ? ['MAGE'] : []);
	}
});

function compiled(header, steps = `step Work\n${body(true)}`) {
	const result = compile(guide('audience', header, steps));
	assert.deepEqual(result.errors, []);
	return result.guides;
}

for (const [label, header] of [['class', 'class Mage'], ['race', 'race Dwarf'], ['faction', 'faction Horde']]) {
	test(`fixed-persona playback skips an incompatible ${label} header`, () => {
		const guides = compiled(header);
		assert.deepEqual(playChain(guides, fixtureData(), HUMAN), []);
		assert.deepEqual(honestPlay(guides, fixtureData(), () => [HUMAN]), []);
	});
}

for (const [header, persona] of [
	['', HUMAN],
	['faction Alliance\nrace Human\nclass Warrior', HUMAN],
	['faction Horde\nrace Undead\nclass Warrior', { ...HUMAN, faction: 'Horde', race: 'Scourge' }],
]) test(`matching or absent guide headers retain quest findings (${header || 'unrestricted'})`, () => {
	const findings = playChain(compiled(header), fixtureData(), persona);
	assert.ok(findings.some((f) => f.rule === 'R5' && /0\/10/.test(f.reason)), JSON.stringify(findings));
});

test('a skipped middle guide cannot supply quest state to later eligible work', () => {
	const result = compile({
		'01-start.guide': guide('start', 'next test/middle', 'step Begin\n  note Begin'),
		'02-middle.guide': guide('middle', 'class Mage\nnext test/end', 'step Prepare\n  accept 783\n  turnin 783\n  accept 7\n  kill 6 x10 quest 7.1'),
		'03-end.guide': guide('end', '', 'step Finish\n  turnin 7'),
	});
	assert.deepEqual(result.errors, []);
	const findings = honestPlay(result.guides, fixtureData(), () => [HUMAN], { play: ['test/end'] });
	assert.ok(findings.some((f) => f.rule === 'R5' && /never accepted/.test(f.reason)), JSON.stringify(findings));
	const mage = honestPlay(result.guides, fixtureData(), () => [{ ...HUMAN, cls: 'MAGE' }], { play: ['test/end'] });
	assert.deepEqual(mage.filter((f) => f.rule === 'R5'), []);
});

for (const [root, tail, race] of [
	['faction Alliance', 'faction Alliance\nrace Dwarf', 'Dwarf'],
	['', 'faction Horde\nrace Skyborne', 'Skyborne'],
	['faction Horde', 'race Skyborne', 'Skyborne'],
	['race Skyborne', 'faction Horde', 'Skyborne'],
]) test(`later guide headers sample eligible races and factions (${root} -> ${tail})`, async () => {
	const result = await quiet(() => cmd.run([...pack(`${tail}\nclass Warrior`, true, root), '--filter', '02-end', '--format', 'json']));
	assert.equal(result.result, 1, result.out);
	const report = JSON.parse(result.out);
	assert.deepEqual(report.findings.filter((f) => f.rule === 'R5').map((f) => [f.race, f.cls]), [[race, 'WARRIOR']]);
});

for (const explicit of [false, true]) test(`${explicit ? 'an explicit' : 'a named'} class is sampled within the later guide faction`, async () => {
	for (const selection of [[], ['--filter', '02-end']]) {
		const args = pack(`faction Horde\n${explicit ? '' : 'class Druid'}`, true, '');
		const result = await quiet(() => cmd.run([...args, ...selection, ...(explicit ? ['--class', 'Druid'] : []), '--format', 'json']));
		assert.equal(result.result, 1, result.out);
		const report = JSON.parse(result.out);
		assert.deepEqual(report.findings.filter((f) => f.rule === 'R5').map((f) => [f.race, f.cls]), [['Tauren', 'DRUID']]);
	}
});
