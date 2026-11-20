'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('fractional ground-trail controls keep one decimal through the native distance formatter', () => {
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua'] }],
		script: `Polestar.Set("nav.distanceUnit", "yards")
			emit({ gap = Polestar.FormatDistance(0.3, { decimals = 1 }),
				width = Polestar.FormatDistance(1.7, { decimals = 1 }),
				ordinary = Polestar.FormatDistance(120.4) })`,
	}).emitted;
	assert.deepEqual(out, { gap: '0.3 yd', width: '1.7 yd', ordinary: '120 yd' });
});

test('fractional ground distances follow the unit preference, including negative height offsets', () => {
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua'] }],
		script: `Polestar.Set("nav.distanceUnit", "metres")
			emit({ gap = Polestar.FormatDistance(0.3, { decimals = 1 }),
				lift = Polestar.FormatDistance(-1.5, { decimals = 1 }),
				ordinary = Polestar.FormatDistance(100), far = Polestar.FormatDistance(1500, { decimals = 1 }) })`,
	}).emitted;
	assert.equal(out.gap, `${(0.3 * 0.9144).toFixed(1)} m`);
	assert.equal(out.lift, `${(-1.5 * 0.9144).toFixed(1)} m`);
	assert.equal(out.ordinary, '91 m');
	assert.equal(out.far, '1.4 km');
});
