'use strict';
// Kept steps of places only (#4467, docs/GUIDE_FORMAT.md "Steps of places only"): in our leveling guides every step
// whose goals are only gotos, a flight or `enter` is a hidden via unless a `keep <kind> <reason>` line keeps it. Each
// `keep` comes from a data/guide-fixes.json record (`way.keep`) so a guide build writes it again, and each record
// has its `keep` in the guide, right before the anchored goal's step, with the same kind and reason. Parse only: no
// reference data needed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { ROOT } = require('../tools/lib/paths');

const GUIDES = path.join(ROOT, 'guides');
const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data/guide-fixes.json'), 'utf8')).fixes;
const PLACE = new Set(['goto', 'fly', 'enter']);

function guideOf(id) {
	const file = path.join(GUIDES, `${id}.guide`);
	return fs.existsSync(file) ? parseGuide(fs.readFileSync(file, 'utf8'), file, new Diagnostics()) : null;
}

// The step holding the record's anchored goal (accept, turnin, complete, or an objective's goal).
function anchoredStep(guide, at) {
	return guide.steps.findIndex((s) => s.goals.some((g) => {
		if (at.goal === 'objective') return g.quest === at.quest && (at.objective === undefined || g.objective === undefined || g.objective === at.objective) && g.verb !== 'accept' && g.verb !== 'turnin';
		return g.verb === at.goal && g.quest === at.quest;
	}));
}

const records = fixes.filter((r) => r.way && r.way.keep);

test('every way.keep record has its keep line right before its goal\'s step', () => {
	assert.ok(records.length > 0);
	for (const r of records) {
		const guide = guideOf(r.at.guide);
		assert.ok(guide, `${r.id}: guide ${r.at.guide}`);
		const s = anchoredStep(guide, r.at);
		assert.ok(s > 0, `${r.id}: the goal's step in ${r.at.guide}`);
		const keep = guide.steps[s - 1].keep;
		assert.deepEqual(keep && { kind: keep.kind, reason: keep.reason }, r.way.keep, `${r.id}: the keep line of "${guide.steps[s - 1].title}"`);
	}
});

test('every keep line in a leveling guide is on a step of places only and has its record', () => {
	const recorded = new Set(records.map((r) => `${r.at.guide}|${r.way.keep.kind}|${r.way.keep.reason}`));
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	let n = 0;
	for (const file of walk(path.join(GUIDES, 'forever'))) {
		const g = parseGuide(fs.readFileSync(file, 'utf8'), file, new Diagnostics());
		if ((g.header.category || 'Leveling') !== 'Leveling') continue;
		for (const s of g.steps) {
			if (!s.keep) continue;
			n++;
			const goals = s.goals.filter((x) => x.verb !== 'note');
			assert.ok(goals.length && goals.every((x) => PLACE.has(x.verb)), `${g.id}: "${s.title}" keeps a step with work of its own`);
			assert.ok(recorded.has(`${g.id}|${s.keep.kind}|${s.keep.reason}`), `${g.id}: "${s.title}" has no guide-fixes way.keep record`);
		}
	}
	assert.equal(n, records.length, 'a record per keep line');
});
