'use strict';
// tools/lib/data/corrections.json: a correction that gives a quest its
// prerequisites must leave the quest blocked by them. QuestieDB's split
// fields win over pfQuest's `pre` once either is present (prereqs.js), so a
// `set` with `pre` and an empty `preAny` but no `preAll` blocks nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');

const corrections = require('../tools/lib/data/corrections.json');
const { blockingPrereqs } = require('../tools/lib/data/prereqs');

test('every prerequisite correction blocks the quest until its prerequisites are turned in', () => {
	const dead = [];
	for (const [id, entry] of Object.entries(corrections.quests || {})) {
		const set = entry && entry.set;
		if (!set || !['pre', 'preAll', 'preAny'].some((k) => Array.isArray(set[k]) && set[k].length > 0)) continue;
		const { all, any } = blockingPrereqs({ id: Number(id), start: { npc: [1] }, ...set });
		if (all.length === 0 && any.length === 0) dead.push(id);
	}
	assert.deepEqual(dead, [], `corrections that set prerequisites but block nothing: ${dead.join(', ')}`);
});
