'use strict';
// Grind steps name their mob (`level N grind <npcId> -- grind on <Mob>`, docs/GUIDE_FORMAT.md), so the arrow leads
// to the mob's nearest spawn area instead of the step's goto (Engine Own.grindAfter). Every `level` line whose note
// says "grind on" carries a `grind` id, in our guides and in Forge's seed, except a grind on several mobs or a
// place, which names no one mob.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
// No one mob: a camp of several kinds, or a place.
const NO_MOB = new Set(['the Grimtotem below Darkcloud Pinnacle', "the Bloodscalps here: Speaking with Gan'zulah, at the cauldron next, sends you to Skullsplitters of 41-43"]);

function guideFiles(dir) {
	if (!fs.existsSync(dir)) return [];
	return fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) return guideFiles(p);
		return e.name.endsWith('.guide') ? [p] : [];
	});
}

// The grind line under a `level` step (the dungeon a player could run instead, UI.DungeonToast.GrindLine) shows on
// Leveling guides only, so a grind step stands in a guide without another `category`. No count floor: the 0.4.2
// route round replaced grind steps with quests on purpose, so how many there are is the routes' business; the scan
// only has to see some, so a format change can't leave it checking nothing.
for (const dir of ['guides/forever', 'forge/seed/guides/forever']) {
	test(`${dir}: every "grind on" level line names its mob with grind <npcId>, in a Leveling guide`, () => {
		const missing = [];
		const notLeveling = [];
		let named = 0;
		for (const file of guideFiles(path.join(ROOT, dir))) {
			const text = fs.readFileSync(file, 'utf8');
			const category = /^category\s+(\S+)/m.exec(text)?.[1] ?? 'Leveling';
			text.split('\n').forEach((line, i) => {
				const m = /^\s+level\s+[\d.+]+(.*?)\s--\s+grind on (.+?)\s*$/.exec(line);
				if (!m) return;
				const at = `${path.relative(ROOT, file)}:${i + 1}: ${line.trim()}`;
				if (category !== 'Leveling') notLeveling.push(at);
				if (/\bgrind \d+\b/.test(m[1])) named++;
				else if (!NO_MOB.has(m[2])) missing.push(at);
			});
		}
		assert.deepEqual(missing, []);
		assert.deepEqual(notLeveling, []);
		assert.ok(named > 0, "the scan finds the guides' named grind lines");
	});
}
