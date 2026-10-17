'use strict';
// Where coordinates land and in which map frame: drop-source and spawn ranking
// by zone/used maps/nearness, the cross-zone warning, the `coords era|live`
// header and `era`/`live` goal modifiers, the frame-aware 50-yard check, and
// empty quoted strings.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, lineOf, plain } = require('./helpers/dsl');

function dunMorogh(body, extra = []) {
	return guideText(['guide t/dm', 'title Coldridge', 'faction Alliance', 'levels 1-6', 'zone Dun Morogh', ...extra, '', ...body]);
}

function only(list, re) {
	return list.filter((m) => re.test(m));
}

test('collect in Dun Morogh uses the Dun Morogh wolves, not the higher-chance Elwynn ones', () => {
	// Tough Wolf Meat: Elwynn wolves 80%/40%, Dun Morogh wolves 30%.
	const r = compile(dunMorogh(['step S', '  accept 179', '  collect 750 quest 179']));
	assert.deepEqual(r.errors, []);
	const goal = plain(r.guides[0].steps[0].goals[1]);
	assert.equal(goal.map, 1426);
	// Nearest Dun Morogh wolf to Sten Stoutarm (29.71,71.25): the Ragged Timber Wolf at 30,72.
	assert.deepEqual([goal.x, goal.y, goal.f], [30, 72, 'e']);
	assert.deepEqual(only(r.warnings, /never sets zone/), []);
});

test('candidates on maps the guide already used win over the rest of the world', () => {
	// The step zone (Durotar) has no wolves; Dun Morogh was used earlier, Elwynn never.
	const r = compile(dunMorogh(['step S', '  accept 179', 'step T', '  zone Durotar', '  collect 750 quest 179']));
	assert.equal(plain(r.guides[0].steps[1].goals[0]).map, 1426);
});

test('a coordinate on a map the guide never sets as zone warns (cross-continent mistakes)', () => {
	// Only Elwynn wolves drop the item here: the Dun Morogh guide would send players to Elwynn.
	const src = dunMorogh(['step S', '  kill 69', '  goto 10,10 map 1453', '  zone Stormwind City', '  talk 823']);
	const r = compile(src);
	// `goto … map 1453` is fine (the guide sets zone Stormwind City later); `talk 823`
	// (an Elwynn NPC) under `zone Stormwind City` is not.
	assert.deepEqual(only(r.warnings, /never sets zone/), [
		`test.guide:${lineOf(src, '  kill 69')}: coordinates on map 1429 (Elwynn Forest), but this step's zone is 1426 (Dun Morogh) and the guide never sets zone 1429; check the target, or add \`zone map 1429\` if the route really goes there`,
		`test.guide:${lineOf(src, '  talk 823')}: coordinates on map 1429 (Elwynn Forest), but this step's zone is 1453 (Stormwind City) and the guide never sets zone 1429; check the target, or add \`zone map 1429\` if the route really goes there`,
	]);
	// Setting the zone anywhere in the guide silences it.
	const ok = compile(dunMorogh(['step S', '  kill 69', 'step T', '  zone Elwynn Forest', '  level 3']));
	assert.deepEqual(only(ok.warnings, /never sets zone/), []);
});

// Fitz's playtest: Darkshore's "Boat to Stormwind" pointed into Moonglade,
// the zone a Night Elf Druid trip earlier in the guide had set.
test('typed coordinates on a zone set by a step for some characters only warn when the others are elsewhere', () => {
	const trip = ['step Trip', '  only Paladin', '  zone Stormwind City', '  goto 50,50'];
	const src = dunMorogh([...trip, 'step Back', '  goto 30,72 "Coldridge"', '  goto 31,72 only Paladin', '  goto 32,72 map 1426']);
	const r = compile(src);
	// The Paladins' own goal and the one with `map` are fine; the goal everyone sees is in Stormwind for the others.
	assert.deepEqual(only(r.warnings, /sets in a step for/), [
		`test.guide:${lineOf(src, '  goto 30,72 "Coldridge"')}: coordinates on Stormwind City, the zone line ${lineOf(src, '  zone Stormwind City')} sets in a step for Paladin only; the others who see this goal are in Dun Morogh`,
	]);
	assert.equal(plain(r.guides[0].steps[1].goals[0]).map, 1453, 'the zone in effect still holds (only the warning is new)');
	// A `zone` line after the trip, or a step only the trip's characters see, is fine.
	for (const body of [
		[...trip, 'step Back', '  zone Dun Morogh', '  goto 30,72'],
		[...trip, 'step More', '  only Paladin', '  goto 30,72'],
	]) {
		assert.deepEqual(only(compile(dunMorogh(body)).warnings, /sets in a step for/), []);
	}
});

test('hand-typed coordinates are Era-frame by default; `coords live` and `live`/`era` modifiers override', () => {
	const goals = (src) => plain(compile(src).guides[0].steps[0].goals);
	const era = goals(dunMorogh(['step S', '  goto 30,72', '  goto 31,72 live', '  kill 704 @30,72', '  explore 29,70 "Coldridge Valley"']));
	assert.deepEqual(era.map((g) => g.f), ['e', undefined, 'e', 'e']);
	const live = goals(dunMorogh(['step S', '  goto 30,72', '  goto 31,72 era', '  kill 704', '  talk 9002'], ['coords live']));
	assert.deepEqual(live.map((g) => g.f), [undefined, 'e', 'e', undefined], 'data-resolved points keep their source frame');
	const explicitEra = goals(dunMorogh(['step S', '  goto 30,72'], ['coords era']));
	assert.equal(explicitEra[0].f, 'e');
});

test('coordinates on maps without Era bounds compile live; asking for era there warns', () => {
	// Durotar (1411) has Era bounds in the fixture; 9999 has none.
	const src = dunMorogh(['step S', '  goto 50,50 map 9999', '  goto 50,50 map 9999 era']);
	const r = compile(src);
	const goals = plain(r.guides[0].steps[0].goals);
	assert.deepEqual(goals.map((g) => g.f), [undefined, undefined]);
	assert.deepEqual(only(r.warnings, /no Era bounds/), [
		`test.guide:${lineOf(src, '  goto 50,50 map 9999 era')}: \`era\` coordinates on map 9999, but map-frames.json has no Era bounds for it; compiling them as live-frame`,
	]);
});

test('frame modifiers: errors for bad values, duplicates, and use without explicit coordinates', () => {
	const src = dunMorogh(['step S', '  goto 1,1 era live', '  kill 704 live', '  turnin 179 era', '  level 2'], ['coords mixed']);
	assert.deepEqual(compile(src).errors, [
		`test.guide:${lineOf(src, 'coords mixed')}: coords must be era or live, not "mixed"`,
		`test.guide:${lineOf(src, '  goto 1,1 era live')}: duplicate \`era\`/\`live\``,
		`test.guide:${lineOf(src, '  kill 704 live')}: \`live\` only applies to explicit coordinates (@x,y)`,
		`test.guide:${lineOf(src, '  turnin 179 era')}: \`era\` only applies to explicit coordinates (@x,y)`,
		`test.guide:${lineOf(src, '  turnin 179 era')}: \`turnin\` for quest 179 that is never accepted earlier in this guide or a guide chaining into it`,
	]);
});

test('the 50-yard check compares explicit coordinates only with spawns in the same frame', () => {
	// Recorded Lookout (9002) has only a live-frame spawn at 30,30 in Elwynn.
	const elwynn = (body, extra = []) => guideText(['guide t/e', 'title E', 'levels 1-5', 'zone Elwynn Forest', ...extra, '', ...body]);
	const far = '  talk 9002 @60,60';
	assert.deepEqual(only(compile(elwynn(['step S', far])).warnings, /explicit coordinates/), [], 'Era coordinates vs a live spawn: not comparable');
	const liveFar = compile(elwynn(['step S', far], ['coords live']));
	assert.deepEqual(only(liveFar.warnings, /explicit coordinates/), ['test.guide:8: explicit coordinates 60,60 are more than 50 yards from every known spawn of npc 9002']);
	assert.deepEqual(only(compile(elwynn(['step S', '  talk 9002 @30.2,30.1'], ['coords live'])).warnings, /explicit coordinates/), []);
	// Era coordinates against Era spawns still warn when far.
	assert.equal(only(compile(elwynn(['step S', '  talk 823 @60,60'])).warnings, /more than 50 yards/).length, 1);
});

test('empty quoted strings are errors at their line', () => {
	const src = guideText(['step S', '  kill ""', '  note ""', '  accept 7 " "', '  goto 1,1 ""', '  level 2', 'step ""', '  level 3']);
	const r = compile(src);
	const msg = 'empty quoted string (names, titles, labels and notes need text)';
	assert.deepEqual(r.errors, [
		`test.guide:${lineOf(src, '  kill ""')}: ${msg}`,
		`test.guide:${lineOf(src, '  note ""')}: ${msg}`,
		`test.guide:${lineOf(src, '  accept 7 " "')}: ${msg}`,
		`test.guide:${lineOf(src, '  goto 1,1 ""')}: ${msg}`,
		`test.guide:${lineOf(src, 'step ""')}: ${msg}`,
	]);
	const header = guideText(['guide t/h', 'title ""', 'levels 1-2', 'zone Elwynn Forest', '', 'step S', '  level 2']);
	assert.match(compile(header).errors.join('\n'), new RegExp(`test.guide:2: ${msg.replace(/[()]/g, '\\$&')}`));
});

test('collect weighs drop chance on the chosen map: a 0.02% mob next to the last goal loses to the 100% node', () => {
	// Earthroot: Kobold Crate objects 100%, Kobold Vermin 0.02%. The goto stands on a Vermin spawn.
	const src = guideText(['step S', '  goto 49,32.4', '  collect 2449 x5']);
	const g = plain(compile(src).guides[0].steps[0].goals[1]);
	assert.deepEqual([g.map, g.x, g.y], [1429, 47, 32]);
	// Sources of similar chance still go by nearness (Young Wolf 40% vs Timber Wolf 80%).
	const wolves = plain(compile(guideText(['step S', '  goto 46.2,38.1', '  collect 750 x5'])).guides[0].steps[0].goals[1]);
	assert.deepEqual([wolves.x, wolves.y], [46, 38]);
});

test('the 50-yard check compares collect coordinates with real sources only: 2%+ droppers and gathering nodes', () => {
	// Shadowgem: Lone Kobold 5% (80,20), Copper Vein 1% per node (30,30), Battered Chest 0.5% (70,70).
	const near = (at) => compile(guideText(['step S', `  collect 1210 x1 @${at}`])).warnings.filter((w) => /explicit coordinates/.test(w));
	assert.deepEqual(near('30.1,30.1'), [], 'at the vein');
	assert.deepEqual(near('80,20'), [], 'at the 5% dropper');
	assert.equal(near('70,70').length, 1, 'a 0.5% chest is not a source to check against');
	// Any object dropping the item at 2% or more still counts (Earthroot: Kobold Crate at 100%).
	assert.deepEqual(compile(guideText(['step S', '  collect 2449 x1 @10,90'])).warnings.filter((w) => /explicit coordinates/.test(w)).length, 1);
});
