'use strict';
// The `deposit` and `equip` goals and the `equipped` and `indoors` when predicates (pack format
// 11; docs/GUIDE_FORMAT.md) in the real Engine. Each guide is compiled from the fixture data and
// played against the stub world (tests/helpers/play-guide.js). The compiler side:
// tests/dsl-deposit-equip.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide } = require('./helpers/play-guide');

test('`deposit` is done once the bags hold none of the item, and at once for a character without it', () => {
	const [none] = playGuide(['step Bank', '  deposit 750', 'step Then', '  task "Go on"'], 'snap()');
	assert.equal(none.live, 2, 'nothing to deposit: the step passes');
	const [held, banked, back] = playGuide(['step Bank', '  deposit 750', '  accept 783', 'step Then', '  task "Go on"'],
		`snap()
		w.deposit(750)
		snap()
		w.addItem(750, 2)
		snap()`, 'w.items[750] = 4');
	assert.equal(held.live, 1);
	assert.notEqual(held.steps[0].goals[0].status, 'done');
	assert.equal(banked.steps[0].goals[0].status, 'done');
	assert.equal(back.steps[0].goals[0].status, 'done', 'looting more while the step is open does not reopen it');
});

test('a `deposit` on a step ahead is not kept as done before the item is in the bags', () => {
	// Step 2's deposit reads done while the bags are empty; the item looted at step 1 must still be banked.
	const [ahead, looted, banked] = playGuide(['step Loot', '  collect 750 x4', 'step Bank', '  deposit 750', '  accept 783', 'step Then', '  task "Go on"'],
		`snap()
		w.addItem(750, 4)
		snap()
		w.deposit(750)
		snap()`);
	assert.equal(ahead.live, 1);
	assert.equal(looted.live, 2);
	assert.notEqual(looted.steps[1].goals[0].status, 'done', 'the meat is in the bags now: the deposit is open');
	assert.equal(banked.steps[1].goals[0].status, 'done');
});

test('`deposit … xN` counts what the bank holds', () => {
	const [short, enough] = playGuide(['step Bank', '  deposit 750 x15', 'step Then', '  task "Go on"'],
		`w.deposit(750)
		snap()
		w.addItem(750, 5)
		w.deposit(750)
		snap()`, 'w.items[750] = 10');
	assert.equal(short.live, 1);
	assert.deepEqual([short.steps[0].goals[0].cur, short.steps[0].goals[0].max], [10, 15]);
	assert.equal(enough.live, 2);
});

test('`equip` is done while the item is worn and kept once its step had it; `off` the other way round', () => {
	const [bare, worn, removed] = playGuide(['step Gear', '  equip 750', '  accept 783', 'step Then', '  task "Go on"'],
		`snap()
		w.equip(750, true)
		snap()
		w.equip(750, false)
		snap()`);
	assert.notEqual(bare.steps[0].goals[0].status, 'done');
	assert.equal(worn.steps[0].goals[0].status, 'done');
	assert.equal(removed.steps[0].goals[0].status, 'done');
	const [on, off] = playGuide(['step Gear', '  equip 750 off', 'step Then', '  task "Go on"'], `snap()
		w.equip(750, false)
		snap()`, 'w.equipped[750] = true');
	assert.equal(on.live, 1);
	assert.equal(off.live, 2);
});

test("a client that cannot say what is worn: the `equip` goal is the player's to tick", () => {
	const [manual, ticked] = playGuide(['step Gear', '  equip 750', 'step Then', '  task "Go on"'], `w.unsupport("equipment")
		snap()
		E.ToggleGoal(1, 1)
		snap()`);
	assert.equal(manual.steps[0].goals[0].manual, true);
	assert.equal(manual.live, 1);
	assert.equal(ticked.live, 2);
});

test('`when equipped` and `when indoors`: the step applies while the predicate holds', () => {
	const lines = ['step Worn', '  when equipped 750', '  task "A"', 'step Not worn', '  when !equipped 750', '  task "B"', 'step Inside', '  when indoors', '  task "C"', 'step Outside', '  when !indoors', '  task "D"'];
	const [bare, changed] = playGuide(lines, `snap()
		w.equip(750, true)
		w.indoors = true
		stub.fire("ZONE_CHANGED_INDOORS")
		snap()`);
	assert.deepEqual(bare.steps.map((s) => s.applies), [false, true, false, true]);
	assert.deepEqual(changed.steps.map((s) => s.applies), [true, false, true, false]);
});

test('a client that will not say: `equipped` and `indoors` hold neither way', () => {
	const lines = ['step Worn', '  when equipped 750', '  task "A"', 'step Not worn', '  when !equipped 750', '  task "B"', 'step Inside', '  when indoors', '  task "C"', 'step Outside', '  when !indoors', '  task "D"', 'step Always', '  task "E"'];
	const [view] = playGuide(lines, `w.unsupport("equipment")
		IsIndoors = nil
		snap()`);
	assert.deepEqual(view.steps.map((s) => s.applies), [false, false, false, false, true]);
});

test('Guides.Validate reads the new verbs and predicates and refuses malformed ones', () => {
	const [out] = playGuide(['step One', '  task "A"'], `local V = Polestar.Guides.Validate
		local function def(goal, when)
			return { id = "test/v", title = "V", steps = { { when = when, goals = { goal } } } }
		end
		local equip = { t = "equip", item = 750, itemName = "Tough Wolf Meat" }
		local deposit = { t = "deposit", item = 750, itemName = "Tough Wolf Meat", count = 15 }
		local function with(base, k, v) local o = {} for a, b in pairs(base) do o[a] = b end o[k] = v return o end
		emit({
			ok = V(def(with(equip, "off", true), { { k = "equipped", neg = true, item = 750 }, { k = "indoors" } })) == nil and V(def(deposit)) == nil,
			off = V(def(with(equip, "off", 1))) or "",
			offElsewhere = V(def(with(deposit, "off", true))) or "",
			noItem = V(def({ t = "deposit", itemName = "Tough Wolf Meat" })) or "",
			count = V(def(with(deposit, "count", "many"))) or "",
			whenEquipped = V(def(equip, { { k = "equipped" } })) or "",
		})`);
	assert.equal(out.ok, true);
	assert.match(out.off, /bad off/);
	assert.match(out.offElsewhere, /bad off/);
	assert.notEqual(out.noItem, '');
	assert.match(out.count, /bad count/);
	assert.match(out.whenEquipped, /bad when/);
});
