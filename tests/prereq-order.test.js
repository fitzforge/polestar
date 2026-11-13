'use strict';
// Quest prerequisites in route order, branch by branch (tools/lib/route/prereq-order.js): tiny guide
// chains played per start, race and class. The Wetlands report (2026-11-07) had a guide take quests whose
// chain the route never did; lint's check counts a hand-in on any branch into the guide, so a hand-in
// one start makes hid the hole in another.
//
// Needs data/forever; skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { needs } = require('./helpers/data');

const skip = needs('quests.json', 'npcs.json', 'objects.json');

let data = null;
// files: { name: text } -> the check's findings as "file:line quest<-missing race path-start".
// recorded: recordedPrereqs()'s shape, { quest: [ids] }.
function check(files, recorded) {
	const { compileSources } = require('../tools/lib/dsl/project');
	const { loadData } = require('../tools/lib/dsl/data');
	const { DATA } = require('../tools/lib/paths');
	const { prereqOrder } = require('../tools/lib/route/prereq-order');
	data = data || loadData(DATA);
	const { guides } = compileSources(Object.entries(files).map(([file, text]) => ({ file, source: file, text })), data);
	return [...new Set(prereqOrder(guides, data, { recorded }).map((v) => `${v.file}:${v.line} ${v.quest}<-${v.missing.join(',')} ${v.race} ${v.path[0]}`))];
}
const head = (id, more = '', faction = 'Alliance') => `guide ${id}\ntitle ${id}\nfaction ${faction}\nlevels 20-30\nzone Wetlands\n${more}\n`;

// Karl Boran's Reclaiming Goods (281) follows Claws from the Deep (279).
test('a hand-in on one start does not count for another: each start\'s path is played alone', { skip }, () => {
	const shared = head('t/menethil') + 'step Karl Boran\n  accept 281\n';
	const dwarf = head('t/dwarf', 'race Dwarf\nnext t/menethil') + 'step Karl Boran\n  accept 279\n  turnin 279\n';
	const human = head('t/human', 'race Human\nnext t/menethil') + 'step Karl Boran\n  goto 10.8,59.8\n';
	assert.deepEqual(check({ 'menethil.guide': shared, 'dwarf.guide': dwarf, 'human.guide': human }), ['menethil.guide:8 281<-279 Human t/human']);
	const humanFixed = head('t/human', 'race Human\nnext t/menethil') + 'step Karl Boran\n  accept 279\n  turnin 279\n';
	assert.deepEqual(check({ 'menethil.guide': shared, 'dwarf.guide': dwarf, 'human.guide': humanFixed }), []);
});

test('an accept before its prerequisite\'s hand-in, or after a hand-in the character never plays, is reported', { skip }, () => {
	const early = head('t/early', 'race Dwarf') + 'step Karl Boran\n  accept 279\n  accept 281\n  turnin 279\n';
	assert.deepEqual(check({ 'early.guide': early }), ['early.guide:9 281<-279 Dwarf t/early']);
	const onlyHuman = head('t/only', 'race Dwarf,Human') + 'step Karl Boran\n  accept 279\n  turnin 279 only Human\n  accept 281\n';
	assert.deepEqual(check({ 'only.guide': onlyHuman }), ['only.guide:10 281<-279 Dwarf t/only']);
	const right = head('t/right', 'race Dwarf') + 'step Karl Boran\n  accept 279\n  turnin 279\n  accept 281\n';
	assert.deepEqual(check({ 'right.guide': right }), []);
});

test('`when group` is played both ways: a group step\'s accept needs its prerequisite too', { skip }, () => {
	const g = head('t/group', 'race Dwarf') + 'step Karl Boran\n  when group 281\n  accept 281\n\nstep Karl Boran\n  accept 279\n  turnin 279\n';
	assert.deepEqual(check({ 'group.guide': g }), ['group.guide:9 281<-279 Dwarf t/group']);
});

// #1299: the data named no prerequisite for This Land Was Their Land, which the giver offers only after Defeat
// Nek'rosh, so the check above passed an accept nobody could take. The prerequisites players' recordings teach
// (data/recorded/quests.json) count too. Here Claws from the Deep (279, no prerequisite in the data) plays as if
// recorded after The Third Fleet (288).
test('a recorded prerequisite is needed before the accept, as one of the data\'s own prerequisites or the recorded ones', { skip }, () => {
	const early = head('t/early', 'race Dwarf') + 'step Karl Boran\n  accept 279\n';
	assert.deepEqual(check({ 'early.guide': early }, { 279: [288] }), ['early.guide:8 279<-288 Dwarf t/early']);
	assert.deepEqual(check({ 'early.guide': early }), [], 'without the recording the data sees nothing wrong');
	const after = head('t/after', 'race Dwarf') + 'step Menethil\n  accept 288\n  turnin 288\n  accept 279\n';
	assert.deepEqual(check({ 'after.guide': after }, { 279: [288] }), []);
	// Reclaiming Goods (281) has the data prerequisite 279: either one opens it here, so the recording only widens.
	const own = head('t/own', 'race Dwarf') + 'step Karl Boran\n  accept 279\n  turnin 279\n  accept 281\n';
	assert.deepEqual(check({ 'own.guide': own }, { 281: [288] }), []);
});

test('a recorded prerequisite that is the quest\'s breadcrumb never blocks it', { skip }, () => {
	// The Forgotten Pools (870) is offered right after The Barrens Oases (886), its breadcrumb, for players who carried it.
	const g = head('t/pools', 'race Orc', 'Horde') + 'step Tonga Runetotem\n  accept 870\n';
	assert.deepEqual(check({ 'pools.guide': g }, { 870: [886] }), []);
});

test('the check takes the recorded prerequisites Lookup shows, and none of a quest whose prerequisites a correction sets', () => {
	const { recordedPrereqs } = require('../tools/lib/route/prereq-order');
	const fact = (value, status) => ({ value, voters: 3, counted: 2, status, builds: [70862, 70888], beats: null });
	const learned = {
		279: { pre: [fact(288, 'trusted'), fact(290, 'gap'), fact(291, 'stale'), fact(292, 'conflict')] },
		281: { pre: [fact(288, 'gap')] },
		282: { notPre: [fact(279, 'trusted')] },
	};
	assert.deepEqual(recordedPrereqs(learned), { 279: [288, 290, 291], 281: [288] });
	assert.deepEqual(recordedPrereqs(learned, { 281: { set: { preAny: [279] } }, 279: { set: { xp: 100 } } }), { 279: [288, 290, 291] });
});
