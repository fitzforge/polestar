'use strict';
// install: destination choice (flag, env, Wine-prefix auto-detection by
// .flavor.info), dry runs, copies and symlinks that touch only Polestar folders.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { quiet, fakeAddons } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { TOC_MARKER } = require('../tools/lib/pack/format');
const install = require('../tools/commands/install');
const { detectAddonsDirs } = require('../tools/lib/addons');

function compiledAddons() {
	const root = fakeAddons(tmpdir());
	fs.writeFileSync(path.join(root, 'Polestar_Guides', 'Guides.lua'), 'do\n\tlocal function register()\n\t\tPolestar.RegisterGuide({ id = "forever/a" })\n\tend\n\tregister()\nend\n');
	return root;
}

// An AddOns folder with someone else's addon and an old Polestar.
function liveAddOns() {
	const dir = tmpdir();
	fs.mkdirSync(path.join(dir, 'OtherAddon'));
	fs.writeFileSync(path.join(dir, 'OtherAddon', 'OtherAddon.toc'), 'other\n');
	fs.mkdirSync(path.join(dir, 'Polestar'));
	fs.writeFileSync(path.join(dir, 'Polestar', 'old-file.lua'), '-- from the previous version\n');
	fs.writeFileSync(path.join(dir, 'Polestar', 'Polestar.toc'), '## Version: 0.0.1\n');
	return dir;
}

function snapshot(dir) {
	const out = {};
	const walk = (d) => {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			const rel = path.relative(dir, p).split(path.sep).join('/');
			if (e.isSymbolicLink()) out[rel] = `-> ${fs.readlinkSync(p)}`;
			else if (e.isDirectory()) walk(p);
			else out[rel] = fs.readFileSync(p, 'utf8');
		}
	};
	walk(dir);
	return out;
}

function flavorClient(wowDir, name, flavor) {
	const dir = path.join(wowDir, name);
	fs.mkdirSync(path.join(dir, 'Interface', 'AddOns'), { recursive: true });
	if (flavor) fs.writeFileSync(path.join(dir, '.flavor.info'), `Product Flavor!STRING:0\n${flavor}\n`);
	return dir;
}

test('--dry-run reports the plan and changes nothing', async () => {
	const src = compiledAddons();
	const dest = liveAddOns();
	const before = snapshot(dest);
	const { result, out } = await quiet(() => install.run(['--dest', dest, '--addons', src, '--dry-run', '--recorder'], {}));
	assert.equal(result, 0, out);
	assert.match(out, /would replace Polestar \(copy from/);
	assert.match(out, /would add Polestar_Guides/);
	assert.match(out, /would add Polestar_Recorder/);
	assert.deepEqual(snapshot(dest), before);
});

test('the built data addons (Polestar_QuestDB, Polestar_ItemDB, Polestar_Codex) install by default; a missing one is skipped', async () => {
	const src = compiledAddons();
	fakeAddons(src, ['Polestar_QuestDB']);
	const dest = liveAddOns();
	const { result, out } = await quiet(() => install.run(['--dest', dest, '--addons', src], {}));
	assert.equal(result, 0, out);
	assert.match(out, /note: Polestar_ItemDB not built \(no Polestar_ItemDB\/Polestar_ItemDB\.toc\); skipping it/);
	assert.match(out, /note: Polestar_Codex not built \(no Polestar_Codex\/Polestar_Codex\.toc\); skipping it/);
	assert.deepEqual(fs.readdirSync(dest).sort(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_QuestDB', 'OtherAddon'].sort());
	fakeAddons(src, ['Polestar_ItemDB', 'Polestar_Codex']);
	const dry = await quiet(() => install.run(['--dest', dest, '--addons', src, '--dry-run'], {}));
	assert.match(dry.out, /would replace Polestar_QuestDB[\s\S]*would add Polestar_ItemDB[\s\S]*would add Polestar_Codex/);
});

test('--dest copies only the Polestar folders, replacing old copies and leaving everything else alone', async () => {
	const src = compiledAddons();
	const dest = liveAddOns();
	const { result, out } = await quiet(() => install.run(['--dest', dest, '--addons', src], {}));
	assert.equal(result, 0, out);
	assert.deepEqual(fs.readdirSync(dest).sort(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'OtherAddon'].sort());
	const after = snapshot(dest);
	assert.equal(after['OtherAddon/OtherAddon.toc'], 'other\n');
	assert.equal(after['Polestar/old-file.lua'], undefined, 'old copy replaced, not merged');
	assert.equal(after['Polestar/Polestar.toc'], fs.readFileSync(path.join(src, 'Polestar', 'Polestar.toc'), 'utf8'));
	assert.equal(after['Polestar/.hidden'], undefined, 'hidden files are not installed');
	assert.ok(after['Polestar_Guides/Guides.lua']);
	assert.equal(fs.existsSync(path.join(dest, 'Polestar_Recorder')), false, 'recorder only on request');
});

test('--link symlinks the folders, and a later copy replaces the links without touching the sources', async () => {
	const src = compiledAddons();
	const dest = liveAddOns();
	assert.equal((await quiet(() => install.run(['--dest', dest, '--addons', src, '--link', '--recorder'], {}))).result, 0);
	for (const n of ['Polestar', 'Polestar_Guides', 'Polestar_Recorder']) {
		assert.ok(fs.lstatSync(path.join(dest, n)).isSymbolicLink(), n);
		assert.equal(fs.realpathSync(path.join(dest, n)), fs.realpathSync(path.join(src, n)));
	}
	assert.equal((await quiet(() => install.run(['--dest', dest, '--addons', src], {}))).result, 0);
	assert.ok(fs.lstatSync(path.join(dest, 'Polestar')).isDirectory());
	assert.ok(fs.existsSync(path.join(src, 'Polestar', 'Polestar.toc')), 'source survives replacing its link');
	assert.ok(fs.lstatSync(path.join(dest, 'Polestar_Recorder')).isSymbolicLink(), 'not reinstalled without --recorder');
});

test('$WOW_FOREVER_ADDONS is used when --dest is absent; --dest wins over it', async () => {
	const src = compiledAddons();
	const envDest = tmpdir();
	const flagDest = tmpdir();
	assert.equal((await quiet(() => install.run(['--addons', src], { WOW_FOREVER_ADDONS: envDest, HOME: tmpdir() }))).result, 0);
	assert.ok(fs.existsSync(path.join(envDest, 'Polestar', 'Polestar.toc')));
	assert.equal((await quiet(() => install.run(['--addons', src, '--dest', flagDest], { WOW_FOREVER_ADDONS: envDest }))).result, 0);
	assert.ok(fs.existsSync(path.join(flagDest, 'Polestar', 'Polestar.toc')));
	const missing = await quiet(() => install.run(['--addons', src, '--dest', path.join(flagDest, 'nope')], {}));
	assert.equal(missing.result, 1);
	assert.match(missing.out, /is not a folder/);
});

// Auto-detect tests pass this as the platform so they never reach a native
// install on the machine running them (C:\Program Files (x86)\... or /Applications/...).
const NO_NATIVE = { platform: 'linux' };

test('auto-detect finds the Forever client in Wine/Proton/Faugus prefixes by its .flavor.info', () => {
	const home = tmpdir();
	const wow = path.join(home, 'Games', 'drive_c', 'Program Files (x86)', 'World of Warcraft');
	const beta = flavorClient(wow, '_classic_beta_', 'wow_classic_beta');
	flavorClient(wow, '_classic_era_', 'wow_classic_era');
	flavorClient(wow, '_retail_', 'wow');
	flavorClient(wow, '_anniversary_', 'wow_anniversary');
	// A "_classic_beta_" without a flavor file is not trusted.
	flavorClient(path.join(home, '.wine', 'drive_c', 'Program Files (x86)', 'World of Warcraft'), '_classic_beta_', null);
	let found = detectAddonsDirs(home, NO_NATIVE);
	assert.deepEqual(found.map((f) => [f.addons, f.kind]), [[path.join(beta, 'Interface', 'AddOns'), 'beta']]);
	assert.deepEqual(install.chooseDest({}, {}, home, NO_NATIVE).dir, path.join(beta, 'Interface', 'AddOns'));

	// After launch: a _forever_ client in a Faugus prefix wins over the beta.
	const live = flavorClient(path.join(home, 'Faugus', 'battlenet', 'drive_c', 'Program Files (x86)', 'World of Warcraft'), '_forever_', 'wow_forever');
	found = detectAddonsDirs(home, NO_NATIVE);
	assert.equal(found.length, 2);
	assert.deepEqual(install.chooseDest({}, {}, home, NO_NATIVE).dir, path.join(live, 'Interface', 'AddOns'));

	// Proton prefixes keep drive_c under pfx/.
	const proton = flavorClient(path.join(home, '.local', 'share', 'Steam', 'steamapps', 'compatdata', '12345', 'pfx', 'drive_c', 'Program Files (x86)', 'World of Warcraft'), '_forever_', 'wow_forever');
	assert.ok(detectAddonsDirs(home, NO_NATIVE).some((f) => f.client === proton));
	const two = install.chooseDest({}, {}, home, NO_NATIVE);
	assert.match(two.error, /several Forever clients found/);
});

test('auto-detected installs create Interface/AddOns when the client has none yet', async () => {
	const home = tmpdir();
	const client = path.join(home, 'Games', 'drive_c', 'Program Files (x86)', 'World of Warcraft', '_classic_beta_');
	fs.mkdirSync(client, { recursive: true });
	fs.writeFileSync(path.join(client, '.flavor.info'), 'Product Flavor!STRING:0\nwow_classic_beta\n');
	const src = compiledAddons();
	const { result, out } = await quiet(() => install.run(['--addons', src], { HOME: home }, NO_NATIVE));
	assert.equal(result, 0, out);
	assert.deepEqual(fs.readdirSync(path.join(client, 'Interface', 'AddOns')).sort(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav']);
	const none = await quiet(() => install.run(['--addons', src], { HOME: tmpdir() }, NO_NATIVE));
	assert.equal(none.result, 1);
	assert.match(none.out, /no World of Warcraft: Forever client found/);
});

test('install refuses to replace its own source, install into the source, or replace a folder that is not that addon', async () => {
	const src = compiledAddons();
	const intoSource = await quiet(() => install.run(['--dest', src, '--addons', src], {}));
	assert.equal(intoSource.result, 1);
	assert.match(intoSource.out, /refusing to install: .*Polestar is \(or contains\) the source/);
	const nested = await quiet(() => install.run(['--dest', path.join(src, 'Polestar'), '--addons', src, '--link'], {}));
	assert.equal(nested.result, 1);
	assert.match(nested.out, /is inside the source/);
	// An AddOns folder symlinked to the source tree.
	const linked = path.join(tmpdir(), 'AddOns');
	fs.symlinkSync(src, linked, 'dir');
	assert.equal((await quiet(() => install.run(['--dest', linked, '--addons', src, '--link'], {}))).result, 1);
	// A same-named folder that is not that addon is left alone.
	const dest = tmpdir();
	fs.mkdirSync(path.join(dest, 'Polestar'));
	fs.writeFileSync(path.join(dest, 'Polestar', 'notes.txt'), 'mine\n');
	const foreign = await quiet(() => install.run(['--dest', dest, '--addons', src], {}));
	assert.equal(foreign.result, 1);
	assert.match(foreign.out, /has no Polestar\.toc; not an installed Polestar/);
	assert.equal(fs.readFileSync(path.join(dest, 'Polestar', 'notes.txt'), 'utf8'), 'mine\n');
	// Sources are untouched by all of the above.
	for (const n of ['Polestar', 'Polestar_Guides']) assert.ok(fs.existsSync(path.join(src, n, `${n}.toc`)), n);
});

// Pack mode: a temp copy of the mini fixture pack, built with the fixture data
// and the context fixture standing in for our guides.
const PACKS = path.join(__dirname, 'fixtures', 'packs');
const { DATA_DIR } = require('./helpers/dsl');

function miniCopy(manifest = null) {
	const dir = tmpdir();
	fs.cpSync(path.join(PACKS, 'mini'), dir, { recursive: true });
	if (manifest) fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify(manifest, null, '\t'));
	return dir;
}

const packArgs = (dir) => ['--pack', dir, '--data', DATA_DIR, '--context', path.join(PACKS, 'context'), '--context-data', DATA_DIR];

test('inside a pack, install builds it and installs its folder; a second install replaces it', async () => {
	const pack = miniCopy();
	const dest = liveAddOns();
	const first = await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}));
	assert.equal(first.result, 0, first.out);
	assert.match(first.out, /added PolestarPack_MiniPack/);
	const folder = path.join(dest, 'PolestarPack_MiniPack');
	assert.deepEqual(fs.readdirSync(folder).sort(), ['Guides.lua', 'LICENSE-DATA.txt', 'PolestarPack_MiniPack.toc', 'MapFrames.lua', 'Pack.lua'].sort());
	assert.match(fs.readFileSync(path.join(folder, 'PolestarPack_MiniPack.toc'), 'utf8'), /^## Title: Polestar Community: Mini Pack$/m);
	assert.ok(fs.existsSync(path.join(pack, 'dist', 'PolestarPack_MiniPack', 'Guides.lua')), 'built into the pack\'s dist/');
	assert.deepEqual(fs.readdirSync(dest).sort(), ['Polestar', 'PolestarPack_MiniPack', 'OtherAddon'].sort(), 'only the pack folder is installed');
	fs.writeFileSync(path.join(pack, 'guides', 'b.guide'), fs.readFileSync(path.join(pack, 'guides', 'b.guide'), 'utf8').replace('title Mini B', 'title Mini B2'));
	const second = await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}));
	assert.equal(second.result, 0, second.out);
	assert.match(second.out, /replaced PolestarPack_MiniPack/);
	assert.match(fs.readFileSync(path.join(folder, 'Guides.lua'), 'utf8'), /Mini B2/);
	const dry = await quiet(() => install.run([...packArgs(pack), '--dest', dest, '--dry-run'], {}));
	assert.equal(dry.result, 0, dry.out);
	assert.match(dry.out, /would replace PolestarPack_MiniPack/);
});

test('install of a pack without reference data stops with one error and touches nothing', async () => {
	const pack = miniCopy();
	const dest = liveAddOns();
	const before = snapshot(dest);
	const empty = tmpdir();
	const { result, out } = await quiet(() => install.run(['--pack', pack, '--data', empty, '--context', path.join(PACKS, 'context'), '--context-data', DATA_DIR, '--dest', dest], {}));
	assert.equal(result, 1, out);
	assert.equal(out.split('\n').filter((l) => /error:/.test(l)).length, 1, out);
	assert.match(out, /error: no reference data: the folder holds none of quests\.json/);
	assert.match(out, /--no-data checks guides/);
	assert.match(out, /\ninstall failed: no reference data$/);
	assert.deepEqual(snapshot(dest), before);
	assert.equal(fs.existsSync(path.join(pack, 'dist')), false);
	const ours = await quiet(() => install.run(['--no-data', '--dest', dest], {}));
	assert.equal(ours.result, 2, ours.out);
	assert.match(ours.out, /--no-data builds a community addon/);
});

test('install refuses to replace a hand-made folder with the pack folder\'s name', async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	fs.mkdirSync(path.join(dest, 'PolestarPack_MiniPack'));
	fs.writeFileSync(path.join(dest, 'PolestarPack_MiniPack', 'PolestarPack_MiniPack.toc'), '## Title: mine\n');
	const before = snapshot(dest);
	const { result, out } = await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}));
	assert.equal(result, 1, out);
	assert.match(out, /refusing to install: .*PolestarPack_MiniPack: it is not a generated community addon/);
	assert.deepEqual(snapshot(dest), before);
});

test('install replaces an empty folder with the pack folder\'s name (the one folder rule)', async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	fs.mkdirSync(path.join(dest, 'PolestarPack_MiniPack'));
	const { result, out } = await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}));
	assert.equal(result, 0, out);
	assert.match(out, /replaced PolestarPack_MiniPack/);
	assert.ok(fs.existsSync(path.join(dest, 'PolestarPack_MiniPack', 'Guides.lua')));
});

test('install refuses a generated folder of another pack with the same folder name, pointing to "folder" in pack.json', async () => {
	const dest = tmpdir();
	// Another pack titled "Mini Pack" (its own id) was installed into the same default folder.
	const other = path.join(dest, 'PolestarPack_MiniPack');
	fs.mkdirSync(other);
	fs.writeFileSync(path.join(other, 'PolestarPack_MiniPack.toc'), `## Title: Mini Pack\n${TOC_MARKER}\n## X-Polestar-Pack: other-mini\n`);
	const before = snapshot(dest);
	const { result, out } = await quiet(() => install.run([...packArgs(miniCopy()), '--dest', dest], {}));
	assert.equal(result, 1, out);
	assert.match(out, /refusing to install: .*PolestarPack_MiniPack: it holds the community addon "other-mini", not "mini"; set "folder" in pack\.json/);
	assert.deepEqual(snapshot(dest), before);
});

test('install <dir> works on that pack: a dry run plans only its folder; two folders are a usage error', async () => {
	const pack = miniCopy();
	const dest = liveAddOns();
	const before = snapshot(dest);
	const ctx = ['--data', DATA_DIR, '--context', path.join(PACKS, 'context'), '--context-data', DATA_DIR];
	const dry = await quiet(() => install.run([pack, ...ctx, '--dest', dest, '--dry-run'], {}));
	assert.equal(dry.result, 0, dry.out);
	assert.deepEqual(dry.out.split('\n').filter((l) => /^\s+would (add|replace)/.test(l)).map((l) => l.trim().split(' ').slice(0, 3).join(' ')), ['would add PolestarPack_MiniPack']);
	assert.deepEqual(snapshot(dest), before);
	const two = await quiet(() => install.run([pack, miniCopy(), '--dest', dest, '--dry-run'], {}));
	assert.equal(two.result, 2, two.out);
	assert.match(two.out, /one pack folder only, got 2/);
	const none = await quiet(() => install.run([tmpdir(), '--dest', dest, '--dry-run'], {}));
	assert.equal(none.result, 2, none.out);
	assert.match(none.out, /no pack\.json in /);
});

test('a --context folder that does not exist is a usage error, not a crash', async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	const missing = path.join(tmpdir(), 'missing');
	const { result, out } = await quiet(() => install.run(['--pack', pack, '--data', DATA_DIR, '--context', missing, '--dest', dest], {}));
	assert.equal(result, 2, out);
	assert.match(out, /--context .*missing is not a folder/);
	assert.deepEqual(fs.readdirSync(dest), []);
});

test('a pack.json folder like ../x never reaches install: lint fails first and nothing is written', async () => {
	const base = JSON.parse(fs.readFileSync(path.join(PACKS, 'mini', 'pack.json'), 'utf8'));
	for (const folder of ['../x', '..', 'a/b', '/tmp/x']) {
		const pack = miniCopy({ ...base, folder });
		const root = tmpdir();
		const dest = path.join(root, 'AddOns');
		fs.mkdirSync(dest);
		const { result, out } = await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}));
		assert.equal(result, 1, out);
		assert.match(out, /folder ".*" is malformed/);
		assert.deepEqual(fs.readdirSync(root), ['AddOns'], folder);
		assert.deepEqual(fs.readdirSync(dest), [], folder);
		assert.equal(fs.existsSync(path.join(pack, 'dist')), false, folder);
	}
});

test('auto-detect finds native Windows and macOS installs by .flavor.info (platform and root injected)', async () => {
	const home = tmpdir();
	const winRoot = tmpdir();
	const win = flavorClient(path.join(winRoot, 'Program Files (x86)', 'World of Warcraft'), '_classic_era_', 'wow_forever');
	flavorClient(path.join(winRoot, 'Program Files (x86)', 'World of Warcraft'), '_retail_', 'wow');
	assert.deepEqual(detectAddonsDirs(home, { platform: 'win32', root: winRoot }).map((f) => [f.addons, f.kind]), [[path.join(win, 'Interface', 'AddOns'), 'forever']]);
	assert.equal(install.chooseDest({}, {}, home, { platform: 'win32', root: winRoot }).dir, path.join(win, 'Interface', 'AddOns'));
	// install itself takes the same injection.
	const { result, out } = await quiet(() => install.run(['--addons', compiledAddons()], { HOME: home }, { platform: 'win32', root: winRoot }));
	assert.equal(result, 0, out);
	assert.deepEqual(fs.readdirSync(path.join(win, 'Interface', 'AddOns')).sort(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav']);
	const macRoot = tmpdir();
	const mac = flavorClient(path.join(macRoot, 'Applications', 'World of Warcraft'), '_classic_era_', 'wow_forever');
	assert.deepEqual(detectAddonsDirs(home, { platform: 'darwin', root: macRoot }).map((f) => f.client), [mac]);
	// Each platform checks only its own native folder.
	assert.deepEqual(detectAddonsDirs(home, { platform: 'darwin', root: winRoot }), []);
	assert.deepEqual(detectAddonsDirs(home, { platform: 'linux', root: macRoot }), []);
});

test('install --link of a pack links its built dist/ folder, so a later compile shows after /reload', async () => {
	const pack = miniCopy();
	const dest = liveAddOns();
	const r = await quiet(() => install.run([...packArgs(pack), '--dest', dest, '--link'], {}));
	assert.equal(r.result, 0, r.out);
	const folder = path.join(dest, 'PolestarPack_MiniPack');
	assert.ok(fs.lstatSync(folder).isSymbolicLink());
	assert.equal(fs.realpathSync(folder), fs.realpathSync(path.join(pack, 'dist', 'PolestarPack_MiniPack')));
	assert.deepEqual(fs.readdirSync(dest).sort(), ['Polestar', 'PolestarPack_MiniPack', 'OtherAddon'].sort());
	// A copy later replaces the link and leaves the build alone.
	assert.equal((await quiet(() => install.run([...packArgs(pack), '--dest', dest], {}))).result, 0);
	assert.ok(fs.lstatSync(folder).isDirectory());
	assert.ok(fs.existsSync(path.join(pack, 'dist', 'PolestarPack_MiniPack', 'Guides.lua')));
});
