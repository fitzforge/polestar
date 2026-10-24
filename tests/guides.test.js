'use strict';
// Plays every authored guide (guides/**, drafts excluded) to the end in the real
// engine with the guide simulator of `polestar playtest` (tools/lib/playtest.js):
// compiled with the real reference data, loaded with the full addon, as every
// race that can reach it, once per class the guide branches on plus one class
// it never names. A step that cannot be completed, an accept/turn-in without a
// location, or a candidate pick the character may not use fails the guide.
//
// Needs data/forever (forge data build); skips without it.
// POLESTAR_GUIDES=<substring> limits the run to matching guide files or ids.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { playtest, withChain, resultLines } = require('../tools/lib/playtest');
const { OFFICIAL_DIR, findGuideFiles } = require('../tools/lib/dsl/project');
const { readManifest } = require('../tools/lib/pack/manifest');
const { format } = require('../tools/lib/dsl/diag');

const skip = needs('quests.json') || (findGuideFiles(OFFICIAL_DIR).length === 0 && 'no guides under guides/');

test('every authored guide can be played to the end by every class it branches on', { skip }, async () => {
	const { manifest } = readManifest(OFFICIAL_DIR, { official: true });
	// Fixed in route generation (Desperate Prayer race lock 5635; WPL Arcane Quickener timing), see data/local route
	// handover: the human Elwynn Forest guide's `accept 5635` no longer compiles (the quest is Dwarf-only now), so its
	// `next` chain is left out until the generated routes land.
	const all = findGuideFiles(OFFICIAL_DIR);
	const waiting = new Set(withChain(OFFICIAL_DIR, all, ['forever/alliance/human/01-elwynn-forest.guide']));
	const only = process.env.POLESTAR_GUIDES;
	const filter = (rel) => !waiting.has(rel) && (!only || rel.includes(only));
	const { results, diag, played } = await playtest({ dir: OFFICIAL_DIR, manifest, official: true, filter });
	assert.deepEqual(diag.errors.map(format), [], 'guides must compile without errors');
	assert.ok(played > 0, `no guide matches POLESTAR_GUIDES=${process.env.POLESTAR_GUIDES}`);
	const failures = results.filter((r) => !r.ok).flatMap(resultLines);
	assert.deepEqual([...new Set(failures)], []);
});
