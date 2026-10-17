'use strict';
// Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, Smart
// logic, Farm spots) and quest prerequisite titles on accepts.
// Fixture: Silk Cloth (4306) drops from mobs in Elwynn, Durotar and
// Stranglethorn, plus an elite, a mob standing in Goldshire and a 1% dropper.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');
const { compile, plain, fixtureData, writeTestPack, DATA_DIR } = require('./helpers/dsl');
const { loadData } = require('../tools/lib/dsl/data');
const { farmSpots } = require('../tools/lib/dsl/farmspots');

const head = (faction) => ['guide t/f', 'title F', ...(faction ? [`faction ${faction}`] : []), 'levels 1-60', 'zone Elwynn Forest', ''];

function src(faction, body) {
	return `${[...head(faction), 'step S', ...body].join('\n')}\n`;
}

test('farm spots: clustered droppers (by id and name) with zone safety, level range, rate and spawn count', () => {
	const spots = farmSpots(fixtureData(), 4306);
	const byName = Object.fromEntries(spots.map((s) => [s.npcName, s]));
	assert.deepEqual(byName['Cloth Kobold'], { map: 1429, x: 65.4, y: 75.3, f: 'e', faction: 'A', npc: 95001, npcName: 'Cloth Kobold', lvl: { min: 5, max: 5 }, rate: 0.3, spawns: 4 });
	assert.deepEqual([byName['Cloth Harpy'].faction, byName['Cloth Harpy'].spawns], ['H', 3]);
	assert.deepEqual([byName['Cloth Troll'].faction, byName['Cloth Troll'].lvl], ['AH', { min: 35, max: 35 }]);
	assert.equal(byName['Lone Kobold'].spawns, 1);
	// Not farm spots: the elite, the rat inside Goldshire, the kobold at the guard post, Kobold Vermin at 1%.
	for (const name of ['Elite Kobold', 'Goldshire Rat', 'Guardpost Kobold', 'Kobold Vermin']) assert.equal(byName[name], undefined, name);
	// Per continent (Kalimdor, then Eastern Kingdoms), best rate × spawns first:
	// the 5-spawn camp at 35% (1.75) beats the 4-spawn camp at 30% (1.2).
	assert.deepEqual(
		spots.map((s) => s.npcName),
		['Cloth Harpy', 'Ancient Kobold', 'Cloth Kobold', 'Cloth Troll', 'Lone Kobold'],
	);
	// Deterministic.
	assert.deepEqual(farmSpots(fixtureData(), 4306), spots);
});

test('collect <item> xN nearest compiles to farm-spot candidates for the factions the goal serves', () => {
	const r = compile(src('Alliance', ['  collect 4306 x20 nearest']));
	assert.deepEqual(r.errors, []);
	assert.deepEqual(r.warnings, []);
	const g = plain(r.guides[0].steps[0].goals[0]);
	assert.deepEqual([g.t, g.item, g.itemName, g.count, g.map, g.x], ['collect', 4306, 'Silk Cloth', 20, undefined, undefined]);
	// Alliance: Elwynn and contested spots, never Durotar.
	assert.deepEqual(g.candidates.map((c) => c.faction).sort(), ['A', 'A', 'A', 'AH']);
	assert.ok(!g.candidates.some((c) => c.npcName === 'Cloth Harpy'));
	const both = plain(compile(src(null, ['  collect 4306 x20 nearest'])).guides[0].steps[0].goals[0]);
	assert.ok(both.candidates.some((c) => c.faction === 'H'));
});

test('collect … nearest: no spots, no count, a quest link or coordinates are errors', () => {
	const r = compile(src(null, ['  collect 750 x5 nearest', '  collect 4306 nearest', '  accept 33', '  collect 4306 x2 quest 33 nearest', '  collect 4306 x2 nearest @1,1']));
	assert.deepEqual(r.errors, [
		'test.guide:7: `collect 750 nearest` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for Alliance or Horde characters; give @x,y or a gathering step instead',
		'test.guide:8: `collect … nearest` needs a count: `collect <item> xN nearest`',
		'test.guide:10: `collect … nearest` farms by bag count; drop `quest` (quest objectives use the quest’s own targets)',
		'test.guide:11: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id',
	]);
	// Tough Wolf Meat drops at 80% in Elwynn and 30% in Dun Morogh: Alliance zones only.
	const horde = compile(src('Horde', ['  collect 750 x5 nearest']));
	assert.deepEqual(horde.errors, ['test.guide:8: `collect 750 nearest` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for Horde characters; give @x,y or a gathering step instead']);
});

test('a faction with no safe farm spot gets a warning when the goal serves it', () => {
	const r = compile(src(null, ['  collect 4306 x5 nearest only Alliance', '  collect 4306 x5 nearest']));
	assert.deepEqual(r.errors, []);
	assert.deepEqual(r.warnings, []);
	// With Elwynn as the only source, a both-faction goal lacks a Horde-safe spot.
	// A fresh load, so the shared fixture data is never modified.
	const data = loadData(DATA_DIR);
	data.items[4306].drops = { npc: { 95001: 30 }, object: {} };
	const w = compile(src(null, ['  collect 4306 x5 nearest']), data);
	assert.deepEqual(w.warnings, ['test.guide:7: no farm spot for item 4306 that is safe for Horde, but this goal applies to Horde characters']);
});

test('farm spots and prerequisite titles emit Lua that the engine registry accepts and round-trips', () => {
	const r = compile(src(null, ['  collect 4306 x20 nearest', '  accept 9500']).replace(/^guide t\//, 'guide test/'), undefined, { pack: 'test' });
	assert.deepEqual(r.errors, []);
	const file = path.join(writeTestPack(r.guides).dir, 'Guides.lua');
	const lua = fs.readFileSync(file, 'utf8');
	assert.match(lua, /\{ npc = 95001, npcName = "Cloth Kobold", map = 1429, x = 65\.4, y = 75\.3, f = "e", faction = "A", lvl = \{ min = 5, max = 5 \}, rate = 0\.3, spawns = 4 \}/);
	assert.match(lua, /pre = \{ 9201, 783 \}, preTitles = \{ \[783\] = "A Threat Within", \[9201\] = "The First Step" \}/);
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `
			${TEST_PACK}
			local got, res
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) got = g; local ok, e = real(g); res = ok and "ok" or e; return ok, e end
			assert(loadfile(${JSON.stringify(file)}))("Polestar_Guides", {})
			emit({ res = res, title = got.steps[1].goals[2].preTitles[783], guide = got })`,
	}).emitted;
	assert.equal(out.res, 'ok');
	assert.equal(out.title, 'A Threat Within');
	assert.deepEqual(out.guide, plain(r.guides[0]));
});
