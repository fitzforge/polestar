'use strict';
// LuaPool (tools/lib/luapool.js, tests/lua/pool.lua): a play on a reused Lua
// process gives what a fresh process gives. Two guides played on one worker,
// alternating (A, B, A), each against its own runAddon run: nothing of one
// play is left for the next. A Lua error rejects and the worker goes on.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { buildSimPack, playGuide, playGuideIn } = require('../tools/lib/playtest');
const { LuaPool } = require('../tools/lib/luapool');
const { findLua } = require('../tools/lib/lua');
const { needs } = require('./helpers/data');

const skip = needs('quests.json');
const luaSkip = (() => {
	try {
		findLua();
		return false;
	} catch {
		return 'no Lua 5.1';
	}
})();

test('a worker remains usable after a Lua error while the pool is open', { skip: luaSkip }, async () => {
	const pool = new LuaPool({ size: 1 });
	try {
		assert.deepEqual((await pool.runAddon({ script: 'emit(1)' })).emitted, [1]);
		const worker = pool.workers[0];
		await assert.rejects(pool.runAddon({ script: 'error("boom")' }), /Lua failed \(in pool\):\n.*boom/);
		assert.deepEqual((await pool.runAddon({ script: 'emit(2)' })).emitted, [2]);
		assert.equal(pool.workers[0], worker, 'an ordinary Lua error does not retire the worker');
	} finally {
		pool.close();
	}
});

test('closing after a failed play rejects queued jobs and never starts another worker', { skip: luaSkip, timeout: 10000 }, async (t) => {
	const pool = new LuaPool({ size: 1 });
	const jobs = [
		pool.runAddon({ script: 'error("failed play")' }),
		pool.runAddon({ script: 'emit("already dispatched")' }),
		pool.runAddon({ script: 'emit("must not run")' }),
	];
	const settled = Promise.allSettled(jobs);
	const originalWorkers = [...pool.workers];
	const files = [...pool.workers.map((w) => w.job.file), ...pool.queue.map((job) => job.file)];
	// Also clean up on the broken implementation: its callback can spawn a
	// replacement after close(), leaving an idle child that keeps Node alive.
	t.after(() => {
		for (const w of new Set([...originalWorkers, ...pool.workers])) {
			w.onFree = () => {};
			w.proc.kill();
		}
		pool.queue.length = 0;
		pool.close();
		for (const file of files) fs.rmSync(file, { force: true });
	});
	try {
		await assert.rejects(Promise.all(jobs), /failed play/);
	} finally {
		pool.close();
	}
	const results = await settled;
	assert.equal(pool.workers.length, 0, 'draining an active job after close must not spawn a worker');
	assert.equal(results[1].status, 'fulfilled', 'an already dispatched play may finish');
	assert.deepEqual(results[1].value.emitted, ['already dispatched']);
	assert.equal(results[2].status, 'rejected', 'the queued play must not run after close');
	assert.match(results[2].reason.message, /closed/i);
	assert.equal(pool.queue.length, 0);
	for (const file of files) assert.equal(fs.existsSync(file), false, 'finished and cancelled jobs remove their temporary files');
});

test('closing a pool is idempotent and new work is rejected', { skip: luaSkip }, async () => {
	const pool = new LuaPool({ size: 1 });
	try {
		pool.close();
		pool.close();
		await assert.rejects(pool.runAddon({ script: 'emit("must not run")' }), /closed/i);
		assert.equal(pool.workers.length, 0);
		assert.equal(pool.queue.length, 0);
	} finally {
		pool.close();
	}
});

test('a pool rejects worker counts that cannot schedule a bounded number of jobs', () => {
	for (const size of [-1, 0, 0.5, Infinity, NaN, Number.MAX_SAFE_INTEGER + 1, null, '2']) {
		assert.throws(() => new LuaPool({ size }), /worker count must be a positive integer/, String(size));
	}
	assert.ok(new LuaPool().size >= 1, 'the default starts at least one worker');
	assert.equal(new LuaPool({ size: 2 }).size, 2);
});

test('a play on a reused process emits what a fresh process does, whatever ran before', { skip }, async () => {
	const pack = buildSimPack(['forever/horde/orc/01-durotar.guide', 'forever/alliance/human/01-elwynn-forest.guide']);
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
