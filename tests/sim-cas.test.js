'use strict';
// The shared artifact store (tools/lib/sim/cas.js): a world built in one worktree's data/sim is
// taken by another's with the same inputs; a scratch sim dir keeps its own; gc.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');
const { tmpdir } = require('./helpers/tmp');

test('a world built in one worktree is taken from the shared store by another; gc empties it', async () => {
	const root = tmpdir('polestar-cas-');
	const saved = process.env.POLESTAR_CAS;
	process.env.POLESTAR_CAS = path.join(root, 'cas');
	try {
		const cas = require('../tools/lib/sim/cas');
		const sim = require('../tools/lib/sim');
		const a = syn.writeDataDir(path.join(root, 'a', 'data'));
		const b = syn.writeDataDir(path.join(root, 'b', 'data'));
		assert.ok(cas.enabled(a.simDir) && cas.enabled(b.simDir), 'a worktree\'s data/sim');
		assert.ok(!cas.enabled(path.join(root, 'scratch')), 'a scratch sim dir keeps its own');
		const logs = [];
		const load = (d) => sim.loadWorld({ ...d, faction: 'Horde', offline: true, extraStarts: syn.START, walks: false, log: (m) => logs.push(m) });
		const wa = (await load(a)).world;
		assert.ok(logs.some((l) => /building world model/.test(l)));
		assert.equal(cas.status().kinds.world.files, 1);
		logs.length = 0;
		const wb = (await load(b)).world;
		assert.ok(logs.some((l) => /from the shared store/.test(l)), logs.join('\n'));
		assert.ok(!logs.some((l) => /building world model/.test(l)), 'not built again');
		assert.equal(wb.dataHash, wa.dataHash);
		assert.deepEqual(fs.readFileSync(path.join(b.simDir, 'world-horde.json')), fs.readFileSync(path.join(a.simDir, 'world-horde.json')));
		const r = cas.gc({ maxGb: 0 });
		assert.equal(r.kept, 0);
		assert.ok(r.removed >= 1);
	} finally {
		if (saved === undefined) delete process.env.POLESTAR_CAS;
		else process.env.POLESTAR_CAS = saved;
	}
});

test('POLESTAR_CAS_SKIP keeps a kind out of the store: neither stored nor fetched', () => {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-cas-skip-'));
	const saved = [process.env.POLESTAR_CAS, process.env.POLESTAR_CAS_SKIP];
	process.env.POLESTAR_CAS = path.join(root, 'cas');
	try {
		const cas = require('../tools/lib/sim/cas');
		const src = path.join(root, 'w.bin');
		fs.writeFileSync(src, 'walks');
		process.env.POLESTAR_CAS_SKIP = 'walks';
		assert.equal(cas.store('walks', 'k', src), false);
		assert.equal(fs.existsSync(cas.file('walks', 'k')), false);
		assert.equal(cas.store('world', 'k', src), true, 'other kinds still shared');
		delete process.env.POLESTAR_CAS_SKIP;
		assert.equal(cas.store('walks', 'k', src), true);
		process.env.POLESTAR_CAS_SKIP = 'walks';
		assert.equal(cas.fetch('walks', 'k', path.join(root, 'out.bin')), false, 'a skipped kind is not fetched either');
	} finally {
		for (const [k, v] of [['POLESTAR_CAS', saved[0]], ['POLESTAR_CAS_SKIP', saved[1]]]) if (v === undefined) delete process.env[k];
		else process.env[k] = v;
		fs.rmSync(root, { recursive: true, force: true });
	}
});
