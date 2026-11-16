'use strict';
// The `train` and `learn` steps of the crafting profession guides, as the
// committed Polestar_Guides ships them, point only at the trainers who teach
// that rank on Forever, at the skill the step is taken at. Expected lists: the
// Forever TrinityCore world DB (data/local/forever-tdb/world.sqlite,
// 2026-11-10): the creatures whose trainer list (creature_trainer ->
// trainer_spell) has the rank's spell (Expert Leatherworker 3811, Artisan
// 10662, ...), less those whose "Train me." option asks for more skill than
// the rank does (conditions on the creature_trainer menu option). Reads
// Guides.lua only, so it runs without data/forever.
//
// mutaka's report (#1608): the Expert Leatherworking arrow picked from the
// profession's whole trainer list (Simon Tanner, Fimble Finespindle; Horde
// Karolek, Arthur Moore), who teach only up to Journeyman, because
// professions.json was built without the sniffed trainer lists.
//
// Oli's report (#1708): Journeyman Alchemy pointed at Doctor Herbert Halsey,
// who only trains from Alchemy 125 ("You don't yet have the skill to study
// with me"); Hotline's (#1498): Linen Belt at Josephine Lister, who trains
// Tailoring from 200.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const GUIDES = path.join(__dirname, '..', 'addon', 'Polestar_Guides', 'Guides.lua');

// skill -> rank -> npc ids. Left out on purpose: Annora (Expert Enchanting),
// inside Uldaman with no spawn in the reference data, and Meilosh (Expert and
// Artisan Tailoring), Timbermaw Hold's trainer, who needs Timbermaw standing.
// The Artisan trainers who also teach Expert (Rogvar, Kylanna Windwhisper,
// Brikk Keencraft, Buzzek Bracketswing, Drakk Stonehand, Hahrana Ironhide,
// Daryl Stack, Timothy Worthington) train from 200: Expert is not theirs.
const FOREVER = {
	Alchemy: { 3: [4160, 4611], 4: [1386, 7948] },
	Blacksmithing: { 3: [3355, 4258], 4: [2836] },
	Enchanting: { 3: [11072, 11074] },
	Engineering: { 3: [5174, 11017], 4: [8736] },
	Leatherworking: { 3: [3007, 4212], 4: [11097, 11098] },
	Tailoring: { 3: [1346, 4576], 4: [2399, 11052] },
};

// The skill each crafting trainer's "Train me." option asks for (the same DB),
// for the trainers whose ranks' lists name them; a trainer not listed asks
// for none. A rank's skill: 0, 50, 125, 200.
const TRAINS_FROM = {
	Alchemy: { 1386: 200, 2391: 50, 2837: 50, 3009: 50, 3347: 50, 3964: 50, 4160: 125, 4609: 50, 4611: 125, 4900: 50, 5177: 50, 5499: 50, 7948: 200, 11042: 50 },
	Blacksmithing: { 1383: 50, 2836: 200, 2998: 50, 3136: 50, 3355: 125, 3478: 50, 4258: 125, 4596: 50, 5511: 50, 10276: 50 },
	Enchanting: { 1317: 50, 3011: 50, 3345: 50, 4213: 50, 4616: 50, 5157: 50, 7949: 50, 11072: 125, 11074: 125 },
	Engineering: { 1676: 50, 3412: 50, 5174: 125, 5518: 50, 8736: 200, 11017: 125, 11029: 50, 11031: 50 },
	Leatherworking: { 1385: 50, 3007: 125, 3365: 50, 3703: 50, 3967: 50, 4212: 125, 4588: 50, 5127: 50, 5564: 50, 11081: 50, 11084: 50, 11097: 200, 11098: 200 },
	Tailoring: { 1346: 125, 2399: 200, 2627: 50, 3004: 50, 3363: 50, 3704: 50, 4159: 50, 4576: 125, 4578: 200, 5153: 50, 5567: 50, 11049: 50, 11052: 200 },
};
const RANK_SKILL = { 1: 0, 2: 50, 3: 125, 4: 200 };

// Every `train` goal ({ skill, rank, npcs }) and `learn` goal ({ skill line,
// spell, npcs }) of the forever/professions guides, npcs sorted.
function goals() {
	const lua = fs.readFileSync(GUIDES, 'utf8');
	const train = [];
	const learn = [];
	const parts = lua.split(/^(-- Source: .*)$/m);
	for (let i = 1; i < parts.length; i += 2) {
		if (!parts[i].includes('forever/professions/')) continue;
		const block = parts[i + 1];
		const recs = block.match(/local candidateRecords = \{\n([\s\S]*?)\n\t\t\}\n/);
		const records = recs ? [...recs[1].matchAll(/^\t\t\t\{ npc = (\d+)/gm)].map((m) => Number(m[1])) : [];
		const ids = (text) => [...text.matchAll(/candidateRecords\[(\d+)\]|\{ npc = (\d+)/g)].map((m) => (m[1] ? records[Number(m[1]) - 1] : Number(m[2])));
		const lists = block.match(/local candidateLists = \{\n([\s\S]*?)\n\t\t\}\n/);
		const shared = lists ? lists[1].split('\n').map(ids) : [];
		const npcsOf = (cands, what) => {
			const ref = cands.match(/^candidateLists\[(\d+)\]/);
			const npcs = ref ? shared[Number(ref[1]) - 1] : ids(cands);
			assert.ok(npcs && npcs.every(Number.isInteger), `${what}: candidates parsed`);
			return [...new Set(npcs)].sort((a, b) => a - b);
		};
		for (const m of block.matchAll(/t = "train", skill = "([^"]+)", skillLine = \d+, rank = (\d), rankMax = \d+, candidates = (.*)$/gm)) {
			train.push({ skill: m[1], rank: Number(m[2]), npcs: npcsOf(m[3], `${m[1]} rank ${m[2]}`) });
		}
		for (const m of block.matchAll(/t = "learn", spell = (\d+), spellName = "[^"]*", skillLine = (\d+), candidates = (.*)$/gm)) {
			learn.push({ spell: Number(m[1]), line: Number(m[2]), npcs: npcsOf(m[3], `learn ${m[1]}`) });
		}
	}
	return { train, learn };
}

function trainSteps() {
	const out = {};
	for (const g of goals().train) (out[g.skill] ??= {})[g.rank] = g.npcs;
	return out;
}

test("mutaka's report (#1608): Expert Leatherworking points only at Una and Telonis", () => {
	const lw = trainSteps().Leatherworking;
	assert.ok(lw?.[3], 'the leatherworking guide has its Expert train step');
	assert.deepEqual(lw[3], [3007, 4212]);
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

test("Oli's report (#1708): no train step points at a trainer who doesn't train at the rank's skill yet", () => {
	const all = goals().train.filter((g) => TRAINS_FROM[g.skill]);
	assert.ok(all.some((g) => g.skill === 'Alchemy' && g.rank === 2), 'the alchemy guide has its Journeyman train step');
	for (const g of all) {
		const early = g.npcs.filter((npc) => (TRAINS_FROM[g.skill][npc] || 0) > RANK_SKILL[g.rank]);
		assert.deepEqual(early, [], `${g.skill} rank ${g.rank}: trainers who train only from a higher skill`);
	}
	const journeyman = all.find((g) => g.skill === 'Alchemy' && g.rank === 2).npcs;
	assert.ok(!journeyman.includes(4611), 'Journeyman Alchemy: not Doctor Herbert Halsey');
});

test("Hotline's report (#1498) and #1708's learns: Linen Belt is not Josephine Lister's, Minor Mana Potion not Doctor Herbert Halsey's", () => {
	const { learn } = goals();
	const of = (spell) => learn.filter((g) => g.spell === spell);
	assert.ok(of(8776).length, 'the tailoring guide learns Linen Belt');
	for (const g of of(8776)) assert.ok(!g.npcs.includes(4578), `Linen Belt: ${g.npcs}`);
	assert.ok(of(2331).length, 'the alchemy guide learns Minor Mana Potion');
	for (const g of of(2331)) assert.ok(!g.npcs.includes(4611), `Minor Mana Potion: ${g.npcs}`);
});

// Pyzx's report (#1956): at Blacksmithing 205 the guide sent him to Saru Steelfury for Heavy Mithril Breastplate,
// and her trainer window had nothing to teach. Classic's trainer lists (the world DB above, VB 0) put the recipes
// that asked 230-250 there (above Expert's 225) on the Artisan trainers only; Forever moved them 25 points down,
// not off the Artisan list. The guide sources (the generators' output; Guides.lua is compiled from them at release)
// pin each such learn to the Artisan trainers.
test("Pyzx's report (#1956): recipes only the Artisan trainers teach are learned from them, not the Expert trainers", () => {
	const dir = path.join(__dirname, '..', 'guides', 'forever', 'professions');
	const learns = (file, spell) => fs.readFileSync(path.join(dir, file), 'utf8').split('\n').filter((l) => new RegExp(`^\\s*learn ${spell}\\b`).test(l));
	for (const [file, spell, npcs, what] of [
		['blacksmithing.guide', 9959, [2836], 'Heavy Mithril Breastplate: Brikk Keencraft'],
		['leatherworking.guide', 10548, [11097, 11098], 'Nightscape Pants: Drakk Stonehand, Hahrana Ironhide'],
		['tailoring.guide', 12072, [11052, 2399], 'Black Mageweave Headband: Timothy Worthington, Daryl Stack'],
	]) {
		const lines = learns(file, spell);
		assert.ok(lines.length, `${what}: learned in ${file}`);
		for (const l of lines) {
			const m = l.match(/\bnpc (\d+)/);
			assert.ok(m && npcs.includes(Number(m[1])), `${what}: ${l.trim()}`);
		}
	}
});
