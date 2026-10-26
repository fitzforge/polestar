'use strict';
// LuaPool (tools/lib/luapool.js, tests/lua/pool.lua): a play on a reused Lua
// process gives what a fresh process gives. Two guides played on one worker,
// alternating (A, B, A), each against its own runAddon run: nothing of one
// play is left for the next. A Lua error rejects and the worker goes on.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildSimPack, playGuide, playGuideIn } = require('../tools/lib/playtest');
const { LuaPool } = require('../tools/lib/luapool');
const { needs } = require('./helpers/data');

const skip = needs('quests.json');

test('a play on a reused process emits what a fresh process does, whatever ran before', { skip }, async () => {
	const pack = buildSimPack(['forever/horde/orc-troll/01-durotar.guide', 'forever/alliance/human/01-elwynn-forest.guide']);
	const pool = new LuaPool({ size: 1 });
	try {
		assert.ok(pack.guides.length >= 1);
		const plays = pack.guides.map((g) => ({ g, who: g.faction === 'Alliance' ? { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' } : { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' } }));
		const order = plays.length > 1 ? [plays[0], plays[1], plays[0]] : [plays[0], plays[0]];
		for (const { g, who } of order) {
			const fresh = playGuide(pack, g, who);
			const reused = await playGuideIn(pool, pack, g, who);
			assert.deepEqual(reused, fresh, `${g.id} as ${who.race}`);
		}
		await assert.rejects(pool.runAddon({ script: 'error("boom")' }), /Lua failed \(in pool\):\n.*boom/);
		const after = await pool.runAddon({ script: 'emit(1 + 1)' });
		assert.deepEqual(after.emitted, [2], 'the worker goes on after an error');
		assert.equal(pool.workers.length, 1, 'one process served every play');
	} finally {
		pool.close();
		pack.dispose();
	}
});
