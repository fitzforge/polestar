'use strict';
// data build, Wowhead Forever: the cached zone quest lists and how their
// change notes and XP reach quests.json.

const { test, describe } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { parseChangeNotes, loadZoneQuests, applyChangeNotes, fillWowheadXp, applyWowheadFacts } = require('../tools/lib/data/wowhead');
const { tmpdir } = require('./helpers/tmp');

function quest(id, extra = {}) {
	return { id, title: `Quest ${id}`, level: 20, minLevel: 15, xp: null, source: ['pfquest', 'questie-forever'], ...extra };
}

describe('Wowhead zone quest lists', () => {
	test('reads XP, level and required level notes; other notes are ignored', () => {
		assert.deepEqual(parseChangeNotes(['Experience 3,300 instead of 820', 'Requires level 26 instead of 28', 'Level 30 instead of 25', 'Description reworded', 'Experience 630 instead of none']), [
			{ field: 'xp', value: 3300, was: 820 },
			{ field: 'minLevel', value: 26, was: 28 },
			{ field: 'level', value: 30, was: 25 },
			{ field: 'xp', value: 630, was: null },
		]);
	});

	test('the cache gives each row its zone (an older row from its list), and no cache builds without them', () => {
		const sourcesDir = tmpdir('polestar-wowhead-');
		assert.equal(loadZoneQuests({ sourcesDir }).rows.size, 0);
		assert.match(loadZoneQuests({ sourcesDir }).warnings.join('\n'), /no cached Wowhead zone lists/);
		fs.mkdirSync(path.join(sourcesDir, 'wowhead'), { recursive: true });
		const at = '2026-10-14T00:00:00.000Z';
		fs.writeFileSync(path.join(sourcesDir, 'wowhead', 'zones.json'), JSON.stringify({ fetchedAt: at, zones: { 11: [{ id: 5, xp: 100 }], 1581: [{ id: 166, zone: 1581, type: 81 }] } }));
		const r = loadZoneQuests({ sourcesDir });
		assert.deepEqual([r.rows.get(5).zone, r.rows.get(166).zone, r.fetchedAt, r.warnings], [11, 1581, at, []]);
	});
});

describe('Wowhead change notes and XP', () => {
	const rows = new Map([
		[606, { id: 606, status: 'updated', xp: 3300, lines: ['Experience 3300 instead of 820'] }],
		[472, { id: 472, status: 'updated', xp: 1200, lines: ['Level 30 instead of 25', 'Requires level 26 instead of 28'] }],
		[700, { id: 700, status: 'updated', xp: 500, lines: ['Experience 500 instead of 400'] }],
		[7738, { id: 7738, status: 'unchanged', xp: 440, lines: [] }],
		[99, { id: 99, status: 'new', xp: 630, lines: [] }],
		[5645, { id: 5645, name: 'Chastise', status: 'updated', lines: ['Renamed from A Lack of Fear', 'Rewards: adds Chastise'] }],
		[5641, { id: 5641, name: 'Chastise', status: 'updated', lines: ['Renamed from A Lack of Fear'] }],
	]);

	test('a note replaces the value only while we still hold the old one', () => {
		const quests = {
			606: quest(606, { xp: 820 }),
			472: quest(472, { level: 25, minLevel: 20 }),
			700: quest(700, { xp: 450 }),
			5645: quest(5645, { title: 'A Lack of Fear' }),
			5641: quest(5641, { title: 'Our Own Name' }),
		};
		assert.deepEqual(applyChangeNotes(quests, rows), { xp: 1, level: 1, minLevel: 0, title: 1 });
		assert.equal(quests[606].xp, 3300);
		assert.deepEqual(quests[606].source, ['pfquest', 'questie-forever', 'wowhead:xp']);
		assert.equal(quests[472].level, 30);
		assert.equal(quests[472].minLevel, 20, 'our 20 is not the noted old 28: left alone');
		assert.equal(quests[700].xp, 450, 'a value that is neither old nor new is left alone');
		assert.equal(quests[5645].title, 'Chastise', 'renamed in Forever, and we still had the old name');
		assert.deepEqual(quests[5645].source, ['pfquest', 'questie-forever', 'wowhead:title']);
		assert.equal(quests[5641].title, 'Our Own Name', 'a title that is not the noted old name is left alone');
	});

	test('XP fills quests without any, never overrides one', () => {
		const quests = { 99: quest(99, { source: ['questie-forever'] }), 7738: quest(7738, { xp: 2200 }) };
		assert.equal(fillWowheadXp(quests, rows), 1);
		assert.equal(quests[99].xp, 630);
		assert.deepEqual(quests[99].source, ['questie-forever', 'wowhead:xp']);
		assert.equal(quests[7738].xp, 2200, 'an unchanged quest whose Wowhead XP differs keeps ours');
	});

	test('Wowhead facts: instance, type, side, rewards; an item in both lists is a choice unless a note says it no longer is', () => {
		const quests = { 166: quest(166), 962: quest(962), 1486: quest(1486), 1367: quest(1367), 7: quest(7) };
		const facts = new Map([
			[166, { id: 166, zone: 1581, type: 81, side: 1, choices: [[6087, 1]], items: [], money: 0, rep: [[72, 200]], lines: [] }],
			[962, { id: 962, zone: 718, type: 81, side: 3, choices: [[10919, 1], [270008, 1]], items: [[10919, 1]], money: 2000, rep: [], lines: ['Rewards: adds Choice of Heat Resistant Mitts'] }],
			[1486, { id: 1486, zone: 718, type: 81, side: 3, choices: [[918, 1], [6480, 1]], items: [[918, 1], [6480, 1]], money: 1800, rep: [], lines: ['Rewards: adds Deviate Hide Pack, Slick Deviate Leggings', 'Rewards: no longer Choice of Deviate Hide Pack, Choice of Slick Deviate Leggings'] }],
			[1367, { id: 1367, zone: 405, type: 0, side: 3, choices: [], items: [], money: 0, rep: [[93, 250], [92, 1]], lines: [] }],
			[8, { id: 8, zone: 12, type: 0, side: 1, choices: [], items: [], money: 0, rep: [], lines: [] }],
		]);
		assert.equal(applyWowheadFacts(quests, facts), 4, 'quest 8 is not ours');
		assert.deepEqual(quests[166].wowhead, { zone: 1581, type: 81, side: 1, choices: [[6087, 1]], items: [], money: 0, rep: [[72, 200]] });
		assert.deepEqual([quests[962].wowhead.choices, quests[962].wowhead.items], [[[10919, 1], [270008, 1]], []], 'the gloves became one of the choices');
		assert.deepEqual([quests[1486].wowhead.choices, quests[1486].wowhead.items], [[], [[918, 1], [6480, 1]]], 'both given now');
		assert.deepEqual(quests[1367].wowhead.rep, [[93, 250]], 'a reputation of 1 is no amount');
		assert.equal(quests[7].wowhead, undefined);
	});
});
