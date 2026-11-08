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
function check(files) {
	const { compileSources } = require('../tools/lib/dsl/project');
	const { loadData } = require('../tools/lib/dsl/data');
	const { DATA } = require('../tools/lib/paths');
	const { prereqOrder } = require('../tools/lib/route/prereq-order');
	data = data || loadData(DATA);
	const { guides } = compileSources(Object.entries(files).map(([file, text]) => ({ file, source: file, text })), data);
	return [...new Set(prereqOrder(guides, data).map((v) => `${v.file}:${v.line} ${v.quest}<-${v.missing.join(',')} ${v.race} ${v.path[0]}`))];
}
const head = (id, more = '') => `guide ${id}\ntitle ${id}\nfaction Alliance\nlevels 20-30\nzone Wetlands\n${more}\n`;

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
