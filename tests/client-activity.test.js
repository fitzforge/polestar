'use strict';
// Upload retry labels in the Client's Activity screen. Node strips the helper's types.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { sentAgainAt } = require('../apps/client/src/lib/activity.ts');

const entry = (kind, account, at, over = {}) => ({ kind, account, at, chunks: 1, records: 5, bytes: 1000, accepted: [], duplicate: [], rejected: [], message: null, ...over });

test('another account uploading does not resolve either failure of this account', () => {
	const entries = [entry('failed', 'WOW2', 180000), entry('upload', 'WOW1', 120000), entry('failed', 'WOW2', 60000)];
	assert.equal(sentAgainAt(entries, 0), null);
	assert.equal(sentAgainAt(entries, 2), null);
});

test('the first subsequent upload of the same account supplies the retry time', () => {
	const entries = [entry('upload', 'WOW2', 300000), entry('upload', 'WOW2', 240000), entry('upload', 'WOW1', 180000), entry('failed', 'WOW2', 60000)];
	assert.equal(sentAgainAt(entries, 3), 240000);
});

test('an older upload or a newer non-upload entry is not a retry', () => {
	const entries = [entry('update', 'WOW2', 180000), entry('failed', 'WOW2', 120000), entry('upload', 'WOW2', 60000)];
	assert.equal(sentAgainAt(entries, 1), null);
	assert.equal(sentAgainAt(null, 0), null);
});

test('repeated failures of an account can share its next successful request', () => {
	const entries = [entry('upload', 'WOW2', 240000), entry('failed', 'WOW2', 180000), entry('upload', 'WOW1', 120000), entry('failed', 'WOW2', 60000)];
	assert.equal(sentAgainAt(entries, 1), 240000);
	assert.equal(sentAgainAt(entries, 3), 240000);
});

test('unknown accounts cannot establish a retry', () => {
	assert.equal(sentAgainAt([entry('upload', '', 120000), entry('failed', '', 60000)], 1), null);
	assert.equal(sentAgainAt([entry('upload', 'WOW1', 120000), entry('failed', '', 60000)], 1), null);
	assert.equal(sentAgainAt([entry('upload', '', 120000), entry('failed', 'WOW1', 60000)], 1), null);
});

test('a same-account response with duplicates or rejections still means sent again', () => {
	for (const response of [{ duplicate: [1] }, { rejected: [{ seq: 1, reason: 'Invalid record' }] }]) {
		assert.equal(sentAgainAt([entry('upload', 'WOW1', 120000, response), entry('failed', 'WOW1', 60000)], 1), 120000);
	}
});
