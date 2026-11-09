'use strict';
// tools/lib/data/prereqs.js: the parent of a child quest is no quest to turn
// in first but one to hold in the log (the Valik rule, 0.3.7).
const test = require('node:test');
const assert = require('node:assert/strict');
const { blockingPrereqs } = require('../tools/lib/data/prereqs');

const giver = { npc: [1], object: [], item: [] };
const quests = {
	533: { id: 533, title: 'Infiltration', start: giver },
	535: { id: 535, title: 'Valik', start: giver, pre: [], parent: 533 },
	813: { id: 813, title: 'Finding the Antidote', start: giver, pre: [812], parent: 812 },
	812: { id: 812, title: 'Need for a Cure', start: giver },
	900: { id: 900, start: giver, parent: 901 },
	901: { id: 901, start: { npc: [], object: [], item: [] } },
	910: { id: 910, start: giver, parent: 911, excl: [911] },
	911: { id: 911, start: giver },
};
const questOf = (id) => quests[id] || null;

test('a child quest needs its parent in the log, not handed in', () => {
	assert.deepEqual(blockingPrereqs(quests[535], questOf), { all: [], any: [], inLog: 533 });
	// pfQuest lists the parent as `pre` too: it is still no quest to turn in first.
	assert.deepEqual(blockingPrereqs(quests[813], questOf), { all: [], any: [], inLog: 812 });
});

test('no inLog without a parent, for a parent nobody can start, or one exclusive with the quest', () => {
	assert.deepEqual(blockingPrereqs(quests[533], questOf), { all: [], any: [] });
	assert.deepEqual(blockingPrereqs(quests[900], questOf), { all: [], any: [] });
	assert.deepEqual(blockingPrereqs(quests[910], questOf), { all: [], any: [] });
	// A parent missing from the data still counts (the data is what lacks it).
	assert.deepEqual(blockingPrereqs({ id: 920, start: giver, parent: 921 }, questOf), { all: [], any: [], inLog: 921 });
});
