'use strict';
// pack (the release zips) and tools/lib/zip.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { GUIDES_DIR, DATA_DIR } = require('./helpers/dsl');
const { quiet, fakeAddons, polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const pack = require('../tools/commands/pack');
const { buildZip, writeZip, readZip, directoryEntries, crc32 } = require('../tools/lib/zip');
const { packageVersion } = require('../tools/lib/dsl/project');
const { ROOT } = require('../tools/lib/paths');

const VERSION = packageVersion();

function python(...args) {
	return spawnSync('python3', ['-m', 'zipfile', ...args], { encoding: 'utf8' });
}

const hasPython = spawnSync('python3', ['--version']).status === 0;

// The release always holds Polestar_Nav (committed) and a release-safe Codex (`codex build`).
const RELEASE = ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Recorder', 'Polestar_Codex'];

test('pack zips Polestar + Polestar_Guides + Polestar_Nav + Polestar_Codex and the recorder separately, reproducibly', { skip: !hasPython && 'python3 not installed' }, async () => {
	const addons = fakeAddons(tmpdir(), RELEASE);
	const zips = [];
	for (const n of [1, 2]) {
		const dist = tmpdir();
		const { result, out } = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]));
		assert.equal(result, 0, out);
		assert.deepEqual(fs.readdirSync(dist).sort(), [`Polestar-${VERSION}.zip`, `Polestar_Recorder-${VERSION}.zip`, 'SHA256SUMS']);
		zips.push(dist);
	}
	for (const f of [`Polestar-${VERSION}.zip`, `Polestar_Recorder-${VERSION}.zip`, 'SHA256SUMS']) {
		assert.ok(fs.readFileSync(path.join(zips[0], f)).equals(fs.readFileSync(path.join(zips[1], f))), `${f} differs between runs`);
	}
	const list = python('-l', path.join(zips[0], `Polestar-${VERSION}.zip`));
	assert.equal(list.status, 0, list.stderr);
	const names = list.stdout
		.split('\n')
		.slice(1)
		.map((l) => l.split(/\s+\d{4}-\d\d-\d\d /)[0].trim())
		.filter(Boolean);
	assert.deepEqual(names, [
		'Polestar/',
		'Polestar/LICENSE',
		'Polestar/README.txt',
		'Polestar/Main.lua',
		'Polestar/Polestar.toc',
		'Polestar_Guides/',
		'Polestar_Guides/Guides.lua',
		'Polestar_Guides/LICENSE-DATA.txt',
		'Polestar_Guides/MapFrames.lua',
		'Polestar_Guides/Pack.lua',
		'Polestar_Guides/Polestar_Guides.toc',
		'Polestar_Nav/',
		'Polestar_Nav/Main.lua',
		'Polestar_Nav/Polestar_Nav.toc',
		'Polestar_Codex/',
		'Polestar_Codex/LICENSE-DATA.txt',
		'Polestar_Codex/Main.lua',
		'Polestar_Codex/Meta.lua',
		'Polestar_Codex/Polestar_Codex.toc',
	]);
	assert.equal(python('-t', path.join(zips[0], `Polestar-${VERSION}.zip`)).status, 0);
	const rec = python('-l', path.join(zips[0], `Polestar_Recorder-${VERSION}.zip`));
	assert.match(rec.stdout, /Polestar_Recorder\/Polestar_Recorder\.toc/);
	assert.match(rec.stdout, /Polestar_Recorder\/LICENSE /);
	assert.doesNotMatch(rec.stdout + list.stdout, /\.hidden/);
});

test('the Polestar folder in the zip carries the GPL and install steps naming every folder shipped', async () => {
	const addons = fakeAddons(tmpdir(), [...RELEASE, 'Polestar_QuestDB', 'Polestar_ItemDB']);
	const dist = tmpdir();
	const { result, out } = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]));
	assert.equal(result, 0, out);
	const files = Object.fromEntries(readZip(path.join(dist, `Polestar-${VERSION}.zip`)).map((e) => [e.name, e.data]));
	assert.ok(files['Polestar/LICENSE'].equals(fs.readFileSync(path.join(ROOT, 'LICENSE'))));
	const readme = files['Polestar/README.txt'].toString('utf8');
	assert.match(readme, new RegExp(`^Polestar ${VERSION.replace(/\./g, '\\.')}\r\n`));
	assert.match(readme, /_forever_\/Interface\/AddOns\//);
	assert.match(readme, /\/reload does not/);
	for (const n of ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_QuestDB', 'Polestar_ItemDB', 'Polestar_Codex']) assert.match(readme, new RegExp(`^ +${n}\r$`, 'm'));
	assert.match(readme, /part of Polestar: Polestar_Codex holds what Lookup,/);
	assert.match(readme, /Polestar_Nav the arrow's walking routes\r\n +\(Shortest Path Forever's pathing, by Cillian Berragan/);
	// security L12 / review P3-15: the adapted GPL-3.0-or-later code inside Polestar/ is named where it ships.
	assert.match(readme, /^Portions Copyright \(C\) 2026 Cillian Berragan \(Shortest Path Forever\),\r$/m);
	assert.match(files['Polestar/LICENSE'].toString('utf8'), /^Portions Copyright \(C\) 2026 Cillian Berragan \(Shortest Path Forever,$/m);
	assert.doesNotMatch(readme, /^ +Polestar_Recorder\r$/m);
	assert.doesNotMatch(readme.replace(/\r\n/g, ''), /\n/, 'CRLF line endings throughout');
});

test('pack writes SHA256SUMS for the zips it wrote, in the format sha256sum -c reads', async () => {
	const dist = tmpdir();
	const { result, out } = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', fakeAddons(tmpdir(), RELEASE), '--dist', dist]));
	assert.equal(result, 0, out);
	const sum = (f) => crypto.createHash('sha256').update(fs.readFileSync(path.join(dist, f))).digest('hex');
	assert.equal(
		fs.readFileSync(path.join(dist, 'SHA256SUMS'), 'utf8'),
		[`Polestar-${VERSION}.zip`, `Polestar_Recorder-${VERSION}.zip`].map((f) => `${sum(f)}  ${f}\n`).join(''),
	);
});

test('the release zip includes the built data addons and leaves out ones not built', async () => {
	const addons = fakeAddons(tmpdir(), [...RELEASE, 'Polestar_QuestDB']);
	const dist = tmpdir();
	const { result, out } = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]));
	assert.equal(result, 0, out);
	assert.match(out, /note: Polestar_ItemDB not built/);
	const tops = [...new Set(readZip(path.join(dist, `Polestar-${VERSION}.zip`)).map((e) => e.name.split('/')[0]))];
	assert.deepEqual(tops, ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_QuestDB', 'Polestar_Codex']);
	fakeAddons(addons, ['Polestar_ItemDB']);
	assert.equal((await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]))).result, 0);
	const all = [...new Set(readZip(path.join(dist, `Polestar-${VERSION}.zip`)).map((e) => e.name.split('/')[0]))];
	assert.deepEqual(all, ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_QuestDB', 'Polestar_ItemDB', 'Polestar_Codex']);
});

test('pack refuses a release without the Codex, or with a --local-extras one, and writes no zip', async () => {
	const run = async (addons) => {
		const dist = tmpdir();
		const r = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]));
		return { ...r, files: fs.readdirSync(dist) };
	};
	const none = await run(fakeAddons(tmpdir()));
	assert.equal(none.result, 1);
	assert.match(none.out, /pack failed: Polestar_Codex not built \(run `node tools\/polestar\.js codex build`\)/);
	assert.deepEqual(none.files, []);

	const local = fakeAddons(tmpdir(), RELEASE);
	const meta = path.join(local, 'Polestar_Codex', 'Meta.lua');
	fs.writeFileSync(meta, fs.readFileSync(meta, 'utf8').replace('localExtras = false', 'localExtras = true'));
	const refused = await run(local);
	assert.equal(refused.result, 1);
	assert.match(refused.out, /pack failed: Polestar_Codex it is a --local-extras build/);
	assert.deepEqual(refused.files, []);

	// An older local build that predates the flag still names its inputs.
	fs.writeFileSync(meta, 'C.Register("meta", {\n\tsources = {\n\t\t{\n\t\t\tlicence = "GPL-2.0",\n\t\t\tname = "AtlasLootClassic",\n\t\t},\n\t},\n})\n');
	const named = await run(local);
	assert.equal(named.result, 1);
	assert.match(named.out, /its sources include a local-only input \(AtlasLootClassic\)/);

	fs.rmSync(path.join(local, 'Polestar_Codex', 'LICENSE-DATA.txt'));
	fs.writeFileSync(meta, 'C.Register("meta", {})\n');
	assert.match((await run(local)).out, /LICENSE-DATA\.txt is missing/);
});

test('zip: UTF-8 names, empty and binary files, stored and deflated entries round-trip and pass python checks', { skip: !hasPython && 'python3 not installed' }, () => {
	const bin = Buffer.alloc(4096);
	for (let i = 0; i < bin.length; i++) bin[i] = (i * 2654435761) >>> 24;
	const entries = [
		{ name: 'Dir/' },
		{ name: 'Dir/empty.txt', data: '' },
		{ name: 'Dir/Ünïcödé ✓.lua', data: 'print("hi")\n'.repeat(50) },
		{ name: 'Dir/random.bin', data: bin },
		{ name: 'Dir/one.txt', data: 'x' },
	];
	const file = path.join(tmpdir(), 'test.zip');
	writeZip(file, entries);
	assert.ok(buildZip(entries).equals(fs.readFileSync(file)), 'deterministic');
	const back = readZip(file);
	assert.deepEqual(
		back.map((e) => [e.name, e.dir, e.data.toString('base64')]),
		entries.map((e) => [e.name, e.name.endsWith('/'), Buffer.from(e.data || '').toString('base64')]),
	);
	const list = python('-l', file);
	assert.equal(list.status, 0, list.stderr);
	assert.match(list.stdout, /Dir\/Ünïcödé ✓\.lua/);
	assert.equal(python('-t', file).status, 0);
	// Python can extract what we wrote, byte for byte.
	const out = tmpdir();
	assert.equal(python('-e', file, out).status, 0);
	assert.ok(fs.readFileSync(path.join(out, 'Dir', 'random.bin')).equals(bin));
	assert.equal(crc32(Buffer.from('123456789')), 0xcbf43926);
});

test('zip: directoryEntries stores trees under their basename, sorted, without hidden files', () => {
	const root = fakeAddons(tmpdir(), ['Polestar']);
	assert.deepEqual(
		directoryEntries([path.join(root, 'Polestar')]).map((e) => e.name),
		['Polestar/', 'Polestar/Main.lua', 'Polestar/Polestar.toc'],
	);
});

test('zip: an entry that inflates past its declared size, or an archive past the cap, is refused', () => {
	const bomb = Buffer.from(buildZip([{ name: 'Polestar_Guides/Guides/a.lua', data: Buffer.alloc(4 * 1024 * 1024, 45) }]));
	const cd = bomb.indexOf(Buffer.from([0x50, 0x4b, 0x01, 0x02]));
	bomb.writeUInt32LE(16, cd + 24);
	assert.throws(() => readZip(bomb), /corrupt entry/);
	assert.throws(() => readZip(buildZip([{ name: 'a', data: Buffer.alloc(4096) }]), { maxTotal: 1024 }), /exceed the 1024-byte limit/);
});

test('inside a pack, pack writes dist/<folder>-<version>.zip with exactly its five files, reproducibly', () => {
	const PACKS = path.join(__dirname, 'fixtures', 'packs');
	const dir = tmpdir();
	fs.cpSync(path.join(PACKS, 'mini'), dir, { recursive: true });
	const cli = () => polestar(['pack', '--data', DATA_DIR, '--context', path.join(PACKS, 'context'), '--context-data', DATA_DIR], { cwd: path.join(dir, 'guides') });
	const first = cli();
	assert.equal(first.status, 0, first.stderr);
	assert.deepEqual(fs.readdirSync(path.join(dir, 'dist')), ['PolestarPack_MiniPack-0.3.0.zip']);
	const zip = path.join(dir, 'dist', 'PolestarPack_MiniPack-0.3.0.zip');
	const bytes = fs.readFileSync(zip);
	const entries = readZip(zip);
	assert.deepEqual(
		entries.map((e) => e.name),
		['PolestarPack_MiniPack/', ...['Guides.lua', 'LICENSE-DATA.txt', 'MapFrames.lua', 'Pack.lua', 'PolestarPack_MiniPack.toc'].map((f) => `PolestarPack_MiniPack/${f}`)],
	);
	assert.match(entries.find((e) => e.name.endsWith('.toc')).data.toString('utf8'), /## Version: 0\.3\.0/);
	const second = cli();
	assert.equal(second.status, 0, second.stderr);
	assert.ok(fs.readFileSync(zip).equals(bytes), 'identical across runs');
});

test("a pack's LICENSE ships in the zip as LICENSE.txt, byte for byte; its placeholder line warns until replaced", async () => {
	const dir = tmpdir();
	fs.cpSync(path.join(__dirname, 'fixtures', 'packs', 'mini'), dir, { recursive: true });
	const args = ['--pack', dir, '--data', DATA_DIR, '--context', path.join(__dirname, 'fixtures', 'packs', 'context'), '--context-data', DATA_DIR];
	const text = 'Mini Pack by Ann is dedicated to the public domain.\n\nThe full licence text.\n';
	fs.writeFileSync(path.join(dir, 'LICENSE'), text);
	const first = await quiet(() => pack.run(args));
	assert.equal(first.result, 0, first.out);
	const zip = path.join(dir, 'dist', 'PolestarPack_MiniPack-0.3.0.zip');
	const entry = readZip(zip).find((e) => e.name === 'PolestarPack_MiniPack/LICENSE.txt');
	assert.equal(entry && entry.data.toString('utf8'), text);
	const bytes = fs.readFileSync(zip);
	await quiet(() => pack.run(args));
	assert.ok(fs.readFileSync(zip).equals(bytes), 'identical across runs');
	// The line `new` writes for a licence it has no text for.
	fs.writeFileSync(path.join(dir, 'LICENSE'), 'Licensed under CC0-1.0: replace this line with the full text of that licence.\n');
	const lint = await quiet(() => require('../tools/commands/lint').run(args));
	assert.equal(lint.result, 0, lint.out);
	assert.match(lint.out, /LICENSE:1: warning: LICENSE still holds the placeholder line `polestar new` writes, not the licence text\n {2}hint: replace the line with the full text of the CC0-1\.0 licence: the built addon ships LICENSE as LICENSE\.txt/);
});

test('pack refuses a pack with errors and writes nothing', async () => {
	const dir = tmpdir();
	fs.cpSync(path.join(__dirname, 'fixtures', 'packs', 'mini'), dir, { recursive: true });
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id: 'mini', title: 'Mini', author: 'Ann', version: '1', license: 'CC0-1.0', folder: '../escape' }));
	const { result, out } = await quiet(() => pack.run(['--pack', dir, '--data', DATA_DIR, '--context', path.join(__dirname, 'fixtures', 'packs', 'context'), '--context-data', DATA_DIR]));
	assert.equal(result, 1, out);
	assert.match(out, /folder "\.\.\/escape" is malformed/);
	assert.equal(fs.existsSync(path.join(dir, 'dist')), false);
});

test('pack without reference data stops with one error and writes nothing; --no-data is for a pack only', async () => {
	const dir = tmpdir();
	fs.cpSync(path.join(__dirname, 'fixtures', 'packs', 'mini'), dir, { recursive: true });
	const missing = path.join(tmpdir(), 'nope');
	const { result, out } = await quiet(() => pack.run(['--pack', dir, '--data', missing, '--context', path.join(__dirname, 'fixtures', 'packs', 'context'), '--context-data', DATA_DIR]));
	assert.equal(result, 1, out);
	assert.equal(out.split('\n').filter((l) => /error:/.test(l)).length, 1, out);
	assert.match(out, /error: no reference data: the folder does not exist/);
	assert.match(out, /\npack failed: no reference data$/);
	assert.equal(fs.existsSync(path.join(dir, 'dist')), false);
	const ours = await quiet(() => pack.run(['--no-data', '--guides', GUIDES_DIR]));
	assert.equal(ours.result, 2, ours.out);
	assert.match(ours.out, /--no-data builds a community addon; our release needs the reference data/);
});

test('our release: the guide pack folder is not checked for a TOC before it is generated, and write errors are reported', async () => {
	const addons = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Nav', 'Polestar_Recorder', 'Polestar_Codex']);
	const dist = tmpdir();
	const ok = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', dist]));
	assert.equal(ok.result, 0, ok.out);
	assert.doesNotMatch(ok.out, /Polestar_Guides\.toc says version/);
	assert.ok(fs.existsSync(path.join(addons, 'Polestar_Guides', 'Polestar_Guides.toc')));
	// A Polestar_Guides folder we did not generate is refused cleanly.
	const foreign = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Nav', 'Polestar_Recorder', 'Polestar_Codex']);
	fs.mkdirSync(path.join(foreign, 'Polestar_Guides'));
	fs.writeFileSync(path.join(foreign, 'Polestar_Guides', 'mine.txt'), 'mine\n');
	const bad = await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', foreign, '--dist', tmpdir()]));
	assert.equal(bad.result, 1, bad.out);
	assert.match(bad.out, /^pack failed: refusing to write into .*Polestar_Guides/m);
});

// Runs `pack` for our release while reading `file` gives `text` (one of the
// repository's own files, left untouched on disk).
async function packReading(file, text) {
	const readFileSync = fs.readFileSync;
	fs.readFileSync = function (f, ...rest) {
		if (typeof f === 'string' && path.resolve(f) === file) return text;
		return readFileSync.call(this, f, ...rest);
	};
	try {
		const addons = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Nav', 'Polestar_Recorder', 'Polestar_Codex'], packageVersion());
		return await quiet(() => pack.run(['--guides', GUIDES_DIR, '--data', DATA_DIR, '--addons', addons, '--dist', tmpdir()]));
	} finally {
		fs.readFileSync = readFileSync;
	}
}

test('our release: a Polestar.toc without an `## Interface` line is a clear error, not a stack trace', async () => {
	const r = await packReading(path.join(ROOT, 'addon', 'Polestar', 'Polestar.toc'), '## Title: Polestar\nMain.lua\n');
	assert.equal(r.result, 1, r.out);
	assert.match(r.out, /^pack failed: .*Polestar\.toc has no ## Interface line$/m);
});

test('our release: guides/pack.json with another version than package.json is a warning, and the zips are still written', async () => {
	const file = path.join(ROOT, 'guides', 'pack.json');
	const manifest = JSON.parse(fs.readFileSync(file, 'utf8'));
	const r = await packReading(file, JSON.stringify({ ...manifest, version: '0.0.1' }));
	assert.equal(r.result, 0, r.out);
	assert.match(r.out, new RegExp(`^warning: guides/pack\\.json says version 0\\.0\\.1, package\\.json says ${packageVersion().replace(/\./g, '\\.')}$`, 'm'));
	assert.match(r.out, /wrote .*SHA256SUMS/);
});
