'use strict';
// What Polestar Client says over every page (apps/client/src/lib/notices.ts,
// used by App.svelte): the update banner while a Client update waits, and the
// sharing notice once while sharing is on. Node strips the module's types.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { shareNotice, updateBanner, releaseUrl } = require('../apps/client/src/lib/notices.ts');

const snapshot = (over) => ({ setupDone: true, consent: true, shareNotice: false, update: null, ...over });

test('the update banner shows while a Client update waits, and goes when up to date', () => {
	assert.equal(updateBanner(snapshot({ update: '0.1.4' })), '0.1.4');
	// Before setup is done too: the banner is over the whole window then.
	assert.equal(updateBanner(snapshot({ update: '0.1.4', setupDone: false })), '0.1.4');
	assert.equal(updateBanner(snapshot({ update: null })), null);
	assert.equal(updateBanner(null), null);
	assert.equal(releaseUrl('0.1.4'), 'https://github.com/fitzforge/polestar/releases/tag/client-v0.1.4');
});

test('the sharing notice shows once, only while sharing is on', () => {
	assert.equal(shareNotice(snapshot({ shareNotice: true })), true);
	// Read, sharing off, or the game not found yet: not shown.
	assert.equal(shareNotice(snapshot({ shareNotice: false })), false);
	assert.equal(shareNotice(snapshot({ shareNotice: true, consent: false })), false);
	assert.equal(shareNotice(snapshot({ shareNotice: true, setupDone: false })), false);
	assert.equal(shareNotice(null), false);
});
