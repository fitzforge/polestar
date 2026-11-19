'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { audit, LOOKS, SURFACES, SCALES, line } = require('../tools/preview/audit');

test('the guide menu leaves game-look scrollbar arrows clickable at every UI scale', async () => {
	const { findings } = await audit({
		looks: LOOKS.filter(look => ['forever', 'blizzard', 'classic'].includes(look.id)),
		surfaces: SURFACES.filter(surface => surface.key === 'guide-menu'),
		scales: SCALES,
		jobs: 2,
	});
	assert.deepEqual(findings.map(line), []);
});
