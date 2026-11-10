'use strict';
// The Expert and Artisan `train` steps of the crafting profession guides, as
// the committed Polestar_Guides ships them, point only at the trainers who
// teach that rank on Forever. Expected lists: the Forever TrinityCore world
// DB (data/local/forever-tdb/world.sqlite, 2026-11-10): the creatures whose
// trainer list (creature_trainer -> trainer_spell) has the rank's spell
// (Expert Leatherworker 3811, Artisan 10662, ...). Reads Guides.lua only, so
// it runs without data/forever.
//
// mutaka's report (#1608): the Expert Leatherworking arrow picked from the
// profession's whole trainer list (Simon Tanner, Fimble Finespindle; Horde
// Karolek, Arthur Moore), who teach only up to Journeyman, because
// professions.json was built without the sniffed trainer lists.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const GUIDES = path.join(__dirname, '..', 'addon', 'Polestar_Guides', 'Guides.lua');

// skill -> rank -> npc ids. Left out on purpose: Annora (Expert Enchanting),
// inside Uldaman with no spawn in the reference data, and Meilosh (Expert and
// Artisan Tailoring), Timbermaw Hold's trainer, who needs Timbermaw standing.
const FOREVER = {
	Alchemy: { 3: [1386, 4160, 4611, 7948], 4: [1386, 7948] },
	Blacksmithing: { 3: [2836, 3355, 4258], 4: [2836] },
	Enchanting: { 3: [11072, 11074] },
	Engineering: { 3: [5174, 8736, 11017], 4: [8736] },
	Leatherworking: { 3: [3007, 4212, 11097, 11098], 4: [11097, 11098] },
	Tailoring: { 3: [1346, 2399, 4576, 11052], 4: [2399, 11052] },
};

// { [skill]: { [rank]: sorted npc ids } } from every `train` goal of the
// forever/professions guides.
function trainSteps() {
	const lua = fs.readFileSync(GUIDES, 'utf8');
	const out = {};
	const parts = lua.split(/^(-- Source: .*)$/m);
	for (let i = 1; i < parts.length; i += 2) {
		if (!parts[i].includes('forever/professions/')) continue;
		const block = parts[i + 1];
		const recs = block.match(/local candidateRecords = \{\n([\s\S]*?)\n\t\t\}\n/);
		const records = recs ? [...recs[1].matchAll(/^\t\t\t\{ npc = (\d+)/gm)].map((m) => Number(m[1])) : [];
		const ids = (text) => [...text.matchAll(/candidateRecords\[(\d+)\]|\{ npc = (\d+)/g)].map((m) => (m[1] ? records[Number(m[1]) - 1] : Number(m[2])));
		const lists = block.match(/local candidateLists = \{\n([\s\S]*?)\n\t\t\}\n/);
		const shared = lists ? lists[1].split('\n').map(ids) : [];
		for (const m of block.matchAll(/t = "train", skill = "([^"]+)", skillLine = \d+, rank = (\d), rankMax = \d+, candidates = (.*)$/gm)) {
			const ref = m[3].match(/^candidateLists\[(\d+)\]/);
			const npcs = ref ? shared[Number(ref[1]) - 1] : ids(m[3]);
			assert.ok(npcs && npcs.every(Number.isInteger), `${m[1]} rank ${m[2]}: candidates parsed`);
			(out[m[1]] ??= {})[m[2]] = [...new Set(npcs)].sort((a, b) => a - b);
		}
	}
	return out;
}

test("mutaka's report (#1608): Expert Leatherworking points only at Una, Telonis, Drakk Stonehand and Hahrana Ironhide", () => {
	const lw = trainSteps().Leatherworking;
	assert.ok(lw?.[3], 'the leatherworking guide has its Expert train step');
	assert.deepEqual(lw[3], [3007, 4212, 11097, 11098]);
	for (const old of [5564, 5127, 3365, 4588]) assert.ok(!lw[3].includes(old), `Journeyman-only trainer ${old} is not a candidate`);
});

test('every crafting guide\'s Expert and Artisan train step lists exactly the trainers who teach that rank on Forever (#1608)', () => {
	const steps = trainSteps();
	for (const [skill, ranks] of Object.entries(FOREVER)) {
		for (const [rank, want] of Object.entries(ranks)) {
			assert.ok(steps[skill]?.[rank], `${skill} rank ${rank}: the guide has the train step`);
			assert.deepEqual(steps[skill][rank], want, `${skill} rank ${rank}`);
		}
	}
});
