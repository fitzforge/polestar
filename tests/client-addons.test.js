'use strict';
// The Addons page offers the same updates as manager::update_all and community::updates:
// addon updates plus routine, compatible community guide updates. The sidebar badges sit on
// the page where each update is found: addon updates on Addons, guide updates on Community
// Guides (#3832). Node strips the types.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { addonUpdateCount, guideUpdateCount, updateAllCount, updateAllTitle } = require('../apps/client/src/lib/addons.ts');

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

test('a community guide update badges Community Guides, not Addons (#3832)', () => {
	const s = snapshot([{ status: 'upToDate' }], [pack()]);
	assert.equal(addonUpdateCount(s), 0);
	assert.equal(guideUpdateCount(s), 1);
});

test('the Addons badge counts addon updates only', () => {
	const products = ['update', 'update', 'upToDate', 'install', 'noGame', 'unknown', 'unavailable'].map((status) => ({ status }));
	assert.equal(addonUpdateCount(snapshot(products, [pack(), pack()])), 2);
	assert.equal(addonUpdateCount(snapshot()), 0);
});

test('the Community Guides badge counts the guide updates the client announces: confirmations and replacements too, not blocked ones', () => {
	const packs = [
		pack(),
		pack({ changes: changes({ publisher: { from: 'Old publisher', to: 'New publisher' } }) }),
		pack({ changes: changes({ added: ['PolestarPack_guide_maps'] }) }),
		pack({ status: 'replaced' }),
		pack({ blocked: 'This guide needs a newer version of Polestar.' }),
		pack({ status: 'replaced', blocked: 'This guide does not match the game version.' }),
		...['install', 'upToDate', 'unlisted', 'noGame', 'disabled', 'removed'].map((status) => pack({ status })),
	];
	assert.equal(guideUpdateCount(snapshot([{ status: 'update' }], packs)), 4);
	assert.equal(guideUpdateCount(snapshot()), 0);
});

test('the Update all tooltip says it installs community guide updates too (#3832)', () => {
	assert.equal(updateAllTitle(snapshot([{ status: 'update' }], [pack()])), 'Installs 1 addon update and 1 community guide update.');
	assert.equal(updateAllTitle(snapshot([{ status: 'update' }, { status: 'update' }])), 'Installs 2 addon updates.');
	assert.equal(updateAllTitle(snapshot([], [pack(), pack()])), 'Installs 2 community guide updates.');
});

test('the Update all tooltip points guide updates that need confirmation to Community Guides', () => {
	const s = snapshot(
		[{ status: 'update' }],
		[pack(), pack({ changes: changes({ removed: ['PolestarPack_guide_deDE'] }) }), pack({ status: 'replaced' }), pack({ blocked: 'This guide needs a newer version of Polestar.' })],
	);
	assert.equal(
		updateAllTitle(s),
		'Installs 1 addon update and 1 community guide update. 2 community guide updates ask first: open Community Guides.',
	);
	assert.equal(
		updateAllTitle(snapshot([{ status: 'update' }], [pack({ status: 'replaced' })])),
		'Installs 1 addon update. 1 community guide update asks first: open Community Guides.',
	);
});
