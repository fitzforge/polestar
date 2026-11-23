'use strict';
// The walking maps' repack (tools/nav/repack.sh, docs/nav/REPACK.md). The graft of 0.4.2's layers on synthetic
// packs: a file the new pack changed gets the layer appended, a file it left as it was keeps the base's whole
// (also one the layers changed in the middle), a changed file whose base is not the plain one plus a layer stops
// the graft, the manifest's hashes follow and the sidecars come along. compare finds a changed file and a file
// PACK.json does not list. And, where the private inputs are (POLESTAR_REPACK_ENV names their file, so a CI
// runner or a plain test run never starts the pack, a heavy job), a repack of this checkout's inputs gives its
// walking maps byte for byte.
const { test, after } = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { graft, compare, MANIFEST, SIDECARS } = require('../tools/lib/nav/repack');

const ROOT = path.join(__dirname, '..');
const sha = (s) => crypto.createHash('sha256').update(s).digest('hex');
const key = (k) => (k.startsWith('Nav/') ? `Polestar_Nav/${k}` : k);

// A pack folder: its files and a PACK.json (tabs, as forge writes it) listing them.
function pack(dir, files, extra = {}) {
	for (const [k, v] of Object.entries({ ...files, ...extra })) {
		fs.mkdirSync(path.dirname(path.join(dir, key(k))), { recursive: true });
		fs.writeFileSync(path.join(dir, key(k)), v);
	}
	const manifest = { generator: 'forge nav pack', maps: { 0: { part: 'Polestar_Nav_EK' } }, files: Object.fromEntries(Object.entries(files).map(([k, v]) => [k, sha(v)])) };
	fs.writeFileSync(path.join(dir, MANIFEST), `${JSON.stringify(manifest, null, '\t')}\n`);
	return dir;
}

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'nav-repack-'));
after(() => fs.rmSync(tmp, { recursive: true, force: true }));

function fixture() {
	const t = fs.mkdtempSync(path.join(tmp, 'case-'));
	const plain = { 'Nav/Nav0.lua': 'meta 0\n', 'Nav/Chokepoints.lua': 'lifts\nbridges\n', 'Polestar_Nav_EK/Nav0_1.lua': 'part 1\n', 'Polestar_Nav_EK/Nav0_2.lua': 'part 2\n' };
	const base = { ...plain, 'Nav/Nav0.lua': 'meta 0\n-- lanes\n', 'Nav/Chokepoints.lua': 'lifts\nrope bridge\nbridges\n', 'Polestar_Nav_EK/Nav0_1.lua': 'part 1\n-- ground pages\n' };
	const sidecars = Object.fromEntries(SIDECARS.map((s) => [s, `-- ${s}\n`]));
	return { t, plain: pack(path.join(t, 'plain'), plain), base: pack(path.join(t, 'base'), base, sidecars) };
}

test('graft: the layers go after the new pack\'s files, unchanged files keep the base\'s, the hashes follow', () => {
	const { t, plain, base } = fixture();
	const fresh = pack(path.join(t, 'new'), { 'Nav/Nav0.lua': 'meta 0 new\n', 'Nav/Chokepoints.lua': 'lifts\nbridges\n', 'Polestar_Nav_EK/Nav0_1.lua': 'part 1\n', 'Polestar_Nav_EK/Nav0_2.lua': 'part 2 new\n' });
	const out = path.join(t, 'out');
	assert.deepEqual(graft(base, plain, fresh, out), { 'Nav/Chokepoints.lua': 'kept', 'Nav/Nav0.lua': 9, 'Polestar_Nav_EK/Nav0_1.lua': 'kept' });
	const read = (k) => fs.readFileSync(path.join(out, key(k)), 'utf8');
	assert.equal(read('Nav/Nav0.lua'), 'meta 0 new\n-- lanes\n');
	assert.equal(read('Nav/Chokepoints.lua'), 'lifts\nrope bridge\nbridges\n');
	assert.equal(read('Polestar_Nav_EK/Nav0_1.lua'), 'part 1\n-- ground pages\n');
	assert.equal(read('Polestar_Nav_EK/Nav0_2.lua'), 'part 2 new\n', 'a file the base never changed is the new pack\'s');
	const text = fs.readFileSync(path.join(out, MANIFEST), 'utf8');
	assert.ok(text.startsWith('{\n  "generator"'), 'two-space indents, as the base\'s manifest');
	for (const [k, h] of Object.entries(JSON.parse(text).files)) assert.equal(h, sha(fs.readFileSync(path.join(out, key(k)))), k);
	for (const s of SIDECARS) assert.equal(fs.readFileSync(path.join(out, s), 'utf8'), `-- ${s}\n`);
	assert.throws(() => graft(base, plain, fresh, out), /exists/);
});

test('graft: a file the new pack changed whose base is not the plain one plus a layer stops it', () => {
	const { t, plain, base } = fixture();
	const fresh = pack(path.join(t, 'new'), { 'Nav/Nav0.lua': 'meta 0\n', 'Nav/Chokepoints.lua': 'lifts\nbridges\ntunnel\n', 'Polestar_Nav_EK/Nav0_1.lua': 'part 1\n', 'Polestar_Nav_EK/Nav0_2.lua': 'part 2\n' });
	assert.throws(() => graft(base, plain, fresh, path.join(t, 'out')), /Chokepoints\.lua: the new pack changed it/);
});

test('compare: a changed file, a missing one and a file PACK.json does not list', () => {
	const { t, plain } = fixture();
	const copy = path.join(t, 'copy');
	fs.cpSync(plain, copy, { recursive: true });
	assert.deepEqual(compare(plain, copy), { files: 5, differ: [], missing: [], unlisted: [], fields: [] });
	fs.writeFileSync(path.join(copy, 'Polestar_Nav_EK/Nav0_2.lua'), 'part 2 old\n');
	fs.rmSync(path.join(copy, 'Polestar_Nav/Nav/Nav0.lua'));
	fs.writeFileSync(path.join(copy, 'Polestar_Nav_EK/Region0_0_0.lua'), 'stale\n');
	fs.writeFileSync(path.join(copy, 'Polestar_Nav_EK/Polestar_Nav_EK.toc'), '## Title: EK\n');
	assert.deepEqual(compare(plain, copy), { files: 5, differ: ['Polestar_Nav_EK/Nav0_2.lua'], missing: ['Polestar_Nav/Nav/Nav0.lua'], unlisted: ['Polestar_Nav_EK/Region0_0_0.lua'], fields: [] });
});

const envFile = process.env.POLESTAR_REPACK_ENV;
test('a repack of this checkout\'s inputs is its walking maps byte for byte (private inputs; heavy)', {
	skip: !(envFile && fs.existsSync(envFile)) && 'POLESTAR_REPACK_ENV names no inputs file (docs/nav/REPACK.md)',
	timeout: 60 * 60 * 1000,
}, () => {
	const r = spawnSync('bash', [path.join(ROOT, 'tools/nav/repack.sh'), '--check'], { cwd: ROOT, encoding: 'utf8', maxBuffer: 64 << 20 });
	assert.equal(r.status, 0, `${r.stdout.slice(-4000)}\n${r.stderr.slice(-4000)}`);
	assert.match(r.stdout, /files, byte for byte the same\n$/);
});
