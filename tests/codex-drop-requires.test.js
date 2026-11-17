'use strict';
// #1923: a loot source can require a quest held OR completed. Keep the condition
// on that source through merging and packing; other ways to get the item stay open.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { mergeCodex } = require('../tools/lib/codex/build');
const { emitPack } = require('../tools/lib/codex/pack');
const { writeCodexPack } = require('./helpers/codex');
const { runAddon } = require('./helpers/lua');

function inputs() {
	const npc = (id) => ({ id, name: `NPC ${id}`, level: 20, spawns: { 1429: { f: 'e', pts: [[50, 50]] } }, source: ['pfquest'] });
	return { forever: {
		zones: { 1429: { id: 1429, name: 'Elwynn Forest' } }, factions: {}, mapFrames: { era: {}, forever: {} }, meta: {}, quests: {}, instances: {},
		npcs: { 4802: npc(4802), 4803: npc(4803) }, objects: { 30: { id: 30, name: 'Chest', spawns: {} } },
		items: { 16790: { id: 16790, name: 'Damp Note', source: ['pfquest'], vendors: [4803],
			drops: { npc: { 4802: 33, 4803: 10 }, object: { 30: 50 } },
			dropRequires: { npc: { 4802: [6563] }, object: { 30: [6563, 6564] } },
		} },
	}, web: { npc: { 4802: { drops: [{ item: 16790, count: 50, outof: 100 }], spawns: {} } }, object: {}, item: {} } };
}

test('Codex merge keeps quest requirements on their loot source after duplicate sources merge', () => {
	const sources = mergeCodex(inputs()).items[16790].sources;
	assert.deepEqual(sources.find((s) => s.type === 'drop' && s.npc === 4802).requiresQuests, [6563]);
	assert.deepEqual(sources.find((s) => s.type === 'object').requiresQuests, [6563, 6564]);
	assert.equal(sources.find((s) => s.type === 'drop' && s.npc === 4803).requiresQuests, undefined);
	assert.equal(sources.find((s) => s.type === 'vendor').requiresQuests, undefined);
});

test('Codex pack appends loot requirements after provenance and leaves old source fields unchanged', () => {
	const source = { type: 'drop', npc: 4802, chance: 33, instance: null, from: ['pfquest'] };
	const codex = { items: { 16790: { id: 16790, name: 'Damp Note', sources: [source] } } };
	const itemFile = () => emitPack(codex, { version: 'test' })['Items1.lua'];
	const old = itemFile();
	assert.match(old, /d4802,33,,p/);
	source.requiresQuests = [6563, 6564];
	assert.equal(itemFile(), old.replace('d4802,33,,p', 'd4802,33,,p,6563%2C6564'));
	source.requiresQuests = [];
	assert.equal(itemFile(), old, 'no requirement is byte-for-byte the old format');
});

test('Codex Lua reads old and extended loot sources with provenance and source boundaries intact', () => {
	const codex = { items: { 16790: { id: 16790, name: 'Damp Note', sources: [
		{ type: 'drop', npc: 4802, chance: 33, from: ['pfquest'], requiresQuests: [6563] },
		{ type: 'object', object: 30, chance: 50, from: ['questie'], requiresQuests: [6563, 6564] },
		{ type: 'drop', npc: 4803, chance: 10, from: ['pfquest'] },
	] } } };
	const pack = writeCodexPack(codex);
	try {
		const [sources] = runAddon({ stubs: ['stub_world.lua'], before: pack.stubLua, addons: ['Polestar'], script: `
assert(Polestar.Codex.Load())
emit(Polestar.Codex.Item(16790).sources)
` }).emitted;
		assert.deepEqual(sources[0], { type: 'drop', npc: 4802, chance: 33, from: ['pfquest'], requiresQuests: [6563] });
		assert.deepEqual(sources[1], { type: 'object', object: 30, chance: 50, from: ['questie'], requiresQuests: [6563, 6564] });
		assert.deepEqual(sources[2], { type: 'drop', npc: 4803, chance: 10, from: ['pfquest'] });
	} finally { pack.cleanup(); }
});
