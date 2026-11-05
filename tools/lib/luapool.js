'use strict';
// A pool of long-lived lua5.1 processes running addon test programs
// (tests/helpers/lua.js buildProgram) through tests/lua/pool.lua: each
// program in a fresh environment, the files it loads compiled once per
// process. runAddon's result for the same options, without starting Lua and
// parsing the addon and the pack for every program.
//
//   const pool = new LuaPool({ size: 8 });
//   const { emitted } = await pool.runAddon(opts);   // as runAddon(opts)
//   pool.close();
//
// A Lua error rejects with "Lua failed (...)" as runAddon throws. Files the
// programs load must not change while the pool lives (the chunk cache).

const { spawn } = require('node:child_process');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { findLua } = require('./lua');
const { buildProgram, parseEmitted, STUBS, ROOT } = require('../../tests/helpers/lua');

const END = /\n@@END (ok|err)([^\n]*)\n$/;

class Worker {
	constructor() {
		this.proc = spawn(findLua(), [path.join(STUBS, 'pool.lua')], { cwd: ROOT, stdio: ['pipe', 'pipe', 'pipe'] });
		this.buf = '';
		this.err = '';
		this.job = null;
		this.proc.stdout.setEncoding('utf8');
		this.proc.stdout.on('data', (d) => {
			this.buf += d;
			this.drain();
		});
		this.proc.stderr.setEncoding('utf8');
		this.proc.stderr.on('data', (d) => {
			this.err += d;
		});
		this.proc.on('exit', (code) => {
			this.dead = true;
			if (this.job) this.job.reject(new Error(`Lua pool worker exited (${code}):\n${this.err}\n${this.buf}`));
			this.job = null;
		});
	}

	drain() {
		if (!this.job) return;
		const i = this.buf.indexOf('\n@@END ');
		if (i < 0) return;
		const j = this.buf.indexOf('\n', i + 1);
		if (j < 0) return;
		const m = END.exec(this.buf.slice(i, j + 1));
		const stdout = this.buf.slice(0, i);
		this.buf = this.buf.slice(j + 1);
		const { resolve, reject, file } = this.job;
		const stderr = this.err;
		this.err = '';
		this.job = null;
		fs.rmSync(file, { force: true });
		if (m[1] === 'ok') resolve({ emitted: parseEmitted(stdout), stdout, stderr });
		else {
			const e = new Error(`Lua failed (in pool):\n${m[2].slice(1).replace(/\\n/g, '\n').replace(/\\\\/g, '\\')}\n${stderr}\n${stdout}`);
			e.stdout = stdout;
			e.stderr = stderr;
			reject(e);
		}
		this.onFree();
	}

	run(job) {
		this.job = job;
		this.proc.stdin.write(`${job.file}\n`);
	}
}

class LuaPool {
	constructor({ size = Math.max(1, Math.min(8, os.cpus().length - 1)) } = {}) {
		this.size = size;
		this.workers = [];
		this.queue = [];
		this.seq = 0;
	}

	runAddon(opts = {}) {
		const file = path.join(os.tmpdir(), `polestar-pool-${process.pid}-${++this.seq}-${Math.random().toString(36).slice(2)}.lua`);
		fs.writeFileSync(file, buildProgram(opts));
		return new Promise((resolve, reject) => {
			this.queue.push({ file, resolve, reject });
			this.pump();
		});
	}

	pump() {
		while (this.queue.length) {
			let w = this.workers.find((x) => !x.job && !x.dead);
			if (!w) {
				this.workers = this.workers.filter((x) => !x.dead);
				if (this.workers.length >= this.size) return;
				w = new Worker();
				w.onFree = () => this.pump();
				this.workers.push(w);
			}
			w.run(this.queue.shift());
		}
	}

	close() {
		for (const w of this.workers) if (!w.dead) w.proc.stdin.end();
		this.workers = [];
	}
}

module.exports = { LuaPool };
