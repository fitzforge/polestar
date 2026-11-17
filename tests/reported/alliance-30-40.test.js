'use strict';
// Player-reported guide fixes: the Alliance 30-40 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, ARATHI, ASHENVALE_30, at, BADLANDS, compiled, DATA, DESOLACE_SOUTH, Diagnostics, engineRun, everyone,
	forClass, goals, HILLSBRAD_ALLIANCE, is, loadCorrections, loadData, OFFICIAL_DIR, parseGuide, refData, ROOT, skip,
	stepTips, whenOn, yards,
} = require('./helpers');

// --- Alliance 30-40 audit (0.3.7, 2026-11-09) ----------------------------------------------------------------------
const A3040 = ['01-hillsbrad-foothills', '02-desolace', '03-ashenvale', '04-stranglethorn-vale', '04b-stranglethorn-vale', '05-arathi-highlands', '06-badlands', '06b-desolace'].map((f) => `forever/alliance/30-40/${f}.guide`);

// Bennistrov's report (#1521): "FP horde town when playing alliance character". Alliance 30-40's walk east from
// Highperch to the Mirage Raceway pointed at 46.9,48.5, the foot of Freewind Post's lift (the Horde camp on the
// mesa), though the step's tip says to keep clear of it. The point is in the canyon north of the mesa (46.3,40.9,
// on the walking route from Highperch; ~300 yd from the camp), and no Thousand Needles goal of the guide is near it.
test('forever/alliance/30-40/03-ashenvale.guide: the walk east from Highperch keeps away from Freewind Post (#1521)', { skip }, () => {
	const list = goals('forever/alliance/30-40/03-ashenvale.guide');
	const near = list.filter(({ goal }) => goal.map === 1441 && Math.hypot(goal.x - 46.9, goal.y - 48.5) < 4);
	assert.deepEqual(near.map(({ goal }) => `${goal.t} ${goal.x},${goal.y}`), [], 'nothing at the Freewind Post lift');
	const { goal } = list.find(({ goal }) => goal.t === 'goto' && goal.map === 1441 && /canyons east of/.test(goal.text));
	assert.ok(Math.hypot(goal.x - 46.3, goal.y - 40.9) < 0.5, `in the canyon north of the mesa (${goal.x},${goal.y})`);
});

// --- Wetlands (julesbruu, #1705): 0.3.6 lit the catapult (465's hand-in) and then sent everyone to the Tattered
// Spellbook for Old Habits (98223), which offered nothing to a solo player who skipped the elite chieftain, with
// neither Nek'rosh's Gambit (465) nor Defeat Nek'rosh (474) in the log. Players' recordings: offered with 465 in the
// log, with 474 in the log, and once after 474's hand-in. Now it is taken before the catapult, and the step shows
// only while 465 or 474 is in the log (the route's gate).
test(`${HILLSBRAD_ALLIANCE}: julesbruu's report: Old Habits is taken while Nek'rosh's Gambit is still in the log, shown only with it or Defeat Nek'rosh in the log (#1705)`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const take = at(list, 'accept 98223', is('accept', 98223));
	assert.ok(take < at(list, 'turnin 465', is('turnin', 465)), 'the spellbook comes before the catapult is lit');
	const when = list[take].step.when || [];
	assert.ok(!when.some((p) => p.k === 'group'), 'not on the group branch: solo players take it too');
	const gate = when.find((p) => p.k === 'onquest' && !p.neg);
	assert.ok(gate, 'the step shows only while a quest of the chain is in the log');
	assert.deepEqual([gate.q].flat().sort((a, b) => a - b), [465, 474], 'Nek\'rosh\'s Gambit or Defeat Nek\'rosh');
	// The hand-in at Menethil holds only players who took the quest, in a step of its own: Red Jack Flint's accept
	// beside it stays for everyone.
	const back = list[at(list, 'turnin 98223', is('turnin', 98223))];
	assert.ok((back.step.when || []).some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(98223)), 'the hand-in step is when onquest 98223');
	assert.ok(!back.step.goals.some((g) => is('accept', 1132)(g)), 'Red Jack Flint is not in the hand-in step');
	assert.ok(list.some(({ step, goal }) => is('accept', 1132)(goal) && !(step.when || []).length), 'Red Jack Flint is taken by everyone');
	let seen = 0;
	for (const guide of allGuides()) seen += goals(guide).filter(({ goal }) => is('accept', 98223)(goal)).length;
	assert.equal(seen, 1, 'taken in one guide');
});

// --- Dun Modr (Fyurie, #1313): Spark of Freedom's Captive Fire Elemental is held at the far west of the Dark Iron
// ruins, among elites (27-30, Balgaras the Foul 34), and the escort walks back out through them; 0.3.5 sent solo
// players in without asking. It is a group quest now; the camp quests on the road stay for everyone.
test(`${HILLSBRAD_ALLIANCE}: Fyurie's report: Spark of Freedom is asked as a group quest; the Dun Modr camp quests are not (#1313)`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const mine = list.filter(({ goal }) => goal.quest === 87491);
	assert.deepEqual(mine.map(({ goal }) => goal.t), ['accept', 'complete', 'turnin'], 'the accept, the escort and the hand-in');
	for (const { step, goal } of mine) assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(87491) && !p.neg), `${goal.t} 87491 is under when group 87491`);
	for (const [t, q] of [['turnin', 472], ['accept', 631]]) {
		const { step } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(!(step.when || []).some((p) => p.k === 'group'), `${t} ${q} is for everyone`);
	}
});

// --- Southshore (never-seen check, 2026-11-08): 4 Alliance people passed Barkeep Kelly and none was offered Talk of the
// Town (98463); the guide keeps it, optional at both ends, with a tip to skip it.
test(`Talk of the Town is optional at Southshore and at its Booty Bay hand-in, with a tip to skip it`, { skip }, () => {
	const take = goals(HILLSBRAD_ALLIANCE).filter(({ goal }) => goal.quest === 98463);
	const give = goals('forever/alliance/30-40/04-stranglethorn-vale.guide').filter(({ goal }) => goal.quest === 98463);
	assert.ok(take.length && give.length, 'taken in Southshore, handed in at Booty Bay');
	for (const { goal } of [...take, ...give]) assert.ok(goal.optional, `${goal.t} 98463 is optional`);
	assert.ok([take[0].step.note, take[0].step.tip].flat().filter(Boolean).join(' ').includes('Barkeep Kelly may not offer Talk of the Town'), 'the Southshore step says to skip it');
});
test(`${DESOLACE_SOUTH}: the same pattern as #89: Book of the Ancients is taken from Azore on the way to Karnitol's Chest, not on a walk back from it`, { skip }, () => {
	// Review (0.3.6): the first Desolace visit (02) opens the chest beside Azore's tower; the south loop (06b) keeps
	// the chain for a player who loads it without 02, and there Azore still comes before the chest.
	const list = goals(DESOLACE_SOUTH);
	const take = at(list, 'accept 6027 (Book of the Ancients)', is('accept', 6027));
	assert.ok(at(list, 'accept 1454 (Nijel\'s Point)', is('accept', 1454)) < take, 'after Nijel\'s Point');
	assert.ok(take < at(list, "turnin 1454 (Karnitol's Chest)", is('turnin', 1454)), 'before the chest');
});

// --- Flow re-order (2026-11-07, #1106): Alliance Badlands walked from the
// skeleton at Agmond's End west to Lotwil for his quest alone, back to Agmond's
// End for the sweep, and west again for the Lesser Rock Elementals; the
// Indurium flakes were an along list.
test(`${BADLANDS}: flow re-order: Agmond's End swept before Lotwil, Lotwil's elementals in one go, no along steps`, { skip }, () => {
	const list = goals(BADLANDS);
	assert.deepEqual(compiled(BADLANDS).steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const lotwil = at(list, 'accept 710 (Lotwil)', is('accept', 710));
	assert.ok(at(list, 'Theldurin\'s accept', is('accept', 709)) < lotwil, 'Theldurin\'s accept before Lotwil');
	// Level tidy (0.4.0): the scrap comes from the Dustbelcher Ogres (38-39) on the Dustbowl's west side, where players
	// collect it in their recordings, on the Lesser Rock Elementals step: no walk back to Agmond's End's 41-43 camp.
	const stones = at(list, 'collect 4626 (Small Stone Shard)', (g) => g.t === 'collect' && g.item === 4626);
	assert.ok(stones > lotwil, 'the Small Stone Shards after Lotwil\'s accept');
	assert.ok(list.some(({ goal, s }) => s === list[stones].s && goal.t === 'collect' && goal.item === 7848), 'Ghak\'s Rock Elemental Shards with them');
	assert.ok(list.some(({ goal, s }) => s === list[stones].s && goal.t === 'collect' && goal.quest === 733), 'the scrap on the same Dustbowl step');
	assert.ok(at(list, 'the scrap', (g) => g.t === 'collect' && g.quest === 733) < at(list, 'turnin 733', is('turnin', 733)), 'before Sigrun takes it');
});

// --- Flow re-order (2026-11-07, #1100): Alliance Hillsbrad 30-40 walked
// from the Syndicate camp to a point in north-west Alterac and back to the
// camp for Syndicate Assassins, split Farren's Reassignment from Stormwind Ho!
// by a walk across Southshore, and listed the Syndicate on the way.
test(`${HILLSBRAD_ALLIANCE}: flow re-order: the Syndicate camp once, Reassignment with Stormwind Ho!, no along steps`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const { steps } = compiled(HILLSBRAD_ALLIANCE);
	assert.deepEqual(steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	// Level tidy (0.4.0): the camp (Thieves 33-34, Wizards 34-35) is worked in 30-40/05 at about 37, still in one stop;
	// Magistrate Maleb's quest is taken here, on the Southshore stop, and carried there.
	assert.ok(!list.some(({ goal }) => [505, 510, 511].includes(goal.quest) && !is('accept', 505)(goal)), 'no Syndicate camp at 31-32');
	const arathi = goals(ARATHI);
	const docs = at(arathi, 'accept 510 (Foreboding Plans)', is('accept', 510));
	const kills = arathi.filter(({ goal }) => goal.t === 'kill' && goal.quest === 505);
	assert.ok(kills.length && kills.every(({ s }) => s === arathi[docs].s), 'the Syndicate killed at the camp with the documents');
	assert.ok(!list.some(({ goal }) => goal.t === 'goto' && goal.x === 29.6 && goal.y === 37.5), 'no detour to north-west Alterac');
	assert.equal(list[at(list, 'accept 563', is('accept', 563))].s, list[at(list, 'turnin 562', is('turnin', 562))].s, 'Reassignment taken when Stormwind Ho! is handed in');
});

// The Lost Caravan's tip sent players to Watcher Biggs on the swamp's west road;
// the Caravan Chest (object 28024) that holds the Wizards' Reagents stands at the
// north end of the Fallow Sanctuary, beside Galen Goodward's cage, where the
// step's arrow already leads.
test(`${ARATHI}: The Lost Caravan's tip and arrow both lead to the Caravan Chest by Galen's cage, not to Watcher Biggs`, { skip }, () => {
	const list = goals(ARATHI);
	const reagents = list[at(list, "collect 6170 (Wizards' Reagents)", (g) => g.t === 'collect' && g.item === 6170)];
	const tips = [].concat(reagents.step.note || []).join(' ');
	assert.ok(!/near Biggs/.test(tips), `the tip no longer says the caravan is near Biggs: ${tips}`);
	assert.ok(/Galen/.test(tips), 'the tip names Galen\'s cage');
	const chest = refData().spawns('object', 28024).find((sp) => sp.map === reagents.goal.map);
	assert.ok(chest, 'the Caravan Chest has a spawn on the goal\'s map');
	const [x, y] = chest.pts[0];
	assert.ok(yards(reagents.goal, { map: chest.map, x, y }) < 60, `the arrow leads to the chest (${reagents.goal.x},${reagents.goal.y} vs ${x},${y})`);
});

// Thin-data audit (#1317): the Recovered Tome (540) and the Dirty Knucklebones (500) drop from every Crushridge ogre, and
// the Maulers, Mages, Enforcers and Warmongers are elite at 36-39 (the world DB's classification, players' recordings)
// while the guide starts at 36; the steps said nothing about it.
test(`${ARATHI}: thin-data audit: the Crushridge steps say which ogres are elite (#1317)`, { skip }, () => {
	const list = goals(ARATHI);
	for (const [what, pred] of [['collect 3658 (540.1)', (g) => g.t === 'collect' && g.quest === 540 && g.oi === 1], ['collect 2843 (500)', (g) => g.t === 'collect' && g.quest === 500]]) {
		const { step } = list[at(list, what, pred)];
		const tips = [].concat(step.note || []).join(' ');
		assert.match(tips, /Maulers, Mages, Enforcers and Warmongers \(36-39\) are elite/, `${what}: the elites are named`);
		assert.match(tips, /Ogres and Brutes \(34-35\) are not/, `${what}: and the ogres that are not`);
	}
});

// Flow re-order (2026-11-07): Alliance Hillsbrad 30-40 took only the Captive Fire Elemental at Dun Modr
// on the way north and came back to the same camp for Longbraid, Rhag, Roggo and the Heart of Modr,
// walking past the Villards twice. #1565: the Villards' Hearts of the Lost is not in the live game, so the
// step after the camp is Ebenezer Rustlocke's corpse, on the way north.
test(`${HILLSBRAD_ALLIANCE}: flow re-order: Dun Modr in one stop, Ebenezer on the way north, before the crossing`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const dunModr = stepOf('turnin', 472);
	assert.equal(stepOf('accept', 631), dunModr, 'accept 631 on the Dun Modr stop');
	// Spark of Freedom is the group's step right after the camp (#1313), the Heart of Modr after that.
	for (const [t, q] of [['accept', 87491], ['turnin', 87491]]) assert.equal(stepOf(t, q), dunModr + 1, `${t} ${q} right after the camp`);
	assert.ok(list.some(({ goal, s }) => s === dunModr + 2 && goal.t === 'collect' && goal.item === 280396), 'the Heart of Modr right after it (a group step since the final review)');
	// #1319: the crossing is the Cache of Explosives (MacKreel's Moonshine moved to the Arathi guide).
	const span = list[at(list, 'interact 2704 quest 633.1', (g) => g.t === 'interact' && g.quest === 633)].s;
	assert.ok(stepOf('turnin', 631) > dunModr && stepOf('turnin', 631) < span, 'Ebenezer between Dun Modr and the span');
	// #1565: Hearts of the Lost (87318) and its follow-ups (88757, 88758) are not in the live game: no guide takes them.
	assert.ok(!list.some(({ goal }) => [87318, 88757, 88758].includes(goal.quest)), 'no Hearts of the Lost in the Hillsbrad guide (#1565)');
	const root = path.join(OFFICIAL_DIR, 'forever');
	const left = [];
	for (const rel of fs.readdirSync(root, { recursive: true }).filter((f) => f.endsWith('.guide')).sort()) {
		const guide = parseGuide(fs.readFileSync(path.join(root, rel), 'utf8'), rel, new Diagnostics());
		for (const g of guide.steps.flatMap((s) => s.goals)) if ([87318, 88757, 88758].includes(g.quest)) left.push(`forever/${rel}:${g.line} ${g.verb} ${g.quest}`);
	}
	assert.deepEqual(left, [], 'no guide takes the Hearts of the Lost chain (#1565)');
	assert.equal(list.filter(({ goal }) => goal.t === 'turnin' && goal.quest === 472).length, 1, 'one Longbraid turn-in');
});

// --- #1319 (Fyurie): MacKreel's Moonshine (647) has a 15-minute limit. The Wetlands guide took it at the Thandol Span and
// handed it in at Southshore after Menethil and the boat, too late. The Arathi guide takes it after Kor'gresh's cave, on the
// way back to Skuerto at Refuge Pointe, and hands it in straight off the flight to Southshore, with a tip naming the limit.
test(`${ARATHI}: Fyurie's report (#1319): MacKreel's Moonshine is taken after Kor'gresh and handed in straight off the Southshore flight`, { skip }, () => {
	assert.equal(goals(HILLSBRAD_ALLIANCE).filter(({ goal }) => goal.quest === 647).length, 0, 'not in the Wetlands guide');
	const list = goals(ARATHI);
	const accept = at(list, 'accept 647', is('accept', 647));
	const turnin = at(list, 'turnin 647', is('turnin', 647));
	assert.ok(accept > at(list, "Kor'gresh's wand (693)", (g) => g.quest === 693 && g.t === 'collect'), "after Kor'gresh's cave");
	assert.ok(accept < at(list, 'turnin 693', is('turnin', 693)), 'before Skuerto at Refuge Pointe');
	const fly = list.findIndex(({ goal }, i) => i > accept && goal.t === 'fly');
	assert.ok(fly > accept && list[fly].goal.location === 'Southshore', 'the next flight is to Southshore');
	assert.equal(list[turnin].s, list[fly].s + 1, 'handed in in the step right after the flight');
	assert.ok(list.slice(accept + 1, turnin).every(({ goal }) => goal.t !== 'kill' && goal.t !== 'collect'), 'nothing to kill or collect in between');
	assert.ok([list[accept].step.note, list[accept].step.tip].flat().filter(Boolean).join(' ').includes('within 15 minutes'), 'the step names the time limit');
	// Review (0.3.6): the race filter it kept came from an old per-race export; every Alliance race may take it.
	for (const i of [accept, turnin]) assert.ok(!list[i].goal.only?.races, `${list[i].goal.t} 647 is open to every Alliance race`);
});

// Flow re-order (2026-11-07): Alliance Desolace made the Scorpashi venom a stop of its own at Kormek's Hut
// after the Kodo Graveyard, then walked back to the graveyard for the last hides.
test('forever/alliance/30-40/02-desolace.guide: flow re-order: the Scorpashi venom with the kodos at the Kodo Graveyard, no Kormek\'s Hut stop', { skip }, () => {
	const list = goals('forever/alliance/30-40/02-desolace.guide');
	const kodos = list.find(({ goal }) => goal.quest === 5561 && ['kill', 'talk', 'use'].includes(goal.t)); // #1458: a talk at Smeed's camp, not a kill
	const venom = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 6248);
	const hides = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 6249);
	assert.ok(kodos && venom.length === 1 && venom[0].s === kodos.s, 'the venom on the Kodo Graveyard step');
	assert.ok(hides.length === 1 && hides[0].s === kodos.s, 'the hides there, once');
});

// #1579: the first Nijel's Point step had Vahlarriel's Vengeance taken with the first part of Vahlarriel's Search
// (1437), but she offers it with the third part (1438) when the Malem chest's part (1465) is handed back to her (the
// reporter in game, 2026-11-10, and every recorded window).
test('forever/alliance/30-40/02-desolace.guide: Vahlarriel\'s Vengeance is taken when the Malem chest\'s part of her search is handed back, not with its first part (#1579)', { skip }, () => {
	const fix = (loadCorrections().quests[97284] || {}).set || {};
	assert.deepEqual([fix.pre, fix.preAny], [[1465], [1465]], 'forever-db: 97284 comes after 1465');
	const list = goals('forever/alliance/30-40/02-desolace.guide');
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const take = at(list, 'accept 97284', is('accept', 97284));
	assert.ok(at(list, 'turnin 1437', is('turnin', 1437)) < take, 'after the first part is handed in at the Malem chest');
	assert.ok(at(list, 'turnin 1465', is('turnin', 1465)) < take, 'after the second part is handed back to Vahlarriel');
	assert.equal(list[take].s, stepOf('turnin', 1465), 'on the Nijel\'s Point stop that hands her 1465');
	assert.ok(take < at(list, 'kill 4663 (Burning Blade Augur)', is('kill', 97284)), 'before the cultists in Thunder Axe Fortress');
	if (((refData().quests[97284] || {}).pre || []).includes(1465)) assert.ok((list[take].goal.pre || []).includes(1465), `the accept waits for 1465: ${JSON.stringify(list[take].goal.pre)}`);
});

// Flow re-order (2026-11-07): Alliance Stranglethorn 30-40 took Krazek's Cookery only on the second Rebel
// Camp visit and handed it in on the last Booty Bay stop. Since the 30-40 re-order the Rebel Camp's 37s (Bookie
// Herod's chain, Krazek's Cookery) are taken on the northern loop (30-40/04b) when it starts.
test('forever/alliance/30-40/04b-stranglethorn-vale.guide: flow re-order: Krazek\'s Cookery from the Rebel Camp visit to the Booty Bay stop of the same loop', { skip }, () => {
	const list = goals('forever/alliance/30-40/04b-stranglethorn-vale.guide');
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.equal(stepOf('accept', 210), stepOf('accept', 574), 'taken from Kaleb with Special Forces');
	assert.equal(stepOf('turnin', 210), stepOf('turnin', 601), 'handed to Krazek on the Booty Bay stop that ends the loop');
	assert.equal(stepOf('accept', 627), stepOf('turnin', 210), 'Favor for Krazek taken there');
	// Alliance 30-40 audit (0.3.7): the first loop now takes Krazek's Cookery from Kaleb and hands it to Krazek, and turns
	// in Herod's records; 04b's lines stay for players who load it fresh. Favor for Krazek
	// (Arathi's Lesser Bloodstone Deposits) still waits for 04b.
	assert.ok(!goals('forever/alliance/30-40/04-stranglethorn-vale.guide').some(({ goal }) => goal.quest === 627), 'Favor for Krazek not on the first loop at 33-34');
});

// Flow re-order (2026-11-07): Alliance Arathi took the tusks and pouches from the few Witherbark west of
// Refuge Pointe and made a second trip to Witherbark Village for the knife.
test(`${ARATHI}: flow re-order: Worth Its Weight in Gold in one visit to Witherbark Village`, { skip }, () => {
	const list = goals(ARATHI);
	const work = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 691);
	assert.deepEqual(work.map(({ goal }) => goal.item).sort(), [4503, 4522, 5040], 'tusks, pouches and knife listed once each');
	assert.equal(new Set(work.map(({ s }) => s)).size, 1, 'all three on one step');
});
// Final route review, 30-40 (2026-11-07): Alliance Stranglethorn walked from Booty Bay to the river crocolisks and back
// for one hand-in, reached the haunted island only on the northern loop, then walked from Booty Bay back to the island
// for the water elementals, on to Westfall and flew to Booty Bay; Druids trained in Stormwind by way of Ironforge and the
// tram and were then sent to Menethil's flight master; Raptor Mastery's level-40 Jungle Stalkers were an along list.
// Since the 30-40 re-order (2026-11-07) the northern loop is the second Stranglethorn visit, after Desolace (04b).
test('forever/alliance/30-40/04-stranglethorn-vale.guide: final review: the island on the first loop, crocolisks and elementals on the northern one, Druids train in Stormwind', { skip }, () => {
	const file = 'forever/alliance/30-40/04-stranglethorn-vale.guide';
	const list = goals(file);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.ok(at(list, 'complete 578', is('complete', 578)) < at(list, 'turnin 605', is('turnin', 605)), 'the haunted island before the Booty Bay return');
	assert.equal(stepOf('turnin', 578), stepOf('turnin', 605), 'The Stone of the Tides handed in on that return');
	assert.ok(!list.some(({ goal }) => goal.t === 'fly' && /Booty Bay/.test(JSON.stringify(goal))), 'no flight back to Booty Bay from Westfall');
	assert.ok(!list.some(({ goal }) => [577, 601].includes(goal.quest) && goal.t !== 'accept'), 'the crocolisks and the elementals are worked on the northern loop');
	assert.equal(stepOf('accept', 577), stepOf('turnin', 578), 'their quests taken on the Booty Bay stop that ends the first loop, where Drizzlik and the Baron stand');
	assert.equal(stepOf('accept', 601), stepOf('turnin', 578), 'the elementals too');
	assert.deepEqual(compiled(file).steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const druid = list.filter(forClass('DRUID'));
	const train = druid.findIndex(({ step, goal }) => goal.t === 'train' && (step.only || goal.only));
	const sw = druid.findIndex(({ goal }) => goal.t === 'fly' && /Stormwind/.test(JSON.stringify(goal)));
	assert.ok(sw >= 0 && train > sw, 'Druids train after the flight to Stormwind');
	assert.ok(!druid.some(({ goal }) => goal.t === 'goto' && /Ironforge|Tram/.test(JSON.stringify(goal))), 'no Ironforge or tram detour');
	const northFile = 'forever/alliance/30-40/04b-stranglethorn-vale.guide';
	const north = goals(northFile);
	const northStep = (t, q) => north[at(north, `${t} ${q}`, is(t, q))].s;
	const croc = at(north, 'collect 4104', (g) => g.t === 'collect' && g.item === 4104);
	const elem = at(north, 'collect 3923', (g) => g.t === 'collect' && g.item === 3923);
	assert.ok(!north.some(({ goal }) => goal.t === 'accept' && [577, 601, 213].includes(goal.quest)), 'no Booty Bay stop at the start of the northern loop');
	assert.ok(croc > 0 && elem > 0, 'the crocolisks and the elementals worked on the northern loop');
	assert.equal(northStep('turnin', 577), northStep('turnin', 601), 'both handed in on the last Booty Bay stop');
	assert.deepEqual(compiled(northFile).steps.filter((st) => st.along).map((st) => st.title), [], '04b: no along steps');
});
// Final route review, 30-40 (2026-11-07): Warriors walked from Stormwind's flight master to Wu Shen in Old Town, back to
// Elling Trias in the Trade District and on to Dashel in Old Town; the Ironforge stop, reached by flight from Southshore,
// told players to take the tram to Ironforge.
test('forever/alliance/30-40/01-hillsbrad-foothills.guide: final review: The Islander on the Dashel stop, the Ironforge tip fits the flight', { skip }, () => {
	const list = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const islander = at(list, 'accept 1718', is('accept', 1718));
	assert.ok(islander > at(list, 'turnin 1447', is('turnin', 1447)) && islander < at(list, 'turnin 563', is('turnin', 563)), 'after Dashel, before the Keep');
	const hall = list[at(list, 'accept 1453', is('accept', 1453))];
	assert.doesNotMatch([].concat(hall.step.note || []).join(' '), /Deeprun Tram/, 'no tram in the Ironforge tip');
});

// Final route review, 30-40 (2026-11-07): Gleaning Our Future's four hearts drop only from level-32 elites the Goaz Stones
// call up (lint error with Forever's creature data), and the guide sent every player after them alone.
test('forever/alliance/30-40/01-hillsbrad-foothills.guide: final review: Gleaning Our Future is a group quest', { skip }, () => {
	const list = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const mine = list.filter(({ goal }) => goal.quest === 98310);
	assert.ok(mine.length >= 5, 'the four hearts and the hand-in');
	for (const { step, goal } of mine) assert.ok((step.when || []).some((p) => p.k === 'group' && p.q === 98310 && !p.neg), `${goal.t} 98310 is under when group 98310`);
});
// Final route review, 30-40 (2026-11-07): Alliance Wetlands & Hillsbrad put Druid training between Elling Trias's
// hand-in and accept, though Sheldras stands across the city; it now sits on the walk from the Mage Quarter, the last
// Stormwind stop before 30-40/03's flight to Menethil Harbor.
test('forever/alliance/30-40/01-hillsbrad-foothills.guide: final review: Druid training after the Mage Quarter, the last Stormwind stop', { skip }, () => {
	const list = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide').filter(forClass('DRUID'));
	const train = list.findIndex(({ goal }) => goal.t === 'train');
	assert.equal(list[at(list, 'turnin 1245', is('turnin', 1245))].s, list[at(list, 'accept 1246', is('accept', 1246))].s, 'Elling Trias in one stop');
	assert.ok(train > at(list, 'accept 1301', is('accept', 1301)), 'after the Mage Quarter');
	assert.equal(list[train].s, list[list.length - 1].s, 'the last step of the guide');
	const next = goals('forever/alliance/30-40/03-ashenvale.guide');
	const first = next.find(({ goal }) => goal.t !== 'goto');
	assert.ok(first.goal.t === 'fly' && /Menethil/.test(JSON.stringify(first.goal)), 'the next guide opens with the flight to Menethil Harbor (a goto to the flight master before it)');
});

// --- J's report (#1643): the Mage Quarter stop asked for James Hyal (1301) after They Call Him Smiling Jim (1282) was
// handed in, and Connor Rivers no longer offers it: the world DB offers 1301 only while 1282 is not rewarded, both roads
// ending in Theramore. The correction closes 1301 on 1282 (forever-db/corrections/quests.json); with it applied, as
// `data build` does, the accept is passed with its reason once 1282 is done, and still asked for without it.
test(`${HILLSBRAD_ALLIANCE}: J's report (#1643): James Hyal is not asked for once They Call Him Smiling Jim is handed in`, { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['1301'];
	assert.ok(fix, 'the corrections correct 1301');
	Object.assign(corrected.quest(1301), fix.set);
	const shaman = { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'SHAMAN', className: 'Shaman', level: 34 };
	const accepts = (before) => Object.values(engineRun(HILLSBRAD_ALLIANCE, shaman, {
		data: corrected,
		before,
		script: `local out = {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.t == "accept" and g.quest == 1301 then out[#out + 1] = g.status .. " " .. (g.unavailable or "-") .. " " .. (g.unavailableText or "") end
				end
			end
			emit(out)`,
	}));
	assert.deepEqual(accepts('w.complete({ 1282 })'), ['skipped closed No longer offered: you took “They Call Him Smiling Jim”']);
	assert.deepEqual(accepts(''), ['pending - '], 'asked for while Smiling Jim is not done');
});

// Final route review for 0.3.5 (Alliance Badlands 38-39): Lotwil's level 42 bracers were listed at his
// hand-in with no word on where they drop (the Greater Rock Elementals, 42-44, in the south-west); a note
// said Lotwil's next test needs crafted gear (that is Lucien's quest); and another said the skeleton's next
// task, Murdaloc, waits for a later guide right under the accept of Murdaloc itself.
test('Alliance Badlands: Lotwil\'s bracers, Lucien\'s crafted bracers and Murdaloc are described as they are', { skip }, () => {
	const guide = 'forever/alliance/30-40/06-badlands.guide';
	// Level tidy (0.4.0): the Bracers of Rock Binding (Greater Rock Elementals 42-44) are left out at 39.
	assert.ok(!goals(guide).some(({ goal }) => [712, 716].includes(goal.quest)), 'no Study of the Elements: Rock (712) or Lucien\'s trade (716)');
	const skips = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.skip;
	for (const q of [712, 716]) assert.ok(skips.some((e) => e.q === q), `route-fixes skips ${q}`);
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
	assert.doesNotMatch(text, /Lotwil's next test needs crafted gear/);
	assert.doesNotMatch(text, /The skeleton's next task, Murdaloc/);
});

// Final route review for 0.3.5 (Alliance Stranglethorn 33-35): after Booty Bay the route flies to Sentinel
// Hill and walks south out of Westfall to the Crystal Spine Basilisks in Stranglethorn's north-west, but
// the step's tip still said to walk back north to a mine in the middle of the jungle.
test('Alliance Stranglethorn: the basilisk step after the Sentinel Hill flight says the way leads south from Westfall', { skip }, () => {
	const guide = 'forever/alliance/30-40/04-stranglethorn-vale.guide';
	const list = goals(guide);
	const fly = at(list, 'fly Sentinel Hill', (g) => g.t === 'fly' && /Sentinel Hill/.test(g.location || ''));
	const shards = at(list, 'collect 3918 quest 605', (g) => g.t === 'collect' && g.quest === 605);
	assert.ok(fly < shards, 'the flight to Sentinel Hill comes before the basilisks');
	const [tip] = stepTips(guide, /collect 3918 quest 605\b/);
	assert.doesNotMatch(tip, /back north|middle of the jungle/);
	assert.match(tip, /Sentinel Hill/);
});

// Final route review for 0.3.5 (Alliance 30-32): the route flies into Ironforge and hands in at the Hall of
// Explorers and to Magni on the High Seat, but both steps were titled "Deeprun Tram", which this visit
// never takes (it flies on to Stormwind).
test('Alliance Hillsbrad 30-32: the Ironforge steps are not titled after the tram', { skip }, () => {
	const steps = compiled('forever/alliance/30-40/01-hillsbrad-foothills.guide').steps;
	assert.deepEqual(steps.filter((s) => /Deeprun Tram/.test(s.title || '')).map((s) => s.title), []);
	const stormpike = steps.find((s) => s.goals.some((g) => g.t === 'accept' && g.quest === 1453));
	assert.equal(stormpike.title, 'Hall of Explorers');
});

// Final route review for 0.3.5 (Alliance 30-40): Bartolo's Yeti Fur Cloak (565) also wants a Hillman's
// Cloak and a Bolt of Woolen Cloth, which no vendor sells and no step gets. It is optional, with its yeti
// cave only for players who took it, and a route-fixes record keeps it so.
test('Alliance 30-40: Bartolo\'s Yeti Fur Cloak is optional and says what it needs', { skip }, () => {
	refData();
	for (const item of [3719, 2997]) assert.deepEqual(refData().items[item].vendors || [], [], `${item} is not sold`);
	const first = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const acc = first[at(first, 'accept 565', is('accept', 565))];
	assert.ok(acc.goal.optional, 'the accept is optional');
	assert.match(acc.goal.note || '', /Hillman's Cloak/);
	const fur = first[at(first, 'collect 3720', (g) => g.t === 'collect' && g.quest === 565)];
	assert.ok(fur.goal.optional || /565/.test(JSON.stringify(fur.step.when || fur.step.conditions || '')), 'the yeti fur is only for those on it');
	assert.ok(['3719', '2997'].every((item) => (acc.step.when || []).some((p) => p.k === 'has' && !p.neg && String([p.item ?? p.q ?? p.id].flat()[0]) === item)), 'the accept step shows only with the cloak and the cloth in the bags');
	const last = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	const hand = last[at(last, 'turnin 565', is('turnin', 565))];
	assert.ok(hand.goal.optional || (hand.step.when || []).some((p) => ['complete', 'onquest'].includes(p.k) && !p.neg && [p.q].flat().includes(565)), 'the hand-in is only for those on it');
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.optional.find((o) => o.q === 565);
	assert.ok(rec, 'optional is a record');
});

// Final route review for 0.3.5 (Alliance 32-33): from the Mirage Raceway the guide walked back west to the
// Great Lift, north through the Barrens and east through Dustwallow to Theramore (about 5,800 yd). It now
// takes the road south to Gadgetzan (about 1,000 yd), learns the flight path and flies to Theramore.
test('Alliance Thousand Needles: from the Raceway to Gadgetzan and a flight to Theramore, not back through the Barrens', { skip }, () => {
	const list = goals('forever/alliance/30-40/03-ashenvale.guide');
	const race = at(list, 'turnin 1176', is('turnin', 1176));
	const fp = at(list, 'getfp Gadgetzan', (g) => g.t === 'getfp' && /Gadgetzan/.test(g.location || ''));
	const fly = at(list, 'fly Theramore', (g) => g.t === 'fly' && /Theramore/.test(g.location || ''));
	const fiora = at(list, 'turnin 1135', is('turnin', 1135));
	assert.ok(race < fp && fp < fly && fly < fiora, 'Raceway, Gadgetzan, the flight, then Theramore');
	assert.ok(!list.slice(race, fiora).some(({ goal }) => goal.t === 'goto' && goal.map === 1445 && goal.x < 40), 'no walk past the Shady Rest Inn');
});

// --- Hillsbrad's Hoard (98059, 2026-11-08): its one objective is to use the Sealed
// Company Request at the Hillsbrad council in the Hillsbrad Fields (players'
// recordings: 3 people completed it there; the server's quest record in players'
// caches has the same objective). The guide accepted and handed it in on the spot.
test(`${HILLSBRAD_ALLIANCE}: Hillsbrad's Hoard is delivered at the Hillsbrad council after the Syndicate camp, then handed in at Southshore (optional)`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const take = at(list, 'accept 98059', is('accept', 98059));
	const use = at(list, 'use 279386 (Sealed Company Request)', (g) => g.t === 'use' && g.item === 279386 && g.quest === 98059);
	const hand = at(list, 'turnin 98059', is('turnin', 98059));
	assert.ok(take < use && use < hand, 'accept, deliver, then hand in');
	assert.ok(list[use].s !== list[take].s && list[hand].s !== list[use].s, 'three stops, not one');
	assert.ok(!list.some(({ goal }) => is('accept', 511)(goal)), 'the Syndicate camp is in 30-40/05 now (level tidy): the delivery is its own short trip west');
	const g = list[use].goal;
	assert.ok(g.map === 1424 && Math.abs(g.x - 29.7) < 0.5 && Math.abs(g.y - 41.7) < 0.5, `at the Hillsbrad council (${g.map} ${g.x},${g.y})`);
	// The delivery and hand-in are for players on it (`when onquest`, Alliance 30-40 audit: an optional goal in such a step never held it).
	assert.ok(list[take].goal.optional, 'accept 98059 stays optional');
	for (const i of [use, hand]) assert.ok(list[i].goal.optional || (list[i].step.when || []).some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(98059)), `${list[i].goal.t} 98059 only for players on it`);
});

// A step meant for players on a quest (`when onquest|complete Q`) whose goals are all optional is done at once (the
// Engine's goalsDone skips optional goals), so the guide moved past Carnage's flesh, the yeti fur, the Hillsbrad
// council and Bartolo's hand-in without leading anyone there. Sweep: ~/work/maintainer/optional-gated-sweep/allopt.py.
test('Alliance 30-40 audit: a step for players on a quest holds them there (not all of its goals optional)', { skip }, () => {
	const bad = [];
	for (const guide of A3040) {
		for (const step of compiled(guide).steps) {
			if (!(step.when || []).some((p) => ['onquest', 'complete'].includes(p.k) && !p.neg)) continue;
			const work = step.goals.filter((g) => g.t !== 'note');
			if (work.length && work.every((g) => g.optional)) bad.push(`${guide}: "${step.title}"`);
		}
	}
	assert.deepEqual(bad, []);
});

test('Alliance 30-40 audit: Stranglethorn\'s first loop hands in what it walks past (Erlgadin, Herod\'s records, Kaleb to Krazek)', { skip }, () => {
	const list = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	const panther = at(list, 'turnin 191', is('turnin', 191));
	assert.ok(panther < at(list, 'accept 215', is('accept', 215)), 'Panther Mastery is handed in before the walk north to the Rebel Camp');
	const kurzen = list[at(list, 'kill 937 quest 203', (g) => g.t === 'kill' && g.quest === 203)].s;
	for (const [t, q] of [['turnin', 200], ['accept', 328]]) assert.equal(list[at(list, `${t} ${q}`, is(t, q))].s, kurzen, `${t} ${q} on the Kurzen stop`);
	const kaleb = list[at(list, 'accept 210', is('accept', 210))];
	assert.equal(kaleb.goal.npc, 770, 'from Corporal Kaleb');
	assert.ok(at(list, 'turnin 210', is('turnin', 210)) < at(list, 'fly Sentinel Hill', (g) => g.t === 'fly' && /Sentinel Hill/.test(g.location || '')), 'handed to Krazek on the first Booty Bay stop');
	const grinds = list.filter(({ goal }) => goal.t === 'level').map(({ goal }) => goal.level);
	// Level tidy (0.4.0): one short top-up to 33 on the Kurzen Jungle Fighters (32-33), before the elder tigers (34-35):
	// recorded players there are at 34.3 (25th percentile), a level over the model, which the frozen level rule credits.
	assert.deepEqual(grinds, [33], `one top-up, to 33 (${grinds})`);
	const top = list.find(({ goal }) => goal.t === 'level').goal;
	assert.ok(top.npc === 937 || top.grind === 937 || JSON.stringify(top).includes('937'), 'on the Kurzen Jungle Fighters');
	assert.ok(list.findIndex(({ goal }) => goal.t === 'level') < at(list, 'kill 1085', (g) => g.t === 'kill' && g.npc === 1085), 'before the elder tigers');
});

test('Alliance 30-40 audit: Arathi hands in at Refuge Pointe on the way west, the Swamp of Sorrows ends at Watcher Biggs', { skip }, () => {
	const list = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	assert.ok(at(list, 'turnin 681', is('turnin', 681)) < at(list, 'accept 663', is('accept', 663)), 'Northfold Manor before Faldir\'s Cove');
	assert.ok(at(list, 'accept 693', is('accept', 693)) < at(list, 'accept 663', is('accept', 663)), "Trelane's Wand taken on the same stop");
	assert.ok(at(list, 'turnin 1389', is('turnin', 1389)) < at(list, 'turnin 1421', is('turnin', 1421)), 'the Harborage, then Watcher Biggs');
	assert.ok(!list[at(list, 'turnin 1392', is('turnin', 1392))].goal.optional, 'a quest the route makes you do (1392) is handed in');
	for (const q of [523, 537, 551]) assert.ok(!list.some(({ goal }) => goal.quest === q), `${q} (Vardus or Nagaz, 40) is left out at 38 (level tidy)`);
	const weevil = list[at(list, 'collect 213568 (Hay Weevil Specimen)', (g) => g.t === 'collect' && g.item === 213568)];
	assert.ok(whenOn(weevil.step, 'onquest', 93176), 'the Hay Weevil only for players on My Little Friends');
});

// The Howin round trip (98230) stays on the Defeat Nek'rosh group branch only (0.3.6's #1299 fix, kept: Main,
// 2026-11-09): a solo player never sees it. Word to Ironforge (98300), once taken on the same stop, is left out
// (route-fixes skip): Howin offers it only after Death to the Dragonmaw (98291) and Stopping the Cycle (98297),
// which the route does not take (QuestieDB 1.0.16, players' recordings).
test('Alliance 30-40 audit: Wetlands 30-32 sends only group players to Howin, Trying Times and Carnage are handed in only when done', { skip }, () => {
	const list = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const mine = list.filter(({ goal }) => goal.quest === 98230);
	assert.ok(mine.length > 0, '98230 is on the group branch');
	for (const { step } of mine) assert.ok(whenOn(step, 'group', 474), '98230: only for group players');
	assert.deepEqual(list.filter(({ goal }) => goal.quest === 98300).map(({ goal }) => `${goal.t} 98300`), [], 'no Word to Ironforge');
	const eggs = list[at(list, 'collect 280132 quest 98246.1', (g) => g.t === 'collect' && g.quest === 98246)];
	assert.ok(whenOn(eggs.step, 'onquest', 98246), 'the eggs only for players on Trying Times');
	for (const q of [98246, 98283]) assert.ok(whenOn(list[at(list, `turnin ${q}`, is('turnin', q))].step, 'complete', q), `${q} handed in only when complete`);
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(!rf.overrides.skip.some((e) => e.q === 98230 && e.faction === 'Alliance'), 'no skip for 98230');
	assert.ok(rf.overrides.skip.some((e) => e.q === 98300 && !e.faction), 'route-fixes leaves 98300 out');
});

test('Alliance 30-40 audit: Lucien and Lotwil\'s bracers only for players who can do them', { skip }, () => {
	const list = goals('forever/alliance/30-40/06-badlands.guide');
	// Level tidy (0.4.0): left out of the solo route (Greater Rock Elementals 42-44 at 39); Lucien's trade needs them.
	for (const q of [712, 716]) assert.ok(!list.some(({ goal }) => goal.quest === q), `${q} is not in the guide`);
	at(list, 'turnin 711 (the slabs are still handed in)', is('turnin', 711));
});

test('Alliance 30-40 audit: Vahlarriel\'s Vengeance is done on the Thunder Axe Fortress visit', { skip }, () => {
	const list = goals('forever/alliance/30-40/02-desolace.guide');
	const fort = list[at(list, 'collect 6767 quest 1439', (g) => g.t === 'collect' && g.quest === 1439)].s;
	for (let n = 1; n <= 4; n++) assert.equal(list[at(list, `97284.${n}`, (g) => g.t === 'kill' && g.quest === 97284 && g.oi === n)].s, fort, `objective ${n} in the fortress step`);
	assert.ok(at(list, 'accept 97284', is('accept', 97284)) < at(list, 'turnin 97284', is('turnin', 97284)));
	const inc = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	assert.ok(inc.some((e) => e.q === 97284 && /Quest volume/.test(e.reason)), 'include recorded');
});

// Retrieval for Mauren (1078, level 26, accepted at the end of 06-ashenvale) had its scales farmed on gray basilisks in
// Stonetalon at 35 and was handed in at 35.5: the Saltstone Basilisks the Raceway step kills drop them too (Forever's
// item data, 20%: optional, no farm), and the first loop's Stormwind stop, when complete, is the next visit to Collin Mauren.
test('Alliance 30-40 audit: Retrieval for Mauren on the Raceway basilisks, handed in on the first Stormwind stop', { skip }, () => {
	const g03 = goals('forever/alliance/30-40/03-ashenvale.guide');
	const scales = g03[at(g03, 'collect 5675 quest 1078.1', (g) => g.t === 'collect' && g.quest === 1078)];
	assert.equal(scales.s, g03[at(g03, 'collect 5795 quest 1105', (g) => g.t === 'collect' && g.quest === 1105)].s, 'on the Raceway step, where the Saltstone Basilisks roam');
	const g04 = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	assert.ok(!g04.some(({ goal }) => goal.t === 'collect' && goal.quest === 1078), 'no scale farm in Stonetalon');
	assert.ok(at(g04, 'turnin 1078', is('turnin', 1078)) < at(g04, 'fly Astranaar', (g) => g.t === 'fly' && /Astranaar/.test(g.location || '')), 'handed in before the boat north');
	assert.ok(scales.goal.optional, 'no farm for a level-26 quest: the scales come with the basilisks the step kills anyway');
	assert.ok((g04[at(g04, 'turnin 1078', is('turnin', 1078))].step.when || []).some((p) => p.k === 'complete' && [p.q].flat().includes(1078)), 'Collin only when complete');
});

// Fyurie's report (#1425): Private Thorsen gives Jungle Secrets and takes Supplies to Private Thorsen. The server's
// path for him (Forever's world database: creature 20002243, waypoint path 800022430) keeps him about 28 minutes at
// the top of the Rebel Camp's path and a few minutes at the road end, where the data's spawn (and the arrow) was.
test("Fyurie's report (#1425): Private Thorsen is looked for at the top of the Rebel Camp's path, with his walk in the tip", { skip }, () => {
	const guide = 'forever/alliance/30-40/04-stranglethorn-vale.guide';
	const list = goals(guide);
	// Jungle Secrets (215) is offered only at the road end since #1752 (its own case below).
	for (const [t, q] of [['turnin', 198]]) {
		const { goal, step } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(goal.map === 1434 && Math.abs(goal.x - 38.0) < 0.3 && Math.abs(goal.y - 3.4) < 0.3, `${t} ${q} at his camp spot (${goal.x},${goal.y})`);
		assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /walks down it to the road/, `${t} ${q}: the tip says he walks`);
	}
	const pl = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8')).places;
	assert.ok(pl.some((p) => p.quest === 198 && p.objective === 'ender' && p.issue === 1425), '198 ender place recorded');
	assert.ok(pl.some((p) => p.quest === 215 && p.objective === 'giver' && p.issue === 1752 && p.at.x === 40.3), '215 giver place at the road end (#1752)');
});

// Final route review 0.3.6, Alliance 32-33: Fiora Longears stands inside Theramore's inn (66.4,45.2, the innkeeper's
// spot), not on the docks where the Menethil boat lands; Red Jack Flint by Menethil Keep's door, as 30-40/01 says.
test('Alliance Theramore crossing: Fiora Longears is in the inn, Red Jack Flint by the keep door', { skip }, () => {
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/alliance/30-40/03-ashenvale.guide'), 'utf8');
	assert.doesNotMatch(text, /Fiora Longears[^\n]*docks/, 'no step puts Fiora on the docks');
	assert.match(text, /turnin 1132\s+-- Fiora Longears, inside the inn/, 'the hand-in says where she is');
	assert.match(text, /tip Red Jack Flint stands by Menethil Keep's door/, 'Red Jack Flint by the keep door');
});

// Final route review 0.3.6, Alliance 36-38: the Quae step came from the Stone of East Binding but said "north-east past
// Refuge Pointe" (she camps south of it, by Go'Shek Farm); the Alterac step put Baron Vardus on "the manor grounds",
// where none of his five spawn points is (Strahnbrad's inn cellar, the tent camps north and north-west).
test('Alliance Arathi & Alterac: Quae and Baron Vardus tips match the map', { skip }, () => {
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/alliance/30-40/05-arathi-highlands.guide'), 'utf8');
	assert.doesNotMatch(text, /north-east past Refuge Pointe; Quae/, 'Quae is south of the eastern circle');
	assert.doesNotMatch(text, /Baron Vardus walks the manor grounds/, 'Vardus is not on the manor grounds');
	assert.match(text, /Baron Vardus \(40\) turns up in one spot at a time/, 'the Alliance tip names his spots, as the Horde one does');
});

// Final route review 0.3.6, Alliance 38-39 Desolace: the Kodo Graveyard step held a bare `kill 217590` (Flesh Picker,
// for the optional My Little Friends), a check-off every player had to tick, quest or not. It is now its own step for
// players on 93176, with the specimen counted in the bags, as Arathi's Hay Weevil and Stranglethorn's Arbor Tarantula.
test('Alliance Desolace south loop: the Flesh Picker is only for players on My Little Friends', { skip }, () => {
	const list = goals('forever/alliance/30-40/06b-desolace.guide');
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.npc === 217590), 'no bare Flesh Picker check-off');
	const pick = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 213567);
	assert.equal(pick.length, 1, 'one Flesh Picker Specimen goal');
	assert.ok((pick[0].step.when || []).some((p) => p.k === 'onquest' && !p.neg), 'only while My Little Friends is in the log');
});

// Position sweep (0.3.6, class B2: a walking NPC shown at one point): the Forsaken Courier walks the road from Go'Shek
// Farm west across Arathi (CMaNGOS: a 1,426 yd waypoint walk; 10 people met him anywhere from 61,59 to 24,43), and the
// step pointed only at his spawn. The arrow now searches his road, from the farm west.
test('Arathi Highlands (Alliance 36): the Forsaken Courier is searched for along his road', { skip }, () => {
	const list = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	const { goal } = list[at(list, 'collect 4482', (g) => g.t === 'collect' && g.item === 4482)];
	const spots = (goal.spots || []).filter((s) => !s.alt);
	assert.ok(spots.length >= 6, `the arrow searches his road: ${JSON.stringify(goal.spots)}`);
	assert.ok(spots[0].x > 55 && spots[spots.length - 1].x < 30, 'from Go\'Shek Farm west');
});

// Review (0.3.6, Alliance 30-40): Sully Balloo's Letter (637), Sara Balloo's Plea (683) and MacKreel's Moonshine (647) are
// open to every Alliance race (Forever's server data: race mask 77 for 637, all races for 683 and 647; a Dwarf took 683
// from Sara Balloo in the recordings), but the guides kept per-race filters from an old per-race route export: Humans
// never saw 637 or 647, and only Skyborne saw 683, although every race passes the givers on the same stops.
test('Alliance 30-40: the Balloo letters and MacKreel\'s Moonshine for every Alliance race', { skip }, () => {
	const wet = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	for (const [t, q] of [['accept', 637], ['turnin', 637], ['accept', 683], ['turnin', 683]]) {
		assert.ok(everyone(wet[at(wet, `${t} ${q}`, is(t, q))]), `${t} ${q} has no race filter`);
	}
	const ara = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	for (const t of ['accept', 'turnin']) assert.ok(everyone(ara[at(ara, `${t} 647`, is(t, 647))]), `${t} 647 has no race filter`);
});

// Alliance 30-40 Desolace (0.3.6): Karnitol's Chest lies beside Azore's tower, which the
// first Desolace visit (02) climbs for the Sceptre of Light, so the chain is opened there and its report goes in on that
// visit's last Kreldig stop. The south loop (06) then dives for the satchel on its one trip to the north-west coast, opens
// Rackmore's Chest (every race: the quest's race mask is all) right after the Serpent Statue, and visits Nijel's Point
// once at the end instead of walking back to it from the wreck in the middle of the loop.
test('Alliance Desolace: the Karnitol chest on the first visit, one Nijel\'s Point stop and Rackmore for every race on the south loop', { skip }, () => {
	const des = goals('forever/alliance/30-40/02-desolace.guide');
	assert.equal(des[at(des, 'accept 1454', is('accept', 1454))].s, des[at(des, 'turnin 1453', is('turnin', 1453))].s, 'taken from Kreldig with his letter');
	const azore = at(des, 'accept 5741', is('accept', 5741));
	const chest = at(des, 'turnin 1454', is('turnin', 1454));
	assert.equal(des[chest].s, des[azore].s + 1, 'the chest right after Azore');
	assert.ok(chest < at(des, 'turnin 1438', is('turnin', 1438)), 'before Thunder Axe Fortress');
	const report = at(des, 'turnin 1455', is('turnin', 1455));
	assert.equal(des[report].s, des[at(des, 'turnin 1459', is('turnin', 1459))].s, "on the last Kreldig stop");
	assert.equal(des[at(des, 'accept 1456', is('accept', 1456))].s, des[report].s, 'the satchel errand taken there');

	const sth = goals('forever/alliance/30-40/06b-desolace.guide');
	const satchel = at(sth, 'collect 6245', (g) => g.t === 'collect' && g.quest === 1456);
	const statue = at(sth, 'use 15766', (g) => g.t === 'use' && g.quest === 6027);
	const golden = at(sth, 'collect 15881', (g) => g.t === 'collect' && g.item === 15881);
	assert.ok(sth[satchel].s <= sth[golden].s && sth[golden].s <= sth[statue].s, 'the golden key on the naga coast, between the satchel and the statue');
	const claim = at(sth, 'turnin 6161', is('turnin', 6161));
	assert.equal(sth[claim].s, sth[statue].s + 1, "Rackmore's Chest right after the statue");
	for (const i of [at(sth, 'accept 6161', is('accept', 6161)), sth.findIndex(({ goal }) => goal.t === 'collect' && goal.quest === 6161), golden, claim]) {
		assert.ok(everyone(sth[i]), `${sth[i].goal.t} 6161 has no race filter`);
	}
	const kreldig = sth.map(({ goal }, i) => ((goal.t === 'turnin' && [1455, 1456, 1466].includes(goal.quest)) || (goal.t === 'accept' && [1457, 1467].includes(goal.quest)) ? i : -1)).filter((i) => i >= 0);
	assert.ok(kreldig.every((i) => i > satchel && sth[i].s === sth[kreldig[kreldig.length - 1]].s), "Kreldig's hand-ins on one stop after the coast");
	assert.ok(!sth.some(({ goal }) => is('accept', 1456)(goal)), 'the satchel errand comes from 02');
});

// Review (0.3.6, Alliance 30-40/03): Glorin Steelbrow spawns in the Deepwater Tavern (10.6,60.6), beside Mikhail,
// whom the next step visits; the tip sent players up Menethil Keep, where Captain Stoutfist stands.
test('Alliance Menethil 32: Glorin Steelbrow is in the Deepwater Tavern, not the keep', () => {
	const guide = 'forever/alliance/30-40/03-ashenvale.guide';
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.id === 'ba3040-menethil-glorin-in-the-tavern');
	assert.ok(rec, 'the tip is a record');
	const tips = stepTips(guide, /^\s+turnin 270\b/);
	assert.deepEqual(tips, [rec.tip]);
	assert.match(tips[0], /Deepwater Tavern/);
	assert.doesNotMatch(tips[0], /keep\./);
});

// Alliance 30-40 Arathi (0.3.6): from Northfold Manor the loop goes once round, east
// along the north to the Shards of Myzrael and Drywhisker Gorge, back to the Stone of East Binding, south to Witherbark
// Village and north-west to Quae. The guide went to the troll village in the south-east first, then north to the shards,
// east to the gorge and south again to Quae.
test('Alliance Arathi: Northfold, the shards and the gorge, then Witherbark Village on the way to Quae; the eastern circle after Kinelory', { skip }, () => {
	const list = goals(ARATHI);
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const northfold = stepOf('kill 2589', (g) => g.t === 'kill' && g.quest === 681);
	const shards = stepOf('accept 651', is('accept', 651));
	const east = stepOf('collect 4484', (g) => g.t === 'collect' && g.item === 4484);
	const trolls = stepOf('collect 5040', (g) => g.t === 'collect' && g.item === 5040);
	const quae = stepOf('turnin 659', is('turnin', 659));
	const kinelory = stepOf('turnin 660', is('turnin', 660));
	assert.ok(northfold < shards && shards < trolls && trolls < quae, `Northfold ${northfold}, shards ${shards}, Witherbark ${trolls}, Quae ${quae}`);
	assert.equal(trolls, shards + 1, 'Witherbark right after the shards');
	assert.equal(quae, trolls + 1, 'Quae right after the village');
	// Level tidy (0.4.0): the Cresting Exiles (38-39) at the eastern circle, at about 38 after Kinelory's errand, not at 37.
	assert.equal(east, kinelory + 1, 'the eastern circle right after Kinelory, by Quae\'s camp');
	assert.ok(east < stepOf('turnin 681', is('turnin', 681)), 'before Refuge Pointe');
});

// Alliance 30-40/04b (0.3.6): the Shadowmaw Panthers live around Lake Nazferiti and by
// the Skullsplitter ruins, the Tumbled Crystals' geologists on Lake Nazferiti's shore, none of them by the north-west
// tablets, where the guide listed them (the arrow went from Zul'Kunda south to 36,34 and back north), and the Rebel Camp
// was visited three times. Panther Mastery is now taken on the way in, the lake worked right after Kurzen's Compound,
// and the Rebel Camp's hand-ins made on one stop after the tablets.
test('Alliance Stranglethorn 35: Lake Nazferiti after Kurzen\'s Compound, the tablets west, the Rebel Camp once at the end', { skip }, () => {
	const list = goals('forever/alliance/30-40/04b-stranglethorn-vale.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const kurzen = stepOf('kill 938', (g) => g.t === 'kill' && g.quest === 574);
	const crystals = stepOf('collect 4106', (g) => g.t === 'collect' && g.item === 4106);
	const tablets = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 207).map(({ s }) => s);
	assert.equal(crystals, kurzen + 1, 'Lake Nazferiti right after the compound');
	assert.ok(tablets.every((s) => s > crystals), 'the tablets after the lake');
	for (const { goal } of list.filter(({ goal }) => goal.t === 'collect' && goal.item === 4106)) {
		assert.ok(goal.map === 1434 && goal.x > 40 && goal.y > 15 && goal.y < 30, `${goal.t} ${goal.quest} at Lake Nazferiti (${goal.x},${goal.y})`);
	}
	// Level tidy (0.4.0, #2365): Panther Mastery (Shadowmaw 37-38) and Troll Witchery (Skullsplitters 39-42) are worked in 40-50/01.
	assert.ok(!list.some(({ goal }) => [192, 193, 205].includes(goal.quest) && goal.t !== 'accept'), 'no Panther Mastery or Troll Witchery work at 35-36');
	const rebel = list.filter(({ goal }) => goal.t === 'turnin' && [329, 330, 331, 574, 207].includes(goal.quest)).map(({ s }) => s);
	assert.equal(new Set(rebel).size, 1, 'every Rebel Camp hand-in on one stop');
	assert.ok(rebel[0] > Math.max(...tablets), 'after the last tablet');
});

// rockzors (#1602, 0.3.6): "include Carved Centaur Totems with the Centaur Bounty quest". Players' recordings
// (build 70862, 41 drops, 5 contributors) have Carved Centaur Totem (254432) dropping from six Kolkar and seven
// Magram kinds; the merged data listed only the Maraudine, so the quest waited for the south loop's Valley of
// Spears (30-40/06). A forever-db correction adds the droppers and the first visit takes it with Centaur Bounty.
test('rockzors (#1602): Alliance Desolace takes Carved Centaur Totems with Centaur Bounty at Kolkar Village', { skip }, () => {
	const kolkar = [4632, 4633, 4634, 4635, 4636, 4637];
	const magram = [4638, 4639, 4640, 4641, 4642, 4643, 4645];
	const corr = JSON.parse(fs.readFileSync(path.join(ROOT, 'forever-db', 'corrections', 'items.json'), 'utf8'))['254432'];
	assert.ok(corr, 'the drops are a correction');
	assert.deepEqual(corr.addDrops.npc, [...kolkar, ...magram]);
	assert.ok([corr.source].flat().some((s) => s.kind === 'recording'), 'cites the recordings');
	refData();
	const droppers = Object.keys(refData().items[254432]?.drops?.npc || {}).map(Number);
	assert.ok(kolkar.every((n) => droppers.includes(n)), 'the data has the Kolkar droppers (rebuild data/forever with forge data build so the correction applies)');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.include.some((e) => e.q === 93224 && e.after?.[0] === 'accept' && e.after?.[1] === 1387), 'the route record');
	const list = goals('forever/alliance/30-40/02-desolace.guide');
	const step = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(step('accept 93224', is('accept', 93224)), step('accept 1387', is('accept', 1387)), 'Pentigast with Melkins');
	const totems = at(list, 'collect 254432', (g) => g.t === 'collect' && g.quest === 93224);
	assert.equal(list[totems].s, step('collect 6067', (g) => g.t === 'collect' && g.quest === 1387), 'the totems with the ears');
	const handIn = at(list, 'turnin 93224', is('turnin', 93224));
	assert.ok(handIn > totems && list[handIn].s === step('turnin 1387', is('turnin', 1387)), 'both hand-ins on the last Nijel\'s Point stop');
	const south = goals('forever/alliance/30-40/06b-desolace.guide');
	at(south, 'accept 93224 (06b keeps it for a fresh start)', is('accept', 93224));
	at(south, 'turnin 93224 (06b)', is('turnin', 93224));
});

// Roaming-NPC sweep: the Alliance 'Fallow Sanctuary' step waited for Noboru the Cudgel (5477), who walks a 56-node path
// through the ruins: his cudgel and Noboru the Cudgel (1392) are optional; the hand-in at Magtoor stays a plain goal.
test('forever/alliance/30-40/05-arathi-highlands.guide: Noboru\'s cudgel and quest are optional, the hand-in is not', { skip }, () => {
	const list = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	assert.ok(list[at(list, 'collect 6196', (g) => g.t === 'collect' && g.item === 6196)].goal.optional, 'the cudgel never holds the step');
	assert.ok(list[at(list, 'accept 1392', is('accept', 1392))].goal.optional, 'nor its accept');
	assert.ok(!list[at(list, 'turnin 1392', is('turnin', 1392))].goal.optional, 'Magtoor takes it from whoever carries it');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.optional;
	assert.ok(rf.some((e) => e.q === 1392), 'route-fixes deliberate.optional 1392');
});

// #1542: Assassin's Contract (3668, starts 522) drops only from the Shadowy Assassin (2434), one stealthed mob on
// Southshore's edge that few players find, and the Southshore step held until he came: his kill, the contract and both
// quests of the chain (522, then Baron's Demise 523) are optional now, so home and Magistrate Henry Maleb's hand-in and
// next quest finish the step. Whoever carries a quest of the chain still hands it in.
test('Alliance Arathi Highlands: the Shadowy Assassin never holds the Southshore step (#1542)', { skip }, () => {
	const list = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	const { step } = list[at(list, 'kill 2434', (g) => g.t === 'kill' && g.npc === 2434)];
	const chain = (g) => (g.t === 'kill' && g.npc === 2434) || (g.t === 'collect' && g.item === 3668) || (g.t === 'accept' && g.quest === 522);
	assert.equal(step.goals.filter(chain).length, 3, 'the kill, the contract and the accept are on the step');
	for (const g of step.goals.filter(chain)) assert.ok(g.optional, `${g.t} ${g.quest || g.npc || g.item} never holds the step`);
	for (const g of step.goals.filter((g) => !chain(g) && g.t !== 'turnin')) assert.ok(!g.optional, `${g.t} ${g.quest || g.location || ''} still does`);
	assert.ok(!list[at(list, 'turnin 522', is('turnin', 522))].goal.optional, 'whoever carries 522 hands it in');
	// Level tidy (0.4.0): Baron's Demise (Baron Vardus, 40) and Dark Council (Nagaz, 40) are left out at 38.
	assert.ok(!list.some(({ goal }) => [523, 525, 537].includes(goal.quest)), 'no Baron\'s Demise, Further Mysteries or Dark Council');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(rf.deliberate.optional.some((e) => e.q === 522), 'route-fixes deliberate.optional 522');
	for (const q of [523, 537]) assert.ok(rf.overrides.skip.some((e) => e.q === q), `route-fixes skips ${q}`);
});

// mutaka's report (#1752): Private Thorsen did not offer Jungle Secrets (215) at the arrow, his camp spot. The game
// offers it only while he is out of the Rebel Camp (a quest condition on his area): at the foot of the path, where
// two Kurzen's Agents ambush him for a few minutes of each half-hour round. All 9 recorded offers were there, none at
// the camp. The accept points there, is optional (he is often not), and Bookie Herod after it goes with it.
test("mutaka's report (#1752): Jungle Secrets from Private Thorsen at the foot of the Rebel Camp's path, optional", { skip }, () => {
	const guide = 'forever/alliance/30-40/04-stranglethorn-vale.guide';
	const list = goals(guide);
	const take = list[at(list, 'accept 215', is('accept', 215))];
	assert.equal(take.goal.optional, true, 'optional: he offers it only a few minutes of each round');
	assert.ok(Math.abs(take.goal.x - 40.3) < 0.3 && Math.abs(take.goal.y - 8.4) < 0.3, `at the foot of the path, not the camp: ${take.goal.x},${take.goal.y}`);
	const s = take.s;
	const who = { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'SHAMAN', className: 'Shaman', level: 37 };
	const view = engineRun(guide, who, {
		before: 'w.onQuest(210, { 1 }); w.onQuest(203, { 1 }); w.onQuest(204, { 1 })',
		script: `local out = {}
			for _, g in ipairs(E.GetStepView(${s}).goals) do if g.quest == 215 or g.quest == 200 then out[#out + 1] = g.t .. " " .. g.quest .. " " .. g.status end end
			emit(out)`,
	});
	// Without Jungle Secrets nothing of it holds the step: its hand-in is not this character's, Bookie Herod waits on it.
	assert.deepEqual(Object.values(view).filter((v) => !v.startsWith('accept 215')).map((v) => v.replace(/ (na|skipped)$/, ' passed')), ['turnin 215 passed', 'accept 200 passed']);
});

// 0.4.0 route audit (Refs #2025): Scrounging (733) was collected at Agmond's End on the Badlands loop and handed in to
// Sigrun Ironhew only on 40-50/01's return to Hammertoe's Digsite at about 43. It is handed in on the loop itself, right
// after the second Valley of Fangs stop (Sigrun about 330 yd east of it), before Thelsamar ends the guide.
test(`${BADLANDS}: Scrounging is handed in on the Badlands loop, after the second Valley of Fangs stop`, { skip }, () => {
	const list = goals(BADLANDS);
	const back = at(list, 'turnin 733', is('turnin', 733));
	assert.ok(back > at(list, 'collect 4630 (Scrap Metal)', (g) => g.t === 'collect' && g.quest === 733), 'after the scrap');
	assert.ok(back > at(list, 'turnin 703', is('turnin', 703)), 'after the second Valley of Fangs stop');
	assert.ok(back < at(list, 'turnin 2500', is('turnin', 2500)), 'before Thelsamar');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.faction === 'Alliance' && `${p.a}` === 'turnin,703' && `${p.b}` === 'turnin,733'), 'a record the build keeps');
});

// 0.4.0 route audit (Refs #2025): between Ironforge's training in 30-40/01 (players at about 32.5) and Stormwind's in
// 30-40/05 (about 37.5) nobody but Druids trained, though 30-40/04's Stormwind stop (players at about 35) walks the
// Trade District for Blessed Arm. Every class that trains in Stormwind trains there.
test("forever/alliance/30-40/04-stranglethorn-vale.guide: every class but Shamans trains on the Stormwind stop", { skip }, () => {
	const list = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	const train = list.filter(({ goal }) => goal.t === 'train');
	assert.equal(train.length, 1, 'one training stop');
	const arm = list[at(list, 'turnin 322 (Blessed Arm)', is('turnin', 322))].s;
	assert.ok(train[0].s > arm && train[0].s <= arm + 2, 'on the Stormwind stop, after Grimand Elmore');
	for (const cls of ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'DRUID']) assert.ok(forClass(cls)(train[0]), `${cls} trains there`);
	assert.ok(!forClass('SHAMAN')(train[0]), 'Shamans train in Ironforge');
});

// 0.4.0 route audit (Refs #2025, the #1508 pattern): 30-40/05 walked every character from Ironforge through the Dun
// Morogh tunnel to Thelsamar, though every Alliance character has had the Thelsamar flight path since 03-loch-modan
// (Dwarves and Gnomes since their start). Players' recordings: 3 of 8 people flew it (1-2 minutes), 5 walked (9-27).
// The flight is for whoever knows the flight path, the walk for whoever Polestar hasn't seen learn it.
test(`${ARATHI}: Ironforge to Thelsamar by flight when you know the flight path, the tunnel when you don't`, { skip }, () => {
	const list = goals(ARATHI);
	const fly = list[at(list, 'fly Thelsamar', (g) => g.t === 'fly' && /Thelsamar/.test(g.location || g.text || ''))];
	assert.ok((fly.step.when || []).some((p) => p.k === 'taxi' && !p.neg), 'the flight is when taxi "Thelsamar"');
	const walk = list.find(({ step, goal }) => goal.t === 'goto' && /Thelsamar/.test(goal.text || goal.location || '') && (step.when || []).some((p) => p.k === 'taxi' && p.neg));
	assert.ok(walk, 'the tunnel walk is when !taxi "Thelsamar"');
	assert.ok(!list.some(({ step }) => step.only && step.only.races), 'no step of this guide goes by race');
});

// 0.4.0 route audit (Refs #2025): 30-40/03 sends players down the Great Lift into Thousand Needles for Highperch with no
// word on the lift; players' recordings show 11 deaths of 3 people there on this guide's way down, none with an attacker
// recorded (falls). The step says to wait for the lift.
test(`${ASHENVALE_30}: the Great Lift step says to wait for the lift`, { skip }, () => {
	const list = goals(ASHENVALE_30);
	const sac = list[at(list, 'collect 5809', (g) => g.t === 'collect' && g.item === 5809)];
	const tip = [].concat(sac.step.note || []).join(' ');
	assert.match(tip, /Careful:.*lift is level/, tip);
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.id === '2025-great-lift-wait');
	assert.ok(rec, 'a record the build keeps');
	assert.equal(rec.tip, tip, 'the guide carries the record\'s tip');
});

// 0.4.0 route audit (Refs #2025): 30-40/04's Kurzen's Compound step sends players to the compound's outer edge for its
// level 32 Jungle Fighters, while Kurzen Elites and Witch Doctors (36) hold its eastern half; players' recordings: 3
// people killed 5 times by them at about 33. The step warns.
test("forever/alliance/30-40/04-stranglethorn-vale.guide: the Kurzen's Compound step warns of the Elites in its east", { skip }, () => {
	const list = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	const fight = list[at(list, 'kill 937', (g) => g.t === 'kill' && g.quest === 203)];
	const tip = [].concat(fight.step.note || []).join(' ');
	assert.match(tip, /Careful: Kurzen Elites and Witch Doctors \(36\)/, tip);
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.id === '2025-kurzen-compound-careful');
	assert.ok(rec, 'a record the build keeps');
});

// 0.4.0 route audit (Refs #2025, as 6558e6487 for 04b): 30-40/05 is labelled 36-38 (the levels the route plays it at),
// while its worked quests' median is 37 and its 80th percentile 40 (Faldir's Cove and the Alterac Syndicate). The
// pitch says the level 40 quests are there on purpose and how to take their fights.
test(`${ARATHI}: the pitch says why its quests run above its label`, { skip }, () => {
	const g = compiled(ARATHI);
	// Fix round 2 (0.4.0): the level model without accept-time grinding plays it at 35.9-37.4: labelled 35-37, and the
	// pitch still says why its level 40 quests are there.
	assert.match(g.pitch || '', /35 to 37.*Faldir's Cove.*group stop/, g.pitch);
	assert.equal(g.maxLevel, 37, 'the label is the levels the route plays it at');
});

test('Swamp of Sorrows (#2416, Yunra): Karana and Pelluk on the Harborage stop, the crystals are clicked', { skip }, () => {
	const list = goals(ARATHI);
	const harbor = list[at(list, 'accept 1389', is('accept', 1389))].s;
	for (const q of [93429, 93430]) {
		assert.equal(list[at(list, `accept ${q}`, is('accept', q))].s, harbor, `${q} taken with Magtoor`);
		assert.equal(list[at(list, `turnin ${q}`, is('turnin', q))].s, list[at(list, 'turnin 1389', is('turnin', 1389))].s, `${q} handed in with Magtoor`);
	}
	const crystals = list[at(list, 'collect 6071', (g) => g.t === 'collect' && g.quest === 1389)];
	assert.equal(list[at(list, 'collect 258530', (g) => g.t === 'collect' && g.quest === 93430)].s, crystals.s, 'the Lucky Lure on the Fallow Sanctuary step');
	assert.doesNotMatch(stepTips(ARATHI, /collect 6071 quest 1389/).join(' '), /mobs drop the crystals/, 'the crystals are not said to drop');
	assert.match(stepTips(ARATHI, /collect 6071 quest 1389/).join(' '), /blue crystals/);
});

test('Stranglethorn to Desolace (#2403, dloyd): players who know Stonetalon Peak fly there, warlocks to Astranaar for the Heartswood', { skip }, () => {
	const list = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	const peak = list.filter(({ goal }) => goal.t === 'fly' && /Stonetalon Peak/.test(goal.location || ''));
	assert.equal(peak.length, 1, 'one flight to Stonetalon Peak');
	assert.ok((peak[0].step.when || []).some((p) => p.k === 'taxi' && !p.neg), 'only for players who know the flight');
	const astr = list.filter(({ goal }) => goal.t === 'fly' && /Astranaar/.test(goal.location || ''));
	assert.ok(astr.some(({ step }) => (step.when || []).some((p) => p.k === 'taxi' && p.neg)), 'Astranaar for everyone else');
	assert.ok(at(list, 'collect 6912', (g) => g.t === 'collect' && g.quest === 1738) > 0, 'the Heartswood step stays');
});

test('Alliance level tidy 30-40: Lifting the Curse on 01\'s Menethil stop, Cleansing the Eye in its Stormwind', { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const take = at(list, 'accept 290', is('accept', 290));
	const box = at(list, 'turnin 290', is('turnin', 290));
	const glorin = at(list, 'turnin 292', is('turnin', 292));
	const boat = at(list, 'Boat to Southshore', (g) => g.t === 'goto' && /Boat to Southshore/.test(g.text || g.location || ''));
	assert.ok(take < box && box < glorin && glorin < boat, 'Fitzsimmons, the wreck, Glorin, then the boat');
	assert.ok(at(list, 'turnin 293', is('turnin', 293)) > boat, 'Benedictus on the Stormwind stop at the end');
});

// Fix round 1 (0.4.0 Alliance audit): the Bloodscalp ruins' core (Berserkers, Headhunters, Witch Doctors 36-37) was three
// over players on 04's Savage Coast at about 34; Zimmix, Kebok's ears and the Stolen Shipments are worked in the ruins on
// 04b's Zul'Kunda step at about 36, handed in on its Booty Bay stop. Kebok's quest and the crate are taken on 04.
test('Alliance level tidy 30-40: Anything of Value, Zimmix and Kebok\'s ears in the Bloodscalp ruins on the second loop, handed in at Booty Bay', { skip }, () => {
	const first = goals('forever/alliance/30-40/04-stranglethorn-vale.guide');
	at(first, 'accept 97328', is('accept', 97328));
	at(first, 'accept 189', is('accept', 189));
	assert.ok(!first.some(({ goal }) => [97329, 97331].includes(goal.quest) || (goal.quest === 189 && goal.t !== 'accept') || (goal.quest === 97328 && goal.t !== 'accept')), 'no ruin work on the first loop');
	const list = goals('forever/alliance/30-40/04b-stranglethorn-vale.guide');
	const ruins = list[at(list, 'collect 2007 (third tablet)', (g) => g.t === 'collect' && g.item === 2007)].s;
	for (const [what, pred] of [['accept 97329', is('accept', 97329)], ['collect 1519', (g) => g.t === 'collect' && g.item === 1519], ['collect 277953', (g) => g.t === 'collect' && g.item === 277953]]) assert.equal(list[at(list, what, pred)].s, ruins, `${what} on the Zul'Kunda step`);
	const lozgil = at(list, 'turnin 97328', is('turnin', 97328));
	assert.equal(list[lozgil].s, list[at(list, 'turnin 97331', is('turnin', 97331))].s, 'Lozgil takes both on the Booty Bay stop');
	assert.equal(list[lozgil].s, list[at(list, 'turnin 189', is('turnin', 189))].s, 'Kebok on the same stop');
});

// Fix round 1 (0.4.0 Alliance audit): three Cresting Exiles (38-39) guard the Stone of East Binding and attack together,
// two over players on 05 at about 37, with no later Arathi visit: Stones of Binding is a group choice.
test('Alliance Arathi: Stones of Binding is a group choice (the East stone\'s Cresting Exiles are 38-39)', { skip }, () => {
	for (const { step, goal } of goals(ARATHI).filter(({ goal }) => goal.quest === 651)) {
		assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(651) && !p.neg), `${goal.t} 651 is under when group 651`);
	}
});

// Fix round 1 (0.4.0 Alliance audit): the Buzzard Gizzard comes from the Starving Buzzards (35-37, 15%) north of
// Hammertoe's Digsite; the Giant Buzzards (39-41) in the far west were where players went for it, three over them.
test('Alliance Badlands: the Buzzard Gizzard points at the Starving Buzzards north of the digsite', { skip }, () => {
	const list = goals('forever/alliance/30-40/06-badlands.guide').filter(({ goal }) => goal.t === 'collect' && goal.item === 7847);
	assert.ok(list.length >= 1);
	assert.ok(Math.hypot(list[0].goal.x - 57.5, list[0].goal.y - 28.6) < 1, `first gizzard point at the Starving Buzzards (${list[0].goal.x},${list[0].goal.y})`);
	for (const { goal } of list) assert.ok(goal.x > 30, 'never the Giant Buzzards in the far west');
});

// 0.4.0 route audit (Refs #2025): 30-40/01 opened with a bare waypoint to Menethil's Deepwater Tavern, 100 yd from the
// flight master 07 lands at, with nothing to do there; the next step turned back south-east to the Angerfang
// Encampment. The guide opens on the catapult now.
test(`${HILLSBRAD_ALLIANCE}: the guide opens on the Dragonmaw catapult, no goal-less waypoint first`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	assert.ok(!list.some(({ goal }) => goal.t === 'goto' && /Deepwater Tavern/.test(goal.text || goal.location || '')), 'no waypoint to the Deepwater Tavern');
	const first = list.find(({ step }) => !step.when || !step.when.length);
	assert.ok(is('turnin', 465)(first.goal), `the first goal is the catapult (465), not ${first.goal.t}`);
});

// 0.4.0 route audit (Refs #2025): Retrieval for Mauren (1078) was taken in 06-ashenvale at about 25 and carried nine
// levels to the Saltstone Basilisks at the Mirage Raceway (30-40/03). Collin Mauren stands in the Slaughtered Lamb
// beside Archmage Malin, whom 30-40/01's Mage Quarter stop visits right before 30-40/03: the quest is taken there.
test(`${HILLSBRAD_ALLIANCE}: Retrieval for Mauren is taken on the Mage Quarter stop, with Archmage Malin`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const take = at(list, 'accept 1078', is('accept', 1078));
	assert.equal(list[take].s, list[at(list, 'accept 690', is('accept', 690))].s, 'on the stop with Archmage Malin');
	assert.ok(goals(ASHENVALE_30).some(({ goal }) => goal.t === 'collect' && goal.quest === 1078), 'the scales at the Raceway in 30-40/03');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.faction === 'Alliance' && `${p.a}` === 'accept,690' && `${p.b}` === 'accept,1078'), 'a record the build keeps');
});

// 0.4.0 route audit (Refs #2025, danger at the spot #1575): Desolace's Valley of Bones step (Undead Ravagers, the Ghost
// Magnets): Magram Necrokhans and Corpsefeeders (45, elite) of Shen'dralas walk the bone fields with Magram Necromancers
// (42); players' recordings show 5 deaths around the old Ghost Magnets point. The Ravagers' arrow leads to the fields'
// clear western edge, the crate's to the spot players used it in the east, and the step warns of the elites between.
test(`${DESOLACE_SOUTH}: the Valley of Bones points away from the Shen'dralas elites and warns of them`, { skip }, () => {
	const list = goals(DESOLACE_SOUTH);
	const fight = list[at(list, 'kill 11561', (g) => g.t === 'kill' && g.quest === 261)];
	assert.ok(fight.goal.map === 1443 && Math.hypot(fight.goal.x - 61.1, fight.goal.y - 90.9) < 1, `the Ravagers: the fields' western edge (got ${fight.goal.map} ${fight.goal.x},${fight.goal.y})`);
	// Level tidy (0.4.0): Ghost-o-plasm Round Up is a group choice (route-fixes deliberate.group 6134, #2357's record); its
	// magnets still point at the fields' eastern side for the group.
	for (const [what, pred] of [['crate', (g) => g.t === 'use' && g.quest === 6134], ['ghost-o-plasm', (g) => g.t === 'collect' && g.quest === 6134]]) {
		const { goal, step } = list[at(list, what, pred)];
		assert.ok(goal.map === 1443 && Math.hypot(goal.x - 64.4, goal.y - 91.7) < 1, `${what}: the fields' eastern side (got ${goal.map} ${goal.x},${goal.y})`);
		assert.ok(whenOn(step, 'group', 6134), `${what}: only on the group choice`);
	}
	assert.match([].concat(fight.step.note || []).join(' '), /Careful: Magram Necrokhans and Corpsefeeders \(45, elite\) walk the bone fields/);
	assert.ok(JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.some((f) => f.id === '2025-valley-of-bones-careful'), 'the tip, a record the build keeps');
	const places = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8')).places;
	for (const id of ['1575-desolace-alliance-undead-ravagers-west', '1575-desolace-alliance-ghost-magnets-east']) assert.ok(places.some((p) => p.id === id), `${id}: a record the build keeps`);
});

// chiboman (#2253, 0.3.7.2, Human Paladin 38): "Galen's Escape" pulls the Fallow Sanctuary's Lost One Riftseekers (37-38)
// and their pets onto Galen; too hard alone at 38, and the step gave no warning. Players' recordings: 20 people, 11 of 19
// finished on the first try, 8 failed the first escort at 36-39 and 5 of those finished on a retry. The step warns, says
// how to keep the attackers on the player, and that a failed escort is taken again at the cage.
test(`${ARATHI}: Galen's Escape warns of the Lost Ones the escort pulls onto Galen (#2253)`, { skip }, () => {
	const list = goals(ARATHI);
	const { step } = list[at(list, 'accept 1393', is('accept', 1393))];
	const tips = [].concat(step.note || []).join(' ');
	assert.match(tips, /Careful: on the walk out the camp's Lost One Riftseekers \(37-38\) and their pets/);
	assert.match(tips, /take it again at his cage/);
	assert.ok(JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.some((f) => f.id === '2253-galens-escape-careful'), 'a record the build keeps');
});
