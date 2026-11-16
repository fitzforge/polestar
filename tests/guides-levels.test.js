'use strict';
// Our leveling guides' levels, per faction: each side's range of a guide both factions play is the one its
// `levels <min>-<max> Alliance|Horde` gives (docs/GUIDE_FORMAT.md, "Header"), as the addon reads it (Guides.Levels):
// every level from 1 to 60 has a leveling guide on each side, and no guide starts more than a level above the end of
// the guide that leads into it on that side. Reads the guides' headers only.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { guideHeaders, FACTIONS } = require('./helpers/guide-levels');

const all = guideHeaders(path.join(__dirname, '..', 'guides'));
const leveling = Object.entries(all).filter(([, g]) => g.category === 'Leveling');

test('every level from 1 to 60 has a leveling guide on each side', () => {
	assert.ok(leveling.length > 40, `${leveling.length} leveling guides`);
	const gaps = [];
	for (const f of FACTIONS) {
		for (let l = 1; l <= 60; l++) {
			if (!leveling.some(([, g]) => g.levels[f] && g.levels[f].min <= l && l <= g.levels[f].max)) gaps.push(`${f} ${l}`);
		}
	}
	assert.deepEqual(gaps, []);
});

// On each side the guide leads into (its first `next` for that side) starts at most one level above its end.
test('every leveling guide starts at most one level above the end of each guide that leads into it', () => {
	const holes = [];
	for (const [id, g] of Object.entries(all)) {
		for (const f of Object.keys(g.levels)) {
			const nid = g.next.find((n) => all[n] && all[n].levels[f]);
			const n = nid && all[nid].levels[f];
			if (n && n.min > g.levels[f].max + 1) holes.push(`${f}: ${id} ends at ${g.levels[f].max}, ${nid} starts at ${n.min}`);
		}
	}
	assert.deepEqual(holes, []);
});
