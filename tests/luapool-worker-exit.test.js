'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { once } = require('node:events');
const { LuaPool } = require('../tools/lib/luapool');

for (const outcome of ['success', 'error', 'exit', 'signal']) {
	test(`the Lua pool removes its active job file after ${outcome}`, { timeout: 15000 }, async (t) => {
		const pool = new LuaPool({ size: 1 });
		const scripts = {
			success: 'emit("ok")',
			error: 'error("expected control error")',
			exit: 'os.exit(23)',
			signal: 'io.write("POOL_ACTIVE\\n"); io.flush(); io.read("*l")',
		};
		const result = pool.runAddon({ script: scripts[outcome] });
		const worker = pool.workers[0];
		const file = worker.job.file;
		const closed = once(worker.proc, 'close');
		t.after(async () => {
			pool.close();
			if (worker.proc.exitCode === null && worker.proc.signalCode === null) worker.proc.kill('SIGKILL');
			await closed;
			// A failing regression must not leave its own fixture behind.
			fs.rmSync(file, { force: true });
		});
		assert.equal(fs.existsSync(file), true);
		let active = false;
		if (outcome === 'signal') {
			let stdout = '';
			worker.proc.stdout.on('data', (data) => {
				stdout += data;
				if (!active && stdout.includes('POOL_ACTIVE\n')) {
					active = true;
					worker.proc.kill('SIGTERM');
				}
			});
		}
		if (outcome === 'success') assert.deepEqual((await result).emitted, ['ok']);
		else await assert.rejects(result, outcome === 'error' ? /Lua failed \(in pool\):\n.*expected control error/ : /Lua pool worker exited/);
		if (outcome === 'signal') assert.equal(active, true, 'terminate only after the job starts running');
		assert.equal(fs.existsSync(file), false, 'the job file is removed before its promise settles');
		pool.close();
		await closed;
		assert.equal(fs.existsSync(file), false);
	});
}
