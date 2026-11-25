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

test('a quest that asks for a profession\'s skill is no class quest, whatever classes the data limits it to', () => {
	// QuestieDB 1.1.5 limits the Horde's The Art of the Armorsmith (5301, Blacksmithing 200) to Warriors and Paladins.
	const quests = { 5301: { ...quest(5301, -121, 40, BRACERS), classes: 1 | 2, skill: 164, skillLevel: 200 }, 10: quest(10, -61, 20, ROBE) };
	const { starts, quests: out } = buildClassRewards({ quests, tdb: null, table, guides: [], npcs: { 1: giver }, objects: {}, races });
	assert.deepEqual(out.map((e) => e.q), [10]);
	assert.deepEqual(starts.map((s) => s.q), [10]);
});

// #2462 (TAKODACHI): a class guide holds each step to the player's level (Fitz's level rule, 0.4.0), so the heads-up
// waits for the level the guide takes the chain's first quest at, not the quest's own minimum: a card never says
// "ready" at a level the guide then holds you back from. A level 1 start stays at 1 (no heads-up at all).
test('the heads-up comes at the class guide\'s hold on the first quest, when that is above the quest\'s minimum (#2462)', () => {
	const quests = { 10: quest(10, -61, 30, ROBE), 20: quest(20, -61, 1, BLADE) };
	const guides = [
		{ file: 'robe.guide', mask: 256, reward: { items: [ROBE] }, quests: [10], holds: { 10: 43 } },
		{ file: 'blade.guide', mask: 256, reward: { items: [BLADE] }, quests: [20], holds: { 20: 3 } },
	];
	const { starts } = buildClassRewards({ quests, tdb: null, table, guides, npcs: { 1: giver }, objects: {}, races });
	assert.equal(starts.find((s) => s.q === 10).minLevel, 43, 'the card waits for the guide\'s hold');
	assert.equal(starts.find((s) => s.q === 20).minLevel, 1, 'a level 1 start keeps no heads-up');
});

// The shipped card data against today's class guides: every start a class guide takes comes at its hold or later.
test('ClassRewards.lua: no class-quest heads-up comes before its class guide\'s hold (#2462)', () => {
	const fs = require('node:fs');
	const path = require('node:path');
	const { classGuides } = require('../tools/commands/classrewards');
	const lua = fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar', 'UI', 'ClassRewards.lua'), 'utf8');
	const starts = {};
	for (const m of lua.slice(lua.indexOf('starts = {')).matchAll(/\[(\d+)\] = \{ (\d+), g/g)) starts[m[1]] = Number(m[2]);
	const held = {};
	for (const g of classGuides(path.join(__dirname, '..', 'guides'))) {
		for (const [q, hold] of Object.entries(g.holds)) if (!(q in held) || hold < held[q]) held[q] = hold;
	}
	const early = Object.entries(starts).filter(([q, lv]) => lv > 1 && held[q] > lv).map(([q, lv]) => `${q}: card at ${lv}, guide holds ${held[q]}`);
	assert.deepEqual(early, []);
});

test('a buff the turn-in casts with another class\'s spell is no reward: the priests\' Blood of Morphaz casts Mark of the Wild (#2440)', () => {
	const MOTW = 9884, CAT = 768;
	const t = {
		...tables,
		SkillLineAbility: [{ Spell: MOTW, ClassMask: 1024 }, { Spell: CAT, ClassMask: 1024 }],
		SpellName: [{ ID: MOTW, Name_lang: 'Mark of the Wild' }, { ID: CAT, Name_lang: 'Cat Form' }],
	};
	const quests = {
		8257: { ...quest(8257, -202, 52, ROBE), classes: 16 }, // a Priest quest
		20: { ...quest(20, -263, 20, BLADE), classes: 1024 }, // a Druid quest that teaches a druid spell
	};
	const tdb = { quests: { 8257: { rewardSpell: MOTW }, 20: { rewardSpell: CAT } } };
	const { rewards, quests: out } = buildClassRewards({ quests, tdb, table: (n) => t[n] || [], guides: [], npcs: { 1: giver }, objects: {}, races });
	const of = (q) => rewards[out.find((e) => e.q === q).reward - 1];
	assert.equal(of(8257).spell, undefined, 'no Mark of the Wild on the priest card');
	assert.deepEqual(of(8257).items, [ROBE]);
	assert.equal(of(20).spell, CAT, 'a druid still learns Cat Form');
});

// #2472: the quest data no longer carries the web quest database's rewards, so the card takes what players were
// handed at the turn-in in their recordings (data/codex/recorded.json `rewards`), where enough of them agree.
test('a class quest\'s item reward comes from the recorded turn-ins when the quest data has none (#2472)', () => {
	const quests = { 10: { ...quest(10, -61, 20, ROBE), web: undefined }, 11: { ...quest(11, -61, 20, ROBE), web: undefined } };
	const recorded = { 10: { items: [BRACERS], choices: [], voters: 6, trusted: true }, 11: { items: [BLADE], choices: [], voters: 1, trusted: false } };
	const { rewards, quests: out } = buildClassRewards({ quests, tdb: null, table, guides: [], npcs: { 1: giver }, objects: {}, races, recorded });
	const of = (q) => out.find((e) => e.q === q).reward;
	assert.deepEqual(rewards[of(10) - 1].items, [BRACERS]);
	assert.equal(of(11), 0, 'one untrusted recording is no reward');
});

// #2472: The Tempest's Weapons lists both factions' Heed My Call as `pre`; the Alliance's Call of Air chain must not
// take the Horde chain's reward through it.
test('a quest both factions\' chains lead to joins neither chain to the other (#2472)', () => {
	const A = 4294967373, H = 8589934770;
	const q = (id, races, item, extra) => ({ ...quest(id, -82, 30, item), classes: 64, races, web: item ? { zone: -82, items: [[item, 1]], choices: [] } : { zone: -82, items: [], choices: [] }, ...extra });
	const quests = {
		94789: q(94789, A, ROBE, { next: 96264 }), // Alliance Call of Air: its totem
		96264: q(96264, A, null, { pre: [94789] }),
		79366: q(79366, H, null, {}),
		79442: q(79442, H, BLADE, { pre: [79366, 96264] }), // Horde's weapon, listing the Alliance's quest too
	};
	const { rewards, quests: out } = buildClassRewards({ quests, tdb: null, table, guides: [], npcs: { 1: giver }, objects: {}, races });
	const of = (id) => out.find((e) => e.q === id);
	assert.notEqual(of(96264).chain, of(79442).chain, 'two chains');
	const reward = of(96264).reward;
	assert.ok(!reward || !(rewards[reward - 1].items || []).includes(BLADE), "the Alliance quest never shows the Horde chain's weapon");
});

// The 0.4.3 data knows many class trainers only on the client's live frame (Mathrengyl Bearwalker in Darnassus):
// the card's point is an Era one, so the live point is carried onto the Era map, and the card still says where.
test('a giver known only on the live frame gets the same place on the Era map', () => {
	const live = { name: 'Live', faction: 'AH', spawns: { 1429: { f: 'l', pts: [[40, 60]] } } };
	const frames = {
		era: { 1429: { c: 0, left: 0, right: 1000, top: 0, bottom: 1000 } },
		forever: { 1429: { c: 0, left: 100, right: 900, top: 100, bottom: 900 } },
	};
	const quests = { 10: quest(10, -61, 20, ROBE) };
	const at = (f) => buildClassRewards({ quests, tdb: null, table, guides: [], npcs: { 1: live }, objects: {}, races, frames: f }).starts[0].givers[0];
	assert.deepEqual([at(frames).map, at(frames).x, at(frames).y], [1429, 42, 58]);
	assert.equal(at(null).map, undefined, 'without the frames: no point, as before');
});
