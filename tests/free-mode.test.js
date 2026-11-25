'use strict';
const { spawnSync } = require('node:child_process');
const path = require('node:path');
const assert = require('node:assert/strict');
const { test } = require('node:test');
const { findLua } = require('../tools/lib/lua');
const { ADDONS, ROOT, STUBS } = require('./helpers/lua');

test('Free Mode plans held quests and returns control to the active guide', () => {
	const result = spawnSync(findLua(), [
		path.join(STUBS, 'free-mode.lua'),
		path.join(ROOT, 'tools/dev/PolestarFreeMode'),
		ADDONS,
	], { cwd: ROOT, encoding: 'utf8', timeout: 30000 });
	assert.ifError(result.error);
	assert.equal(result.status, 0, result.stderr + result.stdout);
});
