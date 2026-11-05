'use strict';
// The files a pack folder itself holds (pack.json, LICENSE, retired.json,
// legs.json) and its pictures' folders are read only as plain files inside
// the folder: a pack handed over as a repository or an archive with a link
// to another file of the machine (a token, a key) is refused, and no message
// quotes a file that is no JSON.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA_DIR } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { readManifest, readPackFile } = require('../tools/lib/pack/manifest');
const { buildPack } = require('../tools/lib/pack/build');

const SECRET = 'oauth_token: do-not-ship\n';
const MANIFEST = { id: 'yendi', title: 'Yendi Routes', author: 'Yendi', version: '1.0.0', license: 'MIT' };
const GUIDE = `guide yendi/a
title Yendi A
faction Alliance
levels 1-6
zone Elwynn Forest

step Deputy Willem
  image media/cave
  accept 783
`;

// A pack folder with one guide, and a secret file outside it.
function pack() {
	const dir = tmpdir('polestar-packfiles-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify(MANIFEST));
	fs.writeFileSync(path.join(dir, 'a.guide'), GUIDE);
	const outside = tmpdir('polestar-outside-');
	fs.writeFileSync(path.join(outside, 'hosts.yml'), SECRET);
	return { dir, secret: path.join(outside, 'hosts.yml'), outside };
}

function build(dir) {
	const { manifest, diags } = readManifest(dir);
	assert.ok(manifest, JSON.stringify(diags));
	return buildPack({ dir, manifest, diags, contextDir: null, contextDataDir: null }, { dataDir: DATA_DIR });
}

const messages = (r) => r.diag.list.map((d) => `${d.severity}: ${d.message}`);

test('readPackFile reads a plain file of the pack folder, nothing for an absent one, and refuses a link', () => {
	const { dir, secret } = pack();
	assert.equal(readPackFile(dir, 'pack.json').text, JSON.stringify(MANIFEST));
	assert.deepEqual(readPackFile(dir, 'LICENSE'), {});
	fs.symlinkSync(secret, path.join(dir, 'LICENSE'));
	assert.match(readPackFile(dir, 'LICENSE').error, /^LICENSE is a link or not a plain file/);
	fs.mkdirSync(path.join(dir, 'legs.json'));
	assert.match(readPackFile(dir, 'legs.json').error, /^legs\.json is a link or not a plain file/);
});

test('a LICENSE, retired.json or legs.json linked out of the pack folder is an error and never read into the build', () => {
	const { dir, secret } = pack();
	for (const name of ['LICENSE', 'retired.json', 'legs.json']) fs.symlinkSync(secret, path.join(dir, name));
	const r = build(dir);
	assert.equal(r.ok, false);
	assert.equal(r.files, null);
	for (const name of ['LICENSE', 'retired.json', 'legs.json']) {
		assert.ok(messages(r).some((m) => m.startsWith(`error: ${name} is a link or not a plain file`)), `${name}: ${messages(r).join('\n')}`);
	}
	assert.ok(messages(r).every((m) => !m.includes('do-not-ship')), messages(r).join('\n'));
	// A plain LICENSE ships as LICENSE.txt, as before.
	const plain = pack();
	fs.writeFileSync(path.join(plain.dir, 'LICENSE'), 'MIT License\n');
	const ok = build(plain.dir);
	assert.equal(ok.ok, true, messages(ok).join('\n'));
	assert.equal(String(ok.files['LICENSE.txt']), 'MIT License\n');
});

test('a pack.json that is a link is refused, and one that is no JSON is reported without its contents', () => {
	const { dir, secret } = pack();
	const linked = tmpdir('polestar-linked-');
	fs.symlinkSync(path.join(dir, 'pack.json'), path.join(linked, 'pack.json'));
	const refused = readManifest(linked);
	assert.equal(refused.manifest, null);
	assert.match(refused.diags[0].message, /^pack\.json is a link or not a plain file/);
	fs.copyFileSync(secret, path.join(dir, 'pack.json'));
	const bad = readManifest(dir);
	assert.equal(bad.manifest, null);
	assert.match(bad.diags[0].message, /^pack\.json is not valid JSON/);
	assert.doesNotMatch(bad.diags[0].message, /oauth|do-not-ship/);
	fs.writeFileSync(path.join(dir, 'retired.json'), SECRET);
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify(MANIFEST));
	const r = build(dir);
	const retired = messages(r).find((m) => m.includes('retired.json is not JSON'));
	assert.ok(retired, messages(r).join('\n'));
	assert.doesNotMatch(retired, /oauth|do-not-ship/);
});

test('a picture folder linked out of the pack folder holds no picture', () => {
	const { dir, outside } = pack();
	// A 64x64 TGA header: width and height at bytes 12 and 14.
	const tga = Buffer.alloc(18);
	tga.writeUInt16LE(64, 12);
	tga.writeUInt16LE(64, 14);
	fs.writeFileSync(path.join(outside, 'cave.tga'), tga);
	fs.symlinkSync(outside, path.join(dir, 'media'));
	const r = build(dir);
	assert.ok(messages(r).some((m) => m.includes('the pack folder has no media/cave.tga')), messages(r).join('\n'));
	assert.ok(!Object.keys(r.files || {}).some((f) => f.startsWith('media/')));
});
