'use strict';
// The `buff` goal, a `rep` goal's points and the `rep` and `buff` when predicates (pack format
// 11; docs/GUIDE_FORMAT.md) in the real Engine. Each guide is compiled from the fixture data and
// played against the stub world (tests/helpers/play-guide.js). The compiler side:
// tests/dsl-buff-rep.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide, statuses } = require('./helpers/play-guide');

test('a `buff` goal is done with the aura on the player and kept once its step had it', () => {
	const [none, gained, ranOut] = playGuide(
		['step A blessing first', '  buff 1126 "Mark of the Wild"', '  accept 783', 'step Then', '  task "Go on"'],
		`snap()
		w.setAura(1126, true)
		snap()
		w.setAura(1126, false)
		snap()`,
	);
	assert.equal(none.live, 1);
	assert.deepEqual([statuses(none, 1)[0] === 'done', none.steps[0].goals[0].manual], [false, false]);
	assert.equal(statuses(gained, 1)[0], 'done');
	assert.equal(statuses(ranOut, 1)[0], 'done', "the aura ran out while the step's other goal is open: the goal stays done");
	assert.equal(ranOut.live, 1, 'the accept still holds the step');
});

test('a `buff … off` goal is done while the aura is gone', () => {
	const [on, off] = playGuide(
		['step Wait it out', '  buff 15007 "Resurrection Sickness" off', 'step Then', '  task "Go on"'],
		`snap()
		w.setAura(15007, false)
		snap()`,
		'w.auras[15007] = true',
	);
	assert.equal(on.live, 1);
	assert.equal(off.live, 2);
});

test("a client that cannot read auras: the `buff` goal is the player's to tick", () => {
	const [view, ticked] = playGuide(['step A blessing first', '  buff 1126 "Mark of the Wild"', 'step Then', '  task "Go on"'], `w.unsupport("aura")
		snap()
		E.ToggleGoal(1, 1)
		snap()`);
	assert.equal(view.steps[0].goals[0].manual, true);
	assert.equal(view.live, 1);
	assert.equal(ticked.live, 2);
});

test('`when buff` and `when rep`: the step applies while the predicate holds', () => {
	const lines = ['step With the aura', '  when buff 1126', '  task "A"', 'step Honored', '  when rep Stormwind Honored', '  task "B"', 'step Not yet 500 into Revered', '  when !rep Stormwind Revered+500', '  task "C"', 'step Always', '  task "D"'];
	const [bare, aura, honored, revered, past] = playGuide(lines,
		`snap()
		w.setAura(1126, true)
		snap()
		w.setAura(1126, false)
		w.setRep(72, "Stormwind", 6, 9500, 9000, 21000)
		snap()
		w.setRep(72, "Stormwind", 7, 21100, 21000, 42000)
		snap()
		w.setRep(72, "Stormwind", 7, 21500, 21000, 42000)
		snap()`,
	);
	const applies = (snapshot) => snapshot.steps.map((s) => s.applies);
	// A faction the character has not met is below every standing.
	assert.deepEqual(applies(bare), [false, false, true, true]);
	assert.deepEqual(applies(aura), [true, false, true, true]);
	assert.deepEqual(applies(honored), [false, true, true, true]);
	assert.deepEqual(applies(revered), [false, true, true, true], '100 points into Revered: not yet 500');
	assert.deepEqual(applies(past), [false, true, false, true], '500 points into Revered');
});

test('`when buff` on a client that will not say holds neither way', () => {
	const [view] = playGuide(['step With', '  when buff 1126', '  task "A"', 'step Without', '  when !buff 1126', '  task "B"', 'step Always', '  task "C"'],
		`C_UnitAuras.GetPlayerAuraBySpellID = function() error("refused") end
		snap()`);
	assert.deepEqual(view.steps.map((s) => s.applies), [false, false, true]);
});

test('a `rep` goal with points counts the points inside its standing', () => {
	const [below, short, reached, above] = playGuide(
		['step Grind', '  rep Stormwind Revered+500', 'step Then', '  task "Go on"'],
		`w.setRep(72, "Stormwind", 6, 20000, 9000, 21000)
		snap()
		w.setRep(72, "Stormwind", 7, 21300, 21000, 42000)
		snap()
		w.setRep(72, "Stormwind", 7, 21500, 21000, 42000)
		snap()
		w.setRep(72, "Stormwind", 8, 42000, 42000, 43000)
		snap()`,
	);
	assert.equal(below.live, 1);
	assert.equal(short.live, 1);
	assert.deepEqual([short.steps[0].goals[0].cur, short.steps[0].goals[0].max], [300, 500]);
	assert.equal(reached.live, 2);
	assert.equal(above.live, 2);
});

test('a `rep` goal without points is done at the start of its standing, as before', () => {
	const [below, reached] = playGuide(['step Grind', '  rep Stormwind Revered', 'step Then', '  task "Go on"'],
		`w.setRep(72, "Stormwind", 6, 20000, 9000, 21000)
		snap()
		w.setRep(72, "Stormwind", 7, 21000, 21000, 42000)
		snap()`);
	assert.equal(below.live, 1);
	assert.equal(reached.live, 2);
});

test('Guides.Validate reads the new keys and refuses malformed ones', () => {
	const [out] = playGuide(['step One', '  task "A"'], `local V = Polestar.Guides.Validate
		local function def(goal, when)
			return { id = "test/v", title = "V", steps = { { when = when, goals = { goal } } } }
		end
		local buff = { t = "buff", spell = 1126, spellName = "Mark of the Wild" }
		local rep = { t = "rep", faction = 72, factionName = "Stormwind", standing = 7 }
		local function with(base, k, v) local o = {} for a, b in pairs(base) do o[a] = b end o[k] = v return o end
		emit({
			ok = V(def(with(buff, "off", true), { { k = "rep", faction = 72, standing = 6, points = 100 }, { k = "buff", neg = true, spell = 1126 } })) == nil
				and V(def(with(rep, "points", 500))) == nil,
			off = V(def(with(buff, "off", "yes"))) or "",
			offElsewhere = V(def(with(rep, "off", true))) or "",
			points = V(def(with(rep, "points", 0))) or "",
			pointsElsewhere = V(def(with(buff, "points", 5))) or "",
			noName = V(def({ t = "buff", spell = 1126 })) or "",
			whenRep = V(def(buff, { { k = "rep", faction = 72, standing = 9 } })) or "",
			whenRepName = V(def(buff, { { k = "rep", name = "Stormwind", standing = 6 } })) or "",
			whenBuff = V(def(buff, { { k = "buff" } })) or "",
		})`);
	assert.equal(out.ok, true);
	assert.match(out.off, /bad off/);
	assert.match(out.offElsewhere, /bad off/);
	assert.match(out.points, /bad points/);
	assert.match(out.pointsElsewhere, /bad points/);
	assert.notEqual(out.noName, '');
	for (const k of ['whenRep', 'whenRepName', 'whenBuff']) assert.match(out[k], /bad when/, k);
});
