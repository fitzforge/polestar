'use strict';
// A profession guide's materials, gathered or bought (docs/GUIDE_FORMAT.md, "Materials"): `auction <item> xN` buys
// at the Auction House and `collect … gather` is the item's gather way; Core/Materials.lua picks per item which
// applies. The JS compiler side of forge-guide's dsl_materials.rs test.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain, fixtureData } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, MATERIALS_FORMAT, MONEY_TASK_FORMAT, NEEDS } = require('../tools/lib/pack/format');

const head = (faction) => ['guide t/tailoring', 'title Tailoring', 'category Professions', ...(faction ? [`faction ${faction}`] : []), 'levels 1-60', 'zone Elwynn Forest', ''];
const text = (lines, faction = 'Alliance') => `${[...head(faction), ...lines].join('\n')}\n`;
const goals = (r) => plain(r.guides[0]).steps.map((s) => s.goals);

test('`auction <item> xN` leads to the auctioneers of the factions the goal serves, never a neutral house', () => {
	const r = compile(text(['step Auction House', '  auction 4306 x20']));
	assert.deepEqual([r.errors, r.warnings], [[], []], r.text);
	const g = goals(r)[0][0];
	assert.deepEqual([g.t, g.item, g.itemName, g.count], ['auction', 4306, 'Silk Cloth', 20]);
	assert.deepEqual(g.candidates.map((c) => [c.npcName, c.faction]), [['Auctioneer Fitch', 'A']]);
	const both = goals(compile(text(['step Auction House', '  auction 4306 x20'], null)))[0][0];
	assert.deepEqual(both.candidates.map((c) => c.faction).sort(), ['A', 'H']);
	assert.ok(!both.candidates.some((c) => c.npcName === 'Booty Bay Auctioneer'));
});

test('`auction` needs a count, takes no place, and refuses an item that binds when picked up', () => {
	const errs = (lines, data) => compile(text(lines), data).errors.join('\n');
	assert.match(errs(['step A', '  auction 4306']), /`auction` needs a count: `auction <item> xN`/);
	assert.match(errs(['step A', '  auction 4306 x5 @40,50']), /`@x,y` does not apply to `auction`/);
	assert.match(errs(['step A', '  auction 4306 x5 nearest']), /`nearest` does not apply to `auction`/);
	const base = fixtureData();
	const professions = Object.fromEntries([...base.professions.values()].map((p) => [p.id, p]));
	professions[186] = { ...professions[186], materials: { 4306: { name: 'Silk Cloth', bop: true } } };
	const bop = new Data({ quests: base.quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta, professions }, { dir: base.dir });
	assert.match(errs(['step A', '  auction 4306 x5'], bop), /item 4306 binds when picked up: the Auction House never has it/);
});

test('`collect … gather` is the item\'s gather way, with the profession and levels it takes', () => {
	const r = compile(text([
		'step Auction House',
		'  auction 2589 x40',
		'  auction 4306 x20',
		'  auction 1210 x2',
		'step Linen',
		'  collect 2589 x40 anywhere gather levels 5-20',
		'step Silk',
		'  collect 4306 x20 @40,50 gather',
		'step Shadowgem',
		'  collect 1210 x2 @40,50 gather Mining 65',
		'step Both',
		'  collect 2589 x40 anywhere gather "First Aid" 1 levels 5-20',
	]));
	assert.deepEqual(r.errors, [], r.text);
	const g = goals(r);
	assert.deepEqual(g[1][0].gather, { min: 5, max: 20 });
	assert.equal(g[2][0].gather, true);
	assert.deepEqual(g[3][0].gather, { skill: 'Mining', skillLine: 186, rank: 65 });
	assert.deepEqual(g[4][0].gather, { skill: 'First Aid', skillLine: 129, rank: 1, min: 5, max: 20 });
	assert.deepEqual([g[1][0].count, g[2][0].x], [40, 40]);
	const lua = emitGuides(r.guides.map((guide) => ({ guide })));
	assert.match(lua, /count = 40, gather = \{ max = 20, min = 5 \}/);
	assert.match(lua, /gather = \{ rank = 65, skill = "Mining", skillLine = 186 \}/);
	assert.match(lua, /t = "auction", item = 1210, itemName = "Shadowgem", count = 2/);
	assert.equal(formatFor(r.guides), MATERIALS_FORMAT);
	assert.equal(NEEDS[MATERIALS_FORMAT], '0.3.8');
	assert.equal(formatFor(compile(text(['step A', '  money 1s'])).guides), MONEY_TASK_FORMAT);
});

test('a malformed `gather` is an error; an unknown profession named in quotes passes with a warning', () => {
	const r = (lines) => compile(text(['step Auction House', '  auction 4306 x20', 'step S', ...lines]));
	const errs = (lines) => r(lines).errors.join('\n');
	assert.match(errs(['  collect 4306 x20 @40,50 gather levels 30-15']), /malformed level range "30-15"/);
	assert.match(errs(['  collect 4306 x20 @40,50 gather levels thirty']), /malformed level range "thirty"/);
	assert.match(errs(['  collect 4306 x20 @40,50 gather Mining 0']), /malformed skill rank "0" after `gather Mining`/);
	assert.match(errs(['  collect 4306 x20 @40,50 gather Juggling 50']), /unknown profession "Juggling"; quote the name to use it anyway: `gather "Juggling" 50`/);
	assert.match(errs(['  collect 4306 @40,50 gather']), /`collect … gather` needs a count/);
	assert.match(errs(['  collect 4306 x2 quest 7.1 gather']), /`collect … gather` is a profession material, a bag count: drop `quest`/);
	assert.match(errs(['  kill 6 x2 gather']), /`gather` does not apply to `kill`/);
	assert.match(errs(['  collect 4306 x20 gather gather']), /duplicate `gather`/);
	const quoted = r(['  collect 4306 x20 @40,50 gather "Juggling" 50']);
	assert.deepEqual(quoted.errors, []);
	assert.ok(quoted.warnings.some((w) => w.includes('profession "Juggling" is not in data')), quoted.text);
	assert.deepEqual(goals(quoted)[1][0].gather, { skill: 'Juggling', rank: 50 });
});

test('a `gather` needs an `auction` goal for its item in the same section', () => {
	const warns = (lines) => compile(text(lines)).warnings.filter((w) => w.includes('`gather` with no `auction` goal'));
	const sections = ['section Mining 1-75', 'step AH', '  auction 4306 x20', 'step Silk', '  collect 4306 x20 @40,50 gather', 'section Mining 75-150', 'step AH 2', '  auction 2589 x10', 'step Silk 2', '  collect 4306 x30 @40,50 gather'];
	const w = warns(sections);
	assert.equal(w.length, 1, w.join('\n'));
	assert.match(w[0], /test\.guide:\d+: `gather` with no `auction` goal for item 4306 in its section: a player who buys materials has nothing that buys it here/);
	assert.ok(w[0].startsWith(`test.guide:${head('Alliance').length + sections.length}:`), w[0]);
	assert.deepEqual(warns(['step Silk', '  collect 4306 x20 @40,50 gather', 'step AH', '  auction 4306 x20']), []);
	assert.match(warns(['step Silk', '  collect 4306 x20 @40,50 gather'])[0], /in its guide/);
	assert.deepEqual(warns(['step AH', '  auction 4306 x20']), [], 'buying only is fine');
});
