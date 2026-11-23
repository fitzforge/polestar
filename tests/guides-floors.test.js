'use strict';
// Goals upstairs, in a cellar or down in flooded ruins where the walking maps
// have no way in: the arrow leads to the way in first (a building's door, the
// top of the stairs, the shore), since its own walk ends outside the floor,
// behind the wall or on the ground above. In game a guide goal whose last located goal before it is a reached
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
		issue: '#1338',
		files: /Darnassus/,
		match: (goal) => [4217, 3516].includes(goal.npc),
		doors: [{ map: 1457, x: 35.8, y: 11.6 }],
		min: 30,
	},
	{
		// ItsSaulx (#2509): the Captured Scarlet Zealot is in the Gallows' End Tavern's cellar, which is not on the
		// walking maps. From the ground floor the walk went out of the inn's door and round to the ground outside
		// above the cellar, then back in. The top of the cellar stairs on the ground floor (players' trails before
		// the hand-in), with that floor's height so the walk to it stays inside.
		name: "the Gallows' End Tavern's cellar in Brill",
		issue: '#2509',
		files: /Gallows' End/,
		match: (goal) => goal.npc === 1931,
		doors: [{ map: 1420, x: 61.66, y: 51.5, z: 34.3 }],
		min: 1,
	},
	{
		// Mîku (#2203): the naga for the Corrupted Kor Gem stand in the flooded ruins at the Blackfathom Deeps
		// entrance, a pocket of the walking maps no walk from outside reaches. The arrow went north into Darkshore
		// and up onto the ridge over the dungeon. The north end of the Zoram Strand, where players' recordings swim
		// into the ruins (the walk from Zoram'gar, the strand and Darkshore reaches it).
		name: 'the flooded ruins at the Blackfathom Deeps entrance',
		issue: '#2203',
		files: /\b6995\b/,
		match: (goal) => goal.item === 6995,
		doors: [{ map: 1440, x: 14.6, y: 13.7 }],
		min: 2,
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
	test(`every guide's goal in ${b.name} comes after a goto at its way in (${b.issue})`, { skip }, () => {
		data = data || loadData(DATA);
		const missing = [];
		let checked = 0;
		for (const file of guideFiles(path.join(OFFICIAL_DIR, 'forever'))) {
			const text = fs.readFileSync(file, 'utf8');
			if (!b.files.test(text)) continue;
			const { guides } = compileSources([{ file, text }], data);
			for (const g of guides) {
				g.steps.forEach((step, s) =>
					step.goals.forEach((goal, k) => {
						if (!b.match(goal) || goal.map !== b.doors[0].map) return;
						checked++;
						const before = wayIn(g.steps, s, k);
						const door = before && before.t === 'goto' && b.doors.find((d) => before.map === d.map && yards(before, d) < 1);
						const ok = door && (door.z === undefined || before.z === door.z);
						if (!ok) missing.push(`${path.relative(OFFICIAL_DIR, file)} step ${s + 1} "${step.title}": ${goal.t} ${goal.quest || goal.item || ''} (before it: ${before ? `${before.t} ${before.x},${before.y}${before.z !== undefined ? ` z ${before.z}` : ''}` : 'nothing'})`);
					}),
				);
			}
		}
		assert.ok(checked >= b.min, `the guides' goals in ${b.name} were found (${checked})`);
		assert.deepEqual(missing, [], 'goals whose arrow would walk outside, onto the ground above or to a ledge');
	});
}
