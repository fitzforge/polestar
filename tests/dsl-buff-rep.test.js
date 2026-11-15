'use strict';
// The compiler side of the `buff` goal, a `rep` goal's points and the `rep` and `buff` when
// predicates (pack format 11; docs/GUIDE_FORMAT.md). The JS twin of forge-guide's
// tests/guide/dsl_buff_rep.rs; the engine side is tests/engine-buff-rep.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { parseWhen } = require('../tools/lib/dsl/when');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, BUFF_REP_FORMAT, MONEY_TASK_FORMAT, FORMAT, NEEDS } = require('../tools/lib/pack/format');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const emit = (r) => emitGuides(r.guides.map((guide) => ({ guide, source: null })), false);

test('`when rep`: a faction by name or id, a standing by word or number, with points inside it', () => {
	assert.deepEqual(parseWhen('rep "Stormwind" Honored').value, { k: 'rep', name: 'Stormwind', standing: 6 });
	assert.deepEqual(parseWhen('!rep Stormwind Friendly').value, { k: 'rep', neg: true, name: 'Stormwind', standing: 5 });
	assert.deepEqual(parseWhen('rep Argent Dawn Revered+12000').value, { k: 'rep', name: 'Argent Dawn', standing: 7, points: 12000 });
	assert.deepEqual(parseWhen('rep 72 7').value, { k: 'rep', faction: 72, standing: 7 });
	assert.deepEqual(parseWhen('rep "72" Neutral+1').value, { k: 'rep', name: '72', standing: 4, points: 1 }, 'a quoted number is a name');
	for (const bad of ['rep', 'rep Stormwind', 'rep Stormwind Liked', 'rep Stormwind 9', 'rep Stormwind Honored+0', 'rep Stormwind Exalted+1000', 'rep Stormwind Hated']) {
		assert.ok(parseWhen(bad).error, bad);
	}
	assert.ok(parseWhen('rep Stormwind Hated+1').value, 'points into Hated can fail to hold');
});

test('`when buff`: an aura by spell id', () => {
	assert.deepEqual(parseWhen('buff 1126').value, { k: 'buff', spell: 1126 });
	assert.deepEqual(parseWhen('!buff 1126').value, { k: 'buff', neg: true, spell: 1126 });
	for (const bad of ['buff', 'buff 0', 'buff "Mark of the Wild"', 'buff 1 2']) assert.ok(parseWhen(bad).error, bad);
});

test('a `rep` predicate compiles with the id of its faction, on a step, a jump and a hand-off', () => {
	const text = guideText(['step One', '  when rep Stormwind Honored', '  when !rep 72 Revered+500', '  when !buff 1126', '  skipto end when rep "Stormwind" Exalted', '  accept 783', 'step Two', '  label end', '  turnin 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	const [one] = plain(r.guides[0].steps);
	assert.deepEqual(one.when, [
		{ k: 'rep', name: 'Stormwind', faction: 72, standing: 6 },
		{ k: 'rep', neg: true, name: 'Stormwind', faction: 72, standing: 7, points: 500 },
		{ k: 'buff', neg: true, spell: 1126 },
	]);
	assert.deepEqual(one.skipto, [{ to: 'end', when: { k: 'rep', name: 'Stormwind', faction: 72, standing: 8 } }]);
	const out = emit(r);
	assert.ok(out.includes('\t\t\t\t\twhen = { { k = "rep", name = "Stormwind", faction = 72, standing = 6 }, { k = "rep", neg = true, name = "Stormwind", faction = 72, standing = 7, points = 500 }, { k = "buff", neg = true, spell = 1126 } },\n'), out);
	assert.ok(out.includes('\t\t\t\t\tskipto = { { to = "end", when = { k = "rep", name = "Stormwind", faction = 72, standing = 8 } } },\n'), out);

	const follower = ['guide t/friend', 'title Friend', 'faction Alliance', 'levels 10-20', 'zone Elwynn Forest', 'pitch For friends of the city.', '', 'step Start', '  note Go on.', ''].join('\n');
	const main = ['guide t/main', 'title Main', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', 'next t/friend when rep Stormwind Friendly', '', 'step Start', '  note Go on.', ''].join('\n');
	const n = compile({ 'main.guide': main, 'friend.guide': follower });
	assert.deepEqual(n.errors, [], n.text);
	assert.deepEqual(plain(n.guides.find((g) => g.id === 't/main').nextWhen), { 't/friend': [{ k: 'rep', name: 'Stormwind', faction: 72, standing: 5 }] });
	assert.equal(formatFor(n.guides), BUFF_REP_FORMAT);
});

test('a faction the data does not know: an error by name, a warning by id', () => {
	const unknown = guideText(['step One', '  when rep Nobody Honored', '  accept 783']);
	assert.deepEqual(compile(unknown).errors, [`test.guide:${lineOf(unknown, 'when rep Nobody Honored')}: unknown faction "Nobody"; give its id: \`rep <factionId> <Standing>\``]);
	const byId = compile(guideText(['step One', '  when rep 4242 Honored', '  accept 783']));
	assert.deepEqual(byId.errors, [], byId.text);
	assert.deepEqual(plain(byId.guides[0].steps)[0].when, [{ k: 'rep', faction: 4242, standing: 6 }]);
	assert.equal(byId.warnings.filter((w) => w.includes('faction 4242 is not in data')).length, 1);
});

test('a `rep` goal takes points inside its standing, and every standing by name', () => {
	const r = compile(guideText(['step One', '  rep Stormwind Revered+12000', '  rep 72 Honored', '  rep Stormwind Unfriendly']));
	assert.deepEqual(r.errors, [], r.text);
	const [withPoints, plainGoal, low] = goalsOf(r);
	assert.deepEqual([withPoints.t, withPoints.faction, withPoints.standing, withPoints.points], ['rep', 72, 7, 12000]);
	assert.equal(plainGoal.points, undefined);
	assert.equal(low.standing, 3);
	const out = emit(r);
	assert.ok(out.includes('{ t = "rep", faction = 72, factionName = "Stormwind", standing = 7, points = 12000 },\n'), out);
	assert.ok(out.includes('{ t = "rep", faction = 72, factionName = "Stormwind", standing = 6 },\n'), out);
	assert.ok(compile(guideText(['step One', '  rep Stormwind Revered+0'])).errors.some((e) => e.includes('points inside a standing start at 1')));
	assert.ok(compile(guideText(['step One', '  rep Stormwind Exalted+1000'])).errors.some((e) => e.includes('Exalted has 999 points at most')));
});

test('a `buff` goal: the aura to have, or with `off` to be rid of; its name is required', () => {
	const r = compile(guideText(['step One', '  buff 1126 "Mark of the Wild" @47.6,35.1', '  buff 15007 "Resurrection Sickness" off optional']));
	assert.deepEqual(r.errors, [], r.text);
	const [on, off] = goalsOf(r);
	assert.deepEqual([on.t, on.spell, on.spellName, on.off, on.x, on.y], ['buff', 1126, 'Mark of the Wild', undefined, 47.6, 35.1]);
	assert.deepEqual([off.t, off.spell, off.off, off.optional], ['buff', 15007, true, true]);
	const out = emit(r);
	assert.ok(out.includes('{ t = "buff", spell = 1126, spellName = "Mark of the Wild", map = 1429, x = 47.6, y = 35.1, f = "e" },\n'), out);
	assert.ok(out.includes('{ t = "buff", spell = 15007, spellName = "Resurrection Sickness", off = true, optional = true },\n'), out);
	const text = guideText(['step One', '  buff 999999']);
	assert.deepEqual(compile(text).errors, [`test.guide:${lineOf(text, 'buff 999999')}: spell 999999 is not in data; give its name: \`buff 999999 "Name"\``]);
	assert.ok(compile(guideText(['step One', '  kill 6 off'])).errors.some((e) => e.includes('`off` does not apply to `kill`')));
});

test('format 11: a guide with any of them, read by Polestar 0.4.1 and later', () => {
	assert.equal(BUFF_REP_FORMAT, 11);
	assert.equal(NEEDS[BUFF_REP_FORMAT], '0.4.1');
	const step = (extra) => [{ steps: [{ goals: [{ t: 'task', text: 'x' }], ...extra }] }];
	assert.equal(formatFor(step({})), MONEY_TASK_FORMAT);
	assert.equal(formatFor(step({ when: [{ k: 'rep', faction: 72, standing: 6 }] })), 11);
	assert.equal(formatFor(step({ when: [{ k: 'buff', spell: 1 }] })), 11);
	assert.equal(formatFor(step({ skipto: [{ to: 'end', when: { k: 'buff', spell: 1 } }] })), 11);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'buff', spell: 1, spellName: 'A' }] }] }]), 11);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'rep', faction: 72, standing: 6, points: 100 }] }] }]), 11);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'rep', faction: 72, standing: 6 }] }] }]), FORMAT, 'a plain `rep` goal is as old as format 3');
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'accept', quest: 1 }] }], nextWhen: { 'a/b': [{ k: 'rep', faction: 72, standing: 6 }] } }]), 11);
});
