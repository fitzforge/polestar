'use strict';
// Guards over every generated profession guide for the classes of bug the 0.4.4 profession audit found:
// a farming loop that asks a level far under its zone's creatures ("The Hinterlands lvl 2", "Ashenvale lvl
// 9999"); a buy, learn or train step pinned to an NPC that cannot fulfil it (a lure bought below the skill
// it asks, a recipe seller of the other faction, a trainer who does not teach the recipe); a band whose
// recipe greys before the band ends; materials counted at the expected crafts rather than for 9 players
// in 10; and one bracket's trainer visits sent to different trainers of a side (#4153 follow-up: Horde
// tailors between Josef Gregorian, Magar and Daryl Stack). They read the committed guides and data/forever.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA, needs } = require('./helpers/data');

const GUIDES = path.join(__dirname, '..', 'guides', 'forever', 'professions');
const CRAFTING = ['alchemy', 'blacksmithing', 'enchanting', 'engineering', 'leatherworking', 'tailoring'];
// Each crafting guide, and each paired guide with the crafting professions whose steps it holds.
const PROF_GUIDES = [
	...CRAFTING.map((n) => [n, [n]]),
	['herbalism-alchemy', ['alchemy']],
	['mining-blacksmithing', ['blacksmithing']],
	['mining-engineering', ['engineering']],
	['skinning-leatherworking', ['leatherworking']],
	['tailoring-enchanting', ['tailoring', 'enchanting']],
];
// The crafting guides still planned by plan.js; the ones with a curated route (routes/<profession>.json) keep
// tests/profession-route.test.js's rules.
const { loadRoute } = require('../tools/lib/professions/route');
const PLANNED = CRAFTING.filter((n) => !loadRoute(n));
const skip = needs('professions.json', 'npcs.json', 'items.json', 'zones.json', 'objects.json', 'quests.json');

const read = (name) => fs.readFileSync(path.join(GUIDES, `${name}.guide`), 'utf8');
const json = (name) => JSON.parse(fs.readFileSync(path.join(DATA, `${name}.json`), 'utf8'));

// The steps of a guide: { title, lines, section, sectionOf } (sectionOf: the section's line, its profession too).
function steps(text) {
	const out = [];
	let section = null;
	let sectionOf = null;
	for (const l of text.split('\n')) {
		const sec = /^section \S+(?: \S+)? (\d+)-(\d+)$/.exec(l) || /^section .* (\d+)-(\d+)$/.exec(l);
		if (sec) {
			section = [Number(sec[1]), Number(sec[2])];
			sectionOf = l.slice(8);
		}
		const m = /^step (.*)$/.exec(l);
		if (m) out.push({ title: m[1], lines: [], section, sectionOf });
		else if (out.length && /^ {2}\S/.test(l)) out[out.length - 1].lines.push(l.trim());
	}
	return out;
}

test('no farming loop asks a level under its zone\'s own (no "lvl 2" among level 15-55 creatures, no 9999 placeholder)', { skip }, () => {
	const { ZONES } = require('../tools/lib/professions/gathering/tables');
	const byName = new Map(Object.values(ZONES).map((z) => [z.name, z.min]));
	const bad = [];
	// Fishing + Cooking gates its bands on town and dock water by the band's rank instead (FishCook044's design).
	for (const file of fs.readdirSync(GUIDES).filter((f) => f.endsWith('.guide') && f !== 'fishing-cooking.guide')) {
		fs.readFileSync(path.join(GUIDES, file), 'utf8')
			.split('\n')
			.forEach((l, i) => {
				const m = /^\s*loop (.+?) lvl (\d+) /.exec(l);
				if (!m) return;
				const lvl = Number(m[2]);
				const min = byName.get(m[1]);
				if (lvl > 63 || (min != null && lvl < min)) bad.push(`${file}:${i + 1} ${m[1]} lvl ${lvl} (zone from ${min})`);
			});
	}
	assert.deepEqual(bad, []);
});

test('every NPC a profession step is pinned to can do what the step asks', { skip }, () => {
	const professions = json('professions');
	const npcs = json('npcs');
	const serves = (id, side) => {
		const f = (npcs[id] || {}).faction;
		return !f || f === 'AH' || f === side[0];
	};
	const bad = [];
	for (const [file, names] of PROF_GUIDES) for (const name of names) {
		const prof = Object.values(professions).find((p) => p.name.toLowerCase() === name);
		const recipe = new Map(prof.recipes.map((r) => [r.spell, r]));
		// A paired guide's other profession's recipes are checked against that profession.
		const other = new Set(Object.values(professions).filter((p) => names.includes(p.name.toLowerCase()) && p !== prof).flatMap((p) => p.recipes.map((r) => r.spell)));
		const teaches = (id, side, r) => prof.ranks.some((x) => x.minSkill <= r.learnedAt && r.learnedAt < x.max && ((x.trainers || {})[side] || []).includes(id));
		for (const s of steps(read(file))) {
			for (const l of s.lines) {
				const learn = /^learn (\d+) npc (\d+) only (Alliance|Horde)/.exec(l);
				if (learn && !other.has(Number(learn[1]))) {
					const r = recipe.get(Number(learn[1]));
					const id = Number(learn[2]);
					if (!serves(id, learn[3]) || !r || (r.source === 'trainer' && !teaches(id, learn[3], { ...r, learnedAt: Math.max(r.learnedAt, 1) }) && !prof.ranks.some((x) => ((x.trainers || {})[learn[3]] || []).includes(id))))
						bad.push(`${file}: ${s.title}: ${l}`);
				}
				const train = /^train (.+?) (Apprentice|Journeyman|Expert|Artisan) npc (\d+) only (Alliance|Horde)/.exec(l);
				if (train && train[1] === prof.name) {
					const rank = prof.ranks.find((x) => x.name === train[2]);
					if (!serves(Number(train[3]), train[4]) || !((rank.trainers || {})[train[4]] || []).includes(Number(train[3]))) bad.push(`${file}: ${s.title}: ${l}`);
				}
			}
			// A recipe's sellers by side: a seller of one faction is never named for the other.
			const sold = /Sold by (?:Alliance: (.*?); Horde: (.*?)|(.*?))\./.exec(s.lines.find((x) => x.startsWith('tip ')) || '');
			if (sold && sold[3]) {
				for (const n of Object.values(npcs)) {
					if (n.faction && n.faction !== 'AH' && n.roles && n.roles.includes('vendor') && sold[3].includes(`${n.name} (`) && s.lines.some((x) => /^buy \d+ nearest/.test(x))) {
						const item = Number(/^buy (\d+)/.exec(s.lines.find((x) => /^buy \d+ nearest/.test(x)))[1]);
						const m = prof.materials[item] || {};
						const sells = (side) => [...((m.vendors || {})[side] || []), ...((m.limitedVendors || {})[side] || [])].includes(n.id);
						if (sells('Alliance') || sells('Horde')) bad.push(`${file}: ${s.title}: ${n.name} (${n.faction}) named for both sides`);
					}
				}
			}
		}
	}
	// A lure is bought only for a band whose first skill can use it (Bright Baubles ask Fishing 100).
	const { context } = require('../tools/lib/professions/gathering/common');
	const fishing = require('../tools/lib/professions/gathering/fishing');
	const ctx = context(DATA);
	for (const file of ['fishing-cooking', 'fishing']) {
		for (const s of steps(read(file))) {
			const band = /^Lures for .*?(\d+)-(\d+)/.exec(s.title);
			if (!band) continue;
			for (const l of s.lines) {
				const buy = /^buy (\d+) x(\d+)/.exec(l);
				if (buy && fishing.lureSkill(ctx, Number(buy[1])) > Number(band[1])) bad.push(`${file}: ${s.title}: ${l} asks Fishing ${fishing.lureSkill(ctx, Number(buy[1]))}`);
			}
		}
	}
	assert.deepEqual(bad, []);
});

test('no crafting band runs past the skill where its recipe turns grey', { skip }, () => {
	const professions = json('professions');
	const bad = [];
	for (const [file, names] of PROF_GUIDES) for (const name of names) {
		const prof = Object.values(professions).find((p) => p.name.toLowerCase() === name);
		const recipe = new Map(prof.recipes.map((r) => [r.spell, r]));
		// A route may give a recipe's colour where players' recordings show the client table is wrong.
		const colours = (loadRoute(name) || {}).colours || {};
		for (const s of steps(read(file))) {
			for (const l of s.lines) {
				const m = /^craft (\d+)(?: x\d+)? until (\d+)/.exec(l);
				if (!m) continue;
				const r = recipe.get(Number(m[1]));
				if (names.length > 1 && !r) continue; // the pair's other profession
				const grey = r && ((colours[r.spell] || {}).grey || r.grey);
				if (!r || !(grey > Number(m[2]) - 1)) bad.push(`${file}: ${s.title}: ${l} (grey at ${grey})`);
			}
		}
	}
	assert.deepEqual(bad, []);
});

test('gathered materials are counted for 9 players in 10, vendor goods at the expected crafts', { skip }, () => {
	const { planProfession, chance } = require('../tools/lib/professions/plan');
	const { SPECS } = require('../tools/lib/professions/specs');
	const data = { professions: json('professions'), npcs: json('npcs'), objects: json('objects'), zones: json('zones'), quests: json('quests'), items: json('items') };
	// A seeded Monte Carlo of the Classic chance per point: the 90th percentile of the crafts a segment takes.
	let seed = 4404;
	const rnd = () => {
		seed = (seed * 1103515245 + 12345) % 2147483648;
		return seed / 2147483648;
	};
	const mc90 = (r, from, to) => {
		const runs = [];
		for (let i = 0; i < 2000; i++) {
			let n = 0;
			for (let k = from; k < to; ) {
				n++;
				if (rnd() < chance(r, k)) k += r.skillUps || 1;
			}
			runs.push(n);
		}
		runs.sort((a, b) => a - b);
		return runs[Math.floor(runs.length * 0.9)];
	};
	const bad = [];
	let checked = 0;
	for (const [name, spec] of Object.entries(SPECS)) {
		const prof = Object.values(data.professions).find((p) => p.name === name);
		const plan = planProfession(prof, data, { exclude: spec.exclude || {}, noLevel: spec.noLevel || {}, questRecipes: spec.questRecipes || {}, auction: spec.auction || {}, notBefore: spec.notBefore || {}, levelTo: spec.levelTo || {}, use: spec.use || [], to: spec.to || 300 });
		for (const seg of plan.segments) {
			// Segments whose intermediates give points move faster than one draw a point: left to the planner's own test.
			if (seg.make.some((m) => m.recipe.grey > seg.from)) continue;
			const p90 = mc90(seg.recipe, seg.from, seg.to);
			checked++;
			if (seg.count90 < p90 - 1) bad.push(`${name} ${seg.from}-${seg.to} ${seg.recipe.name}: count90 ${seg.count90} < 9-in-10 ${p90}`);
			for (const g of seg.recipe.reagents) {
				const n = seg.need.find((x) => x.item === g.item);
				if (!n || seg.fromStock) continue;
				const vendor = ['Alliance', 'Horde'].every((s) => n.src[s].kind === 'vendor');
				const want = g.count * (vendor ? seg.count : seg.count90);
				if (n.count < want) bad.push(`${name} ${seg.from}-${seg.to} ${seg.recipe.name}: ${n.count} of item ${g.item}, want ${want}`);
			}
		}
	}
	assert.ok(checked > 40, `${checked} segments checked`);
	assert.deepEqual(bad, []);
	// The audit's cases: Heavy Mithril Boots 30 -> 40 crafts at 9 in 10, Runecloth Shoulders 62 -> 73 or more.
	const bs = Object.values(data.professions).find((p) => p.name === 'Blacksmithing');
	const boots = bs.recipes.find((r) => r.name === 'Heavy Mithril Boots');
	assert.ok(mc90(boots, 235, 247) >= 38);
});

test('a bracket of a rank few trainers teach goes to one trainer per side; Tailoring learns Bolt of Silk Cloth on the visit before it needs it', { skip }, () => {
	for (const [name] of PROF_GUIDES) {
		const bySection = new Map();
		for (const s of steps(read(name))) {
			if (!s.section) continue;
			for (const l of s.lines) {
				const m = /^(?:learn \d+|train .+?) npc (\d+) only (Alliance|Horde)/.exec(l);
				// Pins of a recipe only a later rank teaches (taughtBy) and the optional rank offered there are
				// the next rank's trip, counted apart.
				if (!m || /train .* optional/.test(l)) continue;
				const key = `${s.sectionOf} ${m[2]}`;
				if (!bySection.has(key)) bySection.set(key, new Set());
				bySection.get(key).add(m[1]);
			}
		}
		for (const [key, ids] of bySection) assert.ok(ids.size <= 2, `${name} ${key}: ${[...ids].join(', ')}`);
	}
	// Tailoring's route: Bolt of Mageweave from the Expert trainers (Georgio Bolero, Josef Gregorian), and Bolt
	// of Silk Cloth learned before the silk bolts carry 100-120.
	const t = steps(read('tailoring'));
	assert.ok(t.some((s) => s.lines.includes('learn 3865 npc 1346,4576')), 'Bolt of Mageweave at the Expert trainers');
	const silk = t.findIndex((s) => s.lines.some((l) => /^learn 3839 /.test(l)));
	const bolts = t.findIndex((s) => s.lines.some((l) => /^craft 3839 /.test(l)));
	assert.ok(silk >= 0 && silk < bolts, 'Bolt of Silk Cloth learned before the silk bolts carry 100-120');
});

test('a fork: each way\'s steps carry their when, and each way reaches 300 or says what is left', { skip }, () => {
	const all = steps(read('tailoring'));
	const way = (...w) => all.filter((s) => w.every((x) => s.lines.includes(x)));
	const ends = (list, re) => list.some((s) => s.lines.some((l) => re.test(l)));
	assert.ok(ends(way('when knows 18449'), /^craft 18449 until 300$/), 'Runecloth Shoulders reach 300');
	assert.ok(ends(way('when !knows 18449', 'when knows 18450'), /^craft 18450 until 300$/), 'Wizardweave Turban reaches 300');
	const none = way('when !knows 18449', 'when !knows 18450');
	const last = none[none.length - 1];
	assert.ok(last && last.lines.some((l) => /^tip .*Auction House/.test(l)), 'no pattern: the last step says what is left');
});

// Fitz, 0.4.4 try 4: "624 Wool Cloth to get from 75-150 is absurd". The bolts a later stretch needs anyway are
// made while they still give points: Bolt of Silk Cloth carries 100-120 and the bolts go into the hoods (120-125)
// and packs (routes/tailoring.json).
test('Tailoring 75-150 levels on the bolts the later stretches use: under 300 Wool Cloth, no Stylish Red Shirt grind', { skip }, () => {
	const all = steps(read('tailoring'));
	const n = all.filter((s) => /^Get \d+ Wool Cloth$/.test(s.title)).reduce((a, s) => a + Number(/^collect 2592 x(\d+)/.exec(s.lines.find((l) => /^collect 2592 /.test(l)))[1]), 0);
	assert.ok(n <= 300, `75-150 asks ${n} Wool Cloth`);
	assert.ok(all.some((s) => s.lines.includes('craft 3839 until 120')), 'Bolt of Silk Cloth to 120');
	assert.ok(all.some((s) => s.lines.includes('craft 8760 until 125')), 'Azure Silk Hood to 125');
	assert.ok(!all.some((s) => s.lines.some((l) => /^craft 3866 until/.test(l))), 'no Stylish Red Shirt stretch');
});

// Fitz, 0.4.4: "2,168 Thorium Bars for 250-300 and 848 Mithril Bars doesn't sound right". The Thorium went into
// Magnus Frostwake's 40-bar battleaxe because the quest data kept Classic's Blacksmithing 265 for Derotain
// Mudsipper's Imperial Plate quests; a recorded blacksmith of 243 was offered them (forever-db correction: 240).
// The route: his belt plans at 240 and bracers plans on the same visit (Heavy Mithril way), the bracers to 270,
// and from 270 one of three ways (the Radiant plans, the Thorium Leggings plans, or his boots and leggings).
test('Blacksmithing 225-300: Derotain\'s belt and bracers from 240 on one visit, his plans for the third way, no Magnus Frostwake', { skip }, () => {
	const all = steps(read('blacksmithing'));
	const at = (q) => all.findIndex((s) => s.lines.includes(`turnin ${q} direct`));
	assert.ok(at(7653) > 0 && at(7655) === at(7653) + 1, 'the bracers plans come on the belt plans\' visit');
	assert.ok(all.some((s) => s.lines.includes('craft 16647 until 245')) && all.some((s) => s.lines.includes('craft 16649 until 270')), 'belt to 245, bracers to 270');
	const thorium = (...w) => all.filter((s) => s.section && s.section[0] >= 270 && /^Get \d+ Thorium Bar$/.test(s.title) && w.every((x) => s.lines.includes(x))).reduce((a, s) => a + Number(/x(\d+)/.exec(s.lines.find((l) => l.startsWith('collect 12359 ')))[1]), 0);
	assert.equal(thorium('when knows 16656', 'when has 12713'), 508, 'the Radiant way: 508 Thorium Bars');
	assert.equal(thorium('when knows 16656', 'when !has 12713'), 808, 'Radiant Boots without the leggings plans: the boots, then Derotain\'s leggings and their quest\'s 60');
	assert.equal(thorium('when !knows 16662'), 1220, 'Derotain\'s boots and leggings, their quests\' 100 included');
	assert.ok(!all.some((s) => s.lines.some((l) => /^(buy (12819|12823)|learn (16969|16971))\b/.test(l))), 'no Magnus Frostwake plans');
	assert.equal(json('quests')[7653].skillLevel, 240, 'the data build applies the Derotain correction');
});

// Every Get it step's tip starts with why: the count, the band and the crafts it goes into ("57 Wool Cloth for
// Tailoring 75-150: 40 Woolen Capes."), the count the same as its collect line's.
test('every Get it step leads with its count and what it is for', { skip }, () => {
	for (const name of PLANNED) {
		for (const s of steps(read(name)).filter((x) => /^Get /.test(x.title))) {
			const collect = s.lines.find((l) => /^collect \d+ x\d+/.test(l));
			if (!collect) continue;
			const tip = s.lines.find((l) => /^tip /.test(l));
			const m = /^tip (\d+) (.+?) for \S+(?: \S+)? (\d+)-(\d+): ([^.]+)\./.exec(tip || '');
			assert.ok(m, `${name} ${s.title}: ${tip}`);
			assert.equal(m[1], /x(\d+)/.exec(collect)[1], `${name} ${s.title}: the tip's count is the collect's`);
			assert.ok(s.title.startsWith(`Get ${m[2]}`), `${name} ${s.title}: names its material`);
		}
	}
});
