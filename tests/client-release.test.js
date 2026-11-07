'use strict';
// The Polestar Client release's latest.json (apps/client/release/latest-json.sh, run by
// .github/workflows/client.yml): every installed copy must be offered the file of the bundle it
// was installed from. tauri-plugin-updater looks up `{os}-{arch}-{bundle}`, then `{os}-{arch}`,
// and installs the download as its own bundle; a .deb copy offered the AppImage failed with
// "invalid updater binary format" (0.1.0 to 0.1.4 had no deb keys).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { execFileSync, spawnSync } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');

const SCRIPT = path.join(__dirname, '../apps/client/release/latest-json.sh');
const BASE = 'https://github.com/fitzforge/polestar/releases/download/client-v0.1.5';
const FILES = [
	'Polestar.Client_0.1.5_amd64.AppImage',
	'Polestar.Client_0.1.5_aarch64.AppImage',
	'Polestar.Client_0.1.5_amd64.deb',
	'Polestar.Client_0.1.5_arm64.deb',
	'Polestar.Client_0.1.5_x64_en-US.msi',
	'Polestar.Client.app_universal.app.tar.gz',
];

function release(files = FILES) {
	const dir = tmpdir('polestar-client-release-');
	for (const f of files) {
		fs.writeFileSync(path.join(dir, f), 'installer');
		fs.writeFileSync(path.join(dir, `${f}.sig`), `sig of ${f}`);
	}
	// What the release job also has in out/ and must not pick up.
	fs.writeFileSync(path.join(dir, 'Polestar.Client_0.1.5_universal.dmg'), 'dmg');
	return dir;
}

// The plugin's lookup (tauri-plugin-updater 2.14 Updater::get_urls).
function offered(manifest, os, arch, bundle) {
	for (const key of [`${os}-${arch}-${bundle}`, `${os}-${arch}`]) {
		if (manifest.platforms[key]) return manifest.platforms[key];
	}
	return null;
}

// What each bundle's installer accepts (the plugin's install_inner per bundle).
const ACCEPTS = { appimage: /\.AppImage$/, deb: /\.deb$/, msi: /\.msi$/, nsis: /\.msi$/, app: /\.app\.tar\.gz$/ };
const COPIES = [
	['linux', 'x86_64', 'appimage', 'amd64'],
	['linux', 'x86_64', 'deb', 'amd64'],
	['linux', 'aarch64', 'appimage', 'aarch64'],
	['linux', 'aarch64', 'deb', 'arm64'],
	['windows', 'x86_64', 'msi', 'x64'],
	['windows', 'x86_64', 'nsis', 'x64'],
	['windows', 'aarch64', 'msi', 'x64'],
	['darwin', 'aarch64', 'app', 'universal'],
	['darwin', 'x86_64', 'app', 'universal'],
];

test('every installed copy is offered its own bundle, signed, from the release', () => {
	const dir = release();
	const manifest = JSON.parse(execFileSync('bash', [SCRIPT, dir, '0.1.5', BASE], { encoding: 'utf8' }));
	assert.equal(manifest.version, '0.1.5');
	for (const [os, arch, bundle, fileArch] of COPIES) {
		const entry = offered(manifest, os, arch, bundle);
		const what = `${os}-${arch} installed from ${bundle}`;
		assert.ok(entry, `${what}: nothing offered`);
		assert.match(entry.url, ACCEPTS[bundle], `${what}: offered ${entry.url}`);
		assert.ok(entry.url.includes(fileArch), `${what}: offered ${entry.url}`);
		assert.ok(entry.url.startsWith(`${BASE}/`), entry.url);
		assert.equal(entry.signature, `sig of ${path.basename(entry.url)}`);
	}
});

test('a release missing a .deb or a signature gets no latest.json', () => {
	const noDeb = release(FILES.filter((f) => !f.endsWith('_arm64.deb')));
	let run = spawnSync('bash', [SCRIPT, noDeb, '0.1.5', BASE], { encoding: 'utf8' });
	assert.notEqual(run.status, 0);
	assert.match(run.stderr, /no \*_arm64\.deb/);

	const unsigned = release();
	fs.rmSync(path.join(unsigned, 'Polestar.Client_0.1.5_amd64.deb.sig'));
	run = spawnSync('bash', [SCRIPT, unsigned, '0.1.5', BASE], { encoding: 'utf8' });
	assert.notEqual(run.status, 0);
	assert.match(run.stderr, /Polestar\.Client_0\.1\.5_amd64\.deb has no \.sig/);
});
