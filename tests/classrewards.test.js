'use strict';
// tools/commands/classrewards.js: which class quest chains the level-up
// heads-up (UI/ClassToast.lua) may offer.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildClassRewards } = require('../tools/commands/classrewards');

const ROBE = 1001, BRACERS = 1002, BLADE = 1003;
const tables = {
	Item: [ROBE, BRACERS].map((id) => ({ ID: id, ClassID: 4, SubclassID: 1, IconFileDataID: 1 })).concat([{ ID: BLADE, ClassID: 2, SubclassID: 7, IconFileDataID: 2 }]),
	ItemSparse: [{ ID: ROBE, Display_lang: 'Robe' }, { ID: BRACERS, Display_lang: 'Bracers' }, { ID: BLADE, Display_lang: 'Blade' }],
};
const table = (name) => tables[name] || [];
const giver = { name: 'Giver', faction: 'AH', spawns: { 1429: { f: 'e', pts: [[50, 50]] } } };
const quest = (id, sort, level, item) => ({
	id, title: `Q${id}`, level, minLevel: level, races: null, classes: 256, start: { npc: [1], object: [], item: [] }, zone: 1429,
	pre: [], next: null, web: { zone: sort, items: [[item, 1]], choices: [] },
});
const races = { Human: { Alliance: { id: 1, bit: 1, classes: ['WARLOCK'] } } };

test('gear-set turn-ins (filed under a zone, 58+, no spell) get no heads-up; a chain a class guide takes keeps it', () => {
	const quests = {
		10: quest(10, -61, 20, ROBE), // a Warlock class quest, filed under the class
		11: quest(11, 3428, 60, BRACERS), // an Ahn'Qiraj set piece
		12: quest(12, 2557, 60, BLADE), // a Dire Maul weapon chain with its class guide
	};
	const guides = [{ file: 'blade.guide', mask: 256, reward: { items: [BLADE] }, quests: [12] }];
	const { starts, quests: out } = buildClassRewards({ quests, tdb: null, table, guides, npcs: { 1: giver }, objects: {}, races });
	assert.deepEqual(starts.map((s) => s.q), [10, 12]);
	assert.ok(out.find((e) => e.q === 11).reward > 0, 'the set piece keeps its reward on the class card');
});

test('a quest for every class but one is no class quest: Durotar\'s Vile Familiars for all but Warlocks', () => {
	const quests = { 792: { ...quest(792, 14, 2, ROBE), classes: 1 | 2 | 4 | 8 | 16 | 64 | 128 | 1024 }, 10: quest(10, -61, 20, ROBE) };
	const { starts, quests: out } = buildClassRewards({ quests, tdb: null, table, guides: [], npcs: { 1: giver }, objects: {}, races });
	assert.deepEqual(out.map((e) => e.q), [10]);
	assert.deepEqual(starts.map((s) => s.q), [10]);
});

test('only the data\'s class limit makes a class quest: a class guide\'s errand every class can take is none', () => {
	// The Dread Mage Hat guide (Warlock) starts with A Noble Brew, an errand for any
	// Alliance player (no class in the data), before the Warlock's own quest.
	const quests = { 335: { ...quest(335, 10, 25, ROBE), classes: null, next: 397 }, 397: { ...quest(397, -61, 25, ROBE), pre: [335] } };
	const guides = [{ file: 'dread-mage-hat.guide', mask: 256, reward: { items: [ROBE] }, quests: [335, 397] }];
	const { starts, quests: out } = buildClassRewards({ quests, tdb: null, table, guides, npcs: { 1: giver }, objects: {}, races });
	assert.deepEqual(out.map((e) => e.q), [397]);
	assert.deepEqual(starts.map((s) => s.q), [397]);
});
