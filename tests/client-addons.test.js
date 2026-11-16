'use strict';
// The Addons page offers the same updates as manager::update_all and community::updates:
// addon updates plus routine, compatible community guide updates. Node strips the types.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { updateAllCount } = require('../apps/client/src/lib/addons.ts');

const snapshot = (products = [], packs = []) => ({ addons: { products }, community: { packs } });
const pack = (extra = {}) => ({ status: 'update', blocked: null, changes: null, ...extra });
const changes = (extra) => ({ replaced: false, publisher: null, added: [], removed: [], ...extra });

test('Update all counts addon updates and routine guide updates in a mixed catalog', () => {
	const s = snapshot(
		[{ status: 'update' }, { status: 'upToDate' }, { status: 'install' }],
		[
			pack(),
			pack({ changes: changes({ publisher: { from: 'Old publisher', to: 'New publisher' } }) }),
			pack({ blocked: 'This guide needs a newer version of Polestar.' }),
		],
	);
	assert.equal(updateAllCount(s), 2);
});

for (const [name, change] of [
	['publisher', { publisher: { from: 'Old publisher', to: 'New publisher' } }],
	['added folders', { added: ['PolestarPack_guide_maps'] }],
	['removed folders', { removed: ['PolestarPack_guide_deDE'] }],
]) {
	test(`an update that needs confirmation for ${name} does not offer Update all by itself`, () => {
		assert.equal(updateAllCount(snapshot([], [pack({ changes: changes(change) })])), 0);
	});
}

test('a compatible routine guide update offers Update all without addon updates', () => {
	assert.equal(updateAllCount(snapshot([{ status: 'upToDate' }], [pack()])), 1);
});

test('blocked guides and states that cannot be updated do not offer Update all', () => {
	const products = ['noGame', 'unknown', 'unavailable', 'install', 'upToDate'].map((status) => ({ status }));
	const packs = ['install', 'upToDate', 'unlisted', 'noGame', 'replaced', 'disabled', 'removed'].map((status) => pack({ status }));
	packs.push(pack({ blocked: 'This guide does not match the game version.' }));
	assert.equal(updateAllCount(snapshot(products, packs)), 0);
	assert.equal(updateAllCount(snapshot()), 0);
});
