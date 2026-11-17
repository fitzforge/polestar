'use strict';
// The compiler side of the `deposit` and `equip` goals and the `equipped` and `indoors` when
// predicates (pack format 11; docs/GUIDE_FORMAT.md). The JS twin of forge-guide's
// tests/guide/dsl_deposit_equip.rs; the engine side is tests/engine-deposit-equip.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { parseWhen } = require('../tools/lib/dsl/when');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, DEPOSIT_EQUIP_FORMAT, FORMAT, NEEDS } = require('../tools/lib/pack/format');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const emit = (r) => emitGuides(r.guides.map((guide) => ({ guide, source: null })), false);

test('`deposit`: an item into the bank, until the bags hold none or the bank holds a count', () => {
	const r = compile(guideText(['step Bank', '  deposit 750', '  deposit 750 x15 @47.6,35.1']));
	assert.deepEqual(r.errors, [], r.text);
	const [all, some] = goalsOf(r);
	assert.deepEqual([all.t, all.item, all.itemName, all.count], ['deposit', 750, 'Tough Wolf Meat', undefined]);
	assert.deepEqual([some.count, some.x, some.y], [15, 47.6, 35.1]);
	const out = emit(r);
	assert.ok(out.includes('{ t = "deposit", item = 750, itemName = "Tough Wolf Meat" },\n'), out);
	assert.ok(out.includes('{ t = "deposit", item = 750, itemName = "Tough Wolf Meat", count = 15, map = 1429, x = 47.6, y = 35.1, f = "e" },\n'), out);
	assert.ok(compile(guideText(['step Bank', '  deposit 999999'])).errors.length >= 1, 'an item the data lacks needs its name');
	assert.deepEqual(compile(guideText(['step Bank', '  deposit 999999 "New Thing"'])).errors, []);
	assert.ok(compile(guideText(['step Bank', '  deposit 750 quest 33.1'])).errors.some((e) => e.includes('`quest` does not apply to `deposit`')));
	assert.ok(compile(guideText(['step Bank', '  deposit'])).errors.some((e) => e.includes('`deposit` needs an item id')));
});

test('`equip`: an item to wear, or with `off` to take off', () => {
	const r = compile(guideText(['step Gear', '  equip 750', '  equip 750 off optional']));
	assert.deepEqual(r.errors, [], r.text);
	const [on, off] = goalsOf(r);
	assert.deepEqual([on.t, on.item, on.off], ['equip', 750, undefined]);
	assert.deepEqual([off.off, off.optional], [true, true]);
	const out = emit(r);
	assert.ok(out.includes('{ t = "equip", item = 750, itemName = "Tough Wolf Meat" },\n'), out);
	assert.ok(out.includes('{ t = "equip", off = true, item = 750, itemName = "Tough Wolf Meat", optional = true },\n'), out);
	assert.ok(compile(guideText(['step Gear', '  kill 6 off'])).errors.some((e) => e.includes('`off` does not apply to `kill`')));
	assert.ok(compile(guideText(['step Gear', '  deposit 750 off'])).errors.some((e) => e.includes('`off` does not apply to `deposit`')));
});

test('`when equipped <item>` and `when indoors`', () => {
	assert.deepEqual(parseWhen('equipped 750').value, { k: 'equipped', item: 750 });
	assert.deepEqual(parseWhen('!equipped 750').value, { k: 'equipped', neg: true, item: 750 });
	assert.deepEqual(parseWhen('indoors').value, { k: 'indoors' });
	assert.deepEqual(parseWhen('!indoors').value, { k: 'indoors', neg: true });
	for (const bad of ['equipped', 'equipped Sword', 'equipped 0', 'indoors now']) assert.ok(parseWhen(bad).error, bad);
	const text = guideText(['step One', '  when !equipped 750', '  when indoors', '  skipto end when equipped 750', '  accept 783', 'step Two', '  label end', '  turnin 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	const [one] = plain(r.guides[0].steps);
	assert.deepEqual(one.when, [{ k: 'equipped', neg: true, item: 750 }, { k: 'indoors' }]);
	assert.deepEqual(one.skipto, [{ to: 'end', when: { k: 'equipped', item: 750 } }]);
	const out = emit(r);
	assert.ok(out.includes('\t\t\t\t\twhen = { { k = "equipped", neg = true, item = 750 }, { k = "indoors" } },\n'), out);
	assert.ok(out.includes('\t\t\t\t\tskipto = { { to = "end", when = { k = "equipped", item = 750 } } },\n'), out);
	const unknown = guideText(['step One', '  when equipped 999999', '  accept 783']);
	assert.deepEqual(compile(unknown).warnings.filter((w) => w.includes('item 999999')), [`test.guide:${lineOf(unknown, 'when equipped 999999')}: item 999999 is not in data (new Forever content?)`]);
});

test('format 11: a guide with either goal or either predicate, read by Polestar 0.4.1 and later', () => {
	assert.equal(DEPOSIT_EQUIP_FORMAT, 11);
	assert.equal(NEEDS[DEPOSIT_EQUIP_FORMAT], '0.4.1');
	const step = (extra) => [{ steps: [{ goals: [{ t: 'accept', quest: 1 }], ...extra }] }];
	assert.equal(formatFor(step({})), FORMAT);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'deposit', item: 1 }] }] }]), 11);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'equip', item: 1 }] }] }]), 11);
	assert.equal(formatFor(step({ when: [{ k: 'equipped', item: 1 }] })), 11);
	assert.equal(formatFor(step({ when: [{ k: 'indoors' }] })), 11);
	assert.equal(formatFor(step({ skipto: [{ to: 'end', when: { k: 'indoors', neg: true } }] })), 11);
	assert.equal(formatFor([{ steps: [{ goals: [{ t: 'accept', quest: 1 }] }], nextWhen: { 'a/b': [{ k: 'equipped', item: 1 }] } }]), 11);
});

test("the route planner's goal editor writes the `deposit` and `equip` goals and `off`", () => {
	const { goalFields, formatGoal, verbSchema } = require('../tools/lib/planner/goalfmt');
	const { parseGuide } = require('../tools/lib/dsl/parse');
	const { Diagnostics } = require('../tools/lib/dsl/diag');
	const written = (text) => formatGoal(goalFields(parseGuide(guideText(['step Bank', `  ${text}`]), 'x', new Diagnostics()).steps[0].goals[0]));
	assert.equal(written('deposit 750 x15 @47.6,35.1'), 'deposit 750 @47.6,35.1 x15');
	assert.equal(written('deposit 750 "Tough Wolf Meat" optional'), 'deposit 750 "Tough Wolf Meat" optional');
	assert.equal(written('equip 750 optional off'), 'equip 750 off optional');
	assert.equal(formatGoal({ verb: 'equip', item: '750', text: 'Put it on', optional: true }), 'equip 750 optional "Put it on"');
	const { verbs } = verbSchema();
	assert.deepEqual(verbs.deposit.positional.map((p) => p.key), ['item', 'itemName']);
	assert.ok(verbs.deposit.modifiers.some((m) => m.key === 'count'));
	assert.ok(verbs.equip.modifiers.some((m) => m.key === 'off' && m.type === 'bool' && m.mod === 'off'));
	assert.ok(!verbs.deposit.modifiers.some((m) => m.key === 'off'));
});
