'use strict';
// Player-reported guide fixes: the Alliance 50-60 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	at, compiled, everyone, goals, is, located, lvlOf, OFFICIAL_DIR, ROOT, skip,
} = require('./helpers');

// --- Alliance 50-60 quest volume (2026-11-08): quests on stops the route already makes, counted as part of
// the route (not optional) where every solo player gets them; the group-only follow-ups stay behind `when group`.
const ALLIANCE_5060_VOLUME = {
	'forever/alliance/50-60/01-burning-steppes.guide': [8250, 8251, 8252], // Magecraft; Magic Dust; The Siren's Coral (Mages)
	'forever/alliance/50-60/02-felwood.guide': [939], // Flute of Xavaric
	'forever/alliance/50-60/03-winterspring.guide': [5083], // Winterfall Firewater
	'forever/alliance/50-60/04-western-plaguelands.guide': [2844, 2845], // The Giant Guardian; Wandering Shay
	'forever/alliance/50-60/06-silithus.guide': [4441, 5084, 5085, 5086, 6185], // Felbound Ancients; Falling to Corruption; Mystery Goo; Toxic Horrors; The Eastern Plagues
};

// --- Found by Fitz (2026-11-06): after the Moonglade quests (Umber's Under the
// Chitin Was..., 1185) the Silithus guide hearthed everyone to Cenarion Hold, flew
// them to Rut'theran Village and sent them back into Moonglade for its flight
// path, 600 yards from Umber. The flight path comes straight after Umber,
// with no hearth or flight between, and its flight is the way on: straight to
// Rut'theran Village, so neither the flight path's step nor Erelas Ambersky's
// hand-in (4901) sends the player by Auberdine (its old way, the boat from there).
test("Fitz's find (2026-11-06): after the Moonglade quests the Silithus guide takes Moonglade's flight path without leaving Moonglade first", { skip }, () => {
	const guide = 'forever/alliance/50-60/06-silithus.guide';
	const list = goals(guide);
	const umber = at(list, `${guide}: Umber's hand-in of 1185`, is('turnin', 1185));
	const fp = list.findIndex(({ goal }, i) => i > umber && goal.t === 'getfp' && goal.location === 'Moonglade');
	assert.ok(fp > umber, `${guide}: Moonglade's flight path is learned after Umber`);
	for (const { goal, step } of list.slice(umber + 1, fp)) {
		assert.ok(goal.t !== 'hearth' && goal.t !== 'fly', `${guide}: "${step.title}" ${goal.t}s out of Moonglade before its flight path`);
		assert.ok(goal.map == null || goal.map === 1450, `${guide}: "${step.title}" leads to map ${goal.map}, not Moonglade`);
	}
	const hand = at(list, `${guide}: Erelas Ambersky's hand-in of 4901`, is('turnin', 4901));
	assert.ok(hand > fp, `${guide}: Rut'theran Village comes after Moonglade's flight path`);
	for (const { step } of [list[fp], list[hand]]) {
		const tip = [].concat(step.note || []).join(' ');
		assert.doesNotMatch(tip, /Auberdine/, `${guide}: "${step.title}" tip: ${tip}`);
	}
});

// Final route review 0.3.6 (Alliance 40-60): Of Lost Honor (5845) needs Of Forgotten Memories (5781), whose
// Mercutio Filthgorger is elite and optional. A solo player never has 5845, yet the walk to its lake held
// them: across the Eastern Plaguelands and back to Egan for nothing. The walk is only for players with 5845.
test('Alliance 58-60: the walk to the lake for Of Lost Honor is only for players who have the quest', { skip }, () => {
	const guide = 'forever/alliance/50-60/06-silithus.guide';
	const list = goals(guide);
	const symbol = at(list, `${guide}: collect 14625 for 5845`, (g) => g.t === 'collect' && g.item === 14625);
	const walk = list.slice(0, symbol).reverse().find(({ goal }) => goal.t === 'goto');
	assert.ok(walk && walk.s >= list[symbol].s - 1, `${guide}: a walk leads to the lake`);
	assert.ok((walk.step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(5845)), `${guide}: "${walk.step.title}" waits for nobody without Of Lost Honor`);
});

// Final route review 0.3.6 (Alliance 55-57, found with the Horde reviewer): Gregan Brewspewer gives the Videre
// Elixir only as the reward of his own errand, The Videre Elixir (4041: an Evoroot from a ruined building north of
// Rockbiter); he sells none. The Feralas stop collected the elixir for Donova's quest (3909) without the errand, so
// the step could never complete. Gaeriyan (3912) is a ghost seen only after drinking one: the step says so.
test('Alliance 55-57: the Videre Elixir comes from Gregan\'s Evoroot errand, and Gaeriyan\'s step says to drink one', { skip }, () => {
	const guide = 'forever/alliance/50-60/04-western-plaguelands.guide';
	const list = goals(guide);
	const root = at(list, `${guide}: collect 11242`, (g) => g.t === 'collect' && g.item === 11242);
	const hand = at(list, `${guide}: turnin 4041`, is('turnin', 4041));
	const elixir = at(list, `${guide}: collect 11243`, (g) => g.t === 'collect' && g.item === 11243);
	assert.ok(root < hand && hand < elixir, `${guide}: Evoroot, hand-in (on the spot, #1699), then the elixir`);
	assert.ok(located(list[root]), `${guide}: the Evoroot has a place`);
	const shay = at(list, `${guide}: Shay's escort`, is('complete', 2845));
	assert.ok(root < at(list, `${guide}: accept 2845`, is('accept', 2845)) || root > shay, `${guide}: the Evoroot is not picked up during Shay's timed escort`);
	const gaeriyan = list[at(list, `${guide}: turnin 3912`, is('turnin', 3912))];
	assert.match([].concat(gaeriyan.step.note || []).join(' '), /Videre Elixir/, `${guide}: "${gaeriyan.step.title}" says to drink the elixir`);
});

// Flow review (2026-11-07): Alliance Felwood filled Laris's ooze jars on stops of their own on the way back south,
// though the southern loop's satyr and Jaedenar kills stand among the same oozes.
test('forever/alliance/50-60/02-felwood.guide: flow re-order: the ooze jars filled on the southern loop', { skip }, () => {
	const list = goals('forever/alliance/50-60/02-felwood.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const obj = (t, q, oi) => (g) => g.t === t && g.quest === q && g.oi === oi;
	assert.equal(stepOf('the Cursed Ooze jar', obj('collect', 4512, 1)), stepOf('the Felsworn (4421.1)', obj('kill', 4421, 1)), 'Cursed Oozes in Jadefire Glen');
	assert.equal(stepOf('the Tainted Ooze jar', obj('collect', 4512, 2)), stepOf('the hounds (5155.1)', obj('kill', 5155, 1)), 'Tainted Oozes in Jaedenar');
	assert.ok(stepOf('the Tainted Ooze jar', obj('collect', 4512, 2)) < stepOf('turnin 5155', is('turnin', 5155)), 'before the first Sanctuary hand-ins');
});

// Flow review (2026-11-07): Alliance Winterspring picked up one Kel'Theril relic fragment on the first pass by the lake
// and came back for the other three, and rode back to Light's Hope between Corin's Crossing and the west only to hand
// in Defenders of Darrowshire, though the guide ends at the chapel.
test("forever/alliance/50-60/03-winterspring.guide: flow re-order: the four relic fragments on one pass, Defenders of Darrowshire on the last Light's Hope stop", { skip }, () => {
	const list = goals('forever/alliance/50-60/03-winterspring.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const fragments = new Set(list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 5245).map((e) => e.s));
	assert.equal(fragments.size, 1, 'all four fragments in one step');
	assert.ok(!list.some(({ goal }) => goal.quest === 5211), 'Defenders of Darrowshire is left out (level tidy 0.4.0: Corin\'s Crossing\'s Scourge are 57-60 at 55)');
});

// Flow review (2026-11-07): Alliance Western Plaguelands fetched the Annals from Andorhal and came back to the same
// town for the Temporal Parasites on a later loop; Chromie takes both together.
test('forever/alliance/50-60/04-western-plaguelands.guide: flow re-order: the Temporal Parasites on the Annals visit to Andorhal', { skip }, () => {
	const list = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(stepOf('the parasites (4971)', (g) => g.t === 'kill' && g.quest === 4971), stepOf('the Annals (5154)', (g) => g.t === 'collect' && g.quest === 5154), 'one Andorhal visit');
});

// Flow review (2026-11-07): Alliance Silithus handed Noggle's Last Hope to Beetix with Noggle standing beside him and
// only took Noggle's Lost Satchel on the next Cenarion Hold stop.
test("forever/alliance/50-60/06-silithus.guide: flow re-order: Noggle's Lost Satchel taken beside Beetix", { skip }, () => {
	const list = goals('forever/alliance/50-60/06-silithus.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(stepOf('accept 8282', is('accept', 8282)), stepOf('turnin 8278', is('turnin', 8278)), 'on the same stop');
});

// Final route review, Alliance 40-60: the trip to Mountaineer Pebblebitty only for The Horn of the Beast's group; no
// along lists.
test('forever/alliance/50-60/01-burning-steppes.guide: final review: Pebblebitty only for the group, no along lists', { skip }, () => {
	const list = goals('forever/alliance/50-60/01-burning-steppes.guide');
	assert.ok(!list.some(({ step }) => step.along), 'no along lists');
	const trip = list.find(({ goal }) => goal.t === 'goto' && goal.map === 1432 && goal.x === 18.2);
	assert.ok(trip && (trip.step.when || []).some((w) => w.k === 'group' && [w.q].flat().includes(3181)), 'the Pebblebitty trip is the group\'s');
});

// Final route review, Alliance 40-60: Salfa where Timbermaw Hold's tunnel comes out (as on the Horde side); the western
// Winterfall camp a step, not lists.
test('forever/alliance/50-60/03-winterspring.guide: final review: Salfa where the tunnel comes out, no along lists', { skip }, () => {
	const list = goals('forever/alliance/50-60/03-winterspring.guide');
	const salfa = at(list, 'turnin 8465', is('turnin', 8465));
	assert.ok(salfa < at(list, 'accept 3783', is('accept', 3783)), 'before Everlook');
	assert.equal(list[salfa].s, list[at(list, 'accept 8464', is('accept', 8464))].s, 'Winterfall Activity taken there');
	assert.ok(!list.some(({ step }) => step.along), 'no along lists');
	const kills = new Set(list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 5082).map((e) => e.s));
	assert.equal(kills.size, 1, 'the western camp in one step');
});

// Final route review, Alliance 40-60: J.D. Collie stands 40 yd from Linken in Marshal's Refuge; A Gnome's Assistance was
// carried through Silithus. No along lists.
test('forever/alliance/50-60/04-western-plaguelands.guide: final review: J.D. Collie on the first refuge stop, no along lists', { skip }, () => {
	const list = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(stepOf('turnin 3941', is('turnin', 3941)), stepOf('turnin 3914', is('turnin', 3914)), 'beside Linken');
	assert.ok(!list.some(({ step }) => step.along), 'no along lists');
});

// Final route review, Alliance 40-60: class training sat in a step of its own before Stormwind (a tram ride to Ironforge
// and back), and the last city visit went Ironforge, Stormwind, Ironforge, Stormwind.
test('forever/alliance/50-60/06-silithus.guide: final review: Stormwind once and Ironforge once', { skip }, () => {
	const list = goals('forever/alliance/50-60/06-silithus.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const sw = stepOf('turnin 7793', is('turnin', 7793));
	assert.equal(stepOf('turnin 7795', is('turnin', 7795)), sw, 'the Runecloth donation on the same stop');
	assert.equal(stepOf('turnin 7791', is('turnin', 7791)), sw, 'the Wool donation on the same stop');
	assert.ok(sw < stepOf('turnin 4513', is('turnin', 4513)), 'then Ironforge');
	assert.equal(list.filter(({ goal }) => goal.t === 'fly' && /Stormwind/.test(goal.location || '')).length, 1, 'one flight to Stormwind');
});

// #934: Winterspring's "Level 55.05" top-up ground on "Timbermaw Mystic" during the Timbermaw quests; killing
// Timbermaw costs their reputation (Forever TDB creature_onkill_reputation: 11552 -25 with 576), and the
// point was a lone Winterfall Runner. The top-up now grinds the Winterfall camp by Frostfire Hot Springs
// (7441/7442 +5/+6 with 576).
test('#934: Winterspring (Alliance): the level 55.05 top-up grinds Winterfall furbolgs, never Timbermaw', { skip }, () => {
	const list = goals('forever/alliance/50-60/03-winterspring.guide');
	const top = list[at(list, 'level 55.05', (g) => g.t === 'level' && g.level === 55 && Math.abs((g.frac || 0) - 0.05) < 1e-9)];
	const arrow = list.find((g) => g.step === top.step && g.goal.t === 'goto');
	assert.ok(arrow && located(arrow), 'the top-up has a camp');
	assert.doesNotMatch(arrow.goal.text || '', /Timbermaw/, 'not a Timbermaw camp');
	assert.match(arrow.goal.text || '', /Winterfall/);
	assert.ok(Math.abs(arrow.goal.x - 31.4) < 2 && Math.abs(arrow.goal.y - 36) < 2, 'the Frostfire Hot Springs camp');
	for (const { step, goal } of list) {
		if (goal.t === 'goto' && step.goals.some((g) => g.t === 'level')) assert.doesNotMatch(goal.text || '', /Timbermaw/, `${step.label || step.title}: no top-up on Timbermaw`);
	}
});

// Final route review before 0.3.5, Alliance 40-60: the Burning Steppes topped up to 51.39 on the Dreadmaul Rock
// ogres on the way to Flame Crest, then rode back to the same ogres for a top-up to 52 right after the Flame Crest
// accepts. Nothing between gives experience: one top-up to 52 on the way (guide-fixes level record). Level tidy 0.4.0:
// the one top-up comes before Extinguish the Firegut's kills (the rock's Brutes are 52-53), on the Firegut Ogres.
test('forever/alliance/50-60/01-burning-steppes.guide: final review: one top-up to 52 at Dreadmaul Rock before its Brutes and Flame Crest, no ride back', { skip }, () => {
	const list = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const crest = at(list, 'accept 4726', is('accept', 4726));
	const kills = at(list, 'kill 7035 (Firegut Brute)', (g) => g.t === 'kill' && g.quest === 3823);
	const grinds = list.filter(({ goal }) => goal.t === 'level');
	assert.ok(grinds.some(({ goal, s }) => goal.level >= 52 && s < list[kills].s && s > list[at(list, 'accept 3823', is('accept', 3823))].s), 'the top-up to 52 comes right before the Dreadmaul kills');
	const after = list.findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === 4726);
	assert.ok(!grinds.some(({ s }) => s > list[crest].s && s < list[after].s), 'no top-up between the Flame Crest accepts and their hand-ins');
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 3823 && f.level === 52);
	assert.ok(rec, 'a level record keeps it on a refresh');
});

// Final route review before 0.3.5, Alliance 40-60: the 58 Light's Hope stop handed Villains of Darrowshire to Carlin
// Redpath, walked to Caretaker Alen, and came back to Carlin for Heroes of Darrowshire, under a tip from an older
// order ("ride on north to Chillwind Camp and fly to Light's Hope Chapel"). Carlin's hand-ins are one visit now.
test('forever/alliance/50-60/06-silithus.guide: final review: Carlin Redpath\'s two hand-ins in one visit, then Caretaker Alen', { skip }, () => {
	const list = goals('forever/alliance/50-60/06-silithus.guide');
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	const [villains, heroes, marauders, alen] = [idx('turnin', 5181), idx('turnin', 5168), idx('accept', 5206), idx('accept', 5281)];
	assert.ok(villains < heroes && heroes < marauders && marauders < alen, 'Carlin, Carlin, Carlin, then Alen');
	assert.equal(list[villains].s, list[alen].s, 'one Light\'s Hope stop');
	assert.ok(!list.slice(villains, alen + 1).some(({ step }) => /Chillwind/.test(step.note || '')), 'no tip about riding to Chillwind Camp');
});

// Final route review before 0.3.5, Alliance 40-60: after Winterspring's top-up to 55.05 (before the Everlook
// hand-ins) the guide still said "Short of level 54 after the yetis? Run the Sunken Temple" and "keep killing yetis
// until level 54: Harlo's wildkin quests are red before that" (Harlo's quests are in the last guide, at 58-59).
test('forever/alliance/50-60/03-winterspring.guide: final review: no level-54 advice after the top-up to 55', { skip }, () => {
	const list = goals('forever/alliance/50-60/03-winterspring.guide');
	const topUp = list.findIndex(({ goal }) => goal.t === 'level' && goal.level >= 55);
	assert.ok(topUp >= 0, 'the top-up to 55 is in the guide');
	const later = list.slice(topUp).filter(({ step }, i, a) => i === 0 || step !== a[i - 1].step).map(({ step }) => step);
	for (const step of later) {
		const text = [step.note || '', ...step.goals.filter((g) => g.t === 'note').map((g) => g.text)].join(' ');
		assert.doesNotMatch(text, /level 54\b/, `"${step.title}" asks for a level the player already has`);
	}
});

// Final route review before 0.3.5, Alliance 40-60: texts in the last guide from an older order. The Felwood stop
// said to ride out of Astranaar (the route flies to Talrendis Point), Everlook said to ride back to Talrendis Point
// right after the flight from there, Ranshalla's hand-in said her escort comes later (it is the next goal), and the
// Dire Maul note pointed at a Rabid Shardtooth grind the guide doesn't have (its grind is in Terrordale).
test('forever/alliance/50-60/06-silithus.guide: final review: travel tips and notes match the route', { skip }, () => {
	const list = goals('forever/alliance/50-60/06-silithus.guide');
	const texts = ({ step, goal }) => [step.note || '', goal.note || '', goal.t === 'note' ? goal.text : ''].join(' ');
	const sanctuary = list[at(list, 'turnin 5159', is('turnin', 5159))];
	const flight = list.slice(0, list.indexOf(sanctuary)).reverse().find(({ goal }) => goal.t === 'fly');
	assert.match(flight.goal.location || flight.step.title, /Talrendis/, 'the route flies to Talrendis Point');
	assert.doesNotMatch(texts(sanctuary), /Astranaar/, 'and the Felwood stop says so');
	const everlook = list[at(list, 'turnin 5163', is('turnin', 5163))];
	assert.doesNotMatch(texts(everlook), /fly to Everlook/, 'no flight to Everlook after landing there');
	const ranshalla = list[at(list, 'turnin 979', is('turnin', 979))];
	assert.equal(ranshalla.s, list[at(list, 'complete 4901', is('complete', 4901))].s, 'her escort is on the same step');
	assert.doesNotMatch(texts(ranshalla), /later/, 'so it does not come later');
	// The goal-less Dire Maul note went in the 0.4.0 audit (the dungeons owner's runs replace such notes).
	assert.ok(!list.some(({ goal }) => goal.t === 'note' && /Dire Maul/.test(goal.text)), 'no Dire Maul note');
	const grind = list.find(({ goal }) => goal.t === 'level' && goal.level + (goal.frac || 0) >= 59.8);
	assert.ok(grind && /Terrordale/.test(grind.step.note || ''), 'the solo grind to 60 (less the hand-ins after it) is in Terrordale');
});

// Final route review before 0.3.5, Alliance 40-60: the 56-58 guide spends about a quarter of its quest goals in
// Un'Goro Crater and Silithus, but its title named only the Plaguelands and Feralas.
test('forever/alliance/50-60/04-western-plaguelands.guide: final review: the title names Un\'Goro Crater and Silithus', { skip }, () => {
	const guide = compiled('forever/alliance/50-60/04-western-plaguelands.guide');
	const zones = new Set(guide.steps.flatMap((step) => step.goals.filter((g) => ['accept', 'turnin'].includes(g.t) && g.map).map((g) => g.map)));
	assert.ok(zones.has(1449) && zones.has(1451), 'it quests in Un\'Goro Crater (1449) and Silithus (1451)');
	assert.match(guide.title, /Un'Goro Crater/);
	assert.match(guide.title, /Silithus/);
});
for (const [guide, quests] of Object.entries(ALLIANCE_5060_VOLUME)) test(`${guide}: Alliance 50-60 quest volume: its quests are handed in as part of the route`, { skip }, () => {
	const here = goals(guide);
	for (const q of quests) assert.ok(here.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide}, not optional`);
});

test('Alliance 50-60: The Eastern Plagues is taken with Flint Shadowmore and the last top-up stops short of 60 for the Chillwind hand-ins', { skip }, () => {
	const g = goals('forever/alliance/50-60/06-silithus.guide');
	const take = at(g, 'accept 6185', is('accept', 6185));
	assert.ok(at(g, 'turnin 6184', is('turnin', 6184)) < take, 'Flint Shadowmore is handed in first');
	const work = at(g, 'complete 6185', (x) => x.t === 'complete' && x.quest === 6185);
	const top = g.findIndex(({ goal }) => goal.t === 'level' && goal.level + (goal.frac || 0) >= 59.8);
	const hand = at(g, 'turnin 6185', is('turnin', 6185));
	assert.ok(take < work && work < hand && top < hand, 'accept, the Marris Stead, the top-up, then the hand-in');
	assert.ok(g[top].goal.level + (g[top].goal.frac || 0) < 60, 'the top-up leaves the Chillwind hand-ins their XP');
	assert.ok(at(g, 'turnin 6389', is('turnin', 6389)) > top, 'A Plague Upon Thee is handed in after the top-up too');
});

test('Alliance 58-60: the Jaedenar key chain is part of the route on the Shadow Hold visits, not optional at 53', { skip }, () => {
	const g = goals('forever/alliance/50-60/06-silithus.guide');
	const order = [
		['collect', 13140], ['accept', 5202], ['turnin', 5202], ['accept', 5203], ['complete', 5203], ['turnin', 5203],
		['accept', 5204], ['turnin', 5204], ['accept', 5385], ['turnin', 5385],
	].map(([t, q]) => {
		const i = g.findIndex(({ goal }) => goal.t === t && (goal.quest === q || (t === 'collect' && goal.item === q)));
		assert.ok(i >= 0, `${t} ${q} is in 06`);
		assert.ok(!g[i].goal.optional, `${t} ${q} is not optional`);
		return i;
	});
	for (let k = 1; k < order.length; k++) assert.ok(order[k - 1] < order[k], `step ${k} of the chain comes in order`);
	const fw = goals('forever/alliance/50-60/02-felwood.guide');
	for (const q of [5202, 5203, 5204, 5385]) assert.ok(!fw.some(({ goal }) => goal.quest === q), `02-felwood leaves ${q} to the 58 visit`);
});

test('Alliance 53-60: the ritual totems and Meilosh\'s Runecloth come from the route\'s furbolg kills and are handed in at Timbermaw Hold', { skip }, () => {
	const fw = goals('forever/alliance/50-60/02-felwood.guide');
	assert.ok(fw.some(({ goal }) => goal.t === 'accept' && goal.quest === 8470 && !goal.optional), '02: Deadwood Ritual Totem taken');
	assert.ok(!fw.some(({ goal }) => goal.t === 'accept' && goal.quest === 6031), '02: Runecloth is not offered before Friendly');
	const ws = goals('forever/alliance/50-60/03-winterspring.guide');
	const top = ws.findIndex(({ goal }) => goal.t === 'level' && lvlOf(goal) >= 54.85);
	const totem = at(ws, 'accept 8471', is('accept', 8471));
	assert.ok(top >= 0 && top < totem && !ws[totem].goal.optional, '03: the Winterfall totem is taken after the top-up, counted');
	const end = goals('forever/alliance/50-60/06-silithus.guide');
	for (const [t, q] of [['turnin', 8470], ['turnin', 8471], ['accept', 6031], ['turnin', 6031]]) {
		const i = at(end, `${t} ${q}`, is(t, q));
		assert.ok(!end[i].goal.optional, `06: ${t} ${q} is counted`);
	}
});

// Travel (0.3.6, the held Alliance Winterspring exit, Plan 0.3.7 list): 50-60/03 bound the Hearthstone at Everlook
// and left Everlook by the flight to Theramore, the boat to Menethil Harbor and the flight to Southshore (about 15
// minutes to Chillwind Camp in the addon's planner) while the route's bind, Thelsamar's (Hinterlands guide, 47), was
// unused since the Blasted Lands: hearth, gryphon to Chillwind Camp, about 5 minutes. The level model's only Everlook
// hearth saves 5 minutes, so keeping Thelsamar nets about 5 minutes. A player bound at Thelsamar keeps that bind and
// leaves through it; anyone else binds at Everlook and leaves by Theramore and the boat, as before. Both fly to
// Chillwind Camp (flight path from 50-60/01), not Southshore and a ride north.
test('forever/alliance/50-60/03-winterspring.guide: the Ironforge bind is kept and used, Everlook binds only without it', { skip }, () => {
	const list = goals('forever/alliance/50-60/03-winterspring.guide');
	const has = (step, neg) => (step.when || []).some((p) => p.k === 'bound' && !!p.neg === neg);
	const bind = list.find(({ goal }) => goal.t === 'sethome' && goal.location === 'Everlook');
	assert.ok(bind && has(bind.step, true), 'the Everlook bind only when not bound at Thelsamar');
	const flights = list.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Chillwind Camp');
	assert.equal(flights.length, 2, 'two ways to Chillwind Camp');
	assert.ok(flights.some(({ step }) => has(step, false)) && flights.some(({ step }) => has(step, true)), 'one per bind');
	assert.ok(!list.some(({ goal }) => goal.t === 'fly' && goal.location === 'Southshore'), 'no flight to Southshore');
});

// --- Alliance 50-60 quest volume, 0.3.6 audit #11 (2026-11-09): XP before Winterspring's last top-up. Every
// grind of 50-60/01-03 tops up to a level the next work needs, so only XP handed in before the 55.05 top-up
// shortens it; these hand-ins come on stops the route already makes, before it. #2460 (g4dz1n4): A Meeting with
// the Master is gone on Forever (Sanath's gossip teleports for free), so the route no longer takes it. Fix round 3
// (0.4.0): the hold that replaced it, on the Thunderhead Hippogryphs (46-48) around Sanath's camp, is gone too;
// Azshara's one top-up is on the Spitelash Myrmidons (50-51), at the player's level, with the dungeon line.
test('Alliance 50-53: no Meeting with the Master (#2460), the relics and the soil handed in on the way to Felwood', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	assert.ok(!bs.some(({ goal }) => goal.quest === 3381), 'A Meeting with the Master is not in the guide');
	assert.ok(!bs.some(({ goal }) => goal.t === 'level' && goal.grind === 6375), 'no top-up on the Thunderhead Hippogryphs');
	const naga = bs.filter(({ goal }) => goal.t === 'level' && goal.grind === 6196);
	assert.ok(naga.length && naga[0].step.title === 'Level 51.3 on the way north', 'the Azshara top-up is on the Spitelash Myrmidons');
	const relics = at(bs, 'turnin 3701', is('turnin', 3701));
	assert.ok(at(bs, 'relic work', (g) => g.quest === 3701 && g.t !== 'accept' && g.t !== 'turnin') < relics, 'the relics are read first');
	assert.ok(at(bs, 'turnin 3501', is('turnin', 3501)) < relics, 'after the Steppes and the Blasted Lands, on the Ironforge stop');
	assert.ok(relics < at(bs, 'fly to Menethil', (g) => g.t === 'fly' && /Menethil/.test(g.location || '')), 'before the flight to Menethil and the boat to Kalimdor');
	const soil = at(bs, 'turnin 3764', is('turnin', 3764));
	assert.ok(everyone(bs[soil]), 'every class goes up to Jenal');
	assert.ok(soil > at(bs, 'turnin 3661', is('turnin', 3661)), 'from the Rut\'theran stop');
	for (const g of ['04-western-plaguelands', '06-silithus']) {
		const late = goals(`forever/alliance/50-60/${g}.guide`);
		assert.ok(!late.some(({ goal }) => goal.t === 'turnin' && (goal.quest === 3701 || goal.quest === 3764)), `neither waits for ${g}`);
	}
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.skip.some((e) => e.q === 3381 && e.issue === '#2460') && !rf.include.some((e) => e.q === 3381), 'the route fixes leave A Meeting with the Master out');
	for (const q of [3701, 3764]) assert.ok(rf.pairs.some((p) => p.a[0] === 'turnin' && p.a[1] === q && p.faction === 'Alliance'), `a route-fix pair keeps the ${q} hand-in early`);
});

// The same group, in Burning Steppes: Trinkets... (3481) gives the Hoard of the Black Dragonflight, which holds the Black
// Dragonflight Molt (quest reward data; the molt's sources list the hoard), and A Taste of Flame (4022, needs 3481, same
// XP as 4023) takes it at Cyrus with no elite drake. 4023 is not offered once 4022 is in the log or done, so its group
// steps are only for players without Trinkets.
test('Burning Steppes (Alliance 52): after Trinkets..., A Taste of Flame is 4022 with the hoard\'s molt, not the drake', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const cond = (i, k, neg) => (bs[i].step.when || []).some((p) => p.k === k && !!p.neg === neg && [].concat(p.q).includes(3481));
	for (const t of ['accept', 'turnin']) assert.ok(cond(at(bs, `${t} 4022`, is(t, 4022)), 'turnedin', false), `${t} 4022 only after Trinkets...`);
	for (const [t, q] of [['accept', 4023], ['collect', 4023], ['turnin', 4023]]) {
		const i = at(bs, `${t} ${q}`, (g) => g.t === t && g.quest === q);
		assert.ok(cond(i, 'turnedin', true), `${t} ${q} only without Trinkets...`);
	}
	assert.ok(at(bs, 'turnin 4022', is('turnin', 4022)) < at(bs, 'accept 4023', is('accept', 4023)), 'the molt hand-in comes first');
});

// Alliance 50-60 (0.3.6): the Blasted Lands stop lands at Nethergarde Keep, where Ambassador Ardalan
// gives Petty Squabbles (2783, 4,500 XP), and the Fallen Hero who takes it, and gives A Tale of Sorrow (2801, 600 XP),
// stands just over the Swamp of Sorrows border: both on the stop, before Kum'isha and the hearth.
test('Blasted Lands (Alliance 52): Petty Squabbles and A Tale of Sorrow on the Nethergarde stop', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const land = at(bs, 'fly to Nethergarde', (g) => g.t === 'fly' && /Nethergarde/.test(g.location || ''));
	const acc = at(bs, 'accept 2783', is('accept', 2783));
	const told = at(bs, 'turnin 2801', is('turnin', 2801));
	assert.ok(land < acc && acc < at(bs, 'turnin 2783', is('turnin', 2783)) && at(bs, 'turnin 2783', is('turnin', 2783)) < told, 'Ardalan after landing, then the Fallen Hero');
	assert.ok(everyone(bs[acc]) && everyone(bs[told]) && !bs[acc].step.when, 'for everyone');
	assert.ok(told < at(bs, 'turnin 3501', is('turnin', 3501)), 'before Kum\'isha and the hearth');
});

// Felwood end at the tunnel (0.4.0 audit, Alliance 50-60/02): the Emerald Sanctuary's last hand-ins come before the
// Timbermaw block, so the guide ends at Timbermaw Hold, where 50-60/03 starts through the tunnel; the "Level 52.9" top-up
// comes after the Sanctuary's first hand-ins (5155, 4421) that cover most of it, only for a player still short.
test('Alliance Felwood: ends at Timbermaw Hold, the Sanctuary hand-ins first; the 52.9 top-up after the hand-ins', { skip }, () => {
	const file = 'forever/alliance/50-60/02-felwood.guide';
	const list = goals(file);
	const last = (pred) => list.reduce((k, e, i) => (pred(e.goal) ? i : k), -1);
	for (const q of [5156, 4906, 5157, 939]) assert.ok(last(is('turnin', q)) < at(list, 'turnin 8462', is('turnin', 8462)), `${q} handed in before Nafien`);
	const steps = compiled(file).steps;
	assert.match(steps[steps.length - 1].title, /Timbermaw Hold|Nafien/, 'the guide ends at Timbermaw Hold');
	const town = Math.max(at(list, 'turnin 5155', is('turnin', 5155)), at(list, 'turnin 4421', is('turnin', 4421)));
	const grinds = list.map((e, i) => [e, i]).filter(([{ goal, step }]) => goal.t === 'level' && !step.only && !goal.only && Math.abs(goal.level + (goal.frac || 0) - 52.9) < 1e-6);
	assert.equal(grinds.length, 1, 'one 52.9 top-up');
	assert.ok(grinds[0][1] > town, 'after the Sanctuary hand-ins');
	assert.ok(grinds[0][0].step.when.some((p) => p.k === 'level'), 'only for a player still short');
});

// Breadcrumb safety (0.4.0 audit, #2025): The Ruins of Kel'Theril (5244) lists To Winterspring! (5249) as its
// prerequisite in the quest data. 5249 is taken from Ivy Leafrunner on Felwood's last Sanctuary stop and handed to Wynd
// Nightchaser right before 5244, so 5244 is offered whichever way the game treats 5249.
test('Alliance Winterspring: To Winterspring! (5249) from Felwood is handed in right before The Ruins of Kel\'Theril (5244)', { skip }, () => {
	const fel = goals('forever/alliance/50-60/02-felwood.guide');
	assert.ok(at(fel, 'accept 5249', is('accept', 5249)) >= 0, 'Felwood takes To Winterspring!');
	const ws = goals('forever/alliance/50-60/03-winterspring.guide');
	const t = at(ws, 'turnin 5249', is('turnin', 5249));
	const a = at(ws, 'accept 5244', is('accept', 5244));
	assert.ok(t < a, '5249 handed in before 5244 is taken');
	assert.equal(ws[t].s, ws[a].s, 'on the same Wynd Nightchaser step');
});

// 0.4.0 audit (B26, with 40-50's Ironforge bind): 50-60/01 hearths to Ironforge's inn, where 40-50/05 binds, instead of
// Thelsamar and a flight; the Hinterlands stop is only for The Super Snapper FX's group (the feathers are collected in
// 40-50/05), everyone else flies Ironforge -> Southshore; Morgan's Vigil by its flight path when known, else Lakeshire and
// the pass; The Horn of the Beast's group flies Ironforge -> Thelsamar -> Ironforge for Pebblebitty.
test('Alliance 50-60/01: hearths to Ironforge, Aerie Peak only for Gammerita\'s group, Morgan\'s Vigil by known flight path', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const has = (e, k, neg) => (e.step.when || []).some((p) => p.k === k && !!p.neg === neg);
	assert.ok(!bs.some(({ goal }) => goal.t === 'goto' && /Stoutlager/.test(goal.text || goal.label || '')), 'no hearth to Thelsamar');
	assert.equal(bs.filter(({ goal }) => goal.t === 'goto' && goal.map === 1455 && goal.x === 18.15).length, 2, 'two hearths to Ironforge\'s inn');
	const aerie = bs.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Aerie Peak');
	assert.ok(aerie.length === 1 && has(aerie[0], 'group', false), 'Aerie Peak only for the group');
	const ss = bs.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Southshore');
	assert.ok(ss.some((e) => has(e, 'group', true)) && ss.some((e) => has(e, 'group', false)), 'Southshore straight from Ironforge, or from Aerie Peak for the group');
	const mv = bs.find(({ goal }) => goal.t === 'fly' && goal.location === "Morgan's Vigil");
	assert.ok(mv && has(mv, 'taxi', false), "the flight to Morgan's Vigil when its flight path is known");
	const fp = bs.find(({ goal }) => goal.t === 'getfp' && /Morgan/.test(goal.location || ''));
	assert.ok(fp && has(fp, 'taxi', true), 'else Lakeshire, the pass and its flight path');
	const thel = bs.find(({ goal }) => goal.t === 'fly' && goal.location === 'Thelsamar');
	assert.ok(thel && has(thel, 'group', false), 'Thelsamar only for The Horn of the Beast\'s group');
});

// 0.4.0 audit (fold2): 50-60/05's Eastern Kingdoms round trip at 58 is folded into 06. 04 leads straight to 06, which
// opens at Ratchet (Volcanic Activity, the Stone Circle); an Ironforge detour from Talrendis Point before Un'Goro
// hands A Little Slime Goes a Long Way in and takes its second part, whose jars are filled on Fire Plume Ridge;
// 05's Stormwind, Ironforge and Light's Hope work joins 06's Eastern Kingdoms finale. Training moves to the
// Ironforge hearth leaving Winterspring (03) and Darnassus (04) for the classes it trains there.
test('Alliance 50-60: 05 folded into 06, the training stops at 55 and 57', { skip }, () => {
	const fsx = require('node:fs');
	assert.ok(!fsx.existsSync(path.join(OFFICIAL_DIR, 'forever/alliance/50-60/05-silithus.guide')), '05 is gone');
	const retired = JSON.parse(fsx.readFileSync(path.join(OFFICIAL_DIR, 'retired.json'), 'utf8'));
	assert.ok(retired.includes('forever/alliance/50-60/05-silithus'), 'its saved tabs open a successor');
	assert.equal(compiled('forever/alliance/50-60/04-western-plaguelands.guide').next, 'forever/alliance/50-60/06-silithus');
	const six = goals('forever/alliance/50-60/06-silithus.guide');
	const p = (t, q) => at(six, `${t} ${q}`, is(t, q));
	assert.ok(p('turnin', 4502) < p('turnin', 5159), 'Ratchet first, then Felwood');
	assert.ok(p('turnin', 4512) < p('accept', 4513) && p('accept', 4513) < at(six, 'jars', (g) => g.t === 'collect' && g.quest === 4513), 'Laris before Un\'Goro, the jars on Fire Plume');
	assert.ok(at(six, 'jars', (g) => g.t === 'collect' && g.quest === 4513) < p('turnin', 4513), 'and handed in on the last Ironforge stop');
	for (const [t, q] of [['turnin', 5022], ['turnin', 6183], ['turnin', 5168], ['turnin', 5206], ['turnin', 6024], ['turnin', 5941], ['turnin', 5281]]) assert.ok(p(t, q) >= 0, `${t} ${q} in 06`);
	assert.ok(p('turnin', 5206) < p('turnin', 5941), 'Chromie after Light\'s Hope');
	const ws = goals('forever/alliance/50-60/03-winterspring.guide');
	const train = ws.find(({ goal }) => goal.t === 'train');
	assert.ok(train && (train.step.when || []).some((w) => w.k === 'bound' && !w.neg), 'Ironforge training on the hearth out of Winterspring');
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	assert.ok(wpl.some(({ goal, step }) => goal.t === 'train' && step.title === 'Darnassus' && [step.only, goal.only].some((o) => o && o.classes && o.classes.includes('WARRIOR'))), 'Darnassus trains its classes');
});

// 0.4.0 audit with the dungeons owner: Alliance 50-60's grind tips name a dungeon only where its run is in the same or
// the next guide on that continent (the Sunken Temple from 01's Swamp of Sorrows stop; Scholomance and Stratholme
// from 06's Caer Darrow and Terrordale stops), and 06's two goal-less dungeon notes, shown to every player, are gone.
test('Alliance 50-60: grind tips name only the dungeons the route can run there; no goal-less dungeon notes', { skip }, () => {
	const allowed = { '01-burning-steppes': ['Sunken Temple'], '06-silithus': ['Scholomance', 'Stratholme'] };
	for (const g of ['01-burning-steppes', '02-felwood', '03-winterspring', '04-western-plaguelands', '06-silithus']) {
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, `forever/alliance/50-60/${g}.guide`), 'utf8');
		for (const m of text.matchAll(/run the ([A-Z][^.]*?) dungeon/g)) {
			for (const name of m[1].split(/ dungeon or the /)) assert.ok((allowed[g] || []).some((a) => name.startsWith(a)), `${g}: names ${name}`);
		}
		assert.doesNotMatch(text, /^step (Dire Maul|Scholomance) \(optional\)$/m, `${g}: no goal-less dungeon note`);
	}
});

// 0.4.0 audit (0.3.7's ac4485952, the part that never reached dev-040): 50-60/01 takes everyone up to Darnassus for Jenal
// and the Un'Goro Soil (3764), but a character without the soil (a fresh loader) has no business there unless a Druid
// (training): the portal up only with the soil or for Druids, the portal down only from Darnassus.
test('Alliance 50-60/01: the Darnassus trip only with the Un\'Goro Soil, or for Druids\' training', { skip }, () => {
	const steps = compiled('forever/alliance/50-60/01-burning-steppes.guide').steps;
	const up = steps.filter((st) => st.title === 'Portal to Darnassus');
	const cond = (st, k, neg) => (st.when || []).some((p) => p.k === k && !!p.neg === neg);
	assert.ok(up.some((st) => cond(st, 'onquest', false) && !st.only), 'up with the soil, every class');
	assert.ok(up.some((st) => cond(st, 'onquest', true) && st.only && st.only.classes && st.only.classes.join() === 'DRUID'), 'up without it only for Druids');
	const down = steps.find((st) => st.title === 'Portal to Teldrassil');
	assert.ok(down && cond(down, 'zone', false), 'down only from Darnassus');
});

// Danger at the spot (#1575, 0.4.0 audit), Alliance 50-60: level 60 Escaped Core Hounds and Firesworn roam the Burning
// Steppes, Vek'zol (55, elite) stands by Kum'isha's hill, and Ancient Irontree Walkers (59, elite) stand among Felwood's
// Irontree Stompers and Toxic Horrors: each step warns, and the arrows point where the targets are clear of them (the
// broodlings east of Flame Crest; the Toxic Horror at the camp's north-east tip).
test('Alliance 50-60: danger warnings at Dreadmaul Rock, the Blackrock camps, Kum\'isha, Irontree Woods and the Toxic Horrors', { skip }, () => {
	const stepOf = (file, pred) => { const l = goals(file); return l[at(l, 'goal', pred)].step; };
	const BS = 'forever/alliance/50-60/01-burning-steppes.guide';
	const L6 = 'forever/alliance/50-60/06-silithus.guide';
	const tipped = (st, re) => assert.ok([st.note, ...(st.notes || []), ...(st.tips || [])].concat(JSON.stringify(st)).some((t) => re.test(t || '')), `${st.title}: ${re}`);
	tipped(stepOf(BS, (g) => g.quest === 3823 && g.t === 'kill' && g.oi === 2), /Escaped Core Hounds/);
	// Level tidy 0.4.0: the Blackrock Stronghold step (Gor'tesh, the medallions) is left out (orcs 55-58 at 52-53), so
	// its Firesworn warning goes with it.
	assert.ok(!goals(BS).some(({ goal }) => goal.quest === 3824 || goal.quest === 4283), 'no Blackrock Stronghold work');
	tipped(stepOf(BS, (g) => g.quest === 3501 && g.t === 'collect'), /Vek'zol/);
	tipped(stepOf(L6, (g) => g.quest === 4084 && g.t === 'collect' && g.oi === 2), /Ancient Irontree Walkers/);
	tipped(stepOf(L6, (g) => g.quest === 5086 && g.t === 'collect'), /Ancient Irontree Walkers/);
	const bs = goals(BS);
	const use = bs[at(bs, 'use 4726', (g) => g.t === 'use' && g.quest === 4726)].goal;
	assert.ok(use.x >= 80 && use.y < 40, 'the Draco-Incarcinatrix where the broodlings are');
	const six = goals(L6);
	const th = six[at(six, 'collect 5086', (g) => g.t === 'collect' && g.quest === 5086)].goal;
	assert.deepEqual([th.x, th.y], [50.6, 22.4], 'the Toxic Horror clear of the walkers');
});

// 0.4.0 audit (A1): the last top-up is ground in Terrordale while the route stands there for Egan, before the Marris
// Stead, the Undercroft, Caer Darrow and Chromie; it rode back north to Terrordale from Caer Darrow for it (about 3.4k yd).
// The hand-ins after it (6024, 5846, 5941 and Chillwind Camp's) take it to 60, so it stops at 59.85.
test('Alliance 50-60/06: the last top-up right after Egan, before the Marris Stead', { skip }, () => {
	const g = goals('forever/alliance/50-60/06-silithus.guide');
	const top = g.findIndex(({ goal }) => goal.t === 'level' && goal.level + (goal.frac || 0) >= 59.8);
	assert.ok(at(g, 'turnin 5281', is('turnin', 5281)) < top, 'after Egan');
	assert.ok(top < at(g, 'Marris Stead', (x) => x.t === 'collect' && x.quest === 6185), 'before the Marris Stead');
	assert.ok(top < at(g, 'turnin 5846', is('turnin', 5846)), 'and before Caer Darrow');
});

// 0.4.0 audit (A2): Ancient Spirit (4261) is handed in at Forest Song on the ride from the Emerald Sanctuary back to
// Talrendis Point, right after Arei's escort, not on a Gadgetzan -> Talrendis Point -> Forest Song detour later.
test('Alliance 50-60/06: Ancient Spirit handed in at Forest Song on the way out of Felwood', { skip }, () => {
	const g = goals('forever/alliance/50-60/06-silithus.guide');
	const t = at(g, 'turnin 4261', is('turnin', 4261));
	assert.ok(t > at(g, 'turnin 5242', is('turnin', 5242)), 'after the Sanctuary');
	assert.ok(t < at(g, 'turnin 4496', is('turnin', 4496)), 'before Gadgetzan');
	assert.ok(g.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Talrendis Point').length <= 1, 'no second flight to Talrendis Point for it');
});

// 0.4.0 audit: with the Ratchet flight path known (the 40-50 Stranglethorn guide teaches it at the Booty Bay dock),
// the late Feralas stop flies Thalanaar -> Ratchet instead of Theramore and a ride up the Barrens coast; without it
// the old way stays.
test('Alliance 50-60/04: Thalanaar to Ratchet by flight path when known, else Theramore and the coast', { skip }, () => {
	const g = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const has = (e, neg) => (e.step.when || []).some((p) => p.k === 'taxi' && !!p.neg === neg);
	const direct = g.find(({ goal }) => goal.t === 'fly' && goal.location === 'Ratchet');
	assert.ok(direct && has(direct, false), 'fly to Ratchet when known');
	const thera = g.find(({ goal }) => goal.t === 'fly' && goal.location === 'Theramore');
	assert.ok(thera && has(thera, true), 'Theramore otherwise');
});

// 0.4.0 audit (fold2 follow-up): Of Forgotten Memories (5781) is handed to Tirion on 06's first Eastern Plaguelands
// stop, and Of Lost Honor (5845, Of Love and Family after it) is only offered once it is. Its Taelan's Hammer drops
// from Mercutio Filthgorger at the Undercroft, which the folded 06 reaches only at its end: the hammer is taken on 04's
// Undercroft visit (the Torn Scroll), where Mercutio stands beside the scroll. 05's warnings for Mercutio's adds and
// the trolls on the way to Infiltrator Hameya stay on their steps.
test('Alliance 50-60: Taelan\'s Hammer before Tirion\'s hand-in after the fold; Mercutio\'s and Hameya\'s warnings kept', { skip }, () => {
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const scroll = at(wpl, 'accept 6024', is('accept', 6024));
	const hammer = at(wpl, 'collect 5781.1', (g) => g.t === 'collect' && g.quest === 5781);
	assert.equal(wpl[hammer].s, wpl[scroll].s, 'the hammer on the Torn Scroll stop');
	assert.ok(at(wpl, 'accept 5781', is('accept', 5781)) < hammer, 'after Tirion gives the quest');
	const said = (st) => [st.note, ...(st.notes || []), JSON.stringify(st)].filter(Boolean).join(' ');
	assert.ok(said(wpl[hammer].step).includes('adds come with Mercutio'), 'with the adds warning');
	const six = goals('forever/alliance/50-60/06-silithus.guide');
	assert.ok(!six.some(({ goal }) => goal.t === 'collect' && goal.quest === 5781), 'no hammer after the hand-in');
	assert.ok(at(six, 'turnin 5781', is('turnin', 5781)) < at(six, 'accept 5845', is('accept', 5845)), 'Tirion: 5781 in, then Of Lost Honor');
	const hameya = six[at(six, 'collect 6024.1', (g) => g.t === 'collect' && g.quest === 6024)].step;
	assert.match(said(hameya), /Zul'Mashar are level 57-59/, 'the trolls warning on Hameya');
	const mound = six[at(six, 'turnin 6024', is('turnin', 6024))].step;
	assert.match(said(mound), /adds come with Mercutio/, 'and the adds warning at the mound');
});

// 0.4.0 audit (lint): the Lakeshire way to Morgan's Vigil leads by its getfp alone; a goto 2 yards from the flight
// master on the same step only doubled the arrow's point.
test('Alliance 50-60/01: Morgan\'s Vigil flight path step without a second point', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const fp = bs.find(({ goal }) => goal.t === 'getfp' && /Morgan/.test(goal.location || ''));
	assert.ok(fp, 'the getfp step');
	assert.ok(!bs.some(({ goal, s }) => s === fp.s && goal.t === 'goto'), 'no goto beside it');
});

// Danger at the spot (#1575, 0.4.0 audit): the Broodling Essence point (81.0,28.0) has a Malfunctioning Reaver (56,
// rare) about 65 yd away and elite dragonspawn around the broodlings: the step warns, from its record.
test('Alliance 50-60/01: the Broodling Essence step warns of the Malfunctioning Reaver and the elite dragonspawn', { skip }, () => {
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const use = bs[at(bs, 'use 4726.1', (g) => g.t === 'use' && g.quest === 4726)];
	assert.match([use.step.note, ...(use.step.notes || []), JSON.stringify(use.step)].filter(Boolean).join(' '), /Malfunctioning Reaver \(level 56, rare\)/, 'the warning on the step');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 4726 && f.at.objective === 1 && /Malfunctioning Reaver/.test(f.tip || '')), 'and its record');
});

// 0.4.0 route-feel audit (Alliance Felwood): the route reaches Xavaric at the far end of Jadefire Run for his Flute;
// he is killed for Further Corruption (4906) there, not after the other satyrs on a walk back (6.3 min on every branch).
test('Alliance 50-60/02: Xavaric killed when the route reaches him for the Flute of Xavaric', { skip }, () => {
	const fel = goals('forever/alliance/50-60/02-felwood.guide');
	const xav = at(fel, 'kill Xavaric', (g) => g.t === 'kill' && g.quest === 4906 && g.oi === 4);
	const flute = at(fel, 'collect 11668', (g) => g.t === 'collect' && g.item === 11668);
	assert.equal(fel[xav].s, fel[flute].s, 'the same step');
	assert.ok(xav < flute, 'killed before the flute is looted');
	for (const oi of [1, 2, 3]) assert.ok(xav < at(fel, `kill 4906.${oi}`, (g) => g.t === 'kill' && g.quest === 4906 && g.oi === oi), `before the other satyrs (4906.${oi})`);
	const felbind = at(fel, 'collect 939.1', (g) => g.t === 'collect' && g.quest === 939);
	for (const oi of [1, 2, 3]) assert.ok(at(fel, `kill 4906.${oi}`, (g) => g.t === 'kill' && g.quest === 4906 && g.oi === oi) < felbind, `the Felbind comes with the satyr kills, after 4906.${oi}`);
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.together;
	assert.ok(rf.some((r) => r.a[0] === 'task' && r.a[1] === 4906 && r.a[2] === 3 && r.b[0] === 'accept' && r.b[1] === 939), 'its record');
	const after = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.after;
	assert.ok(after.some((r) => r.a[0] === 'task' && r.a[1] === 4906 && r.b[0] === 'task' && r.b[1] === 939), 'and the Felbind\'s');
});

// 0.4.0 route-feel audit (Alliance Western Plaguelands): the Dalson's Tears cauldron (Target: Dalson's Tears, 5219)
// stands beside the farmhouse the route works on its first stop there; Return to Chillwind Camp (5220) was walked past
// there and taken 30 min later on a ride out from the camp. Now it is done with the farm and handed in on the same
// return to the camp as the scourgestones (since #2561's sweep each stone hand-in is a step of its own, shown only
// with its stones in the bags, and MacDonnell's the step right after them, with no travel in between).
test('Alliance 50-60/04: the Dalson\'s Tears cauldron on the first pass, Return to Chillwind Camp on the next camp stop', { skip }, () => {
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const p = (t, q) => at(wpl, `${t} ${q}`, is(t, q));
	assert.equal(wpl[p('turnin', 5219)].s, wpl[p('turnin', 5060)].s, 'the cauldron with the farm\'s cabinet');
	assert.ok(p('turnin', 5060) < p('turnin', 5219) && p('turnin', 5219) < p('accept', 5220), 'after the cabinet');
	const stones = wpl[p('turnin', 5402)].s;
	assert.ok(p('turnin', 5403) < p('turnin', 5220) && wpl[p('turnin', 5220)].s - stones <= 2, 'handed in with the scourgestones');
	const camp = compiled('forever/alliance/50-60/04-western-plaguelands.guide').steps.slice(stones - 1, wpl[p('turnin', 5220)].s);
	assert.ok(camp.every((st) => !st.goals.some((g) => ['fly', 'goto', 'hearth'].includes(g.t))), 'on the same camp stop: no travel in between');
	assert.equal(wpl[p('accept', 5222)].s, wpl[p('turnin', 5220)].s, 'Target: Writhing Haunt taken there');
	assert.ok(p('turnin', 5220) < p('turnin', 5097), 'before the watchtowers\' hand-in');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.together;
	assert.ok(rf.some((r) => r.a[0] === 'turnin' && r.a[1] === 5060 && r.b[0] === 'task' && r.b[1] === 5219), 'its record');
	assert.ok(rf.some((r) => r.a[0] === 'turnin' && r.a[1] === 5403 && r.b[0] === 'turnin' && r.b[1] === 5220), 'and the hand-in\'s');
});
