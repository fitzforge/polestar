'use strict';
// Profession, reputation, exploration and achievement verbs (skill, learn,
// craft, rep, explore, achieve): parse, resolve from professions.json /
// factions.json, validation, Lua emission, and the fallbacks when those data
// files are absent. Also the any-of prerequisite rule.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');
const { compile, guideText, lineOf, plain, fixtureData, writeTestPack, DATA_DIR } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');
const { emitGuides } = require('../tools/lib/dsl/emit');

// Fixture data without professions.json and factions.json (as while they are being built).
function dataWithout(...names) {
	const dir = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) {
		if (!names.includes(f)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(dir, f));
	}
	return loadData(dir);
}

function goals(lines, data) {
	const r = compile(guideText(lines), data);
	return { r, goals: r.guides.length ? plain(r.guides[0].steps.flatMap((s) => s.goals)) : [] };
}

function only(list, re) {
	return list.filter((m) => re.test(m));
}

test('skill: profession names (multi-word, quoted, any case) resolve to skill lines', () => {
	const { r, goals: g } = goals(['step S', '  skill First Aid 75', '  skill "first aid" 150', '  skill mining 50', '  skill "Jewelcrafting" 1']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g.slice(0, 3), [
		{ t: 'skill', skill: 'First Aid', skillLine: 129, level: 75 },
		{ t: 'skill', skill: 'First Aid', skillLine: 129, level: 150 },
		// Classic professions resolve from built-in skill lines even when professions.json lacks them.
		{ t: 'skill', skill: 'Mining', skillLine: 186, level: 50 },
	]);
	assert.deepEqual(g[3], { t: 'skill', skill: 'Jewelcrafting', level: 1 });
	assert.match(r.warnings.join('\n'), /test\.guide:11: profession "Jewelcrafting" is not in data; using the explicit name/);
});

test('skill: unknown unquoted professions and malformed ranks are errors at their line', () => {
	const src = guideText(['step S', '  skill Basketry 10', '  skill Mining', '  skill Mining 7x', '  skill 75']);
	const r = compile(src);
	assert.deepEqual(r.errors, [
		`test.guide:${lineOf(src, '  skill Basketry 10')}: unknown profession "Basketry"; quote the name to use it anyway: \`skill "Basketry" 10\``,
		`test.guide:${lineOf(src, '  skill Mining')}: \`skill\` needs a profession and a rank: skill <Profession> <N>`,
		`test.guide:${lineOf(src, '  skill Mining 7x')}: \`skill\` needs a profession and a rank: skill <Profession> <N>`,
		`test.guide:${lineOf(src, '  skill 75')}: \`skill\` needs a profession and a rank: skill <Profession> <N>`,
	]);
});

test('learn: names, skill line and recipe item from data; trainer-taught recipes get every trainer as candidates', () => {
	const { r, goals: g } = goals(['step S', '  learn 3276', '  learn 7934', '  learn 3275 "Bandage" npc 5150']);
	assert.deepEqual(only(r.errors, /./), []);
	// Trainer-taught, no npc: the guide faction's trainers, chosen at runtime (current zone first).
	assert.deepEqual(g[0], {
		t: 'learn',
		spell: 3276,
		spellName: 'Heavy Linen Bandage',
		skillLine: 129,
		candidates: [
			{ npc: 2329, npcName: 'Michelle Belle', map: 1429, x: 43.39, y: 65.55, f: 'e', faction: 'A' },
			// Ironforge has no Era bounds in the fixture: the point is emitted live-frame.
			{ npc: 5150, npcName: 'Nissa Firestone', map: 1455, x: 54.8, y: 58.6, faction: 'A' },
		],
	});
	// A recipe learned from an item names the item instead of a trainer.
	assert.deepEqual(g[1], { t: 'learn', spell: 7934, spellName: 'Anti-Venom', item: 6454, itemName: 'Manual: Strong Anti-Venom', skillLine: 129 });
	// An explicit trainer stays fixed.
	assert.deepEqual(g[2], { t: 'learn', spell: 3275, spellName: 'Bandage', npc: 5150, npcName: 'Nissa Firestone', skillLine: 129, map: 1455, x: 54.8, y: 58.6 });
});

test('learn in a both-faction guide is not pinned to the trainer near an earlier step', () => {
	// The earlier Durotar step used to pin the Durotar (Horde) trainer for every race.
	const src = guideText(['guide t/b', 'title Both', 'levels 1-60', 'zone Durotar', '', 'step One', '  goto 54,41', 'step Two', '  zone Elwynn Forest', '  goto 43,65', 'step Three', '  learn 3276']);
	const r = compile(src);
	assert.deepEqual(r.errors, []);
	const goal = plain(r.guides[0].steps[2].goals[0]);
	assert.equal(goal.npc, undefined);
	assert.equal(goal.map, undefined);
	assert.deepEqual(goal.candidates.map((c) => [c.npc, c.faction]), [[2329, 'A'], [3373, 'H'], [5150, 'A']]);
	// Horde-only guides keep only Horde trainers.
	const horde = compile(guideText(['guide t/h', 'title H', 'faction Horde', 'levels 1-5', 'zone Durotar', '', 'step S', '  learn 3276']));
	assert.deepEqual(plain(horde.guides[0].steps[0].goals[0].candidates).map((c) => c.npc), [3373]);
});

test('learn … nearest: recipe-item learns go to the nearest vendor of the recipe; no source is an error', () => {
	const { r, goals: g } = goals(['step S', '  learn 7934 nearest', '  learn 3276 nearest', '  learn 99997 "Skyborne Weaving" nearest', '  learn 3276 nearest npc 2329']);
	assert.deepEqual(g[0].candidates.map((c) => c.npc), [2805]);
	assert.equal(g[0].item, 6454);
	assert.deepEqual(g[1].candidates.map((c) => c.npc), [2329, 5150]);
	assert.deepEqual(r.errors, [
		'test.guide:10: `learn 99997 nearest`: no trainer or recipe vendor for this spell in data',
		'test.guide:11: `nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC',
	]);
});

test('craft: created item, reagents, x<N> as crafts, and until <N>', () => {
	const { r, goals: g } = goals(['step S', '  learn 3276', '  learn 7934', '  craft 3276 x5', '  craft 7934 x4', '  craft 3276 until 80', '  craft 3276 until 120']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g[2], {
		t: 'craft',
		spell: 3276,
		spellName: 'Heavy Linen Bandage',
		item: 2581,
		itemName: 'Heavy Linen Bandage',
		count: 5,
		skillLine: 129,
		reagents: [{ item: 2589, itemName: 'Linen Cloth', count: 2 }],
	});
	// Anti-Venom makes 3 per craft: 4 crafts -> 12 items.
	assert.equal(g[3].count, 12);
	assert.deepEqual([g[4].untilSkill, g[4].count, g[4].skillLine], [80, undefined, 129]);
	assert.deepEqual(only(r.warnings, /grey/), [`test.guide:13: Heavy Linen Bandage turns grey at 100; crafting it gives no skill up to 120`]);
});

test('craft: x<N> and until together, and until on non-craft verbs, are errors', () => {
	const src = guideText(['step S', '  level 2', '  craft 3275 x2 until 30', '  learn 3275 until 30', '  kill 6 criteria 1']);
	assert.deepEqual(compile(src).errors, [
		`test.guide:${lineOf(src, '  craft 3275 x2 until 30')}: use either \`xN\` or \`until <N>\`, not both`,
		`test.guide:${lineOf(src, '  learn 3275 until 30')}: \`until <N>\` does not apply to \`learn\``,
		`test.guide:${lineOf(src, '  kill 6 criteria 1')}: \`criteria <n>\` does not apply to \`kill\``,
	]);
});

test('learn/craft: unknown spells need a quoted name; with one they warn', () => {
	const src = guideText(['step S', '  learn 99999', '  craft 99998', '  learn 99997 "Skyborne Weaving"', '  craft 99997 "Skyborne Weaving" x2 until 10']);
	const r = compile(src);
	assert.deepEqual(r.errors, [
		`test.guide:${lineOf(src, '  learn 99999')}: spell 99999 is not in data; give its name: \`learn 99999 "Name"\``,
		`test.guide:${lineOf(src, '  craft 99998')}: spell 99998 is not in data; give its name: \`craft 99998 "Name"\``,
		`test.guide:${lineOf(src, '  craft 99997 "Skyborne Weaving" x2 until 10')}: use either \`xN\` or \`until <N>\`, not both`,
	]);
	assert.match(r.warnings.join('\n'), new RegExp(`test\\.guide:${lineOf(src, '  learn 99997 "Skyborne Weaving"')}: spell 99997 is not in data; using the explicit name`));
});

test('craft before its learn in the chain warns; an earlier learn (also in a chained guide) or a free starter recipe does not', () => {
	const src = guideText(['step S', '  craft 3276 x1', '  learn 3276', '  craft 3276 x1', '  craft 3275 x1']);
	assert.deepEqual(only(compile(src).warnings, /before any/), [`test.guide:${lineOf(src, '  craft 3276 x1')}: \`craft\` 3276 (Heavy Linen Bandage) before any \`learn 3276\` earlier in this guide or a guide chaining into it`]);
	const head = (id, next) => [`guide ${id}`, `title ${id}`, 'levels 1-10', 'zone Elwynn Forest', ...(next ? [`next ${next}`] : []), ''];
	const chained = compile({
		'1.guide': `${[...head('t/one', 't/two'), 'step S', '  learn 7934'].join('\n')}\n`,
		'2.guide': `${[...head('t/two'), 'step S', '  craft 7934 x1'].join('\n')}\n`,
	});
	assert.deepEqual(only(chained.warnings, /before any/), []);
});

test('rep: faction by name or id, standing by name or number', () => {
	const { r, goals: g } = goals(['step S', '  rep Stormwind Honored', '  rep "darnassus" friendly', '  rep 76 8', '  rep 1234 "Skyborne Accord" Revered', '  rep Twin Name Neutral']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g.slice(0, 4), [
		{ t: 'rep', faction: 72, factionName: 'Stormwind', standing: 6 },
		{ t: 'rep', faction: 69, factionName: 'Darnassus', standing: 5 },
		{ t: 'rep', faction: 76, factionName: 'Orgrimmar', standing: 8 },
		{ t: 'rep', faction: 1234, factionName: 'Skyborne Accord', standing: 7 },
	]);
	assert.deepEqual([g[4].faction, g[4].standing], [9001, 4]);
	assert.match(r.warnings.join('\n'), /test\.guide:11: faction 1234 is not in data; using the explicit name/);
	assert.match(r.warnings.join('\n'), /test\.guide:12: faction "Twin Name" matches ids 9001, 9002; using 9001/);
});

test('rep: unknown factions, out-of-range and unknown standings are errors at their line', () => {
	const src = guideText(['step S', '  rep Gadgetzan Friendly', '  rep Stormwind 9', '  rep Stormwind 0', '  rep 72 Adored', '  rep 4321 Friendly', '  rep Stormwind']);
	assert.deepEqual(compile(src).errors, [
		`test.guide:${lineOf(src, '  rep Gadgetzan Friendly')}: unknown faction "Gadgetzan"; give its id with the name: \`rep <factionId> "Gadgetzan" <Standing>\``,
		`test.guide:${lineOf(src, '  rep Stormwind 9')}: standing 9 is out of range (1-8, or Hated..Exalted)`,
		`test.guide:${lineOf(src, '  rep Stormwind 0')}: standing 0 is out of range (1-8, or Hated..Exalted)`,
		`test.guide:${lineOf(src, '  rep 72 Adored')}: unknown standing "Adored" (Hated, Hostile, Unfriendly, Neutral, Friendly, Honored, Revered, Exalted, or 1-8)`,
		`test.guide:${lineOf(src, '  rep 4321 Friendly')}: faction 4321 is not in data; give its name: \`rep 4321 "Name" <Standing>\``,
		`test.guide:${lineOf(src, '  rep Stormwind')}: \`rep\` needs a faction and a standing: rep <Faction> <Standing> or rep <factionId> <Standing>`,
	]);
});

test('explore: coordinates in the current zone or a map, with the area name', () => {
	const { r, goals: g } = goals(['step S', '  explore 42.1,65.9 "Goldshire"', '  explore 50,50 map 1453 r 30', '  explore 101,5']);
	assert.deepEqual(r.errors, ['test.guide:10: coordinates 101,5 are outside 0-100']);
	assert.deepEqual(g[0], { t: 'explore', text: 'Goldshire', map: 1429, x: 42.1, y: 65.9, f: 'e' });
	assert.deepEqual(g[1], { t: 'explore', map: 1453, x: 50, y: 50, f: 'e', r: 30 });
	const bad = guideText(['step S', '  level 2', '  explore "Goldshire"', '  explore 1,2 @3,4']);
	assert.deepEqual(compile(bad).errors, [
		`test.guide:${lineOf(bad, '  explore "Goldshire"')}: \`explore\` needs coordinates x,y`,
		`test.guide:${lineOf(bad, '  explore 1,2 @3,4')}: \`@x,y\` does not apply to \`explore\``,
	]);
});

test('achieve: id, required name and optional criterion', () => {
	const { r, goals: g } = goals(['step S', '  achieve 6 "Level 10"', '  achieve 7 "Legacy: Northshire" criteria 3 optional']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g, [
		{ t: 'achieve', achievement: 6, achievementName: 'Level 10' },
		{ t: 'achieve', achievement: 7, achievementName: 'Legacy: Northshire', criteria: 3, optional: true },
	]);
	const src = guideText(['step S', '  achieve 6', '  achieve x6 "A"', '  achieve 6 "A" criteria 0']);
	assert.deepEqual(compile(src).errors, [
		`test.guide:${lineOf(src, '  achieve 6')}: achievement 6 has no reference data; give its name: \`achieve 6 "Name"\``,
		`test.guide:${lineOf(src, '  achieve x6 "A"')}: malformed achievement id "x6"`,
		`test.guide:${lineOf(src, '  achieve 6 "A" criteria 0')}: malformed criterion index "0"`,
	]);
});

test('without professions.json and factions.json: built-in professions still resolve, quoted names warn, nothing crashes', () => {
	const data = dataWithout('professions.json', 'factions.json');
	assert.deepEqual(data.missing, ['professions.json', 'factions.json', 'trainers.json', 'travel.json', 'spawnz.json']);
	const src = guideText([
		'step S',
		'  skill Tailoring 75',
		'  learn 3275 "Linen Bandage"',
		'  craft 3275 "Linen Bandage" x5',
		'  craft 3275 "Linen Bandage" until 40',
		'  rep 72 "Stormwind" Friendly',
		'  learn 3276',
		'  rep Stormwind Friendly',
	]);
	const r = compile(src, data);
	assert.deepEqual(r.errors, [
		`test.guide:${lineOf(src, '  learn 3276')}: spell 3276 is not in data (professions.json missing); give its name: \`learn 3276 "Name"\``,
		`test.guide:${lineOf(src, '  rep Stormwind Friendly')}: unknown faction "Stormwind" (factions.json missing); give its id with the name: \`rep <factionId> "Stormwind" <Standing>\``,
	]);
	const g = plain(r.guides[0].steps[0].goals);
	assert.deepEqual(g.slice(0, 5), [
		{ t: 'skill', skill: 'Tailoring', skillLine: 197, level: 75 },
		{ t: 'learn', spell: 3275, spellName: 'Linen Bandage' },
		{ t: 'craft', spell: 3275, spellName: 'Linen Bandage', count: 5 },
		{ t: 'craft', spell: 3275, spellName: 'Linen Bandage', untilSkill: 40 },
		{ t: 'rep', faction: 72, factionName: 'Stormwind', standing: 5 },
	]);
	assert.match(r.warnings.join('\n'), /spell 3275 is not in data \(professions\.json missing\); using the explicit name/);
	assert.match(r.warnings.join('\n'), /`until` needs the recipe's profession, but spell 3275 is not in professions\.json/);
	assert.match(r.warnings.join('\n'), /faction 72 is not in data \(factions\.json missing\); using the explicit name/);
	// A corrupt optional file counts as missing instead of failing the build.
	const dir = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(dir, f));
	fs.writeFileSync(path.join(dir, 'professions.json'), '{ "129": { "na');
	assert.ok(loadData(dir).missing.includes('professions.json'));
});

test('documented categories are accepted case-insensitively; others warn and pass through', () => {
	// A Class guide says what its goal gives and why (a warning without them).
	const base = (cat) =>
		guideText(['guide t/c', 'title C', 'levels 1-5', 'zone Elwynn Forest', `category ${cat}`, ...(cat === 'class' ? ['reward text Defensive Stance', 'why A stance.'] : []), '', 'step S', '  level 2']);
	for (const c of ['Leveling', 'Class', 'Professions', 'Reputation', 'Legacy', 'Exploration', 'Collectibles', 'Miscellaneous', 'Dungeons']) {
		const r = compile(base(c.toLowerCase()));
		assert.deepEqual([r.guides[0].category, r.warnings], [c, []]);
	}
	const odd = compile(base('Fishing Tales'));
	assert.equal(odd.guides[0].category, 'Fishing Tales');
	assert.deepEqual(odd.warnings, ['test.guide:5: unknown category "Fishing Tales" (known: Leveling, Class, Professions, Reputation, Legacy, Exploration, Collectibles, Miscellaneous, Dungeons)']);
});

test('new verbs emit Lua that loads under Lua 5.1 and round-trips, with reagents as nested tables', () => {
	const src = guideText([
		'guide t/prof',
		'title First Aid 1-150',
		'category Professions',
		'levels 1-60',
		'zone Elwynn Forest',
		'',
		'step Train',
		'  learn 3276',
		'  craft 3276 x10 -- "Linen" \\ notes',
		'  craft 7934 until 115',
		'  skill First Aid 150',
		'step Rep',
		'  rep Stormwind Exalted',
		'  explore 42.1,65.9 "Goldshire"',
		'  achieve 7 "Legacy: Northshire" criteria 3',
	]);
	const r = compile(src);
	assert.deepEqual(r.errors, []);
	const file = path.join(writeTestPack(r.guides).dir, 'Guides.lua');
	const lua = fs.readFileSync(file, 'utf8');
	assert.match(lua, /reagents = \{ \{ item = 2589, itemName = "Linen Cloth", count = 2 \} \}/);
	assert.equal(lua, emitGuides([{ guide: r.guides[0]._localised, source: 'test.guide' }]));
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua'] }],
		script: `
			local got
			Polestar.RegisterGuide = function(g) got = g end
			assert(loadfile(${JSON.stringify(file)}))("Polestar_Guides", {})
			emit(got)`,
	}).emitted;
	assert.deepEqual(out, plain(r.guides[0]._localised));
	assert.equal(out.category, 'Professions');
	assert.equal(out.steps[0].goals[1].note, '"Linen" \\ notes');
});

test('the compiled new-verb goals pass the real engine registry', () => {
	const r = compile(
		guideText(['step S', '  learn 3276', '  craft 3276 x2', '  skill First Aid 150', '  rep 72 Friendly', '  explore 42,65 "Goldshire"', '  achieve 6 "Level 10" criteria 1']).replace(/^guide t\//, 'guide test/'),
		undefined,
		{ pack: 'test' },
	);
	assert.deepEqual(r.errors, []);
	const file = path.join(writeTestPack(r.guides).dir, 'Guides.lua');
	const [ok] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `
			${TEST_PACK}
			local res = {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) local ok, e = real(g); res[#res + 1] = ok and "ok" or e; return ok, e end
			assert(loadfile(${JSON.stringify(file)}))("Polestar_Guides", {})
			emit(res)`,
	}).emitted;
	assert.deepEqual(ok, ['ok']);
});

test('prerequisites are any-of: one turned-in prerequisite suffices; none of them warns', () => {
	// 9500 lists 9201 and 783 as prerequisites.
	const one = compile(guideText(['step S', '  accept 783', '  turnin 783', '  accept 9500']));
	assert.deepEqual(only(one.warnings, /turned in first|none of them/), []);
	const other = compile(guideText(['step S', '  accept 9201', '  turnin 9201', '  accept 9500']));
	assert.deepEqual(only(other.warnings, /turned in first|none of them/), []);
	const src = guideText(['step S', '  accept 9500']);
	assert.deepEqual(only(compile(src).warnings, /turned in first|none of them/), [
		`test.guide:${lineOf(src, '  accept 9500')}: quest 9500 needs one of 9201 (The First Step), 783 (A Threat Within) turned in first, but the chain turns in none of them`,
	]);
	// Accepting is not turning in.
	const accepted = compile(guideText(['step S', '  accept 783', '  accept 9500']));
	assert.equal(only(accepted.warnings, /none of them/).length, 1);
	// Through a `next` chain.
	const chain = compile({
		'1.guide': `${['guide t/one', 'title One', 'levels 1-5', 'zone Elwynn Forest', 'next t/two', '', 'step S', '  accept 9201', '  turnin 9201'].join('\n')}\n`,
		'2.guide': `${['guide t/two', 'title Two', 'levels 1-5', 'zone Elwynn Forest', '', 'step S', '  accept 9500'].join('\n')}\n`,
	});
	assert.deepEqual(only(chain.warnings, /turned in first|none of them/), []);
});
