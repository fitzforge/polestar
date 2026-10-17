'use strict';
// Validation rules of docs/GUIDE_FORMAT.md: every error and warning fires on
// the offending line, and stays quiet on valid input, including across guides
// chained with `next`.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, lineOf, fixtureData } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');

function header(id, extra = []) {
	return [`guide ${id}`, `title ${id}`, 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', ...extra, ''];
}

function text(id, body, extra) {
	return `${[...header(id, extra), ...body].join('\n')}\n`;
}

function only(list, re) {
	return list.filter((m) => re.test(m));
}

test('duplicate guide ids are errors naming both files', () => {
	const r = compile({ 'a.guide': text('t/same', ['step S', '  level 2']), 'b.guide': text('t/same', ['step S', '  level 3']) });
	assert.deepEqual(r.errors, ['b.guide:1: duplicate guide id "t/same" (also in a.guide:1)']);
});

test('`next` must point to a known guide', () => {
	const bad = text('t/a', ['step S', '  level 2'], ['next t/missing']);
	const r = compile({ 'a.guide': bad });
	assert.deepEqual(r.errors, [`a.guide:${lineOf(bad, 'next t/missing')}: \`next\` points to unknown guide "t/missing"`]);
	const ok = compile({ 'a.guide': text('t/a', ['step S', '  level 2'], ['next t/b']), 'b.guide': text('t/b', ['step S', '  level 3']) });
	assert.deepEqual(ok.errors, []);
});

test('`next` and every route option must be a guide the characters can follow: races, classes, and what each race can be', () => {
	const errorsOf = (fromExtra, toExtra) => {
		const from = text('t/a', ['step S', '  level 2'], [...fromExtra, 'next t/b, t/c']);
		const r = compile({ 'a.guide': from, 'b.guide': text('t/b', ['step S', '  level 3']), 'c.guide': text('t/c', ['step S', '  level 3'], toExtra) });
		return r.diag.errors.map((d) => `${d.line === lineOf(from, 'next t/b, t/c') ? 'next' : d.line}: ${d.message}${d.hint ? ` | ${d.hint}` : ''}`);
	};
	assert.deepEqual(errorsOf(['race Human'], ['race Dwarf, Gnome']), [
		'next: no Human character can follow t/c (it is for Dwarf/Gnome only) | pick a guide for the same races: `polestar find --kind guide <zone> --race Human`',
	]);
	// A faction-wide target, or one sharing a race, is fine.
	assert.deepEqual(errorsOf(['race Human'], []), []);
	assert.deepEqual(errorsOf(['race Human, Dwarf'], ['race Dwarf, Gnome']), []);
	// Classes alone.
	assert.deepEqual(errorsOf(['class Paladin'], ['class Mage, Warlock']), [
		'next: no Alliance Paladin character can follow t/c (it is for Alliance Mage/Warlock only) | pick a guide for the same classes: `polestar find --kind guide <zone> --class Paladin`',
	]);
	assert.deepEqual(errorsOf(['class Paladin'], []), []);
	assert.deepEqual(errorsOf(['class Paladin, Mage'], ['class Mage']), []);
	// A Human cannot be a Shaman (races.json), so a Shaman guide is no option.
	assert.deepEqual(errorsOf(['race Human'], ['class Shaman']), [
		'next: no Human character can follow t/c (it is for Alliance Shaman only) | pick a guide for the same races: `polestar find --kind guide <zone> --race Human`',
	]);
	assert.deepEqual(errorsOf(['race Dwarf'], ['class Shaman']), []);
});

test('ids unknown in data are errors without a name and warnings with one', () => {
	const src = guideText(['step S', '  accept 424242', '  accept 424243 "New Forever Quest"', '  kill 77777', '  kill 77778 "Sky Raider" @50,50', '  collect 88888', '  interact 99999 "Odd Totem" @1,1', '  talk 66666']);
	const r = compile(src);
	assert.deepEqual(only(r.errors, /not in data/), [
		`test.guide:${lineOf(src, '  accept 424242')}: quest 424242 is not in data; give its title: \`accept 424242 "Title"\``,
		`test.guide:${lineOf(src, '  kill 77777')}: npc 77777 is not in data; give its name: \`kill 77777 "Target name"\``,
		`test.guide:${lineOf(src, '  collect 88888')}: item 88888 is not in data; give its name: \`collect 88888 "Item name"\``,
		`test.guide:${lineOf(src, '  talk 66666')}: npc 66666 is not in data; give its name: \`talk 66666 "NPC name"\``,
	]);
	assert.deepEqual(only(r.warnings, /not in data; using the explicit/), [
		`test.guide:${lineOf(src, '  accept 424243 "New Forever Quest"')}: quest 424243 is not in data; using the explicit title (new Forever content?)`,
		`test.guide:${lineOf(src, '  kill 77778 "Sky Raider" @50,50')}: npc 77778 is not in data; using the explicit name (new Forever content?)`,
		`test.guide:${lineOf(src, '  interact 99999 "Odd Totem" @1,1')}: object 99999 is not in data; using the explicit name (new Forever content?)`,
	]);
});

test('turnin, complete and objective goals need an earlier accept in the guide', () => {
	const src = guideText(['step S', '  turnin 783', '  complete 7', '  kill 6 quest 7', '  accept 7', '  turnin 7', '  accept 783']);
	const r = compile(src);
	assert.deepEqual(only(r.errors, /never accepted/), [
		`test.guide:${lineOf(src, '  turnin 783')}: \`turnin\` for quest 783 that is never accepted earlier in this guide or a guide chaining into it`,
		`test.guide:${lineOf(src, '  complete 7')}: \`complete\` for quest 7 that is never accepted earlier in this guide or a guide chaining into it`,
		`test.guide:${lineOf(src, '  kill 6 quest 7')}: \`kill\` for quest 7 that is never accepted earlier in this guide or a guide chaining into it`,
	]);
});

// Issue #108: quests handed in straight from the NPC's window, with no accept
// (Distracting Jarven 308, the repeat cloth donations).
test('#108: a `direct` turn-in needs no accept, and is checked for availability and prerequisites as an accept is', () => {
	assert.deepEqual(compile(guideText(['step S', '  turnin 783 direct'])).errors, []);

	// 9100 is Orc-only, so no character of this Alliance guide can be offered it.
	const race = compile(guideText(['step S', '  turnin 9100 direct']));
	assert.deepEqual(only(race.errors, /not available/), [
		'test.guide:8: quest 9100 (Orcish Errand) is not available to any race this step applies to',
	]);

	// 7 needs 783 turned in first, and the chain never turns it in.
	const pre = compile(guideText(['step S', '  turnin 7 direct']));
	assert.deepEqual(only(pre.warnings, /turned in first/), [
		'test.guide:8: quest 7 needs 783 (A Threat Within) turned in first, but the chain never turns it in',
	]);
});

test('#108: `direct` contradicts an earlier accept, and a `direct` quest carries no objectives', () => {
	const both = guideText(['step S', '  accept 783', '  turnin 783 direct']);
	assert.deepEqual(only(compile(both).errors, /direct/), [
		`test.guide:${lineOf(both, '  turnin 783 direct')}: \`turnin\` for quest 783 is marked \`direct\`, but the chain accepts that quest earlier: drop \`direct\``,
	]);

	// The item the hand-in asks for is a plain buy/collect: nothing tracks an
	// objective of a quest that never enters the log. The goals come before the
	// turn-in here, as they would in a guide, and still name the right reason.
	const tracked = guideText(['step S', '  complete 783', '  collect 2589 quest 783', '  turnin 783 direct']);
	const why = 'which is handed in directly (`turnin 783 direct`): it is never in the quest log, so nothing tracks its objectives. Get what it asks for with a plain `buy` or `collect`, without `quest`';
	assert.deepEqual(only(compile(tracked).errors, /handed in directly/), [
		`test.guide:${lineOf(tracked, '  complete 783')}: \`complete\` for quest 783 (A Threat Within), ${why}`,
		`test.guide:${lineOf(tracked, '  collect 2589 quest 783')}: \`collect\` for quest 783 (A Threat Within), ${why}`,
	]);
});

// 9390 is shaped like Distracting Jarven (308) and Additional Runecloth: a
// repeatable quest its giver also takes back; 9391 a repeatable with another ender.
function repeatableData() {
	const base = fixtureData();
	const q = (id, end) => ({ id, title: `Quest ${id}`, level: 2, minLevel: 1, races: null, classes: null, start: { npc: [823], object: [], item: [] }, end: { npc: [end], object: [] }, pre: [], excl: [], objectives: [], repeatable: true });
	const quests = { ...base.quests, 9390: q(9390, 823), 9391: q(9391, 197) };
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

test('#108: a plain turn-in never accepted, of a repeatable its giver takes back, hints at `direct`', () => {
	const hints = (id) => compile(guideText(['step S', `  turnin ${id}`]), repeatableData()).diag.errors.map((d) => d.hint);
	assert.deepEqual(hints(9390), ['a repeatable quest its giver takes back straight from the quest window: write `turnin <id> direct`']);
	assert.deepEqual(hints(9391), [undefined]);
	assert.deepEqual(hints(783), [undefined]);
});

test('an accept in a guide that chains into this one (even indirectly) satisfies a later turn-in; an unrelated guide does not', () => {
	const first = text('t/one', ['step S', '  accept 33'], ['next t/two']);
	const middle = text('t/two', ['step S', '  level 3'], ['next t/three']);
	const last = text('t/three', ['step S', '  collect 750 quest 33', '  turnin 33']);
	assert.deepEqual(compile({ '1.guide': first, '2.guide': middle, '3.guide': last }).errors, []);
	const unrelated = text('t/one', ['step S', '  accept 33']);
	const r = compile({ '1.guide': unrelated, '3.guide': last });
	assert.deepEqual(r.errors.map((e) => e.replace(/:.*?: /, ': ')), [
		'3.guide: `collect` for quest 33 that is never accepted earlier in this guide or a guide chaining into it',
		'3.guide: `turnin` for quest 33 that is never accepted earlier in this guide or a guide chaining into it',
	]);
});

test('accepting a quest no applicable character can take is an error', () => {
	// 9100 is Orc-only (race mask 2); 9101 is Hunter-only (class mask 4).
	const alliance = guideText(['step S', '  accept 9100']);
	assert.match(compile(alliance).errors.join('\n'), new RegExp(`test.guide:${lineOf(alliance, '  accept 9100')}: quest 9100 \\(Orcish Errand\\) is not available to any race this step applies to`));
	const horde = text('t/h', ['step S', '  accept 9100']).replace('faction Alliance', 'faction Horde');
	assert.deepEqual(compile(horde).errors, []);

	const warriors = text('t/w', ['step S', '  accept 9101'], ['class Warrior']);
	assert.match(compile(warriors).errors.join('\n'), /quest 9101 \(Hunter Training\) is not available to any class this step applies to/);
	const notHunters = guideText(['step S', '  only !Hunter', '  accept 9101']);
	assert.match(compile(notHunters).errors.join('\n'), /quest 9101 .* not available to any class this step applies to/);
	const goalOnly = guideText(['step S', '  accept 9101 only Warrior']);
	assert.match(compile(goalOnly).errors.join('\n'), /not available to any class this goal applies to/);
	assert.deepEqual(compile(guideText(['step S', '  accept 9101 only Hunter'])).errors, []);
	assert.deepEqual(compile(guideText(['step S', '  accept 9101'])).errors, []);
});

// The fixture data plus quests shaped like QuestieDB's: 9300 lists only its
// breadcrumbs in `pre` (6061 Taming the Beast: pre = its three class
// breadcrumbs), 9310 needs both 9311 and 9312 (preAll), 9320 either (preAny).
// 9330 is 788 Cutting Teeth (pre 9331 or its breadcrumb 9332), 9340 is 813
// Finding the Antidote (pre = its parent 9341), 9350 is 786 (pre 9351, which
// nobody can start). 9370 is 526 Lightforge Ingots: closed one way by 9371
// (its `excl`, like 324), while 9371 has no `excl`.
function prereqData() {
	const { Data } = require('../tools/lib/dsl/data');
	const { fixtureData } = require('./helpers/dsl');
	const base = fixtureData();
	const q = (id, extra) => ({ id, title: `Quest ${id}`, level: 2, minLevel: 1, races: null, classes: null, start: { npc: [823], object: [], item: [] }, end: { npc: [823], object: [] }, pre: [], excl: [], objectives: [], ...extra });
	const quests = {
		...base.quests,
		9300: q(9300, { pre: [9301, 9302], breadcrumbs: [9301] }),
		9301: q(9301, { breadcrumbFor: 9300 }),
		9302: q(9302, { breadcrumbFor: 9300 }),
		9310: q(9310, { pre: [9311, 9312], preAll: [9311, 9312] }),
		9311: q(9311),
		9312: q(9312),
		9320: q(9320, { pre: [9321, 9322], preAny: [9321, 9322] }),
		9321: q(9321),
		9322: q(9322),
		9330: q(9330, { pre: [9331, 9332], breadcrumbs: [9332] }),
		9331: q(9331),
		9332: q(9332),
		9340: q(9340, { pre: [9341], parent: 9341 }),
		9341: q(9341),
		9350: q(9350, { pre: [9351] }),
		9351: q(9351, { start: { npc: [], object: [], item: [] } }),
		9360: q(9360, { excl: [9361] }),
		9361: q(9361, { excl: [9360] }),
		9370: q(9370, { excl: [9371] }),
		9371: q(9371),
	};
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

test('prerequisites: breadcrumbs never block; preAll needs every one, preAny one', () => {
	const data = prereqData();
	const crumbs = guideText(['step S', '  accept 9300']);
	const r = compile(crumbs, data);
	assert.deepEqual(only(r.warnings, /needs/), []);
	const goal = r.guides[0].steps[0].goals[0];
	assert.equal(goal.pre, undefined, 'breadcrumbs are not compiled as prerequisites');

	const all = guideText(['step S', '  accept 9311', '  turnin 9311', '  accept 9310']);
	const ra = compile(all, data);
	assert.deepEqual(only(ra.warnings, /needs/), [`test.guide:${lineOf(all, '  accept 9310')}: quest 9310 needs 9312 (Quest 9312) turned in first, but the chain never turns it in`]);
	assert.deepEqual(ra.guides[0].steps[0].goals[2].preAll, [9311, 9312]);

	const any = guideText(['step S', '  accept 9321', '  turnin 9321', '  accept 9320']);
	const rn = compile(any, data);
	assert.deepEqual(only(rn.warnings, /needs/), []);
	assert.deepEqual(rn.guides[0].steps[0].goals[2].pre, [9321, 9322]);

	for (const id of [9330, 9340, 9350]) {
		const r2 = compile(guideText(['step S', `  accept ${id}`]), data);
		assert.deepEqual(only(r2.warnings, /needs/), [], `quest ${id}`);
		assert.equal(r2.guides[0].steps[0].goals[0].pre, undefined, `quest ${id}`);
	}
});

test('an accept compiles `closedBy`: the quest its breadcrumb leads to and its exclusive group, titled for the reason text', () => {
	const data = prereqData();
	const r = compile(guideText(['step S', '  accept 9301', '  accept 9360', '  accept 9311']), data);
	const [crumb, exclusive, plain] = r.guides[0].steps[0].goals;
	assert.deepEqual([crumb.closedBy, crumb.preTitles], [[9300], { 9300: 'Quest 9300' }]);
	assert.deepEqual([exclusive.closedBy, exclusive.preTitles], [[9361], { 9361: 'Quest 9361' }]);
	assert.equal(plain.closedBy, undefined);
});

test('coordinates outside 0-100 are errors', () => {
	const src = guideText(['step S', '  goto 101,5', '  kill 6 @-1,50', '  goto 100,0']);
	assert.deepEqual(compile(src).errors, [
		`test.guide:${lineOf(src, '  goto 101,5')}: coordinates 101,5 are outside 0-100`,
		`test.guide:${lineOf(src, '  kill 6 @-1,50')}: coordinates -1,50 are outside 0-100`,
	]);
});

test('an accept whose prerequisite is never turned in earlier in the chain warns', () => {
	const src = guideText(['step S', '  accept 9200']);
	assert.deepEqual(only(compile(src).warnings, /needs 9201/), [`test.guide:${lineOf(src, '  accept 9200')}: quest 9200 needs 9201 (The First Step) turned in first, but the chain never turns it in`]);
	const chained = compile({
		'1.guide': text('t/one', ['step S', '  accept 9201', '  turnin 9201'], ['next t/two']),
		'2.guide': text('t/two', ['step S', '  accept 9200']),
	});
	assert.deepEqual(only(chained.warnings, /turned in first/), []);
});

test('an accept above the level the route plausibly reaches warns; a level goal or earlier XP silences it', () => {
	const src = guideText(['step S', '  accept 9300']);
	assert.deepEqual(only(compile(src).warnings, /plausibly/), [`test.guide:${lineOf(src, '  accept 9300')}: quest 9300 needs level 20, but the route plausibly reaches only level 1 here`]);
	assert.deepEqual(only(compile(guideText(['step S', '  level 20', '  accept 9300'])).warnings, /plausibly/), []);
	// 783 + 33 turned in: (80 + 250) quest XP, doubled for kills along the way -> level 2 (400 XP needed).
	assert.deepEqual(only(compile(guideText(['step S', '  accept 783', '  turnin 783', '  accept 33', '  turnin 33', '  accept 9400'])).warnings, /plausibly/), []);
	assert.equal(only(compile(guideText(['step S', '  accept 9400'])).warnings, /plausibly/).length, 1);
	// The entry level of a chained guide is the best exit of its predecessors.
	const chain = compile({
		'1.guide': text('t/one', ['step S', '  level 20'], ['next t/two']),
		'2.guide': text('t/two', ['step S', '  accept 9300']),
	});
	assert.deepEqual(only(chain.warnings, /plausibly/), []);
});

test('explicit coordinates far from every known spawn of the entity warn', () => {
	const src = guideText(['step S', '  talk 823 @48.2,42.9', '  talk 823 @60,60', '  kill 1423 @60,70 map 1453', '  kill 1423 @10,10 map 1411']);
	assert.deepEqual(only(compile(src).warnings, /explicit coordinates/), [
		`test.guide:${lineOf(src, '  talk 823 @60,60')}: explicit coordinates 60,60 are more than 50 yards from every known spawn of npc 823`,
		`test.guide:${lineOf(src, '  kill 1423 @10,10 map 1411')}: explicit coordinates 10,10: npc 1423 has no known spawn on map 1411`,
	]);
});

test('objective-capable goals without coordinates warn', () => {
	const src = guideText(['step S', '  use 6948', '  kill "Wandering Ghost"', '  kill "Placed Ghost" @20,20', '  kill 6']);
	assert.deepEqual(only(compile(src).warnings, /no coordinates/), [
		`test.guide:${lineOf(src, '  use 6948')}: \`use\` has no coordinates (no known spawns; add @x,y)`,
		`test.guide:${lineOf(src, '  kill "Wandering Ghost"')}: \`kill\` has no coordinates (no known spawns; add @x,y)`,
	]);
});

test('the fixture guide set is valid: no errors, and no warnings but its goto before the kobolds', () => {
	const fs = require('node:fs');
	const path = require('node:path');
	const { GUIDES_DIR } = require('./helpers/dsl');
	const { findGuideFiles } = require('../tools/lib/dsl/project');
	const files = findGuideFiles(GUIDES_DIR);
	assert.deepEqual(files, ['forever/alliance/human/01-northshire.guide', 'forever/alliance/human/02-elwynn.guide']);
	const r = compile(Object.fromEntries(files.map((f) => [f, fs.readFileSync(path.join(GUIDES_DIR, f), 'utf8')])));
	// The fixture keeps a `goto` before its kill so the engine's goto steps stay covered.
	assert.equal(r.warnings.length, 1);
	assert.match(r.warnings[0], /^forever\/alliance\/human\/01-northshire\.guide:19: `goto 47\.6,35\.1` "Kobold camp" sends the player where `kill Kobold Vermin` \(line 20\) already leads, \d+ yards away$/);
	assert.deepEqual(r.errors, []);
});

test('a bare unknown npc id on train or vendor is an error; a quoted name makes it a warning', () => {
	const src = guideText(['step S', '  train 77777', '  vendor 77778', '  train 77779 "Sky Trainer"', '  sethome "Somewhere" npc 77780']);
	const r = compile(src);
	assert.deepEqual(r.errors, [
		`test.guide:${lineOf(src, '  train 77777')}: npc 77777 is not in data; give its name: \`train 77777 "NPC name"\``,
		`test.guide:${lineOf(src, '  vendor 77778')}: npc 77778 is not in data; give its name: \`vendor 77778 "NPC name"\``,
	]);
	assert.match(r.warnings.join('\n'), /test\.guide:10: npc 77779 is not in data; using the explicit name/);
	// `npc <id>` modifiers cannot carry a name, so they only warn.
	assert.match(r.warnings.join('\n'), /test\.guide:11: npc 77780 is not in data; its name and position cannot be filled/);
});

test('an accept closed by an exclusive quest taken earlier in the chain warns', () => {
	const data = prereqData();
	const first = text('t/one', ['step S', '  accept 9371', '  turnin 9371'], ['next t/two']);
	const second = text('t/two', ['step S', '  accept 9370', '  turnin 9370']);
	const msg = 'quest 9370 (Quest 9370) is not offered once 9371 (Quest 9371) is in the log or done, and the chain takes that quest earlier';
	assert.deepEqual(only(compile({ '1.guide': first, '2.guide': second }, data).warnings, /not offered/), [`2.guide:${lineOf(second, '  accept 9370')}: ${msg}`]);
	const same = guideText(['step S', '  accept 9371', 'step T', '  accept 9370', '  turnin 9371', '  turnin 9370']);
	assert.deepEqual(only(compile(same, data).warnings, /not offered/), [`test.guide:${lineOf(same, '  accept 9370')}: ${msg}`]);
	// Near misses: unrelated guides, the one-way direction, characters that never meet.
	assert.deepEqual(only(compile({ '1.guide': text('t/one', ['step S', '  accept 9371', '  turnin 9371']), '2.guide': second }, data).warnings, /not offered/), []);
	assert.deepEqual(only(compile(guideText(['step S', '  accept 9370', '  accept 9371', '  turnin 9370', '  turnin 9371']), data).warnings, /not offered/), []);
	const split = guideText(['step S', '  accept 9371 only Human', '  turnin 9371 only Human', '  accept 9370 only Dwarf', '  turnin 9370 only Dwarf']);
	assert.deepEqual(only(compile(split, data).warnings, /not offered/), []);
});

test('an accept that is never turned in later on the route warns, per route choice', () => {
	const start = text('t/one', ['step S', '  accept 33', '  accept 7', '  accept 783 optional'], ['next t/two, t/three']);
	const two = text('t/two', ['step S', '  turnin 33', '  turnin 7'], ['pitch Two']);
	const three = text('t/three', ['step S', '  turnin 33'], ['pitch Three']);
	assert.deepEqual(only(compile({ '1.guide': start, '2.guide': two, '3.guide': three }).warnings, /never turned in/), [
		`1.guide:${lineOf(start, '  accept 7')}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in on the route through "t/three"`,
	]);
	// A turn-in deeper on the route counts; one on every route after a later choice too.
	const deep = { '1.guide': text('t/one', ['step S', '  accept 7'], ['next t/two']), '2.guide': text('t/two', ['step S', '  level 2'], ['next t/three']), '3.guide': text('t/three', ['step S', '  turnin 7']) };
	assert.deepEqual(only(compile(deep).warnings, /never turned in/), []);
	const lone = guideText(['step S', '  turnin 33', '  accept 7', '  accept 33']);
	assert.deepEqual(only(compile(lone).warnings, /never turned in/), [
		`test.guide:${lineOf(lone, '  accept 7')}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it`,
		`test.guide:${lineOf(lone, '  accept 33')}: quest 33 (Wolves Across the Border) is accepted but never turned in later in this guide or a guide after it`,
	]);
	// `only`: a turn-in for some of the characters leaves the rest.
	const part = guideText(['step S', '  accept 7', '  turnin 7 only Human']);
	assert.deepEqual(only(compile(part).warnings, /never turned in/), [`test.guide:${lineOf(part, '  accept 7')}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it for some of the characters it applies to`]);
	assert.deepEqual(only(compile(guideText(['step S', '  accept 7 only Human', '  turnin 7 only Human'])).warnings, /never turned in/), []);
});

test('a next guide whose races leave out the characters says why its turn-ins do not count; the warning has a hint', () => {
	const one = text('t/one', ['step S', '  accept 7'], ['race Human, Dwarf', 'next t/two']);
	const two = text('t/two', ['step S', '  turnin 7'], ['race Dwarf']);
	const r = compile({ '1.guide': one, '2.guide': two });
	const warns = r.diag.warnings.filter((d) => /never turned in/.test(d.message));
	assert.deepEqual(
		warns.map((d) => [d.line, d.message, d.hint]),
		[
			[
				lineOf(one, '  accept 7'),
				'quest 7 (Kobold Camp Cleanup) is accepted but never turned in later in this guide or a guide after it for some of the characters it applies to ("t/two" is for Dwarf only, so its turn-ins do not count)',
				'turn it in later in this guide, or pick a `next` guide these characters can follow, or make the accept `optional` when the player may leave it',
			],
		],
	);
	// Per route: the route through a Dwarf guide says so; a plain miss does not.
	const choice = text('t/one', ['step S', '  accept 7'], ['race Human, Dwarf', 'next t/two, t/three']);
	const three = text('t/three', ['step S', '  turnin 7'], ['pitch Three']);
	const split = compile({ '1.guide': choice, '2.guide': text('t/two', ['step S', '  turnin 7'], ['race Dwarf', 'pitch Two']), '3.guide': three });
	assert.deepEqual(only(split.warnings, /never turned in/), [
		`1.guide:${lineOf(choice, '  accept 7')}: quest 7 (Kobold Camp Cleanup) is accepted but never turned in on the route through "t/two" for some of the characters it applies to (it is for Dwarf only, so its turn-ins do not count)`,
	]);
	const lone = compile(guideText(['step S', '  accept 7'])).diag.warnings.find((d) => /never turned in/.test(d.message));
	assert.equal(lone.hint, 'turn it in later in this guide or in a guide after it, or make the accept `optional` when the player may leave it');
});

test('an objective index past the quest\'s objectives names them, with a hint', () => {
	const src = guideText(['step S', '  accept 7', '  kill 6 quest 7.2', '  turnin 7']);
	const d = compile(src).diag.warnings.find((x) => /objective\(s\) in data/.test(x.message));
	assert.equal(d.line, lineOf(src, '  kill 6 quest 7.2'));
	assert.equal(d.message, 'quest 7 has 1 objective(s) in data, not 2: 7.1 = kill Kobold Vermin x10');
	assert.equal(d.hint, 'write `quest 7.<n>` with one of these (`polestar find 7` lists them)');
});

// A quest with two item objectives, to name the wrong one by index.
function twoItemData() {
	const base = fixtureData();
	const items = {
		...base.items,
		95100: { id: 95100, name: 'Elite Tusk', drops: { npc: { 95003: 60 }, object: {} }, vendors: [] },
		95101: { id: 95101, name: 'Kobold Tusk', drops: { npc: { 95003: 60, 95002: 10 }, object: {} }, vendors: [] },
	};
	const quests = {
		...base.quests,
		9700: { ...base.quests[7], id: 9700, title: 'Tusks', pre: [], objectives: [{ type: 'item', id: 95100, count: 6 }, { type: 'item', id: 95101, count: 3 }] },
	};
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

test('an objective index that names another objective of the quest is an error that says which index is the item\'s', () => {
	const src = guideText(['step S', '  accept 9700', '  collect 95101 quest 9700.1', '  collect 95100 quest 9700.1', '  turnin 9700']);
	const r = compile(src, twoItemData());
	assert.equal(r.diag.warnings.filter((x) => /9700\.1 is/.test(x.message)).length, 0, 'a swapped index is not only a warning');
	const d = r.diag.errors.filter((x) => /9700\.1 is/.test(x.message));
	assert.equal(d.length, 1, 'only the line whose item is not objective 1');
	assert.equal(d[0].line, lineOf(src, '  collect 95101 quest 9700.1'));
	assert.equal(d[0].message, 'quest 9700.1 is collect Elite Tusk x6, not this item; Kobold Tusk is 9700.2');
	assert.equal(d[0].hint, 'write `quest 9700.2`, or `quest 9700` to take the index from the item');
});

test('`complete` on a quest without objectives warns: the turn-in is the action', () => {
	const src = guideText(['step S', '  accept 783', '  accept 7', '  complete 783', '  complete 7', '  turnin 783', '  turnin 7']);
	assert.deepEqual(only(compile(src).warnings, /no objectives/), [
		`test.guide:${lineOf(src, '  complete 783')}: \`complete\` for quest 783 (A Threat Within), which has no objectives: the action is the turn-in; use \`turnin\``,
	]);
});

// The fixture data plus elite work: 95003 Elite Kobold (rank 1, hostile) is
// already there; 95030 is a friendly rank-1 talk credit (like 8479 Kalaran
// Windblade); item 95100 drops only from the Elite Kobold, 95101 also from a
// normal kobold; quest 9380 collects 95100 as an objective.
function eliteData() {
	const { Data } = require('../tools/lib/dsl/data');
	const { fixtureData } = require('./helpers/dsl');
	const base = fixtureData();
	const npcs = { ...base.npcs, 95030: { id: 95030, name: 'Friendly Sage', level: 55, rank: 1, faction: 'AH', spawns: { 1429: { f: 'e', pts: [[40, 40]] } } } };
	const items = {
		...base.items,
		95100: { id: 95100, name: 'Elite Tusk', drops: { npc: { 95003: 60 }, object: {} }, vendors: [] },
		95101: { id: 95101, name: 'Kobold Tusk', drops: { npc: { 95003: 60, 95002: 10 }, object: {} }, vendors: [] },
	};
	const quests = { ...base.quests, 9380: { ...base.quests[7], id: 9380, title: 'Tusk Hunt', objectives: [{ type: 'item', id: 95100, count: 3, text: 'Elite Tusk' }] } };
	return new Data({ quests, npcs, objects: base.objects, items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

const ELITE_TIP = (target) => `in a Leveling guide make the goal \`optional\` with the tip "${target} is elite: grouping up is advised."`;

test('elite work in a Leveling guide: killing a hostile elite is an error unless optional or friendly', () => {
	const data = eliteData();
	const src = guideText(['step S', '  kill 95003', '  kill 95003 optional', '  kill 95030', '  kill 95002']);
	assert.deepEqual(only(compile(src, data).errors, /elite/), [`test.guide:${lineOf(src, '  kill 95003')}: \`kill\` npc 95003 (Elite Kobold) is elite; ${ELITE_TIP('Elite Kobold')}`]);
	const dungeon = guideText(['guide t/d', 'title D', 'faction Alliance', 'category Dungeons', '', 'step S', '  kill 95003']);
	assert.deepEqual(only(compile(dungeon, data).errors, /elite/), []);
});

test('elite work in a Leveling guide: collecting an item only elites drop is an error', () => {
	const data = eliteData();
	const src = guideText(['step S', '  accept 9380', '  collect 95100 x3', '  collect 95100 x3 quest 9380.1', '  collect 95100 x3 optional', '  collect 95101 x3', '  turnin 9380']);
	const tip = ELITE_TIP('Elite Kobold');
	assert.deepEqual(only(compile(src, data).errors, /elite/), [
		`test.guide:${lineOf(src, '  collect 95100 x3')}: \`collect\` item 95100 (Elite Tusk) drops only from elites (Elite Kobold); ${tip}`,
		`test.guide:${lineOf(src, '  collect 95100 x3 quest 9380.1')}: \`collect\` item 95100 (Elite Tusk) drops only from elites (Elite Kobold); ${tip}`,
	]);
	const reputation = guideText(['guide t/r', 'title R', 'faction Alliance', 'category Reputation', '', 'step S', '  collect 95100 x3']);
	assert.deepEqual(only(compile(reputation, data).errors, /elite/), []);
});

test('solo policy: goals on quests the simulator excludes are errors when elite, else warnings, unless optional', () => {
	const { validateSoloPolicy } = require('../tools/lib/dsl/validate');
	const excluded = {
		Alliance: new Map([
			[7, { id: 7, title: 'Kobold Camp Cleanup', reason: 'elite kill objective npc 95003', category: 'elite' }],
			[33, { id: 33, title: 'Wolves Across the Border', reason: 'profession' }],
			[783, { id: 783, title: 'A Threat Within', reason: 'seasonal event' }],
		]),
	};
	const check = (src) => {
		const r = compile(src, eliteData());
		validateSoloPolicy(r.guides, excluded, r.diag);
		return r.diag.sorted().filter((d) => /elite|solo/.test(d.message)).map((d) => `${d.line}: ${d.severity}: ${d.message}`);
	};
	const src = guideText(['step S', '  accept 7', '  kill 95003 quest 7', '  kill 6 quest 7', '  turnin 7 optional', '  accept 33', '  accept 783']);
	const quest = `quest 7 (Kobold Camp Cleanup) is elite (solo filter: elite kill objective npc 95003); ${ELITE_TIP('Kobold Camp Cleanup')}`;
	assert.deepEqual(check(src), [
		`${lineOf(src, '  accept 7')}: error: ${quest}`,
		// Reported once: as the elite kill, not again for its quest.
		`${lineOf(src, '  kill 95003 quest 7')}: error: \`kill\` npc 95003 (Elite Kobold) is elite; ${ELITE_TIP('Elite Kobold')}`,
		`${lineOf(src, '  kill 6 quest 7')}: error: ${quest}`,
		`${lineOf(src, '  accept 33')}: warning: quest 33 (Wolves Across the Border) is excluded from solo leveling (profession: profession); make the goal \`optional\``,
	]);
	// Other categories than Leveling are not solo routes.
	assert.deepEqual(check(guideText(['guide t/p', 'title P', 'faction Alliance', 'category Professions', '', 'step S', '  accept 7'])), []);
});

test('#108: solo policy: a `direct` turn-in of a repeatable is no grind; it does not need `optional`', () => {
	const { validateSoloPolicy } = require('../tools/lib/dsl/validate');
	const excluded = { Alliance: new Map([[9390, { id: 9390, title: 'Quest 9390', reason: 'repeatable without a recorded reward (no XP)', category: 'repeatable' }]]) };
	const check = (line) => {
		const r = compile(guideText(['step S', line]), repeatableData());
		validateSoloPolicy(r.guides, excluded, r.diag);
		return r.diag.warnings.filter((d) => /solo/.test(d.message)).length;
	};
	assert.equal(check('  turnin 9390 direct'), 0);
	assert.equal(check('  accept 9390'), 1, 'an accepted repeatable still warns');
});

test('lint applies the solo policy from the cached world in --sim (built from the same data by the current builder)', () => {
	const fs = require('node:fs');
	const path = require('node:path');
	const { polestar } = require('./helpers/cli');
	const { GUIDES_DIR, DATA_DIR } = require('./helpers/dsl');
	const { tmpdir } = require('./helpers/tmp');
	const { dataHash } = require('../tools/lib/sim/world');
	const { ROOT } = require('../tools/lib/paths');
	const sim = tmpdir();
	const hash = dataHash(DATA_DIR, path.join(ROOT, 'data', 'sources'));
	fs.writeFileSync(path.join(sim, 'world-alliance.json'), JSON.stringify({ dataHash: hash, excluded: [{ id: 5261, title: 'Eagan Peltskinner', reason: 'dungeon quest', category: 'dungeon' }] }));
	const lint = (...args) => polestar(['lint', '--guides', GUIDES_DIR, '--data', DATA_DIR, ...args]);
	const r = lint('--sim', sim);
	assert.equal(r.status, 0, r.stderr);
	assert.match(r.stderr, /01-northshire\.guide:14: warning: quest 5261 \(Eagan Peltskinner\) is excluded from solo leveling \(dungeon: dungeon quest\)/);
	// Without --sim, other data never reads the default cache.
	assert.doesNotMatch(lint().stderr, /excluded from solo/);
});
