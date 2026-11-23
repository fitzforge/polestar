'use strict';
// #1913: the Codex quest record carries the profession a quest needs (Badlands
// Reagent Run II 2501: Alchemy 210), written as l<line>,<rank> after x<xp>; the
// rank is empty when the data names none. The JS packer (tests' Codex builds)
// writes it the way the Rust one does.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { emitPack } = require('../tools/lib/codex/pack');

const quest = (extra) => ({
	id: 2501, title: 'Badlands Reagent Run II', level: 41, minLevel: 36, faction: null, races: null, classes: null, zone: 3,
	start: { npc: [2786], object: [], item: [] }, end: { npc: [2786], object: [] },
	pre: [17], preAny: [], rewards: [], choices: [], objectives: [], xp: 4950, ...extra,
});
const packed = (q) => Object.values(emitPack({ meta: { schema: 1 }, items: {}, npcs: {}, objects: {}, quests: { 2501: q }, instances: {}, zones: {}, factions: {}, spells: {}, frames: {} }, { version: '0', build: 'test' })).join('\n');

test('pack: a quest record ends with the profession it needs, l<line>,<rank> (#1913)', () => {
	assert.ok(packed(quest({ skill: 171, skillLevel: 210 })).includes(';x4950;l171,210'), 'Alchemy 210');
	assert.ok(packed(quest({ skill: 171, skillLevel: null })).includes(';x4950;l171,'), 'no rank in the data');
	assert.ok(!/;l\d/.test(packed(quest({}))), 'no profession: no field');
});
