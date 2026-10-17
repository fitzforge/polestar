'use strict';
// The resolver (tools/lib/dsl/resolve.js): what the compiler fills in from
// reference data, per docs/GUIDE_FORMAT.md "What the compiler fills in".
// Fixture data: tests/fixtures/dsl/data (Elwynn Forest, uiMapID 1429).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, plain, fixtureData } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');

function goalsOf(lines) {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, [], r.text);
	return { goals: plain(r.guides[0].steps.flatMap((s) => s.goals)), r };
}

// Spawns of an npc or object on Elwynn (1429) that lie outside every spot of
// `goal`, measured in yards through the map's Era frame.
function outsideSpots(goal, kind, id) {
	const data = fixtureData();
	const fr = data.eraFrame(1429);
	const sx = Math.abs(fr.right - fr.left) / 100;
	const sy = Math.abs(fr.bottom - fr.top) / 100;
	const s = data.spawns(kind, id).find((sp) => sp.map === 1429);
	const pts = [...s.pts, ...s.more];
	return pts.filter(([x, y]) => !(goal.spots || []).some((s) => Math.hypot((x - s.x) * sx, (y - s.y) * sy) <= s.r));
}

test('quest titles, quest givers and their positions come from data; Era-sourced points carry f = "e"', () => {
	const { goals } = goalsOf(['step One', '  accept 783', '  turnin 783', '  accept 7 "My Own Title"']);
	assert.deepEqual(goals[0], { t: 'accept', quest: 783, title: 'A Threat Within', npc: 823, npcName: 'Deputy Willem', minLevel: 1, qlvl: 1, map: 1429, x: 48.17, y: 42.94, f: 'e' });
	assert.deepEqual(goals[1], { t: 'turnin', quest: 783, title: 'A Threat Within', npc: 197, npcName: 'Marshal McBride', map: 1429, x: 48.92, y: 41.61, f: 'e' });
	assert.equal(goals[2].title, 'My Own Title', 'explicit title wins over data');
});

test('the spawn nearest the previous goal on the same map is chosen, measured in yards', () => {
	// From 47.6,35.1 the nearest Kobold Vermin in map percent is 47.6,31.2, but
	// Elwynn is wider than tall: in yards 49.0,32.4 is closer.
	const a = goalsOf(['step One', '  goto 47.6,35.1', '  kill 6']).goals;
	assert.deepEqual([a[1].x, a[1].y, a[1].f], [49, 32.4, 'e']);
	const b = goalsOf(['step One', '  goto 52,27', '  kill 6']).goals;
	assert.deepEqual([b[1].x, b[1].y], [52.3, 26.8]);
	// The previous goal can be in an earlier step.
	const c = goalsOf(['step One', '  goto 45,34', 'step Two', '  kill 6']).goals;
	assert.deepEqual([c[1].x, c[1].y], [45.1, 33.9]);
});

test('among several quest enders the one nearest the previous goal wins; npc picks one explicitly', () => {
	const near197 = goalsOf(['step One', '  accept 5261', '  goto 48.9,41.7', '  turnin 5261']).goals[2];
	assert.deepEqual([near197.npc, near197.npcName], [197, 'Marshal McBride']);
	const near196 = goalsOf(['step One', '  accept 5261', '  goto 48.9,40.0', '  turnin 5261']).goals[2];
	assert.deepEqual([near196.npc, near196.npcName], [196, 'Eagan Peltskinner']);
	const explicit = goalsOf(['step One', '  accept 5261', '  goto 48.9,40.0', '  turnin 5261 npc 197']).goals[2];
	assert.deepEqual([explicit.npc, explicit.x, explicit.y], [197, 48.92, 41.61]);
});

test('without previous coordinates the spawn centroid in the current zone is used', () => {
	const elwynn = goalsOf(['step One', '  kill 1423']).goals[0];
	assert.deepEqual([elwynn.map, elwynn.x, elwynn.y], [1429, 50, 60]);
	const city = goalsOf(['step One', '  zone Stormwind City', '  kill 1423']).goals[0];
	assert.deepEqual([city.map, city.x, city.y, city.f], [1453, 60, 70, 'e']);
});

test('collect positions at the item drop sources, preferring the current zone, then nearness, then drop chance', () => {
	// Timber Wolf (80%) and Young Wolf (40%) both spawn in Elwynn. With no earlier
	// point on the map, the higher-chance source's centroid is used. Both droppers'
	// spawns make the spawn areas: a pack of two and, with only three spawns, the
	// lone one too; nearest to the goal's point first.
	// The dominant source (50% or more) is named, for quest objectives too.
	const pack = { x: 45.5, y: 39, r: 30, n: 2 };
	const lone = { x: 44, y: 45, r: 15, n: 1 };
	const alone = goalsOf(['step One', '  collect 750 x4']).goals[0];
	assert.deepEqual(alone, { t: 'collect', item: 750, itemName: 'Tough Wolf Meat', from: 'Timber Wolf', fromId: 69, fromKind: 'npc', fromFaction: 'A', count: 4, map: 1429, x: 44.5, y: 42.5, f: 'e', spots: [lone, pack] });
	// After meeting Eagan (48.94,40.17) the nearest spawn of any source wins: a Young Wolf at 46,38.
	const linked = goalsOf(['step One', '  accept 33', '  collect 750 quest 33']).goals[1];
	assert.deepEqual(linked, { t: 'collect', quest: 33, title: 'Wolves Across the Border', item: 750, itemName: 'Tough Wolf Meat', from: 'Timber Wolf', fromId: 69, fromKind: 'npc', fromFaction: 'A', count: 8, oi: 1, map: 1429, x: 46, y: 38, f: 'e', spots: [pack, lone] });
});

test('a second source dropping the item at 50% or more is named beside the first; both carry their ids (the names in the client\'s language)', () => {
	// Fractured Canine: Timber Wolf 70%, Diseased Young Wolf (299) 60%.
	const g = goalsOf(['step One', '  collect 3299 x2']).goals[0];
	assert.deepEqual([g.from, g.fromId, g.fromAlso, g.fromAlsoId, g.fromKind], ['Timber Wolf', 69, 'Diseased Young Wolf', 299, 'npc']);
	// Tough Wolf Meat: Diseased Young Wolf drops it at 40%, so only Timber Wolf is named.
	assert.equal(goalsOf(['step One', '  collect 750 x4']).goals[0].fromAlso, undefined);
});

// Fixture data plus an orc camp on Elwynn: elite Blackrock Sentries (rank 1)
// at 30,30 and normal Blackrock Grunts at 70,70, both hostile, one Grunt
// among the Sentries. Item 95110 drops from the Sentry at 100% and the Grunt
// at 37% (Hillsbrad Human Skull), 95111 from both at 50% (Battleworn Axe),
// 95112 only from the Sentry.
function eliteCampData() {
	const base = fixtureData();
	const camp = (x, y) => [[x, y], [x + 0.3, y + 0.2], [x - 0.2, y + 0.3]];
	const npcs = {
		...base.npcs,
		95050: { id: 95050, name: 'Blackrock Sentry', level: 25, rank: 1, faction: null, spawns: { 1429: { f: 'e', pts: camp(30, 30) } } },
		95051: { id: 95051, name: 'Blackrock Grunt', level: 24, faction: null, spawns: { 1429: { f: 'e', pts: [...camp(70, 70), [30.4, 29.8]] } } },
	};
	const item = (id, name, npc) => ({ id, name, drops: { npc, object: {} }, vendors: [] });
	const items = {
		...base.items,
		95110: item(95110, 'Orc Skull', { 95050: 100, 95051: 37 }),
		95111: item(95111, 'Orc Axe', { 95050: 50, 95051: 50 }),
		95112: item(95112, 'Sentry Badge', { 95050: 100 }),
	};
	return new Data({ quests: base.quests, npcs, objects: base.objects, items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

test('a collect that normal mobs drop leads to them, not into the camp of elites that drop it too (#126)', () => {
	const data = eliteCampData();
	const goal = (...lines) => {
		const r = compile(guideText(['step One', ...lines]), data);
		assert.deepEqual(r.errors, [], r.text);
		return plain(r.guides[0].steps[0].goals.at(-1));
	};
	const near = (s, x, y) => Math.abs(s.x - x) < 2 && Math.abs(s.y - y) < 2;
	const arrow = (g) => g.spots.filter((s) => !s.alt);
	const alts = (g) => g.spots.filter((s) => s.alt);
	// The Sentry's 100% would leave out the Grunt's 37%: the Grunts are still where to farm it.
	// The Grunt among the Sentries is only an alternative, never the elites' own spawns.
	const skull = goal('  collect 95110 x5');
	assert.ok(!near(skull, 30, 30), `the point is not at the Sentries: ${skull.x},${skull.y}`);
	assert.ok(arrow(skull).length && arrow(skull).every((s) => near(s, 70, 70)), JSON.stringify(skull.spots));
	assert.deepEqual(alts(skull).map((s) => s.n), [1], JSON.stringify(skull.spots));
	// Equal chances, coming from the Sentries' camp: the point leaves it for the Grunts' camp.
	const axe = goal('  goto 30,31', '  collect 95111 x10');
	assert.ok(near(axe, 70, 70), `the point is at the Grunts: ${axe.x},${axe.y}`);
	assert.ok(arrow(axe).every((s) => near(s, 70, 70)), JSON.stringify(axe.spots));
	assert.deepEqual(alts(axe).map((s) => s.n), [1], JSON.stringify(axe.spots));
	// The goal line names the Grunts it leads to, not the elites.
	assert.deepEqual([axe.from, axe.fromAlso, axe.fromRank], ['Blackrock Grunt', undefined, undefined]);
	assert.equal(skull.from, undefined, 'the Grunt drops it at 37%: nothing to name');
	// Hand-placed at the Grunts: the Sentries' spawns make no alternative.
	const hand = goal('  collect 95111 x10 @70,70');
	assert.deepEqual(alts(hand).map((s) => s.n), [1], JSON.stringify(hand.spots));
	// An item only the elites drop still leads to them.
	const badge = goal('  collect 95112 x1 optional');
	assert.ok(near(badge, 30, 30), `the point is at the Sentries: ${badge.x},${badge.y}`);
	assert.ok(badge.spots.every((s) => near(s, 30, 30)), JSON.stringify(badge.spots));
	assert.deepEqual([badge.from, badge.fromRank], ['Blackrock Sentry', 1]);
});

test('kill goals carry the spawn areas of their mob, nearest to the chosen point first, every other place as an alternative; single spawns get none', () => {
	// Camp Gnoll: two camps of three 140 yd apart (around 40,70 and 44,70) and a lone spawn at 42,74:
	// seven spawns, more than six, so the arrow keeps to the camps and the lone one is an alternative.
	const { goals } = goalsOf(['step One', '  goto 41,71', '  kill 95021', '  goto 44,70', '  kill 95021', '  kill 823']);
	const west = { x: 40, y: 70.2, r: 15, n: 3 };
	const east = { x: 44.1, y: 70, r: 15, n: 3 };
	const lone = { x: 42, y: 74, r: 15, n: 1, alt: true };
	assert.deepEqual([goals[1].x, goals[1].y, goals[1].spots, goals[1].spread], [40.3, 70.3, [west, east, lone], undefined], 'from the west camp: west first');
	assert.deepEqual([goals[3].x, goals[3].y, goals[3].spots], [44, 70, [east, west, lone]], 'from the east camp: east first');
	assert.equal(goals[4].spots, undefined, 'a single-spawn npc stays a point');
});

test('a hand-placed point stays the spot the arrow takes; the other places the data knows are alternatives', () => {
	// Camp Gnoll from 40,70 (its west camp): the lone spawn and the east camp follow as alternatives, nearest first.
	const { goals } = goalsOf(['step One', '  kill 95021 @40,70', '  kill 95023 @20,20']);
	assert.deepEqual(goals[0].spots[0], { x: 40, y: 70, r: 20, n: 3 }, 'the author point, wide enough for the camp it stands in');
	assert.deepEqual(goals[0].spots.slice(1), [{ x: 42, y: 74, r: 15, n: 1, alt: true }, { x: 44.1, y: 70, r: 15, n: 3, alt: true }]);
	assert.deepEqual(outsideSpots(goals[0], 'npc', 95021), []);
	// Baron Testshore at 20,20: more than a thousand yards from every known spawn, so the author places
	// him where the data does not, and the data's places would mislead.
	assert.equal(goals[1].spots, undefined);
});

test('an NPC to talk to, accept from or hand in to that stands at several places gets every one', () => {
	const g = goalsOf(['step One', '  talk 95023']).goals[0];
	assert.deepEqual(outsideSpots(g, 'npc', 95023), []);
	assert.equal(g.spots.length, 2);
	assert.ok(g.spots.every((s) => !s.alt), 'a handful of places: the arrow may take any of them');
	assert.equal(g.spread, undefined);
});

test('a target with six spawns or fewer keeps a spot at every one: a named NPC may stand at any of them', () => {
	// Baron Testshore: a pair around 61,50 and a third spawn 224 yd off at 66,44.
	// From the north that third spawn is the goal's point, and it is a spot of its own, first.
	const g = goalsOf(['step One', '  goto 66.5,43.5', '  kill 95023']).goals[1];
	assert.deepEqual([g.x, g.y], [66, 44]);
	assert.deepEqual(outsideSpots(g, 'npc', 95023), []);
	assert.deepEqual([g.spots[0].x, g.spots[0].y, g.spots.length], [66, 44, 2]);
});

test('spawn areas include the points the reference data left out past its cap, data-placed and hand-placed', () => {
	// Capped Wolf: two spread points at 20,60 and 21,60; the cap left out a third at 27,66 (more than 250 yd off).
	const { goals } = goalsOf(['step One', '  goto 20,60', '  kill 95024', '  kill 95024 @20.5,60']);
	for (const g of [goals[1], goals[2]]) assert.deepEqual(outsideSpots(g, 'npc', 95024), [], g.x === 20.5 ? 'hand-placed' : 'data-placed');
	assert.ok(goals[1].spots.some((s) => s.x === 27 && s.y === 66), 'the left-out point is a place of its own');
});

test('object targets get spawn areas too: interact goals and collects from objects', () => {
	// Kobold Crate (object 1617): crates at 47,32 and 51,28, 168 yd apart; Earthroot (2449) comes from them.
	const { goals } = goalsOf(['step One', '  accept 9400', '  interact 1617 quest 9400', '  collect 2449 x5']);
	for (const g of [goals[1], goals[2]]) {
		assert.deepEqual(outsideSpots(g, 'object', 1617), [], g.t);
		assert.deepEqual(g.spots.map((s) => [s.x, s.y]).sort(), [[47, 32], [51, 28]], `${g.t}: two crates are two places, not one area between them`);
	}
});

test('mobs spread over a wide area make an area objective: every cluster, lone spawns too, as a walk from the chosen point', () => {
	// Roaming Gnoll: camps around 30,30 and 60,30 (a thousand yards apart) and a lone spawn at 80,80.
	const g = goalsOf(['step One', '  goto 58,32', '  kill 95020']).goals[1];
	assert.equal(g.spread, true);
	assert.deepEqual(g.spots, [
		{ x: 60.3, y: 29.9, r: 40, n: 3 },
		{ x: 30, y: 30.4, r: 40, n: 3 },
		{ x: 80, y: 80, r: 40, n: 1 },
	]);
});

test('an area objective with more clusters than the cap searches spots spread evenly over the whole area; every other place is an alternative', () => {
	// Plains Strider: twenty lone spawns on a 5 x 4 grid across Elwynn (x 10-90, y 20-80).
	const g = goalsOf(['step One', '  goto 12,22', '  kill 95022']).goals[1];
	assert.equal(g.spread, true);
	const searched = g.spots.filter((s) => !s.alt);
	assert.equal(searched.length, 12);
	assert.deepEqual(g.spots.slice(0, 12), searched, 'the searched spots come first');
	assert.deepEqual([g.spots[0].x, g.spots[0].y], [10, 20], 'the walk starts at the chosen point');
	assert.equal(new Set(g.spots.map((s) => `${s.x},${s.y}`)).size, 20, 'all twenty places, each once');
	assert.deepEqual(outsideSpots(g, 'npc', 95022), []);
	const xs = searched.map((s) => s.x);
	const ys = searched.map((s) => s.y);
	assert.deepEqual([Math.min(...xs), Math.max(...xs), Math.min(...ys), Math.max(...ys)], [10, 90, 20, 80], 'the searched picks reach every edge of the area');
	for (const [x0, x1, y0, y1] of [[10, 50, 20, 50], [50, 90, 20, 50], [10, 50, 50, 80], [50, 90, 50, 80]]) {
		assert.ok(searched.some((s) => s.x >= x0 && s.x <= x1 && s.y >= y0 && s.y <= y1), `a spot in ${x0}-${x1}, ${y0}-${y1}`);
	}
});

test('a spawn or two far from the camp that holds most of a target are strays: the point and the arrow go to the camp, the strays are alternatives', () => {
	// Hold Raider: eight spawns at a camp around 25,50 and two strays, at 41,44 and 40,36, more than
	// 500 yd east of it. Coming from 42,47 the spawn nearest the previous goal is the stray at 41,44.
	const g = goalsOf(['step One', '  goto 42,47', '  kill 95025']).goals[1];
	const nearCamp = (s) => Math.abs(s.x - 25) < 1.5 && Math.abs(s.y - 50) < 1.5;
	assert.ok(nearCamp(g), `the point is at the camp: ${g.x},${g.y}`);
	const arrow = g.spots.filter((s) => !s.alt);
	assert.ok(arrow.length && arrow.every(nearCamp), JSON.stringify(g.spots));
	assert.deepEqual(g.spots.filter((s) => s.alt).map((s) => [s.x, s.y, s.n]), [[41, 44, 1], [40, 36, 1]], 'the strays follow, nearest first');
	assert.deepEqual(outsideSpots(g, 'npc', 95025), []);
	// Trail Raider: a camp of twelve around 70,20 and a trail of three spawns, 140 yd apart, more than
	// 500 yd west of it: a sparse stretch to search, not strays, so the walk starts on the trail.
	const t = goalsOf(['step One', '  goto 45,22', '  kill 95026']).goals[1];
	assert.deepEqual([t.x, t.y, t.spread], [47, 20, true]);
	assert.deepEqual(t.spots.filter((s) => !s.alt).slice(0, 3).map((s) => [s.x, s.y]), [[47, 20], [51, 20], [55, 20]]);
});

test('objective index and count come from the linked objective; explicit values win', () => {
	const { goals, r } = goalsOf(['step One', '  accept 7', '  kill 6 quest 7', '  kill 6 x3 quest 7', '  accept 9400', '  interact 1617 quest 9400', '  kill 6 quest 7.1 x2']);
	assert.deepEqual([goals[1].oi, goals[1].count, goals[1].title], [1, 10, 'Kobold Camp Cleanup']);
	assert.deepEqual([goals[2].oi, goals[2].count], [1, 3]);
	assert.deepEqual([goals[4].oi, goals[4].count, goals[4].objName], [1, undefined, 'Kobold Crate']);
	assert.deepEqual([goals[5].oi, goals[5].count], [1, 2]);
	assert.deepEqual(r.warnings.filter((w) => /objective/.test(w)), []);
});

test('a quest link with no matching objective warns and leaves the index unset', () => {
	const { goals, r } = goalsOf(['step One', '  accept 7', '  kill 69 quest 7']);
	assert.equal(goals[1].oi, undefined);
	assert.match(r.warnings.join('\n'), /test\.guide:9: quest 7 has no objective for this npc/);
});

test('live-frame (recorded) spawns carry no frame flag; hand-typed coordinates are Era-frame by default', () => {
	const { goals } = goalsOf(['step One', '  talk 9001', '  talk 823 @48.2,42.9']);
	assert.deepEqual(goals[0], { t: 'talk', npc: 9001, npcName: 'Skyborne Herald', map: 1429, x: 40, y: 60 });
	assert.deepEqual(goals[1], { t: 'talk', npc: 823, npcName: 'Deputy Willem', map: 1429, x: 48.2, y: 42.9, f: 'e' });
});

test('buy without an npc picks a vendor of the item; map modifiers and zone directives place coordinates', () => {
	const { goals } = goalsOf(['step One', '  buy 159 x5', '  goto 50,50 map 1453 "Trade District"', '  zone map 1411', '  note "Durotar now" @10,20']);
	assert.deepEqual([goals[0].npc, goals[0].npcName, goals[0].count, goals[0].x, goals[0].y], [152, 'Brother Danil', 5, 47.5, 41.6]);
	assert.deepEqual([goals[1].map, goals[1].text], [1453, 'Trade District']);
	assert.deepEqual([goals[2].map, goals[2].x, goals[2].y], [1411, 10, 20]);
});

test('header fields compile to the guide schema with defaults', () => {
	const r = compile(
		guideText(['guide t/full', 'title Full', 'faction Horde', 'race Orc,Undead', 'class !Hunter', 'levels 3-9', 'zone map 1411', 'next t/other', 'category Dungeons', 'author Someone', 'version 4', '', 'step S', '  level 4']),
	);
	const g = plain(r.guides[0]);
	delete g.steps;
	assert.deepEqual(g, {
		id: 't/full',
		pack: 'guides',
		title: 'Full',
		faction: 'Horde',
		races: ['Orc', 'Scourge'],
		classes: ['WARRIOR', 'PALADIN', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID'],
		minLevel: 3,
		maxLevel: 9,
		category: 'Dungeons',
		zone: 1411,
		zoneName: 'Durotar',
		next: 't/other',
		author: 'Someone',
		version: 4,
	});
	const d = plain(compile(guideText(['step S', '  level 2'])).guides[0]);
	assert.deepEqual([d.category, d.author, d.version, d.pack, d.zone, d.zoneName], ['Leveling', 'Polestar', 1, 'guides', 1429, 'Elwynn Forest']);
});

test('step titles, tips and only conditions compile onto the step', () => {
	const r = compile(guideText(['step Camp', '  tip First line.', '  tip Second line.', '  only Warrior,Dwarf', '  level 2']));
	assert.deepEqual(plain(r.guides[0].steps[0]), {
		title: 'Camp',
		note: 'First line.\nSecond line.',
		only: { classes: ['WARRIOR'], races: ['Dwarf'] },
		goals: [{ t: 'level', level: 2 }],
	});
});

test('unknown zone names are errors at the zone line', () => {
	const text = guideText(['step S', '  zone Atlantis', '  level 2']);
	const r = compile(text);
	assert.deepEqual(r.errors, ['test.guide:8: unknown zone "Atlantis" (not in zones.json; use `zone map <uiMapID>`)']);
});
