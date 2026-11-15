'use strict';
// A kill the mechanics do by using an item on that NPC keeps useItem on the
// Codex objective (tools/lib/codex/build.js). Lookup reads it and says Use.
// The same kill without an item, a tame, and an item for a different NPC stay
// as they were. Not one quest id (#2468).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { mergeCodex } = require('../tools/lib/codex/build');

function inputs(mechanics) {
	const quest = (id, extra = {}) => ({ id, title: 'Q' + id, start: { npc: [] }, end: { npc: [] }, objectives: [{ type: 'kill', id: extra.npc || 1, count: 1, text: 'Mob' }], ...extra });
	return {
		forever: {
			zones: {},
			factions: {},
			mapFrames: { era: {}, forever: {} },
			meta: {},
			npcs: {},
			objects: {},
			items: {},
			instances: {},
			dungeons: null,
			quests: {
				88001: quest(88001, { npc: 6498 }),
				88002: quest(88002, { npc: 1 }),
				88003: quest(88003, { npc: 1, objectiveText: 'Use the Taming Rod to tame a bear' }),
				88004: quest(88004, { npc: 2 }),
			},
		},
		atlasloot: null,
		rarescanner: null,
		client: null,
		curated: [],
		entrances: [],
		mechanics,
	};
}

const mechanics = {
	quests: {
		88001: { kinds: [{ kind: 'use-item-on-mob', confidence: 'high' }], params: [{ kind: 'use-item-on-mob', item: 22432, npcs: [6498] }] },
		88002: { kinds: [{ kind: 'use-item-on-mob', confidence: 'high' }], params: [{ kind: 'use-item-on-mob', item: 9, npcs: [99] }] },
		88003: { kinds: [{ kind: 'use-item-on-mob', confidence: 'high' }], params: [{ kind: 'use-item-on-mob', item: 9, npcs: [1] }] },
		88004: { kinds: [{ kind: 'use-item-on-mob', confidence: 'high' }], params: [] },
	},
};

test('a kill done with an item keeps useItem; a plain kill, a tame and a kind with no item do not (#2468)', () => {
	const withItem = mergeCodex(inputs(mechanics)).quests;
	assert.equal(withItem[88001].objectives[0].useItem, 22432);
	assert.equal(withItem[88001].objectives[0].tame, undefined);
	assert.equal(withItem[88002].objectives[0].useItem, undefined);
	assert.equal(withItem[88003].objectives[0].tame, true);
	assert.equal(withItem[88003].objectives[0].useItem, undefined);
	assert.equal(withItem[88004].objectives[0].useItem, undefined);
	const plain = mergeCodex(inputs(null)).quests[88001].objectives[0];
	assert.equal(plain.useItem, undefined);
	assert.equal(plain.type, 'kill');
});
