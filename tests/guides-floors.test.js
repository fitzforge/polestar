'use strict';
// Goals upstairs where the walking maps have no way up: the arrow leads to the
// building's door first, since its own walk ends outside the floor, behind the
// wall. In game a guide goal whose last located goal before it is a reached
// `goto` gets the straight arrow from there (Nav/Walk.lua Walk.FollowsGoto,
// which looks past goals at the target's own spot, another quest of the same
// NPC). This walks back the same way over every guide's compiled goals.
//
// Needs data/forever (forge data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { DATA } = require('../tools/lib/paths');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'map-frames.json');

const SAME_SPOT_YD = 3; // Nav/Walk.lua SAME_SPOT_YD

const BUILDINGS = [
	{
		// Jaesais (#1338): Mathrengyl Bearwalker (upstairs) and Arch Druid Fandral Staghelm (at the top) in the
		// Cenarion Enclave's druids' building. The walking maps have no way up inside it: their walk to Mathrengyl
		// went round past the hunters' building onto a ledge outside his floor, and Fandral's floor is not on them.
		// The door on its south side, where players' recordings walk in.
		name: "the druids' building in the Cenarion Enclave",
		npcs: [4217, 3516],
		door: { map: 1457, x: 35.8, y: 11.6 },
	},
];

let data;
function yards(a, b) {
	const { w, h } = data.mapSize(a.map);
	return Math.hypot(((a.x - b.x) / 100) * w, ((a.y - b.y) / 100) * h);
}

function guideFiles(dir) {
	return fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => {
		const p = path.join(dir, e.name);
		return e.isDirectory() ? guideFiles(p) : e.name.endsWith('.guide') ? [p] : [];
	});
}

// The goal Walk.FollowsGoto finds before goal k of step s: the last located one, past goals at its own spot.
function wayIn(steps, s, k) {
	const target = steps[s].goals[k];
	for (let i = s, j = k - 1; i >= 0; i--, j = i >= 0 ? steps[i].goals.length - 1 : -1) {
		for (; j >= 0; j--) {
			const goal = steps[i].goals[j];
			if (goal.map == null || goal.x == null) continue;
			if (goal.t !== 'goto' && goal.map === target.map && yards(goal, target) <= SAME_SPOT_YD) continue;
			return goal;
		}
	}
	return null;
}

for (const b of BUILDINGS) {
	test(`every guide's goal at an NPC upstairs in ${b.name} comes after a goto at its door (#1338)`, { skip }, () => {
		data = data || loadData(DATA);
		const missing = [];
		let checked = 0;
		for (const file of guideFiles(path.join(OFFICIAL_DIR, 'forever'))) {
			const text = fs.readFileSync(file, 'utf8');
			if (!/Darnassus/.test(text)) continue;
			const { guides } = compileSources([{ file, text }], data);
			for (const g of guides) {
				g.steps.forEach((step, s) =>
					step.goals.forEach((goal, k) => {
						if (!b.npcs.includes(goal.npc) || goal.map !== b.door.map) return;
						checked++;
						const before = wayIn(g.steps, s, k);
						const ok = before && before.t === 'goto' && before.map === b.door.map && yards(before, b.door) < 1;
						if (!ok) missing.push(`${path.relative(OFFICIAL_DIR, file)} step ${s + 1} "${step.title}": ${goal.t} ${goal.quest || goal.item || ''} (before it: ${before ? `${before.t} ${before.x},${before.y}` : 'nothing'})`);
					}),
				);
			}
		}
		assert.ok(checked >= 30, `the guides' goals at ${b.name} were found (${checked})`);
		assert.deepEqual(missing, [], 'goals whose arrow would walk to the ledge outside');
	});
}
