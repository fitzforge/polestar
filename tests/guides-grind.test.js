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

for (const dir of ['guides/forever', 'forge/seed/guides/forever']) {
	test(`${dir}: every "grind on" level line names its mob with grind <npcId>`, () => {
		const missing = [];
		let named = 0;
		for (const file of guideFiles(path.join(ROOT, dir))) {
			fs.readFileSync(file, 'utf8')
				.split('\n')
				.forEach((line, i) => {
					const m = /^\s+level\s+[\d.+]+(.*?)\s--\s+grind on (.+?)\s*$/.exec(line);
					if (!m) return;
					if (/\bgrind \d+\b/.test(m[1])) named++;
					else if (!NO_MOB.has(m[2])) missing.push(`${path.relative(ROOT, file)}:${i + 1}: ${line.trim()}`);
				});
		}
		assert.deepEqual(missing, []);
		assert.ok(named > 40, `${named} grind lines`);
	});
}
