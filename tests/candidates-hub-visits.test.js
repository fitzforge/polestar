'use strict';
// #2992 (nes): Nearest sent a Night Elf Hunter in Darnassus' Cenarion Enclave to Jeen'ra Nightrunner at the top of
// its tower, though Jocaste stood beside her on the same floor. The three hunter trainers stand within 60 yards, so
// the class trainers' smart target keeps one of them per city hub, and it kept the lowest id. Of one hub's NPCs it
// now keeps the one most players train with (trainers.json `visits`, `forge data trainers`); without visits, as before.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { Data } = require('../tools/lib/dsl/data');
const { buildCandidates } = require('../tools/lib/dsl/candidates');

const FRAME = { c: 1, left: 2938.363, right: 1880.03, top: 10238.316, bottom: 9532.587 };
const npc = (id, name, x, y) => ({ id, name, faction: 'A', spawns: { 1457: { f: 'l', pts: [[x, y]] } } });
const raw = (trainers) => ({
	'map-frames': { forever: { 1457: FRAME } },
	zones: { 1457: { id: 1457, name: 'Darnassus', type: 3 } },
	npcs: { 4138: npc(4138, "Jeen'ra Nightrunner", 39.62, 5.89), 4146: npc(4146, 'Jocaste', 40.09, 8.73), 4205: npc(4205, 'Dorion', 41.78, 7.68) },
	trainers,
});
const entries = [4138, 4146, 4205].map((id) => ({ npc: id, classes: ['HUNTER'] }));
const kept = (trainers) => buildCandidates(new Data(raw(trainers)), entries, { sides: ['Alliance'], ref: null }).candidates.map((c) => c.npc);

test('#2992: of one city hub\'s trainers, the one most players train with', () => {
	const t = (v) => Object.fromEntries([[4138, 3], [4146, 14], [4205, 5]].map(([id, n]) => [id, { id, classes: ['HUNTER'], ...(v ? { visits: n } : {}) }]));
	assert.deepEqual(kept(t(true)), [4146], 'Jocaste, 14 players');
	assert.deepEqual(kept(t(false)), [4138], 'without visits: the lowest id, as before');
});
