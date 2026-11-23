'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { once } = require('node:events');
const { LuaPool } = require('../tools/lib/luapool');

async function within(promise, message) {
	let timer;
	try {
		return await Promise.race([promise, new Promise((_, reject) => {
			timer = setTimeout(() => reject(new Error(message)), 5000);
		})]);
	} finally {
		clearTimeout(timer);
	}
}

function fixture(t, size = 1) {
	const pool = new LuaPool({ size });
	const files = new Set();
	const processes = new Map();
	function capture() {
		for (const worker of pool.workers) {
			if (worker.job) files.add(worker.job.file);
			if (!processes.has(worker.proc)) {
				processes.set(worker.proc, worker.proc.exitCode !== null || worker.proc.signalCode !== null ? Promise.resolve() : once(worker.proc, 'close'));
			}
		}
		for (const job of pool.queue) files.add(job.file);
	}
	t.after(async () => {
		capture();
		pool.close();
		for (const proc of processes.keys()) {
			if (proc.exitCode === null && proc.signalCode === null) proc.kill('SIGKILL');
		}
		try {
			await within(Promise.all(processes.values()), 'fixture workers did not close');
		} finally {
			// On the old implementation, both exited and stranded jobs can leave files.
			for (const file of files) fs.rmSync(file, { force: true });
		}
	});
	return {
		pool,
		run(script) {
			const result = pool.runAddon({ script });
			result.catch(() => {}); // Observe early failures while awaiting a worker's start marker.
			capture();
			return result;
		},
	};
}

function active(worker) {
	return within(new Promise((resolve) => {
		let output = '';
		function data(chunk) {
			output += chunk;
			if (output.includes('POOL_ACTIVE\n')) {
				worker.proc.stdout.removeListener('data', data);
				resolve();
			}
		}
		worker.proc.stdout.on('data', data);
	}), 'the worker did not start its job');
}

const WAIT = 'io.write("POOL_ACTIVE\\n"); io.flush(); io.read("*l")';

test('an exiting worker does not strand an already queued play', { timeout: 15000 }, async (t) => {
	const { run } = fixture(t);
	const first = run('os.exit(23)');
	const later = [run('emit("second")'), run('emit("third")')];
	await within(assert.rejects(first, /Lua pool worker exited \(23\)/), 'the first play did not reject');
	const results = await within(Promise.all(later), 'the queued plays never ran after worker exit');
	assert.deepEqual(results.map((result) => result.emitted), [['second'], ['third']]);
	assert.deepEqual((await within(run('emit("reused")'), 'the replacement worker could not be reused')).emitted, ['reused']);
});

test('a terminated active worker releases its queued play', { timeout: 15000 }, async (t) => {
	const { pool, run } = fixture(t);
	const first = run(WAIT);
	const worker = pool.workers[0];
	const started = active(worker);
	const second = run('emit("after signal")');
	await started;
	worker.proc.kill('SIGTERM');
	await within(assert.rejects(first, /Lua pool worker exited/), 'the terminated play did not reject');
	assert.deepEqual((await within(second, 'the queued play never ran after SIGTERM')).emitted, ['after signal']);
});

test('queued plays finish after every active worker is lost', { timeout: 15000 }, async (t) => {
	const { pool, run } = fixture(t, 2);
	const first = run(WAIT);
	const worker1 = pool.workers[0];
	const started1 = active(worker1);
	const second = run(WAIT);
	const worker2 = pool.workers[1];
	const started2 = active(worker2);
	const later = [run('emit("third")'), run('emit("fourth")')];
	await Promise.all([started1, started2]);
	worker1.proc.kill('SIGTERM');
	worker2.proc.kill('SIGTERM');
	await within(Promise.all([assert.rejects(first, /Lua pool worker exited/), assert.rejects(second, /Lua pool worker exited/)]), 'the lost plays did not reject');
	const results = await within(Promise.all(later), 'the queue stalled after losing every worker');
	assert.deepEqual(results.map((result) => result.emitted), [['third'], ['fourth']]);
});

test('an exiting worker retired by close does not restart queued plays', { timeout: 15000 }, async (t) => {
	const { pool, run } = fixture(t);
	const first = run(`${WAIT}; os.exit(23)`);
	const worker = pool.workers[0];
	const started = active(worker);
	const closed = once(worker.proc, 'close');
	let completed = false;
	run('emit("must not run")').then(() => { completed = true; }, () => {});
	await started;
	pool.close(); // EOF releases io.read; its exit notification arrives after retirement.
	await within(assert.rejects(first, /Lua pool worker exited \(23\)/), 'the retired worker did not exit');
	await within(closed, 'the retired process did not close');
	assert.equal(pool.workers.length, 0, 'close must not spawn a replacement');
	assert.equal(completed, false, 'queued work must not run after close');
});

test('an ordinary Lua error still lets an already queued play finish', { timeout: 15000 }, async (t) => {
	const { run } = fixture(t);
	const first = run('error("queue control")');
	const second = run('emit("after error")');
	await within(assert.rejects(first, /Lua failed \(in pool\):\n.*queue control/), 'the Lua error did not reject');
	assert.deepEqual((await within(second, 'the control queue did not drain')).emitted, ['after error']);
});
