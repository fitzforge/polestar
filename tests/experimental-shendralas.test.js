'use strict';
// The Shen'dralas guide (guides/forever/40-50/shendralas.guide, both factions' route), compiled with the
// reference data: the order players' recordings support, pinned so an edit can't undo it unseen.
//
// Needs data/forever (forge data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { buildSimPack, playGuide } = require('../tools/lib/playtest');
const { DATA, ROOT } = require('../tools/lib/paths');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'items.json', 'map-frames.json');

let list;
// The guide's goals in order, as { step, goal }.
function goals() {
	if (!list) {
		const file = path.join(ROOT, 'guides', 'forever', '40-50', 'shendralas.guide');
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], loadData(DATA));
		assert.equal(guides.length, 1, 'the guide compiles');
		list = guides[0].steps.flatMap((step) => step.goals.map((goal) => ({ step, goal })));
	}
	return list;
}
const first = (pred, what) => {
	const i = goals().findIndex(({ goal }) => pred(goal));
	assert.ok(i >= 0, `${what} is in the guide`);
	return i;
};
const is = (t, quest) => (g) => g.t === t && g.quest === quest;

test("Shen'dralas: Mordent's pylons come in the order he offers them, each after the hand-in before it", { skip }, () => {
	const order = [
		[is('accept', 92914), 'Strange Pylons taken'],
		[is('turnin', 92914), 'Strange Pylons handed in'],
		[is('accept', 96010), 'Fragments of the Pylons taken'],
		[is('turnin', 96010), 'Fragments of the Pylons handed in'],
		[is('accept', 96018), 'Powering the Pylons taken'],
		[is('turnin', 96018), 'Powering the Pylons handed in'],
		[is('accept', 93016), 'A Brief History Lesson taken'],
		[is('accept', 93394), 'Meeting the Magister taken'],
		[is('turnin', 93394), 'Meeting the Magister handed in'],
	].map(([pred, what]) => first(pred, what));
	assert.deepEqual([...order].sort((a, b) => a - b), order, 'each comes after the one before it');
	assert.equal(goals()[order[0]].goal.object, 577959, 'Strange Pylons starts at the western pylon');
});

test("Shen'dralas: the temple's quests wait for Meeting the Magister, as the only recorded player had them", { skip }, () => {
	const met = first(is('turnin', 93394), 'Meeting the Magister handed in');
	assert.ok(first(is('accept', 93341), 'Forlorn Gardens taken') > met, 'Mithera after Kirandis');
	const lateBiraxas = goals().findIndex(({ goal }, i) => i > met && is('accept', 99257)(goal));
	assert.ok(lateBiraxas > met, 'Biraxas is offered again after Kirandis');
	// 0.4.0 fix round: A Heart of Crystal (a non-elite Decrepit Pylon Protector by the road, 3,600 XP; 2 recorded players
	// did it) is part of both routes, no longer optional.
	for (const { goal } of goals().filter(({ goal }) => is('accept', 99257)(goal))) assert.ok(!goal.optional, 'taken by the route');
});

// The two pylon credits are separate from the Sieve and the later Protector heart.
test("Shen'dralas: each unfinished pylon gets four crystals and its own repair credit", { skip }, () => {
	const list = goals();
	const sieve = first(g => g.t === 'collect' && g.item === 255662, 'Mana Sieve');
	const repairs = list.flatMap(({ goal }, i) => goal.t === 'interact' && goal.quest === 96018 ? [{ goal, i }] : []);
	assert.deepEqual(repairs.map(({ goal }) => [goal.oi, goal.object]), [[2, 577959], [3, 577960]]);
	let previous = sieve;
	for (const { goal, i } of repairs) {
		const material = list.slice(previous + 1, i).find(({ goal: g }) => g.t === 'collect' && g.item === 255667);
		assert.ok(material && material.goal.count === 4, `four unspent crystals before repair ${goal.oi}`);
		assert.ok(material.step.goals.some(g => g.t === 'use' && g.item === 255662));
		assert.equal(goal.map, 2652);
		previous = i;
	}
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.quest === 96018), 'killing the guard does not repair a pylon');
	assert.ok(first(is('turnin', 96018), 'repair reward') > previous);
});

test("Shen'dralas: skipping an unfinished repair never offers Mordent’s payment or the locked garden chain (#2923, #3014)", { skip }, () => {
	const file = 'forever/40-50/shendralas.guide';
	const pack = buildSimPack([file]);
	try {
		const guide = pack.guides[0];
		const inspect = `local E=Polestar.Engine; local steps=E.GetGuide().steps; local hand
			for i,s in ipairs(steps) do for _,g in ipairs(s.goals) do if g.t=='turnin' and g.quest==96018 then hand=i end end end
			assert(hand); E.SkipUpTo(hand); stub.advance(1)
			local i=E.GetLiveStep(); local open={}; if i then for j,g in ipairs(steps[i].goals) do
				if E.Applies(i,j) and not E.GoalDone(i,j) and not g.optional then open[#open+1]={g.t,g.quest or 0} end
			end end; emit(open[1])`;
		for (const [state, want] of [
			['w.onQuest(96018,{{type="item",required=1,fulfilled=1},{type="event",required=1,fulfilled=1},{type="event",required=1,fulfilled=0}})', ['goto', 0]],
			['w.onQuest(96018,{{type="item",required=1,fulfilled=1},{type="event",required=1,fulfilled=1},{type="event",required=1,fulfilled=1}})', ['turnin', 96018]],
			['w.complete({96018})', ['accept', 93016]],
		]) {
			const [open] = playGuide(pack, guide, { race: 'Orc', faction: 'Horde', cls: 'ROGUE',
				before: `w.level=46; w.moveTo(2652,43.97,35.59); w.setZone("Shen'dralas"); w.complete({96010}); ${state}`, script: inspect });
			assert.deepEqual(open, want);
		}
	} finally { pack.dispose(); }
});
