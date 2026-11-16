'use strict';
// Pack ids reserved for Polestar (tools/lib/pack/format.js RESERVED_IDS, as
// forge's format.rs and Core/Guides.lua have them): a community pack.json may
// give none, the experimental pack's `polestar-experimental` included; only
// this checkout's experimental/ (Polestar's own extra pack, OWN_EXTRAS) may
// give its own, and no other reserved id.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { ROOT } = require('../tools/lib/paths');
const { RESERVED_IDS, OWN_EXTRAS } = require('../tools/lib/pack/format');
const { validateManifest } = require('../tools/lib/pack/manifest');
const { resolvePack, ownExtra } = require('../tools/lib/pack/locate');

const manifest = (id) => ({ id, title: 'T', author: 'A', version: '1.0.0', license: 'MIT' });
const errors = (diags) => diags.filter((d) => d.severity === 'error').map((d) => d.message).join('\n');

test("a community pack.json may give no reserved id, the experimental pack's included", () => {
	for (const e of OWN_EXTRAS) assert.ok(RESERVED_IDS.has(e.id), `${e.id} is reserved`);
	assert.ok(RESERVED_IDS.has('polestar-experimental'));
	for (const id of RESERVED_IDS) {
		assert.match(errors(validateManifest(manifest(id), 'pack.json')), new RegExp(`^pack id "${id}" is reserved for Polestar`), id);
	}
	assert.equal(errors(validateManifest(manifest('guides'), 'pack.json', { official: true })), '');
	assert.match(errors(validateManifest(manifest('polestar-experimental'), 'pack.json', { official: true })), /reserved for Polestar/);
});

test("this checkout's experimental/ may give its own reserved id and no other; the same pack.json elsewhere may not", () => {
	const extra = ownExtra(path.join(ROOT, 'experimental'));
	assert.equal(extra && extra.id, 'polestar-experimental');
	assert.equal(errors(validateManifest(manifest('polestar-experimental'), 'pack.json', { extra })), '');
	assert.match(errors(validateManifest(manifest('guides'), 'pack.json', { extra })), /^pack id "guides" is reserved for Polestar/);
	// The checkout's own experimental guides, when it has them, read as Polestar's.
	if (fs.existsSync(path.join(ROOT, 'experimental', 'pack.json'))) {
		const ours = resolvePack({ pack: path.join(ROOT, 'experimental') });
		assert.equal(ours.official, false);
		assert.equal(ours.manifest && ours.manifest.id, 'polestar-experimental', JSON.stringify(ours.diags));
	}
	const dir = tmpdir('polestar-reserved-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ ...manifest('polestar-experimental'), author: 'Polestar' }));
	assert.equal(ownExtra(dir), null);
	const elsewhere = resolvePack({ pack: dir });
	assert.equal(elsewhere.manifest, null);
	assert.match(errors(elsewhere.diags), /pack id "polestar-experimental" is reserved for Polestar/);
});
