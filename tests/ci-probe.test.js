'use strict';
// Throwaway (not for merging): checks tools/ci-tests.sh's base rerun on GitHub (#3851).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const PROF = path.join(__dirname, '..', 'data', 'forever', 'professions.json');
test('probe: on the base, failing on the public data (no professions.json)', () => {
	assert.ok(fs.existsSync(PROF), 'no professions.json');
});
test('probe: on the base, passing', () => {
	assert.equal(1 + 1, 3, 'the head breaks a test the base passes');
});
test('probe: added by the head, failing on the public data (no professions.json)', () => {
	assert.ok(fs.existsSync(PROF), 'no professions.json');
});
